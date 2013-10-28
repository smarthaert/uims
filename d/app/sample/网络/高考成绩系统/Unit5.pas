unit Unit5;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, DBTables, Grids, DBGrids, Buttons;

type
  TForm5 = class(TForm)
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Edit1: TEdit;
    DBGrid1: TDBGrid;
    Edit2: TEdit;
    Edit3: TEdit;
    Table1: TTable;
    Table1BDEDesigner: TFloatField;
    Table1BDEDesigner2: TFloatField;
    Table1BDEDesigner3: TStringField;
    Table1BDEDesigner4: TFloatField;
    DataSource1: TDataSource;
    Memo1: TMemo;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.SpeedButton1Click(Sender: TObject);
var
sum1:real;
s:string;
s1:string;
aver:real;
bookmark1:tbookmark;
begin
table1.refresh;
with table1 do
try
  disablecontrols;
  filtered:=false;
  memo1.Text:='准考证号='+edit1.text;
  filter:=memo1.text;
  filtered:=true;
finally
  enablecontrols;
if table1.recordcount=0 then begin
messagebeep(1);
showmessage('没有符合条件的记录,请确认条件或放弃查询!');
if messageDlg('是否继续查询？,只有结束查询才能作其它操作!',mtinformation,[mbYes,mbNo],0)=mrno then begin
  filtered:=false;
 table1.close;
 table1.open;
end;
end else begin
sum1:=0.00;
bookmark1:=table1.getbookmark;
table1.disablecontrols;
table1.first;
while not table1.eof do
begin
sum1:=sum1+table1.fieldbyname('考试成绩').value;
table1.Next;
aver:=sum1/table1.recordcount;
end;
table1.gotobookmark(bookmark1);
table1.FreeBookmark(bookmark1);
table1.EnableControls;
str(sum1:8:2,s);
str(aver:8:2,s1);
edit2.text:=s;
edit3.Text:=s1;
 if messageDlg('是否继续查询？,只有结束查询才能作其它操作!',mtinformation,[mbYes,mbNo],0)=mrno then begin
  filtered:=false;
 table1.close;
 table1.open;
end;
 end;
end;
end;
end.
