unit Unit1;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Buttons;

type
  TForm1 = class(TForm)
    ADOQuery1: TADOQuery;
    ADOConnection1: TADOConnection;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    DT_FWQSJ: TDateTime;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  With ADOQuery1 do
    begin
         ExecSQL;
         Dt_FWQSJ:=Parameters.ParamByName('SJ').Value;
    end;
    ShowMessage('服务器时间是['+dateTimeTOStr(DT_FWQSJ)+']');
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var
    sj: _SYSTEMTIME;
    year,month,day: word;
    hour,min,sec,msec:word;
begin
    decodedate(dt_fwqsj,year,month,day);
    sj.wYear:=year;
    sj.wMonth:=month;
    sj.wDay:=day;
    DecodeTime(dt_fwqsj,hour,min,sec,msec);
    sj.wHour:=hour;
    sj.wMinute:=min;
    sj.wSecond:=sec;
    sj.wMilliseconds:=msec;
    SetLocalTime(sj);
    ShowMessage('更新成功');
end;

end.
