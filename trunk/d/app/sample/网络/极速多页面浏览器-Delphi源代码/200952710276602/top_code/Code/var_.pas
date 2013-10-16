unit var_;

interface

uses                          
  Windows, Messages,
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

var
  MyDir, TempDir: String;

  FCaption: string;

  firstrun: Boolean;
  //InstallOn: Boolean = false;

  WindowMax: Boolean;

  NoClose: Boolean;   //点击窗体的关闭按钮不退出?

  DBIndex, DGIndex: Boolean; //处理百度首页?
  SearchChange: word;   //Change是否OK?
  //SearchSet: Boolean;  //用户是否自行选择并设置过搜索引擎?

  BossKey: string;   //老板键
  BossKeyKey: word;
  //BossKeyShift: TShiftState;
  Modifiers: Integer;     
  //sarray: array[0..128] of array[0..99] of string;

  bfState: word = 0;  //前进和后退按钮的状态
  CurrBack: Boolean;
  CurrForward: Boolean;

  TabNull: word = 0;  //标签留空位置

  AutoMenuShow: Boolean = true;
  Auto: Boolean; 

  OneTowz: Boolean;
  OneTowz2: Boolean = true;
  DGIndex2: boolean = true;

  ShowGroup: Boolean;

  TabX, NewTabX: Integer;

  CloseUpdate: Boolean; //是否允许关闭小按钮更新

  eKeyWord: string;

  tcno: Boolean;
  tcMainUrl: String;
  tcUrl: String;
  tcClick: integer;
  tcFlag: word;
  tctFlag: word;
  wbClick_Url: String;
  nilAll: Boolean;

  ZoomStr: string = '100%';  //后续缩放的值

  ImgSaveDir: string;
  NoSaveNewly: Boolean;

  //
  TimerIPVI: Word = 0;
  enableClick: Boolean = true;

  NeedUpdate: Boolean;
  HintUpdate: Boolean = true;
  UpdateAtOne: Boolean;

  EnabledShowPageLogo: Boolean; //

  AddressFocus: Boolean;

  IsWhite: Boolean; //是否白名单中,是的话完整模式
  NoImage: Boolean;
  NoVideo: Boolean;
  NoBgsound: Boolean;
  //NoFlash: Boolean; as ActiveX
  NoJava: Boolean;
  NoScript: Boolean;
  NoActivex: Boolean;

  PageUnLock: Boolean; //页面解锁鼠标左右键
  TabRClickNewPage: Boolean;  //标签栏右击鼠标新建标签?

  //HotArea: Boolean;
  ButtonIndex: Integer;
  //FaceStyle: Word = 2;
  BackEnabled, ForwardEnabled: Boolean;

  AutoRefresh: Boolean = true; //是否是自动刷新?
  AutoRefreshTxt: String; //自动定时提示的内容

  AlwaysNewTab: Boolean; //自动激活新标签?
  WeatherSource: Word; //查看天气预报的源

  SearchShow: Boolean; //搜索框显示?

  AppToExit: Boolean; //程序正在退出?
  //GoRefresh: Boolean;

  CurrentUrl: String;  //当前URL
  HideBorder: Boolean = true; //浏览器是否隐藏边框
  //FaceNeedLine: Boolean = true;  //界面是否需要打线? 

  ShowMenu: Boolean = true;
  //ShowButton: Boolean = true;
  StatusBarV: Boolean; //是否显示状态栏
  StatusBarExtend: Boolean; //是否显示状态栏扩展

  MenuImage: Boolean = true;  //菜单是否有小图标?
  TBTabNewShow: Boolean;  //不显示标签栏前面的?  //标签栏最前面的"新建"小按钮是否显示

  DisDblClick: Boolean;  //禁止鼠标双击关闭标签?

  EnableTitle: Boolean = true;  //是否允许在浏览器的标题栏显示网站的标题  noread

  //TabNewBtn: TToolButton;
  //CreateTabNewBtnOK: Boolean;

  //SkinStyle: String = '0'; //换肤类型
  //ImageStandardButton: Word = 0;

  //FormsAutoComplete: Boolean = false; //网页是否自动完成

  Replace10, Replace11: ShortString;

  LoadLastOpenFlag: Boolean = true;
  //LastOpenPageClose: Boolean = false;
  LoadLastOpenI: Word;
  LoadLastOpenOK: Boolean;

  //{
  wbList: TList;
  PageIndex: Integer = 0;                           
  WhiteList: TStringList;  //白名单字符串列表
  BlackList: TStringList;  //黑名单字符串列表
  //GISPop: Boolean;  //全局的,是弹出?

  LANGUAGE: Word = 0; //语言

  //TabStyle: Word;  //标签样式
  TabAt: Word;  //标签放置

  //ShowTabHint: Boolean = true; //是否显示标签的提示

  //MainMenuDraw: Boolean = true;

  CheckDefaultBrowser: Boolean = true; //检查默认浏览器设置
  AutoUpdateHint: Boolean = true; //自动更新提示

  //AllCloseIng: Boolean; //页面全部关闭中

  ProBar:TProgressBar;  //状态进度条
  LabelPro:TLabel;  //状态进度条百分比

  ButtonMoveO: Word = 1;  //鼠标移过哪个标准按钮
  FaceStyle: Word;  //界面皮肤样式
  TabStyle: Word = 0;  //标签样式
  ButtonStyle: Word = 0; //标准按钮样式

  StatusTextEnabled: Boolean = true; //是否允许地址栏显示字符串

  WindowStateI: Word;  //记录窗口状态
  WindowStateII: Word = 0;  //记录窗口是最大化还是正常状态
  WindowStateOK: Boolean;  //窗口状态设置是否OK
  ShowRunOK: Boolean = false; //主窗体显示时只运行一次
  MainFormTop, MainFormHeight, MainFormLeft, MainFormWidth: Integer;

  TabWidth: Integer;   //标签宽度  120
  HopeTabWidth:Integer;   //期望标签的宽度  180

  //OnlyCurrentPage: Boolean; //仅用当前页打开

  TabAutoWidth: Boolean = true;  //是否自适应标签
  //TabRigthClickEnableClose : Boolean = false; //右击标签消息判别
  //TabParentDblClick: Word = 0;    //标签空白处双击所要做的
  NewlyUrl: string;   //最近的浏览器的一个URL地址
  B_UseProxy: Boolean;  //使用自己的代理
  B_UseIEProxy: Boolean;  //使用IE代理
  //DocumentFocusEnable: Boolean = true;  //是否允许文档有焦点
  MoreUrlOpen: Boolean = false;  //打开多URL

  TimerRunOne :Boolean = false; //只运行一次的

  RunOne: Boolean = true; //是否只运行一个实例标志

  CloseApp: Boolean=false; //是否在关闭程序
  AppCloseHint: Boolean = false;  //退出程序时是否提示

  NickName, UserName, PassWord, Answer, Email, RealName: String; //自动填表

  FavDirMe: Boolean;  //用自己的收藏夹?
  FavoritFolder, SFavoritFolder: string; //收藏夹目录
  //FavoritDir: String;
  //B_NFavoritFolder: Boolean = false; //收藏夹非系统
  FavoritCote: Boolean = false; //工具栏收藏夹
  ShowSideCote: Boolean = false; //显示侧边
  SideCoteWidth: Integer = 233;
  SideStatShape: Boolean = false; //侧边栏是否自动缩回
  //SideCoteAllHide: Boolean = true; //侧边栏是否完全隐藏

  SideAt: Word = 1;  //左侧边栏是位于收藏夹还是歌曲播放的位置?
  MusicPlayType: Word = 0;   //歌曲播放类别
  MusicPlayOrder: Word = 1;  //歌曲播放顺序
  OnlyPlayOne: Boolean;  //单曲播放?

  MemoryThrift: Boolean; //内存是否节约模式
  MemoryThrift2: Boolean = true; //是否内存清理
  CloseTabCount: Word = 0;  //页面关闭的数量
  CallBackMemory: Boolean = true;  //是否完善的回收内存
  //CBMemoryShow: Boolean; //高效回收内存项是否显示 
  Win32_NT: Boolean;

  StopPopup2, StopPopupO2, ShowWebIcon2: Boolean;
  //StopPopup: Boolean = false; //是否屏蔽广告
  //IsPopup:Boolean = true; //广告屏蔽
  //StopPopupMode1: Boolean = true; //广告屏蔽
  StopPopupMode2: Boolean = true; //广告屏蔽
  ClickSleepTime: Integer;   //点击延迟时间
  LClickSleepTime:Integer = 500; //左键单击的延时值
  RClickSleepTime: Integer = 3000; //右键单击的延时值
  LButtonDown: Boolean = false; //记录鼠标在页面中左键点击状态
  LButtonX, LButtonY: integer;  //鼠标左键在网页中进行点击的位置

  ThreadI:Byte; //integer; //线程根据此值执行不同的代码
  FormsAutoComplete: Boolean = false; //网页是否自动完成

  SearchOn: Word = 0;   //搜索引擎为哪个
  //GlobalOn: Word = 0;   //全局控制

  GetScreenSave: Boolean;  //区域抓图后是自动COPY到剪贴板还是另存为...

  DocRoll: Boolean = true;   //双击网页文档是否自动滚屏
  ShowWebIcon: Boolean = true;   //是否显示网站图标
  //UpdateButtonIcon: Boolean = true;  //是否更新图标
  ShowOptionOK: Boolean = false;   //选项设置完毕
  //WebIconFile: String;  //网站图标文件的ICO
  WebIconNeedBlankCount: Word = 3;   //显示网站图标所需空格
  ShowCloseHint: Boolean = false;  //显示标签关闭小按钮
  CloseHintCur: Integer = 999;
  ShowCloseOK: Boolean = false;  //显示标签关闭小按钮是否OK
  //CloseHintUpdate: Boolean;
  //==
  SetRunOne: Boolean = false; //设置窗体是否取值标志
  LoadUrlHistory: Boolean = true; //载入浏览历史
  FavoritMenu: Boolean = false; //收藏夹菜单
  LoadLastTime: Boolean = true; //载入上次浏览内容
  CreateOneTab: Boolean = true; //启动后创建一个标签
  InitForce: Boolean; //初始控制2

  OpenToUrl: String;
  StartPageTo : Word = 99; //开始页指向
  ExitCleanAllHistory: Boolean = false; //退出时清除所有浏览器记录
  CleanAddress: Boolean = false;
  CleanHistory: Boolean = false;
  CleanCache: Boolean = false;
  CleanCookies: Boolean = false;
  CleanRecent: Boolean = false;
  //ShowSideCoteInit: Boolean = false;  //第一次显示侧边栏
  GoToNewPage: Boolean = true; //打开新页面时是否转到新页面
  InstallTrayIcon: Boolean = true; //安装托盘图标   noread
  AppendTab: Boolean = true;   //是否在当前页后面追加标签
  NewTabAtEnd: Boolean;  //新建的标签位于最后面  
  CloseGoTab: Boolean = false;  //关闭页面后是否转到后一标签
  HoldOneTab: Boolean = true; //关闭标签是否保留最后一个标签
  RightClick: Boolean;  //是否在标签上鼠标右击?
  RightClickClose: Boolean = true; //标签上鼠标右键是否关闭页面
  StatusBarStrDT: String = '';  //状态栏显示.
  UseMouseSS: Boolean = false; //是否允许鼠标手势
  SSTop,SSButtom,SSLeft,SSRight,SSRightTop,SSRightButtom: Byte;
  WeatherCityName: String = ''; //天气预报城市
  //==

  CanShowContextMenu: Boolean = true; //是否允许弹出网页右键菜单
  ZoomFlag:Word=0;  //网页缩放大小标志
  FontZoom:Word=2;  //网页文字大小标志 

  QuickLiniStr:Array [0..3] of string;  //快捷网址列表
  
  EXOK: Boolean;
  AlexaUrl: String;
  AlexaEx: Boolean = true;
  
  AutoHintFile, HintStaticFile: String;
  AutoHintReadOK: Boolean;
  FormAutoHintCreateOK: Boolean;
  HintTabOK1, HintTabOK2, HintTabOK3, HintTabOK4, HintTabOK5, HintTabOK6, HintTabOK7: Boolean;

implementation

end.