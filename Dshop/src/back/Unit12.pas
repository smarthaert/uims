unit Unit12;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, RzEdit, Grids, DBGrids, ExtCtrls, DB, ADODB,
  QRCtrls, QuickRpt;

type
  TFr_MaoLiFenXi = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Panel6: TPanel;
    Panel5: TPanel;
    Panel7: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    Panel3: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Panel4: TPanel;
    Label2: TLabel;
    Label7: TLabel;
    RzDateTimeEdit1: TRzDateTimeEdit;
    RzDateTimeEdit2: TRzDateTimeEdit;
    ADOQuery2: TADOQuery;
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
    QRShape21: TQRShape;
    QRShape24: TQRShape;
    QRShape25: TQRShape;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
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
    QRLabel11: TQRLabel;
    QRShape22: TQRShape;
    QRLabel12: TQRLabel;
    QRShape23: TQRShape;
    QRLabel13: TQRLabel;
    SummaryBand1: TQRBand;
    QRShape13: TQRShape;
    QRLabel8: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    dbgrd1: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure dbgrd1DblClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_MaoLiFenXi: TFr_MaoLiFenXi;

implementation

uses Unit1, Unit11;

{$R *.dfm}

procedure TFr_MaoLiFenXi.FormShow(Sender: TObject);
begin
  RzDateTimeEdit1.Date:=StrToDate(FormatdateTime('yyyy-mm-dd', Now));
  RzDateTimeEdit2.Date:=StrToDate(FormatdateTime('yyyy-mm-dd', Now));
end;

procedure TFr_MaoLiFenXi.Button1Click(Sender: TObject);
var
  Y,M,D,ID : String;
  i        : Integer;
  c1,c2,c3 : Currency;
begin
  Y:=FormatdateTime('yyyy', Now);
  M:=FormatdateTime('mm', Now);
  D:=FormatdateTime('dd', Now);
  if RadioButton1.Checked then begin
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('select * from Sell_Main,Sell_Minor '+
                      'where Sell_Main.InvoiceID=Sell_Minor.InvoiceID '+
                      'and Sell_Main.SellDate >=:A and Sell_Main.SellDate <=:B '+
                      'and Sell_Main.Hang Order By Sell_Minor.InvoiceID');
    ADOQuery1.Parameters.ParamByName('A').Value:=Y+'-'+M+'-'+D+' 00:00:00';
    ADOQuery1.Parameters.ParamByName('B').Value:=Y+'-'+M+'-'+D+' 23:59:59';
    ADOQuery1.Open;

    ADOQuery2.SQL.Clear;
    ADOQuery2.SQL.Add('select * from Sell_Main where '+
                      'SellDate >=:A and SellDate <=:B and Hang');
    ADOQuery2.Parameters.ParamByName('A').Value:=Y+'-'+M+'-'+D+' 00:00:00';
    ADOQuery2.Parameters.ParamByName('B').Value:=Y+'-'+M+'-'+D+' 23:59:59';
    ADOQuery2.Open;

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
    ADOQuery1.Parameters.ParamByName('B').Value:=Y+'-'+M+'-'+Fr_ChuKuMingXi.MaxDate(Y,M)+' 23:59:59';
    ADOQuery1.Open;

    ADOQuery2.SQL.Clear;
    ADOQuery2.SQL.Add('select * from Sell_Main where '+
                      'SellDate >=:A and SellDate <=:B and Hang');
    ADOQuery2.Parameters.ParamByName('A').Value:=Y+'-'+M+'-01'+' 00:00:00';
    ADOQuery2.Parameters.ParamByName('B').Value:=Y+'-'+M+'-'+Fr_ChuKuMingXi.MaxDate(Y,M)+' 23:59:59';
    ADOQuery2.Open;

    if ADOQuery1.RecordCount=0 then
      ShowMessage('当月还没有销售商品~~!');
    QRLabel10.Caption:='全月出库明细表　统计时间:'+FormatdateTime('yyyy-mm-dd hh:mm:ss', Now);
  end;

  if RadioButton3.Checked then begin
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('select * from Sell_Main,Sell_Minor '+
                      'where Sell_Main.InvoiceID=Sell_Minor.InvoiceID '+
                      'and Sell_Main.Hang Order By Sell_Minor.InvoiceID');
    ADOQuery1.Open;

    ADOQuery2.SQL.Clear;
    ADOQuery2.SQL.Add('select * from Sell_Main where Hang');
    ADOQuery2.Open;

    if ADOQuery1.RecordCount=0 then
      ShowMessage('请在前台销售商品后在此查询~~!');
    QRLabel10.Caption:='累计出库明细表　统计时间:'+FormatdateTime('yyyy-mm-dd hh:mm:ss', Now);
  end;

  if RadioButton4.Checked then begin
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('select * from Sell_Main,Sell_Minor where '+
                      'Sell_Main.InvoiceID=Sell_Minor.InvoiceID '+
                      'and Sell_Main.SellDate >=:A and Sell_Main.SellDate <=:B '+
                      'and Sell_Main.Hang Order By Sell_Minor.InvoiceID');
    ADOQuery1.Parameters.ParamByName('A').Value:=RzDateTimeEdit1.Text+' 00:00:00';
    ADOQuery1.Parameters.ParamByName('B').Value:=RzDateTimeEdit2.Text+' 23:59:59';
    ADOQuery1.Open;

    ADOQuery2.SQL.Clear;
    ADOQuery2.SQL.Add('select * from Sell_Main Where '+
                      'SellDate >=:A and SellDate <=:B and Hang');
    ADOQuery2.Parameters.ParamByName('A').Value:=RzDateTimeEdit1.Text+' 00:00:00';
    ADOQuery2.Parameters.ParamByName('B').Value:=RzDateTimeEdit2.Text+' 23:59:59';
    ADOQuery2.Open;

    if ADOQuery1.RecordCount=0 then
      ShowMessage('您选择的日期范围内没有销售商品记录~~!');
    QRLabel10.Caption:=RzDateTimeEdit1.Text+'至'+RzDateTimeEdit2.Text+'出库明细表　统计时间:'+FormatdateTime('yyyy-mm-dd hh:mm:ss', Now);
  end;

  //填报告
  c1:=0;
  c2:=0;
  c3:=0;
  ID:='';
  i:=ADOQuery1.RecNo;
  DataSource1.Enabled:=False;
  ADOQuery1.First;
  while not(ADOQuery1.Eof) do begin
    c1:=c1+ADOQuery1.FieldByName('SellScalar').AsCurrency;
    c2:=c2+ADOQuery1.FieldByName('PurchasePrice').AsCurrency*ADOQuery1.FieldByName('SellScalar').AsCurrency;
    if ID<>ADOQuery1.FieldByName('InvoiceID').AsString then begin
      c3:=c3+ADOQuery1.FieldByName('PU').AsCurrency;
      ID:=ADOQuery1.FieldByName('InvoiceID').AsString;
    end;
    ID:=ADOQuery1.FieldByName('InvoiceID').AsString;
    ADOQuery1.Next;
  end;

  ADOQuery1.RecNo:=i;
  Label3.Caption:='商品件数:'+CurrToStr(c1)+'件';
  Label4.Caption:='进货成本:'+FormatFloat('0.00',c2)+'元';
  Label5.Caption:='实收金额:'+FormatFloat('0.00',c3)+'元';
  Label6.Caption:='毛利金额:'+FormatFloat('0.00',c3-c2)+'元';
  QRLabel8.Caption := Label3.Caption;
  QRLabel14.Caption:= Label4.Caption;
  QRLabel15.Caption:= Label5.Caption;
  QRLabel16.Caption:= Label6.Caption;
  DataSource1.Enabled:=True;
