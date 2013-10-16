unit EmbeddedWB;

{$DEFINE USE_IOLECOMMANDTARGET}
//***********************************************************
//               EmbeddedWb ver D2005 (Nov. 20 , 2005)      *
//                                                          *
//              For Delphi 4, 5, 6 , 7 , 2005 , 2006        *
//                     Freeware Component                   *
//                            by                            *
//                     Per Lindsø Larsen                    *
//                 per.lindsoe@larsen.mail.dk               *
//                                                          *
//                                                          *
//       Contributors:                                      *
//                                                          *
//      Eran Bodankin (bsalsa) - Bug fix & D2006 Update     *
//       & All the new functions / procedures               *
//          bsalsa@bsalsa.no-ip.info                        *
//                                                          *
//                mm&I D2005 update                         *
//            Mathias Walter (walter@coint.de)              *
//              -  all messagehandling code                 *
//                                                          *
//            Neil Moss (NeilM@BuchananInternational.com)   *
//              -  code for setting downloadoptions         *
//                                                          *
//            jezek1                                        *
//              - support for D7  (12/09/2002)              *
//                                                          *
//            Thomas Stutz                                  *
//                                                          *
//            - added THEME, NOTHEME, NOPICS,               *
//              NO3DOUTERBORDER to TUserInterfaceOption     *
//              (11/1/04)                                   *
//                                                          *
//       Documentation and updated versions:                *
//                                                          *
//               http://www.euromind.com/iedelphi           *
//    http://groups.yahoo.com/group/delphi-webbrowser/       *
//***********************************************************

interface

{$I EWB.inc}

uses
  SysUtils{$IFDEF DELPHI_6_UP}, Variants {$ENDIF},IEConst, IEUtils, Registry, Windows, Messages, Classes, JPEG,
  Graphics, Controls, Forms, Dialogs, EXTCtrls, OleCtrls, SHDocVw, ActiveX, shlObj,
  Wininet, Urlmon, shellapi, MSHTML, BrowseForFolderU, ComCtrls, iniFiles;

type
{$IFDEF USE_IOLECOMMANDTARGET}
  TScriptErrorEvent = procedure(Sender: TObject; ErrorLine, ErrorCharacter, ErrorCode, ErrorMessage, ErrorUrl: string;
    var ContinueScript: Boolean; var Showdialog: Boolean) of object;
  TRefreshEvent = procedure(Sender: TObject; CmdID: Integer; var Cancel: Boolean) of object;
  TUnloadEvent = procedure(Sender: TObject) of object;
{$ENDIF}
   TInvokeEvent = function(DispID: Integer; const IID: TGUID; LocaleID: Integer;
    Flags: Word; var Params: TagDispParams; VarResult, ExcepInfo, ArgErr: Pointer): HResult of object;

  TGetOverrideKeyPathEvent = function(pchKey: POLESTR; dw: DWORD): HRESULT of object;
  TGetHostInfoEvent = function(var pInfo: TDOCHOSTUIINFO): HRESULT of object;
  TShowUIEvent = function(const dwID: DWORD; const pActiveObject: IOleInPlaceActiveObject;
    const pCommandTarget: IOleCommandTarget; const pFrame: IOleInPlaceFrame;
    const pDoc: IOleInPlaceUIWindow): HRESULT of object;
  THideUIEvent = function: HRESULT of object;
  TUpdateUIEvent = function: HRESULT of object;
  TEnableModelessEvent = function(const fEnable: BOOL): HRESULT of object;
  TOnDocWindowActivateEvent = function(const fActivate: BOOL): HRESULT of object;
  TOnFrameWindowActivateEvent = function(const fActivate: BOOL): HRESULT of object;
  TResizeBorderEvent = function(const prcBorder: PRECT;
    const pUIWindow: IOleInPlaceUIWindow;
    const fRameWindow: BOOL): HRESULT of object;
  TTranslateAcceleratorEvent = function(const lpMsg: PMSG; const pguidCmdGroup: PGUID;
    const nCmdID: DWORD): HRESULT of object;
  TGetOptionKeyPathEvent = function(var pchKey: POLESTR; const dw: DWORD): HRESULT of object;
  TGetDropTargetEvent = function(const pDropTarget: IDropTarget;
    out ppDropTarget: IDropTarget): HRESULT of object;
  TGetExternalEvent = function(out ppDispatch: IDispatch): HRESULT of object;
  TTranslateUrlEvent = function(const dwTranslate: DWORD; const pchURLIn: POLESTR;
    var ppchURLOut: POLESTR): HRESULT of object;
  TFilterDataObjectEvent = function(const pDO: IDataObject;
    out ppDORet: IDataObject): HRESULT of object;
  TShowMessageEvent = function(hwnd: THandle;
    lpstrText: POLESTR; lpstrCaption: POLESTR; dwType: longint; lpstrHelpFile: POLESTR;
    dwHelpContext: longint; var plResult: LRESULT): HRESULT of object;
  TShowHelpEvent = function(hwnd: THandle; pszHelpFile: POLESTR; uCommand: integer;
    dwData: longint; ptMouse: TPoint;
    var pDispatchObjectHit: IDispatch): HRESULT of object;
  TGetTypeInFoCountEvent = function(out Count: Integer): HResult of object;
  TGetTypeInfoEvent = function(Index, LocaleID: Integer; out TypeInfo: ITypeInfo): HResult of object;
  TGetIDsOfNamesEvent = function(const IID: TGUID; Names: Pointer;
    NameCount, LocaleID: Integer; DispIDs: Pointer): HResult of object;
  TQueryServiceEvent = function(const rsid, iid: TGuid; out Obj: IUnknown): HResult of object;
  TShowDialogEvent = procedure(Sender: TObject; h: THandle) of object;
   // TProgressChange = procedure(ASender: TObject; Progress, ProgressMax: Integer) of object;
    TShowContextMenuEvent = function(const dwID: DWORD; const ppt: PPOINT;
    const pcmdtReserved: IUnknown; const pdispReserved: IDispatch): HRESULT of object;

  TDownloadControlOption = (DLCTL_DLIMAGES, DLCTL_VIDEOS, DLCTL_BGSOUNDS,
    DLCTL_NO_SCRIPTS, DLCTL_NO_JAVA, DLCTL_NO_RUNACTIVEXCTLS, DLCTL_NO_DLACTIVEXCTLS,
    DLCTL_DOWNLOADONLY, DLCTL_NO_FRAMEDOWNLOAD, DLCTL_RESYNCHRONIZE, DLCTL_PRAGMA_NO_CACHE,
    DLCTL_NO_BEHAVIORS, DLCTL_NO_METACHARSET, DLCTL_URL_ENCODING_DISABLE_UTF8,
    DLCTL_URL_ENCODING_ENABLE_UTF8, DLCTL_FORCEOFFLINE, DLCTL_NO_CLIENTPULL,
    DLCTL_SILENT, DLCTL_OFFLINE);

  TDownloadControlOptions = set of TDownloadControlOption;

  TUserInterfaceOption = (DIALOG, DISABLE_HELP_MENU, NO3DBORDER,
    SCROLL_NO, DISABLE_SCRIPT_INACTIVE, OPENNEWWIN,
    DISABLE_OFFSCREEN,
    FLAT_SCROLLBAR, DIV_BLOCKDEFAULT, ACTIVATE_CLIENTHIT_ONLY,
    OVERRIDEBEHAVIORFACTORY,
    CODEPAGELINKEDFONTS, URL_ENCODING_DISABLE_UTF8,
    URL_ENCODING_ENABLE_UTF8,
    ENABLE_FORMS_AUTOCOMPLETE, ENABLE_INPLACE_NAVIGATION,
    IME_ENABLE_RECONVERSION,
    THEME, NOTHEME, NOPICS, NO3DOUTERBORDER);
  TUserInterfaceOptions = set of TUserInterfaceOption;

type
  TMeasure = (mMetric, mUS);
  TPrintOrientationOption = (poPortrait, poLandscape);
  TMargins = class(TPersistent)
  private
    FLeft: Real;
    FRight: Real;
    FTop: Real;
    FBottom: real;
  published
    property Left: Real read FLeft write FLeft;
    property Right: Real read FRight write FRight;
    property Top: Real read FTop write FTop;
    property Bottom: Real read FBottom write FBottom;
  end;

  TPrintOptions = class(TPersistent)
  private
    FHTMLHeader: TStrings;
    FHeader: string;
    FFooter: string;
    FMargins: TMargins;
    FOrientation: TPrintOrientationOption;
    FMeasure: TMeasure;
    procedure SetHTMLHeader(const Value: Tstrings);
    property Measure: TMeasure read FMeasure;
  published
    property Margins: TMargins read FMargins write FMargins;
    property Header: string read FHeader write FHeader;
    property HTMLHeader: TStrings read FHTMLHeader write SetHTMLHeader;
    property Footer: string read FFooter write FFooter;
    property Orientation: TPrintOrientationOption read FOrientation write FOrientation;
  end;

  TEmbeddedWB = class(TWebbrowser, IDocHostShowUI, IDocHostUIHandler,
      IDocHostUIHandler2, IDispatch, IServiceProvider
{$IFDEF USE_IOLECOMMANDTARGET}, IOleCommandTarget{$ENDIF})
  private
{$IFDEF VER120UPUP}
    SaveMessage: TMessageEvent;
{$ENDIF}
    FUserAgent: string;
    FReplaceCaption: Boolean;
    FHideBorders: Boolean;
    FHideScrollBars: Boolean;
    FPrintOptions: TPrintOPtions;
    FDownloadControlOptions: TDownloadControlOptions;
    FUserInterfaceOptions: TUserInterfaceOptions;
{$IFDEF USE_IOLECOMMANDTARGET}
    FOnUnload: TUnloadEvent;
    FOnRefresh: TRefreshEvent;
    //FOnProgressChange: TProgressChange;
    FOnScriptError: TScriptErrorEvent;
{$ENDIF}
    //FProgressBar: TProgressBar;
    DDEHWnd: THandle;
    FDisableRightClickMenu: Boolean;
    FDownloadOptionValue: Longint;
    FEnableDDE: Boolean;
    FfpExceptions: Boolean;
    FHelpFile: string;
    FOldWindowProc: TWndMethod;
    FOnCloseQuery: TCloseQueryEvent;
    FOnEnableModeless: TEnableModelessEvent;
    FOnFilterDataObject: TFilterDataObjectEvent;
    FOnGetDropTarget: TGetDropTargetEvent;
    FOnGetExternal: TGetExternalEvent;
    FOnGetHostInfo: TGetHostInfoEvent;
    FOnGetIDsOfNames: TGetIDsOfNamesEvent;
    FOnGetOptionKeyPath: TGetOptionKeyPathEvent;
    FOnGetOverrideKeyPath: TGetOverrideKeypathEvent;
    FOnGetTypeInfo: TGetTypeInfoEvent;
    FOnGetTypeInfoCount: TGetTypeInfoCountEvent;
    FOnHideUI: THideUIEvent;
    FOnInvoke: TInvokeEvent;
    FOnOnDocWindowActivate: TOnDocWindowActivateEvent;
    FOnOnFrameWindowActivate: TOnFrameWindowActivateEvent;
    FOnQueryService: TQueryServiceEvent;
    FOnResizeBorder: TResizeBorderEvent;
    FOnShowContextMenu: TShowcontextmenuEvent;
    FOnShowDialog: TShowDialogEvent;
    FOnShowHelp: TShowHelpEvent;
    FOnShowMessage: TShowMessageEvent;
    FOnShowUI: TShowUIEvent;
    FOnTranslateAccelerator: TTranslateAcceleratorEvent;
    FOnTranslateUrL: TTranslateUrlEvent;
    FOnUpdateUI: TUpdateUIEvent;
    FParentForm: TForm;
    FUserInterfaceValue: Cardinal;
    OldWBWndProc: TWndMethod;
    RuntimeMeasure: TMeasure;
    function DownloadFile(SourceFile, DestFile: string): Boolean;
    procedure DDEWndProc(var AMsg: Messages.TMessage);
    procedure FormWndProc(var AMsg: Messages.TMessage);  //kkk
    procedure GetPrintValues;
    procedure Hook;
    procedure RemoveUserAgent;
    procedure SetDownloadOptions(const Value: TDownloadControlOptions);
    procedure SetfpExceptions(const Value: Boolean);
    procedure SetUserAgent;
    procedure SetUserInterfaceOptions(const Value: TUserInterfaceOptions);
    procedure UnHook;
    procedure UpdateDownloadControlValue;
    procedure UpdateUserInterfaceValue;
  protected
    function DDETerminate(iwParam: WPARAM; ilParam: LPARAM): BOOL;
    function DDEInitiate(iwParam: WPARAM; ilParam: LPARAM): LRESULT;
    function DDEExecute(iwParam: WPARAM; ilParam: LPARAM): LRESULT;
    function GetOverrideKeyPath(pchKey: POLESTR; dw: DWORD): HRESULT; stdcall;

