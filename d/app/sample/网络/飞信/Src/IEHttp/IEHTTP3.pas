unit IEHTTP3;

{.$DEFINE TIE_USE_TNT} //enable this to use TTNTStringList instead of TWideStringList
                       //In Delphi 7, you will need to enable this to handle unicode responses
{.$define tie_debug}

// TIEHTTP
// WinInet HTTP/HTTPS component (supports GET/POST/multipart variables)
// Author: Kyriacos Michael ( to contact me please use the support url below )
//         parts of the code were obtained from usenet.
//         Base64 encoding/decoding by David Barton (davebarton@bigfoot.com)
// Support URL: http://www.myfxboard.com/tiehttp/
// Released: 1 Apr 2003
// Source code released: 28 Mar 2004
//
// This component was released as Freeware with source,
// after many requests from people wanting to extent it
// or simply have a look at it.
// You are free to use the source code for any kind of use, even commercial.
// You are not allowed to sell parts or the whole of the code.
// Please send any modifications of the code, or any additions
// back to the author.
//
// to do list:
// ------------------------------
// investigate InternetSetStatusCallback
// investigate InternetReadFile - > InternetReadFileEx + W
// upload progress
//
//change history
//
// 1.3.0.40 17may2004: blocking / non-blocking mode
//                     cancel requests
//                     request timeout
// 1.3.0.42 17may2004: fixed bug that avoids you to reuse the component after a timeout or a cancel request
// 1.3.0.46 14nov2005: fixed onpacketread in non-blocking mode
//                     added onTimer event and timerIntervalSeconds property
// 1.3.0.44 03sep2004: fixed some bugs in the timeout/onpacketread mechanism
//                     basic proxy authentication support
//                     request_header property e.g. if you want to set "Referer:"
// 1.3.0.47 18feb2006: added gzip decompression (iis) (i had only deflate)
// 1.5.0.48 02jan2007: supports Custom-Content-Length for aspx files
// 1.5.0.60 24apr2008: using xxxW() windows wide functions e.g. InternetOpenW
// 1.5.0.61 24apr2008: full unicode, ditched ansi char operations, pchar operations e.g. strcopy, strcat
// 1.5.0.62 24apr2008: automatic conversion from charset=utf-8, charset=utf-16, charset=us-ascii
// 1.5.0.65 30apr2008: twidestringlist: added option for d7 users to use the default TStringList (ansi) or the TTNTStringList (->DEFINE TIE_USE_TNT)  

{$IFDEF VER80} unsupported {$ENDIF}
{$IFDEF VER90}  {$DEFINE D7_AND_LOWER} {$ENDIF} // D2
{$IFDEF VER93}  {$DEFINE D7_AND_LOWER} {$ENDIF} // CPPB 1
{$IFDEF VER100} {$DEFINE D7_AND_LOWER} {$ENDIF} // D3
{$IFDEF VER110} {$DEFINE D7_AND_LOWER} {$ENDIF} // CPPB 3
{$IFDEF VER120} {$DEFINE D7_AND_LOWER} {$ENDIF} // D4
{$IFDEF VER130} {$DEFINE D7_AND_LOWER} {$ENDIF} // D5
{$IFDEF VER140} {$DEFINE D7_AND_LOWER} {$ENDIF} // D6
{$IFDEF VER150} {$DEFINE D7_AND_LOWER} {$ENDIF} // D7

interface

uses
  SysUtils, Classes, wininet, windows,
  {$IFDEF D7_AND_LOWER}
    //no widestrings in D5, D6 or D7
  {$ELSE}
    //D2005, D2006, D2007...
    WideStrings,
  {$ENDIF}
  {$IFDEF TIE_USE_TNT}
    tntclasses,
  {$else}
    tntlite, //allows MemoryStream and FileStream to load and save unicode files
  {$endif}
  WinInet_Ex, //must be after wininet; defines the wide version of TURLComponents
  forms; //forms unit is necessary for application.processmessages (non blocking mode)

{$IFDEF D7_AND_LOWER} //D5, D6 or D7
  type
  {$IFDEF TIE_USE_TNT}
    TWideStringList = TTNTStringList;
  {$ELSE}
    TWideStringList = TStringList; //fake TWideStringList
  {$ENDIF}
{$ENDIF}

const
  multipart_boundary = '-----------------------------7cf87224d2020a';

//type
//  TRequestMethods = (rm_GET, rm_POST, rm_POST_multipart);

type
  bytestring = ansistring;

