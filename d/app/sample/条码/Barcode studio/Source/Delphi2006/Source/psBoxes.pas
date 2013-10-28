unit psBoxes;

interface

uses Messages, Classes, Windows, SysUtils, StdCtrls, CheckLst, Graphics, Controls,
      Dialogs, TypInfo, Forms, Buttons, ExtCtrls,
      psTypes, psCodeSpecs, psCodeRes, psCodeFN, psCodeFNLite, psBarcode;

type
  TpsBoxOption = (bxOnlySupported);
  TpsBoxOptions = set of TpsBoxOption;
  TpsBarcodeListStyle  = (btSymbol, btText);


  TpsComboBox = class(TComboBox)
  private
    FOptions: TpsBoxOptions;
    procedure SetSelectedTypBarcode(const Value: TpsBarcodeSymbology);
    function  GetSelectedTypBarcode: TpsBarcodeSymbology;
    procedure SetOptions(const Value: TpsBoxOptions);
  public
    constructor Create(AOwner:TComponent); override;
    procedure   Loaded; override;
  published
    property  Items stored False;
    property  Text  stored False;
    property  Options:TpsBoxOptions read FOptions write SetOptions;
    property  SelectedSymbology:TpsBarcodeSymbology read GetSelectedTypBarcode
            write SetSelectedTypBarcode;
//    property  EnabledSymbologies:TpsSymbologies read GetEnabledSymbologies write SetEnabledSymbologies;
  end;

  TpsListBox = class(TListBox)
  private
    FOptions: TpsBoxOptions;
    procedure SetSelectedTypBarcode(const Value: TpsBarcodeSymbology);
    function  GetSelectedTypBarcode: TpsBarcodeSymbology;
    procedure SetOptions(const Value: TpsBoxOptions);
  public
    procedure Loaded; override;
  published
    property  Items stored False;
    property  Text  stored False;
    property  Options:TpsBoxOptions read FOptions write SetOptions;
    property  SelectedSymbology:TpsBarcodeSymbology read GetSelectedTypBarcode
            write SetSelectedTypBarcode;
  end;

  TpsCheckList=class(TCheckListBox)
  private
    FOptions: TpsBoxOptions;
    procedure SetOptions(const Value: TpsBoxOptions);
    function  GetCheckedSymbology(Symbology: TpsBarcodeSymbology): Boolean;
    procedure SetCheckedSymbology(Symbology: TpsBarcodeSymbology;
      const Value: Boolean);
  public
    constructor Create(AOwner:TComponent); override;
    procedure   Loaded; override;
    property    CheckedSymbology[Symbology:TpsBarcodeSymbology]:Boolean
        read GetCheckedSymbology write SetCheckedSymbology;
  published
    property  Items stored False;
    property  Options:TpsBoxOptions read FOptions write SetOptions;
  end;


  TpsWebType=(wtNone,wtHttp, wtFTP, wtEmail, wtNews, wtGopher,
    wtFile, wtHttps, wtTelnet,wtWais,
    wtGoogleSearch, wtAltavistaSearch, wtYahooSearch, wtMSNSearch,
    wtAnswers, wtAmazon,

    wtWikipedia, wtWiktionary, wtWikiNews, wtWikiBooks, wtWikiVersity,
    wtWikiSource, wtMetaWiki
    );

  TpsWebLanguage=(TpsEnglish, tpsDeutsch, TpsEspanol, TpsFrancais, TpsItaliano,
    TpsNederlands, TpsNorsk, TpsPolski, TpsPortugues, TpsRusski, TpsSuomi,
    TpsSvenska);

  TpsPSOFTLink=(
      plNone, plHomepage, plEmail, plEmailSupport,
      plDownloadAll, plDownloadBarcodeStudio,
      plRegisterAll, plRegisterBarcodeStudio,
      plProductsAll, plProductsBarcodeStudio,
      plBarcodeEncyclopedia,
      plBarcodeConsole, plBarcodeActiveX,
      plNews, plForums
    );

    { TODO : Toto podorabat, tu by sa dalo pekne vymyslat }
  TpsSearchEngine = record
    Webtype   : TpsWebType;
    Name      : String[20];
    Link      : String;
  end;

