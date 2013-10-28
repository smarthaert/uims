//*************************************************************
//                          TEmbeddedWB                       *
//                                                            *
//                     Freeware Component                     *
//             For Delphi 4, 5, 6, 7, 2005, 2006              *
//                            by                              *
//                     Per Lindsø Larsen                      *
//      Developing Team:                                      *
//      Eran Bodankin (bsalsa) -(bsalsa@bsalsa.com)           *
//                                                            *
//       Contributors:                                        *
//            Mathias Walter (mathias.walter@gmx.net')        *
//              -  all MessageHandling code                   *
//            Neil Moss (NeilM@BuchananInternational.com)     *
//              -  code for setting downloadoptions           *
//            jezek1                                          *
//              - support for D7  (12/09/2002)                *
//            Thomas Stutz -(smot777@yahoo.com)               *
//                                                            *
//       Documentation and updated versions:                  *
//                                                            *
//               http://www.bsalsa.com                        *
//*************************************************************
{*******************************************************************************}
{LICENSE:
THIS SOFTWARE IS PROVIDED TO YOU "AS IS" WITHOUT WARRANTY OF ANY KIND,
EITHER EXPRESSED OR IMPLIED INCLUDING BUT NOT LIMITED TO THE APPLIED
WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
YOU ASSUME THE ENTIRE RISK AS TO THE ACCURACY AND THE USE OF THE SOFTWARE
AND ALL OTHER RISK ARISING OUT OF THE USE OR PERFORMANCE OF THIS SOFTWARE
AND DOCUMENTATION. [YOUR NAME] DOES NOT WARRANT THAT THE SOFTWARE IS ERROR-FREE
OR WILL OPERATE WITHOUT INTERRUPTION. THE SOFTWARE IS NOT DESIGNED, INTENDED
OR LICENSED FOR USE IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE CONTROLS,
INCLUDING WITHOUT LIMITATION, THE DESIGN, CONSTRUCTION, MAINTENANCE OR
OPERATION OF NUCLEAR FACILITIES, AIRCRAFT NAVIGATION OR COMMUNICATION SYSTEMS,
AIR TRAFFIC CONTROL, AND LIFE SUPPORT OR WEAPONS SYSTEMS. VSOFT SPECIFICALLY
DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF FITNESS FOR SUCH PURPOSE.

You may use/ change/ modify the component under 3 conditions:
1. In your website, add a link to "http://www.bsalsa.com"
2. In your application, add credits to "Embedded Web Browser"
3. Mail me  (bsalsa@bsalsa.com) any code change in the unit  for the benefit
   of the other users.
4. You may consider donation in our web site!
{*******************************************************************************}

unit EmbeddedWB;

//EwbTools----------------------------------------------------------------------
{To remove the EwbTools, just add a dot like "{.$DEFINE...USE_EwbTools" or something.
and re-compile the package.}
{$DEFINE USE_EwbTools}
//IOLECOMMANDTARGET-------------------------------------------------------------
{To remove the IOLECOMMANDTARGET, just add a dot like "{.$DEFINE...USE_IOLECOMMANDTARGET" or something.
and re-compile the package.}
{$DEFINE USE_IOLECOMMANDTARGET}
//------------------------------------------------------------------------------

interface

{$I EWB.inc}

uses
{$IFDEF DELPHI_6_UP}Variants, {$ENDIF}
   Windows, Messages, Classes, Mshtml_Ewb, EWBAcc, Graphics, Controls, Forms,
   ExtCtrls, ActiveX, ShlObj, SHDocVw_EWB, UrlMon;

type
   TAllowFocusChange = function(const pfAllow : Boolean): HRESULT;
{$IFDEF USE_IOLECOMMANDTARGET}
   TScriptErrorEvent = procedure(Sender: TObject; ErrorLine, ErrorCharacter, ErrorCode, ErrorMessage, ErrorUrl: string;
      var ContinueScript: Boolean; var Showdialog: Boolean) of object;
   TRefreshEvent = procedure(Sender: TObject; CmdID: Integer; var Cancel: Boolean) of object;
   TUnloadEvent = procedure(Sender: TObject) of object;
{$ENDIF}
   TDownloadEvent = function(pmk: IMoniker; pbc: IBindCtx; dwBindVerb: DWORD;
      grfBINDF: DWORD; pBindInfo: PBindInfo; pszHeaders: PWidechar;
      pszRedir: PWidechar; uiCP: UINT): HRESULT of object;
   TInvokeEvent = function(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params: TagDispParams; VarResult, ExcepInfo, ArgErr: Pointer): HRESULT of object;
   TGetOverrideKeyPathEvent = function(pchKey: POleStr; dw: DWORD): HRESULT of object;
   TGetHostInfoEvent = function(var pInfo: TDOCHOSTUIINFO): HRESULT of object;
   TShowUIEvent = function(const dwID: DWORD; const pActiveObject: IOleInPlaceActiveObject;
      const pCommandTarget: IOleCommandTarget; const pFrame: IOleInPlaceFrame;
      const pDoc: IOleInPlaceUIWindow): HRESULT of object;
   THideUIEvent = function: HRESULT of object;
   TUpdateUIEvent = function: HRESULT of object;
   TEnableModelessEvent = function(const fEnable: BOOL): HRESULT of object;
   TOnDocWindowActivateEvent = function(const fActivate: BOOL): HRESULT of object;
   TOnFrameWindowActivateEvent = function(const fActivate: BOOL): HRESULT of object;
   TResizeBorderEvent = function(const prcBorder: PRect;
      const pUIWindow: IOleInPlaceUIWindow;
      const fRameWindow: BOOL): HRESULT of object;
   TTranslateAcceleratorEvent = function(const lpMsg: PMSG; const pguidCmdGroup: PGUID;
      const nCmdID: DWORD): HRESULT of object;
   TGetOptionKeyPathEvent = function(var pchKey: POleStr; const dw: DWORD): HRESULT of object;
   TOnDropEvent = function(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint;
      var dwEffect: Longint; Status: string): HResult of object;
   TOnDragEnterEvent = function(const dataObj: IDataObject; grfKeyState: Longint;
      pt: TPoint; var dwEffect: Longint; Status: string): HResult of object;
   TOnDragOverEvent = function(grfKeyState: Longint; pt: TPoint; var dwEffect: Longint;
      Status: string): HResult of object;
   TOnDragLeaveEvent = function: HRESULT of object;
   TGetDropTargetEvent = function(const pDropTarget: IDropTarget;
      out ppDropTarget: IDropTarget): HRESULT of object;
   TGetExternalEvent = function(out ppDispatch: IDispatch): HRESULT of object;
   TTranslateUrlEvent = function(const dwTranslate: DWORD; const pchURLIn: POleStr;
      var ppchURLOut: POleStr): HRESULT of object;
   TFilterDataObjectEvent = function(const pDO: IDataObject; out ppDORet: IDataObject): HRESULT of object;
   TShowMessageEvent = function(HWND: THandle;
      lpstrText: POleStr; lpstrCaption: POleStr; dwType: Longint; lpstrHelpFile: POleStr;
      dwHelpContext: Longint; var plResult: LRESULT): HRESULT of object;
   TShowHelpEvent = function(HWND: THandle; pszHelpFile: POleStr; uCommand: Integer;
      dwData: Longint; ptMouse: TPoint;
      var pDispatchObjectHit: IDispatch): HRESULT of object;
   TGetTypeInFoCountEvent = function(out Count: Integer): HRESULT of object;
   TGetTypeInfoEvent = function(Index, LocaleID: Integer; out TypeInfo: ITypeInfo): HRESULT of object;
   TGetIDsOfNamesEvent = function(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HRESULT of object;
   TQueryServiceEvent = function(const rsid, iid: TGUID; out Obj: IUnknown): HRESULT of object;
   TSetUIHandler = function(const pUIHandler: IDocHostUIHandler): HRESULT of object;
   TShowDialogEvent = procedure(Sender: TObject; h: THandle) of object;
   TShowContextMenuEvent = function(const dwID: DWORD; const ppt: PPOINT;
      const pcmdtReserved: IUnknown; const pdispReserved: IDispatch): HRESULT of object;
   TEvaluateNewWindowEvent = function(pszUrl, pszName, pszUrlContext, pszFeatures: LPCWSTR;
      fReplace: BOOL; dwFlags, dwUserActionTime: DWORD): HRESULT of object; //serge

   {Controlling Download and Execution}
   {http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/hosting/wbcustomization.asp}
   { TDownloadControlOption = (
        DLCTL_DLIMAGES, DLCTL_VIDEOS, DLCTL_BGSOUNDS, DLCTL_NO_SCRIPTS,
        DLCTL_NO_JAVA, DLCTL_NO_RUNACTIVEXCTLS, DLCTL_NO_DLACTIVEXCTLS,
        DLCTL_DOWNLOADONLY, DLCTL_NO_FRAMEDOWNLOAD, DLCTL_RESYNCHRONIZE,
        DLCTL_PRAGMA_NO_CACHE, DLCTL_NO_BEHAVIORS, DLCTL_NO_METACHARSET,
        DLCTL_URL_ENCODING_DISABLE_UTF8, DLCTL_URL_ENCODING_ENABLE_UTF8,
        DLCTL_FORCEOFFLINE, DLCTL_NO_CLIENTPULL, DLCTL_SILENT, DLCTL_OFFLINE); }
   TDownloadControlOption = (
      DownloadImages, DownloadVideos, DownloadBGSounds, DontExecuteScripts,
      DontExecuteJava, DontExecuteActiveX, DontDownloadActiveX,
      DownloadButDontDisplay, DontDownloadFrame, CheckPageResynchronize,
      DownloadAndIgnoreCache, DontDownloadBehaviors, SuppressedMetaCharset,
      DisableUrlIfEncodingUTF8, EnableUrlIfEncodingUTF8,
      ForceOfflineMode, DontPerformClientPull, DonloadInSilentMode, WorkOffline);
   TDownloadControlOptions = set of TDownloadControlOption;

    {Doc Host Flags:
    http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/hosting/reference/enum/dochostuiflag.asp}
    {TUserInterfaceOption = (DIALOG, DISABLE_HELP_MENU, NO3DBORDER,
        SCROLL_NO, DISABLE_SCRIPT_INACTIVE, OPENNEWWIN, DISABLE_OFFSCREEN,
        FLAT_SCROLLBAR, DIV_BLOCKDEFAULT, ACTIVATE_CLIENTHIT_ONLY,
        OVERRIDEBEHAVIORFACTORY,
        CODEPAGELINKEDFONTS, URL_ENCODING_DISABLE_UTF8,
        URL_ENCODING_ENABLE_UTF8,
         ENABLE_FORMS_AUTOCOMPLETE, ENABLE_INPLACE_NAVIGATION,
        IME_ENABLE_RECONVERSION,
        THEME, NOTHEME, NOPICS, NO3DOUTERBORDER, DISABLE_EDIT_NS_FIXUP,
        LOCAL_MACHINE_ACCESS_CHECK, DISABLE_UNTRUSTEDPROTOCOL,
        HOST_NAVIGATES, ENABLE_REDIRECT_NOTIFICATION, USE_WINDOWLESS_SELECTCONTROL,
        USE_WINDOWED_SELECTCONTROL, ENABLE_ACTIVEX_INACTIVATE_MODE);}
   TUserInterfaceOption = (DisableTextSelect, DisableHelpMenu, DontUse3DBorders,
      DontUseScrollBars, PostponeScriptUntilActive, ForceOpenNewWindow, Reserved_OFFSCREEN,
      ForceFlatScrollBars, InsertDivTagOnEditMode, ActivateUIOnlyOnDocClick,
      ConsultBeforeRetrievingBehavior,
      CheckFontSupportsCodePage, DisableSubmitUrlInUTF8,
      EnableSubmitUrlInUTF8,
      EnablesFormsAutoComplete, ForceSameWindowNavigation,
      EmableImeLocalLanguages,
      EnableThemes, DisableThemes, DisablePicsRatings, DisableFrameSetBorder, DisablesAutoNameSpaceCorrection,
      DisableLocalFileAccess, DisableUntrustedProtocol,
      CheckNavigationDelegatedToHost, EnableRedirectNotification, EnableDomWindlessControls,
      EnableWindowedControls, ForceUserActivationOnActiveXJava);
   TUserInterfaceOptions = set of TUserInterfaceOption;

   TRightClickMenu = class(TPersistent)
   private
      FDisableAllMenus: Boolean;
      FDefaultMenu: Boolean;
      FImageMenu: Boolean;
      FControlMenu: Boolean;
      FTableMenu: Boolean;
      FSelTextMenu: Boolean;
      FAnchorMenu: Boolean;
      FUnKnownMenu: Boolean;
      FImageArtMenu: Boolean;
      FImgDynSrcMenu: Boolean;
      FDebugMenu: Boolean;
   published
      property DisableAllMenus: Boolean read FDisableAllMenus write FDisableAllMenus default True;
      property DefaultMenu: Boolean read FDefaultMenu write FDefaultMenu default True;
      property ImageMenu: Boolean read FImageMenu write FImageMenu default True;
      property ControlMenu: Boolean read FControlMenu write FControlMenu default True;
      property TableMenu: Boolean read FTableMenu write FTableMenu default True;
      property SelTextMenu: Boolean read FSelTextMenu write FSelTextMenu default True;
      property AnchorMenu: Boolean read FAnchorMenu write FAnchorMenu default True;
      property UnKnownMenu: Boolean read FUnKnownMenu write FUnKnownMenu default True;
      property ImageArtMenu: Boolean read FImageArtMenu write FImageArtMenu default True;
      property ImgDynSrcMenu: Boolean read FImgDynSrcMenu write FImgDynSrcMenu default True;
      property DebugMenu: Boolean read FDebugMenu write FDebugMenu default True;
   end;

   TRightClickShortCuts = class(TPersistent)
   private
      FDisableBack: Boolean;
      FDisableForward: Boolean;
      FDisableSavePageBkg: Boolean;
      FDisableSetAsBkg: Boolean;
      FDisableCopyBkg: Boolean;
      FDisableSetAsDeskT: Boolean;
      FDisableSelectAll: Boolean;
      FDisablePaste: Boolean;
      FDisableCreateSC: Boolean;
      FDisableAddToFav: Boolean;
      FDisableEncoding: Boolean;
      FDisableRefresh: Boolean;
      FDisableViewSource: Boolean;
      FDisableProperties: Boolean;
      FDisablePrint: Boolean;
      FDisableOpenNWindow: Boolean;
      FDisableOpenLink: Boolean;
   published
      property DisableBack: Boolean read FDisableBack write FDisableBack default False;
      property DisableForward: Boolean read FDisableForward write FDisableForward default False;
      property DisableSavePageBkg: Boolean read FDisableSavePageBkg write FDisableSavePageBkg default False;
      property DisableSetAsBkg: Boolean read FDisableSetAsBkg write FDisableSetAsBkg default False;
      property DisableCopyBkg: Boolean read FDisableCopyBkg write FDisableCopyBkg default False;
      property DisableSetAsDesktopItem: Boolean read FDisableSetAsDeskT write FDisableSetAsDeskT default False;
      property DisableSelectAll: Boolean read FDisableSelectAll write FDisableSelectAll default False;
      property DisablePaste: Boolean read FDisablePaste write FDisablePaste default False;
      property DisableCreateShorcut: Boolean read FDisableCreateSC write FDisableCreateSC default False;
      property DisableAddToFav: Boolean read FDisableAddToFav write FDisableAddToFav default False;
      property DisableEncoding: Boolean read FDisableEncoding write FDisableEncoding default False;
      property DisableRefresh: Boolean read FDisableRefresh write FDisableRefresh default False;
      property DisableViewSource: Boolean read FDisableViewSource write FDisableViewSource default False;
      property DisableProperties: Boolean read FDisableProperties write FDisableProperties default False;
      property DisablePrint: Boolean read FDisablePrint write FDisablePrint default False;
      property DisableOpenInNewWindow: Boolean read FDisableOpenNWindow write FDisableOpenNWindow default False;
      property DisableOpenLink: Boolean read FDisableOpenLink write FDisableOpenLink default False;
   end;

   TShortCuts = class(TPersistent)
   private
      FCTRL_A: Boolean;
      FCTRL_C: Boolean;
      FCTRL_F: Boolean;
      FCTRL_N: Boolean;
      FCTRL_P: Boolean;
   published
      property DisableCTRL_A: Boolean read FCTRL_A write FCTRL_A default False;
      property DisableCTRL_C: Boolean read FCTRL_C write FCTRL_C default False;
      property DisableCTRL_F: Boolean read FCTRL_F write FCTRL_F default False;
      property DisableCTRL_N: Boolean read FCTRL_N write FCTRL_N default True;
      property DisableCTRL_P: Boolean read FCTRL_P write FCTRL_P default False;
   end;

   TProxySettings = class(TPersistent)
   private
      FPort: Integer;
      FServer: string;
      FAutoLoadProxy: Boolean;
   public
{$IFDEF USE_EwbTools}
      procedure SetProxy(FUserAgent, Server: string);
{$ENDIF}
   published
      property AutoLoadProxy: Boolean read FAutoLoadProxy write FAutoLoadProxy default False;
      property Port: Integer read FPort write FPort default 80;
      property Server: string read FServer write FServer;
   end;

   TMessagesBoxes = class(TPersistent)
   private
      FDisableAll: Boolean;
      FInternalErrMsg: Boolean;
      FReplaceCaption: Boolean;
      FReplaceIcon: Boolean;
      FNewCaption: string;
   published
      property DisableAll: Boolean read FDisableAll write FDisableAll default False;
      property InternalErrMsg: Boolean read FInternalErrMsg write FInternalErrMsg default True;
      property ReplaceCaption: Boolean read FReplaceCaption write FReplaceCaption default True;
      property ReplaceIcon: Boolean read FReplaceIcon write FReplaceIcon default True;
      property NewCaption: string read FNewCaption write FNewCaption;
   end;

   TDisableErrors = class(TPersistent)
   private
      FEnableDDE: Boolean;
      FfpExceptions: Boolean;
      FScriptErr: Boolean;
      procedure SetfpExceptions(const Value: Boolean);
   published
      property EnableDDE: Boolean read FEnableDDE write FEnableDDE default True;
      property fpExceptions: Boolean read FfpExceptions write SetfpExceptions default True;
      property ScriptError: Boolean read FScriptErr write FScriptErr default True;
   end;

   TVisualEffects = class(TPersistent)
   private
      FDisableSounds: Boolean;
      FTextSize: Integer;
   published
      property TextSize: Integer read FTextSize write FTextSize default 2;
      property DisableSounds: Boolean read FDisableSounds write FDisableSounds default False;
   end;

type
   TMeasure = (mMetric, mUS);
   TPrintOrientationOption = (poPortrait, poLandscape);
   TMargins = class(TPersistent)
   private
      FLeft: Real;
      FRight: Real;
      FTop: Real;
      FBottom: Real;
   published
      property Left: Real read FLeft write FLeft;
      property Right: Real read FRight write FRight;
      property Top: Real read FTop write FTop;
      property Bottom: Real read FBottom write FBottom;
   end;

   TPrintOptions = class(TPersistent)
   private
      FEnabled: Boolean;
      FHTMLHeader: TStrings;
      FHeader: string;
      FFooter: string;
      FMargins: TMargins;
      FOrientation: TPrintOrientationOption;
      FMeasure: TMeasure;
      procedure SetHTMLHeader(const Value: Tstrings);

   public
      HideSetup: Boolean;
      property Measure: TMeasure read FMeasure;
   published
      property Enabled: Boolean read FEnabled write FEnabled default False;
      property Margins: TMargins read FMargins write FMargins;
      property Header: string read FHeader write FHeader;
      property HTMLHeader: TStrings read FHTMLHeader write SetHTMLHeader;
      property Footer: string read FFooter write FFooter;
      property Orientation: TPrintOrientationOption read FOrientation write FOrientation;
   end;

   TVariantArray = array of OleVariant;

   TEmbeddedWB = class(TEWB,
         IDispatch, //http://msdn.microsoft.com/library/default.asp?url=/library/en-us/automat/html/ebbff4bc-36b2-4861-9efa-ffa45e013eb5.asp
         ICustomDoc,// http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/hosting/reference/ifaces/icustomdoc/icustomdoc.asp
         IDocHostShowUI, //http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/hosting/reference/ifaces/idochostshowui/idochostshowui.asp
         IDocHostUIHandler, //http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/hosting/reference/ifaces/idochostuihandler/idochostuihandler.asp
         IDocHostUIHandler2, //http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/hosting/reference/ifaces/dochostuihandler2/idochostuihandler2.asp
         IDownloadManager, //http://msdn.microsoft.com/workshop/browser/ext/reference/ifaces/idownloadmanager/idownloadmanager.asp
         IDropTarget, //http://msdn.microsoft.com/library/default.asp?url=/library/en-us/com/html/13fbe834-1ef8-4944-b2e4-9f5c413c65c8.asp
         IHTMLOMWindowServices, //http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/hosting/reference/ifaces/IHTMLOMWindowServices/IHTMLOMWindowServices.asp
         IInternetProtocolRoot, // http://msdn.microsoft.com/workshop/networking/pluggable/reference/ifaces/iinternetprotocolroot/iinternetprotocolroot.asp
         {$IFDEF USE_IOLECOMMANDTARGET}
         IOleCommandTarget, //http://msdn.microsoft.com/library/default.asp?url=/library/en-us/com/html/5c8b455e-7740-4f71-aef6-27390a11a1a3.asp
         {$ENDIF}
         INewWindowManager, //http://msdn.microsoft.com/library/default.asp?url=/library/en-us/shellcc/platform/shell/reference/ifaces/inewwindowmanager/evaluatenewwindow.asp
         {Internet Explorer 7 In the To-Do list} IProtectFocus, //http://msdn2.microsoft.com/en-us/library/aa361771.aspx
         IServiceProvider //http://msdn.microsoft.com/library/default.asp?url=/workshop/components/com/reference/ifaces/iserviceprovider/iserviceprovider.asp
         )

   private
      FAllowFocusChange: TAllowFocusChange;
      FProtSink: IInternetProtocolSink;
      FBindInfo: IInternetBindInfo;
      ActualHandle: HWND; //jls
      DDEHWND: THandle;
      FAbout: string;
      FDisableErrors: TDisableErrors;
      FDownloadControlOptions: TDownloadControlOptions;
      FDownloadOptionValue: Longint;
      FOnDownload: TDownloadEvent;
      FDragDrop: Boolean;
      FHelpFile: string;
      FMessagesBoxes: TMessagesBoxes;
      FModified: Boolean;
      FOldWindowProc: TWndMethod;
      FOnCloseQuery: TCloseQueryEvent;
      FOnDragEnterEvent: TOnDragEnterEvent;
      FOnDragLeaveEvent: TOnDragLeaveEvent;
      FOnDragOverEvent: TOnDragOverEvent;
      FOnDropEvent: TOnDropEvent;
      FOnEnableModeless: TEnableModelessEvent;
      FOnEvaluateNewWindow: TEvaluateNewWindowEvent;
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
      FOnMove: TMoveEvent;
      FOnMoveBy, FOnResizeBy: TMoveResizeByEvent;
      FOnOnDocWindowActivate: TOnDocWindowActivateEvent;
      FOnOnFrameWindowActivate: TOnFrameWindowActivateEvent;
      FOnQueryService: TQueryServiceEvent;
      FOnResize: TResizeEvent;
      FOnResizeBorder: TResizeBorderEvent;
      FOnShowContextMenu: TShowContextMenuEvent;
      FOnShowDialog: TShowDialogEvent;
      FOnShowHelp: TShowHelpEvent;
      FOnShowMessage: TShowMessageEvent;
      FOnShowUI: TShowUIEvent;
      FOnTranslateAccelerator: TTranslateAcceleratorEvent;
      FOnTranslateUrL: TTranslateUrlEvent;
      FOnUpdateUI: TUpdateUIEvent;
      FOptionKeyPath: string; //Serge
      FOverOptionKeyPath: Boolean; //Serge
      FParentForm: TForm;
      FPrintOptions: TPrintOptions;
      FProxySettings: TProxySettings;
      FRightClickMenu: TRightClickMenu;
      FRightClickShortCuts: TRightClickShortCuts;
      FSetUIHandler :TSetUIHandler;
      FShortCuts: TShortCuts;
      FUserAgent: string;
      FUserInterfaceOptions: TUserInterfaceOptions;
      FUserInterfaceValue: Cardinal;
      FVisualEffects: TVisualEffects;
      m_bResizing: Boolean;
      m_bWinXPSP2: Boolean;
      OldWBWndProc: TWndMethod;
      RuntimeMeasure: TMeasure;
{$IFDEF USE_IOLECOMMANDTARGET}
      FOnUnload: TUnloadEvent;
      FOnRefresh: TRefreshEvent;
      FOnScriptError: TScriptErrorEvent;
{$ENDIF}
{$IFDEF DELPHI_5_UP}
      SaveMessage: TMessageEvent;
{$ENDIF}
      function GetModified: Boolean;
      procedure DDEWndProc(var AMsg: Messages.TMessage);
      procedure FormWndProc(var AMsg: Messages.TMessage);
      procedure GetPrintValues;
      procedure Hook;
      procedure SetAbout(Value: string);
      procedure SetDownloadOptions(const Value: TDownloadControlOptions);
      procedure SetModified(Value: Boolean);
      procedure SetUserInterfaceOptions(const Value: TUserInterfaceOptions);
      procedure UnHook;
      procedure UpdateDownloadControlValue;
      procedure UpdateUserInterfaceValue;
{$IFDEF USE_EwbTools}
      procedure RemoveUserAgent;
      procedure SetUserAgent;
{$ENDIF}
   protected
{$IFDEF USE_IOLECOMMANDTARGET}
      function QueryStatus(CmdGroup: PGUID; cCmds: Cardinal;
         prgCmds: POleCmd; CmdText: POleCmdText): HRESULT; stdcall;
      function Exec(CmdGroup: PGUID; nCmdID, nCmdexecopt: DWORD;
         const vaIn: OleVariant; var vaOut: OleVariant): HRESULT; stdcall;
{$ENDIF}
{$IFDEF DELPHI_5_UP}
      procedure IEMessageHandler(var Msg: TMsg; var Handled: Boolean);
{$ENDIF}
      function DragEnter(const dataObj: IDataObject; grfKeyState: Longint;
         pt: TPoint; var dwEffect: Longint): HResult; stdcall;
{$WARNINGS OFF}
      function DragOver(grfKeyState: Longint; pt: TPoint; var dwEffect: Longint): HResult; stdcall;
{$WARNINGS ON}
      {Internet Explorer 7}
      function  AllowFocusChange(const pfAllow : Boolean): HRESULT;stdcall;
      function _AddRef: Integer; stdcall;
      function _Release: Integer; stdcall;
      function CopyOptionKeyPath(Overrided: Boolean): PWideChar; //Serge
      function DDEExecute(iwParam: WPARAM; ilParam: LPARAM): LRESULT;
      function DDEInitiate(iwParam: WPARAM; ilParam: LPARAM): LRESULT;
      function DDETerminate(iwParam: WPARAM; ilParam: LPARAM): BOOL;
      function Download(
         pmk: IMoniker; // Identifies the object to be downloaded
         pbc: IBindCtx; // Stores information used by the moniker to bind
         dwBindVerb: DWORD; // The action to be performed during the bind
         grfBINDF: DWORD; // Determines the use of URL encoding during the bind
         pBindInfo: PBindInfo; // Used to implement IBindStatusCallback::GetBindInfo
         pszHeaders: PWidechar; // Additional headers to use with IHttpNegotiate
         pszRedir: PWidechar; // The URL that the moniker is redirected to
         uiCP: UINT // The code page of the object's display name
         ): HRESULT; stdcall;
    {IInternetProtocolRoot Interface}
      function Start(szUrl: PWideChar; OIProtSink: IInternetProtocolSink;
         OIBindInfo: IInternetBindInfo; grfPI, dwReserved: DWORD): HResult; stdcall;
      function Continue(const ProtocolData: TProtocolData): HResult; stdcall;
      function Abort(hrReason: HResult; dwOptions: DWORD): HResult; stdcall;
      function Terminate(dwOptions: DWORD): HResult; stdcall;
      function Suspend: HResult; stdcall;
      function Resume: HResult; stdcall;
      function Read(pv: Pointer; cb: ULONG; out cbRead: ULONG): HResult; stdcall;
      function Seek(dlibMove: LARGE_INTEGER; dwOrigin: DWORD; out libNewPosition: ULARGE_INTEGER): HResult; stdcall;
      function LockRequest(dwOptions: DWORD): HResult; stdcall;
      function UnlockRequest: HResult; stdcall;
      function DragLeave: HResult; stdcall;
      function Drop(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint;
         var dwEffect: Longint): HResult; stdcall;
      function EnableModeless(const fEnable: BOOL): HRESULT; stdcall;
      function EvaluateNewWindow(pszUrl, pszName, pszUrlContext, pszFeatures: LPCWSTR;
         fReplace: BOOL; dwFlags, dwUserActionTime: DWORD): HRESULT; stdcall;
      function FilterDataObject(const pDO: IDataObject; out ppDORet: IDataObject): HRESULT; stdcall;
      function GetDropTarget(const pDropTarget: IDropTarget;
         out ppDropTarget: IDropTarget): HRESULT; stdcall;
      function GetExternal(out ppDispatch: IDispatch): HRESULT; stdcall;
      function GetHostInfo(var pInfo: TDOCHOSTUIINFO): HRESULT; stdcall;
      function GetIDsOfNames(const IID: TGUID; Names: Pointer;
         NameCount, LocaleID: Integer; DispIDs: Pointer): HRESULT; stdcall;
      function GetOptionKeyPath(var pchKey: POleStr; const dw: DWORD): HRESULT; stdcall;
      function GetOverrideKeyPath(pchKey: POleStr; dw: DWORD): HRESULT; stdcall;
      function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HRESULT; stdcall;
      function GetTypeInfoCount(out Count: Integer): HRESULT; stdcall;
      function HideUI: HRESULT; stdcall;
      function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
         Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HRESULT; stdcall;
      function moveBy(const x, y: Integer): HRESULT; stdcall;
      function moveTo(const x, y: Integer): HRESULT; stdcall;
      function OnDocWindowActivate(const fActivate: BOOL): HRESULT; stdcall;
      function OnFrameWindowActivate(const fActivate: BOOL): HRESULT; stdcall;
      function PrintMarginStr(M: Real): PChar;
      function QueryService(const rsid, iid: TGUID; out Obj): HRESULT; stdcall;
      function ResizeBorder(const prcBorder: PRECT; const pUIWindow: IOleInPlaceUIWindow;
         const FrameWindow: BOOL): HRESULT; stdcall;
      function resizeBy(const x, y: Integer): HRESULT; stdcall;
      function resizeTo(const x, y: Integer): HRESULT; stdcall;
      function SetUIHandler(const pUIHandler: IDocHostUIHandler): HRESULT; stdcall;
      function ShowContextMenu(const dwID: DWORD; const ppt: PPOINT;
         const pcmdtReserved: IUnknown; const pdispReserved: IDispatch): HRESULT; stdcall;
      function ShowHelp(HWND: THandle; pszHelpFile: POleStr; uCommand: Integer;
         dwData: Longint; ptMouse: TPoint; var pDispatchObjectHit: IDispatch): HRESULT; stdcall;
      function ShowMessage(HWND: THandle; lpstrText: POleStr; lpstrCaption: POleStr;
         dwType: Longint; lpstrHelpFile: POleStr; dwHelpContext: Longint;
         var plResult: LRESULT): HRESULT; stdcall;
      function ShowUI(const dwID: DWORD; const pActiveObject: IOleInPlaceActiveObject;
         const pCommandTarget: IOleCommandTarget; const pFrame: IOleInPlaceFrame;
         const pDoc: IOleInPlaceUIWindow): HRESULT; stdcall;
      function TranslateAccelerator(const lpMsg: PMSG; const pguidCmdGroup: PGUID;
         const nCmdID: DWORD): HRESULT; stdcall;
      function TranslateUrl(const dwTranslate: DWORD; const pchURLIn: POleStr;
         var ppchURLOut: POleStr): HRESULT; stdcall;
      function UpdateUI: HRESULT; stdcall;
      procedure CreateWnd; override; //jls
      procedure DestroyWnd; override; //jls
      procedure DropEffect(grfKeyState: Longint; var dwEffect: longint); virtual;
   public
      GlobalModelessCounter: Integer;
      SecurityManager: IInternetSecurityManager;
      ZoneManager: IInternetZoneManager;
{$IFDEF USE_EwbTools}
      function AddHtmlToAboutBlank(StringToHtml: string): Boolean;
      function CheckIfInRestricredList(URL: string): Boolean;
      function CheckIfInTrustedList(URL: string): Boolean;
      function CheckOnlineStatus: Boolean;
      function DownloadFile(SourceFile, DestFile: string): Boolean;
      function EncodeUrl(const InputStr: string; const bQueryStr: Boolean): string;
      function DecodeUrl(const InputStr: string): string;
      function IsValidProtocol(const URL: string): Boolean;
      function FillForm(FieldName: string; Value: string): Boolean;
      function FrameCount: LongInt;
      function FrameCountFromDocument(SourceDoc: IHtmlDocument2): Integer;
      function GetBmpFromBrowser(FileName: string): Boolean;
      function GetCachedFileFromURL(strUL: string; var strLocalFile: string): Boolean;
      function GetCookie: string;
      function GetCookiesPath: string;
      function GetDefaultBrowserFromRegistry: string;
      function GetFavoritesPath: string;
      function GetFrameFromDocument(SourceDoc: IHtmlDocument2; FrameNo: Integer): IWebBrowser2;
      function GetHistoryPath: string;
      function GetIEHandle(WebBrowser: TEmbeddedWB; ClassName: string): HWND;
      function GetIPAndHostName(var HostName, IPaddr, WSAErr: string): Boolean;
      function GetJpegFromBrowser(FileName: string; SourceHeight, SourceWidth,
         TargetHeight, TargetWidth: Integer): Boolean;
      function GetLastVisitedPage(var LastVisitedPage: string): Boolean;
      function GetSpecialFolderPath(CallerHandle: THandle; CSIDL: Integer): PChar;
      function GetSSLStatus(var SSLName, SSLDescription: string): Boolean;
      function GetURLSecurityZone(var ZoneName, ZoneDescription: string; var Icon: TIcon): Boolean;
      function GetZoneAttributes(const URL: string): TZoneAttributes;
      function GetZoneIconToForm: Boolean;
      function IsGlobalOffline: Boolean;
      function NavigateToFrame(FrameList: string): IHtmlDocument2;
      function OpenAddressBook: Boolean;
      function OpenCalendar: Boolean;
      function OpenClient(Client: string): Boolean;
      function OpenEudoraMail: Boolean;
      function OpenGoogleMail: Boolean;
      function OpenHotmailMail: Boolean;
      function OpenNetMeeting: Boolean;
      function OpenNewsClient: Boolean;
      function OpenOutlookExpressMail: Boolean;
      function OpenOutlookMail: Boolean;
      function OpenRegistryEditor: Boolean;
      function OpenYahooMail: Boolean;
      function SaveDialogEx: string;
      function SaveLastVisitedPage: Boolean;
      function SearchString(const strText: string): Boolean;
      function SearchText(const Value: string; const iPos: Integer = 1): IHTMLTxtRange; //by JJM
      function SetCharartersSet(const ACharactersSet: string): Boolean;
      function URLFromFavorites(const dotURL: string): string;
      function UrlFromHistory(ShellFolder: IShellFolder; pidl: PItemIDList): string;
      function ZoomRangeHigh: Integer;
      function ZoomRangeLow: Integer;
      function ZoomValue: Integer;
      procedure AddToFavorites(URL, Title: string);
      procedure AddToRestrictedSiteList(URL: string);
      procedure AddToTrustedSiteList(URL: string);
      procedure AutoFillIEFormAndExcecute;
      procedure ClearCache;
      procedure ClearHistory;
      procedure ClearTypedUrls;
      procedure CreateDesktopShortcut;
      procedure CreateNewMail;
      procedure DisableNavSound(bDisable: Boolean);
      procedure ExploreFolder(Path: string);
      procedure GetThumbnail(var Image: TImage);
      procedure GetZoneIcon(IconPath: string; var Icon: TIcon);
      procedure GoAboutBlank;
      procedure GoDownloadFile(URL: string);
      procedure GoDownloadMaskedFile(SourceFile, TargetFile: string; Notify: Boolean);
      procedure GoNoHistory(const URL: string);
      procedure GoSearchInGoogle(SearchTerm: string);
      procedure GoSearchInMSN(SearchTerm: string);
      procedure GoSearchInYahoo(SearchTerm: string);
      procedure GoWithQueryDetails(Url, Query: string);
      procedure LoadFromImage(Image: TImage);
      procedure NavigateFolder(CSIDL: Integer);
      procedure OpenDialog;
      procedure OpenIEBrowserWithAddress;
      procedure OpenOtherWBFavorites;
      procedure PageSetup(UsePrintOptions: Boolean);
      procedure Print;
      procedure PrintPreview;
      procedure PrintPreviewExtended(nCMDShow: Integer);
      procedure PrintSetup;
      procedure PrintWithOptions;
      procedure RestoreApplicationFormSize;
      procedure SaveApplicationFormSize;
      procedure SaveDialog;
      procedure SaveImagesDialog;
      procedure SavePageTextDialog;
      procedure ScrollToBottom;
      procedure ScrollToPosition(X, Y: Integer);
      procedure ScrollToTop;
      procedure SearchAndHighlight(const ACaption, APrompt: string; aText: string = '';
         ShowInputQuery: Boolean = False);
      procedure SendPageInMailAsAttachment(aOwner: TComponent; FileName, Subject, Body: string);
      procedure SendURLInMail;
      procedure SetNewHomePage(HomePage: string);
      procedure ShowFindDialog;
      procedure ShowIEVersionInfo;
      procedure ShowImportExportFavoritesAndCookies;
      procedure ShowInternetOptions;
      procedure ShowOrganizeFavorites;
      procedure ShowPageProperties;
      procedure ViewPageFieldsToStrings(FieldList: TStrings);
      procedure ViewPageImagesToStrings(ImagesList: TStrings);
      procedure ViewPageLinksToStrings(LinksList: TStrings);
      procedure ViewPagePropertiesToStrings(PropertiesList: TStrings);
      procedure ViewPageSourceHtml;
      procedure ViewPageSourceHtmlToStrings(HtmlList: TStrings);
      procedure ViewPageSourceText;
      procedure ViewPageSourceTextToStrings(TextList: TStrings);
      procedure WorkOffline;
      procedure WorkOnline;
      procedure Zoom(ZoomValue: Integer);
{$ENDIF}
      constructor Create(Owner: TComponent); override;
      destructor Destroy; override;
{$IFDEF DELPHI_5_UP}
      procedure EnableMessageHandler;
      procedure DisableMessageHandler;
{$ENDIF}
      function DesignMode(): Boolean;
      function DocumentLoaded: Boolean;
      function GetDocument: IHtmlDocument2;
      function GetFrame(FrameNo: Integer): IWebbrowser2;
      function GetIEHomePage: string;
      function ImportCertFile(AFileName, AStoreType: string): Boolean;
      function LoadFrameFromStream(FrameNo: Integer; AStream: TStream): HRESULT;
      function LoadFrameFromStrings(Frameno: Integer; const AStrings: TStrings): HRESULT;
      function LoadFromStream(const AStream: TStream): HRESULT;
      function LoadFromStrings(const AStrings: TStrings): HRESULT; overload;
      function LoadFromStrings(const AStrings: TStrings; AddHtmlTags: Boolean): HRESULT; overload;
      function SaveFrameToFile(FrameNo: Integer; const FName: string): HRESULT;
      function SaveFrameToStream(FrameNo: Integer; AStream: TStream): HRESULT;
      function SaveFrameToStrings(FrameNo: Integer; AStrings: TStrings): HRESULT;
      function SaveToFile(const FName: string): HRESULT;
      function SaveToStream(AStream: TStream): HRESULT;
      function SaveToStrings(AStrings: TStrings): HRESULT;
      function VariantIsObject(const value: OleVariant): Boolean;
      procedure AssignEmptyDocument;
      procedure Copy;
      procedure Cut;
      procedure Go(Url: string);
      procedure InvokeCMD(InvokeIE: Boolean; Value1, Value2: Integer; var vaIn, vaOut: OleVariant);
      procedure Loaded; override;
      procedure NavigatePidl(pidl: PItemIdlist);
      procedure Paste;
      procedure SelectAll;
      procedure SetFocusToDoc;
      procedure SetFocusToParent;
      procedure Wait;
      procedure WBWndProc(var Message: Messages.TMessage);
      property Modified: Boolean read GetModified write SetModified;
   published
      property About: string read FAbout write SetAbout;
      property DisableErrors: TDisableErrors read FDisableErrors write FDisableErrors;
      property DownloadOptions: TDownloadControlOptions read FDownloadControlOptions
         write SetDownloadOptions;
      property EnableDragAndDrop: Boolean read FDragDrop write FDragDrop default True;
      property HelpFile: string read FHelpFile write FHelpFile;
      property MessagesBoxes: TMessagesBoxes read FMessagesBoxes write FMessagesBoxes;
      property OnCloseQuery: TCloseQueryEvent read FOnCloseQuery write FOnCloseQuery;
      property OnDragEnter: TOnDragEnterEvent read FOnDragEnterEvent write FOnDragEnterEvent;
      property OnDragLeave: TOnDragLeaveEvent read FOnDragLeaveEvent write FOnDragLeaveEvent;
      property OnDragOver2: TOnDragOverEvent read FOnDragOverEvent write FOnDragOverEvent;
      property OnDropEvent: TOnDropEvent read FOnDropEvent write FOnDropEvent;
      property OnEnableModeless: TEnableModelessEvent read FOnEnableModeless
         write FOnEnableModeless;
      property OnEvaluateNewWindow: TEvaluateNewWindowEvent read FOnEvaluateNewWindow
         write FOnEvaluateNewWindow;
      property OnFileDownload: TDownloadEvent read FOnDownload write FOnDownload;
      property OnFilterDataObject: TFilterDataObjectEvent read FOnFilterDataObject
         write FOnFilterDataObject;
      property OnGetDropTarget: TGetDropTargetEvent read FOnGetDropTarget write FOnGetDropTarget;
      property OnGetExternal: TGetExternalEvent read FOnGetExternal write FOnGetExternal;
      property OnGetHostInfo: TGetHostInfoEvent read FOnGethostinfo write fongethostinfo;
      property OnGetIDsOfNames: TGetIDsOfNamesEvent read FOnGetIDsOfNames write FOnGetIdsOfNames;
      property OnGetOptionKeyPath: TGetOptionKeyPathEvent read FOnGetOptionKeyPath
         write FOnGetOptionKeyPath;
      property OnGetOverrideKeyPath: TGetOVerrideKeypathEvent read FOnGetOverrideKeyPath
         write FOnGetOverrideKeyPath;
      property OnGetTypeInfo: TGetTypeInfoEvent read FonGetTypeInfo write FOnGetTypeInfo;
      property OnGetTypeInfoCount: TGetTypeInfoCountEvent read FonGetTypeInfoCount
         write FOnGetTypeInfoCount;
      property OnHideUI: THideUIEvent read FOnHideUI write FOnHideUI;
      property OnInvoke: TInvokeEvent read FOnInvoke write FOnInvoke;
      property OnMove: TMoveEvent read FOnMove write FOnMove;
      property OnMoveBy: TMoveResizeByEvent read FOnMoveBy write FOnMoveBy;
      property OnOnDocWindowActivate: TOnDocWindowActivateEvent read FOnOnDocWindowActivate
         write FOnOnDocWindowActivate;
      property OnOnFrameWindowActivate: TOnFrameWindowActivateEvent read FOnOnFrameWindowActivate
         write FOnOnFrameWindowActivate;
      property OnQueryService: TQueryServiceEvent read FOnQueryService write FOnQueryService;
      property OnResize: TResizeEvent read FOnResize write FOnResize;
      property OnResizeBorder: TResizeBorderEvent read FOnResizeBorder write FOnResizeBorder;
      property OnResizeBy: TMoveResizeByEvent read FOnResizeBy write FOnResizeBy;
      property OnSetUIHandler: TSetUIHandler read FSetUIHandler write FSetUIHandler;
      property OnShowContextMenu: TShowContextMenuEvent read FOnShowContextmenu
         write FOnShowContextmenu;
      property OnShowDialog: TShowDialogEvent read FOnShowDialog write FOnShowDialog;
      property OnShowHelp: TShowHelpEvent read FOnShowHelp write FOnShowHelp;
      property OnShowMessage: TShowMessageEvent read FOnShowMessage write FOnShowMessage;
      property OnShowUI: TShowUIEvent read FOnShowUI write FOnShowUI;
      property OnTranslateAccelerator: TTranslateAcceleratorEvent read FOnTranslateAccelerator
         write FOnTranslateAccelerator;
      property OnTranslateUrl: TTranslateUrlEvent read FOnTranslateUrL write FOnTranslateUrL;
      property OnUpdateUI: TUpdateUIEvent read FOnUpdateUI write FOnUpdateUI;
      property UserInterfaceOptions: TUserInterfaceOptions read FUserInterfaceOptions
         write SetUserInterfaceOptions;
{$IFDEF USE_IOLECOMMANDTARGET}
      property OnRefresh: TRefreshEvent read FOnRefresh write FOnRefresh;
      property OnScriptError: TScriptErrorEvent read FOnScriptError write FOnScriptError;
      property OnUnload: TUnloadEvent read FOnUnload write FOnUnload;
{$ENDIF}
      property OptionKeyPath: string read fOptionKeyPath write fOptionKeyPath; //Serge
      property OverrideOptionKeyPath: Boolean read fOverOptionKeyPath write fOverOptionKeyPath default False; //Serge
      property PrintOptions: TPrintOptions read FPrintOptions write FPrintOptions;
      property ProxySettings: TProxySettings read FProxySettings write FProxySettings;
      property RightClickMenu: TRightClickMenu read FRightClickMenu write FRightClickMenu;
      property RightClickShortCuts: TRightClickShortCuts read FRightClickShortCuts
         write FRightClickShortCuts;
      property ShortCuts: TShortCuts read FShortCuts write FShortCuts;
      property UserAgent: string read FUserAgent write FUserAgent;
      property VisualEffects: TVisualEffects read FVisualEffects write FVisualEffects;
   end;

implementation

uses
{$IFDEF USE_EwbTools}EWBTools, {$ENDIF}
   Registry, SysUtils, Dialogs, Wcrypt2, ComObj, ShellAPI, OleServer, IEConst;

var
   FindFolder, OpenFolder, ExploreFolder, HtmlFileApp, HtmlFileTopic: string; //All DDE variables
   fHtmlCommand, DontRespond: Boolean;
   FoldersApp, FoldersTopic: string;
   Saved8087CW: Word;
   InvokingPageSetup: Boolean;
   PrintingWithOptions: Boolean;
{$IFDEF DELPHI_5_UP}
   bMsgHandler: Boolean;
{$ENDIF}

type
   OSVERSIONINFOEX = packed record
      dwOSVersionInfoSize: DWORD;
      dwMajorVersion: DWORD;
      dwMinorVersion: DWORD;
      dwBuildNumber: DWORD;
      dwPlatformId: DWORD;
      szCSDVersion: array[0..127] of Char;
      wServicePackMajor: WORD;
      wServicePackMinor: WORD;
      wSuiteMask: WORD;
      wProductType: BYTE;
      wReserved: BYTE;
   end;
   TOSVersionInfoEx = OSVERSIONINFOEX;
   POSVersionInfoEx = ^TOSVersionInfoEx;

const
   VER_GREATER_EQUAL = 3;
   VER_MINORVERSION = $0000001;
   VER_MAJORVERSION = $0000002;
   VER_SERVICEPACKMINOR = $0000010;
   VER_SERVICEPACKMAJOR = $0000020;

type
   fn_VerifyVersionInfo = function(var VersionInformation: OSVERSIONINFOEX;
      dwTypeMask: DWORD; dwlConditionMask: LONGLONG): BOOL; stdcall;
   fn_VerSetConditionMask = function(ConditionMask: LONGLONG; TypeMask: DWORD;
      Condition: Byte): LONGLONG; stdcall;

function IsWinXPSP2OrLater(): Boolean;
var
   osvi: TOSVersionInfoEx;
   dwlConditionMask: LONGLONG;
   op: Integer;
   hlib: THandle;
   VerifyVersionInfo: fn_VerifyVersionInfo;
   VerSetConditionMask: fn_VerSetConditionMask;
begin
   result := false;

   hLib := LoadLibrary('kernel32.dll');
   if (hLib <> 0) then
      begin
         @VerifyVersionInfo := GetProcAddress(hLib, 'VerifyVersionInfoA');
         @VerSetConditionMask := GetProcAddress(hLib, 'VerSetConditionMask');
         if ((@VerifyVersionInfo = nil) or (@VerSetConditionMask = nil)) then
            Exit;

         dwlConditionMask := 0;
         op := VER_GREATER_EQUAL;

    // Initialize the OSVERSIONINFOEX structure.
         ZeroMemory(@osvi, sizeof(OSVERSIONINFOEX));
         osvi.dwOSVersionInfoSize := sizeof(OSVERSIONINFOEX);
         osvi.dwMajorVersion := 5;
         osvi.dwMinorVersion := 1;
         osvi.wServicePackMajor := 2;
         osvi.wServicePackMinor := 0;

    // Initialize the condition mask.
         dwlConditionMask := VerSetConditionMask(dwlConditionMask, VER_MAJORVERSION, op);
         dwlConditionMask := VerSetConditionMask(dwlConditionMask, VER_MINORVERSION, op);
         dwlConditionMask := VerSetConditionMask(dwlConditionMask, VER_SERVICEPACKMAJOR, op);
         dwlConditionMask := VerSetConditionMask(dwlConditionMask, VER_SERVICEPACKMINOR, op);

    // Perform the test.
         result := VerifyVersionInfo(osvi, VER_MAJORVERSION or VER_MINORVERSION or
            VER_SERVICEPACKMAJOR or VER_SERVICEPACKMINOR, dwlConditionMask);
      end;
end;

function TEmbeddedWB.AllowFocusChange(const pfAllow : Boolean): HRESULT;
begin  //Internet Explorer 7
     if Assigned(FAllowFocusChange) then
       Result := FAllowFocusChange(pfAllow)
   else
      Result := S_FALSE;
end;

function TEmbeddedWB.SetUIHandler(const pUIHandler : IDocHostUIHandler):HRESULT;
begin
   if Assigned(FSetUIHandler) then
      Result := FSetUIHandler(pUIHandler)
   else
      Result := S_FALSE;
end;
//==============================================================================

function TEmbeddedWB.Start(szUrl: PWideChar; OIProtSink: IInternetProtocolSink;
   OIBindInfo: IInternetBindInfo; grfPI, dwReserved: DWORD): HResult; stdcall;
var
   iNeg: iHTTPNegotiate;
   szHeaders, szAdditionalHeaders: pWideChar;
   SrvProv: iServiceProvider;
begin
   FProtSink := OIProtSink;
   FBindInfo := OIBindInfo;

   (OIProtSink as iUnknown).QueryInterface(IServiceProvider, SrvProv);
   SrvProv.QueryService(IID_IHTTPNegotiate, IID_IHTTPNegotiate, iNeg);
   if Assigned(iNeg) then
      begin
         szHeaders := nil;
         szAdditionalHeaders := nil;
         iNeg.BeginningTransaction(szUrl, szHeaders, 0, szAdditionalHeaders);
      end;

   Result := inet_e_use_default_protocolhandler;
end;

function TEmbeddedWB.Read(pv: Pointer; cb: ULONG; out cbRead: ULONG): HResult;
begin
   Result := S_OK;
end;

function TEmbeddedWB.Terminate(dwOptions: DWORD): HResult; stdcall;
begin
   Result := S_OK;
end;

function TEmbeddedWB.LockRequest(dwOptions: DWORD): HResult; stdcall;
begin
   Result := S_OK;
end;

function TEmbeddedWB.UnlockRequest: HResult;
begin
   Result := S_OK;
end;

function TEmbeddedWB.Continue(const ProtocolData: TProtocolData): HResult;
begin
   Result := S_OK;
end;

function TEmbeddedWB.Abort(hrReason: HResult; dwOptions: DWORD): HResult; stdcall;
begin
   Result := E_NOTIMPL;
end;

function TEmbeddedWB.Suspend: HResult; stdcall;
begin
   Result := E_NOTIMPL;
end;

function TEmbeddedWB.Resume: HResult; stdcall;
begin
   Result := E_NOTIMPL;
end;

function TEmbeddedWB.Seek(dlibMove: LARGE_INTEGER; dwOrigin: DWORD;
   out libNewPosition: ULARGE_INTEGER): HResult;
begin
   Result := E_NOTIMPL;
end;

//Drag And Drop ----------------------------------------------------------------
procedure TEmbeddedWB.DropEffect(grfKeyState: Longint; var dwEffect: longint);
begin
   if (grfKeyState and MK_CONTROL = 0) and (grfKeyState and MK_SHIFT <> 0) and
      (dwEffect and DropEffect_Move <> 0) then
      dwEffect := DropEffect_Move
   else
      if (grfKeyState and MK_CONTROL <> 0) and (grfKeyState and MK_SHIFT <> 0) and
         (dwEffect and DropEffect_Link <> 0) then
         dwEffect := DropEffect_Link
      else
         if (dwEffect and DropEffect_Copy <> 0) then
            dwEffect := DropEffect_Copy
         else
            if (dwEffect and DropEffect_Move <> 0) then
               dwEffect := DropEffect_Move
            else
               if (dwEffect and DropEffect_Link <> 0) then
                  dwEffect := DropEffect_Link
               else
                  dwEffect := DropEffect_None;
end;

function dwEffectToStr(Command: Int64): string;
const
   E_UNSPEC = E_Fail;
begin
   case (Command) of
      DROPEFFECT_NONE: Result := 'Drop target cannot accept the data.';
      DROPEFFECT_COPY: Result := 'Drag source should copy the data.';
      DROPEFFECT_MOVE: Result := 'Drag source should remove the data.';
      DROPEFFECT_LINK: Result := 'Drag source should create a link to the original data.';
      DRAGDROP_S_DROP: Result := 'The drag-and-drop operation was successful.';
      DRAGDROP_S_CANCEL: Result := 'The drag-and-drop operation was canceled.';
      DRAGDROP_S_USEDEFAULTCURSORS: Result := 'Successful completion. Restoring defaults.';
      DRAGDROP_E_INVALIDHWND: Result := 'Invalid handle returned in the hwnd parameter.';
      DRAGDROP_E_NOTREGISTERED: Result := 'Failed to revoke a drop target that has not been registered.';
      E_UNSPEC: Result := 'Unexpected error occurred.';
      E_OUTOFMEMORY: Result := 'Out of memory.';
      7: Result := 'operation was successful.';
      else
         Result := 'Unknown.';
   end;
end;

function TEmbeddedWB.DragEnter(const dataObj: IDataObject; grfKeyState: Longint;
   pt: TPoint; var dwEffect: Longint): HResult;
begin
   if not FDragDrop then
      begin
         dwEffect := DropEffect_None;
         Result := NOERROR;
         RevokeDragDrop(Self.Handle);
         Exit;
      end;
   if Assigned(FOnDragEnterEvent) then
      begin
         Result := FOnDragEnterEvent(dataObj, grfKeyState, Self.ClientToScreen(pt),
            dwEffect, dwEffectToStr(dwEffect));
         DropEffect(grfKeyState, dwEffect);
      end
   else
      Result := NOERROR;
end;

function TEmbeddedWB.DragOver(grfKeyState: Longint; pt: TPoint; var dwEffect: Longint): HResult;
begin
   if not FDragDrop then
      begin
         dwEffect := DropEffect_None;
         RevokeDragDrop(Self.Handle);
         Result := NOERROR;
         Exit;
      end;
   DropEffect(grfKeyState, dwEffect);
   if Assigned(FOnDragOverEvent) then
      Result := FOnDragOverEvent(grfKeyState, Self.ClientToScreen(pt),
         dwEffect, dwEffectToStr(dwEffect))
   else
      Result := NOERROR;
end;

function TEmbeddedWB.DragLeave: HResult;
begin
   if Assigned(FOnDragLeaveEvent) then
      Result := FOnDragLeaveEvent
   else
      Result := NOERROR;
end;

function TEmbeddedWB._AddRef: Integer;
begin
   Result := 1;
end;

function TEmbeddedWB._Release: Integer;
begin
   Result := 1;
end;

function TEmbeddedWB.Drop(const dataObj: IDataObject; grfKeyState: Longint; pt: TPoint;
   var dwEffect: Longint): HResult;
begin
   if not FDragDrop then
      begin
         dwEffect := DropEffect_None;
         RevokeDragDrop(Self.Handle);
         Result := NOERROR;
         Exit;
      end;
   Result := S_OK;
   if Assigned(FOnDropEvent) then
      Result := FOnDropEvent(dataObj, grfKeyState, Self.ClientToScreen(pt),
         dwEffect, dwEffectToStr(dwEffect));
   if (dataObj = nil) then
      raise
         Exception.Create('IDataObject-Pointer is not valid!');
end;
//Drag And Drop End-------------------------------------------------------------

procedure DisposePIDL(ID: PItemIDList);
var
   Malloc: IMalloc;
begin
   if ID = nil then
      Exit;
   OLECheck(SHGetMalloc(Malloc));
   Malloc.Free(ID);
end;

function CopyITEMID(Malloc: IMalloc; ID: PItemIDList): PItemIDList;
begin
   Result := Malloc.Alloc(ID^.mkid.cb + SizeOf(ID^.mkid.cb));
   CopyMemory(Result, ID, ID^.mkid.cb + SizeOf(ID^.mkid.cb));
end;

function NextPIDL(IDList: PItemIDList): PItemIDList;
begin
   Result := IDList;
   Inc(PChar(Result), IDList^.mkid.cb);
end;

function GetPIDLSize(IDList: PItemIDList): Integer;
begin
   Result := 0;
   if Assigned(IDList) then
      begin
         Result := SizeOf(IDList^.mkid.cb);
         while IDList^.mkid.cb <> 0 do
            begin
               Result := Result + IDList^.mkid.cb;
               IDList := NextPIDL(IDList);
            end;
      end;
end;

procedure StripLastID(IDList: PItemIDList);
var
   MarkerID: PItemIDList;
begin
   MarkerID := IDList;
   if Assigned(IDList) then
      begin
         while IDList.mkid.cb <> 0 do
            begin
               MarkerID := IDList;
               IDList := NextPIDL(IDList);
            end;
         MarkerID.mkid.cb := 0;
      end;
end;

function CreatePIDL(Size: Integer): PItemIDList;
var
   Malloc: IMalloc;
   HR: HResult;
begin
   Result := nil;
   HR := SHGetMalloc(Malloc);
   if Failed(HR) then
      Exit;
   try
      Result := Malloc.Alloc(Size);
      if Assigned(Result) then
         FillChar(Result^, Size, 0);
   finally
   end;
end;

function CopyPIDL(IDList: PItemIDList): PItemIDList;
var
   Size: Integer;
begin
   Size := GetPIDLSize(IDList);
   Result := CreatePIDL(Size);
   if Assigned(Result) then
      CopyMemory(Result, IDList, Size);
end;

function ConcatPIDLs(IDList1, IDList2: PItemIDList): PItemIDList;
var
   cb1, cb2: Integer;
begin
   if Assigned(IDList1) then
      cb1 := GetPIDLSize(IDList1) - SizeOf(IDList1^.mkid.cb)
   else
      cb1 := 0;
   cb2 := GetPIDLSize(IDList2);
   Result := CreatePIDL(cb1 + cb2);
   if Assigned(Result) then
      begin
         if Assigned(IDList1) then
            CopyMemory(Result, IDList1, cb1);
         CopyMemory(PChar(Result) + cb1, IDList2, cb2);
      end;
end;

function SaveDocToStrings(Doc: IDispatch; var AStrings: TStrings): HResult;
var
   IpStream: IPersistStreamInit;
   AStream: TMemoryStream;
begin
   AStream := TMemoryStream.Create;
   try
      IpStream := doc as IPersistStreamInit;
      if not Assigned(IpStream) then
         Result := S_False
      else
         if Succeeded(IpStream.save(TStreamadapter.Create(AStream), True))
            then
            begin
               AStream.Seek(0, 0);
               AStrings.LoadFromStream(AStream);
               Result := S_OK;
            end
         else
            Result := S_False;
   except
      Result := S_False;
   end;
   AStream.Free;
end;

function SaveDocToStream(Doc: IDispatch; var AStream: TStream): HResult;
var
   IpStream: IPersistStreamInit;
begin
   if Doc <> nil then
      begin
         IpStream := Doc as IPersistStreamInit;
         Result := IpStream.save(TStreamAdapter.Create(AStream), True);
      end
   else
      Result := S_False;
end;

function SaveDocToFile(Doc: IDispatch; const FName: string): HResult;
var
   PFile: IPersistFile;
begin
   PFile := Doc as IPersistFile;
   Result := PFile.Save(StringToOleStr(FName), False);
end;

function GetRunTimeMeasure: TMeasure;
var
   Buf: array[1..10] of Char;
begin
   FillChar(Buf, SizeOf(Buf), 0);
   GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_IMEASURE, @Buf[1], SizeOf(Buf));
   if Buf[1] = '1' then
      Result := mUS
   else
      Result := mMetric;
end;

function TEmbeddedWB.GetModified: Boolean;
begin
   Result := FModified;
end;

procedure TEmbeddedWB.SetModified(Value: Boolean);
var
   Doc: IHTMLDocument2;
begin
   if ((not FModified) and (READYSTATE = READYSTATE_COMPLETE)) then
      begin
         Doc := Document as IHTMLDocument2;
         if doc <> nil then
            FModified := Doc.QueryCommandEnabled('Undo');
      end;
end;

function TEmbeddedWB.VariantIsObject(const Value: OleVariant): Boolean;
begin
   Result := (VarType(Value) = varDispatch);
end;

procedure TPrintOptions.SetHTMLHeader(const Value: Tstrings);
begin
   FHTMLHeader.Assign(Value);
end;

//DDE stuff  -------------------------------------------------------------------

function GetDDEVariables: Boolean;
var
   s: string;
   Reg: TRegistry;
begin
   Reg := Tregistry.Create;
   with Reg do
      try
         RootKey := HKEY_CLASSES_ROOT;
         OpenKey('htmlfile\shell\open\ddeexec\application', False);
         HtmlFileApp := Readstring('');
         CloseKey;
         OpenKey('htmlfile\shell\open\ddeexec\topic', False);
         HtmlFileTopic := ReadString('');
         CloseKey;
         OpenKey('Folder\shell\open\ddeexec\application', False);
         FoldersApp := Readstring('');
         CloseKey;
         OpenKey('Folder\shell\open\ddeexec\topic', False);
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
   if szCommand = Openfolder then
      Result := VIEW_COMMAND
   else
      if szCommand = Explorefolder then
         Result := EXPLORE_COMMAND
      else
         if szCommand = Findfolder then
            Result := FIND_COMMAND
         else
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
   while not (s[i] in IsDigit) and (i <= Length(s)) do
      Inc(i);
   processID := Copy(s, i, Length(S));
   s := copy(S, i, length(s) - 1);
   i := 1;
   while (s[i] in IsDigit) and (i <= Length(s)) do
      Inc(i);
   s := copy(S, 1, i - 1);

   while not ((ProcessID[i] = ':') or (ProcessID[i] = ',')) and (i <= Length(processID)) do
      Inc(i);
   if ProcessID[i] = ':' then
      begin
         ProcessID := Copy(ProcessID, i, Length(ProcessID));
         i := 1;
         while not (ProcessID[i] in IsDigit) and (i <= Length(ProcessID)) do
            Inc(i);
         ProcessID := Copy(ProcessID, i, Length(ProcessID));
         i := 1;
         while (ProcessID[i] in IsDigit) and (i <= Length(ProcessID)) do
            Inc(i);
         if not (ProcessID[i] in IsDigit) then
            ProcessID := Copy(ProcessID, 1, i - 1);
      end
   else
      ProcessID := '0';
   dwProcessID := StrToInt(ProcessID);
   if dwProcessID <> 0 then
      begin
         hShared := StrToInt(s);
         pidlShared := ShLockShared(hShared, dwProcessId);
         if PidlShared <> nil then
            begin
               Result := CopyPidl(PidlShared);
               ShUnlockShared(pidlShared);
            end
         else
            Result := nil;
         ShFreeShared(hShared, dwProcessID);
      end
   else
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
   while szCommand[i] <> ',' do
      Inc(i);
   Inc(i);
   while szCommand[i] <> ',' do
      Inc(i);
   szCommand := Copy(szCommand, i, Length(szCommand));
   i := 0;
   repeat
      inc(i)
   until (i > Length(szCommand)) or (szCommand[i] in IsDigit);
   if i <= length(szCommand) then
      Result := StrtoInt(szCommand[i])
   else
      Result := 1;
end;

function ParseDDECommand(szCommand: string; var szFolder: string; var pidl: PItemIDList; var show: Integer): UINT;
begin
   Result := GetCommandTypeFromDDEString(szCommand);
   if Result <> NO_COMMAND then
      begin
         GetPathFromDDEString(szCommand, szFolder);
         pidl := GetPidlFromDDEString(szCommand);
         Show := GetShowCmdFromDDEString(szCommand);
      end;
end;

function TEmbeddedwb.DDETerminate(iwParam: WPARAM; ilParam: LPARAM): BOOL;
begin
   Result := PostMessage(THandle(iwParam), WM_DDE_TERMINATE, handle, 0);
end;

function TEmbeddedWB.DDEInitiate(iwParam: WPARAM; ilParam: LPARAM): LResult;
var
   dwThreadID: DWORD;
   dwProcessID: DWORD;
   hwndClient: Integer;
   aInApp, aInTopic, aOutApp, aOutTopic: ATOM;
   szInAppName, szInAppTopic: array[0..255] of Char;
begin
   FillChar(szInAppName, SizeOf(szInAppName), 0);
   FillChar(szInAppTopic, SizeOf(szInAppTopic), 0);
   if DontRespond then
      begin
         Result := 0;
         exit;
      end;
   hwndClient := THandle(iwParam);
   dwThreadID := GetWindowThreadProcessId(hwndClient, @dwProcessID);
   if (GetCurrentProcessId() <> dwProcessID) or (GetCurrentThreadID() <> dwThreadID) then
      begin
         Result := 0;
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
         if (aOutApp <> 0) then
            GlobalDeleteAtom(aOutApp);
         if (aOutTopic <> 0) then
            GlobalDeleteAtom(aOutTopic);
      end
   else
      begin
         fHtmlCommand := False;
         aOutApp := GlobalAddAtom(PChar(FoldersApp));
         aOutTopic := GlobalAddAtom(PChar(FoldersTopic));
         if ((aOutApp <> 0) and (aOutTopic <> 0) and (aOutApp = aInApp) and (aOutTopic = aInTopic)) then
            SendMessage(HWNDClient, WM_DDE_ACK, WPARAM(Handle), MAKELPARAM(aOutApp, aOutTopic));
         if (aOutApp <> 0) then
            GlobalDeleteAtom(aOutApp);
         if (aOutTopic <> 0) then
            GlobalDeleteAtom(aOutTopic);
      end;
   Result := 0;
end;

function TEmbeddedwb.DDEExecute(iwParam: WPARAM; ilParam: LPARAM): LResult;
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
      then
      begin
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

                              if (szFolder <> '') then
                                 Go(szFolder)
                              else
                                 if (pidl <> nil) then
                                    NavigatePidl(pidl);
                              DisposePidl(pidl);
                              Ack.flags := 1;
                           end;
                        EXPLORE_COMMAND:
                           begin
                              DontRespond := True;
                              ZeroMemory(@sei, sizeof(SHELLEXECUTEINFO));
                              sei.cbSize := sizeof(SHELLEXECUTEINFO);
                              if szFolder <> '' then
                                 begin
                                    sei.fMask := SEE_MASK_CLASSNAME;
                                    sei.lpFile := Pchar(szFolder);
                                 end
                              else
                                 begin
                                    sei.fMask := SEE_MASK_IDLIST or SEE_MASK_CLASSNAME;
                                    sei.lpIDList := pidl;
                                 end;
                              sei.lpClass := 'folder';
                              sei.Wnd := 0;
                              sei.nShow := Show;
                              sei.lpVerb := 'explore';
                              ShellExecuteEx(@sei);
                              DontRespond := False;
                              DisposePidl(pidl);
                              Ack.flags := 1;
                           end;
                        FIND_COMMAND:
                           begin
                              DontRespond := True;
                              ZeroMemory(@sei, sizeof(SHELLEXECUTEINFO));
                              sei.cbSize := sizeof(SHELLEXECUTEINFO);
                              if (szFolder <> '')
                                 then
                                 begin
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
                              DontRespond := False;
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

//------------------

constructor TEmbeddedWB.Create(Owner: TComponent);
begin
   inherited;
{$IFDEF DELPHI_5_UP}
   EnableMessageHandler;
{$ENDIF}
   GetDDEVariables;
{$IFDEF DELPHI_6_UP}
{$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}
   DDEHWND := AllocateHWnd(DDEWndProc);
{$IFDEF DELPHI_6_UP}
{$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}
  {---------------------------------------------}
   FAbout := 'Embedded Web Browser. ' + SITE_ADDRESS;
   FUserAgent := 'Mozilla/4.0(Compatible-EmbeddedWB' + VER_NUM + SITE_ADDRESS;
  {---------------------------------------------}
   FPrintOptions := TPrintOptions.Create;
   FPrintOptions.Margins := TMargins.Create;
   FPrintOptions.FHTMLHeader := TStringlist.Create;
   FPrintOptions.FHTMLHeader.Add('<HTML></HTML>');
  {---------------------------------------------}
   FProxySettings := TProxySettings.Create;
   FProxySettings.FPort := 80;
  {---------------------------------------------}
   FRightClickMenu := TRightClickMenu.Create;
   FRightClickMenu.FDisableAllMenus := True;
   FRightClickMenu.FDefaultMenu := True;
   FRightClickMenu.FImageMenu := True;
   FRightClickMenu.FControlMenu := True;
   FRightClickMenu.FTableMenu := True;
   FRightClickMenu.FSelTextMenu := True;
   FRightClickMenu.FAnchorMenu := True;
   FRightClickMenu.FUnKnownMenu := True;
   FRightClickMenu.FImageArtMenu := True;
   FRightClickMenu.FDebugMenu := True;
   FRightClickMenu.FImgDynSrcMenu := True;
  {---------------------------------------------}
   FRightClickShortCuts := TRightClickShortCuts.Create;
  {---------------------------------------------}
   FShortCuts := TShortCuts.Create;
   FShortCuts.FCTRL_N := True;
  {---------------------------------------------}
   FDisableErrors := TDisableErrors.Create;
   FDisableErrors.FEnableDDE := True;
   FDisableErrors.FfpExceptions := True;
   FDisableErrors.FScriptErr := True;
  {---------------------------------------------}
   FMessagesBoxes := TMessagesBoxes.Create;
   FMessagesBoxes.FReplaceCaption := True;
   FMessagesBoxes.FReplaceIcon := True;
  {---------------------------------------------}
   FVisualEffects := TVisualEffects.Create;
   FVisualEffects.FTextSize := 2;
  {---------------------------------------------}
   DownloadOptions := [DownloadImages, DownloadVideos, DownloadBGSounds];
   UserInterfaceOptions := [];
   RuntimeMeasure := GetRunTimeMeasure;
   FDragDrop := True;
   m_bWinXPSP2 := IsWinXPSP2OrLater;
   m_bResizing := not m_bWinXPSP2;
   ActualHandle := WindowHandle;
end;

destructor TEmbeddedWB.Destroy;
begin
{$IFDEF DELPHI_6_UP}
{$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}
   DeAllocateHWND(DDEHWND);
{$IFDEF DELPHI_6_UP}
{$WARN SYMBOL_DEPRECATED ON}
{$ENDIF}
   FPrintOptions.HTMLHeader.Free;
   FPrintOptions.Margins.Free;
   FPrintOptions.Free;
   FRightClickMenu.Free;
   FRightClickShortCuts.Free;
   FShortcuts.Free;
   FMessagesBoxes.Free;
   FDisableErrors.Free;
{$IFDEF USE_EwbTools}
   if FVisualEffects.FDisableSounds then
      DisableNavSound(False);
   if FVisualEffects.FTextSize <> 2 then
      Zoom(2);
   if FProxySettings.FAutoLoadProxy then
      FProxySettings.SetProxy('', '');
   RemoveUserAgent;
{$ENDIF}
   FVisualEffects.Free;

   UnHook;
{$IFDEF DELPHI_5_UP}
   DisableMessagehandler;
{$ENDIF}

   FProxySettings.Free;
   inherited;
end;

procedure TEmbeddedWB.Loaded;
begin
   inherited Loaded;
   Modified := False;
   if not (csDesigning in ComponentState) then
      begin
         OldWBWndProc := WindowProc;
         WindowProc := WBWndProc;
         CoInternetCreateSecurityManager(Self, SecurityManager, 0);
         CoInternetCreateZoneManager(Self, ZoneManager, 0);
         UpdateDownloadControlValue;
         UpdateUserInterfaceValue;
         Hook;
{$IFDEF USE_EwbTools}
         SetUserAgent;
         if (FProxySettings.FAutoLoadProxy) and (FProxySettings.FServer <> '') then
            FProxySettings.SetProxy(FUserAgent, FProxySettings.FServer + ':' + IntToStr(FProxySettings.FPort));
         if FVisualEffects.FDisableSounds then
            DisableNavSound(True);
{$ENDIF}
         if not FDragDrop then
            RevokeDragDrop(Self.Handle);
      end
   else
      begin
         FPrintOptions.FMeasure := RunTimeMeasure;
         GetPrintValues;
      end;
end;

procedure TEmbeddedWB.Hook;
begin
   if (csDesigning in ComponentState) then
      Exit;
   FParentForm := TForm(Owner);
   if (FParentForm <> nil) and (FParentForm.HandleAllocated) then
      begin
         FOldWindowProc := FParentForm.WindowProc;
         FParentForm.WindowProc := FormWndProc;
      end;
end;

procedure TEmbeddedWB.UnHook;
begin
   if (csDesigning in ComponentState) then
      Exit;
   if (FParentForm <> nil) and (FParentForm.HandleAllocated) then
      FParentForm.WindowProc := FOldWindowProc;
//  FOldWindowProc := nil;
   FParentForm := nil;
end;

procedure TEmbeddedWB.DDEWndProc(var AMsg: Messages.TMessage);
begin
   with AMsg do
      if (Msg = WM_DDE_INITIATE) and FDisableErrors.FEnableDDE //and FEnableDDE
         then
         DDEInitiate(WParam, LParam)
      else
         Result := DefWindowProc(DDEHWND, Msg, WParam, LParam);
end;

procedure TDisableErrors.SetfpExceptions(const Value: Boolean);
begin
   case Value of
      True: Set8087CW($133F);
      False: Set8087CW(Saved8087CW);
   end;
   FfpExceptions := Value;
end;

procedure TEmbeddedWB.SetAbout(Value: string);
begin
   Exit;
end;

function TEmbeddedWB.QueryService(const rsid, iid: TGUID; out Obj): HResult;
begin
   if IsEqualGuid(rsid, IID_IHTMLOMWindowServices) then
      begin
         IUnknown(Obj) := Self as IHTMLOMWindowServices;
         Result := S_OK;
      end
   else
      if IsEqualGuid(rsid, IID_IDownloadManager) then
         if Assigned(FOnDownload) then
            begin
               IUnknown(Obj) := Self as IDownloadManager;
               Result := S_OK;
            end
         else
            Result := E_NOINTERFACE
        else
      if IsEqualGuid(rsid, IID_INewWindowManager) then
         if Assigned(FOnEvaluateNewWindow) then
            begin
               IUnknown(Obj) := Self as INewWindowManager;
               Result := S_OK;
            end
         else
            Result := E_NOINTERFACE
      else
         if Assigned(FOnQueryService) then
            Result := FOnQueryService(rsid, iid, IUnknown(obj))
         else
            Result := E_NOINTERFACE;
end;

procedure TEmbeddedWB.SetDownloadOptions(const Value:
   TDownloadControlOptions);
begin
   FDownloadControlOptions := Value;
   UpdateDownloadControlValue;
{$IFDEF DELPHI_4}(Application_ as IOleControl).OnAmbientPropertyChange(DISPID_AMBIENT_DLCONTROL);
{$ELSE}
   (Application as IOleControl).OnAmbientPropertyChange(DISPID_AMBIENT_DLCONTROL);
{$ENDIF}
end;

procedure TEmbeddedWB.SetUserInterfaceOptions(const Value:
   TUserInterfaceOptions);
begin
   FUserInterfaceOptions := Value;
   UpdateUserInterfaceValue;
{$IFDEF DELPHI_4}(Application_ as IOleControl).OnAmbientPropertyChange(DISPID_AMBIENT_DLCONTROL);
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
      for i := Low(TDownloadControlOption) to High(TDownloadControlOption) do
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
      $00040000, $00080000, $00100000, $00200000, $00400000,
      $00800000, $01000000, $02000000, $04000000, $08000000,
      $10000000, $20000000);
