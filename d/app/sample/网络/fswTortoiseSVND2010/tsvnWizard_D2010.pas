unit tsvnWizard_D2010;
{* |<PRE>
================================================================================
* 汉化作者：BainWong
* 备    注：
* 汉化记录：2009.10.27 V1.0
*               汉化TortoiseSVN集成菜单文字、对话框提示文字。

* 修改    ：2010.01.21 by FishSeeWater
================================================================================
|</PRE>}

{$R 'icons.res'}

interface

uses ToolsAPI, SysUtils, Windows, Dialogs, Menus, Registry, ShellApi,
    Classes, Controls, Graphics, ImgList, ExtCtrls, ActnList, Forms;

const
    SVN_PROJECT_EXPLORER = 0;
    SVN_LOG = 1;
    SVN_CHECK_MODIFICATIONS = 2;
    SVN_ADD = 3;
    SVN_UPDATE = 4;
    SVN_COMMIT = 5;
    SVN_DIFF = 6;
    SVN_REVERT = 7;
    SVN_REPOSITORY_BROWSER = 8;
    SVN_SETTINGS = 9;
    SVN_ABOUT = 10;
    SVN_VERB_COUNT = 11;

type TTortoiseSVN = class(TNotifierObject, IOTANotifier, IOTAWizard)
private
    timer: TTimer;
    tsvnMenu: TMenuItem;
    TSVNPath: string;
    procedure Tick( sender: TObject );
    procedure TSVNMenuClick( sender: TObject );
    procedure DiffClick( sender: TObject );
    procedure TSVNExec( params: string );
    function GetBitmapName(Index: Integer): string;
    function GetVerb(Index: Integer): string;
    function GetVerbState(Index: Integer): Word;
    procedure ExecuteVerb(Index: Integer);
    procedure CreateMenu;
    procedure UpdateAction( sender: TObject );
    procedure ExecuteAction( sender: TObject );
public
    constructor Create;
    destructor Destroy; override;
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
    procedure Execute;
end;


{$IFNDEF DLL_MODE}

procedure Register;

{$ELSE}

function InitWizard(const BorlandIDEServices: IBorlandIDEServices;
  RegisterProc: TWizardRegisterProc;
  var Terminate: TWizardTerminateProc): Boolean; stdcall;

{$ENDIF}


implementation

function GetCurrentProject: IOTAProject;
var
  ModServices: IOTAModuleServices;
  Module: IOTAModule;
  Project: IOTAProject;
  ProjectGroup: IOTAProjectGroup;
  i: Integer;
begin
  Result := nil;
  ModServices := BorlandIDEServices as IOTAModuleServices;
  if ModServices <> nil then
      for i := 0 to ModServices.ModuleCount - 1 do
      begin
        Module := ModServices.Modules[i];
        if Supports(Module, IOTAProjectGroup, ProjectGroup) then
        begin
          Result := ProjectGroup.ActiveProject;
          Exit;
        end
        else if Supports(Module, IOTAProject, Project) then
        begin // In the case of unbound packages, return the 1st
          if Result = nil then
            Result := Project;
        end;
      end;
end;

procedure GetCurrentModuleFileList( fileList: TStrings );
var ModServices: IOTAModuleServices;
    Module: IOTAModule;
    i: integer;
begin
    fileList.Clear;
    ModServices := BorlandIDEServices as IOTAModuleServices;
    if ModServices <> nil then begin
        Module:= ModServices.CurrentModule;
        if Module <> nil then
            for i:= 0 to ModServices.CurrentModule.GetModuleFileCount-1 do
                fileList.Add( ModServices.CurrentModule.GetModuleFileEditor(i).GetFileName );
    end;
end;

constructor TTortoiseSVN.Create;
var reg: TRegistry;
begin
    Reg := TRegistry.Create;
    try
        Reg.RootKey := HKEY_LOCAL_MACHINE;
        if Reg.OpenKeyReadOnly( '\SOFTWARE\TortoiseSVN' ) then
            TSVNPath:= Reg.ReadString( 'ProcPath' );
    finally
        Reg.CloseKey;
        Reg.Free;
    end;

    tsvnMenu:= nil;

    timer:= TTimer.create(nil);
    timer.interval:= 200;
    timer.OnTimer:= tick;
    timer.enabled:= true;

