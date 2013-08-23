unit Unit17;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, DB, ADODB, Buttons, Grids, DBGrids, ExtCtrls,
  INIFiles, StdCtrls;

type
  TQHD = class(TForm)
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
  QHD: TQHD;

implementation

uses Unit4;

{$R *.dfm}

procedure TQHD.SpeedButton1Click(Sender: TObject);
begin
  QHD.Close;
end;

procedure TQHD.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TQHD.SpeedButton2Click(Sender: TObject);
begin
  //Main_T.Label26.Caption := ADOQuery1.FieldByName('slid').AsString;

  {复制记录}
  //主表 设置售后单的来源是出库单，设置初始状态为   售后中，初始状态为 0
  ADOQuerySQL.SQL.Clear;
  ADOQuerySQL.SQL.Add('insert into aftersellmains(tid,custid,custstate,custname,custtel,custaddr,yingshou,shishou,sid,sname,stel,saddress,payment,status,uid,uname,preid,nextid,type,cdate,remark,created_at,updated_at) select "' + Main_T.Label26.Caption +
    '" as tid,custid,custstate,custname,custtel,custaddr,yingshou,shishou,sid,sname,stel,saddress,payment,"0" as status,uid,uname,"' +
    ADOQuery1.FieldByName('slid').AsString +
    '" as preid,nextid,"处理中" as type,now() as cdate,remark,now() as created_at,now() as updated_at from selllogmains where slid="' +
    ADOQuery1.FieldByName('slid').AsString + '"');
  ADOQuerySQL.ExecSQL;

  //明细表 复制销售记录，设置售后编号，初始状态为0，初始类型为-（无需售后）
  ADOQuerySQL.SQL.Clear;
  ADOQuerySQL.SQL.Add('insert into afterselldetails(tid,pid,barcode,goodsname,size,color,volume,unit,inprice,pfprice,hprice,outprice,amount,');
  ADOQuerySQL.SQL.Add('ramount,bundle,rbundle,discount,additional,subtotal,status,type,cdate,remark,created_at,updated_at) select "' + Main_T.Label26.Caption +
    '" as tid,pid,barcode,goodsname,size,color,volume,unit,inprice,pfprice,hprice,outprice,camount,camount,cbundle,cbundle,discount,' +
    'additional,subtotal,"0" as status,"-" as type,now() as cdate,remark,now() as created_at,now() as updated_at from selllogdetails where slid="' +
    ADOQuery1.FieldByName('slid').AsString + '"');
  ADOQuerySQL.ExecSQL;

  //主表
  ADOQuerySQL.SQL.Clear;
  ADOQuerySQL.SQL.Add('update selllogmains set type="售后中",nextid="' +
    Main_T.Label26.Caption + '" where slid="' +
    ADOQuery1.FieldByName('slid').AsString + '"');
  ADOQuerySQL.ExecSQL;

  {恢复客户，物流等信息}
  Main_T.edt1.Text :=
    ADOQuery1.FieldByName('custname').AsString;
  Main_T.edt2.Text :=
    ADOQuery1.FieldByName('custtel').AsString;
  Main_T.edt3.Text :=
    ADOQuery1.FieldByName('custaddr').AsString;
  Main_T.edt7.Text :=
    ADOQuery1.FieldByName('custid').AsString;
  Main_T.edt8.Text :=
    ADOQuery1.FieldByName('custstate').AsString;
  Main_T.RzEdit7.Text :=
    ADOQuery1.FieldByName('shopname').AsString;

  Main_T.edt4.Text :=
    ADOQuery1.FieldByName('sname').AsString;
  Main_T.edt5.Text :=
    ADOQuery1.FieldByName('stel').AsString;
  Main_T.edt6.Text :=
    ADOQuery1.FieldByName('saddress').AsString;

  Main_T.cbb1.Text :=
    ADOQuery1.FieldByName('payment').AsString;
  Main_T.mmo1.Text :=
    ADOQuery1.FieldByName('remark').AsString;

  Main_T.QH1;
  Main_T.QH2;

  Main_T.RzEdit4.Text := '';

  SpeedButton1.Click;
end;

procedure TQHD.c1;
begin
  //如果没有挂单数据则退出
  if ADOQuery1.RecordCount < 1 then
  begin
    ShowMessage('挂单库没有记录~~!');
    QHD.Close;
  end
end;

procedure TQHD.DBGrid1KeyPress(Sender: TObject; var Key:
  Char);
begin
  if key = #13 then
  begin
    key := #0;
    SpeedButton2.Click;
  end;
end;

{查询销售记录表}
//默认保修日期为100天

procedure TQHD.FormShow(Sender: TObject);
begin
  if Main_T.qsrc = 'custname' then
  begin
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('select sm.* from selllogdetails sd,selllogmains sm where sd.additional<>"补件" and');
    ADOQuery1.SQL.Add(' sd.camount>0 and sd.slid=sm.slid and sm.type<>"售后中" and sm.created_at between date_add(now(),interval -100 day) and now() and sm.custname like "%' +
      Main_T.edt1.Text + '%" group by sm.slid');
    ADOQuery1.Active := True;
  end
  else if Main_T.qsrc = 'pid' then
  begin
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('select sm.* from selllogdetails sd,selllogmains sm where sd.pid="' + Main_T.RzEdit4.Text +
      '" and sd.additional<>"补件" and');
    ADOQuery1.SQL.Add(' sd.camount>0 and sd.slid=sm.slid and sm.type<>"售后中" and sm.created_at between date_add(now(),interval -100 day) and now() and sm.custname like "%' +
      Main_T.edt1.Text + '%" group by sm.slid');
    ADOQuery1.Active := True;
  end;

end;

end.

