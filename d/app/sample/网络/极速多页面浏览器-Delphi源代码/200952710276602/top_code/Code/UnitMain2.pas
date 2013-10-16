unit UnitMain;
                                   
interface

{$DEFINE ATSAMEON}
//{$DEFINE InstallOn}
                    
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ExtCtrls, StdCtrls, ComCtrls, ToolWin, PaintPanel,
  Menus, OleCtrls, IniFiles, SHDocVw, EmbeddedWB, FavoritesTreeEx, AppEvnts,
  MSHTML, ActiveX, Registry,
  ShlObj,  ShellApi,
  ComObj,  WinInet, //add
  Buttons, DdeMan, ActnList, WMPLib_TLB, MPlayer, XPMan;

{$IFDEF ATSAMEON}
const
  APPNAME = '0*****0';
  APPTAG = 88888;
  CloseMsg = '0*MSGOFCLOSE*0';
  WM_OPENPAGE = WM_USER + 1;
  WM_FOUNDHE = WM_USER + 2;
{$ENDIF}

type
  TFormMain = class(TForm, IDropTarget)
    Panel1: TPanel;
    PaintPanel4: TPaintPanel;
    Imagebg: TImage;
    ImageGo2: TImage;
    ImageGo3: TImage;
    PanelWBMain: TPanel;
    WBInitPage: TEmbeddedWB;
    PaintPanelMTop: TPaintPanel;
    ToolBarTabParent: TToolBar;
    ToolBarTabNew: TToolBar;
    ToolButtonTabNew: TToolButton;
    ToolBarTabControl: TToolBar;
    ToolButtonTabList: TToolButton;
    ToolButtonTabClose: TToolButton;
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
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    FavoritesTree1: TFavoritesTreeEx;
    PaintPanelFavorite: TPaintPanel;
    ToolBarFavorite: TToolBar;
    TBarFavoriteList: TToolBar;
    TBFavoriteList: TToolButton;
    PopupMenuNewly: TPopupMenu;
    ApplicationEvents1: TApplicationEvents;
    Splitter1: TSplitter;
    ImageTabYes: TImage;
    ImageTabNo: TImage;
    WB1_: TEmbeddedWB;
    PopupMenuTabList: TPopupMenu;
    N1: TMenuItem;
    ToolBarStatusBar: TToolBar;
    ToolButton3: TToolButton;
    ToolButtonAutoHint: TToolButton;
    ToolButton18: TToolButton;
    ToolButtonFlash: TToolButton;
    ToolButton100: TToolButton;
    StatusBar2: TStatusBar;
    ImageListRightSmall: TImageList;
    ToolButtonFavorites: TToolButton;
    ToolButtonAddFavorites: TToolButton;
    ImageListF: TImageList;
    ImageButton: TImage;
    ImageButtonHot: TImage;
    ImageList3: TImageList;
    ImageList31: TImageList;
    ImageList32: TImageList;
    ImageList5: TImageList;
    ImageListTabLeft: TImageList;
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
    ActionTest1: TAction;
    ActionTest2: TAction;
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
    ListBoxMusicList: TListBox;
    OpenDialog2: TOpenDialog;
    TimerPlayer: TTimer;
    LPM: TPopupMenu;
    NOpenMusicFile: TMenuItem;
    NOpenDirectory: TMenuItem;
    MenuItem1: TMenuItem;
    NOnlineTV: TMenuItem;
    Ncctv1: TMenuItem;
    Ncctv2: TMenuItem;
    CCTV31: TMenuItem;
    CCTV41: TMenuItem;
    Ncctv5: TMenuItem;
    CCTV61: TMenuItem;
    CCTV91: TMenuItem;
    CCTV1: TMenuItem;
    Nygws: TMenuItem;
    Nxkws: TMenuItem;
    N18: TMenuItem;
    Ndfws: TMenuItem;
    Nmydy: TMenuItem;
    Nhnws: TMenuItem;
    sh1: TMenuItem;
    N19: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    MenuItem2: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    Nfhwszwt: TMenuItem;
    N20: TMenuItem;
    MenuItem3: TMenuItem;
    Nsepd: TMenuItem;
    Nfhws_bj: TMenuItem;
    Nfhzx_bj: TMenuItem;
    N5: TMenuItem;
    NLoadList: TMenuItem;
    NSaveList: TMenuItem;
    NListSaveAs: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    TimerSide: TTimer;
    NMop: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    QQ1: TMenuItem;
    N32: TMenuItem;
    N451: TMenuItem;
    N33: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    N37: TMenuItem;
    BFMTV1: TMenuItem;
    Discovery1: TMenuItem;
    N38: TMenuItem;
    BC1: TMenuItem;
    LFX1: TMenuItem;
    ELEM1: TMenuItem;
    N39: TMenuItem;
    N40: TMenuItem;
    N41: TMenuItem;
    ImageListCloseImg: TImageList;
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
    StatusBar: TStatusBar;
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
    ImageSearch1: TImage;
    ImageSearchDrop1: TImage;
    ImageSearch2: TImage;
    ImageSearchDrop2: TImage;
    ImageSearch3: TImage;
    ImageSearchDrop3: TImage;
    ToolBarMenu: TToolBar;
    ImageGo1: TImage;
    PopupMenuTools: TPopupMenu;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    PMCommandLine: TMenuItem;
    N44: TMenuItem;
    PopupMenuNewPage: TPopupMenu;
    NAddNewBlank2: TMenuItem;
    NAddNewHomePage2: TMenuItem;
    NCopyCurrentPage: TMenuItem;
    PopupMenuRefreshAll: TPopupMenu;
    NRefreshAll: TMenuItem;
    PopupMenuCloseAll: TPopupMenu;
    NPopupCloseAll: TMenuItem;
    Imagenew1: TImage;
    Imagenew2: TImage;
    Imagenew3: TImage;
    ImageGoBack2: TImage;
    ImageGoForward2: TImage;
    Imagestop1: TImage;
    Imagestop2: TImage;
    Imagestop3: TImage;
    ImageRefresh1: TImage;
    ImageRefresh2: TImage;
    ImageRefresh3: TImage;
    ImageHome1: TImage;
    ImageHome2: TImage;
    ImageHome3: TImage;
    ImageGoBack0: TImage;
    ImageGoForward0: TImage;
    ImageGoBack1: TImage;
    ImageGoForward1: TImage;
    ImageGoBack3: TImage;
    ImageGoForward3: TImage;
    PaintPanelButton: TPaintPanel;
    Imagenew: TImage;
    ImageGoBack: TImage;
    ImageGoForward: TImage;
    ImageStop: TImage;
    ImageRefresh: TImage;
    ImageHome: TImage;
    ImageNewly1: TImage;
    ImageNewly2: TImage;
    ImageNewly3: TImage;
    ImageNewly: TImage;
    Imagebg2: TImage;
    BPF1: TSpeedButton;
    BPF2: TSpeedButton;
    ImageTabYes1: TImage;
    ImageTabNo1: TImage;
    ImageTabYes4: TImage;
    ImageTabNo4: TImage;
    Imagebg0: TImage;
    ImageTabYes0: TImage;
    ImageTabNo0: TImage;
    ImageTabNo2: TImage;
    ImageTabYes2: TImage;
    ImageListCloseImg2: TImageList;
    ImageListB0: TImageList;
    ImageListB0D: TImageList;
    ImageWebIconT: TImage;
    ActionTabLock: TAction;
    ActionTabUnLock: TAction;
    TBAllMode: TToolButton;
    ToolButton4: TToolButton;
    ActionAllModeY: TAction;
    ActionAllModeN: TAction;
    N11: TMenuItem;
    NOrderPlay: TMenuItem;
    NRandomPlay: TMenuItem;
    ImagebgWhite: TImage;
    TimerIPV: TTimer;
    PaintPanelButtonAddress: TPaintPanel;
    CoolBar1: TCoolBar;
    ToolBarButton: TToolBar;
    TBAddNew: TToolButton;
    ToolButton1: TToolButton;
    TBGoBack: TToolButton;
    TBGoForward: TToolButton;
    TBStop: TToolButton;
    TBRefresh: TToolButton;
    TBGoHome: TToolButton;
    TBFavorite: TToolButton;
    ToolButton6: TToolButton;
    TBClose: TToolButton;
    TBNewly: TToolButton;
    TBOption: TToolButton;
    TBTools: TToolButton;
    ToolButton7: TToolButton;
    PaintPanelButtonAddress2: TPaintPanel;
    BBGO: TSpeedButton;
    ImageGo: TImage;
    CBURL: TComboBoxEx;
    PaintPanelSearch: TPaintPanel;
    ImageSearch: TImage;
    ImageSearchDrop: TImage;
    LabelSearchName: TLabel;
    ComboBoxSearch: TComboBoxEx;
    ButtonSearch: TButton;
    Label1: TLabel;
    procedure ToolBarGoBackForwardCustomDraw(Sender: TToolBar;
      const ARect: TRect; var DefaultDraw: Boolean);
    procedure PaintPanelSearchPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    //procedure ToolBarTabParentMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure TimerDocRollTimer(Sender: TObject);
    procedure ApplicationEvents1Activate(Sender: TObject);
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
    procedure ImageGoBackClick(Sender: TObject);
    procedure ImageGoForwardClick(Sender: TObject);
    procedure CBURLClick(Sender: TObject);
    procedure CBURLKeyDown(Sender: TObject; var Key: Word;
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
    procedure ToolButton22Click(Sender: TObject);
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
    procedure ToolBarStatusBarCustomDrawButton(Sender: TToolBar;
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
    procedure Ncctv1Click(Sender: TObject);
    procedure Ncctv2Click(Sender: TObject);
    procedure CCTV31Click(Sender: TObject);
    procedure CCTV41Click(Sender: TObject);
    procedure Ncctv5Click(Sender: TObject);
    procedure CCTV61Click(Sender: TObject);
    procedure CCTV91Click(Sender: TObject);
    procedure CCTV1Click(Sender: TObject);
    procedure NygwsClick(Sender: TObject);
    procedure NxkwsClick(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure NdfwsClick(Sender: TObject);
    procedure NmydyClick(Sender: TObject);
    procedure NhnwsClick(Sender: TObject);
    procedure sh1Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure NfhwszwtClick(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure NsepdClick(Sender: TObject);
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
    procedure ActionTest2Execute(Sender: TObject);
    procedure NMopClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure N25Click(Sender: TObject);
    procedure N26Click(Sender: TObject);
    procedure N27Click(Sender: TObject);
    procedure N28Click(Sender: TObject);
    procedure N29Click(Sender: TObject);
    procedure N30Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure QQ1Click(Sender: TObject);
    procedure N32Click(Sender: TObject);
    procedure N451Click(Sender: TObject);
    procedure N33Click(Sender: TObject);
    procedure N34Click(Sender: TObject);
    procedure N35Click(Sender: TObject);
    procedure N36Click(Sender: TObject);
    procedure N37Click(Sender: TObject);
    procedure BFMTV1Click(Sender: TObject);
    procedure Discovery1Click(Sender: TObject);
    procedure N38Click(Sender: TObject);
    procedure BC1Click(Sender: TObject);
    procedure LFX1Click(Sender: TObject);
    procedure ELEM1Click(Sender: TObject);
    procedure N39Click(Sender: TObject);
    procedure N40Click(Sender: TObject);
    procedure N41Click(Sender: TObject);
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
    procedure ImageSearchMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageSearchDropMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure ImageSearchMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageSearchMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageSearchDropMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageSearchDropMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure LabelSearchNameMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure LabelSearchNameMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure LabelSearchNameMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageSearchDropClick(Sender: TObject);
    procedure ImageSearchClick(Sender: TObject);
    procedure LabelSearchNameClick(Sender: TObject);
    procedure ToolBarMenuCustomDraw(Sender: TToolBar; const ARect: TRect;
      var DefaultDraw: Boolean);
    procedure ToolBarButtonCustomDraw(Sender: TToolBar; const ARect: TRect;
      var DefaultDraw: Boolean);
    procedure TBGoHomeClick(Sender: TObject);
    procedure TBGoForwardClick(Sender: TObject);
    procedure TBGoBackClick(Sender: TObject);
    procedure BBGOClick(Sender: TObject);
    procedure TBRefreshClick(Sender: TObject);
    procedure TBStopClick(Sender: TObject);
    procedure TBFavoriteClick(Sender: TObject);
    procedure TBNewlyClick(Sender: TObject);
    procedure TBCloseClick(Sender: TObject);
    procedure TBOptionClick(Sender: TObject);
    procedure TBToolsClick(Sender: TObject);
    procedure PaintPanelButtonAddressPaint(Sender: TObject);
    procedure ToolBarAddressCustomDraw(Sender: TToolBar;
      const ARect: TRect; var DefaultDraw: Boolean);
    procedure TBAddNewClick(Sender: TObject);
    procedure ImageGoClick(Sender: TObject);
    procedure ImageGoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageGoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageGoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintPanelButtonAddressMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure NAddNewBlank2Click(Sender: TObject);
    procedure NAddNewHomePage2Click(Sender: TObject);
    procedure NCopyCurrentPageClick(Sender: TObject);
    procedure NPopupCloseAllClick(Sender: TObject);
    procedure NRefreshAllClick(Sender: TObject);
    procedure PaintPanelButtonPaint(Sender: TObject);
    procedure ImagenewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImagenewMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImagenewMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageStopMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageRefreshMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageHomeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageStopMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageStopMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageRefreshMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageHomeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);           
    procedure ImageRefreshMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageHomeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    //procedure PaintPanelButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ImageGoBackMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageGoForwardMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImageGoBackMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageGoForwardMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure ImageGoBackMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageGoForwardMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImagenewClick(Sender: TObject);
    procedure ImageRefreshClick(Sender: TObject);
    procedure ImageHomeClick(Sender: TObject);
    procedure ToolButtonAutoHintClick(Sender: TObject);
    procedure ActionTabLockExecute(Sender: TObject);
    procedure ActionTabUnLockExecute(Sender: TObject);
    procedure ComboBoxSearchChange(Sender: TObject);
    procedure ComboBoxSearchClick(Sender: TObject);
    procedure ComboBoxSearchKeyPress(Sender: TObject; var Key: Char);
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
    procedure TimerIPVTimer(Sender: TObject);
    procedure PaintPanelButtonAddress2Paint(Sender: TObject);
    procedure ToolBar1CustomDraw(Sender: TToolBar; const ARect: TRect;
      var DefaultDraw: Boolean);
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
    procedure AddHotKey;  //向系统中注册全局热键
    procedure HotKey(var Msg:TMessage); Message WM_HOTKEY; //截取系统中热键信息
    //procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
    procedure WMQueryEndSession({var Message: TMessage}var Msg: TWMQUERYENDSESSION); message WM_QUERYENDSESSION;
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
    procedure ImageButtonInit;
    procedure ButtonMouseDown(Sender: TObject);
    procedure ButtonMouseMove(Sender: TObject);
    procedure ButtonMouseUp(Sender: TObject);
    procedure PlayMusic(MusicName:string);
    procedure PlayRandom;
    procedure PlayUp;
    procedure PlayDown;
    procedure PlayError;
    procedure SetBrowser(flag:integer=0); //设置某个浏览器为默认浏览器
    //procedure dragdropfile(var msg :  tmessage);message wm_dropfiles;
    function EnabledOpenExt(FileName: String): Boolean;
  public
    { Public declarations }
    //procedure InterfaceRepaint;
    procedure NavigateInit;
    procedure NavigateInit2;
    procedure LoadMusicList(Path:string);
    //procedure DrawButtonIcon;
    procedure AllClose(Sender: TObject);
    procedure AllRefresh(Sender: TObject);
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

uses var_, const_, UnitPublic, UnitSet, Public, UnitWebBrowser, KillAd,
  UnitLoadLastTime, GetPathUnit, UnitWmp, UnitHintShow, UnitAutoHint,
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
                        
procedure TFormMain.NavigateInit;
var
  Res:TReSourceStream;
  MemStream:TMemoryStream;
  //FileStream:TFileStream;
begin
try
  if not EnabledInitPage then exit;
  case StartPageTo of
    2, 99: if (Trim(InitUrl) <> '') or (Trim(OpenToUrl) <> '') then exit;
  end;

  if InitUrl <> '' then
  begin
  TFormWebBrowser(wbList[0]).WebUrl := InitUrl;
  TFormWebBrowser(wbList[0]).WebBrowser.Hint := InitUrl;
  TFormWebBrowser(wbList[0]).WebBrowser.Navigate(InitUrl);
  end
  else
  begin
  //{
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
  //}
  end;
except end;
end;

procedure TFormMain.NavigateInit2;
var
  Res:TReSourceStream;
  MemStream:TMemoryStream;
begin
try
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
  if OpenToUrl = '' then OpenToUrl := InitUrl;
  //PageIndex := wbList.Count - 1;
  LastTimeURLList:=TStringList.Create;
  try
  LastTimeURLList.LoadFromFile(MyDir+OpenURLListFile2);  //MessageBox(0, InitUrl, PChar(LastTimeURLList[0]), 0);
  if LastTimeURLList.Count >= 1 then
  begin
    if LastTimeURLList.Count = 1 then
    begin              
      if (Pos('/' + DataDir + '/' + LastOpenLoadFile, LastTimeURLList[0]) <> 0) or (Pos(OpenToUrl, LastTimeURLList[0]) <> 0) or (Pos(InitUrl, LastTimeURLList[0]) <> 0) then
      begin
        exit;
      end;
    end;

    if (StartPageTo = 1) and (EnabledInitPage){((TFormWebBrowser(wbList[0]).WebBrowser.LocationUrl <> '') and (TFormWebBrowser(wbList[0]).WebBrowser.LocationUrl <> 'about:blank'))} then
    ToolButtonTabNew.Click;
    if (StartPageTo = 2) then
    ToolButtonTabNew.Click;

    LoadLastOpenI := PageIndex;
    TFormWebBrowser(wbList[PageIndex]).WebBrowser.Navigate({ExtractFilePath(Paramstr(0))}MyDir + DataDir + '\' + LastOpenLoadFile);
    //TFormWebBrowser(wbList[PageIndex]).WebBrowser.Navigate('http://www.aisoho.com/test/lastunclose.htm');
    TFormWebBrowser(wbList[PageIndex]).WebUrl := BrowserName + '://Data/' + LastOpenLoadFile;
    CBUrl.Text := BrowserName + '://Data/' + LastOpenLoadFile;
  end;
  finally
    LastTimeURLList.Free;
  end;
except end;
end;

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
            FormPublic.NewPage(PageIndex + 1, Url, True)
            else if pt.X > P.X + 10 then //右
            FormPublic.NewPage(PageIndex + 1, Url, false)
            else
            FormPublic.NewPage(PageIndex + 1, Url, false);
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
      if (TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationURL <> '') and (TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationURL <> 'about:blank') then
      //ToolButtonTabNew.Click;
      FormPublic.NewPage(PageIndex + 1, FFileName, true)
      else TFormWebBrowser(wbList[PageIndex]).WebBrowser.Navigate(FFileName);
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

//{
procedure TFormMain.AddHotKey;
var
  id1,id2:integer;
begin
try
  try
  id1:=GlobalAddAtom('hotkey1');
  RegisterHotKey(Self.Handle,id1,MOD_Control,89);    //y 窗体显示/隐藏
  id2:=GlobalAddAtom('hotkey2');
  RegisterHotKey(Self.Handle,id2,MOD_Control,75);    //K 快速退出-不保存
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
  if ((Msg.LParamLo=MOD_CONTROL) and (Msg.LParamHi=89)) then
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

procedure TFormMain.WMQueryEndSession({var Message: TMessage}var Msg: TWMQUERYENDSESSION);
begin
try
  //msg.Result:=0;
  //ShowMessage('ok');
  msg.Result := Integer(TRUE);  
  FormMain.Close;
  inherited;
except end;
end;

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

procedure TFormMain.ImageButtonInit;
var
  i: integer;
begin
try
  SetLength(FImageButton, 8);
  FImageButton[0] := Imagenew;
  FImageButton[1] := Imagenew;
  FImageButton[2] := ImageGoBack;
  FImageButton[3] := ImageGoForward;
  FImageButton[4] := ImageStop;
  FImageButton[5] := ImageRefresh;
  FImageButton[6] := ImageHome;
  FImageButton[7] := ImageNewly;

  SetLength(FImageButton1, 8);
  FImageButton1[0] := Imagenew1;
  FImageButton1[1] := Imagenew1;
  FImageButton1[2] := ImageGoBack1;
  FImageButton1[3] := ImageGoForward1;
  FImageButton1[4] := ImageStop1;
  FImageButton1[5] := ImageRefresh1;
  FImageButton1[6] := ImageHome1;
  FImageButton1[7] := ImageNewly1;

  SetLength(FImageButton2, 8);
  FImageButton2[0] := Imagenew2;
  FImageButton2[1] := Imagenew2;
  FImageButton2[2] := ImageGoBack2;
  FImageButton2[3] := ImageGoForward2;
  FImageButton2[4] := ImageStop2;
  FImageButton2[5] := ImageRefresh2;
  FImageButton2[6] := ImageHome2;
  FImageButton2[7] := ImageNewly2;

  SetLength(FImageButton3, 8);
  FImageButton3[0] := Imagenew3;
  FImageButton3[1] := Imagenew3;
  FImageButton3[2] := ImageGoBack3;
  FImageButton3[3] := ImageGoForward3;
  FImageButton3[4] := ImageStop3;
  FImageButton3[5] := ImageRefresh3;
  FImageButton3[6] := ImageHome3;
  FImageButton3[7] := ImageNewly3;
except end;
end;

procedure TFormMain.ButtonMouseDown(Sender: TObject);
begin
try
  case (Sender as TImage).Tag of
    2:
    begin
      if BackEnabled then
      else
      exit;
    end;
    3:
    begin
      if ForwardEnabled then
      else
      exit;
    end;
  end;
  (Sender as TImage).Picture := FImageButton3[(Sender as TImage).Tag].Picture;
except end;
end;

procedure TFormMain.ButtonMouseMove(Sender: TObject);
begin
try
  if (ButtonMoveO <> (Sender as TImage).Tag) and (ButtonMoveO <> 0) then
  begin
    if (ButtonMoveO <> 2) and (ButtonMoveO <> 3) then
    FImageButton[ButtonMoveO].Picture := FImageButton1[ButtonMoveO].Picture
    else
    begin
      //ButtonMoveO := (Sender as TImage).Tag;
      case ButtonMoveO of
        2:
        begin
          if BackEnabled then FormMain.ImageGoBack.Picture := FormMain.ImageGoBack1.Picture
          else FormMain.ImageGoBack.Picture := FormMain.ImageGoBack0.Picture;
        end;
        3:
        begin
          if ForwardEnabled then FormMain.ImageGoForward.Picture := FormMain.ImageGoForward1.Picture
          else FormMain.ImageGoForward.Picture := FormMain.ImageGoForward0.Picture;
        end;
      end;
    end;
  end;

  ButtonMoveO := (Sender as TImage).Tag;
  case ButtonMoveO of
    2:
    begin
      if BackEnabled then
        FormMain.ImageGoBack.Picture := FormMain.ImageGoBack2.Picture
      else
        FormMain.ImageGoBack.Picture := FormMain.ImageGoBack0.Picture;
    end;
    3:
    begin
      if ForwardEnabled then
        FormMain.ImageGoForward.Picture := FormMain.ImageGoForward2.Picture
      else
        FormMain.ImageGoForward.Picture := FormMain.ImageGoForward0.Picture;
    end;
    else (Sender as TImage).Picture := FImageButton2[(Sender as TImage).Tag].Picture;
  end;
  //ButtonMoveO := (Sender as TImage).Tag;
  //(Sender as TImage).Picture := FImageButton2[(Sender as TImage).Tag].Picture;
except end;
end;

procedure TFormMain.ButtonMouseUp(Sender: TObject);
begin
try
  case (Sender as TImage).Tag of
    2:
    begin
      if BackEnabled then
      else
      exit;
    end;
    3:
    begin
      if ForwardEnabled then
      else
      exit;
    end;
  end;
  (Sender as TImage).Picture := FImageButton1[(Sender as TImage).Tag].Picture;
except end;
end;

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

procedure TFormMain.PaintPanelSearchPaint(Sender: TObject);
begin
try
  case ButtonStyle of
  0: PaintPanelSearch.Canvas.CopyRect(PaintPanelSearch.ClientRect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
  1: PaintPanelSearch.Canvas.CopyRect(PaintPanelSearch.ClientRect, Imagebg2.Picture.Bitmap.Canvas, Imagebg2.ClientRect);
  end;
except end;
end;

procedure TFormMain.FormResize(Sender: TObject);
begin
try
  if CloseApp then exit;
  if AppToExit then exit;
  try
  //BBGO.Left := PaintPanelAddress.Left + PaintPanelAddress.Width - BBGO.Width - 2;
  //CBURL.Width := PaintPanelAddress.Width - BBGO.Width - 16;
  {
  case ButtonStyle of
    0:
    begin
      CBURL.Left := ToolBarButton.Left + ToolBarButton.Width + 6;
      //CBURL.Width := PaintPanelButtonAddress.Width - ToolBarButton.Width - PaintPanelSearch.Width - ImageGo.Width - 12;
      if not SearchShow then
      CBURL.Width := PaintPanelButtonAddress.Width - ToolBarButton.Width - ImageGo.Width - 16
      else
      CBURL.Width := PaintPanelButtonAddress.Width - ToolBarButton.Width - PaintPanelSearch.Width - ImageGo.Width - 12;
    end;
    1:
    begin
      CBURL.Left := PaintPanelButton.Left + PaintPanelButton.Width + 1;
      if not SearchShow then
      CBURL.Width := PaintPanelButtonAddress.Width - PaintPanelButton.Width - ImageGo.Width - 12
      else
      CBURL.Width := PaintPanelButtonAddress.Width - PaintPanelButton.Width - PaintPanelSearch.Width - ImageGo.Width - 10;
    end;
  end;
  ImageGo.Left := CBURL.Left + CBURL.Width + 4; //PaintPanelButtonAddress.Left + PaintPanelButtonAddress.Width - PaintPanelSearch.Width -ImageGo.Width - 2;
  }

  CBURL.Left := 6;
  CBURL.Width := PaintPanelButtonAddress2.Width - ComboBoxSearch.Width - ImageSearch.Width - ImageGo.Width - 32;
  ImageGo.Left := CBURL.Left + CBURL.Width + 4;

  StatusBar.Width :=  ToolBarStatusBar.Width - ToolButtonAutoHint.Width - FormMain.ToolButtonFlash.Width - TBAllMode.Width - ToolButton100.Width - 28;
  StatusBar.Left := ToolBarStatusBar.Left + 5;
  finally
    ImageSearchDrop.Repaint;
    ImageSearch.Repaint;
    ImageSearch.Refresh;
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
  Application.Title := TitleStr + '  ' + Version;         
  Self.Caption := TitleStr;
  //Application.ShowMainForm := false;      
  MyDir := ExtractFilePath(ParamStr(0));
  if MyDir[Length(MyDir)]<>'\' then MyDir := MyDir + '\';
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

procedure TFormMain.ApplicationEvents1Activate(Sender: TObject);
begin
try
  //BBGO.Repaint;
  //FormMain.BBGO.Refresh;
  ImageSearchDrop.Repaint;
  ImageSearch.Repaint;
except end;
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
  //SetForm.Timer1.Enabled:=false;
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
      if StopPopup then TFormWebBrowser(wbList[PageIndex]).IsPopup:=true;
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
    begin
      //dddddddddd
      ClickSleepTime:=LClickSleepTime;
      ThreadI:=97;
      RunProcess.Create(False);
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
  if Msg.message = WM_KEYDOWN then
  begin
    Message.Msg := Msg.message;       
    Message.WParam := Msg.wParam;
    Message.LParam := Msg.lParam;
    Handled := ActionList1.IsShortCut(TWMKey(Message));
  end;

  //****************************
  //Handled:=False;
  if Msg.message = WM_MOUSEWHEEL then
  begin
    if GetKeyState(VK_RBUTTON) < 0 then
    begin
      Handled := true;
      exit;
    end
    else
    begin
      Msg.hwnd := WindowFromPoint(Msg.pt);
      //{
      //if Msg.hwnd = TFormWebBrowser(wbList[PageIndex]).WebBrowser.hwnd then FormPublic.DocumentSetFocus;
      if IsChild(TFormWebBrowser(wbList[PageIndex]).WebBrowser.Handle, Msg.hwnd) then
      begin
        H := TFormWebBrowser(wbList[PageIndex]).WebBrowser.Handle;
        //if not IsChild(h, GetFocus) then
        if Assigned(TFormWebBrowser(wbList[PageIndex]).WebBrowser.Document) then
        FormPublic.DocumentSetFocus;
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
    if wbList.Count = 0 then exit;
    if StopPopup=false then exit;
    TFormWebBrowser(wbList[PageIndex]).IsPopup:=false;
    //DocumentFocusEnable := true;
    finally
    ClickSleepTime:=LClickSleepTime;

    if LoadLastOpenFlag then
    if (Pos('/' + DataDir + '/' + LastOpenLoadFile, TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl) <> 0) then
    begin
      //LockWindowUpdate(FormMain.PanelWBMain.Handle); 
      StopPopup2 := StopPopup;
      ShowWebIcon2 := true;
      StopPopup := false;
      //ShowWebIcon := false;
    end;

    ThreadI:=97;
    RunProcess.Create(False);
    //Halt;
    //InterfaceRepaint;
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
        TFormWebBrowser(wbList[PageIndex]).IsPopup:=false;
        ClickSleepTime:=RClickSleepTime;
        ThreadI:=97;
        RunProcess.Create(False);
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
  //SetForm.Timer1.Enabled:=true;
  if MemoryThrift2 then
    FormPublic.NQuickClearMemory.OnClick(Sender);
  finally
  //ApplicationEvents1.Activate;
  ApplicationEvents1.OnActivate(Sender);
  //PanelWBMain.SetFoucus;
  FormPublic.DocumentSetFocus;
  end;
except end;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
try
  if AppToExit then exit;
  try    //exit;
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
  finally

    if not ShowRunOK then
    begin
      ShowRunOK := true;
      FormPublic.ShowRun(Sender);
      FormPublic.GetFavoritFolder;

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
      ImageButtonInit;
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
  Sender.Canvas.CopyRect(ARect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
except end;
end;

procedure TFormMain.ToolBarTabControlCustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
try
  //if wbList.Count <= 0 then exit;
  Sender.Canvas.CopyRect(ARect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect)
except end;
end;

procedure TFormMain.ToolBarTabNewCustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
try
  //if wbList.Count <= 0 then exit;
  Sender.Canvas.CopyRect(ARect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect)
except end;
end;

procedure TFormMain.ToolButtonTabNewClick(Sender: TObject);
begin
try
  //LockWindowUpdate(FormMain.PanelWBMain.Handle);
  CBUrl.Text := 'about:blank';
  StatusBar.Panels[0].Text := '';
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
  //LockWindowUpdate(0);
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
  try
  DefaultDraw := False;

  if (ShowCloseHint) {and (TabAt <>1)} and (not ShowCloseOK) and (Button.Index = PageIndex) then
  begin
    ShowCloseOK := true; //Self.Caption := IntToStr(Random(999999999));
    CloseHintCurC := false;
    if CloseHintCur <> PageIndex then
    begin
      ToolBarTabClose.Hide;
      CloseHintCur := PageIndex;
    end;
    R := FormMain.ToolBarTabParent.Buttons[PageIndex].BoundsRect;
    {
    FormMain.Image1.Top := FormMain.PanelWBMain.Top + 7;
    FormMain.Image1.Left := R.Right;
    }
    //if PaintBox1.Left = R.Right - PaintBox1.Width - 2 then exit;
    if TabAt = 0 then
    FormMain.ToolBarTabClose.Top := {ToolBarTabParent.Top}FormMain.PanelWBMain.Top + 7  //R.Top + 72;
    else
    if (TabAt = 1) and (PaintPanelMTop.Align = alBottom) then
    FormMain.ToolBarTabClose.Top := {ToolBarTabParent.Top}PaintPanelMTop.Top + 72;  //R.Top + 72;
    //{
    if FormMain.PanelLeft.Visible and not SideStatShape then
    FormMain.ToolBarTabClose.Left := R.Right - FormMain.ToolBarTabClose.Width + FormMain.PanelLeft.Width  + 66
    else
    FormMain.ToolBarTabClose.Left := R.Right - FormMain.ToolBarTabClose.Width + 66;
    //}
    //FormMain.ToolBarTabClose.Left := R.Right - FormMain.ToolBarTabClose.Width + 66;
    if (CloseHintCurC) or (not ToolBarTabClose.Visible) then FormMain.ToolBarTabClose.Visible := True;
    //dddddddddddddddddddddddddddd
  end;
  
  finally
  //{
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

procedure TFormMain.ImageGoBackClick(Sender: TObject);
begin
try
  if BackEnabled then
  begin
    TFormWebBrowser(wbList[PageIndex]).WebBrowser.GoBack;
    //if not BackEnabled then ImageGoBack.Picture := ImageGoBack0.Picture;
  end
  else ImageGoBack.Picture := ImageGoBack0.Picture;
except end;
end;

procedure TFormMain.ImageGoForwardClick(Sender: TObject);
begin
try
  if ForwardEnabled then
  begin
    TFormWebBrowser(wbList[PageIndex]).WebBrowser.GoForward;
    //if not ForwardEnabled then ImageGoForward.Picture := ImageGoForward0.Picture;
  end
  else ImageGoForward.Picture := ImageGoForward0.Picture;
except end;
end;

procedure TFormMain.CBURLClick(Sender: TObject);
begin
try
    FormMain.BBGO.OnClick(Sender);
except end;
end;

procedure TFormMain.CBURLKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
  DefaultDraw := False;
  Index := Button.ImageIndex;
  if cdsHot in State then Inc(Index, 2);
  if cdsSelected in State then Inc(Index, 2);
  ImageListRightSmall.Draw(Sender.Canvas, Button.Left + 2, Button.Top + 4, Index);
except end;
end;

procedure TFormMain.TabListClick(Sender: TObject);
var
  I: Integer;
begin
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
    CopyRect(ARect, ImageButton.Picture.Bitmap.Canvas, ImageButton.ClientRect);
    Pen.Color := TColor($808080);
    MoveTo(0, Sender.Height -1);
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
  if Button.Down then Bitmap := ImageButtonHot.Picture.Bitmap else
    if cdsHot in State then Bitmap := {ImageTitleMenuMouseMove}ImageButtonHot.Picture.Bitmap else Bitmap := nil;
      //if cdsSelected in State then Bitmap := {ImageTitleMenuMouseMove}ImageButtonHot.Picture.Bitmap else Bitmap := nil;

  if Assigned(Bitmap) then
  begin
    SrcR := Rect(0, 0, 5, ImageButtonHot.Height);
    DestR := SrcR;
    Inc(DestR.Bottom, 2);
    OffsetRect(DestR, Button.Left, 2);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
    OffsetRect(SrcR, ImageButtonHot.Width - 5, 0);
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
    CopyRect(ARect, ImageButton.Picture.Bitmap.Canvas, ImageButton.ClientRect);
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
  if Button.Down then Bitmap := ImageButtonHot.Picture.Bitmap else
    if cdsHot in State then Bitmap := {ImageTitleMenuMouseMove}ImageButtonHot.Picture.Bitmap else Bitmap := nil;
      //if cdsSelected in State then Bitmap := {ImageTitleMenuMouseMove}ImageButtonHot.Picture.Bitmap else Bitmap := nil;
    //}

  //{
  if Assigned(Bitmap) then
  begin
    SrcR := Rect(0, 0, 5, ImageButtonHot.Height);
    DestR := SrcR;
    Inc(DestR.Bottom, 2);
    OffsetRect(DestR, Button.Left, 2);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
    OffsetRect(SrcR, ImageButtonHot.Width - 5, 0);
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
    CopyRect(ARect, ImageButton.Picture.Bitmap.Canvas, ImageButton.ClientRect);
    Pen.Color := TColor($808080);
    MoveTo(0, Sender.Height -1);
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

procedure TFormMain.ToolButton22Click(Sender: TObject);
begin
try
  FormPublic.NAddFavorite.OnClick(Sender);
except end;
end;

procedure TFormMain.ToolButtonAddFavoritesClick(Sender: TObject);
begin
try
  FormPublic.NAddFavorite.OnClick(Sender);
except end;
end;

procedure TFormMain.ToolBarTabNewCustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  Index: Integer;
begin
try    //exit;
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
var
  Pt: TPoint;
begin
try
  if (Button=mbRight) then
  begin
  GetCursorPos(Pt);
  {
  Pt.x := ToolButtonTabList.Left + ToolButtonTabList.Width; // - PopupMenu1.Width;
  Pt.y := ToolButtonTabList.Height;  Pt := ToolButtonTabList.ClientToScreen(Pt);  //PopupMenu1.Popup(Pt.X, Pt.Y);
  }
  {
  if FormMain.Menu = FormPublic.MainMenu1 then
  FormPublic.NNShowMenu.Checked := true
  else
  FormPublic.NNShowMenu.Checked := false;
  }
  FormPublic.PopupMenuShowCote.Popup(Pt.X, Pt.Y);
  end;
except end;
end;

procedure TFormMain.ToolBarFavoriteCustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
try    //exit;
  if not PaintPanelFavorite.Visible then exit;
  with Sender.Canvas do
  begin
    CopyRect(ARect, ImageButton.Picture.Bitmap.Canvas, ImageButton.ClientRect);
    Pen.Color := TColor($808080);
    MoveTo(0, Sender.Height -1);
    //LineTo(Sender.Width, Sender.Height -1);
  end;
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
try   //exit;
  //{
  //if (not PaintPanelFavorite.Visible) {and ((Sender as TToolBar) <> ToolBarFavorite)} then exit;
  if not PaintPanelFavorite.Visible then exit;
  DefaultDraw := False;
  if Button.Down then Bitmap := ImageButtonHot.Picture.Bitmap else
    if cdsHot in State then Bitmap := {ImageTitleMenuMouseMove}ImageButtonHot.Picture.Bitmap else Bitmap := nil;
      //if cdsSelected in State then Bitmap := {ImageTitleMenuMouseMove}ImageButtonHot.Picture.Bitmap else Bitmap := nil;
    //}

  //{
  if Assigned(Bitmap) then
  begin
    SrcR := Rect(0, 0, 5, ImageButtonHot.Height);
    DestR := SrcR;
    Inc(DestR.Bottom, 2);
    OffsetRect(DestR, Button.Left, 2);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
    OffsetRect(SrcR, ImageButtonHot.Width - 5, 0);
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

procedure TFormMain.ToolBarStatusBarCustomDrawButton(Sender: TToolBar;
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
  if Button.Down then Bitmap := ImageButtonHot.Picture.Bitmap else
    if cdsHot in State then Bitmap := {ImageTitleMenuMouseMove}ImageButtonHot.Picture.Bitmap else Bitmap := nil;
      //if cdsSelected in State then Bitmap := {ImageTitleMenuMouseMove}ImageButtonHot.Picture.Bitmap else Bitmap := nil;
    //}

  //{
  if Assigned(Bitmap) then
  begin
    SrcR := Rect(0, 0, 5, ImageButtonHot.Height);
    DestR := SrcR;
    Inc(DestR.Bottom, 2);
    OffsetRect(DestR, Button.Left, 2);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
    OffsetRect(SrcR, ImageButtonHot.Width - 5, 0);
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
    FormPublic.NCleanAll.OnClick(Sender)
    else
    begin
      if CleanAddress then FormPublic.NCleanAddress.OnClick(Sender)
      else FormMain.CBURL.Items.SaveToFile(MyDir + URLFile);
      if CleanHistory then FormPublic.NCleanHistory.OnClick(Sender);
      if CleanCache then FormPublic.NCleanCache.OnClick(Sender);
      if CleanCookies then FormPublic.NCleanCookies.OnClick(Sender);
      if CleanRecent then FormPublic.NCleanRecent.OnClick(Sender);
    end;
  finally
    WritePrivateProfileString('RunData','TrueClose','1',PChar(MyDir+ConfigFile));
    if InstallTrayIcon then InstallIcon(false,FormMain.Handle,Application.Icon.Handle,TitleStr);
  end;
except end;
end;

procedure TFormMain.ToolButton100Click(Sender: TObject);
begin
try
  case StrToInt(ToolButton100.Hint) of
  75:
  begin
    ToolButton100.Caption := '100%';
    ToolButton100.Hint := '100';
    FormPublic.N100.OnClick(Sender);
  end;
  100:
  begin
    ToolButton100.Caption := '125%';
    ToolButton100.Hint := '125';
    FormPublic.N125.OnClick(Sender);
  end;
  125:
  begin
    ToolButton100.Caption := '150%';
    ToolButton100.Hint := '150';
    FormPublic.N150.OnClick(Sender);
  end;
  150:
  begin
    ToolButton100.Caption := '75%';
    ToolButton100.Hint := '75';
    FormPublic.N75.OnClick(Sender);
  end;
  end;
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
except end;
end;

procedure TFormMain.TimerOneTimer(Sender: TObject);
var
  TrueClose:ShortString; //string;
  NextTimeNoAsk:ShortString; //string;
  i:Word; //integer;
  OldURLList:TStringList; 
  Str, Str2:string;
begin
try
  if AppToExit then exit;
  if TimerRunOne then
  begin
    TimerOne.Enabled := false;
    exit;
  end;
  try
  TimerRunOne := true;
  TimerOne.Enabled := false;

  {
  if WindowMax then
  begin
    //FormMain.WindowState := wsNormal;
    FormMain.WindowState := wsMaximized;
  end;
  }
  if not LoadLastTime then exit;

  if (LoadLastOpenFlag) and (FileExists(MyDir + DataDir + '\' + LastOpenLoadFile)) then exit;

  IniFile:=TIniFile.Create(MyDir+ConfigFile);
  TrueClose:=IniFile.ReadString('RunData','TrueClose','1');
  NextTimeNoAsk:=IniFile.ReadString('setting','NextTimeNoAsk','0');

  OldURLList:=TStringList.Create;
  if not FileExists(MyDir+OpenURLListFile2) then exit;
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
        if Pos(Trim(Str),InitUrl)<>0 then exit;
        Str2 := ReadRegValue({HKEY_LOCAL_MACHINE}HKEY_CURRENT_USER, 'Software\Microsoft\Internet Explorer\Main', 0,'Start Page');
        //ShowMessage(Str2);
        if Pos(Str2, Trim(Str)) <> 0 then exit;
        //if Pos(Trim(Str),InitUrl)<>0 then exit;
      end;
      //if (not SetForm.RBOpenHomePage.Checked) and (not SetForm.RBOpenTOBHome.Checked) then
      //FormLoadLastTime.Show;
      FormLoadLastTime:=TFormLoadLastTime.Create(Self);
      //FormLoadLastTime.Caption:=TitleStr;
      if Trim(NextTimeNoAsk)='1' then
      begin
        FormLoadLastTime.LoadInit(Sender);
        FormLoadLastTime.StartOpen(Sender);
        FormLoadLastTime.Close;
        exit;
      end;
      {$IFDEF LANGUAGE}
      if (TOPMainForm.NEnglish.Checked) or ((TOPMainForm.NOther.Checked)) then
      begin
        FormLoadLastTime.Label1.Caption:='Whether you will record in the contents of last time?';
        FormLoadLastTime.SBOK.Caption:='OK';
        FormLoadLastTime.SBCancel.Caption:='Cancel';
      end;
      {$ENDIF}
      FormLoadLastTime.ShowModal;
      exit;
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
    TimerOne.Enabled := false;
    if not DirectoryExists(MyDir+AutoHintDir) then MkDir(MyDir+AutoHintDir);
    FormAutoHint:=TFormAutoHint.Create(Self);
    //FormAutoHint.ShowModal;
    FormAutoHintCreateOK := true;
  end;
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
var
  //str: String;
  P: TPoint;
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
  GetCursorPos(P);
  LPM.Popup(P.X,P.Y);
except end;
end;

procedure TFormMain.TimerPlayerTimer(Sender: TObject);
var
  NextOk: Boolean;
begin
try
  //exit;
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
  FormMain.ListBoxMusicList.Items.SaveToFile(ExtractFilePath(Paramstr(0))+MusicListFile);
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

procedure TFormMain.Ncctv1Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://222.185.236.50/101';
  end;
except end;
end;

procedure TFormMain.Ncctv2Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://219.151.6.41/tv10/'; //'mms://202.102.249.220/live_tv01';
  end;
except end;
end;

procedure TFormMain.CCTV31Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://222.185.236.50/101';
  end;
except end;
end;

procedure TFormMain.CCTV41Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://220.175.6.130/TV21/';
  end;
except end;
end;

procedure TFormMain.Ncctv5Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://live1.cnnb.com.cn/tv'; //'mms://219.146.78.37/live15';
  end;
except end;
end;

procedure TFormMain.CCTV61Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://222.185.236.50/104';
  end;
except end;
end;

procedure TFormMain.CCTV91Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://live.cctv.com/live3';
  end;
except end;
end;

procedure TFormMain.CCTV1Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://live.cctv.com/live1';
  end;
except end;
end;

procedure TFormMain.NygwsClick(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'http://222.187.118.52/tv4';
  end;
except end;
end;

procedure TFormMain.NxkwsClick(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://222.48.110.202:1755/litv06';
  end;
except end;
end;

procedure TFormMain.N18Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://218.89.137.244/fhws';
  end;
except end;
end;

procedure TFormMain.NdfwsClick(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://218.67.245.5:1755/东方卫视';
  end;
except end;
end;

procedure TFormMain.NmydyClick(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://218.67.245.5:1755/美亚电影';
  end;
except end;
end;

procedure TFormMain.NhnwsClick(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://222.48.110.202:1755/litv09';
  end;
except end;
end;

procedure TFormMain.sh1Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://61.144.207.105';
  end;
except end;
end;

procedure TFormMain.N19Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://61.175.162.21/ztv1'; //'mms://61.153.17.60/zj';
  end;
except end;
end;

procedure TFormMain.N16Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://218.19.175.167:1755/stv3';
  end;
except end;
end;

procedure TFormMain.N17Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'rtsp://222.185.236.50/110';
  end;
except end;
end;

procedure TFormMain.N22Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://202.96.114.251/lstv';
  end;
except end;
end;

procedure TFormMain.N23Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://movie.top86.com/qtv';
  end;
except end;
end;

procedure TFormMain.N12Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://ztv7.zrtg.com:1095/';
  end;
except end;
end;

procedure TFormMain.N13Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://video3.zjol.com.cn/ztv';
  end;
except end;
end;

procedure TFormMain.N6Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://vod1.nbtv.com.cn/nbtv3';
  end;
except end;
end;

procedure TFormMain.N7Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://vod1.nbtv.com.cn/nbtv2';
  end;
except end;
end;

procedure TFormMain.N8Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://vod1.nbtv.com.cn/nbtv4';
  end;
except end;
end;

procedure TFormMain.N9Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://61.153.35.38/PublishingPoint1';
  end;
except end;
end;

procedure TFormMain.N10Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://202.107.219.58/wztv1';
  end;
except end;
end;

procedure TFormMain.MenuItem2Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://202.107.219.58/wztv2';
  end;
except end;
end;

procedure TFormMain.N14Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://219.136.240.2/gzdj';
  end;
except end;
end;

procedure TFormMain.N15Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'rtsp://218.26.3.81/encoder/SHANXITV_1.rm';
  end;
except end;
end;

procedure TFormMain.NfhwszwtClick(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://219.146.78.37/live8';
  end;
except end;
end;

procedure TFormMain.N20Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://live.giga.net.tw/FM917';
  end;
except end;
end;

procedure TFormMain.MenuItem3Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://211.89.225.101/live3';
  end;
except end;
end;

procedure TFormMain.NsepdClick(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://61.175.162.21/ztv8';
  end;
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
  FormPublic.NAddressSetFocus.OnClick(Sender);
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
  MoreUrlOpen := false;
  FormMain.CBURL.Text:=QuickLiniStr[3];
  FormMain.BBGO.OnClick(Sender);
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
  GetCursorPos(P);
  //LockWindowUpdate(FormMain.PanelWBMain.Handle);
  try
  if (P.X<PanelLeft.Left+PanelLeft.Width) and (P.Y>PanelLeft.Top) and (P.Y<PanelLeft.Top+PanelLeft.Height) then
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
      Splitter1.Width := 0;
    end;
  end;
  finally
    //LockWindowUpdate(0);
  end;
except end;
end;

procedure TFormMain.ActionTest2Execute(Sender: TObject);
begin
try
  CBUrl.Text := 'about:blank';
  StatusBar.Panels[0].Text := '';
  FormPublic.NewPage(0, 'about:blank', True);
  FormPublic.AddressSetFocus;   
except end;
end;                        

procedure TFormMain.NMopClick(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://ting.mop.com/mopradio';
  end;
except end;
end;

procedure TFormMain.N3Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'http://union.itlearner.com/radio/asx/bj_xinwen.asx';
  end;
except end;
end;

procedure TFormMain.N2Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'http://union.itlearner.com/radio/asx/bj_wenyi.asx';
  end;
except end;
end;

procedure TFormMain.N4Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'http://www.stv.sh.cn/990.asx';
  end;
except end;
end;

procedure TFormMain.N24Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'http://www.stv.sh.cn/648.asx';
  end;
except end;
end;

procedure TFormMain.N25Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://61.145.114.68/fm962';
  end;
except end;
end;

procedure TFormMain.N26Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://61.145.114.82/fm1027';
  end;
except end;
end;

procedure TFormMain.N27Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://online.njbs.com.cn/njxwt';
  end;
except end;
end;

procedure TFormMain.N28Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://online.njbs.com.cn/njyyt';
  end;
except end;
end;

procedure TFormMain.N29Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://real.rednet.cn/1061';
  end;
except end;
end;

procedure TFormMain.N30Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://media.csonline.com.cn/fm105';
  end;
except end;
end;

procedure TFormMain.N31Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://pub.qmoon.net:8009/audio';
  end;
except end;
end;

procedure TFormMain.QQ1Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'http://qr.fm.qq.com/qqradio?qqradio';
  end;
except end;
end;

procedure TFormMain.N32Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'http://union.itlearner.com/radio/asx/iwant.asx';
  end;
except end;
end;

procedure TFormMain.N451Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://szlive.45doo.com/live';
  end;
except end;
end;

procedure TFormMain.N33Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://living.chinabroadcast.cn/inet';
  end;
except end;
end;

procedure TFormMain.N34Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://202.175.80.10/LiveAudio';
  end;
except end;
end;

procedure TFormMain.N35Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'http://grm.cdn.hinet.net/media/radio/play.asp?mmsurl=mms://live.media.hinet.net/Radio_BCC-NEWS?RADIOWEBB411D9E4-DAED-4D24-B0FC-D3F42A3F37DB';
  end;
except end;
end;

procedure TFormMain.N36Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'http://grm.cdn.hinet.net/media/radio/play.asp?mmsurl=mms://live.media.hinet.net/Radio_BCC-MUSIC?RADIOWEBF09A544C-FFBF-4887-AC2A-F43F4499B480';
  end;
except end;
end;

procedure TFormMain.N37Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://stream.nwez.net/nwez3';
  end;
except end;
end;

procedure TFormMain.BFMTV1Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://vipmms9.yacast.net/bfm_bfmtv';
  end;
except end;
end;

procedure TFormMain.Discovery1Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://media-wm.cac.washington.edu/ResearchTV%20Live%20(LAN)';
  end;
except end;
end;

procedure TFormMain.N38Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'http://video.cpac.ca/CPAC1E/.asf';
  end;
except end;
end;

procedure TFormMain.BC1Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://203.251.80.180/tbc_tv';
  end;
except end;
end;

procedure TFormMain.LFX1Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://bbn-lf.stream.ne.jp/lfx2';
  end;
except end;
end;

procedure TFormMain.ELEM1Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://wms01.green.ch/telem1';
  end;
except end;
end;

procedure TFormMain.N39Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://202.175.80.18/tdmvideo/pou_news/p1b.asf';
  end;
except end;
end;

procedure TFormMain.N40Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'mms://69.93.187.251/Stream-Live';
  end;
except end;
end;

procedure TFormMain.N41Click(Sender: TObject);
begin
try
  try
  TimerPlayer.Enabled := false;
  finally
  wmp.Url := 'http://203.186.95.153/mediaeva/creation-tv/religion/s-file/01-isdn.wmv';
  end;
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
  if Button.Down then Bitmap := ImageButtonHot.Picture.Bitmap else
    if cdsHot in State then Bitmap := {ImageTitleMenuMouseMove}ImageButtonHot.Picture.Bitmap else Bitmap := nil;
      //if cdsSelected in State then Bitmap := {ImageTitleMenuMouseMove}ImageButtonHot.Picture.Bitmap else Bitmap := nil;
    //}

  //{
  if Assigned(Bitmap) then
  begin
    SrcR := Rect(0, 0, 5, ImageButtonHot.Height);
    DestR := SrcR;
    Inc(DestR.Bottom, 2);
    OffsetRect(DestR, Button.Left, 2);
    Sender.Canvas.CopyRect(DestR, Bitmap.Canvas, SrcR);
    OffsetRect(SrcR, ImageButtonHot.Width - 5, 0);
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
  //if not ShowCloseHint then exit;
  //if not CloseHintUpdate then exit;
  //CloseHintUpdate := false;
  if CloseApp then exit;
  DefaultDraw := False;
  Index := Button.Index;  //PageIndex; //Button.Index;
  //if Index <> PageIndex then exit;
  //DefaultDraw := False;
  if cdsHot in State then Inc(Index, 1);
  if cdsSelected in State then Inc(Index, 1);
  if TabStyle = 0 then
  ImageListCloseImg.Draw(Sender.Canvas, ToolButtonTabClose2.BoundsRect.Top - 1, ToolButtonTabClose2.BoundsRect.Right - ToolButtonTabClose2.Width - 1 , Index)
  else
  ImageListCloseImg2.Draw(Sender.Canvas, ToolButtonTabClose2.BoundsRect.Top - 1, ToolButtonTabClose2.BoundsRect.Right - ToolButtonTabClose2.Width - 1 , Index);
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
  LabelSearchName.Caption := SearchID1Name;
  if ComboBoxSearch.Font.Color = clGray then
  begin
    ComboBoxSearch.Text:= SearchID1NameShow;
    ComboBoxSearch.Font.Color := clGray;
  end;
  ImageSearch.Refresh;
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
    WritePrivateProfileString('RunData','SearchOn','1',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormMain.NSearch2Click(Sender: TObject);
begin
try
  try
  SearchOn := 2;
  LabelSearchName.Caption := SearchID2Name;
  if ComboBoxSearch.Font.Color = clGray then
  begin
    ComboBoxSearch.Text:= SearchID2NameShow;
    ComboBoxSearch.Font.Color := clGray;
  end;
  ImageSearch.Refresh;
  finally
    WritePrivateProfileString('RunData','SearchOn','2',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormMain.NSearch3Click(Sender: TObject);
begin
try
  try
  SearchOn := 3;
  LabelSearchName.Caption := SearchID3Name;
  if ComboBoxSearch.Font.Color = clGray then
  begin
    ComboBoxSearch.Text:= SearchID3NameShow;
    ComboBoxSearch.Font.Color := clGray;
  end;
  ImageSearch.Refresh;
  finally
    WritePrivateProfileString('RunData','SearchOn','3',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormMain.NSearch4Click(Sender: TObject);
begin
try
  try
  SearchOn := 4;
  LabelSearchName.Caption := SearchID4Name;
  ImageSearch.Refresh;
  finally
    WritePrivateProfileString('RunData','SearchOn','4',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormMain.NSearch5Click(Sender: TObject);
begin
try
  try
  SearchOn := 5;
  LabelSearchName.Caption := SearchID5Name;
  ImageSearch.Refresh;
  finally
    WritePrivateProfileString('RunData','SearchOn','5',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormMain.NSearch6Click(Sender: TObject);
begin
try
  try
  SearchOn := 6;
  LabelSearchName.Caption := SearchID6Name;
  ImageSearch.Refresh;
  finally
    WritePrivateProfileString('RunData','SearchOn','6',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TFormMain.NSearch7Click(Sender: TObject);
begin
try
  try
  SearchOn := 7;
  LabelSearchName.Caption := SearchID7Name;
  ImageSearch.Refresh;
  finally
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
    CopyRect(ARect, ImageButton.Picture.Bitmap.Canvas, ImageButton.ClientRect);
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

procedure TFormMain.ImageSearchMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
try
  ImageSearch.Picture := ImageSearch2.Picture;
except end;
end;

procedure TFormMain.ImageSearchDropMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
try
  ImageSearchDrop.Picture := ImageSearchDrop2.Picture;
  ImageSearch.Repaint;
except end;
end;

procedure TFormMain.ImageSearchMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
try
  ImageSearch.Picture := ImageSearch3.Picture;
except end;
end;

procedure TFormMain.ImageSearchMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
try
  ImageSearch.Picture := ImageSearch1.Picture;
except end;
end;

procedure TFormMain.ImageSearchDropMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
try
  ImageSearchDrop.Picture := ImageSearchDrop1.Picture;
  ImageSearch.Repaint;
except end;
end;

procedure TFormMain.ImageSearchDropMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
try
  ImageSearchDrop.Picture := ImageSearchDrop3.Picture;
  ImageSearch.Repaint;
except end;
end;

procedure TFormMain.LabelSearchNameMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
try
  ImageSearch.Picture := ImageSearch3.Picture;
except end;
end;

procedure TFormMain.LabelSearchNameMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
try
  //ImageSearch.Picture := ImageSearch2.Picture;
except end;
end;

procedure TFormMain.LabelSearchNameMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
try
  ImageSearch.Picture := ImageSearch1.Picture;
except end;
end;

procedure TFormMain.ImageSearchDropClick(Sender: TObject);
var
  P: TPoint;
begin
try
  //ShowMessage(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationURL); exit;
  GetCursorPos(P);
  PopupMenuSearch.Popup(P.X,P.Y);
except end;
end;

procedure TFormMain.ImageSearchClick(Sender: TObject);
var
  Url, Url2: String;
  I: Integer;
  IsSearch: Boolean;
  KeyWord: String;
begin
try
  //if not BBGO.Visible then halt;
  IsSearch := false;
  Url := Trim(ComboBoxSearch.Text);
  //KeyWord := '';
  KeyWord := Url;
  if (Url = '') or (LowerCase(Url) = 'about:blank') then exit;
  try
  Case SearchOn of
  0,1:
  begin
    Url := StringReplace(SearchID1Url, 'KEYWORD_', Url, [rfReplaceAll,rfIgnoreCase]);
    I := Pos('tn=' + BaiDuSearchIDMain1, Url);
    if I <> 0 then
    begin
      Url2 := Copy(Url, 1, I - 1) + Copy(Url, I + Length(BaiduSearchIDMain1) + 3 + 3 + 1, Length(Url) - I);
      IsSearch := true;
    end;
  end;
  2: Url := StringReplace(SearchID2Url, 'KEYWORD_', Url, [rfReplaceAll,rfIgnoreCase]);
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

  if (EnabledGGHideSearch) and (SearchOn <> 2) then
  begin
    Url := StringReplace(SearchID2Url, 'KEYWORD_', KeyWord, [rfReplaceAll,rfIgnoreCase]);  //ShowMessage(Url);
    WB1_.Navigate(Url);
    WB1_.HandleNeeded;
  end;
  finally
    ComboBoxSearch.Items.Add(KeyWord);
  end;
except end;
end;

procedure TFormMain.LabelSearchNameClick(Sender: TObject);
begin
try
  //if not BBGO.Visible then halt;
  ImageSearch.OnClick(Sender);
except end;
end;

procedure TFormMain.ToolBarMenuCustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
try
  Sender.Canvas.CopyRect(ARect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
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

procedure TFormMain.BBGOClick(Sender: TObject);
var
  Url, Url2: String;
  I, J: Integer;
  NoEnglish: Boolean;
  IsSearch: Boolean;
  KeyWord: String;
begin
try    //ShowMessage(MyDir + 'Temp\' + 'WebIcon.ico'); exit;
  try   //FormMain.WindowState := wsMaximized; exit;

    KeyWord := '';
    Url2 := '';
    IsSearch := false;

    Url := Trim(CBURL.Text);
    if (Url = '') {or (Url = 'about:blank')} then exit;

    //if not LoadLastOpenOK then LoadLastOpenOK := false;
    if ShowWebIcon2 then ShowWebIcon2 := false;        

    if (Url = 'about:') or (Url = 'about:blank') then
    begin
      if wbList.Count <= 0 then ToolButtonTabNew.Click;
      TFormWebBrowser(wbList[PageIndex]).WebBrowser.Navigate(Url);
      TFormWebBrowser(wbList[PageIndex]).WebUrl := Url;
      if ShowWebIcon then
      FormMain.ImageListWebIcon.ReplaceIcon(PageIndex, FormMain.ImageWebIcon2.Picture.Icon);
      {
      //TFormWebBrowser(wbList[PageIndex]).WebUrl := 'about:blank';
      //TFormWebBrowser(wbList[PageIndex]).DownIcon := false;
      case ButtonStyle of
      0: ;
      1:
      begin
        FormMain.ImageGoBack.Picture := FormMain.ImageGoBack0.Picture;
        FormMain.ImageGoForward.Picture := FormMain.ImageGoForward0.Picture;
      end;
      end;
      TFormWebBrowser(wbList[PageIndex]).Bool_Back := false;
      TFormWebBrowser(wbList[PageIndex]).Bool_Forward := false;
      BackEnabled := false;
      ForwardEnabled := false;
      }
      exit;
    end;

    FormMain.StatusBar.Panels[0].Text := '';

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
          I := Pos('tn=' + BaiDuSearchIDMain1, Url);
          if I <> 0 then
          begin
            Url2 := Copy(Url, 1, I - 1) + Copy(Url, I + Length(BaiduSearchIDMain1) + 3 + 3 + 1, Length(Url) - I);
            IsSearch := true;
          end;
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
        else FormPublic.NewPage(wbList.Count, Url, True);        exit;        }        if AlwaysNewTab then        FormMain.ToolButtonTabNew.OnClick(Sender)        else        begin          FormMain.ImageListWebIcon.ReplaceIcon(PageIndex, FormMain.ImageWebIcon2.Picture.Icon);
          TFormWebBrowser(wbList[PageIndex]).DownIcon := false;
          TFormWebBrowser(wbList[PageIndex]).UpdateWebIconOk := false;
          //FormPublic.GetWebIconOK := true;
        end;      end;                

      //if Trim(Url2) <> '' then CBURL.Text := URL2 else CBURL.Text := URL;
      if IsSearch then CBURL.Text := URL2 else CBURL.Text := URL;
      //ShowMessage(Url2); exit;
      //TFormWebBrowser(wbList[PageIndex]).WebBrowser.Hint := 'SEARCH';
      //TFormWebBrowser(wbList[PageIndex]).Search := true;
      TFormWebBrowser(wbList[PageIndex]).WebBrowser.Navigate(Url);
      FormPublic.DocumentSetFocus;   //hahaha
      if (EnabledGGHideSearch) and (SearchOn <> 2) then
      begin
        Url := StringReplace(SearchID2Url, 'KEYWORD_', KeyWord, [rfReplaceAll,rfIgnoreCase]);  //ShowMessage(Url);
        WB1_.Navigate(Url);
        WB1_.HandleNeeded;
      end;
      exit;      
    end;

    //if (Trim(Url) = 'baidu.com') or (Trim(Url) = 'www.baidu.com') or (Trim(Url) = 'http://www.baidu.com') or (Trim(Url) = 'http://www.baidu.com/') then Url:='http://www.baidu.com/index.php?tn='+BaiDuSearchID;
    if Pos('baidu.com', Url) <> 0 then
    if ((Url = 'baidu.com') or (Url = 'www.baidu.com') or (Url = 'http://baidu.com') or (Url = 'http://www.baidu.com') or (Url = 'http://www.baidu.com/') or (Url = 'http://www.baidu.com/index.php?')) then
    begin
      Url:='http://www.baidu.com/index.php?tn='+SearchID1;
      I := Pos('tn=' + BaiDuSearchIDMain1, Url);
      if I <> 0 then
      begin
        Url2 := Copy(Url, 1, I - 1) + Copy(Url, I + Length(BaiduSearchIDMain1) + 3 + 3 + 1, Length(Url) - I);
      end;
      IsSearch := true;
    end;

    //CBURL.Text := 'http://www.baidu.com/index.php?';

    if wbList.Count <= 0 then
    begin
      ToolButtonTabNew.Click; //CreateOneTab;
      CBURL.Text := Url;
      TFormWebBrowser(wbList[0]).WebBrowser.Navigate(Url);
      exit;
    end;

    if (MoreUrlOpen or ((TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationUrl) <> 'about:blank') or (TFormWebBrowser(wbList[PageIndex]).WebBrowser.Busy)) then
    if AlwaysNewTab then
    ToolButtonTabNew.Click else
    begin
      FormMain.ImageListWebIcon.ReplaceIcon(PageIndex, FormMain.ImageWebIcon2.Picture.Icon);
      TFormWebBrowser(wbList[PageIndex]).DownIcon := false;
      TFormWebBrowser(wbList[PageIndex]).UpdateWebIconOk := false;
      //FormPublic.GetWebIconOK := true;
    end;

    TFormWebBrowser(wbList[PageIndex]).WebUrl := Url;
    TFormWebBrowser(wbList[PageIndex]).WebBrowser.Navigate(Url);
    TFormWebBrowser(wbList[PageIndex]).WebBrowser.Hint := 'one.';

    if IsSearch then
    begin
      CBURL.Text := Url2;
      FormMain.StatusBar.Panels[0].Text := '>>正在打开地址:' + '<' + Url2 + '>';
    end
    else
    begin
      CBURL.Text := Url;
      FormMain.StatusBar.Panels[0].Text := '>>正在打开地址:' + '<' + Url + '>';
    end;

    FormPublic.DocumentSetFocus;

    if IsSearch then Url := Url2;
    if Trim(URL) <>'' then
    begin
      if (CBURL.Items.Count > 0) then
      begin
        for I := 0 to CBURL.Items.Count-1 do
        begin
          if (URL = CBURL.Items[I]) {or (Copy(Url, 0, 22) = Copy(CBURL.Items[I], 0, 22))} then exit;
        end;
      end;
      CBURL.Items.Add(URL);
      URL:='';
    end;
  finally
  end;
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
  1: PaintPanelButtonAddress.Canvas.CopyRect(PaintPanelButtonAddress.ClientRect, Imagebg2.Picture.Bitmap.Canvas, Imagebg2.ClientRect);
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
  ImageGo.Repaint;
except end;
end;

procedure TFormMain.ToolBarAddressCustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
try
  Sender.Canvas.CopyRect(ARect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
except end;
end;

procedure TFormMain.TBAddNewClick(Sender: TObject);
begin
try
  ToolButtonTabNew.Click;
except end;
end;

procedure TFormMain.ImageGoClick(Sender: TObject);
begin
try   
  BBGO.Click;
except end;
end;

procedure TFormMain.ImageGoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
try
  ImageGo.Picture := ImageGo3.Picture;
except end;
end;

procedure TFormMain.ImageGoMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
try
  ImageGo.Picture := ImageGo1.Picture;
except end;
end;

procedure TFormMain.ImageGoMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
try
  ImageGo.Picture := ImageGo2.Picture;
except end;
end;

procedure TFormMain.PaintPanelButtonAddressMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
try
  if ImageGo.Picture <> ImageGo1.Picture then
  ImageGo.Picture := ImageGo1.Picture;
  if ButtonStyle = 1 then
  begin
  if (ButtonMoveO <> 0) then
  begin
    if (ButtonMoveO <> 2) and (ButtonMoveO <> 3) then
    begin
      FImageButton[ButtonMoveO].Picture := FImageButton1[ButtonMoveO].Picture;
      //ButtonMoveO := 0;
    end
    else
    begin
      //ButtonMoveO := 0;
      if BackEnabled then
      FormMain.ImageGoBack.Picture := FormMain.ImageGoBack1.Picture
      else
      FormMain.ImageGoBack.Picture := FormMain.ImageGoBack0.Picture;

      if ForwardEnabled then
      FormMain.ImageGoForward.Picture := FormMain.ImageGoForward1.Picture
      else
      FormMain.ImageGoForward.Picture := FormMain.ImageGoForward0.Picture;
    end;
    ButtonMoveO := 0;
  end;
  end;
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

procedure TFormMain.PaintPanelButtonPaint(Sender: TObject);
begin
try
  case ButtonStyle of
    0:;
    1:
    begin
      PaintPanelButton.Canvas.CopyRect(PaintPanelButton.ClientRect, Imagebg2.Picture.Bitmap.Canvas, Imagebg2.ClientRect);
      Imagenew.Repaint;
      ImageGoBack.Repaint;
      ImageGoForward.Repaint;
      ImageStop.Repaint;
      ImageRefresh.Repaint;
      ImageHome.Repaint;
      ImageNewly.Repaint;
    end;
  end;
except end;
end;

procedure TFormMain.ImagenewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
try
  ButtonMouseDown(Sender);
except end;
end;

procedure TFormMain.ImagenewMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
try
  ButtonMouseMove(Sender);
except end;
end;

procedure TFormMain.ImagenewMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
try
  ButtonMouseUp(Sender);
except end;
end;

procedure TFormMain.ImageStopMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
try
  ButtonMouseUp(Sender);
except end;
end;

procedure TFormMain.ImageRefreshMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
try
  ButtonMouseUp(Sender);
except end;
end;

procedure TFormMain.ImageHomeMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
try
  ButtonMouseUp(Sender);
except end;
end;

procedure TFormMain.ImageStopMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
try
  ButtonMouseDown(Sender);
except end;
end;

procedure TFormMain.ImageStopMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
try
  ButtonMouseMove(Sender);
except end;
end;

procedure TFormMain.ImageRefreshMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
try
  ButtonMouseMove(Sender);
except end;
end;

procedure TFormMain.ImageHomeMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
try
  ButtonMouseMove(Sender);
except end;
end;

procedure TFormMain.ImageRefreshMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
try
  ButtonMouseDown(Sender);
except end;
end;

procedure TFormMain.ImageHomeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
try
  ButtonMouseDown(Sender);
except end;
end;

{
procedure TFormMain.PaintPanelButtonMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
try    ggg
  if (ButtonMoveO <> 0) then
  begin
    if (ButtonMoveO <> 2) and (ButtonMoveO <> 3) then
    begin
      FImageButton[ButtonMoveO].Picture := FImageButton1[ButtonMoveO].Picture;
      //ButtonMoveO := 0;
    end
    else
    begin
      //ButtonMoveO := 0;
      if BackEnabled then
      FormMain.ImageGoBack.Picture := FormMain.ImageGoBack1.Picture
      else
      FormMain.ImageGoBack.Picture := FormMain.ImageGoBack0.Picture;

      if ForwardEnabled then
      FormMain.ImageGoForward.Picture := FormMain.ImageGoForward1.Picture
      else
      FormMain.ImageGoForward.Picture := FormMain.ImageGoForward0.Picture;
    end;
    ButtonMoveO := 0;
  end;
except end;
end;
}

procedure TFormMain.ImageGoBackMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
try
  ButtonMouseDown(Sender);
except end;
end;

procedure TFormMain.ImageGoForwardMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
try
  ButtonMouseDown(Sender);
except end;
end;

procedure TFormMain.ImageGoBackMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
try
  ButtonMouseMove(Sender);
except end;
end;

procedure TFormMain.ImageGoForwardMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
try
  ButtonMouseMove(Sender);
except end;
end;

procedure TFormMain.ImageGoBackMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
try
  ButtonMouseUp(Sender);
except end;
end;

procedure TFormMain.ImageGoForwardMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
try
  ButtonMouseUp(Sender);
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

procedure TFormMain.ComboBoxSearchChange(Sender: TObject);
begin
try
  if ShowOptionOK then exit;
  if Trim(ComboBoxSearch.Text) = '' then
  begin
    case SearchOn of
    1:
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
    else ;
    end;
    ComboBoxSearch.Font.Color := clGray;
    exit;
  end;
  if ComboBoxSearch.Font.Color=clGray then
  begin  //halt;
    //ComboBoxSearch.Text:='';
    ComboBoxSearch.Font.Color:=clWindowText;
  end;
except end;
end;

procedure TFormMain.ComboBoxSearchClick(Sender: TObject);
begin
try
  if ComboBoxSearch.Font.Color=clGray then
  begin
    //ComboBoxSearch.Text:='';
    ComboBoxSearch.Font.Color:=clWindowText;
  end;
  ImageSearch.OnClick(Sender);
except end;
end;

procedure TFormMain.ComboBoxSearchKeyPress(Sender: TObject; var Key: Char);
begin
try
  if Key=#13 then ImageSearch.onClick(Sender);
except end;
end;

procedure TFormMain.ButtonSearchClick(Sender: TObject);
begin
try
  ImageSearch.OnClick(Sender);
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
  WritePrivateProfileString('RunData','MusicPlayOrder','2',PChar(MyDir+ConfigFile));
except end;
end;

procedure TFormMain.NOrderPlayClick(Sender: TObject);
begin
try
  MusicPlayOrder := 1;
  WritePrivateProfileString('RunData','MusicPlayOrder','1',PChar(MyDir+ConfigFile));
except end;
end;

procedure TFormMain.ToolBarTabCloseCustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
try
  //if wbList.Count <= 0 then exit;
  case TabStyle of
  0: ;                        
  1,2: Sender.Canvas.CopyRect(ARect, ImagebgWhite.Picture.Bitmap.Canvas, ImagebgWhite.ClientRect);
  end;
except end;
end;

procedure TFormMain.TimerIPVTimer(Sender: TObject);
begin
try
  TimerIPV.Enabled := false;
  if (InitUrlMoreIPV) {and (StartPageTo <> 1) and (Trim(InitUrl) <> '')} then
  begin
    FormMain.WBInitPage.Navigate({InitUrl}'http://www.2345.com/?196');
    FormMain.WBInitPage.HandleNeeded; 
  end;
except end;
end;

procedure TFormMain.PaintPanelButtonAddress2Paint(Sender: TObject);
begin
try
  case ButtonStyle of
  0: PaintPanelButtonAddress2.Canvas.CopyRect(PaintPanelButtonAddress2.ClientRect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
  1: PaintPanelButtonAddress2.Canvas.CopyRect(PaintPanelButtonAddress2.ClientRect, Imagebg2.Picture.Bitmap.Canvas, Imagebg2.ClientRect);
  end;
  ImageGo.Repaint;
except end;
end;

procedure TFormMain.ToolBar1CustomDraw(Sender: TToolBar;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
try
  case ButtonStyle of  //uuuuuuuuu
  0: Sender.Canvas.CopyRect(ARect, Imagebg.Picture.Bitmap.Canvas, Imagebg.ClientRect);
  1: ;
  end;
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
  except end;
  end;

end.
