unit Unit1;
//download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, ImgList, PrnDbgeh, Grids, DBGridEh, RzPanel, ExtCtrls,
  RzButton, Wwdbigrd, Wwdbgrid, RzStatus, wwDialog, wwfltdlg, FR_DSet,
  FR_DBSet, FR_Class, FR_Desgn, StdCtrls;

type
  TForm1 = class(TForm)
    RzToolbar1: TRzToolbar;
    RzStatusBar1: TRzStatusBar;
    PrintDBGridEh1: TPrintDBGridEh;
    ImageList1: TImageList;
    DataSource1: TDataSource;
    ADOConnection1: TADOConnection;
    da: TADOTable;
    BtnOpen: TRzToolButton;
    BtnSave: TRzToolButton;
    BtnPrintPreview: TRzToolButton;
    BtnPrint: TRzToolButton;
    BtnView: TRzToolButton;
    BtnExit: TRzToolButton;
    RzStatusPane1: TRzStatusPane;
    RzStatusPane2: TRzStatusPane;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    wwDBGrid1: TwwDBGrid;
    RzSpacer1: TRzSpacer;
    RzSpacer2: TRzSpacer;
    BtnInsertRecord: TRzToolButton;
    BtnDeleteRecord: TRzToolButton;
    wwFilterDialog1: TwwFilterDialog;
    frReport1: TfrReport;
    frDBDataSet1: TfrDBDataSet;
    frDesigner1: TfrDesigner;
    Panel2: TPanel;
    ComboBox1: TComboBox;
    RzBitBtn1: TRzBitBtn;
    procedure BtnOpenClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnInsertRecordClick(Sender: TObject);
    procedure BtnDeleteRecordClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnExitClick(Sender: TObject);
    procedure BtnViewClick(Sender: TObject);
    procedure BtnPrintPreviewClick(Sender: TObject);
    procedure BtnPrintClick(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure wwDBGrid1TitleButtonClick(Sender: TObject;
      AFieldName: String);
  private
    procedure loadexcel(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const{TADOConnection 连接数据库的参数}
ADOLinkString ='Provider=Microsoft.Jet.OLEDB.4.0;Extended Properties=excel 8.0;'
   + 'Password=%s;'     //用户工作组(*.mdw)密码
   + 'User ID=%s;'     //用户工作组(*.mdw)用户名Admin
   + 'Data Source=%s;'    //数据库文件(*.mdb)位置
   + 'Jet OLEDB:Database Password=%s;' //数据库密码
   + 'Jet OLEDB:New Database Password=%s;'    //?密码
;
var  mdwPassword,mdwUserID,mdbDataSource,mdbUserID,mdbPassword,mdbNewPassword:string;
var path:string;
procedure TForm1.loadexcel(Sender: TObject);
begin
Path :=ExtractFilePath(ParamStr(0));
mdwPassword :='';
mdwUserID :='Admin';
mdbUserID :='Admin';
mdbPassword :='wss690905'; //password wss690905
mdbNewPassword :='';
 with ADOConnection1 do
 begin
 ADOConnection1.Connected:=false;
 ConnectionString :=Format(ADOLinkString, [mdwPassword,  mdwUserId,mdbDataSource, mdbPassword, mdbNewPassword]);{初始连接参数}
 ADOConnection1.Connected:=true;
 //adouser.Active :=true;
 end;
end;
procedure TForm1.BtnOpenClick(Sender: TObject);
var i,fn:integer;
begin
if OpenDialog1.Execute then
begin
mdbDataSource :=OpenDialog1.FileName ; //不同系统更换数据库
Form1.loadexcel(Sender);
ADOConnection1.GetTableNames(ComboBox1.Items) ;
ComboBox1.ItemIndex :=0;
RzBitBtn1.Enabled :=true;
RzBitBtn1.Click ;
end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
da.Active :=false;
end;

procedure TForm1.BtnInsertRecordClick(Sender: TObject);
begin
da.append;
end;

procedure TForm1.BtnDeleteRecordClick(Sender: TObject);
begin
da.delete;
end;

procedure TForm1.BtnSaveClick(Sender: TObject);
begin
da.next;
da.Prior ;
end;

procedure TForm1.BtnExitClick(Sender: TObject);
begin
form1.Close;
end;

procedure TForm1.BtnViewClick(Sender: TObject);
begin
wwFilterDialog1.Execute ;
end;

procedure TForm1.BtnPrintPreviewClick(Sender: TObject);
begin
frReport1.LoadFromFile(path+'print.frf');
frReport1.DesignReport ;
end;

procedure TForm1.BtnPrintClick(Sender: TObject);
begin
frReport1.LoadFromFile(path+'print.frf');
frReport1.showReport  ;
end;

procedure TForm1.RzBitBtn1Click(Sender: TObject);
var fn,i:integer;
begin
da.Active :=false;
da.TableName :='['+combobox1.Text+']' ;
da.Active :=true;
fn:=da.FieldCount;
for i:=1 to fn do wwDBGrid1.AutoSizeColumn(i) ;
wwDBGrid1.Visible :=true;
BtnSave.Enabled:=true;
BtnInsertRecord.Enabled:=true;
BtnDeleteRecord.Enabled:=true;
BtnPrintPreview.Enabled:=true;
BtnPrint.Enabled:=true;
BtnView.Enabled :=true;
end;

procedure TForm1.wwDBGrid1TitleButtonClick(Sender: TObject;
  AFieldName: String);
begin
IF da.Sort= AFieldName+' ASC' THEN da.Sort:= AFieldName+' DESC'
ELSE da.Sort:= AFieldName+' ASC' ;
end;

end.
