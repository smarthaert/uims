//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsrtf
//
//
//      Description:  Export to RTF
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

unit xlsrtf;
{$Q-}
{$R-}

interface

{$I xlsdef.inc}

uses nexcel, xlsfrmt, xlshash, classes;

type

  TXLSRTFOnGetCellWidth = function (Cell: IXLSRange): double of object;


  TXLSRTFStyles = class
  private
    FWorksheet: IXLSWorksheet;

    FColorArr: Array of longword;
    FColorHash: THashInteger; 

    FFontArr: Array of string;
    FFontHash: THashInteger; 
    FScale: double;

    function GetDefaultHAlign(Value: variant): String;
    function GetRTFBorderStyle(LineStyle, LineWeight, Color: longword): String;
    function StoreColorTable(S: TStream): integer;
    function StoreFontTable(S: TStream): integer;
    function StorePageSetup(S: TStream): integer;
    function GetColorIndex(Value: Longword): integer;
    function GetFontIndex(FontName: String): integer;
    function Inch2Twips(Value: double): integer;
    function GetVerticalAlignment(Cell: IXLSRange): Longword;
    function PaperSize(PageSize: Longword; Var H,W: integer): integer;
  public
    constructor Create();
    destructor Destroy; override;
    function GetHeaderStyleText(XFIndex: integer; Cell: IXLSRange): String;
    function GetStyleText(XFIndex: integer; Cell: IXLSRange): String;
    function Store(S: TStream): integer;
    function GetWorkAreaWidth: integer;
    property Worksheet: IXLSWorksheet read FWorksheet write FWorksheet;
    property Scale: double read FScale write FScale;
  end;

  TXLSRTFExport = class
  private
    FFormater: TXLSFormater;
    FStyles: TXLSRTFStyles;
    FOnGetCellWidth: TXLSRTFOnGetCellWidth;
    FPictures: THashObject;
    function ExcelX2Twips(Value: double): integer;
    function ExcelY2Twips(Value: double): integer;
    function Text2RTFText(Value: string): string;
    function BuildRTFTable(Range: IXLSRange; TableBody: TStringList): integer;
    function WriteRTFHeader(Stream: TStream): integer;
    function WriteRTFFooter(Stream: TStream): integer;
    function RTFRowHeight(ExcelRowHeight: double): integer;
    function RTFColWidth(ExcelColWidth: double): integer;
    function RangeRTFWidth(Range: IXLSRange): integer;
    function GetPictureText(row, col: integer): string;
    procedure BuildPictureList(Range: IXLSRange);
  public
    constructor Create;              
    destructor Destroy; override;
    function SaveAsRTF(Workbook: IXLSWorkbook; FileName: Widestring): integer; overload;
    function SaveAsRTF(Workbook: IXLSWorkbook; Stream: TStream): integer; overload;
    function SaveAsRTF(WorkSheet: IXLSWorksheet; FileName: Widestring): integer; overload;
    function SaveAsRTF(WorkSheet: IXLSWorksheet; Stream: TStream): integer; overload;
    function SaveAsRTF(Range: IXLSRange; FileName: Widestring): integer; overload;
    function SaveAsRTF(Range: IXLSRange; Stream: TStream): integer; overload;
    property OnGetCellWidth: TXLSRTFOnGetCellWidth read FOnGetCellWidth write FOnGetCellWidth;
  end;

implementation
uses sysutils, wstream, xlsblob, xlsescher, xlsdrw, 
     {$IFDEF D45}
        ComObj
     {$ELSE}
         Variants
     {$ENDIF};

const
  defindent = 30;

constructor TXLSRTFExport.Create();
begin
  inherited Create;
  FFormater := TXLSFormater.Create(false);
  FPictures := nil; 
  FStyles := nil;
end;


destructor TXLSRTFExport.Destroy;
begin
  FFormater.Free;
  FStyles.Free;
  FPictures.Free;
  inherited Destroy;
end;


function TXLSRTFExport.SaveAsRTF(Workbook: IXLSWorkbook; FileName: Widestring): integer; 
Var  S: TWFileStream;
begin
  S := TWFileStream.Create(FileName, fmCreate);
  try
     Result := SaveAsRTF(Workbook, S);
  finally
     S.Free;
  end;
end;

function TXLSRTFExport.SaveAsRTF(Workbook: IXLSWorkbook; Stream: TStream): integer;
Var  TableBody:   TStringList;
     cnt, i: integer;
