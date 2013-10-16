program ZoneDemo;

uses
  Forms,
  _ZoneDemo in '_ZoneDemo.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
