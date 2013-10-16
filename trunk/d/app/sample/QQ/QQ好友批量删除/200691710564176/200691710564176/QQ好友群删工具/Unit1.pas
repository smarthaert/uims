unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Timer1: TTimer;
    Timer2: TTimer;
    Button2: TButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  i:integer;

implementation

{$R *.dfm}

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
if GetKeyState(vk_escape)<0 then
close;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
Window: THandle;
begin
window:=FindWindow('#32770', '信息管理器');
if window = 0 then exit;
keybd_event(VK_CONTROL,0,0,0);
keybd_event(ord(65),0,0,0);
keybd_event(ord(65),0,KEYEVENTF_KEYUP,0);
keybd_event(VK_CONTROL,0,KEYEVENTF_KEYUP,0);
mouse_event(MOUSEEVENTF_RIGHTDOWN,0,0,0,0);
keybd_event(ord(68),0,0,0);
timer2.Enabled:=true;
end;
procedure TForm1.Timer2Timer(Sender: TObject);
var
Window2,hButton,hLastWin : THandle;
a:string ;
Buf: array[0..1024] of Char;
begin
hButton:=0;
hLastWin:=FindWindowEx(GetForegroundWindow,hButton,'#32770',nil);
if hLastWin=0 then Exit;
hButton := FindWindowEx(hLastWin, THandle(nil),nil,'确定');
if hButton=0 then Exit;
SendMessage(hLastWin, WM_GETTEXT, 33, Integer(@Buf));
SendMessage(hButton, WM_LBUTTONDOWN, 0, 0);
SendMessage(hButton, WM_LBUTTONUP, 0, 0);
i:=i+1;
a:=InttoStr(i);
memo1.Lines.Add('正在删除您的第'+a+'位好友'+buf);
timer1.Enabled:=false;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
timer1.Enabled:=true;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
i:=0;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
close;
end;

end.
