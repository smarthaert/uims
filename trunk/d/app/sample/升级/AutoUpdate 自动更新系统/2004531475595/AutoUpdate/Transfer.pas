unit Transfer;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, IdFTP, IdComponent, IdURI, Contnrs;


type
  TOnTransferStart = procedure (Sender: TObject; const AWorkCountMax: Integer)
          of object;
  TOnTransfer = procedure (Sender: TObject; const AWorkCount: Integer) of
          object;
  TOnTransferEnd = procedure (Sender: TObject) of object;
  TTransfer = class(TPersistent)
  private
    FCurrentDir: string;
    FFileName: string;
    FHost: string;
    FOnTransfer: TOnTransfer;
    FOnTransferEnd: TOnTransferEnd;
    FOnTransferStart: TOnTransferStart;
    FPassword: string;
    FPort: Integer;
    FURI: TIdURI;
    FUser: string;
    procedure SetHost(const Value: string); virtual;
    procedure SetURI(Value: TIdURI);
  protected
    function GetOnStatus: TIdStatusEvent; virtual; abstract;
    procedure SetOnStatus(Value: TIdStatusEvent); virtual; abstract;
  public
    procedure Connect; virtual; abstract;
    procedure Get(FileName: String); overload; virtual; abstract;
    procedure Get(Stream: TStream); overload; virtual; abstract;
    procedure WorkStart(Sender: TObject; AWorkMode: TWorkMode; const
            AWorkCountMax: Integer); virtual;
    procedure Work(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount:
            Integer); virtual;
    procedure WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    property CurrentDir: string read FCurrentDir write FCurrentDir;
    property FileName: string read FFileName write FFileName;
    property Host: string read FHost write SetHost;
    property Password: string read FPassword write FPassword;
    property Port: Integer read FPort write FPort;
    property URI: TIdURI read FURI write SetURI;
    property User: string read FUser write FUser;
  published
    property OnStatus: TIdStatusEvent read GetOnStatus write SetOnStatus;
    property OnTransfer: TOnTransfer read FOnTransfer write FOnTransfer;
    property OnTransferEnd: TOnTransferEnd read FOnTransferEnd write
            FOnTransferEnd;
    property OnTransferStart: TOnTransferStart read FOnTransferStart write
            FOnTransferStart;
  end;
  
  TFTPTransfer = class(TTransfer)
  private
    FIdfTP: TIdfTP;
    procedure SetHost(const Value: string); override;
  protected
    function GetOnStatus: TIdStatusEvent; override;
    procedure SetOnStatus(Value: TIdStatusEvent); override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Connect; override;
    procedure Get(FileName: String); overload; override;
    procedure Get(Stream: TStream); overload; override;
    procedure WorkStart(Sender: TObject; AWorkMode: TWorkMode; const
            AWorkCountMax: Integer); override;
  end;
  
  TTransferFactory = class(TObject)
  private
    FIdURI: TIdURI;
    FObjectList: TObjectList;
  public
    constructor Create;
    destructor Destroy; override;
    function CreateTransfer(URL:  String): TTransfer;
  end;
  
  ExceptionNoSuport = class(Exception)
  end;
  

implementation

{
********************************** TTransfer ***********************************
}
procedure TTransfer.SetHost(const Value: string);
begin
  FHost := Value;
end;

procedure TTransfer.SetURI(Value: TIdURI);
begin
  // TODO -cMM: TTransfer.SetURI default body inserted
  //if Assigned(FURI) then FURI.Free;
  FURI := Value;
  self.Host := FURI.Host;
  if trim(FURI.Username) = '' then
    self.User := 'Anonymous'
  else
    self.User := FURI.Username;
  self.Password := FURI.Password;
  if trim(FURI.Path) = '' then
    Self.CurrentDir := '/'
  else
    self.CurrentDir := FURI.Path;
  self.FileName := FURI.Document;
  if (FURI.Port = '') then
    self.Port := 21
  else
    self.Port := StrToInt(FURI.Port);
end;

procedure TTransfer.WorkStart(Sender: TObject; AWorkMode: TWorkMode; const
        AWorkCountMax: Integer);
begin
  if Assigned(FOnTransferStart) then
    FOnTransferStart(Sender, AWorkCountMax);
