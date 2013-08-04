unit Unit10;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, StdCtrls, ComCtrls, Mask, RzEdit,
  Gauges, DB, ADODB, QRCtrls, QuickRpt, INIFiles;

type
  TFr_MXSP = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    RzDateTimeEdit1: TRzDateTimeEdit;
    RzDateTimeEdit2: TRzDateTimeEdit;
    Panel5: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Panel6: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Panel7: TPanel;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    Gauge1: TGauge;
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Panel8: TPanel;
    QuickRep1: TQuickRep;
    DetailBand1: TQRBand;
    QRShape6: TQRShape;
    QRShape5: TQRShape;
    QRShape4: TQRShape;
    PageHeaderBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRShape1: TQRShape;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRShape3: TQRShape;
    SummaryBand1: TQRBand;
    QRShape7: TQRShape;
    QRSysData1: TQRSysData;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRExpr1: TQRExpr;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_MXSP: TFr_MXSP;

implementation

uses Unit1, Unit11;

{$R *.dfm}

procedure TFr_MXSP.FormCreate(Sender: TObject);
begin
  Gauge1.Progress:=100;

end;

procedure TFr_MXSP.Button1Click(Sender: TObject);
var
  Y,M,D : String;
  s     : String;
begin
  Y:=FormatdateTime('yyyy', Now);
  M:=FormatdateTime('mm', Now);
  D:=FormatdateTime('dd', Now);
  //清空明星商品
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Delete from mxsp');
  ADOQuery1.ExecSQL;
  //按日期查询主销售库数据
  ADOQuery1.SQL.Clear;

  //判断是否为全部商品统计或分日期统计
  if RadioButton3.Checked then begin
    s:='Select GoodsName,Min(BarCode) as BarCode,Sum(SellScalar) as SellScalar,'+
       'Sum(PurchasePrice) as PurchasePrice,Sum(Subtotal) as SellPrice,'+
       'Min(Gift) as Gift,Min(UntreadFlag) as UntreadFlag,Min(Unit) as Unit '+
       'from Sell_Minor Group BY GoodsName,Gift Order BY Min(BarCode)';

    QRLabel4.Caption:='所有出库商品统计,时间截止';
    QRLabel7.Caption:='至'+Y+'-'+M+'-'+D+' '+FormatdateTime('tt', Now);
  end else
    s:='Select GoodsName,Min(BarCode) as BarCode,Sum(SellScalar) as SellScalar,'+
       'Sum(PurchasePrice) as PurchasePrice,Sum(Subtotal) as SellPrice,'+
       'Min(Gift) as Gift,Min(UntreadFlag) as UntreadFlag,Min(Unit) as Unit '+
       'from Sell_Main,Sell_Minor where Sell_Main.InvoiceID=Sell_Minor.InvoiceID '+
       'and Sell_Main.SellDate >=:A and Sell_Main.SellDate <=:B '+
       'and Sell_Main.Hang Group BY GoodsName,Gift Order BY Min(BarCode)';

  ADOQuery1.SQL.Add(s);
  //当天进货查询
  if RadioButton1.Checked then begin
    ADOQuery1.Parameters.ParamByName('A').Value:=Y+'-'+M+'-'+D+' 00:00:00';
    ADOQuery1.Parameters.ParamByName('B').Value:=Y+'-'+M+'-'+D+' 23:59:59';
    QRLabel4.Caption:='从'+Y+'-'+M+'-'+D+' 00:00:00';
    QRLabel7.Caption:='至'+Y+'-'+M+'-'+D+' '+FormatdateTime('tt', Now);
  end;

  //当月进货查询
  if RadioButton2.Checked then begin
    ADOQuery1.Parameters.ParamByName('A').Value:=Y+'-'+M+'-01'+' 00:00:00';
    ADOQuery1.Parameters.ParamByName('B').Value:=Y+'-'+M+'-'+Fr_ChuKuMingXi.MaxDate(Y,M)+' 23:59:59';
    QRLabel4.Caption:='从'+Y+'-'+M+'-01'+' 00:00:00';
    QRLabel7.Caption:='至'+Y+'-'+M+'-'+Fr_ChuKuMingXi.MaxDate(Y,M)+' '+FormatdateTime('tt', Now);
  end;

  //指定日期查询
  if RadioButton4.Checked then begin
    ADOQuery1.Parameters.ParamByName('A').Value:=RzDateTimeEdit1.Text+' 00:00:00';
    ADOQuery1.Parameters.ParamByName('B').Value:=RzDateTimeEdit2.Text+' 23:59:59';
    QRLabel4.Caption:='从'+RzDateTimeEdit1.Text+' 00:00:00';
    QRLabel7.Caption:='至'+RzDateTimeEdit2.Text+' '+FormatdateTime('tt', Now);
  end;

  //开始查询数据
  ADOQuery1.Open;

  ADOQuery2.SQL.Clear;
  ADOQuery2.SQL.Add('Select * from mxsp');
  ADOQuery2.Open;
  ADOQuery1.First;
  while not(ADOQuery1.Eof) do begin
    ADOQuery2.Append;
    ADOQuery2.FieldByName('BarCode').AsString:=
    ADOQuery1.FieldByName('BarCode').AsString;
    ADOQuery2.FieldByName('GoodsName').AsString:=
    ADOQuery1.FieldByName('GoodsName').AsString;
    ADOQuery2.FieldByName('SellScalar').AsString:=
    ADOQuery1.FieldByName('SellScalar').AsString;
    ADOQuery2.FieldByName('PurchasePrice').AsString:=
    ADOQuery1.FieldByName('PurchasePrice').AsString;
    ADOQuery2.FieldByName('SellPrice').AsString:=
    ADOQuery1.FieldByName('SellPrice').AsString;
    ADOQuery2.FieldByName('Gift').AsString:=
    ADOQuery1.FieldByName('Gift').AsString;
    ADOQuery2.FieldByName('UntreadFlag').AsString:=
    ADOQuery1.FieldByName('UntreadFlag').AsString;
    ADOQuery2.FieldByName('Unit').AsString:=
    ADOQuery1.FieldByName('Unit').AsString;
    ADOQuery2.Post;
    ADOQuery1.Next;
  end;