var
   i: TUserInterfaceOption;
begin
   FUserInterfaceValue := 0;
   if (FUserInterfaceOptions <> []) then
      for i := Low(TUserInterfaceOption) to High(TUserInterfaceOption) do
         if (i in FUserInterfaceOptions) then
            Inc(FUserInterfaceValue, acardUserInterfaceValues[i]);
end;

{$IFDEF DELPHI_5_UP}

procedure TEmbeddedWB.EnableMessageHandler;
begin
   if not bMsgHandler then
      begin
         SaveMessage := Forms.Application.OnMessage;
         Forms.Application.OnMessage := IeMessageHandler;
         bMsgHandler := True;
      end;
end;

procedure TEmbeddedWB.DisableMessageHandler;
begin
   if bMsgHandler then
      begin
         Forms.Application.OnMessage := SaveMessage;
         bMsgHandler := False;
      end;
end;
{$ENDIF}

{$IFDEF DELPHI_5_UP}
///BEGIN >>>>> Messagehandler by Mathias Walter - mathias.walter@gmx.net >>>>>///
procedure TEmbeddedWB.IEMessageHandler(var Msg: TMsg; var Handled: Boolean);
const
   StdKeys = [VK_TAB, VK_RETURN]; { standard keys }
   ExtKeys = [{VK_DELETE,} VK_BACK, VK_LEFT, VK_RIGHT]; { extended keys }
   ExtendedFlag = $01000000; { extended key flag }