type
  TIEHTTP = class(TComponent)
  private
    extraHeaders : widestring;
    hSession, hConnect, hFile : HInternet;
    buffer: TByteArray; //TByteArray = array[0..32767] of Byte;

    _lpSzExtraInfo_Bytes : ByteString;

    is_ie6_and_below : boolean;

    fTimeout : Integer; //value is in milliseconds
    fTimerIntervalSeconds : Integer;
    //ie_thread : TTimeout;

    flag_request_to_stop : boolean;
    flag_timeout_occured : boolean;

    flag_cleanup_completed : boolean;
    fBlockingMode: boolean;

    last_packet_read_dt : TDateTime;
    last_packet_processed_dt : TDateTime;
    last_timer_procesed_dt : TDateTime;

    timeout_datetime : tdatetime; //the calculated time to timeout

    //procedure ReadUrl(hSession: HInternet; const UrlAddr: string; Dest: TStream);
    procedure CrackURL; //step2 : uncompressed, no sl, will also perform crackurl
    //procedure ProcessReadRequest; //step3 : actual reading

    procedure SetGetStr(const Value: widestring);
    procedure SetPostStr(const Value: widestring);
    procedure SetRequestMethod(const Value: widestring);
    procedure SetMultipart(value: boolean);
    procedure SetURL(value: widestring);
    procedure ConvertToMultiPart;
    procedure ReadCookiesAndHeaders(hFile:HInternet);
    procedure CalcTimeoutDatetime;
    procedure SetTimeout(const Value: integer); //value is in milliseconds
    procedure PrepareHeaders1;
    procedure PrepareHeaders2;
    procedure ReadResponse;
    procedure SetBlockingMode(const Value: boolean);
    procedure CleanUpConnectionMemory;
    function GetErrorString(error_code: integer): widestring;
    procedure AddHeader(s: widestring);
    procedure SetTimeInterval(const Value: Integer);
  protected
    FpostStr : widestring;
    FgetStr : widestring;
    FRequestMethod : widestring;
    FMultipartPOST : boolean;
    FUrl: widestring;
    FOnPacketRead: TNotifyEvent;
    FOnTimer     : TNotifyEvent;
  public
    //flag_WaitForSingleObject : boolean;
    ie_thread : TThread; //ttimeout not known here
    //ie_thread_ready : boolean;
    ie_thread_finished : boolean;
    //headers : string; //deprecated: see request_headers
    error : integer;
    error_msg : widestring;
    http_agent_string : widestring;

    result_sl : TWideStringList; //text response
    sl : TWideStringList; //alias to result_sl
    result_ms : TTNTMemoryStream;   //binary response, tnt is to allow saving to unicode filename, nothing to do with content
    //result_ms : TMemoryStream; //binary response
    cookies : TWideStringlist;
    request_headers : TWideStringList; //additional request headers, e.g.
    response_headers : TWideStringList;
    error_code : integer; //100: timeout
                          //101: canceled
    working_status : integer;

    bytes_read_total : integer;
    event_handle : THandle;

    content_type : widestring;
    ContentSize : DWORD;
    multipartVars : array of record f: widestring; v : widestring end; //v will be converted to utf8
    multipartBinaryVars : array of record f: widestring; v : bytestring end;

    aURLC2 : TURLComponents;
    username : widestring;
    password : widestring;
    proxy_username : widestring;
    proxy_password : widestring;
    debug_total_packets : integer;
    debug_total_packet_events : integer;
    debug_total_timer_events : Integer;
    unzip_method : ansichar; //G: iis Z: php
    procedure ProcessReadRequest; //step3 : actual reading

    procedure Execute;                 //step1 : execute default url
    procedure ExecuteURL(url: widestring); //step1 : execute given url

    constructor Create(AOwner: TComponent); override; //reintroduce;
    destructor Destroy; override;
    function GetStringPercentage: widestring; //example on how to read download status
    procedure RequestCompleted;
    procedure StopRequest(wait: boolean=false);
    function GetProgress: single;
    function GetProgressPercentage: single;
    function CheckIEOnline: boolean;
    function GetResponseHeaderValue(header_name: widestring): widestring;
    function GetResponseHeaderIdx(header_name: widestring): integer;
    procedure AddRequestHeader(header_name, value: widestring);
    procedure DeleteRequestHeader(header_name: widestring);
    function GetRequestHeaderIdx(header_name: widestring): integer;
    function GetRequestHeaderValue(header_name: widestring): widestring;
    function Canceled: boolean; //us-spelling
    function FileToB64String(filename: widestring): bytestring;
  published
    property postStr : widestring read FPostStr write SetPostStr;
    property getStr : widestring read FGetStr write SetGetStr;
    property URL : widestring read FUrl write SetURL;
    property Timeout : integer read fTimeout write SetTimeout;
    property TimerIntervalSeconds : Integer read fTimerIntervalSeconds write SetTimeInterval;
    property BlockingMode : boolean read fBlockingMode write SetBlockingMode;
    //property username : string read FUsername write FUsername;
    //property password : string read FPassword write FPassword;
    //property content_type : string read Fcontent_type write Fcontent_type;
    property RequestMethod : widestring read FRequestMethod write SetRequestMethod;
    property MultipartPOST : boolean read FMultipartPOST write SetMultipart;
    property OnPacketRead: TNotifyEvent read FOnPacketRead write FOnPacketRead;
    property OnTimer: TNotifyEvent read FOnTimer write FOnTimer;
    procedure AddMultipartVar(field: widestring; value: widestring);
    procedure AddMultipartVarW(field: widestring; value: widestring);
    procedure AddMultipartVarA(field: widestring; value: ansistring);
    procedure AddMultipartVar_B64(field: widestring; value: bytestring);
    procedure AddMultipartFile(field: widestring; filename: widestring);
    procedure AddMultipartStream(field: widestring; ms: TMemoryStream);
    //procedure AddMultipartVar_Compressed(field: string; value: string);
  end;

procedure Register;

implementation

uses
  {$IFDEF tie_debug} my_unit1, {$endif}
  ZLib, iiehttp3_funcs, iehttp4_thread,
  Dialogs, Controls; //for MessageDlg and mrOK;

procedure Register;
begin
  RegisterComponents('Internet', [TIEHTTP]);
end;

{$IFDEF tie_debug}
procedure LogStr(s: widestring);
begin
  AppendToFileLNA('c:\iehttp1.log', datetimetostr(now) + ' : ' + s);
end;
{$endif}

{ TIEHTTP }

constructor TIEHTTP.Create;
var
  lStructSize : Cardinal;
  wininet_receive_timeout : LongInt;
begin
  inherited Create(AOwner);

  setRequestMethod('GET');
  multipartPOST := false;

  result_sl := TWideStringList.Create;
  sl := result_sl; //alias
  result_ms := TTNTMemoryStream.Create;
  result_ms.Position := 0;
  response_headers := TWideStringList.create;
  request_headers := TWideStringList.create;
  request_headers.Add('Accept-Encoding: gzip, deflate');
  cookies := tWideStringlist.create;

  http_agent_string := 'tiehttp';

  fBlockingMode := true; //if you will not be allowed to cancel requests
                         //except from other threads
  fTimeout := 90; // timeout if no reply for X seconds between reads
                 // this will not affect a long connection as long
                 // as the delay between reads does not exceed X seconds

  working_status := 0; //0: working=off, 1: working=on

  lStructSize := sizeof(wininet_receive_timeout);
  InternetQueryOptionW(nil, INTERNET_OPTION_RECEIVE_TIMEOUT, @wininet_receive_timeout, lStructSize );

  //ie7 introduced a default receive timeout of 30seconds
  //in ie6 and below the timeout was 0 (infinite)
  is_ie6_and_below := wininet_receive_timeout <> 30000;

  if not is_ie6_and_below then begin
    wininet_receive_timeout := 0;   
    InternetSetOptionW(nil, INTERNET_OPTION_RECEIVE_TIMEOUT, @wininet_receive_timeout, sizeof(wininet_receive_timeout) );
  end;
end;

destructor TIEHTTP.Destroy;
begin
  result_sl.Free;
  result_ms.free;
  cookies.free;
  response_headers.Free;
  request_headers.free;

  inherited Destroy;
end;

//==============================================================================
// sample: how to get download progress
//==============================================================================
function TIEHTTP.GetStringPercentage: widestring;
var
  percent_done : widestring;
begin
  if contentSize > 0 then
    percent_done := format('%.0n%%', [ GetProgress*100 ] )
  else
    percent_done := '[]';

  //example on how to read download status
  result := format('Bytes Read: %.0n '#13'Total File Size: %.0n'#13'Status: %s done'
                                   ,[bytes_read_total*1.0,contentSize*1.0,percent_done] ) ;
end;

function TIEHTTP.GetProgress: single;
//percentage progress: 0.00 - 1.00
begin
  if contentSize = 0 then begin
    result := 0;
    exit;
  end;

  result := (bytes_read_total/contentSize);
end;

function TIEHTTP.GetProgressPercentage: single;
//percentage progress: 0 - 100%
begin
  result := GetProgress*100;
end;

procedure TIEHTTP.ProcessReadRequest;
//this is used from HTTPS -POST/GET
//                  HTTP  -POST
//                  for HTTP/GET use geturl
var
  dwFlags : DWord;
  lpdwBufferLength: DWORD;
  dwError : DWord;
var
  context : DWORD;
var
  dwBufLen : DWORD;
  dwIndex : Cardinal;
  //error_msg : string;
  //wininet_receive_timeout : ULONG;
  //lStructSize : cardinal;
  ContentSize_custom : widestring;
