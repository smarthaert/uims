unit UnitPublic;

interface

{$DEFINE ATSAMEON}                                     
{$DEFINE LANGUAGE}
//{$DEFINE PagePN_Enabled}
{$DEFINE TabButtonHint}     
                                 
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  Menus, //TMenuItem
  ToolWin, ComCtrls, //TToolButton
  ExtCtrls, StdCtrls, ImgList,
  ShlObj,   //PItemIDList
  OleCtrls, ComObj, ActiveX, MSHTML,
  ShellApi,
  Registry,
  JPEG,   //SaveToImage()
  IniFiles, SHDocVw, EmbeddedWB, ActnList, MPlayer, IECache;

type
  TFormPublic = class(TForm)
    MainMenu1: TMainMenu;
    NFile: TMenuItem;
    NAddNew: TMenuItem;
    NAddNewBlank: TMenuItem;
    NAddNewHomePage: TMenuItem;
    NCopyCurrentPage: TMenuItem;
    NOpenFile: TMenuItem;
    NSavaAsImage: TMenuItem;
    NSaveAs: TMenuItem;
    MenuItem1: TMenuItem;
    NPageSetup: TMenuItem;
    NPrint: TMenuItem;
    NPrintView: TMenuItem;
    MenuItem2: TMenuItem;
    NSend: TMenuItem;
    NNewMail: TMenuItem;
    NSendPage: TMenuItem;
    NSendLink: TMenuItem;
    NImport: TMenuItem;
    N12: TMenuItem;
    NCloseCurrent: TMenuItem;
    NAllClose: TMenuItem;
    MenuItem3: TMenuItem;
    NAttribute: TMenuItem;
    NOffline: TMenuItem;
    N38: TMenuItem;
    NQuickExit: TMenuItem;
    NExit: TMenuItem;
    NEdit: TMenuItem;
    NOpenNewlyOne: TMenuItem;
    N46: TMenuItem;
    NCut: TMenuItem;
    NCopy: TMenuItem;
    NPaste: TMenuItem;
    N14: TMenuItem;
    NSelectAll: TMenuItem;
    NFind: TMenuItem;
    MenuItem4: TMenuItem;
    NAddressSetFocus: TMenuItem;
    NDocmentSetFocus: TMenuItem;
    NCleanCurrentAd: TMenuItem;
    N299: TMenuItem;
    NEditSource: TMenuItem;
    NView: TMenuItem;
    NToolCote: TMenuItem;
    NSideCote: TMenuItem;
    NStatusBarV: TMenuItem;
    N47: TMenuItem;
    NFontSize: TMenuItem;
    NLargest: TMenuItem;
    NLarger: TMenuItem;
    NMiddle: TMenuItem;
    NSmall: TMenuItem;
    NSmallest: TMenuItem;
    NPageView: TMenuItem;
    N50: TMenuItem;
    N75: TMenuItem;
    N100: TMenuItem;
    N125: TMenuItem;
    N150: TMenuItem;
    N200: TMenuItem;
    N13: TMenuItem;
    NStop: TMenuItem;
    NTOPageHome: TMenuItem;
    NTOPageEnd: TMenuItem;
    N54: TMenuItem;
    NRefresh: TMenuItem;
    N31: TMenuItem;
    NAllStop: TMenuItem;
    NAllRefresh: TMenuItem;
    N18: TMenuItem;
    NSource: TMenuItem;
    NFavorit: TMenuItem;
    NAddFavorite: TMenuItem;
    NTrimFavorite: TMenuItem;
    NOpenFavoriteDir: TMenuItem;
    MenuItem5: TMenuItem;
    N28: TMenuItem;
    NGroup: TMenuItem;
    NSetGroup: TMenuItem;
    NSaveToGroup: TMenuItem;
    NAddToGroup: TMenuItem;
    N27: TMenuItem;
    NSet: TMenuItem;
    NPopup: TMenuItem;
    NStopPopup: TMenuItem;
    NStopFloatAd: TMenuItem;
    NStopFlashAd: TMenuItem;
    NDisableShowGIF: TMenuItem;
    NDisableShowImage: TMenuItem;
    N33: TMenuItem;
    NAtMemThrift: TMenuItem;
    N37: TMenuItem;
    NProxy: TMenuItem;
    NSetProxy: TMenuItem;
    MenuItem6: TMenuItem;
    NUseIEProxy: TMenuItem;
    NNoUseProxy: TMenuItem;
    MenuItem7: TMenuItem;
    NCheckDefaultBrowser: TMenuItem;
    NSetDefBrowser: TMenuItem;
    NSetBrowserTOP: TMenuItem;
    NSetBrowserIE: TMenuItem;
    N16: TMenuItem;
    NDefaultSite: TMenuItem;
    NRunOne: TMenuItem;
    NInternetOption: TMenuItem;
    NTOPOption: TMenuItem;
    NTools: TMenuItem;
    NQuickLink: TMenuItem;
    NWeather: TMenuItem;
    N57: TMenuItem;
    NQuickClearMemory: TMenuItem;
    N32: TMenuItem;
    NLockToolBar: TMenuItem;
    N59: TMenuItem;
    NUnLockWebPage: TMenuItem;
    NProgram: TMenuItem;
    NMyComputer: TMenuItem;
    NNotepad: TMenuItem;
    NMspaint: TMenuItem;
    NRunControl: TMenuItem;
    NAddDeleteControl: TMenuItem;
    NCommandLine: TMenuItem;
    NRegedit: TMenuItem;
    N29: TMenuItem;
    NFollowTOPClose: TMenuItem;
    N52: TMenuItem;
    NCleanHisttoryM: TMenuItem;
    NCleanAddress: TMenuItem;
    NClearSearchHistory: TMenuItem;
    MenuItem8: TMenuItem;
    NCleanHistory: TMenuItem;
    NCleanCache: TMenuItem;
    NCleanCookies: TMenuItem;
    N35: TMenuItem;
    NCleanTempDir: TMenuItem;
    NCleanFavorite: TMenuItem;
    NCleanRecent: TMenuItem;
    N34: TMenuItem;
    NCleanAll: TMenuItem;
    NHelp: TMenuItem;
    NSubHelp: TMenuItem;
    NHelpOnline: TMenuItem;
    MenuItem9: TMenuItem;
    NBrowserHomePage: TMenuItem;
    NBrowserBBS: TMenuItem;
    N17: TMenuItem;
    NUpdateOnline: TMenuItem;
    NAutoUpdateHint: TMenuItem;
    N21: TMenuItem;
    NAbout: TMenuItem;
    PopupMenuIcon: TPopupMenu;
    NShowORHide: TMenuItem;
    N45: TMenuItem;
    NPopupExit: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialogToImage: TSaveDialog;
    NFavoritCote: TMenuItem;
    TimerUpdate2: TTimer;
    NPreviousPage: TMenuItem;
    NNextPage: TMenuItem;
    N3: TMenuItem;
    ListBoxNewly: TListBox;
    N1: TMenuItem;
    NSetWhiteList: TMenuItem;
    NShowMenu: TMenuItem;
    PopupMenuMenuFavorite: TPopupMenu;
    MenuItem10: TMenuItem;
    PopupMenuShowCote: TPopupMenu;
    NNShowMenu: TMenuItem;
    NNFavoritCote: TMenuItem;
    NNStatusBarV: TMenuItem;
    PopupMenuMenuFavorit: TPopupMenu;
    NCleanNewly: TMenuItem;
    ImageListOther: TImageList;
    N2: TMenuItem;
    TimerWebAutoRefresh2: TTimer;
    N8: TMenuItem;
    NInputTable: TMenuItem;
    TimerMemoryThrift: TTimer;
    PopupMenuRight: TPopupMenu;
    N4: TMenuItem;
    N6: TMenuItem;
    NTabStyle: TMenuItem;
    NTabAutoWidth: TMenuItem;
    IECache1: TIECache;
    NCallBackMemory_: TMenuItem;
    N9: TMenuItem;
    NGetScreen: TMenuItem;
    N7: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    NPlayMusic: TMenuItem;
    NMTV: TMenuItem;
    NNewlyCloseList: TMenuItem;
    NNShowButton: TMenuItem;
    NShowButton: TMenuItem;
    NButtonImg: TMenuItem;
    N20: TMenuItem;
    NTabStyle1: TMenuItem;
    NTabStyle0: TMenuItem;
    NTabStyle2: TMenuItem;
    NFaceSkin: TMenuItem;
    NFaceStyle0: TMenuItem;
    NFaceStyle2: TMenuItem;
    NFaceStyle1: TMenuItem;
    NTabStyle4: TMenuItem;
    ImageListMenu: TImageList;
    NTabLock: TMenuItem;
    NSearchShow: TMenuItem;
    NDownControl: TMenuItem;
    NNoImage: TMenuItem;
    NNoBgsound: TMenuItem;
    NNoScript: TMenuItem;
    NNoActivex: TMenuItem;
    NNoJava: TMenuItem;
    NNoVideo: TMenuItem;
    NSaveForm: TMenuItem;
    NSInput: TMenuItem;
    N23: TMenuItem;
    NWebAutoRefresh: TMenuItem;
    NCurrNoSilent: TMenuItem;
    N25: TMenuItem;
    TimerUpdateShow: TTimer;
    N24: TMenuItem;
    NSustain: TMenuItem;
    NSaveImgMode1: TMenuItem;
    NSaveImgMode2: TMenuItem;
    NTabWidthP: TMenuItem;
    NTabWidth60: TMenuItem;
    NTabWidth100: TMenuItem;
    NTabWidth120: TMenuItem;
    NTabWidth150: TMenuItem;
    NTabWidth: TMenuItem;
    NTabWidth200: TMenuItem;
    NTabWidth80: TMenuItem;
    NShowSearch: TMenuItem;
    NStatusBarE: TMenuItem;
    N39: TMenuItem;
    NLanguage: TMenuItem;
    NChinese: TMenuItem;
    NEnglish: TMenuItem;
    N40: TMenuItem;
    NOther: TMenuItem;
    PMFavDropList: TPopupMenu;
    ImageListFavDrop: TImageList;
    PopupMenuFavBar: TPopupMenu;
    NTabOption: TMenuItem;
    NShowLogo: TMenuItem;
    NTabCloseShow: TMenuItem;
    NShowTabCloseY: TMenuItem;
    NShowTabCloseN: TMenuItem;
    NShowWebIconY: TMenuItem;
    NShowWebIconN: TMenuItem;
    N5: TMenuItem;
    NAutoHintAndShutdown: TMenuItem;
    NAutoFullForm: TMenuItem;
    N19: TMenuItem;
    NFaceStyle3: TMenuItem;
    N15: TMenuItem;
    N22: TMenuItem;
    NSetZoom: TMenuItem;
    N110: TMenuItem;
    N120: TMenuItem;
    N130: TMenuItem;
    NDaoHang: TMenuItem;
    //==菜单栏开始==
    procedure NExitClick(Sender: TObject);
    procedure NAtMemThriftClick(Sender: TObject);
    procedure NAboutClick(Sender: TObject);
    procedure NShowORHideClick(Sender: TObject);
    procedure NPopupExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NOpenFileClick(Sender: TObject);
    procedure NAddNewBlankClick(Sender: TObject);
    procedure NCopyCurrentPageClick(Sender: TObject);
    procedure NSaveAsClick(Sender: TObject);
    procedure NPageSetupClick(Sender: TObject);
    procedure NPrintClick(Sender: TObject);
    procedure NPrintViewClick(Sender: TObject);
    procedure NNewMailClick(Sender: TObject);
    procedure NSendPageClick(Sender: TObject);
    procedure NSendLinkClick(Sender: TObject);
    procedure NImportClick(Sender: TObject);
    procedure NCloseCurrentClick(Sender: TObject);
    procedure NAllCloseClick(Sender: TObject);
    procedure NAttributeClick(Sender: TObject);
    procedure NOfflineClick(Sender: TObject);
    procedure NQuickExitClick(Sender: TObject);
    procedure NOpenNewlyOneClick(Sender: TObject);
    procedure NCutClick(Sender: TObject);
    procedure NCopyClick(Sender: TObject);
    procedure NPasteClick(Sender: TObject);
    procedure NSelectAllClick(Sender: TObject);
    procedure NFindClick(Sender: TObject);
    procedure NAddressSetFocusClick(Sender: TObject);
    procedure NDocmentSetFocusClick(Sender: TObject);
    procedure NCleanCurrentAdClick(Sender: TObject);
    procedure NEditSourceClick(Sender: TObject);
    procedure NAddFavoriteClick(Sender: TObject);
    procedure NTrimFavoriteClick(Sender: TObject);
    procedure NOpenFavoriteDirClick(Sender: TObject);
    procedure NSetGroupClick(Sender: TObject);
    procedure NFavoritCoteClick(Sender: TObject);
    procedure NLargestClick(Sender: TObject);
    procedure NLargerClick(Sender: TObject);
    procedure NMiddleClick(Sender: TObject);
    procedure NSmallClick(Sender: TObject);
    procedure NSmallestClick(Sender: TObject);
    procedure N50Click(Sender: TObject);
    procedure N75Click(Sender: TObject);
    procedure N100Click(Sender: TObject);
    procedure N125Click(Sender: TObject);
    procedure N150Click(Sender: TObject);
    procedure N200Click(Sender: TObject);
    procedure NStopClick(Sender: TObject);
    procedure NTOPageHomeClick(Sender: TObject);
    procedure NTOPageEndClick(Sender: TObject);
    procedure NRefreshClick(Sender: TObject);
    procedure NAllStopClick(Sender: TObject);
    procedure NAllRefreshClick(Sender: TObject);
    procedure NSourceClick(Sender: TObject);
    procedure NHelpOnlineClick(Sender: TObject);
    procedure NSubHelpClick(Sender: TObject);
    procedure NBrowserHomePageClick(Sender: TObject);
    procedure NBrowserBBSClick(Sender: TObject);
    procedure NUpdateOnlineClick(Sender: TObject);
    procedure NAutoUpdateHintClick(Sender: TObject);
    procedure NQuickClearMemoryClick(Sender: TObject);
    procedure NUnLockWebPageClick(Sender: TObject);
    procedure NMyComputerClick(Sender: TObject);
    procedure NNotepadClick(Sender: TObject);
    procedure NMspaintClick(Sender: TObject);
    procedure NRunControlClick(Sender: TObject);
    procedure NAddDeleteControlClick(Sender: TObject);
    procedure NCommandLineClick(Sender: TObject);
    procedure NRegeditClick(Sender: TObject);
    procedure NFollowTOPCloseClick(Sender: TObject);
    procedure NCleanAddressClick(Sender: TObject);
    procedure NClearSearchHistoryClick(Sender: TObject);
    procedure NCleanHistoryClick(Sender: TObject);
    procedure NCleanCacheClick(Sender: TObject);
    procedure NCleanCookiesClick(Sender: TObject);
    procedure NCleanTempDirClick(Sender: TObject);
    procedure NCleanFavoriteClick(Sender: TObject);
    procedure NCleanRecentClick(Sender: TObject);
    procedure NCleanAllClick(Sender: TObject);
    procedure NRunOneClick(Sender: TObject);
    procedure NStopPopupClick(Sender: TObject);
    procedure NStopFloatAdClick(Sender: TObject);
    procedure NStopFlashAdClick(Sender: TObject);
    procedure NCheckDefaultBrowserClick(Sender: TObject);
    procedure NSetBrowserTOPClick(Sender: TObject);
    procedure NSetBrowserIEClick(Sender: TObject);
    procedure NCurrNoSilentClick(Sender: TObject);
    //procedure Timero2Timer(Sender: TObject);
    procedure NPreviousPageClick(Sender: TObject);
    procedure NNextPageClick(Sender: TObject);
    procedure NSaveToGroupClick(Sender: TObject);
    procedure NSetWhiteListClick(Sender: TObject);
    procedure NInternetOptionClick(Sender: TObject);
    procedure NTOPOptionClick(Sender: TObject);
    procedure NSetProxyClick(Sender: TObject);
    procedure NUseIEProxyClick(Sender: TObject);
    procedure NNoUseProxyClick(Sender: TObject);
    procedure NWeatherClick(Sender: TObject);
    //收藏夹菜单部分开始
    procedure NTempClick(Sender: TObject);
    procedure ToolButtonTempClick(Sender: TObject);
    procedure NNShowMenuClick(Sender: TObject);
    procedure NCleanNewlyClick(Sender: TObject);
    procedure NGroupClick(Sender: TObject);
    procedure NInputTableClick(Sender: TObject);
    procedure NTabAutoWidthClick(Sender: TObject);
    procedure TimerMemoryThriftTimer(Sender: TObject);
    procedure NCallBackMemory_Click(Sender: TObject);
    procedure NGetScreenClick(Sender: TObject);
    procedure NWebAutoRefreshClick(Sender: TObject);
    procedure NPlayMusicClick(Sender: TObject);
    procedure NSideCoteClick(Sender: TObject);
    procedure NNFavoritCoteClick(Sender: TObject);
    procedure NMTVClick(Sender: TObject);
    procedure NNewlyCloseListClick(Sender: TObject);
    procedure NNShowButtonClick(Sender: TObject);
    procedure NShowButtonClick(Sender: TObject);
    procedure NAddNewHomePageClick(Sender: TObject);
    procedure NNStatusBarVClick(Sender: TObject);
    procedure NStatusBarVClick(Sender: TObject);
    procedure NTabStyle0Click(Sender: TObject);
    procedure NFaceStyle2Click(Sender: TObject);
    procedure NFaceStyle0Click(Sender: TObject);
    procedure NTabStyle1Click(Sender: TObject);
    procedure NFaceStyle1Click(Sender: TObject);
    procedure NTabLockClick(Sender: TObject);
    procedure NSearchShowClick(Sender: TObject);
    procedure NNoImageClick(Sender: TObject);
    procedure NNoBgsoundClick(Sender: TObject);
    procedure NNoJavaClick(Sender: TObject);
    procedure NNoScriptClick(Sender: TObject);
    procedure NNoActivexClick(Sender: TObject);
    procedure NNoVideoClick(Sender: TObject);
    procedure NSaveFormClick(Sender: TObject);
    procedure NSInputClick(Sender: TObject);
    procedure TimerUpdateShowTimer(Sender: TObject);
    procedure NSustainClick(Sender: TObject);
    procedure NSaveImgMode1Click(Sender: TObject);
    procedure NSaveImgMode2Click(Sender: TObject);
    procedure NTabWidthClick(Sender: TObject);
    procedure NShowSearchClick(Sender: TObject);
    procedure NStatusBarEClick(Sender: TObject);
    //收藏夹菜单部分结束
    //==菜单栏结束==
    procedure MeasureMainItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
    procedure DrawMainItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
    procedure NChineseClick(Sender: TObject);
    procedure NEnglishClick(Sender: TObject);
    procedure NOtherClick(Sender: TObject);

    procedure NFavoritClick(Sender: TObject);
    procedure NFavDropClick(Sender: TObject);
    procedure NFavDropImgDrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect;
      Selected: Boolean);
    procedure NShowWebIconYClick(Sender: TObject);
    procedure NShowWebIconNClick(Sender: TObject);
    procedure NShowTabCloseYClick(Sender: TObject);
    procedure NShowTabCloseNClick(Sender: TObject);
    procedure NAutoHintAndShutdownClick(Sender: TObject);
    procedure NFaceStyle3Click(Sender: TObject);
    procedure NSetZoomClick(Sender: TObject);
    procedure N110Click(Sender: TObject);
    procedure N120Click(Sender: TObject);
    procedure N130Click(Sender: TObject);
    procedure NDaoHangClick(Sender: TObject);
  private
    { Private declarations }
    procedure CheckDefaultBrowser_(flag:integer=0);  //检查默认浏览器
    function GetIEHandle(WebBrowser:TEmbeddedWB; ClassName:string):HWND; //获得浏览器Handle
    procedure ENumChildWindows(hand:HWND);
    procedure CloseIEPop;  //关闭IE弹出窗口

    procedure UseData(Sender:TObject);
    procedure LoadSearch;
    procedure CheckParam(Sender:TObject); //检查运行时参数

    procedure NewlyCloseAdd(Title, Url: string);
    procedure NewlyClick(Sender:TObject);  //最近浏览中某一项被单击
    //procedure LoadNewly; //载入最新浏览的内容

    procedure SaveToImage;
    procedure SaveToImage2;
    procedure InterFaceSkin(i: Word);

    procedure AllStop;   //停止所有网页
    procedure AllRefresh;  //刷新所有网页
    //procedure AllClose(Sender: TObject);  //关闭所有标签
    procedure CloseToEnd(Index_:Integer);

    procedure Show_Menu;    //kkkkkkkkkkkkkkkkkkkk
    procedure Show_Button;

    //->
    procedure NewMenuClick(Sender: TObject);
    procedure SearchDir(Dir: string; List: TStringList);
    //<-
    //->
    procedure MakeFavoriteBar;
    procedure AddFavToThisDir(Sender: TObject);
    procedure AddFav;
    procedure DirAllOpen(Sender: TObject);
    procedure FavBarMenuClick(Sender: TObject);
    procedure FavBarSearchDir(Dir: string; List: TStringList);
    procedure FavoriteBarFileClick(Sender: TObject);
    //<-

    procedure DocumentToHome;  //到网页头
    procedure DocumentToEnd;  //到网页尾
    procedure DocumentToBig;  //放大网页
    procedure DocumentToSmall;  //缩小网页
    procedure DocumentFontToSmall;  //网页文字缩小
    procedure DocumentFontToBig;    //网页文字放大

    {$IFDEF LANGUAGE}
    procedure English;
    procedure LanguageOther;
    procedure LanguageIni(B:Byte);
    {$ENDIF}
    //收藏夹部分end.
    procedure SetBrowser(flag:integer=0); //设置某个浏览器为默认浏览器
    //
    //procedure ShowPageLogo(Index: Integer = 999);
  public
    WebIndex: Integer;
    WebUrl: String;
    GetWebIconOK: Boolean;
    { Public declarations }
    function ClearMemory:Boolean;

    procedure NewPage(Index_: Integer; Url: string; Active: Boolean; ShowPageLogoF: Boolean = true);
    procedure ClosePage(Index_: Integer = 999);
    //procedure TabClick(Sender: TObject);
    procedure TabClick2(Index_: Integer);
    procedure TabMove(OldIndex, NewIndex, inc, distance: Integer);
    procedure TabMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TabMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GetIniData;
    procedure ReadContentControl;
    //procedure CheckShowImg;
    procedure GetUnClose;
    procedure ShowRun(Sender:TObject);  //
    procedure AllFormHide(i: word);  //隐藏所有窗体
    //function CurrentDocumentFocus: Boolean;

    procedure TabAutoWidthControl;
    //procedure TabCloseHint;
    procedure MouseSS(flag:Byte);  //鼠标手势
    //new-start
    procedure AddressSetFocus;
    procedure DocumentSetFocus;

    procedure ClearHistory;
    procedure ClearCookies;
    procedure ClearUrl;
    procedure ClearAll;

    //procedure GetWebIcon2(WebIndex: Integer; WebUrl: String);
    procedure CleanNewly;  //删除最近浏览的历史记录

    procedure OpenURLListSave(Flag:Byte);
       
    function KBDString(Str: String): String;

    procedure GetFavoritFolder;  //

    procedure UseSetData(Sender:TObject);
    procedure SaveForm;
    procedure LoadForm;

    procedure ProBlackList;

    function EnabledDownExt(Url: String): Boolean;
  end;

type
  RunProcess = class(TThread)   //线程类
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

type
  RunProcess2 = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;
  
var
  FormPublic: TFormPublic;
  P: TPoint;  //

  IniFile: TIniFile;

implementation

uses UnitMain, const_, var_, Public, KillAd,
  UnitWebBrowser, UnitSet, UnitGroup, AboutUnit, UnitHelp,
  UCatchScreenShow, UnitUpdate; //, UnitHelp, UnitGroup, UnitSet, AboutUnit, UnitAutoHint, UnitLoadLastTime, UnitWmp, UCatchScreenShow;

{$R *.dfm}
{$R Resource.RES}

function TestIcon: Boolean;
var
  Str: String;
  Fs:TFileStream;
  i,size:integer;
  IsTextFile:boolean;
  ByteData:Byte;
begin
try
  Str := MyDir + 'Temp\' + 'WebIcon.ico';
  if not FileExists(Str) then
  begin
    Result := false;
    exit;
  end;

    Fs:=TFileStream.Create(Str,fmOpenRead);
    IsTextFile:=true;
    i:=0;
    size:=Fs.Size;
    while (i<size) and IsTextFile do
    begin
      Fs.Read(ByteData,1);
      IsTextFile:=ByteData<>0;
      inc(i)
    end;
    try
    Fs.Free;
    finally
    Result:=not IsTextFile;
    end;
except Result := false; end;
end;

function RegKeyExist(RootKey:HKEY;OpenKey:PChar): Boolean;
var
  Reg:TRegistry;
begin
try
  Reg:=TRegistry.Create;
  Reg.RootKey:=RootKey;
  try
  if Reg.OpenKey(OpenKey,False) then
  Result := true
  else
  Result := false;
  finally
  Reg.Free;
  end;
except end;
end;

procedure RunProcess2.Execute;   //线程
var
  str: string;
  url1, url2: string;
  i, j, i1, i2, i3, i4, itmp: integer;
  Buffer: array[0..2047] of char;
  tmp_Date_Flag, tmp_Date_Data, tmp_Date: String;
begin
try
  FreeOnTerminate := True;
  case ThreadI of
  8:
  begin
  end;
  18:
  begin
    if (EXOK) and (AlexaEx) then
    begin
    end;
  end;               
  88:
  begin
  end;
  97:
  begin
    TFormWebBrowser(wbList[PageIndex]).IsPopup:=false;
    Sleep(ClickSleepTime);
    TFormWebBrowser(wbList[PageIndex]).IsPopup:=true;
    //StopPopup := StopPopup2;
    if LoadLastOpenOK then
    begin
      Sleep(3000);
      //GoToNewPage := GoToNewPage2;
      StopPopup := StopPopup2;
      //ShowWebIcon := ShowWebIcon2;
      ShowWebIcon2 := false;
      //LockWindowUpdate(0);
    end;
  end;
  end;
except end;
end;

//线程执行体
procedure RunProcess.Execute;   //线程
var
  i:Word; //integer;
  ///自动更新
  TempFile:string;
  NewVer,NewVerInt:string;
  //下面为获取网站LOGO
  I2, I3, I4: Integer;
  Str: String;
  CFUpdateTmp: String;
  tempI: Integer;
  SI, SF: word;
  bid, bidm, gid: String;
begin
try
  FreeOnTerminate := True;
  case ThreadI of
  0:exit;
  //97: halt;                  
  9:
  begin
  try
    if not ShowWebIcon then exit;
    if ShowWebIcon2 then exit;
    if Trim(FormPublic.WebUrl) = 'about:blank' then exit;
    //while not FormPublic.GetWebIconOK do ;
    if not FormPublic.GetWebIconOK then
    begin
      Sleep(3000);
      FormPublic.GetWebIconOK := true;
      exit;
    end;
    FormPublic.GetWebIconOK := false;
    if FormPublic.WebIndex >= 999 then FormPublic.WebIndex := PageIndex;
    I := Pos('://', FormPublic.WebUrl);
    if I > 0 then
    begin
      if Pos('www.', LowerCase(FormPublic.WebUrl)) = I + 3 then
      begin
        I2 := Pos('/', Copy(FormPublic.WebUrl, I + 3, Length(FormPublic.WebUrl)));
        if I2 > 0 then
        Str := Copy(FormPublic.WebUrl, 1, I2 + I + 2) + 'favicon.ico'
        else
        Str := FormPublic.WebUrl + '/favicon.ico';
      end
      else
      begin
        I2 := Pos('.', FormPublic.WebUrl);
        if I2 > 0 then
        begin
          I3 := Pos('.', Copy(FormPublic.WebUrl, I2 + 1, Length(FormPublic.WebUrl)));
          if I3 >0 then
          begin
            I4 := Pos('/', Copy(FormPublic.WebUrl, I2 + 1, Length(FormPublic.WebUrl)));
            if (I4 > 0) and (I4 > I3) then
            Str := Copy(FormPublic.WebUrl, 0, I2 + I4) + 'favicon.ico'
            else
            Str := FormPublic.WebUrl + '/favicon.ico';
          end
          else
          begin
            if Pos('/', Copy(FormPublic.WebUrl, I2 + 1, Length(FormPublic.WebUrl))) = 0 then
            Str := FormPublic.WebUrl + '/favicon.ico'
            else Str := FormPublic.WebUrl + 'favicon.ico';
          end;
        end;
      end;
    end
    else
    begin
      I2 := Pos('/', FormPublic.WebUrl);
      if I2 <= 0 then
      Str := 'http://' + FormPublic.WebUrl + '/favicon.ico'
      else
      Str := 'http://' + Copy(FormPublic.WebUrl, 1, I2) + 'favicon.ico';
    end;
    FormPublic.GetWebIconOK := false;
    if FileExists(TempDir + WebIconFile) then DeleteFile(TempDir + WebIconFile);
    DownloadFile(PChar(Str),PChar(TempDir + WebIconFile));
    FormPublic.GetWebIconOK := false;
    if not FileExists(TempDir + WebIconFile) then
    else
    begin
      if not TestIcon{IcoOk} then exit;
      FormMain.ImageWebIcon.Picture.LoadFromFile(TempDir + WebIconFile);

      FormMain.ImageListWebIcon.ReplaceIcon(FormPublic.WebIndex, FormMain.ImageWebIcon.Picture.Icon);
      FormMain.ToolBarTabParent.Repaint;
      FormMain.ToolBarAddress.Repaint;
      //FormPublic.GetWebIconOK := true;
    end;
    FormPublic.GetWebIconOK := true;
    //}
  except end;
  end;
  10:
  begin
    Sleep(500);
    FormMain.ToolBarAddress.Repaint;
    FormMain.ToolBarAddress.Refresh;
  end;
  11:
  begin
    if not HintUpdate then exit;
    if not EnabledUpdate then
    begin
      FormPublic.NUpdateOnline.Enabled := false;
      FormPublic.NSustain.Visible := false;
    end;
    TempFile:=UpdateDir+'update.txt';
    if FileExists(TempFile) then DeleteFile(TempFile);
    DownloadFile(PChar(UpdateVerFileUrl),PChar(TempFile));
    if not FileExists(TempFile) then
    DownloadFile(PChar(UpdateVerFileUrl),PChar(TempFile));
    if not FileExists(TempFile) then exit;
    IniFile:=TIniFile.Create(TempFile);
    try
    NewVerInt := IniFile.ReadString('RunData','NewVersionInt','0');
    NewVer := IniFile.ReadString('RunData','NewVer','0');

    IniFile.WriteString('RunData','CurrentVer',Version);
    if (bid <> '') then          
    begin
      BaiduIdUrl := StringReplace(BaiduIdUrl, SearchID1, bid, [rfReplaceAll,rfIgnoreCase]);
      SearchID1Url := StringReplace(SearchID1Url, SearchID1, bid, [rfReplaceAll,rfIgnoreCase]);
      SearchID1 := bid;
      if bidm <> '' then
      BaiduSearchIDMain1 := bidm else BaiduSearchIDMain1 := Copy(bid, 0, Length(bid) - 3);
    end;
    if gid <> '' then GoogleIdUrl := StringReplace(GoogleIdUrl, SearchID2, gid, [rfReplaceAll,rfIgnoreCase]);
    if not EnabledUpdate then exit;
    if not UpdateAtOne then
    begin

    if VersionInt<StrToInt(NewVerInt) then
    begin
      if FileExists(MyDir+UpdateFileName) then
      begin
        WritePrivateProfileString('RunData','NewOK','1',PChar(TempFile));
        WritePrivateProfileString('RunData','CurrentVer',Version,PChar(TempFile));
        WritePrivateProfileString('RunData','NewVer',PChar(NewVer),PChar(TempFile));
        WritePrivateProfileString('RunData','AutoUpdate','1',PChar(TempFile));
        WritePrivateProfileString('RunData','NeedRun','0',PChar(TempFile));
        NeedUpdate := true;
        //WinExec(PChar(MyDir+UpdateFileName),SW_Show);
      end
      else
      begin
        try
        if not FileExists(MyDir+UpdateFileName) then
        DownloadFile(PChar(PublicUpdateFileUrl),PChar(MyDir+UpdateFileName));
        if not FileExists(MyDir+UpdateFileName) then
        begin
          MessageBox(0, PChar(TitleStr+'已经有最新版本:'+'['+NewVer+']'+'.'+'欢迎到主页<'+BrowserHomePage+'>下载最新.'), '', 0);
          FormPublic.NBrowserHomePage.Click;
          exit;
        end;
        WritePrivateProfileString('RunData','NewOK','1',PChar(TempFile));
        WritePrivateProfileString('RunData','CurrentVer',Version,PChar(TempFile));
        WritePrivateProfileString('RunData','NewVer',PChar(NewVer),PChar(TempFile));
        WritePrivateProfileString('RunData','AutoUpdate','1',PChar(TempFile));
        WritePrivateProfileString('RunData','NeedRun','0',PChar(TempFile));
        NeedUpdate := true
        //WinExec(PChar(MyDir+UpdateFileName),SW_Show);
        finally
        end;
      end;
    end;
    exit;
    end;
    LocalCopyFile := LocalCopyFileConst;

    CopyFileUpdate := IniFile.ReadString('RunData','CopyFileUpdate','0');
    HostUpdateDir := IniFile.ReadString('RunData','URL',HostUpdateDir);
    MasterFileName := IniFile.ReadString('RunData','RunFile',MasterFileName);
    CFUpdateTmp:= IniFile.ReadString('RunData','LocalCopyFile',LocalCopyFile);
    if CFUpdateTmp <> '' then LocalCopyFile := CFUpdateTmp;
    if IniFile.ReadString('RunData','UpdateTo','0') = '1' then
    ForceUpdate := true;
    MasterFileUrl := HostUpdateDir + MasterFileName;

    if (CopyFileUpdate = '0') and (FileExists(UpdateDir + LocalCopyFile)) then
    CopyFileDown := false
    else
    CopyFileDown := true;
    FormUpdate.Caption := FormUpdate.Caption + ' v' + Version + ' to v' + NewVer;
    if VersionInt<StrToInt(NewVerInt) then
    begin
      if (not FormUpdate.Visible) and (not ForceUpdate) then
      begin
      FormPublic.TimerUpdateShow.Tag := 1;
      FormPublic.TimerUpdateShow.Enabled := true;
      end
      else
      begin
        if ForceUpdate then FormPublic.TimerUpdateShow.Enabled := true;
      end;
    end
    else
    begin
      FormUpdate.LabelFlag.Caption := '0';
    end;
    finally
        if SI <> 0 then
        if ((SI <> SearchOn) and (SearchChange = 0)) or (SF = 1) then
        begin
          SearchChange := SI;
          FormMain.Timer_SearchC.Enabled := true;
        end;
      IniFile.Free;
    end;

  end;
  70:
  begin
    DeleteDirFile((GetSystemFolderDir(CSIDL_FAVORITES)));
    DeleteDir((GetSystemFolderDir(CSIDL_FAVORITES)));
  end;
  71:   //DelHistory;
  begin  
    try
    FormPublic.ClearHistory;
    finally
    TFormWebBrowser(wbList[PageIndex]).WebBrowser.ClearHistory;
    FormPublic.CleanNewly;
    NewlyUrl:='';
    end;
  end;
  72:  //CACHE
  begin
    try
    //DelRegCache;
    finally
    TFormWebBrowser(wbList[PageIndex]).WebBrowser.ClearCache;
    end;
  end;
  73:   //Cookies
  begin
    try
    //DelCookie;
    finally
    FormPublic.ClearCookies;
    end;
  end;
  74:
  begin
    DeleteDirFile(TempDir);
  end;
  79:
  begin
    try
    FormPublic.ClearAll;
    FormPublic.ClearCookies;
    //DeleteDir((GetSystemFolderDir(CSIDL_RECENT)));
    finally
    TFormWebBrowser(wbList[PageIndex]).WebBrowser.ClearCache;
    TFormWebBrowser(wbList[PageIndex]).WebBrowser.ClearHistory;
    if DirectoryExists(TempDir) then DeleteDirFile(TempDir);
    FormPublic.ClearAll;
    end;
  end;
  97:
  begin  //MessageBox(FormMain.Handle, '...', '', 0);  //halt; //application.terminate;
    tempI := PageIndex;
    TFormWebBrowser(wbList[PageIndex]).IsPopup:=false;
    Sleep(ClickSleepTime);
    TFormWebBrowser(wbList[tempI]).IsPopup:=true;  //tempI PageIndex
    //StopPopup := StopPopup2;
    if LoadLastOpenFlag then
    begin
      //StopPopup := StopPopup2;
      //ShowWebIcon := ShowWebIcon2;
      ShowWebIcon2 := false;
      //LockWindowUpdate(0);
    end;
  end;
  end;
except end;
end;

//{
function TFormPublic.GetIEHandle(WebBrowser:TEmbeddedWB; ClassName:string):HWND;
var
  hwndChild,hwndTmp:HWND;
  oleCtrl:TOleControl;
  szClass:array [0..255] of char;
begin
try
  oleCtrl:=WebBrowser;
  hwndTmp:=oleCtrl.Handle;
  while (true) do
  begin
    hwndChild:=GetWindow(hwndTmp,GW_CHILD);
    GetClassName(hwndChild,szClass,SizeOf(szClass));
    if (string(szClass)=ClassName) then
    begin
      Result:=hwndChild;
      Exit;
    end;
    hwndTmp:=hwndChild;
  end;
  Result:=0;
except end;
end;
//}

//{
procedure TFormPublic.ENumChildWindows(Hand:HWND);
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

procedure TFormPublic.CloseIEPop;
var
  H:HWnd;
  Text:array [0..255] of Char;
begin
try
  h:=GetWindow(Handle,GW_HWNDFIRST);
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
//}

procedure TFormPublic.NewPage(Index_: Integer; Url: string; Active: Boolean; ShowPageLogoF: Boolean = true);
var
  Button: TToolButton;
  FormWebBrowser: TFormWebBrowser;
  I: Integer;
  IsWhite2: Boolean;
begin
try
  {
  if not CreateTabNewBtnOK then
  begin
    CreateTabNewBtn;
    CreateTabNewBtnOK := true;
  end;
  }
  if ((wbList.Count > 0) and (Trim(Url) <> '') and (LowerCase(Trim(Url)) <> ('about:blank'))) and ((LowerCase(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl)='about:blank') and (not TFormWebBrowser(wbList[PageIndex]).WebBrowser.Busy)) and (not MoreUrlOpen) then
  begin
    for I := 0 to WhiteList.Count - 1 do //ShowMessage(Copy(WhiteList[I], 2, Length(WhiteList[I]) - 1));
    if (Pos(Copy(WhiteList[I], 2, Length(WhiteList[I]) - 1), Url) <> 0) or (Pos(WhiteList[I], Url) <> 0) then
    begin
      TFormWebBrowser(wbList[PageIndex]).CleanADWhite := true;
      TFormWebBrowser(wbList[PageIndex]).NoCleanFlash := true;
      //FormMain.ToolBarStatusBar.Repaint;
    end;
    TFormWebBrowser(wbList[PageIndex]).WebBrowser.Navigate(Url);
    exit;
  end;
  //}
  {
  if ShowCloseHint then
  begin
    ShowCloseOK := true;
    FormMain.ToolBarTabClose.Visible := false;
  end;
  }
  CloseUpdate := false;
  //FormMain.ToolBarTabClose.Hide;
  LockWindowUpdate(FormMain.Handle);   //hoho
  try

  if TabAutoWidth then
  if ((wbList.Count + 1) * TabWidth + 2 > FormMain.ToolBarTabParent.Width) then
  begin
    TabWidth := (FormMain.ToolBarTabParent.Width div (wbList.Count + 1));
    FormMain.ToolBarTabParent.ButtonWidth := TabWidth;
  end;
  //LockWindowUpdate(FormWebBrowser.Handle);   //hoho
  //LockWindowUpdate(Application.Handle);

  try

  if (not AppendTab) or (NewTabAtEnd) then Index_ := wbList.Count;
  NewTabAtEnd := false;
  //if (Trim(Url) = '') or (Trim(Url) = 'about:blank') then Index_ := wbList.Count;

      IsWhite := false;
      for I := 0 to WhiteList.Count - 1 do
      if (Pos(Copy(WhiteList[I], 2, Length(WhiteList[I]) - 1), Url) <> 0)  or (Pos(WhiteList[I], Url) <> 0) then
      begin
        IsWhite := true;
      end;
      IsWhite2 := IsWhite;

      //FormWebBrowser.LWhiteFlag.Caption := '1';
  Button := TToolButton.Create(FormMain.ToolBarTabParent);
  if ShowWebIcon then
  begin
    Case WebIconNeedBlankCount of
    2: if LANGUAGE <= 1 then Button.Caption := '  空白页' else Button.Caption := '  about:blank';
    3: if LANGUAGE <= 1 then Button.Caption := '   空白页' else Button.Caption := '   about:blank';
    4: if LANGUAGE <= 1 then Button.Caption := '    空白页' else Button.Caption := '   about:blank';
    5: if LANGUAGE <= 1 then Button.Caption := '     空白页' else Button.Caption := '   about:blank';
    6: if LANGUAGE <= 1 then Button.Caption := '      空白页' else Button.Caption := '   about:blank';
    end;
  end
  else
  if LANGUAGE <= 1 then
  Button.Caption := '空白页' else Button.Caption := 'about:blank';
  //Button.
  //Button.OnClick := TabClick;
  //Button.Hint := IntToStr(Index_);
  Button.OnMouseDown := TabMouseDown;
  Button.OnMouseUp := TabMouseUp;
  //if ShowCloseHint then Button.OnMouseMove := FormMain.ToolBarTabParentMouseMove; //TabMouseMove;
  Button.ShowHint := true;
  if ShowWebIcon then
  begin
    FormMain.ImageListWebIcon.InsertIcon(Index_, FormMain.ImageWebIcon2.Picture.Icon);
    FormMain.ToolBarTabParent.Repaint;
  end;
  //LockUpdate
    FormWebBrowser := TFormWebBrowser.Create(FormMain.PanelWBMain); //FormMain.PanelWBMain
    wbList.Insert(Index_, FormWebBrowser);
    FormWebBrowser.Parent := FormMain.PanelWBMain;
    //FormWebBrowser.WebBrowser.Loaded;
    if Trim(Url) <> '' then
    begin
      if FormMain.Visible then
      FormPublic.DocumentSetFocus;
      FormWebBrowser.WebBrowser.Silent := true;
      if IsWhite2 then
      begin
        TFormWebBrowser(wbList[Index_]).CleanADWhite := true;
        TFormWebBrowser(wbList[Index_]).NoCleanFlash := true;
      end;
      FormWebBrowser.WebBrowser.Navigate(Url);
      TFormWebBrowser(wbList[Index_]).WebUrl := Url;
      //WebUrl := Url;
    end;

    Button.Parent := FormMain.ToolBarTabParent;

    if Active then
    begin
      PageIndex := Index_;
      FormWebBrowser.Show;
    end
    else
    begin
      TFormWebBrowser(wbList[Index_]).WebBrowser.HandleNeeded;
    end;
    //OldParamS := '';
    FormPublic.TabAutoWidthControl;
  finally
    //LockWindowUpdate(0);   //hoho
    TFormWebBrowser(wbList[PageIndex]).UpdateWebIconOk := false;
    ShowCloseOK := false;
    FormMain.ToolBarTabParent.Repaint;   //newnew
    FormMain.ToolBarTabParent.Refresh;  //FormPublic.TabAutoWidthControl;
    FormMain.ToolButton100.Hint := '100';
    FormMain.ToolButton100.Caption := '100%';
    FormMain.ToolBarStatusBar.Repaint;
    FormMain.ToolBarAddress.Repaint;
  end;
  finally
  LockWindowUpdate(0);
  CloseUpdate := true;
  FormMain.ToolBarMenu.Repaint;
  end;
except end;
end;

procedure TFormPublic.ClosePage(Index_: Integer);
var
  I: Integer;

  WebTitle_, WebUrl_: String;
begin
try
  if (Index_ = 999) then Index_ := PageIndex;
  if TFormWebBrowser(wbList[Index_]).TabLock then
  begin
    //{
    if RightClick then  
    begin
      RightClick := false;
      FormMain.ToolBarTabParent.RePaint;
    end;
    //}
    exit;
  end;
  //CallBackMemory := true;
  TFormWebBrowser(wbList[Index_]).IsPopup:=true;
  WebTitle_ := TFormWebBrowser(wbList[Index_]).WebTitle;
  if (Trim(WebTitle_) = '') or (Trim(WebTitle_) = 'about:blank') then
  WebTitle_ := TFormWebBrowser(wbList[Index_]).WebBrowser.LocationName;
  WebUrl_ := TFormWebBrowser(wbList[Index_]).WebBrowser.LocationUrl;
  //if TFormWebBrowser(wbList[Index_]).WebBrowser.Busy then TFormWebBrowser(wbList[Index_]).WebBrowser.Stop;
  LockWindowUpdate(FormMain.PanelWBMain.Handle);
  try
  try
  if (wbList.Count > 1) then
  begin    TFormWebBrowser(wbList[Index_]).Closeing := true;    TFormWebBrowser(wbList[Index_]).WebBrowser.Navigate('about:blank');    if CallBackMemory then Application.ProcessMessages;    {if ShowCloseHint then FormMain.ToolBarTabClose.Visible := false;}    I := TFormWebBrowser(wbList[Index_]).WebBrowser.Tag;    if  I= LastUnCloseFlag then    begin      if not LoadLastOpenOK then      begin        LoadLastOpenOK := true;        LoadLastOpenFlag := false;        ShowWebIcon2 := false;      end;    end;    {TFormWebBrowser(wbList[Index_]).WebBrowser.Tag := CloseTag;}    TFormWebBrowser(wbList[Index_]).Free;    FormMain.ToolBarTabParent.Buttons[Index_].Free;    if ShowWebIcon then    begin      FormMain.ImageListWebIcon.Delete(Index_);      FormMain.ToolBarTabParent.Repaint;    end;    if Index_ = PageIndex then    begin      if (I= LastUnCloseFlag) and (not GoToNewPage) then      PageIndex := wbList.Count - 1   {      else        if (I= LastUnCloseFlag) and (GoToNewPage) then        PageIndex := wbList.Count - 2    }      else      begin        if (Index_ = wbList.Count -1) then PageIndex := PageIndex - 1        else if not CloseGoTab then if Index_ >= 1 then PageIndex := Index_ - 1;      end;      wbList.Delete(Index_);      if PageIndex >= wbList.Count then      begin        Dec(PageIndex);      end;      if PageIndex = wbList.Count then      begin        Dec(PageIndex);      end;      TabClick2(PageIndex);           I := 0;    end else    begin      wbList.Delete(Index_);    end;  end
  else if (wbList.Count = 1) then
  begin
    try
    //TFormWebBrowser(wbList[Index_]).Closeing := true;
    //FormMain.CBURL.Text := 'about:blank';
    {
    //TFormWebBrowser(wbList[0]).WebBrowser.Navigate('about:blank');
    TFormWebBrowser(wbList[0]).WebBrowser.Hint := 'init';
    if InitControl then
    begin
      //if InitControl then
      //TFormWebBrowser(wbList[0]).WebBrowser.Navigate('about:blank');
      FormMain.CBURL.Text := 'init';
      FormMain.NavigateInit;
    end
    else
    }
    if not LoadLastOpenOK then LoadLastOpenOK := true;

    if (OneTowz and OneTowz2) then
    TFormWebBrowser(wbList[0]).WebBrowser.Navigate(WebNavigationUrl)
    else
    begin
    TFormWebBrowser(wbList[Index_]).WebBrowser.Hint := 'Close0';
    TFormWebBrowser(wbList[Index_]).WebUrl := 'about:blank';
    TFormWebBrowser(wbList[Index_]).WebBrowser.Navigate('about:blank');
    //FormMain.CBURL.Text := 'about:blank';
    //TFormWebBrowser(wbList[Index]).Bool_Back := false;
    //TFormWebBrowser(wbList[Index]).Bool_Forward := false;
    TFormWebBrowser(wbList[Index_]).WebUrl := 'about:blank';
            
    LoadLastOpenOK := true;
    LoadLastOpenFlag := false;
    ShowWebIcon2 := false;

    //if (AlexaEx) then FormMain.StatusBar.Panels[2].Text := '';
    
    if ShowWebIcon then
    FormMain.ImageListWebIcon.ReplaceIcon(0, FormMain.ImageWebIcon2.Picture.Icon);

    //ShowPageLogo(Index_);
    end;


    finally
    if (not OneTowz or not OneTowz2) then
    begin
    FormMain.CBURL.Text := 'about:blank';    FormMain.Panel_StatusBar1.Caption := '';    FormMain.CBURL.Text := 'about:blank';
    //FormPublic.DocumentSetFocus;    kfk
    end;
    //if (EnabledInitPage) and (StartPageTo = 1) then FormMain.NavigateInit;
    //if EnabledGetCount then FormMain.NavigateInit(2);

    FormPublic.NQuickClearMemory.Click;
    //OldParamS := '';
    if TFormWebBrowser(wbList[Index_]).TimerWebAutoRefresh <> nil then
    TFormWebBrowser(wbList[Index_]).TimerWebAutoRefresh.Enabled := false;

    if (ProBar.Visible) then
    begin
      ProBar.Position := 0;
      ProBar.Visible := false;
      //LabelPro.Visible := false;
    end;
    end;
    FormMain.ImageListWebIcon.ReplaceIcon({FormPublic.WebIndex}Index_, FormMain.ImageWebIcon2.Picture.Icon);  
    //FormMain.ToolBarTabParent.Repaint;
    TFormWebBrowser(wbList[Index_]).DownIcon := false;
    BackEnabled := false;
    ForwardEnabled := false;
    {
    case ButtonStyle of
      0: ;
      1:
      begin
      end;
    end;
    }
  end;

    {
    if FormMain.ToolBarTabParent.ButtonCount * TabWidth + 10 < FormMain.ToolBarTabParent.Width then
    begin
      FormMain.ToolBarTabParent.Indent :=  0;
    end
    else
    begin
      if (FormMain.ToolBarTabParent.Indent <> 0) and (((FormMain.ToolBarTabParent.Buttons[PageIndex].Left + TabWidth) < (FormMain.ToolBarTabParent.Indent * -1)) or (FormMain.ToolBarTabParent.Buttons[PageIndex].Left + TabWidth > FormMain.ToolBarTabParent.Indent)) then
      begin
        FormMain.ToolBarTabParent.Indent := ((TabWidth * PageIndex) * -1);
      end;
    end;
    }
    FormPublic.TabAutoWidthControl;
    //OldParamS := '';
  finally
    //LockWindowUpdate(0);
    //if not MoreUrlOpen then
    TFormWebBrowser(wbList[PageIndex]).UpdateWebIconOk := false;
    //FormMain.DrawButtonIcon;
    //FormMain.BBGO.Repaint;
    //FormMain.BBGO.Refresh;
    FormMain.ToolBarTabParent.RePaint;
    FormMain.ToolBarTabParent.Refresh;
    //if B then TabClick2(PageIndex);
    FormMain.ToolBarAddress.Repaint;
    if not NoSaveNewly then
    begin
      NewlyUrl := WebUrl_;
      FormPublic.NewlyCloseAdd(WebTitle_, NewlyUrl);
    end      
    else NoSaveNewly := false;
    if MemoryThrift2 then
    begin
      CloseTabCount := CloseTabCount + 1;
      if CloseTabCount >= 3 then
      begin
        FormPublic.NQuickClearMemory.Click;
        CloseTabCount := 0;
      end;
    end;
  end;
  finally
  LockWindowUpdate(0);
  FormMain.ToolBarMenu.Repaint;
  end;
except end;
end;

{
procedure TFormWebBrowser.TabClick(Sender: TObject);
var
  OldIndex: Integer;
  Title, Url: String;
  I: Integer;
begin
try
  if wbList.Count<=0 then exit;
  LockWindowUpdate(FormMain.PanelWBMain.Handle);
  try
  //FormMain.ToolBarTabParent.Buttons[OldIndex].Font.Size := 10;
  with (Sender as TToolButton) do
  begin
    OldIndex := PageIndex;
    PageIndex := Index;


    if (OldIndex >= 0) and (OldIndex < wbList.Count) then
      FormMain.ToolBarTabParent.Buttons[OldIndex].Repaint;

    TFormWebBrowser(wbList[PageIndex]).Show;

    Title := TFormWebBrowser(wbList[PageIndex]).WebTitle; //TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationName;
    Url :=  Trim(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl);
    if (Url = '') or (LowerCase(Url) = 'about:blank') then
    Url := Trim(TFormWebBrowser(wbList[PageIndex]).WebUrl);

    I := Pos('tn=' + BaiduSearchIDMain, Title);
    if I <> 0 then
    Title := Copy(Title, 1, I - 1) + Copy(Title, I + Length(BaiduSearchIDMain) + 3 + 3 + 1, Length(Title) - I);

    I := Pos('tn=' + BaiduSearchIDMain, Url);
    if I <> 0 then  //ShowMessage(Url+'#'+IntToStr(I));
    Url := Copy(Url, 1, I - 1) + Copy(Url, I + Length(BaiduSearchIDMain) + 3 + 3 + 1, Length(Url) - I);
    //Url := Copy(Url, 1, I - 1) + Copy(Url, I + 10, Length(Url) - I);

    FormMain.ImageGoBack.Enabled := TFormWebBrowser(wbList[PageIndex]).Bool_Back;
    FormMain.ImageGoForward.Enabled := TFormWebBrowser(wbList[PageIndex]).Bool_Forward;

    if ((Trim(Url) <> '') and (LowerCase(Trim(Url)) <> 'about:blank')) then
    begin
      if (TFormWebBrowser(wbList[PageIndex]).WebBrowser.Busy) then
      begin
        FormMain.CBURL.Text := Url;
        FormMain.StatusBar.Panels[0].Text := '>>正在连接地址:' + '<' + Url + '>';
        FormWebbrowser.DocumentSetFocus;
      end
      else
      begin
        FormMain.CBURL.Text := Url;
        FormMain.StatusBar.Panels[0].Text:= '>>' + Title + '<' + Url + '>';
        //FormWebbrowser.DocumentSetFocus;
        if TFormWebBrowser(wbList[PageIndex]).NoCleanAd then
        begin
          if not TFormWebBrowser(wbList[PageIndex]).CleanADWhite then
          ClearAd(TFormWebBrowser(wbList[PageIndex]).WebBrowser, TFormWebBrowser(wbList[PageIndex]).NoCleanFlash);
          TFormWebBrowser(wbList[PageIndex]).NoCleanAd := false;
        end;
        FormWebbrowser.DocumentSetFocus;
      end;
    end
    else
    begin
      FormMain.CBURL.Text := 'about:blank';
      FormMain.StatusBar.Panels[0].Text := '';
      if not (TFormWebBrowser(wbList[PageIndex]).WebBrowser.Busy) then
      if wbList.Count = 1 then DocumentSetFocus
      else AddressSetFocus;
    end;

    if TFormWebBrowser(wbList[PageIndex]).WebBrowser.DefaultInterface.Left<>0 then
    begin
      TFormWebBrowser(wbList[PageIndex]).WebBrowser.DefaultInterface.Left := 0;
      TFormWebBrowser(wbList[PageIndex]).WebBrowser.DefaultInterface.Top  := 0;
    end;

    //if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document<>nil then
    //if TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationURL <> InitPage then TFormWebBrowser(wbList[PageIndex]).WebBrowser.ExecWB(OLECMDID_ZOOM, OLECMDEXECOPT_DONTPROMPTUSER,EmptyParam,t);

    //FormMain.CBURL.Text := Url;
    //StatusBar := Url;
  end;
  finally
    LockWindowUpdate(0);
    if (LowerCase(Trim(Url)) <> 'about:blank') then DocumentSetFocus;
    if ((ProBar<>nil) and (ProBar.Visible)) then
    begin
      ProBar.Position := 0;
      ProBar.Visible := false;
    end;
    if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Silent then
    FormPublic.NCurrNoSilent.Checked := false
    else
    FormPublic.NCurrNoSilent.Checked := true;
  end;
  FormMain.ToolBarStatusBar.Repaint;
except end;
end;
}

procedure TFormPublic.TabClick2(Index_: Integer);
var
  OldIndex: Integer;
  Title, Url: String;
  I: Integer;
  //f: Double;
begin
try
  if wbList.Count<=0 then exit;
  //if not FormMain.visible then exit;
  {
  if PageIndex = Index_ then exit;
  if TFormWebBrowser(wbList[Index_]).Closeing then exit;
  }
  //PostMessage(TFormWebBrowser(wbList[Index_]).WebBrowser.Handle,WM_LBUTTONDOWN,1,1);
  //PostMessage(TFormWebBrowser(wbList[Index_]).WebBrowser.Handle,WM_LBUTTONUP,1,1);
  //SendMessage(TFormWebBrowser(wbList[Index_]).WebBrowser.Handle,BM_Click,0,0);
  //if ShowCloseHint then FormMain.ToolBarTabClose.Hide; //FormPublic.TabCloseHint;
  //CloseHintUpdate := false;
  //if ShowCloseHint then FormMain.ToolBarTabClose.Hide;
  CloseUpdate := false;
  LockWindowUpdate(FormMain.{PanelWBMain.}Handle);
  try
  //FormMain.ToolBarTabParent.Buttons[OldIndex].Font.Size := 10;

    if Index_ = 999 then Index_ := PageIndex;
    
    OldIndex := PageIndex;
    PageIndex := Index_;


    if (ShowCloseHint) and (CloseHintCur <> PageIndex) then FormMain.ToolBarTabClose.Hide;  //hhhhhide

    if (OldIndex >= 0) and (OldIndex < wbList.Count) then
      FormMain.ToolBarTabParent.Buttons[OldIndex].Repaint;

    TFormWebBrowser(wbList[PageIndex]).Show;

    Title := TFormWebBrowser(wbList[PageIndex]).WebTitle;
    if Title = 'about:blank' then
    Title := TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationName;
    Url :=  Trim(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl);
    if (Url = '') or (LowerCase(Url) = 'about:blank') then
    Url := Trim(TFormWebBrowser(wbList[PageIndex]).WebUrl);
    //if (Url = '') then Url := 'about:blank';
         //ShowMessage(TFormWebBrowser(wbList[PageIndex]).WebBrowser.Hint);

    Title := FormPublic.KBDString(Title);
    Url := FormPublic.KBDString(Url);


    //FormMain.ImageGoBack.Enabled := TFormWebBrowser(wbList[PageIndex]).Bool_Back;
    //FormMain.ImageGoForward.Enabled := TFormWebBrowser(wbList[PageIndex]).Bool_Forward;

    //FormMain.ImageGoBack.Picture := FormMain.ImageGoBack0.Picture;
    //FormMain.ImageGoForward.Picture := FormMain.ImageGoForward0.Picture;

    BackEnabled := TFormWebBrowser(wbList[PageIndex]).Bool_Back;
    ForwardEnabled := TFormWebBrowser(wbList[PageIndex]).Bool_Forward;

    CurrBack := BackEnabled;
    CurrForward := ForwardEnabled;

    if (BackEnabled and CurrForward) then bfState := 4
    else if (BackEnabled and not ForwardEnabled) then bfState := 2
    else if (not BackEnabled and ForwardEnabled) then bfState := 3
    else if (not BackEnabled and not ForwardEnabled) then bfState := 1;

    NTabLock.Checked := TFormWebBrowser(wbList[PageIndex]).TabLock;

    case ButtonStyle of
      0:
      begin
        FormMain.TBGoBack.Enabled := BackEnabled;
        FormMain.TBGoForward.Enabled := ForwardEnabled;
      end;
      1:
      begin
      end;
    end;
      //ShowMessage(Url);   exit;
    if EnableTitle then
    begin
      {
      if Length(Title) <= 52 then
      FormMain.Caption := Title + '  -  ' + TitleStr
      else
      FormMain.Caption := Copy(Title, 0, 52) + '...' + '  -  ' + TitleStr;
      }
      //FormMain.Caption := Title + '  -  ' + TitleStr;
      //FormMain.Caption := TitleStr + '  -  ' + Title;
        //if ShowMenu then
        //if Length(Title) > 80 then Title := Copy(Title,1,80) + '...';
        //Title := Copy(Title,1, (FormMain.ToolBarMenu.Width - (FormMain.ToolBarMenu.Width div 2))) + '...';
        case LANGUAGE of
        0,1: FormMain.Caption := TitleStr + '  -  ' + Title;
        2,3: FormMain.Caption := BrowserName + '  -  ' + Title;
        99: FormMain.Caption := BrowserName + '  -  ' + Title;
        end;

    end;

    if LoadLastOpenFlag then
    if (Pos('/' + DataDir + '/' + LastOpenLoadFile, Url) <> 0) then
    begin
      FormMain.CBURL.text := BrowserName + '://Data/' + LastOpenLoadFile;;
      FormMain.Panel_StatusBar1.Caption :=  ' ' + BrowserName + '://Data/' + LastOpenLoadFile;

      exit;
    end;

    FormMain.CBURL.Text := Url;
    FormMain.Panel_StatusBar1.Caption :=  ' >>' + Title + '<' + Url + '>';

    Url := LowerCase(Trim(Url));    
    if ((Url <> '') and {(Url <> 'about:') and} (Url <> 'about:blank')) then
    begin

      if (TFormWebBrowser(wbList[PageIndex]).WebBrowser.Busy) or (TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag = LastUnCloseFlag) then
      begin
        exit;
        //FormMain.StatusBar.Panels[0].Text := '>>正在连接地址:' + '<' + Url + '>';
        ////FormWebbrowser.DocumentSetFocus;
      end
      else
      begin   //exit; //eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
        //FormMain.CBURL.Text := Url;
        //FormMain.StatusBar.Panels[0].Text:= '>>' + Title + '<' + Url + '>';
        FormPublic.DocumentSetFocus;
        if Pos('file://', Url) <> 1 then
        begin    //exit; //eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
        if TFormWebBrowser(wbList[PageIndex]).NoCleanAd then
        begin
          //FormMain.Caption := IntToStr(Random(999999999));
          if not TFormWebBrowser(wbList[PageIndex]).CleanADWhite then
          ClearAd(TFormWebBrowser(wbList[PageIndex]).WebBrowser, TFormWebBrowser(wbList[PageIndex]).NoCleanFlash);
          //if not (TFormWebBrowser(wbList[PageIndex]).WebBrowser.Busy) then
          TFormWebBrowser(wbList[PageIndex]).NoCleanAd := false;

        end;
        end;
        FormPublic.DocumentSetFocus;
      end;
    end
    else
    begin

      FormMain.CBURL.Text := 'about:blank';
      FormMain.Panel_StatusBar1.Caption := '';
      if not (TFormWebBrowser(wbList[PageIndex]).WebBrowser.Busy) then
      if wbList.Count = 1 then FormPublic.DocumentSetFocus
      else FormPublic.AddressSetFocus;
    end;
    //{
    if TFormWebBrowser(wbList[PageIndex]).WebBrowser.DefaultInterface.Left<>0 then
    begin
      TFormWebBrowser(wbList[PageIndex]).WebBrowser.DefaultInterface.Left := 0;
      TFormWebBrowser(wbList[PageIndex]).WebBrowser.DefaultInterface.Top  := 0;
    end;    
    //}

    if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Silent then
    FormPublic.NCurrNoSilent.Checked := false
    else
    FormPublic.NCurrNoSilent.Checked := true;

    //if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document <> nil then
    {
    FormMain.ToolButton100.Caption := '100%';
    FormMain.ToolButton100.Hint := '100';
    TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom := 1.0;
    //i := (TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom);
    //fffffffffffffff
    }
    
    if DocRoll then FormMain.TimerDocRoll.Enabled := false;
    //{
    with TFormWebBrowser(wbList[PageIndex]) do
    FormPublic.NWebAutoRefresh.Checked := (TimerWebAutoRefresh <> nil) and TimerWebAutoRefresh.Enabled;
    //}          //lllllllllllll
    //CloseHintUpdate := true; 
    //if ShowCloseHint then FormPublic.TabCloseHint;
    //}
    //if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document<>nil then
    //if TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationURL <> InitPage then TFormWebBrowser(wbList[PageIndex]).WebBrowser.ExecWB(OLECMDID_ZOOM, OLECMDEXECOPT_DONTPROMPTUSER,EmptyParam,t);

    //FormMain.CBURL.Text := Url;
    //StatusBar := Url;
    //FormMain.FavoritesListView1.EmbeddedWB := TFormWebBrowser(wbList[PageIndex]).WebBrowser;
    //if ShowCloseHint then FormMain.ToolBarTabClose.Show;
    
    //ShowMessage(IntToStr((TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom)*100)); exit;
    FormMain.ToolButton100.Caption := ZoomStr;
    //if Url <> 'about:blank' then
                          
    if TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag = ZoomTag then
    begin
      //FormMain.ToolButton100.Caption := TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom;
      //FormMain.ToolButton100.Hint := TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom;
    end;
    {
    //case (TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom)*100 of
    case StrToInt(Copy(TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom,1,Length(TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom)-1)) of
      50:
      begin
        FormMain.ToolButton100.Caption := '50%';
        FormMain.ToolButton100.Hint := '50';
        //N50.Checked := true;
        //FormPublic.N75.OnClick(Sender);
      end;
      75:
      begin
        FormMain.ToolButton100.Caption := '75%';
        FormMain.ToolButton100.Hint := '75';
        //N75.Checked := true;
      end;
      125:
      begin
        FormMain.ToolButton100.Caption := '125%';
        FormMain.ToolButton100.Hint := '125';
        //N125.Checked := true;
      end;
      150:
      begin
        FormMain.ToolButton100.Caption := '150%';
        FormMain.ToolButton100.Hint := '150';
        //N150.Checked := true;
      end;
      200:
      begin
        FormMain.ToolButton100.Caption := '200%';
        FormMain.ToolButton100.Hint := '200';
        //N200.Checked := true;
      end;
      else
      //1,10,100:
      begin
        FormMain.ToolButton100.Caption := '100%';
        FormMain.ToolButton100.Hint := '100';
        //N100.Checked := true;
      end;
    end;
    //FormMain.ToolButton100.Repaint;
    //FormMain.ToolBarStatusBar.Repaint;
    }
  finally
    LockWindowUpdate(0);
    FormMain.ToolBarMenu.Repaint;
    CloseUpdate := true;
    ShowCloseOK := false;
    if (LowerCase(Trim(Url)) <> 'about:blank') then FormPublic.DocumentSetFocus;
    if (ProBar.Visible) then
    begin
      ProBar.Position := 0;
      ProBar.Visible := false;
      //LabelPro.Visible := false;
    end;
    {
    if  (ProBar.Position <> 0) and (ProBar.Visible) then
    begin
      ProBar.Position := 0;
      ProBar.Visible := false;            
      if LabelPro.Visible then
      LabelPro.Visible := false;
    end;
    }

    //if ((Trim(Url) <> '') and (LowerCase(Trim(Url)) <> 'about:blank')) then FormWebbrowser.DocumentSetFocus;
    //FormMain.BBGO.Repaint;
    //FormMain.BBGO.Refresh;
    FormMain.ToolBarAddress.Repaint;
    FormMain.ToolBarStatusBar.Repaint;
    if PageUnLock then NUnLockWebPage.Click;
  end;
except end;
end;

//标签移动处理
procedure TFormPublic.TabMove(OldIndex, NewIndex, inc, distance: Integer);
var
  I: Integer;
begin
try
  if NewIndex<0 then NewIndex := 0;
  if NewIndex>wbList.Count-1 then NewIndex := wbList.Count-1;
  if (OldIndex<>NewIndex) then
  begin
    try
    wbList.Move(OldIndex, NewIndex);
    //FTS.TabHints.Move(OldIndex, NewIndex);
    //FTS.Indexes.Move(OldIndex, NewIndex);

  //for I:=0 to wbList.Count-1 do TFormWebBrowser(wbList.Objects[I]).Tag := I;
  if inc > 0 then
  FormMain.ToolBarTabParent.Buttons[PageIndex].Left := FormMain.ToolBarTabParent.Buttons[PageIndex + distance].Left
  else
  FormMain.ToolBarTabParent.Buttons[PageIndex].Left := FormMain.ToolBarTabParent.Buttons[PageIndex - distance].Left - 10;

  FormMain.ImageListWebIcon.GetIcon(OldIndex, FormMain.ImageTabIconT2.Picture.icon);
  FormMain.ImageListWebIcon.GetIcon(NewIndex, FormMain.ImageTabIconT1.Picture.icon);
  FormMain.ImageListWebIcon.ReplaceIcon(OldIndex, FormMain.ImageTabIconT1.Picture.Icon);
  FormMain.ImageListWebIcon.ReplaceIcon(NewIndex, FormMain.ImageTabIconT2.Picture.Icon);

  finally
  TabClick2(NewIndex);
  FormPublic.TabAutoWidthControl;
  //FormMain.OnReSize(Sender);
  FormMain.ToolBarTabParent.Repaint;
  end;
  end;
except end;
end;

procedure TFormPublic.TabMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
begin
try
  if (Button=mbLeft) and (ssDouble in Shift) then
  begin
    //TabX := X;
    if DisDblClick then exit;
    //FormWebbrowser.ClosePage(StrToInt(TButton(Sender).Hint));
    //TabClick2((Sender as TToolButton).Index);
    CallBackMemory := false;
    TabClick2((Sender as TToolButton).Index);
    ClosePage((Sender as TToolButton).Index);
    //SendMessage(TFormWebBrowser(wbList[PageIndex]).WebBrowser.Handle,BM_Click,0,0);
    //PostMessage(TFormWebBrowser(wbList[PageIndex]).WebBrowser.Handle,WM_LBUTTONDOWN,1,1);
    //PostMessage(TFormWebBrowser(wbList[PageIndex]).WebBrowser.Handle,WM_LBUTTONUP,1,1);
    {
    if NCallBackMemory.visible then
    begin
      NCallBackMemory.visible := false;
      WritePrivateProfileString('setting', 'NCBMemoryShow', '0', PChar(MyDir+ConfigFile));
    end;
    }
    exit;
  end;
  if (Button=mbLeft) then
  begin
    //FormWebbrowser.ClosePage(StrToInt(TButton(Sender).Hint));
    //ClosePage((Sender as TToolButton).Index);
    //if PageIndex <> ((Sender as TToolButton).Index) then
    TabClick2((Sender as TToolButton).Index);
    //SendMessage(TFormWebBrowser(wbList[PageIndex]).WebBrowser.Handle,BM_Click,0,0);
    //PostMessage(TFormWebBrowser(wbList[PageIndex]).WebBrowser.Handle,WM_LBUTTONDOWN,1,1);
    //PostMessage(TFormWebBrowser(wbList[PageIndex]).WebBrowser.Handle,WM_LBUTTONUP,1,1);

    //FormMain.ToolBarTabParent.Buttons[PageIndex].Left := FormMain.ToolBarTabParent.Buttons[PageIndex - 1].Left - 1;
    //TabMove(PageIndex, PageIndex - 1);
    TabX := X;

    exit;
  end;
  if (Button=mbRight) then
  begin
    if RightClickClose then
    begin     //ShowMessage(IntToStr((Sender as TToolButton).Index));
      //(Sender as TToolButton).Click;
      CallBackMemory := true;
      RightClick := true;
      TabClick2((Sender as TToolButton).Index);
      ClosePage((Sender as TToolButton).Index);
      //if TFormWebBrowser(wbList[(Sender as TToolButton).Index]).TabLock then FormMain.ToolBarTabParent.RePaint;
      //TabRigthClickEnableClose := true;
      {
      if not NCallBackMemory.visible then
      begin
        NCallBackMemory.Checked := true;
        NCallBackMemory.visible := true;
        WritePrivateProfileString('setting', 'NCBMemoryShow', '1', PChar(MyDir+ConfigFile));
      end;
      }
    end
    else
    begin
      FormMain.N_BR_Flag.Tag := (Sender as TToolButton).Index;
      GetCursorPos(P);
      FormMain.PM_ButtonRight.Popup(P.X,P.Y);
    end;
    exit;
  end;
  {
  if (Button=mbMiddle) then
  begin
    TabClick2((Sender as TToolButton).Index);
    ClosePage((Sender as TToolButton).Index);
    exit;
  end;
  }
except end;
end;

procedure TFormPublic.TabMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
try
  if (Button=mbLeft) then
  begin
    NewTabX := X;
    if NewTabX <> TabX then
    begin
      //ShowMessage('.<>.');
      if (NewTabX > TabX) and (NewTabX - TabX > 20) then
      begin   //halt;
        if PageIndex + 1 = wbList.Count then exit;
        TabMove(PageIndex, PageIndex + 1, 1, 1);
        //TabMove(PageIndex, PageIndex + (NewTabX mod Tabx), NewTabX mod Tabx);
      end
      else exit;
      {
      if NewTabX < TabX then
      begin
        if PageIndex = 0 then exit;
        TabMove(PageIndex, PageIndex - 1, -1, 1);
      end;
      }
    end;
  end;
except end;
end;

{
procedure TFormPublic.TabMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  Index: Integer;
  Str: String;
  I: Integer;
begin
try          
  /$IFDEF TabButtonHint/
  /
  if ShowTabHint then
  begin
  Index := wbList.IndexOf(Self);
  Str := TFormWebBrowser(wbList[Index]).WebBrowser.Name;
  I := Length(Str);
  with Sender as TToolButton do
    Hint := Copy(Str, WebIconNeedBlankCount, I - WebIconNeedBlankCount);
    //Hint := TFormWebBrowser(wbList[Index]).WebBrowser.Name;  //.WebTitle;  //Caption; //TFormWebBrowser(wbList[Index]).Caption; //IntToStr(Random(999999));
  end;
  /
  /$ELSE/
  /$ENDIF/
  if not ShowCloseHint then exit;    
  FormPublic.TabCloseHint;
  //FormMain.ToolBarTabClose.Visible := true;
  FormMain.TimerTabClose.Enabled := true;
  //with Sender as TToolButton do Hint := Caption;
  //(Sender as TToolButton).Hint := Caption;
  //with Sender as TToolButton do Hint := TFormWebBrowser(wbList[Index]).Caption;
except end;
end;
}

procedure TFormPublic.GetIniData;
var
  IniFile: TIniFile;
  //WindowMax: Shortstring;
  //S_SideCote:ShortString;
  //S_SideStatShape:ShortString;
begin
try                             
  if AppToExit then exit;  
  IniFile := TIniFile.Create(MyDir + ConfigFile);
  try
  //WindowMax := IniFile.ReadString('RunData', 'WindowMax', '1');
  HopeTabWidth := StrToIntDef(IniFile.ReadString('RunData', 'TabWidth', '150'), 150);    
  //MusicPlayType := StrToInt(IniFile.ReadString('RunData', 'MusicPlayType', '0'));
  FaceStyle := StrToInt(IniFile.ReadString('RunData', 'FaceStyle', '0'));
  TabStyle := StrToInt(IniFile.ReadString('RunData', 'TabStyle', '0'));    
  //ButtonStyle := StrToInt(IniFile.ReadString('RunData', 'ButtonStyle', '0'));
  SideAt := StrToInt(IniFile.ReadString('RunData', 'SideAt', '1'));

  SearchOn := StrToInt(IniFile.ReadString('RunData', 'SearchOn', SearchOnI));
                  
  //是否显示菜单栏
  if IniFile.ReadString('RunData', 'ShowMenu', '1') = '0' then ShowMenu := false else ShowMenu := true;
  //if IniFile.ReadString('RunData', 'ShowButton', '1') = '0' then ShowButton := false;
  if IniFile.ReadString('RunData', 'StatusBarV', '1') = '0' then StatusBarV := false else StatusBarV := true;
  if IniFile.ReadString('RunData', 'StatusBarExtend', '1') = '0' then StatusBarExtend := false else StatusBarExtend := true;
  if IniFile.ReadString('RunData', 'AutoRefresh', '1') = '0' then AutoRefresh := false else AutoRefresh := true;

  //if IniFile.ReadString('RunData', 'v328ok', '0') = '1' then v328ok := true;

  if not AutoRefresh then
  begin
    AutoRefreshTxt := IniFile.ReadString('RunData', 'AutoRefreshTxt', '');
  end;
  //是否允许浏览器标题栏显示网页标题
  //if IniFile.ReadString('RunData', 'EnableTitle', '1') = '0' then EnableTitle := false;

  {
  if IniFile.ReadString('RunData', 'CommendVisible', '1') = '0' then
  CommendVisible := false
  else
  begin
  CommendVisible := true;
  CommendUpdateInt := StrToInt(IniFile.ReadString('RunData', 'CommendUpdateInt', IntToStr(CommendFileInt)));
  end;
  }
  if IniFile.ReadString('RunData', 'RunOne', '1') = '1' then RunOne := true
  else RunOne := false;
  if IniFile.ReadString('RunData', 'ShowSideCote', '0') = '1' then ShowSideCote := true
  else ShowSideCote := false;
  //{
  if IniFile.ReadString('RunData','SideStatShape','0') = '1' then SideStatShape := true
  else SideStatShape := false;
  //}
  if IniFile.ReadString('RunData', 'FavoritCote', '0') = '1' then FavoritCote := true
  else FavoritCote := false;

  if IniFile.ReadString('RunData', 'FormsAutoComplete', '1') = '1' then FormsAutoComplete := true
  else FormsAutoComplete := false;

  if IniFile.ReadString('RunData', 'WindowMax', '1') = '1' then WindowMax := true
  else
  begin
    WindowMax := false;
    MainFormTop := StrToInt(IniFile.ReadString('RunData', 'MainFormTop', '131'));
    MainFormHeight := StrToInt(IniFile.ReadString('RunData', 'MainFormHeight', '600'));
    MainFormLeft := StrToInt(IniFile.ReadString('RunData', 'MainFormLeft', '263'));
    MainFormWidth := StrToInt(IniFile.ReadString('RunData', 'MainFormWidth', '855'));
  end;

  if IniFile.ReadString('RunData', 'FirstRun', '1') = '1' then
  begin
    firstrun := true;
    WritePrivateProfileString('RunData','firstrun','0',PChar(MyDir+ConfigFile));
  end
  else firstrun := false;

  case ForceDefaultBrowser of
  0:
  begin
    if IniFile.ReadString('RunData', 'CheckDefaultBrowser', '1') = '1' then CheckDefaultBrowser := true
    else CheckDefaultBrowser := false;
  end;
  end;
  if IniFile.ReadString('RunData', 'StopPopup', '1') = '1' then
  begin
    StopPopup := true;
    StopPopupO2 := true;
  end
  else StopPopup := false;
  if IniFile.ReadString('RunData', 'StopFloatAd', '0') = '1' then StopFloatAd := true
  else StopFloatAd := false;
  if IniFile.ReadString('RunData', 'StopFlashAd', '0') = '1' then StopFlashAd := true
  else StopFlashAd := false;

  if IniFile.ReadString('RunData', 'UseProxy', '0') = '1' then B_UseProxy := true
  else B_UseProxy := false;    //UseProxy: Boolean = false;  //使用自己的代理
  if IniFile.ReadString('RunData', 'UseIEProxy', '1') = '1' then B_UseIEProxy := true
  else B_UseIEProxy := false;    //UseIEProxy: Boolean = false;  //使用IE的代理
  SideCoteWidth := StrToIntDef(IniFile.ReadString('RunData', 'SideCoteWidth', '233'), 233);
  {
  if IniFile.ReadString('RunData', 'AutoUpdateHint', '1') = '1' then AutoUpdateHint := true
  else AutoUpdateHint := false;   //自动更新提示
  }
  if IniFile.ReadString('RunData', 'TabAutoWidth', '1') = '1' then TabAutoWidth := true
  else TabAutoWidth := false;   //自动适应标签
  if IniFile.ReadString('RunData', 'MemThrift', '0') = '1' then MemoryThrift := true
  else MemoryThrift := false;   //内存节约模式
  if IniFile.ReadString('RunData', 'DocRoll', '0') = '1' then DocRoll := true
  else DocRoll := false;   //双击网页文档是否自动滚屏
  if IniFile.ReadString('RunData', 'StatusTextEnabled', '1') = '1' then StatusTextEnabled := true
  else StatusTextEnabled := false;   //是否允许显示状态栏字符串
  {
  if IniFile.ReadString('RunData', 'ShowTabHint', '0') = '1' then ShowTabHint := true
  else ShowTabHint := false;   //是否允许显示标签的提示
  }

  if IniFile.ReadString('RunData', 'GetScreenSave', '1') = '1' then GetScreenSave := true;  //屏幕抓图是否保存到文件

  if IniFile.ReadString('RunData', 'LoadLastOpenFlag', '1') = '0' then  LoadLastOpenFlag := false;

  //以下是各按钮是否显示的参数读取

  {
  if IniFile.ReadString('RunData', 'OnlyCurrentPage', '0') = '1' then OnlyCurrentPage := true
  else OnlyCurrentPage := false;
  }

  //if TempBoolFlag then
  //if StrToIntDef(IniFile.ReadString('RunData', 'TempBoolOk3', '0'), 0) = 1 then TempBoolOk3 := true;

  if IniFile.ReadString('RunData', 'HintUpdate', '1') = '0' then HintUpdate := false;

  //==

  TabAt := StrToInt(IniFile.ReadString('setting', 'TabAt', '0'));
  
  if IniFile.ReadString('setting', 'LoadUrlHistory', '1') = '1' then LoadUrlHistory := true
  else LoadUrlHistory := false;  //LoadUrlHistory: Boolean = true; //载入浏览历史
  if IniFile.ReadString('setting', 'FavoritMenu', '1') = '1' then FavoritMenu := true
  else FavoritMenu := false;  //FavoritMenu收藏夹菜单
  if IniFile.ReadString('setting', 'LoadLastTime', '1') = '1' then LoadLastTime := true
  else LoadLastTime := false;    //LoadLastTime: Boolean = true; //载入上次浏览内容

  FormMain.TimerOne.Enabled := true;      
  //{
  if IniFile.ReadString('setting', 'CreateOneTab', '1') = '1' then CreateOneTab := true
  else CreateOneTab := false;    //CreateOneTab: Boolean = true; //启动后创建一个标签
  //}

  Replace10:=IniFile.ReadString('setting','Replace10','10');
  Replace11:=IniFile.ReadString('setting','Replace11','11');

  StartPageTo := StrToInt(IniFile.ReadString('setting', 'StartPageTo', StartPageToI));
  OpenToUrl := IniFile.ReadString('setting', 'OpenToUrl', OpenToUrlStr);

  if IniFile.ReadString('setting', 'ExitCleanAllHistory', '0') = '1' then ExitCleanAllHistory := true
  else ExitCleanAllHistory := false;    //ExitCleanAllHistory: Boolean = false; //退出时清除所有浏览器记录
  if IniFile.ReadString('setting', 'CleanAddress', '0') = '1' then CleanAddress := true
  else CleanAddress := false;    //CleanAddress: Boolean = false;
  if IniFile.ReadString('setting', 'CleanHistory', '0') = '1' then CleanHistory := true
  else CleanHistory := false;    //CleanHistory: Boolean = false;
  if IniFile.ReadString('setting', 'CleanCache', '0') = '1' then CleanCache := true
  else CleanCache := false;    //CleanCache: Boolean = false;
  if IniFile.ReadString('setting', 'CleanCookies', '0') = '1' then CleanCookies := true
  else CleanCookies := false;    //CleanCookies: Boolean = false;
  if IniFile.ReadString('setting', 'CleanRecent', '0') = '1' then CleanRecent := true
  else CleanRecent := false;    //CleanRecent: Boolean = false;

  if IniFile.ReadString('setting', 'GoToNewPage', '1') = '1' then GoToNewPage := true
  else GoToNewPage := false;  //GoToNewPage: Boolean = false; //打开新页面时是否转到新页面
  //{
  if IniFile.ReadString('setting', 'InstallTrayIcon', '1') = '1' then InstallTrayIcon := true
  else InstallTrayIcon := false;
  //}
  {
  if IniFile.ReadString('setting', 'HoldOneTab', '1') = '1' then HoldOneTab := true
  else HoldOneTab := false;    //HoldOneTab: Boolean = true; //关闭标签是否保留最后一个标签
  }
  if IniFile.ReadString('setting', 'AppendTab', '1') = '1' then AppendTab := true
  else AppendTab := false;    //AppendTab: Boolean = true;   //是否在当前页后面追加标签
  if IniFile.ReadString('setting', 'CloseGoTab', '1') = '0' then CloseGoTab := true
  else CloseGoTab := false;    //CloseGoTab: Boolean = true;   //关闭页面后是否转到后一标签
  if IniFile.ReadString('setting', 'RightClickClose', '1') = '1' then RightClickClose := true
  else RightClickClose := false;    //RightClickClose: Boolean = true; //标签上鼠标右键是否关闭页面

  if IniFile.ReadString('setting', 'SearchShow', '1') = '1' then SearchShow := true;

  if IniFile.ReadString('setting', 'InitForce', '0') = '1' then InitForce := true else InitForce := false;

  //if IniFile.ReadString('setting', 'MenuImage', '1') = '0' then MenuImage := false;

  StatusBarStrDT := IniFile.ReadString('setting', 'StatusBarStrDT', '');   //StatusBarStrDT: 状态显示.

  if IniFile.ReadString('setting', 'ShowWebIcon', '1') = '1' then ShowWebIcon := true
  else ShowWebIcon := false;

  if IniFile.ReadString('setting', 'ShowCloseHint', '1') = '1' then ShowCloseHint := true else ShowCloseHint := false;   //显示标签关闭小按钮

  ZoomStr := IniFile.ReadString('setting', 'ZoomStr', '100%');

  if IniFile.ReadString('setting', 'UseMouseSS', '0') = '1' then
  begin
    UseMouseSS := true;
    SSTop := StrToInt(IniFile.ReadString('setting', 'SSTop', '11'));
    SSButtom := StrToInt(IniFile.ReadString('setting', 'SSButtom', '10'));
    SSLeft := StrToInt(IniFile.ReadString('setting', 'SSLeft', '5'));
    SSRight := StrToInt(IniFile.ReadString('setting', 'SSRight', '6'));
    SSRightTop := StrToInt(IniFile.ReadString('setting', 'SSRightTop', '0'));
    SSRightButtom := StrToInt(IniFile.ReadString('setting', 'SSRightButtom', '0'));
  end
  else UseMouseSS := false;  //UseMouseSS: Boolean = false; //是否允许鼠标手势

  WeatherCityName := IniFile.ReadString('setting', 'WeatherCityName', '');  //天气预报城市

  {
  if IniFile.ReadString('setting', 'CallBackMemory', '1') = '1' then CallBackMemory := true
  else CallBackMemory := false;

  if IniFile.ReadString('setting', 'NCBMemoryShow', '0') = '1' then CBMemoryShow := true
  else CBMemoryShow := false;
  }
  //{
  if IniFile.ReadString('setting', 'AppCloseHint', '0') = '1' then AppCloseHint := true
  else AppCloseHint := false;
  //}
  if IniFile.ReadString('setting', 'AlwaysNewTab', '1') = '0' then AlwaysNewTab := false else AlwaysNewTab := true;

  if IniFile.ReadString('setting', 'NoClose', '0') = '1' then NoClose := true;

  //if IniFile.ReadString('setting', 'EnabledShowPageLogo', '1') = '1' then EnabledShowPageLogo := true;
  //==

  FormMain.ToolBarTabParent.ButtonWidth := TabWidth;

  WeatherSource := StrToIntDef(IniFile.ReadString('setting', 'WeatherPageSource', '1'), 1);

  FormMain.ToolBarMenu.Font.Size := StrToIntDef(IniFile.ReadString('setting', 'MenuFontSize', '9'), 9);
  //FormMain.StatusBar.Panels[0].Width := StrToIntDef(IniFile.ReadString('setting', 'Panels0Width', '578'), 578);

  LANGUAGE := StrToIntDef(IniFile.ReadString('setting', 'Language', '0'), 0);

  if IniFile.ReadString('setting', 'DisDblClick', '0') = '1' then DisDblClick := true;
                    
  if IniFile.ReadString('setting', 'AddressFocus', '0') = '1' then AddressFocus := true;

  if IniFile.ReadString('setting', 'TabRClickNewPage', '1') = '1' then TabRClickNewPage := true;

  if IniFile.ReadString('setting', 'HideBorder', '1') = '0' then HideBorder := false;

  if IniFile.ReadString('setting', 'TBTabNewShow', '1') = '1' then  TBTabNewShow := true;

  if (IniFile.ReadString('setting', 'UpdateAtOne', '0') = '1') then
  begin
    UpdateAtOne := true;
    if (not FileExists(MyDir + UpdateFileName)) then UpdateAtOne := false;
  end;

  if IniFile.ReadString('setting', 'FavDirMe', '0') = '1' then
  begin
    FavDirMe := true;
    FavoritFolder := IniFile.ReadString('setting', 'FavoritFolder', '');
  end;
  
  if IniFile.ReadString('setting', 'AlexaEx', '1') = '0' then AlexaEx := false;

  MusicPlayOrder := StrToIntDef(IniFile.ReadString('setting', 'MusicPlayOrder', '2'), 2);
  if IniFile.ReadString('setting', 'OnlyPlayOne', '0') = '1' then OnlyPlayOne := true;

  SearchChange := StrToInt(IniFile.ReadString('setting', 'SearchChange', '0'));

  BossKey := IniFile.ReadString('setting', 'BossKey', 'Alt+`');

  //{   
  NickName := IniFile.ReadString('setting', 'NickName', '');
  UserName := IniFile.ReadString('setting', 'UserName', '');
  PassWord := IniFile.ReadString('setting', 'PassWord', '');
  Answer := IniFile.ReadString('setting', 'Answer', '');
  Email := IniFile.ReadString('setting', 'Email', '');
  RealName := IniFile.ReadString('setting', 'RealName', '');
  //}
                              
  ImgSaveDir := IniFile.ReadString('setting', 'ImgSaveDir', '');

  if IniFile.ReadString('setting', 'onewz', '1') = '0' then OneTowz2 := false;

  //if IniFile.ReadString('setting', 'rlink', '1') = '0' then rlink2 := false;

  if IniFile.ReadString('setting', 'DGIndex', '1') = '0' then DGIndex2 := false;

  if IniFile.ReadString('setting', 'tcno', '0') = '1' then tcno := true;

  FormMain.ImageList1.Replace(0, FormMain.ImageC11.Picture.BitMap, nil);
  FormMain.ImageList1.Replace(1, FormMain.ImageC211.Picture.BitMap, nil);
  FormMain.ImageList1.Replace(2, FormMain.ImageC31.Picture.BitMap, nil);
  FormMain.ImageList1.Replace(3, FormMain.ImageC12.Picture.BitMap, nil);
  FormMain.ImageList1.Replace(4, FormMain.ImageC212.Picture.BitMap, nil);
  FormMain.ImageList1.Replace(5, FormMain.ImageC32.Picture.BitMap, nil);

  TabNull := StrToInt(IniFile.ReadString('setting', 'TabNull', '0'));

  if IniFile.ReadString('setting', 'ShowGroup', '0') = '1' then ShowGroup := true;

  finally
    TabWidth := HopeTabWidth;
    if WindowMax then        
    begin
      WindowStateII := 2;  //kokokk
      FormMain.WindowState := wsMaximized;
      //if GetScreenWH('W') = '800' then FormMain.StatusBar.Panels[0].Width := FormMain.StatusBar.Panels[0].Width - 100
      //else if GetScreenWH('W') = '1024' then FormMain.StatusBar.Panels[0].Width := FormMain.StatusBar.Panels[0].Width - 40;
      //FormMain.Top := 0;
      //FormMain.Height := Screen.WorkAreaHeight - 2;
    end
    else
    begin
      WindowStateII := 1;

      FormMain.ImageList1.Replace(1, FormMain.ImageC221.Picture.BitMap, nil);
      FormMain.ImageList1.Replace(4, FormMain.ImageC222.Picture.BitMap, nil);

      //FormMain.Position := poDefault;
      //WindowState := wsNormal;
      FormMain.Top := MainFormTop;
      //if MainFormHeight >= 600 then
      FormMain.Height := MainFormHeight;
      FormMain.Left := MainFormLeft;
      FormMain.Width := MainFormWidth;
    end;
    //CopyFile(PChar(MyDir + ConfigFile), PChar(MyDir + 'Config2.ini'), false);
    IniFile.Free;
  end;
except end;
end;

procedure TFormPublic.ReadContentControl;
var
  IniFile: TIniFile;
begin
try
  IniFile := TIniFile.Create(MyDir + ConfigFile);
  try
  if IniFile.ReadString('setting', 'NoImage', '0') = '1' then NoImage := true else NoImage := false;
  if IniFile.ReadString('setting', 'NoVideo', '0') = '1' then NoVideo := true else NoVideo := false;
  if IniFile.ReadString('setting', 'NoBgsound', '0') = '1' then NoBgsound := true else NoBgsound := false;
  if IniFile.ReadString('setting', 'NoJava', '0') = '1' then NoJava := true else NoJava := false;
  if IniFile.ReadString('setting', 'NoScript', '0') = '1' then NoScript := true else NoScript := false;
  if IniFile.ReadString('setting', 'NoActivex', '0') = '1' then NoActivex := true else NoActivex := false;

  if NoImage then NNoImage.Checked := true;
  if NoVideo then NNoVideo.Checked := true;
  if NoBgsound then NNoBgsound.Checked := true;
  if NoJava then NNoJava.Checked := true;
  if NoScript then NNoScript.Checked := true;
  if NoActivex then NNoActivex.Checked := true;
  finally
    IniFile.Free;
  end;
except end;
end;

{
procedure TFormPublic.ShowPageLogo(Index: Integer);
var              
  Str, Url: String;
begin
try
  if not EnabledShowPageLogo then exit;

  if Index = 999 then Index := PageIndex;

      CheckShowImg;

      Str := MyDir + DataDir + '\' + ShowImg;

      Url := '<TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>' +
           '<TBODY>' +
           '<TR>' +
           '<TD vAlign=bottom align=left>' +
           '<IMG src='+'"'+Str+'"'+'>' +
           '</TD>' +
           '</TR>' +
           '</TBODY>' +
           '</TABLE>';
      TFormWebBrowser(wbList[Index]).WebBrowser.AssignDocument;
      (TFormWebBrowser(wbList[Index]).WebBrowser.Document as IHTMLDocument2).body.innerHTML := Url;
except end;
end;
}

{
procedure TFormPublic.CheckShowImg;
var
  Res:TReSourceStream;
begin
try                  
  if not EnabledShowPageLogo then exit;
  if not FileExists(MyDir + DataDir + '\' + ShowImg) then
  begin
    Res:=TResourceStream.Create(Hinstance,'abc_gif',PChar('gif'));
    Res.SaveToFile(MyDir + DataDir + '\' + 'abc.gif');
    Res.Free;
  end;
except end;
end;
}

procedure TFormPublic.GetUnClose;
var
  Res:TReSourceStream;
begin
try
  {
  if (Version ='3.2.8') and (not v328ok) then
  begin
    if GoToNewPage then
    Res:=TResourceStream.Create(Hinstance,'lastunclose_htm',PChar('htm'))
    else
    Res:=TResourceStream.Create(Hinstance,'lastunclose2_htm',PChar('htm'));
    Res.SaveToFile(MyDir + DataDir + '\' + LastOpenLoadFile);
    WritePrivateProfileString('RunData','v328ok','1',PChar(MyDir+ConfigFile));
    Res.Free;
    exit;
  end;
  }
  if (not FileExists(MyDir + DataDir + '\' + LastOpenLoadFile)) then
  begin
  if GoToNewPage then
  Res:=TResourceStream.Create(Hinstance,'lastunclose_htm',PChar('htm'))
  else
  Res:=TResourceStream.Create(Hinstance,'lastunclose2_htm',PChar('htm'));
  Res.SaveToFile(MyDir + DataDir + '\' + LastOpenLoadFile);
  Res.Free;
  end;
  if not FileExists(MyDir + DataDir + '\' + 'checked.gif') then
  begin
  Res:=TResourceStream.Create(Hinstance,'checked_gif',PChar('gif'));
  Res.SaveToFile(MyDir + DataDir + '\' + 'checked.gif');
  Res.Free;
  end;
  if not FileExists(MyDir + DataDir + '\' + 'unchecked.gif') then
  begin
  Res:=TResourceStream.Create(Hinstance,'unchecked_gif',PChar('gif'));
  Res.SaveToFile(MyDir + DataDir + '\' + 'unchecked.gif');
  Res.Free;
  end;
  {
  if TempBoolFlag then
  begin
    if not TempBoolOk3 then
    begin
      if GoToNewPage then
      Res:=TResourceStream.Create(Hinstance,'lastunclose_htm',PChar('htm'))
      else
      Res:=TResourceStream.Create(Hinstance,'lastunclose2_htm',PChar('htm'));
      Res.SaveToFile(MyDir + DataDir + '\' + LastOpenLoadFile);
      WritePrivateProfileString('RunData','TempBoolOk3','1',PChar(MyDir + ConfigFile));
      Res.Free;
    end;
  end;
  }
except end;
end;
                   
procedure TFormPublic.UseData(Sender:TObject);
var
  OpenToUrl2: String;
  Res: TReSourceStream;
begin
try
  if AppToExit then exit;
  try
  //MemoryThrift := true;
  //{  //kk
  if TabAt = 1 then
  begin
    //SetForm.RBTabAt1.Checked := true;
    //FormMain.PaintPanelMTop.Parent := FormMain;
    FormMain.PaintPanelMTop.Align := alBottom;
  end;
  //}
  //=[RunData]中的数据值=开始==
  //ShowSideCoteInit := false;
  if ShowSideCote then NSideCote.OnClick(Sender);  //侧边栏
  //ShowSideCoteInit := true;

  if ShowGroup then
  begin
    FormMain.PaintPanelMenu2.Width := FormMain.PaintPanelMenu2.Width + 60;
    NGroup.Visible := true;
  end;
  if {not} ShowMenu then NShowMenu.Click;
  if not StatusBarV then NNStatusBarV.Click;
  if not StatusBarExtend then NStatusBarE.Click;
  //if not ShowButton then NShowButton.Click;

  if FavoritCote then NFavoritCote.OnClick(Sender);   //收藏栏
  //状态栏
  if StopPopup then NStopPopup.Checked := true;  //弹窗过滤
  if StopFloatAd then NStopFloatAd.Checked := true;  //漂浮过滤
  //FLASH过滤
  if StopFlashAd then NStopFlashAd.Checked := true;     //dddddddd
  //{
  if B_UseIEProxy then    
  begin
    NNoUseProxy.Checked := false;
    NUseIEProxy.Checked := true;
    CheckProxy;
  end
  else
  if B_UseProxy then   //使用自己的代理
  begin
    SetForm.BLoadProxyList.Click;
    if SetForm.ListBoxProxyList.Items.Count > 0 then
    begin
      NSetProxy.Checked := true;
      //str := SetForm.ListBoxProxyList.Items.Strings[0];   fdgfdgf
      FormPublic.NSetProxy.Checked := true;
      SetForm.CBUseProxy.Checked := true;
      SetForm.BProxySetOK.Enabled := false;
      UseProxy(SetForm.ListBoxProxyList.Items.Strings[0]);
    end;
  end
  else
  begin
    NNoUseProxy.Checked := true;
    SetForm.CBUseProxy.Checked:=false;
    SetForm.CBNoUseProxy.Checked:=true;
    SetForm.BProxySetOK.Enabled := false;
    NotProxy;
  end;
  //}
  //{
  if RunOne then NRunOne.Checked := true
  else NRunOne.Checked := false;   //运行一个浏览器实例
  //}
  //if RunOne then NRunOne.OnClick(Sender);
  if SideCoteWidth < 100 then SideCoteWidth := 233;
  FormMain.PanelLeft.Width := SideCoteWidth;

  case TabStyle of
   0:
   begin
     //{
     NTabStyle0.OnClick(Sender);
     NTabStyle0.Checked := true;
     //}
   end;
   1:
   begin
     NTabStyle1.OnClick(Sender);
     NTabStyle1.Checked := true;
   end;      
   2:
   begin
     NTabStyle2.OnClick(Sender);
     NTabStyle2.Checked := true;
   end;
  end;

  case FaceStyle of      
   0:
   begin
   end;
   1:
   begin
     NFaceStyle1.OnClick(Sender);
     NFaceStyle1.Checked := true;
   end;
   2:
   begin
     NFaceStyle2.OnClick(Sender);
     NFaceStyle2.Checked := true;
   end;
   3:
   begin
     NFaceStyle3.OnClick(Sender);
     NFaceStyle3.Checked := true;
   end;
  end;
  
  if not AlwaysNewTab then SetForm.RBNewTabY.Checked := true; //.OnClick(Sender);
    
    if LANGUAGE <= 1 then
    begin
    case SearchOn of
      0,1:
      begin
        FormMain.NSearch1.Checked := true;
        //FormMain.LabelSearchName.Caption := SearchID1Name;
        FormMain.ComboBoxSearch.Text := SearchID1NameShow;
      end;
      2:
      begin
        //if FileExists(MyDir + 'txt.txt') then
        //begin
          FormMain.NSearch2.Checked := true;
          //FormMain.LabelSearchName.Caption := SearchID2Name;
          FormMain.ComboBoxSearch.Text := SearchID2NameShow;
        //end;
      end;
      3:
      begin
        FormMain.NSearch3.Checked := true;
        //FormMain.LabelSearchName.Caption := SearchID3Name;
        FormMain.ComboBoxSearch.Text := SearchID3NameShow;
      end;
      4:
      begin
        FormMain.NSearch4.Checked := true;
        //FormMain.LabelSearchName.Caption := SearchID4Name;
        FormMain.ComboBoxSearch.Text := SearchID4NameShow;
      end;
      5:
      begin    
        FormMain.NSearch5.Checked := true;
        //FormMain.LabelSearchName.Caption := SearchID5Name;
        FormMain.ComboBoxSearch.Text := SearchID5NameShow;
      end;
      6:
      begin
        FormMain.NSearch6.Checked := true;
        //FormMain.LabelSearchName.Caption := SearchID6Name;
        FormMain.ComboBoxSearch.Text := SearchID6NameShow;
      end;
      7:
      begin         
        FormMain.NSearch7.Checked := true;
        //FormMain.LabelSearchName.Caption := SearchID7Name;
        FormMain.ComboBoxSearch.Text := SearchID7NameShow;
      end;
    end;
    end
    else
    begin
    case SearchOn of
      0,1:
      begin
        FormMain.NSearch1.Checked := true;
        //FormMain.LabelSearchName.Caption := SearchID1NameE;
        FormMain.ComboBoxSearch.Text := SearchID1NameShow;
      end;
      2:
      begin
        FormMain.NSearch2.Checked := true;
        //FormMain.LabelSearchName.Caption := SearchID2NameE;
        FormMain.ComboBoxSearch.Text := SearchID2NameShow;
      end;
      3:
      begin
        FormMain.NSearch3.Checked := true;
        //FormMain.LabelSearchName.Caption := SearchID3NameE;
        FormMain.ComboBoxSearch.Text := SearchID3NameShow;
      end;
      4:
      begin
        FormMain.NSearch4.Checked := true;
        //FormMain.LabelSearchName.Caption := SearchID4NameE;
        FormMain.ComboBoxSearch.Text := SearchID4NameShow;
      end;
      5:
      begin
        FormMain.NSearch5.Checked := true;
        //FormMain.LabelSearchName.Caption := SearchID5NameE;
        FormMain.ComboBoxSearch.Text := SearchID5NameShow;
      end;
      6:
      begin
        FormMain.NSearch6.Checked := true;
        //FormMain.LabelSearchName.Caption := SearchID6NameE;
        FormMain.ComboBoxSearch.Text := SearchID6NameShow;
      end;
      7:
      begin
        FormMain.NSearch7.Checked := true;
        //FormMain.LabelSearchName.Caption := SearchID7NameE;
        FormMain.ComboBoxSearch.Text := SearchID7NameShow;
      end;
    end;
    end;

    FormMain.ComboBoxSearch.Font.Color := clGray;

  if TabAutoWidth then NTabAutoWidth.Checked := true;

  if SideStatShape then
  begin
    FormMain.TimerSide.Enabled := true;
    FormMain.ToolBarLeftTopControl.Images := FormMain.ImageList31;
    FormMain.Splitter1.Hide;
  end;

  case SideAt of
  0,1: FormMain.ToolButtonFav.OnClick(Sender);
  2:  FormMain.ToolButtonMusicPlay.OnClick(Sender);
  end;
                                 
  case MusicPlayOrder of
  1: FormMain.NOrderPlay.Checked := true;
  2: ;
  end;
  if OnlyPlayOne then FormMain.NOnlyOne.Checked := true;

  //=[RunData]中的数据值=结束==

  //==根据相关数据值进行动作=开始==
  if InstallTrayIcon then InstallIcon(True,FormMain.Handle,Application.Icon.Handle,TitleStr);
  if LoadUrlHistory then
  if FileExists(MyDir + UrlFile) then
  FormMain.CBURL.Items.LoadFromFile(MyDir + UrlFile);

  //if CBMemoryShow then NCallBackMemory.Visible := true;

  if not SearchShow then
  begin
    FormMain.ToolBarSearchEdit.Hide;
    FormMain.ComboBoxSearch.Hide;
    FormMain.ToolBarSearchButton.Hide;
    NSearchShow.Checked := false;
    NShowSearch.Checked := false
  end;

  if Win32Platform=VER_PLATFORM_WIN32_NT then Win32_NT := true;
  NAtMemThrift.Checked := MemoryThrift;
  if MemoryThrift then TimerMemoryThrift.Enabled := true;


  if (CreateOneTab) and (ParamCount=0)  then
  begin
    FormMain.ToolButtonTabNew.OnClick(Sender);
    //FormMain.ToolBarAddress.Repaint;
  end;

  //主页/首页/开始页  
  //if (InitForce) and ((Trim(InitUrl) <> '') or (Trim(OpenToUrl) <> '')) then StartPageTo := 2;

  if not firstRun then
  if (OpenToUrl = OpenToUrlStr) then OpenToUrl := OpenToUrlStr2;
    
  case StartPageTo of
  0: ;
  1:
  begin
    OpenToUrl2 := ReadRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Internet Explorer\Main',0,'Start Page');
    if (Trim(OpenToUrl2) = '') or (Trim(OpenToUrl2) = 'about:blank') then OpenToUrl2 := OpenToUrl;
    if Trim(OpenToUrl2) <> '' then
    begin     
      FormMain.CBURL.Text := OpenToUrl2;
      TFormWebBrowser(wbList[0]).WebTitle := OpenToUrl2;
      //TFormWebBrowser(wbList[0]).WebBrowser.Hint := 'OPENTOURL';
      TFormWebBrowser(wbList[0]).WebBrowser.Navigate(OpenToUrl2);
    end;
    //if EnabledInitPage then FormMain.NavigateInit;
  end;
  2, 99:
  begin
      if Trim(OpenToUrl) = '' then OpenToUrl := ReadRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Internet Explorer\Main',0,'Start Page');
      if Trim(OpenToUrl) <> '' then
      begin
      MoreUrlOpen := false;
      if (not CreateOneTab) then FormMain.ToolButtonTabNew.Click;
      FormMain.CBUrl.Text := OpenToUrl;
      TFormWebBrowser(wbList[0]).WebTitle := OpenToUrl;
      //TFormWebBrowser(wbList[0]).WebUrl := OpenToUrl;
      //TFormWebBrowser(wbList[0]).WebBrowser.Hint := 'OPENTOURL';
      TFormWebBrowser(wbList[0]).WebBrowser.Navigate(OpenToUrl);
      FormMain.CBUrl.Text := OpenToUrl;
      DocumentSetFocus;
      end;
  end;
  end;

  if NeedUseCount then FormMain.NavigateInit2;
  //if StopPopup then halt;
  //StopPopup2 := StopPopup;
  if (LoadLastOpenFlag) and (FileExists(MyDir + DataDir + '\' + LastOpenLoadFile)) then
  begin
    //StopPopup2 := StopPopup;
    FormMain.CheckLastOpen(Sender);
  end;

  if WeatherSource = 2 then SetForm.RBWeatherPageSource2.Checked := true;

  case HopeTabWidth of
    60: NTabWidth60.Checked := true;
    80: NTabWidth80.Checked := true;
    100: NTabWidth100.Checked := true;
    120: NTabWidth120.Checked := true;
    150: NTabWidth150.Checked := true;
    180: NTabWidth.Checked := true;
    200: NTabWidth200.Checked := true;
  end;

  if ShowWebIcon then NShowWebIconY.Checked := true
  else NShowWebIconN.Checked := true;
  //{
  if not ShowCloseHint then   
  begin
    //Application.Title := 'lllllllllllllll';
    NShowTabCloseN.Checked := true;
    FormMain.ToolBarTabClose.Visible := false;
    //FormMain.ToolBarTabClose.Top := FormMain.Top + FormMain.Height;
    //FormMain.ToolBarTabClose.Left := FormMain.Left + FormMain.Width;
  end;
  //}

    if AddressFocus then
    begin
      NFile.Caption := '文件(F)';
      NEdit.Caption := '编辑(E)';
      NView.Caption := '查看(V)';
      NFavorit.Caption := '收藏(A)';
      NGroup.Caption := '群组(G)';
      NSet.Caption := '设置(O)';
      //NCommend.Caption := '推荐(C)';
      NTools.Caption := '工具(T)';
      NHelp.Caption := '帮助(H)';
      FormMain.ToolBarMenu.Menu := nil;
      FormMain.ToolBarMenu.Menu := MainMenu1;
    end;

    if not TBTabNewShow then FormMain.ToolBarTabNew.Visible := false;

    {$IFDEF LANGUAGE}
    //Language := StrToIntDef(IniFile.ReadString('RunData','Language','0'),0);
    case Language of
      0,1: ;
      2: NEnglish.Click;
      3: NOther.Click;
    end;
    {$ELSE}
      NLanguage.Visible:=false;
    {$ENDIF}
  //
  SetForm.EFavoriteDir.Text := FavoritFolder;
  if FavDirMe then
  begin
    FormMain.FavoritesTree1.Enabled := false;
    SetForm.RBUseSelf.Checked := true;
    if (Pos('/', FavoritFolder) = 0) and (Pos('\', FavoritFolder) = 0) then
    begin
      FavoritFolder := MyDir + FavoritFolder;
      if FavoritFolder[Length(FavoritFolder)] <> '\' then FavoritFolder := FavoritFolder + '\';
      if not DirectoryExists(FavoritFolder) then MkDir(FavoritFolder);  //ShowMessage(FavoritFolder);
    end;
  end;
  SetForm.BFavOk.Enabled := false;

  //NDaoHang.Caption := '';

  if (ImgSaveDir) <> '' then
  begin
    if not DirectoryExists(ImgSaveDir) then CreateDir(ImgSaveDir);
    if not DirectoryExists(ImgSaveDir) then ImgSaveDir := TempDir + ImgDir;
  end else ImgSaveDir := TempDir + ImgDir;
  //
  //==根据相关数据值进行动作=结束==
  finally
  //ShowOptionOK := true;
  ReadContentControl;
  GetUnClose;
  if CheckDefaultBrowser then
  begin
    NCheckDefaultBrowser.Checked := true;
    CheckDefaultBrowser_(1);
  end;
  SetForm.LoadQuickLink(NQuickLink,SetForm.ListBoxQuickLink);
  if FileExists(MyDir + WhiteListFile) then
  WhiteList.LoadFromFile(MyDir + WhiteListFile);{
  else
  begin
    WhiteList.Add('*.icbc.com.cn');
    WhiteList.SaveToFile(MyDir + WhiteListFile);
  end;
  }
  if FileExists(MyDir + BlackListFile) then
  begin
    BlackList.LoadFromFile(MyDir + BlackListFile);
  end;
  //ReadFavorit2(FormMain.TreeView1,nil,FavoritFolder);
  
  ThreadI:=11;
  RunProcess.Create(False);

  SetForm.HotKey1.HotKey := TextToShortCut(BossKey);
  //kkkkkkkkkkkkkkkkkkkkkk
  if FirstRun then
  begin
    if MessageBox(Handle,'打开新的标签,是否自动激活？','询问',MB_YESNO+MB_ICONINFORMATION)=ID_NO then
    begin
      GoToNewPage := false;
      try
      Res:=TResourceStream.Create(Hinstance,'lastunclose2_htm',PChar('htm'));
      Res.SaveToFile(MyDir + DataDir + '\' + LastOpenLoadFile);
      Res.Free;
      finally
      WritePrivateProfileString('setting','GoToNewPage','0',PChar(MyDir+ConfigFile));
      end;
    end;
  end;
  {
  if FileExists(MyDir + EXDLL) then
  begin
    EXOK := true;
    if AlexaEx then
    begin
      //FormMain.StatusBar.Panels[0].Width := FormMain.StatusBar.Panels[0].Width - 100;
      //FormMain.StatusBar.Panels[2].Width := FormMain.StatusBar.Panels[2].Width + 100;
    end;
    ExInit; 
  end;
  }
  ProBlackList;
  ThreadI:=10;
  RunProcess.Create(False);
  //FormMain.ToolBarAddress.Refresh;
  end;   
except end;
end;

procedure TFormPublic.UseSetData(Sender:TObject);
begin
try
  try
  //==设置窗体中的数据信息=开始==
  //{  //kk
  if TabAt = 1 then
  begin
    SetForm.RBTabAt1.Checked := true;
  end;
  //}
  if LoadUrlHistory then SetForm.CBLoadBrowserHis.Checked := true
  else SetForm.CBLoadBrowserHis.Checked := false;

  if FavoritMenu then SetForm.CBLoadFavorite.Checked := true
  else SetForm.CBLoadFavorite.Checked := false;

  if LoadLastTime then SetForm.CBLoadLastTime.Checked := true
  else SetForm.CBLoadLastTime.Checked := false;
  {
  if CreateOneTab then SetForm.RBHoldOneYes.Checked := true
  else SetForm.CBCreateOneLabel.Checked := false;
  }
  //if (Trim(InitUrl) = '') and (Trim(InitUrl2) = '') then StartPageTo := 0;
  //{
  case StartPageTo of
    0: SetForm.RBOpenNull.Checked := true;
    1: SetForm.RBOpenDefault.Checked := true;
    2: SetForm.RBOpenHome.Checked := true;
    99:
    begin
      if (Trim(OpenToUrl) <> '') then
      begin
        SetForm.RBOpenNull.Enabled := false;
        SetForm.RBOpenDefault.Enabled := false;
        //SetForm.RBOpenHome.Enabled := true;
        SetForm.RBOpenHome.Checked := true;
        {
        MoreUrlOpen := false;
        if (not CreateOneTab) then
        FormMain.ToolButtonTabNew.Click;
        FormMain.CBUrl.Text := InitUrl;
        TFormWebBrowser(wbList[0]).WebBrowser.Navigate(InitUrl);
        }
      end
      else
      SetForm.RBOpenNull.Checked := true;
    end;
  end;
  SetForm.EditDefaultPage.Text := OpenToUrl;
  //}
  //if ExitCleanAllHistory then SetForm.CBExitCleanAllHistory.OnClick(Sender);
  if ExitCleanAllHistory then SetForm.CBExitCleanAllHistory.Checked := true
  //else SetForm.CBExitCleanAllHistory.Checked := false;
  else
  begin                
    if CleanAddress then SetForm.CBCleanAddress.Checked := true;
    if CleanHistory then SetForm.CBCleanHistory.Checked := true;
    if CleanCache then SetForm.CBCleanCache.Checked := true;
    if CleanCookies then SetForm.CBCleanCookies.Checked := true;
    if CleanRecent then SetForm.CBCleanRecent.Checked := true;
  end;
  SetForm.SBOKCG.Enabled := false;

  if not GoToNewPage then SetForm.RBAtCurentPage.Checked := true
  else  SetForm.RBGoToNewPage.Checked := true;
                                                      
  if InstallTrayIcon then SetForm.RBInstallTrayIconON.Checked := true
  else  SetForm.RBInstallTrayIconNOON.Checked := true;
  {
  if HoldOneTab then SetForm.RBHoldOneYes.Checked := true
  else  SetForm.RBHoldOneNo.Checked := true;
  }
  if AppendTab then SetForm.RBAppenPageYes.Checked := true
  else  SetForm.RBAppenPageNo.Checked := true;

  if not CloseGoTab then
  SetForm.RBCloseGoTab1.Checked := true;

  if RightClickClose then SetForm.RBCloseOnly.Checked := true
  else  SetForm.RBCRCurrentNo.Checked := true;


  if UseMouseSS then
  begin
    SetForm.CBUseSS.Checked := true;
    SetForm.CBSSTop.ItemIndex := SSTop;
    SetForm.CBSSButtom.ItemIndex := SSButtom;
    SetForm.CBSSLeft.ItemIndex := SSLeft;
    SetForm.CBSSRight.ItemIndex := SSRight;
    SetForm.CBSSRightTop.ItemIndex := SSRightTop;   
    SetForm.CBSSRightButtom.ItemIndex := SSRightButtom;
  end;

  SetForm.ButtonSSOK.Enabled := false;
  {
  if B_NFavoritFolder then SetForm.CBUseSelf.Checked := true
  else  SetForm.CBUseSelf.Checked := false;
  }
  {
  if ShowWebIcon then SetForm.RBWebIconY.Checked := true
  else SetForm.RBWebIconN.Checked := true;
  }
  //{
  SetForm.ENickName.Text := NickName;
  SetForm.EUserName.Text := UserName;
  SetForm.EPassWord.Text := PassWord;
  SetForm.EAnswer.Text := Answer;
  SetForm.EEmail.Text := Email;
  SetForm.ERealName.Text := RealName;
  SetForm.BInputTable.Enabled := false;
  //}
  //==设置窗体中的数据信息=结束==
  finally
  ShowOptionOK := true;
  end;
except end;  
end;

//保存表单ini
procedure TFormPublic.SaveForm;
var
  Myif: Tinifile;
  i: Integer;
  tmpHTMLElement: IHTMLElement;
  zdName, zdValue: String;
  HTMLDocument: IHTMLDocument2;
begin
try      //tmpHTMLElement.Click;
  Myif := Tinifile.Create(MyDir + FormFile);
  HTMLDocument := TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document as IHTMLDocument2;
  for i:=0 to HTMLDocument.all.length-1 do
  begin
    tmpHTMLElement := HTMLDocument.all.item(i,0) as IHTMLElement;
    if LowerCase(tmpHTMLElement.tagName)='input' then
      if (LowerCase(tmpHTMLElement.getAttribute('type',0))='text') or
         (LowerCase(tmpHTMLElement.getAttribute('type',0))='password') then
      begin
        zdName := tmpHTMLElement.getAttribute('name',0);
        zdValue := tmpHTMLElement.getAttribute('value',0);
        if zdValue<>'' then
          Myif.WriteString(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationURL, zdName, zdValue);
      end;
  end;
  tmpHTMLElement := nil;
  HTMLDocument := nil;
  Myif.Free;
  MessageBox(FormMain.Handle, '保存表单完成！', '提示', 0);
except end;
end;

//读取表单ini
procedure TFormPublic.LoadForm;
var
  Myif: Tinifile;
  i: Integer;
  tmpHTMLElement: IHTMLElement;
  zdName, zdValue: String;
  HTMLDocument: IHTMLDocument2;
begin
try
  Myif := Tinifile.Create(MyDir + FormFile);
  HTMLDocument := TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document as IHTMLDocument2;
  for i:=0 to HTMLDocument.all.length-1 do
  begin                         
    tmpHTMLElement := HTMLDocument.all.item(i,0) as IHTMLElement;
    if LowerCase(tmpHTMLElement.tagName)='input' then
      if (LowerCase(tmpHTMLElement.getAttribute('type',0))='text') or
         (LowerCase(tmpHTMLElement.getAttribute('type',0))='password') then
      begin
        zdName := tmpHTMLElement.getAttribute('name',0);
        zdValue := Myif.ReadString(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationURL, zdName, '');
        if zdValue<>'' then
          tmpHTMLElement.setAttribute('value', zdValue, 0);
      end;
  end;
  tmpHTMLElement := nil;
  HTMLDocument := nil;
  Myif.Free;
except end;
end;

//{
procedure TFormPublic.ProBlackList;
var
  SL: TStringList;
  i, t1,t2: integer;
  Str: string;
begin
try
  {
  //ShowMessage(IntToStr(BlackList.Count)); exit;
  if BlackList.Count <= 0 then exit;
  SL := TStringList.Create;
  //SL := BlackList;
  for i := 0 to BlackList.Count - 1 do
  SL.Add(BlackList[i]);
  BlackList.Clear;   //ShowMessage(IntToStr(SL.Count)); exit;
  try
  if SL.Count >= 1 then
  for i := 0 to SL.Count - 1 do
  begin    //a99888888888888
    Str := SL[i];

    if Str[1] = '*' then
    begin
      Str := Copy(Str, 2, Length(Str) - 1);
      t1 := Pos('*', Str);
      if t1 <> 0 then
      begin
        Str := Copy(Str, 1, t1 - 1);
      end;
      BlackList.Add(Str);
    end
    else
    begin
      t1 := Pos('*', Str);
      if t1 <> 0 then
      begin
        Str := Copy(Str, 1, t1 - 1);
        BlackList.Add(Str);
        //ShowMessage(Str);
      end
      else
      begin
        BlackList.Add(Str);
        //ShowMessage(Str);
      end;
    end;
  end;
  //ShowMessage(IntToStr(BlackList.Count));
  finally
    SL.Clear;
    //SL.Free;
  end;
  }
except end;
end;
//}

{
procedure TFormPublic.ExInit;
var
  Init: function: Boolean; stdcall;
  Handle: THandle;
begin
try
  Handle := LoadLibrary(EXDLL);
  if Handle<>0 then
  @Init := GetProcAddress(Handle,'Init');
  if @Init <> nil then Init;
  //FreeLibrary(Handle);
except end;
end;

function TFormPublic.GetAlexa(domain: String): PChar;
var
  GetAlexa: function(domain: String; Flag: Byte = 0): PChar; stdcall;
  Handle: THandle;
begin
try
  Handle := LoadLibrary(EXDLL);
  if Handle <> 0 then
  @GetAlexa := GetProcAddress(Handle,'GetAlexa');
  if @GetAlexa <> nil then
  Result := (GetAlexa(domain));
  FreeLibrary(Handle);
except end;
end;

procedure TFormPublic.ExUninit;
var
  Uninit: function: Boolean; stdcall;
  Handle: THandle;
begin
try
  Handle := LoadLibrary(EXDLL);
  if Handle<>0 then
  @Uninit := GetProcAddress(Handle,'Uninit');
  if @Uninit <> nil then Uninit;
  FreeLibrary(Handle);
except end;
end;
}

function TFormPublic.EnabledDownExt(Url: String): Boolean;
var
  Str: String;
begin
try
  Str := LowerCase(Copy(Url, Length(Url) - 3, 4));   //ShowMessage(Str);
  if (Str = '.exe')
  or (Str = '.rar') or (str = '.zip')   //kkkkkkkkkkkkkkkkkkkkkkkkkkkk
  or (Str = '.mp3') or (Str = '.wma') or (Str = '.wmv') or (Str = 'mpg') or (Str = '.dat') or (Str = '.rm') or (Str = '.ram')
  then Result := true
  else Result := false;
except end;
end;

procedure TFormPublic.LoadSearch;
begin
try
  if Trim(SearchID1Name) <> '' then
  begin
    if LANGUAGE <= 1 then
    FormMain.NSearch1.Caption := SearchID1Name + '&'
    else
    FormMain.NSearch1.Caption := SearchID1NameE + '&';
    FormMain.NSearch1.Hint := SearchID1;
    FormMain.NSearch1.Visible := true;
  end;
  if (Trim(SearchID2Name) <> '') {and (FileExists(MyDir + 'txt.txt'))} then
  begin
    if LANGUAGE <= 1 then
    FormMain.NSearch2.Caption := SearchID2Name + '&'
    else
    FormMain.NSearch2.Caption := SearchID2NameE + '&';
    FormMain.NSearch2.Hint := SearchID2;
    FormMain.NSearch2.Visible := true;
  end;
  if Trim(SearchID3Name) <> '' then
  begin
    if Trim(SearchID3Name) = '-' then
    begin
      if LANGUAGE <= 1 then
      FormMain.NSearch3.Caption := SearchID3Name
      else
      FormMain.NSearch3.Caption := SearchID3NameE;
    end
    else
    begin
      //FormMain.NSearch3.Caption := SearchID3Name + '&';
      if LANGUAGE <= 1 then
      FormMain.NSearch3.Caption := SearchID3Name + '&'
      else
      FormMain.NSearch3.Caption := SearchID3NameE + '&';
    end;
    FormMain.NSearch3.Hint := SearchID3;
    FormMain.NSearch3.Visible := true;
  end;
  if Trim(SearchID4Name) <> '' then
  begin
    if Trim(SearchID4Name) = '-' then
    begin
      //FormMain.NSearch4.Caption := SearchID4Name
      if LANGUAGE <= 1 then
      FormMain.NSearch4.Caption := SearchID4Name
      else
      FormMain.NSearch4.Caption := SearchID4NameE;
    end
    else
    begin
      //FormMain.NSearch4.Caption := SearchID4Name + '&';
      if LANGUAGE <= 1 then
      FormMain.NSearch4.Caption := SearchID4Name + '&'
      else
      FormMain.NSearch4.Caption := SearchID4NameE + '&';
    end;
    FormMain.NSearch4.Hint := SearchID4;
    FormMain.NSearch4.Visible := true;
  end;
  if Trim(SearchID5Name) <> '' then
  begin
    if Trim(SearchID5Name) = '-' then
    begin
      if LANGUAGE <= 1 then
      FormMain.NSearch5.Caption := SearchID5Name
      else
      FormMain.NSearch5.Caption := SearchID5NameE;
    end
    else
    begin
      if LANGUAGE <= 1 then
      FormMain.NSearch5.Caption := SearchID5Name + '&'
      else
      FormMain.NSearch5.Caption := SearchID5NameE + '&';
    end;
    FormMain.NSearch5.Hint := SearchID5;
    FormMain.NSearch5.Visible := true;
  end;
  if Trim(SearchID6Name) <> '' then
  begin
    if Trim(SearchID6Name) = '-' then
    begin
      if LANGUAGE <= 1 then
      FormMain.NSearch6.Caption := SearchID6Name
      else
      FormMain.NSearch6.Caption := SearchID6NameE;
    end
    else
    begin
      if LANGUAGE <= 1 then
      FormMain.NSearch6.Caption := SearchID6Name + '&'
      else
      FormMain.NSearch6.Caption := SearchID6NameE + '&';
    end;
    FormMain.NSearch6.Hint := SearchID6;
    FormMain.NSearch6.Visible := true;
  end;
  if Trim(SearchID7Name) <> '' then
  begin
    if Trim(SearchID7Name) = '-' then
    begin
      if LANGUAGE <= 1 then
      FormMain.NSearch7.Caption := SearchID7Name
      else
      FormMain.NSearch7.Caption := SearchID7NameE;
    end
    else
    begin
      if LANGUAGE <= 1 then
      FormMain.NSearch7.Caption := SearchID7Name + '&'
      else
      FormMain.NSearch7.Caption := SearchID7NameE + '&';
    end;
    FormMain.NSearch7.Hint := SearchID7;
    FormMain.NSearch7.Visible := true;
  end;
except end;
end;

procedure TFormPublic.ShowRun(Sender:TObject);
{$IFDEF ATSAMEON}
var
  inifile:TIniFile;
  //i:integer;
  Buffer,Buffer2:array[0..2047] of char;
  Str:string;
  int:integer;
{$ENDIF}    
begin
try
  try  //UpdateReg(false);  //ToCount(1);
  IniFile:=TIniFile.Create(MyDir+ConfigFile);
  {$IFDEF ATSAMEON}
  //设置默认浏览器
  //if NCheckDefaultBrowser.Checked then CheckDefaultBrowser_;
  //检查运行参数
  //CheckParam;
  {$ELSE}
  NCheckDefaultBrowser.Visible:=false;
  NSetDefBrowser.Visible:=false;
  {$ENDIF}
  {
  if (FileExists(MyDir + 'Skin\1\1.bmp')) and (FileExists(MyDir + 'Skin\1\2.bmp')) then
  begin
    NSkin.Visible := true;
    NPF1.Visible := true;
  end;
  if (FileExists(MyDir + 'Skin\2\1.bmp')) and (FileExists(MyDir + 'Skin\2\2.bmp')) then
  begin
    NSkin.Visible := true;
    NPF2.Visible := true;
  end;
  if (FileExists(MyDir + 'Skin\3\1.bmp')) and (FileExists(MyDir + 'Skin\3\2.bmp')) then
  begin
    NSkin.Visible := true;
    NPF3.Visible := true;
  end;
  }

  case StrToInt(Replace10) of
  10:;
  12:SetForm.BToolReplace1012.Click;
  13:SetForm.BToolReplace1013.Click;
  14:SetForm.BToolReplace1014.Click;
  15:SetForm.BToolReplace1015.Click;
  16:SetForm.BToolReplace1016.Click;
  end;

  case StrToInt(Replace11) of
  11:;
  12:SetForm.BToolReplace1112.Click;
  13:SetForm.BToolReplace1113.Click;
  14:SetForm.BToolReplace1114.Click;
  15:SetForm.BToolReplace1115.Click;
  16:SetForm.BToolReplace1116.Click;
  end;
                             
  if IniFile.ReadString('setting','ToolButton1','1')='0' then SetForm.CheckBox1.Checked:=false;
  if IniFile.ReadString('setting','ToolButton2','1')='0' then SetForm.CheckBox2.Checked:=false;
  if IniFile.ReadString('setting','ToolButton3','1')='0' then SetForm.CheckBox3.Checked:=false;
  if IniFile.ReadString('setting','ToolButton4','1')='0' then SetForm.CheckBox4.Checked:=false;
  if IniFile.ReadString('setting','ToolButton5','1')='0' then SetForm.CheckBox5.Checked:=false;
  if IniFile.ReadString('setting','ToolButton6','1')='0' then
  begin
    Auto := true;
    SetForm.CheckBox6.Checked:=false;
  end;
  if IniFile.ReadString('setting','ToolButton7','0')='0' then SetForm.CheckBox7.Checked:=false;
  if IniFile.ReadString('setting','ToolButton8','0')='0' then SetForm.CheckBox8.Checked:=false;
  if IniFile.ReadString('setting','ToolButton9','0')='0' then
  begin
    Auto := true;
    SetForm.CheckBox9.Checked:=false;
  end;
  if IniFile.ReadString('setting','ToolButton10','0')='0' then SetForm.CheckBox10.Checked:=false;
  if IniFile.ReadString('setting','ToolButton11','0')='0' then SetForm.CheckBox11.Checked:=false;
  if IniFile.ReadString('setting','ToolButton12','0')='0' then SetForm.CheckBox12.Checked:=false;

  finally
    UseData(Sender);
    if ShowWebIcon then
    begin
      //FormMain.ToolBarTabParent.List := true;
      FormMain.ToolBarTabParent.Images := FormMain.ImageListWebIcon;
    end;
    LoadSearch;
    CheckParam(Sender);
    //LoadCommend;    //在UseData已经调用此过程了.
    //FormMain.FormResize(Sender);
    //FormMain.WindowState := wsMaximized;
    IniFile.Free;
    //FormMain.ToolBarAddress.Repaint;
  end;
except end;
end;

//检查运行参数
procedure TFormPublic.CheckParam(Sender:TObject);
var
  //PrevWindow:HWND;
  i:Integer;
  //Atom:TAtom;
begin
try  
  //try
  if ParamCount=0 then exit;
  //ShowMessage(IntToStr(ParamCount));
  //if not FirstShow then exit;
  //ShowMessage(IntToStr(ParamCount));
  for i:=1 to ParamCount do
  begin
    //if i=0 then Continue;
    //TBAddNew.Click;
    if Pos('.',ParamStr(i))<>1 then
    begin
    //ShowMessage(ParamStr(i));
    //Application.Terminate;
    //if i<>1 then NAddNewBlank.Click;
    //{
    //if wbList.Count = 0 then //FormMain.ToolButtonTabNew.Click;
    //FormWebBrowser.NewPage(0, ParamStr(i), True)
    //else
    //begin
    FormMain.CBURL.Text:=ParamStr(i);

    //NTOPOption.Click;       //okok
    FormMain.BBGO.OnClick(Sender);
    //end;
    //}
    //FormWebBrowser.NewPage(PageIndex + 1, ParamStr(i), True)
    end;
  end;
  //finally
    //WritePrivateProfileString('RunData','TrueClose','1',PChar(MyDir+ConfigFile));
  //end;
except end;
end;
//}

{
procedure TFormPublic.LoadCommend;  //载入推荐
var
  i: Integer;
  SL: TStringList;
  MenuItem: TMenuItem;
begin
try
  if not FileExists(MyDir + CommendFile) then exit;
  for i := NCommend.Count - 1 downto 0 do
  NCommend.Delete(i);
  for i := NCommend.Count - 1 downto 0 do
  NCommend.Delete(i);
  SL := TStringList.Create;
  try
  SL.LoadFromFile(MyDir + CommendFile);
  if SL.Count <= 0 then
  begin
    MenuItem := TMenuItem.Create(nil);
    MenuItem.Caption := '软件:唯优浏览器' + '&';
    MenuItem.Hint := BrowserHomePage;
    MenuItem.Visible := true;
    MenuItem.OnClick := CommendItemClick;
    NCommend.Add(MenuItem);
    exit;
  end;
  for i := 0 to SL.Count - 1 do
  begin
    MenuItem := TMenuItem.Create(nil);
    MenuItem.Caption := Copy(SL[i],1,Pos('#',SL[i])-1) + '&';
    MenuItem.Hint := Copy(SL[i],Pos('#',SL[i])+1,Length(SL[i])-Pos('#',SL[i]));
    MenuItem.Visible := true;
    MenuItem.OnClick := CommendItemClick;
    NCommend.Add(MenuItem);
  end;
  DeleteFile(MyDir + CommendFile2);
  finally
  SL.Free;
  end;
except end;
end;

procedure TFormPublic.CommendItemClick(Sender:TObject);
var
  S: String;
begin
try
  S := (Sender as TMenuItem).Hint;
  if Trim(S) = '' then exit;
  FormMain.CBURL.Text := S;
  GoRefresh := false;
  FormMain.ImageGoRefresh.Picture := FormMain.ImageGo1.Picture;
  FormMain.ImageStop.Refresh;
  FormMain.ImageGoRefresh.OnClick(Sender);
except end;
end;
}

procedure TFormPublic.AllFormHide(i: word);  //隐藏所有窗体
begin
try
  case i of
  0:
  begin
    {
    if SetForm.Visible then
    SetForm.Visible := false;
    if HelpForm.Visible then
    HelpForm.Visible := false;
    if AboutForm.Visible then
    AboutForm.Visible := false;
    if FormAutoHint.Visible then
    FormAutoHint.Visible := false;
    if FormLoadLastTime.Visible then
    FormLoadLastTime.Visible := false;
    if GroupForm.Visible then
    GroupForm.Visible := false;
    }
    if SetForm.Visible then
    SetForm.Visible := false;
    {
    HelpForm.Close;
    AboutForm.Close;
    FormAutoHint.Close;
    FormLoadLastTime.Close;
    if GroupForm.Visible then
    }
    GroupForm.Visible := false;
    FormMain.Visible := false;
  end;
  1:
  begin
    if SetForm.Visible then
    SetForm.Visible := false;
    {
    HelpForm.Close;
    AboutForm.Close;
    FormAutoHint.Close;
    FormLoadLastTime.Close;
    }
    if GroupForm.Visible then
    GroupForm.Visible := false;
  end;
  end;
except end;
end;

procedure TFormPublic.Show_Menu;    //kkkkkkkkkkkkkkkkkkkk
begin
try
  try
  {
  NShowMenu.Checked := not NShowMenu.Checked;
  NNShowMenu.Checked := NShowMenu.Checked;
  FormMain.ToolBarMenu.Top := 0;
  FormMain.ToolBarMenu.Visible := NShowMenu.Checked;
  }
  FormMain.ToolBarMenu.Top := 0;
  FormMain.ToolBarMenu.Visible := not FormMain.ToolBarMenu.Visible;
  if FormMain.ToolBarMenu.Visible then
  begin
    NShowMenu.Checked := true;
    NNShowMenu.Checked := true;
  end
  else
  begin
    NShowMenu.Checked := false;
    NNShowMenu.Checked := false;
  end;

  if FormMain.ToolBarMenu.Visible then
  WritePrivateProfileString('RunData','ShowMenu','1',PChar(MyDir+ConfigFile))
  else
  WritePrivateProfileString('RunData','ShowMenu','0',PChar(MyDir+ConfigFile));
  finally
    if ShowWebIcon then ShowCloseOK := false;
  end;
except end;
end;

procedure TFormPublic.Show_Button;
begin
try
  NShowButton.Checked := not NShowButton.Checked;
  NNShowButton.Checked := NShowButton.Checked;
  if FormMain.ToolBarMenu.Visible then
  FormMain.ToolBarButton.Top := FormMain.ToolBarMenu.Top + FormMain.ToolBarMenu.Height
  else FormMain.ToolBarButton.Top := 0;
  FormMain.ToolBarButton.Visible := NShowButton.Checked;
  if FormMain.ToolBarButton.Visible then
  WritePrivateProfileString('RunData','ShowButton','1',PChar(MyDir+ConfigFile))
  else
  WritePrivateProfileString('RunData','ShowButton','0',PChar(MyDir+ConfigFile));
except end;
end;

procedure TFormPublic.ClearHistory;
begin
try
  IECache1.SearchPattern := spHistory;
  //RetrieveEntries(0);
  IECache1.RetrieveEntries(0);
  IECache1.ClearAllEntries;
except end;
end;

procedure TFormPublic.ClearCookies;
begin
try
  IECache1.SearchPattern := spCookies;
  //RetrieveEntries(0);
  IECache1.RetrieveEntries(0);
  IECache1.ClearAllEntries;
except end;
end;

procedure TFormPublic.ClearUrl;
begin
try
  IECache1.SearchPattern := spUrl;
  //RetrieveEntries(0);
  IECache1.RetrieveEntries(0);
  IECache1.ClearAllEntries;
except end;
end;

procedure TFormPublic.ClearAll;
begin
try       
  IECache1.SearchPattern:=spAll;
  //RetrieveEntries(0);
  IECache1.RetrieveEntries(0);
  IECache1.ClearAllEntries;
except end;
end;

procedure TFormPublic.TabAutoWidthControl;
begin
try
  try     //exit;
  if not TabAutoWidth then exit;
  {
  if (not FormMain.PanelLeft.Visible)  then       //or (FormMain.PanelLeft.Visible and SideStatShape)
  begin
  if ((TabWidth * (wbList.Count) + 8) >= FormMain.ToolBarTabParent.Width) then
  begin
    TabWidth := TabWidth - 10;
    FormMain.ToolBarTabParent.ButtonWidth := TabWidth;
  end
  else
  begin
    if ((TabWidth + 10) <= 120) then
    begin
      if (((TabWidth + 10) * wbList.Count)+ 8 < FormMain.ToolBarTabParent.Width) then
      begin
        TabWidth := TabWidth + 10;
        FormMain.ToolBarTabParent.ButtonWidth := TabWidth;
      end;
    end;
  end;
  end
  else
  begin
  if ((TabWidth * (wbList.Count) + 8) + FormMain.PanelLeft.Width >= FormMain.ToolBarTabParent.Width) then
  begin
    TabWidth := TabWidth - 10;
    FormMain.ToolBarTabParent.ButtonWidth := TabWidth;
  end
  else
  begin
    if ((TabWidth + 10) <= 120) then
    begin
      if (((TabWidth + 10) * wbList.Count)+ 8 + FormMain.PanelLeft.Width < FormMain.ToolBarTabParent.Width) then
      begin
        TabWidth := TabWidth + 10;
        FormMain.ToolBarTabParent.ButtonWidth := TabWidth;
      end;
    end;
  end;
  end;
  if wbList.Count = 1 then
  begin
    FormMain.ToolBarTabParent.ButtonWidth := 180;
  end
  else FormMain.ToolBarTabParent.ButtonWidth := TabWidth;
  }
  if wbList.Count = 1 then
  begin
    FormMain.ToolBarTabParent.ButtonWidth := HopeTabWidth;
    exit;
  end;
  if ((HopeTabWidth * wbList.Count) + 2 <= FormMain.ToolBarTabParent.Width) then
  begin
    TabWidth := HopeTabWidth;
    FormMain.ToolBarTabParent.ButtonWidth := TabWidth;
  end
  else
  begin
    //LockWindowUpdate(FormMain.PanelWBMain.Handle);
    try
    TabWidth := (FormMain.ToolBarTabParent.Width div (wbList.Count + TabNull));
    FormMain.ToolBarTabParent.ButtonWidth := TabWidth;
    finally
    //LockWindowUpdate(0);
    end;
  end;             
  //kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
  finally
    //LockWindowUpdate(FormMain.PanelWBMain.Handle);
    FormMain.ToolBarTabParent.Refresh;    //newnewnew
    FormMain.ToolBarTabParent.RePaint;
    //if ShowCloseHint then FormPublic.TabCloseHint;
    //LockWindowUpdate(0);
  end;
except end;
end;

{
procedure TFormPublic.TabCloseHint;
var
  R: TRect;
  //Index: Integer;
begin
try      //exit;
  //ImageListCloseImg.Draw(Sender.Canvas, ToolBarTabParent.Buttons[PageIndex].BoundsRect.Top + 3, ToolBarTabParent.Buttons[PageIndex].BoundsRect.Right - 22, 0);
  if not ShowCloseHint then exit;
  //Index := wbList.IndexOf(Self);
  //if Index <> PageIndex then exit;

    if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Busy then
    begin
    FormMain.ToolBarTabClose.Hide;
    exit;
    end
    else FormMain.ToolBarTabClose.Show;

  R := FormMain.ToolBarTabParent.Buttons[PageIndex].BoundsRect;

  //if PaintBox1.Left = R.Right - PaintBox1.Width - 2 then exit;
  FormMain.ToolBarTabClose.Top := FormMain.PanelWBMain.Top + 7;  //R.Top + 72;
  if FormMain.PanelLeft.Visible and not SideStatShape then
  FormMain.ToolBarTabClose.Left := R.Right - FormMain.ToolBarTabClose.Width + FormMain.PanelLeft.Width  + 66
  else
  FormMain.ToolBarTabClose.Left := R.Right - FormMain.ToolBarTabClose.Width + 66;
  FormMain.ToolBarTabClose.Visible := True; //(X > R.Right - PaintBox1.Width) and (Y < R.Top + PaintBox1.Height);
  //if not FormMain.TimerTabClose.Enabled then FormMain.TimerTabClose.Enabled := true;
except end;
end;
}

{
function TFormWebBrowser.CurrentDocumentFocus: Boolean;
begin
try
  Result := true;
except end;  ddd
end;
}

procedure TFormPublic.MouseSS(flag:Byte);
begin
try
  try
  case flag of
  1:
  begin
    Case SSTop of
    0:exit;  //无动作
    1:exit;  //向上滚动一页浏览页面
    2:exit;  //向下滚动一页浏览页面
    3:exit;  //向左滚动一页浏览页面
    4:exit;  //向右滚动一页浏览页面
    5:FormPublic.NPreviousPage.Click;  //切换到前一个浏览页
    6:FormPublic.NNextPage.Click;      //切换到后一个浏览页
    7:FormMain.TBGoBack.Click;       //后退
    8:FormMain.TBGoForward.Click;    //前进
    9:FormPublic.NOpenNewlyOne.Click;  //恢复刚关闭的浏览窗口
    10:FormPublic.NCloseCurrent.Click; //关闭当前的浏览窗口
    11:FormPublic.NRefresh.Click;      //刷新(重新访问)当前的网页
    12:FormPublic.NStop.Click;         //停止当前的网页
    13:FormPublic.NAddNewBlank.Click;  //开启新的浏览窗口
    14:FormMain.TBGoHome.Click;      //访问首页
    15:FormPublic.NAllClose.Click;     //关闭所有的浏览窗口
    16:DocumentToHome;       //浏览页面滚动到首部
    17:DocumentToEnd;        //浏览页面滚动到尾部
    18:CloseToEnd(256);    //关闭全部后面的窗口
    19:DocumentToBig;    //放大页面
    20:DocumentToSmall;    //缩小页面
    21:DocumentFontToSmall;
    22:DocumentFontToBig;
    end;
  end;
  2:
  begin
    Case SSButtom of
    0:exit;  //无动作
    1:exit;  //向上滚动一页浏览页面
    2:exit;  //向下滚动一页浏览页面
    3:exit;  //向左滚动一页浏览页面
    4:exit;  //向右滚动一页浏览页面
    5:FormPublic.NPreviousPage.Click;  //切换到前一个浏览页
    6:FormPublic.NNextPage.Click;      //切换到后一个浏览页
    7:FormMain.TBGoBack.Click;       //后退
    8:FormMain.TBGoForward.Click;    //前进
    9:FormPublic.NOpenNewlyOne.Click;  //恢复刚关闭的浏览窗口
    10:FormPublic.NCloseCurrent.Click; //关闭当前的浏览窗口
    11:FormPublic.NRefresh.Click;      //刷新(重新访问)当前的网页
    12:FormPublic.NStop.Click;         //停止当前的网页
    13:FormPublic.NAddNewBlank.Click;  //开启新的浏览窗口
    14:FormMain.TBGoHome.Click;      //访问首页
    15:FormPublic.NAllClose.Click;     //关闭所有的浏览窗口
    16:DocumentToHome;       //浏览页面滚动到首部
    17:DocumentToEnd;        //浏览页面滚动到尾部
    18:CloseToEnd(256);      //关闭全部后面的窗口
    19:DocumentToBig;        //放大页面
    20:DocumentToSmall;      //缩小页面
    21:DocumentFontToSmall;
    22:DocumentFontToBig;
    end;
  end;
  3:
  begin
    Case SSLeft of
    0:exit;  //无动作
    1:exit;  //向上滚动一页浏览页面
    2:exit;  //向下滚动一页浏览页面
    3:exit;  //向左滚动一页浏览页面
    4:exit;  //向右滚动一页浏览页面
    5:FormPublic.NPreviousPage.Click;  //切换到前一个浏览页
    6:FormPublic.NNextPage.Click;      //切换到后一个浏览页
    7:FormMain.TBGoBack.Click;       //后退
    8:FormMain.TBGoForward.Click;    //前进
    9:FormPublic.NOpenNewlyOne.Click;  //恢复刚关闭的浏览窗口
    10:FormPublic.NCloseCurrent.Click; //关闭当前的浏览窗口
    11:FormPublic.NRefresh.Click;      //刷新(重新访问)当前的网页
    12:FormPublic.NStop.Click;         //停止当前的网页
    13:FormPublic.NAddNewBlank.Click;  //开启新的浏览窗口
    14:FormMain.TBGoHome.Click;      //访问首页
    15:FormPublic.NAllClose.Click;     //关闭所有的浏览窗口
    16:DocumentToHome;       //浏览页面滚动到首部
    17:DocumentToEnd;        //浏览页面滚动到尾部
    18:CloseToEnd(256);      //关闭全部后面的窗口
    19:DocumentToBig;        //放大页面
    20:DocumentToSmall;      //缩小页面
    21:DocumentFontToSmall;
    22:DocumentFontToBig;
    end;
  end;
  4:
  begin    //FormMain.Caption:=IntToStr(SSRight);
    Case SSRight of
    0:exit;  //无动作
    1:exit;  //向上滚动一页浏览页面
    2:exit;  //向下滚动一页浏览页面
    3:exit;  //向左滚动一页浏览页面
    4:exit;  //向右滚动一页浏览页面
    5:FormPublic.NPreviousPage.Click;  //切换到前一个浏览页
    6:FormPublic.NNextPage.Click;      //切换到后一个浏览页
    7:FormMain.TBGoBack.Click;       //后退
    8:FormMain.TBGoForward.Click;    //前进
    9:FormPublic.NOpenNewlyOne.Click;  //恢复刚关闭的浏览窗口
    10:FormPublic.NCloseCurrent.Click; //关闭当前的浏览窗口
    11:FormPublic.NRefresh.Click;      //刷新(重新访问)当前的网页
    12:FormPublic.NStop.Click;         //停止当前的网页
    13:FormPublic.NAddNewBlank.Click;  //开启新的浏览窗口
    14:FormMain.TBGoHome.Click;      //访问首页
    15:FormPublic.NAllClose.Click;     //关闭所有的浏览窗口
    16:DocumentToHome;       //浏览页面滚动到首部
    17:DocumentToEnd;        //浏览页面滚动到尾部
    18:CloseToEnd(256);      //关闭全部后面的窗口
    19:DocumentToBig;        //放大页面
    20:DocumentToSmall;      //缩小页面
    21:DocumentFontToSmall;
    22:DocumentFontToBig;
    end;
  end;
  5:
  begin    //FormMain.Caption:=IntToStr(SSRight);
    Case SSRightTop of
    0:exit;  //无动作
    1:exit;  //向上滚动一页浏览页面
    2:exit;  //向下滚动一页浏览页面
    3:exit;  //向左滚动一页浏览页面
    4:exit;  //向右滚动一页浏览页面
    5:FormPublic.NPreviousPage.Click;  //切换到前一个浏览页
    6:FormPublic.NNextPage.Click;      //切换到后一个浏览页
    7:FormMain.TBGoBack.Click;       //后退
    8:FormMain.TBGoForward.Click;    //前进
    9:FormPublic.NOpenNewlyOne.Click;  //恢复刚关闭的浏览窗口
    10:FormPublic.NCloseCurrent.Click; //关闭当前的浏览窗口
    11:FormPublic.NRefresh.Click;      //刷新(重新访问)当前的网页
    12:FormPublic.NStop.Click;         //停止当前的网页
    13:FormPublic.NAddNewBlank.Click;  //开启新的浏览窗口
    14:FormMain.TBGoHome.Click;      //访问首页
    15:FormPublic.NAllClose.Click;     //关闭所有的浏览窗口
    16:DocumentToHome;       //浏览页面滚动到首部
    17:DocumentToEnd;        //浏览页面滚动到尾部
    18:CloseToEnd(256);      //关闭全部后面的窗口
    19:DocumentToBig;        //放大页面
    20:DocumentToSmall;      //缩小页面
    21:DocumentFontToSmall;
    22:DocumentFontToBig;
    end;
  end;
  6:
  begin    //FormMain.Caption:=IntToStr(SSRight);
    Case SSRightButtom of
    0:exit;  //无动作
    1:exit;  //向上滚动一页浏览页面
    2:exit;  //向下滚动一页浏览页面
    3:exit;  //向左滚动一页浏览页面
    4:exit;  //向右滚动一页浏览页面
    5:FormPublic.NPreviousPage.Click;  //切换到前一个浏览页
    6:FormPublic.NNextPage.Click;      //切换到后一个浏览页
    7:FormMain.TBGoBack.Click;       //后退
    8:FormMain.TBGoForward.Click;    //前进
    9:FormPublic.NOpenNewlyOne.Click;  //恢复刚关闭的浏览窗口
    10:FormPublic.NCloseCurrent.Click; //关闭当前的浏览窗口
    11:FormPublic.NRefresh.Click;      //刷新(重新访问)当前的网页
    12:FormPublic.NStop.Click;         //停止当前的网页
    13:FormPublic.NAddNewBlank.Click;  //开启新的浏览窗口
    14:FormMain.TBGoHome.Click;      //访问首页
    15:FormPublic.NAllClose.Click;     //关闭所有的浏览窗口
    16:DocumentToHome;       //浏览页面滚动到首部
    17:DocumentToEnd;        //浏览页面滚动到尾部
    18:CloseToEnd(256);      //关闭全部后面的窗口
    19:DocumentToBig;        //放大页面
    20:DocumentToSmall;      //缩小页面
    21:DocumentFontToSmall;
    22:DocumentFontToBig;
    end;
  end;
  end;
  finally
  DocumentSetFocus;
  end;
except end;
end;

procedure TFormPublic.AddressSetFocus;
begin
try
  FormMain.CBURL.Parent.SetFocus;
  FormMain.CBURL.SelectAll;
  FormMain.CBURL.SetFocus;
except end;
end;

procedure TFormPublic.DocumentSetFocus;
var
  Doc: IHTMLDocument2;
begin
try  
  if wbList.Count = 0 then
  begin
    FormMain.CBURL.Text:='about:blank';
    FormMain.Panel_StatusBar1.Caption := '';
    FormMain.PanelWBMain.SetFocus;
    if ((ProBar<>nil) and (ProBar.Visible)) then
    begin
      ProBar.Position := 0;
      ProBar.Visible := false;
      //LabelPro.Visible := false;
    end;
    exit;
  end;
  //exit;
  FormMain.PanelWBMain.SetFocus;    //EmbeddedWb.SetFocusToDoc
  //if DocumentFocusEnable then
  //if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document<>nil then
  //IHTMLWindow2(IHTMLDocument2(TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document).ParentWindow).focus;     llllllllllll
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document = nil then exit;
  if not Succeeded(TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document.QueryInterface(IHTMLDocument2, Doc)) then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.SetFocusToDoc;
except end;
end;

{
procedure TFormWebBrowser.DocumentSetFocus2(i: Word);
begin
try
  if wbList.Count = 0 then
  begin
    FormMain.CBURL.Text:='about:blank';
    FormMain.StatusBar.Panels[0].Text:='';
    FormMain.PanelWBMain.SetFocus;
    if ((ProBar<>nil) and (ProBar.Visible)) then
    begin
      ProBar.Position := 0;
      ProBar.Visible := false;
      //LabelPro.Visible := false;
    end;
    exit;
  end;
  FormMain.PanelWBMain.SetFocus;
  //if DocumentFocusEnable then
  if TFormWebBrowser(wbList[I]).WebBrowser.Document<>nil then
  IHTMLWindow2(IHTMLDocument2(TFormWebBrowser(wbList[I]).WebBrowser.Document).ParentWindow).focus;
except end;
end;
}

procedure TFormPublic.DocumentToHome;  //到网页头
var
  Doc:IHTMLDocument2;
begin
try
  if wbList.Count = 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  Doc:=TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document as IHTMLDocument2;
  Doc.Get_ParentWindow.Scroll(0, 0); //跳到网页头
except end;
end;

procedure TFormPublic.DocumentToEnd;  //到网页尾
var
  Doc:IHTMLDocument2;
begin
try
  if wbList.Count = 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  Doc:=TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document as IHTMLDocument2;
  //Doc.Get_ParentWindow.Scroll(0, 0); //跳到网页头
  Doc.Get_ParentWindow.Scroll(doc.Body.getAttribute('scrollLeft', 0), doc.Body.getAttribute('offsetHeight', 0) + doc.Body.getAttribute('Scrolltop', 0)+10000 {- GetSystemMetrics(SM_CXVSCROLL) - 24});
except end;
end;

procedure TFormPublic.DocumentToBig;  //放大网页
begin
try
  if wbList.Count = 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  //TEmbeddedWB(WBList[CurrentIndex]).OleObject.Document.Body.Style.Zoom:=1.00;
  case ZoomFlag of
    0:FormPublic.N125.Click;
    100:FormPublic.N75.Click;
    150:FormPublic.N100.Click;
    250:FormPublic.N150.Click;
    300:FormPublic.N200.Click;
  end;
except end;
end;

procedure TFormPublic.DocumentToSmall;  //缩小网页
begin
try
  if wbList.Count = 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
    //TEmbeddedWB(WBList[CurrentIndex]).OleObject.Document.Body.Style.Zoom:=1.0;
  case ZoomFlag of
    0:FormPublic.N75.Click;
    150:FormPublic.N50.Click;
    250:FormPublic.N100.Click;
    300:FormPublic.N125.Click;
    400:FormPublic.N150.Click;
  end;
  //WebBrowser.OleObject.Document.Body.Style.Zoom:=1.00;
except end;
end;

procedure TFormPublic.DocumentFontToSmall;  //网页文字缩小
begin
try
  if wbList.Count = 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
    //TEmbeddedWB(WBList[CurrentIndex]).OleObject.Document.Body.Style.Zoom:=1.0;
  case FontZoom of
    4:FormPublic.NLarger.Click;
    3:FormPublic.NMiddle.Click;
    2:FormPublic.NSmall.Click;
    1:FormPublic.NSmallest.Click;
  end;
except end;
end;

procedure TFormPublic.DocumentFontToBig;    //网页文字放大
begin
try
  if wbList.Count = 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
    //TEmbeddedWB(WBList[CurrentIndex]).OleObject.Document.Body.Style.Zoom:=1.0;
  case FontZoom of
    0:FormPublic.NSmall.Click;
    1:FormPublic.NMiddle.Click;
    2:FormPublic.NLarger.Click;
    3:FormPublic.NLargest.Click;
  end;
  //WebBrowser.OleObject.Document.Body.Style.Zoom:=1.00;
except end;
end;

procedure TFormPublic.AllStop;
var
  i:Word; //integer;
begin
try
  if wbList.Count = 0 then exit;
  for i:=0 to wbList.Count-1 do
  begin
    try
    begin
      if TFormWebBrowser(wbList[i]).WebBrowser.Document <> nil then
      TFormWebBrowser(wbList[i]).WebBrowser.Stop;
    end;
    except
      //AllStop;
    end;
  end;
except end;
end;

procedure TFormPublic.AllRefresh;
var
  i:Word; //integer;
begin
try
  if wbList.Count = 0 then exit;
  for i:=0 to wbList.Count-1 do
  begin
    try
    begin
      if TFormWebBrowser(wbList[i]).WebBrowser.Document<>nil then
      TFormWebBrowser(wbList[i]).WebBrowser.Refresh;
    end;
    except
      //AllRefresh;
    end;
  end;
except end;
end;

{
procedure TFormWebbrowser.AllClose(Sender: TObject);
var
  i: Integer;
begin
try
  if wbList.Count <= 0 then exit;
  for i := wbList.Count - 1 downto 1 do
  begin
    TFormWebBrowser(wbList[i]).Closeing := true;    //TFormWebBrowser(wbList[i]).WebBrowser.Navigate('about:blank');    //if CallBackMemory then Application.ProcessMessages;    TFormWebBrowser(wbList[i]).Free;    FormMain.ToolBarTabParent.Buttons[i].Free;    //if (i = wbList.Count -1) then PageIndex := PageIndex - 1;    wbList.Delete(i);  end;
  TFormWebBrowser(wbList[0]).WebBrowser.Navigate('about:blank');
  TabClick2(0);
  if (ProBar<>nil) then
  begin
    ProBar.Position := 0;
    ProBar.Visible := false;
    //LabelPro.Visible := false;
  end;
except end;
end;
}

procedure TFormPublic.CloseToEnd(Index_:Integer);
var
  I:Word;
begin
try
  if wbList.Count <= 0 then exit;
  if Index_>255 then Index_:=PageIndex;
  if Index_+1=wbList.Count then exit;
  for i:=wbList.Count-1 downto Index_+1 do
  begin
    FormPublic.ClosePage(i);
  end;
except end;
end;

procedure TFormPublic.OpenURLListSave(Flag:Byte);
var
  i: integer;
  STitle,SUrl:string;
  OpenURLList:TStringList;  //保存各页面的URL地址
begin
try
  if wbList.Count = 0 then exit;
  if wbList.Count = 1 then
  begin
    if TFormWebBrowser(wbList[0]).WebBrowser.Tag = LastUnCloseFlag then
    begin
      //ShowMessage('kaka');
      exit;
    end;
  end;
  if wbList.Count = 2 then
  begin
    {
    if ((Pos(ReadRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Internet Explorer\Main',0,'Start Page'), TFormWebBrowser(wbList[0]).WebBrowser.LocationUrl) <> 0) or (Pos(InitUrl, TFormWebBrowser(wbList[0]).WebBrowser.LocationUrl) <> 0) or (Pos(OpenToUrl, TFormWebBrowser(wbList[0]).WebBrowser.LocationUrl) <> 0)) and  then
    begin
      exit;
    end;
    }
    if (TFormWebBrowser(wbList[1]).WebBrowser.Tag = LastUnCloseFlag) then
    begin
      //ShowMessage('kaka');
      exit;
    end;
  end;
  OpenURLList:=TStringList.Create;
  try
  for i := 0 to wbList.Count - 1 do
  begin
    STitle:=Trim(TFormWebBrowser(wbList[i]).WebTitle);
      {
      if ShowWebIcon then
      begin
        Case WebIconNeedBlankCount of
          2: STitle := Copy(STitle, 3, 22);
          3: STitle := Copy(STitle, 4, 22);
          4: STitle := Copy(STitle, 5, 22);
          5: STitle := Copy(STitle, 6, 22);
          6: STitle := Copy(STitle, 7, 22);
        end;
      end;
      }
    if (STitle='') or (STitle='about:blank') then
    STitle:=TFormWebBrowser(wbList[i]).WebBrowser.LocationName;

    SUrl:=TFormWebBrowser(wbList[i]).WebBrowser.LocationURL;
    if (Trim(STitle)<>'') and (Trim(SUrl)<>'') and (LowerCase(Trim(SUrl))<>'about:blank') then
    OpenURLList.Add(STitle+'#'+SUrl);
  end;
  if OpenURLList.Count>=0 then
  begin
    case Flag of
      0:
      begin
        if FormMain.CBURL.Items.Count>0 then
        FormMain.CBURL.Items.SaveToFile(MyDir+URLFile);
      end;
      1:
      OpenURLList.SaveToFile(MyDir+OpenURLListFile);
      2:
      begin
        //if OpenURLList.Count>=2 then
        OpenURLList.SaveToFile(MyDir+OpenURLListFile);
        OpenURLList.SaveToFile(MyDir+OpenURLListFile2);
        if FormMain.CBURL.Items.Count>0 then
        FormMain.CBURL.Items.SaveToFile(MyDir+URLFile);
      end;
    end;
  end;
  if (Flag<>1) and (not CloseApp) then
  WritePrivateProfileString('RunData','TrueClose','0',PChar(MyDir+ConfigFile));
  finally
  OpenURLList.Free;
  end;
except end;
end;

function TFormPublic.KBDString(Str: String): String;
var
  I: Integer;
begin
try
  I := Pos('tn=' + BaiDuSearchIDMain1, Str);
  if I <> 0 then
  Str := Copy(Str, 1, I - 1) + Copy(Str, I + Length(BaiduSearchIDMain1) + 3 + 3 + 1, Length(Str) - I)
  else if DoubleSearch then
  begin
    I := Pos('tn=' + BaiDuSearchIDMain2, Str);
    if I <> 0 then
    Str := Copy(Str, 1, I - 1) + Copy(Str, I + Length(BaiduSearchIDMain2) + 3 + 3 + 1, Length(Str) - I);
  end;
  Result := Str;
except end;
end;

//工具栏收藏夹开始
procedure TFormPublic.GetFavoritFolder;
var
  ItemIDList: PItemIDList;
  TmpPath: array[0..MAX_PATH] of Char;
  IniFile: TIniFile;
  Str: String;
  Bool: Boolean;
begin
try
  //if FavDirMe then exit;
  {
  if B_NFavoritFolder then
  begin
    IniFile:=TIniFile.Create(MyDir + ConfigFile);
    Str := (IniFile.ReadString('Setting','FavoritDir',''));
    if (Trim(Str) = '') then Bool := true
    else
    if (Pos('/', Trim(Str)) <> 1) and (Pos('\', Trim(Str)) <> 1) and (not DirectoryExists(Str)) then Bool := true
    else
    begin
      if DirectoryExists(Str) then
      begin
        FavoritDir := Str;
        ShowMessage(FavoritDir);
        exit;
      end
      else
      begin
        FavoritDir := Copy(Str, 2, Length(Str) - 1);
        if not DirectoryExists(MyDir + FavoritDir) then Bool := true;
      end;
    end;
    if Bool then B_NFavoritFolder := false
    else exit;
  end;
  }
  SHGetSpecialFolderLocation(FormMain.Handle, CSIDL_FAVORITES, ItemIDList);
  SHGetPathFromIDList(ItemIDList, TmpPath);
  if FavDirMe then SFavoritFolder := TmpPath
  else
  begin
    FavoritFolder := TmpPath;
    SetForm.EFavoriteDir.Text := FavoritFolder;
    SetForm.BFavOk.Enabled := false;
  end;
  if FavoritFolder[Length(FavoritFolder)]<> '\' then FavoritFolder := FavoritFolder + '\';
except end;
end;

//->
procedure AddDummy(Menu: TMenuItem);
var
  Dummy: TMenuItem;
begin
try
  Dummy := TMenuItem.Create(Menu);
  Dummy.Visible := False;
  Menu.Add(Dummy);
except end;
end;

procedure TFormPublic.NewMenuClick(Sender: TObject);
var
  MenuItem: TMenuItem;
  List: TStringList;
  I: Integer;

  Buffer: array[0..2047] of Char;
  Str: String;
begin
try
  MenuItem := Sender as TMenuItem;
  if MenuItem.Count = 1 then
  begin
    List := TStringList.Create;
    try
      SearchDir(MenuItem.Hint, List);
      List.Sort;
      //===
      MenuItem2 := TMenuItem.Create(nil);
      MenuItem2.Caption := '添加链接到本目录...&';
      MenuItem2.Hint := MenuItem.Hint;
      MenuItem2.OnAdvancedDrawItem := DrawMainItem;
      MenuItem2.OnMeasureItem := MeasureMainItem;
      MenuItem2.Visible := true;
      MenuItem2.OnClick := AddFavToThisDir;
      MenuItem.Add(MenuItem2);
      MenuItem2 := TMenuItem.Create(nil);
      MenuItem2.Caption := '打开本目录下所有链接&';
      MenuItem2.Hint := MenuItem.Hint;
      MenuItem2.OnAdvancedDrawItem := DrawMainItem;
      MenuItem2.OnMeasureItem := MeasureMainItem;
      MenuItem2.Visible := true;
      MenuItem2.OnClick := DirAllOpen;
      MenuItem.Add(MenuItem2);
      //MenuItem.Free;
      MenuItem2 := TMenuItem.Create(nil);
      MenuItem2.Caption := '-';
      MenuItem2.OnAdvancedDrawItem := DrawMainItem;
      MenuItem2.OnMeasureItem := MeasureMainItem;
      MenuItem2.Visible := true;
      MenuItem.Add(MenuItem2);
      //===
      for I := 0 to List.Count -1 do
        MenuItem.Add(List.Objects[I] as TMenuItem);
    finally
      List.Free;
    end;
  end else
    if MenuItem.Count = 0 then
    begin
      //ShowMessage(MenuItem.Hint);
      GetPrivateProfileString('InternetShortcut',PChar('URL'),nil,Buffer,SizeOf(Buffer),PChar(MenuItem.Hint));
      Str:=String(Buffer);
      FormMain.CBURL.Text := Str;
      FormMain.BBGO.Click;
    end;
except end;
end;

procedure TFormPublic.SearchDir(Dir: string; List: TStringList);
var
  Found: Integer;
  MenuItem: TMenuItem;
  SearchRec: TSearchRec;

  Str: string;
begin
try
  Found := FindFirst(Format('%s*.*', [Dir]), faAnyFile, SearchRec);
  while Found = 0 do
  begin
    if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
    begin
      if (SearchRec.Name <> 'Desktop.ini') then
      begin
      MenuItem := TMenuItem.Create(Self);
      MenuItem.OnClick := NewMenuClick;
      MenuItem.OnAdvancedDrawItem := DrawMainItem;
      MenuItem.OnMeasureItem := MeasureMainItem;
      if (SearchRec.Attr and faDirectory <> 0) then
      begin
        Str:=SearchRec.Name;
        //MenuItem.Caption := SearchRec.Name;
        if Length(Str)>32 then Str:=Copy(Str,1,32)+'...';
        MenuItem.Caption := Str + '&';
        MenuItem.ImageIndex := 0;
        MenuItem.ImageIndex := 1;
        MenuItem.Hint := Format('%s%s\', [Dir, SearchRec.Name]);
        AddDummy(MenuItem);
        List.AddObject(Format('a%s', [SearchRec.Name]), MenuItem);
      end else
      begin                 
        MenuItem.ImageIndex := 1;
        MenuItem.ImageIndex := 2;
        //MenuItem.Caption := Copy(SearchRec.Name, 0, Length(SearchRec.Name) -4);
        Str:=Copy(SearchRec.Name, 0, Length(SearchRec.Name) -4);
        if Length(Str)>38 then Str:=Copy(Str,1,38)+'...';
        MenuItem.Caption := Str + '&';
        MenuItem.Hint := Dir + SearchRec.Name;
        List.AddObject(Format('b%s', [SearchRec.Name]), MenuItem);
      end;
      end;
    end;
    Found := FindNext(SearchRec);
  end;
  FindClose(SearchRec);
except end;
end;

procedure TFormPublic.NFavoritClick(Sender: TObject);
var
  List: TStringList;
  I, Col, MaxCol, J: Integer;
  MaxCount: Integer;
  Pt: TPoint;
  MenuItem: TMenuItem;
begin    
try
  for I := NFavorit.Count -1 downto 5 do NFavorit.Items[I].Free;
  Pt := FormMain.PaintPanelButtonAddress.ClientToScreen(Point(0, FormMain.PaintPanelButtonAddress.Height));
  MaxCount := (Screen.DesktopHeight - Pt.Y) div (MainMenu1.Images.Height + 4)+1;
  //MaxCount := (FormMain.Height div 24);
  List := TStringList.Create;
  try
    SearchDir(FavoritFolder, List);
    List.Sort;
    Col := 0;
    MenuItem := nil;
    if List.Count + NFavorit.Count > MaxCount then
    begin
      Col := (List.Count + NFavorit.Count) div MaxCount;
      MaxCol := StrToIntDef('3', 3);
      if Col >= MaxCol then
      begin
        MenuItem := TMenuItem.Create(Self);
        MenuItem.OnClick := NFavDropClick;
        MenuItem.OnDrawItem := NFavDropImgDrawItem;
        //MenuItem.OnAdvancedDrawItem := DrawMainItem;
        //MenuItem.OnMeasureItem := MeasureMainItem;
        J := MaxCol * MaxCount - NFavorit.Count -1;
        for I := PMFavDropList.Items.Count -1 downto 0 do
          PMFavDropList.Items[I].Free;
        for I :=  List.Count -1 downto J do
        begin
          PMFavDropList.Items.Insert(0, List.Objects[I] as TMenuItem);
          List.Delete(I);
        end;
        if Col > MaxCol + 1 then
          for I := 1 to Col - MaxCol do
            PMFavDropList.Items[I * MaxCount].Break := mbBreak;
        Col := MaxCol;
      end;
    end;
    for I := 0 to List.Count -1 do
      NFavorit.Add(List.Objects[I] as TMenuItem);
    if Assigned(MenuItem) then NFavorit.Add(MenuItem);
    if Col = 1 then
      NFavorit.Items[I * MaxCount].Break := mbBreak else
      for I := 1 to Col -1 do
        NFavorit.Items[I * MaxCount].Break := mbBreak;
  finally
     List.Free;
  end;
except end;
end;

procedure TFormPublic.NFavDropClick(Sender: TObject);
var
  Pt: TPoint;
begin
try
  Pt := ClienttoScreen(Point(0, 0));
  PMFavDropList.Popup(Pt.X, Pt.Y);
except end;
end;

procedure TFormPublic.NFavDropImgDrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
var
  X, Y: Integer;
begin
try
  ACanvas.Brush.Color := clBackground;
  ACanvas.FillRect(ARect);
  X := (ARect.Right - ARect.Left - ImageListFavDrop.Width) div 2 + ARect.Left;
  Y := (ARect.Bottom - ARect.Top - ImageListFavDrop.Height) div 2 + ARect.Top;
  if Selected then
    ImageListFavDrop.Draw(ACanvas, X, Y, 0, True) else
    ImageListFavDrop.Draw(ACanvas, X, Y, 1, True);
except end;
end;

procedure TFormPublic.AddFavToThisDir(Sender: TObject);
var
  Title, Url: string;
  MenuItem: TMenuItem;
begin
try
  MenuItem := (Sender as TMenuItem);
  //ShowMessage({FavoritFolder + }MenuItem.Hint);   exit;
  Url := TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl;
  if Trim(Url) = 'about:blank' then exit;
  Title := TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationName;
  with TIniFile.Create(MenuItem.Hint + Title + '.url') do
  try
    WriteString('InternetShortcut', 'URL', Url);
    ShowMessage('已经成功添加[' + MenuItem.Hint + Title + '.url' + ']!');  //到收藏夹目录[' + MenuItem.Hint + ']!');
    if MenuItem.Tag = FavCoteFlag then MakeFavoriteBar;
  finally
    Free;
  end;
except end;
end;

procedure TFormPublic.AddFav;
var
  Title, Url: string;
begin
try
  Url := TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl;
  if Trim(Url) = 'about:blank' then exit;
  Title := TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationName;
  with TIniFile.Create(FavoritFolder + Title + '.url') do
  try
    WriteString('InternetShortcut', 'URL', Url);
    ShowMessage('已经成功添加[' + FavoritFolder + Title + '.url' + ']!');  //到收藏夹目录[' + MenuItem.Hint + ']!');
    if FormMain.ToolBarFavorite.Visible then MakeFavoriteBar;
  finally
    Free;
  end;
except end;
end;

procedure TFormPublic.DirAllOpen(Sender: TObject);
var
  MenuItem: TMenuItem;
  I: Integer;
  Buffer: array[0..2047] of Char;
  Str: String;
begin
try
  MenuItem := (Sender as TMenuItem);
  //ShowMessage(IntToStr(MenuItem.Parent.Count div 2));
  for I := 0 to MenuItem.Parent.Count - 1 do
  begin
    //ShowMessage(MenuItem.Parent.Items[I].Hint );
    if I = 1 then MoreUrlOpen := true;
    if LowerCase(ExtractFileExt(MenuItem.Parent.Items[I].Hint)) = '.url' then
    begin
      GetPrivateProfileString('InternetShortcut',PChar('URL'),nil,Buffer,SizeOf(Buffer),PChar(MenuItem.Parent.Items[I].Hint));
      Str:=String(Buffer);
      FormMain.CBURL.Text:=Str;
      FormMain.BBGO.OnClick(Sender);  
    end;
  end;
  MoreUrlOpen := false;
except end;
end;

procedure TFormPublic.FavBarMenuClick(Sender: TObject);
var
  MenuItem: TMenuItem;
  List: TStringList;
  I: Integer;

  Buffer: array[0..2047] of Char;
  Str: String;

  MenuItem2: TMenuItem;
begin
try
  MenuItem := Sender as TMenuItem;
  if MenuItem.Count = 1 then
  begin        
    List := TStringList.Create;
    try
      FavBarSearchDir(MenuItem.Hint, List);
      //ShowMessage(MenuItem.Hint);
      List.Sort;
      //===
      {
      MenuItem2 := TMenuItem.Create(nil);
      MenuItem2.Caption := '添加收藏到本目录...&';
      MenuItem2.Visible := true;
      MenuItem.Add(MenuItem2);
      //MenuItem.Free;
      }
      MenuItem2 := TMenuItem.Create(nil);
      MenuItem2.Caption := '添加链接到本目录...&';
      MenuItem2.Hint := MenuItem.Hint;
      MenuItem2.OnAdvancedDrawItem := DrawMainItem;
      MenuItem2.OnMeasureItem := MeasureMainItem;
      MenuItem2.Visible := true;
      MenuItem2.Tag := FavCoteFlag;
      MenuItem2.OnClick := AddFavToThisDir;
      MenuItem.Add(MenuItem2);
      MenuItem2 := TMenuItem.Create(nil);
      MenuItem2.Caption := '打开本目录下所有链接&';
      MenuItem2.OnAdvancedDrawItem := DrawMainItem;
      MenuItem2.OnMeasureItem := MeasureMainItem;
      MenuItem2.Hint := MenuItem.Hint;
      MenuItem2.Visible := true;
      MenuItem2.OnClick := DirAllOpen;
      MenuItem.Add(MenuItem2);
      //MenuItem.Free;
      MenuItem2 := TMenuItem.Create(nil);
      MenuItem2.Caption := '-';
      MenuItem2.OnAdvancedDrawItem := DrawMainItem;
      MenuItem2.OnMeasureItem := MeasureMainItem;
      MenuItem2.Visible := true;
      MenuItem.Add(MenuItem2);
      //===
      for I := 0 to List.Count -1 do
        MenuItem.Add(List.Objects[I] as TMenuItem);
    finally
      List.Free;
    end;
  end else
    if MenuItem.Count = 0 then
    begin
      //ShowMessage(MenuItem.Hint);
      MoreUrlOpen := false;
      GetPrivateProfileString('InternetShortcut',PChar('URL'),nil,Buffer,SizeOf(Buffer),PChar(MenuItem.Hint));
      Str:=String(Buffer);
      //MoreUrlOpen := true;
      FormMain.CBURL.Text:=Str;
      FormMain.BBGO.OnClick(Sender);  
    end;
except end;
end;

procedure TFormPublic.FavBarSearchDir(Dir: string; List: TStringList);
var
  Found: Integer;
  MenuItem: TMenuItem;
  SearchRec: TSearchRec;
  Str:string;
begin
try
  Found := FindFirst(Format('%s*.*', [Dir]), faAnyFile, SearchRec);
  while Found = 0 do
  begin
    if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
    begin
      MenuItem := TMenuItem.Create(Self);
      MenuItem.OnClick := FavBarMenuClick;
      if (SearchRec.Attr and faDirectory <> 0) then
      begin
        Str:=SearchRec.Name;
        if Length(Str)>32 then Str:=Copy(Str,1,32)+'...';
        MenuItem.Caption := Str;
        MenuItem.ImageIndex := 1;
        MenuItem.Hint := Format('%s%s\', [Dir, SearchRec.Name]);
        MenuItem.OnAdvancedDrawItem := DrawMainItem;
        MenuItem.OnMeasureItem := MeasureMainItem;
        AddDummy(MenuItem);
        List.AddObject(Format('a%s', [SearchRec.Name]), MenuItem);
      end else
      begin
        MenuItem.ImageIndex := 2;
        Str:=Copy(SearchRec.Name, 0, Length(SearchRec.Name) -4);
        if Length(Str)>38 then Str:=Copy(Str,1,38)+'...';
        MenuItem.Caption := Str;
        MenuItem.Hint := Dir + SearchRec.Name;
        MenuItem.OnAdvancedDrawItem := DrawMainItem;
        MenuItem.OnMeasureItem := MeasureMainItem;
        List.AddObject(Format('b%s', [SearchRec.Name]), MenuItem);
      end;
    end;
    Found := FindNext(SearchRec);
  end;
  FindClose(SearchRec);
except end;
end;

procedure TFormPublic.FavoriteBarFileClick(Sender: TObject);
var
  ToolButton: TToolButton;
  Buffer: array[0..2047] of Char;
  Str: String;
begin
try
  ToolButton := Sender as TToolButton;
  Str := ToolButton.Hint;
  //ShowMessage(Str);
  GetPrivateProfileString('InternetShortcut',PChar('URL'),nil,Buffer,SizeOf(Buffer),PChar(Str));
  Str:=String(Buffer);
  FormMain.CBURL.Text:=Str;
  FormMain.BBGO.OnClick(Sender);
except end;
end;

procedure TFormPublic.MakeFavoriteBar;
var
  ItemIDList: PItemIDList;
  TmpPath: array[0..MAX_PATH] of Char;
  List: TStringList;
  SearchRec: TSearchRec;
  Found: Integer;
  Button: TToolButton;
  I: Integer;
  Path: string;
  MenuItem: TMenuItem;
begin
try
  if FavDirMe then Path := FavoritFolder
  else
  begin
    SHGetSpecialFolderLocation(Handle, CSIDL_FAVORITES, ItemIDList);
    SHGetPathFromIDList(ItemIDList, TmpPath);
    Path := TmpPath;
  end;
  //Path := TmpPath;
  if Path[Length(Path)] <> '\' then Path := Path + '\';
  List := TStringList.Create;
  try
    Found := FindFirst(Path + '\*.*', faAnyFile, SearchRec);
    while Found = 0 do
    begin
      if SearchRec.Attr and faDirectory > 0 then
      begin
        if SearchRec.Name[1] <> '.' then
        begin
          Button := TToolButton.Create(FormMain.ToolBarFavorite);
          MenuItem:= TMenuItem.Create(Self);
          MenuItem.Caption := SearchRec.Name;
          MenuItem.ImageIndex := 2;
          AddDummy(MenuItem);
          MenuItem.Hint := Format('%s\%s\', [Path, SearchRec.Name]);
          Menuitem.OnClick := FavBarMenuClick;
          PopupMenuFavBar.Items.Add(MenuItem);
          Button.AutoSize := True;
          Button.Grouped := True;
          Button.MenuItem := MenuItem;
          List.AddObject('a' + SearchRec.Name, Button);
        end;
      end else
      if LowerCase(ExtractFileExt(SearchRec.Name)) = '.url' then
      begin
        Button := TToolButton.Create(FormMain.ToolBarFavorite);
        Button.Caption := Copy(SearchRec.Name, 1, Length(SearchRec.Name) - 4);
        Button.Hint := Path + SearchRec.Name;;
        Button.OnClick := FavoriteBarFileClick;
        Button.AutoSize := True;
        Button.ImageIndex := 3;
        List.AddObject('b' + SearchRec.Name, Button);
      end;
      Found := FindNext(SearchRec);
    end;
    FindClose(SearchRec);
    List.Sort;
    for I := List.Count - 1 downto 0 do
      (List.Objects[I] as TToolButton).Parent := FormMain.ToolBarFavorite;
  finally
    List.Free;
  end;
except end;
end;

//<-

procedure TFormPublic.NewlyCloseAdd(Title, Url: string);
var
  MenuItem: TMenuItem;
begin
try
  if (Trim(Url) = '') or (Trim(Url) = 'about:blank') then exit;
  MenuItem := TMenuItem.Create(Self);
  MenuItem.OnClick := NewlyClick;
  {
  if ShowWebIcon then
  begin
    Case WebIconNeedBlankCount of       
    2: Title := Copy(Title, 3, 40);
    3: Title := Copy(Title, 4, 40);
    4: Title := Copy(Title, 5, 40);
    5: Title := Copy(Title, 6, 40);
    6: Title := Copy(Title, 7, 40);
    end;
  end;
  }
  if Length(Title) >= 36 then Title := Copy(Title, 1, 36) + '...';
  MenuItem.Caption := Title + '&';
  MenuItem.Hint := Url;
  MenuItem.Visible := true;
  FormMain.PopupMenuNewly.Items.Add(MenuItem);
  //MenuItem.Free;
except end;
end;

procedure TFormPublic.NewlyClick(Sender:TObject);
var
  i:Byte;
begin
try
  FormMain.CBURL.Text:=TMenuItem(Sender).Hint;
  FormMain.BBGO.OnClick(Sender);
  for i:=0 to FormMain.PopupMenuNewly.Items.Count-1 do
  begin
    if FormMain.PopupMenuNewly.Items[i].Hint=TMenuItem(Sender).Hint then
    begin
      FormMain.PopupMenuNewly.Items.Delete(i);
      exit;
    end;
  end;
except end;
end;

{
procedure TFormPublic.LoadNewly;
var
  i:Byte;
  NewItem:TMenuItem;
begin
try
  if not FileExists(MyDir+NewlyBrowserFile) then exit;
  //ListBoxNewly.Items.Clear;
  ListBoxNewly.Items.LoadFromFile(MyDir+NewlyBrowserFile);
  if ListBoxNewly.Items.Count<=0 then exit;
    for i:=0 to ListBoxNewly.Items.Count-1 do
    begin
      //if Trim(ListBoxNewly.Items[i])<>'' then
      //PopupMenuNewly.Items[i].Caption:=Copy(ListBoxNewly.Items[i],1,Pos('#',ListBoxNewly.Items[i])-1);
      //PopupMenuNewly.Items[i].Hint:=Copy(ListBoxNewly.Items[i],Pos('#',ListBoxNewly.Items[i])+1,Length(ListBoxNewly.Items[i])-Pos('#',ListBoxNewly.Items[i]));
      //SaveToNewly(Copy(ListBoxNewly.Items[i],1,Pos('#',ListBoxNewly.Items[i])-1),Copy(ListBoxNewly.Items[i],Pos('#',ListBoxNewly.Items[i])+1,Length(ListBoxNewly.Items[i])-Pos('#',ListBoxNewly.Items[i])));
      NewItem:=TMenuItem.Create(nil);
      NewItem.Visible:=true;   //ShowMessage(IntToStr(URLList.Count));
      NewItem.Caption:=Copy(ListBoxNewly.Items[i],1,Pos('#',ListBoxNewly.Items[i])-1);
      NewItem.Hint:=Copy(ListBoxNewly.Items[i],Pos('#',ListBoxNewly.Items[i])+1,Length(ListBoxNewly.Items[i])-Pos('#',ListBoxNewly.Items[i]));
      NewItem.OnClick:=NewlyClick;
      PopupMenuNewly.Items.Add(NewItem);
      if PopupMenuNewly.Items.Count>12 then exit;
    end;
except end;
end;
}

//{
procedure TFormPublic.CleanNewly;
var
  i:integer;
begin
try
  try
  if FormMain.PopupMenuNewly.Items.Count <= {0}2 then exit;
  for i := FormMain.PopupMenuNewly.Items.Count-1 downto {0}2 do
  begin
    FormMain.PopupMenuNewly.Items.Delete(i);
  end;
  finally
  //if FileExists(MyDir+NewlyBrowserFile) then DeleteFile(MyDir+NewlyBrowserFile);
  end;
except end;
end;
//}

procedure TFormPublic.SaveToImage;
var
  Doc:IHTMLDocument2;
  ViewObject: IViewObject;
  sourceDrawRect: TRect;
  a, getjpg: TBitMap;
  i, m: integer;
  pdest, psour: hbitmap;
  jpg: tjpegimage;
  FileName,FileName2:string;
  WB:TWebBrowser;
begin
try
  if wbList.Count=0 then exit;
  if not FormPublic.SaveDialogToImage.Execute then exit;
  FileName:=FormPublic.SaveDialogToImage.FileName;
      //{
      case FormPublic.SaveDialogToImage.FilterIndex of
      0,1:
      begin
        FileName:=ChangeFileExt(FileName,'.jpg');
      end;
      2:
      begin
        FileName:=ChangeFileExt(FileName,'.bmp');
      end;
      end;
      //}
  if FileExists(FileName) then
  begin
    //if MessageDlg('确定要关闭整个TOB吗？',mtconfirmation,[mbyes,mbno],0)=mryes then
    //if (Application.MessageBox('所要保存的文件已经存，确认要覆盖吗？','请确认:',MB_YESNO)=IDNO) then
    if MessageBox(FormMain.Handle,'所要保存的文件已经存，确认要覆盖吗？','询问:',MB_YESNO+MB_ICONINFORMATION)=ID_NO then
    begin
      SaveToImage;
      exit;
    end;
  end;
  LockWindowUpdate(FormMain.Handle);
  try
  WB:=TFormWebBrowser(wbList[PageIndex]).WebBrowser;
  Doc:=WB.Document as IHTMLDocument2;
  //Doc:=TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document as IHTMLDocument2;
  if WB.Document <> nil then
  //if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document <> nil then
  begin
    WB.Document.QueryInterface(IViewObject, ViewObject);
    //TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document.QueryInterface(IViewObject, ViewObject);
    if ViewObject <> nil then
      Doc.Get_ParentWindow.Scroll(0, 0); //跳到网页头
      getjpg := TBitMap.Create();
      getjpg.PixelFormat := pf24bit;
      getjpg.Height := doc.Body.getAttribute('scrollHeight', 0);
      getjpg.Width := doc.Body.getAttribute('scrollwidth', 0);
      pdest := getjpg.Canvas.Handle;
      m := Trunc(doc.Body.getAttribute('ScrollHeight', 0) / (doc.Body.getAttribute('offsetHeight', 0) - 20));
      i := Trunc(doc.Body.getAttribute('Scrollwidth', 0) / (doc.Body.getAttribute('offsetwidth', 0) - 20));
      for i := 0 to i do
      begin
        for m := 0 to m + 1 do
        begin                  
          a := TBitMap.Create();
          a.Height := doc.Body.getAttribute('offsetHeight', 0);
          a.Width := doc.Body.getAttribute('offsetwidth', 0);
          psour := a.Canvas.handle;
          sourceDrawRect := Rect(0, 0, a.Width, a.Height);
          ViewObject.Draw(DVASPECT_CONTENT, 1, nil, nil, Self.Handle, a.Canvas.Handle, @sourceDrawRect, nil, nil, 0);
          bitblt(pdest, doc.Body.getAttribute('scrollLeft', 0), doc.Body.getAttribute('Scrolltop', 0), a.Width, a.Height, psour, 2, 2, srccopy);
          Doc.Get_ParentWindow.Scroll(doc.Body.getAttribute('scrollLeft', 0), doc.Body.getAttribute('offsetHeight', 0) + doc.Body.getAttribute('Scrolltop', 0) - GetSystemMetrics(SM_CXVSCROLL) - 24);
          a.Free;
        end;
        Doc.Get_ParentWindow.Scroll(doc.Body.getAttribute('offsetwidth', 0) + doc.Body.getAttribute('scrollLeft', 0) - GetSystemMetrics(SM_CXVSCROLL) - 24, 0);
      end;
      jpg := tjpegimage.Create;
      jpg.Assign(getjpg);
      getjpg.Free;
      case FormPublic.SaveDialogToImage.FilterIndex of
      0,1:
      begin
        if (LowerCase(ExtractFileExt(FileName))<>'.jpg') and (LowerCase(ExtractFileExt(FileName))<>'.jpeg') then
        FileName:=ChangeFileExt(FileName,'.jpg');
        jpg.SaveToFile(FileName);
      end;
      2:
      begin
        if (LowerCase(ExtractFileExt(FileName))<>'.jpg') and (LowerCase(ExtractFileExt(FileName))<>'.jpeg') then
        FileName:=ChangeFileExt(FileName,'.jpg');
        jpg.SaveToFile(FileName);
        if not FileExists(FileName) then
        begin
          if (LowerCase(ExtractFileExt(FileName))<>'.jpg') and (LowerCase(ExtractFileExt(FileName))<>'.jpeg') then
          FileName:=ChangeFileExt(FileName,'.jpg');
          jpg.SaveToFile(FileName);
        end;
        FileName2:=ChangeFileExt(FileName,'.bmp');
        JpgToBmp(PChar(FileName),PChar(FileName2));
        DeleteFile(FileName);
      end;
      end;
      jpg.Free;
    end;
  finally
    LockWindowUpdate(0);
    ViewObject._Release;
  end;
except end;
end;

procedure GenerateJPEGfromBrowser(browser: iWebBrowser2;
                                 jpegFQFilename: string; srcHeight:
                                 integer; srcWidth: integer;
                                 tarHeight: integer; tarWidth: integer);
var
  sourceDrawRect: TRect;
  targetDrawRect: TRect;
  sourceBitmap  : TBitmap;
  targetBitmap  : TBitmap;
  aJPG          : TJPEGImage;
  aViewObject   : IViewObject;
begin
  sourceBitmap := TBitmap.Create;
  targetBitmap := TBitmap.Create;
  aJPG := TJPEGImage.Create;
  try
    try
      sourceDrawRect := Rect(0, 0, srcWidth, srcHeight);
      sourceBitmap.Width := srcWidth;
      sourceBitmap.Height := srcHeight;

      aViewObject := browser as IViewObject;

      if aViewObject=nil then
        Exit;

      OleCheck(aViewObject.Draw(DVASPECT_CONTENT, 1, nil, nil,
                               Application.Handle,
                               sourceBitmap.Canvas.Handle,
                               @sourceDrawRect, nil, nil, 0));

       // 设定图片尺寸 
      targetDrawRect := Rect(0, 0, tarWidth, tarHeight);
      targetBitmap.Height := tarHeight;
      targetBitmap.Width := tarWidth;
      targetBitmap.Canvas.StretchDraw(targetDrawRect, sourceBitmap);

      // 产生JPEG并保存
      aJPG.Assign(targetBitmap);

      aJPG.SaveToFile(jpegFQFilename)
    finally
      aJPG.Free;
      sourceBitmap.Free;
      targetBitmap.Free
    end; { try }
  except
    // 处理异常
  end; 
end;

procedure TFormPublic.SaveToImage2; 
var
  IDoc1: IHTMLDocument2;
  Web  : iWebBrowser2;
  tmpX,
  tmpY : integer;

  FileName,FileName2:string;
begin
try
  if wbList.Count=0 then exit;
  if not FormPublic.SaveDialogToImage.Execute then exit;
  FileName:=FormPublic.SaveDialogToImage.FileName;
  //FileName:=ChangeFileExt(FileName,'.jpg');
      //{
      case FormPublic.SaveDialogToImage.FilterIndex of
      0,1:
      begin
        FileName:=ChangeFileExt(FileName,'.jpg');
      end;
      2:
      begin
        FileName:=ChangeFileExt(FileName,'.bmp');
      end;
      end;
      //}

  if FileExists(FileName) then
  begin
    //if MessageDlg('确定要关闭整个TOB吗？',mtconfirmation,[mbyes,mbno],0)=mryes then
    //if (Application.MessageBox('所要保存的文件已经存，确认要覆盖吗？','请确认:',MB_YESNO)=IDNO) then
    if MessageBox(FormMain.Handle,'所要保存的文件已经存，确认要覆盖吗？','询问:',MB_YESNO+MB_ICONINFORMATION)=ID_NO then
    begin
      exit;
    end;
  end;
  //LockWindowUpdate(FormMain.Handle);
  try
  FileName:=ChangeFileExt(FileName,'.jpg');
  with TFormWebBrowser(wbList[PageIndex]).WebBrowser do
  begin
    Document.QueryInterface(IHTMLDocument2, IDoc1);
    Web := ControlInterface;
    tmpX := Height;
    tmpY := Width;
    Height := OleObject.Document.Body.getAttribute('scrollHeight', 0) + GetSystemMetrics(SM_CXVSCROLL)+3;// .ParentWindow.Screen.Height+1000;
    Width := OleObject.Document.Body.getAttribute('scrollwidth', 0) + GetSystemMetrics(SM_CXVSCROLL)+3;//.ParentWindow.Screen.Width;
    GenerateJPEGfromBrowser(Web, FileName, Height, Width, Height, Width);
        Height := tmpX;
    Width := tmpY;
  end;

      case FormPublic.SaveDialogToImage.FilterIndex of
      0,1:
      begin
        //if (LowerCase(ExtractFileExt(FileName))<>'.jpg') and (LowerCase(ExtractFileExt(FileName))<>'.jpeg') then
        //FileName:=ChangeFileExt(FileName,'.jpg');
      end;
      2:
      begin
        //if (LowerCase(ExtractFileExt(FileName))<>'.jpg') and (LowerCase(ExtractFileExt(FileName))<>'.jpeg') then
        //FileName:=ChangeFileExt(FileName,'.jpg');
        if not FileExists(FileName) then exit;
        FileName2:=ChangeFileExt(FileName,'.bmp');
        JpgToBmp(PChar(FileName),PChar(FileName2));
        DeleteFile(FileName);
      end;
      end;
  finally
    //LockWindowUpdate(0);
  end;
except end;
end;

{
procedure TFormPublic.GetWebIcon2(WebIndex: Integer; WebUrl: String);
var
  I, I2, I3: Integer;
  Str: String;
begin
try
  if not ShowWebIcon then exit;
  //if Trim(WebUrl) = 'about:blank' then exit;
  //if WebIndex >= 999 then WebIndex := PageIndex;
  I := Pos('://', WebUrl);
  if I > 0 then
  begin
    //ShowMessage(IntToStr(I) + ' : ' + IntToStr(Pos('www.', LowerCase(WebUrl))));  exit;
    if Pos('www.', LowerCase(WebUrl)) = I + 3 then
    begin
      I2 := Pos('/', Copy(WebUrl, I + 3, Length(WebUrl)));
      if I2 > 0 then
      Str := Copy(WebUrl, 1, I2 + I + 2) + 'favicon.ico'
      else
      Str := WebUrl + '/favicon.ico';
    end
    else
    begin
      //I := Pos('://', WebUrl);
      I2 := Pos('.', WebUrl);          //http://it.sohu.com/abc/index.htm
      I3 := Pos('/', Copy(WebUrl, I + 3, Length(WebUrl)));
      Str := Copy(WebUrl, 1, I + 2) + 'www' + Copy(WebUrl, I2, I3 - I2 + I + 2) + '/favicon.ico';;
      //ShowMessage(Str);
    end;
  end
  else
  begin
    I2 := Pos('/', WebUrl);
    if I2 <= 0 then
    Str := 'http://' + WebUrl + '/favicon.ico'
    else
    Str := 'http://' + Copy(WebUrl, 1, I2) + 'favicon.ico';
  end;
  if FileExists(TempDir + WebIconFile) then DeleteFile(TempDir + WebIconFile);
  DownloadFile(PChar(Str),PChar(TempDir + WebIconFile));
  if not FileExists(TempDir + WebIconFile) then
  else
  begin
    FormMain.ImageWebIcon.Picture.LoadFromFile(TempDir + WebIconFile);
    FormMain.ImageListWebIcon.ReplaceIcon(WebIndex, FormMain.ImageWebIcon.Picture.Icon);
    //for I := 0 to FormMain.ToolBarTabParent.ButtonCount - 1 do FormMain.ToolBarTabParent.Buttons[I].ImageIndex := I;
    FormMain.ToolBarTabParent.Repaint;
  end;
  //ShowMessage(Str + '#' + TempDir + WebIconFile);
except end; 
end;
}

procedure TFormPublic.InterFaceSkin(i: Word);
var
  Str: String;
begin
try
  try
  finally
  end;
except end;
end;

procedure TFormPublic.NSetWhiteListClick(Sender: TObject);
begin
try
  SetForm.PageControl1.ActivePage := SetForm.TabSheetWhiteList;
  SetForm.RBWhiteList.Checked := true;
  SetForm.BWhiteListLoad.OnClick(Sender);
  SetForm.Show;
except end;
end;

{$IFDEF LANGUAGE}
procedure TFormPublic.English;
begin
try
  NFile.Caption:='File(F)';
  NEdit.Caption:='Edit(E)';
  NView.Caption:='View(V)';
  NFavorit.Caption:='Favorit(A)';
  NGroup.Caption:='Group(G)';
  //NCommend.Caption:='Commend(C)';
  NSet.Caption:='Option(O)';
  NTools.Caption:='Tools(T)';
  NHelp.Caption:='Help(H)';

  //File
  NAddNew.Caption:='Add New';
  //
  NAddNewBlank.Caption:='Add New Blank';
  NAddNewHomePage.Caption:='Add New HomePage';
  NCopyCurrentPage.Caption:='Copy Current Page';
  //
  NOpenFile.Caption:='Open File(&O)';
  NSavaAsImage.Caption:='Sava As Image';
  NSaveImgMode1.Caption := 'Mode1';
  NSaveImgMode2.Caption := 'Mode2';
  NSaveAs.Caption:='Save As(&A)';
  NPageSetup.Caption:='Page Setup(&U)';
  NPrint.Caption:='Print';
  NPrintView.Caption:='Print View(&V)';
  NSend.Caption:='Send(&E)';
  //
  NNewMail.Caption:='New Mail(&P)';
  NSendPage.Caption:='Send Page(&L)';
  NSendLink.Caption:='Desktop Quick Link(&S)';
  //
  NImport.Caption:='Import Export(&I)';
  NCloseCurrent.Caption:='Close Current';
  NAllClose.Caption:='All Close';
  NAttribute.Caption:='Attribute(&R)';
  NOffline.Caption:='Offline';
  NQuickExit.Caption:='Quick Exit';
  NExit.Caption:='Exit(&E)';

  //Edit
  NOpenNewlyOne.Caption:='Open Newly One';
  NNewlyCloseList.Caption:= 'Newly Close List';
  NCut.Caption:='Cut(&T)';
  NCopy.Caption:='Copy(&C)';
  NPaste.Caption:='Paste(&P)';
  NSelectAll.Caption:='Select All(&A)';
  NFind.Caption:='Find(&F)';
  NAddressSetFocus.Caption:='Address Set Focus';
  NDocmentSetFocus.Caption:='Docment Set Focus';
  NCleanCurrentAd.Caption:='Clean Current Ad';
  NEditSource.Caption:='Edit Source';

  //View
  NToolCote.Caption:='Tool Cote';
  //
  //
  //NShowCaption.Caption:='Show Caption';
  NShowMenu.Caption:='Show Menu';
  NShowButton.Caption:='Show Button';
  NShowSearch.Caption:='Show Search';

  NSideCote.Caption:='Side Cote';

  NFavoritCote.Caption:='Favorit Cote';
  NStatusBarV.Caption:='StatusBar';
  NStatusBarE.Caption:='StatusBar Extend';

  //NStandardButtonImg.Caption:='Standard Button Image';
  //NStandardButtonImgStyle1.Caption:='Standard Button Img Style 1';
  //NStandardButtonImgStyle2.Caption:='Standard Button Img Style 2';
  NFontSize.Caption:='Font Size(&X)';  
  //
  NLargest.Caption:='Largest(&G)';
  NLarger.Caption:='Larger(&L)';
  NMiddle.Caption:='Middle(&M)';
  NSmall.Caption:='Small(&S)';
  NSmallest.Caption:='Smallest(&A)';
  //
  NPageView.Caption:='Page View';
  //
  //
  NStop.Caption:='Stop';
  NTOPageHome.Caption:='TO Page Home';
  NTOPageEnd.Caption:='TO Page End';
  NRefresh.Caption:='Refresh';
  NAllStop.Caption:='All Stop';
  NAllRefresh.Caption:='All Refresh';
  NPreviousPage.Caption:='Previous Page';
  NNextPage.Caption:='Next Page';
  NSource.Caption:='Source(&C)';

  //Favorit
  NAddFavorite.Caption:='Add Favorite(&F)';
  NTrimFavorite.Caption:='Trim Favorite(&O)';
  NOpenFavoriteDir.Caption:='Open Favorite Dir';
  //NReloadFavorit.Caption:='Reload Favorit';

  //Group
  NSetGroup.Caption:='Set Group';
  NSaveToGroup.Caption:='Save All To Group';
  NAddToGroup.Caption:='Add To Group';

  //Option
  NPopup.Caption:='Popup Lock';
  //
  NStopPopup.Caption:='Stop Popup';
  NStopFloatAd.Caption:='Stop Float Ad';
  NStopFlashAd.Caption:='Stop Flash Ad';
  NDisableShowGIF.Caption:='Disable Show GIF';
  NDisableShowImage.Caption:='Disable Show Image';
  NSetWhiteList.Caption:='Set White List';

  NDownControl.Caption:='Download Control';
  //
  NNoImage.Caption:='NNoImage';
  NNoVideo.Caption:='No Video';
  NNoBgsound.Caption:='No Bgsound';
  NNoJava.Caption:='No Java';
  NNoScript.Caption:='No Script';
  NNoActivex.Caption:='No ActiveX';

  //NCallBackMemory.Caption:='Height CallBack Memory';
  //
  NAtMemThrift.Caption:='At Mem Thrift';
  NProxy.Caption:='Proxy';
  //
  NSetProxy.Caption:='Set Proxy';
  NUseIEProxy.Caption:='Use IE Proxy';
  NNoUseProxy.Caption:='No Use Proxy';
  //
  NCheckDefaultBrowser.Caption:='Check Default Browser';
  NSetDefBrowser.Caption:='Set Default Browser';
  //
  NSetBrowserTOP.Caption:='Set Browser '+BrowserName;
  NSetBrowserIE.Caption:='Set Browser IE';
  //
  //
  NFaceSkin.Caption:='Face Skin';
  //
  NFaceStyle0.Caption:='Face Default';
  NFaceStyle1.Caption:='Face1';
  NFaceStyle2.Caption:='Face2';
  //
  NTabWidthP.Caption:='Tab Width';
  NTabOption.Caption := 'Tab Option';
  NShowLogo.Caption:='Show Web Logo';
  NShowWebIconY.Caption:='Show Logo Y';
  NShowWebIconN.Caption:='Show Logo N';
  NTabCloseShow.Caption := 'Show Tab Close';
  NShowTabCloseY.Caption := 'Show Close Y';
  NShowTabCloseN.Caption := 'Show Close N';
  NTabStyle.Caption:='Tab Style';
  NTabStyle0.Caption:='Style 1';
  NTabStyle1.Caption:='Style 2';
  NTabAutoWidth.Caption:='Tab Auto Width';
  NButtonImg.Caption:='Button Image';
  //dddd
  //                     
  NCurrNoSilent.Caption:='Current No Silent';
  NRunOne.Caption:='Run One';
  //NSetDefBrowser.Caption:='To Default Set';   fff
  NWebAutoRefresh.Caption := 'Web Auto Refresh';
  NSetZoom.Caption := 'Set Page Zoom';
  NAutoHintAndShutdown.Caption := 'Auto Hint';
  NInternetOption.Caption:='Internet Option';
  NTOPOption.Caption:=BrowserName+' Option';   

  //Tools
  NQuickLink.Caption:='Quick Link';
  //
  NWeather.Caption:='Weather';
  //
  NPlayMusic.Caption:='Play Music';
  NMTV.Caption:='Online TV';
  NTabLock.Caption:='Tab Lock';

  NAutoFullForm.Caption := 'Auto Full Form';
  NSInput.Caption:='Form Input';
  NSaveForm.Caption:='Save Form';
  NInputTable.Caption:='Auto Input Table';

  NGetScreen.Caption:='Get Screen';

  NQuickClearMemory.Caption:='Quick Clear Memory';
  NLockToolBar.Caption:='Lock ToolBar';
  NUnLockWebPage.Caption:='UnLock WebPage';
  NProgram.Caption:='Program';
  //
  NMyComputer.Caption:='My Computer';
  NNotepad.Caption:='Notepad';
  NMspaint.Caption:='Mspaint';
  NRunControl.Caption:='Control';
  NAddDeleteControl.Caption:='Add Delete Control';
  NCommandLine.Caption:='Command Line';
  NRegedit.Caption:='Regedit';
  NFollowTOPClose.Caption:='Follow '+BrowserName+' Close';
  //
  NCleanHisttoryM.Caption:='Clean Histtory';
  //
  NCleanAddress.Caption:='Clean Address';
  NCleanNewly.Caption:='Clean Newly';
  NClearSearchHistory.Caption:='Clear Search History';
  NCleanHistory.Caption:='Clean History';
  NCleanCache.Caption:='Clean Cache';
  NCleanCookies.Caption:='Clean Cookies';
  NCleanTempDir.Caption:='Clean Temp Dir';
  NCleanFavorite.Caption:='Clean Favorite';
  NCleanRecent.Caption:='Clean Recent';
  NCleanAll.Caption:='Clean All';
  //

  //Help
  NSubHelp.Caption:='Help';
  NHelpOnline.Caption:='Help Online';
  NBrowserHomePage.Caption:=BrowserName+' HomePage';
  NBrowserBBS.Caption:=BrowserName+' BBS';
  NSustain.Caption:='Sustain';
  NUpdateOnline.Caption:='Update Online';
  NAutoUpdateHint.Caption := 'Auto Update Hint';
  NAbout.Caption:='About';
except end;
end;

procedure TFormPublic.LanguageOther;
begin
try
  FormMain.Caption := 'kx Browser';
  SetForm.Caption:='Browser Option';

  FormMain.ToolButtonFav.Caption := 'Favorite';
  FormMain.ToolButtonMusicPlay.Caption := 'Music Play';
  FormMain.TBAddFav.Caption := 'Add';
  FormMain.TBHistory.Caption := 'History';
  FormMain.TBWebNavigation.Caption := 'WebNavigation';

  SetForm.TabSheet1.Caption:='General';
  SetForm.TabSheet2.Caption:='Window';
  SetForm.TabSheetButton.Caption:='Button';
  SetForm.TabSheetMousssTable.Caption:='Mouse Gesture';
  SetForm.TabSheetQuickLink.Caption:='Quick URL';
  SetForm.TabSheetProxy.Caption:='Porxy';
  SetForm.TabSheetHistory.Caption:='History';
  SetForm.TabSheetWhiteList.Caption:='White List';       
  SetForm.TabSheetOther.Caption:='Other Option';
  SetForm.TabSheetSystem.Caption:='System';

  FormMain.LMusicName.Caption:='Double Click To Play Music.';
  FormMain.RBOrderPlay.Caption:='Order';
  FormMain.RBRandomPlay.Caption:='Random';
  FormMain.RBOneLoopPlay.Caption:='Loop One';
  FormMain.Label29.Caption:='Volume Control';
  FormMain.Label27.Caption:='Play Position';
  FormMain.SBOpenMusicFile.Caption:='Open File';
  FormMain.SBOpenDir.Caption:='Open Dir';
  FormMain.TBOpenUrl.Caption:='Open Url';

  SetForm.SBSystemInfo.Caption:='SystemInfo';
  SetForm.SBMemoryOptimize.Caption:='MemoryOptimize';
  SetForm.SBGetAutoRunKey.Caption:='AutoRunKey';
  SetForm.SBProcessPath.Caption:='ProcessPath';
  SetForm.SBAllProcess.Caption:='AllProcess';
  { 
  .Caption:='';
  .Caption:='';
  }
except end;
end;

procedure TFormPublic.LanguageIni(B:Byte);
var
  inifile:TIniFile;
begin
try
  case B of
  0,1:exit;
  2:
  begin
    IniFile:=TIniFile.Create(MyDir+EnglishFile);
    //.Caption.Caption:=IniFile.ReadString('Data','','');
    NFile.Caption:=IniFile.ReadString('Data','NFile','');
    NEdit.Caption:=IniFile.ReadString('Data','NEdit','');
    NView.Caption:=IniFile.ReadString('Data','NView','');
    NFavorit.Caption:=IniFile.ReadString('Data','NFavorit','');
    NGroup.Caption:=IniFile.ReadString('Data','NGroup','');
    //NCommend.Caption:=IniFile.ReadString('Data','NCommend','');
    NSet.Caption:=IniFile.ReadString('Data','NSet','');
    NTools.Caption:=IniFile.ReadString('Data','NTools','');
    NHelp.Caption:=IniFile.ReadString('Data','NHelp','');                

    NAddNew.Caption:=IniFile.ReadString('Data','NAddNew','');

    NAddNewBlank.Caption:=IniFile.ReadString('Data','NAddNewBlank','');
    NAddNewHomePage.Caption:=IniFile.ReadString('Data','NAddNewHomePage','');
    NCopyCurrentPage.Caption:=IniFile.ReadString('Data','NCopyCurrentPage','');

    NOpenFile.Caption:=IniFile.ReadString('Data','NOpenFile','');
    NSavaAsImage.Caption:=IniFile.ReadString('Data','NSaveAsImage','');
    NSaveImgMode1.Caption:=IniFile.ReadString('Data','SaveImgMode1','');
    NSaveImgMode2.Caption:=IniFile.ReadString('Data','SaveImgMode2','');
    NSaveAs.Caption:=IniFile.ReadString('Data','NSaveAs','');
    NPageSetup.Caption:=IniFile.ReadString('Data','NPageSetup','');
    NPrint.Caption:=IniFile.ReadString('Data','NPrint','');
    NPrintView.Caption:=IniFile.ReadString('Data','NPrintView','');
    NSend.Caption:=IniFile.ReadString('Data','NSend','');

    NNewMail.Caption:=IniFile.ReadString('Data','NNewMail','');
    NSendPage.Caption:=IniFile.ReadString('Data','NSendPage','');
    NSendLink.Caption:=IniFile.ReadString('Data','NSendLink','');

    NImport.Caption:=IniFile.ReadString('Data','NImport','');
    NCloseCurrent.Caption:=IniFile.ReadString('Data','NCloseCurrent','');
    NAllClose.Caption:=IniFile.ReadString('Data','NAllClose','');
    NAttribute.Caption:=IniFile.ReadString('Data','NAttribute','');
    NOffline.Caption:=IniFile.ReadString('Data','NOffline','');
    NQuickExit.Caption:=IniFile.ReadString('Data','NQuickExit','');
    NExit.Caption:=IniFile.ReadString('Data','NExit','');

    NOpenNewlyOne.Caption:=IniFile.ReadString('Data','NOpenNewlyOne','');
    NNewlyCloseList.Caption:=IniFile.ReadString('Data','NNewlyCloseList','');
    NCut.Caption:=IniFile.ReadString('Data','NCut','');
    NCopy.Caption:=IniFile.ReadString('Data','NCopy','');

    NPaste.Caption:=IniFile.ReadString('Data','NPaste','');
    NSelectAll.Caption:=IniFile.ReadString('Data','NSelectAll','');
    NFind.Caption:=IniFile.ReadString('Data','NFind','');
    NAddressSetFocus.Caption:=IniFile.ReadString('Data','NAddressSetFocus','');
    NDocmentSetFocus.Caption:=IniFile.ReadString('Data','NDocmentSetFocus','');
    NCleanCurrentAd.Caption:=IniFile.ReadString('Data','NCleanCurrentAd','');
    NEditSource.Caption:=IniFile.ReadString('Data','NEditSource','');

    NToolCote.Caption:=IniFile.ReadString('Data','NToolCote','');

    //NSideCote.Caption:=IniFile.ReadString('Data','NSideCote','');
    //NStatusBarV.Caption:=IniFile.ReadString('Data','NStatusBarV','');

    //NShowCaption.Caption:=IniFile.ReadString('Data','NShowCaption','');
    NShowMenu.Caption:=IniFile.ReadString('Data','NShowMenu','');
    NShowButton.Caption:=IniFile.ReadString('Data','NShowButton','');
    NShowSearch.Caption:=IniFile.ReadString('Data','NShowSearch','');

    NSideCote.Caption:=IniFile.ReadString('Data','NSideCote','');

    NFavoritCote.Caption:=IniFile.ReadString('Data','NFavoritCote','');
    NStatusBarV.Caption:=IniFile.ReadString('Data','NStatusBarV','');
    NStatusBarE.Caption:=IniFile.ReadString('Data','NStatusBarE','');

    NFontSize.Caption:=IniFile.ReadString('Data','NFontSize','');

    NLargest.Caption:=IniFile.ReadString('Data','NLargest','');
    NLarger.Caption:=IniFile.ReadString('Data','NLarger','');
    NMiddle.Caption:=IniFile.ReadString('Data','NMiddle','');
    NSmall.Caption:=IniFile.ReadString('Data','NSmall','');
    NSmallest.Caption:=IniFile.ReadString('Data','NSmallest','');

    NPageView.Caption:=IniFile.ReadString('Data','NPageView','');

    NStop.Caption:=IniFile.ReadString('Data','NStop','');
    NTOPageHome.Caption:=IniFile.ReadString('Data','NTOPageHome','');
    NTOPageEnd.Caption:=IniFile.ReadString('Data','NTOPageEnd','');
    NRefresh.Caption:=IniFile.ReadString('Data','NRefresh','');
    NAllStop.Caption:=IniFile.ReadString('Data','NAllStop','');
    NAllRefresh.Caption:=IniFile.ReadString('Data','NAllRefresh','');
    NPreviousPage.Caption:=IniFile.ReadString('Data','NPreviousPage','');
    NNextPage.Caption:=IniFile.ReadString('Data','NNextPage','');
    NSource.Caption:=IniFile.ReadString('Data','NSource','');

    NAddFavorite.Caption:=IniFile.ReadString('Data','NAddFavorite','');
    NTrimFavorite.Caption:=IniFile.ReadString('Data','NTrimFavorite','');
    NOpenFavoriteDir.Caption:=IniFile.ReadString('Data','NOpenFavoriteDir','');
    //NReloadFavorit.Caption:=IniFile.ReadString('Data','NReloadFavorit','');

    NSetGroup.Caption:=IniFile.ReadString('Data','NSetGroup','');
    NSaveToGroup.Caption:=IniFile.ReadString('Data','NSaveToGroup','');
    NAddToGroup.Caption:=IniFile.ReadString('Data','NAddToGroup','');

    NPopup.Caption:=IniFile.ReadString('Data','NPopup','');

    NStopPopup.Caption:=IniFile.ReadString('Data','NStopPopup','');
    NStopFloatAd.Caption:=IniFile.ReadString('Data','NStopFloatAd','');
    NStopFlashAd.Caption:=IniFile.ReadString('Data','NStopFlashAd','');
    NDisableShowGIF.Caption:=IniFile.ReadString('Data','NDisableShowGIF','');
    NDisableShowImage.Caption:=IniFile.ReadString('Data','NDisableShowImage','');
    NSetWhiteList.Caption:=IniFile.ReadString('Data','NSetWhiteList','');

    NDownControl.Caption:=IniFile.ReadString('Data','NDownControl','');
    //
    NNoImage.Caption:=IniFile.ReadString('Data','NNoImage','');
    NNoVideo.Caption:=IniFile.ReadString('Data','NNoVideo','');
    NNoBgsound.Caption:=IniFile.ReadString('Data','NNoBgsound','');
    NNoJava.Caption:=IniFile.ReadString('Data','NNoJava','');
    NNoScript.Caption:=IniFile.ReadString('Data','NNoScript','');
    NNoActivex.Caption:=IniFile.ReadString('Data','NNoActivex','');
    
    //NCallBackMemory.Caption:=IniFile.ReadString('Data','NCallBackMemory','');

    NAtMemThrift.Caption:=IniFile.ReadString('Data','NAtMemThrift','');
    NProxy.Caption:=IniFile.ReadString('Data','NProxy','');

    NSetProxy.Caption:=IniFile.ReadString('Data','NSetProxy','');
    NUseIEProxy.Caption:=IniFile.ReadString('Data','NUseIEProxy','');
    NNoUseProxy.Caption:=IniFile.ReadString('Data','NNoUseProxy','');

    NCheckDefaultBrowser.Caption:=IniFile.ReadString('Data','NCheckDefaultBrowser','');
    NSetDefBrowser.Caption:=IniFile.ReadString('Data','NSetDefBrowser','');

    NSetBrowserTOP.Caption:=IniFile.ReadString('Data','NSetBrowserMe','');
    NSetBrowserIE.Caption:=IniFile.ReadString('Data','NSetBrowserIE','');

    //
    NFaceSkin.Caption:=IniFile.ReadString('Data','NFaceSkin','');
    //
    NFaceStyle0.Caption:=IniFile.ReadString('Data','NFaceStyle0','');
    NFaceStyle1.Caption:=IniFile.ReadString('Data','NFaceStyle1','');
    NFaceStyle2.Caption:=IniFile.ReadString('Data','NFaceStyle2','');
    //

    NTabWidthP.Caption:=IniFile.ReadString('Data','NTabWidthP','');

    NTabOption.Caption := IniFile.ReadString('Data','NTabOption','');
    NShowLogo.Caption:=IniFile.ReadString('Data','NShowLogo','');
    NShowWebIconY.Caption:=IniFile.ReadString('Data','NShowWebIconY','');
    NShowWebIconN.Caption:=IniFile.ReadString('Data','NShowWebIconN','');
    NTabCloseShow.Caption := IniFile.ReadString('Data','NTabCloseShow','');
    NShowTabCloseY.Caption := IniFile.ReadString('Data','NShowTabCloseY','');
    NShowTabCloseN.Caption := IniFile.ReadString('Data','NShowTabCloseN','');

    NTabStyle.Caption:=IniFile.ReadString('Data','NTabStyle','');
    NTabStyle0.Caption:=IniFile.ReadString('Data','NTabStyle0','');
    NTabStyle1.Caption:=IniFile.ReadString('Data','NTabStyle1','');
    NTabAutoWidth.Caption:=IniFile.ReadString('Data','NTabAutoWidth','');
    NButtonImg.Caption:=IniFile.ReadString('Data','NButtonImg','');

    NCurrNoSilent.Caption:=IniFile.ReadString('Data','NCurrNoSilent','');
    NRunOne.Caption:=IniFile.ReadString('Data','NRunOne','');
    //NSetDefBrowser.Caption:=IniFile.ReadString('Data','NToDefaultSet','');
    NWebAutoRefresh.Caption := IniFile.ReadString('Data','NWebAutoRefresh','');
    NSetZoom.Caption := IniFile.ReadString('Data','NSetZoom','');
    NAutoHintAndShutdown.Caption := IniFile.ReadString('Data','NAutoHintAndShutdown','');
    NInternetOption.Caption:=IniFile.ReadString('Data','NInternetOption','');
    NTOPOption.Caption:=IniFile.ReadString('Data','NBrowserOption','');

    NQuickLink.Caption:=IniFile.ReadString('Data','NQuickLink','');

    NWeather.Caption:=IniFile.ReadString('Data','NWeather','');

    NPlayMusic.Caption:=IniFile.ReadString('Data','NPlayMusic','');
    NMTV.Caption:=IniFile.ReadString('Data','NMTV','');

    NTabLock.Caption:=IniFile.ReadString('Data','NTabLock','');

    NAutoFullForm.Caption := IniFile.ReadString('Data','NAutoFullForm','');
    NSInput.Caption:=IniFile.ReadString('Data','NSInput','');
    NSaveForm.Caption:=IniFile.ReadString('Data','NSaveForm','');
    NInputTable.Caption:=IniFile.ReadString('Data','NInputTable','');

    NGetScreen.Caption:=IniFile.ReadString('Data','NGetScreen','');

    NQuickClearMemory.Caption:=IniFile.ReadString('Data','NQuickClearMemory','');
    NLockToolBar.Caption:=IniFile.ReadString('Data','NLockToolBar','');
    NUnLockWebPage.Caption:=IniFile.ReadString('Data','NUnLockWebPage','');
    NProgram.Caption:=IniFile.ReadString('Data','NProgram','');

    NMyComputer.Caption:=IniFile.ReadString('Data','NMyComputer','');
    NNotepad.Caption:=IniFile.ReadString('Data','NNotepad','');
    NMspaint.Caption:=IniFile.ReadString('Data','NMspaint','');
    NRunControl.Caption:=IniFile.ReadString('Data','NRunControl','');
    NAddDeleteControl.Caption:=IniFile.ReadString('Data','NAddDeleteControl','');
    NCommandLine.Caption:=IniFile.ReadString('Data','NCommandLine','');
    NRegedit.Caption:=IniFile.ReadString('Data','NRegedit','');
    NFollowTOPClose.Caption:=IniFile.ReadString('Data','NFollowBrowserClose','');

    NCleanHisttoryM.Caption:=IniFile.ReadString('Data','NCleanHisttoryM','');

    NCleanAddress.Caption:=IniFile.ReadString('Data','NCleanAddress','');
    NClearSearchHistory.Caption:=IniFile.ReadString('Data','NClearSearchHistory','');
    NCleanNewly.Caption:=IniFile.ReadString('Data','NCleanNewly','');
    NCleanHistory.Caption:=IniFile.ReadString('Data','NCleanHistory','');
    NCleanCache.Caption:=IniFile.ReadString('Data','NCleanCache','');
    NCleanCookies.Caption:=IniFile.ReadString('Data','NCleanCookies','');
    NCleanTempDir.Caption:=IniFile.ReadString('Data','NCleanTempDir','');
    NCleanFavorite.Caption:=IniFile.ReadString('Data','NCleanFavorite','');
    NCleanRecent.Caption:=IniFile.ReadString('Data','NCleanRecent','');
    NCleanAll.Caption:=IniFile.ReadString('Data','NCleanAll','');

    NSubHelp.Caption:=IniFile.ReadString('Data','NSubHelp','');
    NHelpOnline.Caption:=IniFile.ReadString('Data','NHelpOnline','');
    NBrowserHomePage.Caption:=IniFile.ReadString('Data','NBrowserHomePage','');
    NBrowserBBS.Caption:=IniFile.ReadString('Data','NBrowserBBS','');
    NSustain.Caption:=IniFile.ReadString('Data','NSustain','');
    NUpdateOnline.Caption:=IniFile.ReadString('Data','NUpdateOnline','');
    NAutoUpdateHint.Caption := IniFile.ReadString('Data','NAutoUpdateHint','');
    NAbout.Caption:=IniFile.ReadString('Data','NAbout','');
    IniFile.Free;
  end;
  3:
  begin
    IniFile:=TIniFile.Create(MyDir+LanguageFile);
    //.Caption.Caption:=IniFile.ReadString('Data','','');
    NFile.Caption:=IniFile.ReadString('Data','NFile','');
    NEdit.Caption:=IniFile.ReadString('Data','NEdit','');
    NView.Caption:=IniFile.ReadString('Data','NView','');
    NFavorit.Caption:=IniFile.ReadString('Data','NFavorit','');
    NGroup.Caption:=IniFile.ReadString('Data','NGroup','');
    //NCommend.Caption:=IniFile.ReadString('Data','NCommend','');
    NSet.Caption:=IniFile.ReadString('Data','NSet','');
    NTools.Caption:=IniFile.ReadString('Data','NTools','');
    NHelp.Caption:=IniFile.ReadString('Data','NHelp','');

    NAddNew.Caption:=IniFile.ReadString('Data','NAddNew','');

    NAddNewBlank.Caption:=IniFile.ReadString('Data','NAddNewBlank','');
    NAddNewHomePage.Caption:=IniFile.ReadString('Data','NAddNewHomePage','');
    NCopyCurrentPage.Caption:=IniFile.ReadString('Data','NCopyCurrentPage','');

    NOpenFile.Caption:=IniFile.ReadString('Data','NOpenFile','');
    NSavaAsImage.Caption:=IniFile.ReadString('Data','NSaveAsImage','');
    NSaveImgMode1.Caption:=IniFile.ReadString('Data','SaveImgMode1','');
    NSaveImgMode2.Caption:=IniFile.ReadString('Data','SaveImgMode2','');
    NSaveAs.Caption:=IniFile.ReadString('Data','NSaveAs','');
    NPageSetup.Caption:=IniFile.ReadString('Data','NPageSetup','');
    NPrint.Caption:=IniFile.ReadString('Data','NPrint','');
    NPrintView.Caption:=IniFile.ReadString('Data','NPrintView','');
    NSend.Caption:=IniFile.ReadString('Data','NSend','');

    NNewMail.Caption:=IniFile.ReadString('Data','NNewMail','');
    NSendPage.Caption:=IniFile.ReadString('Data','NSendPage','');
    NSendLink.Caption:=IniFile.ReadString('Data','NSendLink','');

    NImport.Caption:=IniFile.ReadString('Data','NImport','');
    NCloseCurrent.Caption:=IniFile.ReadString('Data','NCloseCurrent','');
    NAllClose.Caption:=IniFile.ReadString('Data','NAllClose','');
    NAttribute.Caption:=IniFile.ReadString('Data','NAttribute','');
    NOffline.Caption:=IniFile.ReadString('Data','NOffline','');
    NQuickExit.Caption:=IniFile.ReadString('Data','NQuickExit','');
    NExit.Caption:=IniFile.ReadString('Data','NExit','');

    NOpenNewlyOne.Caption:=IniFile.ReadString('Data','NOpenNewlyOne','');
    NNewlyCloseList.Caption:=IniFile.ReadString('Data','NNewlyCloseList','');
    NCut.Caption:=IniFile.ReadString('Data','NCut','');
    NCopy.Caption:=IniFile.ReadString('Data','NCopy','');
    NPaste.Caption:=IniFile.ReadString('Data','NPaste','');
    NSelectAll.Caption:=IniFile.ReadString('Data','NSelectAll','');
    NFind.Caption:=IniFile.ReadString('Data','NFind','');
    NDocmentSetFocus.Caption:=IniFile.ReadString('Data','NDocmentSetFocus','');
    NCleanCurrentAd.Caption:=IniFile.ReadString('Data','NCleanCurrentAd','');
    NEditSource.Caption:=IniFile.ReadString('Data','NEditSource','');

    NToolCote.Caption:=IniFile.ReadString('Data','NToolCote','');

    //NShowCaption.Caption:=IniFile.ReadString('Data','NShowCaption','');
    NShowMenu.Caption:=IniFile.ReadString('Data','NShowMenu','');
    NShowButton.Caption:=IniFile.ReadString('Data','NShowButton','');
    NShowSearch.Caption:=IniFile.ReadString('Data','NShowSearch','');

    NSideCote.Caption:=IniFile.ReadString('Data','NSideCote','');

    NFavoritCote.Caption:=IniFile.ReadString('Data','NFavoritCote','');
    NStatusBarV.Caption:=IniFile.ReadString('Data','NStatusBarV','');
    NStatusBarE.Caption:=IniFile.ReadString('Data','NStatusBarE','');
    
    NFontSize.Caption:=IniFile.ReadString('Data','NFontSize','');

    NLargest.Caption:=IniFile.ReadString('Data','NLargest','');
    NLarger.Caption:=IniFile.ReadString('Data','NLarger','');
    NMiddle.Caption:=IniFile.ReadString('Data','NMiddle','');
    NSmall.Caption:=IniFile.ReadString('Data','NSmall','');
    NSmallest.Caption:=IniFile.ReadString('Data','NSmallest','');

    NPageView.Caption:=IniFile.ReadString('Data','NPageView','');

    NStop.Caption:=IniFile.ReadString('Data','NStop','');
    NTOPageHome.Caption:=IniFile.ReadString('Data','NTOPageHome','');
    NTOPageEnd.Caption:=IniFile.ReadString('Data','NTOPageEnd','');
    NRefresh.Caption:=IniFile.ReadString('Data','NRefresh','');  
    NAllStop.Caption:=IniFile.ReadString('Data','NAllStop','');
    NAllRefresh.Caption:=IniFile.ReadString('Data','NAllRefresh','');
    NPreviousPage.Caption:=IniFile.ReadString('Data','NPreviousPage','');
    NNextPage.Caption:=IniFile.ReadString('Data','NNextPage','');
    NSource.Caption:=IniFile.ReadString('Data','NSource','');

    NAddFavorite.Caption:=IniFile.ReadString('Data','NAddFavorite','');
    NTrimFavorite.Caption:=IniFile.ReadString('Data','NTrimFavorite','');
    NOpenFavoriteDir.Caption:=IniFile.ReadString('Data','NOpenFavoriteDir','');
    //NReloadFavorit.Caption:=IniFile.ReadString('Data','NReloadFavorit','');

    NSetGroup.Caption:=IniFile.ReadString('Data','NSetGroup','');
    NSaveToGroup.Caption:=IniFile.ReadString('Data','NSaveToGroup','');
    NAddToGroup.Caption:=IniFile.ReadString('Data','NAddToGroup','');

    NPopup.Caption:=IniFile.ReadString('Data','NPopup','');

    NStopPopup.Caption:=IniFile.ReadString('Data','NStopPopup','');
    NStopFloatAd.Caption:=IniFile.ReadString('Data','NStopFloatAd','');
    NStopFlashAd.Caption:=IniFile.ReadString('Data','NStopFlashAd','');
    NDisableShowGIF.Caption:=IniFile.ReadString('Data','NDisableShowGIF','');
    NDisableShowImage.Caption:=IniFile.ReadString('Data','NDisableShowImage','');
    NSetWhiteList.Caption:=IniFile.ReadString('Data','NSetWhiteList','');

    NDownControl.Caption:=IniFile.ReadString('Data','NDownControl','');
    //
    NNoImage.Caption:=IniFile.ReadString('Data','NNoImage','');
    NNoVideo.Caption:=IniFile.ReadString('Data','NNoVideo','');
    NNoBgsound.Caption:=IniFile.ReadString('Data','NNoBgsound','');
    NNoJava.Caption:=IniFile.ReadString('Data','NNoJava','');
    NNoScript.Caption:=IniFile.ReadString('Data','NNoScript','');
    NNoActivex.Caption:=IniFile.ReadString('Data','NNoActivex','');

    //NCallBackMemory.Caption:=IniFile.ReadString('Data','NCallBackMemory','');

    NAtMemThrift.Caption:=IniFile.ReadString('Data','NAtMemThrift','');
    NProxy.Caption:=IniFile.ReadString('Data','NProxy','');

    NSetProxy.Caption:=IniFile.ReadString('Data','NSetProxy','');
    NUseIEProxy.Caption:=IniFile.ReadString('Data','NUseIEProxy','');
    NNoUseProxy.Caption:=IniFile.ReadString('Data','NNoUseProxy','');

    NCheckDefaultBrowser.Caption:=IniFile.ReadString('Data','NCheckDefaultBrowser','');
    NSetDefBrowser.Caption:=IniFile.ReadString('Data','NSetDefBrowser','');

    NSetBrowserTOP.Caption:=IniFile.ReadString('Data','NSetBrowserMe','');
    NSetBrowserIE.Caption:=IniFile.ReadString('Data','NSetBrowserIE','');

    NTabWidthP.Caption:=IniFile.ReadString('Data','NTabWidthP','');

    NTabOption.Caption := IniFile.ReadString('Data','NTabOption','');
    NShowLogo.Caption:=IniFile.ReadString('Data','NShowLogo','');
    NShowWebIconY.Caption:=IniFile.ReadString('Data','NShowWebIconY','');
    NShowWebIconN.Caption:=IniFile.ReadString('Data','NShowWebIconN','');
    NTabCloseShow.Caption := IniFile.ReadString('Data','NTabCloseShow','');
    NShowTabCloseY.Caption := IniFile.ReadString('Data','NShowTabCloseY','');
    NShowTabCloseN.Caption := IniFile.ReadString('Data','NShowTabCloseN','');

    NTabStyle.Caption:=IniFile.ReadString('Data','NTabStyle','');
    NTabStyle0.Caption:=IniFile.ReadString('Data','NTabStyle0','');
    NTabStyle1.Caption:=IniFile.ReadString('Data','NTabStyle1','');
    NTabAutoWidth.Caption:=IniFile.ReadString('Data','NTabAutoWidth','');
    NButtonImg.Caption:=IniFile.ReadString('Data','NButtonImg','');

    NCurrNoSilent.Caption:=IniFile.ReadString('Data','NCurrNoSilent','');
    NRunOne.Caption:=IniFile.ReadString('Data','NRunOne','');
    //NSetDefBrowser.Caption:=IniFile.ReadString('Data','NToDefaultSet','');
    NWebAutoRefresh.Caption := IniFile.ReadString('Data','NWebAutoRefresh','');
    NSetZoom.Caption := IniFile.ReadString('Data','NSetZoom','');
    NAutoHintAndShutdown.Caption := IniFile.ReadString('Data','NAutoHintAndShutdown','');
    NInternetOption.Caption:=IniFile.ReadString('Data','NInternetOption','');
    NTOPOption.Caption:=IniFile.ReadString('Data','NBrowserOption','');

    NQuickLink.Caption:=IniFile.ReadString('Data','NQuickLink','');

    NWeather.Caption:=IniFile.ReadString('Data','NWeather','');

    NPlayMusic.Caption:=IniFile.ReadString('Data','NPlayMusic','');
    NMTV.Caption:=IniFile.ReadString('Data','NMTV','');

    NTabLock.Caption:=IniFile.ReadString('Data','NTabLock','');
               
    NAutoFullForm.Caption := IniFile.ReadString('Data','NAutoFullForm','');
    NSInput.Caption:=IniFile.ReadString('Data','NSInput','');
    NSaveForm.Caption:=IniFile.ReadString('Data','NSaveForm','');
    NInputTable.Caption:=IniFile.ReadString('Data','NInputTable','');

    NGetScreen.Caption:=IniFile.ReadString('Data','NGetScreen','');
    
    NQuickClearMemory.Caption:=IniFile.ReadString('Data','NQuickClearMemory','');
    NLockToolBar.Caption:=IniFile.ReadString('Data','NLockToolBar','');
    NUnLockWebPage.Caption:=IniFile.ReadString('Data','NUnLockWebPage','');
    NProgram.Caption:=IniFile.ReadString('Data','NProgram','');

    NMyComputer.Caption:=IniFile.ReadString('Data','NMyComputer','');
    NNotepad.Caption:=IniFile.ReadString('Data','NNotepad','');
    NMspaint.Caption:=IniFile.ReadString('Data','NMspaint','');
    NRunControl.Caption:=IniFile.ReadString('Data','NRunControl','');
    NAddDeleteControl.Caption:=IniFile.ReadString('Data','NAddDeleteControl','');
    NCommandLine.Caption:=IniFile.ReadString('Data','NCommandLine','');
    NRegedit.Caption:=IniFile.ReadString('Data','NRegedit','');
    NFollowTOPClose.Caption:=IniFile.ReadString('Data','NFollowBrowserClose','');

    NCleanHisttoryM.Caption:=IniFile.ReadString('Data','NCleanHisttoryM','');

    NCleanAddress.Caption:=IniFile.ReadString('Data','NCleanAddress','');
    NClearSearchHistory.Caption:=IniFile.ReadString('Data','NClearSearchHistory','');
    NCleanNewly.Caption:=IniFile.ReadString('Data','NCleanNewly','');
    NCleanHistory.Caption:=IniFile.ReadString('Data','NCleanHistory','');
    NCleanCache.Caption:=IniFile.ReadString('Data','NCleanCache','');
    NCleanCookies.Caption:=IniFile.ReadString('Data','NCleanCookies','');
    NCleanTempDir.Caption:=IniFile.ReadString('Data','NCleanTempDir','');
    NCleanFavorite.Caption:=IniFile.ReadString('Data','NCleanFavorite','');
    NCleanRecent.Caption:=IniFile.ReadString('Data','NCleanRecent','');
    NCleanAll.Caption:=IniFile.ReadString('Data','NCleanAll','');

    NSubHelp.Caption:=IniFile.ReadString('Data','NSubHelp','');
    NHelpOnline.Caption:=IniFile.ReadString('Data','NHelpOnline','');
    NBrowserHomePage.Caption:=IniFile.ReadString('Data','NBrowserHomePage','');
    NBrowserBBS.Caption:=IniFile.ReadString('Data','NBrowserBBS','');
    NSustain.Caption:=IniFile.ReadString('Data','NSustain','');
    NUpdateOnline.Caption:=IniFile.ReadString('Data','NUpdateOnline','');
    NAutoUpdateHint.Caption := IniFile.ReadString('Data','NAutoUpdateHint','');
    NAbout.Caption:=IniFile.ReadString('Data','NAbout','');
    IniFile.Free;
  end;
  end;
except end;
end;
{$ENDIF}

//检查默认浏览器
procedure TFormPublic.CheckDefaultBrowser_(flag:integer=0);
var
  Reg: TRegistry;
  cmdStr:string;
  myArray:Array[0..7] of Word;
  str1,str2:string;
begin
try
  //cmdStr:='"'+Application.ExeName+'" "%1"';

  str1:=ReadRegValue(HKEY_CLASSES_ROOT,'http\shell\',0,'');
  str2:=ReadRegValue(HKEY_CLASSES_ROOT,'http\shell\' + BrowserName + '\command\',0,'');
  //ShowMessage(Str1 + #10 + #13 + Str2);
  //if ((Trim(str1)<>BrowserName) or (pos(Application.ExeName,str2)=0)) then
  if (UpperCase(BrowserName) <> UpperCase(Trim(str1))) or (pos(Application.ExeName,str2)=0) then
  begin     
    //SetBrowser(1);
    //exit;
    //ShowMessage('App:'+Application.ExeName+#10+#13+'str2:'+str2);
    //if MessageDlg('确定要关闭整个浏览器吗？',mtconfirmation,[mbyes,mbno],0)=mryes then
    //if (Application.MessageBox('x目前不是默认浏览器,想把x设置为默认浏览器吗？','确认:',MB_YESNO)=IDNO) then
    case ForceDefaultBrowser of
    0,1:
    begin
      if MessageBox(Handle,BrowserName+'目前不是默认浏览器,想把'+BrowserName+'设置为默认浏览器吗？','询问',MB_YESNO+MB_ICONINFORMATION)=ID_NO then
      begin
        if ForceDefaultBrowser = 0 then
        begin
          if NCheckDefaultBrowser.Checked then NCheckDefaultBrowser.Checked:=false;
          WritePrivateProfileString('RunData','CheckDefaultBrowser','0',PChar(MyDir+ConfigFile));
        end
        else
        begin
          //SetBrowser(1);
          //NCheckDefaultBrowser.Checked:=true;
        end;
      end
      else
      begin
        SetBrowser(1);
        NCheckDefaultBrowser.Checked:=true;
      end;
    end;
    2:
    begin
      //MessageBox(Handle,BrowserName+'目前不是默认浏览器,想把'+BrowserName+'设置为默认浏览器吗？','询问',MB_YESNO+MB_ICONINFORMATION);
      SetBrowser(1);
    end;
    end;
  end;
  DocumentSetFocus;
except end;
end;

//设置某个浏览器为默认浏览器
procedure TFormPublic.SetBrowser(flag:integer=0);
var
  Reg:TRegistry;
  cmdStr:string;
  //myArray:array[0..7] of Word;
  str1,str2:string;
  BrowserName2:string;
  ApplicationName:string;
  str:string;

  Key1, Key2, Key3: String;
begin
try
  case flag of
  0,1:
  begin
    ApplicationName:=Application.ExeName;
    BrowserName2:=BrowserName;
  end;
  2:
  begin
    BrowserName2:='ie'; 
    //ApplicationName:='C:\Program Files\Internet Explorer\'+'iexplore.exe';
    str:=GetSystemFolderDir($0026);
    if (Trim(str)<>'') and DirectoryExists(str) then
    ApplicationName:=str+'\Internet Explorer\'+'iexplore.exe';
    if not FileExists(ApplicationName) then
    begin
      ApplicationName:=ReadRegValue(HKEY_CLASSES_ROOT,'http\Shell\Open\Command\',0,'');
    end;
    //ShowMessage(ApplicationName);
    if not FileExists(ApplicationName) then
    begin
      //ShowMessage('设置失败！');
      ApplicationName:='C:\Program Files\Internet Explorer\'+'iexplore.exe';
      if not FileExists(ApplicationName) then
      begin
        ShowMessage('设置失败！');
        exit;
      end;
    end;
  end;
  else
  begin
    ApplicationName:=Application.ExeName;
    BrowserName2:=BrowserName;
  end;
  end;
  cmdStr:='"'+ApplicationName+'" "%1"';
  {
  myArray[0] := $00;
  myArray[1] := $46;
  myArray[2] := $73;
  myArray[3] := $48;
  myArray[4] := $a2;
  myArray[5] := $56;
  myArray[6] := $c2;
  myArray[7] := $01;
  }
  //cmdStr := '"'+Application.ExeName+'" "%1"';
  //ShowMessage(ApplicationName);  //kkk
  Reg:=TRegistry.Create;
  try
    Reg.RootKey:=HKEY_CLASSES_ROOT;
    {
    Reg.OpenKey('Applications\'+BrowserName2+'.exe\shell\',True);
    Reg.WriteString('',BrowserName2);
    Reg.WriteString('FriendlyCache', BrowserName2);
    Reg.WriteBinaryData('FriendlyCacheCTime',myArray, 8);
    Reg.CloseKey;
    Reg.OpenKey('Applications\'+BrowserName2+'.exe\shell\'+BrowserName2+'\command\', True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;
    }
    {
    Reg.OpenKey('file\shell\',True);
    Reg.WriteString('',BrowserName2);
    Reg.CloseKey;
    Reg.OpenKey('file\shell\'+BrowserName2+'\command\',True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;
    Reg.OpenKey('file\shell\open\command\',True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;
    }
    {
    Reg.OpenKey('ftp\shell\',True);
    Reg.WriteString('',BrowserName2);
    Reg.CloseKey;
    Reg.OpenKey('ftp\shell\'+BrowserName2+'\command\',True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;
    Reg.OpenKey('ftp\shell\open\command\',True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;
    }

    Key1 := 'htmlfile\shell\';
    Key2 := 'HTTP\shell\';
    Key3 := 'https\shell\';
    case flag of
    0,1:
    begin
    {
    Reg.OpenKey('http\shell\',True);
    Reg.WriteString('',BrowserName2);
    Reg.CloseKey;
    Reg.OpenKey('http\shell\'+BrowserName2+'\command\',True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;
    Reg.OpenKey('http\shell\open\command\',True);
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
    }

    //Reg.WriteString('', System.ParamStr(0) + ' %1');
    if Reg.OpenKey(Key1, False) then
    begin      Reg.WriteString('', BrowserName2);      if Reg.OpenKey(BrowserName2 + '\command\', True) then        Reg.WriteString('', '"' + System.ParamStr(0) + '" "%1"');      Reg.CloseKey;    end;    if Reg.OpenKey(Key2, False) then    begin      Reg.WriteString('', BrowserName2);      if Reg.OpenKey(BrowserName2 + '\command\', True) then        Reg.WriteString('', '"' + System.ParamStr(0) + '" "%1"');      Reg.CloseKey;    end;

    if Reg.OpenKey(Key3, False) then
    begin      Reg.WriteString('', BrowserName2);      if Reg.OpenKey(BrowserName2 + '\command\', True) then        Reg.WriteString('', '"' + System.ParamStr(0) + '" "%1"');      Reg.CloseKey;    end;

    if Reg.OpenKey('http\shell\open\command\',True) then
    begin
      Reg.WriteString('', '"' + System.ParamStr(0) + '" "%1"');  //'"'+System.ParamStr(0)+'"' + ' "%1"'
      Reg.CloseKey;
    end;
    if Reg.OpenKey('htmlfile\shell\open\command\',True) then
    begin
      Reg.WriteString('', '"' + System.ParamStr(0) + '" "%1"');
      Reg.CloseKey;
    end;
    if Reg.OpenKey('https\shell\open\command\',True) then
    begin
      Reg.WriteString('', '"' + System.ParamStr(0) + '" "%1"');
      Reg.CloseKey;
    end;

    {
    Reg.OpenKey('CLSID\//0002DF01-0000-0000-C000-000000000046//\LocalServer32\',True);
    Reg.WriteString('', System.ParamStr(0));
    Reg.CloseKey;
    }
    //end;
    end;
    2:
    begin
    //{
    if Reg.OpenKey(Key1, False) then
    begin      Reg.WriteString('', 'OpenNew');      Reg.CloseKey;    end;    //}
    if Reg.OpenKey(Key2, False) then
    begin      Reg.WriteString('', BrowserName2);      {      if Reg.OpenKey(BrowserName2 + '\command\', True) then        Reg.WriteString('', cmdStr);      }      Reg.CloseKey;    end;
    if Reg.OpenKey(Key3, False) then
    begin      Reg.WriteString('', BrowserName2);      {      if Reg.OpenKey(BrowserName2 + '\command\', True) then        Reg.WriteString('', cmdStr);      }      Reg.CloseKey;    end;
    if Reg.OpenKey('http\shell\open\command\',True) then
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;
    Reg.OpenKey('htmlfile\shell\open\command\',True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;
    if Reg.OpenKey('https\shell\open\command\',True) then
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;
    {
    Reg.OpenKey('CLSID\//0002DF01-0000-0000-C000-000000000046//\LocalServer32\',True);
    Reg.WriteString('', ApplicationName);
    Reg.CloseKey;     
    }
    end;
    end;
    //}

  finally
    Reg.Free;
  end;
except end;
end;

function TFormPublic.ClearMemory:Boolean;
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

procedure TFormPublic.NStopFloatAdClick(Sender: TObject);
begin
try
  NStopFloatAd.Checked:=not NStopFloatAd.Checked;
  if NStopFloatAd.Checked then
  begin
    StopFloatAd:=true;
    WritePrivateProfileString('RunData','StopFloatAd','1',PChar(MyDir+ConfigFile));
    if wbList.Count <= 0 then exit;
    //TFormWebBrowser(wbList[PageIndex]).NoCleanFlash := false;
    if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
    ClearAd(TFormWebBrowser(wbList[PageIndex]).WebBrowser, TFormWebBrowser(wbList[PageIndex]).NoCleanFlash);
  end
  else
  begin
    StopFloatAd:=false;
    //TFormWebBrowser(wbList[PageIndex]).NoCleanFlash := true;
    WritePrivateProfileString('RunData','StopFloatAd','0',PChar(MyDir+ConfigFile));
    if wbList.Count <= 0 then exit;
    TFormWebBrowser(wbList[PageIndex]).WebBrowser.Refresh;
  end;
  //FormMain.ToolBarStatusBar.Repaint;
except end;
end;

procedure TFormPublic.NStopFlashAdClick(Sender: TObject);
begin
try
  try
  NStopFlashAd.Checked:=not NStopFlashAd.Checked;
  if NStopFlashAd.Checked then
  begin
    StopFlashAd:=true;
    WritePrivateProfileString('RunData','StopFlashAd','1',PChar(MyDir+ConfigFile));
    if wbList.Count <= 0 then exit;
    if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
    ClearAd(TFormWebBrowser(wbList[PageIndex]).WebBrowser, TFormWebBrowser(wbList[PageIndex]).NoCleanFlash);
  end
  else
  begin
    StopFlashAd:=false;
    WritePrivateProfileString('RunData','StopFlashAd','0',PChar(MyDir+ConfigFile));
    if wbList.Count <= 0 then exit;
    TFormWebBrowser(wbList[PageIndex]).WebBrowser.Refresh;
  end;
  finally
    TFormWebBrowser(wbList[PageIndex]).NoCleanFlash := not StopFlashAd;
    FormMain.ToolBarStatusBar.Repaint;   //kkkkk
    //FormMain.ToolBarStatusBar.Refresh;
  end;
except end;
end;

//============public================

//==菜单栏代码开始==

procedure TFormPublic.NExitClick(Sender: TObject);
begin
try
  //ShowCloseHint := false;
  FormMain.Close; //Application.Terminate;
  //Close;
except end;
end;

procedure TFormPublic.NAtMemThriftClick(Sender: TObject);
begin
try
  NAtMemThrift.Checked:=not NAtMemThrift.Checked;
  try
  if NAtMemThrift.Checked then
  begin
    MemoryThrift := true;
    TimerMemoryThrift.Enabled:=true;
    NQuickClearMemory.OnClick(Sender);
  end
  else
  begin
    MemoryThrift := false;
    TimerMemoryThrift.Enabled:=false;
  end;
  finally
    if NAtMemThrift.Checked then
      WritePrivateProfileString('RunData','MemThrift','1',PChar(MyDir+ConfigFile))
    else
      WritePrivateProfileString('RunData','MemThrift','0',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormPublic.NAboutClick(Sender: TObject);
begin
try
  //ShowMessage(BrowserName + ' ' + 'http://www.51vu.com/' + ' ' + 'Author:allfreelove@163.com');
  AboutForm:=TAboutForm.Create(Self);
  AboutForm.Caption:=TitleStr;
  AboutForm.ShowModal;
except end;
end;

//==菜单栏代码结束==

procedure TFormPublic.NShowORHideClick(Sender: TObject);
begin
try
  //{
  if WindowStateI=2 then
  begin      
    Application.Restore;
    SetForegroundWindow(FormMain.handle);
    FormMain.ApplicationEvents1.Activate;
    WindowStateI:=0;
    SetForm.TimerStatusBar.Enabled := true;
    FormPublic.DocumentSetFocus;
    exit;
  end;
  //}  //kokokk
  if FormMain.Visible then
  begin
    AllFormHide(1);    
    ShowWindow(Application.Handle, SW_HIDE);
    SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW);
    ShowWindow(Application.Handle, SW_SHOW);
    FormMain.Visible:=false;
    SetForm.TimerStatusBar.Enabled := false; 
    //SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW); //不在任务栏上创建图标
    //if NAtMemThrift.Checked then
    //begin
      //Timer1.Enabled:=true;
      if MemoryThrift2 then
      NQuickClearMemory.OnClick(Sender);
    //end;
  end
  else
  begin
    ShowWindow(Application.Handle, SW_HIDE);
    SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_OVERLAPPEDWINDOW);    ShowWindow(Application.Handle, SW_SHOW);
    FormMain.Visible:=true;
    SetForm.TimerStatusBar.Enabled := true;  
    SetForegroundWindow(FormMain.handle);
    //if MemoryThrift then
    //begin
      //Timer1.Enabled:=false;
      //if MemoryThrift2 then NQuickClearMemory.OnClick(Sender);
    //end;
    //FormMain.InterfaceRepaint; //FormMain.ApplicationEvents1.Activate;
    //FormPublic.DocumentSetFocus;
  end;
except end;
end;

procedure TFormPublic.NPopupExitClick(Sender: TObject);
begin
try
  //ShowCloseHint := false;
  NPopupExit.Enabled:=false;
  FormMain.Close;
except end;
end;

procedure TFormPublic.FormCreate(Sender: TObject);
//var
  //I: Integer;
begin
try
  //{
  try
  NRunOne.Caption:='只允许运行一个'+BrowserName+'实例';
  //NToDefaultSet.Caption:='恢复'+BrowserName+'默认设置';
  NTOPOption.Caption:=BrowserName+' '+'选项';
  NSetBrowserTOP.Caption:='设置 '+BrowserName+' 为默认浏览器';
  NFollowTOPClose.Caption:='随 '+BrowserName+' 关闭';
  NBrowserHomePage.Caption:=BrowserName+' '+'主页';
  NBrowserBBS.Caption:=BrowserName+' '+'论坛';
  NSustain.Caption := NSustain.Caption + BrowserName;
  NPopupExit.Caption := '退出 ' + BrowserName;
  NDaoHang.Caption := WebNavigationUrl_main;
  //UrlList := TStringList.Create;
  //ReadFavorit(NFavorit, FavoritFolder);
  finally
    GetWebIconOK := true;
    {
    FormMain.ToolBarMenu.Menu := nil;
    for I := 0 to ComponentCount - 1 do
    if Components[I] is TMenuItem then      (Components[I] as TMenuItem).OnDrawItem := MenuItemDrawItem;
    FormMain.ToolBarMenu.Menu := FormPublic.MainMenu1;
    }
  end;
  //}
except end;
end;

procedure TFormPublic.NOpenFileClick(Sender: TObject);
var
  TStr:string;
begin
try                   
  if not OpenDialog1.Execute then exit;
  if not FileExists(OpenDialog1.FileName) then exit;
  if (UpperCase(ExtractFileExt(OpenDialog1.FileName))='.HTM')
  or (UpperCase(ExtractFileExt(OpenDialog1.FileName))='.HTML')
  or (UpperCase(ExtractFileExt(OpenDialog1.FileName))='.ASP')
  or (UpperCase(ExtractFileExt(OpenDialog1.FileName))='.ASPX')
  or (UpperCase(ExtractFileExt(OpenDialog1.FileName))='.PHP')
  or (UpperCase(ExtractFileExt(OpenDialog1.FileName))='.JSP')
  or (UpperCase(ExtractFileExt(OpenDialog1.FileName))='.JPG')
  or (UpperCase(ExtractFileExt(OpenDialog1.FileName))='.JPEG')
  or (UpperCase(ExtractFileExt(OpenDialog1.FileName))='.BMP')
  or (UpperCase(ExtractFileExt(OpenDialog1.FileName))='.GIF')
  then
  begin
    TStr:=Trim(OpenDialog1.FileName);
    if not FileExists(TStr) then exit;
    FormMain.CBURL.Text:=TStr;
    FormMain.BBGO.OnClick(Sender);  
  end
  else ShellExecute(Handle,'open',PChar(OpenDialog1.FileName),nil,nil,0);
except end;
end;

procedure TFormPublic.NAddNewBlankClick(Sender: TObject);
begin
try
  FormMain.CBUrl.Text := 'about:blank';
  FormMain.Panel_StatusBar1.Caption := '';
  if AppendTab and (wbList.Count > 0) then
    FormPublic.NewPage(PageIndex + 1, 'about:blank', True)  else    FormPublic.NewPage(wbList.Count, 'about:blank', True);
  if FormMain.ToolBarTabParent.ButtonCount >= 1 then FormPublic.AddressSetFocus;
except end;
end;

procedure TFormPublic.NCopyCurrentPageClick(Sender: TObject);
begin
try
  FormMain.BBGO.OnClick(Sender);
except end;
end;

procedure TFormPublic.NSaveAsClick(Sender: TObject);
begin
try       
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.ExecWB(OLECMDID_SAVEAS,OLECMDEXECOPT_DODEFAULT,EmptyParam,EmptyParam);
  FormPublic.DocumentSetFocus;
except end;
end;

procedure TFormPublic.NPageSetupClick(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.ExecWB(OLECMDID_PAGESETUP, OLECMDEXECOPT_DODEFAULT,EmptyParam,EmptyParam);
  FormPublic.DocumentSetFocus;
except end;
end;

procedure TFormPublic.NPrintClick(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.ExecWB(OLECMDID_PRINT,0);
except end;
end;

procedure TFormPublic.NPrintViewClick(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.ExecWB(OLECMDID_PRINTPREVIEW, OLECMDEXECOPT_DODEFAULT,EmptyParam,EmptyParam);
except end;
end;

procedure TFormPublic.NNewMailClick(Sender: TObject);
var
  LocationName, LocationUrl: string;
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  LocationName:=TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationName;
  LocationURL:=TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationURL;
  ShellExecute(Handle,'open',pchar('MailTo:?Subject='+LocationName+'&Body='+LocationURL),nil,nil,SW_SHOW);
except end;
end;

procedure TFormPublic.NSendPageClick(Sender: TObject);
var
  LocationName, LocationUrl: string;
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  LocationName:=TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationName;
  LocationURL:=TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationURL;
  ShellExecute(Handle,'open',pchar('MailTo:?Subject='+LocationName+'&Body='+LocationURL),nil,nil,SW_SHOW);
except end;
end;

procedure TFormPublic.NSendLinkClick(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  SendMessage(GetIEHandle(TFormWebBrowser(wbList[PageIndex]).WebBrowser,'Shell DocObject View'),WM_COMMAND,283,0);
except end;
end;

procedure TFormPublic.NImportClick(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  SendMessage(GetIEHandle(TFormWebBrowser(wbList[PageIndex]).WebBrowser,'Shell DocObject View'),WM_COMMAND,374,0);
except end;
end;

procedure TFormPublic.NCloseCurrentClick(Sender: TObject);
begin
try
  FormMain.ToolButtonTabClose.OnClick(Sender);
except end;
end;

procedure TFormPublic.NAllCloseClick(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;  
  FormMain.AllClose(Sender); 
  {
  if SetForm.CBAffirmExitCloseAll.Checked then
  begin
    //if MessageDlg('确定要关闭全部页面吗？',mtconfirmation,[mbyes,mbno],0)=mrNo then exit;
    //if (Application.MessageBox('确定要关闭全部页面吗？','确认:',MB_YESNO)=IDYES) then
    if MessageBox(Handle,'确定要关闭全部页面吗？','询问',MB_YESNO+MB_ICONINFORMATION)=ID_YES then
    FormWebbrowser.AllClose
    else FormWebbrowser.DocumentSetFocus;
  end
  else FormWebbrowser.AllClose;
  }
except end;
end;

procedure TFormPublic.NAttributeClick(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.ExecWB(OLECMDID_PROPERTIES,OLECMDEXECOPT_DODEFAULT);
except end;
end;

procedure TFormPublic.NOfflineClick(Sender: TObject);
begin
try
  NOffline.Checked:=not NOffline.Checked;
except end;
end;

procedure TFormPublic.NQuickExitClick(Sender: TObject);
begin
try
  Application.Terminate;
  //if InstallTrayIcon then InstallIcon(false,FormMain.Handle,FormMain.Icon.Handle,TitleStr);
  //Halt;
except end;
end;

procedure TFormPublic.NOpenNewlyOneClick(Sender: TObject);
begin
try
  {
  if (Trim(NewlyUrl)<>'') and (Trim(NewlyUrl)<>'about:blank') then
  begin
    FormMain.CBURL.Text:=NewlyUrl;
    FormMain.BBGO.OnClick(Sender);
  end
  else
  begin //exit;
    if PopupMenuNewly.Items.Count<=0 then exit;
    //PopupMenuNewly.Items[PopupMenuNewly.Items.Count-1].OnClick(Sender);
    PopupMenuNewly.Items[PopupMenuNewly.Items.Count-1].Click;
  end;
  }
  if FormMain.PopupMenuNewly.Items.Count<=0 then exit;
  FormMain.PopupMenuNewly.Items[FormMain.PopupMenuNewly.Items.Count-1].Click;
except end;
end;

procedure TFormPublic.NCutClick(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.ExecWB(OLECMDID_CUT, OLECMDEXECOPT_PROMPTUSER);
except end;
end;

procedure TFormPublic.NCopyClick(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.ExecWB(OLECMDID_COPY, OLECMDEXECOPT_PROMPTUSER);
except end;
end;

procedure TFormPublic.NPasteClick(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.ExecWB(OLECMDID_PASTE,OLECMDEXECOPT_PROMPTUSER);
except end;
end;

procedure TFormPublic.NSelectAllClick(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  FormPublic.DocumentSetFocus;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.ExecWB(OLECMDID_SELECTALL, OLECMDEXECOPT_PROMPTUSER);
except end;
end;

procedure TFormPublic.NFindClick(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.ShowFindDialog;
except end;
end;

procedure TFormPublic.NAddressSetFocusClick(Sender: TObject);
begin
try
  FormPublic.AddressSetFocus;
except end;
end;

procedure TFormPublic.NDocmentSetFocusClick(Sender: TObject);
begin
try
  FormPublic.DocumentSetFocus;
except end;
end;

procedure TFormPublic.NCleanCurrentAdClick(Sender: TObject);
begin
try
  try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  ClearAd(TFormWebBrowser(wbList[PageIndex]).WebBrowser, TFormWebBrowser(wbList[PageIndex]).NoCleanFlash);
  finally
    FormPublic.CloseIEPop;
  end;
except end;
end;

procedure TFormPublic.NEditSourceClick(Sender: TObject);
var
  Doc:IHTMLDocument2;
  //Html:string;
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;

  Doc:=TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document as IHTMLDocument2;
  Doc.designMode:='On';
  Doc.body.setAttribute('contentEditable','true',0);
  Doc.execCommand('Underline',False,0);
  //Html:=Doc.body.InnerHTML;
  //ShowMessage('Innerhtml='+Html);
  //Html:=Doc.body.OuterHTML;
  //ShowMessage('Outerhtml='+Html);
  //SaveHTMLSourceToFile(TempDir+TempFileName,TFrameWebBrowser(Self.FFrameList.Items[CurrentIndex]).WebBrowser);
except end;
end;

procedure TFormPublic.NAddFavoriteClick(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  //if FavDirMe then SetForm.SetFavoriteDir(FavoritFolder,false);
  if FavDirMe then FormPublic.AddFav else
  SendMessage(GetIEHandle(TFormWebBrowser(wbList[PageIndex]).WebBrowser,'Internet Explorer_Server'),WM_COMMAND,2261,0);
  //if FavDirMe then SetForm.SetFavoriteDir(SFavoritFolder,false);
except end;
end;

procedure TFormPublic.NTrimFavoriteClick(Sender: TObject);
var
  proc:procedure(Handle:THandle;Path:PChar);stdcall;
  WHwnd:HWnd;
begin
try
  try
  WHwnd:=LoadLibrary(PChar('shdocvw.dll'));
  if WHwnd<>0 then
  begin
    proc:=GetProcAddress(WHwnd,PChar('DoOrganizeFavDlg'));
    if Assigned(proc) then
      proc(Handle,PChar(FavoritFolder));
  end;
  FreeLibrary(WHwnd);
  finally
  FormPublic.DocumentSetFocus;
  end;
except end;
end;

procedure TFormPublic.NOpenFavoriteDirClick(Sender: TObject);
begin
try
  //ShowMessage(FavoritFolder);
  ShellExecute(0,'open',PChar({'file://' +} FavoritFolder),nil,nil,SW_NORMAL);
except end;
end;

procedure TFormPublic.NSetGroupClick(Sender: TObject);
begin
try
  GroupForm.Show;
  {
  GroupForm:=TGroupForm.Create(Self);
  //FormLoadLastTime.Caption:=TitleStr;
  GroupForm.ShowModal;
  }
except end;
end;

procedure TFormPublic.NFavoritCoteClick(Sender: TObject);
begin
try
  if ShowWebIcon then FormMain.ToolBarTabClose.Hide;
  NFavoritCote.Checked := not NFavoritCote.Checked;
  //FormMain.ToolBarFavorite.Visible := NFavoritCote.Checked;
  FormMain.PaintPanelFavorite.Visible := NFavoritCote.Checked;
  //if FormMain.ToolBarFavorite.Visible then MakeFavoriteBar;
  if FormMain.PaintPanelFavorite.Visible then MakeFavoriteBar;
  FavoritCote := NFavoritCote.Checked;
  if NFavoritCote.Checked then
  WritePrivateProfileString('RunData', 'FavoritCote', '1', PChar(MyDir + ConfigFile))
  else
  WritePrivateProfileString('RunData', 'FavoritCote', '0', PChar(MyDir + ConfigFile));
  NNFavoritCote.Checked := NFavoritCote.Checked;
  if ShowWebIcon then
  begin
    ShowCloseOK := false;
    if ShowCloseHint then
    FormMain.ToolBarTabClose.Show;
  end;
except end;
end;

procedure TFormPublic.NLargestClick(Sender: TObject);
var
  Font:OleVariant;
begin
try
  Font:=4;
  FontZoom:=4;
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.ExecWB(OLECMDID_ZOOM,OLECMDEXECOPT_DONTPROMPTUSER,Font,Font);
except end;
end;

procedure TFormPublic.NLargerClick(Sender: TObject);
var
  Font:OleVariant;
begin
try
  Font:=3;
  FontZoom:=3;
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.ExecWB(OLECMDID_ZOOM,OLECMDEXECOPT_DONTPROMPTUSER,Font,Font);
except end;
end;

procedure TFormPublic.NMiddleClick(Sender: TObject);
var
  Font:OleVariant;
begin
try
  Font:=2;
  FontZoom:=2;
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.ExecWB(OLECMDID_ZOOM,OLECMDEXECOPT_DONTPROMPTUSER,Font,Font);
except end;
end;

procedure TFormPublic.NSmallClick(Sender: TObject);
var
  Font:OleVariant;
begin
try
  Font:=1;
  FontZoom:=1;
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.ExecWB(OLECMDID_ZOOM,OLECMDEXECOPT_DONTPROMPTUSER,Font,Font);
except end;
end;

procedure TFormPublic.NSmallestClick(Sender: TObject);
var
  Font:OleVariant;
begin
try
  Font:=0;
  FontZoom:=0;
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.ExecWB(OLECMDID_ZOOM,OLECMDEXECOPT_DONTPROMPTUSER,Font,Font);
except end;
end;

procedure TFormPublic.N50Click(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom:='50%'; //0.50;
  if (TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag <> LastUnCloseFlag) then TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag := ZoomTag;
except end;
end;

procedure TFormPublic.N75Click(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom:='75%'; //0.75;
  if (TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag <> LastUnCloseFlag) then TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag := ZoomTag;
except end;
end;

procedure TFormPublic.N100Click(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom:='100%'; //1.00;
  if (TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag <> LastUnCloseFlag) then TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag := ZoomTag;
except end;
end;

procedure TFormPublic.N125Click(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom:='125%'; //1.25;
  if (TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag <> LastUnCloseFlag) then TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag := ZoomTag;
except end;
end;

procedure TFormPublic.N150Click(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom:='150%'; //1.50;
  if (TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag <> LastUnCloseFlag) then TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag := ZoomTag;
except end;
end;

procedure TFormPublic.N200Click(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom:='200%'; //2.00;
  if (TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag <> LastUnCloseFlag) then TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag := ZoomTag;
except end;
end;

procedure TFormPublic.NStopClick(Sender: TObject);
begin
try
  FormMain.TBStop.OnClick(Sender);
except end;
end;

procedure TFormPublic.NTOPageHomeClick(Sender: TObject);
begin
try
  FormPublic.DocumentToHome;
except end;
end;

procedure TFormPublic.NTOPageEndClick(Sender: TObject);
begin
try
  FormPublic.DocumentToEnd;
except end;
end;

procedure TFormPublic.NRefreshClick(Sender: TObject);
begin
try
  FormMain.TBRefresh.OnClick(Sender);
except end;
end;

procedure TFormPublic.NAllStopClick(Sender: TObject);
begin
try
  FormPublic.AllStop;
except end;
end;
  
procedure TFormPublic.NAllRefreshClick(Sender: TObject);
begin
try
  FormPublic.AllRefresh;
except end;
end;

procedure TFormPublic.NSourceClick(Sender: TObject);
var
  TempFileName:string;
  SL:TStringList;
begin
try
  if wbList.Count = 0 then exit;
  SL:=TStringList.Create;
  try
    if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
    //if TFormWebBrowser(wbList[PageIndex]).WebUrl=InitPage then exit;
    SL.Add(IHtmlDocument2(TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document).Body.OuterHtml);
    TempFileName:=Copy(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationURL,8,10)+'.txt';
    SL.SaveToFile(TempDir+TempFileName);
    ShellExecute(Handle,'open',PChar(TempDir+TempFileName),nil,nil,SW_SHOW);
  finally
    SL.Clear;
    SL.Free;
  end;
except end;
end;

procedure TFormPublic.NHelpOnlineClick(Sender: TObject);
begin
try
  FormMain.CBURL.Text:=OnlineHelpUrl;
  FormMain.BBGO.OnClick(Sender); 
except end;
end;

procedure TFormPublic.NSubHelpClick(Sender: TObject);
begin
try
  {
  if HelpForm.Visible then
  begin
    SetForegroundWindow(HelpForm.Handle);
    exit;
  end;
  }
  //HelpForm.Show;
  if EnableShowHelp then
  begin
  HelpForm:=THelpForm.Create(Self);
  HelpForm.Caption:=TitleStr+' '+Version;
  HelpForm.ShowModal;
  end
  else
  begin
    NHelpOnline.OnClick(Sender);
  end;
  //ShellExecute(Handle,'open',PChar(MyDir+'Readme.txt'),nil,nil,SW_SHOW);
  //ShellExecute(0,'OPEN',PChar(MyDir+'Readme.txt'),nil,nil,SW_SHOW);
except end;
end;

procedure TFormPublic.NBrowserHomePageClick(Sender: TObject);
begin
try
  FormMain.CBURL.Text:=BrowserHomePage;
  FormMain.BBGO.OnClick(Sender);
except end;
end;

procedure TFormPublic.NBrowserBBSClick(Sender: TObject);
begin
try
  FormMain.CBURL.Text:=BrowserBBS;
  FormMain.BBGO.OnClick(Sender);   
except end;
end;

procedure TFormPublic.NUpdateOnlineClick(Sender: TObject);
//var
  //IniFile:TIniFile;
begin
try
  if not UpdateAtOne then
  begin
  if (not FileExists(MyDir+UpdateFileName)) {or (not FileExists(MyDir+'update.txt'))} then
  begin
    ShowMessage('升级程序不完整，请手动进行升级!');
    FormMain.CBURL.Text:=BrowserHomePage;
    FormMain.BBGO.OnClick(Sender);
    exit;
  end;
  try
  finally
    if (not FileExists({MyDir}UpdateDir+'update.txt')) then
    begin
      DownloadFile(PChar(UpdateVerFileUrl),PChar({MyDir}UpdateDir+'update.txt'));
      WritePrivateProfileString('RunData','NewOK','1',PChar({MyDir}UpdateDir+'update.txt'));
    end                                             
    else
    WritePrivateProfileString('RunData','NewOK','0',PChar({MyDir}UpdateDir+'update.txt'));
    WritePrivateProfileString('RunData','CurrentVer',Version,PChar({MyDir}UpdateDir+'update.txt'));
    WritePrivateProfileString('RunData','AutoUpdate','0',PChar({MyDir}UpdateDir+'update.txt'));
    WritePrivateProfileString('RunData','NeedRun','1',PChar({MyDir}UpdateDir+'update.txt'));
    WritePrivateProfileString('RunData','RunFile',PChar(ExtractFileName(ParamStr(0))),PChar({MyDir}UpdateDir+'update.txt'));
    WinExec(PAnsiChar(MyDir+UpdateFileName),SW_SHOW);
    //IniFile.Free;
  end;
  exit;
  end;
  FormUpdate.Show;
except end;
end;

procedure TFormPublic.NAutoUpdateHintClick(Sender: TObject);
begin
try
  NAutoUpdateHint.Checked:=not NAutoUpdateHint.Checked;
  if NAutoUpdateHint.Checked then
  begin
  WritePrivateProfileString('RunData','AutoUpdateHint','1',PChar(MyDir+ConfigFile));
  AutoUpdateHint := true;
  //TimerUpdate.Enabled:=true;
  ThreadI:=11;
  RunProcess.Create(False);
  end
  else
  WritePrivateProfileString('RunData','AutoUpdateHint','0',PChar(MyDir+ConfigFile));
except end;
end;

procedure TFormPublic.NQuickClearMemoryClick(Sender: TObject);
begin
try
  if Win32Platform=VER_PLATFORM_WIN32_NT then
  begin
    SetProcessWorkingSetSize(GetCurrentProcess,$FFFFFFFF,$FFFFFFFF);
    Application.ProcessMessages;
  end;
except end;
end;

procedure TFormPublic.NSetZoomClick(Sender: TObject);
var
  Str: string;
  I: integer;
begin
try
  Str := InputBox('页面后续缩放 提示：','请输入后续需要缩放的值,目前的值为:' + (Copy(ZoomStr,1,Length(ZoomStr)-1)) + '.如果想停止后续页面的缩放请输入0或者100后确定!','');
  if (Trim(Str) = '') then exit;
  i := StrToInt(str);
  if (Trim(Str) = '0') or (Trim(Str) = '100') then
  begin
    ZoomStr := '100%';
    WritePrivateProfileString('setting','ZoomStr','100%',PChar(MyDir+ConfigFile));
    exit;
  end;
  ZoomStr := Str + '%';
  WritePrivateProfileString('setting','ZoomStr',PChar(ZoomStr),PChar(MyDir+ConfigFile));
except end;
end;

procedure TFormPublic.NAutoHintAndShutdownClick(Sender: TObject);
begin
try
  FormMain.ToolButtonAutoHint.OnClick(Sender);
except end;
end;

procedure TFormPublic.NUnLockWebPageClick(Sender: TObject);
begin
try
  PageUnLock := true;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  WebPageUnLock(TFormWebBrowser(wbList[PageIndex]).WebBrowser);
  FormPublic.DocumentSetFocus;
except end;
end;

procedure TFormPublic.NMyComputerClick(Sender: TObject);
var
  WinDir:string;
begin
try
  WinDir:=GetWinDir;
  if WinDir[Length(WinDir)]<>'\' then WinDir:=WinDir+'\';
  WinExec(PChar(WinDir+'explorer.exe ::{20D04FE0-3AEA-1069-A2D8-08002B30309D}'),SW_SHOW);
  //ShellExecute(Handle,'open',PChar(WinDir+'explorer.exe ::{20D04FE0-3AEA-1069-A2D8-08002B30309D}'),nil,nil,0);
except end;
end;

procedure TFormPublic.NNotepadClick(Sender: TObject);
var
  WinDir,SysDir:string;
begin
try
  if Win32Platform<>VER_PLATFORM_WIN32_NT then
  begin
    WinDir:=GetWinDir;
    if WinDir[Length(WinDir)]<>'\' then WinDir:=WinDir+'\';
    //if FileExists(WinDir+'notepad.exe') then
    WinExec(PChar(WinDir+'notepad.exe'),SW_SHOW);
    exit;
  end;
  SysDir:=GetSysDir;
  if SysDir[Length(SysDir)]<>'\' then SysDir:=SysDir+'\';
  WinExec(PChar(SysDir+'notepad.exe'),SW_SHOW);
  //ShellExecute(Handle,'open',PChar(SysDir+'notepad.exe'),nil,nil,0);
except end;
end;

procedure TFormPublic.NMspaintClick(Sender: TObject);
var
  SysDir:string;
begin
try
  SysDir:=GetSysDir;
  if SysDir[Length(SysDir)]<>'\' then SysDir:=SysDir+'\';
  WinExec(PChar(SysDir+'mspaint.exe'),SW_SHOW);
  //ShellExecute(Handle,'open',PChar(SysDir+'mspaint.exe'),nil,nil,0);
except end;
end;

procedure TFormPublic.NRunControlClick(Sender: TObject);
var
  WinDir,SysDir:string;
begin
try
  if Win32Platform<>VER_PLATFORM_WIN32_NT then
  begin
    WinDir:=GetWinDir;
    if WinDir[Length(WinDir)]<>'\' then WinDir:=WinDir+'\';
    //if FileExists(WinDir+'control.exe') then
    WinExec(PChar(WinDir+'control.exe'),SW_SHOW);
    exit;
  end;
  SysDir:=GetSysDir;
  if SysDir[Length(SysDir)]<>'\' then SysDir:=SysDir+'\';
  WinExec(PChar(SysDir+'control.exe'),SW_SHOW);
except end;
end;

procedure TFormPublic.NAddDeleteControlClick(Sender: TObject);
var
  SysDir:string;
begin
try
  SysDir:=GetSysDir;
  if SysDir[Length(SysDir)]<>'\' then SysDir:=SysDir+'\';
  WinExec(PChar(SysDir+'control.exe appwiz.cpl'),SW_SHOW);
  //ShellExecute(Handle,'open',PChar(SysDir+'control.exe appwiz.cpl'),nil,nil,0);
except end;
end;

procedure TFormPublic.NCommandLineClick(Sender: TObject);
var
  WinDir,SysDir:string;
begin
try
  if Win32Platform<>VER_PLATFORM_WIN32_NT then
  begin
    WinDir:=GetWinDir;
    if WinDir[Length(WinDir)]<>'\' then WinDir:=WinDir+'\';
    //ShowMessage(WinDir+'COMMAND.COM');
    //if FileExists(WinDir+'COMMAND.COM') then
    WinExec(PChar(WinDir+'COMMAND.COM'),SW_SHOW);
    exit;
  end;
  SysDir:=GetSysDir;
  if SysDir[Length(SysDir)]<>'\' then SysDir:=SysDir+'\';
  if FileExists(SysDir+'CMD.exe') then
  WinExec(PChar(SysDir+'CMD.exe'),SW_SHOW)
  else if FileExists(SysDir+'Command.exe') then
  WinExec(PChar(SysDir+'Command.exe'),SW_SHOW);
except end;
end;

procedure TFormPublic.NRegeditClick(Sender: TObject);
var
  WinDir:string;
begin
try    //ShowMessage(WinDir);
  LockReg(False);
  WinDir:=GetWinDir;
  if WinDir[Length(WinDir)]<>'\' then WinDir:=WinDir+'\';
  WinExec(PChar(WinDir+'regedit.exe'),SW_SHOW);
  //ShellExecute(Handle,'open',PChar(WinDir+'regedit.exe'),nil,nil,0);
except end;
end;

procedure TFormPublic.NFollowTOPCloseClick(Sender: TObject);
begin
try
  NFollowTOPClose.Checked:=not NFollowTOPClose.Checked;
  if NFollowTOPClose.Checked then WritePrivateProfileString('RunData','CClose','1',PChar(MyDir+ConfigFile))
  else WritePrivateProfileString('RunData','CClose','0',PChar(MyDir+ConfigFile));
except end;
end;

procedure TFormPublic.NCleanAddressClick(Sender: TObject);
begin
try
  //if MessageDlg('确认要清除地址栏历史记录吗？',mtConfirmation,[mbYes, mbNo],0)=mrYes then
  begin
    //if CBURL.Items.Count>0 then
    FormMain.CBURL.Items.Clear;
    FormMain.CBURL.Text:='';
    FormMain.CBURL.Items.SaveToFile(MyDir+URLFILE);
    //if FileExists(MyDir+URLFILE) then DeleteFile(MyDir+URLFILE);
  end;
except end;
end;

procedure TFormPublic.NClearSearchHistoryClick(Sender: TObject);
begin
try
  //FormMain.ComboBoxSearch.Items.Clear;
  FormMain.ComboBoxSearch.Text := '';
  //FormMain.ImageSearch.RePaint;
except end;
end;

procedure TFormPublic.NCleanHistoryClick(Sender: TObject);
begin
try
  try
  //OldUrl:='';
  ThreadI:=71;
  RunProcess.Create(False);
  //exit;
  //DeleteDirFile((GetSystemFolderDir(CSIDL_HISTORY)));
  //DeleteDir((GetSystemFolderDir(CSIDL_HISTORY)));
  finally
    //DeleteFile(MyDir+NewlyBrowserFile);
    CleanNewly;
    //while PopupMenuNewly.Items.Count>0 do CleanNewly;
  end;
except end;
end;

procedure TFormPublic.NCleanCacheClick(Sender: TObject);
begin
try               //ShowMessage(GetSystemFolderDir(CSIDL_INTERNET_CACHE));
  ThreadI:=72;
  RunProcess.Create(False);
  //exit;
  //DeleteDirFile(GetSystemFolderDir(CSIDL_INTERNET_CACHE));
  //DeleteDir(GetSystemFolderDir(CSIDL_INTERNET_CACHE));
except end;
end;

procedure TFormPublic.NCleanCookiesClick(Sender: TObject);
begin
try
  ThreadI:=73;
  RunProcess.Create(False);
  //exit;
  //DeleteDirFile((GetSystemFolderDir(CSIDL_COOKIES)));
  //DeleteDir((GetSystemFolderDir(CSIDL_COOKIES)));
except end;
end;

procedure TFormPublic.NCleanTempDirClick(Sender: TObject);
begin
try
  ThreadI:=74;
  RunProcess.Create(False);
  //DeleteDirFile(GetTempDir);
  //DeleteDir(GetTempDir);
except end;
end;

procedure TFormPublic.NCleanFavoriteClick(Sender: TObject);
begin
try
  //if MessageDlg('确定要关闭整个TOB吗？',mtconfirmation,[mbyes,mbno],0)=mryes then
  //if (Application.MessageBox('此项操作将清空整个收藏夹的内容且不可再恢复，请慎重进行此项操作。'+#10+#13'确定要清空整个收藏夹吗？','确认:',MB_YESNO)=IDYES) then
  if MessageBox(Handle,'此项操作将清空整个收藏夹的内容且不可再恢复，请慎重进行此项操作。'+#10+#13'确定要清空整个收藏夹吗？','询问',MB_YESNO+MB_ICONINFORMATION)=ID_YES then
  begin
    ThreadI:=70;
    RunProcess.Create(False);
    exit;
    DeleteDirFile((GetSystemFolderDir(CSIDL_FAVORITES)));
    DeleteDir((GetSystemFolderDir(CSIDL_FAVORITES)));
  end;
except end;
end;

procedure TFormPublic.NCleanRecentClick(Sender: TObject);
begin
try
  DeleteDirFile((GetSystemFolderDir(CSIDL_RECENT)));
  //DeleteDir((GetSystemFolderDir(CSIDL_RECENT)));
except end;
end;

procedure TFormPublic.NCleanAllClick(Sender: TObject);
begin
try
  try
  //OldUrl:='';
  FormMain.CBURL.Text:='';
  //CBSearch.Text:='';

  FormMain.CBURL.Items.Clear;
  FormMain.CBURL.Items.SaveToFile(MyDir+URLFILE);

  //FormMain.EditSearch.Text := '';   //okok

  NewlyUrl:='';
  CleanNewly;
  //if FileExists(MyDir+NewlyBrowserFile) then DeleteFile(MyDir+NewlyBrowserFile);
  //CleanNewly;
  //exit;
  {
  NCleanHistory.OnClick(Sender);
  NCleanCache.OnClick(Sender);
  NCleanCookies.OnClick(Sender);
  NCleanRecent.OnClick(Sender);
  }
  finally
  ThreadI := 79;
  RunProcess.Create(False);

  DeleteDirFile((GetSystemFolderDir(CSIDL_RECENT)));
  
  //DeleteDirFile(TempDir);
  //DeleteDir(TempDir);
  //DeleteDirFile(GetTempDir);
  //DeleteDir(GetTempDir);
  end;
except end;
end;

procedure TFormPublic.NRunOneClick(Sender: TObject);
begin
try
  NRunOne.Checked:=not NRunOne.Checked;
  if NRunOne.Checked=true then
  begin
    WritePrivateProfileString('RunData','RunOne','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    WritePrivateProfileString('RunData','RunOne','0',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormPublic.NStopPopupClick(Sender: TObject);
begin
try
  try
  NStopPopup.Checked:=not NStopPopup.Checked;
  if NStopPopup.Checked then
  begin
    StopPopup:=true;
    StopPopupO2 := true;
    //if (not KillPopupMode1) and (not KillPopupMode2) then
    //StopPopupMode1:=true;
    StopPopupMode2:=true;
    WritePrivateProfileString('RunData','StopPopup','1',PChar(MyDir+ConfigFile));
    if wbList.Count <= 0 then exit;
    if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
    ClearAd(TFormWebBrowser(wbList[PageIndex]).WebBrowser, TFormWebBrowser(wbList[PageIndex]).NoCleanFlash);
  end
  else
  begin
    StopPopup:=false;
    StopPopupO2 := false;
    //StopPopupMode1:=false;
    StopPopupMode2:=false;
    WritePrivateProfileString('RunData','StopPopup','0',PChar(MyDir+ConfigFile));
    if wbList.Count <= 0 then exit;
    TFormWebBrowser(wbList[PageIndex]).WebBrowser.Refresh;
  end;
  finally
    //StopPopup2 := StopPopup;
  end;
except end;
end;

procedure TFormPublic.NCheckDefaultBrowserClick(Sender: TObject);
begin
try
  try    //CheckDefaultBrowser_(1);
  //CheckDefaultBrowser_(1);
  //if not ShowOptionOK then exit;
  case ForceDefaultBrowser of
  0,1:
  begin
  if ForceDefaultBrowser = 0 then
  NCheckDefaultBrowser.Checked := not NCheckDefaultBrowser.Checked
  else NCheckDefaultBrowser.Checked := true;
  if NCheckDefaultBrowser.Checked then
  begin
    CheckDefaultBrowser_(1);
    WritePrivateProfileString('RunData','CheckDefaultBrowser','1',PChar(MyDir+ConfigFile));
    //CheckParam;
  end
  else
  begin
    if ForceDefaultBrowser = 0 then
    WritePrivateProfileString('RunData','CheckDefaultBrowser','0',PChar(MyDir+ConfigFile));
  end;
  end;
  2:SetBrowser(1);
  end;
  finally
  //WritePrivateProfileString('RunData','CheckDefaultBrowser','1',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormPublic.NSetBrowserTOPClick(Sender: TObject);
begin
try
  SetBrowser(1);
except end;
end;

procedure TFormPublic.NSetBrowserIEClick(Sender: TObject);
begin
try
  SetBrowser(2);
except end;
end;

procedure TFormPublic.NCurrNoSilentClick(Sender: TObject);
begin
try
  if wbList.Count <= 0 then
  begin
    NCurrNoSilent.Checked := false;
    exit;
  end;
  NCurrNoSilent.Checked := not NCurrNoSilent.Checked;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document <> nil then
  if NCurrNoSilent.Checked then
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.Silent := false
  else
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.Silent := true;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.Refresh;
except end;
end;

{
procedure TFormPublic.Timero2Timer(Sender: TObject);
var
  S:string;
  i:integer;
  NewS:string;
begin
try
  NewS:='';
  //S:=Trim(EStatusBar.Text);
  S:='A-B-C_D:E:F_G';

  for i:=1 to Length(S) do
  begin
    //ms.dwLength:=sizeof(ms);
    //GlobalMemoryStatus(ms);
    case S[i] of
    'A':NewS:=NewS+GetDateTime2(1);
    'B':NewS:=NewS+GetDateTime2(2);
    'C':NewS:=NewS+GetDateTime2(3);
    'D':NewS:=NewS+GetDateTime2(4);
    'E':NewS:=NewS+GetDateTime2(5);
    'F':NewS:=NewS+GetDateTime2(6);

    'H':NewS:=NewS+' '; //NewS:=NewS+Format('%d'+'MB',[ms.dwAvailPhys/1000.00]);

    ':':NewS:=NewS+':';
    '-':NewS:=NewS+'-';
    '_':NewS:=NewS+'_';
    ' ':NewS:=NewS+' ';
    else NewS:=NewS+S[i];;
    end;
  end;
  FormMain.StatusBar.Panels[3].Text:=NewS;
except end;
end;
}

procedure TFormPublic.NPreviousPageClick(Sender: TObject);
begin
try
  if wbList.Count <= 1 then exit;
  if PageIndex = 0 then exit;
  if PageIndex > 0 then
  //FormMain.ToolBarTabParent.Buttons[PageIndex - 1].Click;
  FormPublic.TabClick2(PageIndex - 1);
  FormMain.ToolBarTabParent.RePaint;
  {
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl <> 'about:blank' then
  FormWebBrowser.DocumentSetFocus
  else FormWebBrowser.AddressSetFocus;
  }
except end;
end;

procedure TFormPublic.NNextPageClick(Sender: TObject);
begin
try
  if wbList.Count <= 1 then exit;           
  if PageIndex = wbList.Count - 1 then exit;
  if PageIndex + 1 < wbList.Count then
  //FormMain.ToolBarTabParent.Buttons[PageIndex + 1].Click;
  FormPublic.TabClick2(PageIndex + 1);
  FormMain.ToolBarTabParent.RePaint;
  {
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl <> 'about:blank' then
  FormWebBrowser.DocumentSetFocus
  else FormWebBrowser.AddressSetFocus;
  }
except end;
end;

procedure TFormPublic.NSaveToGroupClick(Sender: TObject);
var
  i:Word; //integer;
  STitle,SUrl:string;
  GroupName:string;
begin
try
  try
  if wbList.Count <= 0 then exit;
  if not DirectoryExists(GroupDir) then MkDir(GroupDir);
  GroupForm.ListBox.Items.Clear;
  GroupName:=InputBox('提示：','请输入群组名称:',''{IntToStr(Random(100000))});
  if Trim(GroupName)='' then exit;
  if FileExists(GroupDir+Trim(GroupName)+ExtendName) then
  begin
    //ShowMessage('组名已经存在，保存失败!');
    //if MessageDlg('确定要关闭整个TOB吗？',mtconfirmation,[mbyes,mbno],0)=mryes then
    //if (Application.MessageBox('组名已经存在,确定要添加到已存在的群组中吗？','确认:',MB_YESNO)=IDNO) then
    if MessageBox(Handle,'组名已经存在,确定要添加到已存在的群组中吗？','询问',MB_YESNO+MB_ICONINFORMATION)=ID_NO then
    exit;
    GroupForm.ListBox.Items.LoadFromFile(GroupDir+Trim(GroupName)+ExtendName);
    CurrentGroupName:=Trim(GroupName);
  end
  else
  begin
    GroupForm.CLBox1.Items.Add(Trim(GroupName));
    GroupForm.ENewGroup.Text:='';
    GroupForm.CLBox1.ItemIndex:=GroupForm.CLBox1.Count-1;
    CurrentGroupName:=GroupForm.CLBox1.Items.Strings[GroupForm.CLBox1.itemIndex];
  end;
  for i:=0 to wbList.Count - 1 do
  begin
    begin
      SUrl:=Trim(TFormWebBrowser(wbList[i]).WebBrowser.LocationURL);
      if ((Trim(SUrl)<>'') and (Trim(SUrl)<>'about:blank')) then
      begin
        STitle:=Trim(TFormWebBrowser(wbList[i]).WebTitle);
        if (STitle='') or (STitle='about:blank') then
        STitle:=Trim(TFormWebBrowser(wbList[i]).WebBrowser.LocationName);
        GroupForm.ListBox.Items.Add(STitle+'#'+Trim(SUrl));
      end
    end;
  end;
  GroupForm.SBOK.OnClick(Sender);
  //GroupForm.CleanAll;
  //GroupForm.ReLoadAll;   //kkk
  finally
  FormPublic.DocumentSetFocus;
  end;
except end;
end;

//===
procedure TFormPublic.NTempClick(Sender: TObject);
var
  Pt: TPoint;
begin
try
  Pt := FormMain.{ToolBarMenu}PaintPanelButtonAddress.ClienttoScreen(Point(0, FormMain.{ToolBarMenu.}Height));
  Pt.X := 0;    //okok
  PopupMenuMenuFavorit.Popup(Pt.X, Pt.Y);
except end;
end;

procedure TFormPublic.ToolButtonTempClick(Sender: TObject);
begin
try   
  with Sender as TToolButton do
  begin
    Grouped := not Grouped;    //exit;
    if Grouped then ImageIndex := ImageIndex + 1 else
      ImageIndex := ImageIndex -1;
  end;
except end;
end;

procedure TFormPublic.NInternetOptionClick(Sender: TObject);
begin
try
  //WinExec(PChar(WinDir+'inetcpl.cpl'),SW_SHOW);
  //WinExec(PChar(SysDir+'inetcpl.cpl'),SW_SHOW);
  ShellExecute(Handle,'','rundll32.exe','shell32.dll,Control_RunDLL inetcpl.cpl,,0','0',1);  //'0'->'c:\'
except end;
end;

procedure TFormPublic.NTOPOptionClick(Sender: TObject);
begin
try
  SetForm.Show;
  SetForm.BWhiteListLoad.OnClick(Sender);
except end;
end;

procedure TFormPublic.NSetProxyClick(Sender: TObject);
begin
try
  //SetForm.PageControl1.ActivePageIndex:=4;
  SetForm.PageControl1.ActivePage := SetForm.TabSheetProxy;
  SetForm.Show;
  SetForm.BLoadProxyList.OnClick(Sender);
except end;
end;

procedure TFormPublic.NUseIEProxyClick(Sender: TObject);
begin
try
  try
  NUseIEProxy.Checked := not NUseIEProxy.Checked;
  if NUseIEProxy.Checked then
  begin
    NSetProxy.Checked := false;   
    NNoUseProxy.Checked := false;
    WritePrivateProfileString('RunData','UseProxy','0',PChar(MyDir+ConfigFile));
    WritePrivateProfileString('RunData','UseIEProxy','1',PChar(MyDir+ConfigFile));
  end else
  begin
    NSetProxy.Checked := false;
    NNoUseProxy.Checked := true;
    WritePrivateProfileString('RunData','UseProxy','0',PChar(MyDir+ConfigFile));
    WritePrivateProfileString('RunData','UseIEProxy','0',PChar(MyDir+ConfigFile));
  end;
  finally
    if NUseIEProxy.Checked then CheckProxy else NotProxy;
    //MessageBox(FormMain.Handle, '此设置在重新启动浏览器后生效,请重新启动浏览器!', '提示:', 0);
  end;
except end;
end;

procedure TFormPublic.NNoUseProxyClick(Sender: TObject);
begin
try
  try
  NNoUseProxy.Checked:=true;
  NUseIEProxy.Checked:=false;
  NSetProxy.Checked := false;    
  WritePrivateProfileString('RunData','UseProxy','0',PChar(MyDir+ConfigFile));
  WritePrivateProfileString('RunData','UseIEProxy','0',PChar(MyDir+ConfigFile));
  finally
    //SetForm.CBUseProxy.Checked:=false;
    //SetForm.CBNoUseProxy.Checked:=true;
  NotProxy;
  end;
except end;
end;

procedure TFormPublic.NWeatherClick(Sender: TObject);
var
  str:string;
begin
try
  case WeatherSource of
  1:
  begin
    //http://weather.cncn.com/weather.htm
    FormMain.CBURL.Text := 'http://weather.cncn.com/weather.htm';
    FormMain.BBGO.OnClick(Sender);
  end;
  2:
  begin
  //MoreUrlOpen := false;
  if Trim(SetForm.CBWeather.Text)='' then
  begin 
    str:=InputBox('提示：','这可能是您第一次使用天气预报功能，请先输入您所在城市的地名,如"北京":','');
    if Trim(str)='' then exit;
    SetForm.CBWeather.Text:=str;
    SetForm.SBWeatherOK.OnClick(Sender);
  end
  else
  SetForm.SBWeatherOK.OnClick(Sender);
  end;
  end;
except end;
end;

procedure TFormPublic.NNShowMenuClick(Sender: TObject);
begin
try
  //FormMain.ToolBarMenu.Menu := nil; //FormPublic.MainMenu1;
  //exit;
  //Show_Menu;
  {
  //NNShowMenu.Checked := not NNShowMenu.Checked;
  //NShowMenu.Checked := NNShowMenu.Checked;
  NShowMenu.Checked := not NShowMenu.Checked;
  NNShowMenu.Checked := NShowMenu.Checked;
  FormMain.ToolBarMenu.Visible := NShowMenu.Checked;
  }
  if NShowMenu.Checked then
  begin
    WritePrivateProfileString('RunData','ShowMenu','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    WritePrivateProfileString('RunData','ShowMenu','0',PChar(MyDir+ConfigFile));
  end;

  if NShowMenu.Checked then
  begin
    ShowMenu := true;
    FormMain.ToolBarMenu2.Menu := FormPublic.MainMenu1;
  end
  else
  begin
    ShowMenu := false;
    FormMain.ToolBarMenu2.Menu := nil;
  end;
  FormMain.NShowMenu2.Checked := NShowMenu.Checked;
  //FormPaint(Sender);
  //if ShowRunOK then
  if not AutoMenuShow then
  begin
    AutoMenuShow := true;
    FormMain.OnResize(Sender);
  end;
  //if NNShowMenu.Checked
except end;
end;

procedure TFormPublic.NCleanNewlyClick(Sender: TObject);
begin
try
  CleanNewly;
except end;
end;

procedure TFormPublic.NGroupClick(Sender: TObject);
begin
try
  if GroupChange then
  begin                          
    GroupForm.CleanAll;
    GroupForm.ReLoadAll;
    GroupChange := false;
  end;                                  
except end;
end;                                           

procedure TFormPublic.NSaveFormClick(Sender: TObject);
begin
try
  SaveForm;
except end;
end;

procedure TFormPublic.NInputTableClick(Sender: TObject);
{
var
  o: Olevariant;
  all: IHTMLElementCollection;
  item: IHTMLElement;
  }
  {
  doc:IHTMLDocument2;
  item2:olevariant;
  }
begin
try
  if (Trim(UserName) = '') then
  begin
    SetForm.PageControl1.ActivePage := SetForm.TabSheetMousssTable;
    SetForm.Show;
    SetForm.ENickName.SetFocus;
    exit;
  end;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('nickname', NickName);
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('uname', NickName);

  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('username', UserName);
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('user', UserName);

  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('password', PassWord);
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('password2', PassWord);
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('passwd', PassWord);
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('pwdagain', PassWord);
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('pwd', PassWord);
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('againpwd', PassWord);
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('passwdAgain', PassWord);

  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('pwdA', Answer);

  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('email', Email);

  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('usermail', Email);

  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('realname', RealName);

  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('name', RealName);
  {
  try
  finally
    LoadForm; 
  end;
  }
except end;
end;

procedure TFormPublic.NTabAutoWidthClick(Sender: TObject);
begin
try
  NTabAutoWidth.Checked := not NTabAutoWidth.Checked;
  if NTabAutoWidth.Checked then
  begin
    TabAutoWidth := true;
    FormMain.ToolBarTabParent.Indent :=  0;
    FormPublic.TabAutoWidthControl;
    FormMain.ToolBarTabParent.Repaint;
    WritePrivateProfileString('RunData','TabAutoWidth','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    TabAutoWidth := false;
    TabWidth := HopeTabWidth;
    FormMain.ToolBarTabParent.ButtonWidth := HopeTabWidth;
    WritePrivateProfileString('RunData','TabAutoWidth','0',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormPublic.TimerMemoryThriftTimer(Sender: TObject);
begin
try
  if Win32_NT then
  SetProcessWorkingSetSize(GetCurrentProcess,$FFFFFFFF,$FFFFFFFF);
except end;
end;

procedure TFormPublic.NCallBackMemory_Click(Sender: TObject);
begin
try
  {
  NCallBackMemory.Checked := not NCallBackMemory.Checked;
  CallBackMemory := NCallBackMemory.Checked;
  if //NCallBackMemory.Checked//CallBackMemory then
  WritePrivateProfileString('setting', 'CallBackMemory', '1', PChar(MyDir+ConfigFile))
  else
  WritePrivateProfileString('setting', 'CallBackMemory', '0', PChar(MyDir+ConfigFile));
  }
except end;
end;

{
procedure TFormPublic.NAddNewDrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
//var
  //R: TRect;
begin
try
  ///
  ACanvas.Brush.Color := clred;
  ACanvas.FillRect(ARect);
  //ACanvas.TextOut(ARect.Left, ARect.Top, (Sender as TMenuItem).Caption);
  R := ARect;
  DrawText(ACanvas.Handle, PChar((Sender as TMenuItem).Caption), -1, R, DT_LEFT or DT_SINGLELINE or DT_VCENTER);
  ///
  if not MainMenuDraw then exit;
  if Selected then
   begin     ACanvas.Pen.Color := clBackground;     ACanvas.Brush.Color := clSkyblue;     ACanvas.Rectangle(ARect);   end else   begin     ACanvas.Brush.Color := clCream;     ACanvas.FillRect(ARect);   end;   R := ARect;   Inc(R.Left, 22);   DrawText(ACanvas.Handle, PChar((Sender as TMenuItem).Caption), -1, R, DT_LEFT or DT_SINGLELINE or DT_VCENTER);
except end;
end;
}

//{
//调整主菜单项尺寸
procedure TFormPublic.MeasureMainItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
begin
try
  Width := Width + 6;
  Height := Height + 2;
except end;
end;

//绘制主菜单内容
procedure TFormPublic.DrawMainItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
const
  {
  MainMenuBackColor      : TColor = $FFFFFF; //$FDFEFF;  //$EDEEEF; //$FDFDFD;  //$DEEDEF;
  MainMenuBorderColor    : TColor = $FFFFFF;  //$EDEEEF; //$FDFDFD;  //$DEEDEF;
  MainMenuSelectedBackColor  : TColor = $FFFFFF;  //$EDEEEF; //$FDFDFD;  //$DFA988;  //选中的啊
  MainMenuSelectedBorderColor: TColor = $C08000;
  MainMenuHotLightBackColor  : TColor = $FFFFFF;  //$EDEEEF; //$FDFDFD;  //$DEEDEF;
  MainMenuHotLightBorderColor: TColor = $800080;
  MainMenuGrayedBackColor  : TColor = $FFFFFF;  //$EDEEEF; //$FDFDFD;  //$DEEDEF;  //-
  }
  SubMenuBackColor      : TColor = $FFFFFF; //$FDFEFF; //$F7F8F9;
  SubMenuBorderColor    : TColor = $EEEEE2;
  SubMenuSelectedBackColor  : TColor = $EED2C1;   //$FFFFFF;
  SubMenuSelectedBorderColor: TColor = $C08000;
  SubMenuLineColor      : TColor = $C8D0D4;
  //SubMenuHotLightBorderColor: TColor = $C08000;
  SubMenuGrayedBackColor  : TColor = $F7F8F9;  //$DEEDEF;

var
  BrushColor, PenColor: TColor;
  TextRect: TRECT;

  str: String;
  ImageList: TCustomImageList;
begin
try
  {
  if odGrayed in State then
  begin
    BrushColor := MainMenuGrayedBackColor;
    PenColor := MainMenuGrayedBackColor;
  end
  else
    if odHotLight in State then
    begin   //鼠标划过
      BrushColor := MainMenuHotLightBackColor;
      PenColor := MainMenuHotLightBorderColor;
    end
    else
    if odSelected in State then
    begin
      BrushColor := MainMenuSelectedBackColor;
      PenColor := MainMenuSelectedBorderColor;
    end
    else
    begin
      BrushColor := MainMenuBackColor;
      PenColor := MainMenuBackColor;
      if TMenuItem(Sender).Caption = '帮助(&H)' then ARect.Right := ARect.Right + 1600;
    end;
  ACanvas.Brush.Color := BrushColor;
  ACanvas.Pen.Color := PenColor;
  //ACanvas.FillRect(ARect);
  ACAnvas.Rectangle(ARect);
  ACanvas.Brush.Style := bsClear;
  //绘出文字
  if odGrayed in State then
    ACanvas.Font.Color := clBtnShadow
  else
    ACanvas.Font.Color := clBlack;
  SetRect(TextRect, ARect.left+10, ARect.top+3, ARect.right, ARect.bottom);
  DrawText(ACanvas.Handle, PChar(TMenuItem(Sender).Caption), Length(TMenuItem(Sender).Caption),
       TextRect, DT_LEFT);
  }
  if (odGrayed in State) and not(TMenuItem(Sender).IsLine) then
  begin
    BrushColor := SubMenuGrayedBackColor;
      {
          ////if odSelected in State then
      ////PenColor := SubMenuSelectedBorderColor
    ////else////
      }
      PenColor := SubMenuGrayedBackColor;
  end
  else
    if odSelected in State then
    begin
      BrushColor := SubMenuSelectedBackColor;
      PenColor := SubMenuSelectedBorderColor;
    end
    else
    begin
      BrushColor := SubMenuBackColor;
      PenColor := SubMenuBackColor;
    end;
  ACanvas.Brush.Color := BrushColor;
  ACanvas.Pen.Color := PenColor;
  ACAnvas.Rectangle(ARect);
  if not(odSelected in State) or (odGrayed in State) then
  begin
    ACanvas.Brush.Color := SubMenuBorderColor;
    ACanvas.FillRect(Rect(ARect.Left, ARect.Top, ARect.Left+20, ARect.Bottom));
  end;
  //绘文字和快捷键
  if TMenuItem(Sender).IsLine then
  begin
    ACanvas.Brush.Color := SubMenuLineColor;
    ACanvas.Pen.Color := SubMenuLineColor;
    ACanvas.FillRect(Rect(ARect.Left+23, ARect.Top+(ARect.Bottom-ARect.Top) div 2-1,
             ARect.Right-2, ARect.Top+(ARect.Bottom-ARect.Top) div 2));
  end
  else
  begin
    ACanvas.Brush.Style := bsClear;
    if odGrayed in State then
      ACanvas.Font.Color := clBtnShadow
    else
      ACanvas.Font.Color := clBlack;
    str := TMenuItem(Sender).Caption;
    SetRect(TextRect, ARect.Left+24, ARect.Top+3, ARect.Right, ARect.Bottom);
    DrawText(ACanvas.Handle, PChar(str), Length(str), TextRect, DT_LEFT);
    str := ShortCutToText(TMenuItem(Sender).ShortCut);
    SetRect(TextRect, ARect.Left+24, ARect.Top+3, ARect.Right-10, ARect.Bottom);
    DrawText(ACanvas.Handle, PChar(str), Length(str), TextRect, DT_RIGHT);
    //
    if TMenuItem(Sender).Checked then
    begin
      ACanvas.Font.Charset := DEFAULT_CHARSET;
      ACanvas.Font.Name := 'Webdings';
      if TMenuItem(Sender).RadioItem then
        ACanvas.TextOut(ARect.Left+4, ARect.Top, '=')
      else
      begin
        ACanvas.Font.Height := -16;
        ACanvas.TextOut(ARect.Left+2, ARect.Top, 'a');
      end;
    end;
  end;
  //{
  //绘制图片
  ImageList := TMenuItem(Sender).GetImageList;
  ImageList := FormPublic.ImageListOther;
  if ImageList<>nil then
    if (odSelected in State) and not(odGrayed in State) then
      ImageList.Draw(ACanvas, ARect.left+2, ARect.Top+2, TMenuItem(Sender).ImageIndex)
    else
      ImageList.Draw(ACanvas, ARect.left+3, ARect.Top+3,
               TMenuItem(Sender).ImageIndex, TMenuItem(Sender).Enabled);
  //}
except end;
end;

procedure TFormPublic.NGetScreenClick(Sender: TObject);
begin
try
  CatchScreenShowForm.Hide;
  CatchScreenShowForm.ChildTimer.Enabled := True;
  {
  GetScreen := not GetScreen;
  if GetScreen then
  begin
    //FormMain.Hide;
    CatchScreenShowForm.Hide;
    CatchScreenShowForm.ChildTimer.Enabled := True;
  end
  else
  begin      
    //CatchScreenShowForm.ChildTimer.Enabled := false;
  end;
  }
except end;
end;

procedure TFormPublic.NWebAutoRefreshClick(Sender: TObject);
begin
try
  NWebAutoRefresh.Checked := not NWebAutoRefresh.Checked;
  if NWebAutoRefresh.Checked then
  begin
    NWebAutoRefresh.Checked := false;
    FormMain.ActionTimerWebAutoRefreshExecute(Sender);
  end
  else
  begin
    if TFormWebBrowser(wbList[PageIndex]).TimerWebAutoRefresh <> nil then
    begin
    TFormWebBrowser(wbList[PageIndex]).TimerWebAutoRefresh.Enabled := false;
    TFormWebBrowser(wbList[PageIndex]).TimerWebAutoRefresh.Interval := 0;
    end;
  end;
except end;
end;

procedure TFormPublic.NPlayMusicClick(Sender: TObject);
begin
try
  try
    if not NSideCote.Checked then NSideCote.Click
    else
    begin
      FormMain.PanelLeft.Align:=alLeft;
      FormMain.PanelLeft.Top:=FormMain.PanelWBMain.Top + 1;
      FormMain.PanelLeft.Visible:=true;
      //if not SideStatShape then SBSideStatShape.Click;
      {
      if FormMain.SBSideStatShape.Hint='锁定' then FormMain.SBSideStatShape.Click;
      FormMain.TimerSide.Enabled:=true;
      }  //okok
    end;

  //FormMain.LabelLeftTitle.Caption:='歌曲播放';
  //FormMain.PageControl1.ActivePageIndex:=1;
  FormMain.ToolButtonMusicPlay.OnClick(Sender);
  finally
    if (FormMain.MediaPlayer.Mode<>mpPlaying) then FormMain.ListBoxMusicList.OnDblClick(Sender);
  end;
except end;
end;

procedure TFormPublic.NSideCoteClick(Sender: TObject);
begin
try
  FormMain.ToolButtonFavorites.Click;
except end;
end;

procedure TFormPublic.NNFavoritCoteClick(Sender: TObject);
begin
try
  NFavoritCote.OnClick(Sender);
except end;
end;

procedure TFormPublic.NMTVClick(Sender: TObject);
begin
try
  try
    //if not firstrun then exit;
    if not NSideCote.Checked then NSideCote.Click
    else
    begin
      FormMain.PanelLeft.Align:=alLeft;
      FormMain.PanelLeft.Top:=FormMain.PanelWBMain.Top + 1;
      FormMain.PanelLeft.Visible:=true;
      //if not SideStatShape then SBSideStatShape.Click;
      {
      if FormMain.SBSideStatShape.Hint='锁定' then FormMain.SBSideStatShape.Click;
      FormMain.TimerSide.Enabled:=true;
      }  //okok
    end;

  //FormMain.LabelLeftTitle.Caption:='歌曲播放';
  //FormMain.PageControl1.ActivePageIndex:=1;
  FormMain.ToolButtonMusicPlay.OnClick(Sender);
  finally
    //if (FormMain.MediaPlayer.Mode<>mpPlaying) then FormMain.ListBoxMusicList.OnDblClick(Sender);
    FormMain.TBOpenUrl.Click;
  end;
except end;
end;

procedure TFormPublic.NNewlyCloseListClick(Sender: TObject);
var
  P: TPoint;
begin
try
  GetCursorPos(P);
  FormMain.PopupMenuNewly.Popup(P.X,P.Y);
except end;
end;

procedure TFormPublic.NNShowButtonClick(Sender: TObject);
begin
try
  Show_Button;
  //FormMain.ToolBarButton.Visible := NNShowButton.Checked;
except end;
end;

procedure TFormPublic.NShowButtonClick(Sender: TObject);
begin
try
  Show_Button;
except end;
end;

procedure TFormPublic.NAddNewHomePageClick(Sender: TObject);
begin
try
  FormMain.TBGoHome.Click;
except end;
end;

procedure TFormPublic.NNStatusBarVClick(Sender: TObject);
begin
try
  FormMain.ToolBarStatusBar.Visible := not FormMain.ToolBarStatusBar.Visible;
  if FormMain.ToolBarStatusBar.Visible then
  begin
    NStatusBarV.Checked := true;
    NNStatusBarV.Checked := true;
    //FormMain.StatusBar.Width := FormMain.ToolBarStatusBar.Width - 125;
    {
    if FormMain.ToolButtonAutoHint.Visible then
    FormMain.StatusBar.Width := FormMain.ToolBarStatusBar.Width - FormMain.ToolButtonFlash.Width - FormMain.TBAllMode.Width - FormMain.ToolButton100.Width - FormMain.ToolButtonAutoHint.Width - 18
    else
    FormMain.StatusBar.Width := FormMain.ToolBarStatusBar.Width - FormMain.ToolButtonFlash.Width - FormMain.TBAllMode.Width - FormMain.TBAllMode.Width - FormMain.ToolButton100.Width - 18;
    }
    WritePrivateProfileString('RunData','StatusBarV','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    NStatusBarV.Checked := false;
    NNStatusBarV.Checked := false;
    WritePrivateProfileString('RunData','StatusBarV','0',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormPublic.NStatusBarVClick(Sender: TObject);
begin
try
  NNStatusBarV.OnClick(Sender);
except end;
end;

procedure TFormPublic.NTabStyle0Click(Sender: TObject);
begin
try
  try
  TabStyle := 0;
  FormMain.ImageTabYes.Picture := FormMain.ImageTabYes1.Picture;
  FormMain.ImageTabNo.Picture := FormMain.ImageTabNo1.Picture;
  //FormMain.Repaint;
  FormMain.ToolBarTabParent.Repaint;
  FormMain.ToolBarTabClose.Repaint;
  finally
  WritePrivateProfileString('RunData','TabStyle','0',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormPublic.NTabStyle1Click(Sender: TObject);
begin
try
  try
  TabStyle := 1;
  FormMain.ImageTabYes.Picture := FormMain.ImageTabYes0.Picture;
  FormMain.ImageTabNo.Picture := FormMain.ImageTabNo0.Picture;
  //FormMain.Repaint;
  FormMain.ToolBarTabParent.Repaint;
  FormMain.ToolBarTabClose.Repaint;
  finally
  WritePrivateProfileString('RunData','TabStyle','1',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormPublic.NFaceStyle2Click(Sender: TObject);
begin
try
  try
  FaceStyle := 2;
  if TBTabNewShow then FormMain.ToolBarTabNew.Visible := false;
  FormMain.Imagebg.Picture.Bitmap := FormMain.{SBBGHei2.Glyph}Imagebg1.Picture.Bitmap; //FormMain.BPF1.Glyph;
  //FormMain.CoolBar1.Bitmap := FormMain.Imagebg.Picture.Bitmap;
  {
  if NTabStyle0.Checked then
  begin
    NTabStyle0.Click;
    NTabStyle0.Checked := true;
  end
  else if NTabStyle1.Checked then
  begin
    NTabStyle1.Click;
    NTabStyle1.Checked := true;
  end;
  }
  NTabStyle1.OnClick(Sender);
  NTabStyle1.Checked := true;
  ShowCloseOk := false;
  FormMain.ToolBarMenu.RePaint;
  FormMain.ToolBarTabParent.RePaint;
  FormMain.ToolBarButton.RePaint;
  FormMain.ToolBarTabControl.RePaint;
  FormMain.PaintPanelButtonAddress.RePaint;
  FormMain.ToolBarTabNew.RePaint;
  FormMain.ToolBarAddress.RePaint;
  FormMain.ToolBarBGO.RePaint;
  FormMain.ToolBarSearchEdit.RePaint;
  FormMain.ToolBarSearchButton.RePaint;
  FormMain.ToolBarFavorite.RePaint;
  finally
  WritePrivateProfileString('RunData','FaceStyle','2',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormPublic.NFaceStyle0Click(Sender: TObject);
begin
try
  try
  FaceStyle := 0;
  if TBTabNewShow then FormMain.ToolBarTabNew.Visible := true;
  FormMain.Imagebg.Picture := FormMain.Imagebg0.Picture;
  //FormMain.CoolBar1.Bitmap := FormMain.Imagebg.Picture.Bitmap;

  if NTabStyle0.Checked then
  begin
    NTabStyle0.Click;
    NTabStyle0.Checked := true;
  end
  else if NTabStyle1.Checked then
  begin
    NTabStyle1.Click;
    NTabStyle1.Checked := true;
  end;
  ShowCloseOk := false;
  FormMain.ToolBarMenu.RePaint;
  FormMain.ToolBarTabParent.RePaint;
  FormMain.ToolBarButton.RePaint;
  FormMain.ToolBarTabControl.RePaint;
  FormMain.PaintPanelButtonAddress.RePaint;
  FormMain.ToolBarTabNew.RePaint;
  FormMain.ToolBarAddress.RePaint;
  FormMain.ToolBarBGO.RePaint;
  FormMain.ToolBarSearchEdit.RePaint;
  FormMain.ToolBarSearchButton.RePaint;
  FormMain.ToolBarFavorite.RePaint;
  finally
  WritePrivateProfileString('RunData','FaceStyle','0',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormPublic.NFaceStyle1Click(Sender: TObject);
begin
try
  try
  FaceStyle := 1;
  if TBTabNewShow then FormMain.ToolBarTabNew.Visible := false;
  FormMain.Imagebg.Picture.Bitmap := FormMain.SBBGHei1.Glyph;
  //FormMain.Imagebg2.Picture.Bitmap := FormMain.{SBBGHei2.Glyph}Imagebg1.Picture.Bitmap;
  //FormMain.CoolBar1.Bitmap := FormMain.Imagebg.Picture.Bitmap;

  if NTabStyle0.Checked then
  begin
    NTabStyle0.Click;
    NTabStyle0.Checked := true;
  end
  else if NTabStyle1.Checked then
  begin
    NTabStyle1.Click;
    NTabStyle1.Checked := true;
  end;
  ShowCloseOk := false;
  FormMain.ToolBarMenu.RePaint;
  FormMain.ToolBarTabParent.RePaint;
  FormMain.ToolBarButton.RePaint;
  FormMain.ToolBarTabControl.RePaint;
  FormMain.PaintPanelButtonAddress.RePaint;
  FormMain.ToolBarTabNew.RePaint;
  FormMain.ToolBarAddress.RePaint;
  FormMain.ToolBarBGO.RePaint;
  FormMain.ToolBarSearchEdit.RePaint;
  FormMain.ToolBarSearchButton.RePaint;
  FormMain.ToolBarFavorite.RePaint;
  finally
  WritePrivateProfileString('RunData','FaceStyle','1',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormPublic.NShowWebIconYClick(Sender: TObject);
begin
try
  WritePrivateProfileString('setting', 'ShowWebIcon', '1', PChar(MyDir + ConfigFile));
  NShowWebIconN.Checked := false;
  //ShowMessage('本设置在重新启动浏览器后生效!');
except end;
end;

procedure TFormPublic.NShowWebIconNClick(Sender: TObject);
begin
try
  WritePrivateProfileString('setting', 'ShowWebIcon', '0', PChar(MyDir + ConfigFile));
  NShowWebIconY.Checked := false;
  //ShowMessage('本设置在重新启动浏览器后生效!');
except end;
end;

procedure TFormPublic.NShowTabCloseYClick(Sender: TObject);
begin
try
  ShowCloseHint := true;     
  WritePrivateProfileString('setting', 'ShowCloseHint', '1', PChar(MyDir + ConfigFile));
  NShowTabCloseN.Checked := false;
  ShowCloseOK := false;
  FormMain.ToolBarTabParent.Repaint;
  //ShowMessage('本设置在重新启动浏览器后生效!');
except end;
end;

procedure TFormPublic.NShowTabCloseNClick(Sender: TObject);
begin
try
  ShowCloseHint := false;
  FormMain.ToolBarTabClose.Visible := false;
  WritePrivateProfileString('setting', 'ShowCloseHint', '0', PChar(MyDir + ConfigFile));
  NShowTabCloseY.Checked := false;
  ShowCloseOK := false;
  //ShowMessage('本设置在重新启动浏览器后生效!');
except end;
end;

procedure TFormPublic.NTabLockClick(Sender: TObject);
begin
try
  TFormWebBrowser(wbList[PageIndex]).TabLock := NTabLock.Checked;
  {
  if NTabLock.Checked then
  begin
    NTabLock.Caption := '解锁标签(&U)';
    NTabLock.ShortCut := TextToShortCut('Ctrl+U');
  end
  else
  begin
    NTabLock.Caption := '锁定标签(&L)';
    NTabLock.ShortCut := TextToShortCut('Ctrl+L');
  end;
  }
except end;
end;

procedure TFormPublic.NSearchShowClick(Sender: TObject);
begin
try
  SearchShow := NSearchShow.Checked;
  //FormMain.PaintPanelSearch.Visible := SearchShow;
  if not SearchShow then
  begin
    FormMain.ToolBarSearchEdit.Hide;
    FormMain.ComboBoxSearch.Hide;
    FormMain.ToolBarSearchButton.Hide;
  end
  else
  begin
    FormMain.ToolBarSearchEdit.Left := FormMain.ToolBarBGO.Left + FormMain.ToolBarBGO.Width;
    FormMain.ToolBarSearchButton.left := FormMain.ToolBarSearchEdit.Left + FormMain.ToolBarSearchEdit.Width;
    FormMain.ToolBarSearchEdit.Show;
    FormMain.ComboBoxSearch.Show;
    FormMain.ToolBarSearchButton.Show;
  end;
  FormMain.FormResize(Sender);
  if SearchShow then
  WritePrivateProfileString('setting','SearchShow','1',PChar(MyDir+ConfigFile))
  else
  WritePrivateProfileString('setting','SearchShow','0',PChar(MyDir+ConfigFile));
except end;
end;

procedure TFormPublic.NNoImageClick(Sender: TObject);
//var
  //DownloadCO: TDownloadControlOptions;
begin
try
  NoImage := NNoImage.Checked;
  try
  //DownloadCO := TFormWebBrowser(wbList[PageIndex]).WebBrowser.DownloadOptions;
  {
  //定义下载内容
  if not NoImage then
  Include(DownloadCO, DLCTL_DLIMAGES);
  if not NoVideo then
  Include(DownloadCO, DLCTL_VIDEOS);
  if not NoBgsound then
  Include(DownloadCO, DLCTL_BGSOUNDS);
  if NoJava then
  Include(DownloadCO, DLCTL_NO_JAVA);
  if NoScript then
  Include(DownloadCO, DLCTL_NO_SCRIPTS);
  if NoActivex then
  begin
    Include(DownloadCO, DLCTL_NO_DLACTIVEXCTLS);
    Include(DownloadCO, DLCTL_NO_RUNACTIVEXCTLS);
  end;
  //DLCTL_OFFLINE and DLCTL_OFFLINEIFNOTCONNECTED  - 脱机
  }
  {
  if not NoImage then
  Include(DownloadCO, DLCTL_DLIMAGES) //这是包含 DLCTL_NO_SCRIPTS
  else
  Exclude(DownloadCO, DLCTL_DLIMAGES); //这是去除 DLCTL_NO_SCRIPTS

  TFormWebBrowser(wbList[PageIndex]).WebBrowser.DownloadOptions:=DownloadCO;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.Refresh;
  }
  with TFormWebBrowser(wbList[PageIndex]).WebBrowser do
  begin
    if not NoImage then
      DownloadOptions := DownloadOptions + [DLCTL_DLIMAGES]
    else        
      DownloadOptions := DownloadOptions - [DLCTL_DLIMAGES];
    DownloadOptions := DownloadOptions + [DLCTL_RESYNCHRONIZE];
    DownloadOptions := DownloadOptions + [DLCTL_PRAGMA_NO_CACHE];
    Refresh;
  end;
  finally
  if NoImage then
  begin
    WritePrivateProfileString('setting','NoImage','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    WritePrivateProfileString('setting','NoImage','0',PChar(MyDir+ConfigFile));
  end;
  end;
except end;
end;

procedure TFormPublic.NNoBgsoundClick(Sender: TObject);
var
  DownloadCO: TDownloadControlOptions;
begin
try
  NoBgsound := NNoBgsound.Checked;
  try
  DownloadCO := TFormWebBrowser(wbList[PageIndex]).WebBrowser.DownloadOptions;

  if not NoBgsound then
  Include(DownloadCO, DLCTL_BGSOUNDS)
  else
  Exclude(DownloadCO, DLCTL_BGSOUNDS);

  TFormWebBrowser(wbList[PageIndex]).WebBrowser.DownloadOptions:=DownloadCO;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.Refresh;

  finally
  if NoBgsound then
  begin
    WritePrivateProfileString('setting','NoBgsound','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    WritePrivateProfileString('setting','NoBgsound','0',PChar(MyDir+ConfigFile));
  end;
  end; 
except end;
end;

procedure TFormPublic.NNoJavaClick(Sender: TObject);
var
  DownloadCO: TDownloadControlOptions;
begin
try
  NoJava := NNoJava.Checked;

  try
  
  with TFormWebBrowser(wbList[PageIndex]).WebBrowser do
  begin
    if NoJava then
      DownloadOptions := DownloadOptions + [DLCTL_NO_JAVA]
    else
      DownloadOptions := DownloadOptions - [DLCTL_NO_JAVA];
    Refresh;
  end;

  finally
  if NoJava then
  begin
    WritePrivateProfileString('setting','NoJava','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    WritePrivateProfileString('setting','NoJava','0',PChar(MyDir+ConfigFile));
  end;
  end;
except end;
end;

procedure TFormPublic.NNoScriptClick(Sender: TObject);
begin
try
  NoScript := NNoScript.Checked;
  try

  //DownloadCO := TFormWebBrowser(wbList[PageIndex]).WebBrowser.DownloadOptions;
  {
  if NoScript then
  Include(DownloadCO, DLCTL_NO_SCRIPTS) //这是包含 DLCTL_NO_SCRIPTS
  else
  Exclude(DownloadCO, DLCTL_NO_SCRIPTS); //这是去除 DLCTL_NO_SCRIPTS

  TFormWebBrowser(wbList[PageIndex]).WebBrowser.DownloadOptions:=DownloadCO;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.Refresh;
  }
  if NoScript then
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.DownloadOptions := TFormWebBrowser(wbList[PageIndex]).WebBrowser.DownloadOptions + [DLCTL_NO_SCRIPTS]
  else
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.DownloadOptions := TFormWebBrowser(wbList[PageIndex]).WebBrowser.DownloadOptions - [DLCTL_NO_SCRIPTS];
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.Refresh;

  finally
  if NoScript then
  begin
    WritePrivateProfileString('setting','NoScript','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    WritePrivateProfileString('setting','NoScript','0',PChar(MyDir+ConfigFile));
  end;
  end;
except end;
end;

procedure TFormPublic.NNoActivexClick(Sender: TObject);
//var
  //DownloadCO: TDownloadControlOptions;
begin
try
  NoActivex := NNoActivex.Checked;
  try

  with TFormWebBrowser(wbList[PageIndex]).WebBrowser do
  begin
    if NoActivex then
    begin
      DownloadOptions := DownloadOptions + [DLCTL_NO_DLACTIVEXCTLS];
      DownloadOptions := DownloadOptions + [DLCTL_NO_RUNACTIVEXCTLS];
    end
    else
    begin
      DownloadOptions := DownloadOptions - [DLCTL_NO_DLACTIVEXCTLS];
      DownloadOptions := DownloadOptions - [DLCTL_NO_RUNACTIVEXCTLS];
    end;
    Refresh;
  end;

  finally
  if NoActivex then
  begin
    WritePrivateProfileString('setting','NoActivex','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    WritePrivateProfileString('setting','NoActivex','0',PChar(MyDir+ConfigFile));
  end;
  end;
except end;
end;

procedure TFormPublic.NNoVideoClick(Sender: TObject);
var
  DownloadCO: TDownloadControlOptions;
begin
try
  NoVideo := NNoVideo.Checked;
  try

  DownloadCO := TFormWebBrowser(wbList[PageIndex]).WebBrowser.DownloadOptions;

  if not NoVideo then
  Include(DownloadCO, DLCTL_VIDEOS)
  else
  Exclude(DownloadCO, DLCTL_VIDEOS);


  TFormWebBrowser(wbList[PageIndex]).WebBrowser.DownloadOptions:=DownloadCO;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.Refresh;

  finally
  if NoVideo then
  begin
    WritePrivateProfileString('setting','NoVideo','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    WritePrivateProfileString('setting','NoVideo','0',PChar(MyDir+ConfigFile));
  end;
  end;
except end;
end;

procedure TFormPublic.NSInputClick(Sender: TObject);
begin
try
  LoadForm;
  {
  if (Trim(UserName) = '') then
  begin
    SetForm.PageControl1.ActivePage := SetForm.TabSheetMousssTable;
    SetForm.Show;
    SetForm.ENickName.SetFocus;
    exit;
  end;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('nickname', NickName);
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('uname', NickName);

  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('username', UserName);
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('user', UserName);

  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('password', PassWord);
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('password2', PassWord);
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('passwd', PassWord);
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('pwdagain', PassWord);
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('pwd', PassWord);
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('againpwd', PassWord);
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('passwdAgain', PassWord);

  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('pwdA', Answer);

  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('email', Email);

  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('usermail', Email);

  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('realname', RealName);

  TFormWebBrowser(wbList[PageIndex]).WebBrowser.FillForm('name', RealName);
  }
except end;
end;

procedure TFormPublic.TimerUpdateShowTimer(Sender: TObject);
begin
try
  TimerUpdateShow.Enabled := false;
  if TimerUpdateShow.Tag = 1 then
  begin
    FormUpdate.LabelFlag.Caption := '1';
    FormUpdate.Show;
  end
  else
  begin
  FormUpdate.LabelFlag.Caption := '1';
  FormUpdate.Show;
  FormUpdate.btn_Update.Enabled := true;
  FormUpdate.btn_Update.Click;
  end;
except end;                       
end;

procedure TFormPublic.NSustainClick(Sender: TObject);
begin
try
  {
  FormMain.CBURL.Text := UpVUUrl;
  FormMain.BBGO.OnClick(Sender);
  }
  FormMain.CBURL.Text := 'http://www.sharebank.com.cn/soft/softbuy.php?soid=16062';
  FormMain.BBGO.OnClick(Sender);
except end;
end;

procedure TFormPublic.NSaveImgMode1Click(Sender: TObject);
begin
try
  SaveToImage;
  FormPublic.DocumentSetFocus;
except end;
end;

procedure TFormPublic.NSaveImgMode2Click(Sender: TObject);
begin
try
  SaveToImage2;
  FormPublic.DocumentSetFocus;
except end;
end;

procedure TFormPublic.NTabWidthClick(Sender: TObject);
var
  I: Integer;
begin
try
  //ShowMessage(IntToStr((Sender as TMenuItem).Tag));
  //(Sender as TMenuItem).Checked := true;
  I := (Sender as TMenuItem).Tag;
  TabWidth := I;
  HopeTabWidth := I;
  if ShowCloseHint then
  begin
    FormMain.ToolBarTabClose.Hide;
    //FormMain.ToolBarTabParent.Repaint;
    //FormMain.ToolBarTabClose.Show;
  end;
  ShowCloseOk := false;
  TabAutoWidthControl;
  FormMain.ToolBarTabParent.Repaint;
  WritePrivateProfileString('RunData','TabWidth', PChar(IntToStr(I)), PChar(MyDir+ConfigFile));
except end;
end;

procedure TFormPublic.NShowSearchClick(Sender: TObject);
begin
try
  NShowSearch.Checked := not NShowSearch.Checked;
  SearchShow := NShowSearch.Checked;
  NSearchShow.Checked := NShowSearch.Checked;
  //FormMain.PaintPanelSearch.Visible := SearchShow;
  if not SearchShow then
  begin
    FormMain.ToolBarSearchEdit.Hide;
    FormMain.ComboBoxSearch.Hide;
    FormMain.ToolBarSearchButton.Hide;
  end
  else
  begin
    FormMain.ToolBarSearchEdit.Left := FormMain.ToolBarBGO.Left + FormMain.ToolBarBGO.Width;
    FormMain.ToolBarSearchButton.left := FormMain.ToolBarSearchEdit.Left + FormMain.ToolBarSearchEdit.Width;
    FormMain.ToolBarSearchEdit.Show;
    FormMain.ComboBoxSearch.Show;
    FormMain.ToolBarSearchButton.Show;
  end;

  FormMain.FormResize(Sender);
  if SearchShow then
  WritePrivateProfileString('setting','SearchShow','1',PChar(MyDir+ConfigFile))
  else
  WritePrivateProfileString('setting','SearchShow','0',PChar(MyDir+ConfigFile));
except end;
end;

procedure TFormPublic.NStatusBarEClick(Sender: TObject);
begin
try
  if not NStatusBarE.Checked then
  begin
    FormMain.ToolButtonS1.Hide;
    FormMain.ToolButtonS2.Hide;
    FormMain.ToolButtonS3.Hide;
    FormMain.ToolButtonAutoHint.Hide;
    FormMain.ToolButtonFlash.Hide;
    FormMain.TBAllMode.Hide;
    FormMain.ToolButton100.Hide;
    WritePrivateProfileString('RunData', 'StatusBarExtend', '0', PChar(MyDir + ConfigFile));
  end
  else
  begin
    FormMain.ToolButtonS1.Show;
    FormMain.ToolButtonS2.Show;
    FormMain.ToolButtonS3.Show;
    FormMain.ToolButtonAutoHint.Show;
    FormMain.ToolButtonFlash.Show;
    FormMain.TBAllMode.Show;
    FormMain.ToolButton100.Show;
    WritePrivateProfileString('RunData', 'StatusBarExtend', '1', PChar(MyDir + ConfigFile));
  end;
except end;
end;

procedure TFormPublic.NChineseClick(Sender: TObject);
begin
try {$IFDEF LANGUAGE}
  try
  LANGUAGE := 1;

  FormMain.ToolBarMenu.Font.Name:='宋体';
  NChinese.Checked:=true;
  NEnglish.Checked:=false;
  NOther.Checked:=false;      

  FormMain.ToolButtonFav.Caption := '收藏夹';
  FormMain.ToolButtonMusicPlay.Caption := '歌曲播放';
  FormMain.TBAddFav.Caption := '添加';
  FormMain.TBHistory.Caption := '历史';
  FormMain.TBWebNavigation.Caption := '网址导航';
  FormMain.SBOpenMusicFile.Caption:='打开文件';
  FormMain.SBOpenDir.Caption:='打开目录';
  FormMain.TBOpenUrl.Caption:='打开URL';

  finally
  FormMain.Caption := TitleStr;
  if NChinese.Checked then WritePrivateProfileString('setting','Language','1',PChar(MyDir+ConfigFile));
  end;
  ShowMessage('设置已经成功保存,重新启动即可!'); {$ENDIF}
except end;
end;

procedure TFormPublic.NEnglishClick(Sender: TObject);
begin
try  {$IFDEF LANGUAGE}
  try
  LANGUAGE := 2;
  FormMain.ToolBarMenu.Font.Name:='MingLiU';
  Application.Title:=BrowserName+' '+'Browser';
  Self.Caption:=Application.Title;
  LanguageOther;
  if not FileExists(MyDir+EnglishFile) then
  begin
  english;
  end
  else LanguageIni(2);
  NChinese.Checked:=false;
  NEnglish.Checked:=true;
  NOther.Checked:=false;
  finally
  if  NEnglish.Checked then WritePrivateProfileString('setting','Language','2',PChar(MyDir+ConfigFile));
  //ShowMessage('Language File:'+MyDir+EnglishFile+'.');
  FormMain.ToolBarMenu.Menu:=nil;
  FormMain.ToolBarMenu.Menu:=MainMenu1;
  //FormMain.refresh;
  FormMain.FormResize(Sender);
  //FormMain.ToolBarMenu.RePaint;
  end;    {$ENDIF}
except end;
end;

procedure TFormPublic.NOtherClick(Sender: TObject);
var
  Bool:Boolean;
begin
try   {$IFDEF LANGUAGE}
  try
  LANGUAGE := 99;
  Bool:=false;
  Application.Title:=BrowserName+' '+'Browser';
  Self.Caption:=Application.Title;
  LanguageOther;
  if FileExists(MyDir+LanguageFile) then
  begin
    Bool:=true;
    NChinese.Checked:=false;
    NEnglish.Checked:=false;
    NOther.Checked:=true;
    if NOther.Checked then WritePrivateProfileString('setting','Language','3',PChar(MyDir+ConfigFile));
    //ShowMessage('Language File:'+MyDir+LanguageFile+'.');
  end
  else
  begin
    ShowMessage('File:'+MyDir+LanguageFile+' is not exists!');
  end;
  finally
    FormMain.ToolBarMenu.Font.Name:='MingLiU';
    if Bool then LanguageIni(3);
    FormMain.ToolBarMenu.Menu:=nil;
    FormMain.ToolBarMenu.Menu:=MainMenu1;
    FormMain.FormResize(Sender);
  end;  {$ENDIF}
except end;
end;

{
procedure TFormPublic.NFavoritClick(Sender: TObject);
var
  List: TStringList;
  I, Col, MaxCol, J: Integer;
  MaxCount: Integer;
  Pt: TPoint;
  MenuItem: TMenuItem;
begin
try
  for I := NFavorit.Count -1 downto 5 do NFavorit.Items[I].Free;
  Pt := FormMain.PaintPanelButtonAddress.ClientToScreen(Point(0, FormMain.PaintPanelButtonAddress.Height));
  //MaxCount := (Screen.DesktopHeight - Pt.Y) div (MainMenu1.Images.Height + 4)+1;
  MaxCount := (FormMain.Height div 24);
  List := TStringList.Create;
  try
    SearchDir(FavoritFolder, List);
    List.Sort;
    Col := 0;
    MenuItem := nil;
    if List.Count + NFavorit.Count > MaxCount then
    begin
      Col := (List.Count + NFavorit.Count) div MaxCount;
      MaxCol := StrToIntDef('3', 3);
      if Col >= MaxCol then
      begin
        MenuItem := TMenuItem.Create(Self);
        MenuItem.OnClick := NFavDropClick;
        MenuItem.OnDrawItem := NFavDropImgDrawItem;
        //MenuItem.OnAdvancedDrawItem := DrawMainItem;
        //MenuItem.OnMeasureItem := MeasureMainItem;
        J := MaxCol * MaxCount - NFavorit.Count -1;
        for I := PMFavDropList.Items.Count -1 downto 0 do
          PMFavDropList.Items[I].Free;
        for I :=  List.Count -1 downto J do
        begin
          PMFavDropList.Items.Insert(0, List.Objects[I] as TMenuItem);
          List.Delete(I);
        end;
        if Col > MaxCol + 1 then
          for I := 1 to Col - MaxCol do
            PMFavDropList.Items[I * MaxCount].Break := mbBreak;
        Col := MaxCol;
      end;
    end;
    for I := 0 to List.Count -1 do
      NFavorit.Add(List.Objects[I] as TMenuItem);
    if Assigned(MenuItem) then NFavorit.Add(MenuItem);
    if Col = 1 then
      NFavorit.Items[I * MaxCount].Break := mbBreak else
      for I := 1 to Col -1 do
        NFavorit.Items[I * MaxCount].Break := mbBreak;
  finally
     List.Free;
  end;
except end;
end;
}

procedure TFormPublic.NFaceStyle3Click(Sender: TObject);
begin
try
  try
  FaceStyle := 3;
  if TBTabNewShow then FormMain.ToolBarTabNew.Visible := false;

  if FileExists(MyDir + 'Skin\Default\bg.bmp') then
  FormMain.Imagebg.Picture.LoadFromFile(MyDir + 'Skin\Default\bg.bmp')
  else
  FormMain.Imagebg.Picture.Bitmap := FormMain.BPF1.Glyph;
  if FileExists(MyDir + 'Skin\Default\ty.bmp') then
  FormMain.ImageTabYes.Picture.LoadFromFile(MyDir + 'Skin\Default\ty.bmp');
  if FileExists(MyDir + 'Skin\Default\tn.bmp') then
  FormMain.ImageTabNo.Picture.LoadFromFile(MyDir + 'Skin\Default\tn.bmp');
  ShowCloseOk := false;
  //FormMain.CoolBar1.Bitmap := FormMain.Imagebg.Picture.Bitmap;
  FormMain.ToolBarMenu.RePaint;
  FormMain.ToolBarTabParent.RePaint;
  FormMain.ToolBarButton.RePaint;
  FormMain.ToolBarTabControl.RePaint;
  FormMain.PaintPanelButtonAddress.RePaint;
  FormMain.ToolBarTabNew.RePaint;
  FormMain.ToolBarAddress.RePaint;
  FormMain.ToolBarBGO.RePaint;
  FormMain.ToolBarSearchEdit.RePaint;
  FormMain.ToolBarSearchButton.RePaint;
  FormMain.ToolBarFavorite.RePaint;
  finally
  WritePrivateProfileString('RunData','FaceStyle','3',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormPublic.N110Click(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom:='110%'; //1.00;
  if (TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag <> LastUnCloseFlag) then TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag := ZoomTag;
except end;
end;

procedure TFormPublic.N120Click(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom:='120%'; //1.00;
  if (TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag <> LastUnCloseFlag) then TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag := ZoomTag;
except end;
end;

procedure TFormPublic.N130Click(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom:='130%'; //1.00;
  if (TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag <> LastUnCloseFlag) then TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag := ZoomTag;
except end;
end;
                 
procedure TFormPublic.NDaoHangClick(Sender: TObject);
begin
try
  FormMain.CBURL.Text := WebNavigationUrl;
  FormMain.BBGO.Click;
except end;
end;

end.



