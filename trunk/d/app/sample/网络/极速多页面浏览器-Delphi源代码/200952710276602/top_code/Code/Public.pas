unit Public;

interface

uses
  Windows, Messages,   //14KB 14KB
  SysUtils,  //24.5KB 38.5KB
  //Classes,   //46KB 84.5KB
  //Graphics,  //8KB 92.5KB   GetScreen
  ShellApi,  //0KB 92.5KB
  Registry,  //0.5KB 93KB
  IniFiles,  //0KB 93KB
  TlHelp32,  //0KB 93KB
  //ComObj,    //19KB 228KB   CreateLnk,CreateLnk2
  ShlObj,    //0KB 228KB   GetSystemFolderDir
  //ActiveX,   //0KB 228KB
  Wininet,  //
  psAPI,    // MeUseMem
  Graphics, JPEG,
  ComObj, //ActiveX, //2,creatLnk2
  UrlMon,    //0KB 93KB
  Forms,      MMSystem,  //0KB 93KB
  Winsock;  //GetIPAddress


//系统类  [2]-11
function GetWinDir:string;
function GetSysDir:string;
function GetTempDir:string;
function GetSystemFolderDir(mFolder:Integer):string;
function MeUseMem:string;
function GetDisplayFrequency:Integer;
//function ClearMemory:Boolean;
//function GetDateTime:PChar;
//function GetDateTime_1:string;
function GetDateTime2(i:integer):string;
function IsWin32:Boolean;
function GetOSInfo:PChar;
function AddMuter(Str:PChar):Boolean;
//function AddHotKey(FormHandle:HWND;Key:Integer):Boolean;
function ShutDown:Boolean;
//function ExitWindows(B:Byte):Boolean;
function GetScreenWH(WORH:PChar):string;
//function SetWallPaper(WallPaper:PChar;TileWallPaper,WallPaperStyle:Byte):Boolean;
//打开/关闭光驱
function OpenCDROM(B:Byte):Boolean;

//小系统类  [3]-12
//function CreateLnk(FileName,LnkName:PChar):Boolean;
function CreateLnk2(FileName,LnkName:PChar):Boolean;
function InstallIcon(IsTrue:Boolean;Handle:THandle;IconHandle:THandle;szTipStr:PChar):Boolean;
//function DriveType(Driver:PChar):Integer;

//综合类  [4]-13
function KillProcess(ProcessName:PChar):Boolean;
//function FindProcess(ExeFileName:PChar):Boolean;
//function CloseWindow(ClassName,WindowName:PChar):Boolean;
function GetProcessFilePath(ProcessName:PChar):PChar;
function GetDiskNumber:string;
function GetCPUID:LongInt;
function GetCPUSpeed:Double;
function DownloadFile(SourceFile,TargetFile:PChar):Boolean;
//关闭IE弹出广告窗口
//procedure ENumChildWindows(hand:HWND);
//procedure CloseIEPop;
//function HideDesktop(IsTrue:Boolean):Boolean;
//function HideTaskbar(IsTrue:Boolean):Boolean;
//function DeleteMe:Boolean;
function DeleteDirFile(Dir:string):Boolean;
function DeleteDir(Dir:string):Boolean;
//function DeleteFile2(Dir:string):Boolean;
//function DeleteDir2(Dir:string):Boolean;
function GetFileSize2(Filename: string):LongInt; //DWORD;
function GetIPAddress:string;
//function AppendText(FileName:PChar;Str:PChar):Boolean;
function JpgToBmp(SourceFileName,TargetFileName:PChar):Boolean;
function BmpToJpg(SourceFileName,TargetFileName:PChar):Boolean;

//ini
function ReadConfig(IniFileName,SectionName,ValueName:String):String;
function WriteConfig(IniFileName,SectionName,ValueName,Value:String;Flag:Word=0):Boolean;

//注册表类  [6]-12
function ReadRegValue(RootKey:HKEY;OpenKey:PChar;KeyType:Integer;Key:PChar):string;
function SetRegValue(RootKey:HKEY;OpenKey:PChar;KeyType:Integer;Key,Value:PChar):Boolean;
function DeleteRegValue(RootKey:HKEY;OpenKey:PChar;Value:PChar):Boolean;
//function AutoRun(KeyValue:PChar;FileName:PChar):Boolean;
function LinkTxtType(FileName:PChar;IsTrue:Boolean):Boolean;
function LinkExeType(FileName:PChar;IsTrue:Boolean):Boolean;
//function CheckState(Key:PChar;Name:PChar;Value:Integer):Integer;
function LockReg(IsTrue:Boolean):Boolean;
function LockIE:Boolean;
function DefaultIE:Boolean;
function LockAll:Boolean;
function DefaultAll:Boolean;
function GetVersionInfo(var SProduct,SVersion,SServicePack:string):Boolean;
function UseProxy(const Proxy: string):Boolean;
function CheckProxy: Boolean;
function ChangeProxy(const Proxy: string):Boolean;
{
function EnableProxy:Boolean;
function DisableProxy:Boolean;
}
function NotProxy:Boolean;
procedure SetBrowser(AppExeName:string;flag:integer=0);  
//procedure UpdateReg(Str:string;Remove: Boolean);
//procedure Uninstall(Str:string);

//IE类
function DelRegCache:Boolean;
//function GetCookiesFolder:string;
function ShellDeleteFile(sFileName: string):Boolean;
function DelCookie:Boolean;
function DelHistory:Boolean;
//function CreateIntShotCut(FileName,URL:PChar):Boolean;

//function KeyboardHookHandler(iCode:Integer;wParam:WPARAM;lParam:LPARAM):LRESULT;stdcall;
//function EnableHotKeyHook:Boolean;
//function DisableHotKeyHook:Boolean;


implementation

uses UnitMain, const_;

const AuthorInformation='login ChuJingChun QQ:3249136 CHINA 2004-2008';

var
  PPChar:PChar;

  hNextHookProc:HHook;
  procSaveExit:Pointer;

//系统类
//获得Windows目录
function GetWinDir:string;
var
  WinDir:string;
begin
try   
  SetLength(WinDir,128);
  GetWindowsDirectory(PChar(WinDir),128);
  SetLength(WinDir,StrLen(PChar(WinDir)));
  if WinDir[Length(WinDir)]<>'\' then WinDir:=WinDir+'\';
  Result:=WinDir;
  {
  GetMem(PPChar,200);
  StrpCopy(PPChar,WinDir);
  GetWinDir:=PPChar;
  FreeMem(PPChar);
  } 
except
  Result:='';
end;
end;

//获得系统目录
function GetSysDir:string;
var
  SysDir:string;
begin
try
  SetLength(SysDir,128);
  GetSystemDirectory(PChar(SysDir),128);
  SetLength(SysDir,Strlen(PChar(SysDir)));
  if SysDir[Length(SysDir)]<>'\' then SysDir:=SysDir+'\';
  Result:=SysDir;
  {
  GetMem(PPChar,200);
  StrpCopy(PPChar,SysDir);
  GetSysDir:=PPChar;
  FreeMem(PPChar);
  }
except
  Result:='';
end;
end;

//获得临时目录
function GetTempDir:string;
var
  pth:array [0..MAX_PATH] of Char;
  str:string;
begin
try
  GetTempPath(SIZEOF(pth),pth) ;
  str:=StrPas(pth) ;
  if str[Length(str)]<>'\' then str:=str+'\';
  Result:=str;
  {
  GetMem(PPChar,200);
  StrpCopy(PPChar,SysDir);
  GetSysDir:=PPChar;
  FreeMem(PPChar);
  }
except
  Result:='';
end;
end;

{
//向文本文件中追加数据
function AppendText(FileName:PChar;Str:PChar):Boolean;
var
  TxtFile:TextFile;
begin
try
  AssignFile(TxtFile,FileName);
  if FileExists(FileName)then Append(TxtFile)    //ReSet(TxtFile);
  else ReWrite(TxtFile);
  if Trim(Str)<>'' then WriteLn(TxtFile,Str);
  CloseFile(TxtFile);
  Result:=True;
except 
  Result:=False;
end;
end;
}

//{
//图形图像类
//JPG图片转BMP格式
//USES JPEG;
function JpgToBmp(SourceFileName,TargetFileName:PChar):Boolean;
var
  B:TBitmap;
  J:TJpegImage;
begin
try
  B:=TBitmap.Create;
  J:=TJpegImage.Create;
  try
  J.LoadFromFile(SourceFileName);
  B.Assign(J);
  TargetFileName:=PChar(ChangeFileExt(TargetFileName,'.bmp'));
  B.SaveToFile(TargetFileName);
  finally
  B.free;
  J.free;
  end;
  Result:=True;
except Result:=False; end;
end;

//BMP图片转JPG格式
//USES JPEG;
function BmpToJpg(SourceFileName,TargetFileName:PChar):Boolean;
var
  B:TBitmap;
  J:TJpegImage;
begin
try
  try
  B:=TBitmap.Create;
  J:=TJpegImage.Create;
  B.loadfromfile(SourceFileName);
  J.Assign(B);
  TargetFileName:=PChar(ChangeFileExt(TargetFileName,'.jpg'));
  J.SaveToFile(TargetFileName);
  finally
  B.free;
  J.free;
  end;
  Result:=True;
except Result:=False; end;
end;
//图形图像类结束
//}

function GetSystemFolderDir(mFolder:Integer):string;
{ 返回获取系统文件或系统目录}
{
 CSIDL_BITBUCKET 回收站
 CSIDL_DESKTOP          = $0000; 桌面
 CSIDL_INTERNET          = $0001;
 CSIDL_PROGRAMS          = $0002;  程序组 D:\Documents and Settings\Administrator\「开始」菜单\程序
 CSIDL_CONTROLS          = $0003;  控制面板
 CSIDL_PRINTERS          = $0004;  打印机
 CSIDL_PERSONAL          = $0005;  我的文档
 CSIDL_FAVORITES          = $0006;  收藏夹
 CSIDL_STARTUP          = $0007; 启动
 CSIDL_RECENT          = $0008;  最近文档
 CSIDL_SENDTO          = $0009;  发送到
 CSIDL_BITBUCKET          = $000a; 回收站
 CSIDL_STARTMENU          = $000b; 开始菜单
 CSIDL_DESKTOPDIRECTORY          = $0010; 桌面目录
 CSIDL_DRIVES          = $0011; 我的电脑
 CSIDL_NETWORK          = $0012;  网上邻居
 CSIDL_NETHOOD          = $0013;  网上邻居目录
 CSIDL_FONTS          = $0014;  字体
 CSIDL_TEMPLATES          = $0015; //模版
 CSIDL_COMMON_STARTMENU          = $0016;  //公用的开始菜单
 CSIDL_COMMON_PROGRAMS          = $0017;
 CSIDL_COMMON_STARTUP          = $0018;
 CSIDL_COMMON_DESKTOPDIRECTORY       = $0019;
 CSIDL_APPDATA          = $001a; //D:\Documents and Settings\Administrator\Application Data
 CSIDL_PRINTHOOD          = $001b; //D:\Documents and Settings\Administrator\PrintHood
 CSIDL_ALTSTARTUP          = $001d;         // DBCS
 CSIDL_COMMON_ALTSTARTUP         = $001e;         // DBCS
 CSIDL_COMMON_FAVORITES          = $001f;
 CSIDL_INTERNET_CACHE          = $0020;  D:\Documents and Settings\Administrator\Local Settings\Temporary Internet Files
 CSIDL_COOKIES          = $0021;   Cook文件夹
 CSIDL_HISTORY          = $0022;   历史文件夹
 CSIDL_COMMON_APPDATA          = $0023;
          = $0024;   D:\WINNT
          = $0025;   D:\WINNT\system32
          = $0026    D:\Program Files
          = $0027    D:\Documents and Settings\Administrator\My Documents\My Pictures
          = $0028    D:\Documents and Settings\Administrator
          = $0029    D:\WINNT\system32
}
var
  vItemIDList: PItemIDList;
  vBuffer: array[0..MAX_PATH] of Char;
begin
try
  SHGetSpecialFolderLocation(0, mFolder,vItemIDList);
  SHGetPathFromIDList(vItemIDList,vBuffer); //转换成文件系统的路径
  Result:=vBuffer;
except end;
end;

function MeUseMem:String;
var
  pmc:PPROCESS_MEMORY_COUNTERS;
  cb:Integer;
begin
try
  cb:=SizeOf(_PROCESS_MEMORY_COUNTERS);
  GetMem(pmc,cb);
  pmc^.cb := cb;
  if GetProcessMemoryInfo(GetCurrentProcess(),pmc,cb) then
    Result:=(IntToStr(pmc^.WorkingSetSize div (1024))+'KB')
  else
    Result:='';
  FreeMem(pmc);
except end;
end;

function GetDisplayFrequency:Integer;
var
 DeviceMode:TDeviceMode;
