unit Unit25;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, ADODB, Grids, DBGrids;

type
  TFr_BankCard = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_BankCard: TFr_BankCard;

implementation

uses Unit1;

{$R *.dfm}

procedure TFr_BankCard.DBGrid1DblClick(Sender: TObject);
begin
  Fr_BankCard.Close;
end;

procedure TFr_BankCard.FormShow(Sender: TObject);
begin
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from bankcard');
  ADOQuery1.Open;
end;

procedure TFr_BankCard.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then begin
    Fr_BankCard.Close;
  end;
end;

end.
