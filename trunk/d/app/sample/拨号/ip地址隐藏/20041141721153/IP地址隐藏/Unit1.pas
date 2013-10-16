unit Unit1;

interface

uses
Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, 
StdCtrls, OleCtrls, Registry; 

Const 
SrcIP = '123.123.123.1';//发送方IP地址 
SrcPort = 1234; //发送方端口
DestIP = '127.0.0.2'; //目的IP地址
DestPort = 4321; //目的端口

Max_Message = 4068; 
Max_Packet = 4096; 

type 

TPacketBuffer = Array[0..Max_Packet-1] of byte; 


  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure SendIt;
{ Public declarations }
  end;
// IP 头 
type 
T_IP_Header = record 
ip_verlen : Byte; 
ip_tos : Byte; 
ip_totallength : Word; 
ip_id : Word; 
ip_offset : Word; 
ip_ttl : Byte; 
ip_protocol : Byte; 
ip_checksum : Word; 
ip_srcaddr : LongWord; 
ip_destaddr : LongWord; 
end; 

// UDP 头 
Type 
T_UDP_Header = record 
src_portno : Word; 
dst_portno : Word; 
udp_length : Word; 
udp_checksum : Word; 
end; 

// 一些 Winsock 2 的类型声明 
u_char = Char; 
u_short = Word; 
u_int = Integer; 
u_long = Longint; 

SunB = packed record 
s_b1, s_b2, s_b3, s_b4: u_char; 
end; 
SunW = packed record 
s_w1, s_w2: u_short; 
end; 
in_addr = record 
case integer of 
0: (S_un_b: SunB); 
1: (S_un_w: SunW); 
2: (S_addr: u_long); 
end; 
TInAddr = in_addr; 
Sockaddr_in = record 
case Integer of 
0: (sin_family: u_short; 
sin_port: u_short; 
sin_addr: TInAddr; 
sin_zero: array[0..7] of Char); 
1: (sa_family: u_short; 
sa_data: array[0..13] of Char) 
end; 
TSockAddr = Sockaddr_in; 
TSocket = u_int; 

const 
WSADESCRIPTION_LEN = 256; 
WSASYS_STATUS_LEN = 128; 

type 
PWSAData = ^TWSAData; 
WSAData = record // WSDATA 
wVersion: Word; 
wHighVersion: Word; 
szDescription: array[0..WSADESCRIPTION_LEN] of Char; 
szSystemStatus: array[0..WSASYS_STATUS_LEN] of Char; 
iMaxSockets: Word; 
iMaxUdpDg: Word; 
lpVendorInfo: PChar; 
end; 
TWSAData = WSAData; 

//定义一些 winsock 2 函数
function closesocket(s: TSocket): Integer; stdcall; 
function socket(af, Struct, protocol: Integer): TSocket; stdcall; 
function sendto(s: TSocket; var Buf; len, flags: Integer; var addrto: TSockAddr; 
tolen: Integer): Integer; stdcall;{} 
function setsockopt(s: TSocket; level, optname: Integer; optval: PChar; 
optlen: Integer): Integer; stdcall; 
function inet_addr(cp: PChar): u_long; stdcall; {PInAddr;} { TInAddr } 
function htons(hostshort: u_short): u_short; stdcall; 
function WSAGetLastError: Integer; stdcall; 
function WSAStartup(wVersionRequired: word; var WSData: TWSAData): Integer; stdcall; 
function WSACleanup: Integer; stdcall; 

const 
AF_INET = 2; // internetwork: UDP, TCP, etc. 

IP_HDRINCL = 2; // IP Header Include 

SOCK_RAW = 3; // raw-protocol interface 

IPPROTO_IP = 0; // dummy for IP 
IPPROTO_TCP = 6; // tcp 
IPPROTO_UDP = 17; // user datagram protocol 
IPPROTO_RAW = 255; // raw IP packet 

INVALID_SOCKET = TSocket(NOT(0)); 
SOCKET_ERROR = -1; 


var
  Form1: TForm1;

implementation