end;

procedure TFr_MaoLiFenXi.Button3Click(Sender: TObject);
begin
  Fr_MaoLiFenXi.Close;
end;

procedure TFr_MaoLiFenXi.dbgrd1DblClick(Sender: TObject);
//var
//  i        : Integer;
//  c1,c2,c3 : Currency;
//  s1,s2    : String;
begin
{  c1:=0;
  c2:=0;
  c3:=0;
  s1:=ADOQuery1.FieldByName('GoodsName').AsString;
  s2:='';
  i:=ADOQuery1.RecNo;
  DataSource1.Enabled:=False;
  ADOQuery1.First;
  while not(ADOQuery1.Eof) do begin
    if ADOQuery1.FieldByName('GoodsName').AsString=s1 then begin
      c1:=c1+ADOQuery1.FieldByName('SellScalar').AsCurrency;
      c2:=c2+ADOQuery1.FieldByName('PurchasePrice').AsCurrency*ADOQuery1.FieldByName('SellScalar').AsCurrency;
    end;
    ShowMessage(s2+#10#13+ADOQuery1.FieldByName('Sell_Main.InvoiceID').AsString);

    if s2<>ADOQuery1.FieldByName('Sell_Main.InvoiceID').AsString then begin
      s2:=ADOQuery1.FieldByName('Sell_Main.InvoiceID').AsString;
      ShowMessage('+');
      ADOQuery2.SQL.Clear;
      ADOQuery2.SQL.Add('Select * from Sell_Main where InvoiceID="'+ADOQuery1.FieldByName('Sell_Main.InvoiceID').AsString+'"');
      ADOQuery2.Open;
      c3:=c3+ADOQuery2.FieldByName('PU').AsCurrency;
    end;
//    s2:=ADOQuery1.FieldByName('Sell_Main.InvoiceID').AsString;
    ADOQuery1.Next;
  end;



  ADOQuery1.RecNo:=i;
  Label3.Caption:='商品件数:'+CurrToStr(c1)+'件';
  Label4.Caption:='进货成本:'+FormatFloat('0.00',c2)+'元';
  Label5.Caption:='实收金额:'+FormatFloat('0.00',c3)+'元';
  Label6.Caption:='毛利金额:'+FormatFloat('0.00',c3-c2)+'元';
  DataSource1.Enabled:=True;}
end;

procedure TFr_MaoLiFenXi.Button4Click(Sender: TObject);
begin
  QuickRep1.Preview;
end;

end.
