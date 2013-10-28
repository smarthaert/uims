//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsxread
//
//      Description:  XLSX reader
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
unit xlsxread;
{$Q-}
{$R-}

interface
{$I xlsdef.inc}
uses classes, nExcel;

function OpenXLSXFile(Book: TXLSWorkBook; FileName: WideString; Password: WideString; Var FileFormat: TXLSFileFormat): integer;
function OpenXLSXStream(Book: TXLSWorkBook; Stream: TStream; Password: WideString; Var FileFormat: TXLSFileFormat): integer;


function ST_CellRef2RowCol(celltype: integer; cellref: string; Var row: integer; Var col: integer): boolean;

implementation
uses xlsxfrw, wstream, xmlreader, sysutils, xlshash, math,
     xlsstylecolor, xlsstylefont, xlsstylefill, xlsstyleborder, xlsstylexf,
     xlsxrelations, xlscalc, xlscols, xlsrows, xlsblob;

const
   xlsxoeCantOpenArchive = -2000;

{$I xlsbase.inc}

type

   TXLSMasterSharedCell = class
   private
     FRow: integer;
     FCol: integer;
   public
     constructor Create(r,c: integer);
     property Row: integer read FRow;
     property Col: integer read FCol;
   end;

   TXLSXReader = class
   private
     _tmp: longword;
     FFileReader: TXLSXFileReader;
     FFileFormat: TXLSFileFormat;
     FBook: TXLSWorkbook;
     FSheet: IXLSWorksheet;
     FXMLReader: TXMLReader;
     FWorkbookRelations: TXLSXRelations;
     FWorksheetRelations: TXLSXRelations;
     FIsFitToPages: boolean;
     FSharedFormulaCells: TObjectArray;

     FActiveSheetIndex:   integer;
     FFirstSheetIndex:    integer;

     FStringTable: TWideStringArray;
     FName2RecID: THashInteger;
     FExtraStylesCount: integer;

     function Load: integer;
     procedure FillStyleDefault;
     procedure SharedFormulaCellsClear;

     function  OpenXMLReader(filename: widestring): integer;
     procedure CloseXMLReader;
     procedure InitName2RecId;

     function FindTag(tagname: string): boolean;
     function ReadContent: widestring;
     function AttrValueAsInt32(attrname: string): integer; overload;
     function AttrValueAsInt32(attrname: string; DefaultValue: integer): integer; overload;
     //function AttrValueAsHex(attrname: string): longword; 
     function AttrValueAsHex(attrname: string; DefaultValue: longword): longword;
//     function AttrValueAsBoolean(attrname: string): boolean; overload;
     function AttrValueAsBoolean(attrname: string; DefaultValue: boolean): boolean; //overload;
     function AttrValueAsString(attrname: string): widestring; overload;
     function AttrValueAsString(attrname: string; DefaultValue: widestring): widestring; overload;
     function AttrValueAsDouble(attrname: string): double; overload;
     function AttrValueAsDouble(attrname: string; DefaultValue: double): double; overload;
     procedure MoveToElementEnd;
     procedure MoveToParentElementEnd;

     function ParseSST: integer;
     function ParseWorkbook: integer;
     function ParseWorksheets: integer;
     function ParseWorksheet(fname: widestring): integer;
     function ParseWorkbookRels: integer;
     function ParseWorksheetRels(fname: widestring): integer;
     function ParseStyles: integer;
     function ParseRelations(rel: TXLSXRelations):integer;
     
     function ParseWorkbookRecord(recid: integer): integer;
     function Parse_WB_SHEETS: integer;
     function Parse_WB_BOOKVIEWS: integer;
     function Parse_WB_CALCPR: integer;
     function Parse_WB_WORKBOOKPR: integer;
     function Parse_WB_EXTERNALREFERENCES: integer;
     function Parse_WB_fileSharing: integer;
     function Parse_WB_fileVersion: integer;
     function Parse_WB_definedNames: integer;
     function Parse_WB_definedName: integer;
     function Parse_WB_SetPrintTitles(val: widestring; sheetindex: integer): integer;
     function Parse_WB_workbookProtection: integer;

     function ParseStylesRecord(recid: integer): integer;
     function Parse_ST_numFmts: integer;
     function Parse_ST_fonts: integer;
     function Parse_ST_font(fontindex: integer): integer;
     function Parse_ST_fills: integer;
     function Parse_ST_fill(fillindex: integer): integer;
     function Parse_ST_borders: integer;
     function Parse_ST_border(borderindex: integer): integer;
     function Parse_ST_borderline(bl: TXLSStyleBorderLine): integer;
     function Parse_ST_cellStyleXfs: integer;
     function Parse_ST_cellXfs: integer;
     function Parse_ST_cellStyles: integer;
     function Parse_ST_cellStyle: integer;
     function Parse_ST_xf(xfindex: integer; isStyle: boolean): integer;
     function Parse_ST_colors: integer;
     function Parse_ST_indexedColors: integer;

     function ParseWorksheetRecord(recid: integer): integer;
     function Parse_WS_sheetPr: integer;
     function Parse_WS_outlinePr: integer;
     function Parse_WS_pageSetup: integer;
     function Parse_WS_pageSetupPr: integer;
     function Parse_WS_dimension: integer;
     function Parse_WS_sheetViews: integer; 
     function Parse_WS_pageMargins: integer; 
     function Parse_WS_sheetFormatPr: integer;
     function Parse_WS_sheetView: integer; 
     function Parse_WS_pane: integer;
     function Parse_WS_selection: integer;
     function Parse_WS_cols: integer;
     function Parse_WS_col: integer;
     function Parse_WS_sheetData: integer;
     function Parse_WS_row: integer;
     function Parse_WS_c: integer;
     function Parse_WS_mergeCells: integer;
     function Parse_WS_mergeCell: integer;
     function Parse_WS_f(r, c: integer): integer;
     function Parse_WS_v_n(var value: double): integer;
     function Parse_WS_v_b(var value: boolean): integer;
     function Parse_WS_v_s(var value: integer): integer;
     function Parse_WS_v_str(var value: widestring): integer;
     function Parse_WS_c_is(var value: widestring): integer;
     function Parse_WS_colBreaks: integer;
     function Parse_WS_rowBreaks: integer;
     function Parse_WS_brk(isRow: boolean): integer;
     function Parse_WS_printOptions: integer;
     function Parse_WS_headerFooter: integer;
     function Parse_WS_hyperlinks: integer;
     function Parse_WS_hyperlink: integer;
     function Parse_WS_sheetProtection: integer;

     function SplitHeaderFooter(value: widestring; var Left: widestring; var Center: widestring; var Right: widestring): integer;
     function STPatternTypeToInternalPattern(st_pattern: string): integer;
     function STBorderStyleToInternal(st_bstyle: string): integer;
     function STHorizontalAlignmentToInternal(value: string): integer;
     function STVerticalAlignmentToInternal(value: string): integer;

     function Parse_color(c: TXLSStyleColor; autocolorindex: integer): integer;

     function PostProcess: integer;
     function GetFileData(FileName: widestring): TXLSBlob;
     function LoadVBA: integer;
   public
     constructor Create(Book: TXLSWorkbook; Password: WideString);
     destructor Destroy; override;
     function Open(FileName: WideString): integer; overload;
     function Open(Stream: TStream): integer; overload;
     property FileFormat: TXLSFileFormat read FFileFormat;
   end;


{To do:
  + Date1904 
  - FileFormat
  +!! Names
  - VBA projects
  - workbook protection/password
  + print area
  + print title rows
  + print title columns
  + first sheet
  + active sheet
  + set fonts default count
  + UserDefinedName
  - drawing
  - chart
  - sheet chart
  - file password
  + ref mode
  - SupBook
  - external names
  - code page
  + sheet protection/password
  + workbook VBAObjectName
  + worksheet VBAObjectName
  + fonts
  + numformats
  + sheet name
  + sheet visible
  + sst
  + palette
  - externs
  - conditional formatting
  - data validation
  + styles
  + xf
  + cell value 
  +   double
  +   sst value
  +   label
  +   boolean
  +   formula
  +   shared formula
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
  + PageSetup.LeftFooter  
  + PageSetup.CenterFooter
  + PageSetup.RightFooter 
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
  - autofilter
  + HorizontalPageBreaks
  + VerticalPageBreaks
  + DefColInfo
  - Comments
  + Hyperlinks
  + QuickTip
  + FitToPages
  + Outline.SummaryColumn
  + Outline.SummaryRow

}

const

   RECID_WB_SHEETS          = 1;
   RECID_WB_BOOKVIEWS       = 2;
   RECID_WB_CALCPR          = 3;
   RECID_WB_WORKBOOKPR      = 4;
   RECID_WB_definedNames    = 5;
   RECID_WB_EXTERNALREFERENCES = 6;
   RECID_WB_fileSharing     = 7;
   RECID_WB_fileVersion     = 8;
   RECID_WB_workbookProtection = 9;

   RECID_ST_numFmts         = 101;
   RECID_ST_fonts           = 102;
   RECID_ST_fills           = 103;
   RECID_ST_borders         = 104;
   RECID_ST_cellStyleXfs    = 105;
   RECID_ST_cellXfs         = 106;
   RECID_ST_cellStyles      = 107;
   RECID_ST_colors          = 108;

   RECID_WS_sheetPr         = 1001;
   RECID_WS_pageSetup       = 1002;
   RECID_WS_dimension       = 1003;
   RECID_WS_sheetViews      = 1004;
   RECID_WS_sheetFormatPr   = 1005;
   RECID_WS_pageMargins     = 1006;
   RECID_WS_cols            = 1007;
   RECID_WS_sheetData       = 1008;
   RECID_WS_mergeCells      = 1009;
   RECID_WS_colBreaks       = 1010;
   RECID_WS_rowBreaks       = 1011;
   RECID_WS_printOptions    = 1012;
   RECID_WS_headerFooter    = 1013;
   RECID_WS_hyperlinks      = 1014;
   RECID_WS_sheetProtection = 1015;   

//celltype - 0 - cell
//           1 - first cell, row number or column in the range (ex: A1:B1, $1:$2; $A:$B)
//           2 - second cell, row number or column in the range (ex: A1:B1, $1:$2; $A:$B)
  
function ST_CellRef2RowCol(celltype: integer; cellref: string; Var row: integer; Var col: integer): boolean;
Var i, cnt: integer;
    lrow, lcol: integer;
    ch: char; 
    res: integer;
begin
  lCol   := 0;
  lRow   := 0;
  cnt    := Length(cellref);
  i := 1;
  res := 1;

  //Check length of cellref
  if cnt < 1 then res := -1;

  //column index
  if res >= 0 then begin
     //skip $ 
     if cellref[i] = '$' then begin
        Inc(i);
        if i > cnt then res := -1;
     end;
  end;

  if res = 1 then begin
     ch := cellref[i];
     if ((ch >= 'A') and (ch <= 'Z')) or
        ((ch >= 'a') and (ch <= 'z')) then begin
        while (i <= cnt) and (lcol <= (XLSXMaxCol + 1)) do begin
           ch := cellref[i];
           if (ch >= 'A') and (ch <= 'Z') then begin
              lcol := lcol * 26 + Ord(ch) - $41 + 1;
           end else if (ch >= 'a') and (ch <= 'z') then begin
              lcol := lcol * 26 + Ord(ch) - $61 + 1;
           end else begin
              break;
           end;
           Inc(i);
        end; 
        if (lcol <= 0) or (lcol > (XLSXMaxCol + 1)) then res := -1 else Dec(lcol);
     end else if (ch >= '0') and (ch <= '9') then begin
        //entire rows  
        if celltype = 0 then begin
           res := -1;
        end else if celltype = 2 then begin
           res := 2; 
           lcol := XLSXMaxCol;
        end;
     end else begin
        res := -1;
     end;
  end;

  if res = 1 then begin
     //skip $ 
     if i <= cnt then begin
        if cellref[i] = '$' then begin
           Inc(i);
           if i > cnt then res := -1;
        end;
     end;  
  end;

  if res > 0 then begin 
     if i > cnt then begin
        //entire column
        if celltype = 0 then begin
           res := -1;
        end else if celltype = 2 then begin
           lrow := XLSXMaxRow;  
        end;
     end else begin
        ch := cellref[i];
        if (ch >= '0') and (ch <= '9') then begin
           while (i <= cnt) and (lrow <= (XLSXMaxRow + 1)) do begin
              ch := cellref[i]; 
              if (ch >= '0') and (ch <= '9') then begin 
                 lrow := lrow * 10 + Ord(ch) - $30;
              end else begin
                 res := -1;
                 break;
              end;
              inc(i);
           end;
          if (lrow <= 0) or (lrow > (XLSXMaxRow + 1)) then res := -1 else Dec(lrow);
        end; 
        if i <= cnt then res := -1; 
     end;
  end;

  if res > 0 then begin
     col := lcol;
     row := lrow;
  end;

  Result := (res > 0);
end;

function ST_Ref2RowCols(Value: String; Var r1, c1, r2, c2: integer): boolean;
Var cell1, cell2: String;
    i: integer;
