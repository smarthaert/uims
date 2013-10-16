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
( Description: main ThttpScan unit                                           )
(                                                                            )
((((((((((((((((((((((((((((((((((((((O))))))))))))))))))))))))))))))))))))))}

unit THtScan;

interface

Uses Windows, Classes, ExtCtrls, StdCtrls,
     ThConst, ThGetThr, ThDwnld, ThSlist, ThCrkUrl, ThGetUrl, ThUrlQue;

const

    QUIT_DELAY_COUNT = 10;

    TYPELINK_UNKNOWN = 'unknown';
type
    TResultFile = (RESULTS_NOTHING, RESULTS_FILEOFRESULTS, RESULTS_CREATE_DATETIME);

    TProxyType = (PROXY_DIRECT, PROXY_USEPROXY, PROXY_DEFAULT);

    TLinkScan = (scanAllLinks, scanInitialSite, scanInitialPath);
    TLinkReport = (reportAllLinks, reportCurrentSiteLinks, reportCurrentPathLinks);

    TOnLinkFound = procedure (Sender: TObject; UrlFound, TypeLink,
                              FromUrl, HostName, UrlPath, UrlPathWithFile, ExtraInfos: String;
                              var WriteToFile: String; HrefOrSrc: Char; CountArea: Integer;
                              var FollowIfHtmlLink: Boolean) of object;

    TOnPageReceived = procedure(Sender: TObject; HostName, Url, Head, Body : string) of object;

    TOnEndUserPageReceived = procedure (Sender: TObject; HostName, Url, Head, Body: String ; AlreadyOnDisk : boolean) of object;
    TOnHttpScanUpdatedStats = procedure (Sender: TObject; InQueue, Downloading, ToAnalyze, Done, Retries, Errors: Integer) of object;
    TOnMetaTag = procedure (Sender : TObject ; Url : string; ReferringUrl : string ; TagType : string ; Tag1stAttrib, Tag1stValue, Tag2ndAttrib, Tag2ndValue, Tag3rdAttrib, Tag3rdValue : string) of object;

    TScanOnError = procedure(Sender: TObject ; Url : string ; ErrorCode : DWord ; ErrorMsg : string) of object;

    TOnHeritedTimer = procedure (Sender : TObject ; Aborting : boolean) of object;

    TOnProcessNotHtmlLink = procedure (TypeLink, NewUrl, HostName, ReferringUrl : string ; HRefOrSrc : char ; CountArea : integer ; UrlFilePath : string ; HttpLink : boolean) of object;
    TOnPostLocalizeHrefSrc = procedure (var Body_ : string) of object;
    TOnPostHtmlPageReceived = procedure (Sender: TObject ; PtGet : TMFHttpGet) of object;
    TOnLog = procedure(Sender: TObject; LogMessage : string) of object;

    THttpScan = class (TComponent)
    private
       Timer : TTimer;
       INTIMER: Boolean;

       FQuitDelayCount : integer;

       FExiting : boolean;

       FStartLocked : boolean;

       HResultFile : Text;
       ResultFilesOpened : boolean;


       FGlobalKeyArea : integer ;

       FOnLinkFound : TOnLinkFound;
       FOnPageReceived : TOnPageReceived;
       FOnError : TScanOnError;

       FOnLog : TOnLog;

       FOnPostLocalizeHrefSrc : TOnPostLocalizeHrefSrc;

       FOnProcessNotHtmlLink : TOnProcessNotHtmlLink;
       FOnPostHtmlPageReceived : TOnPostHtmlPageReceived;

       FOnHeritedTimer : TOnHeritedTimer;

       UrlsDone : TMFStringList;
       HostsDone : TMFStringList;

       FCrackedStartingUrl : TCrackUrl; // used in the .start and .reinit

       FAgent: String;
       FPort : integer;
       FReferer: String;
       FStartingUrl : string;

       FHttpScanStats : TOnHttpScanUpdatedStats;
       FDwnldStats : TOnUpdatedStats;

       FMaxHtmlQueueSize : integer;

       FUserName: String;
       FPassword: String;

       FProxyType : TProxyType;
       FProxyAddress : string;
       FProxyPort : integer;
       FProxyUser : string;
       FProxyPassword : string;

       FInitialReferringUrl : string;

       FOnLogsEnabled : boolean;
       FTimeOut : integer;
       FSeekRobotsTxt : boolean;
       FResultFile : TResultFile;
       FTypeFilter: TMFStringList;
       FTypeFilterEnabled: boolean;
       FKeywordsFilter : TMFStringList;
       FKeywordsLimiter : TMFStringList;
       FKeywordsFilterEnabled : boolean;
       FKeywordsLimiterEnabled : boolean;
       FFileOfResults : string;
       FRetryCount : integer;
       FLinkScan: TLinkScan;
       FLinkReport: TLinkReport;

       FOnHtmlDwnldWorking : TOnWorking;
       FOnMetaTag : TOnMetaTag;

       HtmlDwnld : TMFDwnld;

       function RebuildNewUrl (RetourGet : TMFHttpGet ; LinkExtracted : string ; var TypeLink : string) : string;
       function ExtractionType (NewUrl : string ; var iLastSlash : integer ; var HttpFileName : string ; var Protocol : string) : string;
       procedure ParseHtml (RetourGet : TMFHttpGet ; Body : string ; NewUrlCracked : TCrackUrl);
       function ProcessLinkFound (RetourGet : TMFHttpGet ; LinkExtracted : string ; HrefOrSrc_ : char ; NewUrlCracked : TCrackUrl ; CountArea : integer) : string;

       function LocalizeHrefSrc (var Body : string) : boolean;

       procedure OnDwnldHtmlHeadComplete (Sender: TObject; Tag : integer ; Url : string ; Head : String ; StatusCode : integer ; ContentType : string ; ContentLength : integer ; DepthSearchLevel : integer ; var OkToGetData : boolean ; CountArea : integer);
       procedure OnGetError (Sender: TObject ; Tag_ : integer ; Url : string ; ErrorCode_ : LongWord ; ErrorMsg_ : string ; ReferringUrl : string);
       procedure PageHead (PtGet : TMFHttpGet);
       procedure ProcessMeta (PtGet : TMFHttpGet ; iStartAttrib : integer ; Meta : string ; UpMeta : string);


       procedure HtmlDwnldWorking (Sender: TObject ; Working_ : boolean);

       function GetWorking : boolean; // v2 compatibility
       function GetStopping : boolean;// v2 compatibility
       function GetLeavesFirst : boolean;
       function GetDepthSearchLevel : integer;
       function GetHtmlConcurrentDownloads : integer;
       function GetActionForHtmlPages : TGetAction;
       function GetStartingUrl: String;
       function GetTypeFilter: string;
       function GetExiting: Boolean;
       function GetKeywordsFilter : string;
       function GetKeywordsLimiter : string;
       function GetInitialReferringUrl: string;
       function GetLogsEnabled: boolean;
       function GetResultFile: TResultFile;
       function GetTimeOut: integer;
       function GetFileOfResults: string;
       function GetUserName: string;
       function GetPassword: string;
       function GetAgent: string;
       function GetReferer: string;
       function GetPort: integer;
       function GetRetryCount: integer;
       function GetTypeFilterEnabled: boolean;
       function GetKeywordsFilterEnabled: boolean;
       function GetKeywordsLimiterEnabled: boolean;
       function GetProxyType: TProxyType;
       function GetProxyAddress: string;
       function GetProxyPort: integer;
       function GetProxyUser: string;
       function GetProxyPassword: string;
       function GetMaxHtmlQueueSize: integer;
       function GetSeekRobotsTxt: boolean;
       function GetLinkScan: TLinkScan;
       function GetLinkReport: TLinkReport;

       procedure SetLinkReport (Value: TLinkReport);
       procedure SetLinkScan (Value: TLinkScan);
       procedure SetPort (Value: integer);
       procedure SetReferer (Value: string);
       procedure SetFileOfResults (Value : string);
       procedure SetLeavesFirst (Value : boolean);
       procedure SetSeekRobotsTxt (Value : boolean);
       procedure SetDepthSearchLevel (Value : integer);
       procedure SetStartingUrl (Value: String);
       procedure SetHtmlConcurrentDownloads (Value : integer);
       procedure SetRetryCount (Value : integer);
       procedure SetTimeOut (Value : integer);
       procedure SetLogsEnabled (Value : boolean);
       procedure SetProxyType (Value : TProxyType);
       procedure SetProxyAddress (Value : string);
       procedure SetProxyPort (Value : integer);
       procedure SetProxyUser (Value : string);
       procedure SetProxyPassword (Value : string);
       procedure SetUsername (Value : string);
       procedure SetPassword (Value : string);
       procedure SetAgent (Value : string);
       procedure SetMaxHtmlQueueSize (Value : integer);
       procedure SetTypeFilterEnabled (Value: boolean);
       procedure SetKeywordsFilterEnabled (Value : boolean);
       procedure SetKeywordsLimiterEnabled (Value : boolean);
       procedure SetResultFile (Value : TResultFile);
       procedure SetInitialReferringUrl (Value : string);
       procedure SetTypeFilter (Value: string);
       procedure SetKeywordsFilter (Value : string);
       procedure SetKeywordsLimiter (Value : string);

       function SearchKeywords (KeywordsLowerList : TMFStringList ; S : string) : boolean;
       procedure OnTimer (Sender: TObject);
       procedure HtmlPageReceived (Sender: TObject; PtGet : TMFHttpGet ; AlreadyOnDisk : boolean);
       procedure DwnldStats (Sender: TObject; Tag : integer ;  InQueue, Loging, ToAnalyze, Done, Retries, Errors, AlreadyOnDisk : integer);
       procedure OnLogDwnld (Sender: TObject; LogMessage : string);
       procedure CloseFileOfResults;
       procedure MFHtScanPostLocalizeHrefSrc (var Body_ : string);
       //property QuitDelayCount : integer read FQuitDelayCount write FQuitDelayCount;

   protected
       procedure ClearUrlsDoneIfNotHtml;

       property OnHeritedTimer : TOnHeritedTimer read FOnHeritedTimer write FOnHeritedTimer;
       property OnPostLocalizeHrefSrc : TOnPostLocalizeHrefSrc read FOnPostLocalizeHrefSrc write FOnPostLocalizeHrefSrc;
       property OnProcessNotHtmlLink : TOnProcessNotHtmlLink read FOnProcessNotHtmlLink write FOnProcessNotHtmlLink;
       property OnPostHtmlPageReceived : TOnPostHtmlPageReceived read FOnPostHtmlPageReceived write FOnPostHtmlPageReceived;
    public
       constructor Create (AOwner : TComponent); override;
       destructor Destroy; override;

       procedure HttpScanLoadParams;
       function Start: boolean; overload;
       function Start (Value : string) : boolean; overload;
       function Stop : boolean;
       procedure Exit;
       procedure StopHtml;

       property Working : boolean read GetWorking; // v2 compatibility
       property Stopping : boolean read GetStopping; // v2 compatibility
       property Exiting : boolean read GetExiting;
       property InitialReferringUrl : string read GetInitialReferringUrl write SetInitialReferringUrl;
       property KeywordsFilter : string read GetKeywordsFilter write SetKeywordsFilter; // new in v3.10
       property TypeFilter: string read GetTypeFilter write SetTypeFilter;              // new in v3.10
       property KeywordsLimiter : string read GetKeywordsLimiter write SetKeywordsLimiter;
       property LogsEnabled : boolean read GetLogsEnabled write SetLogsEnabled;
       property ResultFile : TResultFile read GetResultFile write SetResultFile;

       property OnHtmlDwnldWorking : TOnWorking read FOnHtmlDwnldWorking write FOnHtmlDwnldWorking;
       property OnUpdatedStats2 : TOnUpdatedStats read FDwnldStats write FDwnldStats;

    published
       property TimeOut : integer read GetTimeOut write SetTimeOut;
       property FileOfResults : string read GetFileOfResults write SetFileOfResults;
       property LeavesFirst : boolean read GetLeavesFirst write SetLeavesFirst;

       property UserName: String read GetUserName write SetUsername;
       property Password: String read GetPassword write SetPassword;

       property Agent: String read GetAgent write SetAgent;
       property Referer: String read GetReferer write SetReferer;

       property StartingUrl : String read GetStartingUrl write SetStartingUrl;

       property HttpPort : integer read GetPort write SetPort;

       property Retries : integer read GetRetryCount write SetRetryCount;

       property LinkScan: TLinkScan read GetLinkScan write SetLinkScan;
       property LinkReport: TLinkReport read GetLinkReport write SetLinkReport;
       property DepthSearchLevel : integer read GetDepthSearchLevel write SetDepthSearchLevel;

       property TypeFilterEnabled: boolean read GetTypeFilterEnabled write SetTypeFilterEnabled;
       property KeywordsFilterEnabled : boolean read GetKeywordsFilterEnabled write SetKeywordsFilterEnabled stored true default false;
       property KeywordsLimiterEnabled : boolean read GetKeywordsLimiterEnabled write SetKeywordsLimiterEnabled stored true default false;
       property ProxyType : TProxyType read GetProxyType write SetProxyType;
       property ProxyAddress : string read GetProxyAddress write SetProxyAddress;
       property ProxyPort : integer read GetProxyPort write SetProxyPort;
       property ProxyUser : string read GetProxyUser write SetProxyUser;
       property ProxyPassword : string read GetProxyPassword write SetProxyPassword;
       property MaxQueueSize : integer read GetMaxHtmlQueueSize write SetMaxHtmlQueueSize;
       property SeekRobotsTxt : boolean read GetSeekRobotsTxt write SetSeekRobotsTxt;
       property ConcurrentDownloads : integer read GetHtmlConcurrentDownloads write SetHtmlConcurrentDownloads;

       property OnMetaTag :TOnMetaTag read FOnMetaTag write FOnMetaTag;
       property OnLinkFound : TOnLinkFound read FOnLinkFound write FOnLinkFound;
       property OnPageReceived : TOnPageReceived read FOnPageReceived write FOnPageReceived;
       property OnUpdatedStats : TOnHttpScanUpdatedStats read FHttpScanStats write FHttpScanStats;
       property OnLog : TOnLog read FOnLog write FOnLog;
       property OnError : TScanOnError read FOnError write FOnError;
       property OnWorking : TOnWorking read FOnHtmlDwnldWorking write FOnHtmlDwnldWorking;

    end;

