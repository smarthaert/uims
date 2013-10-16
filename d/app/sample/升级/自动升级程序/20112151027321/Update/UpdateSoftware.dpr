program UpdateSoftware;

uses
  Forms,
  Update in 'Update.pas' {UpdataFrm},
  IBInstatusCallBack in 'IBInstatusCallBack.pas',
  arUpdata_ in 'arUpdata_.pas',
  DownInifile in 'DownInifile.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ÖÇÄÜ¸üÐÂV1.0';
  Application.CreateForm(TUpdataFrm, UpdataFrm);
  Application.Run;
end.