begin
 if not (csDesigning in ComponentState) then
  begin
   Handled := False;
   with Msg do
      if ((Message >= WM_KEYFIRST) and (Message <= WM_KEYLAST)) and
         ((wParam in StdKeys) or (GetKeyState(VK_CONTROL) < 0) or
         (wParam in ExtKeys) and ((lParam and ExtendedFlag) = ExtendedFlag)) then
         try
            if IsChild(GetParent(HWND), HWND) then
               begin
                  with Application as IOleInPlaceActiveObject do
                     Handled := TranslateAccelerator(Msg) = S_OK;
                  if not Handled then
                     begin
                        Handled := True;
                        TranslateMessage(Msg);
                        DispatchMessage(Msg);
                     end;
               end;
         except
         end;
  end;
end; // IEMessageHandler
{$ENDIF}
///END <<<<<< Messagehandler by Mathias Walter - mathias.walter@gmx.net <<<<<///

// IDOCHOSTUIHANDLER
function TEmbeddedWB.ShowContextMenu(const dwID: DWORD; const ppt: PPOINT;
   const pcmdtReserved: IUnknown; const pdispReserved: IDispatch): HResult;
var
   ShDocLcHandle: THandle;
   bFreeDll: Boolean;
   OleCommandTarget: IOleCommandTarget;
   OleWindow: IOleWindow;
   WindowHandle: Windows.HWND;
   ParentMenu, SubMenu: HMENU;
   EncodingSubMenu, InParam, OutParam: OleVariant;
   SubMenuItemInfo: MENUITEMINFO;
   PopupResult: LongBool;
