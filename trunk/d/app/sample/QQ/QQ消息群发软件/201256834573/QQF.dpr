program QQF;

uses
  Forms,
  UnitMainForm in 'UnitMainForm.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
