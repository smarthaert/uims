//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlshtml
//
//
//      Description:  Export to HTML
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

unit xlshtml;
{$Q-}
{$R-}

interface

{$I xlsdef.inc}

uses nexcel, xlsfrmt, classes;

type
  TXLSHTMLExport = class
  private
    FFormater: TXLSFormater;
    function GetDefaultHAlign(Value: variant): WideString;
//    function StringToHTML(Value: WideString): WideString;
//    function GetDisplayValue(Value: Variant; NumberFormat: WideString): WideString;
    function GetCSSItem(Worksheet: IXLSWorksheet; FormatKey: String; LTXFIndex, RTXFIndex, LBXFIndex: integer; Range:IXLSRange): WideString;
    function GetCSSLineStyle(LineStyle: LongWord): WideString;
    function GetCSSLineWeight(LineWeight, LineStyle: LongWord): WideString;
    function GetCSSColor(Color: LongWord): WideString;
    function CreateNavigateHTML(WorkBook: TXLSWorkbook; FileName: WideString): integer;
    function CreateMainHTML(WorkBook: TXLSWorkbook; FileName: WideString): integer;
//    function isDateFormat(NumberFormat: WideString): boolean;
//    procedure ParseNumberFormat(NumberFormat: WideString; Var FormatP,FormatN,FormatZ,FormatE: WideString);
//    procedure ParseFormat(Format: WideString; Var Before, Mask, After, Color: WideString);
//    procedure ExtractColor(Var Format, Color: WideString);
//    function  FormatString(Value: Variant): WideString;
//    function  FormatDouble(NumberFormat: WideString; Value: Variant): WideString;
  public
    constructor Create;              
    destructor Destroy; override;
    function SaveAsHTML(WorkSheet: IXLSWorksheet; FileName: Widestring): integer; overload;  
    function SaveAsHTML(WorkSheet: IXLSWorksheet; Stream: TStream): integer; overload;  
    function SaveAsHTML(Range: IXLSRange; FileName: Widestring): integer; overload;  
    function SaveAsHTML(Range: IXLSRange; Stream: TStream): integer; overload;  
    function SaveAsHTML(WorkBook: TXLSWorkbook; FileName: WideString): integer; overload;
  end;

implementation
uses xlshash, sysutils, wstream,
     {$IFDEF D45}
        ComObj
     {$ELSE}
         Variants
     {$ENDIF};




constructor TXLSHTMLExport.Create();
begin
  inherited Create;
  FFormater := TXLSFormater.Create(false);
end;


destructor TXLSHTMLExport.Destroy;
begin
  FFormater.Free;
  inherited Destroy;
end;


function TXLSHTMLExport.SaveAsHTML(WorkSheet: IXLSWorksheet; FileName: Widestring): integer;   
Var  S: TStream;
begin
  S := TWFileStream.Create(FileName, fmCreate);
  try
     Result := SaveAsHTML(WorkSheet.UsedRange, S);
  finally
     S.Free;
  end;
end;

function TXLSHTMLExport.SaveAsHTML(WorkSheet: IXLSWorksheet; Stream: TStream): integer;   
begin
  Result := SaveAsHTML(Worksheet.UsedRange, Stream);
end;

function TXLSHTMLExport.SaveAsHTML(Range: IXLSRange; FileName: Widestring): integer;   
Var  S: TStream;
begin
  S := TWFileStream.Create(FileName, fmCreate);
  try
     Result := SaveAsHTML(Range, S);
  finally
     S.Free;
  end;
end;


function TXLSHTMLExport.SaveAsHTML(Range: IXLSRange; Stream: TStream): integer;   
Var rowc, colc: integer;
    row, col: integer;
    URange: IXLSRange;
    Cell : IXLSRange;
    MergeArea: IXLSRange;
    Format: Array [1..3] of integer;
    FormatKey: string;
    Merge: string;
    skipcell: boolean;
    Style: TMemoryStream;
    Table: TMemoryStream;
    StyleHash: THashBool;
    StrValue: WideString;
    Width : integer;
    lValue: Variant;
    Worksheet: IXLSWorksheet;