begin
  // Initialization, fall-through
  hSession := nil;
  hConnect := nil;
  hFile := nil;
  //size3_multipart := 0;
  dwError := 0;

  debug_total_packets := 0;
  debug_total_packet_events := 0;
  debug_total_timer_events := 0;

  hSession := InternetOpenW(pwidechar(http_agent_string), INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);

  try
    if (hSession = nil) then begin
      //raise exception.create('Could not open Internet');
      error_msg := 'Could not open Internet';
      exit;
    end;

    // Set options for the internet handle
    //InternetSetOption(aHi, INTERNET_OPTION_CONNECT_TIMEOUT, @timeOutMS, sizeOf(timeOutMS));

    //InternetSetOption(hI, INTERNET_OPTION_CONNECT_TIMEOUT,5*60*1000,0);
    //session.SetOption(hI, INTERNET_OPTION_CONNECT_RETRIES,15,0);
    //session.SetOption(hI, INTERNET_OPTION_DATA_SEND_TIMEOUT,5*60*1000,0);
    //session.SetOption(hI, INTERNET_OPTION_RECEIVE_TIMEOUT,5*60*1000,0);

    //in ie receive_timeout returns 30000 ms
    //dwBufLen := sizeof(wininet_receive_timeout);
    //InternetQueryOption(nil, INTERNET_OPTION_RECEIVE_TIMEOUT, @wininet_receive_timeout, dwBufLen);

    //http://msdn.microsoft.com/library/default.asp?url=/library/en-us/wceinternet5/html/wce50lrfoptionflags.asp
    //fix for ie7 beta2: get rid of "receive timeout" that is being set to 30 seconds
    //wininet_receive_timeout := 0;
    //InternetSetOption(nil, INTERNET_OPTION_RECEIVE_TIMEOUT, @wininet_receive_timeout, sizeof(wininet_receive_timeout));

    // Make a connection to that host, raising an exception if no connection}
        //    aHConnect := InternetConnect(aHI, aURLc.lpSzHostName,
        //               INTERNET_INVALID_PORT_NUMBER, nil, nil,
        //               INTERNET_SERVICE_HTTP, 0, 0);
    context := 0;
    hConnect := InternetConnectW(hSession, aURLc2.lpSzHostName,
                aURLc2.nPort{INTERNET_DEFAULT_HTTPS_PORT}, aURLc2.lpszUserName, aURLc2.lpszPassword,
               INTERNET_SERVICE_HTTP, 0, context);

    if (hConnect = nil) then begin
      //raise exception.createFmt('Could not connect to server %s', [aURLc2.lpSzHostName]);
      error_msg := format('Could not connect to server %s', [aURLc2.lpSzHostName]);
      exit;
    end;

    // Open a reqest to get ready to GET data, raising an exception if not successful
    //    aHFile := HTTPOpenRequest(aHConnect, PChar(sMethod), aURLc.lpSzUrlPath, HTTP_VERSION, nil,
    //      nil, INTERNET_FLAG_DONT_CACHE, 0);
    if aURLc2.nPort = 443 then
      dwflags := INTERNET_FLAG_SECURE
              or INTERNET_FLAG_IGNORE_CERT_CN_INVALID
              or INTERNET_FLAG_IGNORE_CERT_DATE_INVALID
              or SECURITY_FLAG_IGNORE_UNKNOWN_CA //avoid 12045 -> todo: not working here
      //dwflags := SECURITY_INTERNET_MASK
      //dwflags := 0
    else
      dwflags := 0;

    dwFlags := dwFlags or INTERNET_FLAG_RELOAD;

    PrepareHeaders1;

    setlasterror(0);
    hFile := HTTPOpenRequestW(hConnect, PWideChar( RequestMethod ),
                             aURLc2.lpSzUrlPath, HTTP_VERSION, nil, nil, dwflags, context);
    dwError := getlasterror;
    if dwError <> 0 then begin
      if dwError in [183,122] then
        //sometimes we may receive these errors
        //183: cannot create a file when that file already exists (win98/d6)
        //122: the data area passed to a system call is too small
        dwError := 0
      else begin
        //RaiseLastWin32Error; //no exceptions in the thread
        error := dwerror; //will be handled outside thread
        exit;
        //raise exception.create('error #' + inttostr(dwError));
      end;
    end;

    //if getlasterror <> 0 then RaiseLastWin32Error;

    if (hFile = nil) then begin
      //raise exception.create('Could not open HTTP request');
      error_msg := 'Could not open HTTP request';
      exit;
    end;

  {lStructSize := sizeof(DWORD);
  InternetQueryOption(nil, INTERNET_OPTION_SECURITY_FLAGS, @dwFlags, lStructSize);
  //showmessage(inttostr(dwflags)); //SECURITY_FLAG_SSL3
        dwflags := INTERNET_FLAG_SECURE
              or INTERNET_FLAG_IGNORE_CERT_CN_INVALID
              or INTERNET_FLAG_IGNORE_CERT_DATE_INVALID
              or SECURITY_FLAG_IGNORE_UNKNOWN_CA
              or SECURITY_FLAG_SSL3
              or SECURITY_FLAG_SSL
              or SECURITY_FLAG_IGNORE_WRONG_USAGE
              or SECURITY_FLAG_IGNORE_REVOCATION;
  InternetSetOption(hFile, INTERNET_OPTION_SECURITY_FLAGS, @dwFlags, sizeof(dwFlags) );}

    // Add any extra headers to the request, raising an exception if not successful
    //   if not HTTPAddRequestHeaders(aHFile, PChar(s), length(s), HTTP_ADDREQ_FLAG_ADD) then
    //     raise(EHTTPAddReqError.create('Could not add HTTP request header'));

    // Send the request, raising an exception if not successful
    //    if not HTTPSendRequest(hFile, nil, 0, aURLc.lpSzExtraInfo, aURLc.dwExtraInfoLength) then begin
    //      dwError := getlasterror;

    PrepareHeaders2;

    //-------------------------
    //Connection Attempt
    //-------------------------

    if (error_msg <> '') or (error <> 0) then exit;

    //_lpSzExtraInfo_Bytes is used to send binary data
    if not HTTPSendRequestW(hFile, pwidechar( extraHeaders ), length(extraHeaders),
                                   //aURLc2.lpSzExtraInfo, aURLc2.dwExtraInfoLength) then begin
                                   //_lpSzExtraInfo_Ansi, _dwExtraInfoLength)) then begin
                                   pansichar(_lpSzExtraInfo_Bytes), length(_lpSzExtraInfo_Bytes)) then begin
      dwError := getlasterror;
      //if not HTTPSendRequestEx(hFile, extraHeaders, extraHeadersLength, aURLc2.lpSzExtraInfo, aURLc2.dwExtraInfoLength) then begin
      //  dwError := getlasterror;

      //if (dwError <> 0) then begin
      //showmessage(GetErrorString(dwError));
      //don't raise exception here because this procedure is called in a thread
      //RaiseLastWin32Error;
      //RaiseLastOSError;
      //end;

      if dwError = 12045 then begin
        //try again if Certificate is invalid

        {     x := nil;
        InternetErrorDlg(GetDesktopWindow(),
                           aHFile,
                           ERROR_INTERNET_INVALID_CA,
                           FLAGS_ERROR_UI_FILTER_FOR_ERRORS or
                           FLAGS_ERROR_UI_FLAGS_GENERATE_DATA or
                           FLAGS_ERROR_UI_FLAGS_CHANGE_OPTIONS,
                           x);}

        InternetQueryOptionW( hFile, INTERNET_OPTION_SECURITY_FLAGS, @dwFlags, lpdwBufferLength);

        dwFlags := dwFlags or SECURITY_FLAG_IGNORE_UNKNOWN_CA;
        InternetSetOptionW( hFile, INTERNET_OPTION_SECURITY_FLAGS, @dwFlags, sizeof(dwFlags) );

        //verify: InternetQueryOption(hFile, INTERNET_OPTION_SECURITY_FLAGS,
        //         @dwFlags, lpdwBufferLength);
        {    hFile := HTTPOpenRequest(hConnect, PChar(sMethod),
        aURLc.lpSzUrlPath, HTTP_VERSION, nil, nil, dwflags, context);
        dwError := getlasterror;
        if dwError <> 0 then RaiseLastWin32Error;}

        //this incorrectly reports error 2 : file not found..., so do not handle the error
        if not HTTPSendRequestW(hFile, pwidechar(extraHeaders), length(extraHeaders),
                                 //aURLc2.lpSzExtraInfo, aURLc2.dwExtraInfoLength)
                                 //_lpSzExtraInfo_Ansi, _dwExtraInfoLength)
                                 pansichar(_lpSzExtraInfo_Bytes), length(_lpSzExtraInfo_Bytes))
        then ;
        dwError := getlasterror;
        //if getlasterror <> 0 then RaiseLastWin32Error;
      end; //retry invalid certificate
    end;

    if dwError > 0 then exit;

    dwBufLen := sizeof(ContentSize);
    ContentSize := 0;
    dwIndex := 0;
    HttpQueryInfoW(hFile, HTTP_QUERY_CONTENT_LENGTH or HTTP_QUERY_FLAG_NUMBER, @ContentSize, dwBufLen, dwIndex );
    if ContentSize=0 then ContentSize:=1; //avoid division by 0
    //bytes_total := ContentSize;

    bytes_read_total := 0;

    ReadCookiesAndHeaders(hFile);

    //asp.net (aspx) disabled content-length even if it is set manually
    //WRONG, content length is being removed from iis-gzip compression filter
    //in such case content is always compressed
    if ContentSize <= 1 then begin
      ContentSize_custom := GetResponseHeaderValue('Custom-Content-Length');
      if (ContentSize_custom <> '') and (ContentSize_custom<>'0') then
        ContentSize := strtoint(ContentSize_custom);
    end;

    {
http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=UTF-8&safe=off&th=e9372deb72b03c8d&rnum=15
InternetReadFile does not work Async.
It blocks until a least some data are read,
and you have no way to stop it other than killing the thread.
Using ReadFileEx, you can use the callback function so you don't need
a thread, and you can stop the call whenever you want, thus respecting timeout values.
}

    CalcTimeoutDatetime;

    //
    // Loop to read the content from the URL in chunks
    ReadResponse;

    //if (not flag_request_to_stop) and (not flag_timeout_occured) then begin
    //end;

    //moved before read response because we may need Custom-Content-Length
    //ReadCookiesAndHeaders(hFile);

  finally
    CleanUpConnectionMemory;
    error := dwError;

  end;

