unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WinSock;

const
  SIZE_TABLE = 256 * 256 * 256;
  SIZE_CONTENT = SIZE_TABLE div 8;

type
  TForm1 = class(TForm)
    edt1: TEdit;
    edt2: TEdit;
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
  private
    Table: array[0..SIZE_TABLE - 1] of Integer;
    Content: array[0..SIZE_CONTENT - 1] of Byte;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  wsdata: TWSAData;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  InFile: TStringList;
  OutFile: TFileStream;
  i, j: Integer;
  sIPMask, sIP, sMask: string;
  IP, Bit, Mask, KeyStart, KeyEnd: Cardinal;
  procedure GetIPAndMask(IPMask: string; var AIP, AMask: string);
  var
    ind: Integer;
  begin
    ind := Pos('/', IPMask);
    if ind > -1 then begin
      AIP := Copy(IPMask, 0, ind - 1);
      AMask := Copy(IPMask, ind + 1, Length(IPMask) - ind);
    end;
  end;
  function Str2IP(const HostName: string): cardinal;
  var
    hostEnt: PHostEnt;
  begin
    Result := 0;
    hostEnt := GetHostByName(PChar(HostName));
    if Assigned(hostEnt) then
      if Assigned(hostEnt^.h_addr_list) then
        Move(hostEnt^.h_addr_list^[0], Result, 4);
  end;
begin
  FillChar(Table, Length(Table), 0);
  InFile := TStringList.Create;
  //  读取IP路由表
  InFile.LoadFromFile('CNC.txt');
  for i := 0 to InFile.Count - 1 do begin
    sIPMask := Trim(InFile.Strings[i]);
    if sIPMask = '' then
      Continue;
    GetIPAndMask(sIPMask, sIP, sMask);
    IP := Str2IP(sIP);
    //  无效IP
    if IP <= 0 then
      Continue;
    IP := htonl(IP);
    Bit := StrToIntDef(sMask, 0);
    //  无效掩码位
    if (Bit < 1) or (Bit > 24) then
      Continue;
    Mask := $FFFFFFFF shl (32 - Bit);
    //  计算IP段
    KeyStart := (IP and Mask) shr 8;
    KeyEnd := KeyStart + $01000000 shr Bit;
    for j := KeyStart to KeyEnd - 1 do
      Table[j] := 1;
  end;
  InFile.Free;
  for i := 0 to SIZE_CONTENT - 1 do begin
    Content[i] := (Table[i * 8 + 0] shl 7) or
                  (Table[i * 8 + 1] shl 6) or
                  (Table[i * 8 + 2] shl 5) or
                  (Table[i * 8 + 3] shl 4) or
                  (Table[i * 8 + 4] shl 3) or
                  (Table[i * 8 + 5] shl 2) or
                  (Table[i * 8 + 6] shl 1) or
                  (Table[i * 8 + 7] shl 0);
  end;
  OutFile := TFileStream.Create('CNC.Dat', fmCreate or fmOpenWrite);
  OutFile.WriteBuffer(Content, SIZE_CONTENT);
  OutFile.Free;
end;

initialization
  WSAStartup($0101, wsdata);

finalization
  WSACleanup;

end.

