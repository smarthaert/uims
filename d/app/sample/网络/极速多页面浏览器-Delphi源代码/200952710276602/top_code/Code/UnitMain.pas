unit UnitMain;
                                   
interface

{$DEFINE ATSAMEON}
//{$DEFINE InstallOn}
{$DEFINE MenuSmall}
                     
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ExtCtrls, StdCtrls, ComCtrls, ToolWin, PaintPanel,
  Menus, OleCtrls, IniFiles, SHDocVw, EmbeddedWB, FavoritesTreeEx, AppEvnts,
  MSHTML, ActiveX, Registry,
  ShlObj,  ShellApi,  
  ComObj,  WinInet, //add
  Buttons, DdeMan, ActnList,
  Clipbrd,
  WMPLib_TLB, MPlayer,
  //XPMan,
  AddressBox;

{$IFDEF ATSAMEON}
const
  APPNAME = '0**99*****99';
  APPTAG = 88899;
  CloseMsg = '0*0*CLOSE*0*0';
  WM_OPENPAGE = WM_USER + 1;
  WM_FOUNDHE = WM_USER + 2;
{$ENDIF}

type
  TFormMain = class(TForm, IDropTarget)
    Panel1: TPanel;
    PaintPanel4: TPaintPanel;
    PanelWBMain: TPanel;
    WBInitPage: TEmbeddedWB;
    ImageWebIcon2: TImage;
    ImageWebIcon: TImage;
    ImageListWebIcon: TImageList;
    TimerDocRoll: TTimer;
    TimerOne: TTimer;
    PopupMenuSearch: TPopupMenu;
    NSearch1: TMenuItem;
    NSearch2: TMenuItem;
    NSearch3: TMenuItem;
    NSearch4: TMenuItem;
    NSearch5: TMenuItem;
    NSearch6: TMenuItem;
    NSearch7: TMenuItem;
    NSearch11: TMenuItem;
    PanelLeft: TPanel;
    PanelLeftTop0: TPanel;
    ToolBar6: TToolBar;
    ToolButtonFav: TToolButton;
    PanelFavorit: TPanel;
    Panel3: TPanel;
    TreeView1: TTreeView;
    ToolBar12: TToolBar;
    TBAddFav: TToolButton;
    TBWebNavigation: TToolButton;
    FavoritesTree1: TFavoritesTreeEx;
    PopupMenuNewly: TPopupMenu;
    ApplicationEvents1: TApplicationEvents;
    Splitter1: TSplitter;
    ImageTabYes: TImage;
    ImageTabNo: TImage;
    PopupMenuTabList: TPopupMenu;
    N1: TMenuItem;
    ToolBarStatusBar_: TToolBar;
    ToolButtonS1: TToolButton;
    ToolButtonAutoHint: TToolButton;
    ToolButtonS2: TToolButton;
    ToolButtonFlash: TToolButton;
    ToolButton100: TToolButton;
    ImageListRightSmall: TImageList;
    ImageListF: TImageList;
    ImageButton: TImage;
    ImageList3: TImageList;
    ImageList5: TImageList;
    ImageListTabLeft2: TImageList;
    ActionList1: TActionList;
    ActionNAddNewBlank: TAction;
    ActionNAddNewHomePage: TAction;
    ActionNCopyCurrentPage: TAction;
    ActionNSaveAs: TAction;
    ActionNPrint: TAction;
    ActionNCloseCurrent: TAction;
    ActionNAllClose: TAction;
    ActionNExit: TAction;
    ActionNSelectAll: TAction;
    ActionNFind: TAction;
    ActionNAddressSetFocus: TAction;
    ActionNRefresh: TAction;
    ActionNStop: TAction;
    ActionNAllRefresh: TAction;
    ActionNPreviousPage: TAction;
    ActionNNextPage: TAction;
    ActionNAddFavorite: TAction;
    ActionNWeather: TAction;
    ActionOpenNewlyOne: TAction;
    ActionDocmentSetFocus: TAction;
    ActionCleanCurrentAd: TAction;
    ActionF1: TAction;
    ActionF2: TAction;
    ActionF3: TAction;
    ActionF4: TAction;
    ActionQuickClearMemory: TAction;
    ActionCleanHistory: TAction;
    ActionAddFirstTab: TAction;
    ActionTimerWebAutoRefresh: TAction;
    ActionInputTable: TAction;
    ActionSetTabWidth: TAction;
    ActionUnLock: TAction;
    ActionGetScreen: TAction;
    ToolButtonMusicPlay: TToolButton;
    PageControl_1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet3: TTabSheet;
    PanelMusicPlay: TPanel;
    Panel11: TPanel;
    OpenDialog2: TOpenDialog;
    TimerPlayer: TTimer;
    LPM: TPopupMenu;
    NOpenMusicFile: TMenuItem;
    NOpenDirectory: TMenuItem;
    MenuItem1: TMenuItem;
    NLoadList: TMenuItem;
    NSaveList: TMenuItem;
    NListSaveAs: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    TimerSide: TTimer;
    ImageListClowwwwwwwseImg: TImageList;
    ToolBarTabClose: TToolBar;
    ToolButtonTabClose2: TToolButton;
    ActionTV: TAction;
    PM_ButtonRight: TPopupMenu;
    NRBClosePage: TMenuItem;
    N_BR_Flag: TMenuItem;
    NRBRefrsh: TMenuItem;
    ImageList_ButtonRight: TImageList;
    N43: TMenuItem;
    NRBClose: TMenuItem;
    N42: TMenuItem;
    ActionOpenNewly: TAction;
    StatusBar_: TStatusBar;
    PaintPanelMusicPlayTop: TPaintPanel;
    PanelMusicPlay0: TPanel;
    SBNext: TSpeedButton;
    SBPrevious: TSpeedButton;
    SBPause_Play: TSpeedButton;
    SBStop: TSpeedButton;
    SBPlay: TSpeedButton;
    SBPause: TSpeedButton;
    TrackBar1: TTrackBar;
    Label29: TLabel;
    Label27: TLabel;
    TrackBar2: TTrackBar;
    RBOrderPlay: TRadioButton;
    RBRandomPlay: TRadioButton;
    RBOneLoopPlay: TRadioButton;
    ToolBarMusicPlayOpen: TToolBar;
    SBOpenMusicFile: TToolButton;
    SBOpenDir: TToolButton;
    TBOpenUrl: TToolButton;
    MediaPlayer: TMediaPlayer;
    wmp: TWindowsMediaPlayer;
    LMusicName: TLabel;
    PaintPanelFavLeftControl: TPaintPanel;
    ToolBarLeftTopControl: TToolBar;
    SBSideStatShape: TToolButton;
    SBLeftTopClose: TToolButton;
    ShowImage: TImage;
    PopupMenuTools: TPopupMenu;
    MIComputer: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    PMCommandLine: TMenuItem;
    MIRegedit: TMenuItem;
    PopupMenuNewPage: TPopupMenu;
    NAddNewBlank2: TMenuItem;
    NAddNewHomePage2: TMenuItem;
    NCopyCurrentPage: TMenuItem;
    PopupMenuRefreshAll: TPopupMenu;
    NRefreshAll: TMenuItem;
    PopupMenuCloseAll: TPopupMenu;
    NPopupCloseAll: TMenuItem;
    BPF1: TSpeedButton;
    ImageTabYes1: TImage;
    ImageTabNo1: TImage;
    ImageListCloseImg2: TImageList;
    ImageWebIconT: TImage;
    ActionTabLock: TAction;
    ActionTabUnLock: TAction;
    TBAllMode: TToolButton;
    ToolButtonS3: TToolButton;
    ActionAllModeY: TAction;
    ActionAllModeN: TAction;
    N11: TMenuItem;
    NOrderPlay: TMenuItem;
    NRandomPlay: TMenuItem;
    ActionCut: TAction;
    ActionCopy: TAction;
    ActionPaste: TAction;
    ActionCdromOpen: TAction;
    ActionCdromClose: TAction;
    PaintPanelMTop: TPaintPanel;
    ToolBarTabParent: TToolBar;
    ToolBarTabNew: TToolBar;
    ToolButtonTabNew: TToolButton;
    ToolButtonFavorites: TToolButton;
    ToolButtonAddFavorites: TToolButton;
    ToolBarTabControl: TToolBar;
    ToolButtonTabList: TToolButton;
    ToolButtonTabClose: TToolButton;
    PaintPanelFavorite: TPaintPanel;
    TBarFavoriteList: TToolBar;
    TBFavoriteList: TToolButton;
    ToolBarFavorite: TToolBar;
    PopupMenudx: TPopupMenu;
    N501: TMenuItem;
    N751: TMenuItem;
    N1001: TMenuItem;
    N1251: TMenuItem;
    N1501: TMenuItem;
    N2001: TMenuItem;
    SBBGHei2: TSpeedButton;
    SBBGHei1: TSpeedButton;
    TBHistory: TToolButton;
    ImageList32: TImageList;
    ImageList31: TImageList;
    ImageListTabLeft: TImageList;
    ImageListCloseImg: TImageList;
    MainMenu1: TPopupMenu;
    NFile: TMenuItem;
    N45: TMenuItem;
    N46: TMenuItem;
    N47: TMenuItem;
    NGroup: TMenuItem;
    N49: TMenuItem;
    N50: TMenuItem;
    N51: TMenuItem;
    N52: TMenuItem;
    N54: TMenuItem;
    N55: TMenuItem;
    NNewBlankPage: TMenuItem;
    N53: TMenuItem;
    N57: TMenuItem;
    N58: TMenuItem;
    N59: TMenuItem;
    N60: TMenuItem;
    N61: TMenuItem;
    N62: TMenuItem;
    N63: TMenuItem;
    N64: TMenuItem;
    N65: TMenuItem;
    N66: TMenuItem;
    N67: TMenuItem;
    N68: TMenuItem;
    N69: TMenuItem;
    N70: TMenuItem;
    N71: TMenuItem;
    N72: TMenuItem;
    N73: TMenuItem;
    N74: TMenuItem;
    N75: TMenuItem;
    N76: TMenuItem;
    N77: TMenuItem;
    N78: TMenuItem;
    N79: TMenuItem;
    N80: TMenuItem;
    N81: TMenuItem;
    N82: TMenuItem;
    N83: TMenuItem;
    N84: TMenuItem;
    N85: TMenuItem;
    IE1: TMenuItem;
    N86: TMenuItem;
    N87: TMenuItem;
    N88: TMenuItem;
    N89: TMenuItem;
    N90: TMenuItem;
    N91: TMenuItem;
    N92: TMenuItem;
    N93: TMenuItem;
    N94: TMenuItem;
    N95: TMenuItem;
    N96: TMenuItem;
    N97: TMenuItem;
    N98: TMenuItem;
    N99: TMenuItem;
    N100: TMenuItem;
    N101: TMenuItem;
    N102: TMenuItem;
    N103: TMenuItem;
    N104: TMenuItem;
    N105: TMenuItem;
    N106: TMenuItem;
    N107: TMenuItem;
    N108: TMenuItem;
    N109: TMenuItem;
    N110: TMenuItem;
    N111: TMenuItem;
    N112: TMenuItem;
    N113: TMenuItem;
    N114: TMenuItem;
    N115: TMenuItem;
    N116: TMenuItem;
    N117: TMenuItem;
    N118: TMenuItem;
    NAddToGroup: TMenuItem;
    N120: TMenuItem;
    N121: TMenuItem;
    N122: TMenuItem;
    N123: TMenuItem;
    N124: TMenuItem;
    N125: TMenuItem;
    N126: TMenuItem;
    N127: TMenuItem;
    N128: TMenuItem;
    N129: TMenuItem;
    N130: TMenuItem;
    N131: TMenuItem;
    LOGO1: TMenuItem;
    N132: TMenuItem;
    N133: TMenuItem;
    N134: TMenuItem;
    N135: TMenuItem;
    Intenet1: TMenuItem;
    N136: TMenuItem;
    N137: TMenuItem;
    N138: TMenuItem;
    FLASH1: TMenuItem;
    N139: TMenuItem;
    N140: TMenuItem;
    N141: TMenuItem;
    N142: TMenuItem;
    N143: TMenuItem;
    Java1: TMenuItem;
    Scripts1: TMenuItem;
    ActiveX1: TMenuItem;
    N144: TMenuItem;
    N145: TMenuItem;
    IE2: TMenuItem;
    N146: TMenuItem;
    N147: TMenuItem;
    IE3: TMenuItem;
    N148: TMenuItem;
    N149: TMenuItem;
    N150: TMenuItem;
    N801: TMenuItem;
    N1002: TMenuItem;
    N1201: TMenuItem;
    N1502: TMenuItem;
    N1801: TMenuItem;
    N2002: TMenuItem;
    LOGO2: TMenuItem;
    LOGO3: TMenuItem;
    N151: TMenuItem;
    N152: TMenuItem;
    N153: TMenuItem;
    N154: TMenuItem;
    N155: TMenuItem;
    N156: TMenuItem;
    N157: TMenuItem;
    N158: TMenuItem;
    N159: TMenuItem;
    N160: TMenuItem;
    N161: TMenuItem;
    N162: TMenuItem;
    N163: TMenuItem;
    N164: TMenuItem;
    N165: TMenuItem;
    N166: TMenuItem;
    N167: TMenuItem;
    N168: TMenuItem;
    N169: TMenuItem;
    N170: TMenuItem;
    N171: TMenuItem;
    N172: TMenuItem;
    N173: TMenuItem;
    N174: TMenuItem;
    N175: TMenuItem;
    N176: TMenuItem;
    N177: TMenuItem;
    N178: TMenuItem;
    N179: TMenuItem;
    N180: TMenuItem;
    N181: TMenuItem;
    N182: TMenuItem;
    N183: TMenuItem;
    N184: TMenuItem;
    N185: TMenuItem;
    N186: TMenuItem;
    N187: TMenuItem;
    N188: TMenuItem;
    N189: TMenuItem;
    N190: TMenuItem;
    N191: TMenuItem;
    N192: TMenuItem;
    N193: TMenuItem;
    N194: TMenuItem;
    N195: TMenuItem;
    N196: TMenuItem;
    N197: TMenuItem;
    N198: TMenuItem;
    N199: TMenuItem;
    N200: TMenuItem;
    N201: TMenuItem;
    N202: TMenuItem;
    N203: TMenuItem;
    N204: TMenuItem;
    Cache1: TMenuItem;
    Cookies1: TMenuItem;
    N205: TMenuItem;
    N206: TMenuItem;
    N207: TMenuItem;
    N208: TMenuItem;
    N209: TMenuItem;
    N601: TMenuItem;
    N21: TMenuItem;
    N44: TMenuItem;
    ddd1: TMenuItem;
    ddd2: TMenuItem;
    ddd3: TMenuItem;
    N56: TMenuItem;
    G1: TMenuItem;
    L1: TMenuItem;
    M1: TMenuItem;
    S1: TMenuItem;
    A1: TMenuItem;
    N502: TMenuItem;
    N752: TMenuItem;
    N1003: TMenuItem;
    N1252: TMenuItem;
    N1503: TMenuItem;
    N2003: TMenuItem;
    NHide1: TMenuItem;
    N48: TMenuItem;
    Action_AlexaEx: TAction;
    PMGORPop: TPopupMenu;
    NGO: TMenuItem;
    NGOSearch: TMenuItem;
    N211: TMenuItem;
    NGetClipbrdGo: TMenuItem;
    TIUseIEOpen: TMenuItem;
    Action_Test1: TAction;
    N119: TMenuItem;
    NOnlyOne: TMenuItem;
    Image8: TImage;
    Image7: TImage;
    NCleanAllNewly: TMenuItem;
    N212: TMenuItem;
    NGetClipbrdSearch: TMenuItem;
    ActionSaveForm: TAction;
    ActionFullForm: TAction;
    Imagebg1: TImage;
    Timer_SearchC: TTimer;
    N1101: TMenuItem;
    N1202: TMenuItem;
    N1301: TMenuItem;
    ListBoxTV: TListBox;
    PMTV: TPopupMenu;
    NTVListEdit: TMenuItem;
    NTVListRefresh: TMenuItem;
    ListBoxMusicList: TListBox;
    ListBoxTV2: TListBox;
    ActionClearLastNewly: TAction;
    ActionCloseCurrentNoNewly: TAction;
    Action1: TAction;
    ImageMenuBase: TImage;
    ImageMenuMouseDown: TImage;
    PanelMenuControl: TPanel;
    PaintPanelControl: TPaintPanel;
    ToolBarControl: TToolBar;
    ToolButtonMinimize: TToolButton;
    ToolButtonWindowState: TToolButton;
    ToolButtonClose: TToolButton;
    PaintPanelMenu: TPaintPanel;
    ToolBarMenu: TToolBar;
    Imagebg: TImage;
    Imagebg0: TImage;
    ImageListB0D: TImageList;
    PaintPanelButtonAddress: TPaintPanel;
    ImageGo: TImage;
    ToolBarButton: TToolBar;
    TBAddNew: TToolButton;
    ButtonSplitter1: TToolButton;
    TBGoBack: TToolButton;
    TBGoForward: TToolButton;
    TBStop: TToolButton;
    TBRefresh: TToolButton;
    TBGoHome: TToolButton;
    TBFavorite: TToolButton;
    ToolButtonS6: TToolButton;
    TBClose: TToolButton;
    TBNewly: TToolButton;
    TBOption: TToolButton;
    TBTools: TToolButton;
    ToolButton7: TToolButton;
    CBURL2: TComboBoxEx;
    ButtonSearch: TButton;
    ToolBarAddress: TToolBar;
    CBURL: TAddressBox;
    ToolBarBGO: TToolBar;
    BBGO: TToolButton;
    ToolBarSearchButton: TToolBar;
    ToolButtonSearch: TToolButton;
    ToolBarSearchEdit: TToolBar;
    ComboBoxSearch: TEdit;
    Image2: TImage;
    ImageList1: TImageList;
    ImageList4: TImageList;
    ImageTabBG: TImage;
    ImageTabYes0: TImage;
    ImageTabNo0: TImage;
    ImageTabCloseBg: TImage;
    ToolBarStatusBar: TPaintPanel;
    Panel_StatusBar3: TPanel;
    Panel_StatusBar1: TPanel;
    Panel_StatusBar2: TPanel;
    ImageTabIconT1: TImage;
    ImageTabIconT2: TImage;
    ImageC221: TImage;
    ImageC212: TImage;
    ImageC11: TImage;
    ImageC31: TImage;
    ImageC222: TImage;
    ImageC12: TImage;
    ImageC32: TImage;
    ImageC211: TImage;
    TBTabNew: TToolButton;
    ImageMenuMouseDown2: TImage;
    ImageListB01: TImageList;
    ImageListB02: TImageList;
    ImageListB03: TImageList;
    ImageListB04: TImageList;
    PM_ShowMenu: TPopupMenu;
    NShowMenu2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N2: TMenuItem;
    N8: TMenuItem;
    dddd1: TMenuItem;
    N9: TMenuItem;
    WB1_: TEmbeddedWB;
    WB1_2: TWebBrowser;
    PaintPanelMenu2: TPaintPanel;
    ToolBarMenu2: TToolBar;
    PaintPanelBlank: TPaintPanel;
    ToolBar1: TToolBar;
    procedure ToolBarGoBackForwardCustomDraw(Sender: TToolBar;
      const ARect: TRect; var DefaultDraw: Boolean);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    //procedure ToolBarTabParentMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure TimerDocRollTimer(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG;
      var Handled: Boolean);
    procedure ApplicationEvents1Restore(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PaintPanelMTopPaint(Sender: TObject);
    procedure ToolBarTabParentCustomDraw(Sender: TToolBar;
      const ARect: TRect; var DefaultDraw: Boolean);
    procedure ToolBarTabControlCustomDraw(Sender: TToolBar;
      const ARect: TRect; var DefaultDraw: Boolean);
    procedure ToolBarTabNewCustomDraw(Sender: TToolBar; const ARect: TRect;
      var DefaultDraw: Boolean);
    procedure ToolButtonTabNewClick(Sender: TObject);
    procedure ToolBarTabParentCustomDrawButton(Sender: TToolBar;
      Button: TToolButton; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure ToolBarTabParentDblClick(Sender: TObject);
    procedure CBURL2Click(Sender: TObject);
    procedure CBURL2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToolBarTabControlCustomDrawButton(Sender: TToolBar;
      Button: TToolButton; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure TabListClick(Sender: TObject);  //Self add
    procedure ToolButtonTabListClick(Sender: TObject);
    procedure ToolButtonTabCloseClick(Sender: TObject);
    procedure ToolButtonFavoritesClick(Sender: TObject);
    procedure FavoritesTree1GetImageIndex(Sender: TObject;
      Node: TTreeNode);
    procedure FavoritesTree1GetSelectedIndex(Sender: TObject;
      Node: TTreeNode);
    procedure FavoritesTree1Navigate(Sender: TObject; const URL: String);
    procedure ToolBar6CustomDraw(Sender: TToolBar; const ARect: TRect;
      var DefaultDraw: Boolean);
    procedure ToolBar6CustomDrawButton(Sender: TToolBar;
      Button: TToolButton; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure ToolBar12CustomDraw(Sender: TToolBar; const ARect: TRect;
      var DefaultDraw: Boolean);
    procedure ToolBar12CustomDrawButton(Sender: TToolBar;
      Button: TToolButton; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure ToolBarLeftTopControlCustomDraw(Sender: TToolBar;
      const ARect: TRect; var DefaultDraw: Boolean);
    procedure SBLeftTopCloseClick(Sender: TObject);
    procedure TBAddFavClick(Sender: TObject);
    procedure ToolButtonAddFavoritesClick(Sender: TObject);
    procedure ToolBarTabNewCustomDrawButton(Sender: TToolBar;
      Button: TToolButton; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure ToolBarTabParentMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ToolBarFavoriteCustomDraw(Sender: TToolBar;
      const ARect: TRect; var DefaultDraw: Boolean);
    procedure ToolBarFavoriteCustomDrawButton(Sender: TToolBar;
      Button: TToolButton; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure ToolBarStatusBar_CustomDrawButton(Sender: TToolBar;
      Button: TToolButton; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton100Click(Sender: TObject);
    procedure ToolButtonFlashClick(Sender: TObject);
    procedure ActionGetScreenExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TimerOneTimer(Sender: TObject);
    procedure ActionTimerWebAutoRefreshExecute(Sender: TObject);
    procedure ToolButtonMusicPlayClick(Sender: TObject);
    procedure ToolButtonFavClick(Sender: TObject);
    procedure SBOpenMusicFileClick(Sender: TObject);
    procedure SBOpenDirClick(Sender: TObject);
    procedure TBOpenUrlClick(Sender: TObject);
    procedure TimerPlayerTimer(Sender: TObject);
    procedure NOpenMusicFileClick(Sender: TObject);
    procedure NOpenDirectoryClick(Sender: TObject);
    procedure NLoadListClick(Sender: TObject);
    procedure NSaveListClick(Sender: TObject);
    procedure NListSaveAsClick(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure ListBoxMusicListDblClick(Sender: TObject);
    procedure ActionNAddNewBlankExecute(Sender: TObject);
    procedure ActionNAddNewHomePageExecute(Sender: TObject);
    procedure ActionNCopyCurrentPageExecute(Sender: TObject);
    procedure ActionNSaveAsExecute(Sender: TObject);
    procedure ActionNPrintExecute(Sender: TObject);
    procedure ActionNCloseCurrentExecute(Sender: TObject);
    procedure ActionNAllCloseExecute(Sender: TObject);
    procedure ActionNExitExecute(Sender: TObject);
    procedure ActionNSelectAllExecute(Sender: TObject);
    procedure ActionNFindExecute(Sender: TObject);
    procedure ActionNAddressSetFocusExecute(Sender: TObject);
    procedure ActionNRefreshExecute(Sender: TObject);
    procedure ActionNStopExecute(Sender: TObject);
    procedure ActionNAllRefreshExecute(Sender: TObject);
    procedure ActionNPreviousPageExecute(Sender: TObject);
    procedure ActionNNextPageExecute(Sender: TObject);
    procedure ActionNAddFavoriteExecute(Sender: TObject);
    procedure ActionNWeatherExecute(Sender: TObject);
    procedure ActionOpenNewlyOneExecute(Sender: TObject);
    procedure ActionDocmentSetFocusExecute(Sender: TObject);
    procedure ActionCleanCurrentAdExecute(Sender: TObject);
    procedure ActionF1Execute(Sender: TObject);
    procedure ActionF2Execute(Sender: TObject);
    procedure ActionF3Execute(Sender: TObject);
    procedure ActionF4Execute(Sender: TObject);
    procedure ActionQuickClearMemoryExecute(Sender: TObject);
    procedure ActionInputTableExecute(Sender: TObject);
    procedure ActionSetTabWidthExecute(Sender: TObject);
    procedure ActionUnLockExecute(Sender: TObject);
    procedure SBSideStatShapeClick(Sender: TObject);
    procedure TimerSideTimer(Sender: TObject);
    procedure ActionAddFirstTabExecute(Sender: TObject);
    procedure ToolBarMusicPlayOpenCustomDrawButton(Sender: TToolBar;
      Button: TToolButton; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure ImageStopClick(Sender: TObject);
    procedure ToolBarTabCloseCustomDrawButton(Sender: TToolBar;
      Button: TToolButton; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure ToolButtonTabClose2Click(Sender: TObject);
    procedure ToolButtonTabClose2MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ActionTVExecute(Sender: TObject);
    procedure NRBClosePageClick(Sender: TObject);
    procedure NRBRefrshClick(Sender: TObject);
    procedure NRBCloseClick(Sender: TObject);
    procedure ActionOpenNewlyExecute(Sender: TObject);
    procedure NSearch1Click(Sender: TObject);
    procedure NSearch2Click(Sender: TObject);
    procedure NSearch3Click(Sender: TObject);
    procedure NSearch4Click(Sender: TObject);
    procedure NSearch5Click(Sender: TObject);
    procedure NSearch6Click(Sender: TObject);
    procedure NSearch7Click(Sender: TObject);
    procedure PaintPanelMusicPlayTopPaint(Sender: TObject);
    procedure ToolBarMusicPlayOpenCustomDraw(Sender: TToolBar;
      const ARect: TRect; var DefaultDraw: Boolean);
    procedure PaintPanelFavLeftControlPaint(Sender: TObject);
    procedure ToolBarMenuCustomDraw(Sender: TToolBar; const ARect: TRect;
      var DefaultDraw: Boolean);
    procedure ToolBarButtonCustomDraw(Sender: TToolBar; const ARect: TRect;
      var DefaultDraw: Boolean);
    procedure TBGoHomeClick(Sender: TObject);
    procedure TBGoForwardClick(Sender: TObject);
    procedure TBGoBackClick(Sender: TObject);
    procedure TBRefreshClick(Sender: TObject);
    procedure TBStopClick(Sender: TObject);
    procedure TBFavoriteClick(Sender: TObject);
    procedure TBNewlyClick(Sender: TObject);
    procedure TBNewlyMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TBCloseClick(Sender: TObject);
    procedure TBOptionClick(Sender: TObject);
    procedure TBToolsClick(Sender: TObject);
    procedure PaintPanelButtonAddressPaint(Sender: TObject);
    procedure ToolBarAddressCustomDraw(Sender: TToolBar;
      const ARect: TRect; var DefaultDraw: Boolean);
    procedure TBAddNewClick(Sender: TObject);
    procedure NAddNewBlank2Click(Sender: TObject);
    procedure NAddNewHomePage2Click(Sender: TObject);
    procedure NCopyCurrentPageClick(Sender: TObject);
    procedure NPopupCloseAllClick(Sender: TObject);
    procedure NRefreshAllClick(Sender: TObject);
    procedure ImagenewClick(Sender: TObject);
    procedure ImageRefreshClick(Sender: TObject);
    procedure ImageHomeClick(Sender: TObject);
    procedure ToolButtonAutoHintClick(Sender: TObject);
    procedure ActionTabLockExecute(Sender: TObject);
    procedure ActionTabUnLockExecute(Sender: TObject);
    procedure ButtonSearchClick(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TBAllModeClick(Sender: TObject);
    procedure ActionAllModeYExecute(Sender: TObject);
    procedure ActionAllModeNExecute(Sender: TObject);
    procedure NRandomPlayClick(Sender: TObject);
    procedure NOrderPlayClick(Sender: TObject);
    procedure ToolBarTabCloseCustomDraw(Sender: TToolBar;
      const ARect: TRect; var DefaultDraw: Boolean);
    procedure ToolBarMenuClick(Sender: TObject);
    procedure PaintPanelButtonAddressClick(Sender: TObject);
    procedure ToolBarTabParentClick(Sender: TObject);
    procedure ActionCutExecute(Sender: TObject);
    procedure ActionCopyExecute(Sender: TObject);
    procedure ActionPasteExecute(Sender: TObject);
    procedure PaintPanelFavoritePaint(Sender: TObject);
    procedure ActionCdromOpenExecute(Sender: TObject);
    procedure ActionCdromCloseExecute(Sender: TObject);
    procedure WBInitPageNewWindow2(Sender: TObject; var ppDisp: IDispatch;
      var Cancel: WordBool);
    procedure WB1_2222ScriptError(Sender: TObject; ErrorLine, ErrorCharacter,
      ErrorCode, ErrorMessage, ErrorUrl: String; var ContinueScript,
      Showdialog: Boolean);
    procedure WBInitPageScriptError(Sender: TObject; ErrorLine,
      ErrorCharacter, ErrorCode, ErrorMessage, ErrorUrl: String;
      var ContinueScript, Showdialog: Boolean);
    procedure N1001Click(Sender: TObject);
    procedure PaintPanelButtonAddressMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ToolButton100MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TBHistoryClick(Sender: TObject);
    procedure TBWebNavigationClick(Sender: TObject);
    procedure MIComputerClick(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure PMCommandLineClick(Sender: TObject);
    procedure MIRegeditClick(Sender: TObject);
    //MainMenu Start  //mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    {$IFDEF MenuSmall}
    procedure NNewBlankPageClick(Sender: TObject);
    procedure N54Click(Sender: TObject);
    procedure N55Click(Sender: TObject);
    procedure N53Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N44Click(Sender: TObject);
    procedure N58Click(Sender: TObject);
    procedure N60Click(Sender: TObject);
    procedure N61Click(Sender: TObject);
    procedure N64Click(Sender: TObject);
    procedure N65Click(Sender: TObject);
    procedure N67Click(Sender: TObject);
    procedure N68Click(Sender: TObject);
    procedure N70Click(Sender: TObject);
    procedure N71Click(Sender: TObject);
    procedure N74Click(Sender: TObject);
    procedure N75Click(Sender: TObject);
    procedure N77Click(Sender: TObject);
    procedure N78Click(Sender: TObject);
    procedure N79Click(Sender: TObject);
    procedure N81Click(Sender: TObject);
    procedure N82Click(Sender: TObject);
    procedure N84Click(Sender: TObject);
    procedure N85Click(Sender: TObject);
    procedure IE1Click(Sender: TObject);
    procedure N87Click(Sender: TObject);
    procedure N106Click(Sender: TObject);
    procedure N109Click(Sender: TObject);
    procedure N107Click(Sender: TObject);
    procedure N108Click(Sender: TObject);
    procedure N111Click(Sender: TObject);
    procedure N112Click(Sender: TObject);
    procedure N93Click(Sender: TObject);
    procedure N94Click(Sender: TObject);
    procedure N95Click(Sender: TObject);
    procedure N97Click(Sender: TObject);
    procedure N99Click(Sender: TObject);
    procedure N100Click(Sender: TObject);
    procedure N102Click(Sender: TObject);
    procedure N103Click(Sender: TObject);
    procedure N105Click(Sender: TObject);
    procedure N113Click(Sender: TObject);
    procedure N114Click(Sender: TObject);
    procedure N115Click(Sender: TObject);
    procedure N117Click(Sender: TObject);
    procedure N118Click(Sender: TObject);
    procedure N137Click(Sender: TObject);
    procedure N138Click(Sender: TObject);
    procedure FLASH1Click(Sender: TObject);
    procedure N140Click(Sender: TObject);
    procedure N141Click(Sender: TObject);
    procedure N142Click(Sender: TObject);
    procedure N143Click(Sender: TObject);
    procedure Java1Click(Sender: TObject);
    procedure Scripts1Click(Sender: TObject);
    procedure ActiveX1Click(Sender: TObject);
    procedure N123Click(Sender: TObject);
    procedure N144Click(Sender: TObject);
    procedure IE2Click(Sender: TObject);
    procedure N146Click(Sender: TObject);
    procedure N127Click(Sender: TObject);
    procedure N147Click(Sender: TObject);
    procedure IE3Click(Sender: TObject);
    procedure N148Click(Sender: TObject);
    procedure N149Click(Sender: TObject);
    procedure N150Click(Sender: TObject);
    procedure N801Click(Sender: TObject);
    procedure N1002Click(Sender: TObject);
    procedure N1201Click(Sender: TObject);
    procedure N1502Click(Sender: TObject);
    procedure N1801Click(Sender: TObject);
    procedure N2002Click(Sender: TObject);
    procedure LOGO2Click(Sender: TObject);
    procedure LOGO3Click(Sender: TObject);
    procedure N151Click(Sender: TObject);
    procedure N152Click(Sender: TObject);
    procedure N154Click(Sender: TObject);
    procedure N133Click(Sender: TObject);
    procedure Intenet1Click(Sender: TObject);
    procedure N136Click(Sender: TObject);
    procedure N191Click(Sender: TObject);
    procedure N157Click(Sender: TObject);
    procedure N159Click(Sender: TObject);
    procedure N160Click(Sender: TObject);
    procedure N162Click(Sender: TObject);
    procedure N164Click(Sender: TObject);
    procedure N165Click(Sender: TObject);
    procedure N166Click(Sender: TObject);
    procedure N168Click(Sender: TObject);
    procedure N170Click(Sender: TObject);
    procedure N172Click(Sender: TObject);
    procedure N174Click(Sender: TObject);
    procedure N193Click(Sender: TObject);
    procedure N194Click(Sender: TObject);
    procedure N195Click(Sender: TObject);
    procedure N196Click(Sender: TObject);
    procedure N197Click(Sender: TObject);
    procedure N198Click(Sender: TObject);
    procedure N199Click(Sender: TObject);
    procedure N200Click(Sender: TObject);
    procedure N201Click(Sender: TObject);
    procedure N202Click(Sender: TObject);
    procedure N204Click(Sender: TObject);
    procedure Cache1Click(Sender: TObject);
    procedure Cookies1Click(Sender: TObject);
    procedure N206Click(Sender: TObject);
    procedure N207Click(Sender: TObject);
    procedure N209Click(Sender: TObject);
    procedure N179Click(Sender: TObject);
    procedure N180Click(Sender: TObject);
    procedure N182Click(Sender: TObject);
    procedure N183Click(Sender: TObject);
    procedure N186Click(Sender: TObject);
    procedure N187Click(Sender: TObject);
    procedure N190Click(Sender: TObject);
    procedure ddd1Click(Sender: TObject);
    procedure ddd2Click(Sender: TObject);
    procedure ddd3Click(Sender: TObject);
    procedure N73Click(Sender: TObject);
    procedure N56Click(Sender: TObject);
    procedure G1Click(Sender: TObject);
    procedure L1Click(Sender: TObject);
    procedure M1Click(Sender: TObject);
    procedure S1Click(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure N502Click(Sender: TObject);
    procedure N752Click(Sender: TObject);
    procedure N1003Click(Sender: TObject);
    procedure N1252Click(Sender: TObject);
    procedure N1503Click(Sender: TObject);
    procedure N2003Click(Sender: TObject);
    procedure N601Click(Sender: TObject);
    procedure Action_AlexaExExecute(Sender: TObject);
    procedure NGOClick(Sender: TObject);
    procedure NGOSearchClick(Sender: TObject);
    procedure NGetClipbrdGoClick(Sender: TObject);
    procedure Action_Test1Execute(Sender: TObject);
    procedure NOnlyOneClick(Sender: TObject);
    procedure ToolBarAddressResize(Sender: TObject);
    procedure ToolBarBGOCustomDraw(Sender: TToolBar; const ARect: TRect;
      var DefaultDraw: Boolean);
    procedure ToolBarBGOCustomDrawButton(Sender: TToolBar;
      Button: TToolButton; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure ToolBarSearchEditCustomDraw(Sender: TToolBar;
      const ARect: TRect; var DefaultDraw: Boolean);
    procedure ToolBarSearchButtonCustomDraw(Sender: TToolBar;
      const ARect: TRect; var DefaultDraw: Boolean);
    procedure CBURLClick(Sender: TObject);
    procedure CBURLKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToolButtonSearchClick(Sender: TObject);
    procedure ComboBoxSearchChange(Sender: TObject);
    procedure ComboBoxSearchClick(Sender: TObject);
    procedure ComboBoxSearchKeyPress(Sender: TObject; var Key: Char);
    procedure BBGOMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolBarSearchEditMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BBGOClick(Sender: TObject);
    procedure ToolBarSearchButtonCustomDrawButton(Sender: TToolBar;
      Button: TToolButton; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure NCleanAllNewlyClick(Sender: TObject);
    procedure NGetClipbrdSearchClick(Sender: TObject);
    procedure ActionFullFormExecute(Sender: TObject);
    procedure ActionSaveFormExecute(Sender: TObject);
    procedure ToolBarMenuCustomDrawButton(Sender: TToolBar;
      Button: TToolButton; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure Timer_SearchCTimer(Sender: TObject);
    procedure ActionCleanHistoryExecute(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure NTVListRefreshClick(Sender: TObject);
    procedure NTVListEditClick(Sender: TObject);
    procedure ListBoxTVDblClick(Sender: TObject);
    procedure ActionClearLastNewlyExecute(Sender: TObject);
    procedure ActionCloseCurrentNoNewlyExecute(Sender: TObject);
    procedure PaintPanelControlPaint(Sender: TObject);
    procedure PaintPanelMenuPaint(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure ToolBarControlCustomDraw(Sender: TToolBar;
      const ARect: TRect; var DefaultDraw: Boolean);
    procedure ToolBarControlCustomDrawButton(Sender: TToolBar;
      Button: TToolButton; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure ToolBarStatusBarPaint(Sender: TObject);
    procedure ToolButtonCloseClick(Sender: TObject);
    procedure ToolButtonWindowStateClick(Sender: TObject);
    procedure ToolButtonMinimizeClick(Sender: TObject);
    procedure ToolBarMenuDblClick(Sender: TObject);
    procedure ToolBarMenuMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolBarAddressMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TBTabNewClick(Sender: TObject);
    procedure Panel_StatusBar3Click(Sender: TObject);
    procedure TBTabNewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToolBarButtonCustomDrawButton(Sender: TToolBar;
      Button: TToolButton; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure TBRefreshMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure NShowMenu2Click(Sender: TObject);
    procedure ToolBarLeftTopControlCustomDrawButton(Sender: TToolBar;
      Button: TToolButton; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure WB1_ScriptError(Sender: TObject; ErrorLine, ErrorCharacter,
      ErrorCode, ErrorMessage, ErrorUrl: String; var ContinueScript,
      Showdialog: Boolean);
    procedure WB1_2NewWindow2(Sender: TObject; var ppDisp: IDispatch;
      var Cancel: WordBool);
    procedure wb_ClickScriptError(Sender: TObject; ErrorLine,
      ErrorCharacter, ErrorCode, ErrorMessage, ErrorUrl: String;
      var ContinueScript, Showdialog: Boolean);
    procedure ToolBarMenu2CustomDraw(Sender: TToolBar; const ARect: TRect;
      var DefaultDraw: Boolean);
    procedure ToolBarMenu2CustomDrawButton(Sender: TToolBar;
      Button: TToolButton; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure PaintPanelMenu2Paint(Sender: TObject);
    procedure PaintPanelBlankPaint(Sender: TObject);
    {$ENDIF}
    //procedure MeasureMainItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
    //procedure DrawMainItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
    //mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
  protected
    { protected declarations }
    function DragEnter(const dataObj: IDataObject; grfKeyState: Longint;
      pt: TPoint; var dwEffect: Longint): HResult; stdcall;
    function DragOver(grfKeyState: Longint; pt: TPoint;
      var dwEffect: Longint): HResult; stdcall;
    function DragLeave: HResult; stdcall;
    function Drop(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint;
      var dwEffect: Longint): HResult; stdcall;
  private
    { Private declarations }
    DocRollInt: Integer;
    MusicNamePub: string; //保存所播放歌曲的名字
    procedure WMNCActivate(var Message: TWMNCActivate); message WM_NCACTIVATE;
    procedure WMNCPAINT(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMNCCALCSIZE(var Message: TWMNCCALCSIZE); message WM_NCCALCSIZE;
    procedure WMSetText(var Message: TWMSetText); message WM_SETTEXT;

    //procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    //procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    //procedure AddHotKey;  //向系统中注册全局热键
    procedure HotKey(var Msg:TMessage); Message WM_HOTKEY; //截取系统中热键信息
    //procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
    //procedure WMQueryEndSession({var Message: TMessage}var Msg: TWMQUERYENDSESSION); message WM_QUERYENDSESSION;
    {$IFDEF ATSAMEON}
    //打开新页面
    procedure WMFoundHe(var Msg: TMessage); message WM_FOUNDHE;
    procedure WMOpenPage(var Msg: TMessage); message WM_OPENPAGE;
    procedure CreateParams(var Params: TCreateParams); override;
    {$ELSE}
    //托盘图标被单击的事件处理
    procedure IconClick(var Msg:TMessage);message WM_USER+1;
    {$ENDIF}
    {$IFDEF InstallOn}
    procedure InstallOn();
    {$ENDIF}
    procedure PlayMusic(MusicName:string);
    procedure PlayRandom;
    procedure PlayUp;
    procedure PlayDown;
    procedure PlayError;
    procedure SetBrowser(flag:integer=0); //设置某个浏览器为默认浏览器
    //procedure dragdropfile(var msg :  tmessage);message wm_dropfiles;
    function EnabledOpenExt(FileName: String): Boolean;
    procedure SearchColor;
    procedure UpdateTypedUrls{(Url: string)};
    //procedure TargetToProcess;
  public
    { Public declarations }
    //procedure InterfaceRepaint;
    //procedure NavigateInit;
    procedure NavigateInit2;
    procedure LoadMusicList(Path:string);
    //procedure DrawButtonIcon;
    procedure AllClose(Sender: TObject);
    procedure AllRefresh(Sender: TObject);

    procedure AddHotKey;  //向系统中注册全局热键
    procedure CheckLastOpen(Sender: TObject);
    procedure Mymessage(var t:TWmCopyData);message WM_COPYDATA;
    //procedure WMQueryEndSession(var Message: TMessage); message WM_QUERYENDSESSION;
  end;

var
  FormMain: TFormMain;
  FImageButton: array of TImage;
  FImageButton1: array of TImage;
  FImageButton2: array of TImage;
  FImageButton3: array of TImage;
  //程序启动时候检查本身是否已经运行
  Hnd:THandle;
  //OldParamS:string; //传递给程序的参数

implementation

uses var_, const_, UnitPublic, UnitSet, Public, UnitWebBrowser, KillAd, GetPathUnit, UnitWmp, UnitHintShow, UnitAutoHint,
  UnitUpdate;

{$R *.dfm}

{
procedure TFormMain.InterfaceRepaint;
begin
try
  ToolBarStatusBar.Repaint;
except end;
end;
}

procedure TFormMain.Mymessage(var t: TWmCopyData);
var
  Url: String;
begin
try
  //ShowMessage(StrPas(t.CopyDataStruct^.lpData));
    {
    if not Self.Visible then
    begin
      ShowWindow(Application.Handle, SW_HIDE);
      SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_OVERLAPPEDWINDOW);      ShowWindow(Application.Handle, SW_SHOW);
      Self.Visible:=true;
      SetForegroundWindow(handle);
      ApplicationEvents1.Activate;
      SetForm.TimerStatusBar.Enabled:=true;
      FormPublic.DocumentSetFocus;
    end
    else
    if WindowStateI=2 then
    begin
      Application.Restore;
      SetForegroundWindow(handle);
      ApplicationEvents1.Activate;
      WindowStateI:=0;
      SetForm.TimerStatusBar.Enabled:=true;
      FormPublic.DocumentSetFocus;
    end;
    }

  Url := StrPas(t.CopyDataStruct^.lpData);

  if Url = CloseMsg then
  begin
    Close;
    exit;
  end;
  if Url = APPNAME then
  begin
    if WindowStateI=2 then
    begin
      Application.Restore;
      SetForegroundWindow(handle);
      ApplicationEvents1.Activate;
      WindowStateI:=0;
      SetForm.TimerStatusBar.Enabled:=true;
      FormPublic.DocumentSetFocus;
    end
    else
    if not Self.Visible then
    begin
      ShowWindow(Application.Handle, SW_HIDE);
      SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_OVERLAPPEDWINDOW);      ShowWindow(Application.Handle, SW_SHOW);
      Self.Visible:=true;
      SetForegroundWindow(handle);
      ApplicationEvents1.Activate;
      SetForm.TimerStatusBar.Enabled:=true;
      FormPublic.DocumentSetFocus;
    end;
  end;
  if (Trim(Url)<>'') then
  if (LowerCase(Copy(Url,1,7))='http://')
  or (LowerCase(Copy(Url,1,8))='https://')
  or (LowerCase(Copy(Url,1,7))='file://')
  or (Pos('.htm',LowerCase(Url))>0)
  or (Pos('.html',LowerCase(Url))>0)
  or (LowerCase(Copy(Url,1,6))='ftp://')
  or (LowerCase(Copy(Url,1,4))='www.') then
  begin     //ShowMessage(Url); exit;
    //if Trim(Url)+'#'=Trim(OldParamS) then exit;
    //NAddNewBlank.Click;
    //exit;
    CBURL.Text:=Trim(Url);
    BBGO.Click;
    Url := '';
    //OldParamS:=Trim(Url)+'#';
  end;
except end;
end;

{
procedure TFormMain.NavigateInit;
var
  Res:TReSourceStream;
  MemStream:TMemoryStream;
  //FileStream:TFileStream;
begin
try
  if not EnabledInitPage then exit;
  case StartPageTo of
    2, 99: if (Trim(OpenToUrl) <> '') then exit;
  end;

  if InitUrl <> '' then
  begin
  TFormWebBrowser(wbList[0]).WebUrl := InitUrl;
  TFormWebBrowser(wbList[0]).WebBrowser.Hint := InitUrl;
  TFormWebBrowser(wbList[0]).WebBrowser.Navigate(InitUrl);
  end
  else
  begin
  Res:=TResourceStream.Create(Hinstance,'init_htm',PChar('htm'));
  MemStream:=TMemoryStream.Create;
  try
  MemStream.LoadFromStream(Res);

  TFormWebBrowser(wbList[0]).WebUrl := 'init';
  TFormWebBrowser(wbList[0]).WebBrowser.Hint := 'init';
  TFormWebBrowser(wbList[0]).WebBrowser.LoadFromStream(MemStream);
  finally
    Res.Free;
    MemStream.free;
  end;
  end;
except end;
end;
}

procedure TFormMain.NavigateInit2;
//{
var
  Res:TReSourceStream;
  MemStream:TMemoryStream;
//}
begin
try
  //WBInitPage.Go(UserCount);
  //{
  if not NeedUseCount then exit;
  Res:=TResourceStream.Create(Hinstance,'init2_htm',PChar('htm'));
  MemStream:=TMemoryStream.Create;
  try
  MemStream.LoadFromStream(Res);
  WBInitPage.LoadFromStream(MemStream);
  WBInitPage.HandleNeeded;
  finally
    Res.Free;
    MemStream.free;
  end;
  //}
except end;
end;

procedure TFormMain.AllClose(Sender: TObject);
var
  i: Integer;
begin
try
  try
  if wbList.Count <= 0 then exit;
  //AllCloseIng := true;
  //if ShowCloseHint then ToolBarTabClose.Visible := false;
  for i := wbList.Count - 1 downto 1 do
  begin
    TFormWebBrowser(wbList[i]).Closeing := true;    TFormWebBrowser(wbList[i]).Free;    FormMain.ToolBarTabParent.Buttons[i].Free;    wbList.Delete(i);  end;
  TFormWebBrowser(wbList[0]).WebBrowser.Hint := '';
  TFormWebBrowser(wbList[0]).WebUrl := 'about:blank';
  TFormWebBrowser(wbList[0]).WebBrowser.Navigate('about:blank');
  FormPublic.TabClick2(0);
  if (ProBar<>nil) then
  begin
    ProBar.Position := 0;
    ProBar.Visible := false;
    //LabelPro.Visible := false;
  end;
  FormMain.ToolBarTabParent.Indent :=  0;

  finally
    FormPublic.TabAutoWidthControl;
    //if ShowCloseHint then FormPublic.TabCloseHint;
    //AllCloseIng := false;
  end;
except
  //AllCloseIng := false;
end;
end;

procedure TFormMain.AllRefresh(Sender: TObject);
var
  i: integer;
begin
try
  if wbList.Count <= 0 then exit;
  //if ShowCloseHint then ToolBarTabClose.Visible := false;
  for i := wbList.Count - 1 downto 1 do
  begin
    TFormWebBrowser(wbList[i]).WebBrowser.Refresh;  end;
except end;
end;

procedure TFormMain.CheckLastOpen(Sender: TObject);
var
  LastTimeURLList: TStringList;
begin
try
  if not LoadLastTime then exit;
  if not FileExists(MyDir+OpenURLListFile2) then exit;
  //if OpenToUrl = '' then OpenToUrl := InitUrl;
  //PageIndex := wbList.Count - 1;
  LastTimeURLList:=TStringList.Create;
  try
  LastTimeURLList.LoadFromFile(MyDir+OpenURLListFile2);  //MessageBox(0, InitUrl, PChar(LastTimeURLList[0]), 0);
  if LastTimeURLList.Count >= 1 then
  begin
    if LastTimeURLList.Count = 1 then
    begin              
      if (Pos('/' + DataDir + '/' + LastOpenLoadFile, LastTimeURLList[0]) <> 0) or (Pos(OpenToUrl, LastTimeURLList[0]) <> 0) then
      begin
        exit;
      end;
    end;

    if (TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl <> 'about:blank') or (TFormWebBrowser(wbList[PageIndex]).WebBrowser.Busy) then ToolButtonTabNew.Click;

    LoadLastOpenI := PageIndex;
    TFormWebBrowser(wbList[PageIndex]).WebBrowser.Tag := LastUnCloseFlag;
    TFormWebBrowser(wbList[PageIndex]).WebBrowser.Navigate(MyDir + DataDir + '\' + LastOpenLoadFile);
    //TFormWebBrowser(wbList[PageIndex]).WebBrowser.Navigate('http://www.aijisu.com/test/lastunclose.htm');
    TFormWebBrowser(wbList[PageIndex]).WebUrl := BrowserName + '://Data/' + LastOpenLoadFile;
    CBUrl.Text := BrowserName + '://Data/' + LastOpenLoadFile;
  end;
  finally
    LastTimeURLList.Free;
  end;
except end;
end;

{
//调整主菜单项尺寸
procedure TFormMain.MeasureMainItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
begin
try
  Width := Width + 6;
  Height := Height + 2;
except end;
end;

//绘制主菜单内容
procedure TFormMain.DrawMainItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
const
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
  if (odGrayed in State) and not(TMenuItem(Sender).IsLine) then
  begin
    BrushColor := SubMenuGrayedBackColor;

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
  //绘制图片
  ImageList := TMenuItem(Sender).GetImageList;
  ImageList := FormPublic.ImageListOther;
  if ImageList<>nil then
    if (odSelected in State) and not(odGrayed in State) then
      ImageList.Draw(ACanvas, ARect.left+2, ARect.Top+2, TMenuItem(Sender).ImageIndex)
    else
      ImageList.Draw(ACanvas, ARect.left+3, ARect.Top+3,
               TMenuItem(Sender).ImageIndex, TMenuItem(Sender).Enabled);
except end;
end;
}

//====
function TFormMain.DragEnter(const dataObj: IDataObject; grfKeyState: Longint;
  pt: TPoint; var dwEffect: Longint): HResult;
begin
  P := pt;
  Result  := S_OK;
end;

function TFormMain.DragOver(grfKeyState: Longint; pt: TPoint;
  var dwEffect: Longint): HResult;
begin
  Result := S_OK;
end;

function TFormMain.DragLeave: HResult;
begin
  Result := S_OK;
end;

function TFormMain.Drop(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint;
  var dwEffect: Longint): HResult;
var
  FormatEtc: TFormatEtc;
  StgMedium: TStgMedium ;
  Data: PChar;
  Text: string;
  i:integer;
  Chinese:Boolean;
  Url: string;

  hr: HRESULT;
  Nfiles: integer;
  Ext: String;
  J: Integer;
  FFileName: array[0..MAX_PATH] of Char;
begin
try

  Chinese:=false;
  if (dwEffect > DROPEFFECT_NONE) and Assigned(dataObj) then
  begin
    FormatEtc.cfFormat := CF_TEXT;
    FormatEtc.ptd := nil;
    FormatEtc.dwAspect := DVASPECT_CONTENT;
    FormatEtc.lindex := -1;
    FormatEtc.tymed := TYMED_HGLOBAL;
    if dataobj.QueryGetData(FormatEtc) = S_OK then
    begin
      OleCheck(dataObj.GetData(FormatEtc, StgMedium));
      try
        Data := GlobalLock(StgMedium.hGlobal);
        Text := Data;

        for I:=0 to length(Text)-1 do
        if ByteType(Text,i)=mbLeadByte then Chinese:=true;
        //if (ord(Text[i])>=127) then Chinese:=true;  //if (ord(s)>=33)and(ord(s)<=126) then e
        if not Chinese then
        begin
          if (LowerCase(Copy(Text,1,7))='http://')
          or (LowerCase(Copy(Text,1,8))='https://')
          or (LowerCase(Copy(Text,1,7))='file://')
          or (LowerCase(Copy(Text,1,6))='ftp://')
          or (LowerCase(Copy(Text,1,4))='www.')
          //or (Pos('.com',LowerCase(Text))=Length(Text)-3) then
          or (Pos('.',LowerCase(Text))>0) then
          begin
            //if (Pos('.',Text)<>0) then   fff
            if (LowerCase(Copy(Text,1,4))='www.') then
            Url := 'http://' + Text
            else
            Url := Text;
            if pt.X < P.X - 10 then  //向左手
            FormPublic.NewPage(PageIndex + 1, Url, True, false)
            else if pt.X > P.X + 10 then //右
            FormPublic.NewPage(PageIndex + 1, Url, false, false)
            else
            FormPublic.NewPage(PageIndex + 1, Url, false, false);
          end
          else
          begin
            {
            FormMain.CBURL.Text:=Text;
            BBGO.Click;
            }
            ComboBoxSearch.Text:=Text;
            ButtonSearch.Click;
          end;
        end
        else
        begin
          {
          FormMain.CBURL.Text:=Text;
          BBGO.Click;
          }
          ComboBoxSearch.Text:=Text;
          ButtonSearch.Click;
        end;
      finally
        GlobalUnlock(StgMedium.hGlobal);
        ReleaseStgMedium(StgMedium);
      end;
    end
    else
    begin
//
  with FormatEtc do
  begin
    cfFormat := CF_HDROP;
    ptd := nil;
    dwAspect := DVASPECT_CONTENT;
    lindex := -1;
    tymed := TYMED_HGLOBAL;
  end;
  hr := dataobj.GetData(FormatEtc, StgMedium);
  if Failed(hr) then Exit;
  //将所有被拖放的文件写到指定文件中
  NFiles:=DragQueryFile(StgMedium.hGlobal, $FFFFFFFF, nil, 0);
  //ShowMessage(IntToStr(NFiles)); exit;
  J := 0;
  for i:=0 to nfiles-1 do
  begin
    // 读取拖放文件列表，并将文件名记录下来
    DragQueryFile(StgMedium.hGlobal, i, FFileName , SizeOf(FFilename));
    // 如果拖放对象是一个目录，就记录目录名
    //if GetFileAttributes(FFilename)=faDirectory then writeln (f,'Folder -> '+ffilename);
    if GetFileAttributes(FFilename)=faDirectory then
    begin
      if (TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationURL <> '') and (TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationURL <> 'about:blank') then
      ToolButtonTabNew.Click;
      TFormWebBrowser(wbList[PageIndex]).WebBrowser.Hint := ':file';
      TFormWebBrowser(wbList[PageIndex]).WebBrowser.Go('file://' + FFilename);  //exit;
      Continue;
    end;
    //ShowMessage(FFileName);
    {
    Ext := LowerCase(ExtractFileExt(FFileName));
    if (Ext = '.htm') or (Ext = '.html') or (Ext = '.mht') or (Ext = '.bmp') or (Ext = '.jpg') or (Ext = '.gif') or (Ext = '.txt') or (Ext = '.ini') or (Ext = '.pas') then
    }
    if EnabledOpenExt(FFileName) then
    begin
      {
      Inc(J);
      if J = 1 then TFormWebBrowser(wbList[PageIndex]).WebBrowser.Navigate(FFileName)
      else FormPublic.NewPage(PageIndex + 1, FFileName, false);
      }
      //{
      if (pt.X < P.X - 10) or (pt.Y > P.Y + 10) then  //向左手
      begin   //ShowMessage(ImgSaveDir); exit;
        //ImgSaveDir  //TempDir + ImgDir
        if Trim((ImgSaveDir)) = '' then ImgSaveDir := TempDir + ImgDir;
        if not DirectoryExists(ImgSaveDir) then
        begin
          MkDir(ImgSaveDir); //exit;   ShowMessage(ImgSaveDir + ExtractFileName(FFileName)); exit;
          if not DirectoryExists(ImgSaveDir) then
          begin
            ImgSaveDir := TempDir + ImgDir;
            if not DirectoryExists(ImgSaveDir) then MkDir(ImgSaveDir);
          end;
        end;
        CopyFile(FFileName, PChar(ImgSaveDir + ExtractFileName(FFileName)), False);
      end
      else
      begin
        if (TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationURL <> '') and (TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationURL <> 'about:blank') then
        //ToolButtonTabNew.Click;
        FormPublic.NewPage(PageIndex + 1, FFileName, true, false)
        else TFormWebBrowser(wbList[PageIndex]).WebBrowser.Navigate(FFileName);
      end;
      //}
    end;
  end;
//
    end;
  end;
  Result := S_OK;
except end;
end;
//====

procedure TFormMain.WMNCPAINT(var Message: TWMNCPaint);
var
  Canvas: TCanvas;
begin
try
  Canvas := TCanvas.Create;
  Canvas.Handle := GetWindowDC(Handle);
  try
    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Color := TColor($808080);  //$808080
    Canvas.Rectangle(0, 0, Width, Height);
  finally
    ReleaseDC(Handle, Canvas.Handle);
    Canvas.Free;
  end;
except end;
end;

procedure TFormMain.WMNCCALCSIZE(var Message: TWMNCCALCSIZE);
begin
try
  with Message.CalcSize_Params^.rgrc[0] do
  begin
    Inc(Top);
    Dec(Bottom);
    Inc(Left);
    Dec(Right);
  end;
except end;
end;

//{
procedure TFormMain.WMNCActivate(var Message: TWMNCActivate);
var
  Canvas: TCanvas;
begin
try
  //if WindowState = wsNormal then
  Message.Result := 1;
  //if WindowState = wsNormal then
  //begin
  //inherited;
  Canvas := TCanvas.Create;
  Canvas.Handle := GetWindowDC(Handle);
  try
    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Color := TColor($808080);  //$808080
    Canvas.Rectangle(0, 0, Width, Height);
  finally
    ReleaseDC(Handle, Canvas.Handle);
    Canvas.Free;
  end;
  //end;
except end;
end;
//}

//var
  //FCaption: string;
procedure TFormMain.WMSetText(var Message: TWMSetText);
begin
try
  //inherited;
  //ToolBarControl.repaint;
  FCaption := Message.Text;
  //重画标题栏，把标题栏中DrawText中的PChar(Caption)改为PChar(FCaption)
except end;
end;

//{
procedure TFormMain.AddHotKey;
var
  id1,id2{,id3}:integer;

  Shift: TShiftState;
  //Key: Word;
  //Modifiers: Integer;
  //BossKeyShift: TShiftState;
begin
try
  try
  //ShowMessage(BossKey); exit;
  id1:=GlobalAddAtom('hotkey1');
  //RegisterHotKey(Self.Handle,id1,MOD_Control,89);    //y 窗体显示/隐藏

  Menus.ShortCutToKey({Hotkey1.HotKey}TextToShortCut(BossKey), {Key}BossKeyKey, Shift);  //ShowMessage(IntToStr(Key)); exit;
  {
  if Shift = [ssCtrl] then
    Modifiers := MOD_CONTROL else
  if Shift = [ssShift] then
    Modifiers := MOD_SHIFT else
  if Shift = [ssAlt] then
    Modifiers := MOD_ALT
  else
  }
  Modifiers := 0;
  if ssAlt in Shift then Modifiers := Modifiers or MOD_ALT;
  if ssCtrl in Shift then Modifiers := Modifiers or MOD_Control;
  if ssShift in Shift then Modifiers := Modifiers or MOD_SHIFT;

  RegisterHotKey(Self.Handle,id1,Modifiers,{Key}BossKeyKey);

  id2:=GlobalAddAtom('hotkey2');
  RegisterHotKey(Self.Handle,id2,MOD_Control,75);    //K 快速退出-不保存
  {
  id3:=GlobalAddAtom('hotkey3');
  RegisterHotKey(Self.Handle,id3,MOD_Control,89);    //y 窗体显示/隐藏
  }
  {
  id3:=GlobalAddAtom('hotkey3');
  RegisterHotKey(Self.Handle,id3,MOD_Control,79);    //O 歌曲播放
  id4:=GlobalAddAtom('hotkey4');
  RegisterHotKey(Self.Handle,id4,MOD_Control,83);    //S 歌曲停止播放
  id5:=GlobalAddAtom('hotkey5');
  RegisterHotKey(Self.Handle,id5,MOD_Control,78);    //N 歌曲播放下一曲
  id6:=GlobalAddAtom('hotkey6');
  RegisterHotKey(Self.Handle,id6,MOD_Control,80);    //P 歌曲播放上一首
  }
  {
  id:=GlobalAddAtom('hotkey2');
  RegisterHotKey(Self.handle,id,mod_control,75);   //y 窗体显示/隐藏
  }
  finally
    //RegisterHotKey(Handle,{HotKeyId}0,MOD_Control,78); //CTRL+N-Create new blank page.
    RegisterHotKey(Handle,1,MOD_CONTROL or MOD_Alt,89); //CTRL+ALT+Y
    RegisterHotKey(Handle,2,MOD_CONTROL or MOD_Alt,75); //CTRL+ALT+K

    RegisterHotKey(Handle,3,MOD_CONTROL or MOD_Alt,79); //CTRL+ALT+O
    RegisterHotKey(Handle,4,MOD_CONTROL or MOD_Alt,83); //CTRL+ALT+S
    RegisterHotKey(Handle,5,MOD_CONTROL or MOD_Alt,78); //CTRL+ALT+N
    RegisterHotKey(Handle,6,MOD_CONTROL or MOD_Alt,80); //CTRL+ALT+P
  end;
  {
  ((Message.LParamLo = MOD_CONTROL) and (Shift = [ssCtrl]) or
  (Message.LParamLo = MOD_ALT) and (Shift = [ssAlt]) or
  (Message.LParamLo = MOD_SHIFT) and (Shift = [ssShift]))
  RegisterHotKey(Handle,IDHOT_SNAPWINDOW,MOD_SHIFT or MOD_CONTROL,$41); //Shift+Ctrl+a
  RegisterHotKey(handle,ID,MOD_CONTROL+MOD_Alt,VK_F3);  //Ctrl+Alt+F3
  }
except end;
end;

procedure TFormMain.HotKey(var Msg:TMessage);
begin
try
  try
  {
  //ALT+F "文件"
  if ((Msg.LParamLo=MOD_ALT) and (Msg.LParamHi=70)) then
  begin     //ShowMessage('ALT+F');
    SendMessage(NFile.Handle,BM_Click,0,0);
    //SendMessage(NFile.Handle,BM_Click,0,0);
    //NFile.SetSubComponent(true);
    //NFile.Default:=true;
    //NFile.Click;  NFile.Click;
    //ShowMessage('ALT+F');
    exit;
  end;
  }
  {
  //ALT+N "add new blankpage"
  if ((Msg.LParamLo=MOD_CONTROL) and (Msg.LParamHi=78)) then
  begin
    NAddNewBlank.Click;  
    exit;
  end;
  }
  //快速退出程序-不保存
  //CLTR+K
  if ((Msg.LParamLo=MOD_CONTROL) and (Msg.LParamHi=75)) then
  begin
    //ShowCloseHint := false;
    Self.Hide;
    FormPublic.NPopupExit.Enabled := false;
    Close; //Application.Terminate;
    //if InstallTrayIcon then InstallIcon(false,Self.Handle,Self.Icon.Handle,TitleStr);
    //Halt;
    {
    if Self.PageControl.PageCount=0 then
    begin
      if FileExists(MyDir+OpenURLListFile) then DeleteFile(MyDir+OpenURLListFile);
      if FileExists(MyDir+OpenURLListFile2) then DeleteFile(MyDir+OpenURLListFile2);
    end
    else OpenURLListSave(2);
    }
    exit;
  end;
  //CTRL+ALT+K
  if ((Msg.LParamLo=MOD_CONTROL or MOD_ALT) and (Msg.LParamHi=75)) then
  begin
    //ShowCloseHint := false;
    Self.Hide;
    FormPublic.NPopupExit.Enabled := false;
    Close; //Application.Terminate;
    //if InstallTrayIcon then InstallIcon(false,Self.Handle,Self.Icon.Handle,TitleStr);
    //Halt;
    {
    if Self.PageControl.PageCount=0 then
    begin
      if FileExists(MyDir+OpenURLListFile) then DeleteFile(MyDir+OpenURLListFile);
      if FileExists(MyDir+OpenURLListFile2) then DeleteFile(MyDir+OpenURLListFile2);
    end
    else OpenURLListSave(2);
    }
    exit;
  end;
  //界面显示/隐藏y
  //CTRL+Y
  if ((Msg.LParamLo=Modifiers) and (Msg.LParamHi=BossKeyKey)) {or ((Msg.LParamLo=MOD_CONTROL) and (Msg.LParamHi=89))} then
  //or ((Msg.LParamLo=MOD_CONTROL) and (Msg.LParamHi=72)) then
  begin
    try
    if FormMain.Visible=true then
    begin
      //{
      if WindowStateI=2 then
      begin
        Application.Restore;
        SetForegroundWindow(Handle);
        ApplicationEvents1.Activate;
        SetForm.TimerStatusBar.Enabled:=true;
        FormPublic.DocumentSetFocus;
        exit;
      end;
      //}  //kokokk
      FormPublic.AllFormHide(0);
      ShowWindow(Application.Handle, SW_HIDE);
      SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW);
      ShowWindow(Application.Handle, SW_SHOW);
      FormMain.Hide;
      //if SetForm.RBInstallTrayIconON.Checked then
      InstallIcon(false,Self.Handle,Application.Icon.Handle,TitleStr);
      SetForm.TimerStatusBar.Enabled:=false;
      //if (SetForm.SBStop_Play.Enabled) and (SetForm.SBStop_Play.Caption='停止播放') then SetForm.SBStop_Play.Click;
      if (wmp.playState = 3) then wmp.Controls.Stop;
    end
    else
    begin
      FormMain.Show;
      ShowWindow(Application.Handle, SW_HIDE);
      SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_OVERLAPPEDWINDOW);      ShowWindow(Application.Handle, SW_SHOW);
      SetForegroundWindow(handle);
      if InstallTrayIcon then
      InstallIcon(true,Self.Handle,Application.Icon.Handle,TitleStr);
      ApplicationEvents1.Activate;
      SetForm.TimerStatusBar.Enabled:=true;
      FormPublic.DocumentSetFocus;
      //ListForm.Show;
    end;
    finally
    FormPublic.ClearMemory;
    end;
  end;
  //==>
  //CTRL+ALT+Y
  if ((Msg.LParamLo=MOD_CONTROL or MOD_ALT) and (Msg.LParamHi=89)) then
  //or ((Msg.LParamLo=MOD_CONTROL) and (Msg.LParamHi=72)) then
  begin
    try
    if FormMain.Visible=true then
    begin
      //{
      if WindowStateI=2 then
      begin
        Application.Restore;
        SetForegroundWindow(Handle);
        ApplicationEvents1.Activate;
        SetForm.TimerStatusBar.Enabled:=true;
        exit;
      end;
      //}  //kokokk
      FormPublic.AllFormHide(0);
      FormMain.Hide;
      if InstallTrayIcon then
      InstallIcon(false,Self.Handle,Application.Icon.Handle,TitleStr);
      SetForm.TimerStatusBar.Enabled:=false;
      if (wmp.playState = 3) then wmp.Controls.Stop;
    end
    else
    begin
      FormMain.Show;
      SetForegroundWindow(handle);
      if InstallTrayIcon then
      InstallIcon(true,Self.Handle,Application.Icon.Handle,TitleStr);
      ApplicationEvents1.Activate;
      SetForm.TimerStatusBar.Enabled:=true;
      //ListForm.Show;
    end;
    finally
    FormPublic.ClearMemory;
    end;
    //==-<
  end;

  //CTRL+ALT+O 歌曲播放
  if ((Msg.LParamLo=MOD_CONTROL or MOD_ALT) and (Msg.LParamHi=79)) then
  begin
    if (wmp.playState = 2) {or (MediaPlayer.Mode=mpStopped)} then
    begin
      wmp.Controls.Play;     //kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
      exit;
    end;
    if FormMain.ListBoxMusicList.Count<=0 then exit;
    if ListBoxMusicList.ItemIndex<0 then ListBoxMusicList.ItemIndex:=0;
    if MusicPlayType = 0 then
    begin
      FileName:=ListBoxMusicList.Items.Strings[ListBoxMusicList.itemIndex];
      if TimerPlayer.Enabled then TimerPlayer.Enabled := false;
      wmp.Url := FileName;
      TimerPlayer.Interval := 5000;
      TimerPlayer.Enabled := true;
    end
    else
    PlayMusic(ListBoxMusicList.Items.Strings[ListBoxMusicList.itemIndex]);
    exit;
  end;
  //CTRL+ALT+S
  if ((Msg.LParamLo=MOD_CONTROL or MOD_ALT) and (Msg.LParamHi=83)) then
  begin
    case MusicPlayType of
    0:
    begin
      if not TimerPlayer.Enabled then wmp.Controls.Stop
      else
      if (wmp.playState = 3) then wmp.Controls.Pause else wmp.Controls.Stop;
    end;
    1:if (MediaPlayer.Mode=mpPlaying) then SBStop.Click;
    end;
    exit;
  end;
  //CTRL+ALT+N
  if ((Msg.LParamLo=MOD_CONTROL or MOD_ALT) and (Msg.LParamHi=78)) then
  begin
    PlayDown;
    exit;
  end;

  //CTRL+ALT+P
  if ((Msg.LParamLo=MOD_CONTROL or MOD_ALT) and (Msg.LParamHi=80)) then
  begin
    PlayUp;
    exit;
  end;
  exit;
  finally
    inherited;
  end;
except end;
end;

{
procedure TFormMain.WMSysCommand(var Message: TWMSysCommand);
begin
try
  try
  .WindowState = wsMaximized then
  if (Message.WParam = SC_MINIMIZE)Or(Message.WParam=Sc_Close) then halt;

  if (Message.cmdtype=SC_MINIMIZE) then halt;

  //if Message.WParam = SC_ICON then  halt;

  case Message.CmdType of
    SC_Maxmized: Halt;
    else ;
  end;

  with Message do
  begin
    if (WindowState = wsMinimized) then
    begin     halt;
      ImageGoBack.Refresh;
      ImageGoForward.Refresh;
    end;
  end;
  finally
    inherited;
  end;
except end;
end;
}

{
procedure TFormMain.WMQueryEndSession(///var Message: TMessage///var Msg: TWMQUERYENDSESSION);
begin
try
  //msg.Result:=0;
  //ShowMessage('ok');
  msg.Result := Integer(TRUE);  
  FormMain.Close;
  inherited;
except end;
end;
}

{$IFDEF ATSAMEON}
procedure TFormMain.WMFoundHe(var Msg: TMessage);
begin
try
  try
  Msg.Result := APPTAG;
  finally
    //inherited;
  end;
except end;
end;

//{
procedure TFormMain.WMOpenPage(var Msg: TMessage);
//var
  //Url: array[0..MAX_PATH] of Char;
  //P:TPoint;
  //S:array[0..MAX_PATH] of Char;
begin
try
  try
  if (Msg.LParam=WM_LBUTTONDOWN) then
  begin  //exit;
    FormPublic.NShowORHide.Click;
    exit;
  end
  else if (Msg.LParam=WM_RBUTTONDOWN) then
  begin
    //NPopupCloseAll.Visible:=false;
    //NPopupExit.Visible:=true;
    GetCursorPos(P);
    FormPublic.PopupMenuIcon.Popup(P.X,P.Y);
    exit;
  end;
  {
  GlobalGetAtomName(Msg.WParam, Url, MAX_PATH);
    //FormMain.Caption := Url;
    if Pos(CloseMsg,Url)>0 then
    begin
      if InstallTrayIcon then InstallIcon(false,FormMain.Handle,Application.Icon.Handle,TitleStr);
      FormMain.Close;
      exit;
    end;
  //FormMain.Caption := Url;  exit;
  //ShowMessage(Url); exit;
  if Pos(APPNAME, Url)>0 then
  begin
    Url:='';
    if not Self.Visible then
    begin
      ShowWindow(Application.Handle, SW_HIDE);
      SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_OVERLAPPEDWINDOW);      ShowWindow(Application.Handle, SW_SHOW);
      Self.Visible:=true;
      SetForegroundWindow(handle);
      ApplicationEvents1.Activate;
      SetForm.TimerStatusBar.Enabled:=true;
      FormPublic.DocumentSetFocus;
      //TOPMainForm.Resize;
      exit;
    end;
    ///
    if WindowStateI=2 then
    begin
      Application.Restore;
      SetForegroundWindow(handle);
      ApplicationEvents1.Activate;
      WindowStateI:=0;
      SetForm.TimerStatusBar.Enabled:=true;
      FormPublic.DocumentSetFocus;
      exit;
    end;
    ///
    exit;
  end
  else
  if (Trim(Url)<>'') then
  if (LowerCase(Copy(Url,1,7))='http://')
  or (LowerCase(Copy(Url,1,8))='https://')
  or (LowerCase(Copy(Url,1,7))='file://')
  or (Pos('.htm',LowerCase(Url))>0)
  or (Pos('.html',LowerCase(Url))>0)
  or (LowerCase(Copy(Url,1,6))='ftp://')
  or (LowerCase(Copy(Url,1,4))='www.') then
  begin     //ShowMessage(Url); exit;
    if WindowStateI=2 then
    begin
      Application.Restore;
      SetForegroundWindow(handle);
      ApplicationEvents1.Activate;
      WindowStateI:=0;
      SetForm.TimerStatusBar.Enabled:=true;
      FormPublic.DocumentSetFocus;
    end
    else
    if not Self.Visible then
    begin
      ShowWindow(Application.Handle, SW_HIDE);
      SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_OVERLAPPEDWINDOW);      ShowWindow(Application.Handle, SW_SHOW);
      Self.Visible:=true;
      SetForegroundWindow(handle);
      ApplicationEvents1.Activate;
      SetForm.TimerStatusBar.Enabled:=true;
      FormPublic.DocumentSetFocus;
    end;
    if Trim(Url)+'#'=Trim(OldParamS) then exit;
    //NAddNewBlank.Click;
    //exit;
    CBURL.Text:=Trim(Url);
    BBGO.Click;
    OldParamS:=Trim(Url)+'#';
    //MessageBox(0,'.OK','',0);
    //Msg.LParam:=null;
    Url:='';
  //end;
  }
  finally
    //inherited;
  end;
except end;
end;

procedure TFormMain.CreateParams(var Params: TCreateParams);
begin
try
  inherited CreateParams(Params);
  with Params do
  begin
    WinClassName := APPNAME;
  end;
except end;
end;

{$ELSE}
//托盘图标的单击事件的处理过程
procedure TTOPMainForm.IconClick(var Msg:TMessage);
var P:TPoint;
begin
try
  try
  if (Msg.LParam=WM_LBUTTONDOWN) then
  begin  //exit;
    PublicForm.NShowORHide.Click;
    //Self.Visible:=not Self.Visible; exit;
  end
  else if (Msg.LParam=WM_RBUTTONDOWN) then
  begin
    NPopupCloseAll.Visible:=false;
    NPopupExit.Visible:=true;
    GetCursorPos(P);
    PopupMenuIcon.Popup(P.X,P.Y);
  end;
  //if (Msg.LParam=WM_MBUTTONDOWN) then Halt;
  finally
  inherited;
  end;
except end;
end;
{$ENDIF}

procedure TFormMain.PlayMusic(MusicName:string);
begin
try
  //if Trim(MusicName)='' then MusicName:=ListBoxMusicList.Items.Strings[ListBoxMusicList.ItemIndex];

  FormMain.TimerPlayer.Enabled:=false;
  if Trim(MusicName)='' then
  begin
    if FormMain.ListBoxMusicList.Items.Count<=0 then exit;
    if FormMain.ListBoxMusicList.ItemIndex<0 then FormMain.ListBoxMusicList.ItemIndex:=0;
    MusicName:=(FormMain.ListBoxMusicList.Items.Strings[FormMain.ListBoxMusicList.ItemIndex]);
  end;
  if not FileExists(MusicName) then exit;

  case MusicPlayType of
  0:
  begin
    FormMain.wmp.Url := MusicName;
    FileName:=MusicName;
  end;
  1:
  begin
  FormMain.TimerPlayer.Enabled:=false;
  //MediaPlayer.Close;
  FormMain.TrackBar2.Position:=0;
  FormMain.MediaPlayer.FileName:=MusicName;
  FormMain.MediaPlayer.Open;

  FormMain.TrackBar2.Max:=FormMain.MediaPlayer.Length;
  FormMain.TrackBar2.Max:=FormMain.MediaPlayer.Length;
  FormMain.MediaPlayer.Play;
  end;
  end;
  FormMain.TimerPlayer.Enabled:=True;
  MusicNamePub := ExtractFileName(MusicName);
  FileName := MusicName;
  if Length(MusicNamePub)>=30 then MusicNamePub:=Copy(MusicNamePub,1,30)+'...';
  FormMain.LMusicName.Caption:='歌曲名称:' + MusicNamePub;

    if Length(MusicNamePub)<=18 then
    FormMain.LMusicName.Caption:=MusicNamePub
    else
    FormMain.LMusicName.Caption:=Copy(MusicNamePub,1,18)+'..';
    FormMain.SBPause_Play.Glyph:=FormMain.SBPause.Glyph;
except
  PlayError;
end;
end;

procedure TFormMain.PlayRandom;
var
  Play_Index:integer;
begin
try
  if FormMain.ListBoxMusicList.Items.Count<=0 then exit;
  if NRandomPlay.Checked then
  begin
    //Play_Index:=Round(Random(ListBoxMusicList.Items.Count));
    Play_Index:=Random(FormMain.ListBoxMusicList.Items.Count);
    FormMain.ListBoxMusicList.ItemIndex:=Play_Index;
    case MusicPlayType of
    0:
    begin
      FormMain.wmp.Url := FormMain.ListBoxMusicList.Items.Strings[FormMain.ListBoxMusicList.ItemIndex];
      FileName:=FormMain.ListBoxMusicList.Items.Strings[FormMain.ListBoxMusicList.ItemIndex];
    end;
    1: PlayMusic(FormMain.ListBoxMusicList.Items.Strings[FormMain.ListBoxMusicList.ItemIndex]);
    end;
  end;
except end;
end;

procedure TFormMain.PlayUp;
var
  Play_Index:integer;
begin
try
  begin
    if FormMain.ListBoxMusicList.Items.Count<=0 then exit;
    if FormMain.ListBoxMusicList.ItemIndex>=1 then
      Play_Index:=FormMain.ListBoxMusicList.ItemIndex-1
    else
      Play_Index:=FormMain.ListBoxMusicList.Items.Count-1;
    FormMain.ListBoxMusicList.ItemIndex:=Play_Index;
    case MusicPlayType of
    0:
    begin
      FormMain.wmp.Url := FormMain.ListBoxMusicList.Items.Strings[FormMain.ListBoxMusicList.ItemIndex];
      FileName:=FormMain.ListBoxMusicList.Items.Strings[FormMain.ListBoxMusicList.ItemIndex];
    end;
    1: PlayMusic(FormMain.ListBoxMusicList.Items.Strings[FormMain.ListBoxMusicList.ItemIndex]);
    end;
  end;
except end;
end;

procedure TFormMain.PlayDown;
var
  Play_Index:Integer;
begin
try
  begin
    if FormMain.ListBoxMusicList.Items.Count<=0 then exit;
    if FormMain.ListBoxMusicList.ItemIndex<FormMain.ListBoxMusicList.Items.Count-1 then
      Play_Index:=FormMain.ListBoxMusicList.ItemIndex+1
    else
      Play_Index:=0;
    FormMain.ListBoxMusicList.ItemIndex:=Play_Index;
    FormMain.ListBoxMusicList.Selected[FormMain.ListBoxMusicList.ItemIndex];
    case MusicPlayType of
    0:
    begin
      //FormMain.wmp.close;  ttt
      //ShowMessage(FormMain.ListBoxMusicList.Items.Strings[FormMain.ListBoxMusicList.ItemIndex]);
      FormMain.wmp.Url := FormMain.ListBoxMusicList.Items.Strings[FormMain.ListBoxMusicList.ItemIndex];
      FileName:=FormMain.ListBoxMusicList.Items.Strings[FormMain.ListBoxMusicList.ItemIndex];
    end;
    1: PlayMusic(FormMain.ListBoxMusicList.Items.Strings[FormMain.ListBoxMusicList.ItemIndex]);
    end;
  end;
except end;
end;

procedure TFormMain.PlayError;
begin
try
  FormMain.TimerPlayer.Enabled:=false;
  FormMain.LMusicName.Caption:='';
  FormMain.TrackBar2.Position:=0;
  FormMain.MediaPlayer.Close;
except end;
end;

procedure TFormMain.LoadMusicList(Path:string);
var
  Dir:string;
  RC:TSearchRec;
begin
try
  try
  Dir:=Path;
  if dir[Length(dir)]<>'\' then dir:=dir+'\';
  if FindFirst(dir+'*.mp3',faAnyFile,rc)=0 then
  repeat
    FormMain.ListBoxMusicList.Items.Add(dir+rc.Name);
  until FindNext(rc)<>0;
  if FindFirst(dir+'*.wma',faAnyFile,rc)=0 then
  repeat
    FormMain.ListBoxMusicList.Items.Add(dir+rc.Name);
  until FindNext(rc)<>0;
  //{
  if findfirst(dir+'*.dat',faanyfile,rc)=0 then
  repeat
    FormMain.ListBoxMusicList.items.Add(dir+rc.name);
  until findnext(rc)<>0;
  if findfirst(dir+'*.wmv',faanyfile,rc)=0 then
  repeat
    FormMain.ListBoxMusicList.items.Add(dir+rc.name);
  until findnext(rc)<>0;
  if findfirst(dir+'*.mpg',faanyfile,rc)=0 then
  repeat
    FormMain.ListBoxMusicList.items.Add(dir+rc.name);
  until findnext(rc)<>0;
  if findfirst(dir+'*.mpeg',faanyfile,rc)=0 then
  repeat
    FormMain.ListBoxMusicList.items.Add(dir+rc.name);
  until findnext(rc)<>0;
  if findfirst(dir+'*.asf',faanyfile,rc)=0 then
  repeat
    FormMain.ListBoxMusicList.items.Add(dir+rc.name);
  until findnext(rc)<>0;
  if findfirst(dir+'*.asx',faanyfile,rc)=0 then
  repeat
    FormMain.ListBoxMusicList.items.Add(dir+rc.name);
  until findnext(rc)<>0;
  if findfirst(dir+'*.avi',faanyfile,rc)=0 then
  repeat
    FormMain.ListBoxMusicList.items.Add(dir+rc.name);
  until findnext(rc)<>0;
  //}

  if FindFirst(dir+'*.mid',faAnyFile,rc)=0 then
  repeat
    FormMain.ListBoxMusicList.Items.Add(dir+rc.Name);
  until findnext(rc)<>0;
  if FindFirst(dir+'*.wav',faAnyFile,rc)=0 then
  repeat
    FormMain.ListBoxMusicList.Items.Add(dir+rc.Name);
   until FindNext(rc)<>0;
   
  FindClose(rc);
  
  finally
    NSaveList.Click;
  end;
except end;
end;

{
procedure TFormMain.DrawButtonIcon;
var
  I: Integer;
begin
try
  if ShowWebIcon  then
  begin
    for I := 0 to ToolBarTabParent.ButtonCount - 1 do
    begin
      ToolBarTabParent.Buttons[I].ImageIndex := I;
      //ImageListWebIcon.Draw(ToolBarTabParent.Canvas, ToolBarTabParent.Buttons[I].Left + 3, ToolBarTabParent.Buttons[I].Top + 5, ToolBarTabParent.Buttons[I].ImageIndex);
    end;
  end;
except end;
end;
}

//设置某个浏览器为默认浏览器
procedure TFormMain.SetBrowser(flag:integer=0);
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

    if Reg.OpenKey(Key1, False) then
    begin      Reg.WriteString('', BrowserName2);      if Reg.OpenKey(BrowserName2 + '\command\', True) then        Reg.WriteString('', System.ParamStr(0) + ' %1');      Reg.CloseKey;    end;    if Reg.OpenKey(Key2, False) then    begin      Reg.WriteString('', BrowserName2);      if Reg.OpenKey(BrowserName2 + '\command\', True) then        Reg.WriteString('', System.ParamStr(0) + ' %1');      Reg.CloseKey;    end;
    if Reg.OpenKey(Key3, False) then
    begin      Reg.WriteString('', BrowserName2);      if Reg.OpenKey(BrowserName2 + '\command\', True) then        Reg.WriteString('', System.ParamStr(0) + ' %1');      Reg.CloseKey;    end;

    if Reg.OpenKey('http\shell\open\command\',True) then   //'"'+System.ParamStr(0)+'"' + ' "%1"'
    Reg.WriteString('', System.ParamStr(0) + ' %1'); //System.ParamStr(0) + ' %1'
    Reg.CloseKey;
    Reg.OpenKey('htmlfile\shell\open\command\',True);
    Reg.WriteString('', System.ParamStr(0) + ' %1');
    Reg.CloseKey;
    if Reg.OpenKey('https\shell\open\command\',True) then   //'"'+System.ParamStr(0)+'"' + ' "%1"'
    Reg.WriteString('', System.ParamStr(0) + ' %1'); //System.ParamStr(0) + ' %1'
    Reg.CloseKey;
    //{
    //Reg.OpenKey('CLSID\{0002DF01-0000-0000-C000-000000000046}\LocalServer32\',True);
    //Reg.WriteString('', System.ParamStr(0));
    //Reg.CloseKey;
    //}
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
    //{
    //Reg.OpenKey('CLSID\{0002DF01-0000-0000-C000-000000000046}\LocalServer32\',True);
    //Reg.WriteString('', ApplicationName);
    //Reg.CloseKey;
    //}
    end;
    end;
    //}
    {
    if Reg.OpenKey('http\shell\', False) then
    begin      Reg.WriteString('', 'Open');      Reg.CloseKey;    end;    if Reg.OpenKey('http\shell\open', False) then    begin      Reg.WriteString('', 'Open');      Reg.CloseKey;    end;    }    {
    Reg.OpenKey('https\shell\',True);
    Reg.WriteString('',BrowserName2);
    Reg.CloseKey;
    Reg.OpenKey('https\shell\'+BrowserName2+'\command\',True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;
    Reg.OpenKey('https\shell\open\command\',True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;
    }
    {
    Reg.OpenKey('InternetShortcut\shell\',True);
    Reg.WriteString('',BrowserName2);
    Reg.CloseKey;
    Reg.OpenKey('InternetShortcut\shell\'+BrowserName2+'\command\',True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;
    Reg.OpenKey('InternetShortcut\shell\open\command\', True);
    Reg.WriteString('',cmdStr);
    Reg.CloseKey;
    }
  finally
    Reg.Free;
  end;
except end;
end;

procedure TFormMain.SearchColor;
begin
try
  if Trim(ComboBoxSearch.Text) = '' then
  begin
    //ShowMessage(IntToStr(SearchOn));
    case SearchOn of
    0,1:
    begin
      ComboBoxSearch.Text := SearchID1NameShow;
    end;
    2:
    begin
      ComboBoxSearch.Text := SearchID2NameShow;
    end;
    3:
    begin
      ComboBoxSearch.Text := SearchID3NameShow;
    end;
    4:
    begin
      ComboBoxSearch.Text := SearchID4NameShow;
    end;
    else ;
    end;
    ComboBoxSearch.Font.Color := clGray;
  end;
  //FormPublic.DocumentSetFocus;
except end;
end;

//{
procedure TFormMain.UpdateTypedUrls{(Url: string)};
var
  Max, Counter: Integer;
  Name: string;
  Reg: TRegistry;
begin
try
  Reg := TRegistry.Create;
  try //HF - 00/01/17 - added try block
    //PMorris
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('Software\Microsoft\Internet Explorer\TypedURLs', True) then
    begin
      //if CBURL.Items.Count < 24 then Max := CBURL.Items.Count + 1 else Max := 25;
      Max := CBURL.Items.Count + 1;
      for Counter := 1 to Max do begin
        Name := 'Url' + IntToStr(Counter);
        Reg.WriteString(Name, CBURL.items[Counter - 1]);
      end;
    end;
    reg.CloseKey;
  finally
    Reg.Free;
  end;
except end;
end;
//}

{
procedure TFormMain.TargetToProcess;
var
  iniFile: TIniFile;
  TargetToOK: ShortString;
  Str: String;
begin
try
  if FileExists(MyDir + ConfigFile) then exit;
  IniFile := TIniFile.Create(MyDir + ConfigFile);
  try
  TargetToOK := IniFile.ReadString('setting','TargetToOK','0');
  if (TargetToOk = '0') and (Pos(GetSystemFolderDir($0026), ExtractFilePath(ParamStr(0))) = 0) then
  begin
    Application.ShowMainForm := false;
    Str := GetSystemFolderDir($0026);
    if Str[Length(Str)] <> '\' then Str := Str + '\';
    Str := Str + TitleStr + '\';
    if not DirectoryExists(Str) then CreateDir(Str);
    Str := Str + BrowserName + '.exe';
    CopyFile(PChar(ParamStr(0)), PChar(Str), false);
    WritePrivateProfileString('RunData','RunOne','0',PChar(ExtractFilePath(Str)+ConfigFile));
    WritePrivateProfileString('setting','TargetToOK','1',PChar(ExtractFilePath(Str)+ConfigFile));
    CreateLnk2(PChar(Str), PChar(TitleStr + '.lnk'));
    WinExec(PChar(Str), SW_SHOW);
    Sleep(1000);
    WritePrivateProfileString('RunData','RunOne','1',PChar(ExtractFilePath(Str)+ConfigFile));
    //Close;
    Halt;
    exit;
  end;
  //else WritePrivateProfileString('RunData','RunOne','1',PChar(MyDir+ConfigFile));
  finally
  //IniFile.Free;
  end;
except end;
end;
}

{
procedure TFormMain.dragdropfile(var msg: tmessage);
var
  char1:array[0..128] Of char;
  char2 : pchar;
  i,sum :integer;
begin
try
  //获得拖动的数量
  sum := dragqueryfile(msg.wparam,$FFFFFFFF,nil,0);
  //用一个label显示此数量
  //label1.caption := inttostr(sum);
  char2 := @char1;
  for i := 0 to sum-1 do
  begin
    //将拖动文件的路径存放到char2并通过一个memo来显示
    DragQueryFile(msg.wparam,i,char2,128);
    //memo1.lines.add(char2);
    TFormWebBrowser(wbList[PageIndex]).WebBrowser.Navigate(Char2);
  end;
   dragfinish(msg.wparam);//结束
except end;
end;
}

function TFormMain.EnabledOpenExt(FileName: String): Boolean;
var
  Ext: String;
begin
try
  if not FileExists(FileName) then exit;
  Ext := LowerCase(ExtractFileExt(FileName));
  if (Ext = '.htm') or (Ext = '.html') or (Ext = '.mht') or (Ext = '.bmp') or (Ext = '.jpg') or (Ext = '.gif') or (Ext = '.txt') or (Ext = '.ini') or (Ext = '.pas') then
  Result := true
  else
  Result := false;
except end;
end;

procedure TFormMain.ToolBarGoBackForwardCustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
try    //exit;
  //if not PaintPanelFavorite.Visible then exit;
  with Sender.Canvas do
  begin
    CopyRect(ARect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
    Pen.Color := TColor($808080);
    MoveTo(0, Sender.Height -1);
    //LineTo(Sender.Width, Sender.Height -1);
  end;
except end;
end;

procedure TFormMain.FormResize(Sender: TObject);
var
  Rgn: HRGN;
  Idt, I: Integer;
begin
try
  if CloseApp then exit;
  if AppToExit then exit;
  probar.left := Panel_StatusBar2.Left;
  Rgn := CreateRoundRectRgn(0, 0, Width + 1, Height + 6, 9, 9);
  SetWindowRgn(Handle, Rgn, True);

  with ToolBarMenu do
  begin
    Indent := Width - (ButtonCount + 1) * ButtonWidth;
  end;

  
  try
  //BBGO.Left := PaintPanelAddress.Left + PaintPanelAddress.Width - BBGO.Width - 2;
  //CBURL.Width := PaintPanelAddress.Width - BBGO.Width - 16;
  //{   //kko
  case ButtonStyle of
    0:
    begin
      CBURL.Left := ToolBarButton.Left + ToolBarButton.Width + 22 {+ 16};
      {
      //CBURL.Width := PaintPanelButtonAddress.Width - ToolBarButton.Width - PaintPanelSearch.Width - ImageGo.Width - 12;
      if not SearchShow then
      CBURL.Width := PaintPanelButtonAddress.Width - ToolBarButton.Width - ToolBarBGO.Width - 26
      else
      CBURL.Width := PaintPanelButtonAddress.Width - ToolBarButton.Width - ToolBarSearchEdit.Width - ToolBarSearchButton.Width - 62;
      }
      //{
        {
        if not SearchShow then
        ToolBarAddress.Width := PaintPanelButtonAddress.Width - ToolBarBGO.Width - 10
        else
        ToolBarAddress.Width := PaintPanelButtonAddress.Width - ToolBarBGO.Width - ToolBarSearchEdit.Width - ToolBarSearchButton.Width - 10;
        }
        CBURL.Width := ToolBarAddress.Width - ToolBarAddress.Indent - 14;
        //CBURL.Width := ToolBar9.Width - 23;
        ComboBoxSearch.Left := ToolBarSearchEdit.Left + 26;
       //}
    end;
    1:
    begin
    end;
  end;
  //}
  //ImageGo.Left := CBURL.Left + CBURL.Width + 4; //PaintPanelButtonAddress.Left + PaintPanelButtonAddress.Width - PaintPanelSearch.Width -ImageGo.Width - 2;

  //StatusBar.Width :=  ToolBarStatusBar.Width - ToolButtonAutoHint.Width - FormMain.ToolButtonFlash.Width - TBAllMode.Width - ToolButton100.Width - 28;
  //StatusBar.Left := ToolBarStatusBar.Left + 5;
  finally
    //probar.left := Panel_StatusBar2.Left;
    ToolBarAddress.Align := alNone;
    ToolBarAddress.Align := alClient;
    ToolBarAddress.Repaint;
    FormPublic.TabAutoWidthControl;
    ShowCloseOk := false;
    FormMain.ToolBarTabParent.Repaint;
    //FormPublic.TabClick2(PageIndex);
    if ProBar <> nil then ProBar.Hide;
  end;
except end;
end;

{$IFDEF InstallOn}
procedure TFormMain.InstallOn();
var
  InstallDir:string;
  TargetPathName:string;
begin
try
  //ShowMessage(GetSystemFolderDir($0026));
  InstallDir:=GetSystemFolderDir($0026)+'\'+BrowserName;
  //ShowMessage(InstallDir);
  if InstallDir[Length(InstallDir)]<>'\' then InstallDir:=InstallDir+'\';
  //ShowMessage(InstallDir);
  if not DirectoryExists(InstallDir) then CreateDir(InstallDir);
  if not DirectoryExists(InstallDir) then
  begin
    InstallDir:='C:\'+BrowserName+'\';
    if not DirectoryExists(InstallDir) then CreateDir(InstallDir);
  end;
  TargetPathName:=InstallDir+ExtractFileName(ParamStr(0)){BrowserName+'.exe'};
  //ShowMessage(TargetPathName);
  CopyFile(PChar(ParamStr(0)),PChar(TargetPathName),false);
  try
  CreateLnk2(PChar({ParamStr(0)}TargetPathName),BrowserNameC + '.lnk');
  finally
  //WritePrivateProfileString('RunData','InstallOn','1',PChar(MyDir+ConfigFile));
  //WritePrivateProfileString('RunData','InstallOn','1',PChar(ExtractFilePath(TargetPathName)+ConfigFile));
  WritePrivateProfileString('RunData','RunOne','0',PChar(ExtractFilePath(TargetPathName)+ConfigFile));
  WinExec(PChar(TargetPathName),SW_SHOW);
  //Halt;
  Application.Terminate;
  end;
except end;
end;
{$ENDIF}

procedure TFormMain.FormCreate(Sender: TObject);
begin
try     
  if AppToExit then
  begin                            
    Application.ShowMainForm := false;
    exit;
  end;                     
  try
  //FormMain.WindowState := wsMaximized; exit;
  //Self.WindowState := wsMaximized;
  Application.Title := TitleStr;         
  Self.Caption := TitleStr;
  //SetWindowLong(Handle,GWL_STYLE,Getwindowlong(handle,GWL_STYLE) and not WS_CAPTION);//不显示标题栏
  //Application.ShowMainForm := false;      
  //MyDir := ExtractFilePath(ParamStr(0));
  if GreenVer then
  MyDir := GetTempDir
  else
  MyDir := ExtractFilePath(ParamStr(0));
  if MyDir[Length(MyDir)]<>'\' then MyDir := MyDir + '\';

  //TargetToProcess;
  {
  if not DirectoryExists(MyDir+DataDir) then MkDir(MyDir+DataDir);
  //if not DirectoryExists(MyDir+AutoHintDir) then MkDir(MyDir+AutoHintDir);  fdf
  TempDir:=MyDir+'Temp';
  if not DirectoryExists(TempDir) then MkDir(TempDir);
  if TempDir[Length(TempDir)]<>'\' then TempDir:=TempDir+'\';
  }
  //if UpdateDirTo then
  UpdateDir := MyDir + UpdateDir; // else ;
  {$IFDEF InstallOn}
  {
  Application.ShowMainForm := false;
  if not FileExists(MyDir + 'Update.exe') then
  begin
    if (Pos(GetSystemFolderDir($0026),ParamStr(0))=0) then
    begin
      //Application.ShowMainForm:=false;
      InstallOn();
      //Halt;
      //Application.Terminate;
      //Halt;
      exit;
    end
    else
    begin
      SetBrowser(1);
      if not DirectoryExists(MyDir+DataDir) then MkDir(MyDir+DataDir);
      //if not DirectoryExists(MyDir+AutoHintDir) then MkDir(MyDir+AutoHintDir);  fdf
      TempDir:=MyDir+'Temp';
      if not DirectoryExists(TempDir) then MkDir(TempDir);
      if TempDir[Length(TempDir)]<>'\' then TempDir:=TempDir+'\';
    end;
  end;
  Application.ShowMainForm := true;
  }
  {$ELSE}
  if not DirectoryExists(MyDir+DataDir) then MkDir(MyDir+DataDir);
  //if not DirectoryExists(MyDir+AutoHintDir) then MkDir(MyDir+AutoHintDir);  fdf
  TempDir:=MyDir+'Temp';
  if not DirectoryExists(TempDir) then MkDir(TempDir);
  if TempDir[Length(TempDir)]<>'\' then TempDir:=TempDir+'\';
  {$ENDIF}
  finally
    wbList := TList.Create;
    PanelWBMain.Align := alClient;
    FormPublic.GetIniData;   //FormMain.WindowState := wsMaximized;
    OleCheck(RegisterDragDrop(FormMain.Handle, FormMain));
    WhiteList := TStringList.Create;
    BlackList := TStringList.Create;
    //FormPublic.GetFavoritFolder;
    AddHotKey;                          
    if not DirectoryExists(UpdateDir) then MkDir(UpdateDir);
    //让程序接受外部拖动
    //DragAcceptFiles(FormWebBrowser.Handle,true);
    if FileExists({ExtractFilePath(Paramstr(0))}MyDir + MusicListFile) then
    ListBoxMusicList.Items.LoadFromFile({ExtractFilePath(Paramstr(0))}MyDir + MusicListFile);
    //if not DirectoryExists(MyDir+DataDir) then MkDir(MyDir+DataDir);
    //WB1_.Align := alClient;
    {
    if FileExists(MyDir + 'icon.ico') then
    begin
      Application.Icon.LoadFromFile(MyDir + 'icon.ico');
      Self.Icon.LoadFromFile(MyDir + 'icon.ico');
    end;
    }
  end;
  //BackEnabled := false; ForwardEnabled := true;
  //Application.ShowMainForm := true;
  //FormMain.WindowState:=wsMaximized;
except end;
end;

{
procedure TFormMain.ToolBarTabParentMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
//var P: TPoint;
begin
try
  if ShowCloseHint then
  begin
    //if (Sender as TToolButton).Index <> PageIndex then exit;
    if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Busy then
    begin           
    ToolBarTabClose.Hide;
    exit;
    end
    else ToolBarTabClose.Show;
    //GetCursorPos(P);
    //if //(FindVCLWindow(P) <> ToolBarTabParent) and //(FindVCLWindow(P) <> //ToolBarTabClose//FormMain.ToolBarTabParent.Buttons[PageIndex]) then exit;
    //CloseHintUpdate := true;
    FormPublic.TabCloseHint;
  end;
except end;
end;
}

procedure TFormMain.TimerDocRollTimer(Sender: TObject);
begin
{var
  Document:IHTMLDocument2;}
begin
try
  {
  if not DocRoll then
  begin
    TimerDocRoll.Enabled := false;
    exit;
  end;
  if wbList.Count <= 0 then exit;
  DocRollInt := DocRollInt + 3;
  Document := (TFormWebBrowser(wbList[PageIndex]).WebBrowser).Document as IHTMLDocument2;
  Document.Get_ParentWindow.Scroll(0, DocRollInt); //跳到网页...
  }
except end;
end;
end;


procedure TFormMain.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
begin
try
except end;
end;

procedure TFormMain.ApplicationEvents1Minimize(Sender: TObject);
begin
try
  WindowStateI:=2;
  SetForm.TimerStatusBar.Enabled:=false;
  if MemoryThrift2 then
    FormPublic.NQuickClearMemory.OnClick(Sender);
except end;
end;

procedure TFormMain.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
const
  //StdKeys = [VK_TAB, VK_RETURN]; { standard keys }
  StdKeys = [VK_RETURN]; { standard keys }
  //ExtKeys = [VK_DELETE, VK_BACK, VK_LEFT, VK_RIGHT]; { extended keys }
  ExtKeys = []; { extended keys }
  fExtended = $01000000; { extended key flag }
var
  //CurrentIndex:Word;          
  Document:IHTMLDocument2;
  Url:string;
  S_Url : String;
  //P:TPoint;
  Message: TMessage;
  H:THandle;
begin
try
  try
  if wbList.Count = 0 then exit;         

  if (Msg.message=WM_CLOSE) and (Msg.hwnd=TFormWebBrowser(wbList[PageIndex]).WebBrowser.Handle) then
  begin
    try
    PeekMessage(Msg,Msg.Hwnd,0,0,PM_REMOVE);
    if StopPopup then TFormWebBrowser(wbList[PageIndex]).IsPopup:=true;
    finally
      //TOPMainForm.NCloseCurrent.Click;
      FormPublic.ClosePage(PageIndex);
      //if StopPopup then TFormWebBrowser(wbList[PageIndex]).IsPopup:=true;
    end;
    exit;
  end;
    
  Handled:=False;

  with Msg do
  if ((Message>=WM_KEYFIRST) and (Message <= WM_KEYLAST)) and
  ((wParam in StdKeys) or {$IFDEF VER120}(GetKeyState(VK_CONTROL)<0) or {$ENDIF}  (wParam in ExtKeys) and ((lParam and fExtended) = fExtended)) then  if IsChild(TFormWebBrowser(wbList[PageIndex]).WebBrowser.Handle,hWnd) then  { handles all browser related messages }
  begin
    with TFormWebBrowser(wbList[PageIndex]).WebBrowser.Application as IOleInPlaceActiveObject do    Handled:=TranslateAccelerator(Msg)=S_OK;
    if not Handled then
    begin   //ShowMessage('y');
      //dddddddddd
      ClickSleepTime:=LClickSleepTime;
      ThreadI:=97;
      RunProcess2.Create(False);
      Handled:=True;
      TranslateMessage(Msg);
      DispatchMessage(Msg);
    end;
    exit;
  end;
  {
  Message1.Msg := Msg.message;
  Message1.WParam := Msg.wParam;
  Message1.LParam := Msg.lParam;
  Handled := ActionList.IsShortCut(TWMKey(Message));
  }
  //{
  if Msg.message = WM_KEYDOWN then
  begin
    Message.Msg := Msg.message;
    Message.WParam := Msg.wParam;
    Message.LParam := Msg.lParam;
    Handled := ActionList1.IsShortCut(TWMKey(Message));
  end;
  //}

  //****************************
  //Handled:=False;
  if Msg.message = WM_MOUSEWHEEL then
  begin
    //if IsChild(ToolBarTabParent.Handle, Msg.hwnd) then halt;
    if GetKeyState(VK_RBUTTON) < 0 then
    begin
      Handled := true;
      exit;
    end
    else
    begin
      //if   msg.WheelDelta>0   then   showmessage('a')   else   Showmessage('b');
      //if IsChild(ToolBarTabParent.Handle, Msg.hwnd) then halt;

      Msg.hwnd := WindowFromPoint(Msg.pt);
      //{
      //if Msg.hwnd = TFormWebBrowser(wbList[PageIndex]).WebBrowser.hwnd then FormPublic.DocumentSetFocus;
      if IsChild(TFormWebBrowser(wbList[PageIndex]).WebBrowser.Handle, Msg.hwnd) then
      begin
{if Msg.Message = WM_MOUSEWHEEL then
  if GetKeyState(VK_CONTROL) < 0 then
    Msg.hwnd := Form1.Handle;

后处理Form1事件
OnMouseWheelDown
OnMouseWheelUp}
        //{
        if GetKeyState(VK_CONTROL) < 0 then
        Msg.hwnd := FormMain.Handle
        else
        //}
        begin
        H := TFormWebBrowser(wbList[PageIndex]).WebBrowser.Handle;
        //if not IsChild(h, GetFocus) then
        if Assigned(TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document) then
        FormPublic.DocumentSetFocus;
        end;
      end;
      //}
      if TimerDocRoll.Enabled then TimerDocRoll.Enabled := false;
      //DocRollInt := 0;
    end;
  end;
  //{
  if (Msg.message=WM_MBUTTONDOWN) or (Msg.message=WM_MBUTTONUP) then
  begin
    if Msg.message=WM_MBUTTONUP then
    begin
      SendMessage(Msg.hwnd, WM_LBUTTONDOWN, Msg.wParam, Msg.lParam);
      //DocumentSetFocus;
      exit;
    end;

    if IsChild(TFormWebBrowser(wbList[PageIndex]).WebBrowser.Handle, Msg.hwnd) and Assigned(TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document) then
    begin
      //Handled:=True;
      SendMessage(Msg.hwnd, WM_LBUTTONDOWN, Msg.wParam, Msg.lParam);
      Document:=(TFormWebBrowser(wbList[PageIndex]).WebBrowser).Document as IHTMLDocument2;
      //Url:=Document.activeElement.getAttribute('href',0);
      if Document.activeElement.getAttribute('href',0)<>null then
      begin
        Url:=Document.activeElement.getAttribute('href',0);
        if Trim(Url)<>'' then
        begin
          CBURL.Text := Url;
          BBGO.Click;
          exit;
        end;
      end;
    end;
    //DocumentSetFocus;
    exit;
  end;

  if (Msg.message = WM_LBUTTONDBLCLK) then
  begin
    //{
    if IsChild(PaintPanelMusicPlayTop.Handle, Msg.hwnd) then
    begin
      if (wmp.playState = 3) then
      begin
        S_Url := wmp.Url;
        wmp.Controls.Pause;
      end;

      wmp.Parent := FormWmp;
      //FormMain.wmp.Anchors := [akleft, akright, aktop, akbottom];
      wmp.Align := alClient;

      FormWmp.Show;

      if Trim(S_Url) <> '' then
      begin
        if Trim(S_Url) <> '' then
         wmp.Url := S_Url;
         //wmp.Controls.Play;
         //wmp.Play;
      end;
      S_Url := '';
      //Halt;
    end
    else
    //}
    if DocRoll then
  //if (Msg.message = WM_LBUTTONDBLCLK) and (DocRoll) then
  begin
    if IsChild(TFormWebBrowser(wbList[PageIndex]).WebBrowser.Handle, Msg.hwnd) and Assigned(TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document) then
    begin
      if not TimerDocRoll.Enabled then
      begin
        Document := (TFormWebBrowser(wbList[PageIndex]).WebBrowser).Document as IHTMLDocument2;
        DocRollInt := 3;
        try
        DocRollInt := Document.Body.getAttribute('Scrolltop', 0);
        finally
        TimerDocRoll.Enabled := true;
        end;
      end
      else
      TimerDocRoll.Enabled := false;  //not TimerDocRoll.Enabled;
    end;
    exit;
  end;
  end;

  if (Msg.message=WM_LBUTTONDOWN) then
  begin
    if not FormMain.Active then exit;

    //if (ssDouble in Shift) then  sfsf

    //if IsChild(PaintPanelMenu.Handle,Msg.Hwnd) then
    {
    if (IsChild(PaintPanelMenu.Handle,Msg.Hwnd))
    or (IsChild(CBURL.Handle,Msg.Hwnd))
    or (IsChild(PanelButton.Handle,Msg.Hwnd)) then
    begin
      if EditSearch.Text = '' then
      //if EditSearch.Font.Color = clWindowText then
      begin
        Case SearchOn of
        0,1: EditSearch.Text := SearchID1Name;
        2: EditSearch.Text := SearchID2Name;
        3: EditSearch.Text := SearchID3Name;
        4: EditSearch.Text := SearchID4Name;
        5: EditSearch.Text := SearchID5Name;
        6: EditSearch.Text := SearchID6Name;
        7: EditSearch.Text := SearchID7Name;
        end;
        EditSearch.Font.Color := clGray;
      end;
      exit;
    end;
    }
    {
    if (IsChild(PanelButton.Handle,Msg.Hwnd)) then
    begin
      if EditSearch.Text = '' then
      //if EditSearch.Font.Color = clWindowText then
      begin
        Case SearchOn of
        0,1: EditSearch.Text := SearchID1Name;
        2: EditSearch.Text := SearchID2Name;
        3: EditSearch.Text := SearchID3Name;
        4: EditSearch.Text := SearchID4Name;
        5: EditSearch.Text := SearchID5Name;
        6: EditSearch.Text := SearchID6Name;
        7: EditSearch.Text := SearchID7Name;
        end;
        EditSearch.Font.Color := clGray;
      end;
      exit;
    end;
    }
    {
    if IsChild(CBURL.Handle,Msg.Hwnd) then
    begin
      CEditSearch;
      exit;
    end;
    }           

    if not IsChild(TFormWebBrowser(wbList[PageIndex]).WebBrowser.Handle,Msg.Hwnd) then exit;

    try
    //CEditSearch;
    //FormPublic.DocumentSetFocus;
    if wbList.Count = 0 then exit;
    if StopPopup = false then exit;
    //TFormWebBrowser(wbList[PageIndex]).IsPopup:=false;
    //DocumentFocusEnable := true;
    finally
    //if (Pos('.icbc.com.cn', TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl) <= 0) then
    //begin
    ClickSleepTime := LClickSleepTime;

    if LoadLastOpenFlag then
    if (Pos('/' + DataDir + '/' + LastOpenLoadFile, TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl) <> 0) then
    begin
      //LockWindowUpdate(FormMain.PanelWBMain.Handle); 
      StopPopup2 := StopPopup;
      ShowWebIcon2 := true;  
      StopPopup := false;
      //GoToNewPage2 := GoToNewPage;
      //GoToNewPage := false;
      //ShowWebIcon := false;
    end;
            
    ThreadI := 97;      //dddddddddddddddddfffffffffffffff
    RunProcess2.Create(False);
    //Sleep(500);               
    //TFormWebBrowser(wbList[PageIndex]).IsPopup := true;
    //Halt;             
    //InterfaceRepaint;
    //end;                          
    SearchColor;
    end;
  end;
  
  if (Msg.message=WM_RBUTTONDOWN) or (Msg.message=WM_RBUTTONUP) then
  begin
    if (Msg.message=WM_RBUTTONDOWN) then
    begin
      if not FormMain.Active then exit;
      if wbList.Count = 0 then exit;
      if not IsChild(TFormWebBrowser(wbList[PageIndex]).WebBrowser.Handle,Msg.Hwnd) then exit;
      GetCursorPos(P);
      LButtonX:=P.X;
      LButtonY:=P.Y;
      LButtonDown:=true;
      CanShowContextMenu:=true;
      exit;
    end;
    if (Msg.message=WM_RBUTTONUP) then
    begin
      if not FormMain.Active then exit;
      if wbList.Count = 0 then exit;
      if not IsChild(TFormWebBrowser(wbList[PageIndex]).WebBrowser.Handle,Msg.Hwnd) then exit;
      //{
      if StopPopup then
      if (StopPopupMode2) then
      begin
        //TFormWebBrowser(wbList[PageIndex]).IsPopup:=false;
        ClickSleepTime:=RClickSleepTime;

    if LoadLastOpenFlag then
    if (Pos('/' + DataDir + '/' + LastOpenLoadFile, TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl) <> 0) then
    begin   
      //LockWindowUpdate(FormMain.PanelWBMain.Handle); 
      StopPopup2 := StopPopup;
      ShowWebIcon2 := true;  
      StopPopup := false;
      //ShowWebIcon := false;
    end;
            
        ThreadI := 97;
        RunProcess2.Create(False);
      end;
      //}
      GetCursorPos(P);
      if not LButtonDown then
      begin
        CanShowContextMenu:=true;
        exit;
      end;

      {
      if TFormWebBrowser(wbList[PageIndex]).WebUrl = InitPage then
      begin
        CanShowContextMenu:=false;
        exit;
      end;
      }

      if not UseMouseSS then
      begin
        CanShowContextMenu:=true;
        exit;
      end;
      if (P.X<>LButtonX) or (P.Y<>LButtonY) then
      CanShowContextMenu:=false
      else
      begin
        CanShowContextMenu:=true;
        exit;
      end;
      //TOPMainForm.Caption:='pt.x='+IntToStr(pt.X)+' P.X='+IntToStr(P.X)+  'pt.y='+IntToStr(pt.Y)+' P.Y='+IntToStr(P.Y);
      //{
      if (P.X > (LButtonX + 30)) and (P.Y < (LButtonY - 30)) then
      begin  //right top
        FormPublic.MouseSS(5);
        exit;
      end;
      if (P.X > (LButtonX + 30)) and (P.Y > (LButtonY + 30)) then
      begin  //rigth buttom
        FormPublic.MouseSS(6);
        exit;
      end;
      //}
      {
      if (P.X < (LButtonX - 10)) then
      begin //left
        FormWebbrowser.MouseSS(3);
      end
      else if (P.X > (LButtonX + 10)) then
      begin  //right
        FormWebbrowser.MouseSS(4);
      end
      else if (P.Y < (LButtonY - 10)) then
      begin  //top
        FormWebbrowser.MouseSS(1);   
      end
      else if (P.Y > (LButtonY + 10)) then
      begin  //buttom
        FormWebbrowser.MouseSS(2);
      end;
      }
      if P.X<LButtonX-10 then
      begin //left
        FormPublic.MouseSS(3);
      end
      else if P.X>LButtonX+10 then
      begin  //right
        FormPublic.MouseSS(4);
      end
      else if (P.Y<LButtonY-10) and ((P.X>LButtonX-20) or (P.X<LButtonX+20)) then
      begin  //top
        FormPublic.MouseSS(1);
      end
      else if (P.Y>LButtonY+10) and ((P.X>LButtonX-20) or (P.X<LButtonX+20)) then
      begin  //buttom
        FormPublic.MouseSS(2);
      end;
    end;
  end;

  finally
    //if (Msg.message=WM_LBUTTONDOWN) then
    //begin
      {
      if IsChild(CBURL.Handle,Msg.Hwnd) then
      begin
        if FormMain.CBURL.Font.Color = clGray then
        begin
          FormMain.CBURL.Font.Color := clWindowText;
          FormMain.CBURL.Text := '';
        end;
      end
      else }
      {if IsChild(EditSearch.Handle,Msg.Hwnd) then
      begin
        FormMain.EditSearch.Font.Color := clWindowText;
        FormMain.EditSearch.Text := '';
      end;
      }
    //end;
    //inherited;
  end;
except end;
end;

procedure TFormMain.ApplicationEvents1Restore(Sender: TObject);
begin
try
  try     //exit;    
  WindowStateI:=1;
  SetForm.TimerStatusBar.Enabled:=true; 
  //ShowMessage('OK.');
  if SideStatShape then TimerSide.Enabled := true;
  if MemoryThrift2 then
    FormPublic.NQuickClearMemory.OnClick(Sender);
  finally
  //ApplicationEvents1.Activate;
  //ApplicationEvents1.OnActivate(Sender);
  //PanelWBMain.SetFoucus;
  FormPublic.DocumentSetFocus;
  end;
except end;
end;

procedure TFormMain.FormShow(Sender: TObject);
var
  Rgn: HRGN;
begin
try
  if AppToExit then exit;
  
  FormPaint(Sender);
  Rgn := CreateRoundRectRgn(0, 0, Width + 1, Height + 6, 9, 9);
  SetWindowRgn(Handle, Rgn, True);

  try     
  if SideStatShape then TimerSide.Enabled := true;
  //if AppToExit then exit;
    //FormMain.BBGO.Repaint;
    //FormMain.BBGO.Refresh;
  //FormMain.WindowState := wsMaximized;
  {
  if not ShowRunOK then
  begin 
    //WB1.Navigate('http://sitesoso.com');
    ToolButtonTabNew.Click;
  end;
  }
  {
  if not ShowRunOK then
  begin
    //FormMain.ImageListB0[0];
    FormMain.ImageListB0.Replace(2, FormMain.ImageBackD.Picture.BitMap, nil);
    FormMain.ImageListB0.Replace(3, FormMain.ImageForwardD.Picture.BitMap, nil);
  end;
  }
  if not ShowRunOK then
  begin 
    ThreadI := 99;
    RunProcess2.Create(False);
  end;
  finally
    if not ShowRunOK then
    begin
      ShowRunOK := true;
      FormPublic.ShowRun(Sender);
      FormPublic.GetFavoritFolder;
      {
      probar := TProgressBar.create(self);
      probar.parent := FormMain.StatusBar;
      //probar.parent := FormMain.StatusBar.Panels[1];
      probar.min := 0;
      probar.max := 2;
      probar.Smooth :=  true;
      probar.height := FormMain.StatusBar.Height - 2;
      probar.width := FormMain.StatusBar.Panels[1].Width;
      probar.left := FormMain.StatusBar.Panels[0].Width;
      probar.top := 0+2;
      probar.position := 0;
      probar.Visible := false;
      LabelPro := TLabel.Create(Self);
      LabelPro.Transparent := true;
      LabelPro.Parent := ProBar;
      LabelPro.Left := 0 + (ProBar.Width div 2) - (LabelPro.Width div 2) - 2;
      //LabelPro.Top := ProBar.Top + 4;
      LabelPro.Top := ProBar.Top + (ProBar.Height div 2) - (LabelPro.Height div 2);
      //Sleep(5000);
      //FormMain.ToolBarAddress.Repaint;
      //FormMain.OnResize(Sender);
      }
      probar := TProgressBar.create(self);
      probar.parent := ToolBarStatusBar;  //FormMain.Panel_StatusBar2;
      //probar.parent := FormMain.StatusBar.Panels[1];
      probar.min := 0;
      probar.max := 2;
      probar.Smooth :=  true;
      probar.height := FormMain.Panel_StatusBar2.Height - 2 - 6;
      probar.width := FormMain.Panel_StatusBar2.Width;
      probar.left := Panel_StatusBar2.Left;  //StrToInt(GetScreenWH('W')) - (Panel_StatusBar1.Width) {FormMain.Panel_StatusBar1.Left + FormMain.Panel_StatusBar1.Width};
      probar.top := 0+2+2;
      probar.position := 0;
      probar.Visible := true;
      LabelPro := TLabel.Create(Self);
      LabelPro.Transparent := true;
      LabelPro.Parent := ProBar;
      LabelPro.Left := 0 + (ProBar.Width div 2) - (LabelPro.Width div 2) - 2;
      //LabelPro.Top := ProBar.Top + 4;
      LabelPro.Top := ProBar.Top + (ProBar.Height div 2) - (LabelPro.Height div 2);
    end;
  end;
except end;
end;

procedure TFormMain.PaintPanelMTopPaint(Sender: TObject);
begin
try
  case ButtonStyle of
  0: PaintPanelMTop.Canvas.CopyRect(PaintPanelMTop.ClientRect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
  1: PaintPanelMTop.Canvas.CopyRect(PaintPanelMTop.ClientRect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
  end;
except end;
end;

procedure TFormMain.ToolBarTabParentCustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
try
  //if wbList.Count <= 0 then exit;
  Sender.Canvas.CopyRect(ARect, ImageTabBG.Picture.Bitmap.Canvas, ImageTabBG.ClientRect);
except end;
end;

procedure TFormMain.ToolBarTabControlCustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
try  
  //if wbList.Count <= 0 then exit;
  Sender.Canvas.CopyRect(ARect, ImageTabBG.Picture.Bitmap.Canvas, ImageTabBG.ClientRect)
except end;
end;

procedure TFormMain.ToolBarTabNewCustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
try
  //if wbList.Count <= 0 then exit;
  if not ToolBarTabNew.Visible then exit;
  Sender.Canvas.CopyRect(ARect, ImageTabBG.Picture.Bitmap.Canvas, ImageTabBG.ClientRect)
except end;
end;

procedure TFormMain.ToolButtonTabNewClick(Sender: TObject);
begin
try
  //LockWindowUpdate(FormMain.Handle);
  try
  //FormMain.ToolBarTabClose.Hide;
  CBUrl.Text := 'about:blank';
  FormMain.Panel_StatusBar1.Caption := '';
  if AppendTab and (wbList.Count > 0) then
    FormPublic.NewPage(PageIndex + 1, 'about:blank', True)  else    FormPublic.NewPage(wbList.Count, 'about:blank', True);
  FormPublic.NTabLock.Checked := false;
  FormPublic.NWebAutoRefresh.Checked := false;
  FormPublic.NCurrNoSilent.Checked := false;
  //ToolBarStatusBar.Repaint;
  if ToolBarTabParent.ButtonCount >= 1 then
  FormPublic.AddressSetFocus;
  //FormMain.BBGO.Repaint;
  //FormMain.BBGO.Refresh;
  finally
  //FormMain.ToolBarAddress.Repaint;
  //LockWindowUpdate(0);
  FormMain.ToolButton100.Caption := ZoomStr;
  end;
except end;
end;

procedure TFormMain.ToolBarTabParentCustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  Bitmap: TBitmap;
  SrcR, DestR: TRect;
  Flags: Longint;
  Caption: string;

  i: Integer;

  R: TRect;
  CloseHintCurC: Boolean;
begin                             
try
  if wbList.Count <= 0 then exit;
  if CloseApp then exit;
  if TFormWebBrowser(wbList[PageIndex]).Closeing then exit;

  //if not ShowCloseOK then ToolBarTabClose.Hide;
  DefaultDraw := False;
  try

  {
  if Button.Index = PageIndex then
    Bitmap := ImageTabYes.Picture.Bitmap else
    Bitmap := ImageTabNo.Picture.Bitmap;
  SrcR := ImageTabYes.ClientRect;
  SrcR.Right := 5;
  DestR := Button.BoundsRect;
  DestR.Right := DestR.Left + 5;
  Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
  OffsetRect(SrcR, ImageTabYes.Width - 5, 0);
  OffsetRect(DestR, Button.Width - 5, 0);
  Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
  OffsetRect(SrcR, - 5, 0);
  DestR.Right := DestR.Left;
  DestR.Left := Button.Left + 5;
  Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
  SrcR := Button.BoundsRect;
  Inc(SrcR.Left, 5);
  Dec(SrcR.Right, 5);
  }
  if Button.Index = PageIndex then
    Bitmap := {ImageTabYes}ImageTabYes0.Picture.Bitmap else
    Bitmap := {ImageTabNo}ImageTabNo0.Picture.Bitmap;
  SrcR := {ImageTabYes}ImageTabYes0.ClientRect;
  SrcR.Right := 5;
  DestR := Button.BoundsRect;
  DestR.Right := DestR.Left + 5;
  Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
  OffsetRect(SrcR, {ImageTabYes}ImageTabYes0.Width - 5, 0);
  OffsetRect(DestR, Button.Width - 5, 0);
  Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
  OffsetRect(SrcR, - 5, 0);
  DestR.Right := DestR.Left;
  DestR.Left := Button.Left + 5;
  Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
  SrcR := Button.BoundsRect;
  Inc(SrcR.Left, 5);
  Dec(SrcR.Right, 5);  
  //{
  //ShowCloseHint := true;
  if not ShowCloseHint then
  begin
    ToolBarTabClose.Visible := false;
    //halt;
  end
  else
  //if ToolBarTabClose.Parent <> PaintPanelMTop then ToolBarTabClose.Parent := PaintPanelMTop; //ToolBarTabParent;
  if {(ShowCloseHint)  and} (not ShowCloseOK) and (Button.Index = PageIndex) then
  begin
    CloseUpdate := false;
    //ToolBarTabClose.Hide;
    LockWindowUpdate(FormMain.Handle);
    try
    ShowCloseOK := true; //Self.Caption := IntToStr(Random(999999999));
    CloseHintCurC := false;
    if CloseHintCur <> PageIndex then
    begin
      ToolBarTabClose.Hide;
      CloseHintCur := PageIndex;
    end;
    R := FormMain.ToolBarTabParent.Buttons[PageIndex].BoundsRect;

    //if PaintBox1.Left = R.Right - PaintBox1.Width - 2 then exit;
    if TabAt = 0 then
    FormMain.ToolBarTabClose.Top := {ToolBarTabParent.Top}FormMain.PanelWBMain.Top + 7  //R.Top + 72;
    else
    if (TabAt = 1) and (PaintPanelMTop.Align = alBottom) then
    FormMain.ToolBarTabClose.Top := {ToolBarTabParent.Top}PaintPanelMTop.Top + 78;  //R.Top + 72;

    if not {TBTabNewShow}ToolBarTabNew.Visible then
    begin
      if FormMain.PanelLeft.Visible and not SideStatShape then                       
      FormMain.ToolBarTabClose.Left := R.Right - FormMain.ToolBarTabClose.Width + FormMain.PanelLeft.Width  {+ 66}  - ToolBarTabNew.Width + 24
      else
      FormMain.ToolBarTabClose.Left := R.Right - FormMain.ToolBarTabClose.Width {+ 66}  - ToolBarTabNew.Width + 24;
    end
    else
    begin
      if FormMain.PanelLeft.Visible and not SideStatShape then
      FormMain.ToolBarTabClose.Left := R.Right - FormMain.ToolBarTabClose.Width + FormMain.PanelLeft.Width  {+ 66}   + 24
      else
      FormMain.ToolBarTabClose.Left := R.Right - FormMain.ToolBarTabClose.Width {+ 66} + 24;
    end;
    //FormMain.ToolBarTabClose.Left := R.Right - FormMain.ToolBarTabClose.Width + 66;
    if (CloseHintCurC) or (not ToolBarTabClose.Visible) then FormMain.ToolBarTabClose.Visible := True;
    //dddddddddddddddddddddddddddd
    finally
    LockWindowUpdate(0);
    CloseUpdate := true;   
    end;
  end;
  //}
  //if Button.Index = PageIndex then ImageListWebIcon.Draw(Sender.Canvas, Button.Left + 3, Button.Top + 5, Button.Index);
  //{
  if ShowWebIcon then
  begin
    //Self.Caption := IntToStr(Random(999999999));       UpdateWebIconOk
    if {(Button.Index = PageIndex) and} (not TFormWebBrowser(wbList[PageIndex]).UpdateWebIconOk) then
    begin
      //Self.Caption := IntToStr(Random(999999999));
      for I := 0 to ToolBarTabParent.ButtonCount - 1 do ToolBarTabParent.Buttons[I].ImageIndex := I;
      //ImageListWebIcon.Draw(Sender.Canvas, Button.Left + 3, Button.Top + 5, Button.ImageIndex);     //hhhhhhhhhhhhhhhhhhhhhh
      //TFormWebBrowser(wbList[PageIndex]).UpdateWebIconOk := true;
    end;
    ImageListWebIcon.Draw(Sender.Canvas, Button.Left + 3, Button.Top + 5, Button.ImageIndex);     //hhhhhhhhhhhhhhhhhhhhhh
    TFormWebBrowser(wbList[PageIndex]).UpdateWebIconOk := true;
  end;
  //}
  //if (Button.Index = PageIndex) then ImageListWebIcon.Draw(Sender.Canvas, Button.Left + 3, Button.Top + 5, Button.ImageIndex);   //DrawButtonIcon;

  finally

  if Button.Index < wbList.Count then
  Caption := TFormWebBrowser(wbList[Button.Index]).Caption;
  //Caption := Button.Caption;
  //Hint := TFormWebBrowser(wbList[Button.Index]).Hint;
  Flags := DT_VCENTER or DT_SINGLELINE;

  //{
    if Sender.Canvas.TextWidth(Caption) > Button.Width then
      Flags := Flags or DT_LEFT or DT_END_ELLIPSIS
    else
      Flags := flags or DT_CENTER;
  //end;
  SetBkMode(Sender.Canvas.Handle, TRANSPARENT);
  DrawText(Sender.Canvas.Handle, PChar(Caption), -1, SrcR, Flags);
  //}
  end;
except end;
end;

procedure TFormMain.ToolBarTabParentDblClick(Sender: TObject);
begin
try
  NewTabAtEnd := true;
  ToolButtonTabNew.Click;
except end;
end;

procedure TFormMain.CBURL2Click(Sender: TObject);
begin
try
    FormMain.BBGO.OnClick(Sender);
except end;
end;

procedure TFormMain.CBURL2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  KeyState: TKeyBoardState;
begin
try
  try
  if (Shift=[ssCtrl]) and (Key=13) then
  begin
    MoreUrlOpen := false;
    CBURL.Text:='http://www.'+Trim(CBURL.Text)+'.com/';
    FormMain.BBGO.OnClick(Sender);
    FormPublic.DocumentSetFocus;
    exit;
  end;
  if (Shift=[ssAlt]) and (Key=13) then
  begin
    MoreUrlOpen := false;
    CBURL.Text:='http://www.'+Trim(CBURL.Text)+'.net/';
    FormMain.BBGO.OnClick(Sender);
    FormPublic.DocumentSetFocus;
    exit;
  end;
  if (Shift=[ssShift]) and (Key=13) then
  begin
    MoreUrlOpen := false;
    CBURL.Text:='http://www.'+Trim(CBURL.Text)+'.com.cn/';
    FormMain.BBGO.OnClick(Sender);
    FormPublic.DocumentSetFocus;
    exit;
  end;
  if Key=VK_RETURN then
  begin    MoreUrlOpen := false;    FormMain.BBGO.OnClick(Sender);    FormPublic.DocumentSetFocus;    exit;  end;
  finally
  end;
except end;
end;

procedure TFormMain.ToolBarTabControlCustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  Index: Integer;
begin
try     
  //LockWindowUpdate(FormMain.Handle);
  DefaultDraw := False;
  Index := Button.ImageIndex;
  if cdsHot in State then Inc(Index, 3);
  if cdsSelected in State then Inc(Index, 3);
  ImageListRightSmall.Draw(Sender.Canvas, Button.Left + 2, Button.Top + 4, Index);
  //LockWindowUpdate(0);
except end;
end;

procedure TFormMain.TabListClick(Sender: TObject);
var
  I: Integer;
begin
try
  try
  I := StrToInt((Sender as TMenuItem).Hint);
  //ToolBarTabParent.Buttons[I].Click;
  FormPublic.TabClick2(I);

  if FormMain.ToolBarTabParent.ButtonCount * TabWidth + 10 < FormMain.ToolBarTabParent.Width then
  begin
    FormMain.ToolBarTabParent.Indent :=  0;
    exit;
  end
  else
  begin
    ToolBarTabParent.Indent := ((TabWidth * I) * -1);
    //FormPublic.TabCloseHint;
  end;
  //if ((ToolBarTabParent.Buttons[I].Left + TabWidth) < (ToolBarTabParent.Indent * -1) or (ToolBarTabParent.Buttons[I].Left + TabWidth > ToolBarTabParent.Indent)) then
  //xxx.
  {
  if (ToolBarTabParent.Indent <> 0) and (((ToolBarTabParent.Buttons[I].Left + TabWidth) < (ToolBarTabParent.Indent * -1)) or (ToolBarTabParent.Buttons[I].Left + TabWidth > ToolBarTabParent.Indent)) then
  begin
    ToolBarTabParent.Indent := ((TabWidth * I) * -1);
  end;
  }
  finally
    FormMain.ToolBarTabParent.RePaint;
  end;
except end;
end;

procedure TFormMain.ToolButtonTabListClick(Sender: TObject);
var
  I: Integer;
  Str: String;
  MenuItem: TMenuItem;
  Pt: TPoint;
begin
try
  if wbList.Count <= 0 then exit;
  try
  for I := PopupMenuTabList.Items.Count - 1 to 0 do
  PopupMenuTabList.Items[I].Free;
  PopupMenuTabList.Items.Clear;
  finally

  MenuItem := TMenuItem.Create(nil);
  MenuItem.Caption := '全部关闭&';
  MenuItem.Visible := true;
  MenuItem.OnClick := AllClose;
  PopupMenuTabList.Items.Add(MenuItem);

  MenuItem := TMenuItem.Create(nil);
  MenuItem.Caption := '-';
  MenuItem.Visible := true;
  PopupMenuTabList.Items.Add(MenuItem);

  for I := 0 to wbList.Count - 1 do
  begin
    Str := TFormWebBrowser(wbList[I]).WebTitle;
    if ((Trim(Str) = '') or (LowerCase(Trim(Str)) = 'about:blank')) then
    Str := TFormWebBrowser(wbList[I]).WebBrowser.LocationName;

    if Trim(Str) = '' then      
    begin
      if TFormWebBrowser(wbList[I]).WebBrowser.Busy then Str := '正在打开中...'
      else Str := '未知页';
    end
    else
    begin
      {
      if ShowWebIcon then
      begin
        Case WebIconNeedBlankCount of
        2: Str := Copy(Str, 3, 22);
        3: Str := Copy(Str, 4, 22);
        4: Str := Copy(Str, 5, 22);
        5: Str := Copy(Str, 6, 22);
        6: Str := Copy(Str, 7, 22);
        end;
      end
      else
      }
      if Length(Str) > 22 then
      Str := Copy(Str, 1, 22) + '...';
    end;

    MenuItem := TMenuItem.Create(nil);
    MenuItem.Caption := Str + '&';
    MenuItem.Hint := IntToStr(I);
    //MenuItem.RadioItem := true;
    //MenuItem.AutoCheck := true;
    MenuItem.Visible := true;
    MenuItem.OnClick := TabListClick;
    if I = PageIndex then
    begin
      //MenuItem.RadioItem := true;
      MenuItem.Checked := true;
    end;
    PopupMenuTabList.Items.Add(MenuItem);
  end;
  //GetCursorPos(Pt);
  Pt.x := ToolButtonTabList.Left + ToolButtonTabList.Width; // - PopupMenu1.Width;
  Pt.y := ToolButtonTabList.Height;  Pt := ToolButtonTabList.ClientToScreen(Pt);  //PopupMenu1.Popup(Pt.X, Pt.Y);
  PopupMenuTabList.Popup(Pt.X, Pt.Y);
  end;
except end;
end;

procedure TFormMain.ToolButtonTabCloseClick(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  FormPublic.ClosePage();
except end;
end;

procedure TFormMain.ToolButtonFavoritesClick(Sender: TObject);
begin
try
  //PanelLeft.Visible := not PanelLeft.Visible;
  if SideStatShape then
  begin
    SBSideStatShape.OnClick(Sender);
    PanelLeft.Visible := true;
  end
  else PanelLeft.Visible := not PanelLeft.Visible;
  ShowCloseOK := false;
except end;
end;

procedure TFormMain.FavoritesTree1GetImageIndex(Sender: TObject;
  Node: TTreeNode);
begin
try
  case TNodeType(Node.Data) of
    ntItem: Node.ImageIndex := 2;
    ntEmptyFolder, ntFolder:
      if Node.Expanded then
        Node.ImageIndex := 1 else Node.ImageIndex := 1;
  end;
except end;
end;

procedure TFormMain.FavoritesTree1GetSelectedIndex(Sender: TObject;
  Node: TTreeNode);
begin
try
  case TNodeType(Node.Data) of
    ntItem: Node.SelectedIndex := 2;
    ntEmptyFolder, ntFolder:
      if Node.Expanded then
        Node.SelectedIndex := 1 else Node.SelectedIndex := 1;
  end;
except end;
end;

procedure TFormMain.FavoritesTree1Navigate(Sender: TObject;
  const URL: String);
begin
try
  {
  //Showmessage(Url);
  CBURL.Text := URL;
  BBGO.OnClick(Sender);
  }
  CBURL.Text := URL;
  FormMain.BBGO.OnClick(Sender);
except end;
end;

procedure TFormMain.ToolBar6CustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
try    //exit;
  //if not PaintPanelFavorite.Visible then exit;
  if not PanelLeft.Visible then exit;
  with Sender.Canvas do
  begin
    CopyRect(ARect, {ImageButton}Imagebg.Picture.Bitmap.Canvas, {ImageButton}Imagebg.ClientRect);
    //Pen.Color := TColor($808080);
    //MoveTo(0, Sender.Height -1);
    //LineTo(Sender.Width, Sender.Height -1);
  end;
except end;
end;

procedure TFormMain.ToolBar6CustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  SrcR, DestR: TRect;
  Bitmap: TBitmap;
  R: TRect;
  L: Integer;
  Flags: Longint;
begin
try
  //if (not PaintPanelFavorite.Visible) {and ((Sender as TToolBar) <> ToolBarFavorite)} then exit;
  if not PanelLeft.Visible then exit;
  DefaultDraw := False;
  if {Button.Down}cdsSelected in State then Bitmap := ImageMenuMouseDown.Picture.Bitmap else
    if cdsHot in State then Bitmap := {ImageTitleMenuMouseMove}ImageMenuMouseDown.Picture.Bitmap else Bitmap := nil;
      //if cdsSelected in State then Bitmap := {ImageTitleMenuMouseMove}ImageButtonHot.Picture.Bitmap else Bitmap := nil;

  if Assigned(Bitmap) then
  begin
    SrcR := Rect(0, 0, 5, ImageMenuMouseDown.Height);
    DestR := SrcR;
    Inc(DestR.Bottom, 2);
    OffsetRect(DestR, Button.Left, 2);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
    OffsetRect(SrcR, ImageMenuMouseDown.Width - 5, 0);
    OffsetRect(DestR, Button.Width - 5, 0);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
    OffsetRect(SrcR, -3, 0);
    DestR.Left := Button.Left + 5;
    Dec(DestR.Right, 5);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
  end;
  {
  if Button.ImageIndex >= 0 then
  begin
    L := Button.Left + 3;
    if Button.Caption = '' then Inc(L, 2);
    if (TFormWebBrowser(wbList[PageIndex]).NoCleanFlash) then
    ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex)
    else if Button = ToolButtonFlash then
    ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex + 1)
    else ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex);
  end;
  }
  if Button.Caption <> '' then
  begin
    R := Button.BoundsRect;
    Inc(R.Top, 2);
    Flags := DT_VCENTER or DT_SINGLELINE;
    if Button.ImageIndex >= 0 then
    begin
      Inc(R.Left, 20);
      Flags := Flags or DT_LEFT;
    end else
      Flags := Flags or DT_CENTER;
    SetBkMode(Sender.Canvas.Handle, TRANSPARENT);
    DrawText(Sender.Canvas.Handle, PChar(Button.Caption), -1, R, Flags);
  end;
except end;
end;

procedure TFormMain.ToolBar12CustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
try    //exit;
  if not PanelLeft.Visible then exit;
  if not PanelLeft.Visible then exit;
  with Sender.Canvas do
  begin
    CopyRect(ARect, {ImageButton}Imagebg.Picture.Bitmap.Canvas, {ImageButton}Imagebg.ClientRect);
    Pen.Color := TColor($808080);
    MoveTo(0, Sender.Height -1);
    //LineTo(Sender.Width, Sender.Height -1);
  end;
except end;
end;

procedure TFormMain.ToolBar12CustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  SrcR, DestR: TRect;
  Bitmap: TBitmap;
  R: TRect;
  L: Integer;
  Flags: Longint;
begin
try
  //{
  if not PanelLeft.Visible then exit;
  DefaultDraw := False;
  if Button.Down then Bitmap := ImageMenuMouseDown.Picture.Bitmap else
    if cdsHot in State then Bitmap := {ImageTitleMenuMouseMove}ImageMenuMouseDown.Picture.Bitmap else Bitmap := nil;
      //if cdsSelected in State then Bitmap := {ImageTitleMenuMouseMove}ImageButtonHot.Picture.Bitmap else Bitmap := nil;
    //}

  //{
  if Assigned(Bitmap) then
  begin
    SrcR := Rect(0, 0, 5, ImageMenuMouseDown.Height);
    DestR := SrcR;
    Inc(DestR.Bottom, 2);
    OffsetRect(DestR, Button.Left, 2);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
    OffsetRect(SrcR, ImageMenuMouseDown.Width - 5, 0);
    OffsetRect(DestR, Button.Width - 5, 0);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
    OffsetRect(SrcR, -3, 0);
    DestR.Left := Button.Left + 5;
    Dec(DestR.Right, 5);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
  end;
  //}

  //{    allmode
  if Button.ImageIndex >= 0 then
  begin
    L := Button.Left + 3;
    if Button.Caption = '' then Inc(L, 2);
    ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex);
    {
    if (TFormWebBrowser(wbList[PageIndex]).AllMode) then
    ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex)
    else if Button = ToolButtonAllMode then
    ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex + 1)
    else ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex);
    }
  end;
  //}

  //{
  if Button.Caption <> '' then
  begin
    R := Button.BoundsRect;
    Inc(R.Top, 2);
    Flags := DT_VCENTER or DT_SINGLELINE;
    if Button.ImageIndex >= 0 then
    begin
      Inc(R.Left, 20);
      Flags := Flags or DT_LEFT;
    end else
      Flags := Flags or DT_CENTER;
    SetBkMode(Sender.Canvas.Handle, TRANSPARENT);
    DrawText(Sender.Canvas.Handle, PChar(Button.Caption), -1, R, Flags);
  end;
  //}

  {
    if (ProBar.Visible) then
    begin
      ProBar.Position := 0;
      ProBar.Visible := false;
      //LabelPro.Visible := false;
    end;
  }
except end;
end;

procedure TFormMain.ToolBarLeftTopControlCustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
try    //exit;
  //if not PaintPanelFavorite.Visible then exit;
  with Sender.Canvas do
  begin
    CopyRect(ARect, {ImageButton}Imagebg.Picture.Bitmap.Canvas, {ImageButton}Imagebg.ClientRect);
    //Pen.Color := TColor($808080);
    //MoveTo(0, Sender.Height -1);
    //LineTo(Sender.Width, Sender.Height -1);
  end;
except end;
end;

procedure TFormMain.SBLeftTopCloseClick(Sender: TObject);
begin
try
  PanelLeft.Hide;
  ShowCloseOK := false;
  if (wmp.playState >= 2) and (wmp.Parent = PaintPanelMusicPlayTop) then wmp.Controls.Stop;
except end;
end;

procedure TFormMain.TBAddFavClick(Sender: TObject);
begin
try
  FormPublic.NAddFavorite.OnClick(Sender);
except end;
end;

procedure TFormMain.ToolButtonAddFavoritesClick(Sender: TObject);
begin
try
  //if FavDirMe Then SetForm.SetFavoriteDir(FavoritFolder,false);
  FormPublic.NAddFavorite.OnClick(Sender);
  //if FavDirMe Then SetForm.SetFavoriteDir(SFavoritFolder,false);
except end;
end;

procedure TFormMain.ToolBarTabNewCustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  Index: Integer;
begin
try    //exit;
  if not ToolBarTabNew.Visible then exit;
  DefaultDraw := False;
  Index := Button.ImageIndex;
  //{
  if cdsHot in State then Inc(Index, 2);
  if cdsSelected in State then Inc(Index, 2);
  //}
  ImageListTabLeft.Draw(Sender.Canvas, Button.Left + 2, Button.Top + 4, Index);
except end;
end;

procedure TFormMain.ToolBarTabParentMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
//{
  var
  Pt: TPoint;
//}
begin
try
  if Button = mbLeft then
  begin
    if WindowState = wsMaximized then exit;
    ReleaseCapture;
    PerForm(WM_SYSCOMMAND, $f012, 0);
  end;
  //{
  if (Button=mbRight) then
  if TabRClickNewPage then
  begin       
    NewTabAtEnd := true;
    ToolButtonTabNew.Click;
  end
  else
  begin
    GetCursorPos(Pt);
    FormPublic.PopupMenuShowCote.Popup(Pt.X, Pt.Y);
  end;
  //}
except end;
end;

procedure TFormMain.ToolBarFavoriteCustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
try    //exit;
  if not PaintPanelFavorite.Visible then exit;
  Sender.Canvas.CopyRect(ARect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
  {
  with Sender.Canvas do
  begin
    CopyRect(ARect, ImageButton.Picture.Bitmap.Canvas, ImageButton.ClientRect);
    Pen.Color := TColor($808080);
    MoveTo(0, Sender.Height -1);
    //LineTo(Sender.Width, Sender.Height -1);
  end;
  }
except end;
end;

procedure TFormMain.ToolBarFavoriteCustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  SrcR, DestR: TRect;
  Bitmap: TBitmap;
  R: TRect;
  L: Integer;
  Flags: Longint;
begin
try
  //exit;
  //if (not PaintPanelFavorite.Visible) {and ((Sender as TToolBar) <> ToolBarFavorite)} then exit;
  if not PaintPanelFavorite.Visible then exit;
  //DefaultDraw := False;

  //{             
  DefaultDraw := False;
  {if Button.Down}if cdsSelected in State then Bitmap := ImageMenuMouseDown.Picture.Bitmap else
    if cdsHot in State then Bitmap := ImageMenuMouseDown.Picture.Bitmap else Bitmap := nil;
      //if cdsSelected in State then Bitmap := {ImageTitleMenuMouseMove}ImageButtonHot.Picture.Bitmap else Bitmap := nil;
  //}

  //Bitmap := ImagebgWhite.Picture.Bitmap;   {ImageTitleMenuMouseMove}
  //BitMap := nil;
  //{
  if Assigned(Bitmap) then
  begin
    SrcR := Rect(0, 0, 5, ImageMenuMouseDown.Height);
    DestR := SrcR;
    Inc(DestR.Bottom, 2);
    OffsetRect(DestR, Button.Left, 2);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
    OffsetRect(SrcR, ImageMenuMouseDown.Width - 5, 0);
    OffsetRect(DestR, Button.Width - 5, 0);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
    OffsetRect(SrcR, -3, 0);
    DestR.Left := Button.Left + 5;
    Dec(DestR.Right, 5);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
  end;
  //}
  //{    allmode
  if Button.ImageIndex >= 0 then
  begin
    L := Button.Left + 3;
    if Button.Caption = '' then Inc(L, 2);
    ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex);
    {
    if (TFormWebBrowser(wbList[PageIndex]).AllMode) then
    ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex)
    else if Button = ToolButtonAllMode then
    ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex + 1)
    else ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex);
    }
  end;
  //}

  //{
  if Button.Caption <> '' then
  begin
    R := Button.BoundsRect;
    Inc(R.Top, 2);
    Flags := DT_VCENTER or DT_SINGLELINE;
    if Button.ImageIndex >= 0 then
    begin
      Inc(R.Left, 20);
      Flags := Flags or DT_LEFT;
    end else
      Flags := Flags or DT_CENTER;
    SetBkMode(Sender.Canvas.Handle, TRANSPARENT);
    DrawText(Sender.Canvas.Handle, PChar(Button.Caption), -1, R, Flags);
  end;
  //}

  {
    if (ProBar.Visible) then
    begin
      ProBar.Position := 0;
      ProBar.Visible := false;
      //LabelPro.Visible := false;
    end;
  }
except end;
end;

procedure TFormMain.ToolBarStatusBar_CustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  SrcR, DestR: TRect;
  Bitmap: TBitmap;
  R: TRect;
  L: Integer;
  Flags: Longint;
begin
try
  if wbList.Count <= 0 then exit;
  //{
  DefaultDraw := False;
  if Button.Down then Bitmap := ImageMenuMouseDown.Picture.Bitmap else
    if cdsHot in State then Bitmap := {ImageTitleMenuMouseMove}ImageMenuMouseDown.Picture.Bitmap else Bitmap := nil;
      //if cdsSelected in State then Bitmap := {ImageTitleMenuMouseMove}ImageButtonHot.Picture.Bitmap else Bitmap := nil;
    //}

  //{
  if Assigned(Bitmap) then
  begin
    SrcR := Rect(0, 0, 5, ImageMenuMouseDown.Height);
    DestR := SrcR;
    Inc(DestR.Bottom, 2);
    OffsetRect(DestR, Button.Left, 2);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
    OffsetRect(SrcR, ImageMenuMouseDown.Width - 5, 0);
    OffsetRect(DestR, Button.Width - 5, 0);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
    OffsetRect(SrcR, -3, 0);
    DestR.Left := Button.Left + 5;
    Dec(DestR.Right, 5);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
  end;
  //}

  //{
  if Button.ImageIndex >= 0 then
  begin
    L := Button.Left + 3;
    if Button.Caption = '' then Inc(L, 2);
    {
    if (TFormWebBrowser(wbList[PageIndex]).NoCleanFlash) then
    ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex)
    else if Button = ToolButtonFlash then
    ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex + 1)
    else ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex);
    }
    //ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex);
    if Button = ToolButtonFlash then
    begin
      if (TFormWebBrowser(wbList[PageIndex]).NoCleanFlash) then
      ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex)
      else
      ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex + 1);
    end
    else //ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex);

    if Button = TBAllMode then
    begin
      if (TFormWebBrowser(wbList[PageIndex]).AllMode) then
      begin
        ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex);
        TBAllMode.Hint := '目前状态:完整模式/F10';
      end
      else
      begin
        ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex + 1);
        TBAllMode.Hint := '目前状态:安全模式/F11';
      end;
    end
    else ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex);

  end;
  //}

  //{
  if Button.Caption <> '' then  
  begin
    R := Button.BoundsRect;
    Inc(R.Top, 2);
    Flags := DT_VCENTER or DT_SINGLELINE;
    if Button.ImageIndex >= 0 then
    begin
      Inc(R.Left, 20);
      Flags := Flags or DT_LEFT;
    end else
      Flags := Flags or DT_CENTER;
    SetBkMode(Sender.Canvas.Handle, TRANSPARENT);
    DrawText(Sender.Canvas.Handle, PChar(Button.Caption), -1, R, Flags);
  end;
  //}

  {
    if (ProBar.Visible) then
    begin
      ProBar.Position := 0;
      ProBar.Visible := false;
      //LabelPro.Visible := false;
    end;
  }
except end;
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
try
  try    
    CloseApp := true;
    //if InstallTrayIcon then InstallIcon(false,FormMain.Handle,FormMain.Icon.Handle,TitleStr);
    //AllClose(Sender);
    if ExitCleanAllHistory then
    begin
      FormPublic.ClearAll;
      DeleteDirFile((GetSystemFolderDir(CSIDL_RECENT)));
      Sleep(200);
    end
    else
    begin                         
      if CleanAddress then FormPublic.NCleanAddress.OnClick(Sender)
      else FormMain.CBURL.Items.SaveToFile(MyDir + URLFile);
      if CleanHistory then
      begin
        try
        //FormPublic.NCleanHistory.OnClick(Sender);
        //DeleteDirFile((GetSystemFolderDir(CSIDL_HISTORY)));
        //DeleteDir((GetSystemFolderDir(CSIDL_HISTORY)));
        //DelHistory;
        FormPublic.ClearHistory;
        //FormPublic.ClearUrl;
        finally
        TFormWebBrowser(wbList[PageIndex]).WebBrowser.ClearHistory;
        //ThreadI:=71;
        //RunProcess.Create(False);
        end;
      end;
      if CleanCache then
      begin
        try
        //FormPublic.NCleanCache.OnClick(Sender);
        //DelRegCache;
        //FormPublic.ClearUrl;       
        finally
        TFormWebBrowser(wbList[PageIndex]).WebBrowser.ClearCache;
        //ThreadI:=72;
        //RunProcess.Create(False);
        end;
      end;                        
      if CleanCookies then
      begin
        try
        //FormPublic.NCleanCookies.OnClick(Sender);
        //DelCookie;
        finally
        FormPublic.ClearCookies;
        //ThreadI:=73;
        //RunProcess.Create(False);
        end;
      end;
      if CleanRecent then
      begin
        //FormPublic.NCleanRecent.OnClick(Sender);
        DeleteDirFile((GetSystemFolderDir(CSIDL_RECENT)));
      end;
      Sleep(200);
    end;
  finally
    WritePrivateProfileString('RunData','TrueClose','1',PChar(MyDir+ConfigFile));
    if InstallTrayIcon then InstallIcon(false,FormMain.Handle,Application.Icon.Handle,TitleStr);
    UpdateTypedUrls{(Url)};   
  end;
except end;
end;

procedure TFormMain.ToolButton100Click(Sender: TObject);
begin
try
  //{
  case StrToInt(Copy(ToolButton100.Hint,1,Length(ToolButton100.Hint)-1)) of
  50:
  begin
    ToolButton100.Caption := '75%';
    ToolButton100.Hint := '75%';
    FormPublic.N75.OnClick(Sender);
  end;
  75:
  begin
    ToolButton100.Caption := '100%';
    ToolButton100.Hint := '100%';
    FormPublic.N100.OnClick(Sender);
  end;
  {
  100:
  begin
    ToolButton100.Caption := '125%';
    ToolButton100.Hint := '125%';
    FormPublic.N125.OnClick(Sender);
  end;
  125:
  begin
    ToolButton100.Caption := '150%';
    ToolButton100.Hint := '150%';
    FormPublic.N150.OnClick(Sender);
  end;
  }
  //
  100:
  begin
    ToolButton100.Caption := '110%';
    ToolButton100.Hint := '110%';
    FormPublic.N110.OnClick(Sender);
  end;
  110:
  begin
    ToolButton100.Caption := '120%';
    ToolButton100.Hint := '120%';
    FormPublic.N120.OnClick(Sender);
  end;
  120:
  begin
    ToolButton100.Caption := '125%';
    ToolButton100.Hint := '125%';
    FormPublic.N125.OnClick(Sender);
  end;
  125:
  begin
    ToolButton100.Caption := '130%';
    ToolButton100.Hint := '130%';
    FormPublic.N130.OnClick(Sender);
  end;
  130:
  begin
    ToolButton100.Caption := '150%';
    ToolButton100.Hint := '150%';
    FormPublic.N150.OnClick(Sender);
  end;
  //
  150:
  begin
    ToolButton100.Caption := '200%';
    ToolButton100.Hint := '200%';
    FormPublic.N200.OnClick(Sender);
  end;
  200:
  begin
    ToolButton100.Caption := '50%';
    ToolButton100.Hint := '50%';
    FormPublic.N50.OnClick(Sender);
  end;         
  else
  begin
    ToolButton100.Caption := '100%';
    ToolButton100.Hint := '100%';
    FormPublic.N100.OnClick(Sender);
  end;
  end;
  //}
except end;
end;

procedure TFormMain.ToolButtonFlashClick(Sender: TObject);
{
var
  UserIO: TUserInterfaceOptions;
  DownloadCO: TDownloadControlOptions;
}
begin
try
  if wbList.Count = 0 then exit;
  try
  //ToolButtonFlash
  //{
  TFormWebBrowser(wbList[PageIndex]).NoCleanFlash := not TFormWebBrowser(wbList[PageIndex]).NoCleanFlash;
  //ImageList3.Move(14, 15);
  //ClearAd((sender as TEmbeddedWB), TFormWebBrowser(wbList[PageIndex]).NoCleanFlash);
  if not TFormWebBrowser(wbList[PageIndex]).NoCleanFlash then
  ClearAd(TFormWebBrowser(wbList[PageIndex]).WebBrowser, TFormWebBrowser(wbList[PageIndex]).NoCleanFlash)
  else
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.Refresh;
  {
  if TFormWebBrowser(wbList[PageIndex]).NoCleanFlash then
  ToolButtonFlash.Hint := '屏蔽当前页FLASH'
  else
  ToolButtonFlash.Hint := '不屏蔽当前页FLASH';
  }
  {
  TFormWebBrowser(wbList[PageIndex]).AllMode := not TFormWebBrowser(wbList[PageIndex]).AllMode;
  if TFormWebBrowser(wbList[PageIndex]).AllMode then
  begin
    //Include(UserIO, NO3DBORDER);

    Include(DownloadCO, DLCTL_DLIMAGES);
    Include(DownloadCO, DLCTL_VIDEOS);
    Include(DownloadCO, DLCTL_BGSOUNDS);

    Include(DownloadCO, DLCTL_RESYNCHRONIZE);
    Include(DownloadCO, DLCTL_PRAGMA_NO_CACHE);
    TFormWebBrowser(wbList[PageIndex]).WebBrowser.DownloadOptions:=DownloadCO;
  end
  else
  begin
    //Include(UserIO, NO3DBORDER);

    Include(DownloadCO, DLCTL_NO_JAVA);
    Include(DownloadCO, DLCTL_NO_SCRIPTS);
    Include(DownloadCO, DLCTL_NO_DLACTIVEXCTLS);
    Include(DownloadCO, DLCTL_NO_RUNACTIVEXCTLS);
    Include(DownloadCO, DLCTL_RESYNCHRONIZE);
    Include(DownloadCO, DLCTL_PRAGMA_NO_CACHE);

    TFormWebBrowser(wbList[PageIndex]).WebBrowser.DownloadOptions:=DownloadCO;
  end;

  //InternetSetOption(nil,   INTERNET_OPTION_SETTINGS_CHANGED,   nil,   0);
  //InternetSetOption(nil,   INTERNET_OPTION_REFRESH   ,   nil,   0);

  //TFormWebBrowser(wbList[PageIndex]).WebBrowser.Refresh;
  //TFormWebBrowser(wbList[PageIndex]).WebBrowser.Navigate(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationURL)  //.Refresh;
  }
  finally
  FormMain.ToolBarStatusBar.Repaint;
  end;
except end;
end;

procedure TFormMain.ActionGetScreenExecute(Sender: TObject);
begin
try                          
  FormPublic.NGetScreen.OnClick(Sender);
except end;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
try
  try    
  //CloseApp:=true;
  //WritePrivateProfileString('RunData','TrueClose','1',PChar(MyDir+ConfigFile));
  //if InstallTrayIcon then InstallIcon(false,FormMain.Handle,FormMain.Icon.Handle,TitleStr);
  finally
  wbList.Free;
  LabelPro.Free;
  probar.Free;
  end;
except end;
end;

procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  Flag: Boolean;
begin
try
  if (NoClose) and (FormPublic.NPopupExit.Enabled) then
  begin    //ShowMessage('no close');
    CanClose := false;
      FormPublic.AllFormHide(0);
      ShowWindow(Application.Handle, SW_HIDE);
      SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW);
      ShowWindow(Application.Handle, SW_SHOW);
      FormMain.Hide;
      //InstallIcon(false,Self.Handle,Application.Icon.Handle,TitleStr);
      SetForm.TimerStatusBar.Enabled:=false;
      if (wmp.playState = 3) then wmp.Controls.Stop;
    exit;
  end;
  
  try
  //ShowMessage('');
  if AppCloseHint then             
  begin
    Flag := false;
    if (wbList.Count >= 1) then
    begin
      if wbList.Count = 1 then
      if (TFormWebBrowser(wbList[0]).WebBrowser.LocationUrl = 'about:blank') then Flag := true;
      if not Flag then
      if MessageBox(Handle,'确认要退出' + BrowserName + '浏览器吗？','询问',MB_YESNO+MB_ICONINFORMATION)=ID_NO then
      begin
        CanClose := false;
        exit;
      end;
    end;
  end;
  //FormUpdate.AbortTransfer := true;
  CloseApp := true;
  //CBURL.Items.SaveToFile(MyDir + URLFile);
  if wbList.Count = 0 then
  begin
    if FileExists(MyDir+OpenURLListFile) then DeleteFile(MyDir+OpenURLListFile);
    if FileExists(MyDir+OpenURLListFile2) then DeleteFile(MyDir+OpenURLListFile2);
  end 
  else FormPublic.OpenURLListSave(2);

  if {WindowStateII = 1}(FormMain.WindowState = wsNormal{<> wsMaximized}) then
  begin
    WritePrivateProfileString('RunData','MainFormTop',PChar(IntToStr(Self.Top)),PChar(MyDir+ConfigFile));
    WritePrivateProfileString('RunData','MainFormHeight',PChar(IntToStr(Self.Height)),PChar(MyDir+ConfigFile));
    WritePrivateProfileString('RunData','MainFormLeft',PChar(IntToStr(Self.Left)),PChar(MyDir+ConfigFile));
    WritePrivateProfileString('RunData','MainFormWidth',PChar(IntToStr(Self.Width)),PChar(MyDir+ConfigFile));
    WritePrivateProfileString('RunData','WindowMax','0',PChar(MyDir+ConfigFile));
  end
  else
   WritePrivateProfileString('RunData','WindowMax','1',PChar(MyDir+ConfigFile));
  finally
    if NeedUpdate then
    begin
      WritePrivateProfileString('RunData','RunFile',PChar(ExtractFileName(ParamStr(0))),PChar(MyDir+'update.txt'));
      WinExec(PChar(MyDir+UpdateFileName),SW_Show);
    end;
  end;
except end;
end;

procedure TFormMain.TimerOneTimer(Sender: TObject);
var
  //TrueClose:ShortString; //string;
  NextTimeNoAsk:ShortString; //string;
  i:Word; //integer;
  OldURLList:TStringList; 
  Str, Str2:string;
begin
try
  //try
  if AppToExit then exit;
  if TimerRunOne then
  begin
    TimerOne.Enabled := false;
    exit;
  end;
  try
  TimerRunOne := true;
  TimerOne.Enabled := false;

  //FormMain.ToolBarAddress.Repaint;
  //FormMain.OnResize(Sender);

  {
  if WindowMax then
  begin
    //FormMain.WindowState := wsNormal;
    FormMain.WindowState := wsMaximized;
  end;
  }
  if not LoadLastTime then exit;

  if (LoadLastOpenFlag) and (FileExists(MyDir + DataDir + '\' + LastOpenLoadFile)) then exit;

  if not FileExists(MyDir+OpenURLListFile2) then exit;

  OldURLList:=TStringList.Create;
  try
  OldURLList.LoadFromFile(MyDir+OpenURLListFile2);
  if OldURLList.Count<=0 then exit;

  if LoadLastTime then
  begin
    if (OldURLList.Count>0) then
    begin
      //add now
      //ShowMessage(IntToStr(OldURLList.Count));
      if OldURLList.Count = 1 then
      begin
        Str:=Copy(OldURLList.Strings[0],Pos('#',OldURLList.Strings[0])+1,Length(OldURLList.Strings[0])-Pos('#',OldURLList.Strings[0]));
        if Pos(Trim(Str),OpenToUrl)<>0 then exit;
        Str2 := ReadRegValue({HKEY_LOCAL_MACHINE}HKEY_CURRENT_USER, 'Software\Microsoft\Internet Explorer\Main', 0,'Start Page');
        //ShowMessage(Str2);
        if Pos(Str2, Trim(Str)) <> 0 then exit;
        //if Pos(Trim(Str),InitUrl)<>0 then exit;
      end;

      IniFile:=TIniFile.Create(MyDir+ConfigFile);
      try
      //TrueClose:=IniFile.ReadString('RunData','TrueClose','1');
      NextTimeNoAsk:=IniFile.ReadString('setting','NextTimeNoAsk','0');

      exit;
      finally
        IniFile.Free;
      end;
    end
    else exit;
  end;
  {
  if Trim(TrueClose)='1' then exit;
  if (OldURLList.Count<=1) then
  begin
    if SetForm.RBOpenHomePage.Checked then exit;
    if ParamCount>=1 then exit;
  end;
  //if MessageDlg('由于未知的错误导致了上一次浏览非正常结束。是否重新打开上次异常退出时的浏览页面？',mtconfirmation,[mbyes,mbno],0)=mryes then
  //if (Application.MessageBox('由于未知的错误导致了上一次浏览非正常结束。'+#10+#13+'是否重新打开上次异常退出时的浏览页面？','确认:',MB_YESNO)=IDYES) then
  if MessageBox(Handle,'由于未知的错误导致了上一次浏览非正常结束。'+#10+#13+'是否重新打开上次异常退出时的浏览页面？','询问',MB_YESNO+MB_ICONINFORMATION)=ID_YES then
  begin
    for i:=0 to OldURLList.Count-1 do
    begin
      if i<>0 then ToolButtonTabNew.OnClick(Sender);
      //Self.PageControl.ActivePageIndex:=i;
      //CBURL.Text:=OpenURLList.Strings[i];
      CBURL.Text:=Copy(OldURLList.Strings[i],Pos('#',OldURLList.Strings[i])+1,Length(OldURLList.Strings[i])-Pos('#',OldURLList.Strings[i]));
      BBGO.OnClick(Sender);
      //Sleep(20);
    end;
  end;
  }
  finally
    OldURLList.Free;
  end;
  finally  
    TimerOne.Enabled := false;
    FormMain.ToolBarAddress.Repaint;
    if not DirectoryExists(MyDir+AutoHintDir) then MkDir(MyDir+AutoHintDir);
    FormAutoHint:=TFormAutoHint.Create(Self);
    //FormAutoHint.ShowModal;
    FormAutoHintCreateOK := true;
  end;
  {
  finally
    FormMain.ToolBarAddress.Repaint;
  end;
  }
except end;
end;

procedure TFormMain.ActionTimerWebAutoRefreshExecute(Sender: TObject);
var
  Str: String;
  I: Integer;
begin
try
  {
  if TFormWebBrowser(wbList[PageIndex]).TimerWebAutoRefresh = nil then
  begin
    TFormWebBrowser(wbList[PageIndex]).TimerWebAutoRefresh := TTimer.Create(TFormWebBrowser(wbList[PageIndex]));
    //TFormWebBrowser(wbList[PageIndex]).TimerWebAutoRefresh.Tag := PageIndex;
    TFormWebBrowser(wbList[PageIndex]).TimerWebAutoRefresh.Enabled := false;
    TFormWebBrowser(wbList[PageIndex]).TimerWebAutoRefresh.OnTimer := FormWebBrowser.TimerWebAutoRefreshTimer;
  end;
  }
  if TFormWebBrowser(wbList[PageIndex]).TimerWebAutoRefresh = nil then
  TFormWebBrowser(wbList[PageIndex]).TimerWebAutoRefreshCreate;
  I := TFormWebBrowser(wbList[PageIndex]).TimerWebAutoRefresh.Interval;
  if I <= 0 then
  Str := InputBox('页面自动刷新 提示：','请输入定时器的刷新工作频率,如果是1秒请输入1000:','')
  else
  Str := InputBox('页面自动刷新 提示：','请输入定时器的刷新工作频率,如果是1秒请输入1000,目前的值为:' + IntToStr(I) + '.如果想停止定时刷新请输入0后确定!','');
  if (Trim(Str) = '') then exit;
  if (Trim(Str) = '0')then
  begin
    TFormWebBrowser(wbList[PageIndex]).TimerWebAutoRefresh.Enabled := false;
    TFormWebBrowser(wbList[PageIndex]).TimerWebAutoRefresh.Interval := 0;
    FormPublic.NWebAutoRefresh.Checked := false;
    exit;
  end;
  I := StrToInt(Str);
  TFormWebBrowser(wbList[PageIndex]).TimerWebAutoRefresh.Interval := I;
  TFormWebBrowser(wbList[PageIndex]).TimerWebAutoRefresh.Enabled := true;
  FormPublic.NWebAutoRefresh.Checked := true;
  ///xxx
except end;
end;

procedure TFormMain.ToolButtonMusicPlayClick(Sender: TObject);
begin
try
  PanelMusicPlay.Parent := PanelLeft;
  PanelMusicPlay.Visible := true;
  PanelFavorit.Visible := false;
  ListBoxTV.Hide;
  ListBoxMusicList.Show;
  SBOpenMusicFile.Show;
  SBOpenDir.Show;
  WritePrivateProfileString('RunData','SideAt','2',PChar(MyDir+ConfigFile));
except end;
end;

procedure TFormMain.ToolButtonFavClick(Sender: TObject);
begin
try
  PanelMusicPlay.Visible := false;
  PanelFavorit.Visible := true;
  WritePrivateProfileString('RunData','SideAt','1',PChar(MyDir+ConfigFile));
except end;
end;

procedure TFormMain.SBOpenMusicFileClick(Sender: TObject);
var
  FileName:string;
begin
try
  if not Opendialog2.Execute then exit;
  FileName:=Opendialog2.FileName;
  if Pos('http://',FileName) = 0 then
  if not FileExists(FileName) then exit;
  FormMain.ListBoxMusicList.Items.Add(FileName);
  FormMain.ListBoxMusicList.ItemIndex:=FormMain.ListBoxMusicList.Count-1;
  case MusicPlayType of
  0: wmp.Url :=  FormMain.ListBoxMusicList.Items.Strings[FormMain.ListBoxMusicList.ItemIndex];
  1: PlayMusic(FileName);
  end;
  //LoadList(ExtractFilePath(FileName));
  FormMain.NSaveList.OnClick(Sender);
except end;
end;

procedure TFormMain.SBOpenDirClick(Sender: TObject);
begin
try
  FormMain.NOpenDirectory.OnClick(Sender);
except end;
end;

procedure TFormMain.TBOpenUrlClick(Sender: TObject);
//var
  //str: String;
  //P: TPoint;
begin
try
  {
  //SBOpenMusicFile.OnClick(Sender);
  str:=InputBox('提示：','请输入歌曲或视频的URL地址:','http://');
  if (Trim(str)='') or (LowerCase(str) = 'http://') then exit;
  if (Pos(UpperCase('http://'),UpperCase(str)) = 0) and (Pos(UpperCase('mms:'),UpperCase(str)) = 0) then exit;
  TimerPlayer.Enabled := false;
  wmp.Url := str;
  TimerPlayer.Interval := 5000;
  TimerPlayer.Enabled := true;
  }
  //GetCursorPos(P);
  //LPM.Popup(P.X,P.Y);
  SBOpenMusicFile.Hide;
  SBOpenDir.Hide;
  ListBoxMusicList.Hide;
  ListBoxTV.Show;
  //ListBoxTV2.Show;
  NTVListRefresh.OnClick(Sender);
except end;
end;

procedure TFormMain.TimerPlayerTimer(Sender: TObject);
var
  NextOk: Boolean;
begin
try
  //exit;
  if OnlyPlayOne then
  begin
    TimerPlayer.Enabled := false;
    exit;
  end;
  NextOk := false;
  //if FormWmp.Visible then exit;
  case MusicPlayType of
  0:
  begin
    if (wmp.playState = 1) or (wmp.playState = 2) then exit;
    if TimerPlayer.Interval = 5000 then TimerPlayer.Interval := 1000;
    if wmp.Controls.currentPosition + 3 >= wmp.currentMedia.duration then NextOk := true;
  end;
  1:
  begin
  if MediaPlayer.Mode <> mpPlaying then exit;
  FormMain.TrackBar2.Position:=FormMain.MediaPlayer.Position;
  FormMain.TrackBar2.Position:=FormMain.MediaPlayer.Position;
  if FormMain.TrackBar2.Max-FormMain.TrackBar2.Position<=10 then NextOk := true;
  end;
  end;
  
  if NextOK then
  begin
    {
    if ListBoxMusicList.ItemIndex>=0 then
    if ListBoxMusicList.Items.Strings[ListBoxMusicList.ItemIndex]<>FileName then
    begin
      PlayMusic('');
      ListBoxMusicList.Selected[ListBoxMusicList.ItemIndex];
      exit;
    end;
    }
    {
    if FormMain.RBRandomPlay.Checked then SetForm.PlayRandom
    else if FormMain.RBOneLoopPlay.Checked then SetForm.PlayMusic('')
    else
    begin
      if FileName=FormMain.ListBoxMusicList.Items.Strings[FormMain.ListBoxMusicList.ItemIndex] then
        SetForm.PlayDown
      else
        SetForm.PlayMusic('');
    end;
    }
    case MusicPlayOrder of
    1:
    begin                
      if ListBoxMusicList.ItemIndex>=0 then
      if ListBoxMusicList.Items.Strings[ListBoxMusicList.ItemIndex]<>FileName then
      begin
        PlayMusic('');
        ListBoxMusicList.Selected[ListBoxMusicList.ItemIndex];
        exit;
      end
      else
      PlayDown;
    end;
    2:PlayRandom;
    3:PlayMusic('');
    end;
  end;
except
  PlayError;
end;
end;

procedure TFormMain.NOpenMusicFileClick(Sender: TObject);
begin
try
  SBOpenMusicFile.OnClick(Sender);
except end;
end;

procedure TFormMain.NOpenDirectoryClick(Sender: TObject);
begin
try
  //GetPathForm.Show;
  GetPathForm:=TGetPathForm.Create(Self);
  GetPathForm.Caption:='请选择歌曲的目录:';
  GetPathForm.ShowModal;
except end;
end;

procedure TFormMain.NLoadListClick(Sender: TObject);
begin
try
  if not SetForm.OpenDialogList.Execute then exit;
  if not FileExists(SetForm.OpenDialogList.FileName) then exit;
  FormMain.ListBoxMusicList.Items.LoadFromFile(SetForm.OpenDialogList.FileName);
except end;
end;

procedure TFormMain.NSaveListClick(Sender: TObject);
begin
try            
  FormMain.ListBoxMusicList.Items.SaveToFile(MyDir + MusicListFile);
except end;
end;

procedure TFormMain.NListSaveAsClick(Sender: TObject);
var
  str:string;
begin
try
  if not SetForm.SaveDialog.Execute then exit;
  //if LowerCase(ExtractFileExt(SaveDialog.FileName))<>'.lst' then
  SetForm.SaveDialog.FileName:=ChangeFileExt(SetForm.SaveDialog.FileName,'.lst');
  str:=SetForm.SaveDialog.FileName;
  FormMain.ListBoxMusicList.Items.SaveToFile(str);
except end;
end;

procedure TFormMain.MenuItem5Click(Sender: TObject);
var
  i:integer;
begin
try
  //ListBoxMusicList.Items.Delete(ListBoxMusicList.ItemIndex);
  if FormMain.ListBoxMusicList.SelCount<=0 then exit;
  for i:=1 to FormMain.ListBoxMusicList.SelCount do
  begin
    //if ListBoxMusicList.Items[ListBoxMusicList.ItemIndex]<>''then
    FormMain.ListBoxMusicList.Items.Delete(FormMain.ListBoxMusicList.ItemIndex);
  end;
  NSaveList.OnClick(Sender);
except end;
end;

procedure TFormMain.MenuItem6Click(Sender: TObject);
begin
try
  FormMain.ListBoxMusicList.Items.Clear;
  DeleteFile(ExtractFilePath(Paramstr(0))+MusicListFile);
  NSaveList.OnClick(Sender);
except end;
end;

procedure TFormMain.ListBoxMusicListDblClick(Sender: TObject);
begin
try
  if FormMain.ListBoxMusicList.Count<=0 then
  begin
    //if SideStatShape then SBSideStatShape.Click;
    SBOpenMusicFile.OnClick(Sender);
    exit;
  end;
  if ListBoxMusicList.ItemIndex<0 then ListBoxMusicList.ItemIndex:=0;
  if MusicPlayType = 0 then
  begin
    FileName:=ListBoxMusicList.Items.Strings[ListBoxMusicList.itemIndex];
    if TimerPlayer.Enabled then TimerPlayer.Enabled := false;
    wmp.Url := FileName;
    TimerPlayer.Interval := 5000;
    TimerPlayer.Enabled := true;
  end
  else
  PlayMusic(ListBoxMusicList.Items.Strings[ListBoxMusicList.itemIndex]);
except end;
end;

procedure TFormMain.ActionNAddNewBlankExecute(Sender: TObject);
begin
try
  FormPublic.NAddNewBlank.OnClick(Sender);
except end;;
end;

procedure TFormMain.ActionNAddNewHomePageExecute(Sender: TObject);
begin
try
  FormMain.TBGoHome.Click;
except end;
end;

procedure TFormMain.ActionNCopyCurrentPageExecute(Sender: TObject);
begin
try
  FormPublic.NCopyCurrentPage.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionNSaveAsExecute(Sender: TObject);
begin
try
  FormPublic.NSaveAs.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionNPrintExecute(Sender: TObject);
begin
try
  FormPublic.NPrint.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionNCloseCurrentExecute(Sender: TObject);
begin
try
  //NoSaveNewly := true;
  FormPublic.NCloseCurrent.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionNAllCloseExecute(Sender: TObject);
begin
try
  FormPublic.NAllClose.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionNExitExecute(Sender: TObject);
begin
try
  FormPublic.NExit.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionNSelectAllExecute(Sender: TObject);
begin
try
  FormPublic.NSelectAll.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionNFindExecute(Sender: TObject);
begin
try
  FormPublic.NFind.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionNAddressSetFocusExecute(Sender: TObject);
begin
try
  //FormPublic.NAddressSetFocus.OnClick(Sender);
  FormPublic.AddressSetFocus;
except end;
end;

procedure TFormMain.ActionNRefreshExecute(Sender: TObject);
begin
try
  FormPublic.NRefresh.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionNStopExecute(Sender: TObject);
begin
try
  FormPublic.NStop.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionNAllRefreshExecute(Sender: TObject);
begin
try
  FormPublic.NAllRefresh.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionNPreviousPageExecute(Sender: TObject);
begin
try
  FormPublic.NPreviousPage.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionNNextPageExecute(Sender: TObject);
begin
try
  FormPublic.NNextPage.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionNAddFavoriteExecute(Sender: TObject);
begin
try
  FormPublic.NAddFavorite.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionNWeatherExecute(Sender: TObject);
begin
try
  FormPublic.NWeather.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionOpenNewlyOneExecute(Sender: TObject);
begin
try
  FormPublic.NOpenNewlyOne.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionDocmentSetFocusExecute(Sender: TObject);
begin
try
  FormPublic.NDocmentSetFocus.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionCleanCurrentAdExecute(Sender: TObject);
begin
try
  FormPublic.NCleanCurrentAd.OnClick(Sender);
  {
  try
  CurrentIndex:=TOPMainForm.PageControl.ActivePageIndex;
  if CurrentIndex>0 then
  ClearAd2(TFrameWebBrowser(TOPMainForm.FFrameList.Items[CurrentIndex]).WebBrowser)
  else
  ClearAd2(TOPMainForm.FrameWebBrowserDefault.WebBrowser);
  except end;
  }
except end;
end;

procedure TFormMain.ActionF1Execute(Sender: TObject);
begin
try
  MoreUrlOpen := false;
  FormMain.CBURL.Text:=QuickLiniStr[0];
  FormMain.BBGO.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionF2Execute(Sender: TObject);
begin
try
  MoreUrlOpen := false;
  FormMain.CBURL.Text:=QuickLiniStr[1];
  FormMain.BBGO.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionF3Execute(Sender: TObject);
begin
try
  MoreUrlOpen := false;
  FormMain.CBURL.Text:=QuickLiniStr[2];
  FormMain.BBGO.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionF4Execute(Sender: TObject);
begin
try
  if Trim(QuickLiniStr[3]) <> '' then
  begin
  MoreUrlOpen := false;
  FormMain.CBURL.Text:=QuickLiniStr[3];
  FormMain.BBGO.OnClick(Sender);
  end
  else
  begin     
    FormPublic.NCloseCurrent.OnClick(Sender);
  end;
except end;
end;

procedure TFormMain.ActionQuickClearMemoryExecute(Sender: TObject);
begin
try
  FormPublic.NQuickClearMemory.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionInputTableExecute(Sender: TObject);
begin
try
  FormPublic.NInputTable.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionSetTabWidthExecute(Sender: TObject);
var
  Str: String;
begin
try
  Str := InputBox('标签宽度值 提示：','请输入标签的宽度值,目前的值为:' + IntToStr(TabWidth) + '.','');
  if (Trim(Str) = '') then exit;
  TabWidth := StrToInt(Str);
  ToolBarTabParent.ButtonWidth := TabWidth;
except end;
end;

procedure TFormMain.ActionUnLockExecute(Sender: TObject);
begin
try
  FormPublic.NUnLockWebPage.Click;
except end;
end;

procedure TFormMain.SBSideStatShapeClick(Sender: TObject);
begin
try
  try
  SideStatShape:=not SideStatShape;
  if SideStatShape then
  begin   Splitter1.Hide;
    //SBSideStatShape.Glyph:=SBSideStatShape1.Glyph;
    FormMain.ToolBarLeftTopControl.Images := FormMain.ImageList31;
    SBSideStatShape.Hint:='锁定';
    PanelLeft.Align:=alNone;
    TimerSide.Enabled:=true;
    WritePrivateProfileString('RunData','SideStatShape','1',PChar(MyDir+ConfigFile));
  end        
  else                          
  begin  Splitter1.Show;
    //SBSideStatShape.Glyph:=SBSideStatShape0.Glyph;
    FormMain.ToolBarLeftTopControl.Images := FormMain.ImageList32;
    SBSideStatShape.Hint:='自动隐藏';
    PanelLeft.Align:=alLeft;
    TimerSide.Enabled:=false;          
    Splitter1.Width := 1;
    WritePrivateProfileString('RunData','SideStatShape','0',PChar(MyDir+ConfigFile));
  end;
  finally
  FormPublic.TabAutoWidthControl;
  ShowCloseOK := false;
  ToolBarTabParent.Repaint;
  {
  if ShowCloseHint then
  if (PanelLeft.Visible) and (wbList.Count = 1) then
  else FormMain.ToolBarTabClose.Visible := false;
  }
  //TreeView1.Parent.SetFocus;
  //TreeView1.SetFocus;
  end;
except end;
end;

procedure TFormMain.TimerSideTimer(Sender: TObject);
var
  P:TPoint;
begin
try
  {
  if not FormPublic.NSideCote.Checked then
  begin
    TimerSide.Enabled:=false;
    exit;
  end;   fdf
  }
  if not SideStatShape then
  begin
    TimerSide.Enabled:=false;
    exit;
  end;
  if (not FormMain.Visible) or (WindowStateI = 2) then
  begin
    TimerSide.Enabled:=false;
    exit;
  end;
  GetCursorPos(P);
  //Application.Title := IntToStr(RanDom(999999999));
  //LockWindowUpdate(FormMain.PanelWBMain.Handle);
  try
  if (P.X<(PanelLeft.Left+PanelLeft.Width+2)) and (P.Y>PanelLeft.Top) and (P.Y<(PanelLeft.Top+PanelLeft.Height+28)) then
  begin
    //if {(SideCoteAllHide)} //and (FormPublic.NSideCote.Checked)// {and} (not PanelLeft.Visible) then
    //if ((FormMain.WindowState = wsMaximized) and (P.X <= 2)) or ((FormMain.WindowState = wsNormal) and ((P.X - FormMain.Left >= 0) and (P.X - FormMain.Left <= 5))) then
    //if (((FormMain.WindowState = wsMaximized) and (P.X <= 2)) or ((FormMain.WindowState = wsNormal) and ((P.X - FormMain.Left >= 0) and (P.X - FormMain.Left <= 5)))) then
    if ((P.X - FormMain.Left >= 0) and (P.X - FormMain.Left <= 5)) then
    begin     {WindowStateII = 2}    {WindowStateII = 1}        //ppppppppppppppp
      PanelLeft.Align:=alNone;
      PanelLeft.Height:=PanelWBMain.Height - 2;
      PanelLeft.Top:=PanelWBMain.Top + 1;
      Splitter1.Width := 1;
      if wbList.Count = 1 then ToolBarTabClose.Hide;
      PanelLeft.Visible:=true;
    end;
  end
  else
  begin
    //if not FormPublic.NSideCote.Checked then exit;
    //LockWindowUpdate(Handle);
    //try
    if not SideStatShape then
    begin  
      PanelLeft.Height:=PanelWBMain.Height-2;
      PanelLeft.Top:=PanelWBMain.Top + 1;
      Splitter1.Width := 1;
      PanelLeft.Visible:=true;
    end
    else
    begin
      PanelLeft.Visible:=false;
      //if ShowCloseHint then ToolBarTabClose.Show;
      Splitter1.Width := 0;
    end;
  end;       
  finally
    //LockWindowUpdate(0);
  end;
except end;
end;

procedure TFormMain.ActionAddFirstTabExecute(Sender: TObject);
begin
try
  CBUrl.Text := 'about:blank';
  FormMain.Panel_StatusBar1.Caption := '';
  FormPublic.NewPage(0, 'about:blank', True);
  FormPublic.AddressSetFocus;
except end;
end;

procedure TFormMain.ToolBarMusicPlayOpenCustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  SrcR, DestR: TRect;
  Bitmap: TBitmap;
  R: TRect;
  L: Integer;
  Flags: Longint;
begin
try   //exit;
  //{
  //if (not PaintPanelFavorite.Visible) {and ((Sender as TToolBar) <> ToolBarFavorite)} then exit;
  if not PanelLeft.Visible then exit;
  DefaultDraw := False;
  if Button.Down then Bitmap := ImageMenuMouseDown.Picture.Bitmap else
    if cdsHot in State then Bitmap := {ImageTitleMenuMouseMove}ImageMenuMouseDown.Picture.Bitmap else Bitmap := nil;
      //if cdsSelected in State then Bitmap := {ImageTitleMenuMouseMove}ImageButtonHot.Picture.Bitmap else Bitmap := nil;
    //}

  //{
  if Assigned(Bitmap) then
  begin
    SrcR := Rect(0, 0, 5, ImageMenuMouseDown.Height);
    DestR := SrcR;
    Inc(DestR.Bottom, 2);
    OffsetRect(DestR, Button.Left, 2);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
    OffsetRect(SrcR, ImageMenuMouseDown.Width - 5, 0);
    OffsetRect(DestR, Button.Width - 5, 0);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
    OffsetRect(SrcR, -3, 0);
    DestR.Left := Button.Left + 5;
    Dec(DestR.Right, 5);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
  end;
  //}

  {
  if Button.ImageIndex >= 0 then
  begin
    L := Button.Left + 3;
    if Button.Caption = '' then Inc(L, 2);
    if (TFormWebBrowser(wbList[PageIndex]).NoCleanFlash) then
    ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex)
    else if Button = ToolButtonFlash then
    ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex + 1)
    else ImageList3.Draw(Sender.Canvas, L, Button.Top + 5, Button.ImageIndex);
  end;
  }

  if Button.Caption <> '' then
  begin
    R := Button.BoundsRect;
    Inc(R.Top, 2);
    Flags := DT_VCENTER or DT_SINGLELINE;
    if Button.ImageIndex >= 0 then
    begin
      Inc(R.Left, 20);
      Flags := Flags or DT_LEFT;
    end else
      Flags := Flags or DT_CENTER;
    SetBkMode(Sender.Canvas.Handle, TRANSPARENT);
    DrawText(Sender.Canvas.Handle, PChar(Button.Caption), -1, R, Flags);
  end;
except end;
end;

procedure TFormMain.ImageStopClick(Sender: TObject);
begin
try
  //FormMain.Image1.parent := FormMain.ToolBarTabParent; exit;
  //ShowMessage(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl); exit;
  //FormPublic.NStop.OnClick(Sender);
  //FormPublic.TabAutoWidthControl; exit;
  if wbList.Count <= 0 then exit;   //ShowMessage(IntToStr(TabWidth)); exit;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.Stop;
except end;
end;    

procedure TFormMain.ToolBarTabCloseCustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  Index: Integer;
begin   //ImageListCloseImg   ImageListTabClose
try
  if not CloseUpdate then exit;
  //CloseUpdate := false;
  //if not ShowCloseHint then exit;
  //if not CloseHintUpdate then exit;
  //CloseHintUpdate := false;
  if CloseApp then exit;
  if not ShowCloseHint then
  begin
    //ToolBarTabClose.Visible := false;
    exit;
  end;
  //if not ToolBarTabClose.Visible then exit;
  DefaultDraw := False;
  Index := Button.Index;  //PageIndex; //Button.Index;
  //if Index <> PageIndex then exit;
  //DefaultDraw := False;
  if cdsHot in State then Inc(Index, 1);
  if cdsSelected in State then Inc(Index, 1);
  ImageListCloseImg2.Draw(Sender.Canvas, ToolButtonTabClose2.BoundsRect.Top - 1, ToolButtonTabClose2.BoundsRect.Right - ToolButtonTabClose2.Width - 1 , Index);
  exit;
  case TabStyle of
    1: ImageListCloseImg2.Draw(Sender.Canvas, ToolButtonTabClose2.BoundsRect.Top - 1, ToolButtonTabClose2.BoundsRect.Right - ToolButtonTabClose2.Width - 1 , Index);
    0: ImageListCloseImg.Draw(Sender.Canvas, ToolButtonTabClose2.BoundsRect.Top - 1, ToolButtonTabClose2.BoundsRect.Right - ToolButtonTabClose2.Width - 1 , Index);
  end;
except end;
end;

procedure TFormMain.ToolButtonTabClose2Click(Sender: TObject);
begin
try
  CallBackMemory := true;
  FormPublic.ClosePage(PageIndex);
except end;
end;

procedure TFormMain.ToolButtonTabClose2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
try
  if (Button=mbRight) then
  begin
    CallBackMemory := true;
    FormPublic.ClosePage(PageIndex);
  end;
except end;
end;

procedure TFormMain.ActionTVExecute(Sender: TObject);
begin
try
  FormMain.TBOpenUrl.Click;
except end;
end;

procedure TFormMain.NRBClosePageClick(Sender: TObject);
begin
try
  FormPublic.TabClick2({PageIndex}N_BR_Flag.Tag);
  FormPublic.ClosePage({PageIndex}N_BR_Flag.Tag);
except end;
end;

procedure TFormMain.NRBRefrshClick(Sender: TObject);
begin
try
  TFormWebBrowser(wbList[{PageIndex}N_BR_Flag.Tag]).DownIcon := false;
  TFormWebBrowser(wbList[{PageIndex}N_BR_Flag.Tag]).WebBrowser.Refresh;
except end;
end;

procedure TFormMain.NRBCloseClick(Sender: TObject);
var
  P: TPoint;
begin
try
  //PopupMenuNewly.Parent := NRBClose;
  GetCursorPos(P);
  PopupMenuNewly.Popup(P.X,P.Y);
except end;
end;

procedure TFormMain.ActionOpenNewlyExecute(Sender: TObject);
var
  P: TPoint;
begin
try
  GetCursorPos(P);
  PopupMenuNewly.Popup(P.X,P.Y);
except end;
end;

procedure TFormMain.NSearch1Click(Sender: TObject);
begin
try
  try
  SearchOn := 1;
  //LabelSearchName.Caption := SearchID1Name;
  if ComboBoxSearch.Font.Color = clGray then
  begin
    ComboBoxSearch.Text:= SearchID1NameShow;
    ComboBoxSearch.Font.Color := clGray;
  end;
  //ImageSearch.Refresh;
  {
  if (Trim(EditSearch.Text) = '') or (EditSearch.Font.Color=clGray) then
  begin
    if LANGUAGE <= 1 then
    EditSearch.Text := SearchID1Name
    else
    EditSearch.Text := SearchID1NameE;
    EditSearch.Font.Color := clGray;
  end;
  }
  finally
    //FormMain.PaintPanelAS.Repaint;
    ToolBarSearchEdit.Repaint;
    WritePrivateProfileString('RunData','SearchOn','1',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormMain.NSearch2Click(Sender: TObject);
begin
try
  try
  SearchOn := 2;
  //LabelSearchName.Caption := SearchID2Name;
  if ComboBoxSearch.Font.Color = clGray then
  begin
    ComboBoxSearch.Text:= SearchID2NameShow;
    ComboBoxSearch.Font.Color := clGray;
  end;
  //ImageSearch.Refresh;
  finally
    ToolBarSearchEdit.Repaint;
    WritePrivateProfileString('RunData','SearchOn','2',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormMain.NSearch3Click(Sender: TObject);
begin
try
  try
  SearchOn := 3;
  //LabelSearchName.Caption := SearchID3Name;
  if ComboBoxSearch.Font.Color = clGray then
  begin
    ComboBoxSearch.Text:= SearchID3NameShow;
    ComboBoxSearch.Font.Color := clGray;
  end;
  //ImageSearch.Refresh;
  finally
    ToolBarSearchEdit.Repaint;
    WritePrivateProfileString('RunData','SearchOn','3',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormMain.NSearch4Click(Sender: TObject);
begin
try
  try
  SearchOn := 4;
  //LabelSearchName.Caption := SearchID7Name;
  if ComboBoxSearch.Font.Color = clGray then
  begin
    ComboBoxSearch.Text:= SearchID4NameShow;
    ComboBoxSearch.Font.Color := clGray;
  end;
  //ImageSearch.Refresh;
  finally
    ToolBarSearchEdit.Repaint;
    WritePrivateProfileString('RunData','SearchOn','4',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormMain.NSearch5Click(Sender: TObject);
var
  Url: String;
begin
try
  {//
  if ComboBoxSearch.Font.Color <> clGray then
  begin
    Url := Trim(ComboBoxSearch.Text);
    if Url = '' then
    begin
      ComboBoxSearch.Text := '请输入关键词';
      ComboBoxSearch.Font.Color :=clGray;
      exit;
    end;
    Url := StringReplace(SearchID5Url, 'KEYWORD_', Url, [rfReplaceAll,rfIgnoreCase]);
    CBURL.Text := Url;
    BBGO.OnClick(Sender);
  end
  else
  begin
    ComboBoxSearch.Text := '请输入关键词';
    ComboBoxSearch.Font.Color :=clGray;
  end;
  exit;
  }
  
  try
  SearchOn := 5;
  //LabelSearchName.Caption := SearchID7Name;
  if ComboBoxSearch.Font.Color = clGray then
  begin
    ComboBoxSearch.Text:= SearchID5NameShow;
    ComboBoxSearch.Font.Color := clGray;
  end;
  //ImageSearch.Refresh;
  //ToolButtonSearch.OnClick(Sender);
  finally
    ToolBarSearchEdit.Repaint;
    WritePrivateProfileString('RunData','SearchOn','5',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormMain.NSearch6Click(Sender: TObject);
var
  Url: String;
begin
try
  {//
  if ComboBoxSearch.Font.Color <> clGray then
  begin
    Url := Trim(ComboBoxSearch.Text);
    if Url = '' then
    begin
      ComboBoxSearch.Text := '请输入关键词';
      ComboBoxSearch.Font.Color :=clGray;
      exit;
    end;
    Url := StringReplace(SearchID6Url, 'KEYWORD_', Url, [rfReplaceAll,rfIgnoreCase]);
    CBURL.Text := Url;
    BBGO.OnClick(Sender);
  end
  else
  begin
    ComboBoxSearch.Text := '请输入关键词';
    ComboBoxSearch.Font.Color :=clGray;
  end;
  exit;
  }
  try
  SearchOn := 6;
  //LabelSearchName.Caption := SearchID7Name;
  if ComboBoxSearch.Font.Color = clGray then
  begin
    ComboBoxSearch.Text:= SearchID6NameShow;
    ComboBoxSearch.Font.Color := clGray;
  end;
  //ImageSearch.Refresh;
  finally
    ToolBarSearchEdit.Repaint;
    WritePrivateProfileString('RunData','SearchOn','6',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormMain.NSearch7Click(Sender: TObject);
var
  Url: String;
begin
try
  {//
  if ComboBoxSearch.Font.Color <> clGray then
  begin
    Url := Trim(ComboBoxSearch.Text);
    if Url = '' then
    begin
      ComboBoxSearch.Text := '请输入关键词';
      ComboBoxSearch.Font.Color :=clGray;
      exit;
    end;
    Url := StringReplace(SearchID7Url, 'KEYWORD_', Url, [rfReplaceAll,rfIgnoreCase]);
    CBURL.Text := Url;
    BBGO.OnClick(Sender);
  end
  else
  begin
    ComboBoxSearch.Text := '请输入关键词';
    ComboBoxSearch.Font.Color :=clGray;
  end;
  exit;
  }
  try
  SearchOn := 7;
  //LabelSearchName.Caption := SearchID7Name;
  if ComboBoxSearch.Font.Color = clGray then
  begin
    ComboBoxSearch.Text:= SearchID7NameShow;
    ComboBoxSearch.Font.Color := clGray;
  end;
  //ImageSearch.Refresh;
  finally
    ToolBarSearchEdit.Repaint;
    WritePrivateProfileString('RunData','SearchOn','7',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormMain.PaintPanelMusicPlayTopPaint(Sender: TObject);
begin
try
  case ButtonStyle of
  0: PaintPanelMusicPlayTop.Canvas.CopyRect(PaintPanelMusicPlayTop.ClientRect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
  1: PaintPanelMusicPlayTop.Canvas.CopyRect(PaintPanelMusicPlayTop.ClientRect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
  end;
except end;
end;

procedure TFormMain.ToolBarMusicPlayOpenCustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
try    //exit;
  //if not PaintPanelFavorite.Visible then exit;
  if not PanelLeft.Visible then exit;
  with Sender.Canvas do
  begin
    CopyRect(ARect, {ImageButton}Imagebg.Picture.Bitmap.Canvas, {ImageButton}Imagebg.ClientRect);
    Pen.Color := TColor($808080);
    MoveTo(0, Sender.Height -1);
    //LineTo(Sender.Width, Sender.Height -1);
  end;
except end;
end;

procedure TFormMain.PaintPanelFavLeftControlPaint(Sender: TObject);
begin
try
  case ButtonStyle of
  0: PaintPanelFavLeftControl.Canvas.CopyRect(PaintPanelFavLeftControl.ClientRect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
  1: PaintPanelFavLeftControl.Canvas.CopyRect(PaintPanelFavLeftControl.ClientRect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
  end;
except end;
end;

procedure TFormMain.ToolBarMenuCustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
  var
  R: TRect;
begin
try
  Sender.Canvas.CopyRect(ARect, ImageMenuBase.Picture.Bitmap.Canvas, ImageMenuBase.ClientRect);
  //exit;
  //Sender.Canvas.CopyRect(Image1.ClientRect, Image1.Picture.Bitmap.Canvas, Image1.ClientRect);
  DrawIconEx(Sender.Canvas.Handle, 4, 3, Application.Icon.Handle, 16, 16, 0, 0, DI_NORMAL);
  SetBkMode(Sender.Canvas.Handle, TRANSPARENT);   
  R := Rect(22 + 4, 0, Sender.Indent, Sender.Height);
  DrawText(Sender.Canvas.Handle , PChar(FCaption), -1, R, DT_LEFT or DT_VCENTER or DT_SINGLELINE);
except end;
end;

procedure TFormMain.ToolBarButtonCustomDraw(Sender: TToolBar; const ARect: TRect;
  var DefaultDraw: Boolean);
begin
try
  case ButtonStyle of  //uuuuuuuuu
  0: Sender.Canvas.CopyRect(ARect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
  1: ;
  end;
except end;
end;

procedure TFormMain.TBGoHomeClick(Sender: TObject);
begin
try
  if wbList.Count = 0 then ToolButtonTabNew.Click;
  //{
  if wbList.Count >= 1 then
  begin
    if (TFormWebBrowser(wbList[PageIndex]).WebBrowser.Busy) or (LowerCase(Trim(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl))<>'about:blank') then
    ToolButtonTabNew.Click;
  end;

  if OpenToUrl <> '' then
  begin
    CBURL.Text := OpenToUrl;
    TFormWebBrowser(wbList[PageIndex]).WebURL := OpenToUrl;
    TFormWebBrowser(wbList[PageIndex]).WebBrowser.Navigate(OpenToUrl);
  end
  else
  begin
  TFormWebBrowser(wbList[PageIndex]).WebURL := ReadRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Internet Explorer\Main',0,'Start Page');
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.GoHome;
  end;
except end;
end;

procedure TFormMain.TBGoForwardClick(Sender: TObject);
begin
try
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.GoForward;
except end;
end;

procedure TFormMain.TBGoBackClick(Sender: TObject);
begin
try
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.GoBack;
except end;
end;

procedure TFormMain.TBRefreshClick(Sender: TObject);
{
var
  Range: IHTMLTxtRange;
  Doc: IHTMLDocument2;
}
begin
try
  {
  Doc := TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document as IHTMLDocument2;
  Range := (Doc.body as IHTMLBodyElement).createTextRange; 
  while Range.findText('浏览器', 1, 0) do
  begin
    Range.pasteHTML('<a href=http://www.uuiv.com>浏览器</a>');
    //Range.pasteHTML('<a href="#" onmouseover="alert(this.innerText); alert(this.href)">中国</a>');
    Range.collapse(False);
  end;
  exit;
  }
  {
  with TFormWebBrowser(wbList[PageIndex]).WebBrowser do
  begin
    if not NoImage then DownloadOptions := DownloadOptions + [DLCTL_DLIMAGES]
    else DownloadOptions := DownloadOptions - [DLCTL_DLIMAGES];

    if not NoVideo then DownloadOptions := DownloadOptions + [DLCTL_VIDEOS]
    else DownloadOptions := DownloadOptions - [DLCTL_VIDEOS];

    if not NoBgsound then DownloadOptions := DownloadOptions + [DLCTL_BGSOUNDS]
    else DownloadOptions := DownloadOptions - [DLCTL_DLIMAGES];

    if NoJava then DownloadOptions := DownloadOptions + [DLCTL_NO_JAVA]
    else DownloadOptions := DownloadOptions - [DLCTL_NO_JAVA];

    if NoScript then DownloadOptions := DownloadOptions + [DLCTL_NO_SCRIPTS]
    else DownloadOptions := DownloadOptions - [DLCTL_NO_SCRIPTS];

    if NoActivex then
    begin
      DownloadOptions := DownloadOptions + [DLCTL_NO_DLACTIVEXCTLS];
      DownloadOptions := DownloadOptions + [DLCTL_NO_RUNACTIVEXCTLS];
    end
    else
    begin
      DownloadOptions := DownloadOptions - [DLCTL_NO_DLACTIVEXCTLS];
      DownloadOptions := DownloadOptions + [DLCTL_NO_RUNACTIVEXCTLS];
    end;
    //Refresh; 
  end;
  }
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.Refresh;
except end;    
end;

procedure TFormMain.TBStopClick(Sender: TObject);
begin
try                 
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.Stop;
except end;
end;

procedure TFormMain.TBFavoriteClick(Sender: TObject);
begin
try
  //ToolButton13.Down:=true; //not ToolButton13.Down;
  FormPublic.NSideCote.OnClick(Sender);
except end;
end;

procedure TFormMain.TBNewlyClick(Sender: TObject);
begin
try
  {
  GetCursorPos(Pt);
  //Pt.x := ToolButtonTabList.Left + ToolButtonTabList.Width; // - PopupMenu1.Width;
  //Pt.y := ToolButtonTabList.Height;  //Pt := ToolButtonTabList.ClientToScreen(Pt);  //PopupMenu1.Popup(Pt.X, Pt.Y);
  PopupMenuNewly.Popup(Pt.X, Pt.Y);
  }
  FormPublic.NOpenNewlyOne.OnClick(Sender);
except end;
end;

procedure TFormMain.TBNewlyMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  P: tPoint;
begin
try
  //{
  if (Button = mbRight) then
  begin
    GetCursorPos(P);
    PopupMenuNewly.Popup(P.X,P.Y);
  end;
  //}
except end;
end;

procedure TFormMain.NCleanAllNewlyClick(Sender: TObject);
begin
try
  FormPublic.CleanNewly;
except end;
end;

procedure TFormMain.TBCloseClick(Sender: TObject);
begin
try     
  if wbList.Count <= 0 then exit;
  //FormPublic.ClosePage(PageIndex);
  FormMain.ToolButtonTabClose.OnClick(Sender);
except end;
end;

procedure TFormMain.TBOptionClick(Sender: TObject);
begin
try
  case TBOption.Tag of
  10:SetForm.Show;
  12:FormPublic.NCopy.OnClick(Sender);
  13:FormPublic.NSideCote.OnClick(Sender);
  14:FormPublic.NPrintView.OnClick(Sender);
  15:FormPublic.NPrint.OnClick(Sender);
  16:FormPublic.NSaveAs.OnClick(Sender);
  end;
except end;
end;                      

procedure TFormMain.TBToolsClick(Sender: TObject);
var
  P:TPoint;
begin
try
  case TBTools.Tag of
  11:
  begin
  //GetCursorPos(P);
  P.X:=TBTools.Left+10; //+TBTools.Width;
  P.Y:=TBTools.Top-TBTools.Height-10;
  PopupMenuTools.Popup(P.X,P.Y);
  end;
  12:FormPublic.NCopy.OnClick(Sender);
  13:FormPublic.NSideCote.OnClick(Sender);
  14:FormPublic.NPrintView.OnClick(Sender);
  15:FormPublic.NPrint.OnClick(Sender);
  16:FormPublic.NSaveAs.OnClick(Sender);
  end;
except end;
end;

procedure TFormMain.PaintPanelButtonAddressPaint(Sender: TObject);
begin
try
  case ButtonStyle of
  0: PaintPanelButtonAddress.Canvas.CopyRect(PaintPanelButtonAddress.ClientRect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
  1: PaintPanelButtonAddress.Canvas.CopyRect(PaintPanelButtonAddress.ClientRect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
  end;
  {
  PaintPanelButtonAddress.Canvas.Brush.Color := clWindow;
  PaintPanelButtonAddress.Canvas.Pen.Color := clBtnFace;  PaintPanelButtonAddress.Canvas.Rectangle(CBURL.Left - 27, CBURL.Top, CBURL.Left + CBURL.Width + 1, CBURL.Top + CBURL.Height + 1);
  //PaintPanelAS.Canvas.Rectangle(CBURL.Left - 27, CBURL.Top -1, CBURL.Left + , CBURL.Top + CBURL.Height + 1);
  //PaintPanelAS.Canvas.Rectangle(CBURL.Left - 23, CBURL.Top - 5, CBURL.Left + CBURL.Width + 10, CBURL.Top + CBURL.Height + 5);
  ImageList3.Draw(PaintPanelButtonAddress.Canvas, CBURL.Left - 20, CBURL.Top + 2, 3);
  exit;
  case SearchOn of
    0,1: ImageList3.Draw(PaintPanelButtonAddress.Canvas, CBURL.Left - 2, 9, 0);
    2: ImageList3.Draw(PaintPanelButtonAddress.Canvas, CBURL.Left - 2, 9, 1);
    3: ImageList3.Draw(PaintPanelButtonAddress.Canvas, CBURL.Left - 2, 9, 8);
    4: ImageList3.Draw(PaintPanelButtonAddress.Canvas, CBURL.Left - 23, 9, 8);
    5: ImageList3.Draw(PaintPanelButtonAddress.Canvas, CBURL.Left - 23, 9, 8);
    6: ImageList3.Draw(PaintPanelButtonAddress.Canvas, CBURL.Left - 23, 9, 8);
    7: ImageList3.Draw(PaintPanelButtonAddress.Canvas, CBURL.Left - 23, 9, 8);
  end;
  }
  //ImageGo.Repaint;
except end;
end;

procedure TFormMain.ToolBarAddressCustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
var
  SrcR, DestR: TRect;
  //Canvas: TCanvas;
begin
try
  Sender.Canvas.CopyRect(ARect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
  SrcR := Image8.ClientRect;
  SrcR.Right := 3;
  DestR := SrcR;
  Inc(DestR.Bottom, 0);          //2
  OffsetRect(DestR, 0, 7);   //5 //6
  Sender.Canvas.BrushCopy(Destr, Image8.Picture.Bitmap, SrcR, clFuchsia);
  OffsetRect(SrcR, Image8.Width - 3, 0);
  OffsetRect(DestR, Sender.Width - 3, 0);
  Sender.Canvas.BrushCopy(DestR, Image8.Picture.Bitmap, SrcR, clFuchsia);
  OffsetRect(SrcR, -3, 0);
  DestR.Left := 3;
  DestR.Right := Sender.Width - 3;
  Sender.Canvas.CopyRect(DestR, Image8.Picture.Bitmap.Canvas, SrcR);
  //ImageList3.Draw(Sender.Canvas, 5, 10, 3);  //exit;  lllkk
  if wbList.Count <= 0 then exit;
  ImageListWebIcon.Draw(Sender.Canvas, 5, 11, ToolBarTabParent.Buttons[PageIndex].ImageIndex);
  {
  exit;
  Sender.Canvas.Pen.Color := TColor($808080);
  Sender.Canvas.MoveTo(0, Sender.Height -1);
  Sender.Canvas.LineTo(Sender.Width, Sender.Height -1);
  }
except end;
end;
{
begin
try
  Sender.Canvas.CopyRect(ARect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
except end;
end;
}

procedure TFormMain.TBAddNewClick(Sender: TObject);
begin
try
  ToolButtonTabNew.Click;
except end;
end;

procedure TFormMain.NAddNewBlank2Click(Sender: TObject);
begin
try
  ToolButtonTabNew.OnClick(Sender);
except end;
end;

procedure TFormMain.NAddNewHomePage2Click(Sender: TObject);
begin
try
  TBGoHome.OnClick(Sender);
except end;
end;

procedure TFormMain.NCopyCurrentPageClick(Sender: TObject);
begin
try
  FormMain.BBGO.OnClick(Sender);
except end;
end;

procedure TFormMain.NPopupCloseAllClick(Sender: TObject);
begin
try
  AllClose(Sender);
except end;
end;

procedure TFormMain.NRefreshAllClick(Sender: TObject);
begin
try
  AllRefresh(Sender);
except end;
end;

procedure TFormMain.ImagenewClick(Sender: TObject);
begin
try
  ToolButtonTabNew.Click;
except end;
end;

procedure TFormMain.ImageRefreshClick(Sender: TObject);
begin
try
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.Refresh;
except end;
end;

procedure TFormMain.ImageHomeClick(Sender: TObject);
begin
{
try
  if wbList.Count >= 1 then
  begin
  //if (TFormWebBrowser(wbList[PageIndex]).WebBrowser.Busy) or (LowerCase(Trim(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl))<>'about:blank') then
  //ToolButtonTabNew.Click;
  end
  else ToolButtonTabNew.Click;
  if (InitForce) and (Trim(InitUrl) <> '') then
  begin
    MoreUrlOpen := false;
    CBURL.Text := InitUrl;
    BBGO.OnClick(Sender);
  end
  else
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.GoHome;
except end;
}
try
  if wbList.Count = 0 then ToolButtonTabNew.Click;
  //{
  if wbList.Count >= 1 then
  begin
    if (TFormWebBrowser(wbList[PageIndex]).WebBrowser.Busy) or (LowerCase(Trim(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl))<>'about:blank') then
    ToolButtonTabNew.Click;
  end;

  if OpenToUrl <> '' then
  begin
    CBURL.Text := OpenToUrl;
    TFormWebBrowser(wbList[PageIndex]).WebURL := OpenToUrl;
    TFormWebBrowser(wbList[PageIndex]).WebBrowser.Navigate(OpenToUrl);
  end
  else
  begin
  TFormWebBrowser(wbList[PageIndex]).WebURL := ReadRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Internet Explorer\Main',0,'Start Page');
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.GoHome;
  end;
except end;
end;

procedure TFormMain.ToolButtonAutoHintClick(Sender: TObject);
begin
try
  //FormAutoHint.Show;
  if FormAutoHintCreateOK then
  begin
    FormAutoHint.Show;
    AutoHintFile := MyDir + AutoHintDir + GetDateTime2(1) + GetDateTime2(2) + GetDateTime2(3) + '.txt';
    if not FileExists(AutoHintFile) then
    begin
      FormAutoHint.Timer1.Enabled := false;
      FormAutoHint.CBH1.Text := '';
      FormAutoHint.CBM1.Text := '';
      FormAutoHint.Memo1.Text := '';
      FormAutoHint.CBH2.Text := '';
      FormAutoHint.CBM2.Text := '';
      FormAutoHint.Memo2.Text := '';
      FormAutoHint.CBH3.Text := '';
      FormAutoHint.CBM3.Text := '';
      FormAutoHint.Memo3.Text := '';
      FormAutoHint.CBH4.Text := '';
      FormAutoHint.CBM4.Text := '';
      FormAutoHint.Memo4.Text := '';
      FormAutoHint.CBH5.Text := '';
      FormAutoHint.CBM5.Text := '';
      FormAutoHint.Memo5.Text := '';
      FormAutoHint.CBH6.Text := '';
      FormAutoHint.CBM6.Text := '';
      FormAutoHint.Memo6.Text := '';
      FormAutoHint.CBH7.Text := '';
      FormAutoHint.CBM7.Text := '';
      FormAutoHint.Memo7.Text := '';
      FormAutoHint.Label_1.Caption := '';
      FormAutoHint.Label_2.Caption := '';
      FormAutoHint.Label_3.Caption := '';
      FormAutoHint.Label_4.Caption := '';
      FormAutoHint.Label_5.Caption := '';
      FormAutoHint.Label_6.Caption := '';
      FormAutoHint.Label_7.Caption := '';
    end;
    if FileExists(HintStaticFile) then
    begin
      IniFile := TIniFile.Create(HintStaticFile);
      try
      if IniFile.ReadString('Data','Static6','0') = '1' then
      begin
        FormAutoHint.CBH6.Text := IniFile.ReadString('Data','CBH6','');
        FormAutoHint.CBM6.Text := IniFile.ReadString('Data','CBM6','');
        FormAutoHint.Memo6.Text := IniFile.ReadString('Data','Memo6','');
        FormAutoHint.CheckBox6.Checked := true;
      end;
      if IniFile.ReadString('Data','Static7','0') = '1' then
      begin
        FormAutoHint.CBH7.Text := IniFile.ReadString('Data','CBH7','');
        FormAutoHint.CBM7.Text := IniFile.ReadString('Data','CBM7','');
        FormAutoHint.Memo7.Text := IniFile.ReadString('Data','Memo7','');
        FormAutoHint.CheckBox7.Checked := true;
      end;
      finally
      IniFile.Free;
      end;
    end;
  end
  else
  begin
  FormAutoHint:=TFormAutoHint.Create(Self);
  //FormAutoHint.Caption:=TitleStr+' '+Version;
  FormAutoHint.ShowModal;
  FormAutoHintCreateOK := true;
  end;
  //xxx.
except end;
end;

procedure TFormMain.ActionTabLockExecute(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  FormPublic.NTabLock.Checked := true;
  TFormWebBrowser(wbList[PageIndex]).TabLock := true;
except end;
end;

procedure TFormMain.ActionTabUnLockExecute(Sender: TObject);
begin
try
  if wbList.Count <= 0 then exit;
  FormPublic.NTabLock.Checked := false;
  TFormWebBrowser(wbList[PageIndex]).TabLock := false;
except end;
end;

procedure TFormMain.ButtonSearchClick(Sender: TObject);
begin
try
  ToolButtonSearch.OnClick(Sender);
except end;
end;

procedure TFormMain.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
try
  {
  ReleaseCapture;
  SendMessage(Handle,WM_SYSCOMMAND,$f012,0);
  }
except end;
end;

procedure TFormMain.TBAllModeClick(Sender: TObject);
begin
try
  TFormWebBrowser(wbList[PageIndex]).AllMode := not TFormWebBrowser(wbList[PageIndex]).AllMode;
  if TFormWebBrowser(wbList[PageIndex]).AllMode then
  begin
    with TFormWebBrowser(wbList[PageIndex]).WebBrowser do
    begin
      DownloadOptions := DownloadOptions + [DLCTL_DLIMAGES];
      DownloadOptions := DownloadOptions + [DLCTL_VIDEOS];
      DownloadOptions := DownloadOptions + [DLCTL_BGSOUNDS];
      DownloadOptions := DownloadOptions - [DLCTL_NO_JAVA];
      DownloadOptions := DownloadOptions - [DLCTL_NO_SCRIPTS];
      DownloadOptions := DownloadOptions - [DLCTL_NO_DLACTIVEXCTLS];
      DownloadOptions := DownloadOptions - [DLCTL_NO_RUNACTIVEXCTLS];
      Refresh;
    end;
    TBAllMode.Hint := '目前状态:完整模式/F10';
  end
  else
  begin
    with TFormWebBrowser(wbList[PageIndex]).WebBrowser do
    begin
      DownloadOptions := DownloadOptions + [DLCTL_DLIMAGES];
      DownloadOptions := DownloadOptions - [DLCTL_VIDEOS];
      DownloadOptions := DownloadOptions - [DLCTL_BGSOUNDS];
      DownloadOptions := DownloadOptions + [DLCTL_NO_JAVA];
      DownloadOptions := DownloadOptions + [DLCTL_NO_SCRIPTS];
      DownloadOptions := DownloadOptions + [DLCTL_NO_DLACTIVEXCTLS];
      DownloadOptions := DownloadOptions + [DLCTL_NO_RUNACTIVEXCTLS];
      Refresh;
    end;
    TBAllMode.Hint := '目前状态:安全模式/F11';
  end;
  ToolBarStatusBar.Repaint;
except end;
end;

procedure TFormMain.ActionAllModeYExecute(Sender: TObject);
begin
try
  if not TFormWebBrowser(wbList[PageIndex]).AllMode then TBAllMode.OnClick(Sender);
  begin
    with TFormWebBrowser(wbList[PageIndex]).WebBrowser do
    begin
      DownloadOptions := DownloadOptions + [DLCTL_DLIMAGES];
      DownloadOptions := DownloadOptions + [DLCTL_VIDEOS];
      DownloadOptions := DownloadOptions + [DLCTL_BGSOUNDS];
      DownloadOptions := DownloadOptions - [DLCTL_NO_JAVA];
      DownloadOptions := DownloadOptions - [DLCTL_NO_SCRIPTS];
      DownloadOptions := DownloadOptions - [DLCTL_NO_DLACTIVEXCTLS];
      DownloadOptions := DownloadOptions - [DLCTL_NO_RUNACTIVEXCTLS];
      Refresh;
    end;
    TBAllMode.Hint := '目前状态:完整模式/F10';
  end
except end;
end;

procedure TFormMain.ActionAllModeNExecute(Sender: TObject);
begin
try
  if TFormWebBrowser(wbList[PageIndex]).AllMode then TBAllMode.OnClick(Sender);
except end;
end;

procedure TFormMain.NRandomPlayClick(Sender: TObject);
begin
try
  MusicPlayOrder := 2;
  WritePrivateProfileString('setting','MusicPlayOrder','2',PChar(MyDir+ConfigFile));
except end;
end;

procedure TFormMain.NOrderPlayClick(Sender: TObject);
begin
try
  MusicPlayOrder := 1;
  WritePrivateProfileString('setting','MusicPlayOrder','1',PChar(MyDir+ConfigFile));
except end;
end;

procedure TFormMain.NOnlyOneClick(Sender: TObject);
begin
try
  //NOnlyOne.Checked := not NOnlyOne.Checked;
  if NOnlyOne.Checked then
  begin
    OnlyPlayOne := true;
    WritePrivateProfileString('setting','OnlyPlayOne','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    OnlyPlayOne := false;
    //TimerPlayer.enabled := true;
    WritePrivateProfileString('setting','OnlyPlayOne','0',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormMain.ToolBarTabCloseCustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
try
  if not CloseUpdate then exit;
  //CloseUpdate := false;
  //if wbList.Count <= 0 then exit;
  if not ToolBarTabClose.Visible then exit;
  case TabStyle of
  //0: ;
  0,1,2: Sender.Canvas.CopyRect(ARect, ImageTabCloseBg.Picture.Bitmap.Canvas, ImageTabCloseBg.ClientRect);
  end;
except end;
end;

procedure TFormMain.ToolBarMenuClick(Sender: TObject);
begin
try
  SearchColor;
except end;
end;

procedure TFormMain.PaintPanelButtonAddressClick(Sender: TObject);
begin
try
  SearchColor;
except end;
end;

procedure TFormMain.ToolBarTabParentClick(Sender: TObject);
begin
try
  SearchColor;
except end;
end;

procedure TFormMain.ActionCutExecute(Sender: TObject);
begin
try
  FormPublic.NCut.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionCopyExecute(Sender: TObject);
begin
try
  FormPublic.NCopy.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionPasteExecute(Sender: TObject);
begin
try
  FormPublic.NPaste.OnClick(Sender);
except end;
end;

procedure TFormMain.PaintPanelFavoritePaint(Sender: TObject);
begin
try
  case ButtonStyle of
  0: PaintPanelFavorite.Canvas.CopyRect(PaintPanelFavorite.ClientRect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
  1: PaintPanelFavorite.Canvas.CopyRect(PaintPanelFavorite.ClientRect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
  //0: PaintPanelButtonAddress.Canvas.CopyRect(PaintPanelButtonAddress.ClientRect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
  //1: PaintPanelButtonAddress.Canvas.CopyRect(PaintPanelButtonAddress.ClientRect, Imagebg2.Picture.Bitmap.Canvas, Imagebg2.ClientRect);
  end;
except end;
end;

procedure TFormMain.ActionCdromOpenExecute(Sender: TObject);
begin
try
  OpenCDROM(1);
except end;
end;

procedure TFormMain.ActionCdromCloseExecute(Sender: TObject);
begin
try
  OpenCDROM(0);
except end;
end;

procedure TFormMain.WBInitPageNewWindow2(Sender: TObject;
  var ppDisp: IDispatch; var Cancel: WordBool);
begin
try
  Cancel := true;
except end;
end;

procedure TFormMain.WB1_2222ScriptError(Sender: TObject; ErrorLine,
  ErrorCharacter, ErrorCode, ErrorMessage, ErrorUrl: String;
  var ContinueScript, Showdialog: Boolean);
begin
try
  ContinueScript:=true;
  Showdialog:=false;
except end;
end;

procedure TFormMain.WBInitPageScriptError(Sender: TObject; ErrorLine,
  ErrorCharacter, ErrorCode, ErrorMessage, ErrorUrl: String;
  var ContinueScript, Showdialog: Boolean);
begin
try
  ContinueScript:=true;
  Showdialog:=false;
except end;
end;

procedure TFormMain.N1001Click(Sender: TObject);
begin
try
  ToolButton100.Hint := IntToStr((Sender as TMenuItem).Tag);
  ToolButton100.Caption := ToolButton100.Hint + '%';
  case StrToInt(ToolButton100.Hint) of
  50:
  begin
    FormPublic.N50.OnClick(Sender);
  end;
  75:
  begin
    FormPublic.N75.OnClick(Sender);
  end;
  100:
  begin
    FormPublic.N100.OnClick(Sender);
  end;
  110:
  begin
    FormPublic.N110.OnClick(Sender);
  end;
  120:
  begin
    FormPublic.N120.OnClick(Sender);
  end;
  125:
  begin
    FormPublic.N125.OnClick(Sender);
  end;
  130:
  begin
    FormPublic.N130.OnClick(Sender);
  end;
  150:
  begin
    FormPublic.N150.OnClick(Sender);
  end;
  200:
  begin
    FormPublic.N200.OnClick(Sender);
  end;
  end;
except end;
end;

procedure TFormMain.PaintPanelButtonAddressMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pt: TPoint;
begin
try
  if TabRClickNewPage then
  if (Button=mbRight) then
  begin
    GetCursorPos(Pt);
    FormPublic.PopupMenuShowCote.Popup(Pt.X, Pt.Y);
  end;
except end;
end;

procedure TFormMain.ToolButton100MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Pt: TPoint;
begin
try       
  if (Button=mbRight) then
  begin
    GetCursorPos(Pt);
    PopupMenudx.Popup(Pt.X, Pt.Y);
  end;
except end;
end;

procedure TFormMain.TBHistoryClick(Sender: TObject);
begin
try
  if (TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl <> 'about:blank') or (TFormWebBrowser(wbList[PageIndex]).WebBrowser.Busy) then ToolButtonTabNew.Click;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.NavigateFolder(CSIDL_HISTORY);
except end;
end;

procedure TFormMain.TBWebNavigationClick(Sender: TObject);
begin
try
  CBURL.Text := WebNavigationUrl;
  BBGO.Click;
except end;
end;

procedure TFormMain.MIComputerClick(Sender: TObject);
begin
try
  FormPublic.NMyComputer.Click;
except end;
end;

procedure TFormMain.MenuItem8Click(Sender: TObject);
begin
try
  FormPublic.NNotepad.Click;
except end;
end;

procedure TFormMain.MenuItem9Click(Sender: TObject);
begin
try
  FormPublic.NMspaint.Click;
except end;
end;

procedure TFormMain.MenuItem10Click(Sender: TObject);
begin
try
  FormPublic.NRunControl.Click;
except end;
end;

procedure TFormMain.MenuItem11Click(Sender: TObject);
begin
try
  FormPublic.NAddDeleteControl.Click;
except end;
end;

procedure TFormMain.PMCommandLineClick(Sender: TObject);
begin
try
  FormPublic.NCommandLine.Click;
except end;
end;

procedure TFormMain.MIRegeditClick(Sender: TObject);
begin
try
  FormPublic.NRegedit.Click;
except end;
end;

//MainMenu Start  //mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
{$IFDEF MenuSmall}
procedure TFormMain.NNewBlankPageClick(Sender: TObject);
begin
try
  FormPublic.NAddNewBlank.Click;
except end;
end;

procedure TFormMain.N54Click(Sender: TObject);
begin
try
  FormPublic.NAddNewHomePage.Click;
except end;
end;

procedure TFormMain.N55Click(Sender: TObject);
begin
try
  FormPublic.NCopyCurrentPage.Click;
except end;
end;

procedure TFormMain.N53Click(Sender: TObject);
begin
try
  FormPublic.NOpenFile.Click;
except end;
end;

procedure TFormMain.N21Click(Sender: TObject);
begin
try
  FormPublic.NSaveImgMode1.Click;
except end;
end;

procedure TFormMain.N44Click(Sender: TObject);
begin
try
  FormPublic.NSaveImgMode2.Click;
except end;
end;

procedure TFormMain.N58Click(Sender: TObject);
begin
try
  FormPublic.NSaveAs.Click;
except end;
end;
  
procedure TFormMain.N60Click(Sender: TObject);
begin
try
  FormPublic.NPageSetup.Click;
except end;
end;

procedure TFormMain.N61Click(Sender: TObject);
begin
try
  FormPublic.NPrintView.Click;
except end;
end;

procedure TFormMain.N64Click(Sender: TObject);
begin
try
  FormPublic.NPrint.Click;
except end;
end;

procedure TFormMain.ddd1Click(Sender: TObject);
begin
try
  FormPublic.NNewMail.Click;
except end;
end;

procedure TFormMain.ddd2Click(Sender: TObject);
begin
try
  FormPublic.NSendPage.Click;
except end;
end;

procedure TFormMain.ddd3Click(Sender: TObject);
begin
try
  FormPublic.NSendLink.Click;
except end;
end;

procedure TFormMain.N65Click(Sender: TObject);
begin
try
  FormPublic.NImport.Click;
except end;
end;

procedure TFormMain.N67Click(Sender: TObject);
begin
try
  FormPublic.NCloseCurrent.Click;
except end;
end;

procedure TFormMain.N68Click(Sender: TObject);
begin
try
  FormPublic.NAllClose.Click;
except end;
end;

procedure TFormMain.N70Click(Sender: TObject);
begin
try
  FormPublic.NAttribute.Click;
except end;
end;

procedure TFormMain.N71Click(Sender: TObject);
begin
try
  FormPublic.NOffline.Click;
except end;
end;

procedure TFormMain.N73Click(Sender: TObject);
begin
try
  FormPublic.NExit.Click;
except end;
end;

procedure TFormMain.N74Click(Sender: TObject);
begin
try
  FormPublic.NOpenNewlyOne.Click;
except end;
end;

procedure TFormMain.N75Click(Sender: TObject);
begin
try
  FormPublic.NNewlyCloseList.Click;
except end;
end;

procedure TFormMain.N77Click(Sender: TObject);
begin
try
  FormPublic.NCut.Click;
except end;
end;

procedure TFormMain.N78Click(Sender: TObject);
begin
try
  FormPublic.NCopy.Click;
except end;
end;

procedure TFormMain.N79Click(Sender: TObject);
begin
try
  FormPublic.NPaste.Click;
except end;
end;

procedure TFormMain.N81Click(Sender: TObject);
begin
try
  FormPublic.NSelectAll.Click;
except end;
end;

procedure TFormMain.N82Click(Sender: TObject);
begin
try
  FormPublic.NFind.Click;
except end;
end;

procedure TFormMain.N84Click(Sender: TObject);
begin
try
  FormPublic.NAddressSetFocus.Click;
except end;
end;

procedure TFormMain.N85Click(Sender: TObject);
begin
try
  FormPublic.NDocmentSetFocus.Click;
except end;
end;

procedure TFormMain.IE1Click(Sender: TObject);
begin
try
  FormPublic.NCleanCurrentAd.Click;
except end;
end;

procedure TFormMain.N87Click(Sender: TObject);
begin
try
  FormPublic.NEditSource.Click;
except end;
end;

procedure TFormMain.N106Click(Sender: TObject);
begin
try
  //FormPublic.NNShowMenu.Click;
  AutoMenuShow := false;
  FormPublic.NShowMenu.Checked := not FormPublic.NShowMenu.Checked;
  FormPublic.NNShowMenu.OnClick(Sender);
except end;
end;

procedure TFormMain.N56Click(Sender: TObject);
begin
try
  FormPublic.NShowButton.Click;
except end;
end;

procedure TFormMain.N109Click(Sender: TObject);
begin
try
  FormPublic.NShowSearch.Click;
except end;
end;

procedure TFormMain.N107Click(Sender: TObject);
begin
try
  FormPublic.NSideCote.Click;
except end;
end;

procedure TFormMain.N108Click(Sender: TObject);
begin
try
  FormPublic.NFavoritCote.Click;
except end;
end;

procedure TFormMain.N111Click(Sender: TObject);
begin
try
  FormPublic.NStatusBarV.Click;
except end;
end;

procedure TFormMain.N112Click(Sender: TObject);
begin
try
  FormPublic.NStatusBarE.Click;
except end;
end;

procedure TFormMain.G1Click(Sender: TObject);
begin
try
  FormPublic.NLargest.Click;
except end;
end;

procedure TFormMain.L1Click(Sender: TObject);
begin
try
  FormPublic.NLarger.Click;
except end;
end;

procedure TFormMain.M1Click(Sender: TObject);
begin
try
  FormPublic.NMiddle.Click;
except end;
end;

procedure TFormMain.S1Click(Sender: TObject);
begin
try
  FormPublic.NSmall.Click;
except end;
end;

procedure TFormMain.A1Click(Sender: TObject);
begin
try
  FormPublic.NSmallest.Click;
except end;
end;

procedure TFormMain.N502Click(Sender: TObject);
begin
try
  FormPublic.N50.Click;
except end;
end;

procedure TFormMain.N752Click(Sender: TObject);
begin
try
  FormPublic.N75.Click;
except end;
end;

procedure TFormMain.N1003Click(Sender: TObject);
begin
try
  FormPublic.N100.Click;
except end;
end;

procedure TFormMain.N1252Click(Sender: TObject);
begin
try
  FormPublic.N125.Click;
except end;
end;

procedure TFormMain.N1503Click(Sender: TObject);
begin
try
  FormPublic.N150.Click;
except end;
end;

procedure TFormMain.N2003Click(Sender: TObject);
begin
try
  FormPublic.N200.Click;
except end;
end;

procedure TFormMain.N93Click(Sender: TObject);
begin
try
  FormPublic.NStop.Click;
except end;
end;

procedure TFormMain.N94Click(Sender: TObject);
begin
try
  FormPublic.NTOPageHome.Click;
except end;
end;

procedure TFormMain.N95Click(Sender: TObject);
begin
try
  FormPublic.NTOPageEnd.Click;
except end;
end;

procedure TFormMain.N97Click(Sender: TObject);
begin
try
  FormPublic.NRefresh.Click;
except end;
end;

procedure TFormMain.N99Click(Sender: TObject);
begin
try
  FormPublic.NAllStop.Click;
except end;
end;

procedure TFormMain.N100Click(Sender: TObject);
begin
try
  FormPublic.NAllRefresh.Click;
except end;
end;

procedure TFormMain.N102Click(Sender: TObject);
begin
try
  FormPublic.NPreviousPage.Click;
except end;
end;

procedure TFormMain.N103Click(Sender: TObject);
begin
try
  FormPublic.NNextPage.Click;
except end;
end;

procedure TFormMain.N105Click(Sender: TObject);
begin
try
  FormPublic.NSource.Click;
except end;
end;

procedure TFormMain.N113Click(Sender: TObject);
begin
try
  FormPublic.NAddFavorite.Click;
except end;
end;

procedure TFormMain.N114Click(Sender: TObject);
begin
try
  FormPublic.NTrimFavorite.Click;
except end;
end;

procedure TFormMain.N115Click(Sender: TObject);
begin
try
  FormPublic.NOpenFavoriteDir.Click;
except end;
end;

procedure TFormMain.N117Click(Sender: TObject);
begin
try
  FormPublic.NSetGroup.Click;
except end;
end;

procedure TFormMain.N118Click(Sender: TObject);
begin
try
  FormPublic.NSaveToGroup.Click;
except end;
end;

procedure TFormMain.N137Click(Sender: TObject);
begin
try
  FormPublic.NStopPopup.Click;
except end;
end;

procedure TFormMain.N138Click(Sender: TObject);
begin
try
  FormPublic.NStopFloatAd.Click;
except end;
end;

procedure TFormMain.FLASH1Click(Sender: TObject);
begin
try
  FormPublic.NStopFlashAd.Click;
except end;
end;

procedure TFormMain.N140Click(Sender: TObject);
begin
try
  FormPublic.NSetWhiteList.Click;
except end;
end;

procedure TFormMain.N141Click(Sender: TObject);
begin
try
  FormPublic.NNoImage.Click;
except end;
end;

procedure TFormMain.N142Click(Sender: TObject);
begin
try
  FormPublic.NNoVideo.Click;
except end;
end;

procedure TFormMain.N143Click(Sender: TObject);
begin
try
  FormPublic.NNoBgsound.Click;
except end;
end;

procedure TFormMain.Java1Click(Sender: TObject);
begin
try
  FormPublic.NNoJava.Click;
except end;
end;

procedure TFormMain.Scripts1Click(Sender: TObject);
begin
try
  FormPublic.NNoScript.Click;
except end;
end;

procedure TFormMain.ActiveX1Click(Sender: TObject);
begin
try
  FormPublic.NNoActivex.Click;
except end;
end;

procedure TFormMain.N123Click(Sender: TObject);
begin
try
  FormPublic.NAtMemThrift.Click;
except end;
end;

procedure TFormMain.N144Click(Sender: TObject);
begin
try
  FormPublic.NSetProxy.Click;
except end;
end;

procedure TFormMain.IE2Click(Sender: TObject);
begin
try
  FormPublic.NUseIEProxy.Click;
except end;
end;

procedure TFormMain.N146Click(Sender: TObject);
begin
try
  FormPublic.NNoUseProxy.Click;
except end;
end;

procedure TFormMain.N127Click(Sender: TObject);
begin
try
  FormPublic.NCheckDefaultBrowser.Click;
except end;
end;

procedure TFormMain.N147Click(Sender: TObject);
begin
try
  FormPublic.NSetBrowserTOP.Click;
except end;
end;

procedure TFormMain.IE3Click(Sender: TObject);
begin
try
  FormPublic.NSetBrowserIE.Click;
except end;
end;

procedure TFormMain.N148Click(Sender: TObject);
begin
try
  FormPublic.NFaceStyle0.Click;
except end;
end;

procedure TFormMain.N149Click(Sender: TObject);
begin
try
  FormPublic.NFaceStyle1.Click;
except end;
end;

procedure TFormMain.N150Click(Sender: TObject);
begin
try
  FormPublic.NFaceStyle2.Click;
except end;
end;

procedure TFormMain.N601Click(Sender: TObject);
begin
try
  FormPublic.NTabWidth.Click;
except end;
end;

procedure TFormMain.N801Click(Sender: TObject);
begin
try
  FormPublic.NTabWidth.Click;
except end;
end;

procedure TFormMain.N1002Click(Sender: TObject);
begin
try
  FormPublic.NTabWidth.Click;
except end;
end;

procedure TFormMain.N1201Click(Sender: TObject);
begin
try
  FormPublic.NTabWidth.Click;
except end;
end;

procedure TFormMain.N1502Click(Sender: TObject);
begin
try
  FormPublic.NTabWidth.Click;
except end;
end;

procedure TFormMain.N1801Click(Sender: TObject);
begin
try
  FormPublic.NTabWidth.Click;
except end;
end;

procedure TFormMain.N2002Click(Sender: TObject);
begin
try
  FormPublic.NTabWidth.Click;
except end;
end;

procedure TFormMain.LOGO2Click(Sender: TObject);
begin
try  
  FormPublic.NShowWebIconY.Click;
except end;
end;

procedure TFormMain.LOGO3Click(Sender: TObject);
begin
try
  FormPublic.NShowWebIconN.Click;
except end;
end;

procedure TFormMain.N151Click(Sender: TObject);
begin
try
  FormPublic.NTabStyle0.Click;
except end;
end;

procedure TFormMain.N152Click(Sender: TObject);
begin
try
  FormPublic.NTabStyle1.Click;
except end;
end;

procedure TFormMain.N154Click(Sender: TObject);
begin
try
  FormPublic.NTabAutoWidth.Click;
except end;
end;

procedure TFormMain.N133Click(Sender: TObject);
begin
try
  FormPublic.NRunOne.Click;
except end;
end;

procedure TFormMain.Intenet1Click(Sender: TObject);
begin
try
  FormPublic.NInternetOption.Click;
except end;
end;

procedure TFormMain.N136Click(Sender: TObject);
begin
try
  FormPublic.NTOPOption.Click;
except end;
end;

procedure TFormMain.N191Click(Sender: TObject);
begin
try
  FormPublic.NWeather.Click;
except end;
end;

procedure TFormMain.N157Click(Sender: TObject);
begin
try
  FormPublic.NQuickClearMemory.Click;
except end;
end;

procedure TFormMain.N159Click(Sender: TObject);
begin
try
  FormPublic.NPlayMusic.Click;
except end;
end;

procedure TFormMain.N160Click(Sender: TObject);
begin
try
  FormPublic.NMTV.Click;
except end;
end;

procedure TFormMain.N162Click(Sender: TObject);
begin
try
  FormPublic.NTabLock.Click;
except end;
end;

procedure TFormMain.N164Click(Sender: TObject);
begin
try
  FormPublic.NSaveForm.Click;
except end;
end;

procedure TFormMain.N165Click(Sender: TObject);
begin
try
  FormPublic.NSInput.Click;
except end;
end;

procedure TFormMain.N166Click(Sender: TObject);
begin
try
  FormPublic.NInputTable.Click;
except end;
end;

procedure TFormMain.N168Click(Sender: TObject);
begin
try
  FormPublic.NGetScreen.Click;
except end;
end;

procedure TFormMain.N170Click(Sender: TObject);
begin
try
  FormPublic.NUnLockWebPage.Click;
except end;
end;

procedure TFormMain.N172Click(Sender: TObject);
begin
try
  FormPublic.NCurrNoSilent.Click;
except end;
end;

procedure TFormMain.N174Click(Sender: TObject);
begin
try
  FormPublic.NWebAutoRefresh.Click;
except end;
end;

procedure TFormMain.N193Click(Sender: TObject);
begin
try
  FormPublic.NMyComputer.Click;
except end;
end;

procedure TFormMain.N194Click(Sender: TObject);
begin
try
  FormPublic.NNotepad.Click;
except end;
end;

procedure TFormMain.N195Click(Sender: TObject);
begin
try
  FormPublic.NMspaint.Click;
except end;
end;

procedure TFormMain.N196Click(Sender: TObject);
begin
try
  FormPublic.NRunControl.Click;
except end;
end;

procedure TFormMain.N197Click(Sender: TObject);
begin
try
  FormPublic.NAddDeleteControl.Click;
except end;
end;

procedure TFormMain.N198Click(Sender: TObject);
begin
try
  FormPublic.NCommandLine.Click;
except end;
end;

procedure TFormMain.N199Click(Sender: TObject);
begin
try
  FormPublic.NRegedit.Click;
except end;
end;

procedure TFormMain.N200Click(Sender: TObject);
begin
try
  FormPublic.NCleanAddress.Click;
except end;
end;

procedure TFormMain.N201Click(Sender: TObject);
begin
try
  FormPublic.NClearSearchHistory.Click;
except end;
end;

procedure TFormMain.N202Click(Sender: TObject);
begin
try
  FormPublic.NCleanNewly.Click;
except end;
end;

procedure TFormMain.N204Click(Sender: TObject);
begin
try
  FormPublic.NCleanHistory.Click;
except end;
end;

procedure TFormMain.Cache1Click(Sender: TObject);
begin
try
  FormPublic.NCleanCache.Click;
except end;
end;

procedure TFormMain.Cookies1Click(Sender: TObject);
begin
try
  FormPublic.NCleanCookies.Click;
except end;
end;

procedure TFormMain.N206Click(Sender: TObject);
begin
try
  FormPublic.NCleanTempDir.Click;
except end;
end;

procedure TFormMain.N207Click(Sender: TObject);
begin
try
  FormPublic.NCleanRecent.Click;
except end;
end;

procedure TFormMain.N209Click(Sender: TObject);
begin
try
  FormPublic.NCleanAll.Click;
except end;
end;

procedure TFormMain.N179Click(Sender: TObject);
begin
try
  FormPublic.NSubHelp.Click;
except end;
end;

procedure TFormMain.N180Click(Sender: TObject);
begin
try
  FormPublic.NHelpOnline.Click;
except end;
end;

procedure TFormMain.N182Click(Sender: TObject);
begin
try
  FormPublic.NBrowserHomePage.Click;
except end;
end;

procedure TFormMain.N183Click(Sender: TObject);
begin
try
  FormPublic.NBrowserBBS.Click;
except end;
end;

procedure TFormMain.N186Click(Sender: TObject);
begin
try
  FormPublic.NSustain.Click;
except end;
end;

procedure TFormMain.N187Click(Sender: TObject);
begin
try
  FormPublic.NUpdateOnline.Click;
except end;
end;

procedure TFormMain.N190Click(Sender: TObject);
begin
try
  FormPublic.NAbout.Click;
except end;
end;
{$ENDIF}
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

procedure TFormMain.Action_AlexaExExecute(Sender: TObject);
begin
try
  {
  AlexaEx := not AlexaEx;
  if AlexaEx then
  begin
    FormMain.StatusBar.Panels[0].Width := FormMain.StatusBar.Panels[0].Width - 100;
    FormMain.StatusBar.Panels[2].Width := FormMain.StatusBar.Panels[2].Width + 100;
    WritePrivateProfileString('setting','AlexaEx','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    StatusBar.Panels[2].Text := '';
    FormMain.StatusBar.Panels[0].Width := FormMain.StatusBar.Panels[0].Width + 100;
    FormMain.StatusBar.Panels[2].Width := FormMain.StatusBar.Panels[2].Width - 100;
    WritePrivateProfileString('setting','AlexaEx','0',PChar(MyDir+ConfigFile));
  end;
  }
except end;
end;

procedure TFormMain.NGOClick(Sender: TObject);
begin
try
  BBGO.Click;
except end;
end;

procedure TFormMain.NGOSearchClick(Sender: TObject);
begin
try
  ComboBoxSearch.Text := CBURL.Text;
  ToolButtonSearch.OnClick(Sender);
except end;
end;

procedure TFormMain.NGetClipbrdSearchClick(Sender: TObject);
begin
try
  if (Clipboard.HasFormat(CF_TEXT) or Clipboard.HasFormat(CF_OEMTEXT)) then
  begin
    ComboBoxSearch.Text := (Clipboard.asText);
    ButtonSearch.Click;
  end;
except end;
end;

procedure TFormMain.NGetClipbrdGoClick(Sender: TObject);
begin
try
  if (Clipboard.HasFormat(CF_TEXT) or Clipboard.HasFormat(CF_OEMTEXT)) then
  begin
    CBURL.TEXT := (Clipboard.asText);
    //ShowMessage(Clipboard.asText);
    BBGO.Click;
  end;
except end;
end;

procedure TFormMain.Action_Test1Execute(Sender: TObject);
begin
try
  if fileExists(MyDir + 'txt.txt') then 
  CBURL.Text := TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl;
except end;
end;                         

procedure TFormMain.ToolBarAddressResize(Sender: TObject);
begin
try
  exit;     
  {
        if not SearchShow then
        ToolBarAddress.Width := PaintPanelButtonAddress.Width - ToolBarBGO.Width - 10
        else
        ToolBarAddress.Width := PaintPanelButtonAddress.Width - ToolBarBGO.Width - ToolBarSearchEdit.Width - ToolBarSearchButton.Width - 10;
        CBURL.Width := ToolBarAddress.Width - ToolBarAddress.Indent - 14 - 2;
        //CBURL.Width := ToolBar9.Width - 23;
        ComboBoxSearch.Left := ToolBarSearchEdit.Left + 26;

  CBURL.Width := ToolBarAddress.Width - ToolBarAddress.Indent - 14 - 2;
  //CBURL.Width := ToolBar9.Width - 23;
  ComboBoxSearch.Left := ToolBarSearchEdit.Left + 26;
  }
except end;
end;

procedure TFormMain.ToolBarBGOCustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
try
  with Sender.Canvas do
  begin
    CopyRect(ARect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
    Pen.Color := TColor($808080);
    MoveTo(0, Sender.Height -1);
    //LineTo(Sender.Width, Sender.Height -1);
  end;
except end;
end;

procedure TFormMain.ToolBarBGOCustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  Index: Integer;
begin
try
  DefaultDraw := False;
  Index := Button.Tag;
  if cdsHot in State then Inc(Index, 2);
  if cdsSelected in State then Inc(Index, 2);
  ImageList4.Draw(Sender.Canvas, Button.Left + 4, Button.Top + 4, Index);
except end;
end;

procedure TFormMain.ToolBarSearchEditCustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
var
  SrcR, DestR: TRect;
  i: Word;
begin
try
  if not ToolBarSearchEdit.Visible then exit;
  {
  Sender.Canvas.CopyRect(ARect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
  SrcR := Image7.ClientRect;
  SrcR.Right := 12;
  DestR := SrcR;
    //Inc(DestR.Bottom, 2);
  OffsetRect(DestR, 0, 7);
  Sender.Canvas.BrushCopy(DestR, Image7.Picture.Bitmap, SrcR, clFuchsia);
  OffsetRect(SrcR, Image7.Width - 12, 0);
  OffsetRect(DestR, Sender.Width - 12, 0);
  Sender.Canvas.BrushCopy(DestR, Image7.Picture.Bitmap, SrcR, clFuchsia);
  OffsetRect(SrcR, - 12, 0);
  DestR.Left := 12;
  DestR.Right := Sender.Width - 12;
  Sender.Canvas.BrushCopy(DestR, Image7.Picture.Bitmap, SrcR, clFuchsia);
  }
  Sender.Canvas.CopyRect(ARect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
  SrcR := Image8.ClientRect;
  SrcR.Right := 3;    
  DestR := SrcR;
  Inc(DestR.Bottom, 0);          //2
  OffsetRect(DestR, 0, 7);   //5 //6
  Sender.Canvas.BrushCopy(Destr, Image8.Picture.Bitmap, SrcR, clFuchsia);
  OffsetRect(SrcR, Image8.Width - 3, 0);
  OffsetRect(DestR, Sender.Width - 3, 0);
  Sender.Canvas.BrushCopy(DestR, Image8.Picture.Bitmap, SrcR, clFuchsia);
  OffsetRect(SrcR, -3, 0);
  DestR.Left := 3;
  DestR.Right := Sender.Width - 3;
  Sender.Canvas.CopyRect(DestR, Image8.Picture.Bitmap.Canvas, SrcR);
  //ImageList3.Draw(Sender.Canvas, 8, 9, SearchOn);    exit;
  case SearchOn of
    0,1: i := 0;
    2: i := 1;
    3: i := 13;
    4: i := 15;                     
  end;                       
  ImageList3.Draw(Sender.Canvas, 8, 11, i);
  {
  exit;
  Sender.Canvas.Pen.Color := TColor($808080);
  Sender.Canvas.MoveTo(0, Sender.Height -1);
  Sender.Canvas.LineTo(Sender.Width, Sender.Height -1);
  }
except end;
end;

procedure TFormMain.ToolBarSearchButtonCustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
try
  if not ToolBarSearchButton.Visible then exit;
  //{
  with Sender.Canvas do
  begin
    CopyRect(ARect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
    Pen.Color := TColor($808080);
    MoveTo(0, Sender.Height -1);
    //LineTo(Sender.Width, Sender.Height -1);
  end;
  //}
  //Sender.Canvas.CopyRect(ARect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
except end;
end;

procedure TFormMain.ToolBarSearchButtonCustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  Index: Integer;
begin
try
  if not ToolBarSearchButton.Visible then exit;
  DefaultDraw := False;
  Index := Button.Tag;
  if cdsHot in State then Inc(Index, 2);
  if cdsSelected in State then Inc(Index, 2);
  ImageList4.Draw(Sender.Canvas, Button.Left + 4, Button.Top + 4, Index);
except end;
end;

procedure TFormMain.CBURLClick(Sender: TObject);
begin
try
    FormMain.BBGO.OnClick(Sender);
except end;
end;

procedure TFormMain.CBURLKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  KeyState: TKeyBoardState;
begin
try
  try
  if (Shift=[ssCtrl]) and (Key=13) then
  begin
    MoreUrlOpen := false;
    CBURL.Text:='http://www.'+Trim(CBURL.Text)+'.com/';
    FormMain.BBGO.OnClick(Sender);
    FormPublic.DocumentSetFocus;
    exit;
  end;
  if (Shift=[ssAlt]) and (Key=13) then
  begin
    MoreUrlOpen := false;
    CBURL.Text:='http://www.'+Trim(CBURL.Text)+'.net/';
    FormMain.BBGO.OnClick(Sender);
    FormPublic.DocumentSetFocus;
    exit;
  end;
  if (Shift=[ssShift]) and (Key=13) then
  begin
    MoreUrlOpen := false;
    CBURL.Text:='http://www.'+Trim(CBURL.Text)+'.com.cn/';
    FormMain.BBGO.OnClick(Sender);
    FormPublic.DocumentSetFocus;
    exit;
  end;
  if Key=VK_RETURN then
  begin    MoreUrlOpen := false;    FormMain.BBGO.OnClick(Sender);    FormPublic.DocumentSetFocus;    exit;  end;
  finally
  end;
except end;
end;

procedure TFormMain.ToolButtonSearchClick(Sender: TObject);
var
  Url, Url2: String;
  I: Integer;
  IsSearch: Boolean;
  KeyWord: String;
begin     
try
  {
  ShowMessage(WB1_.LocationUrl);
  ShowMessage(WB1_2.LocationUrl);
  ShowMessage(WB_eb.LocationUrl);
  exit;
  }
  //if not BBGO.Visible then halt;
  IsSearch := false;
  Url := Trim(ComboBoxSearch.Text);
  //KeyWord := '';
  KeyWord := Url;
  if (Url = '') or (LowerCase(Url) = 'about:blank') then exit;

  //fffffffffffffffffffffffffhhhhhhhhhhhhhhhhhhhhhhhhhh

  try
  Case SearchOn of
  0,1:
  begin
    if (Url = SearchID1NameShow) {and (DBIndex = true)} then
    begin
      if ((LowerCase(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl)<>'about:blank') or (TFormWebBrowser(wbList[PageIndex]).WebBrowser.Busy)) then
      begin
        FormMain.ToolButtonTabNew.OnClick(Sender);           end;        
      CBURL.Text := 'http://www.baidu.com/baidu?';
      //TFormWebBrowser(wbList[PageIndex]).WebBrowser.Go(SearchID1MainUrl + SearchID1);
      TFormWebBrowser(wbList[PageIndex]).WebBrowser.Go(BaiduIdUrl);
      CBURL.Text := 'http://www.baidu.com/baidu?';
      IsSearch := true;
      Url2 := FormPublic.KBDString(Url);
      exit;
    end;
    //else if (Url = SearchID1NameShow) then exit;
    Url := StringReplace(SearchID1Url, 'KEYWORD_', Url, [rfReplaceAll,rfIgnoreCase]);
    {
    I := Pos('tn=' + BaiDuSearchIDMain1, Url);
    if I <> 0 then
    begin
      Url2 := Copy(Url, 1, I - 1) + Copy(Url, I + Length(BaiduSearchIDMain1) + 3 + 3 + 1, Length(Url) - I);
      IsSearch := true;
    end;
    }
    IsSearch := true;
    Url2 := FormPublic.KBDString(Url);
  end;
  //2: Url := StringReplace(SearchID2Url, 'KEYWORD_', Url, [rfReplaceAll,rfIgnoreCase]);
  2:
  begin
    if (Url = SearchID2NameShow) {and (DGIndex)} then
    begin
      if ((LowerCase(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl)<>'about:blank') or (TFormWebBrowser(wbList[PageIndex]).WebBrowser.Busy)) then
      begin
        FormMain.ToolButtonTabNew.OnClick(Sender);      end;      CBURL.Text := 'http://www.google.cn/';
      TFormWebBrowser(wbList[PageIndex]).WebBrowser.Go(GoogleIdUrl);
      //CBURL.Text := 'http://www.google.cn/';
      exit;
    end;
    //else if (Url = SearchID2NameShow) then exit;
    Url := StringReplace(SearchID2Url, 'KEYWORD_', Url, [rfReplaceAll,rfIgnoreCase]);
  end;
  3: Url := StringReplace(SearchID3Url, 'KEYWORD_', Url, [rfReplaceAll,rfIgnoreCase]);
  4: Url := StringReplace(SearchID4Url, 'KEYWORD_', Url, [rfReplaceAll,rfIgnoreCase]);
  5: Url := StringReplace(SearchID5Url, 'KEYWORD_', Url, [rfReplaceAll,rfIgnoreCase]);
  6: Url := StringReplace(SearchID6Url, 'KEYWORD_', Url, [rfReplaceAll,rfIgnoreCase]);
  7: Url := StringReplace(SearchID7Url, 'KEYWORD_', Url, [rfReplaceAll,rfIgnoreCase]);
  end;
  //ShowMessage(Url); exit;
  {
  end
  else
  begin
    Url := 'http://www.' + Url + '.com'; //ShowMessage(Url); exit;
    end;
  }
  if ((LowerCase(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl)<>'about:blank') or (TFormWebBrowser(wbList[PageIndex]).WebBrowser.Busy)) then
  begin
    {
    CBUrl.Text := 'about:blank';
    StatusBar.Panels[0].Text := '';
    if AppendTab and (wbList.Count > 0) then FormPublic.NewPage(PageIndex + 1, Url, True)
    else FormPublic.NewPage(wbList.Count, Url, True);    exit;    }    FormMain.ToolButtonTabNew.OnClick(Sender);  end;

  //if Trim(Url2) <> '' then CBURL.Text := URL2 else CBURL.Text := URL;
  if (IsSearch) then CBURL.Text := URL2 else CBURL.Text := URL;
  //ShowMessage(Url2); exit;
  //TFormWebBrowser(wbList[PageIndex]).WebBrowser.Hint := 'SEARCH';
  //TFormWebBrowser(wbList[PageIndex]).Search := true;
  TFormWebBrowser(wbList[PageIndex]).WebBrowser.Navigate(Url);
  FormPublic.DocumentSetFocus;

  finally
    {
    eKeyWord := KeyWord;
    ThreadI:=88;
    RunProcess2.Create(False);
    }
    //ComboBoxSearch.Items.Add(KeyWord);   //kko
    ToolButton100.Caption := ZoomStr;
    ToolButton100.Hint := ZoomStr;
  end;
except end;
end;

procedure TFormMain.ComboBoxSearchChange(Sender: TObject);
begin
try
  if Trim(ComboBoxSearch.Text) = '' then
  begin
    exit;
  end;
  if ComboBoxSearch.Font.Color=clGray then
  begin
    ComboBoxSearch.Font.Color:=clWindowText;
  end;
except end;
end;

procedure TFormMain.ComboBoxSearchClick(Sender: TObject);
begin
try
  if ComboBoxSearch.Font.Color=clGray then
  begin
    ComboBoxSearch.Text:='';
    ComboBoxSearch.Font.Color:=clWindowText;
  end;
  //ToolButtonSearch.OnClick(Sender);
except end;
end;

procedure TFormMain.ComboBoxSearchKeyPress(Sender: TObject; var Key: Char);
begin
try
  if Key=#13 then ToolButtonSearch.onClick(Sender);
except end;
end;

procedure TFormMain.BBGOMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
{$IFDEF MenuSmall}
var
  P: TPoint;
{$ENDIF}
begin
try
  {$IFDEF MenuSmall}
  if (Button = mbRight) then
  begin
    GetCursorPos(P);
    if ToolBarMenu.Visible = false then
    begin
      MainMenu1.Popup(P.X,P.Y);
    end
    else
    begin
      //ImageGo.Picture := ImageGo3.Picture;
      PMGORPop.Popup(P.X,P.Y);
    end;
  end
  else ;  //ImageGo.Picture := ImageGo3.Picture;
  {$ELSE}
  //ImageGo.Picture := ImageGo3.Picture;
  {$ENDIF}
except end;
end;

procedure TFormMain.ToolBarSearchEditMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Pt: TPoint;
begin
try
  if (Button=mbLeft) then  
  if (X < ComboBoxSearch.Left) and (X > (ComboBoxSearch.Left - 1535)) then
  //if (X <= ToolBarSearchEdit.Left) and (X >= ToolBarSearchEdit.Left + 300) then
  begin
    //GetCursorPos(Pt);   //halt;
    Pt.x := ComboBoxSearch.Left - 3; // + CBURL.Width + EditSearch.Width;
    Pt.y := ComboBoxSearch.Top + ComboBoxSearch.Height + 27;    Pt := FormMain.ClientToScreen(Pt);    PopupMenuSearch.Popup(Pt.X, Pt.Y);
  end;      
except end;
end;

procedure TFormMain.BBGOClick(Sender: TObject);
var
  Url, Url2: String;
  I, J: Integer;
  NoEnglish: Boolean;
  IsSearch: Boolean;
  KeyWord: String;
begin          
try
  try
    //ShowMessage(wb_eb.LocationURL); exit;
    //FormMain.Caption := wb_eb.LocationURL; ToolBarMenu.Repaint;  exit;
    //FormPublic.TabAutoWidthControl; exit; 
    //ShowMessage(IntToStr(StrToInt(GetDateTime2(6)) mod 2));exit;
       //ToolButton1.hide;
       //ShowMessage(IntToStr(ImageListWebIcon.Count));
       //ShowMessage(MyDir + 'Temp\' + 'WebIcon.ico'); exit;
       //FormMain.WindowState := wsMaximized; exit;
       //if StopPopup then showmessage('...'); //exit;
       //if not TFormWebBrowser(wbList[PageIndex]).IsPopup then halt;
    KeyWord := '';
    Url2 := '';
    IsSearch := false;

    Url := Trim(CBURL.Text);    
    if (Url = '') {or (Url = 'about:blank')} then exit;

    if (LowerCase(Copy(URL,1,6) )= 'top://') then exit;

    //if not LoadLastOpenOK then LoadLastOpenOK := false;
    //if ShowWebIcon2 then ShowWebIcon2 := false;        

    if (Url = 'about:') or (Url = 'about:blank') then
    begin
      if wbList.Count <= 0 then ToolButtonTabNew.Click;
      TFormWebBrowser(wbList[PageIndex]).WebBrowser.Navigate(Url);
      TFormWebBrowser(wbList[PageIndex]).WebUrl := Url;
      if ShowWebIcon then
      FormMain.ImageListWebIcon.ReplaceIcon(PageIndex, FormMain.ImageWebIcon2.Picture.Icon);
      if TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag = ZoomTag then TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag := 0;
      exit;
    end;

    FormMain.Panel_StatusBar1.Caption := '';

    if (LowerCase(Copy(URL,1,11)) = 'javascript:') then
    begin
      TFormWebBrowser(wbList[PageIndex]).WebBrowser.go(Url);
      exit;
    end;

    //TFormWebBrowser(wbList[PageIndex]).WebBrowser.Go('javascript:alert(document.body.innerHTML)');  exit;

    HoldOneTab := false;

    if (LowerCase(Copy(URL,1,7) )= 'http://')
    or (LowerCase(Copy(URL,1,8)) = 'https://')
    or (LowerCase(Copy(URL,1,7)) = 'rtsp://')
    or (LowerCase(Copy(URL,1,6)) = 'mms://')
    or (LowerCase(Copy(URL,1,7)) = 'file://')
    or (LowerCase(Copy(URL,1,6)) = 'ftp://')
    then URL := URL
    else if ((Length(URL) >= 2) and (Pos(':', URL) = 2)) then
    begin
      if (Pos('\', URL) = Length(URL)) or (Pos('/', URL) = Length(URL)) then
      URL := 'file://' + URL
      else URL := 'file://' + URL + '/';
    end
    else
      if ((Pos('.', URL)>0) or (LowerCase(URL) = 'localhost')) then
      URL := 'http://' + URL
    else
    begin     //ShowMessage(Url); exit;
      //SEARCH
      {
      EditSearch.Text := Url;
      ToolButtonSearch.OnClick(Sender);
      }

      //for j := 0 to length(URL) - 1 do if ByteType(URL, j) = mbLeadByte then NoEnglish := true;

      //if NoEnglish then
      //begin
        KeyWord := Url;
        Case SearchOn of
        0,1:
        begin
          Url := StringReplace(SearchID1Url, 'KEYWORD_', Url, [rfReplaceAll,rfIgnoreCase]);
          {
          I := Pos('tn=' + BaiDuSearchIDMain1, Url);
          if I <> 0 then
          begin
            Url2 := Copy(Url, 1, I - 1) + Copy(Url, I + Length(BaiduSearchIDMain1) + 3 + 3 + 1, Length(Url) - I);
            IsSearch := true;
          end;
          }
          IsSearch := true;
          Url2 := FormPublic.KBDString(Url);
        end;
        2: Url := StringReplace(SearchID2Url, 'KEYWORD_', Url, [rfReplaceAll,rfIgnoreCase]);
        3: Url := StringReplace(SearchID3Url, 'KEYWORD_', Url, [rfReplaceAll,rfIgnoreCase]);
        4: Url := StringReplace(SearchID4Url, 'KEYWORD_', Url, [rfReplaceAll,rfIgnoreCase]);
        5: Url := StringReplace(SearchID5Url, 'KEYWORD_', Url, [rfReplaceAll,rfIgnoreCase]);
        6: Url := StringReplace(SearchID6Url, 'KEYWORD_', Url, [rfReplaceAll,rfIgnoreCase]);
        7: Url := StringReplace(SearchID7Url, 'KEYWORD_', Url, [rfReplaceAll,rfIgnoreCase]);
        end;
      {
      end
      else
      begin
        Url := 'http://www.' + Url + '.com'; //ShowMessage(Url); exit;
      end;
      }
      if ({(LowerCase(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl)<>'about:') or} (LowerCase(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl)<>'about:blank') or (TFormWebBrowser(wbList[PageIndex]).WebBrowser.Busy)) then
      begin
        {
        CBUrl.Text := 'about:blank';
        StatusBar.Panels[0].Text := '';
        if AppendTab and (wbList.Count > 0) then FormPublic.NewPage(PageIndex + 1, Url, True)
        else FormPublic.NewPage(wbList.Count, Url, True);        exit;        }        if AlwaysNewTab then        FormMain.ToolButtonTabNew.OnClick(Sender)        else if ShowWebIcon then        begin          TFormWebBrowser(wbList[PageIndex]).Closeing := false;          FormMain.ImageListWebIcon.ReplaceIcon(PageIndex, FormMain.ImageWebIcon2.Picture.Icon);
          TFormWebBrowser(wbList[PageIndex]).DownIcon := false;
          TFormWebBrowser(wbList[PageIndex]).UpdateWebIconOk := false;
          //FormPublic.GetWebIconOK := true;
        end;      end;
      //if EnabledShowPageLogo then (TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document as IHTMLDocument2).body.innerHTML := '';
      //if Trim(Url2) <> '' then CBURL.Text := URL2 else CBURL.Text := URL;
      if IsSearch then CBURL.Text := URL2 else CBURL.Text := URL;
      //ShowMessage(Url2); exit;
      //TFormWebBrowser(wbList[PageIndex]).WebBrowser.Hint := 'SEARCH';
      //TFormWebBrowser(wbList[PageIndex]).Search := true;
      TFormWebBrowser(wbList[PageIndex]).WebBrowser.Navigate(Url);
      FormPublic.DocumentSetFocus;   //hahaha
    {
    eKeyWord := KeyWord;
    ThreadI:=88;
    RunProcess2.Create(False);
    }
      exit;
    end;


    //if (Trim(Url) = 'baidu.com') or (Trim(Url) = 'www.baidu.com') or (Trim(Url) = 'http://www.baidu.com') or (Trim(Url) = 'http://www.baidu.com/') then Url:='http://www.baidu.com/index.php?tn='+BaiDuSearchID;
    if DBIndex then
    if Pos('baidu.com', Url) <> 0 then
    if ((Url = 'baidu.com') or (Url = 'www.baidu.com') or (Url = 'http://baidu.com') or (Url = 'http://www.baidu.com') or (Url = 'http://www.baidu.com/') or (Url = 'http://www.baidu.com/index.php?')) then
    begin
      //halt;
      {
      Url:='http://www.baidu.com/index.php?tn='+SearchID1;  //SearchID1MainUrl
      I := Pos('tn=' + BaiDuSearchIDMain1, Url);
      if I <> 0 then
      begin
        Url2 := Copy(Url, 1, I - 1) + Copy(Url, I + Length(BaiduSearchIDMain1) + 3 + 3 + 1, Length(Url) - I);
      end;
      }
      Url := BaiduIdUrl;  //Url:='http://www.baidu.com/index.php?tn='+SearchID1;
      IsSearch := true;
      Url2 := FormPublic.KBDString(Url);
    end;

    if DGIndex and DGIndex2 then
    if Pos('google', LowerCase(Url)) <> 0 then
    if ((Url = 'google.com') or (Url = 'www.google.com') or (Url = 'http://google.com') or (Url = 'http://www.google.com') or (Url = 'http://www.google.com/') or (Url = 'google.cn')  or (Url = 'http://google.cn') or (Url = 'www.google.cn') or (Url = 'http://www.google.cn') or (Url = 'http://www.google.cn/')) then
    begin
      Url := GoogleIdUrl;
      //Url := FormPublic.KGGString(Url);
      //IsSearch := true;
    end;

    //CBURL.Text := 'http://www.baidu.com/index.php?';
    //{
    if (EXOK) and (AlexaEx) then
    begin
      AlexaUrl := Url;
      ThreadI := 18;
      RunProcess2.Create(False);
      //FormPublic.ExInit;
      //FormMain.StatusBar.Panels[3].Text := (FormPublic.GetAlexa(PChar(AlexaUrl)));
    end;
    //}

    if wbList.Count <= 0 then
    begin
      ToolButtonTabNew.Click; //CreateOneTab;
      CBURL.Text := Url;
      TFormWebBrowser(wbList[0]).Closeing := false;
      TFormWebBrowser(wbList[0]).WebBrowser.Navigate(Url);
      exit;
    end;

    if (MoreUrlOpen or ((TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl) <> 'about:blank') or (TFormWebBrowser(wbList[PageIndex]).WebBrowser.Busy)) then
    if AlwaysNewTab then
    ToolButtonTabNew.Click else if ShowWebIcon then
    begin
      FormMain.ImageListWebIcon.ReplaceIcon(PageIndex, FormMain.ImageWebIcon2.Picture.Icon);
      TFormWebBrowser(wbList[PageIndex]).DownIcon := false;
      TFormWebBrowser(wbList[PageIndex]).UpdateWebIconOk := false;
      //FormPublic.GetWebIconOK := true;
    end;

    TFormWebBrowser(wbList[PageIndex]).Closeing := false;
    TFormWebBrowser(wbList[PageIndex]).WebUrl := Url;
    TFormWebBrowser(wbList[PageIndex]).WebBrowser.Navigate(Url);
    TFormWebBrowser(wbList[PageIndex]).WebBrowser.Hint := 'one.';
    //if StopPopup then TFormWebBrowser(wbList[PageIndex]).IsPopup:=true;

    if IsSearch then
    begin
      CBURL.Text := Url2;
      FormMain.Panel_StatusBar1.Caption := ' >>正在打开地址:' + '<' + Url2 + '>';
    end
    else
    begin
      CBURL.Text := Url;
      FormMain.Panel_StatusBar1.Caption := ' >>正在打开地址:' + '<' + Url + '>';
    end;          

    FormPublic.DocumentSetFocus;
    //ShowMessage(Url);
    if IsSearch then Url := Url2;

    //ShowMessage(IntToStr(Length('http://www.sharebank.com.cn/soft/softbuy.php?soid=16062'))); exit;
    //UpdateTypedUrls(Url); exit;

    //if Length(URL) > 52 then exit;
    if Trim(URL) <>'' then
    begin
      if (CBURL.Items.Count > 0) then
      begin     //ShowMessage('true.');
        for I := 0 to CBURL.Items.Count-1 do
        begin
          if (URL = CBURL.Items[I]) {or (Copy(Url, 0, 22) = Copy(CBURL.Items[I], 0, 22))} then exit; //ShowMessage(IntToStr(i)); //halt; //exit;
        end;
      end;
      //if Length(URL) < 52 then
      CBURL.Items.Add(URL);  //ShowMessage(Url);
      //UpdateTypedUrls;
      URL:='';
    end;
  finally
    ToolButton100.Caption := ZoomStr;
    ToolButton100.Hint := ZoomStr;
  end;
except end;
end;

procedure TFormMain.ActionFullFormExecute(Sender: TObject);
begin
try
  FormPublic.NSInput.OnClick(Sender);
except end;
end;

procedure TFormMain.ActionSaveFormExecute(Sender: TObject);
begin
try
  FormPublic.NSaveForm.OnClick(Sender);
except end;
end;

procedure TFormMain.ToolBarMenuCustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  SrcR, DestR: TRect;
  Bitmap: TBitmap;
  R: TRect;
begin
try
  if cdsHot in State then Bitmap := ImageMenuMouseDown.Picture.Bitmap else
    if cdsSelected in State then Bitmap := ImageMenuMouseDown.Picture.Bitmap else Exit;
  DefaultDraw := False;  
  SrcR := Rect(0, 0, 5, ImageMenuMouseDown.Height);
  DestR := SrcR;
  OffsetRect(DestR, Button.Left, 2);
  Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
  OffsetRect(SrcR, ImageMenuMouseDown.Width - 5, 0);
  OffsetRect(DestR, Button.Width - 5, 0);
  Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
  OffsetRect(SrcR, -3, 0);
  DestR.Left := Button.Left + 5;
  Dec(DestR.Right, 5);
  Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
  R := Button.BoundsRect;
  Inc(R.Top, 2);
  SetBkMode(Sender.Canvas.Handle, TRANSPARENT);
  //Sender.Canvas.Font.Size := 15;
  //SelectObject(Sender.Canvas.Handle, Sender.Canvas.Font.Handle);
  //DefaultDraw := False;
  //R := Button.BoundsRect;
  //Sender.Canvas.Font.Size := 15;
  //SelectObject(Sender.Canvas.Handle, Sender.Canvas.Font.Handle);
  //DrawText(Sender.Canvas.Handle, PChar(Button.Caption), -1, R, DT_CENTER or DT_VCENTER or DT_SINGLELINE);

  DrawText(Sender.Canvas.Handle, PChar(Button.Caption), -1, R, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
except end;
end;

procedure TFormMain.Timer_SearchCTimer(Sender: TObject);
begin
try
  Timer_SearchC.Enabled := false;
  //ShowMessage(IntToStr(SearchChange));
  WritePrivateProfileString('RunData', 'SearchOn', PChar(IntToStr(SearchChange)), PChar(MyDir + ConfigFile));
  WritePrivateProfileString('setting', 'SearchChange', '1', PChar(MyDir + ConfigFile));
except end;
end;

procedure TFormMain.ActionCleanHistoryExecute(Sender: TObject);
begin
try
  {
  if FormMain.FormStyle = fsNormal then
  FormMain.FormStyle := fsStayOnTop
  else
  FormMain.FormStyle := fsNormal;
  }
  FormPublic.CleanNewly;
  DeleteDirFile((GetSystemFolderDir(CSIDL_RECENT)));
  ThreadI:=71;
  RunProcess.Create(False);
  //ThreadI:=72;
  //RunProcess.Create(False);
  //sdddddddddddddsfsfsfsfsdf
except end;
end;

procedure TFormMain.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
  str: string;
  i: integer;
begin
try
  if ssCtrl in Shift then
  begin
    if wbList.Count <= 0 then exit;
    if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
    str := TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom;
    if str = '' then
    begin
      str := '98%';
      TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom := str;
    end
    else
    begin
      Str := IntToStr(StrToInt(Copy(Str,1,Length(Str)-1)) - 2) + '%';
      TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom := Str;
    end;
    if (TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag <> LastUnCloseFlag) then TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag := ZoomTag;
    ToolButton100.Caption := str;
    ToolButton100.Hint := str;
  end;
except end;
end;

procedure TFormMain.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
  str: string;
  i: integer;
begin
try
  if ssCtrl in Shift then
  begin
    if wbList.Count <= 0 then exit;
    if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document=nil then exit;
    str := TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom;
    if str = '' then
    begin
      str := '102%';
      TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom := str;
    end
    else
    begin
      Str := IntToStr(StrToInt(Copy(Str,1,Length(Str)-1)) + 2) + '%';
      TFormWebBrowser(wbList[PageIndex]).WebBrowser.OleObject.Document.Body.Style.Zoom := Str;
    end;
    if (TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag <> LastUnCloseFlag) then TFormWebBrowser(wbList[PageIndex]).Webbrowser.Tag := ZoomTag;
    ToolButton100.Caption := str;
    ToolButton100.Hint := str;
  end;
except end;
end;

function GetTvList: Boolean;
var
  StrList: TStringList;
  inifile: tinifile;
  i: integer;
  Str_1, Str_2: String;
begin
try
  //Str2 := '';
  if not FileExists(MyDir + TVFile) then exit;  //halt;
  StrList := TStringList.Create;
  inifile := tinifile.create(MyDir + TVFile);
  inifile.{readsection}readsectionvalues('Data', StrList);
  try
  for i:=0 to StrList.Count-1 do
  begin
    str_1:=Copy(StrList[i],1,Pos('=',StrList[i])-1);
    str_2:=Copy(StrList[i],Pos('=',StrList[i])+1,Length(StrList[i])-Pos('=',StrList[i]));    //ShowMessage(str_1+'.'+str_2);
    {
    if i = StrList.Count-1 then
    Str2 := Str2 + Str_1 + '#' + Str_2
    else
    Str2 := Str2 + Str_1 + '#' + Str_2 + '#';
    }
    FormMain.ListBoxTV.Items.Add(str_1);
    FormMain.ListBoxTV2.Items.Add(str_2);
  end;
  //ShowMessage(Str2);
  //Result := Str2;
  finally
    inifile.Free;
    StrList.Free;
  end;
except end;
end;

procedure TFormMain.NTVListRefreshClick(Sender: TObject);
var
  Res:TReSourceStream;
begin
try
  ListBoxTV.Items.Clear;
  ListBoxTV2.Items.Clear;
  //ListBoxTV.Items.LoadFromFile(MyDir + TVFile);
  try
  if not FileExists(MyDir + TVFile) then
  begin
    Res:=TResourceStream.Create(Hinstance,'tv_txt',PChar('txt'));
    Res.SaveToFile(MyDir + TVFile);
    Res.Free;
  end;
  finally
  GetTvList;
  end;
except end;
end;

procedure TFormMain.NTVListEditClick(Sender: TObject);
var
  Res:TReSourceStream;
begin
try
  try
  //MyDir + TVFile
  if not FileExists(MyDir + TVFile) then
  begin
    Res:=TResourceStream.Create(Hinstance,'tv_txt',PChar('txt'));
    Res.SaveToFile(MyDir + TVFile);
    Res.Free;
  end;
  //ShellExecute(Handle, 'open', PChar(MyDir + TVFile), nil, nil, 0);
  finally
  ShellExecute(Handle,'open',PChar('"' + MyDir + TVFile + '"'),'','',SW_Show);
  end;
except end;
end;

procedure TFormMain.ListBoxTVDblClick(Sender: TObject);
var
  str1, str2: string;
begin         
try
  if ListBoxTV.Count<=0 then exit;
  if ListBoxTV.ItemIndex<0 then exit;
  str1 := Trim(ListBoxTV.Items[ListBoxTV.ItemIndex]);
  if (str1 <> '') or (str1 <> '-') then
  begin
    TimerPlayer.Enabled := false;
    wmp.Url := ListBoxTV2.Items[ListBoxTV.ItemIndex];
  end;
except end;
end;

procedure TFormMain.ActionClearLastNewlyExecute(Sender: TObject);
var
  Str: string;
begin
try
  NewlyUrl := ''; 
  if FormMain.PopupMenuNewly.Items.Count<=0 then exit;
  //FormMain.PopupMenuNewly.Items.Delete(FormMain.PopupMenuNewly.Items.Count-1);
  Str := InputBox('删除最近浏览 提示：','请输入要删除的最近浏览的序列编号.','');
  if (Trim(Str) = '') then exit;
  if (Trim(Str) = '-1') or (Trim(Str) = '999') then
  begin
    FormMain.PopupMenuNewly.Items.Delete(FormMain.PopupMenuNewly.Items.Count-1);
    exit;
  end;
  FormMain.PopupMenuNewly.Items.Delete(StrToInt(Str));
except end;
end;

procedure TFormMain.ActionCloseCurrentNoNewlyExecute(Sender: TObject);
begin
try
  NoSaveNewly := true;
  FormPublic.NCloseCurrent.OnClick(Sender);
except end;
end;

procedure TFormMain.PaintPanelControlPaint(Sender: TObject);
begin
try
  PaintPanelControl.Canvas.CopyRect(PaintPanelControl.ClientRect, ImageMenuBase.Picture.Bitmap.Canvas, ImageMenuBase.ClientRect);
except end;
end;

procedure TFormMain.PaintPanelMenuPaint(Sender: TObject);
begin
try
  PaintPanelMenu.Canvas.CopyRect(PaintPanelMenu.ClientRect, ImageMenuBase.Picture.Bitmap.Canvas, ImageMenuBase.ClientRect);
except end;
end;

procedure TFormMain.FormPaint(Sender: TObject);
begin
try
except end;
end;

procedure TFormMain.ToolBarControlCustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
var
  R: TRect;
begin
try
  Sender.Canvas.CopyRect(ARect, ImageMenuBase.Picture.Bitmap.Canvas, ImageMenuBase.ClientRect);
  exit;
  R := Image2.ClientRect;
  OffsetRect(R, Sender.Width - Image2.Width, 0);
  Sender.Canvas.CopyRect(R, Image2.Picture.Bitmap.Canvas, Image2.ClientRect);
except end;
end;

procedure TFormMain.ToolBarControlCustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  Index: Integer;
begin
try
  DefaultDraw := False;
  Index := Button.Index;
  if cdsHot in State then Inc(Index, 3);
  //if cdsSelected in State then Inc(Index, 3);
  ImageList1.Draw(ToolBarControl.Canvas, Button.Left + 1, Button.Top + 1, Index, True);
except end;
end;

procedure TFormMain.ToolBarStatusBarPaint(Sender: TObject);
begin
try
  ToolBarStatusBar.Canvas.CopyRect(ToolBarStatusBar.ClientRect, ImageMenuBase.Picture.Bitmap.Canvas, ImageMenuBase.ClientRect);
except end;
end;

procedure TFormMain.ToolButtonCloseClick(Sender: TObject);
begin
try
  Close;
except end;
end;

procedure TFormMain.ToolButtonWindowStateClick(Sender: TObject);
begin
try
  WindowStateOK := false;
  if WindowState = wsNormal then
  begin
    WindowStateII := 2;

    ImageList1.Replace(1, FormMain.ImageC211.Picture.BitMap, nil);
    ImageList1.Replace(4, FormMain.ImageC212.Picture.BitMap, nil);

    WindowState := wsMaximized;
    //FormMain.Top := -2;     //kkk
    //FormMain.Height := FormMain.Height - 8;
    //FormMain.Height := StrToInt(GetScreenWH('H')) - 30;
    WritePrivateProfileString('RunData','WindowMax','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    WindowStateII := 1;

    ImageList1.Replace(1, FormMain.ImageC221.Picture.BitMap, nil);
    ImageList1.Replace(4, FormMain.ImageC222.Picture.BitMap, nil);

    WindowState := wsNormal;

    {
    FormMain.Top := MainFormTop;
    FormMain.Height := MainFormHeight;
    FormMain.Left := MainFormLeft;
    FormMain.Width := MainFormWidth;
    }
    WritePrivateProfileString('RunData','WindowMax','0',PChar(MyDir+ConfigFile));
  end;
  WindowStateOK := true;
  //FormPublic.TabAutoWidthControl;
  //FormMain.OnResize(Sender);
  //TabWidth := HopeTabWidth div 2;
  //TimerTabWidth.Enabled := true;
  PanelWBMain.SetFocus;
  FormPublic.DocumentSetFocus;
except end;
end;

procedure TFormMain.ToolButtonMinimizeClick(Sender: TObject);
begin
try
  Application.Minimize;
except end;
end;

procedure TFormMain.ToolBarMenuDblClick(Sender: TObject);
begin
try
  ToolButtonWindowState.OnClick(Sender);
except end;
end;

procedure TFormMain.ToolBarMenuMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  P: tPoint;
begin
try
  if Button = mbRight then
  begin
    if ShowMenu then exit;
    GetCursorPos(P);
    {PM_ShowMenu}MainMenu1.Popup(P.X,P.Y);
  end;
  if WindowState = wsMaximized then exit;
  if Button = mbLeft then
  begin
    ReleaseCapture;
    PerForm(WM_SYSCOMMAND, $f012, 0);
  end;
except end;
end;

procedure TFormMain.ToolBarAddressMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
try
  if WindowState = wsMaximized then exit;
  if Button = mbLeft then
  begin
    ReleaseCapture;
    PerForm(WM_SYSCOMMAND, $f012, 0);
  end;
except end;
end;

procedure TFormMain.TBTabNewClick(Sender: TObject);
begin
try
  ToolButtonTabNew.OnClick(Sender);
except end;
end;

procedure TFormMain.Panel_StatusBar3Click(Sender: TObject);
begin
try
  SetForm.Show;
  SetForm.PageControl1.ActivePageIndex := 1;
except end;
end;

procedure TFormMain.TBTabNewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
try
  if Button = mbRight then FormMain.ToolButtonTabList.OnClick(Sender);
except end;
end;

procedure TFormMain.ToolBarButtonCustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  Index: Integer;
begin
try
  DefaultDraw := False;
  Index := Button.Index;
  if cdsHot in State then Inc(Index, 6);
  if cdsSelected in State then Inc(Index, 6);
  case bfState of
  0: ImageListB01.Draw(ToolBarButton.Canvas, Button.Left + 1, Button.Top + 1 + 3, Index, True);
  1: ImageListB01.Draw(ToolBarButton.Canvas, Button.Left + 1, Button.Top + 1 + 3, Index, True);
  2: ImageListB02.Draw(ToolBarButton.Canvas, Button.Left + 1, Button.Top + 1 + 3, Index, True);
  3: ImageListB03.Draw(ToolBarButton.Canvas, Button.Left + 1, Button.Top + 1 + 3, Index, True);
  4: ImageListB04.Draw(ToolBarButton.Canvas, Button.Left + 1, Button.Top + 1 + 3, Index, True);
  end;
except end;
end;

procedure TFormMain.TBRefreshMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
try
  if Button = mbRight then AllRefresh(Sender);
except end;
end;

procedure TFormMain.NShowMenu2Click(Sender: TObject);
begin
try
  AutoMenuShow := false;
  FormPublic.NShowMenu.Checked := not FormPublic.NShowMenu.Checked;
  FormPublic.NNShowMenu.OnClick(Sender);
except end;
end;

procedure TFormMain.ToolBarLeftTopControlCustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  Index: Integer;

  SrcR, DestR: TRect;
  Bitmap: TBitmap;
  //R: TRect;
  //L: Integer;
  //Flags: Longint;
begin  
try    //exit;
  DefaultDraw := False;
  Index := Button.ImageIndex;
  {
  if cdsHot in State then Inc(Index, 2);
  if cdsSelected in State then Inc(Index, 2);
  }
  if {Button.Down}cdsSelected in State then Bitmap := ImageMenuMouseDown.Picture.Bitmap else
    if cdsHot in State then Bitmap := {ImageTitleMenuMouseMove}ImageMenuMouseDown.Picture.Bitmap else Bitmap := nil;
      //if cdsSelected in State then Bitmap := {ImageTitleMenuMouseMove}ImageButtonHot.Picture.Bitmap else Bitmap := nil;

  if Assigned(Bitmap) then
  begin
    SrcR := Rect(0, 0, 5, ImageMenuMouseDown.Height);
    DestR := SrcR;
    Inc(DestR.Bottom, 2);
    OffsetRect(DestR, Button.Left, 2);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
    OffsetRect(SrcR, ImageMenuMouseDown.Width - 5, 0);
    OffsetRect(DestR, Button.Width - 5, 0);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
    OffsetRect(SrcR, -3, 0);
    DestR.Left := Button.Left + 5;
    Dec(DestR.Right, 5);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
  end;
  
  if SideStatShape then
  ImageList31.Draw(Sender.Canvas, Button.Left + 2, Button.Top + 4, Index)
  else
  ImageList32.Draw(Sender.Canvas, Button.Left + 2, Button.Top + 4, Index);
except end;
end;

procedure TFormMain.WB1_ScriptError(Sender: TObject; ErrorLine,
  ErrorCharacter, ErrorCode, ErrorMessage, ErrorUrl: String;
  var ContinueScript, Showdialog: Boolean);
begin
try
  ContinueScript:=true;
  Showdialog:=false;
except end;
end;

procedure TFormMain.WB1_2NewWindow2(Sender: TObject; var ppDisp: IDispatch;
  var Cancel: WordBool);
begin
try
  ppDisp := nil;
  Cancel := true;
except end;
end;

procedure TFormMain.wb_ClickScriptError(Sender: TObject; ErrorLine,
  ErrorCharacter, ErrorCode, ErrorMessage, ErrorUrl: String;
  var ContinueScript, Showdialog: Boolean);
begin
try
  ContinueScript:=true;
  Showdialog:=false;
except end;
end;

procedure TFormMain.ToolBarMenu2CustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
try
  Sender.Canvas.CopyRect(ARect, ImageMenuBase.Picture.Bitmap.Canvas, ImageMenuBase.ClientRect);
except end;
end;

procedure TFormMain.ToolBarMenu2CustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  SrcR, DestR: TRect;
  Bitmap: TBitmap;
  R: TRect;
begin
try
  if cdsHot in State then Bitmap := ImageMenuMouseDown.Picture.Bitmap else
    if cdsSelected in State then Bitmap := ImageMenuMouseDown.Picture.Bitmap else Exit;
  DefaultDraw := False;  
  SrcR := Rect(0, 0, 5, ImageMenuMouseDown.Height);
  DestR := SrcR;
  OffsetRect(DestR, Button.Left, 2);
  Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
  OffsetRect(SrcR, ImageMenuMouseDown.Width - 5, 0);
  OffsetRect(DestR, Button.Width - 5, 0);
  Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
  OffsetRect(SrcR, -3, 0);
  DestR.Left := Button.Left + 5;
  Dec(DestR.Right, 5);
  Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
  R := Button.BoundsRect;
  Inc(R.Top, 2);
  SetBkMode(Sender.Canvas.Handle, TRANSPARENT);

  DrawText(Sender.Canvas.Handle, PChar(Button.Caption), -1, R, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
except end;
end;

procedure TFormMain.PaintPanelMenu2Paint(Sender: TObject);
begin
try
  PaintPanelMenu2.Canvas.CopyRect(PaintPanelMenu2.ClientRect, ImageMenuBase.Picture.Bitmap.Canvas, ImageMenuBase.ClientRect);
except end;
end;

procedure TFormMain.PaintPanelBlankPaint(Sender: TObject);
begin
try
  PaintPanelBlank.Canvas.CopyRect(PaintPanelBlank.ClientRect, ImageMenuBase.Picture.Bitmap.Canvas, ImageMenuBase.ClientRect);
except end;
end;

initialization
begin
  try
  OleInitialize(nil);
  except end;
  end;

finalization
  begin
  try
  OleUninitialize;
  {$IFDEF ATSAMEON}
  if Hnd<>0 then CloseHandle(Hnd);
  {$ENDIF}
  {
  //wbList.free;
  //probar.free;
  //LabelPro.free;
  //WhiteList.Free;
  }
  except end;
  end;

end.
