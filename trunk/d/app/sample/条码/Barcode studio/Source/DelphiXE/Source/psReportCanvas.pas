unit psReportCanvas;

interface

uses
  Windows, WinSpool, Printers, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Mask, ExtCtrls, Buttons, ComCtrls,
  DB, DBCtrls, DBGrids, Grids, IniFiles,
  psTypes, psBarcodeComp, psBarcode, psCodeFNLite, psCodeFN, psCodeSpecs, psCodeRes, psCodeDB;

const constSheetFieldSeparator='|';

type
  TpsPrinter = class;

  TpsPrintParamsFmt = class(TForm)
    Panel1: TPanel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    btnHelp: TBitBtn;
    btnPrint: TBitBtn;
    btnPrinterSetup: TBitBtn;
    PrintDialog: TPrintDialog;
    PrinterPageSetup: TPageSetupDialog;
    btnPageSetup: TBitBtn;
    Splitter1: TSplitter;
    pnlPreview: TPanel;
    lblPaperSize: TLabel;
    lblPrinter: TLabel;
    lblDocumentTitle: TLabel;
    Panel3: TPanel;
    ZAL: TPageControl;
    SH_PARAMS: TTabSheet;
    Panel4: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ED_Width: TMaskEdit;
    ED_Height: TMaskEdit;
    ED_LEFT: TMaskEdit;
    ED_TOP: TMaskEdit;
    ED_RIGHT: TMaskEdit;
    ED_BOTTOM: TMaskEdit;
    ED_SPACEX: TMaskEdit;
    ED_SPACEY: TMaskEdit;
    CB_UNITS: TComboBox;
    CB_STYLE: TComboBox;
    ED_COUNT: TMaskEdit;
    ED_STARTFROM: TMaskEdit;
    ED_Title: TMaskEdit;
    SH_DATA: TTabSheet;
    DBGrid: TDBGrid;
    DBNav: TDBNavigator;
    SH_PreviewParams: TTabSheet;
    CB_LivePreview: TCheckBox;
    cb_ColorLabel: TColorBox;
    cb_ColorPage: TColorBox;
    cb_ColorShadow: TColorBox;
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    TabPages: TTabControl;
    PreviewBox: TPaintBox;
    ListBox1: TListBox;
    Button1: TButton;
    Panel2: TPanel;
    Label6: TLabel;
    Label1: TLabel;
    lblSelectedHeader: TLabel;
    lblDataSelectedCount: TLabel;
    lblLabelsPerPage: TLabel;
    ud: TUpDown;
    e1: TEdit;
    lblPagesCount: TLabel;
    Label9: TLabel;
    cb_SheetsDatabase: TComboBox;
    SH_LABELS: TTabSheet;
    Panel5: TPanel;
    btnOpenSheets: TBitBtn;
    BitBtn2: TBitBtn;
    TV_SHEETS: TTreeView;
    OD: TOpenDialog;
    procedure btnPrinterSetupClick(Sender: TObject);
    procedure CB_UNITSChange(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnPageSetupClick(Sender: TObject);
    procedure DBGridCellClick(Column: TColumn);
    procedure PreviewBoxPaint(Sender: TObject);
    procedure ED_TitleChange(Sender: TObject);
    procedure udClick(Sender: TObject; Button: TUDBtnType);
    procedure e1Change(Sender: TObject);
    procedure TabPagesChange(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cb_SheetsDatabaseChange(Sender: TObject);
    procedure btnOpenSheetsClick(Sender: TObject);
  private
    InUpdate : Boolean;
    procedure UpdateParams;
    procedure UpdateLblPaperSize(updateUD:Boolean=True);
    procedure UpdatePageIndex(idx:Integer);
    procedure UpdateAll;

    procedure LoadSheets(fn:TFileName; tv:TTreeView);

  public
    psPrinter : TpsPrinter;
    constructor Create(AOwner:TComponent); override;
    destructor  Destroy; override;
    procedure   LoadPrinterParams;
    procedure   PreviewVisible(visible:Boolean);
  end;

  // ----------------------------------------------------------------------
  // types used for printing
  // ----------------------------------------------------------------------

  TpsUnits = (buMilimetres, buInches{, buPixels});
  TpsPrintStyle = (psSingle, psSheet, psSheetInc, psSheetSymbologies,
      psTableData, psSelectedRows);
  TpsPrintNextMode=(mnNone, mnNextValue, mnNextFromTable, mnStandard,
      mnAddOn2, mnAddOn5);
  TpsPrintRect = record
    Left, Top, Right, Bottom : Double;
  end;

  TpsPrintLabelEvent = procedure(Sender:TObject; BarcodeComponent: TComponent;
      var ViewRect:TpsPrintRect; var Enabled: Boolean; var EndLoop:Boolean) of Object;

  TpsPrintPageEvent  = procedure(Sender:TObject; CurrPage, TotalPages:Integer) of Object;


  TpsPaperParamsRec = record
    FSpaceX       : Double;
    FSpaceY       : Double;
    FLabelWidth   : Double;
    FLabelHeight  : Double;
    FMarginBottom : Double;
    FMarginTop    : Double;
    FMarginLeft   : Double;
    FMarginRight  : Double;
    FUnits        : TpsUnits;
    FStyle        : TpsPrintStyle;
    FDocumentTitle: String;

    FDpiX, FDpiY                : Integer;
    pPaperWidth  , pPaperHeight : Integer; // in pixels
    mm10Width , mm10Height      : Integer;
    FOffsetX, FOffsetY          : Integer;
    FPaperID                    : Integer;
    FPaperName                  : String;
  end;

  PPaperParamsRec = ^TpsPaperParamsRec;

  TpsPrinterPreview = class(TPersistent)
  private
    FPaperColor : TColor;
    FLive       : Boolean;
    FLabelColor : TColor;
    FShadowColor: TColor;
    FVisiblePage: Boolean;
    FShadowWidth: Integer;
  public
    constructor Create;
    destructor  Destroy; override;
  published
    property PaperColor:TColor read FPaperColor write FPaperColor;
    property LabelColor:TColor read FLabelColor write FLabelColor;
    property LivePreview:Boolean read FLive write FLive default True;
    property ShadowColor:TColor read FShadowColor write FShadowColor;
    property ShadowWidth:Integer read FShadowWidth write FShadowWidth;
    property VisiblePage:Boolean read FVisiblePage write FVisiblePage default true;
  end;

  ///  <summary>Paper parameters</summary>
  ///  <comments>Some parameters (PaperWidth, PaperHeight) are read-only, automatically set from selected printer/selected paper format</comments>
  ///  <remarks>Main parameters of paper, label sizes, positons, margins ...</remarks>
  TpsPaperParams = class(TPersistent)
  private
    FParams       : TpsPaperParamsRec;
    FParamsBackup : TpsPaperParamsRec;
    function  GetPaperHeight: Double;
    function  GetPaperWidth: Double;
    procedure SetUnits(const Value: TpsUnits);
    procedure UpdatePrinterParams;
    procedure SetDefaults;
    function  GetNonPrintableHorz: Double;
    function  GetNonPrintableVert: Double;
    function  PixelsHorzToCurrUnit(X:Integer):Double;
    function  PixelsVertToCurrUnit(Y:Integer):Double;
  public
    constructor Create;
    procedure BackupParams;
    procedure RestoreParams;
    function  NextLabel(var pR:TpsPrintRect):Boolean;
    procedure ChangeUnits(NewUnits:TpsUnits);
    function  LabelsPerPage: Integer;
    function  PaperFormat: String;

    property  pPaperHeight:Integer read FParams.pPaperHeight write FParams.pPaperHeight;
    property  pPaperWidth:Integer read FParams.pPaperWidth write FParams.pPaperWidth;
    property  OffsetX:Integer read FParams.FOffsetX write FParams.FOffsetX;
    property  OffsetY:Integer read FParams.FOffsetY write FParams.FOffsetY;
  published
    property  PaperWidth:Double read GetPaperWidth stored False;
    property  PaperHeight:Double read GetPaperHeight stored False;
    property  PaperName:String read FParams.FPaperName stored False;
    property  LabelWidth:Double read FParams.FLabelWidth write FParams.FLabelWidth;
    property  LabelHeight:Double read FParams.FLabelHeight write FParams.FLabelHeight;
    property  MarginTop:Double read FParams.FMarginTop write FParams.FMarginTop;
    property  MarginLeft:Double read FParams.FMarginLeft write FParams.FMarginLeft;
    property  MarginRight:Double read FParams.FMarginRight write FParams.FMarginRight;
    property  MarginBottom:Double read FParams.FMarginBottom write FParams.FMarginBottom;
    property  SpaceX:Double read FParams.FSpaceX write FParams.FSpaceX;
    property  SpaceY:Double read FParams.FSpaceY write FParams.FSpaceY;
    property  NonPrintableHorz : Double read GetNonPrintableHorz stored False;
    property  NonPrintableVert : Double read GetNonPrintableVert stored False;
    property  Units:TpsUnits read FParams.FUnits write SetUnits;
    property  Style:TpsPrintStyle read FParams.FStyle write FParams.FStyle;
    property  DocumentTitle:String read FParams.FDocumentTitle write FParams.FDocumentTitle;
  end;

  TpsPrinterProgressEvent=procedure(Sender:TObject;
    const PageIndex, PageCount:Integer) of Object;

  /// <summary>Component for easy print bar code on the printer as sheet</summary>
  TpsPrinter = class(TComponent)
  private
    FBarcodeObject  : TpsBarcodeComponent;
    FFont           : TFont;
    FOnBeforePrint  : TpsPrintLabelEvent;
    FOnAfterPrint   : TpsPrintLabelEvent;
    FOnReportHeader : TNotifyEvent;
    FOnReportFooter : TNotifyEvent;
    FOnPageHeader   : TpsPrintPageEvent;
    FOnPageFooter   : TpsPrintPageEvent;

    FFontHeightMM   : Double;
    FCurrRect       : TRect;
    FCurrCanvas     : TCanvas;
    FCurrIsPrinter  : Boolean;
    FPrintPageIndex : Integer;
    FPrintPagesCount: Integer;

    FPageIndex      : Integer;
    FStartFrom      : Integer;
    FCount          : Integer;
    // FDataSource     : TDataSource;
    FViewControl    : TCustomControl;
    FPreviewParams  : TpsPrinterPreview;
    FPaperParams    : TpsPaperParams;
    FShowProgress   : Boolean;
    FSheets         : TStringList;
    FAbortPrint     : Boolean;
    FOnProgress     : TpsPrinterProgressEvent;
    FHelpType       : THelpType;
    FHelpKeyword    : String;
    FHelpContext    : THelpContext;

    procedure SetBarcodeObject(const Value:TpsBarcodeComponent);

    procedure DoReportHeader;
    procedure DoReportFooter;
    procedure DoPageHeader;
    procedure DoPageFooter;

    procedure SetFont(const Value: TFont);
    procedure SetCount(const Value: Integer);
    procedure SetPaperParams(const Value: TpsPaperParams);
    procedure SetPreviewParams(const value: TpsPrinterPreview);
    procedure SetSheets(const Value: TStringList);

    procedure psAbortPrint(Sender:TObject);

    procedure psNextBarcode(bc:TpsBarcodeComponent);
    function  GetAbout:String;
  protected
    procedure   CheckBarcode;
  public
    constructor Create(Aowner:TComponent); override;
    destructor  Destroy; override;

    procedure   SetHelpProp(C:TControl);
    class function    IsPrinterInstalled:Boolean;

    procedure   SheetsFill(sl:TStrings);
    procedure   SheetsSelect(idx:Integer);

    procedure   Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure   Print;
    procedure   Preview(C: TCanvas; ViewRect: TRect);
    procedure   EditParams(ShowPreview:Boolean=True); overload;

    procedure   PrinterSetup;
    procedure   PageSetup;

    class procedure GetPaperNames(sl:TStrings);
    class function  PrinterName:String;

    class procedure ListPapers(sl: TStrings);

    procedure SetDefaults;

    function  ConvertPoint(X,Y:Double):TPoint;
    function  ConvertRect (R:TpsPrintRect): TRect;
    function  ConvertHeight(H:Double):Integer;
    procedure TextOut(Left,Top:Double; Text:String);
    procedure FontHeight(Value:Double);

    function  PagesCount: Integer;
    function  PagesCountString:String;
    function  LabelsCount:Integer;
    function  IsDataAware:Boolean;
    function  DataSource:TDataSource;
    function  DataSet:TDataSet;

    property  ViewControl:TCustomControl read FViewControl write FViewControl;

  published
    property About:string read GetAbout stored false;
    property HelpContext: THelpContext read FHelpContext write FHelpContext;
    property HelpType: THelpType read FHelpType write FHelpType;
    property HelpKeyword: String read FHelpKeyword write FHelpKeyword;


    property  PaperParams:TpsPaperParams read FPaperParams write SetPaperParams;
    property  Count:Integer read FCount write SetCount;
    property  StartFrom:Integer read FStartFrom write FStartFrom;
    property  BarcodeObject:TpsBarcodeComponent read FBarcodeObject write SetBarcodeObject;
    property  PageIndex:Integer read FPageIndex write FPageIndex;
    property  Font:TFont read FFont write SetFont;
    property  FontHeightMM :Double read FFontHeightMM write FFontHeightMM;
    property  PreviewParams:TpsPrinterPreview read FPreviewParams write SetPreviewParams;
    property  Sheets:TStringList read FSheets write SetSheets;
    property  ShowProgress:Boolean read FShowProgress write FShowProgress;

    property  OnBeforePrint:TpsPrintLabelEvent read FOnBeforePrint write FOnBeforePrint;
    property  OnAfterPrint:TpsPrintLabelEvent read FOnAfterPrint write FOnAfterPrint;
    property  OnReportHeader:TNotifyEvent read FOnReportHeader write FOnReportHeader;
    property  OnReportFooter:TNotifyEvent read FOnReportFooter write FOnReportFooter;
    property  OnPageHeader:TpsPrintPageEvent read FOnPageHeader write FOnPageHeader;
    property  OnPageFooter:TpsPrintPageEvent read FOnPageFooter write FOnPageFooter;
    property  OnPrintProgress:TpsPrinterProgressEvent read FOnProgress write FOnProgress;
  end;

//----------------------------------------------------------------------------
// procedures to output barcode on the any Canvas or HWnd ...
// or you can use same procedures without prefix ps from unit psBarcode
//----------------------------------------------------------------------------

  procedure psPaintBarCode(C:TCanvas; R:TRect; E:TpsBarcodeComponent);
  procedure psPaintBarCodeControl(WinControl:TWinControl; R:TRect; E:TpsBarcodeComponent);
  procedure psPaintBarCodeHandle(HWnd:THandle; R:TRect; E:TpsBarcodeComponent);

  procedure psPrintBarcode(bc:TpsBarcodeComponent);

  procedure psChangeUnits(NewUnits:TpsUnits; var pp:TpsPaperParamsRec);

  function  psPrinterSetup:Boolean;


{
  procedure psPrintParamsEdit(bc:TpsBarcodeComponent; var par:TpsPrintParamsRec); overload;
  procedure psPrintParamsEdit(bc:TpsBarcodeComponent); overload;
  procedure psPrintParamsPreview(bc:TpsBarcodeComponent; par:TpsPrintParamsRec;
    C:TCanvas; ViewRect:TRect);

  procedure psPrintLabels(bc:TpsBarcodeComponent; par:TpsPrintParamsRec); overload;

  procedure psPrintLabel(bc:TpsBarcodeComponent; Left, Top, Width, Height:Double);

  function  psLabelsPerPage(const par:TpsPrintParamsRec):Integer;
  function  psPagesCount(const par:TpsPrintParamsRec):Integer;
}

{$R *.dfm}


implementation

procedure psChangeUnits(NewUnits:TpsUnits; var pp:TpsPaperParamsRec);
var koef:Double;
  function psRound(x:double):double;
  const decimals=10000;
  begin
    Result := Trunc(decimals*x*koef + 0.5)/decimals;
  end;
begin
  if NewUnits<>pp.FUnits then begin
      Koef :=1;
      if (NewUnits=buMilimetres) and (pp.FUnits=buInches) then
        Koef := psInchMM;
      if (pp.FUnits=buMilimetres) and (NewUnits=buInches) then
        Koef := 1/psInchMM;

      pp.FLabelWidth    := psRound(pp.FLabelWidth);
      pp.FLabelHeight   := psRound(pp.FLabelHeight);
      pp.FMarginTop     := psRound(pp.FMarginTop);
      pp.FMarginLeft    := psRound(pp.FMarginLeft);
      pp.FMarginRight   := psRound(pp.FMarginRight);
      pp.FMarginBottom  := psRound(pp.FMarginBottom);
      pp.FSpaceX        := psRound(pp.FSpaceX);
      pp.FSpaceY        := psRound(pp.FSpaceY);
      pp.FUnits         := NewUnits;
  end;
end;


procedure psPaintBarCode(C:TCanvas; R:TRect; E:TpsBarcodeComponent);
begin
    PaintBarCode(C, R, E);
end;

procedure psPaintBarCodeControl(WinControl:TWinControl; R:TRect; E:TpsBarcodeComponent);
begin
    // PaintBarcodeControl(WinControl,R,E);
end;

procedure psPaintBarCodeHandle(HWnd:THandle; R:TRect; E:TpsBarcodeComponent);
begin
  PaintBarCodeHandle(HWnd, R, E);
end;

procedure psPrintBarcode(bc:TpsBarcodeComponent);
var P:TpsPrinter;
begin
  P:= TpsPrinter.Create(nil);
  try
    P.BarcodeObject := bc;
    P.EditParams;
  finally
    P.Free;
  end;
end;

procedure TpsPrintParamsFmt.UpdateAll;
begin
    psPrinter.PaperParams.UpdatePrinterParams;
    UpdateLblPaperSize(False);
end;

procedure TpsPrintParamsFmt.UpdateLblPaperSize(updateUD:Boolean=True);
var DataSelected, DataCnt:Integer;
    ds : TDataSource;
    p  : TpsPrinter;
    i  : Integer;
begin
  p :=psPrinter;
  if UpdateUD then begin
    ud.Max      := p.PagesCount;
    ud.Min      := 1;
    if p.PageIndex>p.PagesCount then
      p.PageIndex:=p.PagesCount;
    ud.Position := p.PageIndex;
  end;

  LblPaperSize.Caption      := p.PaperParams.PaperFormat;
  LblPrinter.Caption        := p.PrinterName;
  lblPagesCount.Caption     := Format(' of %4d',[p.PagesCount]);
  lblLabelsPerPage.Caption  := IntToStr(p.PaperParams.LabelsPerPage);
  if TabPages.Tabs.Count<>p.PagesCount then begin
      TabPages.Tabs.BeginUpdate;
      TabPages.Tabs.Clear;
      for i:=0 to p.PagesCount - 1 do
          TabPages.Tabs.Add(IntToStr(i+1));
      TabPages.Tabs.EndUpdate;
  end;
  TabPages.TabIndex := p.PageIndex-1;

  ds := p.DataSource;
  DataCnt      := 0;
  DataSelected := 0;
  if Assigned(ds) then begin
    if Assigned(ds.DataSet) then
      DataCnt := ds.DataSet.RecordCount
    else
      DataCnt := 0;
    DataSelected := DBGrid.SelectedRows.Count;
  end;
  if DataSelected=0 then
    DataSelected := DataCnt;
  lblDataSelectedCount.Caption := Format('%d/%d',[DataSelected, DataCnt]);

  PreviewBox.Repaint;
end;

procedure TpsPrintParamsFmt.UpdatePageIndex(idx: Integer);
begin
  psPrinter.PageIndex := idx;
  TabPages.TabIndex := idx-1;
  e1.Text           := IntToStr(idx);
  PreviewBox.Invalidate;
end;

procedure TpsPrintParamsFmt.UpdateParams;
begin
  if InUpdate then Exit;
  try
    InUpdate :=True;
    with psPrinter, psPrinter.PaperParams do begin
        Units         := TpsUnits(CB_Units.ItemIndex);
        Style         := TpsPrintStyle(CB_Style.ItemIndex);
        LabelWidth    := StrToFloat(ED_Width.Text);
        LabelHeight   := StrToFloat(ED_Height.Text);
        MarginLeft    := StrToFloat(ED_Left.Text);
        MarginTop     := StrToFloat(ED_Top.Text);
        MarginRight   := StrToFloat(ED_Right.Text);
        MarginBottom  := StrToFloat(ED_Bottom.Text);
        SpaceX        := StrToFloat(ED_SpaceX.Text);
        SpaceY        := StrToFloat(ED_SpaceY.Text);
        Count         := StrToIntDef(ED_COUNT.Text,1);
        StartFrom     := StrToIntDef(ED_STARTFROM.Text,0);
        DocumentTitle := ED_Title.Text;

        PreviewParams.LivePreview := CB_LivePreview.Checked;
        PreviewParams.LabelColor  := cb_ColorLabel.Selected;
        PreviewParams.PaperColor  := cb_ColorPage.Selected;
        PreviewParams.ShadowColor := cb_ColorShadow.Selected;

        if PageIndex>PagesCount then
            PageIndex     := 1;
        UpdateLblPaperSize;
    end;
  finally
      InUpdate:=False;
  end;
end;

procedure TpsPaperParams.UpdatePrinterParams;
type
  TPointArray = array[0..8191] of TPoint;
  PPointArray = ^TPointArray;
var
  Buffer          : array[0..65535] of Char;
  PaperCount      : integer;
  PaperSizeArray  : PPointArray;
//  PaperNames      : array of string;
//  PaperSizes      : array of TPoint;
//  Papers          : array of SHORT;
  DevMode         : THandle;
  pDevmode        : PDeviceMode;
  FDevice, FDriver, FPort : array [0..255] of Char;
  i, idx : integer;
  tmpPaperSize : TPoint;
begin
  FParams.FDpix        := 600;
  FParams.FDpiy        := 600;
  FParams.pPaperWidth  := Trunc(FParams.FDpix*210/25.4);
  FParams.pPaperHeight := Trunc(FParams.FDpix*297/25.4);
  FParams.FPaperName   := 'A4 (210x297 mm)';
  FParams.FPaperID     := -1;
  FParams.mm10Width    := Trunc(FParams.pPaperWidth*10);
  FParams.mm10Height   := Trunc(FParams.pPaperHeight*10);
  FParams.FPaperName   := 'Unknown';

  if TpsPrinter.IsPrinterInstalled then begin
    FParams.FDpix        := GetDeviceCaps(Printer.handle, LOGPIXELSX);
    FParams.FDpiy        := GetDeviceCaps(Printer.handle, LOGPIXELSY);
    FParams.pPaperWidth  := GetDeviceCaps(Printer.handle, PHYSICALWIDTH);
    FParams.pPaperHeight := GetDeviceCaps(Printer.handle, PHYSICALHEIGHT);
    FParams.FOffsetX     := GetDeviceCaps(Printer.Handle, PHYSICALOFFSETX);
    FParams.FOffsetY     := GetDeviceCaps(Printer.Handle, PHYSICALOFFSETY);


    Printer.GetPrinter(FDevice, FDriver, FPort, DevMode);
    pDevMode := GlobalLock(Devmode);
    if pDevmode <> nil then
    try
      FParams.FPaperID    := pDevMode^.dmPaperSize;

      idx := -1;
      PaperCount := DeviceCapabilities(FDevice, FDriver, DC_PAPERS, @Buffer, nil);
      for i := 0 to PaperCount - 1 do
        if FParams.FPaperID=PWordArray(@Buffer)^[I] then begin
          idx := i;
          Break;
        end;
      if idx>=0 then
      begin
        {PaperCount         := } DeviceCapabilities(FDevice, FDriver, DC_PAPERNAMES, @Buffer, nil);
        FParams.FPaperName := PChar(@Buffer[idx * 64 {128}]);

        DeviceCapabilities(FDevice, FDriver, DC_PAPERSIZE, @Buffer, nil);
        PaperSizeArray := @Buffer;
        tmpPaperSize   := PaperSizeArray^[Idx];

        FParams.mm10Width  := tmpPaperSize.X;
        FParams.mm10Height := tmpPaperSize.Y;
      end;
    finally
      GlobalUnlock(DevMode);
    end;
  end;
end;

procedure TpsPrinter.Preview(C:TCanvas; ViewRect:TRect);
var R,R2        : TRect;
    Zoom        : Double;
    w,h,i       : Integer;
    pR          : TpsPrintRect;
    EndLoop     : Boolean;
    OfsX, OfsY  : Integer;
    CurrPage    : Integer;
    bc          : TpsBarcodeComponent;
    psShadowOffset: Integer;

    function ConvertToView:TRect;
    var pw,ph:Double;
    begin
        pw := PaperParams.PaperWidth;
        ph := PaperParams.PaperHeight;
        if (pw=0) or (ph=0) then Result := Rect(0,0,0,0)
        else begin
          Result.Left   := OfsX + Trunc(w*(pR.Left-PaperParams.NonPrintableHorz)/pw);
          Result.Right  := OfsX + Trunc(w*(pR.Right-PaperParams.NonPrintableHorz)/pw);
          Result.Top    := OfsY + Trunc(h*(pR.Top-PaperParams.NonPrintableVert)/ph);
          Result.Bottom := OfsY + Trunc(h*(pR.Bottom-PaperParams.NonPrintableVert)/ph);
        end;
    end;
begin
  psShadowOffset := PreviewParams.ShadowWidth;
  if PaperParams.pPaperHeight<>0 then
    Zoom := PaperParams.pPaperWidth/PaperParams.pPaperHeight
  else
    Zoom := 210/297;  //A4

  h    := HeightOf(ViewRect)-Abs(psShadowOffset);
  w    := Trunc(h*Zoom);

  if (w+psShadowOffset)>WidthOf(ViewRect) then begin
    Zoom := 1/Zoom;
    w    := WidthOf(ViewRect)-Abs(psShadowOffset);
    h    := Trunc(w*Zoom);
  end;

  OfsX := ViewRect.Left + (WidthOf(ViewRect)-psShadowOffset - w) div 2;
  OfsY := ViewRect.Top  + (HeightOf(ViewRect)-psShadowOffset - h) div 2;

  R:= Rect(OfsX, OfsY, OfsX+w-1, OfsY+h-1);

  R2:=R;
  OffsetRect(R2, psShadowOffset, psShadowOffset);

  CurrPage       := 1;
  FCurrIsPrinter := False;
  FCurrCanvas    := C;
  FCurrRect      := R; // ViewRect;

  // PaintPreviewBorder();
  with C do begin
    Brush.Style := bsSolid;
    Brush.Color := PreviewParams.ShadowColor;
    Pen.Style   := psClear;
    FillRect(R2);

    Brush.Style := bsSolid;
    Brush.Color := PreviewParams.PaperColor;
    Pen.Style   := psSolid;
    Pen.Color   := clSilver;
    Pen.Width   := 1;
    FillRect(R);
    Rectangle(R);

    R2:=R;
    i:= MulDiv(PaperParams.OffsetX, w, PaperParams.pPaperWidth);
    Inc(R2.Left, i);
    Dec(R2.Right,i);
    i:= MulDiv(PaperParams.OffsetY, h, PaperParams.pPaperHeight);
    Inc(R2.Top, i);
    Dec(R2.Bottom,i);
    Pen.Style := psDot;
    Rectangle(R2);
  end;

  // loop for paint labels
  pR.Left   := PaperParams.MarginLeft;
  pR.Top    := PaperParams.MarginTop;

  C.Brush.Color := PreviewParams.LabelColor;

  EndLoop       := False;
  i             := 1 - StartFrom;

  bc := nil;
  if BarcodeObject<>nil then
     if Supports(BarcodeObject, IpsDataLink) then begin
        { TODO : dorobit ... }
//        bc := TpsDBBarcode.Create(nil);
//        TpsDBBarcode(bc).Assign(TpsDBBarcode(BarcodeObject));
     end else begin
        bc := TpsBarcodeComponent.Create(nil);
        bc.Assign(BarcodeObject);
     end;

  try
    if Assigned(BarcodeObject) then begin
      bc.Options := bc.Options - [boSecurity];

      case PaperParams.Style of
        psSheetSymbologies : bc.ChangeSymbology(psDirFirst, True);
        psTableData        : if DataSet<>nil then DataSet.First;
      end;
    end;

    FCurrCanvas.Font.Assign(FFont);
    DoReportHeader;
    DoPageHeader;
    while (i<=Count) and not EndLoop do begin
      if i>0 then begin
          pR.Right  := pR.Left + PaperParams.LabelWidth;
          pr.Bottom := pR.Top  + PaperParams.LabelHeight;
          R2 := ConvertToView;
          if PageIndex=CurrPage then begin
            if Assigned(bc) and PreviewParams.LivePreview then begin
              PaintBarcode(C, R2, bc);
              psNextBarcode(bc);
            end else begin
              C.FillRect(R2);
              C.Rectangle(R2);
            end;
          end;
          if PaperParams.Style=psSheetSymbologies then begin
            bc.ChangeSymbology(psDirNext, True);
            bc.CaptionUpper.Visible := True;
            bc.CaptionUpper.Alignment := taCenter;
            bc.CaptionUpper.Text.Text := BarcodeInfoItem(bc.BarcodeSymbology, itName);
          end;
     end;

      if PaperParams.NextLabel(pR) then begin
        if PageIndex=CurrPage then
          DoPageFooter;
        Inc(CurrPage);
        if PageIndex=CurrPage then
          DoPageHeader;
      end;
      Inc(i);
    end;
    DoPageFooter;
  finally
    bc.Free;
  end;
end;

{
procedure psPrintLabels(bc:TpsBarcodeComponent; par:TpsPrintParamsRec);
var pR       : TpsPrintRect;
    R        : TRect;
    i        : Integer;
    bcTemp   : TpsBarcodeComponent;
    NextMode : TpsPrintNextMode;
    BI       : TBarcodeInfo;
    EndLoop  : Boolean;
begin
  Printer.Title := par.DocumentTitle;
  EndLoop       := False;
  Printer.BeginDoc;
  try
    bcTemp := TpsBarcodeComponent.Create(nil);
    try
        if Assigned(bc) then
            bcTemp.Assign(bc);
        if par.Style=psSheetSymbologies then
          bcTemp.BarcodeSymbology := Low(TpsBarcodeComponentSymbology);

        pR.Left   := par.MarginLeft;
        pR.Top    := par.MarginTop;

        i := 1 - par.StartFrom;
        while (i<=par.Count) and not EndLoop do begin
              if i>0 then begin
                pR.Right  := pR.Left+par.LabelWidth;
                pr.Bottom := pR.Top+par.LabelHeight;
                R         := psConvertRect(pR, par);
                PaintBarcode(Printer.Canvas, R, bcTemp);
                if par.Style=psSheetSymbologies then begin

                end;

              end;

              pR.Left := pR.Left + par.LabelWidth+par.SpaceX;
              if pR.Left+par.LabelWidth>par.PaperWidth-par.MarginRight then
              begin
                pR.Left := par.MarginLeft;
                pR.Top  := pr.Top + par.LabelHeight+par.SpaceY;
              end;
              if pR.Top+par.LabelHeight>par.PaperHeight-par.MarginBottom then
              begin
                Printer.NewPage;
                pR.Left   := par.MarginLeft;
                pR.Top    := par.MarginTop;
              end;

              Inc(i);

              if par.Style=psSheetSymbologies then begin
                if bcTemp.BarcodeSymbology=High(TpsBarcodeComponentSymbology) then
                  EndLoop :=True
                else begin
                  bcTemp.BarcodeSymbology  := Succ(bcTemp.BarcodeSymbology);
                  BI := BarcodeInfo(bcTemp.BarcodeSymbology);
                  bcTemp.CaptionUpper.Text := BI.Name;
                end;
              end;
        end;
    finally
      bcTemp.Free;
    end;
  finally
    Printer.EndDoc;
  end;
end;
}


function TpsPrinter.LabelsCount: Integer;
begin
  Result := FCount;
end;

class procedure TpsPrinter.ListPapers(sl: TStrings);
type
  TPointArray = array[0..8191] of TPoint;
  PPointArray = ^TPointArray;
var
  i: integer;
  Buffer: array[0..65535] of Char;
  PrinterName: PChar;
  PaperCount: integer;
  PaperSizeArray: PPointArray;
  PaperNames: array of string;
  PaperSizes: array of TPoint;
  Papers: array of SHORT;
begin
  with Printer do
  begin
    PrinterName := PChar(Printers[PrinterIndex]);
    PaperCount := DeviceCapabilities(PrinterName, '',
      DC_PAPERNAMES, @Buffer, nil);
    SetLength(PaperNames, PaperCount);
    SetLength(PaperSizes, PaperCount);
    SetLength(Papers,     PaperCount);
    for i := 0 to PaperCount - 1 do
      PaperNames[I] := PChar(@Buffer[I * 64 {128}]);

    DeviceCapabilities(PrinterName, '', DC_PAPERSIZE, @Buffer, nil);
    PaperSizeArray := @Buffer;
    for i := 0 to PaperCount - 1 do
      PaperSizes[I] := PaperSizeArray^[I];

    DeviceCapabilities(PrinterName, '', DC_PAPERS, @Buffer, nil);
    for i := 0 to PaperCount - 1 do
      Papers[I] := PWordArray(@Buffer)^[I];

    for i := 0 to PaperCount - 1 do
      sl.Add(Format('%d : %s (%d, %d)',[ Papers[i], PaperNames[i], PaperSizes[i].X, PaperSizes[i].Y] ));
  end;
end;

function  TpsPaperParams.LabelsPerPage:Integer;
var x,y : Integer;
    tmp : Double;
begin
    if (LabelWidth+SpaceX = 0) or (LabelHeight+SpaceY=0) then
        Result := 0
    else begin
        tmp := (PaperWidth - MarginLeft - MarginRight + SpaceX);
        x := Trunc( tmp/(LabelWidth+SpaceX) );
        tmp := (PaperHeight - MarginTop - MarginBottom + SpaceY);
        y := Trunc( tmp/(LabelHeight+SpaceY) );
        Result := x*y;
    end;
end;

procedure TpsPrinter.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation=opRemove then begin
    if AComponent=FBarcodeObject  then FBarcodeObject := nil;
    // if AComponent=DataSource     then DataSource    := nil;
    if AComponent=FViewControl    then FViewControl   := nil;
  end;
end;

function  TpsPrinter.PagesCount:Integer;
var cnt:Integer;
begin
  cnt    := PaperParams.LabelsPerPage;
  Result := 1;
  if cnt>0 then
    Inc(Result, (FStartFrom  + LabelsCount - 1) div cnt);
end;

procedure TpsPrintParamsFmt.btnOKClick(Sender: TObject);
begin
  UpdateParams;
end;

procedure TpsPrintParamsFmt.btnPrintClick(Sender: TObject);
begin
  UpdateParams;
  psPrinter.Print;
end;

procedure TpsPrintParamsFmt.btnPrinterSetupClick(Sender: TObject);
begin
  if psPrinterSetup then
    UpdateAll;
end;

procedure TpsPrintParamsFmt.btnOpenSheetsClick(Sender: TObject);
begin
  LoadSheets('',TV_Sheets);
end;

procedure TpsPrintParamsFmt.btnPageSetupClick(Sender: TObject);
begin
  if PrintDialog.Execute then
    UpdateAll;
end;

procedure TpsPrintParamsFmt.Button1Click(Sender: TObject);
begin
//  TpsPrinter.GetPaperNames(ListBox1.Items);
  TpsPrinter.ListPapers(ListBox1.Items);
end;

procedure TpsPrintParamsFmt.cb_SheetsDatabaseChange(Sender: TObject);
begin
  psPrinter.SheetsSelect( Integer(cb_SheetsDatabase.Items.Objects[cb_SheetsDatabase.ItemIndex]));
  LoadPrinterParams;
  UpdateLblPaperSize;
end;

procedure TpsPrintParamsFmt.CB_UNITSChange(Sender: TObject);
begin
  if InUpdate then Exit;
  // InUpdate := True;
  try
    if Sender=CB_UNITS then begin
      psPrinter.PaperParams.ChangeUnits(TpsUnits(CB_UNITS.ItemIndex));
      LoadPrinterParams;
      UpdateLblPaperSize;
    end else begin
      // psPrinter.PageIndex := StrToIntDef(e1.Text,1);
      if CB_STYLE.ItemIndex=0 then
          ED_Count.Text:='1';
      if CB_STYLE.ItemIndex=3 then
          ED_Count.Text:=IntToStr(psCount([], True));
      UpdateParams;
    end;
  finally
    InUpdate := False;
  end;
end;


procedure TpsPrintParamsFmt.PreviewBoxPaint(Sender: TObject);
begin
  // UpdateLblPaperSize;
//   psPrinter.PageIndex := ud.Position;
  psPrinter.Preview(PreviewBox.Canvas, PreviewBox.ClientRect);
end;


procedure TpsPrintParamsFmt.PreviewVisible(visible:Boolean);
begin
  pnlPreview.Visible := visible;
end;


procedure TpsPrintParamsFmt.TabPagesChange(Sender: TObject);
begin
  UpdatePageIndex(TabPages.TabIndex+1);
end;

procedure TpsPrintParamsFmt.udClick(Sender: TObject; Button: TUDBtnType);
begin
  UpdatePageIndex(ud.Position);
end;

{ TpsPrinter }


procedure TpsPrinter.CheckBarcode;
begin
  if not Assigned(FBarcodeObject) then
    raise Exception.Create('TpsPrinter.BarcodeObject property not assigned.');
end;

function TpsPrinter.ConvertHeight(H: Double): Integer;
begin
    Result := Trunc(HeightOf(FCurrRect)*H/PaperParams.PaperHeight);
end;

function TpsPrinter.ConvertPoint(X, Y: Double): TPoint;
begin
    Result.X := FCurrRect.Left
      + Trunc(WidthOf(FCurrRect)*(X-PaperParams.GetNonPrintableHorz)/PaperParams.PaperWidth);
    Result.Y := FCurrRect.Top
      + Trunc(HeightOf(FCurrRect)*(Y-PaperParams.GetNonPrintableVert)/PaperParams.PaperHeight);
end;

function TpsPrinter.ConvertRect(R: TpsPrintRect): TRect;
begin
  Result.TopLeft     := ConvertPoint(R.Left, R.Top);
  Result.BottomRight := ConvertPoint(R.Right, R.Bottom);
end;

constructor TpsPrinter.Create(Aowner: TComponent);
begin
  inherited;
  FFont          := TFont.Create;
  FPreviewParams := TpsPrinterPreview.Create;
  FPaperParams   := TpsPaperParams.Create;
  FSheets        := TStringList.Create;
  FShowProgress  := True;
  FHelpType      := htContext;
  SetDefaults;
end;


function TpsPrinter.DataSet: TDataSet;
begin
  if DataSource<>nil then
    Result:=DataSource.DataSet
  else
    Result:=Nil;
end;

function TpsPrinter.DataSource: TDataSource;
begin
  Result := nil;
  if Assigned(FBarcodeObject) then
    if Supports(FBarcodeObject, IpsDataLink) then
      Result:=(FBarcodeObject as IpsDataLink).DataSource;
end;

destructor TpsPrinter.Destroy;
begin
  FSheets.Free;
  FPaperParams.Free;
  FPreviewParams.Free;
  FFont.Free;
  inherited;
end;


procedure TpsPrinter.DoPageFooter;
begin
  if Assigned(FOnPageFooter) then
    FOnPageFooter(Self, PageIndex, PagesCount);
end;

procedure TpsPrinter.DoPageHeader;
begin
  if Assigned(FOnPageHeader) then
      FOnPageHeader(Self, PageIndex, PagesCount);
end;

procedure TpsPrinter.DoReportHeader;
begin
    if Assigned(FOnReportHeader) then
      FOnReportHeader(Self);
end;

procedure TpsPrinter.DoReportFooter;
begin
    if Assigned(FOnReportFooter) then
      FOnReportFooter(Self);
end;

procedure TpsPrinter.EditParams(ShowPreview:Boolean=True);
var F:TpsPrintParamsFmt;
begin
  F:=TpsPrintParamsFmt.Create(Application);
  with F do
  try
    psPrinter       := Self;
    PaperParams.BackupParams;
    ZAL.ActivePage  := SH_PARAMS;
    // solve all needed if used dataaware barcode component
    SH_DATA.TabVisible := IsDataAware;
    DBGrid.DataSource := DataSource;
    DBNav.Datasource  := DataSource;
    SH_DATA.TabVisible:= IsDataAware;
    lblDataSelectedCount.Visible := IsDataAware;
    lblSelectedHeader.Visible    := IsDataAware;

    LoadPrinterParams;
    CB_Style.ItemIndex        := Integer(PaperParams.Style);
    ED_Count.Text             := IntToStr(Count);
    ED_StartFrom.Text         := IntToStr(StartFrom);
    ED_Title.Text             := PaperParams.DocumentTitle;
    lblDocumentTitle.Caption  := PaperParams.DocumentTitle;

    UpdateLblPaperSize;

    SH_PreviewParams.TabVisible := PreviewParams.VisiblePage;
    cb_ColorLabel.Selected      := PreviewParams.LabelColor;
    cb_ColorPage.Selected       := PreviewParams.PaperColor;
    cb_ColorShadow.Selected     := PreviewParams.ShadowColor;

    CB_LivePreview.Checked := PreviewParams.LivePreview;

    SheetsFill(cb_SheetsDatabase.Items);

    SetHelpProp(btnHelp);

    if not ShowPreview then F.PreviewVisible(False);

    if ShowModal = mrOK then begin
        // new values
        UpdateParams;
    end else begin
      // return old values;
      PaperParams.RestoreParams;
    end;
  finally
    Free;
  end;
end;


procedure TpsPrinter.SheetsFill(sl:TStrings);
var i,j:Integer;
    s:string;
begin
  sl.Clear;
  for i := 0 to Sheets.Count - 1 do begin
    s:=Sheets[i];
    j:=Pos(constSheetFieldSeparator, s);
    if j>0 then
      sl.AddObject(Copy(s,1,j-1), TObject(i) );
  end;
end;

procedure TpsPrinter.FontHeight(Value: Double);
begin
  FFont.Height := ConvertHeight(Value);
end;

constructor TpsPrintParamsFmt.Create(AOwner: TComponent);
begin
  inherited;
  psPrinter := nil;
end;

procedure TpsPrintParamsFmt.DBGridCellClick(Column: TColumn);
begin
  UpdateLblPaperSize;
end;

destructor TpsPrintParamsFmt.Destroy;
begin
  inherited;
end;



procedure TpsPrintParamsFmt.e1Change(Sender: TObject);
begin
  PreviewBox.Update;
end;

procedure TpsPrintParamsFmt.ED_TitleChange(Sender: TObject);
begin
  psPrinter.PaperParams.DocumentTitle  := ED_TITLE.Text;
  lblDocumentTitle.Caption := ED_TITLE.Text;
end;

procedure TpsPrintParamsFmt.ListBox1DblClick(Sender: TObject);
begin
  ShowMessage('Papers');
  TpsPrinter.GetPaperNames(ListBox1.Items);

end;

procedure TpsPrintParamsFmt.LoadPrinterParams;
begin
  with psPrinter.PaperParams do begin
    CB_Units.ItemIndex := Integer(Units);
    ED_Width.Text      := Format('%7.2f',[LabelWidth]);
    ED_Height.Text     := Format('%7.2f',[LabelHeight]);
    ED_Left.Text       := Format('%7.2f',[MarginLeft]);
    ED_Top.Text        := Format('%7.2f',[MarginTop]);
    ED_Right.Text      := Format('%7.2f',[MarginRight]);
    ED_Bottom.Text     := Format('%7.2f',[MarginBottom]);
    ED_SpaceX.Text     := Format('%7.2f',[SpaceX]);
    ED_SpaceY.Text     := Format('%7.2f',[SpaceY]);
  end;
end;

procedure TpsPrintParamsFmt.LoadSheets(fn:TFileName; tv: TTreeView);
var ini         : TIniFile;
    sl, section : TStringList;
    i,j         : Integer;
    tn          : TTreeNode;
    node_name{, node_value }: string;
begin
  if fn='' then
      if OD.Execute then
        fn:=OD.FileName;
  if fn='' then Exit;

  { TODO : Dokoncit tlac }

  ini:=TIniFile.Create(fn);
  try
    sl := TStringList.Create;
    try
        tv.Items.BeginUpdate;
        tv.Items.Clear;
        ini.ReadSections(sl);
        for I := 0 to sl.Count - 1 do begin
            tn:=tv.Items.Add(nil, sl.Strings[i]);
            section:=TStringList.Create;
            try
                ini.ReadSectionValues(sl.Strings[i], section);
                for j := 0 to section.Count - 1 do begin
                    node_name := section.Names[j];
                    if UpperCase(node_name)<>'PAPER' then
                        tv.Items.AddChild(tn, node_name)
                    else
                      ;
                end;
            finally
                section.Free;
            end;
        end;
    finally
        sl.Free;
        tv.Items.EndUpdate;
    end;
  finally
    ini.Free;
  end;
end;

procedure TpsPaperParams.BackupParams;
begin
  FParamsBackup:=FParams;
end;

procedure TpsPaperParams.ChangeUnits(NewUnits: TpsUnits);
begin
  psChangeUnits(NewUnits,FParams);
end;

constructor TpsPaperParams.Create;
begin
  inherited;
  UpdatePrinterParams;
  SetDefaults;
end;

function TpsPaperParams.GetNonPrintableHorz: Double;
begin
  Result := PixelsHorzToCurrUnit(FParams.FOffsetX);
end;

function TpsPaperParams.GetNonPrintableVert: Double;
begin
  Result := PixelsVertToCurrUnit(FParams.FOffsetY);
end;

function TpsPaperParams.GetPaperHeight: Double;
begin
  case Units of
    buMilimetres  :
        Result := FParams.mm10Height/10;
      // Result := 25.4*FParams.pPaperHeight/FParams.FDpiY;
    buInches      :
        Result := FParams.mm10Width/10/25.4;
      // Result := FParams.pPaperHeight/FParams.FDpiY;
    else            Result := FParams.pPaperHeight;
  end;
end;

function TpsPrinter.GetAbout: String;
begin
  Result := FBarcodeObject.About;
end;

class procedure TpsPrinter.GetPaperNames(sl:TStrings);
type
  TPaperName      = array [0..63] of Char;
  TPaperNameArray = array [1..High(Word) div SizeOf(TPaperName)] of TPaperName;
  PPapernameArray = ^TPaperNameArray;
var
  Device, Driver, Port: array [0..255] of Char;
  hDevMode: THandle;
  i, numPaperformats: Integer;
  pPaperFormats: PPapernameArray;
  FDeviceMode: PDevMode;
begin
  Printer.PrinterIndex := -1; // Standard printer
  Printer.GetPrinter(Device, Driver, Port, hDevmode);

  FDeviceMode := Ptr(hDevMode);
  ShowMessage( Format('Paper Size : %d', [FDeviceMode^.dmPaperSize]));

  numPaperformats := DeviceCapabilities(Device, Port, DC_PAPERNAMES, nil, nil);
  if numPaperformats>0 then
  begin
    GetMem(pPaperformats, numPaperformats * SizeOf(TPapername));
    try
      DeviceCapabilities(Device, Port, DC_PAPERNAMES,
        PChar(pPaperFormats), nil);
      sl.Clear;
      for i := 1 to numPaperformats do sl.Add(pPaperformats^[i]);
    finally
      FreeMem(pPaperformats);
    end;
  end;
end;



{type
  TPointArray = array[0..8191] of TPoint;
  PPointArray = ^TPointArray;
var
  i: integer;
  Buffer: array[0..65535] of byte;
  PrinterName: PChar;
  PaperCount: integer;
  PaperSizeArray: PPointArray;
  PaperNames: array of string;
  PaperSizes: array of TPoint;
  Papers: array of SHORT;

  with Printer do begin
    PrinterName := PChar(Printers[PrinterIndex]);
    PaperCount := DeviceCapabilities(PrinterName, '',
      DC_PAPERNAMES, @Buffer, nil);
    SetLength(PaperNames, PaperCount);
    SetLength(PaperSizes, PaperCount);
    SetLength(Papers, PaperCount);
    for i := 0 to PaperCount - 1 do
      PaperNames[I] := PChar(@Buffer[I * 64]);
    DeviceCapabilities(PrinterName, '',
      DC_PAPERSIZE, @Buffer, nil);
    PaperSizeArray := @Buffer;
    for i := 0 to PaperCount - 1 do
      PaperSizes[I] := PaperSizeArray^[I];
    DeviceCapabilities(PrinterName, '', DC_PAPERS, @Buffer, nil);
    for i := 0 to PaperCount - 1 do
      Papers[I] := PWordArray(@Buffer)^[I];
  end;
}

function TpsPaperParams.GetPaperWidth: Double;
begin
  case Units of
    buMilimetres  :
        Result := FParams.mm10Width/10;
        // Result := 25.4*FParams.pPaperWidth/FParams.FDpiX;
    buInches      :
        Result := (FParams.mm10Width/10)/25.4;
        // Result := FParams.pPaperWidth/FParams.FDpiX;
    else            Result := FParams.pPaperWidth;
  end;
end;

function TpsPaperParams.NextLabel(var pR: TpsPrintRect): Boolean;
begin
  Result := False;
  pR.Left := pR.Left + LabelWidth+SpaceX;
  if pR.Left+LabelWidth>PaperWidth-MarginRight then begin
      pR.Left := MarginLeft;
      pR.Top  := pr.Top + LabelHeight+SpaceY;
  end;
  if pR.Top+LabelHeight>PaperHeight-MarginBottom then begin
    pR.Left   := MarginLeft;
    pR.Top    := MarginTop;
    Result := True;
  end;
end;

procedure TpsPaperParams.RestoreParams;
begin
  FParams := FParamsBackup;
end;

function TpsPrinter.IsDataAware: Boolean;
begin
  Result:=DataSource<>nil;
end;

class function TpsPrinter.IsPrinterInstalled: Boolean;
begin
  Result := (Printer.Printers.Count > 0);
end;

function TpsPrinter.PagesCountString: String;
begin
  Result := Format('%d / %d',[FPageIndex, PagesCount])
end;

procedure TpsPrinter.PageSetup;
var ps:TPageSetupDialog;
begin
    ps := TPageSetupDialog.Create(Application);
    try
      if ps.Execute then begin
        PaperParams.UpdatePrinterParams;
      end;
    finally
      ps.Free;
    end;
end;

function TpsPaperParams.PaperFormat: String;
begin
  case units of
    buMilimetres :     Result := Format('%3.0fx%3.0f mm',
      [PaperWidth, PaperHeight]);
    buInches     :     Result := Format('%5.2fx%5.2f "',
      [PaperWidth, PaperHeight]);
  end;
  if Length(PaperName)>0 then
    Result:=PaperName+' : '+Result;
end;

function TpsPaperParams.PixelsHorzToCurrUnit(X: Integer): Double;
begin
  Result := X;
  case FParams.FUnits of
    buMilimetres : Result:= 25.4 * X/FParams.FDpiX;
    buInches     : Result:= X/FParams.FDpiX;
  end;
end;

function TpsPaperParams.PixelsVertToCurrUnit(Y: Integer): Double;
begin
  Result := Y;
  case FParams.FUnits of
    buMilimetres : Result:= 25.4 * Y/FParams.FDpiY;
    buInches     : Result:= Y/FParams.FDpiY;
  end;
end;

procedure TpsPrinter.Print;
var pR       : TpsPrintRect;
    R        : TRect;
    i        : Integer;
    bcTemp   : TpsBarcodeComponent;
//    NextMode : TpsPrintNextMode;
    BI       : TpsBarcodeInfo;
    EndLoop  : Boolean;
    CanPrint : Boolean;
    bc       : TpsBarcodeComponent;
    w,h      : Integer;
    npX, npY : Double;
    prg      : TForm;

    lblPosition : TLabel;
    pb          : TProgressBar;
    btnStop     : TBitBtn;

    function ConvertToPixels:TRect;
    var pw,ph:Double;
    begin
        pw := PaperParams.PaperWidth;
        ph := PaperParams.PaperHeight;
        if (pw=0) or (ph=0) then Result := Rect(0,0,0,0)
        else begin
          Result.Left   := Trunc(w*(pR.Left - npX )/pw);
          Result.Right  := Trunc(w*(pR.Right - npX )/pw);
          Result.Top    := Trunc(h*(pR.Top   - npY )/ph);
          Result.Bottom := Trunc(h*(pR.Bottom- npY )/ph);
        end;
    end;
    procedure UpdateProgress;
    begin
      if ShowProgress then begin
          lblPosition.Caption := Format('Page %d of %d',[PageIndex, PagesCount]);
          pb.Position  := PageIndex;
      end;
      if Assigned(FOnProgress) then
          FOnProgress(Self, PageIndex, PagesCount);
    end;
begin
  bc          := FBarcodeObject;
  EndLoop     := False;
  FAbortPrint := False;
  FPageIndex  := 1;
  prg         := nil;

  try
     if ShowProgress then begin
        prg := TForm.Create(Application);
        // create progress window
        prg.BorderStyle := bsSingle;
        prg.BorderIcons := [];
        prg.FormStyle   := fsStayOnTop;
        prg.Position    := poScreenCenter;
        prg.Width       := 300;
        prg.Height      := 150;
        prg.Caption     := Format(rsPrintProgressWindowCaption,[PaperParams.DocumentTitle]);
        // progress bar
        pb            := TProgressBar.Create(prg);
        pb.Parent     := prg;
        pb.BoundsRect := Rect(20,20,260,40);
        pb.min        := 0;
        pb.max        := PagesCount;

        // label with currently printed page index
        lblPosition := TLabel.Create(prg);
        lblPosition.Parent    := prg;
        lblPosition.AutoSize  := False;
        lblPosition.Alignment := taCenter;
        lblPosition.BoundsRect := Rect(20,50,260,70);

        // stop button
        btnStop:=TBitBtn.Create(prg);
        btnStop.Parent     := prg;
        btnStop.BoundsRect := Rect(20,80,260,110);
        btnStop.Kind       := bkCancel;
        btnStop.OnClick    := psAbortPrint;
        prg.Show;
    end
    else
      if not Assigned(FOnProgress) then
        Screen.Cursor := crHourGlass;


    Printer.Title := PaperParams.DocumentTitle;
    with PaperParams do begin
        FCurrRect     := Rect(0,0,pPaperWidth,pPaperHeight);
        FCurrCanvas   := Printer.Canvas;
     
        w   := WidthOf(FCurrRect);
        h   := HeightOf(FCurrRect);

        npX := PaperParams.NonPrintableHorz;
        npY := PaperParams.NonPrintableVert;
     
        case PaperParams.Style of
          psSingle    : FCount :=1 ;
          psSheet,
          psSheetInc  : ;
          // psSheetSymbologies: ;
        end;
     
        Printer.BeginDoc;
        try
          UpdateProgress;
          DoReportHeader;
          DoPageHeader;
          bcTemp := TpsBarcodeComponent.Create(nil);
          try
            if Assigned(bc) then begin
                bcTemp.Assign(bc);
                bcTemp.Options := bcTemp.Options -[boSecurity];
            end;
            if PaperParams.Style=psSheetSymbologies then
              bcTemp.BarcodeSymbology := Low(TpsBarcodeSymbology);
     
            pR.Left   := MarginLeft;
            pR.Top    := MarginTop;
            FPrintPageIndex  := 0;
            FPrintPagesCount := PagesCount;
            DoPageHeader;
     
            i := 1 - FStartFrom;
            while (i<=FCount) and not EndLoop do begin
                  Application.ProcessMessages;
                  if FAbortPrint then Break;
     
                  if i>0 then begin
                    pR.Right  := pR.Left+LabelWidth;
                    pr.Bottom := pR.Top+LabelHeight;
                    R := ConvertToPixels;
                    CanPrint:=True;
                    if Assigned(FOnBeforePrint) then
                      FOnBeforePrint(Self, bc, pR, CanPrint, EndLoop);
                    if CanPrint then
                      PaintBarcode(Printer.Canvas, R, bcTemp);
                    if EndLoop then Continue;
     
                    if Assigned(FOnAfterPrint) then
                      FOnAfterPrint(Self, bc, pR, CanPrint, EndLoop);
                    if EndLoop then Continue;
     
                    if Style=psSheetSymbologies then begin
     
                    end;
     
                  end;
     
                  pR.Left := pR.Left + LabelWidth+SpaceX;
                  if pR.Left+LabelWidth>PaperWidth-MarginRight then
                  begin
                    pR.Left := MarginLeft;
                    pR.Top  := pr.Top + LabelHeight+SpaceY;
                  end;
                  if pR.Top+LabelHeight>PaperHeight-MarginBottom then
                  begin
                    DoPageFooter;
                    Printer.NewPage;
                    Inc(FPageIndex);
                    DoPageHeader;
                    UpdateProgress;
                    pR.Left   := MarginLeft;
                    pR.Top    := MarginTop;
                  end;
     
                  Inc(i);
     
                  if Style=psSheetSymbologies then begin
                    if bcTemp.BarcodeSymbology=High(TpsBarcodeSymbology) then
                      EndLoop :=True
                    else begin
                      bcTemp.BarcodeSymbology  := Succ(bcTemp.BarcodeSymbology);
                      BI := BarcodeInfo(bcTemp.BarcodeSymbology);
                      bcTemp.CaptionUpper.Text.Text := BI.Name;
                    end;
                  end;
            end;
          finally
            bcTemp.Free;
          end;
        finally
          if FAbortPrint then
              Printer.Abort;
          if not Printer.Aborted then begin
              DoPageFooter;
              DoReportFooter;
              Printer.EndDoc;
          end;
        end;
    end;  // end with PaperParams
  finally
    Screen.Cursor := crDefault;
    if Assigned(prg) then
      prg.Free;
  end;
end;

class function TpsPrinter.PrinterName: String;
begin
  if Printer.PrinterIndex>=0 then begin
    Result := Printer.Printers[Printer.PrinterIndex]
  end else
    Result := rsPrinterNotSelected;
end;

procedure TpsPrinter.PrinterSetup;
begin
      if psPrinterSetup then
        PaperParams.UpdatePrinterParams;
end;

procedure TpsPrinter.psAbortPrint(Sender: TObject);
begin
  FAbortPrint :=
    (MessageDlg(rsPrintStop,mtInformation, [mbYes,mbNo], 0)= mrYes);
end;

procedure TpsPrinter.psNextBarcode(bc: TpsBarcodeComponent);
var dDataSet:TDataSet;
begin
  case PaperParams.Style of
    psSingle, psSheet   : ;
    psSheetInc          : ;
    psSheetSymbologies  : ;
    psTableData         : begin
        dDataSet := DataSet;
        if Assigned(dDataSet) then
              dDataSet.Next;
      end;
    psSelectedRows : ;
  end;
end;

procedure TpsPrinter.SetDefaults;
begin
  FCount         := 5;
  FStartFrom     := 0;
  FPageIndex     := 1;
  PaperParams.SetDefaults;
end;

procedure TpsPaperParams.SetDefaults;
begin
  Units         := buMilimetres;
  Style         := psSheet;
  LabelWidth    := 50;
  LabelHeight   := 30;
  MarginLeft    := 15;
  MarginTop     := 20;
  MarginRight   := 20;
  MarginBottom  := 20;
  SpaceX        := 010;
  SpaceY        := 10;
  DocumentTitle := 'PSOFT Barcode studio sheet';
  UpdatePrinterParams;
end;

procedure TpsPrinter.SetBarcodeObject(const Value: TpsBarcodeComponent);
begin
    FBarcodeObject := Value;
    // SetDataSource(FBarcodeObject);
end;

procedure TpsPrinter.SetCount(const Value: Integer);
begin
  FCount:=Value;
end;

procedure TpsPrinter.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TpsPrinter.SetHelpProp(C: TControl);
begin
  C.HelpContext := HelpContext;
  C.HelpKeyWord := HelpKeyWord;
  C.HelpType    := HelpType;
end;

procedure TpsPrinter.SetPaperParams(const Value: TpsPaperParams);
begin
  FPaperParams.Assign(Value);
end;

procedure TpsPrinter.SetPreviewParams(const Value: TpsPrinterPreview);
begin
  FPreviewParams.Assign(Value);
end;

procedure TpsPrinter.SetSheets(const Value: TStringList);
begin
  FSheets.Assign(Value);
end;

procedure TpsPrinter.SheetsSelect(idx: Integer);
var i     : Integer;
    s, Sn : String;
    function GetValue:string;
    begin
        i:= Pos(constSheetFieldSeparator, s);
        if i>0 then begin
            Result := Copy(s,1,i-1);
            s      := Copy(s,i+1,Length(s)-i);
        end else begin
            Result := s;
            s      := '';
        end;
    end;
begin
  if (idx<0) or (idx>=FSheets.Count) then Exit;
  s  := FSheets[idx];
  if Length(s)=0 then Exit;

  sn := GetValue;
  PaperParams.LabelWidth  := StrToFloatDef(GetValue, 0);
  PaperParams.LabelHeight := StrToFloatDef(GetValue, 0);
  PaperParams.MarginLeft  := StrToFloatDef(GetValue, 0);
  PaperParams.MarginTop   := StrToFloatDef(GetValue, 0);
  PaperParams.MarginRight := StrToFloatDef(GetValue, 0);
  PaperParams.MarginBottom:= StrToFloatDef(GetValue, 0);
  PaperParams.SpaceX      := StrToFloatDef(GetValue, 0);
  PaperParams.SpaceY      := StrToFloatDef(GetValue, 0);
end;


procedure TpsPaperParams.SetUnits(const Value: TpsUnits);
begin
  ChangeUnits(Value);
end;

procedure TpsPrinter.TextOut(Left, Top: Double; Text: String);
var p:TPoint;
begin
  P:=ConvertPoint(Left,Top);
  SetBkMode(FCurrCanvas.Handle,TRANSPARENT);
  FCurrCanvas.TextOut(P.X, P.Y, Text);
end;

{ TpsPrinterPreview }

constructor TpsPrinterPreview.Create;
begin
  inherited;
  FPaperColor   := clWhite;
  FShadowColor  := clSilver;
  FLabelColor   := clMoneyGreen;
  FLive         := True;
  FShadowWidth  := 5;
  FVisiblePage  := True;
end;

destructor TpsPrinterPreview.Destroy;
begin
  inherited;
end;


function psPrinterSetup:Boolean;
begin
    with TPrinterSetupDialog.Create(Application) do
    try
      Result := Execute;
    finally
      Free;
    end;
end;

end.
