//**************************************************************
//                                                             *
//                IEDownload ver 2005 (oct 27, 2005)           *                                                      *
//                 For Delphi 5, 6, 7, 2005, 2006              *
//                     Freeware Component                      *
//                            by                               *
//                     Per Lindsø Larsen                       *
//                   per.lindsoe@larsen.dk                     *
//                                                             *
//  Contributions:                                             *
//  Eran Bodankin (bsalsa) bsalsa@bsalsa.no-ip.info            *
//         -  D2005 update                                     *
//                                                             *
//  Updated versions:                                          *
//  http://www.euromind.com/iedelphi                           *
//  http://groups.yahoo.com/group/delphi-webbrowser/           *
//**************************************************************

unit IEDownload;

interface

uses
 ActiveX, Registry, Contnrs, Extctrls, wininet, Windows, UrlMon, SysUtils, Classes;

const
  CP_THREAD_ACP = 3;
  CP_SYMBOL = 42;

  BINDINFOF_URLENCODESTGMEDDATA = $1;
  BINDINFOF_URLENCODEDEXTRAINFO = $2;

  HTTP_QUERY_FLAG_REQUEST_HEADERS = $80000000;
  HTTP_QUERY_FLAG_SYSTEMTIME = $40000000;
  HTTP_QUERY_FLAG_NUMBER = $20000000;
  HTTP_QUERY_FLAG_COALESCE = $10000000;
  HTTP_QUERY_MODIFIER_FLAGS_MASK = (HTTP_QUERY_FLAG_REQUEST_HEADERS
    or HTTP_QUERY_FLAG_SYSTEMTIME
    or HTTP_QUERY_FLAG_NUMBER
    or HTTP_QUERY_FLAG_COALESCE
    );

  RESUME_RESPONSE_RESUME = 0;
  RESUME_RESPONSE_OVERWRITE = 1;
  RESUME_RESPONSE_CANCEL = 2;


type

  TInfo = record
    Sender: TObject;
    Url: PwideChar;
    TimeOut: Integer;
    FileName: string;
    PostData: string;
    PutFileName: string;
    AdditionalHeader: TStrings;
    PassWord: string;
    Username: string;
    CustomVerb: string;
    ExtraInfo: string;
    Descriptor: string;
    UserAgent: string;
    RangeBegin: Integer;
    RangeEnd: Integer;
    InheritHandle: Boolean;
    BindVerbValue: Cardinal;
    BindInfoValue: Cardinal;
    UrlEncodeValue: Cardinal;
    CodePageValue: Cardinal;
  end;



