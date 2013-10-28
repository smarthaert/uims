program SUpData;

uses
  Forms,
  UpTemp in 'UpTemp.pas' {UpTempForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '铁通陕西分公司拨号升级程序';
  Application.CreateForm(TUpTempForm, UpTempForm);
  Application.Run;
end.
