unit psBarcodeFmt;

interface

{$I psBarcode.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Printers,
  psBarcodeComp, psBarcode, psCodeSpecs, psTypes, psCodeRes, psCodeFNLite, psCodeFN,
  {$ifdef PSOFT_PROF}       psCodeProf,     {$endif}
  {$ifdef PSOFT_STUDIO}     psCodeStudio,   {$endif}
  {$ifdef PSOFT_BARCODE_DB} psReportCanvas, {$endif}
  psBoxes, ComCtrls, ImgList, CheckLst;

const MAX_CB = 50;

type

  TpsBarcodeEditorFmt = class(TForm,IpsBarcodeEditor)
    FD: TFontDialog;
    CO: TColorDialog;
    SD: TSaveDialog;
    Panel1: TPanel;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    OD: TOpenDialog;
    Tree: TTreeView;
    Splitter2: TSplitter;
    Panel3: TPanel;
    ZAL: TPageControl;
    SH_MAIN: TTabSheet;
    ZNAKY: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    EANMEMO: TMemo;
    RG_Angle: TRadioGroup;
    SH_COLORS_FONTS: TTabSheet;
    Label4: TLabel;
    Label5: TLabel;
    lblFontSample: TLabel;
    Label6: TLabel;
    Label41: TLabel;
    btnFont: TBitBtn;
    bgColor: TColorBox;
    LinesColor: TColorBox;
    SH_CAPTIONS: TTabSheet;
    Label44: TLabel;
    RG_CAPTION: TRadioGroup;
    Group_Caption: TGroupBox;
    L4: TLabel;
    L2: TLabel;
    CA_FontSample: TLabel;
    Label15: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    CA_Alignment: TComboBox;
    CA_FONT: TBitBtn;
    CA_MaxHeight: TEdit;
    CA_TEXT: TMemo;
    UpDown1: TUpDown;
    CA_AutoCaption: TCheckBox;
    CA_AutoSize: TCheckBox;
    CA_Parentfont: TCheckBox;
    CA_Visible: TCheckBox;
    SH_OPTIONS: TTabSheet;
    Label8: TLabel;
    Label45: TLabel;
    CL_Options: TCheckListBox;
    SH_QUIETZONE: TTabSheet;
    Label46: TLabel;
    QZ_VISIBLE: TCheckBox;
    PNL_QZ: TPanel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    QZ_LEFT: TEdit;
    QZ_RIGHT: TEdit;
    QZ_TOP: TEdit;
    QZ_BOTTOM: TEdit;
    QZ_STYLE: TComboBox;
    QZ_SIZE: TEdit;
    QZ_PENWIDTH: TEdit;
    QZ_PENCOLOR: TColorBox;
    SH_PARAMS: TTabSheet;
    Label40: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label48: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    ED_SegmentIndex: TEdit;
    ED_SegmentCount: TEdit;
    ED_ECI: TEdit;
    CB_FNC1_InputType: TComboBox;
    CB_FNC1_Type: TComboBox;
    SH_PDF417: TTabSheet;
    Label9: TLabel;
    Label10: TLabel;
    PDF_COLSlbl: TLabel;
    PDF_ROWSlbl: TLabel;
    Label47: TLabel;
    PDF_ErrorLevel: TComboBox;
    PDF_MODE: TComboBox;
    PDF_COLS: TEdit;
    PDF_ROWS: TEdit;
    PDF_TRUNCATED: TCheckBox;
    GroupBox2: TGroupBox;
    Label16: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label36: TLabel;
    Label39: TLabel;
    Label68: TLabel;
    PDF417_ADDR: TEdit;
    PDF417_SENDER: TEdit;
    PDF417_TIMESTAMP: TEdit;
    PDF417_CHECKSUM: TEdit;
    PDF417_FileName: TEdit;
    PDF417_MACRO: TCheckBox;
    SH_QRCODE: TTabSheet;
    Label50: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    CB_QR_ECL: TComboBox;
    CB_QR_MODE: TComboBox;
    CB_QR_VERSION: TComboBox;
    CB_QR_MICRO: TCheckBox;
    SH_DATAMATRIX: TTabSheet;
    Label51: TLabel;
    SH_AZTEC: TTabSheet;
    Label61: TLabel;
    SHEET_PRINT: TTabSheet;
    Label11: TLabel;
    Label12: TLabel;
    Label17: TLabel;
    Label20: TLabel;
    GroupBox1: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    LBL_FORMAT: TLabel;
    E_LEFT: TEdit;
    E_TOP: TEdit;
    E_SPACEX: TEdit;
    E_SPACEY: TEdit;
    E_WIDTH: TEdit;
    E_HEIGHT: TEdit;
    E_COUNT: TEdit;
    BitBtn1: TBitBtn;
    E_NEXT: TCheckBox;
    E_UNITS: TComboBox;
    SH_COPYRIGHT: TTabSheet;
    Image2: TImage;
    Memo1: TMemo;
    SH_FUNCTIONS: TTabSheet;
    Label49: TLabel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    SH_PRINT: TTabSheet;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    Splitter1: TSplitter;
    Label72: TLabel;
    Version: TLabel;
    CB_DM_ENCODING: TComboBox;
    CB_DM_VERSION: TComboBox;
    EAN: TpsBarcode;
    cbTyp: TpsComboBox;
    procedure PropChange(Sender: TObject);
    procedure BtnApplyClick(Sender: TObject);