begin
  Worksheet := Range.Worksheet;
  //hash for CSS table
  StyleHash := THashBool.Create;
  Style := TMemoryStream.Create();
  Table := TMemoryStream.Create();
  try 
     URange := Range;
     rowc := URange.Rows.Count;
     colc := URange.Columns.Count;

     WorkSheet.WorkBook._XFList.CreateAllReferredList(0);
     BaseWriteAnsiString(Style,
               '<html><head>'#13#10 +
               '<meta http-equiv=Content-Type content="text/html; charset=utf-8">'#13#10 +
               '<STYLE TYPE="text/css">'#13#10'<!--'#13#10);

     Width := 0;

     for col := 1 to colc  do begin
         Width := Width + (Round(URange.Item[1, col].ColumnWidth * 7.1 + 6.12));
     end;
 
     BaseWriteAnsiString(Table, '<table border=0 cellpadding=0 cellspacing=0 width=');
     BaseWriteAnsiString(Table, AnsiString(inttostr(Width)));
     BaseWriteAnsiString(Table, ' style='#39'border-collapse:collapse;table-layout:fixed'#39'>'#13#10);

     for col := 1 to colc  do begin
       Cell := URange[1, col];
       BaseWriteAnsiString(Table, AnsiString(
                 ' <col width=' + inttostr(Round(Cell.ColumnWidth * 7.1 + 6.12)) + 
                 ' style=''width:'+ floattohtml((Cell.ColumnWidth * 7.1 + 6.12) / 1.333) + 'pt'' ' + 
                 '>'#13#10));
     end;

     for row := 1 to rowc  do begin
       BaseWriteAnsiString(Table, '<tr>'#13#10);
       for col := 1 to colc  do begin
         lValue := null;
         Cell := URange[row, col];
         Merge := '';
         skipcell := false;
         Format[1] := Cell.XFIndex;
         Format[2] := -1;
         Format[3] := -1; 
         if (col = 1) and WorkSheet._RowInfo.IsHeightSet(Cell.FirstRow) then begin
            Merge := Merge + ' height=' + inttostr(Round(Cell.RowHeight * 1.333)) + 
                     ' style=''height:' + floattohtml(Cell.RowHeight) + 'pt'' '
         end;

         MergeArea := Cell; 

         if Cell.MergeCells then begin
            MergeArea := Cell.MergeArea;
            if (Cell.Row = MergeArea.Row) and  
               (Cell.Column = MergeArea.Column) then begin
               if MergeArea.Columns.Count > 1 then Merge := Merge + 'colspan=' + inttostr(MergeArea.Columns.Count) + ' '; 
               if MergeArea.Rows.Count > 1    then Merge := Merge + 'rowspan=' + inttostr(MergeArea.Rows.Count) + ' '; 
               Format[2] := MergeArea[1, MergeArea.Columns.Count].XFIndex;
               Format[3] := MergeArea[MergeArea.Rows.Count, 1].XFIndex;
            end else begin
               skipcell := true;
            end;
         end;

         FormatKey := inttostr(Format[1]);
         if Format[2] >= 0 then begin
            if (Format[1] <> Format[2]) or (Format[1] <> Format[3]) then begin
               FormatKey := FormatKey + 'r' + inttostr(Format[2]) + 'b' + inttostr(Format[3]);  
            end else begin
               Format[2] := -1;
               Format[3] := -1;
            end;
         end;
  
         if not(skipcell) then begin
            lValue := Cell.Value; 
            if Cell.HorizontalAlignment = xlHAlignGeneral then begin
               Merge := Merge + GetDefaultHAlign(lValue); 
            end;
         end;

         if not(skipcell) then begin
   //        if Format > 0 then Format := FWorkbook.FXFList.SaveIndex[Format];
//           if FormatKey <> '0' then begin
              if not(StyleHash.KeyExists(FormatKey)) then begin
                 BaseWriteAnsiString(Style, AnsiString(
                   GetCSSItem(WorkSheet, FormatKey, Format[1], Format[2], Format[3], MergeArea)));
                 StyleHash.Values[FormatKey] := true;
              end;
  //         end;

           BaseWriteAnsiString(Table, AnsiString(' <td ' + Merge + ' class=f' + FormatKey + '>'));
           StrValue := FFormater.GetDisplayValue(lValue, Cell.NumberFormat, true);
           BaseWriteAnsiString(Table, UTF8Encode(StrValue));
           BaseWriteAnsiString(Table, '</td>');
         end;
       end;
       BaseWriteAnsiString(Table, '</tr>'#13#10);
     end;
     BaseWriteAnsiString(Table, '</table></body></html>');
     BaseWriteAnsiString(Style, '-->'#13#10'</STYLE>'#13#10'</head><body>'#13#10);
     Style.Position := 0;
     Table.Position := 0;
     Stream.CopyFrom(Style, Style.Size); 
     Stream.CopyFrom(Table, Table.Size); 
  finally
    Style.Free;
    Table.Free;
    StyleHash.Free;
  end;
  Result := 1;
end;


function TXLSHTMLExport.GetDefaultHAlign(Value: variant): WideString;
Var vt: integer;
begin
  vt := VarType(Value);
  case vt of
    varBoolean, varEmpty, varNull, varByte,
    {$IFNDEF D45}
    varWord, varLongWord, varInt64, varShortInt,
    {$ENDIF}
    varSmallint, varInteger, varSingle, varDouble, 
    varCurrency : Result := 'align=right '; 
    else          Result := 'align=left ';
  end;     
end;

{
function TXLSHTMLExport.StringToHTML(Value: WideString): WideString;
begin
  Value := StringReplace(Value, '&', '&amp;', [rfReplaceAll]);
  Value := StringReplace(Value, '<', '&lt;', [rfReplaceAll]);
  Value := StringReplace(Value, '>', '&gt;', [rfReplaceAll]);
  Value := StringReplace(Value, '"', '&quot;', [rfReplaceAll]);
//  Value := StringReplace(Value, ' ', '&nbsp;', [rfReplaceAll]);
  Value := StringReplace(Value, Chr(13) + Chr(10), '<br>', [rfReplaceAll]);
  Result := StringReplace(Value, Chr(13), '<br>', [rfReplaceAll]);
end;

function TXLSHTMLExport.isDateFormat(NumberFormat: WideString): boolean;
Var Val: WideString;
begin
  Val := uppercase(NumberFormat);
  Result := (Pos('DD', Val) > 0) or
            (Pos('MM', Val) > 0) or
            (Pos('YY', Val) > 0) or
            (Pos('HH', Val) > 0) or
            (Pos('SS', Val) > 0); 
end;

procedure TXLSHTMLExport.ParseNumberFormat(NumberFormat: WideString; Var FormatP,FormatN,FormatZ,FormatE: WideString);
Var lPos: integer;
begin
  FormatP := NumberFormat;
  lPos := Pos(';', FormatP);
  if lPos > 0 then begin
     FormatN := Copy(FormatP, lPos + 1, Length(FormatP) - lPos);
     FormatP := Copy(FormatP, 1, lPos - 1);
  end else begin
     FormatN := FormatP; 
  end;

  lPos := Pos(';', FormatN);
  if lPos > 0 then begin
     FormatZ := Copy(FormatN, lPos + 1, Length(FormatN) - lPos);
     FormatN := Copy(FormatN, 1, lPos - 1);
  end else begin
     FormatZ := FormatP; 
  end;

  lPos := Pos(';', FormatZ);
  if lPos > 0 then begin
     FormatE := Copy(FormatZ, lPos + 1, Length(FormatZ) - lPos);
     FormatZ := Copy(FormatZ, 1, lPos - 1);
  end else begin
     FormatE := FormatP; 
  end;
end;


procedure TXLSHTMLExport.ExtractColor(Var Format, Color: WideString);
   function checkcolor(Var Format, Color: Widestring; TestColor: Widestring): boolean;
   Var lPos: integer;
   begin
     Result := false;
     lPos := Pos('[' + TestColor + ']', lowercase(Format));
     if lPos > 0 then begin
        Color := TestColor;
        Format := Copy(Format, 1, lPos - 1) + 
                  Copy(Format, lPos + Length(Color) + 2, 
                         Length(Format) - lPos - Length(Color) - 1);
        Result := true;
     end;
   end; 
begin
  Color := '';
  while true do begin
     if CheckColor(Format, Color, 'red') then break;
     if CheckColor(Format, Color, 'green') then break;
     if CheckColor(Format, Color, 'blue') then break;
     if CheckColor(Format, Color, 'black') then break;
     if CheckColor(Format, Color, 'maroon') then break;
     if CheckColor(Format, Color, 'yellow') then break;
     if CheckColor(Format, Color, 'white') then break;
     break;
  end; 
end;

procedure TXLSHTMLExport.ParseFormat(Format: WideString; Var Before, Mask, After, Color: WideString);
Var c: WideChar;
    inqw: boolean;
    cnt, i: integer;
    part: integer;
    slash: boolean; 
begin
  inqw := false;
  cnt := Length(Format);
  ExtractColor(Format, Color);
  Before := '';
  After := '';
  Mask := '';
  part := 1;
  if cnt > 0 then begin
     slash := false; 
     for i := 1 to cnt do begin
       c := Format[i];
       if part = 1 then begin
          if slash then begin
             Before := Before + c;
             slash := false;
          end else if inqw then begin
             if c = '"' then inqw := false
             else Before := Before + c; 
          end else if char(c) in ['#', '0', '.', 'd', '[',
                   'D', 'm', 'Y','y','M', 'H', 'h', 's', 'S', '-'] then begin
             part := 2;
          end else if c = '\' then begin
              slash := true;
          end else if c = '"' then begin
              inqw := true;
          end else if c = '_' then begin
              Before := Before + ' ';
          end else begin
              Before := Before + c;
          end;
       end;

       if part = 2 then begin
          if char(c) in ['#', ',', ' ', '0', '.', ':', 'd',
             'D', 'Y', 'y', 'm', 'M', 'H', 'h', 's', 'S', '-', '/'] then begin
             Mask := Mask + c;
          end else if (c = '[') or (c = ']') then begin
             //skip
          end else begin
             part := 3;
          end;
       end;

       if part = 3 then begin
          if slash then begin
             After := After + c;
             slash := false;
          end else if inqw then begin
             if c = '"' then inqw := false
             else After := After + c; 
          end else if c = '\' then begin
              slash := true;
          end else if c = '"' then begin
              inqw := true;
          end else if c = '_' then begin
              After := After + ' ';
          end else begin
              After := After + c;
          end;
       end;
    end;
  end;
end;

function TXLSHTMLExport.FormatString(Value: Variant): WideString;
begin
  Result := VarToStr(Value);
  if Result = '' then 
     Result := '&nbsp;'
  else begin   
     Result := StringToHTML(Result);
  end; 
end;

function TXLSHTMLExport.FormatDouble(NumberFormat: WideString; Value: Variant): WideString;
Var FormatP, FormatN, FormatZ, FormatE: WideString;
    UsedFormat: WideString;
    isdate: boolean; 
    Before, Mask, After, Color: WideString;
begin
  isdate := false;
  ParseNumberFormat(NumberFormat,FormatP, FormatN, FormatZ, FormatE);
  if isDateFormat(NumberFormat) then begin
    UsedFormat := FormatP;
    isdate := true;
  end else begin
    if Value > 0 then
       UsedFormat := FormatP
    else if Value < 0 then begin
       UsedFormat := FormatN;
       if FormatN <> FormatP then Value := -Value;
    end else if Value = 0 then
       UsedFormat := FormatZ
    else 
       UsedFormat := FormatE;
  end; 
  ParseFormat(UsedFormat, Before, Mask, After, Color);
  if isdate then begin
     if Mask <> '' then
        Result := FormatDateTime(Mask, Value)
     else Result := '';
  end else begin
     if Mask <> '' then
        Result := FormatFloat(Mask, Value)
     else Result := '';
  end;

  Result := Before + Result + After;

  if Result = '' then 
     Result := '&nbsp;'
  else begin   
     Result := StringToHTML(Result);
     Result := StringReplace(Result, ' ', '&nbsp;', [rfReplaceAll]);
     if Color <> '' then begin
        Result := '<font color="' + color + '">' + Result + '</font>';
     end;
  end;
end;

function TXLSHTMLExport.GetDisplayValue(Value: Variant; NumberFormat: WideString): WideString;
Var vt: integer;
//    nv: Cardinal;
begin
  vt := VarType(Value);
  if (NumberFormat <> '') and (NumberFormat <> '@') and (NumberFormat <> 'General') then begin
     case vt of
        varSmallint,
        varInteger,
        varSingle,
        varDouble,
        varCurrency: begin
                       //nv := Value;
                       Result := FormatDouble(NumberFormat, Value);
                     end;
        varDate: begin
                   Result := FormatDouble(NumberFormat, Value);
                 end;
        varNull, varEmpty: Result := FormatString(Value);
        else Result := FormatString(Value);
      end;
  end else Result := FormatString(Value);
end;
}

function TXLSHTMLExport.GetCSSLineStyle(LineStyle: LongWord): WideString;
begin
  Result := '';
  if LineStyle <> xlLineStyleNone then begin
       case LineStyle of
         xlContinuous:   Result :=  'solid';
         xlDash:         Result :=  'dashed';
         xlDashDot:      Result :=  'dashed';
         xlDashDotDot:   Result :=  'dashed';
         xlDot:          Result :=  'dotted';
         xlDouble:       Result :=  'double';
         xlSlantDashDot: Result :=  'dashed';
       end;
  end;
end;

function TXLSHTMLExport.GetCSSLineWeight(LineWeight, LineStyle: LongWord): WideString;
Var StartWeight: Single;
    Weight: Single;
begin
  Result := '';
  StartWeight := 0;
  Weight := 0;
  if LineStyle = xlDouble then StartWeight := 1.5;

  case LineWeight of
     xlHairline:   Weight := 0.1;
     xlThin    :   Weight := 0.5;
     xlMedium  :   Weight := 1.5;
     xlThick   :   Weight := 2;
  end;
  Weight := Weight + StartWeight;
  Result := FloatToHTML(Weight) + 'pt';
end;


function TXLSHTMLExport.GetCSSColor(Color: LongWord): WideString;
begin
  Result := inttohex(Color, 6);
  Result := '#' + copy(Result, 5, 2) + copy(Result, 3, 2) + copy(Result, 1, 2);
end;

function TXLSHTMLExport.GetCSSItem(Worksheet: IXLSWorksheet; FormatKey: String; LTXFIndex, RTXFIndex, LBXFIndex: integer; Range:IXLSRange): WideString;
Var color:     string;
    HAlign:    LongWord;
    VAlign:    LongWord;
    Pattern:   LongWord;
    LineStyle: LongWord;
    iColor:    LongWord;
    Cell: IXLSRange;
    CurXFIndex: integer;
begin
  Cell := Range[1,1];
  Result := ' td.f' + FormatKey + ' {' +
            'font-family: ' + Cell.Font.Name + '; ' +
            'font-size: ' + inttostr(Round(Cell.Font.Size)) + 'pt; ' +
            'padding:1px; ';
    if Cell.Font.Bold then  Result := Result + 'font-weight: bold; ';
    if Cell.Font.Italic then  Result := Result + 'font-style: italic; ';
    HAlign := Cell.HorizontalAlignment;
    case HAlign of
       xlHAlignLeft    : Result := Result + 'text-align: left; padding-right: 0; ';
       xlHAlignCenter  : Result := Result + 'text-align: center; ';
       xlHAlignRight   : Result := Result + 'text-align: right; padding-left: 0;';
       xlHAlignJustify : Result := Result + 'text-align: justify; ';
     end;
    VAlign := Cell.VerticalAlignment;
    case VAlign of
       xlVAlignBottom  : Result := Result + 'vertical-align: bottom; padding-top: 0; ';
       xlVAlignTop     : Result := Result + 'vertical-align: top; padding-bottom: 0;';
       xlVAlignCenter  : Result := Result + 'vertical-align: middle; ';
     end;
    color := inttohex(Cell.Font.Color, 6);
    color := copy(color, 5, 2) + copy(color, 3, 2) + copy(color, 1, 2);
    Result := Result + 'color: #' + color + '; ';

    Pattern := Cell.Interior.Pattern;
    if Pattern <> xlPatternNone then begin
       color := inttohex(Cell.Interior.Color, 6);
       color := copy(color, 5, 2) + copy(color, 3, 2) + copy(color, 1, 2);
       Result := Result + 'background-color: #' + color + '; ';
    end;
    
    if not(Cell.WrapText) then Result := Result + 'white-space: nowrap; ';

    //top border 
    CurXFIndex := LTXFIndex;
    LineStyle := WorkSheet.WorkBook._XFList.GetBorderLineStyle(CurXFIndex, 4);
    if LineStyle <> xlLineStyleNone then begin
       Result := Result 
           + 'border-top: ' 
           + GetCSSLineWeight(WorkSheet.WorkBook._XFList.GetBorderWeight(CurXFIndex, 4), LineStyle) 
           + ' ' + GetCSSLineStyle(LineStyle) 
           + ' ' + GetCSSColor(Cell.Borders[xlEdgeTop].Color) + '; ';
    end;

    LineStyle := WorkSheet.WorkBook._XFList.GetBorderLineStyle(CurXFIndex, 1);
    if LineStyle <> xlLineStyleNone then begin
       Result := Result 
           + 'border-left: ' 
           + GetCSSLineWeight(WorkSheet.WorkBook._XFList.GetBorderWeight(CurXFIndex, 1), LineStyle) 
           + ' ' + GetCSSLineStyle(LineStyle) 
           + ' ' + GetCSSColor(Cell.Borders[xlEdgeLeft].Color) + '; ';
    end;

    //bottom border
    if LBXFIndex >= 0 then begin
       CurXFIndex := LBXFIndex;
       Cell := Range[Range.Rows.Count, 1];
    end;

    LineStyle := WorkSheet.WorkBook._XFList.GetBorderLineStyle(CurXFIndex, 8);
    if LineStyle <> xlLineStyleNone then begin
       iColor := Cell.Borders[xlEdgeBottom].Color;
       Result := Result 
           + 'border-bottom: ' 
           + GetCSSLineWeight(WorkSheet.WorkBook._XFList.GetBorderWeight(CurXFIndex, 8), LineStyle) 
           + ' ' + GetCSSLineStyle(LineStyle) 
           + ' ' + GetCSSColor(iColor) + '; ';
    end;

    //right border
    if RTXFIndex >= 0 then begin
       CurXFIndex := RTXFIndex;
       Cell := Range[1, Range.Columns.Count];
    end;

    LineStyle := WorkSheet.WorkBook._XFList.GetBorderLineStyle(CurXFIndex, 2);
    if LineStyle <> xlLineStyleNone then begin
       Result := Result 
           + 'border-right: ' 
           + GetCSSLineWeight(WorkSheet.WorkBook._XFList.GetBorderWeight(CurXFIndex, 2), LineStyle) 
           + ' ' + GetCSSLineStyle(LineStyle) 
           + ' ' + GetCSSColor(Cell.Borders[xlEdgeRight].Color) + '; ';
    end;

    Result := Result +  '}';
end;

function TXLSHTMLExport.SaveAsHTML(WorkBook: TXLSWorkbook; FileName: WideString): integer;
Var SheetCount, i: integer;
    NewDir: string;
    Len: integer;
begin
  SheetCount:=WorkBook.Sheets.Count;
  if SheetCount = 1 then begin
     SaveAsHTML(WorkBook.Sheets[1], FileName);
  end else if SheetCount > 1 then begin
     NewDir := ExtractFileName(FileName);
     Len := Length(ExtractFileExt(FileName));
     NewDir := Copy(NewDir, 1, Length(NewDir) - Len);
     NewDir := ExtractFilePath(FileName) + NewDir + '.files';
     if not(DirExists(NewDir)) then MkDir(NewDir);
     CreateNavigateHTML(WorkBook, NewDir + '\tabstrip.htm');
     for i := 1 to SheetCount do
       SaveAsHTML(WorkBook.Sheets[i], NewDir + '\Sheet' + formatfloat('000', i) + '.htm');
     CreateMainHTML(WorkBook, FileName);
  end;
  Result := 1;
end;

function TXLSHTMLExport.CreateNavigateHTML(WorkBook: TXLSWorkbook; FileName: WideString): integer;
Var F: TextFile;
    nl: string;
    SheetCount, i: integer;
begin
  nl := Chr(13) + Chr(10);
  SheetCount := WorkBook.Sheets.Count;
//  if FileExists(Filename) then DeleteFile(Filename);
  AssignFile(F, Filename);
  Rewrite(F);
  Writeln(F,
   '<html>' + nl +
   '<head>' + nl +
   ' <meta http-equiv=Content-Type content="text/html; charset=utf-8">' + nl +
   '<style>' + nl +
   '<!--' + nl +
   'A {' + nl +
   '    text-decoration:none;' + nl +
   '    color:#000000;' + nl +
   '    font-size:9pt;' + nl +
   '}' + nl +
   '-->' + nl +
   '</style>' + nl +
   '</head>' + nl +
   '<body topmargin=0 leftmargin=0 bgcolor="#808080">' + nl +
   '<table border=0 cellspacing=1>' + nl +
   ' <tr>');
   for i := 1 to SheetCount do begin
     Writeln(F, AnsiString('<td bgcolor="#FFFFFF" nowrap><b><small><small>&nbsp;<a href="Sheet') + 
                AnsiString(FormatFloat('000', i)) + 
                AnsiString('.htm" target="frSheet"><font face="Arial" color="#000000">') + 
                UTF8Encode(WorkBook.Sheets[i].Name) + 
                AnsiString('</font></a>&nbsp;</small></small></b></td>'));
   end;
   writeln(F,
   ' </tr>' + nl +
   '</table>' + nl +
   '</body>' + nl +
   '</html>');

  CloseFile(F);
  Result := 1;
end;

function TXLSHTMLExport.CreateMainHTML(WorkBook: TXLSWorkbook; FileName: WideString): integer;
Var F: TextFile;
    nl: AnsiString;
    Dir: WideString;
    Len: Integer;
begin
//  if FileExists(Filename) then DeleteFile(Filename);
  AssignFile(F, Filename);
  Rewrite(F);
  Dir := ExtractFileName(FileName);
  Len := Length(ExtractFileExt(FileName));
  Dir := Copy(Dir, 1, Length(Dir) - Len) + '.files';

  nl := AnsiString(Chr(13) + Chr(10));
  writeln(F, '<html>' + nl + '<head>' +  nl + 
             '  <meta http-equiv=Content-Type content="text/html; charset=utf-8">' + nl +
             '</head>' + nl +
  '<frameset rows="*,39" border=0 width=0 frameborder=no framespacing=0>');
  writeln(F, AnsiString('<frame src="') + 
             AnsiString(Dir) + 
             AnsiString('/Sheet') + 
             AnsiString(formatfloat('000', Workbook.ActiveSheet.Index)) + 
             AnsiString('.htm" name="frSheet">'));
  writeln(F, AnsiString('<frame src="') + 
             AnsiString(Dir) + 
             AnsiString('/tabstrip.htm" name="frTabs" marginwidth=0 marginheight=0>') + 
             nl +
  '<noframes>' + nl +
  '<body>' + nl +
  '<p>This page uses the frames. Your browser does not support frames.</p>' + nl +
  '</body>' + nl +
  '</noframes>' + nl +
  '</frameset>' + nl +
  '</html>');
  CloseFile(F);
  Result := 1;
end;

end.
