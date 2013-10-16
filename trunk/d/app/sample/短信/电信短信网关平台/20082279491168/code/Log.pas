{------------------------------------------------}
{                   写日志线程                   }
{                      Author: LUOXINXI          }
{                       DateTime: 2004/3/11      }
{------------------------------------------------}
unit Log;

interface
uses
  Messages,
  SysUtils,
  Classes,
  Forms,
  Windows,
  SyncObjs,
  inifiles,
  //UDP
  IdUDPServer,
  IdBaseComponent,
  IdComponent,
  IdUDPBase,
  IdUDPClient,IdSocketHandle,
  //
  ThreadSafeList;
const
  Log_Max_Rows = 10000;
  {写日志}
type
  WriteLog = class(TThread)
  private
    LogEvent: TEvent; //定义事件
    LogFile: TextFile;
    UDPClient:TIdUDPClient;
    flog: byte;
    UDPMsgNO:integer;
    logtxt: string;
    logdate: string;
    date: string;
    fsleep: integer;
    temp1, temp2, temp3: string; //log path file
    {日志序列号计数器}
    CTDeliver: word;
    SPDeliver: word;
    CTResponse: word;
    SPResponse: word;
    CTReport: word;
    SPReport: word;
    SPSubmit: word;
    SubmitToCT: word;
    Active: word;
    Delete: word;
    Login: word;
    Cexit: word;
    {日志行计数器}
    nCTDeliver: word;
    nSPDeliver: word;
    nCTResponse: word;
    nSPResponse: word;
    nCTReport: word;
    nSPReport: word;
    nSPSubmit: word;
    nSubmitToCT: word;
    nActive: word;
    nDelete: word;
    nLogin: word;
    nExit: word;
    Createstr:string;
  protected
    procedure execute; override;
    procedure UDPStatus(ASender: TObject;
       const AStatus: TIdStatus; const AStatusText: String);
    procedure WriteLog(id: byte; Logpath, LogTitle: string);
    procedure readini;
    procedure upmemo;
    procedure writeIntoini;
    procedure Writetxt;
    procedure Log_arrange;
  public
    procedure Terminate;
    constructor create(udpip:string;udpport,sleeptime: integer); virtual;
    destructor destroy; override;

  end;
implementation
uses U_main,U_SysConfig;
{Thread procedure}
constructor WriteLog.create(udpip:string;udpport,sleeptime: integer);
begin
  inherited create(True);
  {UDP 参数设置}
  UDPClient:=TIdUDPClient.Create(nil);
  UDPClient.Host:=udpip;
  UDPClient.Port:=udpport;
  LogEvent := TEvent.Create(nil, False, False, 'FJCTGateway_Log_Write_F16F0AE4-62EE-4A39-BF1A-75ED6EC88DBF');
  freeonterminate := True;
  WriteLog_Free:=False;
  fsleep := sleeptime;
  UDPClient.Active:=True;
  Createstr:='【' + datetimetostr(now()) + '】日志处理功能启动,ThreadID:'+inttostr(self.ThreadID);
  synchronize(upmemo);
  Resume;
end;
destructor WriteLog.destroy;
begin
  writeIntoini;
  UDPClient.Active:=False;
  Createstr:='【' + datetimetostr(now()) + '】日志线程已停止,ThreadID:'+inttostr(self.ThreadID);
  Synchronize(upmemo);
  FreeAndNil(UDPClient);
  LogEvent.SetEvent;
  LogEvent.Free;
  WriteLog_Free:=True;
  inherited;
end;
procedure WriteLog.execute;
begin
  readini;
  temp1 := extractfilepath(application.ExeName) + 'log\CTLog\';
  temp2 := extractfilepath(application.ExeName) + 'log\SPLog\';
  temp3 := extractfilepath(application.ExeName) + 'log\Login_Exit\';
  
  if not DirectoryExists(temp1) then
    ForceDirectories(temp1);
  if not DirectoryExists(temp2) then
    ForceDirectories(temp2);
  if not DirectoryExists(temp3) then
    ForceDirectories(temp3);
    
  while not Terminated do begin
    date := formatdatetime('yymmdd', now);
    if LogList.GetFristLog(logtxt) then
    begin
      if logtxt <> '' then
        Log_arrange;
    end
    else
      LogEvent.WaitFor(Windows.INFINITE); //如果没有新的日志记录加入到日志列表中则线程无限等待
  end;
  
  if  Terminated then
  try
    UDPClient.send('31002 【' + datetimetostr(now()) + '】日志线程退出,电信网关系统退出');
  except
  end;
