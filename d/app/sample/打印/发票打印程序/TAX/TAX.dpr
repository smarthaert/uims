program TAX;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  Tools in 'Tools.pas',
  JBInput in 'JBInput.pas' {FrmJBInput},
  ChargeInput in 'ChargeInput.pas' {FrmChargeInput},
  EPriseReg in 'EPriseReg.pas' {FrmEPriseReg},
  IMESet in 'IMESet.pas' {FrmIMESet},
  Login in 'Login.pas' {FrmLogin};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
