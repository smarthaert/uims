program FF_300M;

uses
  Forms,
  fm_main in 'fm_main.pas' {MAINFORM},
  do_beep_thread in 'do_beep_thread.pas',
  ff_hs_base in 'ff_hs_base.pas',
  s_lib_pas_unit in 's_lib_pas_unit.pas',
  uFutuDataTypes in 'uFutuDataTypes.pas',
  uFutuMessageInterface in 'uFutuMessageInterface.pas',
  uFutuSdkInterface in 'uFutuSdkInterface.pas',
  ff_dm in 'ff_dm.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMAINFORM, MAINFORM);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.

