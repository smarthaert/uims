unit psCodeRes;

interface

{$I psBarcode.inc}

const

      constBarcodeSymbology = 'BarcodeSymbology';
      rsNotSupported='Sorry, function/feature %s is now not supported.';


{$ifdef PSOFT_PROF}
        rsBarcodeDescription='PSOFT Barcode object'#13'with PDF417 support'#13'http://www.psoft.sk';
{$else}
        rsBarcodeDescription='PSOFT Barcode object'#13'http://www.psoft.sk';
{$endif}


      rsEditor                = 'Properties ... ';
      rsPrintSheet            = 'Print sheet';
      rsExportBarcode         = 'Export or Copy barcode ...';

      rsEmailPSoft            = 'Barcode library - send email to authors';
      rsBarcodeLinks          = 'Barcode links';
      rsHomePageText          = 'PSOFT homepage';
      rsCheckForUpdates       = 'Check for updates';
      rsBarcodeRegister       = 'Online registration of Barcode library';
      rsDownloadPage          = 'Download page';
      rsFAQPage               = 'FAQ page';
      rsBarcodeEncyclopedia   = 'Barcode encyclopedia';
      rsBarcodeOnlinePrinter  = 'Barcode online printer';

//      rsBarcodeLibraryRegisterStringLite = 'http://www.regsoft.net/purchase.php3?productid=76312';

      rsBarcodeCategory      = 'BarCode';
      rsBarcodeSheetName     = 'PSOFT Barcode';

      ErrOK                  = 'O.K';
//      ErrSyntaxError         = '';
//      ErrSyntaxErrorManual   = 'Error in data to encode, see manual or our Barcode knowledgebase';
      ErrMustBe              = 'Char(s) at(from) position %d must be (equal or in range) %s';
      ErrUnspecified         = 'Unspecified error, no code generated';
      ErrUnavailableChar     = 'Unvailable char for this barcode symbology (%d.char - %s)';
      ErrSmallPaintBox       = 'Rectangle for painting is very small.';
      ErrOutOfSecurityBox    = 'Rectangle for secure painting is very small.';
      ErrLengthInvalid       = 'Invalid length of barcode, must be in [%s].';
      ErrLengthInvalidRange  = 'Invalid length of barcode, must be between %d and %d.';
      ErrFirstCharZero       = 'ITF14 - first char must be 0.';

      ErrCharSpace           = '%d. char must be space.';
      ErrCountCharBeEven     = '2of5 Interleaved/ITF - count of digits must be even.';
      ErrEmptyCode           = 'Empty code.';
      ErrCode16KMode         = 'Mode Code16K must be -1 for automatic mode selection or between 0..6';
      ErrBadPrefix           = 'Bad barcode prefix, must  be %s';
      ErrBadSuffix           = 'Bad barcode sufix , must  be %s';
      Err2DBadColCount       = 'Bad columns count, you have %d, must be 0 or in %s .';
      Err2DBadRowCount       = 'Bad rows count, you have %d, must be 0 or in %s .';
      Err2DOutOfSymbolSpace  = 'Symbol data capacity is smaller than you need.'#13'Need/Have codewords : (%s).';
      errCPCBadCode          = 'Error in CPC/Postbar code %s at %d position.';
      errBarcodeValueOutOfRange = 'Barcode value must be between %d and %d';
      errItalianPharmaBad    = 'Italian Pharmacode value bad.'#13'Must be in format ANNNNNNNN .';
      errNumericBarcode      = 'Barcode symbology is accept only digits.';
      errNumericRange        = 'Chars from position %d to %d must be digits.';
      rsOutOfFunction        = 'Sorry, this function is now not implementded. In next days we hope this function is ready.Sorry';
      errNoSymbology         = 'Empty barcode.';
      errOutOfMaxCapacity    = 'Max.codeword capacity ( %d codewords) overcome.';
      errBadECI              = 'Bad ECI value, must be between 0 and 999999 (inluded).';
      rsBadCharInPDF417      = 'Bad char in PDF417, position %d, char : %s';
      rsBadBarcodeValueText  = 'Bad barcode value';

      errGS1                 = 'Error in GS1 syntax';
      ErrGS1_AI_MustBeInteger= 'GS1 Application identifier must be integer';
      errGS1_AI_NotFound     = 'GS1 unknown Application identifier';
      errGS1_BadValueLength    = 'Value length must be between %d and %d' ;
      errGS1_ValueMustBeInteger= 'Value must be integer';


