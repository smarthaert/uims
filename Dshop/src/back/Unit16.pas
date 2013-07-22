unit Unit16;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, ADODB, StdCtrls, Grids, DBGrids;

type
  TFr_KuCunYuJing = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel5: TPanel;
    Button1: TButton;
    Button2: TButton;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    Label6: TLabel;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_KuCunYuJing: TFr_KuCunYuJing;

implementation

uses Unit1;

{$R *.dfm}

procedure TFr_KuCunYuJing.Button2Click(Sender: TObject);
begin
  Fr_KuCunYuJing.Close;
end;

procedure TFr_KuCunYuJing.FormShow(Sender: TObject);
begin
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from Stock where StockScalar<=StockBaseline');
  ADOQuery1.Open;
end;

procedure TFr_KuCunYuJing.FormActivate(Sender: TObject);
begin
  if ADOQuery1.RecordCount=0 then
    ShowMessage('没有低于库存底线商品~~!');
end;

end.
