//*****************************************************************
//  Rich Edit for Web Browser ver D2005 (Dec. 20 , 2005)          *
//                                                                *
//                     For Delphi 5,6,7, 2005                     *
//                     Freeware Component                         *
//                            by                                  *
//                     Eran Bodankin (bsalsa)                     *
//                                                                *
//      Based on a Idea's from:  http://www.torry.net/            *
//                                                                *
//     Documentation and updated versions:                        *
//     http://groups.yahoo.com/group/delphi-webbrowser/           *
//*****************************************************************


unit RichEditBrowser;

interface

{$I EWB.inc}

uses
  Windows, Messages, Classes, Controls, ComCtrls, ExtCtrls, Graphics, ComObj,Menus,
  HighLightHTML, HighLightXML, EmbeddedWB, ImgList, RichEdit, ClipBrd, ActiveX;

 Const
  REO_GETOBJ_NO_INTERFACES  = $00000000;
  REO_GETOBJ_POLEOBJ        = $00000001;
  REO_GETOBJ_PSTG           = $00000002;
  REO_GETOBJ_POLESITE       = $00000004;
  REO_GETOBJ_ALL_INTERFACES = $00000007;
  REO_CP_SELECTION          = $FFFFFFFF;
  REO_IOB_SELECTION         = $FFFFFFFF;
  REO_IOB_USE_CP            = $FFFFFFFE;
  REO_NULL                  = $00000000;
  REO_READWRITEMASK         = $0000003F;
  REO_DONTNEEDPALETTE       = $00000020;
  REO_BLANK                 = $00000010;
  REO_DYNAMICSIZE           = $00000008;
  REO_INVERTEDSELECT        = $00000004;
  REO_BELOWBASELINE         = $00000002;
  REO_RESIZABLE             = $00000001;
  REO_LINK                  = $80000000;
  REO_STATIC                = $40000000;
  REO_SELECTED              = $08000000;
  REO_OPEN                  = $04000000;
  REO_INPLACEACTIVE         = $02000000;
  REO_HILITED               = $01000000;
  REO_LINKAVAILABLE         = $00800000;
  REO_GETMETAFILE           = $00400000;
  RECO_PASTE                = $00000000;
  RECO_DROP                 = $00000001;
  RECO_COPY                 = $00000002;
  RECO_CUT                  = $00000003;
  RECO_DRAG                 = $00000004;
  READYSTATE_COMPLETE       = $00000004;
  CLSID_NULL : TCLSID       = '{00000000-0000-0000-0000-000000000000}';
  clSelColor                = clHighlightText;
  clSelColorBk              = clHighlight;
  clTextColor               = clWindowText;
  clTextColorBk             = clWindow;
  clHyperlink               = clBlue;
  clHyperlinkBk             = clWindow;

// type
 // TRichEditVersion = 1..4;
 type
  TURLClickEvent  = procedure(Sender :TObject; const URL: string) of object;
  TTextAlignment  = (taLeftJustify, taRightJustify, taCenter);
  TThemes         = (tDefault, tXP, tBlack, tAluminum, tLight);
 type
  TEditStreamCallBack = function (dwCookie: Longint; pbBuff: PByte;cb:
  Longint; var pcb: Longint): DWORD; stdcall;

  TEditStream = record
   dwCookie: Longint;
   dwError: Longint;
   pfnCallback: TEditStreamCallBack;
 end;

  TRichEditWB = class(TRichEdit)

  private
    fAcceptDragComponnents : boolean;
    fAcceptDragFiles       : boolean;
    fAutoNavigate          : Boolean;
    fEmbeddedWB            : TEmbeddedWB;
    fFileName              : string;
    fHideCaret             : Boolean;
    fHighlightURL          : Boolean;
    fHTMLHighlight         : Boolean;
    fImage                 : TImage;
    fModified              : Boolean;
    fMoreThen64KB          : Boolean;
    fOnURLClick            : TURLClickEvent;
    fSelPos                : integer;
    fStatusbar             : TStatusbar;
    fStream                : TMemoryStream;
    fThemes                : TThemes;
    fTextAlignment         : TAlignment;
    fTopGap, fLeftGap      : Integer;
    fRightGap, fBottomGap  : Integer;
    fXMLHighlight          : Boolean;
    fPopupVerbMenu         : TPopupMenu;
    FAutoVerbMenu          : Boolean;
    inserted               : Boolean;
    function GetCanUndo: Boolean;
    function GetModified: Boolean;
    function GetRTFText: string;
    procedure CheckFileSave;
    procedure ClearAll(Sender: TObject);
    procedure ClearSel(Sender: TObject);
    procedure CNNotify(var Msg: TWMNotify); message CN_NOTIFY;
    procedure CopySel(Sender: TObject);
    procedure CutSel(Sender: TObject);
    procedure DoHTMLrc(Sender: TObject);
    procedure DoXMLrc(Sender: TObject);
    procedure FindDialog(Sender : TObject);
    procedure FindDialogFind(Sender : TObject);
    procedure PasteSel(Sender: TObject);
    procedure PerformFileOpen(const AFileName: string);
    procedure PrintSel(Sender: TObject);
    procedure Prnt(Sender: TObject);
    procedure ReplaceDialogReplace(Sender: TObject);
    procedure SetEditRect;
    procedure SetFileName(const FileName: String);
    procedure SetHideCaret(const Value: Boolean);
    procedure SetHyperlink(Setlink: Boolean; wParam: Integer);
    procedure SetModified(Value: Boolean);
    procedure SetRTFText(RichText: string);
    procedure SetTextAlignment (al: TAlignment);
    procedure UpdateInfo;
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged);
              message WM_WINDOWPOSCHANGED;

  protected
    FMax: integer;
    FSelection: TCharRange;
    function GetPopupMenu: TPopupMenu; override;
    function GetSelStart: integer; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure DoSetMaxLength(Value: Integer); override;
    procedure DoURLClick(const URL : string);
    procedure EMExSetSel(var Message: TMessage); message EM_EXSETSEL;
    procedure EMReplaceSel(var Message: TMessage); message EM_REPLACESEL;
    procedure setBottomGap(value : Integer);
    procedure setLeftGap(value : Integer);
    procedure setRightGap(value : Integer);
    procedure setTopGap(value : Integer);
    procedure WndProc(var Msg: TMessage); override;

 public
    CapsLockKey        : string;
    CarretPosition  : string;
    CompCount       : integer;
    CursorPositionX, CursorPositionY : integer;
    HTMLSyn         : THighlightHTML;
    InsertKey          : string;
    LineIndex       : integer;
    NumLockKey         : string;
    XMLSyn          : THighlightXML;
    constructor Create(AOwner : TComponent); override;
    procedure Loaded;override;
    destructor Destroy; override;
    function AddBitmapFromImagelist(const ASource: TCustomImageList; const
     AImageIndex: TImageIndex): integer;
    function AddBullets: integer;
    function AddButton(bCaption, bName: string; reLeft, bLeft, bTop:integer): integer;
    function AddCheckBox(cbCaption, cbName: string; reLeft, cbLeft,cbTop :
    Integer; Chk:Boolean): integer;
    function AddDateAndTime: integer;
    function AddEditBox(eText, eName: string; reLeft, eLeft, eTop :Integer): integer;
    function AddEmptyLine: integer;
    function AddFile(FilePath : String;Linked : bool;AsIcon :
             Bool): integer;
    function AddFiles(Files : TStrings;Linked : bool;AsIcon :
             Bool): integer;
    function AddFormatedText(const txt: string; Bold, Italic, Strikeout, Underline:
             boolean; txtColor : TColor ): integer;
    function AddImage(FilePath : String): Integer;
    function AddImages(Files: TStrings):integer;
    function AddImageUsingClipboard(FilePath : String): integer;
    function AddLineNumbering: integer;
    function AddRadioButton(rbCaption, rbName: string; reLeft, rbLeft, rbTop:
    integer; Chk: boolean): integer;
    function AddRomanNumbering: integer;
    function AddRTFSelection(sourceStream: TStream): integer;
    function AddRtfText(str: String): integer;
    function AddText(const txt: string): integer;
    function AddTextByCursor(str: string): integer;
    function ConvertBitmapToRTF(pict: TBitmap): string;
    function ChangeToANSIChangeCase(const S: string): string;
    function GetCharactersCount: integer;
    function GetLineCount: Integer;
    function GetLineFromChar(CharIndex: Integer): Integer;
    function GetLineIndex(LineNo: Integer): Integer;
    function GetLineLength(CharIndex: Integer): Integer;
    function GetNextWord(var s: string; var PrevWord: string): string;
    function GetRTFSelection(intoStream: TStream ): String;
    function GetRTFTextToString: string;
    function GetSelectedText(var SelectedText: string):boolean;
    function GetVisibleLines: Integer;
    function IsNumber(s: string): Boolean;
    function IsSeparator(Car: Char): Boolean;
    function RemoveTextFormats: integer;
    function SearchAndReplace(InSearch, InReplace: string): integer;
    function SearchForTextAndSelect(SearchText: string): string;
    function SelectLine(Index: Integer): boolean;
    procedure AlignText(alignment: TAlignment);
    procedure AppendRTF(str : String);
    procedure CheckCapslock;
    procedure CheckInsertKey;
    procedure CheckNumLock;
    procedure CreateSnapShot(Pic: TBitmap);
    procedure DoHighlightHTML;
    procedure DoHighlightXML;
    procedure Find;
    procedure GetMemStatus;
    procedure GoToPosition(LineNumber, CharNumber: Word);
    procedure LoadAsCopyFromBrowser;
    procedure LoadFromFile(FileName: string);
    procedure LoadFromStream(S: TStream);
    procedure LoadHTMLFromBrowser;
    procedure LoadStreamFromBrowser;
    procedure LoadStringsFromBrowser;
    procedure LoadTextFromBrowser;
    procedure MailContext;
    procedure MailSelected;
    procedure New;
    procedure Open;
    procedure PreviewInBrowser;
    procedure PrintAll;
    procedure PrintSelectedText;
    procedure Replace;
    procedure Save;
    procedure SaveAs;
    procedure SaveToFile(FileName: string);
    procedure SaveToStream(S: TStream);
    procedure ScrollToBottom;
    procedure ScrollToTop;
    procedure SelAll(Sender: TObject);
    procedure SelectFont;
    procedure SelectionChange; override;
    procedure SetColor;
    procedure SetFontBold;
    procedure SetFontColor;
    procedure SetFontItalic;
    procedure SetFontSize;
    procedure SetFontUnderLine;
    procedure SetLineSpacing(lineSpacing: Byte);
    procedure SetOffSetsValues(SetTo: Integer);
    procedure SetSelectedBgColor;
    procedure SetSelectionHyperLink(Hyperlink: Boolean);
    procedure SetTabWidth(FTabWidth: Integer);
    procedure SetThemes(Thm: TThemes);
    procedure SetToMoreThen64KB;
    procedure SetToOEM(var Key: Char);
    procedure SetWordHyperLink(Hyperlink: Boolean);
    procedure UndoLast(Sender: TObject);
    property CanUndo: Boolean read GetCanUndo;
    property Modified: Boolean read GetModified write SetModified;
    property AutoVerbMenu: boolean read FAutoVerbMenu write FAutoVerbMenu default true;

  published
    procedure DblClick; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y:
              Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y:
              Integer); override;
    property AcceptDragComponnents : Boolean read fAcceptDragComponnents write
             fAcceptDragComponnents default True;
    property AcceptDragFiles : Boolean read fAcceptDragFiles write
             fAcceptDragFiles default True;
    property AutoNavigate: boolean read fAutoNavigate write fAutoNavigate;
    property EmbeddedWB: TEmbeddedWB read fEmbeddedWB write fEmbeddedWB;
    property FileName: string read fFileName write SetFileName;
    property GapBottom : Integer read FBottomGap write setBottomGap default 0;
    property GapLeft : Integer read FLeftGap write setLeftGap default 0;
    property GapRight : Integer read FRightGap write setRightGap default 0;
    property GapTop : Integer read FTopGap write setTopGap default 0;
    property HighlightHTML: boolean read fHTMLHighlight write fHTMLHighlight;
    property HighlightURL: boolean read fHighlightURL write fHighlightURL;
    property HighlightXML: boolean read fXMLHighlight write fXMLHighlight;
    property Image: TImage read fImage write fImage;
    property OnURLClick : TURLClickEvent read FOnURLClick write FOnURLClick;
    property RTFText: string read GetRTFText write SetRTFText;
    property Statusbar: TStatusbar read fStatusbar write fStatusbar;
    property SupprtMoreThen64KB: boolean read fMoreThen64KB write fMoreThen64KB;
    property TextAlignment: TAlignment read fTextAlignment write fTextAlignment;
    property HideCaret: Boolean read FHideCaret write SetHideCaret;
    property Themes: TThemes read fThemes write fThemes;

    property Align;
    property Alignment;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind default bkNone;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property HideScrollBars;
    property ImeMode;
    property ImeName;
    property Constraints;
    property Lines;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PlainText;
    property PopupMenu;
    property ReadOnly;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property WantTabs;
    property WantReturns;
    property WordWrap;
    property OnChange;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnendDock;
    property OnendDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    {$IFDEF DELPHI_9_UP}
    property OnMouseActivate;
    {$ENDIF}
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnProtectChange;
    property OnResizeRequest;
    property OnSaveClipboard;
    property OnSelectionChange;
    property OnStartDock;
    property OnStartDrag;
  end;


