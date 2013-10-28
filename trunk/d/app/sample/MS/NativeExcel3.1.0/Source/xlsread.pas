//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsread
//       
//      Description: Read an existing excel file
//
//////////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2004-2011 NikaSoft. All rights reserved.
//     Author: A.V.Nikulitsa
//
//       site: http://www.nika-soft.com/ 
//     e-mail: support@nika-soft.com
//
//////////////////////////////////////////////////////////////////////////////
unit xlsread;
{$Q-}
{$R-}

interface

{$I xlsdef.inc}

uses classes, nexcel;

 function OpenExcelFile(Book: TXLSWorkBook; FileName: WideString; Password: WideString; Var FileFormat: TXLSFileFormat): integer;
 function OpenExcelStream(Book: TXLSWorkBook; Stream: TStream; Password: WideString; Var FileFormat: TXLSFileFormat): integer;

implementation
uses ole, xlsblob, xlshash, xlscalc, xlsvba{}, xlsescher{}, xlsstrm, xlschart,
     xlsstylefont, xlsstylecolor, xlsstyleborder, xlsstylefill, xlsstylexf,
     sysutils,  windows, wstream, xlsxread, xlscols, xlsrows,
     {$IFDEF D45}
         ComObj
     {$ELSE}
         Variants
     {$ENDIF};

type

  TXLSBlobArray =  xlsblob.TXLSBlobList;

   TXLSSystemName = class
   protected
      nametype: integer;
      sheet: integer;
      row1: integer;
      row2: integer;
      col1: integer;
      col2: integer;
   public
      constructor Create(NameType: integer; sheet, row1, row2, col1, col2: integer); 
   end;

   TXLSSystemNames = class (TList)
   private
      function GetItem(Index: integer): TXLSSystemName;
   public
      procedure AddItem(NameType: integer; sheet, row1, row2, col1, col2: integer); 
      destructor Destroy; override;
      property Item[Index: integer]: TXLSSystemName read GetItem; default;
   end;

   TXLSCachedNameEntry = class
   public 
      FNameID: integer;
      FData: TXLSBlob;
      constructor Create(NameID: integer; Data: TXLSBlob);
      destructor Destroy; override;
   end;

   TXLSReader = class
   private
     FBiffVersion: Word;
     FContext: integer;
     FReadStream: TXLSReadStream;

     FBook: TXLSWorkbook;
     FStringTable: TWideStringArray;
     FStringCount: LongWord;
     FStringTotalCount: LongWord;

     FActiveSheetIndex:   Word;
     FFirstSheetIndex:    Word;
     FFrozen: boolean;
     FIsFitToPages: boolean;
     FSheetCount: Word;
     FFontCount: integer;
     FXFCount: integer;
     FCodePage: Word;
     FDateMode1904: boolean;

     FNameIndex: integer;

     FSharedFormulaRow: integer;
     FSharedFormulaCol: integer;
     FSharedFormulaSetResult: boolean;
     FSharedFormulaResult: variant;  

     FSysNames: TXLSSystemNames;
     FChart: TXLSCustomChart;
     //FCachedSheetID: THashInteger;
     FExcel5LocalLinkTable: TWideStringArray;
     FCachedNames: TObjectArray;
     FLastFormulaRow: integer;
     FLastFormulaCol: integer;

     function Process: integer;
     function PostProcess: integer;
     function ParseRecord(RecID: Word; Data: TXLSBlobArray): integer;
     function ParseWorkbookRecord(RecID: Word; Data: TXLSBlobArray): integer;
     function ParseWorksheetRecord(RecID: Word; Data: TXLSBlobArray): integer;
     function ParseChartRecord(RecID: Word; Data: TXLSBlobArray): integer;
     
     procedure SysNamesApply;
     function  Excel5ExternID2Name(ExternID: integer): WideString;

     //workbook
     function ParseBof(Data: TXLSBlob): integer;
     function ParseIncludedBof(Data: TXLSBlob): integer;

     function ParseWindow1(Data: TXLSBlob): integer;
     function ParseFont(Data: TXLSBlob): integer;
     function ParseNumFormat(Data: TXLSBlob): integer;
     function ParseCodePage(Data: TXLSBlob): integer;
     function ParseStyle(Data: TXLSBlob): integer;
     function ParseXF(Data: TXLSBlob): integer;
     function ParseSST(DataList: TXLSBlobArray): integer;
     function ParseBoundSheet(Data: TXLSBlob): integer;
     function ParsePalette(Data: TXLSBlob): integer;
     function ParseExterns(Data: TXLSBlob): integer;
     function ParseMsoDrawingGroup(DataList: TXLSBlobArray): integer;
     function ParseDateMode(Data: TXLSBlob): integer;

     function GetNameShortRange(Data: TXLSBlob; Var row1, row2, col1, col2, SheetIndex: integer): integer;
     function GetNameLongRange(Data: TXLSBlob; Var row1, row2, col1, col2, SheetIndex: integer): integer;
     function ParseNameShort(Data: TXLSBlob): integer;
     function ParseNameLong(Data: TXLSBlob): integer;
     function ParseName(Data: TXLSBlob): integer;
     function ParseUserDefinedName(ANameID: integer; Data: TXLSBlob): integer;
     function ParseRefMode(Data: TXLSBlob): integer;
     function ParseFilePass(Data: TXLSBlob): integer;
     function ParseSupBook(Data: TXLSBlob): integer;
     function ParseExternalName(Data: TXLSBlob): integer;

     //Both workbook and worksheet
     function ParseProtect(Data: TXLSBlob): integer;
     function ParsePassword(Data: TXLSBlob): integer;
     function ParseVBAObjectName(Data: TXLSBlob): integer;
     //worksheet
     function ParseSheetProtect(Data: TXLSBlob): integer;
     function ParseDouble(Data: TXLSBlob): integer;
     function ParseString(Data: TXLSBlob): integer;
     function ParseBoolean(Data: TXLSBlob): integer;
     function ParseRK(Data: TXLSBlob): integer;
     function ParseMulRK(Data: TXLSBlob): integer;
     function ParseLabelSST(Data: TXLSBlob): integer;
     function ParseLabel(Data: TXLSBlob): integer;
     function ParseRstring(Data: TXLSBlob): integer;
     function ParseBlank(Data: TXLSBlob): integer;
     function ParseFormula(Data: TXLSBlob): integer;
     function ParseSharedFormula(Data: TXLSBlob): integer;
     function ParseArrayFormula(Data: TXLSBlob): integer;
     function ParseMulBlank(Data: TXLSBlob): integer;
     function ParseColinfo(Data: TXLSBlob): integer;
     function ParseRowinfo(Data: TXLSBlob): integer;
     function ParseMergedCells(Data: TXLSBlob): integer;
     function ParseSelection(Data: TXLSBlob): integer;
     function ParsePanes(Data: TXLSBlob): integer;
     function ParseWindow2(Data: TXLSBlob): integer;
     function ParseSetup(Data: TXLSBlob): integer;
     function ParseAutoFilterInfo(Data: TXLSBlob): integer;
     function ParseAutoFilterData(Data: TXLSBlob): integer;
     function ParsePrintGridLines(Data: TXLSBlob): integer;
     function ParsePrintHeaders(Data: TXLSBlob): integer;
     function ParseHBreaks(Data: TXLSBlob): integer;
     function ParseVBreaks(Data: TXLSBlob): integer;
     function ParseWSBool(Data: TXLSBlob): integer;
     function RK2Double(Value: LongWord): Double;
     function ParseMargin(Data: TXLSBlob; Side: integer): integer;
     function ParseCenter(Data: TXLSBlob; Orient: integer): integer;
     function ParseHeaderFooter(Data: TXLSBlob; Orient: integer): integer;
     function ParseZoom(Data: TXLSBlob): integer;
     function ParseDefColInfo(Data: TXLSBlob; ValType: integer): integer;
     function ParseDefRowInfo(Data: TXLSBlob): integer;
     function ParseComment(Data: TXLSBlob): integer;
     function ParseHyperlink(Data: TXLSBlobArray): integer;
     function ParseQuickTip(Data: TXLSBlob): integer;
     function ParseMsoDrawing(DataList: TXLSBlobArray): integer;
     function ParseCFHeader(DataList: TXLSBlobArray): integer;
     function ParseCFRule(DataList: TXLSBlobArray): integer;
     function ParseDVHeader(DataList: TXLSBlobArray): integer;
     function ParseDVItem(DataList: TXLSBlobArray): integer;
     function ParseObject(DataList: TXLSBlobArray): integer;
     function ParseTXO(DataList: TXLSBlobArray): integer;

     function GetFileFormat: TXLSFileFormat;
     function Load: integer; 
   public
     constructor Create(Book: TXLSWorkbook; Password: WideString);
     destructor Destroy; override;
     function Open(FileName: WideString): integer; overload;
     function Open(Stream: TStream): integer; overload;
     property FileFormat: TXLSFileFormat read GetFileFormat;
   end;

function CheckFileFormat(Stream: TStream): integer;
var signature: longword;
    cnt: integer;
begin
  Stream.Seek(0, soFromBeginning);
  cnt := Stream.Read(signature, 4);

  Result := -1;

  if cnt = 4  then begin
     if signature = $E011CFD0 then begin
        {D0 CF 11 E0 A1 B1 1A E1}
        Result := 1; //compound document
     end else if signature = $04034B50 then begin
        {50 4B 03 04}
        Result := 2; //Zip file -> OpenXMLWorkbook
     end else if ((signature and $0000FFFF) = $00000809) then begin
        //09 08 XX XX
        //biff stored in plain stream
        Result := 3;
     end else if ((signature or $20202000) = $6D74683C) then begin
        {<htm} 
         Result := 4; //html 
     end else if ((signature or $20202000) = $6C6D783C) then begin
        {<xml} 
         Result := 5; //xml
     end;
  end;

  Stream.Seek(0, soFromBeginning);
end;

function OpenExcelFile(Book: TXLSWorkBook; FileName: WideString; Password: WideString; Var FileFormat: TXLSFileFormat): integer;
Var Reader: TXLSReader;
    strm: TStream;
    ff: integer;
begin
  Result := 1;
  strm := nil;

  try
    strm := TWFileStream.Create(FileName, fmOpenRead); 
  except
    //can't to open file
    Result := -1;
  end;

  try
    if Result = 1 then begin
       ff := CheckFileFormat(strm);
       if (ff = 1) or (ff = 3) then begin
          {biff   compounddoc or plain stream}
          strm.Free;
          strm := nil;   
          Reader := TXLSReader.Create(Book, Password);
          Result := Reader.Open(FileName);
          if Result = 1 then FileFormat := Reader.FileFormat;
          Reader.Free;
       end else if ff = 2 then begin
          {OpenXMLWorkbook}
          Result := OpenXLSXStream(Book, strm, Password, FileFormat);
       end else begin
          {unsupported file format}
          if ff = 4 then begin 
             Result := -3001;  //html
          end else if ff = 5 then begin 
             Result := -3002;  //xml
          end else begin
             Result := -3000;
          end; 
       end;
    end;
  finally
    strm.Free;
  end;
