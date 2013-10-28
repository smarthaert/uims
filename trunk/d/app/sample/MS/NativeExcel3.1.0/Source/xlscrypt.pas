//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsCrypt
//       
//      Description:  Decrypt service 
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

unit xlscrypt;

{$Q-}
{$R-}

{$I xlsdef.inc}

interface


uses xlsblob, xlsmd5, xlsrc4;

type

  TXLSDecrypter = class
  public 
    function  CheckPassword(Data: TXLSBlob; Password: Widestring): integer; virtual; abstract; 
    procedure Skip(Count: integer); virtual; abstract;
    procedure Decrypt(Data: TXLSBlob; Count: integer); virtual; abstract;
  end;

  TXLSDecrypterRC4 = class(TXLSDecrypter)
  private
    FStreamPos: Longword;
    FPassword: WideString; 
    FMD5: TMD5Hash;
    FRC4: TRC4;  
    FBlock: integer;
    FScratchBuf: TXLSBlob;
  public
    constructor Create;
    function    CheckPassword(Data: TXLSBlob; Password: Widestring): integer; override;
    procedure   Skip(Count: integer); override;
    procedure   Decrypt(Data: TXLSBlob; Count: integer); override;
    destructor  Destroy; override;
  end;

  TXLSDecrypterXOR = class(TXLSDecrypter)
  private
    FStreamPos: Longword;
    FXorKey: array [0..15] of byte; 
    function  Password2Hash(Password: Widestring): Word;
    procedure CreateCryptSeq(key: word; Password: Widestring);
  public
    constructor Create;
    function    CheckPassword(Data: TXLSBlob; Password: Widestring): integer; override;
    procedure   Skip(Count: integer); override;
    procedure   Decrypt(Data: TXLSBlob; Count: integer); override;
    destructor  Destroy; override;
  end;

implementation
uses sysutils, xlsmd4;

Const
  REKEY_BLOCK_SIZE = $400;

{TDecrypterRC4}  
constructor TXLSDecrypterRC4.Create;
begin
  inherited Create;
  FStreamPos := 0;
end;

destructor TXLSDecrypterRC4.Destroy;
begin
  FMD5.Free;
  FRC4.Free;
  FScratchBuf.Free;
  inherited Destroy;
end;

function  TXLSDecrypterRC4.CheckPassword(Data: TXLSBlob; Password: Widestring): integer;
Const 
  BuffSize = 64;
Var 
  PWData: TXLSBlob;
  md5: TMD5Hash;
  Digest: TXLSBlob;
  valDigest: TXLSBlob;
  docid: TXLSBlob;
  salt: TXLSBlob;
  hashedsalt: TXLSBlob;
  offset, keyoffset, tocopy: integer;
  rc4: TRC4;
begin 
  Result := 1;
  FPassword  := Password;
  rc4 := nil;
  md5 := nil;
  docid := TXLSBlob.Create(16);
  salt := TXLSBlob.Create(64);
  hashedsalt := TXLSBlob.Create(16);
  PWData := TXLSBlob.Create(BuffSize);
  Digest := TXLSBlob.Create(16); 
  valDigest := TXLSBlob.Create(16); 
  try
     if Length(Password) > ((BuffSize div 2) - 1) then begin
        Result := -1004;
        //max password size is exceeded
     end;

     if Result = 1 then begin

        docid.CopyData(Data, 6, 0, 16);
        salt.CopyData(Data, 22, 0, 16);
        hashedsalt.CopyData(Data, 38, 0, 16);

        PWData.Clear();
        PWData.SetWideString(Password, 0);
        PWData.SetByte($80, Length(Password) * 2);
        PWData.SetByte(Length(Password) shl 4, 56);
        
        MD5CalcHash(PWData.Buff^, BuffSize, Digest.Buff^);

        offset    := 0;
        keyoffset := 0;
        tocopy    := 5;

        md5 := TMD5Hash.Create();
        md5.Init();
        while (offset <> 16) do begin
           if ((64 - offset) < 5) then begin
               tocopy := 64 - offset;
           end;
           PWData.CopyData(Digest, keyoffset, offset, tocopy);
           Inc(offset, tocopy);

           if (offset = 64) then begin
              md5.Update(PWData.Buff^, 64); 

              keyoffset := tocopy;
              tocopy    := 5 - tocopy;
              offset    := 0;
              continue;
           end;

           keyoffset := 0;
           tocopy := 5;
           
           PWData.CopyData(docid, 0, offset, 16);
        	inc(offset, 16);;
        end;

        PWData.SetByte($80, 16);
        PWData.FillByte(17, 47, 0);
        PWData.SetByte($80, 56);
        PWData.SetByte($0A, 57);

        md5.Update(PWData.Buff^, 64);
        md5.Store(valDigest.Buff^);

        {Generate 40-bit RC4 key from 128-bit hashed password}
        rc4 := TRC4.Create;
        rc4.MakeKey(0, valDigest.Buff^);
        rc4.Process(salt.Buff^, 16);
        rc4.Process(hashedsalt.Buff^, 16);

        salt.SetByte($80, 16);
        salt.FillByte(17, 47, 0);
        salt.SetByte($80, 56);

        MD5CalcHash(salt.Buff^, 64, Digest.Buff^);

        if not CompareMem(Digest.Buff, hashedsalt.Buff, 16) then begin
           Result := -1005; //invalid password
        end else begin
       	    FBlock := -1;

            FMD5.Free;
            FMD5 := md5;
            md5 := nil;
            FRC4.Free;
            FRC4 := rc4;
            rc4 := nil;  
        end;

     end;
   finally
     salt.Free;
     hashedsalt.Free;
     docid.Free;
     md5.Free;
     rc4.Free;
     PWData.Free;
     Digest.Free;  
     valDigest.Free;
   end;