{const
  psEngines : array[TpsWebType] of TpsSearchEngine =
    ();
}

  TpsBarcodeWebLabel=class(TLabel)
  private
    FURL         : String;
    FFontHover   : TFont;
    FEmailSubject: String;

    FWebType    : TpsWebType;
    FLanguage   : String;
    FDomain     : String;
    FFontTmp    : TFont;
    FEmailCC    : String;
    FEMailBody  : String;
    FEmailBCC   : String;
    FSearchText : String;
    FPsoftLink  : TpsPSOFTLink;

    procedure   SetFontHover(const Value: TFont);
    procedure   SetEmailSubject(const Value: String);
    function    GetFinished: Boolean;
    function    GetVersion: String;
    procedure   SetEMailBody(const Value: String);
    procedure   SetEmailCC(const Value: String);
    procedure   SetEmailBCC(const Value: String);
    procedure   SetPsoftLink(const Value: TpsPSOFTLink);
  protected
    procedure   psMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure   psMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  public
    constructor Create(AOwner:TComponent); override;
    destructor  Destroy; override;
    procedure   Click; override;
    function    FinalLink:String;
  published
    property    URL:String read FURL write FURL;
    property    FontHover:TFont read FFontHover write SetFontHover;
    property    EmailSubject:String read FEmailSubject write SetEmailSubject;
    property    EmailCC:String read FEmailCC write SetEmailCC;
    property    EmailBCC:String read FEmailBCC write SetEmailBCC;
    property    EMailBody:String read FEMailBody write SetEMailBody;
    property    WebType:TpsWebType read FWebType write FWebType;
    property    WebLink:String read FURL write FURL;
    property    Language:String read FLanguage write FLanguage;
    property    SearchText:String read FSearchText write FSearchText;
    property    Domain:String read FDomain write FDomain;

    property    Version:String read GetVersion;
    property    Finished:Boolean read GetFinished;
    property    PSoftLink:TpsPSOFTLink read FPsoftLink write SetPsoftLink;
   end;

  TpsBarcodeLabel=class(TLabel)
  private
    FTypBarcode : TpsBarcodeSymbology;
    FTypInfoItem: TpsBarcodeInfoItemType;
    procedure SetBarcodeSymbology(const Value: TpsBarcodeSymbology);
    procedure SetTypInfoItem(const Value: TpsBarcodeInfoItemType);
  protected
    procedure UpdateCaption;
  public
  published
    property BarcodeSymbology:TpsBarcodeSymbology read FTypBarcode write SetBarcodeSymbology;
    property BarcodeInfoType:TpsBarcodeInfoItemType read FTypInfoItem write SetTypInfoItem;
  end;


  TpsBarcodeAbout=class(TComponent)
  private
    procedure SetEdition(const Value: String);
    procedure SetProductName(const Value: String);
    procedure SetVersion(const Value: String);
    function  GetEdition: String;
    function  GetProductName: String;
    function  GetVersion: String;
    function GetCountLinear: Integer;
    function GetCountMatrix: Integer;
    function GetCountPostal: Integer;
    function GetCountStacked: Integer;
    function GetCountSupported: Integer;
  protected
  public
    procedure Execute; virtual;
  published
    property  Edition:String read GetEdition write SetEdition;
    property  Version:String read GetVersion write SetVersion;
    property  ProductName:String read GetProductName write SetProductName;
    property  CountSupported:Integer read GetCountSupported stored False;
    property  CountLinear:Integer read GetCountLinear stored False;
    property  CountPostal:Integer read GetCountPostal stored False;
    property  CountStacked:Integer read GetCountStacked stored False;
    property  CountMatrix:Integer read GetCountMatrix stored False;
  end;

  // ***********************************************************************
  // **** Functions for info about symbologies
  // ***********************************************************************

  procedure AddTypesToList(L:TStrings; S:TpsBarcodeListStyle);
  function  addLabelWeb(F:TWinControl; X,Y:Integer; text:string; url:string):TpsBarcodeWebLabel;

  function  psDialogWithURL(msg:string; dlgfType:TMsgDlgType;
    Buttons: TMsgDlgButtons):Integer;

//-------------------------------------------------------------------------
//  PROCEDURES AND FUNCTIONS FOR RUNTIME FORM CREATION
//-------------------------------------------------------------------------

function  addLabel(F:TWinControl; X,Y:Integer;  text:string;fs:TFontStyles=[]):TLabel;
function  addEdit(F:TWinControl; X,Y,W:Integer;  edText:string):TEdit;
function  addBtn(F:TWinControl; X,Y,W:Integer;  btnText:string; prc:TNotifyEvent):TBitBtn;
function  addComboType(F:TWinControl; X,Y,W:Integer;
    ti:pointer=nil; value:integer=0):TComboBox;
function  addLine(F:TWinControl; X,Y,W:Integer; C:TColor):TShape;

function psShowAboutDlg(Demo:Boolean):Integer;

function psGetPrintRectangle(var R:TpsRect; position : TPosition=poScreenCenter):boolean;

// ---------------------------------------------------------------------------
// Barcode reader on serial port
// ---------------------------------------------------------------------------
type

  TpsBarcodeReader  = class;
  TpsComPort        = (psCom1, psCom2, psCom3, psCom4, psCom5, psCom6, psCom7, psCom8);
  TpsComBitRate     = (br300, br600, br1200, br2400, br4800, br9600, br14400, br19200, br38400, br57600, br115200 );
  TpsComParity      = (parityNone, parityOdd, paritySpace, parityEven, parityMark);
  TpsComDataBits    = (db7Bits, db8Bits);
  TpsComStopBits    = (sbStop1, sbStop15, sbStop2);

  TpsOnBarcodeReady = procedure (Sender:TObject; Barcode:String) of Object;
  TpsOnAfterSend    = procedure (Sender:TObject; SendString:String) of Object;

  TpsBarcodeReaderOption = (boRemoveCR, boRemoveLF, boEnabledSend);
  TpsBarcodeReaderOptions = set of TpsBarcodeReaderOption;

  TEanReadThread = class(TThread)
  private
        FReader     : TpsBarcodeReader;
        FBarcode    : String;
        FEventMask  : DWORD;
        FComHandle  : THandle;
        FTimeOut    : Integer;
        procedure HandleComPortEvent;
  public
        CloseEvent  : THandle;
        procedure   Execute; override;
        constructor CreateEan(Reader:TpsBarcodeReader);
        procedure   DataReceived;
        procedure   DataSent;
        procedure   Send(s:String);
        function    ComPortHandle:THandle;
  end;

  // basic com port component
  TpsBarcodeReader = class(TComponent)
  private
    FActive      : Boolean;
    FComPort     : TpsComPort;
    FComParity   : TpsComParity;
    FComBitRate  : TpsComBitRate;
    FComdataBits : TpsComDataBits;
    FComStopBits : TpsComStopBits;

    FReadThread  : TEanReadThread;
    FOnBarcodeReady: TpsOnBarcodeReady;
    FOnAfterSend   : TpsOnAfterSend;
    FTimeOut: Integer;
    FLastBarcode: String;
    FOptions: TpsBarcodeReaderOptions;
    FScaleString : String;

    procedure SetActive(const Value: Boolean);
    procedure InternalClose;
    procedure InternalOpen;

    procedure SetOptions(Value:TpsBarcodeReaderOptions);
    function GetHandle: THandle;
    procedure SetHandle(const Value: THandle);
  protected
  public
     LastSendString : String;
     LastSendCount  : DWORD;

     constructor Create(AOwner:TComponent); override;
     destructor  Destroy; override;
     procedure   Loaded; override;
     procedure   ReConnect;
     procedure   ActivateScale;
     procedure   SendToPort(s:String);

  published
     property Active    :Boolean        Read FActive       Write SetActive;
     property Port      :TpsComPort     Read FComPort      Write FComPort;
     property BitRate   :TpsComBitRate  Read FComBitrate   Write FComBitRate;
     property Parity    :TpsComParity   Read FComParity    Write FComParity;
     property DataBits  :TpsComDataBits Read FComDataBits  Write FComDataBits;
     property StopBits  :TpsComStopBits Read FComStopBits  Write FComStopBits;
     property TimeOut   :Integer        Read FTimeOut      Write FTimeOut Default 100;
     property LastBarcode:String        Read FLastBarcode  Write FLastBarcode;
     property OnBarcodeReady:TpsOnBarcodeReady Read FOnBarcodeReady Write FOnBarcodeReady;
     property OnAfterSend: TpsOnAfterSend read FOnAfterSend write FOnAfterSend;
     property Options:TpsBarcodeReaderOptions  Read FOptions Write SetOptions;
     property ScaleString:String read FScaleString write FScaleString;
     property Handle:THandle Read GetHandle Write SetHandle;
  end;


