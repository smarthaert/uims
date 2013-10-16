unit Base64;

interface

const
  TableBase64 =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';
  ReTablebase64 =
    #$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$3E +#$40
    +#$40 +#$40 +#$3F +#$34 +#$35 +#$36 +#$37 +#$38 +#$39 +#$3A +#$3B +#$3C
    +#$3D +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$00 +#$01 +#$02 +#$03
    +#$04 +#$05 +#$06 +#$07 +#$08 +#$09 +#$0A +#$0B +#$0C +#$0D +#$0E +#$0F
    +#$10 +#$11 +#$12 +#$13 +#$14 +#$15 +#$16 +#$17 +#$18 +#$19 +#$40 +#$40
    +#$40 +#$40 +#$40 +#$40 +#$1A +#$1B +#$1C +#$1D +#$1E +#$1F +#$20 +#$21
    +#$22 +#$23 +#$24 +#$25 +#$26 +#$27 +#$28 +#$29 +#$2A +#$2B +#$2C +#$2D
    +#$2E +#$2F +#$30 +#$31 +#$32 +#$33 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40;

function DecodeBase64(const Value: string): string;
function EncodeBase64(const Value: string): string;

implementation

function Decode4to3Ex(const Value, Table: string): string;
type
  TDconvert = record
    case byte of
      0: (a0, a1, a2, a3: char);
      1: (i: integer);
  end;
var
  x, y, l, lv: Integer;
  d: TDconvert;
  dl: integer;
  c: byte;
  p: ^char;
begin
  lv := Length(Value);
  SetLength(Result, lv);
  x := 1;
  dl := 4;
  d.i := 0;
  p := pointer(result);
  while x <= lv do
  begin
    y := Ord(Value[x]);
    if y in [33..127] then
      c := Ord(Table[y - 32])
    else
      c := 64;
    Inc(x);
    if c > 63 then
      continue;
    d.i := (d.i shl 6) or c;
    dec(dl);
    if dl <> 0 then
      continue;
    p^ := d.a2;
    inc(p);
    p^ := d.a1;
    inc(p);
    p^ := d.a0;
    inc(p);
    d.i := 0;
    dl := 4;
  end;
  case dl of
    1:
      begin
        d.i := d.i shr 2;
        p^ := d.a1;
        inc(p);
        p^ := d.a0;
        inc(p);
      end;
    2:
      begin
        d.i := d.i shr 4;
        p^ := d.a0;
        inc(p);
      end;
  end;
  l := integer(p) - integer(pointer(result));
  SetLength(Result, l);
end;

function Encode3to4(const Value, Table: string): string;
var
  c: Byte;
  n, l: Integer;
  Count: Integer;
  DOut: array[0..3] of Byte;
begin
  setlength(Result, ((Length(Value) + 2) div 3) * 4);
  l := 1;
  Count := 1;
  while Count <= Length(Value) do
  begin
    c := Ord(Value[Count]);
    Inc(Count);
    DOut[0] := (c and $FC) shr 2;
    DOut[1] := (c and $03) shl 4;
    if Count <= Length(Value) then
    begin
      c := Ord(Value[Count]);
      Inc(Count);
      DOut[1] := DOut[1] + (c and $F0) shr 4;
      DOut[2] := (c and $0F) shl 2;
      if Count <= Length(Value) then
      begin
        c := Ord(Value[Count]);
        Inc(Count);
        DOut[2] := DOut[2] + (c and $C0) shr 6;
        DOut[3] := (c and $3F);
      end
      else
      begin
        DOut[3] := $40;
      end;
    end
    else
    begin
      DOut[2] := $40;
      DOut[3] := $40;
    end;
    for n := 0 to 3 do
    begin
      Result[l] := Table[DOut[n] + 1];
      Inc(l);
    end;
  end;
end;

function DecodeBase64(const Value: string): string;
begin
  Result := Decode4to3Ex(Value, ReTableBase64);
end;

function EncodeBase64(const Value: string): string;
begin
  Result := Encode3to4(Value, TableBase64);
end;

end.
 