unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, RzEdit, ExtCtrls, INIFiles, RzForms;

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
    procedure RzEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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
  vIniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.Ini');
  Label2.Caption := Main.Label7.Caption;
  CheckBox1.Checked := vIniFile.ReadBool('System', 'PB', True);

  {根据支付方式填写周到金额}
  if Main.cbb1.Text <> '现金' then
  begin
    RzEdit1.Text := Label2.Caption;
  end;
end;

procedure TGathering.FormKeyDown(Sender: TObject; var Key: Word;
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
  vIniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.Ini');
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
    if StrToCurr(RzEdit1.Text) - StrToCurr(Label2.Caption) < 0 then
    begin
      ShowMessage('现金支付时，收到金额不能小于应收款~~!');
      RzEdit1.Text := '';
      RzEdit1.SetFocus;
      Exit;
    end;

    //计算找零
    Label7.Caption := FormatFloat('0.00', StrToCurr(RzEdit1.Text) - StrToCurr(Label2.Caption));
  end;

  //结束输入
  RzEdit1.ReadOnly := True;
  //显示提示语
  Label9.Visible := True;

  //写主窗口记录
  Main.Label14.Caption := FormatFloat('0.00', StrToCurr(Label2.Caption));
  Main.Label15.Caption := FormatFloat('0.00', StrToCurr(RzEdit1.Text));
  Main.Label16.Caption := FormatFloat('0.00', StrToCurr(Label7.Caption));

  //打印小票
  if CheckBox1.Checked then
  begin
    if messagedlg('确认打印吗？', mtconfirmation, [mbyes, mbno], 0) = mryes then
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


  //记录新客户信息
  Main.ADOQuerySQL.SQL.Clear;
  Main.ADOQuerySQL.SQL.Add('insert into customers(cid,loginname,cname,sex,address,tel,state,cdate,remark,created_at,updated_at) values("","","' + Main.edt1.Text + '","","' + Main.edt3.Text + '","' + Main.edt2.Text + '","' + Main.edt8.Text + '",now(),"",now(),now()) on duplicate key update updated_at=now()');
  Main.ADOQuerySQL.ExecSQL;

  //记录新托运部信息
  Main.ADOQuerySQL.SQL.Clear;
  Main.ADOQuerySQL.SQL.Add('insert into shippers(sid,sname,tel,address,custid,custname,custtel,cdate,remark,created_at,updated_at) values("","' + Main.edt4.Text + '","' + Main.edt5.Text + '","' + Main.edt6.Text + '","","' + Main.edt1.Text + '","' + Main.edt2.Text + '",now(),"",now(),now()) on duplicate key update updated_at=now()');
  Main.ADOQuerySQL.ExecSQL;


  //写销售记录
  Main.ADOQuery1.First;
  while not (Main.ADOQuery1.Eof) do
  begin
    {
    Main.ADOQuery2.Edit;
    //查找商品
    Main.ADOQuery2.SQL.Clear;
    Main.ADOQuery2.SQL.Add('Select * from stocks Where pid="' + Main.ADOQuery1.FieldByName('pid').AsString + '"');
    Main.ADOQuery2.Open;
    //减少库存
    Main.ADOQuery2.Edit;
    Main.ADOQuery2.FieldByName('amount').AsCurrency := Main.ADOQuery2.FieldByName('amount').AsCurrency - Main.ADOQuery1.FieldByName('amount').AsCurrency;


    UpdateTimeStr := FormatdateTime('yyyy-mm-dd hh:mm:ss', Now);
    if Main.ADOQuery2.FieldByName('created_at').AsString = '' then
      Main.ADOQuery2.FieldByName('created_at').AsString := UpdateTimeStr;
    Main.ADOQuery2.FieldByName('updated_at').AsString := UpdateTimeStr;


    Main.ADOQuery2.Post;
    Main.ADOQuery2.Refresh;
    }

    Main.ADOQuerySQL.SQL.Clear;
    Main.ADOQuerySQL.SQL.Add('update stocks set amount=amount-' + Main.ADOQuery1.FieldByName('amount').AsString + ', updated_at=now() where pid="' + Main.ADOQuery1.FieldByName('pid').AsString + '"');
    Main.ADOQuerySQL.ExecSQL;

    Main.ADOQuery1.Next;
  end;

  //更改销售标记
  {
  Main.ADOQuery2.SQL.Clear;
  Main.ADOQuery2.SQL.Add('Select * from selllogmains Where slid="' + Main.Label26.Caption + '"');
  Main.ADOQuery2.Open;
  Main.ADOQuery2.Edit;
  Main.ADOQuery2.FieldByName('yingshou').AsString := Main.Label7.Caption;
  Main.ADOQuery2.FieldByName('shishou').AsString := Label2.Caption;
  Main.ADOQuery2.FieldByName('status').AsString := '1';
  Main.ADOQuery2.FieldByName('remark').AsString := Main.mmo1.Lines.GetText;


  UpdateTimeStr := FormatdateTime('yyyy-mm-dd hh:mm:ss', Now);
  if Main.ADOQuery2.FieldByName('created_at').AsString = '' then
    Main.ADOQuery2.FieldByName('created_at').AsString := UpdateTimeStr;
  Main.ADOQuery2.FieldByName('updated_at').AsString := UpdateTimeStr;


  Main.ADOQuery2.Post;
  Main.ADOQuery2.Refresh;
  }

  Main.ADOQuerySQL.SQL.Clear;
  Main.ADOQuerySQL.SQL.Add('update selllogmains set yingshou="' + Main.Label7.Caption + '", shishou="' + Label2.Caption + '", status="1", type="已销售", remark="' + Main.mmo1.Lines.GetText + '", updated_at=now() where slid="' + Main.Label26.Caption + '"');
  Main.ADOQuerySQL.ExecSQL;

  //根据支付方式记帐
  {
  Main.ADOQuery2.SQL.Clear;
  Main.ADOQuery2.SQL.Add('Select * from contactpayments Where not(1)');
  Main.ADOQuery2.Open;
  Main.ADOQuery2.Append;
  Main.ADOQuery2.FieldByName('custid').AsString := Main.edt7.Text;
  Main.ADOQuery2.FieldByName('custname').AsString := Main.edt1.Text;
  Main.ADOQuery2.FieldByName('inmoney').AsString := Label2.Caption;
  Main.ADOQuery2.FieldByName('outmoney').AsString := Main.Label7.Caption;
  if StrToCurr(Main.Label7.Caption) - StrToCurr(Label2.Caption) <> 0 then
    Main.ADOQuery2.FieldByName('strike').AsCurrency := StrToCurr(Main.Label7.Caption) - StrToCurr(Label2.Caption);
  Main.ADOQuery2.FieldByName('method').AsString := Main.cbb1.Text;
  Main.ADOQuery2.FieldByName('remark').AsString := Main.mmo1.Lines.GetText;


  UpdateTimeStr := FormatdateTime('yyyy-mm-dd hh:mm:ss', Now);
  if Main.ADOQuery2.FieldByName('created_at').AsString = '' then
    Main.ADOQuery2.FieldByName('created_at').AsString := UpdateTimeStr;
  Main.ADOQuery2.FieldByName('updated_at').AsString := UpdateTimeStr;


  Main.ADOQuery2.Post;
  Main.ADOQuery2.Refresh;
  }
  Main.ADOQuerySQL.SQL.Clear;
  Main.ADOQuerySQL.SQL.Add('insert into contactpayments(custid,custname,outmoney,inmoney,strike,method,cdate,remark,created_at,updated_at) values("' + Main.edt7.Text + '","' + Main.edt1.Text + '","' + Main.Label7.Caption + '","' + Label2.Caption + '","' + CurrToStr(StrToCurr(Main.Label7.Caption) - StrToCurr(Label2.Caption)) + '","' + Main.cbb1.Text + '",now(),"' + Main.mmo1.Lines.GetText + '",now(),now())');
  Main.ADOQuerySQL.ExecSQL;


  //查找最小单号
  Main.GetOrderId;
  {
  for i := 1 to 9999 do
  begin
    SID := FormatdateTime('yymmdd', Now) + FormatFloat('0000', i);
    Main.ADOQuery2.SQL.Clear;
    Main.ADOQuery2.SQL.Add('Select * from selllogmains Where slid="' + SID + '"');
    Main.ADOQuery2.Open;
    if Main.ADOQuery2.RecordCount = 0 then
      Break;
  end;
  Main.Label26.Caption := SID;
  }

  //重新计算主窗口商品价格
  Main.QH2;

  {清空数据项}
  Main.edt1.Text := '';
  Main.edt2.Text := '';
  Main.edt3.Text := '';
  Main.edt7.Text := '';
  Main.edt8.Text := '';

  Main.edt4.Text := '';
  Main.edt5.Text := '';
  Main.edt6.Text := '';

  Main.cbb1.Text := '';
  Main.mmo1.Text := '';


  //刷新销售列表
  {
  Main.ADOQuery1.Refresh;
  Main.ADOQuery1.Close;
  Main.ADOQuery1.SQL.Clear;
  //Main.ADOQuery1.SQL.Add('Select * from selllogdetails Where slid="' + Main.Label26.Caption + '"');
  Main.ADOQuery1.SQL.Add('select pid,goodsname,color,FORMAT(volume,2) as volume,FORMAT(amount,0) as amount,unit,FORMAT(bundle,0) as bundle,FORMAT(outprice,0) as outprice,discount,additional,FORMAT((subtotal),0) as subtotal, ');
  Main.ADOQuery1.SQL.Add('inprice, pfprice, hprice from selllogdetails where slid = "' + Main.Label26.Caption + '" union select "合计" as pid, "" as goodsname, "" as color,FORMAT(sum(volume),2) ');
  Main.ADOQuery1.SQL.Add('as volume,FORMAT(sum(amount),0) as amount,"" as unit,FORMAT(sum(bundle),0) as bundle,FORMAT(sum(outprice),0) as outprice,"" as discount,"" ');
  Main.ADOQuery1.SQL.Add('as additional,FORMAT(sum(subtotal),0) as subtotal,inprice, pfprice, hprice  from selllogdetails where slid = "' + Main.Label26.Caption + '"');

  Main.ADOQuery1.Open;
  }
  Main.ListRefresh;
end;



procedure TGathering.RzEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
  begin
    count := count + key;
    if RzEdit1.ReadOnly then
      Gathering.Close;
    if not (RzEdit1.ReadOnly) then
      JZ;
  end;
end;

end.
