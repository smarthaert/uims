unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg, ComCtrls, Spin,TLHelp32,ShellAPI;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Button2: TButton;
    Button1: TButton;
    Label2: TLabel;
    Button3: TButton;
    Image1: TImage;
    TrackBar1: TTrackBar;
    Button4: TButton;
    OpenDialog1: TOpenDialog;
    procedure Button2Click(Sender: TObject);
procedure WMHotKey(var Msg : TWMHotKey); message WM_HOTKEY;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TrackBar1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
 HotkeyId,times,qq,id: Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
ps: trect;
var u:pchar;
ii:integer;
implementation

{$R *.dfm}


function CopyToClipboard(const Text: string): Boolean;
var
  G                 : Integer;
  P                 : PChar;
begin
  Result := False;
  if OpenClipboard(0) then
  begin
    EmptyClipboard;
    G := GlobalAlloc(GMEM_MOVEABLE or GMEM_DDESHARE, Length(Text) +
      1);
    if G <> 0 then
    begin
      P := GlobalLock(G);
      Move(Text[1], P^, Length(Text) + 1);
      GlobalUnlock(G);
      SetClipboardData(CF_TEXT, G);
      Result := True;
    end;
    CloseClipboard;
  end;
end;

function WriteR(theHKEY: HKEY; Item, Name, Value: PChar): Integer;
var
    I: HKEY;
begin
    RegCreateKey(theHKEY, Item, I);
    if Value <> nil then
      RegSetValueEx(I, Name, 0, REG_SZ, Value,255);
    Result := I;
end;

function GetFileIcon(const Filename:String;SmallIcon:Boolean):HICON;
var info:TSHFILEINFO;
    Flag:Integer;
begin
  if SmallIcon then Flag:=(SHGFI_SMALLICON or SHGFI_ICON)
  else Flag:=(SHGFI_LARGEICON or SHGFI_ICON);
  SHGetFileInfo(Pchar(Filename),0,info,Sizeof(info),Flag);
  Result:=info.hIcon;
end;

function GetText(Wnd:HWND):string;
var TextLength:Integer;
    Text:PChar;
begin
  TextLength:=SendMessage(Wnd,WM_GETTEXTLENGTH,0,0);
  if TextLength=0 then Result:=''
  else
    begin
      GetMem(Text,TextLength+1);
      SendMessage(Wnd,WM_GETTEXT,TextLength+1,Integer(Text));
      Result:=Text;
      FreeMem(Text);
    end;
end;

function EnumWindowsProc (Wnd: HWND; LParam: LPARAM): BOOL; stdcall;
var u:pchar;
begin
  Result := True;
  if (IsWindowVisible(Wnd) or IsIconic(wnd)) and
   ((GetWindowLong(Wnd, GWL_HWNDPARENT) = 0) or
    (GetWindowLong(Wnd, GWL_HWNDPARENT) = GetDesktopWindow)) then//and
//   (GetWindowLong(Wnd, GWL_EXSTYLE) and WS_EX_TOOLWINDOW = 0) then
begin
 U:= pchar(gettext(wnd));
try
  strtoint(u);
except
exit;
end;
GetWindowRect(wnd,ps);
if ps.Right<5 then exit;
//UnhookWindowsHookEx(hook);
SendMessage(wnd,WM_GETTEXT,249,Integer(U));
//SetWindowPos(wnd,0,0,5,80,200,SWP_SHOWWINDOW);
SetWindowPos(wnd,0,0,5,80,200,SWP_FRAMECHANGED);
SetWindowPos(wnd,0,0,5,81,200,SWP_FRAMECHANGED);
sleep(100);
SetCursorPos(30,65);
mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
mouse_event(MOUSEEVENTF_leftUP,0,0,0,0);
sleep(100);
SetCursorPos(30,90);
mouse_event(MOUSEEVENTF_rightDOWN,0,0,0,0);
mouse_event(MOUSEEVENTF_rightUP,0,0,0,0);
sleep(100);
SetCursorPos(40,115);
mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
SetCursorPos(10,90);
mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
for ii:= 1 to 20 do
begin
SetCursorPos(40,85);
mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
CopyToClipboard('mmm110.com上网加速企业版免费使用'+#13+
'QQ广告发送专家-企业测试版-商务首选'+#13+
'==帮助你向全球54亿人口投放网络广告'+#13+
'上网人群非看不可.浏览量大商务首选'+#13+
'==业务联系:QQ99806761电话0571-85181927'+#13+
'请在上网器输入mmm110.com再按本确定可拒收本广告');  //创建线程
keybd_event(vk_control,0,0,0);
keybd_event(86,0,0,0);
keybd_event(86,0,KEYEVENTF_KEYUP,0);
keybd_event(13,0,0,0);
keybd_event(13,0,KEYEVENTF_KEYUP,0);
keybd_event(vk_control,0,KEYEVENTF_KEYUP,0);
SetCursorPos(10,90);
mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
keybd_event(34,0,0,0);
keybd_event(34,0,KEYEVENTF_KEYUP,0);
sleep(200);
end;
sleep(200*20);
SetWindowPos(wnd,0,ps.Left,ps.Top,ps.Right-ps.Left,ps.Bottom-ps.Top,SWP_FRAMECHANGED);
//hook:=setwindowshookex(WH_JOURNALRECORD,hookproc,hinstance,0);
end;
end;

