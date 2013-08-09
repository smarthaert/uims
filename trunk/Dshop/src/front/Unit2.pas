unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, StdCtrls, Grids, DBGrids, DB, ADODB, INIFiles,
  RzForms, RzStatus, Mask, RzEdit, QRCtrls, QuickRpt, Registry, DBTables;

type
  TMain = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ADOQuery2: TADOQuery;
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
    Label22: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Panel5: TPanel;
    QuickRep1: TQuickRep;
    DetailBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    PageHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRShape2: TQRShape;
    QRShape1: TQRShape;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    SummaryBand1: TQRBand;
    QRLabel7: TQRLabel;
    QRShape7: TQRShape;
    QRLabel9: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel13: TQRLabel;
    QRShape8: TQRShape;
    QRLabel14: TQRLabel;
    Label30: TLabel;
    QRShape3: TQRShape;
    QRShape6: TQRShape;
    QRShape5: TQRShape;
    QRShape4: TQRShape;
    ADOConnection1: TADOConnection;
    ADOQuery3: TADOQuery;
    RzEdit4: TRzEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure QuickRep1StartPage(Sender: TCustomQuickRep);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RzEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure RzEdit3KeyPress(Sender: TObject; var Key: Char);
    procedure RzEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RzEdit4KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    procedure QH1;
    procedure WRecord;
    procedure QH2;
    { Public declarations }
  end;

var
  Main: TMain;

implementation

uses Unit1, Unit3, Unit4, Unit5, Unit10, Unit7;

{$R *.dfm}

procedure TMain.FormCreate(Sender: TObject);
var
  vIniFile      : TIniFile;
  Reg           : TRegistry;
  D1, Data, SID : String;
  i             : Integer;
begin
  {
  //建立INI文件关联
  vIniFile:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'Config.Ini');
  //写是否为注册版本
  if Pass.Key(vIniFile.Readstring('System','PCID',''))=vIniFile.Readstring('System','Key','') then
  begin
    Main.Label1.Caption:='（已注册）';
  end
  else
  begin
    Reg:=TRegistry.Create;
    Reg.RootKey:=HKEY_CURRENT_USER;
    Reg.OpenKey('Software\WL',True);
    D1:=CurrToStr(44-(StrToDate(FormatdateTime('yyyy-mm-dd', Now))-StrToDate(Reg.ReadString('Date'))));
    Main.Label1.Caption:='（未注册）剩余'+D1+'天';
    Main.SpeedButton2.Caption:='F12.软件注册';
    //打开注册窗口
//    RegKey:=TRegKey.Create(Application);
//    RegKey.showmodal;
  end;
  }
  Main.Width:=798;//恢复主窗口大小
  Main.Height:=571;//恢复主窗口大小
  //使主窗口位于屏幕正中央
  Main.Top :=(GetSystemMetrics(SM_CySCREEN)-Main.Height) div 2 - 13;
  Main.Left :=(GetSystemMetrics(SM_CxSCREEN)-Main.Width) div 2;
  //建立数据库链接
  {
  Data:='Provider='+vIniFile.Readstring('System','Provider','')+';';
  Data:=Data+'Data Source='+vIniFile.Readstring('System','Data Source','')+';';
  Data:=Data+'Persist Security Info=False';
  ADOConnection1.ConnectionString:=Data;
  }
  ADOConnection1.ConnectionString:='Provider=MSDASQL.1;' +
            'Persist Security Info=False;' +
            'User ID=root;' +
            'Password=zaqwsxcde123;' +
            'Data Source=shop';
  //初始单号
  for i:=1 to 9999 do
  begin
    SID:=FormatdateTime('yymmdd', Now)+FormatFloat('0000',i);
    ADOQuery2.SQL.Clear;
    ADOQuery2.SQL.Add('Select * from sell_main Where InvoiceID="'+SID+'"');
    ADOQuery2.Open;
    if ADOQuery2.RecordCount=0 then
    begin
      Break;
    end;
  end;
  //读取单号
  Label26.Caption:=SID;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from sell_minor Where InvoiceID="'+Label26.Caption+'"');
  ADOQuery1.Open;
  QH2;
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if messagedlg('确认退出吗？',mtconfirmation,[mbyes,mbno],0)=mryes then
    Application.Terminate
  else
    Action:=caNone;
end;

procedure TMain.SpeedButton1Click(Sender: TObject);
begin
  Main.Close;
