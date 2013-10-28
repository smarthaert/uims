program Promac;

uses
  Forms,
  UnitMain in 'UnitMain.pas' {Form1},
  SetupApi in 'SetupApi.pas',
  Cfg in 'Cfg.pas',
  Cfgmgr32 in 'Cfgmgr32.pas',
  ChgEthernet in 'ChgEthernet.pas',
  Common in 'Common.pas';

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