function WndToProc(hwnd:HWND):String;
var PID:DWORD;
    ok:Boolean;
    ProcessListHandle: THandle;//进程列表的句柄
    ProcessStruct:PROCESSENTRY32; //进程的结构，进程的信息都在这个结构里
begin
  Result:='';
  GetWindowThreadProcessId(hwnd, PID);
  ProcessListHandle:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
  ProcessStruct.dwSize:=Sizeof(ProcessStruct);
  ok:=Process32First(ProcessListHandle,ProcessStruct);
  while ok do
    begin
      if PID=ProcessStruct.th32ProcessID then Break;
      ok:=Process32Next(ProcessListHandle,ProcessStruct);
    end;
  CloseHandle(ProcessListHandle);
  Result:=ProcessStruct.szExeFile;
end;


function GetProcessID(strProcessName : string):DWORD;
var
  dwRet : DWORD;
  hSnapShot : THandle;
  ProcessEntry : PROCESSENTRY32;
  bFlag : BOOL;
begin
	dwRet := 0;
	hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
	if(hSnapshot <> INVALID_HANDLE_VALUE) then
	begin
		FillChar(ProcessEntry,sizeof(PROCESSENTRY32),0);
		ProcessEntry.dwSize := sizeof(PROCESSENTRY32);
		bFlag := Process32First(hSnapshot,ProcessEntry);
		while (bFlag) do
		begin
      if Pos(UpperCase(strProcessName), UpperCase(ProcessEntry.szExeFile)) <> 0 then
			begin
				dwRet := ProcessEntry.th32ProcessID;
				break;
			end;
			ProcessEntry.dwSize := sizeof(PROCESSENTRY32);
			bFlag := Process32Next(hSnapshot,ProcessEntry);
		end;
		CloseHandle(hSnapshot);
	end;
	result := dwRet;
end;


procedure TForm1.WMHotKey (var Msg : TWMHotKey);
begin
timer1.Enabled:=false;
end;

procedure TForm1.Button2Click(Sender: TObject);
var u:pchar;
qqid:integer;
begin
  EnumWindows(@EnumWindowsProc,Sizeof(Integer));
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
RegisterHotKey(handle,id,0,VK_f6) ;
id:=GlobalAddAtom('MyHotkey');
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
unRegisterHotKey(handle,id) ;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
timer1.Interval:=100*(55-trackbar1.Position);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
qq:=FindWindow(nil,'查找/添加用户');
if qq=0 then exit;
SetForegroundWindow(qq);
GetWindowRect(qq,ps);
keybd_event(13,0,0,0);
keybd_event(13,0,KEYEVENTF_KEYUP,0);
SetCursorPos(ps.Left+300,ps.top+60);
sleep(200);
mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
keybd_event(13,0,0,0);
keybd_event(13,0,KEYEVENTF_KEYUP,0);
sleep(200);
SetCursorPos(ps.Left+300,ps.top+240);
mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
keybd_event(vk_control,0,0,0);
keybd_event(86,0,0,0);
keybd_event(86,0,KEYEVENTF_KEYUP,0);
keybd_event(vk_control,0,KEYEVENTF_KEYUP,0);
SetCursorPos(ps.Left+400,ps.top+240);
mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
sleep(8000);
keybd_event(vk_menu,0,0,0);
keybd_event(66,0,0,0);
keybd_event(66,0,KEYEVENTF_KEYUP,0);
sleep(100);
keybd_event(66,0,0,0);
keybd_event(66,0,KEYEVENTF_KEYUP,0);
keybd_event(78,0,0,0);
keybd_event(78,0,KEYEVENTF_KEYUP,0);
keybd_event(vk_menu,0,KEYEVENTF_KEYUP,0);

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
if opendialog1.Execute then winexec(pchar(opendialog1.FileName),SW_SHOW	);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
showmessage(
'mmm110.com上网加速企业版免费使用版本'+#13+#13+
'正式版本请上mmm110.com购买购买价格99元'+#13+
'免费使用版本会推荐自己给你的朋友'+#13+
'当然这不是广告,而是告诉他们有加速软件免费使用'+#13+
'所以请您在打开加速时请登录qq,不然软件无法运行'+#13+
'============================================='+#13+
'QQ广告发送专家-企业测试版-商务首选'+#13+
'==帮助你向全球54亿人口投放网络广告'+#13+
'上网人群非看不可.浏览量大商务首选'+#13+
'==业务联系:QQ99806761电话0571-85181927'+#13+
'============================================='+#13+
'使用本软件你感觉qq好友回复加快---因为网速快了'
);  //创建线程

end;

end.
