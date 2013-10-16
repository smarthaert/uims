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
( Description: download queue manager                                        )
(                                                                            )
((((((((((((((((((((((((((((((((((((((O))))))))))))))))))))))))))))))))))))))}

unit ThDwnld;

interface

Uses ThCrkUrl, ThUrlQue, ThGetUrl, ThGetThr;

const
    WORKDONEDELAY = 10;
    ID_HTML = 1;
    ID_FILES = 2;


type
    TErrorInfo = (ERROR_TIMEDOUT, ERROR_RETRYCOUNT, ERROR_OTHER);

    TOnDwnldHeadComplete = procedure (Sender: TObject; Tag : integer ; Url : string ; Head : String ; StatusCode : integer ; ContentType : string ; ContentLength : integer ; DepthSearchLevel_ : integer ; var OkToGetData : boolean ; CountArea : integer) of object;
    TOnProgress = procedure (PtGet : TMFHttpGet ; BytesRead : longword) of object;

    TOnUpdatedStats = procedure(Sender: TObject; Tag, InQueue, Downloading, ToAnalyze, Done, Retries, Errors, AlreadyOnDisk : integer) of object;
    TOnDataReceived = procedure(Sender: TObject; PtGet : TMFHttpGet ; AlreadyOnDisk : boolean) of object;
    TOnGetError = procedure (Sender: TObject ; Tag_ : integer ; Url : string ; ErrorCode_ : LongWord ; ErrorMsg_ : string ; ReferringUrl : string) of object;
    TOnGetError2 = procedure(Sender: TObject; PtGet : TMFHttpGet ; ErrorInfo : TErrorInfo) of object;
    TOnWorking = procedure (Sender: TObject ; Working_ : boolean) of object;
    TOnCanReinit = procedure (Sender: TObject ; var OnCanReinit_ : boolean) of object;
    TOnStartingGet = procedure (iTabGet : integer ; ReturnTag : integer);
    TOnDwnldLog = procedure(Sender: TObject; LogMessage : string) of object;
    TOnReinit = procedure of object;

    TMFDwnld = class (TObject)

    private

       FTag: integer;
       INTIMER : boolean;

       FWorkDoneDelay : integer;

       FDownloadPath : string;
       FRetryCount : integer;
       FTimeOut : integer;

       FDepthSearchLevel : integer;
       FConcurrentDownloads : integer;

       UrlsInQueue : TUrlInQueue;

       AtLeastOnePriority : boolean;
       AlternatePriority : boolean;

       FStats : TOnUpdatedStats;

       FGlobalKeyArea : integer ;

       FDataReceived : TOnDataReceived;
       FLog : TOnDwnldLog;
       FError : TOnGetError;
       FError2 : TOnGetError2;
       FOnProgress : TOnProgress;
       FOnStartingGet : TOnStartingGet;

       FReuseExistingFiles : boolean;

       FOnHeadComplete : TOnDwnldHeadComplete;
       FOnReinit : TOnReinit;
       FOnCanReinit : TOnCanReinit;
       FOnWorking : TOnWorking;
       FWorking : boolean;

       FAborting : boolean;
       FAgent: String;
       FReuseCache: Boolean;
       FPort : integer;
       FUserName: String;
       FPassword: String;
       FReferringUrl: String;
       CrackedStartingUrl : TCrackUrl;

       FProxyType : TProxyType;
       FProxyAddress : string;
       FProxyPort : integer;
       FProxyUser : string;
       FProxyPassword : string;

       TabGets : array of TMFHttpGet;
       FLeavesFirst : boolean;

       StatsDone : integer;
       StatsErrors : integer;
       StatsRetries : integer;
       StatsAlreadyOnDisk : integer;

       MemoStatsInQueue : integer;
       MemoStatsToAnalyze : integer;
       MemoStatsDownloading : integer;
       MemoStatsDone : integer;
       MemoStatsErrors : integer;
       MemoStatsRetries : integer;
       MemoStatsAlreadyOnDisk : integer;

       procedure StartGetOnWaitingThreads;
       function StartGetOnWaitingThread (iTabGet : integer) : boolean;
       procedure GetUrlOnHeadComplete (Sender: TObject; Url : string ; Head : String ; StatusCode : integer ; ContentType : string ; ContentLength : integer ; DepthSearchLevel_ : integer ; var OkToGetData : boolean ; CountArea : integer);
       procedure ResizeTabGets;
       procedure Progress (Sender : TObject ; BytesRead : longword);
       function FindPriorityInQueue  : integer;
       procedure SetWorking (Value : boolean);
       procedure SetAborting (Value : boolean);
    protected

    public
       AllowToAddInQueue : boolean;
       constructor Create;
       destructor Destroy; override;
       function RefreshStats : boolean;
       function AddInQueue (Url : string ; ReferringUrl : string ; Level : integer ; CurrentRetryCount : integer ; HrefOrSrc : char ; GetAction : TGetAction ; CountArea : integer ; priority : boolean ; ReturnTag : integer) : boolean;
       function QueueCount : integer;
       //procedure InfoGets (Memo : TMemo);
       procedure OnTimer;
       procedure Reinit;
       property Aborting : boolean read FAborting write SetAborting;
       property OnStartingGet : TOnStartingGet read FOnStartingGet write FOnStartingGet;
       property OnError2 : TOnGetError2 read FError2 write FError2;
       property TimeOut : integer read FTimeOut write FTimeOut;
       property DownloadPath : string read FDownloadPath write FDownloadPath;
       property LeavesFirst : boolean read FLeavesFirst write FLeavesFirst;
       property ReuseCache: Boolean read FReuseCache write FReuseCache;

       property UserName: String read FUserName write FUserName;
       property Password: String read FPassword write FPassword;

       property Agent: String read FAgent write FAgent;
       property ReferringUrl: String read FReferringUrl write FReferringUrl;

       property HttpPort : integer read FPort write FPort;

       property RetryCount : integer read FRetryCount write FRetryCount;

       property DepthSearchLevel : integer read FDepthSearchLevel write FDepthSearchLevel;
       property ConcurrentDownloads : integer read FConcurrentDownloads write FConcurrentDownloads;

       property OnDataReceived : TOnDataReceived read FDataReceived write FDataReceived;
       property OnUpdatedStats : TOnUpdatedStats read FStats write FStats;
       property OnLog : TOnDwnldLog read FLog write FLog;
       property OnError : TOnGetError read FError write FError;
       property OnHeadComplete : TOnDwnldHeadComplete read FOnHeadComplete write FOnHeadComplete;
       property OnProgress : TOnProgress read FOnProgress write FOnProgress;
       property ReuseExistingFiles : boolean read FReuseExistingFiles write FReuseExistingFiles;

       property ProxyType : TProxyType read FProxyType write FProxyType;
       property ProxyAddress : string read FProxyAddress write FProxyAddress;
       property ProxyPort : integer read FProxyPort write FProxyPort;
       property ProxyUser : string read FProxyUser write FProxyUser;
       property ProxyPassword : string read FProxyPassword write FProxyPassword;
       property OnReinit : TOnReinit read FOnReinit write FOnReinit;
       property OnWorking : TOnWorking read FOnWorking write FOnWorking;
       property OnCanReinit : TOnCanReinit read FOnCanReinit write FOnCanReinit;
       property Working : boolean read FWorking write SetWorking;
       property Tag: integer read FTag write FTag;
    end;