end;



procedure TMain.SpeedButton2Click(Sender: TObject);
begin
  if SpeedButton2.Caption='F12.软件注册' then begin
    //打开注册窗口
    RegKey:=TRegKey.Create(Application);
    RegKey.showmodal;
  end else begin
    //使主窗口位于屏幕正中央
    Main.Top :=(GetSystemMetrics(SM_CySCREEN)-Main.Height) div 2 - 13;
    Main.Left :=(GetSystemMetrics(SM_CxSCREEN)-Main.Width) div 2;
  end;
end;

procedure TMain.QuickRep1StartPage(Sender: TCustomQuickRep);
var
  vIniFile: TIniFile;
begin
  vIniFile:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'Config.Ini');
  QRLabel1.Caption:=viniFile.ReadString('System','Name','');
  QRLabel2.Caption:=viniFile.ReadString('System','La1','');
  QRLabel13.Caption:='电话:'+viniFile.ReadString('System','TEL','');
  QRLabel14.Caption:=viniFile.ReadString('System','La2','');
  QRLabel7.Caption:='应收:'+Label14.Caption+'元';
  QRLabel8.Caption:='实收:'+Label15.Caption+'元';
  QRLabel9.Caption:='找零:'+Label16.Caption+'元';
  QRLabel10.Caption:='收款:'+Label19.Caption;
  QRLabel11.Caption:='日期:'+FormatDateTime('dddddd tt', Now);
  QRLabel12.Caption:='单号:№'+Label26.Caption;
end;

procedure TMain.QH1;
var
  sum:Double;
begin
  
  ADOQuery1.Refresh;
  //计算合计数
  //如果是赠品小计为零
  ADOQuery1.Edit;
  if ADOQuery1.FieldByName('Gift').AsString='赠品' then begin
    ADOQuery1.FieldByName('Subtotal').AsCurrency := 0;
    ADOQuery1.Post;
    Exit;
  end;
  //单条记录求合：小计=售价*数量*折扣/100
  sum := ADOQuery1.FieldByName('SellPrice').AsCurrency*
                                                  ADOQuery1.FieldByName('SellScalar').AsCurrency*
                                                  ADOQuery1.FieldByName('Agio').AsCurrency/100;
  
  ADOQuery1.FieldByName('Subtotal').AsCurrency := sum;
  ADOQuery1.Post;
  ADOQuery1.Refresh;
end;

procedure TMain.WRecord;
begin
  //数据检查
  try
    StrToCurr(RzEdit1.Text);
  Except
   RzEdit1.Text:='100';
  end;

  try
    StrToCurr(RzEdit3.Text);
  Except
    RzEdit3.Text:='1';
  end;

  //初始折扣和数量
  RzEdit1.Text:='100';
  RzEdit3.Text:='1';

  //查销售主库是否有此单号
  ADOQuery3.SQL.Clear;
  ADOQuery3.SQL.Add('Select * from sell_main Where InvoiceID="'+Label26.Caption+'"');
  ADOQuery3.Open;
  if ADOQuery3.RecordCount=0 then begin
    ADOQuery3.Edit;
    ADOQuery3.Append;
    ADOQuery3.FieldByName('InvoiceID').AsString := Label26.Caption;
    ADOQuery3.FieldByName('AR').AsString  := Label7.Caption;
    ADOQuery3.FieldByName('Hang').AsString := '0';
    ADOQuery3.FieldByName('SellDate').AsString  := FormatdateTime('yyyy-mm-dd hh:mm:ss', Now);
    ADOQuery3.FieldByName('UserName').AsString  := Label19.Caption;
    ADOQuery3.Post;
  end;

  //填扫描记录
  ADOQuery1.Edit;
  ADOQuery1.Append;
  ADOQuery1.FieldByName('InvoiceID').AsString     := Label26.Caption;
  ADOQuery1.FieldByName('BarCode').AsString       := ADOQuery2.FieldByName('BarCode').AsString;
  ADOQuery1.FieldByName('GoodsName').AsString     := ADOQuery2.FieldByName('GoodsName').AsString;
  ADOQuery1.FieldByName('Unit').AsString          := ADOQuery2.FieldByName('Unit').AsString;
  ADOQuery1.FieldByName('SellScalar').AsString    := RzEdit3.Text;
  ADOQuery1.FieldByName('Agio').AsString          := RzEdit1.Text;
  ADOQuery1.FieldByName('PurchasePrice').AsString := ADOQuery2.FieldByName('PurchasePrice').AsString;
  ADOQuery1.FieldByName('SellPrice').AsString     := ADOQuery2.FieldByName('SellPrice').AsString;
  ADOQuery1.FieldByName('Gift').AsString          := '-';
  ADOQuery1.FieldByName('UntreadFlag').AsString   := '-';
  QH1;
  QH2;