procedure Register;

implementation

Uses SysUtils, Dialogs, WinInet, Forms,
     ThTools, ThTypes;

procedure Register;
begin
  RegisterComponents('HttpScan', [THttpScan]);
end;

constructor THttpScan.Create (AOwner : TComponent);
begin
   inherited Create (AOwner);

   FStartLocked := false;

   FOnPostLocalizeHrefSrc := MFHtScanPostLocalizeHrefSrc; // default

   FExiting := false;
   FCrackedStartingUrl := TCrackUrl.Create;

   INTIMER := false;

   HtmlDwnld := TMFDwnld.Create;
   FTypeFilter := TMFStringList.Create;
   FKeywordsFilter := TMFStringList.Create;
   FKeywordsLimiter := TMFStringList.Create;

   HtmlDwnld.DepthSearchLevel := 3;
   HtmlDwnld.ConcurrentDownloads := 6;
   HtmlDwnld.LeavesFirst := false;

   FLinkScan := ScanAllLinks;
   FLinkReport := ReportAllLinks;

   FRetryCount := 3;
   FTimeOut := 300;
   FSeekRobotsTxt := false;
   FInitialReferringUrl := '';
   FFileOfResults := 'c:\results.txt';
   ResultFile := RESULTS_FILEOFRESULTS;
   FOnLogsEnabled := false;
   FProxyType := PROXY_DEFAULT;
   FProxyAddress := '';
   FProxyPort := 80;
   FProxyUser := '';
   FProxyPassword := '';
   FUsername := '';
   FPassword := '';
   FMaxHtmlQueueSize := 5000;

   FTypeFilterEnabled := false;
   FTypeFilter.Text := DEFAULTTYPEFILTER;

   FKeywordsFilterEnabled := false;
   FKeywordsFilter.Text := DEFAULTKEYWORDSFILTER;
   FKeywordsFilter.Sort;

   FKeywordsLimiterEnabled := false;
   FKeywordsLimiter.Text := DEFAULTKEYWORDSLIMITER;
   FKeywordsLimiter.Sort;

   HttpScanLoadParams;

   FQuitDelayCount := 0;

   HtmlDwnld.Tag := ID_HTML;

   HtmlDwnld.OnDataReceived := HtmlPageReceived;
   HtmlDwnld.OnUpdatedStats := DwnldStats;
   HtmlDwnld.OnHeadComplete := OnDwnldHtmlHeadComplete;
   HtmlDwnld.OnError  := OnGetError;
   HtmlDwnld.OnWorking := HtmlDwnldWorking;
   HtmlDwnld.Agent := Agent;

   ResultFilesOpened := false;

   FGlobalKeyArea := 0;

   HttpPort := 80;

   FAgent := DEFAULT_AGENT;

   HostsDone := TMFStringList.Create;
   HostsDone.Capacity := 10000;
   HostsDone.Text := '';

   UrlsDone := TMFStringList.Create;
   UrlsDone.Capacity := 32000;
   UrlsDone.Text := '';

   INTIMER := false;

   Timer := TTimer.Create (Self);
   Timer.enabled := false;

   Timer.OnTimer := OnTimer;
   Timer.Interval := TIMERINTERVAL;
   Timer.enabled := true;
