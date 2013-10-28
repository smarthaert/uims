//***********************************************************
//                        TEditDesigner                     *
//                                                          *
//                       For Delphi 4/5                     *
//                     Freeware Component                   *
//                            by                            *
//                     Per Lindsø Larsen                    *                                                            //                   per.lindsoe@larsen.dk                  *
//                 Fixed by bsalsa - bsalsa.com             *
//  Documentation and Updated versions:                     *
//                                                          *
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

You may use, Change or modify the component under 3 conditions:
1. In your website, add a link to "http://www.bsalsa.com"
2. In your application, add credits to "Embedded Web Browser"
3. Mail me  (bsalsa@bsalsa.com) any code Change in the unit
   for the benefit of the other users.
4. You may consider donation in our web site!
{*******************************************************************************}

unit EditDesigner;

interface

{$I EWB.inc}

uses
   EWBAcc, EmbeddedWB, ActiveX, Mshtml_Ewb, Classes, Windows;

const
   S_OK = 0;
{$EXTERNALSYM S_OK}
   S_FALSE = $00000001;
{$EXTERNALSYM S_FALSE}
   E_FAIL = HRESULT($80004005);
{$EXTERNALSYM E_FAIL}
  //IID_IOleContainer : TGUID = '{0000011B-0000-0000-C000-000000000046}';
   IID_IOleContainer: TGUID = (D1: $0000011B; D2: $0000; D3: $0000;
      D4: ($C0, $00, $00, $00, $00, $00, $00, $46));
   SID_SHTMLEditServices: TGUID = (D1: $3050F7F9; D2: $98B5; D3: $11CF;
      D4: ($BB, $82, $00, $AA, $00, $BD, $CE, $0B));
   IID_IUnknown: TGUID = (D1: $00000000; D2: $0000; D3: $0000;
      D4: ($C0, $00, $00, $00, $00, $00, $00, $46));

type
   TPreHandleEvent = function(inEvtDispId: Integer; const pIEventObj: IHTMLEventObj): HResult of object;
   TPostHandleEvent = function(inEvtDispId: Integer; const pIEventObj: IHTMLEventObj): HResult of object;
   TTranslateAccelerator = function(inEvtDispId: Integer; const pIEventObj: IHTMLEventObj): HResult of object;
   TPostEditorEventNotify = function(inEvtDispId: Integer; const pIEventObj: IHTMLEventObj): HResult of object;
   TMSHTMLEvent = procedure(Event: IHTMLEventObj) of object;
   TMousePositionEvent = procedure(const X, Y: integer) of object;
   TErrorEvent = procedure(const ErrorCode: integer; ErrMessage: string) of object;
   TEvtDispIdEvent = procedure(const inEvtDispId: integer) of object;
   TMouseButtonEvent = procedure(const Button: integer) of object;
   TKeyStateEvent = procedure(const CapsLock, NumLock, InsertKey, altKey, ctrlKey, shiftKey: Boolean) of object;
   TKeyPressEvent = procedure(const Key: integer) of object;
   TtypeEvent = procedure(const type_: string) of object;
   TtagNameEvent = procedure(const tagName: string) of object;
   TSnapRect = function(const pIElement: IHTMLElement; var prcNew: tagRECT; eHandle: _ELEMENT_CORNER): HResult of object;
   TPreDrag = function: HResult of object;
   TtoStringEvent = procedure(const toString: string) of object;
   TinnerHtmlEvent = procedure(const innerHtml: string) of object;
   TinnerTextEvent = procedure(const innerText: string) of object;
type
   IOleContainer = interface(IParseDisplayName)
      ['{0000011B-0000-0000-C000-000000000046}']
      function EnumObjects(grfFlags: Longint; out Enum: IEnumUnknown): HResult; stdcall;
      function LockContainer(fLock: BOOL): HResult; stdcall;
   end;

