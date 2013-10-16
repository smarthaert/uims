program WifiScanner;

uses
  Forms,
  uWifiScanner in 'uWifiScanner.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
