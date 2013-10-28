unit AccPass;

interface
  //Download by http://www.codefans.net
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, WinSkinData;

type
  TAcc = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    OD: TOpenDialog;
    edit1: TEdit;
    edit2: TEdit;
    edit3: TEdit;
    SkinData1: TSkinData;
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Acc: TAcc;

implementation
uses
GetPass;

{$R *.dfm}

procedure TAcc.SpeedButton2Click(Sender: TObject);
begin
Application.Terminate;
end;

procedure TAcc.FormCreate(Sender: TObject);
begin
ACC.FormStyle := fsStayOnTop;
showmessage('本软件由马振强制作'#13'QQ:395241021'#13'有任何问题与我无关！'#13'呵呵~~');
end;

procedure TAcc.SpeedButton1Click(Sender: TObject);
begin
if od.Execute then
edit1.Text:=od.FileName;
try
GetAccPass(edit1.Text,edit2,edit3);
except
showmessage('狂晕，无法破解~~~');
end;
end;

end.
