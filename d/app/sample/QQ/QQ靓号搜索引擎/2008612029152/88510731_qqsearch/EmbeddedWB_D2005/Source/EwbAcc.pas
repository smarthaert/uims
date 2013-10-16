//**************************************************************
//                                                             *
//                               EwbAcc                        *                                                      *
//                 For Delphi 5, 6, 7, 2005, 2006              *
//                            by bsalsa                        *
//                    based on a code by Per Larsen            *
//                                                             *
//  Updated versions:                                          *
//               http://www.bsalsa.com                         *
//**************************************************************

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

You may use, change or modify the component under 3 conditions:
1. In your website, add a link to "http://www.bsalsa.com"
2. In your application, add credits to "Embedded Web Browser"
3. Mail me  (bsalsa@bsalsa.com) any code change in the unit
   for the benefit of the other users.
{*******************************************************************************}

unit EwbAcc;

interface

{$I EWB.inc}

  uses
   Activex, SysUtils, ShlObj, Windows, Urlmon;

const //TGUID
   CGID_DocHostCommandHandler: TGUID = (D1: $F38BC242; D2: $B950; D3: $11D1; D4: ($89, $18, $00, $C0, $4F, $C2, $C8, $36));
   CLSID_CUrlHistory: TGUID = '{3C374A40-BAE4-11CF-BF7D-00AA006946EE}';
   CLSID_ShellUIHelper: TGUID = '{64AB4BB7-111E-11D1-8F79-00C04FC2FBE1}';
   CLSID_WebBrowser: TGUID = '{ED016940-BD5B-11cf-BA4E-00C04FD70816}'; //when you add new Command IDs
   CMDSETID_Forms3: TGUID = '{DE4BA900-59CA-11CF-9592-444553540000}';
   GUID_TriEditCommandGroup: TGUID = '{2582F1C0-084E-11d1-9A0E-006097C9B344}';
   IID_IACList: TGUID = '{77A130B0-94FD-11D0-A544-00C04FD7d062}';
   IID_IACList2: TGUID = '{470141a0-5186-11d2-bbb6-0060977b464c}';
   IID_ICustomDoc: TGUID='{425B5AF0-65F1-11D1-9611-0000F81E0D0D}';
   IID_IDocHostShowUI: TGUID = '{c4d244b0-d43e-11cf-893b-00aa00bdce1a}';
   IID_IDocHostUIHandler: TGUID = '{bd3f23c0-d43e-11cf-893b-00aa00bdce1a}';
   IID_IDocHostUIHandler2: TGUID = '{3050f6d0-98b5-11cf-bb82-00aa00bdce0b}';
   IID_IDownloadManager: TGUID = (D1: $988934A4; D2: $064B; D3: $11D3; D4: ($BB, $80, $0, $10, $4B, $35, $E7, $F9));
   IID_IEnumStatUrl: TGUID = (D1: $3C374A42; D2: $BAE4; D3: $11CF; D4: ($BF, $7D, $00, $AA, $00, $69, $46, $EE));
   IID_IHTMLOMWindowServices: TGUID = '{3050F5FC-98B5-11CF-BB82-00AA00BDCE0B}';
   IID_IInternetHostSecurityManager: TGUID = '{3af280b6-cb3f-11d0-891e-00c04fb6bfc4}';
   IID_IInternetSecurityManager: TGUID = '{79eac9ee-baf9-11ce-8c82-00aa004ba90b}';
   IID_IInternetSecurityMgrSite: TGUID = '{79eac9ed-baf9-11ce-8c82-00aa004ba90b}';
   IID_IInternetSession: TGUID = '{79eac9e7-baf9-11ce-8c82-00aa004ba90b}';
   IID_IInternetZoneManager: TGUID = '{79eac9ef-baf9-11ce-8c82-00aa004ba90b}';
   IID_INewWindowManager: TGUID = '{D2BC4C84-3F72-4a52-A604-7BCBF3982CBB}';
   IID_IQueryInfo: TGUID = (D1: $00021500; D2: $0000; D3: $0000; D4: ($C0, $00, $00, $00, $00, $00, $00, $46));
   IID_IUniformResourceLocatorA: TGUID = (D1: $FBF23B80; D2: $E3F0; D3: $101B; D4: ($84, $88, $00, $AA, $00, $3E, $56, $F8));
   IID_IUniformResourceLocatorW: TGUID = (D1: $CABB0DA0; D2: $DA57; D3: $11CF; D4: ($99, $74, $00, $20, $AF, $D7, $97, $62));
   IID_IUrlHistoryNotify: TGUID = (D1: $BC40BEC1; D2: $C493; D3: $11D0; D4: ($83, $1B, $00, $C0, $4F, $D5, $AE, $38));
   IID_IUrlHistoryStg: TGUID = (D1: $3C374A41; D2: $BAE4; D3: $11CF; D4: ($BF, $7D, $00, $AA, $00, $69, $46, $EE));
   IID_IUrlHistoryStg2: TGUID = (D1: $AFA0DC11; D2: $C313; D3: $831A; D4: ($83, $1A, $00, $C0, $4F, $D5, $AE, $38));
   SID_IHTMLOMWindowServices = '{3050F5FC-98B5-11CF-BB82-00AA00BDCE0B}';
   SID_IInternetHostSecurityManager: TGUID = '{3af280b6-cb3f-11d0-891e-00c04fb6bfc4}';
   SID_IInternetSecurityManager: TGUID = '{79eac9ee-baf9-11ce-8c82-00aa004ba90b}';
{$IFDEF UNICODE}
   IID_IUniformResourceLocator: TGUID = (D1: $CABB0DA0; D2: $DA57; D3: $11CF; D4: ($99, $74, $00, $20, $AF, $D7, $97, $62));
{$ELSE}
   IID_IUniformResourceLocator: TGUID = (D1: $FBF23B80; D2: $E3F0; D3: $101B; D4: ($84, $88, $00, $AA, $00, $3E, $56, $F8));
{$ENDIF}
   CLSID_InternetShortCut: TGUID = (d1: $FBF23B40; D2: $E3F0; D3: $101B; D4: ($84, $88, $00, $AA, $00, $3E, $56, $F8));
   SID_IUniformResourceLocatorA = '{FBF23B80-E3F0-101B-8488-00AA003E56F8}';
   SID_IUniformResourceLocatorW = '{CABB0DA0-DA57-11CF-9974-0020AFD79762}';
{$IFDEF UNICODE}
   SID_IUniformResourceLocator = SID_IUniformResourceLocatorW;
{$ELSE}
   SID_IUniformResourceLocator = SID_IUniformResourceLocatorA;
{$ENDIF}