end;

procedure TMain.QH2;
begin
  ADOQuery2.SQL.Clear;
  ADOQuery2.SQL.Add('Select SUM(Subtotal) from sell_minor Where InvoiceID="'+Label26.Caption+'"');
  ADOQuery2.Open;
  Label7.Caption := FormatFloat('0.00',ADOQuery2.Fields[0].AsCurrency)
end;

procedure TMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  SID : String;
  i   : Integer;
begin
  case key of
    VK_ESCAPE:SpeedButton1.Click;

    VK_SPACE :
    begin
      //检查货物数量
      if ADOQuery1.RecordCount<1 then begin
        ShowMessage('没有商品记录~~!');
        Exit;
      end else begin
        Gathering:=TGathering.Create(Application);
        Gathering.ShowModal;
      end;
    end;

    VK_F1:RzEdit4.SetFocus;

    VK_F2:RzEdit1.SetFocus;

    VK_F3:RzEdit2.SetFocus;

    VK_F4:RzEdit3.SetFocus;

    VK_F5: begin
      if ADOQuery1.FieldByName('Gift').AsString='-' then begin
        if ADOQuery1.RecordCount>0 then begin
          ADOQuery1.Edit;
          ADOQuery1.FieldByName('Gift').AsString:='赠品';
        end;
        QH1;
        QH2;
      end else begin
        if ADOQuery1.RecordCount>0 then begin
          ADOQuery1.Edit;
          ADOQuery1.FieldByName('Gift').AsString:='-';
        end;
        QH1;
        QH2;
      end;
    end;
    VK_F6:begin
      //初始单号
      for i:=1 to 9999 do
      begin
        SID:=FormatdateTime('yymmdd', Now)+FormatFloat('0000',i);
        ADOQuery2.SQL.Clear;
        ADOQuery2.SQL.Add('Select * from sell_main Where InvoiceID="'+SID+'"');
        ADOQuery2.Open;
        if ADOQuery2.RecordCount=0 then
        begin
          Break;
        end;
      end;
      //读取单号
      Label26.Caption:=SID;
      ADOQuery1.SQL.Clear;
      ADOQuery1.SQL.Add('Select * from sell_minor Where InvoiceID="'+Label26.Caption+'"');
      ADOQuery1.Open;
      QH2;



    end;

    VK_F7:begin
      if QD<>nil then
        QD.ShowModal
      else begin
        QD:=TQD.Create(Application);
        QD.ShowModal;
      end;
    end;

    VK_F9:begin
      if Pos_Setup<>nil then
        Pos_Setup.ShowModal
      else begin
        Pos_Setup:=TPos_Setup.Create(Application);
        Pos_Setup.ShowModal;
      end;
    end;

    VK_UP:
    begin
      DBGrid1.SetFocus;
    end;

    VK_DOWN:
    begin
      DBGrid1.SetFocus;
    end;

    VK_DELETE: begin
      if ADOQuery1.RecordCount>0 then begin
        if messagedlg('确认删除"'+ADOQuery1.FieldByName('GoodsName').AsString+'"吗?',mtconfirmation,[mbyes,mbno],0)=mryes then begin
          ADOQuery1.Delete;
          QH2;
        end;
      end else begin
        ShowMessage('没有商品记录~~!');
      end;
    end;

    VK_ADD: begin
      ADOQuery1.Edit;
      ADOQuery1.FieldByName('SellScalar').AsCurrency:=ADOQuery1.FieldByName('SellScalar').AsCurrency+1;
      QH1;
      QH2;
    end;

    VK_SUBTRACT: begin
      if ADOQuery1.FieldByName('SellScalar').AsCurrency>1 then begin
        ADOQuery1.Edit;
        ADOQuery1.FieldByName('SellScalar').AsCurrency:=ADOQuery1.FieldByName('SellScalar').AsCurrency-1;
        QH1;
        QH2;
      end;
    end;
  end;
