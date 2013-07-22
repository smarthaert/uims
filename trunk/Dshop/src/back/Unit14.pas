unit Unit14;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, RzEdit, DB, ADODB;

type
  TFr_KuCunPanDian = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Bevel2: TBevel;
    Bevel1: TBevel;
    Panel4: TPanel;
    Label5: TLabel;
    Panel5: TPanel;
    Label6: TLabel;
    RzEdit1: TRzEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ADOQuery1: TADOQuery;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure RzEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_KuCunPanDian: TFr_KuCunPanDian;

implementation

uses Unit1, Unit15;

{$R *.dfm}

procedure TFr_KuCunPanDian.Button1Click(Sender: TObject);
begin
  ADOQuery1.Next;
  Label2.Caption:=ADOQuery1.FieldByName('GoodsName').AsString;
  Label3.Caption:=ADOQuery1.FieldByName('StockScalar').AsString;
end;

procedure TFr_KuCunPanDian.FormShow(Sender: TObject);
begin
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from Stock');
  ADOQuery1.Open;
  Label2.Caption:=ADOQuery1.FieldByName('GoodsName').AsString;
  Label3.Caption:=ADOQuery1.FieldByName('StockScalar').AsString;
end;

procedure TFr_KuCunPanDian.Button2Click(Sender: TObject);
begin
  ADOQuery1.First;
  Label2.Caption:=ADOQuery1.FieldByName('GoodsName').AsString;
  Label3.Caption:=ADOQuery1.FieldByName('StockScalar').AsString;
end;

procedure TFr_KuCunPanDian.Button4Click(Sender: TObject);
begin
  Fr_KuCunPanDian.Close;
end;

procedure TFr_KuCunPanDian.RzEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#13 then begin
    //在库存中按条码查找商品
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('Select * from Stock where BarCode="'+RzEdit1.Text+'"');
    ADOQuery1.Open;
    if ADOQuery1.RecordCount<>0 then begin
      Label2.Caption:=ADOQuery1.FieldByName('GoodsName').AsString;
      Label3.Caption:=ADOQuery1.FieldByName('StockScalar').AsString;
      RzEdit1.Text:='';
    end else begin
      //如果按条码查找没有则按拼音查找
      ADOQuery1.SQL.Clear;
      ADOQuery1.SQL.Add('Select * from Stock where PYBrevity="'+RzEdit1.Text+'"');
      ADOQuery1.Open;
      if ADOQuery1.RecordCount<>0 then begin
        Label2.Caption:=ADOQuery1.FieldByName('GoodsName').AsString;
        Label3.Caption:=ADOQuery1.FieldByName('StockScalar').AsString;
        RzEdit1.Text:='';
      end else begin
        ShowMessage('没有找到符合条件的商品~~!');
        RzEdit1.Text:='';
      end;
    end;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('Select * from Stock');
    ADOQuery1.Open;
  end;
end;

procedure TFr_KuCunPanDian.Button3Click(Sender: TObject);
begin
  if Fr_KuCunPanDian_1<>nil then
    Fr_KuCunPanDian_1.ShowModal
  else begin
    Fr_KuCunPanDian_1:=TFr_KuCunPanDian_1.Create(Application);
    Fr_KuCunPanDian_1.ShowModal;
  end;
end;

end.