//这个函数返回的显示刷新率是以Hz为单位的
begin
try
 EnumDisplaySettings(nil,Cardinal(-1),DeviceMode);
 Result:=DeviceMode.dmDisplayFrequency;
except end;
end;

{
function ClearMemory:Boolean;
begin
try
  if Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    SetProcessWorkingSetSize(GetCurrentProcess,$FFFFFFFF,$FFFFFFFF);
    Application.ProcessMessages;
  end;
  Result:=true;
except end;
end;
}

{
//获得当前日期时间
function GetDateTime:PChar;
var
  ST:TSystemTime;
  S:String;
  YY,YM,YD,TH,TM,TS:String;
begin
try
  GetLocalTime(st);
  YY:=IntToStr(st.wYear);
  YM:=IntToStr(st.wMonth);
  YD:=IntToStr(st.wDay);
  TH:=IntToStr(st.wHour);
  TM:=IntToStr(st.wMinute);
  TS:=IntToStr(st.wSecond);
  If Length(YM)=1 then YM:='0'+YM; 
  If Length(YD)=1 then YD:='0'+YD;
  If Length(TH)=1 then TH:='0'+TH;
  If Length(TM)=1 then TM:='0'+TM;
  If Length(TS)=1 then TS:='0'+TS;
  //S:=Format('%2d-%2d-%2d   %2d:%2d:%2d',[st.wYear,st.wMonth,st.wDay,st.wHour,st.wMinute,st.wSecond]);
  S:=YY+'-'+YM+'-'+YD+' '+TH+':'+TM+':'+TS;
  Result:=PChar(S);
except
  Result:='';
end;
end;
}

{
function GetDateTime_1:string;
var
  ST:TSystemTime;
  S:String;
  YY,YM,YD,TH,TM:String;
begin
try
  GetLocalTime(st);
  YY:=IntToStr(st.wYear);
  YM:=IntToStr(st.wMonth);
  YD:=IntToStr(st.wDay);
  TH:=IntToStr(st.wHour);
  TM:=IntToStr(st.wMinute);
  If Length(YM)=1 then YM:='0'+YM;
  If Length(YD)=1 then YD:='0'+YD;
  If Length(TH)=1 then TH:='0'+TH;
  If Length(TM)=1 then TM:='0'+TM;
  //S:=Format('%2d-%2d-%2d   %2d:%2d:%2d',[st.wYear,st.wMonth,st.wDay,st.wHour,st.wMinute,st.wSecond]);
  S:=YY+'-'+YM+'-'+YD+' '+TH+':'+TM;
  Result:=S;
except
  Result:='';
end;
end;
}

//获得当前日期时间2
function GetDateTime2(i:integer):string;
var
  ST:TSystemTime;
  S:String;
  YY,YM,YD,TH,TM,TS:String;
begin
try
  GetLocalTime(st);
  YY:=IntToStr(st.wYear);
  YM:=IntToStr(st.wMonth);
  YD:=IntToStr(st.wDay);
  TH:=IntToStr(st.wHour);
  TM:=IntToStr(st.wMinute);
  TS:=IntToStr(st.wSecond);
  if Length(YM)=1 then YM:='0'+YM;
  if Length(YD)=1 then YD:='0'+YD;
  if Length(TH)=1 then TH:='0'+TH;
  if Length(TM)=1 then TM:='0'+TM;
  if Length(TS)=1 then TS:='0'+TS;
  case i of
  1:Result:=YY;
  2:Result:=YM;
  3:Result:=YD;
  4:Result:=TH;
  5:Result:=TM;
  6:Result:=TS;
  else Result:='';
  end;
  //S:=Format('%2d-%2d-%2d   %2d:%2d:%2d',[st.wYear,st.wMonth,st.wDay,st.wHour,st.wMinute,st.wSecond]);
  //S:=YY+'-'+YM+'-'+YD+' '+TH+':'+TM+':'+TS;
  //Result:=PChar(S);
except
  Result:='';
end;
end;

//判断系统是否为WIN32
function ISWin32:Boolean;
begin
try
  {$IFDEF WIN32}
    Result:=True;
  {$ELSE}
    Result:=False;
  {$ENDIF}
except end;
end;

//获得系统信息，判断是WINNI还是WINDOWS。
function GetOsInfo:PChar;
//var
 //Osinfo:OsVersionInfo;
begin
try
  //OsInfo.dwOSVersionInfoSize:=SizeOf(OsVersionInfo);
  //GetVersionEx(OsInfo);
  //if OsInfo.DWPlatFormID=VER_PLATFORM_WIN32_NT then
  if Win32Platform=VER_PLATFORM_WIN32_NT then Result:='WINNT'
  else Result:='WINDOWS';
except
  Result:='';
end;
end;

//增加互斥
function AddMuter(Str:PChar):Boolean;
var
  HMutex:THandle;
  Errno:Integer;
begin         
try
  if Trim(Str)='' then
    HMutex:=CreateMutex(nil,False,PChar(AuthorInformation))
  else
    HMutex:=CreateMutex(nil,False,PChar(Str));
  Errno:=GetLastError;
  ReleaseMutex(HMutex);
  if Errno=ERROR_ALREADY_EXISTS then Result:=False
  else Result:=True;
except
  Result:=False;
end;
end;

{
//向系统中增加热键
function AddHotKey(FormHandle:HWND;Key:Integer):Boolean;
var
  ID:Integer;
begin
try
  ID:=GlobalAddAtom('HotKey');
  if RegisterHotKey(FormHandle,ID,Mod_Control,Key) then
  Result:=True
  else
  Result:=False;
except
  Result:=False;
end;
{
  id:=GlobalAddAtom('hotkey');
  RegisterHotKey(handle,id,0,VK_F3); //MOD_ALT // ALT 键必须按下
                                      //MOD_CONTROL // CTRL 键必须按下
                                      //MOD_SHIFT // SHIFT 键必须按下
function HotKey(var Msg:TMessage); Message WM_HOTKEY;
function HotKey(var Msg:TMessage):Boolean;
var
  Key:integer;
begin
  try
    if (Msg.LParamLo=MOD_CONTROL) and (Msg.LParamHi=key) then
    begin
      if hide then show
      else hide;
      result:=true;
    end;
  except
    result:=false;
  exit;
end;
}
//end;


//关机
function ShutDown:Boolean;
const se_shutdown_name='seshutdownprivilege';
var
  ReturnLength:DWord;
  HToken:THandle;
  NewState,PreviousState:TTokenPrivileges;
begin
try
  if Win32Platform=VER_PLATFORM_WIN32_NT then
  begin
    ReturnLength:=0;
    OpenProcessToken(GetCurrentProcess(),TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,HToken);
    LookupPrivilegeValue(nil,SE_SHUTDOWN_NAME,NewState.Privileges[0].Luid);
    NewState.PrivilegeCount:=1;
    NewState.Privileges[0].Attributes:=SE_PRIVILEGE_ENABLED;
    AdjustTokenPrivileges(HToken,False,NewState,SizeOf(TTokenPrivileges),PreviousState,ReturnLength);
    ExitWindowsEx(EWX_POWEROFF,0);
  end
  else
    ExitWindowsEx(1,0);
    Result:=True;
except
  Result:=False;
end;
end;

{
//退出WINDOWS
function ExitWindows(B:Byte):Boolean;
const se_shutdown_name='seshutdownprivilege';
var
  returnlength:dword;
  htoken:thandle;
  newstate,previousstate:ttokenprivileges;
begin
try
  if Win32Platform=VER_PLATFORM_WIN32_NT then
  begin
    ReturnLength:=0;
    OpenProcessToken(GetCurrentProcess(),TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,HToken);
    LookupPrivilegeValue(nil,SE_SHUTDOWN_NAME,NewState.Privileges[0].Luid);
    NewState.PrivilegeCount:=1;
    NewState.Privileges[0].Attributes:=SE_PRIVILEGE_ENABLED;
    AdjustTokenPrivileges(HToken,False,NewState,SizeOf(TTokenPrivileges),PreviousState,ReturnLength);
    Case B of
      1:ExitWindowsEx(EWX_POWEROFF,0);
      2:ExitWindowsEx(2,0);
      3:ExitWindowsEx(3,0);
      4:ExitWindowsEx(4,0);
      5:ExitWindowsEx(5,0);
    end;
  end
  else
    Case B of
      1:ExitWindowsEx(1,0);
      2:ExitWindowsEx(2,0);
      3:ExitWindowsEx(3,0);
      4:ExitWindowsEx(4,0);
      5:ExitWindowsEx(5,0);
    end;
    Result:=True;
except
  Result:=False;
end;
end;
}

//显示器休眠
{
function Perform(Msg: Cardinal; WParam, LParam: Longint): Longint;
var
  Message: TMessage;
begin
  Message.Msg := Msg;
  Message.WParam := WParam;
  Message.LParam := LParam;
  Message.Result := 0;
  //if Self <> nil then WindowProc(Message);
  Result := Message.Result;
end;

function xsqxm:Boolean;stdcall;
begin
try
  Perform(WM_SYSCOMMAND, SC_MONITORPOWER, 1);
except end;
end;
}

//获得屏幕宽和高
function GetScreenWH(WORH:PChar):string;
begin
try
  //user Forms;
  //Result:=PChar((IntToStr(Screen.Width)+','+IntToStr(Screen.Height)));
  //exit;
  if Trim(WORH)='' then
  begin
    Result:=(IntToStr(GetSystemMetrics(SM_CXSCREEN))+'*'+IntToStr(GetSystemMetrics(SM_CYSCREEN)));
    exit;
  end;
  if UpperCase(Trim(WORH))='W' then
  Result:=(IntToStr(GetSystemMetrics(SM_CXSCREEN)))
  else
  if UpperCase(Trim(WORH))='H' then
  Result:=(IntToStr(GetSystemMetrics(SM_CYSCREEN)))
  else
  Result:='';
except
  Result:='';
end;
end;

{
//设置墙纸
function SetWallPaper(WallPaper:PChar;TileWallPaper,WallPaperStyle:Byte):Boolean;
var
  Reg: TRegistry;
  TPC:PChar;
begin
try
  TPC:=WallPaper;
  if not FileExists(WallPaper) then exit;
  if UpperCase(ExtractFileExt(WallPaper))<>'.BMP' then exit;

  //if UpperCase(ExtractFileExt(WallPaper))='.JPG' then
  //begin
    //JpgToBmp(WallPaper,'Temp.bmp');
    //TPC:='Temp.bmp';
  //end;

  // 设置墙纸的属性
  try
  Reg:=TRegistry.Create;
  if Reg.OpenKey('Control Panel\DeskTop', False) then
  begin
    Reg.WriteString('WallPaper',TPC); // 墙纸文件的路径″C:\A.BMP″
    Reg.WriteString('TileWallPaper',IntToStr(TileWallPaper)); // 平铺方式，TileWallPaper为1
    Reg.WriteString('WallPaperStyle',IntToStr(WallPaperStyle)); // 非拉伸方式，WallPaperStyle为0
  end;
  Reg.CloseKey;
  finally Reg.Free; end;
  //广播注册表改动的消息
  SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, nil, SPIF_SENDCHANGE);
  Result:=True;
except
  Result:=False;
end;
end;
//系统类结束
}

//打开/关闭光驱
function OpenCDROM(B:Byte):Boolean;
begin
try
  if B=0 then
    mciSendString('set cdaudio door closed wait',nil,0,0)
  else
    mciSendString('set cdaudio door open wait',nil,0,0);
  Result:=True;
except
  Result:=False;
end;
end;

{
//小系统类
//创建桌面快捷方式
//Uses ShlObj,ComObj,ActiveX;
function CreateLnk(FileName,LnkName:PChar):Boolean;
var
  tmpObject:IUnknown;
  tmpSLink:IShellLink;
  tmpPFile:IPersistFile;
  PIDL:PItemIDList;
  StartupDirectory:array [0..MAX_PATH] of Char;
  StartupFilename:String;
  LinkFilename:WideString;
  c1:THandle;
  Str:String;
begin
try
  //if LnkName[1]<>'\' then LnkName:='\'+LnkName;
  Str:=LnkName;
  if Str[1]<>'\' then Str:='\'+Str;
  LnkName:=PChar(Str);
  StartupFilename:=FileName;
  tmpObject := CreateComObject(CLSID_ShellLink);
  tmpSLink := tmpObject as IShellLink;
  tmpPFile := tmpObject as IPersistfile;
  tmpSLink.SetPath(pChar(StartupFilename));
  tmpSLink.SetWorkingDirectory(pChar(ExtractFilePath(StartupFilename)));
  SHGetSpecialFolderLocation(0,CSIDL_DESKTOPDIRECTORY,PIDL);
  SHGetPathFromIDList(PIDL,StartupDirectory);
  Str:=StartupDirectory+String(LnkName);
  LinkFilename:=Str;
  tmpPFile.Save(pWChar(LinkFilename),FALSE);
  c1:=windows.FindWindowEx(windows.FindWindowEx(windows.FindWindow('Progman','Program Manager'),0,'SHELLDLL_DefView',''),0,'SysListView32','');
  PostMessage(c1,WM_KEYDOWN,VK_F5,0);
  PostMessage(c1,WM_KEYUP,VK_F5,1 shl 31);
  Result:=True;
except Result:=False; end;
end;
}