end;

function OpenExcelStream(Book: TXLSWorkBook; Stream: TStream; Password: WideString; Var FileFormat: TXLSFileFormat): integer;
Var Reader: TXLSReader;
    ff: integer;
begin
  ff := CheckFileFormat(Stream);
  if (ff = 1) or (ff = 3) then begin
     {biff   compounddoc or plain stream}
     Reader := TXLSReader.Create(Book, Password);
     Result := Reader.Open(Stream);
     if Result = 1 then FileFormat := Reader.FileFormat;
     Reader.Free;
  end else if ff = 2 then begin
     {OpenXMLWorkbook}
     Result := OpenXLSXStream(Book, Stream, Password, FileFormat);
  end else begin
     {unsupported file format}
     if ff = 4 then begin 
        Result := -3001;  //html
     end else if ff = 5 then begin 
        Result := -3002;  //xml
     end else begin
        Result := -3000;
     end; 
  end;
end;



{TXLSSystemName}
constructor TXLSSystemName.Create(NameType: integer; sheet, row1, row2, col1, col2: integer);
begin
   inherited Create;
   self.nametype := NameType;
   self.sheet := sheet;
   self.row1  := row1;
   self.row2  := row2;
   self.col1  := col1;
   self.col2  := col2;
end;

{TXLSSystemNames}
function TXLSSystemNames.GetItem(Index: integer): TXLSSystemName;
begin
  Result := TXLSSystemName(Get(Index));
end;

procedure TXLSSystemNames.AddItem(NameType: integer; sheet, row1, row2, col1, col2: integer);
Var item: TXLSSystemName;
begin
   item := TXLSSystemName.Create(NameType, sheet, row1, row2, col1, col2);
   Add(item);
end;

destructor TXLSSystemNames.Destroy;
Var i: integer;
begin
  for i := 0 to Count - 1 do begin
     Item[i].Free;
  end;
  inherited Destroy; 
end;


{TXLSCachedNameEntry}
constructor TXLSCachedNameEntry.Create(NameID: integer; Data: TXLSBlob);
begin
   inherited Create;
   FNameID := NameID;
   FData := Data;
end;

destructor TXLSCachedNameEntry.Destroy;
begin
   FData.Free;
   inherited Destroy;
end;


{TXLSReader}
constructor TXLSReader.Create(Book: TXLSWorkbook; Password: WideString);
begin
  inherited Create;
  FSheetCount := 0;
  FContext := 0;
  FFontCount:=0;
  FXFCount := 0;
  FBook := Book;
  FStringCount := 0;
  FStringTotalCount := 0;
  FStringTable := TWideStringArray.Create;

  FActiveSheetIndex   := 0;
  FFirstSheetIndex    := 0;
  FNameIndex          := 0;
  FCodePage           := 1252;

  FReadStream := TXLSReadStream.Create(Password);
  FSysNames := TXLSSystemNames.Create();
  //FCachedSheetID := THashInteger.Create();
  FExcel5LocalLinkTable := TWideStringArray.Create();

  FCachedNames := TObjectArray.Create();
  FLastFormulaRow := -1;
  FLastFormulaCol := -1;

  FSharedFormulaSetResult := false;
  FSharedFormulaResult := 0;  
end;

destructor TXLSReader.Destroy;
begin
  inherited Destroy;
  FStringTable.Free; 
  FReadStream.Free;
  FSysNames.Free;
  //FCachedSheetID.Free;
  FChart.Free;
  FExcel5LocalLinkTable.Free;
  FCachedNames.Free;
end;

function TXLSReader.Open(FileName: WideString): integer;
begin 
  Result := FReadStream.Open(FileName);
  if Result = 1 then Result := Load();
end;

function TXLSReader.Open(Stream: TStream): integer;
begin
  Result := FReadStream.Open(Stream);
  if Result = 1 then Result := Load();
end;


function TXLSReader.Load: integer;
Var vba: TXLSFileStorage;
    ctls: TXLSFileStream;
begin
  FBook._Clear;
  FBook._XFList.CreateDefaultFills;
  FBook._Extern.Excel5ExternID2Name := Excel5ExternID2Name;
  Result := Process;
  FBook._Extern.Excel5ExternID2Name := nil;
  if Result = 1 then Result := PostProcess; 
  FReadStream.CloseStream;
   
  if Result = 1 then begin
     if FBiffVersion >= $0600 then
          vba := TXLSFileStorage.Create('_VBA_PROJECT_CUR')
     else vba := TXLSFileStorage.Create('_VBA_PROJECT');
       
     try 
       if vba.Load(FReadStream.Storage) = 1 then begin
          FBook.VBA := vba;
       end else begin
          vba.Free; 
       end;
     except
       on E:Exception do begin
          FBook.VBA := nil;
          vba.Free; 
       end; 
     end;
  end;


  if Result = 1 then begin
     ctls := TXLSFileStream.Create('Ctls');
     try 
       if ctls.Load(FReadStream.Storage) = 1 then begin
          FBook.Ctls := ctls;
       end else begin
          ctls.Free; 
       end;
     except
       on E:Exception do begin
          FBook.Ctls := nil;
          ctls.Free; 
       end; 
     end;
  end;

  FReadStream.CloseStorage; 
end;

function TXLSReader.Process: integer;
Var CurRecID,  CurRecLen: Word;
    RecID: Word;   
    DataList: TXLSBlobArray;
    Data: TXLSBlob;
    cnt: integer;
    ret: integer; 
    isContinue: boolean;
begin
  Result := 1;
  DataList := TXLSBlobArray.Create;
  cnt := 0;
  RecID := 0;
  while Result = 1 do begin
     Result := FReadStream.ReadHeader(CurRecID, CurRecLen);
     if Result = 1 then Result := FReadStream.ReadBody(CurRecLen, Data);
     isContinue :=  (FContext <> 3) and //is not Chart
                    (cnt > 0) and
                    ((CurRecID = $003C) or
                     ((RecId = $00EB) and 
                      (CurRecID = $00EB))
                    );
     if (Result = 100) or not(isContinue) then begin
        //Process List
        ret := ParseRecord(RecID, DataList);
        if ret <> 1 then Result := ret;
        DataList.Free;
        DataList := TXLSBlobArray.Create;
        cnt := 0;  
     end;

     if (Result = 1) and (cnt = 0) then RecID := CurRecID;
     if Result = 1 then begin      
        DataList[cnt] := Data;
        Inc(cnt);
     end;
  end;
  if (FContext = 0) and (Result = 100) then Result := 1;
  DataList.Free;
end;

procedure TXLSReader.SysNamesApply;
var i: integer;
    n: TXLSSystemName;
    v: string;
begin
  for i := 0 to FSysNames.Count - 1 do begin
     n := FSysNames[i]; 
     if (n.Sheet < 1) or (n.Sheet > FBook.Sheets.Count) then
         continue;

     case n.NameType of 
        6: begin
             FBook.Sheets[n.Sheet].PageSetup.SetPrintArea(n.row1, n.col1, n.row2, n.col2);
           end;
        7: begin
             if n.row1 <> -1 then begin
                ValuesToRowDiapason(n.row1 + 1, n.row2 + 1, v);
                FBook.Sheets[n.Sheet].PageSetup.PrintTitleRows := v; 
             end else begin
                ValuesToColDiapason(n.col1 + 1, n.col2 + 1, v);
                FBook.Sheets[n.Sheet].PageSetup.PrintTitleColumns := v; 
             end; 
           end;
     end; 
  end;
end;

function TXLSReader.PostProcess: integer;
begin
  Result := 1;
  FBook.Sheets[FFirstSheetIndex + 1].SetFirstSheet;

  if FActiveSheetIndex < FSheetCount then
     FBook.Sheets[FActiveSheetIndex + 1].Activate;
  SysNamesApply;
end;

function TXLSReader.ParseRecord(RecID: Word; Data: TXLSBlobArray): integer;
var i, cnt: integer;
    cachedname: TXLSCachedNameEntry;
begin
  Result := 1;
  //close current context if EOF record
  if RecID = $000A then begin //EOF

     if (FContext = 1) and (FFontCount > 5) then begin
        FBook._XFList.Fonts.SetDefaultCount(FFontCount - 1);

     end;
     if (FContext = 1) and (FBiffVersion < $0600) then begin
        cnt := FCachedNames.Count;
        if cnt > 0 then begin
           for i := 1 to cnt do begin
               cachedname := TXLSCachedNameEntry(FCachedNames[i]);
               ParseUserDefinedName(cachedname.FNameID, cachedname.FData);
           end;
        end; 
     end;

     if FContext = 2 then FBook.Sheets[FSheetCount]._Drawing.FinalizeParse;

     if FContext = 3 then begin
        //set chart
        FChart.AddData($000A, 0, nil);
        FBook.Sheets[FSheetCount]._SetChartData(FChart);
        FChart := nil;
     end; 

     if FContext = 4 then begin
        //set chart
        FChart.AddData($000A, 0, nil);
        FBook.Sheets[FSheetCount]._Drawing.SetChartData(FChart);
        FChart := nil;
        FContext := 2;
     end else begin
        FContext := 0;  
     end; 

  end else begin
    case FContext of
      0:{without context only BOF allowed}
          if RecID = $0809 then ParseBof(Data[0]);
      1:{workbook}
        Result := ParseWorkBookRecord(RecID, Data);
      2:{worksheet}
        Result := ParseWorkSheetRecord(RecID, Data);
      3,4:{chart}
        Result := ParseChartRecord(RecID, Data);
    end;
  end;
end;

function TXLSReader.ParseWorkBookRecord(RecID: Word; Data: TXLSBlobArray): integer;
begin
  Result := 1;
  if Assigned(Data[0]) then begin
    case RecID of
     {FilePass}    $002F: Result := ParseFilePass(Data[0]);
     {RefMode}     $000F: Result := ParseRefMode(Data[0]);
     {Window1}     $003D: Result := ParseWindow1(Data[0]);
     {Protect}     $0012: Result := ParseProtect(Data[0]);
     {Password}    $0013: Result := ParsePassword(Data[0]);
     {Name}        $0018: Result := ParseName(Data[0]); 
     {DateMode}    $0022: Result := ParseDateMode(Data[0]); 
     {Font}        $0031: Result := ParseFont(Data[0]); 
     {Font}        $0042: Result := ParseCodePage(Data[0]); 
     {NumFormat}   $041E: Result := ParseNumFormat(Data[0]); 
     {Styles}      $0293: Result := ParseStyle(Data[0]);    
     {XF}          $00E0: Result := ParseXF(Data[0]);    
     {SST}         $00FC: Result := ParseSST(Data); 
     {BoundSheet}  $0085: Result := ParseBoundSheet(Data[0]); 
     {Palette}     $0092: Result := ParsePalette(Data[0]); 
     {ExternSheet} $0017: Result := ParseExterns(Data[0]); //!!!!
     {SupBook}     $01AE: Result := ParseSupBook(Data[0]);
     {ExternalName}$0023: Result := ParseExternalName(Data[0]);
     {VBAObjName}  $01BA: Result := ParseVBAObjectName(Data[0]);
  {msoDrawingGroup}$00EB: begin
                            //DrawingDump(Data);
                            Result := ParseMsoDrawingGroup(Data);
                          end;
     {Bof}         $0809: begin
                             {bug EOF lost}
                             ParseRecord($000A, nil);
                             Result := ParseRecord(RecID, Data);
                          end;
    end;
  end;