{ Forward declaration }
  TIEDownload = class;

  TBSCB = class(TObject,
      IUnknown,
      IBindStatusCallback,
      IHttpNegotiate,
      IAuthenticate,
      IHTTPSecurity)
  private
    { Private declarations }
    Info: TInfo;
    OutputFile: TFileStream;
    FBSCBTimer: TTimer;
    FstartTime: TDatetime;
    FTimedOut: Boolean;
    FCancel: Boolean;
    FBindCtx: IBindCtx;
    FStream: IStream;
    FMoniker: IMoniker;
    FSender: TIEDownload;
    FRedirect: Boolean;
    FGlobalData: HGLOBAL;
    FDataSize: Integer;
    FTotalRead: Cardinal;
    FDataAvailable: Integer;
    { Public declarations }
{IBindStatusCallBack methods}
    function OnLowResource(reserved: DWORD): HResult; stdcall;
    function OnProgress(ulProgress, ulProgressMax, ulStatusCode: ULONG;
      szStatusText: LPCWSTR): HResult; stdcall;
    function OnStartBinding(dwReserved: DWORD; pib: IBinding): HResult; stdcall;
    function OnStopBinding(hresult: HResult; szError: LPCWSTR): HResult; stdcall;
    function OnDataAvailable(grfBSCF: DWORD; dwSize: DWORD; formatetc: PFormatEtc;
      stgmed: PStgMedium): HResult; stdcall;
    function OnObjectAvailable(const iid: TGUID; punk: IUnknown): HResult; stdcall;
    function GetPriority(out nPriority): HResult; stdcall;
    function GetBindInfo(out grfBINDF: DWORD; var bindinfo: TBindInfo): HResult; stdcall;
{IHTTPNegotiate methods}
    function OnResponse(dwResponseCode: DWORD; szResponseHeaders, szRequestHeaders: LPCWSTR;
      out szAdditionalRequestHeaders: LPWSTR): HResult; stdcall;
    function BeginningTransaction(szURL, szHeaders: LPCWSTR; dwReserved: DWORD;
      out szAdditionalHeaders: LPWSTR): HResult; stdcall;
{IAuthenticate methods}
    function Authenticate(var hwnd: HWnd; var szUserName, szPassWord: LPWSTR): HResult; stdcall;
{IWindowForbindingUI methods}
    function GetWindow(const guidReason: TGUID; out hwnd): HResult; stdcall;
{IHttpSecurity methods}
    function OnSecurityProblem(dwProblem: DWORD): HResult; stdcall;


    constructor Create(DownloadInfo: TInfo);
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    function Download: HRESULT;
    procedure ClearAll;
    procedure TimerExpired(Sender: TObject);
  public
    Url: Pwidechar;
    Stream: TStream;
    Binding: IBinding;
    ResponseCode: Cardinal;
    function QueryInfo(dwOption: DWORD; var Info: TDateTime): Boolean; overload;
    function QueryInfo(dwOption: DWORD; var Info: Cardinal): Boolean; overload;
    function QueryInfo(dwOption: DWORD; var info: string): Boolean; overload;
    function GetBindResult(out clsidProtocol: TCLSID; out dwResult: DWORD;
      out szResult: POLEStr; dwReserved: DWORD): HResult;
    destructor destroy; override;
  end;


  TOnProgressEvent = procedure(Sender: TBSCB; ulProgress, ulProgressMax, ulStatusCode: ULONG;
    szStatusText: LPCWSTR; ElapsedTime, Speed, EstimatedTime: string) of object;
  TAuthenticateEvent = function(Sender: TBSCB; var hwnd: HWnd; var szUserName, szPassWord: LPWSTR): HResult of object;
  TBeginningTransactionEvent = function(Sender: TBSCB; szURL, szHeaders: LPCWSTR; dwReserved: DWORD;
    out szAdditionalHeaders: LPWSTR): HResult of object;
  TOnResponseEvent = function(Sender: TBSCB; dwResponseCode: DWORD; szResponseHeaders, szRequestHeaders: LPCWSTR;
    out szAdditionalRequestHeaders: LPWSTR): HResult of object;
  TOnDataEvent = procedure(Sender: TBSCB; var Buffer: PByte; var BufLength: Cardinal) of object;
  TOnCompleteEvent = procedure(Sender: TBSCB; Stream: TStream; Result: HResult) of object;
  TOnResumeEvent = procedure(Sender: TBSCB; Filename: string; var Action: DWORD) of object;
  TGetWindowEvent = function(Sender: TBSCB; const guidReason: TGUID; out hwnd: LongWord): HResult of object;
  TOnSecurityProblemEvent = function(Sender: TBSCB; dwProblem: DWORD): HResult of object;

  TUrlEncodeOption = (PostData, ExtraInfo);
  TUrlEncodeOptions = set of TUrlEncodeOption;

  TBindInfoOption = (
    Asynchronous, AsyncStorage, NoProgressiveRendering, OfflineOperation, GetNewestVersion,
    NoWriteCache, NeedFile, PullData, IgnoreSecurityProblem, Resynchronize, Hyperlink,
    No_UI, SilentOperation, Pragma_No_Cache, GetClassObject, Reserved_1, Free_Threaded,
    Direct_Read, Forms_Submit, GetFromCache_If_Net_Fail, FromUrlmon, Fwd_Back, Reserved_2,
    Reserved_3);

  TBindInfoOptions = set of TBindInfoOption;

  TCodePageOption = (Ansi, // default to ANSI code page
    OEM, // // default to OEM  code page
    Mac, // default to MAC  code page
    ThreadsAnsi, // Current thread's ANSI code page
    Symbol, // Symbol code page (42)
    UTF7, // Translate using UTF-7
    UTF8); // Translate using UTF-8

  TSecurity = class(TPersistent)
  private
    FInheritHandle: Boolean;
    FDescriptor: string;
  published
    property InheritHandle: boolean read FInheritHandle write FInheritHandle;
    property Descriptor: string read FDescriptor write FDescriptor;
  end;

  TRange = class(TPersistent)
  private
    FRangeBegin: Integer;
    FRangeEnd: Integer;
  published
    property RangeBegin: Integer read FRangeBegin write FRangeBegin;
    property RangeEnd: Integer read FRangeEnd write FRangeEnd;
  end;

  TBindVerbOption = (Get, Post, Put, Custom);

  TIEDownload = class(TComponent)
  private
    { Private declarations }

    FObjList: TObjectList;
    FTimeOut: Integer;
    FSecurity: TSecurity;
    FRange: TRange;
    FRefCount: Integer;
    FCancel: Boolean;
    FOnResume: TOnResumeEvent;
    FOnData: TOnDataEvent;
    FPostData: string;
    FPutFileName: string;
    FAdditionalHeader: Tstrings;
    FPassword: string;
    FUsername: string;
    FExtraInfo: string;
    FCustomVerb: string;
    FUserAgent: string;
    FBindVerbValue: Cardinal;
    FBindInfoValue: Cardinal;
    FCodePageValue: Cardinal;
    FBindInfoOptions: TBindInfoOptions;
    FBindVerbOption: TBindVerbOption;
    FCodePageOption: TCodePageOption;
    FUrlEncodeOptions: TUrlEncodeOptions;
    FUrlEncodeValue: Cardinal;
    FBeginningtransAction: TBeginningTransActionEvent;
    FOnAuthenticate: TAuthenticateEvent;
    FOnResponse: TOnResponseEvent;
    FOnProgress: TOnProgressEvent;
    FOnComplete: TOnCompleteEvent;
    FGetWindow: TGetWindowEvent;
    FOnSecurityProblem: TOnSecurityProblemEvent;
    procedure SetAdditionalHeader(const Value: Tstrings);
  protected
  {Other Methods}
    procedure SetBindInfoOptions(const Value: TBindInfoOptions);
    procedure SetBindVerbOption(const Value: TBindVerbOption);
    procedure SetCodePageOption(const Value: TCodePageOption);
    procedure UpdateUrlEncodeValue;
    procedure SetUrlEncodeOptions(const Value: TUrlEncodeOptions);
    procedure FillInfo(var Info: TInfo);
    procedure UpdateBindInfoValue;
  public
    { Public declarations }
    constructor create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Go(Url: string); overload;
    procedure Go(Url, Fname: string); overload;
    procedure Cancel(Item: TBSCB); overload;
    procedure Cancel; overload;
  published
    property TimeOut: Integer read FTimeOut write FTimeOut;
    property ExtraInfo: string read FExtraInfo write FExtraInfo;
    property CustomVerb: string read FCustomVerb write FCustomVerb;
    property Codepage: TCodepageOption read FCodepageOption write SetCodepageOption;
    property Method: TBindVerbOption read FBindVerbOption write SetBindVerbOption;
    property Options: TBindInfoOptions read FBindInfoOptions write SetBindInfoOptions;
    property UrlEncode: TUrlEncodeOptions read FUrlEncodeOptions write FUrlEncodeOptions;
    property Security: TSecurity read FSecurity write FSecurity;
    property Range: TRange read FRange write FRange;
    property Password: string read FPassword write FPassword;
    property Username: string read FUsername write FUsername;
    property PutFileName: string read FPutFileName write FPutFileName;
    property AdditionalHeader: Tstrings read FAdditionalHeader write SetAdditionalHeader;
    property PostData: string read FPostData write FPostData;
    property UserAgent: string read FUserAgent write FUserAgent;

    property OnProgress: TOnProgressEvent read FOnProgress write FOnProgress;
    property OnResume: TOnresumeEvent read FOnResume write FOnResume;
    property OnBeginningTransaction: TBeginningTransActionEvent read FBeginningTransAction write FBeginningTransAction;
    property OnResponse: TOnResponseEvent read FOnResponse write FOnResponse;
    property OnAuthenticate: TAuthenticateEvent read FOnAuthenticate write FOnAuthenticate;
    property OnComplete: TOnCompleteEvent read FOnComplete write FOnComplete;
    property OnData: TOnDataEvent read FOnData write FOnData;
    property OnGetWindow: TGetWindowEvent read FGetwindow write FGetwindow;
    property OnSecurityProblem: TOnSecurityProblemEvent read FOnSecurityProblem write FOnSecurityProblem;

    { Published declarations }
  end;