type
   BrowserNavConstants = TOleEnum;

   STATURL = record
      cbSize: DWORD;
      pwcsUrl: DWORD;
      pwcsTitle: DWORD;
      ftLastVisited: FILETIME;
      ftLastUpdated: FILETIME;
      ftExpires: FILETIME;
      dwFlags: DWORD;
   end;

   IDownloadManager = interface(IUnknown)
      ['{988934A4-064B-11D3-BB80-00104B35E7F9}']
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
   end;

   IEnumSTATURL = interface(IUnknown)
      ['{3C374A42-BAE4-11CF-BF7D-00AA006946EE}']
      function Next(celt: Integer; out elt; pceltFetched: PLongint): HRESULT; stdcall;
      function Skip(celt: Longint): HRESULT; stdcall;
      function Reset: HResult; stdcall;
      function Clone(out ppenum: IEnumSTATURL): HResult; stdcall;
      function SetFilter(poszFilter: PWideChar; dwFlags: DWORD): HResult; stdcall;
   end;

   IUrlHistoryStg = interface(IUnknown)
      ['{3C374A41-BAE4-11CF-BF7D-00AA006946EE}']
      function AddUrl(pocsUrl: PWideChar; pocsTitle: PWideChar; dwFlags: Integer): HResult; stdcall;
      function DeleteUrl(pocsUrl: PWideChar; dwFlags: Integer): HResult; stdcall;
      function QueryUrl(pocsUrl: PWideChar; dwFlags: Integer; var lpSTATURL: STATURL): HResult; stdcall;
      function BindToObject(pocsUrl: PWideChar; var riid: TIID; out ppvOut: Pointer): HResult; stdcall;
      function EnumUrls(out ppenum: IEnumSTATURL): HResult; stdcall;
   end;

   IUrlHistoryStg2 = interface(IUrlHistoryStg)
      ['{AFA0DC11-C313-11D0-831A-00C04FD5AE38}']
      function AddUrlAndNotify(pocsUrl: PWideChar; pocsTitle: PWideChar; dwFlags: Integer;
         fWriteHistory: Integer; var poctNotify: Pointer;
         const punkISFolder: IUnknown): HResult; stdcall;
      function ClearHistory: HResult; stdcall;
   end;

   IUrlHistoryNotify = interface(IOleCommandTarget)
      ['{BC40BEC1-C493-11d0-831B-00C04FD5AE38}']
   end;

   PDOCHOSTUIINFO = ^TDOCHOSTUIINFO;
   TDOCHOSTUIINFO = record
      cbSize: ULONG;
      dwFlags: DWORD;
      dwDoubleClick: DWORD;
      chHostCss: POLESTR;
      chHostNS: POLESTR;
   end;

  type
  INewWindowManager = interface (IUnknown) //Serge
  ['{D2BC4C84-3F72-4a52-A604-7BCBF3982CBB}']
     function EvaluateNewWindow(pszUrl, pszName, pszUrlContext, pszFeatures: LPCWSTR;
      fReplace: BOOL; dwFlags, dwUserActionTime: DWORD): HRESULT; stdcall;
  end;

   IDocHostShowUI = interface(IUnknown)
      ['{c4d244b0-d43e-11cf-893b-00aa00bdce1a}']
      function ShowMessage(hwnd: THandle; lpstrText: POLESTR; lpstrCaption: POLESTR;
         dwType: longint; lpstrHelpFile: POLESTR; dwHelpContext: longint;
         var plResult: LRESULT): HRESULT; stdcall;
      function ShowHelp(hwnd: THandle; pszHelpFile: POLESTR; uCommand: integer;
         dwData: longint; ptMouse: TPoint;
         var pDispatchObjectHit: IDispatch): HRESULT; stdcall;
   end; // IDocHostShowUI


   IDocHostUIHandler = interface(IUnknown)
      ['{bd3f23c0-d43e-11cf-893b-00aa00bdce1a}']
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
         const fRameWindow: BOOL): HRESULT; stdcall;
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
   end; // IDocHostUIHandler

   IDocHostUIHandler2 = interface(IDocHostUIHandler)
      ['{3050f6d0-98b5-11cf-bb82-00aa00bdce0b}']
      function GetOverrideKeyPath(pchKey: POLESTR; dw: DWORD): HRESULT; stdcall;
   end;

   IProtectFocus = interface(IDocHostUIHandler)
     ['{D81F90A3-8156-44F7-AD28-5ABB87003274}']
     function AllowFocusChange(const pfAllow : Boolean): HRESULT; stdcall;
   end;

   ICustomDoc = interface(IUnknown)
       ['{3050f3f0-98b5-11cf-bb82-00aa00bdce0b}']
       function SetUIHandler (const pUIHandler : IDocHostUIHandler) : HRESULT; stdcall;
      end; // ICustomDoc

   IHTMLOMWindowServices = interface(IUnknown)
      ['{3050f5fc-98b5-11cf-bb82-00aa00bdce0b}']
      function moveTo(const x, y: Integer): HRESULT; stdcall;
      function moveBy(const x, y: Integer): HRESULT; stdcall;
      function resizeTo(const x, y: Integer): HRESULT; stdcall;
      function resizeBy(const x, y: Integer): HRESULT; stdcall;
   end;