type
  TREObject = Packed Record
    cbStruct : DWORD;
    cp : longint;
    clsid : TCLSID;
    oleobj : IOleObject;
    stg : IStorage;
    olesite : IOLEClientSite;
    SIZEL : TSize;
    dvaspect : DWORD;
    dwFlags : DWORD;
    dwUser : DWORD
 end;

  type
  IRichEditOle = Interface(IUnknown) ['{00020d00-0000-0000-c000-000000000046}']
    function GetClientSite(Out clientSite : IOleClientSite) : HResult;Stdcall;
    function GetObjectCount : HResult;Stdcall;
    function GetLinkCount : HResult;Stdcall;
    function GetObject(iob : Longint;Out reobject : TReObject;
              dwFlags : DWORD) : HResult;Stdcall;
    function InsertObject(var reobject : TReObject) : HResult;Stdcall;
    function ConvertObject(iob : Longint;rclsidNew : TIID;
              lpstrUsertypeNew : LPCSTR) : HResult;Stdcall;
    function ActivateAs(rclsid : TIID;rclsidAs : TIID) : HResult;Stdcall;
    function SetHostNames(lpstrContainerApp : LPCSTR;
             lpstrContainerObj : LPCSTR) : HResult;Stdcall;
    function SetLinkAvailable(iob : Longint;fAvailable : BOOL) : HResult;Stdcall;
    function SetDvaspect(iob : Longint;dvaspect : DWORD) : HResult;Stdcall;
    function HandsOffStorage(iob : Longint) : HResult;Stdcall;
    function SaveCompleted(iob : Longint;Const stg : IStorage) : HResult;Stdcall;
    function InPlaceDeactivate : HResult;Stdcall;
    function ContextSensitiveHelp(fEnterMode : BOOL) : HResult;Stdcall;
    function GetClipboardData(var chrg : TCharRange;reco : DWORD;
              Out dataobj : IDataObject) : HResult;Stdcall;
    function ImportDataObject(dataobj : IDataObject;cf : TClipFormat;
             hMetaPict : HGLOBAL) : HResult;Stdcall;
  end;

  IRichEditOleCallback = Interface(IUnknown)
    ['{00020d03-0000-0000-c000-000000000046}']
    function GetNewStorage(Out stg : IStorage) : HResult;Stdcall;
    function GetInPlaceContext(Out Frame : IOleInPlaceFrame;
      Out Doc : IOleInPlaceUIWindow;
      lpFrameInfo : POleInPlaceFrameInfo) : HResult;Stdcall;
    function ShowContainerUI(fShow : BOOL) : HResult;Stdcall;
    function QueryInsertObject(Const clsid : TCLSID;Const stg : IStorage;
      cp : Longint) : HResult;Stdcall;
    function DeleteObject(Const oleobj : IOleObject) : HResult;Stdcall;
    function QueryAcceptData(Const dataobj : IDataObject;
      var cfFormat : TClipFormat;reco : DWORD;fReally : BOOL;
      hMetaPict : HGLOBAL) : HResult;Stdcall;
    function ContextSensitiveHelp(fEnterMode : BOOL) : HResult;Stdcall;
    function GetClipboardData(Const chrg : TCharRange;reco : DWORD;
      Out dataobj : IDataObject) : HResult;Stdcall;
    function GetDragDropEffect(fDrag : BOOL;grfKeyState : DWORD;
      var dwEffect : DWORD) : HResult;Stdcall;
    function GetContextMenu(seltype : Word;Const oleobj : IOleObject;
      Const chrg : TCharRange;Out Menu : HMENU) : HResult;Stdcall;
  end;

type
  TRichEditOleCallback = Class(TInterfacedObject, IRichEditOleCallback)
  Public
    function QueryInterface(Const iid : TGUID;Out Obj) : HResult;Stdcall;
    function _AddRef : Longint;Stdcall;
    function _Release : Longint;Stdcall;
    function GetNewStorage(Out stg : IStorage) : HResult;Stdcall;
    function GetClipboardData(Const chrg : TCharRange;reco : DWORD;
      Out dataobj : IDataObject) : HResult;Stdcall;
    function GetContextMenu(seltype : Word;Const oleobj : IOleObject;
      Const chrg : TCharRange;Out Menu : HMENU) : HResult;Stdcall;
    function GetInPlaceContext(Out Frame : IOleInPlaceFrame;
      Out Doc : IOleInPlaceUIWindow;
      lpFrameInfo : POleInPlaceFrameInfo) : HResult;Stdcall;
    function ShowContainerUI(fShow : BOOL) : HResult;Stdcall;
    function QueryInsertObject(Const clsid : TCLSID;Const stg : IStorage;
      cp : Longint) : HResult;Stdcall;
    function DeleteObject(Const oleobj : IOleObject) : HResult;Stdcall;
    function QueryAcceptData(Const dataobj : IDataObject;var cfFormat : TClipFormat;
      reco : DWORD;fReally : BOOL;hMetaPict : HGLOBAL) : HResult;Stdcall;
    function ContextSensitiveHelp(fEnterMode : BOOL) : HResult;Stdcall;
    function GetDragDropEffect(fDrag : BOOL;grfKeyState : DWORD;
      var dwEffect : DWORD) : HResult;Stdcall;
  end;

   procedure CreateIStorage(Out Fstorage : Istorage);
   function GetRichOleInterface(ARichEdit : TRichEdit;Out RichOleInterface : IRichEditOle;Out OleClientSite : IOleclientSite) : boolean;
   procedure REOleSetCallback(RichEdit : TRichEdit;OleInterface : IRichEditOleCallback);
   procedure ReleaseObject(var Obj);
   function SetFormatEtc(Cf : TClipFormat;med : Longint;td : PDVTargetDevice = Nil;
    Asp : Longint = DVASPECT_CONTENT;li : Longint = -1) : TFormatEtc;
   function OleSwitchDisplayAspect(OleObject : IOleObject;var CurrentAspect : DWORD;
    NewAspect : DWORD;METAFILEPICT : THandle;DeleteOldAspect, SetUpViewAdvise : boolean;
    AdviseSink : IAdviseSink;var MustUpdate : boolean) : HRESULT;
   function GetOleClassFile(Const Name : String) : TCLSID;
   function OleCopyPasString(Const Source : String;Malloc : IMalloc = Nil) : POleStr;
   function SetStgMedium(Stg, Handle : longint;Release : pointer = Nil) : TStgMedium;
   procedure OleFreeString(Str : POleStr;Malloc : IMalloc = Nil);
   function OleMalloc(Size : Longword;Malloc : IMalloc = Nil) : pointer;
   procedure OleFree(Mem : pointer;Malloc : IMalloc = Nil);
   procedure ChangeOleIcon(REdit : TRichEdit;HIcon : Hwnd;LabelIcon : String);

 var
  MyCallback          : TRichEditOleCallback;
  FRichEditModule     : THandle;
  RichEditOle         : IRichEditOle;
  RichEditOleCallback : IRichEditOleCallback;
 // RichEditVersion     : TRichEditVersion;
procedure Register;

implementation

uses  StdCtrls,dialogs, Forms, Printers, sysUtils ,ShellAPI, JPEG;

resourcestring
  sSaveChanges = 'Save changes to %s?';
  sOverWrite   = 'The file already exist. Do you want to overwrite %s ?';
  sUntitled    = 'Untitled';
  sModified    = 'Modified';
  sColRowInfo  = 'Line: %3d   Col: %3d';


procedure Register;
begin
  RegisterComponents('Embedded Web Browser', [TRichEditWB]);
end;

type
  TImageDataObject  = class(TInterfacedObject, IDataObject)
  private
    FMedium:        STGMEDIUM;
    FFormat:        FORMATETC;
    FHasData:       Boolean;
  protected
    function GetData(const formatetcIn: TFormatEtc; out medium: TStgMedium): HResult; stdcall;
    function GetDataHere(const formatetc: TFormatEtc; out medium: TStgMedium): HResult; stdcall;
    function QueryGetData(const formatetc: TFormatEtc): HResult; stdcall;
    function GetCanonicalFormatEtc(const formatetc: TFormatEtc; out formatetcOut: TFormatEtc): HResult; stdcall;
    function SetData(const formatetc: TFormatEtc; var medium: TStgMedium; fRelease: BOOL): HResult; stdcall;
    function EnumFormatEtc(dwDirection: Longint; out enumFormatEtc: IEnumFormatEtc): HResult; stdcall;
    function DAdvise(const formatetc: TFormatEtc; advf: Longint; const advSink: IAdviseSink; out dwConnection: Longint): HResult; stdcall;
    function DUnadvise(dwConnection: Longint): HResult; stdcall;
    function EnumDAdvise(out enumAdvise: IEnumStatData): HResult; stdcall;
    procedure SetBitmap(const ASource: TBitmap);
    function GetOleObject(const AClient: IOleClientSite;
                          const AStorage: IStorage): IOleObject;
  public
    class procedure InsertBitmap(ADest: TCustomRichEdit; ASource: TBitmap);
    destructor Destroy(); override;
  end;

class procedure TImageDataObject.InsertBitmap;
var
  idoImage:       TImageDataObject;
  ifOLE:          IRichEditOle;
  ifData:         IDataObject;
  ifClient:       IOleClientSite;
  ifStorage:      IStorage;
  ifBytes:        ILockBytes;
  ifOLEObject:    IOleObject;
  sCode:          HRESULT;
  reObj:          TREObject;
  gdClass:        TGUID;
begin
  ifOLE := nil;
  SendMessage(ADest.Handle, EM_GETOLEINTERFACE, 0, LPARAM(@ifOLE));
  if Assigned(ifOLE) then
    try
      idoImage  := TImageDataObject.Create();
      if idoImage.GetInterface(IDataObject, ifData) then
        try
          idoImage.SetBitmap(ASource);
          ifClient  := nil;
          ifOLE.GetClientSite(ifClient);
          if Assigned(ifClient) then
            try
              ifBytes := nil;
              sCode   := CreateILockBytesOnHGlobal(0, True, ifBytes);
              if (sCode = S_OK) and (Assigned(ifBytes)) then
                try
                  sCode   := StgCreateDocfileOnILockBytes(ifBytes, STGM_SHARE_EXCLUSIVE or
                                STGM_CREATE or STGM_READWRITE, 0, ifStorage);
                  if sCode = S_OK then
                    try
                      ifOLEObject := idoImage.GetOleObject(ifClient, ifStorage);
                      if Assigned(ifOLEObject) then
                        try
                          OleSetContainedObject(ifOLEObject, True);
                          sCode := ifOLEObject.GetUserClassID(gdClass);
                          if sCode = S_OK then
                           begin
                            with reObj do
                             begin
                              //clsid       := '';
                              cp        := LongInt(REO_CP_SELECTION);
                              dvaspect  := DVASPECT_CONTENT;
                              oleobj    := ifOLEObject;
                              olesite   := ifClient;
                              stg       := ifStorage;
                            end;
                            ifOLE.InsertObject(reObj);
                          end;
                        finally
                          ifOLEObject := nil;
                        end;
                    finally
                      ifStorage := nil;
                    end;
                finally
                  ifBytes := nil;
                end;
            finally
              ifClient  := nil;
            end;
        finally
          ifData  := nil;
        end;
    finally
      ifOLE := nil;
    end;
end;

procedure TImageDataObject.SetBitmap;
begin
  FMedium.tymed          := TYMED_GDI;
  FMedium.hBitmap        := ASource.Handle;
  FMedium.unkForRelease  := nil;
  FFormat.cfFormat       := CF_BITMAP;
  FFormat.ptd            := nil;
  FFormat.dwAspect       := DVASPECT_CONTENT;
  FFormat.lindex         := -1;
  FFormat.tymed          := TYMED_GDI;
end;

function TImageDataObject.GetOleObject;
var
  sCode:        HRESULT;
begin
  sCode := OleCreateStaticFromData(Self, IOleObject, OLERendER_FORMAT,
                                   @FFormat, AClient, AStorage, Result);
  if sCode <> S_OK then
  begin
    OleCheck(sCode);
    Result  := nil;
  end;
end;

destructor TImageDataObject.Destroy;
begin
  if FHasData then
    ReleaseStgMedium(FMedium);
  inherited;
end;

function TImageDataObject.GetData;
var
  hDest:      THandle;

begin
  hDest := OleDuplicateData(FMedium.hBitmap, CF_BITMAP, 0);
  if (hDest <> 0) then
  begin
    medium.tymed          := TYMED_GDI;
    medium.hBitmap        := hDest;
    medium.unkForRelease  := nil;
  	Result                := S_OK;
  end
  else
    Result                := E_HANDLE;  
end;

function TImageDataObject.GetDataHere;
begin
  Result  := E_NOTIMPL;
end;

function TImageDataObject.QueryGetData;
begin
  Result  := E_NOTIMPL;
end;

function TImageDataObject.GetCanonicalFormatEtc;
begin
  Result  := E_NOTIMPL;
end;

function TImageDataObject.SetData;
begin
  FMedium   := medium;
  FFormat   := formatetc;
  FHasData  := True;
  Result    := S_OK;
end;

function TImageDataObject.EnumFormatEtc;
begin
  Result  := E_NOTIMPL;
end;

function TImageDataObject.DAdvise;
begin
  Result  := E_NOTIMPL;
end;

function TImageDataObject.DUnadvise;
begin
  Result  := E_NOTIMPL;