end;

procedure TIEHTTP.CrackURL;
var
  s1, s2, s3 : array[1..INTERNET_MAX_PATH_LENGTH] of widechar;
begin
  //Clear the structure
  FillChar(aURLC2, sizeOf(TURLComponents), 0);
  aURLC2.lpszUrlPath := nil;
  aURLC2.lpszExtraInfo := nil;

  aURLC2.dwStructSize := sizeOf(TURLComponents);
  aURLC2.lpSzExtraInfo := @s1[1];
  aURLC2.dwExtraInfoLength := INTERNET_MAX_PATH_LENGTH;
  aURLC2.lpSzHostName := @s2[1];
  aURLC2.dwHostNameLength := INTERNET_MAX_PATH_LENGTH;
  aURLC2.lpszUrlPath := @s3[1];
  aURLC2.dwUrlPathLength := INTERNET_MAX_PATH_LENGTH;

  _lpSzExtraInfo_Bytes := '';

  if not InternetCrackUrlW( PWideChar(furl), 0, ICU_ESCAPE, aURLC2) then begin
    //raise exception.createFmt('TIE: Invalid URL. Error - %d = ', [GetLastError, SysErrorMessage(GetLastError)]);
    error_msg := format('tiehttp: Invalid URL. Error - %d = %s', [GetLastError, SysErrorMessage(GetLastError)]);
    exit;
  end;

  if widestring(aurlc2.lpszUrlPath) = '' then begin
    error_msg := 'tiehttp: Empty URL';
    exit;
  end;

  //remove only on post
  //if pos('?', aURLc.lpSzExtraInfo) = 1 then begin
  //   aURLc.lpSzExtraInfo := pchar(copy(aURLc.lpSzExtraInfo,2, aURLc.dwExtraInfoLength));
  //   dec(aURLc.dwExtraInfoLength);
  // end;

  //todo: add urldecode?
  _lpSzExtraInfo_Bytes := _WideStringToUTF8(aURLC2.lpszExtraInfo);
  if pos('+', _lpSzExtraInfo_Bytes) > 0 then  //v=1+2 even if passed as 1%2B2, crack url set's it to 1+2
    _lpSzExtraInfo_Bytes := {ansi}stringreplace(_lpSzExtraInfo_Bytes, '+', '%2B', [rfReplaceAll] );

  if (widestring(aURLC2.lpszUserName)='') and (username <> '') then begin
    aURLC2.lpszUserName := pwidechar(Username);
    aURLC2.lpszPassword := pwidechar(Password);
  end;
end;

procedure TIEHTTP.ExecuteURL(url: widestring);
begin
  SetURL(url);
  Execute;
end;

procedure TIEHTTP.Execute;
//var ie_thread : ttimeout;
var
  msg : widestring;
  tmp_dt : tdatetime;
  s : bytestring;
  //response_charset : widestring;
