//***************************************
//       Extended IEParser 2             *
//        For Delphi 4 og 5             *
//       Freeware Component             *
//               by                     *
//                                      *
//        Per Lindsø Larsen             *
//        Modified : Marc Hervais       *
//   http://www.euromind.com/iedelphi   *
//***************************************

unit extIEParser;

interface

uses
{$IFDEF VER130}mshtml{$ELSE}mshtml_tlb{$ENDIF},
  Dialogs, Sysutils, Urlmon, ActiveX, Windows, Messages, Classes;

const
  WM_USER_STARTWALKING = WM_USER + 1;
  DISPID_AMBIENT_DLCONTROL = (-5512);
  READYSTATE_COMPLETE = $00000004;

  {DLCTL_DLIMAGES = $00000010;
  DLCTL_VIDEOS = $00000020;
  DLCTL_BGSOUNDS = $00000040;
  DLCTL_NO_SCRIPTS = $00000080;
  DLCTL_NO_JAVA = $00000100;
  DLCTL_NO_RUNACTIVEXCTLS = $00000200;
  DLCTL_NO_DLACTIVEXCTLS = $00000400;
  DLCTL_DOWNLOADONLY = $00000800;
  DLCTL_NO_FRAMEDOWNLOAD = $00001000;
  DLCTL_RESYNCHRONIZE = $00002000;
  DLCTL_PRAGMA_NO_CACHE = $00004000;
  DLCTL_FORCEOFFLINE = $10000000;
  DLCTL_NO_CLIENTPULL = $20000000;
  DLCTL_SILENT = $40000000;
  DLCTL_OFFLINEIFNOTCONNECTED = $80000000;
  DLCTL_OFFLINE = DLCTL_OFFLINEIFNOTCONNECTED;    }

