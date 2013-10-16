{*******************************************************************************

  AutoUpgrader Professional
  FILE: auHTTP.pas - auHTTP component. Used as base class for acAutoUpgrader
          in the AppControls v2.3 and later

  Copyright (c) 1998-2004 UtilMind Solutions
  All rights reserved.
  E-Mail: info@utilmind.com
  WWW: http://www.utilmind.com, http://www.appcontrols.com

  The entire contents of this file is protected by International Copyright
Laws. Unauthorized reproduction, reverse-engineering, and distribution of all
or any portion of the code contained in this file is strictly prohibited and
may result in severe civil and criminal penalties and will be prosecuted to
the maximum extent possible under the law.

*******************************************************************************}
{$I auDefines.inc}

unit auHTTP;

interface

uses
  Windows, Classes, Graphics, WinInet,
  auThread, auUtils;

const
  auDefaultProxyPort = 8080;
  auDefaultProxyBypass = '127.0.0.1;';
  DEF_TRANSFERBUFFERSIZE = 4096;
  TEXTHTML = 'text/html';
  DEF_ACCEPT_TYPES = TEXTHTML + ', */*';
{$IFDEF D4}
  S_PIC = 'pic';
{$ELSE}
{  HTTP Response Status Codes: }
  HTTP_STATUS_CONTINUE            = 100;    { OK to continue with request }
  HTTP_STATUS_SWITCH_PROTOCOLS    = 101;    { server has switched protocols in upgrade header }
  HTTP_STATUS_OK                  = 200;    { request completed }
  HTTP_STATUS_CREATED             = 201;    { object created, reason = new URI }
  HTTP_STATUS_ACCEPTED            = 202;    { async completion (TBS) }
  HTTP_STATUS_PARTIAL             = 203;    { partial completion }
  HTTP_STATUS_NO_CONTENT          = 204;    { no info to return }
  HTTP_STATUS_RESET_CONTENT       = 205;    { request completed, but clear form }
  HTTP_STATUS_PARTIAL_CONTENT     = 206;    { partial GET furfilled }
  HTTP_STATUS_AMBIGUOUS           = 300;    { server couldn't decide what to return }
  HTTP_STATUS_MOVED               = 301;    { object permanently moved }
  HTTP_STATUS_REDIRECT            = 302;    { object temporarily moved }
  HTTP_STATUS_REDIRECT_METHOD     = 303;    { redirection w/ new access method }
  HTTP_STATUS_NOT_MODIFIED        = 304;    { if-modified-since was not modified }
  HTTP_STATUS_USE_PROXY           = 305;    { redirection to proxy, location header specifies proxy to use }
  HTTP_STATUS_REDIRECT_KEEP_VERB  = 307;    { HTTP/1.1: keep same verb }
  HTTP_STATUS_BAD_REQUEST         = 400;    { invalid syntax }
  HTTP_STATUS_DENIED              = 401;    { access denied }
  HTTP_STATUS_PAYMENT_REQ         = 402;    { payment required }
  HTTP_STATUS_FORBIDDEN           = 403;    { request forbidden }
  HTTP_STATUS_NOT_FOUND           = 404;    { object not found }
  HTTP_STATUS_BAD_METHOD          = 405;    { method is not allowed }
  HTTP_STATUS_NONE_ACCEPTABLE     = 406;    { no response acceptable to client found }
  HTTP_STATUS_PROXY_AUTH_REQ      = 407;    { proxy authentication required }
  HTTP_STATUS_REQUEST_TIMEOUT     = 408;    { server timed out waiting for request }
  HTTP_STATUS_CONFLICT            = 409;    { user should resubmit with more info }
  HTTP_STATUS_GONE                = 410;    { the resource is no longer available }
  HTTP_STATUS_AUTH_REFUSED        = 411;    { couldn't authorize client }
  HTTP_STATUS_PRECOND_FAILED      = 412;    { precondition given in request failed }
  HTTP_STATUS_REQUEST_TOO_LARGE   = 413;    { request entity was too large }
  HTTP_STATUS_URI_TOO_LONG        = 414;    { request URI too long }
  HTTP_STATUS_UNSUPPORTED_MEDIA   = 415;    { unsupported media type }
  HTTP_STATUS_SERVER_ERROR        = 500;    { internal server error }
  HTTP_STATUS_NOT_SUPPORTED       = 501;    { required not supported }
  HTTP_STATUS_BAD_GATEWAY         = 502;    { error response received from gateway }
  HTTP_STATUS_SERVICE_UNAVAIL     = 503;    { temporarily overloaded }
  HTTP_STATUS_GATEWAY_TIMEOUT     = 504;    { timed out waiting for gateway }
  HTTP_STATUS_VERSION_NOT_SUP     = 505;    { HTTP version not supported }
  HTTP_STATUS_FIRST               = HTTP_STATUS_CONTINUE;
  HTTP_STATUS_LAST                = HTTP_STATUS_VERSION_NOT_SUP;
{$ENDIF}
  HTTP_STATUS_RANGE_NOT_SATISFIABLE = 416;
  // misc strings (for use in application )
  STR_DownloadError   = 'Download Error';
  STR_HostUnreachable = 'Host Unreachable';
  STR_ConnectionLost  = 'Connection Lost';

type
  SetOfChar = set of Char;

  { TauLoginComponent }
  TauLoginComponent = class(TComponent)
  private
    procedure ReadData(Stream: TStream);
    procedure WriteData(Stream: TStream);
  protected
    FLoginUsername, FLoginPassword: String;
      
    procedure DefineProperties(Filer: TFiler); override;
  end;

  { TauHTTP }
  TauHTTPProgressEvent = procedure(Sender: TObject; const ContentType: String;
                                   DataSize, BytesRead,
                                   ElapsedTime, EstimatedTimeLeft: Integer;
                                   PercentsDone: Byte; TransferRate: Single;
                                   Stream: TStream) of object;
{$IFNDEF IE3}
  TauHTTPUploadProgressEvent  = procedure(Sender: TObject;
                                   DataSize, BytesTransferred,
                                   ElapsedTime, EstimatedTimeLeft: Integer;
                                   PercentsDone: Byte; TransferRate: Single) of object;
  TauHTTPUploadFieldRequest   = procedure(Sender: TObject; FileIndex: Word; UploadStream: TMemoryStream; var FieldName, FileName: String) of object;
{$ENDIF}
  TauHTTPHeaderInfoEvent      = procedure(Sender: TObject; ErrorCode: Integer; const RawHeadersCRLF, ContentType, ContentLanguage, ContentEncoding: String;
                                   ContentLength: Integer; const Location: String; const Date, LastModified, Expires: TDateTime; const ETag: String; var ContinueDownload: Boolean) of object;
  TauHTTPStatusChanged        = procedure(Sender: TObject; StatusID: Cardinal; const StatusStr: String) of object;
  TauHTTPRedirected           = procedure(Sender: TObject; const NewURL: String) of object;
  TauHTTPDoneEvent            = procedure(Sender: TObject; const ContentType: String; FileSize: Integer; Stream: TStream) of object;
  TauHTTPConnLostEvent        = procedure(Sender: TObject; const ContentType: String; FileSize, BytesRead: Integer; Stream: TStream) of object;
  TauHTTPErrorEvent           = procedure(Sender: TObject; ErrorCode: Integer; Stream: TStream) of object;
  TauHTTPPasswordRequestEvent = procedure(Sender: TObject; const Realm: String; var TryAgain: Boolean) of object;
  TauHTTPProxyAuthenticationEvent = procedure(Sender: TObject; var ProxyUsername, ProxyPassword: String; var TryAgain: Boolean) of object;
  TauHTTPBeforeSendRequest = procedure(Sender: TObject; hRequest: hInternet) of object;

{$IFNDEF IE3}
  TauHTTPPOSTMethod = (pmFormURLEncoded, pmMultipartFormData);
{$ENDIF}
  TauHTTPRequestMethod = (rmAutoDetect, rmGET, rmPOST);
  TauHTTPAccessType = (atPreconfig, atDirect, atUseProxy);
  TauHTTPProxy = class(TPersistent)
  private
    FAccessType: TauHTTPAccessType;
    FProxyPort: Integer;
    FProxyServer: String;
    FProxyBypass: String;
    FProxyUsername: String;
    FProxyPassword: String;

    function IsUseProxy: Boolean;
  public
    constructor Create;

    procedure Assign(Source: TPersistent); override;
  published
    property AccessType: TauHTTPAccessType read FAccessType write FAccessType default atPreconfig;
    property ProxyPort: Integer read FProxyPort write FProxyPort default auDefaultProxyPort;
    property ProxyServer: String read FProxyServer write FProxyServer stored IsUseProxy;
    property ProxyBypass: String read FProxyBypass write FProxyBypass stored IsUseProxy;
    property ProxyUsername: String read FProxyUsername write FProxyUsername;
    property ProxyPassword: String read FProxyPassword write FProxyPassword;
  end;

  TauHTTPRange = class(TPersistent)
  private
    FStartRange, FEndRange: Cardinal;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property StartRange: Cardinal read FStartRange write FStartRange default 0;
    property EndRange: Cardinal read FEndRange write FEndRange default 0;
  end;

  TauHTTPTimeouts = class(TPersistent)
  private
    FConnectTimeout, FReceiveTimeout, FSendTimeout: DWord;
  public
    procedure Assign(Source: TPersistent); override;  
  published
    property ConnectTimeout: DWord read FConnectTimeout write FConnectTimeout default 0;
    property ReceiveTimeout: DWord read FReceiveTimeout write FReceiveTimeout default 0;
    property SendTimeout: DWord read FSendTimeout write FSendTimeout default 0;
  end;

  TauOutputFileAttributes = class(TPersistent)
  private
    FComplete, FIncomplete: TauFileAttributes;

    procedure SetComplete(const Value: TauFileAttributes);
    procedure SetIncomplete(const Value: TauFileAttributes);
  protected
    procedure AttributesChanged; dynamic;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
  published
    property Complete: TauFileAttributes read FComplete write SetComplete default [atrArchive];
    property Incomplete: TauFileAttributes read FIncomplete write SetIncomplete default [atrArchive, atrTemporary];
  end;

  { TauFileStream - FileStream able to write to opened file (no read lock) }
  TauFileStream = class(THandleStream)
  public
    constructor Create(const FileName: String; CreateNew: Boolean; TestFileAttributes: Boolean {$IFDEF D4} = True {$ENDIF});
    destructor Destroy; override;
  end;

  TauBufferSize = 255..MaxInt;
  TauInternetOption = (ioIgnoreCertificateInvalid, ioIgnoreCertificateDateInvalid,
                       ioIgnoreUnknownCertificateAuthority,
                       ioIgnoreRedirectToHTTP, ioIgnoreRedirectToHTTPS,
                       ioKeepConnection, ioNoAuthentication,
                       ioNoAutoRedirect, ioNoCookies);
  TauInternetOptions = set of TauInternetOption;
  TauCacheOption   = (coAlwaysReload, coReloadIfNoExpireInformation,
                      coReloadUpdatedObjects, coPragmaNoCache,
                      coNoCacheWrite, coCreateTempFilesIfCantCache,
                      coUseCacheIfNetFail);
  TauCacheOptions  = set of TauCacheOption;
  TauCustomHTTP = class(TauLoginComponent)
  private
    FAddHeaders: TStrings;
    FAcceptTypes, FAgent,
    FOutputFileName: String;
    FOutputFileAttributes: TauOutputFileAttributes;
    FURL, FPostData, FReferer: String;
    FCacheOptions: TauCacheOptions;
    FInternetOptions: TauInternetOptions;
    FRange: TauHTTPRange;
    FTimeouts: TauHTTPTimeouts;
    FTransferBufferSize: TauBufferSize;
{$IFNDEF IE3}
    FPOSTMethod: TauHTTPPOSTMethod;
{$ENDIF}
    FRequestMethod: TauHTTPRequestMethod;
    FProxy: TauHTTPProxy;
{$IFNDEF IE3}
    FShowGoOnlineMessage: Boolean;
{$ENDIF}
    FWorkOffline: Boolean;
    FData: Pointer;

    // success events
    FOnBeforeSendRequest: TauHTTPBeforeSendRequest;
    FOnHeaderInfo: TauHTTPHeaderInfoEvent;
    FOnDone: TauHTTPDoneEvent;
    FOnDoneInterrupted: TNotifyEvent;
    FOnProgress: TauHTTPProgressEvent;
    FOnStatusChanged: TauHTTPStatusChanged;
    FOnRedirected: TauHTTPRedirected;
{$IFNDEF IE3}
    FOnUploadProgress: TauHTTPUploadProgressEvent;
    FOnUploadFieldRequest: TauHTTPUploadFieldRequest;
{$ENDIF}
    // error events
    FOnAnyError: TNotifyEvent;
    FOnAborted: TNotifyEvent;
    FOnConnLost: TauHTTPConnLostEvent;
    FOnHostUnreachable: TNotifyEvent;      // no connection
    FOnHTTPError: TauHTTPErrorEvent;       // read error
    FOnOutputFileError: TNotifyEvent;    
    FOnPasswordRequest: TauHTTPPasswordRequestEvent;
    FOnProxyAuthenticationRequest: TauHTTPProxyAuthenticationEvent;
    FOnWaitTimeoutExpired: TauThreadWaitTimeoutExpired;

    // internal events
{$IFDEF USEINTERNAL}
    FOnBeforeCreateFile, FOnAfterCreateFile: TNotifyEvent;
{$ENDIF}

    // internal variables
    FBusy, FRealBusy: Boolean;
    FThread: TauCustomThread;
    HTTPStream: TStream;
    HTTPSuccess, HTTPTryAgain, HTTPOutputToFile,
    HTTPContinueDownload, HTTPDeleteOutputFileOnAbort: Boolean;
    HTTPData: Pointer; // read buffer
    HTTPFileSize, HTTPBytesTransferred, HTTPStartTime,
    HTTPInitStartRange, HTTPInitEndRange: Cardinal;
{$IFNDEF IE3}
    HTTPUploadRequestHeader: String;
{$ENDIF}

    // WinInet handles
    hSession, hConnect, hRequest: hInternet;
    hFile: hFile;

    procedure SetAddHeaders(Value: TStrings);
    function  GetSuspended: Boolean;
    procedure SetSuspended(Value: Boolean);
    function  GetThreadPriority: TThreadPriority;
    procedure SetThreadPriority(Value: TThreadPriority);
    function  GetWaitThread: Boolean;
    procedure SetWaitThread(Value: Boolean);
    function  GetWaitTimeout: Integer;
    procedure SetWaitTimeout(Value: Integer);
    function  GetThreadBusy: Boolean;
    function  GetFreeOnTerminate: Boolean;
    procedure SetFreeOnTerminate(Value: Boolean);
    function  GetFileName: String;
    function  GetHostName: String;

    function  IsNotDefaultAcceptTypes: Boolean;

    procedure PrepareProgressParams;
    procedure CloseHTTPHandles;
    procedure AbortAndReleaseStreams;

    // thread management
    procedure ThreadExecute(Sender: TObject);
    procedure ThreadException(Sender: TObject);
    procedure ThreadDone(Sender: TObject);
    procedure ThreadWaitTimeoutExpired(Sender: TObject; var TerminateThread: Boolean);

    // synchronized methods
    procedure CallAborted;
    procedure CallHeaderInfo;
    procedure CallProgress;
{$IFNDEF IE3}
    procedure CallUploadProgress;
{$ENDIF}
    procedure CallPasswordRequest;
    procedure CallProxyAuthenticationRequest;
{$IFDEF USEINTERNAL}
    procedure CallBeforeCreateFile;
    procedure CallAfterCreateFile;
{$ENDIF}
  protected
    // headers
    HTTPRawHeadersCRLF, HTTPContentType,
    HTTPContentLanguage, HTTPContentEncoding, HTTPLocation, HTTPETag: String;
    HTTPDate, HTTPLastModified, HTTPExpires: TDateTime;

    // for OnProgres/OnUploadProgress events
    ProgressPercentsDone: Byte;
    ProgressElapsedTime, ProgressEstimatedTime: Cardinal;
    ProgressTransferRate: Single;

    procedure DoAnyError;
    procedure ReleaseHTTPStream;
  public
    HTTPErrorCode: Integer;

    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    // public methods
    function  Read{$IFDEF D4}(ForceWaitThread: Boolean = False){$ENDIF}: Boolean;
    function  ReadRange(StartRange: Cardinal; EndRange: Cardinal {$IFDEF D4} = 0; ForceWaitThread: Boolean = False{$ENDIF}): Boolean;
{$IFNDEF IE3}
    function  Upload(NumberOfFields: Word): Boolean;

    function  BeginPrepareUpload: Boolean;
    procedure UploadStream(const FieldName: String; UploadStream: TStream; const FileName: String {$IFDEF D4} = '' {$ENDIF});
    procedure UploadString(const FieldName, StrValue: String);
    procedure UploadInteger(const FieldName: String; IntValue: Integer);
    procedure UploadBoolean(const FieldName: String; BoolValue: Boolean);
    procedure UploadPicture(const FieldName: String; Picture: TPicture;
      const FileName: String {$IFDEF D4} = S_PIC {$ENDIF});
{$IFDEF USEJPEG}
    procedure UploadThumbnailedPicture(const FieldName: String; Picture: TPicture;
      ThumbnailWidth: Word {$IFDEF D4} = DefThumbnailWidth {$ENDIF};
      ThumbnailHeight: Word {$IFDEF D4} = DefThumbnailHeight {$ENDIF};
      JPEGCompressionQuality: Byte {$IFDEF D4} = 90 {$ENDIF};
      WriteNormalImageIfThumbnailHaveBiggerSize: Boolean {$IFDEF D4} = True {$ENDIF};
      const FileName: String {$IFDEF D4} = S_PIC {$ENDIF});
{$ENDIF}
    procedure EndPrepareUpload;
{$ENDIF}
    procedure Abort(DeleteOutputFile: Boolean {$IFDEF D4} = False {$ENDIF}; HardTerminate: Boolean {$IFDEF D4} = False {$ENDIF});

    // new methods (AppControls v3.6.1)
    // works only for binary files. OutputFileName MUST BE SPECIFIED!!
    procedure Pause; // same as Abort(False)
    function  Resume: Boolean;
    function IsGlobalOffline: Boolean;

    // from TacLoginComponent
    property Username: String read FLoginUsername write FLoginUsername stored False;
    property Password: String read FLoginPassword write FLoginPassword stored False;

    // optional properties
    property Busy: Boolean read FBusy;
    property ThreadBusy: Boolean read GetThreadBusy;
    property FreeOnTerminate: Boolean read GetFreeOnTerminate write SetFreeOnTerminate;
    property FileName: String read GetFileName;
    property HostName: String read GetHostName;
    property Thread: TauCustomThread read FThread;

    // public properties
    property AcceptTypes: String read FAcceptTypes write FAcceptTypes stored IsNotDefaultAcceptTypes;
    property AddHeaders: TStrings read FAddHeaders write SetAddHeaders;
    property Agent: String read FAgent write FAgent;
    property Proxy: TauHTTPProxy read FProxy write FProxy;
{$IFNDEF IE3}
    property ShowGoOnlineMessage: Boolean read FShowGoOnlineMessage write FShowGoOnlineMessage default False;    
{$ENDIF}
    property CacheOptions: TauCacheOptions read FCacheOptions write FCacheOptions default [coReloadIfNoExpireInformation, coReloadUpdatedObjects, coCreateTempFilesIfCantCache];
    property InternetOptions: TauInternetOptions read FInternetOptions write FInternetOptions default [ioKeepConnection];
    property OutputFileName: String read FOutputFileName write FOutputFileName;
    property OutputFileAttributes: TauOutputFileAttributes read FOutputFileAttributes write FOutputFileAttributes;
    property URL: String read FURL write FURL;
    property POSTData: String read FPOSTData write FPOSTData;
    property Range: TauHTTPRange read FRange write FRange;
    property Referer: String read FReferer write FReferer;
    property RequestMethod: TauHTTPRequestMethod read FRequestMethod write FRequestMethod default rmAutoDetect;
    property Timeouts: TauHTTPTimeouts read FTimeouts write FTimeouts;
    property TransferBufferSize: TauBufferSize read FTransferBufferSize write FTransferBufferSize default DEF_TRANSFERBUFFERSIZE; // 4Kb
    property WorkOffline: Boolean read FWorkOffline write FWorkOffline default False;
    property Data: Pointer read FData write FData stored False;

    // thread properties
    property Suspended: Boolean read GetSuspended write SetSuspended;
    property ThreadPriority: TThreadPriority read GetThreadPriority write SetThreadPriority default tpNormal;
    property WaitThread: Boolean read GetWaitThread write SetWaitThread default False;
    property WaitTimeout: Integer read GetWaitTimeout write SetWaitTimeout default 0;

    // public events
    property OnBeforeSendRequest: TauHTTPBeforeSendRequest read FOnBeforeSendRequest write FOnBeforeSendRequest;
    property OnHeaderInfo: TauHTTPHeaderInfoEvent read FOnHeaderInfo write FOnHeaderInfo;    
    property OnDone: TauHTTPDoneEvent read FOnDone write FOnDone;
    property OnProgress: TauHTTPProgressEvent read FOnProgress write FOnProgress;
    property OnStatusChanged: TauHTTPStatusChanged read FOnStatusChanged write FOnStatusChanged;
    property OnRedirected: TauHTTPRedirected read FOnRedirected write FOnRedirected;
{$IFNDEF IE3}
    property OnUploadProgress: TauHTTPUploadProgressEvent read FOnUploadProgress write FOnUploadProgress;
    property OnUploadFieldRequest: TauHTTPUploadFieldRequest read FOnUploadFieldRequest write FOnUploadFieldRequest;
{$ENDIF}

    property OnAnyError: TNotifyEvent read FOnAnyError write FOnAnyError;
    property OnAborted: TNotifyEvent read FOnAborted write FOnAborted;
    property OnConnLost: TauHTTPConnLostEvent read FOnConnLost write FOnConnLost;
    property OnDoneInterrupted: TNotifyEvent read FOnDoneInterrupted write FOnDoneInterrupted;
    property OnOutputFileError: TNotifyEvent read FOnOutputFileError write FOnOutputFileError;
    property OnPasswordRequest: TauHTTPPasswordRequestEvent read FOnPasswordRequest write FOnPasswordRequest;
    property OnProxyAuthenticationRequest: TauHTTPProxyAuthenticationEvent read FOnProxyAuthenticationRequest write FOnProxyAuthenticationRequest;
    property OnHostUnreachable: TNotifyEvent read FOnHostUnreachable write FOnHostUnreachable;
    property OnHTTPError: TauHTTPErrorEvent read FOnHTTPError write FOnHTTPError;
    property OnWaitTimeoutExpired: TauThreadWaitTimeoutExpired read FOnWaitTimeoutExpired write FOnWaitTimeoutExpired;
    // internal events
{$IFDEF USEINTERNAL}
    property OnBeforeCreateFile: TNotifyEvent read FOnBeforeCreateFile write FOnBeforeCreateFile;
    property OnAfterCreateFile: TNotifyEvent read FOnAfterCreateFile write FOnAfterCreateFile;
{$ENDIF}
  end;

  // TauHTTPPragmaNoCache
  TauHTTPPragmaNoCache = class(TauCustomHTTP)
  public
    constructor Create(aOwner: TComponent); override;

    property CacheOptions default [coReloadIfNoExpireInformation, coReloadUpdatedObjects, coPragmaNoCache];
  end;

  // TauHTTP
  TauHTTP = class(TauCustomHTTP)
  published
    property AcceptTypes;
    property AddHeaders;
    property Agent;
    property Proxy;
    property URL;
    property Username;
    property CacheOptions;
    property InternetOptions;
    property OutputFileName;
    property OutputFileAttributes;
    property Password;
    property POSTData;
    property Range;
    property Referer;
    property RequestMethod;
{$IFNDEF IE3}
    property ShowGoOnlineMessage;
{$ENDIF}
{$IFDEF USEINTERNAL}
    property Suspended;
{$ENDIF}    
    property Timeouts;
    property ThreadPriority;
    property TransferBufferSize;
    property WaitThread;
    property WaitTimeout;
    property WorkOffline;

    // success
    property OnBeforeSendRequest;
    property OnHeaderInfo;
    property OnDone;
    property OnDoneInterrupted;
    property OnOutputFileError;
    property OnProgress;
{$IFDEF USEINTERNAL}
    property OnStatusChanged;
{$ENDIF}    
    property OnRedirected;
{$IFNDEF IE3}
    property OnUploadProgress;
    property OnUploadFieldRequest;
{$ENDIF}
    // errors
    property OnAnyError;
    property OnAborted;
    property OnConnLost;
    property OnHTTPError;
    property OnHostUnreachable;
    property OnPasswordRequest;
    property OnProxyAuthenticationRequest;
    property OnWaitTimeoutExpired;    
  end;

function HTTPReadString(const URL: String; Timeout: Integer {$IFDEF D4} = 0 {$ENDIF}): String;
{ Encodes the string in manner how the address visible in the browser line
 (Turns unsafe characters to escape codes) }
function URLEncode(const Str: String): String;
{ Decodes the string from manner how the address visible in the browser line to a normal string
  (Unescapes all codes and turns them to normal characters) }
function URLDecode(Str: String): String;
function ParseURL(URL: String; var Protocol, HostName, URLPath,
  Username, Password, ExtraInfo: String; var Port: Word): Boolean;

implementation

uses {$IFDEF TRIAL} Forms, {$ENDIF} SysUtils, {$IFDEF D6} RTLConsts {$ELSE} Consts {$ENDIF};

{$IFDEF TRIAL}
var
  NotifyDone: Boolean = False;
{$ENDIF}

const
  HostUnreachableCode = -1;
  UnsafeURLChars = ['*', '#', '%', '<', '>', '+', ' '];
  DEF_CONTENT_TYPE = 'Content-Type: application/x-www-form-urlencoded';
  DEF_CONTENT_TYPE_SIZE = 47;

  {$IFNDEF D4}
  INTERNET_FLAG_NEED_FILE                = $00000010; // need a file for this request
  INTERNET_FLAG_FORMS_SUBMIT             = $00000040; // this is a forms submit
  INTERNET_FLAG_CACHE_ASYNC              = $00000080; // ok to perform lazy cache-write
  INTERNET_FLAG_PRAGMA_NOCACHE           = $00000100; // asking wininet to add "pragma: no-cache"
  INTERNET_FLAG_NO_UI                    = $00000200; // no cookie popup
  INTERNET_FLAG_HYPERLINK                = $00000400; // asking wininet to do hyperlinking semantic which works right for scripts
  INTERNET_FLAG_RESYNCHRONIZE            = $00000800; // asking wininet to update an item if it is newer
  INTERNET_FLAG_CACHE_IF_NET_FAIL        = $00010000; // return cache file if net request fails
  INTERNET_FLAG_NO_AUTH                  = $00040000; // no automatic authentication handling
  INTERNET_FLAG_NO_COOKIES               = $00080000; // no automatic cookie handling
  INTERNET_OPTION_PROXY_USERNAME         = 43;
  INTERNET_OPTION_PROXY_PASSWORD         = 44;
  INTERNET_OPTION_CONNECTED_STATE        = 50;
  INTERNET_STATE_DISCONNECTED_BY_USER    = $00000010;
  INTERNET_STATUS_INTERMEDIATE_RESPONSE  = 120;
  INTERNET_STATUS_STATE_CHANGE           = 200;
  // HTTP 1.1 defined headers
  HTTP_QUERY_AGE                         = 48;
  HTTP_QUERY_CACHE_CONTROL               = 49;
  HTTP_QUERY_CONTENT_BASE                = 50;
  HTTP_QUERY_CONTENT_LOCATION            = 51;
  HTTP_QUERY_CONTENT_MD5                 = 52;
  HTTP_QUERY_CONTENT_RANGE               = 53;
  HTTP_QUERY_ETAG                        = 54;
  HTTP_QUERY_HOST                        = 55;
  HTTP_QUERY_IF_MATCH                    = 56;
  HTTP_QUERY_IF_NONE_MATCH               = 57;
  HTTP_QUERY_IF_RANGE                    = 58;
  HTTP_QUERY_IF_UNMODIFIED_SINCE         = 59;
  HTTP_QUERY_MAX_FORWARDS                = 60;
  HTTP_QUERY_PROXY_AUTHORIZATION         = 61;
  HTTP_QUERY_RANGE                       = 62;
  HTTP_QUERY_TRANSFER_ENCODING           = 63;
  HTTP_QUERY_UPGRADE                     = 64;
  HTTP_QUERY_VARY                        = 65;
  HTTP_QUERY_VIA                         = 66;
  HTTP_QUERY_WARNING                     = 67;
  {$IFNDEF IE3}
  HSR_INITIATE    = $00000008;
  {$ENDIF}
  SECURITY_FLAG_IGNORE_UNKNOWN_CA        = $00000100;
  ERROR_INTERNET_INVALID_CA              = INTERNET_ERROR_BASE + 45;
  FLAGS_ERROR_UI_FILTER_FOR_ERRORS       = $01;
  FLAGS_ERROR_UI_FLAGS_CHANGE_OPTIONS    = $02;
  FLAGS_ERROR_UI_FLAGS_GENERATE_DATA     = $04;
  FLAGS_ERROR_UI_FLAGS_NO_UI             = $08;
  FLAGS_ERROR_UI_SERIALIZE_DIALOGS       = $10;
  {$ENDIF}

  INTERNET_MAX_PATH_LENGTH = 2048;
  INTERNET_MAX_SCHEME_LENGTH = 32;  // longest protocol name length

type
  PURLComponents = ^TURLComponents;
  TURLComponents = record
    dwStructSize: DWORD;      // size of this structure. Used in version check
    lpszScheme: LPSTR;        // pointer to scheme name
    dwSchemeLength: DWORD;    // length of scheme name
    nScheme: TInternetScheme; // enumerated scheme type (if known)
    lpszHostName: LPSTR;      // pointer to host name
    dwHostNameLength: DWORD;  // length of host name
    nPort: INTERNET_PORT;     // converted port number
    pad: WORD;                // force correct allignment regardless of comp. flags
    lpszUserName: LPSTR;      // pointer to user name
    dwUserNameLength: DWORD;  // length of user name
    lpszPassword: LPSTR;      // pointer to password
    dwPasswordLength: DWORD;  // length of password
    lpszUrlPath: LPSTR;       // pointer to URL-path
    dwUrlPathLength: DWORD;   // length of URL-path
    lpszExtraInfo: LPSTR;     // pointer to extra information (e.g. ?foo or #foo)
    dwExtraInfoLength: DWORD; // length of extra information
  end;

function InternetCrackUrl(lpszUrl: PChar; dwUrlLength, dwFlags: DWORD;
  var lpUrlComponents: TURLComponents): BOOL; stdcall; external 'wininet.dll' name 'InternetCrackUrlA';


{$IFNDEF IE3}
{$IFNDEF D5}
{ INTERNET_BUFFERS - combines headers and data. May be chained for e.g. file }
{ upload or scatter/gather operations. For chunked read/write, lpcszHeader }
{ contains the chunked-ext }
type
  PInternetBuffers = ^INTERNET_BUFFERS;
  INTERNET_BUFFERS = record
    dwStructSize: DWORD;      { used for API versioning. Set to sizeof(INTERNET_BUFFERS) }
    Next: PInternetBuffers;   { chain of buffers }
    lpcszHeader: PAnsiChar;   { pointer to headers (may be NULL) }
    dwHeadersLength: DWORD;   { length of headers if not NULL }
    dwHeadersTotal: DWORD;    { size of headers if not enough buffer }
    lpvBuffer: Pointer;       { pointer to data buffer (may be NULL) }
    dwBufferLength: DWORD;    { length of data buffer if not NULL }
    dwBufferTotal: DWORD;     { total size of chunk, or content-length if not chunked }
    dwOffsetLow: DWORD;       { used for read-ranges (only used in HttpSendRequest2) }
    dwOffsetHigh: DWORD;
  end;

function HttpSendRequestEx(hRequest: HINTERNET; lpBuffersIn: PInternetBuffers;
    lpBuffersOut: PInternetBuffers;
    dwFlags: DWORD; dwContext: DWORD): BOOL; stdcall external 'wininet.dll' name 'HttpSendRequestExA';
function HttpEndRequest(hRequest: HINTERNET;
  lpBuffersOut: PInternetBuffers; dwFlags: DWORD;
  dwContext: DWORD): BOOL; stdcall external 'wininet.dll' name 'HttpEndRequestA';
function InternetGoOnline(lpszURL: PChar; hwndParent: HWND;
  dwFlags: DWORD): BOOL; stdcall external 'wininet.dll' name 'InternetGoOnline';
{$ENDIF D5}

type
  TauHTTPUploadStream = class(TMemoryStream)
  private
    FUploadBoundary: String;
  public
    constructor Create(var HTTPRequestHeader: String);
    procedure FinalizeData;

    procedure WriteInt(Value: Integer);
    procedure WriteFieldHeader(const FieldName, FileName: String);
    procedure WriteFieldFooter;
  end;

constructor TauHTTPUploadStream.Create(var HTTPRequestHeader: String);
begin
  inherited Create;

  // prepare request header and boundary BEFORE execute thread
  FUploadBoundary := GenerateAttachBoundary('0');
  HTTPRequestHeader := 'Content-Type: multipart/form-data, boundary=' + FUploadBoundary;
  FUploadBoundary := '--' + FUploadBoundary;
end;

procedure TauHTTPUploadStream.FinalizeData;
begin
  // finish it with boundary line
  FUploadBoundary := FUploadBoundary + '--' + CRLF;
  Write(FUploadBoundary[1], Length(FUploadBoundary));
end;

procedure TauHTTPUploadStream.WriteInt(Value: Integer);
begin
  Write(Value, SizeOf(Value));
end;

procedure TauHTTPUploadStream.WriteFieldHeader(const FieldName, FileName: String);
var
  FieldHeader: String;
begin
  // put boundary and field identifiers to stream
  FieldHeader := FUploadBoundary + CRLF +
     'Content-Disposition: form-data; name="' + FieldName + '"';
  Write(FieldHeader[1], Length(FieldHeader));
  // add filename and content-type of the file, if it's not empty
  if FileName <> '' then
   begin
    FieldHeader := '; filename="' + FileName + '"' + CRLF +
       'Content-Type: ' + GetMIMEType(ExtractFileExt(FileName));
    Write(FieldHeader[1], Length(FieldHeader));
   end;
  // finish header with double CRLF
  Write(D_CRLF, 4);
end;

procedure TauHTTPUploadStream.WriteFieldFooter;
begin
  Write(CRLF, 2);
end;
{$ENDIF IE3}


// HTTP Status Callback
procedure GetURLStatusCallback(InternetSession: hInternet; Context, InternetStatus: DWord;
  StatusInformation: Pointer; StatusInformationLength: DWord); stdcall;
var
  NewURL, StatusStr: String;
begin
  with TauHTTP(Context) do
   begin
    if Assigned(FOnStatusChanged) then
     begin
      case InternetStatus of
        INTERNET_STATUS_RESOLVING_NAME: StatusStr := 'Resolving name';
        INTERNET_STATUS_NAME_RESOLVED: StatusStr := 'Name resolved';
        INTERNET_STATUS_CONNECTING_TO_SERVER: StatusStr := 'Connecting to server';
        INTERNET_STATUS_CONNECTED_TO_SERVER: StatusStr := 'Connected';
        INTERNET_STATUS_SENDING_REQUEST: StatusStr := 'Sending Request';
        INTERNET_STATUS_REQUEST_SENT: StatusStr := 'Request sent';
        INTERNET_STATUS_RECEIVING_RESPONSE: StatusStr := 'Receiving response';
        INTERNET_STATUS_RESPONSE_RECEIVED: StatusStr := 'Response received';
        INTERNET_STATUS_CTL_RESPONSE_RECEIVED: StatusStr := 'CTL Response received';
        INTERNET_STATUS_PREFETCH: StatusStr := 'Prefetch';
        INTERNET_STATUS_CLOSING_CONNECTION: StatusStr := 'Closing connection';
        INTERNET_STATUS_CONNECTION_CLOSED: StatusStr := 'Connection closed';
        INTERNET_STATUS_HANDLE_CREATED: StatusStr := 'Handle created';
        INTERNET_STATUS_HANDLE_CLOSING: StatusStr := 'Handle closing';
        INTERNET_STATUS_REQUEST_COMPLETE: StatusStr := 'Request complete';
        INTERNET_STATUS_REDIRECT: StatusStr := 'Redirect';
        INTERNET_STATUS_INTERMEDIATE_RESPONSE: StatusStr := 'Intermediate response';
        INTERNET_STATUS_STATE_CHANGE: StatusStr := 'State change';
        else
          StatusStr := 'Unknown status';
       end;

      FOnStatusChanged(TauHTTP(Context), InternetStatus, StatusStr);
     end;

    if InternetStatus = INTERNET_STATUS_REDIRECT then
     begin
      SetLength(NewURL, StatusInformationLength - 1);
      Move(StatusInformation^, NewURL[1], StatusInformationLength - 1);

      if Assigned(FOnRedirected) then
        FOnRedirected(TauHTTP(Context), NewURL);
     end;
   end;
end;

function ParseURL(URL: String; var Protocol, HostName, URLPath,
  Username, Password, ExtraInfo: String; var Port: Word): Boolean;
var
  URLComp: TURLComponents;
begin
  if Pos('://', URL) = 0 then // this should be HTTP by default
    URL := HTTPPrefix + URL;

  InitMSRecord(URLComp, SizeOf(URLComp));
  with URLComp do
   begin
    dwSchemeLength     := INTERNET_MAX_SCHEME_LENGTH + 1;
    dwHostNameLength   := INTERNET_MAX_HOST_NAME_LENGTH + 1;
    dwUserNameLength   := INTERNET_MAX_USER_NAME_LENGTH + 1;
    dwPassWordLength   := INTERNET_MAX_PASSWORD_LENGTH + 1;
    dwUrlPathLength    := INTERNET_MAX_PATH_LENGTH + 1;
    dwExtraInfoLength  := INTERNET_MAX_PATH_LENGTH + 1;
    GetMem(lpszScheme,    INTERNET_MAX_SCHEME_LENGTH + 1);
    GetMem(lpszHostName,  INTERNET_MAX_HOST_NAME_LENGTH + 1);
    GetMem(lpszUserName,  INTERNET_MAX_USER_NAME_LENGTH + 1);
    GetMem(lpszPassword,  INTERNET_MAX_PASSWORD_LENGTH + 1);
    GetMem(lpszUrlPath,   INTERNET_MAX_PATH_LENGTH + 1);
    GetMem(lpszExtraInfo, INTERNET_MAX_PATH_LENGTH + 1);

    Result := InternetCrackUrl(PChar(URL), Length(URL), ICU_ESCAPE, URLComp);
    if Result then
     begin
      Protocol  := lpszScheme;
      HostName  := lpszHostName;
      URLPath   := lpszUrlPath;
      Username  := lpszUserName;
      Password  := lpszPassword;
      ExtraInfo := lpszExtraInfo;
      Port      := nPort;
     end;

    FreeMem(lpszExtraInfo);
    FreeMem(lpszUrlPath);
    FreeMem(lpszPassword);
    FreeMem(lpszUserName);
    FreeMem(lpszHostName);
    FreeMem(lpszScheme);
   end;
end;

procedure ReplaceChars(var Str: String; Replacer: Char; Replaced: SetOfChar);
var
  I: Integer;
begin
  for I := 1 to Length(Str) do
   if Str[I] in Replaced then
     Str[I] := Replacer;
end;

{ Encodes the string in manner how the address visible in the browser line
 (Turns unsafe characters to escape codes) }
function URLEncode(const Str: String): String;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(Str) do
   if (Str[I] in UnsafeURLChars) or (Str[I] >= #$80) or (Str[I] < #32) then
     Result := Result + '%' + IntToHex(Ord(Str[I]), 2)
   else
     Result := Result + Str[I];
end;

{ Decodes the string from manner how the address visible in the browser line to a normal string
  (Unescapes all codes and turns them to normal characters) }
function URLDecode(Str: String): String;
var
  I: Integer;
  ESC: String[2];
  CharCode: integer;
begin
  Result := '';
  ReplaceChars(Str, ' ', ['+']);
  I := 1;
  while I <= Length(Str) do
   begin
    if Str[I] <> '%' then
      Result := Result + Str[I]
    else
     begin
      Inc(I); // skip the % char
      ESC := Copy(Str, I, 2); // Copy the escape code
      Inc(I, 1); // Then skip it.
      try
        CharCode := StrToInt('$' + ESC);
        if (CharCode > 0) and (CharCode < 256) then
          Result := Result + Char(CharCode);
      except
      end;
     end;
    Inc(I);
   end;
end;

function URLToHostName(const URL: String): String;
var
  Dummy: String;
  DummyPort: Word;
begin
  ParseURL(URL, Dummy, Result, Dummy, Dummy, Dummy, Dummy, DummyPort);
end;

function URLToFileName(const URL: String): String;
var
  I: Integer;
  Dummy: String;
  DummyPort: Word;
begin
  ParseURL(URL, Dummy, Dummy, Result, Dummy, Dummy, Dummy, DummyPort);
  I := Length(Result);
  if I <> 0 then
   for I := 1 to Length(Result) do
    if Result[I] = '/' then Result[I] := '\';
  Result := ExtractFileName(Result);
end;

{$IFDEF D4}{$IFDEF USEINTERNAL}
function IsURL(const URL: String): Boolean;
var
  I: Integer;
begin
  Result := False;
  if (Length(URL) > Length(HTTPPrefix) + 5) and (Length(URL) <= 60) then
   begin
    if LowerCase(Copy(URL, 1, Length(HTTPPrefix))) = HTTPPrefix then
     begin
      // URL should not contain invalid characters, spaces and line breaks
      for I := 1 to Length(URL) do
       if (URL[I] < #32) or (URL[I] >= #$80) or (URL[I] in UnsafeURLChars) then Exit;
      Result := True; 
     end;
   end;
end;

// checks whether a string is URL
function IsURL(const URL: String; PrefferedDocumentExtensions: Array of String): Boolean;
var
  I: Integer;
  FileName: String;
begin
  Result := False;
  if (Length(URL) > Length(HTTPPrefix) + 5) and (Length(URL) <= 60) then
   begin
    if LowerCase(Copy(URL, 1, Length(HTTPPrefix))) = HTTPPrefix then
     begin
      // URL should not contain invalid characters, spaces and line breaks
      for I := 1 to Length(URL) do
       if (URL[I] < #32) or (URL[I] >= #$80) or (URL[I] in UnsafeURLChars) then Exit;

      // if not extensions specified
      if High(PrefferedDocumentExtensions) <= 0 then
       begin
        Result := True;
        Exit;
       end;

      FileName := LowerCase(ExcludeLeadingChar(ExtractFileExt(URLToFileName(URL)), '.'));       
      // checking extensions
      for I := Low(PrefferedDocumentExtensions) to High(PrefferedDocumentExtensions) do
       if PrefferedDocumentExtensions[I] = FileName then
        begin
         Result := True;
         Exit;
        end;
     end;
   end;
end;
{$ENDIF}{$ENDIF}


// INTERNAL
type
  TacSimpleHTTPLoader = class(TObject)
  private
     FHTTP: TauHTTPPragmaNoCache;
     FResult: String;
     procedure HTTPDone(Sender: TObject; const ContentType: String; FileSize: Integer; Stream: TStream);
  public
     constructor Create(const URL: String; Timeout: DWord);
     destructor Destroy; override;
     function Read: String;
  end;

constructor TacSimpleHTTPLoader.Create(const URL: String; Timeout: DWord);
begin
  inherited Create;
  FHTTP := TauHTTPPragmaNoCache.Create(nil);
  FHTTP.FURL := URL;
  with FHTTP do
   begin
    with FTimeouts do
     begin
      FConnectTimeout := Timeout;
      FReceiveTimeout := Timeout;
      FSendTimeout := Timeout;
     end; 
    WaitThread := True;
    WaitTimeout := Timeout;
    FOnDone := HTTPDone;
   end; 
end;

destructor TacSimpleHTTPLoader.Destroy;
begin
  FHTTP.Free;
  inherited;
end;

function TacSimpleHTTPLoader.Read: String;
begin
  FResult := '';
  FHTTP.Read;
  Result := FResult;
end;

procedure TacSimpleHTTPLoader.HTTPDone(Sender: TObject; const ContentType: String; FileSize: Integer; Stream: TStream);
begin
  FResult := StreamToString(Stream);
end;

function HTTPReadString(const URL: String; Timeout: Integer {$IFDEF D4} = 0 {$ENDIF}): String;
begin
  if URL <> '' then
   with TacSimpleHTTPLoader.Create(URL, Timeout) do
    try
      Result := Read;
    finally
      Free;
    end
  else
    Result := '';
end;


// routines to hide the HTTP username and password in the DFM
procedure EncryptUP(Stream: TStream; const U, P: String); // encrypts username/password and puts to stream
var
  Buffer: ShortString;
begin
  asm
        push    esi
        push    edi

        mov     esi, ECX   // "P"
        
        // -- determinating the length of Password
        mov     eax, esi
        test    eax, eax
        jz      @@z1
        mov     eax, [esi - 4] // length of Password, if not empty
@@z1:   // -------

        push    eax       // saving length of Password
        push    esi
        mov     esi, EDX   // "U"

        // -- determinating the length of Username
        mov     ecx, esi
        test    ecx, ecx
        jz      @@z2
        mov     ecx, [esi - 4] // length of Username, if not empty
@@z2:   // -------

        add     al, cl    // total length of Username and Password
        inc     eax

        lea     edi, Buffer
        mov     edx, eax  // save the total length for future use
        stosb             // store the total length in Buffer
        mov     al, cl    // total length
        stosb             // store the length of Username
rep     movsb             // copying the Username, including the length of username

        pop     esi
        pop     ecx       // restoring length of Password
rep     movsb             // copying the Password
        mov     ecx, edx  // restoring total length

        // Encrypt it
        std
        dec     edi
        mov     esi, edi
        xor     dl, 0EBh
@@XOR:
        lodsb
        xor     al, dl
        stosb
        loop    @@XOR
        cld

        pop     edi
        pop     esi
  end;
  Stream.Write(Buffer, Byte(Buffer[0]) + 1);
end;

procedure DecryptUP(Stream: TStream; var U, P: String); // retrieves username/password from stream and decrypts them
var
  User, Pass, Buffer: String[$7F]; // hope this enough
begin
  Stream.Read(Buffer, 1);
  Stream.Read(Buffer[1], Byte(Buffer[0]));

  asm
        push    esi
        push    edi

        xor     eax, eax

        lea     esi, Buffer
        lodsb             // retrieve length of encrypted string
        push    esi
        push    eax

        // Decrypt it
        mov     ecx, eax
        mov     edx, eax
        mov     edi, esi

        xor     dl, 0EBh
@@XOR:
        lodsb
        xor     al, dl
        stosb
        loop    @@XOR

        pop     eax
        pop     esi

        lea     edi, User
        mov     cl, [esi] // length of Username
        inc     ecx
        sub     eax, ecx  // length of Password
rep     movsb             // restoring Username
        lea     edi, Pass
        stosb             // restoring length of Password
        mov     ecx, eax
rep     movsb             // restoring Password

        pop     edi
        pop     esi
  end;

  U := User;
  P := Pass;
end;


{ TauLoginComponent }
procedure TauLoginComponent.ReadData(Stream: TStream);
begin
  DecryptUP(Stream, FLoginUsername, FLoginPassword);
end;

procedure TauLoginComponent.WriteData(Stream: TStream);
begin
  EncryptUP(Stream, FLoginUsername, FLoginPassword);
end;

procedure TauLoginComponent.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('LInfo', ReadData, WriteData, (Length(FLoginUsername) <> 0) or (Length(FLoginPassword) <> 0));
end;


{ TauHTTPProxy }
constructor TauHTTPProxy.Create;
begin
  inherited;
  FProxyPort := auDefaultProxyPort;
  FProxyBypass := auDefaultProxyBypass;
end;

procedure TauHTTPProxy.Assign(Source: TPersistent);
begin
  if Source = nil then
   begin
    FAccessType := atPreconfig; 
    FProxyPort := auDefaultProxyPort;
    FProxyBypass := auDefaultProxyBypass;
    FProxyServer := '';
    FProxyUsername := '';
    FProxyPassword := '';
   end
  else
   if Source is TauHTTPProxy then
    begin
     FAccessType := TauHTTPProxy(Source).FAccessType;
     FProxyPort := TauHTTPProxy(Source).FProxyPort;
     FProxyBypass := TauHTTPProxy(Source).FProxyBypass;
     FProxyServer := TauHTTPProxy(Source).FProxyServer;
     FProxyUsername := TauHTTPProxy(Source).FProxyUsername;
     FProxyPassword := TauHTTPProxy(Source).FProxyPassword;
    end
   else
    inherited;
end;

function TauHTTPProxy.IsUseProxy: Boolean;
begin
  Result := FAccessType = atUseProxy;
end;


// TauHTTPRange
procedure TauHTTPRange.Assign(Source: TPersistent);
begin
  if Source = nil then
   begin
    FStartRange := 0;
    FEndRange := 0;
   end
  else
   if Source is TauHTTPRange then
    begin
     FStartRange := TauHTTPRange(Source).FStartRange;
     FEndRange := TauHTTPRange(Source).FEndRange;
    end
   else
    inherited;
end;


// TauHTTPTimeouts
procedure TauHTTPTimeouts.Assign(Source: TPersistent);
begin
  if Source = nil then
   begin
    FConnectTimeout := 0;
    FReceiveTimeout := 0;
    FSendTimeout := 0;
   end
  else
   if Source is TauHTTPTimeouts then
    begin
     FConnectTimeout := TauHTTPTimeouts(Source).FConnectTimeout;
     FReceiveTimeout := TauHTTPTimeouts(Source).FReceiveTimeout;
     FSendTimeout := TauHTTPTimeouts(Source).FSendTimeout;
    end
   else
    inherited;
end;


// TauOutputFileAttributes
constructor TauOutputFileAttributes.Create;
begin
  inherited;
  FComplete := [atrArchive];
  FIncomplete := [atrArchive, atrTemporary];
end;

procedure TauOutputFileAttributes.Assign(Source: TPersistent);
begin
  if Source = nil then
   begin
    FComplete := [atrArchive];
    FIncomplete := [atrArchive, atrTemporary];
   end
  else
   if Source is TauOutputFileAttributes then
    begin
     FComplete := TauOutputFileAttributes(Source).FComplete;
     FIncomplete := TauOutputFileAttributes(Source).FIncomplete;
    end
   else
    inherited;
end;

procedure TauOutputFileAttributes.AttributesChanged;
begin
end;

procedure TauOutputFileAttributes.SetComplete(const Value: TauFileAttributes);
begin
  if FComplete <> Value then
   begin
    FComplete := Value;
    AttributesChanged;
   end;
end;

procedure TauOutputFileAttributes.SetIncomplete(const Value: TauFileAttributes);
begin
  if FIncomplete <> Value then
   begin
    FIncomplete := Value;
    AttributesChanged;
   end;
end;

{$WARNINGS OFF}
{ TauFileStream - FileStream able to write to opened file (no read lock) }
constructor TauFileStream.Create(const FileName: String; CreateNew: Boolean; TestFileAttributes: Boolean {$IFDEF D4} = True {$ENDIF});
const
  CreateNewFlag: Array[Boolean] of Cardinal = (OPEN_ALWAYS, CREATE_ALWAYS);
var
  Attr: Cardinal;
begin
  if TestFileAttributes then
   begin
    Attr := GetFileAttributes(PChar(FileName));
    if (Attr and FILE_ATTRIBUTE_HIDDEN = FILE_ATTRIBUTE_HIDDEN) or
       (Attr and FILE_ATTRIBUTE_READONLY = FILE_ATTRIBUTE_READONLY) then
      SetFileAttributes(PChar(FileName), FILE_ATTRIBUTE_ARCHIVE);
   end;

  inherited Create(CreateFile(PChar(FileName), GENERIC_READ or GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
                   CreateNewFlag[CreateNew], FILE_ATTRIBUTE_NORMAL, 0));
  if Handle < 0 then
{$IFDEF D7}
    raise EFCreateError.CreateResFmt(@SFCreateErrorEx, [ExpandFileName(FileName), SysErrorMessage(GetLastError)]);
{$ELSE}
  {$IFDEF D5}
    raise EFCreateError.CreateResFmt(@SFCreateError, [FileName]);
  {$ELSE}
    {$IFDEF D3}
      raise EFCreateError.CreateFmt(SFCreateError, [FileName]);
    {$ELSE}
      raise EFCreateError.CreateResFmt(SFCreateError, [FileName]);
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

  if TestFileAttributes then
    SetFileAttributes(PChar(FileName), Attr);
end;
{$WARNINGS ON}

destructor TauFileStream.Destroy;
begin
  if Handle >= 0 then FileClose(Handle);
  inherited;
end;


// TauHTTP
constructor TauCustomHTTP.Create(aOwner: TComponent);
begin
  inherited;
  FOutputFileAttributes := TauOutputFileAttributes.Create;

  FThread := TauCustomThread.Create(Self);
  FThread.OnExecute := ThreadExecute;
  FThread.OnException := ThreadException;
  FThread.OnTerminate := ThreadDone;
  FThread.OnWaitTimeoutExpired := ThreadWaitTimeoutExpired;

  FAddHeaders := TStringList.Create;
  FProxy := TauHTTPProxy.Create;
  FRange := TauHTTPRange.Create;
  FTimeouts := TauHTTPTimeouts.Create;

  FAcceptTypes := DEF_ACCEPT_TYPES;
  FAgent := 'acHTTP component (AppControls.com)';
  FTransferBufferSize := DEF_TRANSFERBUFFERSIZE; // 4Kb
  FCacheOptions := [coReloadIfNoExpireInformation, coReloadUpdatedObjects, coCreateTempFilesIfCantCache];
  FInternetOptions := [ioKeepConnection];

{$IFDEF TRIAL}
  if not NotifyDone and not (csDesigning in ComponentState) then
   begin
    NotifyDone := True;
    Application.MessageBox('This program built with AutoUpgrader Pro'#13#10 +
                           '(c) by UtilMind Solutions 1999-2006'#13#10#10 +
                           'To register AutoUpgrader Professional -'#13#10 +
                           'follow instructions in "readme.txt" file.', 'UNREGISTERED', mb_Ok or mb_IconInformation);
   end;
{$ENDIF}
end;

destructor TauCustomHTTP.Destroy;
begin
  FThread.Suspend; // we've used Abort method previously, but thread
                     // will be destroyed anyway in FThread.Free method
                     // we don't need to recreate it twice...
  FTimeouts.Free;
  FRange.Free;
  FProxy.Free;
  FAddHeaders.Free;
  FThread.Free;

  CloseHTTPHandles;
  ReleaseHTTPStream;

  FOutputFileAttributes.Free; // release it at the end, since attributes still required in ReleaseHTTPStream  
  inherited;
end;


// PROTECTED
procedure TauCustomHTTP.DoAnyError;
begin
  if Assigned(FOnAnyError) then
    FOnAnyError(Self);
end;


// PUBLIC METHODS
function TauCustomHTTP.Read{$IFDEF D4}(ForceWaitThread: Boolean = False){$ENDIF}: Boolean;
begin
  Result := ReadRange(0, 0 {$IFDEF D4}, ForceWaitThread {$ENDIF});
end;

{$WARNINGS OFF}
function  TauCustomHTTP.ReadRange(StartRange: Cardinal; EndRange: Cardinal {$IFDEF D4} = 0; ForceWaitThread: Boolean = False{$ENDIF}): Boolean;
{$IFDEF D4}
var
  SaveWaitThread: Boolean;
{$ENDIF}  
begin
  Result := not FRealBusy;
  if Result then
   begin
    FRealBusy := True;
    FBusy := True;

    ProgressTransferRate := -1;
    HTTPInitStartRange := StartRange;
    HTTPInitEndRange := EndRange;
{$IFNDEF IE3}
    FPOSTMethod := pmFormURLEncoded;
{$ENDIF}
{$IFDEF D4}
    if ForceWaitThread then
     begin
      SaveWaitThread := WaitThread;
      WaitThread := True;
     end;
{$ENDIF}
    Result := FThread.Execute;
{$IFDEF D4}
    if ForceWaitThread then
      WaitThread := SaveWaitThread;
{$ENDIF}
   end;
end;
{$WARNINGS ON}

function  TauCustomHTTP.Resume: Boolean;
var
  StartRange: Cardinal;
begin
  // check the OutputFileSize
  StartRange := {$IFNDEF D4}Round({$ENDIF} ExtractFileSize(FOutputFileName) {$IFNDEF D4}){$ENDIF};
  if Integer(StartRange) = -1 then StartRange := 0;

  // 18.12.2004: Rollback feature
  if StartRange <> 0 then
    if StartRange <= FTransferBufferSize then
      StartRange := 0
    else
      StartRange := StartRange - FTransferBufferSize;

  Result := ReadRange(StartRange, 0);
end;

function TauCustomHTTP.IsGlobalOffline: Boolean;
var
  State, StateSize: DWord;
begin
  State := 0;
  StateSize := SizeOf(State);
  Result := InternetQueryOption(nil, INTERNET_OPTION_CONNECTED_STATE, @State, StateSize) and
     (State and INTERNET_STATE_DISCONNECTED_BY_USER = INTERNET_STATE_DISCONNECTED_BY_USER);
end;

{$IFNDEF IE3}
function  TauCustomHTTP.Upload(NumberOfFields: Word): Boolean;
var
  I: Word;
  UploadStream: TMemoryStream;
  UploadFieldName, UploadFileName: String;
begin
  Result := Assigned(FOnUploadFieldRequest) and BeginPrepareUpload;
  if Result then
   try
     // create temporary stream to put files to main HTTPStream
     UploadStream := TMemoryStream.Create;
     try
       // put files to stream
       I := 0;
       while I < NumberOfFields do
        begin
         // ask for data and field name
         UploadFieldName := '';
         UploadFileName := '';
         UploadStream.Clear;
         FOnUploadFieldRequest(Self, I, UploadStream, UploadFieldName, UploadFileName);

         with TauHTTPUploadStream(HTTPStream) do
          begin
           // put boundary and field identifiers to stream
           WriteFieldHeader(UploadFieldName, UploadFileName);
           // put data to stream, after boundary
           Write(UploadStream.Memory^, UploadStream.Size);
           WriteFieldFooter;
          end;

         Inc(I);
        end;
     finally
       UploadStream.Free;
     end;
   finally
     EndPrepareUpload;
   end;
end;

function TauCustomHTTP.BeginPrepareUpload: Boolean;
begin
  Result := not FRealBusy;
  if Result then
   begin
    FRealBusy := True;
    FBusy := True;

    ProgressTransferRate := -1;
    HTTPInitStartRange := 0;
    HTTPInitEndRange := 0;
    // create stream for uploading (will released on completion or on error)
    HTTPStream := TauHTTPUploadStream.Create(HTTPUploadRequestHeader);
   end;
end;

procedure TauCustomHTTP.UploadStream(const FieldName: String; UploadStream: TStream; const FileName: String {$IFDEF D4} = '' {$ENDIF});
begin
  with TauHTTPUploadStream(HTTPStream) do
   begin
    WriteFieldHeader(FieldName, FileName);
    CopyFrom(UploadStream, 0);
    WriteFieldFooter;
   end;
end;

procedure TauCustomHTTP.UploadString(const FieldName, StrValue: String);
begin
  with TauHTTPUploadStream(HTTPStream) do
   begin
    WriteFieldHeader(FieldName, '');
    Write(StrValue[1], Length(StrValue));
    WriteFieldFooter;
   end;
end;

procedure TauCustomHTTP.UploadInteger(const FieldName: String; IntValue: Integer);
begin
  with TauHTTPUploadStream(HTTPStream) do
   begin
    WriteFieldHeader(FieldName, '');
    WriteInt(IntValue);
    WriteFieldFooter;
   end;
end;

procedure TauCustomHTTP.UploadBoolean(const FieldName: String; BoolValue: Boolean);
begin
  UploadInteger(FieldName, Byte(BoolValue));
end;

procedure TauCustomHTTP.UploadPicture(const FieldName: String; Picture: TPicture;
  const FileName: String {$IFDEF D4} = S_PIC {$ENDIF});
var
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    Picture.Graphic.SaveToStream(Stream);
    UploadStream(FieldName, Stream, FileName);
  finally
    Stream.Free;
  end;
end;

{$IFDEF USEJPEG}
procedure TauCustomHTTP.UploadThumbnailedPicture(const FieldName: String; Picture: TPicture;
  ThumbnailWidth: Word {$IFDEF D4} = DefThumbnailWidth {$ENDIF};
  ThumbnailHeight: Word {$IFDEF D4} = DefThumbnailHeight {$ENDIF};
  JPEGCompressionQuality: Byte {$IFDEF D4} = 90 {$ENDIF};
  WriteNormalImageIfThumbnailHaveBiggerSize: Boolean {$IFDEF D4} = True {$ENDIF};
  const FileName: String {$IFDEF D4} = S_PIC {$ENDIF});
var
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    WriteThumbnailedImageToStream(Stream, Picture,
      ThumbnailWidth, ThumbnailHeight, JPEGCompressionQuality, WriteNormalImageIfThumbnailHaveBiggerSize);
    UploadStream(FieldName, Stream, FileName);
  finally
    Stream.Free;
  end;
end;
{$ENDIF}  

procedure TauCustomHTTP.EndPrepareUpload;
begin
  TauHTTPUploadStream(HTTPStream).FinalizeData;
  // execute thread
  FPOSTMethod := pmMultipartFormData;
  FThread.Execute;
end;
{$ENDIF}

procedure TauCustomHTTP.Abort(DeleteOutputFile: Boolean {$IFDEF D4} = False {$ENDIF}; HardTerminate: Boolean {$IFDEF D4} = False {$ENDIF});
begin
  if ThreadBusy then
   begin
    HTTPDeleteOutputFileOnAbort := DeleteOutputFile;
    FThread.Terminate(HardTerminate);
    if HardTerminate then
      AbortAndReleaseStreams;
   end;
end;

// new methods (AppControls v3.6.1)
// works only for binary files. OutputFileName MUST BE SPECIFIED!!
procedure TauCustomHTTP.Pause; // same as Abort(False)
begin
  Abort(False, False);
end;


// ENGINE
procedure TauCustomHTTP.PrepareProgressParams;
begin
  ProgressPercentsDone := PercentsOf(HTTPFileSize + HTTPInitStartRange, HTTPBytesTransferred + HTTPInitStartRange);

  ProgressElapsedTime := (GetTickCount - HTTPStartTime) div 1000;
  ProgressEstimatedTime := Round(HTTPFileSize / HTTPBytesTransferred * ProgressElapsedTime)
                   { ^- This is total time for download} - ProgressElapsedTime;
  ProgressTransferRate := HTTPBytesTransferred / 1024;
  if ProgressElapsedTime <> 0 then
    ProgressTransferRate := ProgressTransferRate / ProgressElapsedTime;
end;

procedure TauCustomHTTP.CloseHTTPHandles;
begin
  if hFile <> 0 then
   begin
    CloseHandle(hFile);
    hFile := 0;
   end;
  if hRequest <> nil then
   begin
    InternetCloseHandle(hRequest);
    hRequest := nil;
   end;
  if hConnect <> nil then
   begin
    InternetCloseHandle(hConnect);
    hConnect := nil;
   end;
  if hSession <> nil then
   begin
    InternetCloseHandle(hSession);
    hSession := nil;
   end;
end;

procedure TauCustomHTTP.ReleaseHTTPStream;
begin
  if HTTPData <> nil then
   begin
    FreeMem(HTTPData);
    HTTPData := nil;
   end;

  if HTTPStream <> nil then
   begin
    HTTPStream.Free;
    HTTPStream := nil;

    // fix for strange behaviour, when Windows set Archive attribute to file after closing File Handle
    if HTTPOutputToFile and (FOutputFileAttributes.FIncomplete <> [atrArchive]) then // reset incomplete file attribute
      SetFileAttr(FOutputFileName, FOutputFileAttributes.FIncomplete);

    HTTPOutputToFile := False;
   end;

  FBusy := False;
  FRealBusy := False; // can execute another HTTP session
end;

procedure TauCustomHTTP.AbortAndReleaseStreams;
var
  IsOutputToFile: Boolean;
begin
  CloseHTTPHandles;
  IsOutputToFile := HTTPOutputToFile;
  ReleaseHTTPStream;
  if IsOutputToFile and HTTPDeleteOutputFileOnAbort then
    DeleteFile(FOutputFileName);

  if not (csDestroying in ComponentState) and Assigned(FOnAborted) then
    if FThread.Suspended then
      FOnAborted(Self)
    else
      FThread.Synchronize(CallAborted);
end;


// THREAD MANAGEMENT
procedure TauCustomHTTP.ThreadExecute;
label TryAnotherRequest;
const
  HEADER_BUFFER_SIZE = 4096;
  OfflineFlags: Array[Boolean] of DWord = (0, INTERNET_FLAG_OFFLINE);
  ProxyFlags: Array[TauHTTPAccessType] of DWord = (INTERNET_OPEN_TYPE_PRECONFIG, INTERNET_OPEN_TYPE_DIRECT, INTERNET_OPEN_TYPE_PROXY);
  RequestMethods: Array[Boolean] of PChar = ('GET', 'POST');
var
  I: DWord;
  IsPOSTResume: Boolean;
  PortNumber: Word;
  HTTPBlockSize: TauBufferSize;
  ProtocolName, HostName, ObjectName,
  URLUsername, URLPassword, URLExtraInfo: String;
  HeaderData: Array[0..HEADER_BUFFER_SIZE - 1] of Char;
  AcceptTypes: Array[0..1] of PChar;
  RollBackCheckData: Pointer;
  Headers: String;
{$IFNDEF IE3}
  UploadBuffer: INTERNET_BUFFERS;
{$ENDIF}
  IsLocalFile: Boolean;

  function CheckAborted: Boolean;
  begin
    Result := FThread.Terminated;
    if Result then
     begin
      AbortAndReleaseStreams;
      FThread.Terminate(True); // now kill the thread completely and recreate it
     end;
  end;

  function QueryHTTPHeader(Flags: DWord): Boolean;
  var
    dwBufLen, dwIndex: DWord;
  begin
    dwIndex := 0;
    dwBufLen := HEADER_BUFFER_SIZE;
    Result := HttpQueryInfo(hRequest, Flags, @HeaderData, dwBufLen, dwIndex);
  end;

  procedure SetStringOption(Option: DWord; const Value: String);
  begin
    InternetSetOption(hRequest, Option, PChar(Value), Length(Value));
  end;

  procedure SetDWOption(Option: DWord; Value: DWord);
  begin
    InternetSetOption(hRequest, Option, @Value, SizeOf(Value));
  end;

  procedure SetHeaderRange(StartRange, EndRange: Cardinal);
  begin
    Headers := Headers + 'RANGE: bytes=' + IntToStr(StartRange) + '-';
    if EndRange <> 0 then
      Headers := Headers + IntToStr(EndRange);
    Headers := Headers + CRLF;
  end;

  function GenerateRequestHeaders(AddRange: Boolean): Boolean; // returns True if succeed
  const
    AddRequestModifierFlags: Array[Boolean] of DWord = (HTTP_ADDREQ_FLAG_ADD, HTTP_ADDREQ_FLAG_REPLACE);
  begin
    // Generate additional header
    Headers := FAddHeaders.Text;

    if AddRange then
     begin
      // Generate content RANGE for "Resume"
      if (HTTPInitStartRange <> 0) or (HTTPInitEndRange <> 0) then
        SetHeaderRange(HTTPInitStartRange, HTTPInitEndRange)
      else
        // Generate content RANGE by specified properties
        with FRange do
         if (FStartRange <> 0) or (FEndRange <> 0) then
           SetHeaderRange(FStartRange, FEndRange);
     end
    else
      SetHeaderRange(0, 0);

    if Length(Headers) <> 0 then
      Result := HttpAddRequestHeaders(hRequest, PChar(Headers), Length(Headers),
        AddRequestModifierFlags[HTTPErrorCode = HTTP_STATUS_RANGE_NOT_SATISFIABLE])
    else
      Result := True;
  end;

  function CheckObjectSize: Cardinal;
  begin
    Result := 0;
    if GenerateRequestHeaders(False) and not CheckAborted and HttpSendRequest(hRequest, nil, 0, nil, 0) and
       QueryHTTPHeader(HTTP_QUERY_STATUS_CODE) then // get status code
     begin
      HTTPErrorCode := StrToIntDef(HeaderData, 0);
      if ((HTTPErrorCode = HTTP_STATUS_OK) or (HTTPErrorCode = HTTP_STATUS_PARTIAL_CONTENT)) and
         QueryHTTPHeader(HTTP_QUERY_CONTENT_LENGTH) then
        Result := StrToIntDef(HeaderData, 0);
     end;
    CheckAborted;
  end;

begin
  HTTPErrorCode := HostUnreachableCode;
  HTTPContentType := '';
  HTTPBlockSize := FTransferBufferSize;
  HTTPStartTime := GetTickCount;
  HTTPContinueDownload := True;

  ParseURL(FURL, ProtocolName, HostName, ObjectName,
           URLUsername, URLPassword, URLExtraInfo, PortNumber);
  URLExtraInfo := URLEncode(URLExtraInfo); // 2.08.2005: Fix to avoid sending of decoded characters over 7bits. Thanks to Grzegorz Zielinski!
  if URLUsername = '' then
    URLUsername := FLoginUsername;
  if URLPassword = '' then
    URLPassword := FLoginPassword;

  CheckAborted; // <--

  IsLocalFile := ProtocolName = 'file';
  if not IsLocalFile then
   begin
    // Opening the session
    with FProxy do
     begin
      if FAccessType = atUseProxy then
       if FProxyBypass = '' then
         // We should not use empty string for ProxyBypass because
         // InternetOpen will use it as the proxy bypass list
         hSession := InternetOpen(PChar(FAgent), ProxyFlags[FAccessType],
            PChar(ProxyServer + ':' + IntToStr(FProxyPort)), nil, OfflineFlags[FWorkOffline])
       else
         hSession := InternetOpen(PChar(FAgent), ProxyFlags[FAccessType],
            PChar(ProxyServer + ':' + IntToStr(FProxyPort)), PChar(FProxyBypass), OfflineFlags[FWorkOffline])
      else
        hSession := InternetOpen(PChar(FAgent), ProxyFlags[FAccessType],
           nil, nil, OfflineFlags[FWorkOffline]);

      if (FAccessType <> atDirect) and (FProxyUsername <> '') and (FProxyPassword <> '') then
       begin
        SetStringOption(INTERNET_OPTION_PROXY_USERNAME, FProxyUsername);
        SetStringOption(INTERNET_OPTION_PROXY_PASSWORD, FProxyPassword);
       end;
     end;

    // Registering the Callback function
    InternetSetStatusCallback(hSession, @GetURLStatusCallback);

    // check success
    HTTPSuccess := hSession <> nil;
    if not HTTPSuccess then Exit; // No connection or host unreachable

TryAnotherRequest:

    CheckAborted; // <--

    // Estabilishing connection
    hConnect := InternetConnect(hSession, PChar(HostName), PortNumber,
       PChar(URLUsername), PChar(URLPassword), INTERNET_SERVICE_HTTP, 0, DWord(Self));
    // check success
    HTTPSuccess := hConnect <> nil;
    if not HTTPSuccess then Exit; // No connection or host unreachable

    CheckAborted; // <--

    // Preparing the request
    AcceptTypes[0] := PChar(FAcceptTypes);
    AcceptTypes[1] := nil;
    if FRequestMethod = rmAutoDetect then
      IsPOSTResume := (FPOSTData <> '') {$IFNDEF IE3} or (FPOSTMethod = pmMultipartFormData){$ENDIF}
    else
      IsPOSTResume := Boolean(Byte(FRequestMethod) - 1);

    // generate flags
    I := 0;
    // secure
    if ProtocolName = 'https' then
      Inc(I, INTERNET_FLAG_SECURE)
    else // secure pages won't be cached
      if (coCreateTempFilesIfCantCache in FCacheOptions) then
        Inc(I, INTERNET_FLAG_NEED_FILE);
    // cache
    if (coAlwaysReload in FCacheOptions) then
      Inc(I, INTERNET_FLAG_RELOAD);
    if (coReloadIfNoExpireInformation in FCacheOptions) then
      Inc(I, INTERNET_FLAG_HYPERLINK);
    if (coReloadUpdatedObjects in FCacheOptions) then
      Inc(I, INTERNET_FLAG_RESYNCHRONIZE);
    if (coPragmaNoCache in FCacheOptions) then
      Inc(I, INTERNET_FLAG_PRAGMA_NOCACHE);
    if (coNoCacheWrite in FCacheOptions) then
      Inc(I, INTERNET_FLAG_NO_CACHE_WRITE);
    if (coUseCacheIfNetFail in FCacheOptions) then
      Inc(I, INTERNET_FLAG_CACHE_IF_NET_FAIL);
    // internet
    if (ioIgnoreCertificateInvalid in FInternetOptions) then
      Inc(I, INTERNET_FLAG_IGNORE_CERT_CN_INVALID);
    if (ioIgnoreCertificateDateInvalid in FInternetOptions) then
      Inc(I, INTERNET_FLAG_IGNORE_CERT_DATE_INVALID);
    if (ioIgnoreRedirectToHTTP in FInternetOptions) then
      Inc(I, INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTP);
    if (ioIgnoreRedirectToHTTPS in FInternetOptions) then
      Inc(I, INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTPS);
    if (ioKeepConnection in FInternetOptions) then
      Inc(I, INTERNET_FLAG_KEEP_CONNECTION);
    if (ioNoAuthentication in FInternetOptions) then
      Inc(I, INTERNET_FLAG_NO_AUTH);
    if (ioNoAutoRedirect in FInternetOptions) then
      Inc(I, INTERNET_FLAG_NO_AUTO_REDIRECT);
    if (ioNoCookies in FInternetOptions) then
      Inc(I, INTERNET_FLAG_NO_COOKIES);

    hRequest := HttpOpenRequest(hConnect, PChar(RequestMethods[IsPOSTResume]),
         PChar(ObjectName + URLExtraInfo), nil, PChar(FReferer), @AcceptTypes, I, 0);
    // check success
    HTTPSuccess := hRequest <> nil;
    if not HTTPSuccess then Exit; // No connection or host unreachable

    CheckAborted; // <--

    // Set timeouts
    with FTimeouts do
     begin
      if FConnectTimeout <> 0 then
        SetDWOption(INTERNET_OPTION_CONNECT_TIMEOUT, FConnectTimeout);
      if FReceiveTimeout <> 0 then
        SetDWOption(INTERNET_OPTION_RECEIVE_TIMEOUT, FReceiveTimeout);
      if FSendTimeout <> 0 then
        SetDWOption(INTERNET_OPTION_SEND_TIMEOUT, FSendTimeout);

      if (ioIgnoreUnknownCertificateAuthority in FInternetOptions) then
        SetDWOption(INTERNET_OPTION_SECURITY_FLAGS, SECURITY_FLAG_IGNORE_UNKNOWN_CA);

{$IFNDEF IE3}
      // try to go online
      if FShowGoOnlineMessage and IsGlobalOffline then
        InternetGoOnline(PChar(URL), GetDesktopWindow, 0);
{$ENDIF}

      // set custom Internet options
      if Assigned(FOnBeforeSendRequest) then
        FOnBeforeSendRequest(Self, hRequest);
     end;

    if not GenerateRequestHeaders(True) then Exit;

    repeat
      CheckAborted; // <--
          
      HTTPTryAgain := False;

      // SENDING the request! Returns False if fails
      if IsPOSTResume then // if POST method
       {$IFNDEF IE3}
        if FPOSTMethod = pmFormURLEncoded then
       {$ENDIF}
          HTTPSuccess := HttpSendRequest(hRequest, DEF_CONTENT_TYPE, DEF_CONTENT_TYPE_SIZE,
              PChar(FPOSTData), Length(FPOSTData))
       {$IFNDEF IE3}
        else // multipart/form-data
         begin
          HTTPFileSize := HTTPStream.Size;

          // prepare BufferIn structure
          InitMSRecord(UploadBuffer, SizeOf(UploadBuffer));
          with UploadBuffer do
           begin
            lpcszHeader := PChar(HTTPUploadRequestHeader);
            dwHeadersLength := Length(HTTPUploadRequestHeader);
            dwHeadersTotal := dwHeadersLength;
            dwBufferTotal := HTTPFileSize;
           end;
          // start upload request
          HTTPSuccess := HttpSendRequestEx(hRequest,
               @UploadBuffer, nil, HSR_INITIATE, 0);

          // request and upload data
          if HTTPSuccess then
           begin
            // upload the data
            HTTPStream.Position := 0;
            HTTPBytesTransferred := 0;
            // UPLOADING DATA
            while not CheckAborted do
             with TMemoryStream(HTTPStream) do
              begin
               // determinate the size of block to upload
               if HTTPBytesTransferred + HTTPBlockSize > HTTPFileSize then
                 I := HTTPFileSize - HTTPBytesTransferred
               else
                 I := HTTPBlockSize;
               // upload block
               if not InternetWriteFile(hRequest,
                   Pointer(Cardinal(Memory) + HTTPBytesTransferred),
                   I, I) or (I = 0) then Break;
               Inc(HTTPBytesTransferred, I);
               if Assigned(FOnUploadProgress) then
                 FThread.Synchronize(CallUploadProgress);
             end;

            // finish uploading
            if not HTTPEndRequest(hRequest, nil, 0, 0) and
               (GetLastError = ERROR_INTERNET_FORCE_RETRY) then
             begin
              HTTPTryAgain := True;
              Continue;
             end;
           end;
         end
       {$ENDIF}
      else // GET
        HTTPSuccess := HttpSendRequest(hRequest, nil, 0, nil, 0);

      if not HTTPSuccess then // No connection or host unreachable
       begin
        if HTTPStream <> nil then // release upload stream if available
         begin
          HTTPStream.Free;
          HTTPStream := nil;
         end;
        Exit;
       end;

      CheckAborted; // <--

      // get status code
      HTTPSuccess := QueryHTTPHeader(HTTP_QUERY_STATUS_CODE);
      if HTTPSuccess then HTTPErrorCode := StrToIntDef(HeaderData, 0);

      // check, maybe file already downloaded?
      if (HTTPErrorCode = HTTP_STATUS_RANGE_NOT_SATISFIABLE) and (HTTPInitStartRange <> 0) then
        if CheckObjectSize = HTTPInitStartRange then Exit // everything is ok, file already there
        else // definitely error, invalid range :-(
         begin
          HTTPErrorCode := -1;
          HTTPInitStartRange := 0;
          InternetCloseHandle(hRequest); hRequest := nil;
          InternetCloseHandle(hConnect); hConnect := nil;
          goto TryAnotherRequest; // make another request which will return error code
         end
      else
       // trigger WWW and Proxy authentication requests
       if (HTTPErrorCode = HTTP_STATUS_DENIED) and
          Assigned(FOnPasswordRequest) then
        begin
         HTTPSuccess := QueryHTTPHeader(HTTP_QUERY_WWW_AUTHENTICATE);
         if HTTPSuccess then
          begin
           HTTPContentType := HeaderData; // this originally looks like 'Basic realm="REALM NAME"'
           I := Pos('="', HTTPContentType);
           if I <> 0 then
            begin
             Inc(I, 2);
             HTTPContentType := Copy(HTTPContentType, I, Length(HTTPContentType) - Integer(I));
            end;

           // ...the code block above can be replaced by this:...
           //  HTTPContentType := LeftPart('"', RightPart('="', HTTPContentType));
          end
         else HTTPContentType := '';
         FThread.Synchronize(CallPasswordRequest);
         SetStringOption(INTERNET_OPTION_USERNAME, FLoginUsername);
         SetStringOption(INTERNET_OPTION_PASSWORD, FLoginPassword);
        end
       else
        if (HTTPErrorCode = HTTP_STATUS_PROXY_AUTH_REQ) and
           Assigned(FOnProxyAuthenticationRequest) then
         begin
          FThread.Synchronize(CallProxyAuthenticationRequest);
          with FProxy do
           begin
            SetStringOption(INTERNET_OPTION_PROXY_USERNAME, FProxyUsername);
            SetStringOption(INTERNET_OPTION_PROXY_PASSWORD, FProxyPassword);
           end;
         end;
    until not HTTPTryAgain;

    if HTTPStream <> nil then // release upload stream if available
     begin
      HTTPStream.Free;
      HTTPStream := nil;
     end;

    CheckAborted; // <--

    // PROCESS HEADERS OF RESPONSE
    if QueryHTTPHeader(HTTP_QUERY_CONTENT_TYPE) then
      HTTPContentType := HeaderData;
    HTTPSuccess := QueryHTTPHeader(HTTP_QUERY_CONTENT_LENGTH);
    if HTTPSuccess then
      HTTPFileSize := StrToIntDef(HeaderData, 0)
    else
      HTTPFileSize := 0;

    // AK: 17-12-2004, fix for servers which does not supports ranges and resume of broken downloads (HTTP 1.0 protocol)
    if not QueryHTTPHeader(HTTP_QUERY_CONTENT_RANGE) then
      HTTPInitStartRange := 0; // there is no range headers!!! Server doesn't supports resuming :-(

    // if we need some additional headers -- process them
    if Assigned(FOnHeaderInfo) then
     begin
      if QueryHTTPHeader(HTTP_QUERY_RAW_HEADERS_CRLF) then
        HTTPRawHeadersCRLF := HeaderData
      else
        HTTPRawHeadersCRLF := '';
      if QueryHTTPHeader(HTTP_QUERY_CONTENT_LANGUAGE) then
        HTTPContentLanguage := HeaderData
      else
        HTTPContentLanguage := '';
      if QueryHTTPHeader(HTTP_QUERY_CONTENT_ENCODING) then
        HTTPContentEncoding := HeaderData
      else
        HTTPContentEncoding := '';
      if QueryHTTPHeader(HTTP_QUERY_LOCATION) then
        HTTPLocation := HeaderData
      else
        HTTPLocation := '';
      if QueryHTTPHeader(HTTP_QUERY_ETAG) then
        HTTPETag := HeaderData
      else
        HTTPETag := '';
      if QueryHTTPHeader(HTTP_QUERY_DATE) then
        HTTPDate := InternetTimeToDateTime(HeaderData)
      else
        HTTPDate := 0;
      if QueryHTTPHeader(HTTP_QUERY_LAST_MODIFIED) then
        HTTPLastModified := InternetTimeToDateTime(HeaderData)
      else
        HTTPLastModified := 0;
      if QueryHTTPHeader(HTTP_QUERY_EXPIRES) then
        HTTPExpires := InternetTimeToDateTime(HeaderData)
      else
        HTTPExpires := 0;

      FThread.Synchronize(CallHeaderInfo);
      if not HTTPContinueDownload then Exit; // we don't want to download data
     end;
   end
  else // if LocalFile
   begin
    hFile := CreateFile(PChar(ObjectName), GENERIC_READ, FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
                              OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
    if hFile = INVALID_HANDLE_VALUE then
     begin
      HTTPErrorCode := HTTP_STATUS_NOT_FOUND;
      HTTPFileSize := 0;
     end
    else
     begin
      HTTPErrorCode := HTTP_STATUS_OK;
      HTTPFileSize := GetFileSize(hFile, @I);
      // set ranges for local file
      if HTTPInitStartRange <> 0 then
        SetFilePointer(hFile, HTTPInitStartRange, nil, FILE_BEGIN)
      else
        // Generate content RANGE by specified properties
        with FRange do
         if FStartRange <> 0 then
           SetFilePointer(hFile, HTTPInitStartRange, nil, FILE_BEGIN);
     end;
   end;

  CheckAborted; // <--

  // PREPARING THE STREAM TO DOWNLOAD
  if ((HTTPErrorCode = HTTP_STATUS_OK) or (HTTPErrorCode = HTTP_STATUS_PARTIAL_CONTENT)) and // AK:11-DEC-2004 - Pause/Resume support
     (FOutputFileName <> '') then // AK:13-NOV-2001 - support of FileStream if the OutputFileName specified
   begin
    try
{$IFDEF USEINTERNAL}    
      if Assigned(FOnBeforeCreateFile) then
        FThread.Synchronize(CallBeforeCreateFile);
{$ENDIF}
      HTTPStream := TauFileStream.Create(FOutputFileName, HTTPInitStartRange = 0, True);
      
      if (HTTPInitStartRange <> 0) and
         (HTTPStream.Seek(HTTPInitStartRange, soFromBeginning) <> LongInt(HTTPInitStartRange)) then
        HTTPErrorCode := -1 // can't set file pointer
      else
        if FOutputFileAttributes.FIncomplete <> [atrArchive] then
          SetFileAttr(FOutputFileName, FOutputFileAttributes.FIncomplete);

      HTTPOutputToFile := True;
    except // file creation error
      if HTTPSuccess then
       begin
        HTTPStream := nil;
        Exit; // for binary file only one way out -- exit... we can't do anything due to file creation error...
       end
      else
        HTTPStream := TMemoryStream.Create; // this is ASCII dynamic content, let it output as MemoryStream
    end;
{$IFDEF USEINTERNAL}
    if Assigned(FOnAfterCreateFile) then
      FThread.Synchronize(CallAfterCreateFile);
{$ENDIF}

    if HTTPErrorCode = -1 then
     begin
      InternetCloseHandle(hRequest); hRequest := nil;
      InternetCloseHandle(hConnect); hConnect := nil;
      goto TryAnotherRequest; // make another request which will return error code
     end;
   end
  else
   begin
    HTTPStream := TMemoryStream.Create;
    if HTTPSuccess then // for binary file specifying the stream size to avoid expanding of TMemoryStream over 4MB
      TMemoryStream(HTTPStream).SetSize(HTTPFileSize);
   end;

  // READING THE DATA FROM THE WEB
  IsPOSTResume := (HTTPInitStartRange <> 0) and HTTPOutputToFile; 
  HTTPBytesTransferred := 0;
  GetMem(HTTPData, HTTPBlockSize);

  while not CheckAborted do
   begin
    if IsLocalFile then
      if not ReadFile(hFile, HTTPData^, HTTPBlockSize, I, nil) then Break else
    else
      if not InternetReadFile(hRequest, HTTPData, HTTPBlockSize, I) then Break;
    if I = 0 then Break;
    
    Inc(HTTPBytesTransferred, I);    

    if IsPOSTResume then
     begin
      IsPOSTResume := False;
      // read last N bytes from file and compare with received data
      GetMem(RollBackCheckData, HTTPBlockSize);
      try
        HTTPStream.Read(RollBackCheckData^, HTTPBlockSize);
        HTTPTryAgain := not CompareMem(RollBackCheckData, HTTPData, HTTPBlockSize);
      finally
        FreeMem(RollBackCheckData);
      end;

      if HTTPTryAgain then
       begin
        HTTPErrorCode := -1;
        InternetCloseHandle(hRequest); hRequest := nil;
        InternetCloseHandle(hConnect); hConnect := nil;
        goto TryAnotherRequest; // make another request which will return error code
       end;
     end
    else // write to stream if rollback part is okay
     begin
      HTTPStream.Write(HTTPData^, I);
      if Assigned(FOnProgress) then
        FThread.Synchronize(CallProgress);
     end;
   end;

  FreeMem(HTTPData);
  HTTPData := nil;

  HTTPSuccess := (HTTPErrorCode = HTTP_STATUS_OK) or (HTTPErrorCode = HTTP_STATUS_PARTIAL_CONTENT);
  // if the data size has been determinated -- check, maybe connection was lost
  // and only part of data has been downloaded
  if HTTPSuccess and (HTTPFileSize <> 0) and (HTTPStream <> nil) then
    HTTPSuccess := HTTPFileSize = Cardinal(HTTPBytesTransferred);
end;

procedure TauCustomHTTP.ThreadDone(Sender: TObject);
var
  DeleteOutputFile: Boolean;
begin
  CloseHTTPHandles;
  DeleteOutputFile := False;
  // move stream position to beginning of stream
  if HTTPStream <> nil then
    HTTPStream.Position := 0;

  FBusy := False;
  if HTTPContinueDownload then
   with FThread do
    if HTTPSuccess then
     begin
      if HTTPStream = nil then
       begin
        DoAnyError;
        if Assigned(FOnOutputFileError) then
          FOnOutputFileError(Self);
        FRealBusy := False;
        Exit;
       end
      else
       if HTTPOutputToFile then // HTTPStream is TauFileStream, this happends when the OutputFileName specified
        begin
         ReleaseHTTPStream; // release it before usage in OnDone handler. OnDone should work only with MemoryStreams
         if FOutputFileAttributes.FComplete <> FOutputFileAttributes.FIncomplete then
           SetFileAttr(FOutputFileName, FOutputFileAttributes.FComplete);
        end; 

      if Assigned(FOnDone) then // note, HTTPStream can be NIL !!
        FOnDone(Self, HTTPContentType, HTTPBytesTransferred + HTTPInitStartRange, HTTPStream);
     end
    else
     begin
      // Connection lost?
      if (HTTPErrorCode = HTTP_STATUS_OK) or (HTTPErrorCode = HTTP_STATUS_PARTIAL_CONTENT) then
       if Assigned(FOnConnLost) then
          FOnConnLost(Self, HTTPContentType,
              HTTPFileSize, HTTPBytesTransferred, HTTPStream)
        else
      else
       // fire OnHostUnreachable
       if HTTPErrorCode = HostUnreachableCode then
         if Assigned(FOnHostUnreachable) then
           FOnHostUnreachable(Self)
         else
       else
        begin
         // fire OnError if occurred
         if Assigned(FOnHTTPError) then
           FOnHTTPError(Self, HTTPErrorCode, HTTPStream);

         DeleteOutputFile := HTTPOutputToFile;
        end;

      DoAnyError; // call it after other events       
     end;

  ReleaseHTTPStream;

  if DeleteOutputFile then
    DeleteFile(OutputFileName);

  if not HTTPContinueDownload and Assigned(FOnDoneInterrupted) then
    FOnDoneInterrupted(Self);
end;

procedure TauCustomHTTP.ThreadException;
begin
  DoAnyError;
end;

procedure TauCustomHTTP.ThreadWaitTimeoutExpired(Sender: TObject; var TerminateThread: Boolean);
begin
  if Assigned(FOnWaitTimeoutExpired) then
    FOnWaitTimeoutExpired(Self, TerminateThread);
  if TerminateThread then
   begin
    CloseHTTPHandles;
    ReleaseHTTPStream;
   end;
end;


// SYNCHRONIZED METHODS
procedure TauCustomHTTP.CallAborted;
begin
  if Assigned(FOnAborted) then
    FOnAborted(Self);
end;

procedure TauCustomHTTP.CallHeaderInfo;
begin
  if Assigned(FOnHeaderInfo) then
    FOnHeaderInfo(Self, HTTPErrorCode, HTTPRawHeadersCRLF,
                        HTTPContentType, HTTPContentLanguage, HTTPContentEncoding, HTTPFileSize + HTTPInitStartRange,
                        HTTPLocation, HTTPDate, HTTPLastModified, HTTPExpires, HTTPETag,
                        HTTPContinueDownload);
end;

procedure TauCustomHTTP.CallProgress;
begin
  PrepareProgressParams;
  if Assigned(FOnProgress) then
    FOnProgress(Self, HTTPContentType, HTTPFileSize + HTTPInitStartRange, HTTPBytesTransferred + HTTPInitStartRange,
                ProgressElapsedTime, ProgressEstimatedTime,
                ProgressPercentsDone, ProgressTransferRate, HTTPStream);
end;

{$IFNDEF IE3}
procedure TauCustomHTTP.CallUploadProgress;
begin
  PrepareProgressParams;
  if Assigned(FOnUploadProgress) then
    FOnUploadProgress(Self, HTTPFileSize, HTTPBytesTransferred,
                ProgressElapsedTime, ProgressEstimatedTime,
                ProgressPercentsDone, ProgressTransferRate);
end;
{$ENDIF}

procedure TauCustomHTTP.CallPasswordRequest; // error 401
begin
  if Assigned(FOnPasswordRequest) then
    FOnPasswordRequest(Self, HTTPContentType, HTTPTryAgain);
end;

procedure TauCustomHTTP.CallProxyAuthenticationRequest; // error 407
begin
  if Assigned(FOnProxyAuthenticationRequest) then
    FOnProxyAuthenticationRequest(Self, FProxy.FProxyUsername, FProxy.FProxyPassword, HTTPTryAgain);
end;

{$IFDEF USEINTERNAL}
procedure TauCustomHTTP.CallBeforeCreateFile;
begin
  if Assigned(FOnBeforeCreateFile) then
    FOnBeforeCreateFile(Self);
end;

procedure TauCustomHTTP.CallAfterCreateFile;
begin
  if Assigned(FOnAfterCreateFile) then
    FOnAfterCreateFile(Self);
end;
{$ENDIF}


// PROPERTIES
procedure TauCustomHTTP.SetAddHeaders(Value: TStrings);
begin
  FAddHeaders.Assign(Value);
end;

function  TauCustomHTTP.GetSuspended: Boolean;
begin
  Result := FThread.Suspended;
end;

procedure TauCustomHTTP.SetSuspended(Value: Boolean);
begin
  FThread.Suspended := Value;
end;

function  TauCustomHTTP.GetThreadPriority: TThreadPriority;
begin
  Result := FThread.Priority;
end;

procedure TauCustomHTTP.SetThreadPriority(Value: TThreadPriority);
begin
  FThread.Priority := Value;
end;

function  TauCustomHTTP.GetWaitTimeout: Integer;
begin
  Result := FThread.WaitTimeout;
end;

procedure TauCustomHTTP.SetWaitTimeout(Value: Integer);
begin
  FThread.WaitTimeout := Value;
end;

function  TauCustomHTTP.GetWaitThread: Boolean;
begin
  Result := FThread.WaitThread;
end;

procedure TauCustomHTTP.SetWaitThread(Value: Boolean);
begin
  FThread.WaitThread := Value;
end;

function TauCustomHTTP.GetThreadBusy: Boolean;
begin
  Result := FThread.Running;
end;

function  TauCustomHTTP.GetFreeOnTerminate: Boolean;
begin
  Result := FThread.FreeOwnerOnTerminate;
end;

procedure TauCustomHTTP.SetFreeOnTerminate(Value: Boolean);
begin
  FThread.FreeOwnerOnTerminate := Value;
end;

function TauCustomHTTP.GetFileName: String;
begin
  Result := URLToFileName(FURL);
end;

function TauCustomHTTP.GetHostName: String;
begin
  Result := URLToHostName(FURL);
end;

function TauCustomHTTP.IsNotDefaultAcceptTypes: Boolean;
begin
  Result := FAcceptTypes <> DEF_ACCEPT_TYPES;
end;


// TauHTTPPragmaNoCache
constructor TauHTTPPragmaNoCache.Create(aOwner: TComponent);
begin
  inherited;
  FCacheOptions := [coReloadIfNoExpireInformation, coReloadUpdatedObjects, coPragmaNoCache]
end;

end.
