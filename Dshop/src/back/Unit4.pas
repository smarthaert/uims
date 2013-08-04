unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, RzEdit, DB, ADODB;

type
  TFr_Stock_Add = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Panel4: TPanel;
    RzEdit1: TRzEdit;
    RzEdit2: TRzEdit;
    RzEdit3: TRzEdit;
    RzEdit4: TRzEdit;
    RzEdit5: TRzEdit;
    RzEdit6: TRzEdit;
    RzEdit7: TRzEdit;
    RzEdit8: TRzEdit;
    RzEdit9: TRzEdit;
    Button1: TButton;
    Button2: TButton;
    ADOQuery1: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_Stock_Add: TFr_Stock_Add;

implementation

uses Unit9, Unit1;

{$R *.dfm}

procedure TFr_Stock_Add.FormShow(Sender: TObject);
begin
  RzEdit1.Text:=Fr_Stock.ADOQuery1.FieldByName('BarCode').AsString;
  RzEdit2.Text:=Fr_Stock.ADOQuery1.FieldByName('GoodsName').AsString;
  RzEdit3.Text:=Fr_Stock.ADOQuery1.FieldByName('PurchasePrice').AsString;
  RzEdit4.Text:=Fr_Stock.ADOQuery1.FieldByName('PurchaseScalar').AsString;

  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from stock Where BarCode="'+RzEdit1.Text+'"');
  ADOQuery1.Open;
  if ADOQuery1.RecordCount<>0 then begin
    RzEdit5.Text:=ADOQuery1.FieldByName('SellPrice').AsString;
    RzEdit6.Text:=ADOQuery1.FieldByName('Agio').AsString;
    RzEdit7.Text:=ADOQuery1.FieldByName('StockBaseline').AsString;
    RzEdit8.Text:=ADOQuery1.FieldByName('UntreadDate').AsString;
    RzEdit9.Text:=ADOQuery1.FieldByName('PYBrevity').AsString;
    Button1.SetFocus;
  end else begin
    RzEdit5.Text:='';
    RzEdit6.Text:='100';
    RzEdit7.Text:='10';
    RzEdit8.Text:='3';
    RzEdit9.Text:='';
    RzEdit5.SetFocus;
  end;
end;

