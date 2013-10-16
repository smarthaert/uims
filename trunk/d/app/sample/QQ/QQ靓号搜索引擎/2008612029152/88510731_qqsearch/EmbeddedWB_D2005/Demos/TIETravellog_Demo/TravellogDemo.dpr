program TravellogDemo;

uses
  Forms,
  TravelLogDemo_U in 'TravelLogDemo_U.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
