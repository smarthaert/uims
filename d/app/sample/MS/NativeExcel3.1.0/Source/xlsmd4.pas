//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsmd4
//       
//      Description: MD4 hash 
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

unit xlsmd4;

{$Q-}
{$R-}

interface

type

  TMD4Hash = class
  private
    FHash: array[0..3] of LongWord;
    LenHi: Longword;
    LenLo: Longword;
    Index: LongWord;
    Buffer: array[0..63] of Byte;
  public
    procedure Init();
    procedure Update(const Data; DataSize: LongWord);
    procedure Transform();
    procedure MDFinal(var Digest); 
  end;


implementation

type
  PLongword = ^Longword;

const
  S11 = 3;
  S12 = 7;
  S13 = 11;
  S14 = 19;
  S21 = 3;
  S22 = 5;
  S23 = 9;
  S24 = 13;
  S31 = 3;
  S32 = 9;
  S33 = 11;
  S34 = 15;

function rol(x: LongWord; y: Byte): LongWord;
begin
  Result := (x shl y) or (x shr (32 - y));
end;

function F(x, y, z: LongWord): LongWord;
begin
  Result := ((x and y) or ((not x) and (z)))
end;

function G(x, y, z: LongWord): LongWord; 
begin
  Result := (x and y) or (x and z) or (y and z);
end;

function H(x, y, z: LongWord): LongWord;
begin
  Result := x xor y xor z;
end;

procedure FF(var a: LongWord; b, c, d, x, s: LongWord);
begin
  a := a + (F(b, c, d) + x);
  a := rol(a, s);
end;

procedure GG(var a: LongWord; b, c, d, x, s: LongWord);
begin
  a := a + G(b, c, d) + x + $5a827999;
  a := rol(a, s);
end;

procedure HH(var a: LongWord; b, c, d, x, s: LongWord);
begin
  a := a + H(b, c, d) + x + $6ed9eba1;
  a := rol(a, s);
end;

procedure TMD4Hash.Init();
begin

  LenLo    := 0;
  LenHi    := 0;
  Index    := 0;

  FHash[0] := $67452301;
  FHash[1] := $efcdab89;
  FHash[2] := $98badcfe;
  FHash[3] := $10325476;

  FillChar(Buffer, Sizeof(Buffer), 0);

end;

procedure TMD4Hash.Transform();
var
  a, b, c, d: LongWord;
  x: array[0..15] of LongWord;
begin

  a := FHash[0]; 
  b := FHash[1]; 
  c := FHash[2]; 
  d := FHash[3];

  Move(Buffer, x, Sizeof(x));

  FF (a, b, c, d, x[ 0], S11); //* 1 */
  FF (d, a, b, c, x[ 1], S12); //* 2 */
  FF (c, d, a, b, x[ 2], S13); //* 3 */
  FF (b, c, d, a, x[ 3], S14); //* 4 */
  FF (a, b, c, d, x[ 4], S11); //* 5 */
  FF (d, a, b, c, x[ 5], S12); //* 6 */
  FF (c, d, a, b, x[ 6], S13); //* 7 */
  FF (b, c, d, a, x[ 7], S14); //* 8 */
  FF (a, b, c, d, x[ 8], S11); //* 9 */
  FF (d, a, b, c, x[ 9], S12); //* 10 */
  FF (c, d, a, b, x[10], S13); //* 11 */
  FF (b, c, d, a, x[11], S14); //* 12 */
  FF (a, b, c, d, x[12], S11); //* 13 */
  FF (d, a, b, c, x[13], S12); //* 14 */
  FF (c, d, a, b, x[14], S13); //* 15 */
  FF (b, c, d, a, x[15], S14); //* 16 */

  //* Round 2 */
  GG (a, b, c, d, x[ 0], S21); //* 17 */
  GG (d, a, b, c, x[ 4], S22); //* 18 */
  GG (c, d, a, b, x[ 8], S23); //* 19 */
  GG (b, c, d, a, x[12], S24); //* 20 */
  GG (a, b, c, d, x[ 1], S21); //* 21 */
  GG (d, a, b, c, x[ 5], S22); //* 22 */
  GG (c, d, a, b, x[ 9], S23); //* 23 */
  GG (b, c, d, a, x[13], S24); //* 24 */
  GG (a, b, c, d, x[ 2], S21); //* 25 */
  GG (d, a, b, c, x[ 6], S22); //* 26 */
  GG (c, d, a, b, x[10], S23); //* 27 */
  GG (b, c, d, a, x[14], S24); //* 28 */
  GG (a, b, c, d, x[ 3], S21); //* 29 */
  GG (d, a, b, c, x[ 7], S22); //* 30 */
  GG (c, d, a, b, x[11], S23); //* 31 */
  GG (b, c, d, a, x[15], S24); //* 32 */

  //* Round 3 */
  HH (a, b, c, d, x[ 0], S31); //* 33 */
  HH (d, a, b, c, x[ 8], S32); //* 34 */
  HH (c, d, a, b, x[ 4], S33); //* 35 */
  HH (b, c, d, a, x[12], S34); //* 36 */
  HH (a, b, c, d, x[ 2], S31); //* 37 */
  HH (d, a, b, c, x[10], S32); //* 38 */
  HH (c, d, a, b, x[ 6], S33); //* 39 */
  HH (b, c, d, a, x[14], S34); //* 40 */
  HH (a, b, c, d, x[ 1], S31); //* 41 */
  HH (d, a, b, c, x[ 9], S32); //* 42 */
  HH (c, d, a, b, x[ 5], S33); //* 43 */
  HH (b, c, d, a, x[13], S34); //* 44 */
  HH (a, b, c, d, x[ 3], S31); //* 45 */
  HH (d, a, b, c, x[11], S32); //* 46 */
  HH (c, d, a, b, x[ 7], S33); //* 47 */
  HH (b, c, d, a, x[15], S34); //* 48 */

  //State updates
  FHash[0] := FHash[0] + a;
  FHash[1] := FHash[1] + b;
  FHash[2] := FHash[2] + c;
  FHash[3] := FHash[3] + d;

  Index := 0;

  FillChar(Buffer, Sizeof(Buffer), 0);

end;

procedure TMD4Hash.Update(const Data; DataSize: LongWord);
var
  PData: ^byte;
  PartLen: LongWord;
begin
  //* Update number of bits */
  LenLo := LenLo + DataSize shl 3;
  if (LenLo < (DataSize shl 3)) then Inc(LenHi);
  LenHi := LenHi + DataSize shr 29;

  PData := @Data;
  while DataSize > 0 do begin
    PartLen := SizeOf(Buffer) - Index;
    if PartLen <= DataSize then begin
       Move(PData^, Buffer[Index], PartLen);
       DataSize := DataSize - PartLen;
       Inc(PData, PartLen);
       Transform();
    end else begin
       Move(PData^, Buffer[Index], DataSize);
       Index := Index + DataSize;
       DataSize := 0;
    end;
  end;
end;

procedure TMD4Hash.MDFinal(var Digest);
begin
  Buffer[Index] := $80;

  if Index >= (Sizeof(Buffer) - 8) then begin
     Inc(Index);
     FillChar(Buffer[Index], Sizeof(Buffer) - Index, 0);
     Transform();
  end;

  PLongword(@Buffer[Sizeof(Buffer) - 8])^:= LenLo;
  PLongword(@Buffer[Sizeof(Buffer) - 4])^:= LenHi;
  Transform();

  Move(FHash, Digest, Sizeof(FHash));
end;


end.
