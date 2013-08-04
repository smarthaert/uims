unit Unit10;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Buttons, Grids, DBGrids, ExtCtrls, INIFiles, StdCtrls;

type
  TQD = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    SpeedButton1: TSpeedButton;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    procedure c1;
    { Public declarations }
  end;

var
  QD: TQD;

implementation

uses Unit2;

{$R *.dfm}

procedure TQD.SpeedButton1Click(Sender: TObject);
begin
  QD.Close;
end;

procedure TQD.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE:SpeedButton1.Click;
    VK_SPACE :SpeedButton2.Click;

    VK_UP:
    begin
      DBGrid1.SetFocus;
    end;

    VK_DOWN:
    begin
      DBGrid1.SetFocus;
    end;
  end;
end;

procedure TQD.SpeedButton2Click(Sender: TObject);
begin
  Main.Label26.Caption:=ADOQuery1.FieldByName('InvoiceID').AsString;
  Main.ADOQuery1.Close;
  Main.ADOQuery1.SQL.Clear;
  Main.ADOQuery1.SQL.Add('Select * from sell_minor where InvoiceID="'+Main.Label26.Caption+'"');
  Main.ADOQuery1.Open;
  Main.QH1;
  Main.QH2;
  SpeedButton1.Click;
end;

procedure TQD.c1;
begin
  //如果没有挂单数据则退出
  if ADOQuery1.RecordCount<1 then
  begin
    ShowMessage('挂单库没有记录~~!');
    QD.Close;
  end
end;

procedure TQD.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
    key:=#0;
    SpeedButton2.Click;
  end;
end;

procedure TQD.FormShow(Sender: TObject);
begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from sell_main where Not(Hang)');
  ADOQuery1.Active:=True;
end;

end.