type
   TMoveResizeByEvent = procedure(Sender: TObject; cx, cy: Integer) of object;
   TMoveEvent = procedure(Sender: TObject; X, Y: Integer) of object;
   TResizeEvent = procedure(Sender: TObject; Width, Height: Integer) of object;


   PUrlInvokeCommandInfoA = ^TUrlInvokeCommandInfoA;
   TUrlInvokeCommandInfoA = record
      dwcbSize: DWORD; // Size of structure
      dwFlags: DWORD; // Bit field of IURL_INVOKECOMMAND_FLAGS
      hwndParent: HWND; // Parent window.  Valid only if IURL_INVOKECOMMAND_FL_ALLOW_UI is set.
      pcszVerb: LPCSTR; // Verb to invoke.  Ignored if IURL_INVOKECOMMAND_FL_USE_DEFAULT_VERB is set.
   end;

   PUrlInvokeCommandInfoW = ^TUrlInvokeCommandInfoW;
   TUrlInvokeCommandInfoW = record
      dwcbSize: DWORD; // Size of structure
      dwFlags: DWORD; // Bit field of IURL_INVOKECOMMAND_FLAGS
      hwndParent: HWND; // Parent window.  Valid only if IURL_INVOKECOMMAND_FL_ALLOW_UI is set.
      pcszVerb: LPCWSTR; // Verb to invoke.  Ignored if IURL_INVOKECOMMAND_FL_USE_DEFAULT_VERB is set.
   end;

{$IFDEF UNICODE}
   PURLInvokeCommandInfo = ^TUrlInvokeCommandInfoW;
   TUrlInvokeCommandInfo = TUrlInvokeCOmmandInfoW;
{$ELSE}
   PURLInvokeCommandInfo = ^TUrlInvokeCommandInfoA;
   TUrlInvokeCommandInfo = TUrlInvokeCOmmandInfoA;
{$ENDIF}

   IUniformResourceLocatorA = interface(IUnknown)
      [SID_IUniformResourceLocatorA]
      function SetURL(pcszURL: LpcStr; dwInFlags: DWORD): HRESULT; stdcall;
      function GetURL(ppszURL: LpStr): HRESULT; stdcall;
      function InvokeCommand(purlici: PURLINVOKECOMMANDINFOA): HRESULT; stdcall;

   end;

   IUniformResourceLocatorW = interface(IUnknown)
      [SID_IUniformResourceLocatorW]
      function SetURL(pcszURL: LpcWStr; dwInFlags: DWORD): HRESULT; stdcall;
      function GetURL(ppszURL: LpWStr): HRESULT; stdcall;
      function InvokeCommand(purlici: PURLINVOKECOMMANDINFOW): HRESULT; stdcall;
   end;

{$IFDEF UNICODE}
   IUniformResourceLocator = IUniformResourceLocatorW;
{$ELSE}
   IUniformResourceLocator = IUniformResourceLocatorA;
{$ENDIF}

function TranslateURLA(pcszURL: LPCSTR;
   dwInFlags: DWORD;
   ppszTranslatedURL: LPSTR): HRESULT; stdcall;

function TranslateURLW(pcszURL: LPCWSTR;
   dwInFlags: DWORD;
   ppszTranslatedURL: LPWSTR): HRESULT; stdcall;

{$IFDEF UNICODE}
function TranslateURL(pcszURL: LPCWSTR;
   dwInFlags: DWORD;
   ppszTranslatedURL: LPWSTR): HRESULT; stdcall;
{$ELSE}
function TranslateURL(pcszURL: LPCSTR;
   dwInFlags: DWORD;
   ppszTranslatedURL: LPSTR): HRESULT; stdcall;
{$ENDIF}

function URLAssociationDialogA(hwndParent: HWND;
   dwInFlags: DWORD;
   pcszFile: LPCSTR;
   pcszURL: LPCSTR;
   pszAppBuf: LPSTR;
   ucAppBufLen: UINT): HRESULT; stdcall;

