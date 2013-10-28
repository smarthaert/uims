unit RasDial3;
//Downlolad by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Formauto, StdCtrls, ShellApi, ComCtrls, ExtCtrls, registry, IniFiles;

type
  TConfigureAutoForm = class(TAutoForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel2: TPanel;
    GroupBox4: TGroupBox;
    AutoStarted: TCheckBox;
    AutoConnected: TCheckBox;
    ReConnected: TCheckBox;
    Label7: TLabel;
    ReConnectTime: TComboBox;
    Label8: TLabel;
    ReConnectNb: TEdit;
    CancelButton: TButton;
    OkButton: TButton;
    procedure CancelButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    function  GetAutoConnect : Boolean;
    procedure SetAutoConnect(newValue : Boolean);
    function  GetAutoStart : Boolean;
    procedure SetAutoStart(newValue : Boolean);
    function  GetReConnect : Boolean;
    procedure SetReConnect(newValue : Boolean);
    procedure ExecuteProg(Exe, Dir : String);
function SetRegValue(key:Hkey; subkey,name,value:string):boolean;
procedure SetDelValue(ROOT: hKey; Path, Value: string);
  public
    Section : String;
    procedure Configure;
    property  AutoConnect : Boolean  read GetAutoConnect  write SetAutoConnect;
    property  AutoStart : Boolean  read GetAutoStart  write SetAutoStart;
    property  ReConnect : Boolean  read GetReConnect  write SetReConnect;
  end;

var
  ConfigureAutoForm: TConfigureAutoForm;

implementation

uses
  RasDial5, RasDial1;

{$R *.DFM}


//设置配置信息
procedure TConfigureAutoForm.Configure;
var
  OldAutoStart:Boolean;
  OldAutoConnect:Boolean;
  OldReConnect:Boolean;
  OldAutoPassword:Boolean;
  OldReConnectTime:integer;
  OldReConnectNb:integer;
begin
  OldAutoStart:=AutoStarted.Checked;                    //开机自动启动
  OldAutoConnect:=AutoConnected.Checked;                //自动连接
  OldReConnect:=ReConnected.Checked;                    //断线重新连接
//  OldAutoPassword:=RasDialerForm.AutoPassword.Checked;  //自动密码
  OldReConnectTime:=ReConnectTime.ItemIndex;            //重试间隔
  OldReConnectNb:=StrToIntDef(ReConnectNb.Text,3);      //重试次数

  if ShowModal<>mrOk then                               //若放弃修改则回滚
  begin
    AutoStarted.Checked:=OldAutoStart;                  //开机自动启动
    AutoConnected.Checked:=OldAutoConnect;              //自动连接
    ReConnected.Checked:=OldReConnect;                  //断线重新连接
//    RasDialerForm.AutoPassword.Checked:=OldAutoPassword;//自动密码
    ReConnectTime.ItemIndex:=OldReConnectTime;          //重试间隔
    ReConnectNb.Text:=IntToStr(OldReConnectNb);         //重试次数
  end;
end;


//关闭窗口
procedure TConfigureAutoForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if ModalResult<>mrOk then                             //按了放弃键
  begin
    if Application.MessageBox('您是否决定放弃修改 ?',
                              '注意', mb_YESNO+mb_DEFBUTTON2)<>IDYES then
    begin
      canClose:=FALSE;
    end;
  end;
end;

//自动连接标志
function TConfigureAutoForm.GetAutoConnect : Boolean;
begin
  Result:=AutoConnected.Checked;
end;

//修改是否自动连接标志
procedure TConfigureAutoForm.SetAutoConnect(newValue : Boolean);
begin
  AutoConnected.Checked:=newValue;
end;

//开机自动启动标志
function TConfigureAutoForm.GetAutoStart : Boolean;
begin
  Result:=AutoStarted.Checked;
end;

//修改开机自动启动标志
procedure TConfigureAutoForm.SetAutoStart(newValue : Boolean);
begin
  AutoStarted.Checked:=newValue;
end;

//断线自动连接标志
function TConfigureAutoForm.GetReConnect : Boolean;
begin
  Result:=ReConnected.Checked;
end;

//修改断线自动连接标志
procedure TConfigureAutoForm.SetReConnect(newValue : Boolean);
begin
  ReConnected.Checked:=newValue;
end;

//取消按键
procedure TConfigureAutoForm.CancelButtonClick(Sender: TObject);
begin
  inherited;
  ModalResult:=mrCancel;
end;

//确定按键
procedure TConfigureAutoForm.OkButtonClick(Sender: TObject);
var
  s,ss:string;
  Reg:TRegistry;                                        //首先定义一个TRegistry类型的变量Reg
begin
  inherited;

  s:='PPPOE Dialed';                                    //用于记录用户要添加的数值名称
  ss:=sPath+'RASDIAL.exe';                              //用于记录数值数据(即自启动程序的路径)
  ss:=application.ExeName;
  if AutoStarted.Checked then                           //开机自动启动
  begin
//    可用
//    Reg:=TRegistry.Create;                              //创建一个新键
//    Reg.RootKey:=HKEY_LOCAL_MACHINE;                    //将根键设置为HKEY_LOCAL_MACHINE
//    Reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run',true); //打开一个键
//    Reg.WriteString(s,ss);                              //在Reg这个键中写入数据名称和数据数值
//    Reg.CloseKey;                                       //关闭键
//    Reg.Free;

    //添加注册表项
    SetRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Windows\CurrentVersion\Run',s,ss);
  end
  else
  begin
//    不可用（删除指令错误）
//    Reg:=TRegistry.Create;                              //创建一个新键
//    Reg.RootKey:=HKEY_LOCAL_MACHINE;                    //将根键设置为HKEY_LOCAL_MACHINE
//    Reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run',true); //打开一个键
//    Reg.DeleteKey(s);                                   //在Reg这个键中删除数据名称和数据数值
//    Reg.CloseKey;                                       //关闭键
//    Reg.Free;

    //删除注册表项
    SetDelValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Windows\CurrentVersion\Run',s);
  end;

  ModalResult:=mrOk;
end;

//运行外部程序
procedure TConfigureAutoForm.ExecuteProg(Exe, Dir : String);
var
  ExeName:String;
  Params:String;
  I:Integer;
  Status:Integer;
  Msg:String;
begin
  if Exe[1]='"' then
  begin
    I:=2;
    while (I<=Length(Exe)) and (Exe[I]<>'"') do
    begin
      Inc(I);
    end;
    Params:=Trim(Copy(Exe, I+1, Length(Exe)));
    ExeName:=Trim(Copy(Exe, 2, I-2));
  end
  else
  begin
    I:=1;
    while (I<=Length(Exe)) and not (Exe[I] in ['/','*','?','"','<','>','|']) do
    begin
      Inc(I);
    end;
    Params:=Trim(Copy(Exe, I, Length(Exe)));
    ExeName:=Trim(Copy(Exe, 1, I-1));
  end;

  Status:=ShellExecute(Handle, 'open', PChar(ExeName), PChar(Params), PChar(Dir), SW_SHOWNORMAL);
  if Status>32 then
  begin
    Exit;
  end;

  case Status of
    0                      :Msg:='The operating system is out of memory '
                                +'or resources.';
    ERROR_FILE_NOT_FOUND   :Msg:='The specified file was not found.';
    ERROR_PATH_NOT_FOUND   :Msg:='The specified path was not found.';
    ERROR_BAD_FORMAT	     :Msg:='The .EXE file is invalid (non-Win32 '
                                +'.EXE or error in .EXE image).';
    SE_ERR_ACCESSDENIED	   :Msg:='The operating system denied access to '
                                +'the specified file.';
    SE_ERR_ASSOCINCOMPLETE :Msg:='The filename association is incomplete '
                                +'or invalid.';
    SE_ERR_DDEBUSY	       :Msg:='The DDE transaction could not be '
                                +'completed because other DDE '
                                +'transactions were being processed.';
    SE_ERR_DDEFAIL	       :Msg:='The DDE transaction failed.';
    SE_ERR_DDETIMEOUT	     :Msg:='The DDE transaction could not be '
                                +'completed because the request timed out.';
    SE_ERR_DLLNOTFOUND	   :Msg:='The specified dynamic-link library was '
                                +'not found.';
    SE_ERR_NOASSOC	       :Msg:='There is no application associated with '
                                +'the given filename extension.';
    SE_ERR_OOM	           :Msg:='There was not enough memory to complete '
                                +'the operation.';
    SE_ERR_SHARE	         :Msg:='A sharing violation occurred.';
    else
                            Msg:='ShellExecute failed with error #'+IntToStr(Status);
  end;
  MessageBeep(MB_OK);
  Msg:=Msg+#10+'trying to execute '''+Exe+'''';
  Application.MessageBox(PChar(Msg), 'Warning', MB_OK);
end;

//添加注册表项．．
function TConfigureAutoForm.SetRegValue(key:Hkey; subkey,name,value:string):boolean;
var
  regkey:hkey;
begin
  result:=false;
  RegCreateKey(key,PChar(subkey),regkey);
  if RegSetValueEx(regkey,Pchar(name),0,REG_EXPAND_SZ,pchar(value),length(value))=0 then
  begin
    result:=true;
  end;
  RegCloseKey(regkey);
end;

//删除注册表项
procedure TConfigureAutoForm.SetDelValue(ROOT: hKey; Path, Value: string);
var
  Key:hKey;
begin
  RegOpenKeyEx(ROOT, pChar(Path), 0, KEY_ALL_ACCESS, Key);
  RegDeleteValue(Key, pChar(Value));
  RegCloseKey(Key);
end;

procedure TConfigureAutoForm.FormCreate(Sender: TObject);
begin
  inherited;
  ReConnectTime.ItemIndex:=2;                           //重新连接时间
  ReConnectNb.Text:='1';                                //重新连接次数
end;

end.