procedure TFr_Stock_Add.Button1Click(Sender: TObject);
begin
  if RzEdit5.Text='' then begin
    ShowMessage('出售价格不能为空~~!'+#10#10+'请重新输入~~!');
    RzEdit5.SetFocus;
    Exit;
  end;

  if RzEdit6.Text='' then begin
    ShowMessage('最大折扣不能为空~~!'+#10#10+'请重新输入~~!');
    RzEdit6.SetFocus;
    Exit;
  end;
  if RzEdit7.Text='' then begin
    ShowMessage('库存底线不能为空~~!'+#10#10+'请重新输入~~!');
    RzEdit7.SetFocus;
    Exit;
  end;
  if RzEdit8.Text='' then begin
    ShowMessage('退货期限不能为空~~!'+#10#10+'请重新输入~~!');
    RzEdit8.SetFocus;
    Exit;
  end;
  //数据类型检查
  Try
    StrToCurr(RzEdit5.Text);
  Except
    ShowMessage('出售价格类型非法~~!'+#10#10+'请重新输入~~!');
    RzEdit5.Text:='';
    RzEdit5.SetFocus;
    Exit;
  end;
  Try
    StrToCurr(RzEdit7.Text);
  Except
    ShowMessage('库存底线类型非法~~!'+#10#10+'请重新输入~~!');
    RzEdit7.Text:='';
    RzEdit7.SetFocus;
    Exit;
  end;
  //系统提示
  if StrToCurr(RzEdit3.Text)>StrToCurr(RzEdit5.Text) then
  begin
    if messagedlg('销售价格低于进价是否继续？',mtconfirmation,[mbyes,mbno],0)=mrno then
      Exit;
  end;
  //填加库存
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from stock Where BarCode="'+RzEdit1.Text+'"');
  ADOQuery1.Open;
  if ADOQuery1.RecordCount=0 then
  begin
    //如果库存中没有此商品则填加
    ADOQuery1.Append;
    ADOQuery1.Edit;
    ADOQuery1.FieldByName('BarCode').AsString:=RzEdit1.Text;
    ADOQuery1.FieldByName('GoodsName').AsString:=RzEdit2.Text;
    ADOQuery1.FieldByName('PYBrevity').AsString:=RzEdit9.Text;
    ADOQuery1.FieldByName('Unit').AsString:=Fr_Stock.ADOQuery1.FieldByName('Unit').AsString;
    ADOQuery1.FieldByName('PurchasePrice').AsString:=RzEdit3.Text;
    ADOQuery1.FieldByName('SellPrice').AsString:=RzEdit5.Text;
    ADOQuery1.FieldByName('StockScalar').AsString:=RzEdit4.Text;
    ADOQuery1.FieldByName('Agio').AsString:=RzEdit6.Text;
    ADOQuery1.FieldByName('StockBaseline').AsString:=RzEdit7.Text;
    ADOQuery1.FieldByName('UntreadDate').AsString:=RzEdit8.Text;
    ADOQuery1.Post;
    ADOQuery1.Refresh;
    Fr_Stock.ADOQuery1.Edit;
    Fr_Stock.ADOQuery1.FieldByName('EnterFiag').AsString:='1';
    Fr_Stock.ADOQuery1.Post;
    Fr_Stock.ADOQuery1.Refresh;
  end
  else
  begin
    //如果商品已存在
    //用加权平均法计算进价
    ADOQuery1.Edit;
    ADOQuery1.FieldByName('PurchasePrice').AsCurrency:=(ADOQuery1.FieldByName('PurchasePrice').AsCurrency *
                                                        ADOQuery1.FieldByName('StockScalar').AsCurrency +
                                               Fr_STock.ADOQuery1.FieldByName('PurchasePrice').AsCurrency *
                                               Fr_STock.ADOQuery1.FieldByName('purchaseScalar').AsCurrency )/
                                                       (ADOQuery1.FieldByName('StockScalar').AsCurrency +
                                               Fr_STock.ADOQuery1.FieldByName('purchaseScalar').AsCurrency);
    //增加商品数量
    ADOQuery1.FieldByName('StockScalar').AsCurrency:=ADOQuery1.FieldByName('StockScalar').AsCurrency+
                                            Fr_Stock.ADOQuery1.FieldByName('purchaseScalar').AsCurrency;
    ADOQuery1.FieldByName('GoodsName').AsString:=RzEdit2.Text;
    ADOQuery1.FieldByName('PYBrevity').AsString:=RzEdit9.Text;
    ADOQuery1.FieldByName('Unit').AsString:=Fr_Stock.ADOQuery1.FieldByName('Unit').AsString;
    ADOQuery1.FieldByName('SellPrice').AsString:=RzEdit5.Text;
    ADOQuery1.FieldByName('Agio').AsString:=RzEdit6.Text;
    ADOQuery1.FieldByName('StockBaseline').AsString:=RzEdit7.Text;
    ADOQuery1.FieldByName('UntreadDate').AsString:=RzEdit8.Text;
    ADOQuery1.Post;
    ADOQuery1.Refresh;
    Fr_Stock.ADOQuery1.Edit;
    Fr_Stock.ADOQuery1.FieldByName('EnterFiag').AsString:='1';
    Fr_Stock.ADOQuery1.Post;
    Fr_Stock.ADOQuery1.Refresh;
  end;
  //刷新数据
  Fr_Stock.ADOQuery1.Close;
  Fr_Stock.ADOQuery1.SQL.Clear;
  Fr_Stock.ADOQuery1.SQL.Add('Select * From purchase Where Not(EnterFiag)');
  Fr_Stock.ADOQuery1.Open;
  Fr_Stock_Add.Close;
end;

procedure TFr_Stock_Add.Button2Click(Sender: TObject);
begin
  Fr_Stock_Add.Close;
end;

end.