function URLAssociationDialogW(hwndParent: HWND;
   dwInFlags: DWORD;
   pcszFile: LPCWSTR;
   pcszURL: LPCWSTR;
   pszAppBuf: LPWSTR;
   ucAppBufLen: UINT): HRESULT; stdcall;

{$IFDEF UNICODE}
function URLAssociationDialog(hwndParent: HWND;
   dwInFlags: DWORD;
   pcszFile: LPCWSTR;
   pcszURL: LPCWSTR;
   pszAppBuf: LPWSTR;
   ucAppBufLen: UINT): HRESULT; stdcall;
{$ELSE}
function URLAssociationDialog(hwndParent: HWND;
   dwInFlags: DWORD;
   pcszFile: LPCSTR;
   pcszURL: LPCSTR;
   pszAppBuf: LPSTR;
   ucAppBufLen: UINT): HRESULT; stdcall;
{$ENDIF}

function MIMEAssociationDialogA(hwndParent: HWND;
   dwInFlags: DWORD;
   pcszFile: LPCSTR;
   pcszMIMEContentType: LPCSTR;
   pszAppBuf: LPSTR;
   ucAppBufLen: UINT): HRESULT; stdcall;

function MIMEAssociationDialogW(hwndParent: HWND;
   dwInFlags: DWORD;
   pcszFile: LPCWSTR;
   pcszMIMEContentType: LPCWSTR;
   pszAppBuf: LPWSTR;
   ucAppBufLen: UINT): HRESULT; stdcall;

{$IFDEF UNICODE}
function MIMEAssociationDialog(hwndParent: HWND;
   dwInFlags: DWORD;
   pcszFile: LPCWSTR;
   pcszMIMEContentType: LPCWSTR;
   pszAppBuf: LPWSTR;
   ucAppBufLen: UINT): HRESULT; stdcall;
{$ELSE}
function MIMEAssociationDialog(hwndParent: HWND;
   dwInFlags: DWORD;
   pcszFile: LPCSTR;
   pcszMIMEContentType: LPCSTR;
   pszAppBuf: LPSTR;
   ucAppBufLen: UINT): HRESULT; stdcall;
{$ENDIF}

function InetIsOffline(dwFlags: DWORD): BOOL; stdcall;

{$IFDEF VER120}

type
   TUrlZoneReg = ULONG;

   PBindInfo = ^TBindInfo;
   _tagBINDINFO = packed record
      cbSize: ULONG;
      szExtraInfo: LPWSTR;
      stgmedData: TStgMedium;
      grfBindInfoF: DWORD;
      dwBindVerb: DWORD;
      szCustomVerb: LPWSTR;
      cbstgmedData: DWORD;
      dwOptions: DWORD;
      dwOptionsFlags: DWORD;
      dwCodePage: DWORD;
      securityAttributes: TSecurityAttributes;
      iid: TGUID;
      pUnk: IUnknown;
      dwReserved: DWORD;
   end;
   TBindInfo = _tagBINDINFO;
   BINDINFO = _tagBINDINFO;

{$NODEFINE POLEStrArray}
   POLEStrArray = ^TOLESTRArray;
{$NODEFINE TOLEStrArray}
   TOLEStrArray = array[0..MaxLongint div SizeOf(POLEStr) - 1] of POLEStr;

{$EXTERNALSYM IInternetBindInfo}
   IInternetBindInfo = interface
      ['{79eac9e1-baf9-11ce-8c82-00aa004ba90b}']
      function GetBindInfo(out grfBINDF: DWORD; var bindinfo: TBindInfo): HResult; stdcall;
      function GetBindString(ulStringType: ULONG; wzStr: POLEStrArray; cEl: ULONG;
         var cElFetched: ULONG): HResult; stdcall;
   end;

   PProtocolData = ^TProtocolData;
{$EXTERNALSYM _tagPROTOCOLDATA}
   _tagPROTOCOLDATA = packed record
      grfFlags: DWORD;
      dwState: DWORD;
      pData: Pointer;
      cbData: ULONG;
   end;
   TProtocolData = _tagPROTOCOLDATA;
{$EXTERNALSYM _tagPROTOCOLDATA}
   PROTOCOLDATA = _tagPROTOCOLDATA;

{$EXTERNALSYM IInternetProtocolSink}
   IInternetProtocolSink = interface; // forward

{$EXTERNALSYM IInternetProtocolRoot}
   IInternetProtocolRoot = interface
      ['{79eac9e3-baf9-11ce-8c82-00aa004ba90b}']
      function Start(szUrl: LPCWSTR; OIProtSink: IInternetProtocolSink;
         OIBindInfo: IInternetBindInfo; grfPI, dwReserved: DWORD): HResult; stdcall;
      function Continue(const ProtocolData: TProtocolData): HResult; stdcall;
      function Abort(hrReason: HResult; dwOptions: DWORD): HResult; stdcall;
      function Terminate(dwOptions: DWORD): HResult; stdcall;
      function Suspend: HResult; stdcall;
      function Resume: HResult; stdcall;
   end;