end;

function TXLSReader.ParseWorkSheetRecord(RecID: Word; Data: TXLSBlobArray): integer;
begin
  Result := 1;
  if Assigned(Data[0]) then begin
    case RecID of
       {Formula} $0006,
                 $0406: Result := ParseFormula(Data[0]);
       {Protect} $0012: Result := ParseProtect(Data[0]);
      {Password} $0013: Result := ParsePassword(Data[0]);
        {Header} $0014: Result := ParseHeaderFooter(Data[0], 1); //!!!!
        {Footer} $0015: Result := ParseHeaderFooter(Data[0], 2); //!!!!
   {ExternSheet} $0017: Result := ParseExterns(Data[0]); //!!!!
       {VBreaks} $001A: Result := ParseVBreaks(Data[0]);    //!!!! 
       {HBreaks} $001B: Result := ParseHBreaks(Data[0]);    //!!!! 
     {Selection} $001D: Result := ParseSelection(Data[0]);  //!!!!
       {Comment} $001C: Result := ParseComment(Data[0]);  //!!!!
    {MarginLeft} $0026: Result := ParseMargin(Data[0], 1);    
   {MarginRight} $0027: Result := ParseMargin(Data[0], 2);    
     {MarginTop} $0028: Result := ParseMargin(Data[0], 3);    
  {MarginBottom} $0029: Result := ParseMargin(Data[0], 4);    
     {PrHeaders} $002A: Result := ParsePrintHeaders(Data[0]);     
     {PrGrLines} $002B: Result := ParsePrintGridLines(Data[0]);     
         {Panes} $0041: Result := ParsePanes(Data[0]);     
   {DefColWidth} $0055: Result := ParseDefColInfo(Data[0], 1);
        {Object} $005D: Result := ParseObject(Data);
       {ColInfo} $007D: Result := ParseColInfo(Data[0]);
        {WSBool} $0081: Result := ParseWSBool(Data[0]);    
       {HCenter} $0083: Result := ParseCenter(Data[0], 1);    
       {VCenter} $0084: Result := ParseCenter(Data[0], 2);    
   {StdColWidth} $0099: Result := ParseDefColInfo(Data[0], 2);
{AUTOFILTERINFO} $009D: Result := ParseAutoFilterInfo(Data[0]);
{AUTOFILTERDATA} $009E: Result := ParseAutoFilterData(Data[0]);
          {Zoom} $00A0: Result := ParseZoom(Data[0]); 
         {Setup} $00A1: Result := ParseSetup(Data[0]);     
         {MulRK} $00BD: Result := ParseMulRK(Data[0]); //!!!!!
      {MulBlank} $00BE: Result := ParseMulBlank(Data[0]); //!!!!
   {MergedCells} $00E5: Result := ParseMergedCells(Data[0]);//!!!!
       {Drawing} $00EC: Result := ParseMsoDrawing(Data);
      {LabelSST} $00FD: Result := ParseLabelSST(Data[0]);
       {RString} $00D6: Result := ParseRString(Data[0]); //!!!!
     {CF_Header} $01B0: Result := ParseCFHeader(Data);
     {CF_Rule}   $01B1: Result := ParseCFRule(Data);
     {DV_Header} $01B2: Result := ParseDVHeader(Data);
           {TXO} $01B6: Result := ParseTXO(Data);
     {Hyperlink} $01B8: Result := ParseHyperLink(Data);
     {VBAObjName}$01BA: Result := ParseVBAObjectName(Data[0]);
     {DV_Rule}   $01BE: Result := ParseDVItem(Data);
         {Blank} $0201: Result := ParseBlank(Data[0]);
        {Double} $0203: Result := ParseDouble(Data[0]);
         {Label} $0204: Result := ParseLabel(Data[0]); //!!!!
       {Boolean} $0205: Result := ParseBoolean(Data[0]);
       {String}  $0207: Result := ParseString(Data[0]);
       {RowInfo} $0208: Result := ParseRowInfo(Data[0]);
  {ArrayFormula} $0221: Result := ParseArrayFormula(Data[0]);
  {DefRowHeight} $0225: Result := ParseDefRowInfo(Data[0]);
       {Window2} $023E: Result := ParseWindow2(Data[0]);     
            {RK} $027E: Result := ParseRK(Data[0]);
 {SharedFormula} $04BC: Result := ParseSharedFormula(Data[0]);
      {QuickTip} $0800: Result := ParseQuickTip(Data[0]);
           {BOF} $0809: Result := ParseIncludedBof(Data[0]);
  {SheetProtect} $0867: Result := ParseSheetProtect(Data[0]);
   end;
 end;

end;

function TXLSReader.ParseChartRecord(RecID: Word; Data: TXLSBlobArray): integer;
var i, cnt: integer;
    len: integer;
    d: TXLSBlob;
begin
   if Assigned(Data) then begin
      cnt := Data.Count;
      if cnt > 0 then begin
         for i := 0 to cnt - 1 do begin
            if i > 0 then RecID := $003C;
            d := Data[i];  

            if Assigned(d) then begin
               len := d.DataLength;
            end else begin
               len := 0;
               d := nil; 
            end;

            FChart.AddData(RecId, len, d);
         end;
      end else begin
         FChart.AddData(RecId, 0, nil);
      end;
   end else begin
      FChart.AddData(RecId, 0, nil);
   end;
  
   Result := 1;
end;

function TXLSReader.ParseBof(Data: TXLSBlob): integer;
Var BiffVersion: Word;
    BofType: Word;
begin
  Result := 1; 
  if Data.DataLength > 4 then begin
     BiffVersion := Data.GetWord(0);
     BofType := Data.GetWord(2);
     case BofType of
        $0005: begin //workbook
                 FContext := 1; 
                 case BiffVersion of 
                   $0500: FBiffVersion := BiffVersion;
                   $0600: FBiffVersion := BiffVersion;
                 end;
               end;
        $0010: begin  //worksheet
                 FContext := 2;
                 FIsFitToPages := false;
                 FFrozen := false;
                 Inc(FSheetCount);
                 if (FSheetCount > FBook.Sheets.Count) then FBook.Sheets.Add();
               end; 
        $0020: begin  //chart
                 FContext := 3;
                 Inc(FSheetCount);
                 //create chart
                 FBook.InitFormula();
                 FChart := TXLSCustomChart.Create(FBook._Formula, FBiffVersion);
                 FChart.AddData($0809, Data.DataLength, Data);
               end; 
     end;

     FExcel5LocalLinkTable.Free;
     FExcel5LocalLinkTable := TWideStringArray.Create();

     if FBiffVersion = 0 then result := -1;
  end;
end;


function TXLSReader.ParseIncludedBof(Data: TXLSBlob): integer;
Var BofType: Word;
begin
  Result := 1; 
  if Data.DataLength > 4 then begin
     BofType := Data.GetWord(2);
     case BofType of
        $0020: begin  //Included chart
                 FContext := 4;
                 //create chart
                 FBook.InitFormula();
                 FChart.Free;
                 FChart := nil;
                 FChart := TXLSCustomChart.Create(FBook._Formula, FBiffVersion);
                 FChart.AddData($0809, Data.DataLength, Data);
               end; 
     end;
  end;
end;


function TXLSReader.ParseWindow1(Data: TXLSBlob): integer;
begin
  Result := 1;
  if Data.DataLength >= 16 then begin
     FActiveSheetIndex    := Data.GetWord(10);
     FFirstSheetIndex     := Data.GetWord(12);
  end;
end;

function TXLSReader.ParseFilePass(Data: TXLSBlob): integer;
begin
//  if FBiffVersion >= $0600 then begin
     Result := FReadStream.ParseFilePass(Data);
//  end else begin
//     Result := -1000;
//  end;  
end;


function TXLSReader.ParseRefMode(Data: TXLSBlob): integer;
begin
  Result := 1;
  if Data.DataLength >= 2 then begin
     FBook.ReferenceStyle := Data.GetWord(0);
  end;
end;

function TXLSReader.ParseSupBook(Data: TXLSBlob): integer;
begin
  Result := FBook._Extern.SupBook.Parse(Data);
end;

function TXLSReader.ParseExternalName(Data: TXLSBlob): integer;
begin
  Result := FBook._Extern.SupBook.ParseExternalName(Data);
end;


function TXLSReader.ParseCodePage(Data: TXLSBlob): integer;
begin
  Result := 1;
  if Data.DataLength >= 2 then begin
     FCodePage := Data.GetWord(0);
     if FCodePage = 1200 then FCodePage := 1252;
  end;
end;

function TXLSReader.ParseDateMode(Data: TXLSBlob): integer;
begin
  Result := 1;
  if Data.DataLength >= 2 then begin
     FDateMode1904 := (Data.GetWord(0) = 1);
     FBook.Date1904 := FDateMode1904;
  end;
end;

function TXLSReader.ParseProtect(Data: TXLSBlob): integer;
begin
  Result := 1;
  if Data.DataLength >= 2 then 
     if Data.GetWord(0) = 1 then 
        case FContext of
           1: FBook._Protect.SetProtected(true);
           2: FBook.Sheets[FSheetCount]._Protect.SetProtected(true);
        end;
end;

function TXLSReader.ParseSheetProtect(Data: TXLSBlob): integer;
begin
  Result := 1;
  if Data.DataLength >= 23 then 
      FBook.Sheets[FSheetCount]._Protect.SetOptions(Data.GetWord(19));
end;

function TXLSReader.ParsePassword(Data: TXLSBlob): integer;
begin
  Result := 1;
  if Data.DataLength >= 2 then 
     case FContext of
        1: FBook._Protect.ProtectEncode(Data.GetWord(0));
        2: FBook.Sheets[FSheetCount]._Protect.ProtectEncode(Data.GetWord(0));
     end;
end;

function TXLSReader.ParseVBAObjectName(Data: TXLSBlob): integer;
Var Name: WideString;
    index: LongWord;
begin
  Result := 1;
  if Data.DataLength >= 4 then begin
     index := 0; 
     Name := Data.GetBiffString(index, false, true); 
     case FContext of
        1: FBook._VBAObjectName := Name;
        2: FBook.Sheets[FSheetCount]._VBAObjectName := Name;
     end;
  end;
end;


function TXLSReader.ParseFont(Data: TXLSBlob): integer;
Var f: TXLSStyleFont;
    Value: Word;
    Len: Word;