{$ifdef PSOFT_PROF}
      rsAustraliaInvalidEncode        = 'Bad data to encode';
      rsAustraliaInvalidFCC           = 'Invalid FCC, must be one from 11, 87, 45, 92, 59, 62, 44';
      rsAustraliaInvalidSortCode      = 'Invalid Sort code, must be 8 digits lenght';
      rsAustraliaInvalidCustomerCode  = 'Invalid Customer code/info, see documentation';
      rsAustraliaInvalidCustomerInfo  = 'Invalid Customer info/info, see documentation';
{$endif}


      rsLoadFromIni   = 'Load from ini file';
      rsSaveToIni     = 'Save to ini file';
      rsSaveToHtml    = 'Save all barcode types to HTML';
      rsSaveToXML     = 'Save to XML';
      rsLoadFromXML   = 'Load From XML';
      rsExportToHTML  = 'Export to HTML file';
      rsSaveToDFM     = 'Save to DFM';
      rsLoadFromDFM   = 'Load from DFM';
      rsReedSolomonOverFlow = 'ReedSolomon overflow';

      rsYes = 'Yes';
      rsNo  = 'No';

      errNotSupported                 = 'Sorry, this feature (%s) not supported now.'#13#10'Please contact us on email peter@psoft.sk for detail info.'#13#10'Thanks.';
      errNeedProfessionalVersion      = 'Sorry, for this feature/function you must have professional version'#13#10'Please look at http://psoft.sk for Barcode library version table.'#13#10'Thanks.';

      rsHintTemplate = 'Symbology  name : %s'#13#10
                      +'Enumerated name : %s'#13#10
                      +'Symbology type  : %s'#13#10
                      +'Current value   : %s'#13#10
                      +'Charset         : %s'#13#10;

      rsErrorWord    = 'ERROR :';

// ----------------------------------------------------------------------
// used by frames and editors
// ----------------------------------------------------------------------

    rsFrameCaption_Main           = 'Main';
    rsFrameCaption_Options        = 'Options';
    rsFrameCaption_Ext            = 'Extended';
    rsFrameCaption_QZ             = 'Quiet zone';
    rsFrameCaption_CaptionUpper   = 'Upper|Caption upper';
    rsFrameCaption_CaptionBottom  = 'Bottom|Caption bottom';
    rsFrameCaption_CaptionHuman   = 'Human|Human readable';
    rsFrameCaption_2D             = '2D|2D properties';
    rsFrameCaption_PDF417         = 'PDF417';
    rsFrameCaption_Pen            = 'Pen';
    rsFrameCaption_Buttons        = 'Buttons';
    rsFrameCaption_Inspector      = 'Inspector|Barcode inspector';
    rsFrameCaption_Print          = 'Print|Print parameters';
    rsFrameCaption_Presentation   = 'Demo|Presentation window';
    rsFrameSymbologyInfo          = 'Barcode symbology info';

    rsFrameSymbology              = 'Barcode symbology';
    rsFrameValue                  = 'String to encode';
    rsFrameAvailableCharset       = 'Available charset';
    rsFrameUnits                  = 'Units';
    rsFrameStyle                  = 'Style';
    rsFrameVisible                = 'Visible';
    rsFrameIndicatorSize          = 'Indicator size';
    rsFrameQZLeft                 = 'Left';
    rsFrameQZRight                = 'Right';
    rsFrameQZTop                  = 'Top';
    rsFrameQZBottom               = 'Bottom';

    rsFramePenStyle               = 'Pen style';
    RSFRAMEPENWIDTH               = 'Pen width';
    RSFRAMEPENMODE                = 'Pen mode';
    RSFRAMEPENCOLOR               = 'Pen color';

    RSFRAMEOPTIONS                = 'OPTIONS';
    RSFRAMETEXT                   = 'Text';
    RSFRAMEMASK                   = 'Mask';
    RSFRAMETRANSPARENT            = 'Transparent';
    RSFRAMEAUTOCAPTION            = 'Auto caption';
    RSFRAMEAUTOSIZE               = 'Auto size';
    RSFRAMEBACKGROUNDFULL         = 'Background full width';
    RSFRAMEBGCOLOR                = 'Background color';
    RSFRAMEALIGNMENT              = 'Alignment';
    RSFRAMEMAXHEIGHT              = 'Max.height %';
    RSFRAMEPARENTFONT             = 'Parent font';
    RSFRAMEFONT                   = 'Font';

    RSFRAMEBACKGROUNDCOLOR        = 'Background colot';
    RSFRAMELINESCOLOR             = 'Bars color';
    RSFRAMEANGLE                  = 'Angle';
    rsFrameInputFilters           = 'Input filters';
    rsPDF417Version               = 'PDF417 version';
    rsPDF417SecurityLevel         = 'Security level';
    rsPDF417Mode                  = 'Mode';
    rsPDF417Filename              = 'Filename';
    rsPDF417TimeStamp             = 'Timestamp';
    rsPDF417Address               = 'Address';
    rsPDF417Sender                = 'Sender';
    rsPDF417FileSize              = 'File size';
    rsPDF417CheckSum              = 'Checksum';

    rsFrameCols             = 'Columns';
    rsFrameRows             = 'Rows';
    rsFrameSegmentIndex     = 'Segment index';
    rsFrameSegmentCount     = 'Segment count';
    rsFrameFileID           = 'File ID';
    rsFrameECI              = 'ECI';

    rsFramePrintUnits       = 'Print units';
    rsFramePrintPageWidth   = 'Page width';
    rsFramePrintPageHeight  = 'Page height';
    rsFramePrintMarginLeft  = 'Margin left';
    rsFramePrintMarginTop   = 'Margin top';
    rsFramePrintLabelWidth  = 'Label width';
    rsFramePrintLabelHeight = 'Label height';
    rsFramePrintSpaceX      = 'Space X';
    rsFramePrintSpaceY      = 'Space Y';
    rsFrameResetToDefaults  = 'Defaults';
    rsFramePrint            = 'Print';
    rsFrameUndo             = 'Undo';
    rsFrameExport           = 'Export';
    rsFramePrior            = 'Prior';
    rsFrameNext             = 'Next';