begin
  i := Pos(':', Value);
  if i > 0 then begin
     Cell1 := Copy(Value, 1, i - 1);
     Cell2 := Copy(Value, i + 1, Length(Value) - i);
     Result := ST_CellRef2RowCol(1, Cell1, r1, c1);
     if Result then Result := ST_CellRef2RowCol(2, Cell2, r2, c2);
  end else begin
     Result := ST_CellRef2RowCol(0, Value, r1, c1);
     if Result then begin
        r2 := r1;
        c2 := c1;
     end;
  end;
end;


function OpenXLSXFile(Book: TXLSWorkBook; FileName: WideString; Password: WideString; Var FileFormat: TXLSFileFormat): integer;
Var Reader: TXLSXReader;
begin
  Reader := TXLSXReader.Create(Book, Password);
  try
    Result := Reader.Open(FileName);
    if Result = 1 then FileFormat := Reader.FileFormat;
  finally
    Reader.Free;
  end; 
end;

function OpenXLSXStream(Book: TXLSWorkBook; Stream: TStream; Password: WideString; Var FileFormat: TXLSFileFormat): integer;
Var Reader: TXLSXReader;
begin
  Reader := TXLSXReader.Create(Book, Password);
  try
    Result := Reader.Open(Stream);
    if Result = 1 then FileFormat := Reader.FileFormat;
  finally
    Reader.Free;
  end;
end;

{TXLSMasterSharedCell}
constructor TXLSMasterSharedCell.Create(r,c: integer);
begin
  inherited Create;
  FRow := r;
  FCol := c;
end;

{TXLSXReader}
constructor TXLSXReader.Create(Book: TXLSWorkbook; Password: WideString);
begin
  inherited Create;
  FStringTable := TWideStringArray.Create;
  FFileReader := TXLSXFileReader.Create();
  FWorkbookRelations := TXLSXRelations.Create;
  FWorksheetRelations := TXLSXRelations.Create;
  FBook := Book;
  FName2RecID := THashInteger.Create();
  FActiveSheetIndex   := 0;
  FFirstSheetIndex    := 0;
  FSharedFormulaCells := TObjectArray.Create(true);
end;

destructor TXLSXReader.Destroy; 
begin
  FStringTable.Free;
  FXMLReader.Free;
  FFileReader.Free;
  FName2RecID.Free;
  FWorkbookRelations.Free;
  FWorksheetRelations.Free;
  FSharedFormulaCells.Free;
  inherited Destroy;
end;

function TXLSXReader.Open(FileName: WideString): integer;
begin
  try 
    FFileReader.OpenArchive(FileName);
    Result := Load();
  except
    Result := -1;
  end;
end;

function TXLSXReader.Open(Stream: TStream): integer; 
begin
  try 
    FFileReader.OpenArchive(Stream);
    Result := Load();
  except
    Result := -1;
  end;
end;

procedure TXLSXReader.InitName2RecID;
begin
  //workbook
  FName2RecID['sheets']        := RECID_WB_SHEETS;
  FName2RecID['bookViews']     := RECID_WB_BOOKVIEWS;
  FName2RecID['calcPr']        := RECID_WB_CALCPR;
  FName2RecID['workbookPr']    := RECID_WB_WORKBOOKPR;
  FName2RecID['definedNames']  := RECID_WB_definedNames;
  FName2RecID['externalReferences']  := RECID_WB_EXTERNALREFERENCES;
  FName2RecID['fileSharing']   := RECID_WB_fileSharing;
  FName2RecID['fileVersion']   := RECID_WB_fileVersion;
  FName2RecID['workbookProtection'] := RECID_WB_workbookProtection;

  //styles
  FName2RecID['numFmts']      :=  RECID_ST_numFmts;
  FName2RecID['fonts']        :=  RECID_ST_fonts;
  FName2RecID['fills']        :=  RECID_ST_fills;
  FName2RecID['borders']      :=  RECID_ST_borders;
  FName2RecID['cellStyleXfs'] :=  RECID_ST_cellStyleXfs;
  FName2RecID['cellXfs']      :=  RECID_ST_cellXfs;
  FName2RecID['cellStyles']   :=  RECID_ST_cellStyles;
  FName2RecID['colors']       :=  RECID_ST_colors;

  //worksheet
  FName2RecID['sheetPr']      := RECID_WS_sheetPr;
  FName2RecID['pageSetup']    := RECID_WS_pageSetup;
  FName2RecID['dimension']    := RECID_WS_dimension;
  FName2RecID['sheetViews']   := RECID_WS_sheetViews;
  FName2RecID['sheetFormatPr']:= RECID_WS_sheetFormatPr;
  FName2RecID['pageMargins']  := RECID_WS_pageMargins;
  FName2RecID['cols']         := RECID_WS_cols;
  FName2RecID['sheetData']    := RECID_WS_sheetData;
  FName2RecID['mergeCells']   := RECID_WS_mergeCells;
  FName2RecID['colBreaks']    := RECID_WS_colBreaks;
  FName2RecID['rowBreaks']    := RECID_WS_rowBreaks;
  FName2RecID['printOptions'] := RECID_WS_printOptions;
  FName2RecID['headerFooter'] := RECID_WS_headerFooter;
  FName2RecID['hyperlinks']   := RECID_WS_hyperlinks;
  FName2RecID['sheetProtection'] := RECID_WS_sheetProtection;
end;

function TXLSXReader.Load: integer;
begin
   if Not(Assigned(FBook)) then raise Exception.Create('Workbook is not asssigned');
   FExtraStylesCount := 0;
   FBook._Clear;
   //FBook._XFList.CreateDefault2007;
   try
      FBook.InitFormula();
      FBook._Formula.Set2007Settings;

      FillStyleDefault;
      InitName2RecID;
      Result := ParseSST;
      if Result >= 0 then Result := ParseWorkbook;
      if Result >= 0 then Result := ParseStyles;
      if Result >= 0 then Result := ParseWorkbookRels;
      if Result >= 0 then Result := ParseWorksheets;
      if Result >= 0 then Result := PostProcess; 
      if Result >= 0 then Result := LoadVBA;
   finally
      FBook._Formula.RestoreSettings;
   end;
end;


procedure TXLSXReader.FillStyleDefault;
begin
  FBook._XFList._Clear;
  FBook._XFList.CreateDefault2007;
end;

function TXLSXReader.OpenXMLReader(filename: widestring): integer;
begin
//  w riteln('openxmlreader ', filename);
  Result := 1;
  if Assigned(FXMLReader) then raise Exception.Create('Cannot open other xml reader');
//  try 
    FXMLReader := FFileReader.OpenXMLFile(filename);
    if Not(Assigned(FXMLReader)) then Result := -1;
//  except
//    Result := -1;
//  end;
end;

procedure TXLSXReader.CloseXMLReader;
begin
  if Assigned(FXMLReader) then begin
     //w riteln('closexmlreader ');
     FXMLReader.Free;
     FXMLReader := nil;
  end;
end;

function TXLSXReader.FindTag(tagname: string): boolean;
begin
  Result := false;
  repeat
     if FXMLReader.NodeType = xmlntElement then begin
        if (string(FXMLReader.Name) = tagname) then begin
           Result := true;
           break; 
        end; 
     end; 
  until not(FXMLReader.Read);
end;

function TXLSXReader.ReadContent: widestring;
var depth: integer;
begin
  Result := '';
  FXMLReader.MoveToElement;
  if not(FXMLReader.IsEmptyElement) then begin
     depth := FXMLReader.Depth;
     if FXMLReader.Read then begin
        while (depth < FXMLReader.Depth) do begin
          if (FXMLReader.NodeType = xmlntText) then begin
             Result := Result + FXMLReader.Value;
          end;
          if not(FXMLReader.Read) then raise Exception.Create('Unexpected EOF');
        end;    
        //if (FXMLReader.NodeType = xmlntEndElement) then FXMLReader.Read;
         
     end; 
  end;
end;

function TXLSXReader.AttrValueAsInt32(attrname: string): integer;
begin
  if not(FXMLReader.HasAttributes) then
     raise Exception.Create('Current tag doesn''t have attributes');
  if not(FXMLReader.MoveToAttribute(attrname)) then begin
     raise Exception.Create('Attribute "' + attrname + '" not found');
  end;
  if string(FXMLReader.Name) <> attrname then 
     raise Exception.Create('Attribute "' + attrname + '" not found');
  Result := strtoint(FXMLReader.Value);
end;

function TXLSXReader.AttrValueAsInt32(attrname: string; DefaultValue: integer): integer;
var attrexist: boolean;
begin
  if not(FXMLReader.HasAttributes) then begin
     Result := DefaultValue;
  end else begin
     attrexist := FXMLReader.MoveToAttribute(attrname);
     if attrexist then begin
        if string(FXMLReader.Name) <> attrname then begin
           Result := DefaultValue;
        end else begin
           Result := strtoint(FXMLReader.Value);
        end;
     end else begin
        Result := DefaultValue;
     end;
  end;
end;

function TXLSXReader.AttrValueAsHex(attrname: string; DefaultValue: longword): longword;
var attrexist: boolean;
begin
  if not(FXMLReader.HasAttributes) then begin
     Result := DefaultValue;
  end else begin
     attrexist := FXMLReader.MoveToAttribute(attrname);

     if attrexist then begin
        if string(FXMLReader.Name) <> attrname then begin
           Result := DefaultValue;
        end else begin
           Result := strtoint('$' + FXMLReader.Value);
        end;
     end else begin
        Result := DefaultValue;
     end;
  end;
end;


function TXLSXReader.AttrValueAsBoolean(attrname: string; DefaultValue: boolean): boolean;
var attrexist: boolean;
begin
  if not(FXMLReader.HasAttributes) then begin
     Result := DefaultValue;
  end else begin
     attrexist := FXMLReader.MoveToAttribute(attrname);

     if attrexist then begin
        if string(FXMLReader.Name) <> attrname then begin
           Result := DefaultValue;
        end else begin
           Result := FXMLReader.Value = '1';
        end;
     end else begin
        Result := DefaultValue;
     end;
  end;
end;


function TXLSXReader.AttrValueAsString(attrname: string): widestring;
begin
  if not(FXMLReader.HasAttributes) then
     raise Exception.Create('Current tag doesn''t have attributes');
  if not(FXMLReader.MoveToAttribute(attrname)) then begin
     raise Exception.Create('Attribute "' + attrname + '" not found');
  end;
  if string(FXMLReader.Name) <> attrname then 
     raise Exception.Create('Attribute "' + attrname + '" not found');
  Result := FXMLReader.Value;
end;

function TXLSXReader.AttrValueAsString(attrname: string; DefaultValue: widestring): widestring;
var attrexist: boolean;
begin
  if not(FXMLReader.HasAttributes) then begin
     Result := DefaultValue;
  end else begin
     attrexist := FXMLReader.MoveToAttribute(attrname);

     if attrexist then begin
        if string(FXMLReader.Name) <> attrname then begin
           Result := DefaultValue;
        end else begin
           Result := FXMLReader.Value;
        end;
     end else begin
        Result := DefaultValue;
     end;
  end;
end;

procedure TXLSXReader.MoveToElementEnd;
var tagname: AnsiString;
    depth: integer;
    ok: boolean;
    sk: boolean;
begin
  FXMLReader.MoveToElement;
  if not(FXMLReader.IsEmptyElement) then begin
     depth := FXMLReader.Depth;
     tagname := FXMLReader.Name;
     ok := true;
     sk := false;
     while ok do begin

         if sk then FXMLReader.Skip else ok := FXMLReader.Read;

         sk := false;

         if not(ok) then break;

         if (FXMLReader.NodeType = xmlntEndElement) and 
             (FXMLReader.Depth = depth) and  
             (FXMLReader.Name = tagname) then begin
             break;
         end;

         if (FXMLReader.NodeType = xmlntElement) and
            (FXMLReader.Depth > depth) and 
            not(FXMLReader.IsEmptyElement) then begin
            sk := true;
         end;
     end;
  end;
end;

procedure TXLSXReader.MoveToParentElementEnd;
var 
    depth: integer;
    ok: boolean;
    sk: boolean;
begin
  FXMLReader.MoveToElement;
  depth := FXMLReader.Depth;
  if not(FXMLReader.IsEmptyElement) then begin
     ok := true;
     sk := false;
     while ok do begin

         if sk then FXMLReader.Skip else ok := FXMLReader.Read;
         sk := false;

         if not(ok) then break;

         if (FXMLReader.NodeType = xmlntEndElement) and 
             (FXMLReader.Depth < depth) then begin
             break;
         end;

         if (FXMLReader.NodeType = xmlntElement) and
            (FXMLReader.Depth >= depth) and 
            not(FXMLReader.IsEmptyElement) then begin
            sk := true;
         end;
     end;
  end;
end;

function TXLSXReader.AttrValueAsDouble(attrname: string): double;
begin
  if not(FXMLReader.HasAttributes) then
     raise Exception.Create('Current tag doesn''t have attributes');
  if not(FXMLReader.MoveToAttribute(attrname)) then
     raise Exception.Create('Attribute "' + attrname + '" not found');
  if string(FXMLReader.Name) <> attrname then 
     raise Exception.Create('Attribute "' + attrname + '" not found');
  Result := xlsstrtofloat(FXMLReader.Value, '.');