procedure Register;
function BindStatusText(ulStatusCode: ULONG): string;
function ErrorText(errorCode: Integer): string;
function ResponseCodeText(ResponseCode: Integer): string;

implementation


function TBSCB.GetWindow(const guidReason: TGUID; out hwnd): HResult;
begin
  if Assigned(FSender.FGetWindow) then Result :=
    FSender.FGetWindow(self, guidReason, LongWord(hwnd)) else
    Result := S_OK;
end;

function TBSCB.OnSecurityProblem(dwProblem: DWORD): HResult;
begin
  if Assigned(FSender.FOnSecurityProblem) then Result :=
    FSender.FOnSecurityProblem(self, dwProblem) else
    Result := S_OK;
end;


function TBSCB.Authenticate(var hwnd: HWnd; var szUserName,
  szPassWord: LPWSTR): HResult;
var
  Len: Integer;
begin
  Result := S_OK;
  if Assigned(FSender.FOnAuthenticate) then Result :=
    FSender.FOnAuthentiCate(self, hwnd, szUsername, szPassword) else
  begin
    if Info.Username <> '' then
    begin
      Len := Length(Info.Username);
      szUsername := CoTaskMemAlloc(Len * 2);
      MultiByteToWideChar(0, 0, Pointer(Info.Username), Len, szUsername, Len);
    end else szUsername := nil;
    if Info.Password <> '' then
    begin
      Len := Length(Info.Password);
      szPassword := CoTaskMemAlloc(Len * 2);
      MultiByteToWideChar(0, 0, Pointer(Info.Password), Len, szPassword, Len);
    end else szPassword := nil;
  end;
end;

function TBSCB.BeginningTransaction(szURL, szHeaders: LPCWSTR;
  dwReserved: DWORD; out szAdditionalHeaders: LPWSTR): HResult;
var
  sr: TSearchRec;
  Action: Cardinal;
  s: string;
  Size: Longint;
//  ResumeSupported: Boolean;
  x, Len: Integer;
begin
  if FCancel or FSender.FCancel then
  begin
    Result := E_ABORT;
    if Assigned(FSender.FOnComplete) then FSender.FOnComplete(Self, nil, Result);
    exit;
  end;
  if Info.Useragent <> '' then S := 'User-agent: ' + Info.UserAgent + #13#10;
  if (Info.FileName <> '') then begin

    if FindFirst(Info.FileName, faAnyFile, sr) = 0 then
    begin
      Size := sr.Size;
      FindClose(sr);
      Info.RangeEnd := 0;
      Action := 0;
      if Assigned(FSender.OnResume) then
        FSender.OnResume(Self, Info.Filename, Action);
      case Action of
        RESUME_RESPONSE_CANCEL:
          begin
            Result := E_ABORT;
            exit;
          end;
        RESUME_RESPONSE_OVERWRITE: Info.RangeBegin := 0;
      else
        Info.RangeBegin := Size;
      end;

    end else
    begin
      Info.RangeBegin := 0;
      Info.RangeEnd := 0;
    end;
  end;

  if ((Info.RangeBegin <> 0) or (Info.RangeEnd <> 0)) then
  begin

    S := S + 'Range: bytes=' + IntToStr(Info.RangeBegin) + '-';
    if Info.RangeEnd <> 0 then
      S := S + InttoStr(Info.RangeEnd) + #13#10
    else s := S + #13#10;

  end;
  if (Info.AdditionalHeader[0] <> '') then for x := 0 to Info.AdditionalHeader.Count - 1 do
      S := S + info.additionalheader[x];
  Len := Length(S);
  szAdditionalheaders := CoTaskMemAlloc(Len * 2);
  MultiByteToWideChar(0, 0, Pointer(S), Len,
    szAdditionalheaders, Len);
  if Assigned(FSender.FBeginningTransaction) then
    Result := FSender.FBeginningTransaction(self, szUrl, szHeaders, dwReserved, szAdditionalHeaders) else
    Result := S_OK;
  FBSCBTimer := TTimer.Create(nil);
  FBSCBTimer.OnTimer := TimerExpired;
  FBSCBTimer.Interval := Info.TimeOut;
  FBSCBTimer.Enabled := True;
  FTimedOut := False;
