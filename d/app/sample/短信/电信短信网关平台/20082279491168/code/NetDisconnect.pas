unit NetDisconnect;

interface

uses
  Forms, Dialogs, StdCtrls, mmsystem, classes, SysUtils, log, activex;
type
  TWarnning = class(TThread)
  private
  protected
    procedure execute; override;
    procedure play;
  public
    constructor create; virtual;
    destructor destroy; override;
  end;
type
  FullWarnning = class(TThread)
  private
  protected
    procedure execute; override;
    procedure play;
  public
    constructor create; virtual;
    destructor destroy; override;
  end;
type
  GWWarnning = class(TThread)
  private
    str: string;
  protected
    procedure execute; override;
    function ThreadIsNull: boolean;
    procedure upmemo;
  public
    constructor create; virtual;
    destructor destroy; override;
  end;

implementation
uses U_main, U_SysConfig, U_SPDeliverThread, U_SPReThread, U_SubmitThread;
constructor TWarnning.create;
begin
  inherited create(True);
  FreeOnTerminate := True;
  Resume;
end;

destructor TWarnning.destroy;
begin
  inherited;
end;

procedure TWarnning.execute;
begin
  inherited;
  play;
end;

procedure TWarnning.play;
var
  filename: string;
  i: integer;
begin
  filename := FSysConfig.edit12.text;
  for i := 0 to 1 do try
    PlaySound(pansichar(filename), 0, SND_SYNC);
  except
  end;
end;
{ FullWarnning }

constructor FullWarnning.create;
begin
  inherited create(True);
  FreeOnTerminate := True;
  Resume;
end;

destructor FullWarnning.destroy;
begin
  inherited;
end;

procedure FullWarnning.execute;
begin
  inherited;
  if SMGPGateWay.checkbox1.checked then
    play;
end;

procedure FullWarnning.play;
var
  filename: string;
  i: integer;
begin
  filename := FSysConfig.edit4.text;
  for i := 0 to 1 do try
    PlaySound(pansichar(filename), 0, SND_SYNC);
  except
  end;
end;

{ GWWarnning }

function GWWarnning.ThreadIsNull: boolean;
var
  sleeptime, logNumber: integer;
  autowrite: boolean;
  ip, Port: string;
  timeout: integer;
  udpsrvip:string;
  udpport:integer;
begin
  if WriteLog_Free then begin
    readlogth(udpsrvip,udpport,logNumber, sleeptime, autowrite);
   xWriteLog := WriteLog.create(udpsrvip,udpport,sleeptime);
  end;
  if GDeliverTList.Count = 0 then begin
    readMoport(Port, logNumber, sleeptime);
    readSerIp(ip, timeout);
    try
      //if SMGPGateWay.XMLService.Active then SMGPGateWay.XMLService.Active := False;
      //SMGPGateWay.XMLService.LoadFromFile(extractfilepath(application.ExeName) + 'Service.xml');
      //SMGPGateWay.XMLService.Active := True;
      xDeliverThread := TSPDeliverThread.create(ip, Port, sleeptime, timeout); //创建线程
      GDeliverTList.Add(xDeliverThread);
    except
    end;
  end;
  if GSubmitTList.Count = 0 then begin
    readMTport(Port, logNumber, sleeptime);
    readSerIp(ip, timeout);
    xSubmitThread := TSubmitThread.create(ip, Port, sleeptime, timeout); //创建线程
    GSubmitTList.Add(xSubmitThread);
  end;
  if GRespTList.Count = 0 then begin
    readRespport(Port, logNumber, sleeptime);
    readSerIp(ip, timeout);
    xRespThread := TResp.create(ip, Port, sleeptime, timeout); //创建线程
    GRespTList.Add(xRespThread)
  end;
  if GRepTList.Count = 0 then begin
    readRepport(Port, logNumber, sleeptime);
    readSerIp(ip, timeout);
    xRepThread := TRep.create(ip, Port, sleeptime, timeout); //创建线程
    GRepTList.Add(xRepThread);
  end;
end;

constructor GWWarnning.create;
begin
  inherited create(True);
  FreeOnTerminate := True;
  str := '【' + datetimetostr(now) + '】监控线程启动';
  synchronize(upmemo);
  Resume;
end;

destructor GWWarnning.destroy;
begin
  couninitialize;
  str := '【' + datetimetostr(now) + '】监控线程停止';
  synchronize(upmemo);
  inherited;
end;

procedure GWWarnning.execute;
var
  i: integer;
begin
  inherited;
  coinitialize(nil);
  while not Terminated do begin
    for i := 0 to 3600 do begin   //一小时监控一次
      if Terminated then exit;
      sleep(1000);
    end;
    ThreadIsNull;
  end;
end;

procedure GWWarnning.upmemo;
begin
  SMGPGateWay.MeMO3.Lines.Add(str);
end;

end.

