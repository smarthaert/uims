unit Unit1;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Calendar, Buttons, StdCtrls, Mask, Spin, SqlTimSt;

type
  TForm1 = class(TForm)
    Calendar1: TCalendar;
    Edit1: TEdit;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Edit2: TEdit;
    Edit3: TEdit;
    SpinButton1: TSpinButton;
    SpinButton2: TSpinButton;
    Label2: TLabel;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    procedure SpeedButton1Click(Sender: TObject);
    procedure Calendar1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton2UpClick(Sender: TObject);
    procedure SpinButton2DownClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Intis : Integer=0;
implementation

{$R *.dfm}

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if Intis=0 then
  begin
    Calendar1.Visible := True;
    SpinButton1.Enabled := True;
    SpinButton2.Enabled := True;
    Intis := Intis+1;
  end
  else
  begin
    Calendar1.Visible := False;
    SpinButton1.Enabled := False;
    SpinButton2.Enabled := False;
    Intis := Intis-1;
  end;
end;

procedure TForm1.Calendar1Change(Sender: TObject);
begin
  Edit1.Text := IntToStr(Calendar1.Year)+'-'+IntToStr(Calendar1.Month)+'-'+IntToStr(Calendar1.Day);
  Edit2.Text := IntToStr(Calendar1.Year);
  Edit3.Text := IntToStr(Calendar1.Month);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Edit1.Text := IntToStr(Calendar1.Year)+'-'+IntToStr(Calendar1.Month)+'-'+IntToStr(Calendar1.Day);
  Edit2.Text := IntToStr(Calendar1.Year);
  Edit3.Text := IntToStr(Calendar1.Month);
  Calendar1.Hint := '当前时间为：'+IntToStr(Calendar1.Year)+'年'+IntToStr(Calendar1.Month)+'月'+IntToStr(Calendar1.Day)+'日';
end;

procedure TForm1.SpinButton1UpClick(Sender: TObject);
begin
  Calendar1.PrevYear;
  Calendar1Change(Sender);
end;

procedure TForm1.SpinButton1DownClick(Sender: TObject);
begin
  Calendar1.NextYear;
  Calendar1Change(Sender);
end;

procedure TForm1.SpinButton2UpClick(Sender: TObject);
begin
  Calendar1.PrevMonth;
  Calendar1Change(Sender);
end;

procedure TForm1.SpinButton2DownClick(Sender: TObject);
begin
  Calendar1.NextMonth;
  Calendar1Change(Sender);
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  TS : TSystemTime;
begin
  //在单元中添加SqlTimSt单元
  DateTimeToSystemTime(now,TS);
  Edit1.Text := IntToStr(TS.wYear)+'-'+IntToStr(TS.wMonth)+'-'+IntToStr(TS.wDay);
  Edit2.Text := IntToStr(TS.wYear);
  Edit3.Text := IntToStr(TS.wMonth);
  Calendar1.Year := TS.wYear;
  Calendar1.Month := TS.wMonth;
  Calendar1.Day := TS.wDay;
end;


end.