{$IFDEF USE_IOLECOMMANDTARGET}
    function QueryStatus(CmdGroup: PGUID; cCmds: Cardinal;
      prgCmds: POleCmd; CmdText: POleCmdText): HResult; stdcall;
    function Exec(CmdGroup: PGUID; nCmdID, nCmdexecopt: DWORD;
      const vaIn: OleVariant; var vaOut: OleVariant): HResult; stdcall;
{$ENDIF}
    function ShowContextMenu(const dwID: DWORD; const ppt: PPOINT;
      const pcmdtReserved: IUnknown; const pdispReserved: IDispatch): HRESULT; stdcall;
    function GetHostInfo(var pInfo: TDOCHOSTUIINFO): HRESULT; stdcall;
    function ShowUI(const dwID: DWORD; const pActiveObject: IOleInPlaceActiveObject;
      const pCommandTarget: IOleCommandTarget; const pFrame: IOleInPlaceFrame;
      const pDoc: IOleInPlaceUIWindow): HRESULT; stdcall;
    function HideUI: HRESULT; stdcall;
    function UpdateUI: HRESULT; stdcall;
    function EnableModeless(const fEnable: BOOL): HRESULT; stdcall;
    function OnDocWindowActivate(const fActivate: BOOL): HRESULT; stdcall;
    function OnFrameWindowActivate(const fActivate: BOOL): HRESULT; stdcall;
    function ResizeBorder(const prcBorder: PRECT;
      const pUIWindow: IOleInPlaceUIWindow;
      const FrameWindow: BOOL): HRESULT; stdcall;
    function TranslateAccelerator(const lpMsg: PMSG; const pguidCmdGroup: PGUID;
      const nCmdID: DWORD): HRESULT; stdcall;
    function GetOptionKeyPath(var pchKey: POLESTR; const dw: DWORD): HRESULT; stdcall;
    function GetDropTarget(const pDropTarget: IDropTarget;
      out ppDropTarget: IDropTarget): HRESULT; stdcall;
    function GetExternal(out ppDispatch: IDispatch): HRESULT; stdcall;
    function TranslateUrl(const dwTranslate: DWORD; const pchURLIn: POLESTR;
      var ppchURLOut: POLESTR): HRESULT; stdcall;
    function FilterDataObject(const pDO: IDataObject;
      out ppDORet: IDataObject): HRESULT; stdcall;
    function ShowMessage(hwnd: THandle;
      lpstrText: POLESTR; lpstrCaption: POLESTR; dwType: longint; lpstrHelpFile: POLESTR;
      dwHelpContext: longint; var plResult: LRESULT): HRESULT; stdcall;
    function ShowHelp(hwnd: THandle; pszHelpFile: POLESTR; uCommand: integer;
      dwData: longint; ptMouse: TPoint;
      var pDispatchObjectHit: IDispatch): HRESULT; stdcall;
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
{$IFDEF VER120UPUP}
    procedure IEMessageHandler(var Msg: TMsg; var Handled: Boolean);
{$ENDIF}
    function QueryService(const rsid, iid: TGuid; out Obj): HResult; stdcall;
    function OpenClient(Client: string): Boolean;
    function PrintMarginStr(M: Real): PChar;
  public
    SecurityManager: IInternetSecurityManager;
    ZoneManager: IInternetZoneManager;
    function AddHtmlToAboutBlank(StringToHtml: string): Boolean;
    function CheckOnlineStatus: Boolean;
    function CheckIfInTrustedList(URL: string): Boolean;
    function CheckIfInRestricredList(URL: string): Boolean;
    function DesignMode(): boolean;
    function FillForm(FieldName: string; Value: string): Boolean;
    function GetCachedFileFromURL(strUL: string; var strLocalFile: string): boolean;
    function GetCookie: string;
    function GetCookiesPath: string;
    function GetDefaultBrowserFromRegistry :String;
    function GetFavoritesPath: string;
    function GetHistoryPath: string;
    function GetIEHomePage : string;
    function GetIEHandle(WebBrowser: TEmbeddedWB; ClassName: string): HWND;
    function GetLastVisitedPage(var LastVisitedPage: string): boolean;
    function GetIPAndHostName(var HostName, IPaddr, WSAErr: string): Boolean;
    function GetSpecialFolderPath(CallerHandle: THandle; CSIDL: Integer): PChar;
    function GetBmpFromBrowser(FileName : string): Boolean;
    function GetJpegFromBrowser(FileName: string; SourceHeight, SourceWidth,
             TargetHeight , TargetWidth: integer): Boolean;
    function GetZoneAttributes(const URL: string): TZoneAttributes;
    function GetURLSecurityZone(var ZoneName, ZoneDescription: string;var Icon: TIcon):boolean;
    function GetSSLStatus(var SSLName, SSLDescription: string):boolean;
    function GetZoneIconToForm: boolean;
    function SaveLastVisitedPage: boolean;
    function OpenAddressBook: Boolean;
    function OpenCalendar: Boolean;
    function OpenEudoraMail: Boolean;
    function OpenGoogleMail: Boolean;
    function OpenHotmailMail: Boolean;
    function OpenNetMeeting: Boolean;
    function OpenNewsClient: Boolean;
    function OpenOutlookExpressMail: Boolean;
    function OpenOutlookMail: Boolean;
    function OpenRegistryEditor: Boolean;
    function OpenYahooMail: Boolean;
    function SearchThisText(const Value: String; Const iPos : Integer=1): IHTMLTxtRange; //by JJM
    function URLFromFavorites(const dotURL: string): string;
    function UrlFromHistory(ShellFolder: IShellFolder; pidl: PItemIDList): string;
    function VariantIsObject(const value: OleVariant): boolean;
    procedure AutoFillIEFormAndExcecute;
    procedure AddToRestrictedSiteList(URL: string);
    procedure AddToTrustedSiteList(URL: string);
    procedure AddToFavorites(URL, Title: string);
    procedure AssignDocument;
    procedure ClearCache;
    procedure ClearHistory;
    procedure ClearTypedUrls;
    procedure Copy;
    procedure CreateDesktopShortcut;
    procedure CreateNewMail;
    procedure Cut;
    procedure ExploreFolder(Path: string);
    procedure GetZoneIcon(IconPath: string; var Icon: TIcon);
    procedure Go(Url: string);
    procedure GoAboutBlank;
    //procedure GoDownloadFile(URL: string);
    procedure GoDownloadMaskedFile(SourceFile, TargetFile: string ;Notify: boolean);
    procedure GoSearchInGoogle(SearchTerm: string);
    procedure GoSearchInMSN(SearchTerm: string);
    procedure GoSearchInYahoo(SearchTerm: string);
    procedure NavigateFolder(CSIDL: Integer);
    procedure NavigatePidl(pidl: PItemIdlist);
    //procedure GoWithoutTracks(const URL: string);
    procedure GoWithQueryDetails(Url, Query: string);
    procedure InvokeCMD(InvokeIE: Boolean; Value1, Value2: Integer; var vaIn, vaOut: OleVariant);
    procedure OpenDialog;
    procedure OpenIEBrowserWithAddress;
    procedure OpenOtherWBFavorites;
    procedure PageSetup(UsePrintOptions: Boolean);
    procedure Paste;
    procedure Print;
    procedure PrintSetup;
    procedure SaveDialog;
    procedure RestoreApplicationFormSize;
    procedure SaveApplicationFormSize;
    procedure SaveImagesDialog;
    procedure SavePageTextDialog;
    procedure ScrollToBottom;
    procedure ScrollToPosition(X, Y : integer);
    procedure ScrollToTop;
    procedure SetFocusToDoc;
    procedure SearchAndHighlight;
    procedure SelectAll;
    procedure SendPageInMailAsAttachment(FileName: string);
    procedure SendURLInMail;
    procedure SetNewHomePage(HomePage: string);
    procedure ShowFindDialog;
    procedure ShowIEVersionInfo;
    procedure ShowInternetOptions;
    procedure ShowOrgenizeFavorites;
    procedure ShowImportExportFavoritesAndCookies;
    procedure ShowPageProperties;
    procedure ViewPageFieldsToStrings(FieldList: TStrings);
    procedure ViewPageImagesToStrings(ImagesList: TStrings);
    procedure ViewPageLinksToStrings(LinksList: TStrings);
    procedure ViewPagePropertiesToStrings(PropertiesList: TStrings);
    procedure ViewPageSourceHtml;
    procedure ViewPageSourceText;
    procedure ViewPageSourceTextToStrings(TextList: TStrings);
    procedure ViewPageSourceHtmlToStrings(HtmlList: TStrings);
    procedure WBWndProc(var Message: Messages.TMessage);
 {$IFDEF VER120UPUP}
    procedure EnableMessagehandler;
    procedure DisableMessagehandler;
 {$ENDIF}
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    function DocumentLoaded: Boolean;
    function FrameCount: LongInt;
    function GetFrame(FrameNo: Integer): IWebbrowser2;
    function IsGlobalOffline: boolean;
    function LoadFrameFromStream(FrameNo: Integer; AStream: TStream): HRESULT;
    function LoadFrameFromStrings(Frameno: Integer; const AStrings: TStrings): HResult;
    function LoadFromStream(const AStream: TStream): HRESULT;
    function LoadFromStrings(const AStrings: TStrings): HRESULT;
    function SaveFrameToFile(FrameNo: Integer; const Fname: string): HRESULT;
    function SaveFrameToStream(FrameNo: Integer; AStream: TStream): HRESULT;
    function SaveFrameToStrings(FrameNo: Integer; AStrings: TStrings): HRESULT;
    function SaveToFile(const Fname: string): HRESULT;
    function SaveToStream(AStream: TStream): HRESULT;
    function SaveToStrings(AStrings: TStrings): HRESULT;
    function SetCharartersSet(const ACharactersSet: string): Boolean;
    function ZoomRangeHigh : Integer;
    function ZoomRangeLow : Integer;
    function ZoomValue : Integer;
    procedure GetThumbnail(var Image: TImage);
    procedure Loaded; override;
    procedure PrintPreView;
    procedure PrintWithOptions;
    procedure WorkOffline;
    procedure WorkOnline;
    procedure Zoom(ZoomValue: Integer);
  published
  //  property ProgressBar: TProgressBar read FProgressBar write FProgressBar;
    property DownloadOptions: TDownloadControlOptions read FDownloadControlOptions write SetDownloadOptions;
    property UserInterfaceOptions: TUserInterfaceOptions read FUserInterfaceOptions write SetUserInterfaceOptions;
{$IFDEF USE_IOLECOMMANDTARGET}
    property OnRefresh: TRefreshEvent read FOnRefresh write FOnRefresh;
  //  property OnProgressChange: TProgressChange read FOnProgressChange write FOnProgressChange;
    property OnScriptError: TScriptErrorEvent read FOnScriptError write FOnScriptError;
    property OnUnload: TUnloadEvent read FOnUnload write FOnUnload;
{$ENDIF}
    property DisableRightClickMenu: Boolean read FDisableRightClickMenu write FDisableRightClickMenu;
    property EnableDDE: Boolean read FEnableDDE write FEnableDDE;
    property fpExceptions: Boolean read FfpExceptions write SetfpExceptions;
    property HelpFile: string read FHelpFile write FHelpFile;
    property HideBorders: Boolean read FHideBorders write FHideBorders;
    property HideScrollBars: Boolean read FHideScrollBars write FHideScrollBars;
    property OnCloseQuery: TCloseQueryEvent read FOnCloseQuery write FOnCloseQuery;
    property OnEnableModeless: TEnableModelessEvent read FOnEnableModeless write FOnEnableModeless;
    property OnFilterDataObject: TFilterDataObjectEvent read FOnFilterDataObject write FOnFilterDataObject;
    property OnGetDropTarget: TGetDropTargetEvent read FOnGetDropTarget write FOnGetDropTarget;
    property OnGetExternal: TGetExternalEvent read FOnGetExternal write FOnGetExternal;
    property OnGetHostInfo: TGetHostInfoEvent read FOnGethostinfo write fongethostinfo;
    property OnGetIDsOfNames: TGetIDsOfNamesEvent read FOnGetIDsOfNames write FOnGetIdsOfNames;
    property OnGetOptionKeyPath: TGetOptionKeyPathEvent read FOnGetOptionKeyPath write FOnGetOptionKeyPath;
    property OnGetOverrideKeyPath: TGetOVerrideKeypathEvent read FOnGetOverrideKeyPath write FOnGetOverrideKeyPath;
    property OnGetTypeInfo: TGetTypeInfoEvent read FonGetTypeInfo write FOnGetTypeInfo;
    property OnGetTypeInfoCount: TGetTypeInfoCountEvent read FonGetTypeInfoCount write FOnGetTypeInfoCount;
    property OnHideUI: THideUIEvent read FOnHideUI write FOnHideUI;
    property OnInvoke: TInvokeEvent read FOnInvoke write FOnInvoke;
    property OnOnDocWindowActivate: TOnDocWindowActivateEvent read FOnOnDocWindowActivate write FOnOnDocWindowActivate;
    property OnOnFrameWindowActivate: TOnFrameWindowActivateEvent read FOnOnFrameWindowActivate write FOnOnFrameWindowActivate;
    property OnQueryService: TQueryServiceEvent read FOnQueryService write FOnQueryService;
    property OnResizeBorder: TResizeBorderEvent read FOnResizeBorder write FOnResizeBorder;
    property OnShowContextMenu: TShowContextMenuEvent read FOnShowContextmenu write FOnShowContextmenu;
    property OnShowDialog: TShowDialogEvent read FOnShowDialog write FOnShowDialog;
    property OnShowHelp: TShowHelpEvent read FOnShowHelp write FOnShowHelp;
    property OnShowMessage: TShowMessageEvent read FOnShowMessage write FOnShowMessage;
    property OnShowUI: TShowUIEvent read FOnShowUI write FOnShowUI;
    property OnTranslateAccelerator: TTranslateAcceleratorEvent read FOnTranslateAccelerator write FOnTranslateAccelerator;
    property OnTranslateUrl: TTranslateUrlEvent read FOnTranslateUrL write FOnTranslateUrL;
    property OnUpdateUI: TUpdateUIEvent read FOnUpdateUI write FOnUpdateUI;
    property PrintOptions: TPrintOptions read FPrintOptions write FPrintOptions;
    property ReplaceCaption: Boolean read FReplaceCaption write FReplaceCaption;
    property UserAgent: string read FUserAgent write FUserAgent;
 end;
    function RegisterMIMEFilter(clsid: TGUID; MIME: PWideChar): HRESULT;
    function UnregisterMIMEFilter(MIME: PWideChar): HRESULT;
    function RegisterNameSpace(clsid: TGUID): HRESULT;
    function UnregisterNameSpace: HRESULT;

procedure Register;

implementation

uses
  comobj, SendMail, winSock, var_, UnitMain, Public;
var
  Saved8087CW: Word;
  PrintingWithOptions: Boolean;
  InvokingPagesetup: Boolean;
  MimeFactory, NSFactory: IClassFactory;
  MimeInternetSession, NSInternetSession: IInternetSession;
  DontRespond: Boolean;
  OpenFolder, ExploreFolder: string;
  FoldersApp, FoldersTopic: string;
  FindFolder: string;
  HtmlFileApp, HtmlFileTopic: string;
  fHtmlCommand: Boolean;
{$IFDEF VER120UPUP}
  bMsgHandler: Boolean;
{$ENDIF}

function OrganizeFavorite(h: THandle; path: PChar): Boolean; stdcall external 'shdocvw.dll' Name 'DoOrganizeFavDlg';

procedure TEmbeddedWB.GetThumbnail(var Image: TImage);
var
  DrawRect: TRect;
begin
  if Image = nil then exit;
  DrawRect := Rect(0, 0, Image.Height, Image.width);
  Image.Picture.Bitmap.Height := image.height;
  Image.Picture.Bitmap.Width := image.Width;
  ({$IFDEF VER120UPUP}Application_{$ELSE} Application{$ENDIF}
  as IviewObject).Draw(DVASPECT_DOCPRINT, 0, nil, nil, 0,
    image.Canvas.Handle, @DrawRect, nil, nil, 0);
    Image.Refresh;
end;

procedure TEmbeddedWB.SetfpExceptions(const Value: Boolean);
begin
  if not Value then begin
    Set8087CW($133F);
    FfpExceptions := False;
  end
  else
  begin
    Set8087CW(Saved8087CW);
    FfpExceptions := True;
  end;
end;

function TEmbeddedwb.GetFrame(FrameNo: Integer): IWebbrowser2;
var
  OleContainer: IOleContainer;
  enum: ActiveX.IEnumUnknown;
  unk: IUnknown;
  Fetched: PLongint;
begin
  while ReadyState <> READYSTATE_COMPLETE do
    Forms.Application.ProcessMessages;
  if Assigned(document) then
  begin
    Fetched := nil;
    OleContainer := Document as IOleContainer;
    OleContainer.EnumObjects(OLECONTF_EMBEDDINGS, Enum);
    Enum.Skip(FrameNo);
    Enum.Next(1, Unk, Fetched);
    Result := Unk as IWebbrowser2;
  end else Result := nil;
end;

{
Ver. 1.16:
Thanks to Brian Lowe for Fixing OLE-problem in function FrameCount:
http://groups.yahoo.com/group/delphi-webbrowser/message/4194
}

function TEmbeddedWB.FrameCount: LongInt;
var
  OleContainer: IOleContainer;
  enum: ActiveX.IEnumUnknown;
  unk: array[0..99] of IUnknown; // CHANGED from "unk: IUnknown;"
  EnumResult: HRESULT;
begin
  while ReadyState <> READYSTATE_COMPLETE do
    Forms.Application.ProcessMessages;
  if Assigned(document) then
  begin
    OleContainer := Document as IOleContainer;
    EnumResult := OleContainer.EnumObjects(OLECONTF_EMBEDDINGS, Enum);
    if EnumResult = S_OK then // Added per OLE help
      Enum.Next(100, Unk, @Result)
    else // Added per OLE help
      Enum := nil;
  end else
    Result := 0;
end;

procedure TEmbeddedWB.SetUserAgent;
var
  reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings\User Agent\Post Platform', True)
      then Reg.WriteString(FUserAgent, '');
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

procedure TEmbeddedWB.RemoveUserAgent;
var
  reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings\User Agent\Post Platform', FALSE)
      then reg.DeleteValue(FUseragent);
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

function GetDDEVariables: Boolean;
var
  s: string;
  Reg: TRegistry;
begin
  Reg := Tregistry.Create;
  with Reg do try
    RootKey := HKEY_CLASSES_ROOT;
    OpenKey('htmlfile\shell\open\ddeexec\application', False);
    HtmlFileApp := Readstring('');
    CloseKey;
    OpenKey('htmlfile\shell\open\ddeexec\topic', FALSE);
    HtmlFileTopic := ReadString('');
    CloseKey;
    OpenKey('Folder\shell\open\ddeexec\application', False);
    FoldersApp := Readstring('');
    CloseKey;
    OpenKey('Folder\shell\open\ddeexec\topic', FALSE);
    FoldersTopic := ReadString('');
    CloseKey;
    OpenKey('Folder\shell\open\ddeexec', False);
    s := readString('');
    CloseKey;
    S := Copy(S, Pos('[', S) + 1, length(S));
    OpenFolder := Copy(s, 1, Pos('(', S) - 1);
    OpenKey('Folder\shell\explore\ddeexec', False);
    s := readString('');
    CloseKey;
    S := Copy(S, Pos('[', S) + 1, length(S));
    ExploreFolder := Copy(s, 1, Pos('(', S) - 1);
    OpenKey('Directory\shell\find\ddeexec', False);
    s := readString('');
    CloseKey;
    S := Copy(S, Pos('[', S) + 1, length(S));
    FindFolder := Copy(s, 1, Pos('(', S) - 1);
    Result := True;
  except
    Result := False;
  end;
  Reg.Free;
end;

function GetCommandTypeFromDDEString(szCommand: string): UINT;
begin
  szCommand := Copy(szCommand, Pos('[', szCommand) + 1, length(szCommand));
  szCommand := Copy(szCommand, 1, Pos('(', szCommand) - 1);
  if szCommand = Openfolder then Result := VIEW_COMMAND else
    if szCommand = Explorefolder then Result := EXPLORE_COMMAND else
      if szCommand = Findfolder then Result := FIND_COMMAND else
        Result := NO_COMMAND;
end;

function GetPathFromDDEString(szCommand: string; var szFolder: string): Boolean;
begin
  szCommand := Copy(szCommand, Pos('"', szCommand) + 1, length(szCommand));
  szFolder := Copy(szCommand, 1, Pos('"', szCommand) - 1);
  Result := (szFolder <> '');
end;

function GetPidlFromDDEString(szCommand: string): PItemIDList;
var
  pidlShared, pidlGlobal: PItemIDList;
  dwProcessID: Integer;
  hShared: THandle;
  s: string;
  ProcessID: string;
  i: Integer;
