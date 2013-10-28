//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsRC4
//       
//      Description:  An implmentation for the RC4 Encryption Algorithm 
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

unit xlsrc4;

{$Q-}
{$R-}

interface

uses xlsblob;

type

  TRC4 = class
  private
    State: array[0..255] of byte;
    x: byte;
    y: byte;
    procedure swap_byte(var a,b: byte);
  public
    procedure prepare_key(const key_data; key_data_len: integer);
    procedure Process(const Buffer; BufferSize: integer);
    procedure MakeKey(block: LongWord; const valDigest);
  end;


implementation

uses xlsmd5;

type
  TFakeBArray = array[0..0] of byte;
  PFakeBArray = ^TFakeBArray;

procedure TRC4.swap_byte(var a,b: byte);
var t: byte;
begin
   t := a; a := b; b := t;
end;

procedure TRC4.prepare_key(const key_data; key_data_len: integer);
var ind1, ind2: byte;
    i: byte;
    key: PFakeBArray; 
begin
  key := PFakeBArray(@key_data);
  for i := 0 to 255 do begin
    state[i] := i;
  end;

  x := 0;
  y := 0;
  ind1 := 0;
  ind2 := 0;

  for i := 0 to 255 do begin
      ind2 := ((key^[ind1] + state[i] + ind2) mod 256); 
      swap_byte(state[i], state[ind2]);
      ind1 := (ind1 + 1) mod key_data_len;
  end;

end;


procedure TRC4.Process(const Buffer; BufferSize: integer);
var i: LongWord;
    x, y: byte;
    xorIndex: byte;
    buf: PFakeBArray; 
begin
  if BufferSize = 0 then exit;

  x := self.x;
  y := self.y;

  buf := PFakeBArray(@Buffer);
  for i := 0 to BufferSize - 1 do begin

      x := (x + 1) mod 256;
      y := (state[x] + y) mod 256; 

      swap_byte (state[x], state[y]);
      xorIndex := (state[x] + state[y]) mod 256;
      buf^[i] := buf^[i] xor state[xorIndex];
  end;

  self.x := x;
  self.y := y;

end;


procedure TRC4.MakeKey(block: LongWord; const valDigest);
var
  Digest : TXLSBlob;
  PWData : TXLSBlob;
  i : integer;
begin 
  Digest := TXLSBlob.Create(16);
  PWData := TXLSBlob.Create(64);
  try
     PWData.Clear();
     PWData.CopyMem(valDigest, 0, 0, 5);
     for i := 0 to 3 do begin
        PWData.SetByte((block shr (i*8)) and $FF, 5 + i);
     end; 
     PWData.SetByte($80, 9);
     PWData.SetByte($48, 56);
     MD5CalcHash(PWData.Buff^, 64, Digest.Buff^);
     prepare_key(Digest.Buff^, 16);  
  finally
    Digest.Free;
    PWData.Free; 
  end;
end;


end.
