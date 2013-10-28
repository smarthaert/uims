unit UnitBackup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db,ADODB, ExtCtrls, ShellApi, Menus,
  ComCtrls, Registry, ScktComp , StdCtrls , Buttons,  Variants,IniFiles ,StrUtils,
  ImgList ;

 const
  WM_BARICON=WM_USER+200; //自定义消息
  ID_MAIN=100;//定义图标的ID
type
  TFrmBackup = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    CmbServerName: TComboBox;
    CmbDatabaseName: TComboBox;
    EdtUserName: TEdit;
    EdtPassword: TEdit;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    btnSave: TBitBtn;
    btnCancel: TBitBtn;
    cboAutoRun: TCheckBox;
    EdtPath: TEdit;
    btnPath: TButton;
    btnSetTime: TBitBtn;
    connAdo: TADOConnection;
    connQuery: TADOQuery;
    btnBackup: TBitBtn;
    Timer1: TTimer;
    cboShowMessage: TCheckBox;
    PopupMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    ImageList1: TImageList;
    cboMin: TCheckBox;
    cboClose: TCheckBox;
    cboStart: TCheckBox;
    BitBtn1: TBitBtn;
    Button1: TButton;
    procedure btnSetTimeClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnBackupClick(Sender: TObject);
    procedure btnPathClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FilePath:String;
    BackupIniFile:TIniFile;
    ServerName,DatabaseName,UserName,Password:String;

    Run,StartMin,Show,Min,CloseShow:integer;
    Conn:Boolean;  //判断联接是否成功
    connString:String; //联接字符串
    BackFileName:String; //备份文件的名称
    procedure AddIcon(hwnd:HWND);
    procedure RemoveIcon(hwnd: HWND); //从状态区移去图标

    procedure WMSysCommand(var Message: TMessage); message WM_SYSCOMMAND;
    procedure WMBarIcon(var Message:TMessage);message WM_BARICON;
    procedure WMMini(var Message:TMessage);message WM_SETFOCUS;
    procedure BackupBase(FileName:String); //定义备份过程
    procedure ReadIni; //读取INI文件中的内容
  public
    { Public declarations }

    BackupType,EveryTime,EveryDay,EveryMonth,EveryWeek:integer;
    procedure ComBoboxValue(Cmb:TComBoBox;Str:string) ;
  end;


var
  FrmBackup: TFrmBackup;
implementation

uses UnitFrmSetupTime, UnitFilePath, UnitDirPath, UnitDlg, UnitChose;

{$R *.dfm}
procedure TFrmBackup.AddIcon(hwnd:HWND);
var
  lpData:PNotifyIconData;
begin
  lpData := new(PNotifyIconDataA);
  lpData.cbSize := 88;
  lpData.Wnd := FrmBackup.Handle;
  lpData.hIcon := FrmBackup.Icon.Handle;
  lpData.uCallbackMessage := WM_BARICON;
  lpData.uID :=0;
  lpData.szTip := '数据库备份工具';
  lpData.uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
  Shell_NotifyIcon(NIM_ADD,lpData);
  dispose(lpData);
  FrmBackup.Visible := False;
end;

procedure TFrmBackup.RemoveIcon(hwnd: HWND);//从状态区移去图标
var
  lpData:PNotifyIconData;
begin
  //如果用户点击任务栏图标则将图标删除并回复窗口。
  lpData := new(PNotifyIconDataA);
  lpData.cbSize := 88;//SizeOf(PNotifyIconDataA);
  lpData.Wnd := FrmBackup.Handle;
  lpData.hIcon := FrmBackup.Icon.Handle;
  lpData.uCallbackMessage := WM_BARICON;
  lpData.uID :=0;
  lpData.szTip := 'Samples';
  lpData.uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
  Shell_NotifyIcon(NIM_DELETE,lpData);
  dispose(lpData);
end;

procedure TFrmBackup.WMSysCommand(var Message:TMessage);
begin
  if Message.WParam = SC_ICON then
  begin
     //如果用户最小化窗口则将窗口
     //隐藏并在任务栏上添加图标
     AddIcon(handle);
  end
  else if (Message.WParam= SC_Close) and (Min=1)then begin
      Application.Minimize;
      AddIcon(handle);
  end
  else if (Message.WParam=WM_CREATE) and (Min=1)then begin
      Application.Minimize;
      AddIcon(handle);
  end
  else
     //如果是其它的SystemCommand
     //消息则调用系统缺省处理函数处理之。
     DefWindowProc(FrmBackup.Handle,Message.Msg,Message.WParam,Message.LParam);
end;

procedure TFrmBackup.WMBarIcon(var Message:TMessage);
var
   lpData:PNotifyIconData;
   Pt:TPoint;
