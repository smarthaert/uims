//Remote Access Service Dialer (RAS-DIALER)
unit RasDial1;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, StdActns,  ActnList, Menus,
  ExtCtrls, StdCtrls, winsock, ScktComp, Buttons,
  IniFiles, Ras, FormAuto, ShellApi, TB97Ctls, jpeg, UrlMon;



const
  iTest=0;                                              //0-正常、1-显示测试按键、2-显示测试、服务器地址按键
  Vers='1.10';                                          //当前版本（升级标志）

  WM_AUTOCONNECT=WM_USER+1;
  CM_RESTORE = WM_USER + $1000;                         //自定义的“恢复”消息
//  ADSL_APP_NAME = 'ADSL_System';
  WindowsMessage =WM_USER+101   ;
  WM_WZGLNOTIFY = WM_USER + 100;                        //自定义消息
  strNotifyTip = '天天上网拨号器';                      //状态区的提示信息
  ID_MAIN = 100;                                        //定义图标的ID

type
  TRasDialerForm = class(TAutoForm)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    PasswordEdit: TEdit;
    SavePWCheckBox: TCheckBox;
    CheckTimer: TTimer;
    EntryNameComboBox: TComboBox;
    UserNameComboBox: TComboBox;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    MnuQuit: TMenuItem;
    MnuConnect: TMenuItem;
    MnuProperties: TMenuItem;
    MnuNew: TMenuItem;
    MnuAbout: TMenuItem;
    MnuShowIP: TMenuItem;
    N1: TMenuItem;
    MnuOptions: TMenuItem;
    MnuConfigure: TMenuItem;
    ImageList1: TImageList;
    CoolBar1: TCoolBar;
    ToolBar3: TToolBar;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton9: TToolButton;
    CtrlN1: TMenuItem;
    CtrlD1: TMenuItem;
    ClientSocket1: TClientSocket;
    ToolButton1: TToolButton;
    Popupmenu: TPopupMenu;
    N11: TMenuItem;
    N21: TMenuItem;
    CtrlN2: TMenuItem;
    CtrlD2: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    ConnectBtn: TToolbarButton97;
    CancelBtn: TToolbarButton97;
    ConfigBtn: TToolbarButton97;
    AboutBtn: TToolbarButton97;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    InfoListBox: TListBox;
    Edit2: TEdit;
    Edit1: TEdit;
    Button1: TButton;
    Image1: TImage;
    Panel2: TPanel;
    Image2: TImage;
    URLLabel1: TLabel;
    Edit3: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckTimerTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EntryNameComboBoxChange(Sender: TObject);
    procedure UserNameComboBoxChange(Sender: TObject);
    procedure MnuQuitClick(Sender: TObject);
    procedure MnuPropertiesClick(Sender: TObject);
    procedure MnuNewClick(Sender: TObject);
    procedure IPButtonClick(Sender: TObject);
    procedure ClientSocket1Connect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Disconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure ConnectBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure ConfigBtnClick(Sender: TObject);
    procedure AboutBtnClick(Sender: TObject);
    procedure URLLabel1Click(Sender: TObject);
  private
    hRasConn        : THRASCONN;
    ConnectTime     : DWORD;
    aRasConn        : array [0..10] of TRASCONN;
    nRasConnCount   : DWORD;
    DialingServer   : String;
    DialingUserName : String;
    DialingPassword : String;
    procedure FileUpData();                             //系统自动更新
    function  DownloadFile(Source, Dest: string): Boolean;
    procedure WMAutoConnect(var Msg : TMessage); message WM_AUTOCONNECT;
    procedure Connected;
    procedure Disconnected;
    procedure GetActiveConn;
    procedure DisplayActiveConn;
    function  GetActiveConnHandle(szName : String) : THRASCONN;
    procedure SaveSettings;
    procedure LoadPhoneBook;
    procedure SelectPhoneBookEntry(EntryName : String);
    procedure GetUserNameList;
    procedure GetUserPassword;
    procedure DoConnect;
    procedure DoProperties;
    procedure DoNew;
    procedure DoCancel;
    procedure DoConfigure;

    procedure ReadTcp();                                //准备获取缴费截止日期
    function  AddIcon(hwnd: HWND): Boolean;             //在状态区添加图标
    function  RemoveIcon(hwnd: HWND): Boolean;          //从状态区移去图标
    procedure Notify(var Msg: TMessage); message WM_WZGLNOTIFY; //自定义消息处理函数
    procedure minimize(sender: Tobject);                //定义最小化过程，赋给Application.OnMinimize;

    procedure PPPOEInstall();                           //安装pppoe驱动程序
  public
    procedure Dial(EntryName, UserName, Password : String);
    procedure WndProc(var Msg: TMessage); override;
    procedure LogMessage(Msg : String);
  end;

var
  RasDialerForm: TRasDialerForm;
  nid: NOTIFYICONDATA;
//  Log:TLogMsg;
  LinkFun:integer;
  NB:integer;
  sOK,rOK:boolean;                                      //提交申请标志
  r:real;                                               //缴费截止日期
  iTime:real;                                           //拨号开始时间
  rMsg:string;                                          //应答信息
  dTime:real;                                           //断线重新连接初始化时间

  RasIcon:string;                                       //显示图标编号名称
  RasOK:boolean;                                        //PPPOE拨号标志
  ConOK:boolean;                                        //TCP连接标志
  ks:integer;                                           //重新连接时间计数器
  kt:integer;                                           //重新连接次数计数器

  Inst:Boolean;                                         //pppoe网卡安装标志

  kz:integer;                                           //TCP申请控制标志
  SPath:string;                                         //系统目录
  Up:string;                                            //升级标志

  iYear:Word;                                           //当前年
  iMon :Word;                                           //当前月
  iDay :Word;                                           //当前日
  iHour:Word;                                           //当前时
  iMin :Word;                                           //当前分
  iSec :Word;                                           //当前秒
  iMSec:Word;                                           //当前微秒
  lYear:Word;                                           //保留年
  lMon :Word;                                           //保留月
  lDay :Word;                                           //保留日
  lHour:Word;                                           //保留时
  lMin :Word;                                           //保留分
  lSec :Word;                                           //保留秒
  
implementation

uses
  RasDial2, RasDial3, JpgPast, auUtils;

{$R *.DFM}

//--{$R RasIcon.res}

const
  ProgName = '天天上网';
  ProgVer  = 'V1.10';


function Encrypt(S:String):String; forward;
function CrunchName(S:String):String; forward;

var
  g_hWnd: HWND;


//自动连接
procedure TRasDialerForm.WMAutoConnect(var Msg:TMessage);
begin
  LogMessage('开机自动启动');                           //显示提示信息
  LogMessage('自动连接');
  DoConnect;                                            //连接
end;


//在ListBox中显示Msg信息
procedure TRasDialerForm.LogMessage(Msg:String);
begin
//因为无法改变log文件的路径，所以取消保存log文件
//Log.Text('!',Msg);                                    //log文件
  InfoListBox.Items.Add(Msg);                           //拨号连接信息列表
  InfoListBox.Refresh;                                  //刷新
end;


//拨号
procedure RasDialFunc(unMsg:DWORD; RasConnState:TRASCONNSTATE; dwError:DWORD); stdcall;
begin
  PostMessage(g_hWnd,WM_RASDIALEVENT,RasConnState,dwError);

