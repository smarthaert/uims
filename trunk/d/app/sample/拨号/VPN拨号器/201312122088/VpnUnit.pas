unit VpnUnit;

interface 

uses 
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
Dialogs, StdCtrls, StrUtils, ExtCtrls,  DialUp;


type 
TVpnForm = class(TForm)
    DialUp: TDialUp;
    Button1: TButton;
    Label1: TLabel;
    ServerIPEd: TEdit;
    Label2: TLabel;
    UserEd: TEdit;
    Label3: TLabel;
    PwdEd: TEdit;
    Button2: TButton;
    procedure DialUpVPN;
    procedure DialUpActiveConnection(Sender: TObject; Handle: Integer;
      Status: TRasConnStatusA; StatusString: String; EntryName, DeviceType,
      DeviceName: array of Char);
    procedure DialUpError(Sender: TObject; ErrorCode: Integer;
      ErrorMessage: String);
    procedure DialUpNotConnected(Sender: TObject; ErrorCode: Integer;
      ErrorMessage: String);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
private
{ Private declarations } 
public 
{ Public declarations } 
end; 

var 
VpnForm: TVpnForm;

type
 GUID = record
  Data1: Integer;
  Data2: ShortInt;
  Data3: ShortInt;
  Data4: array[0..7] of Byte;
end;
type
  TRasIPAddr = record
   a: byte;
   b: byte;
   c: byte;
   d: byte;
end;
type
 TRasEntry = record
  dwSize,
  dwfOptions,
  dwCountryID,
  dwCountryCode          : Longint;
  szAreaCode             : array[0.. 10] of Byte;
  szLocalPhoneNumber     : array[0..128] of Byte;
  dwAlternatesOffset     : Longint;
  ipaddr,
  ipaddrDns,
  ipaddrDnsAlt,
  ipaddrWins,
  ipaddrWinsAlt          : TRasIPAddr;
  dwFrameSize,
  dwfNetProtocols,
  dwFramingProtocol      : Longint;
  szScript               : Array [0..259] of Byte;
  szAutodialDll          : Array [0..259] of Byte;
  szAutodialFunc         : Array [0..259] of Byte;
  szDeviceType           : Array [0..16] of Byte;
  szDeviceName           : Array [0..128] of Byte;
  szX25PadType           : Array [0..32] of Byte;
  szX25Address           : Array [0..200] of Byte;
  szX25Facilities        : Array [0..200] of Byte;
  szX25UserData          : Array [0..200] of Byte;
  dwChannels,
  dwReserved1,
  dwReserved2,
  dwSubEntries,
  dwDialMode,
  dwDialExtraPercent,
  dwDialExtraSampleSeconds,
  dwHangUpExtraPercent,
  dwHangUpExtraSampleSeconds,
  dwIdleDisconnectSeconds,
  dwType,
  dwEncryptionType,
  dwCustomAuthKey       : Longint;
  guidId                : GUID;
  szCustomDialDll       : Array [0..259] of Byte;
  dwVpnStrategy,
  dwfOptions2,
  dwfOptions3           : Longint;
  szDnsSuffix           : Array [0..255] of Byte;
  dwTcpWindowSize       : Longint;
  szPrerequisitePbk     : Array [0..259] of Byte;
  szPrerequisiteEntry   : Array [0..256] of Byte;
  dwRedialCount,
  dwRedialPause         : Longint;
end;

TRasCredentialsA = record
  dwSize, dwMask: Longint;
  szUserName: array[0..256] of Byte;
  szPassword: array[0..256] of Byte;
  szDomain: array[0..15] of Byte;
end;

function RasSetEntryPropertiesA(lpszPhonebook, lpszEntry: PAnsichar; lpRasEntry: Pointer; dwEntryInfoSize: LongInt;lpbDeviceInfo:Pointer;dwDeviceInfoSize: Longint): Longint; stdcall;
function RasSetCredentialsA(lpszPhoneBook, lpszEntry: PAnsichar; lpCredentials: Pointer; fClearCredentials: Longint): Longint; stdcall;
procedure CopyMemory(Destination, Source: Pointer; Length:Integer) stdcall;

var
  VpnServerIP,VpnUser,VpnPwd:string;

implementation

{$R *.dfm}