begin
   if Assigned(FOnShowContextMenu) then
      Result := FOnShowContextMenu(dwID, ppt, pcmdtReserved, pdispReserved)
   else
      if (not FRightClickMenu.FDefaultMenu) and (dwID = 0) then
         Result := S_OK
      else
         if (not FRightClickMenu.FImageMenu) and (dwID = 1) then
            Result := S_OK
         else
            if (not FRightClickMenu.FControlMenu) and (dwID = 2) then
               Result := S_OK
            else
               if (not FRightClickMenu.FTableMenu) and (dwID = 3) then
                  Result := S_OK
               else
                  if (not FRightClickMenu.FSelTextMenu) and (dwID = 4) then
                     Result := S_OK
                  else
                     if (not FRightClickMenu.FAnchorMenu) and (dwID = 5) then
                        Result := S_OK
                     else
                        if (not FRightClickMenu.FUnKnownMenu) and (dwID = 6) then
                           Result := S_OK
                        else
                           if (not FRightClickMenu.FImgDynSrcMenu) and (dwID = 7) then
                              Result := S_OK
                           else
                              if (not FRightClickMenu.FImageArtMenu) and (dwID = 8) then
                                 Result := S_OK
                              else
                                 if (not FRightClickMenu.FDebugMenu) and (dwID = 9) then
                                    Result := S_OK
                                 else
                                    if (not FRightClickMenu.FDisableAllMenus) then
                                       Result := S_OK
                                    else
                                       Result := S_False;
   if (Result = S_False) and (not Assigned(FOnShowContextMenu))
      and (FRightClickShortCuts.FDisableBack or FRightClickShortCuts.FDisableForward or
      FRightClickShortCuts.FDisableSavePageBkg or FRightClickShortCuts.FDisableSetAsBkg or
      FRightClickShortCuts.FDisableCopyBkg or FRightClickShortCuts.FDisableSetAsDeskT or
      FRightClickShortCuts.FDisableSelectAll or FRightClickShortCuts.FDisablePaste or
      FRightClickShortCuts.FDisableCreateSC or FRightClickShortCuts.FDisableAddToFav or
      FRightClickShortCuts.FDisableEncoding or FRightClickShortCuts.FDisableRefresh or
      FRightClickShortCuts.FDisableProperties or FRightClickShortCuts.FDisablePrint or
      FRightClickShortCuts.FDisableViewSource or FRightClickShortCuts.FDisableOpenNWindow or
      FRightClickShortCuts.FDisableOpenLink) then
      begin
         bFreeDll := False;
         ShDocLcHandle := GetModuleHandle('SHDOCLC.DLL');
         if ShDocLcHandle = 0 then
            begin
               ShDocLcHandle := LoadLibrary('SHDOCLC.DLL');
               bFreeDll := ShDocLcHandle <> 0;
            end;
         OleCommandTarget := pcmdtReserved as IOleCommandTarget;
         OleWindow := pcmdtReserved as IOleWindow;
         WindowHandle := 0;
         if ActiveX.Succeeded(OleWindow.GetWindow(WindowHandle)) then
            begin
               ParentMenu := Windows.LoadMenu(ShDocLcHandle, MAKEINTRESOURCE(CContextMenuID));
               if ParentMenu <> 0 then
                  begin
                     SubMenu := GetSubMenu(ParentMenu, dwID);
                     // if ActiveX.SUCCEEDED(OleCommandTarget.Exec(@CGID_ShellDocView, CGetMimeSubMenuCommandID,
                     // OLECMDEXECOPT_DODEFAULT, Null, EncodingSubMenu)) then
                     ExecWB(CGetMimeSubMenuCommandID, OLECMDEXECOPT_DODEFAULT, EncodingSubMenu);
                     begin
                        FillChar(SubMenuItemInfo, SizeOf(SubMenuItemInfo), 0);
                        SubMenuItemInfo.cbSize := SizeOf(MENUITEMINFO);
                        SubMenuItemInfo.fMask := MIIM_SUBMENU;
                        SubMenuItemInfo.hSubMenu := HMENU(@EncodingSubMenu);
                        SetMenuItemInfo(SubMenu, IDM_LANGUAGE, False, SubMenuItemInfo);
{$WARNINGS OFF}
                        InParam := SubMenu;
                        OutParam := dwID;
{$WARNINGS ON}
                     end;
                     if FRightClickShortCuts.FDisableBack then
                        DeleteMenu(SubMenu, IDM_BACK, MF_BYCOMMAND);
                     if FRightClickShortCuts.FDisableForward then
                        DeleteMenu(SubMenu, IDM_FORWARD, MF_BYCOMMAND);
                     if FRightClickShortCuts.FDisableSavePageBkg then
                        DeleteMenu(SubMenu, IDM_SAVEBACKGROUND, MF_BYCOMMAND);
                     if FRightClickShortCuts.FDisableSetAsBkg then
                        DeleteMenu(SubMenu, IDM_SETASBACKGROUND, MF_BYCOMMAND);
                     if FRightClickShortCuts.FDisableCopyBkg then
                        DeleteMenu(SubMenu, IDM_COPYBACKGROUND, MF_BYCOMMAND);
                     if FRightClickShortCuts.FDisableSetAsDeskT then
                        DeleteMenu(SubMenu, IDM_SETASDESKTOPITEM, MF_BYCOMMAND);
                     if FRightClickShortCuts.FDisableSelectAll then
                        DeleteMenu(SubMenu, IDM_SELECTALL, MF_BYCOMMAND);
                     if FRightClickShortCuts.FDisablePaste then
                        DeleteMenu(SubMenu, IDM_PASTE, MF_BYCOMMAND);
                     if FRightClickShortCuts.FDisableCreateSC then
                        DeleteMenu(SubMenu, IDM_CREATESHORTCUT, MF_BYCOMMAND);
                     if FRightClickShortCuts.FDisableAddToFav then
                        DeleteMenu(SubMenu, IDM_ADDTOFAVOURITES, MF_BYCOMMAND);
                     if FRightClickShortCuts.FDisableEncoding then
                        DeleteMenu(SubMenu, IDM_ENCODING, MF_BYCOMMAND);
                     if FRightClickShortCuts.FDisableRefresh then
                        DeleteMenu(SubMenu, IDM_REFRESH, MF_BYCOMMAND);
                     if FRightClickShortCuts.FDisableViewSource then
                        DeleteMenu(SubMenu, IDM_VIEWSOURCE, MF_BYCOMMAND);
                     if FRightClickShortCuts.FDisableProperties then
                        DeleteMenu(SubMenu, IDM_PROPERTIES, MF_BYCOMMAND);
                     if FRightClickShortCuts.FDisablePrint then
                        DeleteMenu(SubMenu, IDM_PRINT, MF_BYCOMMAND);
                     if FRightClickShortCuts.FDisableOpenNWindow then
                        DeleteMenu(SubMenu, IDM_OPENINNEWWINDOW, MF_BYCOMMAND);
                     if FRightClickShortCuts.FDisableOpenLink then
                        DeleteMenu(SubMenu, IDM_OPENLINK, MF_BYCOMMAND);
                     PopupResult := Windows.TrackPopupMenuEx(SubMenu, TPM_LEFTALIGN
                        or TPM_TOPALIGN or TPM_RETURNCMD or TPM_RIGHTBUTTON
                        or TPM_HORPOSANIMATION or TPM_VERPOSANIMATION, ppt^.X, ppt^.Y, WindowHandle, nil);
                     if PopupResult then
                        SendMessage(WindowHandle, WM_COMMAND, MakeWParam(LOWORD(PopupResult), 0), 0);
                     DestroyMenu(ParentMenu);
                     Result := S_OK; //(Ray)
                  end;
            end;
         OleWindow := nil;
         OleCommandTarget := nil;
         if bFreeDll and (ShDocLcHandle <> 0) then
            Windows.FreeLibrary(ShDocLcHandle);
      end;
