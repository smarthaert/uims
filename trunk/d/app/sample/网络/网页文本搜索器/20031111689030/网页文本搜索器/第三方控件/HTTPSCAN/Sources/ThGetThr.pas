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
( Description: get thread manager                                            )
(                                                                            )
((((((((((((((((((((((((((((((((((((((O))))))))))))))))))))))))))))))))))))))}

unit ThGetThr;

interface

Uses Classes, WinInet,
     ThUrlQue, ThCrkUrl;

const
   SMALLBUFFERSIZE = $400;
   HEADERBUFFERSIZE = $800;
Type
  TProxyType = (PROXY_DIRECT, PROXY_USEPROXY, PROXY_DEFAULT);

  TFile = File;
  PtFile = ^TFile;

  TOnThreadHeadComplete = procedure (Sender: TObject; Head : String ; StatusCode : integer ; ContentType : string ; ContentLength : integer ; var GetData : boolean) of object;
  TOnThreadProgress = procedure (Sender : TObject ; BytesRead : longword) of object;
  TOnThreadDataComplete = procedure (var DataString : string) of object;
  TOnStatusCode = procedure (StatusCode : integer) of object;
  TOnRefreshTimeOut = procedure of object;
  TOnLogThr = procedure(Sender: TObject; LogMessage : string) of object;

  THTTPGetThread = class(TThread)

  private
    CrackedUrl : TCrackUrl;

    FAccepted : string;
    FAgent : string;

    FRequest : string;

    FOkToGetData : boolean;

    FReferer: String;
    FUsername : string;
    FPassword : string;

    FFilePath : string;

    FDataString : string;

    FLog : TOnLogThr;

    FDoneOk: Boolean;
    FAborted : boolean;

    FContentLength: Integer;
    FStatusCode : integer;
    FHead, FType : string;

    FOnHeadComplete : TOnThreadHeadComplete;
    FOnProgress : TOnThreadProgress;
    FOnDataComplete : TOnThreadDataComplete;
    FOnStatusCode : TOnStatusCode;
    FOnRefreshTimeOut : TOnRefreshTimeOut;


    FStoreToDataString : boolean;

    SmallBuffer1 : array[0..SMALLBUFFERSIZE + 1] of char;

    FProxyType : TProxyType;
    FProxyAddress : string;
    FProxyPort : integer;
    FProxyUser : string;
    FProxyPassword : string;

    LogMessage : string;

    hSession, hConnect, hRequest: hInternet;

    BytesRead, BytesToRead: LongWord;

    procedure HeadComplete;
    //procedure Log;
    procedure Progress;
    procedure DataComplete;
    procedure StatusCode;
    procedure RefreshTimeOut;

  protected
    procedure Execute; override;

  public
     constructor Create(CrackedUrl_ : TCrackUrl ; Agent_ : string ; GetAction : TGetAction;
            Referer_ : string; UserName_ : string ;
            Password_ : string ; ReuseCache_ : boolean ; ProxyType_ : TProxyType ;
            ProxyAddress_ : string ; ProxyPort_ : integer ; ProxyUser_, ProxyPassword_ : string ;
            OnLog_: TOnLogThr ; OnDataComplete_ : TOnThreadDataComplete ; OnProgress_ : TOnThreadProgress ;
            OnHeadComplete_ : TOnThreadHeadComplete ; OnStatusCode_ : TOnStatusCode ; OnEndThread_ : TNotifyEvent ; OnRefreshTimeOut_ : TOnRefreshTimeOut);
     property DoneOk : boolean read FDoneOk;
     property Aborted : boolean read FABorted;
     procedure CloseHandles;

     property ContentType : string read FType;
     property ContentLength : integer read FContentLength;
     property Agent : string read FAgent write FAgent;
     property FilePath : string read FFilePath write FFilePath;
     property Request : string read FRequest write FRequest;
     property Referer : string read FReferer write FReferer;
     property OnHeadComplete : TOnThreadHeadComplete read FOnHeadComplete write FOnHeadComplete;
     property OnProgress : TOnThreadProgress read FOnProgress write FOnProgress;
     property ProxyType : TProxyType read FProxyType write FProxyType;
     property ProxyAddress : string read FProxyAddress write FProxyAddress;
     property ProxyPort : integer read FProxyPort write FProxyPort;
     property ProxyUser : string read FProxyUser write FProxyUser;
     property ProxyPassword : string read FProxyPassword write FProxyPassword;
     property OnDataComplete : TOnThreadDataComplete read FOnDataComplete write FOnDataComplete;
     property OnRefreshTimeOut : TOnRefreshTimeOut read FOnRefreshTimeOut write FOnRefreshTimeOut;
  end;