type
   TImpIOleContainer = class(TObject, IOleContainer)
   protected
      m_cRef: DWORD;
   public
      function _AddRef: Integer; overload; stdcall;
      function _Release: Integer; overload; stdcall;
      constructor Create; virtual;
      destructor Destroy; override;
      function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
      function ParseDisplayName(const bc: IBindCtx; pszDisplayName: POleStr;
         out chEaten: Longint; out mkOut: IMoniker): HResult; stdcall;
      function EnumObjects(grfFlags: Longint; out Enum: IEnumUnknown): HResult; stdcall;
      function LockContainer(fLock: BOOL): HResult; stdcall;
   end;

   TEditDesigner = class(TComponent,
         IUnknown, //http://msdn.microsoft.com/library/default.asp?url=/library/en-us/com/html/33f1d79a-33fc-4ce5-a372-e08bda378332.asp
         IHtmlEditDesigner, //http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/mshtml/reference/IFaces/EditDesigner/IHTMLEditDesigner.asp
         IHTMLEditHost, //http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/mshtml/reference/ifaces/edithost/ihtmledithost.asp
         IHTMLEditHost2 //, //http://msdn.microsoft.com/library/default.asp?url=/workshop/browser/mshtml/reference/ifaces/edithost2/ihtmledithost2.asp
         )

   private
      bDesignMode: Boolean;
      bConnected: Boolean;
      FAbout: string;
      FEmbeddedWB: TEmbeddedWB;
      FEnable: Boolean;
      FOnError: TErrorEvent;
      FOnInnerHtml: TinnerHtmlEvent;
      FOnInnerText: TinnerTextEvent;
      FOnEvtDispId: TEvtDispIdEvent;
      FOnKeyState: TKeyStateEvent;
      FOnKeyPress: TKeyPressEvent;
      FOnMousePosition: TMousePositionEvent;
      FOnMouseButton: TMouseButtonEvent;
      FonType_: TtypeEvent;
      FOnToString: TtoStringEvent;
      FOntagName: TtagNameEvent;
      FPostEditorEventNotify: TPostEditorEventNotify;
      FPostHandleEvent: TPostHandleEvent;
      FPreHandleEvent: TPreHandleEvent;
      FPreDrag: TPreDrag;
      FSnapRect: TSnapRect;
      FTranslateAccelerator: TTranslateAccelerator;
      sl: TStringList;
      procedure SetAbout(Value: string);
   protected
      {IHTMLEditHost}
      function SnapRect(const pIElement: IHTMLElement; var prcNew: tagRECT; eHandle: _ELEMENT_CORNER): HResult; stdcall;
      {IHTMLEditHost2}
      function PreDrag: HResult; stdcall;
      {IHtmlEditDesigner}
      function PreHandleEvent(inEvtDispId: Integer; const pIEventObj: IHTMLEventObj): HResult; stdcall;
      function PostHandleEvent(inEvtDispId: Integer; const pIEventObj: IHTMLEventObj): HResult; stdcall;
      function TranslateAccelerator(inEvtDispId: Integer; const pIEventObj: IHTMLEventObj): HResult; stdcall;
      function PostEditorEventNotify(inEvtDispId: Integer; const pIEventObj: IHTMLEventObj): HResult; stdcall;
      procedure Loaded; override;

   public
      procedure SetDesignModeOff;
      procedure SetDesignModeOn;
      function ConnectDesigner: integer;
      function RemoveDesigner: integer;
      procedure InsertHTML(stHTML: string);
      function GetPageProperties: TStrings;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure BeforeDestruction; override;
      function GetContainer(out container: IOleContainer): HResult;
   published
      property About: string read fAbout write SetAbout;
      property Enable: Boolean read FEnable write FEnable default True;
      property EmbeddedWB: TEmbeddedWB read FEmbeddedWB write FEmbeddedWB;
      property OnPreDrag: TPreDrag read FPreDrag write FPreDrag;
      property OnError: TErrorEvent read FOnError write FOnError;
      property OnInnerText: TInnerTextEvent read FOnInnerText write FOnInnerText;
      property OnInnerHtml: TInnerHtmlEvent read FOnInnerHtml write FOnInnerHtml;
      property OnKeyPress: TKeyPressEvent read FOnKeyPress write FOnKeyPress;
      property OnKeyState: TKeyStateEvent read FOnKeyState write FOnKeyState;
      property OnPreHandle: TPreHandleEvent read FPreHandleEvent write FPreHandleEvent;
      property OnPostHandle: TPostHandleEvent read FPostHandleEvent write FPostHandleEvent;
      property OnPostEditorNotify: TPostEditorEventNotify read FPostEditorEventNotify write FPostEditorEventNotify;
      property OnTranslateAccelerator: TTranslateAccelerator read FTranslateAccelerator write FTranslateAccelerator;
      property OnMousePosition: TMousePositionEvent read FOnMousePosition write FOnMousePosition;
      property OnMouseButton: TMouseButtonEvent read FOnMouseButton write FOnMouseButton;
      property OnEvtDispId: TEvtDispIdEvent read FOnEvtDispId write FOnEvtDispId;
      property OnSnapRect: TSnapRect read FSnapRect write FSnapRect;
      property OnType_: TtypeEvent read FOnType_ write FOnType_;
      property OnToString: TtoStringEvent read FOnToString write FOnToString;
      property OnTagName: TtagNameEvent read FOnTagName write FOnTagName;
   end;

