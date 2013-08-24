unit Unit9;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, DB, ADODB, Buttons, Grids, DBGrids, ExtCtrls,
  INIFiles, StdCtrls;

type
  TQC = class(TForm)
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
  QC: TQC;

implementation

uses Unit2;

{$R *.dfm}

procedure TQC.SpeedButton1Click(Sender: TObject);
begin
  QC.Close;
end;

procedure TQC.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TQC.SpeedButton2Click(Sender: TObject);
begin
  {恢复客户}
  Main.edt1.Text :=
    DBGrid1.DataSource.DataSet.FieldByName('cname').AsString;
  Main.edt2.Text :=
    DBGrid1.DataSource.DataSet.FieldByName('tel').AsString;
  Main.edt3.Text :=
    DBGrid1.DataSource.DataSet.FieldByName('address').AsString;
  Main.edt7.Text :=
    DBGrid1.DataSource.DataSet.FieldByName('cid').AsString;
  Main.edt8.Text :=
    DBGrid1.DataSource.DataSet.FieldByName('state').AsString;
  Main.RzEdit7.Text :=
    DBGrid1.DataSource.DataSet.FieldByName('shopname').AsString;
  SpeedButton1.Click;
end;

procedure TQC.c1;
begin
  //如果没有客户数据则退出
  if ADOQuery1.RecordCount < 1 then
  begin
    ShowMessage('没有找到客户信息~~!');
    QC.Close;
  end
end;

procedure TQC.DBGrid1KeyPress(Sender: TObject; var Key:
  Char);
begin
  if key = #13 then
  begin
    key := #0;
    SpeedButton2.Click;
  end;
end;

procedure TQC.FormShow(Sender: TObject);
begin

  if Main.qsrc = 'cname' then
  begin
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('Select * from customers where cname like "%' +
      Main.edt1.Text + '%"');
    ADOQuery1.Active := True;
  end
  else if Main.qsrc = 'tel' then
  begin
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('Select * from customers where tel="'
      +
      Main.edt2.Text + '"');
    ADOQuery1.Active := True;
  end
  else if Main.qsrc = 'state' then
  begin
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('Select * from customers where state="' +
      Main.edt8.Text + '"');
    ADOQuery1.Active := True;
  end
  else if Main.qsrc = 'cid' then
  begin
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('Select * from customers where cid="'
      +
      Main.edt7.Text + '"');
    ADOQuery1.Active := True;
  end;

end;

end.