implementation

Uses Windows, SysUtils, Forms;

constructor THTTPGetThread.Create(CrackedUrl_ : TCrackUrl ; Agent_ : string ; GetAction : TGetAction ;
            Referer_ : string; UserName_ : string ;
            Password_ : string ; ReuseCache_ : boolean ; ProxyType_ : TProxyType ;
            ProxyAddress_ : string ; ProxyPort_ : integer ; ProxyUser_, ProxyPassword_ : string ;
            OnLog_: TOnLogThr ; OnDataComplete_ : TOnThreadDataComplete ; OnProgress_ : TOnThreadProgress ;
            OnHeadComplete_ : TOnThreadHeadComplete ; OnStatusCode_ : TOnStatusCode ; OnEndThread_ : TNotifyEvent ; OnRefreshTimeOut_ : TOnRefreshTimeOut);
begin
   inherited Create (True);

   FAborted := false;
   FLog := OnLog_;
   FOnDataComplete := OnDataComplete_;
   FOnProgress := OnProgress_;
   FOnHeadComplete := OnHeadComplete_;
   FOnStatusCode := OnStatusCode_;
   FOnRefreshTimeOut := OnRefreshTimeOut_;
   OnTerminate := OnEndThread_;


   ProxyType := ProxyType_;
   ProxyAddress := ProxyAddress_;
   ProxyPort := ProxyPort_;
   ProxyUser := ProxyUser_;
   ProxyPassword := ProxyPassword_;
   BytesRead := 0;

   FreeOnTerminate := True;

   CrackedUrl := CrackedUrl_;

   FUsername := UserName_;
   FPassword := PassWord_;

   FAccepted := '*/*';


   FStoreToDataString := false;

   FStoreToDataString := false;
   case GetAction of
      HEAD_ONLY : begin
      end;
      STORE_TO_DATASTRING : begin
         FStoreToDataString := true;
      end;
   end;

   FAgent := Agent_;
   FReferer := Referer_;
   FRequest := '';

   LogMessage := '';
end;

//procedure THttpGetThread.Log;
//begin
//   FLog (Self, LogMessage);
//end;

procedure THttpGetThread.HeadComplete;
begin
   FOnHeadComplete (Self, FHead, FStatusCode, FType, FContentLength, FOkToGetData);
end;

procedure THttpGetThread.Progress;
begin
   FOnProgress (Self, BytesRead);
end;

procedure THttpGetThread.RefreshTimeOut;
begin
   FOnRefreshTimeOut;
end;

procedure THttpGetThread.StatusCode;
begin
   FOnStatusCode (FStatusCode);
end;

procedure THttpGetThread.DataComplete;
begin
   FOnDataComplete (FDataString);
end;

procedure THttpGetThread.CloseHandles;
begin
   if hRequest <> nil then begin
      InternetCloseHandle(hRequest);
      hRequest := nil;
   end;
   if hConnect <> nil then begin
      InternetCloseHandle(hConnect);
      hConnect := nil;
   end;
   if hSession <> nil then begin
      InternetCloseHandle(hSession);
      hSession := nil;
   end;
end;

