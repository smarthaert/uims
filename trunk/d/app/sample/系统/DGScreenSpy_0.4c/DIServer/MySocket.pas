unit MySocket;

interface

uses
  Windows, Winsock, MySysutils, MyClasses;

{$WARNINGS OFF}
{$J+} 
const
  TDXHugeSize = 8192 * 2; // 16kb CHUNKS
  TDXXferTimeout: Word = 50000; // if data loss then set to 50000
  TDXMaxSocketBuffer: Word = TDXHugeSize; // Winsock Buffer Size
  PeekBufferSize: Byte = 250; // do not go over 250!
{$J-}

const
  INVALID_SOCKET = Winsock.INVALID_SOCKET;
  WSAENOBUFS = Winsock.WSAENOBUFS;
  WSAETIMEDOUT = Winsock.WSAETIMEDOUT;
  WSAECONNABORTED = Winsock.WSAECONNABORTED;
  Socket_Error = Winsock.SOCKET_ERROR;
  WSAEWOULDBLOCK = Winsock.WSAEWOULDBLOCK;
  WSAECONNRESET = Winsock.WSAECONNRESET;
  ConstSizeofTSockAddrIn = 16;

type
  TSockAddrIn = Winsock.TSockAddrIn;
  TTimeVal = Winsock.TTimeVal;
  TFDSet = Winsock.TFDSet;
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;
  TDXBSArray = array[0..65500] of Char;
  TDXBSArray2 = array[0..250] of Char;
  TDXBlockSizeFlags = (bsfZero, bsfRealSmall, bsfSmall, bsfNormal, bsfBigger, bsfBiggest, bsfHUGE);

  TDXTCPClient = class
  private
    FTLS: Boolean;
    fChunkBuf: Pointer;
    FPeekBuffer: ^TDXBSArray2;
    FReadTimeout: Boolean;
    FBlockSizeFlags: TDXBlockSizeFlags;
    FActualBlockSize: Integer;
    FErrStatus: Integer;
    fTooManyCharacters: Integer;
    GlobalPeerPort: Integer;
    GlobalPeerIPAddress: string;
    VarConstSizeofTSockAddrIn: Integer;
  protected
    function GetPort: Integer;
    function GetIPAddr: string;
    function IsConnected: Boolean;
    function IsValidSocket: Boolean;
    function IsReadable: Boolean;
    function IsWritable: Boolean;
    function DidReadTimeout: Boolean;
    procedure SetfBlockSizeFlags(Value: TDXBlockSizeFlags);
    function FCountWaiting: Integer;
  public
    SockAddr: TSockAddrIn;
    Sock: Integer;
    constructor Create;
    destructor Destroy; override;
    function Connect(ipAddress: string; Port: Integer): Boolean;
    procedure CloseGracefully;
    procedure Disconnect;
    procedure CloseNow;

    function WriteBuffer(const Buf; Count: Integer): Integer;
    function ReadBuffer(var Buf; Count: Integer): Integer; 

    function Write(const s: string): Integer; overload;
    function Write(buf: Pointer; len: Integer): Integer; overload;
    function WriteLn(const s: string): Integer;
    function WriteInteger(const n: integer): integer;
    function WriteStream(Stream: TStream; Count: Integer = 0): Boolean;
    function WriteStreamWithSize(Stream: TStream): Boolean;

    function Read(buf: Pointer; len: Integer): Integer; overload;
    function ReadChar: Char; overload;
    function ReadInteger: integer;
    function ReadStr(MaxLength: Integer): string;
    function ReadLn(Timeout: Longword = 15000): string;
    function ReadStream(Stream: TStream; Timeout: Longword = 150000): Boolean; overload;
    function ReadStreamWithSize(Stream: TStream; Timeout: Longword = 150000): Boolean;

    function PeekString: string;
    function PeekChar: Char;
    function GetErrorDesc(errorCode: Integer): string;
    function DroppedConnection: Boolean;
    function WaitForData(timeout: Longint): Boolean;
    procedure SockClientSetGlobal(I: string; P: Integer);
    procedure SetTimeoutAndBuffer(SocketHandle: Integer);
  published
    property TLSActive: Boolean read FTLS write FTLS;
    property Connected: Boolean read IsConnected;
    property CharactersToRead: Integer read FCountWaiting;
    property ReceiveLength: Integer read FCountWaiting; 
    property ValidSocket: Boolean read IsValidSocket;
    property LastReadTimeout: Boolean read DidReadTimeout;
    property LastCommandStatus: Integer read FErrStatus write FErrStatus;
    property OutputBufferSize: TDXBlockSizeFlags read fBlockSizeFlags write SetfBlockSizeFlags;
    property TooManyCharacters: Integer read fTooManyCharacters write fTooManyCharacters;
    property PeerIPAddress: string read GlobalPeerIPAddress write GlobalPeerIPAddress;
    property PeerPort: Integer read GlobalPeerPort write GlobalPeerPort;
    property LocalIPAddress: string read GetIPAddr;
    property LocalPort: Integer read GetPort;
    property Readable: Boolean read IsReadable;
    property Writable: Boolean read IsWritable;
  end;

  function MakeBytesToWord(const A, B: Byte): Word;
  procedure DoSleepEX(const Interval: DWord);
  function IsNumericString(const S: string): Boolean;
  function FixDottedIP(const S: string): string;
  function TimeOutEX(const MyTime: Cardinal): Boolean;
  function TimeCounter: Cardinal;
  function CreateSocket(sin_family, socket_type, protocol: integer; var ErrorCode: Integer): TSocket;
  function ClientConnectToServer(ServerIPAddress: string; ServerPort: Integer; UseNAGLE: Boolean; ResultSockAddr: PSockAddr; var ErrorCode: Integer): TSocket;
  procedure CloseConnection(var Sock: TSocket; Gracefully: Boolean);
  function BasicSend(Sock: TSocket; var Buf; Len: Integer; Flags: Integer; var ErrorCode: Integer): Integer;
  function BasicRecv(Sock: TSocket; var Buf; Len: Integer; Flags: Integer; var ErrorCode: Integer): Integer;
  function BasicPeek(Sock: TSocket; var Buf; Len: Integer): Integer;
  function BasicSelect(Sock: TSocket; CheckRead: Boolean; Timeout: TTimeVal): Integer;
  procedure SetNagle(Sock: TSocket; TurnOn: Boolean; var ErrorCode: Integer);
  procedure SetBlocking(Sock: TSocket; UseBlocking: Boolean; var ErrorCode: Integer);
  procedure SetReceiveTimeout(Sock: TSocket; TimeoutMS: Integer; var ErrorCode: Integer);
  procedure SetSendTimeout(Sock: TSocket; TimeoutMS: Integer; var ErrorCode: Integer);
  procedure SetReceiveBuffer(Sock: TSocket; WantedSize: Integer; var ErrorCode: Integer);
  procedure ResetBufferAndTimeout(Sock: TSocket; TimeoutMS: Integer; WantedSize: Integer);
  procedure SetSockStatusBool(Sock: TSocket; SO_Flag: Integer; Setting: Boolean; var ErrorCode: Integer);
  function CountWaiting(Sock: TSocket; var ErrorCode: Integer): Integer;
  function GetIPAddressByHost(Host: string; Which: Integer): string;
  function GetHostByIPAddress(IPAddress: string): string;
  function GetLocalHostName: string;
  function GetLocalPort(Sock: TSocket): Integer;
  function GetLocalIPAddr(Sock: TSocket): string;
  function GetLastError: Integer;
  function SocketLayerLoaded: Boolean;
  function SetErrorCode(ResultCode: Integer): Integer;

