unit Unit7;
{作者BLOG ALALMN JACK     http://hi.baidu.com/alalmn  
远程控制和木马编写群30096995   }
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Menus;

type
  Tjincheng = class(TForm)
    ListView1: TListView;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Timer1: TTimer;
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  jincheng: Tjincheng;

implementation
uses Unit1;

{$R *.dfm}


procedure Tjincheng.N1Click(Sender: TObject);
begin
Form1.ZhuDongCmdSend('021',inttostr(ListView1.ItemIndex),false);
end;

procedure Tjincheng.N2Click(Sender: TObject);
begin
Form1.ZhuDongCmdSend('020','',false);
end;

procedure Tjincheng.Timer1Timer(Sender: TObject);
begin
Form1.ZhuDongCmdSend('020','',false);
end;

end.