end;

function TXLSXReader.AttrValueAsDouble(attrname: string; DefaultValue: double): double;
var attrexist: boolean;
begin
  if not(FXMLReader.HasAttributes) then begin
     Result := DefaultValue;
  end else begin
     attrexist := FXMLReader.MoveToAttribute(attrname);

     if attrexist then begin
        if string(FXMLReader.Name) <> attrname then begin
           Result := DefaultValue;
        end else begin
           Result := xlsstrtofloat(FXMLReader.Value, '.');
        end;
     end else begin
        Result := DefaultValue;
     end;
  end;
end;

procedure TXLSXReader.SharedFormulaCellsClear;
begin
  FSharedFormulaCells.Free;
  FSharedFormulaCells := TObjectArray.Create(true);
end;


function TXLSXReader.ParseSST: integer;
var //depth: integer;
    i, uniquecnt: integer;
    txt: widestring;
begin
  try 
    try
      Result := OpenXMLReader('/xl/sharedStrings.xml');
    except 
      Result := 0;
    end;

    if Result <> 1 then Result := 0;

    if Result = 1 then begin
       if not (FindTag('sst')) then begin
          raise Exception.Create('ParseSST: ''sst'' tag not found!');
       end;
//       depth := FXMLReader.Depth;
//       cnt := AttrValueAsInt32('count');
       uniquecnt := AttrValueAsInt32('uniqueCount', 0);
       if uniquecnt > 0 then begin
          for i := 1 to uniquecnt do begin
              if not(FindTag('si')) then raise Exception.Create('ParseSST: ''si'' tag not found!');
              txt := ReadContent();
              FStringTable[i] := txt;
          end;
       end;
    end;   

  finally
    CloseXMLReader;
  end;
end;

function TXLSXReader.ParseWorkbook: integer;
var tagname: WideString;
    recid: integer;
begin
  try 
    Result := OpenXMLReader('/xl/workbook.xml');
    if Result <> 1 then raise Exception.Create('Can''t open /xl/workbook.xml');

    while FXMLReader.Read do begin
       if FXMLReader.NodeType <> xmlntElement then continue;
       tagname := widestring(FXMLReader.Name);
       recid := FName2RecID[tagname];
       if recid > 0 then Result := ParseWorkbookRecord(recid);
    end;

  finally
    CloseXMLReader;
  end;
end;

function TXLSXReader.ParseWorksheet(fname: widestring): integer;
var tagname: widestring;
    recid: integer;
begin
  try 
    Result := OpenXMLReader(fname);
    if Result <> 1 then raise Exception.Create('Can''t open ' + fname);

    FIsFitToPages := false;

    while FXMLReader.Read do begin
       if FXMLReader.NodeType <> xmlntElement then continue;
       tagname := widestring(FXMLReader.Name);
       recid := FName2RecID[tagname];
       if recid > 0 then Result := ParseWorksheetRecord(recid);
    end;

  finally
    CloseXMLReader;
    SharedFormulaCellsClear;
  end;
end;


function TXLSXReader.ParseWorksheets: integer;
var cnt, i: integer;
    rid: widestring;
    fname: widestring;
    rname: widestring;
    tname: widestring;
begin
  Result := 1;
  cnt := FBook.Worksheets.Count;
  if cnt > 0 then begin
     for i := 1 to cnt do begin
         FSheet := FBook.Sheets[i];
         rid := FSheet._RId;
         if FWorkbookRelations.Exists(rid) then begin
            tname := FWorkbookRelations.ById[rid].Target;
            if pos(widestring('worksheets/'), tname) = 1 then begin
               rname := '/xl/worksheets/_rels/' + 
                        copy(tname, 12, length(tname) - 11) + '.rels';
               ParseWorksheetRels(rname);
            end;

            fname := '/xl/' + tname;
            Result := ParseWorksheet(fname);
         end;
         if Result < 0 then break;
     end;
  end;
end;

function TXLSXReader.ParseRelations(rel: TXLSXRelations):integer;
var lid, ltype, ltarget: widestring;
begin
  Result := 1;
  if rel.Count > 0 then rel.Clear;
  while FXMLReader.Read do begin
     if FXMLReader.NodeType <> xmlntElement then continue;
     if FXMLReader.Name = 'Relationship' then begin
        lid     := AttrValueAsString('Id');
        ltype   := AttrValueAsString('Type');
        ltarget := AttrValueAsString('Target');
        rel.Add(lid, ltype, ltarget); 
     end;
  end;
end;

function TXLSXReader.ParseWorkbookRels: integer;
begin
  try 
    Result := OpenXMLReader('/xl/_rels/workbook.xml.rels');
    if Result <> 1 then raise Exception.Create('Can''t open /xl/_rels/workbook.xml.rels');
    Result := ParseRelations(FWorkbookRelations);
  finally
    CloseXMLReader;
  end;
end;

function TXLSXReader.ParseWorksheetRels(fname: widestring): integer;
begin
  try 
    try
       Result := OpenXMLReader(fname);
    except
       Result := -1;
    end;

    if Result = 1 then begin
       Result := ParseRelations(FWorksheetRelations);
    end;

  finally
    CloseXMLReader;
  end;

end;

function TXLSXReader.ParseStyles: integer;
var tagname: widestring;
    recid: integer;
begin
  try 
    Result := OpenXMLReader('/xl/styles.xml');
    if Result <> 1 then raise Exception.Create('Can''t open /xl/styles.xml');

    while FXMLReader.Read do begin
       if FXMLReader.NodeType <> xmlntElement then continue;
       tagname := widestring(FXMLReader.Name);
       recid := FName2RecID[tagname];
       if recid > 0 then begin
          Result := ParseStylesRecord(recid);
       end;
    end;

  finally
    CloseXMLReader;
  end;
end;



function TXLSXReader.ParseWorkbookRecord(recid: integer): integer;
begin
  case recid of 
       RECID_WB_SHEETS:       Result := Parse_WB_SHEETS;
       RECID_WB_BOOKVIEWS:    Result := Parse_WB_BOOKVIEWS;
       RECID_WB_CALCPR:       Result := Parse_WB_CALCPR;
       RECID_WB_WORKBOOKPR:   Result := Parse_WB_WORKBOOKPR;
       RECID_WB_EXTERNALREFERENCES: Result := Parse_WB_EXTERNALREFERENCES; 
       RECID_WB_fileSharing:   Result := Parse_WB_fileSharing; 
       RECID_WB_fileVersion:   Result := Parse_WB_fileVersion; 
       RECID_WB_definedNames:  Result := Parse_WB_definedNames;   
       RECID_WB_workbookProtection: Result := Parse_WB_workbookProtection;
       else Result := 1; //skip
  end;  
end;

function TXLSXReader.ParseWorksheetRecord(recid: integer): integer;
begin
  case recid of 
       RECID_WS_sheetPr:       Result := Parse_WS_sheetPr;
       RECID_WS_pageSetup:     Result := Parse_WS_pageSetup;
       RECID_WS_dimension:     Result := Parse_WS_dimension;
       RECID_WS_sheetViews:    Result := Parse_WS_sheetViews;
       RECID_WS_sheetFormatPr: Result := Parse_WS_sheetFormatPr;
       RECID_WS_pageMargins:   Result := Parse_WS_pageMargins;
       RECID_WS_cols:          Result := Parse_WS_cols;
       RECID_WS_sheetData:     Result := Parse_WS_sheetData;
       RECID_WS_mergeCells:    Result := Parse_WS_mergeCells;
       RECID_WS_colBreaks:     Result := Parse_WS_colBreaks;
       RECID_WS_rowBreaks:     Result := Parse_WS_rowBreaks;
       RECID_WS_printOptions:  Result := Parse_WS_printOptions;
       RECID_WS_headerFooter:  Result := Parse_WS_headerFooter;
       RECID_WS_hyperlinks:    Result := Parse_WS_hyperlinks;
       RECID_WS_sheetProtection: Result := Parse_WS_sheetProtection;
       else Result := 1; //skip
  end;  
end;

function TXLSXReader.Parse_WB_CALCPR: integer;
begin
  if AttrValueAsString('refMode', 'A1') = 'A1' then begin
      FBook.ReferenceStyle := xlA1;
  end else begin
      FBook.ReferenceStyle := xlR1C1;
  end;
  //calcCompleted - Specifies a boolean value that determines whether workbook data was recalculated
  //                before the workbook was saved.
  //calcId - Specifies the version of the calculation engine
  //calcMode
  //calcOnSave
  //concurrentCalc
  //concurrentManualCount
  //forceFullCalc
  //fullCalcOnLoad
  //fullPrecision
  //iterate
  //iterateCount
  //iterateDelta
  Result := 1;
end;

function TXLSXReader.Parse_WB_SHEETS: integer;
var depth: integer;
    sheetname: widestring;
    state: widestring;
begin
  Result := 1;

  if not(FXMLReader.IsEmptyElement) then begin
     depth := FXMLReader.Depth;
     repeat
        if not(FXMLReader.Read) then break;
        if FXMLReader.NodeType <> xmlntElement then continue;
        if FXMLReader.Name = 'sheet' then begin
           sheetname := AttrValueAsString('name');
           With FBook.Sheets.Add() do begin
              Name := sheetname;
              state := AttrValueAsString('state', 'visible');
              _RID := AttrValueAsString('r:id');
              if state = 'hidden'then 
                 Visible := xlSheetHidden
              else if state = 'veryHidden' then 
                 Visible := xlSheetVeryHidden
              else 
                 Visible := xlSheetVisible;
           end;
        end; 
     until depth >= FXMLReader.Depth;
  end;
end;

function TXLSXReader.Parse_WB_BOOKVIEWS: integer;
begin
  FXMLReader.Read;
  if FXMLReader.Name = 'workbookView' then begin 
     //parse workbook view
     FActiveSheetIndex := AttrValueAsInt32('activeTab', 0);
     FFirstSheetIndex := AttrValueAsInt32('firstSheet', 0);
     //autoFilterDateGrouping  0/1
     //minimized 0/1
     //showHorizontalScroll
     //showSheetTabs
     //showVerticalScroll
     //tabRatio
     //visibility
     //windowHeight
     //windowWidth
     //xWindow
     //yWindow
  end;

  Result := 1;
end;

function TXLSXReader.Parse_WB_WORKBOOKPR: integer;
begin
  FBook.Date1904 := (AttrValueAsInt32('date1904', 0) = 1);
  Result := 1;
end;

function TXLSXReader.PostProcess: integer;
begin
  Result := 1;
  FBook.Sheets[FFirstSheetIndex + 1].SetFirstSheet;

  if FActiveSheetIndex < FBook.Sheets.Count then
     FBook.Sheets[FActiveSheetIndex + 1].Activate;

  //!!!! SysNamesApply;
end;


function TXLSXReader.Parse_WB_EXTERNALREFERENCES: integer;
begin
  //!!!!! todo
  Result := 1;
end;

function TXLSXReader.Parse_WB_fileSharing: integer;
begin
  //!!!!! todo
  Result := 1;
end;

function TXLSXReader.Parse_WB_fileVersion: integer;
begin
  //!!!!! todo
  Result := 1;
end;

function TXLSXReader.Parse_WB_definedNames: integer;
var tagname: widestring;
begin
  Result := 1;
  FXMLReader.MoveToElement;
  if not(FXMLReader.IsEmptyElement) then begin
     while FXMLReader.Read do begin
        tagname := widestring(FXMLReader.Name);
        if (FXMLReader.NodeType = xmlntEndElement) and (tagname = 'definedNames') then break;
        if (FXMLReader.NodeType <> xmlntElement) then continue;
        if tagname = 'definedName'   then begin
            Result := Parse_WB_definedName;
        end else MoveToElementEnd;
     end;
  end;
end;


function TXLSXReader.Parse_WB_workbookProtection: integer;
var password: widestring;
    phash: word;  
    ls, lw: boolean;
begin
  Result := 1;
  {revisionsPassword (Revisions Password) 
     Specifies the hash of the password required for unlocking revisions in this workbook. 
  }
  {workbookPassword (Workbook Password) 
     Specifies the hash of the password required for unlocking revisions in this workbook.
  } 
  password := AttrValueAsString('workbookPassword', ''); 
  if password <> '' then begin
     phash := strtoint('$' + password); 
     FBook._Protect.ProtectEncode(phash);
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
  ls := AttrValueAsBoolean('lockStructure', false);  
  lw := AttrValueAsBoolean('lockWindows', false);  
  if ls or lw then  FBook._Protect.SetProtected(true);
end;

function TXLSXReader.Parse_WB_SetPrintTitles(val: widestring; sheetindex: integer): integer;
var r1, c1, r2, c2: integer;
    p: integer;
    v: string;
