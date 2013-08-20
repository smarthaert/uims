unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, StdCtrls, Grids, DBGrids, DB, ADODB, INIFiles,
  RzForms, RzStatus, Mask, RzEdit, QRCtrls, QuickRpt, Registry, DBTables,
  RzCmboBx;

type
  TMain_T = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    RzFormShape1: TRzFormShape;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Bevel1: TBevel;
    Label17: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Bevel4: TBevel;
    RzEdit1: TRzEdit;
    RzEdit2: TRzEdit;
    RzEdit3: TRzEdit;
    Label23: TLabel;
    Label24: TLabel;
    Label27: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Panel5: TPanel;
    QuickRep1: TQuickRep;
    DetailBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    SummaryBand1: TQRBand;
    QRLabel7: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel10: TQRLabel;
    Label30: TLabel;
    RzEdit4: TRzEdit;
    grp1: TGroupBox;
    grp2: TGroupBox;
    grp3: TGroupBox;
    grp4: TGroupBox;
    DBGrid1: TDBGrid;
    edt1: TRzEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    edt2: TRzEdit;
    lbl3: TLabel;
    edt3: TRzEdit;
    lbl4: TLabel;
    edt4: TRzEdit;
    lbl5: TLabel;
    edt5: TRzEdit;
    lbl6: TLabel;
    edt6: TRzEdit;
    lbl7: TLabel;
    cbb1: TComboBox;
    lbl8: TLabel;
    mmo1: TMemo;
    lbl9: TLabel;
    edt7: TRzEdit;
    edt8: TRzEdit;
    lbl10: TLabel;
    qrbndPageFooter1: TQRBand;
    qrdbtxtpid: TQRDBText;
    qrdbtxtgoodsname: TQRDBText;
    qrdbtxtcolor: TQRDBText;
    qrdbtxtvolume: TQRDBText;
    qrdbtxtamount: TQRDBText;
    qrdbtxtunit: TQRDBText;
    qrdbtxtbundle: TQRDBText;
    qrdbtxtoutprice: TQRDBText;
    qrdbtxtrepeat: TQRDBText;
    qrdbtxtsubtotal: TQRDBText;
    qrlbl13: TQRLabel;
    qrlbl14: TQRLabel;
    qrlbl15: TQRLabel;
    qrlbl16: TQRLabel;
    qrlbl17: TQRLabel;
    qrlbl18: TQRLabel;
    qrlbl19: TQRLabel;
    qrlbl20: TQRLabel;
    qrlbl21: TQRLabel;
    qrlbl22: TQRLabel;
    qrlbl12: TQRLabel;
    qrlbl23: TQRLabel;
    qrbndtitleColumnHeaderBand1: TQRBand;
    qrbndtitleTitleBand1: TQRBand;
    qrlbl9: TQRLabel;
    qrlbl24: TQRLabel;
    qrlbl25: TQRLabel;
    qrlbl26: TQRLabel;
    qrlbl27: TQRLabel;
    qrlbl28: TQRLabel;
    qrlbl29: TQRLabel;
    qrlbl30: TQRLabel;
    qrlbl31: TQRLabel;
    qrlbl32: TQRLabel;
    qrlbl2: TQRLabel;
    RzEdit5: TRzEdit;
    Label31: TLabel;
    ADOQuerySQL: TADOQuery;
    QRLabel3: TQRLabel;
    qrdbtxtrow: TQRDBText;
    Label32: TLabel;
    Label22: TLabel;
    Label33: TLabel;
    ADOQuery2: TADOQuery;
    RzComboBox1: TRzComboBox;
    lbl11: TLabel;
    RzEdit7: TRzEdit;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure QuickRep1StartPage(Sender: TCustomQuickRep);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RzEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure RzEdit3KeyPress(Sender: TObject; var Key: Char);
    procedure RzEdit5KeyPress(Sender: TObject; var Key: Char);
    procedure RzEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RzEdit4KeyPress(Sender: TObject; var Key: Char);
    procedure edt1KeyPress(Sender: TObject; var Key: Char);
    procedure edt4KeyPress(Sender: TObject; var Key: Char);
    procedure qrlbl12Print(sender: TObject; var Value: string);
    procedure edt8KeyPress(Sender: TObject; var Key: Char);
    procedure edt2KeyPress(Sender: TObject; var Key: Char);
    procedure FormHide(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure RzComboBox1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    procedure QH1;
    procedure WRecord;
    procedure QH2;
    procedure ListRefresh;
    procedure GetOrderId;
    procedure GetLoginTime;
    { Public declarations }
  end;

var
  Main_T: TMain_T;
  FTotalPages: Integer;
  source: string;

implementation

uses Unit1, Unit2, Unit3, Unit5, Unit7, Unit9, Unit10, Unit11, Unit12, Unit13, Unit14, Unit15, Unit16,
  Unit17, Unit18;

{$R *.dfm}



{初始化下单页面}

procedure TMain_T.FormCreate(Sender: TObject);
begin
  {
  Main_T.Width:=1045;//恢复主窗口大小
  Main_T.Height:=810;//恢复主窗口大小


//使主窗口位于屏幕正中央
  Main_T.Top := (GetSystemMetrics(SM_CySCREEN) - 810) div 2 - 13;
  Main_T.Left := (GetSystemMetrics(SM_CxSCREEN) - 1045) div 2;
  }

  GetOrderId;

  ListRefresh;
  QH2;

end;

{获取单号}

procedure TMain_T.GetOrderId;
begin
  {每日最大单号9999}

  ADOQuery2.SQL.Clear;
  ADOQuery2.SQL.Add('select concat("T",DATE_FORMAT(now(),"%y%m%d"),lpad(cast(substr(if(max(tid) is null,"0000",max(tid)),8) as signed) + 1,4,"0")) as id from aftersellmains where DATE_FORMAT(created_at,"%y%m%d")=DATE_FORMAT(now(),"%y%m%d") and tid like "T%"');
  ADOQuery2.Open;

  //读取单号
  Label26.Caption := ADOQuery2.FieldByName('id').AsString;
end;

procedure TMain_T.GetLoginTime;
begin

  ADOQuery2.SQL.Clear;
  ADOQuery2.SQL.Add('select now() as now');
  ADOQuery2.Open;

  //读取单号
  Label21.Caption := ADOQuery2.FieldByName('now').AsString;
end;


{刷新列表}

procedure TMain_T.ListRefresh;
var
  bookmark: Pointer;
begin
  {记录当前处理的行位置，以便于刷新数据后恢复当前的位置}
  bookmark := ADOQuery1.GetBookmark;


  ADOQuery1.SQL.Clear;

  ADOQuery1.SQL.Add('(select (@row := @row + 1) as row,id, pid,goodsname,color,FORMAT(volume,2) as volume,FORMAT(amount,0) as amount,unit,FORMAT(bundle,0) as bundle,FORMAT(outprice,0) as outprice,discount,additional,FORMAT((subtotal),0) as subtotal, ');
  ADOQuery1.SQL.Add('tid, barcode, size, inprice, pfprice,hprice,type from afterselldetails, (SELECT @row := 0) r where tid = "' + Label26.Caption + '" order by id) union (select "合计" as row, "" as id, "" as pid, "" as goodsname, "" as color,FORMAT(sum(volume*amount),2) ');
  ADOQuery1.SQL.Add('as volume,FORMAT(sum(amount),0) as amount,"" as unit,FORMAT(sum(bundle),0) as bundle,"" as outprice,"" as discount,"" ');
  ADOQuery1.SQL.Add('as additional,-FORMAT(sum(subtotal),0) as subtotal, "" as tid, "" as barcode, "" as size, "" as inprice, "" as pfprice, "" as hprice, "" as type  from afterselldetails where tid = "' + Label26.Caption + '" and type="退货")');

  ADOQuery1.Open;
  if ADOQuery1.RecordCount > 1 then
    ADOQuery1.GotoBookmark(bookmark);

  ADOQuery1.FreeBookmark(bookmark);


end;


procedure TMain_T.SpeedButton1Click(Sender: TObject);
begin
  Main.Show;
  Main_T.Close;
end;



procedure TMain_T.SpeedButton2Click(Sender: TObject);
begin
  if SpeedButton2.Caption = 'F12.软件注册' then
  begin
    //打开注册窗口
    RegKey := TRegKey.Create(Application);
    RegKey.showmodal;
  end
  else
  begin
    //使主窗口位于屏幕正中央
    Main_T.Top := (GetSystemMetrics(SM_CySCREEN) - Main_T.Height) div 2 - 13;
    Main_T.Left := (GetSystemMetrics(SM_CxSCREEN) - Main_T.Width) div 2;
  end;
end;

{打印单据上的信息}

procedure TMain_T.QuickRep1StartPage(Sender: TCustomQuickRep);
var
  vIniFile: TIniFile;
begin
  vIniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.Ini');
  QRLabel1.Caption := viniFile.ReadString('System', 'Name', '');
  QRLabel2.Caption := viniFile.ReadString('System', 'La1', '');

  QRLabel10.Caption := '操作员:' + Label19.Caption;
  QRLabel7.Caption := '应收:' + Label14.Caption + '元';
  QRLabel8.Caption := '实收:' + Label15.Caption + '元';
  QRLabel9.Caption := '找零:' + Label16.Caption + '元';

  qrlbl13.Caption := '收件人:' + Main_T.edt1.Text;
  qrlbl14.Caption := '电话:' + Main_T.edt2.Text;
  qrlbl15.Caption := '收货地址:' + Main_T.edt3.Text;
  qrlbl19.Caption := '付款方式:' + Main_T.cbb1.Text;


  qrlbl16.Caption := '托运部:' + Main_T.edt4.Text;
  qrlbl17.Caption := '电话:' + Main_T.edt5.Text;
  qrlbl18.Caption := '托运部地址:' + Main_T.edt6.Text;


  qrlbl20.Caption := '日期:' + FormatDateTime('dddddd tt', Now);
  qrlbl21.Caption := '单号:№' + Label26.Caption;
  qrlbl22.Caption := '订购电话:' + viniFile.ReadString('System', 'TEL', '');
  qrlbl23.Caption := viniFile.ReadString('System', 'La2', '');
end;

{计算每个产品的小计金额}

procedure TMain_T.QH1;
begin

  ADOQuerySQL.SQL.Clear;
  ADOQuerySQL.SQL.Add('update afterselldetails set subtotal=(if(additional="-",(outprice*amount*discount/100),0)),updated_at=now() where tid = "' + Label26.Caption + '"');
  ADOQuerySQL.ExecSQL;

  {刷新列表}
  ListRefresh;
end;

{订单中产品新增}

procedure TMain_T.WRecord;
begin

  {
  //数据检查
  try
    StrToCurr(RzEdit1.Text);
  except
    RzEdit1.Text := '100';
  end;

  try
    StrToCurr(RzEdit3.Text);
  except
    RzEdit3.Text := '1';
  end;
  }

  //初始折扣和数量
  RzEdit1.Text := '100';
  RzEdit3.Text := '1';



  {跟新产品选择信息，有记录就更新，无记录就插入}
  //查销售主库是否有此单号
  ADOQuerySQL.SQL.Clear;
  ADOQuerySQL.SQL.Add('Select * from selllogmains Where slid="' + Label26.Caption + '"');
  ADOQuerySQL.ExecSQL;
  if ADOQuerySQL.RecordCount = 0 then
  begin

    ADOQuerySQL.SQL.Clear;
    ADOQuerySQL.SQL.Add('insert into selllogmains(slid,custid,custstate,custname,shopname,custtel,custaddr,sname,stel,saddress,payment,status,uname,cdate,remark,created_at,updated_at) values("' + Label26.Caption + '","' + edt7.Text + '","' + edt8.Text + '","' + edt1.Text + '","' + RzEdit7.Text + '","' + edt2.Text + '","' + edt3.Text + '","' + edt4.Text + '","' + edt5.Text + '","' + edt6.Text + '","' + cbb1.Text + '","0","' + Label19.Caption + '",now(),"' + mmo1.Lines.GetText + '",now(),now())');
    ADOQuerySQL.ExecSQL;

  end;

  //ADOQuerySQL.SQL.Clear;
  //ADOQuerySQL.SQL.Add('insert into selllogdetails(slid,pid,barcode,goodsname,size,color,volume,unit,inprice,pfprice,hprice,outprice,amount,bundle,discount,additional,cdate,status,created_at,updated_at) values("' + Label26.Caption + '","' + ADOQuery2.FieldByName('pid').AsString + '","' + ADOQuery2.FieldByName('barcode').AsString + '","' + ADOQuery2.FieldByName('goodsname').AsString + '","' + ADOQuery2.FieldByName('size').AsString + '","' + ADOQuery2.FieldByName('color').AsString + '","' + ADOQuery2.FieldByName('volume').AsString + '","' + ADOQuery2.FieldByName('unit').AsString + '","' + ADOQuery2.FieldByName('inprice').AsString + '","' + ADOQuery2.FieldByName('pfprice').AsString + '","' + ADOQuery2.FieldByName('pfprice').AsString + '","' + ADOQuery2.FieldByName('pfprice').AsString + '","' + RzEdit3.Text + '","0","' + RzEdit1.Text + '","-",now(),"0",now(),now()) on duplicate key update amount=amount+1,updated_at=now()');
  //ADOQuerySQL.ExecSQL;

  QH1;
  QH2;


end;

{计算指定单号的合计价格}

procedure TMain_T.QH2;
begin
  ADOQuery2.SQL.Clear;
  ADOQuery2.SQL.Add('Select -sum(subtotal) from afterselldetails Where tid="' + Label26.Caption + '" and type="退货"');
  ADOQuery2.Open;

  Label7.Caption := FormatFloat('0.00', ADOQuery2.Fields[0].AsCurrency)
end;

{处理快捷键}

procedure TMain_T.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  slid: string;
begin
  case key of
    VK_ESCAPE: SpeedButton1.Click; //退出

    VK_SPACE: //提交订单
      begin
        //检查货物数量
        if ADOQuery1.RecordCount < 1 then
        begin
          ShowMessage('没有商品记录~~!');
          Exit;
        end
        else
        begin
          Gathering := TGathering.Create(Application);
          Gathering.ShowModal;
        end;
      end;

    VK_F1: RzEdit4.SetFocus; //增加商品

    VK_F2: RzEdit3.SetFocus; //修改数量

    VK_F3: RzEdit5.SetFocus; //修改件数

    VK_F4: RzEdit2.SetFocus; //修改单价

    VK_F5: RzComboBox1.SetFocus; //售后操作类型，退货/换货/维修/补发/

    VK_F6: //将当前未完成退货订单挂起 set status=0
      begin

        ADOQuerySQL.SQL.Clear;
        ADOQuerySQL.SQL.Add('insert into aftersellmains(tid,custid,custstate,custname,shopname,custtel,custaddr,yingshou,shishou,sname,stel,saddress,payment,status,uname,cdate,remark,created_at,updated_at) values("' + Label26.Caption + '","","' + edt8.Text + '","' + edt1.Text + '","' + RzEdit7.Text + '","' + edt2.Text + '","' + edt3.Text + '","0","0","' + edt4.Text + '","' + edt6.Text + '","' + edt5.Text + '","' + cbb1.Text + '","0","' + Label19.Caption + '",now(),"' + mmo1.Lines.GetText + '",now(),now()) on duplicate key update custstate="' + edt8.Text + '",custname="' + edt1.Text + '",shopname="' + RzEdit7.Text + '",custtel="' + edt2.Text + '",custaddr="' + edt3.Text + '",sname="' + edt4.Text + '",stel="' + edt6.Text + '",saddress="' + edt5.Text + '",payment="' + cbb1.Text + '",uname="' + Label19.Caption + '",remark="' + mmo1.Lines.GetText + '",updated_at=now()');
        ADOQuerySQL.ExecSQL;

        {清空数据项}
        edt1.Text := '';
        edt2.Text := '';
        edt3.Text := '';
        edt7.Text := '';
        edt8.Text := '';
        RzEdit7.Text := '';

        edt4.Text := '';
        edt5.Text := '';
        edt6.Text := '';

        cbb1.Text := '';
        mmo1.Text := '';


        {更换单号}
        GetOrderId;

        ListRefresh;
        QH2;

        RzEdit4.SetFocus;
      end;

    VK_F7: //取未完成的退货订单 status=0
      begin
        if QHDF7 <> nil then
          QHDF7.ShowModal
        else
        begin
          QHDF7 := TQHDF7.Create(Application);
          QHDF7.ShowModal;
          RzEdit4.SetFocus;
        end;
      end;

    VK_F8: //取消退货订单
      begin

        ADOQuery2.SQL.Clear;
        ADOQuery2.SQL.Add('select * from selllogmains where nextid="' + Main_T.Label26.Caption + '" and type="售后中"');
        ADOQuery2.Open;
        if ADOQuery2.RecordCount < 1 then
        begin
          ShowMessage('"' + Main_T.Label26.Caption + '"没有找到原始订单信息，请联系管理员~~!');
          Exit;
        end
        else
        begin
          if messagedlg('取消该售后订单吗?', mtconfirmation, [mbyes, mbno], 0) = mryes then
          begin
            //主表
            ADOQuerySQL.SQL.Clear;
            ADOQuerySQL.SQL.Add('update selllogmains set type="已销售", nextid="" where slid="' + ADOQuery2.FieldByName('slid').AsString + '"');
            ADOQuerySQL.ExecSQL;

            {复制记录}
            //主表
            ADOQuerySQL.SQL.Clear;
            ADOQuerySQL.SQL.Add('delete from aftersellmains where tid="' + Main_T.Label26.Caption + '"');
            ADOQuerySQL.ExecSQL;

            //明细表
            ADOQuerySQL.SQL.Clear;
            ADOQuerySQL.SQL.Add('delete from afterselldetails where tid="' + Main_T.Label26.Caption + '"');
            ADOQuerySQL.ExecSQL;
          end;
        end;

        QH1;
        QH2;
      end;

    VK_F10: RzEdit1.SetFocus;

    VK_F11:
      begin
        if QO <> nil then
          QO.ShowModal
        else
        begin
          QO := TQO.Create(Application);
          QO.ShowModal;
        end;
      end;

    VK_F12: SpeedButton2.Click;

    VK_UP:
      begin
        DBGrid1.SetFocus;
      end;

    VK_DOWN:
      begin
        DBGrid1.SetFocus;
      end;

    VK_DELETE: //删除产品项目
      begin
        if ADOQuery1.RecordCount > 0 then
        begin


          if ADOQuery1.FieldByName('pid').AsString = '' then
          begin
            if messagedlg('清空当前订单中的所有商品吗?', mtconfirmation, [mbyes, mbno], 0) = mryes then
            begin
              ADOQuerySQL.SQL.Clear;
              ADOQuerySQL.SQL.Add('delete from afterselldetails where tid="' + Label26.Caption + '"');
              ADOQuerySQL.ExecSQL;
            end
            else
              Exit;
          end
          else
          begin
            if messagedlg('确认删除"' + ADOQuery1.FieldByName('goodsname').AsString + '"吗?', mtconfirmation, [mbyes, mbno], 0) = mryes then
            begin
              //ADOQuery1.Delete;
              ADOQuerySQL.SQL.Clear;
              ADOQuerySQL.SQL.Add('delete from afterselldetails where tid="' + Label26.Caption + '" and pid="' + ADOQuery1.FieldByName('pid').AsString + '"');
              ADOQuerySQL.ExecSQL;
            end;
          end;

          QH1;
          QH2;
        end
        else
        begin
          ShowMessage('没有商品记录~~!');
        end;
      end;

    VK_ADD: //增加产品数量，不能超过原有订单中同类商品的数量
      begin
        if ADOQuery1.RecordCount > 0 then
        begin
          if ADOQuery1.FieldByName('pid').AsString = '' then //合计行
          begin
            {暂不支持批量增加数量}
          end
          else
          begin
            ADOQuery2.SQL.Clear;
            ADOQuery2.SQL.Add('select * from selllogmains where nextid="' + Main_T.Label26.Caption + '" and type="售后中"');
            ADOQuery2.Open;
            if ADOQuery2.RecordCount < 1 then
            begin
              ShowMessage('"' + Main_T.Label26.Caption + '"没有找到原始订单信息，请联系管理员~~!');
              Exit;
            end
            else
            begin
              slid := ADOQuery2.FieldByName('slid').AsString;

              ADOQuery2.SQL.Clear;
              ADOQuery2.SQL.Add('select * from selllogdetails where slid="' + slid + '" and pid="' + ADOQuery1.FieldByName('pid').AsString + '"');
              ADOQuery2.Open;

              //一类产品的数量不能超过原始订单中的产品数量
              if ADOQuery1.FieldByName('amount').AsInteger < ADOQuery2.FieldByName('amount').AsInteger then
              begin
                ADOQuerySQL.SQL.Clear;
                ADOQuerySQL.SQL.Add('update afterselldetails set amount=(amount+1),updated_at=now()  where tid="' + Label26.Caption + '" and pid="' + ADOQuery1.FieldByName('pid').AsString + '"');
                ADOQuerySQL.ExecSQL;
              end
              else
              begin
                ShowMessage('退货数量不能超过原订单中产品数量~~!');
                Exit;
              end;
            end;
          end;

          QH1;
          QH2;
        end;

      end;

    VK_SUBTRACT: //减少产品数量,拆分记录
      begin
        if ADOQuery1.RecordCount > 0 then
        begin
          if ADOQuery1.FieldByName('pid').AsString = '' then
          begin
            if messagedlg('减少当前订单中所有产品数量吗?', mtconfirmation, [mbyes, mbno], 0) = mryes then
            begin
              ADOQuerySQL.SQL.Clear;
              ADOQuerySQL.SQL.Add('update afterselldetails set amount=(if(amount>1,amount-1,amount)),updated_at=now()  where tid="' + Label26.Caption + '"');
              ADOQuerySQL.ExecSQL;
            end
            else
              Exit;
          end
          else
          begin
            if ADOQuery1.FieldByName('amount').AsCurrency > 1 then
            begin
              ADOQuerySQL.SQL.Clear;
              ADOQuerySQL.SQL.Add('update afterselldetails set amount=(amount-1),updated_at=now()  where tid="' + Label26.Caption + '" and pid="' + ADOQuery1.FieldByName('pid').AsString + '"');
              ADOQuerySQL.ExecSQL;
            end;
          end;

          QH1;
          QH2;
        end;
      end;

  end;
end;

{修改折扣信息}

procedure TMain_T.RzEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    if ADOQuery1.RecordCount > 0 then
    begin
      //输入数据检查
      try
        StrToInt(RzEdit1.Text);
        if StrToInt(RzEdit1.Text) < 1 then
        begin
          ShowMessage('折扣不能小于1~~!');
          RzEdit1.Text := '100';
          Exit;
        end;
      except
        ShowMessage('输入非法字符~~!');
        RzEdit1.Text := '100';
        Exit;
      end;

      ADOQuerySQL.SQL.Clear;
      ADOQuerySQL.SQL.Add('update afterselldetails set discount="' + RzEdit1.Text + '",updated_at=now() where tid = "' + Label26.Caption + '" and pid="' + ADOQuery1.FieldByName('pid').AsString + '"');
      ADOQuerySQL.ExecSQL;

      QH1;
      QH2;
    end;
    RzEdit1.Text := '100';
    RzEdit4.SetFocus;
  end;
end;

{修改数量}

procedure TMain_T.RzEdit3KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    if ADOQuery1.RecordCount > 0 then
    begin
      //输入数据检查
      try
        StrToCurr(RzEdit3.Text);
        if StrToCurr(RzEdit3.Text) < 0 then
        begin
          ShowMessage('商品数量不能小于零~~!');
          RzEdit3.Text := '1';
          Exit;
        end;
      except
        ShowMessage('输入非法字符~~!');
        Exit;
      end;

      ADOQuerySQL.SQL.Clear;
      ADOQuerySQL.SQL.Add('update afterselldetails set amount="' + RzEdit3.Text + '",updated_at=now() where tid = "' + Label26.Caption + '" and pid="' + ADOQuery1.FieldByName('pid').AsString + '"');
      ADOQuerySQL.ExecSQL;

      QH1;
      QH2;
    end;
    RzEdit3.Text := '1';
    RzEdit4.SetFocus;
  end;
end;


{修改件数}

procedure TMain_T.RzEdit5KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    if ADOQuery1.RecordCount > 0 then
    begin
      //输入数据检查
      try
        StrToCurr(RzEdit5.Text);
        if StrToCurr(RzEdit5.Text) < 0 then
        begin
          ShowMessage('商品件数不能小于零~~!');
          RzEdit5.Text := '1';
          Exit;
        end;
      except
        ShowMessage('输入非法字符~~!');
        Exit;
      end;

      ADOQuerySQL.SQL.Clear;
      ADOQuerySQL.SQL.Add('update afterselldetails set bundle="' + RzEdit5.Text + '",updated_at=now() where tid = "' + Label26.Caption + '" and pid="' + ADOQuery1.FieldByName('pid').AsString + '"');
      ADOQuerySQL.ExecSQL;

      QH1;
      QH2;
    end;
    RzEdit5.Text := '1';
    RzEdit4.SetFocus;
  end;
end;

{修改单价}

procedure TMain_T.RzEdit2KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    if ADOQuery1.RecordCount > 0 then
    begin
      //输入数据检查
      try
        StrToCurr(RzEdit2.Text);
        if StrToCurr(RzEdit2.Text) < 0 then
        begin
          ShowMessage('商品售价不能为负数~~!');
          RzEdit1.Text := '100';
          Exit;
        end;
      except
        ShowMessage('输入非法字符~~!');
        Exit;
      end;

      ADOQuerySQL.SQL.Clear;
      ADOQuerySQL.SQL.Add('update afterselldetails set outprice="' + RzEdit2.Text + '",updated_at=now() where tid = "' + Label26.Caption + '" and pid="' + ADOQuery1.FieldByName('pid').AsString + '"');
      ADOQuerySQL.ExecSQL;

      QH1;
      QH2;
    end;
    RzEdit4.SetFocus;
  end;
end;


{上下移动列表行时更新数据}

procedure TMain_T.DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  RzEdit1.Text := ADOQuery1.FieldByName('discount').AsString;
  RzEdit2.Text := ADOQuery1.FieldByName('outprice').AsString;
  RzEdit3.Text := ADOQuery1.FieldByName('amount').AsString;
  RzEdit5.Text := ADOQuery1.FieldByName('bundle').AsString;
  RzComboBox1.Text := ADOQuery1.FieldByName('type').AsString;
end;

procedure TMain_T.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  RzEdit1.Text := ADOQuery1.FieldByName('discount').AsString;
  RzEdit2.Text := ADOQuery1.FieldByName('outprice').AsString;
  RzEdit3.Text := ADOQuery1.FieldByName('amount').AsString;
  RzEdit5.Text := ADOQuery1.FieldByName('bundle').AsString;
  RzComboBox1.Text := ADOQuery1.FieldByName('type').AsString;
end;

{根据条码找商品}

procedure TMain_T.RzEdit4KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    //当输入为空则结账
    if (RzEdit4.Text = '') and (ADOQuery1.RecordCount > 0) then
    begin

      if cbb1.Text = '' then
      begin
        ShowMessage('请选择支付方式~~!');
        cbb1.SetFocus;
        Exit;
      end;

      Gathering := TGathering.create(application);
      Gathering.showmodal;
      Exit;
    end;

    {流程要求先输入客户名称}
    //检查货物数量
    if edt1.Text = '' then
    begin
      ShowMessage('请先输入客户信息再开始下单~~!');
      edt1.SetFocus;
      Exit;
    end;

    {提供客户选择产品的功能}
    if QP <> nil then
      QP.ShowModal
    else
    begin
      QP := TQP.Create(Application);
      QP.ShowModal;
    end;


    //在库存中按条码查找商品
    ADOQuerySQL.SQL.Clear;
    ADOQuerySQL.SQL.Add('Select * from stocks Where pid="' + RzEdit4.Text + '"');
    ADOQuerySQL.ExecSQL;
    if ADOQuerySQL.RecordCount <> 0 then
    begin
      WRecord;
      RzEdit4.Text := '';
      RzEdit4.SetFocus;
    end;
  end;
  if (key = #43) or (key = #45) then
    key := #0;
end;


{根据客户姓名模糊查询该客户的历史订单}

procedure TMain_T.edt1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    if QHD <> nil then
      QHD.ShowModal
    else
    begin
      QHD := TQHD.Create(Application);
      QHD.ShowModal;
      //RzEdit4.SetFocus;
    end;
  end;
  if (key = #43) or (key = #45) then
    key := #0;

end;

{根据客户编号查询客户偏好托运部}

procedure TMain_T.edt4KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin

    {流程要求先输入客户名称}
  //检查客户编号
    if edt7.Text = '' then
    begin
      if messagedlg('这是新客户吗？', mtconfirmation, [mbyes, mbno], 0) = mryes then
        Exit;
    end;

    if QS <> nil then
      QS.ShowModal
    else
    begin
      QS := TQS.Create(Application);
      QS.ShowModal;
    end;
  end;
  if (key = #43) or (key = #45) then
    key := #0;
end;

procedure TMain_T.qrlbl12Print(sender: TObject; var Value: string);
begin
  Value := '第' + IntToStr(QuickRep1.QRPrinter.PageNumber) + '页 / 共' + IntToStr(FTotalPages) + '页';
end;

procedure TMain_T.edt8KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    if QC_S <> nil then
      QC_S.ShowModal
    else
    begin
      QC_S := TQC_S.Create(Application);
      QC_S.ShowModal;
    end;
  end;
  if (key = #43) or (key = #45) then
    key := #0;
end;

procedure TMain_T.edt2KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    if QC_T <> nil then
      QC_T.ShowModal
    else
    begin
      QC_T := TQC_T.Create(Application);
      QC_T.ShowModal;
    end;
  end;
  if (key = #43) or (key = #45) then
    key := #0;
end;

procedure TMain_T.FormHide(Sender: TObject);
begin
  Main.Show;
end;

procedure TMain_T.FormActivate(Sender: TObject);
begin
  Main.Hide;

  Main_T.Width := 1045; //恢复主窗口大小
  Main_T.Height := 810; //恢复主窗口大小


  //使主窗口位于屏幕正中央
  Main_T.Top := (GetSystemMetrics(SM_CySCREEN) - Main_T.Height) div 2 - 13;
  Main_T.Left := (GetSystemMetrics(SM_CxSCREEN) - Main_T.Width) div 2;

end;

procedure TMain_T.RzComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;

    if (RzComboBox1.Text <> '') and (RzComboBox1.Text <> '退货') and (RzComboBox1.Text <> '维修') and (RzComboBox1.Text = '补发') then
    begin
      ShowMessage('请选择有效的售后类型~~!');
      Exit;
    end
    else
    begin

      if ADOQuery1.FieldByName('pid').AsString = '' then
      begin
        if messagedlg('设置当前订单中的所有商品售后属性吗?', mtconfirmation, [mbyes, mbno], 0) = mryes then
        begin
          ADOQuerySQL.SQL.Clear;
          ADOQuerySQL.SQL.Add('update afterselldetails set type="' + RzComboBox1.Text + '",updated_at=now() where tid="' + Label26.Caption + '"');
          ADOQuerySQL.ExecSQL;
        end
        else
          Exit;
      end
      else
      begin
        ADOQuerySQL.SQL.Clear;
        ADOQuerySQL.SQL.Add('update afterselldetails set type="' + RzComboBox1.Text + '",updated_at=now() where tid="' + Label26.Caption + '" and pid="' + ADOQuery1.FieldByName('pid').AsString + '"');
        ADOQuerySQL.ExecSQL;
      end;
    end;
    QH1;
    QH2;

    RzEdit4.SetFocus;
  end;
end;

end.

