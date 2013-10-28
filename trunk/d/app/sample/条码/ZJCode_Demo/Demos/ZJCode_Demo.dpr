program Project1;

uses
  Forms,
  Code in 'Code.pas' {Form1},
  BuildCode in 'BuildCode.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
