//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsmd5
//       
//      Description:  An implmentation for the MD5 Message-Digest Algorithm (RFC-1321)
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

unit xlsmd5;

{$Q-}
{$R-}

interface

const
  SizeOfByteBuffer = 64;
  SizeOfLongBuffer = SizeOfByteBuffer div 4;
type

  TMD5Hash = class
  private
    FHash: array[0..3] of LongWord;
    LenHi: Longword;
    LenLo: Longword;
    Buffer: array[0..SizeOfByteBuffer - 1] of Byte;
    function GetDigest: Pointer;
  public
    procedure Init();
    procedure Update(const Data; DataSize: LongWord);
    procedure Transform();
    procedure MDFinal(var Digest); 
    procedure Store(var Digest);
    procedure CalcHash(const Data; DataSize: LongWord; var Digest);
    property Digest: Pointer read GetDigest;
  end;

  procedure MD5CalcHash(const Data; DataSize: LongWord; var Digest);

implementation

type
  PLongword = ^Longword;

function rol(x: LongWord; y: Byte): LongWord;
begin
  Result := (x shl y) or (x shr (32 - y));
end;

procedure Round1(var a: LongWord; b, c, d, data: LongWord; s: byte);
begin
   a := a + (d xor (b and (c xor d))) + data;
   a := rol(a, s) + b;
end;

procedure Round2(var a: LongWord; b, c, d, data: LongWord; s: byte);
begin
   a := a + (c xor (d and (b xor c))) + data;
   a := rol(a, s) + b;
end;

procedure Round3(var a: LongWord; b, c, d, data: LongWord; s: byte);
begin
   a := a + (b xor c xor d) + data;
   a := rol(a, s) + b;
end;

procedure Round4(var a: LongWord; b, c, d, data: LongWord; s: byte);
begin
   a := a + (c xor (b or not d)) + data;
   a := rol(a, s) + b;
end;

{
procedure Dump(const Data; size: integer);
type 
    tbarr = array[0..0] of byte; 
    pbarr = ^tbarr;
Var i, cnt: LongWord;
    c: Byte;
    cc: Byte;
    arr: pbarr;
begin
   system.writ eln;
   cnt := size;
   c := 0;
   cc:= 0;
   system.write('               ');
   arr := pbarr(@Data);
   for i:= 0 to cnt - 1 do begin
      system.write(inttohex(arr^[i], 2), ' ');
      if c = 3 then begin
         system.writ e(' ');
         c := 0;
         if (cc = 3) and (i < (cnt - 1))then begin
            system.writ eln;
            system.writ e('               ');
            cc := 0;
         end
         else Inc(cc);
      end
      else Inc(c);
   end;
end;
}

procedure TMD5Hash.Init();
begin
  LenLo    := 0;
  LenHi    := 0;

  FHash[0] := $67452301;
  FHash[1] := $efcdab89;
  FHash[2] := $98badcfe;
  FHash[3] := $10325476;

  FillChar(Buffer, SizeOfByteBuffer, 0);
end;

procedure TMD5Hash.Transform();
var
  a, b, c, d: LongWord;
  x: array[0..(SizeOfLongBuffer - 1)] of LongWord;