implementation

Uses Windows, SysUtils, Forms;

constructor TMFDwnld.Create;
begin
   AllowToAddInQueue := true; // go to false when exiting not to start others downloads

   SetLength (TabGets, 0);

   INTIMER := false;

   UrlsInQueue := TUrlInQueue.Create;

   FTimeOut := 300;

   FWorking := false;

   FLeavesFirst := false;

   FReuseCache := false;

   FGlobalKeyArea := 0;

   FWorkDoneDelay := WORKDONEDELAY;

   FDownloadPath := '';

   FAborting := false;

   AtLeastOnePriority := false;
   AlternatePriority := false;

   FReuseExistingFiles := false;

   FRetryCount := 3;

   CrackedStartingUrl := TCrackUrl.Create;

   FDepthSearchLevel := 2;
   FConcurrentDownloads := 3;
   HttpPort := 80;

   FAgent := 'DelphiCity';
   UserName := '';
   Password := '';

   ProxyType := PROXY_DEFAULT;
   ProxyAddress := '';
   ProxyPort := 80;
   ProxyUser := '';
   ProxyPassword := '';

end;

function TMFDwnld.AddInQueue (Url : string ; ReferringUrl : string ; Level : integer ; CurrentRetryCount : integer ; HrefOrSrc : char ; GetAction : TGetAction ; CountArea : integer ; priority : boolean ; ReturnTag : integer) : boolean;
var
   Ok : boolean;
   CanReinit : boolean;
   OkToAddInQueue : boolean;
   f : file;
   Buf : pointer;
   dwBufLen : DWord;
   PtGetReload : TMFHttpGet;