var
  FGlobalTimeout: TTimeVal;

implementation

var
  FWSAData:  TWSAData;
  FWSResult: Integer;
  FIntSize:  Integer = 4;

function MakeBytesToWord(const A, B: Byte): Word;
begin
  Result := (A shl 8) + B;
end;

procedure DoSleepEX(const Interval: DWord);
begin
  SleepEx(Interval, False);
end;

function IsNumeric(const c: char): Boolean;
begin
  Result := IsCharAlphaNumeric(c) and not IsCharAlpha(c);
end;

function IsNumericString(const S: string): Boolean;
var
  Loop, MaxLoop: Integer;
begin
  Result := True;
  MaxLoop := Length(S);
  Loop := 0;
  while (Loop < MaxLoop) and (Result) do 
  begin
    if (S[Loop + 1] <> '.') then Result := IsNumeric(S[Loop + 1]);
    Inc(Loop);
  end;
end;

function FixDottedIP(const S: string): string;
var
  n: Cardinal;
begin
  Result := '.' + S;
  n := Pos('.0', Result);
  while n > 0 do begin
    Delete(Result, n + 1, 1);
    n := Pos('.0', Result);
  end;
  n := Pos('..', Result);
  while N > 0 do begin
    Insert('0', Result, n + 1);
    n := Pos('..', Result);
  end;
  if Result[Length(Result)] = '.' then Result := Result + '0';
  Delete(Result, 1, 1);
end;

function TimeOutEX(const MyTime: Cardinal): Boolean;
begin
  Result := MyTime <= TimeCounter;
end;

function TimeCounter: Cardinal;
begin
  Result := GetTickCount;
end;