implementation

{ TEanComboBox }

procedure FillItems(Items:TStrings; Options:TpsBoxOptions; EnabledSymbologies:TpsSymbologies);
var i    : TpsBarcodeSymbology;
    info : TpsBarCodeInfo;
    s    : String;
begin
  Items.Clear;

  for i:=Low(TpsBarcodeSymbology) to High(TpsBarcodeSymbology) do begin
      info := BarcodeInfo(i,'');
      if (bxOnlySupported in Options) and not info.Supported then Continue;
      s    := info.Name;
      if not info.Supported then s:= s+' (not supported)';
      Items.AddObject(s, TObject(i));
  end;
end;

function FindSymbology(Items:TStrings; const Value: TpsBarcodeSymbology):Integer;
begin
  Result := Items.IndexOfObject(TObject(Value));
end;


procedure TpsComboBox.Loaded;
begin
  inherited;
  Style := csDropDownList;
  FillItems(Items,FOptions,[]);
  ItemIndex:=0;
end;

function TpsComboBox.GetSelectedTypBarcode: TpsBarcodeSymbology;
begin
  if ItemIndex>=0 then Result:=TpsBarcodeSymbology(Items.Objects[ItemIndex])
  else Result := bcNone;
end;

procedure TpsComboBox.SetOptions(const Value: TpsBoxOptions);
begin
  FOptions := Value;
  FillItems(Items,FOptions,[]);
end;

procedure TpsComboBox.SetSelectedTypBarcode(const Value: TpsBarcodeSymbology);
begin
  ItemIndex := Items.IndexOfObject(TObject(Value));
end;

constructor TpsComboBox.Create(AOwner: TComponent);
begin
  inherited;
  Style := csDropDownList;
end;


{ TEanListBox }

procedure TpsListBox.Loaded;
begin
  inherited;
  FillItems(Items, Options, []);
  ItemIndex:=0;
end;

function TpsListBox.GetSelectedTypBarcode: TpsBarcodeSymbology;
begin
  if ItemIndex>=0 then Result:=TpsBarcodeSymbology(Items.Objects[ItemIndex])
  else Result := bcNone;
end;

procedure TpsListBox.SetOptions(const Value: TpsBoxOptions);
begin
  FOptions := Value;
  FillItems(Items, FOptions, []);
end;

procedure TpsListBox.SetSelectedTypBarcode(const Value: TpsBarcodeSymbology);
begin
  ItemIndex := Items.IndexOfObject(TObject(Value));
end;


{ TEanCheckList }

constructor TpsCheckList.Create(AOwner: TComponent);
begin
  inherited;

end;

function TpsCheckList.GetCheckedSymbology(Symbology: TpsBarcodeSymbology): Boolean;
var i:Integer;
begin
  i:=FindSymbology(Items, Symbology);
  Result := False;
  if i>=0 then Result := Checked[i];
end;

procedure TpsCheckList.Loaded;
begin
  inherited;
  FillItems(Items, Options, []);
end;

procedure TpsCheckList.SetCheckedSymbology(Symbology: TpsBarcodeSymbology;
  const Value: Boolean);
var i:Integer;
begin
  i:=FindSymbology(Items, Symbology);
  if i>=0 then Checked[i] := Value;
end;

procedure TpsCheckList.SetOptions(const Value: TpsBoxOptions);
begin
  FOptions := Value;
  FillItems(Items, FOptions, []);
end;


type TPsoftLinkItem=record
        co:TpsPSOFTLink;
        Name:String;
        Link:^String;
        Hint:String;
     end;

const tblPsoftLinks:array[1..12] of TPsoftLinkItem=(
    (co:plHomepage; name:'PSOFT homepage';
          Link:@constPSOFTHomePage),
    (co:plEmail   ; name:'Email to PSOFT';
          Link:@constPSOFTEmail),
    (co:plEmailSupport; name:'Email support';
          Link:@constPSOFTContact),
    (co:plDownloadAll; name:'Download area';
          Link:@constPSOFTDownload),
    (co:plDownloadBarcodeStudio; name:'Download Barcode studio';
          Link:@constPSOFTDownloadBarcodeStudio),
    (co:plRegisterAll; name:'Order page';
          Link:@constRegisterBuy),
    (co:plRegisterBarcodeStudio; name:'Order Barcode studio';
          Link:@constBarcodeRegisterLink),
    (co:plProductsAll; name:'All products';
          Link:@constPSOFTProducts),
    (co:plProductsBarcodeStudio; name:'Barcode studio home';
          Link:@constPSOFTHomePage),
    (co:plBarcodeEncyclopedia; name:'Barcode encyclopedia';
          Link:@constBarcodeEncyclopedia),
    (co:plNews;   name:'News page';
          Link:@constPSOFTNews),
    (co:plForums; name:'Forums page';
          Link:@constPSOFTForums)
  );


