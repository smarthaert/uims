unit Unit10;
{作者BLOG ALALMN JACK     http://hi.baidu.com/alalmn  
远程控制和木马编写群30096995   }
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  Txiwenjian = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  xiwenjian: Txiwenjian;

implementation
uses
Unit6,Unit1;
{$R *.dfm}

procedure Txiwenjian.Button2Click(Sender: TObject);
begin
close;
end;

procedure Txiwenjian.Button1Click(Sender: TObject);
begin
   if Edit1.Text<>'' then
     Form1.ZhuDongCmdSend('011',Downloadpath+ Edit1.Text,false);
     wenjian.RefreshMenuClick(Sender);
   close;
end;

end.
