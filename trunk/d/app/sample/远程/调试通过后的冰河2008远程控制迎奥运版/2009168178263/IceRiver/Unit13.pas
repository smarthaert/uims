unit Unit13;
{作者BLOG ALALMN JACK     http://hi.baidu.com/alalmn  
远程控制和木马编写群30096995   }
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls;

type
  Tjianpan = class(TForm)
    Memo1: TMemo;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  jianpan: Tjianpan;

implementation
 uses Unit1;

{$R *.dfm}

procedure Tjianpan.N1Click(Sender: TObject);
begin
Form1.ZhuDongCmdSend('040','',false);
end;

procedure Tjianpan.N2Click(Sender: TObject);
begin
Form1.ZhuDongCmdSend('041','',false);
end;

procedure Tjianpan.N3Click(Sender: TObject);
begin
Form1.ZhuDongCmdSend('042','',false);
end;

procedure Tjianpan.N4Click(Sender: TObject);
begin
Form1.ZhuDongCmdSend('043','',false);
end;

end.
