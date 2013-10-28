program IWUser;
{PUBDIST}

uses
  IWInitStandAlone,
  ServerController in 'ServerController.pas' {IWServerController: TDataModule},
  IWUnit1 in 'IWUnit1.pas' {formMain: TIWAppForm},
  uIUserService in 'uIUserService.pas';

{$R *.res}

begin
  IWRun(TFormMain, TIWServerController);
end.