end;
procedure WriteLog.readini;
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'LogConfig.ini';
  inifile := Tinifile.create(filename);
  try
    logdate := inifile.ReadString('todaydate', 'date', '');
    CTDeliver := inifile.ReadInteger('CTDeliver', 'id', 0);
    SPDeliver := inifile.ReadInteger('SPdeliver', 'id', 0);
    CTResponse := inifile.ReadInteger('CTresponse', 'id', 0);
    SPResponse := inifile.ReadInteger('SPresponse', 'id', 0);
    CTReport := inifile.ReadInteger('CTreport', 'id', 0);
    SPReport := inifile.ReadInteger('SPReport', 'id', 0);
    SPSubmit := inifile.ReadInteger('SPSubmit', 'id', 0);
    SubmitToCT := inifile.ReadInteger('SubmitToCT', 'id', 0);
    Active := inifile.ReadInteger('Active', 'id', 0);
    Delete := inifile.ReadInteger('Delete', 'id', 0);
    Login := inifile.ReadInteger('Login', 'id', 0);
    Cexit := inifile.ReadInteger('Exit', 'id', 0);
    nCTDeliver := inifile.ReadInteger('CTDeliver', 'nowrows', 0);
    nSPDeliver := inifile.ReadInteger('SPdeliver', 'nowrows', 0);
    nCTResponse := inifile.ReadInteger('CTresponse', 'nowrows', 0);
    nSPResponse := inifile.ReadInteger('SPresponse', 'nowrows', 0);
    nCTReport := inifile.ReadInteger('CTreport', 'nowrows', 0);
    nSPReport := inifile.ReadInteger('SPReport', 'nowrows', 0);
    nSPSubmit := inifile.ReadInteger('SPSubmit', 'nowrows', 0);
    nSubmitToCT := inifile.ReadInteger('SubmitToCT', 'nowrows', 0);
    nActive := inifile.ReadInteger('Active', 'nowrows', 0);
    nDelete := inifile.ReadInteger('Delete', 'nowrows', 0);
    nLogin := inifile.ReadInteger('Login', 'nowrows', 0);
    nExit := inifile.ReadInteger('Exit', 'nowrows', 0);
  finally
    inifile.Free;
  end;
end;

procedure WriteLog.writeIntoini;
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'LogConfig.ini';
  inifile := Tinifile.create(filename);
  try
    inifile.WriteString('todaydate', 'date', date);
    inifile.WriteInteger('CTDeliver', 'id', CTDeliver);
    inifile.WriteInteger('SPdeliver', 'id', SPDeliver);
    inifile.WriteInteger('CTresponse', 'id', CTResponse);
    inifile.WriteInteger('SPresponse', 'id', SPResponse);
    inifile.WriteInteger('CTreport', 'id', CTReport);
    inifile.WriteInteger('SPReport', 'id', SPReport);
    inifile.WriteInteger('SPSubmit', 'id', SPSubmit);
    inifile.WriteInteger('SubmitToCT', 'id', SubmitToCT);
    inifile.WriteInteger('Active', 'id', Active);
    inifile.WriteInteger('Delete', 'id', Delete);
    inifile.WriteInteger('Login', 'id', Login);
    inifile.WriteInteger('Exit', 'id', Cexit);
    inifile.WriteInteger('CTDeliver', 'nowrows', nCTDeliver);
    inifile.WriteInteger('SPdeliver', 'nowrows', nSPDeliver);
    inifile.WriteInteger('CTresponse', 'nowrows', nCTResponse);
    inifile.WriteInteger('SPresponse', 'nowrows', nSPResponse);
    inifile.WriteInteger('CTreport', 'nowrows', nCTReport);
    inifile.WriteInteger('SPReport', 'nowrows', nSPReport);
    inifile.WriteInteger('SPSubmit', 'nowrows', nSPSubmit);
    inifile.WriteInteger('SubmitToCT', 'nowrows', nSubmitToCT);
    inifile.WriteInteger('Active', 'nowrows', nActive);
    inifile.WriteInteger('Delete', 'nowrows', nDelete);
    inifile.WriteInteger('Login', 'nowrows', nLogin);
    inifile.WriteInteger('Exit', 'nowrows', nExit);
  finally
    inifile.Free;
  end;
end;

procedure WriteLog.Writetxt;
begin
  try
    WriteLn(LogFile, logtxt);
  finally
    CloseFile(LogFile);
  end;
end;

procedure WriteLog.Log_arrange;
var
  LogTitle: string;
