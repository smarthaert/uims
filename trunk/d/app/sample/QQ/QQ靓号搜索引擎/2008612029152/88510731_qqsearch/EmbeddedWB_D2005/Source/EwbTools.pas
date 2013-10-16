//***********************************************************
//                           EwbTools                       *
//                                                          *
//                    For Delphi 5 to 2006                  *
//                     Freeware Component                   *
//                            by                            *
//                      bsalsa & Smot                       *
//                  per.lindsoe@larsen.dk                   *
//                                                          *
//  Documentation and updated versions:                     *
//               http://www.bsalsa.com                      *
//***********************************************************

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
   4. You may consider donation in our web site!
{*******************************************************************************}

unit EWBTools;

interface

{$I EWB.inc}

uses
   EWBAcc, Windows, Classes, ExtCtrls, ShlObj, Graphics, ActiveX,
   Mshtml_Ewb, SHDocVw_EWB, URLMon, EmbeddedWB;

var
   PrintingWithOptions: Boolean;

//Document and Frame
function DocumentLoaded(Document: IDispatch): Boolean;
procedure AssignEmptyDocument(WebBrowser: TEmbeddedWB);
function GetDocument(WebBrowser: TEmbeddedWB): IHTMLDocument2;
function AddHtmlToAboutBlank(WebBrowser: TEmbeddedWB; StringToHtml: string): Boolean;

function GetFrame(Document: IDispatch; FrameNo: Integer): IWebBrowser2;
function GetFrameFromDocument(SourceDoc: IHTMLDocument2; FrameNo: Integer): IWebBrowser2; //By Aladin
function FrameCount(Document: IDispatch): Longint;
function FrameCountFromDocument(SourceDoc: IHtmlDocument2): Integer; //By Aladin

//Document Operations
function DesignMode(Document: IDispatch): Boolean;
procedure SetFocusToDoc(WebBrowser: TEmbeddedWB; Dispatch, Document: IDispatch);
procedure Cmd_Copy(Document: IDispatch);
procedure Cmd_Paste(Document: IDispatch);
procedure Cmd_Cut(Document: IDispatch);
procedure SelectAll(Document: IDispatch);

procedure ScrollToTop(OleObject: Variant);
procedure ScrollToPosition(OleObject: Variant; X, Y: Integer);
procedure ScrollToBottom(OleObject: Variant);

procedure Zoom(Document: IDispatch; ZoomValue: Integer);
function ZoomValue(Document: IDispatch): Integer;
function ZoomRangeHigh(Document: IDispatch): Integer;
function ZoomRangeLow(Document: IDispatch): Integer;
function SetCharartersSet(WebBrowser: TEmbeddedWB; Document: IDispatch; const ACharactersSet: string): Boolean;
function GetCookie(OleObject: Variant): string;
procedure GetThumbnail(Dispatch: IDispatch; var Image: TImage);
function GetBmpFromBrowser(Document: IDispatch; Handle: THandle; Width, Height: Integer; FileName: string): Boolean;
function GetJPEGfromBrowser(Document: IDispatch; ControlInterface: IWebBrowser2; FileName: string; SourceHeight, SourceWidth, TargetHeight, TargetWidth: Integer): Boolean;

//View Document Fields/Properties/Images
procedure ViewPageFieldsToStrings(OleObject: Variant; FieldList: TStrings);
procedure ViewPageImagesToStrings(OleObject: Variant; ImagesList: TStrings);
procedure ViewPageLinksToStrings(OleObject: Variant; LinksList: TStrings);
procedure ViewPageSourceHTMLToStrings(OleObject: Variant; Document: IDispatch; HtmlList: TStrings);
procedure ViewPageSourceTextToStrings(OleObject: Variant; Document: IDispatch; TextList: TStrings);
procedure ViewPagePropertiesToStrings(OleObject: Variant; Document: IDispatch; PropertiesList: TStrings);
procedure ViewPageSourceText(OleObject: Variant; Document: IDispatch);

//Save & Load
function SaveToFile(Document: IDispatch; const Fname: string): HRESULT;
function SaveToStream(Document: IDispatch; var AStream: TStream): HRESULT;
function SaveToStrings(Document: IDispatch; AStrings: TStrings): HRESULT;
function SaveDocToStrings(Document: IDispatch; var AStrings: TStrings): HRESULT;
function SaveDocToStream(Document: IDispatch; var AStream: TStream): HRESULT;
function SaveDocToFile(Document: IDispatch; const Fname: string): HRESULT;
function SaveFrameToFile(Document: IDispatch; FrameNo: Integer; const Fname: string): HRESULT;
function SaveFrameToStream(Document: IDispatch; FrameNo: Integer; AStream: TStream): HRESULT;
function SaveFrameToStrings(Document: IDispatch; FrameNo: Integer; AStrings: TStrings): HRESULT;

function LoadFromStrings(WebBrowser: TEmbeddedWB; Document: IDispatch; const AStrings: TStrings): HRESULT;
function LoadFromStream(WebBrowser: TEmbeddedWB; Document: IDispatch; const AStream: TStream): HRESULT;
procedure LoadFromImage(WebBrowser: TEmbeddedWB; Image: TImage);
function LoadFrameFromStrings(Document: IDispatch; FrameNo: Integer; const AStrings: TStrings): HRESULT;
function LoadFrameFromStream(Document: IDispatch; FrameNo: Integer; AStream: TStream): HRESULT;

//Printing
procedure Print(ControlInterface: IWebBrowser2; bHideSetup: Boolean);
procedure PrintWithOptions(ControlInterface: IWebBrowser2; Document: IDispatch; UsePrintOptions, PrintOptionsEnabled, HideSetup: Boolean; var InvokingPageSetup: Boolean);
procedure PrintPreview(Webbrowser: IWebBrowser2);
procedure PrintPreviewExtended(ControlInterface: IWebBrowser2; nCMDShow: Integer; HideSetup: Boolean);
procedure PageSetup(Document: IDispatch; UsePrintOptions, PrintOptionsEnabled: Boolean; var InvokingPageSetup: Boolean);
procedure PrintSetup(ControlInterface: IWebBrowser2; HideSetup: Boolean);
procedure GetPrintValues(WebBrowser: TEmbeddedWB; PrintOptions: TPrintOptions; Measure: TMeasure);
function PrintMarginStr(Measure, RuntimeMeasure: TMeasure; M: Real): PChar;

//Dialogs
procedure OpenDialog(WebBrowser: TEmbeddedWB; AOwner: TComponent);
procedure SaveDialog(Document: IDispatch); overload;
function SaveDialog(WebBrowser: TEmbeddedWB; AOwner: TComponent): string; overload;
procedure ShowInternetOptions(Document: IDispatch);
procedure ShowPageProperties(Document: IDispatch);
procedure ShowOrganizeFavorites(Handle: THandle);
procedure ShowImportExportFavoritesAndCookies(Handle: THandle);
procedure ShowFindDialog(Document: IDispatch);
procedure SaveImagesDialog(OleObject: Variant; Document: IDispatch);
procedure ViewPageSourceHtml(Document: IDispatch);
procedure SavePageTextDialog(AOwner: TComponent; OleObject: Variant; Document: IDispatch);

//Open external programs
procedure OpenAddressBook;
procedure OpenEudoraMail;
procedure OpenOutlookExpressMail;
procedure OpenOutlookMail;
procedure OpenRegistryEditor;
function OpenCalendar: Boolean;
function OpenClient(Client: string): Boolean;
function OpenNetMeeting: Boolean;
function OpenNewsClient: Boolean;
procedure DoExploreFolder(Handle: THandle; Path: string);
procedure OpenIEBrowserWithAddress(Handle: THandle);

//Open specific webpages
function OpenHotmailMail(WebBrowser: TEmbeddedWB): Boolean;
function OpenYahooMail(WebBrowser: TEmbeddedWB): Boolean;
function OpenGoogleMail(WebBrowser: TEmbeddedWB): Boolean;
procedure GoSearchInGoogle(WebBrowser: TEmbeddedWB; SearchTerm: string);
procedure GoSearchInMSN(WebBrowser: TEmbeddedWB; SearchTerm: string);
procedure GoSearchInYahoo(WebBrowser: TEmbeddedWB; SearchTerm: string);

//Navigate & Download
procedure Go(WebBrowser: TEmbeddedWB; Url: string);
procedure GoWithQueryDetails(WebBrowser: TEmbeddedWB; Url, Query: string);
procedure GoNoHistory(WebBrowser: TEmbeddedWB; const URL: string);
procedure NavigatePidl(WebBrowser: TEmbeddedWB; pidl: PItemIdList);
function NavigateToFrame(WebBrowser: TEmbeddedWB; FrameList: string): IHTMLDocument2;
procedure NavigateFolder(WebBrowser: TEmbeddedWB; CSIDL: Integer);
procedure GoAboutBlank(WebBrowser: TEmbeddedWB);
procedure GoDownloadFile(WebBrowser: TEmbeddedWB; URL: string);
function DownloadFile(SourceFile, TargetFile: string): Boolean;
procedure GoDownloadMaskedFile(SourceFile, TargetFile: string; Notify: Boolean);

//Get Special Folders/URL paths etc.
function GetSpecialFolderPath(CallerHandle: THandle; CSIDL: Integer): PChar;
function GetIEHomePage: string;
function GetCachedFileFromURL(strUL: string; var strLocalFile: string): Boolean;
function GetDefaultBrowserFromRegistry: string;
function GetIPAndHostName(var HostName, IPaddr, WSAErr: string): Boolean;

//E-Mail functions
procedure SendPageInMailAsAttachment(WebBrowser: TEmbeddedWB; AOwner: TComponent; Document: IDispatch; mFileName, mSubject, mBody: string);
procedure CreateNewMail;
procedure SendUrlInMail(LocationURL, LocationName: WideString);

//Search in Document & Fill Forms
function SearchString(Webbrowser: TEmbeddedWB; const strText: string): Boolean;
function SearchText(WebBrowser: TEmbeddedWB; Document: IDispatch; const Value: string; const iPos: Integer = 1): IHTMLTxtRange;
procedure SearchAndHighlight(Document: IDispatch; const ACaption, APrompt: string; aText: string = ''; ShowInputQuery: Boolean = False);
function FillForm(OleObject: Variant; FieldName: string; Value: string): Boolean;
procedure AutoFillIEFormAndExcecute;

//Clearing
procedure ClearCache;
procedure ClearTypedUrls;

//Online Status
function CheckOnlineStatus: Boolean;
function IsGlobalOffline: Boolean;
procedure WorkOffline(WebBrowser: TEmbeddedWB);
procedure WorkOnline(WebBrowser: TEmbeddedWB);

//Restricted & Trusted Lists
function CheckIfInRestricredList(const URL: string): Boolean;
function CheckIfInTrustedList(const URL: string): Boolean;
procedure AddToTrustedSiteList(WebBrowser: TEmbeddedWB; const URL: string);
procedure AddToRestrictedSiteList(WebBrowser: TEmbeddedWB; const URL: string);

//Zone Icon, Security Zone, SSL Status
procedure GetZoneIcon(IconPath: string; var Icon: TIcon);
function GetZoneIconToForm(LocationURL: string; Caption, Hint: string): Boolean;
function GetZoneAttributes(const URL: string): TZoneAttributes;
function GetSSLStatus(OleObject: Variant; LocationURL: string; var SSLName, SSLDescription: string): Boolean;
function GetUrlSecurityZone(LocationURL: string; var ZoneName, ZoneDescription: string; var Icon: TIcon): Boolean;

//Proxy & User agent
procedure SetProxy(UserAgent, ProxyServer: string);
//procedure SetProxy(Server: string)overload;
procedure SetUserAgent(var UserAgent: string);
procedure RemoveUserAgent(UserAgent: string);

//MIME Filter & NameSpace
function RegisterMIMEFilter(clsid: TGUID; MIME: PWideChar): HRESULT;
function UnregisterMIMEFilter(MIME: PWideChar): HRESULT;
function RegisterNameSpace(clsid: TGUID): HRESULT;
function UnregisterNameSpace: HRESULT;

//Cookies
function GetCookiesPath: string;

//Favorites
function OrganizeFavorite(h: THandle; Path: PChar): Boolean; stdcall external 'shdocvw.dll' Name 'DoOrganizeFavDlg';
function URLFromFavorites(const dotURL: string): string;
function GetFavoritesPath: string;
procedure AddToFavorites(URL, Title: string);
procedure OpenOtherWBFavorites(WebBrowser: TEmbeddedWB);

//History
function GetHistoryPath: string;
function UrlFromHistory(ShellFolder: IShellFolder; pidl: PItemIDList): string;
procedure ClearHistory;

