{-----------------------------------------------------------------------------
 Unit Name: uUDPPort
 Author:    jzx
 Purpose:   端口嗅探对象
 History:
-----------------------------------------------------------------------------}


unit uUDPPort;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WInSock, StdCtrls;

resourcestring
  RS_CANNOT_LOAD_EXT_DLL = '不能加载 inetmib1.dll 动态库';
  RS_CANNOT_LOAD_INIT_EXT_DLL = '不能初始化 inetmib1.dll 动态库';

const
  HOSTNAMELEN = 256;
  PORTNAMELEN = 256;
  ADDRESSLEN = HOSTNAMELEN + PORTNAMELEN;
  CS_INETMIB1_DLL = 'inetmib1.dll';
  CS_SNMPEXTINIT = 'SnmpExtensionInit';
  CS_SNMPEXTQUERY = 'SnmpExtensionQuery';
  udpidentifiers: array[0..9] of Cardinal = (1, 3, 6, 1, 2, 1, 7, 5, 1, 1);

type
  TAsnOctetString = record
    stream: pByte;
    length: Cardinal;
    dynamic: Boolean;
  end;

  TAsnObjectIdentifier = record
    idLength: Cardinal;
    ids: Pointer;
  end;
  pAsnObjectIdentifier = ^TAsnObjectIdentifier;

  TAsnObjectSyntax = record
    case asnType: Byte of
      0: (number: LongInt);
      1: (unsigned32: Cardinal);
      2: (counter64: Int64);
      3: (AsnString: TAsnOctetString);
      4: (bits: TAsnOctetString);
      5: (AsnObject: TAsnObjectIdentifier);
      7: (sequence: TAsnOctetString);
      8: (address: TAsnOctetString);
      9: (counter: Cardinal);
      10: (gauge: Cardinal);
      11: (ticks: Cardinal);
      12: (arbitrary: TAsnOctetString);
  end;

  TRFC1157VarBind = record
    name: TAsnObjectIdentifier;
    value: TAsnObjectSyntax;
  end;
  pRFC1157VarBind = ^TRFC1157VarBind;

  TRFC1157VarBindList = record
    list: pRFC1157VarBind;
    len: DWord
  end;
  pRFC1157VarBindList = ^TRFC1157VarBindList;

  pTcpInfo = ^TTcpInfo;
  TTcpInfo = record
    prev: pTcpInfo;
    next: pTcpInfo;
    state: Cardinal;
    localip: Cardinal;
    localport: Cardinal;
    remoteip: Cardinal;
    remoteport: Cardinal;
  end;

  TSnmpExtensionInit = function(dwTimeZeroReference: DWord;
    hPollForTrapEvent: PHandle;
    pFirstSupportedRegion: pAsnObjectIdentifier): Boolean; stdcall;

  TSnmpExtensionQuery = function(requestType: Byte;
    variableBindings: pRFC1157VarBindList;
    errorStatus: pLongInt;
    errorIndex: pLongInt): Boolean; stdcall;

  TUDPPortStru = packed record
    Proto : string;
    IP : string;
    Port : string;
    Name : string;
  end;

  PUDPPortStru = ^TUDPPortStru;

  TUDPPortSniffer = class
  private
    FList : TList;
    FCount: Integer;
    FMySnmpExtensionInit: TSnmpExtensionInit;
    FMySnmpExtensionQuery: TSnmpExtensionQuery;
    FhTrapEvent: THandle;
    FhIdentifier: TAsnObjectIdentifier;
    FHideSystemPort: Boolean;

    function Get_Items(const Index: Integer): PUDPPortStru;
  protected
    procedure ClearUDPPortList;
    procedure GetUDPPortList;
    function LoadInetMibEntryPoints: Boolean;
    function GetPortName(Port: Integer; Proto, Name: PChar; NameLen: Integer): PChar;
    function GetIpHostName(Local: Boolean; IpAddr: DWord; Name: PChar; NameLen: Integer): PChar;
  public
    constructor Create(const AGetPortListNow : Boolean = True);
    destructor Destroy;override;
    function Refresh : Integer;
    property Count : Integer read FCount;
    property HideSystemPort : Boolean read FHideSystemPort Write FHideSystemPort;
    property Items[const Index : Integer] : PUDPPortStru read Get_Items;
  end;//

implementation

{ TUDPPortSniffer }

procedure TUDPPortSniffer.ClearUDPPortList;
var
  i : Integer;
begin
  while FList.Count > 0 do
  begin
    Dispose(PUDPPortStru(FList[FList.Count -1]));
    FList.Delete(FList.Count -1);
  end;
end;

constructor TUDPPortSniffer.Create(const AGetPortListNow : Boolean = True);
begin
  FList := TList.Create;
  FHideSystemPort := True;
  if not LoadInetMibEntryPoints then
    raise Exception.Create(RS_CANNOT_LOAD_EXT_DLL);

  if not FMySnmpExtensionInit(GetCurrentTime, @FhTrapEvent, @FhIdentifier) then
    raise Exception.Create(RS_CANNOT_LOAD_INIT_EXT_DLL);
  if AGetPortListNow then
    GetUDPPortList;
end;

destructor TUDPPortSniffer.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TUDPPortSniffer.GetIpHostName(Local: Boolean; IpAddr: DWord;
  Name: PChar; NameLen: Integer): PChar;
