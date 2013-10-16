program WeatherSrv;

uses
  SvcMgr,
  Unit_Main in 'Unit_Main.pas' {ServiceWeather: TService};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TServiceWeather, ServiceWeather);
  Application.Run;
end.