// Import Winsock 2 functions 
const WinSocket = 'WS2_32.DLL'; 

function closesocket; external winsocket name 'closesocket'; 
function socket; external winsocket name 'socket'; 
function sendto; external winsocket name 'sendto'; 
function setsockopt; external winsocket name 'setsockopt'; 
function inet_addr; external winsocket name 'inet_addr'; 
function htons; external winsocket name 'htons'; 
function WSAGetLastError; external winsocket name 'WSAGetLastError'; 
function WSAStartup; external winsocket name 'WSAStartup'; 
function WSACleanup; external winsocket name 'WSACleanup'; 


{$R *.DFM} 

function CheckSum(Var Buffer; Size : integer) : Word;
type 
TWordArray = Array[0..1] of Word; 
var 
ChkSum : LongWord; 
i : Integer; 
begin 
ChkSum := 0; 
i := 0; 
While Size > 1 do begin 
//ChkSum := ChkSum + TWordArray(Buffer);
inc(i);
Size := Size - SizeOf(Word);
end; 

//if Size=1 then ChkSum := ChkSum + Byte(TWordArray(Buffer));

ChkSum := (ChkSum shr 16) + (ChkSum and $FFFF); 
ChkSum := ChkSum + (Chksum shr 16); 

Result := Word(ChkSum); 
end; 


procedure BuildHeaders( 
FromIP : String; 
iFromPort : Word; 
ToIP : String; 
iToPort : Word; 
StrMessage : String; 
Var Buf : TPacketBuffer; 
Var remote : TSockAddr; 
Var iTotalSize : Word 
); 
Var 
dwFromIP : LongWord; 
dwToIP : LongWord; 

iIPVersion : Word; 
iIPSize : Word; 
ipHdr : T_IP_Header; 
udpHdr : T_UDP_Header; 

iUdpSize : Word; 
iUdpChecksumSize : Word; 
cksum : Word; 

Ptr : ^Byte; 

procedure IncPtr(value : Integer); 
begin 
ptr := pointer(integer(ptr) + value); 
end; 

begin 
// Convert ip address'ss 

dwFromIP := inet_Addr(PChar(FromIP)); 
dwToIP := inet_Addr(PChar(ToIP)); 

// 初始化 IP 头 
// 
iTotalSize := sizeof(ipHdr) + sizeof(udpHdr) + length(strMessage); 

iIPVersion := 4; 
iIPSize := sizeof(ipHdr) div sizeof(LongWord); 

ipHdr.ip_verlen := (iIPVersion shl 4) or iIPSize; 
ipHdr.ip_tos := 0; // IP type of service 
ipHdr.ip_totallength := htons(iTotalSize); // Total packet len 
ipHdr.ip_id := 0; // Unique identifier: set to 0 
ipHdr.ip_offset := 0; // Fragment offset field 
ipHdr.ip_ttl := 128; // Time to live 
ipHdr.ip_protocol := $11; // Protocol(UDP) 
ipHdr.ip_checksum := 0; // IP checksum
ipHdr.ip_srcaddr := dwFromIP; // Source address
ipHdr.ip_destaddr := dwToIP; // Destination address 
// 
// 初始化 UDP 头 
// 
iUdpSize := sizeof(udpHdr) + length(strMessage); 

udpHdr.src_portno := htons(iFromPort);
udpHdr.dst_portno := htons(iToPort);
udpHdr.udp_length := htons(iUdpSize);
udpHdr.udp_checksum := 0; 

iUdpChecksumSize := 0;

ptr := @buf[0]; 
FillChar(Buf, SizeOf(Buf), 0); 

Move(ipHdr.ip_srcaddr, ptr^, SizeOf(ipHdr.ip_srcaddr)); 
IncPtr(SizeOf(ipHdr.ip_srcaddr)); 

iUdpChecksumSize := iUdpChecksumSize + sizeof(ipHdr.ip_srcaddr); 

Move(ipHdr.ip_destaddr, ptr^, SizeOf(ipHdr.ip_destaddr)); 
IncPtr(SizeOf(ipHdr.ip_destaddr)); 