end;


function TBSCB.OnResponse(dwResponseCode: DWORD; szResponseHeaders,
  szRequestHeaders: LPCWSTR;
  out szAdditionalRequestHeaders: LPWSTR): HResult;
var
  Res: HResult;
  len: Cardinal;
  s: string;
begin
  ResponseCode := dwResponseCode;
  if QueryInfo(HTTP_QUERY_CONTENT_LENGTH, Len) and (Len = 0) then
  begin
    Res := S_OK;
    if Assigned(FSender.FOnComplete) then FSender.FOnComplete(Self, nil, Res);
    Result := E_ABORT;
  end else
    if (ResponseCode >= 400) and (ResponseCode < 500) or FCancel or FSender.FCancel then
    begin
      Result := E_ABORT;
      if Assigned(FSender.FOnComplete) then FSender.FOnComplete(Self, nil, Result);
    end
    else
    begin
      if Assigned(FSender.FOnresponse) then Result :=
        FSender.FOnResponse(self, dwResponseCode, szresponseHeaders, szRequestHeaders, szAdditionalRequestHeaders)
      else
        Result := S_OK;
      if (Info.RangeBegin <> 0) and (Info.FileName <> '') then
      begin
        QueryInfo(HTTP_QUERY_ACCEPT_RANGES, S);
        if (S = 'bytes') or (dwResponseCode = 206) then
        begin
          Outputfile := TFileStream.Create(Info.FileName, fmOpenReadWrite);
          Outputfile.Seek(0, soFromEnd);
        end else
        begin
          Outputfile := TFileStream.Create(Info.FileName, fmCreate);
          Info.RangeBegin := 0;
        end;
      end else if Info.FileName <> '' then Outputfile := TFileStream.Create(Info.FileName, fmCreate);
    end;
end;


function TBSCB.GetBindInfo(out grfBINDF: DWORD;
  var bindinfo: TBindInfo): HResult;
var
  PutFile: TFileStream;
  Len: Integer;
begin
  grfBINDF := Info.BindInfoValue;
  with BindInfo do begin
    cbSize := sizeof(TBINDINFO);
    if FReDirect then
      dwBindVerb := BINDVERB_GET else
      dwBindVerb := Info.BindVerbValue;
    grfBindInfoF := Info.UrlEncodeValue; //I don't think it is supported by Urlmon.dll yet
    dwCodePage := Info.CodepageValue;
    with SecurityAttributes do
    begin
      nLength := SizeOf(TSecurityAttributes);
      bInheritHandle := Info.InheritHandle;
      if Info.Descriptor <> '' then
        lpSecurityDescriptor := Pchar(Info.Descriptor) else
        lpSecurityDescriptor := nil;
    end;
    if Info.ExtraInfo <> '' then
    begin
      Len := Length(Info.ExtraInfo);
      szExtraInfo := CoTaskMemAlloc(Len * 2);
      MultiByteToWideChar(0, 0, Pointer(Info.ExtraInfo), Len, szExtraInfo, Len);
    end else szExtraInfo := nil;
    if (Info.BindVerbValue = BINDVERB_PUT) then
    begin
      PutFile := TFileStream.Create(Info.PutFileName, fmOpenRead);
      putfile.Seek(0, 0);
      FglobalData := GlobalAlloc(GPTR, PutFile.Size);
      FDataSize := PutFile.Size;
      putfile.ReadBuffer(Pointer(FGlobalData)^, Putfile.Size);
      putfile.Free;
    end;
    if (Info.BindVerbValue = BINDVERB_POST) then
    begin
      FglobalData := GlobalAlloc(GPTR, Length(Info.Postdata) + 1);
      FDataSize := Length(Info.PostData) + 1;
      move(Info.Postdata[1], Pointer(FGlobalData)^, Length(Info.Postdata));
    end;
    if (Info.CustomVerb <> '') and (dwBindVerb = BINDVERB_CUSTOM) then
    begin
      Len := Length(Info.CustomVerb);
      szCustomVerb := CoTaskMemAlloc(Len * 2);
      MultiByteToWideChar(0, 0, Pointer(Info.CustomVerb), Len, szCustomVerb, Len);
    end else szCustomVerb := nil;
    Fillchar(stgmedData, 0, sizeof(STGMEDIUM));
    cbStgmedData := FDataSize;
    with StgmedData do
    begin
      if dwBindVerb = BINDVERB_GET
        then Tymed := TYMED_NULL else
        Tymed := TYMED_HGLOBAL; // this is the only medium urlmon supports right now
      hGlobal := FGlobalData;
      IUnknown(unkForRelease) := self;
    end;
  end;
  Result := S_OK;
end;

function TBSCB.GetPriority(out nPriority): HResult;
begin
  if FCancel or FSender.FCancel then binding.Abort;
  Result := S_OK;
end;

function TBSCB.OnDataAvailable(grfBSCF, dwSize: DWORD;
  formatetc: PFormatEtc; stgmed: PStgMedium): HResult;
