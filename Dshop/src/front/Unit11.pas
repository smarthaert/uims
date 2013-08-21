unit Unit11;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, DB, ADODB, Buttons, Grids, DBGrids, ExtCtrls,
  INIFiles, StdCtrls;

type
  TQS = class(TForm)
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
    procedure DBGrid1KeyPress(Sender: TObject; var Key:
      Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    procedure c1;
    { Public declarations }
  end;

var
  QS: TQS;

implementation

uses Unit2;

{$R *.dfm}

procedure TQS.SpeedButton1Click(Sender: TObject);
begin
  QS.Close;
end;

procedure TQS.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE: SpeedButton1.Click;
    VK_SPACE: SpeedButton2.Click;

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

procedure TQS.SpeedButton2Click(Sender: TObject);
begin
  {恢复客户}
  Main.edt4.Text :=
    DBGrid1.DataSource.DataSet.FieldByName('sname').AsString;
  Main.edt5.Text :=
    DBGrid1.DataSource.DataSet.FieldByName('tel').AsString;
  Main.edt6.Text :=
    DBGrid1.DataSource.DataSet.FieldByName('address').AsString;
  SpeedButton1.Click;
end;

procedure TQS.c1;
begin
  //如果没有客户数据则退出
  if ADOQuery1.RecordCount < 1 then
  begin
    ShowMessage('没有找到托运部信息~~!');
    QS.Close;
  end
end;

procedure TQS.DBGrid1KeyPress(Sender: TObject; var Key:
  Char);
begin
  if key = #13 then
  begin
    key := #0;
    SpeedButton2.Click;
  end;
end;

procedure TQS.FormShow(Sender: TObject);
begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from shippers where custid = "' + Main.edt7.Text +
    '"');
  ADOQuery1.Active := True;
end;

end.
