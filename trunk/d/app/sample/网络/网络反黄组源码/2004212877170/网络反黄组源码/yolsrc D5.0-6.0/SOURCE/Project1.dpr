program Project1;

uses
  Forms,
  windows,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {password},
  Des in 'Des.pas',
  Unit3 in 'Unit3.pas' {about},
  tool in 'tool.pas',
  Unit4 in 'Unit4.pas' {Form4},
  typeunit in 'typeunit.pas';

{$R *.RES}

begin
  Application.Initialize;
 // Application.ShowMainForm := False;
  Application.Title := 'ÍøÂç·´»Æ×éV1.3';
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