begin
   Result := 1;
   //print titles
   val := trim(val);
   p := pos('!', val);
   if p > 0 then begin
      //remove sheet name
      val := Copy(val, p + 1, length(val) - p);
   end;
   p := pos(',', val);
   if p > 0 then begin
      val := Copy(val, 1, p - 1);
   end;
   if sheetindex >= 0 then begin
      if ST_Ref2RowCols(val, r1, c1, r2, c2) then begin
         //set print title
         if r2 = XLSXMaxRow then begin
            //columns
            ValuesToColDiapason(c1 + 1, c2 + 1, v);
            FBook.Sheets[sheetindex + 1].PageSetup.PrintTitleColumns := v; 
         end else if c2 = XLSXMaxCol then begin
            //rows
            ValuesToRowDiapason(r1 + 1, r2 + 1, v);
            FBook.Sheets[sheetindex + 1].PageSetup.PrintTitleRows := v; 
         end;   
      end;
   end;
end;


function TXLSXReader.Parse_WB_definedName: integer;
var isfunction: boolean;
    hidden: boolean;
    sheetindex: integer;
    name: widestring;
    name_f: widestring;
    val: widestring;
    p: integer;
    r1, c1, r2, c2: integer;
begin
  Result := 1;
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
  isfunction :=  AttrValueAsBoolean('function', false); 
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
  hidden :=  AttrValueAsBoolean('hidden', false); 

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
  sheetindex := AttrValueAsInt32('localSheetId', -1); 

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
  name := AttrValueAsString('name', ''); 

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
  name_f := ReadContent;
  if pos(widestring('_xlnm.'), name) = 1 then begin
     //system name
     {_xlnm.Print_Area 
         this defined name specifies the workbook's  print area. 
     }
     if name = '_xlnm.Print_Area' then begin
         //print area
         p := pos('!', name_f);
         if p > 0 then begin
            //remove sheet name
            name_f := Copy(name_f, p + 1, length(name_f) - p);
         end;
         p := pos(',', name_f);
         if p > 0 then begin
            name_f := Copy(name_f, 1, p - 1);
         end;
         if sheetindex >= 0 then begin
            if ST_Ref2RowCols(name_f, r1, c1, r2, c2) then begin
               //set print area
               FBook.Sheets[sheetindex + 1].PageSetup.SetPrintArea(r1, c1, r2, c2);
            end;
         end;
     end;
     {_xlnm.Print_Titles
         this defined name specifies the row(s) or column(s) to repeat
         at the top of each printed page. 
     }
     if name = '_xlnm.Print_Titles' then begin
         //print titles
         while true do begin
            p := pos(',', name_f);
            if p > 0 then begin
               val := Copy(name_f, 1, p - 1);
               name_f := Copy(name_f, p + 1, length(name_f) - p);
               Parse_WB_SetPrintTitles(val, sheetindex);
            end else begin
               Parse_WB_SetPrintTitles(name_f, sheetindex);
               break;
            end;
         end; 
     end;
  end else begin
     //user defined
     if isfunction then begin
        //skip
        //!!!!!
     end else begin
        if name_f <> '' then name_f := '=' + name_f;
        if name_f <> '' then begin
           if sheetindex >= 0 then begin
               if Assigned(FBook.Sheets[sheetindex + 1].Names.Add(name, name_f, not(hidden))) then begin
               end; 
           end else begin
               if Assigned(FBook._Names.Add(name, name_f, not(hidden))) then begin
               end; 
           end; 
        end;
     end;
  end;
end;



function TXLSXReader.ParseStylesRecord(recid: integer): integer;
begin
  case recid of 
       RECID_ST_numFmts:       Result := Parse_ST_numFmts;
       RECID_ST_fonts:         Result := Parse_ST_fonts;
       RECID_ST_fills:         Result := Parse_ST_fills;
       RECID_ST_borders:       Result := Parse_ST_borders;
       RECID_ST_cellStyleXfs:  Result := Parse_ST_cellStyleXfs;
       RECID_ST_cellXfs:       Result := Parse_ST_cellXfs; 
       RECID_ST_cellStyles:    Result := Parse_ST_cellStyles; 
       RECID_ST_colors:        Result := Parse_ST_colors;
       else Result := 1; //skip
  end;  
end;

function TXLSXReader.Parse_ST_numFmts: integer;
var cnt, i: integer;
    numFmtId: integer;
    formatCode: widestring;
begin
  Result := 1;
  cnt := AttrValueAsInt32('count', 0);

  for i := 1 to cnt do begin
    if not(FXMLReader.Read) then begin
       Result := -1;
       break; 
    end;     
    if FXMLReader.Name <> 'numFmt' then begin
       Result := -1;
       break; 
    end;
    numFmtId := AttrValueAsInt32('numFmtId');
    formatCode := AttrValueAsString('formatCode');
    FBook._XFList.Formats.Value[numFmtId] := formatCode;
  end;

end;

function TXLSXReader.Parse_ST_fonts: integer;
var cnt, i: integer;
    fnti: integer; 
begin
  fnti := 0;
  Result := 1;
  cnt := AttrValueAsInt32('count');
  for i := 1 to cnt do begin
    if not(FXMLReader.Read) then begin
       Result := -1;
       break; 
    end;     
    if FXMLReader.Name <> 'font' then begin
       Result := -1;
       break; 
    end;
    Result := Parse_ST_font(fnti); 
    Inc(fnti);
    if Result <> 1 then break;
  end;

//  if (cnt + 3 ) > 4 then begin
//   FBook._XFList.Fonts.SetDefaultCount(cnt + 3 - 1);
//  end;
  
end;

function TXLSXReader.Parse_color(c: TXLSStyleColor; autocolorindex: integer): integer;
var cv: integer;
    ct: integer;
    tint: double;
    sv: widestring;
begin
  
  cv := autocolorindex;
  ct := 0;

  if FXMLReader.HasAttribute('indexed') then begin
     cv := AttrValueAsInt32('indexed', 0);  
     ct := 0;
  end else if FXMLReader.HasAttribute('rgb') then begin
     sv := AttrValueAsString('rgb');  
     cv := $FFFFFF and (strtoint('$' + sv)); 
     cv := ((cv and $0000FF) shl 16) or (cv and $00FF00) or ((cv and $FF0000) shr 16);
     ct := 2;
  end else if FXMLReader.HasAttribute('theme') then begin
     cv := AttrValueAsInt32('theme');  
     ct := 1;
  end;

  tint := AttrValueAsDouble('tint', 0);    

  c.Assign(ct, cv, tint);
  Result := 1;
end;

function TXLSXReader.Parse_ST_font(fontindex: integer): integer;
var tagname: ansistring;
    sval: widestring;
    f: TXLSStyleFont;
    i: integer;
begin

  Result := 1;
  f := TXLSStyleFont.Create;
  f.Name := 'Calibri';
  f.Size := 11;
  f.Family := 0;
  f.Color.Assign(0, $7FFF, 0);

  while FXMLReader.Read do begin
     tagname := FXMLReader.Name;
     if (FXMLReader.NodeType = xmlntEndElement) and (tagname = 'font') then begin
          break;
     end;
     if (FXMLReader.NodeType <> xmlntElement) then continue;
     if       tagname = 'name'      then f.Name   := AttrValueAsString('val') 
     else if  tagname = 'sz'        then f.Size   := AttrValueAsDouble('val') 
     else if  tagname = 'family'    then f.Family := AttrValueAsInt32('val') 
//   else if  tagname = 'condense'  then f.Condense := AttrValueAsBoolean('val', true) 
//   else if  tagname = 'extend'    then f.Extend := AttrValueAsBoolean('val', true) 
     else if  tagname = 'b'         then f.Bold   := AttrValueAsBoolean('val', true)
     else if  tagname = 'i'         then f.Italic := AttrValueAsBoolean('val', true) 
     else if  tagname = 'charset'   then f.Charset := AttrValueAsInt32('val')
     else if  tagname = 'color'     then Parse_color(f.Color, $7FFF)
     else if  tagname = 'vertAlign' then 
        begin
          sval := AttrValueAsString('val', 'baseline'); 
          if sval = 'subscript' then f.SubScript := true
          else if sval = 'superscript' then f.SuperScript := true;
        end
     else if  tagname = 'outline'    then f.OutlineFont := AttrValueAsBoolean('val', true) 
//   else if  tagname = 'scheme'     then 
//      begin
//        sval := AttrValueAsString('val', ''); 
//        if      sval = 'minor' then f.Scheme := 1
//        else if sval = 'major' then f.Scheme := 2
//        else f.Scheme := 0;
//      end
     else if  tagname = 'shadow' then f.Shadow := AttrValueAsBoolean('val', true) 
     else if  tagname = 'strike' then f.Strikethrough := AttrValueAsBoolean('val', true) 
     else if  tagname = 'u' then 
        begin
          sval := AttrValueAsString('val', 'single'); 
          if      sval = 'none'             then f.Underline := 0
          else if sval = 'double'           then f.Underline := 2
          else if sval = 'doubleAccounting' then f.Underline := 34
          else if sval = 'single'           then f.Underline := 1
          else if sval = 'singleAccounting' then f.Underline := 33;
        end;
  end;
  if fontindex = 0 then begin
     for i := 0 to 3 do begin
        FBook._XFList.Fonts.SetKeyItem(i, f.Clone());
     end;
     FBook._XFList.Fonts.SetKeyIndex(f, 0);
     f.Free;
  end else begin
     FBook._XFList.Fonts.SetKeyItem(fontindex + 3, f); 
  end;
end;

function TXLSXReader.Parse_ST_fills: integer;
var cnt, i: integer;
    fi: integer; 
begin
  fi := 0;
  Result := 1;
  cnt := AttrValueAsInt32('count');
  for i := 1 to cnt do begin
    if not(FXMLReader.Read) then begin
       Result := -1;
       break; 
    end;     
    if FXMLReader.Name <> 'fill' then begin
       Result := -1;
       break; 
    end;
    Result := Parse_ST_fill(fi); 
    Inc(fi);
    if Result <> 1 then break;
  end;
end;

function TXLSXReader.STPatternTypeToInternalPattern(st_pattern: string): integer;
begin
  Result := 0;
  if       st_pattern = 'none'            then Result := 0
  else if  st_pattern = 'solid'           then Result := 1
  else if  st_pattern = 'mediumGray'      then Result := 2
  else if  st_pattern = 'darkGray'        then Result := 3
  else if  st_pattern = 'lightGray'       then Result := 4
  else if  st_pattern = 'darkHorizontal'  then Result := 5
  else if  st_pattern = 'darkVertical'    then Result := 6
  else if  st_pattern = 'darkDown'        then Result := 7
  else if  st_pattern = 'darkUp'          then Result := 8
  else if  st_pattern = 'darkGrid'        then Result := 9
  else if  st_pattern = 'darkTrellis'     then Result := 10
  else if  st_pattern = 'lightHorizontal' then Result := 11
  else if  st_pattern = 'lightVertical'   then Result := 12
  else if  st_pattern = 'lightDown'       then Result := 13
  else if  st_pattern = 'lightUp'         then Result := 14
  else if  st_pattern = 'lightGrid'       then Result := 15
  else if  st_pattern = 'lightTrellis'    then Result := 16
  else if  st_pattern = 'gray125'         then Result := 17
  else if  st_pattern = 'gray0625'        then Result := 18;
end;

function TXLSXReader.Parse_ST_fill(fillindex: integer): integer;
var tagname: ansistring;
    sval: widestring;
    f: TXLSStyleFill;
begin
  Result := 1;
  f := TXLSStyleFill.Create;
  f.BgColor.Assign(0, 65, 0);
  f.FgColor.Assign(0, 64, 0);
  FXMLReader.Read;
  if FXMLReader.Name <> 'patternFill' then begin
      //gradientFill - igonore
      FXMLReader.Skip;
  end else begin
      //patternFill
      sval := AttrValueAsString('patternType', 'none');
      f.PatternType := STPatternTypeToInternalPattern(sval);
      FXMLReader.MoveToElement;
      if FXMLReader.IsEmptyElement then begin
         FXMLReader.Read; //go to /fill            
      end else begin
         
         while FXMLReader.Read do begin
            tagname := FXMLReader.Name;

            if (FXMLReader.NodeType = xmlntEndElement) and (tagname = 'patternFill') then begin
               FXMLReader.Read; //go to /fill            
               break;
            end;

            if (FXMLReader.NodeType <> xmlntElement) then continue;

            if       tagname = 'bgColor'   then Parse_color(f.BgColor, 64)
            else if  tagname = 'fgColor'   then Parse_color(f.FgColor, 65);
         end;
      end;
  end;
  FBook._XFList.Fills.SetKeyItem(fillindex, f); 
end;


function TXLSXReader.Parse_ST_borders: integer;
var cnt, i: integer;
    bi: integer; 
begin
  bi := 0;
  Result := 1;
  cnt := AttrValueAsInt32('count');
  for i := 1 to cnt do begin
    if not(FXMLReader.Read) then begin
       Result := -1;
       break; 
    end;     
    if FXMLReader.Name <> 'border' then begin
       Result := -1;
       break; 
    end;
    Result := Parse_ST_border(bi); 
    Inc(bi);
    if Result <> 1 then break;
  end;
