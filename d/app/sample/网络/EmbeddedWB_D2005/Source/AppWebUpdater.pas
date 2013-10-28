//*************************************************************
//                       Application Updater                  *
//                                                            *
//               For Delphi 5,6, 7 , 2005, 2006               *
//                     Freeware Component                     *
//                            by                              *
//                     Eran Bodankin (bsalsa)                 *
//                     bsalsa@bsalsa.com                      *
//                                                            *
//  Thanks to Snuki snuki@freemail.hu for his wonderful idea  *
//  Thanks to smot for English trans' and reformating         *
//     Documentation and updated versions:                    *
//               http://www.bsalsa.com                        *
//*************************************************************
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

unit AppWebUpdater;

interface

{$I EWB.inc}

uses
   Controls, ActiveX, Windows, SysUtils, Classes, LibXmlParser, ComCtrls, UrlMon;

type
   TErrorMessage = (emCreateSubBackup, emFileCopyError, emXmlError, emFileNotExist, emCreateFolder,
      emExit, emUpdateVersion, emCurrentVersion, emDownloadInfo, emDownloadFiles,
      emBusy, emDelete, emError, emMatch);

   TOnError = procedure(Sender: TObject; ErrorCode: TErrorMessage; Parameter, ErrMessage: string) of object;
type
   TSuccessMessage = (smDone, smUpdateNotNeeded, smUpdateNeeded, smChecking);

   TOnSuccess = procedure(Sender: TObject; SuccessCode: TSuccessMessage; Parameter, SuccessMessage: string) of object;
type

   TOnChangeText = procedure(Sender: TObject; Text: string) of object;
   TProgressEvent = procedure(ProgressMax: integer; Position: integer) of object;
   TUpdateFormat = (ufStandard, ufNumbers);

type
   PUpRec = ^TUpRec;
   TUpRec = record
      dlFileName: string[40];
      dlDestination: string[40];
      dlTerminate: Boolean;
   end;

   TUpdatesList = record
      NoRestartList: TStringList;
      WithRestartList: TStringList;
   end;

   TWebUpdater = class(TComponent)
   private
      ApplicationFolder: string;
      Busy: Boolean;
      FAbout: string;
      FAppCurrentVer: Double;
      FApplicationName: string;
      FAppNewVer: Double;
      FAuthor: string;
      FBackupFolder: string;
      FBatFileName: string;
      FCaption: string;
      FCompany: string;
      FCursor: TCursor;
      FDeleteBatch: Boolean;
      FDeleteLog: Boolean;
      FDeleteUpdates: Boolean;
      FDeleteBackups: Boolean;
      FDeleteWebInFo: Boolean;
      FEmail: string;
      FEnabled: Boolean;
      FAbortMessage: string;
      FErrorReport: Boolean;
      FExeName: string;
      FErrorMessage: string;
      FLogData: TStrings;
      FLogDateStamp: Boolean;
      FLogFileName: TFileName;
      FLogHeader: string;
      FMatchDetails: boolean;
      FOnChangeText: TOnChangeText;
      FOnError: TOnError;
      FOnProgress: TProgressEvent;
      FOnSuccess: TOnSuccess;
      FOpenAppFolder: Boolean;
      FProgressBar: TProgressBar;
      FQuitOnError: Boolean;
      FSaveBackup: Boolean;
      FShowMessages: boolean;
      FShowChanges: Boolean;
      FShowPersonalDetails: Boolean;
      FShowUpdateFiles: Boolean;
      FStatusBar: TStatusBar;
      FSuccessMessageText: string;
      FUpdateFormat: TUpdateFormat;
      FUpdateInFoText: TStringList;
      FUpdateText: TStringList;
      FUpdatesFolder: string;
      FWebInFoFileName: string;
      FWebURL: string;
      XmlFile: string;
      NeedTerminate: boolean;
      OldCaption: string;
      OldCursor: TCursor;
      XmlParser: TXMLParser;
      function Check_CreateFolder(FolderName: string): boolean;
      function CheckVersionNum(): boolean;
      function CopyFiles(Source, Destination, FileName: string): boolean;
      function CreateSubBackupFolder(): boolean;
      function DownloadFile(SourceFile, DestFile: string): Boolean;
      function DownloadWebUpdates(): boolean;
      function GetXmlData(): boolean;
      function GetXmlHead(): boolean;
      function GetXmlTag(const TagName: string): boolean;
      function ParseXML(): boolean;
      function PerformMatchDetails(aString, bString: string): boolean;
      function ProcessBatch(): boolean;
      procedure AddLog(text: string);
      procedure CleanUp();
      procedure FinishHandler();
      procedure InitialUpdating();
      procedure ProcessFolderNames();
      procedure RestartApplication();
      procedure RestoreAppControls();
      procedure SetAbout(Value: string);
      procedure SetUpdateInfoText(Value: TstringList);
      procedure UpdateAppControls();
      procedure UpdateInfo();
      procedure UpdateProgressControls(ProgMax, Pos: integer);
      procedure UpdateTextControls(txt: string);
      procedure WriteLog();
      procedure ExitError(ErrString: string);
      procedure ExitNoUpdateFound();
      procedure ExitMatch();
      procedure ExitOK();
      procedure ExitUser();
      procedure ErrMessagesHandler(pErrCode: TErrorMessage; Parameter: string = '');
      procedure SuccessMessagesHandler(pSuccessCode: TSuccessMessage; Parameter: string = '');

   protected
      function GetFullLogFileName: TFileName;
      procedure CloseLog();
      procedure OpenLog();
      procedure SetLogData(Value: TStrings);

   public
      Quit: boolean;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      function CheckBusyState: boolean;
      function DeleteFiles(FileName: string): Boolean;
      function DeleteFolder(FolderName: string): Boolean;
      function OpenFolder(FolderName: string): Boolean;
      function Start: Boolean;
      procedure ClearLog();
      procedure Stop();
      procedure SendErrorReport();

   published
      property About: string read FAbout write SetAbout;
      property AbortMessage: string read FAbortMessage write FAbortMessage;
      property AppCurrentVer: Double read FAppCurrentVer write FAppCurrentVer;
      property ApplicationName: string read FApplicationName write FApplicationName;
      property Author: string read FAuthor write FAuthor;
      property BackupFolder: string read FBackupFolder write FBackupFolder;
      property Caption: string read FCaption write FCaption;
      property Company: string read FCompany write FCompany;
      property Cursor: TCursor read FCursor write FCursor default crAppStart;
      property DeleteOldBackupOnInit: Boolean read FDeleteBackups write FDeleteBackups default False;
      property DeleteBatchFileOnComplete: Boolean read FDeleteBatch write FDeleteBatch default True;
      property DeleteLogOnComplete: Boolean read FDeleteLog write FDeleteLog default True;
      property DeleteUpdatesOnComplete: Boolean read FDeleteUpdates write FDeleteUpdates default True;
      property DeleteWebInfoFileOnComplete: Boolean read FDeleteWebInfo write FDeleteWebInfo default True;
      property EMail: string read FEMail write FEMail;
      property Enabled: boolean read FEnabled write FEnabled default True;
      property ErrorMessage: string read FErrorMessage write FErrorMessage;
      property FullLogFileName: TFileName read GetFullLogFileName;
      property LogAddTime: Boolean read FLogDateStamp write FLogDateStamp;
      property LogData: TStrings read FLogData write setLogData;
      property LogFileName: TFileName read FLogFileName write FLogFileName;
      property LogHeaderText: string read FLogHeader write FLogHeader;
      property MatchDetails: boolean read FMatchDetails write FMatchDetails default True;
      property MailErrorReport: boolean read FErrorReport write FErrorReport default True;
      property OnChangeText: TOnChangeText read FOnChangeText write FOnChangeText;
      property OnError: TOnError read FOnError write FOnError;
      property OnProgress: TProgressEvent read FOnProgress write FOnProgress;
      property OnSuccess: TOnSuccess read FOnSuccess write FOnSuccess;
      property OpenAppFolderOnComplete: Boolean read FOpenAppFolder write FOpenAppFolder default False;
      property ProgressBar: TProgressBar read FProgressBar write FProgressBar;
      property QuitOnError: Boolean read FQuitOnError write FQuitOnError default True;
      property SaveBackup: Boolean read FSaveBackup write FSaveBackup default True;
      property ShowUserMessages: boolean read FShowMessages write FShowMessages default True;
      property ShowChangeLog: boolean read FShowChanges write FShowChanges default True;
      property ShowPersonalDetails: boolean read FShowPersonalDetails write FShowPersonalDetails default True;
      property ShowUpdateFilesList: boolean read FShowUpdateFiles write FShowUpdateFiles default False;
      property StatusBar: TStatusBar read FStatusBar write FStatusBar;
      property SuccessMessageText: string read FSuccessMessageText write FSuccessMessageText;
      property UpdateFormat: TUpdateFormat read FUpdateFormat write FUpdateFormat default ufNumbers;
      property UpdateInfoText: TStringList read FUpdateInfoText write SetUpdateInfoText;
      property UpdatesFolder: string read FUpdatesFolder write FUpdatesFolder;
      property WebInfoFileName: string read FWebInfoFileName write FWebInfoFileName;
      property WebURL: string read FWebURL write FWebURL;

   end;

