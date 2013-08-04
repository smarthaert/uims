unit Unit18;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, DB, ADODB, Menus;

type
  TFr_GJTH_1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_GJTH_1: TFr_GJTH_1;

implementation

uses Unit17;

{$R *.dfm}

procedure TFr_GJTH_1.FormShow(Sender: TObject);
begin
  Fr_GJTH.ADOQuery2.SQL.Clear;
  Fr_GJTH.ADOQuery2.SQL.Add('Select * from purchase Order By InvoiceID');
  Fr_GJTH.ADOQuery2.Open;
end;

procedure TFr_GJTH_1.DBGrid1DblClick(Sender: TObject);
begin
  Fr_GJTH.RzEdit1.Text:=Fr_GJTH.ADOQuery2.FieldByName('InvoiceID').AsString;
  Fr_GJTH.RzEdit3.Text:=Fr_GJTH.ADOQuery2.FieldByName('BarCode').AsString;
  Fr_GJTH.RzEdit4.Text:=Fr_GJTH.ADOQuery2.FieldByName('GoodsName').AsString;
  Fr_GJTH.RzEdit5.Text:=Fr_GJTH.ADOQuery2.FieldByName('FeederName').AsString;
  Fr_GJTH.RzEdit6.Text:=Fr_GJTH.ADOQuery2.FieldByName('Unit').AsString;
  Fr_GJTH.RzEdit7.Text:=Fr_GJTH.ADOQuery2.FieldByName('PurchaseScalar').AsString;
  Fr_GJTH.RzEdit8.Text:=Fr_GJTH.ADOQuery2.FieldByName('PurchasePrice').AsString;
  Fr_GJTH.RzEdit2.SetFocus;
  Fr_GJTH_1.Close;
end;

procedure TFr_GJTH_1.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then begin
    Fr_GJTH.RzEdit1.Text:=Fr_GJTH.ADOQuery2.FieldByName('InvoiceID').AsString;
    Fr_GJTH.RzEdit3.Text:=Fr_GJTH.ADOQuery2.FieldByName('BarCode').AsString;
    Fr_GJTH.RzEdit4.Text:=Fr_GJTH.ADOQuery2.FieldByName('GoodsName').AsString;
    Fr_GJTH.RzEdit5.Text:=Fr_GJTH.ADOQuery2.FieldByName('FeederName').AsString;
    Fr_GJTH.RzEdit6.Text:=Fr_GJTH.ADOQuery2.FieldByName('Unit').AsString;
    Fr_GJTH.RzEdit7.Text:=Fr_GJTH.ADOQuery2.FieldByName('PurchaseScalar').AsString;
    Fr_GJTH.RzEdit8.Text:=Fr_GJTH.ADOQuery2.FieldByName('PurchasePrice').AsString;
    Fr_GJTH.RzEdit2.SetFocus;
    Fr_GJTH_1.Close;
  end;
end;

end.