begin
  if (Message.LParam = WM_LBUTTONDOWN) then
   begin
     RemoveIcon(handle);
     FrmBackup.Visible := True;
   end
   else if (Message.LParam=WM_RBUTTONDOWN) then
   begin
     SetForeGroundWindow(lpData.Wnd);
     GetCursorPos(Pt);
     Popupmenu.Popup(Pt.X,pt.y);
   end;
end;

procedure TFrmBackup.WMMini(var Message:TMessage);
begin
  if (Message.Msg=WM_CREATE) then begin
      Application.Minimize;
      AddIcon(handle);
  end
end;

//定义备份过程
procedure TFrmBackup.BackupBase(FileName:String);
begin
  try
    screen.Cursor:=crSqlWait;
    with connQuery do
    begin
      close;
      Sql.Text:='Backup Database '+Trim(CmbDatabaseName.Text)+' to Disk='''+FileName+''' ';
      ExecSQL;
    end;
    screen.Cursor:=crDefault;
  except
    MessageBox(handle,'备份失败！','提示',MB_IconWarning+mb_Ok);
    screen.Cursor:=crDefault;
    Exit;
  end;
end;

//读取INI文件中的内容
procedure TFrmBackup.ReadIni;
begin
  FilePath:=ExtractFilePath(Application.ExeName)+'System.ini';
  BackupIniFile:=TIniFile.Create(FilePath);
  ServerName:=BackupIniFile.ReadString('Database','ServerName','');
  DatabaseName:=BackupIniFile.ReadString('Database','DatabaseName','');
  UserName:=BackupIniFile.ReadString('Database','UserName','');
  Password:=BackupIniFile.ReadString('Database','Password','');
  Run:=BackupIniFile.ReadInteger('AutoRun','Run',0);
  StartMin:=BackupIniFile.ReadInteger('AutoRun','StartMin',0); 
  Show:=BackupIniFile.ReadInteger('AutoRun','Show',0);
  Min:=BackupIniFile.ReadInteger('AutoRun','Min',0);
  CloseShow:=BackupIniFile.ReadInteger('AutoRun','CloseShow',0);

  BackupType:=BackupIniFile.ReadInteger('Backup','BackupType',0);
  EveryTime:=BackupIniFile.ReadInteger('Backup','EveryTime',0);
  EveryDay:=BackupIniFile.ReadInteger('Backup','EveryDay',0);
  EveryWeek:=BackupIniFile.ReadInteger('Backup','EveryWeek',0);
  EveryMonth:=BackupIniFile.ReadInteger('Backup','EveryMonth',0);

  CmbServerName.Text:=ServerName;
  //CmbDatabaseName.Text:=DatabaseName;

  ComBoboxValue(cmbDatabaseName,DatabaseName);

  EdtUserName.Text:=UserName;
  EdtPassword.Text:=Password;
  EdtPath.Text:=BackupIniFile.ReadString('FilePath','Path','');
  
  if Run=1 then  //初始化<随开机启动>
    cboAutoRun.Checked:=True
  else
    cboAutoRun.Checked:=False;
  if StartMin=1 then //初始化<启动后最小化>
    cboStart.Checked:=True
  else
    cboStart.Checked:=False;
  if Show=1 then //初始化<备份时显示提示信息>
    cboShowMessage.Checked:=True
  else
    cboShowMessage.Checked:=False;
  if Min=1 then  //初始化<关闭时最小化>
    cboMin.Checked:=True
  else
    cboMin.Checked:=False;
  if CloseShow=1 then  //初始化<不显示关闭信息>
    cboClose.Checked:=True
  else
    cboClose.Checked:=False;
end;

procedure TFrmBackup.btnSetTimeClick(Sender: TObject);
begin
  Application.CreateForm(TFrmSetupTime,FrmSetupTime); 
  FrmSetupTime.ShowModal;
  FrmSetupTime.Free;
end;

procedure TFrmBackup.btnSaveClick(Sender: TObject);
var
  reg:TRegistry;
  S_RegTree:String;
begin
  if not conn then //判断数据库联接是否成功，只有成功之后才能保存
  begin
    MessageBox(handle,'数据库联接没有成功，所以不能保存！','错误',mb_IconWarning+mb_Ok);
    CmbServerName.SetFocus;
    Exit;
  end;
  //将数据库联接参数保存到Ini文件中
  BackupIniFile.WriteString('Database','ServerName',Trim(CmbServername.Text));
  BackupIniFile.WriteString('Database','DatabaseName',DatabaseName);
  BackupIniFile.WriteString('Database','UserName',Trim(EdtUserName.Text));
  BackupIniFile.WriteString('Database','Password',Trim(EdtPassword.Text));
  BackupIniFile.WriteString('FilePath','Path',Trim(EdtPath.Text));
  //判断是否开机时起动系统
  reg:=tregistry.Create;
  Reg.RootKey:=HKEY_LOCAL_MACHINE;
  S_RegTree:='\Software\Microsoft\Windows\CurrentVersion\Run';
  if Reg.OpenKey(S_RegTree,False)=false then
    Reg.CreateKey(S_RegTree);
  Reg.OpenKey(S_RegTree,True);
  FilePath:=ExtractFilePath(Application.ExeName)+'Backup.exe';

  if cboAutoRun.Checked then
  begin
    Reg.WriteString('BackupDatabase',FilePath);
    BackupIniFile.WriteInteger('AutoRun','Run',1);
  end
  else begin
    Reg.DeleteValue('BackupDatabase');
    BackupIniFile.WriteInteger('AutoRun','Run',0);
  end;
  //启动后最小化
  if cboStart.Checked then
    BackupIniFile.WriteInteger('AutoRun','StartMin',1)
  else
    BackupIniFile.WriteInteger('AutoRun','StartMin',0);
  //<备份时显示提示信息>
  if cboShowMessage.Checked then
    BackupIniFile.WriteInteger('AutoRun','Show',1)
  else
    BackupIniFile.WriteInteger('AutoRun','Show',0);
  //<关闭时最小化>
  if cboMin.Checked then
    BackupIniFile.WriteInteger('AutoRun','Min',1)
  else
    BackupIniFile.WriteInteger('AutoRun','Min',0);
  //<显示关闭信息>
  if cboClose.Checked then
    BackupIniFile.WriteInteger('AutoRun','CloseShow',1)
  else
    BackupIniFile.WriteInteger('AutoRun','CloseShow',0);
  Reg.Free;
  ReadIni();
end;

procedure TFrmBackup.btnBackupClick(Sender: TObject);
var
  FilePath:String;
  i:integer;
  str:String;
begin
  try
    if Show=1 then begin
      application.CreateForm(tfrmDlg,frmDlg);
      frmDlg.Show;
    end;

    for i:=0 to cmbDatabaseName.Items.Count-1 do
    begin
      //文件名等于<年月日时分秒>
      BackFileName:=Trim(CmbDatabaseName.Items[i])+FormatDateTime('yyyymmddhhmmss',Now); //取得备份文件名

      //取得地址框中的地址
      if RightStr(EdtPath.text,1)='\' then
         FilePath:=EdtPath.Text
      else
         FilePath:=EdtPath.Text+'\';

      FilePath:=FilePath+BackFileName;
      screen.Cursor:=crSqlWait;

      //      BackupBase(FilePath); //调用备份过程备份文件
      screen.Cursor:=crSqlWait;

      str:='Backup Database '+Trim(CmbDatabaseName.Items[i])+' to Disk='''+FilePath+''' ';

      with connQuery do
      begin
        close;
        Sql.Text:=str;
        ExecSQL;
      end;
    end;

    screen.Cursor:=crDefault;

    if Show=1 then
    begin
      frmDlg.Close;
      frmDlg.Free;
    end;
    
  except
    MessageBox(handle,'备份失败！','提示',MB_IconWarning+mb_Ok);
    screen.Cursor:=crDefault;
    frmDlg.Close;
    frmDlg.Free;
    Exit;
  end;
end;


procedure TFrmBackup.btnPathClick(Sender: TObject);
begin
  Application.CreateForm(TFrmDirPath,FrmDirPath); 
  if FrmDirPath.ShowModal=mrOk then
    EdtPath.Text:=FrmDirPath.DirectoryListBox1.Directory;
end;

procedure TFrmBackup.Timer1Timer(Sender: TObject);
var
  Year,Month,Day,Hour,Min,Sec,MSec:Word;
begin
  DecodeDate(Now,Year,Month,Day);
  DecodeTime(Now, Hour, Min, Sec, MSec);

  case BackupType of
  0:begin//不备份
      //
    end;
  1:begin//每小时
      if (Min=EveryTime) and (Sec=0) then
        btnBackupClick(btnBackup);
    end;
  2:begin//每天
      if (Hour=EveryDay) and (Min=EveryTime) and (Sec=0) then
        btnBackupClick(btnBackup);
    end;
  3:begin//每周
      if ((DayOfWeek(Date)-1)=EveryWeek) and (Hour=EveryDay) and (Min=EveryTime) and (Sec=0) then
        btnBackupClick(btnBackup);
    end;
  4:begin//每月
      if (Day=EveryMonth) and (Hour=EveryDay) and (Min=EveryTime) and (Sec=0) then
        btnBackupClick(btnBackup);
    end;
  end;

end;

procedure TFrmBackup.FormCreate(Sender: TObject);
begin
  ReadIni();
  connString:='Driver={SQL server};server='+Trim(CmbServerName.Text)+';database='+Trim(CmbDatabaseName.Text)+
              ';uid='+Trim(EdtUserName.Text)+';pwd='+Trim(EdtPassword.Text);
  try
    connAdo.ConnectionString:=connString;
    connAdo.LoginPrompt:=False;
    connAdo.Connected:=True;
    conn:=True;
  except
    MessageBox(handle,'联接数据库错误','错误',mb_IconWarning+mb_Ok);
    Exit;
  end;


  //判断启动时是否最小化窗体
 { if StartMin=1 then
  begin
    //Application.Minimize;
    AddIcon(handle);
  end;  }
end;

procedure TFrmBackup.btnCancelClick(Sender: TObject);
begin
  //取消所做的修改
  ReadIni();
end;

procedure TFrmBackup.N2Click(Sender: TObject);
begin
  close;
end;

procedure TFrmBackup.N1Click(Sender: TObject);
begin
  FrmBackup.Visible := True;
end;

procedure TFrmBackup.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if CloseShow=1 then
  begin
    if MessageBox(Handle,'确实要关闭系统吗？','提示',MB_YESNO+MB_ICONINFORMATION)=IDNO then
    begin
      canClose:=False;
    end
    else
    begin
      RemoveIcon(handle);
      Application.Terminate ;
    end;
  end
  else begin
    RemoveIcon(handle);
    Application.Terminate ;
  end;
end;

procedure TFrmBackup.BitBtn1Click(Sender: TObject);
begin
  if Trim(CmbServerName.Text)='' then
  begin
    MessageBox(handle,'数据库服务器名称不能为空！','错误',mb_IconWarning+mb_Ok);
    CmbServerName.SetFocus;
    Exit;
  end;
  if Trim(CmbDatabaseName.Text)='' then
  begin
    MessageBox(handle,'数据库名称不能为空！','错误',mb_IconWarning+mb_Ok);
    CmbDatabaseName.SetFocus;
    Exit;
  end;
  if Trim(EdtUserName.Text)='' then
  begin
    MessageBox(handle,'用户名不能为空！','错误',mb_IconWarning+mb_Ok);
    EdtUserName.SetFocus;
    Exit;
  end;
  connString:='Driver={SQL server};server='+Trim(CmbServerName.Text)+';database='+Trim(CmbDatabaseName.Text)+
              ';uid='+Trim(EdtUserName.Text)+';pwd='+Trim(EdtPassword.Text);
  try
    screen.Cursor:=crSqlwait;
    with connAdo do
    begin
      if Connected then
         Connected:=False;
      ConnectionString:=connString;
      LoginPrompt:=False;
      Connected:=True;
    end;
    MessageBox(handle,'联接成功！','提示',MB_ICONINFORMATION+mb_Ok);
    conn:=True;
    screen.Cursor:=crdefault;
  except
    MessageBox(handle,'联接失败！','提示',mb_IconWarning+mb_Ok);
    screen.Cursor:=crdefault;
    conn:=False;
    Exit;
  end;
end;

procedure TFrmBackup.Button1Click(Sender: TObject);
var
  i,j:integer;
begin
  Application.CreateForm(TfrmChoose,frmChoose);
  //取得服务器中所有数据库名
  with connQuery do
  begin
    Close;
    Sql.Text:='select * from master.dbo.sysdatabases';
    open;
    while not Eof do
    begin
      frmChoose.list.Items.Add(Fields[0].Value);
      next;
    end;
  end;

  //列表框中取得要备份的数据库名称
  for i:=0 to cmbDatabaseName.Items.Count-1 do
  begin
    for j:=0 to frmChoose.list.Count-1 do
    begin
      if frmChoose.list.Items[j]=cmbDatabaseName.Items[i] then
        frmChoose.list.Checked[j]:=True;  
    end;
  end;

  if frmChoose.ShowModal=mrok then
  begin
    cmbDatabaseName.Clear;
    DatabaseName:='';
    for i:=0 to frmChoose.list.Count-1 do
    begin
      if frmChoose.list.Checked[i] then
      begin
        DatabaseName:=DatabaseName+frmChoose.list.Items[i]+'|';
        cmbDatabaseName.Items.Add(frmChoose.list.Items[i]);
      end;
    end;

    cmbDatabaseName.ItemIndex:=0;
  end;
end;


procedure TFrmBackup.ComBoboxValue(Cmb:TComBoBox;Str:string) ;
var i,j,k,n:integer ;
    s:string;
begin
  K:=0 ; n:=1;
  Cmb.Clear;
  For i:=1 to Length(Str) do
    if copy(Str,i,1)='|' then
      begin
        s:=copy(Str,n,i-n) ;
        Cmb.Items.Add(s);
        n:=i+1;
        k:=K+1 ;
      end ;
     Cmb.ItemIndex:=0; 
end;

end.