function CreateSocket(sin_family, socket_type, protocol: integer; var ErrorCode: Integer): TSocket;
begin
  ErrorCode := 0;
  Result := Winsock.Socket(sin_family, socket_type, protocol);
  if Result = Invalid_Socket then ErrorCode := WSAGetLastError;
end;

function SetErrorCode(ResultCode: Integer): Integer;
begin
  if ResultCode = Socket_Error then 
	  Result := WSAGetLastError
  else 
	  Result := 0;
end;

procedure SetNagle(Sock: TSocket; TurnOn: Boolean; var ErrorCode: Integer);
var
  TA: array[0..3] of Char;
begin
  if not TurnOn then
    TA := '1111'
  else
    TA := '0000';
  ErrorCode := SetErrorCode(SetSockOpt(Sock, IPPROTO_TCP, TCP_NODELAY, @TA, FIntSize));
end;

procedure SetBlocking(Sock: TSocket; UseBlocking: Boolean; var ErrorCode: Integer);
var
  iBlocking: Integer;
begin
  if UseBlocking then 
	  iBlocking := 0
  else 
	  iBlocking := 1;
  ErrorCode := SetErrorCode(Winsock.ioctlsocket(Sock, FIONBIO, iBlocking));
end;

procedure SetReceiveTimeout(Sock: TSocket; TimeoutMS: Integer; var ErrorCode: Integer);
begin
  ErrorCode := SetErrorCode(setsockopt(Sock, SOL_SOCKET, SO_RCVTIMEO, @TimeoutMS, FIntSize));
end;

procedure SetSendTimeout(Sock: TSocket; TimeoutMS: Integer; var ErrorCode: Integer);
begin
  ErrorCode := SetErrorCode(setsockopt(Sock, SOL_SOCKET, SO_SNDTIMEO, @TimeoutMS, FIntSize));
end;

procedure SetReceiveBuffer(Sock: TSocket; WantedSize: Integer; var ErrorCode: Integer);
begin
  ErrorCode := SetErrorCode(setsockopt(Sock, SOL_SOCKET, SO_RCVBUF, @WantedSize, FIntSize));
end;

procedure ResetBufferAndTimeout(Sock: TSocket; TimeoutMS: Integer; WantedSize: Integer);
begin
  setsockopt(Sock, SOL_SOCKET, SO_SNDTIMEO, @TimeoutMS, FIntSize);
  setsockopt(Sock, SOL_SOCKET, SO_RCVTIMEO, @TimeoutMS, FIntSize);
  setsockopt(Sock, SOL_SOCKET, SO_RCVBUF, @WantedSize, FIntSize);
  setsockopt(Sock, SOL_SOCKET, SO_SNDBUF, @WantedSize, FIntSize);
end;

procedure SetSockStatusBool(Sock: TSocket; SO_Flag: Integer; Setting: Boolean; var ErrorCode: Integer);
var
  intval: integer;
begin
  if (Setting) then 
	  intval := 1
  else 
	  intval := 0;
  ErrorCode := SetErrorCode(SetSockOpt(Sock, SOL_Socket, SO_Flag, @intval, FIntSize));
end;

procedure KillSocket(var Sock: TSocket);
begin
  if Sock <> Invalid_Socket then 
  begin
    ShutDown(Sock, 2);
    CloseSocket(Sock);
    Sock := Invalid_Socket;
  end;
end;

procedure CloseConnection(var Sock: TSocket; Gracefully: Boolean);
var
  Lin: Linger;
begin
  if Sock = Invalid_Socket then Exit;
  Lin.l_linger := 0;
  if Gracefully then 
  begin
    Lin.l_onoff := 1; // Not(0);
    Winsock.setsockopt(Sock, SOL_SOCKET, SO_LINGER, @lin, Sizeof(Lin));
  end
  else 
  begin
    Lin.l_onoff := 0;
    Winsock.setsockopt(Sock, SOL_SOCKET, SO_LINGER, @lin, sizeof(lin)); {DONT 2.0.f}
  end;
  KillSocket(Sock);
end;