{$EXTERNALSYM IInternetProtocol}
   IInternetProtocol = interface(IInternetProtocolRoot)
      ['{79eac9e4-baf9-11ce-8c82-00aa004ba90b}']
      function Read(pv: Pointer; cb: ULONG; out cbRead: ULONG): HResult; stdcall;
      function Seek(dlibMove: LARGE_INTEGER; dwOrigin: DWORD; out libNewPosition: ULARGE_INTEGER): HResult; stdcall;
      function LockRequest(dwOptions: DWORD): HResult; stdcall;
      function UnlockRequest: HResult; stdcall;
   end;

{$EXTERNALSYM IInternetProtocolSink}
   IInternetProtocolSink = interface
      ['{79eac9e5-baf9-11ce-8c82-00aa004ba90b}']
      function Switch(const ProtocolData: TProtocolData): HResult; stdcall;
      function ReportProgress(ulStatusCode: ULONG; szStatusText: LPCWSTR): HResult; stdcall;
      function ReportData(grfBSCF: DWORD; ulProgress, ulProgressMax: ULONG): HResult; stdcall;
      function ReportResult(hrResult: HResult; dwError: DWORD; szResult: LPCWSTR): HResult; stdcall;
   end;

{$NODEFINE TLPCWSTRArray}
   TLPCWSTRArray = array[0..MaxLongInt div SizeOf(LPCWSTR) - 1] of LPCWSTR;
{$NODEFINE PLPCWSTRArray}
   PLPCWSTRArray = ^TLPCWSTRArray;

{$EXTERNALSYM IInternetSession}
   IInternetSession = interface
      ['{79eac9e7-baf9-11ce-8c82-00aa004ba90b}']
      function RegisterNameSpace(CF: IClassFactory; const clsid: TCLSID; pwzProtocol: LPCWSTR;
         cPatterns: ULONG; const pwzPatterns: PLPCWSTRArray; dwReserved: DWORD): HResult; stdcall;
      function UnregisterNameSpace(CF: IClassFactory; pszProtocol: LPCWSTR): HResult; stdcall;
      function RegisterMimeFilter(CF: IClassFactory; const rclsid: TCLSID;
         pwzType: LPCWSTR): HResult; stdcall;
      function UnregisterMimeFilter(CF: IClassFactory; pwzType: LPCWSTR): HResult; stdcall;
      function CreateBinding(BC: IBindCtx; szUrl: LPCWSTR; UnkOuter: IUnknown; out Unk: IUnknown;
         out OINetProt: IInternetProtocol; dwOption: DWORD): HResult; stdcall;
      function SetSessionOption(dwOption: DWORD; pBuffer: Pointer; dwBufferLength: DWORD;
         dwReserved: DWORD): HResult; stdcall;
      function GetSessionOption(dwOption: DWORD; pBuffer: Pointer; var dwBufferLength: DWORD;
         dwReserved: DWORD): HResult; stdcall;
   end; // IInternetSession

{$EXTERNALSYM CoInternetGetSession}
function CoInternetGetSession(dwSessionMode: DWORD; var pIInternetSession: IInternetSession;
   dwReserved: DWORD): HResult; stdcall;

type
{$EXTERNALSYM IInternetSecurityMgrSite}
   IInternetSecurityMgrSite = interface
      ['{79eac9ed-baf9-11ce-8c82-00aa004ba90b}']
      function GetWindow(out hwnd: HWnd): HResult; stdcall;
      function EnableModeless(fEnable: BOOL): HResult; stdcall;
   end;

const
{$EXTERNALSYM MAX_SIZE_SECURITY_ID}
   MAX_SIZE_SECURITY_ID = 512; // bytes;

  // MapUrlToZone returns the zone index given a URL
{$EXTERNALSYM PUAF_DEFAULT}
   PUAF_DEFAULT = $00000000;
{$EXTERNALSYM PUAF_NOUI}
   PUAF_NOUI = $00000001;
{$EXTERNALSYM PUAF_ISFILE}
   PUAF_ISFILE = $00000002;
{$EXTERNALSYM PUAF_WARN_IF_DENIED}
   PUAF_WARN_IF_DENIED = $00000004;
{$EXTERNALSYM PUAF_FORCEUI_FOREGROUND}
   PUAF_FORCEUI_FOREGROUND = $00000008;
{$EXTERNALSYM PUAF_CHECK_TIFS}
   PUAF_CHECK_TIFS = $00000010;

// This is the wrapper function that most clients will use.
// It figures out the current Policy for the passed in Action,
// and puts up UI if the current Policy indicates that the user
// should be queried. It returns back the Policy which the caller
// will use to determine if the action should be allowed
// This is the wrapper function to conveniently read a custom policy.

// SetZoneMapping
//    lpszPattern: string denoting a URL pattern
//        Examples of valid patterns:
//            *://*.msn.com
//            http://*.sony.co.jp
//            *://et.msn.com
//            ftp://157.54.23.41/
//            https://localsvr
//            file:\localsvr\share
//            *://157.54.100-200.*
//        Examples of invalid patterns:
//            http://*.lcs.mit.edu
//            ftp://*
//    dwFlags: SZM_FLAGS values

{$EXTERNALSYM SZM_CREATE}
   SZM_CREATE = $00000000;
{$EXTERNALSYM SZM_DELETE}
   SZM_DELETE = $00000001;

