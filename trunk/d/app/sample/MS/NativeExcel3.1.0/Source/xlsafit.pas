//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsafit
//
//
//      Description: Autofit width or height routines 
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

unit xlsafit;
{$I xlsdef.inc}
{$Q-}
{$R-}

interface
uses nexcel, xlsfrmt, 
     {$IFDEF D2012}Vcl.Graphics{$ELSE}Graphics{$ENDIF};

type 

  TXLSAutoFit = class
  private
    FRange: TXLSRange;
    FFormater: TXLSFormater;
    FCanvas: TCanvas;
    function GetPixelsPerInch: integer;
    procedure ColumnAutoFit(Range: IXLSRange);
    procedure RowAutoFit(Range: IXLSRange);
    function GetCellWidth(Cell: IXLSRange; CurWidth: integer): integer;
    function GetCellHeight(Cell: IXLSRange; CurHeight: integer): integer;
    function GetWidth(Cell: IXLSRange; CurWidth: integer): integer;
    function GetHeight(Cell: IXLSRange; CurHeight: integer): integer;
   
    function GetTextWidth(Value: WideString; 
                          FontName: WideString; FontSize: Double; FontBold: boolean;
                          WordBreak: boolean;
                          Height: integer;
                          CurWidth: integer): integer;
    function GetMultiLineTextWidth(Value: WideString;
                                   CurHeight, CurWidth: integer;
                                   SlHeight, SlWidth: integer): integer;

    function GetTextHeight(Cell: IXLSRange; Value: WideString; 
                          FontName: WideString; FontSize: Double; FontBold: boolean;
                          WordBreak: boolean;
                          Width: integer): integer;
 
    function GetWidthA: integer;
  public
    constructor Create(Range: TXLSRange);
    procedure   ColumnsAutoFit;
    procedure   RowsAutoFit;
    destructor  Destroy; override;
    function PixelsToExcelWidth(PixelsWidth: integer): Double;
    function PixelsToExcelHeight(PixelsHeight: integer): Double;
    function ExcelWidthToPixels(Width: Double): integer;
    function ExcelHeightToPixels(Height: Double): integer;
  end;

implementation
uses 
  {$IFDEF D2012}
    Winapi.Windows, System.Classes, System.Math, System.SysUtils;
  {$ELSE}
    windows, classes, math, sysutils;
  {$ENDIF}

type
  TDrawTextW = function (hDC: HDC; lpString: PWideChar; nCount: Integer; var lpRect: TRect; uFormat: UINT): Integer; stdcall;

Var

  GlobalPixelsPerInch: integer = -1;
  GlobalWidthA: integer = -1;

  DLLHnd: HMODULE;
  DrawTextW_: TDrawTextW;
  OSInfo: TOsVersionInfo;
  isWin32_Windows: boolean;
  isUnicowsLoaded: boolean;

{ 
  The API DrawTextW, does not work correctly on Windows 95, 98, and Me Systems.
  Windows 95/98/Me: DrawTextW is supported by the Microsoft Layer for Unicode. 
  To use this, you need to add UnicoWS.dll to your system, 
  as outlined in Microsoft Layer for Unicode on Windows 95/98/Me Systems.

  See: http://www.microsoft.com/downloads/details.aspx?FamilyID=73BA7BD7-ED06-4F0D-80A4-2A7EEAEE17E2&displaylang=en

  Under Windows 95/98/Me
  API DrawText will be used instead of DrawTextW in case UnicoWS.dll is not found.

  Great thanks to Maicon Gabriel Schmitz for above information.
}

function XLSDrawTextW(hDC: HDC; wString: WideString; nCount: Integer; var lpRect: TRect; uFormat: UINT): Integer;
begin
  if isWin32_Windows then begin
    if isUnicowsLoaded then begin
      Result := DrawTextW_(hDC, PWideChar(wString), nCount, lpRect, uFormat);
    end else begin
      {$ifdef D2012}
        Result := DrawTextW(hDC, wString, nCount, lpRect, uFormat);
      {$else}
        Result := DrawText(hDC, PChar(String(wString)), nCount, lpRect, uFormat);
      {$endif}
    end;
  end else begin
    Result := DrawTextW(hDC, PWideChar(wString), nCount, lpRect, uFormat);
  end;