type
   TDownloadCallback = class(TInterfacedObject, IBindStatusCallback)
   public
      Quit: boolean;
      ProgressMax: integer;
      Position: integer;
      function OnStartBinding(dwReserved: DWORD; pib: IBinding): HResult; stdcall;
      function GetPriority(out nPriority): HResult; stdcall;
      function OnLowResource(reserved: DWORD): HResult; stdcall;
      function OnProgress(ulProgress, ulProgressMax, ulStatusCode: ULONG;
         szStatusText: LPCWSTR): HResult; stdcall;
      function OnStopBinding(hresult: HResult; szError: LPCWSTR): HResult; stdcall;
      function GetBindInfo(out grfBINDF: DWORD; var bindinfo: TBindInfo): HResult; stdcall;
      function OnDataAvailable(grfBSCF: DWORD; dwSize: DWORD; Formatetc: PFormatEtc;
         stgmed: PStgMedium): HResult; stdcall;
      function OnObjectAvailable(const iid: TGUID; punk: IUnknown): HResult; stdcall;
   end;

implementation

uses
   Forms, Messages, Dialogs, ShellAPI;

var
   OnProgressStatusList: TStringList;
   logFile: TextFile;
   Dcb: TDownloadCallback;
   UpdateRec: TUpdatesList;

const
   LineBrk = #10 + #13;
   LineSpc = '                  ';

///////////--- DownloadCallback Part --------///////////////

function TDownloadCallback.GetPriority(out nPriority): HResult; stdcall;
begin
   Result := E_NOTIMPL;
end;

function TDownloadCallback.OnLowResource(reserved: DWORD): HResult; stdcall;
begin
   Result := E_NOTIMPL;
end;

function TDownloadCallback.OnStartBinding(dwReserved: DWORD;
   pib: IBinding): HResult; stdcall;
begin
   Position := 0;
   ProgressMax := 100;
   Result := S_OK;
end;

function TDownloadCallback.OnProgress(ulProgress, ulProgressMax,
   ulStatusCode: ULONG; szStatusText: LPCWSTR): HResult; stdcall;
begin
   OnProgressStatusList := TStringList.Create;
   ulProgressMax := 100;
   ProgressMax := ulProgressMax;
   Position := ulProgress;
   OnProgressStatusList.Add(Format('[ %d]:: %s - %d:%d', [ulStatusCode,
      string(szStatusText),
         ulProgress,
         ulProgressMax]));
   OnProgressStatusList.Add(szStatusText);
   OnProgressStatusList.Add('Progress:= ' + IntToStr(ulProgress) + ':  '
      + IntToStr(ulProgressMax));
   OnProgressStatusList.Add('Status:= ' + SzStatusText);
   OnProgressStatusList.Add('');
   case ulStatusCode of
      1: OnProgressStatusList.Add('BINDSTATUS_FINDINGRESOURCE');
      2: OnProgressStatusList.Add('BINDSTATUS_CONNECTING');
      3: OnProgressStatusList.Add('BINDSTATUS_REDIRECTING');
      4: OnProgressStatusList.Add('BINDSTATUS_BEGINDOWNLOADDATA');
      5: OnProgressStatusList.Add('BINDSTATUS_DOWNLOADINGDATA');
      6: OnProgressStatusList.Add('BINDSTATUS_ENDDOWNLOADDATA ');
      7: OnProgressStatusList.Add('BINDSTATUS_BEGINDOWNLOADCOMPONENTS');
      8: OnProgressStatusList.Add('BINDSTATUS_INSTALLINGCOMPONENTS');
      9: OnProgressStatusList.Add('BINDSTATUS_ENDDOWNLOADCOMPONENTS');
      10: OnProgressStatusList.Add('BINDSTATUS_USINGCACHEDCOPY');
      11: OnProgressStatusList.Add('BINDSTATUS_SENDINGREQUEST');
      12: OnProgressStatusList.Add('BINDSTATUS_CLASSIDAVAILABLE');
      13: OnProgressStatusList.Add('BINDSTATUS_MIMETYPEAVAILABLE');
      14: OnProgressStatusList.Add('BINDSTATUS_CACHEFILENAMEAVAILABLE');
   end;
   if Quit then
      Result := E_ABORT
   else
      Result := S_OK;
