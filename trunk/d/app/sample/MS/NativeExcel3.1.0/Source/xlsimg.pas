//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsimg
//
//
//      Description:  Image processing
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

unit xlsimg;
{$Q-}
{$R-}
interface
{$I xlsdef.inc}

uses 
  {$IFDEF D2012}
    Vcl.Graphics;
  {$ELSE}
    Graphics;    // -----> GC
  {$ENDIF}

function GetImageSize(Const AFileName: WideString; Var AWidth, AHeight: double): integer;
function GetBmpSizeStream(Bitmap:Tbitmap; Var AWidth, AHeight: double): integer;   // -----> GC
implementation

uses 
  {$IFDEF D2012}
    System.SysUtils, System.classes, 
  {$ELSE}
    SysUtils, Classes,
  {$ENDIF}
  wstream;

{function GetJpegSize2(Const AFileName: String; Var AWidth, AHeight: double): integer;
Var Img: TJpegImage;
begin
  Result := 1;
  Img := TJpegImage.Create;
  try
    try 
      Img.LoadFromFile(AFileName);
    
      AWidth := Img.Width * 0.75;
      AHeight := Img.Height * 0.75;
     
    except
      Result := -1;
    end;
  finally
    Img.Free;
  end;
end;}

function swapbyte(W: word): word;
begin
  Result := ((W and $00FF) shl 8) or ((W and $FF00) shr 8);
end;

function lswapbyte(L: longword): longword;
begin
  Result := (swapbyte(L and $FFFF) shl 16) or
            (swapbyte((L and $FFFF0000) shr 16));
end;

function GetJpegSize(Const AFileName: WideString; Var AWidth, AHeight: double): integer;
//procedure GetJPGSize(const sFile: string; var wWidth, wHeight: word);
const
  ValidSig : array[0..1] of byte = ($FF, $D8);
  Parameterless = [$01, $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7];
var
  Sig: array[0..1] of byte;
  f: TWFileStream;
  x: integer;
  Seg: byte;
  Dummy: array[0..15] of byte;
  Len: word;
  ReadLen: LongInt;
  wWidth, wHeight: Word;