begin
  Result := 1;
  f := TXLSStyleFont.Create();
  if Data.DataLength >= 15 then begin
     f.Size := Data.GetWord(0) / 20;
     f.Color.Assign(0, Data.GetWord(4), 0);
     f.Bold := Data.GetWord(6) > 400;
     Value := Data.GetWord(2); //grbit        
     f.Italic        := ((Value shr 1) and 1) = 1; //italic (10)
     f.Strikethrough := ((Value shr 3) and 1) = 1; //Strikethrough (11)
     f.OutLineFont   := ((Value shr 4) and 1) = 1; //OutLineFont (12)
     f.shadow        := ((Value shr 5) and 1) = 1; //shadow   (13)

     f.Underline := Data.GetByte(10);       //Underline type (14-15)
     f.SubScript := ((Data.GetWord(8) shr 1) and 1) = 1;
     f.SuperScript := (Data.GetWord(8) and 1) = 1;
     f.Family := Data.GetByte(11);
     f.CharSet := Data.GetByte(12);
     Len := Data.GetByte(14);  //Font Name Length
     if FBiffVersion >= $0600 then begin
        Value :=  Data.GetByte(15); //unicode option 
        if Value = 1 then begin
           if Data.DataLength < (16 + Len * 2) then Result := -1;
           if Result = 1 then
              f.Name := Data.GetWideString(16, Len * 2);
        end else begin
           if Data.DataLength < (16 + Len) then Result := -1;
           if Result = 1 then
           f.Name := StringToWideStringEx(Data.GetString(16, Len), FCodePage);
        end;
     end else begin
        if Data.DataLength < (15 + Len) then Result := -1;
        if Result = 1 then
           f.Name := StringToWideStringEx(Data.GetString(15, Len), FCodePage);  
     end;
  end else Result := -1;
  if Result = 1 then begin
     FBook._XFList.Fonts.SetKeyItem(FFontCount, f);
     Inc(FFontCount);
  end else begin
     f.Free;
     with FBook._XFList.Fonts do  
       SetKeyItem(FFontCount, DefaultKey.Clone());
     Inc(FFontCount);
  end;
end;

function TXLSReader.ParseNumFormat(Data: TXLSBlob): integer;
Var Index: Word;
    Format: WideString;
    Offset: LongWord;
begin
  Result := 1;
  Index := Data.GetWord(0);
  offset := 2;
  if FBiffVersion >= $0600 then begin
     Format := Data.GetBiffString(offset, false, true);
  end else begin
     Format := Data.GetBiffString(offset, true, false);
  end;
  FBook._XFList.Formats.Value[Index] := Format;
end;

function TXLSReader.ParseBoundSheet(Data: TXLSBlob): integer;
Var grbit: byte;
    offset: longword;
begin
  Result := 1;
  grbit := Data.GetByte(5);
  if (grbit = 0 {workbook}) or 
     (grbit = 2 {chart}) then begin 
     offset := 6; 
     With FBook.Sheets.Add() do begin
        Name := Data.GetBiffString(offset, true, (FBiffVersion >= $0600));
        Visible := Data.GetByte(4);
     end;
  end;    
end;

function TXLSReader.ParsePalette(Data: TXLSBlob): integer;
Var ccv, i: word;
    Color: LongWord;
begin
  Result := 1;
  ccv := Data.GetWord(0);
  for i := 0 to ccv - 1 do begin
     Color := Data.GetByte(2 + i * 4);
     Color := Color or (Data.GetByte(2 + i * 4 + 1) shl 8);
     Color := Color or (Data.GetByte(2 + i * 4 + 2) shl 16);
     FBook.Colors[i + 1, 0] := Color;
  end;
end;

function TXLSReader.ParseExterns(Data: TXLSBlob): integer;
Var cnt, i: integer;
    sbi: integer;
    offset: integer; 
    ish1,ish2: integer;
    {$ifdef D2009}
    sheetname: AnsiString;
    {$else}
    sheetname: string;
    {$endif}
begin
  Result := 1;
  if FBiffVersion >= $0600 then begin
     offset := 0;
     cnt := Data.GetWord(offset); offset := offset + 2;
     if cnt > 0 then begin
        for i := 1 to cnt do begin
          sbi  := Data.GetWord(offset); offset := offset + 2;
          ish1 := Data.GetWord(offset); offset := offset + 2;
          ish2 := Data.GetWord(offset); offset := offset + 2; 
//          if sbi = 0 then begin
             FBook._Extern.AddExtern(i, sbi, ish1 + 1, ish2 + 1);  
//          end; 
        end;
     end;
  end else begin
    cnt := Data.DataLength - 1;
    offset := 1;
//    sheetid := FBook.GetNewSheetID;
    if Data.GetByte(offset) = $03 then begin
       cnt := cnt - 1;
       Inc(offset);
       sheetname := Data.GetString(offset, cnt);
       //Store Sheet ID
//       FCachedSheetID[sheetname] := sheetid;  
//       FBook._Extern.AddExternIDBySheetID(sheetid, sheetid, sheetid);   
    end else begin
       sheetname := '';
    end;   
    FExcel5LocalLinkTable[FExcel5LocalLinkTable.Count + 1] := StringToWideStringEx(sheetname, FCodePage);
  end;
end;


function TXLSReader.ParseCFHeader(DataList: TXLSBlobArray): integer;
begin
   FBook.Sheets[FSheetCount]._CF.Parse($01B0, DataList);
   Result := 1;
end;

function TXLSReader.ParseDVHeader(DataList: TXLSBlobArray): integer;
begin
   FBook.Sheets[FSheetCount]._DV.Parse($01B2, DataList);
   Result := 1;
end;

function TXLSReader.ParseCFRule(DataList: TXLSBlobArray): integer;
begin
   FBook.Sheets[FSheetCount]._CF.Parse($01B1, DataList);
   Result := 1;
end;

function TXLSReader.ParseDVItem(DataList: TXLSBlobArray): integer;
begin
   FBook.Sheets[FSheetCount]._DV.Parse($01BE, DataList);
   Result := 1;
end;


function TXLSReader.ParseMsoDrawingGroup(DataList: TXLSBlobArray): integer;
begin
  if FBook._DisableGraphics then begin
     Result := 1; 
  end else begin
     Result := FBook.DrawingGroup.Parse(DataList);
  end;
end;


function TXLSReader.ParseMsoDrawing(DataList: TXLSBlobArray): integer;
begin
  if FBook._DisableGraphics then begin
     Result := 1; 
  end else begin
     Result := FBook.Sheets[FSheetCount]._Drawing.Parse(DataList);
  end;
end;

function TXLSReader.ParseObject(DataList: TXLSBlobArray): integer;
begin
  Result := 1; 
  if not(FBook._DisableGraphics) then begin
     FBook.Sheets[FSheetCount]._Drawing.ParseObj(DataList);
  end;
end;

function TXLSReader.ParseTXO(DataList: TXLSBlobArray): integer;
Var Decrypt: boolean;
begin
  if not(FBook._DisableGraphics) then begin
     Decrypt := FBook._Protect.IsProtected and FBook._Protect.IsPassword and not(FReadStream.IsEncrypted);
     FBook.Sheets[FSheetCount]._Drawing.ParseTXO(DataList, Decrypt);
  end;
  Result := 1;
end;

{
Procedure DumpData(D: TXLSBlob);
Var i, cnt: LongWord;
    c: Byte;
    cc: Byte;
begin
   cnt := D.GetBuffSize;
   c := 0;
   cc:= 0;
   for i:= 0 to cnt - 1 do begin
      write(inttohex(D.GetByte(i), 2), ' ');
      if c = 3 then begin
         write(' ');
         c := 0;
         if (cc = 3) and (i < (cnt - 1))then begin
            w riteln;
            w rite('               ');
            cc := 0;
         end
         else Inc(cc);
      end
      else Inc(c);
   end;
end;
}

function TXLSReader.ParseStyle(Data: TXLSBlob): integer;
Var XFIndex: Word;
    Index: Word;
    Len: Word;
    Name: WideString;
    Code: Byte;
    ilevel: integer;
    bv: byte;
begin
  Result := 1;
  Index := Data.GetWord(0);
  XFIndex := (Index and $FFF);
  if (Index and $8000) = $8000 then  begin
     //builtin style
     Code := Data.GetByte(2);
     bv := Data.GetByte(3);
     ilevel := bv;
     if bv = $FF then ilevel := -1;
     if XFIndex < FBook._XFList.ListSize then begin
         FBook._XFList.Styles.AddBuiltinStyle(Code, XFIndex, ilevel);
         FBook._XFList.IncReferredCount(XFIndex);   
     end;
  end else begin
     //custom style
     if FBiffVersion >= $0600 then begin
        Len := Data.GetWord(2);
        if Data.GetByte(4) = 1 then begin
           Name := Data.GetWideString(5, Len * 2);
        end else begin
           Name := StringToWideStringEx(Data.GetString(5, Len), FCodePage);
        end;
     end else begin
        Len    := Data.GetByte(2);
        Name := StringToWideStringEx(Data.GetString(4, Len), FCodePage);
     end; 
     if Name <> '' then begin
        FBook._XFList.Styles.AddStyle(Name, XFIndex);
        FBook._XFList.IncReferredCount(XFIndex);   
     end;  
  end;
end;

function TXLSReader.ParseXF(Data: TXLSBlob): integer;
Var xf: TXLSStyleXF;
    Orientation: Byte;
    Value : LongWord;
    W: LongWord;
    fnti: Word;
    b: TXLSStyleBorder;
    f: TXLSStyleFill;
    wval: word;
    bval: byte;