end;


function TXLSXReader.Parse_ST_border(borderindex: integer): integer;
var tagname: ansistring;
    b: TXLSStyleBorder;
begin
  Result := 1;
  b := TXLSStyleBorder.Create;
  b.DiagonalUp := AttrValueAsBoolean('diagonalUp', false);
  b.DiagonalDown := AttrValueAsBoolean('diagonalDown', false);
  while FXMLReader.Read do begin
     tagname := FXMLReader.Name;
     if (FXMLReader.NodeType = xmlntEndElement) and (tagname = 'border') then break;
     if (FXMLReader.NodeType <> xmlntElement) then continue;
     if       tagname = 'left'     then Parse_ST_borderline(b.Left)
     else if  tagname = 'right'    then Parse_ST_borderline(b.Right)
     else if  tagname = 'top'      then Parse_ST_borderline(b.Top)
     else if  tagname = 'bottom'   then Parse_ST_borderline(b.Bottom) 
     else if  tagname = 'diagonal' then Parse_ST_borderline(b.Diagonal);
  end;
  FBook._XFList.Borders.SetKeyItem(borderindex, b); 
end;

function TXLSXReader.STBorderStyleToInternal(st_bstyle: string): integer;
begin
  Result := 0;
  if       st_bstyle = 'none'             then Result := 0
  else if  st_bstyle = 'thin'             then Result := 1
  else if  st_bstyle = 'medium'           then Result := 2
  else if  st_bstyle = 'dashed'           then Result := 3
  else if  st_bstyle = 'dotted'           then Result := 4
  else if  st_bstyle = 'thick'            then Result := 5
  else if  st_bstyle = 'double'           then Result := 6
  else if  st_bstyle = 'hair'             then Result := 7
  else if  st_bstyle = 'mediumDashed'     then Result := 8
  else if  st_bstyle = 'dashDot'          then Result := 9
  else if  st_bstyle = 'mediumDashDot'    then Result := 10
  else if  st_bstyle = 'dashDotDot'       then Result := 11
  else if  st_bstyle = 'mediumDashDotDot' then Result := 12
  else if  st_bstyle = 'slantDashDot'     then Result := 13;
end;

function TXLSXReader.STHorizontalAlignmentToInternal(value: string): integer;
begin
  Result := 0;
  if       value = 'general'          then Result := 0
  else if  value = 'left'             then Result := 1
  else if  value = 'center'           then Result := 2
  else if  value = 'right'            then Result := 3
  else if  value = 'fill'             then Result := 4
  else if  value = 'justify'          then Result := 5
  else if  value = 'centerContinuous' then Result := 6
  else if  value = 'distributed'      then Result := 7;
end;

function TXLSXReader.STVerticalAlignmentToInternal(value: string): integer;
begin
  Result := 2;
  if       value = 'top'          then Result := 0
  else if  value = 'center'       then Result := 1
  else if  value = 'bottom'       then Result := 2
  else if  value = 'justify'      then Result := 3
  else if  value = 'distributed'  then Result := 4;
end;


function TXLSXReader.Parse_ST_borderline(bl: TXLSStyleBorderLine): integer;
var tagname: ansistring;
    endtag: ansistring;
begin
  endtag := FXMLReader.Name;
  bl.Style := STBorderStyleToInternal(AttrValueAsString('style', 'none'));
  FXMLReader.MoveToElement;
  if not(FXMLReader.IsEmptyElement) then begin
     while FXMLReader.Read do begin
        tagname := FXMLReader.Name;
        if (FXMLReader.NodeType = xmlntEndElement) and (tagname = endtag) then break;
        if (FXMLReader.NodeType <> xmlntElement) then continue;
        if tagname = 'color'   then Parse_color(bl.Color, 64);
     end;
  end;
  if bl.Style = 0 then Result := 0 else Result := 1;
end;

function TXLSXReader.Parse_ST_cellStyleXfs: integer;
var cnt, i: integer;
    fi: integer; 
begin
  fi := 0;
  Result := 1;
  cnt := AttrValueAsInt32('count');
  for i := 1 to cnt do begin
    if not(FXMLReader.Read) then begin
       Result := -1;
       break; 
    end;     
    if FXMLReader.Name <> 'xf' then begin
       Result := -1;
       break; 
    end;
    Result := Parse_ST_xf(fi, true); 
    Inc(fi);
    if Result <> 1 then break;
  end;
end;


function TXLSXReader.Parse_ST_xf(xfindex: integer; isStyle: boolean): integer;
var tagname: ansistring;
    ival: integer;
    xf: TXLSStyleXF;
begin

  Result := 1;
  xf := FBook._XFList.CreateNewXFormat;

  xf.NumFormatIndex := AttrValueAsInt32('numFmtId', 0); 
  ival := AttrValueAsInt32('fontId', 0);
  if ival > 0 then ival := ival + 3;
  xf.FontIndex := ival; 
  xf.BorderIndex := AttrValueAsInt32('borderId', 0); 
  xf.FillIndex := AttrValueAsInt32('fillId', 0); 
  if isStyle then begin
     xf.ParentStyleIndex := -1;
  end else begin
     ival := AttrValueAsInt32('xfId', 0);
     if ival > 0  then ival := ival + 20;
     xf.ParentStyleIndex := ival; 
     FBook._XFList.IncReferredCount(ival);
  end;
  xf.ApplyNumFormat := AttrValueAsBoolean('applyNumberFormat', false); 
  xf.ApplyFont := AttrValueAsBoolean('applyFont', false); 
  xf.ApplyNumFormat := AttrValueAsBoolean('applyNumberFormat', false); 
  xf.ApplyFill := AttrValueAsBoolean('applyFill', false); 
  xf.ApplyBorder := AttrValueAsBoolean('applyBorder', false); 
  xf.ApplyAlignment := AttrValueAsBoolean('applyAlignment', false); 
  xf.ApplyProtection := AttrValueAsBoolean('applyProtection', false); 
  FXMLReader.MoveToElement;
  if not(FXMLReader.IsEmptyElement) then begin
     while FXMLReader.Read do begin
        tagname := FXMLReader.Name;
        if (FXMLReader.NodeType = xmlntEndElement) and (tagname = 'xf') then break;
        if (FXMLReader.NodeType <> xmlntElement) then continue;
        if tagname = 'alignment'   then begin
             xf.HorAlign        := STHorizontalAlignmentToInternal(AttrValueAsString('horizontal', 'general'));
             xf.VerAlign        := STVerticalAlignmentToInternal(AttrValueAsString('vertical', 'bottom'));
             xf.IndentLevel     := AttrValueAsInt32('indent', 0);
             xf.JustifyLastLine := AttrValueAsBoolean('justifyLastLine', false);
             xf.ReadingOrder    := AttrValueAsInt32('readingOrder', 0);
             xf.relativeIndent  := AttrValueAsInt32('relativeIndent', 0);
             xf.shrinkToFit     := AttrValueAsBoolean('shrinkToFit', false);
             xf.Orientation     := AttrValueAsInt32('textRotation', 0);
             xf.wrapText        := AttrValueAsBoolean('wrapText', false);
        end else if tagname = 'protection' then begin
             //w riteln('protection locked:', AttrValueAsBoolean('locked', false));
             xf.Hidden          := AttrValueAsBoolean('hidden', false);
             xf.Locked          := AttrValueAsBoolean('locked', true);
        end else MoveToElementEnd;
     end;
  end;

  if isStyle then begin
     xf.IsStyleXF := isStyle;
     if xfindex > 0 then begin
        xfindex := xfindex + 20;
        if (xfindex - 20) > FExtraStylesCount then FExtraStylesCount := (xfindex - 20);
     end;
     FBook._XFList.SetKeyItem(xfindex, xf);
     FBook._XFList.DecReferredCount(xfindex);  
     //FBook._XFList.IncReferredCount(xfindex);   
  end else begin
     xfindex := xfindex + 15;
     if xfindex > 15 then begin
        xfindex := xfindex + 5 + FExtraStylesCount;
     end;
     FBook._XFList.SetKeyItem(xfindex, xf); 
     FBook._XFList.DecReferredCount(xfindex);  
  end;
end;


function TXLSXReader.Parse_ST_cellXfs: integer;
var cnt, i: integer;
    fi: integer; 
begin
  fi := 0;
  Result := 1;
  cnt := AttrValueAsInt32('count');
  for i := 1 to cnt do begin
    if not(FXMLReader.Read) then begin
       Result := -1;
       break; 
    end;     
    if FXMLReader.Name <> 'xf' then begin
       Result := -1;
       break; 
    end;
    Result := Parse_ST_xf(fi, false); 
    Inc(fi);
    if Result <> 1 then break;
  end;
end;

function TXLSXReader.Parse_ST_cellStyles: integer;
var cnt, i: integer;
begin
  Result := 1;
  cnt := AttrValueAsInt32('count');
  for i := 1 to cnt do begin
    if not(FXMLReader.Read) then begin
       Result := -1;
       break; 
    end;     
    if FXMLReader.Name <> 'cellStyle' then begin
       Result := -1;
       break; 
    end;
    Result := Parse_ST_cellStyle;
    if Result <> 1 then break;
  end;
end;

function TXLSXReader.Parse_ST_cellStyle: integer;
var s: TXLSStyleEntry;
    ival, bxf: integer;
begin
   Result := 1;
   s := TXLSStyleEntry.Create;

   s.Name      := AttrValueAsString('name', '');
   s.BuiltinID := AttrValueAsInt32('builtinId', -1);
   s.Custom    := AttrValueAsBoolean('customBuiltin', false); 
   s.Hidden    := AttrValueAsBoolean('hidden', false); 
   s.iLevel    := AttrValueAsInt32('iLevel', -1);

   ival := AttrValueAsInt32('xfId', 0);
   if ival > 0 then ival := ival + 20;

   if not(s.Custom) and 
      ((s.BuiltinID = 0) or ((s.BuiltinID >=3) and (s.BuiltinID <=7))) then begin

      bxf := 0;
      case s.BuiltinID of 
         0: bxf := 0;
         3: bxf := $13;  
         4: bxf := $10;
         5: bxf := $12;
         6: bxf := $14;
         7: bxf := $11;
      end;
      if (bxf > 0) and (bxf <> ival) then begin
         FBook._XFList.CopyFormat(ival, bxf);
         FBook._XFList.IncReferredCount(bxf);
      end;
      s.Free;
   end else begin
      s.XFIndex := ival; 
      FBook._XFList.IncReferredCount(ival);
      FBook._XFList.Styles.Add(s);
   end;
   
   MoveToElementEnd;
end;

function TXLSXReader.Parse_ST_colors: integer;
var tagname: ansistring;
begin
  Result := 1;
  FXMLReader.MoveToElement;
  if not(FXMLReader.IsEmptyElement) then begin
     while FXMLReader.Read do begin
        tagname := FXMLReader.Name;
        if (FXMLReader.NodeType = xmlntEndElement) and (tagname = 'colors') then break;
        if (FXMLReader.NodeType <> xmlntElement) then continue;
        if tagname = 'indexedColors'   then begin
            Result := Parse_ST_indexedColors;
        end else MoveToElementEnd;
     end;
  end;
end;

function TXLSXReader.Parse_ST_indexedColors: integer;
var tagname: ansistring;
    i: integer;
    cv: longword;
begin
  Result := 1;
  FXMLReader.MoveToElement;
  i := 0;
  if not(FXMLReader.IsEmptyElement) then begin
     while FXMLReader.Read do begin
        tagname := FXMLReader.Name;
        if (FXMLReader.NodeType = xmlntEndElement) and (tagname = 'indexedColors') then break;
        if (FXMLReader.NodeType <> xmlntElement) then continue;
        if tagname = 'rgbColor' then begin
           cv := AttrValueAsHex('rgb', 0);
           cv := ((cv and $0000FF) shl 16) or (cv and $00FF00) or ((cv and $FF0000) shr 16);
           FBook.ColorManager.Palette[i] := cv;
           Inc(i);
        end else MoveToElementEnd;
     end;
  end;
end;

function TXLSXReader.Parse_WS_sheetPr: integer;
var tagname: ansistring;
begin
  Result := 1;
  FSheet._VBAObjectName := AttrValueAsString('codeName', '');
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
  FXMLReader.MoveToElement;
  if not(FXMLReader.IsEmptyElement) then begin
     while FXMLReader.Read do begin
        tagname := FXMLReader.Name;
        if (FXMLReader.NodeType = xmlntEndElement) and (tagname = 'sheetPr') then break;
        if (FXMLReader.NodeType <> xmlntElement) then continue;
        if tagname = 'outlinePr'   then begin
            Result := Parse_WS_outlinePr();
        end else if tagname = 'tabColor' then begin
            //to do
            MoveToElementEnd;
        end else if tagname = 'pageSetUpPr' then begin
            Result := Parse_WS_pageSetupPr();
        end else MoveToElementEnd;
     end;
  end;
end;

