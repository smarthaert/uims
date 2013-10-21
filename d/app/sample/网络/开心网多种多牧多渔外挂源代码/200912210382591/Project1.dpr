program Project1;

uses
  Forms,
  Windows,
  Unit1 in 'Unit1.pas' {Form1},
  dhtmlevent in 'dhtmlevent.pas';

{$R *.res}

begin
  Application.Initialize;
  SetThreadLocale(2052);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