end;


constructor TXLSAutoFit.Create(Range: TXLSRange);
begin
  inherited Create;
  FRange := Range;
  FCanvas := TCanvas.Create;
  FFormater := TXLSFormater.Create(true);
  GetWidthA();
//  FWidthA   := GetTextWidth('a', 'Arial', 10, false, false, 30, 0);
end;

function TXLSAutoFit.GetPixelsPerInch: integer;
var
  DC: HDC;
begin
  if GlobalPixelsPerInch = -1 then begin
    DC := GetDC(0);
    GlobalPixelsPerInch := GetDeviceCaps(DC, LOGPIXELSY);
    ReleaseDC(0, DC);
  end;
  Result := GlobalPixelsPerInch;
end;

function TXLSAutoFit.GetWidthA: integer;
var
  MemDC: HDC;
  TM: TTextMetric;
  fstyle: TFontStyles;
begin
  if GlobalWidthA = -1 then begin
     MemDC := CreateCompatibleDC(0);
     try
       FCanvas.Handle := MemDC;
       FCanvas.Font.Name := 'Arial';
       FCanvas.Font.Size := 10;

       fstyle := [];
       FCanvas.Font.Style := fstyle;

       GetTextMetrics(FCanvas.Handle, TM);

       GlobalWidthA := TM.tmAveCharWidth;

       //GlobalWidthA := Round(GetTextWidth('09', 'Arial', 10, false, false, 30, 0)/2);
       GlobalWidthA := GetTextWidth('0', 'Arial', 10, false, false, 30, 0);
     finally
       FCanvas.Handle := 0;
       DeleteDC(MemDC);
     end;
  end;
  Result := GlobalWidthA;
end;


procedure TXLSAutoFit.ColumnsAutoFit;
Var r1,c1,r2,c2: integer;
    aRange: IXLSRange;
    col: integer;
    MemDC: HDC;
begin
   r1 := FRange.Row;
   r2 := r1 + integer(FRange.Rows.Count) - 1;
   c1 := FRange.Column;
   c2 := c1 + integer(FRange.Columns.Count) - 1;
   aRange := FRange.Worksheet.UsedRange;

   if r1 < aRange.Row then r1 := aRange.Row;
   if r2 > (aRange.Row + integer(aRange.Rows.Count) - 1)  then 
      r2 := (aRange.Row + integer(aRange.Rows.Count) - 1);
   if r2 < r1 then exit;

   if c1 < aRange.Column then c1 := aRange.Column;
   if c2 > (aRange.Column + integer(aRange.Columns.Count) - 1)  then 
      c2 := (aRange.Column + integer(aRange.Columns.Count) - 1);
   if c2 < c1 then exit;

   aRange := FRange.Worksheet.RCRange[r1, c1, r2, c2];

   MemDC := CreateCompatibleDC(0);
   try
     FCanvas.Handle := MemDC;
     for col := 1 to (c2 - c1 + 1) do ColumnAutoFit(aRange.Columns[col])
   finally
     FCanvas.Handle := 0;
     DeleteDC(MemDC);
   end;
  
end;

procedure TXLSAutoFit.RowsAutoFit;
Var r1,c1,r2,c2: integer;
    aRange: IXLSRange;
    row: integer;
    MemDC: HDC;
begin
   r1 := FRange.Row;
   r2 := r1 + integer(FRange.Rows.Count) - 1;
   c1 := FRange.Column;
   c2 := c1 + integer(FRange.Columns.Count) - 1;
   aRange := FRange.Worksheet.UsedRange;
   if r1 < aRange.Row then r1 := aRange.Row;
   if r2 > (aRange.Row + integer(aRange.Rows.Count) - 1)  then 
      r2 := (aRange.Row + integer(aRange.Rows.Count) - 1);
   if r2 < r1 then exit;

   if c1 < aRange.Column then c1 := aRange.Column;
   if c2 > (aRange.Column + integer(aRange.Columns.Count) - 1)  then 
      c2 := (aRange.Column + integer(aRange.Columns.Count) - 1);
   if c2 < c1 then exit;

   aRange := FRange.Worksheet.RCRange[r1, c1, r2, c2];
   MemDC := CreateCompatibleDC(0);
   try
     FCanvas.Handle := MemDC;
     for row := 1 to (r2 - r1 + 1) do RowAutoFit(aRange.Rows[row])
   finally
     FCanvas.Handle := 0;
     DeleteDC(MemDC);
   end;
