program reportPrint;

uses
  Forms,
  sysutils,
  dialogs,
  Unit1 in 'Unit1.pas' {Form1},
  Unit4 in 'Unit4.pas',
  Unit5 in 'Unit5.pas' {Form5},
  Unit6 in 'Unit6.pas' {Form6},
  Unit7 in 'Unit7.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  ////先运行initParams函数初始化参数.
  try
  unit7.initParams;
  except on e:exception do
  begin
    showmessage('导入params.cfg配置文件失败,建议检查后和重新运行程序'+e.message);
    //exit;
  end;
  end;
  Application.Run;
end.
