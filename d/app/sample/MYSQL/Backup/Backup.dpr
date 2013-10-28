program Backup;

uses
  Forms,
  UnitBackup in 'UnitBackup.pas' {FrmBackup},
  UnitFrmSetupTime in 'UnitFrmSetupTime.pas' {FrmSetupTime},
  UnitFilePath in 'UnitFilePath.pas' {FrmFilePath},
  UnitDirPath in 'UnitDirPath.pas' {FrmDirPath},
  UnitDlg in 'UnitDlg.pas' {frmDlg},
  UnitChose in 'UnitChose.pas' {frmChoose};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmBackup, FrmBackup);
  Application.Run;
end.