begin
  if working_status <> 0 then begin
    if MessageDlg('Request is in progress (iehttp). Override and continue?', mtConfirmation, [mbOK, mbCancel], 0) <> mrOK then
      exit;
    //raise exception.create('tiehttp: Cannot reuse TIE, while processing request');
    //exit;
  end;
  working_status := 1;

  error_code := 0;
  error := 0;
  error_msg := '';
  bytes_read_total := 0;
  contentSize := 0;

  if furl = '' then raise exception.create('TIEHTTP: no url in execute method');

  try
    result_sl.Clear;
    result_ms.Clear;

    //CrackURL; //crack occurs every time we set the url
    //CrackURL; //FIXED there is a bug that causes the script path to disappear if we progressivly call the same execute command.
    //ProcessReadRequest;

    CalcTimeoutDatetime;
    flag_timeout_occured := false;

    flag_request_to_stop := false;
    flag_cleanup_completed := false;

    last_packet_read_dt := now;
    last_packet_processed_dt := now;

    //create event first
    //create event must be in the same thread as the waitforsingleobject
    //event_handle := CreateEvent(nil, False, False, nil);
    event_handle := CreateEvent(nil, TRUE, False, nil); //2nd param=true means we can reset the event by calling resetEvent

    ie_thread_finished := false;
    //ie_thread_ready := false;
    ie_thread := ttimeout.create(true);
    ttimeout(ie_thread).owner_ie := self;
    ie_thread.Resume;

    //waitForSingleObjectEx(0,infinite,true);

    {$IFDEF tie_debug} LogStr('cp1'); {$endif}
    repeat
      //event_handle := CreateEvent(nil, False, False, nil);

      //check timeout every 500 milliseconds,
      //if request processed before 500ms, WaitForSingleObject will continue
      {$IFDEF tie_debug} LogStr('cp1a'); {$endif}
      try
      {$IFDEF tie_debug} LogStr('about to call WaitForSingleObject. Event handle =' + inttostr(event_handle) + ' .thread done=' + booltostr(ie_thread_finished)); {$endif}

        //mainwait
        //flag_WaitForSingleObject := true;
        WaitForSingleObject(event_handle, 500); //if wfso = WAIT_TIMEOUT then
        //flag_WaitForSingleObject := false;
        ResetEvent(event_handle); //set to non-signeled, resetEvent cancels setEvent
        //CloseHandle( event_handle ); //don't close handle, since event is reusable

        {$IFDEF tie_debug} LogStr('ok. Event handle =' + inttostr(event_handle) + ' .thread done=' + booltostr(ie_thread_finished)); {$endif}
      except
        {$IFDEF tie_debug} LogStr('tiehttp: CANNOT call WaitForSingleObject. Event handle =' + inttostr(event_handle) + ' .thread done=' + booltostr(ie_thread_finished)); {$endif}
        raise exception.create('CANNOT call WaitForSingleObject. Event handle =' + inttostr(event_handle) + ' .thread done=' + booltostr(ie_thread_finished));
        break;
      end;
      {$IFDEF tie_debug} LogStr('cp2'); {$endif}

      //use copy to avoid inconcistency of last_packet_read_dt value, since it may change in thread
      tmp_dt := last_packet_read_dt;
      if assigned(FOnPacketRead) and (tmp_dt>last_packet_processed_dt) then begin
        last_packet_processed_dt := tmp_dt;

        //if not flag_process_onpacketread then
        //  showmessage('managed to process lost packet');

        inc(debug_total_packet_events);
        FOnPacketRead(self);

        //after processing because thread will wait for this flag to continue after successfully processing packet
        //flag_process_onpacketread := false;
      end;

      if assigned(FOnTimer) and (fTimerIntervalSeconds>0)
                            and (last_timer_procesed_dt + (fTimerIntervalSeconds/SecsPerDay) < now) then
      begin
        last_timer_procesed_dt := now;

        //if not flag_process_onpacketread then
        //  showmessage('managed to process lost packet');

        inc(debug_total_timer_events);
        FOnTimer(self);

        //after processing because thread will wait for this flag to continue after successfully processing packet
        //flag_process_onpacketread := false;
      end;


      if not fBlockingMode then //allows user to cancel request
        application.processmessages;

      {$IFDEF tie_debug} LogStr('cp3'); {$endif}

      if (flag_request_to_stop) then begin
        self.working_status := 0; //12mar05
        InternetCloseHandle( hSession );
        //request_to_stop := false;
        result_ms.Clear;
        //msg := '[error 101: canceled by user]';
        //result_ms.Write(pchar(msg)[1], length(msg));
        msg := '';
        error_code := 101; //canceled
        break; //thread may never finish, but there is nothing we can do
      end;
      {$IFDEF tie_debug} LogStr('cp4'); {$ENDIF}

      if ((fTimeout>0) and (now > timeout_datetime)) then begin
        InternetCloseHandle( hSession );
        flag_timeout_occured := true;
        result_ms.Clear;
        result_ms.position := 0;
        //08feb08
        //msg := '[error 100: tiehttp timeout expired]';
        //result_ms.Write(pchar(msg)[1], length(msg));
        //result_ms.WriteBuffer(msg[1], length(msg));
        msg := '';
        error_code := 100; //timeout
        break; //thread may never finish, but there is nothing we can do
      end;
      {$IFDEF tie_debug} LogStr('cp5'); {$endif}
    until ie_thread_finished;
    //if (ie_thread.finished) and (ie_thread <> nil) then
    //  raise exception.create('thread finished but is not nil');

    CloseHandle( event_handle ); //caused crash because we were closing in the thread

    {$IFDEF tie_debug} LogStr('cp100'); {$endif}

    //if ie_thread <> nil then ie_thread.Terminate;
    //for some reason this clears the result_ms on line InternetCloseHandle(hI);
    //if flag_timeout_occured then  CleanUpConnectionMemory;

    //DONT FREE THREAD -> it has freeonterminate := true
    {if  flag_timeout_occured or flag_request_to_stop then
      //
    else
      ttimeout(ie_thread).free;}

    {try  ie_thread.Destroy or free; //does not work on timeout, it waits for thread to stop processing ie request
    except  end;}
    ie_thread := nil;

    /////////

    result_ms.Position := 0;
    CheckAndDecompress(tmemorystream(result_ms), url, unzip_method);

    result_ms.Position := 0;
    //sl_wide.text := my_unit1.Stream_To_TextW(result_ms);
    //sl_wide.text := ByteStringToWideString( Stream_To_ByteString(result_ms) );
    //result_ms.SaveToFile('c:\1.bin');
    //sl_wide.LoadFromStream( result_ms );
    //showmessagexx( sl_wide.text );

    //showmessage( response_headers.text );

    //result_ms.Position := 0;
    //result_sl.LoadFromStream(result_ms);
    s := Stream_To_ByteString(result_ms);
    result_ms.Position := 0;

//Content-Type: text/plain; charset=utf-8
//charset=utf-8
//charset=utf-16
//charset=us-ascii
//response_charset := GetResponseHeaderValue
    if pos('charset=utf-8', response_headers.text) > 0 then
      result_sl.text := _UTF8ToWideString( s )
    else
    if pos('charset=utf-16', response_headers.text) > 0 then
      result_sl.text := PWideChar( pointer(s) ) //pointer() avoids "Suspicious typecast" warning
      //[DCC Warning] IEHTTP3.pas(862): W1044 Suspicious typecast of AnsiString to PWideChar
      //warning is safe, since in utf-16 mode, "s" contains bytes that form a WideString      
    else
    //charset=us-ascii
      result_sl.text := s;
  finally
    setlength(multipartVars, 0);
    setlength(multipartBinaryVars, 0);
    working_status := 0; //finished

    if flag_timeout_occured or flag_request_to_stop then
      CleanUpConnectionMemory;
  end;
  working_status := 0; //finished
  {$IFDEF tie_debug} LogStr('cp200'); {$endif}

  //if (error in  [12030,12017]) then begin //operation canceled
    // do nothing
  //end else begin
  if error > 0 then
    raise exception.create('wininet error # '+inttostr(error) + ' : ' + GetErrorString(error));
  if error_msg <> '' then
    raise exception.create('tiehttp error: ' + error_msg);
end;

procedure TIEHTTP.SetGetStr(const Value: widestring);
begin
  if working_status <> 0 then begin
    raise exception.create('tiehttp: Cannot change parameters while processing request');
    exit;
  end;

  FGetStr := Value;
end;

procedure TIEHTTP.SetPostStr(const Value: widestring);
begin
  if working_status <> 0 then begin
    raise exception.create('tiehttp: Cannot change parameters while processing request');
    exit;
  end;

  FPostStr := Value;
end;


procedure TIEHTTP.SetMultipart(value: boolean);
begin
  if working_status <> 0 then begin
    raise exception.create('tiehttp: Cannot change parameters while processing request');
    exit;
  end;

  FMultipartPOST := value;

  if FMultipartPOST then begin
    //if fRequestMethod <> 'POST' then
    SetRequestMethod('POST');
    //content_type := 'multipart/form-data; boundary='+multipart_boundary;
  end else
    SetRequestMethod(FRequestMethod); //important if switching from multipart to non-multipart 