begin
  Result := 1;

  FillChar(Sig, SizeOf(Sig), #0);
  f := TWFileStream.Create(AFileName, fmOpenRead);

  try
    ReadLen := f.Read(Sig[0], SizeOf(Sig));

    for x := Low(Sig) to High(Sig) do begin
      if Sig[x] <> ValidSig[x] then ReadLen := 0;
    end;

    if ReadLen > 0 then begin

      ReadLen := f.Read(Seg, 1);
      while (Seg = $FF) and (ReadLen > 0) do begin
        ReadLen := f.Read(Seg, 1);
        if Seg <> $FF then begin
          if (Seg = $C0) or (Seg = $C1) or (Seg = $C2) then begin
            ReadLen := f.Read(Dummy[0], 3); { don't need these bytes }
            ReadLen := f.Read(wHeight, 2);
            wHeight := swapbyte(wHeight);
            ReadLen := f.Read(wWidth, 2);
            wWidth := swapbyte(wWidth);
          end else begin
            if not (Seg in Parameterless) then begin
              ReadLen := f.Read(Len, 2); Len := swapbyte(Len);
              f.Seek(Len - 2, 1);
              ReadLen := f.Read(Seg, 1);
            end else begin
              Seg := $FF; { Fake it to keep looping. }
            end;
          end;
        end;
      end;
    end;
  finally
    f.Free;
  end;
  if ReadLen <= 0 then Result := -1;
  AWidth  := wWidth * 0.75;
  AHeight := wHeight * 0.75;
end;


function GetPngSize(Const AFileName: WideString; Var AWidth, AHeight: Double):  integer;
var   
  f: TWFileStream;
  lWidth, lHeight: Longword;
  ReadLen: LongInt;
begin
  Result := 1;
  f := TWFileStream.Create(AFileName, fmOpenRead);
  try
    f.seek(16, soFromCurrent);
    ReadLen := f.Read(lWidth,  4);
    lWidth := lswapbyte(lWidth);
    if ReadLen <> 4 then Result := -1;
    if Result = 1 then begin
       ReadLen := f.Read(lHeight, 4);
       lHeight := lswapbyte(lHeight);
       if ReadLen <> 4 then Result := -1;
    end;
  finally
    f.Free;
  end;
  
  if Result = 1 then begin
    AWidth  := lWidth * 0.75;
    AHeight := lHeight * 0.75;
  end else begin
    AWidth := 100;
    AHeight := 100;
  end;
end;

function GetGifSize(Const AFileName: WideString; Var AWidth, AHeight: Double):  integer;
begin
  AWidth := 100;
  AHeight := 100;
  Result := 1;
end;

function GetBmpSize(Const AFileName: WideString; Var AWidth, AHeight: Double):  integer;
var   
  f: TWFileStream;
  lWidth, lHeight: Longword;
  ReadLen: LongInt;
begin
  Result := 1;
  f := TWFileStream.Create(AFileName, fmOpenRead);
  try
    f.seek(14 + 4, soFromCurrent);
    ReadLen := f.Read(lWidth,  4);
    if ReadLen <> 4 then Result := -1;
    if Result = 1 then begin
       ReadLen := f.Read(lHeight, 4);
       if ReadLen <> 4 then Result := -1;
    end;
  finally
    f.Free;
  end;
  
  if Result = 1 then begin
    AWidth := lWidth * 0.75;
    AHeight := lHeight * 0.75;
  end else begin
    AWidth := 100;
    AHeight := 100;
  end;
end;

   // -----> GC  31/01/2006   -  Gamma Computer snc Settino T. Italy
function GetBmpSizeStream(BitMap:Tbitmap; Var AWidth, AHeight: Double):  integer;
var
  f: TMemoryStream;
  lWidth, lHeight: Longword;
  ReadLen: LongInt;
begin
f:=TmemoryStream.Create;
  Result := 1;
  Bitmap.SaveToStream(f);
  f.position:=0;
  try
    f.seek(14 + 4, soFromCurrent);
    ReadLen := f.Read(lWidth,  4);
    if ReadLen <> 4 then Result := -1;
    if Result = 1 then begin
       ReadLen := f.Read(lHeight, 4);
       if ReadLen <> 4 then Result := -1;
    end;
  finally
    f.Free;
  end;
  if Result = 1 then begin
    AWidth := ((BitMap.Width )* 0.75);   //   BitMap.Width; //
    AHeight :=((BitMap.Height )* 0.75) ; //     BitMap.Height; //
  end else begin
    AWidth := 100;
    AHeight := 100;
  end;
end;

function GetWmfEmfSize(Const AFileName: WideString; Var AWidth, AHeight: Double):  integer;
begin
  Result := 7;
end;


function GetImageSize(Const AFileName: WideString; Var AWidth, AHeight: double): integer;
Var Ext: String;
begin
  Ext := Lowercase(Copy(ExtractFileExt(AFileName), 2, 5));

  if (Ext = 'jpeg') or (Ext = 'jpg') then begin
     Result := GetJpegSize(AFileName, AWidth, AHeight);
  end else if (Ext = 'bmp') then begin
     Result := GetBmpSize(AFileName, AWidth, AHeight);
  end else if (Ext = 'gif') then begin
     Result := GetGifSize(AFileName, AWidth, AHeight);
  end else if (Ext = 'png') then begin
     Result := GetPngSize(AFileName, AWidth, AHeight);
  end else if (Ext = 'wmf') then begin                        // -----> GC
     Result := GetWmfEmfSize(AFileName, AWidth, AHeight);     // -----> GC
  end else if (Ext = 'emf') then begin                        // -----> GC
     Result := GetWmfEmfSize(AFileName, AWidth, AHeight);     // -----> GC

  end else begin
     Result := -1;
  end;
end;

end.
	