//{
//创建桌面快捷方式2
//uses ComObj;
function CreateLnk2(FileName,LnkName:PChar):Boolean;
var
  ObjShortCut, ObjShell :Variant;
  StrDesk:String;
  Str:String;
begin
try
  Str:=LnkName;
  if Str[1]<>'\' then Str:='\'+Str;
  LnkName:=PChar(Str);
  ObjShell:= CreateOleObject('Wscript.Shell');
  StrDesk:= ObjShell.SpecialFolders.Item('Desktop');
  ObjShortCut:= ObjShell.CreateShortCut(StrDesk+LnkName);
  ObjShortCut.Targetpath:=String(FileName);
  ObjShortCut.Save;
  //ObjShell:=UnAssigned;
  //ObjShortCut:=UnAssigned;
except end;
end;
//}

//安装ICO到托盘  use ShellApi;
function InstallIcon(IsTrue:Boolean;Handle:THandle;IconHandle:THandle;szTipStr:PChar):Boolean;
var
  IconData:TNotifyIconData; //全局变量
begin
try
  IconData.cbSize:=SizeOf(IconData);
  IconData.Wnd:=Handle;
  IconData.uID:=1;
  IconData.uFlags:=NIF_ICON or NIF_MESSAGE or NIF_TIP;
  IconData.uCallBackMessage:=WM_USER+1;
  IconData.hIcon:=IconHandle;
  StrCopy(IconData.szTip,pchar(szTipStr));
  //IconData.szTip:=array(szTipStr);
  if IsTrue=True then
    Shell_NotifyIcon(NIM_ADD,@IconData)
  else
    Shell_NotifyIcon(NIM_Delete,@IconData);
  Result:=True;
except
  Result:=False;
end;
{
procedure IconClick(var Msg:TMessage);message WM_USER+1;
procedure TMainForm.IconClick(var Msg:TMessage);
begin
try
  If (Msg.LParam=WM_LBUTTONDOWN) or (Msg.LParam=WM_RBUTTONDOWN) then
  begin
    Self.visible:=not Self.visible;
  end;
  inherited;
except end;
end;
}
end;

{
//获得驱动器类别
function DriveType(Driver:PChar):Integer;
begin
try
  if Length(Driver)>3 then
  begin  //MessageBox(0,PChar(IntToStr(Length(Driver))),'',0);
    Result:=0;
    Exit;
  end;
  Result:=GetDriveType(PChar(UpperCase(Driver)));
except end;
end;
}

//综合类
//结束进程
function KillProcess(ProcessName:PChar):Boolean;
var
  ContinueLoop:BOOL;
  FSnapshotHandle:THandle;
  FProcessEntry32:TProcessEntry32;
  Path:String;
  ID:DWORD;
  hh:THandle;
  i:Integer;
begin
try
  i:=FindWindow(nil,PChar(ProcessName));
  if i<>0 then
    SendMessage(i,WM_CLOSE,0,0); //Sendmessage(i,$0010,0,0);
  FSnapshotHandle:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
  FProcessEntry32.dwSize:=SizeOf(FProcessEntry32);
  ContinueLoop:=Process32First(FSnapshotHandle,FProcessEntry32);
  while Integer(ContinueLoop)<>0 do
  begin
    if (((UpperCase(ExtractFileName(FProcessEntry32.szExeFile))=UpperCase(ProcessName))
    or (UpperCase(FProcessEntry32.szExeFile)=UpperCase(ProcessName))))  then
    begin //and (pos(UpperCase(path),UpperCase(FProcessEntry32.szExeFile))>1)
      Id:=FProcessEntry32.th32ProcessID;
      hh:=OpenProcess(PROCESS_ALL_ACCESS,True,Id);
      TerminateProcess(hh,0);
      Result:=True;
      Path:=FProcessEntry32.szExeFile;
      Break;
    end
    else Result:=False;
    ContinueLoop:=Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
except
  Result:=False;
end;
end;

{
//查找进程
function FindProcess(ExeFileName:PChar):Boolean;
var
  ContinueLoop:BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32:TProcessEntry32;
  path:string;
  ID:DWORD;
  hh:THandle;
begin
try
  FSnapshotHandle:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize:=SizeOf(FProcessEntry32);
  ContinueLoop:=Process32First(FSnapshotHandle, FProcessEntry32);
  while Integer(ContinueLoop)<>0 do
  begin
    if (((UpperCase(ExtractFileName(FProcessEntry32.szExeFile))=UpperCase(ExeFileName))
    or (UpperCase(FProcessEntry32.szExeFile)=UpperCase(ExeFileName))))  then
    begin //and (pos(UpperCase(path),UpperCase(FProcessEntry32.szExeFile))>1)
      Result:=True;
      path:=FProcessEntry32.szExeFile;
      break;
    end
    else Result:=False;
    ContinueLoop:=Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
except
  Result:=False;
end;
end;
}

{
//关闭窗口
function CloseWindow(ClassName,WindowName:PChar):Boolean;
var
  hwnd:longword;
begin
try
  if ClassName<>'' then
  begin
    hwnd:=FindWindow(PChar(ClassName),nil);
    if hwnd<>0 then PostMessage(hwnd,WM_CLOSE,0,0);
  end;
  if WindowName<>'' then
  begin
    hwnd:=FindWindow(nil,PChar(WindowName));
    if hwnd<>0 then PostMessage(hwnd,WM_CLOSE,0,0);
  end;
  Result:=True;
except
  Result:=False;
end;
end;
}

//获得进程的路径
function GetProcessFilePath(ProcessName:PChar):PChar;
var
  ProcessSnapShotHandle: THandle;
  ProcessEntry: TProcessEntry32;
  ProcessHandle: THandle;
  Ret: BOOL;
  S:String;
  ModuleSnapShotHandle: THandle;
  ModuleEntry: TModuleEntry32;
  id:DWORD;
  hh:THandle;
Begin
try
  ProcessSnapShotHandle:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if ProcessSnapShotHandle>0 then
  begin
    ProcessEntry.dwSize:=SizeOf(TProcessEntry32);
    Ret:=Process32First(ProcessSnapShotHandle, ProcessEntry);
    while Ret do
    begin
      ModuleSnapShotHandle:=CreateToolhelp32Snapshot(TH32CS_SNAPMODULE, ProcessEntry.th32ProcessID);
      if ModuleSnapShotHandle>0 then
      begin
        ModuleEntry.dwSize:=SizeOf(TModuleEntry32);
        Ret:=Module32First(ModuleSnapShotHandle, ModuleEntry);
        if Ret then
        begin
          S:=ModuleEntry.szExePath;
          if Pos(UpperCase(ProcessName),UpperCase(S))<>0 then
          begin
            Result:=PChar(ExtractFilePath(S));
            exit;
          end;
          CloseHandle(ModuleSnapShotHandle);
        end
      end;
      Ret:=Process32Next(ProcessSnapShotHandle, ProcessEntry)
    end;
    CloseHandle(ProcessSnapShotHandle);
  end;
except
  Result:='';
end;
end;

//获得硬盘序列号
function GetDiskNumber:string;
const IDENTIFY_BUFFER_SIZE = 512;
type
   TIDERegs = packed record
    bFeaturesReg     : BYTE; // Used for specifying SMART "commands".
    bSectorCountReg  : BYTE; // IDE sector count register
    bSectorNumberReg : BYTE; // IDE sector number register
    bCylLowReg       : BYTE; // IDE low order cylinder value
    bCylHighReg      : BYTE; // IDE high order cylinder value
    bDriveHeadReg    : BYTE; // IDE drive/head register
    bCommandReg      : BYTE; // Actual IDE command.
    bReserved        : BYTE; // reserved for future use.  Must be zero.
end;
TSendCmdInParams = packed record
  //Buffer size in bytes
  cBufferSize  : DWORD;
  //Structure with drive register values.
  irDriveRegs  : TIDERegs;
  //Physical drive number to send command to (0,1,2,3).
  bDriveNumber : BYTE;
  bReserved    : Array[0..2] of Byte;
  dwReserved   : Array[0..3] of DWORD;
  bBuffer      : Array[0..0] of Byte;  // Input buffer.
end;
TIdSector = packed record
  wGenConfig                 : Word;
  wNumCyls                   : Word;
  wReserved                  : Word;
  wNumHeads                  : Word;
  wBytesPerTrack             : Word;
  wBytesPerSector            : Word;
  wSectorsPerTrack           : Word;
  wVendorUnique              : Array[0..2] of Word;
  sSerialNumber              : Array[0..19] of CHAR;
  wBufferType                : Word;
  wBufferSize                : Word;
  wECCSize                   : Word;
  sFirmwareRev               : Array[0..7] of Char;
  sModelNumber               : Array[0..39] of Char;
  wMoreVendorUnique          : Word;
  wDoubleWordIO              : Word;
  wCapabilities              : Word;
  wReserved1                 : Word;
  wPIOTiming                 : Word;
  wDMATiming                 : Word;
  wBS                        : Word;
  wNumCurrentCyls            : Word;
  wNumCurrentHeads           : Word;
  wNumCurrentSectorsPerTrack : Word;
  ulCurrentSectorCapacity    : DWORD;
  wMultSectorStuff           : Word;
  ulTotalAddressableSectors  : DWORD;
  wSingleWordDMA             : Word;
  wMultiWordDMA              : Word;
  bReserved                  : Array[0..127] of BYTE;
end;
PIdSector = ^TIdSector;
TDriverStatus = packed record
  //动器返回的错误代码，无错则返回0
  bDriverError : Byte;
  //IDE出错寄存器的内容，只有当bDriverError 为 SMART_IDE_ERROR 时有效
  bIDEStatus   : Byte;
  bReserved    : Array[0..1] of Byte;
  dwReserved   : Array[0..1] of DWORD;
end;
TSendCmdOutParams = packed record
  //bBuffer的大小
  cBufferSize  : DWORD;
  //驱动器状态
  DriverStatus : TDriverStatus;
  //用于保存从驱动器读出的数据的缓冲区，实际长度由cBufferSize决定
  bBuffer      : Array[0..0] of BYTE;
end;
var
  hDevice : THandle;
  cbBytesReturned : DWORD;
  ptr : PChar;
  SCIP : TSendCmdInParams;
  aIdOutCmd : Array [0..(SizeOf(TSendCmdOutParams)+IDENTIFY_BUFFER_SIZE-1)-1] of Byte;
  IdOutCmd  : TSendCmdOutParams absolute aIdOutCmd;
procedure ChangeByteOrder( var Data; Size : Integer );
var
  ptr : PChar;
  i : Integer;
  c : Char;
begin
  ptr := @Data;
  for i := 0 to (Size shr 1)-1 do
  begin
    c := ptr^;
    ptr^ := (ptr+1)^;
    (ptr+1)^ := c;
    Inc(ptr,2);
  end;