end;

destructor THttpScan.Destroy;
begin
   Timer.enabled := false;

   UrlsDone.Free;
   HostsDone.Free;
   FTypeFilter.Free;
   FKeywordsFilter.Free;
   FKeywordsLimiter.Free;
   HtmlDwnld.Free;
   Timer.Free;
   FCrackedStartingUrl.Free;

   inherited Destroy;
end;

procedure THttpScan.OnGetError (Sender: TObject ; Tag_ : integer ; Url : string ; ErrorCode_ : LongWord ; ErrorMsg_ : string ; ReferringUrl : string);
begin
   if Assigned (FOnError) then FOnError (Sender, Url, ErrorCode_, ErrorMsg_);
end;

function THttpScan.GetTypeFilterEnabled: boolean;
begin
   Result := FTypeFilterEnabled;
end;

function THttpScan.GetKeywordsFilterEnabled: boolean;
begin
   Result := FKeywordsFilterEnabled;
end;

function THttpScan.GetKeywordsLimiterEnabled: boolean;
begin
   Result := FKeywordsLimiterEnabled;
end;

function THttpScan.GetProxyType: TProxyType;
begin
   Result := FProxyType;
end;

function THttpScan.GetProxyAddress: string;
begin
   Result := FProxyAddress;
end;

function THttpScan.GetProxyPort: integer;
begin
   Result := FProxyPort;
end;

function THttpScan.GetProxyUser: string;
begin
   Result := FProxyUser;
end;

function THttpScan.GetProxyPassword: string;
begin
   Result := FProxyPassword;
end;

function THttpScan.GetMaxHtmlQueueSize: integer;
begin
   Result := FMaxHtmlQueueSize;
end;

function THttpScan.GetSeekRobotsTxt: boolean;
begin
   Result := FSeekRobotsTxt;
end;

function THttpScan.GetPort: integer;
begin
   Result := FPort;
end;

function THttpScan.GetRetryCount: integer;
begin
   Result := FRetryCount;
end;

function THttpScan.GetAgent: string;
begin
   Result := FAgent;
end;

function THttpScan.GetReferer: string;
begin
   Result := FReferer;
end;

function THttpScan.GetUserName: string;
begin
   Result := FUserName;
end;

function THttpScan.GetPassword: string;
begin
   Result := FPassword;
end;

function THttpScan.GetTimeOut: integer;
begin
   Result := FTimeOut;
end;

function THttpScan.GetFileOfResults: string;
begin
   Result := FFileOfResults;
end;

function THttpScan.GetLogsEnabled: boolean;
begin
   Result := FOnLogsEnabled;
end;

function THttpScan.GetResultFile: TResultFile;
begin
   Result := FResultFile;
end;

function THttpScan.GetInitialReferringUrl: string;
begin
   Result := FInitialReferringUrl;
end;

function THttpScan.GetExiting: Boolean;
begin
   Result := FExiting;
end;

function THttpScan.GetWorking : boolean;
begin
   Result := HtmlDwnld.Working;
end;

function THttpScan.GetStopping : boolean;
begin
   Result := HtmlDwnld.Aborting;
end;

procedure THttpScan.HtmlDwnldWorking (Sender: TObject ; Working_ : boolean);
begin
   if assigned (FOnHtmlDwnldWorking)then FOnHtmlDwnldWorking (Sender, Working_);
   if not Working_ then begin
      UrlsDone.Text := '';
      HostsDone.Text := '';
   end;
end;

procedure THttpScan.HttpScanLoadParams;
begin
   inherited;
end;

function THttpScan.SearchKeywords (KeywordsLowerList : TMFStringList ; S : string) : boolean;
var
   i : integer;
   Done : boolean;
   Found : boolean;
   lowerS : string;
begin
   lowerS := lowercase (S);
   Found := false;
   i := 0;
   Done := false;
   while not Done do begin
      if i = KeywordsLowerList.Count then begin
         Done := true;
      end
      else begin
         if pos (KeywordsLowerList[i], lowerS) > 0 then begin
            Found := true;
            Done := true;
         end
         else begin
            inc (i);
         end;
      end;
   end;
   SearchKeywords := Found;
end;

procedure THttpScan.OnDwnldHtmlHeadComplete (Sender: TObject; Tag : integer ; Url : string ; Head : String ; StatusCode : integer ; ContentType : string ; ContentLength : integer ; DepthSearchLevel : integer ; var OkToGetData : boolean ; CountArea : integer);
begin
   if LogsEnabled then if Assigned (FOnLog) then FOnLog (Self, 'html head complete (' + inttostr (StatusCode) + '):' + Url);
end;

function RemoveUnwantedCharacters (Chaine : string ; DropQuotes, ReplaceReturnByBlank : boolean) : string;
var
   Retour : string;
   lg : integer;
   car : char;
   MemoCar : char;
   i : integer;
   Skip : boolean;
   NextCar : char;
