(****************************************************)
unit PlugProt;

interface

uses
  HttpApp, Windows, SysUtils, Classes, Graphics, Forms, ComObj, VCLCom, StdVcl,
    ActiveX, ShellConsts, ThreadComLib, ComEvents, UrlMonEx, CDBookPP_TLB;

// we using temporary name space registration ....

{** $DEFINE PERMANENT_PROTOCOL}
{$DEFINE TEMP_NAMESPACE_PROTOCOL}

const
  PROTOCOL_SCHEME = 'cdbook';
  PROTOCOL_DESC   = 'cdbook: Pluggable Protocol';

type
  TPluggableProtocol = class; // forwarded

  TURIHandler = class(TInterfacedObject)
  private
    FProtocol  : TPluggableProtocol;
    FFullURI   : String;
    FContainer : String;
    FOption    : String;
    FOptValue  : String;
    FMimeType  : String;
    FdwOptVal: Integer;
  protected
    procedure LoadResStream(var Stream: IStream; var dwWritten: Integer); virtual;
    procedure LoadDocStream(var Stream: IStream; var dwWritten: Integer); virtual;
    procedure LoadRawStream(var Stream: IStream; var dwWritten: Integer); virtual;
  public
    constructor Create(Protocol: TPluggableProtocol);
    procedure GetContents(var Stream: IStream; var dwWritten: Integer);  virtual;
    procedure ParseURI(const URI: String);  virtual;
  end;

  TPluggableProtocol = class(
     TAutoObjectWithEvents,
     ICDBookProtocol,
     IInternetProtocol,
     IInternetProtocolInfo)
  private
    { Private-Deklarationen }
    FEvents         : _CDBookEvents;          // Application event sink
    FURIHandler     : TURIHandler;            // interface object to URI handling   
    FIProtSink      : IInternetProtocolSink;  // PP implementation follows
    FIBindInfo      : IInternetBindInfo;
    FSinkCount      : Integer;
    FBindCount      : Integer;
    FStrmCount      : Integer;
    FBindType       : Integer;
    FBindInfo       : TBindInfo;
    FGrfSTI         : Integer;
    FLocked         : Boolean;
    FDone           : Boolean;
    FReallyDone     : Boolean;
    FcbTotalURLMon  : Integer;
    FcbTotalRead    : Integer;
    FcbTotalWritten : Integer;
    FcbTotalSize    : Integer;
    FProtocolStream : IStream;
    { IInternetProtocol }
    function Start(szUrl: PWideChar; OIProtSink: IInternetProtocolSink;
      OIBindInfo: IInternetBindInfo; grfPI, dwReserved: Integer): HResult; stdcall;
    function Continue(const ProtocolData: TProtocolData): HResult; stdcall;
    function Abort(hrReason: HResult; dwOptions: Integer): HResult; stdcall;
    function Terminate(dwOptions: Integer): HResult; stdcall;
    function Suspend: HResult; stdcall;
    function Resume: HResult; stdcall;
    function Read(pv: Pointer; cb: ULONG; out cbRead: ULONG): HResult; stdcall;
    function Seek(dlibMove: LARGE_INTEGER; dwOrigin: Integer;
      out libNewPosition: ULARGE_INTEGER): HResult; stdcall;
    function LockRequest (dwOptions: Integer): HResult; stdcall;
    function UnlockRequest: HResult; stdcall;
    { IInternetProtocolInfo }
    function ParseUrl(pwzUrl: PWideChar; ParseAction: LongWord; dwParseFlags: Integer;
      pwzResult: PWideChar; cchResult: Integer; out pcchResult: Integer; dwReserved: Integer): HResult; stdcall;
    function CombineUrl(pwzBaseUrl, pwzRelativeUrl: PWideChar; dwCombineFlags: Integer;
      pwzResult: PWideChar; cchResult: Integer; out pcchResult: Integer; dwReserved: Integer): HResult; stdcall;
    function CompareUrl(pwzUrl1, pwzUrl2: PWideChar; dwCompareFlags: Integer): HResult; stdcall;
    function QueryInfo(pwzUrl: PWideChar; QueryOption: TQueryOption; dwQueryFlags: Integer;
      pBuffer: Pointer; cbBuffer: Integer; var cbBuf: Integer; dwReserved: Integer): HResult; stdcall;
  protected
    procedure EventSinkChanged(const Events: IUnknown); override;
    function DoBindProtocol: HResult; virtual;
    function DoParseURLStr(const URL: String): HResult; virtual;
  protected
    property ProtocolStream : IStream read FProtocolStream;
  public
    { Public-Deklarationen }
    procedure Initialize; override;
    destructor Destroy; override;
  end;

