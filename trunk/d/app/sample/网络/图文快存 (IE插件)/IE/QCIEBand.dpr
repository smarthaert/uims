library QCIEBand;

uses
  ComServ,
  QCIEBand_TLB in 'QCIEBand_TLB.pas',
  BandUnit in 'BandUnit.pas' {BandUnit: CoClass},
  IEForm in 'IEForm.pas' {frmMain},
  ShizhiUnit in 'ShizhiUnit.pas' {frmShizhi};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.