begin
  s := Copy(szCommand, Pos(',', szCommand) + 1, length(szCommand));
  i := 1;
  while not (s[i] in IsDigit) and (i <= Length(s)) do Inc(i);
  processID := Copy(s, i, Length(S));
  s := copy(S, i, length(s) - 1);
  i := 1;
  while (s[i] in IsDigit) and (i <= Length(s)) do Inc(i);
  s := copy(S, 1, i - 1);

  while not ((ProcessID[i] = ':') or (ProcessID[i] = ',')) and (i <= Length(processID)) do Inc(i);
  if ProcessID[i] = ':' then
  begin
    ProcessID := Copy(ProcessID, i, Length(ProcessID));
    i := 1;
    while not (ProcessID[i] in IsDigit) and (i <= Length(ProcessID)) do Inc(i);
    ProcessID := Copy(ProcessID, i, Length(ProcessID));
    i := 1;
    while (ProcessID[i] in IsDigit) and (i <= Length(ProcessID)) do Inc(i);
    if not (ProcessID[i] in IsDigit) then ProcessID := Copy(ProcessID, 1, i - 1);
  end else ProcessID := '0';
  dwProcessID := StrToInt(ProcessID);
  if dwProcessID <> 0 then begin
    hShared := StrToInt(s);
    pidlShared := ShLockShared(hShared, dwProcessId);
    if PidlShared <> nil then
    begin
      Result := CopyPidl(PidlShared);
      ShUnlockShared(pidlShared);
    end else Result := nil;
    ShFreeShared(hShared, dwProcessID);
  end else
  begin
    pidlGlobal := PItemIDList(StrToInt(s));
    Result := CopyPidl(pidlGlobal);
    _Free(pidlGlobal);
  end;
end;

function GetShowCmdFromDDEString(szCommand: string): Integer;
var
  i: Integer;
begin
  i := 1;
  while szCommand[i] <> ',' do Inc(i);
  Inc(i);
  while szCommand[i] <> ',' do Inc(i);
  szCommand := Copy(szCommand, i, Length(szCommand));
  i := 0;
  repeat
    inc(i)
  until (i > Length(szCommand)) or (szCommand[i] in IsDigit);
  if i <= length(szCommand) then result := StrtoInt(szCommand[i]) else
    result := 1;
end;


function ParseDDECommand(szCommand: string; var szFolder: string; var pidl: PItemIDList; var show: Integer): UINT;
begin
  Result := GetCommandTypeFromDDEString(szCommand);
  if Result <> NO_COMMAND then begin
    GetPathFromDDEString(szCommand, szFolder);
    pidl := GetPidlFromDDEString(szCommand);
    Show := GetShowCmdFromDDEString(szCommand);
  end;
end;

function TEmbeddedwb.DDETerminate(iwParam: WPARAM; ilParam: LPARAM): BOOL;
begin
  Result := PostMessage(THandle(iwParam), WM_DDE_TERMINATE, handle, 0);
end;

function TEmbeddedWB.DDEInitiate(iwParam: WPARAM; ilParam: LPARAM): LRESULT;
var
  dwThreadID: DWORD;
  dwProcessID: DWORD;
  hwndClient: Integer;
  aInApp, aInTopic, aOutApp, aOutTopic: ATOM;
  szInAppName,  szInAppTopic: array[0..255] of Char;
begin
  FillChar(szInAppName, SizeOf(szInAppName), 0);
  FillChar(szInAppTopic, SizeOf(szInAppTopic), 0);
  if DontRespond then
  begin
    result := 0;
    exit;
  end;
  hwndClient := THandle(iwParam);
  dwThreadID := GetWindowThreadProcessId(hwndClient, @dwProcessID);
  if (GetCurrentProcessId() <> dwProcessID) or (GetCurrentThreadID() <> dwThreadID) then
  begin
    result := 0;
    exit;
  end;
  aInApp := LOWORD(ilParam);
  aInTopic := HIWORD(ilParam);
  GlobalGetAtomName(aInApp, szInAppName, SizeOf(szInAppName));
  GlobalGetAtomName(aInTopic, szInAppTopic, SizeOf(szInAppTopic));
  if szInAppName = HtmlFileApp then
  begin
    fHtmlCommand := True;
    aOutApp := GlobalAddAtom(PChar(HtmlFileApp));
    aOutTopic := GlobalAddAtom(PChar(HtmlFileTopic));
    if ((aOutApp <> 0) and (aOutTopic <> 0) and (aOutApp = aInApp) and (aOutTopic = aInTopic)) then
      SendMessage(hwndClient, WM_DDE_ACK, WPARAM(handle), MAKELPARAM(aOutApp, aOutTopic));
    if (aOutApp <> 0) then GlobalDeleteAtom(aOutApp);
    if (aOutTopic <> 0) then GlobalDeleteAtom(aOutTopic);
  end
  else
  begin
    fHtmlCommand := False;
    aOutApp := GlobalAddAtom(PChar(FoldersApp));
    aOutTopic := GlobalAddAtom(PChar(FoldersTopic));
    if ((aOutApp <> 0) and (aOutTopic <> 0) and (aOutApp = aInApp) and (aOutTopic = aInTopic)) then
      SendMessage(HWNDClient, WM_DDE_ACK, WPARAM(Handle), MAKELPARAM(aOutApp, aOutTopic));
    if (aOutApp <> 0) then GlobalDeleteAtom(aOutApp);
    if (aOutTopic <> 0) then GlobalDeleteAtom(aOutTopic);
  end;
  result := 0;
end;

function TEmbeddedwb.DDEExecute(iwParam: WPARAM; ilParam: LPARAM): LRESULT;
var
  szFolder: string;
  szCommand: LPTSTR;
  uLo: PUINT;
  hgMem: HGLOBAL;
  ack: DDEACK;
  lpTemp: PUINT;
  uCommand: Cardinal;
  show: Integer;
  pidl: PITEMIDLIST;
  sei: TShellExecuteInfo;
  szTmp: string;
begin
  ulo := nil;
  if UnpackDDElParam(WM_DDE_EXECUTE, ilParam, uLo, @hgMem)
    then begin
    szCommand := GlobalLock(hgmem);
    ZeroMemory(@Ack, sizeof(ddeAck));
    if (szCommand <> nil) then
    begin
      if fHtmlCommand then
      begin
        szTmp := szCommand;
        if Pos('"', szTmp) = 1 then
        begin
          Delete(szTmp, 1, 1);
          szTmp := System.Copy(szTmp, 1, Pos('"', szTmp) - 1);
        end;
        Go(szTmp);
        Ack.flags := 1;
      end
      else
      begin
        uCommand := ParseDDECommand(szCommand, szFolder, pidl, Show);
        case uCommand of
          VIEW_COMMAND:
            begin

              if (szFolder <> '') then Go(szFolder)
              else
                if (pidl <> nil) then NavigatePidl(pidl);
              DisposePidl(pidl);
              Ack.flags := 1;
            end;
          EXPLORE_COMMAND:
            begin
              DontRespond := TRUE;
              ZeroMemory(@sei, sizeof(SHELLEXECUTEINFO));
              sei.cbSize := sizeof(SHELLEXECUTEINFO);
              if szFolder <> '' then begin
                sei.fMask := SEE_MASK_CLASSNAME;
                sei.lpFile := Pchar(szFolder);
              end else
              begin
                sei.fMask := SEE_MASK_IDLIST or SEE_MASK_CLASSNAME;
                sei.lpIDList := pidl;
              end;
              sei.lpClass := 'folder';
              sei.Wnd := 0;
              sei.nShow := Show;
              sei.lpVerb := 'explore';
              ShellExecuteEx(@sei);
              DontRespond := FALSE;
              DisposePidl(pidl);
              Ack.flags := 1;
            end;
          FIND_COMMAND:
            begin
              DontRespond := TRUE;
              ZeroMemory(@sei, sizeof(SHELLEXECUTEINFO));
              sei.cbSize := sizeof(SHELLEXECUTEINFO);
              if (szFolder <> '')
                then begin
                sei.fMask := 0;
                sei.lpFile := PChar(szFolder);
              end
              else
              begin
                sei.fMask := SEE_MASK_IDLIST;
                sei.lpIDList := pidl;
              end;
              sei.wnd := 0;
              sei.nShow := Show;
              sei.lpVerb := 'find';
              ShellExecuteEx(@sei);
              DontRespond := FALSE;
              DisposePidl(pidl);
              Ack.flags := 1;
            end;
        end;
      end;
      GlobalUnlock(hgMem);
      lpTemp := @Ack;
      PostMessage(Thandle(iwParam),
        WM_DDE_ACK,
        WPARAM(handle),
        ReuseDDElParam(ilParam, WM_DDE_EXECUTE, WM_DDE_ACK, lpTemp^, hgMem));
    end;
  end;
  Result := 0;
end;

procedure TEmbeddedwb.PrintWithOptions;
begin
  PrintingWithOptions := True;
  Pagesetup(TRUE);
  Print;
end;

procedure TembeddedWB.GetPrintValues;
var
  S: string;
  regWinRegistry: TRegistry;

function ReadMargin(key: string): Real;
    begin
         S := RegwinRegistry.ReadString(key);
      if S = '' then S:='0.750000'; // <-- default margin value  by takeru_tk_81 
         S := Stringreplace(S, ' ', '', [rfReplaceAll]);
      if DecimalSeparator <> '.' then
         S := Stringreplace(S, '.', DecimalSeparator, []);
      if Printoptions.Measure = mMetric then
         result := StrtoFloat(S) * InchToMetric else
         result := StrtoFloat(S);
    end;

begin
  regWinRegistry := TRegistry.Create;
  try
    with regWinRegistry do begin
         RootKey := HKEY_CURRENT_USER;
      if OpenKey('Software\Microsoft\Internet Explorer\PageSetup', False) then
      begin
         PrintOptions.Header := Readstring('header');
         PrintOptions.Footer := ReadString('footer');
         PrintOptions.Margins.left := ReadMargin('margin_left');
         PrintOptions.Margins.right := ReadMargin('margin_right');
         PrintOptions.Margins.top := ReadMargin('margin_top');
         PrintOptions.Margins.bottom := ReadMargin('margin_bottom');
      end;
      regWinRegistry.Free;
    end;
  except
     MessageDlg('Error while getting page print values from the registry!', mtError, [mbOK], 0);
  end;
end; 

procedure TEmbeddedWB.Loaded;
begin
  inherited Loaded;
  CoInternetCreateSecuritymanager(self, SecurityManager, 0);
  CoInternetCreateZoneManager(self, ZoneManager, 0);
  UpdateDownloadControlValue;
  UpdateUserInterfaceValue;
  hook;
  if not (csDesigning in ComponentState) then
  begin
    OldWBWndProc := WindowProc;
    if not AddressFocus then
    WindowProc := WBWndProc;    //kkk
    SetUserAgent;
  end else
  begin
    PrintOptions.FMeasure := RunTimeMeasure;
    GetPrintValues;
  end;
end;

function TEmbeddedWB.PrintMarginStr(M: Real): PChar;
var
  S: string;
begin
  if printOptions.Measure <> RuntimeMeasure
    then begin
    if RuntimeMeasure = mMetric then
      s := FloatToStr(M * InchToMetric) else
      s := FloatToStr(M / InchToMetric);
    Result := PChar(S);
  end else Result := PChar(FloatToStr(M));
end;


constructor TEmbeddedWb.Create(Owner: TComponent);
var
  Buf: array[1..10] of Char;
begin
  FfpExceptions := True;
  inherited;
{$IFDEF VER120UPUP}
  enablemessagehandler;
{$ENDIF}
  GetDDEVariables;
 {$IFDEF DELPHI_6_UP}
  {$WARN SYMBOL_DEPRECATED OFF}
 {$ENDIF}
  DDEHWnd := AllocateHWnd(DDEWndProc);
{$IFDEF DELPHI_6_UP}
  {$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}
  FPrintOptions := TPrintOptions.Create;
  FPrintOptions.Margins := TMargins.Create;
  FPrintOptions.FHTMLHeader := TStringlist.Create;
  FPrintOptions.FHTMLHeader.Add('<HTML></HTML>');
  FillChar(Buf, SizeOf(Buf), 0);
  GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_IMEASURE, @Buf[1], SizeOf(Buf));
  if Buf[1] = '1' then RunTimeMeasure := mUS else
     RunTimeMeasure := mMetric;
  DownloadOptions := [DLCTL_DLIMAGES, DLCTL_BGSOUNDS, DLCTL_VIDEOS];
  UserInterfaceOptions := [];
  FEnableDDE := False;
  FDisableRightClickMenu := False;
  UpdateUserInterfaceValue;
end;



destructor TEmbeddedWb.Destroy;
begin
  {$IFDEF DELPHI_6_UP}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$ENDIF}
  DeAllocateHWnd(DDEHwnd);
  {$IFDEF DELPHI_6_UP}
  {$WARN SYMBOL_DEPRECATED ON}
  {$ENDIF}
  FPrintOptions.HTMLHeader.Free;
  FPrintoptions.Margins.Free;
  FPrintoptions.Free;
  unhook;
  RemoveUserAgent;
{$IFDEF VER120UPUP}
  disablemessagehandler;
{$ENDIF}
  inherited;
end;

function RegisterMIMEFilter(clsid: TGUID; MIME: PWideChar): HRESULT;
begin
  CoGetClassObject(Clsid, CLSCTX_SERVER, nil, IClassFactory, MimeFactory);
  CoInternetGetSession(0, MimeInternetSession, 0);
  Result := MIMEInternetSession.RegisterMimeFilter(MimeFactory, Clsid, MIME);
end;

function UnregisterMIMEFilter(MIME: PWideChar): HRESULT;
begin
  Result := MIMEInternetSession.UnregisterMimeFilter(MIMEFactory, MIME);
end;

function RegisterNameSpace(clsid: TGUID): HRESULT;
begin
  CoGetClassObject(Clsid, CLSCTX_SERVER, nil, IClassFactory, NSFactory);
  CoInternetGetSession(0, NSInternetSession, 0);
  Result := NSInternetSession.RegisterNameSpace(NSFactory, Clsid, 'http', 0, nil, 0);
end;

function UnregisterNameSpace: HRESULT;
begin
  Result := NSInternetSession.UnregisterNameSpace(NSFactory, 'http');
end;

procedure TEmbeddedWB.Hook;
begin
  if (csDesigning in ComponentState) then exit;
  FParentform := TForm(Owner);
  if (FParentForm <> nil) and (FParentForm.HandleAllocated) then
  begin
    FOldWindowProc := FParentForm.WindowProc;
    FParentForm.WindowProc := FormWndProc;     //kkkk
  end;
end;

procedure TEmbeddedWB.UnHook;
begin
  if (csDesigning in ComponentState) then exit;
  if (FParentForm <> nil) and (FParentForm.HandleAllocated) then
    FParentForm.WindowProc := FOldWindowProc;
//  FOldWindowProc := nil;
  FParentform := nil;
end;

procedure TEmbeddedWB.DDEWndProc(var AMsg: Messages.TMessage);
begin
  with AMsg do
    if (Msg = WM_DDE_INITIATE) and FEnableDDE
      then DDEInitiate(wparam, lparam)
    else
      Result := DefWindowProc(DDEHWND, msg, wParam, lParam);
end;

//{  //kkk
procedure TEmbeddedWB.FormWndProc(var AMsg: Messages.TMessage);
var
  i: Integer;
  wnd: Integer;
  S: string;
  Msg: TWmActivate;
begin
try
  if AMsg.Msg = WM_ENDSESSION then
  begin
    try
    //MessageBox(0, 'haha.', '', 0);
    //FormMain.BShutDownKill.Click;
    //KillProcess(PChar(ExtractFileName(ParamStr(0))));
    AppCloseHint := false;
    FormMain.Close;
    ShutDown;
    finally
    KillProcess(PChar(ExtractFileName(ParamStr(0))));
    Halt;   //kkk
    end;
  end else
  if AMsg.Msg = WM_ACTIVATE then begin
    Msg := TWmActivate(AMsg);
    if Msg.Active = 0 then
    begin
      wnd := Msg.ActiveWindow;
      SetLength(S, 80);
      SetLength(S, GetClassName(Wnd, PChar(S), Length(S)));
      if (S = '#32770') then
      begin
        if ReplaceCaption then
        begin
          SendMessage(wnd, WM_SETICON, ICON_SMALL, Forms.Application.Icon.Handle);
          I := GetWindowTextLength(wnd);
          SetLength(S, I + 1);
          GetWindowText(Wnd, PChar(S), I + 1);
          S := StringReplace(S, 'Microsoft ', '', []);
          S := StringReplace(S, 'Internet Explorer', Forms.Application.Title, []);
          SetWindowText(Wnd, Pchar(S));
        end;
        if InvokingPageSetup then
        begin
          InvokingPagesetup := False;
          if PrintingWithOptions then
          begin
            SetWindowPos(0, 0, -600, 0, 0, 0, 0); //SetWindowPos(Wnd, 0, -600, 0, 0, 0, 0);  //kkk default self
            PrintingWithOptions := False;
          end;
          if PrintOptions.Orientation = poPortrait then
            SendDlgItemMessage(Wnd, $0420, BM_CLICK, 0, 0) else
            SendDlgItemMessage(Wnd, $0421, BM_CLICK, 0, 0);
            SetDlgItemText(wnd, $1FD3, PChar(PrintOptions.Header));
            SetDlgItemText(wnd, $1FD5, PChar(PrintOptions.Footer));
            SetDlgItemText(wnd, $0483, PrintMarginStr(PrintOptions.Margins.Left));
            SetDlgItemText(wnd, $0484, PrintMarginStr(PrintOptions.Margins.top));
            SetDlgItemText(wnd, $0485, PrintMarginStr(PrintOptions.Margins.Right));
            SetDlgItemText(wnd, $0486, PrintMarginStr(PrintOptions.Margins.Bottom));
          if (Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion > 4) then
            PostMessage(FindWindowEx(wnd, 0, Pchar('Button'), nil), BM_CLICK, 0, 0) //Win2000
          else SendDlgItemMessage(Wnd, 1, BM_CLICK, 0, 0);
        end;

      end;        
      if not PrintingWithOptions and (wnd <> 0) and Assigned(FOnShowDialog) then
              FOnShowDialog(self, Wnd);
    end;
  end;
  FOldWindowProc(AMsg);