begin
   Ok := true;
   if AllowToAddInQueue then begin
     if not FAborting then begin
      if not Working then begin
         CanReinit := true;
         if Assigned (FOnCanReinit) then FOnCanReinit (Self, CanReinit);
         if CanReinit then begin
            Reinit;
         end;
         Working := true;
      end;
      if Ok then begin
         if Priority then begin
            AtLeastOnePriority := true;
         end;

         OkToAddInQueue := true;
         if ReuseExistingFiles then begin
            PtGetReload := TMFHttpGet.Create;
            PtGetReload.CrackedUrl.CrackUrl (Url, FDownloadPath);
            if FileExists (PtGetReload.CrackedUrl.UrlFilePath) then begin
                  PtGetReload.ReferringUrl := ReferringUrl;
                  PtGetReload.DepthSearchLevel := Level;
                  PtGetReload.GetAction := GetAction;
                  PtGetReload.RetryCount := CurrentRetryCount;
                  PtGetReload.ReturnTag := ReturnTag;
                  PtGetReload.CountArea := CountArea;
                  PtGetReload.HrefOrSrc := HRefOrSrc;

                  dwBufLen := 0;
                  AssignFile(f, PtGetReload.CrackedUrl.UrlFilePath);
                  FileMode := 0;
                  {$I-}
                  Reset (f, 1);
                  {$I+}
                  if IOResult = 0 then begin
                     dwBufLen := FileSize (f);
                     GetMem(Buf, dwBuflen);
                     BlockRead (f, Buf^, dwBufLen);
                     PtGetReload.Body := PChar (Buf);
                     FreeMem (Buf);
                     CloseFile (f);
                     OkToAddInQueue := false;
                     if not FAborting then begin
                        if Assigned (Flog) then if not FAborting then FLog (Self, '(reloaded from disk) ' + PtGetReload.crackedUrl.Url);
                        if Assigned (FDataReceived) then if not FAborting then FDataReceived (Self, PtGetReload, true);
                     end;
                     inc (StatsAlreadyOnDisk);
                  end;
                  PtGetReload.ContentLength := dwBufLen;
                  Application.ProcessMessages;
            end;
            PtGetReload.Free;
         end;
         if OkToAddInQueue then begin
            UrlsInQueue.Add (Tag, Url, ReferringUrl, Level, CurrentRetryCount, HRefOrSrc, GetAction, CountArea, Priority, ReturnTag);
         end;
      end
      else begin
      end;
     end;
   end
   else begin
      Ok := false;
   end;
   AddInqueue := Ok;
