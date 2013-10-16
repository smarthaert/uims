{ $HDR$}
{**********************************************************************}
{ 单元说明:}
{ 参阅:}
{ 已知问题:}
{ 待作事项:}
{ 作者: 名字(邮件)}
{ 当前版本号:}
{ 版本历史:}
{**********************************************************************}
unit ThreadSafeList;

interface

uses
  Classes,
  SyncObjs;

type
  TThreadSafe = class
  protected
    FCriticalSection: TCriticalSection;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Lock;
    procedure Unlock;
  end;

  TThreadSafeStringList = class(TThreadSafe)
  protected
    LogEvent: TEvent;
    fStringList: TStringList;
    function GetCount: integer;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure AddLog(const LogStr: string);
    function GetFristLog(var Log: string): boolean;
    function GetLastLog(var Log: string): boolean;
    property Count: integer read GetCount;
  end;


implementation

uses
  SysUtils;

{ TThreadSafe }

constructor TThreadSafe.Create;
begin
  inherited;
  FCriticalSection := TCriticalSection.Create;
end;

destructor TThreadSafe.Destroy;
begin
  FreeAndNil(FCriticalSection);
  inherited;
end;

procedure TThreadSafe.Lock;
begin
  FCriticalSection.Enter;
end;

procedure TThreadSafe.Unlock;
begin
  FCriticalSection.Leave;
end;



{ TThreadSafeStringList }

procedure TThreadSafeStringList.AddLog(const LogStr: string);
begin
  Lock;
  try
    fStringList.Add(LogStr);
    LogEvent.SetEvent;
  finally Unlock; end;
end;

constructor TThreadSafeStringList.Create;
begin
  inherited;
  fStringList := TStringList.Create;
  LogEvent := TEvent.Create(nil, False, False, 'FJCTGateway_Log_Write_F16F0AE4-62EE-4A39-BF1A-75ED6EC88DBF');
  //  LogEvent.ResetEvent;
end;

destructor TThreadSafeStringList.Destroy;
begin
  FreeAndNil(fStringList);
  LogEvent.SetEvent;
  LogEvent.Free;
  inherited;
end;

function TThreadSafeStringList.GetCount: integer;
begin
  Lock;
  try
    result := fStringList.Count;
  finally
    Unlock;
  end;
end;

function TThreadSafeStringList.GetFristLog(var Log: string): boolean;
begin
  Lock;
  try
    result := fStringList.Count > 0;
    if result then begin
      Log := fStringList.Strings[0];
      fStringList.Delete(0);
    end;
  finally Unlock; end;
end;

function TThreadSafeStringList.GetLastLog(var Log: string): boolean;
begin
  Lock;
  try
    result := fStringList.Count > 0;
    if result then begin
      Log := fStringList.Strings[fStringList.Count - 1];
      fStringList.Delete(fStringList.Count - 1);
    end;
  finally Unlock; end;
end;

end.