except end;
end;
//}

function TEmbeddedWB.QueryService(const rsid, iid: TGuid; out Obj): HResult;
begin
  if Assigned(FOnQueryService) then
     Result := FOnQueryService(rsid, iid, IUnknown(obj)) else
     Result := E_NOINTERFACE;
end;

function TEmbeddedWB.OpenOutlookMail: Boolean;
begin
   result := true;
   ShellExecute(Handle, 'open', PChar('outlook.exe'), nil, nil, SW_SHOW);
end;

function TEmbeddedWB.OpenOutlookExpressMail: Boolean;
begin
   result := true;
   ShellExecute(Handle, 'open', PChar('MSIMN.EXE'), nil, nil, SW_SHOW);
end;

function TEmbeddedWB.OpenEudoraMail: Boolean;
begin
   result := true;
   ShellExecute(Handle, 'open', PChar('Eudora.EXE'), nil, nil, SW_SHOW);
end;

function TEmbeddedWB.OpenHotmailMail: Boolean;
begin
   result := true;
   Navigate('http://lc1.law5.hotmail.passport.com/cgi-bin/login');
end;

function TEmbeddedWB.OpenGoogleMail: Boolean;
begin
   result := true;
   Navigate('http://mail.google.com/mail/');
end;

function TEmbeddedWB.OpenYahooMail: Boolean;
begin
   result := true;
   Navigate('http://mail.yahoo.com/');
end;
function TEmbeddedWB.OpenRegistryEditor: Boolean;
begin
   result := true;
   ShellExecute(Handle, 'open', PChar('regedit.exe'), nil, nil, SW_SHOW);
end;

function TEmbeddedWB.OpenNewsClient: Boolean;
begin
  result := OpenClient('News');
end;

function TEmbeddedWB.OpenAddressBook: Boolean;
begin
   result := true;
   ShellExecute(Handle, 'open', PChar('wab.exe'), nil, nil, SW_SHOW);
end;

function TEmbeddedWB.OpenCalendar: Boolean;
begin
  result := OpenClient('Calendar');
end;

function TEmbeddedWB.OpenNetMeeting: Boolean;
begin
  result := OpenClient('Internet Call');
end;

function TEmbeddedWB.CheckOnlineStatus: Boolean;
 var
  dwConnectionTypes: Integer;
begin
 try
     dwConnectionTypes := INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN + INTERNET_CONNECTION_PROXY;
  if InternetGetConnectedState(@dwConnectionTypes, 0) then
     Result := true
  else
     Result := false;
 except
     Result := false;
 end;
end;

function TEmbeddedWB.OpenClient(Client: string): Boolean;
var
  s, params, Exec: string;