    procedure E_WIDTHChange(Sender: TObject);

    procedure EditFont(F:TFont; SampleLabel:TLabel);
    procedure TreeChange(Sender: TObject; Node: TTreeNode);
    procedure BitBtn12Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ZALChange(Sender: TObject);
  private
    ParentEAN   : TpsBarcodeComponent;
    InChange    : Boolean;
    FUsedPages  : TpsEditorPages;
    { TODO : Dorobit, aby sa nedalo rekurzivne klinut v editor okne na barcode }
    // FOrigEnabledEditor : Boolean;
    function  GetBarcodeOptions : TpsBarcodeOptions;
    procedure UpdateTree;
    procedure UpdateVisibility;
    procedure UpdateOneCaptionControls(C:TpsBarcodeCaption);
  public
    procedure Edit(bc:TObject);
    procedure Print(bc:TObject);
    procedure EditPage(bc:TObject; pages:TpsEditorPages);

    procedure UpdateParentBarcode;
    procedure SetParentEAN(E:TpsBarcodeComponent);
    procedure SetActivePage(Page:TpsEditorPage);
    procedure UpdateLabel;
  end;

  TpsBarcodeAbout=class(TComponent)
  private
    FParentBarcode : TpsBarcodeComponent;
    FEnabledPages  : TpsEditorPages;
    FFormTop       : Integer;
    FFormLeft      : Integer;
    FFormPosition  : TPosition;
    FFormCaption   : String;
    function GetEdition: String;
    function GetProductName: String;
    function GetVersion: String;
  protected
  public
    constructor Create(AOwner:TComponent); override;
    class procedure Execute; virtual;

    function  GetEditWindowClass:TCustomFormClass; virtual;
    procedure UpdateControls(F:TCustomForm; B:TpsBarcodeComponent; Page:TpsEditorPage); virtual;
    procedure UpdateBarcode(F:TCustomForm; B:TpsBarcodeComponent);  virtual;
    function  EditBarcode(B:TpsBarcodeComponent):Boolean; virtual;
    function  EditBarcodePage(B:TpsBarcodeComponent; Page:TpsEditorPage):Boolean; virtual;
  published
    property  Edition:String read GetEdition stored False;
    property  Version:String read GetVersion stored False;
    property  ProductName:String read GetProductName stored False;

    property  FormCaption:String read FFormCaption write FFormCaption;
    property  EnabledPages:TpsEditorPages read FEnabledPages write FEnabledPages;
    property  FormLeft:Integer read FFormLeft write FFormLeft;
    property  FormTop:Integer read FFormTop write FFormTop;
    property  FormPosition:TPosition read FFormPosition write FFormPosition;
  end;

  function EditBarcode(BarcodeComponent : TPersistent):Boolean;
  function EditBarcodePages(BarcodeComponent:TPersistent; Pages:TpsEditorPages):Boolean;
  function PrintDialog(BarcodeComponent : TPersistent):Boolean;

implementation

{$R *.DFM}

procedure TpsBarcodeEditorFmt.PropChange(Sender: TObject);
var C:TpsBarcodeCaption;
begin
  if InChange then
      Exit;

  InChange :=True;
  try
    case RG_CAPTION.ItemIndex of
      0 : C := EAN.CaptionUpper;
      1 : C := EAN.CaptionHuman;
      2 : C := EAN.CaptionBottom;
      else C := nil;
    end;

    if Sender=cbTyp then begin
       EAN.BarcodeSymbology := cbTyp.SelectedSymbology;
       // EAN.Width      := EAN.MinWidth;
       EanMemo.Text   := Ean.BarCode;
       ZNAKY.Caption  := EAN.GetSetOfCharsVisible;
       UpdateVisibility;
    end;
    if Sender=EanMemo then begin
       EAN.BarCode := EanMemo.Text;
       EAN.Width   := EAN.MinWidth;
    end;

    if Sender=LinesColor then
        EAN.LinesColor   := LinesColor.Selected;
    if Sender=bgColor then
        EAN.BackgroundColor := bgColor.Selected;
    if Sender=btnFont  then
        EditFont(EAN.Font, lblFontSample);
    if Sender=RG_Angle then
        EAN.Angle := 90*RG_ANGLE.ItemIndex;
    if Sender=CL_Options then
        EAN.Options := GetBarcodeOptions;