{ TpsBarcodeWebLabel }

procedure TpsBarcodeWebLabel.Click;
begin
  inherited;

  { TODO : Dorobit tu hladanie cez language a domain }

  ConnectWebLink(FinalLink);
end;

constructor TpsBarcodeWebLabel.Create(AOwner: TComponent);
begin
  inherited;

  FFontTmp:=TFont.Create;
  Cursor := crHandPoint;

  Font.Color := clBlue;
  Font.Style := Font.Style;

  FFontHover:=TFont.Create;
  FFontHover.Assign(Font);
  FFontHover.Style := FFontHover.Style + [fsUnderLine];
end;

destructor TpsBarcodeWebLabel.Destroy;
begin
  FFontTmp.Free;
  FFontHover.Free;
  inherited;
end;

function TpsBarcodeWebLabel.FinalLink: String;
var s:string;
  function AddWebPrefix(Prefix:String; Address:String):String;
  begin
    if Pos(UpperCase(Prefix),UpperCase(Address))<=0 then Result:=Prefix+Address
    else                          Result:=Address;
  end;
begin
  case WebType of
    wtNone            : s:=WebLink;
    wtHttp            : s:=AddWebPrefix('http://',WebLink);
    wtFTP             : s:=AddWebPrefix('ftp://',WebLink);
    wtEmail           : s:=AddWebPrefix('mailto:',WebLink)
      +'?Subject='+EMailSubject+'&CC='+EMailCC+'&bcc='+EMailBCC
      +'&Body='+EMailBody;
    wtNews            : s:=AddWebPrefix('news:',WebLink);
    wtGopher          : s:=AddWebPrefix('gopher://',WebLink);
    wtGoogleSearch    : s:='http://www.google.com?'+FSearchText;
    wtAltavistaSearch : s:='http://www.altavista.com?'+FSearchText;
    wtYahooSearch     : s:='http://www.yahoo.com?'+FSearchText;
    wtMSNSearch       : s:='http://www.msn.com?'+FSearchText;
    wtFile            : s:='file://'+WebLink;
    wtHttps           : s:=AddWebPrefix('https://',WebLink);
    wtTelnet          : s:=AddWebPrefix('telnet:',WebLink);
    wtWais            : s:=AddWebPrefix('wais:',WebLink);
    wtAnswers         : s:='http://www.answers.com/'+FSearchText+'?nafid=3';
    wtAmazon          : s:='http://www.amazon.com/exec/obidos/external-search?keyword='+FSearchText;
    wtWikipedia       : s:='http://en.wikipedia.org/wiki/Special:Search?search='
        +FSearchText+'+code&go=Go';
  end;
  Result:=s;
end;

function TpsBarcodeWebLabel.GetFinished: Boolean;
begin
  Result := True;
end;

function TpsBarcodeWebLabel.GetVersion: String;
begin
  Result:= constProductVersion;
end;

procedure TpsBarcodeWebLabel.psMouseEnter(var Message: TMessage);
begin
  inherited;
  if not(csDesigning in ComponentState) then begin
    FFontTmp.Assign(Font);
    Font.Assign(FontHover);
  end;
  Hint := FinalLink;
end;

procedure TpsBarcodeWebLabel.psMouseLeave(var Message: TMessage);
begin
  inherited;
  if not(csDesigning in ComponentState) then
    Font.Assign(FFontTmp);
  Hint := '';  
end;

procedure TpsBarcodeWebLabel.SetEmailBCC(const Value: String);
begin
  FEmailBCC := Value;
end;

procedure TpsBarcodeWebLabel.SetEMailBody(const Value: String);
begin
  FEMailBody := Value;
end;

procedure TpsBarcodeWebLabel.SetEmailCC(const Value: String);
begin
  FEmailCC := Value;
end;

procedure TpsBarcodeWebLabel.SetEmailSubject(const Value: String);
begin
  FEmailSubject := Value;
end;

procedure TpsBarcodeWebLabel.SetFontHover(const Value: TFont);
begin
  FFontHover := Value;
end;

procedure TpsBarcodeWebLabel.SetPsoftLink(const Value: TpsPSOFTLink);
var i:Integer;
begin
  if FPSoftLink<>Value then begin
    FPsoftLink := Value;
    for i:=Low(tblPsoftLinks) to High(tblPsoftLinks) do
        if tblPsoftLinks[i].co=FPsoftLink then begin
          Caption := tblPsoftLinks[i].Name;
          URL     := tblPsoftLinks[i].Link^;
          Hint    := tblPsoftLinks[i].Hint;
          if Pos('http://',URL)>0 then WebType := wtHttp;
          if Pos('mailto:',URL)>0 then WebType := wtEmail;
          Break;
        end;
  end;
end;

{ TpsBarcodeLabel }

procedure TpsBarcodeLabel.SetBarcodeSymbology(const Value: TpsBarcodeSymbology);
begin
  if FTypBarcode<>Value then begin
      FTypBarcode := Value;
      UpdateCaption;
  end;
end;

procedure TpsBarcodeLabel.SetTypInfoItem(const Value: TpsBarcodeInfoItemType);
begin
  if FTypInfoItem<>Value then begin
    FTypInfoItem := Value;
    UpdateCaption;
  end;
end;

procedure TpsBarcodeLabel.UpdateCaption;
begin
  Caption := BarcodeInfoItem(BarcodeSymbology, BarcodeInfoType);
end;


procedure AddTypesToList(L:TStrings; S:TpsBarcodeListStyle);
var q        : Integer;
    PropInfo : PPropInfo;
    TD       : TTypeData;
