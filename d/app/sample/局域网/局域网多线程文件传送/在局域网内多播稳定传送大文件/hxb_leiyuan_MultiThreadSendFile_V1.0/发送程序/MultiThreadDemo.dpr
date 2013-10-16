program MultiThreadDemo;

uses
  ExceptionLog,
  Forms,
  MainForm in 'MainForm.pas' {MainFrm},
  uAbout in 'uAbout.pas' {About};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainFrm, MainFrm);
  Application.Run;
end.
