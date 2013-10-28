program SendMail;

uses
  Forms,
  frm_SendMail in 'frm_SendMail.pas' {FrmSendMail};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmSendMail, FrmSendMail);
  Application.Run;
end.