//Pages
procedure SetNewHomePage(HomePage: string);
function GetLastVisitedPage(var LastVisitedPage: string): Boolean;
function SaveLastVisitedPage(WebBrowser: TEmbeddedWB; LocationURL: string): Boolean;

//Code accessories
procedure Wait(WebBrowser: TEmbeddedWB);
procedure InvokeCMD(Document: IDispatch; InvokeIE: Boolean; Value1, Value2: Integer; var vaIn, vaOut: OleVariant);
function GetIEHandle(WebBrowser: TEmbeddedWB; ClassName: string): HWND;

//Miscellaneous
procedure RestoreApplicationFormSize(WebBrowser: TEmbeddedWB);
procedure SaveApplicationFormSize(WebBrowser: TEmbeddedWB);
procedure ShowIEVersionInfo(Handle: THandle);
procedure CreateDesktopShortcut(Handle: THandle);
procedure DisableNavSound(bDisable: Boolean);


//----- add to ewb-------------------------------------------------------
function ConcatPIDLs(IDList1, IDList2: PItemIDList): PItemIDList;
function CopyITEMID(Malloc: IMalloc; ID: PItemIDList): PItemIDList;
function CopyPIDL(IDList: PItemIDList): PItemIDList;
function CreatePIDL(Size: Integer): PItemIDList;
function DeleteUrl(Url: PWideChar): HResult;
function Encode(const S: string): string;
function ExtractUrl(ShellFolder: IShellFolder; pidl: PItemIDList): string;
function GetDisplayName(Folder: IShellFolder; pidl: PItemIDList): string;
function GetFileName(Folder: IShellFolder; pidl: PItemIDList): string;
function GetIEVersion: string;
function GetImageIndex(pidl: PItemIDList): integer;
function GetMailClients: TStrings;
function GetPIDLSize(IDList: PItemIDList): Integer;
function IE5_Installed: Boolean;
function IsChannel(ChannelShortcut: string; ShellFolder: IShellFolder; ID: PItemIDList): Boolean;
function IsFolder(ShellFolder: IShellFolder; ID: PItemIDList): Boolean;
function IsFolderEx(ChannelShortcut: string; ShellFolder: IShellFolder; ID: PItemIDList): Boolean;
function NextPIDL(IDList: PItemIDList): PItemIDList;
function ResolveChannel(pFolder: IShellFolder; pidl: PItemIDList; var lpszURL: string): HRESULT;
function ResolveLink(const path: string): string;
function ResolveUrlIni(Filename: string): string;
function ResolveUrlIntShCut(Filename: string): string;
function StringToVarArray(const S: string): Variant;
function URLFromShortcut(const dotURL: string): string;
function VarArrayToString(const V: Variant): string;
procedure DisposePIDL(ID: PItemIDList);
procedure StripLastID(IDList: PItemIDList);
function IsWinXPSP2OrLater(): Boolean;
function EncodeUrl(const InputStr: string; const bQueryStr: Boolean): string;
function DecodeUrl(const InputStr: string): string;
function IsValidProtocol(const URL: string): Boolean;
//--end of add to ewb---------------------------------

implementation

uses
   Registry, ShellAPI, Controls, Dialogs, Messages, Forms, SysUtils,
   OleCtrls, WinInet, SendMail_For_Ewb, ComObj, IEConst, IniFiles, JPEG, WinSock
   {$IFDEF DELPHI_6_UP}, Variants{$ENDIF}, Browse4Folder;

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
   VER_MINORVERSION      = $0000001;
   VER_MAJORVERSION      = $0000002;
   VER_SERVICEPACKMINOR  = $0000010;
   VER_SERVICEPACKMAJOR  = $0000020;

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
  if (hLib <> 0) then begin
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

function EncodeURL(const InputStr: string; const bQueryStr: Boolean): string;
var
  Idx: Integer;
begin
  Result := '';
  for Idx := 1 to Length(InputStr) do
  begin
    case InputStr[Idx] of
      'A'..'Z', 'a'..'z', '0'..'9', '-', '_', '.':
        Result := Result + InputStr[Idx];
      ' ':
        if bQueryStr then
          Result := Result + '+'
        else
          Result := Result + '%20';
      else
        Result := Result + '%' + SysUtils.IntToHex(Ord(InputStr[Idx]), 2);
    end;
  end;
end;

function DecodeUrl(const InputStr: string): string;
var
  Idx: Integer;
  Hex: string;
  Code: Integer;
begin
  Result := '';
  Idx := 1;
  while Idx <= Length(InputStr) do
  begin
    case InputStr[Idx] of
      '%':
      begin
        if Idx <= Length(InputStr) - 2 then
        begin
          Hex := InputStr[Idx+1] + InputStr[Idx+2];
          Code := SysUtils.StrToIntDef('$' + Hex, -1);
          Inc(Idx, 2);
        end
        else
          Code := -1;
        if Code = -1 then
          raise SysUtils.EConvertError.Create('Invalid hex digit in URL');
        Result := Result + Chr(Code);
      end;
      '+':
        Result := Result + ' '
      else
        Result := Result + InputStr[Idx];
    end;
    Inc(Idx);
  end;
end;

function IsValidProtocol(const URL: string): Boolean;
const
  Protocols: array[1..11] of string = ('ftp://', 'http://', 'https://',
     'gopher://', 'mailto:', 'news:', 'nntp://',  'telnet://', 'wais://',
     'file://', 'prospero://');
var
  I: Integer;
begin
  Result := False;
  for I := 1 to 11 do
    if Pos(Protocols[I], SysUtils.LowerCase(URL)) <> 0 then
    begin
      Result := True;
      Break;
    end;
end;

function DocumentLoaded(Document: IDispatch): Boolean;
var
   iDoc: IHtmlDocument2;
begin
   Result := False;
   if Assigned(Document) then
      begin
         Document.QueryInterface(IHtmlDocument2, iDoc);
         Result := Assigned(iDoc);
      end;
end;

procedure AssignEmptyDocument(WebBrowser: TEmbeddedWB);
begin
   WebBrowser.Go('about:blank'); 
end;

function GetDocument(WebBrowser: TEmbeddedWB): IHtmlDocument2;
begin
   Result := WebBrowser.Document as IHtmlDocument2;
   if Result = nil then
      raise Exception.Create('Unable to load the document');
end;

function AddHtmlToAboutBlank(WebBrowser: TEmbeddedWB; StringToHtml: string): Boolean;
var
   Flags, TargetFrameName, PostData, Headers: OleVariant;
begin
   WebBrowser.Navigate('about:' + StringToHtml, Flags, TargetFrameName, PostData, Headers);
   Result := True;
end;

function GetFrame(Document: IDispatch; FrameNo: Integer): IWebBrowser2;
var
   OleContainer: IOleContainer;
   enum: ActiveX.IEnumUnknown;
   unk: IUnknown;
   Fetched: PLongint;
begin
   if DocumentLoaded(Document) then
      begin
         Fetched := nil;
         OleContainer := Document as IOleContainer;
         OleContainer.EnumObjects(OLECONTF_EMBEDDINGS, Enum);
         Enum.Skip(FrameNo);
         Enum.Next(1, Unk, Fetched);
         Result := Unk as IWebBrowser2;
      end
   else
      Result := nil;
end;

function FrameCount(Document: IDispatch): LongInt;
var //fix by Aladin
   OleContainer: IOleContainer;
   enum: ActiveX.IEnumUnknown;
   FetchedContrs: LongInt;
   Unknown: IUnknown;
   IWeb: IWebBrowser2;
begin
   Result := 0; //bsalsa
   if not DocumentLoaded(Document) then
      Exit;
   OleContainer := Document as IOleContainer;
   if OleContainer.EnumObjects(OLECONTF_EMBEDDINGS, Enum) = S_OK then
      begin
         while Enum.Next(1, Unknown, @FetchedContrs) = S_OK do
            begin
               if Unknown.QueryInterface(IID_IWebBrowser2, IWeb) = S_OK then //check if it is frame
                  Inc(Result);
            end;
      end;
end;

function FrameCountFromDocument(SourceDoc: IHtmlDocument2): Integer;
var //by Aladin
   OleContainer: IOleContainer;
   enum: ActiveX.IEnumUnknown;
   unk: array[0..99] of IUnknown; // CHANGED from "unk: IUnknown;"
   EnumResult: HRESULT;
begin
   Result := 0;
   if not DocumentLoaded(SourceDoc) then
      Exit;
   OleContainer := SourceDoc as IOleContainer;
   EnumResult := OleContainer.EnumObjects(OLECONTF_EMBEDDINGS, Enum);
   if EnumResult = S_OK then
      begin // Added per OLE help
         Enum.Next(100, Unk, @Result)
      end
   else
      begin // Added per OLE help
         Enum := nil;
      end;
end;

function DesignMode(Document: IDispatch): Boolean;
// by smot
var
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
            end
         else
            begin
               HTMLDocument2.designMode := 'On';
               Result := True;
            end;
      end;
end;

procedure SetFocusToDoc(WebBrowser: TEmbeddedWB; Dispatch, Document: IDispatch);
begin
   if DocumentLoaded(Document) then
      with (Dispatch as IOleObject) do
         DoVerb(OLEIVERB_UIACTIVATE, nil, WebBrowser, 0, WebBrowser.Handle, WebBrowser.ClientRect);
end;

procedure CMD_Copy(Document: IDispatch);
var
   vaIn, vaOut: OleVariant;