begin
  Result := FALSE;
  with TRegistry.Create do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey('Software\Clients\' + Client, FALSE);
    S := ReadString('');
    CloseKey;
    OpenKey('Software\Clients\' + Client + '\' + S + '\shell\open\command', FALSE);
    S := ReadString('');
    CloseKey;
    if S <> '' then begin
      if Pos('/', S) > 0 then begin
        Exec := system.Copy(S, 1, Pos('/', S) - 2);
        Params := system.Copy(s, Length(exec) + 1, length(S));
      end else begin
        Exec := S;
        Params := '';
      end;
      Result := TRUE;
      shellExecute(handle, 'open', Pchar(Exec), pChar(Params), '', SW_SHOW);
    end;
  finally
    Free;
  end;
end;

procedure TEmbeddedWB.PrintPreView;
// IE 5.5 only
var
  vaIn, vaOut: Olevariant;
begin
    ControlInterface.ExecWB(OLECMDID_PRINTPREVIEW, OLECMDEXECOPT_DONTPROMPTUSER, vaIn, vaOut);
 // InvokeCmd(FALSE, OLECMDID_PRINTPREVIEW, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
end;

procedure TEmbeddedWB.SetDownloadOptions(const Value:
  TDownloadControlOptions);
begin
  FDownloadControlOptions := Value;
  UpdateDownloadControlValue;
{$IFDEF VER120UPUP}(Application_ as IOleControl).OnAmbientPropertyChange(DISPID_AMBIENT_DLCONTROL);
{$ELSE}
  (Application as IOleControl).OnAmbientPropertyChange(DISPID_AMBIENT_DLCONTROL);
{$ENDIF}
end;

procedure TEmbeddedWB.SetUserInterfaceOptions(const Value:
  TUserInterfaceOptions);
begin
  FUserInterfaceOptions := Value;
  UpdateUserInterfaceValue;
{$IFDEF VER120UPUP}(Application_ as IOleControl).OnAmbientPropertyChange(DISPID_AMBIENT_DLCONTROL);
{$ELSE}
  (Application as IOleControl).OnAmbientPropertyChange(DISPID_AMBIENT_DLCONTROL);
{$ENDIF}
end;

procedure TEmbeddedWB.UpdateDownloadControlValue;
const
  acardDownloadControlValues: array[TDownloadControlOption] of Cardinal =
  ($00000010, $00000020, $00000040, $00000080,
    $00000100, $00000200, $00000400, $00000800,
    $00001000, $00002000, $00004000, $00008000,
    $00010000, $00020000, $00040000, $10000000,
    $20000000, $40000000, $80000000);
var
  i: TDownloadControlOption;
begin
  FDownloadOptionValue := 0;
  if (FDownloadControlOptions <> []) then
    for i := Low(TDownloadControlOption) to High(TDownloadControlOption)
      do
      if (i in FDownloadControlOptions) then
        Inc(FDownloadOptionValue, acardDownloadControlValues[i]);
end;

procedure TEmbeddedWB.UpdateUserInterfaceValue;
const
  acardUserInterfaceValues: array[TUserInterfaceOption] of Cardinal =
  ($00000001, $00000002, $00000004, $00000008,
    $00000010, $00000020, $00000040, $00000080,
    $00000100, $00000200, $00000400, $00000800,
    $00001000, $00002000, $00004000, $00010000, $00020000,
    $00040000, $00080000, $00100000, $00200000);
var
  i: TUserInterfaceOption;
begin
  FUserInterfaceValue := 0;
  if HideBorders then
   FUserInterfaceOptions :=[NO3DOUTERBORDER, NO3DBORDER] + FUserInterfaceOptions
  else FUserInterfaceOptions := FUserInterfaceOptions - [NO3DOUTERBORDER, NO3DBORDER];

  if HideScrollbars then
   FUserInterfaceOptions :=[SCROLL_NO]+ FUserInterfaceOptions
  else FUserInterfaceOptions := FUserInterfaceOptions - [SCROLL_NO];

  if (FUserInterfaceOptions <> []) then
    for  i := Low(TUserInterfaceOption) to High(TUserInterfaceOption) do
       if (i in FUserInterfaceOptions) then
          Inc(FUserInterfaceValue, acardUserInterfaceValues[i]);
end;

function TEmbeddedWB.URLFromFavorites(const dotURL: string): string;
begin
   with TIniFile.Create(dotURL) do
   try
     try
       Result := ReadString('InternetShortcut', 'URL', '') ;
     except;
       Result := '';
     end;
   finally
     Free;
   end;
end;

function TEmbeddedWB.GetBmpFromBrowser(FileName : String): Boolean;
var
  ViewObject: IViewObject;
  sourceDrawRect: TRect;
  ScreenImg : TImage;
begin
  result := false;
  if Document <> nil then
  try
    Document.QueryInterface(IViewObject, ViewObject);
    if ViewObject <> nil then
      try
        ScreenImg := TImage.Create(Self);
        ScreenImg.Height := Height ;
        ScreenImg.Width  := Width;
        sourceDrawRect := Rect(0, 0, ScreenImg.Width, ScreenImg.Height);
        ViewObject.Draw(DVASPECT_CONTENT, 1, nil, nil, Self.Handle,
        ScreenImg.Canvas.Handle, @sourceDrawRect, nil, nil, 0);
        ScreenImg.Picture.SaveToFile(FileName);
        result := true;
      finally
        ViewObject._Release;
     //   ScreenImg.free;
      end;
  except
    result := false;
  end;
end;

function TEmbeddedWB.GetJPEGfromBrowser(FileName: string; SourceHeight, SourceWidth,
                                  TargetHeight, TargetWidth: integer): Boolean;
var
  sourceDrawRect: TRect;
  targetDrawRect: TRect;
  sourceBitmap  : Graphics.TBitmap;
  targetBitmap  : Graphics.TBitmap;
  aJPG          : TJPEGImage;
  aViewObject   : IViewObject;
  Browser       : iWebBrowser2;
begin
  result := false;
  sourceBitmap := Graphics.TBitmap.Create;
  targetBitmap := Graphics.TBitmap.Create;
  aJPG         := TJPEGImage.Create;
  Browser      := ControlInterface;
  try
    try
      sourceDrawRect := Rect(0, 0, SourceWidth, SourceHeight);
      sourceBitmap.Width := SourceWidth;
      sourceBitmap.Height := SourceHeight;
      aViewObject := Browser as IViewObject;
      if aViewObject=nil then Exit;
      OleCheck(aViewObject.Draw(DVASPECT_CONTENT, 1, nil, nil,
                               Forms.Application.Handle,
                               sourceBitmap.Canvas.Handle,
                               @sourceDrawRect, nil, nil, 0));
      targetDrawRect := Rect(0, 0, TargetWidth, TargetHeight);
      targetBitmap.Height := TargetHeight;
      targetBitmap.Width := TargetWidth;
      targetBitmap.Canvas.StretchDraw(targetDrawRect, sourceBitmap);
      aJPG.Assign(targetBitmap);
      aJPG.SaveToFile(FileName);
      result:= true;
    finally
      aJPG.Free;
      sourceBitmap.Free;
      targetBitmap.Free;
    end;
  except
     result := false;
  end;
end;

function TEmbeddedWB.GetSpecialFolderPath(CallerHandle: THandle; CSIDL: Integer): PChar;
var
  exInfo : TShellExecuteInfo;
  Buf    : PChar;
begin
   FillChar(exInfo, SizeOf(exInfo), 0);
 with exInfo do
  begin
    cbSize := SizeOf(exInfo);
    fMask  := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_IDLIST;
    Wnd    := CallerHandle;
    nShow  := SW_SHOWNORMAL;
    Buf    := StrAlloc(MAX_PATH);
    SHGetSpecialFolderPath(wnd, Buf, CSIDL, True);
    Result := Buf;
  end;
end;

procedure TEmbeddedWB.GetZoneIcon(IconPath: string; var Icon: TIcon);
var
  FName, ImageName: string;
  h: hInst;
begin
  FName := System.Copy(IconPath, 1, Pos('#', IconPath) - 1);
  ImageName := System.Copy(IconPath, Pos('#', IconPath), Length(IconPath));
  h := LoadLibrary(Pchar(FName));
  try
    if h <> 0 then
    begin
      Icon.Handle := LoadImage(h, Pchar(ImageName), IMAGE_ICON, 16, 16, 0);
    end;
  finally
    FreeLibrary(h);
  end;
end;

function TEmbeddedWB.GetZoneAttributes(const URL: string): TZoneAttributes;
var
  dwZone: Cardinal;
  ZoneAttr: TZoneAttributes;
var
  ZoneManager: IInternetZoneManager;
  SecManager: IInternetSecurityManager;
begin
  ZeroMemory(@ZoneAttr, SizeOf(TZoneAttributes));
  if CoInternetCreateSecuritymanager(nil, SecManager, 0) = S_OK then
    if CoInternetCreateZoneManager(nil, ZoneManager, 0)  = S_OK then
    begin
      SecManager.MapUrlToZone(PWideChar(WideString(URL)), dwZone, 0);
      ZoneManager.GetZoneAttributes(dwZone, Result);
    end;
end;

function TEmbeddedWB.GetZoneIconToForm: boolean;
 var
  ZoneAttr: TZoneAttributes;
  ZoneIcon: TIcon;
begin
  ZoneAttr := GetZoneAttributes(LocationURL);
  ZoneIcon := TIcon.Create;
  try
    GetZoneIcon(ZoneAttr.szIconPath, ZoneIcon);
    Caption := ZoneAttr.szDisplayName;
    Hint := ZoneAttr.szDisplayName;
    Forms.Application.Icon := ZoneIcon;
  finally
    ZoneIcon.Free;
  end;
result := true;
end;

function TEmbeddedWB.GetUrlSecurityZone(var ZoneName, ZoneDescription: string;var Icon: TIcon):boolean;
var
  ZoneAttr: TZoneAttributes;
  ZoneIcon: TIcon;
begin
  ZoneAttr := GetZoneAttributes(LocationURL);
  ZoneIcon := TIcon.Create;
  try
    GetZoneIcon(ZoneAttr.szIconPath, ZoneIcon);
    ZoneName := ZoneAttr.szDisplayName;
    ZoneDescription := ZoneAttr.szDescription;
    icon := ZoneIcon;
    result := true;
 except
    result := false;
  end;
end;

function TEmbeddedWB.GetSSLStatus(var SSLName, SSLDescription: string):boolean;
begin
   result:= false;
   if (Pos('http://', LocationURL)  > 0) then
     begin
       if Oleobject.Document.Location.Protocol = 'https:' then
         begin
           SSLName        := 'SSL';
           SSLDescription := 'It is a secure web page.';
           result         := true;
         end;
     end
       else
        begin
           SSLName        := 'None';
           SSLDescription := 'The page is not secured.';
           result         := false;
        end
end;

function TEmbeddedWB.UrlFromHistory(ShellFolder: IShellFolder; pidl: PItemIDList): string;
var
  Handle : THandle;
  Info   : IQueryInfo;
  W      : PWideChar;
begin
  Handle := 0;
  Info   := nil;
  ShellFolder.GetUIObjectOf(Handle, 1, pidl, IID_IQUERYINFO, nil, Pointer(Info));
  if assigned(Info) then
    begin
      Info.GetInfoTip(0, w);
       Result := W;
    end
      else result  := '';
  Result := Trim(System.Copy(Result, Pos(#10, Result) + 1, length(Result)));
end;

function TEmbeddedWB.VariantIsObject(const value: OleVariant): boolean;
begin
  result := (VarType(value) = varDispatch);
end;

function TEmbeddedWB.DocumentLoaded: Boolean;
var
  iDoc: IHtmlDocument2;
begin
     Result := False;
  if Document <> nil then
    begin
      ControlInterface.Document.QueryInterface(IHtmlDocument2, iDoc);
      Result := Assigned(iDoc);
    end;
end;

function TEmbeddedWB.IsGlobalOffline: boolean;
var
  dwState: DWORD;
  dwSize: DWORD;
begin
  dwState := 0;
  dwSize := SizeOf(dwState);
  result := false;
  if (InternetQueryOption(nil, INTERNET_OPTION_CONNECTED_STATE, @dwState,
    dwSize)) then
    if ((dwState and INTERNET_STATE_DISCONNECTED_BY_USER) <> 0) then
      result := true;
end; 

procedure TEmbeddedWB.OpenOtherWBFavorites;
begin
   if FileExists('c:\' + 'newbook.htm') then
      navigate('c:\newbook.htm')
 else MessageDlg('We can not locate the file, sorry.'
 +#10+#13+ 'Please use "Open URL" in the toolbar to locate the file', mtCustom, [mbOK], 0);
end;

procedure TEmbeddedWB.WorkOffline;
const
  INTERNET_STATE_DISCONNECTED_BY_USER = $10;
  ISO_FORCE_DISCONNECTED = $1;
  INTERNET_STATE_CONNECTED = $1;
 var
  btn : Integer;
  ci: TInternetConnectedInfo;
  dwSize: DWORD;
begin
   btn := MessageDlg('You are choosing to work Offline!',mtWarning, mbOKCancel, 0);
   if btn = mrCancel then exit;
   dwSize := SizeOf(ci);
   ci.dwConnectedState := INTERNET_STATE_DISCONNECTED_BY_USER;
   ci.dwFlags := ISO_FORCE_DISCONNECTED;
   InternetSetOption(nil, INTERNET_OPTION_CONNECTED_STATE, @ci, dwSize);
end;

procedure TEmbeddedWB.WorkOnline;
const
  INTERNET_STATE_DISCONNECTED_BY_USER = $10;
  ISO_FORCE_DISCONNECTED = $1;
  INTERNET_STATE_CONNECTED = $1;
 var
  btn : Integer;
  ci: TInternetConnectedInfo;
  dwSize: DWORD;
begin
  btn := MessageDlg('You are choosing to work Online',mtInformation, mbOKCancel, 0);
  if btn = mrCancel then exit;
  dwSize := SizeOf(ci);
  ci.dwFlags := 0;
  ci.dwConnectedState := INTERNET_STATE_CONNECTED;
  InternetSetOption(nil, INTERNET_OPTION_CONNECTED_STATE, @ci, dwSize);
end;

function SaveDocToStream(Doc: IDispatch; var AStream: TStream): HResult;
var
  IpStream: IPersistStreamInit;
begin
  if Doc <> nil then begin
    IpStream := Doc as IPersistStreamInit;
    Result := IpStream.save(TStreamAdapter.Create(AStream), TRUE);
  end else Result := S_FALSE;
end;


function TEmbeddedWB.SaveToStream(AStream: TStream): HRESULT;
begin
  while ReadyState <> READYSTATE_COMPLETE do
    Forms.Application.ProcessMessages;
  if Assigned(Document) then
    Result := SaveDocToStream(Document, AStream)
  else Result := S_FALSE;
end;

function SaveDocToStrings(Doc: IDispatch; var AStrings: TStrings): HResult;
var
  IpStream: IPersistStreamInit;
  AStream: TMemoryStream;
begin
  AStream := TMemoryStream.Create;
  try
    IpStream := doc as IPersistStreamInit;
    if not Assigned(IpStream) then Result := S_FALSE else
      if Succeeded(IpStream.save(TStreamadapter.Create(AStream), TRUE))
        then begin
        AStream.Seek(0, 0);
        AStrings.LoadFromStream(AStream);
        Result := S_OK;
      end else Result := S_FALSE;
  except
    Result := S_FALSE;
  end;
  AStream.Free;
end;

function TEmbeddedwb.SaveFrameToStream(FrameNo: Integer; AStream: TStream): HRESULT;
var
  iw: IWebbrowser2;
begin
  Result := S_FALSE;
  iw := Getframe(frameNo);
  if (iw <> nil) and assigned(iw.Document) then
    Result := SaveDocToStream(iw.Document, AStream)
end;

procedure TEmbeddedwb.SearchAndHighlight;
var
  aText : string;
  tr: IHTMLTxtRange;
begin
    while ReadyState <> READYSTATE_COMPLETE do
    Forms.Application.ProcessMessages;
if InputQuery('Browser - Search and Highlight', 'Please enter your search term.', aText) then
  begin
    tr := ((Document as IHTMLDocument2).body as IHTMLBodyElement).createTextRange;
   while tr.findText(aText, 1, 0) do
    begin
      tr.pasteHTML('<span style="background-color: Lime; font-weight: bolder;">' +
      tr.htmlText + '</span>');
      tr.scrollIntoView(True);
    end;
    end
    else;
end;

function TEmbeddedwb.SaveFrameToStrings(FrameNo: Integer; AStrings: TStrings): HRESULT;
var
  iw: Iwebbrowser2;
begin
  Result := S_FALSE;
  iw := Getframe(frameNo);
  if (iw <> nil) and assigned(iw.Document) then
    Result := SaveDocToStrings(iw.Document, AStrings);
end;

function TEmbeddedwb.SaveFrameToFile(FrameNo: Integer; const Fname: string): HRESULT;
var
  Iw: IWebbrowser2;
  PFile: IPersistFile;
begin
  iw := Getframe(frameNo);
  if (iw <> nil) and assigned(iw.Document) then begin
    PFile := iw.Document as IPersistFile;
    Result := PFile.Save(StringToOleStr(FName), False);
  end else Result := S_FALSE;
end;


function SaveDocToFile(Doc: IDispatch; const Fname: string): HResult;
var
  PFile: IPersistFile;
begin
  PFile := Doc as IPersistFile;
  Result := PFile.Save(StringToOleStr(FName), False);
end;


function TEmbeddedWB.SaveToFile(const Fname: string): HRESULT;
begin
  while ReadyState <> READYSTATE_COMPLETE do
    Forms.Application.ProcessMessages;
  if Assigned(Document) then
  begin
    Result := SaveDocToFile(Document, FName);
  end else Result := S_FALSE;
end;

function TEmbeddedWB.SetCharartersSet(const ACharactersSet: string): Boolean;
var
  RefreshLevel: OleVariant;
begin
  Result := False;
 while ReadyState <> READYSTATE_COMPLETE do
       Forms.Application.ProcessMessages;
  try
    MSHTML.IHTMLDocument2(Document).Set_CharSet(ACharactersSet);
    Result := True;
    RefreshLevel := 7;
    Refresh2(RefreshLevel);
  except
  end;
end;

function TEmbeddedWB.GetCookie: string;
begin
  Result := '';
  while ReadyState <> READYSTATE_COMPLETE do
  Forms.Application.ProcessMessages;
  Result := OleObject.document.cookie;
end;

function TEmbeddedWB.GetCookiesPath: String;
var
  Reg : TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', False) then
       Result :=Reg.ReadString('Cookies');
  finally
    Reg.CloseKey;
    Reg.Free;
  End;
end;

function TEmbeddedWB.GetHistoryPath: String;
var
  Reg : TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', False) then
       Result := Reg.ReadString('History');
  finally
    Reg.CloseKey;
    Reg.Free;
  End;
end;

function TEmbeddedWB.GetFavoritesPath: String;
var
  Reg : TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', False) then
       Result :=Reg.ReadString('Favorites');
  finally
    Reg.CloseKey;
    Reg.Free;
  End;
end;

function TEmbeddedWB.GetDefaultBrowserFromRegistry :String;
var
  Reg: TRegistry;
  KeyName: string;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CLASSES_ROOT;
    KeyName  := 'htmlfile\shell\open\command';
    if Reg.OpenKey(KeyName, False) then
    begin
      Result := Reg.ReadString('');
      Reg.CloseKey;
     end
    else
      Result:= 'No Default Webbrowser!';
  finally
    Reg.Free;
  end;
end;

function TEmbeddedWB.GetIPAndHostName(var HostName, IPaddr, WSAErr: string): Boolean;
type
  Name = array[0..100] of Char;
  PName = ^Name;
var
  HEnt: pHostEnt;
  HName: PName;
  WSAData: TWSAData;
  i: Integer;
begin
  Result := False;
  if WSAStartup($0101, WSAData) <> 0 then begin
    WSAErr := 'Winsock is not responding."';
    Exit;
  end;
  IPaddr := '';
  New(HName);
  if GetHostName(HName^, SizeOf(Name)) = 0 then
  begin
    HostName := StrPas(HName^);
    HEnt := GetHostByName(HName^);
    for i := 0 to HEnt^.h_length - 1 do
     IPaddr :=
      Concat(IPaddr,
      IntToStr(Ord(HEnt^.h_addr_list^[i])) + '.');
    SetLength(IPaddr, Length(IPaddr) - 1);
    Result := True;
  end
  else begin
   case WSAGetLastError of
    WSANOTINITIALISED:WSAErr:='WSANotInitialised';
    WSAENETDOWN      :WSAErr:='WSAENetDown';
    WSAEINPROGRESS   :WSAErr:='WSAEInProgress';
   end;
  end;
  Dispose(HName);
  WSACleanup;
end;

function TEmbeddedWB.SaveToStrings(AStrings: TStrings): HRESULT;
begin
  while ReadyState <> READYSTATE_COMPLETE do
    Forms.Application.ProcessMessages;
  if Assigned(document) then
    Result := SaveDocToStrings(Document, AStrings)
  else Result := S_FALSE;
end;

function TEmbeddedWb.LoadFrameFromStrings(Frameno: Integer; const AStrings: TStrings): HResult;
var
  iw: IWebbrowser2;
  M: TMemoryStream;
begin
  Result := S_FALSE;
  iw := GetFrame(Frameno);
  if (iw <> nil) and assigned(iw.document) then begin
    M := TMemoryStream.Create;
    try
      AStrings.SaveToStream(M);
      M.seek(0, 0);
      Result := (iw.Document as IPersistStreamInit).Load(TStreamadapter.Create(M));
    except
      Result := S_FALSE;
    end;
    M.free;
  end;
end;

function TEmbeddedWb.LoadFromStrings(const AStrings: TStrings): HResult;
var
  M: TMemoryStream;
begin
  if not Assigned(document) then AssignDocument;
  M := TMemoryStream.Create;
  try
    AStrings.SaveToStream(M);
    Result := LoadFromStream(M);
  except
    Result := S_FALSE;
  end;
  M.free;
end;

function TEmbeddedWb.LoadFrameFromStream(FrameNo: Integer; AStream: TStream): HRESULT;
var
  iw: IWebbrowser2;
begin
  Result := S_FALSE;
  iw := Getframe(frameNo);
  if (iw <> nil) then if Assigned(iw.Document) then
    begin
      AStream.seek(0, 0);
      Result := (iw.Document as IPersistStreamInit).Load(TStreamadapter.Create(AStream));
    end;
end;

function TEmbeddedWb.LoadFromStream(const AStream: TStream): HRESULT;
begin
  if not Assigned(Document) then AssignDocument;
  AStream.seek(0, 0);
  Result := (Document as IPersistStreamInit).Load(TStreamadapter.Create(AStream));
end;

function TEmbeddedWb.AddHtmlToAboutBlank(StringToHtml: string): Boolean;
var
  Flags, TargetFrameName, PostData, Headers: OleVariant;
begin
  Navigate('about:' + StringToHtml, Flags, TargetFrameName, PostData, Headers);
  result:= true;
end;

function TEmbeddedWB.SearchThisText(const Value: String; Const iPos : Integer=1): IHTMLTxtRange;
begin //by JJM
  Result := Nil;
  Try
    Forms.Application.ProcessMessages;
    While (ReadyState < READYSTATE_INTERACTIVE) And (Not DocumentLoaded) Do
     Forms.Application.ProcessMessages;
    if Assigned((Document as IHTMLDocument2).body) then
    begin
      Result := ((Document as IHTMLDocument2).body as IHTMLBodyElement).CreateTextRange;
      if Result.findText(Value, iPos, 0) then
       Result.ScrollIntoView(True)
      else
       Result := Nil;
    end;
  Except
   On e:Exception do;
  end;
end;


function TEmbeddedWb.FillForm(FieldName: string; Value: string): Boolean;
var
  I, j     : Integer;
  FormItem : Variant;
begin
  Result := False;
  if OleObject.Document.all.tags('FORM').Length = 0 then
  begin
    Exit;
  end;
  for I := 0 to OleObject.Document.forms.Length - 1 do
  begin
    FormItem := OleObject.Document.forms.Item(I);
    for j := 0 to FormItem.Length - 1 do
    begin
      try
        if FormItem.Item(j).Name = FieldName then
        begin
          FormItem.Item(j).Value := Value;
          Result := True;
        end;
      except
        Exit;
      end;
    end;
  end;
end;

procedure  TEmbeddedWb.AutoFillIEFormAndExcecute;
var
 // hIE: HWND;
  ShellWindow: IShellWindows;
  WB: IWebbrowser2;
  spDisp: IDispatch;
  IDoc1: IHTMLDocument2;
  Document: Variant;
  k, m: Integer;
  ovElements: OleVariant;
  i: Integer;
begin
  ShellWindow := CoShellWindows.Create;
  // get the running instance of Internet Explorer
  for k := 0 to ShellWindow.Count do
  begin
    spDisp := ShellWindow.Item(k);
    if spDisp = nil then Continue;
    // QueryInterface determines if an interface can be used with an object
    spDisp.QueryInterface(iWebBrowser2, WB);

    if WB <> nil then
    begin
      WB.Document.QueryInterface(IHTMLDocument2, iDoc1);
      if iDoc1 <> nil then
      begin
        WB := ShellWindow.Item(k) as IWebbrowser2;
        begin
          Document := WB.Document;

          // count forms on document and iterate through its forms
          for m := 0 to Document.forms.Length - 1 do
          begin
            ovElements := Document.forms.Item(m).elements;
            // iterate through elements
            for i := 0 to ovElements.Length - 1 do
            begin
              // when input fieldname is found, try to fill out
              try
                if (CompareText(ovElements.item(i).tagName, 'INPUT') = 0) and
                   (CompareText(ovElements.item(i).type, 'text') = 0) then
                begin
                  ovElements.item(i).Value := 'FindWindow';
                end;
              except
              end;
              // when Submit button is found, try to click
              try
                if (CompareText(ovElements.item(i).tagName, 'INPUT') = 0) and
                   (CompareText(ovElements.item(i).type, 'SUBMIT') = 0) and
                   (ovElements.item(i).Value = 'Search') then  // Suchen für German
                begin
                  ovElements.item(i).Click;
                end;
              except
              end;
            end;
          end;
        end;
      end;
    end;
  end;

end;


function TEmbeddedWb.GetCachedFileFromURL(strUL: string; var strLocalFile: string): boolean;
var
  lpEntryInfo: PInternetCacheEntryInfo;
  hCacheDir: LongWord;
  dwEntrySize: LongWord;
  dwLastError: LongWord;
begin
  Result := False;
  dwEntrySize := 0;
  // Begin the enumeration of the Internet cache.
  FindFirstUrlCacheEntry(nil, TInternetCacheEntryInfo(nil^), dwEntrySize);
  GetMem(lpEntryInfo, dwEntrySize);
  hCacheDir := FindFirstUrlCacheEntry(nil, lpEntryInfo^, dwEntrySize);
  if (hCacheDir <> 0) and (strUL = lpEntryInfo^.lpszSourceUrlName) then
  begin
    strLocalFile := lpEntryInfo^.lpszLocalFileName;
    Result := True;
  end;
  FreeMem(lpEntryInfo);
  if Result = False then
    repeat
      dwEntrySize := 0;
      // Retrieves the next cache group in a cache group enumeration
      FindNextUrlCacheEntry(hCacheDir, TInternetCacheEntryInfo(nil^), dwEntrySize);
      dwLastError := GetLastError();
      if (GetLastError = ERROR_INSUFFICIENT_BUFFER) then
      begin
        GetMem(lpEntryInfo, dwEntrySize);
        if (FindNextUrlCacheEntry(hCacheDir, lpEntryInfo^, dwEntrySize)) then
        begin
          if strUL = lpEntryInfo^.lpszSourceUrlName then
          begin
            strLocalFile := lpEntryInfo^.lpszLocalFileName;
            Result := True;
            Break;
          end;
        end;
        FreeMem(lpEntryInfo);
      end;
    until (dwLastError = ERROR_NO_MORE_ITEMS);
end;

procedure TEmbeddedWb.GoSearchInGoogle(SearchTerm: string);
const
  GOOGLE_QUERY = 'http://www.google.com/search?ie=ISO-8859-1&hl=de&q=';
var
  sQuery: string;
begin
  sQuery := GOOGLE_QUERY + SearchTerm;
  Navigate(sQuery);
end;

procedure TEmbeddedWb.GoSearchInMSN(SearchTerm: string);
const
  MSN_QUERY = 'http://search.msn.com/previewx.aspx?q=';
  MSN_Const  = '&FORM=CBPW&first=1&noredir=1';
var
  sQuery: string;
begin
  sQuery := MSN_QUERY + SearchTerm+ MSN_Const;
  Navigate(sQuery);
end;

procedure TEmbeddedWb.GoSearchInYahoo(SearchTerm: string);
const
  YAHOO_QUERY = 'http://search.yahoo.com/bin/search?p=';
var
  sQuery: string;
begin
  sQuery := YAHOO_QUERY + SearchTerm;
  Navigate(sQuery);
end;


procedure TEmbeddedWb.AssignDocument;
begin
  Go('about:blank');
  while readystate <> READYSTATE_COMPLETE do Forms.Application.ProcessMessages;
end;

procedure TEmbeddedWb.SetFocusToDoc;
begin
  if Document <> nil then
    with {$IFDEF VER120UPUP}Application_{$ELSE}Application{$ENDIF} as IOleobject do
      DoVerb(OLEIVERB_UIACTIVATE, nil, Self, 0, Handle, GetClientRect);
end;

{$IFDEF VER120UPUP}

procedure TEmbeddedWb.EnableMessagehandler;
begin
  if not bMsgHandler then
  begin
    SaveMessage := Forms.Application.OnMessage;
    Forms.Application.OnMessage := IeMessagehandler;
    bMsgHandler := True;
  end;
end;


procedure TEmbeddedWB.DisableMessageHandler;
begin
  if bMsgHandler then
  begin
    Forms.Application.onMessage := Savemessage;
    bMsgHandler := False;
  end;
end;
{$ENDIF}


///BEGIN >>>>> Messagehandler by Mathias Walter - walter@coint.de >>>>>///

procedure TEmbeddedWB.WBWndProc(var Message: Messages.TMessage);
const
  StdKeys = [VK_RETURN{, VK_BACK}]; { standard keys }
  ExtKeys = [{VK_LEFT, VK_RIGHT}]; { extended keys }      //kkk
  fExtended = $01000000; { extended key flag }
var
  bClose: Boolean;
{$IFNDEF VER120}
  WinMsg: TMsg;
{$ENDIF}
begin
  with Message do
  begin
{$IFNDEF VER120}  //kkk
    //{
    if (Msg >= (CN_BASE + WM_KEYFIRST)) and (Msg <= (CN_BASE + WM_DEADCHAR)) then
    begin
      WinMsg.hwnd := Handle;
      WinMsg.message := Msg - CN_BASE;
      WinMsg.wParam := wParam;
      WinMsg.lParam := lParam;
      WinMsg.time := GetMessageTime;
      WinMsg.pt.x := $115DE1F1;
      WinMsg.pt.y := $115DE1F1;
      if not ((wParam in StdKeys) or (wParam in ExtKeys) and ((lParam and fExtended) = fExtended)) then
        with Application as IOleInPlaceActiveObject do
          Result := Integer(TranslateAccelerator(WinMsg) = S_OK);
    end
    else
    //}
{$ENDIF}
      case Msg of
        WM_CLOSE: begin
            bClose := True;
            if Assigned(FOnCloseQuery) then
              FOnCloseQuery(Self, bClose);
            if bClose then
              OldWBWndProc(Message);
          end;
        WM_DDE_EXECUTE: DDEExecute(wparam, lparam);
        WM_DDE_TERMINATE: DDETerminate(wparam, lparam);
      else
        OldWBWndProc(Message);
      end;
  end;
end;

{$IFDEF VER120UPUP}

procedure TEmbeddedWB.IEMessageHandler(var Msg: TMsg; var Handled: Boolean);
{ fixes the malfunction of some keys within webbrowser control }
const
  StdKeys = [{VK_TAB, }VK_RETURN]; { standard keys }
  ExtKeys = [VK_DELETE, VK_BACK, VK_LEFT, VK_RIGHT]; { extended keys }  //kkk
  fExtended = $01000000; { extended key flag }
begin
  Handled := False;
  with Msg do
    if ((Message >= WM_KEYFIRST) and (Message <= WM_KEYLAST)) and
      ((wParam in StdKeys) or (GetKeyState(VK_CONTROL) < 0) or
      (wParam in ExtKeys) and ((lParam and fExtended) = fExtended)) then
    try
      if IsChild(Handle, hWnd) then
      { handles all browser related messages }
      begin
     //   with Application_ as IOleInPlaceActiveObject do
      //    Handled := TranslateAccelerator(Msg) = S_OK;
        if not Handled then
        begin
          Handled := True;
          TranslateMessage(Msg);
          DispatchMessage(Msg);
        end;
      end;
    except end;
end; // IEMessageHandler
{$ENDIF}

///END <<<<<< Messagehandler by Mathias Walter - walter@coint.de <<<<<///

procedure TEmbeddedWb.SendUrlInMail;
var
  em_body, em_mail, em_subject, URL, Title : String;
begin
  URL        := LocationURL;
  Title      := LocationName;
  em_subject := 'Check this site';
  em_body := 'I found '+ LocationName + '    In: '+ LocationURL +'   Please Have A look';
  em_mail := 'mailto:?subject=' +
  em_subject + '&body=' + em_body ;
  ShellExecute(Handle,'open',  PChar(em_mail), nil, nil, SW_SHOWNORMAL);
end;

procedure TEmbeddedWb.CreateNewMail;
begin
    SendMessage(Handle, WM_COMMAND, ID_IE_FILE_NEWMAIL, 0);
end;

procedure TEmbeddedWb.CreateDesktopShortcut;
{const
  NotAllowed: set of Char = ['"'] + ['/'] + ['\'] + ['?'] + [':'] + ['*'] +
    ['<'] + ['>'] + ['|'];

function GetSysDir: string;
var
  dir: array [0..MAX_PATH] of Char;
begin
  GetSystemDirectory(dir, MAX_PATH);
  Result := StrPas(dir);
end;
var
  url: TStringList;
  Path, title, b: string;
  i: Integer;
  c: Char;
begin
  Path:= GetSpecialFolderPath(Handle, CSIDL_DESKTOPDIRECTORY);
  url := TStringList.Create;
  try
    url.Add('[InternetShortcut]');
    url.Add('URL=' + LocationURL);
    url.Add('IconIndex=0');
    url.Add('ShowCommand=7');
    title := LocationName;
    b := '';
    for i := 1 to Length(title) do
    begin
      c := title[i];
      if not (c in NotAllowed) then
      begin
        b := b + LocationName[i];
      end;
    end;
    url.SaveToFile(Path + '\' + b + '.url');
  finally
    url.Free;
  end; }
begin
     SendMessage(Handle, WM_COMMAND, ID_IE_FILE_SENDDESKTOPSHORTCUT, 0);
     MessageDlg('A shortcut to:  "' + LocationName+'"  will be placed on your desktop'  ,mtInformation,[mbOK], 0);
end;

procedure TEmbeddedWb.SendPageInMailAsAttachment(FileName: string);
begin
   SaveToFile(FileName);
   Sleep(800);
  with TMAPIMail.Create(Self) do
    try
      Subject := 'My dear friend, I am sending you this web page please have a look.';
      Body := 'Hi,'#13#10#13#10'with best regards';
      Attachments.Add(FileName);
      EditDialog := True;
      Send
    finally
      Free
    end;
end;

procedure TEmbeddedWb.SetNewHomePage(HomePage: string);
begin
 with TRegistry.Create do
  begin
   try
    OpenKey('\Software\Microsoft\Internet Explorer\Main',True);
    WriteString('Start Page', HomePage);
    CloseKey;
  finally
    Free;
  end;
  end;
  MessageDlg('Your new home page is: ' + HomePage ,mtInformation,[mbOK], 0);
end;

function TEmbeddedWb.DesignMode: boolean;
var    {toms}
  HTMLDocument2: IHTMLDocument2;
  Status : string;
begin
    result := false;
    HTMLDocument2 := (Document as IHTMLDocument2);
    if HTMLDocument2 <> nil then
    begin
      Status := HTMLDocument2.get_designMode;
      if Status = 'On' then
      begin
        HTMLDocument2.designMode := 'Off';
        result := false;
      end
      else
      begin
        HTMLDocument2.designMode := 'On';
        result := true;
      end;
    end;
end;

function TEmbeddedWb.GetLastVisitedPage(var LastVisitedPage: string): boolean;
begin
result := false;
 with TRegistry.Create do
   begin
     LastVisitedPage:='';
     RootKey:= HKEY_LOCAL_MACHINE;
     try
     if OpenKey('SOFTWARE\'+Forms.Application.Title+'\WebPages', false)then
       begin
        LastVisitedPage := ReadString('LastVisitedPage');
        CloseKey;
        if (LastVisitedPage <> '') and (AnsiPos('.', LastVisitedPage) > 0) then
            result := true;
       end;
    finally
    Free;
    end;
   end;
end;

function TEmbeddedWb.SaveLastVisitedPage: boolean;
var
  RegPath : string;
begin
   result := false;
   with TRegistry.Create do
    begin
      RootKey:= HKEY_LOCAL_MACHINE;
      RegPath :='SOFTWARE\'+Forms.Application.Title+'\WebPages';
   if OpenKey(RegPath, false) then
      try
       DeleteKey('LastVisitedPage');
      except
      begin
        MessageDlg('Error while writing the Last Visited Page to the registry!'  ,mtError,[mbOK], 0);
        exit;
      end;
      end;
     Free;
   end;
  with TRegIniFile.Create do
  begin
    RootKey:= HKEY_LOCAL_MACHINE;
    RegPath :='SOFTWARE\'+Forms.Application.Title;
 if OpenKey(RegPath, true) then
    try
      WriteString('WebPages', 'LastVisitedPage', LocationURL);
      Result:= true;
    except
       begin
         MessageDlg('Error while writing the Last Visited Page to the registry!'  ,mtError,[mbOK], 0);
       end;
     CloseKey;
     Free;
    end;
 end;
end;

function TEmbeddedWb.GetIEHomePage: string;
var
 HomePage: string;
begin
  with TRegistry.Create do
   try
    RootKey:=HKEY_CURRENT_USER;
    OpenKey('\Software\Microsoft\Internet Explorer\Main',False);
    HomePage:= ReadString('Start Page');
    CloseKey;
  finally
  Free;
  end;
  Result:= HomePage;
end;

{ //kkkkkkkkkkkkkkkkkkk
procedure TEmbeddedWb.GoWithoutTracks(const URL: string);
var
  Flags: OleVariant;
begin
    UpdateUserInterfaceValue;
  Flags := navNoHistory;
    if pos('res://', URL) or pos('file://', URL)
    or pos('about:', URL) or pos('javascript:', URL)
    or pos('mailto:', URL)>0 then
       Flags := Flags or navNoReadFromCache or navNoWriteToCache;
       Navigate(WideString(URL), Flags);
end;
}

procedure TEmbeddedWb.NavigateFolder(CSIDL: Integer);
var
  sFolder: PItemIdList;
begin
  UpdateUserInterfaceValue;
  SHGetSpecialFolderLocation(0, CSIDL, SFolder);
  NavigatePidl(SFolder);
  CoTaskMemFree(SFolder);
end;


procedure TEmbeddedWB.NavigatePidl(pidl: PItemIdList);
var
  VaEmpty, vaPidl: Olevariant;
  psa: PSafeArray;
  cbData: UINT;
begin
  UpdateUserInterfaceValue;
  cbdata := GetPidlSize(pidl);
  psa := SafeArrayCreateVector(VT_UI1, 0, cbData);
  if (psa <> nil) then begin
    CopyMemory(psa.pvData, pidl, cbData);
    VariantInit(vaPidl);
    TVariantArg(vaPidl).vt := VT_ARRAY or VT_UI1;
    TVariantArg(vaPidl).parray := psa;
    Navigate2(vaPidl, vaEmpty, vaEmpty, vaEmpty, vaEmpty);
    VariantClear(vaPidl);
  end;
end;

procedure TEmbeddedWB.Go(Url: string);
var
  _URL, Flags, TargetFrameName, PostData, Headers: Olevariant;
begin
  UpdateUserInterfaceValue;
  _URL := Url;
  Flags := 0; TargetFrameName := 0; Postdata := 0; Headers := 0;
  Navigate2(_URL, Flags, TargetFrameName, PostData, Headers);
end;

procedure TEmbeddedWB.GoWithQueryDetails(Url, Query: string);
var
  _URL, Flags, TargetFrameName, PostData, Headers: Olevariant;
begin
  UpdateUserInterfaceValue;
  _URL := Url + Query;
  TargetFrameName := 0;
  headers  := StringtoVarArray('Content-Type:application/x-www-form-urlencoded'#13#10);
  Postdata := StringToVarArray('version=current&name=myname' + #13#10);
  Flags    := 0;
  Navigate2(_URL, Flags, TargetFrameName, PostData, Headers);
end;

procedure TEmbeddedWb.GoAboutBlank;
begin
  Go('about:blank');
  while readystate <> READYSTATE_COMPLETE do Forms.Application.ProcessMessages;
end;

procedure TEmbeddedWb.GoDownloadMaskedFile(SourceFile, TargetFile: string ;Notify: boolean);
function DownloadFile(SourceFile, TargetFile: string): Boolean;
begin
  try
    Result := UrlDownloadToFile(nil, PChar(SourceFile), PChar(TargetFile), 0, nil) = 0;
  except
    Result := False;
  end;
end;

begin
 if notify then
 begin
  if DownloadFile(SourceFile, TargetFile) then
    MessageBox(Handle, Pchar('Downloading: '+SourceFile+#10+#13+
    'To: '+TargetFile+#10+#13+'Was Succesfully finished.'),
    PChar('Download Succesfull.'), MB_OK)
  else
    MessageBox(Handle, Pchar(
    'An error ocurred while contacting the site for downloading'+SourceFile),
     PChar('Downloading Error!!'), MB_ICONERROR or MB_OK);
  end
  else DownloadFile(SourceFile, TargetFile);
end;

{ //kkkkkkkkkkkkkkkkkkkkkkkkk
procedure TEmbeddedWb.GoDownloadFile(URL: string);
var
  Flags: OleVariant;
begin
  UpdateUserInterfaceValue;
  Flags := navNoHistory or navNoReadFromCache or navNoWriteToCache
           or navAllowAutosearch or navBrowserBar;
  Navigate(URL, Flags);
end;
}

procedure TEmbeddedWB.AddToFavorites(URL, Title: string);
const
  CLSID_ShellUIHelper: TGUID = '{64AB4BB7-111E-11D1-8F79-00C04FC2FBE1}';
var
  ShellUIHelper : ISHellUIHelper;
  Url1, Title1 : Olevariant;
begin
 inherited;
   Title1  := Title;
   Url1    := Url;
   CoCreateInstance(CLSID_SHELLUIHELPER, nil, CLSCTX_INPROC_SERVER, IID_IShellUIHelper, ShellUIHelper);
   ShellUIHelper.AddFavorite(URL1, Title1);
end;

procedure TEmbeddedWB.AddToRestrictedSiteList(URL: string);
var
 st  : string;
 I   : integer;
 Reg : TRegistryIniFile;
begin
  I  := LastDelimiter(':', Url)+2;
  st := System.Copy(Url, I + 1, MaxInt);
  if AnsiPos('www' , st ) > 0 then
  begin
    I  := 4;
    st := System.Copy(st, I + 1, MaxInt);
  end;
  try
   Reg := TRegistryIniFile.Create('\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains');
   Reg.WriteInteger(st, '*', (4));
   Reg.Free;
   except
    begin
      MessageDlg('Error while adding the site to the restricted sites list zone !', mtError,[mbOK], 0);
    end;
  MessageDlg('The page was added to the restricted sites list zone.', mtInformation, [mbOK], 0);
  end;
end;

procedure TEmbeddedWB.AddToTrustedSiteList(URL: string);
var
   Reg: TRegistryIniFile;
begin
 if AnsiPos('https', URL) = 0 then
   MessageDlg('Only sites with https:// prefix (secured sites) can be added to the truested sites list zone!', mtError,[mbOK], 0)
 else 
  begin
  try
   Reg := TRegistryIniFile.Create('\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains');
   Reg.WriteInteger(URL, 'https', (2));
   Reg.Free;
   except
     begin
      MessageDlg('Error while adding the site to the truested sites list zone!'  ,mtError, [mbOK], 0);
     end;
   end;
  MessageDlg('The page was added to the truested sites list zone.'  ,mtInformation, [mbOK], 0);
  end;
end;

function TEmbeddedWB.CheckIfInTrustedList(URL: string): Boolean;
var
   bTrusted: Boolean;
begin
  result := false;
  with TRegistry.Create(KEY_READ) do
  begin
   try
    RootKey := HKEY_CURRENT_USER;
   if Not OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains'+'\'+URL,False)then
      begin
         CloseKey;
         exit;
      end
   else
       bTrusted := ReadInteger('https') = 2;
    if bTrusted then
       result := true
   finally
    CloseKey;
    Free;
   end;
 end;
end;

function TEmbeddedWB.CheckIfInRestricredList(URL: string): Boolean;
var
   bRest: Boolean;
begin
  result := false;
  with TRegistry.Create(KEY_READ) do
  begin
   try
    RootKey := HKEY_CURRENT_USER;
   if not OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains'+'\'+URL,False) then
      begin
        CloseKey;
        exit;
      end
    else
    bRest := ReadInteger('*') = 4;
    if bRest then
       result := true;
   finally
    CloseKey;
    Free;
   end;
 end;
end;

procedure TEmbeddedWB.InvokeCMD(InvokeIE: Boolean; Value1, Value2: Integer; var vaIn, vaOut: OleVariant);
var
  CmdTarget: IOleCommandTarget;
  PtrGUID: PGUID;
begin
  New(PtrGUID);
  if InvokeIE then PtrGUID^ := CLSID_WebBrowser else
    PtrGuid := PGUID(nil);
  if Document <> nil then
  try
    Document.QueryInterface(IOleCommandTarget, CmdTarget);
    if CmdTarget <> nil then
    try
      CmdTarget.Exec(PtrGuid, Value1, Value2, vaIn, vaOut);
    finally
      CmdTarget._Release;
    end;
  except end;
  Dispose(PtrGUID);
end;


procedure TEmbeddedWB.Print;
var
  vaIn, vaOut: Olevariant;
 { HtmlText: string;
  Stream: IStream;
  Dummy: Int64;
  Psa: PSafeArray; }
begin
  {HtmlText := PrintOptions.HtmlHeader.Text;
  CreateStreamOnHGlobal(0, TRUE, Stream);
  Stream.Write(Pchar(HTMLText), length(HTMLText), @Dummy);
  Stream.Seek(0, STREAM_SEEK_SET, Dummy);
  SafeArrayCopy(PSafeArray(TVarData(VarArrayOf([FPrintOptions.Header, FPrintOptions.Footer, Stream as IUnknown])).VArray), psa);
  TVarData(VaIn).VType := varArray or varByRef;
  SafeArrayCopy(psa, PSafeArray(TVarData(VaIn).VArray));
  InvokeCmd(FALSE, OLECMDID_PRINT, OLECMDEXECOPT_DONTPROMPTUSER, vaIn, vaOut);}
  ControlInterface.ExecWB(OLECMDID_PRINT, OLECMDEXECOPT_PROMPTUSER,
    vaIn, vaOut);
end;

procedure TEmbeddedWB.PrintSetup;
var
  vaIn, vaOut: Olevariant;
{  HtmlText: string;
  Stream: IStream;
  Dummy: Int64;
  Psa: PSafeArray;   }
begin
 { HtmlText := PrintOptions.HtmlHeader.Text;
  CreateStreamOnHGlobal(0, TRUE, Stream);
  Stream.Write(Pchar(HTMLText), length(HTMLText), @Dummy);
  Stream.Seek(0, STREAM_SEEK_SET, Dummy);
  SafeArrayCopy(PSafeArray(TVarData(VarArrayOf([FPrintOptions.Header, FPrintOptions.Footer, Stream as IUnknown])).VArray), psa);
  TVarData(VaIn).VType := varArray or varByRef;
  SafeArrayCopy(psa, PSafeArray(TVarData(VaIn).VArray));
  InvokeCmd(FALSE, OLECMDID_PRINT, OLECMDEXECOPT_PROMPTUSER, vaIn, vaOut);}
  ControlInterface.ExecWB(OLECMDID_PAGESETUP, OLECMDEXECOPT_PROMPTUSER,
    vaIn, vaOut);
end;

procedure TEmbeddedWB.PageSetup(UsePrintOptions: Boolean);
var
  vaIn, vaOut: Olevariant;
begin
  if UsePrintOptions then InvokingPageSetup := True;
  InvokeCmd(FALSE, OLECMDID_PAGESETUP, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
end;

procedure TEmbeddedWB.OpenIEBrowserWithAddress;
begin
  SendMessage(Handle, WM_COMMAND, ID_IE_FILE_NEWWINDOW, 0);
end;

procedure TEmbeddedWB.ExploreFolder(Path: string);
begin
   ShellExecute(handle, 'explore', Pchar(path), Nil, Nil, SW_SHOWNORMAL);
end;

procedure TEmbeddedWB.OpenDialog;
var
  OD: TOpenDialog;
begin
    OD := TOpenDialog.Create(self);
    OD.Filter := 'Internet Files and Url Shortcuts|*.htm;*.html;*.HTML;*.HTM';
    OD.Title  := 'Browser Open Dialog - Internet Files and Url Shortcuts';
  if OD.Execute then
    begin
       Go(OD.FileName);
    end;
  OD.Free;
end;

procedure TEmbeddedWB.SaveDialog;
var
  vaIn, vaOut: Olevariant;
begin
  InvokeCmd(FALSE, OLECMDID_SAVEAS, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
end;

function TEmbeddedWB.DownloadFile(SourceFile, DestFile: string): Boolean;
begin
  try
    Result := UrlDownloadToFile(nil, PChar(SourceFile), PChar(DestFile), 0,
      nil) = 0;
  except
    Result := False;
  end;
end;

procedure TEmbeddedWB.SaveImagesDialog;
var
  k, p: Integer;
  path, Source, dest, ext: string;
begin
  while ReadyState <> READYSTATE_COMPLETE do
      Forms.Application.ProcessMessages;
   if Assigned(document) then
   begin
   path := BrowseForFolder('Web Browser - Please select a destination folder'+#10+#13
   +'for the images', 'Desktop');
   MessageDlg(Path ,mtCustom,[mbYes,mbAll,mbCancel], 0);
    begin
 for k := 0 to OleObject.Document.Images.Length - 1 do
  begin
    Source := OleObject.Document.Images.Item(k).Src;
    p := LastDelimiter('.', Source);
    ext := UpperCase(System.Copy(Source, p + 1, Length(Source)));
    if (ext = 'GIF') or (ext = 'JPG') or (ext = 'BMP') or (ext = 'PNG') then
    begin
      p  := LastDelimiter('/', Source);
      dest := path+ '/Images'+ System.Copy(Source, p + 1, Length(Source));
      DownloadFile(Source, dest);
    end;
   end;
  end;
 end;
end;

procedure TEmbeddedWB.ScrollToTop;
begin
  while ReadyState <> READYSTATE_COMPLETE do
    Forms.Application.ProcessMessages;
    try
      OleObject.Document.ParentWindow.ScrollTo(0, 0);
    except
    end;
end;

procedure TEmbeddedWB.ScrollToPosition(X, Y : integer);
begin
  while ReadyState <> READYSTATE_COMPLETE do
        Forms.Application.ProcessMessages;
  try
    OleObject.Document.ParentWindow.ScrollTo(X, Y);
  except
  end;
end;

procedure TEmbeddedWB.ScrollToBottom;
begin
  while ReadyState <> READYSTATE_COMPLETE do
        Forms.Application.ProcessMessages;
  try
    OleObject.Document.ParentWindow.ScrollTo(0, MaxInt);
  except
  end;
end;

procedure TEmbeddedWB.RestoreApplicationFormSize;
var
  ws : integer;
  RegPath: string;
begin
  with TRegistry.Create do
  begin
    RootKey:= HKEY_LOCAL_MACHINE;
    RegPath :='SOFTWARE\'+Forms.Application.Title+'\FormSize';
 if OpenKey(RegPath, false) then
    try
      Forms.Application.MainForm.Left   := ReadInteger('Left');
      Forms.Application.MainForm.Top    := ReadInteger('Top');
      Forms.Application.MainForm.Width  := ReadInteger('Width');
      Forms.Application.MainForm.Height := ReadInteger('Height');
      ws := ReadInteger('WindowState');
       case ws of
        0 : Forms.Application.MainForm.WindowState := wsNormal;
        1 : Forms.Application.MainForm.WindowState := wsMinimized;
        2 : Forms.Application.MainForm.WindowState := wsMaximized;
       end;
    except
     MessageDlg('Error while writing the application form position to the registry!'  ,mtError,[mbOK], 0);
     end;
     CloseKey;
     free;
  end;
end;

procedure TEmbeddedWB.SaveApplicationFormSize;
var
  RegPath: string;
begin
  with TRegistry.Create do
  begin
    RootKey:= HKEY_LOCAL_MACHINE;
    RegPath :='SOFTWARE\'+Forms.Application.Title+'\FormSize';
 if OpenKey(RegPath, true) then
    try
     begin
         WriteInteger('Top', Forms.Application.MainForm.Top);
         WriteInteger('Left', Forms.Application.MainForm.Left);
         WriteInteger('Width', Forms.Application.MainForm.Width);
         WriteInteger('Height', Forms.Application.MainForm.Height);
      with Forms.Application.MainForm do
       case WindowState of
         wsNormal    : WriteInteger('WindowState', 0);
         wsMinimized : WriteInteger('WindowState', 0);
         wsMaximized : WriteInteger('WindowState', 0);
       end;
       CloseKey;
       free;
     end;
   except
   MessageDlg('Error while writing the application form position to the registry!' ,mtError,[mbOK], 0);
  end;
 end;
end;

procedure TEmbeddedWB.SavePageTextDialog;
var
 sd: TSaveDialog;
 textStr : TStringList;
begin
      textstr:= TStringList.Create;
while ReadyState <> READYSTATE_COMPLETE do
      Forms.Application.ProcessMessages;
   if Assigned(document) then
      textStr.Add(VarToStr(OleObject.Document.documentElement.innerText));
   begin
     sd := TSaveDialog.Create(self);
     sd.Filter      :='Text file|*.txt|Word file|*.doc';
     sd.DefaultExt  := 'txt';
     sd.FilterIndex := 1;
     sd.FileName    :='WebSiteText.txt';
     sd.Title       :='Web Site Text';
  if sd.Execute then
    begin
     textStr.SaveToFile(sd.FileName);
    end;
  sd.free;
  textStr.Free;
 end;
end;

procedure TEmbeddedWB.ViewPageSourceHtml;
var
  vaIn, vaOut: Olevariant;
begin
  InvokeCmd(TRUE, HTMLID_VIEWSOURCE, 0, vaIn, vaOut);
end;

procedure TEmbeddedWB.ViewPageSourceText;
var
 TextLst : TStringList;
begin
      TextLst:= TStringList.Create;
while ReadyState <> READYSTATE_COMPLETE do
      Forms.Application.ProcessMessages;
   if Assigned(document) then
    begin
      TextLst.Add(VarToStr(OleObject.Document.documentElement.innerText));
      MessageDlg(TextLst.Text ,mtCustom, [mbOK], 0);
    end;
  TextLst.Free;
end;

procedure TEmbeddedWB.ViewPagePropertiesToStrings(PropertiesList: TStrings);
begin
 PropertiesList.Clear;
if ReadyState = READYSTATE_COMPLETE  then
if Assigned(document) then
 begin
   try
    with PropertiesList do
      begin
       Add('Current Url: '+OleObject.Document.Url);
       Add('Current Title: '+OleObject.Document.title);
       Add('Scroll Height: '+IntToStr(OleObject.Document.Body.ScrollHeight));
       Add('Scroll Width: '+IntToStr(OleObject.Document.Body.ScrollWidth));
       Add('Scroll Top: '+IntToStr(OleObject.Document.Body.ScrollTop));
       Add('Scroll Left: '+IntToStr(OleObject.Document.Body.ScrollLeft));
       Add('Client Height: '+IntToStr(OleObject.Document.Body.ClientHeight));
       Add('Client Width: '+IntToStr(OleObject.Document.Body.ClientWidth));
       Add('Referrer: '+OleObject.Document.referrer);
       Add('Cookie: '+OleObject.document.cookie);
       Add('Last Modified: '+OleObject.document.LastModified);
       Add('Protocol: '+OleObject.Document.Location.Protocol);
     //Add('Parent Window: '+OleObject.Document.ParentWindow);
       Add('Default Charset: '+OleObject.Document.defaultCharset);
       Add('Unique ID: '+OleObject.Document.uniqueID);
       Add('File Size: '+OleObject.document.FileSize);
       Add('File Created Date: '+OleObject.Document.fileCreatedDate);
     end;
    except
      PropertiesList.Add('It looks like there are errors on the page HTML code!');
     end;
   end;
end;

procedure TEmbeddedWB.ViewPageSourceTextToStrings(TextList: TStrings);
begin
 TextList.Clear;
 while ReadyState <> READYSTATE_COMPLETE do
       Forms.Application.ProcessMessages;
    if Assigned(document) then
       TextList.Add(VarToStr(OleObject.Document.documentElement.innerText));
end;

procedure TEmbeddedWB.ViewPageSourceHTMLToStrings(HtmlList: TStrings);
begin
 HtmlList.Clear;
 while ReadyState <> READYSTATE_COMPLETE do
       Forms.Application.ProcessMessages;
    if Assigned(document) then
       HtmlList.Add(VarToStr(OleObject.Document.documentElement.innerHTML));
end;

procedure TEmbeddedWB.ViewPageLinksToStrings(LinksList: TStrings);
var   //by tom
  UNum: Variant;
  s: string;
 procedure RecurseLinks(htmlDoc: Variant);
  var
    BodyElement, ElementCo, HTMLFrames, HTMLWnd, doc: OleVariant;
    j, i: integer;
  begin
    if VarIsEmpty(htmlDoc) then   exit;
       BodyElement := htmlDoc.body;
    if BodyElement.tagName = 'BODY' then
    begin
      ElementCo := htmlDoc.links;
      j := ElementCo.Length - 1;
      for i := 0 to j do
      begin
        UNum := ElementCo.item(i);
        s := UNum.href;
        If j = 0 then s :='No Links found in the page body';
        LinksList.Add(s);
      end;
    end;
    HTMLFrames := htmlDoc.Frames;
    j := HTMLFrames.length - 1;
    for i := 0 to j do
    begin
      HTMLWnd := HTMLFrames.Item(i);
      try
        doc := HTMLWnd.Document;
        RecurseLinks(doc);
      except
        continue;
      end;
    end;
  end;
begin
  LinksList.Clear;
  RecurseLinks(document);
end;

procedure TEmbeddedWB.ViewPageImagesToStrings(ImagesList: TStrings);
var   //by tom
  i, Num: Integer;
  sImageURL: string;
  strLocalFile: string;
begin
  i := 0;
  ImagesList.Clear;
  for Num := 0 to OleObject.Document.Images.Length - 1 do
  begin
    sImageURL := OleObject.Document.Images.Item(Num).Src;
    ImagesList.Add('--Url  :' + sImageURL);
    GetCachedFileFromURL(sImageURL, strLocalFile);
    ImagesList.Add('--Local:' + strLocalFile);
    i := Num;
  end;
  if i = 0 then ImagesList.Add('No images were found.');
end;

procedure TEmbeddedWB.ViewPageFieldsToStrings(FieldList: TStrings);
var  //by tom
  i, j: Integer;
  FormItem: Variant;
begin
  FieldList.Clear;
  for I := 0 to OleObject.Document.forms.Length - 1 do
  begin
    FormItem := OleObject.Document.forms.Item(I);
    for j := 0 to FormItem.Length - 1 do
    begin
      try
        FieldList.Add('Name :' + FormItem.Item(j).Name + ' ; ' +
                        'ID :' + FormItem.Item(j).ID + ' ; ' +
                   'TagName :' + FormItem.Item(j).TagName + ' ; ' +
                  'toString :' + FormItem.Item(j).toString + ' ; ' +
                 'innerText :' + FormItem.Item(j).innerText + ' ; ' +
                 'innerHTML :' + FormItem.Item(j).innerHTML);
      except
      Exit;
      end;
    end;
  end;
end;

procedure TEmbeddedWB.ShowInternetOptions;
var
  vaIn, vaOut: Olevariant;
begin
  InvokeCmd(TRUE, HTMLID_OPTIONS, 0, vaIn, vaOut);
end;

procedure TEmbeddedWB.ShowPageProperties;
var
  vaIn, vaOut: Olevariant;
begin
  InvokeCmd(FALSE, OLECMDID_PROPERTIES, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
end;

procedure TEmbeddedWB.ShowOrgenizeFavorites;
begin
  OrganizeFavorite(Handle, GetSpecialFolderPath(Handle, CSIDL_FAVORITES));
end;

function TEmbeddedWB.GetIEHandle(WebBrowser: TEmbeddedWB; ClassName: string): HWND;
var
  hwndChild, hwndTmp: integer;
  oleCtrl: TOleControl;
  szClass: array [0..255] of char;
begin
  oleCtrl := WebBrowser;
  hwndTmp := oleCtrl.Handle;
  while (true) do
  begin
    hwndChild := GetWindow(hwndTmp, GW_CHILD);
    GetClassName(hwndChild, szClass, SizeOf(szClass));
    if (string(szClass)=ClassName) then
    begin
      Result :=hwndChild;
      Exit;
    end;
    hwndTmp := hwndChild;
  end;
  Result := 0;
end;

procedure TEmbeddedWB.ShowImportExportFavoritesAndCookies;
begin
  SendMessage(Handle, WM_COMMAND, ID_IE_FILE_IMPORTEXPORT, 0);
end;

procedure TEmbeddedWB.ShowIEVersionInfo;
begin
  SendMessage(Handle, WM_COMMAND, ID_IE_HELP_VERSIONINFO   , 0);
end;

procedure TEmbeddedWB.ShowFindDialog;
var
  vaIn, vaOut: Olevariant;
begin
  InvokeCmd(TRUE, HTMLID_FIND, 0, vaIn, vaOut);
end;

procedure TEmbeddedWB.Copy;
var
  vaIn, vaOut: Olevariant;
begin
  InvokeCmd(FALSE, OLECMDID_COPY, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
end;
procedure TEmbeddedWB.Paste;
var
  vaIn, vaOut: Olevariant;
begin
  InvokeCmd(FALSE, OLECMDID_PASTE, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
end;

procedure TEmbeddedWB.Cut;
var
  vaIn, vaOut: Olevariant;
begin
  InvokeCmd(FALSE, OLECMDID_CUT, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
end;

procedure TEmbeddedWB.SelectAll;
var
  vaIn, vaOut: Olevariant;
begin
  InvokeCmd(FALSE, OLECMDID_SELECTALL, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
end;

procedure TEmbeddedWB.Zoom(ZoomValue: Integer);
var
  vaIn, vaOut: Olevariant;
begin
  if ZoomValue < ZoomRangeLow then vaIn := ZoomRangeLow else
    if ZoomValue > ZoomRangeHigh then vaIn := ZoomRangeHigh else
      vaIn := ZoomValue;
  InvokeCmd(FALSE, OLECMDID_ZOOM, OLECMDEXECOPT_DONTPROMPTUSER, vaIn, vaOut);
end;

function TEmbeddedWB.ZoomRangeLow: Integer;
var
  vaIn, vaOut: Olevariant;
begin
  InvokeCmd(FALSE, OLECMDID_GETZOOMRANGE, OLECMDEXECOPT_DONTPROMPTUSER, vaIn, vaOut);
  result := LoWord(Dword(vaOut));
end;

function TEmbeddedWB.ZoomRangeHigh: Integer;
var
  vaIn, vaOut: Olevariant;
begin
  InvokeCmd(FALSE, OLECMDID_GETZOOMRANGE, OLECMDEXECOPT_DONTPROMPTUSER, vaIn, vaOut);
  result := HiWord(Dword(vaOut));
end;

function TEmbeddedWB.ZoomValue: Integer;
var
  vaIn, vaOut: Olevariant;
begin
  vaIn := null;
  InvokeCmd(FALSE, OLECMDID_ZOOM, OLECMDEXECOPT_DONTPROMPTUSER, vaIn, vaOut);
  result := vaOut;
end;

// IDOCHOSTUIHANDLER

function TEmbeddedWB.ShowContextMenu(const dwID: DWORD; const ppt: PPOINT;
  const pcmdtReserved: IUnknown; const pdispReserved: IDispatch): HRESULT;
begin
  if (FDisableRightClickmenu) then RESULT:= S_OK else RESULT := S_FALSE ;
  if (Assigned(FOnShowContextmenu)) and not(FDisableRightClickmenu)
   then RESULT := FOnSHowContextmenu(dwID, ppt, pcmdtreserved, pdispreserved)
  // else  RESULT := S_FALSE;
end;

function TEmbeddedWB.GetHostInfo(var pInfo: TDOCHOSTUIINFO): HRESULT;
begin
  pInfo.cbSize := SizeOf(pInfo);
  pInfo.dwFlags := FUserInterfaceValue;
  pInfo.dwDoubleClick := DOCHOSTUIDBLCLK_DEFAULT;
  if Assigned(FOnGetHostInfo) then
    Result := FOnGetHostInfo(pInfo) else
    Result := S_OK;
end;

function TEmbeddedWB.ShowUI(const dwID: DWORD;
  const pActiveObject: IOleInPlaceActiveObject;
  const pCommandTarget: IOleCommandTarget; const pFrame: IOleInPlaceFrame;
  const pDoc: IOleInPlaceUIWindow): HRESULT;
begin
  if Assigned(FOnShowUI) then
    Result := FOnShowUI(dwID, pActiveObject, pCommandTarget, pFrame, pDoc)
  else
    Result := S_FALSE;
end;

function TEmbeddedWB.HideUI: HRESULT;
begin
  if Assigned(FOnHideUI) then
    Result := FOnHideUI else
    Result := S_FALSE;
end;

function TEmbeddedWB.UpdateUI: HRESULT;
begin
  if Assigned(FOnUpdateUI) then
    Result := FOnUpdateUI else
    Result := S_FALSE;
end;

function TEmbeddedWB.EnableModeless(const fEnable: BOOL): HRESULT;
begin
  if Assigned(FOnEnableModeless) then
    Result := FOnEnableModeless(fEnable) else
    Result := S_FALSE;
end;

function TEmbeddedWB.OnDocWindowActivate(const fActivate: BOOL): HRESULT;
begin
  if Assigned(FOnOnDocWindowActivate) then
    Result := FOnOnDocWindowActivate(fActivate) else
    Result := S_FALSE;
end;

function TEmbeddedWB.OnFrameWindowActivate(const fActivate: BOOL): HRESULT;
begin
  if Assigned(FOnOnFrameWindowActivate) then
    Result := FOnOnFrameWindowActivate(fActivate) else
    Result := S_FALSE;
end;

function TEmbeddedWB.ResizeBorder(const prcBorder: PRECT;
  const pUIWindow: IOleInPlaceUIWindow; const fRameWindow: BOOL): HRESULT;
begin
  if Assigned(FOnResizeBorder) then
    Result := FOnResizeBorder(prcBorder, pUIWindow, fRameWindow) else
    Result := S_FALSE;
end;

function TEmbeddedWB.TranslateAccelerator(const lpMsg: PMSG;
  const pguidCmdGroup: PGUID; const nCmdID: DWORD): HRESULT;
begin
  if Assigned(FOnTranslateAccelerator) then
    Result := FOnTranslateAccelerator(lpMsg, pguidCmdGroup, nCmdID) else
    Result := S_FALSE;
end;

function TEmbeddedWB.GetOptionKeyPath(var pchKey: POLESTR; const dw: DWORD): HRESULT;
begin
  if Assigned(FOnGetOptionKeyPath) then
    Result := FOnGetOptionKeyPath(pchKey, dw) else
    Result := S_FALSE;
end;

function TEmbeddedWB.GetDropTarget(const pDropTarget: IDropTarget;
  out ppDropTarget: IDropTarget): HRESULT;
begin
  if Assigned(FOnGetDropTarget) then
    Result := FOnGetDropTarget(pDropTarget, ppDropTarget) else
    Result := S_OK;
end;

function TEmbeddedWB.GetExternal(out ppDispatch: IDispatch): HRESULT;
begin
  if Assigned(FOnGetExternal) then
    Result := FOnGetExternal(ppDispatch) else
    Result := S_FALSE;
end;

function TEmbeddedWB.TranslateUrl(const dwTranslate: DWORD;
  const pchURLIn: POLESTR; var ppchURLOut: POLESTR): HRESULT;
begin
  if Assigned(FOnTranslateUrl) then
    Result := FOnTranslateUrl(dwTranslate, pchUrlIn, ppchUrlOut) else
    Result := S_FALSE;
end;

function TEmbeddedWB.FilterDataObject(const pDO: IDataObject;
  out ppDORet: IDataObject): HRESULT;
begin
  if Assigned(FOnFilterDataObject) then
    Result := FOnFilterDataObject(pDO, ppDORet) else
    Result := S_FALSE;
end;

// IDOCHOSTSHOWUI

function TEmbeddedWB.ShowMessage(hwnd: THandle; lpstrText: POLESTR;
  lpstrCaption: POLESTR; dwType: longint; lpstrHelpFile: POLESTR;
  dwHelpContext: longint; var plResult: LRESULT): HRESULT;
begin
  if Assigned(FOnShowMessage) then
    Result := FOnShowMessage(hwnd, lpstrText, lpStrCaption, dwType, lpStrHelpFile, dwHelpContext, plResult) else
    Result := S_FALSE;
end;

function TEmbeddedWB.ShowHelp(hwnd: THandle; pszHelpFile: POLESTR;
  uCommand: integer; dwData: longint; ptMouse: TPoint;
  var pDispatchObjectHit: IDispatch): HRESULT;
begin
  Result := S_OK;
  if Assigned(FOnShowHelp) then
    Result := FOnShowHelp(hwnd, pszHelpFile, uCommand, dwData, ptMouse, pDispatchObjectHit) else
    if FHelpFile <> '' then HtmlHelp(hwnd, Pchar(FHelpFile), ucommand, dwData) else
      Result := S_FALSE;
end;

// IDISPATCH methods

function TEmbeddedWB.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  if Assigned(FOnGetIdsofNames) then
    Result := FOnGetIdsofNames(IID, Names, NameCount, LocaleID, DispIds) else
    result := E_NotImpl;
end;

function TEmbeddedWB.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  if Assigned(FOnGetTypeInfo) then
    Result := FOnGetTypeInfo(Index, LocaleID, ITypeInfo(TypeInfo)) else
  begin
    Result := E_NOTIMPL;
    pointer(TypeInfo) := nil;
  end;
end;

function TEmbeddedWB.GetTypeInfoCount(out Count: Integer): HResult;
begin
  if Assigned(FOnGetTypeInfoCount) then
    Result := FOnGetTypeInfoCount(Count) else
  begin
    Result := E_NOTIMPL;
    Count := 0;
  end;
end;

function TEmbeddedWB.Invoke(DispID: Integer;
  const IID: TGUID;
  LocaleID: Integer;
  Flags: Word;
  var Params;
  VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
begin
  UpdateUserInterfaceValue;
  Result := S_OK;
  if (Flags and DISPATCH_PROPERTYGET <> 0) and (VarResult <> nil) and
    (DispId = DISPID_AMBIENT_DLCONTROL) then
    PVariant(VarResult)^ := FDownloadOptionValue
  else
    if Assigned(FOnInvoke) then
      Result := FOnInvoke(DispId, IID, LocaleID, Flags, TagDispParams(Params),
        VarResult, ExcepInfo, ArgErr)
    else
      Result := inherited Invoke(DispID, IID, LocaleID, Flags, Params,
        VarResult, ExcepInfo, ArgErr);
end;


procedure Register;
begin
  RegisterComponents('Embedded Web Browser', [TEmbeddedWB]);
end;

{ TPrintOptions }

procedure TPrintOptions.SetHTMLHeader(const Value: Tstrings);
begin
  FHTMLHeader.Assign(Value);
end;

function DeleteFirstCacheEntry(var H: THandle): DWORD;
var
  T: PInternetCacheEntryInfo;
  D: DWord;
begin
  Result := S_OK;
  H := 0;
  D := 0;
  FindFirstUrlCacheEntryEx(nil, 0, {URLCACHE_FIND_DEFAULT_FILTER}NORMAL_CACHE_ENTRY, 0, nil, @D, nil, nil, nil);
  GetMem(T, D);
  try
    H := FindFirstUrlCacheEntryEx(nil, 0, {URLCACHE_FIND_DEFAULT_FILTER}NORMAL_CACHE_ENTRY, 0, T, @D, nil, nil, nil);
    if (H = 0) then Result := GetLastError else DeleteUrlCacheEntry(T^.lpszSourceUrlname);
  finally
    FreeMem(T, D)
  end;
end;

function DeleteNextCacheEntry(H: THandle): DWORD;
var
  T: PInternetCacheEntryInfo;
  D: DWORD;
begin
  Result := S_OK;
  D := 0;
  FindnextUrlCacheEntryEx(H, nil, @D, nil, nil, nil);
  GetMem(T, D);
  try
    if not FindNextUrlCacheEntryEx(H, T, @D, nil, nil, nil)
      then Result := GetLastError else DeleteUrlCacheEntry(T^.lpszSourceUrlname);
  finally
    FreeMem(T, D)
  end;
end;

procedure TEmbeddedWB.ClearCache;
var
  H: THandle;
begin
  if DeleteFirstCacheEntry(H) = S_OK then
    repeat
    until DeleteNextCacheEntry(H) = ERROR_NO_MORE_ITEMS;
  FindCloseUrlCache(H)
end;

procedure TEmbeddedWB.ClearTypedUrls;
begin
  with TRegistry.Create do
  try
    RootKey := HKEY_CURRENT_USER;
    DeleteKey('Software\Microsoft\Internet Explorer\TypedURLs');
  finally
    Free;
  end;
end;

procedure TEmbeddedWB.ClearHistory;
var
  HistoryStg: IUrlHistoryStg2;
begin
try
  HistoryStg := CreateComObject(CLSID_CUrlHistory) as IUrlHistoryStg2;
  HistoryStg.ClearHistory;
except end;
end;

function TEmbeddedWB.GetOverrideKeyPath(pchKey: POLESTR;
  dw: DWORD): HRESULT;
begin
  if Assigned(FOnGetOverrideKeyPath) then RESULT := FOnGetOverrideKeyPath(pchkey, dw) else
    Result := S_OK;
end;

{$IFDEF USE_IOLECOMMANDTARGET}       

function TEmbeddedWB.Exec(CmdGroup: PGUID; nCmdID, nCmdexecopt: DWORD;
  const vaIn: OleVariant; var vaOut: OleVariant): HResult;
var
  FCancel, FContinueScript, FShowDialog: Boolean;
  pEventObj: IHTMLEventObj;
  function GetProperty(const PropName: WideString): OLEVariant;
  var
    Dispparams: TDispParams;
    Disp, Status: Integer;
    ExcepInfo: TExcepInfo;
    PPropName: PWideChar;
  begin
    Dispparams.rgvarg := nil;
    Dispparams.rgdispidNamedArgs := nil;
    Dispparams.cArgs := 0;
    Dispparams.cNamedArgs := 0;
    PPropName := PWideChar(PropName);
    Status := pEventObj.GetIDsOfNames(GUID_NULL, @PPropname, 1,
      LOCALE_SYSTEM_DEFAULT, @Disp);
    if Status = 0 then
    begin
      Status := pEventObj.Invoke(disp, GUID_NULL, LOCALE_SYSTEM_DEFAULT, DISPATCH_PROPERTYGET,
        Dispparams, @Result, @ExcepInfo, nil);
      if Status <> 0 then DispatchInvokeError(Status, ExcepInfo);
    end else
      if Status = DISP_E_UNKNOWNNAME then
        raise EOleError.CreateFmt('''%s'' not supported.', [PropName])
      else
        OleCheck(Status);
  end;
begin
  UpdateUserInterfaceValue;
  if (CmdGroup = nil) then
  begin
    Result := OLECMDERR_E_UNKNOWNGROUP;
    exit;
  end;
  Result := OLECMDERR_E_NOTSUPPORTED;
  if (ncmdID = OLECMDID_ONUNLOAD) and IsEqualGuid(cmdGroup^, CGID_EXPLORER) and
    Assigned(FOnUnload) then FOnUnload(Self);

  if IsEqualGuid(cmdGroup^, CGID_DocHostCommandHandler) then
  begin
  {   if Assigned(FOnProgressChange) then
     begin
       FOnProgressChange(Position := Round((Progress * 100) Div ProgressMax);
     end; }

    if Assigned(FOnRefresh) and ((nCmdID = 6041 {F5}) or (nCmdID = 6042 {ContextMenu}) or (nCmdID = 2300)) then
    begin
      FCancel := False;
      FOnRefresh(self, nCmdID, FCancel);
      if FCancel then Result := S_OK;
    end else
      case nCmdID of
        OLECMDID_SHOWSCRIPTERROR:
          {
          if Assigned(FOnScriptError)
            then begin
            Result := S_OK;    //×Ô¼ºÌí¼ÓµÄÒ»¾ä¡£  //kkk
            pEventObj := (Document as IHTMLDocument2).parentWindow.event;
            if pEventObj <> nil then
            begin
              FContinueScript := True;
              FShowDialog := True;
              FOnScriptError(self,
                GetProperty('errorline'),
                GetProperty('errorCharacter'),
                GetProperty('errorCode'),
                GetProperty('errorMessage'),
                GetProperty('errorUrl'),
                FContinueScript, FShowDialog);
              TVariantArg(vaOut).vt := VT_BOOL;
              TVariantArg(vaOut).vbool := FContinueScript;
              //if not FShowDialog then Result := S_OK;
              if FShowDialog then Result := OLECMDERR_E_NOTSUPPORTED
              else Result := S_OK;
            end;
          end;
          }
          if Assigned(FOnScriptError) then
          begin
            pEventObj := (Document as IHTMLDocument2).parentWindow.event;
            FContinueScript := True;
            FShowDialog := True;
            if pEventObj <> nil then
            begin
              FOnScriptError(self,
                GetProperty('errorline'),
                GetProperty('errorCharacter'),
                GetProperty('errorCode'),
                GetProperty('errorMessage'),
                GetProperty('errorUrl'),
                FContinueScript, FShowDialog);
            end else
              FOnScriptError(self, '', '', '', '', '', FContinueScript, FShowDialog);
            TVariantArg(vaOut).vt := VT_BOOL;
            TVariantArg(vaOut).vbool := FContinueScript;
            if not FShowDialog then Result := S_OK;
          end;
      end;
  end;
end;

function TEmbeddedWB.QueryStatus(CmdGroup: PGUID; cCmds: Cardinal;
  prgCmds: POleCmd; CmdText: POleCmdText): HResult;
begin
  result := S_OK;
end;
{$ENDIF}


initialization
  Saved8087CW := Default8087CW;
{$IFDEF VER120UP}
  bMsgHandler := False;
{$ENDIF}
  OleInitialize(nil);
 // Set8087CW($133F);
finalization
  Set8087CW(Saved8087CW);
  try
    OleUninitialize;
  except
  end;
end.

