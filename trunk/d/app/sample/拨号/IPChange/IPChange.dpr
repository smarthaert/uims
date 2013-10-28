program IPChange;

uses
  Forms,
  frm_IPChange in 'frm_IPChange.pas' {FrmIPAddr};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmIPAddr, FrmIPAddr);
  Application.Run;
end.