procedure THTTPGetThread.Execute;
var
  Fini, Ok : boolean;
  dwBufLen, dwIndex: DWord;
  Resent : boolean;
  BytesAvail : DWord;
  InternetReadBuffer : PChar;
  HeaderBuffer : PChar;
  UrlPathExtraInfo : string;
  CountRefreshTimeOut : integer;
  //ms : DWord;
  Label Resend;
begin
 try
   CountRefreshTimeOut := 0;
   FDoneOk := true;

   hSession := nil;
   hConnect := nil;
   hRequest := nil;

   dwIndex  := 0;
   dwBufLen := SMALLBUFFERSIZE;

   {$IFDEF DEBUG}
   if Assigned (Flog) then begin
      LogMessage := 'thread: before open';
      Synchronize (Log);
   end;
   {$ENDIF}

   case ProxyType of
       PROXY_DEFAULT : hSession := InternetOpen(PChar (FAgent), INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
        PROXY_DIRECT : hSession := InternetOpen(PChar (FAgent), INTERNET_OPEN_TYPE_DIRECT, nil, nil, 0);
      PROXY_USEPROXY : hSession := InternetOpen(PChar (FAgent), INTERNET_OPEN_TYPE_PROXY , PChar (FProxyAddress + ':' + inttostr(FProxyPort)), nil, 0);
   end;

   if (hsession = nil) or Terminated then begin
      FDoneOk := False;
      Exit;
   end;

   {ms := 1000;
   InternetSetOption(hsession, INTERNET_OPTION_CONNECT_TIMEOUT, @ms, sizeof(ms));
   InternetSetOption(hsession, INTERNET_OPTION_CONTROL_RECEIVE_TIMEOUT, @ms, sizeof(ms));
   InternetSetOption(hsession, INTERNET_OPTION_CONTROL_SEND_TIMEOUT, @ms, sizeof(ms));
   InternetSetOption(hsession, INTERNET_OPTION_DATA_SEND_TIMEOUT, @ms, sizeof(ms));
   InternetSetOption(hsession, INTERNET_OPTION_DATA_RECEIVE_TIMEOUT, @ms, sizeof(ms));}

   {$IFDEF DEBUG}
   if Assigned (Flog) then begin
      LogMessage := 'thread: opened, befor connect';
      Synchronize (Log);
   end;
   {$ENDIF}

   hConnect := InternetConnect(hSession, CrackedUrl.UrlComp.lpszHostname, CrackedUrl.UrlComp.nPort, CrackedUrl.UrlComp.lpszUserName, CrackedUrl.UrlComp.lpszPassword, INTERNET_SERVICE_HTTP, 0, 0);
   if (hConnect = nil) or Terminated then begin
      FDoneOk := False;
      Exit;
   end;

   {$IFDEF DEBUG}
   if Assigned (Flog) then begin
      LogMessage := 'connected, before open request';
      Synchronize (Log);
   end;
   {$ENDIF}

   UrlPathExtraInfo := string (CrackedUrl.UrlComp.lpszUrlPath) + string (CrackedUrl.UrlComp.lpszExtraInfo);
   hRequest := HttpOpenRequest(hConnect, PChar ('GET'), PChar (UrlPathExtraInfo), PChar ('HTTP/1.0'),
                                         PChar (FReferer), nil, INTERNET_FLAG_RELOAD, 0);

   if (hRequest = nil) or Terminated then begin
      FDoneOk := False;
      Exit;
   end;

   {$IFDEF DEBUG}
   if Assigned (Flog) then begin
      LogMessage := 'thread: request opened, before sendrequest';
      Synchronize (Log);
   end;
   {$ENDIF}

   Resent := false;

   Resend:

   Application.ProcessMessages;

   if FRequest = '' then begin
      Ok := HttpSendRequest(hRequest, nil, 0, nil, 0)
   end
   else begin
      Ok := HttpSendRequest(hRequest, 'Content-Type: application/x-www-form-urlencoded',
                                       HTTP_QUERY_CONTENT_DISPOSITION,
                                       PChar(FRequest),
                                       Length(FRequest));
   end;
   if (Ok = false) or Terminated then begin
      FDoneOk := False;
      Exit;
   end;

   {$IFDEF DEBUG}
   if Assigned (Flog) then begin
      LogMessage := 'thread: request send, before query info';
      Synchronize (Log);
   end;
   {$ENDIF}

   dwIndex  := 0;
   dwBufLen := SMALLBUFFERSIZE;
   SmallBuffer1[0] := char(0);
   Ok := HttpQueryInfo(hRequest, HTTP_QUERY_STATUS_CODE, @SmallBuffer1, dwBufLen, dwIndex);

   if (Ok = false) or Terminated then begin
      FDoneOk := False;
      Exit;
   end;

   FStatusCode := StrToInt(StrPas(SmallBuffer1));

   Synchronize (StatusCode);

   {$IFDEF DEBUG}
   if Assigned (Flog) then begin
      LogMessage := 'query info done, status:' + StrPas (SmallBuffer1);
      Synchronize (Log);
   end;
   {$ENDIF}

   if not Resent then begin
      if FStatusCode = HTTP_STATUS_PROXY_AUTH_REQ then begin
         StrPCopy (SmallBuffer1, FProxyUser);
         InternetSetOption (hRequest, INTERNET_OPTION_PROXY_USERNAME, @SmallBuffer1, StrLen (SmallBuffer1));
         StrPCopy (SmallBuffer1, FProxyPassword);
         InternetSetOption (hRequest, INTERNET_OPTION_PROXY_PASSWORD, @SmallBuffer1, StrLen (SmallBuffer1));
         {$IFDEF DEBUG}
         if Assigned (Flog) then begin
            LogMessage := 'thread: proxy need password, set option done';
            Synchronize (Log);
         end;
         {$ENDIF}
         Resent := true;
         goto Resend;
      end
      else if FStatusCode = HTTP_STATUS_DENIED then begin
         StrPCopy (SmallBuffer1, FUsername);
         InternetSetOption (hRequest, INTERNET_OPTION_USERNAME, @SmallBuffer1, StrLen (SmallBuffer1));
         StrPCopy (SmallBuffer1, FPassword);
         InternetSetOption (hRequest, INTERNET_OPTION_PASSWORD, @SmallBuffer1, StrLen (SmallBuffer1));
         Resent := true;
        {$IFDEF DEBUG}
         if Assigned (Flog) then begin
            LogMessage := 'thread: denied need authorization, resend with password';
            Synchronize (Log);
         end;
         {$ENDIF}
         goto Resend;
      end;
   end
   else begin
      if (FStatusCode = HTTP_STATUS_PROXY_AUTH_REQ)
         or (FStatusCode = HTTP_STATUS_DENIED) then begin
        {$IFDEF DEBUG}
         if Assigned (Flog) then begin
            LogMessage := 'thread: authorization denied with password, abort';
            Synchronize (Log);
         end;
         {$ENDIF}
         FDoneOk := False;
         Exit;
      end;
   end;

   {$IFDEF DEBUG}
   if Assigned (Flog) then begin
      LogMessage := 'pre query info';
      Synchronize (Log);
   end;
   {$ENDIF}

   dwIndex  := 0;
   dwBufLen := HEADERBUFFERSIZE;
   GetMem (HeaderBuffer, HEADERBUFFERSIZE + 1);

   Ok := HttpQueryInfo(hRequest, HTTP_QUERY_RAW_HEADERS_CRLF, HeaderBuffer, dwBufLen, dwIndex);
   if (Ok = false) or Terminated then begin
      FreeMem (HeaderBuffer);
      FDoneOk := False;
      Exit;
   end;
   HeaderBuffer[dwBufLen] := char(0);
   FHead := string (HeaderBuffer);
   FreeMem (HeaderBuffer);

   {$IFDEF DEBUG}
   if Assigned (Flog) then begin
      LogMessage := 'query raw headers done';
      Synchronize (Log);
   end;
   {$ENDIF}

   dwIndex  := 0;
   dwBufLen := SMALLBUFFERSIZE;

   Ok := HttpQueryInfo(hRequest, HTTP_QUERY_CONTENT_TYPE, @SmallBuffer1, dwBufLen, dwIndex);
   SmallBuffer1[dwBufLen] := char(0);
   if (Ok = false) or Terminated then begin
      FDoneOk := False;
      Exit;
   end;

   if pos ('text/html', SmallBuffer1) = 0 then begin
      FDoneOk := false;
      FAborted := true;
      Exit;
   end;

   {$IFDEF DEBUG}
   if Assigned (Flog) then begin
      LogMessage := 'thread: query content done';
      Synchronize (Log);
   end;
   {$ENDIF}

   FType := StrPas(SmallBuffer1);

   dwIndex  := 0;
   dwBufLen := SMALLBUFFERSIZE;

   if HttpQueryInfo(hRequest, HTTP_QUERY_CONTENT_LENGTH, @SmallBuffer1, dwBufLen, dwIndex) then begin
      SmallBuffer1[dwBufLen] := char(0);
      FContentLength := StrToInt(StrPas(SmallBuffer1));
   end
   else begin
      FContentLength := 0;
   end;

   if Terminated then begin
      FDoneOk := False;
      Exit;
   end;

   {$IFDEF DEBUG}
   if Assigned (Flog) then begin
      LogMessage := 'thread: query content length done: ' + inttostr (fcontentlength);
      Synchronize (Log);
   end;
   {$ENDIF}

   if Assigned (FOnHeadComplete) then begin
      FOkToGetData := true;
      Synchronize (HeadComplete);
      if not FOkToGetData then begin
         FDoneOk := False;
         FAborted := true;
         Exit;
      end;
   end;

   BytesRead := MAXDWORD;
   if Assigned (FOnProgress) then Synchronize (Progress);
   BytesRead := 0;

   FDataString := '';
   BytesRead := 0;

   fini := false;
   Ok := true;

   {$IFDEF DEBUG}
   if Assigned (Flog) then begin
      LogMessage := 'thread: starting getting body';
      Synchronize (Log);
   end;
   {$ENDIF}

   while not fini do begin
      if Terminated then begin
         Fini := true;
         Ok := false;
      end
      else begin
       if not InternetQueryDataAvailable (hRequest, BytesAvail, 0, 0) then begin
          Fini := true;
          Ok := false;
       end
       else begin
        if BytesAvail = 0 then begin
           Fini := true;
        end
        else begin
         GetMem (InternetReadBuffer, BytesAvail + 1);
         if not InternetReadFile(hRequest, InternetReadBuffer, BytesAvail, BytesToRead) then begin
            fini := true;
            Ok := false;
         end
         else begin
            InternetReadBuffer[BytesAvail] := char(0);
            if Assigned (FOnProgress) then Synchronize (Progress);
            if BytesToRead > 0 then begin
              inc(BytesRead, BytesToRead);
              if FStoreToDataString then begin
                 FDatastring := FDatastring + string (InternetReadBuffer);
              end;
            end;

            inc (CountRefreshTimeOut);
            if CountRefreshTimeOut = 10 then begin
               synchronize (RefreshTimeOut);
               CountRefreshTimeOut := 0;
            end;

         end;
         FreeMem (InternetReadBuffer);
        end;
       end;
      end;
   end;

   if (Ok = false) or Terminated then begin
      FDoneOk := False;
      Exit;
   end;

   {$IFDEF DEBUG}
   if Assigned (Flog) then begin
      LogMessage := 'thread: body complete';
      Synchronize (Log);
   end;
   {$ENDIF}

   if FStoreToDataString then begin
      Synchronize (DataComplete);
      if BytesRead <> 0 then begin
         Ok := true;
      end
      else begin
         Ok := false;
      end;
   end;
   FDoneOk := Ok;
 finally
   if Terminated then begin
      FAborted := true;
   end;
   CloseHandles;
 end;
end;

end.