begin
     PropInfo := GetPropInfo(TypeInfo(TpsCustomBarcode),'TypBarCode');
     TD       := GetTypeData(PropInfo.PropType^)^;
     L.BeginUpdate;
     try
        L.Clear;
        for q:=TD.MinValue to TD.MaxValue do begin
            if    S=btSymbol then L.Add(GetEnumName(PropInfo^.PropType^,q))
            else                  L.Add(BarcodeInfo(TpsBarcodeSymbology(q),'').Name);
        end;
     finally
          L.EndUpdate;
     end;
end;


function  addLabelWeb(F:TWinControl; X,Y:Integer;
  text:string; url:string):TpsBarcodeWebLabel;
begin
  Result:=TpsBarcodeWebLabel.Create(F);
  with Result do begin
    Parent  := F;
    Left    := X;
    Top     := Y;
    Caption := text;
  end;
end;


function psMessageDlg(msg:string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; TypBarcode:String;
  HelpCtx: Longint=0; X:Integer=-1; Y: Integer=-1):Integer;
const h=300;
      w=500;
var F:TForm;
begin
  F:=TForm.Create(Application);
  with F do
    try
      Width     := w;
      Height    := h;
      BorderStyle := bsDialog;
      Caption     := constProductName+', '+constCopyright;
      HelpContext := HelpCtx;
      //HelpFile  := HelpFileName;
      if X >= 0 then Left := X;
      if Y >= 0 then Top := Y;
      if (Y < 0) and (X < 0) then Position := poScreenCenter;


      with TLabel.Create(F) do begin
        Parent:=F;
        Left := 20; Top:= 20;
        Caption := constProductName;
        Font.Size := 14;  Font.Style := [fsBold];
      end;
      Result := ShowModal;
    finally
      Free;
    end;
end;

function  psDialogWithURL(msg:string; dlgfType:TMsgDlgType;
    Buttons: TMsgDlgButtons):Integer;
var F:TForm;
    x,y:integer;
begin
  x:=10;
  y:=200;
  // F:=CreateMessageDialog(Msg,DlgfType,Buttons);
  F:=TForm.Create(Application);
  try
    F.Width := 400;
    F.Height := 300;
    AddLabel(F,20,20,'ahoj',[fsBold,fsItalic]);
    AddLabelWeb(F,x,y,'barcode-software.eu','http://barcode-software.eu');
    Result := F.ShowModal;
  finally
    F.Free;
  end;
end;


function  addLabel(F:TWinControl; X,Y:Integer;  text:string; fs:TFontStyles=[]):TLabel;
begin
  Result:=TLabel.Create(F);
  with Result do begin
    Parent  := F;
    Left    := X;
    Top     := Y;
    Font.Style := fs;
    Caption := text;
  end;
end;

function  addEdit(F:TWinControl; X,Y,W:Integer;  edText:string):TEdit;
begin
  Result:=TEdit.Create(F);
  with Result do begin
    Parent  := F;
    Left    := X;
    Top     := Y;
    Width   := W;
    Text    := edText;
  end;
end;

function  addBtn(F:TWinControl; X,Y,W:Integer;  btnText:string; prc:TNotifyEvent):TBitBtn;
begin
  Result:=TBitBtn.Create(F);
  with Result do begin
    Parent  := F;
    Left    := X;
    Top     := Y;
    Width   := W;
    Caption := btnText;
    OnClick := prc;
  end;
end;

function  addComboType(F:TWinControl; X,Y,W:Integer;      ti:pointer=nil; value:integer=0):TComboBox;
begin
  Result:=TComboBox.Create(F);
  with Result do begin
    Parent  := F;
    Left    := X;
    Top     := Y;
    Width   := W;
  end;
end;

function  addLine(F:TWinControl; X,Y,W:Integer; C:TColor):TShape;
begin
  Result:=TShape.Create(F);
  with Result do begin
    Parent  := F;
    Left    := X;
    Top     := Y;
    Width   := W;
    Height  := 2;
    Brush.Color := C;
    Pen.Width := 0;
    Pen.Style := psClear;
  end;
end;

{ TpsBarcodeAbout }

function  psCreateAboutDlg(ParentControl:TWinControl; demo:boolean;
    ShowCloseBtn:Boolean): Integer;
var hlLBL :TLabel;
    dx, dy:Integer;

      function AddLabel(const txt:String):TLabel;
      begin
        Result:=TLabel.Create(ParentControl);
        with Result do begin
          Parent  := ParentControl;
          Left    := dx;
          Top     := dy;
          Caption := txt;
        end;
      end;

      function AddLink(const C,u:String):TpsBarcodeWebLabel; overload;
      begin
        Result:= TpsBarcodeWebLabel.Create(ParentControl);
        with Result do begin
          Parent  := ParentControl;
          Left    := dx;
          Top     := dy;
          Caption := C;
          URL     := u;
          Hint    := url;
          Inc(dy,15);
        end;
      end;

      function AddLink(pl:TpsPsoftLink):TpsBarcodeWebLabel; overload;
      begin
        Result:= TpsBarcodeWebLabel.Create(ParentControl);
        with Result do begin
          Parent    := ParentControl;
          Left      := dx;
          Top       := dy;
          PsoftLink := pl;
          Hint      := url;
          Inc(dy,15);
        end;
      end;

      function AddHR(x,y,w:integer; Colot:TColor) : TShape;
      begin
        Result:=TShape.Create(ParentControl);
        with Result do begin
          Parent    := ParentControl;
          Left      := dx;
          Top       := 50;
          height    := 1;
          width     := ParentControl.ClientWidth-left-10;
          Pen.Width := 1;
          Pen.Color := clSilver;
        end;
      end;