begin
  Result := 1;
  xf := TXLSStyleXF.Create();
  fnti := Data.GetWord(0);
  if fnti >= 5 then dec(fnti);
  xf.FontIndex := fnti;
  xf.NumFormatIndex := Data.GetWord(2);
  xf.Protection := Data.GetWord(4) and 7;
  wval := (Data.GetWord(4) and $FFF0) shr 4;
  if wval = $FFF then begin
     xf.ParentStyleIndex := -1; 
     xf.IsStyleXF := true;
  end else begin
     xf.ParentStyleIndex := wval; 
  end;

  bval := Data.GetByte(6);
  xf.HorAlign := bval and 7;
  xf.WrapText := (bval and 8) > 0;
  xf.VerAlign := (bval shr 4) and 7;

  if (FBiffVersion >= $0500) and (FBiffVersion < $0600) then begin
     //BIFF5-7
     Orientation := Data.GetByte(7) and 3;
     case Orientation of 
        1: Orientation := 255;
        2: Orientation := 90;
        3: Orientation := 180;
     end;
  end else begin 
     //BIFF8
     Orientation := Data.GetByte(7);
  end;
  xf.Orientation := Orientation;

  if (FBiffVersion >= $0500) and (FBiffVersion < $0600) then begin
     //skip
  end else begin
     bval := Data.GetByte(8);
     xf.IndentLevel := bval and $0F;
     xf.ShrinkToFit := (bval and $10) > 0;
     xf.ReadingOrder := ((bval and $C0) shr 6);
  end;

  //borders
  if (FBiffVersion >= $0500) and (FBiffVersion < $0600) then begin
     Value := 0;
     W := Data.GetWord(10);
     Value := Value or ((W shl 6) and $7000);
     W := Data.GetWord(12);
     Value := Value or ((W shl 8) and $0700);
     Value := Value or ((W shr 3) and $0007);
     Value := Value or ((W shr 2) and $0070);
     W := Data.GetWord(14);
     Value := Value or ((W shl 16) and $7F0000);
     Value := Value or ((W shl 16) and $3F800000);
  end else begin
     Value := Data.GetLong(10);
  end;

  b := TXLSStyleBorder.Create();
  b.Left.Style := Value and $F;
  b.Right.Style := (Value and $F0) shr 4;
  b.Top.Style := (Value and $F00) shr 8;
  b.Bottom.Style := (Value and $F000) shr 12;
  b.Left.Color.Assign(0, (Value and $7F0000) shr 16, 0);
  b.Right.Color.Assign(0, (Value and $3F800000) shr 23, 0);
  b.DiagonalUp := (Value and $80000000) > 0;
  b.DiagonalDown := (Value and $40000000) > 0;

  if (FBiffVersion >= $0500) and (FBiffVersion < $0600) then begin
     Value := 0;
     W := Data.GetWord(10);
     Value := Value or ((W shr 2) and $3F80);
     W := Data.GetWord(12);
     Value := Value or ((W shr 9) and $7F);
  end else begin
     Value := Data.GetLong(14) and ($FFFFFFFF-$FC000000);
  end;

  b.Top.Color.Assign(0, (Value and $7F), 0);
  b.Bottom.Color.Assign(0,   ((Value shr 7) and $7F), 0);
  b.Diagonal.Color.Assign(0, ((Value shr 14) and $7F), 0);
  b.Diagonal.Style := (Value shr 21) and $0F;

  Value := FBook._XFList.Borders.SetKey(-1, b, true);
  xf.BorderIndex := Value;

  //pattern
  f := TXLSStyleFill.Create;
  if (FBiffVersion >= $0500) and (FBiffVersion < $0600) then begin
     Value := (Data.GetLong(8) shr 16)  and $3F;
  end else begin
     Value := (Data.GetLong(14) shr 26) and $3F;
  end;

  f.PatternType := Value;
  if (FBiffVersion >= $0500) and (FBiffVersion < $0600) then begin
     Value := Data.GetWord(8);
  end else begin
     Value := Data.GetWord(18);
  end;
  f.FgColor.Assign(0, (Value and $7F), 0);
  f.BgColor.Assign(0, ((Value shr 7) and $7F), 0);

  Value := FBook._XFList.Fills.SetKey(-1, f, true);
  xf.FillIndex := Value;
 
  if (FBiffVersion >= $0500) and (FBiffVersion < $0600) then begin
     Value := (Data.GetByte(7) shr 2) and 63;
  end else begin
     Value := (Data.GetByte(9) shr 2) and 63;
  end;
  xf.UsedAttributes := Value;

  FBook._XFList.SetKeyItem(FXFCount, xf);

  Inc(FXFCount);
end;

function TXLSReader.ParseDouble(Data: TXLSBlob): integer;
Var row, col: Word;
    xf: Word;
    Value: Double;
    isdt: boolean;
    sheet: IXLSWorksheet;
    ReplaceIndex: boolean;
begin
  Result := 1;
  row := Data.GetWord(0);
  col := Data.GetWord(2);
  xf := Data.GetWord(4);
  Value := Data.GetDouble(6);
  sheet := FBook.Sheets[FSheetCount];
  sheet._SetXF(row, col, xf);

  if FBook.Date1904 then begin
     if xf > 0 then begin
        isdt := FBook._XFList.isDateFormat(xf);
     end else begin
        isdt := FBook._XFList.isDateFormat(sheet.GetXFIndex(row, col, ReplaceIndex));
     end;

     if isdt then begin
        Value := Value + 1462; 
     end;
  end; 
  sheet.Cells[row + 1, col + 1].Value := Value; 
end;

function TXLSReader.ParseBoolean(Data: TXLSBlob): integer;
Var row, col: Word;
    xf: Word;
    Value: Boolean;
    Opt: byte;
begin
  Result := 1;
  row := Data.GetWord(0);
  col := Data.GetWord(2);
  xf := Data.GetWord(4);
  Value := (Data.GetByte(6) = 1);
  Opt    := Data.GetByte(7);
  if Opt = 0 then begin
     FBook.Sheets[FSheetCount].Cells[row + 1, col + 1].Value := Value; 
  end;
  FBook.Sheets[FSheetCount]._SetXF(row, col, xf);
end;


function TXLSReader.ParseFormula(Data: TXLSBlob): integer;
Var row, col: Word;
    xf: Word;
    Value: TXLSCompiledFormula;
    opt: word; 
    srow, scol: Word;
    ArrayFormula: TXLSArrayFormula; 
    Formula: TXLSCompiledFormula;
    fExpr0: integer;
    ftype: integer;
    FormulaResult: variant;
    SetFormulaResult: boolean;
begin
  Result := 1;
  FSharedFormulaRow := -1;
  FSharedFormulaCol := -1;
  FLastFormulaRow := -1;
  FLastFormulaCol := -1;


  row := Data.GetWord(0);
  col := Data.GetWord(2);
  xf := Data.GetWord(4);
  opt := Data.GetWord(14); 
  FBook.InitFormula;
  SetFormulaResult := false;
  FormulaResult := 0;
  
  if ((opt and $0003) = $0000) then begin 
     //try to get the value
     fExpr0 := Data.GetWord(12);
     if (fExpr0 = $FFFF) then begin
        ftype := Data.GetByte(6);
        if (ftype = 0) then begin
           //string
           FLastFormulaRow := row;
           FLastFormulaCol := col;
        end else if (ftype = 1) then begin
           //bool
           FormulaResult := boolean(Data.GetByte(8) > 0); 
           SetFormulaResult := true; 
        end else if (ftype = 2) then begin
           //boolerr 
        end;     
     end else begin
       //double value
       FormulaResult := Data.GetDouble(6);
       SetFormulaResult := true; 
     end;
  end;

  if {((opt and $0008) = $0008) and}
     (Data.GetByte(22) = $01) then begin
        //tExp
        srow := Data.GetWord(23);
        scol := Data.GetWord(25);

        if (srow = row) and (scol = col) then begin
           //first formula for shared formula
           FSharedFormulaRow := row;
           FSharedFormulaCol := col;
           FSharedFormulaSetResult := false;
           if SetFormulaResult then begin
              Value := FBook.Sheets[FSheetCount]._GetCompiledFormula(srow, scol);
              if Assigned(Value) then begin
                 Value.Value := FormulaResult;
                 Value.ChangeID := 1;
              end else begin
                 FSharedFormulaSetResult := true;
                 FSharedFormulaResult := FormulaResult;
              end; 
           end;
        end else begin
           //next formula for shared or array formula
           Value := FBook.Sheets[FSheetCount]._GetCompiledFormula(srow, scol);
           if Assigned(Value) then begin
              if Value.IsArrayFormula then begin
                 //array formula
                 if Value.ArrayFormula.IsRootFormula then begin
                    ArrayFormula := TXLSArrayFormula.Create(srow, scol, Value);
                    Formula := TXLSCompiledFormula.Create(ArrayFormula);
                    FBook.Sheets[FSheetCount]._SetCompiledFormula(row, col, Formula);
                 end;
              end else begin 
                 //shared formula
                 Value := Value.GetCopy();
                 if Assigned(Value) and SetFormulaResult then begin
                    Value.Value := FormulaResult;
                    Value.ChangeID := 1;
                 end;
                 FBook.Sheets[FSheetCount]._SetCompiledFormula(row, col, Value);
              end;
           end;
        end;
  end else begin
    Value := FBook._Formula.GetTranslatedFormula(Data, 20, FBiffVersion);
    if Assigned(Value) then begin
       if SetFormulaResult then begin
          Value.Value := FormulaResult;
          Value.ChangeID := 1;
       end;
       FBook.Sheets[FSheetCount]._SetCompiledFormula(row, col, Value);
    end;
  end;
  FBook.Sheets[FSheetCount]._SetXF(row, col, xf);
end;

function TXLSReader.ParseSharedFormula(Data: TXLSBlob): integer;
Var fr, lr: integer;
    fc, lc: integer;
    Value: TXLSCompiledFormula;
begin
  Result := 1;
  fr := Data.GetWord(0);
  lr := Data.GetWord(2);
  fc := Data.GetByte(4);
  lc := Data.GetWord(5);
  FBook.InitFormula;

  if (FSharedFormulaRow >= 0)  and
     (FSharedFormulaCol >= 0)  and
     (FSharedFormulaRow >= fr) and
     (FSharedFormulaRow <= lr) and
     (FSharedFormulaCol >= fc) and
     (FSharedFormulaCol <= lc) then begin
     Value := FBook._Formula.GetTranslatedFormula(Data, 8, FBiffVersion); 
     if Assigned(Value) then begin
        if (FSharedFormulaSetResult) then begin 
           Value.Value := FSharedFormulaResult;
           FSharedFormulaSetResult := false;
           Value.ChangeID := 1;
        end;
        FBook.Sheets[FSheetCount]._SetCompiledFormula(FSharedFormulaRow, FSharedFormulaCol, Value);
     end;   
  end;
  FSharedFormulaRow := -1;
  FSharedFormulaCol := -1;
end;


function TXLSReader.ParseArrayFormula(Data: TXLSBlob): integer;
Var fr, lr: integer;
    fc, lc: integer;
//    opt: word;
    Value: TXLSCompiledFormula;
    ArrayFormula: TXLSArrayFormula;
begin
  Result := 1;
  fr := Data.GetWord(0);
  lr := Data.GetWord(2);
  fc := Data.GetByte(4);
  lc := Data.GetByte(5);
//  opt := Data.GetWord(6);

  FBook.InitFormula;

  if (FSharedFormulaRow >= 0)  and
     (FSharedFormulaCol >= 0)  and
     (FSharedFormulaRow >= fr) and
     (FSharedFormulaRow <= lr) and
     (FSharedFormulaCol >= fc) and
     (FSharedFormulaCol <= lc) then begin

     Value := FBook._Formula.GetTranslatedFormula(Data, 12, FBiffVersion); 
     if Assigned(Value) then begin
        ArrayFormula := TXLSArrayFormula.Create(FSharedFormulaRow, FSharedFormulaCol,
                        fr, fc, lr, lc,
                        Value);
        Value.SetArrayFormula(ArrayFormula);  
        FBook.Sheets[FSheetCount]._SetCompiledFormula(FSharedFormulaRow, FSharedFormulaCol, Value);
     end;   
  end;
  FSharedFormulaRow := -1;
  FSharedFormulaCol := -1;
end;

function TXLSReader.ParseString(Data: TXLSBlob): integer;
var 
    cFormula: TXLSCompiledFormula;
    res: widestring;
    index: longword;
begin
  Result := 1;
  if (FLastFormulaRow >= 0) and (FLastFormulaCol >= 0) then begin
     cFormula := FBook.Sheets[FSheetCount]._GetCompiledFormula(FLastFormulaRow, FLastFormulaCol);
     if Assigned(cFormula) then begin
       index := 0; 
       res := Data.GetBiffString(index, false, true); 
       cFormula.Value := res;
       cFormula.ChangeId := 1;
     end;
  end; 
end;