function RasSetEntryPropertiesA; external 'Rasapi32.dll' name 'RasSetEntryPropertiesA'
function RasSetCredentialsA; external 'Rasapi32.dll' name 'RasSetCredentialsA';
procedure CopyMemory; external 'Kernel32.dll' name 'RtlMoveMemory';

function Create_VPN_Connection(sEntryName, sServer, sUsername, sPassword: string): Boolean;
var
  sDeviceName, sDeviceType: string;
  re: TRasEntry;
  rc: TRasCredentialsA;
begin
  sDeviceName := 'WAN 微型端口 (PPTP)';
  sDeviceType := 'VPN';
  with re do
  begin
  Result := False;
  ZeroMemory(@re,SizeOf(re));
  dwSize := Sizeof(re);
  dwCountryCode := 86;
  dwCountryID := 86;
  dwDialExtraPercent := 75;
  dwDialExtraSampleSeconds := 120;
  dwDialMode := 1;
  dwEncryptionType := 3;
  dwfNetProtocols := 4;
  dwfOptions := 1024262928-16;
  dwfOptions2 := 367;
  dwFramingProtocol := 1;
  dwHangUpExtraPercent := 10;
  dwHangUpExtraSampleSeconds := 120;
  dwRedialCount := 3;
  dwRedialPause := 60;
  dwType := 5;
  dwVpnStrategy := 0;
  dwEncryptionType := 3;  //0 无  1 VPN 默认值 3 拨号默认值 可选
  StrCopy(@szDeviceName[0], PansiChar(sDeviceName));
  StrCopy(@szDeviceType[0], PansiChar(sDeviceType));
  StrCopy(@szLocalPhoneNumber[0], PansiChar(sServer));
  end;
  with rc do
  begin
  ZeroMemory(@rc,Sizeof(rc));
  dwSize := sizeof(rc);
  dwMask := 11;
  StrCopy(@szUserName[0],PansiChar(sUsername));
  StrCopy(@szPassword[0],PansiChar(sPassword));
  end;
  if RasSetEntryPropertiesA(Nil, PChar(sEntryName),@re, SizeOf(re), nil, 0)=0 then
  if RasSetCredentialsA(Nil, PChar(sEntryName),@rc,0) = 0 then
  Result := True;
end;

procedure TVpnForm.DialUpVPN;
begin
  DialUp.GetConnections;
  DialUp.DialMode:=dmsync;
  DialUp.GetEntries;
  DialUp.Entry:='VPN';
  DialUp.Dial;
end;

procedure TVpnForm.DialUpActiveConnection(Sender: TObject; Handle: Integer;
  Status: TRasConnStatusA; StatusString: String; EntryName, DeviceType,
  DeviceName: array of Char);
begin
  if Trim(EntryName)='VPN' then DialUp.HangUpConn(Handle);
end;

procedure TVpnForm.DialUpError(Sender: TObject; ErrorCode: Integer;
  ErrorMessage: String);
begin
  Application.MessageBox(PChar('与VPN服务器连接失败! '+ErrorMessage),'VPN连接',MB_OK+MB_ICONWARNING+MB_TOPMOST);
end;

procedure TVpnForm.DialUpNotConnected(Sender: TObject; ErrorCode: Integer;
  ErrorMessage: String);
begin
  Application.MessageBox(PChar('与VPN服务器连接失败! '+ErrorMessage),'VPN连接',MB_OK+MB_ICONWARNING+MB_TOPMOST);
end;

procedure TVpnForm.Button1Click(Sender: TObject);
var
 sServer, sEntryName, sUsername, sPassword: string;
begin
 sEntryName := 'VPN';
 sServer := ServerIPEd.Text;
 sUsername := UserEd.Text;
 sPassword := PwdEd.Text;
 if Create_VPN_Connection(sEntryName, sServer, sUsername, sPassword) then
  begin
   DialUpVPN;
  end else
  begin
   Application.MessageBox('VPN连接建立失败!','VPN连接',MB_OK+MB_ICONWARNING+MB_TOPMOST);
  end;
end;

procedure TVpnForm.Button2Click(Sender: TObject);
begin
  DialUp.GetConnections;
  DialUp.DialMode:=dmsync;
  DialUp.GetEntries;
  DialUp.Entry:='VPN';
  DialUp.DeleteEntry;
end;

end.
