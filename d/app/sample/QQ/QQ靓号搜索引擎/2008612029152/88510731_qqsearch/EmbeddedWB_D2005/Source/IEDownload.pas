//**********************************************************************
//                                                                     *
//                IEDownload ver 14.56  (12/07/2006)                   *                                                      *
//                 For Delphi 5, 6, 7, 2005, 2006                      *
//                     Freeware Component                              *
//                            by                                       *
//                     Per Lindsø Larsen                               *
//                   per.lindsoe@larsen.dk                             *
//                                                                     *
//  Contributions:                                                     *
//  Eran Bodankin (bsalsa) bsalsa@bsalsa.no-ip.info (All the new stuf) *
//  Brad (Bradley_davidson@hotmail.com) (MS patches updates)           *
//                                                                     *
//  Updated versions:                                                  *
//               http://www.bsalsa.com                                 *
//**********************************************************************
{*******************************************************************************}
{LICENSE:
THIS SOFTWARE IS PROVIDED TO YOU "AS IS" WITHOUT WARRANTY OF ANY KIND,
EITHER EXPRESSED OR IMPLIED INCLUDING BUT NOT LIMITED TO THE APPLIED
WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
YOU ASSUME THE ENTIRE RISK AS TO THE ACCURACY AND THE USE OF THE SOFTWARE
AND ALL OTHER RISK ARISING OUT OF THE USE OR PERFORMANCE OF THIS SOFTWARE
AND DOCUMENTATION. [YOUR NAME] DOES NOT WARRANT THAT THE SOFTWARE IS ERROR-FREE
OR WILL OPERATE WITHOUT INTERRUPTION. THE SOFTWARE IS NOT DESIGNED, INTENDED
OR LICENSED FOR USE IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE CONTROLS,
INCLUDING WITHOUT LIMITATION, THE DESIGN, CONSTRUCTION, MAINTENANCE OR
OPERATION OF NUCLEAR FACILITIES, AIRCRAFT NAVIGATION OR COMMUNICATION SYSTEMS,
AIR TRAFFIC CONTROL, AND LIFE SUPPORT OR WEAPONS SYSTEMS. VSOFT SPECIFICALLY
DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF FITNESS FOR SUCH PURPOSE.

You may use, change or modify the component under 3 conditions:
1. In your website, add a link to "http://www.bsalsa.com"
2. In your application, add credits to "Embedded Web Browser"
3. Mail me  (bsalsa@bsalsa.com) any code change in the unit
   for the benefit of the other users.
{*******************************************************************************}

unit IEDownload;

interface

{$I EWB.inc}

uses
   Dialogs, ActiveX, Contnrs, ExtCtrls, Windows, UrlMon, Classes;

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
      UserName: string;
      CustomVerb: string;
      ExtraInfo: string;
      Descriptor: string;
      UserAgent: string;
      RangeBegin: Cardinal;
      RangeEnd: Integer;
      InheritHandle: Boolean;
      BindVerbValue: Cardinal;
      BindInfoValue: Cardinal;
      UrlEncodeValue: Cardinal;
      CodePageValue: Cardinal;
   end;

   TProxySettings = class(TPersistent)
   private
      FPort: Integer;
      FServer: string;
      FAutoLoadProxy: Boolean;
      procedure SetProxy(FullUserAgent, ProxyServer: string);
   published
      property AutoLoadProxy: Boolean read FAutoLoadProxy write FAutoLoadProxy default False;
      property Port: Integer read FPort write FPort default 80;
      property Server: string read FServer write FServer;
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
      Info: TInfo;
      OutputFile: TFileStream;
      FBSCBTimer: TTimer;
      FStartTime: TDatetime;
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
      StartTick: Int64;
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
{IWindowForBindingUI methods}
      function GetWindow(const GUIDReason: TGUID; out hwnd): HResult; stdcall;
{IHttpSecurity methods}
      function OnSecurityProblem(dwProblem: DWORD): HResult; stdcall;
      constructor Create(DownloadInfo: TInfo);
      function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
      function _AddRef: Integer; stdcall;
      function _Release: Integer; stdcall;
      function Download: HRESULT;
      procedure ClearAll;
      procedure TimerExpired(Sender: TObject);
      procedure UpdateEvents(Code: integer; BusyState: Boolean; Sender: TBSCB;
         ulProgress, ulProgressMax: ULONG; szStatusText: LPCWSTR; Downloaded, ElapsedTime,
         Speed, RemainingTime, Status: string; Stream: TStream);
      function CheckCancelState: integer;
   public
      Url: PWideChar;
      Stream: TStream;
      Binding: IBinding;
      ResponseCode: Cardinal;
      function QueryInfo(dwOption: DWORD; var Info: TDateTime): Boolean; overload;
      function QueryInfo(dwOption: DWORD; var Info: Cardinal): Boolean; overload;
      function QueryInfo(dwOption: DWORD; var info: string): Boolean; overload;
      function GetBindResult(out clsidProtocol: TCLSID; out dwResult: DWORD;
         out szResult: POLEStr; dwReserved: DWORD): HResult;
      destructor Destroy; override;
   end;

   TOnProgressEvent = procedure(Sender: TBSCB; ulProgress, ulProgressMax, ulStatusCode: ULONG;
      szStatusText: LPCWSTR; Downloaded, ElapsedTime, Speed, RemainingTime, Status: string) of object;
   TAuthenticateEvent = function(Sender: TBSCB; var hwnd: HWnd; var szUserName, szPassWord: LPWSTR): HResult of object;
   TBeginningTransactionEvent = function(Sender: TBSCB; szURL, szHeaders: LPCWSTR; dwReserved: DWORD;
      out szAdditionalHeaders: LPWSTR): HResult of object;
   TOnResponseEvent = function(Sender: TBSCB; dwResponseCode: DWORD; szResponseHeaders, szRequestHeaders: LPCWSTR;
      out szAdditionalRequestHeaders: LPWSTR): HResult of object;
   TOnDataEvent = procedure(Sender: TBSCB; var Buffer: PByte; var BufLength: Cardinal) of object;
   TOnCompleteEvent = procedure(Sender: TBSCB; Stream: TStream; Result: HResult) of object;
   TOnResumeEvent = procedure(Sender: TBSCB; FileName: string; var Action: DWORD) of object;
   TGetWindowEvent = function(Sender: TBSCB; const GUIDReason: TGUID; out hwnd: LongWord): HResult of object;
   TOnSecurityProblemEvent = function(Sender: TBSCB; dwProblem: DWORD): HResult of object;
   TOnErrorTextEvent = procedure(Sender: TBSCB; Text: string) of object;
   TOnStatusTextEvent = procedure(Sender: TBSCB; Text: string) of object;
   TOnRespondTextEvent = procedure(Sender: TBSCB; Text: string) of object;

   TUrlEncodeOption = (PostData, ExtraInfo);
   TUrlEncodeOptions = set of TUrlEncodeOption;

   TBindInfoOption = (
      Asynchronous, AsyncStorage, NoProgressiveRendering, OfflineOperation, GetNewestVersion,
      NoWriteCache, NeedFile, PullData, IgnoreSecurityProblem, Resynchronize, Hyperlink,
      No_UI, SilentOperation, Pragma_No_Cache, GetClassObject, Reserved_1, Free_Threaded,
      Direct_Read, Forms_Submit, GetFromCache_If_Net_Fail, FromUrlmon, Fwd_Back, Reserved_2,
      Reserved_3);

   TBindInfoOptions = set of TBindInfoOption;

   TCodePageOption = (
      Ansi, // default to ANSI code page
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
      FObjList: TObjectList;
      FTimeOut: Integer;
      FSecurity: TSecurity;
      FRange: TRange;
      FRefCount: Integer;
      Fbusy: Boolean;
      FOnBusy: TNotifyEvent;
      FullUserAgent: string;
      FURL: WideString;
      FDefaultProtocol: string;
      FCancel: Boolean;
      FOnResume: TOnResumeEvent;
      FOnData: TOnDataEvent;
      FPostData: string;
      FPutFileName: string;
      FAdditionalHeader: Tstrings;
      FPassword: string;
      FUserName: string;
      FExtraInfo: string;
      FCustomVerb: string;
      FUserAgent: string;
      FSaveFileAs: WideString;
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
      FOnErrorText: TOnErrorTextEvent;
      FProxySettings: TProxySettings;
      FOnStatusText: TOnStatusTextEvent;
      FOnRespondText: TOnRespondTextEvent;
      procedure SetAdditionalHeader(const Value: Tstrings);
      function AddPrefixHttp: Widestring;
      procedure UpdateUserAgent;
      function DoPath: WideString;
   protected
      procedure SetDefaultProtocol(const Value: string);
      procedure BusyChange; dynamic;
      procedure SetBindInfoOptions(const Value: TBindInfoOptions);
      procedure SetBindVerbOption(const Value: TBindVerbOption);
      procedure SetCodePageOption(const Value: TCodePageOption);
      procedure UpdateUrlEncodeValue;
      procedure SetUrlEncodeOptions(const Value: TUrlEncodeOptions);
      procedure FillInfo(var Info: TInfo);
      procedure UpdateBindInfoValue;
   public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure Loaded; override;
      procedure DownloadUrlToFile(URL: WideString);
      procedure DownloadUrlToStream(URL: WideString);
      procedure Go(URL: WideString); overload;
      procedure Go(Url, FileName: WideString); overload;
      procedure Cancel(Item: TBSCB); overload;
      procedure Cancel; overload;
      property Busy: Boolean read FBusy write FBusy default False;
   published
      property TimeOut: Integer read FTimeOut write FTimeOut;
      property ExtraInfo: string read FExtraInfo write FExtraInfo;
      property CustomVerb: string read FCustomVerb write FCustomVerb;
      property Codepage: TCodepageOption read FCodepageOption write SetCodepageOption;
      property DefaultProtocol: string read FDefaultProtocol write SetDefaultProtocol;
      property Method: TBindVerbOption read FBindVerbOption write SetBindVerbOption;
      property Options: TBindInfoOptions read FBindInfoOptions write SetBindInfoOptions;
      property ProxySettings: TProxySettings read FProxySettings write FProxySettings;
      property UrlEncode: TUrlEncodeOptions read FUrlEncodeOptions write FUrlEncodeOptions;
      property Security: TSecurity read FSecurity write FSecurity;
      property Range: TRange read FRange write FRange;
      property Password: string read FPassword write FPassword;
      property UserName: string read FUserName write FUserName;
      property PutFileName: string read FPutFileName write FPutFileName;
      property AdditionalHeader: Tstrings read FAdditionalHeader write SetAdditionalHeader;
      property PostData: string read FPostData write FPostData;
      property SaveFileAs: WideString read FSaveFileAs write FSaveFileAs;
      property UserAgent: string read FUserAgent write FUserAgent;
      property OnBusyStateChange: TNotifyEvent read FOnBusy write FOnBusy;
      property OnErrorText: TOnErrorTextEvent read FOnErrorText write FOnErrorText;
      property OnRespondText: TOnRespondTextEvent read FOnRespondText write FOnRespondText;
      property OnStatusText: TOnStatusTextEvent read FOnStatusText write FOnStatusText;
      property OnProgress: TOnProgressEvent read FOnProgress write FOnProgress;
      property OnResume: TOnresumeEvent read FOnResume write FOnResume;
      property OnBeginningTransaction: TBeginningTransActionEvent read FBeginningTransAction write FBeginningTransAction;
      property OnResponse: TOnResponseEvent read FOnResponse write FOnResponse;
      property OnAuthenticate: TAuthenticateEvent read FOnAuthenticate write FOnAuthenticate;
      property OnComplete: TOnCompleteEvent read FOnComplete write FOnComplete;
      property OnData: TOnDataEvent read FOnData write FOnData;
      property OnGetWindow: TGetWindowEvent read FGetwindow write FGetwindow;
      property OnSecurityProblem: TOnSecurityProblemEvent read FOnSecurityProblem write FOnSecurityProblem;
      property URL: WideString read FURL write FURL;
   end;

function BindStatusText(ulStatusCode: ULONG): string;
function ErrorText(errorCode: Integer): string;
function ResponseCodeText(ResponseCode: Integer): string;

implementation

uses
   SysUtils, WinInet, Registry, IEConst, Forms;

// Accesories-------------------------------------------------------------------

function ResponseCodeText(ResponseCode: Integer): string;
begin
   case ResponseCode of
      0: Result := 'OK';
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
         begin
            Result := 'Unknown Response: ' + IntToStr(ResponseCode);
         end;
   end
end;

function BindStatusText(ulStatusCode: ULONG): string;
begin
   case ulStatusCode of
      0: Result := 'OK';
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
      BINDSTATUS_CACHEFileNameAVAILABLE: Result := 'Cache file name available...';
      BINDSTATUS_BEGINSYNCOPERATION: Result := 'Synchronous operation has started...';
      BINDSTATUS_ENDSYNCOPERATION: Result := 'Ending synchronous operation...';
      BINDSTATUS_BEGINUPLOADDATA: Result := 'Beginning to upload data...';
      BINDSTATUS_UPLOADINGDATA: Result := 'Uploading data...';
      BINDSTATUS_ENDUPLOADDATA: Result := 'Ending data upload...';
      BINDSTATUS_PROTOCOLCLASSID: Result := 'Protocol handler CLSID is available...';
      BINDSTATUS_ENCODING: Result := 'Encoding data...';
      BINDSTATUS_VERIFIEDMIMETYPEAVAILABLE: Result := 'Verified MIME type is available...';
      BINDSTATUS_CLASSINSTALLLOCATION: Result := 'Class install location is available...';
      BINDSTATUS_DECODING: Result := 'Decoding data...';
      BINDSTATUS_LOADINGMIMEHANDLER: Result := 'Pluggable MIME handler is being loaded...';
{$IFDEF DELPHI_6_UP}
      BINDSTATUS_CONTENTDISPOSITIONATTACH: Result := 'Content-Disposition resource is an attachment...';
      BINDSTATUS_FILTERREPORTMIMETYPE: Result := 'New MIME type available for resource...';
      BINDSTATUS_CLSIDCANINSTANTIATE: Result := 'CLSID to return on BindToObject...';
      BINDSTATUS_IUNKNOWNAVAILABLE: Result := 'IUnknown interface has been released...';
      BINDSTATUS_DIRECTBIND: Result := 'Connected directly to the pluggable protocol handler...';
      BINDSTATUS_RAWMIMETYPE: Result := 'Raw MIME type...';
      BINDSTATUS_PROXYDETECTING: Result := 'Proxy server has been detected...';
      BINDSTATUS_ACCEPTRANGES: Result := 'Valid types of range requests...';
{$ENDIF}
      else
         Result := 'Unknown Bindstatus: ' + IntToStr(ulStatusCode);
   end;
end;

function ErrorText(ErrorCode: Integer): string;
begin
   case ErrorCode of
   //     401: Result := 'You are not authorized to view this page.';
   //     404 : Result := 'The page you are looking for does not exist.';
      S_OK: Result := 'OK';
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
      INET_E_USE_EXTEND_Binding: Result := 'Reissue request with extended Binding.';
      INET_E_TERMINATED_BIND: Result := 'Binding is terminated.';
      INET_E_CODE_DOWNLOAD_DECLINED: Result := 'Permission to download is declined.';
      INET_E_RESULT_DISPATCHED: Result := 'Result is dispatched.';
      INET_E_CANNOT_REPLACE_SFP_FILE: Result := 'Cannot replace a protected System File Protection (SFP) file.';
      ERROR_INTERNET_SEC_CERT_DATE_INVALID: Result := 'SSL certificate date that was received from the server is bad. The certificate is expired.';
      ERROR_INTERNET_SEC_CERT_CN_INVALID: Result := 'SSL certificate common name (host name field) is incorrect???for example, if you entered www.server.com and the common name on the certificate says www.different.com.';
      ERROR_INTERNET_MIXED_SECURITY: Result := 'The content is not entirely secure. Some of the content being viewed may have come from unsecured servers.';
      ERROR_INTERNET_CHG_POST_IS_NON_SECURE: Result := 'The application is posting and attempting to change multiple lines of text on a server that is not secure.';
      ERROR_INTERNET_POST_IS_NON_SECURE: Result := 'The application is posting data to a server that is not secure.';
      ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED: Result := 'The server is requesting client authentication.';
      ERROR_INTERNET_INVALID_CA: Result := 'The function is unfamiliar with the Certificate Authority that generated the server''s certificate.';
      ERROR_INTERNET_CLIENT_AUTH_NOT_SETUP: Result := 'Client authorization is not set up on this computer.';
      ERROR_INTERNET_SEC_CERT_REV_FAILED: Result := 'SSL Certificate revision failed.';
      ERROR_INTERNET_SEC_CERT_REVOKED: Result := 'SSL certificate was revoked.';
      ERROR_INTERNET_FORTEZZA_LOGIN_NEEDED: Result := 'The requested resource requires Fortezza authentication.';
      ERROR_INTERNET_HTTP_TO_HTTPS_ON_REDIR: Result := 'The application is moving from a non-SSL to an SSL connection because of a redirect.';
      ERROR_INTERNET_HTTPS_TO_HTTP_ON_REDIR: Result := 'The application is moving from an SSL to an non-SSL connection because of a redirect.';
      ERROR_HTTP_REDIRECT_NEEDS_CONFIRMATION: Result := 'The redirection requires user confirmation.';
      ERROR_INTERNET_SEC_CERT_ERRORS: Result := 'The SSL certificate contains errors.';
      else
         if ErrorCode <> 0 then
            Result := 'Error: ' + IntToStr(ErrorCode) + ' ' + SysErrorMessage(ErrorCode);
   end;
end;

function FormatTickToTime(TickCount: Cardinal): string;
var
   Hours, Minutes, Seconds, MSecs: Cardinal;
   S_HUR, S_MIN, S_SEC, S_MSC: string;
begin
   S_MSC := '000';
   S_SEC := '00';
   S_MIN := '00';
   S_HUR := '00';
   try
      if (TickCount > 0) then
         begin
            MSecs := TickCount mod MSecsPerSec;
            TickCount := TickCount div MSecsPerSec;
            S_MSC := Format('%.3d', [MSecs]);
            Seconds := TickCount mod SecsPerMin;
            TickCount := TickCount div SecsPerMin;
            S_SEC := Format('%.2d', [Seconds]);
            Minutes := TickCount mod MinsPerHour;
            TickCount := TickCount div MinsPerHour;
            S_MIN := Format('%.2d', [Minutes]);
            Hours := TickCount mod HoursPerDay;
            S_HUR := Format('%.2d', [Hours]);
         end;
   finally
      if S_HUR = '00' then
         Result := S_MIN + 'm :' + S_SEC + 's :' + S_MSC + 'ms';
      if (S_HUR = '00') and (S_MIN = '00') then
         Result := S_SEC + 's :' + S_MSC + 'ms';
      if S_HUR <> '00' then
         Result := S_HUR + 'h :' + S_MIN + 'm :' + S_SEC + 's :' + S_MSC + 'ms';
   end;
end;

function FormatSize(Byte: Double): string;
begin
   if (Byte < 1024) then
      Result := Format('%.2n b', [Byte])
   else
      begin
         Byte := (Byte / 1024);
         if (Byte < 1024) then
            Result := Format('%.2n Kb', [Byte])
         else
            begin
               Byte := (Byte / 1024);
               Result := Format('%.2n Mb', [Byte]);
            end;
      end;
end;

function IsValidURL(const URL: Widestring): Boolean;
begin
   if UrlMon.IsValidURL(nil, PWideChar(URL), 0) = S_OK then
      Result := True
   else
      Result := False;
end;

// End of Accesories------------------------------------------------------------

function TBSCB.GetWindow(const GUIDReason: TGUID; out hwnd): HResult;
begin
   if Assigned(FSender.FGetWindow) then
      Result :=
         FSender.FGetWindow(self, GUIDReason, LongWord(hwnd))
   else
      Result := S_OK;
end;

function TBSCB.OnSecurityProblem(dwProblem: DWORD): HResult; //bs
begin
   UpdateEvents(dwProblem, False, Self, 0, 0, 'Security Problem.',
      '0', '0', '0', '0', 'Security Problem.', nil);
   if Assigned(FSender.FOnSecurityProblem) then
      begin
         Result := FSender.FOnSecurityProblem(Self, dwProblem);
      end
   else
      Result := S_OK;
end;

function TBSCB.Authenticate(var hwnd: HWnd; var szUserName, szPassWord: LPWSTR): HResult;
var
   Len: Integer;
begin
  {Optional Results  on Authenticate callback :
  S_OK  = Authentication was successful.
  E_ACCESSDENIED = Authentication failed.
  E_INVALIDARG = One or more parameters are invalid.}
   Result := S_OK;
   if CheckCancelState = E_Abort then
      Exit;
   if Assigned(FSender.FOnAuthenticate) then
      Result := FSender.FOnAuthentiCate(self, hwnd, szUserName, szPassword)
   else
      begin
         if Info.UserName <> '' then
            begin
               Len := Length(Info.UserName);
               szUserName := CoTaskMemAlloc(Len * 2);
               if szUserName = nil then
                  begin
                     UpdateEvents(E_OUTOFMEMORY, False, Self, 0, 0, 'Out of memory.',
                        '0', '0', '0', '0', 'Out of memory.', nil);
                     Exit;
                  end;
               MultiByteToWideChar(0, 0, Pointer(Info.UserName), Len, szUserName, Len);
            end
         else
            szUserName := nil;
         if Info.Password <> '' then
            begin
               Len := Length(Info.Password);
               szPassword := CoTaskMemAlloc(Len * 2);
               if szPassword = nil then
                  begin
                     UpdateEvents(E_OUTOFMEMORY, False, Self, 0, 0, 'Out of memory.',
                        '0', '0', '0', '0', 'Out of memory.', nil);
                     Exit;
                  end;
               MultiByteToWideChar(0, 0, Pointer(Info.Password), Len, szPassword, Len);
            end
         else
            szPassword := nil;
      end;
end;

function TBSCB.BeginningTransaction(szURL, szHeaders: LPCWSTR; dwReserved: DWORD;
   out szAdditionalHeaders: LPWSTR): HResult; //bs
var
   sr: TSearchRec;
   Action: Cardinal;
   S: string;
   Size: Longint;
   x, Len: Integer;
begin
   if CheckCancelState = E_Abort then
      begin
         Result := E_Abort;
         Exit;
      end;
   S := FSender.FullUserAgent + #13#10;
   if (Info.FileName <> '') then
      begin
         if FindFirst(Info.FileName, faAnyFile, sr) = 0 then
            begin
               Size := sr.Size;
               FindClose(sr);
               Info.RangeEnd := 0;
               Action := 0;
               if Assigned(FSender.OnResume) then
                  FSender.OnResume(Self, Info.FileName, Action);
               case Action of
                  RESUME_RESPONSE_CANCEL:
                     begin
                        Result := E_ABORT;
                        Exit;
                     end;
                  RESUME_RESPONSE_OVERWRITE: Info.RangeBegin := 0;
                  else
                     Info.RangeBegin := Size;
               end;
            end
         else
            begin
               Info.RangeBegin := 0;
               Info.RangeEnd := 0;
            end;
      end;
   if ((Info.RangeBegin <> 0) or (Info.RangeEnd <> 0)) then
      begin
         S := S + 'Range: bytes=' + IntToStr(Info.RangeBegin) + '-';
         if Info.RangeEnd <> 0 then
            S := S + IntToStr(Info.RangeEnd) + #13#10
         else
            S := S + #13#10;
      end;
   if (Info.AdditionalHeader[0] <> '') then
      for x := 0 to Info.AdditionalHeader.Count - 1 do
         S := S + info.additionalheader[x] + '#$D#$A"';
   Len := Length(S);
   szAdditionalHeaders := CoTaskMemAlloc(Len * 2);
   MultiByteToWideChar(0, 0, Pointer(S), Len, szAdditionalHeaders, Len);
   if Assigned(FSender.FBeginningTransaction) then
      Result := FSender.FBeginningTransaction(Self, szUrl, szHeaders, dwReserved, szAdditionalHeaders)
   else
      Result := S_OK;

   FBSCBTimer.Enabled := True;
   FTimedOut := False;
end;

function TBSCB.OnResponse(dwResponseCode: DWORD; szResponseHeaders,
   szRequestHeaders: LPCWSTR; out szAdditionalRequestHeaders: LPWSTR): HResult; //bs
var
   len: Cardinal;
   s: string;
begin
   if CheckCancelState = E_Abort then
      begin
         Result := E_Abort;
         ClearAll;
         Exit;
      end;
   ResponseCode := dwResponseCode;
   if (ResponseCode >= 300) then
      UpdateEvents(ResponseCode, False, Self, 0, 0, 'Error.',
         '0', '0', '0', '0', 'Error.', nil);

   if (QueryInfo(HTTP_QUERY_CUSTOM, len) and (Len = 0)) or
      (QueryInfo(HTTP_QUERY_CONTENT_LENGTH, Len) and (Len = 0)) then
      begin
         FCancel := true;
         Result := E_ABORT;
         UpdateEvents(Result, False, Self, 0, 0, 'File Size Error.',
            '0', '0', '0', '0', 'File Size Error.', nil);
         ClearAll;
         Exit;
      end
   else
      if (ResponseCode >= 400) and (ResponseCode < 500) then
         begin
            FCancel := true;
            Result := E_ABORT;
            UpdateEvents(Result, False, Self, 0, 0, 'Aborted.',
               '0', '0', '0', '0', ResponseCodeText(ResponseCode), nil);
            ClearAll;
            Exit;
         end
      else
         begin
            if Assigned(FSender.FOnResponse) then
               Result := FSender.FOnResponse(self, dwResponseCode,
                  szResponseHeaders, szRequestHeaders, szAdditionalRequestHeaders)
            else
               Result := S_OK;
            if (Info.RangeBegin <> 0) and (Info.FileName <> '') then
               begin
                  QueryInfo(HTTP_QUERY_ACCEPT_RANGES, S);
                  if (S = 'bytes') or (dwResponseCode = 206) then
                     begin
                        OutPutFile := TFileStream.Create(Info.FileName, fmOpenReadWrite);
                        OutPutFile.Seek(0, soFromEnd);
                     end
                  else
                     begin
                        OutPutFile := TFileStream.Create(Info.FileName, fmCreate);
                        Info.RangeBegin := 0;
                     end;
               end
            else
               if Info.FileName <> '' then
                  OutPutFile := TFileStream.Create(Info.FileName, fmCreate);
         end;
end;

function TBSCB.GetBindInfo(out grfBINDF: DWORD; var bindinfo: TBindInfo): HResult; //bs
var
   PutFile: TFileStream;
   Len: Integer;
begin
   grfBINDF := Info.BindInfoValue;
   with BindInfo do
      begin
         cbSize := sizeof(TBINDINFO);
         if FReDirect then
            dwBindVerb := BINDVERB_GET
         else
            dwBindVerb := Info.BindVerbValue;
         grfBindInfoF := Info.UrlEncodeValue; //I don't think it is supported by Urlmon.dll yet
         dwCodePage := Info.CodepageValue;
         with SecurityAttributes do
            begin
               nLength := SizeOf(TSecurityAttributes);
               bInheritHandle := Info.InheritHandle;
               if Info.Descriptor <> '' then
                  lpSecurityDescriptor := Pchar(Info.Descriptor)
               else
                  lpSecurityDescriptor := nil;
            end;
         if Info.ExtraInfo <> '' then
            begin
               Len := Length(Info.ExtraInfo);
               szExtraInfo := CoTaskMemAlloc(Len * 2);
               MultiByteToWideChar(0, 0, Pointer(Info.ExtraInfo), Len, szExtraInfo, Len);
            end
         else
            szExtraInfo := nil;
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
            end
         else
            szCustomVerb := nil;
         Fillchar(stgmedData, 0, sizeof(STGMEDIUM));
         cbStgmedData := FDataSize;
         with StgmedData do
            begin
               if dwBindVerb = BINDVERB_GET
                  then
                  Tymed := TYMED_NULL
               else
                  Tymed := TYMED_HGLOBAL; // this is the only medium urlmon supports right now
               hGlobal := FGlobalData;
               IUnknown(unkForRelease) := self;
            end;
      end;
   Result := S_OK;
end;

function TBSCB.GetPriority(out nPriority): HResult;
begin
   Result := CheckCancelState;
end;

function TBSCB.OnDataAvailable(grfBSCF, dwSize: DWORD; formatetc: PFormatEtc;
   stgmed: PStgMedium): HResult;
var
   Data: PByte;
   BufL, dwRead, dwActuallyRead: Cardinal;
begin
   if FStartTime = 0 then
      FStartTime := Now;
   if CheckCancelState = E_Abort then
      begin
         Result := E_Abort;
         Exit;
      end
   else
      begin
         FBSCBTimer.Enabled := False;
         FBSCBTimer.Enabled := True;
         if (grfBSCF = grfBSCF or BSCF_FIRSTDATANOTIFICATION) and
            ((FStream = nil) and (stgmed.tymed = TYMED_ISTREAM)) then
            FStream := IStream(stgmed.stm);
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
               if Info.FileName <> '' then
                  OutPutFile.WriteBuffer(Data^, bufl)
               else
                  Stream.WriteBuffer(Data^, bufl);
               Inc(FTotalRead, dwActuallyRead);
               FreeMem(Data);
            until dwActuallyRead = 0;
      end;
   Result := S_OK;
end;

function TBSCB.OnLowResource(reserved: DWORD): HResult;
begin
   Result := S_OK;
end;

function TBSCB.OnObjectAvailable(const iid: TGUID; punk: IUnknown): HResult;
begin
   Result := S_OK;
end;

function TBSCB.OnProgress(ulProgress, ulProgressMax, ulStatusCode: ULONG;
   szStatusText: LPCWSTR): HResult;
var
   Speed, Elapsed, Downloaded, RemainingTime, Status: string;
   _Speed: double;
begin
   if CheckCancelState = E_Abort then
      begin
         Result := E_Abort;
         Exit;
      end
   else
      begin
         if (Assigned(FSender.FOnStatusText)) and (BindStatusText(ulStatusCode) <> 'Bindstatus Unknown') then
            FSender.FOnStatusText(Self, BindStatusText(ulStatusCode));
         Status := BindStatusText(ulStatusCode);
         Elapsed := FormatTickToTime(GetTickCount - StartTick);
         case ulStatusCode of
            BINDSTATUS_ENDDOWNLOADDATA:
               begin
                  Downloaded := 'Done.';
                  ulProgress := 0;
                  Speed := '0/00  kb/sec';
                  RemainingTime := '00.00.00';
                  Elapsed := FormatTickToTime(GetTickCount - StartTick);
                  Status := 'Done.';
               end;
            BINDSTATUS_DOWNLOADINGDATA:
               begin
                  if ulProgressMax = 0 then
                     ulProgressMax := ulProgress * 100; // dummy value in case file size is unknown
                  if Assigned(FSender.FOnProgress) then
                     begin
                        try
                           if (Now - FStartTime) > 0 then
                              _Speed := ulProgress / (Now - FStartTime) * SecsPerDay * MSecsPerSec
                           else
                              _Speed := 0;

                           Speed := Copy(FloatToStr(_Speed), 1, Pos(DecimalSeparator,
                              FloatToStr(_Speed)) + 2) + ' kb/sec';
                           if (ulProgressMax > 0) and ((_speed) > 0) then
                              begin
                                 LongTimeFormat := 'mm:ss.zzz';
                                 remainingTime := TimeToStr((ulProgressMax - ulProgress) / _speed * 1000 * SecsPerDay);
                              end
                           else
                              RemainingTime := '00:00:000';
                           Downloaded := FormatSize(ulProgress + Info.RangeBegin);
                        except
                           on EZeroDivide do
                              RemainingTime := '00.00.000';
                        end;
                     end;
               end;
            BINDSTATUS_REDIRECTING:
               begin
                  FRedirect := (ulStatusCode = BINDSTATUS_REDIRECTING);
                  if (Assigned(FSender.FOnStatusText)) then
                     FSender.FOnStatusText(Self, BindStatusText(ulStatusCode));
               end
            else
               ;
         end;
         if Assigned(FSender.FOnProgress) then
            FSender.FOnProgress(Self, ulProgress + Info.RangeBegin, ulProgressMax + Info.RangeBegin, ulStatusCode, szStatusText,
               Downloaded, Elapsed, Speed, RemainingTime, Status);
      end;
   Result := S_OK;
end;

function TBSCB.CheckCancelState: Integer;
begin
   if FCancel or FSender.FCancel then
      begin
         Binding.Abort;
         Result := E_ABORT;
         UpdateEvents(Result, False, Self, 0, 0, 'Aborted.',
            '0', '0', '0', '0', 'Aborted.', nil);
      end
   else
      Result := S_OK;
end;

procedure TBSCB.TimerExpired(Sender: TObject); //bs
begin
   FTimedOut := True;
  //  Binding.Abort;
end;

function TBSCB.OnStartBinding(dwReserved: DWORD; pib: IBinding): HResult;
begin
   if CheckCancelState = E_Abort then
      Result := E_FAIL
   else
      begin
         Binding := pib;
         Result := S_OK;
      end;
end;

function TBSCB.OnStopBinding(hresult: hResult; szError: LPCWSTR): HResult; //bs
begin
   Result := S_OK;
  //  FBSCBTimer.Enabled := False;
   if FTimedOut then
      hResult := INET_E_CONNECTION_TIMEOUT;
   if hResult = S_OK then
      begin

         if info.FileName <> '' then
            begin
               OutPutFile.Seek(0, 0);
               UpdateEvents(hResult, False, Self, 0, 0, 'Ready.',
                  '', '', '', '', 'Done', OutPutFile);
            end
         else
            begin
               UpdateEvents(hResult, False, Self, 0, 0, 'Ready.',
                  '', '', '', '', 'Ready.', Stream);
            end;

         if (Info.FileName <> '') then
            begin
               UpdateEvents(hResult, False, Self, 0, 0, ',Ready.',
                  '', '', '', '', 'Done ' + Info.FileName, OutPutFile);

               FreeAndNil(OutPutFile);
            end;
         if Info.BindInfoValue = Info.BindInfoValue or BINDF_ASYNCHRONOUS then
            FSender.FObjList.Remove(Self);
      end
   else
      UpdateEvents(hResult, False, Self, 0, 0, 'Error.',
         '', '', '', '', (ErrorText(hResult)), nil);
end;

constructor TBSCB.Create(DownloadInfo: TInfo);
begin
   inherited Create;
   ClearAll;
   StartTick := GetTickCount;
   if (Info.FileName = '') then
      Stream := TMemoryStream.Create;
   Info := DownloadInfo;
   FBSCBTimer := TTimer.Create(nil);
   FBSCBTimer.OnTimer := TimerExpired;
   FBSCBTimer.Interval := Info.TimeOut;
   FTimedOut := False;
   FSender := TIEDownload(Info.Sender);
   Url := Info.Url;
   Binding := nil;
   UpdateEvents(S_OK, True, Self, 0, 0, 'Starting..',
      '', '', '', '', 'Starting...', nil);
   if CheckCancelState = E_Abort then
      Exit
   else
      Download;
end;

destructor TBSCB.Destroy; //bs
begin
   ClearAll;
   if (FBSCBTimer <> nil) and Assigned(FBSCBTimer) then
      FreeAndNil(FBSCBTimer);
   if (OutPutFile <> nil) and Assigned(OutPutFile) then
      FreeAndNil(OutPutFile);
   if (Stream <> nil) and Assigned(Stream) then
      FreeAndNil(Stream);
   Info.AdditionalHeader.Free;
   if (FGlobalData <> 0) then
      GlobalFree(FGlobalData);
   inherited;
end;

function TBSCB.Download: HRESULT;
var
   hr: HRESULT;
   OleStrUrl: POleStr;
begin
   FCancel := False;
   Result := S_False;
   ClearAll;
   OleStrUrl := StringToOleStr(Info.URL);
   try
      hr := CreateURLMoniker(nil, OleStrUrl, FMoniker);
      if (hr <> S_OK) then
         begin
            UpdateEvents(HR, False, Self, 0, 0, 'Error creating Moniker.',
               '0', '0', '0', '0', 'Error creating Moniker.', nil);
            Exit;
         end;
      hr := CreateAsyncBindCtx(0, SELF, nil, FBindCtx);
      if (hr <> S_OK) then
         begin
            UpdateEvents(HR, False, Self, 0, 0, 'Error creating Async Bind.',
               '0', '0', '0', '0', 'Error creating Async Bind.', nil);
            Exit;
         end;
      hr := URLMon.IsValidUrl(FBindCtx, OleStrUrl, 0);
      if hr <> S_OK then
         begin
            UpdateEvents(MK_E_SYNTAX, False, Self, 0, 0, 'Error in syntax.',
               '0', '0', '0', '0', 'Error in syntax.', nil);
            Exit;
         end;
      hr := FMoniker.BindToStorage(FbindCtx, nil, IStream, fstream);

      if (hr <> S_OK) and (hr <> MK_S_ASYNCHRONOUS) then
         begin
            UpdateEvents(MK_E_SYNTAX, False, Self, 0, 0, 'Error in Bind To Storage.',
               '0', '0', '0', '0', 'Error in Bind To Storage.', nil);
            Exit;
         end
      else
         begin
            Result := S_OK;
         end;
   finally
      SysFreeString(oleStrUrl);
   end;
end;

procedure TBSCB.ClearAll;
begin
   Binding := nil;
   fmoniker := nil;
   fbindctx := nil;
   FGlobalData := 0;
   FTotalRead := 0;
   FDataAvailable := 0;
   FStartTime := 0;
end;

function TBSCB._AddRef: Integer;
begin
   Result := InterlockedIncrement(FSender.FRefCount);
end;

function TBSCB._Release: Integer;
begin
   Result := InterlockedDecrement(Fsender.FRefCount);
   if Result = 0 then
      Destroy;
end;

function TBSCB.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
   if GetInterface(IID, Obj) then
      Result := 0
   else
      Result := E_NOINTERFACE;
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
         if Result then
            Info := C;
      end
   else
      Result := False;
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
         if Result then
            Info := Buf;
      end
   else
      Result := False;
   HttpInfo := nil;
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
         BufferLength := SizeOf(TSystemTime);
         Result := not Boolean(httpInfo.QueryInfo(dwOption or HTTP_QUERY_FLAG_SYSTEMTIME,
            @SysTime, BufferLength, dwflags, Reserved));
         if Result then
            Info := SystemTimeToDateTime(SysTime);
      end
   else
      Result := False;
   HttpInfo := nil;
end;

function TBSCB.GetBindResult(out clsidProtocol: TCLSID; out dwResult: DWORD;
   out szResult: POLEStr; dwReserved: DWORD): HResult;
begin
   Result := Binding.GetBindResult(clsidProtocol, dwResult, szResult, 0);
end;

constructor TIEDownload.Create(AOwner: TComponent);
begin
   inherited;
   FCodepageOption := Ansi;
   FProxySettings := TProxySettings.Create;
   FProxySettings.FPort := 80;
   FUrlEncodeOptions := [];
   FDefaultProtocol := 'http://';
   FObjList := TObjectList.Create;
   FAdditionalHeader := TStringlist.Create;
   FAdditionalHeader.Add('Content-Type: application/x-www-form-urlencoded ');
   FRange := TRange.Create;
   FSecurity := TSecurity.Create;
   FRefcount := 1;
   FBindInfoOptions := [Asynchronous, AsyncStorage, PullData, NoWriteCache, GetNewestVersion];
   FBindVerbOption := Get; //Method;
   FCodePageOption := Ansi; //Ansi Code page;
   UpdateUserAgent;
end;

procedure TIEDownload.Loaded;
begin
   inherited Loaded;
   UpdateUserAgent;
   if FProxySettings.FAutoLoadProxy then
      FProxySettings.SetProxy(FullUserAgent, FProxySettings.FServer);
   Busy := False;
   FBusy := Busy;
end;

destructor TIEDownload.Destroy; //bsalsa2
begin
   Busy := False;
   FBusy := Busy;
   if FProxySettings.FAutoLoadProxy then
      FProxySettings.SetProxy('', '');
   FProxySettings.Free;
   FObjlist.Free;
   FRange.Free;
   FSecurity.Free;
   FAdditionalHeader.Free;
   inherited;
end;

procedure TIEDownload.UpdateUserAgent;
begin
   FullUserAgent := 'User-agent: Mozilla/4.0 (Compatible ' + FUserAgent + ' by IEDownload- from: ' + SITE_ADDRESS + ')' + #13#10
end;

procedure TIEDownload.Cancel;
begin
   FCancel := True;
end;

procedure TIEDownload.Cancel(Item: TBSCB);
begin
   Item.FCancel := True;
end;

procedure TIEDownload.FillInfo(var Info: TInfo); //bs
begin
   with info do
      begin
         Sender := Self;
         AdditionalHeader.AddStrings(FAdditionalHeader);
         BindVerbValue := FBindVerbValue;
         BindInfoValue := FBindInfoValue;
         Password := FPassWord;
         UserName := FUserName;
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
         UserAgent := FullUserAgent;
      end;
end;

procedure TIEDownload.Go(Url, FileName: WideString); //bsalsa2
var
   Info: TInfo;
   bs: TBscb;
begin
   FCancel := False;
   FURL := URL;
   FURL := AddPrefixHttp;
   Info.Url := StringToOleStr(FURL);
   FSaveFileAs := FileName;
   FSaveFileAs := DoPath;
   Info.FileName := FSaveFileAs;
   Info.AdditionalHeader := TStringlist.Create;
   FillInfo(Info);
   BS := TBSCB.Create(Info);
   if FBindInfoValue <> FBindInfoValue or BINDF_ASYNCHRONOUS then
      BS.Free
   else
      FObjList.Add(BS);
end;

procedure TIEDownload.Go(URL: WideString); //bsalsa2
var
   Info: TInfo;
   bs: TBscb;
begin
   FCancel := False;
   FURL := URL;
   FURL := AddPrefixHttp;
   Info.Url := StringToOleStr(FURL);
   Info.FileName := '';
   Info.AdditionalHeader := TStringlist.Create;
   FillInfo(Info);
   BS := TBSCB.Create(Info);
   if FBindInfoValue <> FBindInfoValue or BINDF_ASYNCHRONOUS then
      BS.Free
   else
      FObjList.Add(BS);
end;

procedure TIEDownload.DownloadUrlToStream(URL: WideString); //bsalsa2
var
   Info: TInfo;
   bs: TBscb;
begin
   FCancel := False;
   FURL := URL;
   FURL := AddPrefixHttp;
   Info.Url := StringToOleStr(FURL);
   Info.FileName := '';
   Info.AdditionalHeader := TStringlist.Create;
   FillInfo(Info);
   BS := TBSCB.Create(Info);
   if FBindInfoValue <> FBindInfoValue or BINDF_ASYNCHRONOUS then
      BS.Free
   else
      FObjList.Add(BS);
end;

procedure TIEDownload.DownloadUrlToFile(URL: WideString); //bsalsa2
var
   Info: TInfo;
   bs: TBscb;
begin
   FCancel := False;
   FURL := URL;
   FURL := AddPrefixHttp;
   Info.Url := StringToOleStr(FURL);
   FSaveFileAs := DoPath;
   Info.FileName := FSaveFileAs;
   Info.AdditionalHeader := TStringlist.Create;
   FillInfo(Info);
   BS := TBSCB.Create(Info);
   if FBindInfoValue <> FBindInfoValue or BINDF_ASYNCHRONOUS then
      BS.Free
   else
      FObjList.add(bs);
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

procedure TIEDownload.SetUrlEncodeOptions(const Value: TUrlEncodeOptions);
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

procedure TIEDownload.SetBindInfoOptions(const Value: TBindInfoOptions);
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

procedure TIEDownload.SetBindVerbOption(const Value: TBindVerbOption);
begin
   FBindVerbOption := Value;
   case FBindVerbOption of
      Get: FBindVerbValue := BINDVERB_GET;
      Put: FBindVerbValue := BINDVERB_PUT;
      Post: FBindVerbValue := BINDVERB_POST;
      Custom: FBindVerbValue := BINDVERB_CUSTOM;
   end;
end;

procedure TIEDownload.SetAdditionalHeader(const Value: Tstrings);
begin
   FAdditionalHeader.Assign(Value);
end;

function TIEDownload.AddPrefixHttp: Widestring;
var
   st: string;
begin
   st := AnsiUpperCase(FURL);
   if (AnsiPos('HTTP', st) <> 0)
      then
      Result := FURL
   else
      Result := FDefaultProtocol + FURL;
end;

function TIEDownload.DoPath: WideString;
begin
   if FSaveFileAs = '' then
      FSaveFileAs := ExtractFilePath(Application.ExeName) + Application.Title + '.html';
   Result := FSaveFileAs;
end;

procedure TIEDownload.SetDefaultProtocol(const Value: string);
begin
   FDefaultProtocol := (Value);
   if fDefaultProtocol = '' then
      FDefaultProtocol := 'http://';
end;

procedure TIEDownload.BusyChange;
begin
   if Assigned(FOnBusy) then
      FOnBusy(Self);
end;

procedure TBSCB.UpdateEvents(Code: integer; BusyState: Boolean; Sender: TBSCB; //bsalsa
   ulProgress, ulProgressMax: ULONG; szStatusText: LPCWSTR; Downloaded, ElapsedTime,
   Speed, RemainingTime, Status: string; Stream: TStream);
begin
   with FSender do
      begin
         FBusy := BusyState;
         Busy := FBusy;
         BusyChange;
         if (Code >= 0) and (Code < 99) then
            if Assigned(FOnStatusText) then
               FOnStatusText(Self, BindStatusText(Code));
         if (Code = 0) or ((Code > 99) and (Code < 506)) then
            if Assigned(FOnRespondText) then
               FOnRespondText(Self, ResponseCodeText(Code));
         if (Code < -10000) or (Code > 12000) then
            if Assigned(FOnErrorText) then
               begin
                  FOnErrorText(Self, ErrorText(Code));
                  if Assigned(FOnRespondText) then
                     FOnRespondText(Self, '');
                  if Assigned(FOnStatusText) then
                     FOnStatusText(Self, 'Download Error.');
               end;
         if Assigned(FOnComplete) then
            FOnComplete(Self, Stream, Code);
         if Assigned(FOnProgress) then
            OnProgress(Sender, ulProgress, ulProgressMax, Code, szStatusText,
               Downloaded, ElapsedTime, Speed, RemainingTime, Status);
      end;
end;

//--TProxy Section--------------------------------------------------------------
type
   INTERNET_PER_CONN_OPTION = record
      dwOption: DWORD;
      Value: record
         case Integer of
            1: (dwValue: DWORD);
            2: (pszValue: PAnsiChar);
            3: (ftValue: TFileTime);
      end;
   end;
   LPINTERNET_PER_CONN_OPTION = ^INTERNET_PER_CONN_OPTION;
   INTERNET_PER_CONN_OPTION_LIST = record
      dwSize: DWORD;
      pszConnection: LPTSTR;
      dwOptionCount: DWORD;
      dwOptionError: DWORD;
      pOptions: LPINTERNET_PER_CONN_OPTION;
   end;
   LPINTERNET_PER_CONN_OPTION_LIST = ^INTERNET_PER_CONN_OPTION_LIST;

procedure TProxySettings.SetProxy(FullUserAgent, ProxyServer: string); //mladen
var
   list: INTERNET_PER_CONN_OPTION_LIST;
   dwBufSize: DWORD;
   hInternet: Pointer;
   Options: array[1..3] of INTERNET_PER_CONN_OPTION;
const
   INTERNET_PER_CONN_FLAGS = 1;
   INTERNET_PER_CONN_PROXY_SERVER = 2;
   INTERNET_PER_CONN_PROXY_BYPASS = 3;
   INTERNET_PER_CONN_AUTOCONFIG_URL = 4;
   INTERNET_PER_CONN_AUTODISCOVERY_FLAGS = 5;
   PROXY_TYPE_DIRECT = $00000001; // direct to net
   PROXY_TYPE_PROXY = $00000002; // via named proxy
   PROXY_TYPE_AUTO_PROXY_URL = $00000004; // autoproxy URL
   PROXY_TYPE_AUTO_DETECT = $00000008; // use autoproxy detection
   INTERNET_OPTION_REFRESH = 37;
   INTERNET_OPTION_PER_CONNECTION_OPTION = 75;
   INTERNET_OPTION_SETTINGS_CHANGED = 39;
begin
   dwBufSize := sizeof(list);
   list.dwSize := sizeof(list);
   list.pszConnection := nil;
   list.dwOptionCount := High(Options); // the highest index of the array (in this case 3)
   Options[1].dwOption := INTERNET_PER_CONN_FLAGS;
   Options[1].Value.dwValue := PROXY_TYPE_DIRECT or PROXY_TYPE_PROXY;
   Options[2].dwOption := INTERNET_PER_CONN_PROXY_SERVER;
   Options[2].Value.pszValue := PChar(ProxyServer);
   Options[3].dwOption := INTERNET_PER_CONN_PROXY_BYPASS;
   Options[3].Value.pszValue := '<Download>'; // '<Download>' instead of 'Download'
   list.pOptions := @Options;
   hInternet := InternetOpen(PChar(FullUserAgent), INTERNET_OPEN_TYPE_DIRECT, nil, nil, 0);
   InternetSetOption(hInternet, INTERNET_OPTION_PER_CONNECTION_OPTION, @list, dwBufSize);
   InternetSetOption(hInternet, INTERNET_OPTION_REFRESH, nil, 0);
   InternetCloseHandle(hInternet);
end;
// End of Proxy-----------------------------------------------------------------

initialization
   coInitialize(nil);
finalization
   coUninitialize;
end.
