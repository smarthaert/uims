program ResumeDemo;

uses
  Forms,
  Resumedemo_U in 'Resumedemo_U.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
