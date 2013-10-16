program HeroBrowser;

uses
  Forms,
  U_FrmMain in 'U_FrmMain.pas' {FrmMain},
  U_MutiPageWebBrowser in 'U_MutiPageWebBrowser.pas',
  U_WebForm in 'U_WebForm.pas' {FrmWeb},
  U_WebToolBar in 'U_WebToolBar.pas',
  U_PublicUnit in 'U_PublicUnit.pas',
  U_PublicInterface in 'U_PublicInterface.pas',
  U_SideBar in 'U_SideBar.pas' {FrmSideBar},
  Unicode in 'Components\UnicodeLib\Unicode.pas',
  U_UserConfig in 'U_UserConfig.pas',
  U_FrmAbout in 'U_FrmAbout.pas' {AboutBox},
  U_UndoList in 'U_UndoList.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
