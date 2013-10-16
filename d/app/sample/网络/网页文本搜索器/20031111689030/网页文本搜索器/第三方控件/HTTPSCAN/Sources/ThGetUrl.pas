{(((((((((((((((((((((((((((((((((((((O)))))))))))))))))))))))))))))))))))))))
(                                                                            )
(                              THttpScan v4.02                               )
(                       Copyright (c) 2001 Michel Fornengo                   )
(                             All rights reserved.                           )
(                                                                            )
( home page:     http://www.delphicity.com                                   )
( contacts:      contact@delphicity.com                                      )
( support:       support@delphicity.com                                      )
((((((((((((((((((((((((((((((((((((((O)))))))))))))))))))))))))))))))))))))))
(                                                                            )
( Description: get url manager                                               )
(                                                                            )
((((((((((((((((((((((((((((((((((((((O))))))))))))))))))))))))))))))))))))))}

unit ThGetUrl;

interface

uses Windows,
     ThUrlQue, ThCrkUrl, ThGetThr;

type

  TMFHttpGetState = (GETHTTP_NOTUSED, GETHTTP_WAITING, GETHTTP_PREPARING, GETHTTP_GETTING, GETHTTP_THREAD_DONE, GETHTTP_OK, GETHTTP_ERROR);
  TMFHttpGetRequest = (GETHTTP_HEAD, GETHTTP_BODY);

  TOnGetUrlHeadComplete = procedure (Sender: TObject; Url : string ; Head_ : String ; StatusCode : integer ; ContentType : string ; ContentLength : integer ; DepthSearchLevel_ : integer ; var OkToGetData : boolean ; CountArea : integer) of object;
  TOnError = procedure (Sender : TObject ; ErrorCode : DWord ; ErrorMsg : string) of object;
  TOnFileComplete = procedure(Sender: TObject; FilePath: String; ContentLength: Integer) of object;
  TOnDataComplete = procedure(Sender: TObject; Result: String) of object;
  TOnGetUrlLog = procedure(Sender: TObject; LogMessage : string) of object;

  TMFHttpGet = class(TObject)
  private

    Continue : boolean;

    FAcceptTypes: String;
    FAgent: String;
    FReuseCache: Boolean;
    FUserName: String;
    FPassword: String;
    FPostQuery: String;
    FReferringUrl: String;
    FWait: Boolean;

    FLog : TOnGetUrlLog;

    GetThread: THTTPGetThread;

    FError: TOnError;

    FState : TMFHttpGetState;
    FRequest : TMFHttpGetRequest;
    FThreadDoneOk : boolean;
    FThreadABorted : boolean;

    FStatusCode : integer;
    FErrorMsg : string;

    FContentLength : LongWord;

    FOnProgress : TOnThreadProgress;

    FConnectTimeOut : dword;
    FTimeOut : integer;

    FThreadRunning : boolean;


    FBody : string;
    FHead : string;

    FKilled : boolean;

    FGetAction : TGetAction;

    FProxyType : TProxyType;
    FProxyAddress : string;
    FProxyPort : integer;
    FProxyUser : string;
    FProxyPassword : string;

    FOnHeadComplete : TOnGetUrlHeadComplete;

    procedure HeadComplete (Sender: TObject; Head_ : String ; StatusCode_ : integer ; ContentType_ : string ; ContentLength_ : integer ; var OkToGetData : boolean);
    procedure Progress (Sender : TObject ; BytesRead : longword);
    procedure OnDataComplete (var DataString : string);
    procedure OnStatusCode (StatusCode_ : integer);
    procedure OnEndThread (Sender: TObject);
    function GetTimeOut : integer;
    procedure SetTimeOut (Value : integer);

  public
    CrackedUrl : TCrackUrl;
    DepthSearchLevel : integer;
    RetryCount : integer;

    CountArea : integer;  // used to give an unique number to the couple HREF & SRC Urls
    HrefOrSrc : char; // idem
    ReturnTag : integer; // any value returned to the calling app

    constructor Create;
    destructor Destroy ; override;

    procedure Get (Request_ : TMFHttpGetRequest = GETHTTP_BODY);
    procedure KillGet;
    procedure FinalizeGet;
    procedure RefreshTimeOut;
    property ThreadDoneOk : boolean read FThreadDoneOk;
    property ThreadAborted : boolean read FThreadAborted;
    property Killed : boolean read FKilled;

    property GetAction : TGetAction read FGetAction write FGetAction;
    property TimeOut : integer read GetTimeOut write SetTimeOut;
    property ConnectTimeOut : dword read FConnectTimeOut write FConnectTimeOut;
    property AcceptTypes: String read FAcceptTypes write FAcceptTypes;
    property Agent: String read FAgent write FAgent;
    property ReuseCache: Boolean read FReuseCache write FReuseCache;
    property UserName: String read FUserName write FUserName;
    property Password: String read FPassword write FPassword;
    property ContentLength : LongWord read FContentLength write FContentLength;
    property PostQuery: String read FPostQuery write FPostQuery;
    property ReferringUrl: String read FReferringUrl write FReferringUrl;
    property Wait: Boolean read FWait write FWait;


    property State : TMFHttpGetState read FState write FState;
    property Request : TMFHttpGetRequest read FRequest write FRequest;

    property StatusCode : integer read FStatusCode;
    property Head : string read FHead;
    property Body : string read FBody write FBody;

    property ErrorMsg : string read FErrorMsg;
    property OnError : TOnError read FError write FError;
    property OnHeadComplete : TOnGetUrlHeadComplete read FOnHeadComplete write FOnHeadComplete;
    property ProxyType : TProxyType read FProxyType write FProxyType;
    property ProxyAddress : string read FProxyAddress write FProxyAddress;
    property ProxyPort : integer read FProxyPort write FProxyPort;
    property ProxyUser : string read FProxyUser write FProxyUser;
    property ProxyPassword : string read FProxyPassword write FProxyPassword;
    property OnLog : TOnGetUrlLog read FLog write FLog;
    property OnProgress : TOnThreadProgress read FOnProgress write FOnProgress;
  end;