end;

destructor TXLSAutoFit.Destroy;
begin
  FFormater.Free;
  FCanvas.Free;
  inherited Destroy;
end;


procedure TXLSAutoFit.ColumnAutoFit(Range: IXLSRange);
Var row, col, rowcnt: integer;
    curwidth: integer;
    newwidth: integer; 
begin
  rowcnt := Range.Rows.Count;
//  frow   := Range.Row;
  col   := 1;
  curwidth := -1;
  if rowcnt > 0 then begin
     for row := 1 to rowcnt do begin       
       newwidth := GetWidth(Range.Cells[row, col], curwidth);
       if newwidth > 0 then begin
          if newwidth > curwidth then begin
             curwidth := newwidth;
          end;
       end;
     end;
     if curwidth > 0 then begin
        Range.Columns[1].ColumnWidth := PixelsToExcelWidth(curwidth);
     end;
  end;
end;

procedure TXLSAutoFit.RowAutoFit(Range: IXLSRange);
Var col, row, colcnt: integer;
    curheight: integer;
    newheight: integer; 
begin
  colcnt := Range.Columns.Count;
//  fcol   := Range.Column;
  row    := 1;
  curheight := -1;
  if colcnt > 0 then begin
     for col := 1 to colcnt do begin
       newheight := GetHeight(Range.Cells[row, col], curheight);
       if newheight > 0 then begin
          if newheight > curheight then begin
             curheight := newheight;
          end;
       end;
     end;
     if curheight > 0 then begin
        Range.Rows[1].RowHeight := PixelsToExcelHeight(curheight);
     end;
  end;
end;

function TXLSAutoFit.GetCellWidth(Cell: IXLSRange; CurWidth: integer): integer;
Var Txt: WideString;
    CellHeight: integer;
    marea: IXLSRange;
    cnt, row: integer;
begin
  Result := -1;
  if Cell.MergeCells then begin
     marea := Cell.MergeArea;
     if (marea.Row <> Cell.Row) or
        (marea.Column <> Cell.Column) or
        (marea.Columns.Count > 1) then exit;
     cnt := marea.Rows.Count;
     CellHeight := 0;
     for row := 1 to cnt do begin
        CellHeight := CellHeight + ExcelHeightToPixels(marea.Rows[row].RowHeight);
     end;
  end else begin
     CellHeight := ExcelHeightToPixels(Cell.RowHeight);
  end;

  if CellHeight <= 0 then exit;

  Txt := FFormater.GetDisplayValue(Cell.Value, Cell.NumberFormat);
  if Txt = '' then exit;
  Result := GetTextWidth(Txt, Cell.Font.Name, Cell.Font.Size,
                         Cell.Font.Bold, Cell.WrapText, CellHeight, CurWidth);
  Result := Result + 5 + Round(GetTextWidth('0', Cell.Font.Name, Cell.Font.Size,
                         Cell.Font.Bold, false, CellHeight, 0)/3);
//  if Result > 0 then Inc(Result, 5); //extra space
end;

function TXLSAutoFit.GetHeight(Cell: IXLSRange; CurHeight: integer): integer;
begin
  if (Cell.Orientation = 90) or (Cell.Orientation = -90) then begin
     Result := GetCellWidth(Cell, CurHeight);  
  end else begin
     Result := GetCellHeight(Cell, CurHeight);  
  end;
end;

