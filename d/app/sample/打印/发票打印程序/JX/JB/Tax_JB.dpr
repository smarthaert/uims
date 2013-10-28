program Tax_JB;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  EnterpriseRegister in 'EnterpriseRegister.pas' {frmEnterpriseRegister},
  DeputizeCharge in 'DeputizeCharge.pas' {frmDeputizeCharge},
  MonthScrip in 'MonthScrip.pas' {frmMonthScrip},
  QueryPrint in 'QueryPrint.pas' {frmQueryPrint},
  Option in 'Option.pas' {frmOption},
  ClassEnterprise in 'ClassEnterprise.pas',
  Global in 'Global.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := '增值税发票结报系统.';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmQueryPrint, frmQueryPrint);
  Application.CreateForm(TfrmOption, frmOption);
  Application.Run;
end.