//Win32 API消息函数:PostMessage
//    函数功能：该函数将一个消息放入（寄送）到与指定窗口创建的线程相联系消息队列里，不等待线程处理消息就返回。消息队列里的消息通过调用GetMessage和PeekMessage取得。
//    函数原型：B00L PostMessage（HWND hWnd，UINT Msg，WPARAM wParam，LPARAM lParam）；
//    参数    hWnd：其窗口程序接收消息的窗口的句柄。可取有特定含义的两个值：
//                  HWND.BROADCAST：消息被寄送到系统的所有顶层窗口，包括无效或不可见的非自身拥有的窗口、被覆盖的窗口和弹出式窗口。消息不被寄送到子窗口。
//                  NULL：此函数的操作和调用参数dwThread设置为当前线程的标识符PostThreadMessage函数一样。
//            Msg：指定被寄送的消息。
//            wParam：指定附加的消息特定的信息。
//            IParam：指定附加的消息特定的信息。
//    返回值：如果函数调用成功，返回非零值：如果函数调用失败，返回值是零。若想获得更多的错误信息，请调用GetLastError函数。
//    备注：需要以 HWND_BROADCAST方式通信的应用程序应当用函数 RegisterwindwosMessage来获得应用程序间通信的独特的消息。
//    如果发送一个低于WM_USER范围的消息给异步消息函数（PostMessage.SendNotifyMessage，SendMesssgeCallback），消息参数不能包含指针。否则，操作将会失败。函数将再接收线程处理消息之前返回，发送者将在内存被使用之前释放。
//    速查：Windows NT： 3.1及以上版本；Windows：95及以上版本；Windows CE：1.0及以上版本；头文件：winuser.h；输入库：user32.lib；Unicode：在Windows NT环境下以Unicode和ANSI方式实现。
end;

//连接完成，显示连接信息
procedure TRasDialerForm.Connected;
var
  h: HWnd;
begin
  RasOK:=true;                                          //防止再入
  ConnectTime:=GetTickCount;                            //获取当前经过时间
//GetTickCount函数
//函数功能：GetTickCount返回（retrieve）从操作系统启动到现在所经过（elapsed）的毫秒数，它的返回值是DWORD。

  CtrlN1.Enabled:=false;
  CtrlN2.Enabled:=false;
  CtrlD1.Enabled:=true;
  CtrlD2.Enabled:=true;
  Caption:=ProgName+' - Connected';                     //标题

  //修改图标
  RasIcon:='RasIcon1';
  RemoveIcon(handle);
  AddIcon(handle);
//  ShowWindow(Application.handle, sw_hide)

//  Image2.Picture.Bitmap.Handle:=LoadBitmap(hInstance, 'RasIcon1');
  Image2.Picture.Bitmap.LoadFromResourceName(hInstance, 'RasIcon1');
//  StatusBar1.Panels.Items[0].text:='已连接';
  ReadTcp();

//  RasDialerForm.WindowState:=wsMinimized;             //不正确的
//  RasDialerForm.minimize(Sender);
//SendMessage(RasDialerForm.Handle,WM_SYSCOMMAND,   SC_MINIMIZE,0);

//  Application.Minimize;                                 //正确的
end;

//断开连接，显示断开信息
procedure TRasDialerForm.Disconnected;
begin
//hRasConn:=1;
  RasOK:=false;                                         //防止再入
  if hRasConn<>0 then
  begin
    RasHangUpA(hRasConn);                               //断开连接
    hRasConn:=0;
  end;
  ConnectTime:=0;                                       //清时钟计数器
  Caption:=ProgName;

  CtrlN1.Enabled:=true;
  CtrlN2.Enabled:=true;
  CtrlD1.Enabled:=false;
  CtrlD2.Enabled:=false;

  //修改图标
  RasIcon:='RasIcon2';
  RemoveIcon(handle);
  AddIcon(handle);
//  ShowWindow(Application.handle, sw_hide)

//  Image2.Picture.Bitmap.Handle:=LoadBitmap(hInstance, 'RasIcon2');
  Image2.Picture.Bitmap.LoadFromResourceName(hInstance, 'RasIcon2');
  StatusBar1.Panels.Items[0].text:='';
end;

//WIN消息（回调函数）
procedure TRasDialerForm.WndProc(var Msg:TMessage);
var
  ss:string;
  Buf:array [0..255] of Char;
begin
  if Msg.Msg<>WM_RASDIALEVENT then
  begin
    inherited WndProc(Msg);
    Exit;
  end;
  ss:=RasConnectionStateToString(Msg.wParam);           //连接状态
  LogMessage(ss);                                       //连接信息
  if Msg.wParam=RASCS_Connected then                    //连接成功
  begin
    dTime:=now;                                         //重拨计数器清零计时（连接后10分钟清零）
    Connected;
    Application.Minimize;                               //窗口最小化
  end
  else if Msg.wParam=RASCS_Disconnected then            //连接出错
  begin
    RasGetErrorStringA(Msg.lParam,@Buf[0],SizeOf(Buf));
    LogMessage(Buf);
    showmessage('          '+IntToStr(Msg.wParam)+' '+Buf+'           ');
    Disconnected;
  end;
end;

//系统配置文件 *.INI 的操作
//（1） INI文件的结构：
//;这是关于INI文件的注释部分
//[节点]
//关键字=值
//...
//INI文件允许有多个节点，每个节点又允许有多个关键字， “=”后面是该关键字的值（类型有三种：字符串、整型数值和布尔值。其中字符串存贮在INI文件中时没有引号，布尔真值用1表示，布尔假值用0表示）。注释以分号“;”开头。

//（2） INI文件的操作
//1、 在Interface的Uses节增加IniFiles；
//2、 在Var变量定义部分增加一行：inifile:Tinifile;然后，就可以对变量myinifile进行创建、打开、读取、写入等操作了。
//3、 打开INI文件：inifile:=Tinifile.create('tmp.ini');
//4、 读取关键字的值:
//    a:=inifile.Readstring('节点','关键字',缺省值);// string类型
//    b:=inifile.Readinteger('节点','关键字',缺省值);// integer类型
//    c:=inifile.Readbool('节点','关键字',缺省值);// boolean类型
//    其中[缺省值]为该INI文件不存在该关键字时返回的缺省值。
//5、 写入INI文件:
//    inifile.writestring('节点','关键字',变量或字符串值);
//    inifile.writeinteger('节点','关键字',变量或整型值);
//    inifile.writebool('节点','关键字',变量或True或False);
//    当这个INI文件的节点不存在时，上面的语句还会自动创建该INI文件。
//6、 删除关键字：
//    inifile.DeleteKey('节点','关键字');//关键字删除
//    inifile.EraseSection('节点');// 节点删除
//7、 节点操作：
//    inifile.readsection('节点',TStrings变量);//可将指定小节中的所有关键字名读取至一个字符串列表变量中；
//    inifile.readsections(TStrings变量);//可将INI文件中所有小节名读取至一个字符串列表变量中去。
//    inifile.readsectionvalues('节点',TStrings变量);//可将INI文件中指定小节的所有行（包括关键字、=、值）读取至一个字符串列表变量中去。
//8、 释放：inifile.distory;或inifile.free;




//定时器（每5秒钟扫描1次连接状态）
procedure TRasDialerForm.CheckTimerTimer(Sender: TObject);
var
  s,ss,Zh:string;
  i,k,n:integer;
  RasConnStatus:TRASCONNSTATUS;
  Status:DWORD;
  Buf:array [0..255] of Char;
  IPAddr:String;
begin
  CheckTimer.Enabled:=FALSE;                            //关闭定时器
  DecodeDate(Date, iYear, iMon, iDay);                  //获取年、月、日
  DecodeTime(Time, iHour, iMin, iSec, iMSec);           //获取时、分、秒
  Application.ProcessMessages;                          //让其他控件能获取消息

