unit GetPass;

interface

uses
  Windows, SysUtils, Classes, StdCtrls;

type
  PassType = record
    PassCode: string;
    FileType: string;
 end;

var
    DateStr: DWord;
    PassCode: WideString;
    EncodeArray: array[0..19] of Word;
    ReaderArray: array[0..19] of Word;
    function ExecFile(FName: string): PassType;
    procedure GetAccPass(Path: string; DataType, DataPass: TEdit);

var
  InhereCode: array[0..9] of Word =
  ($37EC, $FA9C, $E628, $608A, $367B, $B1DF, $4313, $33B1, $5B79, $2A7C);
  UserCode8: array[0..9] of Word = 
  ($8B86, $345D, $2EC6, $C613, $E454, $02F5, $8477, $DFCF, $1134, $C592);
  UserCode: array[0..9] of Word = 
  ($7B86, $C45D, $DEC6, $3613, $1454, $F2F5, $7477, $2FCF, $E134, $3592);
  InCode97: array[0..19] of byte = 
  ($86, $FB, $EC, $37, $5D, $44, $9C, $FA, $C6, $5E,
    $28, $E6, $13, $00, $00, $00, $00, $00, $00, $00);

implementation

function ExecFile(FName: string): PassType;
  function CovTime(FD: _FileTime): TDateTime;
  var
    TCT: _SystemTime;
    Tmp: _FileTime;
  begin
    FileTimeToLocalFileTime(FD, Tmp);
    FileTimeToSystemTime(Tmp, TCT);
    Result := SystemTimeToDateTime(TCT);
  end;

var
  Stream: TFileStream;
  i, n: integer;
  TP: TSearchRec;
  WTime: TDateTime;
  WSec: DWord;
  M, S: string;
  Buf: array[0..200] of byte;
  Date0: TDateTime;
  Date1: TDateTime;
  Date2: TDateTime;
const
  XorStr = $823E6C94;
begin
  FindFirst(FName, faAnyFile, TP);

  Stream := TFileStream.Create(FName, fmOpenReadWrite);
  Stream.Seek($00, 00); Stream.Read(Buf[0], 200);
  if Buf[$14] = 0 then begin
    PassCode := '';
    Stream.Seek($42, 00); Stream.Read(Buf[0], 20);
    for i := 0 to 19 do
      PassCode := PassCode + chr(Buf[i] xor InCode97[i]);
    Result.PassCode := PassCode;
    Result.FileType := 'ACCESS-97';
    Exit; 
  end;

  Date0 := EncodeDate(1978, 7, 01);
  Date1 := EncodeDate(1989, 9, 17);
  Date2 := EncodeDate(2079, 6, 05);

  Stream.Seek($42, 00); Stream.Read(ReaderArray[0], 40);
  Stream.Seek($75, 00); Stream.Read(DateStr, 4);
  Stream.Free;
  for i := $42 to $42 + 55 do begin
    if i = $72 then M := '-' else M := '';
    S := S + #32 + M + IntToHex(Buf[i], 2);
  end;
  Delete(S, 1, 1);

  if (DateStr >= $90000000) and (DateStr < $B0000000) then begin
    WSec := DateStr xor $903E6C94;
    WTime := Date2 + WSec / 8192 * 2;
  end else begin
    WSec := DateStr xor $803E6C94;
    WTime := Date1 + WSec / 8192;
    if WSec and $30000000 <> 0 then begin
      WSec := $40000000 - WSec;
      WTime := Date1 - WSec / 8192 / 2;
    end;
  end;
  if WTime < Date1 then begin
    for i := 0 to 9 do begin
      EncodeArray[i * 2] := (Trunc(WTime) - Trunc(Date0)) xor UserCode[i] xor $F000;
     
      EncodeArray[i * 2 + 1] := InhereCode[i];
    end;
  end;
  if (WTime >= Date1) and (WTime < Date2) then begin
    for i := 0 to 9 do begin
      EncodeArray[i * 2] := (Trunc(WTime) - Trunc(Date1)) xor UserCode[i];
      EncodeArray[i * 2 + 1] := InhereCode[i];
    end;
  end;
  if WTime >= Date2 then begin
    for i := 0 to 9 do begin
      EncodeArray[i * 2] := (Trunc(WTime) - Trunc(Date1)) xor UserCode[i];
      EncodeArray[i * 2 + 1] := InhereCode[i] xor 1;
     
    end;
  end;
  PassCode := '';
  for i := 0 to 19 do begin
    N := EncodeArray[i] xor ReaderArray[i];
    if N <> 0 then PassCode := PassCode + WideChar(N);
  end;
  Result.FileType := 'ACCESS-2000';
  Result.PassCode := PassCode;
end;

procedure GetAccPass(Path: string; DataType, DataPass: TEdit);
var
  P: PassType;
begin
  P := ExecFile(Path);
  DataType.Text := P.FileType;
  DataPass.Text := P.PassCode;
end;

end.
