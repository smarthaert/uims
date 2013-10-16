unit CNC;

interface

uses
  WinSock, Classes, SysUtils, Math;

function IPIsCNC(IP: Cardinal): Boolean;

var
  CNCStream: TFileStream;

implementation

function IPIsCNC(IP: Cardinal): Boolean;
var
  ch: Char;
  i: in_addr;
  val: Cardinal;
  IPpos: LongInt;
begin
  i.S_addr := IP;
  val := Ord(i.S_un_b.s_b1) * 65536 + Ord(i.S_un_b.s_b2) * 256 +
    Ord(i.S_un_b.s_b3);
  IPpos := val div 8;
  CNCStream.Position := IPpos;
  CNCStream.Read(ch, 1);
  Result := Ord(ch) and (1 shl (val mod 8)) <> 0;
end;

initialization
  CNCStream := TFileStream.Create('CNC.dat', fmOpenRead);

finalization
  CNCStream.Free;

end.

