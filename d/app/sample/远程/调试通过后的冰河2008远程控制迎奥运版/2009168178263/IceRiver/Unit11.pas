unit Unit11;
{作者BLOG ALALMN JACK     http://hi.baidu.com/alalmn  
远程控制和木马编写群30096995   }
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  Tcanshu = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    ComboBox1: TComboBox;
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
  canshu: Tcanshu;

implementation
uses
Unit6,Unit1;

{$R *.dfm}

procedure Tcanshu.Button2Click(Sender: TObject);
begin
close;
end;

procedure Tcanshu.Button1Click(Sender: TObject);
begin
    if Edit1.Text<>'' then
       Form1.ZhuDongCmdSend('014',inttostr(ComboBox1.Items.IndexOf(ComboBox1.Text))+#13+Downloadpath+Form1.ListView1.Selected.Caption+#13+edit1.Text,false)
    else
       Form1.ZhuDongCmdSend('014',inttostr(ComboBox1.Items.IndexOf(ComboBox1.Text))+#13+Downloadpath+Form1.ListView1.Selected.Caption,false)
end;

end.
