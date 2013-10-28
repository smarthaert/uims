unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  StdCtrls, ShellAPI, ComCtrls, DB, GridsEh, DBGridEh, ASGSQLite3, ExtCtrls,
  IniFiles, ExtDlgs, ImgList, WinSkinData, U_TDownFile, Menus, ToolWin,HTTPApp,
  dxGDIPlusClasses;

type
  TFrmMain = class(TForm)
    pgc1: TPageControl;
    tsGeneral: TTabSheet;
    ts2: TTabSheet;
    Btn2: TButton;
    ts3: TTabSheet;
    ASQLite3DB1: TASQLite3DB;
    ds1: TDataSource;
    ASQLite3Table1: TASQLite3Table;
    ASQLite3Table2: TASQLite3Table;
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    EdtStopTime: TEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    Edt2: TEdit;
    grp2: TGroupBox;
    Chk1: TCheckBox;
    Chk2: TCheckBox;
    rg2: TRadioGroup;
    grp3: TGroupBox;
    MemoXX1: TMemo;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    MemoXX2: TMemo;
    MemoXX3: TMemo;
    grp4: TGroupBox;
    grp5: TGroupBox;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    EdtHM1: TEdit;
    EdtHM2: TEdit;
    EdtHM3: TEdit;
    Btn3: TButton;
    grp6: TGroupBox;
    RbGetBuyer: TRadioButton;
    RbGetSeller: TRadioButton;
    Btn1: TButton;
    Btn4: TButton;
    MemoWangZhi: TMemo;
    grp7: TGroupBox;
    tv1: TTreeView;
    Btnadd: TButton;
    BtnDel: TButton;
    BtnTg: TButton;
    BtnOutTxt: TButton;
    BtnInTxT: TButton;
    Edt1: TEdit;
    lbl11: TLabel;
    lbl12: TLabel;
    grp8: TGroupBox;
    lbl13: TLabel;
    Btn5: TButton;
    Btn6: TButton;
    Btn7: TButton;
    Btn8: TButton;
    SaveDlgToText: TSaveTextFileDialog;
    OpenDlgFromText: TOpenTextFileDialog;
    stat1: TStatusBar;
    lvSendList: TListView;
    BtnClean: TButton;
    il1: TImageList;
    lbl14: TLabel;
    lbl15: TLabel;
    Chkverify: TCheckBox;
    lbl16: TLabel;
    ChkSFYZ: TCheckBox;
    lbl17: TLabel;
    lbl18: TLabel;
    EdtYZSJ: TEdit;
    lbl19: TLabel;
    lbl20: TLabel;
    lbl21: TLabel;
    lvRunList: TListView;
    SkinData1: TSkinData;
    pnl1: TPanel;
    grp9: TGroupBox;
    tmr1: TTimer;
    Dbgrd1: TDBGridEh;
    pm1: TPopupMenu;
    as1: TMenuItem;
    dfs1: TMenuItem;
    tlb1: TToolBar;
    btn9: TToolButton;
    tsAuto: TTabSheet;
    grp10: TGroupBox;
    lvAutoSend: TListView;
    Btn10: TButton;
    lbl23: TLabel;
    Edt3: TEdit;
    Btn11: TButton;
    lbl22: TLabel;
    EdtYZXX: TEdit;
    img1: TImage;
    lblGG: TLabel;
    Btn12: TButton;
    Btn13: TButton;
    Btn14: TButton;
    Btn15: TButton;
    grp11: TGroupBox;
    lbl24: TLabel;
    lbl25: TLabel;
    EdtHowMsg: TEdit;
    rg1: TRadioGroup;
    lbl26: TLabel;
    lbl27: TLabel;
    Edt4: TEdit;
    Chk5: TCheckBox;
    Chk4: TCheckBox;
    Chk3: TCheckBox;
    procedure Btn1Click(Sender: TObject);
    procedure Btn2Click(Sender: TObject);
    procedure Btn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdtStopTimeKeyPress(Sender: TObject; var Key: Char);
    procedure Edt2KeyPress(Sender: TObject; var Key: Char);
    procedure Btn4Click(Sender: TObject);
    procedure BtnaddClick(Sender: TObject);
    procedure tv1Change(Sender: TObject; Node: TTreeNode);
    procedure BtnDelClick(Sender: TObject);
    procedure ASQLite3Table2BeforeDelete(DataSet: TDataSet);
    procedure BtnTgClick(Sender: TObject);
    procedure Btn5Click(Sender: TObject);
    procedure ASQLite3Table3AfterPost(DataSet: TDataSet);
    procedure ASQLite3Table3AfterCancel(DataSet: TDataSet);
    procedure Btn6Click(Sender: TObject);
    procedure Btn7Click(Sender: TObject);
    procedure Btn8Click(Sender: TObject);
    procedure BtnOutTxtClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnInTxTClick(Sender: TObject);
    procedure ASQLite3Table1AfterOpen(DataSet: TDataSet);
    procedure BtnCleanClick(Sender: TObject);
    procedure EdtYZSJChange(Sender: TObject);
    procedure Edt2Change(Sender: TObject);
    procedure EdtStopTimeChange(Sender: TObject);
    procedure lvRunListColumnClick(Sender: TObject; Column: TListColumn);
    procedure FormShow(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure lblGGMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lblGGMouseLeave(Sender: TObject);
    procedure dfs1Click(Sender: TObject);
    procedure as1Click(Sender: TObject);
    procedure EdtYZSJKeyPress(Sender: TObject; var Key: Char);
    procedure Btn10Click(Sender: TObject);
    procedure Btn11Click(Sender: TObject);
    procedure pgc1Change(Sender: TObject);
    procedure Btn12Click(Sender: TObject);
    procedure Btn15Click(Sender: TObject);
    procedure Btn13Click(Sender: TObject);
    procedure Btn14Click(Sender: TObject);
  private
    FDownFile : TDownFile;
    { Private declarations }
  public

    { Public declarations }
  end;


TThreadYHID = class(TThread) { 声明线程类 }
  private

  protected
    procedure Execute; override;{ 执行线程的方法 }
  public
    id: Cardinal; //1: 发送信息  2: 获取旺旺买家ID   3: 获取旺旺卖家ID
    procedure SendMsg();//发送信息
    procedure GetBuyer(); //获取旺旺买家ID
    procedure GetSeller(); //获取旺旺卖家ID
    procedure SelfUpdate();//自动更新
  end;

const
  version = 'V1.2.2 测试版';
  Url='http://menghun932.dns36.ceshi6.com/download/update/seekwang/';
  VerFile='Ver.html';
  Bulletin='Bulletin.html';
  UpdateFile= 'seekwang.exe';
var
  FrmMain: TFrmMain;
  AppPath:String;//系统路径
  Ppp, PHwnd, PrHwnd, MenuBtnHwnd, memu: LongInt;
  IDEdtHwnd, SendBtnHwnd: LongInt;
  wndhwnd: HWND;
  ThreadSendMsg, ThreadGetBuyer, ThreadGetSeller, ThreadUpdate: TThreadYHID;

  MyInifile: TInifile;
  StWwHwnd: TStringList;//已经打开的旺旺句柄
  StBulletin: TStringList;//公告栏信息
  IdBulletin: Integer;//公告栏信息顺序号
  sSendWangWang: string;//指定的发送号

  function EnumChildWndProc(AhWnd: LongInt;AlParam: lParam): boolean; stdcall; //枚举找到聊天窗口的所有子控件句柄
  function EnumChildSendID(AhWnd: LongInt;AlParam: lParam): boolean; stdcall; //枚举找到旺旺的所有子控件句柄
  function EnumWndProc(hwnd:THandle;lparam:LPARAM):Boolean;stdcall;//枚举找到所有已经打开的旺旺
  function ToUTF8Encode(str: string): string;//汉字转UTF-8
  function WangWangOnLine(str: string): Boolean; //旺旺是否在线;
  function DengDaiYanZhen(i: Integer):Boolean;//输入验证码
  function JianHaoYou(i: Integer): Boolean;//添加为好友
  procedure FaXiaoXi();//发送消息
  function ZhiDingWangWang(i: Integer;var SendIDHWnd: LongInt):Boolean;//指定发送号

implementation

uses UntAddDlg, UntRegFrm, UntReg, UntFrmGY, UntFrmAddAutoSend;

{$R *.dfm}


procedure TFrmMain.as1Click(Sender: TObject);
begin
  TFrmGY.Create(nil);
  FrmGY.Show;
end;

procedure TFrmMain.ASQLite3Table1AfterOpen(DataSet: TDataSet);
begin
  Dbgrd1.Columns[0].Width := MyInifile.ReadInteger('GridWidth2','Id',Dbgrd1.Columns[0].Width);
end;

procedure TFrmMain.ASQLite3Table2BeforeDelete(DataSet: TDataSet);
begin
  try
    ASQLite3Table1.DisableControls;
    ASQLite3Table1.First;
    while not ASQLite3Table1.Eof do
      ASQLite3Table1.Delete;
  finally
    ASQLite3Table1.EnableControls;
  end;

end;

procedure TFrmMain.ASQLite3Table3AfterCancel(DataSet: TDataSet);
begin
  Btn5.Enabled := True;
end;

procedure TFrmMain.ASQLite3Table3AfterPost(DataSet: TDataSet);
begin
  Btn5.Enabled := True;
end;

procedure TFrmMain.Btn10Click(Sender: TObject);
var
  AddAutoSend: TFrmAddAutoSend;
begin
  AddAutoSend := TFrmAddAutoSend.Create(nil);
  AddAutoSend.ShowModal;
  AddAutoSend.Free;
end;

procedure TFrmMain.Btn11Click(Sender: TObject);
begin
  OpenDlgFromText.Title := '旺旺位置';
  OpenDlgFromText.Filter := '旺旺执行文件(*.exe)|*.exe';
  if OpenDlgFromText.Execute then
  begin
    edt3.Text := OpenDlgFromText.FileName;
  end;
end;

procedure TFrmMain.Btn12Click(Sender: TObject);
begin
  if lvAutoSend.Selected <> nil then
    lvAutoSend.Selected.Delete;
end;

procedure TFrmMain.Btn13Click(Sender: TObject);
var
  TxtFile: TextFile;
  ln:string;
  i:Integer;
begin
  SaveDlgToText.InitialDir := ExtractFilePath( Application.ExeName );
  SaveDlgToText.FileName := '智能推广用户信息.txt';
  SaveDlgToText.Title := '保存用户信息';
  SaveDlgToText.Filter := '文本文件(*.txt)|*.txt';
  if lvAutoSend.Items.Count < 1 then
  begin
    Application.MessageBox('列表是空的！','提示',MB_OK);
    exit;
  end;
  if SaveDlgToText.Execute then
  begin
    if FileExists(SaveDlgToText.FileName) then   //判断文件是否已经存在
       if Application.MessageBox('文件已经存在，是否覆盖？','文件已经存在',MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) <> IDYES then
         Exit;
    AssignFile(TxtFile, SaveDlgToText.FileName);
    Rewrite(TxtFile);
    for i := 0 to lvAutoSend.Items.Count-1 do
    begin
      ln:=lvAutoSend.Items.Item[i].Caption + '|' + lvAutoSend.Items.Item[i].SubItems.Strings[0];
      writeln(TxtFile,ln);
    end;
    CloseFile(TxtFile);
    Application.MessageBox('导出文件成功！','提示',MB_OK);
  end;
end;

procedure TFrmMain.Btn14Click(Sender: TObject);
var
  TxtFile: TextFile;
  ln:string;
  NewItem: TListItem;
begin
  OpenDlgFromText.InitialDir := ExtractFilePath(Application.ExeName );
  OpenDlgFromText.Title := '导入用户信息';
  OpenDlgFromText.Filter := '文本文件(*.txt)|*.txt';
  if OpenDlgFromText.Execute then
  begin
    AssignFile(TxtFile, OpenDlgFromText.FileName);
    Reset(TxtFile);
    while not eof(TxtFile) do
    begin
      Readln(TxtFile,ln);
      NewItem := lvAutoSend.Items.Add;
      NewItem.Caption := Trim(Copy(ln,1,Pos('|',ln)-1));
      NewItem.SubItems.Add(Trim(Copy(ln,Pos('|',ln)+1,Length(ln))));
    end;
    CloseFile(TxtFile);
    Application.MessageBox('导入文件成功！','提示',MB_OK);
  end;
end;

procedure TFrmMain.Btn15Click(Sender: TObject);
begin
  lvAutoSend.Clear;
end;

procedure TFrmMain.Btn1Click(Sender: TObject);
begin
  if FrmMain.MemoWangZhi.Text = '' then
  begin
    Application.MessageBox('请填写一个网络地址！','提示',MB_OK);
    FrmMain.MemoWangZhi.SetFocus;
    exit;
  end;

  if (tv1.Selected = nil) or (tv1.Selected.Text = '已读取的组ID') then
  begin
    Application.MessageBox('请选取一个组,用来存放查到的ID！','提示',MB_OK);
    tv1.SetFocus;
    exit;
  end;

  if RbGetBuyer.Checked then
  begin
    ThreadGetBuyer := TThreadYHID.Create(True);
    ThreadGetBuyer.FreeOnTerminate := true;
    ThreadGetBuyer.id := 2;
    ThreadGetBuyer.Resume;
  end
  else begin
    ThreadGetSeller := TThreadYHID.Create(True);
    ThreadGetSeller.FreeOnTerminate := true;
    ThreadGetSeller.id := 3;
    ThreadGetSeller.Resume;
  end;
  Btn1.Enabled := not Btn1.Enabled;
  Btn4.Enabled := not Btn1.Enabled;
  RbGetBuyer.Enabled := False;
  RbGetSeller.Enabled := False;
end;

procedure TFrmMain.Btn4Click(Sender: TObject);
begin
  if RbGetBuyer.Checked then
  begin
    ThreadGetBuyer.Suspend;
    ThreadGetBuyer.Terminate;
  end
  else begin
    ThreadGetSeller.Suspend;
    ThreadGetSeller.Terminate;
  end;
  Btn1.Enabled := not Btn1.Enabled;
  Btn4.Enabled := not Btn1.Enabled;
  RbGetBuyer.Enabled := True;
  RbGetSeller.Enabled := True;
end;

procedure TFrmMain.Btn5Click(Sender: TObject);
var
  AddDlg: TFrmAddDlg;
begin
  AddDlg := TFrmAddDlg.Create(nil);
  AddDlg.ShowModal;
  AddDlg.Free;
end;

procedure TFrmMain.Btn6Click(Sender: TObject);
begin
  if lvSendList.Selected <> nil then
    lvSendList.Selected.Delete;
end;

procedure TFrmMain.Btn7Click(Sender: TObject);
begin
  if lvSendList.Selected <> nil then
  begin
    lvSendList.Selected.SubItems.Strings[0] := '待发';
    lvSendList.Selected.SubItemImages[0] := 0;
  end;
end;

procedure TFrmMain.Btn8Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to lvSendList.Items.Count - 1 do
  begin
    lvSendList.Items.Item[i].SubItems.Strings[0] := '待发';
    lvSendList.Items.Item[i].SubItemImages[0] := 0;
  end;
end;

procedure TFrmMain.BtnaddClick(Sender: TObject);
var
  TvChildItem: TTreeNode;
begin
  if Edt1.Text = '' then
  begin
    Application.MessageBox('新组名不能为空！','提示',MB_OK);
    Edt1.SetFocus;
    Abort;
  end;
  if not FrmMain.ASQLite3Table2.Active then
    FrmMain.ASQLite3Table2.Open;
  if ASQLite3Table2.Locate('GroupName',Edt1.Text,[]) then
  begin
    Application.MessageBox('组名已存在，重新输入！','提示',MB_OK);
    Edt1.Text := '';
    Edt1.SetFocus;
    Abort;
  end;
  TvChildItem := tv1.Items.AddChild(tv1.Items[0],Edt1.Text);
  TvChildItem.ImageIndex := 5;
  TvChildItem.SelectedIndex := 6;
  ASQLite3Table2.Append;
  ASQLite3Table2.FieldByName('GroupName').AsString := TvChildItem.Text;
  ASQLite3Table2.Post;
  ASQLite3Table2.Close;
  ASQLite3Table2.Open;
  Edt1.Text := '';
  tv1.SetFocus;
  tv1.Selected := TvChildItem;
end;

procedure TFrmMain.BtnCleanClick(Sender: TObject);
begin
  lvSendList.Clear;
end;

procedure TFrmMain.BtnDelClick(Sender: TObject);
begin
  if (tv1.Selected = nil) or (tv1.Selected.Text = '已读取的组ID') then
  begin
    Application.MessageBox('请选择要删除的ID组！','提示',mb_ok);
    tv1.SetFocus;
    abort;
  end;
  ASQLite3Table2.Locate('GroupName',tv1.Selected.Text,[]);
  ASQLite3Table2.Delete;
  tv1.Selected.Delete;
end;

procedure TFrmMain.BtnInTxTClick(Sender: TObject);
var
  TxtFile: TextFile;
  ln:string;
begin
  if (tv1.Selected = nil) or (tv1.Selected.Text = '已读取的组ID') then
  begin
    Application.MessageBox('请选择要导入数据的数据组！','提示',mb_ok);
    tv1.SetFocus;
    abort;
  end;
  OpenDlgFromText.InitialDir := ExtractFilePath(Application.ExeName );
  OpenDlgFromText.Title := '导入旺旺ID到组';
  OpenDlgFromText.Filter := '文本文件(*.txt)|*.txt';
  if OpenDlgFromText.Execute then
  begin
    AssignFile(TxtFile, OpenDlgFromText.FileName);
    Reset(TxtFile);
    while not eof(TxtFile) do
    begin
      Readln(TxtFile,ln);
      if not ASQLite3Table1.Active then ASQLite3Table1.Open;
      if not ASQLite3Table1.Locate('FL;WwName',VarArrayOf([ASQLite3Table2.FieldByName('AutoId').AsInteger,ln]),[]) then
      begin
        ASQLite3Table1.Append;
        ASQLite3Table1.FieldByName('WwName').AsString := ln;
        ASQLite3Table1.FieldByName('FL').AsInteger := ASQLite3Table2.FieldByName('AutoId').AsInteger;
        ASQLite3Table1.Post;
      end;
//        TxtFile.Next;
    end;
    CloseFile(TxtFile);
    Application.MessageBox('导入文件成功！','提示',MB_OK);
  end;
end;

procedure TFrmMain.BtnOutTxtClick(Sender: TObject);
var
  TxtFile: TextFile;
  ln:string;
begin
  if (tv1.Selected = nil) or (tv1.Selected.Text = '已读取的组ID') then
  begin
    Application.MessageBox('请选择要导出的ID组！','提示',mb_ok);
    tv1.SetFocus;
    abort;
  end;
  SaveDlgToText.InitialDir := ExtractFilePath( Application.ExeName );
  SaveDlgToText.FileName := tv1.Selected.Text;
  SaveDlgToText.Filter := '文本文件(*.txt)|*.txt';
  SaveDlgToText.Title := '导出旺旺ID到TXT文件';
  if SaveDlgToText.Execute then
  begin
    if FileExists(SaveDlgToText.FileName) then   //判断文件是否已经存在
       if Application.MessageBox('文件已经存在，是否覆盖？','文件已经存在',MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) <> IDYES then
         Exit;
    AssignFile(TxtFile, SaveDlgToText.FileName);
    Rewrite(TxtFile);
    try
      ASQLite3Table1.First;
      ASQLite3Table1.DisableControls;
      while not ASQLite3Table1.Eof do
      begin
        ln:=ASQLite3Table1.FieldByName('WwName').AsString;
        writeln(TxtFile,ln);
        ASQLite3Table1.next;
      end;
      CloseFile(TxtFile);
      Application.MessageBox('导出文件成功！','提示',MB_OK);
    finally
      ASQLite3Table1.First;
      ASQLite3Table1.EnableControls;
    end;
  end;

end;

procedure TFrmMain.BtnTgClick(Sender: TObject);
var
  NewItem: TListItem;
begin
  if (tv1.Selected = nil) or (tv1.Selected.Text = '已读取的组ID') then
  begin
    Application.MessageBox('请选择要推广的ID组！','提示',mb_ok);
    tv1.SetFocus;
    abort;
  end;
  try
    ASQLite3Table1.DisableControls;
    ASQLite3Table1.First;
    while not ASQLite3Table1.Eof do
    begin
      //不导入重复的用户名
      if lvSendList.FindCaption(0,ASQLite3Table1.FieldByName('WWName').AsString,False,True,False) = nil then
      begin
        NewItem := lvSendList.Items.Add;
        NewItem.Caption := ASQLite3Table1.FieldByName('WWName').AsString;
        NewItem.ImageIndex := -1;
        NewItem.SubItems.Add('待发');
        NewItem.SubItemImages[0] := 0;
      end;
      ASQLite3Table1.Next;
    end;

    MessageBox(FrmMain.Handle,'成功添加到推广！','提示',mb_ok);
    ASQLite3Table1.First;
  finally
    ASQLite3Table1.EnableControls;
  end;

end;

procedure TFrmMain.dfs1Click(Sender: TObject);
begin
  ShellExecute(0, 'open', Pchar(AppPath+'Help.chm'), nil, nil, SW_SHOWNORMAL);
end;

procedure TFrmMain.Btn3Click(Sender: TObject);
begin
  ThreadSendMsg.Suspend;
  ThreadSendMsg.Terminate;
  Btn2.Enabled := not Btn2.Enabled;
  Btn3.Enabled := not Btn2.Enabled;
end;

procedure TFrmMain.Btn2Click(Sender: TObject);
begin
  ThreadSendMsg := TThreadYHID.Create(True);
  ThreadSendMsg.FreeOnTerminate := true;
  ThreadSendMsg.id := 1;
  ThreadSendMsg.Resume;
  Btn2.Enabled := not Btn2.Enabled;
  Btn3.Enabled := not Btn2.Enabled;
end;

procedure TFrmMain.Edt2Change(Sender: TObject);
begin
  if Edt2.Text = '' then
    Edt2.Text := '0';
end;

procedure TFrmMain.Edt2KeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9',#13,#8]) then
    key := #0;
end;

procedure TFrmMain.EdtYZSJChange(Sender: TObject);
begin
  if EdtYZSJ.Text = '' then
    EdtYZSJ.Text := '0';
end;

procedure TFrmMain.EdtYZSJKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9',#13,#8]) then
    key := #0;
end;

procedure TFrmMain.EdtStopTimeChange(Sender: TObject);
begin
  if EdtStopTime.Text = '' then
    EdtStopTime.Text := '0';
end;

procedure TFrmMain.EdtStopTimeKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9',#13,#8]) then
    key := #0;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  Filename: string;
  TvChildItem: TTreeNode;
begin
  stat1.Panels[0].Text := '版本：' + version;//版本号
  AppPath := ExtractFilePath(ParamStr(0)); //程序路径
  StWwHwnd := TStringList.Create;
  StBulletin := TStringList.Create;
  IdBulletin := 0;

  ASQLite3DB1.DefaultDir := Utf8Encode( ExtractFilePath( Application.ExeName ) ); //避免中文目录时出错
  ASQLite3DB1.DriverDLL := ExtractFilePath( Application.ExeName ) + 'Sqlite3.dll'; //这儿中文没关系
  ASQLite3DB1.Database := Utf8Encode( 'DBS.sqb' ); //如果全是英文，不用转换编码也可以
  ASQLite3DB1.CharacterEncoding := 'STANDARD'; //这个如果不设置，查询出来的中文全是乱码，但如果设置成 UTF8 好像也可以，没去仔细研究

  ASQLite3DB1.Open;

  ASQLite3Table2.Open;
  ASQLite3Table2.First;
  while not ASQLite3Table2.Eof do //读取已经保存的数据组列表
  begin
    TvChildItem := tv1.Items.AddChild(tv1.Items[0],ASQLite3Table2.FieldByName('GroupName').AsString);
    TvChildItem.ImageIndex := 5;
    TvChildItem.SelectedIndex := 6;
    ASQLite3Table2.Next;
  end;
  tv1.FullExpand;

  //把LoginSys.ini文件存储在应用程序当前目录中
  Filename := ExtractFilePath(paramstr(0))+'SysSet.ini';
  MyInifile:= TInifile.Create(Filename);
  Chk1.Checked := MyInifile.ReadBool('SendOptions','AddFriend',False);
  Chk2.Checked := MyInifile.ReadBool('SendOptions','OnlyOnline',True);
  ChkSFYZ.Checked := MyInifile.ReadBool('SendOptions','SFYZ',True);
  rg1.ItemIndex := MyInifile.ReadInteger('SendOptions','MessageNum',0);
  rg2.ItemIndex := MyInifile.ReadInteger('SendOptions','SendIdNum',0);
  EdtStopTime.Text := MyInifile.ReadString('ProgramOptions','StopTime','10');
  Edt2.Text := MyInifile.ReadString('ProgramOptions','DelayTime','4');
  EdtYZSJ.Text := MyInifile.ReadString('ProgramOptions','YzTime','15');
  Chkverify.Checked := MyInifile.ReadBool('ProgramOptions','Ddverify',True);
  lvSendList.Columns.Items[0].Width := MyInifile.ReadInteger('SendList','Id',150);
  lvSendList.Columns.Items[1].Width := MyInifile.ReadInteger('SendList','State',40);
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  MyInifile.WriteBool('SendOptions','AddFriend',Chk1.Checked);
  MyInifile.WriteBool('SendOptions','OnlyOnline',Chk2.Checked);
  MyInifile.WriteBool('SendOptions','SFYZ',ChkSFYZ.Checked);
  MyInifile.WriteInteger('SendOptions','MessageNum',rg1.ItemIndex);
  MyInifile.WriteInteger('SendOptions','SendIdNum',rg2.ItemIndex);
  MyInifile.WriteString('ProgramOptions','StopTime',EdtStopTime.Text);
  MyInifile.WriteString('ProgramOptions','DelayTime',Edt2.Text);
  MyInifile.WriteString('ProgramOptions','YzTime',EdtYZSJ.Text);
  MyInifile.WriteBool('ProgramOptions','Ddverify',Chkverify.Checked);
  MyInifile.WriteInteger('GridWidth2','Id',Dbgrd1.Columns[0].Width);
  MyInifile.WriteInteger('SendList','Id',lvSendList.Columns.Items[0].Width);
  MyInifile.WriteInteger('SendList','State',lvSendList.Columns.Items[1].Width);
  MyInifile.Destroy;
end;

procedure TFrmMain.FormShow(Sender: TObject);
var
  FrmZC: TFrmReg;
  i: Integer;
begin
  if not InitToRegTab then
  begin
    Application.MessageBox('初始化注册信息失败','提示',MB_OK+MB_ICONWARNING);
    Close;
  end;
  if not VerifyRegInfo then
  begin
    FrmZC := TFrmReg.Create(nil);
    if FrmZC.ShowModal <> mrOk then
      Close;//Application.MessageBox('注册失败','提示',MB_OK+MB_ICONWARNING);
  end;
  tmr1.Enabled := True;

  DeleteFile(AppPath+'old.bak');//删除旧文件
  ThreadUpdate := TThreadYHID.Create(True);//检测更新
  ThreadUpdate.FreeOnTerminate := true;
  ThreadUpdate.id := 4;
  ThreadUpdate.Resume;
end;

procedure TFrmMain.lblGGMouseLeave(Sender: TObject);
begin
  tmr1.Enabled := true;
end;

procedure TFrmMain.lblGGMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  tmr1.Enabled := False;
end;

procedure TFrmMain.lvRunListColumnClick(Sender: TObject; Column: TListColumn);
var
  i: Integer;
  Li: TListItem;
begin
  StWwHwnd.Clear;
  lvRunList.Clear;
  EnumWindows(@EnumWndProc,0);
  for i := 0 to StWwHwnd.Count - 1 do
  begin
    Li := lvRunList.Items.Add;
    Li.Caption := Copy(StWwHwnd.Strings[i],1,Pos(',',StWwHwnd.Strings[i])-1);
  end;
end;

procedure TFrmMain.pgc1Change(Sender: TObject);
begin
  if pgc1.ActivePage = tsAuto then
  begin
    grp5.Parent := tsAuto;
    grp3.Parent := tsAuto;
  end;
  if pgc1.ActivePage = tsGeneral then
  begin
    grp5.Parent := tsGeneral;
    grp3.Parent := tsGeneral;
  end;

end;

procedure TFrmMain.tmr1Timer(Sender: TObject);
begin
  if StBulletin.Text <> '' then
  begin
    if IdBulletin = StBulletin.Count then
      IdBulletin := 0;
    lblGG.Caption := StBulletin.Strings[IdBulletin];
    Inc(IdBulletin);
  end;
//  else tmr1.Enabled := False;
end;

procedure TFrmMain.tv1Change(Sender: TObject; Node: TTreeNode);
begin
  lbl13.Caption := '当前组为：' + Node.Text;
  if ASQLite3Table2.Locate('GroupName',Node.Text,[]) then
  begin
    ASQLite3Table1.Filtered := True;
    ASQLite3Table1.Filter := 'FL = '+ QuotedStr(ASQLite3Table2.FieldByName('AutoID').AsString);
    if not ASQLite3Table1.Active then ASQLite3Table1.Open;
  end
  else ASQLite3Table1.Close;
end;

function EnumChildWndProc(AhWnd: LongInt;
  AlParam: lParam): boolean; stdcall;
var
  WndClassName: array[0..254] of Char;
  WndCaption: array[0..254] of Char;
begin
  GetClassName(AhWnd, wndClassName, 254); //控件类名
  GetWindowText(aHwnd, WndCaption, 254);  //控件标题
  if string(WndClassName) = 'RichEditComponent' then
    Ppp := Ahwnd;  //消息输入框句柄
  if (string(WndClassName) = 'StandardButton') and (string(wndCaption) = '发送') then
      PHwnd := AhWnd; //“发送” 按钮句柄
  if string(WndClassName) = 'ToolBarPlus' then
    if GetParent(AhWnd)= wndhwnd then
      PrHwnd := AhWnd; //“工具栏” 句柄     4
  result := true;
end;

function EnumChildSendID(AhWnd: LongInt;AlParam: lParam): boolean; stdcall;
var
  WndClassName: array[0..254] of Char;
  WndCaption: array[0..254] of Char;
  PWndClassName: array[0..254] of Char;  //父窗类名
  PWndCaption: array[0..254] of Char;    //父窗标题
  PHHwnd: HWND;
begin
  GetClassName(AhWnd, wndClassName, 254); //控件类名
  GetWindowText(aHwnd, WndCaption, 254);  //控件标题
  GetClassName(GetParent(AhWnd),PWndClassName,254);
  GetWindowText(GetParent(AhWnd),PWndCaption,254);
  if (string(WndClassName) = 'StandardButton') and (string(wndCaption) = '') and (string(PWndClassName)='StandardFrame')then
      MenuBtnHwnd := AhWnd; //“发送” 按钮句柄
  if (string(WndClassName) = 'EditComponent') and (string(WndCaption) = '') then
    IDEdtHwnd := AhWnd;
  if (string(WndClassName) = 'StandardButton') and (string(WndCaption) = '发 送') then
    SendBtnHwnd := AhWnd;
  if (string(WndClassName) = 'StandardButton') and (string(WndCaption) = '确  定') then
    SendBtnHwnd := AhWnd;
  if (string(WndClassName) = 'StandardButton') and (string(WndCaption) = '发送消息') then
    SendBtnHwnd := AhWnd;
  result := true;
end;

function EnumWndProc(hwnd:THandle;lparam:LPARAM):Boolean;stdcall
var
  WndCaption: array[0..254] of Char;
  WndClassName: array[0..254] of Char;
  s:string;
begin
  GetClassName(hwnd,WndClassName,254);
  GetWindowText(hwnd,WndCaption,254);
  if string(WndClassName) = 'StandardFrame' then
  begin
    s:=WndCaption;
    Delete(s,Pos('-',s),Length(s));
    StWwHwnd.Add(s+','+ IntToStr(hwnd));
  end;
  Result := True;
end;

function ToUTF8Encode(str: string): string;//汉字转UTF-8
var
b: Byte;
begin
  for b in BytesOf(UTF8Encode(str)) do
  Result := Format('%s%s%.2x', [Result, '%', b]);
end;

function WangWangOnLine(str: string): Boolean;
var
//  Request: TStrings;
  Response: TStringStream;
  s,sURL:string;
  idhttp1: TIdHTTP;
begin
  Result := False;
  idhttp1 := TIdHTTP.Create(nil);
  idhttp1.HandleRedirects := true;
  idhttp1.ReadTimeout := 60000;
  idhttp1.ConnectTimeout := 60000;
  IdHTTP1.Request.ContentType := 'application/x-www-form-urlencoded';
//  Request := TStringList.Create;
  Response := TStringStream.Create('');
  try
    sURL := 'http://amos1.taobao.com/muliuserstatus.aw?beginnum=0&site=cntaobao&uids='+ HTTPEncode(str);
    IdHTTP1.Get(surl, Response);

    s:=Response.DataString;
    Delete(s,1,Pos('online[',s)+6);
    Delete(s,1,Pos('=',s));
    s := Trim(s);
    Delete(s,2,Length(s));
    if StrToInt(s) <> 0 then
      Result := True
    else Result := False;
  except
//    MessageBox(FrmMain.handle,'获取“在线状态”超时，关闭后继续发送！','提示',MB_OK);
  end;
end;

function DengDaiYanZhen(i: Integer):Boolean;
var
  YanZheng: LongInt;
begin
  Result := True;
  YanZheng := FindWindow(nil, '阿里旺旺 - 安全验证'); //安全验证对话框
  if YanZheng <> 0 then
  begin
    if FrmMain.Chkverify.Checked then
    begin
      Application.MessageBox('为确保消息成功发送，请输入正确验证码'+#13#13+'确认安全验证框被关闭后'+#13+'再按确定，程序将继续执行！','提示',MB_OK+MB_ICONWARNING);
      SendMessage(YanZheng,WM_CLOSE,0,0);
      Sleep(StrToInt(FrmMain.Edt2.Text)*1000);//系统延迟
    end
    else begin
      SendMessage(YanZheng,WM_CLOSE,0,0);
      SendMessage(wndhwnd,WM_CLOSE,0,0);                    //关闭聊天窗口
      FrmMain.lvSendList.Items.Item[i].SubItems.Strings[0] := '排除消息验证';
      FrmMain.lvSendList.Items.Item[i].SubItemImages[0] := 0;
      Result := False;
    end;
  end;
end;

function JianHaoYou(i: Integer): Boolean;//添加为好友
var
  CGHwnd: LongInt;
begin
  Result := True;
  if FrmMain.Chk1.Checked then //加对方为好友
  begin
    sendmessage(PrHwnd, WM_LBUTTONDOWN , MK_LBUTTON, MAKELONG(265,15));
    SendMessage(PrHwnd, WM_LBUTTONUP , MK_LBUTTON, MAKELONG(265,15));
    sendmessage(PrHwnd, WM_LBUTTONDOWN , MK_LBUTTON, MAKELONG(265,15));
    SendMessage(PrHwnd, WM_LBUTTONUP , MK_LBUTTON, MAKELONG(265,15));

    Sleep(StrToInt(FrmMain.Edt2.Text)*1000);//系统延迟
    Result := DengDaiYanZhen(i);//验证码窗口
    if Result then
    begin
      CGHwnd := FindWindow(nil, '添加好友成功!');//找到添加成功的提示框
      if CGHwnd <> 0 then
        SendMessage(CGHwnd,WM_CLOSE,0,0);
    end;
  end;
end;

procedure FaXiaoXi();//发送消息
var
  Rgindex: Integer;
begin
  if FrmMain.rg1.ItemIndex = 3 then //开始发送消息
  begin
    Randomize;
    Rgindex := Random(3);
  end
  else Rgindex := FrmMain.rg1.ItemIndex;
  if Rgindex = 0 then
    sendmessage(Ppp,WM_SETTEXT,0,Integer(PChar(FrmMain.MemoXX1.Text))); //填写消息一
  if Rgindex = 1 then
    sendmessage(Ppp,WM_SETTEXT,0,Integer(PChar(FrmMain.MemoXX2.Text))); //填写消息二
  if Rgindex = 2 then
    sendmessage(Ppp,WM_SETTEXT,0,Integer(PChar(FrmMain.MemoXX3.Text))); //填写消息三
  SendMessage(Ppp,WM_IME_KEYDOWN,VK_RETURN,0);   //按ENTER键发送消息
//  SendMessage(PHwnd,BM_CLICK,0,0);                      //发送消息
end;

function ZhiDingWangWang(i: Integer; var SendIDHWnd: LongInt):Boolean;//指定发送号
var
  Rgindex,ListIndex: Integer;
  s: string;
begin
  Result := True;
  if FrmMain.rg2.ItemIndex = 3 then  //随机ID
  begin
    Randomize;
    Rgindex := Random(3);
  end
  else Rgindex := FrmMain.rg2.ItemIndex;
  case Rgindex of
    0: begin
         for ListIndex := 0 to StWwHwnd.Count - 1 do
         begin
           s := StWwHwnd.Strings[ListIndex];
           if FrmMain.EdtHM1.Text = copy(s,1,Pos(',',StWwHwnd.Strings[ListIndex])-1) then
           begin
             sSendWangWang := FrmMain.EdtHM1.Text;
             Delete(s,1,Pos(',',StWwHwnd.Strings[ListIndex]));
             SendIDHWnd := StrToInt(s); //找到第一个旺旺窗口句柄
             Break;
           end
           else if (ListIndex = StWwHwnd.Count - 1) then
           begin
             FrmMain.lvSendList.Items.Item[i].SubItems.Strings[0] := '号码一未开启 '+ FrmMain.EdtHM1.Text;
             FrmMain.lvSendList.Items.Item[i].SubItemImages[0] := 3;
             Rgindex := -1; //只是做一个标记 ,未找到指定旺旺
             Break;
           end;
         end;
         if Rgindex < 0 then Result := False;
       end;
    1: begin
         for ListIndex := 0 to StWwHwnd.Count - 1 do
         begin
           s := StWwHwnd.Strings[ListIndex];
           if FrmMain.EdtHM2.Text = copy(s,1,Pos(',',StWwHwnd.Strings[ListIndex])-1) then
           begin
             sSendWangWang := FrmMain.EdtHM2.Text;
             Delete(s,1,Pos(',',StWwHwnd.Strings[ListIndex]));
             SendIDHWnd := StrToInt(s); //找到第二个旺旺窗口句柄
             Break;
           end
           else if (ListIndex = StWwHwnd.Count - 1) then
           begin
             FrmMain.lvSendList.Items.Item[i].SubItems.Strings[0] := '号码二未开启 '+ FrmMain.EdtHM2.Text;
             FrmMain.lvSendList.Items.Item[i].SubItemImages[0] := 3;
             Rgindex := -1;
             Break;
           end;
         end;
         if Rgindex < 0 then Result := False;
       end;
    2: begin
         for ListIndex := 0 to StWwHwnd.Count - 1 do
         begin
           s := StWwHwnd.Strings[ListIndex];
           if FrmMain.EdtHM3.Text = copy(s,1,Pos(',',StWwHwnd.Strings[ListIndex])-1) then
           begin
             sSendWangWang := FrmMain.EdtHM3.Text;
             Delete(s,1,Pos(',',StWwHwnd.Strings[ListIndex]));
             SendIDHWnd := StrToInt(s); //找到第一个旺旺窗口句柄
             Break;
           end
           else if (ListIndex = StWwHwnd.Count - 1) then
           begin
             FrmMain.lvSendList.Items.Item[i].SubItems.Strings[0] := '号码三未开启 '+ FrmMain.EdtHM3.Text;
             FrmMain.lvSendList.Items.Item[i].SubItemImages[0] := 3;
             Rgindex := -1;
             Break;
           end;
         end;
         if Rgindex < 0 then Result := False;
       end;
  end;
end;




{ TThreadQuery }

procedure TThreadYHID.Execute;
begin
  case id of
    1: SendMsg;
    2: GetBuyer;
    3: GetSeller;
    4: SelfUpdate;
  end;
end;

procedure TThreadYHID.GetBuyer;
var
  Request: TStrings;
  Response: TStringStream;
  s, Id:string;
  i: Integer;
  idhttp1:TIdHTTP;
begin
  idhttp1 := TIdHTTP.Create(nil);
  idhttp1.HandleRedirects := true;
  idhttp1.ReadTimeout := 60000;
  idhttp1.ConnectTimeout := 60000;
  IdHTTP1.Request.ContentType := 'application/x-www-form-urlencoded';

  request := TStringList.Create;
  Response := TStringStream.Create('');
  //request.Add('q=test');
  try
    IdHTTP1.Get(FrmMain.MemoWangZhi.Text, Response);
//    IdHTTP1.Post('...',
//    request, Response);
    s:=Response.DataString;
    try
      FrmMain.Dbgrd1.DataSource := nil;//此处不断开DbGrd的话，后面数重复后还是被添加进去，而且会有BookMArk未定义之类的大量错误，原因未明
      i := 0;
      while Pos('<a href="http://jianghu.taobao.com/n/',s)>0 do
      begin
        Delete(s,1,Pos('<a href="http://jianghu.taobao.com/n/',s));
        Delete(s,1,Pos('>',s));
        Id := Copy(s,1,Pos('<',s)-1);
        if not FrmMain.ASQLite3Table1.Active then FrmMain.ASQLite3Table1.Open;
        if not FrmMain.ASQLite3Table1.Locate('FL;WwName',VarArrayOf([FrmMain.ASQLite3Table2.FieldByName('AutoId').AsInteger,Id]),[]) then
        begin
          FrmMain.ASQLite3Table1.Append;
          FrmMain.ASQLite3Table1.FieldByName('FL').AsInteger := FrmMain.ASQLite3Table2.FieldByName('AutoId').AsInteger;
          FrmMain.ASQLite3Table1.FieldByName('WwName').AsString := Id;
          FrmMain.ASQLite3Table1.Post;
          Inc(i);
        end;
      end;
    finally
      FrmMain.Dbgrd1.DataSource := FrmMain.ds1;
    end;
    Application.MessageBox(PWideChar('查找结束，本次共找到 '+inttostr(i)+' 旺旺号！'),'完成',mb_ok);
    FrmMain.Btn1.Enabled := not FrmMain.Btn1.Enabled;
    FrmMain.Btn4.Enabled := not FrmMain.Btn1.Enabled;
    FrmMain.RbGetBuyer.Enabled := True;
    FrmMain.RbGetSeller.Enabled := True;
  except
    on e: Exception do
    begin
      Application.MessageBox('连接失败','错误',MB_OK);
      FrmMain.Btn1.Enabled := not FrmMain.Btn1.Enabled;
      FrmMain.Btn4.Enabled := not FrmMain.Btn1.Enabled;
      FrmMain.RbGetBuyer.Enabled := True;
      FrmMain.RbGetSeller.Enabled := True;
    end
  end;

end;

procedure TThreadYHID.GetSeller;
var
  Request: TStrings;
  Response: TStringStream;
  s, Id:string;
  i: Integer;
  idhttp1:TIdHTTP;
begin
  idhttp1 := TIdHTTP.Create(nil);
  idhttp1.HandleRedirects := true;
  idhttp1.ReadTimeout := 60000;
  idhttp1.ConnectTimeout := 60000;
  IdHTTP1.Request.ContentType := 'application/x-www-form-urlencoded';

  request := TStringList.Create;
  Response := TStringStream.Create('');
  try
    IdHTTP1.Get(FrmMain.MemoWangZhi.Text, Response);
    s:=Response.DataString;
    try
      FrmMain.Dbgrd1.DataSource := nil;//此处不断开DbGrd的话，后面数重复后还是被添加进去，而且会有BookMArk未定义之类的大量错误，原因未明
      i := 0;
      while Pos('a href="http://store.taobao.com/shop/view_shop',s)>0 do
      begin
        Delete(s,1,Pos('a href="http://store.taobao.com/shop/view_shop',s));
        Delete(s,1,Pos('>',s));
        Id := Copy(s,1,Pos('<',s)-1);
        if not FrmMain.ASQLite3Table1.Active then FrmMain.ASQLite3Table1.Open;
        if not FrmMain.ASQLite3Table1.Locate('FL;WwName',VarArrayOf([FrmMain.ASQLite3Table2.FieldByName('AutoId').AsInteger,Id]),[]) then
        begin
          FrmMain.ASQLite3Table1.Append;
          FrmMain.ASQLite3Table1.FieldByName('FL').AsInteger := FrmMain.ASQLite3Table2.FieldByName('AutoId').AsInteger;
          FrmMain.ASQLite3Table1.FieldByName('WwName').AsString := Id;
          FrmMain.ASQLite3Table1.Post;
          Inc(i);
        end;
      end;
    finally
      FrmMain.Dbgrd1.DataSource := FrmMain.ds1;
    end;
      Application.MessageBox(PWideChar('查找结束，本次共找到 '+inttostr(i)+' 旺旺号！'),'完成',mb_ok);
      FrmMain.Btn1.Enabled := not FrmMain.Btn1.Enabled;
      FrmMain.Btn4.Enabled := not FrmMain.Btn1.Enabled;
      FrmMain.RbGetBuyer.Enabled := True;
      FrmMain.RbGetSeller.Enabled := True;

  except
    on e: Exception do
    begin
      Application.MessageBox('连接失败','错误',MB_OK);
      FrmMain.Btn1.Enabled := not FrmMain.Btn1.Enabled;
      FrmMain.Btn4.Enabled := not FrmMain.Btn1.Enabled;
      FrmMain.RbGetBuyer.Enabled := True;
      FrmMain.RbGetSeller.Enabled := True;
    end
  end;

end;

procedure TThreadYHID.SelfUpdate;
var
  AppFile:string;
  IdhttpUpdate: TIdHTTP;
  Request: TStrings;
  Response: TStringStream;
  s:string;
  FDownFile: TDownFile;
  Attr:Integer;
  sMsg:Msg;
begin
  IdhttpUpdate := TIdHTTP.Create(nil);
  IdhttpUpdate.HandleRedirects := true;
  IdhttpUpdate.ReadTimeout := 60000;
  IdhttpUpdate.ConnectTimeout := 60000;
  IdhttpUpdate.Request.ContentType := 'application/x-www-form-urlencoded';

  request := TStringList.Create;
  Response := TStringStream.Create('');

  IdhttpUpdate.Get(Url + Bulletin, Response); //更新公告信息
  StBulletin.Text := Response.DataString;
  Response.Clear;

  try
    FrmMain.stat1.Panels[3].Text :='更新：检测中...';
    IdhttpUpdate.Get(Url + VerFile, Response);
    s:=Response.DataString;
    if version = s then
    begin
      FrmMain.stat1.Panels[3].Text :='更新：已是最新版';
      Exit;
    end;
  except
    FrmMain.stat1.Panels[3].Text :='更新：连接超时';
  end;

  AppFile := ExtractFileName(Application.ExeName);
  if not DirectoryExists(AppPath+'update') then //文件夹是否存在
    forcedirectories(AppPath+'update');//创建文件夹
  Attr := FileGetAttr(AppPath+'update');//文件夹属性
  if not ((Attr and faHidden) = faHidden)then
    FileSetAttr(AppPath+'update',attr or faHidden); //设为隐藏

  FrmMain.stat1.Panels[3].Text :='更新：正在下载升级文件...';

  if FDownFile.DownFile(Url + UpdateFile,AppPath+'update\'+Appfile) then //下载更新文件
  begin
    if FileExists(AppPath+'update\'+Appfile) then
    begin
      RenameFile(AppPath+AppFile,AppPath+'old.bak'); //重命名旧的文件
      MoveFile(PWideChar(AppPath+'update\'+Appfile),PWideChar(AppPath+Appfile));//移动更新文件到程序目录
      FrmMain.stat1.Panels[3].Text :='更新：下载成功，等待重启';
      if Application.MessageBox('更新文件下载完成'+#13+'重启软件完成更新？','提示',MB_YesNo+MB_ICONQuestion)=mryes then
      begin
        ShellExecute(0, 'open', Pchar(AppPath+Appfile), nil, nil, SW_SHOWNORMAL);
        SendMessage(FrmMain.Handle,WM_CLOSE,0,0);
      end;
    end;
  end
  else
    FrmMain.stat1.Panels[3].Text :='更新：更新失败';
end;

procedure TThreadYHID.SendMsg;
var
 i: integer;
 SendIDHWnd, SendDLGHWnd: LongInt;
 s: string;
 hhhh:LongInt;
begin
  inherited;
  try
    for i := 0 to FrmMain.lvSendList.Items.Count - 1 do
    begin
      StWwHwnd.Clear;
      EnumWindows(@EnumWndProc,0);//枚举出打开的旺旺句柄

      if FrmMain.chk2.Checked then //仅发送给在线的旺旺
        if not WangWangOnLine(FrmMain.lvSendList.Items.Item[i].Caption) then
        begin
          FrmMain.lvSendList.Items.Item[i].SubItems.Strings[0] := '离线';
          FrmMain.lvSendList.Items.Item[i].SubItemImages[0] := 2;
          Continue;
        end;
      if FrmMain.lvSendList.Items.Item[i].SubItems.Strings[0] = '成功' then  continue;//被标示为这几种状态的都不用发送

      if not ZhiDingWangWang(i, SendIDHWnd) then Continue;   //指定发送号是否打开

      EnumChildWindows(SendIDHWnd, @EnumChildSendID, 0);//枚举发送号所有控件
      SendMessage(MenuBtnHwnd,BM_CLICK,0,0); //点击菜单按钮
      Sleep(StrToInt(FrmMain.Edt2.Text)*1000);//系统延迟
      memu := FindWindow('coolmenu',nil);
      if memu <> 0 then
      begin
        SendMessage(memu,WM_LBUTTONDOWN , MK_LBUTTON, MAKELONG(70,145)); //模拟点击“指定发送”
        PostMessage(memu,WM_LBUTTONUP , MK_LBUTTON, MAKELONG(70,145)); //里用用Post程序才能执行下去
      end;

      Sleep(StrToInt(FrmMain.Edt2.Text)*1000);//系统延迟
      SendDLGHWnd := FindWindow(nil, PWideChar('指定用户发送'));
      if SendDLGHWnd <> 0 then
      begin
        EnumChildWindows(SendDLGHWnd, @EnumChildSendID, 0);
        SendMessage(IDEdtHwnd,WM_SETTEXT,0,Integer(PChar(FrmMain.lvSendList.Items.Item[i].Caption)));  //填定用户
        SendMessage(IDEdtHwnd,WM_IME_KEYDOWN,VK_RETURN,0);//发送ENTER键，相当于“发送”按钮
//        PostMessage(SendBtnHwnd,BM_CLICK,0,0); //点击发送按钮  这里用POST全为了下面的条件能顺利被判断到
        Sleep(StrToInt(FrmMain.Edt2.Text)*1000);//系统延迟
        if SendDLGHWnd <> 0 then
        begin
          sendMessage(SendDLGHWnd,WM_CLOSE,0,0);
          wndhwnd := FindWindow(nil, '阿里旺旺');//没有这个用户
          if wndhwnd <> 0 then
          begin
            SendMessage(wndhwnd,WM_CLOSE,0,0);
            FrmMain.lvSendList.Items.Item[i].SubItems.Strings[0] := '没有这个用户';
            FrmMain.lvSendList.Items.Item[i].SubItemImages[0] := 3;
            Continue;
          end;
        end;
      end
      else begin
        FrmMain.lvSendList.Items.Item[i].SubItems.Strings[0] := '无指定发送窗口';
        FrmMain.lvSendList.Items.Item[i].SubItemImages[0] := 3;
        Continue;
      end;

      wndhwnd := FindWindow(nil, '阿里旺旺');//拒绝添加窗口
      if wndhwnd <> 0 then
      begin
        SendMessage(wndhwnd,WM_CLOSE,0,0);
        FrmMain.lvSendList.Items.Item[i].SubItems.Strings[0] := '对方拒绝添加';
        FrmMain.lvSendList.Items.Item[i].SubItemImages[0] := 3;
        Continue;
      end;
      Sleep(StrToInt(FrmMain.Edt2.Text)*1000);//系统延迟

      wndhwnd := FindWindow(nil, '添加好友信息');//用户信息窗口
      if wndhwnd <> 0 then
      begin
        if not FrmMain.ChkSFYZ.Checked then  //需要身份验证
        begin
          EnumChildWindows(wndhwnd, @EnumChildSendID, 0);
          SendMessage(IDEdtHwnd,WM_SETTEXT,0,Integer(PChar(FrmMain.EdtYZXX.Text)));//填写验证消息
//          SendMessage(IDEdtHwnd,WM_IME_KEYDOWN,VK_RETURN,0);//发送ENTER键，相当于点击“确定按钮”
          SendMessage(SendBtnHwnd,BM_CLICK,0,0); //点击确定按钮
          Sleep(StrToInt(FrmMain.Edt2.Text)*1000);//系统延迟
          if not DengDaiYanZhen(i) then Continue;//输入验证码
          Sleep(StrToInt(FrmMain.EdtYZSJ.Text)*1000);//等待对方添加
          wndhwnd := FindWindow(nil, '添加请求被拒绝');//请求被拒绝
          if wndhwnd <> 0 then
          begin
            SendMessage(wndhwnd,WM_CLOSE,0,0);
            FrmMain.lvSendList.Items.Item[i].SubItems.Strings[0] := '对方拒绝添加';
            FrmMain.lvSendList.Items.Item[i].SubItemImages[0] := 3;
            Continue;
          end;
          wndhwnd := FindWindow(nil, '添加好友成功!');//添加成功
          if wndhwnd <> 0 then
          begin
            EnumChildWindows(wndhwnd, @EnumChildSendID, 0);
            SendMessage(SendBtnHwnd,BM_CLICK,0,0); //点击发送消息按钮
            Sleep(StrToInt(FrmMain.Edt2.Text)*1000);//系统延迟
          end
          else begin
            FrmMain.lvSendList.Items.Item[i].SubItems.Strings[0] := '请求添加超时';
            FrmMain.lvSendList.Items.Item[i].SubItemImages[0] := 3;
            Continue;
          end;
        end
        else begin
          SendMessage(wndhwnd,WM_CLOSE,0,0);
          FrmMain.lvSendList.Items.Item[i].SubItems.Strings[0] := '排除消息验证';
          FrmMain.lvSendList.Items.Item[i].SubItemImages[0] := 0;
          Continue;
        end;
      end;


      wndhwnd := FindWindow(nil, PWideChar(FrmMain.lvSendList.Items.Item[i].Caption + ' - ' +   sSendWangWang)); //找到聊天窗口句柄
      if wndhwnd <> 0 then
      begin
        EnumChildWindows(wndhwnd, @EnumChildWndProc, 0);
        if not JianHaoYou(i) then Continue; //加为好友
        FaXiaoXi();//发送消息
        SendMessage(wndhwnd,WM_KEYDOWN,VK_RETURN,0);
        Sleep(StrToInt(FrmMain.Edt2.Text)*1000);//系统延迟
        if not DengDaiYanZhen(i) then Continue;//输入验证码

        SendMessage(wndhwnd,WM_CLOSE,0,0);                    //关闭聊天窗口
        FrmMain.lvSendList.Items.Item[i].SubItems.Strings[0] := '成功';
        FrmMain.lvSendList.Items.Item[i].SubItemImages[0] := 1;
      end
      else begin
        FrmMain.lvSendList.Items.Item[i].SubItems.Strings[0] := '失败';
        FrmMain.lvSendList.Items.Item[i].SubItemImages[0] := 3;
      end;

      Sleep(StrToInt(FrmMain.EdtStopTime.Text)*1000);//等待发送下一条
    end;
    FrmMain.Btn2.Enabled := not FrmMain.Btn2.Enabled;
    FrmMain.Btn3.Enabled := not FrmMain.Btn2.Enabled;
  except
    Application.MessageBox('线程异常终止!!','错误',mb_ok); { 线程异常 }
    FrmMain.Btn2.Enabled := not FrmMain.Btn2.Enabled;
    FrmMain.Btn3.Enabled := not FrmMain.Btn2.Enabled;
  end;
end;

end.
