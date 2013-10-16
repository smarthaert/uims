program GATEWAY;

uses
  Forms,
  main in 'main.pas' {MainForm},
  SPPO10 in 'SPPO10.pas',
  Global in 'Global.pas',
  Cmpp20 in 'Cmpp20.pas',
  SGIP12 in 'SGIP12.pas',
  Buffer in 'Buffer.pas',
  SMGP13 in 'SMGP13.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