//未用（无法做到真正控制）
//  if Inst then                                          //pppoe网卡安装标志
//  begin
//    Inst:=false;                                        //pppoe网卡安装标志
//    LoadPhoneBook;                                      //获取PPPOE虚拟网卡
//    EntryNameComboBox.ItemIndex:=0;
//  end;

  //准备读取提醒信息
  if ConOK then                                         //已进入连接标志
  begin
    ConOK:=false;

    IPAddr:=RasGetIPAddress;                            //读取IP
    if IPAddr>'' then
    begin
      StatusBar1.Panels.Items[0].text:=IPAddr;          //显示IP
    end;

    //准备从宽带系统获取用户信息
    if iTest=0 then
    begin
      s:=UserNameComboBox.Text;                         //用户帐号
    end
    else
    begin
//    s:='9912345678';
      s:='917000376';
      s:=Edit1.Text;
    end;

//申请字符串格式：290000001|1.10
//                帐号|版本号

    try
      ClientSocket1.Socket.SendText(s+'|'+Vers);          //申请缴费截止日期
      sOK:=true;                                          //提交申请标志
    except
    end;
  end;
  Application.ProcessMessages;                          //让其他控件能获取消息

  //已经收到提醒信息
  if sOK and rOK then
  begin
    sOK:=false;                                         //提交申请标志
    rOK:=false;                                         //获取应答标志

//rMsg格式：290000001|0|包年|2008-04-05
//          帐号|升级标志|包年包月|缴费截止日期

    i:=pos('|',rMsg);                                   //在应答信息中提取分隔符
    Zh:=LeftStr(rMsg,i-1);                              //获取帐号
    Up:=MidStr(rMsg,i+1,1);                             //获取升级标志：0-正常、U-需要升级
    ss:=MidStr(rMsg,i+3,100);                           //截取应答信息（让过升级标志和分隔符'|'）

    i:=pos('|',ss);                                     //在应答信息中提取分隔符
    s:=LeftBStr(ss,i-1);                                //提前提醒天数
    k:=StrToIntDef(s,3);                                //未知则为3天
    s:=MidStr(ss,i+1,20);                               //取缴费截止日期
    r:=StrToDateDef(s,0);
    JpgPastForm.Jfjzrq:=r;                              //缴费截止日期

    //若查询用户名等于应答用户名
    if Zh=UserNameComboBox.Text then                    //若是正确应答
    begin
      if (r>StrToDate('2000-1-1')) and (r-k<date) then  //若时间段正确
      begin
        //显示提醒缴费信息
        JpgPastForm.Show;                               //显示提醒
      end;
    end;
    Application.ProcessMessages;                        //让其他控件能获取消息

    //测试（不考虑时间因素）
    if iTest>0 then
    begin
      InfoListBox.Items.Add('缴费截止日期='+s);         //显示
      JpgPastForm.Show;                                 //显示提醒
    end;
    Application.ProcessMessages;                        //让其他控件能获取消息

    //系统自动更新
    if Up='U' then                                      //需要自动更新
    begin
      FileUpData();                                     //自动更新
    end;
    rMsg:='';                                           //清缴费截止日期信息
  end;

  if iSec<>lSec then                                    //已经进入新的一秒
  begin
    lSec:=iSec;                                         //保留当前秒
//  StatusBar1.Panels.Items[0].text:='未连接';
    StatusBar1.Panels.Items[1].text:=FormatDateTime('yyyy"年"mm"月"dd"日 "hh"时"mm"分"ss"秒"',now);
    Application.ProcessMessages;                        //让其他控件能获取消息

    //遍历所有虚拟网卡
    for i:=0 to EntryNameComboBox.Items.Count-1 do
    begin
//    hRasConn:=GetActiveConnHandle(EntryNameComboBox.Text);     //读取活动连接的句柄（只是当前网络适配器的连接）
      hRasConn:=GetActiveConnHandle(EntryNameComboBox.Items[i]); //读取活动连接的句柄（所有网络适配器的连接）
      if hRasConn>0 then                               //若连接
      begin
        EntryNameComboBox.ItemIndex:=i;
        break;
      end;
    end;

    if hRasConn=0 then                                  //若未连接则退出
    begin
      if RasOK then                                     //在已连接状态
      begin
        Disconnected;                                   //断开连接操作
        ks:=0;                                          //重新连接时间计数器
        if kt<9999 then                                 //防止溢出
        begin
          kt:=kt+1;                                     //重新连接次数计数器
        end;  
        showmessage('              用户名或密码错误！               ');
      end;

      if ks<9999 then                                   //防止溢出
      begin
        ks:=ks+1;                                       //重新连接时间计数器
      end;
      case ConfigureAutoForm.ReConnectTime.ItemIndex of
        0: k:=1;                                        //1 秒
        1: k:=3;                                        //3 秒
        2: k:=5;                                        //5 秒
        3: k:=10;                                       //10 秒
        4: k:=30;                                       //30  秒
        5: k:=60;                                       //1 分钟
        6: k:=120;                                      //2 分钟
        7: k:=300;                                      //5 分钟
        8: k:=600;                                      //10 分钟
        else k:=10;                                     //10 秒
      end;
      n:=StrToIntDef(ConfigureAutoForm.ReConnectNb.Text,2);

      //自动连接
      if (ks>=k) and (kt<n) then                        //定时时间到且在重拨次数中
      begin
        ks:=0;
        if ConfigureAutoForm.AutoConnect then           //若是自动连接
          PostMessage(Handle,WM_AUTOCONNECT,0,0);       //提交信息
      end;
      CheckTimer.Enabled:=TRUE;                          //激活定时器
      Exit;
    end;

//  Fillchar是System单元的一个标准过程，它的使用格式是：FillChar(var X; Count: Word; value)，它的功能是，把指定变量X在内存段中所占的低Count个字节赋为相同的值value， 其中value是填充的值，只能是Byte、Char或Boolean等单字节类型的值。在Free Pascal中稍加扩展为FillChar(var X; Count: Longint; value), 功能没变。
    FillChar(RasConnStatus, SizeOf(RasConnStatus), 0);      //在RasConnStatus中填0
    RasConnStatus.dwSize:=SizeOf(RasConnStatus);            //RasConnStatus长度
    Status:=RasGetConnectStatusA(hRasConn, @RasConnStatus); //获取连接状态

    if Status=ERROR_INVALID_HANDLE then                     //连接错误
    begin
      LogMessage('关闭连接');                               //连接已被断开
      Disconnected;                                         //断开连接操作
      CheckTimer.Enabled:=TRUE;                             //激活定时器
      Exit;
    end;

    if Status<>0 then                                       //正常为0
    begin
      Buf:='';
      RasGetErrorStringA(Status,@Buf[0],SizeOf(Buf));       //获取错误信息
      LogMessage('Error #'+IntToStr(Status)+' : '+Buf);     //显示错误信息
    end;

    //判断是否连接，修改图标
    if Status=0 then                                    //若已连接
    begin
      if not RasOK then                                 //防止再入标志，若未连接状态
      begin
        Connected;
      end;
    end
    else                                                //若未连接
    begin
      if RasOK then                                     //在已连接状态
      begin
        Disconnected;                                   //断开连接操作
      end;
    end;

    if now-dTime>0.007 then                             //上次通信已经过了10分钟
    begin
      kt:=0;                                            //断线重拨次数清零
    end;

    if iMin<>lMin then                                  //已经进入新的一分钟
    begin
      lMin:=iMin;                                       //保留当前分钟
      if iHour<>lHour then                              //已经进入新的一小时
      begin
        lHour:=iHour;                                   //保留当前小时
      end;
    end;
  end;
  CheckTimer.Enabled:=TRUE;                             //激活定时器
  Application.ProcessMessages;                          //让其他控件能获取消息
end;