var
  Data: PByte;
  BufL, dwRead, dwActuallyRead: Cardinal;
begin
If FStarttime=0 then FStarttime:=Now;
  if FCancel or FSender.FCancel then binding.Abort else
  begin
    FBSCBTimer.enabled := False;
    FBSCBTimer.enabled := true;
    if (grfBSCF = grfBSCF or BSCF_FIRSTDATANOTIFICATION)
      then
      if (FStream = nil) and (stgmed.tymed = TYMED_ISTREAM)
        then FStream := IStream(stgmed.stm);
    dwRead := dwSize - FTotalRead;
    dwActuallyRead := 0;
    if (dwRead > 0) then
      repeat
        Data := AllocMem(dwRead + 1);
        FStream.Read(Data, dwRead, @dwActuallyRead);
        bufl := dwActuallyRead;
        if Assigned(FSender.FOnData) then
        begin
          FSender.FOnData(self, Data, bufl);
        end;
        if info.filename <> '' then
          Outputfile.WriteBuffer(Data^, bufl) else
          Stream.WriteBuffer(Data^, bufl);
        Inc(FTotalRead, dwActuallyRead);
        FreeMem(data);
      until dwActuallyRead = 0;
  end;
  Result := S_OK;
end;

function TBSCB.OnLowResource(reserved: DWORD): HResult;
begin
  Result := S_OK;
end;

function TBSCB.OnObjectAvailable(const iid: TGUID;
  punk: IUnknown): HResult;
begin
  Result := S_OK;
end;

function TBSCB.OnProgress(ulProgress, ulProgressMax, ulStatusCode: ULONG;
  szStatusText: LPCWSTR): HResult;
var
  Elapsed: string;
 _Speed: double; // temp,
  Speed: string;
  Remaining: string;
begin
  if FCancel or FSender.FCancel then binding.Abort else
  begin
    if (ulStatusCode = BINDSTATUS_DOWNLOADINGDATA) and Assigned(FSender.FOnProgress) then
    begin
      if FStarttime <> 0 then Elapsed := TimeToStr(FStartTime - Now) else
        Elapsed := '';
       try
         _Speed:=ulProgress / (Now - FStarttime) * SecsPerDay * 1000;
       except
         on EZeroDivide do
         begin
           _Speed:=0;
         end;
       end;
      Speed := FloatToStr(_Speed);
      Speed := Copy(Speed, 1, Pos(Decimalseparator, Speed) + 2) + ' kb/sec';
      if ulProgressMax <> 0 then
        remaining := TimeToStr((ulProgressMax - ulProgress) / _speed * 1000 * SecsPerDay)
      else
        Remaining := '';
    end;
    FRedirect := (ulStatusCode = BINDSTATUS_REDIRECTING);
    if Assigned(FSender.FOnProgress) then
      FSender.FOnProgress(self, ulProgress + Info.RangeBegin, ulProgressMax + Info.RangeBegin, ulStatusCode, szStatusText,
        Elapsed, Speed, Remaining);
  end;
  Result := S_OK;
end;

procedure TBSCB.TimerExpired(Sender: TObject);
begin
  FTimedOut := TRUE;
  Binding.Abort;
end;

function TBSCB.OnStartBinding(dwReserved: DWORD; pib: IBinding): HResult;
begin
  if FCancel or FSender.FCancel then
  begin
    Result := E_FAIL;
    if Assigned(FSender.FOnComplete) then FSender.FOnComplete(Self, nil, E_ABORT);
  end else
  begin
    Binding := pib;
    Result := S_OK;
  end;
end;

function TBSCB.OnStopBinding(hresult: HResult; szError: LPCWSTR): HResult;
begin
  Result := S_OK;
  if FTimedOut then hResult := INET_E_CONNECTION_TIMEOUT;
  if info.filename <> '' then
  begin
    Outputfile.Seek(0, 0);
    if Assigned(FSender.FOnComplete) then FSender.FOnComplete(Self, Outputfile, hResult);
  end
  else
    if Assigned(FSender.FOnComplete) then FSender.FOnComplete(Self, stream, hResult);
  if (Info.Filename <> '') then
  begin
    Outputfile.Free;
    Outputfile := nil;
  end;
  if Info.BindInfoValue = Info.BindInfoValue or BINDF_ASYNCHRONOUS then
    FSender.FObjList.Remove(Self);
end;



constructor TBSCB.Create(DownloadInfo: TInfo);
begin
  inherited Create;
  FStarttime:=0;
  if (Info.FileName = '') then Stream := TMemoryStream.Create;
  info := DownloadInfo;
  FSender := TIEDownload(Info.Sender);
  Url := Info.Url;
  binding := nil;
  if not Succeeded(download) then free;
end;

function TBSCB.Download: HRESULT;
var
  hr: HRESULT;
begin
  FCancel := False;
  Result := S_FALSE;
  ClearAll;
  hr := CreateURLMoniker(nil, URL, FMoniker);
  if (hr <> S_OK) then
  begin
    if Assigned(FSender.FOnComplete) then FSender.FOnComplete(self, nil, hr);
    exit;
  end;
  hr := CreateAsyncBindCtx(0, SELF, nil, FBindCtx);
  if (hr <> S_OK) then
  begin
    if Assigned(FSender.FOnComplete) then FSender.FOnComplete(self, nil, hr);
    exit;
  end;
  hr := IsValidUrl(FBindCtx, URL, 0);
  if hr <> S_OK then
  begin
    if Assigned(FSender.FOnComplete) then FSender.FOnComplete(self, nil, MK_E_SYNTAX);
    exit;
  end;
  hr := FMoniker.BindToStorage(FbindCtx, nil, IStream, fstream);
  if (hr <> S_OK) and (hr <> MK_S_ASYNCHRONOUS) then
  begin
    if Assigned(FSender.FOnComplete) then FSender.FOnComplete(self, nil, hr);
    exit;
  end else
  begin
    Result := S_OK;
  end;