end;

function TDownloadCallback.OnStopBinding(hresult: HResult; szError: LPCWSTR): HResult; stdcall;
begin
   Result := E_NOTIMPL;
end;

function TDownloadCallback.GetBindInfo(out grfBINDF: DWORD;
   var bindinfo: TBindInfo): HResult; stdcall;
begin
   Result := E_NOTIMPL;
end;

function TDownloadCallback.OnDataAvailable(grfBSCF: DWORD; dwSize: DWORD;
   Formatetc: PFormatEtc; stgmed: PStgMedium): HResult; stdcall;
begin
   Result := E_NOTIMPL;
end;

function TDownloadCallback.OnObjectAvailable(const iid: TGUID;
   punk: IUnknown): HResult; stdcall;
begin
   Result := E_NOTIMPL;
end;
///////////---End of DownloadCallback Part --------///////////////

///////////---Logger Part --------///////////////

procedure TWebUpdater.SetLogData(Value: TStrings);
begin
   FLogData.Assign(Value);
end;

function TWebUpdater.GetFullLogFileName: TFileName;
begin
   if (pos('\', FLogFileName) > 0) or
      (pos(':', FLogFileName) > 0) or
      (pos('/', FLogFileName) > 0) then
      begin
         Result := LogFileName;
      end
   else
      begin
         Result := ExtractFilePath(Application.Exename) + LogFileName;
      end;
end;

procedure TWebUpdater.WriteLog();
var
   i: Integer;
begin
   try
      OpenLog;
      UpdateProgressControls(100, 20);
      if FLogDateStamp then
         begin
            WriteLn(logFile, DateToStr(Date) + ' ' + TimeToStr(Now));
         end;
      if (FLogHeader > '') then
         begin
            WriteLn(logFile, FLogHeader);
         end;
      for i := 0 to (FLogData.Count - 1) do
         begin
            WriteLn(logFile, FLogData[i]);
         end;
   finally
      CloseLog;
   end;
end;

procedure TWebUpdater.ClearLog();
begin
   AssignFile(logFile, FullLogFileName);
   try
      ReWrite(logFile);
   finally
      CloseFile(logFile);
   end;
end;

procedure TWebUpdater.OpenLog();
begin
   AssignFile(LogFile, FullLogFileName);
{$I-}
   Append(LogFile);
{$I+}
   if (IOResult <> 0) then
      begin
         try
            ReWrite(LogFile);
         except
            on E: Exception do
               begin
                  E.Message := 'Unable to create error log file: ' + LineBrk + FLogFileName +
                     LineBrk + E.Message;
                  raise;
               end;
         end;
      end;
end;

procedure TWebUpdater.CloseLog();
begin
   CloseFile(LogFile);
end;

procedure TWebUpdater.AddLog(text: string);
var
   Data: TStrings;
   i: Integer;
begin
   OpenLog;
   Data := TStringList.Create;
   try
      if FLogDateStamp then
         begin
            Data.Add(DateToStr(Date) + ' ' + TimeToStr(Now));
         end;
      if (FLogHeader > '') then
         begin
            Data.Add(FLogHeader);
         end;
      Data.Add(text);
      Data.Add('');
      for i := 0 to (Data.Count - 1) do
         begin
            WriteLn(logFile, Data[i]);
         end;
   finally
      CloseLog;
      Data.Free;
   end;
end;
///////////---End of Logger Part --------///////////

///////////---Messages Part --------///////////

procedure TWebUpdater.ErrMessagesHandler(pErrCode: TErrorMessage; Parameter: string);
var
   EM, st: string;
begin
   case pErrCode of
      emBusy: EM := 'Update procedure is running. Please wait';
      emCreateSubBackup: EM := FErrorMessage + ' trying to create the sub backup folder!';
      emCreateFolder: EM := FErrorMessage + ' trying to create the folder!';
      emFileCopyError: EM := FErrorMessage + ' trying to copy the file';
      emXMLError: EM := FErrorMessage + ' trying to parse the XML file!';
      emUpdateVersion: EM := FErrorMessage + ' trying to locate the update version number!';
      emCurrentVersion: EM := FErrorMessage + ' trying to locate the current version number!';
      emDownloadInfo: EM := FErrorMessage + ' downloading the update Info file!';
      emDownloadFiles: EM := FErrorMessage + ' downloading the updates!';
      emDelete: EM := FErrorMessage + ' trying to delete the file !';
      emFileNotExist: EM := FErrorMessage + ' trying to locate the source folder!';
      emExit: EM := FAbortMessage;
      emError: EM := 'Updates checking was canceled (An error has been found).';
      emMatch: EM := 'Security Alert!! '
         + LineBrk + FErrorMessage + 'trying to match the application '
            + 'details with the remote web site details!';
   end;
   if Parameter = '' then
      st := EM
   else
      st := EM + LineBrk + Parameter;
   UpdateTextControls(st);
   if Assigned(FOnError) then
      FOnError(Self, pErrCode, Parameter, EM);
   if FShowMessages then
      MessageDlg(st, mtError, [mbAbort], 0);
   if FErrorReport then
      SendErrorReport();
end;

procedure TWebUpdater.SuccessMessagesHandler(pSuccessCode: TSuccessMessage; Parameter: string);
var
   SM: string;
   Name: string;
begin
   Name := ExtractFileName(Application.ExeName);
   case pSuccessCode of
      smDone: SM := FSuccessMessageText;
      smUpdateNeeded: SM := 'A new update is available for: ' + Name;
      smUpdateNotNeeded: SM := 'Your application is up to date.';
      smChecking: SM := 'Checking for the latest release';
   end;
   UpdateTextControls(SM);
   if FShowMessages then
      MessageDlg(SM, mtInformation, [mbOK], 0);
   if Assigned(FOnSuccess) then
      FOnSuccess(Self, pSuccessCode, Parameter, SM);
end;
///////////---End Of Messages Part --------///////////

///////////---Component Part --------///////////

constructor TWebUpdater.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   FCursor := crAppStart;
   FAbortMessage := 'Aborted! (User request).';
   FAbout := 'Application Updater by bsalsa : bsalsa@bsalsa.no-ip.info';
   Busy := False;
   FAppCurrentVer := 0.001;
   FAppNewVer := 0.001;
   FBackupFolder := 'Backup\';
   FLogDateStamp := True;
   FWebURL := 'http://';
   FEnabled := True;
 // FFilesToUpdate        := TStringList.Create;
//  FFilesToUpdate.Duplicates := dupIgnore;
{$IFDEF DELPHI_6_UP}
//  FFilesToUpdate.CaseSensitive := False;
{$ENDIF}
   FLogData := TstringList.Create;
   FUpdateText := TstringList.Create;
   FDeleteUpdates := True;
   FDeleteWebInfo := True;
   FDeleteLog := True;
   FDeleteBatch := True;
   FErrorMessage := 'An error ocurred while ';
   FErrorReport := True;
   FMatchDetails := True;
   FQuitOnError := True;
   FSaveBackup := True;
   FShowMessages := True;
   FShowChanges := True;
   FShowPersonalDetails := True;
   FShowUpdateFiles := False;
   FSuccessMessageText := 'Update is done.';
   FUpdateInfoText := TStringList.Create;
   FUpdateInfoText.Duplicates := dupIgnore;
   FUpdatesFolder := 'Updates\';
   FOpenAppFolder := False;
   XmlParser := TXMLParser.Create;
   FLogFileName := 'Updater.txt';
   FWebInfoFileName := 'Updates.xml';
   FCaption := 'Checking for updates... Please wait.';
   FUpdateFormat := ufNumbers;
   Quit := False;

   UpdateRec.NoRestartList := TStringList.Create;
   UpdateRec.NoRestartList.Duplicates := dupIgnore;
   UpdateRec.WithRestartList := TStringList.Create;
   UpdateRec.WithRestartList.Duplicates := dupIgnore;
end;

destructor TWebUpdater.Destroy;
begin
   Stop();
   while Busy do
      begin
         Application.ProcessMessages();
      end;
   OnProgressStatusList.Free;
   FUpdateInfoText.Free;
   FUpdateText.Free;
   XmlParser.Free;
   FLogData.Free;
   UpdateRec.WithRestartList.Free;
   UpdateRec.NoRestartList.Free;
   inherited Destroy;
end;

procedure TWebUpdater.SetAbout(Value: string);
begin
   Exit;
end;

procedure TWebUpdater.SetUpdateInfoText(Value: TstringList);
begin
   FUpdateInfoText.Assign(Value);
end;

///////////---End Of Component Part --------///////////

///////////////// private Updates procedures //////////////

procedure TWebUpdater.UpdateInfo();
begin
   if Quit then
      begin
         ExitUser();
         Exit;
      end;
   FUpdateInfoText.Add('A new update is available for ' + FApplicationName + '!' + LineBrk);
   if FShowPersonalDetails then
      begin
         if Trim(fAuthor) <> '' then
            FUpdateInfoText.Add('The update is available by: ' + LineBrk +
               LineBrk + 'Author:  ' + Trim(fAuthor));
         if Trim(fCompany) <> '' then
            FUpdateInfoText.Add('Company:  ' + Trim(fCompany));
         if Trim(fEMail) <> '' then
            FUpdateInfoText.Add('Email:  ' + Trim(fEMail));
      end;
   if FShowChanges then
      begin
         if FUpdateText.Text <> '' then
            FUpdateInfoText.Add(LineBrk + 'Update Changes: ' + FUpdateText.Text);
      end;
   if FShowUpdateFiles then
      begin
         FUpdateInfoText.Add(LineBrk + 'The files that will be updated are: ' + LineBrk
            + LineBrk + UpdateRec.NoRestartList.Text + UpdateRec.WithRestartList.Text)
      end;
   FUpdateInfoText.Add(LineBrk + 'Press "OK" to update ' + FApplicationName +
      ' or press "Abort".');
end;

procedure TWebUpdater.UpdateProgressControls(ProgMax, Pos: integer);
begin
   if Assigned(fProgressBar) then
      begin
         FProgressBar.Max := ProgMax;
         FProgressBar.Position := Pos;
      end;
   if Assigned(FOnProgress) then
      FOnProgress(ProgMax, Pos);
end;

procedure TWebUpdater.UpdateTextControls(txt: string);
begin
   AddLog(txt);
   if Assigned(fOnChangeText) then
      FOnChangeText(Self, txt);
   if Assigned(fStatusbar) then
      FStatusbar.SimpleText := txt;
end;

procedure TWebUpdater.UpdateAppControls();
begin
   AddLog('Updating Application Controls');
   OldCaption := Forms.Application.MainForm.Caption;
   Forms.Application.MainForm.Caption := FCaption;
   OldCursor := Screen.Cursor;
   Screen.Cursor := FCursor;
end;

procedure TWebUpdater.RestoreAppControls();
begin
   Screen.Cursor := OldCursor;
   Forms.Application.MainForm.Caption := OldCaption;
end;

///////////////// End of private Updates procedures  //////////////

///////////////// private procedures //////////////

function TWebUpdater.CheckVersionNum(): boolean;
var
   iNew, ICur: integer;
   Info: string;
begin
   Result := False;
   if Quit then
      begin
         ExitUser();
         Exit;
      end;
   if (fAppCurrentVer < 0) or (fAppCurrentVer > 100000) then
      begin
         AddLog('error has been found in the current version definition');
         ErrMessagesHandler(emCurrentVersion, ' Definition');
      end;
   if (fAppNewVer < 0) or (fAppNewVer > 100000) then
      begin
         AddLog('error has been found in the new version definition');
         ErrMessagesHandler(emUpdateVersion, ' Definition');
      end;
   iNew := StrToInt(FloatToStr(fAppNewVer * 1000));
   iCur := StrToInt(FloatToStr(fAppCurrentVer * 1000));
   if (iNew > iCur) then
      begin
         AddLog('A new update is available. ' + info);
         UpdateTextControls('A new update is available ');
         Result := True;
      end
   else
      begin
         UpdateTextControls('Your application is up to date.');
      end;
end;

function TWebUpdater.Check_CreateFolder(FolderName: string): boolean;
begin
   Result := False;
   if Quit then
      begin
         ExitUser();
         Exit;
      end;
{$IFDEF DELPHI_6_UP}
   if not (DirectoryExists(FolderName)) then
{$ENDIF}
      begin
         if not (CreateDir(FolderName)) then
            begin
               AddLog('Error Creating ' + FolderName + ' folder!');
               ErrMessagesHandler(emCreateFolder, FolderName);
               Result := True;
            end
         else
            AddLog('Creating ' + FolderName + ' folder.');
      end
{$IFDEF DELPHI_6_UP}
   else
      AddLog('Checking if folder ' + FolderName + ' exists. --> OK.');
{$ENDIF}
end;

function TWebUpdater.CopyFiles(Source, Destination, FileName: string): boolean;
begin
   Result := False;
   if Quit then
      begin
         ExitUser();
         Exit;
      end;
   UpdateProgressControls(100, 40);
   Source := (ApplicationFolder + Source);
   Destination := (ApplicationFolder + Destination);
   Check_CreateFolder(Destination);
   if FileExists(Source + FileName) then
      begin
         if not (CopyFile(PAnsiChar(Source + FileName),
            PAnsiChar(Destination + FileName), False)) then
            begin
               AddLog('Error copy file name: ' + Source + FileName +
                  '  ---> to: ' + Destination + FileName);
               ErrMessagesHandler(emFileCopyError, FileName);
               Result := True;
            end
         else
            AddLog('The File ' + Source + FileName +
               LineBrk + ' --> has been copied to: ' + Destination + FileName);
      end
   else
      begin
         ErrMessagesHandler(emFileNotExist, FileName);
         AddLog('File doesn'' t exist: ' + Source + FileName + ' !');
      end;
end;

function TWebUpdater.CreateSubBackupFolder: boolean;
begin
   Result := False;
   if Quit then
      begin
         ExitUser();
         Exit;
      end;
   FBackupFolder := FBackupFolder + FormatDateTime('yyyy_MM_dd_HH_mm_ss', Now) + '\';
   if FSaveBackup then
      if not CreateDir(fBackupFolder) then
         begin
            ErrMessagesHandler(emCreateSubBackup, FBackupFolder);
            AddLog('Error creating ' + FBackupFolder + ' folder.');
            Result := True;
         end
      else
         AddLog('Creating ' + FBackupFolder + ' folder. --> OK.');
end;

function TWebUpdater.GetXmlHead(): boolean;
begin
   Result := False;
   if Quit then
      begin
         ExitUser();
         Exit;
      end;
   while XmlParser.Scan() do
      begin
         if XmlParser.CurPartType = ptXmlProlog then
            begin
               AddLog('Parsing XML Head section');
               Result := True;
               exit;
            end
         else
            begin
               AddLog('Error parsing XML Head section');
               ErrMessagesHandler(emXMLError, '(  XML Head)');
            end;
      end;
end;

function TWebUpdater.GetXmlTag(const TagName: string): boolean;
begin
   Result := False;
   if Quit then
      begin
         ExitUser();
         Exit;
      end;
   while XmlParser.Scan() do
      begin
         if ((XmlParser.CurPartType = ptStartTag)
            or (XmlParser.CurPartType = ptEmptyTag))
            and (XmlParser.CurName = TagName) then
            begin
               AddLog('Parsing XML tag: ' + TagName);
               Result := True;
               Exit;
            end;
      end;
end;

function TWebUpdater.GetXmlData(): boolean;
begin
   Result := False;
   if Quit then
      begin
         ExitUser();
         Exit;
      end;
   while XmlParser.Scan() do
      begin
         if ((XmlParser.CurPartType = ptContent) or (XmlParser.CurPartType = ptCData)) then
            begin
               AddLog('Parsing XML data');
               Result := True;
               exit;
            end
         else
            begin
               ErrMessagesHandler(emXMLError, ' (XML Data)');
               AddLog('Error parsing XML data');
            end;
      end;
end;

function TWebUpdater.DownloadFile(SourceFile, DestFile: string): Boolean;
var
   st: string;
begin
   Result := False;
   if Quit then
      begin
         ExitUser();
         Exit;
      end;
   Dcb := TDownloadCallback.Create;
   Dcb.ProgressMax := 100;
   try
      st := 'Application folder\' + DestFile;
      AddLog('Trying to download: ' + SourceFile + '  To: ' + st);
      if UrlDownloadToFile(nil, PChar(SourceFile), PChar(DestFile), 0, dcb) = 0 then
         begin
            UpdateProgressControls(100, Dcb.Position);
            Result := True;
            AddLog(OnProgressStatusList.Text + LineBrk + 'Downloading ' + SourceFile +
               ' To: ' + st + ' was successful.')
         end
      else
         begin
            Result := False;
            ErrMessagesHandler(emDownloadInfo, SourceFile);
         end;
   except
      begin
         Result := False;
         ErrMessagesHandler(emDownloadInfo, SourceFile);
      end;
   end;
end;

function TWebUpdater.DeleteFiles(FileName: string): Boolean;
begin
   Result := False;
   if Quit then
      begin
         ExitUser();
         Exit;
      end;
   if not FileExists(FileName) then
      FileName := (GetCurrentDir + '\' + TrimLeft(FileName));
   begin
      FileName := TrimLeft(FileName);
      if DeleteFile(PChar(FileName)) then
         begin
            if FileName <> FLogFileName then
               begin
                  AddLog('File deleted: ' + FileName);
                  Result := True;
               end;
         end;
   end;
end;

function TWebUpdater.DeleteFolder(FolderName: string): Boolean;
var
   st: string;
   i: integer;
begin
   Result := False;
   if Quit then
      begin
         ExitUser();
         Exit;
      end;
   st := GetCurrentDir + '\' + FolderName;
   if FolderName = FUpdatesFolder then
      try
         for i := 0 to UpdateRec.NoRestartList.Count - 1 do
            begin
               DeleteFiles(st + TrimLeft(UpdateRec.NoRestartList[i]));
               Addlog('File deleted: ' + st + TrimLeft(UpdateRec.NoRestartList[i]));
            end;
         for i := 0 to UpdateRec.WithRestartList.Count - 1 do
            begin
               DeleteFiles(st + TrimLeft(UpdateRec.WithRestartList[i]));
               Addlog('File deleted: ' + st + TrimLeft(UpdateRec.WithRestartList[i]));
            end;
      except
      end;
   i := Length(st) - 1;
   SetLength(st, i);
   if RemoveDir(st) then
      begin
         Addlog('Folder deleted: ' + st);
         Result := True;
      end;
end;

function TWebUpdater.OpenFolder(FolderName: string): Boolean;
begin
   Result := False;
   if Quit then
      begin
         ExitUser();
         Exit;
      end;
   ShellExecute(Forms.Application.Handle, 'explore', Pchar(FolderName), nil,
      nil, SW_SHOWNORMAL);
   Addlog('Open folder : ' + FolderName);
   Result := True;
end;

procedure TWebUpdater.ProcessFolderNames();
begin
   if Quit then
      begin
         ExitUser();
         Exit;
      end;
   AddLog('Start processing file names. ');
   UpdateProgressControls(100, 20);
{$IFDEF DELPHI_6_UP}
{$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}
   XmlFile := Pchar(FWebURL + '/' + (fWebInfoFileName));
   FBatFileName := ChangeFileExt(Application.ExeName, '.bat');
   FExeName := ExtractFileName(Application.ExeName);
   FUpdatesFolder := IncludeTrailingBackslash(fUpdatesFolder);
   ApplicationFolder := IncludeTrailingBackslash(UpperCase(ExtractFilePath(Application.ExeName)));
   if Trim(fBackupFolder) = ''
      then
      FBackupFolder := ApplicationFolder + FBackupFolder
   else
      FBackupFolder := IncludeTrailingBackslash(fBackupFolder);
   AddLog('Finished processing files names.');
{$IFDEF DELPHI_6_UP}
{$WARN SYMBOL_PLATFORM ON}
{$ENDIF}
end;

procedure TWebUpdater.InitialUpdating();
begin
   ClearLog();
   WriteLog();
   AddLog('Initializing the updater.');
   NeedTerminate := False;
   FUpdateText.Clear();
   UpdateAppControls();
   UpdateProgressControls(100, 10);
   UpdateTextControls('Checking for updates...');
   ProcessFolderNames();
   if FDeleteBackups then
      if DeleteFile(fBackUpFolder + '\*.*') then
         DeleteFolder(Trim(fBackUpFolder));
end;

function TWebUpdater.ParseXML(): boolean;
var
   Node: TNvpNode;
   i: integer;
   UpdRec: PUpRec;
   MS: TMemoryStream;
   Zero: Char;
   Container: string;
   {$IFDEF DELPHI_7_UP}
   FormatSettings: TFormatSettings;
   {$ENDIF}
begin
   Result := False;
   if Quit then
      begin
         ExitUser();
         Exit;
      end;
   AddLog('Start downloading xml remote file.');
   if DownloadFile(XmlFile, FWebInfoFileName) then
      begin
         if not FileExists(ExtractFilePath(ParamStr(0)) + FWebInfoFileName) then
            begin
               ErrMessagesHandler(emFileNotExist, FWebInfoFileName);
               ExitError(fErrorMessage + 'trying to locate the web info file.');
               Exit;
            end
         else
            begin
               Zero := #0;
               MS := TMemoryStream.Create;
               MS.Write(Zero, 1);
               MS.LoadFromFile(fWebInfoFileName);
               XmlParser.SetBuffer(MS.Memory);
               XmlParser.Normalize := False;
               XmlParser.StartScan();
               if not GetXmlHead() then
                  if FQuitOnError then
                     begin
                        ExitError('An error has been found in the update XML file (Head Section)');
                        Exit;
                     end;
               if not GetXmlTag('Updates') then
                  if FQuitOnError then
                     begin
                        ExitError('An error has been found in the update XML file (Updates Section)');
                        Exit;
                     end;
               if not GetXmlTag('Details') then
                  if FQuitOnError then
                     begin
                        ExitError('An error has been found in the update XML file (Details)');
                        Exit;
                     end;
               if not GetXmlTag('ApplicationName') then
                  if FQuitOnError then
                     begin
                        ExitError('An error has been found in the update XML file (Application Name)');
                        Exit;
                     end;
               if not GetXmlData() then
                  if FQuitOnError then
                     begin
                        ExitError('An error has been found in the update XML file (Application Name)');
                        Exit;
                     end;
               if MatchDetails then
                  if not PerformMatchDetails(Trim(fApplicationName),
                     Trim(XmlParser.CurContent)) then
                     begin
                        ExitMatch();
                        Exit;
                     end;
               FApplicationName := XmlParser.CurContent;
               if not GetXmlTag('Author') then
                  if FQuitOnError then
                     begin
                        ExitError('An error has been found in the update XML file (Author)');
                        Exit;
                     end;
               if not GetXmlData() then
                  if FQuitOnError then
                     begin
                        ExitError('An error has been found in the update XML file (Author)');
                        Exit;
                     end;
               if MatchDetails then
                  if not PerformMatchDetails(Trim(fAuthor),
                     Trim(XmlParser.CurContent)) then
                     begin
                        ExitMatch();
                        Exit;
                     end;
               FAuthor := XmlParser.CurContent;
               if not GetXmlTag('Company') then
                  if FQuitOnError then
                     begin
                        ExitError('An error has been found in the update XML file (Company)');
                        Exit;
                     end;
               if not GetXmlData() then
                  if FQuitOnError then
                     begin
                        ExitError('An error has been found in the update XML file (Company)');
                        Exit;
                     end;
               if MatchDetails then
                  if not PerformMatchDetails(Trim(fCompany),
                     Trim(XmlParser.CurContent)) then
                     begin
                        ExitMatch();
                        Exit;
                     end;
               FCompany := XmlParser.CurContent;
               if not GetXmlTag('Version') then
                  if FQuitOnError then
                     begin
                        ExitError('An error has been found in the update XML file (Version)');
                        Exit;
                     end;
               if not GetXmlData() then
                  if FQuitOnError then
                     begin
                        ExitError('An error has been found in the update XML file (Version)');
                        Exit;
                     end;
                {$IFDEF DELPHI_7_UP}
               GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, formatSettings);
               FormatSettings.DecimalSeparator := '.';
               fAppNewVer := StrToFloat(XmlParser.CurContent, FormatSettings);
               {$ELSE}
               fAppNewVer := StrToFloat(XmlParser.CurContent);
                    {$ENDIF}
               AddLog('Application current version is: ' + FloatToStr(AppCurrentVer) +
                  LineBrk + '  Update version is: ' + XmlParser.CurContent);

               if not GetXmlTag('ChangeLog') then
                  if FQuitOnError then
                     begin
                        ExitError('An error has been found in the update XML file (ChangeLog section)');
                        Exit;
                     end;
               FUpdateText.Add(LineBrk);
               while GetXmlTag('Info') do
                  begin
                     for i := 0 to XmlParser.CurAttr.Count - 1 do
                        begin
                           Node := TNvpNode(XmlParser.CurAttr[i]);
                           if Node.Name = 'Text' then
                              FUpdateText.Add(TrimLeft(Node.Value));
                        end;
                  end;
               XmlParser.StartScan;
               if not GetXmlTag('Instructions') then
                  if FQuitOnError then
                     begin
                        ExitError('An error has been found in the update XML file (Instructions section)');
                        Exit;
                     end;
               while GetXmlTag('File') do
                  begin
                     New(UpdRec);
                     UpdRec.dlFileName := '';
                     UpdRec.dlDestination := '';
                     UpdRec.dlTerminate := False;
                     for i := 0 to XmlParser.CurAttr.Count - 1 do
                        begin
                           Node := TNvpNode(XmlParser.CurAttr[i]);
                           Container := Trim(Node.Name);
                           if Container = 'Name' then
                              UpdRec.dlFileName := Trim(Node.Value)
                           else
                              if (Container = 'Destination') then
                                 begin
                                    UpdRec.dlDestination := Trim(Node.Value) + '\';
                                    if UpdRec.dlDestination = 'ApplicationFolder\' then
                                       UpdRec.dlDestination := '';
                                 end
                              else
                                 if (Container = 'Terminate') then
                                    begin
                                       if Trim(Node.Value) = 'yes' then
                                          begin
                                             UpdRec.dlTerminate := True;
                                             UpdateRec.WithRestartList.AddObject(UpdRec.dlFileName, Pointer(UpdRec));
                                             AddLog('Adding files which require restart into the update list: ' + UpdRec.dlFileName);
                                             Result := True;
                                          end
                                       else
                                          if Trim(Node.Value) = 'no' then
                                             begin
                                                UpdRec.dlTerminate := False;
                                                UpdateRec.NoRestartList.AddObject(UpdRec.dlFileName, Pointer(UpdRec));
                                                AddLog('Adding files into the update list: ' + UpdRec.dlFileName);
                                                Result := True;
                                             end;
                                    end;
                        end;
                  end;
               MS.Free;
            end;
      end;
end;

function TWebUpdater.ProcessBatch(): boolean;
var
   slBatchFile: TStringList;
   Destination, FileName: string;
   i: integer;
   UpdRecRestart: PUpRec;
begin
   Result := False;
   if Quit then
      begin
         ExitUser();
         Exit;
      end;
   AddLog('Creating a batch file: ' + FBatFileName);
   slBatchFile := TStringList.Create;
   slBatchFile.Add('@Echo On');
   slBatchFile.Add(':again');
   for i := 0 to UpdateRec.WithRestartList.Count - 1 do
      begin
         UpdRecRestart := PUpRec(UpdateRec.WithRestartList.Objects[i]);
         FileName := Trim(UpdRecRestart.dlFileName);
         Destination := Trim(UpdRecRestart.dlDestination);
         if Destination <> '' then
            slBatchFile.Add('if not exist "' + Destination + '" MD " ' + Destination + '"');
         slBatchFile.Add('del "' + Destination + FileName + '"');
         slBatchFile.Add('if exist "' + Destination + FileName + '" goto again');
         slBatchFile.Add('copy "' + FUpdatesFolder + FileName + '" "' + Destination + FileName + '"');
         slBatchFile.Add('if not exist "' + Destination + FileName + '" ' + ' copy "' + FBackupFolder + '" "' + Destination + FileName + '"');
      end;
   slBatchFile.Add('call "' + Application.ExeName + '"');
   if FDeleteUpdates then
      slBatchFile.Add('RMDIR /S /Q "' + FUpdatesFolder + '"');
   if FDeleteBatch then
      slBatchFile.Add('del "' + FBatFileName + '"');
   slBatchFile.SaveToFile(fBatFileName);
   AddLog('Batch File Commands: ' + LineBrk + LineBrk + slBatchFile.Text);
   slBatchFile.Free;
   Result := True;
end;

function TWebUpdater.PerformMatchDetails(aString, bString: string): boolean;
begin
   AddLog('Matching details: ' + aString + ' to: ' + bString);
   if aString = bString then
      begin
         AddLog('Result: MATCH.');
         Result := True;
      end
   else
      begin
         AddLog('Result: No match found!');
         Result := False;
      end;
end;

procedure TWebUpdater.RestartApplication();
var
   ProcessInfo: TProcessInformation;
   StartupInfo: TStartupInfo;
   Res: DWORD;
begin
   if Quit then
      begin
         ExitUser();
         Exit;
      end;
   AddLog('Creating a process to run the batch file.');
   FillChar(StartupInfo, SizeOf(TStartupInfo), 0);
   StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
   StartupInfo.wShowWindow := SW_HIDE;
   if CreateProcess(nil, PChar(fBatFileName), nil, nil, False,
      IDLE_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInfo) then
      begin
         AddLog('Restarting.... Hold On.');
         CloseHandle(ProcessInfo.hThread);
         GetExitCodeProcess(ProcessInfo.hProcess, Res);
         CloseHandle(ProcessInfo.hProcess);
         PostMessage(Application.Handle, WM_CLOSE, 0, 0);
      end
   else
      begin
         AddLog('An error ocurred while trying to run the cmd file. ');
         raise
            Exception.CreateFmt('An error ocurred while trying to run the cmd file, error %d', [GetLastError()]);
      end;
end;

procedure TWebUpdater.FinishHandler();
begin
   RestoreAppControls();
   UpdateProgressControls(100, 0);
   FUpdateInfoText.Clear();
   CleanUp();
   Busy := False;
end;

procedure TWebUpdater.ExitOK();
begin
   SuccessMessagesHandler(smDone);
   if FOpenAppFolder then
      OpenFolder(ApplicationFolder);
   FinishHandler();
end;

procedure TWebUpdater.ExitError(ErrString: string);
begin
   ErrMessagesHandler(emError, ErrString);
   FinishHandler();
end;

procedure TWebUpdater.ExitMatch();
begin
   ErrMessagesHandler(emMatch);
   FinishHandler();
end;

procedure TWebUpdater.ExitUser();
begin
   ErrMessagesHandler(emExit);
   FinishHandler();
end;

procedure TWebUpdater.ExitNoUpdateFound();
begin
   UpdateTextControls('There are no new available updates. ');
   FinishHandler();
end;

///////////////// End of private procedures//////////////

///////////////// public procedures//////////////

function TWebUpdater.CheckBusyState(): boolean;
begin
   Result := False;
   if Quit then
      begin
         ExitUser();
         Exit;
      end;
   if Busy then
      begin
         ErrMessagesHandler(emBusy);
         Result := True;
      end
   else
      AddLog('Updater is running... ');
end;

procedure TWebUpdater.CleanUp();
begin
   Addlog('Cleaning unnecessary files. ');
   if FDeleteWebInfo then
      DeleteFiles(Trim(fWebInfoFileName));
   if (fDeleteUpdates and not NeedTerminate) then
      DeleteFolder(Trim(fUpdatesFolder));
   if FDeleteLog then
      DeleteFiles(Trim(fLogFileName));
end;

function TWebUpdater.DownloadWebUpdates(): boolean;
var
   i: integer;
   DLfilename, dest: string;
   UpdRec, UpdRecRestart: PUpRec;
begin
   Result := False;
   if Quit then
      begin
         ExitUser();
         Exit;
      end;
   if UpdateRec.NoRestartList.Count > 0 then
      begin
         for i := 0 to UpdateRec.NoRestartList.Count - 1 do
            begin
               UpdRec := PUpRec(UpdateRec.NoRestartList.Objects[i]);
               if (Trim(UpdRec.dlFileName) <> '') then
                  begin
                     if not FileExists(fUpdatesFolder + Trim(UpdateRec.NoRestartList[i])) then
                        begin
                           DLfilename := FWebURL + '/' + (Pchar(Trim(UpdateRec.NoRestartList[i])));
                           Dest := FUpdatesFolder + Trim(UpdateRec.NoRestartList[i]);
                           DownloadFile(DLfilename, Dest);
                        end
                     else
                        begin
                           if Dest = '' then
                              Dest := FUpdatesFolder + ' folder.';
                           AddLog('File name: ' + Trim(UpdateRec.NoRestartList[i]) +
                              ' already exists in ' + Dest + ' (OverWriting.)');
                        end;
                  end;
            end;
      end;
   if UpdateRec.WithRestartList.Count > 0 then
      begin
         for i := 0 to UpdateRec.WithRestartList.Count - 1 do
            begin
               UpdRecRestart := PUpRec(UpdateRec.WithRestartList.Objects[i]);
               if (Trim(UpdRecRestart.dlFileName) <> '') then
                  begin
                     if not FileExists(fUpdatesFolder + Trim(UpdateRec.WithRestartList[i])) then
                        begin
                           DLfilename := FWebURL + '/' + (Pchar(Trim(UpdateRec.WithRestartList[i])));
                           Dest := FUpdatesFolder + Trim(UpdateRec.WithRestartList[i]);
                           DownloadFile(DLfilename, Dest);
                        end
                     else
                        begin
                           if Dest = '' then
                              Dest := FUpdatesFolder + ' folder.';
                           AddLog('File name: ' + Trim(UpdateRec.WithRestartList[i]) +
                              ' already exists in ' + Dest + ' (OverWriting.)');
                        end;
                  end;
            end;
      end;
end;

function TWebUpdater.Start(): boolean;
var
   i: integer;
   SM, st: string;
   UpdRec, UpdRecRestart: PUpRec;
begin
   Result := False;
   if not Enabled then
      Exit;
   CheckBusyState();
   Busy := True;
   InitialUpdating();
   if not ParseXML() then
      ExitError(fErrorMessage + 'parsing the xml file')
   else
      begin
         if FUpdateFormat = ufNumbers then
            if not CheckVersionNum then
               begin
                  ExitNoUpdateFound();
                  Exit;
               end;

         UpdateInfo();
         AddLog('XML Information: ' + LineBrk + FUpdateInfoText.Text);
         if FShowMessages then
            begin
               SM := FUpdateInfoText.Text;
               if MessageDlg(SM, mtCustom, [mbOK, mbAbort], 0) <> 1 then
                  begin
                     ExitUser();
                     Exit;
                  end;
            end;

         if Check_CreateFolder(fUpdatesFolder) then
            if FQuitOnError then
               begin
                  ExitError(fErrorMessage + 'creating updates folder');
                  Exit;
               end;
         if Check_CreateFolder(fBackupFolder) then
            if FQuitOnError then
               begin
                  ExitError(fErrorMessage + 'creating backup folder');
                  Exit;
               end;
         if CreateSubBackupFolder() then
            if FQuitOnError then
               begin
                  ExitError(fErrorMessage + 'creating sub backup folder');
                  Exit;
               end;

         DownloadWebUpdates();
      end;

   if UpdateRec.NoRestartList.Count > 0 then
      begin
         for i := 0 to UpdateRec.NoRestartList.Count - 1 do
            begin
               UpdRec := PUpRec(UpdateRec.NoRestartList.Objects[i]);
               if ((Trim(UpdRec.dlFileName) <> '') and (UpdRec.dlTerminate = False)) then
                  begin
                     if FSaveBackup then
                        begin
                           if FileExists(UpdRec.dlDestination + UpdRec.dlFileName) then
                              CopyFiles(UpdRec.dlDestination, FBackUpFolder,
                                 UpdRec.dlFileName);
                        end;

                     if Trim(UpdRec.dlFileName) <> '' then
                        begin
                           CopyFiles(fUpdatesFolder, UpdRec.dlDestination,
                              UpdRec.dlFileName);
                        end;
                  end;
            end;
      end;

   if UpdateRec.WithRestartList.Count > 0 then
      begin
         NeedTerminate := True;
         st := 'Some of the updates require a restart. ' + LineBrk +
            'Press "Yes" to restart now, or press "Abort" to run the ' +
            'updates checking later.';
         UpdateTextControls(st);
         if MessageDlg(st, mtCustom, [mbYes, mbAbort], 0) = 6 then
            begin
               for i := 0 to UpdateRec.WithRestartList.Count - 1 do
                  begin
                     UpdRecRestart := PUpRec(UpdateRec.WithRestartList.Objects[i]);
                     if ((Trim(UpdRecRestart.dlFileName) <> '') and
                        (UpdRecRestart.dlTerminate = True)) then
                        begin
                           if FSaveBackup then
                              begin
                                 if FileExists(UpdRecRestart.dlDestination +
                                    UpdRecRestart.dlFileName) then
                                    CopyFiles(UpdRecRestart.dlDestination, FBackUpFolder,
                                       UpdRecRestart.dlFileName);
                              end;
                        end;
                  end;
               if ProcessBatch() then
                  begin
                     RestartApplication();
                     ExitOK();
                  end;
            end
         else
            ExitUser();
      end;
   if ((UpdateRec.NoRestartList.Count > 0) and not (NeedTerminate)) then
      ExitOK();
   Busy := False;
   Result := not Busy;
end;

procedure TWebUpdater.SendErrorReport();
var
   emMail, emSubject: string;
   emBody: TStringList;
begin
   if FileExists(GetFullLogFileName) then
      begin
         embody := TStringList.Create;
         emBody.Clear;
         try
            emBody.LoadFromFile(GetFullLogFileName);
            emSubject := 'Updater Error Report';
            emMail := 'mailto:' + FEmail + '?subject=' + emSubject + '&body=' + emBody.Text;
            AddLog('Mailing Error Report.... Hold On.');
            ShellExecute(Forms.Application.Handle, 'open', PChar(emMail), nil, nil, SW_SHOWNORMAL);
         finally
            emBody.Free;
         end;
      end;
end;

procedure TWebUpdater.Stop();
begin
   if Busy then
      begin
         Quit := True;
         UpdateTextControls('Stopped (User Request).');
      end;
end;

///////////////// End of public procedures//////////////

end.