begin
      Result := 1;

      if ParentControl is TForm then
      with TForm(ParentControl) do begin
          Caption     := Format('%s, %s, %s',
              [constProductName,constCopyright,constPSOFTHomePage]);
          Position    := poScreenCenter;
          BorderStyle := bsToolWindow;
          Font.Name   := 'Verdana';
          ShowHint    := True;
      end;

      with ParentControl do begin
        Width       := 450;
        Height      := 420;
      end;

      if ShowCloseBtn then
      with TBitBtn.Create(ParentControl) do begin
        Parent  := ParentControl;
        Kind    := bkClose;
        Default := True;
        Height  := 30;
        Width   := 100;
        Left    := ParentControl.ClientWidth  - Width  - 5;
        Top     := ParentControl.ClientHeight - Height - 5;
      end;

      with TpsCustomBarcode.Create(ParentControl) do begin
        Parent  := ParentControl;
        Left    := 10;
        Top     := 10;
        Width   := 120;
        Options := Options - [boSecurity];
      end;

      dx := 150;
      dy := 10;

      With AddLabel(constProductName) do begin
        Font.Size := 16;
        Font.Style:=[fsBold];
      end;

      with AddLabel('Version : '+constProductVersion) do begin
        Left := 300;
        Top:= 35;
      end;

      AddHR(dx,50,1,clSilver);

      with AddLabel(GetBarcodeLibraryEdition) do begin
          Top         := 55;
          Font.Style  := [fsBold];
          dy          := Top+Height+5;
      end;

      AddLink('For more info about editions click here',constBarcodeStudioEditions);

      if demo then begin
        Inc(dy,15);
        hlLBL := TLabel.Create(ParentControl);

        with hlLBL do begin
          Parent    := ParentControl;
          Left      := dx;
          Top       := dy;
          Width     := ParentControl.ClientWidth-left-10;
          Autosize  := False;
          Height    := ParentControl.ClientHeight - Top-5;
          WordWrap  := True;
          Caption   := 'Why order/register?';
          Font.Style:= [fsBold];
          Font.Color := clRed;
          Font.Size := 2*Font.Size;
        end;
        Inc(dy,hlLBL.Font.Size+15);
        AddHR(dx,dy,1,clSilver);
      end;

      hlLBL:=TLabel.Create(ParentControl);
      with hlLBL do begin
          Parent:=ParentControl;
          Left := dx;  Top := dy;
          Width := ParentControl.ClientWidth-left-10;
          Autosize := False;
          Height   := ParentControl.ClientHeight - Top-5;
          WordWrap := True;

          if demo then
            Caption  := 'Thanks for use trial version. '
              +'This version is limited to use with Delphi/C++Builder IDE only.'+psCRLF
              +'For use in commercial products please register.'+psCRLF+psCRLF
              +'Why register ? Benefits ?'+psCRLF
              +'- Full source code compatible with Delphi/C++Builder'+psCRLF
              +'- native source code, no DLL or another files needed'+psCRLF
              +'- Minor versions updates free'+psCRLF
              +'- One year free updates'+psCRLF
              +'- Free Email support'+psCRLF
              +'- Discount when order another our products'+psCRLF
              +psCRLF
              +'For more information about this product, detail feature list, etc. please visit our homepage.'
          else
            Caption := 'Thanks for using our products.'+psCRLF+psCRLF
              +'For information about news, documentation, bugs reports please visit our homepage.'
              +'Here you can sing up to our newsletter for receiving information about updates and news.'
              +'You can use our discussion forum to get more information about barcode.'+psCRLF+psCRLF
              +'Good information source is our barcode encyclopedia.'+psCRLF+psCRLF
              +'If you have some question, please send problem description using our contact page.';
      end;

      with AddLabel('PSOFT '+constCopyright) do begin
        Font.Style := [fsBold];
        Top    := ParentControl.ClientHeight - Height - 5;
      end;

      // web links
      dx:= 10; dy:=110;
      with AddLabel('Links') do begin
        Font.Style  := [fsBold];
        Font.Size   := 11;
        Inc(dy,25);
      end;
      with TShape.Create(ParentControl) do begin
        Parent    := ParentControl;
        Left      := dx;
        Top       := dy-5;
        height    := 1;
        width     := 130;
        Pen.Width := 1;
        Pen.Color := clMoneyGreen;
        Brush.Style := bsSolid;
        Brush.Color := clYellow;
      end;

        AddLink(plProductsBarcodeStudio);
        AddLink(plDownloadBarcodeStudio);
        AddLink(plRegisterBarcodeStudio);
        Inc(dy,5);

        AddLink(plBarcodeEncyclopedia);
        AddLink(plProductsAll);
        Inc(dy,5);

        AddLink(plEmailSupport);
        AddLink(plHomepage);


        with TpsBarcodeWebLabel.Create(ParentControl) do begin
          Parent      := ParentControl;
          Left        := dx;
          Top         := ParentControl.ClientHeight - 25;
          Font.Size   := Font.Size + 4;
          Font.Style  := [fsBold];
          FontHover.Assign(Font);  FontHover.Style := [fsBold,fsUnderline];
          if demo then begin
            Caption := constCaptionOrderBuy;
            URL     := constRegisterBuy;
          end else begin
            Caption := constCaptionCheckUpdates;
            URL     := CheckForUpdatesURL(1,constProductVersion);
          end;
          Inc(dy,15);
        end;


        // logo barcode-software.eu
        //TpsBarcodeWebLabel.Create(ParentControl);

        {if demo then
          with TTimer.Create(ParentControl) do begin
              Interval := 10000;
              OnTimer  :=
          end;
        }
end;


function psShowAboutDlg(Demo:Boolean):Integer;
var F:TForm;
begin
    Result:=1;
    F:=TForm.Create(nil);
    try
      psCreateAboutDlg(F, Demo, True);
      F.ShowModal;
    finally
      F.Free;
    end;
end;

function psGetPrintRectangle(var R:TpsRect; position : TPosition=poScreenCenter):boolean;
const ofs1 = 10;
      ofs2 = 100;
      difY = 25;
      w    = 100;