function TXLSXReader.Parse_WS_outlinePr: integer;
begin
  Result := 1;
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
  if AttrValueAsBoolean('summaryBelow', true) then
     FSheet.Outline.SummaryRow := xlBelow
  else 
     FSheet.Outline.SummaryRow := xlAbove;
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
  if AttrValueAsBoolean('summaryRight', true) then
     FSheet.Outline.SummaryColumn := xlRight
  else 
     FSheet.Outline.SummaryColumn := xlLeft;
end;

function TXLSXReader.Parse_WS_pageSetupPr: integer;
begin
  Result := 1;
  {autoPageBreaks
     Flag indicating whether the sheet displays Automatic Page Breaks.
     The possible values for this attribute are defined by the XML Schema boolean datatype. 
  }
  {fitToPage
     Flag indicating whether the Fit to Page print option is enabled.
     The possible values for this attribute are defined by the XML Schema boolean datatype.  
  }
  FIsFitToPages := AttrValueAsBoolean('fitToPage', false);
end;

function TXLSXReader.Parse_WS_pageSetup: integer;
var sval: widestring;
begin
  Result := 1;
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
  FSheet.PageSetup.Zoom := AttrValueAsInt32('scale', 100);

  {fitToHeight
     Number of vertical pages to fit on.
  }
  FSheet.PageSetup.FitToPagesTall := AttrValueAsInt32('fitToHeight', 0);

  {fitToWidth
     Number of horizontal pages to fit on.
  }
  FSheet.PageSetup.FitToPagesWide := AttrValueAsInt32('fitToWidth', 0);

  {horizontalDpi
     Horizontal print resolution of the device.
  }
  {id
     Relationship Id of the devMode printer settings part.
  }
  {orientation
     Orientation of the page.("default", "portrait", "landscape")
  }
  sval := AttrValueAsString('orientation', '');
  if sval = 'portrait' then begin
     FSheet.PageSetup.Orientation := 1;
  end else if sval = 'landscape' then begin
     FSheet.PageSetup.Orientation := 2;
  end;

  {pageOrder
     Order of printed pages. (downThenOver, overThenDown)
  }
  {paperSize
     Paper size  (default 1)
  }
  FSheet.PageSetup.PaperSize := AttrValueAsInt32('paperSize', 1);

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
  FSheet.PageSetup.Zoom := not(FIsFitToPages);

end;

function TXLSXReader.Parse_WS_dimension: integer;
begin
  Result := 1;
  //skip
end;

function TXLSXReader.Parse_WS_sheetViews: integer;
var tagname: ansistring;
begin
  Result := 1;
  FXMLReader.MoveToElement;
  if not(FXMLReader.IsEmptyElement) then begin
     while FXMLReader.Read do begin
        tagname := FXMLReader.Name;
        if (FXMLReader.NodeType = xmlntEndElement) and (tagname = 'sheetViews') then break;
        if (FXMLReader.NodeType <> xmlntElement) then continue;
        if tagname = 'sheetView'   then begin
            Result := Parse_WS_sheetView;
            MoveToParentElementEnd;
            break;
        end else MoveToElementEnd;
     end;
  end;
end;

function TXLSXReader.Parse_WS_sheetView: integer;
var topleftcell: widestring;
    r,c: integer;
    zoom: integer;
    tagname: ansistring;
    view: widestring;
begin
  Result := 1;

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
  FSheet.DisplayRightToLeft := AttrValueAsBoolean('rightToLeft', false);
  {showFormulas
     Flag indicating whether this sheet should display formulas. 
     The possible values for this attribute are defined by the XML Schema boolean datatype.
  }
  {showGridLines
     Flag indicating whether this sheet should display gridlines.
     The possible values for this attribute are defined by the XML Schema boolean datatype.
  }
  FSheet.DisplayGridLines := AttrValueAsBoolean('showGridLines', true);
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
  FSheet.DisplayZeros := AttrValueAsBoolean('showZeros', true);
  {tabSelected
     Flag indicating whether this sheet is selected. When only 1 sheet is selected and active,
     this value should be in synch with the activeTab value. In case of a conflict, the Start Part
     setting wins and sets the active sheet tab.
     Note: multiple sheets can be selected, but only one sheet can be active at one time.  
  }
  FSheet.Selected := AttrValueAsBoolean('tabSelected', false);
  {topLeftCell
     Location of the top left visible cell Location of the top left visible cell in the bottom right
     pane (when in Left-to-Right mode).  
  }
  topleftcell := AttrValueAsString('topLeftCell', 'A1'); 
  if ST_CellRef2RowCol(0, topleftcell, r, c) then begin
     FSheet.ScrollRow := r + 1;
     FSheet.ScrollColumn := c + 1;
  end;

  {view
     Indicates view type.  (normal, pageBreakPreview, pageLayout)
  }
  view := AttrValueAsString('view', 'normal');
  if view = 'pageBreakPreview' then begin
      FSheet.View := xlPageBreakPreview;
  end else if view = 'pageLayout' then begin
      FSheet.View := xlPageLayoutView;
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
  {zoomScale
     Window zoom magnification for current view representing percent values. Valid values
     range from 10 to 400. Horizontal & Vertical scale together.
  }
  zoom := AttrValueAsInt32('zoomScale', 0); 
  if (zoom >= 10) and (zoom <= 400) then begin
     FSheet.Zoom := zoom; 
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

  FXMLReader.MoveToElement;
  if not(FXMLReader.IsEmptyElement) then begin
     while FXMLReader.Read do begin
        tagname := FXMLReader.Name;
        if (FXMLReader.NodeType = xmlntEndElement) and (tagname = 'sheetView') then break;
        if (FXMLReader.NodeType <> xmlntElement) then continue;
        if tagname = 'pane'   then begin
           Result := Parse_WS_pane;
        end else if tagname = 'selection' then begin
           Result := Parse_WS_selection;
        //end else if tagname = 'pivotSelection' then begin
        end else MoveToElementEnd;
     end;
  end;
end;

function TXLSXReader.Parse_WS_pane: integer;
var r,c: integer;
    topleftcell: string;
    x, y: integer;
    state: string;
begin
  Result := 1;
  {activePane
    The pane that is active. (bottomLeft, bottomRight, topLeft, topRight)
  }
  {state
    Indicates whether the pane has horizontal / vertical splits, and whether those splits are
    frozen. (frozen, frozenSplit, split)
  }
  state := AttrValueAsString('state', ''); 

  {topLeftCell
    Location of the top left visible cell in the bottom right pane
  }
  topleftcell := AttrValueAsString('topLeftCell', ''); 
  ST_CellRef2RowCol(0, topleftcell, r, c);
                                                  
  {xSplit
    Horizontal position of the split, in 1/20th of a point; 0 (zero) if none. 
    If the pane is frozen, this value indicates the number of columns 
    visible in the top pane.
  }
  x := round(AttrValueAsDouble('xSplit', 0)); 

  {ySplit
    Vertical position of the split, in 1/20th of a point; 0 (zero) if none. 
    If the pane is frozen, this value indicates the number of rows visible 
    in the left pane.
  }
  y := round(AttrValueAsDouble('ySplit', 0)); 

  if state = 'split' then 
     FSheet.ThawPanes((y - 255)/20, (x - 390)/113.879, r, c)
  else
     FSheet.FreezePanes(y, x, r, c);
end;

function TXLSXReader.Parse_WS_selection: integer;
var row1, row2, col1, col2: integer;
    sqref: string;
    p: integer;
begin
  Result := 1;
  {activeCell
     Location of the active cell.
  }

  {activeCellId
     0-based index of the range reference (in the array of references listed in sqref)
     containing the active cell. Only used when the selection in sqref is not contiguous.
     Therefore, this value needs to be aware of the order in which the range references are
     written in sqref.
     When this value is out of range then activeCell can be used.
  }

  {pane
     The pane to which this selection belongs.
  }

  {sqref
     Range of the selection. Can be non-contiguous set of ranges.
  }
  sqref := AttrValueAsString('sqref', ''); 
  p := pos(' ', sqref);
  if p > 0 then begin
     sqref := Copy(sqref, 1, p - 1);
  end;

  if ST_Ref2RowCols(sqref, row1, col1, row2, col2) then begin
     FSheet.RCRange[row1 + 1, col1 + 1, row2 + 1, col2 + 1].Select;
  end;

end;

function TXLSXReader.Parse_WS_sheetFormatPr: integer;
var ival: integer;
    dval: double;
begin
  Result := 1;
  {baseColWidth
     Specifies the number of characters of the maximum digit width of the normal style's font.
     This value does not include margin padding or extra padding for gridlines. It is only the
     number of characters.
     See defaultColWidth description in this section for details on calculating this value.
     See the col element description, particularly the width attribute description, for more
     information on what is meant by "maximum digit width".
  }
  ival := AttrValueAsInt32('baseColWidth', -1);
  if ival > 0 then 
     FSheet.StandardWidth := Excel2Width( ival * 296);

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
  dval := AttrValueAsDouble('defaultColWidth', -1);
  if dval > 0 then begin
     //dval := Truncate((dval * 7 + 5) / 7 * 256) / 256;  //8->8.7109375
     dval := ceil((dval * 7 - 5)/7 * 256)/256;//  8.7109375 -> 8
     FSheet.StandardWidth := dval;
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
  dval := AttrValueAsDouble('defaultRowHeight', -1);
  if dval > 0 then 
     FSheet.StandardHeight := dval;

  {outlineLevelCol
     Highest number of outline levels for columns in this sheet. These values must be in synch
     with the actual sheet outline levels.  
  }
  {outlineLevelRow
     Highest number of outline level for rows in this sheet. These values must be in synch with
     the actual sheet outline levels.  
  }
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
end;

function TXLSXReader.Parse_WS_pageMargins: integer;
begin
  Result := 1;
  with FSheet.PageSetup do begin
     {bottom
        Bottom Page Margin in inches.
     }
     BottomMargin := AttrValueAsDouble('bottom', 1);
     {footer
        Footer Page Margin in inches.
     }
     FooterMargin := AttrValueAsDouble('footer', 0.5);
     {header
        Header Page Margin in inches.
     }
     HeaderMargin := AttrValueAsDouble('header', 0.5);
     {left
        Left Page Margin in inches.
     }
     LeftMargin := AttrValueAsDouble('left', 0.75);
     {right
        Right page margin in inches.
     }
     RightMargin := AttrValueAsDouble('right', 0.75);
     {top 
        Top Page Margin in inches.
     }
     TopMargin := AttrValueAsDouble('top', 1);
  end;

end;

function TXLSXReader.Parse_WS_cols: integer;
var tagname: ansistring;
begin
  Result := 1;
  FXMLReader.MoveToElement;
  if not(FXMLReader.IsEmptyElement) then begin
     while FXMLReader.Read do begin
        tagname := FXMLReader.Name;
        if (FXMLReader.NodeType = xmlntEndElement) and (tagname = 'cols') then break;
        if (FXMLReader.NodeType <> xmlntElement) then continue;
        if tagname = 'col'   then begin
            Result := Parse_WS_col;
        end else MoveToElementEnd;
     end;
  end;
end;

function TXLSXReader.Parse_WS_col: integer;
var col1, col2: integer;
    width: integer;
    hidden: boolean;
    xf: integer;
    outlinelevel: integer;
    //customwidth: boolean;
    dval: double;
    i: integer;
begin
  Result := 1;

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

   {hidden
      Flag indicating if the affected column(s) are hidden on this worksheet.
   }
   hidden := AttrValueAsBoolean('hidden', false);

   {max 
      Last column affected by this 'column info' record.
   }
   col2 := AttrValueAsInt32('max', 1) - 1;

   {min 
      First column affected by this 'column info' record.
   }
   col1 := AttrValueAsInt32('min', 1) - 1;

   {outlineLevel
      Outline level of affected column(s). Range is 0 to 7. See description of outlinePr
      element's summaryBelow and summaryRight attributes for detailed information.
   }
   outlineLevel := AttrValueAsInt32('outlineLevel', 0) + 1;

   {phonetic 
      Flag indicating if the phonetic information should be displayed by default for the affected
      column(s) of the worksheet.
   }

   {style 
      Default style for the affected column(s). Affects cells not yet allocated in the column(s).
      In other words, this style applies to new columns.
   }
   xf := AttrValueAsInt32('style', 0);
   if xf > 0 then xf := xf + 20 + FExtraStylesCount;

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
   dval := AttrValueAsDouble('width', -1);
   if dval > 0 then begin
      dval := ceil((dval * 7 - 5)/7 * 256)/256;
   end;
   if dval > 0 then width := Width2Excel(dval)
               else width := -1;
 
  if col1 <= col2 then begin
     for i := col1 to col2 do begin
         FSheet._ColumnInfo._SetColInfo(i, width, hidden, xf, outlinelevel);
     end;  
  end;
   
end;

function TXLSXReader.Parse_WS_sheetData: integer;
var tagname: ansistring;
begin
  Result := 1;
  FXMLReader.MoveToElement;
  if not(FXMLReader.IsEmptyElement) then begin
     while FXMLReader.Read do begin
        tagname := FXMLReader.Name;
        if (FXMLReader.NodeType = xmlntEndElement) and (tagname = 'sheetData') then break;
        if (FXMLReader.NodeType <> xmlntElement) then continue;
        if tagname = 'row'   then begin
            Result := Parse_WS_row;
        end else MoveToElementEnd;
     end;
  end;
