program TestDama2;

uses
  Forms,
  MainFrm in 'MainFrm.pas' {MainForm},
  Dama2 in 'Dama2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