type

  TDownloadControlOption = (DLCTL_DLIMAGES, DLCTL_VIDEOS, 
DLCTL_BGSOUNDS,
    DLCTL_NO_SCRIPTS, DLCTL_NO_JAVA, DLCTL_NO_RUNACTIVEXCTLS, 
DLCTL_NO_DLACTIVEXCTLS,
    DLCTL_DOWNLOADONLY, DLCTL_NO_FRAMEDOWNLOAD, DLCTL_RESYNCHRONIZE, 
DLCTL_PRAGMA_NO_CACHE,
    DLCTL_NO_BEHAVIORS, DLCTL_NO_METACHARSET, 
DLCTL_URL_ENCODING_DISABLE_UTF8,
    DLCTL_URL_ENCODING_ENABLE_UTF8, DLCTL_FORCEOFFLINE, 
DLCTL_NO_CLIENTPULL,
    DLCTL_SILENT, DLCTL_OFFLINE);

  TDownloadControlOptions = set of TDownloadControlOption;

  TElementInfo = record
    className: string;
    id: string;
    tagName: string;
    title: string;
    language: string;
    sourceIndex: Integer;
    recordNumber: OleVariant;
    lang: string;
    offsetLeft: Integer;
    offsetTop: Integer;
    offsetWidth: Integer;
    offsetHeight: Integer;
    innerHTML: string;
    innerText: string;
    outerHTML: string;
    outerText: string;
  end;

  TOnDownloadCompleteEvent = procedure (Sender: TObject) of object;
  TOnBREvent = procedure (Sender: TObject; clear: string; Element: TElementInfo) of 
      object;
  TOnHREvent = procedure (Sender: TObject; align: string; color, width, size: OleVariant; 
      noShade: Boolean; Element: TElementInfo) of object;
  TOnDIVEvent = procedure (Sender: TObject; align: string; noWrap: Boolean; Element: 
      TElementInfo) of object;
  TOnScriptEvent = procedure (Sender: Tobject; src, htmlFor, event, text: string; defer: 
      Boolean; Element: TElementInfo) of object;
  TOnFormEvent = procedure (Sender: TObject; action, dir, encoding, method, target, name: 
      string; Element: TElementInfo) of object;
  TOnMarqueeEvent = procedure (Sender: TObject; bgcolor, width, height: OleVariant; 
      direction, behavior: string; ScrollAmount, scrollDelay, loop, vspace, hspace: 
      Integer; Element: TElementInfo) of object;
  TOnFontEvent = procedure (Sender: TObject; color, size: OleVariant; Face: string; 
      Element: TElementInfo) of object;
  TOnBaseFontEvent = procedure (Sender: TObject; color: OleVariant; Face: string; size: 
      Integer; Element: TElementInfo) of object;
  TOnBaseEvent = procedure (Sender: TObject; href, target: string; Element: TElementInfo) 
      of object;
  TOnMetaEvent = procedure (Sender: TObject; httpEquiv, content, name, url, charset: 
      string; Element: TElementInfo) of object;
  TOnBodyEvent = procedure (Sender: TObject; background, bgProperties: string; leftmargin,
      topmargin, rightMargin, bottomMargin, bgColor, text, link, vlink, alink: OleVariant;
      noWrap: Boolean; Element: TElementInfo) of object;
  TOnImageEvent = procedure (Sender: TObject; src, lowsrc, vrml, dynsrc, alt, align, 
      usemap: string; isMap: Boolean; border, loop: OleVariant; vspace, hspace, width, 
      height: Integer; Element: TElementInfo) of object;
  TOnAnchorEvent = procedure (Sender: TObject; href, target, rel, rev, urn, Methods, name,
      host, hostname, pathname, port, protocol, search, hash, accesskey, protocolLong, 
      mimeType, nameProp: string; Element: TElementInfo) of object;
  TOnCommentEvent = procedure (sender: TObject; text: string; Element: TElementInfo) of 
      object;
  TOnElementEvent = procedure (Sender: TObject; ElementInfo: TElementInfo) of object;

  TNoFramesEvent = procedure (Sender: TObject ; ELement : TElementInfo) of object;
  TOnFrameEvent = procedure (Sender: TObject; SRC,Name : OleVariant; Element : 
      TElementInfo) of object;
  TOnFrameSetEvent = procedure (Sender: TObject; Rows, Cols, FrameBorder,Name : 
      WideString; Border , BorderColor, FameSpacing : OleVariant ; Element : 
      TelementInfo) of object;

  //TextIEParser = class (TComponent, IUnknown, IPropertyNotifySink, IOleClientSite)
  TextIEParser = class (TComponent, IUnknown, IDispatch, IPropertyNotifySink, 
      IOleClientSite)
  private
    FparseNoFrames: Boolean;
    Fhtml: string;
    FOnFrame: TOnFrameEvent;
    FOnFrameset: TOnFrameSetEvent;
    FOnNoFrame: TNoFramesEvent;
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
    FMarquee: TOnMarqueeEvent;
    FMeta: TOnMetaEvent;
    FRefCount: Integer;
    FScript: TOnScriptEvent;
    FUrl: string;
    _URL: PWideChar;
    function GetContainer(out container: IOleContainer): HResult; stdcall;
    function GetMoniker(dwAssign: Longint; dwWhichMoniker: Longint;  out mk: IMoniker): 
        HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID:  Integer; Flags: Word;  
        var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
    function LoadFromString: HResult;
    function LoadUrlFromMoniker: HResult;
    function OnChanged(dispid: TDispID): HResult; stdcall;
    function OnRequestEdit(dispid: TDispID): HResult; stdcall;
    function OnShowWindow(fShow: BOOL): HResult; stdcall;
    function RequestNewObjectLayout: HResult; stdcall;
    function SaveObject: HResult; stdcall;
    function ShowObject: HResult; stdcall;
  public
    All: IHtmlElementCollection;
    Doc: IhtmlDocument2;
    constructor Create(Owner : Tcomponent); override;
    procedure Execute;
  published
    property About: string read FAbout write FAbout;
    property DownloadOnly: Boolean read FDownloadOnly write FDownloadOnly;
    property DownloadOptions: TDownloadControlOptions read FDownloadControlOptions write FDownloadControlOptions;
    property parseNoFrames: Boolean read FparseNoFrames write FparseNoFrames ;
    property html: string read Fhtml write Fhtml;
    property OnAnchor: TOnAnchorEvent read FAnchor write FAnchor;
    property OnBase: TOnBaseEvent read FBase write FBase;
    property OnBaseFont: TOnBaseFontEvent read FBaseFont write FBaseFont;
    property OnBody: TOnBodyEvent read FBody write FBody;
    property OnBR: TOnBREvent read FBr write FBr;
    property OnComment: TOnCommentEvent read FComment write FComment;
    property OnDiv: TOnDIVEvent read FDiv write FDiv;
    property OnDownloadComplete: TOnDownloadCompleteEvent read FDownLoadComplete write FDownLoadComplete;
    property OnElement: TOnElementEvent read FElement write FElement;
    property OnFont: TOnFontEvent read FFont write FFont;
    property OnForm: TOnFormEvent read FForm write FForm;
    property OnFrame: TOnFrameEvent read FOnFrame write FOnFrame;
    property OnFrameset: TOnFrameSetEvent read FOnFrameset write FOnFrameset;
    property OnHR: TOnHREvent read FHr write FHr;
    property OnImage: TOnImageEvent read FImage write FImage;
    property OnMarquee: TOnMarqueeEvent read FMarquee write FMarquee;
    property OnMeta: TOnMetaEvent read FMeta write FMeta;
    property OnNoFrame: TNoFramesEvent read FOnNoFrame write FOnNoFrame;
    property OnScript: TOnScriptEvent read FScript write FScript;
    property Url: string read FUrl write FUrl;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Embedded Web Browser', [TextIEParser]);
