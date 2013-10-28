//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsxwrite
//
//      Description:  XLSX writer
//
//////////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2008 NikaSoft. All rights reserved.
//     Author: A.V.Nikulitsa
//
//       site: http://www.nika-soft.com/ 
//     e-mail: support@nika-soft.com
//
//////////////////////////////////////////////////////////////////////////////
unit xlsxwrite;
{$Q-}
{$R-}

interface
{$I xlsdef.inc}
uses classes, nExcel;//, performance;

function SaveXLSXFile(Book: TXLSWorkBook; FileName: WideString; Password: WideString; FileFormat: TXLSFileFormat): integer;
function SaveXLSXStream(Book: TXLSWorkBook; Stream: TStream; Password: WideString; FileFormat: TXLSFileFormat): integer;

implementation
uses xlsxfrw, wstream, sysutils, xlshash, xmlwriter, xlsxrelations,
     xlsstylefont, xlsstylecolor, xlsstylefill, xlsstyleborder,
     xlsstylexf, xlssst, xlscols, xlsrows, xlscalc, xlshyper, xlsnames;


{$I xlsbase.inc}

type

   TXLSXWriter = class
   private
     FFileWriter: TXLSXFileWriter;
//     FFileFormat: TXLSFileFormat;
     FBook: TXLSWorkbook;
     FSheet: IXLSWorksheet;
     FXMLWriter: TXMLWriter;
     FWBRelations: TXLSXRelations;
     FWSRelations: TXLSXRelations;
     FXFTranslation: Array of integer;
     FActivePane: string;
     FNeedRecalc: boolean;
     FMergedCells: TList;

     function Store: integer;

     function  CreateXMLWriter(filename: widestring): integer;
     procedure CloseXMLWriter;

     procedure SetAttrInt32(attrname: ansistring; Value: integer); 
     procedure SetAttrString(attrname: ansistring; Value: widestring; Encode: boolean);
     procedure SetAttrBoolean(attrname: ansistring; Value: boolean); 
     procedure SetAttrDouble(attrname: ansistring; Value: double); 
     procedure WriteTextElement(tagname: ansistring; Value: widestring);
     procedure WriteDouble(Value: double); 
     procedure WriteBoolean(Value: boolean); 
     procedure WriteInt32(Value: integer); 
     procedure WriteError(Value: integer); 

     function StoreRootRels: integer;
     function FillContentTypes: integer;
     function StoreWorkbook: integer;
     function StoreWorkbookHeader: integer;
     function StoreWorkbookFooter: integer;
     function StoreWorksheets: integer;
     function StoreStyles: integer;
     function StoreStylesHeader: integer;
     function StoreStylesFooter: integer;
     function StoreWorksheet(index: integer): integer;
     function StoreWorksheetHeader: integer;
     function StoreWorksheetFooter: integer;

     function InternalPatternToSTPatternType(pattern: integer): widestring;
     function InternalBorderStyleToSTBorderStyle(style: byte): widestring;
     function InternalHAlignToSTHorizontalAlignment(value: integer): widestring;
     function InternalVAlignToSTVerticalAlignment(value: integer): widestring;

     function Store_WB_fileVersion: integer;
     function Store_WB_workbookPr: integer;
     function Store_WB_bookViews: integer;
     function Store_WB_workbookView: integer;
     function Store_WB_sheets: integer;
     function Store_WB_sheet(index: integer): integer;
     function Store_WB_rels: integer;
     function Store_WB_calcPr: integer;
     function Store_WB_externalReferences: integer;
     function Store_WB_fileSharing: integer;
     function Store_WB_definedNames: integer;
     function Store_WB_definedName(nm: TXLSCustomName; sheetindex: integer; var nameexist: boolean): integer;
     function Store_WB_PrintArea(sheetindex: integer; var nameexist: boolean): integer;
     function Store_WB_PrintTitle(sheetindex: integer; var nameexist: boolean): integer;
     function Store_WB_workbookProtection: integer;

     function Store_SST: integer;

     function Store_WS_sheetPr: integer;
     function Store_WS_outlinePr: integer; 
     function Store_WS_pageSetUpPr: integer;
     function Store_WS_dimension: integer;    
     function Store_WS_sheetViews: integer;
     function Store_WS_sheetView: integer;
     function Store_WS_selection: integer;
     function Store_WS_pane: integer;
     function Store_WS_sheetFormatPr: integer;
     function Store_WS_cols: integer;
     function Store_WS_col(c: TXLSColumnInfo; mincol, maxcol: integer): integer;
     function Store_WS_sheetData: integer;
     function Store_WS_row(row: integer; r: TXLSRowInfo): integer;
     //function Store_WS_c(row, col: integer; c: TXLSCellRef): integer;
     function Store_WS_pageMargins: integer;
     function Store_WS_pageSetup: integer;
     function Store_WS_headerFooter: integer;
     function Store_WS_drawing: integer;
     function Store_WS_printOptions: integer;
     function Store_WS_mergeCells: integer;
     function Store_WS_mergeCell(c: TXLSCellRef): integer;
     function Store_WS_colBreaks: integer;
     function Store_WS_rowBreaks: integer;
     function Store_WS_brk(isRow: boolean; location: integer): integer;
     function Store_WS_hyperlinks: integer;
     function Store_WS_hyperlink(hlink: TXLSCustomHyperlink): integer;
     function Store_WS_rels(filename: widestring): integer;
     function Store_WS_sheetProtection: integer;

     function Store_ST_numFmts: integer;
     function Store_ST_fonts: integer;
     function Store_ST_font(index: integer): integer;
     function Store_ST_fills: integer;
     function Store_ST_fill(index: integer): integer;
     function Store_ST_borders: integer;
     function Store_ST_border(index: integer): integer;
     function Store_ST_borderline(tagname: widestring; l:TXLSStyleBorderLine): integer;
     function Store_ST_cellStyleXfs: integer;
     function Store_ST_xf(f: TXLSStyleXF; isStyle: boolean): integer;
     function Store_ST_cellXfs: integer;
     function Store_ST_cellStyles: integer;
     function Store_ST_dxfs: integer;
     function Store_ST_tableStyles: integer;
     function Store_ST_color(tagname: widestring; color: TXLSStyleColor; defColorIndex: longword): integer;
     function Store_ST_indexedColors: integer;
     function ColIndexToAddress(col:integer): AnsiString;
     function EncodeCellRef(row,col:integer): AnsiString;

   public
     constructor Create(Book: TXLSWorkbook; Password: WideString);
     destructor Destroy; override;
     function Save(FileName: WideString): integer; overload;
     function Save(Stream: TStream): integer; overload;
   end;


{To do:

+  cols
+  sheetdata
+  formula
+  formula for biff8
+  palette
+  names
+  merged cells
+  hbreaks
+  vbreaks
+  hyperlinks

  - FileFormat
  + Names
  - VBA projects
  - workbook protection/password
  + print area
  + print title rows
  + print title columns
  + UserDefinedName
  - drawing
  - chart
  - sheet chart
  - file password
  - SupBook
  - external names
  - code page
  + sheet protection/password
  - externs
  - conditional formatting
  - data validation
  - autofilter
  - Comments
  + Date1904 
  + first sheet
  + active sheet
  + ref mode
  + workbook VBAObjectName
  + worksheet VBAObjectName
  + fonts
  + numformats
  + sheet name
  + sheet visible
  + sst
  + palette
  + styles
  + xf
  + cell value 
  +   double
  +   sst value
  +   label
  +   boolean
  +   formula
  +/-   shared formula
  -   array formula
  +   blank
  + merged cells
  + pagesetup margins
  + sheet zoom
  + PageSetup.CenterHorizontally
  + PageSetup.CenterVertically  
  + PageSetup.LeftHeader  
  + PageSetup.CenterHeader
  + PageSetup.RightHeader 
  + Row info
  +   height
  +   hidden
  +   xf   
  +   outline level
  + Col info
  +   width
  +   hidden
  +   xf   
  +   outline level
  + selection
  + panes (freeze, thaw)
  + DisplayGridLines
  + Frozen
  + DisplayZeros
  + DisplayRightToLeft
  + Selected sheet
  + ScrollRow
  + ScrollColumn
  + PageSetup
  +   PaperSize
  +   Zoom 
  +   FitToPagesWide
  +   FitToPagesTall
  +   Orientation
  +   HeaderMargin
  +   FooterMargin
  +   PrintGridlines
  +   PrintHeadings
  + HorizontalPageBreaks
  + VerticalPageBreaks
  + DefColInfo
  + Hyperlinks
  + QuickTip
  + FitToPages
  + Outline.SummaryColumn
  + Outline.SummaryRow

}

const 
  XMLNS_MAIN   = 'http://schemas.openxmlformats.org/spreadsheetml/2006/main';
  XMLNS_RS     = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships';
  XMLNS_RS_WS  = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet';
  XMLNS_RS_OD  = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument';
  XMLNS_RS_ST  = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles';
  XMLNS_RS_SST = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/sharedStrings';
  XMLNS_RS_HL  = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink';

  CT_PKG_RS   = 'application/vnd.openxmlformats-package.relationships+xml';
  CT_OD_MAIN  = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml';
  CT_OD_WS    = 'application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml';
  CT_OD_ST    = 'application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml';
  CT_OD_SST   = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sharedStrings+xml';

function Range2ST_Ref(Range: IXLSRange): widestring;
var r1, c1, r2, c2: integer;
begin
   if Assigned(Range) then begin
      r1 := Range.FirstRow;
      r2 := Range.LastRow;
      c1 := Range.FirstCol;
      c2 := Range.LastCol;
      Result := EncodeCellRange(r1, c1, r2, c2);
   end else begin
      Result := '';
   end;
end;


function SaveXLSXFile(Book: TXLSWorkBook; FileName: WideString; Password: WideString; FileFormat: TXLSFileFormat): integer;
Var Writer: TXLSXWriter;
begin
  Writer := TXLSXWriter.Create(Book, Password);
  try
    Result := Writer.Save(FileName);
  finally
    Writer.Free;
  end; 
end;

function SaveXLSXStream(Book: TXLSWorkBook; Stream: TStream; Password: WideString; FileFormat: TXLSFileFormat): integer;
Var Writer: TXLSXWriter;
begin
  Writer := TXLSXWriter.Create(Book, Password);
  try
    Result := Writer.Save(Stream);
  finally
    Writer.Free;
  end;
end;

constructor TXLSXWriter.Create(Book: TXLSWorkbook; Password: WideString);
begin
  inherited Create;
  FFileWriter := TXLSXFileWriter.Create();
  FMergedCells := TList.Create;
  FBook := Book;
end;

destructor TXLSXWriter.Destroy; 
begin
  FXMLWriter.Free;
  FFileWriter.Free;
  FWBRelations.Free;
  FWSRelations.Free;
  FMergedCells.Free;
  inherited Destroy;
end;

function TXLSXWriter.Save(FileName: WideString): integer;
begin
  FFileWriter.CreateArchive(FileName);
  Result := Store();
end;

function TXLSXWriter.Save(Stream: TStream): integer; 
begin
  FFileWriter.CreateArchive(Stream);
  Result := Store();
end;

function TXLSXWriter.Store: integer;
var cnt: integer;
    
begin
   

   if Not(Assigned(FBook)) then raise Exception.Create('Workbook is not asssigned');
   cnt := FBook.Sheets.Count;
   if cnt = 0 then begin
      FBook.Sheets.Add;
      
   end;

   

   FNeedRecalc := false;
   FWBRelations := TXLSXRelations.Create;
   FWSRelations := TXLSXRelations.Create;
   FBook.InitFormula();
   FBook._Formula.Set2007Settings;

   Result := FillContentTypes;
   if Result >= 0 then Result := Store_SST;
   if Result >= 0 then Result := StoreStyles;
   if Result >= 0 then Result := StoreWorksheets;
   if Result >= 0 then Result := StoreWorkbook();
   if Result >= 0 then Result := Store_WB_rels;
   if Result >= 0 then Result := StoreRootRels;

   FBook._Formula.RestoreSettings;
end;

function TXLSXWriter.FillContentTypes: integer;
begin
   FFileWriter.AddDefaultContentType('rels', CT_PKG_RS);
   FFileWriter.AddDefaultContentType('xml', 'application/xml');
   FFileWriter.AddDefaultContentType('bin', 'application/vnd.openxmlformats-officedocument.spreadsheetml.printerSettings');
   Result := 1;
end;

function TXLSXWriter.CreateXMLWriter(filename: widestring): integer;
begin
  //w riteln('Createxmlwriter ', filename);
  Result := 1;
  if Assigned(FXMLWriter) then begin
     raise Exception.Create('Cannot open other xml Writer');
  end;
//  try 
    FXMLWriter := FFileWriter.CreateXMLFile(filename);
    if Not(Assigned(FXMLWriter)) then begin
       Result := -1;
    end else begin
       //FXMLWriter.Formating := xmlfrmtNone;
    end;
    
//  except
//    Result := -1;
//  end;
end;

procedure TXLSXWriter.CloseXMLWriter;
begin
  if Assigned(FXMLWriter) then begin
     //w riteln('Closexmlwriter ');
     FXMLWriter.Free;
     FXMLWriter := nil;
  end;
end;

procedure TXLSXWriter.SetAttrInt32(attrname: ansistring; Value: integer);
begin
  FXMLWriter.WriteAttributeString('', attrname, '', inttostr(Value), false);
end;

procedure TXLSXWriter.SetAttrString(attrname: ansistring; Value: widestring; Encode: boolean);
begin
  FXMLWriter.WriteAttributeString('', attrname, '', Value, Encode);
end;

procedure TXLSXWriter.SetAttrBoolean(attrname: ansistring; Value: boolean);
begin
   if Value then FXMLWriter.WriteAttributeString('', attrname, '', '1', false)
            else FXMLWriter.WriteAttributeString('', attrname, '', '0', false);
end;

procedure TXLSXWriter.SetAttrDouble(attrname: ansistring; Value: double);
begin
  FXMLWriter.WriteAttributeString('', attrname, '', xlsfloattostr(value, '.'), false);
end;

procedure TXLSXWriter.WriteDouble(Value: double); 
begin
  FXMLWriter.WriteString(floattostr(Value), false);
end;

procedure TXLSXWriter.WriteBoolean(Value: boolean); 
begin
  if Value then FXMLWriter.WriteString('1', false) 
           else FXMLWriter.WriteString('0', false);
end;

procedure TXLSXWriter.WriteInt32(Value: integer); 
begin
  FXMLWriter.WriteString(inttostr(Value), false);
end;

procedure TXLSXWriter.WriteError(Value: integer); 
begin
   case Value of 
      xlsErrorDIV0:  FXMLWriter.WriteString('#DIV/0!', false);
      xlsErrorNA:    FXMLWriter.WriteString('#N/A', false);
      xlsErrorName:  FXMLWriter.WriteString('#NAME?', false);
      xlsErrorNull:  FXMLWriter.WriteString('#NULL!', false);
      xlsErrorNum:   FXMLWriter.WriteString('#NUM!', false);
      xlsErrorRef:   FXMLWriter.WriteString('#REF!', false);
      xlsErrorValue: FXMLWriter.WriteString('#VALUE!', false);
   end;
end;

procedure TXLSXWriter.WriteTextElement(tagname: ansistring; Value: widestring);
var l: integer;
   ch: widechar;
   isPreserve: boolean;