end;

function TMFDwnld.QueueCount : integer;
begin
   QueueCount := UrlsInQueue.Queue.Count;
end;

destructor TMFDwnld.Destroy;
begin
   UrlsInQueue.Free;

   CrackedStartingUrl.Free;

   inherited Destroy;
end;

procedure TMFDwnld.Progress (Sender : TObject ; BytesRead : longword);
begin
   if not FAborting then begin
      if assigned (FOnProgress) then FOnProgress (TMFHttpGet (Sender), BytesRead);
   end;
end;

procedure TMFDwnld.GetUrlOnHeadComplete (Sender: TObject; Url : string ; Head : String ; StatusCode : integer ; ContentType : string ; ContentLength : integer ; DepthSearchLevel_ : integer ; var OkToGetData : boolean ; CountArea : integer);
var
   Keep : boolean;
begin
   Keep := true;
   if not FAborting then begin
      if Tag = ID_HTML then begin
         if pos ('htm', ContentType) = 0 then begin
            Keep := false;
         end;
      end;
      if Keep then begin
         if Assigned (FOnHeadComplete) then FOnHeadComplete (sender, Tag, Url, Head, StatusCode, ContentType, ContentLength, DepthSearchLevel_, OkToGetData, CountArea);
      end
      else begin
         OkToGetData := false;
      end;
   end;
end;

procedure TMFDwnld.SetWorking (Value : boolean);
begin
   FWorking := Value;
   if assigned (FOnWorking) then FOnWorking (Self, Value);
   if not Value then begin
      FAborting := false;
   end;
end;

procedure TMFDwnld.SetAborting (Value : boolean);
var
   i : integer;
begin
   FAborting := Value;
   if FAborting then begin
      for i := 0 to (length (TabGets) - 1) do begin
          TabGets[i].KillGet;
      end;
   end;
end;

procedure TMFDwnld.Reinit;
begin
      StatsDone := 0;
      StatsErrors := 0;
      StatsRetries := 0;
      StatsAlreadyOnDisk := 0;

      AtLeastOnePriority := false;

      MemoStatsInQueue := 99999;
      MemoStatsToAnalyze := 99999;
      MemoStatsDownloading := 99999;
      MemoStatsToAnalyze := 99999;
      MemoStatsDone :=99999;
      MemoStatsErrors :=99999;
      MemoStatsRetries := 99999;
      MemoStatsAlreadyOnDisk := 99999;

      if Assigned (FStats) then FStats (Self, Tag, 0, 0, 0, 0, 0, 0, 0);
      if Assigned (FOnReinit) then FOnReinit;

      UrlsInQueue.Clear;
end;

function TMFDwnld.RefreshStats : boolean;
var
   StatsInQueue : integer;
   StatsDownloading : integer;
   StatsToAnalyze : integer;
   Continue : boolean;
   i : integer;
   SomethingRunning, SomethingChanged : boolean;
