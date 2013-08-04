unit Unit11;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Grids, DBGrids, Mask, RzEdit,
  RzSpnEdt, RzButton, RzRadChk, DB, ADODB, QRCtrls, QuickRpt;

type
  TFr_ChuKuMingXi = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel6: TPanel;
    Button1: TButton;
    Button2: TButton;
    Panel5: TPanel;
    Label1: TLabel;
    Button3: TButton;
    Panel3: TPanel;
    Panel4: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RzDateTimeEdit1: TRzDateTimeEdit;
    RzDateTimeEdit2: TRzDateTimeEdit;
    Label2: TLabel;
    Label3: TLabel;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    Panel7: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel8: TPanel;
    QuickRep1: TQuickRep;
    DetailBand1: TQRBand;
    QRShape7: TQRShape;
    QRShape6: TQRShape;
    QRShape5: TQRShape;
    QRShape19: TQRShape;
    QRShape18: TQRShape;
    QRShape17: TQRShape;
    QRShape16: TQRShape;
    QRShape15: TQRShape;
    QRDBText2: TQRDBText;
    QRDBText1: TQRDBText;
    PageHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRLabel3: TQRLabel;
    QRShape8: TQRShape;
    QRLabel4: TQRLabel;
    QRShape9: TQRShape;
    QRLabel5: TQRLabel;
    QRShape10: TQRShape;
    QRLabel6: TQRLabel;
    QRShape11: TQRShape;
    QRLabel7: TQRLabel;
    QRShape12: TQRShape;
    QRLabel2: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel9: TQRLabel;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QRLabel11: TQRLabel;
    QRShape22: TQRShape;
    QRLabel12: TQRLabel;
    QRShape23: TQRShape;
    QRLabel13: TQRLabel;
    QRShape24: TQRShape;
    QRShape25: TQRShape;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    dbgrd1: TDBGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RzDateTimeEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure RzDateTimeEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure Button3Click(Sender: TObject);
    procedure dbgrd1CellClick(Column: TColumn);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    function MaxDate(Y, M: String): String;
    { Public declarations }
  end;

var
  Fr_ChuKuMingXi: TFr_ChuKuMingXi;

implementation

uses Unit1;

{$R *.dfm}

{出库明细}
procedure TFr_ChuKuMingXi.Button1Click(Sender: TObject);
var
  Y,M,D:String;
begin
  Y:=FormatdateTime('yyyy', Now);
  M:=FormatdateTime('mm', Now);
  D:=FormatdateTime('dd', Now);
  if RadioButton1.Checked then begin
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('select * from sell_main,sell_minor '+
                      'where sell_main.InvoiceID=sell_minor.InvoiceID '+
                      'and sell_main.SellDate >=:A and sell_main.SellDate <=:B '+
                      'and sell_main.Hang Order By sell_minor.InvoiceID');
    ADOQuery1.Parameters.ParamByName('A').Value:=Y+'-'+M+'-'+D+' 00:00:00';
    ADOQuery1.Parameters.ParamByName('B').Value:=Y+'-'+M+'-'+D+' 23:59:59';
    ADOQuery1.Open;
    if ADOQuery1.RecordCount=0 then
      ShowMessage('当天还没有销售商品~~!');
    QRLabel10.Caption:=FormatdateTime('yyyy-mm-dd', Now)+'出库明细表　统计时间:'+FormatdateTime('hh:mm:ss', Now);
  end;

  if RadioButton2.Checked then begin
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('select * from Sell_Main,Sell_Minor '+
                      'where Sell_Main.InvoiceID=Sell_Minor.InvoiceID '+
                      'and Sell_Main.SellDate >=:A and Sell_Main.SellDate <=:B '+
                      'and Sell_Main.Hang Order By Sell_Minor.InvoiceID');
    ADOQuery1.Parameters.ParamByName('A').Value:=Y+'-'+M+'-01'+' 00:00:00';
    ADOQuery1.Parameters.ParamByName('B').Value:=Y+'-'+M+'-'+MaxDate(Y,M)+' 23:59:59';
    ADOQuery1.Open;
    if ADOQuery1.RecordCount=0 then
      ShowMessage('当月还没有销售商品~~!');
    QRLabel10.Caption:='全月出库明细表　统计时间:'+FormatdateTime('yyyy-mm-dd hh:mm:ss', Now);
  end;

  if RadioButton3.Checked then begin
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('select * from sell_main,sell_minor '+
                      'where sell_main.InvoiceID=sell_minor.InvoiceID '+
                      'and sell_main.Hang Order By sell_minor.InvoiceID');
    ADOQuery1.Open;
    if ADOQuery1.RecordCount=0 then
      ShowMessage('请在前台销售商品后在此查询~~!');
    QRLabel10.Caption:='累计出库明细表　统计时间:'+FormatdateTime('yyyy-mm-dd hh:mm:ss', Now);
  end;

  if RadioButton4.Checked then begin
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('select * from sell_main,sell_minor '+
                      'where sell_main.InvoiceID=sell_minor.InvoiceID '+
                      'and sell_main.SellDate >=:A and sell_main.SellDate <=:B '+
                      'and sell_main.Hang Order By sell_minor.InvoiceID');
    ADOQuery1.Parameters.ParamByName('A').Value:=RzDateTimeEdit1.Text+' 00:00:00';
    ADOQuery1.Parameters.ParamByName('B').Value:=RzDateTimeEdit2.Text+' 23:59:59';
    ADOQuery1.Open;
    if ADOQuery1.RecordCount=0 then
      ShowMessage('您选择的日期范围内没有销售商品记录~~!');
    QRLabel10.Caption:=RzDateTimeEdit1.Text+'至'+RzDateTimeEdit2.Text+'出库明细表　统计时间:'+FormatdateTime('yyyy-mm-dd hh:mm:ss', Now);
  end;
