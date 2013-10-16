program Server;

uses
  Forms,
  uServer in 'uServer.pas' {fmServer};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmServer, fmServer);
  Application.Run;
end.
