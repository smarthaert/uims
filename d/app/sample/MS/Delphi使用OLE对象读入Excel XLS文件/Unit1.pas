unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, DBTables, Grids, DBGrids,ComObj;

type
  TMainForm = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Table1: TTable;
    BitBtnSave: TBitBtn;
    BitBtnClose: TBitBtn;
    CheckBox1: TCheckBox;
    procedure BitBtnSaveClick(Sender: TObject);
    procedure BitBtnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  v:variant;

implementation

{$R *.dfm}

procedure TMainForm.BitBtnSaveClick(Sender: TObject);
var
  s:string;
  i,j:integer;
begin
  s:='f:\zfhd\example.xls'; //文件名
  if fileexists(s) then deletefile(s);
  v:=CreateOLEObject('Excel.Application'); //建立OLE对象
  V.WorkBooks.Add;
  if Checkbox1.Checked then
    begin
      V.Visible:=True;
      MainForm.WindowState:=wsMinimized;
      //使Excel可见，并将本程序最小化，以观察Excel的运行情况
    end
  else
    begin
      V.Visible:=False;
    end;
    //使Excel窗口不可见
    Application.BringToFront; //程序前置
  try
  try
    Cursor:=crSQLWait;
    Table1.DisableControls;
    For i:=0 to Table1.FieldCount-1 do //字段数
    //注意：Delphi中的数组的下标是从0开始的，
    // 而Excel的表格是从1开始编号
      begin
      V.Goto('R1'+'C'+IntToStr(i+1)); //Excel的表格是从1开始编号
      V.ActiveCell.FormulaR1C1:=Table1.Fields[i].FieldName;//传送字段名
      end;
    j:=2;
    Table1.First;
    while not Table1.EOF do
      begin
      For i:=0 to Table1.FieldCount-1 do //字段数
        begin
          V.Goto('R'+IntToStr(j)+'C'+IntToStr(i+1));
          V.ActiveCell.FormulaR1C1:=Table1.Fields[i].AsString;//传送内容
        end;
      Table1.Next;
      j:=j+1;
     end;
    V.ActiveSheet.Protect(DrawingObjects:=True,Contents:=True,Scenarios:=True);//设置保护
    ShowMessage('数据库到Excel的数据传输完毕!');
    v.ActiveWorkBook.Saveas(filename:=s);//文件存盘
    except //发生错误时
    ShowMessage('没有发现Excel!');
    end;
    finally
    Cursor:=crDefault;
    Table1.First;
    Table1.EnableControls;
    end;
    end;
procedure TMainForm.BitBtnCloseClick(Sender: TObject);
begin
v.quit; //退出OLE对象
MainForm.WindowState:=wsNormal;
end;
//Download by http://www.codefans.net
procedure TMainForm.FormShow(Sender: TObject);
begin
Table1.Open;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Table1.Close;
end;

end.