end;

function TImageDataObject.EnumDAdvise;
begin
  Result  := E_NOTIMPL;
end;

function TRichEditOleCallback.QueryInterface(Const iid : TGUID;Out Obj) : HResult;
begin
  If GetInterface(iid, Obj) Then
    Result := S_OK
  Else
    Result := E_NOINTERFACE;
end;

function TRichEditOleCallback._AddRef : LongInt;
begin
  Inc(FRefCount);
  Result := FRefCount;
end;

function TRichEditOleCallback._Release : LongInt;
begin
  Dec(FRefCount);
  Result := FRefCount;
end;

function TRichEditOleCallback.GetNewStorage(Out stg : IStorage) : HResult;
begin
  Try
    CreateIStorage(stg);
    Result := S_OK;
  Except
    Result := E_OUTOFMEMORY;
  end;
end;

function TRichEditOleCallback.GetClipboardData(Const chrg : TCharRange;reco : DWORD;
  Out dataobj : IDataObject) : HResult;
begin
  Result := E_NOTIMPL;
end;

function TRichEditOleCallback.GetContextMenu(seltype : Word;
  Const oleobj : IOleObject;Const chrg : TCharRange;
  Out Menu : HMENU) : HResult;
begin
 // menu:=0;
  Result:= S_OK; // Result := E_NOTIMPL;
end;

function TRichEditOleCallback.GetInPlaceContext(Out Frame : IOleInPlaceFrame;Out Doc : IOleInPlaceUIWindow;lpFrameInfo : POleInPlaceFrameInfo) : HResult;
begin
  Result := S_OK;
end;

function TRichEditOleCallback.QueryInsertObject(Const clsid : TCLSID;Const stg : IStorage;
  cp : Longint) : HResult;
begin
  Result := NOERROR;
end;

function TRichEditOleCallback.DeleteObject(Const oleobj : IOleObject) : HResult;
begin
  If Assigned(oleobj) Then oleobj.Close(OLECLOSE_NOSAVE);
  Result := NOERROR;
end;

function TRichEditOleCallback.QueryAcceptData(Const dataobj : IDataObject;
  var cfFormat : TClipFormat;reco : DWORD;fReally : BOOL;
  hMetaPict : HGLOBAL) : HResult;
begin
  Result := S_OK;
end;

function TRichEditOleCallback.ContextSensitiveHelp(fEnterMode : BOOL) : HResult;
begin
  Result := NOERROR;
end;

function TRichEditOleCallback.GetDragDropEffect(fDrag : BOOL;grfKeyState : DWORD;
  var dwEffect : DWORD) : HResult;
begin
  Result := E_NOTIMPL;
end;

function TRichEditOleCallback.ShowContainerUI(fShow : BOOL) : HResult;
begin
  Result := S_OK;
end;

procedure CreateIStorage(Out Fstorage : Istorage);
var
  FlockBytes : IlockBytes;
begin
  OleCheck(CreateILockBytesOnHGlobal(0, True, FLockBytes));
  OleCheck(StgCreateDocfileOnILockBytes(FLockBytes, STGM_SHARE_EXCLUSIVE Or STGM_CREATE Or STGM_READWRITE, 0, FStorage))
end;

function GetRichOleInterface(ARichEdit : TRichEdit;Out RichOleInterface : IRichEditOle;Out OleClientSite : IOleclientSite) : boolean;
var
  AppName : String;
begin
  Result := False;
  If boolean(SendMessage(ARichEdit.Handle, EM_GETOLEINTERFACE, 0, longint(@RichOleInterface))) Then
  begin
    Try
      AppName := Application.Title;
      If Trim(AppName) = '' Then AppName := ExtractFileName(Application.ExeName);
      RichOleInterface.SetHostNames(PChar(AppName), PChar(AppName));
      RichOleInterface.GetClientSite(OleclientSite);
      Result := True;
    Except
      Result := False;
    end;
  end;
end;

procedure REOleSetCallback(RichEdit : TRichEdit;OleInterface : IRichEditOleCallback);
begin
  SendMessage(RichEdit.Handle, EM_SETOLECALLBACK, 0, LPARAM(Oleinterface));
end;

procedure ReleaseObject(var Obj);
begin
  If IUnknown(Obj) <> Nil Then
  begin
    IUnknown(Obj)._Release;
    IUnknown(Obj) := Nil;
  end;
end;

function SetFormatEtc(Cf : TClipFormat;med : Longint;td : PDVTargetDevice = Nil;
  Asp : Longint = DVASPECT_CONTENT;li : Longint = -1) : TFormatEtc;
begin
  With Result Do
  begin
    cfFormat := cf;
    dwAspect := asp;
    ptd := td;
    tymed := med;
    lindex := li
  end
end;

function OleSwitchDisplayAspect(OleObject : IOleObject;var CurrentAspect : DWORD;
  NewAspect : DWORD;METAFILEPICT : THandle;DeleteOldAspect, SetUpViewAdvise : boolean;
  AdviseSink : IAdviseSink;var MustUpdate : boolean) : HRESULT;
var
  OleCache : IOleCache;
  ViewObject : IViewObject;
  EnumStatData : IEnumStatData;
  StatData : TStatData;
  FormatEtc : TFormatEtc;
  Medium : TStgMedium;
  Advf,
    NewConnection,
    OldAspect : longint;
  Error : HRESULT;
begin
  OleCache := Nil;
  ViewObject := Nil;
  EnumStatData := Nil;
  OldAspect := CurrentAspect;
  MustUpdate := False;
  If Failed(OleObject.QueryInterface(IOleCache, OleCache)) Then
  begin
    Result := E_INVALIDARG;
    Exit
  end;
  FormatEtc := SetFormatEtc(0, TYMED_NULL, Nil, NewAspect);
  If (NewAspect = dvaspect_Icon) And (METAFILEPICT <> 0) Then
    Advf := advf_nodata
  Else
    Advf := ADVF_PRIMEFIRST;
  Result := OleCache.Cache(FormatEtc, Advf, NewConnection);
  If Failed(Result) Then
    Exit;
  CurrentAspect := NewAspect;
  If (NewAspect = dvaspect_Icon) And (METAFILEPICT <> 0) Then
  begin
    FormatEtc := SetFormatEtc(CF_METAFILEPICT, TYMED_MFPICT, Nil, dvaspect_Icon);
    Medium := SetStgMedium(TYMED_MFPICT, METAFILEPICT);
    OleCache.SetData(FormatEtc, Medium, False)
  end
  Else
    MustUpdate := True;
  If SetUpViewAdvise And Assigned(AdviseSink) Then
    If Succeeded(OleObject.QueryInterface(IViewObject, ViewObject)) Then
    begin
      ViewObject.SetAdvise(NewAspect, 0, AdviseSink);
      ViewObject := Nil
    end;
  If DeleteOldAspect Then
  begin
    Error := OleCache.EnumCache(EnumStatData);
    While Error = S_OK Do
    begin
      Error := EnumStatData.Next(1, StatData, Nil);
      If Error = S_OK Then
        If StatData.FormatEtc.dwAspect = OldAspect Then
           OleCache.Uncache(StatData.dwConnection)
    end
  end;
  Result := S_OK
end;

function GetOleClassFile(Const Name : String) : TCLSID;
var
  Buffer : POleStr;
begin
  Result := CLSID_NULL;
  Buffer := OleCopyPasString(Name);
  Try
    OleCheck(GetClassFile(Buffer, Result))
  Finally
    If Assigned(Buffer) Then
      OleFreeString(Buffer)
  end
end;

function OleCopyPasString(Const Source : String;Malloc : IMalloc = Nil) : POleStr;
var
  Size : Integer;
begin
  Size := Length(Source);
  If Size = 0 Then
    Result := Nil
  Else
  begin
    Inc(Size);
    Result := OleMalloc(Size * SizeOf(WideChar), Malloc);
    If Not Assigned(Result) Then
      OutOfMemoryError;
    StringToWideChar(Source, Result, Size)
  end
end;

function SetStgMedium(Stg, Handle : longint;Release : pointer = Nil) : TStgMedium;
begin
  Result.tymed := Stg;
  Result.hGlobal := Handle;
  Result.unkForRelease := Release
end;

procedure OleFreeString(Str : POleStr;Malloc : IMalloc = Nil);
begin
  OleFree(Str, Malloc)
end;

function OleMalloc(Size : Longword;Malloc : IMalloc = Nil) : pointer;
begin
  If Not Assigned(Malloc) Then
    Result := CoTaskMemAlloc(Size)
  Else
    Result := Malloc.Alloc(Size)
end;

procedure OleFree(Mem : pointer;Malloc : IMalloc = Nil);
var
  Ok : Integer;
begin
  If Not Assigned(Malloc) Then
  begin
    Ok := CoGetMalloc(MEMCTX_TASK, Malloc);
    Assert(Ok = NOERROR, 'CoGetMalloc');
  end;
  Ok := Malloc.DidAlloc(Mem);
  Assert(Ok = S_FALSE, 'Impossible to free the memory');
  Malloc.Free(Mem)
end;

procedure ChangeOleIcon(REdit : TRichEdit;HIcon : Hwnd;LabelIcon : String);
var
  Update : Boolean;
  Selectiontype : Integer;
  RichEditOle : IRichEditOle;
  OleClientSite : IOleClientSite;
  REObject : TReObject;
begin
  Update := True;
  FillChar(ReObject, SizeOf(ReObject), 0);
  ReObject.cbStruct := SizeOf(ReObject);
  Selectiontype := SendMessage(Redit.Handle, EM_SELECTIONtype, 0, 0);
  If selectionType = SEL_OBJECT Then
    GetRichOleInterface(REdit, RichEditOle, OleClientSite);
  OleCheck(RichEditOle.GetObject(Longint(REO_IOB_SELECTION), ReObject, REO_GETOBJ_POLEOBJ Or REO_GETOBJ_POLESITE));
  HIcon := OleMetafilePictFromIconAndLabel(Hicon, OleCopyPasString(LabelIcon), '', 0);
  OleSwitchDisplayAspect(REObject.oleobj, REObject.dvaspect, REObject.dvaspect, Hicon, False, False, Nil, Update);
  OleCheck(REobject.oleobj.Update);
end;

function TRichEditWB.ConvertBitmapToRTF(pict: TBitmap): string;
var
 bi, bb, rtf: string;
 bis, bbs: Cardinal;
 achar: ShortString;
 hexpict: string;
 I: Integer;
begin
 GetDIBSizes(pict.Handle, bis, bbs);
 SetLength(bi, bis);
 SetLength(bb, bbs);
 GetDIB(pict.Handle, pict.Palette, PChar(bi)^, PChar(bb)^);
 rtf := '{\rtf1 {\pict\dibitmap ';
 SetLength(hexpict, (Length(bb) + Length(bi)) * 2);
 I := 2;
 for bis := 1 to Length(bi) do
 begin
   achar := Format('%x', [Integer(bi[bis])]);
   if Length(achar) = 1 then
     achar := '0' + achar;
   hexpict[I - 1] := achar[1];
   hexpict[I] := achar[2];
   Inc(I, 2);
 end;
 for bbs := 1 to Length(bb) do
 begin
   achar := Format('%x', [Integer(bb[bbs])]);
   if Length(achar) = 1 then
     achar := '0' + achar;
   hexpict[I - 1] := achar[1];
   hexpict[I] := achar[2];
   Inc(I, 2);
 end;
 rtf := rtf + hexpict + ' }}';
 Result := rtf;
end;

function TRichEditWB.AddFiles(Files : TStrings;Linked : bool;AsIcon : Bool): integer;
var
  I : Integer;
  FilePath : String;
  Ind : word;
  HIcon : hwnd;
  Update : boolean;
  OleClientSite : IOleClientSite;
  Storage : IStorage;
  OleObject : IOleObject;
  ReObject : TReObject;
  RichEditOle : IrichEditOle;
begin
  Ind := 1;
  Update := True;
  FillChar(ReObject, SizeOf(TReObject), 0);
  For I := 0 To Files.Count - 1 Do
  begin
    FilePath := Files[I];
    If GetRichOleInterface(Self, RichEDitOle, OleClientSite) Then
    begin
      Storage := Nil;
      Try
        CreateIStorage(Storage);
        If Linked Then
          OleCheck(OleCreateLinkToFile(OleCopyPasString(FilePath), IOleObject, OLERendER_DRAW, Nil, OleClientSite, Storage, OleObject))
        Else
          OleCheck(OleCreateLinkToFile(OleCopyPasString(FilePath), IOleObject, OLERendER_DRAW, Nil, OleClientSite, Storage, OleObject));
        With ReObject Do
        begin
          cbStruct := SizeOf(TReObject);
          cp := Integer(REO_CP_SELECTION);
          OleObject.GetUserClassId(CLSID);
          oleobj := OleObject;
          stg := Storage;
          olesite := OleClientSite;
          If Asicon Then
            DvAspect := DVASPECT_ICON
          Else
            DvAspect := DVASPECT_CONTENT;
          dwFlags := REO_RESIZABLE Or REO_DYNAMICSIZE;
        end;
        If IsEqualCLSID(REObject.CLSID, CLSID_NULL) Then
          REObject.CLSID := GetOleClassFile(FilePath);
        HIcon := ShellAPI.ExtractAssociatedIcon(Application.Handle, PChar(FilePath), Ind);
        HIcon := OleMetafilePictFromIconAndLabel(Hicon, OleCopyPasString(ExtractFileName(FilePath)), '', 0);
        OleSwitchDisplayAspect(OleObject, REObject.dvaspect, REObject.dvaspect, Hicon, False, False, Nil, Update);
        OleCheck(RichEditOle.InsertObject(ReObject));
        SendMessage(Self.Handle, EM_SCROLLCARET, 0, 0);
        OleCheck(OleObject.Update);
      Finally
        OleClientSite := Nil;
        Storage := Nil;
      end;
    end;
  end;
  Result := Lines.Count;
