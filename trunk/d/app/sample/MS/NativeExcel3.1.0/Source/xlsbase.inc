type
  TOleEnum = type LongWord;

type
  XlLineStyle = TOleEnum;

type
  PDouble = ^Double;
  PLongWord = ^LongWord;
  PWord = ^Word;
  PByte = ^Byte;
  
const
  xlContinuous = $00000001;
  xlDashDot = $00000004;
  xlDashDotDot = $00000005;
  xlSlantDashDot = $0000000D;
  xlLineStyleNone = $FFFFEFD2;
  xlDouble = $FFFFEFE9;
  xlDot = $FFFFEFEA;
  xlDash = $FFFFEFED;
  xlLineStyleUndefined = $FFFFFFFF;

const
  xlUnknown = 0;
  xlExcel5  = 1;
  xlExcel97 = 2;
  xlHTML    = 3;
  xlRTF     = 4;
  xlCSV     = 5;
  xlText    = 6;
  xlUnicodeCSV     = 7;
  xlUnicodeText    = 8;
  xlOpenXMLWorkbook = 9;
     
type
  XlBorderWeight = TOleEnum;
const
  xlHairline = $00000001;
  xlMedium = $FFFFEFD6;
  xlThick = $00000004;
  xlThin = $00000002;
  xlBorderWeightUndefined = $FFFFFFFF;


// Constants for enum XlInsertShiftDirection
type
  XlInsertShiftDirection = TOleEnum;
const
  xlShiftDown = $FFFFEFE7;
  xlShiftToRight = $FFFFEFBF;

// Constants for enum XlDeleteShiftDirection
type
  XlDeleteShiftDirection = TOleEnum;
const
  xlShiftToLeft = $FFFFEFC1;
  xlShiftUp = $FFFFEFBE;

type
  XlPasteType = TOleEnum;
const
xlPasteAll                        = $00000017;
xlPasteFormats                    = $00000001;
xlPasteValues                     = $00000002;
xlPasteColumnWidths               = $00000004;
xlPasteNumberFormats              = $00000008;
xlPasteValuesAndNumberFormats     = $0000000A;
xlPasteComments                   = $00000010;
{
xlPasteAllExceptBorders           = $00000000;
xlPasteFormulas                   = $00000000;
xlPasteFormulasAndNumberFormats   = $00000000;
xlPasteValidation                 = $00000000;
xlPasteValuesAndNumberFormats     = $00000000;
}

const
  xlInsideHorizontal = $0000000C;  //1100
  xlInsideVertical   = $0000000B;  //1011
  xlDiagonalDown     = $00000005;  //0101
  xlDiagonalUp       = $00000006;  //0110
  xlEdgeBottom       = $00000009;  //1001
  xlEdgeLeft         = $00000007;  //0111
  xlEdgeRight        = $0000000A;  //1010
  xlEdgeTop          = $00000008;  //0100
  xlAround           = $0000000D;  //1101
  xlInsideAll        = $0000000E;  //1110

type
   XlHAlign = TOleEnum;
const
  xlHAlignCenter = $FFFFEFF4;
  xlHAlignCenterAcrossSelection = $00000007;
  xlHAlignDistributed = $FFFFEFEB;
  xlHAlignFill = $00000005;
  xlHAlignGeneral = $00000001;
  xlHAlignJustify = $FFFFEFDE;
  xlHAlignLeft = $FFFFEFDD;
  xlHAlignRight = $FFFFEFC8;

const
  xlVertical = 255;

type
  XlVAlign = TOleEnum;
const
  xlVAlignBottom = $FFFFEFF5;
  xlVAlignCenter = $FFFFEFF4;
  xlVAlignDistributed = $FFFFEFEB;
  xlVAlignJustify = $FFFFEFDE;
  xlVAlignTop = $FFFFEFC0;

// Constants for enum XlPageOrientation
type
  XlPageOrientation = TOleEnum;
const
  xlLandscape = $00000002;
  xlPortrait = $00000001;

// Constants for enum XlOrder
type
  XlOrder = TOleEnum;
const
  xlDownThenOver = $00000000;
  xlOverThenDown = $00000001;

// Constants for enum XlPaperSize
type
  XlPaperSize = TOleEnum;