type
{$EXTERNALSYM IInternetSecurityManager}
   IInternetSecurityManager = interface
      ['{79eac9ee-baf9-11ce-8c82-00aa004ba90b}']
      function SetSecuritySite(Site: IInternetSecurityMgrSite): HResult; stdcall;
      function GetSecuritySite(out Site: IInternetSecurityMgrSite): HResult; stdcall;
      function MapUrlToZone(pwszUrl: LPCWSTR; out dwZone: DWORD;
         dwFlags: DWORD): HResult; stdcall;
      function GetSecurityId(pwszUrl: LPCWSTR; pbSecurityId: Pointer;
         var cbSecurityId: DWORD; dwReserved: DWORD): HResult; stdcall;
      function ProcessUrlAction(pwszUrl: LPCWSTR; dwAction: DWORD;
         pPolicy: Pointer; cbPolicy: DWORD; pContext: Pointer; cbContext: DWORD;
         dwFlags, dwReserved: DWORD): HResult; stdcall;
      function QueryCustomPolicy(pwszUrl: LPCWSTR; const guidKey: TGUID;
         out pPolicy: Pointer; out cbPolicy: DWORD; pContext: Pointer; cbContext: DWORD;
         dwReserved: DWORD): HResult; stdcall;
      function SetZoneMapping(dwZone: DWORD; lpszPattern: LPCWSTR;
         dwFlags: DWORD): HResult; stdcall;
      function GetZoneMappings(dwZone: DWORD; out enumString: IEnumString;
         dwFlags: DWORD): HResult; stdcall;
   end;

{$EXTERNALSYM IInternetHostSecurityManager}
   IInternetHostSecurityManager = interface
      ['{3af280b6-cb3f-11d0-891e-00c04fb6bfc4}']
      function GetSecurityId(pbSecurityId: Pointer; var cbSecurityId: DWORD;
         dwReserved: DWORD): HResult; stdcall;
      function ProcessUrlAction(dwAction: DWORD; pPolicy: Pointer; cbPolicy: DWORD;
         pContext: Pointer; cbContext, dwFlags, dwReserved: DWORD): HResult; stdcall;
      function QueryCustomPolicy(const guidKey: TGUID; out pPolicy: Pointer; out cbPolicy: DWORD;
         pContext: Pointer; cbContext, dwReserved: DWORD): HResult; stdcall;
   end;

type
   PZoneAttributes = ^TZoneAttributes;
{$EXTERNALSYM _ZONEATTRIBUTES}
   _ZONEATTRIBUTES = packed record
      cbSize: ULONG;
      szDisplayName: array[0..260 - 1] of WideChar;
      szDescription: array[0..200 - 1] of WideChar;
      szIconPath: array[0..260 - 1] of WideChar;
      dwTemplateMinLevel: DWORD;
      dwTemplateRecommended: DWORD;
      dwTemplateCurrentLevel: DWORD;
      dwFlags: DWORD;
   end;
   TZoneAttributes = _ZONEATTRIBUTES;
{$EXTERNALSYM ZONEATTRIBUTES}
   ZONEATTRIBUTES = _ZONEATTRIBUTES;

// Gets the zone attributes (information in registry other than actual security
// policies associated with the zone).  Zone attributes are fixed as:
// Sets the zone attributes (information in registry other than actual security
// policies associated with the zone).  Zone attributes as above.
// Returns S_OK or ??? if failed to write the zone attributes.
{  Registry Flags

    When reading, default behavior is:
        If HKLM allows override and HKCU value exists
            Then use HKCU value
            Else use HKLM value
    When writing, default behavior is same as HKCU
        If HKLM allows override
           Then Write to HKCU
           Else Fail
}

const
{$EXTERNALSYM URLZONEREG_DEFAULT}
   URLZONEREG_DEFAULT = 0;
{$EXTERNALSYM URLZONEREG_HKLM}
   URLZONEREG_HKLM = URLZONEREG_DEFAULT + 1;
{$EXTERNALSYM URLZONEREG_HKCU}
   URLZONEREG_HKCU = URLZONEREG_HKLM + 1;

// Gets a named custom policy associated with a zone;
// e.g. the Java VM settings can be defined with a unique key such as 'Java'.
// Custom policy support is intended to allow extensibility from the predefined
// set of policies that IE4 has built in.
//
// pwszKey is the string name designating the custom policy.  Components are
//   responsible for having unique names.
// ppPolicy is the callee allocated buffer for the policy byte blob; caller is
//   responsible for freeing this buffer eventually.
// pcbPolicy is the size of the byte blob returned.
// dwRegFlags determines how registry is accessed (see above).
// Returns S_OK if key is found and buffer allocated; ??? if key is not found (no buffer alloced).
// Sets a named custom policy associated with a zone;
// e.g. the Java VM settings can be defined with a unique key such as 'Java'.
// Custom policy support is intended to allow extensibility from the predefined
// set of policies that IE4 has built in.
//
// pwszKey is the string name designating the custom policy.  Components are
//   responsible for having unique names.
// ppPolicy is the caller allocated buffer for the policy byte blob.
// pcbPolicy is the size of the byte blob to be set.
// dwRegFlags determines if HTCU or HKLM is set.
// Returns S_OK or ??? if failed to write the zone custom policy.
// Gets action policy associated with a zone, the builtin, fixed-length policies info.

// dwAction is the action code for the action as defined above.
// pPolicy is the caller allocated buffer for the policy data.
// cbPolicy is the size of the caller allocated buffer.
// dwRegFlags determines how registry is accessed (see above).
// Returns S_OK if action is valid; ??? if action is not valid.