end;

function TRichEditWB.AddFile(FilePath : String;Linked : bool;AsIcon : Bool): integer;
var
  Ind : word;
  HIcon : hwnd;
  Update : boolean;
  OleClientSite : IOleClientSite;
  Storage : IStorage;
  OleObject : IOleObject;
  ReObject : TReObject;
  RichEditOle : IrichEditOle;
begin
  inserted:= true;
  Ind := 1;
  Update := True;
  FillChar(ReObject, SizeOf(TReObject), 0);
  If GetRichOleInterface(Self, RichEDitOle, OleClientSite) Then
  begin
    Storage := Nil;
    Try
      CreateIStorage(Storage);
      If Linked Then
        OleCheck(OleCreateLinkToFile(OleCopyPasString(FilePath),
        IOleObject, OLERendER_DRAW, Nil, OleClientSite, Storage, OleObject))
      Else
        OleCheck(OleCreateLinkToFile(OleCopyPasString(FilePath),
         IOleObject, OLERendER_DRAW, Nil, OleClientSite, Storage, OleObject));
      With ReObject Do
      begin
        cbStruct := SizeOf(TReObject);
        cp := Integer(REO_CP_SELECTION);
        OleObject.GetUserClassId(CLSID);
        oleobj := OleObject;
        stg := Storage;
        olesite := OleClientSite;
        If Asicon Then
          DvAspect := DVASPECT_ICON
        Else
          DvAspect := DVASPECT_CONTENT;
          dwFlags := REO_RESIZABLE Or REO_DYNAMICSIZE;
      end;
      If IsEqualCLSID(REObject.CLSID, CLSID_NULL) Then
         REObject.CLSID := GetOleClassFile(FilePath);
      HIcon := ShellAPI.ExtractAssociatedIcon(Application.Handle, PChar(FilePath), Ind);
      HIcon := OleMetafilePictFromIconAndLabel(Hicon, OleCopyPasString(ExtractFileName(FilePath)), '', 0);
      OleSwitchDisplayAspect(OleObject, REObject.dvaspect, REObject.dvaspect, Hicon, False, False, Nil, Update);
      OleCheck(RichEditOle.InsertObject(ReObject));
      SendMessage(Self.Handle, EM_SCROLLCARET, 0, 0);
      OleCheck(OleObject.Update);
    Finally
      OleClientSite := Nil;
      Storage := Nil;
    end;
  end;
  result := Lines.Count;
end;

procedure AddbBitmapToRichEdit(bmp : Tbitmap; RichEdit : TRichEditWB);
function BitmapToRTF(pict: TBitmap): string;
var
  bi,bb,rtf: string;
  bis,bbs: Cardinal;
  achar: ShortString;
  hexpict: string;
  I: Integer;
begin
  GetDIBSizes(pict.Handle,bis,bbs);
  SetLength(bi,bis);
  SetLength(bb,bbs);
  GetDIB(pict.Handle,pict.Palette,PChar(bi)^,PChar(bb)^);
  rtf := '{\rtf1 {\pict\dibitmap ';
  SetLength(hexpict,(Length(bb) + Length(bi)) * 2);
  I := 2;
  for bis := 1 to Length(bi) do
  begin
    achar := Format('%x',[Integer(bi[bis])]);
    if Length(achar) = 1 then
      achar := '0' + achar;
    hexpict[I-1] := achar[1];
    hexpict[I] := achar[2];
    Inc(I,2);
  end;
  for bbs := 1 to Length(bb) do
  begin
    achar := Format('%x',[Integer(bb[bbs])]);
    if Length(achar) = 1 then
      achar := '0' + achar;
    hexpict[I-1] := achar[1]; 
    hexpict[I] := achar[2];
    Inc(I,2);
  end;
  rtf := rtf + hexpict + ' }}';
  Result := rtf;
end;
var
 s : TstringStream;
begin
  S := TStringStream.Create(BitmapToRTF(bmp));
  RichEdit.PlainText := False;
 // RichEdit.StreamMode := [smSelection];
  RichEdit.Lines.LoadFromStream(S);
  S.Free;
end;

function TRichEditWB.AddImages(Files: TStrings): integer;
var
  Ext  : string;
  Pict : TPicture;
  I : Integer;
begin
   Result := 0;
   Pict := TPicture.Create;
   Try
    For I := 0 To Files.Count - 1 Do
    begin
      Ext:= ExtractFileExt(Files[I]);
      if (Ext = '.bmp') or (Ext = '.gif') or (Ext = '.jpg') or (Ext = '.jpeg')then
      begin
        Pict.LoadFromFile(Files[I]);
        Clipboard.Assign(Pict);
        PasteFromClipboard;
        SendMessage(Handle, WM_PASTE, 0, 0);
        Result := Lines.Count;
      end
      else
      begin
      MessageDlg('This format is not supported in this feature.', mtError,[mbOK], 0);
      end
    end;
    Finally
    Pict.Free;
  end;
end;

function TRichEditWB.AddImageUsingClipboard(FilePath : String) : Integer;
var
  Pict : TPicture;
begin
  Pict := TPicture.Create;
  try
    inserted := true;
    Pict.LoadFromFile(FilePath);
    Clipboard.Assign(Pict);
    PasteFromClipboard;
    Result := Lines.Count;
  finally
    Pict.Free;
  end;
end;

function TRichEditWB.AddImage(FilePath : String): Integer;
var
  ImageBMP:TBitmap;
  ImageJPG:TJPEGImage;
begin
     WordWrap := false;
     if (Pos('.bmp',FilePath)>0)or(Pos('.BMP',FilePath)>0) then
       begin
         try
           inserted := true;
           ImageBMP:=TBitmap.Create;
           ImageBMP.LoadFromFile(FilePath);
           Clipboard.Assign(ImageBMP);
         // Clipboard.AsText:=ConvertBitmapToRTF(ImageBMP);
           Result := Lines.Count;
         finally
          PasteFromClipboard;
         end;
         ImageBMP.Free;
       end
      else if (Pos('.jp',FilePath)>0)or(Pos('.JP',FilePath)>0) then
       begin
         try
           ImageJPG:=TJPEGImage.Create;
           ImageJPG.LoadFromFile(FilePath);
           Clipboard.Assign(ImageJPG);
           Result := Lines.Count;
         finally
          PasteFromClipboard;
         end;
         ImageJPG.Free;
       end
     else
 begin
   MessageDlg('This format is not supported in this feature.', mtError,[mbOK], 0);
   Result := 0;
 end
end;

function EditStreamInCallback(dwCookie: Longint; pbBuff: PByte;
 cb: Longint; var pcb: Longint): DWORD; Stdcall;
var
   theStream: TStream;
   dataAvail: LongInt;
 begin
   theStream := TStream(dwCookie);
   with theStream do
     begin
       dataAvail := Size - Position;
       Result := 0;
       if dataAvail <= cb then
         begin
           pcb := Read(pbBuff^, dataAvail);
           if pcb <> dataAvail then
              result := DWord(E_FAIL);
         end
       else
         begin
           pcb := Read(pbBuff^, cb);
           if pcb <> cb then
              result := DWord(E_FAIL);
         end;
     end;
end;

function EditStreamOutCallback(dwCookie: Longint; pbBuff: PByte; cb:
 Longint; var pcb: Longint): DWORD; stdcall;
var
theStream: TStream;
 begin
   theStream := TStream(dwCookie);
   with theStream do
     begin
       if cb > 0 then
         pcb := Write(pbBuff^, cb);
         Result := 0;
     end;
end;

function TRichEditWB.GetRTFSelection(intoStream: TStream ): String;
var
editstream: TEditStream;
 begin
   with editstream do
     begin
       dwCookie:= Longint(intoStream);
       dwError:= 0;
       pfnCallback:= EditStreamOutCallBack;
     end;
   Perform( EM_STREAMOUT, SF_RTF or SFF_SELECTION, longint(@editstream));
   Result := SelText;
end;

function TRichEditWB.AddRTFSelection(sourceStream: TStream): integer;
var
editstream: TEditStream;
 begin
   with editstream do
     begin
       dwCookie:= Longint(sourceStream);
       dwError:= 0;
       pfnCallback:= EditStreamInCallBack;
     end;
   Perform(EM_STREAMIN, SF_RTF or SFF_SELECTION, longint(@editstream));
   Result := Lines.Count;
end;

function TRichEditWB.AddRtfText(str : String): integer;
var
 aMemStream: TMemoryStream;
 begin
   Result := 0;
   if Length(str) > 0 then
     begin
       aMemStream := TMemoryStream.Create;
       try
         aMemStream.Write(str[1],length(str));
         aMemStream.Position := 0;
         AddRTFSelection(aMemStream);
         Result := Lines.Count;
       finally
         aMemStream.Free;
       end;
     end;
end;

procedure TRichEditWB.AppendRTF(str : String);
var start, length, eventmask : integer;
 begin
    eventmask := SendMessage(Handle,EM_SETEVENTMASK,0,0);
    SendMessage(Handle,WM_SETREDRAW,0,0);
    start := SelStart;
    length := SelLength;
    SelLength := 0;
    SelStart := System.Length(Text);
    AddRtfText(str);
    SelStart := start;
    SelLength := length;
    SendMessage(Handle,WM_SETREDRAW,1,0);
    InvalidateRect(Handle,nil,true);
    SendMessage(Handle,EM_SETEVENTMASK,0,eventmask);
end;

function TRichEditWB.AddBitmapFromImagelist(const ASource: TCustomImageList;
                                                 const AImageIndex: TImageIndex): integer;
var
  bmpImage:       TBitmap;
begin
  inserted := true;
  bmpImage  := TBitmap.Create();
  try
    ASource.GetBitmap(AImageIndex, bmpImage);
    BmpImage.Width := ASource.Width + 1;
    BmpImage.Height:= ASource.Height + 1;
    TImageDataObject.InsertBitmap(Self, bmpImage);
    Result := Lines.Count;
  finally
    FreeAndNil(bmpImage);
  end;
end;

procedure TRichEditWB.WMPaint(var Msg: TWMPaint);
var
  DC: HDC;
 // R, R1: TRect;
begin
  DC := GetDC(Handle);
  if Transparent= 1 then
    SetBkMode(DC, Windows.TRANSPARENT)
  else
    SetBkMode(DC, Windows.OPAQUE);
    ReleaseDC(Handle, DC);
 {   if RichEditVersion >= 2 then
    inherited
  else
  begin
    if GetUpdateRect(Handle, R, True) then
    begin
      with ClientRect do
        R1 := Rect(Right - 3, Top, Right, Bottom);
      if IntersectRect(R, R, R1) then
        InvalidateRect(Handle, @R1, True);
    end;
  end;}inherited
end;

procedure TRichEditWB.DoSetMaxLength(Value: Integer);
begin
  if Value = 0 then
     Value := $FFFFFF;
     SendMessage(Handle, EM_EXLIMITTEXT, 0, Value);
end;

procedure TRichEditWB.SetHideCaret(const Value: Boolean);
begin
  if FHideCaret <> Value then
    FHideCaret := Value;
 if FHideCaret then
    Windows.HideCaret(Handle);
end;

function TRichEditWB.GetLineFromChar(CharIndex: Integer): Integer;
begin
  Result := SendMessage(Handle, EM_EXLINEFROMCHAR, 0, CharIndex);
end;

function TRichEditWB.GetLineIndex(LineNo: Integer): Integer;
begin
  Result := SendMessage(Handle, EM_LINEINDEX, LineNo, 0);
end;

procedure TRichEditWB.SelectionChange;
begin
  if Assigned(OnSelectionChange) then OnSelectionChange(Self);
end;

procedure TRichEditWB.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
 {   case RichEditVersion of
    1: CreateSubClass(Params, RICHEDIT_CLASS10A);
  else
       CreateSubClass(Params, RICHEDIT_CLASS);
  end; }
    Params.Style := Params.Style or WS_CLIPCHILDREN;
 if FRichEditModule = 0 then
  begin
    FRichEditModule := LoadLibrary('RICHED20.DLL');
 if FRichEditModule <= HINSTANCE_ERROR then
    FRichEditModule := 0;
  end;
 CreateSubClass(Params, RICHEDIT_CLASS);
end;

procedure TRichEditWB.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  SetEditRect;
end;

procedure TRichEditWB.SetEditRect;
var
  Loc: TRect;
begin
  SetRect(Loc, FLeftGap, FTopGap, (ClientWidth -1) -FRightGap, (ClientHeight + 1) - FBottomGap);
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
end;

procedure TRichEditWB.setLeftGap(value : Integer);
begin
 if (FLeftGap <> value) AND (value > -1) then
 begin
   FLeftGap := value;
   ReCreateWnd;
 end;
end;

procedure TRichEditWB.setTopGap(value : Integer);
begin
  if (FTopGap <> value) and (value > -1) then
 begin
   FTopGap := value;
   ReCreateWnd;
 end;
end;