end;

procedure TIEHTTP.SetRequestMethod(const Value: widestring);
begin
  if working_status <> 0 then begin
    raise exception.create('Cannot change parameters while processing request');
    exit;
  end;

  if (wideuppercase(value) <> 'POST') and (wideuppercase(value) <> 'GET') then begin
    raise exception.create('Unsupported method. Allowed methods: GET, POST');
    exit;
  end;

  FRequestMethod := wideuppercase(Value);

  if RequestMethod='POST' then begin
    if multipartPost then
      content_type := 'multipart/form-data; boundary='+multipart_boundary
    else
      content_type := 'application/x-www-form-urlencoded';
  end else
  if RequestMethod='GET' then
    content_type:='';
end;

procedure TIEHTTP.ConvertToMultiPart;
var
  ar, ar2 : arStr;
  i : integer;
  s: ansistring;
begin
  s := _lpSzExtraInfo_Bytes;

  //bug fix
  //if length(s)=0 then
  //  raise exception.create('multipart error: empty post variables list');
  //exit;

  setlength(ar, 0);  //mch
  setlength(ar2, 0); //mch

  if (length(s)>0) then begin
    if s[1] = '&' then delete(s,1,1);
    ar := split(s, '&');
    for i := 0 to length(ar) - 1 do begin
      ar2 := split(ar[i], '=');
      if length(ar2) <> 2 then begin
        //raise exception.Create('could not convert ' + ar[i] + ' to multipart');
        error_msg := 'could not convert ' + ar[i] + ' to multipart';
        exit;
      end;
      AddMultipartVarW(ar2[0], ar2[1]);
    end;
  end;

  //AddMultipartVarW('X', '12345678901234567890123456789012345678901234567890');

  if (length(multipartVars) = 0) and (length(multipartBinaryVars) = 0) then begin
    error_msg := 'multipart error: no variables to post';
    exit;
    //no exceptions in thread
    //raise exception.create('multipart error: no variables to post');
  end;

  s := '';
  for i := 0 to length(multipartVars) - 1 do begin
    s := s + '--' +  multipart_boundary + #13#10
           + 'Content-Disposition: form-data; name="'+multipartVars[i].f+'"'  + #13#10
           + ''  + #13#10
           +  _WideStringToUTF8( multipartVars[i].v ) + #13#10;
  end;

  for i := 0 to length(multipartBinaryVars) - 1 do begin
    //filename is necessary for asp.net to initialize request.files
    // request.files[] index should be the field name, not the filename
    // HttpPostedFile h = Request.Files[field_name];
    s := s + '--' +  multipart_boundary + #13#10
           + 'Content-Disposition: form-data; name="'+multipartBinaryVars[i].f+'"; filename="'+multipartBinaryVars[i].f+'"'  + #13#10
    //       + 'Content-Disposition: attachment; filename="'+multipartBinaryVars[i].f+'"' + #13#10
    //       + 'Content-Type: image/gif' + #13#10
           + 'Content-Transfer-Encoding: binary'  + #13#10

           + ''  + #13#10
           + multipartBinaryVars[i].v + #13#10;
  end;

  s := s + '--' +  multipart_boundary + '--' + #13#10;

  _lpSzExtraInfo_Bytes := s;
end;

procedure TIEHTTP.SetURL(value: widestring);
begin
  furl := value;
  if furl = '' then begin //clear url
    FillChar(aURLC2, sizeOf(TURLComponents), 0);
    exit;
  end;

  if pos('://', widelowercase(furl)) = 0 then
    furl := 'http://'+furl;

  CrackURL;
end;

procedure TIEHTTP.AddMultipartVar(field: widestring; value: widestring);
begin
  AddMultipartVarW(field, value);
end;

procedure TIEHTTP.AddMultipartVarW(field: widestring; value: widestring);
var
  i : integer;
  p : integer;
begin
  if not multipartpost then begin
    //raise exception.create('tiehttp not in multipart mode');
    error_msg := 'tiehttp not in multipart mode';
    exit;
  end;


  //03apr04 - check if variable already exists and replace
  p := -1;
  for i := 0 to length(multipartVars)-1 do
    if multipartVars[i].f = field then begin
      p := i;
      break;
    end;

  if p = -1 then begin
    i := length(multipartVars)+1;
    setlength(multipartVars, i);
    p := i - 1;
  end;

  multipartVars[p].f := field;
  multipartVars[p].v := value;
end;

procedure TIEHTTP.AddMultipartVarA(field: widestring; value: ansistring);
var
  i : integer;
  p : integer;
begin
  if not multipartpost then begin
    //raise exception.create('tiehttp not in multipart mode');
    error_msg := 'tiehttp not in multipart mode';
    exit;
  end;

  //03apr04 - check if variable already exists and replace
  p := -1;
  for i := 0 to length(multipartBinaryVars)-1 do
    if multipartBinaryVars[i].f = field then begin
      p := i;
      break;
    end;

  if p = -1 then begin
    i := length(multipartBinaryVars)+1;
    setlength(multipartBinaryVars, i);
    p := i - 1;
  end;

  multipartBinaryVars[p].f := field;
  multipartBinaryVars[p].v := value;
end;

procedure TIEHTTP.AddMultipartVar_B64(field: widestring; value: bytestring);
begin
  value := B64Encode(value);
  //showmessage(s);

  value := breakuu( value );

  AddMultipartVarW(field, value);
end;

{procedure TIEHTTP.AddMultipartVar_Compressed(field: string; value: string);
var
  sl : tstringlist;
  temp_fn : string;
begin
  temp_fn := 'temp.txt';

  sl := tstringlist.create;
  sl.text:= value;
  sl.SaveToFile( temp_fn );
  ZLIB_Compress( temp_fn, true);
  iehttp1.AddMultipartFile( field, temp_fn );
  sl.free;
  deletefile(temp_fn);
end;}

procedure TIEHTTP.ReadCookiesAndHeaders(hFile:HInternet);
var
  response_lpOutBuffer : array[1..5000] of widechar;
  response_dwSize : cardinal;
  infoLevel : cardinal;
  i2 : cardinal;
begin
  //read cookies
  //or InternetGetCookie
  //infoLevel := HTTP_QUERY_CUSTOM or HTTP_QUERY_FLAG_REQUEST_HEADERS ;

  {   //HttpQueryInfo(hFile, infoLevel, @lpOutBuffer[1], dwSize, temp1);
   //lpOutBuffer, "HttpQueryInfo Output",MB_OK);
  //lpOutBuffer
  }

  infoLevel := HTTP_QUERY_SET_COOKIE;
  cookies.Clear;
  i2 := 0;
  repeat
    response_dwSize := sizeof(response_lpOutBuffer);
    if not HttpQueryInfoW(hFile, infoLevel, @response_lpOutBuffer[1], response_dwSize, i2) then
      break;
    cookies.Add(copy(response_lpOutBuffer, 1, response_dwSize));
    //fillchar(lpOutBuffer,sizeof(lpOutBuffer), 0);
  until false;

  //read all headers
  response_dwSize := sizeof(response_lpOutBuffer);
  fillchar(response_lpOutBuffer,sizeof(response_lpOutBuffer), 0);
  //HTTP_QUERY_RAW_HEADERS_CRLF
  infoLevel := HTTP_QUERY_RAW_HEADERS_CRLF;
  i2 := 0;
  if HttpQueryInfoW(hFile, infoLevel, @response_lpOutBuffer[1], response_dwSize, i2) then begin
    response_headers.Text := copy(response_lpOutBuffer, 1, response_dwSize);