// ----------------------------------------------------------------------
// resources for comboboxes, listboxes, treeviews...
  rs_bc_supported             = 'Supported : %s';
  rs_bc_name                  = 'Barcode name : %s';
  rs_bc_another_name          = 'Another names (known as) : %s';
  rs_bc_family                = 'Barcode family : %s';
  rs_bc_checksum              = 'Checksum : %s';
  rs_bc_autors                = 'Created by : %s';
  rs_bc_year                  = 'Creation year : %d';
  rs_bc_chraset               = 'Available charset : %s';
  rs_bc_enable_addOn          = 'Add On enabled : %s';
  rs_bc_AutoCaption           = 'AutoCaption : %s';
  rs_bc_Continuous            = 'Continuos : %s';
  rs_bc_BiDirectional         = 'Bidirectional : %s';

  rs_bc_NotSupportedText      = 'not supported';
  rs_bc_needEnterpriseVersion = 'need Enterprise version';
  rs_bc_needProfVersion       = 'need Professional version';

  rsExecute = 'Execute';

  rsErrorOpeningComPort='Error opening com port.';

  rsPrintRectCaption = 'Print barcode params';


  rsExportDialogTitle = 'Save your barcode' ;

  rsPrintProgressWindowCaption = 'Printing: %s';
  rsPrintStop                  = 'Stop printing ?';
   rsPrinterNotSelected        = 'Printer not selected';


type
    TpsLinkType=(ltHome, ltProductHome, ltProductDownload, ltProductOrder,
      ltProductScreens);

{$ifdef PSOFT_EU}
    function  GetProductLink(Link:TpsLinkType):string;
{$endif}


var productSEO : string;

implementation

{$ifdef PSOFT_EU}
function  GetProductLink(Link:TpsLinkType):string;
var s:String;
begin
    s:='http://'+constEUHome+'/';
    case Link of
      ltHome            : ;
      ltProductHome     : s:=s+'product-'+productSEO;
      ltProductDownload : s:=s+'download-'+productSEO;
      ltProductOrder    : s:=s+'order-'+productSEO;
      ltProductScreens  : s:=s+'screenshots-'+productSEO;
    end;
    Result := s;
end;
{$endif}


end.