procedure TRichEditWB.setRightGap(value : Integer);
begin
 if (FRightGap <> value) and (value > -1) then
 begin
   FRightGap := value;
   ReCreateWnd;
 end;
end;

procedure TRichEditWB.setBottomGap(value : Integer);
begin
 if (FBottomGap <> value) and (value > -1) then
 begin
   FBottomGap := value;
   ReCreateWnd;
 end;
end;

procedure TRichEditWB.PrintAll;
var
 PD : TPrintDialog;
begin
     PD := TPrintDialog.Create(Self);
  try
  if PD.Execute then
     begin
       Print(Self.Lines.Text);
     end;
   finally
   PD.Free;
   end;
end;

function TRichEditWB.AddText(const txt: string): integer;
begin
  Lines.Add(txt);
  Result := Lines.Count;
end;

function TRichEditWB.AddTextByCursor(str: string): integer;
var
  Str1: string;
  i, ui: Integer;
begin
  ui   := Length(Lines[CaretPos.y]);
  str1 := Lines[CaretPos.y];
  if Pos('<$Cursor$>', str) > 0 then
  begin
    i   := Pos('<$Cursor$>', str);
    str := StringReplace(str, '<$Cursor$>', '', [rfReplaceAll, rfIgnoreCase]);
    i   := i - 1 + ui;
  end
  else
    i := -30;
  System.Insert(str, Str1, CaretPos.x + 1);
  Lines[CaretPos.y] := str1;
  if i <> -30 then
  begin
    SelStart := Perform(EM_LINEINDEX, CaretPos.y, 0) + i;
    SetFocus;
  end;
  Result := Lines.Count;
end;

function TRichEditWB.GetCharactersCount: integer;
 begin
 Result := GetTextLen;
end;

procedure TRichEditWB.SetTabWidth(FTabWidth: Integer);
begin
  WantTabs := True;
  SendMessage(Handle, EM_SETTABSTOPS, 1, Longint(@FTabWidth));
end;

procedure TRichEditWB.SetOffSetsValues(SetTo: Integer);
var
 Rect: TRect;
begin
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Rect));
  Rect.Left:= SetTo;
  SendMessage(Handle, EM_SETRECT, 0, LongInt(@Rect));
  Refresh;
end;

function TRichEditWB.GetLineLength(CharIndex: Integer): Integer;
begin
  Result := SendMessage(Handle, EM_LINELENGTH, CharIndex, 0);
end;

procedure TRichEditWB.SetToOEM(var Key: Char);
var
  ch: string[1];
begin
  Font.Handle := GetStockObject(OEM_FIXED_FONT);
  CharToOem(@Key, @ch[1]);
  Key := ch[1];
end;

procedure TRichEditWB.GetMemStatus;
var
  memory: TMemoryStatus;
