program ProjectTest;

uses
  Forms,
  UnitTest in 'UnitTest.pas' {frmMainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '时钟组件测试程序';
  Application.CreateForm(TfrmMainForm, frmMainForm);
  Application.Run;
end.
