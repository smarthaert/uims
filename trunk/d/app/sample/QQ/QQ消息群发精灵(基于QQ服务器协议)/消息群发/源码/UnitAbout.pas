//**********************************
//源码名称：QQ消息群发精灵(基于QQ服务器协议)
//开发环境：Delphi7.0+WinXP
//源码作者：源码天空
//官方网站：http://www.codesky.net
//特别感谢：微程 提供QQ协议分析
//请尊重原作者的劳动，你可以任意修改源码，但请保持以上信息的完整性。
// **********************************
unit UnitAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfrmAbout = class(TForm)
    btnOK: TBitBtn;
    Label1: TLabel;
    Memo1: TMemo;
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

procedure TfrmAbout.btnOKClick(Sender: TObject);
begin
self.Close;
end;

end.
