unit Unit13;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, RzEdit, Grids, DBGrids, DB, ADODB;

type
  TFr_JinHouTongJi = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Panel6: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Panel5: TPanel;
    Panel3: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Panel4: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    RzDateTimeEdit1: TRzDateTimeEdit;
    RzDateTimeEdit2: TRzDateTimeEdit;
    Panel7: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    dbgrd1: TDBGrid;
    procedure Button1Click(Sender: TObject);
    procedure dbgrd1CellClick(Column: TColumn);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_JinHouTongJi: TFr_JinHouTongJi;

implementation

uses Unit11, Unit1;

{$R *.dfm}

procedure TFr_JinHouTongJi.Button1Click(Sender: TObject);
var
  Y,M,D:String;
begin
  Y:=FormatdateTime('yyyy', Now);
  M:=FormatdateTime('mm', Now);
  D:=FormatdateTime('dd', Now);
  if RadioButton1.Checked then begin
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('select * from purchase '+
                      'where PurchaseDate >=:A and PurchaseDate <=:B');
    ADOQuery1.Parameters.ParamByName('A').Value:=Y+'-'+M+'-'+D+' 00:00:00';
    ADOQuery1.Parameters.ParamByName('B').Value:=Y+'-'+M+'-'+D+' 23:59:59';
    ADOQuery1.Open;
    if ADOQuery1.RecordCount=0 then
      ShowMessage('当天还没有商品进货记录~~!');
  end;

  if RadioButton2.Checked then begin
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('select * from purchase '+
                      'where PurchaseDate >=:A and PurchaseDate <=:B');
    ADOQuery1.Parameters.ParamByName('A').Value:=Y+'-'+M+'-01'+' 00:00:00';
    ADOQuery1.Parameters.ParamByName('B').Value:=Y+'-'+M+'-'+Fr_ChuKuMingXi.MaxDate(Y,M)+' 23:59:59';
    ADOQuery1.Open;
    if ADOQuery1.RecordCount=0 then
      ShowMessage('当月还没有商品进货记录~~!');
  end;

  if RadioButton3.Checked then begin
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('select * from purchase');
    ADOQuery1.Open;
    if ADOQuery1.RecordCount=0 then
      ShowMessage('您没有商品进货记录~~!');
  end;

  if RadioButton4.Checked then begin
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('select * from purchase '+
                      'where PurchaseDate >=:A and PurchaseDate <=:B');
    ADOQuery1.Parameters.ParamByName('A').Value:=RzDateTimeEdit1.Text+' 00:00:00';
    ADOQuery1.Parameters.ParamByName('B').Value:=RzDateTimeEdit2.Text+' 23:59:59';
    ADOQuery1.Open;
    if ADOQuery1.RecordCount=0 then
      ShowMessage('您选择的日期范围内没有商品进货记录~~!');
  end;
end;

procedure TFr_JinHouTongJi.dbgrd1CellClick(Column: TColumn);
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
      c:=c+ADOQuery1.FieldByName('PurchaseScalar').AsCurrency;
    ADOQuery1.Next;
  end;
  ADOQuery1.RecNo:=i;
  DataSource1.Enabled:=True;
  Label5.Caption:='列表数量:'+CurrToStr(c)+ADOQuery1.FieldByName('Unit').AsString;
end;

procedure TFr_JinHouTongJi.Button3Click(Sender: TObject);
begin
  Fr_JinHouTongJi.Close;
end;

procedure TFr_JinHouTongJi.FormShow(Sender: TObject);
begin
  RzDateTimeEdit1.Date:=StrToDate(FormatdateTime('yyyy-mm-dd', Now));
  RzDateTimeEdit2.Date:=StrToDate(FormatdateTime('yyyy-mm-dd', Now));
end;

end.