begin
  flog := strtoint(copy(logtxt, 1, 2));
  logtxt := copy(logtxt, 3, length(logtxt) - 2);
  if logdate <> date then begin
    CTDeliver := 0; nCTDeliver := 0;
    SPDeliver := 0; nSPDeliver := 0;
    CTResponse := 0; nCTResponse := 0;
    SPResponse := 0; nSPResponse := 0;
    CTReport := 0; nCTReport := 0;
    SPReport := 0; nSPReport := 0;
    SPSubmit := 0; nSPSubmit := 0;
    SubmitToCT := 0; nSubmitToCT := 0;
    Active := 0; nActive := 0;
    Delete := 0; nDelete := 0;
    Login := 0; nLogin := 0;
    Cexit := 0; nExit := 0;
    logdate := date;
  end;
  case flog of //日志分类
    0: begin
        LogTitle := 'CT_Deliver'; WriteLog(0, temp1, LogTitle);UDPMsgNO:=31011; end; {电信上行网关非报告类短信}
    1: begin
        LogTitle := 'GW_Deliver'; WriteLog(1, temp2, LogTitle);UDPMsgNO:=31111; end; {网关上行中间层非报告类短信}
    2: begin
        LogTitle := 'CT_Respon'; WriteLog(2, temp1, LogTitle); UDPMsgNO:=31051;end; {电信上行网关回馈报告类短信}
    3: begin
        LogTitle := 'GW_Respon'; WriteLog(3, temp2, LogTitle); UDPMsgNO:=31151;end; {网关上行中间层回馈报告类短信}
    4: begin
        LogTitle := 'CT_Report'; WriteLog(4, temp1, LogTitle); UDPMsgNO:=31061;end; {电信上行网关递送报告类短信}
    5: begin
        LogTitle := 'GW_Report'; WriteLog(5, temp2, LogTitle); UDPMsgNO:=31161; end; {网关上行中间层递送报告类短信}
    6: begin
        LogTitle := 'Ser_Submit'; WriteLog(6, temp2, LogTitle);UDPMsgNO:=31121; end; {网关向中间层请求下行短信}
    7: begin
        LogTitle := 'GW_Submit'; WriteLog(7, temp2, LogTitle);UDPMsgNO:=31021; end; {网关下行到电信}
    8: begin
        LogTitle := 'Active_Test';
        if FSysConfig.CheckBox5.Checked then //是否要写链路测试日志
          WriteLog(8, temp3, LogTitle);
         UDPMsgNO:=31001;end; {电信回馈链路测试包}
    9: begin
        LogTitle := 'MT_Delete'; WriteLog(9, temp2, LogTitle);UDPMsgNO:=31121; end; {短信被删除}
    10: begin
        LogTitle := 'Login'; WriteLog(10, temp3, LogTitle);UDPMsgNO:=31002; end; {网关登陆电信}
    11: begin
        LogTitle := 'Exit'; WriteLog(11, temp3, LogTitle);UDPMsgNO:=31002; end; {网关退出电信连接}
  end;
  if FSysConfig.CheckBox4.Checked then
  try
    UDPClient.Send(inttostr(UDPMsgNO)+#32+logtxt); //发送到监控程序
  except
  end;
end;
procedure WriteLog.WriteLog(id: byte; Logpath, LogTitle: string);
var
  sequence: string;
  logid: word;
  filename:string;
begin
  case id of //日志分类
    0: begin
        if nCTDeliver >= Log_Max_Rows then begin
          inc(CTDeliver); nCTDeliver := 1; end; logid := CTDeliver; inc(nCTDeliver); end;
    1: begin
        if nSPDeliver >= Log_Max_Rows then begin
          inc(SPDeliver); nSPDeliver := 1; end; logid := SPDeliver; inc(nSPDeliver); end;
    2: begin
        if nCTResponse >= Log_Max_Rows then begin
          inc(CTResponse); nCTResponse := 1; end; logid := CTResponse; inc(nCTResponse); end;
    3: begin
        if nSPResponse >= Log_Max_Rows then begin
          inc(SPResponse); nSPResponse := 1; end; logid := SPResponse; inc(nSPResponse); end;
    4: begin
        if nCTReport >= Log_Max_Rows then begin
          inc(CTReport); nCTReport := 1; end; logid := CTReport; inc(nCTReport); end;
    5: begin
        if nSPReport >= Log_Max_Rows then begin
          inc(SPReport); nSPReport := 1; end; logid := SPReport; inc(nSPReport); end;
    6: begin
        if nSPSubmit >= Log_Max_Rows then begin
          inc(SPSubmit); nSPSubmit := 1; end; logid := SPSubmit; inc(nSPSubmit); end;
    7: begin
        if nSubmitToCT >= Log_Max_Rows then begin
          inc(SubmitToCT); nSubmitToCT := 1; end; logid := SubmitToCT; inc(nSubmitToCT); end;
    8: begin
        if nActive >= Log_Max_Rows then begin
          inc(Active); nActive := 1; end; logid := Active; inc(nActive); end;
    9: begin
        if nDelete >= Log_Max_Rows then begin
          inc(Delete); nDelete := 1; end; logid := Delete; inc(nDelete); end;
    10: begin
        if nLogin >= Log_Max_Rows then begin
          inc(Login); nLogin := 1; end; logid := Login; inc(nLogin); end;
    11: begin
        if nExit >= Log_Max_Rows then begin
          inc(Cexit); nExit := 1; end; logid := Cexit; inc(nExit); end;
  end;
  sequence := inttostr(logid);
  if logid < 10 then sequence := '0' + sequence;
  Filename := Logpath + 'CTGate_' + LogTitle + '_' + date + '_' + sequence + '.log';
  assignfile(LogFile, filename);
  if fileexists(filename) then
    try
      Append(LogFile);
    except
    end
  else
    try
      rewrite(LogFile);
    except
    end;
  Writetxt;
end;

procedure WriteLog.upmemo;
begin
    SMGPGateWay.Memo3.Lines.Add(CreateStr);
end;

procedure WriteLog.UDPStatus(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: String);
begin
   SMGPGateWay.Memo3.Lines.Add('['+datetimetostr(now)+']'+ AStatusText);
end;

procedure WriteLog.Terminate;
begin
  inherited;
  LogEvent.SetEvent;
end;

end.

