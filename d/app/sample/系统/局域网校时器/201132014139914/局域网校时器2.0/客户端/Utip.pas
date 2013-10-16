unit Utip;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  Ttip = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    STWebTime: TStaticText;
    STLocalTime: TStaticText;
    Timer1: TTimer;
    BitBtn2: TBitBtn;
    Button1: TButton;
    STD: TStaticText;
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  tip: Ttip;
  I:longword;
  WebTime:Ttime;
implementation
uses Umain;
{$R *.dfm}
//设置客户机系统时钟
function SetSystemtime2(ATime: TDateTime) : boolean;
Var
  ADateTime:TSystemTime;
  yy,mon,dd,hh,min,ss,ms : Word;
Begin
  decodedate(ATime ,yy,mon,dd);
  decodetime(ATime ,hh,min,ss,ms);
  With ADateTime Do
    Begin
      wYear:=yy;
      wMonth:=mon;
      wDay:=dd;
      wHour:=hh;
      wMinute:=min;
      wSecond:=ss;
      wMilliseconds:=ms;
    End;
   Result:=SetLocalTime(ADateTime);
   SendMessage(HWND_BROADCAST,WM_TIMECHANGE,0,0) ;
  // If Result then ShowMessage('成功改变时间!');
End;

procedure Ttip.FormShow(Sender: TObject);
begin
 std.Caption := formatdateTime('yy-mm-dd',strtodatetime(tiptime));
 WebTime:=strtotime(formatdateTime('hh:mm:ss',strtodatetime(tiptime)));
 stWebTime.Caption := formatdateTime('hh:mm:ss',webtime);
 STLocalTime.Caption := formatdateTime('hh:mm:ss',time);
end;

procedure Ttip.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure Ttip.Timer1Timer(Sender: TObject);
begin
 i:=i+1;
 STWebTime.Caption := formatdateTime('hh:mm:ss',(webtime+i/(48*3600)));
 STLocalTime.Caption := formatdateTime('hh:mm:ss',time);
end;

procedure Ttip.Button1Click(Sender: TObject);
var SYNTime:string;
begin
  SYNTime:=std.Caption+' '+STWebTime.Caption;
  SetSystemtime2(strtodatetime(SYNTime));
  FormShow(sender);
  MessageBox(Handle, '同步本机时间完成', '提示', MB_ICONASTERISK);
  close;
end;

end.