begin
  FStyles.Free;
  FStyles := TXLSRTFStyles.Create();
  TableBody := TStringList.Create();
  try
    cnt := Workbook.Sheets.Count;
    if cnt > 0 then begin
       for i := 1 to cnt do begin
         BuildRTFTable(Workbook.Sheets[i].UsedRange, TableBody);
         if i < cnt then begin
            TableBody.Add('\pard \page \par'); //page break
         end;
       end;
    end;  
    WriteRTFHeader(Stream);
    TableBody.SaveToStream(Stream);
    WriteRTFFooter(Stream);
  finally
    FStyles.Free;
    FStyles := nil;
    TableBody.Free;
  end; 
  Result := 1;
end;


function TXLSRTFExport.SaveAsRTF(WorkSheet: IXLSWorksheet; FileName: Widestring): integer;   
begin
   Result := SaveAsRTF(WorkSheet.UsedRange, FileName);
end;

function TXLSRTFExport.SaveAsRTF(Range: IXLSRange; FileName: Widestring): integer;   
Var  S: TWFileStream;
begin
  S := TWFileStream.Create(FileName, fmCreate);
  try
     Result := SaveAsRTF(Range, S);
  finally
     S.Free;
  end;
end;



function TXLSRTFExport.SaveAsRTF(WorkSheet: IXLSWorksheet; Stream: TStream): integer;
begin
  Result := SaveAsRTF(Worksheet.UsedRange, Stream);
end;

function TXLSRTFExport.RTFRowHeight(ExcelRowHeight: double): integer;
begin
 Result := ExcelY2Twips(ExcelRowHeight * FStyles.Scale);
end;

function TXLSRTFExport.RTFColWidth(ExcelColWidth: double): integer;
begin
 Result := ExcelX2Twips(ExcelColWidth * FStyles.Scale);
end;


function TXLSRTFExport.GetPictureText(row, col: integer): string;

   function GetBlipData(msopict: TMSOPicture): string;
   var i, sz: integer;
       b: TXLSBlob;
   begin
      Result := '';
      b := msopict.Data;
      sz := b.DataLength;
      for i := 0 to sz - 1 do begin
         if (i mod 127) = 0 then Result := Result + #13#10;
         Result := Result + inttohex(b.GetByte(i), 2);
      end;
   end;

var msop: TMSOShapePictureFrame;
    k: widestring;
    p: TMSOPicture;
begin
   Result := '';
   if Assigned(FPictures) and (FPictures.Count > 0) then begin
      k := inttostr(row)+','+inttostr(col);
      if FPictures.KeyExists(k) then begin
         msop := TMSOShapePictureFrame(FPictures[k]);
         p := msop.GetPicture;
         if Assigned(p) then begin
            case p.PictureType of
               msoblipJPEG:    // JFIF
                  begin
                    Result := GetBlipData(p);
                    if Result <> '' then begin
                       Result := '{\pict\jpegblip' + Result + '}';
                    end;
                  end;
               msoblipPNG:     // PNG
                  begin
                    Result := GetBlipData(p);
                    if Result <> '' then begin
                       Result := '{\pict\pngblip' + Result + '}';
                    end;
                  end;
               msoblipDIB:    // Windows DIB
                  begin
                    Result := GetBlipData(p);
                    if Result <> '' then begin
                       Result := '{\pict\dbitmap0' + Result + '}';
                    end;
                  end;
            end;
            if Result <> '' then begin
//               Result := '{\shp{\*\shpinst\shpleft30\shptop-13\shpright1156\shpbottom743\' +
//               '\shpfhdr0\shpbxcolumn\shpbxignore\shpbypara' + 
//               '\shpbyignore\shpwr3\shpwrk0\shpfblwtxt0\shpz0' +
//               '{\sp{\sn shapeType}{\sv 75}}' +
//               '{\sp{\sn fFlipH}{\sv 0}}' +
//               '{\sp{\sn fFlipV}{\sv 0}}' +
//               '{\sp{\sn pib}{\sv ' + #13#10 +
//               Result + 
//               '}}}}' + #13#10;
                 Result := Result + #13#10;
            end;
         end;
      end;
   end;
end;

procedure TXLSRTFExport.BuildPictureList(Range: IXLSRange);
Var 
    Worksheet: IXLSWorksheet;
    i, cnt: integer;
    sh: TXLSShape;
    p: TXLSPicture;
    msop: TMSOShapePictureFrame;
    row, col: integer;
    rangerow1, rangerow2, rangecol1, rangecol2: integer;
