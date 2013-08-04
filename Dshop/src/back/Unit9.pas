unit Unit9;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, ADODB, StdCtrls, Grids, DBGrids;

type
  TFr_Stock = class(TForm)
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    DataSource1: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    Panel5: TPanel;
    Button1: TButton;
    Button2: TButton;
    dbgrd1: TDBGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgrd1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_Stock: TFr_Stock;

implementation

uses Unit1, Unit4;

{$R *.dfm}

procedure TFr_Stock.Button1Click(Sender: TObject);
begin
  if ADOQuery1.RecordCount=0 then begin
    ShowMessage('没有未入库商品~~!');
    Exit;
  end;
  if Fr_Stock_Add<>nil then
    Fr_Stock_Add.ShowModal
  else begin
    Fr_Stock_Add:=TFr_Stock_Add.Create(Application);
    Fr_Stock_Add.ShowModal;
  end;
end;

procedure TFr_Stock.Button2Click(Sender: TObject);
begin
  Fr_Stock.Close;
end;

procedure TFr_Stock.FormShow(Sender: TObject);
begin
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from purchase Where Not(EnterFiag)');
  ADOQuery1.Open;
end;

procedure TFr_Stock.dbgrd1DblClick(Sender: TObject);
begin
  Button1.Click;
end;

end.