    // captions
    if Sender=RG_Caption then
      case RG_Caption.ItemIndex of
        0: UpdateOneCaptionControls(EAN.CaptionUpper);
        1: UpdateOneCaptionControls(EAN.CaptionHuman);
        2: UpdateOneCaptionControls(EAN.CaptionBottom);
      end;

    // from sheet SH_QuietZone
    if Sender = QZ_VISIBLE then
        Ean.QuietZone.Visible:=QZ_Visible.Checked;
    if Sender=QZ_LEFT   then
        Ean.QuietZone.Left  :=StrToIntDef(QZ_LEFT.Text,0);
    if Sender=QZ_RIGHT  then
        Ean.QuietZone.Right :=StrToIntDef(QZ_RIGHT.Text,0);
    if Sender=QZ_TOP    then
        Ean.QuietZone.Top   :=StrToIntDef(QZ_TOP.Text,0);
    if Sender=QZ_BOTTOM then
        Ean.QuietZone.Bottom:=StrToIntDef(QZ_BOTTOM.Text,0);
    if Sender=QZ_Style  then
        Ean.QuietZone.Style := TpsQuietZoneIndicatorStyle(QZ_STYLE.ItemIndex);
    if Sender=QZ_SIZE   then
        Ean.QuietZone.IndicatorSize := StrToIntDef(QZ_SIZE.Text,0);
    if Sender=QZ_PENCOLOR then
        Ean.QuietZone.Pen.Color := QZ_PENCOLOR.Selected;
    if Sender=QZ_PENWIDTH then
        Ean.QuietZone.Pen.Width:=StrToIntDef(QZ_PENWIDTH.Text,0);

    if Assigned(C) then begin
      if Sender=CA_Visible      then begin
            C.Visible:=CA_Visible.Checked;
            Group_Caption.Visible := CA_Visible.Checked;
      end;
      if Sender=CA_AutoCaption  then
            C.AutoCaption:=CA_AutoCaption.Checked;
      if Sender=CA_AutoSize     then
            C.AutoSize:=CA_AutoSize.Checked;
      if Sender=CA_ParentFont   then
            C.ParentFont:=CA_ParentFont.Checked;
      if Sender=CA_TEXT         then
            C.Text.Text:= CA_TEXT.Text;
      if Sender=CA_MaxHeight    then
            C.MaxHeight := StrToIntDef(CA_MaxHeight.Text,0);
      if Sender=CA_FONT         then
            EditFont(C.Font, CA_FontSample);
      if Sender=CA_Alignment    then
            C.Alignment:= TAlignment(CA_Alignment.ItemIndex);
    end;


    {$ifdef PSOFT_PDF417}
      with Ean.Params do begin
        if Sender=PDF_ERRORLevel then
          PDF417.SecurityLevel   := TpsPDF417ErrorCorrection(PDF_ERRORLevel.ItemIndex);
        if Sender=PDF_MODE then
          PDF417.Mode := TpsPDF417Mode(PDF_MODE.ItemIndex);
        if Sender=PDF_Cols then
          PDF417.Cols := StrToIntDef(PDF_COLS.Text, 5);
        if Sender=PDF_ROWS then
          PDF417.Rows := StrToIntDef(PDF_ROWS.Text, 0);
        if Sender=PDF_TRUNCATED then begin
          if PDF_TRUNCATED.Checked then
            PDF417.Kind := pkTruncated
          else
            PDF417.Kind := pkStandard;
        end;

        // macro block
        if Sender=PDF417_Macro then
            PDF417.UseMacro := PDF417_Macro.Checked;
        if Sender=PDF417_Filename then
            PDF417.FileName := PDF417_Filename.Text;
        if Sender=PDF417_CHECKSUM then
            PDF417.Checksum := StrToIntDef(PDF417_CHECKSUM.Text,0);
        if Sender=PDF417_ADDR then
            PDF417.Addresse := PDF417_ADDR.Text;
        if Sender=PDF417_SENDER then
            PDF417.Sender:= PDF417_SENDER.Text;
        if Sender=PDF417_TIMESTAMP then
            PDF417.TimeStamp := StrToIntDef(PDF417_TIMESTAMP.Text,0);
      end;
    {$endif}   // end PDF417

    {$ifdef PSOFT_PROF}
        // sheet SH_PARAMS
        with ParentEAN.Params do begin
            if Sender=ED_SegmentIndex then
                SegmentIndex := StrToIntDef(ED_SegmentIndex.Text, SegmentIndex);
            if Sender=ED_SegmentCount then
                SegmentCount := StrToIntDef(ED_SegmentCount.Text, SegmentCount);
            if Sender=ED_ECI then
                ECI := StrToIntDef(ED_ECI.Text, ECI);
           { if Sender=CB_GS1 then
                FNC1_Type := CB_GS1.Checked;
            if Sender=CB_GS1_InputType then
                GS1InputType := TpsGS1InputType(CB_GS1_InputType.ItemIndex);
                }
        end;
    {$endif}