begin
  FPictures.Free;
  FPictures := THashObject.Create();
  FPictures.FreeOnDestroy := false;
  Worksheet := Range.Worksheet;
  cnt := Worksheet.Shapes.Count;
  rangerow1 := Range.Row;
  rangecol1 := Range.Column;
  rangerow2 := rangerow1 + integer(Range.Rows.Count) - 1;
  rangecol2 := rangecol1 + integer(Range.Columns.Count) - 1;
  if cnt > 0 then begin
     for i := 1 to cnt do begin
        sh := Worksheet.Shapes[i];
        if sh is TXLSPicture then begin
           p := TXLSPicture(sh);
           msop := TMSOShapePictureFrame(p._Interface);
           if Assigned(msop) then begin
              row := msop.ClientAnchor.Row1 + 1; 
              col := msop.ClientAnchor.Col1 + 1;
              if (row >= rangerow1) and 
                 (row <= rangerow2) and
                 (col >= rangecol1) and 
                 (col <= rangecol2) then begin
                 //store msop with row and col
                 FPictures[inttostr(row) + ',' + inttostr(col)] := msop;
              end;
           end;
        end;
     end;
  end;
end;

function TXLSRTFExport.BuildRTFTable(Range: IXLSRange; TableBody: TStringList): integer;
Var 
    Worksheet: IXLSWorksheet;
    Cell: IXLSRange;
    MergeArea: IXLSRange;

    rowc, colc: integer;
    r,c: integer;

    StrValue: String;
    lValue: Variant;

    CurXPos: integer;
    RowHeader: String;
    RowBody: String;
    
    skipvalue: boolean;
    XFIndex: integer;
    Style: string;
    pagewidth: integer;
    rangewidth: integer; 
    cellwidth: double;
    cellx: string;
    is_firstcol_mc: boolean;
begin
  Worksheet := Range.Worksheet;

  rowc := Range.Rows.Count;
  colc := Range.Columns.Count;
  BuildPictureList(Range);

  FStyles.Worksheet := Worksheet;
  try 

      Range.ExtendRange();
      FStyles.Scale := 1;
      if (Worksheet.PageSetup.Zoom = false) and
         (Worksheet.PageSetup.FitToPagesWide = 1) then begin
         pagewidth := FStyles.GetWorkAreaWidth;
         if pagewidth > 0 then begin
            rangewidth := RangeRTFWidth(Range);
            if rangewidth > pagewidth then begin
               FStyles.Scale := pagewidth / rangewidth; 
               if FStyles.Scale < 0.3 then FStyles.Scale := 1;
            end;
         end;
      end;


      for r := 1 to rowc do begin
          RowHeader := '\trowd\trql\trleft36';
          RowBody := '';


          CurXPos := 36;
          for c := 1 to colc do begin

            skipvalue := false;
            Cell := Range[r,c];

            XFIndex := Cell.XFIndex;

            if (c = 1) and WorkSheet._RowInfo.IsHeightSet(Cell.FirstRow) then begin
                RowHeader := RowHeader + '\trrh' + inttostr(-RTFRowHeight(Cell.RowHeight));
            end;

            RowHeader := RowHeader + #13#10;
     
            if Assigned(FOnGetCellWidth) then begin
               cellwidth :=  FOnGetCellWidth(Cell);
            end else begin
               cellwidth := Cell.ColumnWidth; 
            end;  
            CurXPos := CurXPos + RtfColWidth(cellwidth);
            cellx := ''; 
            is_firstcol_mc := false; 
            if Cell.MergeCells then begin

               MergeArea := Cell.MergeArea;

               if (MergeArea.Rows.Count > 1) then begin
                  if (Cell.Column = MergeArea.Column) then begin 
                     is_firstcol_mc := true;
                     if (Cell.Row = MergeArea.Row) then 
                        RowHeader := RowHeader + '\clvmgf'
                     else 
                        RowHeader := RowHeader + '\clvmrg';
                  end;
               end; 

               {
               if (MergeArea.Columns.Count > 1) then begin
                  if (Cell.Column = MergeArea.Column) then 
                     RowHeader := RowHeader + '\clmgf'
                  else 
                     RowHeader := RowHeader + '\clmrg';
               end; 
               }

               skipvalue := (Cell.Row <> MergeArea.Row) or 
                            (Cell.Column <> MergeArea.Column);

               if (Cell.Column = MergeArea.Column + integer(MergeArea.Columns.Count) - 1) then begin
                  cellx := '\cellx' + inttostr(CurXPos);  
               end;
            end else begin
               cellx := '\cellx' + inttostr(CurXPos);  
            end;

            if not(skipvalue) then begin
               Style := FStyles.GetHeaderStyleText(XFIndex, Cell);
               if Style <> '' then RowHeader := RowHeader + Style ;
            end;
            if cellx <> '' then RowHeader := RowHeader + cellx;

            StrValue := GetPictureText(Range.Row + r - 1, Range.Column + c - 1);
            if StrValue <> '' then begin
               RowBody := RowBody + StrValue;
            end;

            if not(skipvalue) or is_firstcol_mc then begin
               RowBody := RowBody + '\pard\intbl\plain'#13#10;
               Style := FStyles.GetStyleText(XFIndex, Cell);
               if Style <> '' then RowBody := RowBody + Style + #13#10;
               if not(skipvalue) then begin
                  lValue := Cell.Value;
                  StrValue := FFormater.GetDisplayValue(lValue, Cell.NumberFormat);
                  StrValue := Text2RTFText(StrValue);
                  RowBody := RowBody + StrValue;
               end;
               RowBody := RowBody + '\cell'#13#10;
            end;

          end;
          RowBody := RowBody + '\row'#13#10; 

          TableBody.Add(RowHeader);
          TableBody.Add(RowBody);
      end;
  finally
  end;

  Result := 1;