end;

procedure TTransfer.Work(Sender: TObject; AWorkMode: TWorkMode; const
        AWorkCount: Integer);
begin
  if Assigned(FOnTransfer) then
    FOnTransfer(Sender, AWorkCount);
  Application.ProcessMessages;
end;

procedure TTransfer.WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
  if Assigned(FOnTransferEnd) then
    FOnTransferEnd(Sender);
end;

{
********************************* TFTPTransfer *********************************
}
constructor TFTPTransfer.Create;
begin
  inherited Create;
  FIdFTP := TIdFTP.Create(nil);
  FIdFtp.OnWorkBegin := Self.WorkStart;
  FIdFtp.OnWork := Self.Work;
  FIdFtp.OnWorkEnd := Self.WorkEnd;
  FIdFtp.RecvBufferSize := 8192;
  FIdFtp.SendBufferSize := 4096;
  self.Port := 21;
end;

destructor TFTPTransfer.Destroy;
begin
  if Assigned(FIdFtp) then
  begin
    FIdFtp.Disconnect;
    FreeAndNil(FIdFTP);
  end;
  inherited Destroy;
end;

procedure TFTPTransfer.Connect;
begin
  try
    FIdFtp.Host := self.Host;
    FIdFtp.Username := self.User;
    FidFtp.Password := self.Password;
    FIdFtp.Port := self.Port;
    FIdFtp.Connect();
    if (FidFtp.Username <> 'Anonymous') then
      FIdFtp.Login;
  except
    raise;
  end;
end;

procedure TFTPTransfer.Get(FileName: String);
begin
  try
    if (not FIdFTP.Connected) then
      Connect();
    FIdFtp.ChangeDir(self.CurrentDir);
    FIdFtp.Get(self.FileName, FileName, true);
    FIdFtp.Disconnect;
  except
    raise;
  end;
end;

procedure TFTPTransfer.Get(Stream: TStream);
begin
  try
    if (not FIdFTP.Connected) then
      Connect();
    FIdFtp.ChangeDir(self.CurrentDir);
    FIdFtp.Get(self.FileName, Stream, true);
    FIdFtp.Disconnect;
  except
    raise;
  end;
end;

function TFTPTransfer.GetOnStatus: TIdStatusEvent;
begin
  Result := FIdFtp.OnStatus
end;

procedure TFTPTransfer.SetHost(const Value: string);
begin
  if (Host <> '') then
   if (Host <> Value) then
      FIdFtp.Disconnect;
  inherited SetHost(Value);
end;

procedure TFTPTransfer.SetOnStatus(Value: TIdStatusEvent);
begin
  FIdFtp.OnStatus := Value;
end;

procedure TFTPTransfer.WorkStart(Sender: TObject; AWorkMode: TWorkMode; const
        AWorkCountMax: Integer);
begin
  //inherited WordStart(Sender, AWorkMode, AWorkCountMax);
  if (Assigned(OnTransferStart))  then
    if (AWorkCountMax > 0) then
      inherited WorkStart(Sender, AWorkMode, AWorkCountMax)
    else
      inherited WorkStart(Sender, AWorkMode, FIdFtp.Size(Self.FileName));
      //OnTransferStart(Sender, );
end;

{
******************************* TTransferFactory *******************************
}
constructor TTransferFactory.Create;
begin
  inherited Create;
  FObjectList := TObjectList.Create;
  FIdURI := TIdURI.Create;
end;

destructor TTransferFactory.Destroy;
begin
  FreeAndNil(FObjectList);
  FreeAndNil(FIdURI);
  inherited Destroy;
end;

function TTransferFactory.CreateTransfer(URL:  String): TTransfer;
var
  Index: Integer;
begin
  FIdURI.URI := URL;
  if AnsiUpperCase(FIdURI.Protocol) = 'FTP' then
  begin
    Index := FObjectList.FindInstanceOf(TFTPTransfer);
    if Index <> -1 then
      Result := FObjectList.Items[Index] as TTransfer
    else
      Result := TFTPTransfer.Create;
    Result.URI := FIdURI;
  end
  else
    raise ExceptionNoSuport.Create('不支持的网络协议！');
end;


end.