const
  xlPaper10x14 = $00000010;
  xlPaper11x17 = $00000011;
  xlPaperA3 = $00000008;
  xlPaperA4 = $00000009;
  xlPaperA4Small = $0000000A;
  xlPaperA5 = $0000000B;
  xlPaperB4 = $0000000C;
  xlPaperB5 = $0000000D;
  xlPaperCsheet = $00000018;
  xlPaperDsheet = $00000019;
  xlPaperEnvelope10 = $00000014;
  xlPaperEnvelope11 = $00000015;
  xlPaperEnvelope12 = $00000016;
  xlPaperEnvelope14 = $00000017;
  xlPaperEnvelope9 = $00000013;
  xlPaperEnvelopeB4 = $00000021;
  xlPaperEnvelopeB5 = $00000022;
  xlPaperEnvelopeB6 = $00000023;
  xlPaperEnvelopeC3 = $0000001D;
  xlPaperEnvelopeC4 = $0000001E;
  xlPaperEnvelopeC5 = $0000001C;
  xlPaperEnvelopeC6 = $0000001F;
  xlPaperEnvelopeC65 = $00000020;
  xlPaperEnvelopeDL = $0000001B;
  xlPaperEnvelopeItaly = $00000024;
  xlPaperEnvelopeMonarch = $00000025;
  xlPaperEnvelopePersonal = $00000026;
  xlPaperEsheet = $0000001A;
  xlPaperExecutive = $00000007;
  xlPaperFanfoldLegalGerman = $00000029;
  xlPaperFanfoldStdGerman = $00000028;
  xlPaperFanfoldUS = $00000027;
  xlPaperFolio = $0000000E;
  xlPaperLedger = $00000004;
  xlPaperLegal = $00000005;
  xlPaperLetter = $00000001;
  xlPaperLetterSmall = $00000002;
  xlPaperNote = $00000012;
  xlPaperQuarto = $0000000F;
  xlPaperStatement = $00000006;
  xlPaperTabloid = $00000003;
  xlPaperUser = $00000100;

type
  XlPattern = TOleEnum;
const
  xlPatternAutomatic = $FFFFEFF7;
  xlPatternChecker = $00000009;
  xlPatternCrissCross = $00000010;
  xlPatternDown = $FFFFEFE7;
  xlPatternGray16 = $00000011;
  xlPatternGray25 = $FFFFEFE4;
  xlPatternGray50 = $FFFFEFE3;
  xlPatternGray75 = $FFFFEFE2;
  xlPatternGray8 = $00000012;
  xlPatternGrid = $0000000F;
  xlPatternHorizontal = $FFFFEFE0;
  xlPatternLightDown = $0000000D;
  xlPatternLightHorizontal = $0000000B;
  xlPatternLightUp = $0000000E;
  xlPatternLightVertical = $0000000C;
  xlPatternNone = $FFFFEFD2;
  xlPatternSemiGray75 = $0000000A;
  xlPatternSolid = $00000001;
  xlPatternUp = $FFFFEFBE;
  xlPatternVertical = $FFFFEFBA;

type
  XlColorIndex = TOleEnum;
const
  xlColorIndexAutomatic = $FFFFEFF7;
  xlColorIndexNone = $FFFFEFD2;

// Constants for enum XlUnderlineStyle
type
  XlUnderlineStyle = TOleEnum;
