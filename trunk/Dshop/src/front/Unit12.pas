unit Unit12;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Buttons, Grids, DBGrids, ExtCtrls, INIFiles, StdCtrls;

type
  TQP = class(TForm)
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
  QP: TQP;

implementation

uses Unit2;

{$R *.dfm}

procedure TQP.SpeedButton1Click(Sender: TObject);
begin
  QP.Close;
end;

procedure TQP.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TQP.SpeedButton2Click(Sender: TObject);
begin
  {恢复客户}
  Main.RzEdit4.Text := DBGrid1.DataSource.DataSet.FieldByName('pid').AsString;
  SpeedButton1.Click;
end;

procedure TQP.c1;
begin
  //如果没有客户数据则退出
  if ADOQuery1.RecordCount<1 then
  begin
    ShowMessage('没有找到托运部信息~~!');
    QP.Close;
  end
end;

procedure TQP.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
    key:=#0;
    SpeedButton2.Click;
  end;
end;

procedure TQP.FormShow(Sender: TObject);
begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from stocks where goodsname like "%'+Main.RzEdit4.Text+'%" order by goodsname,color,size');
  ADOQuery1.Active:=True;
  {格式化小数显示}
  TFloatField(DBGrid1.DataSource.DataSet.FieldByName('volume')).DisplayFormat:='0.00';
end;

end.
