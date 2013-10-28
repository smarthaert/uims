program IWProject;
{PUBDIST}

uses
  IWInitStandAlone,
  ServerController in 'ServerController.pas' {IWServerController: TDataModule},
  IWUnit1 in 'IWUnit1.pas' {formMain: TIWForm1},
  IWUnit2 in 'IWUnit2.pas' {FormWelcome: TIWAppForm};

{$R *.res}

begin
  IWRun(TFormMain, TIWServerController);
end.