const
  xlUnderlineStyleDouble = $FFFFEFE9;
  xlUnderlineStyleDoubleAccounting = $00000005;
  xlUnderlineStyleNone = $FFFFEFD2;
  xlUnderlineStyleSingle = $00000002;
  xlUnderlineStyleSingleAccounting = $00000004;

  COLOR_scrollBar      =  0; //Scroll Bar System Color
  COLOR_background     =  1; //Background System Color
  COLOR_activeCaption  =  2; //Active Caption System Color
  COLOR_inactiveCaption = 3; //Inactive Caption System Color
  COLOR_menu           =  4; //Menu System Color
  COLOR_window         =  5; //Window System Color
  COLOR_windowFrame    =  6; //Window Frame System Color
  COLOR_menuText       =  7; //Menu Text System Color
  COLOR_windowText     =  8; //Window Text System Color
  COLOR_captionText    =  9; //Caption Text System Color
  COLOR_activeBorder   = 10; //Active Border System Color 
  COLOR_inactiveBorder = 11; //Inactive Border System Color
  COLOR_appWorkspace   = 12; //Application Workspace System Color
  COLOR_highlight      = 13; //Highlight System Color
  COLOR_highlightText  = 14; //Highlight Text System Color
  COLOR_btnFace        = 15; //Button Face System Color
  COLOR_btnShadow      = 16; //Button Shadow System Color
  COLOR_grayText       = 17; //Gray Text System Color
  COLOR_btnText        = 18; //Button Text System Color
  COLOR_inactiveCaptionText = 19; //Inactive Caption Text System Color
  COLOR_btnHighlight   = 20; //Button Highlight System Color  
  COLOR_3dDkShadow     = 21; //3D Dark System Color 
  COLOR_3dLight        = 22; //3D Light System Color
  COLOR_infoText       = 23; //Info Text System Color
  COLOR_infoBk         = 24; //Info Back System Color
  COLOR_unknown1       = 25;
  COLOR_hotLight       = 26; //Hot Light System Color
  COLOR_gradientActiveCaption = 27; //Gradient Active Caption System Color
  COLOR_gradientInactiveCaption = 28; //Gradient Inactive Caption System Color
  COLOR_menuHighlight  = 29; //Menu Highlight System Color
  COLOR_menuBar        = 30; //Menu Bar System Color





const
  xlSheetVisible     = $0000000;
  xlSheetHidden      = $0000001;
  xlSheetVeryHidden  = $0000002;

{MsoLineStyle constants}
const msoLineSingle           = $00000000;
const msoLineThinThin         = $00000001;
const msoLineThickThin        = $00000002;
const msoLineThinThick        = $00000003;
const msoLineThickBetweenThin = $00000004;
const msoLineStyleMixed       = $00000005;


{MsoLineDashStyle}
const msoLineSolid            = $0;
const msoLineSquareDot        = $2;  //msolineDotSys
const msoLineRoundDot         = $F002;  
const msoLineDash             = $6;  //msolineDashGEL
const msoLineLongDash         = $7;  //msolineLongDashGEL
const msoLineDashDot          = $8;  //msolineDashDotGEL
const msoLineLongDashDot      = $9;  //msolineLongDashDotGEL
const msoLineDashDotDot       = $A;  //msolineLongDashDotDotGEL


{XlReferenceStyle}
const xlA1                    = $1; //A1 Mode
const xlR1C1                  = $0; //RC Mode

{XlReadingOrder}
type XlReadingOrder = byte;
const xlContext                = $0; //According to context.
const xlLTR                    = $1; //Left-to-right.
const xlRTL                    = $2; //Right-to-left.


{XlSummaryRow}
type XlSummaryRow = byte;
const xlAbove                 = $0; //Above
const xlBelow                 = $1; //Below

{XlSummaryColumn}
type XlSummaryColumn = byte;
const xlLeft                 = $0; //Left
const xlRight                = $1; //Right

type XlAutoFilterOperator = byte;
const xlAnd                 = $0; 
const xlOr                  = $1; 
const xlBottom10Items       = $2;
const xlBottom10Percent     = $3;
const xlTop10Items          = $4;
const xlTop10Percent        = $5;


{$IFDEF D45}
type 
  IInterface = System.IUnknown;
{$ENDIF}


type XlThemeColor = byte;
const xlThemeColorDark1              = 1;  //Dark1
const xlThemeColorLight1             = 2;  //Light1
const xlThemeColorDark2              = 3;  //Dark2
const xlThemeColorLight2             = 4;  //Light2
const xlThemeColorAccent1            = 5;  //Accent1
const xlThemeColorAccent2            = 6;  //Accent2
const xlThemeColorAccent3            = 7;  //Accent3
const xlThemeColorAccent4            = 8;  //Accent4
const xlThemeColorAccent5            = 9;  //Accent5
const xlThemeColorAccent6            = 10; //Accent6
const xlThemeColorHyperlink          = 11; //Hyperlink
const xlThemeColorFollowedHyperlink  = 12; //Followed hyperlink
