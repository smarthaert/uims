unit MyGraphics;
{$P+,S-,W-,R-,T-,X+,H+,B-}
{$C PRELOAD}

interface

uses
  Windows, MyClasses;

{ Graphics Objects }
type
  PColor = ^TColor;
  TColor = -$7FFFFFFF - 1..$7FFFFFFF;
{$NODEFINE TColor}
  (*$HPPEMIT 'namespace Graphics'*)
  (*$HPPEMIT '{'*)
  (*$HPPEMIT '  enum TColor {clMin=-0x7fffffff-1, clMax=0x7fffffff};'*)
  (*$HPPEMIT '}'*)

const
  clSystemColor = $FF000000;

  clBtnHighlight = TColor(clSystemColor or COLOR_BTNHIGHLIGHT);
  clBtnFace = TColor(clSystemColor or COLOR_BTNFACE);
  clBtnShadow = TColor(clSystemColor or COLOR_BTNSHADOW);
  clBtnText = TColor(clSystemColor or COLOR_BTNTEXT);

  clBlack = TColor($000000);
  clMaroon = TColor($000080);
  clGreen = TColor($008000);
  clOlive = TColor($008080);
  clNavy = TColor($800000);
  clPurple = TColor($800080);
  clTeal = TColor($808000);
  clGray = TColor($808080);
  clSilver = TColor($C0C0C0);
  clRed = TColor($0000FF);
  clLime = TColor($00FF00);
  clYellow = TColor($00FFFF);
  clBlue = TColor($FF0000);
  clFuchsia = TColor($FF00FF);
  clAqua = TColor($FFFF00);
  clLtGray = TColor($C0C0C0);
  clDkGray = TColor($808080);
  clWhite = TColor($FFFFFF);
  clNone = TColor($1FFFFFFF);

