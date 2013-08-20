unit Unit13;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Buttons, Grids, DBGrids, ExtCtrls, INIFiles, StdCtrls;

type
  TQO = class(TForm)
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
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    procedure c1;
    { Public declarations }
  end;

var
  QO: TQO;

implementation

uses Unit2;

{$R *.dfm}

procedure TQO.SpeedButton1Click(Sender: TObject);
begin
  QO.Close;
end;

procedure TQO.FormKeyDown(Sender: TObject; var Key: Word;
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

{根据状态位取出订单}

procedure TQO.SpeedButton2Click(Sender: TObject);
begin
  //将订单信息从Ordermain表复制到selllogmain表进行处理

  {复制记录}
  //主表
  ADOQuerySQL.SQL.Clear;
  ADOQuerySQL.SQL.Add('insert into selllogmains(slid,custid,custstate,custname,custtel,custaddr,yingshou,shishou,sid,sname,stel,saddress,payment,status,uid,uname,preid,nextid,type,cdate,remark,created_at,updated_at) select "' + Main.Label26.Caption + '" as slid,custid,custstate,custname,custtel,custaddr,yingshou,shishou,sid,sname,stel,saddress,payment,"0" as status,uid,uname,"' + ADOQuery1.FieldByName('oid').AsString + '" as preid,nextid,type,now() as cdate,remark,now() as created_at,now() as updated_at from ordermains where oid="' + ADOQuery1.FieldByName('oid').AsString + '"');
  ADOQuerySQL.ExecSQL;

  //明细表
  ADOQuerySQL.SQL.Clear;
  ADOQuerySQL.SQL.Add('insert into selllogdetails(slid,pid,barcode,goodsname,size,color,volume,unit,inprice,pfprice,hprice,outprice,amount,bundle,discount,additional,subtotal,status,cdate,remark,created_at,updated_at) select "' + Main.Label26.Caption + '" as slid,pid,barcode,goodsname,size,color,volume,unit,inprice,pfprice,hprice,outprice,amount,bundle,discount,additional,subtotal,"0" as status,now() as cdate,remark,now() as created_at,now() as updated_at from orderdetails where oid="' + ADOQuery1.FieldByName('oid').AsString + '"');
  ADOQuerySQL.ExecSQL;


  //主表
  ADOQuerySQL.SQL.Clear;
  ADOQuerySQL.SQL.Add('update ordermains set type="出库中",nextid="' + Main.Label26.Caption + '" where oid="' + ADOQuery1.FieldByName('oid').AsString + '"');
  ADOQuerySQL.ExecSQL;



  {恢复客户，物流等信息}
  Main.edt1.Text := ADOQuery1.FieldByName('custname').AsString;
  Main.edt2.Text := ADOQuery1.FieldByName('custtel').AsString;
  Main.edt3.Text := ADOQuery1.FieldByName('custaddr').AsString;
  Main.edt7.Text := ADOQuery1.FieldByName('custid').AsString;
  Main.edt8.Text := ADOQuery1.FieldByName('custstate').AsString;
  Main.RzEdit7.Text := ADOQuery1.FieldByName('shopname').AsString;


  Main.edt4.Text := ADOQuery1.FieldByName('sname').AsString;
  Main.edt5.Text := ADOQuery1.FieldByName('stel').AsString;
  Main.edt6.Text := ADOQuery1.FieldByName('saddress').AsString;


  Main.cbb1.Text := ADOQuery1.FieldByName('payment').AsString;
  Main.mmo1.Text := ADOQuery1.FieldByName('remark').AsString;

  Main.QH1;
  Main.QH2;

  SpeedButton1.Click;
end;

procedure TQO.c1;
begin
  //如果没有挂单数据则退出
  if ADOQuery1.RecordCount < 1 then
  begin
    ShowMessage('挂单库没有记录~~!');
    QO.Close;
  end
end;

procedure TQO.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SpeedButton2.Click;
  end;
end;

{根据状态位取出订单}

procedure TQO.FormShow(Sender: TObject);
begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from ordermains where Not(status)');
  ADOQuery1.Active := True;
end;

end.
