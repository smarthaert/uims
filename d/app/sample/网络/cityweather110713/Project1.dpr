program Project1;

uses
  Forms,
  Weather in 'Weather.pas' {frmWeather},
  uLkJSON in 'uLkJSON.pas',
  main in 'main.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