end;

function TXLSRTFExport.RangeRTFWidth(Range: IXLSRange): integer;
var i, cnt: integer;
    w: double;
begin
  cnt := Range.Columns.Count;
  w := 0; 
  for i := 1 to cnt do begin
     if Assigned(FOnGetCellWidth) then begin
        w := w + FOnGetCellWidth(Range[1,i]);
     end else begin
        w := w + Range[1,i].ColumnWidth;
     end;  
     
  end;
  Result := ExcelX2Twips(w);
end;


function TXLSRTFExport.WriteRTFHeader(Stream: TStream): integer;
Var 
  Header: ansistring;
begin
  Header := '{\rtf1\ansi'#10#13;
  Stream.WriteBuffer(Pointer(Header)^, Length(Header));
  FStyles.Store(Stream);
  Result := 1;
end;

function TXLSRTFExport.WriteRTFFooter(Stream: TStream): integer;
Var 
  Footer: ansistring;
begin
  Footer := '}';
  Stream.WriteBuffer(Pointer(Footer)^, Length(Footer));
  Result := 1;
end;


function TXLSRTFExport.SaveAsRTF(Range: IXLSRange; Stream: TStream): integer;
Var  TableBody:   TStringList;
begin
  FStyles.Free;
  FStyles := TXLSRTFStyles.Create();
  TableBody := TStringList.Create();
  try
    BuildRTFTable(Range, TableBody);
    WriteRTFHeader(Stream);
    TableBody.SaveToStream(Stream);
    WriteRTFFooter(Stream);
  finally
    FStyles.Free;
    FStyles := nil;
    TableBody.Free;
  end; 

  Result := 1;
end;


function TXLSRTFExport.ExcelX2Twips(Value: double): integer;
var pix: integer;
begin
  if Value >= 1 then
     pix := Round(Value * 7) + 5
  else 
     pix := Round(Value * 100 / 8);

  Result := Round(pix * 1440 / 96); 
  //Result := Round(Value * 112);
end;

function TXLSRTFExport.ExcelY2Twips(Value: double): integer;
begin
  Result := Round(Value * 19.5);
end;