begin
   Continue := true;
   SomethingRunning := false;

   StatsDownloading := 0;
   StatsToAnalyze := 0;
   for i := 0 to (length (TabGets) - 1) do begin
      if TMFHttpGet(TabGets[i]).State > GETHTTP_WAITING then begin
         SomethingRunning := true;
      end;
      case TabGets[i].State of
            GETHTTP_GETTING : inc (StatsDownloading);
            GETHTTP_OK : inc (StatsToAnalyze);
      end;
   end;

   StatsInQueue := UrlsInQueue.Queue.Count;

   if (StatsInQueue <> MemoStatsInqueue) or
          (StatsToAnalyze <> MemoStatsToAnalyze) or
          (StatsDownloading <> MemoStatsDownloading) or
          (StatsDone <> MemoStatsDone) or
          (StatsErrors <> MemoStatsErrors) or
          (StatsRetries <> MemoStatsRetries) or
          (StatsAlreadyOnDisk <> MemoStatsAlreadyOnDisk) then begin
      SomethingChanged := true;
   end
   else begin
      SomethingChanged := false;
   end;

    if Assigned (FStats) then begin
       if SomethingChanged then begin
             FStats (Self, Tag,
                           StatsInQueue,
                           StatsDownloading,
                           StatsToAnalyze,
                           StatsDone,
                           StatsRetries,
                           StatsErrors,
                           StatsAlreadyOnDisk);

          MemoStatsInQueue := StatsInQueue;
          MemoStatsToAnalyze := StatsToAnalyze;
          MemoStatsDownloading := StatsDownloading;
          MemoStatsDone := StatsDone;
          MemoStatsRetries := StatsRetries;
          MemoStatsErrors := StatsErrors;
          MemoStatsAlreadyOnDisk := StatsAlreadyOnDisk;

      end;
   end;

   if (StatsInQueue = 0)
    and (StatsDownloading = 0)
    and (not SomethingChanged)
    and (not SomethingRunning) then begin
       if FWorkDoneDelay = 0 then begin
          Continue := false;
       end
       else begin
            dec (FWorkDoneDelay);
       end;
   end
   else begin
      FWorkDoneDelay := WORKDONEDELAY;
   end;
   RefreshStats := Continue;
end;

procedure TMFDwnld.StartGetOnWaitingThreads;
var
   i : integer;
   OneStarted : boolean;
   imax : integer;
begin
   imax := length (TabGets);
   if imax > FConcurrentDownloads then begin
      imax := FConcurrentDownloads;  // not to start gets on top array when downsizing it
   end;
   OneStarted := false;
   for i := 0 to imax - 1 do begin
    if not FAborting then begin
       if StartGetOnWaitingThread (i) then begin
          OneStarted := true;
      end;
    end;
   end;
   if OneStarted then begin
      //RefreshStats;
   end;
end;

function TMFDwnld.FindPriorityInQueue  : integer;
var
   Done : boolean;
   i, Ct : integer;
begin
   Done := false;
   i := 0;
   Ct := UrlsInQueue.Queue.Count;
   while not Done do begin
      if i = Ct then begin
         Done := true;
         AtLeastOnePriority := false;
         i := 0;
      end
      else begin
         if TUrlObject(UrlsInQueue.Queue.Objects[i]).Priority then begin
            Done := true;
         end
         else begin
            inc (i);
         end;
      end;
   end;
   FindPriorityInQueue := i;
end;

function TMFDwnld.StartGetOnWaitingThread (iTabGet : integer) : boolean;
var
   i : integer;
   iLower : integer;
   Obj : TUrlObject;
   Started : boolean;
   PtGet : TMFHttpGet;