end;

procedure TTortoiseSVN.Tick( sender: TObject );
var intf: INTAServices;
begin
    if BorlandIDEServices.QueryInterface( INTAServices, intf ) = s_OK then begin
        self.createMenu;
        timer.free;
        timer:= nil;
    end;
end;

procedure TTortoiseSVN.TSVNMenuClick( sender: TObject );
var files: TStringList;
    i: integer;
    diff, item: TMenuItem;
begin
    // update the diff item and submenu; the diff action is handled by the
    // menu item itself, not by the action list
    diff:= tsvnMenu.Items[SVN_DIFF];
    diff.Action:= nil;
    diff.OnClick:= nil;
    diff.Enabled:= false;
    diff.Clear;
    files:= TStringList.create;
    GetCurrentModuleFileList(files);
    if files.Count > 0 then begin
        diff.Enabled:= true;
        diff.Caption:= 'Diff';
        if files.Count > 1 then begin
            for i:= 0 to files.count-1 do begin
                item:= TMenuItem.Create(diff);
                item.Caption:= ExtractFileName( files[i] );
                item.OnClick:= DiffClick;
                item.Tag:= i;
                diff.Add( item );
            end;
        end else begin  // files.Count = 1
            diff.Caption:= 'Diff ' + ExtractFileName( files[0] );
            diff.OnClick:= DiffClick;
        end;
    end;
    files.free;
end;

procedure TTortoiseSVN.DiffClick( sender: TObject );
var files: TStringList;
    item: TComponent;
begin
    item:= sender as TComponent;
    files:= TStringList.create;
    GetCurrentModuleFileList(files);
    if files.Count > 1 then
        TSVNExec( '/command:diff /notempfile /path:' + AnsiQuotedStr( files[item.Tag], '"' ) )
    else if files.Count = 1 then
        TSVNExec( '/command:diff /notempfile /path:' + AnsiQuotedStr( files[0], '"' ) );
    files.free;
end;

procedure TTortoiseSVN.CreateMenu;
var mainMenu: TMainMenu;
    item: TMenuItem;
    i: integer;
    bmp: TBitmap;
    action: TAction;
begin
    if tsvnMenu <> nil then exit;

    tsvnMenu:= TMenuItem.Create(nil);
    tsvnMenu.Caption:= 'TortoiseSVN';
    tsvnMenu.OnClick:= TSVNMenuClick;


    for i:= 0 to SVN_VERB_COUNT-1 do begin

        bmp:= TBitmap.create;
        try
          bmp.LoadFromResourceName( HInstance, getBitmapName(i) );
        except end;

        action:= TAction.Create(nil);
        action.ActionList:= (BorlandIDEServices as INTAServices).ActionList;
        action.Caption:= getVerb(i);
        action.Hint:= getVerb(i);
        if (bmp.Width = 16) and (bmp.height = 16) then
            action.ImageIndex:= (BorlandIDEServices as INTAServices).AddMasked( bmp, clBlack );
        bmp.free;
        action.OnUpdate:= updateAction;
        action.OnExecute:= executeAction;
        action.Tag:= i;

        item:= TMenuItem.Create( tsvnMenu );
        item.action:= action;

        tsvnMenu.add( item );
    end;

    mainMenu:= (BorlandIDEServices as INTAServices).MainMenu;
    mainMenu.Items.Insert( mainMenu.Items.Count-1, tsvnMenu );
end;

destructor TTortoiseSVN.Destroy;
begin
    if tsvnMenu <> nil then begin
        tsvnMenu.free;
    end;
    inherited;
end;

