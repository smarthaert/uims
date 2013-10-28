program verifyPro;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  VCRes in 'VCRes.pas';

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
