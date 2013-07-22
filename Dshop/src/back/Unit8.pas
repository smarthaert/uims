unit Unit8;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, ADODB, Grids, DBGrids;

type
  TFr_S_Feeder = class(TForm)
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
  Fr_S_Feeder: TFr_S_Feeder;

implementation

uses Unit1;

{$R *.dfm}

procedure TFr_S_Feeder.DBGrid1DblClick(Sender: TObject);
begin
  Fr_S_FeeDer.Close;
end;

procedure TFr_S_Feeder.FormShow(Sender: TObject);
begin
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from Feeder');
  ADOQuery1.Open;
end;

procedure TFr_S_Feeder.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then begin
    Fr_S_FeeDer.Close;
  end;
end;

end.