end;

{
*************************************** TextIEParser
****************************************
}
{
************************************** TextIEParser **************************************
}
constructor TextIEParser.Create(Owner : Tcomponent);
begin
    FAbout:='http://www.euromind.com/iedelphi';
    inherited create(owner);
    DownloadOptions := [DLCTL_DLIMAGES, DLCTL_BGSOUNDS,
  DLCTL_VIDEOS,DLCTL_DOWNLOADONLY,DLCTL_NO_SCRIPTS,
        DLCTL_NO_JAVA,DLCTL_NO_DLACTIVEXCTLS,DLCTL_NO_RUNACTIVEXCTLS];
end;

procedure TextIEParser.Execute;
var
  boolWorking: Boolean;
  E: IhtmlElement;
  X: Integer;
  C: Integer;
  ConnectionPoint: IConnectionPoint;
  OleChar: array[0..MAX_PATH - 1] of TOleChar;
  Msg: TMsg;
  hr: HRESULT;
  v: OLEVariant;
  u: OLEVariant;
  NoFramesfound: Boolean;
  LoadingFromString: Boolean;
  NoFramesContent, us: string;

begin
    CoCreateInstance(CLASS_HTMLDocument, nil, CLSCTX_INPROC_SERVER,IHTMLDocument2, Doc);
    _Url := @OleChar;
    MultibytetoWideChar(CP_ACP, 0, PChar(FUrl), -1, _Url, sizeof(OleChar));
    (Doc as IOleObject).SetClientSite(self as IOleClientsite);
    (Doc as IOleControl).OnAmbientPropertyChange(DISPID_AMBIENT_DLCONTROL);
    (Doc as IConnectionPointContainer).FindConnectionPoint(IpropertyNotifySink, ConnectionPoint);
    ConnectionPoint.Advise(Self as IPropertyNotifySink, C);
   // noFramesFound := false;
    NoFramesContent := '';
  //  LoadingFromString := false;
    if fURL <> '' then
      HR := LoadUrlFromMoniker
    else
    begin
  //   LoadingFromString := true;
      HR := LoadFromString;
    end;
    boolWorking := System.True;
    if ((SUCCEEDED(HR)) or (HR = E_PENDING)) then
      while (boolWorking and GetMessage(Msg, 0, 0, 0)) do
      begin
        if ((Msg.Message = WM_USER_STARTWALKING) and (Msg.hWnd = 0)) then
        begin
          boolWorking := System.False;
          All := Doc.Get_all;
          if (All <> nil) and not FDownloadOnly then
            for x := 0 to All.length - 1 do begin
              E := All.item(x, 0) as IHTMLElement;
              with Element do begin
                className := E.classname;
                id := E.id;
                tagName := E.Tagname;
                title := E.Title;
                language := E.language;
                sourceIndex := E.SourceIndex;
                recordNumber := E.RecordNumber;
                lang := E.lang;
                offsetLeft := E.OffsetLeft;
                offsetTop := E.OffsetTop;
                offsetWidth := E.OffsetWidth;
                offsetHeight := E.offsetHeight;
                innerHTML := E.innerHTML;
                innerText := E.InnerText;
                outerHTML := E.OuterHTML;
                outerText := E.OuterText;
              end;
  
              if Assigned(FElement) then FElement(self, Element);
  
              if (E.Tagname = 'FRAMESET') and Assigned(FOnFrameSet) then
                with All.item(x, 0) as IHtmlFrameSetElement do
                  FOnFrameSet(self, Rows, Cols, FrameBorder, Name,
                    border,bordercolor,framespacing, Element) else
              if (E.Tagname = 'FRAME') and Assigned(FOnFrame) then
              begin
                v := E.getAttribute('Name',0);
                u := E.getAttribute('Src',0);
                us := u;
                if LoadingFromString and (pos('about:blank',lowercase(us) ) > 0) then delete(us,1,11);
                FOnFrame(self, us, v, Element);
              end
              else
              if (E.Tagname = 'NOFRAMES') then
              begin
           //     NoFramesFound := true;
                NoFramesContent := E.InnerHTML;
                if Assigned(FOnNoFrame) then FOnNoFrame(self, Element);
              end
              else
              if (E.Tagname = 'A') and Assigned(FAnchor) then
                with All.item(x, 0) as IHtmlAnchorElement do
                begin
                  us := href;
                  if LoadingFromString and (pos('about:blank',lowercase(us) ) > 0) then delete(us,1,11);
                  FAnchor(self, us, target, rel, rev, urn, Methods,
                    name, host, hostname, pathname, port, protocol,
                    search, hash, accesskey,
                    protocolLong, mimeType, nameProp, Element)
                end
                else
  
                if ((E.Tagname = 'COMMENT') or (E.Tagname = '!')) and Assigned(FComment) then
                  with All.item(x, 0) as IHtmlCommentElement do
                    FComment(self, text, Element) else
  
                  if (E.Tagname = 'IMG') and Assigned(FImage) then
                    with All.item(x, 0) as IHtmlImgElement do
                    begin
                      us := src;
                      if LoadingFromString and (pos('about:blank',lowercase(us) ) > 0) then delete(us,1,11);
                      FImage(self, us, lowsrc, vrml, dynsrc,
                        alt, align, usemap, isMap, border, loop,
                        vspace, hspace, width, height, Element)
                    end
                    else
  
                    if (E.Tagname = 'BODY') and Assigned(FBody) then
                      with All.item(x, 0) as IHtmlBodyElement do
                        FBody(self, background, bgProperties,
                          leftmargin, topmargin, rightMargin, bottomMargin, bgColor, text, link,
                          vlink, alink, noWrap, Element) else
  
                      if (E.Tagname = 'BASE') and Assigned(FBase) then
                        with All.item(x, 0) as IHtmlBaseElement do
                        begin
                          us := href;
                          if LoadingFromString and (pos('about:blank',lowercase(us) ) > 0) then delete(us,1,11);
                          FBase(self, us, target, Element)
                        end
                        else
  
                        if (E.Tagname = 'BASEFONT') and Assigned(FBaseFont) then
                          with All.item(x, 0) as IHtmlBaseFontElement do
                            FBaseFont(self, color, face, size, Element) else
  
                          if (E.Tagname = 'FONT') and Assigned(FFont) then
                            with All.item(x, 0) as IHtmlFontElement do
                              FFont(self, color, size, face, Element) else
  
                            if (E.Tagname = 'META') and Assigned(FMeta) then
                              with All.item(x, 0) as IHtmlMEtaElement do
                                FMeta(self, httpEquiv, content, name, url,
                                  charset, Element) else
  
                              if (E.Tagname = 'MARQUEE') and Assigned(FMarquee) then
                                with All.item(x, 0) as IHtmlMarqueeElement do
                                  FMarquee(self, bgcolor, width, height, direction, behavior,
                                    ScrollAmount, scrollDelay, loop, vspace, hspace, Element) else
  
                                if (E.Tagname = 'FORM') and Assigned (FForm) then
                                  with All.item(x, 0) as IHtmlFormElement do
                                    FForm(self, action, dir, encoding,method,
                                      target, name, Element) else
  
                                  if (E.Tagname = 'SCRIPT') and Assigned(FScript) then
                                    with All.item(x, 0) as IHtmlScriptElement do
                                    begin
                                      us := src;
                                      if LoadingFromString and (pos('about:blank',lowercase(us) ) > 0) then delete(us,1,11);
                                      FScript(self, us, htmlFor, event, text, defer, Element)
                                    end
                                    else
  
                                    if (E.Tagname = 'DIV') and Assigned (FDiv) then
                                      with All.item(x, 0) as IHtmlDivElement do
                                        FDiv(self, align, noWrap, Element) else
  
                                      if (E.Tagname = 'HR') and Assigned(FHR) then
                                        with All.item(x, 0) as IHtmlHrElement do
                                          FHr(self, align, color, width, size, noShade, Element) else
  
                                        if (E.Tagname = 'BR') and Assigned(FBR) then
                                          with All.item(x, 0) as  IHtmlBrElement do
                                            FBr(self, clear, Element);
  
            end;
        end
        else
          DispatchMessage(Msg);
      end;
    furl := '';
    if (NoframesFound) and (parsenoframes) then
    begin
      fhtml := NoFramesContent;
      execute;
    end;
    fhtml := '';
