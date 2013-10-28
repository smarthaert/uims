program ModemStatus;

uses
  Forms,
  Frm_ModemStatus in 'Frm_ModemStatus.pas' {FrmModemStatus};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmModemStatus, FrmModemStatus);
  Application.Run;
end.
