unit psTypes;

interface

{$I psBarcode.inc}

uses Classes, Messages, Types, Graphics, SysUtils, Math, Windows;


const msg_UpdateBarcode = WM_USER + 100;

      Ord0      = Ord('0');
      Ord9      = Ord('9');
      OrdA      = Ord('A');
      OrdF      = Ord('F');
      OrdZ      = Ord('Z');
      OrdLowerA = Ord('a');
      OrdLowerF = Ord('f');
      OrdLowerZ = Ord('z');

      constBarcodeDomain      = 'http://www.barcode-software.eu';
      constProductSEO         = 'barcode-studio';
      ToolPalettePageBarcode  = 'Barcode studio';
      BarcodePropertyCategory = 'Barcode';
      NoDefault               = Low(Integer);

      ToRad           = 2*PI/360;
      constZoomFactor = 1000;
      psInchMM        = 25.4;

      psLF          = $0A;
      psCR          = $0D;
      psHT          = $09;
      psFS          = 28;
      psGS          = 29;
      psRS          = 30;
      psUS          = 31;
      psEOT         = 04;
      psBACKSLASH   = 92;
      psPERCENTCHAR = 37;
      psSpace       = 32;
      psESC         = 27;
      psCRLF        = #13#10; //psCR+psLF;


      // control characters, my defintion, same for all symbologies, but in
      // encoding process changed to value depended on selected symbology
      psFNC1        = 500;
      psECI         = 501;
      psNS          = 502;
      psPAD         = 503;
      psShiftA      = 510;
      psShiftB      = 511;
      psShiftC      = 512;
      psShiftD      = 513;
      psShiftE      = 514;
      ps2ShiftA     = 515;
      ps3ShiftA     = 514;

      psLatchA      = 520;
      psLatchB      = 521;
      psLockInC     = 530;
      psLockInD     = 531;
      psLockInE     = 532;

      constDigits         = '01234567890';
      constUpperAZ        = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      constLowerAZ        = 'abcdefghijklmnopqrstuvwxyz';
      constHexaDigits     = '0123456789ABCDEF';