end;

function TEmbeddedWB.GetHostInfo(var pInfo: TDOCHOSTUIINFO): HResult;
begin
   pInfo.cbSize := SizeOf(pInfo);
   pInfo.dwFlags := FUserInterfaceValue;
   pInfo.dwDoubleClick := DOCHOSTUIDBLCLK_DEFAULT;
   if Assigned(FOnGetHostInfo) then
      Result := FOnGetHostInfo(pInfo)
   else
      Result := S_OK;
end;

function TEmbeddedWB.ShowUI(const dwID: DWORD;
   const pActiveObject: IOleInPlaceActiveObject;
   const pCommandTarget: IOleCommandTarget;
   const pFrame: IOleInPlaceFrame;
   const pDoc: IOleInPlaceUIWindow): HResult;
begin
   if Assigned(FOnShowUI) then
      Result := FOnShowUI(dwID, pActiveObject, pCommandTarget, pFrame, pDoc)
   else
      Result := S_FALSE;
end;

function TEmbeddedWB.HideUI: HResult;
begin
   if Assigned(FOnHideUI) then
      Result := FOnHideUI
   else
      Result := S_FALSE;
end;

function TEmbeddedWB.UpdateUI: HResult;
begin
   if Assigned(FOnUpdateUI) then
      Result := FOnUpdateUI
   else
      Result := S_FALSE;
end;

function TEmbeddedWB.EnableModeless(const fEnable: BOOL): HResult;
begin
   if fEnable and (GlobalModelessCounter > 0) then
      Dec(GlobalModelessCounter)
   else
      Inc(GlobalModelessCounter);
   Result := S_OK;
   {if Assigned(FOnEnableModeless) then
      Result := FOnEnableModeless(fEnable)
   else
      Result := S_FALSE;}
end;

