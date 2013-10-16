unit Unit12;
{作者BLOG ALALMN JACK     http://hi.baidu.com/alalmn  
远程控制和木马编写群30096995   }
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls;

type
  Tchuanko = class(TForm)
    ListBox1: TListBox;
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
  chuanko: Tchuanko;

implementation
uses Unit1;

{$R *.dfm}

procedure Tchuanko.N1Click(Sender: TObject);
begin
Form1.ZhuDongCmdSend('031','',false);
end;

procedure Tchuanko.N2Click(Sender: TObject);
begin
Form1.ZhuDongCmdSend('032','',false);
end;

procedure Tchuanko.N3Click(Sender: TObject);
begin
Form1.ZhuDongCmdSend('033','',false);
end;

procedure Tchuanko.N4Click(Sender: TObject);
begin
Form1.ZhuDongCmdSend('030','',false);
end;

end.