    {$ifdef PSOFT_STUDIO}
        // QR code
        with EAN.Params.QRCode do begin
            if Sender=CB_QR_ECL then
                EccLevel := TpsQrEccLevel(CB_QR_ECL.ItemIndex);
            if Sender=CB_QR_MODE then
                Mode     := TpsQrMode(CB_QR_MODE.ItemIndex);
            if Sender=CB_QR_VERSION then
                Version  := CB_QR_VERSION.ItemIndex;
            if Sender=CB_QR_MICRO then
                MicroQR  := CB_QR_MICRO.Checked;
        end;
        // DataMatrix
        with EAN.Params.DataMatrix do begin
            if Sender=CB_DM_ENCODING then
                Encoding := TpsDataMatrixEncoding(CB_DM_ENCODING.ItemIndex);
            if Sender=CB_DM_VERSION then
                Version  := TpsDataMatrixVersion(CB_DM_VERSION.ItemIndex);
        end;
    {$endif}
  finally
      InChange := False;
  end;
end;

function TpsBarcodeEditorFmt.GetBarcodeOptions: TpsBarcodeOptions;
var O:TpsBarcodeOptions;
    procedure SetOption(opt:TpsBarcodeOption; En:Boolean);
    begin
      if En then Include(O,opt)
      else       Exclude(O,opt);
    end;
begin
    O := [];
    SetOption(boTransparent,        CL_OPTIONS.Checked[0]);
    SetOption(boSecurity,           CL_OPTIONS.Checked[1]);
    SetOption(boStartStopLines,     CL_OPTIONS.Checked[2]);
    SetOption(boAddOnUp,            CL_OPTIONS.Checked[3]);
    SetOption(boEnableEditor,       CL_OPTIONS.Checked[4]);
    SetOption(boAutoSize,           CL_OPTIONS.Checked[5]);
    SetOption(boAutoHint,           CL_OPTIONS.Checked[6]);
    SetOption(boAutoCheckDigit,     CL_OPTIONS.Checked[7]);
    SetOption(boEditorAfterCreate,  CL_OPTIONS.Checked[8]);
    SetOption(boFlipVertical,       CL_OPTIONS.Checked[9]);
    SetOption(boFlipHorizontal,     CL_OPTIONS.Checked[10]);
    SetOption(boReflectanceReversal,CL_OPTIONS.Checked[11]);
    SetOption(boPaintIfSmall,       CL_OPTIONS.Checked[12]);
    SetOption(boAddLeadingZero,     CL_OPTIONS.Checked[13]);
    Result := O;
end;

procedure TpsBarcodeEditorFmt.SetActivePage(Page: TpsEditorPage);
begin
  case Page of
    epQuietZone     : ZAL.ActivePage := SH_QUIETZONE;
    epPDF417        : ZAL.ActivePage := SH_PDF417;
    epPrint         : ;
    epCaptionUpper  : begin ZAL.ActivePage := SH_CAPTIONS; RG_CAPTION.ItemIndex:=0; end;
    epCaptionHuman  : begin ZAL.ActivePage := SH_CAPTIONS; RG_CAPTION.ItemIndex:=1; end;
    epCaptionBottom : begin ZAL.ActivePage := SH_CAPTIONS; RG_CAPTION.ItemIndex:=2; end;
    epOptions       : ZAL.ActivePage := SH_OPTIONS;
    epParams        : ZAL.ActivePage := SH_PARAMS;
    epSpecial       : ;
    epFunctions     : ;
    else ZAL.ActivePage := SH_MAIN;
  end;
end;


procedure TpsBarcodeEditorFmt.Edit(bc:TObject);
begin
  EditPage(bc,[]);
end;

procedure TpsBarcodeEditorFmt.Print(bc:TObject);
begin
  EditPage(bc, [epPrint]);
end;

procedure TpsBarcodeEditorFmt.EditPage(bc:TObject; pages:TpsEditorPages);
var
  I   : Integer;
  cnt : Integer;
begin
    if pages=[] then
        pages := [Low(TpsEditorPage)..High(TpsEditorPage)];

    FUsedPages := pages;

    SH_MAIN.TabVisible      := epMain in pages;
    SH_QUIETZONE.TabVisible := epQuietZone in pages;
    SH_PRINT.TabVisible     := False; //epPrint in pages;
    SH_FUNCTIONS.TabVisible := False; //epFunctions  in pages;

    SH_CAPTIONS.TabVisible  :=
          ([epCaptionUpper, epCaptionHuman, epCaptionBottom] * pages)<>[];
    if SH_CAPTIONS.TabVisible then begin
//        if epCaptionUpper in  pages then
//            RG_CAPTION.ItemIndex := 0;
//        else
//          if epCaptionHuman in  pages then
//              RG_CAPTION.ItemIndex := 1
//          else
//              RG_CAPTION.ItemIndex := 2;
    end;