function TEmbeddedWB.OnDocWindowActivate(const fActivate: BOOL): HResult;
begin
   if Assigned(FOnOnDocWindowActivate) then
      Result := FOnOnDocWindowActivate(FActivate)
   else
      Result := S_FALSE;
end;

function TEmbeddedWB.OnFrameWindowActivate(const fActivate: BOOL): HResult;
begin
   if Assigned(FOnOnFrameWindowActivate) then
      Result := FOnOnFrameWindowActivate(fActivate)
   else
      Result := S_FALSE;
end;

function TEmbeddedWB.ResizeBorder(const prcBorder: PRECT;
   const pUIWindow: IOleInPlaceUIWindow; const fRameWindow: BOOL): HResult;
begin
   if Assigned(FOnResizeBorder) then
      Result := FOnResizeBorder(prcBorder, pUIWindow, fRameWindow)
   else
      Result := S_FALSE;
end;

function TEmbeddedWB.TranslateAccelerator(const lpMsg: PMSG;
   const pguidCmdGroup: PGUID; const nCmdID: DWORD): HResult;
var
   bCtrlKey, bShiftKey, bAltKey: boolean;
begin
  // Result := S_FALSE;
   if Assigned(FOnTranslateAccelerator) then
      Result := FOnTranslateAccelerator(lpMsg, pguidCmdGroup, nCmdID)
   else
      begin
         Result := S_FALSE;
         bShiftKey := (GetKeyState(VK_SHIFT) < 0);
         bAltKey := (GetKeyState(VK_MENU) < 0);
         bCtrlKey := (GetKeyState(VK_CONTROL) < 0);
         if (not bShiftkey) and (not bAltkey) and bCtrlkey then
            begin
               if FShortcuts.FCTRL_N and (lpMsg.wParam = Ord('N')) then
                  Result := S_OK
               else
                  if FShortcuts.FCTRL_P and (lpMsg.wParam = Ord('P')) then
                     Result := S_OK
                  else
                     if FShortcuts.FCTRL_A and (lpMsg.wParam = Ord('A')) then
                        Result := S_OK
                     else
                        if FShortcuts.FCTRL_C and (lpMsg.wParam = Ord('C')) then
                           Result := S_OK
                        else
                           if FShortcuts.FCTRL_F and (lpMsg.wParam = Ord('F')) then
                              Result := S_OK;
            end;
      end;
      {if FShortcuts.FCTRL_N then
         begin
            if (GetKeyState(VK_CONTROL) < 0) and (lpMsg.wParam = Ord('N')) then
               Result := S_OK;
         end
      else
         if FShortcuts.FCTRL_P then
            begin
               if (GetKeyState(VK_CONTROL) < 0) and (lpMsg.wParam = Ord('P')) then
                  Result := S_OK;
            end
         else
            if FShortcuts.FCTRL_A then
               begin
                  if (GetKeyState(VK_CONTROL) < 0) and (lpMsg.wParam = Ord('A')) then
                     Result := S_OK;
               end
            else
               if FShortcuts.FCTRL_C then
                  begin
                     if (GetKeyState(VK_CONTROL) < 0) and (lpMsg.wParam = Ord('C')) then
                        Result := S_OK;
                  end
               else
                  if FShortcuts.FCTRL_F then
                     begin
                        if (GetKeyState(VK_CONTROL) < 0) and (lpMsg.wParam = Ord('F')) then
                           Result := S_OK;
                     end
                  else
                     Result := S_FALSE;  }
end;

function TEmbeddedWB.GetOptionKeyPath(var pchKey: POleStr; const dw: DWORD): HResult;
begin
   pchKey := CopyOptionKeyPath(False);
   Result := S_OK;
   if Assigned(FOnGetOptionKeyPath) then
      Result := FOnGetOptionKeyPath(pchKey, dw)
   //else
   //   Result := S_FALSE;
end;

function TEmbeddedWB.GetDropTarget(const pDropTarget: IDropTarget;
   out ppDropTarget: IDropTarget): HResult;
begin
   if Assigned(FOnGetDropTarget) then
      Result := FOnGetDropTarget(pDropTarget, ppDropTarget)
   else
      Result := E_NOTIMPL;
end;

function TEmbeddedWB.GetExternal(out ppDispatch: IDispatch): HResult;
begin
   if Assigned(FOnGetExternal) then
      Result := FOnGetExternal(ppDispatch)
   else
      Result := S_FALSE;
end;

function TEmbeddedWB.TranslateUrl(const dwTranslate: DWORD;
   const pchURLIn: POleStr; var ppchURLOut: POleStr): HResult;
begin
   if Assigned(FOnTranslateUrl) then
      Result := FOnTranslateUrl(dwTranslate, pchUrlIn, ppchUrlOut)
   else
      Result := S_FALSE;
end;

function TEmbeddedWB.FilterDataObject(const pDO: IDataObject;
   out ppDORet: IDataObject): HResult;
begin
   if Assigned(FOnFilterDataObject) then
      Result := FOnFilterDataObject(pDO, ppDORet)
   else
      Result := S_FALSE;
end;

// IDOCHOSTSHOWUI

function TEmbeddedWB.ShowMessage(HWND: THandle; lpstrText: POleStr;
   lpstrCaption: POleStr; dwType: Longint; lpstrHelpFile: POleStr;
   dwHelpContext: Longint; var plResult: LResult): HResult;
begin
   if Assigned(FOnShowMessage) then
      Result := FOnShowMessage(HWND, lpstrText, lpStrCaption, dwType, lpStrHelpFile, dwHelpContext, plResult)
   else
      Result := S_FALSE;
end;

function TEmbeddedWB.ShowHelp(HWND: THandle; pszHelpFile: POleStr;
   uCommand: Integer; dwData: Longint; ptMouse: TPoint;
   var pDispatchObjectHit: IDispatch): HResult;
begin
   Result := S_OK;
   if Assigned(FOnShowHelp) then
      Result := FOnShowHelp(HWND, pszHelpFile, uCommand, dwData, ptMouse, pDispatchObjectHit)
   else
      if FHelpFile <> '' then
         HtmlHelp(HWND, PChar(FHelpFile), uCommand, dwData)
      else
         Result := S_FALSE;
end;

// IDISPATCH methods