type
{$EXTERNALSYM IInternetZoneManager}
   IInternetZoneManager = interface
      ['{79eac9ef-baf9-11ce-8c82-00aa004ba90b}']

    // Gets the zone attributes (information in registry other than actual security
    // policies associated with the zone).  Zone attributes are fixed as:
      function GetZoneAttributes(dwZone: DWORD;
         var ZoneAttributes: TZoneAttributes): HResult; stdcall;

    // Sets the zone attributes (information in registry other than actual security
    // policies associated with the zone).  Zone attributes as above.
    // Returns S_OK or ??? if failed to write the zone attributes.
      function SetZoneAttributes(dwZone: DWORD;
         const ZoneAttributes: TZoneAttributes): HResult; stdcall;
      function GetZoneCustomPolicy(dwZone: DWORD; const guidKey: TGUID; out pPolicy: Pointer;
         out cbPolicy: DWORD; urlZoneReg: TUrlZoneReg): HResult; stdcall;
      function SetZoneCustomPolicy(dwZone: DWORD; const guidKey: TGUID; pPolicy: Pointer;
         cbPolicy: DWORD; urlZoneReg: TUrlZoneReg): HResult; stdcall;
      function GetZoneActionPolicy(dwZone, dwAction: DWORD; pPolicy: Pointer;
         cbPolicy: DWORD; urlZoneReg: TUrlZoneReg): HResult; stdcall;
      function SetZoneActionPolicy(dwZone, dwAction: DWORD; pPolicy: Pointer;
         cbPolicy: DWORD; urlZoneReg: TUrlZoneReg): HResult; stdcall;
      function PromptAction(dwAction: DWORD; hwndParent: HWnd; pwszUrl, pwszText: LPCWSTR;
         dwPromptFlags: DWORD): HResult; stdcall;
      function LogAction(dwAction: DWORD; pwszUrl, pwszText: LPCWSTR;
         dwLogFlags: DWORD): HResult; stdcall;
      function CreateZoneEnumerator(out dwEnum, dwCount: DWORD;
         dwFlags: DWORD): HResult; stdcall;
      function GetZoneAt(dwEnum, dwIndex: DWORD; out dwZone: DWORD): HResult; stdcall;
      function DestroyZoneEnumerator(dwEnum: DWORD): HResult; stdcall;
      function CopyTemplatePoliciesToZone(dwTemplate, dwZone, dwReserved: DWORD): HResult; stdcall;
   end;

// Creates the security manager object. The first argument is the Service provider
// to allow for delegation
{$EXTERNALSYM CoInternetCreateSecurityManager}
function CoInternetCreateSecurityManager(SP: IServiceProvider; var SM: IInternetSecurityManager;
   dwReserved: DWORD): HResult; stdcall;
{$EXTERNALSYM CoInternetCreateZoneManager}
function CoInternetCreateZoneManager(SP: IServiceProvider; var ZM: IInternetZoneManager;
   dwReserved: DWORD): HResult; stdcall;

{$ENDIF}

var
   ShellModule: THandle;
   ComCtlModule: THandle;
   HHCtrlModule: THandle;

function SHLockShared(Handle: THandle; DW: DWORD): Pointer; stdcall;
function SHUnlockShared(Pnt: Pointer): BOOL; stdcall;
function SHFreeShared(Handle: THandle; DW: DWORD): Pointer; stdcall;
function _Free(Pidl: PItemIDList): BOOL; stdcall;
function HtmlHelp(hwndCaller: HWND; pszFile: PChar; uCommand: Integer;
   dwData: DWORD): HWND; stdcall;

implementation

const
   urldll = 'url.dll';

function InetIsOffline; external urldll name 'InetIsOffline';

function MIMEAssociationDialogW; external urldll name 'MIMEAssociationDialogW';
function MIMEAssociationDialogA; external urldll name 'MIMEAssociationDialogA';
{$IFDEF UNICODE}
function MIMEAssociationDialog; external urldll name 'MIMEAssociationDialogW';
{$ELSE}
function MIMEAssociationDialog; external urldll name 'MIMEAssociationDialogA';
{$ENDIF}

function URLAssociationDialogW; external urldll name 'URLAssociationDialogW';
function URLAssociationDialogA; external urldll name 'URLAssociationDialogA';
{$IFDEF UNICODE}
function URLAssociationDialog; external urldll name 'URLAssociationDialogW';
{$ELSE}
function URLAssociationDialog; external urldll name 'URLAssociationDialogA';
{$ENDIF}

function TranslateURLA; external urldll name 'TranslateURLA';
function TranslateURLW; external urldll name 'TranslateURLW';
{$IFDEF UNICODE}
function TranslateURL; external urldll name 'TranslateURLW';
{$ELSE}
function TranslateURL; external urldll name 'TranslateURLA';
{$ENDIF}

{$IFDEF VER120}
const
   UrlMonLib = 'URLMON.DLL';
function CoInternetGetSession; external UrlMonLib name 'CoInternetGetSession';
function CoInternetCreateSecurityManager; external UrlMonLib name 'CoInternetCreateSecurityManager';
function CoInternetCreateZoneManager; external UrlMonLib name 'CoInternetCreateZoneManager';
{$ENDIF}

