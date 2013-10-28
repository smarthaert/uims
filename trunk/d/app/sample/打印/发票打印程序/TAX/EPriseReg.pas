unit EPriseReg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Db, DBTables, Label3D, Buttons, OEdit, Grids,
  DBGrids, DBCtrls;

type
  TFrmEPriseReg = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    BitBtn6: TBitBtn;
    Panel4: TPanel;
    Panel5: TPanel;
    btnCancel: TBitBtn;
    btnSave: TBitBtn;
    btnDelete: TBitBtn;
    btnModify: TBitBtn;
    btnAdd: TBitBtn;
    Label3D1: TLabel3D;
    Label1: TLabel;
    edRateNo: TOvrEdit;
    Label2: TLabel;
    edRegNO: TOvrEdit;
    Label3: TLabel;
    edEPrise: TOvrEdit;
    Label4: TLabel;
    edAddress: TOvrEdit;
    Label5: TLabel;
    edPhone: TOvrEdit;
    Label6: TLabel;
    edLinkman: TOvrEdit;
    Table1: TTable;
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    Table1Ratepaying_No: TStringField;
    Table1Enterprise: TStringField;
    Table1Address: TStringField;
    Table1Register_No: TStringField;
    Table1Phone_No: TStringField;
    Table1Linkman: TStringField;
    Table1State: TStringField;
    procedure BitBtn6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAddClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure edLinkmanExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Table1AfterScroll(DataSet: TDataSet);
    procedure btnModifyClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    FStyle : Char;
    function Insert(cStyle:Char):Boolean;
    procedure Write;
    procedure Clear;
    procedure Disable;
    procedure Enable;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEPriseReg: TFrmEPriseReg;

implementation

uses Tools;

{$R *.DFM}

// Ratepaying_No	A(6)		纳税代码
// Enterprise	        A(50)		企业名称
// Address	        A(50)		地址
// Register_No	        A(15)		税务登记证号
// Phone_No	        A(12)		电话
// Linkman  	        A(8)		联系人
// State                L               状态(True-有效,False-无效{注销})
function TFrmEPriseReg.Insert(cStyle:Char):Boolean;
var
  TempQuery:TQuery;
begin
//  Result:=False;
  TempQuery:=TQuery.Create(nil);
  try
    try
      TempQuery.DatabaseName:='TaxDB';
      TempQuery.SQL.Clear;
      case cStyle of
        'I':
        begin
          TempQuery.SQL.Add('INSERT INTO EPRISE.DB');
          TempQuery.SQL.Add('VALUES ("'+Trim(edRateNo.Text)+'","'+Trim(edEPrise.Text)+'",');
          TempQuery.SQL.Add('"'+Trim(edAddress.Text)+'","'+Trim(edRegNO.Text)+'",');
          TempQuery.SQL.Add('"'+Trim(edPhone.Text)+'","'+Trim(edLinkman.Text)+'","1")');
        end;
        'M':
        begin
        end;
      end;
      TempQuery.Prepare;
      TempQuery.ExecSQL;
      Result:=True;
//      Application.MessageBox('登记成功！','提示信息',MB_OK+MB_ICONINFORMATION);
    except
      Result:=False;
//      on E: Exception do Application.MessageBox('登记失败！','错误信息',MB_OK+MB_ICONSTOP);
    end;
  finally
    TempQuery.UnPrepare;
    TempQuery.Free;
  end;
end;

procedure TFrmEPriseReg.Write;
begin
  with Table1 do
  begin
    edRateNo.Text  :=FieldByName('Ratepaying_No').AsString;
    edEPrise.Text  :=FieldByName('Enterprise').AsString;
    edAddress.Text :=FieldByName('Address').AsString;
    edRegNO.Text   :=FieldByName('Register_No').AsString;
    edPhone.Text   :=FieldByName('Phone_No').AsString;
    edLinkman.Text :=FieldByName('Linkman').AsString;
  end;
end;

procedure TFrmEPriseReg.Clear;
begin
  edRateNo.Text  :='';
  edEPrise.Text  :='';
  edAddress.Text :='';
  edRegNO.Text   :='';
  edPhone.Text   :='';
  edLinkman.Text :='';
end;

procedure TFrmEPriseReg.Disable;
begin
  edRateNo.Enabled:=False;
  edEPrise.Enabled:=False;
  edAddress.Enabled:=False;
  edRegNO.Enabled:=False;
  edPhone.Enabled:=False;
  edLinkman.Enabled:=False;
end;

procedure TFrmEPriseReg.Enable;
begin
  edRateNo.Enabled:=True;
  edEPrise.Enabled:=True;
  edAddress.Enabled:=True;
  edRegNO.Enabled:=True;
  edPhone.Enabled:=True;
  edLinkman.Enabled:=True;
end;

procedure TFrmEPriseReg.BitBtn6Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmEPriseReg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Application.MessageBox('真的要返回到主界面吗？','提示信息',MB_OKCANCEL+MB_ICONQUESTION)=IDOK then
    Action:=caFree
  else
    Action:=caNone;
end;

procedure TFrmEPriseReg.btnAddClick(Sender: TObject);
begin
  FStyle:='I';
  Enable;
  Clear;
  edRateNo.SetFocus;

  btnAdd.Enabled:=False;
  btnDelete.Enabled:=False;
  btnModify.Enabled:=False;
  btnSave.Enabled:=True;
  btnCancel.Enabled:=True;
end;

procedure TFrmEPriseReg.btnSaveClick(Sender: TObject);
begin
  if Insert(FStyle) then
  begin
    Application.MessageBox('登记成功！','提示信息',MB_OK+MB_ICONINFORMATION);
    Table1.Refresh;
  end
  else
    Application.MessageBox('登记失败！','错误信息',MB_OK+MB_ICONSTOP);

  Disable;
  btnAdd.Enabled:=True;
  btnAdd.SetFocus;
  btnDelete.Enabled:=True;
  btnModify.Enabled:=True;
  btnSave.Enabled:=False;
  btnCancel.Enabled:=False;
end;

procedure TFrmEPriseReg.edLinkmanExit(Sender: TObject);
begin
  btnSave.SetFocus;
end;

procedure TFrmEPriseReg.FormActivate(Sender: TObject);
begin
  edEPrise.ImeName:=ImeSet;
  edAddress.ImeName:=ImeSet;
  edLinkman.ImeName:=ImeSet;

  Write;
  Disable;
  btnSave.Enabled:=False;
  btnCancel.Enabled:=False;
end;

procedure TFrmEPriseReg.DBNavigator1Click(Sender: TObject;
  Button: TNavigateBtn);
begin
//  Write;
end;

procedure TFrmEPriseReg.DBGrid1CellClick(Column: TColumn);
begin
//  Write;
end;

procedure TFrmEPriseReg.Table1AfterScroll(DataSet: TDataSet);
begin
  Write;
end;

procedure TFrmEPriseReg.btnModifyClick(Sender: TObject);
begin
  FStyle:='M';
  Enable;
  edRateNo.Enabled:=False;
  edRegNO.SetFocus;

  btnAdd.Enabled:=False;
  btnDelete.Enabled:=False;
  btnModify.Enabled:=False;
  btnSave.Enabled:=True;
  btnCancel.Enabled:=True;
end;

procedure TFrmEPriseReg.btnDeleteClick(Sender: TObject);
begin
  if Application.MessageBox('真的要删除吗？','警告信息',MB_OKCANCEL+MB_ICONWARNING)=IDOK then
    Table1.Delete;
end;

end.