end;


function TXLSXReader.Parse_WS_row: integer;
var hidden: boolean;
    ht: double;
    r: integer;
    s: integer;
    outlineLevel: integer;

    h: integer;
    isht: boolean;
    isxf: boolean;
    tagname: ansistring;
    attr: TXMLAttribute;
    acnt, ai: integer;
begin
  Result := 1;
  acnt := FXMLReader.AttributeCount;

  isxf := false;
  isht := false;
  h := 0;
  hidden := false;
  outlineLevel := 1;
  r := 0;
  s := 0;

  if acnt > 0 then begin
     for ai := 0 to acnt - 1 do begin
        attr := FXMLReader.Attribute[ai];


  {r
     Row index. Indicates to which row in the sheet this <row> definition corresponds. 
  }
  if attr.Name = 'r' then begin
     r := attr.ValueAsInt32 - 1;
     //r := AttrValueAsInt32('r', 1) - 1;
     continue;
  end;

  {s
     Index to style record for the row (only applied if customFormat attribute is '1') 
  }
  if attr.Name = 's' then begin
     s := attr.ValueAsInt32;
     //s := AttrValueAsInt32('s', 0);
     if s > 0 then s := s + 20 + FExtraStylesCount;
     continue;
  end;

  {collapsed 
     '1' if the rows 1 level of outlining deeper than the current row are in the collapsed outline
     state. It means that the rows which are 1 outline level deeper (numerically higher value) 
     than the current row are currently hidden due to a collapsed outline state. 
      
     It is possible for collapsed to be false and yet still have the rows in question hidden. 
     This can be achieved by having a lower outline level collapsed, thus hiding all the child 
     rows. 
  }

  {customFormat
     '1' if the row style should be applied. 
  }

  if attr.Name = 'customFormat' then begin
     isxf := attr.ValueAsBoolean;
     //isxf := AttrValueAsBoolean('customFormat', false);
     continue;
  end;

  {customHeight
     '1' if the row height has been manually set. 
  }

  if attr.Name = 'customHeight' then begin
     isht := attr.ValueAsBoolean;
     //isht := AttrValueAsBoolean('customHeight', false);
     continue;
  end;


  {hidden
     '1' if the row is hidden, e.g., due to a collapsed outline or by manually selecting and 
     hiding a row. 
  }
  if attr.Name = 'hidden' then begin
     hidden := attr.ValueAsBoolean;
     //hidden := AttrValueAsBoolean('hidden', false);
     continue;
  end;

  {ht
     Row height measured in point size. There is no margin padding on row height.
  }
  if attr.Name = 'ht' then begin
     ht := attr.ValueAsDouble;
     //ht := AttrValueAsDouble('ht', -1);
     if ht > 0 then h := Height2Excel(ht);
     continue;
  end;

  {outlineLevel
     Outlining level of the row, when outlining is on. See description of outlinePr element's 
     summaryBelow and summaryRight attributes for detailed information. 
  }
  if attr.Name = 'outlineLevel' then begin
     outlineLevel := attr.ValueAsInt32 + 1;
     //outlineLevel := AttrValueAsInt32('outlineLevel', 0) + 1;
     continue;
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
     end; //for
  end; //if

  FSheet._RowInfo._SetRowInfo(r, h, isht, s, isxf, hidden, outlinelevel, true);

  //FXMLReader.MoveToElement;
  if not(FXMLReader.IsEmptyElement) then begin
     while FXMLReader.Read do begin
        tagname := FXMLReader.Name;
        if (FXMLReader.NodeType = xmlntEndElement) and (tagname = 'row') then break;
        if (FXMLReader.NodeType <> xmlntElement) then continue;
        if tagname = 'c'   then begin
            Result := Parse_WS_c;
        end else MoveToElementEnd;
     end;
  end;
end;

function TXLSXReader.Parse_WS_c: integer;
var 
    tagname: ansistring;
    row, col: integer;
    s: integer;
    t: widestring;
    is_isvalue: boolean;
    is_value: boolean;
    is_formula: boolean;
    d_value: double;
    b_value: boolean;
    s_value: widestring;
    si_value: integer;
    f_value: widestring;
    ReplaceIndex: boolean;
    isdt: boolean;
    attr: TXMLAttribute;
    acnt, ai: integer;
    cell: TXLSCellRef;
begin
  Result := 1;
  is_isvalue := false;
  is_value := false;
  is_formula := false;
  s_value := '';
  f_value := '';
  b_value := false;
  d_value := 0;
  si_value := -1;
  s := 0;
  t := 'n';

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
  {r
     An A1 style reference to the location of this cell 
  }
  row := -1; col := -1;

  acnt := FXMLReader.AttributeCount;
  if acnt > 0 then begin
     for ai := 0 to acnt - 1 do begin
        attr := FXMLReader.Attribute[ai];


  if attr.Name = 'r' then begin
     ST_CellRef2RowCol(0, attr.Value, row, col);
     continue;
  end;

  {s
     The index of this cell's style. Style records are stored in the Styles Part. 
  }
  if attr.Name = 's' then begin
     s := attr.ValueAsInt32;
     if s > 0 then s := s + 20 + FExtraStylesCount;
     continue;
  end;

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
  if attr.Name = 't' then begin
     t := attr.Value;
     continue;
  end;

  {vm
        The zero-based index of the value metadata record associated with this cell's value.
        Metadata records are stored in the Metadata Part. Value metadata is extra information
        stored at the cell level, but associated with the value rather than the cell itself. Value
        metadata is accessible via formula reference.
  }

     end; //for
  end; //if 

  //FXMLReader.MoveToElement;
  if not(FXMLReader.IsEmptyElement) then begin
     while FXMLReader.Read do begin
        tagname := FXMLReader.Name;
        if (FXMLReader.NodeType = xmlntEndElement) and (tagname = 'c') then break;
        if (FXMLReader.NodeType <> xmlntElement) then continue;

        if (tagname = 'v') {cell value} and not(is_isvalue) then begin
            is_value := true;
            if t = 'n' then begin
               Result := Parse_WS_v_n(d_value);
            end else if t = 's' then begin
               Result := Parse_WS_v_s(si_value);
            end else if t = 'b' then begin
               Result := Parse_WS_v_b(b_value);
//            end else if t = 'e' then begin
//             Result := Parse_WS_v_e(e_value);
            end else if t = 'str' then begin
               Result := Parse_WS_v_str(s_value);
            end;
        end else if tagname = 'is'{inline rich text} then begin
            Result := Parse_WS_c_is(s_value);
            is_value := true;
            is_isvalue := true;
        end else if tagname = 'f' {formula}   then begin
            is_formula := true;
            Result := Parse_WS_f(row, col);
        end else MoveToElementEnd;
     end;
  end;
  
  if Result = 1 then begin
     cell := FSheet._CellsHeap.GetOrCreateValue(row, col);
     if not(Assigned(cell)) then exit;
     if s > 0 then begin
        FBook._XFList.ReplaceIndex(0, s);
        cell.XFIndex := s;
        //FSheet._SetXF(row, col, s);
     end;

     if is_formula then begin
        inc(_tmp);
     end else begin
        if is_value then begin
           if t = 'n' then begin
              if FBook.Date1904 then begin
                 if s > 0 then begin
                    isdt := FBook._XFList.isDateFormat(s);
                 end else begin
                    isdt := FBook._XFList.isDateFormat(FSheet.GetXFIndex(row, col, ReplaceIndex));
                 end;

                 if isdt then begin
                    d_value := d_value + 1462; 
                 end;
              end; 

              cell.Value[FSheet] := d_value;
              //FSheet.Cells[row + 1, col + 1].Value := d_value;
           end else if t = 'b' then begin
              cell.Value[FSheet] := b_value;
              //FSheet.Cells[row + 1, col + 1].Value := b_value;
           end else if t = 's' then begin
              s_value := FStringTable[si_value + 1];
              cell.Value[FSheet] := '''' + s_value;
              //FSheet.Cells[row + 1, col + 1].Value := '''' + s_value; 
           end else if t = 'str' then begin
              cell.Value[FSheet] := '''' + s_value;
              //FSheet.Cells[row + 1, col + 1].Value := '''' + s_value; 
           end else if t = 'inlineStr' then begin
              cell.Value[FSheet] := '''' + s_value;
              //FSheet.Cells[row + 1, col + 1].Value := '''' + s_value; 
           end;
        end; 
     end;

  end;

end;


function TXLSXReader.Parse_WS_f(r, c: integer): integer;
var t: widestring;
    tid: integer;
    si: integer;
    msc: TXLSMasterSharedCell;
    sformula: widestring;
    cf: TXLSCompiledFormula;
begin
   Result := 1;

   {t
      Type of formula. 
         array (Array Entered)      Formula is an array entered formula. 
         dataTable (Table Formula)  Formula is a data table formula. 
         normal (Normal)            Formula is a regular cell formula. 
         shared (Shared Formula)    Formula is part of a shared formula. 
   }
   t := AttrValueAsString('t', 'normal'); 
   if t = 'normal' then tid := 0
   else if t = 'shared' then tid := 1
   else tid := -1;

   {ca 
      Indicates that this formula needs to be recalculated the next time calculation is 
      performed. For example, this is always set on volatile functions, like =RAND(), and circular 
      references. 
   }

   {si 
      Optional attribute to optimize load performance by sharing formulas. 
       
      When a formula is a shared formula (t value is shared) then this value indicates the 
      group to which this particular cell's formula belongs. The first formula in a group of 
      shared formulas is saved in the f element. This is considered the 'master' formula cell. 
      Subsequent cells sharing this formula need not have the formula written in their f 
      element. Instead, the attribute si value for a particular cell is used to figure what the 
      formula expression should be based on the cell's relative location to the master formula 
      cell. 
       
      A cell is shared only when si is used and t is shared. The formula expression for a cell 
      that is specified to be part of a shared formula (and is not the master) shall be ignored, 
      and the master formula shall override. 
       
      If a master cell of a shared formula range specifies that a particular cell is part of the 
      shared formula range, and that particular cell does not use the si and t attributes to 
      indicate that it is shared, then the particular cell's formula shall override the shared 
      master formula. If this cell occurs in the middle of a range of shared formula cells, the 
      earlier and later formulas shall continue sharing the master formula, and the cell in 
      question shall not share the formula of the master cell formula. 

      Loading and handling of a cell and formula using an si attribute and whose t value is 
      shared, located outside the range specified in the master cell associated with the si 
      group, is implementation defined. 
       
      Master cell references on the same sheet shall not overlap with each other.
   }
   if tid = 1 then begin
      si := AttrValueAsInt32('si', -1); 
      if si >= 0 then begin
         if FSharedFormulaCells.KeyExists(si) then begin
             msc := TXLSMasterSharedCell(FSharedFormulaCells[si]); 
             cf := FSheet._GetCompiledFormula(msc.Row, msc.Col);
             if Assigned(cf) then begin
                 //shared formula
                 FSheet._SetCompiledFormula(r, c, cf.GetCopy(r - msc.Row, c - msc.Col));
             end;
         end else begin
             msc := TXLSMasterSharedCell.Create(r, c);
             FSharedFormulaCells[si] := msc;
             sformula := ReadContent();
             cf := FBook._Formula.GetCompiledFormula(sFormula, FSheet.FSheetID); 
             //cf := nil;
             if Assigned(cf) then begin
                 FSheet._SetCompiledFormula(r, c, cf);
             end else begin
//                 w riteln('not compiled: ', sformula);
             end;
         end;
      end;
   end else if tid = 0 then begin
      sformula := ReadContent();
      cf := FBook._Formula.GetCompiledFormula(sFormula, FSheet.FSheetID); 
      //cf := nil;
      if Assigned(cf) then begin
          FSheet._SetCompiledFormula(r, c, cf);
      end else begin
//          w riteln('not compiled: ', sformula);
      end;
   end else begin
      MoveToElementEnd;
   end;

   {ref
      Range of cells which the formula applies to. Only required for shared formula, array 
      formula or data table. Only written on the master formula, not subsequent formula's 
      belonging to the same shared group, array, or data table. 
   }

end;


function TXLSXReader.Parse_WS_v_n(var value: double): integer;
var s_value: widestring;
begin
  Result := 1;
  s_value := ReadContent();
  value := xlsstrtofloat(s_value, '.');
end;

function TXLSXReader.Parse_WS_v_b(var value: boolean): integer;
var s_value: widestring;
begin
  Result := 1;
  s_value := ReadContent();
  value := (s_value = '1') or (s_value = 'true');
end;

function TXLSXReader.Parse_WS_v_s(var value: integer): integer;
var s_value: widestring;
begin
  Result := 1;
  s_value := ReadContent();
  value := strtoint(s_value);
end;

function TXLSXReader.Parse_WS_v_str(var value: widestring): integer;
begin
  Result := 1;
  value := ReadContent();
end;

