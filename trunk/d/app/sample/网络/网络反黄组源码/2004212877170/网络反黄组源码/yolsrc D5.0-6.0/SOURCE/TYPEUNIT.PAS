unit typeunit;
{********************************************
 *  本模块的功能：定义全局变量并进行初始化  *
 *  日期：2001.2.16         作者：Kingron   *
 *  版本：0.0.1             更新：2001.2.16 *
 ********************************************}

interface

uses windows,Sysutils, Classes;

const
  MAX_DISPLAY=5;         //显示的注册表的项目的个数
  MAX_NETWORK=5;         //网络控制面板的注册表的个数
  MAX_SYSTEM=8;          //系统的限制的个数
  MAX_PRINTER=3;         //打印机
  MAX_SHELLFOLDER=18;
  MAX_SHELLFOLDER2=12;
  MAX_EXPLORER=13;
  MAX_STARTMENU=12;
  MAX_LIMIT=3;
  MAX_PASSWORD=3;
  MAX_IECONTROL=10;
  MAX_IECP=18;
  MAX_MSDOS=15;
  MAX_BOOTAUTORUN=8;

type
  TRegDataType=(rdtString,rdtDword,rdtBin);  //定义注册表的数据类型

type
  TRegInfo=packed record               //定义使用的注册表数据结构
    Key:string;                 //主键
    Name:string;                //键名
    Value:string;               //保存字符串类型的数据值
    RootKey:Hkey;               //根键
    DataType:TRegDataType;      //数据类型
    DataSize:integer;           //数据大小，仅对rdtBin类型起作用
    Modify:boolean;             //是否修改的标志
  end;

type
  TShellFolder=packed record
    RootKey:hkey;
    Key:string;
    Name:string;
    Caption:string;
  end;
{
type
  TIEToolBarInfo=packed record
    RootKey:hkey;
    Key:string;
    ButtonText:string;
    CLSID:string;
    DefaultVisible:string;
    Exec:string;
    HotIcon:string;
    Icon:string;
    MenuStatusBar:string;
    MenuText:string;
    Script:string;
  end;
}

const       //定义初始化的数据，主要是注册表的位置
  s_SystemKey='Software\Microsoft\Windows\CurrentVersion\Policies\system';
  s_ExplorerKey='Software\Microsoft\Windows\CurrentVersion\Policies\Explorer';
  s_WinOldAPPKey='Software\Microsoft\Windows\CurrentVersion\Policies\WinOldAPP';
  s_NetworkKey='Software\Microsoft\Windows\CurrentVersion\Policies\NetWork';
  s_SpecialFolderKey='Software\Microsoft\Windows\CurrentVersion\Explorer';
  s_NoDispCPL='NoDispCPL';
  s_AutoRunKey=s_ExplorerKey;
  s_HideDriverKey=s_ExplorerKey;

var
  DisplayRegInfo:array[0..MAX_DISPLAY-1] of treginfo; //显示限制
  NetworkRegInfo:array[0..MAX_NETWORK-1] of treginfo; //网络限制
  SystemRegInfo:array[0..MAX_SYSTEM-1] of treginfo;   //系统
  PrinterRegInfo:array[0..MAX_PRINTER-1] of treginfo; //打印机
  ControlRegInfo:tstrings;                //控制面板
  AutoRunReginfo:treginfo;
  HideDriverRegInfo:treginfo;
  DriverMenuRegInfo:treginfo;
  SpecialFolderRegInfo:array[0..MAX_SHELLFOLDER-1] of tshellfolder;
  SpecialFolderRegInfo2:array[0..MAX_SHELLFOLDER2-1] of tshellfolder;
  StartMenuRegInfo:array[0..MAX_STARTMENU-1] of treginfo;
  ExplorerRegInfo:array[0..MAX_EXPLORER-1] of treginfo;
  DiskSpaceRegInfo:treginfo;
  LimitReginfo:array[0..MAX_LIMIT-1] of treginfo;
  PasswordRegInfo:array[0..MAX_PASSWORD-1] of treginfo;
  LimitRunRegInfo:treginfo;
  MinPwdLenRegInfo:treginfo;
  LoginInfoRegInfo:treginfo;
  IEControlRegInfo:array [0..MAX_IECONTROL-1] of treginfo;
  IECPRegInfo:array [0..MAX_IECP-1] of treginfo;
  MsdosInfo:array [0..MAX_MSDOS-1] of string;
  BootAutoRunRegInfo:array[0..MAX_BOOTAUTORUN-1] of treginfo;