implementation

uses
   sysUtils;

var
   EditServices: IHTMLEditServices;

//--{TImpIOleContainer}---------------------------------------------------------
constructor TImpIOleContainer.Create;
begin
   inherited;
   m_cRef := 0;
end;

destructor TImpIOleContainer.Destroy;
begin
   inherited;
end;

function TImpIOleContainer.EnumObjects(grfFlags: Longint; out Enum: IEnumUnknown): HResult;
begin
   Result := E_NOINTERFACE;
end;

function TImpIOleContainer.LockContainer(fLock: BOOL): HResult;
begin
   Result := E_NOINTERFACE;
end;

function TImpIOleContainer.ParseDisplayName(const bc: IBindCtx; pszDisplayName: POleStr;
   out chEaten: Longint; out mkOut: IMoniker): HResult;
begin
   Result := E_NOINTERFACE;
end;

function TImpIOleContainer.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
   Result := S_False;
   if GetInterface(IID, Obj) then
      begin
         Result := S_OK;
         Exit;
      end;
    {$IFDEF DELPHI_7_UP}
   if (GUIDToString(IID_IUnknown) = GUIDToString(IID)) or
      (GUIDToString(IID_IOleContainer) = GUIDToString(IID)) then
      begin
         IOleContainer(Obj) := Self;
         Result := S_OK;
         self._AddRef;
      end;
     {$ENDIF} 
end;

function TImpIOleContainer._AddRef: Integer;
begin
   inc(m_cRef);
   Result := m_cRef;
end;

function TImpIOleContainer._Release: Integer;
begin
   Dec(m_cRef);
   Result := m_cRef;
   if m_cRef = 0 then
      Free;
end;

//--{ TEditDesigner }-----------------------------------------------------------

function TEditDesigner.GetContainer(out container: IOleContainer): HResult;
var
   aCntr: TImpIOleContainer;
begin
   aCntr := TImpIOleContainer.Create;
   Result := aCntr.QueryInterface(IID_IOleContainer, container);
end;

constructor TEditDesigner.Create;
begin
   FAbout := 'TEditDesigner - from http://www.bsalsa.com/';
   FEnable := True;
   sl := TStringList.Create;
   inherited;
end;

destructor TEditDesigner.Destroy;
begin
   sl.Free;
   inherited Destroy;
end;

procedure TEditDesigner.BeforeDestruction();
begin
   if bConnected then
      EditServices.RemoveDesigner(Self);
   inherited BeforeDestruction;
end;

procedure TEditDesigner.Loaded;
begin
   sl.Clear;
   bConnected := False;
   bDesignMode := False;
   if Assigned(FEmbeddedWB) and FEnable and not (csDesigning in ComponentState) then
      FEmbeddedWB.AssignEmptyDocument;
   inherited;
end;

function TEditDesigner.SnapRect(const pIElement: IHTMLElement; var prcNew: tagRECT;
   eHandle: _ELEMENT_CORNER): HResult;
begin
   Result := S_OK;
   if Assigned(FSnapRect) and FEnable then
      Result := FSnapRect(pIElement, prcNew, eHandle);
end;

function TEditDesigner.PreDrag: HResult;
begin
   Result := S_OK;
   if Assigned(FPreDrag) and FEnable then
      Result := FPreDrag;
end;

function TEditDesigner.PostEditorEventNotify(inEvtDispId: Integer;
   const pIEventObj: IHTMLEventObj): HResult;
begin
   Result := S_FALSE;
   if FEnable and not (csDesigning in ComponentState) then
      begin
         if (inEvtDispId = -606) and Assigned(FOnMousePosition) then
            FOnMousePosition(pIEventObj.clientX, pIEventObj.clientY);
         if Assigned(FPostEditorEventNotify) then
            Result := FPostEditorEventNotify(inEvtDispID, pIEventObj);
      end;
end;

function TEditDesigner.PostHandleEvent(inEvtDispId: Integer;
   const pIEventObj: IHTMLEventObj): HResult;