type

    // event types

    TpsBarCodeErrorEvent = procedure (Sender: TObject; var Handled:Boolean) of Object;
    TpsBarCodePaintEvent = procedure (Sender: TObject; Canvas:TCanvas;
                                                    Rect:TRect) of object;
    TpsBarCodeNeedHint   = procedure (Sender: TObject; var HintText:String) of Object;
    TpsBarcodeChangeEvent= procedure (Sender: TObject; const PropName:String) of Object;

    //---------------------------------------------------------------------
    //-- all boolean properties we move to property BarcodeOptions
    //---------------------------------------------------------------------
    TpsBarcodeOption = (
      boTransparent,      // set barcode background transparent
      boSecurity,         // use for display or device with small DPI
                          // barcode zoom in width is integer value, for example
                          // 2 or 3x, not 2.3... this solve problem with bars/space lost
                          // and barcode unreadable ...
      // boShowLabels,
      boStartStopLines,   //
      boAddOnUp,          // used for EAN/UPC with 2/5 add-on digits, if True,
                          // add-on human readable digits are printed in upper
                          // part of barcode
      boEnableEditor,     // if True doubleclick on the barcode open default
                          // barcode property editor
//      boChecksumInHuman,  {!}{ dorobit ci checksum sa dava do humanreadable}
      boAutoSize,         // human readable font autosize
      boAutoHint,
      boAutoCheckDigit,

      { TODO : Dorobit }
      boEditorAfterCreate // open barcode editor after create barcode at design time

      ,boFlipVertical
      ,boFlipHorizontal
      ,boReflectanceReversal

      ,boPaintIfSmall
      ,boAddLeadingZero
      ,boAutoSecurity
      ,boHideIfEmpty
      ,boHideIfException

      {     // use only for demonstration !!! True means the barcode
                          // is painted always, if width in pixels is smaller
                          // then minimum width, is painted too -> some
                          // bars/spaces are lost -> barcode is UNREADABLE.
      boAutoPrefix,       // used for ISBN,ISSN,ISMN symbologies, you can set
                          // Barcode property without starting seqeunce
                          // like 978, 977 , for JAN symbology without 98 ...
      boAutoSuffix,
      boUseMacros,        //
      boAddLeadingZero,   // for ITF or 2/5 Interleaved, where count of digits
                          // must be even add leading zero, if this count is odd
      boAutoHint,         // if Barcode or BarcodeSymbology property is changed,
                          // set the Hint property with info about selected symbology
      boLoadDefaults,     //
      boAngleResize  }
      );

    TpsBarcodeOptions = set of TpsBarcodeOption;

    TpsBarcodeSymbology = ( bcNone,
               bcEan8, bcEan13, bcCodabar,
               bcCode39Standard,bcCode39Full,
               bcCode93Standard,bcCode93Full,
               bcCode128,bcABCCodabar,
               bc25Datalogic,bc25Interleaved,bc25Matrix,
               bc25Industrial,bc25IATA,bc25Invert,

               { type of barcode added in new version}
               bcITF, bcISBN, bcISSN, bcISMN,
               bcUPCA,
               bcUPCE0,bcUPCE1,
               bcUPCShipping,
               bcSCC14,
               bcJAN8, bcJAN13,
               bcMSIPlessey,
               bcPostNet,
               bcPlanet,
               bcRoyalMail,
               bc4State,
               bcDutch4StatePostal,
               bcSwissPostal,
               bcSingapore4StatePostalCode,
               bcPostBar,
               bcPostbarCPC4State,

               bcOPC,
               bcUccEan128,
               bc25Coop, bcCode11,
               bcPZN,

               bcPDF417,

               bcCodablockF,
               bcSSCC,
               bcSISAC,
               bcCode16K,
               bcCodabarMonarch,
               bcFim

               // {$ifdef PSOFT_PROF}
                  , bcTelepen
                  , bcIntelligentMail, bcAustraliaPost
                  // , bcPostbarCPC4State
               //{$endif}
               //{$ifdef PSOFT_STUDIO}
                  , bcDataMatrix
                  , bcQRCode
                  , bcAztec
               //{$endif}
               );

               {


                Code B, Cstate4
                4-State	European 4 state code
                ASDA 8 - kod odvodeny od EAN8
                Nixdorf barcode - odvodeny od EAN 13
                Glaxo Welcome company
                GW Dartford - odvodene od Pharma
                GW Code 39
                GW MSI
                GW Ean 13
                GW Ean 8
                GW Pharma

                M&S7 - odvodene od EAN 8

                Novartis Pharma
                ASDA 8,  M&S 7 MSI, Wickes 8, Woolworth 8
                Pharma Code, Glaxo Wellcome IMH Code 39, Kurandt
                Novartis Pharma, PZN Code 39
                HIBC Code 39 , HIBC/HIBC-LIC
	        German Post Office AG
	        Identity and Lead Code
                OCR-A, OCR-B, MICR, and CMC7}

  TpsSymbologies = set of TpsBarcodeSymbology;

  TpsSymbolType =(stUnknown, {stAll,} stLinear, stPostalCode, stStacked, stComposite,
        stMatrix, {st2DCode, } st3DCode, stColorCode);

  TbcSymbolTypes = set of TpsSymbolType;

  TpsBarCodeInfo = record
     SelectedSymbology : TpsBarcodeSymbology;
     Supported      : Boolean;
     Name           : String;
     LongName       : String;
     InitValue      : String;
     Chars          : String;
     ParentCode     : TpsBarcodeSymbology;
     Year           : Word;
     Country        : String;
     CodeContry     : String;
     EnabledAdd     : Boolean;
     AutoCaption    : Boolean;
     OptCharWidthMM : Double;
     Length         : Word;
     SymbolType     : TpsSymbolType;
     VariableRatio  : Boolean;
     Prefix, Suffix : String;
  end;

  TpsBarcodeInfoItemType  = (
      itSupported,  // yes/no - symbology supported
      itName,       // symology name
      itLongName,   // symbology long name
      itEnumName,   // symbology enumerated name ( bcEan8, bcISBN ...)
      itInitValue,  // initial value for selected TypBarcode
      itChars,      // available chars - in intervals
      itCharsString,// available chars - enumerated chars
      itParentCode, // parent barcode symbology
      itYear,       // creation year
      itCountry,    // contry or companies which develop symbology
      itEnabledAdd, // yes/no if enabled add on - for EAN/UPC
      itAutoCaption,// yes/no, if automatic caption update is recommended
      itLength,     // symbology length
      itSymbolType, // symbology type - linear, stacked, 2D, ...
      itPrefix,     // symbology prefix (for example ISBN = 978 )
      itSuffix,     // suffix
      itOptions,    // Symbology options, set as string

      itCountTotal,         itCountSupported,         itCountBoth,
      itCountLinearTotal,   itCountLinearSupported,   itCountLinearBoth,
      itCountPostalTotal,   itCountPostalSupported,   itCountPostalBoth,
      itCountStackedTotal,  itCountStackedSupported,  itCountStackedBoth,
      itCount2DTotal,       itCount2DSupported,       itCount2DBoth
      );

  // used for 2 of 5 symbologies for set wide:narrow ratio
  TpsRatio = (ra20 { 2.0:1}, ra25 {2.5:1} , ra30 {3.0:1} );

  TpsBarcodeListStyle = (btSymbol, btText);

  // used for browse in symbologies
  TpsDirection = (psDirFirst, psDirPrevious, psDirNone, psDirNext, psDirLast);

  T2dDirection=(dirLeft,dirUp,dirRight,dirDown);

  TpsArray = record
    count     : Integer;
    position  : Integer;
    capacity  : Integer;
    data      : array of Integer;
  end;

  function psArrayInitialize(var D:TpsArray; len:Integer):Integer;
  function psDataPut(var D:TpsArray; Value:Integer):Integer;
  function psDataAdd(var Dest, Source : TpsArray):Integer;
  function psDataGet(var D:TpsArray; position:Integer):Integer;
  function psDataSet(var D:TpsArray; Value:Integer; idx:Integer):Integer;