function TEmbeddedWB.GetIDsOfNames(const IID: TGUID; Names: Pointer;
   NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
   if Assigned(FOnGetIDsOfNames) then
      Result := FOnGetIDsOfNames(IID, Names, NameCount, LocaleID, DispIds)
   else
      Result := E_NOTIMPL;
end;

function TEmbeddedWB.GetTypeInfo(Index, LocaleID: Integer;
   out TypeInfo): HResult;
begin
   if Assigned(FOnGetTypeInfo) then
      Result := FOnGetTypeInfo(Index, LocaleID, ITypeInfo(TypeInfo))
   else
      begin
         Result := E_NOTIMPL;
         Pointer(TypeInfo) := nil;
      end;
end;

function TEmbeddedWB.GetTypeInfoCount(out Count: Integer): HResult;
begin
   if Assigned(FOnGetTypeInfoCount) then
      Result := FOnGetTypeInfoCount(Count)
   else
      begin
         Result := E_NOTIMPL;
         Count := 0;
      end;
end;

function TEmbeddedWB.GetOverrideKeyPath(pchKey: POleStr; dw: DWORD): HResult;
begin
   if Assigned(FOnGetOverrideKeyPath) then
      Result := FOnGetOverrideKeyPath(pchKey, dw)
   else
      Result := S_OK;
end;

procedure TEmbeddedWB.FormWndProc(var AMsg: Messages.TMessage);
var
   i: Integer;
   wnd: Integer;
   S, st: string;
   Msg: TWMActivate;
begin
   if AMsg.Msg = WM_ACTIVATE then
      begin
         Msg := TWMActivate(AMsg);
         if Msg.Active = 0 then
            begin
               wnd := Msg.ActiveWindow;
               SetLength(S, 80);
               SetLength(S, GetClassName(wnd, PChar(S), Length(S)));
               if (S = '#32770') then
                  begin
                     if FMessagesBoxes.FDisableAll then
                        SendMessage(wnd, WM_CLOSE, 0, 0);
                     if FMessagesBoxes.FReplaceIcon then
                        SendMessage(wnd, WM_SETICON, ICON_SMALL, Forms.Application.Icon.Handle);
                     if FMessagesBoxes.FReplaceCaption then
                        begin
                           st := FMessagesBoxes.FNewCaption;
                           if st = '' then
                              st := 'Web Browser';
                           I := GetWindowTextLength(wnd);
                           SetLength(S, I + 1);
                           GetWindowText(Wnd, PChar(S), I + 1);
                           S := StringReplace(S, 'Microsoft ', '', []);
                           S := StringReplace(S, 'Internet Explorer', st, []);
                           if Pos(st, S) = 0 then
                              S := st + ':  ' + S;
                           if FDisableErrors.FScriptErr then
                              if AnsiPos('Error', S) <> 0 then
                                 PostMessage(wnd, WM_CLOSE, 0, 0);
                           SetWindowText(wnd, PChar(S));
                        end;
                     if FPrintOptions.FEnabled then
                        begin
                           if InvokingPageSetup then
                              begin
                                 InvokingPageSetup := False;
                                 if PrintingWithOptions then
                                    begin
                                       SetWindowPos(0, 0, -600, 0, 0, 0, 0); //SetWindowPos(Wnd, 0, -600, 0, 0, 0, 0);
                                       PrintingWithOptions := False;
                                    end;
                                 if FPrintOptions.FOrientation = poPortrait then
                                    SendDlgItemMessage(wnd, $0420, BM_CLICK, 0, 0)
                                 else
                                    SendDlgItemMessage(wnd, $0421, BM_CLICK, 0, 0);
                                 SetDlgItemText(wnd, $1FD3, PChar(FPrintOptions.FHeader));
                                 SetDlgItemText(wnd, $1FD5, PChar(FPrintOptions.FFooter));
                                 SetDlgItemText(wnd, $0483, PrintMarginStr(FPrintOptions.FMargins.FLeft));
                                 SetDlgItemText(wnd, $0484, PrintMarginStr(FPrintOptions.FMargins.Ftop));
                                 SetDlgItemText(wnd, $0485, PrintMarginStr(FPrintOptions.FMargins.FRight));
                                 SetDlgItemText(wnd, $0486, PrintMarginStr(FPrintOptions.FMargins.FBottom));
                                 if (Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion > 4) then
                                    PostMessage(FindWindowEx(wnd, 0, PChar('Button'), nil), BM_CLICK, 0, 0) //Win2000
                                 else
                                    SendDlgItemMessage(wnd, 1, BM_CLICK, 0, 0);
                              end;
                        end;
                  end;
               if not PrintingWithOptions and (wnd <> 0) and Assigned(FOnShowDialog) then
                  FOnShowDialog(Self, wnd);
            end;
      end;
   FOldWindowProc(AMsg);
end;

procedure TEmbeddedWB.WBWndProc(var message: Messages.TMessage);
const
   StdKeys = [VK_RETURN, VK_BACK]; { standard keys }
   ExtKeys = [VK_LEFT, VK_RIGHT]; { extended keys }
   ExtendedFlag = $01000000; { extended key flag }
var
   bClose: Boolean;
{$IFDEF DELPHI_4}
   WinMsg: TMsg;
{$ENDIF}
begin
   with message do
      begin
{$IFDEF DELPHI_4}
         if (Msg >= (CN_BASE + WM_KEYFIRST)) and (Msg <= (CN_BASE + WM_DEADCHAR)) then
            begin
               WinMsg.HWND := Handle;
               WinMsg.message := Msg - CN_BASE;
               WinMsg.WPARAM := WParam;
               WinMsg.LPARAM := LParam;
               WinMsg.time := GetMessageTime;
               WinMsg.pt.x := $115DE1F1;
               WinMsg.pt.y := $115DE1F1;
               if not ((WParam in StdKeys) or (wParam in ExtKeys)
                  and ((LParam and ExtendedFlag) = ExtendedFlag)) then
                  with Application as IOleInPlaceActiveObject do
                     Result := Integer(TranslateAccelerator(WinMsg) = S_OK);
            end
         else
{$ENDIF}
            case Msg of
               WM_CLOSE:
                  begin
                     bClose := True;
                     if Assigned(FOnCloseQuery) then
                        FOnCloseQuery(Self, bClose);
                     if bClose then
                            //OldWBWndProc(Message);
                            //by Ryan Bruins
                        if (not ((not Self.Focused) and (Message.Msg = CM_DIALOGKEY))) then
                           OldWBWndProc(Message);
                  end;
               WM_SIZE:
                  if (not ((not Self.Focused) and (Message.Msg = CM_DIALOGKEY))) then
                     begin
                        m_bResizing := False;
                        OldWBWndProc(Message);
                        m_bResizing := not m_bWinXPSP2; // must be set in constructor
                     end;
               WM_WINDOWPOSCHANGING:
                  begin
                     if m_bResizing and ((PWindowPos(lParam)^.flags and (SWP_NOMOVE or SWP_NOSIZE)) > 0) then
                        begin
                           if ((PWindowPos(lParam)^.flags and SWP_NOMOVE) = 0) then
                              begin
                                 PWindowPos(lParam)^.flags := PWindowPos(lParam)^.flags or SWP_NOMOVE;
                                 if Assigned(FOnMove) then
                                    FOnMove(Self, PWindowPos(lParam)^.x, PWindowPos(lParam)^.y);
                              end;

                           if ((PWindowPos(lParam)^.flags and SWP_NOSIZE) = 0) then
                              begin
                                 PWindowPos(lParam)^.flags := PWindowPos(lParam)^.flags or SWP_NOSIZE;
                                 if Assigned(FOnResize) then
                                    FOnResize(Self, PWindowPos(lParam)^.cx, PWindowPos(lParam)^.cy);
                              end;
                        end;
                           // if (not ((not Self.Focused) and (Message.Msg = CM_DIALOGKEY))) then
                                //OldWBWndProc(Message);
                  end;
               WM_SETFOCUS: GetParentForm(Self).ActiveControl := Self;
               WM_DDE_EXECUTE: DDEExecute(wParam, lparam);
               WM_DDE_TERMINATE: DDETerminate(wparam, lparam);
               //WM_ACTIVATE: OldWBWndProc(Message);
               else
                  //OldWBWndProc(Message); //by Ryan Bruins
                  if (not ((not Self.Focused) and (Message.Msg = CM_DIALOGKEY))) then
                     OldWBWndProc(Message);
            end;
      end;
end;

procedure TEmbeddedWB.DestroyWnd; //jls
begin
   if (csDestroying in ComponentState) then
      inherited
   else
      begin
         Windows.SetParent(WindowHandle, Forms.Application.Handle); //Parent to the Application window which is 0x0 in size
         ActualHandle := WindowHandle; //save the WindowHandle
         WindowHandle := 0; //set it to 0 so Createwnd will be called again...
      end;
end;

procedure TEmbeddedWB.CreateWnd; //jls
begin
   if (ActualHandle <> 0) then
      begin
         if (IsWindow(ActualHandle)) then
            begin
               WindowHandle := ActualHandle;
               ActualHandle := 0;
               Windows.SetParent(WindowHandle, TWinControl(Self).Parent.Handle);
               MoveWindow(WindowHandle, 0, 0, TWinControl(Self).Parent.Width,
                  TWinControl(Self).Parent.Height, true); //Force a resize on the client window
               Exit;
            end
      end;
   inherited;
end;

function TEmbeddedWB.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer; Flags: Word;
   var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
   Result := S_OK;
   if (Flags and DISPATCH_PROPERTYGET <> 0) and (VarResult <> nil) and
      (DispID = DISPID_AMBIENT_DLCONTROL) then
      PVariant(VarResult)^ := FDownloadOptionValue
   else
      if Assigned(FOnInvoke) then
         Result := FOnInvoke(DispID, IID, LocaleID, Flags, TagDispParams(Params),
            VarResult, ExcepInfo, ArgErr)
      else
         Result := inherited Invoke(DispID, IID, LocaleID, Flags, Params,
            VarResult, ExcepInfo, ArgErr);
end;

{$IFDEF USE_IOLECOMMANDTARGET}

function TEmbeddedWB.Exec(CmdGroup: PGUID; nCmdID, nCmdexecopt: DWORD;
   const vaIn: OleVariant; var vaOut: OleVariant): HResult;
var
   FCancel, FContinueScript, FShowDialog: Boolean;
   EventObject: IHTMLEventObj;
   CurWindow: IHTMLWindow2;
   CurDocument: IHTMLDocument2;
   CurUnknown: IUnknown;

   function GetProperty(const PropName: WideString): OleVariant;
   var
      DispParams: TDispParams;
      Disp, Status: Integer;
      ExcepInfo: TExcepInfo;
      PPropName: PWideChar;
   begin
      DispParams.rgvarg := nil;
      DispParams.rgdispidNamedArgs := nil;
      DispParams.cArgs := 0;
      DispParams.cNamedArgs := 0;
      PPropName := PWideChar(PropName);
      Status := EventObject.GetIDsOfNames(GUID_NULL, @PPropName, 1, LOCALE_SYSTEM_DEFAULT, @Disp);
      if Status = 0 then
         begin
            Status := EventObject.Invoke(disp, GUID_NULL, LOCALE_SYSTEM_DEFAULT,
               DISPATCH_PROPERTYGET, DispParams, @Result, @ExcepInfo, nil);
            if Status <> 0 then
               DispatchInvokeError(Status, ExcepInfo);
         end
      else
         if Status = DISP_E_UNKNOWNNAME then
            raise
               EOleError.CreateFmt('''%s'' not supported.', [PropName])
         else
            OleCheck(Status);
   end;

begin
   if (CmdGroup = nil) then
      begin
         SetModified(FModified);
         Modified := FModified;
         Result := OLECMDERR_E_UNKNOWNGROUP;
         Exit;
      end;
   Result := OLECMDERR_E_NOTSUPPORTED;
   if (ncmdID = OLECMDID_ONUNLOAD) and IsEqualGuid(cmdGroup^, CGID_EXPLORER) and
      Assigned(FOnUnload) then
      begin
         FOnUnload(Self);
         Result := S_OK;
      end;
   if IsEqualGuid(cmdGroup^, CGID_DocHostCommandHandler) then
      begin
         if Assigned(FOnRefresh) and ((nCmdID = 6041 {F5}) or (nCmdID = 6042 {ContextMenu})
            or (nCmdID = 2300)) then
            begin
               FCancel := False;
               FOnRefresh(Self, nCmdID, FCancel);
               if FCancel then
                  Result := S_OK;
            end
         else
            case nCmdID of
               OLECMDID_SHOWSCRIPTERROR:
                  begin
                     FContinueScript := FDisableErrors.FScriptErr;
                     FShowDialog := not FDisableErrors.FScriptErr;
                     if Assigned(FOnScriptError) then
                        begin
                           CurUnknown := IUnknown(TVarData(vaIn).VUnknown);
                           if succeeded(CurUnknown.QueryInterface(IID_IHTMLDocument2, CurDocument)) then
                              begin
                                 CurWindow := CurDocument.Get_parentWindow;
                                 CurDocument := nil;
                                 if Assigned(CurWindow) then
                                    begin
                                       EventObject := CurWindow.Get_event;
                                       if EventObject <> nil then
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
                                             if not FShowDialog then
                                                Result := S_OK;
                                          end;
                                    end;
                              end;
                        end;
                  end;
            end;
      end;
end;
{$ENDIF}

function TEmbeddedWB.QueryStatus(CmdGroup: PGUID; cCmds: Cardinal;
   prgCmds: POleCmd; CmdText: POleCmdText): HResult;
begin
   Result := S_OK;
{$IFDEF USE_EwbTools}
   if FVisualEffects.FTextSize <> 2 then
      Zoom(FVisualEffects.FTextSize);
{$ENDIF}
end;

function TEmbeddedWB.Download(pmk: IMoniker; pbc: IBindCtx; dwBindVerb: DWORD;
   grfBINDF: DWORD; pBindInfo: PBindInfo; pszHeaders: PWidechar;
   pszRedir: PWidechar; uiCP: UINT): HResult;
begin
   if Assigned(FOnDownload) then
      Result := FOnDownload(pmk, pbc, dwBindVerb, grfBINDF, pBindInfo, pszHeaders, pszRedir, uiCP)
   else
      Result := E_NOTIMPL;
end;

function TEmbeddedWB.moveTo(const x, y: Integer): HResult;
begin
   if Assigned(FOnMove) then
      FOnMove(self, x, y);
   Result := S_OK; // always return success to prevent script error messages
end;

function TEmbeddedWB.moveBy(const x, y: Integer): HResult; stdcall;
begin
   if Assigned(FOnMoveBy) then
      FOnMoveBy(self, x, y);
   Result := S_OK; // always return success to prevent script error messages
end;

function TEmbeddedWB.resizeTo(const x, y: Integer): HResult; stdcall;
begin
   if Assigned(FOnResize) then
      FOnResize(self, x, y);
   Result := S_OK; // always return success to prevent script error messages
end;

function TEmbeddedWB.resizeBy(const x, y: Integer): HResult; stdcall;
begin
   if Assigned(FOnResizeBy) then
      FOnResizeBy(self, x, y);
   Result := S_OK; // always return success to prevent script error messages
end;

function TEmbeddedWB.ImportCertFile(AFileName, AStoreType: string): Boolean;
var
   f: file; //by Ray
   encCert: PByte;
   encCertLen: DWORD;
   store: HCERTSTORE;
   context: PCCERT_CONTEXT;
   n: PCCERT_CONTEXT;
   encType: DWORD;
begin
   Result := False;
   if FileExists(AFileName) then
      begin
         AssignFile(f, AFileName);
         reset(f, 1);
         encCertLen := FileSize(f);
         GetMem(encCert, encCertLen);
         BlockRead(f, encCert^, encCertLen);
         CloseFile(f);
         try
            encType := PKCS_7_ASN_ENCODING or X509_ASN_ENCODING;
            context := CertCreateCertificateContext(encType, encCert, encCertLen);
            if context = nil then
               begin
                  exit;
               end;
            store := CertOpenSystemStore(0, PChar(AStoreType));
            if store = nil then
               begin
                  exit;
               end;
            n := nil;
            CertAddCertificateContextToStore(store, context,
               CERT_STORE_ADD_REPLACE_EXISTING, n);
            CertCloseStore(store, 0);
            CertFreeCertificateContext(context);
            Result := True;
         finally
            FreeMem(encCert, encCertLen);
         end;
      end;
end;

function TEmbeddedWB.CopyOptionKeyPath(Overrided: Boolean): PWideChar; //Serge
{var
   Len: Integer;}
begin
   if (OptionKeyPath = '') or (OverrideOptionKeyPath xor Overrided) then
      Result := nil
   else
      begin
         Result := PWideChar(WideString(FOptionKeyPath));
         {Len := Length(OptionKeyPath) + 1;
         Result := CoTaskMemAlloc(2 * Len);
         if Result <> nil then
            MultiByteToWideChar(0, 0, Pointer(fOptionKeyPath), Len, Result, Len)
         else
            CoTaskMemFree(Result);}
      end;
end;

function TEmbeddedWB.EvaluateNewWindow(pszUrl, pszName, pszUrlContext,
   pszFeatures: LPCWSTR; fReplace: BOOL; dwFlags, dwUserActionTime: DWORD): HResult;

begin
   if Assigned(fOnEvaluateNewWindow) then
      Result := fOnEvaluateNewWindow(pszUrl, pszName, pszUrlContext, pszFeatures,
         fReplace, dwFlags, dwUserActionTime)
   else
      Result := E_FAIL;
end;

procedure TEmbeddedWB.Go(Url: string);
var
   _URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
begin
   _URL := Url;
   Flags := 0;
   TargetFrameName := 0;
   Postdata := 0;
   Headers := 0;
   if (Trim(_URL) <> '') then
      Navigate2(_URL, Flags, TargetFrameName, PostData, Headers);
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

function TEmbeddedWB.GetDocument: IHtmlDocument2;
begin
   Wait();
   Result := Self.Document as IHtmlDocument2;
   if Result = nil then
      raise Exception.Create('Unable to Load Docuemnt');
end;

procedure TEmbeddedWB.SetFocusToDoc;
begin
   if Document <> nil then
      with
{$IFDEF DELPHI_4}Application_{$ELSE}
      Application{$ENDIF} as IOleobject do
         DoVerb(OLEIVERB_UIACTIVATE, nil, Self, 0, Handle, GetClientRect);
end;

procedure TEmbeddedWB.SetFocusToParent;
begin
   if IsWindow(WindowHandle) then
      begin
         Windows.SetParent(WindowHandle, TWinControl(Self).Parent.Handle);
         MoveWindow(WindowHandle, 0, 0, TWinControl(Self).Parent.Width,
            TWinControl(Self).Parent.Height, True);
         TWinControl(Self).Parent.SetFocus;
         Exit;
      end;
end;

function TEmbeddedWB.SaveToFile(const FName: string): HResult;
begin
   Wait();
   if Assigned(Document) then
      begin
         Result := SaveDocToFile(Document, FName);
      end
   else
      Result := S_False;
end;

function TEmbeddedWB.SaveToStream(AStream: TStream): HResult;
begin
   Wait();
   if Assigned(Document) then
      Result := SaveDocToStream(Document, AStream)
   else
      Result := S_False;
end;

function TEmbeddedWB.SaveToStrings(AStrings: TStrings): HResult;
begin
   Wait();
   if Assigned(document) then
      Result := SaveDocToStrings(Document, AStrings)
   else
      Result := S_False;
end;

function TEmbeddedWB.SaveFrameToFile(FrameNo: Integer; const FName: string): HResult;
var
   Iw: IWebbrowser2;
   PFile: IPersistFile;
begin
   iw := Getframe(frameNo);
   if (iw <> nil) and assigned(iw.Document) then
      begin
         PFile := iw.Document as IPersistFile;
         Result := PFile.Save(StringToOleStr(FName), False);
      end
   else
      Result := S_False;
end;

function TEmbeddedWB.SaveFrameToStream(FrameNo: Integer; AStream: TStream): HResult;
var
   iw: IWebbrowser2;
begin
   Result := S_False;
   iw := Getframe(frameNo);
   if (iw <> nil) and assigned(iw.Document) then
      Result := SaveDocToStream(iw.Document, AStream)
end;

function TEmbeddedWB.SaveFrameToStrings(FrameNo: Integer; AStrings: TStrings): HResult;
var
   iw: Iwebbrowser2;
begin
   Result := S_False;
   iw := Getframe(frameNo);
   if (iw <> nil) and assigned(iw.Document) then
      Result := SaveDocToStrings(iw.Document, AStrings);
end;

function TEmbeddedWB.LoadFromStrings(const AStrings: TStrings): HResult;
var
   M: TMemoryStream;
begin
   if not Assigned(document) then
      AssignEmptyDocument;
   M := TMemoryStream.Create;
   try
      AStrings.SaveToStream(M);
      Result := LoadFromStream(M);
   except
      Result := S_False;
   end;
   M.free;
end;

function TEmbeddedWB.LoadFromStrings(const AStrings: TStrings; AddHtmlTags: Boolean): HResult;

   function AnsiSameStr(const S1, S2: string): Boolean;
   begin
      Result := AnsiCompareStr(S1, S2) = 0;
   end;

   function AnsiStartsStr(const ASubText, AText: string): Boolean;
   begin
      Result := AnsiSameStr(ASubText, System.Copy(AText, 1, Length(ASubText)));
   end;
var
   M: TMemoryStream;
   stn: TStrings;
begin
   if not Assigned(document) then
      AssignEmptyDocument;
   M := TMemoryStream.Create;
   try
      if AddHtmlTags and not AnsiStartsStr('<HTML>', UpperCase(AStrings.GetText)) then
         begin
            stn := TStringList.Create;
            with stn do
               begin
                  Add('<html>');
                  Add('<body>');
                  Add('<body bgcolor="#ffffff">');
                  AddStrings(AStrings);
                  Add('</body>');
                  Add('</html>');
                  SaveToStream(M);
               end;
         end
      else
         AStrings.SaveToStream(M);
      Result := LoadFromStream(M);
   except
      Result := S_False;
   end;
   M.free;
end;

function TEmbeddedWB.LoadFromStream(const AStream: TStream): HResult;
begin
   if not Assigned(Document) then
      AssignEmptyDocument;
   AStream.seek(0, 0);
   Result := (Document as IPersistStreamInit).Load(TStreamadapter.Create(AStream));
end;

function TEmbeddedWB.LoadFrameFromStrings(Frameno: Integer; const AStrings: TStrings): HResult;
var
   iw: IWebbrowser2;
   M: TMemoryStream;
begin
   Result := S_False;
   iw := GetFrame(Frameno);
   if (iw <> nil) and assigned(iw.document) then
      begin
         M := TMemoryStream.Create;
         try
            AStrings.SaveToStream(M);
            M.seek(0, 0);
            Result := (iw.Document as IPersistStreamInit).Load(TStreamadapter.Create(M));
         except
            Result := S_False;
         end;
         M.free;
      end;
end;

function TEmbeddedWB.LoadFrameFromStream(FrameNo: Integer; AStream: TStream): HResult;
var
   iw: IWebbrowser2;
begin
   Result := S_False;
   iw := Getframe(frameNo);
   if (iw <> nil) then
      if Assigned(iw.Document) then
         begin
            AStream.seek(0, 0);
            Result := (iw.Document as IPersistStreamInit).Load(TStreamadapter.Create(AStream));
         end;
end;

procedure TEmbeddedWB.AssignEmptyDocument;
begin
   Go('about:blank');
end;

procedure TEmbeddedWB.Wait;
begin
   while ReadyState <> READYSTATE_COMPLETE do
      Forms.Application.ProcessMessages;
end;

procedure TEmbeddedWB.NavigatePidl(pidl: PItemIdList);
var
   VaEmpty, vaPidl: OleVariant;
   psa: PSafeArray;
   cbData: UINT;
begin
   cbdata := GetPidlSize(pidl);
   psa := SafeArrayCreateVector(VT_UI1, 0, cbData);
   if (psa <> nil) then
      begin
         CopyMemory(psa.pvData, pidl, cbData);
         VariantInit(vaPidl);
         TVariantArg(vaPidl).vt := VT_ARRAY or VT_UI1;
         TVariantArg(vaPidl).parray := psa;
         Navigate2(vaPidl, vaEmpty, vaEmpty, vaEmpty, vaEmpty);
         VariantClear(vaPidl);
      end;
end;

function TEmbeddedWB.GetFrame(FrameNo: Integer): IWebbrowser2;
var
   OleContainer: IOleContainer;
   enum: ActiveX.IEnumUnknown;
   unk: IUnknown;
   Fetched: PLongint;
begin
   wait();
   if Assigned(document) then
      begin
         Fetched := nil;
         OleContainer := Document as IOleContainer;
         OleContainer.EnumObjects(OLECONTF_EMBEDDINGS, Enum);
         Enum.Skip(FrameNo);
         Enum.Next(1, Unk, Fetched);
         Result := Unk as IWebbrowser2;
      end
   else
      Result := nil;
end;

procedure TEmbeddedWB.GetPrintValues;
var
   S: string;
   regWinRegistry: TRegistry;

   function ReadMargin(key: string): Real;
   begin
      S := RegwinRegistry.ReadString(key);
      if S = '' then
         S := '0.750000'; // <-- default margin value  by takeru_tk_81
      S := StringReplace(S, ' ', '', [rfReplaceAll]);
      if DecimalSeparator <> '.' then
         S := StringReplace(S, '.', DecimalSeparator, []);
      if PrintOptions.Measure = mMetric then
         Result := StrToFloat(S) * InchToMetric
      else
         Result := StrToFloat(S);
   end;

begin
   regWinRegistry := TRegistry.Create;
   try
      with regWinRegistry do
         begin
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

function TEmbeddedWB.PrintMarginStr(M: Real): PChar;
var
   S: string;
begin
   if printOptions.Measure <> RuntimeMeasure
      then
      begin
         if RuntimeMeasure = mMetric then
            s := FloatToStr(M * InchToMetric)
         else
            s := FloatToStr(M / InchToMetric);
         Result := PChar(S);
      end
   else
      Result := PChar(FloatToStr(M));
end;

function TEmbeddedWB.DesignMode: Boolean;
var {toms}
   HTMLDocument2: IHTMLDocument2;
   Status: string;
begin
   Result := False;
   HTMLDocument2 := (Document as IHTMLDocument2);
   if HTMLDocument2 <> nil then
      begin
         Status := HTMLDocument2.get_designMode;
         if Status = 'On' then
            begin
               HTMLDocument2.designMode := 'Off';
               Result := False;
            end
         else
            begin
               HTMLDocument2.designMode := 'On';
               Result := True;
            end;
      end;
end;

procedure TEmbeddedWB.Copy;
var
   vaIn, vaOut: Olevariant;
begin
   InvokeCmd(False, OLECMDID_COPY, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
end;

procedure TEmbeddedWB.Paste;
var
   vaIn, vaOut: Olevariant;
begin
   InvokeCmd(False, OLECMDID_PASTE, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
end;

procedure TEmbeddedWB.Cut;
var
   vaIn, vaOut: Olevariant;
begin
   InvokeCmd(False, OLECMDID_CUT, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
end;

procedure TEmbeddedWB.SelectAll;
var
   vaIn, vaOut: OleVariant;
begin
   InvokeCmd(False, OLECMDID_SELECTALL, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
end;

procedure TEmbeddedWB.InvokeCMD(InvokeIE: Boolean; Value1, Value2: Integer; var vaIn, vaOut: OleVariant);
var
   CmdTarget: IOleCommandTarget;
   PtrGUID: PGUID;
begin
   New(PtrGUID);
   if InvokeIE then
      PtrGUID^ := CLSID_WebBrowser
   else
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
      except
      end;
   Dispose(PtrGUID);
end;

function TEmbeddedWB.GetIEHomePage: string;
var
   HomePage: string;
begin
   with TRegistry.Create do
      try
         RootKey := HKEY_CURRENT_USER;
         OpenKey('\Software\Microsoft\Internet Explorer\Main', False);
         HomePage := ReadString('Start Page');
         CloseKey;
      finally
         Free;
      end;
   Result := HomePage;
end;

// -----------------------------------------------------------------------------
// EwbTools
// -----------------------------------------------------------------------------

//Document and Frame -----------------------------------------------------------

{$IFDEF USE_EwbTools}

function TEmbeddedWB.AddHtmlToAboutBlank(StringToHtml: string): Boolean;
begin
   Result := EwbTools.AddHtmlToAboutBlank(Self, StringToHtml);
end;

function TEmbeddedWB.GetFrameFromDocument(SourceDoc: IHtmlDocument2;
   FrameNo: Integer): IWebBrowser2; //By Aladin
begin
   Wait();
   Result := EwbTools.GetFrameFromDocument(SourceDoc, FrameNo)
end;

function TEmbeddedWB.FrameCount: Longint;
begin
   Wait();
   Result := EwbTools.FrameCount(Document);
end;

function TEmbeddedWB.FrameCountFromDocument(SourceDoc:
   IHtmlDocument2): Integer; //By Aladin
begin
   Wait();
   Result := EwbTools.FrameCountFromDocument(SourceDoc);
end;

//Document Operations ----------------------------------------------------------

procedure TEmbeddedWB.ScrollToTop;
begin
   Wait();
   EwbTools.ScrollToTop(OleObject);
end;

procedure TEmbeddedWB.ScrollToBottom;
begin
   Wait();
   EwbTools.ScrollToBottom(OleObject);
end;

procedure TEmbeddedWB.ScrollToPosition(X, Y: Integer);
begin
   Wait();
   EwbTools.ScrollToPosition(OleObject, X, Y);
end;

procedure TEmbeddedWB.Zoom(ZoomValue: Integer);
begin
   EwbTools.Zoom(Document, ZoomValue);
end;

function TEmbeddedWB.ZoomRangeLow: Integer;
begin
   Result := EwbTools.ZoomRangeLow(Document);
end;

function TEmbeddedWB.ZoomRangeHigh: Integer;
begin
   Result := EwbTools.ZoomRangeHigh(Document);
end;

function TEmbeddedWB.ZoomValue: Integer;
begin
   Result := EwbTools.ZoomValue(Document);
end;

function TEmbeddedWB.SetCharartersSet(const ACharactersSet: string): Boolean;
begin
   Wait();
   Result := EwbTools.SetCharartersSet(Self, Document, ACharactersSet);
end;

function TEmbeddedWB.GetCookie: string;
begin
   Wait();
   Result := EwbTools.GetCookie(OleObject);
end;

procedure TEmbeddedWB.GetThumbnail(var Image: TImage);
begin
   EwbTools.GetThumbnail({$IFDEF DELPHI_4}Application_{$ELSE}Application{$ENDIF}, Image)
end;

function TEmbeddedWB.GetBmpFromBrowser(FileName: string): Boolean;
begin
   Result := EwbTools.GetBmpFromBrowser(Document, Self.Handle, Self.Width, Self.Height, FileName);
end;

function TEmbeddedWB.GetJPEGfromBrowser(FileName: string; SourceHeight, SourceWidth,
   TargetHeight, TargetWidth: Integer): Boolean;
begin
   Result := EwbTools.GetJPEGfromBrowser(Document, ControlInterface, FileName, SourceHeight, SourceWidth, TargetHeight, TargetWidth);
end;

//View Document Fields/Properties/Images ---------------------------------------

procedure TEmbeddedWB.ViewPageFieldsToStrings(FieldList: TStrings);
begin
   EwbTools.ViewPageFieldsToStrings(OleObject, FieldList);
end;

procedure TEmbeddedWB.ViewPagePropertiesToStrings(PropertiesList: TStrings);
begin
   Wait();
   EwbTools.ViewPagePropertiesToStrings(OleObject, Document, PropertiesList);
end;

procedure TEmbeddedWB.ViewPageSourceText;
begin
   EwbTools.ViewPageSourceText(OleObject, Document);
end;

procedure TEmbeddedWB.ViewPageSourceTextToStrings(TextList: TStrings);
begin
   Wait();
   EwbTools.ViewPageSourceTextToStrings(OleObject, Document, TextList);
end;

procedure TEmbeddedWB.ViewPageSourceHTMLToStrings(HtmlList: TStrings);
begin
   Wait();
   EwbTools.ViewPageSourceHTMLToStrings(OleObject, Document, HtmlList);
end;

procedure TEmbeddedWB.ViewPageLinksToStrings(LinksList: TStrings);
begin
   EwbTools.ViewPageLinksToStrings(OleObject, LinksList);
end;

procedure TEmbeddedWB.ViewPageImagesToStrings(ImagesList: TStrings);
begin
   EwbTools.ViewPageImagesToStrings(OleObject, ImagesList);
end;

procedure TEmbeddedWB.LoadFromImage(Image: TImage);
begin
   EwbTools.LoadFromImage(Self, Image);
end;

//Printing ---------------------------------------------------------------------

procedure TEmbeddedWB.Print;
begin
   Wait();
   EwbTools.Print(ControlInterface, FPrintOptions.HideSetup);
end;

procedure TEmbeddedWB.PrintWithOptions;
begin
   Wait();
   EwbTools.PrintWithOptions(ControlInterface, Document, True, FPrintOptions.FEnabled, FPrintOptions.HideSetup, InvokingPageSetup);
end;

procedure TEmbeddedWB.PrintPreview;
begin
   EwbTools.PrintPreview(ControlInterface);
end;

procedure TEmbeddedWB.PrintPreviewExtended(nCMDShow: Integer);
begin
   EwbTools.PrintPreviewExtended(ControlInterface, nCMDShow, FPrintOptions.HideSetup);
end;

procedure TEmbeddedWB.PageSetup(UsePrintOptions: Boolean);
begin
   Wait();
   EwbTools.PageSetup(Document, UsePrintOptions, FPrintOptions.FEnabled, InvokingPageSetup);
end;

procedure TEmbeddedWB.PrintSetup;
begin
   Wait();
   EwbTools.PrintSetup(ControlInterface, FPrintOptions.HideSetup);
end;

//Dialogs ---------------------------------------------------------------------

procedure TEmbeddedWB.OpenDialog;
begin
   EwbTools.OpenDialog(Self, Self);
end;

procedure TEmbeddedWB.SaveDialog;
begin
   EwbTools.SaveDialog(Document);
end;

function TEmbeddedWB.SaveDialogEx: string;
begin
   Result := EwbTools.SaveDialog(Self, Self);
end;

procedure TEmbeddedWB.ShowInternetOptions;
begin
   EwbTools.ShowInternetOptions(Document);
end;

procedure TEmbeddedWB.ShowPageProperties;
begin
   EwbTools.ShowPageProperties(Document);
end;

procedure TEmbeddedWB.ShowOrganizeFavorites;
begin
   EwbTools.ShowOrganizeFavorites(Handle);
end;

procedure TEmbeddedWB.ShowImportExportFavoritesAndCookies;
begin
   EwbTools.ShowImportExportFavoritesAndCookies(Handle);
end;

procedure TEmbeddedWB.ShowFindDialog;
begin
   EwbTools.ShowFindDialog(Document)
end;

procedure TEmbeddedWB.SaveImagesDialog;
begin
   EwbTools.SaveImagesDialog(OleObject, Document);
end;

procedure TEmbeddedWB.OpenOtherWBFavorites;
begin
   EwbTools.OpenOtherWBFavorites(Self);
end;

procedure TEmbeddedWB.ViewPageSourceHtml;
begin
   EwbTools.ViewPageSourceHtml(Document);
end;

procedure TEmbeddedWB.SavePageTextDialog;
begin
   Wait();
   EwbTools.SavePageTextDialog(Self, OleObject, Document);
end;

//Open external programs -------------------------------------------------------

function TEmbeddedWB.OpenAddressBook: Boolean;
begin
   Result := True;
   EwbTools.OpenAddressBook;
end;

function TEmbeddedWB.OpenEudoraMail: Boolean;
begin
   Result := True;
   EwbTools.OpenEudoraMail;
end;

function TEmbeddedWB.OpenOutlookMail: Boolean;
begin
   Result := True;
   EwbTools.OpenOutlookMail;
end;

function TEmbeddedWB.OpenOutlookExpressMail: Boolean;
begin
   Result := True;
   EwbTools.OpenOutlookExpressMail;
end;

function TEmbeddedWB.OpenCalendar: Boolean;
begin
   Result := EwbTools.OpenCalendar()
end;

function TEmbeddedWB.OpenClient(Client: string): Boolean;
begin
   Result := EwbTools.OpenClient(Client);
end;

function TEmbeddedWB.OpenRegistryEditor: Boolean;
begin
   Result := True;
   EwbTools.OpenRegistryEditor;
end;

function TEmbeddedWB.OpenNewsClient: Boolean;
begin
   Result := EwbTools.OpenNewsClient()
end;

function TEmbeddedWB.OpenNetMeeting: Boolean;
begin
   Result := EwbTools.OpenNetMeeting()
end;

procedure TEmbeddedWB.ExploreFolder(Path: string);
begin
   EwbTools.DoExploreFolder(Handle, Path);
end;

procedure TEmbeddedWB.OpenIEBrowserWithAddress;
begin
   EwbTools.OpenIEBrowserWithAddress(Handle);
end;

//Open specific webpages -------------------------------------------------------

function TEmbeddedWB.OpenHotmailMail: Boolean;
begin
   Result := EwbTools.OpenHotmailMail(Self)
end;

function TEmbeddedWB.OpenYahooMail: Boolean;
begin
   Result := EwbTools.OpenGoogleMail(Self)
end;

function TEmbeddedWB.OpenGoogleMail: Boolean;
begin
   Result := EwbTools.OpenGoogleMail(Self)
end;

procedure TEmbeddedWB.GoSearchInGoogle(SearchTerm: string);
begin
   EwbTools.GoSearchInGoogle(Self, SearchTerm)
end;

procedure TEmbeddedWB.GoSearchInMSN(SearchTerm: string);
begin
   EwbTools.GoSearchInMSN(Self, SearchTerm)
end;

procedure TEmbeddedWB.GoSearchInYahoo(SearchTerm: string);
begin
   EwbTools.GoSearchInYahoo(Self, SearchTerm)
end;

//Navigate & Download ----------------------------------------------------------

procedure TEmbeddedWB.GoDownloadFile(URL: string);
begin
   EwbTools.GoDownloadFile(Self, URL);
end;

procedure TEmbeddedWB.GoDownloadMaskedFile(SourceFile, TargetFile: string; Notify: Boolean);
begin
   EwbTools.GoDownloadMaskedFile(SourceFile, TargetFile, Notify);
end;

procedure TEmbeddedWB.GoWithQueryDetails(Url, Query: string);
begin
   EwbTools.GoWithQueryDetails(Self, Url, Query);
end;

procedure TEmbeddedWB.GoNoHistory(const URL: string);
begin
   EwbTools.GoNoHistory(Self, URL);
end;

procedure TEmbeddedWB.NavigateFolder(CSIDL: Integer);
begin
   EwbTools.NavigateFolder(Self, CSIDL);
end;

function TEmbeddedWB.NavigateToFrame(FrameList: string): IHtmlDocument2;
begin
   Result := EwbTools.NavigateToFrame(Self, FrameList);
end;

procedure TEmbeddedWB.GoAboutBlank;
begin
   EwbTools.GoAboutBlank(Self);
end;

function TEmbeddedWB.DownloadFile(SourceFile, DestFile: string): Boolean;
begin
   Result := EwbTools.DownloadFile(SourceFile, DestFile);
end;

//Get Special Folders/URL paths etc.--------------------------------------------

function TEmbeddedWB.GetCookiesPath: string;
begin
   Result := EwbTools.GetCookiesPath;
end;

function TEmbeddedWB.GetHistoryPath: string;
begin
   Result := EwbTools.GetHistoryPath;
end;

function TEmbeddedWB.GetFavoritesPath: string;
begin
   Result := EwbTools.GetFavoritesPath;
end;

function TEmbeddedWB.GetDefaultBrowserFromRegistry: string;
begin
   Result := EwbTools.GetDefaultBrowserFromRegistry;
end;

function TEmbeddedWB.GetSpecialFolderPath(CallerHandle: THandle; CSIDL: Integer): PChar;
begin
   Result := EwbTools.GetSpecialFolderPath(CallerHandle, CSIDL);
end;

function TEmbeddedWB.GetCachedFileFromURL(strUL: string; var strLocalFile: string): Boolean;
begin
   Result := EwbTools.GetCachedFileFromURL(strUL, strLocalFile)
end;

function TEmbeddedWB.URLFromFavorites(const dotURL: string): string;
begin
   Result := EwbTools.URLFromFavorites(dotURL);
end;

function TEmbeddedWB.UrlFromHistory(ShellFolder: IShellFolder; pidl: PItemIDList): string;
begin
   Result := EwbTools.UrlFromHistory(ShellFolder, pidl)
end;

function TEmbeddedWB.GetIPAndHostName(var HostName, IPaddr, WSAErr: string): Boolean;
begin
   Result := EwbTools.GetIPAndHostName(HostName, IPaddr, WSAErr);
end;

//E-Mail functions--------------------------------------------------------------

procedure TEmbeddedWB.SendPageInMailAsAttachment(aOwner: TComponent; FileName, Subject, Body: string);
begin
   EwbTools.SendPageInMailAsAttachment(Self, aOwner, Document, FileName, Subject, Body);
end;

procedure TEmbeddedWB.CreateNewMail;
begin
   EwbTools.CreateNewMail;
end;

procedure TEmbeddedWB.SendUrlInMail;
begin
   EwbTools.SendUrlInMail(LocationURL, LocationName);
end;

//Search in Document & Fill Forms-----------------------------------------------

function TEmbeddedWB.SearchText(const Value: string; const iPos: Integer = 1): IHTMLTxtRange;
begin //by JJM
   Result := EwbTools.SearchText(Self, Document, Value, iPos);
end;

function TEmbeddedWB.SearchString(const strText: string): Boolean;
begin
   Result := EwbTools.SearchString(Self, strText);
end;

procedure TEmbeddedWB.SearchAndHighlight(const ACaption, APrompt: string; aText: string = ''; ShowInputQuery: Boolean = False);
begin
   Wait();
   EwbTools.SearchAndHighlight(Document, ACaption, APrompt, aText, ShowInputQuery);
end;

function TEmbeddedWB.FillForm(FieldName: string; Value: string): Boolean;
begin
   Result := EwbTools.FillForm(OleObject, FieldName, Value)
end;

procedure TEmbeddedWB.AutoFillIEFormAndExcecute;
begin
   EwbTools.AutoFillIEFormAndExcecute
end;

//Clearing Cache/History/Typed Urls---------------------------------------------

procedure TEmbeddedWB.ClearCache;
begin
   EwbTools.ClearCache;
end;

procedure TEmbeddedWB.ClearTypedUrls;
begin
   EwbTools.ClearTypedUrls;
end;

procedure TEmbeddedWB.ClearHistory;
begin
   EwbTools.ClearHistory;
end;

//Online Status-----------------------------------------------------------------

function TEmbeddedWB.CheckOnlineStatus: Boolean;
begin
   Result := EwbTools.CheckOnlineStatus;
end;

function TEmbeddedWB.IsGlobalOffline: Boolean;
begin
   Result := EwbTools.IsGlobalOffline;
end;

procedure TEmbeddedWB.WorkOnline;
begin
   EwbTools.WorkOnline(Self);
end;

procedure TEmbeddedWB.WorkOffline;
begin
   EwbTools.WorkOffline(Self);
end;

//Restricted & Trusted Lists----------------------------------------------------

procedure TEmbeddedWB.AddToRestrictedSiteList(URL: string);
begin
   EwbTools.AddToRestrictedSiteList(Self, URL);
end;

procedure TEmbeddedWB.AddToTrustedSiteList(URL: string);
begin
   EwbTools.AddToTrustedSiteList(Self, URL);
end;

function TEmbeddedWB.CheckIfInTrustedList(URL: string): Boolean;
begin
   Result := EwbTools.CheckIfInTrustedList(URL);
end;

function TEmbeddedWB.CheckIfInRestricredList(URL: string): Boolean;
begin
   Result := EwbTools.CheckIfInRestricredList(URL);
end;

//Zone Icon, Security Zone, SSL Status  ----------------------------------------

procedure TEmbeddedWB.GetZoneIcon(IconPath: string; var Icon: TIcon);
begin
   EwbTools.GetZoneIcon(IconPath, Icon);
end;

function TEmbeddedWB.GetZoneAttributes(const URL: string): TZoneAttributes;
begin
   Result := EwbTools.GetZoneAttributes(LocationURL);
end;

function TEmbeddedWB.GetZoneIconToForm: Boolean;
begin
   Result := EwbTools.GetZoneIconToForm(LocationURL, Caption, Hint);
end;

function TEmbeddedWB.GetSSLStatus(var SSLName, SSLDescription: string): Boolean;
begin
   Result := EwbTools.GetSSLStatus(OleObject, LocationURL, SSLName, SSLDescription);
end;

function TEmbeddedWB.GetUrlSecurityZone(var ZoneName, ZoneDescription: string; var Icon: TIcon): Boolean;
begin
   Result := EwbTools.GetUrlSecurityZone(LocationURL, ZoneName, ZoneDescription, Icon);
end;

//Proxy & User agent -----------------------------------------------------------

procedure TProxySettings.SetProxy(FUserAgent, Server: string);
begin
   EwbTools.SetProxy(FUserAgent, Server);
end;

procedure TEmbeddedWB.SetUserAgent;
begin
   EwbTools.SetUserAgent(FUserAgent);
end;

procedure TEmbeddedWB.RemoveUserAgent;
begin
   EwbTools.RemoveUserAgent(FUserAgent);
end;

//Miscellaneous  ---------------------------------------------------------------

procedure TEmbeddedWB.RestoreApplicationFormSize;
begin
   EwbTools.RestoreApplicationFormSize(Self);
end;

procedure TEmbeddedWB.SaveApplicationFormSize;
begin
   EwbTools.SaveApplicationFormSize(Self);
end;

function TEmbeddedWB.GetIEHandle(WebBrowser: TEmbeddedWB; ClassName: string): HWND;
begin
   Result := EwbTools.GetIEHandle(WebBrowser, ClassName);
end;

procedure TEmbeddedWB.ShowIEVersionInfo;
begin
   EwbTools.ShowIEVersionInfo(Handle);
end;

procedure TEmbeddedWB.SetNewHomePage(HomePage: string);
begin
   EwbTools.SetNewHomePage(HomePage);
end;

function TEmbeddedWB.GetLastVisitedPage(var LastVisitedPage: string): Boolean;
begin
   Result := EwbTools.GetLastVisitedPage(LastVisitedPage);
end;

function TEmbeddedWB.SaveLastVisitedPage: Boolean;
begin
   Result := EwbTools.SaveLastVisitedPage(Self, LocationURL);
end;

procedure TEmbeddedWB.AddToFavorites(URL, Title: string);
begin
   inherited;
   EwbTools.AddToFavorites(URL, Title);
end;

procedure TEmbeddedWB.CreateDesktopShortcut;
begin
   EwbTools.CreateDesktopShortcut(Handle);
end;

procedure TEmbeddedWB.DisableNavSound(bDisable: Boolean);
begin
   EwbTools.DisableNavSound(bDisable);
end;

function TEmbeddedWB.IsValidProtocol(const URL: string): Boolean;
begin
   Result := EwbTools.IsValidProtocol(URL);
end;

function TEmbeddedWB.DecodeUrl(const InputStr: string): string;
begin
   Result := EwbTools.DecodeUrl(InputStr);
end;

function TEmbeddedWB.EncodeUrl(const InputStr: string; const bQueryStr: Boolean): string;
begin
   Result := EwbTools.EncodeUrl(InputStr, bQueryStr);
end;

{$ENDIF}
//End of EwbTools---------------------------------------------------------------

initialization
   Saved8087CW := Default8087CW;
   bMsgHandler := False;
   OleInitialize(nil);
finalization
   Set8087CW(Saved8087CW);
   try
      OleUninitialize;
   except
   end;
end.