function TXLSReader.ParseRK(Data: TXLSBlob): integer;
Var row, col: Word;
    xf:      Word;
    Value : Double;
    isdt: boolean;
    sheet: IXLSWorksheet;
    ReplaceIndex: boolean;
begin
  Result := 1;
  row := Data.GetWord(0); col   := Data.GetWord(2);
  xf  := Data.GetWord(4); Value := RK2Double(Data.GetLong(6));
  sheet := FBook.Sheets[FSheetCount];
  sheet._SetXF(row, col, xf);

  if FBook.Date1904 then begin
     if xf > 0 then begin
        isdt := FBook._XFList.isDateFormat(xf);
     end else begin
        isdt := FBook._XFList.isDateFormat(sheet.GetXFIndex(row, col, ReplaceIndex));
     end;

     if isdt then begin
        Value := Value + 1462; 
     end;
  end; 
  sheet.Cells[row + 1, col + 1].Value := Value; 
end;

function TXLSReader.ParseBlank(Data: TXLSBlob): integer;
Var row, col: Word;
    xf:      Word;
begin
  Result := 1;
  row := Data.GetWord(0); col   := Data.GetWord(2);
  xf  := Data.GetWord(4); 
  FBook.Sheets[FSheetCount].Cells[row + 1, col + 1].Value := null; 
  FBook.Sheets[FSheetCount]._SetXF(row, col, xf);
end;


function TXLSReader.ParseMulBlank(Data: TXLSBlob): integer;
Var row, scol, colcnt, col: Word;
    xf:      Word;
begin
  Result := 1;
  colcnt := (Data.DataLength - 6) div 2;
  if colcnt > 0 then begin
     row  := Data.GetWord(0); 
     scol := Data.GetWord(2);
     for col := 0 to  colcnt - 1 do begin
         xf  := Data.GetWord(4 + col * 2 ); 
         FBook.Sheets[FSheetCount].Cells[row + 1, col + scol + 1].Value := Null; 
         FBook.Sheets[FSheetCount]._SetXF(row, col + scol, xf);
     end;
  end;
end;

function TXLSReader.ParseMergedCells(Data: TXLSBlob): integer;
Var row1, col1, row2, col2: Word;
    i, cnt: integer;
begin
  Result := 1;
  cnt := Data.GetWord(0);
  if cnt > 0 then begin
     for i := 0 to  cnt - 1 do begin
         row1 := Data.GetWord(2 + i * 8 + 0);
         row2 := Data.GetWord(2 + i * 8 + 2);
         col1 := Data.GetWord(2 + i * 8 + 4);
         col2 := Data.GetWord(2 + i * 8 + 6);
         FBook.Sheets[FSheetCount].RCRange[row1 + 1, col1 + 1, row2 + 1, col2 + 1].Merge(false); 
     end;
  end;
end;

function TXLSReader.ParseMargin(Data: TXLSBlob; Side: integer): integer;
Var Margin: Double;
begin
  Result := 1;
  Margin := Data.GetDouble(0);
  case Side of
     1: FBook.Sheets[FSheetCount].PageSetup.LeftMargin   := Margin;
     2: FBook.Sheets[FSheetCount].PageSetup.RightMargin  := Margin;
     3: FBook.Sheets[FSheetCount].PageSetup.TopMargin    := Margin;
     4: FBook.Sheets[FSheetCount].PageSetup.BottomMargin := Margin;
  end;
end;

function TXLSReader.ParseZoom(Data: TXLSBlob): integer;
Var Value1, Value2: Word;
    Value : integer;
begin
  Result := 1;
  Value1 := Data.GetWord(0);
  Value2 := Data.GetWord(2);
  if Value2 > 0 then begin 
     Value := Round((Value1/Value2) * 100); 
     FBook.Sheets[FSheetCount].Zoom := Value;
  end;
end;

function TXLSReader.ParseCenter(Data: TXLSBlob; Orient: integer): integer;
Var Value: boolean;
begin
  Result := 1;
  Value := (Data.GetWord(0) = 1);
  case Orient of
     1: FBook.Sheets[FSheetCount].PageSetup.CenterHorizontally := Value;
     2: FBook.Sheets[FSheetCount].PageSetup.CenterVertically   := Value;
  end;
end;

function TXLSReader.ParseHeaderFooter(Data: TXLSBlob; Orient: integer): integer;
Var Value: WideString;
    Left, Right, Center: WideString;
    lpos: integer;
    index: longword;
begin
  Result := 1;
  index := 0;
  if FBiffVersion >= $0600 then begin
     Value := Data.GetBiffString(index, false, true);
  end else begin
     Value := Data.GetBiffString(index, true, false);
  end;

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

  case Orient of
     1: begin
          FBook.Sheets[FSheetCount].PageSetup.LeftHeader   := Left;
          FBook.Sheets[FSheetCount].PageSetup.CenterHeader := Center;
          FBook.Sheets[FSheetCount].PageSetup.RightHeader  := Right;
        end;
     2: begin
          FBook.Sheets[FSheetCount].PageSetup.LeftFooter   := Left;
          FBook.Sheets[FSheetCount].PageSetup.CenterFooter := Center;
          FBook.Sheets[FSheetCount].PageSetup.RightFooter  := Right;
        end;
  end;
end;


function TXLSReader.ParseLabelSST(Data: TXLSBlob): integer;
Var row, col: Word;
    xf:      Word;
    ind: LongWord;
    Value : WideString;
begin
  Result := 1;
  row := Data.GetWord(0); col   := Data.GetWord(2);
  xf  := Data.GetWord(4); ind   := Data.GetLong(6); 
  Value := FStringTable[ind+1];
  FBook.Sheets[FSheetCount].Cells[row + 1, col + 1].Value := '''' + Value; 
  FBook.Sheets[FSheetCount]._SetXF(row, col, xf);
end;

function TXLSReader.ParseLabel(Data: TXLSBlob): integer;
Var row, col: Word;
    xf:       Word;
    Value:    WideString;
    sz:       Word;
    opt:      byte;
    offset:   integer;
begin
  Result := 1;
  row := Data.GetWord(0); col   := Data.GetWord(2);
  xf  := Data.GetWord(4); sz   := Data.GetWord(6); 
  offset := 8; 
  opt := 0;
  if FBiffVersion >= $0600 then begin
     opt := Data.GetByte(offset);
     inc(offset);
  end;
  if opt = 0 then 
     Value := StringToWideStringEx(Data.GetString(offset, sz), FCodePage)
  else if opt = 1 then 
     Value := Data.GetWideString(offset, (sz * 2))
  else Value := '';

  FBook.Sheets[FSheetCount].Cells[row + 1, col + 1].Value := '''' + Value; 
  FBook.Sheets[FSheetCount]._SetXF(row, col, xf);
end;

function TXLSReader.ParseRString(Data: TXLSBlob): integer;
Var row, col: Word;
    xf:       Word;
    Value:    WideString;
    offset:   longword;
