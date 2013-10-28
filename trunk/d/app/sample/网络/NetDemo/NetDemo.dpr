program NetDemo;

uses
  Forms,
  DeviceForm in 'DeviceForm.pas' {DevForm},
  Common in 'Common.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDevForm, DevForm);
  Application.Run;
end.