begin
   Result := S_FALSE;
   if FEnable and not (csDesigning in ComponentState) then
      begin
         if Assigned(FPostHandleEvent) and FEnable then
            Result := FPostHandleEvent(inEvtDispID, pIEventObj);
         if (Result = S_OK) and (Assigned(FOnError)) then
            FOnError(Result, 'Failed  while designer Post Handle!');
      end;
end;

function CheckCapsLock: boolean;
begin
   if Odd(GetKeyState(VK_CAPITAL)) then
      Result := True
   else
      Result := False;
end;

function CheckInsertKey: boolean;
begin
   if Odd(GetKeyState(VK_INSERT)) then
      Result := True
   else
      Result := False;
end;

function CheckNumLock: boolean;
begin
   if Odd(GetKeyState(VK_NUMLOCK)) then
      Result := True
   else
      Result := False;
end;

function TEditDesigner.PreHandleEvent(inEvtDispId: Integer;
   const pIEventObj: IHTMLEventObj): HResult;
var
   srcElement: IHTMLElement;
begin
   Result := S_FALSE;
   if FEnable and not (csDesigning in ComponentState) then
      begin
         if Assigned(FPreHandleEvent) then
            Result := FPreHandleEvent(inEvtDispID, pIEventObj);
         if (Result = S_OK) and (Assigned(FOnError)) then
            FOnError(Result, 'Failed  while designer PreHandle!');
         srcElement := pIEventObj.srcElement;
         if Assigned(srcElement) then
            begin
               if Assigned(FOnKeyState) then
                  FOnKeyState(CheckCapsLock, CheckNumLock, CheckInsertKey, pIEventObj.altKey, pIEventObj.ctrlKey, pIEventObj.shiftKey);
               if Assigned(FOnEvtDispId) then
                  FOnEvtDispId(inEvtDispId);
               if Assigned(FOnMouseButton) then
                  FOnMouseButton(pIEventObj.button);
               if Assigned(FOnKeyPress) then
                  FOnKeyPress(pIEventObj.keyCode);
               if Assigned(FOnTagName) then
                  FOnTagName(pIEventObj.srcElement.tagName);
               if Assigned(FOnType_) then
                  FonType_(pIEventObj.type_);
               if Assigned(FOnToString) then
                  FOnToString(pIEventObj.srcElement.toString);
               if Assigned(FOnToString) then
                  FOnToString(pIEventObj.srcElement.toString);
               if Assigned(FOnInnerText) then
                  FOnInnerText(pIEventObj.srcElement.innerText);
               if Assigned(FOnInnerHTML) then
                  FOnInnerHTML(pIEventObj.srcElement.innerHTML);
            end;
      end;
end;

function TEditDesigner.TranslateAccelerator(inEvtDispId: Integer;
   const pIEventObj: IHTMLEventObj): HResult;
begin
   Result := S_FALSE;
   if FEnable and not (csDesigning in ComponentState) then
      begin
         if Assigned(FTranslateAccelerator) then
            Result := FTranslateAccelerator(inEvtDispID, pIEventObj);
         if (Result = S_OK) and (Assigned(FOnError)) then
            FOnError(Result, 'Failed  while designer TranslateAccelerator!');
      end;
end;

procedure TEditDesigner.InsertHTML(stHTML: string);
var
   Sel: IHTMLSelectionObject;
   Range: IHTMLTxtRange;
   Doc: IHTMLDocument2;
begin

   if (not Assigned(Doc) or (not Assigned(FEmbeddedWB)) or not FEnable) then
      Exit;
   Doc := FEmbeddedWB.Document as IHTMLDocument2;
   Sel := Doc.selection;
   if Assigned(Sel) and not (csDesigning in ComponentState) then
      begin
         if (Sel.type_ = 'None') or (Sel.type_ = 'Text') then
            begin
               Range := Sel.createRange as IHTMLTxtRange;
               Range.pasteHTML(stHTML);
            end;
      end;
end;

function TEditDesigner.ConnectDesigner: integer;
begin
   Result := S_False;
   if FEnable and not (csDesigning in ComponentState) then
      begin
         if not Assigned(FEmbeddedWB) then
            begin
               if Assigned(FOnError) then
                  FOnError(E_FAIL, 'Please Assign an EmbeddedWB!');
               Exit;
            end;
         FEmbeddedWB.Wait;
         SetDesignModeOn;
         Result := (FEmbeddedWB.Document as IServiceProvider).Queryservice(SID_SHTMLEDITSERVICES, IID_IHTMLEditServices, EditServices);
         if Result = S_OK then
            Result := EditServices.AddDesigner(Self);
         if ((Result <> S_OK) and Assigned(FOnError)) then
            FOnError(E_FAIL, 'Failed loading the designer!')
         else
            bConnected := True;
      end;
