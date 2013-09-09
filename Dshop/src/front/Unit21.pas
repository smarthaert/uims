unit Unit21;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, DB, ADODB, Buttons, Grids, DBGrids, ExtCtrls,
  INIFiles, StdCtrls;

type
  TQPC = class(TForm)
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
  QPC: TQPC;

implementation

uses Unit2, Unit4;

{$R *.dfm}

procedure TQPC.SpeedButton1Click(Sender: TObject);
begin
  QPC.Close;
end;

procedure TQPC.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TQPC.SpeedButton2Click(Sender: TObject);
begin

  //将选择的产品数量增加1
  ADOQuerySQL.SQL.Clear;
  ADOQuerySQL.SQL.Add('insert into afterselldetails(tid,pid,barcode,goodsname,size,color,volume,unit,inprice,pfprice,hprice,outprice,amount,');
  ADOQuerySQL.SQL.Add('ramount,bundle,rbundle,discount,additional,subtotal,status,dtype,cdate,remark,created_at,updated_at) select tid,pid,barcode,');
  ADOQuerySQL.SQL.Add('goodsname,size,color,volume,unit,inprice,pfprice,hprice,outprice,amount,"1" as ramount,bundle,rbundle,discount,additional,');
  ADOQuerySQL.SQL.Add('subtotal,status,"-" as dtype,now() as cdate,remark,now() as created_at,now() as updated_at from afterselldetails where tid="' + Main_T.Label26.Caption + '" and pid="' +
    ADOQuery1.FieldByName('pid').AsString + '"');
  ADOQuerySQL.ExecSQL;

  Main_T.QH1;
  Main_T.QH2;

  SpeedButton1.Click;
end;

procedure TQPC.c1;
begin
  //如果没有客户数据则退出
  if ADOQuery1.RecordCount < 1 then
  begin
    ShowMessage('没有找到托运部信息~~!');
    QPC.Close;
  end
end;

procedure TQPC.DBGrid1KeyPress(Sender: TObject; var Key:
  Char);
begin
  if key = #13 then
  begin
    key := #0;
    SpeedButton2.Click;
  end;
end;

procedure TQPC.FormShow(Sender: TObject);
begin

  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('select d.tid,d.pid,barcode,d.goodsname,d.size,d.color,d.volume,d.unit,d.inprice,d.pfprice,d.amount,');
  ADOQuery1.SQL.Add('d.ramount,d.bundle,d.discount,d.remark from afterselldetails d where not(d.status) and d.amount>d.ramount and d.tid="' + Main_T.Label26.Caption + '"');
  ADOQuery1.Active := True;
end;

end.