    SH_OPTIONS.TabVisible   := epOptions in pages;
    SH_PARAMS.TabVisible    := epParams in pages;
    // SH_SPECIAL.TabVisible   := epSpecial  in pages;


    SH_PDF417.TabVisible       := epPDF417 in pages;
    SH_DATAMATRIX.TabVisible   := epDataMatrix in pages;
    SH_QRCODE.TabVisible       := epQRCode in pages;
    SH_COLORS_FONTS.TabVisible := epColorsFont in pages;

    SetParentEAN(bc as TpsBarcodeComponent);
    ZAL.ActivePage := nil;
    Caption := Format('%s, %s (%s)',[constProductName,constProductVersion,rsPSOFTHomePage]);
    for I := 0 to ZAL.PageCount - 1 do
      if ZAL.Pages[i].TabVisible then begin
        ZAL.ActivePage := ZAL.Pages[i];
        Break;
      end;
    ZAL.TabIndex:=ZAL.TabIndex+1;
    ZAL.TabIndex:=ZAL.TabIndex-1;

    cnt := 0;
    for I := 0 to ZAL.PageCount - 1 do
        if ZAL.Pages[i].TabVisible then
            Inc(cnt);
    if cnt<=1 then begin
        Tree.Visible              := False;
        // ZAL.ActivePage.TabVisible := False;
    end;

end;

procedure TpsBarcodeEditorFmt.SetParentEAN(E:TpsBarcodeComponent);
var O  : TpsBarcodeOptions;
begin
  InChange := True;
  try
     // initTree;
     UpdateTree;

     EAN.BarcodeComponent.Assign(E);
     Ean.Visible  := True;
     Ean.Align    := alBottom;
     // ParentEAN.Assign(E);

     ParentEAN := E;
     CBTyp.SelectedSymbology := E.BarcodeSymbology;
     EanMemo.Text         := E.BarCode;
     Eanmemo.Visible      := true;
     BGColor.Selected     := E.BackgroundColor;
     LinesColor.Selected  := E.LinesColor;

     RG_ANGLE.ItemIndex := (E.Angle div 90) mod 4;

     O := E.Options;
     CL_OPTIONS.Checked[0] := boTransparent in O;
     CL_OPTIONS.Checked[1] := boSecurity in o;
     CL_OPTIONS.Checked[2] := boStartStopLines in O;
     CL_OPTIONS.Checked[3] := boAddOnUp in O;
     CL_OPTIONS.Checked[4] := boEnableEditor in O;
     CL_OPTIONS.Checked[5] := boAutoSize in O;
     CL_OPTIONS.Checked[6] := boAutoHint in O;
     CL_OPTIONS.Checked[7] := boAutoCheckDigit in O;
     CL_OPTIONS.Checked[8] := boEditorAfterCreate in O;
     CL_OPTIONS.Checked[9] := boFlipVertical in O;
     CL_OPTIONS.Checked[10]:= boFlipHorizontal in O;
     CL_OPTIONS.Checked[11]:= boReflectanceReversal in O;
     CL_OPTIONS.Checked[12]:= boPaintIfSmall in O;
     CL_OPTIONS.Checked[13]:= boAddLeadingZero in O;

     RG_CAPTION.ItemIndex := 0;
     UpdateOneCaptionControls(E.CaptionUpper);


{     CA_U_Visible.Checked      := E.CaptionUpper.Visible;
     CA_U_TEXT.Text            := E.CaptionUpper.Text;
     CA_U_ALIGNMENT.ItemIndex  := Integer(E.CaptionUpper.Alignment);
     CA_U_AutoCaption.Checked  := E.CaptionUpper.AutoCaption;
     CA_U_AutoSize.Checked     := E.CaptionUpper.AutoSize;
     CA_U_ParentFont.Checked  := E.CaptionUpper.ParentFont;
     CA_U_FontSample.Font.Assign(E.CaptionUpper.Font);
     CA_U_MaxHeight.Text := IntToStr(E.CaptionUpper.MaxHeight);
}

     {$ifdef PSOFT_PDF417}
        with E.Params do begin
            PDF_ERRORLevel.ItemIndex := Integer(PDF417.SecurityLevel);
            PDF_MODE.ItemIndex       := Integer(PDF417.Mode);
            PDF_COLS.Text            := IntToStr(PDF417.Cols);
            PDF_ROWS.Text            := IntToStr(PDF417.Rows);

            PDF417_Macro.Checked  := PDF417.UseMacro;
            PDF417_ADDR.Text      := PDF417.Addresse;
            PDF417_SENDER.Text    := PDF417.Sender;
            PDF417_FileName.Text  := PDF417.Filename;
            PDF417_Checksum.Text  := IntToStr(PDF417.Checksum);
            PDF417_TIMESTAMP.Text := DateTimeToStr(PDF417.TimeStamp);
        end;

     {$endif}

