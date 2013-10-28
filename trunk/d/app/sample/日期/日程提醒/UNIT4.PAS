unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls,mmsystem,inifiles, BTOdeum;

type
  TForm4 = class(TForm)
    Bevel1: TBevel;
    SpeedButton1: TSpeedButton;
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    Timer1: TTimer;
    Label6: TLabel;
    BTBeeper1: TBTBeeper;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation
  uses unit1;
{$R *.DFM}

procedure TForm4.SpeedButton1Click(Sender: TObject);
begin
close;
end;

procedure TForm4.FormShow(Sender: TObject);
var
  fn:tinifile;
  FSoundFile:string;
  Finifile:string;
begin
    SetWindowPos(Handle,HWND_TOPMOST,Left,Top,Width,Height,SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);

  finifile:=extractfilepath(application.exename)+'clocker.ini';
  fn:=tinifile.Create(finifile);
  if (fn.readString('tixing','canplay','0')='1') and (caption<>'浏览今日计划') then
  begin
    FSoundFile:=fn.readString('tixing','play',finifile);
    sndPlaySound(pchar(FSoundFile), snd_Async or snd_NoDefault);
  end;
  if fn.readString('tixing','autoclose','0')='1' then
  begin
    timer1.Interval:=(strtoint(fn.readString('tixing','delay','5'))+1)*1000;
    timer1.Enabled:=true;
  end;

end;

procedure TForm4.Timer1Timer(Sender: TObject);
begin
timer1.Enabled:=false;
close;

end;

procedure TForm4.FormPaint(Sender: TObject);
begin
    SetWindowPos(Handle,HWND_TOPMOST,Left,Top,Width,Height,SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);

end;

end.