var F  : TForm;
    dy : Integer;
    e1, e2, e3, e4 : TEdit;
    b1, b2 : TBitBtn;
begin
  F:=TForm.Create(Application);
  try
    dy := 10;
    F.Caption := rsPrintRectCaption;
    addLabel(F, ofs1, dy, 'Left',[]);
    e1 := addEdit(F, ofs2, dy, w,  Format('%5.2f', [R.Left] ) );
    Inc(dy,difY);

    addLabel(F, ofs1, dy, 'Top',[]);
    e2 := addEdit(F, ofs2, dy, w, Format('%5.2f', [R.Top] ));
    Inc(dy,difY);

    addLabel(F, ofs1, dy, 'Width',[]);
    e3 := addEdit(F, ofs2, dy, w, Format('%5.2f', [R.Width] ));
    Inc(dy,difY);

    addLabel(F, ofs1, dy, 'Height',[]);
    e4 := addEdit(F, ofs2, dy, w, Format('%5.2f', [R.Height] ));
    Inc(dy,difY);

    addLine(f, ofs1, dy, ofs2-ofs1+w, clMoneyGreen);

    Inc(dy, 8);

    b1:=addBtn(F, ofs1, dy, ofs2-ofs1+w , 'Cancel', nil);
    b1.Kind := bkCancel;
    Inc(dy,difY);

    b2:=addBtn(F, ofs1, dy, ofs2-ofs1+w , 'OK', nil);
    b2.Kind := bkOK;
    Inc(dy,difY);

    F.Width   := ofs2 + w + 25;
    F.Height  := dy + difY + 20;

    F.Position := Position;
    F.BorderStyle := bsDialog;

    Result := F.ShowModal = mrOK;
    if Result then begin
        R.Left    := StrToFloatDef(e1.Text, R.Left);
        R.Top     := StrToFloatDef(e2.Text, R.Top);
        R.Width   := StrToFloatDef(e3.Text, R.Width);
        R.Height  := StrToFloatDef(e4.Text, R.Height);
    end;
  finally
    F.Free;
  end;
end;

procedure TpsBarcodeAbout.Execute;
begin
  psShowAboutDlg(True);
end;

function TpsBarcodeAbout.GetCountLinear: Integer;
begin
  Result:=psCount([stLinear], True);
end;

function TpsBarcodeAbout.GetCountMatrix: Integer;
begin
  Result:=psCount([stMatrix], True);
end;

function TpsBarcodeAbout.GetCountPostal: Integer;
begin
  Result:=psCount([stPostalCode], True);
end;

function TpsBarcodeAbout.GetCountStacked: Integer;
begin
  Result:=psCount([stStacked], True);
end;

function TpsBarcodeAbout.GetCountSupported: Integer;
begin
  Result:=psCount([], True);
end;

function TpsBarcodeAbout.GetEdition: String;
begin
  Result := GetBarcodeLibraryEdition;
end;

function TpsBarcodeAbout.GetProductName: String;
begin
  Result:=constProductName;
end;

function TpsBarcodeAbout.GetVersion: String;
begin
  Result := constProductVersion;
end;

procedure TpsBarcodeAbout.SetEdition(const Value: String);
begin
end;

procedure TpsBarcodeAbout.SetProductName(const Value: String);
begin
end;

procedure TpsBarcodeAbout.SetVersion(const Value: String);
begin
end;



constructor TpsBarcodeReader.Create(AOwner: TComponent);
begin
     inherited Create(AOwner);

     FComPort     := psCom2;
     FComParity   := parityEven;
     FComBitRate  := br9600;
     FComdataBits := db8Bits;
     FComStopBits := sbStop1;
     FTimeOut     := 100;

     FReadThread  := nil;
     FActive      := False;
     FOptions     := [];
end;

destructor TpsBarcodeReader.Destroy;
begin
     if FActive then
        InternalClose;
     inherited Destroy;
end;

procedure TpsBarcodeReader.Loaded;
begin
     inherited Loaded;
     if Active then InternalOpen;
end;

procedure TpsBarcodeReader.InternalOpen;
begin
        if FActive then InternalClose;
        FReadThread := TEanReadThread.CreateEan(Self);
        FActive := True;
end;

procedure TpsBarcodeReader.InternalClose;
begin
    if FActive then
        FReadThread.Terminate;
    FReadThread.Free;
    FReadThread := nil;
    FActive := False;
end;


procedure TpsBarcodeReader.SetActive(const Value: Boolean);
begin
    if FActive<>Value then begin
        if Value then InternalOpen
        else          InternalClose;
    end;
end;

constructor TEanReadThread.CreateEan(Reader: TpsBarcodeReader);
var PortName:String;
    lpdcb:Tdcb;
    mode : DWORD;
