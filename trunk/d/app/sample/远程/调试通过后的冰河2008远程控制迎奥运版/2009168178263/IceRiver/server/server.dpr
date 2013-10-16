program server;

uses
  Forms,
  mainserve in 'mainserve.pas' {ServerForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TServerForm, ServerForm);
  Application.ShowMainForm := False;
  Application.Run;
end.