begin
   lg := length (chaine);
   MemoCar := 'X';
   Retour := '';

   for i := 1 to lg do begin
      Skip := false;
      Car := chaine[i];
      if Car < ' ' then begin
         if Car = chr(10) then begin
            if ReplaceReturnByBlank then begin
               Car := ' ';
            end
            else begin
               Skip := true;
            end;
         end
         else begin
              Skip := true;
         end;
      end
      else if DropQuotes then begin
         if Car in ['"', '''', ','] then begin
            Car := ' ';
         end;
      end;
      if Car = ' ' then begin
         if MemoCar = '=' then begin
            Skip := true;
         end
         else if i < lg then begin
            NextCar := chaine[i + 1];
            if (NextCar = ' ') or (NextCar = '=') then begin
               Skip := true;
            end;
         end;
      end;
      if not Skip then begin
         Retour := Retour + Car;
         MemoCar := Car;
      end;
   end;
   RemoveUnwantedCharacters := Retour;
end;

function THttpScan.GetTypeFilter: string;
begin
   Result := FTypeFilter.Text;
end;

function THttpScan.GetKeywordsFilter : string;
begin
   Result := FKeywordsFilter.Text;
end;

function THttpScan.GetKeywordsLimiter : string;
begin
   Result := FKeywordsLimiter.Text;
end;

function THttpScan.GetStartingUrl: String;
begin
   Result := FStartingUrl;
end;

function THttpScan.GetLinkScan: TLinkScan;
begin
   Result := FLinkScan;
end;

function THttpScan.GetLinkReport: TLinkReport;
begin
   Result := FLinkReport;
end;

procedure THttpScan.SetLinkScan (Value: TLinkScan);
begin
   FLinkScan := Value;
end;

procedure THttpScan.SetLinkReport (Value: TLinkReport);
begin
   FLinkReport := Value;
end;

procedure THttpScan.SetPort (Value: integer);
begin
   FPort := Value;
end;

procedure THttpScan.SetReferer (Value: string);
begin
   FReferer := Value;
end;

procedure THttpScan.SetStartingUrl (Value: String);
begin
   FStartingUrl := Value;
end;

procedure THttpScan.SetTypeFilter (Value: string);
begin
   FTypeFilter.Text := lowercase (Value);
   FTypeFilter.Sort;
end;

procedure THttpScan.SetKeywordsFilter (Value : string);
begin
   FKeywordsFilter.Text := lowercase (Value);
   FKeywordsFilter.Sort;
end;

procedure THttpScan.SetKeywordsLimiter (Value : string);
begin
   FKeywordsLimiter.Text := lowercase (Value);
   FKeywordsLimiter.Sort;
end;

procedure THttpScan.SetResultFile (Value : TResultFile);
begin
   FResultFile := Value;
end;

procedure THttpScan.SetLeavesFirst (Value : boolean);
begin
   HtmlDwnld.LeavesFirst := Value;
end;

procedure THttpScan.SetSeekRobotsTxt (Value : boolean);
begin
   FSeekRobotsTxt := Value;
end;

procedure THttpScan.SetMaxHtmlQueueSize (Value : integer);
begin
   if Value > 9 then begin
      FMaxHtmlQueueSize := Value;
   end;
end;

procedure THttpScan.SetRetryCount (Value : integer);
begin
   if Value > 0 then begin
      HtmlDwnld.RetryCount := Value;
      FRetryCount := Value;
   end;
end;

procedure THttpScan.SetTimeOut (Value : integer);
begin
   if Value >= 10 then begin
      HtmlDwnld.TimeOut := Value;
      FTimeOut := Value;
   end;
end;

procedure THttpScan.SetFileOfResults (Value : string);
begin
   FFileOfResults := Value;
   if Value <> '' then begin
      if LastChar ('\', Value) = 0 then begin
         FFileOfResults := GetCurrentDir + '\' + DOWNLOAD_SUBPATH + Value;
      end;
   end;
end;

procedure THttpScan.SetLogsEnabled (Value : boolean);
begin
   FOnLogsEnabled := Value;
   if FOnLogsEnabled then begin
      HtmlDwnld.OnLog := OnLogDwnld;
   end
   else begin
      HtmlDwnld.OnLog := nil;
   end;
end;

function THttpScan.LocalizeHrefSrc (var Body : string) : boolean;
const
   CMPITEMS = 14;
type
   TCmpString = record
      Str : String;
      ReplacingCode : Char;
      iStr : integer;
      LgStr : integer;
   end;
var
   AtLeastOne : boolean;
   UpperBody : string;
   Car : char;
   i, j, lg : integer;
   A : array [1..CMPITEMS] of TCmpString;
begin
   A[1].Str := ' HREF=';
   A[1].ReplacingCode:= IDHREF;

   A[2].Str := ' SRC=';
   A[2].ReplacingCode:= IDSRC;

   A[3].Str := '<A';
   A[3].ReplacingCode:= IDAREA;

   A[4].Str := '/A>';
   A[4].ReplacingCode:= IDENDAREA;

   A[5].Str := 'A/>';
   A[5].ReplacingCode:= IDENDAREA;

   A[6].Str := '<FRAME';
   A[6].ReplacingCode:= IDAREA;

   A[7].Str := '</FRAME';
   A[7].ReplacingCode:= IDENDAREA;

   A[8].Str := 'OPENWIN( ';
   A[8].ReplacingCode:= IDHREF;

   A[9].Str := 'BASE HREF=';
   A[9].ReplacingCode:= IDBASEHREF;

   A[10].Str := '<OPTION';
   A[10].ReplacingCode:= IDAREA;

   A[11].Str := '/OPTION>';
   A[11].ReplacingCode:= IDENDAREA;

   A[12].Str := '<APPLET';
   A[12].ReplacingCode:= IDAREA;

   A[13].Str := '/APPLET>';
   A[13].ReplacingCode:= IDENDAREA;

   A[14].Str := ' VALUE=';
   A[14].ReplacingCode:= IDVALUE;

   for j := 1 to CMPITEMS do begin
      A[j].lgStr := length (A[j].Str);
      A[j].iStr := 1;
   end;

   UpperBody := UpperCase (Body);


   AtLeastOne := false;
   lg := Length (UpperBody);
   for i := 1 to lg do begin
      Car := UpperBody[i];
      for j := 1 to CMPITEMS do begin
         With A[j] do begin
            if Car = Str[iStr] then begin
               inc (iStr);
               if iStr > lgStr then begin
                  Body[i] := ReplacingCode;
                  iStr := 1;
                  AtLeastOne := true;
               end;
            end
            else begin
               iStr := 1;
               if Car = Str[1] then begin
                  inc (iStr);
               end;
            end;
         end;
      end;
   end;
   LocalizeHrefSrc := AtLeastOne;
end;

procedure THttpScan.MFHtScanPostLocalizeHrefSrc (var Body_ : string);
var
   i : integer;
   lg : integer;
   VuIdArea : boolean;
   Done : boolean;
begin
   VuIdArea := false;
   lg := length (Body_);
   i := 1;
   Done := false;
   while not Done do begin
    if i > lg then begin
       Done := true;
    end
    else begin
       case Body_[i] of
         IDAREA    : begin
                        if VuIdArea then begin // there is no "</a>" in the previous "<a"
                           if i > 2 then begin // security
                              Body_[i - 1] := IDENDAREA; // the previous "<a" is now delimited by "</a>"
                              dec (i, 2); // i = -2 + 1: we restart at the next loop with IDENDAREA
                           end;
                        end
                        else begin
                           VuIdArea := true;
                        end;
                     end;
         IDENDAREA : begin
                        VuIdArea := false;
                     end;
       end;
       inc (i);
    end;
   end;
end;

function THttpScan.Start (Value : string) : boolean;
begin
   if Value <> '' then begin
      StartingUrl := Value;
   end;
   Result := Start;
end;

function THttpScan.Start: boolean;
var
   Continue : boolean;
   FileName : string;
   Index, InsertPos : integer;
   ReferringUrl : string;
begin
  Continue := true;
  if not FStartLocked then begin
    FStartLocked := true;

    if not HtmlDwnld.Aborting then begin
      if not ResultFilesOpened then begin
         FileName := '';
         if ResultFile = RESULTS_CREATE_DATETIME then begin
            FileName := GetCurrentDir + '\' + DOWNLOAD_SUBPATH + CreateFileNameFromNow;
         end
         else if ResultFile = RESULTS_FILEOFRESULTS then begin
            FileName := FFileOfResults;
         end;
         if FileName <> '' then begin
            AssignFile (HResultFile, FileName);
            {$I-}
            Rewrite (HResultFile);
            {$I+}
            if IOResult <> 0 then begin
               //showmessage ('不能创建 ' + FileName+ ' 文件');
               Continue := false;
            end
            else begin
                 ResultFilesOpened := true;
            end;
         end;
      end;
   end;

   if Continue then begin
      if FstartingUrl = '' then begin
         Continue := false;
        // showmessage ('URL不正确');
      end;
   end;

   if Continue then begin
      if not FCrackedStartingUrl.CrackUrl (FStartingUrl, HtmlDwnld.DownloadPath) then begin
       //  showmessage ('无效地址: ' + FStartingUrl);
         Continue := false;
      end;
   end;

   if Continue then begin
      if FCrackedStartingUrl.UrlComp.nPort = INTERNET_DEFAULT_HTTP_PORT then begin
         if HttpPort <> INTERNET_DEFAULT_HTTP_PORT then begin
            FCrackedStartingUrl.UrlComp.nPort := HttpPort;
         end;
      end;
      if FUserName <> '' then begin
         StrPcopy (FCrackedStartingUrl.UrlComp.lpszUsername, FUsername);
         HtmlDwnld.UserName := FUserName;
      end;
      if FPassword <> '' then begin
         StrPcopy (FCrackedStartingUrl.UrlComp.lpszPassword, FUsername);
         HtmlDwnld.Password := FPassword;
      end;
      if not UrlsDone.Find (FCrackedStartingUrl.Url, Index, InsertPos, true) then begin
         UrlsDone.Objects[insertPos] := pointer (true); // is html kind
         ReferringUrl := FInitialReferringUrl;
         if ReferringUrl = '' then begin
            ReferringUrl := FCrackedStartingUrl.Url;
         end;
         HtmlDwnld.AddInQueue (FCrackedStartingUrl.Url, ReferringUrl, 1, 0, ' ', GetActionForHtmlPages, 0, false, -1);
      end;
   end;
   FStartLocked := false;
  end;
  Start := Continue;
end;

function THttpScan.GetDepthSearchLevel : integer;
begin
   Result := HtmlDwnld.DepthSearchLevel;
end;

procedure THttpScan.SetDepthSearchLevel (Value : integer);
begin
   if Value > 0 then begin
      HtmlDwnld.DepthSearchLevel := Value;
   end;
end;

procedure THttpScan.SetInitialReferringUrl (Value : string);
begin
   FInitialReferringUrl := Value;
end;

function THttpScan.GetHtmlConcurrentDownloads : integer;
begin
   Result := HtmlDwnld.ConcurrentDownloads;
end;

function THttpScan.GetLeavesFirst : boolean;
begin
   Result := HtmlDwnld.LeavesFirst;
end;

procedure THttpScan.SetHtmlConcurrentDownloads (Value : integer);
begin
   if Value > 0 then begin
      HtmlDwnld.ConcurrentDownloads := Value;
      SetConcDwnlds (Value);
   end;
end;

procedure THttpScan.SetProxyType (Value : TProxyType);
begin
   FProxyType := Value;
   HtmlDwnld.ProxyType := ThGetThr.TProxyType (Value);
end;

procedure THttpScan.SetProxyAddress (Value : string);
begin
   FProxyAddress := Value;
   HtmlDwnld.ProxyAddress := Value;
end;

procedure THttpScan.SetProxyPort (Value : integer);
begin
   FProxyPort := Value;
   HtmlDwnld.ProxyPort := Value;
end;

procedure THttpScan.SetProxyUser (Value : string);
begin
   FProxyUser := Value;
   HtmlDwnld.ProxyUser := Value;
end;

procedure THttpScan.SetProxyPassword (Value : string);
begin
   FproxyPassword := Value;
   HtmlDwnld.ProxyPassword := Value;
end;

procedure THttpScan.SetUsername (Value : string);
begin
   FUsername := Value;
   HtmlDwnld.Username := Value;
end;

procedure THttpScan.SetAgent (Value : string);
begin
   FAgent := Value;
   HtmlDwnld.Agent := Value;
end;

procedure THttpScan.SetPassword (Value : string);
begin
   FPassword := Value;
   HtmlDwnld.Password := Value;
end;

function THttpScan.RebuildNewUrl (RetourGet : TMFHttpGet ; LinkExtracted : string ; var TypeLink : string) : string;
var
   Retour : PAnsiChar;
   LRetour : DWORD;
   ULinkExtracted : string;
   idieze : integer;
   Keep : boolean;
   NewUrl : string;
   TempBaseUrl : string;
   Port : string;
   pSearch: integer;
begin
  NewUrl := '';
  ULinkExtracted := UpperCase (LinkExtracted);

  if pos ('MAILTO:', ULinkExtracted) > 0 then begin
     TypeLink := 'mail';
     NewUrl := Copy (LinkExtracted, 8, MAXINT);

     pSearch := pos ('?', NewUrl);
     if pSearch > 1 then begin
        NewUrl := copy (NewUrl, 1, pSearch - 1);
     end;
  end
  else begin
     Keep := true;
     if Keep then begin
        if pos ('JAVASCRIPT', ULinkExtracted) > 0 then begin
           Keep := false;
        end;
     end;

     if Keep then begin
        if (Copy (ULinkExtracted, 1, 5) = 'HTTP:') then begin
           NewUrl := LinkExtracted;
        end
        else if (Copy (ULinkExtracted, 1, 6) = 'HTTPS:') then begin
           NewUrl := LinkExtracted;
        end
        else begin
           LRetour := 1024;
           GetMem (Retour, LRetour);
           if RetourGet.CrackedUrl.UrlComp.nPort = 80 then begin
              Port := '';
           end
           else begin
              Port := ':' + inttostr (RetourGet.CrackedUrl.UrlComp.nPort);
           end;
           TempBaseUrl := RetourGet.CrackedUrl.UrlComp.lpszScheme + '://' + string (RetourGet.CrackedUrl.UrlComp.lpszHostName) + Port  + string (RetourGet.CrackedUrl.UrlPath_Wo_Host_and_File);
           if InternetCombineUrl (PChar (TempBaseUrl), PChar (LinkExtracted), Retour, LRetour, ICU_NO_ENCODE) then begin
              NewUrl := Retour;
           end;
           FreeMem (Retour);
        end;
     end;

     if Keep then begin
        idieze := pos ('#', NewUrl);
        if idieze > 1 then begin
           NewUrl := Copy (NewUrl, 1, idieze - 1);
        end;
     end;
  end;
  RebuildNewUrl := NewUrl;
end;

function THttpScan.ExtractionType (NewUrl : string ; var iLastSlash : integer ; var HttpFileName : string ; var Protocol : string) : string;
var
   ipoint : integer;
   TypeLink : string;
   iCar : integer;
   iType: integer;
begin
   TypeLink := TYPELINK_UNKNOWN;

   HttpFileName := '';
   Protocol := 'http';
   iCar := pos ('://', NewUrl);
   if iCar > 1 then begin
      Protocol := lowercase (Copy (NewUrl, 1, iCar - 1));
      NewUrl[icar + 1] := '\';
      NewUrl[icar + 2] := '\'; // change // in \\ for LastDelimiter ('/')
   end;

   iCar := pos ('#', NewUrl);
   if iCar > 1 then begin
      NewUrl := Copy (NewUrl, 1, iCar - 1);
      TypeLink := 'htm';
   end
   else if pos ('&', NewUrl) > 0 then begin
      TypeLink := 'htm';
   end
   else if pos ('?', NewUrl) > 0 then begin
      TypeLink := 'htm';
   end
   else begin
      iLastSlash := LastDelimiter ('/', NewUrl);
      if copy (protocol, 1, 4) = 'http' then begin
         ipoint := LastDelimiter ('.', NewUrl);
         if ipoint > 0 then begin
            if iLastSlash > 0 then begin
               if ipoint > iLastSlash then begin
                  if ipoint < length (NewUrl) then begin
                     TypeLink := copy (NewUrl, ipoint + 1, MAXINT);
                  end
                  else begin
                     if Length (NewUrl) > 0 then begin
                        if NewUrl[length(NewUrl)] = '/' then begin
                           TypeLink := 'htm';
                        end;
                     end;
                  end;
               end
               else begin
                  TypeLink := 'htm';
               end;
            end
            else begin
               TypeLink := 'htm';
            end;
         end
         else begin
            // no point in the host name !
         end;
      end;
   end;
   if (TypeLink <> TYPELINK_UNKNOWN) and (TypeLink <> 'htm') then begin
      iType := QuickFindType (TypeLink, low (Types), high (Types));
      if iType = -1 then begin
         TypeLink := 'htm';
      end;
   end;
   if TypeLink = 'jpeg' then begin
      TypeLink := 'jpg';
   end;
   if TypeLink = 'mpeg' then begin
      TypeLink := 'mpg';
   end;
   Result := TypeLink;
end;

function DiscardJavaCat (var ExtractedLink : string) : boolean;
var
   i, lgth : integer;
   found, done : boolean;
begin
   lgth := length (ExtractedLink);
   done := false;
   found := false;
   i := 1;
   while not done do begin
      if i > lgth then begin
         done := true;
      end
      else begin
         if ExtractedLink[i] in ['+','(','[',']',')'] then begin
            found := true;
            done := true;
         end
         else begin
            inc (i);
         end;
      end;
   end;
   DiscardJavaCat := (not Found);
end;

procedure THttpScan.ClearUrlsDoneIfNotHtml;
var
   i : integer;
begin
   i := 0;
   while i < UrlsDone.Count do begin
      if boolean (UrlsDone.Objects[i]) then begin
         inc (i);
      end
      else begin
         UrlsDone.Delete (i);
      end;
   end;
end;

function EliminateOtherThanUrlInValue (ExtractedLink : string) : boolean;
var
   Keep : boolean;
   i : integer;
   Done : boolean;
   Car : char;
begin
   Keep := true;
   i := 1;
   Done := false;
   while not Done do begin
      if i > length (ExtractedLink) then begin
         Done := true;
      end
      else begin
         Car := ExtractedLink[i];
         if Car in [' ',';'] then begin
            Keep := false;
            Done := true;
         end;
         inc (i);
      end;
   end;
   if Keep then begin
      if pos ('/', ExtractedLink) = 0 then begin // no slash = this parameter is probably not an url
         Keep := false;
      end;
   end;
   EliminateOtherThanUrlInValue := Keep;
end;

procedure THttpScan.ParseHtml (RetourGet : TMFHttpGet ; Body : string ; NewUrlCracked : TCrackUrl);
var
   Done : boolean;
   i : integer;
   LgBody : integer;
   LinkOk, LinkFound : boolean;
   ExtractedLink : string;
   Car : char;
   MemoHrefOrSrc : char;
   Keep : boolean;
   itemp : integer;
   UpTemp : string;
   InPairArea : boolean;
   CountArea : integer;
begin
   LgBody := length (Body);
   i := 1;
   InPairArea := false;
   MemoHrefOrSrc := ' ';
   ExtractedLink := '';
   LinkFound := false;
   LinkOk := false;
   Done := false;
   while not Done do begin
      if i > lgBody then begin
         Done := true;
      end
      else if HtmlDwnld.Aborting then begin
         Done := true;
      end
      else begin
         Car := Body[i];
         if Car = IDAREA then begin
            LinkFound := false;
            LinkOk := false;
            inc (FGlobalKeyArea);
         end
         else if Car = IDPAIRAREA then begin
            inPairArea := true;
            LinkFound := false;
            LinkOk := false;
            inc (FGlobalKeyArea);
         end
         else if Car = IDENDAREA then begin
            inPairArea := false;
            LinkFound := false;
            LinkOk := false;
         end
         else if Car <= IDLOCATION then begin // IDHREF or IDSRC or BASEHREF or IDVALUE
            MemoHrefOrSrc := Car;
            LinkFound := true;
            LinkOk := false;
            ExtractedLink := '';
         end
         else begin
            if LinkFound then begin
               if ExtractedLink = '' then begin
                 if Car <> ' ' then begin
                    ExtractedLink := ExtractedLink + Car;
                 end
               end
               else begin
                  if not (Car in [' ', '>']) then begin
                    ExtractedLink := ExtractedLink + Car;
                  end
                  else begin
                     LinkOk := true;
                  end;
               end;
               if LinkOk then begin
                        Keep := true;
                        UpTemp := Uppercase (ExtractedLink);
                        if Pos ('TOP.WINDOW', UpTemp) > 0 then begin
                           Keep := false;
                        end;
                        itemp := Pos ('(', ExtractedLink); // embedded java
                        if itemp > 1 then begin
                           ExtractedLink := Copy (ExtractedLink, itemp + 1, 32000);
                           itemp := pos (')', ExtractedLink);
                           if itemp > 1 then begin
                              ExtractedLink := Copy (ExtractedLink, 1, itemp - 1);
                           end;
                        end;
                        itemp := Pos ('<', ExtractedLink); // embedded java
                        if itemp > 0 then begin
                           ExtractedLink := Copy (ExtractedLink, 1, itemp - 1);
                        end;
                        itemp := Pos ('>', ExtractedLink); // embedded java
                        if itemp > 0 then begin
                           ExtractedLink := Copy (ExtractedLink, 1, itemp - 1);
                        end;
                        if Keep then begin
                         Keep := DiscardJavaCat (ExtractedLink);
                         if Keep then begin
                          if ExtractedLink = '=' then begin
                             Keep := false;
                          end;
                          if MemoHrefOrSrc = IDVALUE then begin
                             Keep := EliminateOtherThanUrlInValue (ExtractedLink);
                          end;
                          if Keep then begin
                             if MemoHrefOrSrc = IDBASEHREF then begin
                                RetourGet.CrackedUrl.CrackUrl (ExtractedLink, HtmlDwnld.DownloadPath);
                             end;
                             if InPairArea then begin
                                CountArea := FGlobalKeyArea; // for the derived products
                             end
                             else begin
                                CountArea := 0;
                             end;
                             ProcessLinkFound (RetourGet, ExtractedLink, MemoHrefOrSrc, NewUrlCracked, CountArea);
                             Application.ProcessMessages;
                          end;
                         end;
                        end;
                        LinkFound := false;
                        ExtractedLink := '';
                        LinkOk := false;
               end;
            end;
         end;
         inc (i);
      end;
   end;
end;

function THttpScan.ProcessLinkFound (RetourGet : TMFHttpGet ; LinkExtracted : string ; HrefOrSrc_ : char ; NewUrlCracked : TCrackUrl ; CountArea : integer) : string;
var
   NewUrl : string;
   Protocol : string;
   Keep : boolean;
   TypeLink : string;
   StringToWrite : string;
   Index, InsertPos : integer;
   HrefOrSrc : char;
   HttpLink : boolean;
   PageFileName : string;
   iLastSlash : integer;
   iUrlDone : integer;
   LinkShouldBeReported, LinkShouldBeFollowed: boolean;
   FirstTimeHostEncountered : boolean;
   IsOnInitialSite, IsOnInitialPath: boolean;
   IsOnReferringSite, IsOnReferringPath: boolean;
begin
   Protocol := '';
   HRefOrSrc := ' ';
   HttpLink := true;
   iUrlDone := -1;
   FirstTimeHostEncountered := false;

   TypeLink := TYPELINK_UNKNOWN;

   Keep := true;
   if Keep then begin
      NewUrl := RebuildNewUrl (RetourGet, LinkExtracted, TypeLink);
      if NewUrl = '' then begin
         Keep := false;
      end;
   end;

   if FKeywordsFilterEnabled then begin
      if FKeywordsFilter.Count > 0 then begin
         if SearchKeywords (FKeywordsFilter, NewUrl) then begin
            Keep := false;
         end;
      end;
   end;

   if FKeywordsLimiterEnabled then begin
      if FKeywordsLimiter.Count > 0 then begin
         if not SearchKeywords (FKeywordsLimiter, NewUrl) then begin
            Keep := false;
         end;
      end;
   end;

   if Keep then begin
      if TypeLink = 'mail' then begin
         HttpLink := false;
      end
      else if TypeLink = TYPELINK_UNKNOWN then begin
         TypeLink := extractionType (NewUrl, iLastSlash, PageFileName, Protocol);
      end;
      if TypeLink <> TYPELINK_UNKNOWN then begin
         NewUrlCracked.CrackUrl (NewUrl, HtmlDwnld.DownloadPath);
      end
      else begin
         Keep := false;
      end;
      if copy (Protocol, 1, 4) <> 'http' then begin
         HttpLink := false;
      end;
   end;

   if Keep and HttpLink then begin
      if NewUrl[length(NewUrl)] = ')' then begin
         NewUrl := Copy (NewUrl, 1, length (NewUrl) - 1);
      end;
      if not HostsDone.Find (NewUrlCracked.UrlComp.lpszHostName, Index, InsertPos, true) then begin
         FirstTimeHostEncountered := true;
      end;
   end;
   if Keep then begin
      if Newurl <> '' then begin
         if not UrlsDone.Find (NewUrl, Index, InsertPos, true) then begin
            iUrlDone := InsertPos;
         end
         else begin
            iUrlDone := Index;
            Keep := false;
         end;
      end;
   end;

   if NewUrlCracked.SingleHost = FCrackedStartingUrl.SingleHost then begin
      IsOnInitialSite := true;
   end
   else begin
      IsOnInitialSite := false;
   end;

   if NewUrlCracked.SingleHost = RetourGet.CrackedUrl.SingleHost then begin
      IsOnReferringSite := true;
   end
   else begin
      IsOnReferringSite := false;
   end;

   if (IsOnInitialSite) and (pos (FCrackedStartingUrl.UrlPath_Wo_Host_and_File, NewUrl) <> 0) then begin
      IsOnInitialPath := true;
   end
   else begin
      IsOnInitialPath := false;
   end;

   if (IsOnReferringSite) and (pos (RetourGet.CrackedUrl.UrlPath_Wo_Host_and_File, NewUrl) <> 0) then begin
      IsOnReferringPath := true;
   end
   else begin
      IsOnReferringPath := false;
   end;

   // report and recurse rules
   LinkShouldBeReported := false;
   LinkShouldBeFollowed:= false;

   case FLinkScan of
      ScanAllLinks: begin
         LinkShouldBeFollowed:= true;
      end;
      ScanInitialSite: begin
         if IsOnInitialSite then begin
            LinkShouldBeFollowed:= true;
         end;
      end;
      ScanInitialPath: begin
         if IsOnInitialPath then begin
            LinkShouldBeFollowed:= true;
         end;
      end;
   end;

   case FLinkReport of
      reportAllLinks: begin
         LinkShouldBeReported := true;
      end;
      reportCurrentSiteLinks: begin
         if IsOnReferringSite then begin
            LinkShouldBeReported := true;
         end;
      end;
      reportCurrentPathLinks: begin
         if IsOnReferringPath then begin
            LinkShouldBeReported := true;
         end;
      end;
   end;

   // links reports
   if Keep then begin
      StringToWrite := 'x';
      HrefOrSrc := ' ';
      case HrefOrSrc_ of
         IDHREF : HrefOrSrc := 'H';
         IDSRC : HRefOrSrc := 'S';
      end;

      if LinkShouldBeReported then begin
         if HttpLink then begin
            if (not FTypeFilterEnabled)
             or (FTypeFilterEnabled and FTypeFilter.Find (TypeLink, Index, InsertPos, false)) then begin
               if Assigned (FOnLinkFound) then FOnLinkFound (Self, NewUrl,
                                                         TypeLink,
                                                         RetourGet.CrackedUrl.Url,
                                                         NewUrlCracked.UrlComp.lpszHostName,
                                                         NewUrlCracked.UrlPath_Wo_Host_and_File,
                                                         NewUrlCracked.UrlComp.lpszUrlPath,
                                                         NewUrlCracked.UrlComp.lpszExtraInfo,
                                                         StringToWrite,
                                                         HrefOrSrc,
                                                         CountArea,
                                                         Keep);
            end;
         end
         else begin
            if (not FTypeFilterEnabled) // for mail address
             or (FTypeFilterEnabled and FTypeFilter.Find (TypeLink, Index, InsertPos, false)) then begin

               if Assigned (FOnLinkFound) then FOnLinkFound (Self, NewUrl,
                                                             TypeLink,
                                                             RetourGet.CrackedUrl.Url,
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             StringToWrite,
                                                             HrefOrSrc,
                                                             CountArea,
                                                             Keep);
            end;
         end;
         if ResultFilesOpened then begin
            if StringToWrite <> 'x' then begin
               if StringToWrite > '' then begin
                  Writeln (HResultFile, StringToWrite);
               end;
            end
            else begin
               Writeln (HResultFile, '"' + TypeLink + '";"' + NewUrl + '"');
            end;
         end;
      end;
   end;

   // add in queue
   if Keep then begin
      if HttpLink then begin
         if TypeLink = 'htm' then begin
            UrlsDone.Objects[iUrlDone] := pointer (true); // is html kind

            if LinkShouldBeFollowed then begin
               if FirstTimeHostEncountered then begin
                  if FSeekRobotsTxt then begin
                     HtmlDwnld.AddInQueue ('http://' + NewUrlCracked.UrlComp.lpszHostName + '/robots.txt', '', RetourGet.DepthSearchLevel + 1, FRetryCount, HrefOrSrc_, GetActionForHtmlPages, CountArea, false, -1);
                  end;
               end;

               if HtmlDwnld.QueueCount < MaxQueueSize then begin
                  if RetourGet.DepthSearchLevel < DepthSearchLevel then begin
                     if not HtmlDwnld.Aborting then begin
                        HtmlDwnld.AddInQueue (NewUrl, RetourGet.CrackedUrl.Url, RetourGet.DepthSearchLevel + 1, 0, HrefOrSrc_, GetActionForHtmlPages, CountArea, false, -1);
                     end;
                  end;
               end;
            end;
         end
         else begin
            UrlsDone.Objects[iUrlDone] := pointer (false); // is not html kind
         end;
      end;
      if not HtmlDwnld.Aborting then begin
         if HttpLink then begin
            if assigned (FOnProcessNotHtmlLink) then FOnProcessNotHtmlLink (TypeLink, NewUrl, NewUrlCracked.UrlComp.lpszHostName, RetourGet.CrackedUrl.Url, HrefOrSrc, CountArea, NewUrlCracked.UrlFilePath, HttpLink);
         end;
      end;
   end;
end;

procedure THttpScan.ProcessMeta (PtGet : TMFHttpGet ; iStartAttrib : integer ; Meta : string ; UpMeta : string);
const
   MAXATTRIB = 3;
var
   i : integer;
   attrib : array[1..MAXATTRIB] of string;
   value : array[1..MAXATTRIB] of string;
   iattrib : integer;
   Done : boolean;
   InValue : boolean;
   InQuotes : boolean;
   Car, UpCar : char;
   Skip : boolean;
   TagType : string;
   p: integer;
   Url: string;
   index, insertpos: integer;
begin
   TagType := Copy (UpMeta, 1, iStartAttrib - 1);
   iattrib := 1;
   Attrib[1] := '';
   Value[1] := '';
   Attrib[2] := '';
   Value[2] := '';
   Attrib[3] := '';
   Value[3] := '';
   InValue := false;
   InQuotes := false;
   Done := false;
   i := iStartAttrib + 1;
   while not Done do begin
      if i > length (Meta) then begin
         if InValue then begin
            FOnMetaTag (Self, PtGet.CrackedUrl.Url, PtGet.ReferringUrl, TagType, attrib[1], value[1], attrib[2], value[2], attrib[3], value[3]);
         end;
         Done := true;
      end
      else begin
         Car := Meta[i];
         UpCar := UpMeta[i];
         Skip := false;
         if Car = '=' then begin
            InValue := true;
            Skip := true;
         end
         else if Car = '"' then begin
            InQuotes := not InQuotes;
            Skip := true;
         end
         else if Car = ' ' then begin
            if not InQuotes then begin
               if InValue then begin
                  if iattrib < MAXATTRIB then begin
                     inc (iattrib);
                     InValue := false;
                     Attrib[iattrib] := '';
                     Value[iattrib] := '';
                  end
                  else begin
                     Done := true;
                  end;
               end;
               Skip := true;
            end;
         end;
         if not Skip then begin
            if not InValue then begin
               Attrib[iattrib] := Attrib[iattrib] + UpCar;
            end
            else begin
               if InQuotes then begin
                  Value[iattrib] := Value[iattrib] + Car;
               end
               else begin
                  Value[iattrib] := Value[iattrib] + UpCar;
               end;
            end;
         end;
      end;
      inc (i);
   end;
   // search redirection
   if uppercase (Attrib[1]) = 'HTTP-EQUIV' then begin
      if uppercase (Value[1]) = 'REFRESH' then begin
         if uppercase (Attrib[2]) = 'CONTENT' then begin
            p := pos ('URL', Value[2]);
            if p > 0 then begin
               Url := Copy (Value[2], p + 3, MAXINT);
               if Url <> '' then begin
                  if uppercase (copy (Url, 1, 4)) <> 'HTTP' then begin
                     if ptget.CrackedUrl.Url[length(ptget.CrackedUrl.Url)] = '/' then begin
                        Url := ptget.CrackedUrl.Url + Url;
                     end
                     else begin
                        if Url[1] = '/' then begin
                           Url := ptget.CrackedUrl.Url + Url;
                        end
                        else begin
                           Url := ptget.CrackedUrl.Url + '/' + Url;
                        end;
                     end;
                  end;
                  if not UrlsDone.Find (FCrackedStartingUrl.Url, Index, InsertPos, true) then begin
                     UrlsDone.Objects[insertPos] := pointer (true); // is html kind
                     HtmlDwnld.AddInQueue (Url, PtGet.CrackedUrl.Url, PtGet.DepthSearchLevel, 0, 'H', GetActionForHtmlPages, 0, false, -1);
                  end;
               end;
            end;
         end
      end;
   end;
end;

procedure THttpScan.PageHead (PtGet : TMFHttpGet);
var
   UpBody : string;
   Head, UpHead : string;
   Start, Stop : integer;
   i : integer;
   Car : char;
   Chain, UpChain : string;
   Title : string;
begin
   UpBody := UpperCase (PtGet.Body);
   Start := pos ('<HEAD>', UpBody);
   Stop := pos ('</HEAD>', UpBody);
   if (Start > 0) and (Stop > 0) then begin
      inc (Start, 6);
      Head := RemoveUnwantedCharacters (Copy (PtGet.Body, Start, Stop - Start), false, true);
      UpHead := uppercase (Head);
      Start := pos ('<TITLE>', UpHead);
      Stop := pos ('</TITLE>', UpHead);
      if (Start > 0) and (Stop > 0) then begin
         inc (Start, 7);
         Title := Copy (Head, Start, Stop - Start);
         FOnMetaTag (Self, PtGet.CrackedUrl.Url, PtGet.ReferringUrl, 'TITLE', 'TITLE', Title, '','','','');
      end;
      Chain := '';
      UpChain := '';
      for i := 1 to Length (Head) do begin
         Car := Head[i];
         if Car = '<' then begin
            Chain := '';
            UpChain := '';
         end
         else if Car = '>' then begin
            if length (UpChain) > 5 then begin
               if UpChain[5] = ' ' then begin // base meta link ...
                  ProcessMeta (PtGet, 5, Chain, UpChain);
               end;
            end;
            Chain := '';
            UpChain := '';
         end
         else begin
            Chain := Chain + Car;
            UpChain := UpChain + UpHead[i];
         end;
      end;
   end;
end;
procedure THttpScan.HtmlPageReceived (Sender: TObject; PtGet : TMFHttpGet ; AlreadyOnDisk : boolean);
var
   Body_ : string;
   TempCrackUrl : TCrackUrl;
begin
   if Assigned (FOnPageReceived) then FOnPageReceived (Self, PtGet.CrackedUrl.UrlComp.lpszHostName, PtGet.CrackedUrl.Url, PtGet.Head, PtGet.Body);
   if Assigned (FOnMetaTag) then begin
     PageHead (PtGet);
   end;
   TempCrackUrl := TCrackUrl.Create; // used by processlinkfound and ParseHtml, not to create it again and again
   TempCrackUrl.CrackUrl (PtGet.ReferringUrl, HtmlDwnld.DownloadPath);
   if LogsEnabled then if assigned (FOnLog) then FOnLog (self, 'page received, processing:' + ptGet.CrackedUrl.Url);
   Body_ := RemoveUnwantedCharacters (PtGet.Body, true, false); // remove < 32
   Application.ProcessMessages;

   if lowercase (copy (PtGet.CrackedUrl.Url, length (PtGet.CrackedUrl.Url) - 9, maxint)) = 'robots.txt' then begin
      ProcessLinkFound (PtGet, PtGet.CrackedUrl.Url, ' ', TempCrackUrl, 0);
   end;

   if LocalizeHrefSrc (Body_) then begin
      Application.ProcessMessages;
      FOnPostLocalizeHrefSrc (Body_); // always assigned
      ParseHtml (PtGet, Body_, TempCrackUrl); // crackurl is declared 1 time in this procedure
      if Assigned (FOnPostHtmlPageReceived) then FOnPostHtmlPageReceived (Self, PtGet);
   end;
   TempCrackUrl.Free;
end;

procedure THttpScan.DwnldStats (Sender: TObject; Tag, InQueue, Loging, ToAnalyze, Done, Retries, Errors, AlreadyOnDisk : integer);
begin
   if Assigned (FDwnldStats) then FDwnldStats (Self, Tag, InQueue, Loging, ToAnalyze, Done, Retries, Errors, AlreadyOnDisk);
   if Assigned (FHttpScanStats) then FHttpScanStats (Self, InQueue, Loging, ToAnalyze, Done, Retries, Errors);
end;

procedure THttpScan.OnLogDwnld (Sender: TObject; LogMessage : string);
var
   Typ : string;
begin
 if not HtmlDwnld.Aborting then begin
  if LogsEnabled then begin
   if Assigned (FOnLog) then begin
      if TMFDwnld (Sender).Tag = ID_HTML then begin
         Typ := 'HTML: ';
      end
      else begin
         Typ := 'OTHER: ';
      end;
      FOnLog (Self, Typ + LogMessage);
   end;
  end;
 end;
end;

procedure THttpScan.CloseFileOfResults;
begin
   if ResultFilesOpened then begin
      ResultFilesOpened := false;
      CloseFile (HResultFile);
   end;
end;

function THttpScan.GetActionForHtmlPages : TGetAction;
begin
   GetActionForHtmlPages := STORE_TO_DATASTRING;
end;

function THttpScan.Stop : boolean;
var
   Ok : boolean;
begin
   if (Working) and (not HtmlDwnld.Aborting)  then begin
      CloseFileOfResults;
      StopHtml;
      Ok := true;
   end
   else begin
      Ok := false;
   end;
   Stop := Ok;
end;

procedure THttpScan.StopHtml;
begin
   HtmlDwnld.Aborting := true;
end;

procedure THttpScan.Exit;
begin
   FExiting := true;
   HtmlDwnld.AllowToAddInQueue := false;
   HtmlDwnld.OnDataReceived := nil;
   HtmlDwnld.OnUpdatedStats := nil;
   HtmlDwnld.OnLog := nil;
   HtmlDwnld.OnError := nil;
   HtmlDwnld.OnHeadComplete := nil;
   HtmlDwnld.OnProgress := nil;

   HtmlDwnld.Aborting := true;
   FQuitDelayCount := QUIT_DELAY_COUNT;
end;

procedure THttpScan.OnTimer (Sender: TObject);
begin
  if not INTIMER then begin
      INTIMER := true;
      if HtmlDwnld.Working then begin
         HtmlDwnld.Ontimer;

         if not HtmlDwnld.RefreshStats then begin
            HtmlDwnld.Working := false;
            CloseFileOfResults;
         end;
      end;

      if FQuitDelayCount = 0 then begin
         if assigned (FOnHeritedTimer) then FOnHeritedTimer (self, false);
      end
      else begin
         if assigned (FOnHeritedTimer) then FOnHeritedTimer (self, true);
         dec (FQuitDelayCount);
         if FQuitDelayCount = 0 then begin
            FExiting := false;
            Application.Terminate;
         end;
      end;
      INTIMER := false;
    end;
end;

procedure THttpScan.SetTypeFilterEnabled (Value: boolean);
begin
   FTypeFilterEnabled := Value;
end;

procedure THttpScan.SetKeywordsFilterEnabled (Value : boolean);
begin
   FKeywordsFilterEnabled := Value;
end;

procedure THttpScan.SetKeywordsLimiterEnabled (Value : boolean);
begin
   FKeywordsLimiterEnabled := Value;
end;

end.