end;

procedure TFr_MXSP.FormShow(Sender: TObject);
begin
  RzDateTimeEdit1.Date:=StrToDate(FormatdateTime('yyyy-mm-dd', Now));
  RzDateTimeEdit2.Date:=StrToDate(FormatdateTime('yyyy-mm-dd', Now));
end;

procedure TFr_MXSP.Button3Click(Sender: TObject);
begin
  Fr_MXSP.Close;
end;

procedure TFr_MXSP.Button2Click(Sender: TObject);
var
  vIniFile: TIniFile;
  i:integer;
  S:String;
begin
  vIniFile:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'Config.Ini');
  i:=0;
  while ADOQuery2.RecordCount<>0 do begin
    ADOQuery2.SQL.Clear;
    if i=0 then
      //S:='Select Top 50 * from mxsp'
      S:='Select * from mxsp limit 0,50'
    else
      S:='Select * from mxsp limit 0,50';

      {S:='Select Top 50 * from mxsp Where (ID NOT IN (Select Top '+
         CurrToStr(50*i)+' ID From mxsp))';}
    ADOQuery2.SQL.Add(S);
    ADOQuery2.Open;
    if ADOQuery2.RecordCount<>0 then begin
      if messagedlg('确认打印吗？',mtconfirmation,[mbyes,mbno],0)=mryes then begin
        QRLabel8.Caption:='第'+IntToStr(i+1)+'页';
        QuickRep1.ReportTitle:='出库明细表－第'+IntToStr(i+1)+'页';
        QuickRep1.Height:=200+DetailBand1.Height*ADOQuery2.RecordCount;
        QuickRep1.Page.LeftMargin:=vIniFile.ReadInteger('System','P02',0);
        QuickRep1.Preview;
      end else
        Exit;
    end;
    i:=i+1;
  end;
end;

end.