type

  TpsOffsets = array[1..6] of Integer;

  TpsCapacity2D = record
      Numeric       : integer; // only numbersd 0-9
      Alphanumeric  : integer; // a-z, A-Z, 0-9, punctuation
      Binary        : integer; // ASCII and Extended ASCII 0-255
      Kanji         : integer; // Japanese chars Kanji/Kana
  end;

  TpsSize2D = record
    DataW, DataH    : Integer;
    MatrixW,MatrixH : Integer;
  end;

  TpsRect  = record
      Left, Top , Width, Height : Double;
  end;

  TpsEditorPage = (epMain, epColorsFont, epQuietZone, epPrint,
          epCaptionUpper, epCaptionHuman, epCaptionBottom, epOptions, epParams,
          epSpecial, epFunctions, epPDF417, epDataMatrix, epQRCode);
  TpsEditorPages  = set of TpsEditorPage;

  IpsBarcodeEditor=interface
    ['{16F1CEFC-FCE0-42DA-868D-1BF9454D8C9E}']
    procedure Edit(bc:TObject);
    procedure Print(bc:TObject);
    procedure EditPage(bc:TObject; page:TpsEditorPages);
  end;


  // used for optimalization procedures to encode data for symbologies
  // Code128, PDF417, DataMatrix, QRCode
  // optimalization procedure create array of TpsEncodingPlanItem records
  // last/stop/end of encoding item has Mode = -1

  TpsEncodingPlanItem = record
    Fn    : Integer;  // Function, used for Shift, Latch, Modes, ECI, FNC1..FNC4
    Mode  : Integer;  // depended on barcode symbology
    Data  : String;     // data to encode
    Value : Integer;
  end;

  TpsEncodingPlan = record
    Count : Integer;
    items : array of TpsEncodingPlanItem;
  end;

  TpsEncodingPlanOptimizedItem = record
    Mode : Integer;
    Data : String;
    Fn   : Integer;
  end;

  TpsEncodingPlanOptimized = record
     Count : Integer;
     items : array of TpsEncodingPlanOptimizedItem;
  end;

  procedure psAnalyzeString(const s:string; var P:TpsEncodingPlan);
  procedure PlanOptimize(const P:TpsEncodingPlan; var O:TpsEncodingPlanOptimized);