end;

procedure TMain.RzEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then begin
    key:=#0;
    if ADOQuery1.RecordCount>0 then begin
    //输入数据检查
      try
        StrToInt(RzEdit1.Text);
        if StrToInt(RzEdit1.Text)<1 then begin
          ShowMessage('折扣不能小于1~~!');
          RzEdit1.Text:='100';
          Exit;
        end;
        Except
        ShowMessage('输入非法字符~~!');
        RzEdit1.Text:='100';
        Exit;
      end;
      ADOQuery1.Edit;
      ADOQuery1.FieldByName('Agio').AsString:=RzEdit1.Text;
      ADOQuery1.Post;
      QH1;
      QH2;
    end;
    RzEdit1.Text:='100';
    RzEdit4.SetFocus;
  end;
end;

procedure TMain.RzEdit3KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
    key:=#0;
    if ADOQuery1.RecordCount>0 then begin
      //输入数据检查
      try
        StrToCurr(RzEdit3.Text);
        if StrToCurr(RzEdit3.Text)<0 then begin
          ShowMessage('商品数量不能小于零~~!');
          RzEdit3.Text:='1';
          Exit;
        end;
      Except
        ShowMessage('输入非法字符~~!');
        Exit;
      end;
      ADOQuery1.Edit;
      ADOQuery1.FieldByName('SellScalar').AsString:=RzEdit3.Text;
      ADOQuery1.Post;
      QH1;
      QH2;
      end;
    RzEdit3.Text:='1';
    RzEdit4.SetFocus;
  end;
end;

procedure TMain.RzEdit2KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
    key:=#0;
    if ADOQuery1.RecordCount>0 then begin
      //输入数据检查
      try
        StrToCurr(RzEdit2.Text);
        if StrToCurr(RzEdit2.Text)<0 then begin
          ShowMessage('商品售价不能为负数~~!');
          RzEdit1.Text:='100';
          Exit;
        end;
      Except
        ShowMessage('输入非法字符~~!');
        Exit;
      end;
      ADOQuery1.Edit;
      ADOQuery1.FieldByName('SellPrice').AsString:=RzEdit2.Text;
      ADOQuery1.Post;
      QH1;
      QH2;
    end;
    RzEdit4.SetFocus;
  end;
end;

procedure TMain.DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  RzEdit1.Text:=ADOQuery1.FieldByName('Agio').AsString;
  RzEdit2.Text:=ADOQuery1.FieldByName('SellPrice').AsString;
  RzEdit3.Text:=ADOQuery1.FieldByName('SellScalar').AsString;
end;

procedure TMain.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  RzEdit1.Text:=ADOQuery1.FieldByName('Agio').AsString;
  RzEdit2.Text:=ADOQuery1.FieldByName('SellPrice').AsString;
  RzEdit3.Text:=ADOQuery1.FieldByName('SellScalar').AsString;
end;

procedure TMain.RzEdit4KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then begin
    //当输入为空则结账
    if (RzEdit4.Text='')and(ADOQuery1.RecordCount>0) then begin
      Gathering:=TGathering.create(application);
      Gathering.showmodal;
      Exit;
    end;
    //在库存中按条码查找商品
    ADOQuery2.SQL.Clear;
    ADOQuery2.SQL.Add('Select * from stock Where BarCode="'+RzEdit4.Text+'"');
    ADOQuery2.Open;
    if ADOQuery2.RecordCount<>0 then begin
      WRecord;
      RzEdit4.Text:='';
      RzEdit4.SetFocus;
    end else begin
      //如果按条码查找没有则按拼音查找
      ADOQuery2.SQL.Clear;
      ADOQuery2.SQL.Add('Select * from stock Where PYBrevity="'+RzEdit4.Text+'"');
      ADOQuery2.Open;
      if ADOQuery2.RecordCount<>0 then begin
        if ADOQuery2.RecordCount>1 then begin
          Sele:=TSele.Create(Application);
          Sele.showmodal;
          Exit;
        end;
        WRecord;
        RzEdit4.Text:='';
        RzEdit4.SetFocus;
      end else begin
        //拼音查找没有提示
        showmessage('无此商品ID'+#13#13+'注意核对~~!');
        RzEdit4.Text:='';
        RzEdit4.SetFocus;
      end;
    end;
  end;
  if (key=#43) or (key=#45) then
    key:=#0;
end;

end.