begin
  FXMLWriter.WriteStartElement(tagname);
  l := length(Value);
  if l > 0 then begin
     isPreserve := false;
     ch := Value[1];
     if (ch = #32) or (ch = #13) or (ch= #10) or (ch=#9) then begin
        isPreserve := true; 
     end; 
     if not(isPreserve) then begin
        if l > 1 then begin
           ch := Value[1];
           if (ch = #32) or (ch = #13) or (ch= #10) or (ch=#9) then begin
              isPreserve := true; 
           end; 
        end; 
     end;
     if isPreserve then begin
        SetAttrString('xml:space', 'preserve', false);  
     end; 
  end;  

  FXMLWriter.WriteString(Value, true);
  FXMLWriter.WriteEndElement;
end;

function TXLSXWriter.StoreWorkbook: integer;
var fname: widestring;
begin

  try 
    fname := '/xl/workbook.xml';
    FFileWriter.AddOverrideContentType(fname, CT_OD_MAIN);
    Result := CreateXMLWriter(fname);
    if Result <> 1 then raise Exception.Create('Can''t create ' + fname);
    if Result = 1 then Result := StoreWorkbookHeader;
    if Result = 1 then Result := Store_WB_fileVersion;
    if Result = 1 then Result := Store_WB_fileSharing;
    if Result = 1 then Result := Store_WB_workbookPr;
    if Result = 1 then Result := Store_WB_workbookProtection;
    if Result = 1 then Result := Store_WB_bookViews;
    if Result = 1 then Result := Store_WB_sheets;
    if Result = 1 then Result := Store_WB_externalReferences;
    if Result = 1 then Result := Store_WB_definedNames;
    if Result = 1 then Result := Store_WB_calcPr;

    if Result = 1 then Result := StoreWorkbookFooter;
  finally
    CloseXMLWriter;
  end;
end;

function TXLSXWriter.StoreWorkbookHeader: integer;
begin
  Result := 1;
  FXMLWriter.WriteStartDocument;
  FXMLWriter.WriteStartElement('workbook');
  FXMLWriter.WriteAttributeString('', 'xmlns', '', XMLNS_MAIN, true);
  FXMLWriter.WriteAttributeString('', 'xmlns:r', '',  XMLNS_RS, true);
end;

function TXLSXWriter.StoreWorkbookFooter: integer;
begin
  Result := 1;
  FXMLWriter.WriteEndElement;
  FXMLWriter.WriteEndDocument;
end;


function TXLSXWriter.Store_WB_fileVersion: integer;
begin
  Result := 1;
  FXMLWriter.WriteStartElement('fileVersion');
  SetAttrString('appName', 'xl', false);
  SetAttrString('lastEdited', '4', false);
  SetAttrString('lowestEdited', '4', false);
  SetAttrString('rupBuild', '4505', false);
  FXMLWriter.WriteEndElement;
end;

function TXLSXWriter.Store_WB_workbookPr: integer;
begin
  Result := 1;
  FXMLWriter.WriteStartElement('workbookPr');

  {allowRefreshQuery 
    Specifies a boolean value that indicates whether the application will refresh query table 
    in this workbook. 
    The default value for this attribute is false. 
  }
   
  {autoCompressPictures
    Specifies a boolean value that indicates the application automatically compressed 
    pictures in the workbook. 
    A value of on, 1, or true indicates the application automatically compresses pictures of 
    the workbook. When a picture is compresses, the application: 
      Reduces resolution (to 96 dots per inch (dpi) for Web and 200 dpi for print), and 
    unnecessary information is discarded.  
      Discards extra information. For example, when a picture has been cropped or 
    resized, the "hidden" parts of the picture are stored in the file.  
      Compress the picture, if possible. 
     
    A value of off, 0, or false indicates the application does not compress pictures in this 
    workbook. 
     
    The default value for this attribute is true. 
  } 

  {backupFile 
    Specifies a boolean value that indicates whether the application creates a backup of the 
    workbook on save. 
    The default value for this attribute is false. 
  }

  {checkCompatibility 
    Specifies a boolean value that indicates whether the application checks for compatibility 
    when saving this workbook to older file formats.  
    The default value for this attribute is false. 
  }
  {codeName
    Specifies the codename of the application that created this workbook. Use this attribute 
    to track file content in incremental releases of the application. 
  }
  if FBook._VBAObjectName <> '' then SetAttrString('codeName', FBook._VBAObjectName, true);

  {date1904
    Specifies a boolean value that indicates whether the date systems used in the workbook 
    starts in 1904. 
     
    The default value for this attribute is false. 
  }

  if FBook.Date1904 then SetAttrBoolean('date1904', true);

  {defaultThemeVersion
    Specifies the default version of themes to apply in the workbook. 
     
    The value for defaultThemeVersion depends on the application. SpreadsheetML 
    defaults to the form [version][build], where [version] refers to the version of the 
    application, and [build] refers to the build of the application when the themes in the user
    interface changed. 
  } 

  SetAttrString('defaultThemeVersion', '124226', false);

  {filterPrivacy
    Specifies a boolean value that indicates whether the application has been inspected the 
    workbook for personally identifying information (PII). If this flag is set, the application 
    warns the user any time the user performs do an action that will insert PII into the 
    document. For example, inserting a comment might inserts the user's name. 
    The default value for this attribute is false. 
  }

  {hidePivotFieldList
    Specifies a boolean value that indicates whether a list of fields is shown for pivot tables in 
    the application user interface. 
    The default value for this attribute is false. 
  }
  {promptedSolutions
    Specifies a boolean value that indicates whether the user has received an alert to load 
    Smart Document components. 
    The default value for this attribute is false. 
  }
  {publishItems 
    Specifies a boolean value that indicates whether the publish the workbook or workbook 
    items to the application server. 
    The default value for this attribute is false. 
  }
  {refreshAllConnections
    Specifies a boolean value that indicates whether the workbok shall refresh all the 
    connections to data sources during load. 
  }
  {saveExternalLinkValues
    Specifies a boolean value that indicates whether the application will cache values 
    retrieved from other workbooks via an externally linking formula. Data is cached at save. 
    The default value for this attribute is true. 
  }
   
  {showBorderUnselectedTables
    Specifies a boolean value that indicates whether a border is drawn around unselected 
    tables in the workbook. 
    The default value for this attribute is true. 
  }
   
  {showInkAnnotation
    Specifies a boolean value that indicates whether the book shows ink annotations. 
    The default value for this attribute is true. 
  }

  {showObjects
    Specifies how the application shows embedded objects in the workbook. 
    This attribute it optional. 
    The default value for this attribute is "all." 
    The possible values for this attribute are defined by the ST_Objects simple typ
  }

  {showPivotChartFilter
    Specifies a boolean value that indicates whether filtering options are shown fo
    charts in the workbook. 
    The default value for this attribute is false.
  }

  {updateLinks
    Specifies how the application updates external links when the workbook is opened.  
    The default value for this attribute is userSet. 
    The possible values for this attribute are defined by the ST_UpdateLinks simple type  
  } 

  FXMLWriter.WriteEndElement;
end;


function TXLSXWriter.Store_WB_bookViews: integer;
begin
  FXMLWriter.WriteStartElement('bookViews');
  Result := Store_WB_workbookView;
  FXMLWriter.WriteEndElement;
end;

function TXLSXWriter.Store_WB_workbookView: integer;
begin
  Result := 1;
  FXMLWriter.WriteStartElement('workbookView');

  {activeTab
    Specifies an unsignedInt that contains the index to the active sheet in this book view. 
    The default value for this attribute is 0. 
  }
  if FBook.ActiveSheet.Index > 1 then SetAttrInt32('activeTab', FBook.ActiveSheet.Index - 1);

  {autoFilterDateGrouping
    Specifies a boolean value that indicates whether to group dates when presenting the user 
    with filtering options in the user interface. 
    The default value for this attribute is true. 
  } 

  {firstSheet
    Specifies the index to the first sheet in this book view. 
    The default value for this attribute is 0. 
  }
  if FBook._FirstSheet > 0 then SetAttrInt32('firstSheet', FBook._FirstSheet);

  {minimized 
    Specifies a boolean value that indicates whether the book window is minimized. 
    The default value for this attribute is false. 
  }

  {showHorizontalScroll
    Specifies a boolean value that indicates whether to display the horizontal scroll bar in the 
    user interface. 
    The default value for this attribute is true. 
  }

  {showSheetTabs
    Specifies a boolean value that indicates whether to display the sheet tabs in the user 
    interface. 
    The default value for this attribute is true. 
  }

  {showVerticalScroll 
    Specifies a boolean value that indicates whether to display the vertical scroll bar. 
    The default value for this attribute is true. 
  } 

  {tabRatio
    Specifies ratio between the workbook tabs bar and the horizontal scroll bar. 
    The default value for this attribute is 600. 
  }

  {visibility
    Specifies visible state of the book window. 
    The default value for this attribute is "visible." 
    The possible values for this attribute are defined by the ST_Visibility simple type 
  }

  {xWindow 
    Specifies the X coordinate for the upper left corner of the book window. The unit of 
    measurement for this value is twips. 
  }
  SetAttrString('xWindow', '120', false);

  {yWindow
    Specifies the Y coordinate for the upper left corner of the book window. The unit of 
    measurement for this value is twips. 
  }
  SetAttrString('yWindow', '120', false);

  {windowWidth 
    Specifies the width of the workbook window. The unit of measurement for this value is 
    twips. 
  }
  SetAttrString('windowWidth', '17040', false);

  {windowHeight 
    Specifies the height of the workbook window. The unit of measurement for this value is 
    twips. 
  }
  SetAttrString('windowHeight', '10560', false);
 
  FXMLWriter.WriteEndElement;
end;

function TXLSXWriter.Store_WB_sheets: integer;
var i, cnt: integer;
begin
  Result := 1;
  FXMLWriter.WriteStartElement('sheets');
  cnt := FBook.Sheets.Count;
  if cnt > 0 then begin
     for i := 1 to cnt do begin
        Result := Store_WB_sheet(i);
        if Result <> 1 then break;
     end;
  end;
  FXMLWriter.WriteEndElement;
end;

function TXLSXWriter.Store_WB_sheet(index: integer): integer;
var sheet: IXLSWorksheet;
    visible: integer;
    rid: widestring;
begin
  Result := 1;
  sheet := FBook.Sheets[index];

  FXMLWriter.WriteStartElement('sheet');

  {name
    Specifies the name of the sheet. This name must be unique.  
    This attribute is required. 
  }
  SetAttrString('name', sheet.Name, true);

  {sheetId
    Specifies the internal identifier for the sheet. This identifier must be unique. 
    This attribute is required. 
  }
  SetAttrInt32('sheetId', sheet.FSheetID);

  {state (Visible State)
    Specifies the visible state of this sheet. 
    The default value for this attribute is "visible." 
      hidden, veryHidden, visible
  }
  visible := Sheet.Visible;
  if visible = xlSheetHidden then begin
     SetAttrString('state', 'hidden', false);
  end else if visible = xlSheetVeryHidden then begin
     SetAttrString('state', 'veryHidden', false);
  end;

  {id (Relationship Id) 
    Specifies the identifier of the sheet part where the definition for this sheet is stored. 
    This attribute is required. 
  }
  rid := FWBRelations.AddItem(XMLNS_RS_WS, 'worksheets/sheet' + inttostr(index) + '.xml', '');
  SetAttrString('r:id', rid, false);
  
  FXMLWriter.WriteEndElement;
end;

function TXLSXWriter.Store_WB_rels: integer;
begin
  try 
    Result := CreateXMLWriter('/xl/_rels/workbook.xml.rels');
    if Result <> 1 then raise Exception.Create('Can''t create /xl/_rels/workbook.xml.rels');
    FWBRelations.Store(FXMLWriter); 
  finally
    CloseXMLWriter;
  end;
end;

function TXLSXWriter.Store_WS_rels(filename: widestring): integer;
begin
  Result := 1;
  if FWSRelations.Count > 0 then begin
     try 
       Result := CreateXMLWriter(filename);
       if Result <> 1 then raise Exception.Create('Can''t create ' + filename);
       FWSRelations.Store(FXMLWriter); 
     finally
       CloseXMLWriter;
     end;
  end;
end;


function TXLSXWriter.Store_WB_calcPr: integer;
begin
  Result := 1;
  FXMLWriter.WriteStartElement('calcPr');

  {calcCompleted (Calc Completed) 
     Specifies a boolean value that determines whether workbook data was recalculated 
     before the workbook was saved. 
     The default value for this attribute is true. 
  } 
  
  {calcId (Calculation Id) 
     Specifies the version of the calculation engine used to calculate values in the workbook. 
     When you open a workbook created in the current version, the application recalculates 
     only the formulas that depend on cells that have changed. When you use open a 
     workbook that was created in a earlier version of the application, all the formulas in the 
     workbook- those that depend on cells that have changed and those that do not- are 
     recalculated. This ensures that the workbook is fully optimized for the current application 
     version. 
   
     The value for calcID depends on the application. SpreadsheetML defaults form 
     [version][build], where [version] refers to the version of the application, and [build] 
     refers to the build of the application when the calculation engine changed. 
  } 
  SetAttrString('calcId', '124519', false); 

  {calcMode (Calculation Mode) 
     Specifies when the application should calculate formulas in the workbook. 
     The default value for this attribute is "auto." 
     The possible values for this attribute are defined by the ST_CalcMode simple type 
  }

  {calcOnSave (Calculate On Save) 
     Specifies a boolean value that indicates whether the application will recalculate values 
     when the workbook is saved. 
  }

  {concurrentCalc (Concurrent Calculations) 
     Specifies a boolean value that indicates whether concurrent calculation processes are 
     enabled for this workbook. 
     The default value for this attribute is true. 
  }

  {concurrentManualCount (Concurrent Thread Manual Count) 
     Specifies the count of concurrent calculation processes manually set by the user.  If 
     omitted, the count is set automatically by the application. 
  } 

  {forceFullCalc (Force Full Calculation) 
     Specifies a boolean value that indicates whether the application will perform a full 
     recalculation when one was not indicated by other calculation properties. This attribute 
     allows the application to expose mechanisms in the user interface that give users the 
     ability to trigger when full recalculations take place. 
  } 

  {fullCalcOnLoad (Full Calculation On Load) 
     Specifies a boolean value that indicates whether the application shall perform a full 
     recalculation when the workbook is opened.  After load and successful calculation, the 
     application should set this value to false.  The application should set this value to true 
     when cell formulas or values are modified by another process while the application has 
     the workbook opened. 
     Note: If manual calcMode is true, then a full recalculation will not be performed on load, 
     even when this attribute is set.  
  }

  if FNeedRecalc then SetAttrBoolean('fullCalcOnLoad', FNeedRecalc);

  {fullPrecision (Full Precision Calculation) 
     Specifies a boolean that indicates the precision the application will use when performing 
     calculations in the workbook. Full precision means that the application uses the entire 
     value(s) stored in cells referenced by the formula to perform the calculation. For 
     example, if two cells each contain the value 10.005 and the cells are formatted to display 
     values in currency format, the value $10.01 is displayed in each cell. If you add the two 
     cells together, the result is $20.01 because the application adds the stored values 10.005 
     and 10.005, not the displayed values. You can change the precision of calculations so that 
     the application uses the displayed value instead of the stored value when it recalculates 
     formulas. 
  } 

  {iterate (Calculation Iteration) 
     Specifies a boolean value that indicates whether the application should attempt to 
     calculate formulas that contain circular references. A circular reference is a formula that 
     refers to the cell- either directly or indirectly- that contains the formula. If a formula 
     refers back to one of its own cells, you must determine how many times the formula 
     should recalculate. 
     The default value for this attribute is false. 
  }

  {iterateCount (Iteration Count) 
     Specifies the number of iterations the calculation engine will attempt when calculating a 
     workbook with circular references, when iterate is true. 
      
     The default value for this attribute is 100.
  }

  {iterateDelta (Iterative Calculation Delta) 
     Specifies a double that contains the maximum change for iterative calculations. The 
     application stops calculating after iterateCount iterations or after all values in the 
     circular reference change by less than iterateDelta between iterations, whichever comes 
     first. The default value for this attribute is "0.001" 
  }
   
  {refMode (Reference Mode) 
     Specifies the reference style for this workbook. Instead of using letters for columns and 
     numbers for rows ("A1"), this options enables using numbers for both rows and columns. 
     Cells are then referred to in this format: R1C1. 
      
     The default value for this attribute is "A1." 
  }
  if FBook.ReferenceStyle <> xlA1 then SetAttrString('refMode', 'R1C1', false);

  FXMLWriter.WriteEndElement;
end;

function TXLSXWriter.Store_WB_externalReferences: integer;
begin
  Result := 1;
  //todo
end;

function TXLSXWriter.Store_WB_fileSharing: integer;
begin
  Result := 1;
  //todo
end;

function TXLSXWriter.Store_WB_definedNames: integer;
var nms: TXLSCustomNames;
    cnms: TXLSCustomNames;
    nm: TXLSCustomName;
    i, cnt: integer;
    j, jcnt: integer;
    nameexist: boolean;
begin
  Result := 1;
  nms := FBook._Names;
  nameexist := false;

  if Assigned(nms) then begin
     jcnt := nms.Count;
     if jcnt > 0 then begin
        for j := 1 to jcnt do begin
           nm := nms.Item[j];
           if Assigned(nm) then Store_WB_definedName(nm, 0, nameexist);
        end;
     end;

     cnt := FBook.Sheets.Count;
     for i := 1 to cnt do begin
         Store_WB_PrintArea(i, nameexist);
         Store_WB_PrintTitle(i, nameexist);
         cnms := nms.GetChild(FBook.Sheets[i].FSheetID);
         if Assigned(cnms) then begin
            jcnt := cnms.Count;
            if jcnt > 0 then begin
               for j := 1 to jcnt do begin
                  nm := cnms.Item[j];
                  if Assigned(nm) then Store_WB_definedName(nm, i, nameexist);
               end;
            end;
         end;
     end;

  end;

  if nameexist then begin
     FXMLWriter.WriteEndElement;
  end;

end;

function TXLSXWriter.Store_WB_definedName(nm: TXLSCustomName; sheetindex: integer; var nameexist: boolean): integer;
var name_f: widestring;
begin
  Result := 1;
  if not(nameexist) then begin
     nameexist := true;
     FXMLWriter.WriteStartElement('definedNames');
  end;
  FXMLWriter.WriteStartElement('definedName');
  {comment 
     Specifies the comment the user provided when the name was created. 
  }
  {customMenu 
     Specifies custom menu text for the defined name. 
  }
  {description 
     Specifies description text for the defined name. 
  }
  {function 
     Specifies a boolean value that indicates that the defined name refers to a user-defined 
     function. This attribute is used when there is an add-in or other code project associated 
     with the file. 
  }
  {functionGroupId 
     Specifies the function group index if the defined name refers to a function. The function 
     group defines the general category for the function. This attribute is used when there is 
     an add-in or other code project associated with the file. 
  } 
  {help
     Specifies the help topic to display for this defined name.
  }
  {hidden
     Specifies a boolean value that indicates whether the defined name is hidden in the user
     interface.
  }
  if nm.IsHidden then SetAttrBoolean('hidden', nm.IsHidden);

  {localSheetId
     Specifies the sheet index in this workbook where data from an external reference is
     displayed.
     In the following example, the defined name refers to a range whose data source is an
     external database called "Northwind_Database":
     [Example:
     <definedName name="Northwind_Database"
     localSheetId="2">Sheet5!$A$1:$T$47</definedName>
     end example]
  }
  if sheetindex > 0 then begin
     SetAttrInt32('localSheetId', sheetindex - 1);
  end;

  {name
     Specifies the name that will appear in the user interface for the defined name. This
     attribute is required. The following built-in names are defined in this SpreadsheetML
     specification:
     Print
         _xlnm .Print_Area: this defined name specifies the workbook's print area.
         _xlnm .Print_Titles: this defined name specifies the row(s) or column(s) 
                              to repeat at the top of each printed page.
     Filter & Advanced Filter
        _xlnm .Criteria: this defined name refers to a range containing the criteria values
                         to be used in applying an advanced filter to a range of data.
        _xlnm ._FilterDatabase: can be one of the following
            a. this defined name refers to a range to which an advanced filter has been
               applied. This represents the source data range, unfiltered.
            b. This defined name refers to a range to which an AutoFilter has been
            applied.
        _xlnm .Extract: this defined name refers to the range containing the filtered
            output values resulting from applying an advanced filter criteria to a source
            range.
     Miscellaneous
        _xlnm .Consolidate_Area: the defined name refers to a consolidation area.
        _xlnm .Database: the range specified in the defined name is from a database
                         data source.
        _xlnm .Sheet_Title: the defined name refers to a sheet title.
     Built-in names reserved by SpreadsheetML begin with "_xlnm.". 
     End users shall not use this string for custom names in the user interface.
  }
  SetAttrString('name', nm.Name, true);

  {publishToServer
     Specifies a boolean value that indicates whether the defined name is included in the
     version of the workbook that is published to or rendered on a Web or application server.
  }
  {shortcutKey
     Specifies the keyboard shortcut for the defined name.
  }
  {statusBar
     Specifies text that is displayed on the application status bar when the user places focus
     on the defined name.
  }
  {vbProcedure
     Specified a boolean value that indicates whether the defined name is related to an
     external function, command, or other executable code.
  }
  {workbookParameter
     Specifies a boolean value that indicates that the name is used as a workbook parameter
     on a version of the workbook that is published to or rendered on a Web or application
     server.
  }
  {xlm
     Specifies a boolean value that indicates whether the defined name is related to an
     external function, command, or other executable code.
  }

  name_f := nm.GetRefersTo;
  if length(name_f) > 0 then begin
     name_f := copy(name_f, 2, length(name_f) - 1);
  end;
  FXMLWriter.WriteString(name_f, true);
  FXMLWriter.WriteEndElement;
end;


function TXLSXWriter.Store_WB_PrintArea(sheetindex: integer; var nameexist: boolean): integer;
var pa: widestring;
begin
  Result := 1; 
  if FBook.Sheets[sheetindex].PageSetup.PrintArea <> '' then begin
     
     pa := FBook.Sheets[sheetindex].PageSetup.PrintArea;
     if pos('!', pa) < 1 then begin
        pa := '''' + FBook.Sheets[sheetindex].Name + '''!' + pa;
     end;

     if not(nameexist) then begin
        nameexist := true;
        FXMLWriter.WriteStartElement('definedNames');
     end;
     FXMLWriter.WriteStartElement('definedName');
     SetAttrString('name', '_xlnm.Print_Area', false);
     SetAttrInt32('localSheetId', sheetindex - 1); 
     FXMLWriter.WriteString(pa, true);
     FXMLWriter.WriteEndElement;
  end;
end;

function TXLSXWriter.Store_WB_PrintTitle(sheetindex: integer; var nameexist: boolean): integer;
var ptr: widestring;
    ptc: widestring; 
    f: widestring;
begin
  Result := 1; 
  if (FBook.Sheets[sheetindex].PageSetup.PrintTitleRows <> '') or 
     (FBook.Sheets[sheetindex].PageSetup.PrintTitleColumns <> '') then begin
     
     ptr := FBook.Sheets[sheetindex].PageSetup.PrintTitleRows;
     if ptr <> '' then begin  
        if pos('!', ptr) < 1 then begin
           ptr := '''' + FBook.Sheets[sheetindex].Name + '''!' + ptr;
        end;
     end;

     ptc := FBook.Sheets[sheetindex].PageSetup.PrintTitleColumns;
     if ptc <> '' then begin  
        if pos('!', ptc) < 1 then begin
           ptc := '''' + FBook.Sheets[sheetindex].Name + '''!' + ptc;
        end;
     end;
     f := ptr;
     if ptc <> '' then begin
        if f <> '' then f := f + ',' + ptc
                   else f := ptc;
     end;

     if not(nameexist) then begin
        nameexist := true;
        FXMLWriter.WriteStartElement('definedNames');
     end;

     FXMLWriter.WriteStartElement('definedName');
     SetAttrString('name', '_xlnm.Print_Titles', false);
     SetAttrInt32('localSheetId', sheetindex - 1); 
     FXMLWriter.WriteString(f, true);
     FXMLWriter.WriteEndElement;
  end;
end;

function TXLSXWriter.StoreWorksheets: integer;
var i, cnt: integer;
begin
  Result := 1;
  cnt := FBook.Worksheets.Count;
  if cnt > 0 then begin
     for i := 1 to cnt do begin
         Result := StoreWorksheet(i); 
         if Result < 0 then break;
     end;
  end;
end;

function TXLSXWriter.StoreWorksheet(index: integer): integer;
var filename: widestring;
    fullname: widestring;
begin
  FWSRelations.Clear;
  FSheet := FBook.Sheets[index];
  FActivePane := '';
  filename := 'sheet' + inttostr(index) + '.xml';
  fullname := '/xl/worksheets/' + filename;
  try 
    FFileWriter.AddOverrideContentType(fullname, CT_OD_WS);
    Result := CreateXMLWriter(fullname);
    if Result <> 1 then raise Exception.Create('Can''t create '+ fullname);
    if Result = 1 then Result := StoreWorksheetHeader;

    if Result = 1 then Result := Store_WS_sheetPr;
    if Result = 1 then Result := Store_WS_dimension;
    if Result = 1 then Result := Store_WS_sheetViews;
    if Result = 1 then Result := Store_WS_sheetFormatPr;
    if Result = 1 then Result := Store_WS_cols;
    if Result = 1 then Result := Store_WS_sheetData;
    if Result = 1 then Result := Store_WS_sheetProtection;
    if Result = 1 then Result := Store_WS_mergeCells;
    if Result = 1 then Result := Store_WS_hyperlinks;
    if Result = 1 then Result := Store_WS_printOptions;
    if Result = 1 then Result := Store_WS_pageMargins;
    if Result = 1 then Result := Store_WS_pageSetup;
    if Result = 1 then Result := Store_WS_headerFooter;
    if Result = 1 then Result := Store_WS_rowBreaks;
    if Result = 1 then Result := Store_WS_colBreaks;
    if Result = 1 then Result := Store_WS_drawing;

    if Result = 1 then Result := StoreWorksheetFooter;
  finally
    CloseXMLWriter;
  end;

  if Result = 1 then Result := Store_WS_rels('/xl/worksheets/_rels/' + filename + '.rels');

end;

function TXLSXWriter.StoreWorksheetHeader: integer;
begin
  Result := 1;
  FXMLWriter.WriteStartDocument;
  FXMLWriter.WriteStartElement('worksheet');
  FXMLWriter.WriteAttributeString('', 'xmlns', '', XMLNS_MAIN, true);
  FXMLWriter.WriteAttributeString('', 'xmlns:r', '',  XMLNS_RS, true);
end;

function TXLSXWriter.StoreWorksheetFooter: integer;
begin
  Result := 1;
  FXMLWriter.WriteEndElement;
  FXMLWriter.WriteEndDocument;
end;

function TXLSXWriter.Store_WS_sheetPr: integer;
begin
  Result := 1;
  FXMLWriter.WriteStartElement('sheetPr');
  if FSheet._VBAObjectName <> '' then SetAttrString('codeName', FSheet._VBAObjectName, true);
  {enableFormatConditionsCalculation 
     Flag indicating whether the conditional formatting calculations shall be evaluated. If set
     to false, then the min/max values of color scales or databars or threshold values in Top
     N rules shall not be updated. Essentially the conditional formatting "calc" is off.
     This is useful when conditional formats are being set programmatically at runtime,
     recalculation of the conditional formatting does not need to be done until the program
     execution has finished setting all the conditional formatting properties.
     The possible values for this attribute are defined by the XML Schema boolean datatype.
  }
  {filterMode
     Flag indicating whether the worksheet has one or more autofilters or advanced filters on.
     The possible values for this attribute are defined by the XML Schema boolean datatype.
  }
  {published 
     Flag indicating whether the worksheet is published.
     The possible values for this attribute are defined by the XML Schema boolean datatype. 
  }
  {syncHorizontal
     Flag indicating whether this worksheet is horizontally synced to the synchRef anchor
     point. When true and scroll location is missing from the window properties, the window
     view shall be scrolled to the horizontal (row) aspect of the synchRef value.
     The possible values for this attribute are defined by the XML Schema boolean datatype.
  }
  {syncRef
     Anchor point for worksheet's window.
     The possible values for this attribute are defined by the ST_Ref simple type (3.18.64).  
  }
  {syncVertical
     Flag indicating whether this worksheet is vertically synced to the synchRef anchor point.
     When true and scroll location is missing from the window properties, the window view
     shall be scrolled to the vertical (column) aspect of the synchRef value.
     The possible values for this attribute are defined by the XML Schema boolean datatype.
  }
  {transitionEntry
     Flag indicating whether the Transition Formula Entry (Lotus compatibility) option is
     enabled.
     The possible values for this attribute are defined by the XML Schema boolean datatype.  
  }
  {transitionEvaluation
     Flag indicating whether the Transition Formula Evaluation (Lotus compatibility) option is
     enabled.
     The possible values for this attribute are defined by the XML Schema boolean datatype.
  }

  if Result = 1 then Result := Store_WS_outlinePr;
  //if Result = 1 then Result := Store_WS_tabColor;
  if Result = 1 then Result := Store_WS_pageSetUpPr;
  FXMLWriter.WriteEndElement;
end;

function TXLSXWriter.Store_WS_outlinePr: integer; 
begin
  Result := 1;
  FXMLWriter.WriteStartElement('outlinePr');

  {applyStyles
     Flag indicating whether to apply styles in an outline, when outline is applied. Outline
     styles are described in Styles (3.8).
     The possible values for this attribute are defined by the XML Schema boolean datatype.
  }
  {showOutlineSymbols
     Flag indicating whether the sheet has outline symbols visible. This flag shall always be
     overridden by the showOutlineSymbols attribute on sheetView when there is a conflict.
     The possible values for this attribute are defined by the XML Schema boolean datatype.
  }
  {summaryBelow
     Flag indicating whether summary rows appear below detail in an outline, 
     when applying an outline.
     When true a summary row is inserted below the detailed data being 
     summarized and a new outline level is established on that row.
     When false a summary row is inserted above the detailed data being 
     summarized and a new outline level is established on that row.
     Note that toggling this flag on existing outlines requires an update 
     to cell table, specifically, putting the summary functions in the 
     proper rows, and flagging these rows as new outline levels, 
     and possibly resetting their collapsed state.
     The possible values for this attribute are defined by the XML Schema boolean datatype.
  }
  SetAttrBoolean('summaryBelow', FSheet.Outline.SummaryRow = xlBelow);

  {summaryRight
     Flag indicating whether summary columns appear to the right of detail in 
     an outline, when applying an outline.
     When true a summary column is inserted to the right of the detailed data 
     being summarized and a new outline level is established on that column.
     When false a summary column is inserted to the left of the detailed data 
     being summarized and a new outline level is established on that column.
     Note that toggling this flag on existing outlines requires an update 
     to cell table, specifically, putting the summary functions in the proper 
     columns, and flagging these columns as new outline levels, 
     and possibly resetting their collapsed state.
  }
  SetAttrBoolean('summaryRight', FSheet.Outline.SummaryColumn = xlRight);

  FXMLWriter.WriteEndElement;
end;

function TXLSXWriter.Store_WS_pageSetUpPr: integer;
begin
  Result := 1;
  if FSheet.PageSetup.IsFitToPages then begin
     FXMLWriter.WriteStartElement('pageSetUpPr');

     {autoPageBreaks
        Flag indicating whether the sheet displays Automatic Page Breaks.
        The possible values for this attribute are defined by the XML Schema boolean datatype. 
     }

     {fitToPage
        Flag indicating whether the Fit to Page print option is enabled.
        The possible values for this attribute are defined by the XML Schema boolean datatype.  
     }
//     w riteln('FSheet.PageSetup.IsFitToPages', FSheet.PageSetup.IsFitToPages);
//     w riteln('FSheet.PageSetup.FitToPagesWide', FSheet.PageSetup.FitToPagesWide);
//     w riteln('FSheet.PageSetup.FitToPagesTall', FSheet.PageSetup.FitToPagesTall);
     if FSheet.PageSetup.IsFitToPages then SetAttrBoolean('fitToPage', FSheet.PageSetup.IsFitToPages);

     FXMLWriter.WriteEndElement;
  end;
end;


function TXLSXWriter.Store_WS_dimension: integer;    
var r1, c1, r2, c2: integer;
    ref: widestring;
begin
  Result := 1;
  FXMLWriter.WriteStartElement('dimension');
  with FSheet.UsedRange do begin
     r1 := Row - 1;
     c1 := Column - 1;
     r2 := r1 + integer(Rows.Count) - 1;
     c2 := c1 + integer(Columns.Count) - 1;
  end;
  ref := EncodeCellRange(r1, c1, r2, c2);
  SetAttrString('ref', ref, false);
  FXMLWriter.WriteEndElement;
end;

function TXLSXWriter.Store_WS_sheetViews: integer;
begin
  FXMLWriter.WriteStartElement('sheetViews');
  Result := Store_WS_sheetView;
  FXMLWriter.WriteEndElement;
end;

function TXLSXWriter.Store_WS_sheetView: integer;
var ref: AnsiString;
begin
  Result := 1;
  FXMLWriter.WriteStartElement('sheetView');
  {colorId
     Index to the color value for row/column text headings and gridlines. This is an 'index
     color value' (ICV) rather than rgb value.
     The possible values for this attribute are defined by the XML Schema unsignedInt
     datatype.
  }
  {defaultGridColor
     Flag indicating that the consuming application should use the default grid lines color
     (system dependent). Overrides any color specified in colorId.
     The possible values for this attribute are defined by the XML Schema boolean datatype.
  }
  {rightToLeft
     Flag indicating whether the sheet is in 'right to left' display mode. When in this mode,
     Column A is on the far right, Column B ;is one column left of Column A, and so on. Also,
     information in cells is displayed in the Right to Left format.
     The possible values for this attribute are defined by the XML Schema boolean datatype.
  }
  if FSheet.DisplayRightToLeft then 
     SetAttrBoolean('rightToLeft', FSheet.DisplayRightToLeft);

  {showFormulas
     Flag indicating whether this sheet should display formulas. 
     The possible values for this attribute are defined by the XML Schema boolean datatype.
  }
  {showGridLines
     Flag indicating whether this sheet should display gridlines.
     The possible values for this attribute are defined by the XML Schema boolean datatype.
  }
  if not(FSheet.DisplayGridLines) then 
     SetAttrBoolean('showGridLines', FSheet.DisplayGridLines);

  {showOutlineSymbols
     Flag indicating whether the sheet has outline symbols visible. This flag shall always
     override SheetPr element's outlinePr child element whose attribute is named
     showOutlineSymbols when there is a conflict.
  }
  {showRowColHeaders
     Flag indicating whether the sheet should display row and column headings.  
  }
  {showRuler
     Show the ruler in Page Layout View.  
  }
  {showWhiteSpace
     Flag indicating whether page layout view shall display margins. False means do not
     display left, right, top (header), and bottom (footer) margins (even when there is data in
     the header or footer).  
  }
  {showZeros
     Flag indicating whether the window should show 0 (zero) in cells containing zero value.
     When false, cells with zero value appear blank instead of showing the number zero.  
  }
  if not(FSheet.DisplayZeros) then 
     SetAttrBoolean('showZeros', FSheet.DisplayZeros);

  {tabSelected
     Flag indicating whether this sheet is selected. When only 1 sheet is selected and active,
     this value should be in synch with the activeTab value. In case of a conflict, the Start Part
     setting wins and sets the active sheet tab.
     Note: multiple sheets can be selected, but only one sheet can be active at one time.  
  }
  if FSheet.Selected then 
     SetAttrBoolean('tabSelected', FSheet.Selected);

  {topLeftCell
     Location of the top left visible cell Location of the top left visible cell in the bottom right
     pane (when in Left-to-Right mode).  
  }
  if (FSheet.ScrollRow <> 1) or (FSheet.ScrollColumn <> 1) then begin
     ref := self.EncodeCellRef(FSheet.ScrollRow - 1, FSheet.ScrollColumn - 1);
     if ref <> '' then begin
        FXMLWriter.WriteAttributeAnsiString('topLeftCell', ref);
     end;
  end;

  {view
     Indicates view type.  (normal, pageBreakPreview, pageLayout)
  }
  if FSheet.View = xlPageBreakPreview then begin
     FXMLWriter.WriteAttributeAnsiString('view', 'pageBreakPreview'); 
  end else if FSheet.View = xlPageLayoutView then begin
     FXMLWriter.WriteAttributeAnsiString('view', 'pageLayout'); 
  end;

  {windowProtection
     Flag indicating whether the panes in the window are locked due to workbook protection.
     This is an option when the workbook structure is protected.
     The possible values for this attribute are defined by the XML Schema boolean datatype.  
  }
  {workbookViewId
     Zero-based index of this workbook view, pointing to a workbookView element in the
     bookViews collection.
  }
  SetAttrInt32('workbookViewId', 0);

  {zoomScale
     Window zoom magnification for current view representing percent values. Valid values
     range from 10 to 400. Horizontal & Vertical scale together.
  }
  if FSheet.Zoom <> 100 then begin
     SetAttrInt32('zoomScale', FSheet.Zoom);
  end;
  {zoomScaleNormal
    Zoom magnification to use when in normal view
  }
  {zoomScalePageLayoutView
    Zoom magnification to use when in page layout view
  }
  {zoomScaleSheetLayoutView
    Zoom magnification to use when in page break preview
  }
  if Result = 1 then Result := Store_WS_pane;
  if Result = 1 then Result := Store_WS_selection;

  FXMLWriter.WriteEndElement;
end;


function TXLSXWriter.Store_WS_selection: integer;
var sqref: widestring;
    activecell: AnsiString;
begin
  sqref := Range2ST_Ref(FSheet.Selection);
  if (sqref <> '') and (sqref <> 'A1') then begin
     FXMLWriter.WriteStartElement('selection');
      activecell := self.EncodeCellRef(FSheet.Selection.Row - 1, FSheet.Selection.Column - 1);
      FXMLWriter.WriteAttributeAnsiString('activeCell', activecell);
      SetAttrString('sqref', sqref, false);
      if FActivePane <> '' then begin
         SetAttrString('pane', FActivePane, false);
         FActivePane := '';
      end;
     FXMLWriter.WriteEndElement;
  end;
  Result := 1;
end;

function TXLSXWriter.ColIndexToAddress(col:integer): AnsiString;
var cnt: integer;
    b: array[0..2] of AnsiChar;
begin
   cnt := 0;
   b[2] := AnsiChar((col mod 26) + $41);
   if col > 25 then begin
      col := (col div 26) - 1;
      b[1] := AnsiChar((col mod 26) + $41);
      Inc(cnt);
   end;
   if col > 25 then begin
      col := (col div 26) - 1;
      b[0] := AnsiChar((col mod 26) + $41);
      Inc(cnt);
   end;
   System.SetString(Result, PAnsiChar(@b[2-cnt]), cnt + 1);
end;

function TXLSXWriter.EncodeCellRef(row,col:integer): AnsiString;
var cnt: integer;
    b: array[0..2] of AnsiChar;
begin
   cnt := 0;
   b[2] := AnsiChar((col mod 26) + $41);
   if col > 25 then begin
      col := (col div 26) - 1;
      b[1] := AnsiChar((col mod 26) + $41);
      Inc(cnt);
   end;
   if col > 25 then begin
      col := (col div 26) - 1;
      b[0] := AnsiChar((col mod 26) + $41);
      Inc(cnt);
   end;
   System.SetString(Result, PAnsiChar(@b[2-cnt]), cnt + 1);
   Result := Result + AnsiString(inttostr(row + 1));
end;

function TXLSXWriter.Store_WS_pane: integer;
var rwTop, colLeft: integer;
    xSplit, ySplit: integer;
    state: string;
    isPaneExist: boolean;
    activePane: string;
    topleftcell: AnsiString;
begin

  Result := 1;

  isPaneExist := Assigned(FSheet._Panes);

  if isPaneExist then begin
     if FSheet._Panes.Frozen then begin
        xSplit := Round(FSheet._Panes.X);
        ySplit := Round(FSheet._Panes.Y);
        rwTop := ySplit;
        colLeft := xSplit;
        if FSheet._Panes.RowTop >= 0  then rwTop := FSheet._Panes.RowTop;
        if FSheet._Panes.ColLeft >= 0 then colLeft := FSheet._Panes.ColLeft;
        state := 'frozen';
     end else begin
        //Convert Excel's row and column units to the internal units.
        //The default row height is 12.75
        //The default column width is 8.43
        //The following slope and intersection values were interpolated
        if (FSheet._Panes.Y > 0) or (FSheet._Panes.X > 0) then begin
          ySplit := Round(20 * FSheet._Panes.Y + 255);
          xSplit := Round(113.879 * FSheet._Panes.X + 390);
        end else begin
          xSplit := 0;
          ySplit := 0;
        end;

        rwTop := 0;
        colLeft := 0;
 
        if FSheet._Panes.RowTop > 0  then rwTop   := FSheet._Panes.RowTop;
        if FSheet._Panes.ColLeft > 0 then colLeft := FSheet._Panes.ColLeft;

        state := 'split';
     end;

     if (xSplit > 0) or (ySplit > 0) then begin
        if (xSplit <> 0) and (ySplit <> 0)       then activePane := 'bottomRight'
        else if (xSplit <> 0) and (ySplit = 0)   then activePane := 'topRight'
        else if (xSplit = 0)  and (ySplit <> 0)  then activePane := 'bottomLeft'
        else activePane := 'topLeft';
     end else begin
        isPaneExist := false;
     end;

     if isPaneExist then begin
        FXMLWriter.WriteStartElement('pane');
        {activePane
          The pane that is active. (bottomLeft, bottomRight, topLeft, topRight)
        }
        SetAttrString('activePane', activePane, false);
        FActivePane := activePane;
        {state
          Indicates whether the pane has horizontal / vertical splits, and whether those splits are
          frozen. (frozen, frozenSplit, split)
        }
        SetAttrString('state', state, false);

        {topLeftCell
          Location of the top left visible cell in the bottom right pane
        }
        topleftcell := self.EncodeCellRef(rwTop, colLeft);
        if topleftcell <> '' then begin
           FXMLWriter.WriteAttributeAnsiString('topLeftCell', topleftcell);
        end;

        {xSplit
          Horizontal position of the split, in 1/20th of a point; 0 (zero) if none. 
          If the pane is frozen, this value indicates the number of columns 
          visible in the top pane.
        }
        SetAttrInt32('xSplit', xSplit); 

        {ySplit
          Vertical position of the split, in 1/20th of a point; 0 (zero) if none. 
          If the pane is frozen, this value indicates the number of rows visible 
          in the left pane.
        }
        SetAttrInt32('ySplit', ySplit); 
        
        FXMLWriter.WriteEndElement;
     end;
  end;
end;

function TXLSXWriter.Store_WS_sheetFormatPr: integer;
var //ival: integer;
    dval: double;
begin
  Result := 1;
  FXMLWriter.WriteStartElement('sheetFormatPr');

  {baseColWidth
     Specifies the number of characters of the maximum digit width of the normal style's font.
     This value does not include margin padding or extra padding for gridlines. It is only the
     number of characters.
     See defaultColWidth description in this section for details on calculating this value.
     See the col element description, particularly the width attribute description, for more
     information on what is meant by "maximum digit width".
  }
{  if FSheet.StandardWidth > 0 then begin
     ival := round(Width2Excel(FSheet.StandardWidth) / 296);
     if ival > 0 then begin
        SetAttrInt32('baseColWidth', ival);
     end;
  end;
}

  {customHeight
     'True' if defaultRowHeight value has been manually set, or is different from the default
     value.  
  }
  {defaultColWidth
     Default column width measured as the number of characters of the maximum digit width
     of the normal style's font.
     If the user has not set this manually, then it can be calculated:
     defaultColWidth = baseColumnWidth + (margin padding (2 pixels on each side, totalling
     4 pixels)) + (gridline (1pixel))
     If the user has set this manually, then there is no calculation, and simply a value is
     specified.  
  }

  if (FSheet.StandardWidth > 0) then begin
     dval := (FSheet.StandardWidth * 7 + 5)/7;
     SetAttrDouble('defaultColWidth', dval);
  end;

  {defaultRowHeight
     Default row height measured in point size. Optimization so we don't have to write the
     height on all rows. This can be written out if most rows have custom height, to achieve
     the optimization.
     When the row height of all rows in a sheet is the default value, then that value is written
     here, and customHeight is not set. If a few rows have a different height, that information
     is written directly on each row. However, if most or all of the rows in the sheet have the
     same height, but that height isn't the default height, then that height value should be
     written here (as an optimization), and the customHeight flag should also be set. In this
     case, all rows having this height do not need to express the height, only rows whose
     height differs from this value need to be explicitly expressed.  
  }
  if FSheet.StandardHeight > 0 then begin
     SetAttrDouble('defaultRowHeight', FSheet.StandardHeight);
  end else begin
     SetAttrInt32('defaultRowHeight', 15);
  end;

  {outlineLevelCol
     Highest number of outline levels for columns in this sheet. These values must be in synch
     with the actual sheet outline levels.  
  }
  FSheet._ColumnInfo.CalcMaxOutLineLevel;
  if FSheet._ColumnInfo.MaxOutlineLevel > 0 then 
     SetAttrInt32('outlineLevelCol', FSheet._ColumnInfo.MaxOutlineLevel);

  {outlineLevelRow
     Highest number of outline level for rows in this sheet. These values must be in synch with
     the actual sheet outline levels.  
  }
  FSheet._RowInfo.CalcMaxOutLineLevel;
  if FSheet._RowInfo.MaxOutlineLevel > 0 then 
     SetAttrInt32('outlineLevelRow', FSheet._RowInfo.MaxOutlineLevel);

  {thickBottom
     'True' if rows have a thick bottom border by default.  
  }

  {thickTop
     'True' if rows have a thick top border by default.
  }

  {zeroHeight
     'True' if rows are hidden by default. This setting is an optimization used when most rows
     of the sheet are hidden. In this case, instead of writing out every row and specifying
     hidden, it is much shorter to only write out the rows that are not hidden, and specify
     here that rows are hidden by default, and only not hidden if specified.  
  }

  FXMLWriter.WriteEndElement;
end;

function TXLSXWriter.Store_WS_cols: integer;
var cols: TXLSColumnInfoList;
    si: integer;
    mincol, maxcol: integer;
    c: TXLSColumnInfo;
    colexist: boolean;
begin
  Result := 1;
  cols := FSheet._ColumnInfo;
  si := 0;
  colexist := false;
  while cols.FindNextColToStore(si, mincol, maxcol) do begin
     si := maxcol + 1;
     c := cols.GetColumnInfo(mincol);

     if not(colexist) then begin
        colexist := true;
        FXMLWriter.WriteStartElement('cols');
     end;

     Store_WS_col(c, mincol, maxcol);
  end;

  if colexist then begin
     FXMLWriter.WriteEndElement;
  end;

end;


function TXLSXWriter.Store_WS_col(c: TXLSColumnInfo; mincol, maxcol: integer): integer;
var xf: integer;
    dval: double;
begin
  Result := 1;
 
  FXMLWriter.WriteStartElement('col');

   {bestFit
      Flag indicating if the specified column(s) is set to 'best fit'. 'Best fit' is set to true under
      these conditions:
      The column width has never been manually set by the user, AND
      The column width is not the default width
      'Best fit' means that when numbers are typed into a cell contained in a 'best fit' column,
      the column width should automatically resize to display the number. Note: In best fit
      cases, column width shall not be made smaller, only larger.
   }

   {collapsed
      Flag indicating if the outlining of the affected column(s) is in the collapsed state. See
      description of row collapsed and outlinePr element's summaryBelow and
      summaryRight attributes for detailed information.
   }

   {customWidth
      Flag indicating that the column width for the affected column(s) is different from the
      default or has been manually set.
   }
   //customwidth := AttrValueAsBoolean('customWidth', false);

   {min 
      First column affected by this 'column info' record.
   }
   SetAttrInt32('min', mincol + 1);
   {max 
      Last column affected by this 'column info' record.
   }
   SetAttrInt32('max', maxcol + 1);

   {outlineLevel
      Outline level of affected column(s). Range is 0 to 7. See description of outlinePr
      element's summaryBelow and summaryRight attributes for detailed information.
   }
   if c.OutlineLevel > 1 then begin
      SetAttrInt32('outlineLevel', c.OutlineLevel - 1);
   end;

   {phonetic 
      Flag indicating if the phonetic information should be displayed by default for the affected
      column(s) of the worksheet.
   }

   {style 
      Default style for the affected column(s). Affects cells not yet allocated in the column(s).
      In other words, this style applies to new columns.
   }
   xf := FBook._XFList.SaveIndex[c.XFIndex] - 1;
   if xf >= 0 then begin
      xf := FXFTranslation[xf];
   end;

   if xf > 0 then SetAttrInt32('style', xf);

   {width 
      Column width measured as the number of characters of the maximum digit width of the
      numbers 0, 1, 2, ..., 9 as rendered in the normal style's font. There are 4 pixels of margin
      padding (two on each side), plus 1 pixel padding for the gridlines.
      Note: when wide borders are applied, part of the left/right border shall overlap with the
      2 pixel padding on each side. Wide borders do not affect the width calculation of the
      column.
      Note: When the sheet is in the mode to view formulas instead of values, the pixel width
      of the column is doubled.
   }
   dval := (c.Width * 7 + 5)/7;
   if dval > 0 then begin
      SetAttrDouble('width', dval);
   end;

   {hidden
      Flag indicating if the affected column(s) are hidden on this worksheet.
   }
   if  c.Hidden then SetAttrBoolean('hidden', c.Hidden);
 
   FXMLWriter.WriteEndElement;
end;


function TXLSXWriter.Store_WS_sheetData: integer;
var r: TXLSRowInfo;
    row: integer;
    rows: TXLSRowInfoList;
    sds: char;
    dcs: char;
begin
  Result := 1;
  dcs := '.';
  sds := '.';
  try 
     if {$IFDEF D2011}FormatSettings.{$ENDIF}DecimalSeparator <> dcs then begin
        sds := {$IFDEF D2011}FormatSettings.{$ENDIF}DecimalSeparator;
        {$IFDEF D2011}FormatSettings.{$ENDIF}DecimalSeparator := dcs;
     end;

     FMergedCells.Clear;
     FXMLWriter.WriteStartElement('sheetData');
       rows := FSheet._RowInfo;
       row := 0;
       while true do begin
          row := rows.FindNextRow(row, r);
          if row < 0 then break;
          Store_WS_row(row, r); 
          Inc(row);
       end; 
     FXMLWriter.WriteEndElement;
  finally 
     if sds <> dcs then begin
       {$IFDEF D2011}FormatSettings.{$ENDIF}DecimalSeparator := sds;
     end;
  end;
end;

function TXLSXWriter.Store_WS_mergeCells: integer;
var i, cnt: integer;
begin
  Result := 1;
  cnt := FMergedCells.Count;
  if cnt > 0 then begin
     FXMLWriter.WriteStartElement('mergeCells');
     SetAttrInt32('count', cnt);
     for i := 0 to cnt - 1 do begin
        Store_WS_mergeCell(TXLSCellRef(FMergedCells[i]));
     end;
     FXMLWriter.WriteEndElement;
  end;
end;

function TXLSXWriter.Store_WS_mergeCell(c: TXLSCellRef): integer;
var ref: widestring;
begin
  Result := 1;
  FXMLWriter.WriteStartElement('mergeCell');
  ref := EncodeCellRange(c.Row, c.Col, c.Row + c.MergeRowCount - 1, c.Col + c.MergeColCount - 1);
  SetAttrString('ref', ref, false);
  FXMLWriter.WriteEndElement;
end;


function TXLSXWriter.Store_WS_row(row: integer; r: TXLSRowInfo): integer;
var xf: integer;
    minc, maxc:  integer;
    c: TXLSCellRef;
    ref: AnsiString;
    rowref: AnsiString;
    t: widestring;
    dval: double;
    isdt: boolean;
    ReplaceIndex: boolean;
    f: widestring;
    v: variant;
    res: integer;
    sval: widestring;
begin
  Result := 1;
  FXMLWriter.WriteStartElement('row');

    {r
       Row index. Indicates to which row in the sheet this <row> definition corresponds. 
    }
    rowref := AnsiString(inttostr(row + 1));
    FXMLWriter.WriteAttributeAnsiString('r', rowref);

    {customFormat
       '1' if the row style should be applied. 
    }
    if r.CustomFormat then begin
       SetAttrBoolean('customFormat', r.CustomFormat);
    end;

    {s
       Index to style record for the row (only applied if customFormat attribute is '1') 
    }

    xf := FBook._XFList.SaveIndex[r.XFIndex] - 1;
    if xf >= 0 then begin
       xf := FXFTranslation[xf];
    end;
    if xf > 0 then FXMLWriter.WriteAttributeAnsiString('s', AnsiString(inttostr(xf)));

      {collapsed 
       '1' if the rows 1 level of outlining deeper than the current row are in the collapsed outline
       state. It means that the rows which are 1 outline level deeper (numerically higher value) 
       than the current row are currently hidden due to a collapsed outline state. 
        
       It is possible for collapsed to be false and yet still have the rows in question hidden. 
       This can be achieved by having a lower outline level collapsed, thus hiding all the child 
       rows. 
    }


    {customHeight
       '1' if the row height has been manually set. 
    }
    if r.CustomHeight then SetAttrBoolean('customHeight', r.CustomHeight);

    {ht
       Row height measured in point size. There is no margin padding on row height.
    }
    if r.Height >= 0 then begin
       SetAttrDouble('ht', r.Height);
    end;

    {hidden
       '1' if the row is hidden, e.g., due to a collapsed outline or by manually selecting and 
       hiding a row. 
    }
    if r.Hidden then SetAttrBoolean('hidden', r.Hidden);

    {outlineLevel
       Outlining level of the row, when outlining is on. See description of outlinePr element's 
       summaryBelow and summaryRight attributes for detailed information. 
    }
    if r.OutlineLevel > 1 then begin
       SetAttrInt32('outlineLevel', r.OutlineLevel - 1);
    end;

    {ph
       '1' if the row should show phonetic.
    }

    {spans
       Optimization only, and not required. Specifies the range of non-empty columns (in the 
       format X:Y) for the block of rows to which the current row belongs. To achieve the 
       optimization, span attribute values in a single block should be the same. 
        
       There are 16 rows per block, beginning with the first row. 
        
       Note: this is an optimization, and is purely optional. Different span values within the 
       same row block is allowed. Not writing the span value at all is also allowed. 
        
       Blank rows are not required to write out span values. 
    }

    {thickBot
       '1' if any cell in the row has a medium or thick bottom border, or if any cell in the row 
       directly below the current row has a thick top border. When true and customHeight is 
       false, this flag means that the row height has been adjusted higher by .75 points of the 
       normal style font height. This also means that if the row no longer contains these 
       borders, then the height is automatically re-adjusted down. 
        
       This adjustment is in addition to any adjustment of height due to thickTop. 
        
       Medium borders are these enumeration values from the Styles Part: 
         mediumDashDotDot 
         slantDashDot 
         mediumDashDot 
         mediumDashed 
         medium 
        
       Thick borders are these enumeration values from the Styles Part: 
         thick 
         double  
    }

    {thickTop
       True if the row has a medium or thick top border, or if any cell in the row directly above 
       the current row has a thick bottom border. When true and customHeight is false, this  
       flag means that the row height has been adjusted higher by .75 points of the normal style
       font height. This also means that if the row no longer contains these borders, then the 
       height is automatically re-adjusted down. 
        
       This adjustment is in addition to any adjustment of height due to thickBot. 
        
       Medium borders are these enumeration values from the Styles Part: 
         mediumDashDotDot 
         slantDashDot 
         mediumDashDot 
         mediumDashed 
         medium 
        
       Thick borders are these enumeration values from the Styles Part: 
         thick 
         double 
    }
    minc := r.MinCol;
    maxc := r.MaxCol;
    if (minc >= 0) and (maxc >= 0) then begin
       c := FSheet._CellsHeap.GetFirstRowCell(row);
       while Assigned(c) do begin


           FXMLWriter.WriteStartElement('c');

           {r
              An A1 style reference to the location of this cell 
           }
           ref := self.ColIndexToAddress(c.col) + rowref;
           FXMLWriter.WriteAttributeAnsiString('r', ref);

           {s
              The index of this cell's style. Style records are stored in the Styles Part. 
           }
           xf := FBook._XFList.SaveIndex[c.XFIndex] - 1;
           if xf >= 0 then begin
              xf := FXFTranslation[xf];
           end;
           if xf > 0 then FXMLWriter.WriteAttributeAnsiString('s', AnsiString(inttostr(xf)));

           {cm
              The zero-based index of the cell metadata record associated with this cell. Metadata 
              Index)  information is found in the Metadata Part. Cell metadata is extra information stored at 
              the cell level, and is attached to the cell (travels through moves, copy / paste, clear, etc). 
              Cell metadata is not accessible via formula reference. 
               
              The possible values for this attribute are defined by the XML Schema unsignedInt 
              datatype. 
           }

           {ph
              A Boolean value indicating if the spreadsheet application should show phonetic 
              information.  Phonetic information is displayed in the same cell across the top of the cell 
              and serves as a 'hint' which indicates how the text should be pronounced.  This should 
              only be used for East Asian languages. 
           }

           {t
              An enumeration representing the cell's data type.
                 b (Boolean),  Cell containing a boolean.
                 e (Error)     Cell containing an error.
                 inlineStr     (Inline String) Cell containing an (inline) rich string, 
                               i.e., one not in the shared string table. 
                               If this cell type is used, then the cell value is in the 
                               is element rather than the v element in the cell (c element).
                 n (Number)    Cell containing a number.
                 s (Shared String) Cell containing a shared string.
                 str (String)  Cell containing a formula string.     
           }
           t := '';
           case c.ValueType of 
               xlEmpty: begin 
                    //empty cell
                 end;
               xlString: begin
                    //index to SST
                    SetAttrString('t', 's', false);
                    FXMLWriter.WriteStartElement('v');
                    WriteInt32(FBook._SST.ExtIndex[c.StringIndex]);
                    FXMLWriter.WriteEndElement;
                 end;
               xlDateTime,
               xlDoubleNumber: begin
                    //double number (or it may be a datetime value)
                    dval := c.DoubleValue;
                    if FBook.Date1904 then begin
                       if c.XFIndex > 0 then begin
                          isdt := FBook._XFList.isDateFormat(c.XFIndex);
                       end else begin
                          isdt := FBook._XFList.isDateFormat(FSheet.GetXFIndex(row, c.col, ReplaceIndex));
                       end;
                       if isdt then begin
                          dval := dval - 1462; 
                       end;
                    end;  
                    FXMLWriter.WriteStartElement('v');
                    FXMLWriter.WriteString(floattostr(dval), false);
                    FXMLWriter.WriteEndElement;
                 end;
               xlBoolean: begin
                    //boolean value 
                    SetAttrString('t', 'b', false);
                    FXMLWriter.WriteStartElement('v');
                    WriteBoolean(c.DoubleValue > 0);
                    FXMLWriter.WriteEndElement;
                 end;
               xlFormula: begin
         //           StartTimer(4);
                    f := c.Formula[FSheet];
         //           StopTimer(4);
                    if f <> '' then begin
                       f := Copy(f, 2, Length(f) - 1);
                       res := c.GetCellValue(FSheet, v);
                       if Res = 1 then begin
                          if VarIsNumeric(v) then begin
                             //formula with date or datetime result
                             dval := v;
                             if FBook.Date1904 then begin
                                if c.XFIndex > 0 then begin
                                   isdt := FBook._XFList.isDateFormat(c.XFIndex);
                                end else begin
                                   isdt := FBook._XFList.isDateFormat(FSheet.GetXFIndex(row, c.col, ReplaceIndex));
                                end;
                                if isdt then begin
                                   dval := dval - 1462; 
                                end;
                             end; 
                             FXMLWriter.WriteStartElement('f');
                             FXMLWriter.WriteString(f, true);
                             FXMLWriter.WriteEndElement;
                             FXMLWriter.WriteStartElement('v');
                             WriteDouble(dval);
                             FXMLWriter.WriteEndElement;
                          end else if VarIsBoolean(v) then begin
                             //formula with boolean result
                             SetAttrString('t', 'b', false);
                             FXMLWriter.WriteStartElement('f');
                             FXMLWriter.WriteString(f, true);
                             FXMLWriter.WriteEndElement;
                             FXMLWriter.WriteStartElement('v');
                             WriteBoolean(v);
                             FXMLWriter.WriteEndElement;
                          end else if VarIsNull(v) then begin
                             //formula with empty result
                             FXMLWriter.WriteStartElement('f');
                             FXMLWriter.WriteString(f, true);
                             FXMLWriter.WriteEndElement;
                          end else if VarIsString(v) then begin
                             sval := v;
         {                    if sval = '' then begin
                                //formula with empty result
                                FXMLWriter.WriteStartElement('f');
                                WriteString(f);
                                FXMLWriter.WriteEndElement;
                             end else begin}
                                //formula with string result
                                SetAttrString('t', 'str', false);
                                FXMLWriter.WriteStartElement('f');
                                FXMLWriter.WriteString(f, true);
                                FXMLWriter.WriteEndElement;
                                WriteTextElement('v', sval);
         //                    end;
                          end else begin
                             //formula without result 
                             FXMLWriter.WriteStartElement('f');
                             FXMLWriter.WriteString(f, true);
                             FXMLWriter.WriteEndElement;
                          end;
                       end else begin
                          //not calculated
                          if res in xlsErrors then begin
                             //formula with error 
                             SetAttrString('t', 'e', false);
                             FXMLWriter.WriteStartElement('f');
                             FXMLWriter.WriteString(f, true);
                             FXMLWriter.WriteEndElement;
                             FXMLWriter.WriteStartElement('v');
                             WriteError(res);
                             FXMLWriter.WriteEndElement;
                          end else begin
                             FXMLWriter.WriteStartElement('f');
                             FXMLWriter.WriteString(f, true);
                             FXMLWriter.WriteEndElement;
                             FNeedRecalc := true;
                          end; 
                       end;
                   
                    end;

                 end;   
           end;  

           {vm
                 The zero-based index of the value metadata record associated with this cell's value.
                 Metadata records are stored in the Metadata Part. Value metadata is extra information
                 stored at the cell level, but associated with the value rather than the cell itself. Value
                 metadata is accessible via formula reference.
           }

           FXMLWriter.WriteEndElement;

         //Store_WS_c(c.row, c.col, c);
         if c.Merged and (c = c.MergeCell) then begin
            FMergedCells.Add(c);
         end;
         c := FSheet._CellsHeap.GetNextRowCell(c);
       end; 
    end;

  FXMLWriter.WriteEndElement;
end;

//function TXLSXWriter.Store_WS_c(row, col: integer; c: TXLSCellRef): integer;
//var r: widestring;
//    xf: integer;
//    t: widestring;
//    dval: double;
//    isdt: boolean;
//    ReplaceIndex: boolean;
//    f: widestring;
//    v: variant;
//    res: integer;
//    sval: widestring;
//begin
//  Result := 1;
////  StartTimer(5);
//  FXMLWriter.WriteStartElement('c');
//
//  {r
//     An A1 style reference to the location of this cell 
//  }
//  r := self.EncodeCellRef(row, col);
//  SetAttrString('r', r, false);
//
//  {s
//     The index of this cell's style. Style records are stored in the Styles Part. 
//  }
//  xf := FBook._XFList.SaveIndex[c.XFIndex] - 1;
//  if xf >= 0 then begin
//     xf := FXFTranslation[xf];
//  end;
//  if xf > 0 then SetAttrInt32('s', xf);
//
//  {cm
//     The zero-based index of the cell metadata record associated with this cell. Metadata 
//     Index)  information is found in the Metadata Part. Cell metadata is extra information stored at 
//     the cell level, and is attached to the cell (travels through moves, copy / paste, clear, etc). 
//     Cell metadata is not accessible via formula reference. 
//      
//     The possible values for this attribute are defined by the XML Schema unsignedInt 
//     datatype. 
//  }
//
//  {ph
//     A Boolean value indicating if the spreadsheet application should show phonetic 
//     information.  Phonetic information is displayed in the same cell across the top of the cell 
//     and serves as a 'hint' which indicates how the text should be pronounced.  This should 
//     only be used for East Asian languages. 
//  }
//
//  {t
//     An enumeration representing the cell's data type.
//        b (Boolean),  Cell containing a boolean.
//        e (Error)     Cell containing an error.
//        inlineStr     (Inline String) Cell containing an (inline) rich string, 
//                      i.e., one not in the shared string table. 
//                      If this cell type is used, then the cell value is in the 
//                      is element rather than the v element in the cell (c element).
//        n (Number)    Cell containing a number.
//        s (Shared String) Cell containing a shared string.
//        str (String)  Cell containing a formula string.     
//  }
//  t := '';
//  case c.ValueType of 
//      xlEmpty: begin 
//           //empty cell
//        end;
//      xlString: begin
//           //index to SST
//           SetAttrString('t', 's', false);
//           FXMLWriter.WriteStartElement('v');
//           WriteInt32(FBook._SST.ExtIndex[c.StringIndex]);
//           FXMLWriter.WriteEndElement;
//        end;
//      xlDateTime,
//      xlDoubleNumber: begin
//           //double number (or it may be a datetime value)
//           dval := c.DoubleValue;
//           if FBook.Date1904 then begin
//              if c.XFIndex > 0 then begin
//                 isdt := FBook._XFList.isDateFormat(c.XFIndex);
//              end else begin
//                 isdt := FBook._XFList.isDateFormat(FSheet.GetXFIndex(row, col, ReplaceIndex));
//              end;
//              if isdt then begin
//                 dval := dval - 1462; 
//              end;
//           end;  
//           FXMLWriter.WriteStartElement('v');
//           WriteDouble(dval);
//           FXMLWriter.WriteEndElement;
//        end;
//      xlBoolean: begin
//           //boolean value 
//           SetAttrString('t', 'b', false);
//           FXMLWriter.WriteStartElement('v');
//           WriteBoolean(c.DoubleValue > 0);
//           FXMLWriter.WriteEndElement;
//        end;
//      xlFormula: begin
////           StartTimer(4);
//           f := c.Formula[FSheet];
////           StopTimer(4);
//           if f <> '' then begin
//              f := Copy(f, 2, Length(f) - 1);
//              res := c.GetCellValue(FSheet, v);
//              if Res = 1 then begin
//                 if VarIsNumeric(v) then begin
//                    //formula with date or datetime result
//                    dval := v;
//                    if FBook.Date1904 then begin
//                       if c.XFIndex > 0 then begin
//                          isdt := FBook._XFList.isDateFormat(c.XFIndex);
//                       end else begin
//                          isdt := FBook._XFList.isDateFormat(FSheet.GetXFIndex(row, col, ReplaceIndex));
//                       end;
//                       if isdt then begin
//                          dval := dval - 1462; 
//                       end;
//                    end; 
//                    FXMLWriter.WriteStartElement('f');
//                    FXMLWriter.WriteString(f, true);
//                    FXMLWriter.WriteEndElement;
//                    FXMLWriter.WriteStartElement('v');
//                    WriteDouble(dval);
//                    FXMLWriter.WriteEndElement;
//                 end else if VarIsBoolean(v) then begin
//                    //formula with boolean result
//                    SetAttrString('t', 'b', false);
//                    FXMLWriter.WriteStartElement('f');
//                    FXMLWriter.WriteString(f, true);
//                    FXMLWriter.WriteEndElement;
//                    FXMLWriter.WriteStartElement('v');
//                    WriteBoolean(v);
//                    FXMLWriter.WriteEndElement;
//                 end else if VarIsNull(v) then begin
//                    //formula with empty result
//                    FXMLWriter.WriteStartElement('f');
//                    FXMLWriter.WriteString(f, true);
//                    FXMLWriter.WriteEndElement;
//                 end else if VarIsString(v) then begin
//                    sval := v;
//{                    if sval = '' then begin
//                       //formula with empty result
//                       FXMLWriter.WriteStartElement('f');
//                       WriteString(f);
//                       FXMLWriter.WriteEndElement;
//                    end else begin}
//                       //formula with string result
//                       SetAttrString('t', 'str', false);
//                       FXMLWriter.WriteStartElement('f');
//                       FXMLWriter.WriteString(f, true);
//                       FXMLWriter.WriteEndElement;
//                       WriteTextElement('v', sval);
////                    end;
//                 end else begin
//                    //formula without result 
//                    FXMLWriter.WriteStartElement('f');
//                    FXMLWriter.WriteString(f, true);
//                    FXMLWriter.WriteEndElement;
//                 end;
//              end else begin
//                 //not calculated
//                 if res in xlsErrors then begin
//                    //formula with error 
//                    SetAttrString('t', 'e', false);
//                    FXMLWriter.WriteStartElement('f');
//                    FXMLWriter.WriteString(f, true);
//                    FXMLWriter.WriteEndElement;
//                    FXMLWriter.WriteStartElement('v');
//                    WriteError(res);
//                    FXMLWriter.WriteEndElement;
//                 end else begin
//                    FXMLWriter.WriteStartElement('f');
//                    FXMLWriter.WriteString(f, true);
//                    FXMLWriter.WriteEndElement;
//                    FNeedRecalc := true;
//                 end; 
//              end;
//          
//           end;
//
//        end;   
//  end;  
//
//  {vm
//        The zero-based index of the value metadata record associated with this cell's value.
//        Metadata records are stored in the Metadata Part. Value metadata is extra information
//        stored at the cell level, but associated with the value rather than the cell itself. Value
//        metadata is accessible via formula reference.
//  }
//
//  FXMLWriter.WriteEndElement;
////  StopTimer(5);
//end;


function TXLSXWriter.Store_WS_pageMargins: integer;
begin
  Result := 1;
  FXMLWriter.WriteStartElement('pageMargins');
  with FSheet.PageSetup do begin
     {left
        Left Page Margin in inches.
     }
     SetAttrDouble('left', LeftMargin);
     {right
        Right page margin in inches.
     }
     SetAttrDouble('right', RightMargin);
     {top 
        Top Page Margin in inches.
     }
     SetAttrDouble('top', TopMargin);
     {bottom
        Bottom Page Margin in inches.
     }
     SetAttrDouble('bottom', BottomMargin);
     {header
        Header Page Margin in inches.
     }
     SetAttrDouble('header', HeaderMargin);
     {footer
        Footer Page Margin in inches.
     }
     SetAttrDouble('footer', FooterMargin);
  end;
  FXMLWriter.WriteEndElement;
end;

function TXLSXWriter.Store_WS_pageSetup: integer;
begin
  Result := 1;

  FXMLWriter.WriteStartElement('pageSetup');
  {blackAndWhite
     Print black and white
  }

  {cellComments
     This attribute specifies how to print cell comments. 
     (asDisplayed, atEnd, none) 
  }

  {copies
     Number of copies to print.
  }

  {draft
     Print without graphics.
  }

  {errors
     Specifies how to print cell values for cells with errors.
     ("displayed", "blank", "dash", "NA")
  }

  {firstPageNumber
     Page number for first printed page. If no value is specified, then 'automatic' is assumed.
  }

  {scale    (default 100)
     Print scaling. Valid values range from 10 to 400.
     This setting is overridden when fitToWidth and/or fitToHeight are in use.
  }
  if FSheet.PageSetup.Zoom <> 100 then begin
     SetAttrInt32('scale', FSheet.PageSetup.Zoom);
  end;


  if FSheet.PageSetup.IsFitToPages then begin
     {fitToHeight
        Number of vertical pages to fit on.
     }
     SetAttrInt32('fitToHeight', FSheet.PageSetup.FitToPagesTall);

     {fitToWidth
        Number of horizontal pages to fit on.
     }
     SetAttrInt32('fitToWidth', FSheet.PageSetup.FitToPagesWide);
  end;


  {horizontalDpi
     Horizontal print resolution of the device.
  }
  {id
     Relationship Id of the devMode printer settings part.
  }
  {orientation
     Orientation of the page.("default", "portrait", "landscape")
  }
  if FSheet.PageSetup.Orientation = 1 then begin
     SetAttrString('orientation', 'portrait', false);
  end else if FSheet.PageSetup.Orientation = 2 then begin
     SetAttrString('orientation', 'landscape', false);
  end;
  {pageOrder
     Order of printed pages. (downThenOver, overThenDown)
  }
  {paperSize
     Paper size  (default 1)
  }
  if (FSheet.PageSetup.PaperSize > 1) and (FSheet.PageSetup.PaperSize <> xlPaperUser)  then begin
     SetAttrInt32('paperSize', FSheet.PageSetup.PaperSize);
  end;

  {useFirstPageNumber
     Use firstPageNumber value for first page number, and do not auto number the pages.
  }
  {usePrinterDefaults
     Use the printer's defaults settings for page setup values and don't use the default values
     specified in the schema. For example, if dpi is not present or specified in the XML, the
     application shall not assume 600dpi as specified in the schema as a default and instead
     shall let the printer specify the default dpi.
  }
  {verticalDpi
     Vertical print resolution of the device.
  }
  FXMLWriter.WriteEndElement;

end;

function TXLSXWriter.Store_WS_headerFooter: integer;
var oddHeader: widestring;
    oddFooter: widestring; 
begin
  Result := 1;
   {alignWithMargins   true
      Align header footer margins with page margins. When true, as left/right margins grow
      and shrink, the header and footer edges stay aligned with the margins. When false,
      headers and footers are aligned on the paper edges, regardless of margins.
      todo: AlignMarginsHeaderFooter property
   }
   {differentFirst     false
      Different first page header and footer. When true then firstHeader and firstFooter
      specify first page header and footer values. If false and firstHeader / firstFooter are
      present, they are ignored.
      todo: DifferentFirstPageHeaderFooter property
   }
   {differentOddEven   false
      Different odd and even page headers and footers. When true then oddHeader /
      oddFooter and evenHeader / evenFooter specify page header and footer values for odd
      and even pages. If false then oddHeader / oddFooter is used, even when evenHeader /
      evenFooter are present.
      todo: OddAndEvenPagesHeaderFooter property 
   }
   {scaleWithDoc       true
      Scale header and footer with document scaling.
      todo: ScaleWithDocHeaderFooter property 
   }

   oddFooter := '';
   if FSheet.PageSetup.LeftFooter <> '' then
      oddFooter := oddFooter + '&L' + FSheet.PageSetup.LeftFooter;
   if FSheet.PageSetup.CenterFooter <> '' then
      oddFooter := oddFooter + '&C' + FSheet.PageSetup.CenterFooter;
   if FSheet.PageSetup.RightFooter <> '' then
      oddFooter := oddFooter + '&R' + FSheet.PageSetup.RightFooter;

   oddHeader := '';
   if FSheet.PageSetup.LeftHeader <> '' then
      oddHeader := oddHeader + '&L' + FSheet.PageSetup.LeftHeader;
   if FSheet.PageSetup.CenterHeader <> '' then
      oddHeader := oddHeader + '&C' + FSheet.PageSetup.CenterHeader;
   if FSheet.PageSetup.RightHeader <> '' then
      oddHeader := oddHeader + '&R' + FSheet.PageSetup.RightHeader;

   if (oddFooter <> '') or (oddHeader <> '') then begin
      FXMLWriter.WriteStartElement('headerFooter');
         if oddHeader <> '' then WriteTextElement('oddHeader', oddHeader);
         if oddFooter <> '' then WriteTextElement('oddFooter', oddFooter);
      FXMLWriter.WriteEndElement;
   end;
end;

function TXLSXWriter.Store_WS_drawing: integer;
begin
  Result := 1;
  //todo
  //!!!!
end;

function TXLSXWriter.StoreRootRels: integer;
var r: TXLSXRelations;
begin
   r := nil;
   try 
      Result := CreateXMLWriter('/_rels/.rels');
      if Result <> 1 then raise Exception.Create('Can''t create /_rels/.rels');
      r := TXLSXRelations.Create;
      r.AddItem(XMLNS_RS_OD, 'xl/workbook.xml', '');
      r.Store(FXMLWriter); 
  finally
    CloseXMLWriter;
    r.Free
  end;
end;

function TXLSXWriter.StoreStyles: integer;
var fname: widestring;
begin
  FBook._XFList.CreateAllReferredList(0);

  FWBRelations.AddItem(XMLNS_RS_ST, 'styles.xml', '');
  fname := '/xl/styles.xml';
  try 
    FFileWriter.AddOverrideContentType(fname, CT_OD_ST);
    Result := CreateXMLWriter(fname);
    if Result <> 1 then raise Exception.Create('Can''t create '+ fname);
    if Result = 1 then Result := StoreStylesHeader;

    if Result = 1 then Result := Store_ST_numFmts;
    if Result = 1 then Result := Store_ST_fonts;
    if Result = 1 then Result := Store_ST_fills;
    if Result = 1 then Result := Store_ST_borders;
    if Result = 1 then Result := Store_ST_cellStyleXfs;
    if Result = 1 then Result := Store_ST_cellXfs;
    if Result = 1 then Result := Store_ST_cellStyles;
    if Result = 1 then Result := Store_ST_dxfs;
    if Result = 1 then Result := Store_ST_tableStyles;
    if Result = 1 then Result := Store_ST_indexedColors;

    if Result = 1 then Result := StoreStylesFooter;
  finally
    CloseXMLWriter;
  end;
end;

function TXLSXWriter.StoreStylesHeader: integer;
begin
  Result := 1;
  FXMLWriter.WriteStartDocument;
  FXMLWriter.WriteStartElement('styleSheet');
  FXMLWriter.WriteAttributeString('', 'xmlns', '', XMLNS_MAIN, true);
end;

function TXLSXWriter.StoreStylesFooter: integer;
begin
  Result := 1;
  FXMLWriter.WriteEndElement;
  FXMLWriter.WriteEndDocument;
end;


function TXLSXWriter.Store_ST_fonts: integer;
var i, cnt: integer;
begin
  Result := 1;
  cnt := FBook._XFList.Fonts.ReferredListSize;
  if cnt > 0 then begin
     FXMLWriter.WriteStartElement('fonts');
     SetAttrInt32('count', cnt);
     for i := 1 to cnt do begin
        Result := Store_ST_font(i - 1);
        if Result <> 1 then break;
     end;
     FXMLWriter.WriteEndElement;
  end;
end;

function TXLSXWriter.Store_ST_color(tagname: widestring; color: TXLSStyleColor; defColorIndex: longword): integer;
var cv: longword;
begin
  Result := 1;
  if not(Assigned(color)) then exit;
  if color.IsEqual(0, defColorIndex, 0) then exit;
  FXMLWriter.WriteStartElement(ansistring(tagname));
  case color.ColorType of 
     0: begin
          //indexed
          if color.ColorValue = defColorIndex then begin
             SetAttrBoolean('auto', true);
          end else begin
             SetAttrInt32('indexed', color.ColorValue);
          end;
        end;
     1: begin
          //theme
          SetAttrInt32('theme', color.ColorValue);
        end;
     2: begin
          //rgb
          cv := color.ColorValue;
          cv := $FF000000 or ((cv and $0000FF) shl 16) or (cv and $00FF00) or ((cv and $FF0000) shr 16);
          SetAttrString('rgb', inttohex(cv, 8), false);
        end;
  end;

  if color.TIntAndShade <> 0 then begin
     SetAttrDouble('tint', color.TIntAndShade);
  end;

  FXMLWriter.WriteEndElement;
end;


function TXLSXWriter.Store_ST_font(index: integer): integer;
var f: TXLSStyleFont;
begin
   Result := 1;
   FXMLWriter.WriteStartElement('font');
   f := FBook._XFList.Fonts.GetReferredFont(index);
   //name
   FXMLWriter.WriteStartElement('name');
     SetAttrString('val', f.Name, true);
   FXMLWriter.WriteEndElement;
   //charset
   if f.CharSet <> 0 then begin
      FXMLWriter.WriteStartElement('charset');
        SetAttrInt32('val', f.CharSet);
      FXMLWriter.WriteEndElement;
   end;
   //family
   if f.Family <> 0 then begin
      FXMLWriter.WriteStartElement('family');
        SetAttrInt32('val', f.Family);
      FXMLWriter.WriteEndElement;
   end;
   //b
   if f.Bold then begin
      FXMLWriter.WriteStartElement('b');
      FXMLWriter.WriteEndElement;
   end;
   //i
   if f.Italic then begin
      FXMLWriter.WriteStartElement('i');
      FXMLWriter.WriteEndElement;
   end;
   //strike
   if f.Strikethrough then begin
      FXMLWriter.WriteStartElement('strike');
      FXMLWriter.WriteEndElement;
   end;
   //outline
   if f.OutlineFont then begin
      FXMLWriter.WriteStartElement('outline');
      FXMLWriter.WriteEndElement;
   end;
   //shadow
   if f.Shadow then begin
      FXMLWriter.WriteStartElement('shadow');
      FXMLWriter.WriteEndElement;
   end;
   //condense
   //if f.Condense then begin
   //   FXMLWriter.WriteStartElement('condense');
   //   FXMLWriter.WriteEndElement;
   //end;
   //extend
   //if f.Extend then begin
   //   FXMLWriter.WriteStartElement('extend');
   //   FXMLWriter.WriteEndElement;
   //end;
   //color
   Store_ST_color('color', f.Color, $7FFF);
   //sz
   FXMLWriter.WriteStartElement('sz');
     SetAttrDouble('val', f.Size);
   FXMLWriter.WriteEndElement;
   //u
   if f.Underline <> 0 then begin
      FXMLWriter.WriteStartElement('u');
      case f.Underline of 
          2: SetAttrString('val', 'double', false);
         33: SetAttrString('val', 'singleAccounting', false);
         34: SetAttrString('val', 'doubleAccounting', false);
      end;
      FXMLWriter.WriteEndElement;
   end;
   //vertAlign
   if f.SubScript or f.SuperScript then begin
      FXMLWriter.WriteStartElement('vertAlign');
      if f.SubScript then begin
         SetAttrString('val', 'subscript', false);
      end else begin
         SetAttrString('val', 'superscript', false);
      end;
      FXMLWriter.WriteEndElement;
   end;
   //scheme
   //if f.Scheme <> 0 then begin
   //...
   //end;
   FXMLWriter.WriteEndElement;
end;


function TXLSXWriter.Store_ST_fills: integer;
var i, cnt: integer;
begin
  Result := 1;
  cnt := FBook._XFList.Fills.ReferredListSize;
  if cnt > 0 then begin
     FXMLWriter.WriteStartElement('fills');
     SetAttrInt32('count', cnt);
     for i := 1 to cnt do begin
        Result := Store_ST_fill(i - 1);
        if Result <> 1 then break;
     end;
     FXMLWriter.WriteEndElement;
  end;
end;

function TXLSXWriter.InternalPatternToSTPatternType(pattern: integer): widestring;
begin
  Result := 'none';
  case pattern of
     1:  Result := 'solid';
     2:  Result := 'mediumGray';
     3:  Result := 'darkGray';
     4:  Result := 'lightGray';
     5:  Result := 'darkHorizontal';
     6:  Result := 'darkVertical';
     7:  Result := 'darkDown';
     8:  Result := 'darkUp';
     9:  Result := 'darkGrid';
     10: Result := 'darkTrellis';
     11: Result := 'lightHorizontal';
     12: Result := 'lightVertical';
     13: Result := 'lightDown';
     14: Result := 'lightUp';
     15: Result := 'lightGrid';
     16: Result := 'lightTrellis';
     17: Result := 'gray125';
     18: Result := 'gray0625';
  end;
end;


function TXLSXWriter.Store_ST_fill(index: integer): integer;
var f: TXLSStyleFill;
    patternType: widestring;
begin
   Result := 1;
   FXMLWriter.WriteStartElement('fill');
     f := FBook._XFList.Fills.GetReferredFill(index);
     FXMLWriter.WriteStartElement('patternFill');
        patternType := InternalPatternToSTPatternType(f.PatternType);
        SetAttrString('patternType', patternType, false); 
        if f.PatternType <> 0 then begin
           if f.PatternType = 1 then begin
              if not(f.FgColor.IsEqual(0, 64, 0)) then 
                 Store_ST_color('fgColor', f.FgColor, 64); 
              if not(f.BgColor.IsEqual(0, 65, 0)) then 
                 Store_ST_color('bgColor', f.BgColor, 65); 
           end else begin
              if not(f.FgColor.IsEqual(0, 64, 0)) then 
                 Store_ST_color('fgColor', f.FgColor, 64); 
              if not(f.BgColor.IsEqual(0, 65, 0)) then 
                 Store_ST_color('bgColor', f.BgColor, 65); 
           end;
        end;
     FXMLWriter.WriteEndElement;
   FXMLWriter.WriteEndElement;
end;

function TXLSXWriter.Store_ST_borders: integer;
var i, cnt: integer;
begin
  Result := 1;
  cnt := FBook._XFList.Borders.ReferredListSize;
  if cnt > 0 then begin
     FXMLWriter.WriteStartElement('borders');
     SetAttrInt32('count', cnt);
     for i := 1 to cnt do begin
        Result := Store_ST_border(i - 1);
        if Result <> 1 then break;
     end;
     FXMLWriter.WriteEndElement;
  end;
end;

function TXLSXWriter.Store_ST_border(index: integer): integer;
var b: TXLSStyleBorder;
begin
   Result := 1;
   FXMLWriter.WriteStartElement('border');
     b := FBook._XFList.Borders.GetReferredBorder(index);

     if b.DiagonalUp   then SetAttrBoolean('diagonalUp',   b.DiagonalUp);
     if b.DiagonalDown then SetAttrBoolean('diagonalDown', b.DiagonalDown);

     Store_ST_borderline('left', b.Left);
     Store_ST_borderline('right', b.Right);
     Store_ST_borderline('top', b.Top);
     Store_ST_borderline('bottom', b.Bottom);
     Store_ST_borderline('diagonal', b.Diagonal);
     
   FXMLWriter.WriteEndElement;
end;

function TXLSXWriter.InternalBorderStyleToSTBorderStyle(style: byte): widestring;
begin
  case style of 
       0:  Result := 'none';
       1:  Result := 'thin';
       2:  Result := 'medium';
       3:  Result := 'dashed';
       4:  Result := 'dotted';
       5:  Result := 'thick';
       6:  Result := 'double';
       7:  Result := 'hair';
       8:  Result := 'mediumDashed';
       9:  Result := 'dashDot';
      10:  Result := 'mediumDashDot';
      11:  Result := 'dashDotDot';
      12:  Result := 'mediumDashDotDot';
      13:  Result := 'slantDashDot';
    else   Result := 'none';
  end;
end;

function TXLSXWriter.Store_ST_borderline(tagname: widestring; l:TXLSStyleBorderLine): integer;
begin
   Result := 1;
   FXMLWriter.WriteStartElement(ansistring(tagname));
   if l.Style > 0 then begin
       SetAttrString('style', InternalBorderStyleToSTBorderStyle(l.Style), false);
       Store_ST_color('color', l.Color, 64); 
   end;
   FXMLWriter.WriteEndElement;
end;



function TXLSXWriter.Store_ST_cellStyleXfs: integer;
var cnt, i: integer;
    f: TXLSStyleXF;
    si, ci: integer;
begin
  Result := 1;
  si := 0; ci := 0;
  cnt := FBook._XFList.ReferredListSize;
  if cnt > 0 then begin
     SetLength(FXFTranslation, cnt);
     for i := 0 to cnt - 1 do begin
         f := FBook._XFList.GetReferredXf(i);
         if f.IsStyleXF then begin
            FXFTranslation[i] := si;
            Inc(si);
         end else begin
            FXFTranslation[i] := ci;
            Inc(ci);
         end; 
     end; 
  end;

  FXMLWriter.WriteStartElement('cellStyleXfs');
    if si = 0 then begin
       SetAttrInt32('count', 1);
       FXMLWriter.WriteStartElement('xf');
        SetAttrInt32('numFmtId', 0);
        SetAttrInt32('fontId', 0);
        SetAttrInt32('fillId', 0);
        SetAttrInt32('borderId', 0);
       FXMLWriter.WriteEndElement;
    end else begin
      SetAttrInt32('count', si);
      for i := 0 to cnt - 1 do begin
          f := FBook._XFList.GetReferredXf(i);
          if f.IsStyleXF then begin
             Store_ST_xf(f, true);
          end;
      end; 
    end;
  FXMLWriter.WriteEndElement;
end;

function TXLSXWriter.InternalHAlignToSTHorizontalAlignment(value: integer): widestring;
begin
  case value of 
    0: Result := 'general'         ;
    1: Result := 'left'            ;  
    2: Result := 'center'          ;  
    3: Result := 'right'           ; 
    4: Result := 'fill'            ;
    5: Result := 'justify'         ;  
    6: Result := 'centerContinuous';  
    7: Result := 'distributed'     ; 
    else Result := 'general';
  end;
end;

function TXLSXWriter.InternalVAlignToSTVerticalAlignment(value: integer): widestring;
begin
  case value of 
    0: Result := 'top';
    1: Result := 'center';  
    2: Result := 'bottom';  
    3: Result := 'justify'; 
    4: Result := 'distributed';
    else Result := 'bottom';
  end;
end;

function TXLSXWriter.Store_ST_xf(f: TXLSStyleXF; isStyle: boolean): integer;
var index: integer;
begin
  Result := 1;
  FXMLWriter.WriteStartElement('xf');
  SetAttrInt32('numFmtId', f.NumFormatIndex);

  index := FBook._XFList.Fonts.SaveIndex[f.FontIndex] - 1;
  if index < 0 then index := 0;
  SetAttrInt32('fontId', index);
 
  index := FBook._XFList.Borders.SaveIndex[f.BorderIndex] - 1;
  if index < 0 then index := 0;
  SetAttrInt32('borderId', index);

  index := FBook._XFList.Fills.SaveIndex[f.FillIndex] - 1;
  if index < 0 then index := 0;
  SetAttrInt32('fillId', index);

  if not(isStyle) then begin
     index := 0;
     if f.ParentStyleIndex >= 0 then begin
        index := FBook._XFList.SaveIndex[f.ParentStyleIndex] - 1;
        if index >= 0 then begin
           index := FXFTranslation[index];
        end;
     end;
     if index > 0 then begin
        SetAttrInt32('xfId', index);
     end;
  end;

  if f.ApplyNumFormat  then SetAttrBoolean('applyNumberFormat', f.ApplyNumFormat);
  if f.ApplyFont       then SetAttrBoolean('applyFont',         f.ApplyFont);
  if f.ApplyFill       then SetAttrBoolean('applyFill',         f.ApplyFill);
  if f.ApplyBorder     then SetAttrBoolean('applyBorder',       f.ApplyBorder);

  if f.ApplyAlignment  then SetAttrBoolean('applyAlignment',    f.ApplyAlignment);
  if f.ApplyProtection then SetAttrBoolean('applyProtection',   f.ApplyProtection);

  if (f.ApplyAlignment) and 
     (
       (f.VerAlign <> 2      ) or 
       (f.HorAlign > 0       ) or
       (f.IndentLevel > 0    ) or
       (f.IndentLevel > 0    ) or
       (f.JustifyLastLine    ) or
       (f.ReadingOrder > 0   ) or
       (f.relativeIndent > 0 ) or
       (f.shrinkToFit        ) or
       (f.Orientation > 0    ) or
       (f.wrapText           )
     ) then begin

     FXMLWriter.WriteStartElement('alignment');
       if f.VerAlign <> 2 then begin
          SetAttrString('vertical', InternalVAlignToSTVerticalAlignment(f.VerAlign), false);
       end;
       if f.HorAlign <> 0 then begin
          SetAttrString('horizontal', InternalHAlignToSTHorizontalAlignment(f.HorAlign), false);
       end;

       if f.IndentLevel > 0     then SetAttrInt32('indent',            f.IndentLevel);
       if f.JustifyLastLine     then SetAttrBoolean('justifyLastLine', f.JustifyLastLine);
       if f.ReadingOrder > 0    then SetAttrInt32('readingOrder',      f.ReadingOrder);
       if f.relativeIndent > 0  then SetAttrInt32('relativeIndent',    f.relativeIndent);
       if f.shrinkToFit         then SetAttrBoolean('shrinkToFit',     f.shrinkToFit);
       if f.Orientation > 0     then SetAttrInt32('textRotation',      f.Orientation);
       if f.wrapText            then SetAttrBoolean('wrapText',        f.wrapText);

     FXMLWriter.WriteEndElement;

  end;

  if (f.ApplyProtection) and 
     (f.Hidden or not(f.Locked)) then begin
     FXMLWriter.WriteStartElement('protection');
       if f.Hidden      then SetAttrBoolean('hidden', f.Hidden);
       if not(f.Locked) then SetAttrBoolean('locked', f.Locked);
     FXMLWriter.WriteEndElement;
  end;

  FXMLWriter.WriteEndElement;
end;


function TXLSXWriter.Store_ST_cellXfs: integer;
var cnt, i: integer;
    f: TXLSStyleXF;
    ci: integer;
begin
  Result := 1;

  ci := 0;
  cnt := FBook._XFList.ReferredListSize;
  if cnt > 0 then begin
     for i := 0 to cnt - 1 do begin
         f := FBook._XFList.GetReferredXf(i);
         if not(f.IsStyleXF) then Inc(ci);
     end; 
  end;

  FXMLWriter.WriteStartElement('cellXfs');
    if ci = 0 then begin
       SetAttrInt32('count', 1);
       FXMLWriter.WriteStartElement('xf');
        SetAttrInt32('numFmtId', 0);
        SetAttrInt32('fontId', 0);
        SetAttrInt32('fillId', 0);
        SetAttrInt32('borderId', 0);
       FXMLWriter.WriteEndElement;
    end else begin
      SetAttrInt32('count', ci);
      for i := 0 to cnt - 1 do begin
          f := FBook._XFList.GetReferredXf(i);
          if not(f.IsStyleXF) then begin
             Store_ST_xf(f, false);
          end;
      end; 
    end;
  FXMLWriter.WriteEndElement;
end;

function TXLSXWriter.Store_ST_cellStyles: integer;
var i, cnt: integer;
    s: TXLSStyleEntry;
    xfid: integer;
begin
  Result := 1;
  cnt := FBook._XFList.Styles.Count;
  FXMLWriter.WriteStartElement('cellStyles');
  if cnt > 0 then begin
     SetAttrInt32('count', cnt);
     for i := 0 to cnt - 1 do begin
         s := FBook._XFList.Styles.GetStyleEntry(i);

         FXMLWriter.WriteStartElement('cellStyle');

         if s.Name <> '' then SetAttrString('name', s.Name, true);
         xfid := FBook._XFList.SaveIndex[s.XFIndex] - 1;

         if xfid >= 0 then begin
            xfid := FXFTranslation[xfid];
         end;
         if xfid < 0 then xfid := 0;
         SetAttrInt32('xfId', xfId);

         if s.ILevel >= 0 then SetAttrInt32('iLevel', s.ILevel);
         if s.Custom then SetAttrBoolean('customBuiltin', s.Custom);
         if s.Hidden then SetAttrBoolean('hidden', s.Hidden); 
         if s.BuiltinID >= 0 then SetAttrInt32('builtinId', s.BuiltinID);

         FXMLWriter.WriteEndElement;
     end; 
  end else begin
     SetAttrInt32('count', 1);
     FXMLWriter.WriteStartElement('cellStyle');
      SetAttrString('name', 'General', false);
      SetAttrInt32('xfId', 0);
      SetAttrInt32('builtinId', 0);
     FXMLWriter.WriteEndElement;
  end;
  FXMLWriter.WriteEndElement;
end;

function TXLSXWriter.Store_ST_dxfs: integer;
begin
  Result := 1;
  FXMLWriter.WriteStartElement('dxfs');
  SetAttrInt32('count', 0);
  FXMLWriter.WriteEndElement;
end;

function TXLSXWriter.Store_ST_tableStyles: integer;
begin
  Result := 1;
  FXMLWriter.WriteStartElement('tableStyles');
  SetAttrInt32('count', 0);
  SetAttrString('defaultTableStyle', 'TableStyleMedium9', false);
  SetAttrString('defaultPivotStyle', 'PivotStyleLight16', false);
  FXMLWriter.WriteEndElement;
end;


function TXLSXWriter.Store_ST_numFmts: integer;
Var formatCode: widestring;
    i: integer;
    cnt: Integer;
    fcnt: integer;
begin
 Result := 1;
 cnt := FBook._XFList.Formats.ListSize;
 fcnt := 0;
 if cnt > 0 then begin
    for i := 0 to cnt - 1 do begin
      formatCode := FBook._XFList.Formats.Value[i];
      if (formatCode <> '') and (FBook._XFList.Formats.FmtExists(formatCode)) then begin
         Inc(fcnt);
      end;
    end;
 end;

 if fcnt > 0 then begin 
    FXMLWriter.WriteStartElement('numFmts');
    SetAttrInt32('count', fcnt);
    for i := 0 to cnt - 1 do begin
      formatCode := FBook._XFList.Formats.Value[i];
      if (formatCode <> '') and (FBook._XFList.Formats.FmtExists(formatCode)) then begin
         FXMLWriter.WriteStartElement('numFmt');
            SetAttrInt32('numFmtId', i);
            SetAttrString('formatCode', formatCode, true);
         FXMLWriter.WriteEndElement;
      end;
    end;
    FXMLWriter.WriteEndElement;
 end;

end;

function TXLSXWriter.Store_ST_indexedColors: integer;
var i, cnt: integer;
    cv: longword;
begin
  Result := 1;
  if FBook.ColorManager.PaletteIsChanged then begin
     FXMLWriter.WriteStartElement('colors');
     FXMLWriter.WriteStartElement('indexedColors');
     cnt := 64;
     for i := 1 to cnt do begin
        FXMLWriter.WriteStartElement('rgbColor');
        cv := FBook.ColorManager.Palette[i - 1];
        cv := ((cv and $0000FF) shl 16) or 
              (cv and $00FF00) or 
              ((cv and $FF0000) shr 16);
        SetAttrString('rgb', inttohex(cv, 8), false);
        FXMLWriter.WriteEndElement;
     end;
     FXMLWriter.WriteEndElement;
     FXMLWriter.WriteEndElement;
  end;
end;


function TXLSXWriter.Store_WS_printOptions: integer;
begin
  Result := 1;
  if FSheet.PageSetup.PrintGridlines or
     FSheet.PageSetup.PrintHeadings or
     FSheet.PageSetup.CenterHorizontally or
     FSheet.PageSetup.CenterVertically then begin

     FXMLWriter.WriteStartElement('printOptions');

     {gridLines
        Used in conjunction with gridLinesSet. If both gridLines and gridlinesSet are true, then
        grid lines shall print. Otherwise, they shall not (i.e., one or both have false values).
     }
     if FSheet.PageSetup.PrintGridlines then begin
       SetAttrBoolean('gridLines', FSheet.PageSetup.PrintGridlines); 

       {gridLinesSet
          Used in conjunction with gridLines. If both gridLines and gridLinesSet are true, then
          grid lines shall print. Otherwise, they shall not (i.e., one or both have false values).
       }
       SetAttrBoolean('gridLinesSet', FSheet.PageSetup.PrintGridlines); 
     end;

     {headings
        Print row and column headings.
     }
     if FSheet.PageSetup.PrintHeadings then begin
        SetAttrBoolean('headings', FSheet.PageSetup.PrintHeadings); 
     end;

     {horizontalCentered
        Center on page horizontally when printing.
     }
     if FSheet.PageSetup.CenterHorizontally then begin
        SetAttrBoolean('horizontalCentered', FSheet.PageSetup.CenterHorizontally); 
     end;

     {verticalCentered
        Center on page vertically when printing.
     }
     if FSheet.PageSetup.CenterVertically then begin
        SetAttrBoolean('verticalCentered', FSheet.PageSetup.CenterVertically); 
     end;
     
     FXMLWriter.WriteEndElement;
  end;
end;


function TXLSXWriter.Store_SST: integer;
var sst: TXLSStringTable;
    fname: widestring;
    i, cnt: integer;
begin
  Result := 1;
  sst := FBook._SST;
  sst.InitExtIndex;
  if sst.UniqueCount > 0 then begin
      fname := '/xl/sharedStrings.xml';
      FFileWriter.AddOverrideContentType(fname, CT_OD_SST);
      FWBRelations.AddItem(XMLNS_RS_SST, 'sharedStrings.xml', '');
      try 
        Result := CreateXMLWriter(fname);
        if Result <> 1 then raise Exception.Create('Can''t create '+ fname);
        FXMLWriter.WriteStartDocument;
        FXMLWriter.WriteStartElement('sst');
        FXMLWriter.WriteAttributeString('', 'xmlns', '', XMLNS_MAIN, true);
        SetAttrInt32('count', sst.TotalCount);
        SetAttrInt32('uniqueCount', sst.UniqueCount);
        cnt := sst.StringsCount;

        for i := 1 to cnt do begin
            if sst.ExtIndex[i] >= 0 then begin
               FXMLWriter.WriteStartElement('si');
               WriteTextElement('t', sst.Value[i]);
               FXMLWriter.WriteEndElement;
            end;
        end;

        FXMLWriter.WriteEndElement;
        FXMLWriter.WriteEndDocument;

      finally
        CloseXMLWriter;
      end;
  end;
end;


function TXLSXWriter.Store_WS_colBreaks: integer;
var i, cnt: integer;
begin
  Result := 1;
  {count 
     Number of breaks in the collection.
  }
  {manualBreakCount
     Number of manual breaks in the collection.
  }
  cnt := FSheet.VPageBreaks.Count;
  if cnt > 0 then begin
     FXMLWriter.WriteStartElement('colBreaks');
     SetAttrInt32('count', cnt); 
     SetAttrInt32('manualBreakCount', cnt); 
     for i := 1 to cnt do begin
         Store_WS_brk(false, FSheet.VPageBreaks.Item[i].Location.Column);
     end;
     FXMLWriter.WriteEndElement;
  end;
end;

function TXLSXWriter.Store_WS_rowBreaks: integer;
var i, cnt: integer;
begin
  Result := 1;
  {count 
     Number of breaks in the collection.
  }
  {manualBreakCount
     Number of manual breaks in the collection.
  }
  cnt := FSheet.HPageBreaks.Count;
  if cnt > 0 then begin
     FXMLWriter.WriteStartElement('rowBreaks');
     SetAttrInt32('count', cnt); 
     SetAttrInt32('manualBreakCount', cnt); 
     for i := 1 to cnt do begin
         Store_WS_brk(true, FSheet.HPageBreaks.Item[i].Location.Row);
     end;
     FXMLWriter.WriteEndElement;
  end;
end;

function TXLSXWriter.Store_WS_brk(isRow: boolean; location: integer): integer;
begin
   Result := 1;
   FXMLWriter.WriteStartElement('brk');
   {id
      Zero-based row or column Id of the page break. Breaks occur above the specified row
      and left of the specified column.
   }
   SetAttrInt32('id', location - 1);

   {max 
      Zero-based index of end row or column of the break. 
      For row breaks, specifies column index; 
      for column breaks, specifies row index.
   }
   if isRow then SetAttrInt32('max', $3FFF) 
            else SetAttrInt32('max', $FFFFF); 
   {min
      Zero-based index of start row or column of the break. 
      For row breaks, specifies column index; 
      for column breaks, specifies row index.
   }

   {man
      Manual Break flag.
   }
   SetAttrBoolean('man', true);


   {pt
      Flag indicating that a PivotTable created this break.
   }
   FXMLWriter.WriteEndElement;
end;


function TXLSXWriter.Store_WS_hyperlinks: integer;
var i, cnt: integer;
    hyperlinks: TXLSCustomHyperlinks;
begin
  Result := 1;
  hyperlinks := FSheet._Hyperlinks;
  cnt := 0;
  if Assigned(hyperlinks) then cnt := hyperlinks.Count;
  if cnt > 0 then begin
     FXMLWriter.WriteStartElement('hyperlinks');
     for i := 1 to cnt do begin
        Store_WS_hyperlink(hyperlinks[i]);
     end;
     FXMLWriter.WriteEndElement;
  end;
end;

function TXLSXWriter.Store_WS_hyperlink(hlink: TXLSCustomHyperlink): integer;
var address: widestring;
    rid: widestring;
    ref: widestring;
    range: IXLSRange;
begin
  Result := 1;
  FXMLWriter.WriteStartElement('hyperlink');
  {ref
     Cell location of hyperlink on worksheet. 
  }
  range := IXLSRange(hlink.Range);
  ref := EncodeCellRange(range.FirstRow, range.FirstCol, range.LastRow, range.LastCol);
  SetAttrString('ref', ref, false); 

  {id
     Relationship Id in this sheet's relationships part, expressing the target location of the 
     resource. 
  }
  address := hlink.Address;
  if address <> '' then begin
     rid := FWSRelations.AddItem(XMLNS_RS_HL, address, 'External');
     if rid <> '' then begin
        SetAttrString('r:id', rid, false);
     end;
  end;

  {display
     Display string, if different from string in string table. This is a property on the hyperlink 
     object, but does not need to appear in the spreadsheet application UI. 
  } 
  if hlink.DisplayText <> '' then begin
     SetAttrString('display', hlink.DisplayText, true);
  end;

  {location 
     Location within target. If target is a workbook (or this workbook) this shall refer to a 
     sheet and cell or a defined name. Can also be an HTML anchor if target is HTML file. 
  }
  if hlink.SubAddress <> '' then begin
     SetAttrString('location', hlink.SubAddress, true);
  end;

  {tooltip
     This is additional text to help the user understand more about the hyperlink. This can be 
     displayed as hover text when the mouse is over the link, for example. 
  }
  if hlink.ScreenTip <> '' then begin
     SetAttrString('tooltip', hlink.ScreenTip, true); 
  end;


  FXMLWriter.WriteEndElement;
end;


function TXLSXWriter.Store_WB_workbookProtection: integer;
var isw: boolean;
begin
  Result := 1;
  isw := false;

  if FBook.IsProtected then begin
     isw := true;
     FXMLWriter.WriteStartElement('workbookProtection');
  end;

  if isw then begin
   
  {revisionsPassword (Revisions Password) 
     Specifies the hash of the password required for unlocking revisions in this workbook. 
  }
  {workbookPassword (Workbook Password) 
     Specifies the hash of the password required for unlocking revisions in this workbook.
  } 
  if FBook._Protect.isPassword then begin
     SetAttrString('workbookPassword', inttohex(FBook._Protect.EncodedPassword, 4), false);
  end;
   
  
  {lockRevision (Lock Revisions) 
     Specifies a boolean value that indicates whether the workbook is locked for revisions. 
     The default value for this attribute is false. 
  } 
  {lockStructure (Lock Structure) 
     Specifies a boolean value that indicates whether structure of workbook is locked. 
     The default value for this attribute is false. 
  } 
  {lockWindows (Lock Windows) 
     Specifies a boolean value that indicates whether the windows that comprise the 
     workbook are locked.  The default value for this attribute is false. 
  } 
  if FBook.IsProtected then begin
     SetAttrBoolean('lockStructure', FBook.IsProtected); 
     SetAttrBoolean('lockWindows', FBook.IsProtected); 
  end;

     FXMLWriter.WriteEndElement;
  end;

end;


function TXLSXWriter.Store_WS_sheetProtection: integer;
var isw: boolean;
begin
  Result := 1;
  isw := false;

  if FSheet.IsProtected then begin
     isw := true;
     FXMLWriter.WriteStartElement('sheetProtection');
  end;

  if isw then begin
  {autoFilter (AutoFilter Locked) 
     Autofilters are locked when the sheet is protected. 
  }
   
  {deleteColumns (Delete Columns Locked) 
     Deleting columns is locked when the sheet is protected. 
  }
   
  {deleteRows (Delete Rows Locked) 
     Deleting rows is locked when the sheet is protected. 
  }

  {formatCells (Format Cells Locked) 
     Formatting cells is locked when the sheet is protected. 
  }
   
  {formatColumns (Format Columns Locked) 
     Formatting columns is locked when the sheet is protected. 
  }
   
  {formatRows (Format Rows Locked) 
     Formatting rows is locked when the sheet is protected. 
  }
  {insertColumns (Insert Columns Locked) 
     Inserting columns is locked when the sheet is protected. 
  }

  {insertHyperlinks (Insert Hyperlinks Locked) 
     Inserting hyperlinks is locked when the sheet is protected. 
  }
   
  {insertRows (Insert Rows Locked) 
     Inserting rows is locked when the sheet is protected. 
  }
   
  {objects (Objects Locked) 
     Objects are locked when the sheet is protected. 
  }
   
  {password (Password) 
    Specifies the hash of the password required for editing this worksheet. This protection is 
    optional and may be ignored by applications that choose not to support this 
    functionality.
  }
  if FSheet._Protect.isPassword then begin
     SetAttrString('password', inttohex(FSheet._Protect.EncodedPassword, 4), false);
  end;
   
  {pivotTables (Pivot Tables Locked) 
     Pivot tables are locked when the sheet is protected. 
  } 
  {scenarios (Scenarios Locked) 
     Scenarios are locked when the sheet is protected. 
  }
  {selectLockedCells (Select Locked Cells Locked) 
     Selection of locked cells is locked when the sheet is protected. 
  {selectUnlockedCells (Select Unlocked Cells Locked) 
     Selection of unlocked cells is locked when the sheet is protected. 
  }
  {sheet (Sheet Locked) 
     Sheet is locked when the sheet is protected. 
  }
  
  if FSheet.IsProtected then begin
     SetAttrBoolean('sheet', FSheet.IsProtected); 
     SetAttrBoolean('objects', FSheet.IsProtected); 
     SetAttrBoolean('scenarios', FSheet.IsProtected); 
  end;

  {sort (Sort Locked)  
     Sorting is locked when the sheet is protected. 
  }
     FXMLWriter.WriteEndElement;
  end;

end;


end.