     {$ifdef PSOFT_PROF}
        // on SH_PARAMS
        ED_SegmentIndex.Text  := IntToStr(ParentEAN.Params.SegmentIndex);
        ED_SegmentCount.Text  := IntToStr(ParentEAN.Params.SegmentCount);
        ED_ECI.Text           := IntToStr(ParentEAN.Params.ECI);
        // CB_GS1.Checked        := ParentEAN.Params.GS1;
        // CB_GS1_InputType.ItemIndex := Integer(ParentEAN.Params.GS1InputType);
     {$endif}

     // QuietZone
     QZ_Visible.Checked := E.QuietZone.Visible;
     QZ_LEFT.Text      := IntToStr(E.QuietZone.Left);
     QZ_RIGHT.Text     := IntToStr(E.QuietZone.Right);
     QZ_TOP.Text       := IntToStr(E.QuietZone.Top);
     QZ_BOTTOM.Text    := IntToStr(E.QuietZone.Bottom);
     QZ_STYLE.ItemIndex:= Integer(E.QuietZone.Style);
     QZ_Size.Text      := IntToStr(E.QuietZone.IndicatorSize);

     QZ_PENCOLOR.Selected  := E.QuietZone.Pen.Color;
     QZ_PENWIDTH.Text      := IntToStr(E.QuietZone.Pen.Width);

    {$ifdef PSOFT_STUDIO}
        // QR code
        with EAN.Params.QRCode do begin
            CB_QR_ECL.ItemIndex     := Integer(EccLevel);
            CB_QR_MODE.ItemIndex    := Integer(Mode);
            CB_QR_VERSION.ItemIndex := Integer(Version);
            CB_QR_MICRO.Checked     := MicroQR;
        end;
        // DataMatrix
        with EAN.Params.DataMatrix do begin
                CB_DM_ENCODING.ItemIndex := Integer(Encoding);
                CB_DM_VERSION.ItemIndex  := Integer(Version);
        end;
    {$endif}

     EAN.BarcodeComponent.Assign(E);

     UpdateVisibility;
  finally
    InChange := False;
  end;
end;


procedure TpsBarcodeEditorFmt.TreeChange(Sender: TObject; Node: TTreeNode);
begin
//  if InChange then
//      Exit;

    ZAL.ActivePage := TTabSheet(Node.Data);
end;

procedure TpsBarcodeEditorFmt.UpdateParentBarcode;
{var i:Integer;
    s:String;
    C:TCheckBox;
    O:TpsBarcodeOptions;}
begin
     if ParentEAN=nil then Exit;