//sample response headers
//HTTP/1.1 200 OK
//Server: ASP.NET Development Server/9.0.0.0
//Date: Thu, 24 Apr 2008 01:43:30 GMT
//X-AspNet-Version: 2.0.50727
//Cache-Control: private
//Content-Type: text/plain; charset=utf-8
//Content-Length: 57
//Connection: Close

  end;
end;

procedure TIEHTTP.AddMultipartFile(field, filename: widestring);
var
  ms : ttntmemorystream;
begin
  ms := ttntmemorystream.create;
  try
    ms.LoadFromFile(filename);

    AddMultipartStream(field, ms);
  finally
    ms.free;
  end;
end;

procedure TIEHTTP.AddMultipartStream(field: widestring; ms: TMemoryStream);
var
  s : bytestring;
begin
  s := Stream_To_ByteString(ms);

  //s := uuencode(s);
  s := B64Encode(s);

  s := breakuu(s);

  //AddMultipartVarW(field, s);
  AddMultipartVarW(field, s);
end;


procedure TIEHTTP.CalcTimeoutDatetime;
begin
  timeout_datetime := now + (timeout/SecsPerDay);
end;

procedure TIEHTTP.RequestCompleted;
begin
  //if mutex_handle <> 0 then
  //   CloseHandle(mutex_handle);
  //if event_handle <> 0 then
  //  CloseHandle(event_handle);

end;

{procedure TIEHTTP.StopRequest;
begin
  if working_status > 0 then
    flag_request_to_stop := true;
end;}

procedure TIEHTTP.StopRequest(wait: boolean=false);
begin
  if working_status > 0 then
    flag_request_to_stop := true;

  //if wait then
  //  while working_status >0  do
  //    sleep(100);
  //application.processmessages;
end;

procedure TIEHTTP.SetTimeout(const Value: integer);
//var
  //wininet_receive_timeout : Longint;
  //lStructSize : Cardinal;
begin
  //value is in milliseconds
  fTimeout := Value;

  if is_ie6_and_below then exit;

  //ie7 supports timeout
  {wininet_receive_timeout := fTimeout;
  lStructSize := sizeof(wininet_receive_timeout);
  InternetSetOption(nil, INTERNET_OPTION_RECEIVE_TIMEOUT, @wininet_receive_timeout, lStructSize);

  //confirm
  lStructSize := sizeof(wininet_receive_timeout);
  InternetQueryOption(nil, INTERNET_OPTION_RECEIVE_TIMEOUT, @wininet_receive_timeout, lStructSize);}
end;

procedure TIEHTTP.PrepareHeaders1;
begin
  //PrepareHeaders
  if RequestMethod = 'GET' then begin
    //strcat(aURLc2.lpSzUrlPath, aURLc2.lpszExtraInfo); //already has '?'
    aURLc2.lpSzUrlPath := pwidechar( widestring(aURLc2.lpSzUrlPath) + widestring(aURLc2.lpszExtraInfo) );
  end;

  ///12mar03 - add get info before we open the connection
  if FgetStr <> '' then begin

    if pos('?', widestring(aURLc2.lpszUrlPath)) = 0 then
      FgetStr := '?' + FgetStr
    else
      FgetStr := '&' + FgetStr;

    //size1 := length(aURLc2.lpszUrlPath) + length(FgetStr) + 100;
    //getmem(p1, size1);
    //strpcopy(p1, aURLc2.lpszUrlPath);
    //strcat(p1, pchar(FgetStr));

    //todo: enable
    aURLc2.lpszUrlPath := pwidechar( widestring(aURLc2.lpszUrlPath) + WideString(aURLc2.lpszUrlPath) );

    aURLc2.dwUrlPathLength := length( aURLc2.lpszUrlPath );
    FgetStr := '';
  end;
end;
procedure TIEHTTP.PrepareHeaders2;
var
  proxy_auth_header : widestring;
begin
  if RequestMethod = 'GET' then begin
    _lpSzExtraInfo_Bytes := '';
  end;
  if pos('?', _lpSzExtraInfo_Bytes) = 1 then begin
    Delete(_lpSzExtraInfo_Bytes, 1, 1);
  end;

  //23feb03 - add post info after we process the url
  if FpostStr <> '' then begin

    //5aug03: bug fix: aURLc2.lpszExtraInfo cannot be compared to '' (pchar <-> string)
    if widestring(_lpSzExtraInfo_Bytes) <> '' then FpostStr := '&' + FpostStr;

    if RequestMethod='GET' then
      raise exception.create('No poststr allowed in GET method');

    _lpSzExtraInfo_Bytes := _WideStringToUTF8( widestring(aURLc2.lpSzExtraInfo) + widestring(FpostStr) );

    FpostStr := '';
  end;

  //very important for POST
  //---------------------------
  if RequestMethod='POST' then begin
    if content_type='' then
      content_type := 'application/x-www-form-urlencoded';
  end else
    content_type := '';

  if content_type <> '' then
    if pos('Content-Type:', content_type) = 0 then //03apr04
      content_type := 'Content-Type: ' + content_type;

  if content_type <> '' then
    AddHeader(content_type);

  proxy_auth_header := '';
  if proxy_username <> '' then begin
    //InternetSetOption(hSession, INTERNET_OPTION_PROXY_USERNAME,  pchar(proxy_username), strlen(pchar(proxy_username)));
    //InternetSetOption(hSession, INTERNET_OPTION_PROXY_PASSWORD, pchar(proxy_password), strlen(pchar(proxy_password)));
    proxy_auth_header := 'Proxy-Authorization: Basic '
        + B64Encode(proxy_username + ':' + proxy_password);
        //+ '==';
    AddHeader(proxy_auth_header);
  end;

  if request_headers.text <> '' then
    AddHeader(request_headers.text);

  if pos('multipart', WideLowerCase(content_type)) > 0 then
    ConvertToMultiPart;
end;


procedure TIEHTTP.ReadResponse;
var
  read_result : boolean;
  bytesRead: DWORD;
begin
  repeat
    // Get the next chunk
    read_result := InternetReadFile(hFile, @buffer, sizeof(buffer), bytesRead);

    if flag_timeout_occured then begin
      result_ms.clear;
      break;
    end;

    // Pass it along to the stream
    //result_ms.WriteBuffer(buffer^, bytesRead); //if buffer is a PByteArray (pointer)
    result_ms.WriteBuffer(buffer[0], bytesRead); //if buffer is a TByteArray (record)

    //result_ms.Position := 0;
    //result_ms.SaveToFile(ForceUniqueFilename('c:\temp\tiehttp_test\1.txt'));

    inc(bytes_read_total, bytesread);
    inc(debug_total_packets);
    last_packet_read_dt := now;

    CalcTimeoutDatetime;

    //if ie request_to_cancel then free;
    if flag_request_to_stop then break;
    
    if (bytesread > 0) and assigned(FOnPacketRead) then begin
      SetEvent(event_handle);
      if getlasterror <> 0 then
        RaiseLastOSError;
    end;

  until (read_result and (bytesRead = 0)); //Repeat until we get no more data
