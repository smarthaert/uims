{*******************************************************************************

  AutoUpgrader Professional
  FILE: auAutoUpgrader.pas - AutoUpgrader component.

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

unit auAutoUpgrader;

interface

uses
  Windows, Messages, Classes, Controls, Graphics,
  auHTTP;

const
  LanguageResEntryPoint = 41000;

  auWizardTitle      = 0;
  auDownloadingFiles = 1;
  auUpdateCompleted  = 2;
  auCurrentFile      = 3;
  auAllFiles         = 4;
  auDownloadingFrom  = 5;
  auFileSize         = 6;
  auTransferRate     = 7;
  auEstimatedTime    = 8;
  auDownloadingOf    = 9;
  auSuccessUpdate    = 10;
  auEnterPassword    = 11;
  auUsername         = 12;
  auPassword         = 13;

  auYes              = 14;
  auNo               = 15;
  auOK               = 16;
  auCancel           = 17;
  auNext             = 18;
  auLater            = 19;

  auWarning          = 20;
  auError            = 21;
  auPreparing        = 22;
  auWelcome          = 23;
  auNoUpdate         = 24;
  auNoInfoFile       = 25;
  auHostUnreachable  = 26;
  auInterrupt        = 27;
  auLostFile         = 28;
  auPasswordRequired = 29;
  auConnectionLost   = 30;

  auAutoUpgraderStr  = LanguageResEntryPoint - 1;
  auDelphiStr        = LanguageResEntryPoint - 2;
  auAppTitle         = LanguageResEntryPoint - 3;

type
  TauAutoUpgrader = class;
  TauAutoUpgraderLanguage = (wlAuto, wlEnglish, wlRussian,
                             wlGerman, wlFrench, wlSpanish,
                             wlPortuguese, wlPortugueseBrazilian,
                             wlItalian, wlDutch, wlDanish,
                             wlSwedish, wlFinnish, wlEstonian,
                             wlUkrainian, wlPolish, wlCzech,
                             wlHungarian, wlRomanian, wlCatalan,
                             wlBasque, wlAfrikaans, wlChineseTraditional,
                             wlChineseSimplified, wlIndonesian, wlMalay,
                             wlIcelandic, wlTurkish, wlNorwegian,
                             wlSlovak);
  TacMiscFilesUpgradeBehavior = (mfuAlwaysDownload, mfuOnlyIfSizeDifferent);
  TauAutoUpgraderVersionControl = (byDate, byNumber);
  TacUpgradeMethod = (umSelfUpgrade, umUseExternalSetup, umRedirectToURL);

  { InfoFile structure }
  TauAutoUpgraderInfo = class(TPersistent)
  private
    FFiles: TStrings;
    FUpgradeMethod: TacUpgradeMethod;
    FUpgradeMsg: String;

    procedure SetFiles(const Value: TStrings);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Files: TStrings read FFiles write SetFiles;
    property UpgradeMethod: TacUpgradeMethod read FUpgradeMethod write FUpgradeMethod default umSelfUpgrade;
    property UpgradeMsg: String read FUpgradeMsg write FUpgradeMsg;
  end;

  TauAutoUpgraderShowMessages = set of (mAskUpgrade, mConnLost, mHostUnreachable, mLostFile, mNoInfoFile, mNoUpdateAvailable, mPasswordRequest);
  TauAutoUpgraderWizard = class(TPersistent)
  private
    FEnabled: Boolean;    
    FHideFileLocation: Boolean;
    FPicture: TPicture;
    FLanguage: TauAutoUpgraderLanguage;
    FStayOnTop: Boolean;

    procedure SetPicture(const Value: TPicture);
    procedure SetLanguage(Value: TauAutoUpgraderLanguage);
  public
    constructor Create(aOwner: TComponent);
    destructor Destroy; override;
  published
    property Enabled: Boolean read FEnabled write FEnabled default True;      
    property HideFileLocation: Boolean read FHideFileLocation write FHideFileLocation default False;
    property Pic118x218: TPicture read FPicture write SetPicture;
    property Language: TauAutoUpgraderLanguage read FLanguage write SetLanguage default wlAuto;
    property StayOnTop: Boolean read FStayOnTop write FStayOnTop default True;
  end;

  { TauAutoUpgrader }
  TAUBeginUpgradeEvent = procedure(Sender: TObject;
                                     const UpgradeMsg: String;
                                     UpgradeMethod: TacUpgradeMethod;
                                     Files: TStringList;
                                     var CanUpgrade: Boolean) of object;
  TAUEndUpgradeEvent = procedure(Sender: TObject; var RestartImediately: Boolean) of object;
  TAUFileStartEvent = procedure(Sender: TObject; const FileURL: String; FileSize: Integer; const FileTime: TDateTime; var CanUpgrade: Boolean) of object;
  TAUFileDoneEvent = procedure(Sender: TObject; const FileName: String) of object;
  TAUHostUnreachableEvent = procedure(Sender: TObject; const URL, Hostname: String) of object;
  TAULostFileEvent = procedure(Sender: TObject;
                                 const FileURL: String;
                                 ErrorCode: Integer;
                                 var ContinueUpgrade: Boolean) of object;
  TAUProgressEvent = procedure(Sender: TObject;
                                 const FileURL: String;
                                 FileSize, BytesRead,
                                 ElapsedTime, EstimatedTimeLeft: Integer;
                                 PercentsDone, TotalPercentsDone: Byte;
                                 TransferRate: Single) of object;
  TauAutoUpgrader = class(TauCustomHTTP)
  private
    FAutoCheck: Boolean;
    FAutoCheckDelay: Integer;
    FCacheOptions: TauCacheOptions;

    FInfoFile: TauAutoUpgraderInfo;
    FInfoFileURL: String;

    FVersionControl: TauAutoUpgraderVersionControl;
    FVersionDate: String;
    FVersionDateAutoSet: Boolean;
    FVersionNumber: String;
    
    FMiscFilesUpgrade: TacMiscFilesUpgradeBehavior;
    FRestartParams: String;
    FShowMessages: TauAutoUpgraderShowMessages;
    FWizard: TauAutoUpgraderWizard;

    // events
    FOnBeginUpgrade: TAUBeginUpgradeEvent;
    FOnEndUpgrade: TAUEndUpgradeEvent;
    FOnLaterUpgrade: TNotifyEvent;
    FOnProgress: TAUProgressEvent;
    FOnFileStart: TAUFileStartEvent;
    FOnFileDone: TAUFileDoneEvent;
    FOnDoOwnCloseAppMethod: TNotifyEvent;
    FOnAfterRestart: TNotifyEvent;

    // error events
    FOnAborted: TNotifyEvent;
    FOnConnLost: TNotifyEvent;
    FOnHostUnreachable: TAUHostUnreachableEvent;
    FOnNoUpdateAvailable: TNotifyEvent;
    FOnNoInfoFile: TNotifyEvent;
    FOnLostFile: TAULostFileEvent;
    FOnPasswordRequest: TauHTTPPasswordRequestEvent;

    // internal variables
    FHandle: THandle;
    FAborted, FCanUpgrade, FJustCheckButDontUpgrade: Boolean;
    FAutoCheckDone, FIsAutoCheck: Boolean;
    FQueryInfoStage, FUpdatesReady: Boolean;
    FUpdateMethod: TacUpgradeMethod; // assigned after parsing of info-file
    FDownloadQueue: TStringList;
    FCurrentFileName: String;
    FCurrentFileTime: TDateTime;    
    FCurrentFileIndex: Integer;
    FRestarting: Boolean;

    procedure SetAutoCheck(Value: Boolean);
    procedure SetQueryInfoStage(Value: Boolean);
    procedure SetRestartParams(const Value: String);
    procedure SetVersionDateAutoSet(Value: Boolean);
    function  IsDefaultParams: Boolean;

{$IFDEF LowerCB5}
    function  GetLoginUsername: String;
    procedure SetLoginUsername(const Value: String);
    function  GetLoginPassword: String;
    procedure SetLoginPassword(const Value: String);
{$ENDIF}

    // acHTTP events
    procedure HTTPHeaderInfo(Sender: TObject; ErrorCode: Integer;
      const RawHeadersCRLF, ContentType, ContentLanguage, ContentEncoding: String;
      ContentLength: Integer; const Location: String; const Date, LastModified, Expires: TDateTime;
      const ETag: String; var ContinueDownload: Boolean);
    procedure HTTPDone(Sender: TObject; const ContentType: String; FileSize: Integer; Stream: TStream);
    procedure HTTPDoneInterrupted(Sender: TObject);
    procedure HTTPProgress(Sender: TObject; const ContentType: String;
                           FileSize, BytesRead, ElapsedTime, EstimatedTimeLeft: Integer;
                           PercentsDone: Byte; TransferRate: Single; Stream: TStream);
    procedure HTTPConnLost(Sender: TObject; const ContentType: String; FileSize, BytesRead: Integer; Stream: TStream);
    procedure HTTPError(Sender: TObject; ErrorCode: Integer; Stream: TStream);
    procedure HTTPHostUnreachable(Sender: TObject);
    procedure HTTPPasswordRequest(Sender: TObject; const Realm: String; var TryAgain: Boolean);

    // internal subroutines
    procedure ParseInfoFile(Stream: TStream);
    procedure DoUpgrade(FirstFile: Boolean);
    procedure SafeTerminate(Imediately: Boolean {$IFDEF D4} = False {$ENDIF});
    procedure Relaunch(const ParamStr: String);

    procedure UpdateTimer;
  protected
    FWaitHandle: THandle;
    
    procedure WndProc(var Message: TMessage); virtual;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;

    function CheckUpdate(JustCheckIsUpdateAvailable: Boolean {$IFDEF D4} = False {$ENDIF}): Boolean; // Check InfoURL for update. Returns True if update available and CanUpdate specified in OnBeginUpdate event handler
    procedure Abort(Imediately: Boolean {$IFDEF D4} = False {$ENDIF});
    procedure RestartApplication(const Params: String {$IFDEF D4}=''{$ENDIF});
    procedure DeleteTemporaryFiles; // JH8

    property Aborted: Boolean read FAborted; // JH9
    property DownloadQueue: TStringList read FDownloadQueue; // JH2 
    property QInfoStage: Boolean read FQueryInfoStage write SetQueryInfoStage stored False;
    property Restarting: Boolean read FRestarting;
  published
    // derived properties
    property Proxy;
    property InternetOptions;
    property ThreadPriority;
    property TransferBufferSize;
    property HTTPUsername: String read {$IFDEF LowerCB5} GetLoginUsername {$ELSE} FLoginUsername {$ENDIF} write {$IFDEF LowerCB5} SetLoginUsername {$ELSE} FLoginUsername {$ENDIF} stored False;
    property HTTPPassword: String read {$IFDEF LowerCB5} GetLoginPassword {$ELSE} FLoginPassword {$ENDIF} write {$IFDEF LowerCB5} SetLoginPassword {$ELSE} FLoginPassword {$ENDIF} stored False;
    // derived events
    property OnProxyAuthenticationRequest;

    property AutoCheck: Boolean read FAutoCheck write SetAutoCheck default False;
    property AutoCheckDelay: Integer read FAutoCheckDelay write FAutoCheckDelay default 10000; // 10 seconds
    property CacheOptions read FCacheOptions write FCacheOptions default [coReloadIfNoExpireInformation, coReloadUpdatedObjects, coCreateTempFilesIfCantCache];
    property InfoFile: TauAutoUpgraderInfo read FInfoFile write FInfoFile;
    property InfoFileURL: String read FInfoFileURL write FInfoFileURL;
    property RestartParams: String read FRestartParams write SetRestartParams stored IsDefaultParams;

    property MiscFilesUpgrade: TacMiscFilesUpgradeBehavior read FMiscFilesUpgrade write FMiscFilesUpgrade default mfuAlwaysDownload;
    property VersionControl: TauAutoUpgraderVersionControl read FVersionControl write FVersionControl default byDate;
    property VersionDate: String read FVersionDate write FVersionDate;
    property VersionDateAutoSet: Boolean read FVersionDateAutoSet write SetVersionDateAutoSet; // NO DEFAULT!!!
    property VersionNumber: String read FVersionNumber write FVersionNumber;
    property ShowMessages: TauAutoUpgraderShowMessages read FShowMessages write FShowMessages default [mAskUpgrade, mConnLost, mLostFile, mPasswordRequest];
    property Wizard: TauAutoUpgraderWizard read FWizard write FWizard;

    // events
    property OnBeginUpgrade: TAUBeginUpgradeEvent read FOnBeginUpgrade write FOnBeginUpgrade;
    property OnEndUpgrade: TAUEndUpgradeEvent read FOnEndUpgrade write FOnEndUpgrade;
    property OnLaterUpgrade: TNotifyEvent read FOnLaterUpgrade write FOnLaterUpgrade;
    property OnProgress: TAUProgressEvent read FOnProgress write FOnProgress;
    property OnFileStart: TAUFileStartEvent read FOnFileStart write FOnFileStart;
    property OnFileDone: TAUFileDoneEvent read FOnFileDone write FOnFileDone;
    property OnDoOwnCloseAppMethod: TNotifyEvent read FOnDoOwnCloseAppMethod write FOnDoOwnCloseAppMethod;
    property OnAfterRestart: TNotifyEvent read FOnAfterRestart write FOnAfterRestart;

    // error events
    property OnAborted: TNotifyEvent read FOnAborted write FOnAborted; // this is not the same as OnAborted in HTTP!
    property OnConnLost: TNotifyEvent read FOnConnLost write FOnConnLost;
    property OnHostUnreachable: TAUHostUnreachableEvent read FOnHostUnreachable write FOnHostUnreachable;
    property OnNoUpdateAvailable: TNotifyEvent read FOnNoUpdateAvailable write FOnNoUpdateAvailable;
    property OnNoInfoFile: TNotifyEvent read FOnNoInfoFile write FOnNoInfoFile;
    property OnLostFile: TAULostFileEvent read FOnLostFile write FOnLostFile;
    property OnPasswordRequest: TauHTTPPasswordRequestEvent read FOnPasswordRequest write FOnPasswordRequest;
  end;

function AUDateToDate(const AUDate: String): TDateTime;
function DateToAUDate(const Date: TDateTime): String;
function AULangStr(Ident: Integer): String;
function AUFmtLangStr(Ident: Integer; const Args: Array of const): String;

implementation

uses Forms, Consts, SysUtils, auUtils,
     auAutoUpgraderUpgradeMsg, auAutoUpgraderWizard, auAutoUpgraderPassword;

const
  UpgraderModuleName = 'AUUPG';
  TMPExt             = '.uTMP';
  AUDateFormat       = 'MM"/"DD"/"YYYY';
  AFTER_UPGRADE      = '/afterupgrade';

var
  LanguageID: Word = 0;
  UpgraderFileName: String; // "Upgrader.exe", see Initialization section

{$R auAutoUpgrader.res}
{$R auAutoUpgraderLang.res}


{ INTERNAL }
function AUDateToDate(const AUDate: String): TDateTime;
var
  p1, p2: Integer;
begin
  try
    p1 := Pos('/', AUDate);
    p2 := Pos('/', Copy(AUDate, p1 + 1, Length(AUDate) - p1)) + p1;

    Result := EncodeDate(StrToInt(Copy(AUDate, p2 + 1, Length(AUDate) - p2)),
                         StrToInt(Copy(AUDate, 1, p1 - 1)),
                         StrToInt(Copy(AUDate, p1 + 1, p2 - p1 - 1)));
  except
    Result := Date;
  end;
end;

function DateToAUDate(const Date: TDateTime): String;
begin
  Result := FormatDateTime(AUDateFormat, Date)
end;

{ public but for internal use routines }
function AULangStr(Ident: Integer): String;
begin
  Result := LoadStr(Ident + LanguageID);
end;

function AUFmtLangStr(Ident: Integer; const Args: Array of const): String;
begin
  Result := FmtLoadStr(Ident + LanguageID, Args);
end;

procedure AUAdvErrorBox(const ErrorStr: String; Icon: Integer);
begin
  Application.MessageBox(PChar(ErrorStr),
                         PChar(AULangStr(auWizardTitle)),
                         MB_OK or Icon);
end;

procedure AUErrorBox(ErrorID: Byte; Icon: Integer);
begin
  AUAdvErrorBox(AULangStr(ErrorID), Icon);
end;

function GetAutoLanguage: TauAutoUpgraderLanguage;
const
{$IFNDEF D3}
  LANG_AFRIKAANS  = $36;
  LANG_BASQUE     = $2d;
  LANG_CATALAN    = $03;
  LANG_ESTONIAN   = $25;
  LANG_INDONESIAN = $21;
  LANG_UKRAINIAN  = $22;
{$ENDIF}
  LANG_MALAY      = $3e;
  PrimaryLanguages: Array[TauAutoUpgraderLanguage] of Integer = (0,
                      LANG_ENGLISH,    LANG_RUSSIAN,    LANG_GERMAN,
                      LANG_FRENCH,     LANG_SPANISH,    LANG_PORTUGUESE,
                      LANG_PORTUGUESE, LANG_ITALIAN,    LANG_DUTCH,
                      LANG_DANISH,     LANG_SWEDISH,    LANG_FINNISH,
                      LANG_ESTONIAN,   LANG_UKRAINIAN,  LANG_POLISH,
                      LANG_CZECH,      LANG_HUNGARIAN,  LANG_ROMANIAN,
                      LANG_CATALAN,    LANG_BASQUE,     LANG_AFRIKAANS,
                      LANG_CHINESE,    LANG_CHINESE,    LANG_INDONESIAN,
                      LANG_MALAY,      LANG_ICELANDIC,  LANG_TURKISH,
                      LANG_NORWEGIAN,  LANG_SLOVAK);
var
  tmpLang: TauAutoUpgraderLanguage;
  LangID, PrimaryLangID: Integer;
begin
  Result := wlEnglish;
  LangID := GetSystemDefaultLangID;
  PrimaryLangID := LangID mod 1024;

  // portuguese standard or brazilian
  if PrimaryLangID = LANG_PORTUGUESE then
   begin
    if LangID div 1024 = SUBLANG_PORTUGUESE_BRAZILIAN then
      Result := wlPortugueseBrazilian
    else
      Result := wlPortuguese
   end
  else
   // chinese traditional or simplified
   if PrimaryLangID = LANG_CHINESE then
    begin
     if LangID div 1024 = SUBLANG_CHINESE_SIMPLIFIED then
       Result := wlChineseSimplified
     else
       Result := wlChineseTraditional
    end
   else // other languages
    for tmpLang := wlEnglish to High(TauAutoUpgraderLanguage) do
     if PrimaryLangID = PrimaryLanguages[tmpLang] then
      begin
       Result := tmpLang;
       Break;
      end;

  LanguageID := LanguageResEntryPoint + Pred(Byte(Result)) * 50;
end;


{  TauAutoUpgraderInfo }
constructor TauAutoUpgraderInfo.Create;
begin
  inherited;
  FFiles := TStringList.Create;
end;

destructor TauAutoUpgraderInfo.Destroy;
begin
  FFiles.Free;
  inherited;
end;

procedure TauAutoUpgraderInfo.SetFiles(const Value: TStrings);
begin
  FFiles.Assign(Value);
end;


{ TauAutoUpgraderWizard }
constructor TauAutoUpgraderWizard.Create(aOwner: TComponent);
begin
  inherited Create;
  FEnabled := True;
  FPicture := TPicture.Create;
  FStayOnTop := True;
end;

destructor TauAutoUpgraderWizard.Destroy;
begin
  FPicture.Free;
  inherited;
end;

procedure TauAutoUpgraderWizard.SetPicture(const Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure TauAutoUpgraderWizard.SetLanguage(Value: TauAutoUpgraderLanguage);
begin
  if FLanguage <> Value then
   begin
    FLanguage := Value;
    if Value = wlAuto then
      GetAutoLanguage // set LanguageID
    else
      LanguageID := LanguageResEntryPoint + Pred(Byte(Value)) * 50;
   end;
end;


{ TauAutoUpgrader }
constructor TauAutoUpgrader.Create(aOwner: TComponent);
begin
  inherited;
  inherited OutputFileAttributes.Incomplete := [atrArchive, atrTemporary, atrHidden];
  inherited OnHeaderInfo := HTTPHeaderInfo;
  inherited OnDone := HTTPDone;
  inherited OnDoneInterrupted := HTTPDoneInterrupted;
  inherited OnProgress := HTTPProgress;
  inherited OnConnLost := HTTPConnLost;
  inherited OnHTTPError := HTTPError;
  inherited OnHostUnreachable := HTTPHostUnreachable;
  inherited OnPasswordRequest := HTTPPasswordRequest;

  // Deleting the Upgrader.exe which may remains from previous upgrade
  DeleteFile(UpgraderFileName);

  // preconfiguration
  FAutoCheckDelay := 10000; // 10 seconds
  FCacheOptions := [coReloadIfNoExpireInformation, coReloadUpdatedObjects, coCreateTempFilesIfCantCache];
  FInfoFile := TauAutoUpgraderInfo.Create;
  FInfoFileURL := HTTPPrefix;
  FRestartParams := AFTER_UPGRADE;  
  FVersionDate := DateToAUDate(Date);
  FVersionDateAutoSet := True;
  FShowMessages := [mAskUpgrade, mConnLost, mLostFile, mPasswordRequest];
  FWizard := TauAutoUpgraderWizard.Create(Self);
  FWizard.Language := wlAuto; 

  // list of files to upgrade
  FDownloadQueue := TStringList.Create;

  // handle for timer (used when AutoCheck = True)
  {$IFDEF D6}
  FHandle := Classes.AllocateHWnd(WndProc);  
  {$ELSE}
  FHandle := AllocateHWnd(WndProc);
  {$ENDIF}
end;

destructor TauAutoUpgrader.Destroy;
begin
  // kill timer and deallocate handle
  AutoCheck := False;
  {$IFDEF D6}
  Classes.DeallocateHWnd(FHandle);
  {$ELSE}
  DeallocateHWnd(FHandle);
  {$ENDIF}

//  DeleteTemporaryFiles;

  FDownloadQueue.Free; // files queue list
  FWizard.Free;        // wizard persistent structure
  FInfoFile.Free;      // info-file persistent structure

  inherited;
end;

procedure TauAutoUpgrader.Loaded;
begin
  inherited;
  if Assigned(FOnAfterRestart) and (ParamStr(1) = FRestartParams) then  
    FOnAfterRestart(Self);
end;

procedure TauAutoUpgrader.WndProc(var Message: TMessage);
begin
  with Message do
   if (Msg = WM_TIMER) and (wParam = 1) then
    try
      if IsOnline and FAutoCheck then
       begin
        FAutoCheckDone := True;
        UpdateTimer;
        CheckUpdate(False);
        FIsAutoCheck := True;        
       end;
    except
      Application.HandleException(Self);
    end
   else
    if Msg = WM_QUERYENDSESSION then
      Result := 1 // Correct shutdown
    else
      Result := DefWindowProc(FHandle, Msg, wParam, lParam);
end;


{ properties }
procedure TauAutoUpgrader.SetAutoCheck(Value: Boolean);
begin
  if FAutoCheck <> Value then
   begin
    FAutoCheck := Value;
    UpdateTimer;
   end;
end;

procedure TauAutoUpgrader.SetQueryInfoStage(Value: Boolean);
begin
  FQueryInfoStage := Value;
  if Value then
    inherited CacheOptions := FCacheOptions + [coPragmaNoCache] // never retreive Info-file from Proxy's cache 
  else
    inherited CacheOptions := FCacheOptions;
end;

procedure TauAutoUpgrader.SetRestartParams(const Value: String);
begin
  if FRestartParams <> Value then
   begin
    FRestartParams := Value;
    if FRestartParams = '' then
      FRestartParams := ' ';
   end;
end;

procedure TauAutoUpgrader.SetVersionDateAutoSet(Value: Boolean);
begin
  FVersionDateAutoSet := Value;
  if Value and (csDesigning in ComponentState) then
    FVersionDate := DateToAUDate(Date);
end;

function  TauAutoUpgrader.IsDefaultParams: Boolean;
begin
  Result := FRestartParams <> AFTER_UPGRADE;
end;

{$IFDEF LowerCB5}
function TauAutoUpgrader.GetLoginUsername: String;
begin
  Result := FLoginUsername;
end;

procedure TauAutoUpgrader.SetLoginUsername(const Value: String);
begin
  FLoginPassword := Value;
end;

function TauAutoUpgrader.GetLoginPassword: String;
begin
  Result := FLoginPassword;
end;

procedure TauAutoUpgrader.SetLoginPassword(const Value: String);
begin
  FLoginPassword := Value;
end;
{$ENDIF}

function TauAutoUpgrader.CheckUpdate(JustCheckIsUpdateAvailable: Boolean {$IFDEF D4} = False {$ENDIF}): Boolean; // Check InfoURL for update. Returns True if update available and CanUpdate specified in OnBeginUpdate event handler
begin
  if JustCheckIsUpdateAvailable then
    FJustCheckButDontUpgrade := True;
  try
    FAborted := False;
    FIsAutoCheck := False;
    if not ThreadBusy then
     begin
      QInfoStage := True;
      URL := FInfoFileURL;
      OutputFileName := '';
      // READ THE INFO-FILE
      Read;
     end;
    if JustCheckIsUpdateAvailable then
      Wait(FWaitHandle, INFINITE, True);     
  finally
    FJustCheckButDontUpgrade := False;
  end;
  Result := FCanUpgrade;   
end;

procedure TauAutoUpgrader.Abort(Imediately: Boolean {$IFDEF D4} = False {$ENDIF});
begin
  FAborted := True;
  SafeTerminate(Imediately); // stop awaiting, close all handles / wizards. terminate all processes
  DeleteTemporaryFiles; // JH6
  if Assigned(FOnAborted) then
    FOnAborted(Self);
end;

procedure TauAutoUpgrader.RestartApplication(const Params: String {$IFDEF D4} = ''{$ENDIF});
begin
  if not FUpdatesReady then
    DeleteTemporaryFiles;
    
  if Params = '' then
    Relaunch(FRestartParams + Char(Byte(FUpdateMethod) + Byte('0')))
  else
    Relaunch(Params);
end;


{ acHTTP events }
procedure TauAutoUpgrader.HTTPHeaderInfo(Sender: TObject; ErrorCode: Integer;
  const RawHeadersCRLF, ContentType, ContentLanguage, ContentEncoding: String;
  ContentLength: Integer; const Location: String; const Date, LastModified, Expires: TDateTime;
  const ETag: String; var ContinueDownload: Boolean);
var
  LocalFileName: String;
begin
  if FQueryInfoStage then Exit;
  FCurrentFileTime := LastModified;

  if Assigned(WizardForm) then
    WizardForm.LFileSize.Caption := AUFmtLangStr(auFileSize, [ContentLength / 1024]);

  if (FMiscFilesUpgrade = mfuOnlyIfSizeDifferent) and (ContentLength <> 0) and (FDownloadQueue.Count > 1) then
   begin
    LocalFileName := Copy(FCurrentFileName, 1, Length(FCurrentFileName) - Length(TMPExt));
    if (UpperCase(ExtractFileName(LocalFileName)) <> UpperCase(ExtractFileName(Application.ExeName))) and
       FileExists(LocalFileName) then
      ContinueDownload := ExtractFileSize(LocalFileName) <> ContentLength;
   end;

  if Assigned(FOnFileStart) then
    FOnFileStart(Self, URL, ContentLength, LastModified, ContinueDownload);
end;

procedure TauAutoUpgrader.HTTPDone(Sender: TObject; const ContentType: String; FileSize: Integer; Stream: TStream);
begin
  if FQueryInfoStage then
    ParseInfoFile(Stream)
  else
   begin
    if FCurrentFileTime <> 0 then
      SetFileTimes(FCurrentFileName, FCurrentFileTime, FCurrentFileTime, -1);

    if Assigned(FOnFileDone) then
      FOnFileDone(Self, FCurrentFileName);

    DoUpgrade(False); // reading next file (if exists)
   end;
end;

procedure TauAutoUpgrader.HTTPDoneInterrupted(Sender: TObject);
begin
  DoUpgrade(False); // reading next file (if exists)
end;

procedure TauAutoUpgrader.HTTPProgress(Sender: TObject; const ContentType: String;
                                       FileSize, BytesRead, ElapsedTime, EstimatedTimeLeft: Integer;
                                       PercentsDone: Byte; TransferRate: Single;
                                       Stream: TStream);
var
  TotalPercentsDone: Byte;                                       
begin
  if FQueryInfoStage then Exit;

  TotalPercentsDone := PercentsOf(FDownloadQueue.Count, FCurrentFileIndex) +
                       PercentsDone div FDownloadQueue.Count;

  if Assigned(FOnProgress) then
    FOnProgress(Self, URL, FileSize, BytesRead,
                ElapsedTime, EstimatedTimeLeft,
                PercentsDone, TotalPercentsDone,
                TransferRate);

  if Assigned(WizardForm) then
   with WizardForm do
    begin
     ProgressCurrentFile.Position := PercentsDone;
     ProgressAllFiles.Position := TotalPercentsDone;

     LTransferRate.Caption := AUFmtLangStr(auTransferRate, [TransferRate]);
     LEstimatedTime.Caption := AUFmtLangStr(auEstimatedTime, [EstimatedTimeLeft div 60 div 60,
                                                              EstimatedTimeLeft div 60 mod 60,
                                                              EstimatedTimeLeft mod 60 mod 60]);
    end;
end;

procedure TauAutoUpgrader.HTTPConnLost(Sender: TObject; const ContentType: String; FileSize, BytesRead: Integer; Stream: TStream);
begin
  if Assigned(FOnConnLost) then
    FOnConnLost(Self);

  if mConnLost in FShowMessages then
    AUErrorBox(auConnectionLost, MB_ICONSTOP);

  SafeTerminate(False);
end;

procedure TauAutoUpgrader.HTTPError(Sender: TObject; ErrorCode: Integer; Stream: TStream);
var
  ContinueUpgrade: Boolean;
begin
  if FQueryInfoStage then
   begin
    StopWait(FWaitHandle); // stop Wait at CheckUpdateAndWaitResult
       
    if Assigned(FOnNoInfoFile) then
      FOnNoInfoFile(Self);

    if mNoInfoFile in FShowMessages then
      AUErrorBox(auNoInfoFile, MB_ICONSTOP);
   end
  else
   begin
    ContinueUpgrade := False;
    
    if Assigned(FOnLostFile) then
      FOnLostFile(Self, URL, ErrorCode, ContinueUpgrade);

    if mLostFile in FShowMessages then
      ContinueUpgrade := Application.MessageBox(PChar(AUFmtLangStr(auLostFile, [FileName])),
                            PChar(AULangStr(auError) + ' #' + IntToStr(ErrorCode)),
                            MB_YESNO or MB_ICONWARNING or MB_SYSTEMMODAL) = ID_YES;

    if ContinueUpgrade then DoUpgrade(False) // next file
    else Abort(False);
   end; 
end;

procedure TauAutoUpgrader.HTTPHostUnreachable(Sender: TObject);
begin
  if Assigned(FOnHostUnreachable) then
    FOnHostUnreachable(Self, URL, HostName);

  if FIsAutoCheck then
   begin
    FAutoCheckDone := False;
    UpdateTimer;
   end
  else
    if (mHostUnreachable in FShowMessages) then
      AUAdvErrorBox(AUFmtLangStr(auHostUnreachable, ['' + HTTPPrefix + HostName + '''']), MB_ICONSTOP);

  SafeTerminate(False);                             
end;

procedure TauAutoUpgrader.HTTPPasswordRequest(Sender: TObject; const Realm: String; var TryAgain: Boolean);
begin
  if Assigned(FOnPasswordRequest) then
    FOnPasswordRequest(Self, Realm, TryAgain);

  if not TryAgain and (mPasswordRequest in FShowMessages) then
   begin
    TryAgain := ShowPasswordBox(Self, FileName);
    if not TryAgain then Abort(False);
   end;
end;


// internal subroutines
procedure TauAutoUpgrader.ParseInfoFile(Stream: TStream);
var
  I: Integer;
  InfoFile, St, MsgText: String;

  function ParseStr(const SubStr: String; LongStr: Boolean): String;
  var
    I: Integer;
  begin
    Result := '#' + SubStr + '=';
    if LongStr then Result := Result + '{';
    I := Pos(Result, LowerCase(InfoFile));
    if I <> 0 then
     begin
      inc(I, Length(Result));
      Result := Copy(InfoFile, I, Length(InfoFile) - I + 1);
      if Result <> '' then
       begin
        for I := 1 to Length(Result) do
         if (LongStr and (Result[I] = '}')) or
            (not LongStr and (Result[I] < #32)) then Break;

        Result := Copy(Result, 1, I - 1);
       end
     end
    else Result := '';
  end;
  
  function IsUpdateAvailable: Boolean;
  begin
    if FVersionControl = byNumber then
      Result := VersionCheck(ParseStr('version', False), VersionNumber) > 0
    else
      Result := AUDateToDate(ParseStr('date', False)) > AUDateToDate(FVersionDate);
  end;

begin
  SetLength(InfoFile, Stream.Size);
  Stream.Read(InfoFile[1], Stream.Size);

  // retrieving the files to upgrade (#urlX)
  FDownloadQueue.Clear;
  St := ParseStr('url', False);
  if St <> '' then FDownloadQueue.Add(St);
  St := ParseStr('url0', False);
  if St <> '' then FDownloadQueue.Add(St);
  I := FDownloadQueue.Count;
  repeat
    Inc(I);
    St := ParseStr('url' + IntToStr(I), False);
    if St = '' then Break;
    FDownloadQueue.Add(St);
  until False;

  // if we need upgrade
  FCanUpgrade := IsUpdateAvailable and (FDownloadQueue.Count <> 0);
  if FCanUpgrade then
   begin
    MsgText := ParseStr('message', True); // LongStr

    // upgrade method
    FUpdateMethod := umSelfUpgrade;  // default
    St := ParseStr('method', False);
    if St <> '' then
     case St[1] of
       '1': FUpdateMethod := umUseExternalSetup;
       '2': FUpdateMethod := umRedirectToURL;
      end;

    if Assigned(FOnBeginUpgrade) then
      FOnBeginUpgrade(Self, MsgText, FUpdateMethod, FDownloadQueue, FCanUpgrade);

    if not FJustCheckButDontUpgrade then
      if FCanUpgrade and (not (mAskUpgrade in FShowMessages) or ShowUpgradeBox(MsgText)) then
        if FUpdateMethod = umRedirectToURL then
          OpenURL(FDownloadQueue[0], True)
        else
          DoUpgrade(True)
      else
        if Assigned(FOnLaterUpgrade) then
          FOnLaterUpgrade(Self);
   end
  else
   begin
    if Assigned(FOnNoUpdateAvailable) then
      FOnNoUpdateAvailable(Self);

    if not FIsAutoCheck and (mNoUpdateAvailable in FShowMessages) then
      AUErrorBox(auNoUpdate, MB_ICONINFORMATION);
   end;

  StopWait(FWaitHandle);
end;

procedure TauAutoUpgrader.DoUpgrade(FirstFile: Boolean);
var
  RestartImediately: Boolean;
begin
  if FirstFile then // if first file then displaying the Wizard
   begin
    QInfoStage := False;
    FCurrentFileIndex := 0;
    if FWizard.Enabled then
      ShowAutoUpgraderWizard(Self);
   end
  else
   Inc(FCurrentFileIndex);

  if FCurrentFileIndex < FDownloadQueue.Count then
   begin
    FCurrentFileName := FDownloadQueue[FCurrentFileIndex];
       
    if Assigned(WizardForm) then
     with WizardForm do
      begin
       FileURL.Text := FCurrentFileName;
       AllDownloading.Caption := AUFmtLangStr(auDownloadingOf, [FCurrentFileIndex + 1, FDownloadQueue.Count]);
      end;

    URL := FCurrentFileName;
    // convert to temporary/output filename
    FCurrentFileName := ExtractFilePath(Application.ExeName) +
                        URLToFileName(FCurrentFileName) + TMPExt;
    OutputFileName := FCurrentFileName;
    // DOWNLOAD IT!
    ReleaseHTTPStream;
    Read;
   end
  else
   begin
    if Assigned(WizardForm) then
     with WizardForm do
      begin
       Finish; // show "Finish" messages
       Wait(FWaitHandle, INFINITE, True);
       if FAborted then Exit;
      end;

    FUpdatesReady := True;
    RestartImediately := True;
    if Assigned(FOnEndUpgrade) then
      FOnEndUpgrade(Self, RestartImediately);

    if RestartImediately then // Relaunch the application with following parameters
      RestartApplication('');
   end;
end;

procedure TauAutoUpgrader.SafeTerminate(Imediately: Boolean {$IFDEF D4} = False {$ENDIF});
begin
  StopWait(FWaitHandle); // stop Wait at CheckUpdateAndWaitResult OR in Finish page of Wizard

  // stop HTTP sessions
  inherited Abort(False, Imediately);

  // close all forms
  if WizardForm <> nil then
   begin
    WizardForm.Free;
    WizardForm := nil;
   end;
end;

procedure TauAutoUpgrader.Relaunch(const ParamStr: String);
var
  Dummy: DWord;
  MS: TMemoryStream;
  FileHandle: hFile;
begin
  // writting Upgrader.exe (self upgrading module)
  FileHandle := CreateFile(PChar(UpgraderFileName), GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
                           CREATE_ALWAYS, FILE_ATTRIBUTE_TEMPORARY, 0);
  if FileHandle <> INVALID_HANDLE_VALUE then
   begin
    MS := TMemoryStream.Create;
    try
      LoadResourceToStream(hInstance, UpgraderModuleName, UpgraderModuleName, MS);
      WriteFile(FileHandle, MS.Memory^, MS.Size, Dummy, nil);
    finally
      MS.Free;
    end;
    CloseHandle(FileHandle);
   end;

  // start self-upgrading mechanism
  WinExec(PChar(UpgraderFileName + ' ' + Application.ExeName + ' +' + ParamStr), SW_SHOWNORMAL);

  FRestarting := True;        
  if Assigned(FOnDoOwnCloseAppMethod) then
    FOnDoOwnCloseAppMethod(Self)
  else
    ShutdownApplication;
end;

procedure TauAutoUpgrader.UpdateTimer;
begin
  if not (csDesigning in ComponentState) then
   begin
    KillTimer(FHandle, 1);
    if FAutoCheck and not FAutoCheckDone and (FAutoCheckDelay > 0) then
     if SetTimer(FHandle, 1, FAutoCheckDelay, nil) = 0 then // check every N seconds
{$IFNDEF D3}
       raise EOutOfResources.CreateRes(SNoTimers);
{$ELSE}
       raise EOutOfResources.Create(SNoTimers);
{$ENDIF}
   end;
end;

procedure TauAutoUpgrader.DeleteTemporaryFiles;
var
  FindHandle: THandle;
  FindData: TWin32FindData;
begin
  FindHandle := FindFirstFile(PChar(IncludeTrailingBackslash(ExtractFilePath(Application.ExeName)) + '*.uTMP'), FindData);
  if FindHandle <> INVALID_HANDLE_VALUE then
   begin
    repeat
      DeleteFile(FindData.cFileName);
    until not FindNextFile(FindHandle, FindData);
    Windows.FindClose(FindHandle);
   end;
end;

initialization
  GetAutoLanguage;
  UpgraderFileName := GetTempDir + 'Upgrader3.exe'; // v3x

end.