begin
   InvokeCmd(Document, False, OLECMDID_COPY, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
end;

procedure CMD_Paste(Document: IDispatch);
var
   vaIn, vaOut: OleVariant;
begin
   InvokeCmd(Document, False, OLECMDID_PASTE, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
end;

procedure CMD_Cut(Document: IDispatch);
var
   vaIn, vaOut: OleVariant;
begin
   InvokeCmd(Document, False, OLECMDID_CUT, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
end;

procedure SelectAll(Document: IDispatch);
var
   vaIn, vaOut: OleVariant;
begin
   InvokeCmd(Document, False, OLECMDID_SELECTALL, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
end;

procedure ScrollToTop(OleObject: Variant);
begin
   try
      if DocumentLoaded(OleObject.Document) then
         OleObject.Document.ParentWindow.ScrollTo(0, 0);
   except
   end;
end;

procedure ScrollToPosition(OleObject: Variant; X, Y: Integer);
begin
   try
      if DocumentLoaded(OleObject.Document) then
         OleObject.Document.ParentWindow.ScrollTo(X, Y);
   except
   end;
end;

procedure ScrollToBottom(OleObject: Variant);
begin
   try
      if DocumentLoaded(OleObject.Document) then
         OleObject.Document.ParentWindow.ScrollTo(0, MaxInt);
   except
   end;
end;

procedure Zoom(Document: IDispatch; ZoomValue: Integer);
var
   vaIn, vaOut: OleVariant;
begin
   if ZoomValue < ZoomRangeLow(Document) then
      vaIn := ZoomRangeLow(Document)
   else
      if ZoomValue > ZoomRangeHigh(Document) then
         vaIn := ZoomRangeHigh(Document)
      else
         vaIn := ZoomValue;
   InvokeCmd(Document, False, OLECMDID_ZOOM, OLECMDEXECOPT_DONTPROMPTUSER, vaIn, vaOut);
end;

function ZoomValue(Document: IDispatch): Integer;
var
   vaIn, vaOut: OleVariant;
begin
   vaIn := null;
   InvokeCmd(Document, False, OLECMDID_ZOOM, OLECMDEXECOPT_DONTPROMPTUSER, vaIn, vaOut);
   Result := vaOut;
end;

function ZoomRangeHigh(Document: IDispatch): Integer;
var
   vaIn, vaOut: OleVariant;
begin
   InvokeCmd(Document, False, OLECMDID_GETZOOMRANGE, OLECMDEXECOPT_DONTPROMPTUSER, vaIn, vaOut);
   Result := HiWord(DWORD(vaOut));
end;

function ZoomRangeLow(Document: IDispatch): Integer;
var
   vaIn, vaOut: OleVariant;
begin
   InvokeCmd(Document, False, OLECMDID_GETZOOMRANGE, OLECMDEXECOPT_DONTPROMPTUSER, vaIn, vaOut);
   Result := LoWord(DWORD(vaOut));
end;

function SetCharartersSet(WebBrowser: TEmbeddedWB; Document: IDispatch; const ACharactersSet: string): Boolean;
var
   RefreshLevel: OleVariant;
begin
   Wait(WebBrowser);
   Result := False;
   if DocumentLoaded(Document) then
      begin
         try
            Mshtml_Ewb.IHTMLDocument2(Document).Set_CharSet(ACharactersSet);
            Result := True;
            RefreshLevel := 7;
            WebBrowser.Refresh2(RefreshLevel);
         except
         end;
      end;
end;

function GetCookie(OleObject: Variant): string;
begin
   Result := '';
   Result := OleObject.Document.Cookie;
end;

procedure GetThumbnail(Dispatch: IDispatch; var Image: TImage);
var
   DrawRect: TRect;
begin
   if Image = nil then
      Exit;
   DrawRect := Rect(0, 0, Image.Height, Image.Width);
   Image.Picture.Bitmap.Height := Image.Height;
   Image.Picture.Bitmap.Width := Image.Width;
   (Dispatch as IViewObject).Draw(DVASPECT_DOCPRINT, 0, nil, nil, 0,
      Image.Canvas.Handle, @DrawRect, nil, nil, 0);
   Image.Refresh;
end;

function GetBmpFromBrowser(Document: IDispatch; Handle: THandle; Width, Height: Integer; FileName: string): Boolean;
var
   ViewObject: IViewObject;
   sourceDrawRect: TRect;
   ScreenImg: Graphics.TBitmap;
begin
   Result := False;
   if DocumentLoaded(Document) then
      try
         Document.QueryInterface(IViewObject, ViewObject);
         if Assigned(ViewObject) then
            try
               ScreenImg := TBitmap.Create;
               ScreenImg.Height := Height;
               ScreenImg.Width := Width;
               sourceDrawRect := Rect(0, 0, ScreenImg.Width, ScreenImg.Height);
               ViewObject.Draw(DVASPECT_CONTENT, 1, nil, nil, Handle,
                  ScreenImg.Canvas.Handle, @sourceDrawRect, nil, nil, 0);
               ScreenImg.SaveToFile(FileName);
               Result := True;
            finally
               ViewObject._Release;
            end;
      except
         Result := False;
      end;
end;

function GetJPEGfromBrowser(Document: IDispatch; ControlInterface: IWebBrowser2; FileName: string; SourceHeight, SourceWidth,
   TargetHeight, TargetWidth: Integer): Boolean;
var
   sourceDrawRect: TRect;
   targetDrawRect: TRect;
   sourceBitmap: Graphics.TBitmap;
   targetBitmap: Graphics.TBitmap;
   aJPG: TJPEGImage;
   aViewObject: IViewObject;
   IWeb: IWebBrowser2;
begin
   Result := False;
   sourceBitmap := Graphics.TBitmap.Create;
   targetBitmap := Graphics.TBitmap.Create;
   aJPG := TJPEGImage.Create;
   IWeb := ControlInterface;
   try
      try
         sourceDrawRect := Rect(0, 0, SourceWidth, SourceHeight);
         sourceBitmap.Width := SourceWidth;
         sourceBitmap.Height := SourceHeight;
         aViewObject := IWeb as IViewObject;
         if aViewObject = nil then
            Exit;
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
         Result := True;
      finally
         aJPG.Free;
         sourceBitmap.Free;
         targetBitmap.Free;
      end;
   except
      Result := False;
   end;
end;

procedure ViewPageLinksToStrings(OleObject: Variant; LinksList: TStrings);
var //by smot
   UNum: Variant;
   s: string;

   procedure RecurseLinks(htmlDoc: Variant);
   var
      BodyElement, ElementCo, HTMLFrames, HTMLWnd, doc: OleVariant;
      j, i: Integer;
   begin
      if VarIsEmpty(htmlDoc) then
         Exit;
      BodyElement := htmlDoc.body;
      if BodyElement.tagName = 'BODY' then
         begin
            ElementCo := htmlDoc.links;
            j := ElementCo.Length - 1;
            for i := 0 to j do
               begin
                  UNum := ElementCo.item(i);
                  s := UNum.href;
                  if j = 0 then
                     s := 'No Links found in the page body';
                  LinksList.Add(s);
               end;
         end;
      HTMLFrames := htmlDoc.Frames;
      j := HTMLFrames.Length - 1;
      for i := 0 to j do
         begin
            HTMLWnd := HTMLFrames.Item(i);
            try
               doc := HTMLWnd.Document;
               RecurseLinks(doc);
            except
               Continue;
            end;
         end;
   end;
begin
   LinksList.Clear;
   if not DocumentLoaded(OleObject.Document) then
      Exit;
   RecurseLinks(OleObject.Document);
end;

procedure ViewPageFieldsToStrings(OleObject: Variant; FieldList: TStrings);
var //by smot
   i, j: Integer;
   FormItem: Variant;
begin
   if not DocumentLoaded(OleObject.Document) then
      Exit;
   FieldList.Clear;
   for I := 0 to OleObject.Document.Forms.Length - 1 do
      begin
         FormItem := OleObject.Document.Forms.Item(I);
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

procedure ViewPageImagesToStrings(OleObject: Variant; ImagesList: TStrings);
var //by smot
   i, Num: Integer;
   sImageURL: string;
   strLocalFile: string;
begin
   if not DocumentLoaded(OleObject.Document) then
      Exit;
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
   if i = 0 then
      ImagesList.Add('No images found.');
end;

procedure ViewPageSourceHTMLToStrings(OleObject: Variant; Document: IDispatch; HtmlList: TStrings);
begin
   HtmlList.Clear;
   if DocumentLoaded(Document) then
      HtmlList.Add(VarToStr(OleObject.Document.documentElement.innerHTML));
end;

procedure ViewPageSourceTextToStrings(OleObject: Variant; Document: IDispatch; TextList: TStrings);
begin
   TextList.Clear;
   if DocumentLoaded(Document) then
      TextList.Add(VarToStr(OleObject.Document.documentElement.innerText));
end;

procedure ViewPagePropertiesToStrings(OleObject: Variant; Document: IDispatch; PropertiesList: TStrings);
begin
   PropertiesList.Clear;
   if DocumentLoaded(Document) then
      begin
         try
            with PropertiesList do
               begin
                  Add('Current Url: ' + OleObject.Document.Url);
                  Add('Current Title: ' + OleObject.Document.Title);
                  Add('Scroll Height: ' + IntToStr(OleObject.Document.Body.ScrollHeight));
                  Add('Scroll Width: ' + IntToStr(OleObject.Document.Body.ScrollWidth));
                  Add('Scroll Top: ' + IntToStr(OleObject.Document.Body.ScrollTop));
                  Add('Scroll Left: ' + IntToStr(OleObject.Document.Body.ScrollLeft));
                  Add('Client Height: ' + IntToStr(OleObject.Document.Body.ClientHeight));
                  Add('Client Width: ' + IntToStr(OleObject.Document.Body.ClientWidth));
                  Add('Referrer: ' + OleObject.Document.Referrer);
                  Add('Cookie: ' + OleObject.Document.Cookie);
                  Add('Last Modified: ' + OleObject.Document.LastModified);
                  Add('Protocol: ' + OleObject.Document.Location.Protocol);
                  Add('Default Charset: ' + OleObject.Document.DefaultCharset);
                  Add('Unique ID: ' + OleObject.Document.UniqueID);
                  Add('File Size: ' + OleObject.Document.FileSize);
                  Add('File Created Date: ' + OleObject.Document.FileCreatedDate);
               end;
         except
            PropertiesList.Add('It looks like there are errors on the page HTML code!');
         end;
      end;
end;

procedure ViewPageSourceText(OleObject: Variant; Document: IDispatch);
var
   TextLst: TStringList;
begin
   TextLst := TStringList.Create;
   try
      if DocumentLoaded(Document) then
         begin
            TextLst.Add(VarToStr(OleObject.Document.documentElement.innerText));
            MessageDlg(TextLst.Text, mtCustom, [mbOK], 0);
         end;
   finally
      TextLst.Free;
   end;
end;

function SaveToFile(Document: IDispatch; const Fname: string): HRESULT;
begin
   if DocumentLoaded(Document) then
      begin
         Result := SaveDocToFile(Document, FName);
      end
   else
      Result := S_FALSE;
end;

function SaveToStream(Document: IDispatch; var AStream: TStream): HRESULT;
begin
   if DocumentLoaded(Document) then
      Result := SaveDocToStream(Document, AStream)
   else
      Result := S_FALSE;
end;

function SaveToStrings(Document: IDispatch; AStrings: TStrings): HRESULT;
begin
   if DocumentLoaded(Document) then
      Result := SaveDocToStrings(Document, AStrings)
   else
      Result := S_FALSE;
end;

function SaveDocToStrings(Document: IDispatch; var AStrings: TStrings): HResult;
var
   IpStream: IPersistStreamInit;
   AStream: TMemoryStream;
begin
   Result := S_FALSE;
   if not DocumentLoaded(Document) then
      Exit;
   AStream := TMemoryStream.Create;
   try
      IpStream := Document as IPersistStreamInit;
      if not Assigned(IpStream) then
         Result := S_FALSE
      else
         if Succeeded(IpStream.save(TStreamadapter.Create(AStream), True))
            then
            begin
               AStream.Seek(0, 0);
               AStrings.LoadFromStream(AStream);
               Result := S_OK;
            end;
   except
   end;
   AStream.Free;
end;

function SaveDocToStream(Document: IDispatch; var AStream: TStream): HResult;
var
   IpStream: IPersistStreamInit;
begin
   if DocumentLoaded(Document) then
      begin
         IpStream := Document as IPersistStreamInit;
         Result := IpStream.Save(TStreamAdapter.Create(AStream), True);
      end
   else
      Result := S_FALSE;
end;

function SaveDocToFile(Document: IDispatch; const Fname: string): HResult;
var
   PFile: IPersistFile;
begin
   Result := S_FALSE;
   if DocumentLoaded(Document) then
      begin
         PFile := Document as IPersistFile;
         Result := PFile.Save(StringToOleStr(FName), False);
      end;
end;

function SaveFrameToFile(Document: IDispatch; FrameNo: Integer; const Fname: string): HRESULT;
var
   IWeb: IWebBrowser2;
   PFile: IPersistFile;
begin
   IWeb := GetFrame(Document, FrameNo);
   if (IWeb <> nil) and DocumentLoaded(IWeb.Document) then
      begin
         PFile := IWeb.Document as IPersistFile;
         Result := PFile.Save(StringToOleStr(FName), False);
      end
   else
      Result := S_FALSE;
end;

function SaveFrameToStream(Document: IDispatch; FrameNo: Integer; AStream: TStream): HRESULT;
var
   IWeb: IWebBrowser2;
begin
   Result := S_FALSE;
   IWeb := GetFrame(Document, FrameNo);
   if (IWeb <> nil) and DocumentLoaded(IWeb.Document) then
      Result := SaveDocToStream(IWeb.Document, AStream)
end;

function SaveFrameToStrings(Document: IDispatch; FrameNo: Integer; AStrings: TStrings): HRESULT;
var
   IWeb: IWebBrowser2;
begin
   Result := S_FALSE;
   IWeb := GetFrame(Document, FrameNo);
   if (IWeb <> nil) and DocumentLoaded(IWeb.Document) then
      Result := SaveDocToStrings(IWeb.Document, AStrings);
end;

function LoadFromStrings(WebBrowser: TEmbeddedWB; Document: IDispatch; const AStrings: TStrings): HResult;
var
   Ms: TMemoryStream;
begin
   Ms := TMemoryStream.Create;
   try
      try
         if not DocumentLoaded(Document) then
            AssignEmptyDocument(WebBrowser);
         AStrings.SaveToStream(Ms);
         Result := WebBrowser.LoadFromStream(Ms);
      except
         Result := S_FALSE;
      end;
   finally
      Ms.free;
   end;
end;

function LoadFromStream(WebBrowser: TEmbeddedWB; Document: IDispatch; const AStream: TStream): HRESULT;
begin
   if not DocumentLoaded(Document) then
      AssignEmptyDocument(WebBrowser);
   AStream.Seek(0, 0);
   Result := (Document as IPersistStreamInit).Load(TStreamadapter.Create(AStream));
end;

procedure LoadFromImage(WebBrowser: TEmbeddedWB; Image: TImage);
var
   Stm: TMemoryStream;
begin
   Stm := TMemoryStream.Create;
   try
      Image.Picture.Bitmap.SaveToStream(Stm);
      WebBrowser.LoadFromStream(Stm);
   finally
      Stm.Free;
   end;
end;

function LoadFrameFromStrings(Document: IDispatch; FrameNo: Integer; const AStrings: TStrings): HResult;
var
   IWeb: IWebBrowser2;
   M: TMemoryStream;
begin
   Result := S_FALSE;
   IWeb := GetFrame(Document, FrameNo);
   if (IWeb <> nil) and DocumentLoaded(IWeb.Document) then
      begin
         M := TMemoryStream.Create;
         try
            AStrings.SaveToStream(M);
            M.Seek(0, 0);
            Result := (IWeb.Document as IPersistStreamInit).Load(TStreamadapter.Create(M));
         except
            Result := S_FALSE;
         end;
         M.free;
      end;
end;

function LoadFrameFromStream(Document: IDispatch; FrameNo: Integer; AStream: TStream): HRESULT;
var
   IWeb: IWebBrowser2;
begin
   Result := S_FALSE;
   IWeb := GetFrame(Document, FrameNo);
   if (IWeb <> nil) then
      if DocumentLoaded(IWeb.Document) then
         begin
            AStream.Seek(0, 0);
            Result := (IWeb.Document as IPersistStreamInit).Load(TStreamadapter.Create(AStream));
         end;
end;

procedure Print(ControlInterface: IWebBrowser2; bHideSetup: Boolean);
var
   vaIn, vaOut: OleVariant;
begin
   if DocumentLoaded(ControlInterface.Document) then
      begin
         if bHideSetup then
            ControlInterface.ExecWB(OLECMDID_PRINT, OLECMDEXECOPT_DONTPROMPTUSER, vaIn, vaOut)
         else
            ControlInterface.ExecWB(OLECMDID_PRINT, OLECMDEXECOPT_PROMPTUSER, vaIn, vaOut)
      end;
end;

procedure PrintWithOptions(ControlInterface: IWebBrowser2; Document: IDispatch; UsePrintOptions, PrintOptionsEnabled, HideSetup: Boolean; var InvokingPageSetup: Boolean);
begin
   PrintingWithOptions := True;
   PageSetup(Document, UsePrintOptions, PrintOptionsEnabled, InvokingPagesetup);
   Print(ControlInterface, HideSetup);
end;

procedure PrintPreview(Webbrowser: IWebBrowser2);
// IE 5.5 only
var
   vaIn, vaOut: Olevariant;
begin
   if DocumentLoaded(Webbrowser.Document) then
      Webbrowser.ExecWB(OLECMDID_PRINTPREVIEW, OLECMDEXECOPT_DONTPROMPTUSER, vaIn, vaOut);
end;

function OpenClient(Client: string): Boolean;
var
   s, params, Exec: string;
begin
   Result := False;
   with TRegistry.Create do
      try
         RootKey := HKEY_LOCAL_MACHINE;
         OpenKey('Software\Clients\' + Client, False);
         S := ReadString('');
         CloseKey;
         OpenKey('Software\Clients\' + Client + '\' + S + '\shell\open\command', False);
         S := ReadString('');
         CloseKey;
         if S <> '' then
            begin
               if Pos('/', S) > 0 then
                  begin
                     Exec := system.Copy(S, 1, Pos('/', S) - 2);
                     Params := system.Copy(s, Length(exec) + 1, length(S));
                  end
               else
                  begin
                     Exec := S;
                     Params := '';
                  end;
               Result := True;
               shellExecute(Application.handle, 'open', PChar(Exec), pChar(Params), '', SW_SHOW);
            end;
      finally
         Free;
      end;
end;

procedure PrintPreviewExtended(ControlInterface: IWebBrowser2; nCMDShow: Integer; HideSetup: Boolean);
var
   Preview_HWND, App_HWND: THandle;
   ClassName: array[0..255] of Char;
   StartTime, EndTime: DWORD; //Smot
   vaIn, vaOut: OleVariant;
begin
   if not DocumentLoaded(ControlInterface.Document) then
      Exit;
   if HideSetup then
      ControlInterface.ExecWB(OLECMDID_PRINTPREVIEW, OLECMDEXECOPT_DONTPROMPTUSER, vaIn, vaOut) //jerzy
   else
      ControlInterface.ExecWB(OLECMDID_PRINTPREVIEW, OLECMDEXECOPT_PROMPTUSER, vaIn, vaOut);
   Preview_HWND := 0;
   StartTime := GetTickCount;
   repeat
      App_HWND := GetForegroundWindow();
      GetClassName(App_HWND, ClassName, SizeOf(ClassName));
      if lstrcmp(@ClassName[0], @IE_PPREVIEWCLASS[1]) = 0 then
         Preview_HWND := App_HWND;
      Forms.Application.ProcessMessages;
      EndTime := GetTickCount;
   until (Preview_HWND <> 0) or (EndTime - StartTime > 6000);
   if Preview_HWND <> 0 then
      ShowWindow(Preview_HWND, nCmdShow);
end;

procedure PageSetup(Document: IDispatch; UsePrintOptions, PrintOptionsEnabled: Boolean; var InvokingPageSetup: Boolean);
var
   vaIn, vaOut: OleVariant;
begin
   if DocumentLoaded(Document) then
      begin
         if PrintOptionsEnabled and UsePrintOptions then
            InvokingPageSetup := True;
         InvokeCmd(Document, False, OLECMDID_PAGESETUP, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
      end;
end;

procedure PrintSetup(ControlInterface: IWebBrowser2; HideSetup: Boolean);
var
   vaIn, vaOut: OleVariant;
begin
   if DocumentLoaded(ControlInterface.Document) then
      begin
         if HideSetup then
            ControlInterface.ExecWB(OLECMDID_PAGESETUP, OLECMDEXECOPT_DONTPROMPTUSER, vaIn, vaOut)
         else
            ControlInterface.ExecWB(OLECMDID_PAGESETUP, OLECMDEXECOPT_PROMPTUSER, vaIn, vaOut)
      end;
end;

procedure GetPrintValues(WebBrowser: TEmbeddedWB; PrintOptions: TPrintOptions; Measure: TMeasure);
var
   S: string;
   registry: TRegistry;

   function ReadMargin(key: string): Real;
   begin
      S := registry.ReadString(key);
      if S = '' then
         S := '0.750000'; // <-- default margin value  by takeru_tk_81
      S := StringReplace(S, ' ', '', [rfReplaceAll]);
      if DecimalSeparator <> '.' then
         S := StringReplace(S, '.', DecimalSeparator, []);
      if Measure = mMetric then
         Result := StrToFloat(S) * InchToMetric
      else
         Result := StrToFloat(S);
   end;

begin
   registry := TRegistry.Create;
   try
      with registry do
         begin
            RootKey := HKEY_CURRENT_USER;
            if OpenKey('Software\Microsoft\Internet Explorer\PageSetup', False) then
               begin
                  with PrintOptions do
                  begin
                  Header := ReadString('header');
                  Footer := ReadString('footer');
                  Margins.Left := ReadMargin('margin_left');
                  Margins.Right := ReadMargin('margin_right');
                  Margins.Top := ReadMargin('margin_top');
                  Margins.Bottom := ReadMargin('margin_bottom');
                  end;
               end;
            Registry.Free;
         end;
   except
      if WebBrowser.MessagesBoxes.InternalErrMsg then
         MessageDlg('Error while getting page print values from the registry!', mtError, [mbOK], 0);
   end;
end;

function PrintMarginStr(Measure, RuntimeMeasure: TMeasure; M: Real): PChar;
var
   s: string;
begin
   if Measure <> RuntimeMeasure then
      begin
         if RuntimeMeasure = mMetric then
            s := FloatToStr(M * InchToMetric)
         else
            s := FloatToStr(M / InchToMetric);
         Result := PChar(s);
      end
   else
      Result := PChar(FloatToStr(M));
end;

procedure OpenDialog(WebBrowser: TEmbeddedWB; AOwner: TComponent);
var
   OD: TOpenDialog;
begin
   OD := TOpenDialog.Create(AOwner);
   try
    with OD do
      begin
          Filter :='Internet Files|*.htm; *.html; *.url; *.mht; *.mhtml; *.php *.asp'
          +#10+#13+'|Image Files| *.gif;*.bmp;*.ico;*.jpg;*.png;*.wmf; *.emf; '
          +#10+#13+'|Text & Documents Files| *.txt;*.doc;*.xls;*.dot;'
          +#10+#13+'|Compressed Files| *.zip;'
          +#10+#13+'|XML Files| *.xml;'
          +#10+#13+'|Any Files|*.*';
          Options := Options + [ofShowHelp, ofEnableSizing];
          Title := 'Browser - Open Dialog';
          HelpContext := 0;
        if Execute then
           WebBrowser.Go(OD.FileName);
     end;
   finally
      OD.Free;
   end;
end;

function SaveDialog(WebBrowser: TEmbeddedWB; AOwner: TComponent): string;
var
   SD: TSaveDialog;
begin
   SD := TSaveDialog.Create(AOwner);
   try
    with SD do
      begin
          Filter :='Internet Files|*.htm; *.html;*.mht; *.mhtml; *.php *.asp'
          +#10+#13+'|Text & Documents Files| *.txt;*.doc;*.xls;*.dot;'
          +#10+#13+'|XML Files| *.xml;'
          +#10+#13+'|Any Files|*.*';
          Options := Options + [ofShowHelp, ofEnableSizing];
          Title := 'Browser - Save Dialog';
          HelpContext := 0;
        if Execute then
           Result := SD.FileName;
           if SD.FileName <> '' then            
              SaveToFile(WebBrowser.Document, SD.FileName);
     end;
   finally
      SD.Free;
   end;
end;

procedure SaveDialog(Document: IDispatch);
var
   vaIn, vaOut: OleVariant;
begin
   InvokeCmd(Document, False, OLECMDID_SAVEAS, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
end;

procedure ShowInternetOptions(Document: IDispatch);
var
   vaIn, vaOut: OleVariant;
begin
   InvokeCmd(Document, True, HTMLID_OPTIONS, 0, vaIn, vaOut);
end;

procedure ShowPageProperties(Document: IDispatch);
var
   vaIn, vaOut: OleVariant;
begin
   InvokeCmd(Document, False, OLECMDID_PROPERTIES, OLECMDEXECOPT_DODEFAULT, vaIn, vaOut);
end;

procedure ShowOrganizeFavorites(Handle: THandle);
begin
   OrganizeFavorite(Handle, GetSpecialFolderPath(Handle, CSIDL_FAVORITES));
end;

procedure ShowImportExportFavoritesAndCookies(Handle: THandle);
begin
   SendMessage(Handle, WM_COMMAND, ID_IE_FILE_IMPORTEXPORT, 0);
end;

procedure ShowFindDialog(Document: IDispatch);
var
   vaIn, vaOut: OleVariant;
begin
   InvokeCmd(Document, True, HTMLID_FIND, 0, vaIn, vaOut);
end;

procedure SaveImagesDialog(OleObject: Variant; Document: IDispatch);
var
   k, p: Integer;
   path, Source, dest, ext: string;
begin
   if DocumentLoaded(Document) then
      begin
 //        path := TBrowse4Folder.('Web Browser - Please select a destination folder' + #10 + #13
  //          + 'for the images', 'Desktop');
         MessageDlg(Path, mtCustom, [mbYes, mbAll, mbCancel], 0);
         begin
            for k := 0 to OleObject.Document.Images.Length - 1 do
               begin
                  Source := OleObject.Document.Images.Item(k).Src;
                  p := LastDelimiter('.', Source);
                  ext := UpperCase(System.Copy(Source, p + 1, Length(Source)));
                  if (ext = 'GIF') or (ext = 'JPG') or (ext = 'BMP') or (ext = 'PNG') then
                     begin
                        p := LastDelimiter('/', Source);
                        dest := path + '/Images' + System.Copy(Source, p + 1, Length(Source));
                        DownloadFile(Source, dest);
                     end;
               end;
         end;
      end;
end;

procedure OpenOtherWBFavorites(WebBrowser: TEmbeddedWB);
begin
   if FileExists('c:\' + 'newbook.htm') then
      WebBrowser.Go('c:\newbook.htm')
   else
      if WebBrowser.MessagesBoxes.InternalErrMsg then
         MessageDlg('The file cannot be located.'
            + #10 + #13 + 'Please use "Open URL" in the toolbar to locate the file', mtCustom, [mbOK], 0);
end;

procedure ViewPageSourceHtml(Document: IDispatch);
var
   vaIn, vaOut: OleVariant;
begin
   InvokeCmd(Document, True, HTMLID_VIEWSOURCE, 0, vaIn, vaOut);
end;

procedure SavePageTextDialog(AOwner: TComponent; OleObject: Variant; Document: IDispatch);
var
   sd: TSaveDialog;
   textStr: TStringList;
begin
   textstr := TStringList.Create;
   try
      if DocumentLoaded(Document) then
         textStr.Add(VarToStr(OleObject.Document.documentElement.innerText));
      begin
         sd := TSaveDialog.Create(AOwner);
         try
            sd.Filter := 'Text file|*.txt|Word file|*.doc';
            sd.DefaultExt := 'txt';
            sd.FilterIndex := 1;
            sd.FileName := 'WebSiteText.txt';
            sd.Title := 'Web Site Text';
            if sd.Execute then
               begin
                  textStr.SaveToFile(sd.FileName);
               end;
         finally
            sd.Free;
         end;
      end;
   finally
      textStr.Free;
   end;
end;

procedure OpenOutlookMail;
begin
   ShellExecute(Application.Handle, 'open', PChar('outlook.exe'), nil, nil, SW_SHOW);
end;

procedure OpenOutlookExpressMail;
begin
   ShellExecute(Application.Handle, 'open', PChar('msimn.exe'), nil, nil, SW_SHOW);
end;

procedure OpenEudoraMail;
begin
   ShellExecute(Application.Handle, 'open', PChar('eudora.exe'), nil, nil, SW_SHOW);
end;

procedure OpenRegistryEditor;
begin
   ShellExecute(Application.Handle, 'open', PChar('regedit.exe'), nil, nil, SW_SHOW);
end;

function OpenNewsClient: Boolean;
begin
   result := OpenClient('News');
end;

procedure OpenAddressBook;
begin
   ShellExecute(Application.Handle, 'open', PChar('wab.exe'), nil, nil, SW_SHOW);
end;

function OpenCalendar: Boolean;
begin
   result := OpenClient('Calendar');
end;

function OpenNetMeeting: Boolean;
begin
   result := OpenClient('Internet Call');
end;

procedure DoExploreFolder(Handle: THandle; Path: string);
begin
   ShellExecute(handle, 'explore', PChar(path), nil, nil, SW_SHOWNORMAL);
end;

procedure OpenIEBrowserWithAddress(Handle: THandle);
begin
   SendMessage(Handle, WM_COMMAND, ID_IE_FILE_NEWWINDOW, 0);
end;

function OpenHotmailMail(WebBrowser: TEmbeddedWB): Boolean;
begin
   Result := True;
   Go(WebBrowser, 'http://lc1.law5.hotmail.passport.com/cgi-bin/login');
end;

function OpenGoogleMail(WebBrowser: TEmbeddedWB): Boolean;
begin
   Result := True;
   Go(WebBrowser, 'http://mail.google.com/mail/');
end;

function OpenYahooMail(WebBrowser: TEmbeddedWB): Boolean;
begin
   Result := True;
   Go(WebBrowser, 'http://mail.yahoo.com/');
end;

procedure GoSearchInGoogle(WebBrowser: TEmbeddedWB; SearchTerm: string);
const
   GOOGLE_QUERY = 'http://www.google.com/search?ie=ISO-8859-1&hl=de&q=';
var
   sQuery: string;
begin
   sQuery := GOOGLE_QUERY + SearchTerm;
   Go(WebBrowser, sQuery);
end;

procedure GoSearchInMSN(WebBrowser: TEmbeddedWB; SearchTerm: string);
const
   MSN_QUERY = 'http://search.msn.com/previewx.aspx?q=';
   MSN_Const = '&FORM=CBPW&first=1&noredir=1';
var
   sQuery: string;
begin
   sQuery := MSN_QUERY + SearchTerm + MSN_Const;
   Go(WebBrowser, sQuery);
end;

procedure GoSearchInYahoo(WebBrowser: TEmbeddedWB; SearchTerm: string);
const
   YAHOO_QUERY = 'http://search.yahoo.com/bin/search?p=';
var
   sQuery: string;
begin
   sQuery := YAHOO_QUERY + SearchTerm;
   WebBrowser.Go(sQuery);
end;

procedure Go(WebBrowser: TEmbeddedWB; Url: string);
var
   _URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
begin
   _URL := Url;
   Flags := 0;
   TargetFrameName := 0;
   Postdata := 0;
   Headers := 0;
   if (Trim(_URL) <> '') then
      WebBrowser.Navigate2(_URL, Flags, TargetFrameName, PostData, Headers);
end;

procedure GoWithQueryDetails(WebBrowser: TEmbeddedWB; Url, Query: string);
var
   _URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
begin
   _URL := Url + Query;
   TargetFrameName := 0;
   headers := StringtoVarArray('Content-Type:application/x-www-form-urlencoded'#13#10);
   Postdata := StringToVarArray('version=current&name=myname' + #13#10);
   Flags := 0;
   WebBrowser.Navigate2(_URL, Flags, TargetFrameName, PostData, Headers);
end;

procedure GoNoHistory(WebBrowser: TEmbeddedWB; const URL: string);

   function StrToChr(Str: string; Pos: Integer): Char;
   begin
      Result := Str[Pos];
   end;
var
   Flags: OleVariant;
   HistoryStg: IUrlHistoryStg;
begin
   Flags := navNoHistory;
   WebBrowser.Navigate(WideString(URL), Flags);
   Wait(WebBrowser);
   HistoryStg := CreateComObject(CLSID_CUrlHistory) as IUrlHistoryStg;
   HistoryStg.DeleteUrl(PWideChar(StrToChr(URL, 0)), 0);
end;

procedure NavigatePidl(WebBrowser: TEmbeddedWB; pidl: PItemIdList);
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
         WebBrowser.Navigate2(vaPidl, vaEmpty, vaEmpty, vaEmpty, vaEmpty);
         VariantClear(vaPidl);
      end;
end;

function GetFrameFromDocument(SourceDoc: IHTMLDocument2; FrameNo: Integer): IWebBrowser2;
var //by Aladin
   OleContainer: IOleContainer;
   enum: ActiveX.IEnumUnknown;
   unk: IUnknown;
   Fetched: PLongint;
begin
   Result := nil;
   Fetched := nil;
   if not DocumentLoaded(SourceDoc) then
      Exit;
   OleContainer := SourceDoc as IOleContainer;
   OleContainer.EnumObjects(OLECONTF_EMBEDDINGS or OLECONTF_OTHERS, Enum);
   Enum.Skip(FrameNo);
   Enum.Next(1, Unk, Fetched);
   Result := Unk as IWebBrowser2;
end;

function NavigateToFrame(WebBrowser: TEmbeddedWB; FrameList: string): IHtmlDocument2;
var
   Document: IHtmlDocument2;
   FramesIndexList: TStringList;
   i: Integer;
begin
   Result := nil;
   Document := WebBrowser.GetDocument;
   FramesIndexList := TStringList.Create;
   try
      FramesIndexList.CommaText := FrameList; //move into the last frame
      for i := 0 to FramesIndexList.Count - 1 do
         begin
            Document := GetFrameFromDocument(Document, StrToInt(FramesIndexList[i])).Document as IHtmlDocument2;
            if not DocumentLoaded(Document) then
               Exit;
         end;
      Result := Document;
   finally
      FramesIndexList.Free;
   end;
end;

procedure NavigateFolder(WebBrowser: TEmbeddedWB; CSIDL: Integer);
var
   sFolder: PItemIdList;
begin
   SHGetSpecialFolderLocation(0, CSIDL, SFolder);
   NavigatePidl(WebBrowser, SFolder);
   CoTaskMemFree(SFolder);
end;

procedure GoAboutBlank(WebBrowser: TEmbeddedWB);
begin
   WebBrowser.Go('about:blank');
   Wait(WebBrowser);
end;

procedure SendPageInMailAsAttachment(WebBrowser: TEmbeddedWB; AOwner: TComponent; Document: IDispatch; mFileName, mSubject, mBody: string);
begin
   SaveToFile(Document, mFileName);
   Sleep(800);
   with TEwbMapiMail.Create(AOwner) do
      begin
         try
            Subject := mSubject;
            Body := mBody;
            Attachments.Add(mFileName);
            EditDialog := True;
            if Send then
               if not DeleteFile(mFileName) then
                  if WebBrowser.MessagesBoxes.InternalErrMsg then
                     MessageDlg('An error accured while deleting ' + mFileName, mtInformation, mbOKCancel, 0);
         finally
            Free;
         end;
      end;
end;

procedure GoDownloadFile(WebBrowser: TEmbeddedWB; URL: string);
var
   Flags: OleVariant;
begin
   Flags := navNoHistory or navNoReadFromCache or navNoWriteToCache
      or navAllowAutosearch or navBrowserBar;
   WebBrowser.Navigate(URL, Flags);
end;

function DownloadFile(SourceFile, TargetFile: string): Boolean;
begin
   try
      Result := UrlDownloadToFile(nil, PChar(SourceFile), PChar(TargetFile), 0, nil) = 0;
   except
      Result := False;
   end;
end;

procedure GoDownloadMaskedFile(SourceFile, TargetFile: string; Notify: Boolean);
begin
   if notify then
      begin
         if DownloadFile(SourceFile, TargetFile) then
            MessageBox(0, PChar('Downloading: ' + SourceFile + #10 + #13 +
               'To: ' + TargetFile + #10 + #13 + 'was succesfully finished.'),
               PChar('Download successful.'), MB_OK)
         else
            MessageBox(0, PChar(
               'An error ocurred while contacting the site for downloading' + SourceFile),
               PChar('Downloading Error!!'), MB_ICONERROR or MB_OK);
      end
   else
      DownloadFile(SourceFile, TargetFile);
end;

procedure AddToFavorites(URL, Title: string);
const
   CLSID_ShellUIHelper: TGUID = '{64AB4BB7-111E-11D1-8F79-00C04FC2FBE1}';
var
   ShellUIHelper: ISHellUIHelper;
   Url1, Title1: OleVariant;
begin
   Title1 := Title;
   Url1 := Url;
   CoCreateInstance(CLSID_SHELLUIHELPER, nil, CLSCTX_INPROC_SERVER, IID_IShellUIHelper, ShellUIHelper);
   ShellUIHelper.AddFavorite(URL1, Title1);
end;

function GetFavoritesPath: string;
var
   Reg: TRegistry;
begin
   Reg := TRegistry.Create;
   try
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', False) then
         Result := Reg.ReadString('Favorites');
   finally
      Reg.CloseKey;
      Reg.Free;
   end;
end;

function GetCookiesPath: string;
var
   Reg: TRegistry;
begin
   Reg := TRegistry.Create;
   try
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', False) then
         Result := Reg.ReadString('Cookies');
   finally
      Reg.CloseKey;
      Reg.Free;
   end;
end;

function GetHistoryPath: string;
var
   Reg: TRegistry;
begin
   Reg := TRegistry.Create;
   try
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', False) then
         Result := Reg.ReadString('History');
   finally
      Reg.CloseKey;
      Reg.Free;
   end;
end;

function GetSpecialFolderPath(CallerHandle: THandle; CSIDL: Integer): PChar;
var
   exInfo: TShellExecuteInfo;
   Buf: PChar;
begin
   FillChar(exInfo, SizeOf(exInfo), 0);
   with exInfo do
      begin
         cbSize := SizeOf(exInfo);
         fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_IDLIST;
         Wnd := CallerHandle;
         nShow := SW_SHOWNORMAL;
         Buf := StrAlloc(MAX_PATH);
         SHGetSpecialFolderPath(wnd, Buf, CSIDL, True);
         Result := Buf;
      end;
end;

function GetIEHomePage: string;
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

function GetCachedFileFromURL(strUL: string; var strLocalFile: string): Boolean;
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

function URLFromFavorites(const dotURL: string): string;
begin
   with TIniFile.Create(dotURL) do
      try
         try
            Result := ReadString('InternetShortcut', 'URL', '');
         except;
            Result := '';
         end;
      finally
         Free;
      end;
end;

function UrlFromHistory(ShellFolder: IShellFolder; pidl: PItemIDList): string;
var
   Handle: THandle;
   Info: IQueryInfo;
   W: PWideChar;
begin
   Handle := 0;
   Info := nil;
   ShellFolder.GetUIObjectOf(Handle, 1, pidl, IID_IQUERYINFO, nil, Pointer(Info));
   if Assigned(Info) then
      begin
         Info.GetInfoTip(0, w);
         Result := W;
      end
   else
      Result := '';
   Result := Trim(System.Copy(Result, Pos(#10, Result) + 1, length(Result)));
end;

function GetDefaultBrowserFromRegistry: string;
var
   Reg: TRegistry;
   KeyName: string;
begin
   Reg := TRegistry.Create;
   try
      Reg.RootKey := HKEY_CLASSES_ROOT;
      KeyName := 'htmlfile\shell\open\command';
      if Reg.OpenKey(KeyName, False) then
         begin
            Result := Reg.ReadString('');
            Reg.CloseKey;
         end
      else
         Result := 'No default browser was found';
   finally
      Reg.Free;
   end;
end;

function GetIPAndHostName(var HostName, IPaddr, WSAErr: string): Boolean;
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
   if WSAStartup($0101, WSAData) <> 0 then
      begin
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
            IPaddr := Concat(IPaddr, IntToStr(Ord(HEnt^.h_addr_list^[i])) + '.');
         SetLength(IPaddr, Length(IPaddr) - 1);
         Result := True;
      end
   else
      begin
         case WSAGetLastError of
            WSANOTINITIALISED: WSAErr := 'WSANotInitialised';
            WSAENETDOWN: WSAErr := 'WSAENetDown';
            WSAEINPROGRESS: WSAErr := 'WSAEInProgress';
         end;
      end;
   Dispose(HName);
   WSACleanup;
end;

procedure CreateNewMail;
var
   em_subject, em_body, em_mail: string;
begin
   em_subject := '';
   em_body := '';
   em_mail := 'mailto:?subject=' + em_subject + '&body=' + em_body;
   ShellExecute(0, 'open', PChar(em_mail), nil, nil, SW_SHOWNORMAL);
end;

procedure SendUrlInMail(LocationURL, LocationName: WideString);
var
   em_body, em_mail, em_subject, URL, Title: string;
begin
   URL := LocationURL;
   Title := LocationName;
   em_subject := 'Check this site';
   em_body := 'I found ' + LocationName + '    In: ' + LocationURL + '   Please Have A look';
   em_mail := 'mailto:?subject=' + em_subject + '&body=' + em_body;
   ShellExecute(0, 'open', PChar(em_mail), nil, nil, SW_SHOWNORMAL);
end;

function SearchText(WebBrowser: TEmbeddedWB; Document: IDispatch; const Value: string; const iPos: Integer = 1): IHTMLTxtRange;
begin //by JJM
   Wait(WebBrowser);
   Result := nil;
   try
      if DocumentLoaded(Document) then
         if Assigned((Document as IHTMLDocument2).body) then
            begin
               Result := ((Document as IHTMLDocument2).body as IHTMLBodyElement).CreateTextRange;
               if Result.findText(Value, iPos, 0) then
                  Result.ScrollIntoView(True)
               else
                  Result := nil;
            end;
   except
      on e: Exception do
         ;
   end;
end;

function SearchString(Webbrowser: TEmbeddedWB; const strText: string): Boolean;
var
   tr: IHTMLTxtRange;
begin
   Wait(WebBrowser);
   Result := False;
   try
      if Assigned(Webbrowser.Document) then
         begin
            tr := ((Webbrowser.Document as IHTMLDocument2).body as IHTMLBodyElement).createTextRange;
            Result := tr.findText(strText, 1, 0);
         end;
   except
      on e: Exception do
         ;
   end;
end;

procedure SearchAndHighlight(Document: IDispatch; const ACaption, APrompt: string; aText: string = ''; ShowInputQuery: Boolean = False);
var
   tr: IHTMLTxtRange;
begin
   if DocumentLoaded(Document) then
      begin
         if ShowInputQuery then
            begin
               if not InputQuery(ACaption, APrompt, aText) then
                  Exit;
            end;
         tr := ((Document as IHTMLDocument2).body as IHTMLBodyElement).createTextRange;
         while tr.findText(aText, 1, 0) do
            begin
               tr.pasteHTML('<span style="background-color: Lime; font-weight: bolder;">' +
                  tr.htmlText + '</span>');
               tr.scrollIntoView(True);
            end;
      end;
end;

function FillForm(OleObject: Variant; FieldName: string; Value: string): Boolean;
var
   I, j: Integer;
   FormItem: Variant;
begin
   Result := False;
   if not DocumentLoaded(OleObject.Document) then
      Exit;
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

procedure AutoFillIEFormAndExcecute;
var
   ShellWindow: IShellWindows;
   IWeb: IWebBrowser2;
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
         if spDisp = nil then
            Continue;
    // QueryInterface determines if an interface can be used with an object
         spDisp.QueryInterface(IWebBrowser2, IWeb);

         if IWeb <> nil then
            begin
               IWeb.Document.QueryInterface(IHTMLDocument2, iDoc1);
               if iDoc1 <> nil then
                  begin
                     IWeb := ShellWindow.Item(k) as IWebBrowser2;
                     begin
                        Document := IWeb.Document;
            // count forms on document and iterate through its forms
                        for m := 0 to Document.Forms.Length - 1 do
                           begin
                              ovElements := Document.Forms.Item(m).Elements;
            // iterate through elements
                              for i := 0 to ovElements.Length - 1 do
                                 begin
              // when input fieldname is found, try to fill out
                                    try
                                       if (CompareText(ovElements.Item(i).tagName, 'INPUT') = 0) and
                                          (CompareText(ovElements.Item(i).type, 'text') = 0) then
                                          begin
                                             ovElements.Item(i).Value := 'FindWindow';
                                          end;
                                    except
                                    end;
              // when Submit button is found, try to click
                                    try
                                       if (CompareText(ovElements.Item(i).tagName, 'INPUT') = 0) and
                                          (CompareText(ovElements.Item(i).type, 'SUBMIT') = 0) and
                                          (ovElements.Item(i).Value = 'Search') then // Suchen for German
                                          begin
                                             ovElements.Item(i).Click;
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

procedure ClearHistory;
var
   HistoryStg: IUrlHistoryStg2;
begin
   HistoryStg := CreateComObject(CLSID_CUrlHistory) as IUrlHistoryStg2;
   HistoryStg.ClearHistory;
end;

function DeleteFirstCacheEntry(var H: THandle): DWORD;
var
   T: PInternetCacheEntryInfo;
   D: DWord;
begin
   Result := S_OK;
   H := 0;
   D := 0;
   FindFirstUrlCacheEntryEx(nil, 0, URLCACHE_FIND_DEFAULT_FILTER, 0, nil, @D, nil, nil, nil);
   GetMem(T, D);
   try
      H := FindFirstUrlCacheEntryEx(nil, 0, URLCACHE_FIND_DEFAULT_FILTER, 0, T, @D, nil, nil, nil);
      if (H = 0) then
         Result := GetLastError
      else
         DeleteUrlCacheEntry(T^.lpszSourceUrlname);
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
         then
         Result := GetLastError
      else
         DeleteUrlCacheEntry(T^.lpszSourceUrlname);
   finally
      FreeMem(T, D)
   end;
end;

procedure ClearCache;
var
   H: THandle;
begin
   if DeleteFirstCacheEntry(H) = S_OK then
      repeat
      until DeleteNextCacheEntry(H) = ERROR_NO_MORE_ITEMS;
   FindCloseUrlCache(H)
end;

procedure ClearTypedUrls;
begin
   with TRegistry.Create do
      try
         RootKey := HKEY_CURRENT_USER;
         DeleteKey('Software\Microsoft\Internet Explorer\TypedURLs');
      finally
         Free;
      end;
end;

function CheckOnlineStatus: Boolean;
var
   dwConnectionTypes: Integer;
begin
   Result := False;
   try
      dwConnectionTypes := INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN + INTERNET_CONNECTION_PROXY;
      Result := InternetGetConnectedState(@dwConnectionTypes, 0);
   except
   end;
end;

procedure WorkOffline(WebBrowser: TEmbeddedWB);
var
   btn: Integer;
   ci: TInternetConnectedInfo;
   dwSize: DWORD;
begin
   if WebBrowser.MessagesBoxes.InternalErrMsg then
      begin
         btn := MessageDlg('You are choosing to work Offline!', mtWarning, mbOKCancel, 0);
         if btn = mrCancel then
            Exit;
      end;
   dwSize := SizeOf(ci);
   ci.dwConnectedState := INTERNET_STATE_DISCONNECTED_BY_USER;
   ci.dwFlags := ISO_FORCE_DISCONNECTED;
   InternetSetOption(nil, INTERNET_OPTION_CONNECTED_STATE, @ci, dwSize);
end;

procedure WorkOnline(WebBrowser: TEmbeddedWB);
var
   btn: Integer;
   ci: TInternetConnectedInfo;
   dwSize: DWORD;
begin
   if WebBrowser.MessagesBoxes.InternalErrMsg then
      begin
         btn := MessageDlg('You are choosing to work Online', mtInformation, mbOKCancel, 0);
         if btn = mrCancel then
            Exit;
      end;
   dwSize := SizeOf(ci);
   ci.dwFlags := 0;
   ci.dwConnectedState := INTERNET_STATE_CONNECTED;
   InternetSetOption(nil, INTERNET_OPTION_CONNECTED_STATE, @ci, dwSize);
end;

function IsGlobalOffline: Boolean;
var
   dwState: DWORD;
   dwSize: DWORD;
begin
   dwState := 0;
   dwSize := SizeOf(dwState);
   Result := False;
   if (InternetQueryOption(nil, INTERNET_OPTION_CONNECTED_STATE, @dwState, dwSize)) then
      if ((dwState and INTERNET_STATE_DISCONNECTED_BY_USER) <> 0) then
         Result := True;
end;

function CheckIfInRestricredList(const URL: string): Boolean;
var
   bRest: Boolean;
begin
   Result := False;
   with TRegistry.Create(KEY_READ) do
      begin
         try
            RootKey := HKEY_CURRENT_USER;
            if not OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains' + '\' + URL, False) then
               begin
                  CloseKey;
                  Exit;
               end
            else
               bRest := ReadInteger('*') = 4;
            if bRest then
               Result := True;
         finally
            CloseKey;
            Free;
         end;
      end;
end;

function CheckIfInTrustedList(const URL: string): Boolean;
var
   bTrusted: Boolean;
begin
   Result := False;
   with TRegistry.Create(KEY_READ) do
      begin
         try
            RootKey := HKEY_CURRENT_USER;
            if not OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains' + '\' + URL, False) then
               begin
                  CloseKey;
                  Exit;
               end
            else
               bTrusted := ReadInteger('https') = 2;
            if bTrusted then
               Result := True
         finally
            CloseKey;
            Free;
         end;
      end;
end;

procedure AddToTrustedSiteList(WebBrowser: TEmbeddedWB; const URL: string);
var
   Reg: TRegistryIniFile;
begin
   if AnsiPos('https', URL) = 0 then
      MessageDlg('Only sites with https:// prefix (secured sites) can be added to the trusted sites list zone!', mtError, [mbOK], 0)
   else
      begin
         try
            Reg := TRegistryIniFile.Create('\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains');
            try
               Reg.WriteInteger(URL, 'https', (2));
            finally
               Reg.Free;
            end;
         except
            begin
               if WebBrowser.MessagesBoxes.InternalErrMsg then
                  MessageDlg('Error while adding the site to the trusted sites list zone!', mtError, [mbOK], 0);
            end;
         end;
         if WebBrowser.MessagesBoxes.InternalErrMsg then
            MessageDlg('The page has been added to the trusted sites list zone.', mtInformation, [mbOK], 0);
      end;
end;

procedure AddToRestrictedSiteList(WebBrowser: TEmbeddedWB; const URL: string);
var
   st: string;
   I: Integer;
   Reg: TRegistryIniFile;
begin
   I := LastDelimiter(':', Url) + 2;
   st := Copy(Url, I + 1, MaxInt);
   if AnsiPos('www', st) > 0 then
      begin
         I := 4;
         st := Copy(st, I + 1, MaxInt);
      end;
   try
      Reg := TRegistryIniFile.Create('\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains');
      try
         Reg.WriteInteger(st, '*', (4));
      finally
         Reg.Free;
      end;
   except
      begin
         if WebBrowser.MessagesBoxes.InternalErrMsg then
            MessageDlg('Error while adding the site to the restricted sites list zone!', mtError, [mbOK], 0);
      end;
      if WebBrowser.MessagesBoxes.InternalErrMsg then
         MessageDlg('The page has been added to the restricted sites list zone.', mtInformation, [mbOK], 0);
   end;
end;

procedure GetZoneIcon(IconPath: string; var Icon: TIcon);
var
   FName, ImageName: string;
   h: hInst;
begin
   FName := Copy(IconPath, 1, Pos('#', IconPath) - 1);
   ImageName := Copy(IconPath, Pos('#', IconPath), Length(IconPath));
   h := LoadLibrary(PChar(FName));
   try
      if h <> 0 then
         Icon.Handle := LoadImage(h, PChar(ImageName), IMAGE_ICON, 16, 16, 0);
   finally
      FreeLibrary(h);
   end;
end;

function GetZoneAttributes(const URL: string): TZoneAttributes;
var
   dwZone: Cardinal;
   ZoneAttr: TZoneAttributes;
var
   ZoneManager: IInternetZoneManager;
   SecManager: IInternetSecurityManager;
begin
   ZeroMemory(@ZoneAttr, SizeOf(TZoneAttributes));
   if CoInternetCreateSecuritymanager(nil, SecManager, 0) = S_OK then
      if CoInternetCreateZoneManager(nil, ZoneManager, 0) = S_OK then
         begin
            SecManager.MapUrlToZone(PWideChar(WideString(URL)), dwZone, 0);
            ZoneManager.GetZoneAttributes(dwZone, Result);
         end;
end;

function GetZoneIconToForm(LocationURL: string; Caption, Hint: string): Boolean;
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
   Result := True;
end;

function GetUrlSecurityZone(LocationURL: string; var ZoneName, ZoneDescription: string; var Icon: TIcon): Boolean;
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
      Result := True;
   except
      Result := False;
   end;
end;

function GetSSLStatus(OleObject: Variant; LocationURL: string; var SSLName, SSLDescription: string): Boolean;
begin
   Result := False;
   if (Pos('https://', LocationURL) > 0) then
      begin
         if OleObject.Document.Location.Protocol = 'https:' then
            begin
               SSLName := 'SSL';
               SSLDescription := 'It is a secure web page.';
               Result := True;
            end;
      end
   else
      begin
         SSLName := 'None';
         SSLDescription := 'The page is not secured.';
         Result := False;
      end
end;

{procedure SetProxy(Server: string);
type
  INTERNET_PER_CONN_OPTION = record //by KKKas
    dwOption: DWORD;
    Value: record
      case Integer of
        1: (dwValue: DWORD);
        2: (pszValue: PAnsiChar);
        3: (ftValue: TFileTime);
    end;
  end;
  LPINTERNET_PER_CONN_OPTION = ^INTERNET_PER_CONN_OPTION;
  INTERNET_PER_CONN_OPTION_LIST = record
    dwSize: DWORD;
    pszConnection: LPTSTR;
    dwOptionCount: DWORD;
    dwOptionError: DWORD;
    pOptions: LPINTERNET_PER_CONN_OPTION;
  end;
  LPINTERNET_PER_CONN_OPTION_LIST = ^INTERNET_PER_CONN_OPTION_LIST;
var
  ListRecord: INTERNET_PER_CONN_OPTION_LIST;
  dwBufSize: DWORD;
  hInternet: Pointer;
begin
  dwBufSize := SizeOf(ListRecord);
  ListRecord.dwSize := dwBufSize;
  with ListRecord do
  try
    begin
      pszConnection := nil; // NULL == LAN, otherwise connectoid name.
      dwOptionCount := 3; // Set three options
      pOptions := AllocMem(SizeOf(INTERNET_PER_CONN_OPTION) * 3);
      if pOptions = nil then Exit;
      pOptions^.dwOption := INTERNET_PER_CONN_FLAGS;
      pOptions^.Value.dwValue := PROXY_TYPE_DIRECT or PROXY_TYPE_PROXY;
      inc(pOptions); // Set proxy name.
      pOptions^.dwOption := INTERNET_PER_CONN_PROXY_SERVER;
      pOptions^.Value.pszValue := PChar(Server);
      inc(pOptions); // Set proxy override.
      pOptions^.dwOption := INTERNET_PER_CONN_PROXY_BYPASS;
      pOptions^.Value.pszValue := 'local';
      Dec(pOptions, 2); // Set the options on the connection.
    end;
    hInternet := InternetOpen('APPNAME123', INTERNET_OPEN_TYPE_DIRECT, nil, nil, 0);
    InternetSetOption(hInternet, INTERNET_OPTION_PER_CONNECTION_OPTION, @listRecord, dwBufSize);
    InternetSetOption(hInternet, INTERNET_OPTION_REFRESH, nil, 0);
    InternetCloseHandle(hInternet);
  finally
  end;
  FreeMem(ListRecord.pOptions);
end;  }

procedure SetProxy(UserAgent, ProxyServer: string); //mladen
type
   INTERNET_PER_CONN_OPTION = record
      dwOption: DWORD;
      Value: record
         case Integer of
            1: (dwValue: DWORD);
            2: (pszValue: PAnsiChar);
            3: (ftValue: TFileTime);
      end;
   end;
   LPINTERNET_PER_CONN_OPTION = ^INTERNET_PER_CONN_OPTION;
   INTERNET_PER_CONN_OPTION_LIST = record
      dwSize: DWORD;
      pszConnection: LPTSTR;
      dwOptionCount: DWORD;
      dwOptionError: DWORD;
      pOptions: LPINTERNET_PER_CONN_OPTION;
   end;
   LPINTERNET_PER_CONN_OPTION_LIST = ^INTERNET_PER_CONN_OPTION_LIST;
var
   list: INTERNET_PER_CONN_OPTION_LIST;
   dwBufSize: DWORD;
   hInternet: Pointer;
   Options: array[1..3] of INTERNET_PER_CONN_OPTION;
const
   INTERNET_PER_CONN_FLAGS = 1;
   INTERNET_PER_CONN_PROXY_SERVER = 2;
   INTERNET_PER_CONN_PROXY_BYPASS = 3;
   INTERNET_PER_CONN_AUTOCONFIG_URL = 4;
   INTERNET_PER_CONN_AUTODISCOVERY_FLAGS = 5;
   PROXY_TYPE_DIRECT = $00000001; // direct to net
   PROXY_TYPE_PROXY = $00000002; // via named proxy
   PROXY_TYPE_AUTO_PROXY_URL = $00000004; // autoproxy URL
   PROXY_TYPE_AUTO_DETECT = $00000008; // use autoproxy detection
   INTERNET_OPTION_REFRESH = 37;
   INTERNET_OPTION_PER_CONNECTION_OPTION = 75;
   INTERNET_OPTION_SETTINGS_CHANGED = 39;
begin
   dwBufSize := sizeof(list);
   list.dwSize := sizeof(list);
   list.pszConnection := nil;
   list.dwOptionCount := High(Options); // the highest index of the array (in this case 3)
  // list.pOptions:= Allocmem(sizeof(INTERNET_PER_CONN_OPTION) * 3);
  //if list.pOptions = nil then
  //  Exit;
   Options[1].dwOption := INTERNET_PER_CONN_FLAGS;
   Options[1].Value.dwValue := PROXY_TYPE_DIRECT or PROXY_TYPE_PROXY;
  //inc(list.pOptions);
   Options[2].dwOption := INTERNET_PER_CONN_PROXY_SERVER;
   Options[2].Value.pszValue := PChar(ProxyServer);
  //inc(list.pOptions);
   Options[3].dwOption := INTERNET_PER_CONN_PROXY_BYPASS;
  //list.pOptions^.Value.pszValue  := 'local';
   Options[3].Value.pszValue := '<local>'; // '<local>' instead of 'local'
  //Dec(list.pOptions, 2);
   list.pOptions := @Options;
   hInternet := InternetOpen(PChar(UserAgent), INTERNET_OPEN_TYPE_DIRECT, nil, nil, 0);
   InternetSetOption(hInternet, INTERNET_OPTION_PER_CONNECTION_OPTION, @list, dwBufSize);
   InternetSetOption(hInternet, INTERNET_OPTION_REFRESH, nil, 0);
   InternetCloseHandle(hInternet);
  // Free the allocated memory.
  //FreeMem(list.pOptions);
end;

procedure SetUserAgent(var UserAgent: string);
var
   reg: TRegistry;
begin
   Reg := TRegistry.Create;
   try
      if UserAgent <> ('Mozilla/4.0(Compatible EmbeddedWB-' + VER_NUM + ' from: ' + SITE_ADDRESS) then
         UserAgent := ('Mozilla/4.0(Compatible ' + UserAgent + 'EmbeddedWB-' + VER_NUM + ' from: ' + SITE_ADDRESS);
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings\User Agent\Post Platform', True)
         then
         Reg.WriteString(UserAgent, '');
   finally
      Reg.CloseKey;
      Reg.Free;
   end;
end;

procedure RemoveUserAgent(UserAgent: string);
var
   reg: TRegistry;
begin
   Reg := TRegistry.Create;
   try
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings\User Agent\Post Platform', False)
         then
         reg.DeleteValue(UserAgent);
   finally
      Reg.CloseKey;
      Reg.Free;
   end;
end;

var
   MimeFactory, NSFactory: IClassFactory;
   MimeInternetSession, NSInternetSession: IInternetSession;

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

procedure RestoreApplicationFormSize(WebBrowser: TEmbeddedWB);
var
   ws: Integer;
   RegPath: string;
begin
   with TRegistry.Create do
      begin
         RootKey := HKEY_LOCAL_MACHINE;
         RegPath := 'SOFTWARE\' + Forms.Application.Title + '\FormSize';
         if OpenKey(RegPath, False) then
            try
               Forms.Application.MainForm.Left := ReadInteger('Left');
               Forms.Application.MainForm.Top := ReadInteger('Top');
               Forms.Application.MainForm.Width := ReadInteger('Width');
               Forms.Application.MainForm.Height := ReadInteger('Height');
               ws := ReadInteger('WindowState');
               case ws of
                  0: Forms.Application.MainForm.WindowState := wsNormal;
                  1: Forms.Application.MainForm.WindowState := wsMinimized;
                  2: Forms.Application.MainForm.WindowState := wsMaximized;
               end;
            except
               if WebBrowser.MessagesBoxes.InternalErrMsg then
                  MessageDlg('Error while writing the application form position to the registry!', mtError, [mbOK], 0);
            end;
         CloseKey;
         Free;
      end;
end;

procedure SaveApplicationFormSize(WebBrowser: TEmbeddedWB);
var
   RegPath: string;
begin
   with TRegistry.Create do
      begin
         RootKey := HKEY_LOCAL_MACHINE;
         RegPath := 'SOFTWARE\' + Forms.Application.Title + '\FormSize';
         if OpenKey(RegPath, True) then
            try
               begin
                  WriteInteger('Top', Forms.Application.MainForm.Top);
                  WriteInteger('Left', Forms.Application.MainForm.Left);
                  WriteInteger('Width', Forms.Application.MainForm.Width);
                  WriteInteger('Height', Forms.Application.MainForm.Height);
                  with Forms.Application.MainForm do
                     case WindowState of
                        wsNormal: WriteInteger('WindowState', 0);
                        wsMinimized: WriteInteger('WindowState', 0);
                        wsMaximized: WriteInteger('WindowState', 0);
                     end;
                  CloseKey;
                  Free;
               end;
            except
               if WebBrowser.MessagesBoxes.InternalErrMsg then
                  MessageDlg('Error while writing the application form position to the registry!', mtError, [mbOK], 0);
            end;
      end;
end;

procedure Wait(WebBrowser: TEmbeddedWB);
begin
   while WebBrowser.ReadyState <> READYSTATE_COMPLETE do
      Forms.Application.ProcessMessages;
end;

procedure InvokeCMD(Document: IDispatch; InvokeIE: Boolean; Value1, Value2: Integer; var vaIn, vaOut: OleVariant);
var
   CmdTarget: IOleCommandTarget;
   PtrGUID: PGUID;
begin
   New(PtrGUID);
   if InvokeIE then
      PtrGUID^ := CLSID_WebBrowser
   else
      PtrGuid := PGUID(nil);
   if DocumentLoaded(Document) then
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

function GetIEHandle(WebBrowser: TEmbeddedWB; ClassName: string): HWND;
var
   HWNDChild, HWNDTmp: Integer;
   oleCtrl: TOleControl;
   szClass: array[0..255] of char;
begin
   oleCtrl := WebBrowser;
   HWNDTmp := oleCtrl.Handle;
   while (True) do
      begin
         HWNDChild := GetWindow(HWNDTmp, GW_CHILD);
         GetClassName(HWNDChild, szClass, SizeOf(szClass));
         if (string(szClass) = ClassName) then
            begin
               Result := HWNDChild;
               Exit;
            end;
         HWNDTmp := HWNDChild;
      end;
   Result := 0;
end;

procedure ShowIEVersionInfo(Handle: THandle);
begin
   SendMessage(Handle, WM_COMMAND, ID_IE_HELP_VERSIONINFO, 0);
end;

procedure SetNewHomePage(HomePage: string);
begin
   with TRegistry.Create do
      begin
         try
            OpenKey('\Software\Microsoft\Internet Explorer\Main', True);
            WriteString('Start Page', HomePage);
            CloseKey;
         finally
            Free;
         end;
      end;
end;

function GetLastVisitedPage(var LastVisitedPage: string): Boolean;
begin
   Result := False;
   with TRegistry.Create do
      begin
         LastVisitedPage := '';
         RootKey := HKEY_LOCAL_MACHINE;
         try
            if OpenKey('SOFTWARE\' + Forms.Application.Title + '\WebPages', False) then
               begin
                  LastVisitedPage := ReadString('LastVisitedPage');
                  CloseKey;
                  if (LastVisitedPage <> '') and (AnsiPos('.', LastVisitedPage) > 0) then
                     Result := True;
               end;
         finally
            Free;
         end;
      end;
end;

function SaveLastVisitedPage(WebBrowser: TEmbeddedWB; LocationURL: string): Boolean;
var
   RegPath: string;
begin
   Result := False;
   with TRegistry.Create do
      begin
         RootKey := HKEY_LOCAL_MACHINE;
         RegPath := 'SOFTWARE\' + Forms.Application.Title + '\WebPages';
         if OpenKey(RegPath, False) then
            try
               DeleteKey('LastVisitedPage');
            except
               begin
                  if WebBrowser.MessagesBoxes.InternalErrMsg then
                     MessageDlg('Error while writing the Last Visited Page to the registry!', mtError, [mbOK], 0);
                  Exit;
               end;
            end;
         Free;
      end;
   with TRegIniFile.Create do
      begin
         RootKey := HKEY_LOCAL_MACHINE;
         RegPath := 'SOFTWARE\' + Forms.Application.Title;
         if OpenKey(RegPath, True) then
            try
               WriteString('WebPages', 'LastVisitedPage', LocationURL);
               Result := True;
            except
               begin
                  if WebBrowser.MessagesBoxes.InternalErrMsg then
                     MessageDlg('Error while writing the Last Visited Page to the registry!', mtError, [mbOK], 0);
               end;
               CloseKey;
               Free;
            end;
      end;
end;



procedure CreateDesktopShortcut(Handle: THandle);
begin
   SendMessage(Handle, WM_COMMAND, ID_IE_FILE_SENDDESKTOPSHORTCUT, 0);
end;

procedure DisableNavSound(bDisable: Boolean);
var
   Reg: TRegIniFile;
   Path: string;
begin
   Reg := TRegIniFile.Create;
   Path := 'AppEvents\Schemes\Apps\Explorer\Navigating\';
   with Reg do
      begin
         RootKey := HKEY_CURRENT_USER;
         try
            if bDisable then
               begin
                  if KeyExists(Path + '.Current') then
                     if OpenKey(Path, True) then
                        MoveKey('.Current', 'Old_Current', True);
               end
            else
               begin
                  if KeyExists(Path + 'Old_Current') then
                     if OpenKey(Path, false) then
                        MoveKey('Old_Current', '.Current', True);
               end;
         finally
            CloseKey;
            Free;
         end;
      end;
end;

//To Add--------------------------------------------------

function URLFromShortcut(const dotURL: string): string;
begin
   with TIniFile.Create(dotURL) do
      try
         try
            Result := ReadString('InternetShortcut', 'URL', '');
         except;
            Result := '';
         end;
      finally
         Free;
      end;
end;

function ExtractUrl(ShellFolder: IShellFolder; pidl: PItemIDList): string;
var
   Handle: THandle;
   Info: IQueryInfo;
   W: PWideChar;
begin
   Handle := 0;
   Info := nil;
   ShellFolder.GetUIObjectOf(Handle, 1, pidl, IID_IQUERYINFO, nil, Pointer(Info));
   if assigned(Info) then
      begin
         Info.GetInfoTip(0, w);
         Result := W;
      end
   else
      result := '';
   Result := Trim(Copy(Result, Pos(#10, Result) + 1, length(Result)));
end;

function StringToVarArray(const S: string): Variant;
begin
   Result := Unassigned;

   if S <> '' then
      begin
         Result := VarArrayCreate([0, Length(S) - 1], varByte);
         Move(Pointer(S)^, VarArrayLock(Result)^, Length(S));
         VarArrayUnlock(Result);
      end;
end;

function VarArrayToString(const V: Variant): string;
var
   i, j: Integer;
begin
   if VarIsArray(V) then
      for I := 0 to VarArrayHighBound(V, 1) do
         begin
            j := V[i];
            result := result + chr(j);
         end;
end;

function Encode(const S: string): string;
var
   I: Integer;
   Hex: string;
begin
   for I := 1 to Length(S) do

      case S[i] of
         ' ': result := Result + '+';
         'A'..'Z', 'a'..'z', '*', '@', '.', '_', '-',
            '0'..'9', '$', '!', '''', '(', ')':
            result := Result + s[i];
         else
            begin
               Hex := IntToHex(ord(S[i]), 2);
               if Length(Hex) = 2 then
                  Result := Result + '%' + Hex
               else
                  Result := Result + '%0' + hex;
            end;
      end;
end;

function IE5_Installed: Boolean;
var
   Reg: TRegistry;
   S: string;
begin
   Reg := TRegistry.Create;
   with Reg do
      begin
         RootKey := HKEY_LOCAL_MACHINE;
         OpenKey('Software\Microsoft\Internet Explorer', False);
         if ValueExists('Version') then
            S := ReadString('Version')
         else
            S := '0';
         CloseKey;
         Free;
      end;
   Result := (StrToInt(S[1]) > 4);
end;

function GetIEVersion: string;
var
   SysDir: PChar;
   Info: Pointer;
   InfoData: Pointer;
   InfoSize: LongInt;
   Len: DWORD;
   FName: Pchar;
   SystemDir, Infotype: string;
   LangPtr: Pointer;
begin
   Len := MAX_PATH + 1;
   GetMem(SysDir, Len);
   try
      if Windows.GetSystemDirectory(SysDir, Len) <> 0 then
         SystemDir := SysDir;
   finally
      FreeMem(SysDir);
   end;
   result := '';
   InfoType := 'FileVersion';
   FName := Pchar(SystemDir + '\shdocvw.dll');
   InfoSize := GetFileVersionInfoSize(Fname, Len);
   if (InfoSize > 0) then
      begin
         GetMem(Info, InfoSize);
         try
            if GetFileVersionInfo(FName, Len, InfoSize, Info) then
               begin
                  Len := 255;
                  if VerQueryValue(Info, '\VarFileInfo\Translation', LangPtr, Len) then
                     InfoType := Format('\StringFileInfo\%0.4x%0.4x\%s'#0, [LoWord(LongInt(LangPtr^)),
                        HiWord(LongInt(LangPtr^)), InfoType]);
                  if VerQueryValue(Info, Pchar(InfoType), InfoData, len) then
                     Result := strPas(InfoData);
               end;
         finally
            FreeMem(Info, InfoSize);
         end;
      end;
end;

function ResolveUrlIni(Filename: string): string;
var
   ini: TiniFile;
begin
   result := '';
   ini := TIniFile.create(fileName);
   try
      result := ini.ReadString('InternetShortcut', 'URL', '');
   finally
      ini.free;
   end;
end;

function ResolveUrlIntShCut(Filename: string): string;
var
   IURL: IUniformResourceLocator;
   PersistFile: IPersistfile;
   FName: array[0..MAX_PATH] of WideChar;
   p: Pchar;
begin
   if Succeeded(CoCreateInstance(CLSID_InternetShortcut, nil, CLSCTX_INPROC_SERVER,
      IID_IUniformResourceLocator, IURL))
      then
      begin
         Persistfile := IUrl as IPersistFile;
         StringToWideChar(FileName, FName, MAX_PATH);
         PersistFile.Load(Fname, STGM_READ);
         IUrl.geturl(@P);
         Result := P;
      end;
end;

function ResolveChannel(pFolder: IShellFolder; pidl: PItemIDList; var lpszURL: string): HRESULT;
var
   pidlChannel: PItemIDList;
   psfDesktop: IShellFolder;
   pShellLink: IShellLink;
begin
   Result := S_FALSE;
   if Succeeded(pFolder.GetUIObjectOf(0, 1, pidl, IShellLink, nil, Pointer(pShellLink)))
      then
      if Succeeded(pShellLink.GetIDList(pidlChannel)) then
         if Succeeded(SHGetDesktopFolder(psfDesktop))
            then
            begin
               lpszURL := getDisplayName(psfDesktop, PidlChannel);
               Result := S_OK;
            end;
   DisposePidl(PidlChannel);
end;

function ResolveLink(const path: string): string;
var
   link: IShellLink;
   storage: IPersistFile;
   filedata: TWin32FindData;
   buf: array[0..MAX_PATH] of Char;
   widepath: WideString;
begin
   OleCheck(CoCreateInstance(CLSID_ShellLink, nil, CLSCTX_INPROC_SERVER, IShellLink, link));
   OleCheck(link.QueryInterface(IPersistFile, storage));
   widepath := path;
   Result := '';
   if Succeeded(storage.Load(@widepath[1], STGM_READ)) then
      if Succeeded(link.Resolve(GetActiveWindow, SLR_NOUPDATE)) then
         if Succeeded(link.GetPath(buf, sizeof(buf), filedata, SLGP_UNCPRIORITY)) then
            Result := buf;
   storage := nil;
   link := nil;
end;

function IsFolder(ShellFolder: IShellFolder; ID: PItemIDList): Boolean;
var
   Flags: UINT;
begin
   Flags := SFGAO_FOLDER;
   ShellFolder.GetAttributesOf(1, ID, Flags);
   Result := SFGAO_FOLDER and Flags <> 0;
end;

function IsChannel(ChannelShortcut: string; ShellFolder: IShellFolder; ID: PItemIDList): Boolean;
var
   FileInfo: TShFileInfo;
begin
   SHGetFileInfo(Pchar(ID), 0, FileInfo, SizeOf(TSHFileInfo), SHGFI_PIDL or SHGFI_TYPENAME);
   Result := BOOL(fileinfo.szTypeName = ChannelShortcut);
end;

function IsFolderEx(ChannelShortcut: string; ShellFolder: IShellFolder; ID: PItemIDList): Boolean;
var
   Flags: UINT;
begin
   Flags := SFGAO_FOLDER;
   ShellFolder.GetAttributesOf(1, ID, Flags);
   if SFGAO_FOLDER and Flags <> 0 then
      result := not isChannel(ChannelShortcut, Shellfolder, id)
   else
      Result := False;
end;

function GetImageIndex(pidl: PItemIDList): integer;
var
   Flags: UINT;
   FileInfo: TSHFileInfo;
begin
   Flags := SHGFI_PIDL or SHGFI_SYSICONINDEX or SHGFI_ICON or SHGFI_SMALLICON;
   if SHGetFileInfo(PChar(pidl), 0, FileInfo, SizeOf(TSHFileInfo), Flags) = 0 then
      Result := -1
   else
      Result := FileInfo.iIcon;
end;

function GetDisplayName(Folder: IShellFolder; pidl: PItemIDList): string;
var
   StrRet: TStrRet;
begin
   Folder.GetDisplayNameOf(pidl, SHGDN_NORMAL, StrRet);
   case StrRet.uType of
      STRRET_CSTR:
         SetString(Result, StrRet.cStr, lStrLen(StrRet.cStr));
      STRRET_OFFSET:
         Result := Pchar(@pidl.mkid.abID[StrRet.uOffset - SizeOf(pidl.mkid.cb)]);
      STRRET_WSTR:
         Result := StrRet.pOleStr;
   end;
end;

function GetFileName(Folder: IShellFolder; pidl: PItemIDList): string;
var
   StrRet: TStrRet;
begin
   Folder.GetDisplayNameOf(pidl, SHGDN_FORPARSING, StrRet);
   case StrRet.uType of
      STRRET_CSTR:
         SetString(Result, StrRet.cStr, lStrLen(StrRet.cStr));
      STRRET_OFFSET:
         Result := Pchar(@pidl.mkid.abID[StrRet.uOffset - SizeOf(pidl.mkid.cb)]);
      STRRET_WSTR:
         Result := StrRet.pOleStr;
   end;
end;

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

function DeleteUrl(Url: PWideChar): HResult;
begin
   Result := DeleteUrl(Url);
end;

function GetMailClients: TStrings;
var
   reg: TRegistry;
   ts: TStrings;
   i: integer;
begin
   ts := TStringList.Create;
   ts.Clear;
   reg := TRegistry.Create;
   reg.RootKey := HKEY_CURRENT_USER;
   reg.OpenKey(RegMail, false);
   if reg.HasSubKeys then
      begin
         reg.GetKeyNames(ts);
         reg.CloseKey;
         for i := 0 to ts.Count - 1 do
            begin
               reg.OpenKey(RegMail + ts.Strings[i], false);
            end;
      end;
   if ts.GetText = '' then
      ts.Text := ('We could not find your mail clients.');
   result := ts;
   reg.CloseKey;
   reg.free;
end;

end.