end;

procedure TIEHTTP.CleanUpConnectionMemory;
begin
  if flag_cleanup_completed then exit;

  flag_cleanup_completed := true; //in order to ensure no double requests will be allowed

  //3apr04
  if multipartpost then
    //aURLc2.lpSzExtraInfo := '';
    _lpSzExtraInfo_Bytes := '';

  // Clean up by closing the handles.
  // According to the docs, we only need to close aHI,
  // which should automatically close the other ones that descend from it
  InternetCloseHandle(hFile);
  InternetCloseHandle(hConnect);
  InternetCloseHandle(hSession);

  //flag_cleanup_completed := true;
end;

procedure TIEHTTP.SetBlockingMode(const Value: boolean);
begin
  fBlockingMode := Value;
end;

function TIEHTTP.GetErrorString(error_code : integer) : widestring;
begin
  case error_code  of
    12001: result := '(Out of handles)';
    12002: result := '(Timeout)';
    12004: result := '(Internal Error)';
    12005: result := '(Invalid URL)';
    12006: result := '(Unrecognized Scheme)';
    12007: result := '(Service Name Not Resolved)';
    12008: result := '(Protocol Not Found)';
    12013: result := '(Incorrect User Name)';
    12014: result := '(Incorrect Password)';
    12015: result := '(Login Failure)';
    12016: result := '(Invalid Operation)';
    12017: result := '(Operation Canceled)';
    12020: result := '(Not Proxy Request)';
    12023: result := '(No Direct Access)';
    12026: result := '(Request Pending)';
    12027: result := '(Incorrect Format)';
    12028: result := '(Item not found)';
    12029: result := '(Cannot connect)';
    12030: result := '(Connection Aborted)';
    12031: result := '(Connection Reset)';
    12033: result := '(Invalid Proxy Request)';
    12034: result := '(Need UI)';
    12035: result := '(Sec Cert Date Invalid)';
    12038: result := '(Sec Cert CN Invalid)';
    12044: result := '(Client Auth Cert Needed)';
    12045: result := '(Invalid CA Cert)';
    12046: result := '(Client Auth Not Setup)';
    12150: result := '(HTTP Header Not Found)';
    12152: result := '(Invalid HTTP Server Response)';
    12153: result := '(Invalid HTTP Header)';
    12154: result := '(Invalid Query Request)';
    12156: result := '(Redirect Failed)';
    12159: result := '(TCP/IP not installed)';
    else result := '(Unknown WININET error # ' + inttostr(error_code) + ')';
  end;
end;

procedure TIEHTTP.AddHeader(s: widestring);
begin
  if extraHeaders <> '' then
    s := #13#10 + s;

  extraHeaders := extraHeaders + s;
end;

procedure TIEHTTP.SetTimeInterval(const Value: Integer);
begin
  fTimerIntervalSeconds := Value;
end;

function TIEHTTP.CheckIEOnline: boolean;
//returns FALSE if internet explorer is set to "work offline"
var
  lpdwBufferLength: DWORD;
  dwFlags : DWord;

  //ci : INTERNET_CONNECTED_INFO;
  //ci_len : integer;
begin
  lpdwBufferLength := 4;

  InternetQueryOption(nil, INTERNET_OPTION_CONNECTED_STATE,
                       @dwFlags, lpdwBufferLength );

  result := (dwFlags = INTERNET_STATE_CONNECTED);

               //INTERNET_STATE_DISCONNECTED_BY_USER
    //dwFlags := dwFlags or INTERNET_OPTION_OFFLINE_MODE;
    //dwFlags := 1;
   // ci.dwConnectedState := INTERNET_STATE_CONNECTED;

    {InternetGoOnline(
     InternetSetOption(nil, INTERNET_OPTION_CONNECTED_STATE, @ci, sizeof(ci) );
     InternetQueryOption(nil, INTERNET_OPTION_CONNECTED_STATE, @dwFlags, lpdwBufferLength );}
end;

function TIEHTTP.GetResponseHeaderIdx(header_name: widestring): integer;
var
  i : integer;
begin
  //remove possible colons and spaces in header name
  header_name := trim(widelowercase(header_name));

  if header_name[length(header_name)] = ':' then
    delete(header_name, length(header_name), 1);

  //header_name := stringreplace(header_name, ':', '', [rfReplaceAll]);
  //header_name := stringreplace(header_name, ' ', '', [rfReplaceAll]);

  result := -1;
  for i := 0 to response_headers.count-1 do begin
    if pos(header_name + ': ', widelowercase(response_headers[i])) = 1 then begin
      result := i;
      exit;
    end;
  end;
end;

function TIEHTTP.GetRequestHeaderIdx(header_name: widestring): integer;
var i : integer;
begin
  //remove possible colons and spaces in header name
  header_name := trim(widelowercase(header_name));

  if header_name[length(header_name)] = ':' then
    delete(header_name, length(header_name), 1);

  //header_name := stringreplace(header_name, ':', '', [rfReplaceAll]);
  //header_name := stringreplace(header_name, ' ', '', [rfReplaceAll]);

  result := -1;
  for i := 0 to request_headers.count-1 do begin
    if pos(header_name + ': ', widelowercase(request_headers[i])) = 1 then begin
      result := i;
      exit;
    end;
  end;
end;

function TIEHTTP.GetResponseHeaderValue(header_name: widestring): widestring;
var
  idx : integer;
  s : widestring;
begin
  s := '';
  idx := GetResponseHeaderIdx(header_name);
  if idx = -1 then exit;

  s := response_headers[idx];
  delete(s, 1, Pos(': ',s)+1);
  Result := s;
end;

function TIEHTTP.GetRequestHeaderValue(header_name: widestring): widestring;
var
  idx : integer;
  s : widestring;
begin
  s := '';
  idx := GetRequestHeaderIdx(header_name);
  if idx = -1 then exit;

  s := request_headers[idx];
  delete(s, 1, Pos(': ',s)+1);
  Result := s;
end;

procedure TIEHTTP.DeleteRequestHeader(header_name: widestring);
var
  idx: integer;
begin
  idx := GetRequestHeaderIdx(header_name);
  if idx = -1 then exit;
  request_headers.Delete(idx);
end;

procedure TIEHTTP.AddRequestHeader(header_name: widestring; value: widestring);
var
  idx: integer;
begin
  header_name := trim(header_name);
  if header_name[length(header_name)] = ':' then
    delete(header_name, length(header_name), 1);

  idx := GetRequestHeaderIdx(header_name);
  if idx > -1 then
    DeleteRequestHeader(header_name);

  request_headers.Add(header_name + ': ' + value);
end;

function TIEHTTP.Canceled : boolean;
begin
  result := error_code = 101;
end;

function TIEHTTP.FileToB64String(filename: widestring): bytestring;
var
  ms : ttntmemorystream;
  s : bytestring;
begin
  ms := ttntmemorystream.create;
  try
    ms.LoadFromFile(filename);
    s := Stream_To_ByteString(ms);
  finally
    ms.free;
  end;

  s := B64Encode(s);

  s := breakuu(s);

  result := s;
end;

end.

