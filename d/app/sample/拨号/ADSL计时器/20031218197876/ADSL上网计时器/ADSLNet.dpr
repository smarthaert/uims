program ADSLNet;

uses
  Forms, Classes, SysUtils, Dialogs,
  Main in 'Main.pas' {FrmADSLMain},
  ADSLStringRes in 'ADSLStringRes.pas',
  DropFrm in 'DropFrm.pas' {FrmDrop},
  SetupFrm in 'SetupFrm.pas' {FrmSetup},
  AboutFrm in 'AboutFrm.pas' {AboutBox},
  DropSetupFrm in 'DropSetupFrm.pas' {FrmDropSetup};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmADSLMain, FrmADSLMain);
  Application.CreateForm(TFrmDrop, FrmDrop);
  Application.Run;
end.