function TXLSXReader.Parse_WS_c_is(var value: widestring): integer;
begin
  Result := 1;
  value := ReadContent();
end;

function TXLSXReader.Parse_WS_mergeCells: integer;
var tagname: ansistring;
begin
  Result := 1;
  FXMLReader.MoveToElement;
  if not(FXMLReader.IsEmptyElement) then begin
     while FXMLReader.Read do begin
        tagname := FXMLReader.Name;
        if (FXMLReader.NodeType = xmlntEndElement) and (tagname = 'mergeCells') then break;
        if (FXMLReader.NodeType <> xmlntElement) then continue;
        if tagname = 'mergeCell'   then begin
            Result := Parse_WS_mergeCell;
        end else MoveToElementEnd;
     end;
  end;
end;

function TXLSXReader.Parse_WS_mergeCell: integer;
var ref: widestring;
    row1, row2, col1, col2: integer;
begin
  ref := AttrValueAsString('ref', ''); 
  if ST_Ref2RowCols(ref, row1, col1, row2, col2) then begin
     FSheet.RCRange[row1 + 1, col1 + 1, row2 + 1, col2 + 1].Merge(false);
  end;
  Result := 1;
end;

function TXLSXReader.Parse_WS_colBreaks: integer;
var tagname: ansistring;
begin
  Result := 1;
  {count 
     Number of breaks in the collection.
  }
  {manualBreakCount
     Number of manual breaks in the collection.
  }
  FXMLReader.MoveToElement;
  if not(FXMLReader.IsEmptyElement) then begin
     while FXMLReader.Read do begin
        tagname := FXMLReader.Name;
        if (FXMLReader.NodeType = xmlntEndElement) and (tagname = 'colBreaks') then break;
        if (FXMLReader.NodeType <> xmlntElement) then continue;
        if tagname = 'brk'   then begin
            Result := Parse_WS_brk(false);
        end else MoveToElementEnd;
     end;
  end;
end;

function TXLSXReader.Parse_WS_rowBreaks: integer;
var tagname: ansistring;
begin
  Result := 1;
  {count 
     Number of breaks in the collection.
  }
  {manualBreakCount
     Number of manual breaks in the collection.
  }
  FXMLReader.MoveToElement;
  if not(FXMLReader.IsEmptyElement) then begin
     while FXMLReader.Read do begin
        tagname := FXMLReader.Name;
        if (FXMLReader.NodeType = xmlntEndElement) and (tagname = 'rowBreaks') then break;
        if (FXMLReader.NodeType <> xmlntElement) then continue;
        if tagname = 'brk'   then begin
            Result := Parse_WS_brk(true);
        end else MoveToElementEnd;
     end;
  end;
end;

function TXLSXReader.Parse_WS_brk(isRow: boolean): integer;
var id: integer;
    pt: boolean;
begin
   Result := 1;
   {id
      Zero-based row or column Id of the page break. Breaks occur above the specified row
      and left of the specified column.
   }
   id := AttrValueAsInt32('id', 0); 

   {man
      Manual Break flag.
   }
   {max 
      Zero-based index of end row or column of the break. 
      For row breaks, specifies column index; 
      for column breaks, specifies row index.
   }
   {min
      Zero-based index of start row or column of the break. 
      For row breaks, specifies column index; 
      for column breaks, specifies row index.
   }
   {pt
      Flag indicating that a PivotTable created this break.
   }
   pt := AttrValueAsBoolean('pt', false); 

   if not(pt) then begin
      if isRow then begin
         FSheet.HPageBreaks.Add(FSheet.Cells[id + 1, 1]);
      end else begin
         FSheet.VPageBreaks.Add(FSheet.Cells[1, id + 1]);
      end;
   end;
end;

function TXLSXReader.Parse_WS_printOptions: integer;
var gridLines: boolean;
    gridLinesSet: boolean;
    headings: boolean;
    horizontalCentered: boolean;
    verticalCentered: boolean;
begin
  Result := 1;

  {gridLines
     Used in conjunction with gridLinesSet. If both gridLines and gridlinesSet are true, then
     grid lines shall print. Otherwise, they shall not (i.e., one or both have false values).
  }
  gridLines := AttrValueAsBoolean('gridLines', false); 

  {gridLinesSet
     Used in conjunction with gridLines. If both gridLines and gridLinesSet are true, then
     grid lines shall print. Otherwise, they shall not (i.e., one or both have false values).
  }
  gridLinesSet := AttrValueAsBoolean('gridLinesSet', true); 

  FSheet.PageSetup.PrintGridlines := gridLines and gridLinesSet;

  {headings
     Print row and column headings.
  }
  headings := AttrValueAsBoolean('headings', false); 
  FSheet.PageSetup.PrintHeadings := headings;

  {horizontalCentered
     Center on page horizontally when printing.
  }
  horizontalCentered := AttrValueAsBoolean('horizontalCentered', false); 
  FSheet.PageSetup.CenterHorizontally := horizontalCentered;

  {verticalCentered
     Center on page vertically when printing.
  }
  verticalCentered := AttrValueAsBoolean('verticalCentered', false); 
  FSheet.PageSetup.CenterVertically := verticalCentered;
  
end;

function TXLSXReader.SplitHeaderFooter(value: widestring; var Left: widestring; var Center: widestring; var Right: widestring): integer;
var lpos: integer;
begin
  Right  := '';
  Left   := '';
  Center := ''; 

  //Right
  Right := Value;
  while true do begin 
     {$ifdef D2009}
     lpos := Pos(widestring('&R'), Right);
     {$else}
     lpos := Pos('&R', Right);
     {$endif}
     if lpos > 0 then begin
        if ((lpos = 1) or (copy(Right, lpos - 1, 1) <> '&')) then begin
           Right := Copy(Right, lpos + 2, Length(Right) - lpos - 1);
           break;
        end else begin
           Right := Copy(Right, lpos + 2, Length(Right) - lpos - 1);
        end;
     end else begin
       Right := '';
       break;   
     end;
  end;

  if Length(Right) > 0 then
      Value := Copy(Value, 1, Length(Value) - Length(Right) - 2);

  //Center
  Center := Value;
  while true do begin 
     {$ifdef D2009}
     lpos := Pos(widestring('&C'), Center);
     {$else}
     lpos := Pos('&C', Center);
     {$endif}
     if lpos > 0 then begin
        if ((lpos = 1) or (copy(Center, lpos - 1, 1) <> '&')) then begin
           Center := Copy(Center, lpos + 2, Length(Center) - lpos - 1);
           break;
        end else begin
           Center := Copy(Center, lpos + 2, Length(Center) - lpos - 1);
        end;
     end else begin
       Center := '';
       break;   
     end;
  end;
  if Length(Center) > 0 then
     Value := Copy(Value, 1, Length(Value) - Length(Center) - 2);

  //Left
  Left := Value;
  while true do begin 
     {$ifdef D2009}
     lpos := Pos(widestring('&L'), Left);
     {$else}
     lpos := Pos('&L', Left);
     {$endif}
     if lpos > 0 then begin
        if ((lpos = 1) or (copy(Left, lpos - 1, 1) <> '&')) then begin
           Left := Copy(Left, lpos + 2, Length(Left) - lpos - 1);
           break;
        end else begin
           Left := Copy(Left, lpos + 2, Length(Left) - lpos - 1);
        end;
     end else begin
       Left := '';
       break;   
     end;
  end;
  Result := 1;
end;


function TXLSXReader.Parse_WS_headerFooter: integer;
var tagname: ansistring;
    sval: widestring;
    l,c,r: widestring;
begin
  Result := 1;
{
  .EvenPage.LeftHeader.Text = ""
  .EvenPage.CenterHeader.Text = ""
  .EvenPage.RightHeader.Text = ""
  .EvenPage.LeftFooter.Text = ""
  .EvenPage.CenterFooter.Text = ""
  .EvenPage.RightFooter.Text = ""

  .FirstPage.LeftHeader.Text = ""
  .FirstPage.CenterHeader.Text = ""
  .FirstPage.RightHeader.Text = ""
  .FirstPage.LeftFooter.Text = ""
  .FirstPage.CenterFooter.Text = ""
  .FirstPage.RightFooter.Text = ""
}

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
   FXMLReader.MoveToElement;
   if not(FXMLReader.IsEmptyElement) then begin
      while FXMLReader.Read do begin
         tagname := FXMLReader.Name;
         if (FXMLReader.NodeType = xmlntEndElement) and (tagname = 'headerFooter') then break;
         if (FXMLReader.NodeType <> xmlntElement) then continue;

         if tagname = 'oddHeader' then begin
            sval := ReadContent;
            SplitHeaderFooter(sval, l, c, r);
            with FSheet.PageSetup do begin
               LeftHeader   := l;
               CenterHeader := c;
               RightHeader  := r;
            end;
         end else if tagname = 'oddFooter' then begin 
            sval := ReadContent;
            SplitHeaderFooter(sval, l, c, r);
            with FSheet.PageSetup do begin
               LeftFooter   := l;
               CenterFooter := c;
               RightFooter  := r;
            end;
//         end else if tagname = 'evenFooter' then begin 
//            sval := FXMLReader.ReadContent;
//         end else if tagname = 'evenHeader' then begin 
//            sval := FXMLReader.ReadContent;
//         end else if tagname = 'firstFooter' then begin 
//            sval := FXMLReader.ReadContent;
//         end else if tagname = 'firstHeader' then begin 
//            sval := FXMLReader.ReadContent;
         end else MoveToElementEnd;
      end;
   end;

end;

function TXLSXReader.Parse_WS_hyperlinks: integer;
var tagname: ansistring;
begin
  Result := 1;
  FXMLReader.MoveToElement;
  if not(FXMLReader.IsEmptyElement) then begin
     while FXMLReader.Read do begin
        tagname := FXMLReader.Name;
        if (FXMLReader.NodeType = xmlntEndElement) and (tagname = 'hyperlinks') then break;
        if (FXMLReader.NodeType <> xmlntElement) then continue;
        if tagname = 'hyperlink'   then begin
            Result := Parse_WS_hyperlink();
        end else MoveToElementEnd;
     end;
  end;
end;

function TXLSXReader.Parse_WS_sheetProtection: integer;
var phash: word;
    password: widestring;
    sheet: boolean;
begin
  Result := 1;

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

  password := AttrValueAsString('password', ''); 
  if password <> '' then begin
     phash := strtoint('$' + password); 
     FSheet._Protect.ProtectEncode(phash);
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
  sheet := AttrValueAsBoolean('sheet', false);  
  if sheet then  FSheet._Protect.SetProtected(true);

  {sort (Sort Locked)  
     Sorting is locked when the sheet is protected. 
  }

end;


function TXLSXReader.Parse_WS_hyperlink: integer;
var display: widestring;
    id: widestring;
    location: widestring;
    ref: widestring;
    tooltip: widestring;
    address: widestring;
    r1, r2, c1, c2: integer;
begin
  Result := 1;
  address := '';
  {display
     Display string, if different from string in string table. This is a property on the hyperlink 
     object, but does not need to appear in the spreadsheet application UI. 
  } 
  display := AttrValueAsString('display', ''); 

  {id
     Relationship Id in this sheet's relationships part, expressing the target location of the 
     resource. 
  }
  id := AttrValueAsString('r:id', ''); 

  if id <> '' then begin
      //external hyperlink
      if FWorksheetRelations.Exists(id) then begin
         address := FWorksheetRelations.ById[id].Target;
      end; 
  end;
   
  {location 
     Location within target. If target is a workbook (or this workbook) this shall refer to a 
     sheet and cell or a defined name. Can also be an HTML anchor if target is HTML file. 
  }
  location := AttrValueAsString('location', ''); 
   
  {ref
     Cell location of hyperlink on worksheet. 
  }

  ref := AttrValueAsString('ref', ''); 
  if not(ST_Ref2RowCols(ref, r1, c1, r2, c2)) then Result := -1;
  

  {tooltip
     This is additional text to help the user understand more about the hyperlink. This can be 
     displayed as hover text when the mouse is over the link, for example. 
  }

  tooltip := AttrValueAsString('tooltip', ''); 

  if Result = 1 then begin
     if (address <> '') or (location <> '') then begin
        FSheet.GetCustomHyperlinks().Add(r1, c1, r2, c2, address, location, tooltip, display); 
     end;
  end;
end;

function TXLSXReader.GetFileData(FileName: widestring): TXLSBlob;
var strm: TStream;
    size: integer;
begin
  strm := FFileReader.OpenFile(FileName);
  if Assigned(strm) then begin
     size := FFileReader.GetUncompressedSize(FileName);
     if size > 0 then begin 
        Result := TXLSBlob.Create(size);
        strm.Read(Result.Buff^, size);
        Result.DataLength := size;
     end else begin
        Result := nil;
     end;
     strm.Free;
  end else begin
     Result := nil;
  end;
end;
                     
function TXLSXReader.LoadVBA: integer;
begin
  Result := 1;
  FBook.XLSXVBAProject := GetFileData('/xl/vbaProject.bin');
  //FBook.XLSXVBAProject.Dump;
end; 

end.