var
  HostEnt: PHostEnt;
  nIpAddr: DWord;
begin
  nIpAddr := htonl(IpAddr);
  if IpAddr = 0 then
  begin
    if not Local then
      StrPCopy(Name, Format('%d.%d.%d.%d', [(nIpAddr shr 24) and $FF,
        (nIpAddr shr 16) and $FF,
          (nIpAddr shr 8) and $FF,
          nIpAddr and $FF]))
    else
      Gethostname(Name, NameLen);
  end
  else
  begin
    if (IpAddr = $0100007F) then
      if Local then
        Gethostname(Name, NameLen)
      else
        StrCopy(Name, 'localhost')
    else
    begin
      HostEnt := GetHostByAddr(@IpAddr, Sizeof(nIpAddr), PF_INET);
      if HostEnt <> nil then
        StrCopy(Name, HostEnt^.h_name)
      else
        StrPCopy(Name, Format('%d.%d.%d.%d', [(nIpAddr shr 24) and $FF,
          (nIpAddr shr 16) and $FF,
            (nIpAddr shr 8) and $FF,
            nIpAddr and $FF]))
    end;
  end;
  Result := Name;
end;

function TUDPPortSniffer.GetPortName(Port: Integer; Proto, Name: PChar;
  NameLen: Integer): PChar;
var
  Srvent: PServEnt;
begin
  StrPCopy(Name, '');
  Srvent := GetServByPort(htons(WORD(Port)), Proto);
  if Srvent = nil then
//    StrPLCopy(Name, Format('%d', [Port]), NameLen)
  else
    StrPLCopy(Name, Format('%s', [Srvent^.s_name]), NameLen);
  Result := Name;
end;

procedure TUDPPortSniffer.GetUDPPortList;
var
  CurrentIndex : Integer;
  FwsaData: TWSAData;
  FbindList: TRFC1157VarBindList;
  FbindEntry: TRFC1157VarBind;
  UdpInfoTable: TTcpInfo;
  newEntry, CurrentEntry: pTcpInfo;
  errorStatus, errorIndex: LongInt;
  localname: array[1..HOSTNAMELEN] of Char;
  localport: array[1..PORTNAMELEN] of Char;
  pData : PUDPPortStru;
  AInAddr : TInAddr;
begin
  ClearUDPPortList;
  FbindEntry.name.idLength := $0A;
  FbindEntry.name.ids := @(udpidentifiers[0]);
  FBindList.list := @FbindEntry;
  FBindList.len := 1;
  // Roll through UDP endpoints
  CurrentIndex := 1;
  CurrentEntry := @UdpInfoTable;
  while True do
  begin
    if not FMySnmpExtensionQuery($A1, @FBindList, @errorStatus, @errorIndex) then
      Exit;
    if FbindEntry.name.idLength < $0A then
      break;
    if CurrentIndex <> (pDWord(Integer(FbindEntry.name.ids) + 9 * Sizeof(Cardinal)))^ then
    begin
      CurrentEntry := UdpInfoTable.next;
      CurrentIndex := (pDWord(Integer(FbindEntry.name.ids) + 9 * Sizeof(Cardinal)))^;
    end;
    // 构建自己的TCP信息表
    case (pDWord(Integer(FbindEntry.name.ids) + 9 * Sizeof(Cardinal)))^ of
      1:
        begin // Always allocate a new structure
          newEntry := AllocMem(Sizeof(TTcpInfo));
          newEntry^.prev := CurrentEntry;
          newEntry^.next := @UdpInfoTable;
          CurrentEntry^.next := newEntry;
          CurrentEntry := newEntry;
        end;
      2:
        begin
          currentEntry^.localport := FbindEntry.value.number;
          currentEntry := currentEntry^.next;
        end;
    end;
  end;
  // Now print the connection information
  CurrentEntry := UdpInfoTable.Next;
  while CurrentEntry <> @UdpInfoTable do
  begin
    New(pData);
    pData^.Proto := 'UDP';
    pData^.IP := IntToStr(CurrentEntry^.localip);
    pData.Port := IntToStr(CurrentEntry^.localport);
    pData^.Name := GetPortName(CurrentEntry^.localport, 'UDP', PChar(@localport[1]), PORTNAMELEN);
    if not FHideSystemPort or (pData^.Name = '') then
      FList.Add(pData);
    CurrentEntry := currentEntry^.next;
  end;//while
  FCount := FList.Count;
end;

function TUDPPortSniffer.Get_Items(const Index: Integer): PUDPPortStru;
begin
  Result := nil;
  if Index < FList.Count then
    Result := FList[Index];
end;

function TUDPPortSniffer.LoadInetMibEntryPoints: Boolean;
var
  hInetLib: THandle;
begin
  Result := False;
  hInetLib := LoadLibrary(CS_INETMIB1_DLL);
  if hInetLib = 0 then
    Exit;
  @FMySnmpExtensionInit := GetProcAddress(hInetLib, CS_SNMPEXTINIT);
  if @FMySnmpExtensionInit = nil then
    Exit;
  @FMySnmpExtensionQuery := GetProcAddress(hInetLib, CS_SNMPEXTQUERY);
  if @FMySnmpExtensionQuery = nil then
    Exit;
  Result := True;
end;

function TUDPPortSniffer.Refresh: Integer;
begin
  GetUDPPortList;
end;

end.