implementation

Uses Classes;

constructor TMFHttpGet.Create;
begin
  FThreadRunning := false;

  FState := GETHTTP_NOTUSED;

  CrackedUrl := TCrackUrl.Create;

  Continue := false;

  FTimeOut := 300000;

  FKilled := false;

  FAgent := 'Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)';

  ProxyType := PROXY_DEFAULT;
  ProxyAddress := '';
  ProxyPort := 80;
  ProxyUser := '';
  ProxyPassword := '';

  DepthSearchLevel := 1;

  FGetAction := HEAD_ONLY;

  FWait := false;
  FHead := '';
  FBody := '';

  FRequest := GETHTTP_BODY;

  FPostQuery := '';

  FErrorMsg := '';
end;

destructor TMFHttpGet.Destroy;
begin
  CrackedUrl.Free;
  inherited Destroy;
end;

function TMFHttpGet.GetTimeOut : integer;
begin
   Result := integer (FTimeOut div 1000);
end;

procedure TMFHttpGet.SetTimeOut (Value : integer);
begin
   FTimeOut := dword (Value * 1000);
end;

procedure TMFHttpGet.OnStatusCode (StatusCode_ : integer);
begin
   FStatusCode := StatusCode_;
end;

procedure TMFHttpGet.OnEndThread (Sender: TObject);
begin
   FThreadDoneOk := GetThread.DoneOk;
   FThreadAborted := GetThread.Aborted;
   FState := GETHTTP_THREAD_DONE;
end;

procedure TMFHttpGet.Progress (Sender : TObject ; BytesRead : longword);
begin
   if Assigned (FOnProgress) then if FState = GETHTTP_GETTING then FOnProgress (Self, BytesRead);
end;

procedure TMFHttpGet.HeadComplete (Sender: TObject; Head_ : String ; StatusCode_ : integer ; ContentType_ : string ; ContentLength_ : integer ; var OkToGetData : boolean);
begin
   FContentLength := ContentLength_;
   FHead := Head_;
   if Assigned (FOnHeadComplete) then if Continue then FOnHeadComplete (sender, CrackedUrl.Url, Head, StatusCode_, ContentType_, ContentLength_, DepthSearchLevel, OkToGetData, CountArea);
end;

procedure TMFHttpGet.RefreshTimeOut;
begin
   FConnectTimeOut := GetTickCount;
   inc (FConnectTimeOut, FTimeOut);
end;

procedure TMFHttpGet.Get (Request_ : TMFHttpGetRequest = GETHTTP_BODY);
var
  Msg: TMsg;
begin
 if CrackedUrl.CrackOk then begin
   FState := GETHTTP_GETTING;
   FRequest := Request_;
   FThreadAborted := false;
   FThreadDoneOk := false;

   if not FThreadRunning then begin
      FThreadRunning := true;
      RefreshTimeOut;


      if GetAction <> STORE_OTHER then begin
         FContentLength := 0;
         FKilled := false;
         Continue := true;
         GetThread := THTTPGetThread.Create(CrackedUrl, FAgent, GetAction,
                FReferringUrl, FUserName, FPassword,
                FReuseCache, FProxyType, FProxyAddress, FProxyPort, FProxyUser, FProxyPassword,
                OnLog, OnDataComplete, Progress, HeadComplete, OnStatusCode, OnEndThread, RefreshTimeOut);
         GetThread.Priority := tpTimeCritical;
         GetThread.Resume;
         if FWait then begin
            while Assigned(GetThread) do begin
               while PeekMessage(Msg, 0, 0, 0, PM_REMOVE) do begin
                  TranslateMessage(Msg);
                  DispatchMessage(Msg);
               end;
            end;
         end;
      end;
   end
   else begin
     //MessageDlg ('thread deja assigne : ' + CrackedUrl.Url, mterror, [mbok], 0);
   end;
  end
  else begin
     FState := GETHTTP_WAITING; // invalid url
  end;
end;

procedure TMFHttpGet.OnDataComplete (var DataString : string);
begin
   FBody := DataString;
end;

procedure TMFHttpGet.KillGet;
begin
  FKilled := true;
  if FThreadRunning then begin
     Continue := false;
     GetThread.CloseHandles;
     GetThread.Terminate;
  end;
{  else begin
     FState := GETHTTP_WAITING;
  end;}
end;

procedure TMFHttpGet.FinalizeGet;
begin
   if assigned (FLog) then if Continue then FLog (self, 'thread done: ' + CrackedUrl.Url);
   FThreadRunning := false;
end;

end.
