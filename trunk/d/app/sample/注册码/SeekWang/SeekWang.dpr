program SeekWang;

uses
  Forms,
  UntAddDlg in 'UntAddDlg.pas' {FrmAddDlg},
  UntRegFrm in 'UntRegFrm.pas' {FrmReg},
  Unit1 in 'Unit1.pas' {FrmMain},
  UntReg in 'UntReg.pas',
  U_TDownFile in 'U_TDownFile.pas',
  UntFrmGY in 'UntFrmGY.pas' {FrmGY},
  UntFrmAddAutoSend in 'UntFrmAddAutoSend.pas' {FrmAddAutoSend};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmGY, FrmGY);
  Application.CreateForm(TFrmGY, FrmGY);
  Application.CreateForm(TFrmAddAutoSend, FrmAddAutoSend);
  Application.CreateForm(TFrmAddAutoSend, FrmAddAutoSend);
  Application.Run;
end.