begin
  Result := 1;
  row := Data.GetWord(0); 
  col   := Data.GetWord(2);
  xf  := Data.GetWord(4); 
  Offset := 6;
  Value := Data.GetBiffString(Offset, false, (FBiffVersion >= $0600));
  FBook.Sheets[FSheetCount].Cells[row + 1, col + 1].Value := '''' + Value; 
  FBook.Sheets[FSheetCount]._SetXF(row, col, xf);
end;


function TXLSReader.ParseColinfo(Data: TXLSBlob): integer;
Var col1, col2: Word;
    xf:    Word;
    Width: Word;
    Opt: Word;
    i: integer;
    hidden: boolean;
    outlinelevel: byte;
begin
  Result := 1;
  col1 := Data.GetWord(0);  col2   := Data.GetWord(2);
  Width := Data.GetWord(4); xf  := Data.GetWord(6);
  Opt := Data.GetWord(8);
  hidden := (Opt and $0001) = 1;
  outlinelevel := ((Opt and $0700) shr 8) + 1;
  if col1 <= col2 then begin
     for i := col1 to col2 do begin
         FBook.Sheets[FSheetCount]._ColumnInfo._SetColInfo(i, width, hidden, xf, outlinelevel);
     end;  
  end;
end;

function TXLSReader.ParseRowInfo(Data: TXLSBlob): integer;
Var row: word;
    h: word;
    isht: boolean;
    ishd: boolean;
    isxf: boolean;
    opt: LongWord;
    unsynced: boolean;
    xf: Word;
    outlinelevel: byte;
begin
  Result := 1;
  row := Data.GetWord(0);
  h := Data.GetWord(6);
  if (h and $8000) = $8000 then begin
     isht := false;
     h := h and $7FFF;
  end else begin
     isht := true;
  end;
  opt := Data.GetLong(12);
  outlinelevel := (opt and $07) + 1;
  isxf := ((opt and $80) = $80);
  ishd := ((opt and $20) = $20);
  unsynced := ((opt and $40) = $40);
  xf := ((opt and $FFF0000) shr 16);
  FBook.Sheets[FSheetCount]._RowInfo._SetRowInfo(row, h, isht, xf, isxf, ishd, outlinelevel, unsynced);
end;


function TXLSReader.ParseSelection(Data: TXLSBlob): integer;
Var 
    row1, col1, row2, col2: integer;
    ind: word; 
    offset: integer;
begin
  Result := 1;
  ind := Data.GetWord(5);
  offset := ind * 6 + 9;
  row1 := Data.GetWord(offset);
  row2 := Data.GetWord(offset + 2);
  if (row1 = 0) and (row2 = 16383) then row2 := xlsMaxRow;
  col1 := Data.GetByte(offset + 4);
  col2 := Data.GetByte(offset + 5);
  FBook.Sheets[FSheetCount].RCRange[row1 + 1, col1 + 1, row2 + 1, col2 + 1].Select;
end;

function TXLSReader.ParsePanes(Data: TXLSBlob): integer;
Var  x, y, rowtop, colleft: word;
begin
  Result := 1;
  x := Data.GetWord(0);
  y := Data.GetWord(2);
  rowtop := Data.GetWord(4);
  colleft := Data.GetWord(6);
  if FFrozen then
     FBook.Sheets[FSheetCount].FreezePanes(y, x, rowtop, colleft)
  else
     FBook.Sheets[FSheetCount].ThawPanes((y - 255)/20, (x - 390)/113.879, rowtop, colleft);
end;

function TXLSReader.ParseWindow2(Data: TXLSBlob): integer;
Var  Value: word;
begin
  Result := 1;
  Value := Data.GetWord(0);
  With FBook.Sheets[FSheetCount] do begin

     DisplayGridLines   := (Value and $0002) = $0002;
     FFrozen            := (Value and $0008) = $0008;
     DisplayZeros       := (Value and $0010) = $0010; 
     DisplayRightToLeft := (Value and $0040) = $0040;

     if (Value and $0200) = $0200 then Select(false);
//   if (Value and $0400) <> $0400 then Hide; !!!!  //not visible sheet
     Selected := ((Value and $0200) = $0200); //selected sheet
     if (Value and $0800) = $0800 then View := xlPageBreakPreview;  
  end;
  Value := Data.GetWord(2);
  FBook.Sheets[FSheetCount].ScrollRow := Value + 1;
  Value := Data.GetWord(4);
  FBook.Sheets[FSheetCount].ScrollColumn := Value + 1;
end;

function TXLSReader.ParseSetup(Data: TXLSBlob): integer;
Var  Value: Word;
begin
  Result := 1;
  With FBook.Sheets[FSheetCount].PageSetup do begin
          PaperSize := Data.GetWord(0); //PaperSize
               Zoom := Data.GetWord(2); //Scaling factor in percent
//                     Data.GetWord(4); //Start page number 
     FitToPagesWide := Data.GetWord(6); //Fit worksheet width to this number of pages (0 = use as many as needed)
     FitToPagesTall := Data.GetWord(8); //Fit worksheet width to this number of pages (0 = use as many as needed)
              Value := Data.GetWord(10);      //Option flags
     Order := (Value and $0001);
     if (Value and $0002) > 0 then  Orientation := 1 //Portrait
                              else  Orientation := 2; //Landscape
     BlackAndWhite := (Value and $0008) > 0;
     Draft := (Value and $0010) > 0;
     PrintNotes := (Value and $0020) > 0;

       HeaderMargin := Data.GetDouble(16);
       FooterMargin := Data.GetDouble(24);
       Zoom := not(FIsFitToPages);
  end;
end;

function TXLSReader.ParseAutoFilterInfo(Data: TXLSBlob): integer;
Var AutofilterCount: word;
begin
  AutofilterCount := Data.GetWord(0);
  //!!!!
  if AutofilterCount > 0 then begin
     FBook.Sheets[FSheetCount]._Autofilter.SetFieldCount(AutofilterCount);
  end;

  Result := 1;
end;

function TXLSReader.ParseAutoFilterData(Data: TXLSBlob): integer;
begin
  Result := FBook.Sheets[FSheetCount]._Autofilter.ParseAutofilterData(Data, FBiffVersion);
end;


function TXLSReader.ParsePrintGridLines(Data: TXLSBlob): integer;
begin
  Result := 1;
  FBook.Sheets[FSheetCount].PageSetup.PrintGridlines := (Data.GetWord(0) = 1);
end;

function TXLSReader.ParseHBreaks(Data: TXLSBlob): integer;
Var cnt, i: Word;
    row: word;
begin
  Result := 1;
  cnt := Data.GetWord(0);
  if cnt > 0 then begin
     for i := 0 to cnt - 1 do begin
         if FBiffVersion >= $0600 then begin
            row := Data.GetWord(2 + i * 6);
         end else begin
            row := Data.GetWord(2 + i * 2);
         end;
         With FBook.Sheets[FSheetCount] do HPageBreaks.Add(Cells[row + 1, 1]);
     end;
  end;
end;

function TXLSReader.ParseVBreaks(Data: TXLSBlob): integer;
Var cnt, i: Word;
    col: word;
begin
  Result := 1;
  cnt := Data.GetWord(0);
  if cnt > 0 then begin
     for i := 0 to cnt - 1 do begin
         if FBiffVersion >= $0600 then begin
            col := Data.GetWord(2 + i * 6);
         end else begin
            col := Data.GetWord(2 + i * 2);
         end;
         With FBook.Sheets[FSheetCount] do VPageBreaks.Add(Cells[1, col + 1]);
     end;
  end;
end;

function TXLSReader.GetNameShortRange(Data: TXLSBlob; Var row1, row2, col1, col2, SheetIndex: integer): integer;
Var offs: integer;
begin
   if FBiffVersion >= $0600 then
      SheetIndex := Data.GetWord(8)
   else
      SheetIndex := Data.GetWord(6);

   if SheetIndex > 0 then begin
      if FBiffVersion >= $0600 then begin
         offs := 19;
         row1 := Data.GetWord(offs); Inc(offs, 2);
         row2 := Data.GetWord(offs); Inc(offs, 2); 
         col1 := Data.GetWord(offs); Inc(offs, 2);
         col2 := Data.GetWord(offs);// Inc(offs, 2);
      end else begin
         offs := 30;
         row1 := Data.GetWord(offs); Inc(offs, 2);
         row2 := Data.GetWord(offs); Inc(offs, 2);
         col1 := Data.GetByte(offs); Inc(offs, 1);
         col2 := Data.GetByte(offs);// Inc(offs, 1);
      end;
      Result := 1;
   end else begin
      Result := -1;
   end;
end;

function TXLSReader.GetNameLongRange(Data: TXLSBlob; Var row1, row2, col1, col2, SheetIndex: integer): integer;
Var offs: integer;
    r1, r2, c1, c2: integer;
    isrows: boolean;
    i: integer;
begin
   if FBiffVersion >= $0600 then
      SheetIndex := Data.GetWord(8)
   else
      SheetIndex := Data.GetWord(6);

   if SheetIndex > 0 then begin
      if FBiffVersion >= $0600 then begin
         for i := 1 to 2 do begin
           if i = 1 then offs := 22
                    else offs := 33; 
           r1 := Data.GetWord(offs); Inc(offs, 2);
           r2 := Data.GetWord(offs); Inc(offs, 2); 
           c1 := Data.GetWord(offs); Inc(offs, 2);
           c2 := Data.GetWord(offs);// Inc(offs, 2);
           isrows := ((c1 = 0) and (c2 = 255));
           if isrows then begin
              row1 := r1;
              row2 := r2;
           end else begin
              col1 := c1;
              col2 := c2;
           end; 
         end;
      end else begin
         for i := 1 to 2 do begin
           if i = 1 then offs := 33
                    else offs := 54; 
           r1 := Data.GetWord(offs); Inc(offs, 2);
           r2 := Data.GetWord(offs); Inc(offs, 2);
           c1 := Data.GetByte(offs); Inc(offs, 1);
           c2 := Data.GetByte(offs);// Inc(offs, 1);
           isrows := ((c1 = 0) and (c2 = 255));
           if isrows then begin
              row1 := r1;
              row2 := r2;
           end else begin
              col1 := c1;
              col2 := c2;
           end; 
         end;
      end;

      Result := 1;
   end else begin
      Result := -1;
   end;
end;


function TXLSReader.ParseNameShort(Data: TXLSBlob): integer;
var NameType: byte; 
    sheetindex, row1, row2, col1, col2: integer;
    isrows: boolean;
begin
   Result  := 1;
   NameType := 0;
   if FBiffVersion >= $0600 then begin
      //biff8 
      if (Data.GetByte(14) = 0) then
          NameType := Data.GetByte(15);

      if NameType = 6 then begin

         //print area 
         Result := GetNameShortRange(Data, row1, row2, col1, col2, SheetIndex);
         if Result = 1 then begin
            FSysNames.AddItem(NameType, SheetIndex, row1, row2, col1, col2);
            //w riteln('PrintArea sh=',sheetindex, ' r1=', row1, ' r2=', row2, ' c1=', col1, ' c2=', col2);
         end;

      end else if NameType = 7 then begin

         //PrintTitleShort
         Result := GetNameShortRange(Data, row1, row2, col1, col2, SheetIndex);
         if Result = 1 then begin
            isrows := ((col1 = 0) and (col2 = 255));
            if isrows then 
               FSysNames.AddItem(NameType, SheetIndex, row1, row2, -1, -1)
            else
               FSysNames.AddItem(NameType, SheetIndex, -1, -1, col1, col2);
         end;     

      end else if NameType = $0D then begin

         //autofilter
         Result := GetNameShortRange(Data, row1, row2, col1, col2, SheetIndex);
         if Result = 1 then begin
            FSysNames.AddItem(NameType, SheetIndex, row1, row2, -1, -1)
         end;     

      end;
   end else begin
      //biff5 
      NameType := Data.GetByte(14);
      if NameType = 6 then begin
         //print area 
         Result := GetNameShortRange(Data, row1, row2, col1, col2, SheetIndex);
         if Result = 1 then begin
            FSysNames.AddItem(NameType, SheetIndex, row1, row2, col1, col2);
         end; 
      end else if NameType = 7 then begin
         //PrintTitleShort
         Result := GetNameShortRange(Data, row1, row2, col1, col2, SheetIndex);
         if Result = 1 then begin
            isrows := ((col1 = 0) and (col2 = 255));
            if isrows then 
               FSysNames.AddItem(NameType, SheetIndex, row1, row2, -1, -1)
            else
               FSysNames.AddItem(NameType, SheetIndex, -1, -1, col1, col2);
         end;
      end else if NameType = $0D then begin
         //Autofilter
         Result := GetNameShortRange(Data, row1, row2, col1, col2, SheetIndex);
         if Result = 1 then begin
            FSysNames.AddItem(NameType, SheetIndex, row1, row2, col1, col2);
         end;
      end;
   end;    

end;

function TXLSReader.ParseNameLong(Data: TXLSBlob): integer;
var NameType: byte; 
    sheetindex, row1, row2, col1, col2: integer;
begin
   Result  := 1;
   NameType := 0;
   if FBiffVersion >= $0600 then begin
      //biff8 
      if (Data.GetByte(14) = 0) then
          NameType := Data.GetByte(15);
      if NameType = 7 then begin
         //PrintTitleShort
         Result := GetNameLongRange(Data, row1, row2, col1, col2, SheetIndex);
         if Result = 1 then begin
            FSysNames.AddItem(7, SheetIndex, row1, row2, -1, -1);
            FSysNames.AddItem(7, SheetIndex, -1, -1, col1, col2);
         end;
      end;
   end else begin
      //biff5 
      NameType := Data.GetByte(14);
      if NameType = 7 then begin
         //PrintTitleShort
         Result := GetNameLongRange(Data, row1, row2, col1, col2, SheetIndex);
         if Result = 1 then begin
            FSysNames.AddItem(7, SheetIndex, row1, row2, -1, -1);
            FSysNames.AddItem(7, SheetIndex, -1, -1, col1, col2);
         end;
      end;
   end;    
end;

function TXLSReader.ParseName(Data: TXLSBlob): integer;
Var grbit: word;
    lData: TXLSBlob;
begin
  //$06 - (short name) PrintArea
  //$07 - print title columns/rows
  Inc(FNameIndex);
  //check builtin name flag
  grbit := Data.GetWord(0);
  Result := 1;
  if (grbit and $0020) <> $0020 then begin
      //User defined name
      if FBiffVersion >= $0600 then begin
         ParseUserDefinedName(FNameIndex, Data);
      end else begin
         lData := TXLSBlob.Create(Data.DataLength);
         lData.CopyData(Data);
         FCachedNames[FCachedNames.Count + 1] := TXLSCachedNameEntry.Create(FNameIndex, lData);
      end;
  end else begin
      Result := 1;
      if Data.DataLength < $1B then exit;
      if FBiffVersion >= $0600 then begin
         //Biff8
         if Data.DataLength = $1B then
            ParseNameShort(Data)
         else if Data.DataLength = $2A then 
            ParseNameLong(Data);
      end else begin
         //Biff5
         if Data.DataLength = $24 then
            ParseNameShort(Data)
         else if Data.DataLength = $3D then 
            ParseNameLong(Data);
      end;
  end;
end;

function TXLSReader.ParseUserDefinedName(ANameID: integer; Data: TXLSBlob): integer;
Var grbit: word;
    sheetindex: integer;
    isUserDefined: boolean;
    isHidden: boolean;
//    isGlobalName: boolean;
    namelen: word;
    name: WideString;
    opt: byte;
    formulasize: integer;
    Offset: longword;
    formula: TXLSCompiledFormula;
    externid: integer;
    sheetname: widestring; 
begin
   Result := 1;
   grbit := Data.GetWord(0);
   isUserDefined := ((grbit and $0020) = $0000);
   isHidden      := ((grbit and $0001) = $0001);
   if FBiffVersion >= $0600 then begin
      sheetindex    := Data.GetWord(8);
   end else begin
      externid := smallint(Data.GetWord(6));
      if externid > 0 then begin
         sheetname := Excel5ExternID2Name(externid);
         Sheetindex := FBook.Sheets.IDByName[sheetname];
      end else if externid = 0 then begin
         sheetindex := 0;
      end else begin
         sheetindex := -1;
      end;
   end;
//   isGlobalName  := (sheetindex = 0);
   namelen       := Data.GetByte(3);
   formulasize   := Data.GetWord(4);
   formula       := nil;
   Offset   := 14;
   if (namelen > 0) and isUserDefined {and isGlobalName} then begin
      if FBiffVersion >= $0600 then begin
         opt :=  Data.GetByte(Offset); //unicode option 
         Inc(Offset);
         if opt = 1 then begin
            if Data.DataLength < (Offset + namelen * 2) then Result := -1;
            if Result = 1 then name := Data.GetWideString(Offset, namelen * 2);
            Offset := Offset + namelen * 2;
         end else begin
            if Data.DataLength < (Offset + namelen) then Result := -1;
            if Result = 1 then name := StringToWideStringEx(Data.GetString(Offset, namelen), FCodePage);
            Offset := Offset + namelen;
         end;
      end else begin
         if Data.DataLength < (Offset + namelen) then Result := -1;
         if Result = 1 then name := StringToWideStringEx(Data.GetString(Offset, namelen), FCodePage);  
         Offset := Offset + namelen;
      end;
   end else begin
      Result := -1;
   end;

   if Result = 1 then begin
      Formula := FBook._Formula.GetTranslatedFormula(Data, Offset, formulasize, FBiffVersion);
      if Not(Assigned(Formula)) then begin
         Result := -1;
      end;
   end;

   if Result = 1 then begin
      FBook._Names.Add(ANameID, name, Formula, isHidden, sheetindex);    
   end;

end;


function TXLSReader.ParseDefColInfo(Data: TXLSBlob; ValType: integer): integer;
Var Value: Word;
begin
  Result := 1;
  Value := Data.GetWord(0);
  if Valtype = 2 then begin
     FBook.Sheets[FSheetCount].StandardWidth := Excel2Width(Value);
  end else begin
     FBook.Sheets[FSheetCount].StandardWidth := Excel2Width(Value * {!!!!256} 296);
  end;
end;

function TXLSReader.ParseDefRowInfo(Data: TXLSBlob): integer;
Var Value: Word;
begin
  Result := 1;
  Value := Data.GetWord(2);
  
  if Value > 0 then
     FBook.Sheets[FSheetCount].StandardHeight := Excel2Height(Value);
end;

function TXLSReader.ParseComment(Data: TXLSBlob): integer;
Var row, col: word;
    ObjID: word;
    Options: word;
    CommentTxt: WideString;
    offset: longword;
begin
  Result := 1;
  if FBook._DisableGraphics then exit;

  if FBiffVersion < $0600 then begin
     row := Data.GetWord(0) + 1;
     col := Data.GetWord(2) + 1;
     offset := 4;
     CommentTxt := Data.GetBiffString(offset, false, false);
     FBook.Sheets[FSheetCount].Cells[row, col].AddComment(CommentTxt);
  end else begin
     row     := Data.GetWord(0);
     col     := Data.GetWord(2);
     Options := Data.GetWord(4);
     ObjID   := Data.GetWord(6);  
 
     FBook.Sheets[FSheetCount]._Drawing.SetNoteData(ObjId, row, col, Options, '');
  end;
end;

function TXLSReader.ParseHyperlink(Data: TXLSBlobArray): integer;
begin
  Result := 1;
  if Data.Count = 1 then begin
     FBook.Sheets[FSheetCount].GetCustomHyperLinks().Load(Data[0]);
  end;
end;

function TXLSReader.ParseQuickTip(Data: TXLSBlob): integer;
begin
  Result := 1;
  FBook.Sheets[FSheetCount].GetCustomHyperLinks().LoadQuickTip(Data);
end;

function TXLSReader.ParseWSBool(Data: TXLSBlob): integer;
Var Value: Word;
begin
  Result := 1;
  Value := Data.GetWord(0);
  FIsFitToPages := ((Value and $0100) > 0);
  if (Value and $0080) > 0 then FBook.Sheets[FSheetCount].Outline.SummaryColumn := xlRight
                           else FBook.Sheets[FSheetCount].Outline.SummaryColumn := xlLeft;
  if (Value and $0040) > 0 then FBook.Sheets[FSheetCount].Outline.SummaryRow := xlAbove
                           else FBook.Sheets[FSheetCount].Outline.SummaryRow := xlBelow;
end;

function TXLSReader.ParsePrintHeaders(Data: TXLSBlob): integer;
begin
  Result := 1;
  FBook.Sheets[FSheetCount].PageSetup.PrintHeadings := (Data.GetWord(0) = 1);
end;

function TXLSReader.ParseMulRK(Data: TXLSBlob): integer;
Var row, scol, colcnt, col: Word;
    xf:      Word;
    Value : Double;
    isdt: boolean;
    sheet: IXLSWorksheet;
    ReplaceIndex: boolean;
begin
  Result := 1;
  colcnt := (Data.DataLength - 6) div 6;
  if colcnt > 0 then begin
     sheet := FBook.Sheets[FSheetCount];
     row  := Data.GetWord(0); 
     scol := Data.GetWord(2);
     for col := 0 to  colcnt - 1 do begin
         xf  := Data.GetWord(4 + col * 6 ); 
         Value := RK2Double(Data.GetLong(6 + col * 6));
         sheet._SetXF(row, col + scol, xf);

         if FBook.Date1904 then begin
            if xf > 0 then begin
               isdt := FBook._XFList.isDateFormat(xf);
            end else begin
               isdt := FBook._XFList.isDateFormat(sheet.GetXFIndex(row, col + scol, ReplaceIndex));
            end;

            if isdt then begin
               Value := Value + 1462; 
            end;
         end; 

         sheet.Cells[row + 1, col + scol + 1].Value := Value; 
     end;
  end;
end;


function TXLSReader.ParseSST(DataList: TXLSBlobArray): integer;
Var 
    StrLen: Word;
    StrRestLen: Word;
    StrOpt: Byte;
    Offset: LongWord;
    StrValue: WideString;
    {$ifdef D2009}
    StrAnsiValue: AnsiString;
    {$else}
    StrAnsiValue: String;
    {$endif}
    StrSize: LongWord;
    isContinue: boolean;
    StrOffset: LongWord;
    Data: TXLSBlob;
    i: integer;
    sz, rt: longword;
begin
  Result := 1;
  i := 0;
  Data := DataList[i];
  FStringTotalCount := Data.GetLong(4);
  Offset := 8;
  isContinue := false;
  StrRestLen := 0;
  sz := 0;
  rt := 0;

  if Offset >= Data.DataLength then begin
     Inc(i);
     Offset := Offset - Data.DataLength;
     Data := DataList[i];
  end;


  while (Result = 1) and Assigned(Data) 
        and ((FStringTotalCount > FStringCount) or isContinue) do begin

     if isContinue and (StrRestLen > 0) then begin
         StrLen := StrRestLen;
         StrOpt := Data.GetByte(Offset);
         StrOffset := 1;
     end else begin
         StrLen := Data.GetWord(Offset);
         StrOpt := Data.GetByte(Offset + 2);
         StrOffset := 3;
         sz := 0;
         rt := 0;
     end;

     isContinue := false; 
     StrSize := 0;
     if StrLen > 0 then begin
        if      (StrOpt and 1) = 0 then StrSize := StrLen 
        else StrSize := StrLen * 2;

        if (StrOpt and 8) = 8 then begin//Contains Rich-Text info
           rt := Data.GetWord(Offset + StrOffset) * 4;
           StrOffset := StrOffset + 2;
        end; 

        if (StrOpt and 4) = 4 then begin//Contains Far-East info
           sz := Data.GetLong(Offset + StrOffset);
           StrOffset := StrOffset + 4;
        end;
        
        if Result = 1 then begin
           if (StrSize + Offset + StrOffset) > Data.DataLength then begin
               isContinue := true;
               StrSize := Data.DataLength - Offset - StrOffset;
           end;

           if (StrOpt and 1) = 0 then begin
              StrAnsiValue := Data.GetString(Offset + StrOffset, StrSize);
              if (FCodePage > 0) and (FCodePage <> 1200) then begin
                 StrValue := StringToWideStringEx(StrAnsiValue, FCodePage);
              end else begin
                 StrValue := StringToWideStringEx(StrAnsiValue, 1252);
              end;
           end else begin
              StrValue := Data.GetWideString(Offset + StrOffset, StrSize);
           end;
        end;
     end else StrValue := '';

     if Result = 1 then begin
        FStringTable[FStringCount + 1] := FStringTable[FStringCount + 1] + StrValue;
        if not(isContinue) then Inc(FStringCount);
        if isContinue then begin
           StrRestLen := StrLen - Length(StrValue);
           Inc(i);
           Data := DataList[i];
           Offset := 0;
        end else begin
           Offset := Offset + StrOffset + StrSize + rt + sz;
           if Offset >= Data.DataLength then begin
              Inc(i);
              Offset := Offset - Data.DataLength;
              Data := DataList[i];
           end;
        end;
     end; 
  end;
end;

function TXLSReader.RK2Double(Value: LongWord): Double;
Var isDouble: boolean;
    isMul: boolean;
    tmp: longword;
begin
  isDouble := ((Value and 2) = 0);
  isMul    := ((Value and 1) = 1);
  if isDouble then begin
     if isMul then Dec(Value);
     {$ifdef D2009}
     PLongWord(PAnsiChar(@Result))^ := 0;
     PLongWord(PAnsiChar(@Result) + 4)^ := Value;
     {$else}
     PLongWord(PChar(@Result))^ := 0;
     PLongWord(PChar(@Result) + 4)^ := Value;
     {$endif}
  end else begin
      tmp := (Value shr 2);
      if (Value and $80000000) > 0 then tmp := tmp or $C0000000;
      Result := integer(tmp); 
  end;
  if isMul then Result := Result / 100;
end;

function TXLSReader.GetFileFormat: TXLSFileFormat;
begin
  if FBiffVersion >= $0600 then Result := xlExcel97
  else Result := xlExcel5;
end;

function  TXLSReader.Excel5ExternID2Name(ExternID: integer): WideString;
begin
  Result := FExcel5LocalLinkTable[ExternID];
end;



end.