end;

function TEditDesigner.RemoveDesigner: integer;
begin
   Result := S_False;
   if FEnable and not (csDesigning in ComponentState) then
      begin
         if not Assigned(FEmbeddedWB) and Assigned(FOnError) and (FEmbeddedWB.Document = nil) then
            begin
               FOnError(E_FAIL, 'Failed (Document = nil).');
               Exit;
            end
         else
            if FEmbeddedWB.Busy then
               begin
                  FEmbeddedWB.Stop;
                  FEmbeddedWB.Wait;
               end;
         Result := EditServices.RemoveDesigner(Self);
         if (Result <> S_OK) and (Assigned(FOnError)) then
            FOnError(Result, 'Failed to RemoveDesigner.')
         else
            bConnected := false;
         SetDesignModeOff;
      end;
end;

procedure TEditDesigner.SetDesignModeOn;
begin
   if not Assigned(FEmbeddedWB) then
      begin
         if Assigned(FOnError) then
            FOnError(E_FAIL, 'Please Assign an EmbeddedWB!');
         Exit;
      end;
   if not (csDesigning in ComponentState) then
      begin
         FEmbeddedWB.Wait;
         try
            (FEmbeddedWB.document as IHTMLDocument2).designMode := 'On';
            bDesignMode := True;
         except
            if Assigned(FOnError) then
               FOnError(E_FAIL, 'Failed to set DedignMode state On.');
         end;
      end;
end;

procedure TEditDesigner.SetDesignModeOff;
begin
   if not Assigned(FEmbeddedWB) then
      begin
         if Assigned(FOnError) then
            FOnError(E_FAIL, 'Please Assign an EmbeddedWB!');
         Exit;
      end;
   if not (csDesigning in ComponentState) then
      begin
         try
            (FEmbeddedWB.document as IHTMLDocument2).designMode := 'Off';
            bDesignMode := False;
         except
            if Assigned(FOnError) then
               FOnError(E_FAIL, 'Failed to set DedignMode state Off.');
         end;
      end;
end;

procedure TEditDesigner.SetAbout(Value: string);
begin
   Exit;
end;

function TEditDesigner.GetPageProperties: TStrings;
var
   Doc: IhtmlDocument2;
begin
   sl.Clear;
   if Assigned(FEmbeddedWB) and FEnable and not (csDesigning in ComponentState) then
      begin
         FEmbeddedWB.Wait;
         Doc := FEmbeddedWB.Document as IHTMLDocument2;
         if (Assigned(Doc)) and (Doc.readyState = 'complete') and (Doc <> nil) then
            with sl do
               try
                  Add('URL: ' + Doc.url);
                  Add('Title: ' + Doc.title);
                  Add('Protocol: ' + Doc.protocol);
                  Add('Location: ' + Doc.location.href);
                  Add('Path Name: ' + Doc.location.pathname);
                  Add('Port: ' + Doc.location.port);
                  Add('Protocol: ' + Doc.location.protocol);
                  Add('Host: ' + Doc.location.host);
                  Add('Hash: ' + Doc.location.hash);
                  Add('Search: ' + Doc.location.search);
                  Add('Last Modified: ' + Doc.lastModified);
                  Add('Security: ' + Doc.security);
                  Add('Name Property: ' + Doc.nameProp);
                  Add('Language: ' + Doc.Body.language);
                  Add('Lang: ' + Doc.Body.lang);
                  Add('Design Mode: ' + Doc.designMode);
                  Add('Charset: ' + Doc.charset);
                  Add('Default Charset: ' + Doc.defaultCharset);
                  Add('Cookie: ' + Doc.cookie);
                  Add('Referrer: ' + Doc.Referrer);
                  Add('Doc State: ' + Doc.readyState);
               except
                  on E: Exception do
                     begin
                        if Assigned(FOnError) then
                           FOnError(E_Fail, E.Message);
                        Result := sl;
                        Exit;
                     end;
               end;
      end
   else
      if Assigned(FOnError) then
         FOnError(E_FAIL, 'Please Assign an EmbeddedWB and load a document!');
   Result := sl;
end;

initialization
   OleInitialize(nil);

finalization
   OleUninitialize;

end.