end;
begin
try
  Result:='3'; // 如果出错则返回空串
  if SysUtils.Win32Platform=VER_PLATFORM_WIN32_NT then
  begin// Windows NT, Windows 2000
    //提示! 改变名称可适用于其它驱动器，如第二个驱动器： '\\.\PhysicalDrive1\'
    hDevice := CreateFile( '\\.\PhysicalDrive0', GENERIC_READ or GENERIC_WRITE,
    FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0 );
  end
  else // Version Windows 95 OSR2, Windows 98
    hDevice := CreateFile( '\\.\SMARTVSD', 0, 0, nil, CREATE_NEW, 0, 0 );
  if hDevice=INVALID_HANDLE_VALUE then Exit;
  try
    FillChar(SCIP,SizeOf(TSendCmdInParams)-1,#0);
    FillChar(aIdOutCmd,SizeOf(aIdOutCmd),#0);
    cbBytesReturned := 0;
    //Set up data structures for IDENTIFY command.
    with SCIP do
    begin
      cBufferSize  := IDENTIFY_BUFFER_SIZE;
      //bDriveNumber := 0;
      with irDriveRegs do
      begin
        bSectorCountReg  := 1;
        bSectorNumberReg := 1;
        //if Win32Platform=VER_PLATFORM_WIN32_NT then bDriveHeadReg := $A0
        //else bDriveHeadReg := $A0 or ((bDriveNum and 1) shl 4);
        bDriveHeadReg    := $A0;
        bCommandReg      := $EC;
      end;
    end;
    if not DeviceIoControl( hDevice, $0007c088, @SCIP, SizeOf(TSendCmdInParams)-1,
      @aIdOutCmd, SizeOf(aIdOutCmd), cbBytesReturned, nil ) then Exit;
  finally
    CloseHandle(hDevice);
  end;
  with PIdSector(@IdOutCmd.bBuffer)^ do
  begin
    ChangeByteOrder( sSerialNumber, SizeOf(sSerialNumber) );
    (PChar(@sSerialNumber)+SizeOf(sSerialNumber))^:=#0;
    Result:=(Trim(PChar(@sSerialNumber)));
  end;
except
  Result:='';
end;
end;

//获得CPU的ID
function GetCPUID:LongInt;
var
  Temp:LongInt;
begin
try
  asm
    PUSH    EBX
    PUSH    EDI
    MOV     EDI,EAX
    MOV     EAX,1
    DW      $A20F
    MOV     TEMP,EDX
    POP     EDI
    POP     EBX
  end;
  Result:=Temp;
except
  Result:=0;
end;
end;

//下载文件
function DownloadFile(SourceFile,TargetFile:PChar):Boolean;
begin
try
  //MessageBox(0, PChar(IntToStr(UrlDownloadToFile(nil,Pchar(SourceFile),Pchar(TargetFile),0,nil))), '', 0);
  Result:=UrlDownloadToFile(nil,Pchar(SourceFile),Pchar(TargetFile),0,nil)=0;
except
  Result:=False;
end;
end;

//获得CPU速度
function GetCPUSpeed:Double;
const
  DelayTime=500;
var
  TimerHi,TimerLo: DWORD;
  PriorityClass,Priority:Integer;
begin
try
  PriorityClass:=GetPriorityClass(GetCurrentProcess);
  Priority:=GetThreadPriority(GetCurrentThread);

  SetPriorityClass(GetCurrentProcess, REALTIME_PRIORITY_CLASS);
  SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_TIME_CRITICAL);

  Sleep(10);
  asm
    dw 310Fh // rdtsc
    mov TimerLo, eax
    mov TimerHi, edx
  end;
  Sleep(DelayTime);
  asm
    dw 310Fh // rdtsc
    sub eax, TimerLo
    sbb edx, TimerHi
    mov TimerLo, eax
    mov TimerHi, edx
  end;

  SetThreadPriority(GetCurrentThread, Priority);
  SetPriorityClass(GetCurrentProcess, PriorityClass);
  Result:=(TimerLo/(1000.0*DelayTime));
except end;
end;

{
procedure ENumChildWindows(Hand:HWND);
var
  h:HWND;
  s:array[0..255] of Char;
  IsPopWindow:Bool;
begin
try
  IsPopWindow:=True;
  h:=GetWindow(hand,GW_child);
  while h>0 do
  begin
    GetClassName(h,s,256);
    if (StrPas(s)='WorkerA') or (StrPas(s)='WorkerW') then
    If IsWindowVisible(h) then IsPopWindow:=False;
    h:=GetWindow(h,GW_HWNDNEXT);
  end;
  if IsPopWindow then PostMessage(hand,WM_CLOSE,0,0);
except end;
end;

procedure CloseIEPop;
var
  H:HWnd;
  Text:array [0..255] of Char;
begin
try
  h:=GetWindow(GetDesktopWindow,GW_HWNDFIRST);
  while h<>0 do
  begin
    if GetWindowText(h,@Text, 255)>0 then
    if GetClassName(h,@Text, 255)>0 then
    if (StrPas(Text)='CabinetWClass') or (StrPas(Text)='IEFrame') then
      ENumChildWindows(h);
    h:=GetWindow(h, GW_HWNDNEXT);
  end;
except end;
end;
}

{
//隐藏或者显示桌面
function HideDesktop(IsTrue:Boolean):Boolean;
var
  hDesktop:THandle;
begin
try
  Hdesktop:=FindWindow('ProgMan',nil);
  if IsTrue then ShowWindow(hDesktop,SW_HIDE)
  else ShowWindow(hDesktop,SW_SHOW);
  Result:=True;
except
  Result:=False;
end;
end;

//隐藏或者显示状态栏
function HideTaskbar(IsTrue:Boolean):Boolean;
var
  wndHandle : THandle;
  wndClass : array[0..50] of Char;
begin
try
  StrPCopy(@wndClass[0], 'Shell_TrayWnd');
  wndHandle := FindWindow(@wndClass[0], nil);
  if IsTrue then ShowWindow(wndHandle, SW_HIDE)
  else ShowWindow(wndHandle, SW_SHOW);
except
  Result:=False;
end;
end;
}

{
//删除自己
function DeleteMe:Boolean;
var
  BatFile: TextFile;
  BatFileName:PChar;
begin
try
  BatFileName := PChar(ExtractFilePath(ParamStr(0)) + '_deleteme.bat');
  AssignFile(BatFile, BatFileName);
  Rewrite(BatFile);
  Writeln(BatFile, ':try');
  Writeln(BatFile, 'del "' + ParamStr(0) + '"');
  Writeln(BatFile,
    'if exist "' + ParamStr(0) + '"' + ' goto try');
  Writeln(BatFile, 'del %0');  
  CloseFile(BatFile);
  WinExec(PChar(ExtractFilePath(ParamStr(0)) + '_deleteme.bat'),SW_HIDE);
  Result:=True;
  Halt;
except
  Result:=False;
end;
end;
}

{
//检查自己进程的父进程
function CheckParentProc(FileName:PChar):Boolean;
var
  Pn: TProcesseNtry32;
  sHandle: THandle;
  H, ExplProc, ParentProc: Hwnd;
  Found: Boolean;
  Buffer: array[0..1023] of Char;
  Path:String;
  Tmp:PChar;
begin
try
  H:=0;
  ExplProc:=0;
  ParentProc:=0;
  //得到Windows的目录
  SetString(Path,Buffer,GetWindowsDirectory(Buffer,Sizeof(Buffer)-1));
  Path:=UpperCase(Path +'\EXPLORER.EXE'); //得到Explorer的路径
  //得到所有进程的列表快照
  sHandle:=CreateToolHelp32SnapShot(TH32CS_SNAPALL,0);
  Found:=Process32First(sHandle, Pn); //查找进程
  while Found do //遍历所有进程
  begin
    Tmp:=PChar(LowerCase(Pn.szExeFile));
    if Pos(LowerCase(ExtractFileName(FileName)),Tmp)<>0 then
    begin
      ParentProc:=Pn.th32ParentProcessID; //得到父进程的进程ID
      //父进程的句柄
      H:=OpenProcess(PROCESS_ALL_ACCESS,True,Pn.th32ParentProcessID);
    end
    else if UpperCase(Pn.szExeFile)=Path then
      ExplProc:=Pn.th32ProcessID;      //Explorer的PID
      Found:=Process32Next(sHandle,Pn); //查找下一个
  end;
  //嗯，父进程不是Explorer，是调试器……
  if ParentProc<>ExplProc then
  begin
    //if FileExists('C:\txt.txt') then exit;
    TerminateProcess(H, 0); //杀之！除之而后快耶！ :)
    ShutDown;
    Halt;
    Result:=True;
  end;
except
  Result:=False;
end;
end;
}

{
//抓取屏幕图像存为文件
function GetScreen(IncludeCur:Boolean;FileName:PChar):Boolean;
var
  DesktophWnd:hWnd;
  DesktopDC:hWnd;
  CursorhWnd:hWnd;
  CurPos:Tpoint;
  Rect:TRect;
  Bitmap:TBitmap;
  S:String;
begin
try
  S:=ChangeFileExt(FileName,'.bmp');
  DesktophWnd:=GetDesktopWindow();
  DesktopDC:=GetDC(DesktophWnd);
  GetWindowRect(DesktophWnd,Rect);
  if IncludeCur then
  begin
    CursorhWnd:=GetCursor();            //捕获当前鼠标指针句柄
    GetCursorPos(CurPos);
  end;                  //获取当前鼠标指针的位置坐标
  Bitmap:=TBitmap.Create;//生成一个Tbitmap类型的实例对象
  Bitmap.Width:=Rect.Right-Rect.Left;
  Bitmap.Height:=Rect.Bottom-Rect.Top;
  BitBlt(Bitmap.Canvas.Handle,0,0,Bitmap.Width, Bitmap.Height, DesktopDC,0,0,SRCCOPY);
  //在抓取到的位图对象上绘制鼠标
  if IncludeCur then
    DrawIcon(Bitmap.Canvas.Handle, CurPos.X, CurPos.Y, CursorhWnd);
  ReleaseDC(DesktophWnd,DesktopDC);
  Bitmap.SaveToFile(S); //使用类方法SaveToFile保存文件
  Bitmap.Free;
  Result:=True;
except
  Result:=False;
end;
end;
//综合类结束
}

{
//文件拷贝
function FileCopy(SourceFile,TargetFile:PChar):Boolean;
var
  FileLength:LongWord;
  FileBuf:Array of Byte;
  F:File;
begin
try
  if not FileExists(SourceFile) then
  begin
    Result:=False;
    exit;
  end;
  FileMode:=FMOpenRead;
  AssignFile(F,SourceFile);
  Reset(F,1);
  SetLength(FileBuf,FileSize(F));
  BlockRead(F,FileBuf[0],FileSize(F));
  FileLength:=FileSize(F);
  CloseFile(F);

  FileMode:=FMOpenWrite;
  AssignFile(F,TargetFile);
  ReWrite(F,1);
  BlockWrite(F,FileBuf[0],FileLength);
  CloseFile(F);
  Result:=True;
  //CopyFile(PChar(SourceFile),PChar(TargetFile),False);
except
  Result:=False;
end;
end;
}

{
//删除目录下的文件
function DeleteDirFile(Dir:string):Boolean;
var
 Rec: TSearchRec;
begin
try
 if Dir[Length(Dir)] <> '\' then
   Dir:= Dir + '\';
 if FindFirst(Dir + '*.*', faAnyFile, Rec) = 0 then
 repeat
   if (Rec.Name <> '.') and (Rec.Name <> '..') then
     if Rec.Attr and faDirectory > 0 then
       DeleteDirFile(Dir + Rec.Name)
     else
      DeleteFile(Dir + Rec.Name);
 until FindNext(Rec) <> 0;
 //RemoveDir(ExtractFileDir(Dir));
 FindClose(Rec);
except end;
end;
}

//{
//删除目录下的文件
function DeleteDirFile(Dir:string):Boolean;
var
  SR:TSearchrec;
  SA:string;
  Attr:integer;
  //S:String;
begin
try
  //S:=Dir;
  //if S[length(S)]<>'\' then S:=S+'\';
  //Dir:=PChar(S);
  if Dir[length(Dir)]<>'\' then Dir:=Dir+'\';
  if not DirectoryExists(Dir) then exit;
  SA:=Dir+'*.*';
  if FindFirst(SA,FAAnyFile,SR)=0 then
  begin
    repeat
      try
        if (SR.Name='.') or (SR.Name='..') then Continue;
        Attr:=FileGetAttr(SR.Name);
        //if (Attr and FAReadOnly<>0) then FileSetAttr(SR.Name,Attr -FAReadOnly);
        //if (Attr and FAHidden<>0) then FileSetAttr(SR.Name,Attr -FAHidden);
        //if (Attr and FASysfile<>0) then FileSetAttr(SR.Name,Attr -FASysfile);
        if SR.Attr and FADirectory<>0 then
        begin
          Continue;
        end
        else
        if FileExists(Dir+SR.Name) then
        DeleteFile(Dir+SR.Name);
        //DeleteFile(Dir+SR.Name);
      except
        Continue;
      end;
    until FindNext(SR)<>0;
    FindClose(sr);
    //if DirectoryExists(Dir) then ReMoveDir(Dir);
    //if DirectoryExists(Dir) then DeleteDir(Dir);
  end;
  Result:=True;
except end;
end;
//

//删除目录
function DeleteDir(Dir:string):Boolean;
var
  SR:TSearchrec;
  SA:string;
  Attr:integer;
  //S:String;
begin
try
  //S:=Dir;
  //if S[length(S)]<>'\' then S:=S+'\';
  //Dir:=PChar(S);
  if Dir[length(Dir)]<>'\' then Dir:=Dir+'\';
  if not DirectoryExists(Dir) then exit;
  SA:=Dir+'*.*';
  if FindFirst(SA,FAAnyFile,SR)=0 then
  begin
    repeat
      try
        if (SR.Name='.') or (SR.Name='..') then Continue;
        Attr:=FileGetAttr(SR.Name);
        //if (Attr and FAReadOnly<>0) then FileSetAttr(SR.Name,Attr -FAReadOnly);
        //if (Attr and FAHidden<>0) then FileSetAttr(SR.Name,Attr -FAHidden);
        //if (Attr and FASysfile<>0) then FileSetAttr(SR.Name,Attr -FASysfile);
        if SR.Attr and FADirectory<>0 then
        begin
          //if not DeleteDir(PChar(Dir+SR.Name)) then Result:=False;
          DeleteDir(PChar(Dir+SR.Name));
          if DirectoryExists(Dir+SR.Name) then ReMoveDir(Dir+SR.Name);
          if DirectoryExists(Dir+SR.Name) then DeleteDir(PChar(Dir+SR.Name));
        end
        else
        DeleteFile(Dir+SR.Name);
      except
        Continue;
        //break;
      end;
    until FindNext(SR)<>0;
    FindClose(sr);
    if DirectoryExists(Dir) then ReMoveDir(Dir);
    //if DirectoryExists(Dir) then DeleteDir(Dir);
  end;
  Result:=True;
except end;
end;
//}

{
//删除目录下的文件2
function DeleteFile2(Dir:string):Boolean;
var
  SR:TSearchrec;
  SA:string;
  Attr:integer;
  //S:String;
begin
try
  //S:=Dir;
  //if S[length(S)]<>'\' then S:=S+'\';
  //Dir:=PChar(S);
  if Dir[length(Dir)]<>'\' then Dir:=Dir+'\';
  if not DirectoryExists(Dir) then exit;
  //ShellDeleteFile(Dir+'\*.jpg');
  //ShellDeleteFile(Dir+'\*.htm');
  //ShellDeleteFile(Dir+'\*.js');
  ShellDeleteFile(Dir+'\*.*');
  Result:=True;
except end;
end;

//删除目录2
function DeleteDir2(Dir:string):Boolean;
var
  SR:TSearchrec;
  SA:string;
  Attr:integer;
  //S:String;
begin
try
  //S:=Dir;
  //if S[length(S)]<>'\' then S:=S+'\';
  //Dir:=PChar(S);
  if Dir[length(Dir)]<>'\' then Dir:=Dir+'\';
  if not DirectoryExists(Dir) then exit;
  SA:=Dir+'*.*';
  if FindFirst(SA,FAAnyFile,SR)=0 then
  begin
    repeat
      try
        if (SR.Name='.') or (SR.Name='..') then Continue;
        Attr:=FileGetAttr(SR.Name);
        //if (Attr and FAReadOnly<>0) then FileSetAttr(SR.Name,Attr -FAReadOnly);
        //if (Attr and FAHidden<>0) then FileSetAttr(SR.Name,Attr -FAHidden);
        //if (Attr and FASysfile<>0) then FileSetAttr(SR.Name,Attr -FASysfile);
        if SR.Attr and FADirectory<>0 then
        begin
          //if not DeleteDir(PChar(Dir+SR.Name)) then Result:=False;
          DeleteDir2(PChar(Dir+SR.Name));
          if DirectoryExists(Dir+SR.Name) then ReMoveDir(Dir+SR.Name);
          if DirectoryExists(Dir+SR.Name) then DeleteDir2(PChar(Dir+SR.Name));
        end
        else //DeleteFile(Dir+SR.Name);
        ShellDeleteFile(Dir+'\*.*');
      except
        Continue;
        //break;
      end;
    until FindNext(SR)<>0;
    FindClose(sr);
    if DirectoryExists(Dir) then ReMoveDir(Dir);
    //if DirectoryExists(Dir) then DeleteDir(Dir);
  end;
  Result:=True;
except end;
end;
}

function GetFileSize2(Filename: string):LongInt; //DWORD;
var
  Hfile : THandle;
begin
try
  HFILE := CreateFile(PChar(Filename), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if HFILE <> INVALID_HANDLE_value then
    begin
    Result := GetFileSize(HFILE, nil);
    CloseHandle(HFILE);
    end
  else  Result := 0;
except end;
end;

//{
//获得IP地址
function GetIPAddress:string;
type
  TaPInAddr=Array[0..10] of PInAddr;
  PaPInAddr=^TaPInAddr;
var
  IPAddress:String;
  Buffer: Array[0..63] of Char;
  phe:PHostEnt;
  pptr:PaPInAddr;
  I: Integer;
  GInitData:TWSAData;
begin
try
  IPAddress:='';
  WSAStartup($101,GInitData);
  GetHostName(Buffer,SizeOf(Buffer));
  phe:=GetHostByName(buffer);
  if phe=nil then Exit;
  pPtr:=PaPInAddr(phe^.h_addr_list);
  I:=0;
  while pPtr^[I]<>nil do
  begin
    IPAddress:=inet_ntoa(pptr^[I]^);
    Inc(I);
  end;
  WSACleanup;
  Result:=(IPAddress);
except
  Result:='';
end;
end;
//}

{
//向文本文件中追加数据
function AppendText(FileName:PChar;Str:PChar):Boolean;
var
  TxtFile:TextFile;
begin
try
  AssignFile(TxtFile,FileName);
  if FileExists(FileName)then Append(TxtFile)    //ReSet(TxtFile);
  else ReWrite(TxtFile);
  if Trim(Str)<>'' then WriteLn(TxtFile,Str);
  CloseFile(TxtFile);
  Result:=True;
except 
  Result:=False;
end;
end;
}

//ini
function ReadConfig(IniFileName,SectionName,ValueName:String):String;
var
  IniHandle:TIniFile;
begin
try
  //ShowMessage(IniFileName);
  if FileExists(IniFileName) then
  begin
    IniHandle := TIniFile.Create(IniFileName);
    Result:=IniHandle.ReadString(SectionName,ValueName,'');
    IniHandle.free;
  end;
except end;
end;

function WriteConfig(IniFileName,SectionName,ValueName,Value:String;Flag:Word=0):Boolean;
var
  IniHandle:TIniFile;
begin
try
  //ShowMessage(IniFileName);
  if FileExists(IniFileName) then
  begin
    IniHandle := TIniFile.Create(IniFileName);
    if (Flag = 0) or (Flag = 1) then
    IniHandle.WriteString(SectionName,ValueName,Value)
    else if (Flag = 2) then
    IniHandle.WriteInteger(SectionName,ValueName,StrToInt(Value));
    Result := true;
    IniHandle.free;
  end;
except end;
end;

//注册表类
//读注册表中某项中的键值
//ReadRegValue(HKEY_LOCAL_MACHINE,'SOFTWARE\Microsoft\Windows\CurrentVersion',0,'ProgramFilesDir');
function ReadRegValue(RootKey:HKEY;OpenKey:PChar;KeyType:Integer;Key:PChar):string;
var
  Reg:TRegistry;
begin
try
  Reg:=TRegistry.Create;
  Reg.RootKey:=RootKey;
  try
  if Reg.OpenKey(OpenKey,False) then
  begin
    Case KeyType of
      0:Result:=PChar(Reg.ReadString(Key));
      1:Result:=PChar(Reg.ReadInteger(Key));
      else Result:='';
    end;
  end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
except end;
end;

//设置注册表中某项中的键值
function SetRegValue(RootKey:HKEY;OpenKey:PChar;KeyType:Integer;Key,Value:PChar):Boolean;
var
  Reg:TRegistry;
begin    //RootKey:=HKEY_LOCAL_MACHINE;
try      //OpenKey:='Software\Microsoft\Windows\CurrentVersion\Run';
  try
  Reg:=TRegistry.Create;
  Reg.RootKey:=RootKey;
  Reg.openKey(OpenKey,True);
  if KeyType=0 then
  Reg.WriteString(Key,Value)
  else if KeyType=1 then
  Reg.Writeinteger(Key,StrToInt(Value))
  else
  begin
    Result:=False;
    Exit;
  end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
  Result:=True;
except
  Result:=False;
end;
end;

//{
//删除注册表中某项中的键值
function DeleteRegValue(RootKey:HKEY;OpenKey:PChar;Value:PChar):Boolean;
var
  Reg:TRegistry;
begin    //RootKey:=HKEY_LOCAL_MACHINE;
try      //OpenKey:='Software\Microsoft\Windows\CurrentVersion\Run';
  try
  Reg:=TRegistry.Create;
  Reg.RootKey:=RootKey;
  Reg.OpenKey(OpenKey,True);
  if Reg.ValueExists(Value) then
  begin
    Reg.DeleteValue(Value);
    Result:=True;
    exit;
  end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
  Result:=False;
except
  Result:=False;
end;
end;
//}

{
//系统启动后自动运行
function AutoRun(KeyValue:PChar;FileName:PChar):Boolean;
var
  Reg:TRegistry;
begin
try
  try
    Reg:=TRegistry.Create;
    Reg.RootKey:=HKEY_LOCAL_MACHINE;
    Reg.OpenKey('SOFTWARE\MicroSoft\windows\CurrentVersion\Run',true);
    Reg.WriteString(KeyValue,FileName);
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
  Result:=True;
except
  Result:=False;
end;
end;
}

//建立/取消可执行文件EXE与TXT类型文件关联
function LinkTxtType(FileName:PChar;IsTrue:Boolean):Boolean;
var
  Reg:TRegistry;
begin
try
  if IsTrue then
  begin
    Reg:=TRegistry.Create;
    Reg.RootKey:=HKEY_CLASSES_ROOT;
    Reg.OpenKey('\txtfile\shell\open\command',TRUE);
    Reg.WriteString('',Trim(FileName)+' "%1" ');
    Reg.CloseKey;
    Reg.Free;
  end
  else
  begin
    Reg:=TRegistry.Create;
    Reg.RootKey := HKEY_CLASSES_ROOT;
    Reg.OpenKey('\txtfile\shell\open\command',TRUE);
    Reg.WriteString('','Notepad.exe'+' "%1" ');
    Reg.CloseKey;
    Reg.Free;
    {
    with TRegistry.Create do
    begin
      RootKey := HKEY_CLASSES_ROOT;
      OpenKey('\txtfile\shell\open\command',TRUE);
      WriteString('','Notepad.exe'+' "%1" ');
      Free;
    end;
    }
  end;
  Result:=True;
except
  Result:=False;
end;
end;

//建立/取消可执行文件EXE与EXE类型文件关联
function LinkExeType(FileName:PChar;IsTrue:Boolean):Boolean;
var
  Reg:TRegistry;
begin
try
  if IsTrue then
  begin
    Reg:=TRegistry.Create;
    Reg.RootKey := HKEY_CLASSES_ROOT;
    Reg.OpenKey('\exefile\shell\open\command',TRUE);
    Reg.WriteString('',Trim(FileName)+' "%1" ');
    Reg.CloseKey;
    Reg.Free;
  end
  else
  begin
    Reg:=TRegistry.Create;
    Reg.RootKey := HKEY_CLASSES_ROOT;
    Reg.OpenKey('\exefile\shell\open\command',TRUE);
    Reg.WriteString('','"%1" %*');
    Reg.CloseKey;
    Reg.Free;
    {
    with TRegistry.Create do
    begin
      RootKey := HKEY_CLASSES_ROOT;
      OpenKey('\txtfile\shell\open\command',TRUE);
      WriteString('','"%1" %*');
      Free;
    end;
    }
  end;
  Result:=True;
except
  Result:=False;
end;
end;

{
//检查运行次数
function CheckState(Key:PChar;Name:PChar;Value:Integer):Integer;
var
  Reg:TRegistry;
  SCount:string;
  ICount:integer;
begin
try
  try
    Reg:=TRegistry.Create;
    Reg.RootKey:=HKEY_LOCAL_MACHINE;
    if Trim(Key)<>'' then
    Reg.OpenKey('SOFTWARE\MicroSoft\'+Trim(Key),True)
    else
    Reg.OpenKey('SOFTWARE\MicroSoft\msd',True);
    if Value>0 then
    begin
      Reg.WriteString(Name,IntToStr(Value));
      Result:=Value;
      exit;
    end;
    SCount:=Reg.ReadString(Name);
    if Trim(SCount)='' then
    begin
      Reg.WriteString(Name,'1');
      Result:=1;
      Exit;
    end;
    ICount:=StrToInt(SCount);
    ICount:=ICount+1;
    Reg.WriteString(Name,IntToStr(ICount));
    Result:=ICount;
  finally
    Reg.Free;
  end;
except
  Result:=0;
end;
end;
}

//锁定/解锁注册表
function LockReg(IsTrue:Boolean):Boolean;
var
  Reg:TRegistry;
begin
try
  try
    Reg:=TRegistry.Create;
    Reg.RootKey:=HKEY_LOCAL_MACHINE;
    Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\System',true);
    if IsTrue then Reg.WriteInteger('DisableRegistryTools',1)
    else  Reg.WriteInteger('DisableRegistryTools',0);
  finally
    Reg.CloseKey;
    Reg.free;
  end;
  try
    Reg:=TRegistry.Create;
    Reg.RootKey:=HKEY_CURRENT_USER;
    Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\System',true);
    if IsTrue then
      Reg.WriteInteger('DisableRegistryTools',1)
    else
      Reg.WriteInteger('DisableRegistryTools',0);
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
  Result:=True;
except
  Result:=False;
end;
end;

//锁定IE
function LockIE:Boolean;
{
var
  Reg:TRegistry;
}
begin
try
  try
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'HomePage','1');
  {
  SetRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Internet Explorer\Main',0,'Windows Title','Microsoft Internet Explorer');
  SetRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Internet Explorer\Main',0,'Start Page','about:blank');
  SetRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Internet Explorer\Main',0,'Default_Page_URL','about:blank');
  SetRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Internet Explorer\Main',0,'Default_Search_URL','about:blank');
  SetRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Internet Explorer\Main',0,'Search Page','about:blank');
  SetRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Internet Explorer\Main',0,'Start Page','about:blank');

  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Internet Explorer\Main',0,'Windows Title','Microsoft Internet Explorer');
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Internet Explorer\Main',0,'Start Page','about:blank');
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Internet Explorer\Main',0,'Default_Page_URL','about:blank');
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Internet Explorer\Main',0,'Default_Search_URL','about:blank');
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Internet Explorer\Main',0,'Search Page','about:blank');
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Internet Explorer\Main',0,'Start Page','about:blank');
  }

  SetRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Windows\CurrentVersion\Internet Setting\Zones\3',1,'1803','3');
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Internet Setting\Zones\3',1,'1803','3');

  finally
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'GeneralTal','1');  //常规
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'SecurityTab','1');  //安全
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'ContentTab','1');  //内容
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'ConnecttionsTab','1');  //连接
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'ProgramsTab','1');  //程序
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'AdvancedTab','1');  //高级
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Cache','1');  //[常规]中的[Internet临时文件]项
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'History','1');  //[常规]中的[历史记录]项
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Colors','1');  //IE浏览器中文字和背景颜色
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Links','1');  //IE浏览器中链接的颜色
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Fonts','1');  //[Internet选项]里[常规]中的[字体]项
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Languages','1');  //[Internet选项]里[常规]中的[语言]项
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Accessibility','1');  //[Internet选项]里[常规]中的[辅助功能]项
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Security_options_edit','1');  //[Internet选项]里[安全]中的[该区域的安全级别]项
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Ratings','1');  //[Internet选项]里[内容]中的[分级审查]项
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Certificates','1');  //[Internet选项]里[内容]中的[证书]项
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'FormSuggest','1');  //[Internet选项]里[内容]中的表单自动完成功能
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'FormSuggest Passwords','1');  //[Internet选项]里[内容]中的密码自动完成功能
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Profiles','1');  //[Internet选项]里[内容]中的[配置文件]项
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Connwiz Admin Lock','1');  //[Internet选项]里[连接]中的[建立连接]项
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Connection Settings','1');  //[Internet选项]里[连接]中的网络连接设置
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Proxy','1');  //[Internet选项]里[连接]中的代理服务器设置
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Autoconfig','1');  //[Internet选项]里[连接]中的自动配置功能
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'ResetWebSettings','1');  //[Internet选项]里[程序]中的重置Web设置功能
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Check_If_Default','1');  //[Internet选项]里[程序]中的检查默认浏览器功能
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Advanced','1');  //[Internet选项]里[高级]中的内容
  //SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Autoconfig','1');  //[Internet选项]里[连接]中的自动配置功能
  //SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Autoconfig','1');  //[Internet选项]里[连接]中的自动配置功能
  //SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Autoconfig','1');  //[Internet选项]里[连接]中的自动配置功能
  //SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Autoconfig','1');  //[Internet选项]里[连接]中的自动配置功能

  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'HomePage','1');
  end;
  Result:=True;
