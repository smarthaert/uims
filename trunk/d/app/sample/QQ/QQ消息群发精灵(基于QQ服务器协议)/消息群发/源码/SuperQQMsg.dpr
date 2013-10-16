//**********************************
//源码名称：QQ消息群发精灵(基于QQ服务器协议)
//开发环境：Delphi7.0+WinXP
//源码作者：源码天空
//官方网站：http://www.codesky.net
//特别感谢：微程 提供QQ协议分析
//请尊重原作者的劳动，你可以任意修改源码，但请保持以上信息的完整性。
// **********************************
program SuperQQMsg;

uses
  Forms,
  Unit1 in 'Unit1.pas' {frmMain},
  UnitMD5 in 'UnitMD5.pas',
  UnitSkipQQ in 'UnitSkipQQ.pas' {frmSetSkipQQ},
  UnitAbout in 'UnitAbout.pas' {frmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSetSkipQQ, frmSetSkipQQ);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.
