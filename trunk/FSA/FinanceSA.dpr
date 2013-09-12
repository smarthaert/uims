program FinanceSA;

uses
  Forms,
  fMain2 in 'UNIT\fMain2.pas' {frmMain2},
  fUtils in 'UNIT\fUtils.pas',
  fDef in 'UNIT\fDef.pas',
  MyGraph in 'UNIT\MyGraph.pas',
  ff_hs_base in 'UNIT\ff_hs_base.pas',
  s_lib_pas_unit in 'UNIT\s_lib_pas_unit.pas',
  uFutuDataTypes in 'UNIT\uFutuDataTypes.pas',
  uFutuMessageInterface in 'UNIT\uFutuMessageInterface.pas',
  uFutuSdkInterface in 'UNIT\uFutuSdkInterface.pas',
  do_beep_thread in 'UNIT\do_beep_thread.pas',
  ff_ib_dm in 'UNIT\ff_ib_dm.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain2, frmMain2);
  Application.Run;
end.

