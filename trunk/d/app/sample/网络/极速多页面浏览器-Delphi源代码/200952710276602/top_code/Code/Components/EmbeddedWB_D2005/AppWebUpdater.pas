//*************************************************************
//        Application Updater ver D2005 (Feb. 1 , 2006)       *
//                                                            *
//               For Delphi 5,6, 7 , 2005, 2006               *
//                     Freeware Component                     *
//                            by                              *
//                     Eran Bodankin (bsalsa)                 *
//                     bsalsa@bsalsa.no-ip.info               *
//                                                            *
//  Thanks to Snuki snuki@freemail.hu for his wonderful idea  *
//                                                            *
//     Documentation and updated versions:                    *
//     http://groups.yahoo.com/group/delphi-webbrowser/       *
//*************************************************************


unit AppWebUpdater;

interface

{$I EWB.inc}

uses
 Controls, ActiveX, Windows, SysUtils, Classes, LibXmlParser, ComCtrls, UrlMon;

type
  TErrorMessage =
  (emCreateSubBackup, emFileCopyError, emXmlError, emFileNotExist, emCreateFolder,
   emExit, emUpdateVersion, emCurrentVersion, emDownloadInfo, emDownloadFiles,
   emBusy, emDelete, emError, emMatch);

  TOnError = procedure(Sender: TObject; ErrorCode: TErrorMessage;
                       Parameter, ErrMessage: string) of object;
type
  TSuccessMessage =
  (smDone, smUpdateNotNeeded, smUpdateNeeded, smChecking);

  TOnSuccess =  procedure(Sender: TObject; SuccessCode: TSuccessMessage;
                          Parameter, SuccessMessage: string) of object;
type

 TOnChangeText  = procedure(Sender: TObject; Text : string) of object;

 TProgressEvent = procedure(ProgressMax: integer; Position: integer) of object;

 TUpdateFormat  = (ufStandard, ufNumbers);

 type
  PUpRec        = ^TUpRec;
  TUpRec        = Record
  dlFileName    : string[40];
  dlDestination : string[40];
  dlTerminate   : Boolean;
 end;

   TUpdatesList = record
   NoRestartList   : TStringList;
   WithRestartList : TStringList;
 end;

  TWebUpdater = class(TComponent)
  private
    ApplicationFolder    : string;
    Busy                 : Boolean;
    fAbout               : String;
    fAppCurrentVer       : Double;
    fApplicationName     : string;
    fAppNewVer           : Double;
    fAuthor              : string;
    fBackupFolder        : string;
    fBatFileName         : string;
    fCaption             : string;
    fcompany             : string;
    fCursor              : TCursor;
    fDeleteBatch         : Boolean;
    fDeleteLog           : Boolean;
    fDeleteUpdates       : Boolean;
    fDeleteWebInfo       : Boolean;
    fEmail               : string;
    fEnabled             : Boolean;
    fAbortMessage        : string;
    fErrorReport         : Boolean;
    fExeName             : string;
    fErrorMessage        : string;
    fLogData             : TStrings;
    FLogDateStamp        : Boolean;
    fLogFileName         : TFileName;
    fLogHeader           : String;
    fMatchDetails        : boolean;
    fOnChangeText        : TOnChangeText;
    fOnError             : TOnError;
    FOnProgress          : TProgressEvent;
    fOnSuccess           : TOnSuccess;
    fOpenAppFolder       : Boolean;
    fProgressBar         : TProgressBar;
    fQuitOnError         : Boolean;
    fSaveBackup          : Boolean;
    fShowMessages        : boolean;
    fShowChanges         : Boolean;
    fShowPersonalDetails : Boolean;
    fShowUpdateFiles     : Boolean;
    fStatusBar           : TStatusBar;
    fSuccessMessageText  : string;
    fUpdateFormat        : TUpdateFormat;
    fUpdateInfoText      : TStringList;
    fUpdateText          : TStringList;
    fUpdatesFolder       : string;
    fWebInfoFileName     : string;
    fWebURL              : string;
    XmlFile              : string;
    NeedTerminate        : boolean;
    OldCaption           : string;
    OldCursor            : TCursor;
    XmlParser            : TXMLParser;
    function AddFiles(FileName: string): Integer;
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
    procedure AddLog(text : string);
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
    procedure ExitError(ErrString : string);
    procedure ExitNoUpdateFound();
    procedure ExitMatch();
    procedure ExitOK();
    procedure ExitUser();
    procedure ErrMessagesHandler(pErrCode : TErrorMessage; Parameter: string = '');
    procedure SuccessMessagesHandler(pSuccessCode: TSuccessMessage; Parameter: string = '');

  protected
   function GetFullLogFileName: TFileName;
   procedure CloseLog();
   procedure OpenLog();
   procedure SetLogData(Value: TStrings);

  public
    Quit  : boolean;
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
    property About: String read fAbout Write SetAbout;
    property AbortMessage : string read fAbortMessage Write fAbortMessage;
    property AppCurrentVer: Double read fAppCurrentVer Write fAppCurrentVer;
    property ApplicationName : string read fApplicationName Write fApplicationName;
    property Author : string read fAuthor Write fAuthor;
    property BackupFolder: string read fBackupFolder Write fBackupFolder;
    property Caption : string read fCaption Write fCaption;
    property Company : string read fCompany Write fCompany;
    property Cursor: TCursor read fCursor Write fCursor default crAppStart;
    property DeleteBatchFileOnComplete: Boolean read fDeleteBatch Write fDeleteBatch default True;
    property DeleteLogOnComplete: Boolean read fDeleteLog Write fDeleteLog default True;
    property DeleteUpdatesOnComplete: Boolean read fDeleteUpdates Write fDeleteUpdates default True;
    property DeleteWebInfoFileOnComplete: Boolean read fDeleteWebInfo Write fDeleteWebInfo default True;
    property EMail : string read fEMail Write fEMail;
    property Enabled: boolean read fEnabled Write fEnabled default True;
    property ErrorMessage : string read fErrorMessage Write fErrorMessage;
    property FullLogFileName: TFileName read GetFullLogFileName;
    property LogAddTime: Boolean read FLogDateStamp Write FLogDateStamp;
    property LogData : TStrings read FLogData Write setLogData;
    property LogFileName: TFileName read FLogFileName Write FLogFileName;
    property LogHeaderText: String read FLogHeader Write FLogHeader;
    property MatchDetails : boolean read fMatchDetails Write fMatchDetails default True;
    property MailErrorReport : boolean read fErrorReport Write fErrorReport default True;
    property OnChangeText: TOnChangeText read fOnChangeText Write fOnChangeText;
    property OnError: TOnError read fOnError Write fOnError;
    property OnProgress: TProgressEvent read FOnProgress write FOnProgress;
    property OnSuccess: TOnSuccess read fOnSuccess Write fOnSuccess;
    property OpenAppFolderOnComplete: Boolean read fOpenAppFolder Write fOpenAppFolder default False;
    property ProgressBar : TProgressBar read fProgressBar Write fProgressBar;
    property QuitOnError: Boolean read fQuitOnError Write fQuitOnError default True;
    property SaveBackup: Boolean read fSaveBackup Write fSaveBackup default True;
    property ShowUserMessages: boolean read fShowMessages Write fShowMessages default True;
    property ShowChangeLog: boolean read fShowChanges Write fShowChanges default True;
    property ShowPersonalDetails: boolean read fShowPersonalDetails Write fShowPersonalDetails default True;
    property ShowUpdateFilesList: boolean read fShowUpdateFiles Write fShowUpdateFiles default false;
    property StatusBar : TStatusBar read fStatusBar Write fStatusBar;
    property SuccessMessageText: string read fSuccessMessageText Write fSuccessMessageText;
    property UpdateFormat : TUpdateFormat read fUpdateFormat Write fUpdateFormat default ufNumbers;
    property UpdateInfoText: TStringList read fUpdateInfoText Write SetUpdateInfoText;
    property UpdatesFolder: string read fUpdatesFolder Write fUpdatesFolder;
    property WebInfoFileName: String read fWebInfoFileName Write fWebInfoFileName;
    property WebURL: String read fWebURL Write fWebURL;

