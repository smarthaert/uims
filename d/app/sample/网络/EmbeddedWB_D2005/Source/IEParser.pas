//****************************************************
//             Extended IEParser                     *
//      For Delphi 4, 5, 6, 7, 2005, 2006            *
//                Freeware Component                 *
//                   by                              *
//                                                   *
//        Per Lindsø Larsen                          *
//        Modified : Marc Hervais                    *
//   http://www.euromind.com/iedelphi                *
//                                                   *
// Contributor:                                      *
// Eran Bodankin (bsalsa) - D2005 update and bug fix *
//  bsalsa@bsalsa.com                                *
//                                                   *
// Documentation and updated versions:               *
//               http://www.bsalsa.com               *
//****************************************************

{*******************************************************************************}
{LICENSE:
THIS SOFTWARE IS PROVIDED TO YOU "AS IS" WITHOUT WARRANTY OF ANY KIND,
EITHER EXPRESSED OR IMPLIED INCLUDING BUT NOT LIMITED TO THE APPLIED
WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
YOU ASSUME THE ENTIRE RISK AS TO THE ACCURACY AND THE USE OF THE SOFTWARE
AND ALL OTHER RISK ARISING OUT OF THE USE OR PERFORMANCE OF THIS SOFTWARE
AND DocUMENTATION. [YOUR Name] DOES NOT WARRANT THAT THE SOFTWARE IS ERROR-FREE
OR WILL OPERATE WITHOUT INTERRUPTION. THE SOFTWARE IS NOT DESIGNED, INTENDED
OR LICENSED FOR USE IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE CONTROLS,
INCLUDING WITHOUT LIMITATION, THE DESIGN, CONSTRUCTION, MAINTENANCE OR
OPERATION OF NUCLEAR FACILITIES, AIRCRAFT NAVIGATION OR COMMUNICATION SystemS,
AIR TRAFFIC CONTROL, AND LIFE SUPPORT OR WEAPONS SystemS. VSOFT SPECIFICALLY
DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF FITNESS FOR SUCH PURPOSE.

You may use, change or modify the component under 3 conditions:
1. In your website, add a Link to "http://www.bsalsa.com"
2. In your application, add credits to "Embedded Web Browser"
3. Mail me  (bsalsa@bsalsa.com) any code change in the unit
   for the benefit of the other users.
4. You may consider donation in our web site!
{*******************************************************************************}

unit IEParser;

{$I EWB.inc}

interface

uses
   Windows, Mshtml_Ewb, ActiveX, Classes;

type
   TDownloadControlOption = (
      DownloadImages, DownloadVideos, DownloadBGSounds, DontExecuteScripts,
      DontExecuteJava, DontExecuteActiveX, DontDownloadActiveX,
      DownloadButDontDisplay, DontDownloadFrame, CheckPageResynchronize,
      DownloadAndIgnoreCache, DontDownloadBehaviors, SuppressedMetaCharset,
      DisableUrlIfEncodingUTF8, EnableUrlIfEncodingUTF8,
      ForceOfflineMode, DontPerformClientPull, DonloadInSilentMode, WorkOffline);

   TDownloadControlOptions = set of TDownloadControlOption;

   TElementInfo = record
      ClassName: string;
      Id: string;
      InnerHTML: string;
      InnerText: string;
      Lang: string;
      Language: string;
      OffsetHeight: Integer;
      OffsetLeft: Integer;
      OffsetTop: Integer;
      OffsetWIdth: Integer;
      OuterHTML: string;
      OuterText: string;
      RecordNumber: OleVariant;
      SourceIndex: Integer;
      TagName: string;
      Title: string;
   end;

   TMessages = class(TPersistent)
   private
      FErrorText: WideString;
      FShowErrorMessage: Boolean;
      FShowStatusText: Boolean;
      FStartText: WideString;
      FSuccessText: WideString;
   published
      property ErrorText: WideString read FErrorText write FErrorText;
      property ShowErrorMessage: Boolean read FShowErrorMessage write FShowErrorMessage default False;
      property ShowStatusText: Boolean read FShowStatusText write FShowStatusText default True;
      property StartText: WideString read FStartText write FStartText;
      property SuccessText: WideString read FSuccessText write FSuccessText;
   end;

   TOnStatusTextEvent = procedure(Text: string) of object;
   TOnDocInfoEvent = procedure(Text: string) of object;
   TOnDownloadCompleteEvent = procedure(Sender: TObject) of object;
   TOnBREvent = procedure(Sender: TObject; Clear: string; Element: TElementInfo) of object;
   TOnHREvent = procedure(Sender: TObject; Align: string; Color, Width, Size:
      OleVariant; NoShade: Boolean; Element: TElementInfo) of object;
   TOnDIVEvent = procedure(Sender: TObject; Align: string; NoWrap: Boolean;
      Element: TElementInfo) of object;
   TOnScriptEvent = procedure(Sender: Tobject; Source, HtmlFor, Event, Text: string;
      Defer: Boolean; Element: TElementInfo) of object;
   TOnFormEvent = procedure(Sender: TObject; Action, Dir, Encoding, Method, Target, Name: string;
      Element: TElementInfo) of object;
   TOnMarqueeEvent = procedure(Sender: TObject; bgColor, Width, Height: OleVariant;
      Direction, Behavior: string; ScrollAmount, ScrollDelay, Loop, vSpace, hSpace:
      Integer; Element: TElementInfo) of object;
   TOnFontEvent = procedure(Sender: TObject; Color, Size: OleVariant; Face: string;
      Element: TElementInfo) of object;
   TOnBaseFontEvent = procedure(Sender: TObject; Color: OleVariant; Face: string;
      Size: Integer; Element: TElementInfo) of object;
   TOnBaseEvent = procedure(Sender: TObject; hRef, Target: string; Element: TElementInfo) of object;
   TOnMetaEvent = procedure(Sender: TObject; HttpEquiv, Content, Name, URL, Charset:
      string; Element: TElementInfo) of object;
   TOnBodyEvent = procedure(Sender: TObject; Background, bgProperties: string; LeftMargin,
      TopMargin, RightMargin, BottomMargin, bgColor, Text, Link, vLink, aLink: OleVariant;
      NoWrap: Boolean; Element: TElementInfo) of object;
   TOnImageEvent = procedure(Sender: TObject; Source, LowSrc, Vrml, DynSrc, Alt, Align,
      UseMap: string; IsMap: Boolean; Border, Loop: OleVariant; vSpace, hSpace, Width,
      Height: Integer; Element: TElementInfo) of object;
   TOnAnchorEvent = procedure(Sender: TObject; hRef, Target, Rel, Rev, Urn, Methods, Name,
      Host, HostName, PathName, Port, Protocol, Search, Hash, AccessKey, ProtocolLong,
      MimeType, NameProp: string; Element: TElementInfo) of object;
   TOnCommentEvent = procedure(sender: TObject; Text: string; Element: TElementInfo) of object;
   TOnElementEvent = procedure(Sender: TObject; ElementInfo: TElementInfo) of object;
   TNoFramesEvent = procedure(Sender: TObject; ELement: TElementInfo) of object;
   TOnFrameEvent = procedure(Sender: TObject; Source, Name: OleVariant; Element:
      TElementInfo) of object;
   TOnFrameSetEvent = procedure(Sender: TObject; Rows, Cols, FrameBorder, Name:
      WIdeString; Border, BorderColor, FrameSpacing: OleVariant; Element:
      TelementInfo) of object;

   TIEParser = class(TComponent, IUnknown, Idispatch, IPropertyNotifySink, IOleClientSite)
   private
      FBusy: Boolean;
      FHtml: WIdeString;
      FMessages: TMessages;
      FOnBusy: TNotifyEvent;
      FOnDocInfo: TOnDocInfoEvent;
      FOnFrame: TOnFrameEvent;
      FOnFrameset: TOnFrameSetEvent;
      FOnNoFrame: TNoFramesEvent;
      FOnStatusText: TOnStatusTextEvent;
      FParseNoFrames: Boolean;
      FSaveLog: Boolean;
      StartTick: Int64;
      function UpdateDownloadControlValue: LongInt;
   protected
      Element: TElementInfo;
      FAbout: string;
      FAnchor: TOnAnchorEvent;
      FBase: TOnBaseEvent;
      FBaseFont: TOnBaseFontEvent;
      FBody: TOnBodyEvent;
      FBr: TOnBREvent;
      FComment: TOnCommentEvent;
      FDiv: TOnDIVEvent;
      FDownLoadComplete: TOnDownloadCompleteEvent;
      FDownloadControlOptions: TDownloadControlOptions;
      FDownloadOnly: Boolean;
      FElement: TOnElementEvent;
      FFont: TOnFontEvent;
      FForm: TOnFormEvent;
      FHr: TOnHREvent;
      FImage: TOnImageEvent;
      FLocalFileName: WideString;
      FMarquee: TOnMarqueeEvent;
      FMeta: TOnMetaEvent;
      FRefCount: Integer;
      FSaveLogAs: WideString;
      FScript: TOnScriptEvent;
      FURL: string;
      _URL: PWIdeChar;
      function GetContainer(out container: IOleContainer): HResult; stdcall;
      function GetMoniker(dwAssign: Longint; dwWhichMoniker: Longint; out mk: IMoniker):
         HResult; stdcall;
      function Invoke(DispId: Integer; const IId: TGUId; LocaleId: Integer; Flags: Word;
         var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
      function LoadFromString: HResult;
      function LoadUrlFromMoniker: HResult;
      function OnChanged(dispId: TDispId): HResult; stdcall;
      function OnRequestEdit(dispId: TDispId): HResult; stdcall;
      function OnShowWindow(fShow: BOOL): HResult; stdcall;
      function RequestNewObjectLayout: HResult; stdcall;
      function SaveObject: HResult; stdcall;
      function ShowObject: HResult; stdcall;
      procedure BusyChange; dynamic;
      procedure GetPageProperties;
      procedure SetAbout(Value: string);
      procedure SetURL;
      procedure UpdateErrorEvent(Text: string);
   public
      All: IHtmlElementCollection;
      Doc: IhtmlDocument2;
      constructor Create(Owner: Tcomponent); override;
      destructor Destroy; override;
      procedure Loaded; override;
      procedure Go;
      property Busy: Boolean read FBusy write FBusy default False;
   published
      property About: string read FAbout write SetAbout;
      property DownloadOnly: Boolean read FDownloadOnly write FDownloadOnly default false;
      property DownloadOptions: TDownloadControlOptions read FDownloadControlOptions write FDownloadControlOptions
         default [DownloadImages, DownloadBGSounds,
         DownloadVideos, DownloadButDontDisplay, DontExecuteScripts,
         DontExecuteJava, DontExecuteActiveX, DontDownloadActiveX];
      property Html: WIdeString read FHtml write FHtml;
      property LocalFileName: WideString read FLocalFileName write FLocalFileName;
      property Messages: TMessages read FMessages write FMessages;
      property OnAnchor: TOnAnchorEvent read FAnchor write FAnchor;
      property OnBase: TOnBaseEvent read FBase write FBase;
      property OnBaseFont: TOnBaseFontEvent read FBaseFont write FBaseFont;
      property OnBody: TOnBodyEvent read FBody write FBody;
      property OnBR: TOnBREvent read FBr write FBr;
      property OnBusyStateChange: TNotifyEvent read FOnBusy write FOnBusy;
      property OnComment: TOnCommentEvent read FComment write FComment;
      property OnDiv: TOnDIVEvent read FDiv write FDiv;
      property OnDocInfo: TOnDocInfoEvent read FOnDocInfo write FOnDocInfo;
      property OnDownloadComplete: TOnDownloadCompleteEvent read FDownLoadComplete write FDownLoadComplete;
      property OnElement: TOnElementEvent read FElement write FElement;
      property OnFont: TOnFontEvent read FFont write FFont;
      property OnForm: TOnFormEvent read FForm write FForm;
      property OnFrame: TOnFrameEvent read FOnFrame write FOnFrame;
      property OnFrameSet: TOnFrameSetEvent read FOnFrameset write FOnFrameset;
      property OnHR: TOnHREvent read FHr write FHr;
      property OnImage: TOnImageEvent read FImage write FImage;
      property OnMarquee: TOnMarqueeEvent read FMarquee write FMarquee;
      property OnMeta: TOnMetaEvent read FMeta write FMeta;
      property OnNoFrame: TNoFramesEvent read FOnNoFrame write FOnNoFrame;
      property OnScript: TOnScriptEvent read FScript write FScript;
      property OnStatusText: TOnStatusTextEvent read FOnStatusText write FOnStatusText;
      property SaveLog: Boolean read FSaveLog write FSaveLog default False;
      property SaveLogAs: WideString read FSaveLogAs write FSaveLogAs;
      property URL: string read FURL write FURL;
      property ParseNoFrames: Boolean read FParseNoFrames write FParseNoFrames default False;
   end;

implementation

uses
   Dialogs, IEConst, SysUtils, Urlmon, ComObj;

//**** Accesories **************************************************************

function IsValidURL(const URL: Widestring): Boolean;
begin
   if UrlMon.IsValidURL(nil, PWideChar(URL), 0) = S_OK then
      Result := True
   else
      Result := False;
end;

function FormatTickToTime(TickCount: Cardinal): string;
var
   Hours, Minutes, Seconds, MSecs: Cardinal;
   S_HUR, S_MIN, S_SEC, S_MSC: string;
begin
   S_MSC := '000';
   S_SEC := '00';
   S_MIN := '00';
   S_HUR := '00';
   try
      if (TickCount > 0) then
         begin
            MSecs := TickCount mod MSecsPerSec;
            TickCount := TickCount div MSecsPerSec;
            S_MSC := Format('%.3d', [MSecs]);
            Seconds := TickCount mod SecsPerMin;
            TickCount := TickCount div SecsPerMin;
            S_SEC := Format('%.2d', [Seconds]);
            Minutes := TickCount mod MinsPerHour;
            TickCount := TickCount div MinsPerHour;
            S_MIN := Format('%.2d', [Minutes]);
            Hours := TickCount mod HoursPerDay;
            S_HUR := Format('%.2d', [Hours]);
         end;
   finally
      if S_HUR = '00' then
         Result := S_MIN + 'm :' + S_SEC + 's :' + S_MSC + 'ms';
      if (S_HUR = '00') and (S_MIN = '00') then
         Result := S_SEC + 's :' + S_MSC + 'ms';
      if S_HUR <> '00' then
         Result := S_HUR + 'h :' + S_MIN + 'm :' + S_SEC + 's :' + S_MSC + 'ms';
   end;
end;

function StrToCase(StringOf: string; CasesList: array of string): Integer;
var
   Idx: integer;
begin
   Result := -1;
   for Idx := 0 to Length(CasesList) - 1 do
      begin
         if CompareText(StringOf, CasesList[Idx]) = 0 then
            begin
               Result := Idx;
               Break;
            end;
      end;
end;

//**End Of Accesories***********************************************************

function TIEParser.GetContainer(out container: IOleContainer): HResult;
begin
   Result := E_NOTIMPL;
end;

function TIEParser.GetMoniker(dwAssign: Longint; dwWhichMoniker: Longint; out mk:
   IMoniker): HResult;
begin
   Result := E_NOTIMPL;
end;

function TIEParser.Invoke(DispId: Integer; const IId: TGUId; LocaleId: Integer;
   Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var
   I: Integer;
begin
   if DispId = DISPId_AMBIENT_DLCONTROL then
      begin
         i := UpdateDownloadControlValue;
         PVariant(VarResult)^ := I;
         Result := S_OK;
      end
   else
      Result := DISP_E_MEMBERNOTFOUND;
end;

function TIEParser.LoadFromString: HResult;
var
   V: OLEVariant;
   vDocument: OLEVariant;
   vMimeType: OLEVariant;
   vHtml: OLEVariant;
begin
   if FHtml = '' then
      begin
         UpdateErrorEvent('loading the Html strings.');
         Result := E_FAIL;
         Exit;
      end;
   try
    //Stop any actions - this is important!
    // FWeb.Stop;   no dealing with the Document directly
    // Grab the Document
      V := Doc;
      vDocument := V.script.Document;
      vMimeType := 'text/Html';
      vHtml := FHtml;
      vDocument.Open(vMimeType);
      vDocument.Clear;
      vDocument.Write(vHtml);
      vDocument.Close;
      Result := S_OK;
   except
      Result := E_FAIL;
   end;
end;

function TIEParser.LoadUrlFromMoniker: HResult;
var
   Mon: IMoniker;
   BndCtx: IBindCTX;
begin
   if CreateURLMoniker(nil, _Url, Mon) <> S_OK then
      begin
         UpdateErrorEvent('creating moniker.');
         Result := E_FAIL;
         Exit;
      end;
   if CreateBindCtx(0, BndCtx) = S_OK then
      Result := (Doc as IpersistMoniker).Load(LongBool(0), Mon, BndCtx, STGM_READ)
   else
      begin
         UpdateErrorEvent('load Url from moniker.');
         Result := E_FAIL;
      end;
end;

function TIEParser.OnChanged(dispId: TDispId): HResult;
var
   DP: TDispParams;
   vResult: OLEVariant;
begin
   if (DISPId_READYSTATE = DispId) then
      if SUCCEEDED((Doc as IHtmlDocument2).Invoke(DISPId_READYSTATE, GUId_null,
         LOCALE_System_DEFAULT, DISPATCH_PROPERTYGET, DP, @vResult, nil, nil)) then
         if Integer(vResult) = READYSTATE_COMPLETE then
            PostThreadMessage(GetCurrentThreadId(), WM_USER_STARTWALKING, 0, 0);
   Result := S_OK;
end;

function TIEParser.OnRequestEdit(dispId: TDispId): HResult;
begin
   Result := E_NOTIMPL;
end;

function TIEParser.OnShowWindow(fShow: BOOL): HResult;
begin
   Result := E_NOTIMPL;
end;

function TIEParser.RequestNewObjectLayout: HResult;
begin
   Result := E_NOTIMPL;
end;

function TIEParser.SaveObject: HResult;
begin
   Result := E_NOTIMPL;
end;

function TIEParser.ShowObject: HResult;
begin
   Result := E_NOTIMPL;
end;

function TIEParser.UpdateDownloadControlValue: LongInt;
const
   AcardDownloadControlValues: array[TDownloadControlOption] of Cardinal =
   ($00000010, $00000020, $00000040, $00000080,
      $00000100, $00000200, $00000400, $00000800,
      $00001000, $00002000, $00004000, $00008000,
      $00010000, $00020000, $00040000, $10000000,
      $20000000, $40000000, $80000000);
var
   i: TDownloadControlOption;
   j: Longint;
begin
   j := 0;
   if (FDownloadControlOptions <> []) then
      for i := Low(TDownloadControlOption) to High(TDownloadControlOption)
         do
         if (i in FDownloadControlOptions) then
            Inc(j, AcardDownloadControlValues[i]);
   Result := j;
end;

constructor TIEParser.Create(Owner: Tcomponent);
begin
   inherited Create(Owner);
   FAbout := 'TIEParser from: http://www.bsalsa.com';
   FMessages := TMessages.Create;
   FMessages.FShowStatusText := True;
   FMessages.StartText := 'Please wait.. ';
   FMessages.SuccessText := 'Done. ';
   FMessages.ErrorText := 'An error occured while ';
   DownloadOptions := [DownloadImages, DownloadBGSounds,
      DownloadVideos, DownloadButDontDisplay, DontExecuteScripts,
      DontExecuteJava, DontExecuteActiveX, DontDownloadActiveX];
end;

destructor TIEParser.Destroy;
begin
   if Assigned(doc) then
      doc._Release;
   Busy := False;
   FBusy := Busy;
   FMessages.Free;
end;

procedure TIEParser.Loaded;
begin
   inherited Loaded;
   Busy := False;
   FBusy := Busy;
end;

procedure TIEParser.BusyChange;
begin
   if Assigned(FOnBusy) then
      FOnBusy(Self);
end;

procedure TIEParser.SetAbout(Value: string);
begin
   Exit;
end;

procedure TIEParser.SetURL;
begin
   if FURL = '' then
      FURL := FLocalFileName;
end;

procedure TIEParser.GetPageProperties;
var
   sl: TStringList;
   st: WideString;
begin
   if (doc <> nil) and (Assigned(Doc)) and (Doc.readyState = 'complete') then
      try
         sl := TStringList.Create;
         with sl do
            try
               st := 'Document URL: ' + Doc.url;
               if FSaveLog then
                  Add(st);
               if (Assigned(FOnDocInfo)) then
                  FOnDocInfo(st);
               st := 'Document Title: ' + Doc.title;
               if FSaveLog then
                  Add(st);
               if (Assigned(FOnDocInfo)) then
                  FOnDocInfo(st);
               st := 'Document Protocol: ' + Doc.protocol;
               if FSaveLog then
                  Add(st);
               if (Assigned(FOnDocInfo)) then
                  FOnDocInfo(st);
               st := 'Document Location: ' + Doc.location.href;
               if FSaveLog then
                  Add(st);
               if (Assigned(FOnDocInfo)) then
                  FOnDocInfo(st);
               st := 'Document Path Name: ' + Doc.location.pathname;
               if FSaveLog then
                  Add(st);
               if (Assigned(FOnDocInfo)) then
                  FOnDocInfo(st);
               st := 'Document Port: ' + Doc.location.port;
               if FSaveLog then
                  Add(st);
               if (Assigned(FOnDocInfo)) then
                  FOnDocInfo(st);
               st := 'Document Protocol: ' + Doc.location.protocol;
               if FSaveLog then
                  Add(st);
               if (Assigned(FOnDocInfo)) then
                  FOnDocInfo(st);
               st := 'Document Host: ' + Doc.location.host;
               if FSaveLog then
                  Add(st);
               if (Assigned(FOnDocInfo)) then
                  FOnDocInfo(st);
               st := 'Document Hash: ' + Doc.location.hash;
               if FSaveLog then
                  Add(st);
               if (Assigned(FOnDocInfo)) then
                  FOnDocInfo(st);
               st := 'Document Search: ' + Doc.location.search;
               if FSaveLog then
                  Add(st);
               if (Assigned(FOnDocInfo)) then
                  FOnDocInfo(st);
               st := 'Document Last Modified: ' + Doc.lastModified;
               if FSaveLog then
                  Add(st);
               if (Assigned(FOnDocInfo)) then
                  FOnDocInfo(st);
               st := 'Document Domain: ' + Doc.domain;
               if FSaveLog then
                  Add(st);
               if (Assigned(FOnDocInfo)) then
                  FOnDocInfo(st);
               st := 'Document Security: ' + Doc.security;
               if FSaveLog then
                  Add(st);
               if (Assigned(FOnDocInfo)) then
                  FOnDocInfo(st);
               st := 'Document Name Property: ' + Doc.nameProp;
               if FSaveLog then
                  Add(st);
               if (Assigned(FOnDocInfo)) then
                  FOnDocInfo(st);
               st := 'Document Language: ' + Doc.Body.language;
               if FSaveLog then
                  Add(st);
               if (Assigned(FOnDocInfo)) then
                  FOnDocInfo(st);
               st := 'Document Lang: ' + Doc.Body.lang;
               if FSaveLog then
                  Add(st);
               if (Assigned(FOnDocInfo)) then
                  FOnDocInfo(st);
               st := 'Document Design Mode: ' + Doc.designMode;
               if FSaveLog then
                  Add(st);
               if (Assigned(FOnDocInfo)) then
                  FOnDocInfo(st);
               st := 'Document Charset: ' + Doc.charset;
               if FSaveLog then
                  Add(st);
               if (Assigned(FOnDocInfo)) then
                  FOnDocInfo(st);
               st := 'Document Default Charset: ' + Doc.defaultCharset;
               if FSaveLog then
                  Add(st);
               if (Assigned(FOnDocInfo)) then
                  FOnDocInfo(st);
               st := 'Document Cookie: ' + Doc.cookie;
               if FSaveLog then
                  Add(st);
               if (Assigned(FOnDocInfo)) then
                  FOnDocInfo(st);
               st := 'Document Referrer: ' + Doc.Referrer;
               if FSaveLog then
                  Add(st);
               if (Assigned(FOnDocInfo)) then
                  FOnDocInfo(st);
               st := 'Document Doc State: ' + Doc.readyState;
               if FSaveLog then
                  Add(st);
               if (Assigned(FOnDocInfo)) then
                  FOnDocInfo(st);
           {st := 'Document Mime Type: '+ Doc.mimeType;
           st := 'Document File Size: '+ Doc.fileSize;
           st := 'Document File Created Date: '+ Doc.fileCreatedDate;
           st := 'Document File Modified Date: '+ Doc.fileModifiedDate;
           st := 'Document File Updated Date: '+ Doc.fileUpdatedDate;}
            finally
               try
                  if FSaveLog then
                     if (FSaveLogAs <> '') then
                        sl.SaveToFile(FSaveLogAs)
                     else
                        UpdateErrorEvent('validating log file name and path.');
               except
                  UpdateErrorEvent('getting the document info.');
               end;
               sl.Free;
            end;
      except
         Exit;
      end;
end;

procedure TIEParser.Go;
var
   E: IHtmlElement;
   X, C: Integer;
   ConnectionPoint: IConnectionPoint;
   OleChar: array[0..MAX_PATH - 1] of TOleChar;
   Msg: TMsg;
   hr: HResult;
   v, u: OLEVariant;
   BoolWorking, NoFramesFound, LoadingFromString: Boolean;
   ParseTime, NoFramesContent, Us: string;
begin
   FBusy := True;
   BusyChange;
   StartTick := GetTickCount;
   if FMessages.FShowStatusText and Assigned(FOnStatusText) then
      FOnStatusText(FMessages.FStartText);
   SetURL;
   LoadingFromString := System.False;
   NoFramesFound := System.False;
   CoInitialize(nil);
   if CoCreateInstance(CLASS_HtmlDocument, nil, CLSCTX_INPROC_SERVER,
      IHtmlDocument2, Doc) <> S_OK then
      begin
         UpdateErrorEvent('creating the class.');
         Exit;
      end;
   _Url := @OleChar;
   if MultibytetoWIdeChar(CP_ACP, 0, PChar(FURL), -1, _Url, Sizeof(OleChar)) = 0
      then
      begin
         UpdateErrorEvent('translating the URL.');
         Exit;
      end;
   if (Doc as IOleObject).SetClientSite(Self as IOleClientsite) <> S_OK then
      begin
         UpdateErrorEvent('setting client side.');
         Exit;
      end;
   if (Doc as IOleControl).OnAmbientPropertyChange(DISPId_AMBIENT_DLCONTROL) <> S_OK then
      begin
         UpdateErrorEvent('setting download options.');
         Exit;
      end;
   if (Doc as IConnectionPointContainer).FindConnectionPoint(IpropertyNotifySink, ConnectionPoint) <> S_OK then
      begin
         UpdateErrorEvent('setting connection point.');
         Exit;
      end;

   if ConnectionPoint.Advise(Self as IPropertyNotifySink, C) <> S_OK then
      begin
         UpdateErrorEvent('negotiation with remote site.');
         Exit;
      end;
   NoFramesContent := '';
   if FURL <> '' then
      begin
         if IsValidURL(FURL) then
            HR := LoadUrlFromMoniker
         else
            begin
               UpdateErrorEvent('validating the URL.');
               Exit;
            end;
      end
   else
      HR := LoadFromString;
   BoolWorking := System.True;
   if (Doc = nil) then
      begin
         UpdateErrorEvent('can not load the document.');
         Exit;
      end;
   if SUCCEEDED(HR) {or (HR = E_PENDING))} then
      while (BoolWorking and GetMessage(Msg, 0, 0, 0)) do
         begin
            if ((Msg.Message = WM_USER_STARTWALKING) and (Msg.hWnd = 0)) then
               begin
                  BoolWorking := System.False;
                  All := Doc.Get_all;
                  if (All <> nil) and (All.length <= 4) then
                     begin
                        UpdateErrorEvent('bad document or bad Address.');
                        Exit;
                     end;
                  if (All <> nil) and not FDownloadOnly then
                     for x := 0 to All.length - 1 do
                        begin
                           E := All.Item(x, 0) as IHtmlElement;
                           with Element do
                              begin
                                 ClassName := E.ClassName;
                                 Id := E.Id;
                                 TagName := E.TagName;
                                 Title := E.Title;
                                 Language := E.Language;
                                 SourceIndex := E.SourceIndex;
                                 RecordNumber := E.RecordNumber;
                                 Lang := E.Lang;
                                 OffsetLeft := E.OffsetLeft;
                                 OffsetTop := E.OffsetTop;
                                 OffsetWidth := E.OffsetWidth;
                                 OffsetHeight := E.OffsetHeight;
                                 InnerHtml := E.InnerHtml;
                                 InnerText := E.InnerText;
                                 OuterHtml := E.OuterHtml;
                                 OuterText := E.OuterText;
                              end;
                           if Assigned(FElement) then
                              FElement(Self, Element);

                           case StrToCase(E.TagName, ['FRAMESET', 'FRAME', 'NOFRAMES', 'A', '!',
                              'COMMENT', 'IMG', 'BODY', 'BASE', 'BASEFONT', 'FONT', 'META', 'MARQUEE',
                                 'FORM', 'SCRIPT', 'DIV', 'HR', 'BR']) of
                              0:
                                 begin
                                    if Assigned(FOnFrameSet) then
                                       with All.Item(x, 0) as IHtmlFrameSetElement do
                                          FOnFrameSet(Self, Rows, Cols, FrameBorder, Name,
                                             Border, BorderColor, FrameSpacing, Element);

                                 end;
                              1:
                                 begin
                                    if Assigned(FOnFrame) then
                                       begin
                                          v := E.GetAttribute('Name', 0);
                                          u := E.GetAttribute('Source', 0);
                                          Us := u;
                                          if LoadingFromString and (Pos('about:blank', LowerCase(Us)) > 0) then
                                             Delete(Us, 1, 11);
                                          FOnFrame(Self, Us, v, Element);
                                       end;
                                 end;
                              2:
                                 begin
                                    NoFramesContent := E.InnerHtml;
                                    if Assigned(FOnNoFrame) then
                                       FOnNoFrame(Self, Element);
                                 end;
                              3:
                                 begin
                                    if Assigned(FAnchor) then
                                       with All.Item(x, 0) as IHtmlAnchorElement do
                                          begin
                                             Us := hRef;
                                             if LoadingFromString and (Pos('about:blank', LowerCase(Us)) > 0) then
                                                Delete(Us, 1, 11);
                                             FAnchor(Self, Us, Target, Rel, Rev, Urn, Methods,
                                                Name, Host, HostName, PathName, Port, Protocol,
                                                Search, Hash, AccessKey,
                                                ProtocolLong, MimeType, NameProp, Element);
                                          end;
                                 end;
                              4 or 5:
                                 begin
                                    if Assigned(FComment) then
                                       with All.Item(x, 0) as IHtmlCommentElement do
                                          FComment(Self, Text, Element)
                                    else
                                       if (E.TagName = 'IMG') and Assigned(FImage) then
                                          with All.Item(x, 0) as IHtmlImgElement do
                                             begin
                                                Us := Src;
                                                if LoadingFromString and (Pos('about:blank', LowerCase(Us)) > 0) then
                                                   Delete(Us, 1, 11);
                                                FImage(Self, Us, LowSrc, Vrml, DynSrc,
                                                   Alt, Align, UseMap, IsMap, Border, Loop,
                                                   vSpace, hSpace, Width, Height, Element);
                                             end;
                                 end;

                              6:
                                 begin
                                    if Assigned(FImage) then
                                       with All.Item(x, 0) as IHtmlImgElement do
                                          begin
                                             Us := Src;
                                             if LoadingFromString and (Pos('about:blank', LowerCase(Us)) > 0) then
                                                Delete(Us, 1, 11);
                                             FImage(Self, Us, LowSrc, Vrml, DynSrc,
                                                Alt, Align, UseMap, IsMap, Border, Loop,
                                                vSpace, hSpace, Width, Height, Element);
                                          end;
                                 end;
                              7:
                                 begin
                                    if Assigned(FBody) then
                                       with All.Item(x, 0) as IHtmlBodyElement do
                                          FBody(Self, Background, bgProperties,
                                             LeftMargin, TopMargin, RightMargin, BottomMargin, bgColor, Text, Link,
                                             vLink, aLink, NoWrap, Element);
                                 end;
                              8:
                                 begin
                                    if Assigned(FBase) then
                                       with All.Item(x, 0) as IHtmlBaseElement do
                                          begin
                                             Us := hRef;
                                             if LoadingFromString and (Pos('about:blank', LowerCase(Us)) > 0) then
                                                Delete(Us, 1, 11);
                                             FBase(Self, Us, Target, Element);
                                          end;
                                 end;
                              9:
                                 begin
                                    if Assigned(FBaseFont) then
                                       with All.Item(x, 0) as IHtmlBaseFontElement do
                                          FBaseFont(Self, Color, Face, Size, Element);
                                 end;
                              10:
                                 begin
                                    if Assigned(FFont) then
                                       with All.Item(x, 0) as IHtmlFontElement do
                                          FFont(Self, Color, Size, Face, Element);
                                 end;
                              11:
                                 begin
                                    if Assigned(FMeta) then
                                       with All.Item(x, 0) as IHtmlMEtaElement do
                                          FMeta(Self, HttpEquiv, Content, Name, URL,
                                             Charset, Element);
                                 end;
                              12:
                                 begin
                                    if Assigned(FMarquee) then
                                       with All.Item(x, 0) as IHtmlMarqueeElement do
                                          FMarquee(Self, bgColor, Width, Height, Direction, Behavior,
                                             ScrollAmount, ScrollDelay, Loop, vSpace, hSpace, Element);
                                 end;
                              13:
                                 begin
                                    if Assigned(FForm) then
                                       with All.Item(x, 0) as IHtmlFormElement do
                                          FForm(Self, Action, Dir, Encoding, Method,
                                             Target, Name, Element);
                                 end;
                              14:
                                 begin
                                    if Assigned(FScript) then
                                       with All.Item(x, 0) as IHtmlScriptElement do
                                          begin
                                             Us := Src;
                                             if LoadingFromString and (Pos('about:blank', LowerCase(Us)) > 0) then
                                                Delete(Us, 1, 11);
                                             FScript(Self, Us, HtmlFor, Event, Text, Defer, Element);
                                          end;

                                 end;
                              15:
                                 begin
                                    if Assigned(FDiv) then
                                       with All.Item(x, 0) as IHtmlDivElement do
                                          FDiv(Self, Align, NoWrap, Element);
                                 end;
                              16:
                                 begin
                                    if Assigned(FHR) then
                                       with All.Item(x, 0) as IHtmlHrElement do
                                          FHr(Self, Align, Color, Width, Size, NoShade, Element);
                                 end;
                              17:
                                 begin
                                    if Assigned(FBR) then
                                       with All.Item(x, 0) as IHtmlBrElement do
                                          FBr(Self, Clear, Element);

                                 end;
                           end;
                        end;
                  GetPageProperties;
               end
            else
               DispatchMessage(Msg);
         end;
   FURL := '';
   if (NoFramesFound) and (ParseNoFrames) then
      begin
         FHtml := NoFramesContent;
         Go;
      end;
   FHtml := '';
   ParseTime := FormatTickToTime(GetTickCount - StartTick);
   ConnectionPoint := nil;
   CoUninitialize;
   if FMessages.FShowStatusText and Assigned(FOnStatusText) then
      FOnStatusText(FMessages.FSuccessText + '  Process Time: ' + ParseTime);
   FBusy := False;
   BusyChange;
end;

procedure TIEParser.UpdateErrorEvent(Text: string);
begin
   if FMessages.FShowErrorMessage then
      MessageDlg(FMessages.FErrorText + Text, mtError, [mbAbort], 0);
   if FMessages.FShowStatusText and Assigned(FOnStatusText) then
      FOnStatusText(FMessages.FErrorText + Text)
end;

initialization
   OleInitialize(nil);
finalization
   try
      OleUninitialize;
   except
   end;

end.