//PPPOE拨号
procedure TRasDialerForm.Dial(EntryName, UserName, Password : String);
var
  rdParams:TRASDIALPARAMS;
  dwRet:DWORD;
  Buf:array [0..255] of Char;
begin
  kz:=99;                                               //TCP申请控制标志

  //检测是否已经连接
  hRasConn:=GetActiveConnHandle(EntryName);             //读取活动连接的句柄
  if hRasConn<>0 then
  begin
    LogMessage('已经连接');                             //已经连接
    Connected;
    ConnectTime:=$FFFFFFFF;                             //连接时间不再记录
    Exit;
  end;

  //设置RAS拨号参数
  FillChar(rdParams,SizeOf(rdParams),0);                //缓冲区填0
  rdParams.dwSize:=SizeOf(TRASDIALPARAMS);              //拨号参数的长度
  strCopy(rdParams.szUserName,PChar(UserName));         //用户名
  strCopy(rdParams.szPassword,PChar(Password));         //密码
  strCopy(rdParams.szEntryName,PChar(EntryName));       //网络适配器
  rdParams.szPhoneNumber[0]:=#0;                        //电话号码
  rdParams.szCallbackNumber[0]:='*';                    //回拨号码
  rdParams.szDomain:='*';                               //域名？

//　　 UNLEN = 256;
//　　 PWLEN = 256;
//　　 DNLEN = 15;
//　　 RAS_MaxEntryName　　 = 256;//连接名称最大长度
//　　 RAS_MaxDeviceName　　 = 128;//设备名称最大长度
//　　 RAS_MaxDeviceType　　 = 16;//设备类型名称长度
//　　 { RAS_MaxParamKey　　 = 32;
//　　 RAS_MaxParamValue　　 = 128;}
//　　 RAS_MaxPhoneNumber　　= 128;//电话号码的最大长度
//　　 RAS_MaxCallbackNumber = RAS_MaxPhoneNumber;
//　　 TRASDialParams = Record
//　　　　 dwSize: DWORD;
//　　　　 szEntryName: Array[0..RAS_MaxEntryName] Of Char;
//　　　　 szPhoneNumber: Array[0..RAS_MaxPhoneNumber] Of Char;
//　　　　 szCallbackNumber: Array[0..RAS_MaxCallbackNumber] Of Char;
//　　　　 szUserName: Array[0..UNLEN] Of Char;
//　　　　 szPassword: Array[0..PWLEN] Of Char;
//　　　　 szDomain: Array[0..DNLEN] Of Char;
//　　 end;


//　获取所有活动的拨号连接的信息列表（连接句柄和电话号码）的RasApi32函数为RasEnumConnections，
//其函数原型为：function　RasEnumConnections(LPRASCONN lprasconn，LPDWORD lpcb，LPDWORD lpcConnections) ：DWORD;stdcall;
//　　参数说明：
//　　lprasconn：接收活动连接的缓冲区的指针；
//　　lpcb：接收缓冲区的字节大小；
//　　lpcConnections：实际的活动连接数。
//　　返回值函数的返回值为0表示执行成功；不为0执行失败。
//　　为了正确使用这两个函数，我们要事先定义函数，常数，结构类型及其他信息，有关这一部份的内容都写入rasapi.pas单元。



  g_hWnd:=Handle;                                       //句柄
  hRasConn:=0;;

