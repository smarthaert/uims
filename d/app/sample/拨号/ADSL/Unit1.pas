unit Unit1;

interface
//Download by http://www.codefans.net
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DialUp, OleCtrls, ComCtrls, CnSpin,IniFiles, ExtCtrls,
  CnClasses, CnTrayIcon, IdBaseComponent, IdComponent, winsock;

type
  TFrm_main = class(TForm)
    DialUp1: TDialUp;
    lbl1: TLabel;
    lbl2: TLabel;
    edt_username: TEdit;
    edt_password: TEdit;
    btn_autoDial: TButton;
    cbb_dialname: TComboBox;
    lbl3: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    cnsedt_dialtime: TCnSpinEdit;
    Label2: TLabel;
    mmo_log: TMemo;
    chk_autoHideApp: TCheckBox;
    chk_TrayShowInfo: TCheckBox;
    btn_disAutoDial: TButton;
    chk_autoSaveLog: TCheckBox;
    Timer1: TTimer;
    CnTrayIcon1: TCnTrayIcon;
    btn_disConnect: TButton;
    TabSheet3: TTabSheet;
    lst_ip: TListBox;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btn_autoDialClick(Sender: TObject);
    procedure CnTrayIcon1DblClick(Sender: TObject);
    procedure btn_disConnectClick(Sender: TObject);
    procedure btn_disAutoDialClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    isFilterIP,isHideApp,isShowInfo,isSaveLog:Boolean;
    myIP:string;
    procedure SaveSysConfig;
  public
    { Public declarations }
  end;

var
  Frm_main: TFrm_main;

implementation

{$R *.dfm}
procedure Delay(MSecs: Extended);
//延时函数，MSecs单位为毫秒(千分之1秒)
var
  FirstTickCount, Now: Extended;
begin
  FirstTickCount := GetTickCount();
  repeat
    Application.ProcessMessages;
    Now := GetTickCount();
  until (Now - FirstTickCount >= MSecs) or (Now < FirstTickCount);
end;

//获取IP地址
function getLocalIP:string;   //获取本地机器IP地址 
type 
   TaPInAddr = array [0..10] of PInAddr; 
   PaPInAddr = ^TaPInAddr; 
var 
   phe  : PHostEnt; 
   pptr : PaPInAddr; 
   Buffer : array [0..63] of char; 
   I    : Integer; 
   GInitData      : TWSADATA; 

begin 
   WSAStartup($101, GInitData); 
   Result := ''; 
   GetHostName(Buffer, SizeOf(Buffer)); 
   phe :=GetHostByName(buffer); 
   if phe = nil then Exit; 
   pptr := PaPInAddr(Phe^.h_addr_list); 
   I := 0; 
   while pptr^[I] <> nil do 
   begin 
     result:=StrPas(inet_ntoa(pptr^[I]^)); 
     Inc(I); 
   end; 
   WSACleanup; 
end; 


procedure TFrm_main.FormCreate(Sender: TObject);
var filename:string;
    myinifile:TIniFile;
begin
    filename:=ExtractFilePath(paramstr(0))+'config.ini';
    myinifile:=Tinifile.Create(filename);
    //线路链接
    cbb_dialname.Items:=DialUp1.PossibleConnections;
    cbb_dialname.ItemIndex:=cbb_dialname.Items.IndexOf(Trim(myinifile.ReadString('SysConfig','dialname',''))) ;

    edt_username.Text:=Trim(myinifile.ReadString('SysConfig','username',''));
    edt_password.Text:=Trim(myinifile.ReadString('SysConfig','password',''));

    cnsedt_dialtime.Text:=Trim(myinifile.ReadString('DialConfig','AutoDialTime','5'));

    if Trim(myinifile.ReadString('DialConfig','IsFilterIP','0'))='1' then
    isFilterIP:=true
    else
    isFilterIP:=False;

    if Trim(myinifile.ReadString('DialConfig','IsHideApp','0'))='1' then
    isHideApp:=true
    else
    isHideApp:=False;

    if Trim(myinifile.ReadString('DialConfig','IsTrayShowInfo','0'))='1' then
    isShowInfo:=true
    else
    isShowInfo:=False;

    if Trim(myinifile.ReadString('DialConfig','IsAutoSaveLog','0'))='1' then
    isSaveLog:=true
    else
    isSaveLog:=False;

    chk_autoHideApp.Checked:=isHideApp;
    chk_TrayShowInfo.Checked:=isShowInfo;
    chk_autoSaveLog.Checked:=isSaveLog;

    myinifile.Free;

    mmo_log.Lines.LoadFromFile(ExtractFilePath(paramstr(0))+'log.txt');
    
end;

