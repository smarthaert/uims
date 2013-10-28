unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, Mask;

type
  TForm2 = class(TForm)
    GroupBox1: TGroupBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    ComboBox1: TComboBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    memo1: TMemo;
    ComboBox2: TComboBox;
    Label6: TLabel;
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
  uses unit1;
{$R *.DFM}

procedure TForm2.SpeedButton4Click(Sender: TObject);
begin
  close;
  //free;
end;

procedure TForm2.SpeedButton3Click(Sender: TObject);
var
  i:integer;
  fn:string;
  //整条记录,开始日期,时间,类别,内容
  r,s,t,l,a:string;
  sHour, sMin, sSec: string;
  Hour, Min, Sec, MSec: Word;
begin
  //获得个字段值
  s:=datetostr(DateTimePicker1.date);
  decodetime(DateTimePicker2.Time,Hour, Min, Sec, MSec);
  if (combobox2.ItemIndex=0)then
    if hour>12 then hour:=hour-12;
  if (combobox2.ItemIndex=1)then
    if hour<12 then hour:=hour+12;
  sHour:=inttostr(hour);
  sMin:=inttostr(min);
  sSec:='00';
  if strlen(pchar(shour))=1 then shour:='0'+shour;
  if strlen(pchar(smin))=1 then smin:='0'+smin;
  t:=sHour+':'+sMin+':'+sSec;

  l:=ComboBox1.Text;
  for i:=0 to memo1.lines.count-1 do
    a:=a+memo1.lines[i];
  r:=s+'*'+t+'*'+l+'*'+a;//合成记录

  with form1 do//根据情况更新数据
  begin
    if addoredit='添加记录' then
      ListBox1.Items.Add(r);//向同步列表框中添加
    if addoredit='修改当前记录' then
      listbox1.Items[StringGrid1.row-1]:=r;//在同步列表框中修改
    //保存数据
    fn:=extractfiledir(application.ExeName)+'\clocker.dat';
    ListBox1.Items.SaveToFile(fn);
    getdata;//刷新数据
    getTodayData;//更新当日提醒数据
    stringgrid1.Row:=stringgrid1.tag;//恢复修改前的选中行
  end;

  close;
  //free;
end;


//初始化窗口
procedure TForm2.FormCreate(Sender: TObject);
begin
  Caption:=addoredit;
  if addoredit='添加记录' then
  begin
    DateTimePicker1.Date:=now;
    DateTimePicker2.Time:=now;
    combobox1.ItemIndex:=0;
    combobox2.ItemIndex:=0;
    memo1.Clear;
  end;
  if addoredit='修改当前记录' then
  begin
    Memo1.Lines:=form1.stringgrid1.Rows[form1.stringgrid1.Row];
    with memo1 do
    begin
    DateTimePicker1.Date:=strtodate(lines[0]) ;
    if strtotime(lines[1])>strtotime('12:00:00') then
      combobox2.ItemIndex:=1
    else
      combobox2.ItemIndex:=0;
    DateTimePicker2.Time:=strtotime(lines[1]);
    if lines[2]='当次有效' then combobox1.ItemIndex:=0;
    if lines[2]='每天一次' then combobox1.ItemIndex:=1;
    if lines[2]='每周一次' then combobox1.ItemIndex:=2;
    if lines[2]='每月一次' then combobox1.ItemIndex:=3;
    if lines[2]='每年一次' then combobox1.ItemIndex:=4;
    lines.Text:=lines[3];
    end;
  end;

end;

end.
