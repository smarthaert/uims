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

procedure TQD.SpeedButton2Click(Sender: TObject);
begin
  Main.Label26.Caption := ADOQuery1.FieldByName('slid').AsString;
  {
  Main.ADOQuery1.Close;
  Main.ADOQuery1.SQL.Clear;

  Main.ADOQuery1.SQL.Add('select pid,goodsname,color,FORMAT(volume,2) as volume,FORMAT(amount,0) as amount,unit,FORMAT(bundle,0) as bundle,FORMAT(outprice,0) as outprice,discount,additional,FORMAT((subtotal),0) as subtotal, ');
  Main.ADOQuery1.SQL.Add('inprice, pfprice, hprice from selllogdetails where slid = "' + Main.Label26.Caption + '" union select "合计" as pid, "" as goodsname, "" as color,FORMAT(sum(volume),2) ');
  Main.ADOQuery1.SQL.Add('as volume,FORMAT(sum(amount),0) as amount,"" as unit,FORMAT(sum(bundle),0) as bundle,FORMAT(sum(outprice),0) as outprice,"" as discount,"" ');
  Main.ADOQuery1.SQL.Add('as additional,FORMAT(sum(subtotal),0) as subtotal,inprice, pfprice, hprice  from selllogdetails where slid = "' + Main.Label26.Caption + '"');

  Main.ADOQuery1.Open;
  }

  Main.QH1;
  Main.QH2;

  {恢复客户，物流等信息}
  Main.edt1.Text := ADOQuery1.FieldByName('custname').AsString;
  Main.edt2.Text := ADOQuery1.FieldByName('custtel').AsString;
  Main.edt3.Text := ADOQuery1.FieldByName('custaddr').AsString;
  Main.edt7.Text := ADOQuery1.FieldByName('custid').AsString;
  Main.edt8.Text := ADOQuery1.FieldByName('custstate').AsString;


  Main.edt4.Text := ADOQuery1.FieldByName('sname').AsString;
  Main.edt5.Text := ADOQuery1.FieldByName('stel').AsString;
  Main.edt6.Text := ADOQuery1.FieldByName('saddress').AsString;


  Main.cbb1.Text := ADOQuery1.FieldByName('payment').AsString;
  Main.mmo1.Text := ADOQuery1.FieldByName('remark').AsString;

  SpeedButton1.Click;
end;

procedure TQD.c1;
begin
  //如果没有挂单数据则退出
  if ADOQuery1.RecordCount < 1 then
  begin
    ShowMessage('挂单库没有记录~~!');
    QD.Close;
  end
end;

procedure TQD.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SpeedButton2.Click;
  end;
end;

procedure TQD.FormShow(Sender: TObject);
begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from selllogmains where Not(status)');
  ADOQuery1.Active := True;
end;

end.