function TXLSAutoFit.GetWidth(Cell: IXLSRange; CurWidth: integer): integer;
begin
  if (Cell.Orientation = 90) or (Cell.Orientation = -90) then begin
     Result := GetCellHeight(Cell, CurWidth);  
  end else begin
     Result := GetCellWidth(Cell, CurWidth);  
  end;
end;

function TXLSAutoFit.GetCellHeight(Cell: IXLSRange; CurHeight: integer): integer;
Var Txt: WideString;
    CellWidth: integer;
    marea: IXLSRange;
    col, cnt: integer;
begin
  Result := -1;
  if Cell.MergeCells then begin
     marea := Cell.MergeArea;
     if (marea.Row <> Cell.Row) or
        (marea.Column <> Cell.Column) or
        (marea.Rows.Count > 1) then exit;
     CellWidth := 0;
     cnt := marea.Columns.Count;
     for col := 1 to cnt do begin
       CellWidth := CellWidth + ExcelWidthToPixels(marea.Columns[col].ColumnWidth);
     end;
  end else begin
     CellWidth := ExcelWidthToPixels(Cell.ColumnWidth);
  end;

  if CellWidth <= 0 then exit;

  if not(Cell.WrapText) then 
     Txt := 'Wg'
  else
     Txt := FFormater.GetDisplayValue(Cell.Value, Cell.NumberFormat);

  if Txt = '' then Txt := 'Wg';
  if Txt = 'Wg' then begin
     Result := GetTextHeight(Cell, Txt, Cell.Font.Name, Cell.Font.Size,
                             Cell.Font.Bold, Cell.WrapText, CellWidth);
//     Result := Result + Result div 5;
  end else begin
     Result := GetTextHeight(Cell, Txt, Cell.Font.Name, Cell.Font.Size,
                             Cell.Font.Bold, Cell.WrapText, CellWidth){ +
               GetTextHeight('Wg', Cell.Font.Name, Cell.Font.Size,
                             Cell.Font.Bold, false, CellWidth) div 5};   
  end;
  
end;

function TXLSAutoFit.PixelsToExcelWidth(PixelsWidth: integer): Double;
begin
  if  PixelsWidth >= (5 + GetWidthA) then begin
      Result := Round(100 * (PixelsWidth - 5)/GetWidthA) / 100;
  end else begin
      Result := Round(100 * PixelsWidth/(GetWidthA + 5)) / 100;
  end;
end;

function TXLSAutoFit.PixelsToExcelHeight(PixelsHeight: integer): Double;
begin
    Result := PixelsHeight * 72 / GetPixelsPerInch();
end;

function TXLSAutoFit.ExcelWidthToPixels(Width: Double): integer;
begin
    if Width >= 1 then begin
       Result := Round(Width * GetWidthA) + 5;
    end else begin
       Result := Round(Width * (GetWidthA + 5));
    end;   
end;

function TXLSAutoFit.ExcelHeightToPixels(Height: Double): integer;
begin
    Result := Trunc(Height / 72 * GetPixelsPerInch());
end;


function TXLSAutoFit.GetTextWidth(Value: WideString; 
                      FontName: WideString; FontSize: Double; FontBold: boolean;
                      WordBreak: boolean;
                      Height: integer;
                      CurWidth: integer): integer;
Var  
    fstyle: TFontStyles;
    lRect: TRect;
    Flags: integer;
begin
    FCanvas.Font.Name := FontName;
    FCanvas.Font.Size := Round(FontSize);
    fstyle := [];
    Flags := 0;
    if FontBold      then Include(fstyle, fsBold);
    Flags := Flags or DT_SINGLELINE;
    FCanvas.Font.Style := fstyle;
    lRect := Rect(0, 0, 1, Height);
    XLSDrawTextW(FCanvas.Handle, Value, Length(Value), 
              lRect, Flags or DT_CALCRECT); 
    Result := lRect.Right;

    if WordBreak and 
       (Result > CurWidth) and
       (lRect.Bottom < Height) then begin
       Result := GetMultiLineTextWidth(Value, Height, CurWidth, lRect.Bottom, Result);
    end;

    if Result <= 0 then Result := -1;
end;