procedure TFrm_main.btn_autoDialClick(Sender: TObject);
begin
    Application.ProcessMessages;
    btn_autoDial.Enabled:=false;

    Timer1.Interval:=StrToInt(cnsedt_dialtime.Text)*60000;
    Timer1.Enabled:=true;
    if Trim(edt_username.Text)='' then
    begin
        Application.MessageBox('请输入拨号的用户名', '提示', MB_OK +
          MB_ICONINFORMATION);
        edt_username.SetFocus;
        exit;
    end;

    if Trim(edt_password.Text)='' then
    begin
        Application.MessageBox('请输入拨号的密码', '提示', MB_OK +
          MB_ICONINFORMATION);
        edt_password.SetFocus;
        exit;
    end;

    if Trim(cbb_dialname.Text)='' then
    begin
        Application.MessageBox('请选择连接线路', '提示', MB_OK +
          MB_ICONINFORMATION);
        cbb_dialname.SetFocus;
        exit;
    end;

    try
      DialUp1.Username:=Trim(edt_username.Text);
      DialUp1.Password:=Trim(edt_password.Text);
      DialUp1.ConnectTo:=Trim(cbb_dialname.Text);
      DialUp1.GoOffline;
      mmo_log.Lines.Add(FormatDateTime('yyyy-mm-dd hh:mm',Now)+'  断线成功');

      if DialUp1.GoOnline then
      begin

          if isHideApp then
          CnTrayIcon1.HideApplication;

          Delay(1*500);
          myIP:=getLocalIP;
          if isShowInfo then
          CnTrayIcon1.BalloonHint('提示','拨号成功!IP地址为:'+myIP,btInfo,1);

          mmo_log.Lines.Add(FormatDateTime('yyyy-mm-dd hh:mm',Now)+'  拨号成功');
          lst_ip.Items.Add(myIP);
          //模拟按钮Alt+R
{          keybd_event(VK_MENU, MapVirtualKey(VK_MENU, 0), 0, 0);
          keybd_event(ORD('R'), MapVirtualKey(ORD('R'), 0), 0, 0);
          keybd_event(VK_MENU, MapVirtualKey(VK_MENU, 0), KEYEVENTF_KEYUP, 0);
          keybd_event(ORD('R'), MapVirtualKey(ORD('R'), 0), KEYEVENTF_KEYUP, 0);
          Sleep(9000);
          keybd_event(VK_RETURN, MapVirtualKey(VK_RETURN, 0), 0, 0);
          keybd_event(VK_RETURN, MapVirtualKey(VK_RETURN, 0), KEYEVENTF_KEYUP, 0);
}          
      end;
    except
      Application.MessageBox('连接失败,请检查帐号密码和线路是否连接正确!',
        '提示', MB_OK + MB_ICONSTOP);        
    end;

    if isSaveLog then
    mmo_log.Lines.SaveToFile(ExtractFilePath(paramstr(0))+'log.txt');

end;

procedure TFrm_main.SaveSysConfig;
var filename:string;
    myinifile:TIniFile;
begin
     filename:=ExtractFilePath(paramstr(0))+'config.ini';
     myinifile:=Tinifile.Create(filename);
     //保存帐号信息
     myinifile.WriteString('SysConfig','username',Trim(edt_username.Text));
     myinifile.WriteString('SysConfig','password',Trim(edt_password.Text));
     myinifile.WriteString('SysConfig','dialname',Trim(cbb_dialname.Text));

     //保存基本设置
     myinifile.WriteString('DialConfig','AutoDialTime',Trim(cnsedt_dialtime.Text));


     if chk_autoHideApp.Checked then
     myinifile.WriteString('DialConfig','IsHideApp','1')
     else
     myinifile.WriteString('DialConfig','IsHideApp','0');

     if chk_TrayShowInfo.Checked then
     myinifile.WriteString('DialConfig','IsTrayShowInfo','1')
     else
     myinifile.WriteString('DialConfig','IsTrayShowInfo','0');

     if chk_autoSaveLog.Checked then
     myinifile.WriteString('DialConfig','IsAutoSaveLog','1')
     else
     myinifile.WriteString('DialConfig','IsAutoSaveLog','0');
     
     isHideApp:=chk_autoHideApp.Checked;
     isShowInfo:=chk_TrayShowInfo.Checked;

     myinifile.Free;
end;

procedure TFrm_main.CnTrayIcon1DblClick(Sender: TObject);
begin
    CnTrayIcon1.ShowApplication;
end;

procedure TFrm_main.btn_disConnectClick(Sender: TObject);
begin
    btn_autoDial.Enabled:=true;
    try
      DialUp1.GoOffline;
    except
    end; 
end;

procedure TFrm_main.btn_disAutoDialClick(Sender: TObject);
begin
    Timer1.Enabled:=False;
    btn_autoDial.Enabled:=true;
end;

procedure TFrm_main.Timer1Timer(Sender: TObject);
begin
    btn_autoDialClick(Self);
end;

procedure TFrm_main.Button1Click(Sender: TObject);
begin
    SaveSysConfig;
end;

procedure TFrm_main.Button2Click(Sender: TObject);
begin
    if Application.MessageBox('你确实要清空日志吗?',
      '提示', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
        mmo_log.Clear;
    end; 
end;

procedure TFrm_main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
mmo_log.Lines.SaveToFile(ExtractFilePath(paramstr(0))+'log.txt');
end;

end.