end;

procedure TBSCB.ClearAll;
begin
  binding := nil;
  fmoniker := nil;
  fbindctx := nil;
  FGlobalData := 0;
  FTotalRead := 0;
  FDataAvailable := 0;
end;

destructor TBSCB.destroy;
begin
  if FBSCBTimer <> nil then FBSCBTimer.Free;
  if Outputfile <> nil then outputfile.Free;
  info.AdditionalHeader.Free;
  Stream.Free;
  clearall;
  inherited;
end;

function TBSCB._AddRef: Integer;
begin
  Result := InterlockedIncrement(FSender.FRefCount);
end;

function TBSCB._Release: Integer;
begin
  Result := InterlockedDecrement(Fsender.FRefCount);
  if Result = 0 then Destroy;
end;

function TBSCB.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then Result := 0 else Result := E_NOINTERFACE;
end;



function TBSCB.QueryInfo(dwOption: DWORD; var Info: Cardinal): Boolean;
var
  HttpInfo: IWinInetHttpInfo;
  C: Cardinal;
  BufferLength: Cardinal;
  Reserved, dwFlags: Cardinal;
begin
  Info := 0;
  Httpinfo := Binding as IWinInetHttpInfo;
  if Httpinfo <> nil then
  begin
    Reserved := 0;
    dwFlags := 0;
    BufferLength := SizeOf(Cardinal);
    Result := not Boolean(httpInfo.QueryInfo(dwOption or HTTP_QUERY_FLAG_NUMBER,
      @C, BufferLength, dwflags, reserved));
    if Result then Info := C;
  end else Result := FALSE;
  httpinfo := nil;
end;

function TBSCB.QueryInfo(dwOption: DWORD; var info: string): Boolean;
var

  buf: array[0..INTERNET_MAX_PATH_LENGTH] of char;
  HttpInfo: IWinInetHttpInfo;
  buflength, dwReserved, dwFlags: Cardinal;
begin
  Info := '';
  dwReserved := 0;
  dwFlags := 0;
  Httpinfo := Binding as IWinInetHttpInfo;
  if Httpinfo <> nil then
  begin
    buflength := INTERNET_MAX_PATH_LENGTH + 1;
    Result := not Boolean(Httpinfo.QueryInfo(dwOption, @buf, bufLength, dwFlags, dwReserved));
    if Result then Info := Buf;
  end else
    Result := FALSE;
  httpinfo := nil;
end;

function TBSCB.QueryInfo(dwOption: DWORD; var Info: TDateTime): Boolean;
var
  HttpInfo: IWinInetHttpInfo;
  SysTime: TSystemtime;
  BufferLength: Cardinal;
  Reserved, dwFlags: Cardinal;
begin
  Info := 0;
  Httpinfo := Binding as IWinInetHttpInfo;
  if Httpinfo <> nil then
  begin
    Reserved := 0;
    dwFlags := 0;
    BufferLength := SizeOf(TSystemtime);
    Result := not Boolean(httpInfo.QueryInfo(dwOption or HTTP_QUERY_FLAG_SYSTEMTIME,
      @SysTime, BufferLength, dwflags, reserved));
    if Result then Info := SystemtimetoDatetime(SysTime);
  end else Result := FALSE;
  httpinfo := nil;
end;



function TBSCB.GetBindResult(out clsidProtocol: TCLSID;
  out dwResult: DWORD; out szResult: POLEStr; dwReserved: DWORD): HResult;
begin
  Result := Binding.GetBindResult(clsidProtocol, dwResult, szResult, 0);
end;

{ TDownloader }

function GetDefaultUserAgent: string;
var
  reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings\', FALSE)
      then Result := Reg.ReadString('User Agent');
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

constructor TIEDownload.create(AOwner: TComponent);
begin
  inherited;
  FObjList := TObjectList.Create;
  FAdditionalHeader := TStringlist.Create;
  Frange := TRange.Create;
  FSecurity := TSecurity.Create;
  FRefcount := 1;
  FBindInfoOptions := [Asynchronous, AsyncStorage, PullData, NoWriteCache, GetNewestVersion]; //Options;
  FBindVerbOption := Get; //Method;
  FCodePageOption := Ansi; //Ansi Code page;
  FUserAgent := GetDefaultUserAgent;
  FAdditionalHeader.Add('Content-Type: application/x-www-form-urlencoded');
end;

procedure TIEDownload.FillInfo(var Info: TInfo);
begin
  with info do begin
    Sender := Self;
    AdditionalHeader.AddStrings(FAdditionalHeader);
    BindVerbValue := FBindVerbValue;
    BindInfoValue := FBindInfoValue;
    PassWord := FPassWord;
    Username := FUsername;
    CustomVerb := FCustomVerb;
    ExtraInfo := FExtraInfo;
    PostData := FPostData;
    PutFileName := FPutFileName;
    Descriptor := Security.Descriptor;
    InheritHandle := Security.InheritHandle;
    RangeBegin := Range.RangeBegin;
    RangeEnd := Range.RangeEnd;
    UrlEncodeValue := FUrlEncodeValue;
    CodePageValue := FCodepageValue;
    TimeOut := FtimeOut;
  end;