function TTortoiseSVN.GetBitmapName(Index: Integer): string;
begin
    case index of
        SVN_PROJECT_EXPLORER:
            Result:= 'explorer';
        SVN_LOG:
            Result:= 'log';
        SVN_CHECK_MODIFICATIONS:
            Result:= 'check';
        SVN_ADD:
            Result:= 'add';
        SVN_UPDATE:
            Result:= 'update';
        SVN_COMMIT:
            Result:= 'commit';
        SVN_DIFF:
            Result:= 'diff';
        SVN_REVERT:
            Result:= 'revert';
        SVN_REPOSITORY_BROWSER:
            Result:= 'repository';
        SVN_SETTINGS:
            Result:= 'settings';
        SVN_ABOUT:
            Result:= 'about';
    end;
end;

function TTortoiseSVN.GetVerb(Index: Integer): string;
begin
    case index of
        SVN_PROJECT_EXPLORER:
            Result:= '浏览项目文件夹(&P)...';  // '&Project explorer...';
        SVN_LOG:
            Result:= '日志(&L)...'; // '&Log...';
        SVN_CHECK_MODIFICATIONS:
            Result:= '检查修改(&M)...';  // 'Check &modifications...';
        SVN_ADD:
            Result:= '增加(&A)...'; // '&Add...';
        SVN_UPDATE:
            Result:= '更新至版本(&U)...'; // '&Update to revision...';
        SVN_COMMIT:
            Result:= '提交(&C)...'; // '&Commit...';
        SVN_DIFF:
            Result:= '与前一版本比较(&D)...'; // '&Diff...';
        SVN_REVERT:
            Result:= '还原(&R)...'; // '&Revert...';
        SVN_REPOSITORY_BROWSER:
            Result:= '版本库浏览器(B)...'; // 'Repository &browser...';
        SVN_SETTINGS:
            Result:= '设置(&S)...'; // '&Settings...';
        SVN_ABOUT:
            Result:= '关于(&A)...'; // '&About...';
    end;
end;

const vsEnabled = 1;

function TTortoiseSVN.GetVerbState(Index: Integer): Word;
begin
    Result:= 0;
    case index of
        SVN_PROJECT_EXPLORER:
            if GetCurrentProject <> nil then
                Result:= vsEnabled;
        SVN_LOG:
            if GetCurrentProject <> nil then
                Result:= vsEnabled;
        SVN_CHECK_MODIFICATIONS:
            if GetCurrentProject <> nil then
                Result:= vsEnabled;
        SVN_ADD:
            if GetCurrentProject <> nil then
                Result:= vsEnabled;
        SVN_UPDATE:
            if GetCurrentProject <> nil then
                Result:= vsEnabled;
        SVN_COMMIT:
            if GetCurrentProject <> nil then
                Result:= vsEnabled;
        SVN_DIFF:
            // this verb state is updated by the menu itself
            ;
        SVN_REVERT:
            if GetCurrentProject <> nil then
                Result:= vsEnabled;
        SVN_REPOSITORY_BROWSER:
            Result:= vsEnabled;
        SVN_SETTINGS:
            Result:= vsEnabled;
        SVN_ABOUT:
            Result:= vsEnabled;
    end;
end;

procedure TTortoiseSVN.TSVNExec( params: string );
var cmdLine: AnsiString;
begin
    // cmdLine:= TSVNPath + ' ' + params;
    // WinExec( pansichar(cmdLine), SW_SHOW );
    //* 修改    ：2010.01.21 by FishSeeWater
    ShellExecute(0,'open',PChar(TSVNPath),PChar(params),'',SW_SHOW);
end;

