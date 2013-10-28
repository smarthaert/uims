program IWProject;
{PUBDIST}

uses
  IWInitStandAlone,
  ServerController in 'ServerController.pas' {IWServerController: TDataModule},
  IWUnit1 in 'IWUnit1.pas' {formMain: TIWForm1},
  udmUser in 'udmUser.pas' {UserDM: TDataModule},
  uUserMaint in 'uUserMaint.pas';

{$R *.res}

begin
  IWRun(TFormMain, TIWServerController);
end.