begin
   PtGet := TabGets[iTabGet];
   Started := false;
   if PtGet.State = GETHTTP_WAITING then begin
      PtGet.State := GETHTTP_PREPARING;
      if UrlsInQueue.Queue.Count > 0 then begin
         iLower := 0;
         if AtLeastOnePriority then begin
            if not AlternatePriority then begin
               iLower := FindPriorityInQueue;
               AlternatePriority := true;
            end
            else begin
               iLower := FindPriorityInQueue;
               AlternatePriority := false;
            end;
         end
         else begin
            if FLeavesFirst then begin // search for URLs with the lowest level
               for i := 0 to (UrlsInQueue.Queue.Count - 1) do begin
                   if TUrlObject (UrlsInQueue.Queue.Objects[0]).DeepLevel < iLower then begin
                      iLower := i;
                   end;
               end;
            end;
         end;
         PtGet.OnLog := OnLog;
         PtGet.OnProgress := Progress;
         PtGet.CrackedUrl.CrackUrl (UrlsInQueue.Queue[iLower], FDownloadPath);
         Obj := TUrlObject(UrlsInQueue.Queue.Objects[iLower]);
         PtGet.TimeOut := FTimeOut;


         PtGet.RetryCount := Obj.CurrentRetryCount;
         PtGet.DepthSearchLevel := Obj.DeepLevel;
         PtGet.CountArea := Obj.CountArea;
         PtGet.HrefOrSrc := Obj.HrefOrSrc;
         PtGet.ReturnTag := Obj.ReturnTag;
         PtGet.GetAction := Obj.GetAction;
         PtGet.OnHeadComplete := GetUrlOnHeadComplete;
         PtGet.Agent := FAgent;
         PtGet.ReferringUrl := Obj.ReferringUrl;
         PtGet.UserName := UserName;
         PtGet.Password := Password;
         PtGet.ProxyType := ProxyType;
         PtGet.proxyAddress := ProxyAddress;
         PtGet.ProxyPort := ProxyPort;
         PtGet.ProxyUser := ProxyUser;
         PtGet.ProxyPassword := ProxyPassword;

         if FDownloadPath = '' then begin
            PtGet.GetAction := STORE_TO_DATASTRING; // path incorrect
         end;

         UrlsInQueue.Delete (iLower);

         if not FAborting then begin
            if Assigned (Flog) then if not FAborting then FLog (Self, 'starting download for ' + PtGet.crackedUrl.Url);
            if Assigned (FOnStartingGet) then FOnStartingGet (iTabGet, Obj.ReturnTag);
            PtGet.Get (GETHTTP_BODY);
            Started := true;
         end;
      end;
      if not Started then begin
         PtGet.State := GETHTTP_WAITING;
      end;
   end;
   StartGetOnWaitingThread := Started;
end;

procedure TMFDwnld.ResizeTabGets;
var
   PreviousLength : integer;
   i : integer;
   OkToResize : boolean;
begin
   PreviousLength := length (TabGets);
   if FConcurrentDownloads > PreviousLength then begin
      SetLength (TabGets, FConcurrentDownloads);
      for i := PreviousLength to (length (TabGets) - 1) do begin
         TabGets[i] := TMFHttpGet.Create;
         TabGets[i].State := GETHTTP_WAITING;
      end;
   end
   else if FConcurrentDownloads < PreviousLength then begin
      OkToResize := true;
      for i := FConcurrentDownloads to (PreviousLength - 1) do begin
          if TabGets[i].State = GETHTTP_WAITING then begin
             TabGets[i].State := GETHTTP_NOTUSED;
          end
          else if TabGets[i].State = GETHTTP_NOTUSED then begin
          end
          else begin
             OkToResize := false;
          end;
      end;
      if OkToResize then begin
         for i := FConcurrentDownloads to (PreviousLength - 1) do begin
            TabGets[i].Free;
         end;
         SetLength (TabGets, FConcurrentDownloads);
      end;
   end;
end;

procedure TMFDwnld.OnTimer;
var
   i : integer;
   PtGet : TMFHttpGet;
   Fini : boolean;
