unit Unit23;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, DB, ADODB, Buttons, Grids, DBGrids, ExtCtrls,
  INIFiles, StdCtrls;

type
  TQHB = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    SpeedButton1: TSpeedButton;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    ADOQuerySQL: TADOQuery;
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
  QHB: TQHB;

implementation

uses Unit4, Unit2;

{$R *.dfm}

procedure TQHB.SpeedButton1Click(Sender: TObject);
begin
  QHB.Close;
end;

procedure TQHB.FormKeyDown(Sender: TObject; var Key: Word;
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

{确认选择时，复制记录去Aftersellmain表}

procedure TQHB.SpeedButton2Click(Sender: TObject);
begin
  //Main_T.Label26.Caption := ADOQuery1.FieldByName('slid').AsString;
  Main.ADOConnection1.BeginTrans;
  try

    {合并两条记录,保留第一条记录}
    ADOQuerySQL.SQL.Clear;
    ADOQuerySQL.SQL.Add('update afterselldetails ad,(select tid,pid,ramount,dtype from afterselldetails where tid="' + Main_T.Label26.Caption + '" and pid="' +
      ADOQuery1.FieldByName('pid').AsString + '"');
    ADOQuerySQL.SQL.Add(' and dtype="' +
      ADOQuery1.FieldByName('type').AsString +
      '") t set ad.ramount=(ad.ramount+t.ramount),updated_at=now() where t.tid=ad.tid and t.pid=ad.pid and ad.dtype="' +
      Main_T.ADOQuery1.FieldByName('type').AsString +
      '" and additional="' +
      ADOQuery1.FieldByName('additional').AsString + '"');
    ADOQuerySQL.ExecSQL;

    //删除第二次选择的记录
    ADOQuerySQL.SQL.Clear;
    ADOQuerySQL.SQL.Add('delete from afterselldetails where tid="' +
      Main_T.Label26.Caption + '" and pid="' +
      Main_T.ADOQuery1.FieldByName('pid').AsString +
      '" and additional="' +
      ADOQuery1.FieldByName('additional').AsString +
      '" and dtype="' + ADOQuery1.FieldByName('type').AsString
      +
      '"');
    ADOQuerySQL.ExecSQL;

    Main.ADOConnection1.CommitTrans;
  except
    Main.ADOConnection1.RollbackTrans;
  end;

  Main_T.QH1;
  Main_T.QH2;

  SpeedButton1.Click;
end;

procedure TQHB.c1;
begin
  //如果没有挂单数据则退出
  if ADOQuery1.RecordCount < 1 then
  begin
    ShowMessage('挂单库没有记录~~!');
    QHB.Close;
  end
end;

procedure TQHB.DBGrid1KeyPress(Sender: TObject; var Key:
  Char);
begin
  if key = #13 then
  begin
    key := #0;
    SpeedButton2.Click;
  end;
end;

{查询销售记录表}

procedure TQHB.FormShow(Sender: TObject);
begin
  //
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('select (@row := @row + 1) as row,id, pid,goodsname,color,FORMAT(volume,2) as volume,FORMAT(amount,0) as amount,');
  ADOQuery1.SQL.Add('FORMAT(ramount,0) as ramount,unit,FORMAT(bundle,0) as bundle,FORMAT(rbundle,0) as rbundle,FORMAT(outprice,0) as outprice,discount,additional,FORMAT((subtotal),0) as subtotal, ');
  ADOQuery1.SQL.Add('tid, barcode, size, inprice, pfprice,hprice,dtype as type from afterselldetails, (SELECT @row := 0) r where tid="' + Main_T.Label26.Caption +
    '" and ramount>0 and pid="' +
    Main_T.ADOQuery1.FieldByName('pid').AsString +
    '" and additional="' +
    Main_T.ADOQuery1.FieldByName('additional').AsString +
    '" and dtype<>"' +
    Main_T.ADOQuery1.FieldByName('type').AsString +
    '" order by id');
  ADOQuery1.Active := True;
end;

end.