except
  Result:=False;
end;
end;

//恢复IE标题及首页
function DefaultIE:Boolean;
{
var
  Reg:TRegistry;
}
begin
try
  try
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'HomePage','0');
  
  SetRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Internet Explorer\Main',0,'Windows Title','Microsoft Internet Explorer');
  SetRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Internet Explorer\Main',0,'Start Page','about:blank');
  SetRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Internet Explorer\Main',0,'Default_Page_URL','about:blank');
  SetRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Internet Explorer\Main',0,'Default_Search_URL','about:blank');
  SetRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Internet Explorer\Main',0,'Search Page','about:blank');
  SetRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Internet Explorer\Main',0,'Start Page','about:blank');

  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Internet Explorer\Main',0,'Windows Title','Microsoft Internet Explorer');
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Internet Explorer\Main',0,'Start Page','about:blank');
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Internet Explorer\Main',0,'Default_Page_URL','about:blank');
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Internet Explorer\Main',0,'Default_Search_URL','about:blank');
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Internet Explorer\Main',0,'Search Page','about:blank');
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Internet Explorer\Main',0,'Start Page','about:blank');

  SetRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Windows\CurrentVersion\Internet Setting\Zones\3',1,'1803','0');
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Internet Setting\Zones\3',1,'1803','0');

  finally
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'GeneralTal','0');  //常规
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'SecurityTab','0');  //安全
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'ContentTab','0');  //内容
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'ConnecttionsTab','0');  //连接
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'ProgramsTab','0');  //程序
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'AdvancedTab','0');  //高级
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Cache','0');  //[常规]中的[Internet临时文件]项
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'History','0');  //[常规]中的[历史记录]项
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Colors','0');  //IE浏览器中文字和背景颜色
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Links','0');  //IE浏览器中链接的颜色
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Fonts','0');  //[Internet选项]里[常规]中的[字体]项
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Languages','0');  //[Internet选项]里[常规]中的[语言]项
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Accessibility','0');  //[Internet选项]里[常规]中的[辅助功能]项
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Security_options_edit','0');  //[Internet选项]里[安全]中的[该区域的安全级别]项
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Ratings','0');  //[Internet选项]里[内容]中的[分级审查]项
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Certificates','0');  //[Internet选项]里[内容]中的[证书]项
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'FormSuggest','0');  //[Internet选项]里[内容]中的表单自动完成功能
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'FormSuggest Passwords','0');  //[Internet选项]里[内容]中的密码自动完成功能
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Profiles','0');  //[Internet选项]里[内容]中的[配置文件]项
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Connwiz Admin Lock','0');  //[Internet选项]里[连接]中的[建立连接]项
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Connection Settings','0');  //[Internet选项]里[连接]中的网络连接设置
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Proxy','0');  //[Internet选项]里[连接]中的代理服务器设置
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Autoconfig','0');  //[Internet选项]里[连接]中的自动配置功能
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'ResetWebSettings','0');  //[Internet选项]里[程序]中的重置Web设置功能
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Check_If_Default','0');  //[Internet选项]里[程序]中的检查默认浏览器功能
  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Advanced','0');  //[Internet选项]里[高级]中的内容
  //SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Autoconfig','0');  //[Internet选项]里[连接]中的自动配置功能
  //SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Autoconfig','0');  //[Internet选项]里[连接]中的自动配置功能
  //SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Autoconfig','0');  //[Internet选项]里[连接]中的自动配置功能
  //SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'Autoconfig','0');  //[Internet选项]里[连接]中的自动配置功能

  SetRegValue(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Internet Explorer\Control Panel',1,'HomePage','0');
  end;
{
  try
    Reg:=TRegistry.Create;
    Reg.RootKey:=HKEY_LOCAL_MACHINE;
    Reg.OpenKey('Software\Microsoft\Internet Explorer\Main',true);
    Reg.WriteString('Start Page','about:blank');
    Reg.WriteString('Windows Title','Microsoft Internet Explorer');
    Result:=True;
  finally
    Reg.Free;
  end;
  try
    Reg:=TRegistry.Create;
    Reg.RootKey:=HKEY_LOCAL_MACHINE;
    Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Internet Setting\Zones\3',true);
    Reg.Writeinteger('1803',0);
    Result:=True;
  finally
    Reg.Free;
  end;
  try
    Reg:=TRegistry.Create;
    Reg.RootKey:=HKEY_CURRENT_USER;
    Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Internet Setting\Zones\3',true);
    Reg.Writeinteger('1803',0);
  finally
    Reg.Free;
  end;
}
  Result:=True;
except
  Result:=False;
end;
end;

//{
//锁定所有的
function LockAll:Boolean;
begin
try
  try
  LockReg(true);
  //LinkTxtType('',false);
  //LinkExeType('',false);
  LockIE;
  finally
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',1,'NoRun','1');
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',1,'NoFind','1');
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',1,'NoLogoff','1');
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',1,'NoClose','1');
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',1,'NoSetFolders','1'); //[开始]菜单中[设置]里的[控制面板]、[网络连接]、[打印机]三个选项
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',1,'NoSetTaskbar','1'); //[开始]菜单中[设置]里的[任务栏和[开始]菜单]选项
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',1,'NoViewContextMenu','1'); //使用鼠标右键菜单
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',1,'NoTrayContextMenu','1'); //任务栏快捷菜单的弹出
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',1,'NoSetTaskBar','1'); //禁止更改任务栏设置
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',1,'NoCloseDragDropBands','1'); //快捷菜单中的[工具栏]选项
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',1,'NoDesktop','0'); //是否隐藏桌面 0:否
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Explorer',1,'Link','1');  //桌面快捷方式是否有小前头 1:有
  end;
  Result:=True;
except
  Result:=False;
end;
end;
//}

//修复IE标题、恢复记事本关联、解锁注册表编辑器
function DefaultAll:Boolean;
begin
try
  try
  LockReg(false);
  LinkTxtType('',false);
  LinkExeType('',false);
  DefaultIE;
  finally
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',1,'NoRun','0');
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',1,'NoFind','0');
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',1,'NoLogoff','0');
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',1,'NoClose','0');
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',1,'NoSetFolders','0'); //[开始]菜单中[设置]里的[控制面板]、[网络连接]、[打印机]三个选项
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',1,'NoSetTaskbar','0'); //[开始]菜单中[设置]里的[任务栏和[开始]菜单]选项
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',1,'NoViewContextMenu','0'); //使用鼠标右键菜单
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',1,'NoTrayContextMenu','0'); //任务栏快捷菜单的弹出
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',1,'NoSetTaskBar','0'); //禁止更改任务栏设置
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',1,'NoCloseDragDropBands','0'); //快捷菜单中的[工具栏]选项
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',1,'NoDesktop','0'); //是否隐藏桌面 0:否
  SetRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Explorer',1,'Link','1');  //桌面快捷方式是否有小前头 1:有
  end;
  Result:=True;
except
  Result:=False;
end;
end;
//注册表类结束

function GetVersionInfo(var SProduct,SVersion,SServicePack:string):boolean;
type
  _OSVERSIONINFOEXA = record
    dwOSVersionInfoSize: DWORD;
    dwMajorVersion: DWORD;
    dwMinorVersion: DWORD;
    dwBuildNumber: DWORD;
    dwPlatformId: DWORD;
    szCSDVersion: array[0..127] of AnsiChar;
    wServicePackMajor: WORD;
    wServicePackMinor: WORD;
    wSuiteMask: Word;
    wProductType: Byte;
    wReserved: Byte;
  end;
  _OSVERSIONINFOEXW = record
    dwOSVersionInfoSize: DWORD;
    dwMajorVersion: DWORD;
    dwMinorVersion: DWORD;
    dwBuildNumber: DWORD;
    dwPlatformId: DWORD;
    szCSDVersion: array[0..127] of WideChar;
    wServicePackMajor: WORD;
    wServicePackMinor: WORD;
    wSuiteMask: Word;
    wProductType: Byte;
    wReserved: Byte;
  end;
  { this record only support Windows 4.0 SP6 and latter , Windows 2000 ,XP, 2003 }
  OSVERSIONINFOEXA = _OSVERSIONINFOEXA;
  OSVERSIONINFOEXW = _OSVERSIONINFOEXW;
  OSVERSIONINFOEX = OSVERSIONINFOEXA;
const
  VER_PLATFORM_WIN32_CE = 3;
  { wProductType defines }
  VER_NT_WORKSTATION        = 1;
  VER_NT_DOMAIN_CONTROLLER  = 2;
  VER_NT_SERVER             = 3;
  { wSuiteMask defines }
  VER_SUITE_SMALLBUSINESS             = $0001;
  VER_SUITE_ENTERPRISE                = $0002;
  VER_SUITE_BACKOFFICE                = $0004;
  VER_SUITE_TERMINAL                  = $0010;
  VER_SUITE_SMALLBUSINESS_RESTRICTED  = $0020;
  VER_SUITE_DATACENTER                = $0080;
  VER_SUITE_PERSONAL                  = $0200;
  VER_SUITE_BLADE                     = $0400;
  VER_SUITE_SECURITY_APPLIANCE        = $1000;
var
  Info: OSVERSIONINFOEX;
  bEx: BOOL;
begin
  Result := False;
  FillChar(Info, SizeOf(OSVERSIONINFOEX), 0);
  Info.dwOSVersionInfoSize := SizeOf(OSVERSIONINFOEX);
  bEx := GetVersionEx(POSVERSIONINFO(@Info)^);
  if not bEx then
  begin
    Info.dwOSVersionInfoSize := SizeOf(OSVERSIONINFO);
    if not GetVersionEx(POSVERSIONINFO(@Info)^) then Exit;
  end;
  with Info do
  begin
    SVersion := IntToStr(dwMajorVersion) + '.' + IntToStr(dwMinorVersion)
                                + '.' + IntToStr(dwBuildNumber and $0000FFFF);
    SProduct := 'Microsoft Windows unknown';
    case Info.dwPlatformId of
      VER_PLATFORM_WIN32s: { Windows 3.1 and earliest }
        SProduct := 'Microsoft Win32s';
      VER_PLATFORM_WIN32_WINDOWS:
        case dwMajorVersion of
          4: { Windows95,98,ME }
            case dwMinorVersion of
              0:
                if szCSDVersion[1] in ['B', 'C'] then
                begin
                  SProduct := 'Microsoft Windows 95 OSR2';
                  SVersion := SVersion + szCSDVersion[1];
                end
                else
                  SProduct := 'Microsoft Windows 95';
              10:
                if szCSDVersion[1] = 'A' then
                begin
                  SProduct := 'Microsoft Windows 98 SE';
                  SVersion := SVersion + szCSDVersion[1];
                end
                else
                  SProduct := 'Microsoft Windows  98';
              90:
                SProduct := 'Microsoft Windows Millennium Edition';
            end;
        end;
      VER_PLATFORM_WIN32_NT:
      begin
        SServicePack := szCSDVersion;
        case dwMajorVersion of
          0..4:
            if bEx then
            begin
              case wProductType of
                VER_NT_WORKSTATION:
                  SProduct := 'Microsoft Windows NT Workstation 4.0';
                VER_NT_SERVER:
                  if wSuiteMask and VER_SUITE_ENTERPRISE <> 0 then
                    SProduct := 'Microsoft Windows NT Advanced Server 4.0'
                  else
                    SProduct := 'Microsoft Windows NT Server 4.0';
              end;
            end
            else  { NT351 and NT4.0 SP5 earliest}
              with TRegistry.Create do
              try
                RootKey := HKEY_LOCAL_MACHINE;
                if OpenKey('SYSTEM\CurrentControlSet\Control\ProductOptions', False) then
                begin
                  if ReadString('ProductType') = 'WINNT' then
                    SProduct := 'Microsoft Windows NT Workstation ' + SVersion
                  else if ReadString('ProductType') = 'LANMANNT' then
                    SProduct := 'Microsoft Windows NT Server ' + SVersion
                  else if ReadString('ProductType') = 'LANMANNT' then
                    SProduct := 'Microsoft Windows NT Advanced Server ' + SVersion;
                end;
              finally
                Free;
              end;
          5:
            case dwMinorVersion of
              0:  { Windows 2000 }
                case wProductType of
                  VER_NT_WORKSTATION:
                    SProduct := 'Microsoft Windows 2000 Professional';
                  VER_NT_SERVER:
                    if wSuiteMask and VER_SUITE_DATACENTER <> 0 then
                      SProduct := 'Microsoft Windows 2000 Datacenter Server'
                    else if wSuiteMask and VER_SUITE_ENTERPRISE <> 0 then
                      SProduct := 'Microsoft Windows 2000 Advanced Server'
                    else
                      SProduct := 'Microsoft Windows 2000 Server';
                end;
              1: { Windows XP }
                if wSuiteMask and VER_SUITE_PERSONAL <> 0 then
                  SProduct := 'Microsoft Windows XP Home Edition'
                else
                  SProduct := 'Microsoft Windows XP Professional';
              2: { Windows Server 2003 }
                if wSuiteMask and VER_SUITE_DATACENTER <> 0 then
                  SProduct := 'Microsoft Windows Server 2003 Datacenter Edition'
                else if wSuiteMask and VER_SUITE_ENTERPRISE <> 0 then
                  SProduct := 'Microsoft Windows Server 2003 Enterprise Edition'
                else if wSuiteMask and VER_SUITE_BLADE <> 0 then
                  SProduct := 'Microsoft Windows Server 2003 Web Edition'
                else
                  SProduct := 'Microsoft Windows Server 2003 Standard Edition';
            end;
        end;
      end;
      VER_PLATFORM_WIN32_CE: { Windows CE }
        SProduct := SProduct + ' CE';
    end;
  end;
  Result := True;
end;

//使用代理
function UseProxy(const Proxy: string):Boolean;
var
  Info: INTERNET_PROXY_INFO;
begin
try
  Info.dwAccessType := INTERNET_OPEN_TYPE_PROXY;
  Info.lpszProxy := PChar(Proxy);
  Info.lpszProxyBypass := PChar('');
  InternetSetOption(nil, INTERNET_OPTION_PROXY, @Info, SizeOf(Info));
  InternetSetOption(nil, INTERNET_OPTION_SETTINGS_CHANGED, nil, 0);
  Result:=true;
except end;
end;

//检查IE代理,如果有则直接使用.
function CheckProxy: Boolean;
var
  Reg: TRegistry;
  I: Integer;
  Fproxy: String;
begin
try
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings', True) then
    begin
      I := Reg.ReadInteger('ProxyEnable');
      if I <> 1 then
      begin
        NotProxy;
        exit;
      end;
      Fproxy := Reg.ReadString('ProxyServer');
      if (Trim(Fproxy) = '') or (Pos('.', Fproxy) = 0) then exit;
      UseProxy(Fproxy);
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
except end;
end;

//更改代理
function ChangeProxy(const Proxy: string):Boolean;
var
  Reg: TRegistry;
  //Info: INTERNET_PROXY_INFO;
  Fproxy:string;
begin
try
  FProxy := Proxy;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings', True) then
    begin
      Reg.WriteString('ProxyServer', Fproxy);
      //Reg.WriteInteger('ProxyEnable', Integer(True));
      {
      Info.dwAccessType := INTERNET_OPEN_TYPE_PROXY;
      Info.lpszProxy := PChar(FProxy);
      Info.lpszProxyBypass := PChar('');
      InternetSetOption(nil, INTERNET_OPTION_PROXY, @Info, SizeOf(Info));
      InternetSetOption(nil, INTERNET_OPTION_SETTINGS_CHANGED, nil, 0);
      }
    end;
    Result:=true;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
except end;
end;

{
function EnableProxy:Boolean;
var
  Reg: TRegistry;
begin
try
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings', True) then
    begin
      Reg.WriteInteger('ProxyEnable', Integer(True));
    end;
    Result:=true;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
except end;
end;

function DisableProxy:Boolean;
var
  Reg: TRegistry;
begin
try
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings', True) then
    begin
      Reg.WriteInteger('ProxyEnable', Integer(false));
    end;
    Result:=true;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
except end;
end;
}

//禁用代理
function NotProxy:Boolean;
var
  Reg: TRegistry;
  Info: INTERNET_PROXY_INFO;
begin
try
  {
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings', True) then
    begin
      Reg.Writestring('ProxyServer', '');
      Reg.WriteInteger('ProxyEnable', Integer(False));
      Info.dwAccessType := INTERNET_OPEN_TYPE_DIRECT;
      Info.lpszProxy := nil;
      Info.lpszProxyBypass := nil;
      InternetSetOption(nil, INTERNET_OPTION_PROXY, @Info, SizeOf(Info));
      InternetSetOption(nil, INTERNET_OPTION_SETTINGS_CHANGED, nil, 0);
    end;
    Result:=true;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
  }
  Info.dwAccessType := INTERNET_OPEN_TYPE_DIRECT;
  Info.lpszProxy := nil;
  Info.lpszProxyBypass := nil;
  InternetSetOption(nil, INTERNET_OPTION_PROXY, @Info, SizeOf(Info));
  InternetSetOption(nil, INTERNET_OPTION_SETTINGS_CHANGED, nil, 0);
except end;
end;

//设置某个浏览器为默认浏览器
procedure SetBrowser(AppExeName:string;flag:integer=0);
var
  Reg:TRegistry;
  cmdStr:string;
  myArray:array[0..7] of Word;
  str1,str2:string;
  BrowserName2:string;
  ApplicationName:string;
  str:string;
begin
try
  case flag of
  0,1:
  begin
    ApplicationName:=AppExeName;
    BrowserName2:=BrowserName;
  end;
  2:
  begin
    //ApplicationName:='C:\Program Files\Internet Explorer\'+'iexplore.exe';
    str:=GetSystemFolderDir($0026);
    if Trim(str)<>'' then
    ApplicationName:=str+'\Internet Explorer\'+'iexplore.exe'
    else
    ApplicationName:='C:\Program Files'+'\Internet Explorer\'+'iexplore.exe';
    //ShowMessage(ApplicationName);
    if not FileExists(ApplicationName) then
    begin
      //ShowMessage('设置失败！');
      exit;
    end;
    BrowserName2:='ie';
  end;
  else
  begin
    ApplicationName:=AppExeName;
    BrowserName2:=BrowserName;
  end;
  end;

  cmdStr:='"'+ApplicationName+'" "%1"';

  myArray[0] := $00;
  myArray[1] := $46;
  myArray[2] := $73;
  myArray[3] := $48;
  myArray[4] := $a2;
  myArray[5] := $56;
  myArray[6] := $c2;
  myArray[7] := $01;
  //cmdStr := '"'+Application.ExeName+'" "%1"';

  Reg:=TRegistry.Create;
  try
    Reg.RootKey:=HKEY_CLASSES_ROOT;

    Reg.OpenKey('Applications\'+BrowserName2+'.exe\shell\',True);
    Reg.WriteString('',BrowserName2);
    Reg.WriteString('FriendlyCache', BrowserName2);
    Reg.WriteBinaryData('FriendlyCacheCTime',myArray, 8);
    Reg.CloseKey;
    Reg.OpenKey('Applications\'+BrowserName2+'.exe\shell\'+BrowserName2+'\command\', True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;

    Reg.OpenKey('file\shell\',True);
    Reg.WriteString('',BrowserName2);
    Reg.CloseKey;
    Reg.OpenKey('file\shell\'+BrowserName2+'\command\',True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;
    Reg.OpenKey('file\shell\open\command\',True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;

    Reg.OpenKey('ftp\shell\',True);
    Reg.WriteString('',BrowserName2);
    Reg.CloseKey;
    Reg.OpenKey('ftp\shell\'+BrowserName2+'\command\',True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;
    Reg.OpenKey('ftp\shell\open\command\',True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;

    Reg.OpenKey('htmlfile\shell\', True);
    Reg.WriteString('', BrowserName2);
    Reg.CloseKey;
    Reg.OpenKey('htmlfile\shell\'+BrowserName2+'\command\', True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;
    Reg.OpenKey('htmlfile\shell\open\command\',True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;

    Reg.OpenKey('http\shell\',True);
    Reg.WriteString('',BrowserName2);
    Reg.CloseKey;
    Reg.OpenKey('http\shell\'+BrowserName2+'\command\',True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;
    Reg.OpenKey('http\shell\open\command\',True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;

    Reg.OpenKey('https\shell\',True);
    Reg.WriteString('',BrowserName2);
    Reg.CloseKey;
    Reg.OpenKey('https\shell\'+BrowserName2+'\command\',True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;
    Reg.OpenKey('https\shell\open\command\',True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;

    Reg.OpenKey('InternetShortcut\shell\',True);
    Reg.WriteString('',BrowserName2);
    Reg.CloseKey;
    Reg.OpenKey('InternetShortcut\shell\'+BrowserName2+'\command\',True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;
    Reg.OpenKey('InternetShortcut\shell\open\command\', True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;
  finally
    Reg.Free;
  end;
except end;
end;

{
procedure UpdateReg(Str:string;Remove: Boolean);    
const  Key = 'Software\Microsoft\Windows\CurrentVersion\Uninstall\EnjoyIE';begin  with TRegistry.Create do  try    RootKey := HKEY_LOCAL_MACHINE;    if Remove then DeleteKey(Key) else      if OpenKey(Key, True) then      begin        WriteString('DisplayName',BrowserName+'浏览器');        WriteString('UninstallString', Str + ' /u');      end;  finally    Free;  end;end;

procedure Uninstall(Str:string);
begin
try                       
    //Application.ShowMainForm:=false;
    UpdateReg(Str,true);
    //WritePrivateProfileString('RunData','Uninstall','1',PChar(WinDir+ToSysConfigFile));
    MessageBox(0,TitleStr+'已经成功卸载!','卸载成功.',0);  //exit;
    try
      DeleteDirFile(ExtractFilePath(Str));
      DeleteDir(ExtractFilePath(Str));
    finally
    DeleteMe;
    KillProcess(PChar(Str));
    Halt;
    //Application.Terminate;
    //exit;
    end;
except end;
end;
}

//IE类开始
function DelRegCache:Boolean;
var
  reg:TRegistry;
begin
try
  try
  reg:=Tregistry.create;
  reg.RootKey:=HKEY_CURRENT_USER;
  reg.DeleteKey('Software\Microsoft\Internet Explorer\TypedURLs');
  finally
   reg.Free;
  end;
  Result:=true;
except end;
end;

function GetCookiesFolder:string;
var
  pidl:pItemIDList;
  buffer:array [ 0..255 ] of char ;
begin
try
  SHGetSpecialFolderLocation(Application.Handle , CSIDL_COOKIES, pidl);

  SHGetPathFromIDList(pidl, buffer);
  result:=strpas(buffer);
except end;
end;

function ShellDeleteFile(sFileName: string): Boolean;
var
  FOS: TSHFileOpStruct;
begin
try
   FillChar(FOS, SizeOf(FOS), 0); //记录清零
   with FOS do
   begin
       wFunc := FO_DELETE;//删除
       pFrom := PChar(sFileName);
       fFlags := FOF_NOCONFIRMATION;
   end;
   Result := (SHFileOperation(FOS) = 0);
except end;
end;

function DelCookie:Boolean;
var
  dir:string;
begin
try
   InternetSetOption(nil, INTERNET_OPTION_END_BROWSER_SESSION, nil, 0);
   dir:=GetCookiesFolder;
   ShellDeleteFile(dir+'\*.txt');
except end;
end;

//{
function DelHistory:Boolean;
var
  lpEntryInfo: PInternetCacheEntryInfo;
  hCacheDir: LongWord ;
  dwEntrySize, dwLastError: LongWord;
begin
try
   dwEntrySize := 0;
   FindFirstUrlCacheEntry(nil, TInternetCacheEntryInfo(nil^), dwEntrySize);
   GetMem(lpEntryInfo, dwEntrySize);

   hCacheDir := FindFirstUrlCacheEntry(nil, lpEntryInfo^, dwEntrySize);
   if hCacheDir <> 0 then
      DeleteUrlCacheEntry(lpEntryInfo^.lpszSourceUrlName);
   FreeMem(lpEntryInfo);

   repeat
     dwEntrySize := 0;
     FindNextUrlCacheEntry(hCacheDir, TInternetCacheEntryInfo(nil^),
       dwEntrySize);
     dwLastError := GetLastError();
     if dwLastError = ERROR_INSUFFICIENT_BUFFER then //如果成功
     begin
         GetMem(lpEntryInfo, dwEntrySize); //分配dwEntrySize字节的内存
         if FindNextUrlCacheEntry(hCacheDir, lpEntryInfo^, dwEntrySize) then
            DeleteUrlCacheEntry(lpEntryInfo^.lpszSourceUrlName);
         FreeMem(lpEntryInfo);
     end;
  until (dwLastError = ERROR_NO_MORE_ITEMS);
except end;
end;
//}

{
function CreateIntShotCut(FileName,URL:PChar):Boolean;
var
  IURL: IUniformResourceLocator;
　PersistFile: IPersistfile;
begin
  try
  if Succeeded(CoCreateInstance(CLSID_InternetShortcut,
　　　　　　　　　　　　　　　　　　　　nil,
　　　　　　　　　　　　　　　　　　　　CLSCTX_INPROC_SERVER,
　　　　　　　　　　　　　　　　　　　　IID_IUniformResourceLocator,
　　　　　　　　　　　　　　　　　　　　IURL)) then
　begin
　　IUrl.SetURL(aURL, 0);
　　Persistfile := IUrl as IPersistFile;
　　PersistFile.Save(StringToOleStr(aFileName), False);
　end;
  Result:=true;
except end;
end;
}
//IE类结束

//======================================================================
{
function KeyboardHookHandler(iCode:Integer;WParam:WPARAM;lParam:LPARAM):LRESULT;stdcall;
var
  pt:TPoint;
  hwnd:THandle;
  r:TRect;
begin
try
  Result:=0;
  if iCode <0 then
  begin
    Result:=CallNextHookEx(hNextHookProc,iCode,wParam,lParam);
    Exit;
  end;
  //if (wParam=WM_LBUTTONDOWN) or (wParam=WM_NCLBUTTONDOWN) then
  //if (wParam=WM_LBUTTONDOWN) or (wParam=WM_RBUTTONDOWN) then
  if (wParam=WM_LBUTTONDOWN) then
  begin
    GetCursorPos(pt);
    hwnd:=WindowFromPoint(pt);

    GetWindowRect(TOPMainForm.Handle,r);
    if ptInRect(r,pt) then
    begin
      ThreadI:=97;
      RunProcess.Create(False);
    end;

    if IsChild(TOPMainForm.Handle,Msg.Hwnd) then
    begin
      //handled:=True;
      ThreadI:=97;
      RunProcess.Create(False);
    end;
  end;
except end;
end;

function EnableHotKeyHook:Boolean;
begin
try
  Result:=False;
  if hNextHookProc <> 0 then exit;
  hNextHookProc:=SetWindowsHookEx(WH_MOUSE,KeyboardHookHandler,hInstance,0);
  //hNextHookProc:=SetWindowsHookEx(WH_KEYBOARD,KeyboardHookHandler,Hinstance,0);
  Result:=hNextHookProc <>0 ;
except end;
end;

function DisableHotKeyHook:Boolean;
begin
try
  if hNextHookPRoc <> 0 then
  begin
    UnhookWindowshookEx(hNextHookProc);
    hNextHookProc:=0;
    //Messagebeep(0);
    Messagebeep(0);
  end;
  Result:=hNextHookPRoc=0;
except end;
end;

procedure HotKeyHookExit;
begin
try
  if hNextHookProc <> 0 then DisableHotKeyHook;
  ExitProc:=procSaveExit;
except end;
end;
}

{
initialization
begin
try
  MessageBox(0,'OK.','OK:',0);
except end;
end;

begin
try

except end;
end;

finalization
begin
try
  MessageBox(0,'End.','',0);
except end;
end;
}

end.

//*********************************************************//
{
//综合
//WritePrivateProfileString('Windows','run',PChar(Application.ExeName),PChar('C:\Windows.bat'));
//WritePrivateProfileString('RunData','OldFormWidth',PChar(application.exename),PChar(MyDir+ConfigFile));
//MyDir:=ExtractFilePath(ParamStr(0));
//if MyDir[Length(MyDir)]<>'\' then MyDir:=MyDir+'\';
//SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW); //不在任务栏上创建图标　　
//SetWindowLong(Handle,GWL_STYLE,Getwindowlong(handle,GWL_STYLE) and not WS_CAPTION);//不显示标题栏
//SetWindowPos(form2.Handle,HWND_TOPMOST,0,0,0,0,SWP_NOSIZE);
//if not hideform.Active then hideform.SetFocus;
//if Win32Platform=VER_PLATFORM_WIN32_NT then
//PostMessage(WebBrowser1.Handle,WM_LBUTTONDOWN,1,1);
//PostMessage(WebBrowser1.Handle,WM_LBUTTONUP,1,1);
//SendMessage(Panel4.Handle,BM_Click,0,0);
//if MessageBox(Handle,'TOP目前不是默认浏览器,想把TOP设置为默认浏览器吗？','询问',MB_YESNO+MB_ICONINFORMATION)=ID_NO then

//FileOpen(FormPassDialog.TempFileName, fmShareExclusive); //不允许复制删除等
//if MessageDlg('确实要关机吗？',mtconfirmation,[mbyes,mbno],0)=mryes then//

  //var Msg: TMsg;
  //while GetMessage(Msg, 0, 0, 0) do ; 
}
{
procedure AddHotKey(Sender:TObject);
procedure WMHotKey(var Msg: TWMHotKey); Message WM_HOTKEY;

procedure TMainForm.AddHotkey(Sender:TObject);
begin
  RegisterHotKey(Handle,125, MOD_CONTROL + MOD_ALT, $58);  //Ctrl+Alt+x
end;

procedure TMainForm.WMHotkey(var Msg: TWMHotKey);
begin
  if Msg.HotKey=125 then
end;
}
{
var
  P:TPoint;
begin
try
  GetCursorPos(P);
  PopupMenu.Popup(P.X,P.Y);
Except end;
end;
}

{
var
  FileName:string;
  s:integer;
  FileExt:string;
begin
try
  FileName:=ExtractFileName(ParamStr(0));
  FileName:=Copy(FileName,1,Pos('.',FileName)-1);
  //s:=Pos('.',FileName);
  //if s>0 then SetLength(FileName,s-1);
  //FileExt:=ExtractFileExt(FileName);
  //Delete(FileName, Length(FileName) - Length(FileExt)+1, Length(FileExt));
  ShowMessage(FileName);
except end;
end;
}

{
//关闭一进程
var
  f1,f2,f3:LongInt;
begin
  f1:=FindWindow(PChar('RavMonClass'),PChar('RavMon.exe'));//得到瑞星窗体
  GetWindowThreadProcessId(f1, @f2);  //得到进程句柄
  f3:=OpenProcess(PROCESS_ALL_ACCESS,True,f2);  //以最高权限打开
  TerminateProcess(f3,0);   //关闭
end;
}

{
//屏蔽ALT+F4键
procedure TForm1.FormKeyDown(Sender:TObject;var Key:Word;Shift:TShiftState);
begin
  if((Key=VK_F4) AND (ssAlt in  Shift)) then Key:=0;
  inherited;
end;
}

{
//操作文本文件
const TempFile='Temp.~txt'
var
  MyDir:String;
  Str:string;
  TxtFile:TextFile;
begin
try
  MyDir:=ExtractFilePath(ParamStr(0));
  if MyDir[Length(MyDir)]<>'\' then MyDir:=MyDir+'\';
  if FileExists(MyDir+TempFile)then
  begin
    AssignFile(TxtFile,MyDir+TempFile);
    ReSet(TxtFile);    //Append(TxtFile);
    WriteLn(TxtFile,Str);
    CloseFile(TxtFile);
  end
  else
  begin
    AssignFile(TxtFile,MyDir+TempFile);
    ReWrite(TxtFile);
    CloseFile(TxtFile);
  end;
except end;
end;
}

{
//截获窗体最小化消息并处理
procedure WMSysCommand(var Msg:TMessage);Message WM_SYSCOMMAND;
procedure TMainForm.WMSyscommand(var Msg:TMessage);
var
  PlaceMent:WINDOWPLACEMENT;
begin
try
   if msg.WParam=SC_MINIMIZE Then
   begin
     Application.Minimize;
     Sleep(200);
     Self.Hide;
   end;
   inherited;
except end;
end;
}

{
procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  MusicStrLst:TstringList;
  i:integer;
begin
try
  if FileExists(ExtractFilePath(ParamStr(0))+HistoryFileName) then
    DeleteFile(ExtractFilePath(ParamStr(0))+HistoryFileName);
  MusicStrLst:=Tstringlist.Create;
  for i:=0 to EURL.Items.Count-1 do
  begin
    MusicStrLst.Add(EURL.Items[i]);
  end;
  MusicStrLst.SaveToFile(ExtractFilePath(ParamStr(0))+HistoryFileName);
  MusicStrLst.Destroy;
except end;
end;
}

{
Procedure TMainForm.LoadAll(Sender:TObject);
var
  TxtFile:TextFile;
  Str:string;
begin
try
if FileExists(ExtractFilePath(ParamStr(0))+HistoryFileName) then
  begin
    AssignFile(TxtFile,ExtractFilePath(ParamStr(0))+HistoryFileName);
    ReSet(TxtFile);
    try
      while not Eof(TxtFile)do
      begin
        ReadLn(TxtFile,Str);
        EURL.Items.Add(Str);
      end;
    finally
      CloseFile(TxtFile);
    end;
  end;
except end;
end;
}

{
procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES; //文件拖放


procedure TMainForm.WMDropFiles(var Msg: TWMDropFiles); //文件拖放
var
  CFileName: array[0..MAX_PATH] of Char;
begin
try
  try
    if DragQueryFile(Msg.Drop, 0, CFileName, MAX_PATH) > 0 then
      begin
        if FileExists(CFileName) then
        begin
          ListForm.ListBox.Items.Add(CFileName);
          PlayMusic(CFileName);
        end;
      end;
  finally
    DragFinish(Msg.Drop);
  end;
except end;
end;

DragAcceptFiles(Handle, True); {接收文件拖放}
}

{
procedure LoadDLL;
var
  Res:TReSourceStream;
  WinDir:string;
begin
try
  try
  WinDir:=GetWinDir;
  Res:=TResourceStream.create(Hinstance,'wmpdll',PChar('dll'));
  Res.SaveToFile(WinDir+'wmp.dll');
  Res.free;
  end;
except end;
end;
}

{
  AssignFile(f,OpenDialog1.FileName);
  Reset(f,1);
  fs := FileSize(f);
  GetMem(p, fs);
  BlockRead(f, p^, fs);
  CloseFile(f);
}
{
 SwapMouseButton(True);//来改变鼠标左右键操作
  SwapMouseButton(False);//还原
}
//        login   http://www.cnlogin.com  2005-2008
//*********************************************************//