begin

  a := FHash[0]; 
  b := FHash[1]; 
  c := FHash[2]; 
  d := FHash[3];

  Move(Buffer, x, SizeOfByteBuffer);
  
  //Round 1
  Round1 (a, b, c, d, x[ 0] + LongWord($d76aa478),  7); //* 1 */
  Round1 (d, a, b, c, x[ 1] + LongWord($e8c7b756), 12); //* 2 */
  Round1 (c, d, a, b, x[ 2] + LongWord($242070db), 17); //* 3 */
  Round1 (b, c, d, a, x[ 3] + LongWord($c1bdceee), 22); //* 4 */
  Round1 (a, b, c, d, x[ 4] + LongWord($f57c0faf),  7); //* 5 */
  Round1 (d, a, b, c, x[ 5] + LongWord($4787c62a), 12); //* 6 */
  Round1 (c, d, a, b, x[ 6] + LongWord($a8304613), 17); //* 7 */
  Round1 (b, c, d, a, x[ 7] + LongWord($fd469501), 22); //* 8 */
  Round1 (a, b, c, d, x[ 8] + LongWord($698098d8),  7); //* 9 */
  Round1 (d, a, b, c, x[ 9] + LongWord($8b44f7af), 12); //* 10 */
  Round1 (c, d, a, b, x[10] + LongWord($ffff5bb1), 17); //* 11 */
  Round1 (b, c, d, a, x[11] + LongWord($895cd7be), 22); //* 12 */
  Round1 (a, b, c, d, x[12] + LongWord($6b901122),  7); //* 13 */
  Round1 (d, a, b, c, x[13] + LongWord($fd987193), 12); //* 14 */
  Round1 (c, d, a, b, x[14] + LongWord($a679438e), 17); //* 15 */
  Round1 (b, c, d, a, x[15] + LongWord($49b40821), 22); //* 16 */

  //* Round 2 */
  Round2 (a, b, c, d, x[ 1] + LongWord($f61e2562),  5); //* 17 */
  Round2 (d, a, b, c, x[ 6] + LongWord($c040b340),  9); //* 18 */
  Round2 (c, d, a, b, x[11] + LongWord($265e5a51), 14); //* 19 */
  Round2 (b, c, d, a, x[ 0] + LongWord($e9b6c7aa), 20); //* 20 */
  Round2 (a, b, c, d, x[ 5] + LongWord($d62f105d),  5); //* 21 */
  Round2 (d, a, b, c, x[10] + LongWord($02441453),  9); //* 22 */
  Round2 (c, d, a, b, x[15] + LongWord($d8a1e681), 14); //* 23 */
  Round2 (b, c, d, a, x[ 4] + LongWord($e7d3fbc8), 20); //* 24 */
  Round2 (a, b, c, d, x[ 9] + LongWord($21e1cde6),  5); //* 25 */
  Round2 (d, a, b, c, x[14] + LongWord($c33707d6),  9); //* 26 */
  Round2 (c, d, a, b, x[ 3] + LongWord($f4d50d87), 14); //* 27 */
  Round2 (b, c, d, a, x[ 8] + LongWord($455a14ed), 20); //* 28 */
  Round2 (a, b, c, d, x[13] + LongWord($a9e3e905),  5); //* 29 */
  Round2 (d, a, b, c, x[ 2] + LongWord($fcefa3f8),  9); //* 30 */
  Round2 (c, d, a, b, x[ 7] + LongWord($676f02d9), 14); //* 31 */
  Round2 (b, c, d, a, x[12] + LongWord($8d2a4c8a), 20); //* 32 */

  //* Round 3 */
  Round3 (a, b, c, d, x[ 5] + LongWord($fffa3942),  4); //* 33 */
  Round3 (d, a, b, c, x[ 8] + LongWord($8771f681), 11); //* 34 */
  Round3 (c, d, a, b, x[11] + LongWord($6d9d6122), 16); //* 35 */
  Round3 (b, c, d, a, x[14] + LongWord($fde5380c), 23); //* 36 */
  Round3 (a, b, c, d, x[ 1] + LongWord($a4beea44),  4); //* 37 */
  Round3 (d, a, b, c, x[ 4] + LongWord($4bdecfa9), 11); //* 38 */
  Round3 (c, d, a, b, x[ 7] + LongWord($f6bb4b60), 16); //* 39 */
  Round3 (b, c, d, a, x[10] + LongWord($bebfbc70), 23); //* 40 */
  Round3 (a, b, c, d, x[13] + LongWord($289b7ec6),  4); //* 41 */
  Round3 (d, a, b, c, x[ 0] + LongWord($eaa127fa), 11); //* 42 */
  Round3 (c, d, a, b, x[ 3] + LongWord($d4ef3085), 16); //* 43 */
  Round3 (b, c, d, a, x[ 6] + LongWord($04881d05), 23); //* 44 */
  Round3 (a, b, c, d, x[ 9] + LongWord($d9d4d039),  4); //* 45 */
  Round3 (d, a, b, c, x[12] + LongWord($e6db99e5), 11); //* 46 */
  Round3 (c, d, a, b, x[15] + LongWord($1fa27cf8), 16); //* 47 */
  Round3 (b, c, d, a, x[ 2] + LongWord($c4ac5665), 23); //* 48 */

  //* Round 4 */
  Round4 (a, b, c, d, x[ 0] + LongWord($f4292244),  6); //* 49 */
  Round4 (d, a, b, c, x[ 7] + LongWord($432aff97), 10); //* 50 */
  Round4 (c, d, a, b, x[14] + LongWord($ab9423a7), 15); //* 51 */
  Round4 (b, c, d, a, x[ 5] + LongWord($fc93a039), 21); //* 52 */
  Round4 (a, b, c, d, x[12] + LongWord($655b59c3),  6); //* 53 */
  Round4 (d, a, b, c, x[ 3] + LongWord($8f0ccc92), 10); //* 54 */
  Round4 (c, d, a, b, x[10] + LongWord($ffeff47d), 15); //* 55 */
  Round4 (b, c, d, a, x[ 1] + LongWord($85845dd1), 21); //* 56 */
  Round4 (a, b, c, d, x[ 8] + LongWord($6fa87e4f),  6); //* 57 */
  Round4 (d, a, b, c, x[15] + LongWord($fe2ce6e0), 10); //* 58 */
  Round4 (c, d, a, b, x[ 6] + LongWord($a3014314), 15); //* 59 */
  Round4 (b, c, d, a, x[13] + LongWord($4e0811a1), 21); //* 60 */
  Round4 (a, b, c, d, x[ 4] + LongWord($f7537e82),  6); //* 61 */
  Round4 (d, a, b, c, x[11] + LongWord($bd3af235), 10); //* 62 */
  Round4 (c, d, a, b, x[ 2] + LongWord($2ad7d2bb), 15); //* 63 */
  Round4 (b, c, d, a, x[ 9] + LongWord($eb86d391), 21); //* 64 */

  //State updates
  FHash[0] := FHash[0] + a;
  FHash[1] := FHash[1] + b;
  FHash[2] := FHash[2] + c;
  FHash[3] := FHash[3] + d;