function TXLSAutoFit.GetTextHeight(Cell:IXLSRange; Value: WideString; 
                      FontName: WideString; FontSize: Double; FontBold: boolean;
                      WordBreak: boolean;
                      Width: integer): integer;
Var  
    fstyle: TFontStyles;
    lRect: TRect;
    Flags: integer;

    TM: TTextMetric;
    lcnt:integer;
    onerowheight: integer;
begin
    FCanvas.Font.Name := FontName;
    FCanvas.Font.Size := Round(FontSize);

    fstyle := [];
    Flags := 0;
    if FontBold      then Include(fstyle, fsBold);
    if WordBreak      then Flags := Flags or DT_WORDBREAK
                      else Flags := Flags or DT_SINGLELINE;

    FCanvas.Font.Style := fstyle;
    lRect := Rect(0, 0, Width, 1);
    XLSDrawTextW(FCanvas.Handle, Value, Length(Value), 
              lRect, Flags or DT_CALCRECT); 
    Result := lRect.Bottom;


    if Result <= 0 then Result := -1;

    if Result > 0 then begin
       GetTextMetrics(FCanvas.Handle, TM);
       lcnt := lRect.Bottom div TM.tmHeight; 
       onerowheight := TM.tmHeight +  TM.tmDescent - TM.tmInternalLeading + 1;

{       Cell.Cells[1, 2].Value := TM.tmHeight;
       Cell.Cells[1, 3].Value := TM.tmAscent;
       Cell.Cells[1, 4].Value := TM.tmDescent;
       Cell.Cells[1, 7].Value := TM.tmInternalLeading;
       Cell.Cells[1, 8].Value := TM.tmOverhang;
       Cell.Cells[1, 9].Value := TM.tmAveCharWidth;
       Cell.Cells[1, 10].Value := TM.tmMaxCharWidth;
}
       Result := onerowheight * lcnt;

       if TM.tmHeight <= 10 then Result :=  Result + 1;
       if onerowheight < 10 then Result := Result + 2 * lcnt;

    end;
end;


function TXLSAutoFit.GetMultiLineTextWidth(Value: WideString;
                                           CurHeight, CurWidth: integer;
                                           SlHeight,  SlWidth: integer): integer;
Var RowCount: integer;
    w: integer;
    Precision: integer;
    wdelta: integer;
    lRect: TRect;
    len: integer;
begin
  Result := SlWidth;
  if SlHeight <= 0 then exit;

  RowCount := Trunc(CurHeight/SlHeight);
  if RowCount <= 1 then exit;

  Precision := 3;

  if CurWidth > 10 then CurWidth := CurWidth - 10;

  w := CurWidth + (SlWidth - CurWidth) div 2;

  wdelta := (slWidth - CurWidth);
  len := Length(Value);

  while wdelta > Precision do begin
    wdelta := wdelta div 2;
    lRect := Rect(0,0,w,0);
    XLSDrawTextW(FCanvas.Handle, Value, len, 
              lRect, DT_WORDBREAK or DT_CALCRECT);
    
    if lRect.Bottom > CurHeight then w := w + wdelta
                                else w := w - wdelta;
    if wdelta <= Precision then Result := w + Precision;  
  end;  
  
end;

initialization

  OSInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(OSInfo);
  isWin32_Windows := (OSInfo.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS);
  isUnicowsLoaded := false;
  DLLHnd := 0;
  DrawTextW_ := nil;

  if isWin32_Windows then begin
    try
      {$ifdef D2012}
      DLLHnd := LoadLibrary(PWideChar(WideString('unicows.dll')));
      {$else}
      DLLHnd := LoadLibrary(PChar('unicows.dll'));
      {$endif}
      if (DLLHnd <> HINSTANCE_ERROR) then begin
        DrawTextW_ := TDrawTextW(GetProcAddress(DLLHND, 'DrawTextW'));
        isUnicowsLoaded := Assigned(DrawTextW_);
      end;
    except
      on E:Exception do begin
         //skip
      end; 
    end; 
  end;

finalization
  if isWin32_Windows and (DLLHnd <> 0) then FreeLibrary(DLLHnd);
end.
