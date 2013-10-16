program VPN;

uses
  Forms,
  VpnUnit in 'VpnUnit.pas' {VpnForm};

{$R *.res}

begin
  Application.Initialize;
  Application.ShowMainForm:=False; 
  Application.CreateForm(TVpnForm, VpnForm);
  Application.Run;
end.