//RasAPI函数拨号 用拨号连接拨号的RasAPI函数为RasDial
//function RasDial(pRasDialExtensions : LPRASDIALEXTENSIONS;//在WIN9X下无用,可设置为NIL
//                 lpszPhonebook : PChar;//电话本名称，在Win9X下无作用,可为空字符串
//                 lpRasDialParams : LPRASDIALPARAMS;//拨号参数
//                 dwNotifierType : DWORD;//消息通知方式
//                 handle : TRasDialFunc;//消息处理事件
//                 var lphRasConn : DWORD//返回的成功连接的连接句柄
//                 ) : DWORD; stdcall;


  dwRet:=RasDialA(nil,nil,@rdParams,0,@RasDialFunc,@hRasConn); //开始拨号
  if dwRet<>0 then                                      //错误
  begin
    RasGetErrorStringA(dwRet,@Buf[0],SizeOf(Buf));      //获取错误信息
    LogMessage(IntToStr(dwRet)+' '+Buf);                //显示
    showmessage('          '+IntToStr(dwRet)+' '+Buf+'           ');
    Disconnected;                                       //断开连接
  end
  else
  begin
    LogMessage('正在拨号 '''+EntryName+'''');            //显示拨号设备
    //此时连接成功
  end;
end;

//保存配置信息->INI文件，拨号时保存1次、退出系统时保存1次
procedure TRasDialerForm.SaveSettings;
var
  IniFile:TIniFile;
  EntryName:String;
  UserName:String;
begin
  IniFile:=TIniFile.Create(FIniFileName);                                         //打开INI文件
  IniFile.WriteString('Last','EntryName',EntryNameComboBox.Text);                 //PPPOE网卡名称
  IniFile.WriteString('Last','UserName',UserNameComboBox.Text);                   //用户名
  IniFile.WriteInteger('Last','AutoPW',ord(SavePWCheckBox.Checked));              //自动密码 ord(false)=0、ord(true)=1
  IniFile.WriteInteger('Last','AutoStart',ord(ConfigureAutoForm.AutoStart));      //开机自动启动
  IniFile.WriteInteger('Last','AutoConnect',ord(ConfigureAutoForm.AutoConnect));  //自动连接
  IniFile.WriteInteger('Last','ReConnect',ord(ConfigureAutoForm.ReConnect));      //断线自动连接
  IniFile.WriteInteger('Last','ReConnect',ord(ConfigureAutoForm.ReConnect));      //断线自动连接
  IniFile.WriteInteger('Last','ReConnect',ord(ConfigureAutoForm.ReConnect));      //断线自动连接
  IniFile.WriteInteger('Last','ReConnectTime',ConfigureAutoForm.ReConnectTime.ItemIndex);        //重试间隔
  IniFile.WriteInteger('Last','ReConnectNb',StrToIntDef(ConfigureAutoForm.ReConnectNb.Text,3));  //重试次数
  if SavePWCheckBox.Checked then                                                  //如果保存密码
  begin
    IniFile.WriteString('Last', '   Password',EnCrypt(PasswordEdit.Text));        //密码（EnCrypt(Password)-加密密码）
    IniFile.WriteString('Last','SavePW', '1');                                    //保存密码标志
    EntryName:=CrunchName(Trim(EntryNameComboBox.Text));                          //转换多义符号
    UserName:=CrunchName(Trim(UserNameComboBox.Text));
    if (UserName<>'') and (EntryName<>'') then                                    //若用户名和网卡不空
    begin
      IniFile.WriteString('RAS_ENTRY_'+EntryName,                                 //网卡、用户名、密码
                          'USER_'+UserName,EnCrypt(PasswordEdit.Text));
    end;
  end
  else                                                                            //不保存密码
  begin
    IniFile.WriteString('Last','Password','');                                    //置空密码
    IniFile.WriteString('Last','SavePW','0');                                     //保存密码标志
  end;
  IniFile.Free;                                                                   //关闭INI文件
end;

//RAS拨号连接
procedure TRasDialerForm.DoConnect;
var
  IPAddr:String;
begin
  if not CtrlN1.Enabled then exit;

  SaveSettings;                                         //保存配置信息
  InfoListBox.Clear;                                    //清列表框
  Caption:=ProgName+' - Dialing';                       //标题栏
  ConfigureAutoForm.Section:='RAS_ENTRY_'+CrunchName(EntryNameComboBox.Text); //保存网卡信息

  DialingServer:=EntryNameComboBox.Text;                //拨号服务器（PPPOE网络适配器）
  DialingUserName:=UserNameComboBox.Text;               //用户名
  DialingPassword:=PasswordEdit.Text;                   //密码
  Dial(DialingServer,DialingUserName,DialingPassword);  //拨号连接
  
  IPAddr:=RasGetIPAddress;
  iTime:=now;                                           //拨号开始时间

//  RasIcon:='RasIcon1';
//  RemoveIcon(handle);
//  AddIcon(handle);
//  ShowWindow(Application.handle, sw_hide)
end;

//关闭窗口
procedure TRasDialerForm.FormClose(Sender:TObject; var Action:TCloseAction);
begin
  CheckTimer.Enabled:=FALSE;                            //关闭定时器
end;

//关闭窗口过程
procedure TRasDialerForm.FormCloseQuery(Sender: TObject; var CanClose:Boolean);
var
  Status:Integer;
begin
//不能做到自动最小化窗口
//  RasDialerForm.minimize(Sender);
//  CanClose:=false;

  SaveSettings;                                         //保存配置

  if Up='U' then                                        //系统升级标志，此时必为连接状态
  begin
    exit;
  end;

  if hRasConn<>0 then                                   //RAS已连接
  begin
    Status:=Application.MEssageBox('退出时是否断开连接？','注意',MB_YESNOCANCEL);
    if Status=IDCANCEL then                             //取消
    begin
//      ShowWindow(Application.handle, sw_hide)
      CanClose:=FALSE;
      Exit;
    end;
    if (Status=IDOK) or (Status=6) then                  //断开连接 IDOK=1 OK键返回6
    begin
      RasHangUpA(hRasConn);
      hRasConn:=0;
    end;
  end;
end;

//取消按键
procedure TRasDialerForm.CancelButtonClick(Sender: TObject);
begin
  DoCancel;
end;

//取消
procedure TRasDialerForm.DoCancel;
begin
  if CtrlN1.Enabled then exit;

  if ConnectTime=0 then
    LogMessage('Canceled')
  else
  begin
    LogMessage('Disconnecting');                        //
  end;
  Disconnected;                                         //断开？
end;

//密码加密
function Encrypt(S:String):String;
type
  PWORD=^WORD;
var
  Len:Integer;
  I:Integer;
  V:DWORD;
  P:PChar;
  Buffer:String[255];
begin
  Buffer:=S;
  Len:=Length(Buffer)+1;
  if (Len mod 2)<>0 then
    Inc(Len);

  if Len<10 then
    Len:=10;

  I:=Length(Buffer);
  if I=0 then
    Buffer:=IntToStr(GetTickCount)
  else
    while Length(Buffer)<10 do
       Buffer:=Buffer+Buffer;
  SetLength(Buffer,I);

  Result:='';
  P:=PChar(@Buffer[0]);
  for I:=1 to Len div 2 do
  begin
    V:=22356+PWORD(P)^;
    P:=P+2;
    Result:=Result+Format('%5.5d',[V]);
  end;
end;

//密码解密
function Decrypt(S:String):String;
type
  PWORD=^WORD;
var
  Buffer:String;
  PW:String[255];
  P:PWORD;
  I:Integer;
  V:Integer;
begin
  PW:='                                   ';
  P:=PWORD(@PW[0]);
  I:=1;
  while I<=Length(S) do
  begin
    Buffer:=Copy(S,I,5);
    I:=I+5;
    V:=StrToInt(Buffer)-22356;
    P^:=V;
    Inc(P);
  end;
  Result:=PW;
end;

//读取活动连接
procedure TRasDialerForm.GetActiveConn;
var
  dwRet:DWORD;
  nCB:DWORD;
  Buf:array [0..255] of Char;
begin
  aRasConn[0].dwSize := SizeOf(aRasConn[0]);
  nCB:=SizeOf(aRasConn);
  dwRet:=RasEnumConnectionsA(@aRasConn, @nCB, @nRasConnCount); //枚举活动连接
  if dwRet<>0 then
  begin
    RasGetErrorStringA(dwRet,@Buf[0],SizeOf(Buf));
    LogMessage(Buf);
  end;
end;

//读取活动连接szName的句柄
function TRasDialerForm.GetActiveConnHandle(szName:String): THRASCONN;
var
  I:Integer;
begin
  GetActiveConn;
  if nRasConnCount>0 then
  begin
    for I:=0 to nRasConnCount-1 do
    begin
      if StrIComp(PChar(szName), aRasConn[I].szEntryName)=0 then
      begin
        Result:=aRasConn[I].hRasConn;
        Exit;
      end;
    end;
  end;
  Result:=0;
end;

//显示当前连接
procedure TRasDialerForm.DisplayActiveConn;
var
  I:Integer;
begin
  if nRasConnCount>0 then
  begin
    LogMessage(IntToStr(nRasConnCount)+'已经连接');
    for I:=0 to nRasConnCount-1 do
      LogMessage(aRasConn[I].szEntryName);
  end;
end;

//显示窗口，读取ini文件
procedure TRasDialerForm.FormShow(Sender: TObject);
var
  FirstTime : Boolean;
  IniFile   : TIniFile;
  SavePW    : String;
  AutoPW    : String;
  AutoFlag  : String;
  EntryName : String;
begin
  inherited;                                                           //继承

  //从ini文件获取配置信息
  FirstTime:=TRUE;                                                     //进入标志
  if FirstTime then
  begin
    FirstTime:=FALSE;
    Caption:=ProgName;                                                 //程序名
    LoadPhoneBook;                                                     //获取PPPOE虚拟网卡
    IniFile:=TIniFile.Create(FIniFileName);                            //打开INI文件
    EntryName:=IniFile.ReadString('Last','EntryName','');              //获取最后使用的PPPOE虚拟网卡
    SelectPhoneBookEntry(EntryName);                                   //从PPPOE虚拟网卡列表中择出最后使用的PPPOE虚拟网卡（防止出错）
    UserNameComboBox.Text:=IniFile.ReadString('Last','UserName','');   //获取最后使用的用户名
    AutoPW:=IniFile.ReadString('Last','AutoPW','1');                   //获取自动密码标志
    SavePWCheckBox.Checked:=(AutoPW<>'0');                             //修改配置窗口的自动密码属性
    AutoFlag:=IniFile.ReadString('Last','AutoStart','0');              //获取开机自动启动属性
    ConfigureAutoForm.AutoStart:=(AutoFlag<>'0');                      //修改配置窗口的开机自动启动属性
    AutoFlag:=IniFile.ReadString('Last','AutoConnect','0');            //获取自动连接属性
    ConfigureAutoForm.AutoConnect:=(AutoFlag<>'0');                    //修改配置窗口的自动连接属性
    AutoFlag:=IniFile.ReadString('Last','ReConnect','0');              //获取断线自动连接属性
    ConfigureAutoForm.ReConnect:=(AutoFlag<>'0');                      //修改配置窗口的断线自动连接属性

    AutoFlag:=IniFile.ReadString('Last','ReConnectTime','0');          //获取重试间隔
    ConfigureAutoForm.ReConnectTime.ItemIndex:=StrToInt(AutoFlag);     //修改配置窗口的重试间隔
    AutoFlag:=IniFile.ReadString('Last','ReConnectNb','0');            //获取重试次数
    ConfigureAutoForm.ReConnectNb.Text:=AutoFlag;                      //修改配置窗口的重试次数


    SavePW:= IniFile.ReadString('Last','Password','');                 //获取用户密码
    if SavePW<>'' then                                                 //若密码不空
    begin
      PasswordEdit.Text:=DeCrypt(SavePW);                              //填写密码
    end
    else
    begin
      PasswordEdit.Text:='';                                           //置空密码
    end;
    SavePW:=IniFile.ReadString('Last','SavePW','0');                   //获取自动密码属性
    SavePWCheckBox.Checked:=(SavePW='1');                              //修改自动密码属性
    IniFile.Free;                                                      //关闭ini文件
    GetActiveConn;                                                     //获取当前连接
    DisplayActiveConn;                                                 //显示当前连接
    ConfigureAutoForm.Section:='RAS_ENTRY_'+CrunchName(EntryNameComboBox.Text); //时间设置窗口的网卡
/////    ConfigureAutoForm.LoadFromIniFile;                                      //读取

    //从ini文件中读取用户帐号列表
    GetUserNameList;

    //自动连接
    if ConfigureAutoForm.AutoConnect then                              //若是自动连接
      PostMessage(Handle,WM_AUTOCONNECT,0,0);                          //提交信息

  end;

  //若发现升级文件，删除升级文件
  if FileExists(sPath+'SUpData.exe') then
  begin
    DeleteFile(sPath+'SUpData.exe');
  end;
  CheckTimer.Enabled:=TRUE;                             //激活定时器
end;

//改变字符串定义
function CrunchName(S:String):String;
var
  I:Integer;
begin
  Result:='';
  for I:=1 to Length(S) do
  begin
    case S[I] of
      ' ': Result:=Result+'_';
      '=': Result:=Result+'\-';
      '@': Result:=Result+'\A';
      '_': Result:=Result+'\_';
      '\': Result:=Result+'\\';
      else
           Result:=Result+S[I];
    end;
  end;
end;

//在虚拟网卡列表中选择最后一次使用的网卡
procedure TRasDialerForm.SelectPhoneBookEntry(EntryName : String);
var
  I:Integer;
begin
  for I:=0 to EntryNameComboBox.Items.Count-1 do
  begin
    if EntryNameComboBox.Items[I]=EntryName then
    begin
      EntryNameComboBox.ItemIndex:=I;
      Exit;
    end;
  end;
end;


//获取PPPOE虚拟网卡
procedure TRasDialerForm.LoadPhoneBook;
var
  Entries:array [0..15] of TRASENTRYNAME;
  cb:DWORD;
  cEntries:DWORD;
  dwRet:DWORD;
  Buf: array [0..127] of char;
  I:Integer;
  ok:boolean;
begin
  FillChar(Entries,SizeOf(Entries),0);
  Entries[0].dwSize:=SizeOf(TRASENTRYNAME);
  cb:=SizeOf(Entries);
  cEntries:=0;

//function RasEnumEntries;external RasApiDll name 'RasEnumEntriesA';
//参数lprasentryname提供了一个RASENTRYNAME类型数组的指针，指向一个接收拨号连接名称的缓冲区，其中RASENTRYNAME及LPRASENTRYNAME的类型说明如下：
//LPRASENTRYNAME = ^RASENTRYNAME;
//RASENTRYNAME = record
//dwSize : DWORD;//该结构所占内存的大小(Bytes)　一般设置为SizeOf(RASENTRYNAME)
//szEntryName : array [ 0..RAS_MaxEntryName ] of char;//拨号连接名称
//lpcb为缓冲区的大小，一般设置为dwSize的倍数，倍数为可能有的连接的个数．
//lpcEntries实际的连接的个数．

  dwRet:=RasEnumEntriesA(NIL,NIL,@Entries[0],@cb,@cEntries); //RAS IPA函数 获取PPPOE虚拟网卡
  if dwRet<>0 then
  begin
    RasGetErrorStringA(dwRet, @Buf[0], SizeOf(Buf));    //错误标识符、错误提示信息的缓冲区、错误提示信息的缓冲区大小
    LogMessage(Buf);                                    //显示错误信息
  end;

  if (cEntries=0) then
  begin
    PPPOEInstall();                                     //安装pppoe驱动程序
    exit;
  end;

  EntryNameComboBox.Items.Clear;
//  ConfigureAutoForm.EntryNameComboBox.Items.Clear;
  for I:=0 to cEntries-1 do
  begin
    EntryNameComboBox.Items.Add(Entries[I].szEntryName);
//    ConfigureAutoForm.EntryNameComboBox.Items.Add(Entries[I].szEntryName);
  end;
end;

//从ini文件读取密码
procedure TRasDialerForm.GetUserPassword;
var
  IniFile:TIniFile;
  Password:String;
  EntryName:String;
  UserName:String;
begin
  if not SavePWCheckBox.Checked then
  begin
    PasswordEdit.Text:='';                              //密码置空
    Exit;
  end;

  IniFile:=TIniFile.Create(FIniFileName);               //打开ini文件
  EntryName:=CrunchName(Trim(EntryNameComboBox.Text));  //网卡名称
  UserName:=CrunchName(Trim(UserNameComboBox.Text));    //用户名
  Password:=IniFile.ReadString('RAS_ENTRY_'+EntryName,  //根据网卡、用户名读取密码（默认值='*'）
                               'USER_'+UserName,'*');
  IniFile.Free;                                         //关闭ini文件

  if Password<>'*' then                                 //若密码<>'*'，读出密码
  begin
    PasswordEdit.Text:=DeCrypt(Password);               //解密密码放入密码对话框
  end
  else
  begin
    PasswordEdit.Text:='';                              //密码置空
  end;
end;

//从ini文件中读取用户帐号列表
procedure TRasDialerForm.GetUserNameList;
var
  IniFile:TIniFile;
  List:TStringList;
  I:Integer;
  Buffer:String;
begin
//  if not ConfigureAutoForm.AutoUserName then
//  begin
//    Exit;
//  end;

  List:=TStringList.Create;                             //建立字符串列表
  IniFile:=TIniFile.Create(FIniFileName);               //打开ini文件
  IniFile.ReadSection('RAS_ENTRY_'
                      +CrunchName(Trim(EntryNameComboBox.Text)),List); //取该网卡下的所有信息（等号左边的内容）
  UserNameComboBox.Items.Clear;                         //清用户名下拉框
  if List.Count>0 then                                  //若读到信息
  begin
    for I:=0 to List.Count-1 do                         //遍历所有信息
    begin
      Buffer:=List.Strings[I];                          //取出一条信息
      if Copy(Buffer,1,5)='USER_' then                  //判断是否用户名相关
      begin
        UserNameComboBox.Items.Add(Copy(Buffer,6,100)); //增加用户名
      end;
    end;
    if UserNameComboBox.Items.Count>0 then              //若有用户名存在
    begin
      UserNameComboBox.Text:=UserNameComboBox.Items[0]; //显示第一个用户名
    end;
  end;
  IniFile.Free;                                         //关闭ini文件
  List.DEstroy;                                         //释放字符串列表
end;

//改变虚拟网卡
procedure TRasDialerForm.EntryNameComboBoxChange(Sender: TObject);
begin
  GetUserNameList;
  GetUserPassword;
end;

//改变用户名
procedure TRasDialerForm.UserNameComboBoxChange(Sender: TObject);
begin
  GetUserPassword;                                      //读取用户密码
end;

//修改指定拨号连接的属性
procedure TRasDialerForm.DoProperties;
var
  dwRet:DWORD;
  Buf:Array [0..127] of char;
begin
//如果用户需要修改拨号连接的属性如电话号码、国家及区号、连接方式、服务器类型等，可以用RasAPI函数来实现，
//其函数名为RasEditPhonebookEntryA
//参数：hwnd（THandle）：新建拨号连接窗口的父窗口的句柄，可以为TForm的Handle，为NIL表示 Windows桌面(DeskTop)
//  　　lpszPhonebook（pchar）：电话本名称,在Win9X下无作用,可设为空字符串
//      lpszEntryName:（ pchar）：要修改的拨号连接的名称，如’163’、’169’等
//函数返回值：0表示执行成功；否则为错误．
  dwRet:=RasEditPhonebookEntryA(Handle, nil, PChar(EntryNameComboBox.Text));
  if dwRet<>0 then
  begin
    RasGetErrorStringA(dwRet, @Buf[0], SizeOf(Buf));    //获取错误信息：错误标识符、错误提示信息的缓冲区、错误提示信息的缓冲区大小
    LogMessage(Buf);                                    //显示错误信息
  end;
end;

//新建拨号连接
procedure TRasDialerForm.DoNew;
var
  EntryName:String;
  dwRet:DWORD;
  Buf:Array [0..127] of char;
begin
//当WIN9X系统中已经建立了拨号连接，则可利用现成的拨号连接。如果没有拨号连接，则需要新建一个拨号连接。
//RasAPI中提供了相应的函数，其函数名为RasCreatePhonebookEntryA
//参数：hwnd（THandle）：新建拨号连接窗口的父窗口的句柄，可以为TForm的Handle，为NIL表；Windows桌面(DeskTop)
//　　　lpszPhonebook（pchar）：电话本名称,在Win9X下无作用,可设为空字符串
//函数返回值：0表示执行成功；否则为错误．
  dwRet:=RasCreatePhonebookEntryA(Handle, nil);
  if dwRet<>0 then
  begin
    RasGetErrorStringA(dwRet, @Buf[0], SizeOf(Buf));    //错误标识符、错误提示信息的缓冲区、错误提示信息的缓冲区大小
    LogMessage(Buf);                                    //显示错误信息
  end
  else
  begin
    EntryName:=EntryNameCombobox.Text;                  //连接设备
    LoadPhoneBook;                                      //获取PPPOE虚拟网卡
    SelectPhoneBookEntry(EntryName);                    //连接设备
  end;
end;

//退出
procedure TRasDialerForm.MnuQuitClick(Sender: TObject);
begin
  RasDialerForm.Close;
end;

//修改连接属性
procedure TRasDialerForm.MnuPropertiesClick(Sender: TObject);
begin
  DoProperties;         //设置属性
end;

//新建连接属性
procedure TRasDialerForm.MnuNewClick(Sender: TObject);
begin
  DoNew;
end;

//修改配置信息
procedure TRasDialerForm.DoConfigure;
begin
  ConfigureAutoForm.Configure;
end;

//读取IP
procedure TRasDialerForm.IPButtonClick(Sender: TObject);
var
  IPAddr:String;
begin
  IPAddr:=RasGetIPAddress;
  if IPAddr>'' then
    InfoListBox.Items.Add('IP='+IPAddr)
  else
    InfoListBox.Items.Add('未知IP');
end;

//连接宽带服务器
procedure TRasDialerForm.ClientSocket1Connect(Sender: TObject; Socket: TCustomWinSocket);
var
  s,ss,Zh:string;
begin
  inherited;
  LinkFun:=1;
  NB:=NB+1;
//  StatusBar1.SimpleText := 'Client Connected to '+Socket.RemoteHost;

  ConOK:=true;
{
  s:=UserNameComboBox.Text;                             //用户帐号
//  s:='9912345678';
//  s:='917000376';

  try
    ClientSocket1.Socket.SendText(s);                   //申请缴费截止日期
    sOK:=true;                                          //提交申请标志
  except
  end;
}
end;

//断开宽带服务器
procedure TRasDialerForm.ClientSocket1Disconnect(Sender: TObject; Socket: TCustomWinSocket);
var
  i:integer;
begin
  inherited;
  NB:=0;
  i:=Socket.SocketHandle;
//  If StatusBar1 <> nil then
//    StatusBar1.SimpleText := 'Client Disconnected '+inttostr(i);
end;

//从宽带服务器读取信息
procedure TRasDialerForm.ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
begin
  inherited;
  rMsg:=Socket.ReceiveText;
  if sOK then
  begin
    rOK:=true;
  end;

  try
    if ClientSocket1.Active then
      ClientSocket1.Active:=false;
  except
  end;
end;

//连接宽带服务器错误
procedure TRasDialerForm.ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
var
  i:integer;
begin
  inherited;
  ErrorCode:=0;                                         //禁止显示错误信息
  for i:=0 to NB-1 do
    Socket.Disconnect(i);                               //断开服务器连接
  NB:=0;
//  ShowMessage('Server Connection Failed');
end;

//在状态区添加图标
function TRasDialerForm.AddIcon(hwnd: HWND): Boolean;
begin
  nid.cbSize := sizeof(NOTIFYICONDATA);
  nid.Wnd := hwnd;
  nid.uID := ID_MAIN;
  nid.uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;
  nid.uCallbackMessage := WM_WZGLNOTIFY;
//  nid.hIcon := LoadIcon(hInstance, 'MAINICON');
  nid.hIcon := LoadIcon(hInstance, PChar(RasIcon));
  strCopy(nid.szTip, strNotifyTip);
  AddIcon := Shell_NotifyIcon(NIM_ADD, @nid);
end;

//从状态区移去图标
function TRasDialerForm.RemoveIcon(hwnd: HWND): Boolean;
var
  nid: NOTIFYICONDATA;
begin
  nid.cbSize := sizeof(NOTIFYICONDATA);
  nid.Wnd := hwnd;
  nid.uID := ID_MAIN;
  nid.uFlags := 0;
  RemoveIcon := Shell_NotifyIcon(NIM_DELETE, @nid);
end;

//自定义消息处理函数 （快捷菜单弹出定位方法）
procedure TRasDialerForm.Notify(var Msg: TMessage);
var
  Pt: TPoint;
begin
  case msg.LParam of
    WM_RBUTTONDOWN:                             //当点击右键时,弹出快捷菜单
    begin
      SetForeGroundWindow(nid.wnd);
      GetCursorPos(Pt);
      Popupmenu.Popup(pt.x, pt.y);
    end;
    WM_LBUTTONDBLCLK:
    begin
//      RemoveIcon(handle);
      SetForeGroundWindow(nid.Wnd);
      ShowWindow(application.Handle,SW_SHOWNORMAL);
    end;
  end;
end;

//定义最小化过程，赋给Application.OnMinimize;
procedure TRasDialerForm.minimize(sender: Tobject);
begin
//  AddIcon(handle);
  ShowWindow(Application.handle, sw_hide)
end;

//取消程序窗口
procedure TRasDialerForm.FormDestroy(Sender: TObject);
begin
  inherited;
  RemoveIcon(handle);
end;

//新建程序窗口
procedure TRasDialerForm.FormCreate(Sender: TObject);
begin
  inherited;
  CheckTimer.Enabled:=FALSE;                            //关闭定时器
  application.OnMinimize:=minimize;
  ks:=0;                                                //重新连接时间计数器
  kt:=0;                                                //重新连接次数计数器

  kz:=0;                                                //TCP申请控制标志
  GetDir(0,SPath);                                      //获取当前目录名,0-当前驱动器,1-A,2-B,3-C...
  SPath:=SPath+'\';                                     //系统安装目录
  Up:='0';                                              //系统升级标志
  Inst:=false;                                          //pppoe网卡安装标志

  Application.ProcessMessages;

  CtrlN1.Enabled:=true;
  CtrlN2.Enabled:=true;
  CtrlD1.Enabled:=false;
  CtrlD2.Enabled:=false;

  //默认服务器地址：Edit2.Text = 222.41.161.40     西安 Dslam IO 服务器
  case iTest of
    0:                                                  //正常
    begin
      Edit1.Visible:=false;                             //测试用帐号
      Edit2.Visible:=false;                             //测试用服务器IP
      Button1.Visible:=false;                           //测试按键
    end;
    1:                                                  //显示用户名、测试按键
    begin
      Edit1.Visible:=true;
      Edit2.Visible:=false;
      Button1.Visible:=true;
    end;
    2:                                                  //显示服务器、用户名、测试按键
    begin
      Edit1.Visible:=true;
      Edit2.Visible:=true;
      Button1.Visible:=true;
    end;
  end;

  RasIcon:='RasIcon2';
  AddIcon(handle);
  ShowWindow(Application.handle, SW_SHOWNORMAL);

//  Image2.Picture.Bitmap.Handle:=LoadBitmap(hInstance, 'RasIcon2');
  Image2.Picture.Bitmap.LoadFromResourceName(hInstance, 'RasIcon2');
  StatusBar1.Panels.Items[0].text:='';
end;

//显示程序窗口按键
procedure TRasDialerForm.N11Click(Sender: TObject);
begin
  inherited;
//  RemoveIcon(handle);
  SetForeGroundWindow(nid.Wnd);
  ShowWindow(application.Handle,SW_SHOWNORMAL);
end;

//关闭程序
procedure TRasDialerForm.N6Click(Sender: TObject);
begin
  inherited;
  RasDialerForm.Close;
end;

//拨号按键
procedure TRasDialerForm.ConnectBtnClick(Sender: TObject);
begin
  inherited;
  ks:=0;                                                //
  kt:=0;                                                //
  DoConnect;
end;

//断开拨号按键
procedure TRasDialerForm.CancelBtnClick(Sender: TObject);
begin
  inherited;
  DoCancel;
end;

//修改配置按键
procedure TRasDialerForm.ConfigBtnClick(Sender: TObject);
begin
  inherited;
  DoConfigure;
end;

//显示关于按键
procedure TRasDialerForm.AboutBtnClick(Sender: TObject);
begin
  inherited;
  AboutForm.ShowModal;
//  RasDialerForm.Close;
// RemoveIcon(handle);
// application.Terminate;
end;

//系统测试按键
procedure TRasDialerForm.Button1Click(Sender: TObject);
var
  i:integer;
  s:string;
begin
  inherited;
  ReadTcp();
end;

//从宽带服务器提取用户信息
//注意：用户名必须规范，否则无法从用户名中提取地市代码
procedure TRasDialerForm.ReadTcp();
var
  i:integer;
  s:string;
begin
  if kz>0 then
  begin
    kz:=0;
//    exit;
  end;  
  if hRasConn>0 then                                    //若连接
  begin
    ClientSocket1.Port:=StrToInt('7999');               //端口
//  ClientSocket1.Address:='127.0.0.1';
    ClientSocket1.Address:='222.41.161.40';             //西安Dslam服务器IP
//  ClientSocket1.Address:='10.72.0.236';               //西安宽带服务器IP
//  ClientSocket1.Address:='222.41.136.106';            //新疆宽带服务器IP
    ClientSocket1.ClientType:=ctNonBlocking;            //连接方式：阻塞
//  ClientSocket1.ClientType:=ctBlocking;

    ClientSocket1.Address:=Edit2.Text;

    if ClientSocket1.Active then
      ClientSocket1.Active:=false;
    try
      ClientSocket1.Active:=true;
    except
    end;
    Application.ProcessMessages;
  end;
end;

//系统自动更新
procedure TRasDialerForm.FileUpData();
var
  b:boolean;
  TSI : TStartupInfo;
  TPI : TProcessInformation;
  tempFile: String;
begin
  try
    if hRasConn=0 then                                   //RAS未连接
    begin
      exit;
    end;

    tempFile:='SUpData.exe';                            //系统升级安装文件的名称
    Application.ProcessMessages;                        //让其他控件能获取消息
    if iTest>11 then                                     //测试
    begin
      b:=DownloadFile('\\127.0.0.1\UpData\'+tempFile, SPath+tempFile);
    end
    else
    begin
      b:=DownloadFile('\\'+Edit3.Text+'\UpData\'+tempFile, SPath+tempFile);
    end;

    Application.ProcessMessages;                        //让其他控件能获取消息
    if not b then                                       //若下载失败
    begin
      Up:='0';                                          //系统升级标志，出错后置为0
      messagebeep(0);
//      showmessage('             升级失败！           ');
//      Application.Terminate;
//      exit;
    end
    else
    begin

      //运行升级程序时，升级程序应与原主程序this.exe在同一目录下。如果当它启动时，这个版本主程序应该退出，但要保证它不会删除任何文件，因为此时Application.Initialize还没有被调用。代码如下：
      FillChar(TSI, SizeOf(TSI), 0);                    //在TSI中填充0
      TSI.CB:=SizeOf(TSI);

      //打开并运行升级程序
      if CreateProcess (PChar(SPath+tempFile), nil, nil, nil, False, DETACHED_PROCESS, nil, nil, TSI, TPI) then
      begin
        Application.Terminate;                          //正常
      end
      else     //但是，如果“升级程序”由于某些原因没有运行，我们此时应该告诉用户，他能通过其他方法得到一个更新的程序版本，这时我们依然退出主程序以便用户升级。如果必要的话，也可以继续装入并运行旧版本。
      begin
        Up:='0';                                        //系统升级标志，出错后置为0
        messagebeep(0);
//      showmessage('          不能完成系统升级！请与维护部门联系           ');
//      Application.Terminate;
      end;
    end;
  except                                                //连接数据库
    Up:='0';                                            //系统升级标志，出错后置为0
    messagebeep(0);
//    showmessage('          不能完成系统升级！请与维护部门联系           ');
//    Application.Terminate;
  end;
end;

//下载新程序
function TRasDialerForm.DownloadFile(Source, Dest: string): Boolean;
begin
  Application.ProcessMessages;                          //让其他控件能获取消息
  try
    Result := UrlDownloadToFile(nil, PChar(source), PChar(Dest), 0, nil) = 0;
  except
    Result := False;
  end;
end;

//运行超级连接
procedure TRasDialerForm.URLLabel1Click(Sender: TObject);
begin
  inherited;
  OpenURL(URLLabel1.Caption, True);
end;

//安装pppoe驱动程序
procedure TRasDialerForm.PPPOEInstall();
var
  TSI : TStartupInfo;
  TPI : TProcessInformation;
  ss,tempFile: String;
begin
//  if Inst then exit;                                    //防止重新进入
//  CheckTimer.Enabled:=FALSE;                            //关闭定时器
  try
    tempFile:='PPPoE_Setup.EXE';                        //pppoe安装文件的名称
    if not FileExists(SPath+tempFile) then
    begin
      showmessage('          您的系统程序已经发生变化，请重新运行安装程序，谢谢。          ');
      Application.Terminate;
      exit;
    end;

    ss:='    您的计算机尚未安装PPPOE网卡驱动程序，是否现在安装？    ';
    if messagedlg(ss,mtwarning,[mbyes,mbno],0)=mrno then
    begin
      showmessage('          安装PPPOE网卡驱动程序之后拨号服务才能启用，谢谢。           ');
      Application.Terminate;
      exit;
    end;

    Application.ProcessMessages;

    //打开并运行PPPOE网卡安装程序
    FillChar(TSI, SizeOf(TSI), 0);                      //在TSI中填充0
    TSI.CB:=SizeOf(TSI);
    CreateProcess (PChar(SPath+tempFile), nil, nil, nil, False, DETACHED_PROCESS, nil, nil, TSI, TPI);
  except
  end;
  Application.Terminate;
//  Inst:=true;                                           //pppoe网卡安装标志
//  CheckTimer.Enabled:=true;                             //打开定时器
end;

end.