//  FillChar(Buffer, Sizeof(Buffer), 0);

end;

procedure TMD5Hash.Update(const Data; DataSize: LongWord);
var
  PData: ^byte;
  PartLen: LongWord;
  T: LongWord; 
  Index: Word; 
begin
  //* Update number of bits */
  T := LenLo;
  LenLo := LenLo + DataSize shl 3;
  if (LenLo < T) then Inc(LenHi);
  LenHi := LenHi + DataSize shr 29;

  Index := (T shr 3) and (SizeOfByteBuffer - 1);
  PData := @Data;

  while DataSize > 0 do begin
    PartLen := SizeOfByteBuffer - Index;
    if PartLen <= DataSize then begin
       Move(PData^, Buffer[Index], PartLen);
       DataSize := DataSize - PartLen;
       Inc(PData, PartLen);
       Transform();
       Index := 0;
    end else begin
       Move(PData^, Buffer[Index], DataSize);
       Index := Index + DataSize;
       DataSize := 0;
    end;
  end;
end;


procedure TMD5Hash.MDFinal(var Digest);
Var Index: Word;
begin
  
  Index := (LenLo shr 3) and (SizeOfByteBuffer - 1);
  Buffer[Index] := $80;

  Inc(Index);
  if Index > (SizeOfByteBuffer - 8) then begin
     FillChar(Buffer[Index], SizeOfByteBuffer - Index, #0);
     Transform();
     FillChar(Buffer, SizeOfByteBuffer - 8, #0);
  end else begin
     FillChar(Buffer[Index], SizeOfByteBuffer - Index - 8, #0);
  end;

  PLongword(@Buffer[SizeOfByteBuffer - 8])^:= LenLo;
  PLongword(@Buffer[SizeOfByteBuffer - 4])^:= LenHi;

  Transform();

  Move(FHash, Digest, SizeOf(FHash));

end;

procedure TMD5Hash.Store(var Digest);
begin
  Move(FHash, Digest, SizeOf(FHash));
end;

procedure TMD5Hash.CalcHash(const Data; DataSize: LongWord; var Digest);
begin
   Init();
   Update(Data, DataSize);
   Store(Digest);
end;

function TMD5Hash.GetDigest: Pointer;
begin
   Result := @FHash;
end;


procedure MD5CalcHash(const Data; DataSize: LongWord; var Digest);
var md5: TMD5Hash;
begin
   md5 := TMD5Hash.Create;
   try
     md5.CalcHash(Data, DataSize, Digest);
   finally
     md5.Free;
   end;
end;


end.
