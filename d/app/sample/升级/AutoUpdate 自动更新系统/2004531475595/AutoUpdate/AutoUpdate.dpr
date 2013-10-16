program AutoUpdate;

uses
  Forms,
  FUpdate in 'FUpdate.pas' {frmAutoUpdate},
  FSeting in 'FSeting.pas' {frmSeting},
  AppInfo in 'AppInfo.PAS',
  Analyse in 'Analyse.PAS',
  Transfer in 'Transfer.pas',
  Update in 'Update.PAS',
  AnalyserCmd in 'AnalyserCmd.PAS',
  uFileAction in 'uFileAction.pas',
  FmxUtils in 'FmxUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmAutoUpdate, frmAutoUpdate);
  Application.CreateForm(TfrmSeting, frmSeting);
  Application.Run;
end.