end;

function TFr_ChuKuMingXi.MaxDate(Y, M: String): String;
begin
  if StrToInt(M)+1>12 then begin
    Y:=IntToStr(StrToInt(Y)+1);
    M:='1';
  end else
    M:=IntToStr(StrToInt(M)+1);
  result:=FormatdateTime('dd',EncodeDate(StrToInt(Y),StrToInt(M),1)-1)
end;



procedure TFr_ChuKuMingXi.FormShow(Sender: TObject);
begin
  RzDateTimeEdit1.Date:=StrToDate(FormatdateTime('yyyy-mm-dd', Now));
  RzDateTimeEdit2.Date:=StrToDate(FormatdateTime('yyyy-mm-dd', Now));
end;

procedure TFr_ChuKuMingXi.RzDateTimeEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#13 then begin
    RzDateTimeEdit2.SetFocus;
    RzDateTimeEdit2.SelectAll;
  end;
end;

procedure TFr_ChuKuMingXi.RzDateTimeEdit2KeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#13 then begin
    RzDateTimeEdit1.SetFocus;
    RzDateTimeEdit1.SelectAll;
  end;
end;

procedure TFr_ChuKuMingXi.Button3Click(Sender: TObject);
begin
  Fr_ChuKuMingXi.Close;
end;

procedure TFr_ChuKuMingXi.dbgrd1CellClick(Column: TColumn);
var
  i:Integer;
  c:Currency;
begin
  if ADOQuery1.Active=False then
    Exit;
  if ADOQuery1.RecordCount=0 then begin
    Label5.Caption:='列表数量:';
    Label6.Caption:='';
    Exit;
  end;
  i:=ADOQuery1.RecNo;
  c:=0;
  Label6.Caption:=ADOQuery1.FieldByName('GoodsName').AsString;
  DataSource1.Enabled:=False;
  ADOQuery1.First;
  while not(ADOQuery1.Eof) do begin
    if ADOQuery1.FieldByName('GoodsName').AsString=Label6.Caption then
      c:=c+ADOQuery1.FieldByName('SellScalar').AsCurrency;
    ADOQuery1.Next;
  end;
  ADOQuery1.RecNo:=i;
  DataSource1.Enabled:=True;
  Label5.Caption:='列表数量:'+CurrToStr(c)+ADOQuery1.FieldByName('Unit').AsString;
end;

procedure TFr_ChuKuMingXi.Button2Click(Sender: TObject);
begin
  QuickRep1.Print;
end;

end.