function ClientConnectToServer(ServerIPAddress: string; ServerPort: Integer; UseNAGLE: Boolean; ResultSockAddr: PSockAddr; var ErrorCode: Integer): TSocket;
begin
  Result := Invalid_Socket;
  if ServerIPAddress = '' then Exit;
  ServerIPAddress := FixDottedIp(ServerIPAddress);
  FillChar(ResultSockAddr^, Sizeof(ResultSockAddr^), #0);
  ResultSockAddr.sin_family := AF_INET;
  ResultSockAddr.sin_port := htons(ServerPort);
  if IsNumericString(ServerIPAddress) then 
    ResultSockAddr.sin_addr.S_addr := Inet_Addr(Pchar(ServerIPAddress))
  else 
  begin
    ServerIPAddress := GetIPAddressByHost(ServerIPAddress, 1);
    if ServerIPAddress = '' then 
	  begin
      ErrorCode := WSAEFAULT; // invalid address
      Exit;
    end;
    ResultSockAddr.sin_addr.S_addr := Inet_Addr(Pchar(ServerIPAddress));
  end;
  Result := CreateSocket(AF_INET, SOCK_STREAM, IPPROTO_TCP, ErrorCode);
  if (Result <> Invalid_Socket) and (not UseNAGLE) then SetNAGLE(Result, UseNAGLE, ErrorCode);
  if Result = Invalid_Socket then Exit;
  SetSendTimeout(Result, 500, ErrorCode);
  if Connect(Result, ResultSockAddr^, ConstSizeofTSockAddrIn) = SOCKET_ERROR then 
  begin
    ErrorCode := WSAGetLastError;
    KillSocket(Result);
  end;
end;

function BasicSend(Sock: TSocket; var Buf; Len: Integer; Flags: Integer; var ErrorCode: Integer): Integer;
begin
  Result := Send(Sock, Buf, Len, Flags);
  ErrorCode := SetErrorCode(Result);
end;

function BasicRecv(Sock: TSocket; var Buf; Len: Integer; Flags: Integer; var ErrorCode: Integer): Integer;
begin
  Result := Recv(Sock, Buf, Len, Flags);
  ErrorCode := SetErrorCode(Result);
end;

function BasicPeek(Sock: TSocket; var Buf; Len: Integer): Integer;
begin
  Result := Recv(Sock, Buf, Len, MSG_PEEK);
end;

function BasicSelect(Sock: TSocket; CheckRead: Boolean; Timeout: TTimeVal): Integer;
var
  SockList: TFDSet;
begin
  SockList.fd_count := 1;
  SockList.fd_array[0] := Sock;
  if CheckRead then
    Result := Select(0, @sockList, nil, nil, @Timeout)
  else
    Result := Select(0, nil, @sockList, nil, @Timeout)
end;

function CountWaiting(Sock: TSocket; var ErrorCode: Integer): Integer;
var
  numWaiting: longint;
begin
  Result := 0;
  ErrorCode := SetErrorCode(Winsock.IOCtlSocket(Sock, FIONREAD, numWaiting));
  if ErrorCode = 0 then Result := numWaiting;
end;

function GetIPAddressByHost(Host: string; Which: Integer): string;
var
  HostEnt: PHostEnt;
  iAddr: Integer;
begin
  HostEnt := gethostbyname(PChar(Host));
  if Assigned(HostEnt) then 
  begin
    if Which <= (HostEnt^.h_length div 4) then 
	  begin
      Move(PByteArray(HostEnt^.h_addr_list^)[(Which - 1) * 4], iAddr, 4);
      Result := inet_ntoa(in_Addr(iAddr));
    end
    else Result := '';
  end
  else Result := '';
end;

function GetHostByIPAddress(IPAddress: string): string;
var
  HostEnt: PHostEnt;
  InAddr: u_long;
begin
  IPAddress := FixDottedIp(IPAddress);
  InAddr := inet_addr(PChar(IPAddress));
  HostEnt := gethostbyaddr(@InAddr, Length(IPAddress), AF_INET);
  if Assigned(HostEnt) then
    Result := StrPas(HostEnt^.h_name)
  else
    Result := '';
end;

function GetLocalHostName: string;
begin
  Result := GetHostByIPAddress(GetIPAddressByHost('localhost', 1));
  if Result = '' then Result := 'Localhost';
end;

function GetLocalPort(Sock: TSocket): Integer;
var
  addr: TSockAddrIn;
  addrlen: integer;
begin
  addrlen := ConstSizeofTSockAddrIn;
  if getsockname(Sock, addr, addrlen) = 0 then 
	  Result := ntohs(addr.sin_port)
  else 
	  Result := 0;
end;

function GetLocalIPAddr(Sock: TSocket): string;
var
  addr: TSockAddrIn;
  addrlen: integer;
begin
  addrlen := ConstSizeofTSockAddrIn;
  FillChar(Addr, Sizeof(TSockAddrIn), #0);
  getsockname(Sock, addr, addrlen);
  Result := inet_ntoa(addr.sin_addr);
end;

procedure GetRemoteSockAddr(Sock: TSocket; ResultAddr: PSockAddr; ResultAddrlen: PInteger; var ErrorCode: Integer);
begin
  ErrorCode := SetErrorCode(getpeername(Sock, ResultAddr^, ResultAddrlen^));
end;

function GetLastError: Integer;
begin
  Result := WSAGetLastError;
end;

function SocketLayerLoaded: Boolean;
begin
  Result := (FWSResult = 999);
end;

constructor TDXTCPClient.Create();
begin
  inherited Create();
  FReadTimeout := False;
  FPeekBuffer := System.GetMemory(PeekBufferSize);
  fChunkBuf := nil;
  SetFBlockSizeFlags(bsfNormal);
  fTooManyCharacters := 2048;
  Sock := INVALID_SOCKET;
  GlobalPeerPort := 0;
  GlobalPeerIPAddress := '';
  VarConstSizeofTSockAddrIn := ConstSizeofTSockAddrIn;
end;

destructor TDXTCPClient.Destroy;
begin
  if Assigned(fChunkBuf) then System.FreeMemory(fChunkBuf);
  fChunkBuf := nil;
  System.FreeMemory(FPeekBuffer);
  if Sock <> INVALID_SOCKET then CloseNow;
  inherited Destroy;
end;

procedure TDXTCPClient.SetTimeoutAndBuffer(SocketHandle: Integer);
begin
  ResetBufferAndTimeout(SocketHandle, TDXXferTimeout, TDXMaxSocketBuffer);
  FErrStatus := 0;
end;

function TDXTCPClient.Connect(ipAddress: string; Port: Integer): Boolean;
begin
  Result := False;
  Sock := ClientConnectToServer(ipAddress, Port, False, @SockAddr, FErrStatus);
  if (FErrStatus <> 0) then Exit;
  GlobalPeerPort := ntohs(SockAddr.sin_port);
  GlobalPeerIPAddress := inet_ntoa(SockAddr.sin_addr);
  SetBlocking(Sock, True, FErrStatus);
  SetSockStatusBool(Sock, SO_KeepAlive, True, FErrStatus);
  SetTimeoutAndBuffer(Sock);
  SetReceiveBuffer(Sock, TDXMaxSocketBuffer * 4, FErrStatus);
  if FErrStatus <> 0 then SetReceiveBuffer(Sock, TDXMaxSocketBuffer * 3, FErrStatus);
  if FErrStatus <> 0 then SetReceiveBuffer(Sock, TDXMaxSocketBuffer * 2, FErrStatus);
  if FErrStatus <> 0 then SetReceiveBuffer(Sock, TDXMaxSocketBuffer, FErrStatus);
  Result := True;
end;

function TDXTCPClient.Write(buf: Pointer; len: Integer): Integer;
var
  BytesLeft: Integer;
  BytesSent: Integer;
  XferSize: Integer;
  TmpP: Pointer;
begin
  Result := 0;
  if (Sock = INVALID_SOCKET) then Exit;
  if (Len < 1) then Exit;
  BytesLeft := Len;
  TmpP := Buf;
  fErrStatus := 0;
  repeat
    XferSize := BytesLeft;
    if IsWritAble then 
    begin
      if XFerSize > FActualBlockSize then XFerSize := FActualBlockSize;
      BytesSent := BasicSend(Sock, TmpP^, XferSize, 0, FErrStatus);
      case BytesSent of
        -1: begin
            case fErrStatus of
              WSAETIMEDOUT,
              WSAENOBUFS,
              WSAEWOULDBLOCK: fErrStatus := 0;
              WSAECONNABORTED, 
              WSAECONNRESET: CloseNow;
            end;
          end;
        0: CloseNow;
        else 
        begin
          if BytesSent > 0 then Dec(BytesLeft, BytesSent);
          if (BytesLeft > 0) and (fErrStatus = 0) then Inc(LongInt(TmpP), BytesSent);
        end;
      end;
    end; // Is Write able.
  until (BytesLeft = 0) or (FErrStatus <> 0) or (sock = Invalid_Socket);
  Result := Len - BytesLeft;
end;

function TDXTCPClient.WriteInteger(const n: integer): integer;
var
  x: integer;
begin
  x := htonl(n);
  result := Write(@x, sizeof(x));
end;

function TDXTCPClient.Write(const s: string): Integer;
begin
  Result := Write(@S[1], Length(S));
end;

function TDXTCPClient.WriteLn(const s: string): Integer;
begin
  Result := Write(S + #13#10);
end;

function TDXTCPClient.ReadInteger: integer;
var
  n: integer;
  cnt: integer;
begin
  cnt := Read(@n, sizeof(n));
  if cnt = sizeof(n) then 
  begin
    n := ntohl(n);
    result := n;
  end
  else result := -1;
end;

function TDXTCPClient.Read(buf: Pointer; len: Integer): Integer;
begin
  fReadTimeout := False;
  Result := 0;
  if (Sock = INVALID_SOCKET) or (Len < 1) then exit;
  Result := BasicRecv(Sock, Buf^, Len, 0, FErrStatus);
  fReadTimeout := Result < 1;
  if Result = 0 then CloseGracefully;
end;

function TDXTCPClient.ReadChar: Char;
var
  Size: Integer;
begin
  Size := Read(@Result, 1);
  if Size < 1 then Result := #0;
end;

function TDXTCPClient.ReadStr(MaxLength: Integer): string;
var
  Size: Integer;
  Ctr: Integer;
  Done: Boolean;
  ReadSize: Integer;
begin
  fReadTimeout := False;
  if Sock = INVALID_SOCKET then Exit;
  Result := '';
  if MaxLength = 0 then Exit;
  Size := MaxLength;
  if MaxLength < 0 then Size := TDXHugeSize;
  Setlength(Result, Size);
  fErrStatus := 0;
  Ctr := 0;
  Done := False;
  while (not Done) and (IsConnected) do 
  begin
    ReadSize := Read(@Result[Ctr + 1], Size - Ctr);
    Done := (Ctr + ReadSize = Size) or
      ((ReadSize = -1) and (MaxLength = -1));
    if not Done then begin
      if ReadSize > 0 then Inc(Ctr, ReadSize);
      if (ReadSize > 0) and
        (MaxLength = -1) and
        (FCountWaiting = 0) then 
        Done := True
      else 
		DoSleepEx(1); 
    end
    else fErrStatus := 0;
  end;
  if (((fErrStatus <> 0) and (fErrStatus <> WSAETIMEDOUT) and (fErrStatus <> WSAEWOULDBLOCK))) or (Size = 0) then
    Result := ''
  else
    if (Size = Socket_Error) then
      Result := ''
    else begin
      Setlength(Result, Ctr);
      fReadTimeout := False;
    end;
end;

function TDXTCPClient.ReadLn(Timeout: Longword = 15000): string;
var
  markerCR, markerLF: Integer;
  s: string;
  startTime: Cardinal;
  LastChar: Char;
  pstring: string;
begin
  Result := '';
  fReadTimeout := False;
  if Sock = INVALID_SOCKET then exit;
  S := ReadChar;
  LastChar := S[1];
  if (Sock = INVALID_SOCKET) then exit;
  MarkerLF := 0;
  MarkerCR := 0;
  fErrStatus := 0;
  StartTime := TimeCounter + Timeout;
  while (Sock <> Invalid_Socket) and
    (MarkerLF + MarkerCR = 0) and
    (not TimeoutEX(StartTime)) and
    (Length(S) < fTooManyCharacters) and
    ((fErrStatus = 0) or (fErrStatus = WSAETIMEDOUT)
    or (fErrStatus = WSAEWOULDBLOCK)) do 
  begin
    if (LastChar = '') or (not (LastChar in [#10, #13])) then 
	begin
      pString := PeekString;
      if TimeoutEX(StartTime) then Break;
      if (pString = '') then
        LastChar := ReadChar
      else
      begin
        MarkerLF := CharPos(#10, pString);
        MarkerCR := CharPos(#13, pString);
        if MarkerLF + MarkerCR > 0 then begin
          if MarkerLF = 0 then
            MarkerLF := MarkerCR
          else if MarkerCR = 0 then
            MarkerCR := MarkerLF;
          if Min(MarkerLF, MarkerCR) > 1 then S := S + Copy(pString, 1, Min(MarkerLF, MarkerCR) - 1);
          ReadStr(Min(MarkerLF, MarkerCR));
          LastChar := #13;
        end
        else
        begin
          S := S + pString;
          ReadStr(Length(pString));
          LastChar := #0;
        end;
      end;
      if TimeoutEX(StartTime) then Break;
      if LastChar > '' then S := S + LastChar;
    end;
    if (Length(LastChar) > 0) and (LastChar in [#10, #13]) then begin
      MarkerLF := CharPos(#10, S);
      MarkerCR := CharPos(#13, S);
      if MarkerLF + MarkerCR > 0 then begin
        if MarkerLF = Length(S) then begin {unix or DOS}
          if MarkerCR = 0 then
          begin {unix or Mac}
            if FCountWaiting > 0 then
              if PeekChar = #13 then
              begin {Mac}
                LastChar := ReadChar;
                S := S + LastChar;
              end;
          end
          else if MarkerCR < MarkerLF then MarkerLF := MarkerCR;
          MarkerCR := MarkerLF;
        end;
        if MarkerCR = Length(S) then begin {Mac or DOS}
          if MarkerLF = 0 then
          begin {Mac or DOS}
            if FCountWaiting > 0 then
              if PeekChar = #10 then
              begin {DOS}
                LastChar := ReadChar;
                S := S + LastChar;
              end;
          end
          else if MarkerLF < MarkerCR then MarkerCR := MarkerLF;
          MarkerLF := MarkerCR;
        end;
      end;
    end;
  end;
  if Sock = INVALID_SOCKET then exit;
  FReadTimeout := (MarkerCR < 1) and (TimeoutEX(StartTime));
  Result := Copy(S, 1, MarkerCR - 1);
end;

function TDXTCPClient.WriteBuffer(const Buf; Count: Integer): Integer; // Borland friendly
begin
  Result := Write(@Buf, Count);
end;

function TDXTCPClient.ReadBuffer(var Buf; Count: Integer): Integer; // Borland friendly
begin
  Result := Read(@Buf, Count);
end;

function TDXTCPClient.WriteStream(Stream: TStream; Count: Integer = 0): Boolean;
var
  Len: Integer;
  SSize, SPosition: Integer;
  Tries: Integer;
begin
  fErrStatus := 0;
  if Count = 0 then
    SSize := Stream.Size
  else
    SSize := Count;
  SPosition := Stream.Position;
  Tries := 0;
  while (sock <> Invalid_Socket) and (Stream.Position < Stream.Size) and (fErrStatus = 0) and (Tries < 3) do 
  begin
    if (SSize - SPosition) < FActualBlockSize then
      Len := SSize - SPosition
    else
      Len := FActualBlockSize;
    if Len > 0 then 
	begin
      Stream.Seek(SPosition, 0);
      Stream.Read(fChunkBuf^, Len);
      Len := Write(fChunkBuf, Len);
      SPosition := SPosition + Len;
      if fErrStatus > 0 then 
        Tries := 3
      else
        if Len < 1 then
          Inc(Tries)
        else
          Tries := 0;
    end;
  end;
  Result := (Sock <> INVALID_SOCKET) and (fErrStatus = 0);
end;

function TDXTCPClient.WriteStreamWithSize(Stream: TStream): Boolean;
var
  Size: Integer;
begin
  Result := False;
  Size := Stream.Size;
  if size < 1 then Exit;
  size := htonl(size);
  Stream.Seek(0, 0);
  if Write(@Size, 4) = 4 then Result := WriteStream(Stream);
end;

function TDXTCPClient.ReadStream(Stream: TStream; Timeout: Longword = 150000): Boolean;
var
  SLen: Integer;
  StartTime: Cardinal;
  OldSize: Integer;
begin
  OldSize := Stream.Size;
  fErrStatus := 0;
  fReadTimeout := False;
  StartTime := TimeCounter + Timeout;
  while ((fErrStatus = 0) or (fErrStatus = WSAETIMEDOUT) or (fErrStatus = WSAEWOULDBLOCK)) and
    (not TimeoutEX(StartTime)) do begin
    SLen := Read(fChunkBuf, FActualBlockSize);
    if SLen < 1 then begin
      if SLen = 0 then Break;
    end
    else
      Stream.Write(fChunkBuf^, SLen);
    if SLen < FActualBlockSize then Break; //GT for TLS Stops looping until timeout
  end;
  Result := (Sock <> INVALID_SOCKET) and ((fErrStatus = 0) or (fErrStatus = WSAETIMEDOUT) or (fErrStatus = WSAEWOULDBLOCK));
  if Result then Result := Stream.Size <> OldSize;
end;

function TDXTCPClient.ReadStreamWithSize(Stream: TStream; Timeout: Longword = 150000): Boolean;
var
  Size: Integer;
  StartTime: Cardinal;
  SLen: Integer;
begin
  Stream.Size := 0;
  fReadTimeout := False;
  if Read(@Size, 4) = 4 then 
  begin
    size := ntohl(size);
    StartTime := TimeCounter + Timeout;
    fErrStatus := 0;
    while ((fErrStatus = 0) or (fErrStatus = WSAETIMEDOUT) or (fErrStatus = WSAEWOULDBLOCK)) and (not TimeoutEX(StartTime)) and (Size > 0) do 
	begin
      SLen := Read(fChunkBuf, Min(Size, FActualBlockSize));
      case SLen of
        -1: ; // non-fatal
        0: Break; // fatal
        else 
	    begin
          Stream.Write(fChunkBuf^, SLen);
          Dec(Size, SLen);
        end;
      end;
    end;
  end;
  Result := (Sock <> INVALID_SOCKET) and ((fErrStatus = 0) or (fErrStatus = WSAETIMEDOUT) or (fErrStatus = WSAEWOULDBLOCK)) and ((Size = 0) and (Stream.Size > 0));
end;

function TDXTCPClient.PeekString: string;
var
  Size: Integer;
begin
  Result := '';
  fReadTimeout := False;
  if Sock = INVALID_SOCKET then exit;
  FErrStatus := BasicPeek(Sock, FPeekBuffer^, PeekBufferSize);
  if FErrStatus = Socket_Error then begin
    FErrStatus := 0;
    Exit;
  end
  else Size := FErrStatus;
  Setlength(Result, Size);
  if Size > 0 then Move(FPeekBuffer^, Result[1], Size); // 3.0
end;

function TDXTCPClient.PeekChar: Char;
begin
  Result := #0;
  fReadTimeout := False;
  if Sock = INVALID_SOCKET then exit;
  FErrStatus := BasicPeek(Sock, FPeekBuffer^, 1);
  case fErrStatus of
    0:  CloseNow;
    Socket_Error: FErrStatus := 0;
  else
    Result := FPeekBuffer^[0];
  end;
end;

procedure TDXTCPClient.CloseGracefully;
begin
  CloseConnection(Sock, True);
end;

procedure TDXTCPClient.Disconnect;
begin
  CloseConnection(Sock, True);
end;

procedure TDXTCPClient.CloseNow;
begin
  CloseConnection(Sock, False);
end;

function TDXTCPClient.IsValidSocket: Boolean;
begin
  Result := Sock <> INVALID_SOCKET;
end;

function TDXTCPClient.IsConnected: Boolean;
begin
  Result := (Sock <> INVALID_SOCKET)
    and ((FErrStatus = 0) or (FErrStatus = WSAETIMEDOUT) or
    (FErrStatus = WSAEWOULDBLOCK) or (fErrStatus = 10038));
  if not Result and (FCountWaiting > 0) then Result := True;
end;

function TDXTCPClient.IsReadable: Boolean;
begin
  fReadTimeout := False;
  Result := False;
  if Sock = INVALID_SOCKET then exit;
  Result := BasicSelect(Sock, True, FGlobalTimeout) > 0;
  fErrStatus := 0;
end;

function TDXTCPClient.IsWritable: Boolean;
begin
  fReadTimeout := False;
  Result := False;
  if Sock = INVALID_SOCKET then exit;
  Result := BasicSelect(Sock, False, FGlobalTimeout) > 0;
  fErrStatus := 0;
end;

function TDXTCPClient.DidReadTimeout: Boolean;
begin
  Result := fReadTimeout;
end;

function TDXTCPClient.GetPort: Integer;
begin
  Result := 0;
  if Sock = INVALID_SOCKET then exit;
  Result := GetLocalPort(Sock);
end;

function TDXTCPClient.GetIPAddr: string;
begin
  Result := '';
  if Sock = INVALID_SOCKET then exit;
  Result := GetLocalIPAddr(Sock);
end;

function TDXTCPClient.GetErrorDesc(errorCode: Integer): string;
begin
  Result := GetErrorDesc(ErrorCode);
end;

procedure TDXTCPClient.SetfBlockSizeFlags(Value: TDXBlockSizeFlags);
begin
  if Assigned(fChunkBuf) then System.FreeMemory(fChunkBuf);
  fChunkBuf := nil;
  fBlockSizeFlags := Value;
  case FBlockSizeFlags of
    bsfZero: fActualBlockSize := 0;
    bsfRealSmall: fActualBlockSize := 128;
    bsfSmall: fActualBlockSize := 256;
    bsfNormal: fActualBlockSize := 512;
    bsfBigger: fActualBlockSize := 2048;
    bsfBiggest: fActualBlockSize := 4096;
  else
    fActualBlockSize := TDXHugeSize;
  end;
  if FBlockSizeFlags <> bsfZero then fChunkBuf := System.GetMemory(FActualBlockSize);
end;

function TDXTCPClient.FCountWaiting: Integer;
begin
  Result := CountWaiting(Sock, FErrStatus);
  if FErrStatus <> 0 then 
  begin
    Result := 0;
    Exit;
  end;
end;

procedure TDXTCPClient.SockClientSetGlobal(I: string; P: Integer);
begin
  GlobalPeerPort := P;
  GlobalPeerIPAddress := I;
end;

function TDXTCPClient.DroppedConnection: Boolean;
begin
  Result := False;
  if IsReadable and (CharactersToRead = 0) then
  begin
    CloseNow; 
    Result := True;
  end;
end;

function TDXTCPClient.WaitForData(timeout: Longint): Boolean;
var
  StartTime: Cardinal;
begin
  Result := False;
  StartTime := TimeCounter + Cardinal(timeout);
  while not TimeOutEX(StartTime) do 
  begin
    if DroppedConnection then 
	begin
      CloseNow;
      Exit;
    end
    else 
	begin
      if CharactersToRead > 0 then 
	  begin
        Result := True;
        Exit;
      end
      else DoSleepEx(0);
    end;
  end;
end;

initialization
  FWSResult := WSAStartup(MAKEBytesToWORD(2, 2), FWSAData);
  if (FWSResult = 0) then 
  begin
    FWSResult := 999;
    FGlobalTimeout.tv_Sec := 0;
    FGlobalTimeout.tv_uSec := 500; 
  end
  else FWSResult := 123;
end.