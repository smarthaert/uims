unit Unit1;
{* |<PRE>
================================================================================
* 软件名称：delphi代码直接控制百度、谷歌网页搜索
* 单元名称：
* 过程名：
* 函数名：
* uses其它单元：
* 作者：    lah998 (lah02000@yahoo.com.cn)
* 制作目的：
* 实现原理：
* 创建时间：2009-09-19
* 开发平台：Microsoft Wiondows XP Pro Service Pack 3 + Delphi 7
* 兼容测试：Win2K
* 修改记录：
* 接口说明：
* 输入输出说明：
* 备    注： 简单就是美
================================================================================
|</PRE>}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw,MSHTML;

type
  TForm1 = class(TForm)
    WebBrowser1: TWebBrowser;
    GroupBox1: TGroupBox;
    Button2: TButton;
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
//user MSHTML, SHDOCVW, IdGlobal
var
  Form: IHTMLFormElement;
  Doc: IHTMLDocument2;
  GJCinputStr: IHTMLInputElement;
begin
  //webbrowser1.Navigate(Edit1.Text);
  webbrowser1.Navigate('http://www.baidu.com');
  repeat
    Application.ProcessMessages;
  until (not webbrowser1.Busy);
  //网页没有打开先暂停,网页打开了执行下面代码
  Doc := webbrowser1.document as IHTMLDocument2;
  GJCinputStr := (Doc.all.item('wd', 0) as IHTMLInputElement);
  GJCinputStr.value := Edit1.Text; //输入百度关键词
  Form := (doc.all.item('f', 0) as ihtmlformelement);
  Form.submit;
end;


procedure TForm1.Button2Click(Sender: TObject);
var
  Doc: IHTMLDocument2;
  input: OleVariant;
  GJCinputStr: IHTMLInputElement;
begin
  //webbrowser1.Navigate(Edit1.Text);
  webbrowser1.Navigate('http://www.google.cn');
  repeat
    Application.ProcessMessages;
  until (not webbrowser1.Busy);
  //网页没有打开先暂停,网页打开了执行下面代码
  Doc := webbrowser1.document as IHTMLDocument2;
  GJCinputStr := (Doc.all.item('q', 0) as IHTMLInputElement);
  GJCinputStr.value :=Edit1.Text; //输入google关键词
  input := Doc.all.item('btnG', 0); 
  input.click;
end;


end.