implementation

var
  i:integer;              //私有变量，用于循环计数

initialization            //初始化
  ControlRegInfo:=TStringList.Create;
  for i:=low(DisplayRegInfo) to High(DisplayRegInfo) do
  begin
    DisplayRegInfo[i].Modify:=false;
    DisplayRegInfo[i].Key:=s_SystemKey;
    DisplayRegInfo[i].RootKey:=HKEY_CURRENT_USER;
  end;
  for i:=low(NetworkRegInfo) to High(NetworkRegInfo) do
  begin
    NetworkRegInfo[i].Modify:=false;
    NetworkRegInfo[i].Key:=s_NetworkKey;
    NetworkRegInfo[i].RootKey:=HKEY_CURRENT_USER;
  end;
  for i:=low(SystemRegInfo) to High(SystemRegInfo) do
  begin
    SystemRegInfo[i].Modify:=false;
    SystemRegInfo[i].Key:=s_SystemKey;
    SystemRegInfo[i].RootKey:=HKEY_CURRENT_USER;
  end;
  for i:=low(PrinterRegInfo) to high(PrinterRegInfo) do
  begin
    PrinterRegInfo[i].Modify:=false;
    PrinterRegInfo[i].Key:=s_ExplorerKey;
    PrinterRegInfo[i].RootKey:=HKEY_CURRENT_USER;
  end;

  for i:=low(ExplorerRegInfo) to high(ExplorerRegInfo) do
  begin
    ExplorerRegInfo[i].Modify:=false;
    ExplorerRegInfo[i].RootKey:=HKEY_CURRENT_USER;
    ExplorerRegInfo[i].Value:='1';
  end;

  for i:=low(StartMenuRegInfo) to high(StartMenuRegInfo) do
  begin
    StartMenuRegInfo[i].Modify:=false;
    StartMenuRegInfo[i].Key:=s_ExplorerKey;
    StartMenuRegInfo[i].DataType:=rdtdword;
    StartMenuRegInfo[i].RootKey:=HKEY_CURRENT_USER;
    StartMenuRegInfo[i].Value:='1';
  end;

  for i:=low(IEControlRegInfo) to high(IEControlRegInfo) do
  begin
    IEControlRegInfo[i].Modify:=false;
    IEControlRegInfo[i].Key:='SoftWare\Policies\MicroSoft\Internet Explorer\Restrictions';
    IEControlRegInfo[i].DataType:=rdtdword;
    IEControlRegInfo[i].RootKey:=HKEY_CURRENT_USER;
    IEControlRegInfo[i].Value:='1';
  end;

  for i:=low(IECPRegInfo) to high(IECPRegInfo) do
  begin
    IECPRegInfo[i].Modify:=false;
    IECPRegInfo[i].Key:='SoftWare\Policies\MicroSoft\Internet Explorer\Control Panel';
    IECPRegInfo[i].DataType:=rdtdword;
    IECPRegInfo[i].RootKey:=HKEY_CURRENT_USER;
    IECPRegInfo[i].Value:='1';
  end;

  BootAutoRunRegInfo[0].RootKey:=HKEY_LOCAL_MACHINE;
  BootAutoRunRegInfo[0].Key:='Software\Microsoft\Windows\CurrentVersion\Run';
  BootAutoRunRegInfo[1].RootKey:=HKEY_LOCAL_MACHINE;
  BootAutoRunRegInfo[1].Key:='Software\Microsoft\Windows\CurrentVersion\RunOnce';
  BootAutoRunRegInfo[2].RootKey:=HKEY_LOCAL_MACHINE;
  BootAutoRunRegInfo[2].Key:='Software\Microsoft\Windows\CurrentVersion\RunServices';
  BootAutoRunRegInfo[3].RootKey:=HKEY_LOCAL_MACHINE;
  BootAutoRunRegInfo[3].Key:='Software\Microsoft\Windows\CurrentVersion\RunOnceServices';
  BootAutoRunRegInfo[4].RootKey:=HKEY_CURRENT_USER;
  BootAutoRunRegInfo[4].Key:='Software\Microsoft\Windows\CurrentVersion\Run';
  BootAutoRunRegInfo[5].RootKey:=HKEY_CURRENT_USER;
  BootAutoRunRegInfo[5].Key:='Software\Microsoft\Windows\CurrentVersion\RunOnce';
  BootAutoRunRegInfo[6].RootKey:=HKEY_CURRENT_USER;
  BootAutoRunRegInfo[6].Key:='Software\Microsoft\Windows\CurrentVersion\RunServices';
  BootAutoRunRegInfo[7].RootKey:=HKEY_CURRENT_USER;
  BootAutoRunRegInfo[7].Key:='Software\Microsoft\Windows\CurrentVersion\RunOnceServices';

  MsdosInfo[0]:='BootMulti';
  MsdosInfo[1]:='BootGUI';
  MsdosInfo[2]:='DoubleBuffer';
  MsdosInfo[3]:='AutoScan';
  MsdosInfo[4]:='BootWin';
  MsdosInfo[5]:='DrvSpace';
  MsdosInfo[6]:='DblSpace';
  MsdosInfo[7]:='LOGO';
  MsdosInfo[8]:='DisableLog';
  MsdosInfo[9]:='BootWarn';
  MsdosInfo[10]:='LoadTop';
  MsdosInfo[11]:='BootSafe';
  MsdosInfo[12]:='BootKeys';
  MsdosInfo[13]:='BootMenu';
  MsdosInfo[14]:='NetWork';

  IECPRegInfo[0].Name:='Advanced';
  IECPRegInfo[1].Name:='Cache';
  IECPRegInfo[2].Name:='AutoConfig';
  IECPRegInfo[3].Name:='Wallet';
  IECPRegInfo[4].Name:='Proxy';
  IECPRegInfo[5].Name:='Languages';
  IECPRegInfo[6].Name:='Links';
  IECPRegInfo[7].Name:='HomePage';
  IECPRegInfo[8].Name:='History';
  IECPRegInfo[9].Name:='Fonts';
  IECPRegInfo[10].Name:='Connection Wizard';
  IECPRegInfo[11].Name:='Connection Settings';
  IECPRegInfo[12].Name:='Colors';
  IECPRegInfo[13].Name:='Check_If_Default';
  IECPRegInfo[14].Name:='Certificates';
  IECPRegInfo[15].Name:='CalendarContact';
  IECPRegInfo[16].Name:='Ratings';
  IECPRegInfo[17].Name:='Profiles';

  IEControlRegInfo[0].Name:='NoBrowserClose';
  IEControlRegInfo[1].Name:='NoBrowserContextMenu';
  IEControlRegInfo[2].Name:='NoBrowserOptions';
  IEControlRegInfo[3].Name:='NoBrowserSaveAs';
  IEControlRegInfo[4].Name:='NoFavorites';
  IEControlRegInfo[5].Name:='NoFileNew';
  IEControlRegInfo[6].Name:='NoFileOpen';
  IEControlRegInfo[7].Name:='NoFindFiles';
  IEControlRegInfo[8].Name:='NoSelectDownloadDir';
  IEControlRegInfo[9].Name:='NoTheaterMode';

  LoginInfoRegInfo.RootKey:=HKEY_LOCAL_MACHINE;
  LoginInfoRegInfo.Key:='Software\Microsoft\Windows\CurrentVersion\Winlogon';
  LoginInfoRegInfo.Name:='LegalNoticeCaption';
  LoginInfoRegInfo.Value:='LegalNoticeText';

  MinPwdLenRegInfo.RootKey:=HKEY_LOCAL_MACHINE;
  MinPwdLenRegInfo.Key:=s_NetworkKey;
  MinPwdLenRegInfo.Name:='MinPwdLen';

  LimitRunRegInfo.Key:=s_ExplorerKey;
  LimitRunRegInfo.RootKey:=HKEY_CURRENT_USER;
  LimitRunRegInfo.Name:='RestrictRun';

  DiskSpaceRegInfo.Key:='System\CurrentControlSet\Control\FileSystem';
  DiskSpaceRegInfo.RootKey:=HKEY_LOCAL_MACHINE;
  DiskSpaceRegInfo.Name:='DisableLowDiskSpaceBroadcast';

  StartMenuRegInfo[0].Name:='NoChangeStartMenu';
  StartMenuRegInfo[1].Name:='NoClose';
  StartMenuRegInfo[2].Name:='NoLogOff';
  StartMenuRegInfo[2].DataType:=rdtbin;
  StartMenuRegInfo[3].Name:='NoFind';
  StartMenuRegInfo[3].DataType:=rdtbin;
  StartMenuRegInfo[4].Name:='NoSettaskBar';
  StartMenuRegInfo[5].Name:='NoFolderOptions';
  StartMenuRegInfo[5].DataType:=rdtbin;
  StartMenuRegInfo[6].Name:='NoRecentDocsMenu';
  StartMenuRegInfo[7].Name:='NoFavoritesMenu';
  StartMenuRegInfo[8].Name:='NoDevMgrUpdate';
  StartMenuRegInfo[9].Name:='NoRecentDocsHistory';
  StartMenuRegInfo[9].DataType:=rdtbin;
  StartMenuRegInfo[10].Name:='NoRun';
  StartMenuRegInfo[11].Name:='NoStartBanner';

  ExplorerRegInfo[0].Name:='NoEntireNetWork';
  ExplorerRegInfo[0].Key:=s_NetworkKey;
  ExplorerRegInfo[0].DataType:=rdtdword;
  ExplorerRegInfo[0].Value:='1';

  ExplorerRegInfo[1].Name:='NoWorkgroupContents';
  ExplorerRegInfo[1].Key:=s_NetworkKey;
  ExplorerRegInfo[1].DataType:=rdtdword;
  ExplorerRegInfo[1].Value:='1';

  ExplorerRegInfo[2].Name:='NoTrayContextMenu';
  ExplorerRegInfo[2].Key:=s_ExplorerKey;
  ExplorerRegInfo[2].DataType:=rdtdword;
  ExplorerRegInfo[2].Value:='1';

  ExplorerRegInfo[3].Name:='NoViewContextMenu';
  ExplorerRegInfo[3].Key:=s_ExplorerKey;
  ExplorerRegInfo[3].DataType:=rdtdword;
  ExplorerRegInfo[3].Value:='1';

  ExplorerRegInfo[4].Name:='ClearRecentDocsOnExit';
  ExplorerRegInfo[4].Key:=s_ExplorerKey;
  ExplorerRegInfo[4].DataType:=rdtbin;
  ExplorerRegInfo[4].Value:='1';

  ExplorerRegInfo[5].Name:='SmallIcons';
  ExplorerRegInfo[5].Key:='Software\Microsoft\Windows\CurrentVersion\Explorer\SmallIcons';
  ExplorerRegInfo[5].DataType:=rdtstring;
  ExplorerRegInfo[5].Value:='yes';

  ExplorerRegInfo[6].Name:='PaintDesktopVersion';
  ExplorerRegInfo[6].Key:='Control Panel\Desktop';
  ExplorerRegInfo[6].DataType:=rdtstring;
  ExplorerRegInfo[6].Value:='1';

  ExplorerRegInfo[7].Name:='DesktopProcess';
  ExplorerRegInfo[7].Key:='Software\Microsoft\Windows\CurrentVersion\Explorer';
  ExplorerRegInfo[7].DataType:=rdtdword;
  ExplorerRegInfo[7].Value:='1';

  ExplorerRegInfo[8].Name:='Beep';
  ExplorerRegInfo[8].Key:='Control Panel\Sound';
  ExplorerRegInfo[8].DataType:=rdtstring;
  ExplorerRegInfo[8].Value:='yes';

  ExplorerRegInfo[9].Name:='LinkResolveIgnoreLinkInfo';
  ExplorerRegInfo[9].Key:=s_ExplorerKey;
  ExplorerRegInfo[9].DataType:=rdtDword;
  ExplorerRegInfo[9].Value:='1';

  ExplorerRegInfo[10].Name:='NoFileMenu';
  ExplorerRegInfo[10].Key:=s_ExplorerKey;
  ExplorerRegInfo[10].DataType:=rdtDword;
  ExplorerRegInfo[10].Value:='1';

  ExplorerRegInfo[11].Name:='NoDesktop';
  ExplorerRegInfo[11].Key:=s_ExplorerKey;
  ExplorerRegInfo[11].DataType:=rdtDword;
  ExplorerRegInfo[11].Value:='1';

  ExplorerRegInfo[12].Name:='NoSaveSettings';
  ExplorerRegInfo[12].Key:=s_ExplorerKey;
  ExplorerRegInfo[12].DataType:=rdtDword;
  ExplorerRegInfo[12].Value:='1';

  PasswordRegInfo[0].Name:='AlphaNumPwds';
  PasswordRegInfo[0].RootKey:=HKEY_LOCAL_MACHINE;
  PasswordRegInfo[0].Key:='Software\Microsoft\Windows\CurrentVersion\Policies\Network';
  PasswordRegInfo[0].DataType:=rdtDword;
  PasswordRegInfo[0].Value:='1';

  PasswordRegInfo[1].Name:='DisablePwdCaching';
  PasswordRegInfo[1].RootKey:=HKEY_LOCAL_MACHINE;
  PasswordRegInfo[1].Key:='Software\Microsoft\Windows\CurrentVersion\Policies\Network';
  PasswordRegInfo[1].DataType:=rdtDword;
  PasswordRegInfo[1].Value:='1';

  PasswordRegInfo[2].Name:='HideSharePwds';
  PasswordRegInfo[2].RootKey:=HKEY_LOCAL_MACHINE;
  PasswordRegInfo[2].Key:='Software\Microsoft\Windows\CurrentVersion\Policies\Network';
  PasswordRegInfo[2].DataType:=rdtDword;
  PasswordRegInfo[2].Value:='1';
  
  SpecialFolderRegInfo2[0].Name:='CommonFilesDir';
  SpecialFolderRegInfo2[0].RootKey:=HKEY_LOCAL_MACHINE;
  SpecialFolderRegInfo2[0].Key:='Software\Microsoft\Windows\CurrentVersion';
  SpecialFolderRegInfo2[0].Caption:='公共文件夹';

  SpecialFolderRegInfo2[1].Name:='ConfigPath';
  SpecialFolderRegInfo2[1].RootKey:=HKEY_LOCAL_MACHINE;
  SpecialFolderRegInfo2[1].Key:='Software\Microsoft\Windows\CurrentVersion';
  SpecialFolderRegInfo2[1].Caption:='配置文件夹';

  SpecialFolderRegInfo2[2].Name:='DevicePath';
  SpecialFolderRegInfo2[2].RootKey:=HKEY_LOCAL_MACHINE;
  SpecialFolderRegInfo2[2].Key:='Software\Microsoft\Windows\CurrentVersion';
  SpecialFolderRegInfo2[2].Caption:='驱动程序信息文件文件夹';

  SpecialFolderRegInfo2[3].Name:='MediaPath';
  SpecialFolderRegInfo2[3].RootKey:=HKEY_LOCAL_MACHINE;
  SpecialFolderRegInfo2[3].Key:='Software\Microsoft\Windows\CurrentVersion';
  SpecialFolderRegInfo2[3].Caption:='多媒体文件夹';

  SpecialFolderRegInfo2[4].Name:='OtherDevicePath';
  SpecialFolderRegInfo2[4].RootKey:=HKEY_LOCAL_MACHINE;
  SpecialFolderRegInfo2[4].Key:='Software\Microsoft\Windows\CurrentVersion';
  SpecialFolderRegInfo2[4].Caption:='未知设备驱动程序文件夹';

  SpecialFolderRegInfo2[5].Name:='WallPaperDir';
  SpecialFolderRegInfo2[5].RootKey:=HKEY_LOCAL_MACHINE;
  SpecialFolderRegInfo2[5].Key:='Software\Microsoft\Windows\CurrentVersion';
  SpecialFolderRegInfo2[5].Caption:='活动桌面墙纸文件夹';

  SpecialFolderRegInfo2[6].Name:='TMP';
  SpecialFolderRegInfo2[6].RootKey:=HKEY_LOCAL_MACHINE;
  SpecialFolderRegInfo2[6].Key:='Software\Microsoft\Windows\CurrentVersion';
  SpecialFolderRegInfo2[6].Caption:='临时文件夹';

  SpecialFolderRegInfo2[7].Name:='SourcePath';
  SpecialFolderRegInfo2[7].RootKey:=HKEY_LOCAL_MACHINE;
  SpecialFolderRegInfo2[7].Key:='Software\Microsoft\Windows\CurrentVersion\Setup';
  SpecialFolderRegInfo2[7].Caption:='Windows安装文件目录';

  SpecialFolderRegInfo2[8].Name:='ICMPath';
  SpecialFolderRegInfo2[8].RootKey:=HKEY_LOCAL_MACHINE;
  SpecialFolderRegInfo2[8].Key:='Software\Microsoft\Windows\CurrentVersion\Setup';
  SpecialFolderRegInfo2[8].Caption:='显示器色彩配置目录';

  SpecialFolderRegInfo2[9].Name:='SysDir';
  SpecialFolderRegInfo2[9].RootKey:=HKEY_LOCAL_MACHINE;
  SpecialFolderRegInfo2[9].Key:='Software\Microsoft\Windows\CurrentVersion\Setup';
  SpecialFolderRegInfo2[9].Caption:='系统库文件目录';

  SpecialFolderRegInfo2[10].Name:='SharedDir';
  SpecialFolderRegInfo2[10].RootKey:=HKEY_LOCAL_MACHINE;
  SpecialFolderRegInfo2[10].Key:='Software\Microsoft\Windows\CurrentVersion\Setup';
  SpecialFolderRegInfo2[10].Caption:='共享目录';

  SpecialFolderRegInfo2[11].Name:='OldWinDir';
  SpecialFolderRegInfo2[11].RootKey:=HKEY_LOCAL_MACHINE;
  SpecialFolderRegInfo2[11].Key:='Software\Microsoft\Windows\CurrentVersion\Setup';
  SpecialFolderRegInfo2[11].Caption:='旧系统文件保存目录';


  SpecialFolderRegInfo[0].Name:='AppData';
  SpecialFolderRegInfo[0].Caption:='应用程序数据';
  SpecialFolderRegInfo[1].Name:='Cache';
  SpecialFolderRegInfo[1].Caption:='IE缓冲文件夹';
  SpecialFolderRegInfo[2].Name:='Cookies';
  SpecialFolderRegInfo[2].Caption:='网页Cookies';
  SpecialFolderRegInfo[3].Name:='Desktop';
  SpecialFolderRegInfo[3].Caption:='桌面';
  SpecialFolderRegInfo[4].Name:='Favorites';
  SpecialFolderRegInfo[4].Caption:='收藏夹';
  SpecialFolderRegInfo[5].Name:='Fonts';
  SpecialFolderRegInfo[5].Caption:='字体';
  SpecialFolderRegInfo[6].Name:='History';
  SpecialFolderRegInfo[6].Caption:='历史记录';
  SpecialFolderRegInfo[7].Name:='Local AppData';
  SpecialFolderRegInfo[7].Caption:='全局应用程序数据';
  SpecialFolderRegInfo[8].Name:='NetHood';
  SpecialFolderRegInfo[8].Caption:='网上邻居';
  SpecialFolderRegInfo[9].Name:='Personal';
  SpecialFolderRegInfo[9].Caption:='我的文档';
  SpecialFolderRegInfo[10].Name:='PrintHood';
  SpecialFolderRegInfo[10].Caption:='打印缓冲';
  SpecialFolderRegInfo[11].Name:='Programs';
  SpecialFolderRegInfo[11].Caption:='开始菜单“程序”';
  SpecialFolderRegInfo[12].Name:='Recent';
  SpecialFolderRegInfo[12].Caption:='开始菜单“文档”';
  SpecialFolderRegInfo[13].Name:='SendTo';
  SpecialFolderRegInfo[13].Caption:='发送到';
  SpecialFolderRegInfo[14].Name:='Start Menu';
  SpecialFolderRegInfo[14].Caption:='开始菜单';
  SpecialFolderRegInfo[15].Name:='Startup';
  SpecialFolderRegInfo[15].Caption:='启动';
  SpecialFolderRegInfo[16].Name:='Templates';
  SpecialFolderRegInfo[16].Caption:='新建文件模板文件目录';
  SpecialFolderRegInfo[17].Name:='ProgramFilesDir';
  SpecialFolderRegInfo[17].Caption:='应用程序';

  LimitReginfo[0].RootKey:=hkey_current_user;
  LimitReginfo[0].Key:='Software\Microsoft\Windows\CurrentVersion\Policies\WinOldapp';
  LimitReginfo[0].Name:='Disabled';
  LimitReginfo[0].DataType:=rdtdword;

  LimitReginfo[1].RootKey:=hkey_current_user;
  LimitReginfo[1].Key:='Software\Microsoft\Windows\CurrentVersion\Policies\WinOldapp';
  LimitReginfo[1].Name:='NoRealMode';
  LimitReginfo[1].DataType:=rdtdword;

  LimitReginfo[2].RootKey:=hkey_current_user;
  LimitReginfo[2].Key:=s_SystemKey;
  LimitReginfo[2].Name:='DisableRegistryTools';
  LimitReginfo[2].DataType:=rdtdword;

  DriverMenuRegInfo.Key:='Drive\shell';
  DriverMenuRegInfo.RootKey:=HKEY_CLASSES_ROOT;

  HideDriverRegInfo.DataSize:=4;
  HideDriverRegInfo.DataType:=rdtBin;
  HideDriverRegInfo.Key:=s_HideDriverKey;
  HideDriverRegInfo.RootKey:=Hkey_Current_user;
  HideDriverRegInfo.Name:='NoDrives';

  AutoRunRegInfo.DataSize:=4;
  AutoRunRegInfo.DataType:=rdtBin;
  AutoRunReginfo.Key:=s_AutoRunKey;
  AutoRunReginfo.RootKey:=Hkey_Current_user;
  AutoRunReginfo.Name:='NoDriveTypeAutoRun';

  PrinterRegInfo[0].Name:='NoAddPrinter';
  PrinterRegInfo[1].Name:='NoDeletePrinter';
  PrinterRegInfo[2].Name:='NoPrinterTabs';

  DisplayRegInfo[0].Name:='NoDispCPL';
  DisplayRegInfo[1].Name:='NoDispScrSavPage';
  DisplayRegInfo[2].Name:='NoDispAppearancePage';
  DisplayRegInfo[3].Name:='NoDispSettingsPage';
  DisplayRegInfo[4].Name:='NoDispBackGroundPage';

  NetworkRegInfo[0].Name:='NoNetSetup';
  NetworkRegInfo[1].Name:='NoNetNetupIDPage';
  NetworkRegInfo[2].Name:='NoNetSetupSecurityPage';
  NetworkRegInfo[3].Name:='NoFileSharingControl';
  NetworkRegInfo[4].Name:='NoPrintSharingControl';

  SystemRegInfo[0].Name:='NoVirtMemPage';
  SystemRegInfo[1].Name:='NoFileSysPage';
  SystemRegInfo[2].Name:='NoDevMgrPage';
  SystemRegInfo[3].Name:='NoConfigPage';
  SystemRegInfo[4].Name:='NoProfilePage';
  SystemRegInfo[5].Name:='NoPwdPage';
  SystemRegInfo[6].Name:='NoSetFolders';
  SystemRegInfo[6].Key:=s_ExplorerKey;
  SystemRegInfo[7].Name:='NoAdminPage';
  SystemRegInfo[7].Key:=s_ExplorerKey;


finalization        //程序退出时释放内存
  ControlRegInfo.Free;        //清除动态数组占用的内存

end.