// used for TpsExport component

type  TGraphicsType     = (gtBmp,gtWmf,gtEmf, gtJPeg, gtGif);
const grExtensions : array [TGraphicsType] of string=
        ('.Bmp','.Wmf','.Emf','.Jpg','.Gif');


var psGlobalBarcodeOptions : TpsBarcodeOptions
    = [ boTransparent, boSecurity, {boShowLabels,} boAutoCheckDigit,
          boStartStopLines,  boAddOnUp,boEnableEditor, boAutoSize, boAutoHint,
          boEditorAfterCreate ];

implementation


function psArrayInitialize(var D:TpsArray; len:Integer):Integer;
var i:Integer;
begin
  SetLength(D.data,len);
  for I := 0 to len - 1 do
      D.data[i] := 0;
  D.position  := 0;
  D.count     := 0;
  D.capacity  := len;
  Result      := D.count;
end;

function psDataPut(var D:TpsArray; Value:Integer):Integer;
begin
  if D.Position>=D.capacity then
      raise Exception.Create('psArray error, max capaciry exceeded.');
  D.Data[D.position] := Value;
  Inc(D.position);
  if D.position>= D.count then
      Inc(D.count);
  Result := D.Position;
end;

function psDataAdd(var Dest, Source : TpsArray):Integer;
var i:Integer;
begin
    for i:=0 to Dest.Count-1 do
        psDataPut(Source, Dest.data[Dest.Count-1-i]);
    Result := Dest.Count;
end;

function psDataGet(var D:TpsArray; position:Integer):Integer;
begin
  if (position>=0) and (position<D.count) then
    result := D.data[position]
  else
    result := -1;
end;

function psDataSet(var D:TpsArray; Value:Integer; idx:Integer):Integer;
begin
  if D.capacity>idx then begin
    D.data[idx] := Value;
    Result := idx;
  end
  else
      Result := -1;
end;

// ---------------------------------------------------------------------------

procedure psAnalyzeString(const s:string; var P:TpsEncodingPlan);
var i:Integer;
    resStr:AnsiString;
begin
    resStr := '';
    i:=1;
    while i<=Length(s) do begin
        Inc(i);
    end;
end;

procedure PlanOptimize(const P:TpsEncodingPlan; var O:TpsEncodingPlanOptimized);
var i        : Integer;
    LastMode : Integer;
    s        : string;
begin
  LastMode := -1;
  O.Count  := 0;
  s        := '';
  for i := 0 to P.Count - 1 do begin
      s := s + P.Items[i].Data;
      if (LastMode>=0) and (P.Items[i].Mode<>LastMode) then begin
          O.items[O.Count].Mode := LastMode;
          O.items[O.Count].Data := s;
          Inc(O.Count);
          s     := '';
      end;
      LastMode:= P.Items[i].Mode;
  end;

  if Length(s)>0 then begin
      O.items[O.Count].Mode := LastMode;
      O.items[O.Count].Data := s;
      Inc(O.Count);
  end;
end;


end.