begin
  memory.dwLength := SizeOf(memory);
  GlobalMemoryStatus(memory);
  ShowMessage('Total memory: '  + IntToStr(memory.dwTotalPhys) + ' Bytes'
  +#10+#13+'Available memory: ' + IntToStr(memory.dwAvailPhys) + ' Bytes');
end;

function TRichEditWB.IsSeparator(Car: Char): Boolean;
begin
  case Car of
    '.', ';', ',', ':',  '!', '"', '''', '^', '+', '-', '*', '/', '\', ' ',
    '`', '[', ']', '(', ')', '{', '}', '?', '%', '=': Result := True;
    else
      Result := False;
  end;
end;

function TRichEditWB.GetNextWord(var s: string; var PrevWord: string): string;
begin
  Result   := '';
  PrevWord := '';
  if s = '' then Exit;
  while (s <> '') and IsSeparator(s[1]) do 
  begin
    PrevWord := PrevWord + s[1];
    Delete(s, 1,1);
  end;
  while (s <> '') and not IsSeparator(s[1]) do 
  begin
    Result := Result + s[1];
    Delete(s, 1,1);
  end;
end;

function TRichEditWB.IsNumber(s: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 1 to Length(s) do
    case s[i] of
      '0'..'9':;
      else 
        Exit;
    end;
  Result := True;
end;

function TRichEditWB.GetVisibleLines: Integer;
begin
  Result := Height div (Abs(Self.Font.Height) + 2);
end;

procedure TRichEditWB.DoHighlightHtml;
var
 ms : TMemoryStream;
begin
  if HighlightHTML then
   begin
    HTMLSyn := THighlightHTML.Create;
    HTMLSyn.SetText(Text);
    ms := TMemoryStream.Create;
    HTMLSyn.ConvertToRTFStream(ms);
    PlainText := false;
    ms.Position := 0;
    Lines.LoadFromStream(ms);
    PlainText := true;
    ms.Free;
    HTMLSyn.Free;
  end;
end;

procedure TRichEditWB.DoHighlightXML;
var
 ms : TMemoryStream;
begin
   if HighlightXML then
   begin
     XMLSyn := THighlightXML.Create;
     XMLSyn.SetText(Text);
     ms := TMemoryStream.Create;
     XMLSyn.ConvertToRTFStream(ms);
     PlainText := false;
     ms.Position := 0;
     Lines.LoadFromStream(ms);
     PlainText := true;
     ms.Free;
     XMLSyn.Free;
   end;   
end;

procedure TRichEditWB.CreateSnapShot(Pic: TBitmap);
var
    psd : TSaveDialog;
    Range: TFormatRange;
    TextBounary : TRect;
begin
    Pic.Width := Width;
    Pic.Height := Height;
    if (Pic.Width <> 0) and (Pic.Height <> 0) then
        Pic.Canvas.Draw(0, 0, Pic)
    else
        with Pic.Canvas do
        begin
            Brush.Color := Color;
            FillRect(ClipRect);
        end;
    Pic.Canvas.Brush.Style := bsClear;
    TextBounary := Rect(0, 0, Width * Screen.PixelsPerInch, Height * Screen.PixelsPerInch);
    with Range  do
    begin
       hdc := Pic.Canvas.Handle;
       hdcTarget := Pic.Canvas.Handle;
       rc := TextBounary;
       rcPage := TextBounary;
       chrg.cpMin := 0;
       chrg.cpMax := -1;
    end;
    SendMessage(Handle, EM_FORMATRANGE, 1, Longint(@Range));
    SendMessage(Handle, EM_FORMATRANGE, 0, 0);
 if Not Assigned(fImage) then
  begin
    psd := TSaveDialog.Create(Self);
    psd.FileName := 'EditorImage.bmp';
    psd.Filter   := 'BMP file | (*.bmp)';
   try
    if psd.Execute then
    if FileExists(psd.FileName) then
    if MessageDlg(Format(sOverWrite, [psd.FileName]), mtConfirmation, mbYesNoCancel, 0)
       <> idYes then Exit;
    Pic.SaveToFile(psd.FileName+'.bmp');
  finally
  psd.Free;
  end;
 end; 
end;

procedure TRichEditWB.CutSel(Sender: TObject);
begin
  if not ReadOnly then
  CutToClipboard;
end;

procedure TRichEditWB.Prnt(Sender: TObject);
begin
  Print(Text);
end;

procedure TRichEditWB.CopySel(Sender: TObject);
begin
  CopyToClipboard;
end;

procedure TRichEditWB.ClearSel(Sender: TObject);
begin
  if not ReadOnly then
  ClearSelection;
end;

procedure TRichEditWB.PasteSel(Sender: TObject);
begin
  if not ReadOnly then
  PasteFromClipboard;
end;

procedure TRichEditWB.SelAll(Sender: TObject);
begin
  SelectAll;
end;

procedure TRichEditWB.ClearAll(Sender: TObject);
begin
  if not ReadOnly then
  Clear;
end;

procedure TRichEditWB.UndoLast(Sender: TObject);
begin
  Undo;
end;

procedure TRichEditWB.SetHyperLink(Setlink: Boolean; wParam: Integer);
var
  cf: TCharFormat;
begin
  FillChar(cf, SizeOf(cf), 0);
  cf.cbSize := SizeOf(cf);
  cf.dwMask := CFM_LINK or CFM_COLOR or CFM_UNDERLINE;

  if Setlink then
  begin
    cf.dwEffects := CFE_LINK or CFE_UNDERLINE;
    cf.crTextColor := COLORREF(clBlue);
  end
  else
  cf.crTextColor := Font.Color;
  SendMessage(Handle, EM_SETCHARFORMAT, wParam, integer(@cf));
end;

procedure TRichEditWB.SetSelectionHyperLink(Hyperlink: Boolean);
begin
  SetHyperlink(Hyperlink, SCF_SELECTION);
end;

procedure TRichEditWB.SetWordHyperLink(Hyperlink: Boolean);
begin
  SetHyperlink(Hyperlink, SCF_WORD or SCF_SELECTION);
end;

procedure TRichEditWB.DoURLClick(const URL : string);
var
  X: Olevariant;
begin
  if  fAutoNavigate  then
  begin
    if Assigned(FOnURLClick) then OnURLClick(Self, URL)
    else
    if Assigned(fEmbeddedWB) then
       begin
         fEmbeddedWB.Navigate(Url, X, X, X, X);
         fEmbeddedWB.SetFocusToDoc;
       end;
  end;
end;

procedure TRichEditWB.CNNotify(var Msg: TWMNotify);
var
  p: TENLink;
  sURL: string;
begin
   if fHighlightURL then
begin
  if (Msg.NMHdr^.code = EN_LINK) then
  begin
   p := TENLink(Pointer(Msg.NMHdr)^);
   if (p.Msg = WM_LBUTTONDOWN) then
   begin
    try
     SendMessage(Handle, EM_EXSETSEL, 0, Longint(@(p.chrg)));
     sURL := SelText;
     DoURLClick(sURL);
    except
    end;
   end;
  end;
 inherited;
 end;
end;

procedure TRichEditWB.CreateWnd;
var
  mask: Word;
begin
  inherited CreateWnd;
  Modified := FModified;
  if fHighlightURL then
  SendMessage(Handle, EM_AUTOURLDETECT,1, 0);
  mask := SendMessage(Handle, EM_GETEVENTMASK, 0, 0);
  SendMessage(Handle, EM_SETEVENTMASK, 0, mask or ENM_LINK);
  SendMessage(Handle, EM_SETBKGNDCOLOR, 0, ColorToRGB(Color));

  DoSetMaxLength(MaxLength);
end;

procedure TRichEditWB.DestroyWnd;
begin
  FModified := Modified;
  inherited DestroyWnd;
end;

procedure TRichEditWB.WndProc(var Msg: TMessage);
  procedure Scroll(Msg, ScrollCode: Integer);
  begin
    Perform(Msg, ScrollCode, 0);
    Perform(Msg, SB_endSCROLL, 0);
  end;

begin
  if FHideCaret and not (csDesigning in ComponentState) then
  begin
    case Msg.Msg of
      WM_LBUTTONDOWN, WM_LBUTTONUP, WM_MOUSEMOVE,
      WM_LBUTTONDBLCLK, WM_CHAR, WM_KEYUP:
        begin
          Msg.Result := 0;
          if Msg.Msg = WM_LBUTTONDOWN then
            if not Focused then
              SetFocus;
          Exit;
        end;
      WM_KEYDOWN:
        begin
          case Msg.WParam of
            VK_DOWN:
              Scroll(WM_VSCROLL, SB_LINEDOWN);
            VK_UP:
              Scroll(WM_VSCROLL, SB_LINEUP);
            VK_LEFT:
              Scroll(WM_HSCROLL, SB_LINELEFT);
            VK_RIGHT:
              Scroll(WM_HSCROLL, SB_LINERIGHT);
            VK_NEXT:
              Scroll(WM_VSCROLL, SB_PAGEDOWN);
            VK_PRIOR:
              Scroll(WM_VSCROLL, SB_PAGEUP);
            VK_HOME:
              Scroll(WM_VSCROLL, SB_TOP);
            VK_end:
              Scroll(WM_VSCROLL, SB_BOTTOM);
          end;
          Msg.Result := 0;
          Exit;
        end;
    end;
  end;
  inherited WndProc(Msg);
end;

constructor TRichEditWB.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if AcceptDragComponnents then
    begin
     ControlStyle := ControlStyle + [csAcceptsControls];
    end;
  CompCount              := 0;
  fAcceptDragComponnents := true;
  fAcceptDragFiles       := true;
  fAutoNavigate          := true;
  FBottomGap             := 0;
  fFileName              := sUntitled;
  fHideCaret             := false;
  fHighlightURL          := true;
  fHTMLHighlight         := true;
  fLeftGap               := 0;
  fMoreThen64KB          := false;
  fRightGap              := 0;
  fStream                := TMemoryStream.Create;
  fTopGap                := 0;
  fXMLHighlight          := true;
  ScrollBars             := ssBoth;
  ShowHint               := true;
  WordWrap               := true;
  FAutoVerbMenu          := true;
  FMax := 0;
  FSelection.cpMin := 0;
  FSelection.cpMax := 0;
end;

function TRichEditWB.GetPopupMenu: TPopupMenu;
var
 canCopy : Boolean;
begin
  Result := inherited GetPopupMenu;
  if SelText <>'' then canCopy := true
  else canCopy :=false;
  if FAutoVerbMenu and Not Assigned(PopupMenu) then
   begin
      FPopupVerbMenu:= TPopupMenu.Create(Self);
      with FPopupVerbMenu do
       begin
           Items.Clear;
           CleanupInstance;
         with Items do
         begin
           Add(NewItem('Undo',0, False, CanUndo, UndoLast, 0, 'MenuItem0'));
           Add(NewLine);
           Add(NewItem('Cut', 0, False, canCopy, CutSel, 2, 'MenuItem2'));
           Add(NewItem('Copy', 0, False, canCopy, CopySel, 3, 'MenuItem3'));
           Add(NewItem('Paste', 0, False, True, PasteSel, 4, 'MenuItem4'));
           Add(NewItem('Select All', 0, False, True, SelAll, 5, 'MenuItem5'));
           Add(NewLine);
           Add(NewItem('Clear', 0, False, True, ClearAll, 6, 'MenuItem6'));
           Add(NewItem('Clear Selection', 0, False, canCopy, ClearSel, 7, 'MenuItem7'));
           Add(NewLine);
           Add(NewItem('Find', 0, False, True, FindDialog, 8, 'MenuItem8'));
           Add(NewLine);
           if fXMLHighlight then
           Add(NewItem('HighLight XML', 0, False, True, DoXMLrc, 9, 'MenuItem9'));
           if fHTMLHighlight then
           Add(NewItem('HighLight HTML', 0, False, True, DoHTMLrc, 10, 'MenuItem10'));
           Add(NewLine);
           Add(NewItem('Print', 0, False, True, Prnt, 12, 'MenuItem12'));
           Add(NewItem('Print Selected Text', 0, False, canCopy, PrintSel, 13, 'MenuItem13'));
           PostMessage(Handle, WM_NULL, 0, 0);
          end;
          Result := FPopupVerbMenu;
        end;
     end;
end;

procedure TRichEditWB.EMExSetSel(var Message: TMessage);
 var
  ISel: integer;
  XSel: ^TCharRange absolute ISel;
begin
 inherited;
 ISel := Message.LParam;
 FSelection := XSel^;
end;

procedure TRichEditWB.EMReplaceSel(var Message: TMessage);
begin
 inherited;
 FMax := FSelection.cpMax + length(PChar(Message.LParam));
end;

function TRichEditWB.GetSelStart: Integer;
 begin
  if FMax = 0 then
   Result := inherited GetSelStart
else
  begin
   Result := FMax;
   FMax := 0;
  end;
end;

procedure TRichEditWB.SetTextAlignment(al: TAlignment);
begin
  Paragraph.Alignment := al;
end;

procedure TRichEditWB.SetThemes(thm: TThemes);
begin
  Themes := Thm;
  if Thm = tBlack then
  begin
     color      := clBlack;
     Font.Color := clWhite;
  end
  else  if Thm = tAluminum then
  begin
     color      := clSilver;
     Font.Color := clWhite;
  end
  else  if Thm = tLight then
  begin
     color      := clInfoBk;
     Font.Color := clBlack;
  end
    else  if Thm = tXP then
  begin
     color      :=  RGB(237,242,251);
     Font.Color := clBlack;
  end
  else if Thm = tDefault then
  begin
     color      := clWindow;
     Font.Color := clBlack;
  end;


end;

procedure TRichEditWB.Loaded;
begin
  inherited Loaded;
  MyCallback := TRichEditOleCallback.Create;
  REOleSetCallback(Self, MyCallBack);
  SetTextAlignment(TextAlignment);
  SetThemes(fThemes);

  UpdateInfo;
  DragAcceptFiles(Handle, True);
  if fMoreThen64KB  then
     SendMessage(Handle, EM_EXLIMITTEXT, 0, $7FFFFFF0);
  If ShowHint then SetModified(True);
   WordWrap:=true;
   WordWrap:=false;
   inserted := false;
end;

destructor TRichEditWB.Destroy;
begin
  FStream.Free;
  inherited Destroy;
end;

procedure TRichEditWB.DblClick;
begin
  inherited;
end;

procedure  TRichEditWB.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
end;

function TRichEditWB.GetModified: Boolean;
begin
  Result := FModified;
  if HandleAllocated then Result := SendMessage(Handle, EM_GETMODIFY, 0, 0) <> 0;
end;

function TRichEditWB.GetCanUndo: Boolean;
begin
  Result := False;
  if HandleAllocated then Result := SendMessage(Handle, EM_CANUNDO, 0, 0) <> 0;
end;

procedure TRichEditWB.SelectFont;
var
fd : TFontDialog;
begin
   fd := TFontDialog.Create(Self);
  try
   fd.Font.Assign(SelAttributes);

if Fd.Execute then
   Font.Assign(fd.Font);
   SetFocus;
  finally
  fd.Free;
   end;
end;

procedure TRichEditWB.SetFontBold;
begin
  with SelAttributes do
    if fsBold in Style then
      Style := Style - [fsBold]
    else
      Style := Style + [fsBold];
end;

procedure TRichEditWB.SetFontUnderLine;
begin
  with SelAttributes do
    if fsUnderLine in Style then
      Style := Style - [fsUnderLine]
    else
      Style := Style + [fsUnderLine];
end;

procedure TRichEditWB.SetFontItalic;
begin
  with SelAttributes do
    if fsItalic in Style then
      Style := Style - [fsItalic]
    else
      Style := Style + [fsItalic];
end;

procedure TRichEditWB.SetFontSize;
begin
  SelAttributes.Size := SelAttributes.Size + 2;
end;

procedure TRichEditWB.SetFontColor;
var
  CD : TColorDialog;
begin
      CD := TColorDialog.Create(Self);
   try
      CD.Color := clBlack;
   if CD.Execute then
      SelAttributes.Color := CD.Color;
   finally
   CD.Free;
   end;
end;

procedure TRichEditWB.SetColor;
var
  CD : TColorDialog;
begin
      CD := TColorDialog.Create(Self);
    try
      CD.Color := clWhite;
   if CD.Execute then
      Color := CD.Color;
   finally
   CD.Free;
   end;
end;

procedure TRichEditWB.SetSelectedBgColor;
var
  Format: CHARFORMAT2;
  CD : TColorDialog;
begin
  CD := TColorDialog.Create(Self);
  try
  CD.Color := clYellow;
   if CD.Execute then
  FillChar(Format, SizeOf(Format), 0);
  with Format do
  begin
    cbSize      := SizeOf(Format);
    dwMask      := CFM_BACKCOLOR;
    crBackColor := CD.Color;
    Perform(EM_SETCHARFORMAT, SCF_SELECTION, Longint(@Format));
  end;
  finally
  CD.Free;
  end;
end;

procedure TRichEditWB.CheckCapslock;
begin
  if Odd (GetKeyState (VK_CAPITAL)) then
     CapsLockKey := 'Caps Lock: On'
  else
     CapsLockKey := 'Caps Lock: Off';
end;

procedure TRichEditWB.CheckInsertKey;
begin
  if Odd (GetKeyState (VK_INSERT)) then
     InsertKey := 'Insert: On'
  else
     InsertKey := 'Insert: Off';
end;

procedure TRichEditWB.CheckNumLock;
begin
  if Odd (GetKeyState (VK_NUMLOCK)) then
     NumLockKey := 'NumLock: On'
  else
     NumLockKey := 'NumLock: Off';
end;

procedure  TRichEditWB.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
{var
   CurPos: TPoint;
   Popup : TPopupMenu;  }
begin
   UpdateInfo;
   LineIndex := Perform(EM_LINEFROMCHAR, SelStart,0);
  {if not Assigned(PopupMenu) then
    begin
     if button = mbRight then
      begin
      Popup := TPopupMenu.Create(self);
      PopupMenu := Popup;
       with popup do
       begin
           Items.Clear;
           CleanupInstance;
           GetCursorPos(CurPos);
           Popup(CurPos.x, CurPos.y);
         with Items do
         begin
           Add(NewItem('Undo',0, False, True, UndoLast, 0, 'MenuItem0'));
           Add(NewLine);
           Add(NewItem('Cut', 0, False, True, CutSel, 2, 'MenuItem2'));
           Add(NewItem('Copy', 0, False, True, CopySel, 3, 'MenuItem3'));
           Add(NewItem('Paste', 0, False, True, PasteSel, 4, 'MenuItem4'));
           Add(NewItem('Select All', 0, False, True, SelAll, 5, 'MenuItem5'));
           Add(NewLine);
           Add(NewItem('Clear', 0, False, True, ClearAll, 6, 'MenuItem6'));
           Add(NewItem('Clear Selection', 0, False, True, ClearSel, 7, 'MenuItem7'));
           Add(NewLine);
           Add(NewItem('Find', 0, False, True, FindDialog, 8, 'MenuItem8'));
           Add(NewLine); 
           if fXMLHighlight then
           Add(NewItem('HighLight XML', 0, False, True, DoXMLrc, 9, 'MenuItem9'));
           if fHTMLHighlight then
           Add(NewItem('HighLight HTML', 0, False, True, DoHTMLrc, 10, 'MenuItem10'));
           Add(NewLine);
           Add(NewItem('Print', 0, False, True, Prnt, 12, 'MenuItem12'));
           Add(NewItem('Print Selected Text', 0, False, True, PrintSel, 13, 'MenuItem13'));
         end;
       end;
       PostMessage(Handle, WM_NULL, 0, 0);
     end;
   end;  }
  inherited ;
end;

procedure TRichEditWB.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    inherited;
end;

procedure TRichEditWB.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
   UpdateInfo;
   LineIndex       := Perform(EM_LINEFROMCHAR, SelStart,0) ;
end;

procedure TRichEditWB.KeyPress(var Key: Char);
const
  KEY_CTRL_A = 01;
  KEY_CTRL_B = 02;
  KEY_CTRL_F = 06;
  KEY_CTRL_I = 9;
  KEY_CTRL_P = 16;
  KEY_CTRL_S = 19;
  KEY_CTRL_U = 21;
begin
 if (Ord(Key) = KEY_CTRL_B) or (Ord(Key) = KEY_CTRL_I) or(Ord(Key) = KEY_CTRL_S)
 or (Ord(Key) = KEY_CTRL_U) then
 begin
  with SelAttributes do
    case Ord(Key) of
      KEY_CTRL_B:
        begin
          Key := #0;
          if fsBold in Style then
            Style := Style - [fsBold]
          else
            Style := Style + [fsBold];
        end;
      KEY_CTRL_I:
        begin
          Key := #0;
          if fsItalic in Style then
            Style := Style - [fsItalic]
          else
            Style := Style + [fsItalic];
        end;
      KEY_CTRL_S:
        begin
          Key := #0;
          if fsStrikeout in Style then
            Style := Style - [fsStrikeout]
          else
            Style := Style + [fsStrikeout];
        end;
      KEY_CTRL_U:
        begin
          Key := #0;
          if fsUnderline in Style then
            Style := Style - [fsUnderline]
          else
            Style := Style + [fsUnderline];
        end;
    end;
   end;
if (Ord(Key) = KEY_CTRL_A)  then
   begin
     SelectAll;
   end
else if (Ord(Key) = KEY_CTRL_F)  then
   begin
    Find;
   end
else if (Ord(Key) = KEY_CTRL_P)  then
   begin
    PrintAll;
   end;
end;

function TRichEditWB.SelectLine(Index: Integer): boolean;
var
  StartPos, endPos: integer;
begin
  result := false;
  if Index < 0 then Exit;
  StartPos :=  Perform(EM_LINEINDEX, Index, 0);
  if StartPos <> -1 then
    begin
      endPos := SendMessage(Handle, EM_LINEINDEX, Index + 1, 0);
      if endPos = -1 then
        endPos := StartPos + Perform(EM_LINELENGTH, StartPos, 0);
      Perform(EM_SETSEL, StartPos, endPos);
      result := true;
    end;
end;

function TRichEditWB.GetSelectedText(var SelectedText: string):boolean;
begin
     SelectedText := SelText;
  if SelectedText <>'' then
     result := true
  else
  begin
    MessageDlg('Please select text before using this feature.', mtError,[mbOK], 0);
    result := false;
  end;
end;

procedure TRichEditWB.MailSelected;
var
   em_body, em_mail, em_subject : String;
begin
   if GetSelectedText(em_body)then
  begin
    em_subject := 'Check it out please.';
    em_mail := 'mailto:?subject=' +
    em_subject + '&body=' + em_body ;
    ShellExecute(Handle,'open',  PChar(em_mail), nil, nil, SW_SHOWNORMAL);
  end;
end;

procedure TRichEditWB.MailContext;
var
   em_body, em_mail, em_subject : String;
begin
   em_body := Lines.GetText;
   if em_body <> '' then
    begin
      em_subject := 'Check it out please.';
      em_mail := 'mailto:?subject=' +
      em_subject + '&body=' + em_body ;
      ShellExecute(Handle,'open',  PChar(em_mail), nil, nil, SW_SHOWNORMAL);
    end
   else
  MessageDlg('Please enter text before using this feature.', mtError,[mbOK], 0);
end;

function TRichEditWB.GetLineCount: Integer;
begin
  GetLineCount := lines.Count;
end;

function TRichEditWB.AddDateAndTime: integer;
var
  lt : TSYSTEMTIME;
  st : TSYSTEMTIME;
begin
     GetLocalTime(lt);
     GetSystemTime(st);
     Lines.Add('Date: '+ IntToStr(lt.wMonth) + '/'   + IntToStr(lt.wDay) + '/' +
               IntToStr(lt.wYear) + '     On: ' + IntToStr(lt.wHour) +  ':' +
               IntToStr(lt.wMinute) +  ':' + IntToStr(lt.wSecond));
     Result := Lines.Count;
end;

procedure TRichEditWB.AlignText(alignment: TAlignment);
begin
  Paragraph.Alignment := alignment;
end;

function TRichEditWB.ChangeToANSIChangeCase(const S: string): string;
var
  i: integer;
  Up: ANSIChar;
begin
  Result := S;
  for i := 1 to Length(Result) do
  begin
    Up := ANSIUpperCase(Result[i])[1];
    if Result[i] = Up then Result[i] := ANSILowerCase(Result[i])[1]
    else Result[i] := Up;
  end;
end;



function TRichEditWB.AddFormatedText(const txt: string; Bold, Italic, Strikeout,
                     Underline : boolean; txtColor : TColor ): integer;
begin
   with SelAttributes do
   begin
      if Bold then
             Style := Style + [fsBold]
       else  Style := Style - [fsBold];
      if Italic then
            Style := Style + [fsItalic]
       else Style := Style - [fsItalic];
      If Strikeout then
            Style := Style + [fsStrikeout]
       else Style := Style - [fsStrikeout];
      If Underline then
            Style := Style + [fsUnderline]
       else Style := Style - [fsUnderline];
   Color := txtColor;
  end;
  SelText:=(txt);
  Result := Lines.Count;
end;

function TRichEditWB.RemoveTextFormats: integer;
begin
   Font.Size := 8;
   with SelAttributes do
   begin
    Style := Style - [fsBold];
    Style := Style - [fsItalic];
    Style := Style - [fsStrikeout];
    Style := Style - [fsUnderline];
    Color := clBlack;
  end;
  Result := Lines.Count;
end;

function TRichEditWB.AddEmptyLine: integer;
begin
 Lines.Add('');
 Result := Lines.Count;
end;

procedure TRichEditWB.SetLineSpacing(lineSpacing: Byte);
var
  pf2: ParaFormat2;
begin
  FillChar(pf2, SizeOf(pf2), 0);
  pf2.cbSize    := SizeOf(PARAFORMAT2);
  pf2.dwMask    := PFM_LINESPACING;
  pf2.bLineSpacingRule := lineSpacing;
  SendMessage(Handle, EM_SETPARAFORMAT, 0, Longint(@pf2));
end;

procedure TRichEditWB.SetToMoreThen64KB;
begin
  SendMessage(Handle, EM_EXLIMITTEXT, 0, $7FFFFFF0);
end;

procedure TRichEditWB.PrintSelectedText;
var
  printarea            : TRect;
  richedit_outputarea  : TRect;
  printresX, printresY : Integer;
  fmtRange             : TFormatRange;
  nextChar            : Integer;
  S: string;
begin
  Printer.beginDoc;
  try
    with Printer.Canvas do
    begin
      printresX := GetDeviceCaps(Handle, LOGPIXELSX);
      printresY := GetDeviceCaps(Handle, LOGPIXELSY);
      printarea := Rect(printresX, printresY * 3 div 2,  Printer.PageWidth -
                   printresX, Printer.PageHeight - printresY * 3 div 2 );
     richedit_outputarea := Rect(printarea.Left * 1440 div printresX,
        printarea.Top * 1440 div printresY, printarea.Right * 1440 div printresX,
        printarea.Bottom * 1440 div printresY);
     fmtRange.hDC       := Handle;
     fmtRange.hdcTarget := Handle;
     fmtRange.rc        := richedit_outputarea;
     fmtRange.rcPage    := Rect(0, 0, Printer.PageWidth * 1440 div printresX,
        Printer.PageHeight * 1440 div printresY);
     fmtRange.chrg.cpMin := selstart;
     fmtRange.chrg.cpMax := selStart + sellength - 1;
     S := SelText;
      while (fmtRange.chrg.cpMax > 0) and
        (S[fmtRange.chrg.cpMax] <= ' ') do Dec(fmtRange.chrg.cpMax);
      repeat
        nextChar := Perform(EM_FORMATRANGE, 1, Longint(@fmtRange));
        if nextchar < fmtRange.chrg.cpMax then
        begin
          printer.newPage;
          fmtRange.chrg.cpMin := nextChar;
        end;
      until nextchar >= fmtRange.chrg.cpMax;
            Perform(EM_FORMATRANGE, 0, 0);
    end;
  finally
    Printer.endDoc;
  end;
end;

function TRichEditWB.SearchForTextAndSelect(SearchText: string): string;
var
  StartPos, Position, endpos: Integer;
begin
  StartPos := 0;
  endpos   := Length(Text);
  Lines.beginUpdate;
    while FindText(SearchText, StartPos, endpos, [stMatchCase])<>-1 do
    begin
      endpos    := Length(Text) - startpos;
      Position  := FindText(SearchText, StartPos, endpos, [stMatchCase]);
      Inc(StartPos, Length(SearchText));
      SetFocus;
      SelStart  := Position;
      SelLength := Length(SearchText);
      result    := SelText;
    end;
    Lines.endUpdate;
end;

procedure TRichEditWB.FindDialogFind(Sender : TObject);
var
  S        : string;
  startpos : integer;
begin
 SelStart := 0;
  with TFindDialog(Sender) do
  begin
    if FSelPos = 0 then
       Options := Options - [frFindNext];
    if frfindNext in Options then
    begin
      StartPos := FSelPos + Length(Findtext);
      S        := Copy(Lines.Text, StartPos, MaxInt);
    end
    else
    begin
      S         := Lines.Text;
      StartPos  := 1;
    end;
    FSelPos     := Pos(FindText, S);
    if FSelPos > 0 then
    begin
      FSelPos   := FSelPos + StartPos - 1;
      SelStart  := FSelPos - 1;
      SelLength := Length(FindText);
      SetFocus;
    end
    else
    begin
      if frfindNext in Options then
      S := Concat('There are no further occurences of "', FindText, '".')
      else
      S := Concat('Could not find "', FindText, '".');
      MessageDlg(S, mtError, [mbOK], 0);
    end;
  end;
end;

procedure TRichEditWB.Find;
var
 f: TFindDialog;
begin
   if not inserted then
   begin
   FSelPos := 0;
  try
   f := TFindDialog.Create(Self);
   f.OnFind := FindDialogFind;
   F.Execute;
  finally
  end;
  end
  else
   MessageDlg('You can not use this feature after inserting files.', mtError, [mbOK], 0);
end;

procedure TRichEditWB.FindDialog(Sender : TObject);
var
 f: TFindDialog;
begin
  if not inserted then
   begin
   FSelPos := 0;
  try
   f := TFindDialog.Create(Self);
   f.OnFind := FindDialogFind;
   F.Execute;
  finally
  end;
    end
  else
   MessageDlg('You can not use this feature after inserting files.', mtError, [mbOK], 0);
end;

procedure TRichEditWB.ReplaceDialogReplace(Sender: TObject);
var
 SelPos, SPos, SLen, TextLength: Integer;
 SearchString  : string;
begin
 with TReplaceDialog(Sender) do
 begin
  TextLength   := Length(Lines.Text);
  SPos         := SelStart;
  SLen         := SelLength;
  SearchString := Copy(Lines.Text, SPos + SLen + 1, TextLength - SLen + 1);
  SelPos       := Pos(FindText, SearchString);
  if SelPos > 0 then begin
    SelStart   := (SelPos - 1) + (SPos + SLen);
    SelLength  := Length(FindText);
    SelText    := ReplaceText;
  end
  else MessageDlg('Could not find "' + FindText + '".', mtError, [mbOk], 0);
  end;
end;

procedure TRichEditWB.Replace;
var
 r: TReplaceDialog;
begin
  if not inserted then
   begin
   FSelPos := 0;
  try
   r := TReplaceDialog.Create(Self);
   r.OnReplace := ReplaceDialogReplace;
   r.Execute;
  finally
  end;
   end
  else
   MessageDlg('You can not use this feature after inserting files.', mtError, [mbOK], 0);
end;

procedure TRichEditWB.GoToPosition(LineNumber, CharNumber: Word);
begin
   SelStart := Perform(EM_LINEINDEX, LineNumber, 0) + CharNumber;
   SetFocus;
end;

procedure TRichEditWB.PrintSel(Sender: TObject);
var
  printarea            : TRect;
  richedit_outputarea  : TRect;
  printresX, printresY : Integer;
  fmtRange             : TFormatRange;
  nextChar             : Integer;
  S                    : string;
begin
  Printer.beginDoc;
  try
    with Printer.Canvas do
    begin
      printresX := GetDeviceCaps(Handle, LOGPIXELSX);
      printresY := GetDeviceCaps(Handle, LOGPIXELSY);
      printarea := Rect(printresX, printresY * 3 div 2,  Printer.PageWidth -
                   printresX, Printer.PageHeight - printresY * 3 div 2 );
     richedit_outputarea := Rect(printarea.Left * 1440 div printresX,
        printarea.Top * 1440 div printresY, printarea.Right * 1440 div printresX,
        printarea.Bottom * 1440 div printresY);
     fmtRange.hDC       := Handle;
     fmtRange.hdcTarget := Handle;
     fmtRange.rc        := richedit_outputarea;
     fmtRange.rcPage    := Rect(0, 0, Printer.PageWidth * 1440 div printresX,
        Printer.PageHeight * 1440 div printresY);
     fmtRange.chrg.cpMin := selstart;
     fmtRange.chrg.cpMax := selStart + sellength - 1;
     S := SelText;
      while (fmtRange.chrg.cpMax > 0) and
        (S[fmtRange.chrg.cpMax] <= ' ') do Dec(fmtRange.chrg.cpMax);
      repeat
        nextChar := Perform(EM_FORMATRANGE, 1, Longint(@fmtRange));
        if nextchar < fmtRange.chrg.cpMax then
        begin
          printer.newPage;
          fmtRange.chrg.cpMin := nextChar;
        end;
      until nextchar >= fmtRange.chrg.cpMax;
            Perform(EM_FORMATRANGE, 0, 0);
    end;
  finally
    Printer.endDoc;
  end;
end;

function TRichEditWB.SearchAndReplace(InSearch, InReplace: string): integer;
var
    X, Toend  : integer;
    oldCursor : TCursor;
begin
   oldCursor     :=  Forms.Screen.Cursor;
   Screen.Cursor := crHourglass;
begin
     X := 0;
     Toend := length(Text);
     X     := FindText(inSearch, X, Toend, []);
     while X <> -1 do
     begin
       SetFocus;
       SelStart  := X;
       SelLength := length(inSearch);
       SelText   := InReplace;
       X         := FindText(inSearch, X + length(InReplace), Toend, []);
     end;
   end;
   Screen.Cursor := oldCursor;
   Result := Lines.Count;
end;

procedure TRichEditWB.SetRTFText(RichText: string);
begin
  FStream.Clear;
  FStream.WriteBuffer(RichText[1], Length(RichText));
  FStream.Position := 0;
  Lines.LoadFromStream(FStream);
end;

function TRichEditWB.GetRTFText: string;
begin
  FStream.Clear;
  Lines.SaveToStream(FStream);
  Result := PChar(FStream.Memory);
end;

procedure TRichEditWB.PreviewInBrowser;
 var
   st: TStringList;
begin
  if Assigned (fEmbeddedWB) then
  begin
   while EmbeddedWB.ReadyState <> READYSTATE_COMPLETE do
         EmbeddedWB.Stop;
  try
    PlainText := False;
    st:= TStringList.Create;
    st.Clear;
    st.Add(Text);
    EmbeddedWB.LoadFromStrings(st);
   finally
   end;
 end
 else
   MessageDlg('You should Assign A web Browser before using this feature!', mtError, [MbOk], 0);
end;

function TRichEditWB.GetRTFTextToString: string;
var
  ss       : TStringStream;
  emptystr : string;
begin
  emptystr := '';
  ss       := TStringStream.Create(emptystr);
  try
    PlainText := False;
    Lines.SaveToStream(ss);
    Result    := ss.DataString;
  finally
    ss.Free
  end;
end;

procedure TRichEditWB.LoadStreamFromBrowser;
 var
  Stm: TMemoryStream;
begin
  if Assigned (fEmbeddedWB) then
  begin
   while EmbeddedWB.ReadyState <> READYSTATE_COMPLETE do
         Forms.Application.ProcessMessages;
   Stm := TMemoryStream.Create;
   PlainText := False;
   clear;
   try
     EmbeddedWB.SaveToStream(Stm);
     Stm.Position := 0;
     Lines.LoadFromStream(Stm);
     Stm.Position := 0;
     fFileName := EmbeddedWB.LocationName;
     UpdateInfo;
     ScrollToTop;
     SelStart := Perform(EM_LINEINDEX, 1, 1) ;
   finally
     Stm.Free;
   end;
  end
  else
     MessageDlg('You should Assign A web Browser before using this feature!', mtError, [MbOk], 0);
end;

procedure TRichEditWB.LoadHTMLFromBrowser;
begin
  if Assigned (fEmbeddedWB) then
   begin
    PlainText := False;
    clear;
 while EmbeddedWB.ReadyState <> READYSTATE_COMPLETE do
       Forms.Application.ProcessMessages;
    if Assigned(EmbeddedWB.document) then
       Lines.Add(EmbeddedWB.OleObject.Document.documentElement.innerHTML);
       fFileName := EmbeddedWB.LocationName;
       UpdateInfo;
       ScrollToTop;
       SelStart := Perform(EM_LINEINDEX, 1, 1) ;
   end
  else
     MessageDlg('You should Assign A web Browser before using this feature!', mtError, [MbOk], 0);
end;

procedure TRichEditWB.LoadTextFromBrowser;
begin
  if Assigned (fEmbeddedWB) then
   begin
   clear;
   PlainText := False;
 while EmbeddedWB.ReadyState <> READYSTATE_COMPLETE do
       Forms.Application.ProcessMessages;
    if Assigned(EmbeddedWB.document) then
       Lines.Add(EmbeddedWB.OleObject.Document.documentElement.innerText);
       fFileName := EmbeddedWB.LocationName;
       UpdateInfo;
       ScrollToTop;
       SelStart := Perform(EM_LINEINDEX, 1, 1) ;
   end
  else
     MessageDlg('You should Assign A web Browser before using this feature!', mtError, [MbOk], 0);
end;

procedure TRichEditWB.LoadStringsFromBrowser;
begin
  if Assigned (fEmbeddedWB) then
   begin
        clear;
       PlainText := False;
 while EmbeddedWB.ReadyState <> READYSTATE_COMPLETE do
       Forms.Application.ProcessMessages;
       EmbeddedWB.SaveToStrings(Lines);
       fFileName := EmbeddedWB.LocationName;
       UpdateInfo;
       ScrollToTop;
       SelStart := Perform(EM_LINEINDEX, 1, 1) ;
   end
  else
     MessageDlg('You should Assign A web Browser before using this feature!', mtError, [MbOk], 0);
end;

procedure TRichEditWB.LoadAsCopyFromBrowser;
begin
  if Assigned (fEmbeddedWB) then
   begin
   clear;
   PlainText := False;
 while EmbeddedWB.ReadyState <> READYSTATE_COMPLETE do
       Forms.Application.ProcessMessages;
       EmbeddedWB.SelectAll;
       EmbeddedWB.Copy;
       PasteFromClipboard;
       fFileName := EmbeddedWB.LocationName;
       UpdateInfo;
       ScrollToTop;
       SelStart := Perform(EM_LINEINDEX, 1, 1) ;
   end
  else
     MessageDlg('You should Assign A web Browser before using this feature!', mtError, [MbOk], 0);
end;

procedure TRichEditWB.ScrollToTop;
begin
    SendMessage(Handle,EM_LINESCROLL, 0, - Lines.Count);
    SetFocus;
end;

procedure TRichEditWB.ScrollToBottom;
begin
   SendMessage(Handle,EM_SCROLL,0, Lines.Count);
   SetFocus;
end;

procedure TRichEditWB.DoHTMLrc(Sender: TObject);
var
 ms : TMemoryStream;
begin
   HTMLSyn := THighlightHTML.Create;
   HTMLSyn.SetText(Text);
   ms := TMemoryStream.Create;
   HTMLSyn.ConvertToRTFStream(ms);
   PlainText := false;
   ms.Position := 0;
   Lines.LoadFromStream(ms);
   PlainText := true;
   ms.Free;
   HTMLSyn.Free;  
end;

procedure TRichEditWB.DoXMLrc(Sender: TObject);
var
 ms : TMemoryStream;
begin
   XMLSyn := THighlightXML.Create;
   XMLSyn.SetText(Text);
   ms    := TMemoryStream.Create;
   XMLSyn.ConvertToRTFStream(ms);
   PlainText := false;
   ms.Position := 0;
   Lines.LoadFromStream(ms);
   PlainText := true;
   ms.Free;
   XMLSyn.Free;  
end;

function TRichEditWB.AddLineNumbering: integer;
var
  fmt: TParaformat2;
begin
  FillChar(fmt, SizeOf(fmt), 0);
  fmt.cbSize := SizeOf(fmt);
  fmt.dwMask := PFM_NUMBERING or PFM_NUMBERINGSTART or PFM_NUMBERINGSTYLE or
                PFM_NUMBERINGTAB;
  fmt.wNumbering := 2;
  fmt.wNumberingStart := 1;
  fmt.wNumberingStyle := $200;
  fmt.wNumberingTab := 1440 div 4;
  Perform(EM_SETPARAFORMAT, 0, lParam(@fmt));
  Result := Lines.Count;
end;

function TRichEditWB.AddBullets: integer;
var
  fmt: TParaformat2;
begin
  SelectAll;
  FillChar(fmt, SizeOf(fmt), 0);
  with fmt do
    begin
       cbSize := SizeOf(fmt);
       dwMask := PFM_NUMBERING or PFM_NUMBERINGSTART or PFM_NUMBERINGSTYLE or
                PFM_NUMBERINGTAB;
       wNumbering := 1;
       wNumberingStart := 1;
       wNumberingStyle := $200;
       wNumberingTab := 1440 div 4;
     end;
  Perform(EM_SETPARAFORMAT, 0, lParam(@fmt));
  selStart :=0;
  Result := Lines.Count;
end;

function TRichEditWB.AddRomanNumbering: integer;
var
  fmt: TParaformat2;
begin
  SelectAll;
  FillChar(fmt, SizeOf(fmt), 0);
  with fmt do
    begin
       cbSize := SizeOf(fmt);
       dwMask := PFM_NUMBERING or PFM_NUMBERINGSTART or PFM_NUMBERINGSTYLE or
                PFM_NUMBERINGTAB;
       wNumbering := 6;
       wNumberingStart := 1;
       wNumberingStyle := $200;
       wNumberingTab := 1440 div 4;
     end;
  Perform(EM_SETPARAFORMAT, 0, lParam(@fmt));
  selStart :=0;
  Result := Lines.Count;
end;

function TRichEditWB.AddCheckBox(cbCaption, cbName: string; reLeft, cbLeft,
cbTop :Integer; Chk:Boolean): integer;
var
   cb: TCheckBox;
begin
  if AcceptDragComponnents then
  begin
   Self.Left := RELeft;
   cb := TCheckBox.Create(Self) ;
   with cb do
   begin
     Name    := cbName + IntToStr(CompCount);
     Caption := cbCaption;
     Left    := cbLeft;
     Top     := cbTop;
     Parent  := Self;
     Checked := Chk;
     inc(CompCount);
     Result := CompCount;
   end;
  end
  else
  Result := 0;
end;

function TRichEditWB.AddEditBox(eText, eName: string; reLeft, eLeft, eTop :Integer): integer;
var
   E: TEdit;
begin
  if AcceptDragComponnents then
  begin
   Self.Left := RELeft;
   E := TEdit.Create(Self) ;
   with E do
   begin
     Name    := eName + IntToStr(CompCount);
     Text    := eText;
     Left    := eLeft;
     Top     := eTop;
     Parent  := Self;
     inc(CompCount);
     Result := CompCount;
   end;
  end
  else
  Result := 0;
end;

function TRichEditWB.AddRadioButton(rbCaption, rbName: string; reLeft, rbLeft,
           rbTop: integer; Chk: boolean): integer;
var
   RB: TRadioButton;
begin
 if AcceptDragComponnents then
  begin
   Self.Left := reLeft;
   RB := TRadioButton.Create(Self) ;
   with RB do
   begin
     Name    := rbName + IntToStr(CompCount);
     Caption := rbCaption;
     Left    := rbLeft;
     Top     := rbTop;
     Parent  := Self;
     Checked := Chk;
     inc(CompCount);
     Result := CompCount;
   end;
  end
  else
  Result := 0;
end;

function TRichEditWB.AddButton(bCaption, bName: string; reLeft, bLeft, bTop:
integer): integer;
var
   B: TButton;
begin
  if AcceptDragComponnents then
  begin
   Self.Left := reLeft;
   B := TButton.Create(Self) ;
   with B do
   begin
     Name    := bName + IntToStr(CompCount);
     Caption := bCaption;
     Left    := bLeft;
     Top     := bTop;
     Parent  := Self;
     inc(CompCount);
     Result := CompCount;
   end;
  end
  else
  Result := 0;
end;

procedure TRichEditWB.SetModified(Value: Boolean);
begin
  inherited Modified;
  UpdateInfo;
  if Assigned(fStatusbar) then
  begin
     fStatusbar.Panels.Add;
     fStatusbar.Panels[0].Width := 2000;
     fStatusbar.Panels[0].Text  := Hint;
  end;
end;

procedure TRichEditWB.UpdateInfo;
var
  CharPos: TPoint;
  sMod : string;
begin
  CharPos.Y := SendMessage(Handle, EM_EXLINEFROMCHAR, 0,  SelStart);
  CharPos.X := (SelStart - SendMessage(Handle, EM_LINEINDEX, CharPos.Y, 0));
  Inc(CharPos.Y);
  Inc(CharPos.X);
  CarretPosition  := Format(sColRowInfo, [CharPos.Y, CharPos.X]);
  CheckCapslock;
  CheckInsertKey;
  CheckNumLock;
  if Modified then sMod := 'Modified' else  sMod := '';
  Hint := 'File Name: ' + fFileName + '. | ' +
  #10+#13+'Position: '  + Format(sColRowInfo, [CharPos.Y, CharPos.X])+'. | '+
  #10+#13+ sMod        + '. | ' +
  #10+#13+ CapsLockKey + '. | ' +
  #10+#13+ NumLockKey  + '. | ' +
  #10+#13+ InsertKey   + '. | ' +
  #10+#13+'Total Lines Count: ' + IntToStr(GetLineCount) + '. |';
  CursorPositionX := CharPos.X;
  CursorPositionY := CharPos.Y;
end;

procedure TRichEditWB.New;
begin
  CheckFileSave;
  SetFileName(sUntitled);
  Lines.Clear;
  inserted := false;
  Modified := False;
  SetModified(False);
end;

procedure TRichEditWB.PerformFileOpen(const AFileName: string);
var
 Ext : string;
begin
     inserted:= false;
     Ext := ExtractFileExt(AFileName);
  if Ext = '.txt' then PlainText := true
  else PlainText := false;
     Lines.LoadFromFile(AFileName);
     SetFileName(AFileName);
     SetFocus;
     Modified := False;
     SetModified(False);
end;

procedure TRichEditWB.Open;
var
  OD : TOpendialog;
begin
    CheckFileSave;
    OD := TOpendialog.Create(Self);
  try
    OD.Title := Forms.Application.Title + ' - ' + 'Open Dialog';
  if OD.Execute then
  begin
    ReadOnly := ofReadOnly in OD.Options;
    PerformFileOpen(OD.FileName);
    Setfilename(OD.FileName);
    UpdateInfo;
  end;
  finally
  OD.Free;
  end;
end;

procedure TRichEditWB.LoadFromFile(FileName: string);
begin
  Lines.LoadFromFile(FileName);
end;

procedure TRichEditWB.LoadFromStream(S: TStream);
begin
  Lines.LoadFromStream(S);
end;

procedure TRichEditWB.SaveToFile(FileName: string);
begin
  Lines.SaveToFile(FileName);
end;


procedure TRichEditWB.SaveToStream(S: TStream);
begin
  Lines.SaveToStream(S);
end;

procedure TRichEditWB.Save;
var
 i: integer;
begin
  if FFileName = sUntitled then
     begin
       SaveAs;
       Exit;
     end
  else
  begin
   if FileExists(Trim(fFileName+'.html')) then
   begin
    i:= MessageDlg(Format(sOverWrite, [Trim(FFileName+'.html')]), mtConfirmation,
    mbYesNoCancel, 0);
    if i = 2 then Exit;
    if i = 7 then SaveAs;
    if i = 6 then
     begin
        Lines.SaveToFile(Trim(FFileName+'.html'));
        Modified := False;
        SetModified(False);
     end;
   end
   else
   Lines.SaveToFile(Trim(FFileName+'.html'));
   Modified := False;
   SetModified(False);
 end;
end;

procedure TRichEditWB.SaveAs;
var
 sd : TSaveDialog;
begin
  sd := TSaveDialog.Create(Self);
  try
  SD.FileName :=(Trim(FFileName+'.html'));
  if SD.Execute then
  begin
    if FileExists(Trim(SD.FileName+'.html')) then
    if MessageDlg(Format(sOverWrite, [(Trim(SD.FileName+'.html'))]), mtConfirmation, mbYesNoCancel, 0)
       <> idYes then Exit;
    Lines.SaveToFile(SD.FileName+'.html');
    SetFileName(SD.FileName);
    Modified := False;
    SetModified(False);
  end;
  finally
  sd.Free;
  end;
end;

procedure TRichEditWB.SetFileName(const FileName: String);
begin
  fFileName := FileName;
end;

procedure TRichEditWB.CheckFileSave;
var
  SaveResp: Integer;
begin
  if not Modified then Exit;
  SaveResp := MessageDlg(Format(sSaveChanges, [FFileName]),
    mtConfirmation, mbYesNoCancel, 0);
  case SaveResp of
    idYes    : Save;
    idNo     : {Nothing};
    idCancel : Abort;
  end;
end;

procedure TRichEditWB.WMDropFiles(var Msg: TWMDropFiles);
var
  CFileName: array[0..MAX_PATH] of Char;
begin
  if AcceptDragFiles then
  begin
  try
    if DragQueryFile(Msg.Drop, 0, CFileName, MAX_PATH) > 0 then
    begin
      CheckFileSave;
      PerformFileOpen(CFileName);
      Msg.Result := 0;
    end;
  finally
    DragFinish(Msg.Drop);
  end;
  end;
end;

initialization

finalization
  if FRichEditModule <> 0 then
  FreeLibrary(FRichEditModule);
end.