begin
        inherited create(False);

        ReturnValue := Self.Handle;

        FReader  := Reader;
        PortName := '\\.\COM'+IntToStr(Integer(Reader.Port)+1);
        FTimeOut := Reader.TimeOut;
        SetLength(FBarcode,20);
        FBarcode := '';

        if boEnabledSend in Reader.Options then
                mode := GENERIC_READ+GENERIC_WRITE
        else
                mode := GENERIC_READ;

        FComHandle:=CreateFile(PChar(PortName),
                mode,
                0,
                nil,
                OPEN_EXISTING,
                FILE_FLAG_OVERLAPPED,
                0);

        if FComHandle=INVALID_HANDLE_VALUE then
                raise Exception.Create(rsErrorOpeningComPort);

        // set serial port parameters here
        SetupComm(FComHandle, 8192, 0);
        GetCommState(FComHandle,lpdcb);
        case Reader.BitRate of
                br115200 : lpdcb.baudrate:= 115200;
                br57600  : lpdcb.baudrate:=  57600;
                br38400  : lpdcb.baudrate:=  38400;
                br19200  : lpdcb.baudrate:=  19200;
                br14400  : lpdcb.baudrate:=  14400;
                br9600   : lpdcb.baudrate:=   9600;
                br4800   : lpdcb.baudrate:=   4800;
                br2400   : lpdcb.baudrate:=   2400;
                br1200   : lpdcb.baudrate:=   1200;
                br600    : lpdcb.baudrate:=    600;
                br300    : lpdcb.baudrate:=    300;
        end;
        case Reader.StopBits of
                sbStop1  : lpdcb.StopBits:=ONESTOPBIT;
                sbStop15 : lpdcb.StopBits:=ONE5STOPBITS;
                sbStop2  : lpdcb.StopBits:=TWOSTOPBITS;
        end;
        case Reader.DataBits of
                db8Bits  : lpdcb.ByteSize:=8;
                db7Bits  : lpdcb.ByteSize:=7;
        end;
        case Reader.Parity of
                parityNone      : lpdcb.Parity:= NoParity;
                parityOdd       : lpdcb.Parity:= OddParity;
                paritySpace     : lpdcb.Parity:= NoParity;
                parityEven      : lpdcb.Parity:= EvenParity;
                parityMark      : lpdcb.Parity:= MarkParity;
        end;


        SetCommState(FComHandle,lpdcb);
        SetCommMask(FComHandle,EV_RXCHAR + EV_TXEMPTY);

        FreeOnTerminate := False;
end;


procedure TEanReadThread.DataReceived;
    procedure BarcodeRemove(ch:Char);
    var l,k:Integer;
    begin
         k:=Pos(ch,FBarcode);
         l:=Length(FBarcode);
         while k>0 do begin
               FBarcode:=Copy(FBarcode,1,k-1)+Copy(FBarcode,k+1,l);
               k:=Pos(ch,FBarcode);
         end;
    end;
begin
        if boRemoveCR in FReader.Options then
           BarcodeRemove(#13);
        if boRemoveLF in FReader.Options then
           BarcodeRemove(#10);

        FReader.Lastbarcode := FBarcode;
        if Assigned(FReader.OnBarcodeReady) then
                FReader.OnBarcodeReady(FReader, FBarcode);
        FBarcode := '';
end;

procedure TEanReadThread.DataSent;
begin
           if Assigned(FReader.OnAfterSend) then
              FReader.OnAfterSend(FReader, FReader.LastSendString);
end;

procedure TEanReadThread.Execute;
var WaitHandles : array[0..1] of THandle;
    Overlap     : TOverlapped;
    WaitEvent   : Cardinal;
begin
    ZeroMemory(@Overlap, SizeOf(Overlap));
    CloseEvent     := CreateEvent(nil, True, False, nil);
    Overlap.hEvent := CreateEvent(nil, True, True,  nil);

    WaitHandles[0] := CloseEvent;
    WaitHandles[1] := Overlap.hEvent;

    while not Terminated do begin
        WaitCommEvent(FComHandle, FEventMask, @Overlap);
        WaitEvent := WaitForMultipleObjects(2, @WaitHandles, False, FTimeOut);
        case WaitEvent of
                WAIT_OBJECT_0     : Terminate;
                WAIT_OBJECT_0 + 1 : HandleComPortEvent;
                WAIT_TIMEOUT      : if FBarcode<>'' then Synchronize(DataReceived);
        end;
    end;

    CloseHandle(Overlap.hEvent);
    CloseHandle(CloseEvent);
    CloseHandle(FComHandle);
end;

function TEanReadThread.ComPortHandle: THandle;
begin
        Result := FComHandle;
end;

procedure TEanReadThread.HandleComPortEvent;
var ErrorMask : DWORD;
    ComStat   : TComStat;
    Overlapped: TOverlapped;
    BytesRead : DWORD;
    Buffer    : array[0..4095] of Char;
    Received  : Integer;
    i,ofs     : Integer;
begin
        ClearCommError(FComHandle, ErrorMask, @ComStat);
        if (FEventMask and EV_RXCHAR)<>0 then begin
                Received := ComStat.cbInQue;
                if Received>4096 then Received:=4096;
                if Received>0 then begin
                        ZeroMemory(@OverLapped, SizeOf(OverLapped));
                        Readfile(FComHandle, Buffer, Received, BytesRead, @OverLapped);
                        ofs := Length(FBarcode);
                        SetLength(FBarcode, ofs+Received);
                        for i:=1 to Received do
                                FBarcode[ofs+i] := Buffer[i-1];
                end;
        end;

        if (FEventMask and EV_TXEMPTY)<>0 then
                Synchronize(DataSent);
end;


procedure   TEanReadThread.Send(s:String);
var Buffer    : array[0..4095] of Char;
    i         : Integer;
begin
     for i:=1 to Length(s) do
         buffer[i-1] := s[i];
     WriteFile(FComHandle, Buffer, Length(s), FReader.LastSendCount, nil);
end;

procedure TpsBarcodeReader.ReConnect;
begin
        Active := False;
        Active := True;
end;

procedure TpsBarcodeReader.SetOptions(Value:TpsBarcodeReaderOptions);
var ac:Boolean;
begin
     ac:=Active;
     InternalClose;
     FOptions := Value;
     if ac then InternalOpen;
end;

procedure TpsBarcodeReader.SendToPort(s:String);
begin
     if not (boEnabledSend in Options) then Exit;
     if not Active then InternalOpen;

     LastSendString := s;
     LastSendCount  := 0;

     FReadThread.Send(s);
end;

procedure TpsBarcodeReader.ActivateScale;
begin
     SendToPort(FScaleString);
end;


function TpsBarcodeReader.GetHandle: THandle;
begin
        if Assigned(FReadThread) then
                Result := FReadThread.ComPortHandle
        else
                Result := 0;
end;

procedure TpsBarcodeReader.SetHandle(const Value: THandle);
begin
        {}
end;


end.
