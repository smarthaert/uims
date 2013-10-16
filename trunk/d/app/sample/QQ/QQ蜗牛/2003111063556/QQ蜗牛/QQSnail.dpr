program QQSnail;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uUtility in 'uUtility.pas',
  uDM in 'uDM.pas' {DM: TDataModule},
  uAbort in 'uAbort.pas' {AboutBox},
  uHelp in 'uHelp.pas' {frmHelp},
  uOptions in 'uOptions.pas' {FrmOptions},
  uSeekPort in 'uSeekPort.pas' {frmSeekPort},
  uUDPPort in 'uUDPPort.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