type
  TBitmap = class;
  TCanvasStates = (csHandleValid, csFontValid, csPenValid, csBrushValid);
  TCanvasState = set of TCanvasStates;

  TCanvas = class(TObject)
  private
    FHandle: HDC;
    State: TCanvasState;
    FLock: TRTLCriticalSection;
    FLockCount: Integer;
    procedure DeselectHandles;
    function GetHandle: HDC;
    procedure SetHandle(Value: HDC);
  protected
    procedure CreateHandle; virtual;
    procedure RequiredState(ReqState: TCanvasState);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure Refresh;
    function TryLock: Boolean;
    procedure Unlock;
    property Handle: HDC read GetHandle write SetHandle;
    property LockCount: Integer read FLockCount;
  published
  end;

  TBitmapImage = class(TObject)
  private
    FRefCount: Integer;
    FHandle: HBITMAP; // DDB or DIB handle, used for drawing
    FMaskHandle: HBITMAP; // DDB handle
    FPalette: HPALETTE;
    FDIBHandle: HBITMAP; // DIB handle corresponding to TDIBSection
    FDIB: TDIBSection;
    FHalftone: Boolean; // FPalette is halftone; don't write to file
  protected
    procedure Reference;
    procedure Release;
    property RefCount: Integer read FRefCount;
    procedure FreeHandle; //override;
  public
    destructor Destroy; override;
  end;

  TBitmapHandleType = (bmDIB, bmDDB);
  TPixelFormat = (pfDevice, pf1bit, pf4bit, pf8bit, pf15bit, pf16bit, pf24bit, pf32bit, pfCustom);

  TBitmap = class(TObject)
  private
    FImage: TBitmapImage;
    FCanvas: TCanvas;
    FMaskBitsValid: Boolean;
    FMaskValid: Boolean;
    procedure CopyImage(AHandle: HBITMAP; APalette: HPALETTE; DIB: TDIBSection);
    procedure DIBNeeded;
    procedure FreeContext;
    function GetCanvas: TCanvas;
    function GetHandle: HBITMAP; virtual;
    function GetHandleType: TBitmapHandleType;
    function GetMaskHandle: HBITMAP; virtual;
    function GetPixelFormat: TPixelFormat;
    function GetScanline(Row: Integer): Pointer;
    procedure NewImage(NewHandle: HBITMAP; NewPalette: HPALETTE; const NewDIB: TDIBSection);
    procedure ReadStream(Stream: TStream; Size: Longint);
    procedure WriteStream(Stream: TStream; WriteSize: Boolean);
    procedure ReadDIB(Stream: TStream; ImageSize: LongWord; bmf: PBitmapFileHeader = nil);
    procedure SetHandle(Value: HBITMAP);
    procedure SetHandleType(Value: TBitmapHandleType); virtual;
    procedure SetMaskHandle(Value: HBITMAP);
    procedure SetPixelFormat(Value: TPixelFormat);
  protected
    function GetEmpty: Boolean;
    function GetHeight: Integer;
    function GetPalette: HPALETTE;
    function GetWidth: Integer;
    procedure HandleNeeded;
    procedure MaskHandleNeeded;
    procedure SetHeight(Value: Integer);
    procedure SetPalette(Value: HPALETTE);
    procedure SetWidth(Value: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    procedure FreeImage;
    function HandleAllocated: Boolean;
    procedure LoadFromStream(Stream: TStream);
    function ReleaseHandle: HBITMAP;
    function ReleaseMaskHandle: HBITMAP;
    function ReleasePalette: HPALETTE;
    procedure SaveToStream(Stream: TStream);
    property Canvas: TCanvas read GetCanvas;
    property Handle: HBITMAP read GetHandle write SetHandle;
    property HandleType: TBitmapHandleType read GetHandleType write SetHandleType;
    property MaskHandle: HBITMAP read GetMaskHandle write SetMaskHandle;
    property PixelFormat: TPixelFormat read GetPixelFormat write SetPixelFormat;
    property ScanLine[Row: Integer]: Pointer read GetScanLine;
    property Height: Integer read GetHeight write SetHeight;
    property Width: Integer read GetWidth write SetWidth;
  end;

var
  SystemPalette16: HPalette; // 16 color palette that maps to the system palette

procedure GetDIBSizes(Bitmap: HBITMAP; var InfoHeaderSize: DWORD; var ImageSize: DWORD);
function GetDIB(Bitmap: HBITMAP; Palette: HPALETTE; var BitmapInfo; var Bits): Boolean;
function CopyPalette(Palette: HPALETTE): HPALETTE;
function BytesPerScanline(PixelsPerScanline, BitsPerPixel, Alignment: Longint): Longint;

implementation

const
  csAllValid = [csHandleValid..csBrushValid];

var
  ScreenLogPixels: Integer;
  StockPen: HPEN;
  StockBrush: HBRUSH;
  StockFont: HFONT;
  BitmapImageLock: TRTLCriticalSection;
  CounterLock: TRTLCriticalSection;
  CanvasList: TThreadList;

procedure InternalDeletePalette(Pal: HPalette);
begin
  if (Pal <> 0) and (Pal <> SystemPalette16) then DeleteObject(Pal);
end;

{ TCanvas }
constructor TCanvas.Create;
begin
  inherited Create;
  InitializeCriticalSection(FLock);
  State := [];
  CanvasList.Add(Self);
end;

destructor TCanvas.Destroy;
begin
  CanvasList.Remove(Self);
  SetHandle(0);
  DeleteCriticalSection(FLock);
  inherited Destroy;
end;

procedure TCanvas.Lock;
begin
  EnterCriticalSection(CounterLock);
  Inc(FLockCount);
  LeaveCriticalSection(CounterLock);
  EnterCriticalSection(FLock);
end;

type
  PPoints = ^TPoints;
  TPoints = array[0..0] of TPoint;

procedure TCanvas.Refresh;
begin
  DeselectHandles;
end;

function TCanvas.TryLock: Boolean;
begin
  EnterCriticalSection(CounterLock);
  try
    Result := FLockCount = 0;
    if Result then Lock;
  finally
    LeaveCriticalSection(CounterLock);
  end;
end;

procedure TCanvas.Unlock;
begin
  LeaveCriticalSection(FLock);
  EnterCriticalSection(CounterLock);
  Dec(FLockCount);
  LeaveCriticalSection(CounterLock);
end;

function TCanvas.GetHandle: HDC;
begin
  RequiredState(csAllValid);
  Result := FHandle;
end;

procedure TCanvas.DeselectHandles;
begin
  if (FHandle <> 0) and (State - [csPenValid, csBrushValid, csFontValid] <> State) then
  begin
    SelectObject(FHandle, StockPen);
    SelectObject(FHandle, StockBrush);
    SelectObject(FHandle, StockFont);
    State := State - [csPenValid, csBrushValid, csFontValid];
  end;
end;

procedure TCanvas.CreateHandle;
begin
end;

procedure TCanvas.SetHandle(Value: HDC);
begin
  if FHandle <> Value then
  begin
    if FHandle <> 0 then
    begin
      DeselectHandles;
      FHandle := 0;
      Exclude(State, csHandleValid);
    end;
    if Value <> 0 then
    begin
      Include(State, csHandleValid);
      FHandle := Value;
    end;
  end;
end;

procedure TCanvas.RequiredState(ReqState: TCanvasState);
var
  NeededState: TCanvasState;
begin
  NeededState := ReqState - State;
  if NeededState <> [] then
  begin
    if csHandleValid in NeededState then
    begin
      CreateHandle;
    end;
    State := State + NeededState;
  end;
end;

function GetDInColors(BitCount: Word): Integer;
begin
  case BitCount of
    1, 4, 8: Result := 1 shl BitCount;
  else
    Result := 0;
  end;
end;

function BytesPerScanline(PixelsPerScanline, BitsPerPixel, Alignment: Longint): Longint;
begin
  Dec(Alignment);
  Result := ((PixelsPerScanline * BitsPerPixel) + Alignment) and not Alignment;
  Result := Result div 8;
end;

type
  PRGBTripleArray = ^TRGBTripleArray;
  TRGBTripleArray = array[Byte] of TRGBTriple;
  PRGBQuadArray = ^TRGBQuadArray;
  TRGBQuadArray = array[Byte] of TRGBQuad;

procedure ByteSwapColors(var Colors; Count: Integer);
var // convert RGB to BGR and vice-versa.  TRGBQuad <-> TPaletteEntry
  SysInfo: TSystemInfo;
begin
  GetSystemInfo(SysInfo);
  asm
        MOV   EDX, Colors
        MOV   ECX, Count
        DEC   ECX
        JS    @@END
        LEA   EAX, SysInfo
        CMP   [EAX].TSystemInfo.wProcessorLevel, 3
        JE    @@386
  @@1:  MOV   EAX, [EDX+ECX*4]
        BSWAP EAX
        SHR   EAX,8
        MOV   [EDX+ECX*4],EAX
        DEC   ECX
        JNS   @@1
        JMP   @@END
  @@386:
        PUSH  EBX
  @@2:  XOR   EBX,EBX
        MOV   EAX, [EDX+ECX*4]
        MOV   BH, AL
        MOV   BL, AH
        SHR   EAX,16
        SHL   EBX,8
        MOV   BL, AL
        MOV   [EDX+ECX*4],EBX
        DEC   ECX
        JNS   @@2
        POP   EBX
    @@END:
  end;
end;

function CreateSystemPalette(const Entries: array of TColor): HPALETTE;
var
  DC: HDC;
  SysPalSize: Integer;
  Pal: TMaxLogPalette;
begin
  Pal.palVersion := $300;
  Pal.palNumEntries := 16;
  Move(Entries, Pal.palPalEntry, 16 * SizeOf(TColor));
  DC := GetDC(0);
  try
    SysPalSize := GetDeviceCaps(DC, SIZEPALETTE);
    if SysPalSize >= 16 then
    begin
      GetSystemPaletteEntries(DC, 0, 8, Pal.palPalEntry);
      { Is light and dark gray swapped? }
      if TColor(Pal.palPalEntry[7]) = clSilver then
      begin
        GetSystemPaletteEntries(DC, SysPalSize - 8, 1, Pal.palPalEntry[7]);
        GetSystemPaletteEntries(DC, SysPalSize - 7, 7, Pal.palPalEntry[Pal.palNumEntries - 7]);
        GetSystemPaletteEntries(DC, 7, 1, Pal.palPalEntry[8]);
      end
      else
        GetSystemPaletteEntries(DC, SysPalSize - 8, 8, Pal.palPalEntry[Pal.palNumEntries - 8]);
    end
    else
    begin
    end;
  finally
    ReleaseDC(0, DC);
  end;
  Result := CreatePalette(PLogPalette(@Pal)^);
end;

function SystemPaletteOverride(var Pal: TMaxLogPalette): Boolean;
var
  DC: HDC;
  SysPalSize: Integer;
begin
  Result := False;
  if SystemPalette16 <> 0 then
  begin
    DC := GetDC(0);
    try
      SysPalSize := GetDeviceCaps(DC, SIZEPALETTE);
      if SysPalSize >= 16 then
      begin
        GetPaletteEntries(SystemPalette16, 0, 8, Pal.palPalEntry);
        GetPaletteEntries(SystemPalette16, 8, 8, Pal.palPalEntry[Pal.palNumEntries - 8]);
        Result := True;
      end
    finally
      ReleaseDC(0, DC);
    end;
  end;
end;

function PaletteFromDIBColorTable(DIBHandle: THandle; ColorTable: Pointer;
  ColorCount: Integer): HPalette;
var
  DC: HDC;
  Save: THandle;
  Pal: TMaxLogPalette;
begin
  Result := 0;
  Pal.palVersion := $300;
  if DIBHandle <> 0 then
  begin
    DC := CreateCompatibleDC(0);
    Save := SelectObject(DC, DIBHandle);
    Pal.palNumEntries := GetDIBColorTable(DC, 0, 256, Pal.palPalEntry);
    SelectObject(DC, Save);
    DeleteDC(DC);
  end
  else
  begin
    Pal.palNumEntries := ColorCount;
    Move(ColorTable^, Pal.palPalEntry, ColorCount * 4);
  end;
  if Pal.palNumEntries = 0 then Exit;
  if (Pal.palNumEntries <> 16) or not SystemPaletteOverride(Pal) then
    ByteSwapColors(Pal.palPalEntry, Pal.palNumEntries);
  Result := CreatePalette(PLogPalette(@Pal)^);
end;

function PaletteToDIBColorTable(Pal: HPalette;
  var ColorTable: array of TRGBQuad): Integer;
begin
  Result := 0;
  if (Pal = 0) or
    (GetObject(Pal, sizeof(Result), @Result) = 0) or
    (Result = 0) then Exit;
  if Result > High(ColorTable) + 1 then Result := High(ColorTable) + 1;
  GetPaletteEntries(Pal, 0, Result, ColorTable);
  ByteSwapColors(ColorTable, Result);
end;

procedure InitializeBitmapInfoHeader(Bitmap: HBITMAP; var BI: TBitmapInfoHeader; Colors: Integer);
var
  DS: TDIBSection;
  Bytes: Integer;
begin
  DS.dsbmih.biSize := 0;
  Bytes := GetObject(Bitmap, SizeOf(DS), @DS);
  if Bytes = 0 then Exit
  else if (Bytes >= (sizeof(DS.dsbm) + sizeof(DS.dsbmih))) and
    (DS.dsbmih.biSize >= DWORD(sizeof(DS.dsbmih))) then
    BI := DS.dsbmih
  else
  begin
    FillChar(BI, sizeof(BI), 0);
    with BI, DS.dsbm do
    begin
      biSize := SizeOf(BI);
      biWidth := bmWidth;
      biHeight := bmHeight;
    end;
  end;
  case Colors of
    2: BI.biBitCount := 1;
    3..16:
      begin
        BI.biBitCount := 4;
        BI.biClrUsed := Colors;
      end;
    17..256:
      begin
        BI.biBitCount := 8;
        BI.biClrUsed := Colors;
      end;
  else
    BI.biBitCount := DS.dsbm.bmBitsPixel * DS.dsbm.bmPlanes;
  end;
  BI.biPlanes := 1;
  if BI.biClrImportant > BI.biClrUsed then
    BI.biClrImportant := BI.biClrUsed;
  if BI.biSizeImage = 0 then
    BI.biSizeImage := BytesPerScanLine(BI.biWidth, BI.biBitCount, 32) * Abs(BI.biHeight);
end;

procedure InternalGetDIBSizes(Bitmap: HBITMAP; var InfoHeaderSize: DWORD;
  var ImageSize: DWORD; Colors: Integer);
var
  BI: TBitmapInfoHeader;
begin
  InitializeBitmapInfoHeader(Bitmap, BI, Colors);
  if BI.biBitCount > 8 then
  begin
    InfoHeaderSize := SizeOf(TBitmapInfoHeader);
    if (BI.biCompression and BI_BITFIELDS) <> 0 then Inc(InfoHeaderSize, 12);
  end
  else
    if BI.biClrUsed = 0 then
      InfoHeaderSize := SizeOf(TBitmapInfoHeader) + SizeOf(TRGBQuad) * (1 shl BI.biBitCount)
    else
      InfoHeaderSize := SizeOf(TBitmapInfoHeader) + SizeOf(TRGBQuad) * BI.biClrUsed;
  ImageSize := BI.biSizeImage;
end;

procedure GetDIBSizes(Bitmap: HBITMAP; var InfoHeaderSize: DWORD;
  var ImageSize: DWORD);
begin
  InternalGetDIBSizes(Bitmap, InfoHeaderSize, ImageSize, 0);
end;

function InternalGetDIB(Bitmap: HBITMAP; Palette: HPALETTE;
  var BitmapInfo; var Bits; Colors: Integer): Boolean;
var
  OldPal: HPALETTE;
  DC: HDC;
begin
  InitializeBitmapInfoHeader(Bitmap, TBitmapInfoHeader(BitmapInfo), Colors);
  OldPal := 0;
  DC := CreateCompatibleDC(0);
  try
    if Palette <> 0 then
    begin
      OldPal := SelectPalette(DC, Palette, False);
      RealizePalette(DC);
    end;
    Result := GetDIBits(DC, Bitmap, 0, TBitmapInfoHeader(BitmapInfo).biHeight, @Bits,
      TBitmapInfo(BitmapInfo), DIB_RGB_COLORS) <> 0;
  finally
    if OldPal <> 0 then SelectPalette(DC, OldPal, False);
    DeleteDC(DC);
  end;
end;

function GetDIB(Bitmap: HBITMAP; Palette: HPALETTE; var BitmapInfo; var Bits): Boolean;
begin
  Result := InternalGetDIB(Bitmap, Palette, BitmapInfo, Bits, 0);
end;

var
  BitmapCanvasList: TThreadList = nil;

{ TBitmapCanvas }
type
  TBitmapCanvas = class(TCanvas)
  private
    FBitmap: TBitmap;
    FOldBitmap: HBITMAP;
    FOldPalette: HPALETTE;
    procedure FreeContext;
  protected
    procedure CreateHandle; override;
  public
    constructor Create(ABitmap: TBitmap);
    destructor Destroy; override;
  end;

procedure DeselectBitmap(AHandle: HBITMAP);
var
  I: Integer;
begin
  if AHandle = 0 then Exit;
  with BitmapCanvasList.LockList do
  try
    for I := Count - 1 downto 0 do
      with TBitmapCanvas(Items[I]) do
        if (FBitmap <> nil) and (FBitmap.FImage.FHandle = AHandle) then FreeContext;
  finally
    BitmapCanvasList.UnlockList;
  end;
end;

constructor TBitmapCanvas.Create(ABitmap: TBitmap);
begin
  inherited Create;
  FBitmap := ABitmap;
end;

destructor TBitmapCanvas.Destroy;
begin
  FreeContext;
  inherited Destroy;
end;

procedure TBitmapCanvas.FreeContext;
var
  H: HBITMAP;
begin
  if FHandle <> 0 then
  begin
    Lock;
    try
      if FOldBitmap <> 0 then SelectObject(FHandle, FOldBitmap);
      if FOldPalette <> 0 then SelectPalette(FHandle, FOldPalette, True);
      H := FHandle;
      Handle := 0;
      DeleteDC(H);
      BitmapCanvasList.Remove(Self);
    finally
      Unlock;
    end;
  end;
end;

procedure TBitmapCanvas.CreateHandle;
var
  H: HBITMAP;
begin
  if FBitmap <> nil then
  begin
    Lock;
    try
      FBitmap.HandleNeeded;
      DeselectBitmap(FBitmap.FImage.FHandle);
      H := CreateCompatibleDC(0);
      if FBitmap.FImage.FHandle <> 0 then
        FOldBitmap := SelectObject(H, FBitmap.FImage.FHandle) 
	  else
        FOldBitmap := 0;
      if FBitmap.FImage.FPalette <> 0 then
      begin
        FOldPalette := SelectPalette(H, FBitmap.FImage.FPalette, True);
        RealizePalette(H);
      end
      else
        FOldPalette := 0;
      Handle := H;
      BitmapCanvasList.Add(Self);
    finally
      Unlock;
    end;
  end;
end;

{ TBitmapImage }
procedure TBitmapImage.Reference;
begin
  Inc(FRefCount);
end;

procedure TBitmapImage.Release;
begin
  if Pointer(Self) <> nil then
  begin
    Dec(FRefCount);
    if FRefCount = 0 then
    begin
      FreeHandle;
      Free;
    end;
  end;
end;

destructor TBitmapImage.Destroy;
begin
  if FDIBHandle <> 0 then
  begin
    DeselectBitmap(FDIBHandle);
    DeleteObject(FDIBHandle);
    FDIBHandle := 0;
  end;
  FreeHandle;
  if FDIB.dshSection <> 0 then CloseHandle(FDIB.dshSection);
  inherited Destroy;
end;

procedure TBitmapImage.FreeHandle;
begin
  if (FHandle <> 0) and (FHandle <> FDIBHandle) then
  begin
    DeselectBitmap(FHandle);
    DeleteObject(FHandle);
  end;
  if FMaskHandle <> 0 then
  begin
    DeselectBitmap(FMaskHandle);
    DeleteObject(FMaskHandle);
    FMaskHandle := 0;
  end;
  InternalDeletePalette(FPalette);
  FHandle := 0;
  FPalette := 0;
end;

{ TBitmap }
const
  Grays: array[0..3] of TColor = (clWhite, clSilver, clGray, clBlack);
  SysGrays: array[0..3] of TColor = (clBtnHighlight, clBtnFace, clBtnShadow, clBtnText);

procedure UpdateDIBColorTable(DIBHandle: HBITMAP; Pal: HPalette;
  const DIB: TDIBSection);
var
  ScreenDC, DC: HDC;
  OldBM: HBitmap;
  ColorCount: Integer;
  Colors: array[Byte] of TRGBQuad;
begin
  if (DIBHandle <> 0) and (DIB.dsbmih.biBitCount <= 8) then
  begin
    ColorCount := PaletteToDIBColorTable(Pal, Colors);
    if ColorCount = 0 then Exit;
    ScreenDC := GetDC(0);
    DC := CreateCompatibleDC(ScreenDC);
    OldBM := SelectObject(DC, DIBHandle);
    try
      SetDIBColorTable(DC, 0, ColorCount, Colors);
    finally
      SelectObject(DC, OldBM);
      DeleteDC(DC);
      ReleaseDC(0, ScreenDC);
    end;
  end;
end;

procedure FixupBitFields(var DIB: TDIBSection);
begin
  if (DIB.dsbmih.biCompression and BI_BITFIELDS <> 0) and
    (DIB.dsBitFields[0] = 0) then
    if DIB.dsbmih.biBitCount = 16 then
    begin
      // fix buggy 16 bit color drivers
      DIB.dsBitFields[0] := $F800;
      DIB.dsBitFields[1] := $07E0;
      DIB.dsBitFields[2] := $001F;
    end else if DIB.dsbmih.biBitCount = 32 then
    begin
      // fix buggy 32 bit color drivers
      DIB.dsBitFields[0] := $00FF0000;
      DIB.dsBitFields[1] := $0000FF00;
      DIB.dsBitFields[2] := $000000FF;
    end;
end;

function CopyBitmap(Handle: HBITMAP; OldPalette, NewPalette: HPALETTE;
  var DIB: TDIBSection; Canvas: TCanvas): HBITMAP;
var
  OldScr, NewScr: HBITMAP;
  ScreenDC, NewImageDC, OldImageDC: HDC;
  BI: PBitmapInfo;
  BitsMem: Pointer;
  SrcDIB: TDIBSection;
  MonoColors: array[0..1] of Integer;
  Pal1, Pal2: HPalette;
begin
  Result := 0;
  with DIB, dsbm, dsbmih do
  begin
    if (biSize <> 0) and ((biWidth = 0) or (biHeight = 0)) then Exit;
    if (biSize = 0) and ((bmWidth = 0) or (bmHeight = 0)) then Exit;
  end;
  DeselectBitmap(Handle);
  SrcDIB.dsbmih.biSize := 0;
  if Handle <> 0 then GetObject(Handle, sizeof(SrcDIB), @SrcDIB);
  ScreenDC := GetDC(0);
  NewImageDC := CreateCompatibleDC(ScreenDC);
  with DIB.dsbm do
  try
    if DIB.dsbmih.biSize < DWORD(sizeof(DIB.dsbmih)) then
      if (bmPlanes or bmBitsPixel) = 1 then // monochrome
        Result := CreateBitmap(bmWidth, bmHeight, 1, 1, nil)
      else // Create DDB
        Result := CreateCompatibleBitmap(ScreenDC, bmWidth, bmHeight)
    else // Create DIB
    begin
      GetMem(BI, sizeof(TBitmapInfo) + 256 * sizeof(TRGBQuad));
      with DIB.dsbmih do
      try
        biSize := sizeof(BI.bmiHeader);
        biPlanes := 1;
        if biBitCount = 0 then biBitCount := GetDeviceCaps(ScreenDC, BITSPIXEL) * GetDeviceCaps(ScreenDC, PLANES);
        BI.bmiHeader := DIB.dsbmih;
        bmWidth := biWidth;
        bmHeight := biHeight;
        if (biBitCount <= 8) then
        begin
          if (biBitCount = 1) and ((Handle = 0) or (SrcDIB.dsbm.bmBits = nil)) then
          begin // set mono DIB to white/black when converting from DDB.
            Integer(BI^.bmiColors[0]) := 0;
            PInteger(Integer(@BI^.bmiColors) + sizeof(Integer))^ := $FFFFFF;
          end
          else if (NewPalette <> 0) then
            PaletteToDIBColorTable(NewPalette, PRGBQuadArray(@BI.bmiColors)^)
          else if Handle <> 0 then
          begin
            NewScr := SelectObject(NewImageDC, Handle);
            if (SrcDIB.dsbmih.biSize > 0) and (SrcDIB.dsbm.bmBits <> nil) then
              biClrUsed := GetDIBColorTable(NewImageDC, 0, 256, BI^.bmiColors)
            else
              GetDIBits(NewImageDC, Handle, 0, Abs(biHeight), nil, BI^, DIB_RGB_COLORS);
            SelectObject(NewImageDC, NewScr);
          end;
        end
        else if ((biBitCount = 16) or (biBitCount = 32)) and
          ((biCompression and BI_BITFIELDS) <> 0) then
        begin
          FixupBitFields(DIB);
          Move(DIB.dsBitFields, BI.bmiColors, sizeof(DIB.dsBitFields));
        end;
        Result := CreateDIBSection(ScreenDC, BI^, DIB_RGB_COLORS, BitsMem, 0, 0);
        if (Handle <> 0) and (SrcDIB.dsbm.bmWidth = biWidth) and
          (SrcDIB.dsbm.bmHeight = biHeight) and (biBitCount > 8) then
        begin // shortcut bitblt steps
          GetDIBits(NewImageDC, Handle, 0, Abs(biHeight), BitsMem, BI^, DIB_RGB_COLORS);
          Exit;
        end;
      finally
        FreeMem(BI);
      end;
    end;
    NewScr := SelectObject(NewImageDC, Result);
    try
      try
        Pal1 := 0;
        Pal2 := 0;
        if NewPalette <> 0 then
        begin
          Pal1 := SelectPalette(NewImageDC, NewPalette, False);
          RealizePalette(NewImageDC);
        end;
        try
          if Canvas <> nil then
          begin
            if (DIB.dsbmih.biBitCount = 1) and (DIB.dsbm.bmBits <> nil) then
            begin
              SetDIBColorTable(NewImageDC, 0, 2, MonoColors);
            end;
          end
          else
            PatBlt(NewImageDC, 0, 0, bmWidth, bmHeight, WHITENESS);
          if Handle <> 0 then
          begin
            OldImageDC := CreateCompatibleDC(ScreenDC);
            try
              OldScr := SelectObject(OldImageDC, Handle);
              if OldPalette <> 0 then
              begin
                Pal2 := SelectPalette(OldImageDC, OldPalette, False);
                RealizePalette(OldImageDC);
              end;
              BitBlt(NewImageDC, 0, 0, bmWidth, bmHeight, OldImageDC, 0, 0, SRCCOPY);
              if OldPalette <> 0 then
                SelectPalette(OldImageDC, Pal2, True);
              SelectObject(OldImageDC, OldScr);
            finally
              DeleteDC(OldImageDC);
            end;
          end;
        finally
          if NewPalette <> 0 then SelectPalette(NewImageDC, Pal1, True);
        end;
      finally
        SelectObject(NewImageDC, NewScr);
      end;
    except
      DeleteObject(Result);
      raise;
    end;
  finally
    DeleteDC(NewImageDC);
    ReleaseDC(0, ScreenDC);
    if (Result <> 0) then GetObject(Result, sizeof(DIB), @DIB);
  end;
end;

function CopyPalette(Palette: HPALETTE): HPALETTE;
var
  PaletteSize: Integer;
  LogPal: TMaxLogPalette;
begin
  Result := 0;
  if Palette = 0 then Exit;
  PaletteSize := 0;
  if GetObject(Palette, SizeOf(PaletteSize), @PaletteSize) = 0 then Exit;
  if PaletteSize = 0 then Exit;
  with LogPal do
  begin
    palVersion := $0300;
    palNumEntries := PaletteSize;
    GetPaletteEntries(Palette, 0, PaletteSize, palPalEntry);
  end;
  Result := CreatePalette(PLogPalette(@LogPal)^);
end;

constructor TBitmap.Create;
begin
  inherited Create;
  FImage := TBitmapImage.Create;
  FImage.Reference;
end;

destructor TBitmap.Destroy;
begin
  FreeContext;
  FCanvas.Free;
  FImage.Release;
  inherited Destroy;
end;

procedure TBitmap.CopyImage(AHandle: HBITMAP; APalette: HPALETTE; DIB: TDIBSection);
var
  NewHandle, NewPalette: THandle;
begin
  FreeContext;
  NewHandle := 0;
  NewPalette := 0;
  try
    if APalette = SystemPalette16 then
      NewPalette := APalette
    else
      NewPalette := CopyPalette(APalette);
    NewHandle := CopyBitmap(AHandle, APalette, NewPalette, DIB, FCanvas);
    NewImage(NewHandle, NewPalette, DIB);
  except
    InternalDeletePalette(NewPalette);
    if NewHandle <> 0 then DeleteObject(NewHandle);
    raise;
  end;
end;

procedure TBitmap.FreeImage;
var
  P: HPalette;
begin
  with FImage do
    if FRefCount > 1 then
    begin
      HandleNeeded;
      if FHalftone then
        P := 0
      else
        P := FPalette;
      CopyImage(FHandle, P, FDIB)
    end
    else
      if (FHandle <> 0) and (FHandle <> FDIBHandle) then
      begin
        if FDIBHandle <> 0 then
          DeleteObject(FDIBHandle);
        FDIBHandle := 0;
        FDIB.dsbm.bmBits := nil;
      end;
end;

function TBitmap.GetEmpty;
begin
  with FImage do
    Result := (FHandle = 0) and (FDIBHandle = 0);
end;

function TBitmap.GetCanvas: TCanvas;
begin
  if FCanvas = nil then
  begin
    HandleNeeded;
    if FCanvas = nil then // possible recursion
    begin
      FCanvas := TBitmapCanvas.Create(Self);
    end;
  end;
  Result := FCanvas;
end;

function TBitmap.GetHandle: HBITMAP;
begin
  FreeContext;
  HandleNeeded;
  Result := FImage.FHandle;
end;

function TBitmap.HandleAllocated: Boolean;
begin
  Result := Assigned(FImage) and (FImage.FHandle <> 0);
end;

function TBitmap.GetHandleType: TBitmapHandleType;
begin
  with FImage do
  begin
    if (FHandle = 0) or (FHandle = FDIBHandle) then
      if FDIBHandle = 0 then
        if FDIB.dsbmih.biSize = 0 then
          Result := bmDDB
        else
          Result := bmDIB
      else
        Result := bmDIB
    else
      Result := bmDDB;
  end;
end;

function TBitmap.GetHeight: Integer;
begin
  Result := Abs(FImage.FDIB.dsbm.bmHeight);
end;

function TBitmap.GetMaskHandle: HBITMAP;
begin
  MaskHandleNeeded;
  Result := FImage.FMaskHandle;
end;

function TBitmap.GetPalette: HPALETTE;
begin
  Result := FImage.FPalette;
end;

function TBitmap.GetPixelFormat: TPixelFormat;
begin
  Result := pfCustom;
  if HandleType = bmDDB then
    Result := pfDevice
  else
    with FImage.FDIB, dsbmih do
      case biBitCount of
        1: Result := pf1Bit;
        4: Result := pf4Bit;
        8: Result := pf8Bit;
        16: case biCompression of
            BI_RGB: Result := pf15Bit;
            BI_BITFIELDS: if dsBitFields[1] = $7E0 then Result := pf16Bit;
          end;
        24: Result := pf24Bit;
        32: if biCompression = BI_RGB then Result := pf32Bit;
      end;
end;

function TBitmap.GetScanLine(Row: Integer): Pointer;
begin
  with FImage.FDIB, dsbm, dsbmih do
  begin
    DIBNeeded;
    GDIFlush;
    if biHeight > 0 then Row := biHeight - Row - 1; // bottom-up DIB      
    Integer(Result) := Integer(bmBits) + Row * BytesPerScanline(biWidth, biBitCount, 32);
  end;
end;

function TBitmap.GetWidth: Integer;
begin
  Result := FImage.FDIB.dsbm.bmWidth;
end;

procedure TBitmap.DIBNeeded;
begin
  with FImage do
  begin
    if (FHandle = 0) or (FDIBHandle <> 0) then Exit;
    if FDIB.dsbmih.biSize = 0 then
    begin
      GetObject(FHandle, sizeof(FDIB), @FDIB);
      with FDIB, dsbm, dsbmih do
      begin
        biSize := sizeof(dsbmih);
        biWidth := bmWidth;
        biHeight := bmHeight;
        biPlanes := 1;
        biBitCount := bmPlanes * bmBitsPixel;
      end;
    end;
    FDIBHandle := CopyBitmap(FHandle, FPalette, FPalette, FDIB, nil);
  end;
end;

procedure TBitmap.FreeContext;
begin
  if (FCanvas <> nil) then TBitmapCanvas(FCanvas).FreeContext;
end;

procedure TBitmap.HandleNeeded;
begin
  with FImage do
    if FHandle = 0 then FHandle := FDIBHandle;
end;
procedure TBitmap.MaskHandleNeeded;
begin
  if FMaskValid and FMaskBitsValid then Exit;
  with FImage do
  begin
  { Delete existing mask if any }
    if FMaskHandle <> 0 then
    begin
      DeselectBitmap(FMaskHandle);
      DeleteObject(FMaskHandle);
      FMaskHandle := 0;
    end;
    FreeContext;
    HandleNeeded; // may change FImage instance pointer
  end;
  with FImage do // use new FImage from here on
  begin
    FMaskValid := True;
    FMaskBitsValid := True;
  end;
end;

procedure TBitmap.LoadFromStream(Stream: TStream);
begin
  ReadStream(Stream, Stream.Size - Stream.Position);
end;

procedure TBitmap.NewImage(NewHandle: HBITMAP; NewPalette: HPALETTE;
  const NewDIB: TDIBSection);
var
  Image: TBitmapImage;
begin
  Image := TBitmapImage.Create;
  with Image do
  try
    FHandle := NewHandle;
    FPalette := NewPalette;
    FDIB := NewDIB;
    if FDIB.dsbm.bmBits <> nil then FDIBHandle := FHandle;
  except
    Image.Free;
    raise;
  end;
  //!! replace with InterlockedExchange()
  EnterCriticalSection(BitmapImageLock);
  try
    FImage.Release;
    FImage := Image;
    FImage.Reference;
  finally
    LeaveCriticalSection(BitmapImageLock);
  end;
  FMaskValid := False;
end;

procedure TBitmap.ReadDIB(Stream: TStream; ImageSize: LongWord; bmf: PBitmapFileHeader);
const
  DIBPalSizes: array[Boolean] of Byte = (sizeof(TRGBQuad), sizeof(TRGBTriple));
var
  DC: HDC;
  BitsMem: Pointer;
  BitmapInfo: PBitmapInfo;
  ColorTable: Pointer;
  HeaderSize: Integer;
  BMHandle: HBITMAP;
  DIB: TDIBSection;
  Pal: HPalette;
begin
  Pal := 0;
  BMHandle := 0;
  Stream.Read(HeaderSize, sizeof(HeaderSize));
  GetMem(BitmapInfo, HeaderSize + 12 + 256 * sizeof(TRGBQuad));
  with BitmapInfo^ do
  try
    try
      Stream.Read(Pointer(Longint(BitmapInfo) + sizeof(HeaderSize))^, HeaderSize - sizeof(HeaderSize));
      Dec(ImageSize, HeaderSize);
      with bmiHeader do
      begin
        biSize := HeaderSize;
        ColorTable := Pointer(Longint(BitmapInfo) + HeaderSize);
        { check number of planes. DIBs must be 1 color plane (packed pixels) }
        // 3 DWORD color element bit masks (ie 888 or 565) can precede colors
        // TBitmapInfoHeader sucessors include these masks in the headersize
        if (HeaderSize = sizeof(TBitmapInfoHeader)) and
          ((biBitCount = 16) or (biBitCount = 32)) and
          (biCompression = BI_BITFIELDS) then
        begin
          Stream.ReadBuffer(ColorTable^, 3 * sizeof(DWORD));
          Inc(Longint(ColorTable), 3 * sizeof(DWORD));
          Dec(ImageSize, 3 * sizeof(DWORD));
        end;
        // Read the color palette
        if biClrUsed = 0 then
          biClrUsed := GetDInColors(biBitCount);
        Stream.ReadBuffer(ColorTable^, biClrUsed * DIBPalSizes[False]);
        Dec(ImageSize, biClrUsed * DIBPalSizes[False]);
        // biSizeImage can be zero. If zero, compute the size.
        if biSizeImage = 0 then // top-down DIBs have negative height
          biSizeImage := BytesPerScanLine(biWidth, biBitCount, 32) * Abs(biHeight);
        if biSizeImage < ImageSize then ImageSize := biSizeImage;
      end;
      DC := GetDC(0);
      try
        begin
          BMHandle := CreateDIBSection(DC, BitmapInfo^, DIB_RGB_COLORS, BitsMem, 0, 0);
          try
            Stream.ReadBuffer(BitsMem^, ImageSize);
          except
            DeleteObject(BMHandle);
            raise;
          end;
        end;
      finally
        ReleaseDC(0, DC);
      end;
      // Hi-color DIBs don't preserve color table, so create palette now
      if (bmiHeader.biBitCount > 8) and (bmiHeader.biClrUsed > 0) and (Pal = 0) then
        Pal := PaletteFromDIBColorTable(0, ColorTable, bmiHeader.biClrUsed);
      FillChar(DIB, sizeof(DIB), 0);
      GetObject(BMHandle, Sizeof(DIB), @DIB);
      // GetObject / CreateDIBSection don't preserve these info values
      DIB.dsBmih.biXPelsPerMeter := bmiHeader.biXPelsPerMeter;
      DIB.dsBmih.biYPelsPerMeter := bmiHeader.biYPelsPerMeter;
      DIB.dsBmih.biClrUsed := bmiHeader.biClrUsed;
      DIB.dsBmih.biClrImportant := bmiHeader.biClrImportant;
    except
      raise;
    end;
  finally
    FreeMem(BitmapInfo);
  end;
  NewImage(BMHandle, Pal, DIB);
end;

procedure TBitmap.ReadStream(Stream: TStream; Size: Longint);
var
  Bmf: TBitmapFileHeader;
  DIB: TDIBSection;
begin
  FreeContext;
  if Size = 0 then
  begin
    FillChar(DIB, sizeof(DIB), 0);
    NewImage(0, 0, DIB);
  end
  else
  begin
    Stream.ReadBuffer(Bmf, sizeof(Bmf));
    ReadDIB(Stream, Size - sizeof(Bmf), @Bmf);
  end;
end;

procedure TBitmap.SetHandle(Value: HBITMAP);
var
  DIB: TDIBSection;
  APalette: HPALETTE;
begin
  with FImage do
    if FHandle <> Value then
    begin
      FreeContext;
      FillChar(DIB, sizeof(DIB), 0);
      if Value <> 0 then GetObject(Value, SizeOf(DIB), @DIB);
      if FPalette = SystemPalette16 then
        APalette := SystemPalette16
      else
        APalette := CopyPalette(FPalette);
      try
        NewImage(Value, APalette, DIB);
      except
        InternalDeletePalette(APalette);
        raise;
      end;
    end;
end;

procedure TBitmap.SetHandleType(Value: TBitmapHandleType);
var
  DIB: TDIBSection;
  AHandle: HBITMAP;
  NewPalette: HPALETTE;
  DoCopy: Boolean;
begin
  if Value = GetHandleType then Exit;
  with FImage do
  begin
    if (FHandle = 0) and (FDIBHandle = 0) then
      if Value = bmDDB then
        FDIB.dsbmih.biSize := 0
      else
        FDIB.dsbmih.biSize := sizeof(FDIB.dsbmih)
    else
    begin
      if Value = bmDIB then
      begin
        if (FDIBHandle <> 0) and (FDIBHandle = FHandle) then Exit;
        FreeContext;
        DIBNeeded;
        CopyImage(FDIBHandle, FPalette, FDIB);
      end
      else
      begin
        if (FHandle <> 0) and (FHandle <> FDIBHandle) then Exit;
        FreeContext;
        DIB := FDIB;
        DIB.dsbmih.biSize := 0; // flag to tell CopyBitmap to create a DDB
        if DoCopy then
          NewPalette := FPalette
        else
          NewPalette := CopyPalette(FPalette);
        AHandle := CopyBitmap(FDIBHandle, FPalette, NewPalette, DIB, nil);
        if DoCopy then
          FHandle := AHandle
        else
          NewImage(AHandle, NewPalette, DIB);
      end;
    end;
  end;
end;

procedure TBitmap.SetHeight(Value: Integer);
var
  DIB: TDIBSection;
begin
  with FImage do
    if FDIB.dsbm.bmHeight <> Value then
    begin
      HandleNeeded;
      DIB := FDIB;
      DIB.dsbm.bmHeight := Value;
      DIB.dsbmih.biHeight := Value;
      CopyImage(FHandle, FPalette, DIB);
    end;
end;

procedure TBitmap.SetMaskHandle(Value: HBITMAP);
begin
  with FImage do
    if FMaskHandle <> Value then
    begin
      FMaskHandle := Value;
      FMaskValid := True;
      FMaskBitsValid := True;
    end;
end;

procedure TBitmap.SetPalette(Value: HPALETTE);
var
  AHandle: HBITMAP;
  DIB: TDIBSection;
begin
  if FImage.FPalette <> Value then
  begin
    with FImage do
      if (Value = 0) then
      begin
        InternalDeletePalette(FPalette);
        FPalette := 0;
      end
      else
      begin
        FreeContext;
        HandleNeeded;
        DIB := FDIB;
        AHandle := CopyBitmap(FHandle, FPalette, Value, DIB, nil);
        try
          NewImage(AHandle, Value, DIB);
        except
          DeleteObject(AHandle);
          raise;
        end;
      end;
    UpdateDIBColorTable(FImage.FDIBHandle, Value, FImage.FDIB);
  end;
end;

procedure TBitmap.SetPixelFormat(Value: TPixelFormat);
const
  BitCounts: array[pf1Bit..pf32Bit] of Byte = (1, 4, 8, 16, 16, 24, 32);
var
  DIB: TDIBSection;
  Pal: HPalette;
  DC: HDC;
  KillPal: Boolean;
begin
  if Value = GetPixelFormat then Exit;
  case Value of
    pfDevice:
      begin
        HandleType := bmDDB;
        Exit;
      end;
  else
    FillChar(DIB, sizeof(DIB), 0);
    DIB.dsbm := FImage.FDIB.dsbm;
    KillPal := False;
    with DIB, dsbm, dsbmih do
    begin
      bmBits := nil;
      biSize := sizeof(DIB.dsbmih);
      biWidth := bmWidth;
      biHeight := bmHeight;
      biPlanes := 1;
      biBitCount := BitCounts[Value];
      Pal := FImage.FPalette;
      case Value of
        pf4Bit: Pal := SystemPalette16;
        pf8Bit:
          begin
            DC := GetDC(0);
            Pal := CreateHalftonePalette(DC);
            KillPal := True;
            ReleaseDC(0, DC);
          end;
        pf16Bit:
          begin
            biCompression := BI_BITFIELDS;
            dsBitFields[0] := $F800;
            dsBitFields[1] := $07E0;
            dsBitFields[2] := $001F;
          end;
      end;
      try
        CopyImage(Handle, Pal, DIB);
      finally
        if KillPal then DeleteObject(Pal);
      end;
    end;
  end;
end;

procedure TBitmap.SetWidth(Value: Integer);
var
  DIB: TDIBSection;
begin
  with FImage do
    if FDIB.dsbm.bmWidth <> Value then
    begin
      HandleNeeded;
      DIB := FDIB;
      DIB.dsbm.bmWidth := Value;
      DIB.dsbmih.biWidth := Value;
      CopyImage(FHandle, FPalette, DIB);
    end;
end;

procedure TBitmap.WriteStream(Stream: TStream; WriteSize: Boolean);
const
  PalSize: array[Boolean] of Byte = (sizeof(TRGBQuad), sizeof(TRGBTriple));
var
  Size, ColorCount: DWORD;
  HeaderSize: DWORD;
  BMF: TBitmapFileHeader;
  Save: THandle;
  Colors: array[Byte] of TRGBQuad;
begin
  DIBNeeded;
  with FImage do
  begin
    Size := 0;
    if FDIBHandle <> 0 then
    begin
      InternalGetDIBSizes(FDIBHandle, HeaderSize, Size, FDIB.dsbmih.biClrUsed);
      Inc(Size, HeaderSize + sizeof(BMF));
      FillChar(BMF, sizeof(BMF), 0);
      BMF.bfType := $4D42;
      Canvas.RequiredState([csHandleValid]);
      Save := SelectObject(FCanvas.FHandle, FDIBHandle);
      ColorCount := GetDIBColorTable(FCanvas.FHandle, 0, 256, Colors);
      SelectObject(FCanvas.FHandle, Save);
      // GetDIBColorTable always reports the full palette; trim it back for partial palettes
      if (0 < FDIB.dsbmih.biClrUsed) and (FDIB.dsbmih.biClrUsed < ColorCount) then
        ColorCount := FDIB.dsbmih.biClrUsed;
      if (ColorCount = 0) and (FPalette <> 0) and not FHalftone then
      begin
        ColorCount := PaletteToDIBColorTable(FPalette, Colors);
        if FDIB.dsbmih.biBitCount > 8 then
        begin // optional color palette for hicolor images (non OS2)
          Inc(Size, ColorCount * sizeof(TRGBQuad));
          Inc(HeaderSize, ColorCount * sizeof(TRGBQuad));
        end;
      end;
      BMF.bfSize := Size;
      BMF.bfOffBits := sizeof(BMF) + HeaderSize;
    end;
    if WriteSize then Stream.WriteBuffer(Size, SizeOf(Size));
    if Size <> 0 then
    begin
      FixupBitFields(FDIB);
      if (ColorCount <> 0) then
      begin
        if (FDIB.dsbmih.biClrUsed = 0) or (FDIB.dsbmih.biClrUsed <> ColorCount) then
          FDIB.dsbmih.biClrUsed := ColorCount;
      end;
      Stream.WriteBuffer(BMF, Sizeof(BMF));
      Stream.WriteBuffer(FDIB.dsbmih, Sizeof(FDIB.dsbmih));
      if (FDIB.dsbmih.biBitCount > 8) and ((FDIB.dsbmih.biCompression and BI_BITFIELDS) <> 0) then
        Stream.WriteBuffer(FDIB.dsBitfields, 12);
      Stream.WriteBuffer(Colors, ColorCount * PalSize[False]);
      Stream.WriteBuffer(FDIB.dsbm.bmBits^, FDIB.dsbmih.biSizeImage);
    end;
  end;
end;

{ ReleaseHandle gives up ownership of the bitmap handle the TBitmap contains. }
function TBitmap.ReleaseHandle: HBITMAP;
begin
  HandleNeeded;
  with FImage do
  begin
    Result := FHandle;
    if FHandle = FDIBHandle then
    begin
      FDIBHandle := 0;
      FDIB.dsbm.bmBits := nil;
    end;
    FHandle := 0;
  end;
end;

function TBitmap.ReleaseMaskHandle: HBITMAP;
begin
  Result := GetMaskHandle;
  FImage.FMaskHandle := 0;
end;

function TBitmap.ReleasePalette: HPALETTE;
begin
  HandleNeeded;
  Result := FImage.FPalette;
  FImage.FPalette := 0;
end;

procedure TBitmap.SaveToStream(Stream: TStream);
begin
  WriteStream(Stream, False);
end;

procedure InitScreenLogPixels;
const
  Pal16: array[0..15] of TColor =
  (clBlack, clMaroon, clGreen, clOlive, clNavy, clPurple, clTeal, clDkGray,
    clLtGray, clRed, clLime, clYellow, clBlue, clFuchsia, clAqua, clWhite);
var
  DC: HDC;
begin
  DC := GetDC(0);
  ScreenLogPixels := GetDeviceCaps(DC, LOGPIXELSY);
  ReleaseDC(0, DC);
  SystemPalette16 := CreateSystemPalette(Pal16);
end;

initialization
  InitScreenLogPixels;
  InitializeCriticalSection(BitmapImageLock);
  InitializeCriticalSection(CounterLock);
  StockPen := GetStockObject(BLACK_PEN);
  StockBrush := GetStockObject(HOLLOW_BRUSH);
  StockFont := GetStockObject(SYSTEM_FONT);
  BitmapCanvasList := TThreadList.Create;
  CanvasList := TThreadList.Create;
finalization
  BitmapCanvasList.Free;
  CanvasList.Free;
  DeleteObject(SystemPalette16);
  DeleteCriticalSection(BitmapImageLock);
  DeleteCriticalSection(CounterLock);
end.