begin
   // INTIMER locking is in MFHtScan
   if FConcurrentDownloads <> length (TabGets) then begin
      ResizeTabGets;
   end;

   if not FAborting then begin
      StartGetOnWaitingThreads;
   end
   else begin
      UrlsInQueue.Clear;
   end;

   fini := false;
   i := 0;
   while not fini do begin
      if i = length (TabGets) then begin
         fini := true;
      end;
      if not fini then begin
         PtGet := TabGets[i];
         case PtGet.State of
            GETHTTP_WAITING : begin
               StartGetOnWaitingThread (i);
            end;
            GETHTTP_GETTING : begin
               if PtGet.ConnectTimeOut < GetTickCount then begin
                  if not PtGet.Killed then begin
                     if assigned (FError) then if not FAborting then FError (Self, Tag, 'timeout : ' + PtGet.CrackedUrl.Url, 0, 'TimeOut', PtGet.ReferringUrl);
                     if assigned (FError2) then if not FAborting then FError2 (Self, PtGet, ERROR_TIMEDOUT);
                     inc (StatsErrors);
                     PtGet.KillGet;
                  end;
               end
               else if FAborting then begin
                  PtGet.KillGet;
               end;
            end;
            GETHTTP_THREAD_DONE : begin
               PtGet.FinalizeGet;
               if PtGet.ThreadDoneOk then begin
                  PtGet.State := GETHTTP_OK;
               end
               else begin
                  if assigned (FOnProgress) then FOnProgress (PtGet, 0);
                  if PtGet.ThreadAborted then begin
                     PtGet.State := GETHTTP_WAITING;
                  end
                  else begin
                     PtGet.State := GETHTTP_ERROR;
                  end;
               end;
            end;
            GETHTTP_OK : begin
                PtGet.State := GETHTTP_WAITING;
                case PtGet.Request of
                   GETHTTP_BODY : begin
                      if PtGet.StatusCode = 200 then begin
                         inc (StatsDone);
                         if Assigned (FDataReceived) then if not FAborting then FDataReceived (Self, PtGet, false);
                      end
                      else if ((PtGet.StatusCode > 200) and (PtGet.StatusCode < 300))
                       or ((PtGet.StatusCode >=500) and (PtGet.StatusCode < 600)) then begin
                          PtGet.State := GETHTTP_ERROR;
                      end
                      else begin
                         if not FAborting then begin
                            if Assigned (FError) then if not FAborting then FError (Self, Tag, PtGet.CrackedUrl.Url, PtGet.StatusCode, 'ERROR', PtGet.ReferringUrl);
                            if assigned (FError2) then if not FAborting then FError2 (Self, PtGet, ERROR_RETRYCOUNT);
                         end;
                      end;
                   end;
                end;
            end;
             GETHTTP_ERROR : begin
                if PtGet.RetryCount < FRetryCount then begin
                   if not FAborting then begin
                      UrlsInQueue.Add (Tag, PtGet.CrackedUrl.Url, PtGet.ReferringUrl, PtGet.DepthSearchLevel, PtGet.RetryCount + 1, PtGet.HrefOrSrc, PtGet.GetAction, PtGet.CountArea, false, -1);
                      inc (StatsRetries);
                   end;
                end
                else begin
                   if not FAborting then begin
                      if Assigned (FError) then if not FAborting then FError (Self, Tag, PtGet.CrackedUrl.Url, PtGet.StatusCode, PtGet.ErrorMsg, PtGet.ReferringUrl);
                      if assigned (FError2) then if not FAborting then FError2 (Self, PtGet, ERROR_OTHER);
                      if Assigned (Flog) then if not FAborting then FLog (Self, 'GetHttp_Error ' + PtGet.crackedUrl.Url);
                      inc (StatsErrors);
                   end;
                end;
              PtGet.State := GETHTTP_WAITING;
            end;
       end;
       inc (i);
      end;
   end;
end;

{procedure TMFDwnld.InfoGets (Memo : TMemo);
var
   i : integer;
   PtGet : TMFHttpGet;
   Line : string;
begin
   Memo.Text := '';
   for i := 0 to Length (TabGets) -1 do begin
      PtGet := TabGets[i];
      Line := inttostr (i) + ' : ';
      case PtGet.State of
         GETHTTP_NOTUSED : begin
            Line := Line + 'not used';
         end;
         GETHTTP_WAITING : begin
            Line := Line + 'waiting';
         end;
         GETHTTP_GETTING : begin
            Line := Line + 'getting ' + PtGet.CrackedUrl.Url;
         end;
         GETHTTP_OK : begin
            Line := Line + 'done ' + PtGet.CrackedUrl.Url;
         end;
         GETHTTP_ERROR : begin
            Line := Line + 'error ' + PtGet.CrackedUrl.Url;
         end;
      end;
      Memo.Lines.Add (Line);
   end;
end;}

end.
