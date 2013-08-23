unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, StdCtrls, Mask, RzEdit, ExtCtrls, INIFiles,
  RzForms;

type
  TGathering = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RzEdit1: TRzEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    RzFormShape1: TRzFormShape;
    CheckBox1: TCheckBox;
    Label10: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RzEdit1KeyDown(Sender: TObject; var Key:
      Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure JZ;
    { Public declarations }
  end;

var
  Gathering: TGathering;
  Count: Integer;
implementation

uses Unit2, Unit6, Unit8;

{$R *.dfm}

procedure TGathering.FormCreate(Sender: TObject);
var
  vIniFile: TIniFile;
begin
  vIniFile := TIniFile.Create(ExtractFilePath(ParamStr(0))
    +
    'Config.Ini');
  Label2.Caption := Main.Label7.Caption;
  CheckBox1.Checked := vIniFile.ReadBool('System', 'PB',
    True);

  {根据支付方式填写周到金额}
  if Main.cbb1.Text <> '现金' then
  begin
    RzEdit1.Text := Label2.Caption;
  end;
end;

procedure TGathering.FormKeyDown(Sender: TObject; var Key:
  Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE: Gathering.Close;
    VK_F1:
      begin
        if CheckBox1.Checked then
        begin
          CheckBox1.Checked := False;
          RzEdit1.SetFocus;
        end
        else
        begin
          CheckBox1.Checked := True;
          RzEdit1.SetFocus;
        end;
      end;
    VK_F2:
      begin
        if MoLing <> nil then
        begin
          MoLing.RzEdit1.Text := Label2.Caption;
          MoLing.RzEdit1.SelectAll;
          MoLing.ShowModal;
        end
        else
        begin
          MoLing := TMoLing.Create(Application);
          MoLing.RzEdit1.Text := Label2.Caption;
          MoLing.RzEdit1.SelectAll;
          MoLing.ShowModal;
        end;
      end;
    {
    VK_F3:
      begin
        RzEdit1.Text := Label2.Caption;
        if Card <> nil then
          Card.ShowModal
        else
        begin
          Card := TCard.Create(Application);
          Card.ShowModal;
        end;
      end;
      }
  end;
end;

{结账操作}

procedure TGathering.jz;
var
  vIniFile: TIniFile;
begin
  vIniFile := TIniFile.Create(ExtractFilePath(ParamStr(0))
    +
    'Config.Ini');
  //输入数据检查
  try
    begin
      StrToCurr(RzEdit1.Text); //收到的金额
    end;
  except
    begin
      ShowMessage('输入非法字符~~!');
      RzEdit1.Text := '';
      RzEdit1.SetFocus;
      Exit;
    end;
  end;

  if Main.cbb1.Text = '' then
  begin
    ShowMessage('请选择支付方式~~!');
    Gathering.Close;
    Main.RzEdit4.SetFocus;
    Exit;
  end;

  //如果使用现金支付，检查输入金额是否小于应付款
  if Main.cbb1.Text = '现金' then
  begin
    if StrToCurr(RzEdit1.Text) - StrToCurr(Label2.Caption)
      < 0 then
    begin
      ShowMessage('现金支付时，收到金额不能小于应收款~~!');
      RzEdit1.Text := '';
      RzEdit1.SetFocus;
      Exit;
    end;

    //计算找零
    Label7.Caption := FormatFloat('0.00',
      StrToCurr(RzEdit1.Text) -
      StrToCurr(Label2.Caption));
  end;

  //结束输入
  RzEdit1.ReadOnly := True;
  //显示提示语
  Label9.Visible := True;

  //写主窗口记录
  Main.Label14.Caption := FormatFloat('0.00',
    StrToCurr(Label2.Caption));
  Main.Label15.Caption := FormatFloat('0.00',
    StrToCurr(RzEdit1.Text));
  Main.Label16.Caption := FormatFloat('0.00',
    StrToCurr(Label7.Caption));

  //打印小票
  if CheckBox1.Checked then
  begin
    if messagedlg('确认打印吗？', mtconfirmation, [mbyes,
      mbno], 0) = mryes then
    begin
      {
      Main.QuickRep1.Height := 200 + Main.DetailBand1.Height * Main.ADOQuery1.RecordCount;
      Main.QuickRep1.Page.LeftMargin := vIniFile.ReadInteger('System', 'P0', 0);
      }

      try
        Main.QuickRep1.Prepare;
        FTotalPages := Main.QuickRep1.QRPrinter.PageCount;
      finally
        Main.QuickRep1.QRPrinter.Cleanup;
      end;

      Main.QuickRep1.Print;
      //Main.QuickRep1.Preview;
    end;
  end;

  //保存是否打印小票信息
  if CheckBox1.Checked then
  begin
    vIniFile.WriteBool('System', 'PB', True);
  end
  else
  begin
    vIniFile.WriteBool('System', 'PB', False);
  end;

  //补打凭证时不修改销售数据
  if Main.reprint then
    Main.reprint := False
  else //交易数据处理
  begin

    //记录新客户信息
    Main.ADOQuerySQL.SQL.Clear;
    Main.ADOQuerySQL.SQL.Add('insert into customers(cid,loginname,cname,shopname,sex,address,tel,state,cdate,remark,created_at,updated_at) values("","","' + Main.edt1.Text + '","' + Main.RzEdit7.Text + '","","' +
      Main.edt3.Text + '","'
      + Main.edt2.Text + '","' + Main.edt8.Text +
      '",now(),"",now(),now()) on duplicate key update cname="' +
      Main.edt1.Text + '",shopname="' + Main.RzEdit7.Text +
      '",address="' + Main.edt3.Text + '",state="' +
      Main.edt8.Text + '",updated_at=now()');
    Main.ADOQuerySQL.ExecSQL;

    //记录新托运部信息
    Main.ADOQuerySQL.SQL.Clear;
    Main.ADOQuerySQL.SQL.Add('insert into shippers(sid,sname,tel,address,custid,custname,custtel,cdate,remark,created_at,updated_at) values("","' + Main.edt4.Text + '","' + Main.edt5.Text + '","' +
      Main.edt6.Text + '","","' +
      Main.edt1.Text + '","' + Main.edt2.Text +
      '",now(),"",now(),now()) on duplicate key update sname="' +
      Main.edt4.Text + '",tel="' + Main.edt5.Text +
      '",address="' + Main.edt6.Text + '",custname="' +
      Main.edt1.Text + '",custtel="' + Main.edt2.Text +
      '",cdate=now(),updated_at=now()');
    Main.ADOQuerySQL.ExecSQL;

    //写销售记录，分别更新各自库存
    Main.ADOQuery1.First;
    while not (Main.ADOQuery1.Eof) do
    begin
      if Main.ADOQuery1.FieldByName('additional').AsString
        =
        '-' then
      begin
        Main.ADOQuerySQL.SQL.Clear;
        Main.ADOQuerySQL.SQL.Add('update stocks set amount=amount-' +
          Main.ADOQuery1.FieldByName('amount').AsString +
          ', updated_at=now() where pid="' +
          Main.ADOQuery1.FieldByName('pid').AsString +
          '"');
        Main.ADOQuerySQL.ExecSQL;
      end
      else if
        Main.ADOQuery1.FieldByName('additional').AsString =
        '赠品' then
      begin

      end
      else if
        Main.ADOQuery1.FieldByName('additional').AsString =
        '补件' then
      begin

      end;
      Main.ADOQuery1.Next;
    end;

    //更改销售标记
    Main.ADOQuerySQL.SQL.Clear;
    Main.ADOQuerySQL.SQL.Add('update selllogmains set yingshou="' +
      Main.Label7.Caption + '", shishou="' + Label2.Caption
      +
      '", status="1", type="已出库", remark="' +
      Main.mmo1.Lines.GetText +
      '", updated_at=now() where slid="' +
      Main.Label26.Caption + '"');
    Main.ADOQuerySQL.ExecSQL;

    //根据支付方式记帐
    Main.ADOQuerySQL.SQL.Clear;
    Main.ADOQuerySQL.SQL.Add('insert into contactpayments(custid,custname,outmoney,inmoney,strike,method,cdate,remark,created_at,updated_at) values("' + Main.edt7.Text + '","' + Main.edt1.Text + '","' +
      Main.Label7.Caption + '","'
      + Label2.Caption + '","' +
      CurrToStr(StrToCurr(Main.Label7.Caption) -
      StrToCurr(Label2.Caption)) + '","' + Main.cbb1.Text +
      '",now(),"' +
      Main.mmo1.Lines.GetText + '",now(),now())');
    Main.ADOQuerySQL.ExecSQL;

    //修改成交数据
    //补件不计入本次销售，也不计算盈亏
    Main.ADOQuerySQL.SQL.Clear;
    Main.ADOQuerySQL.SQL.Add('update selllogmains sm,selllogdetails sd set sd.camount=sd.amount,sd.cbundle=sd.bundle,sd.updated_at=now() where sm.slid="' + Main.Label26.Caption +
      '" and sd.slid=sm.slid and sd.additional<>"补件"');
    Main.ADOQuerySQL.ExecSQL;

    //如果是在线渠道过来的订单 source /preid
    //跟新实际发货数量，一边日后到货提醒
    //前提是控制好实际发货数量不能超过订单数量
    Main.ADOQuerySQL.SQL.Clear;
    Main.ADOQuerySQL.SQL.Add('update selllogmains a,ordermains b,orderdetails c,selllogdetails d set c.ramount=d.amount,c.rbundle=d.bundle,c.additional=d.additional,c.updated_at=now() where a.slid="' + Main.Label26.Caption +
      '" and a.preid=b.oid and b.oid=c.oid and d.slid=a.slid and d.pid=c.pid');
    Main.ADOQuerySQL.ExecSQL;

    //更新订单状态
    Main.ADOQuerySQL.SQL.Clear;
    Main.ADOQuerySQL.SQL.Add('update ordermains set type="已发货", updated_at=now() where nextid="' + Main.Label26.Caption + '"');
    Main.ADOQuerySQL.ExecSQL;

    //维修库存状态更新

  end;

  //查找最小单号
  Main.GetOrderId;

  //重新计算主窗口商品价格
  Main.QH2;

  {清空数据项}
  Main.edt1.Text := '';
  Main.edt2.Text := '';
  Main.edt3.Text := '';
  Main.edt7.Text := '';
  Main.edt8.Text := '';
  Main.RzEdit7.Text := '';

  Main.edt4.Text := '';
  Main.edt5.Text := '';
  Main.edt6.Text := '';

  Main.cbb1.Text := '';
  Main.mmo1.Text := '';

  //刷新销售列表
  Main.ListRefresh;
  //关闭结算窗口
  Gathering.Close;
end;

procedure TGathering.RzEdit1KeyDown(Sender: TObject; var
  Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
  begin
    count := count + key;
    if RzEdit1.ReadOnly and (Main.cbb1.Text = '现金') then
      Gathering.Close;
    if not (RzEdit1.ReadOnly) or (Main.cbb1.Text <> '现金')
      then
      JZ;
  end;
end;

procedure TGathering.FormActivate(Sender: TObject);
begin
  if Main.cbb1.Text <> '现金' then
  begin
    RzEdit1.ReadOnly := True;
  end;
end;

end.