end;

procedure TXLSDecrypterRC4.Skip(Count: integer);
var block: integer;
    size: integer;
begin
  if Count = 0 then exit;
  size := Count;
  if not Assigned(FScratchBuf) then begin
     FScratchBuf := TXLSBlob.Create(REKEY_BLOCK_SIZE);
  end;
  block := (FStreamPos + longword(Count)) div REKEY_BLOCK_SIZE;
  if (block <> FBlock) then begin
      FBlock := block;
      FRC4.MakeKey(FBlock, FMD5.Digest^);
      count := (FStreamPos + longword(Count)) mod REKEY_BLOCK_SIZE; 
  end; 
  FRC4.Process(FScratchBuf.Buff^, Count);
  Inc(FStreamPos, Size); 
end;


procedure TXLSDecrypterRC4.Decrypt(Data: TXLSBlob; Count: integer); 
var size: integer;
    offset: integer;
    pos: longword; 
    step: integer;
begin
  if Count > 0 then begin
     size := Count;
     offset := 0;
     pos := FStreamPos;
     while (FBlock <> integer(((pos + longword(Count)) div REKEY_BLOCK_SIZE))) do begin
       step := REKEY_BLOCK_SIZE - (pos mod REKEY_BLOCK_SIZE);
       FRC4.Process((PAnsiChar(Data.Buff) + offset)^, step);
       Inc(offset, step);
       Inc(pos, step);
       Dec(Count, step);
       Inc(FBlock);
       FRC4.MakeKey(FBlock, FMd5.Digest^);
     end;

     FRC4.Process((PAnsiChar(Data.Buff) + offset)^, Count);
     Inc(FStreamPos, Size); 
  end; 
end;



{TDecrypterXOR}  
constructor TXLSDecrypterXOR.Create;
begin
  inherited Create;
  FStreamPos := 0;
end;

destructor TXLSDecrypterXOR.Destroy;
begin
  inherited Destroy;
end;

function  TXLSDecrypterXOR.CheckPassword(Data: TXLSBlob; Password: Widestring): integer;
var hash, key: word;
    pw_hash: word; 
begin
    Result := 1;
    pw_hash := Password2Hash(Password);
    hash := 0;
    key := 0;

    if Data.DataLength = 4  then begin
       key := Data.GetWord(0);
       hash := Data.GetWord(2); 
    end else if Data.DataLength > 4 then begin
       key := Data.GetWord(2);
       hash := Data.GetWord(4); 
    end else begin
       Result := -1001;
    end;
    
    if Result = 1 then begin
       if not(hash = pw_hash) then 
          Result := -1005;
    end;

    if Result = 1 then begin
       CreateCryptSeq(key, Password);
    end; 
end;

function TXLSDecrypterXOR.Password2Hash(Password: Widestring): Word;
Var Count, i: Word;
    Item: LongWord;
    {$ifdef D2009}
    psw: AnsiString;
    {$else}
    psw: string;
    {$endif}
begin
  Result := 0;
  {$ifdef D2009}
  psw := AnsiString(Password); 
  {$else}
  psw := Password; 
  {$endif}
  Count := Length(psw);
  if Count > 0 then begin
     for i:= 1 to Count do begin
        Item := Ord(psw[i]) shl i;
        Item := (Item and $7FFF) or ((Item and ($7FFF shl 15)) shr 15);
        Result := Result xor Item;
     end;
  end;
  Result := Result xor Count xor $CE4B;
end;

procedure TXLSDecrypterXOR.CreateCryptSeq(key: word; Password: Widestring);
const 
  preset: array [0..15] of byte = ($bb,$ff,$ff,$ba,$ff,$ff,$b9,$80,$00,$be,$0f,$00,$bf,$0f,$00,$00);
var low, high: byte;
    i, len: integer;
    {$ifdef D2009}
    psw: AnsiString;
    {$else}
    psw: string;
    {$endif}
begin
  low := key and $ff;
  high := (key shr 8) and $ff;
  {$ifdef D2009}
  psw := AnsiString(Password); 
  {$else}
  psw := Password; 
  {$endif}
  len := Length(psw);
  if len > 16 then len := 16;
  for i := 0 to len - 1 do begin
      FXorKey[i] := Ord(psw[i + 1]);
  end;

  if len < 16 then begin
     for i := 0 to  (15 - len) do begin
        FXorKey[len + i] := preset[i];
     end;
  end;

  for i := 0 to 7 do begin
      FXorKey[i * 2] := FXorKey[i * 2] xor low;
      FXorKey[i * 2 + 1] := FXorKey[i * 2 + 1] xor high;
  end;

  for i := 0 to 15 do begin
      FXorKey[i] := (FXorKey[i] shl 2) or (FXorKey[i] shr 6);
  end;

end;

procedure TXLSDecrypterXOR.Skip(Count: integer);
begin
  Inc(FStreamPos, Count); 
end;


procedure TXLSDecrypterXOR.Decrypt(Data: TXLSBlob; Count: integer); 
type PByte = ^byte;
var offset: integer;
    buf: PByte;
    i: integer;
    tmp: byte;    
begin
  if Count > 0 then begin
     offset := integer((FStreamPos + longword(Count)) mod 16);
     buf := PByte(Data.Buff);
     for i := 0 to Count - 1 do begin
       tmp := PByte(PAnsiChar(buf) + i)^;
       tmp := (tmp shl 3) or (tmp shr 5);
       PByte(PAnsiChar(buf) + i)^ := tmp xor FXORKey[offset];
       offset := (offset + 1) mod 16;
     end;
     Inc(FStreamPos, Count); 
  end;
end;


end.