end;

procedure TIEDownload.Go(Url, Fname: string);
var
  Info: TInfo;
  bs: TBscb;
begin
  FCancel := False;
  Info.Url := StringToOleStr(Url);
  Info.FileName := FName;
  Info.AdditionalHeader := TStringlist.Create;
  FillInfo(Info);
  bs := TBSCB.Create(Info);
  if FBindInfoValue <> FBindInfoValue or BINDF_ASYNCHRONOUS then
    BS.Free else FObjList.add(bs);
end;


procedure TIEDownload.Go(Url: string);
var
  Info: TInfo;
  bs: TBscb;
begin
  FCancel := False;
  Info.Url := StringToOleStr(Url);
  Info.FileName := '';
  Info.AdditionalHeader := TStringlist.Create;
  FillInfo(Info);
  bs := TBSCB.Create(Info);
  if FBindInfoValue <> FBindInfoValue or BINDF_ASYNCHRONOUS then
    BS.Free else FObjList.add(bs);
end;

destructor TIEDownload.Destroy;
begin
  FObjlist.Free;
  FRange.Free;
  FSecurity.Free;
  FAdditionalHeader.Free;
  inherited;
end;

procedure TIEdownload.UpdateUrlEncodeValue;
const
  acardUrlEncodeValues: array[TUrlEncodeOption] of Cardinal = (
    $00000001, $00000002);
var
  i: TUrlEncodeOption;
begin
  FUrlEncodeValue := 0;
  if (FUrlEncodeOptions <> []) then
    for i := Low(TUrlEncodeOption) to High(TUrlEncodeOption) do
      if (i in FUrlEncodeOptions) then
        Inc(FUrlencodeValue, acardUrlEncodeValues[i]);
end;

procedure TIEDownload.SetUrlEncodeOptions(const Value:
  TUrlEncodeOptions);
begin
  FUrlEncodeOptions := Value;
  UpdateUrlEncodeValue;
end;

procedure TIEDownload.UpdateBindInfoValue;
const
  acardBindInfoValues: array[TBindInfoOption] of Cardinal = (
    $00000001, $00000002, $00000004, $00000008, $00000010, $00000020, $00000040, $00000080,
    $00000100, $00000200, $00000400, $00000800, $00001000, $00002000, $00004000, $00008000,
    $00010000, $00020000, $00040000, $00080000, $00100000, $00200000, $00400000, $00800000);
var
  i: TBindInfoOption;
begin
  FBindInfoValue := 0;
  if (FBindInfoOptions <> []) then
    for i := Low(TBindInfoOption) to High(TBIndInfoOption) do
      if (i in FBindInfoOptions) then
        Inc(FBindInfoValue, acardBindInfoValues[i]);
end;

procedure TIEDownload.SetBindInfoOptions(const Value:
  TBindInfoOptions);
begin
  FBindInfoOptions := Value;
  UpdateBindInfoValue;
end;

procedure TIEDownload.SetCodePageOption(const Value: TCodepageOption);
begin
  FCodepageOption := Value;
  case FCodepageOption of
    Ansi: FCodepageValue := CP_ACP;
    Mac: FCodepageValue := CP_MACCP;
    OEM: FCodepageValue := CP_OEMCP;
    Symbol: FCodepageValue := CP_SYMBOL;
    ThreadsAnsi: FCodepageValue := CP_THREAD_ACP;
    UTF7: FCodepageValue := CP_UTF7;
    UTF8: FCodepageValue := CP_UTF8;
  end;
end;

procedure TIEDownload.SetBindVerbOption(const Value:
  TBindVerbOption);
begin
  FBindVerbOption := Value;
  case FBindVerbOption of
    Get: FBindVerbValue := BINDVERB_GET;
    Put: FBindVerbValue := BINDVERB_PUT;
    Post: FBindVerbValue := BINDVERB_POST;
    Custom: FBindVerbValue := BINDVERB_CUSTOM;
  end;
end;

procedure TIEDownload.Cancel;
begin
  FCancel := True;
end;

procedure TIEDownload.Cancel(Item: TBSCB);
begin
  Item.FCancel := True;
end;




procedure Register;
begin  
  RegisterComponents('Embedded Web Browser', [TIEDownload]);
end;


function ResponseCodeText(ResponseCode: Integer): string;
begin
  case ResponseCode of
    100: Result := 'Continue';
    101: Result := 'Switching Protocols';
    200: Result := 'OK';
    201: Result := 'Created';
    202: Result := 'Accepted';
    203: Result := 'Non-Authoritative Information';
    204: Result := 'No Content';
    205: Result := 'Reset Content';
    206: Result := 'Partial Content';
    300: Result := 'Multiple Choices';
    301: Result := 'Moved Permanently';
    302: Result := 'Moved Temporarily';
    303: Result := 'See Other';
    304: Result := 'Not Modified';
    305: Result := 'Use Proxy';
    400: Result := 'Bad Request';
    401: Result := 'Unauthorized';
    402: Result := 'Payment Required';
    403: Result := 'Forbidden';
    404: Result := 'Not Found';
    405: Result := 'Method Not Allowed';
    406: Result := 'None Acceptable';
    407: Result := 'Proxy Authentication Required';
    408: Result := 'Request Timeout';
    409: Result := 'Conflict';
    410: Result := 'Gone';
    411: Result := 'Length Required';
    412: Result := 'Precondition Failed';
    413: Result := 'Request Entity Too Large';
    414: Result := 'Request-URI Too Long';
    415: Result := 'Unsupported Media Type';
    416: Result := 'Requested Range Not Satisfiable';
    417: Result := 'Expectation Failed';
    500: Result := 'Internal Server Error';
    501: Result := 'Not Implemented';
    502: Result := 'Bad Gateway';
    503: Result := 'Service Unavailable';
    504: Result := 'Gateway Timeout';
    505: Result := 'HTTP Version Not Supported';


  else
    Result := 'Unknown Response';
  end