implementation

uses
  AxCtrls, WinInet, ThreadComServ, dmDataClient;

const
  SHtmlNoDataAvial =
    '<font color=red><br><b>Data not available.</b></font>';

type
  TServerModule = class (TThreadedComServer)
  private
    FProtocolFactory: IClassFactory;
    FInternetSession: IInternetSession;
  protected
    procedure InitializeApartments; override;
    function DllRegisterServer : HResult; override;
    function DllUnregisterServer : HResult; override;
  public
    procedure Initialize; override;
    procedure Finalize; override;
  end;

var
  ProtocolCB: TPluggableProtocol;
  DataClient: TDataClient;

{=====================================================================================}
{The aparment COM server}

procedure TServerModule.InitializeApartments;
  {InitializeApartments apartments gets called right before a COM server
   starts going into its primary thread loop. This enables you to pre-initialize
   any apartments that you may always want created whenever your COM server
   starts up. InitializeApartments is only called for EXE servers.}
begin
  {must be override}
end;

function TServerModule.DllRegisterServer: HResult;
{$IFDEF PERMANENT_PROTOCOL}
var
  CLSID: String;
{$ENDIF PERMANENT_PROTOCOL}
begin
  Result:= inherited DllRegisterServer;
{$IFDEF PERMANENT_PROTOCOL}
  if SUCCEEDED(Result) then
  begin
    CLSID:= GUIDToString(Class_CDBookProtocol);
    CreateRegKey(SKeyAsyncPPHandler+'\'+PROTOCOL_SCHEME, '', PROTOCOL_DESC);
    CreateRegKey(SKeyAsyncPPHandler+'\'+PROTOCOL_SCHEME, 'CLSID', CLSID);
    CreateRegKey(PROTOCOL_SCHEME, '', PROTOCOL_DESC);
    CreateRegKey(PROTOCOL_SCHEME, 'URL Protocol', '');
    CreateRegKey(PROTOCOL_SCHEME+'\'+SKeyDefaultIcon, '', ComServer.ServerFileName+',0');
  end;
{$ENDIF PERMANENT_PROTOCOL}
end;

function TServerModule.DllUnregisterServer: HResult;
begin
{$IFDEF PERMANENT_PROTOCOL}
  DeleteRegKey(PROTOCOL_SCHEME);
  DeleteRegKey(SKeyAsyncPPHandler+'\'+PROTOCOL_SCHEME);
{$ENDIF PERMANENT_PROTOCOL}
  Result:= inherited DllUnregisterServer;
end;

procedure TServerModule.Initialize;
  {Initialize is called before anything happens for your COM server. Override
   Initialize if you want to initialize any resources that your server will need.}
begin
  inherited;
  {--}
  Application.Title:= 'CD Book Plugable Protocol';
  { Do your initialize apartments here }
  try
    DataClient:= TDataClient.Create(Application);
{$IFDEF TEMP_NAMESPACE_PROTOCOL}
    { protocol class }
    OleCheck( CoGetClassObject(
      Class_CDBookProtocol, CLSCTX_SERVER, nil, IClassFactory, FProtocolFactory));
    FProtocolFactory._AddRef;
    // ---
    OleCheck(CoInternetGetSession(0, FInternetSession, 0));
    // ---
    FInternetSession._AddRef;
    OleCheck( FInternetSession.RegisterNameSpace(
      FProtocolFactory, Class_CDBookProtocol, PROTOCOL_SCHEME, 0, nil, 0));
{$ENDIF TEMP_NAMESPACE_PROTOCOL}
  except
    Application.HandleException(ExceptObject);
  end;
end;

procedure TServerModule.Finalize;
begin
  // ---
  if ( FInternetSession <> nil ) then
  begin
    FInternetSession.UnregisterNameSpace(FProtocolFactory, PROTOCOL_SCHEME);
    FInternetSession._Release;
    FInternetSession:= NIL;
  end;
  // ---
  if ( FProtocolFactory <> nil) then
  begin
    FProtocolFactory._Release;
    FProtocolFactory:= NIL;
  end;
  // ---
  if DataClient <> NIL then
    DataClient.Free;
  // ---
  inherited;
end;

{=====================================================================================}
{TURIHandler methods}

constructor TURIHandler.Create(Protocol: TPluggableProtocol);
begin
  inherited Create;
  // ---
  FProtocol:= Protocol;
end;

procedure TURIHandler.ParseURI(const URI: String);
  {- we using this url syntax:
       cdbook://container/option=value
        options = bmp, gif, jpg  for IMG or CSS url(...)
                  raw for application callback
                  other are standard HTML generated TPageProducer
        container = is an access code for database data or resource identifier
  -}
begin
  FFullURI:= URI;
  {extract HTML container object}
  if Pos('?', FFullURI) <> 0 then
    FContainer:= Copy(FFullURI, 1, Pos('?', FFullURI)-1)
  else if Pos('/', FFullURI) <> 0 then
    FContainer:= Copy(FFullURI, 1, Pos('/', FFullURI)-1)
  else
    FContainer:= 'raw';
  FOption:= Copy(FFullURI, Length(FContainer)+2, (Pos('=', FFullURI)-1)-(Length(FContainer)+1));
  FOptValue:= Copy(FFullURI, Pos('=', FFullURI)+1, Length(FFullURI));
  FdwOptVal:= StrToIntDef(FOptValue, -1);
  // translate container/resource id to mime type
  if CompareText(FContainer, 'res') = 0 then
  begin
    {if no resource id, remove file extension}
    if FdwOptVal < 0 then begin
      FOptValue:= ChangeFileExt(FOptValue, '');
    end;
    if CompareText(FOption,  'bmp') = 0 then
      FMimeType:= CFSTR_MIME_BMP
    else if CompareText(FOption,  'jpg') = 0 then
      FMimeType:= CFSTR_MIME_JPEG
    else if CompareText(FOption,  'gif') = 0 then
      FMimeType:= CFSTR_MIME_GIF
  end
  else if CompareText(FContainer, 'raw') = 0 then
    FMimeType:= CFSTR_MIME_RAWDATA
  else
    FMimeType:= CFSTR_MIME_HTML;
end;

procedure TURIHandler.LoadResStream(var Stream: IStream; var dwWritten: Integer);
var
  cbWritten: Longint;
  MemStream: TMemoryStream;
  ResStream: TResourceStream;
  ResType  : PChar;
begin
  MemStream:= TMemoryStream.Create;
  try
    {determine which resource type to use}
    if CompareText(FMimeType, CFSTR_MIME_BMP) = 0 then
      ResType:= RT_BITMAP
    else if (CompareText(FMimeType, CFSTR_MIME_JPEG) = 0) or
            (CompareText(FMimeType, CFSTR_MIME_GIF) = 0) then
      ResType:= RT_RCDATA
    else
      ResType:= RT_RCDATA;
    {create resource stream}
    ResStream:= TResourceStream.Create(hInstance, FOptValue, ResType);
    try
      {write to memory stream}
      ResStream.SaveToStream(MemStream);
      {goto start of stream}
      MemStream.Seek(0, soFromBeginning);
      {---}
      dwWritten:= 0;
      cbWritten:= 0;
      {write to IStream interface}
      Stream.Write(MemStream.Memory, MemStream.Size, @cbWritten);
      {...}
      dwWritten:= cbWritten;
    finally
      ResStream.Free;
    end;
  finally
    MemStream.Free;
  end;
end;

procedure TURIHandler.LoadDocStream(var Stream: IStream; var dwWritten: Integer);
var
  cbWritten : Longint;
  MemStream : TMemoryStream;
  Strings   : TStringList;
begin
  MemStream:= TMemoryStream.Create;
  try
    Strings:= TStringList.Create;
    try
      with DataClient do
      begin
        // load rquested book page
        LoadBookPage(FContainer, FOption, FOptValue, Strings);
        {if no html, show default error page}
        if Strings.Count = 0 then begin
          Strings.Text:= '<html><body>'+SHtmlNoDataAvial+'</body></html>';
        end;
        {update content page producer}
        SetPageContents(Strings);
        {generate final HTML page}
        GetFinalHTMLDoc(Strings);
      end;
      {write to memory stream}
      Strings.SaveToStream(MemStream);
      {goto start of stream}
      MemStream.Seek(0, soFromBeginning);
      {---}
      dwWritten:= 0;
      cbWritten:= 0;
      {write to IStream interface}
      Stream.Write(MemStream.Memory, MemStream.Size, @cbWritten);
      {...}
      dwWritten:= cbWritten;
    finally
      Strings.Free;
    end;
  finally
    MemStream.Free;
  end;
end;

procedure TURIHandler.LoadRawStream(var Stream: IStream; var dwWritten: Integer);
var
  Strings   : IStrings;
  DocStrs   : TStringList;
  cbWritten : Longint;
  MemStream : TMemoryStream;
begin
  {check we have callback event}
  if FProtocol.FEvents = NIL then
  begin
    dwWritten:= 0;
    Exit;
  end;
  {call the application event to get data}
  FProtocol.FEvents.OnPageRequest(FdwOptVal, Strings);
  if Strings = NIL then
  begin
    dwWritten:= 0;
    Exit;
  end;
  DocStrs:= TStringList.Create;
  try
    SetOleStrings(DocStrs, Strings);
    if DocStrs.Count = 0 then
    begin
      dwWritten:= 0;
      Exit;
    end;
    MemStream:= TMemoryStream.Create;
    try
      {write to memory stream}
      DocStrs.SaveToStream(MemStream);
      {goto start of stream}
      MemStream.Seek(0, soFromBeginning);
      {---}
      dwWritten:= 0;
      cbWritten:= 0;
      {write to IStream interface}
      Stream.Write(MemStream.Memory, MemStream.Size, @cbWritten);
      {...}
      dwWritten:= cbWritten;
    finally
      MemStream.Free;
    end;
  finally
    DocStrs.Free;
  end;
end;

procedure TURIHandler.GetContents(var Stream: IStream; var dwWritten: Integer);
begin
  {internal resource (i.e. images or RC data}
  if CompareText(FContainer, 'res') = 0 then
  begin
    LoadResStream(Stream, dwWritten);
    Exit;
  end;
  {raw stream handler, manager by application}
  if CompareText(FContainer, 'raw') = 0 then
  begin
    LoadRawStream(Stream, dwWritten);
    Exit;
  end;
  {default handler}
  LoadDocStream(Stream, dwWritten);
end;

{=====================================================================================}
{Protected methods}

procedure TPluggableProtocol.Initialize;
begin
  inherited Initialize;
  {connect data provider}
  DataClient.OpenDataProvider;
end;

destructor TPluggableProtocol.Destroy;
begin
  {disconnect data provider}
  DataClient.CloseDataProvider;
  {---}
  inherited Destroy;
end;

procedure TPluggableProtocol.EventSinkChanged( const Events: IUnknown );
begin
  FEvents:= Events as _CDBookEvents;
  if ProtocolCB = Nil then
    ProtocolCB:= Self
  else if FEvents = NIL then
    ProtocolCB:= Nil;
end;

function TPluggableProtocol.DoParseURLStr(const URL: String): HResult;

  function InetCanonicalUrl(var URL: string; Flags: integer): Boolean;
  var
    dwUrlSize  : Integer;
    szCanonUrl : array[0..INTERNET_MAX_PATH_LENGTH] of char;
  begin
    Result:= False;
    dwUrlSize:= INTERNET_MAX_PATH_LENGTH;
    if InternetCanonicalizeUrl(PChar(URL), szCanonUrl, dwUrlSize, Flags) then
    begin
      URL:= Copy(szCanonUrl, 1, dwUrlSize);
      Result:= True;
    end;
  end;

var
  stURLString: string;
begin
  try
    Result:= S_OK;
    stURLString:= URL;
    if not InetCanonicalUrl(stURLString, ICU_DECODE or ICU_NO_ENCODE) then
      Result:= E_FAIL
    else
    begin
      {remove protocol schema and : }
      Delete(stURLString, 1, Length(PROTOCOL_SCHEME)+1);

      {remove double slashes if exists}
      if ( Copy(stURLString, 1, 2) = '//' ) then
        Delete(stURLString, 1, 2);

      {check valid url}
      if stURLString = '' then
      begin
        Result:= E_INVALIDARG;
        Exit;
      end;

      {remove last slash}
      if stURLString[Length(stURLString)] = '/' then
        SetLength(stURLString, Pred(Length(stURLString)));

      {prevent memory leaks}
      if Assigned(FURIHandler) then
        FURIHandler.Free;
      {create new URI object}
      FURIHandler:= TURIHandler.Create(Self);
      FURIHandler.ParseURI(stURLString);
    end;
  except
    Result:= E_FAIL;
  end;
end;

function TPluggableProtocol.DoBindProtocol: HResult;
const
  BSCF_FLAGS = BSCF_LASTDATANOTIFICATION or BSCF_DATAFULLYAVAILABLE;
var
  iStmPos : Int64;
  wcStatus: array[0..20] of WideChar;
begin
  try
    {create ole stream on global memory}
    Result:= CreateStreamOnHGlobal(0, True, FProtocolStream);
    if SUCCEEDED(Result) then
    begin
      FStrmCount:= FProtocolStream._AddRef;
      FcbTotalRead:= 0;
      {Get document contents to protocol IStream interface}
      FURIHandler.GetContents(FProtocolStream, FcbTotalRead);
      {check we any data avial...}
      if FcbTotalRead = 0 then
      begin
        Abort(0, 0);
        Result:= S_OK;
        Exit;
      end;
      {set flag}
      FDone:= True;
      {go to start of HTML document}
      FProtocolStream.Seek(0, soFromBeginning, iStmPos);
      {set content mime type}
      StringToWideChar(FURIHandler.FMimeType, wcStatus, Length(FURIHandler.FMimeType)+1);
      {notify protocol sink the content mime type}
      FIProtSink.ReportProgress(BINDSTATUS_VERIFIEDMIMETYPEAVAILABLE, wcStatus);
      {notify protocol sink, it's data ready to download}
      fIProtSink.ReportData(BSCF_FLAGS, FcbTotalRead, FcbTotalRead);
      {notify prtocol sink, status success}
      fIProtSink.ReportResult(S_OK, S_OK, nil);
      {...}
      Result:= S_OK;
    end;
  except
    Result:= E_FAIL;
  end;
end;

{ IInternetProtocol }

function TPluggableProtocol.Start(
              szUrl       : PWideChar;
              OIProtSink  : IInternetProtocolSink;
              OIBindInfo  : IInternetBindInfo;
              grfPI,
              dwReserved  : Integer): HResult;
var
  ProtocolData: TProtocolData;
begin
  try
    // Initialize variables
    // for new download
    FGrfSTI        := grfPI;
    FcbTotalRead   := 0;
    FcbTotalWritten:= 0;
    FcbTotalSize   := 0;
    FcbTotalURLMON := 0;
    FDone          := False;
    FLocked        := False;

    // save internet protocol sink of URLMON.DLL
    FIProtSink:= OIProtSink;
    FSinkCount:= fIProtSink._AddRef;

    // save bind info instance of URLMON.DLL
    FIBindInfo:= OIBindInfo;
    FBindCount:= FIBindInfo._AddRef;

    FBindInfo.cbSize:= sizeof(FBindInfo);
    FIBindInfo.GetBindInfo(FBindType, FBindInfo);

    Result:= DoParseURLStr(szUrl);
    if (fGrfSTI and PI_PARSE_URL) <> 0 then
    begin
      if SUCCEEDED(Result) then
           Result:= S_OK
      else Result:= S_FALSE;
    end;

    if (FBindType and BINDF_NEEDFILE) <> 0 then
    begin
    end;

    if SUCCEEDED(Result) then
    begin
      { We successfully parsed the url, continue }
      if (fGrfSTI and PI_FORCE_ASYNC) <> 0 then
        Result := DoBindProtocol
      else
      begin
        Result:= E_PENDING;
        //
        ProtocolData.grfFlags:= PI_FORCE_ASYNC;
        ProtocolData.dwState := 1;
        ProtocolData.pData   := nil;
        ProtocolData.cbData  := 0;
        //
        if FIProtSink <> nil then
             FIProtSink.Switch(ProtocolData)
        else Result:= E_INVALIDARG;
      end;
    end;
  except
    Result:= E_FAIL;
  end;
end;

function TPluggableProtocol.Continue(const ProtocolData: TProtocolData): HResult;
begin
  try
    Result:= E_FAIL;
    if ( ProtocolData.dwState = 1 ) then
      Result := DoBindProtocol;
  except
    Result:= E_FAIL;
  end;
end;

function TPluggableProtocol.Abort(hrReason: HResult; dwOptions: Integer): HResult;
begin
  try
    // Possibly Abort could get called with 0?
    if (SUCCEEDED(hrReason)) then
      hrReason:= E_ABORT;

    // Notify Sink of abort
    if FIProtSink <> nil then
      FIProtSink.ReportResult(hrReason, 0, nil);

    Result:= S_OK;
  except
    Result:= E_FAIL;
  end;
end;

function TPluggableProtocol.Terminate(dwOptions: Integer): HResult;
  {-Called by UrlMon.dll when we call pOIProtSink.ReportResult. All resources
    should be freed when this method is complete.}
begin
  try
    Result:= S_OK;

    if FProtocolStream <> nil then
    begin
      FStrmCount:= FProtocolStream._Release;
      FProtocolStream := nil;
    end;

    if FIProtSink <> nil then
    begin
      FSinkCount:= FIProtSink._Release;
      FIProtSink:= nil;
    end;

    if FIBindInfo <> nil then
    begin
      FBindCount:= FIBindInfo._Release;
      FIBindInfo:= nil;
    end;

    ReleaseBindInfo(FBindInfo);
  except
    Result:= E_FAIL;
  end;
end;

function TPluggableProtocol.Suspend: HResult;
begin
  try
    { Not currently Implemented }
    Result:= E_NOTIMPL;
  except
    Result:= E_FAIL;
  end;
end;

function TPluggableProtocol.Resume: HResult;
begin
  try
    { Not currently Implemented }
    Result:= E_NOTIMPL;
  except
    Result:= E_FAIL;
  end;
end;

function TPluggableProtocol.Read(pv: Pointer; cb: ULONG; out cbRead: ULONG): HResult;
begin
  try
    Result:= S_OK;
    if not FReallyDone then
    begin
      Result:= FProtocolStream.Read(pv, cb, @cbRead);
      if not SUCCEEDED(Result) then
        Exit;
    end;
    Inc(FcbTotalURLMon, cbRead);
    if SUCCEEDED(Result) and (FcbTotalURLMon = fcbTotalRead ) then
    begin
      if not fDone then
        Result:= E_PENDING
      else
      begin
        fReallyDone:= True;
        Result:= S_FALSE;
      end;
    end;
  except
    Result:= E_FAIL;
  end;
end;

function TPluggableProtocol.Seek(dlibMove: LARGE_INTEGER;
  dwOrigin: Integer; out libNewPosition: ULARGE_INTEGER): HResult;
begin
  try
    Result:= E_NOTIMPL;
  except
    Result:= E_FAIL;
  end;
end;

function TPluggableProtocol.LockRequest (dwOptions: Integer): HResult;
begin
  try
    FLocked:= True;
    Result := S_OK;
  except
    Result:= E_FAIL;
  end;
end;

function TPluggableProtocol.UnlockRequest: HResult;
begin
  try
    FLocked:= False;
    Result := S_OK;
  except
    Result:= E_FAIL;
  end;
end;

{ IInternetProtocolInfo }

function TPluggableProtocol.ParseUrl(
              pwzUrl        : PWideChar;
              ParseAction   : LongWord;
              dwParseFlags  : Integer;
              pwzResult     : PWideChar;
              cchResult     : Integer;
          out pcchResult    : Integer;
              dwReserved    : Integer): HResult;
var
  stTemp : string;
begin
  try
    stTemp:= '';
    Result:= E_NOTIMPL; file://INET_E_DEFAULT_ACTION;
    if DoParseUrlStr(WideCharToString(pwzURL)) = S_OK then
    begin
      case ParseAction of
        PARSE_CANONICALIZE    : stTemp:= PROTOCOL_SCHEME+':'+FURIHandler.FFullURI;
        PARSE_FRIENDLY        : stTemp:= 'Hier klicken...';
        PARSE_SECURITY_URL    : stTemp:= PROTOCOL_SCHEME+':'+FURIHandler.FFullURI;
        PARSE_ROOTDOCUMENT    : stTemp:= FURIHandler.FOptValue;
        PARSE_DOCUMENT        : stTemp:= FURIHandler.FOptValue;
        PARSE_ANCHOR          : stTemp:= '';
        PARSE_ENCODE          : stTemp:= PROTOCOL_SCHEME+':'+FURIHandler.FFullURI;
        PARSE_DECODE          : stTemp:= '';
        PARSE_PATH_FROM_URL   : stTemp:= '';
        PARSE_URL_FROM_PATH   : stTemp:= '';
        PARSE_MIME            : stTemp:= FURIHandler.FMimeType;
        PARSE_SERVER          : stTemp:= '';
        PARSE_SCHEMA          : stTemp:= '';
        PARSE_SITE            : stTemp:= '';
        PARSE_DOMAIN          : stTemp:= '';
        PARSE_LOCATION        : stTemp:= '';
        PARSE_SECURITY_DOMAIN : stTemp:= '';
        PARSE_ESCAPE          : stTemp:= '';
        PARSE_UNESCAPE        : stTemp:= '';
      end; file://case
    end;
    {--}
    if stTemp <> '' then
    begin
      pcchResult := Length(stTemp)*2;
      if cchResult < pcchResult then
        Result := S_FALSE
      else
      begin
        StringToWideChar(stTemp, pwzResult, pcchResult);
        Result:= S_OK;
      end;
    end;
  except
    Result:= E_FAIL;
  end;
end;

function TPluggableProtocol.CombineUrl(
              pwzBaseUrl,
              pwzRelativeUrl: PWideChar;
              dwCombineFlags: Integer;
              pwzResult     : PWideChar;
              cchResult     : Integer;
          out pcchResult    : Integer;
              dwReserved    : Integer): HResult;
var
  S1, S2: String;
begin
  try
    if pwzRelativeUrl = NIL then
      Result:= E_INVALIDARG
    else
    begin
      Result:= E_NOTIMPL; file://INET_E_DEFAULT_ACTION;
      S1:= WideCharToString(pwzBaseUrl);
      S2:= WideCharToString(pwzRelativeUrl);
      if (Length(S2) > 0) and (CompareText(S1, S2) <> 0) then
      begin
        pcchResult:= Length(S2) * 2;
        if cchResult < cchResult then
          Result:= S_FALSE
        else
        begin
          StringToWideChar(S2, pwzResult, cchResult);
          Result:= S_OK;
        end;
      end;
    end;
  except
    Result:= E_FAIL;
  end;
end;

function TPluggableProtocol.CompareUrl(pwzUrl1, pwzUrl2: PWideChar; dwCompareFlags: Integer): HResult;
var
  S1, S2: String;
begin
  try
    S1:= WideCharToString(pwzUrl1);
    S2:= WideCharToString(pwzUrl2);
    if CompareText(S1, S2) = 0 then
         Result:= S_OK
    else Result:= S_FALSE;
  except
    Result:= E_FAIL;
  end;
end;

function TPluggableProtocol.QueryInfo(pwzUrl: PWideChar; QueryOption: TQueryOption; dwQueryFlags: Integer;
   pBuffer: Pointer; cbBuffer: Integer; var cbBuf: Integer; dwReserved: Integer): HResult;
var
  stTemp : string;
begin
  try
    stTemp:= '';
    Result:= INET_E_DEFAULT_ACTION;
    cbBuf := cbBuffer;
    {--}
    case QueryOption of
      QUERY_EXPIRATION_DATE     : stTemp:= DateTimeToStr(Now);
      QUERY_TIME_OF_LAST_CHANGE : stTemp:= '';
      QUERY_CONTENT_ENCODING    : stTemp:= '';
      QUERY_CONTENT_TYPE        : stTemp:= FURIHandler.FMimeType;
      QUERY_REFRESH             : stTemp:= '';
      QUERY_RECOMBINE           : stTemp:= '';
      QUERY_CAN_NAVIGATE        : LongBool(pBuffer^):= TRUE;
      QUERY_USES_NETWORK        : LongBool(pBuffer^):= FALSE;
      QUERY_IS_CACHED           : stTemp:= '';
      QUERY_IS_INSTALLEDENTRY   : stTemp:= '';
      QUERY_IS_CACHED_OR_MAPPED : stTemp:= '';
      QUERY_USES_CACHE          : stTemp:= '';
      QUERY_IS_SECURE           : LongBool(pBuffer^):= TRUE;
      QUERY_IS_SAFE             : LongBool(pBuffer^):= TRUE;
    end; file://case
    {--}
    if stTemp <> '' then
    begin
      cbBuf := Length(stTemp)*2;
      if cbBuffer < cbBuf then
        Result := S_FALSE
      else
      begin
        StringToWideChar(stTemp, pBuffer, cbBuf);
        Result := S_OK;
      end;
    end;
  except
    Result:= E_FAIL;
  end;
end;

initialization
  { ComServer Module }
  ComServer:= TServerModule.Create('CDBOOKPP');
  { register protocol class }
  TAutoObjectWithEventsFactory.Create(ComServer, TPluggableProtocol, Class_CDBookProtocol);

end.