     ParentEAN.Assign(EAN.BarcodeComponent);
{
     O:=ParentEAN.Options;
     ParentEAN.BarcodeSymbology := CBTyp.SelectedSymbology;
     ParentEAN.BarCode          := EanMemo.Text;
     ParentEAN.Angle := RG_Angle.ItemIndex*90;

     ParentEAN.BackgroundColor  := BGColor.Selected;
     ParentEAN.LinesColor       := LinesColor.Selected;
     ParentEAN.Options          := GetBarcodeOptions;

     s:='';
     for i:=1 to MAX_CB do begin
         C:=TCheckBox(FindComponent('C'+IntToStr(i)));
         if C<>nil then begin
            if C.Checked then  s:=s+'_'
            else               s:=s+' ';
         end else
            s:=s+'_';
     end;
     ParentEAN.LabelMask := s;

     with ParentEAN.CaptionUpper do begin
          Visible     := CA_U_Visible.Checked;
          AutoCaption := CA_U_AutoCaption.Checked;
          AutoSize    := CA_U_AutoSize.Checked;
          Font.Assign(CA_U_FONT.FONT);
          Text        := CA_U_TEXT.Text;
          Alignment   := TAlignment(CA_U_ALIGNMENT.ItemIndex);
          MaxHeight   := StrToIntDef(CA_U_MaxHeight.Text,0);
          ParentFont  := CA_U_ParentFont.Checked;
     end;
{     with ParentEAN.CaptionBottom do begin
          Visible     := BCA_Visible.Checked;
          AutoCaption := BCA_AutoCaption.Checked;
          AutoSize    := BCA_AutoSize.Checked;
          Font.Assign(BCA_FONT.FONT);
          Text        := BCA_TEXT.Text;
          Alignment   := TAlignment(BCA_ALIGNMENT.ItemIndex);
     end;
}
//     ParentEan.QuietZone.Assign(Ean.QuietZone);

     {$ifdef PSOFT_PDF417}
{        with ParentEan.Params do begin
             PDF417.SecurityLevel   := psPDF417ErrorCorrection(PDF_ERRORLevel.ItemIndex);
             PDF417.Mode            := psPDF417Mode(PDF_MODE.ItemIndex);
             PDF417.Cols            := StrToIntDef(PDF_COLS.Text, 5);
             PDF417.Rows            := StrToIntDef(PDF_ROWS.Text, 0);

             PDF417.Addresse        := PDF417_ADDR.Text;
             PDF417.Checksum        := StrToIntDef(PDF417_CHECKSUM.Text,0);
             PDF417.Sender          := PDF417_SENDER.Text;
             PDF417.TimeStamp       := StrToIntDef(PDF417_TIMESTAMP.Text,0);
        end;
}
     {$endif}

     {$ifdef PSOFT_PROF}
{        ParentEAN.Params.FileName       := ED_Filename.Text;
        ParentEAN.Params.SegmentIndex   := StrToIntDef(ED_SegmentIndex.Text,0);
        ParentEAN.Params.SegmentCount   := StrToIntDef(ED_SegmentCount.Text,0);
        ParentEAN.Params.ECI            := StrToIntDef(ED_ECI.Text,0);
        ParentEAN.Params.GS1            := CB_GS1.Checked;
}     {$endif}




end;

procedure TpsBarcodeEditorFmt.UpdateTree;
var i : Integer;
    tn: TTreeNode;
    ts: TTabSheet;
    ca: String;
begin
     Tree.Items.BeginUpdate;
     Tree.Items.Clear;
     for i := 0 to ZAL.PageCount - 1 do begin
        ts                := ZAL.Pages[i];
        if not ts.TabVisible then
              Continue;
        ca                := StringReplace(ts.Caption, '&&', ',', [rfReplaceAll]);
        ca                := StringReplace(ca, '&', '', [rfReplaceAll]);
        tn                := Tree.Items.Add(nil,ca);
        tn.Data           := ts;
        tn.ImageIndex     := ts.ImageIndex;
        tn.Selected       := ZAL.ActivePage=ts;
        //ZAL.Pages[i].Tag  := Integer(tn);
     end;
     Tree.Items.EndUpdate;
end;

procedure TpsBarcodeEditorFmt.UpdateVisibility;
var ss:TpsBarcodeSymbology;
//    sh:TTabSheet;
begin
  ss:=cbTyp.SelectedSymbology;

  // sh:=ZAL.ActivePage;
  {$ifdef PSOFT_PROF}
      SH_PDF417.TabVisible := (ss=bcPDF417) or (epPDF417 in FUsedPages);
      SH_Params.TabVisible := ss in
          [bcPDF417
            {$ifdef PSOFT_STUDIO}
                , bcDataMatrix, bcQRCode, bcAztec
            {$endif}
          ];
  {$endif}

  {$ifdef PSOFT_STUDIO}
      SH_DATAMATRIX.TabVisible := (ss = bcDataMatrix);
      SH_QRCODE.TabVisible     := (ss = bcQRCode);
      SH_AZTEC.TabVisible      := (ss = bcAztec);
  {$endif}

  UpdateTree;
end;

procedure TpsBarcodeEditorFmt.ZALChange(Sender: TObject);
begin
//  Tree.Selected := TTreeNode(ZAL.ActivePage.Tag);
end;

procedure TpsBarcodeEditorFmt.BitBtn12Click(Sender: TObject);
begin
    // psPrinterSetup;
end;

procedure TpsBarcodeEditorFmt.BtnApplyClick(Sender: TObject);
begin
     UpdateParentBarcode;
end;


procedure TpsBarcodeEditorFmt.EditFont(F: TFont; SampleLabel: TLabel);
begin
  FD.Font.Assign(F);
  if FD.Execute then begin
    F.Assign(FD.Font);
    if Assigned(SampleLabel) then SampleLabel.Font.Assign(FD.Font);
  end;
end;

procedure TpsBarcodeEditorFmt.E_WIDTHChange(Sender: TObject);
begin
     UpdateLabel;
end;

procedure TpsBarcodeEditorFmt.FormCreate(Sender: TObject);
var i:Integer;
begin
       Set3D(Self, False);
       SetBevel(Self, bvNone, bkNone, bvNone, 0, 0 );

       {$ifdef PSOFT_STUDIO}
          psFillItems(CB_QR_ECL.Items, TypeInfo(TpsQrEccLevel) );
          psFillItems(CB_QR_MODE.Items, TypeInfo(TpsQrMode) );
          with CB_QR_VERSION.Items do begin
            BeginUpdate;
            Clear;
            // Add('Automatic');
            for i:= 0 to 40 do
                Add(IntToStr(i));
            EndUpdate;
          end;
          psFillItems(CB_DM_ENCODING.Items, TypeInfo(TpsDataMatrixEncoding) );
          psFillItems(CB_DM_VERSION.Items, TypeInfo(TpsDataMatrixVersion) );
       {$endif}
end;

procedure TpsBarcodeEditorFmt.UpdateLabel;
var cols,rows : Integer;
    PosX,PosY : Double;
    w,h, margin_left, margin_top, margin_bottom, margin_right,
    space_x, space_y, SizeX, SizeY : Double;
begin
  try
     SizeX := GetDeviceCaps(Printer.Handle, HORZSIZE);
     SizeY := GetDeviceCaps(Printer.Handle, VERTSIZE);

     Margin_Bottom := 5;
     Margin_Right  := 5;

     w := StrToFloat(E_Width.Text);
     h := StrToFloat(E_Height.Text);

     margin_left   := StrToFloat(E_LEFT.Text);
     margin_top    := StrToFloat(E_TOP.Text);

     space_x       := StrToFloat(E_SPACEX.Text);
     space_y       := StrToFloat(E_SPACEY.Text);

     Cols  := 0;
     PosX  := margin_left;
     while PosX+w<SizeX-Margin_Right do begin
           Inc(Cols);
           PosX := PosX + w + Space_x;
     end;

     Rows  := 0;
     PosY  := Margin_Top;
     while PosY+h<SizeY-Margin_Bottom do begin
         Inc(Rows);
         PosY := PosY + h + Space_y;
     end;

     LBL_FORMAT.Caption := Format('Cols : %d,  Rows:%d',[Cols, Rows]);
     E_COUNT.Text := IntToStr(Cols*Rows);
  except
  end;
end;

procedure TpsBarcodeEditorFmt.UpdateOneCaptionControls(C: TpsBarcodeCaption);
begin
  CA_Visible.Checked      := C.Visible;
  Group_Caption.Visible   := C.Visible;
  CA_TEXT.Text            := C.Text.Text;
  CA_Alignment.ItemIndex  := Integer(C.Alignment);
  CA_AutoCaption.Checked  := C.AutoCaption;
  CA_AutoSize.Checked     := C.AutoSize;
  CA_ParentFont.Checked   := C.ParentFont;
  CA_FontSample.Font.Assign(C.Font);
  CA_MaxHeight.Text       := IntToStr(C.MaxHeight);
end;


constructor TpsBarcodeAbout.Create(AOwner: TComponent);
begin
  inherited;
  FFormLeft     := -1;
  FFormTop      := -1;
  FFormCaption  := '';
  FFormPosition := poDesigned;
end;

class procedure TpsBarcodeAbout.Execute;
begin
  psShowAboutDlg(True);
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


function  TpsBarcodeAbout.EditBarcode(B:TpsBarcodeComponent):Boolean;
begin
  Result:=EditBarcodePage(B, epMain);
end;

function TpsBarcodeAbout.EditBarcodePage(B: TpsBarcodeComponent; Page:TpsEditorPage): Boolean;
var F         : TCustomForm;
    frmClass  : TCustomFormClass;
begin
  REsult := False;
  FParentBarcode := B;
  frmClass := GetEditWindowClass;
  if Assigned(frmClass) then begin
    F:=frmClass.Create(Application);
    try
      UpdateControls(F, B, Page);
      Result := (F.ShowModal in [mrOK, mrYes]);
      if Result then
        UpdateBarcode(F,B);
    finally
      F.Free;
    end;
  end;
end;


function TpsBarcodeAbout.GetEditWindowClass: TCustomFormClass;
begin
  Result := BarcodeEditorFmtClass;
end;

procedure TpsBarcodeAbout.UpdateBarcode(F: TCustomForm; B: TpsBarcodeComponent);
begin
  if F is TpsBarcodeEditorFmt then
    TpsBarcodeEditorFmt(F).UpdateParentBarcode;
end;

procedure TpsBarcodeAbout.UpdateControls(F: TCustomForm; B: TpsBarcodeComponent; Page:TpsEditorPage);
begin
  if F is TpsBarcodeEditorFmt then begin
    TpsBarcodeEditorFmt(F).SetParentEan(B);
    TpsBarcodeEditorFmt(F).SetActivePage(Page);
  end;
end;


{ TpsBarcodeEditor }

function EditBarcode(BarcodeComponent : TPersistent):Boolean;
begin
      Result:=EditBarcodePages(BarcodeComponent, []);
end;

function EditBarcodePages(BarcodeComponent: TPersistent; Pages:TpsEditorPages):Boolean;
var F  : TpsBarcodeEditorFmt;
    bc : TpsBarcodeComponent;
begin
    Result := False;
    if not (BarcodeComponent is TComponent) then
        Exit;

    if Supports(BarcodeComponent, IpsBarcodeInterface) then begin
        bc := (TComponent(BarcodeComponent) as IpsBarcodeInterface).BarcodeComponent;
        F:=TpsBarcodeEditorFmt.Create(Application);
        Try
            F.EditPage(bc, Pages);
            if F.ShowModal=mrOK then begin
                Result := True;
                bc.Assign(F.EAN.BarcodeComponent);
            end;
        Finally
          F.Free;
        End;
    end;
end;

function PrintDialog(BarcodeComponent : TPersistent):Boolean;
begin
        Result := EditBarcodePages(BarcodeComponent, [epPrint]);
end;

end.