end;



function BindStatusText(ulStatusCode: ULONG): string;
begin
  case ulStatusCode of
    BINDSTATUS_REDIRECTING: Result := 'Server redirecting client...';
    BINDSTATUS_FINDINGRESOURCE: Result := 'Finding resource...';
    BINDSTATUS_CONNECTING: Result := 'Connecting...';
    BINDSTATUS_BEGINDOWNLOADDATA: Result := 'Beginning to download data...';
    BINDSTATUS_DOWNLOADINGDATA: Result := 'Downloading data...';
    BINDSTATUS_ENDDOWNLOADDATA: Result := 'Ending data download...';
    BINDSTATUS_BEGINDOWNLOADCOMPONENTS: Result := 'Beginning to download components...';
    BINDSTATUS_INSTALLINGCOMPONENTS: Result := 'Installing components...';
    BINDSTATUS_ENDDOWNLOADCOMPONENTS: Result := 'Ending component download...';
    BINDSTATUS_USINGCACHEDCOPY: Result := 'Using cached copy...';
    BINDSTATUS_SENDINGREQUEST: Result := 'Sending request...';
    BINDSTATUS_CLASSIDAVAILABLE: Result := 'CLSID available...';
    BINDSTATUS_MIMETYPEAVAILABLE: Result := 'MIME type available...';
    BINDSTATUS_CACHEFILENAMEAVAILABLE: Result := 'Cache file name available...';
  else Result := 'Bindstatus Unknown';
  end;
end;


function ErrorText(errorCode: Integer): string;
begin
  case errorCode of
    S_OK: Result := 'Download complete...';
    E_INVALIDARG: result := 'One or more parameters are invalid.';
    E_OUTOFMEMORY: Result := 'There was insufficient memory ...';
    E_ABORT: Result := 'Cancelled ...';
    STG_E_ACCESSDENIED: Result := 'Unable to access the storage object.';
    MK_E_NOSTORAGE: Result := 'The object identified by the moniker does not have its own storage.';
    MK_E_EXCEEDEDDEADLINE: Result := 'The operation could not be completed within the time limit specified by the bind context''s BIND_OPTS structure.';
    MK_E_CONNECTMANUALLY: Result := 'The operation was unable to connect to the storage, possibly because a network device could not be connected to. For more information, see IMoniker::BindToObject.';
    MK_E_INTERMEDIATEINTERFACENOTSUPPORTED: Result := 'An intermediate object was found but it did not support an interface required for an operation. For example, an item moniker returns this value if its container does not support the IOleItemContainer interface.';
    MK_E_SYNTAX: Result := 'A moniker could not be created because of invalid URL syntax.';
    INET_E_AUTHENTICATION_REQUIRED: Result := 'Authentication is needed to access the object.';
    INET_E_CANNOT_CONNECT: Result := 'The attempt to connect to the Internet has failed.';
    INET_E_CANNOT_INSTANTIATE_OBJECT: Result := 'CoCreateInstance failed.';
    INET_E_CANNOT_LOAD_DATA: Result := 'The object could not be loaded.';
    INET_E_CANNOT_LOCK_REQUEST: Result := 'The requested resource could not be locked.';
    INET_E_CONNECTION_TIMEOUT: Result := 'The Internet connection has timed out.';
    INET_E_DATA_NOT_AVAILABLE: Result := 'An Internet connection was established, but the data cannot be retrieved.';
    INET_E_DEFAULT_ACTION: Result := 'Use the default action.';
    INET_E_DOWNLOAD_FAILURE: Result := 'The download has failed (the connection was interrupted).';
    INET_E_INVALID_REQUEST: Result := 'The request was invalid.';
    INET_E_INVALID_URL: Result := 'The URL could not be parsed.';
    INET_E_NO_SESSION: Result := 'No Internet session was established.';
    INET_E_NO_VALID_MEDIA: Result := 'The object is not in one of the acceptable MIME types.';
    INET_E_OBJECT_NOT_FOUND: Result := 'The object was not found.';
    INET_E_QUERYOPTION_UNKNOWN: Result := 'The requested option is unknown.';
    INET_E_REDIRECT_TO_DIR: Result := 'The request is being redirected to a directory.';
    INET_E_REDIRECTING: Result := 'The request is being redirected.';
    INET_E_RESOURCE_NOT_FOUND: Result := 'The server or proxy was not found.';
    INET_E_SECURITY_PROBLEM: Result := 'A security problem was encountered.';
    INET_E_UNKNOWN_PROTOCOL: Result := 'The protocol is not known and no pluggable protocols have been entered that match.';
  else
    if errorCode <> 0 then Result := 'Error: ' + InttoStr(ErrorCode);
  end;
end;

procedure TIEDownload.SetAdditionalHeader(const Value: Tstrings);
begin
  FAdditionalHeader.Assign(Value);
end;


initialization
  coInitialize(nil);
finalization
  coUninitialize;

end.