iUdpChecksumSize := iUdpChecksumSize + sizeof(ipHdr.ip_destaddr); 

IncPtr(1); 

Inc(iUdpChecksumSize); 

Move(ipHdr.ip_protocol, ptr^, sizeof(ipHdr.ip_protocol)); 
IncPtr(sizeof(ipHdr.ip_protocol)); 
iUdpChecksumSize := iUdpChecksumSize + sizeof(ipHdr.ip_protocol); 

Move(udpHdr.udp_length, ptr^, sizeof(udpHdr.udp_length)); 
IncPtr(sizeof(udpHdr.udp_length)); 
iUdpChecksumSize := iUdpChecksumSize + sizeof(udpHdr.udp_length); 

move(udpHdr, ptr^, sizeof(udpHdr)); 
IncPtr(sizeof(udpHdr)); 
iUdpChecksumSize := iUdpCheckSumSize + sizeof(udpHdr); 

Move(StrMessage[1], ptr^, Length(strMessage)); 
IncPtr(Length(StrMessage)); 

iUdpChecksumSize := iUdpChecksumSize + length(strMessage); 

cksum := checksum(buf, iUdpChecksumSize); 
udpHdr.udp_checksum := cksum; 

// 
// 现在 IP 和 UDP 头OK了，我们可以把它发送出去。 
// 
FillChar(Buf, SizeOf(Buf), 0); 
Ptr := @Buf[0]; 

Move(ipHdr, ptr^, SizeOf(ipHdr)); IncPtr(SizeOf(ipHdr)); 
Move(udpHdr, ptr^, SizeOf(udpHdr)); IncPtr(SizeOf(udpHdr)); 
Move(StrMessage[1], ptr^, length(StrMessage)); 


remote.sin_family := AF_INET; 
remote.sin_port := htons(iToPort); 
remote.sin_addr.s_addr := dwToIP; 
end; 

procedure TForm1.SendIt; 
Var 
sh : TSocket; 
bOpt : Integer; 
ret : Integer; 
Buf : TPacketBuffer; 
Remote : TSockAddr; 
Local : TSockAddr; 
iTotalSize : Word; 
wsdata : TWSAdata; 

begin 
// Startup Winsock 2 
ret := WSAStartup($0002, wsdata); 
if ret<>0 then begin 
memo1.lines.add('WSA Startup failed.'); 
exit; 
end; 
with memo1.lines do begin 
add('WSA Startup:'); 
add('Desc.: '+wsData.szDescription); 
add('Status: '+wsData.szSystemStatus); 
end; 

try 
// Create socket 
sh := Socket(AF_INET, SOCK_RAW, IPPROTO_UDP); 
if (sh = INVALID_SOCKET) then begin 
memo1.lines.add('Socket() failed: '+IntToStr(WSAGetLastError)); 
exit; 
end; 
Memo1.lines.add('Socket Handle = '+IntToStr(sh)); 

// Option: Header Include 
bOpt := 1; 
ret := SetSockOpt(sh, IPPROTO_IP, IP_HDRINCL, @bOpt, SizeOf(bOpt)); 
if ret = SOCKET_ERROR then begin 
Memo1.lines.add('setsockopt(IP_HDRINCL) failed: '+IntToStr(WSAGetLastError)); 
exit; 
end; 

// Build the packet 
BuildHeaders( SrcIP, SrcPort, 
DestIP, DestPort, 
'THIS IS A TEST PACKET', 
Buf, Remote, iTotalSize ); 

// Send the packet
ret := SendTo(sh, buf, iTotalSize, 0, Remote, SizeOf(Remote));
if ret = SOCKET_ERROR then 
Memo1.Lines.Add('sendto() failed: '+IntToStr(WSAGetLastError)) 
else 
Memo1.Lines.Add('send '+IntToStr(ret)+' bytes.'); 

// Close socket 
CloseSocket(sh); 
finally 
// Close Winsock 2 
WSACleanup; 
end; 
end; 


procedure TForm1.Button1Click(Sender: TObject);
begin
  SendIt; 
end;

end.
 