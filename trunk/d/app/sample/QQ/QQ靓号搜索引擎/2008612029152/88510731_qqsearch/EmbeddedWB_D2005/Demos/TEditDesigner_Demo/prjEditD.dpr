program prjEditD;

uses
  Forms,
  utEditDesigner in 'utEditDesigner.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