end;

function TextIEParser.GetContainer(out container: IOleContainer): HResult;
begin
  result := E_NOTIMPL;
end;

function TextIEParser.GetMoniker(dwAssign: Longint; dwWhichMoniker: Longint;  out mk: 
    IMoniker): HResult;
begin
  result := E_NOTIMPL;
end;

function TextIEParser.Invoke(DispID: Integer; const IID: TGUID; LocaleID:  Integer; 
    Flags: Word;  var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var
  I: Integer;
begin
  if DispId = DISPID_AMBIENT_DLCONTROL then begin
  {    I := DLCTL_DOWNLOADONLY + DLCTL_NO_SCRIPTS +
      DLCTL_NO_JAVA + DLCTL_NO_DLACTIVEXCTLS +
      DLCTL_NO_RUNACTIVEXCTLS;   }
    i := UpdateDownloadControlValue ;
    PVariant(VarResult)^ := I;
    Result := S_OK;
  end else
    Result := DISP_E_MEMBERNOTFOUND;
end;

function TextIEParser.LoadFromString: HResult;
var
  V: OLEVariant;
  vDocument: OLEVariant;
  vMIMEType: OLEVariant;
  vHTML: OLEVariant;
begin
  try
    //Stop any actions - this is important!
    // FWeb.Stop;   no dealing with the document directly
    // Grab the document
    V:= doc;
    // Now get the script's document (like a JavaScript document)
    vDocument:= V.script.document;
    // IE 4.0 only deals with text/html on a consistent basis
    vMIMEType:= 'text/html';
    // You can use any html content you want here
    vHTML:= FHtml;
    //Re-open the page for writing
    vDocument.Open(vMIMEType);
    // Clear the existing content (or not)
    vDocument.Clear;
    // Write our HTML
    vDocument.Write(vHTML);
    // Closing the document sends the page to the browser
    vDocument.Close;
    result := s_ok;
  except
    result := s_false;
  end;
end;

function TextIEParser.LoadUrlFromMoniker: HResult;
var
  moniker: IMoniker;
  BindCtx: IBindCTX;
begin
    createURLMoniker(nil, _Url, Moniker);
    CreateBindCtx(0, BindCtx);
    Result := (Doc as IpersistMoniker).Load(LongBool(0), Moniker, 
  BindCtx, STGM_READ);
end;

function TextIEParser.OnChanged(dispid: TDispID): HResult;
var
  dp: TDispParams;
  vResult: OLEVariant;
begin
    if (DISPID_READYSTATE = Dispid) then
      if SUCCEEDED((Doc as Ihtmldocument2).Invoke(DISPID_READYSTATE, 
  GUID_null,
        LOCALE_SYSTEM_DEFAULT, DISPATCH_PROPERTYGET, dp, @vresult, nil, 
  nil)) then
        if Integer(vresult) = READYSTATE_COMPLETE then
          PostThreadMessage(GetCurrentThreadId(), WM_USER_STARTWALKING, 
  0, 0);
    RESULT := S_OK;
end;

function TextIEParser.OnRequestEdit(dispid: TDispID): HResult;
begin
  RESULT := E_NOTIMPL;
end;

function TextIEParser.OnShowWindow(fShow: BOOL): HResult;
begin
  result := E_NOTIMPL;
end;

function TextIEParser.RequestNewObjectLayout: HResult;
begin
  result := E_NOTIMPL;
end;

function TextIEParser.SaveObject: HResult;
begin
  result := E_NOTIMPL;
end;

function TextIEParser.ShowObject: HResult;
begin
  result := E_NOTIMPL;
end;

function TextIEParser.UpdateDownloadControlValue: LongInt;
  
    const
      acardDownloadControlValues: array[TDownloadControlOption] of 
  Cardinal =
      ($00000010, $00000020, $00000040, $00000080,
        $00000100, $00000200, $00000400, $00000800,
        $00001000, $00002000, $00004000, $00008000,
        $00010000, $00020000, $00040000, $10000000,
        $20000000, $40000000, $80000000);
    var
      i: TDownloadControlOption;
      j: longint;
  
begin
    j := 0;
    if (FDownloadControlOptions <> []) then
      for i := Low(TDownloadControlOption) to High
  (TDownloadControlOption)
        do
        if (i in FDownloadControlOptions) then
          Inc(j, acardDownloadControlValues[i]);
    result := j;
end;

end.