end;

   type
    TDownloadCallback = class( TInterfacedObject, IBindStatusCallback)
    public
      Quit        : boolean;
      ProgressMax : integer;
      Position    : integer;
      function OnStartBinding(dwReserved: DWORD; pib: IBinding): HResult; stdcall;
      function GetPriority(out nPriority): HResult; stdcall;
      function OnLowResource(reserved: DWORD): HResult; stdcall;
      function OnProgress(ulProgress, ulProgressMax, ulStatusCode: ULONG;
        szStatusText: LPCWSTR): HResult; stdcall;
      function OnStopBinding(hresult: HResult; szError: LPCWSTR): HResult; stdcall;
      function GetBindInfo(out grfBINDF: DWORD; var bindinfo: TBindInfo): HResult; stdcall;
      function OnDataAvailable(grfBSCF: DWORD; dwSize: DWORD; formatetc: PFormatEtc;
        stgmed: PStgMedium): HResult; stdcall;
      function OnObjectAvailable(const iid: TGUID; punk: IUnknown): HResult; stdcall;
    end;

procedure Register;

implementation

 uses
   Forms, Messages, Dialogs, ShellAPI;

 var
   OnProgressStatusList : TStringList;
   logFile : TextFile;
   Dcb     : TDownloadCallback;
   UpdateRec : TUpdatesList;
 //  ProgressMax: integer;


 Const
   LineBrk =  #10 + #13;
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
  OnProgressStatusList.Add(Format('[ %d]:: %s - %d:%d', [ ulStatusCode,
                                  String( szStatusText),
                                                           ulProgress,
                                                           ulProgressMax]));
  OnProgressStatusList.Add(szStatusText);
  OnProgressStatusList.Add('Progress:= '+ IntToStr(ulProgress)+ ':  '
                          + IntToStr(ulProgressMax));
  OnProgressStatusList.Add('Status:= '+ SzStatusText);
  OnProgressStatusList.Add('');
  case ulStatusCode of
    1  : OnProgressStatusList.Add('BINDSTATUS_FINDINGRESOURCE');
    2  : OnProgressStatusList.Add('BINDSTATUS_CONNECTING');
    3  : OnProgressStatusList.Add('BINDSTATUS_REDIRECTING');
    4  : OnProgressStatusList.Add('BINDSTATUS_BEGINDOWNLOADDATA');
    5  : OnProgressStatusList.Add('BINDSTATUS_DOWNLOADINGDATA');
    6  : OnProgressStatusList.Add('BINDSTATUS_ENDDOWNLOADDATA ');
    7  : OnProgressStatusList.Add('BINDSTATUS_BEGINDOWNLOADCOMPONENTS');
    8  : OnProgressStatusList.Add('BINDSTATUS_INSTALLINGCOMPONENTS' );
    9  : OnProgressStatusList.Add('BINDSTATUS_ENDDOWNLOADCOMPONENTS');
    10 : OnProgressStatusList.Add('BINDSTATUS_USINGCACHEDCOPY');
    11 : OnProgressStatusList.Add('BINDSTATUS_SENDINGREQUEST');
    12 : OnProgressStatusList.Add('BINDSTATUS_CLASSIDAVAILABLE');
    13 : OnProgressStatusList.Add('BINDSTATUS_MIMETYPEAVAILABLE');
    14 : OnProgressStatusList.Add('BINDSTATUS_CACHEFILENAMEAVAILABLE');
  end;
  If Quit then Result := E_ABORT
  else Result := S_OK;
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
  formatetc: PFormatEtc; stgmed: PStgMedium): HResult; stdcall;
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
  if (pos('\',FLogFileName) > 0) or
     (pos(':',FLogFileName) > 0) or
     (pos('/',FLogFileName) > 0) then
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
  i    : Integer;
begin
 try
   OpenLog;
   UpdateProgressControls(100, 20);
   if FLogDateStamp then
   begin
      WriteLn(logFile,DateToStr(Date)+' '+TimeToStr(Now));
   end;
   if (FLogHeader > '') then
   begin
      WriteLn(logFile,FLogHeader);
   end;
   for i := 0 to ( FLogData.Count-1 ) do
   begin
      WriteLn(logFile,FLogData[i]);
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
   AssignFile(LogFile,FullLogFileName);
   {$I-}
   Append(LogFile);
   {$I+}
   if (IOResult <> 0) then
    begin
    try
      ReWrite(LogFile);
    except
      on E:Exception do
      begin
        e.message := 'Unable to create error log file: ' + LineBrk + FLogFileName +
                      LineBrk + e.message;
        raise;
      end;
    end;
   end;
end;

procedure TWebUpdater.CloseLog();
begin
  CloseFile(LogFile);
end;

procedure TWebUpdater.AddLog(text : string);
var
  Data : TStrings;
  i    : Integer;
Begin
  OpenLog;
  Data := TStringList.Create;
  Try
   if FLogDateStamp then
   begin
     Data.Add(DateToStr(Date)+' '+TimeToStr(Now));
   end;
   if ( FLogHeader > '' ) then
   begin
     Data.Add(FLogHeader);
   end;
   Data.Add(text);
   Data.Add('');
   for i := 0 to ( Data.Count-1 ) do
   begin
     WriteLn(logFile,Data[i]);
   end;
  Finally
   CloseLog;
   Data.Free;
  end;
end;
///////////---End of Logger Part --------///////////

///////////---Messages Part --------///////////
procedure TWebUpdater.ErrMessagesHandler(pErrCode: TErrorMessage; Parameter: string);
var
 EM, st : string;
begin
  case pErrCode of
      emBusy            : EM:='Update procedure is running. Please wait';
      emCreateSubBackup : EM:= fErrorMessage+' trying to create the sub backup Folder!';
      emCreateFolder    : EM:= fErrorMessage+' trying to create the folder!';
      emFileCopyError   : EM:= fErrorMessage+' trying to copy the file';
      emXMLError        : EM:= fErrorMessage+' trying to parse the XML file!';
      emUpdateVersion   : EM:= fErrorMessage+' trying to locate the update version number!';
      emCurrentVersion  : EM:= fErrorMessage+' trying to locate the current version number!';
      emDownloadInfo    : EM:= fErrorMessage+' downloading the update Info File!';
      emDownloadFiles   : EM:= fErrorMessage+' downloading the updates!';
      emDelete          : EM:= fErrorMessage+' trying to delete the file !';
      emFileNotExist    : EM:= fErrorMessage+' trying to locate the source folder!';
      emExit            : EM:= fAbortMessage;
      emError           : EM:='Updates checking was canceled (An error was found).';
      emMatch           : EM:= 'Security Allert!! '
                         + LineBrk+ fErrorMessage+'trying to match the application '
                         + 'details with the remote web site details!';
  end;
  if parameter = '' then st := EM
  else st := EM + LineBrk + Parameter;
  UpdateTextControls(st);
  if Assigned(FOnError) then FOnError(Self, pErrCode, Parameter, EM);
  If fShowMessages then MessageDlg(st, mtError, [mbAbort], 0);
  If fErrorReport then  SendErrorReport();
end;

procedure TWebUpdater.SuccessMessagesHandler(pSuccessCode: TSuccessMessage; Parameter: string);
var
  SM   : string;
  Name : string;
begin
 Name := ExtractFileName(Application.ExeName);
 case pSuccessCode of
      smDone            : SM :=  fSuccessMessageText;
      smUpdateNeeded    : SM :=  'A new update is available for: '+ Name;
      smUpdateNotNeeded : SM :=  'Your application is up to date.';
      smChecking        : SM :=  'Checking for the latest release';
  end;
  UpdateTextControls(SM);
  If fShowMessages then MessageDlg(SM, mtInformation, [mbOK], 0);
  if Assigned(FOnSuccess) then fOnSuccess(Self, pSuccessCode, Parameter, SM);
end;
///////////---End Of Messages Part --------///////////

///////////---Component Part --------///////////
constructor TWebUpdater.Create(AOwner: TComponent);
begin
	inherited Create(AOwner);
  fCursor               := crAppStart;
  fAbortMessage         := 'Aborted! (User request).';
 	fAbout                := 'Application Updater by bsalsa : bsalsa@bsalsa.no-ip.info';
  Busy                  := false;
  fAppCurrentVer        := 0.001;
  fAppNewVer            := 0.001;
  fBackupFolder         := 'Backup\';	
  fLogDateStamp         := True;
  fWebURL               := 'http://';
  fEnabled              := true;
 // fFilesToUpdate        := TStringList.Create;
//  fFilesToUpdate.Duplicates := dupIgnore;
 {$IFDEF DELPHI_6_UP}
//  fFilesToUpdate.CaseSensitive := False;
 {$ENDIF}
  fLogData              := TstringList.Create;
  fUpdateText           := TstringList.Create;
  fDeleteUpdates        := true;
  fDeleteWebInfo        := true;
  fDeleteLog            := true;
  fDeleteBatch          := true;
  fErrorMessage         := 'An error ocurred while ';
  fErrorReport          := true;
  fMatchDetails         := true;
  fQuitOnError          := true;
  fSaveBackup           := true;
  fShowMessages         := true;
  fShowChanges          := true;
  fShowPersonalDetails  := true;
  fShowUpdateFiles      := false;
  fSuccessMessageText   := 'Update is done.';
  fUpdateInfoText       := TStringList.Create;
  fUpdateInfoText.Duplicates := dupIgnore;
  fUpdatesFolder        := 'Updates\';
  fOpenAppFolder        := false;

  XmlParser             := TXMLParser.Create;
  fLogFileName          := 'Updater.txt';
  fWebInfoFileName      := 'Updates.xml';
  fCaption              := 'Checking for updates... Please wait.';
  fUpdateFormat         := ufNumbers;
  Quit                  := false;

  UpdateRec.NoRestartList      := TStringList.Create;
  UpdateRec.NoRestartList.Duplicates := dupIgnore;
  UpdateRec.WithRestartList   := TStringList.Create;
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
//  fFilesToUpdate.Free;
  fUpdateInfoText.Free;
  fUpdateText.Free;
  XmlParser.Free;
//  MS.Free;
  fLogData.Free;
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
  fUpdateInfoText.Assign(Value);
end;

procedure Register;
begin
   RegisterComponents('Embedded Web Browser', [TWebUpdater]);
end;
///////////---End Of Component Part --------///////////

///////////////// private Updates procedures //////////////

procedure TWebUpdater.UpdateInfo();
begin
 If Quit then
   begin
     ExitUser();
     Exit;
   end;
 fUpdateInfoText.Add('A new update is avaliable for '+ fApplicationName +'!'+ LineBrk);
 If fShowPersonalDetails then
     begin
       If Trim(fAuthor)  <> '' then
       fUpdateInfoText.Add('The update is avaliable by: ' + LineBrk+
                            LineBrk + 'Author:  ' + Trim(fAuthor));
       if Trim(fCompany) <> '' then
       fUpdateInfoText.Add('Company:  ' + Trim(fCompany));
       if Trim(fEMail)   <> '' then
       fUpdateInfoText.Add('Email:  ' + Trim(fEMail));
     end;
    If fShowChanges then
      begin
        if fUpdateText.Text <> '' then
           fUpdateInfoText.Add(LineBrk + 'Update Changes: ' + fUpdateText.Text);
      end;
    If fShowUpdateFiles then
       begin
          fUpdateInfoText.Add(LineBrk + 'The files that will be updated are: ' + LineBrk
          + LineBrk + UpdateRec.NoRestartList.Text + UpdateRec.WithRestartList.Text)
       end;
   fUpdateInfoText.Add(LineBrk+ 'Press "OK" to update '+ fApplicationName+
                       ' or press "Abort".');
end;

procedure TWebUpdater.UpdateProgressControls(ProgMax, Pos: integer);
begin
  if Assigned(fProgressBar) then
  begin
    fProgressBar.Max := ProgMax;
    fProgressBar.Position := Pos;
  end;
  If Assigned(FOnProgress) then
     FOnProgress(ProgMax, Pos);
end;

procedure TWebUpdater.UpdateTextControls(txt: string);
begin
  AddLog(txt);
  if Assigned(fOnChangeText) then
     fOnChangeText(Self,  txt);
  if Assigned(fStatusbar) then
     fStatusbar.SimpleText := txt;
end;

procedure TWebUpdater.UpdateAppControls();
begin
  AddLog('Updating Application Controls');
  OldCaption := Forms.Application.MainForm.Caption;
  Forms.Application.MainForm.Caption := fCaption;
  OldCursor :=  Screen.Cursor;
  Screen.Cursor := fCursor;
end;

procedure TWebUpdater.RestoreAppControls();
begin
  Screen.Cursor := OldCursor;
  Forms.Application.MainForm.Caption := OldCaption;
end;

///////////////// End of private Updates procedures  //////////////


///////////////// private procedures //////////////

function TWebUpdater.AddFiles(FileName: string): Integer;
begin
  Result := -1;
  If Quit then
   begin
     ExitUser();
     Exit;
   end;
 { fFilesToUpdate.Duplicates  := dupIgnore;
  if Trim(FileName) <> ''
  then Result := fFilesToUpdate.Add(FileName);  }
end;

function TWebUpdater.CheckVersionNum(): boolean;
var
 iNew, ICur : integer;
 Info : string;
begin
  Result := false;
  If Quit then
   begin
     ExitUser();
     Exit;
   end;
  if (fAppCurrentVer < 0) or (fAppCurrentVer > 100000) then
    begin
        AddLog('Error was found in the current version definition');
        ErrMessagesHandler(emCurrentVersion, ' Definition');
    end;
  if (fAppNewVer < 0)  or  (fAppNewVer > 100000) then
    begin
        AddLog('Error was found in the new version definition');
        ErrMessagesHandler(emUpdateVersion, ' Definition');
    end;
   iNew := StrToInt(FloatToStr(fAppNewVer * 1000));
   iCur := StrToInt(FloatToStr(fAppCurrentVer * 1000));
   if (iNew > iCur) then
      begin
        AddLog('A new update is avaliable . ' + info);
        UpdateTextControls('A new update is avaliable ');
        Result := true;
      end
    else
      begin
        UpdateTextControls('Your application is up to date.');
      end;
end;

function TWebUpdater.Check_CreateFolder(FolderName : string): boolean;
begin
 Result := false;
 If Quit then
   begin
     ExitUser();
     Exit;
   end;
    {$IFDEF DELPHI_6_UP}
    if not(DirectoryExists(FolderName)) then
    {$ENDIF}
    begin
      if not(CreateDir(FolderName)) then
      begin
        AddLog('Error Creating '+ FolderName + ' folder!');
        ErrMessagesHandler(emCreateFolder, FolderName);
        Result := true;
     end
     else
       AddLog('Creating '+ FolderName + ' folder.');
   end
   {$IFDEF DELPHI_6_UP}
   else
   AddLog('Checking if folder '+ FolderName + ' exist. --> OK.');
    {$ENDIF}
end;

function TWebUpdater.CopyFiles(Source, Destination, FileName: string): boolean;
begin
  Result := false;
  If Quit then
   begin
     ExitUser();
     Exit;
   end;
  UpdateProgressControls(100, 40);
  Source      := (ApplicationFolder + Source);
  Destination := (ApplicationFolder + Destination);
  Check_CreateFolder(Destination);
  if FileExists(Source + FileName) then
   begin
     if not (CopyFile(PAnsiChar(Source + FileName),
            PAnsiChar(Destination + FileName),false)) then
      begin
        AddLog('Error copy file name: '+Source + FileName +
        '  ---> to: '+ Destination + FileName);
        ErrMessagesHandler(emFileCopyError, FileName);
        Result := true;
      end
      else
      AddLog('The file '+ Source + FileName +
      LineBrk + ' --> was copy to: '+ Destination + FileName);
   end
   else
   begin
    ErrMessagesHandler(emFileNotExist, FileName);
    AddLog('File not exist: '+Source + FileName+' !');
   end;
end;

function TWebUpdater.CreateSubBackupFolder: boolean;
begin
 Result := false;
 If Quit then
   begin
     ExitUser();
     Exit;
   end;
     fBackupFolder:= fBackupFolder+FormatDateTime('yyyy_MM_dd_HH_mm_ss',Now)+'\';
  if fSaveBackup then
    if not CreateDir(fBackupFolder) then
    begin
      ErrMessagesHandler(emCreateSubBackup, fBackupFolder);
      AddLog('Error Creating '+ fBackupFolder + ' folder.');
      Result := true;
    end
    else
      AddLog('Creating '+ fBackupFolder + ' folder. --> OK.');
end;

function TWebUpdater.GetXmlHead(): boolean;
begin
  Result:=false;
  If Quit then
   begin
     ExitUser();
     Exit;
   end;
  while XmlParser.Scan() do
    begin
      if XmlParser.CurPartType=ptXmlProlog then
      begin
        AddLog('Parsing XML Head section');
        Result:= true;
        exit;
      end
      else
      begin
        AddLog('Error parsing XML Head section');
        ErrMessagesHandler(emXMLError, '(  XML Head)');
      end;
    end;
end;

function TWebUpdater.GetXmlTag(const TagName:string): boolean;
begin
  Result:=false;
  If Quit then
   begin
     ExitUser();
     Exit;
   end;
  while XmlParser.Scan() do
    begin
      if  ((XmlParser.CurPartType = ptStartTag)
      or  (XmlParser.CurPartType = ptEmptyTag))
      and (XmlParser.CurName = TagName) then
        begin
          AddLog('Parsing XML tag: '+ TagName);
          Result:= true;
          Exit;
        end;
    end;
end;

function TWebUpdater.GetXmlData(): boolean;
begin
  Result:=false;
  If Quit then
   begin
     ExitUser();
     Exit;
   end;
  while XmlParser.Scan() do
    begin
      if ((XmlParser.CurPartType=ptContent) or (XmlParser.CurPartType=ptCData)) then
       begin
         AddLog('Parsing XML data');
         Result:= true;
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
st : string;
begin
 Result := false;
 If Quit then
   begin
     ExitUser();
     Exit;
   end;
  Dcb:= TDownloadCallback.Create;
  Dcb.ProgressMax := 100;
  try
   st := 'Application Folder\'+ DestFile;
   AddLog('Trying to download: ' + SourceFile + '  To: '+ st);
   if UrlDownloadToFile(nil, PChar(SourceFile), PChar(DestFile), 0, dcb) = 0 then
   begin
   UpdateProgressControls(100, Dcb.Position);
   Result := True;
   AddLog(OnProgressStatusList.Text+ LineBrk+ 'Downloading '+ SourceFile +
           ' To: '+ st +' was successful.')
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
 Result := false;
 If Quit then
   begin
     ExitUser();
     Exit;
   end;
   If not fileExists(FileName) then
   FileName := (GetCurrentDir+ '\' + TrimLeft(FileName));
   begin
     FileName :=  TrimLeft (FileName);
     if DeleteFile(PChar(FileName)) then
      begin
        If FileName <> fLogFileName then
        begin
          AddLog('File Delete: ' + FileName);
          Result :=  true;
        end;
      end;
    end;
end;

function TWebUpdater.DeleteFolder(FolderName: string): Boolean;
var
  st : string;
  i : integer;
begin
 Result := false;
 If Quit then
   begin
     ExitUser();
     Exit;
   end;
   st := GetCurrentDir + '\' + FolderName;
   if FolderName = fUpdatesFolder then
   try
     for i := 0 to UpdateRec.NoRestartList.Count-1 do
       begin
        DeleteFiles(st+ TrimLeft(UpdateRec.NoRestartList[i]));
        Addlog('File Delete: ' + st+ TrimLeft(UpdateRec.NoRestartList[i]));
       end;
     for i := 0 to UpdateRec.WithRestartList.Count-1 do
       begin
        DeleteFiles(st+ TrimLeft(UpdateRec.WithRestartList[i]));
        Addlog('File Delete: ' + st+ TrimLeft(UpdateRec.WithRestartList[i]));
       end;
   except
   end;
    i := Length(st) - 1;
    SetLength(st, i);
    if RemoveDir(st) then
    begin
      Addlog('Folder Delete: ' + st);
      Result :=  true;
   end;
end;

function TWebUpdater.OpenFolder(FolderName: string): Boolean;
begin
 Result := false;
 If Quit then
   begin
     ExitUser();
     Exit;
   end;
   ShellExecute(Forms.Application.Handle, 'explore', Pchar(FolderName), Nil,
                Nil, SW_SHOWNORMAL);
   Addlog('Open Folder : ' + FolderName);
   Result :=  true;
end;

procedure TWebUpdater.ProcessFolderNames();
begin
  If Quit then
    begin
       ExitUser();
       Exit;
     end;
     AddLog('Start processing files names. ');
     UpdateProgressControls(100, 20);
     {$IFDEF DELPHI_6_UP}
     {$WARN SYMBOL_PLATFORM OFF}
     {$ENDIF}
     XmlFile := Pchar(FWebURL + '/' + (fWebInfoFileName));
     fBatFileName := ChangeFileExt(Application.ExeName, '.bat');
     fExeName := ExtractFileName(Application.ExeName);
     fUpdatesFolder := IncludeTrailingBackslash(fUpdatesFolder);
     ApplicationFolder := IncludeTrailingBackslash(UpperCase(ExtractFilePath(Application.ExeName)));
     if Trim(fBackupFolder) = ''
     then fBackupFolder := ApplicationFolder + fBackupFolder
     else fBackupFolder := IncludeTrailingBackslash(fBackupFolder);
     AddLog('Finished processing files names.');
    {$IFDEF DELPHI_6_UP}
    {$WARN SYMBOL_PLATFORM ON}
    {$ENDIF}
end;

procedure TWebUpdater.InitialUpdating();
begin
  ClearLog();
  WriteLog();
  AddLog('Initialing the updater.');
  NeedTerminate := false;
  fUpdateText.Clear();
  UpdateAppControls();
  UpdateProgressControls(100, 10);
  UpdateTextControls('Checking for Updates...');
  ProcessFolderNames();
end;

function TWebUpdater.ParseXML(): boolean;
var
    Node        : TNvpNode;
    i           : integer;
    UpdRec      : PUpRec;
    MS          : TMemoryStream;
    Zero        : Char;
    Container   : string;
begin
  Result := false;
  If Quit then
    begin
       ExitUser();
       Exit;
     end;
  AddLog('Start downloading xml remote file.');
  if DownloadFile(XmlFile, fWebInfoFileName) then
  begin
   if not FileExists(ExtractFilePath(ParamStr(0)) + fWebInfoFileName) then
      begin
        ErrMessagesHandler(emFileNotExist, fWebInfoFileName);
        ExitError(fErrorMessage + 'trying to locate the web info file.');
        Exit;
      end
      else
      begin
        Zero := #0;
        MS   := TMemoryStream.Create;
        MS.Write(Zero,1);
        MS.LoadFromFile(fWebInfoFileName);
        XmlParser.SetBuffer(MS.Memory);
        XmlParser.Normalize := false;
        XmlParser.StartScan();
        if not GetXmlHead() then if fQuitOnError then
          begin
             ExitError('An error was found in the update XML file (Head Section)');
             Exit;
          end;
        if not GetXmlTag('Updates') then if fQuitOnError then
          begin
             ExitError('An error was found in the update XML file (Updates Section)');
             Exit;
          end;
         if not GetXmlTag('Details') then if fQuitOnError then
          begin
             ExitError('An error was found in the update XML file (Details)');
             Exit;
          end;
        if not GetXmlTag('ApplicationName') then if fQuitOnError then
          begin
             ExitError('An error was found in the update XML file (Application Name)');
             Exit;
          end;
        if not GetXmlData() then if fQuitOnError then
          begin
             ExitError('An error was found in the update XML file (Application Name)');
             Exit;
          end;
        If MatchDetails then if Not PerformMatchDetails(Trim(fApplicationName),
                                    Trim(XmlParser.CurContent))then
         begin
             ExitMatch();
             Exit;
         end;
        fApplicationName := XmlParser.CurContent;
        if not GetXmlTag('Author') then if fQuitOnError then
          begin
             ExitError('An error was found in the update XML file (Author)');
             Exit;
          end;
        if not GetXmlData() then if fQuitOnError then
          begin
             ExitError('An error was found in the update XML file (Author)');
             Exit;
          end;
        If MatchDetails then if Not PerformMatchDetails(Trim(fAuthor),
                                    Trim(XmlParser.CurContent))then
         begin
             ExitMatch();
             Exit;
         end;
        fAuthor := XmlParser.CurContent;
        if not GetXmlTag('Company') then if fQuitOnError then
           begin
              ExitError('An error was found in the update XML file (Company)');
              Exit;
           end;
        if not GetXmlData() then if fQuitOnError then
           begin
              ExitError('An error was found in the update XML file (Company)');
              Exit;
           end;
        If MatchDetails then if Not PerformMatchDetails(Trim(fCompany),
                                    Trim(XmlParser.CurContent))then
         begin
             ExitMatch();
             Exit;
         end;
        fCompany := XmlParser.CurContent;
        if not GetXmlTag('Version') then if fQuitOnError then
          begin
             ExitError('An error was found in the update XML file (Version)');
             Exit;
          end;
        if not GetXmlData() then if fQuitOnError then
          begin
             ExitError('An error was found in the update XML file (Version)');
             Exit;
          end;
        fAppNewVer := StrToFloat(XmlParser.CurContent);
        AddLog('Application current version is: '+ FloatToStr(AppCurrentVer) +
                LineBrk + '  Update version is: '+ XmlParser.CurContent);

        if not GetXmlTag('ChangeLog') then if fQuitOnError then
          begin
             ExitError('An error was found in the update XML file (ChangeLog section)');
             Exit;
          end; 
      fUpdateText.Add(LineBrk);
      while GetXmlTag('Info') do
        begin
          for i := 0 to XmlParser.CurAttr.Count-1 do
            begin
              Node := TNvpNode(XmlParser.CurAttr[i]);
              if Node.Name = 'Text' then
                  fUpdateText.Add(TrimLeft(Node.Value));
            end;
        end;
        XmlParser.StartScan;
        if not GetXmlTag('Instructions') then if fQuitOnError then
          begin
             ExitError('An error was found in the update XML file (Instructions section)');
             Exit;
          end;
      while GetXmlTag('File') do
       begin
           New(UpdRec);
           UpdRec.dlFileName    := '';
           UpdRec.dlDestination := '';
           UpdRec.dlTerminate   := false;
           for i := 0 to XmlParser.CurAttr.Count-1 do
              begin
                Node      := TNvpNode(XmlParser.CurAttr[i]);
                Container := Trim(Node.Name);
                if Container = 'Name' then
                   UpdRec.dlFileName := Trim(Node.Value)
                else if (Container = 'Destination') then
                  begin
                     UpdRec.dlDestination := Trim(Node.Value)+ '\';
                     if UpdRec.dlDestination = 'ApplicationFolder\' then
                        UpdRec.dlDestination := '';
                  end
                else if (Container = 'Terminate') then
                  begin
                    If Trim(Node.Value) = 'yes' then
                       begin
                         UpdRec.dlTerminate := true;
                         UpdateRec.WithRestartList.AddObject(UpdRec.dlFileName,Pointer(UpdRec));
                         AddLog('Adding files which require restart into the update list: '+ UpdRec.dlFileName);
                         Result := true;
                       end
                    else If Trim(Node.Value) = 'no' then
                       begin
                         UpdRec.dlTerminate := false;
                         UpdateRec.NoRestartList.AddObject(UpdRec.dlFileName,Pointer(UpdRec));
                         AddLog('Adding files into the update list: '+ UpdRec.dlFileName);
                         Result := true;
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
  slBatchFile : TStringList;
  Destination, FileName : string;
  i  : integer;
  UpdRecRestart : PUpRec;
begin
   Result := false;
    If Quit then
       begin
         ExitUser();
         Exit;
       end;
    AddLog('Creating a batch file: '+ fBatFileName);
    slBatchFile := TStringList.Create;
    slBatchFile.Add('@Echo On');
    slBatchFile.Add(':again');
    for i := 0 to UpdateRec.WithRestartList.Count-1 do
       begin
           UpdRecRestart := PUpRec(UpdateRec.WithRestartList.Objects[i]);
           FileName := Trim(UpdRecRestart.dlFileName);
           Destination := Trim(UpdRecRestart.dlDestination);
           if Destination <> '' then
           slBatchFile.Add('if not exist "' + Destination+ '" MD " '+ Destination + '"');
           slBatchFile.Add('del "' + Destination + FileName + '"');
           slBatchFile.Add('if exist "' + Destination + FileName +'" goto again');
           slBatchFile.Add('copy "' + fUpdatesFolder + FileName +'" "' + Destination + FileName + '"');
           slBatchFile.Add('if not exist "' + Destination + FileName + '" ' +' copy "' + fBackupFolder + '" "' + Destination + FileName + '"');
       end;
      slBatchFile.Add('call "' + Application.ExeName + '"');
      if fDeleteUpdates then slBatchFile.Add('RMDIR /S /Q "' + fUpdatesFolder + '"');
      if fDeleteBatch then slBatchFile.Add('del "' + fBatFileName + '"');
      slBatchFile.SaveToFile(fBatFileName);
      AddLog('Batch File Commands: ' + LineBrk + LineBrk + slBatchFile.Text);
      slBatchFile.Free;
      Result := true;
end;

function TWebUpdater.PerformMatchDetails(aString, bString: string): boolean;
begin
 AddLog('Matching details: '+ aString + ' to: ' + bString);
 if aString = bString then
  begin
     AddLog('Result: MATCH.');
     Result := true;
  end
 else
  begin
     AddLog('Result: No match was found!');
     Result := false;
  end;
end;

procedure TWebUpdater.RestartApplication();
var
  ProcessInfo : TProcessInformation;
  StartupInfo : TStartupInfo;
  Res: DWORD;
begin
 If Quit then
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
   fUpdateInfoText.Clear();
   CleanUp();
   Busy := false;
end;

procedure TWebUpdater.ExitOK();
begin
   SuccessMessagesHandler(smDone);
   if fOpenAppFolder then OpenFolder(ApplicationFolder);
   FinishHandler();
end;

procedure TWebUpdater.ExitError(ErrString : string);
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
   UpdateTextControls('There are no new avaliable updates. ');
   FinishHandler();
end;

///////////////// End of private procedures//////////////

///////////////// public procedures//////////////

function TWebUpdater.CheckBusyState(): boolean;
begin
 Result := false;
 If Quit then
   begin
     ExitUser();
     Exit;
   end;
 if Busy then
     begin
       ErrMessagesHandler(emBusy);
       Result := true;
     end
     else
     AddLog('Updater is running... ');
end;

procedure TWebUpdater.CleanUp();
begin
  Addlog('Cleaning unnecessary files. ');
  if fDeleteWebInfo then DeleteFiles(Trim(fWebInfoFileName));
  if (fDeleteUpdates and not NeedTerminate) then DeleteFolder(Trim(fUpdatesFolder));
  if fDeleteLog then DeleteFiles(Trim(fLogFileName));
end;

function TWebUpdater.DownloadWebUpdates(): boolean;
var
 i    : integer;
 DLfilename, dest : string;
 UpdRec, UpdRecRestart : PUpRec;
begin
  Result := false;
  If Quit then
   begin
     ExitUser();
     Exit;
   end;
  if UpdateRec.NoRestartList.Count > 0 then
    begin
    for i:= 0 to UpdateRec.NoRestartList.Count-1 do
      begin
        UpdRec := PUpRec(UpdateRec.NoRestartList.Objects[i]);
        if (Trim(UpdRec.dlFileName) <> '') then
        begin
          if not FileExists(fUpdatesFolder + Trim(UpdateRec.NoRestartList[i])) then
            begin
              DLfilename :=  FWebURL + '/' + (Pchar(Trim(UpdateRec.NoRestartList[i])));
              Dest := FUpdatesFolder + Trim(UpdateRec.NoRestartList[i]);
              DownloadFile(DLfilename, Dest);
           end
          else
            begin
              if Dest = '' then Dest:= FUpdatesFolder + ' Folder.';
               AddLog('File name: ' + Trim(UpdateRec.NoRestartList[i]) +
                     ' Already exist in '+ Dest + ' (OverWriting.)');
            end;
     end;
   end;
 end;
 if UpdateRec.WithRestartList.Count > 0 then
 begin
   for i:= 0 to UpdateRec.WithRestartList.Count-1 do
      begin
        UpdRecRestart := PUpRec(UpdateRec.WithRestartList.Objects[i]);
        if (Trim(UpdRecRestart.dlFileName) <> '') then
        begin
          if not FileExists(fUpdatesFolder + Trim(UpdateRec.WithRestartList[i])) then
            begin
              DLfilename :=  FWebURL + '/' + (Pchar(Trim(UpdateRec.WithRestartList[i])));
              Dest := FUpdatesFolder + Trim(UpdateRec.WithRestartList[i]);
              DownloadFile(DLfilename, Dest);
           end
          else
            begin
              if Dest = '' then Dest:= FUpdatesFolder + ' Folder.';
               AddLog('File name: ' + Trim(UpdateRec.WithRestartList[i]) +
                     ' Already exist in '+ Dest + ' (OverWriting.)');
            end;
       end;
     end;
  end;
end;

function TWebUpdater.Start(): boolean;
var
    i      : integer;
    SM, st : string;
    UpdRec, UpdRecRestart : PUpRec;
begin
  Result := False;
  if Not Enabled then Exit;
  CheckBusyState();
  Busy := true;
  InitialUpdating();
  if not ParseXML() then ExitError(fErrorMessage + 'parsing the xml file')
  else
  begin
   if fUpdateFormat = ufNumbers then
      if Not CheckVersionNum then
          begin
             ExitNoUpdateFound();
             Exit;
          end;

   UpdateInfo();
   AddLog('XML Information: ' + LineBrk + fUpdateInfoText.Text);
   if fShowMessages then
       begin
          SM := fUpdateInfoText.Text;
          if MessageDlg(SM, mtCustom, [mbOK ,mbAbort], 0) <> 1 then
             begin
               ExitUser();
               Exit;
             end;
       end;

    if Check_CreateFolder(fUpdatesFolder) then if fQuitOnError then
         begin
            ExitError(fErrorMessage + 'creating updates folder');
            Exit;
         end;
    if Check_CreateFolder(fBackupFolder) then if fQuitOnError then
         begin
            ExitError(fErrorMessage + 'creating backup folder');
            Exit;
         end;
    if CreateSubBackupFolder()then if fQuitOnError then
         begin
            ExitError(fErrorMessage + 'creating sub backup folder');
            Exit;
         end;

    DownloadWebUpdates();
   end;

   if UpdateRec.NoRestartList.Count > 0 then
    begin
    for i:=0 to UpdateRec.NoRestartList.Count-1 do
      begin
        UpdRec := PUpRec(UpdateRec.NoRestartList.Objects[i]);
        if  ((Trim(UpdRec.dlFileName) <> '') and (UpdRec.dlTerminate = false))then
          begin
           if fSaveBackup then
             begin
             if FileExists(UpdRec.dlDestination + UpdRec.dlFileName)then
                CopyFiles(UpdRec.dlDestination, fBackUpFolder,
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
       NeedTerminate := true;
       st := 'Some of the updates require restart. ' + LineBrk +
             'Press "Yes" to restart now, or press "Abort" to run the '+
             'updates checking later.';
       UpdateTextControls(st);
      if MessageDlg(st, mtCustom, [mbYes, mbAbort], 0) = 6 then
      begin
        for i := 0 to UpdateRec.WithRestartList.Count-1 do
         begin
            UpdRecRestart := PUpRec(UpdateRec.WithRestartList.Objects[i]);
            if ((Trim(UpdRecRestart.dlFileName) <> '') and
               (UpdRecRestart.dlTerminate = true)) then
               begin
                 if fSaveBackup then
                   begin
                   if FileExists(UpdRecRestart.dlDestination +
                                 UpdRecRestart.dlFileName)then
                      CopyFiles(UpdRecRestart.dlDestination, fBackUpFolder,
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
  if ((UpdateRec.NoRestartList.Count > 0) and Not (NeedTerminate)) then ExitOK();
  Busy := false;
  Result := Not Busy;
 end;

procedure TWebUpdater.SendErrorReport();
var
  emMail, emSubject : String;
  emBody : TStringList;
begin
 If FileExists(GetFullLogFileName) then
 begin
   embody := TStringList.Create;
   EmBody.Clear;
 try
   emBody.LoadFromFile(GetFullLogFileName);
   emSubject := 'Updater Error Report';
   emMail := 'mailto:'+fEmail+'?subject=' + emSubject + '&body=' + emBody.Text;
   AddLog('Mailing Error Report.... Hold On.');
   ShellExecute(Forms.Application.Handle,'open',  PChar(emMail), nil, nil, SW_SHOWNORMAL);
 finally
  emBody.Free;
 end;
 end;
end;

procedure TWebUpdater.Stop();
begin
  if Busy then
  begin
    Quit := true;
    UpdateTextControls('Stopped (User Request).');
  end;
end;

///////////////// End of public procedures//////////////

end.