const
   Shell32 = 'shell32.dll';
   comctl32 = 'comctl32.dll';
   hhctrl = 'hhctrl.ocx';
   SHLockShared_Index = 521;
   SHUnlockShared_Index = 522;
   SHFreeShared_Index = 523;
   Free_Index = 73;

function GetShellModule: THandle;
begin
   if ShellModule = 0 then
      begin
         ShellModule := {$IFDEF VER120}LoadLibrary(Shell32){$ELSE}SafeLoadLibrary(Shell32){$ENDIF};
         if ShellModule <= HINSTANCE_ERROR then
            ShellModule := 0;
      end;
   Result := ShellModule;
end;

function GetHHctrlModule: THandle;
begin
   if HHCtrlModule = 0 then
      begin
         HHCtrlModule := {$IFDEF VER120}LoadLibrary(HHCtrl){$ELSE}SafeLoadLibrary(HHCtrl){$ENDIF};
         if HHCtrlModule <= HINSTANCE_ERROR then
            HHCtrlModule := 0;
      end;
   Result := HHCtrlModule;
end;

function GetComctlModule: THandle;
begin
   if ComctlModule = 0 then
      begin
         ComctlModule := {$IFDEF VER120}LoadLibrary(comctl32){$ELSE}SafeLoadLibrary(comctl32){$ENDIF};
         if ComctlModule <= HINSTANCE_ERROR then
            ComctlModule := 0;
      end;
   Result := ComctlModule;
end;

function HtmlHelp(hwndCaller: HWND; pszFile: PChar; uCommand: Integer;
   dwData: DWORD): HWND; stdcall;
type
   TheFunctionType = function(hwndCaller: HWND; pszFile: PChar; uCommand: Integer;
      dwData: DWORD): HWND; stdcall;
var
   TheFunction: TheFunctionType;
begin
   Result := 0;
   if HHCtrlModule = 0 then
      HHCtrlModule := GetHHCtrlModule;
   if HHCtrlModule <> 0 then
      begin
         TheFunction := GetProcAddress(HHCtrlModule, PChar('HtlmHelpA'));
         if (Assigned(TheFunction)) then
            Result := TheFunction(hwndCaller, pszFile, uCommand, dwdata);
      end;
end;

function _Free(Pidl: PItemIDList): BOOL; stdcall;
type
   TheFunctionType = function(Pidl: PItemIDList): BOOL; stdcall;
var
   TheFunction: TheFunctionType;
begin
   Result := False;
   if ComctlModule = 0 then
      ComctlModule := GetComctlModule;
   if ComctlModule <> 0 then
      begin
         TheFunction := GetProcAddress(ComctlModule, PChar(Free_Index));
         if (Assigned(TheFunction)) then
            Result := TheFunction(Pidl);
      end;
end;

function SHLockShared(Handle: THandle; DW: DWORD): Pointer; stdcall;
type
   TheFunctionType = function(Handle: THandle; DW: DWORD): Pointer; stdcall;
var
   TheFunction: TheFunctionType;
begin
   Result := nil;
   if ShellModule = 0 then
      ShellModule := GetShellModule;
   if ShellModule <> 0 then
      begin
         TheFunction := GetProcAddress(ShellModule, PChar(SHLockShared_Index));
         if (Assigned(TheFunction)) then
            Result := TheFunction(Handle, DW);
      end;
end;

function SHUnLockShared(pnt: Pointer): BOOL; stdcall;
type
   TheFunctionType = function(pnt: Pointer): BOOL; stdcall;
var
   TheFunction: TheFunctionType;
begin
   Result := FALSE;
   if ShellModule = 0 then
      ShellModule := GetShellModule;
   if ShellModule <> 0 then
      begin
         TheFunction := GetProcAddress(ShellModule, PChar(SHUnLockShared_Index));
         if (Assigned(TheFunction)) then
            Result := TheFunction(pnt);
      end;
end;

function SHFreeShared(Handle: THandle; DW: DWORD): Pointer; stdcall;
type
   TheFunctionType = function(Handle: THandle; DW: DWORD): Pointer; stdcall;
var
   TheFunction: TheFunctionType;
begin
   Result := nil;
   if ShellModule = 0 then
      ShellModule := GetShellModule;
   if ShellModule <> 0 then
      begin
         TheFunction := GetProcAddress(ShellModule, PChar(SHFreeShared_Index));
         if (Assigned(TheFunction)) then
            Result := TheFunction(Handle, DW);
      end;
end;
{IDataObject
IDispatch
IHlinkFrame
IOleCommandTarget
IOleControl
IOleObject
IOleWindow
IPersist
IPersistStreamInit
IProvideClassInfo
IProvideClassInfo2
IServiceProvider
ITargetFrame
ITargetFrame2
ITargetNotify
IUnknown
IViewObject2
IWebBrowser
IWebBrowser2
IWebBrowserPriv
IHlinkFrame
IHTMLWindow2
IProfferService
IShellBrowser
ITargetFrame
ITargetFrame2}
 
initialization

finalization
   if ShellModule <> 0 then
      FreeLibrary(ShellModule);
   if ComctlModule <> 0 then
      FreeLibrary(ComctlModule);
   if HHCtrlModule <> 0 then
      FreeLibrary(HHCtrlModule);

end.