procedure TTortoiseSVN.ExecuteVerb(Index: Integer);
var project: IOTAProject;
begin
    project:= GetCurrentProject();
    case index of
        SVN_PROJECT_EXPLORER:
            if project <> nil then
                ShellExecute( 0, 'open', pchar( ExtractFilePath(project.GetFileName) ), '', '', SW_SHOWNORMAL );
        SVN_LOG:
            if project <> nil then
                TSVNExec( '/command:log /notempfile /path:' + AnsiQuotedStr( ExtractFilePath(project.GetFileName), '"' ) );
        SVN_CHECK_MODIFICATIONS:
            if project <> nil then
                TSVNExec( '/command:repostatus /notempfile /path:' + AnsiQuotedStr( ExtractFilePath(project.GetFileName), '"' ) );
        SVN_ADD:
            if project <> nil then
                TSVNExec( '/command:add /notempfile /path:' + AnsiQuotedStr( ExtractFilePath(project.GetFileName), '"' ) );
        SVN_UPDATE:
            if project <> nil then
                //if MessageDlg( 'All project files will be saved before update. Continue?', mtConfirmation, [mbYes, mbNo], 0 ) = mrYes then begin
                if MessageDlg( '更新之前，所有的项目文件都将被保存，是否继续？', mtConfirmation, [mbYes, mbNo], 0 ) = mrYes then begin
                    (BorlandIDEServices as IOTAModuleServices).saveAll;
                    TSVNExec( '/command:update /rev /notempfile /path:' + AnsiQuotedStr( ExtractFilePath(project.GetFileName), '"' ) );
                end;
        SVN_COMMIT:
            if project <> nil then
                //if MessageDlg( 'All project files will be saved before commit. Continue?', mtConfirmation, [mbYes, mbNo], 0 ) = mrYes then begin
                if MessageDlg( '提交之前，所有的项目文件都将被保存，是否继续？', mtConfirmation, [mbYes, mbNo], 0 ) = mrYes then begin
                    (BorlandIDEServices as IOTAModuleServices).saveAll;
                    TSVNExec( '/command:commit /notempfile /path:' + AnsiQuotedStr( ExtractFilePath(project.GetFileName), '"' ) );
                end;
        SVN_DIFF:
            // this verb is handled by its menu item
            ;
        SVN_REVERT:
            if project <> nil then
                TSVNExec( '/command:revert /notempfile /path:' + AnsiQuotedStr( ExtractFilePath(project.GetFileName), '"' ) );
        SVN_REPOSITORY_BROWSER:
            if project <> nil then
                TSVNExec( '/command:repobrowser /notempfile /path:' + AnsiQuotedStr( ExtractFilePath(project.GetFileName), '"' ) )
            else
                TSVNExec( '/command:repobrowser' );
        SVN_SETTINGS:
            TSVNExec( '/command:settings' );
        SVN_ABOUT:
            TSVNExec( '/command:about' );
    end;
end;

procedure TTortoiseSVN.UpdateAction( sender: TObject );
var action: TAction;
begin
    action:= sender as TAction;
    action.Enabled:= getVerbState( action.tag ) = vsEnabled;
end;

procedure TTortoiseSVN.ExecuteAction( sender: TObject );
var action: TAction;
begin
    action:= sender as TAction;
    executeVerb( action.tag );
end;


function TTortoiseSVN.GetIDString: string;
begin
    result:= 'Subversion.TortoiseSVN';
end;

function TTortoiseSVN.GetName: string;
begin
    result:= 'TortoiseSVN add-in';
end;

function TTortoiseSVN.GetState: TWizardState;
begin
    result:= [wsEnabled];
end;

procedure TTortoiseSVN.Execute;
begin
end;



{$IFNDEF DLL_MODE}

procedure Register;
begin
    RegisterPackageWizard(TTortoiseSVN.create);
end;

{$ELSE}

var wizardID: integer;

procedure FinalizeWizard;
var
  WizardServices: IOTAWizardServices;
begin
    Assert(Assigned(BorlandIDEServices));

    WizardServices := BorlandIDEServices as IOTAWizardServices;
    Assert(Assigned(WizardServices));

    WizardServices.RemoveWizard( wizardID );

end;

function InitWizard(const BorlandIDEServices: IBorlandIDEServices;
  RegisterProc: TWizardRegisterProc;
  var Terminate: TWizardTerminateProc): Boolean; stdcall;
var
  WizardServices: IOTAWizardServices;
begin
    Assert(BorlandIDEServices <> nil);
    Assert(ToolsAPI.BorlandIDEServices = BorlandIDEServices);

    Terminate := FinalizeWizard;

    WizardServices := BorlandIDEServices as IOTAWizardServices;
    Assert(Assigned(WizardServices));

    wizardID:= WizardServices.AddWizard(TTortoiseSVN.Create as IOTAWizard);

    result:= wizardID >= 0;
end;


exports
  InitWizard name WizardEntryPoint;

{$ENDIF}



end.