function TXLSRTFExport.Text2RTFText(Value: string): string;
begin
  Result := StringReplace(Value, '\', '\\', [rfReplaceAll]);
  Result := StringReplace(Result, '{', '\{', [rfReplaceAll]);
  Result := StringReplace(Result, '}', '\}', [rfReplaceAll]);
  Result := StringReplace(Result, #13#10, '\line ', [rfReplaceAll]);
  Result := StringReplace(Result, #10, '\line ', [rfReplaceAll]);
  Result := StringReplace(Result, #13, '\line ', [rfReplaceAll]);
  Result := StringReplace(Result, #9, '\tab ', [rfReplaceAll]);
end;



{TXLSRTFStyles}
constructor TXLSRTFStyles.Create();
begin
  inherited Create;
  SetLength(FColorArr, 0);
  FColorHash := THashInteger.Create(); 
  SetLength(FFontArr, 0);
  FFontHash := THashInteger.Create();
  FScale := 1; 
end;


destructor TXLSRTFStyles.Destroy;
begin
  FWorksheet := nil;
  SetLength(FColorArr, 0);
  FColorHash.Free; 
  SetLength(FFontArr, 0);
  FFontHash.Free; 
  inherited Destroy;
end;

function TXLSRTFStyles.GetColorIndex(Value: Longword): integer;
Var sKey: String;
    cnt: integer;
begin
  sKey := inttohex(Value, 6);
  if FColorHash.KeyExists(sKey) then begin
     Result := FColorHash[sKey] + 1;
  end else begin
     cnt := Length(FColorArr);
     SetLength(FColorArr, cnt + 1);
     FColorArr[cnt] := Value;
     FColorHash[sKey] := cnt;
     Result := cnt + 1; 
  end;
end;

function TXLSRTFStyles.GetFontIndex(FontName: String): integer;
Var cnt: integer;
    sKey: String;
begin
  sKey := UpperCase(FontName);
  if FFontHash.KeyExists(sKey) then begin
     Result := FFontHash[sKey] + 1;
  end else begin
     cnt := Length(FFontArr);
     SetLength(FFontArr, cnt + 1);
     FFontArr[cnt] := FontName;
     FFontHash[sKey] := cnt;
     Result := cnt + 1; 
  end;
end;


function TXLSRTFStyles.GetStyleText(XFIndex: integer; Cell: IXLSRange): String;
Var v: variant;
begin
  Result := '\f' + inttostr(GetFontIndex(Cell.Font.Name));
  Result := Result + '\fs' + inttostr(Round(Cell.Font.Size * 2 * Scale));
  if Cell.Font.Italic then begin
     Result := Result + '\i';
  end;
  if Cell.Font.Bold then begin
     Result := Result + '\b';
  end;
  if Cell.Font.Strikethrough then begin
     Result := Result + '\strike';
  end;

  if (Cell.Font.ColorIndex <> xlColorIndexAutomatic) and
     (Cell.Font.ColorIndex <> xlColorIndexNone) then begin
     Result := Result + '\cf' + inttostr(GetColorIndex(Cell.Font.Color));
  end;

  case Cell.Font.Underline of
     xlUnderlineStyleDouble:
          Result := Result + '\uldb';
     xlUnderlineStyleDoubleAccounting:
          Result := Result + '\uldb';
     xlUnderlineStyleSingle:
          Result := Result + '\ul';
     xlUnderlineStyleSingleAccounting:
          Result := Result + '\uld';
  end;

  {horizontal alignment}
  v := Cell.Value;
  case Cell.HorizontalAlignment of
       xlHAlignLeft    : Result := Result + '\ql\li' + Inttostr(Round(defindent * Scale));
       xlHAlignCenter  : Result := Result + '\qc';
       xlHAlignRight   : Result := Result + '\qr\ri' + Inttostr(Round(defindent * Scale));
       xlHAlignJustify : Result := Result + '\qj';
       else begin
          Result := Result + GetDefaultHAlign(v);
       end; 
  end;

  case GetVerticalAlignment(Cell) of
       xlVAlignTop: Result := Result + '\sb' + Inttostr(Round(25 * Scale));
  end;

end;

function TXLSRTFStyles.GetVerticalAlignment(Cell: IXLSRange): Longword;
begin
  Result := Cell.VerticalAlignment;
  case Result of
       xlVAlignBottom,
       xlVAlignTop,
       xlVAlignCenter: ;
       else begin
         Result := xlVAlignBottom;
       end;
  end;
end;

function TXLSRTFStyles.GetHeaderStyleText(XFIndex: integer; Cell: IXLSRange): String;
Var v: variant;
    LineStyle: LongWord;
    LineWeight: LongWord;
    LineColor: LongWord;
    Pattern:   LongWord;
begin

  {vertical alignment}
  v := Cell.Value;
  Result := '';
  case GetVerticalAlignment(Cell) of
       xlVAlignBottom  : Result := Result + '\clvertalb';
       xlVAlignTop     : Result := Result + '\clvertalt';
       xlVAlignCenter  : Result := Result + '\clvertalc';
  end;

  {borders}
  {top border}
  LineStyle  := FWorkSheet.WorkBook._XFList.GetBorderLineStyle(XFIndex,  4);
  if LineStyle <> xlLineStyleNone then begin
     LineWeight := FWorkSheet.WorkBook._XFList.GetBorderWeight(XFIndex, 4);
     LineColor  := Cell.Borders[xlEdgeTop].Color; 
     Result := Result + '\clbrdrt ' + GetRTFBorderStyle(LineStyle, LineWeight, LineColor) + ' ';
  end;

  {right border}
  LineStyle  := FWorkSheet.WorkBook._XFList.GetBorderLineStyle(XFIndex,  2);
  if LineStyle <> xlLineStyleNone then begin
     LineWeight := FWorkSheet.WorkBook._XFList.GetBorderWeight(XFIndex, 2);
     LineColor  := Cell.Borders[xlEdgeRight].Color; 
     Result := Result + '\clbrdrr ' + GetRTFBorderStyle(LineStyle, LineWeight, LineColor) + ' ';
  end;

  {left border}
  LineStyle  := FWorkSheet.WorkBook._XFList.GetBorderLineStyle(XFIndex,  1);
  if LineStyle <> xlLineStyleNone then begin
     LineWeight := FWorkSheet.WorkBook._XFList.GetBorderWeight(XFIndex, 1);
     LineColor  := Cell.Borders[xlEdgeLeft].Color; 
     Result := Result + '\clbrdrl ' + GetRTFBorderStyle(LineStyle, LineWeight, LineColor) + ' ';
  end;

  {bottom border}
  LineStyle  := FWorkSheet.WorkBook._XFList.GetBorderLineStyle(XFIndex,  8);
  if LineStyle <> xlLineStyleNone then begin
     LineWeight := FWorkSheet.WorkBook._XFList.GetBorderWeight(XFIndex, 8);
     LineColor  := Cell.Borders[xlEdgeBottom].Color; 
//     LineColor  := FWorkSheet.WorkBook._XFList.GetBorderColor(XFIndex, 8); 
     Result := Result + '\clbrdrb ' + GetRTFBorderStyle(LineStyle, LineWeight, LineColor) + ' ';
  end;

  Pattern := Cell.Interior.Pattern;
  if Pattern <> xlPatternNone then begin
     Result := Result + '\clcbpat' + inttostr(GetColorIndex(Cell.Interior.Color));
  end;
end;

function TXLSRTFStyles.GetRTFBorderStyle(LineStyle, LineWeight, Color: longword): String;
Const
  ThinWidth = '20';
  MediumWidth = '40';
  ThickWidth = '60';
begin
  Result := '';
  case LineStyle of 
     xlContinuous: begin
         case LineWeight of
             xlHairline:  Result := '\brdrhair';
             xlThin:      Result := '\brdrs\brdrw' + ThinWidth;
             xlMedium:    Result := '\brdrs\brdrw' + MediumWidth;
             xlThick:     Result := '\brdrs\brdrw' + ThickWidth;
         end;
     end;

     xlDashDot: begin
         case LineWeight of
             xlThin:      Result := '\brdrdashd\brdrw' + ThinWidth;
             xlMedium:    Result := '\brdrdashd\brdrw' + MediumWidth;
             xlThick:     Result := '\brdrdashd\brdrw' + ThickWidth;
         end;
     end;

     xlDashDotDot: begin
         case LineWeight of
             xlThin:      Result := '\brdrdashdd\brdrw' + ThinWidth;
             xlMedium:    Result := '\brdrdashdd\brdrw' + MediumWidth;
             xlThick:     Result := '\brdrdashdd\brdrw' + ThickWidth;
         end;
     end;

     xlSlantDashDot: begin
         case LineWeight of
             xlThin:      Result := '\brdrdashdotstr\brdrw' + ThinWidth;
             xlMedium:    Result := '\brdrdashdotstr\brdrw' + MediumWidth;
             xlThick:     Result := '\brdrdashdotstr\brdrw' + ThickWidth;
         end;
     end;

     xlDouble: begin
         case LineWeight of
             xlThick:     Result := '\brdrdb\brdrw' + ThinWidth;
         end;
     end;

     xlDash: begin
         case LineWeight of
             xlThin:      Result := '\brdrdashsm\brdrw' + ThinWidth;
             xlMedium:    Result := '\brdrdashsm\brdrw' + MediumWidth;
             xlThick:     Result := '\brdrdashsm\brdrw' + ThickWidth;
         end;
     end;

     xlDot: begin
         case LineWeight of
             xlThin:      Result := '\brdrdot\brdrw' + ThinWidth;
             xlMedium:    Result := '\brdrdot\brdrw' + MediumWidth;
             xlThick:     Result := '\brdrdot\brdrw' + ThickWidth;
         end;
     end;
  end;
  Result := Result + '\brdrcf' + inttostr(GetColorIndex(Color));
end;


function TXLSRTFStyles.Store(S: TStream): integer;
begin
  Result := 1;
  StoreFontTable(S);
  StoreColorTable(S);
  StorePageSetup(S);
end;

function TXLSRTFStyles.PaperSize(PageSize: Longword; Var H,W: integer): integer;
begin
   Result := 1;
   case PageSize of
       xlPaper11x17:       begin w := 15842;  h := 24482; end;
       xlPaperA4:          begin w := 11908;  h := 16840; end;
       xlPaperA5:          begin w := 8393;   h := 11908; end;
       xlPaperB5:          begin w := 8393;   h := 11908; end;
       {xlPaperDsheet:     begin w := 0;      h := 0; end;}
       xlPaperEnvelope11:  begin w := 6482; 	h := 14942; end;
       xlPaperEnvelope14:  begin w := 7202; 	h := 16562; end;
       xlPaperEnvelopeB4:  begin w := 14175; 	h := 20015; end;
       xlPaperEnvelopeB6:  begin w := 9980; 	h := 7089;  end;
       xlPaperEnvelopeC4:  begin w := 12985; 	h := 18371; end;
       xlPaperEnvelopeC6:  begin w := 6465; 	h := 9186;  end;
       xlPaperEnvelopeDL:  begin w := 6238; 	h := 12474; end;
       xlPaperEnvelopeMonarch:  
                           begin w := 5582; 	h := 10802; end;
       {xlPaperEsheet:      begin w := 2; 	h := 2; end;}
       xlPaperFanfoldLegalGerman:
                           begin w := 12242; 	h := 18722; end;
       xlPaperFanfoldUS:   begin w := 21422; 	h := 15842; end;
       xlPaperLedger:      begin w := 24482; 	h := 15842; end;
       xlPaperLetter:      begin w := 12242; 	h := 15842; end;
       xlPaperNote:        begin w := 12242; 	h := 15842; end;
       xlPaperStatement:   begin w := 7922; 	h := 12242; end;
       {xlPaperUser:        begin w := 2; 	h := 2; end;}
       xlPaper10x14:       begin w := 14402; 	h := 20162; end;
       xlPaperA3:          begin w := 16840; 	h := 23813; end;
       xlPaperA4Small:     begin w := 11908; 	h := 16840; end;
       xlPaperB4:          begin w := 14175; 	h := 20071; end;
       {xlPaperCsheet:      begin w := 2; 	h := 2; end;}
       xlPaperEnvelope10:  begin w := 5942; 	h := 13682; end;
       xlPaperEnvelope12:  begin w := 6482; 	h := 15842; end;
       xlPaperEnvelope9:   begin w := 5582; 	h := 12782; end;
       xlPaperEnvelopeB5:  begin w := 9980; 	h := 14175; end;
       xlPaperEnvelopeC3:  begin w := 18371; 	h := 25967; end;
       xlPaperEnvelopeC5:  begin w := 9186; 	h := 12985; end;
       xlPaperEnvelopeC65: begin w := 6465; 	h := 12985; end;
       xlPaperEnvelopeItaly: 
                           begin w := 6238; 	h := 13041; end;
       xlPaperEnvelopePersonal:  
                           begin w := 5222; 	h := 9362;  end;
       xlPaperExecutive:   begin w := 10802; 	h := 15122; end;
       xlPaperFanfoldStdGerman:  
                           begin w := 12242; 	h := 18722; end;
       xlPaperFolio:       begin w := 12242; 	h := 18722; end;
       xlPaperLegal:       begin w := 12242; 	h := 20162; end;
       xlPaperLetterSmall: begin w := 12242; 	h := 15842; end;
       xlPaperQuarto:      begin w := 12191; 	h := 15593; end;
       xlPaperTabloid:     begin w := 15842; 	h := 24482; end;
       else Result := -1;
     end;
end;   


function TXLSRTFStyles.GetWorkAreaWidth: integer;
Var
  H,W, m: integer;
begin
  Result := PaperSize(Worksheet.PageSetup.PaperSize, H, W);
  if Result = 1 then begin
     if FWorksheet.PageSetup.Orientation = xlLandscape then begin
        W := H;
     end;
     m := Inch2Twips(FWorksheet.PageSetup.LeftMargin) +
          Inch2Twips(FWorksheet.PageSetup.RightMargin);
     Result := W - m;
  end else begin
     Result := -1;
  end;
end;


function TXLSRTFStyles.StorePageSetup(S: TStream): integer;
Var Str: AnsiString;
    m: integer;


  function GetPaperSize(PageSize: Longword): String;
  Var Res: integer;
      H,W, Tmp: integer;
  begin
     Res := PaperSize(PageSize, H, W);
     if Res = 1 then begin
        if FWorksheet.PageSetup.Orientation = xlLandscape then begin
           Tmp := H; H := W; W := Tmp; 
        end; 
        Result := '\paperw' + inttostr(w) + '\paperh' + inttostr(h);
     end else 
        Result := '';
  end;

begin
  Result := 1;

  Str := AnsiString(GetPaperSize(FWorksheet.PageSetup.PaperSize));

  m := Inch2Twips(FWorksheet.PageSetup.LeftMargin);
  if m > 0 then Str := Str + '\margl' + AnsiString(inttostr(m));
  m := Inch2Twips(FWorksheet.PageSetup.RightMargin);
  if m > 0 then Str := Str + '\margr' + AnsiString(inttostr(m));
  m := Inch2Twips(FWorksheet.PageSetup.TopMargin);
  if m > 0 then Str := Str + '\margt' + AnsiString(inttostr(m));
  m := Inch2Twips(FWorksheet.PageSetup.BottomMargin);
  if m > 0 then Str := Str + '\margb' + AnsiString(inttostr(m));

  if FWorksheet.PageSetup.Orientation = xlLandscape then begin
     Str := Str + '\landscape';
  end;

  if Str <> '' then begin
     Str := Str + #13#10;
     S.WriteBuffer(Pointer(Str)^, Length(Str));
  end;
end;

function TXLSRTFStyles.StoreColorTable(S: TStream): integer;
Var i, cnt: integer;
    val: longword;
    Str: AnsiString;
begin
  Result := 1;
  cnt := Length(FColorArr);
  if cnt > 0 then begin
     Str := '{\colortbl ;';
     for i := 0 to cnt - 1 do begin
        val := FColorArr[i];
        Str := Str + '\red' + AnsiString(inttostr(val and $0000FF)) +
                     '\green' + AnsiString(inttostr((val and $00FF00) shr 8)) +
                     '\blue' + AnsiString(inttostr((val and $FF0000) shr 16)) + ';'
     end;
     Str := Str + '}'#13#10; 
     S.WriteBuffer(Pointer(Str)^, Length(Str));
  end;
end;

function TXLSRTFStyles.StoreFontTable(S: TStream): integer;
Var i, cnt: integer;
    Str: AnsiString;
    FontInfo: AnsiString;
begin
  Result := 1;
  cnt := Length(FFontArr);
  if cnt > 0 then begin
     Str := '{\fonttbl ';
     for i := 0 to cnt - 1 do begin
        FontInfo := '{\f' + AnsiString(inttostr(i+1)) + ' \fnil ' + AnsiString(FFontArr[i]) + ';}'#13#10;
        Str := Str + FontInfo;
     end;
     Str := Str + '}'#13#10; 
     S.WriteBuffer(Pointer(Str)^, Length(Str));
  end;
end;


function TXLSRTFStyles.GetDefaultHAlign(Value: variant): String;
Var vt: integer;
begin
  vt := VarType(Value);
  case vt of
    varBoolean, varByte,
    {$IFNDEF D45}
    varWord, varLongWord, varInt64, varShortInt,
    {$ENDIF}
    varSmallint, varInteger, varSingle, varDouble, 
    varCurrency : Result := '\qr\ri' + Inttostr(Round(defindent * Scale)); 
    else          Result := '\li' + Inttostr(Round(defindent * Scale));
  end;     
end;

function TXLSRTFStyles.Inch2Twips(Value: double): integer;
begin
  Result := Round(1440 * Value);
end;

end.
