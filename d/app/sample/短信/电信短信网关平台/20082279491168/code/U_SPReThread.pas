{------------------------------------------------}
{       向中中间服务器发送报告线程
{              回馈/递送报告
{              Author：LUOXINXI
{              DateTime:2004/3/11
{------------------------------------------------}


unit U_SPReThread;

interface
uses classes, Sockets, U_MsgInfo, Smgp13_XML, SysUtils, U_SysConfig, windows, Htonl;
type
  TResp = class(TThread)
  private
    TcpResp: TTcpClient;
    Receive: CTSMSHeader;
    xMLResp: TSPPack;
    StatuStr: string;
    StatuEStr: string;
    Response: boolean;
    ftimeout: integer;
    fsleeptime: integer;
    Createstr: string;
  protected
    procedure execute; override;
    procedure SendResp;
    procedure upmemo;
    procedure upCreatestr;
    procedure showError;
    procedure SocketError(Sender: TObject; SocketError: integer);
    procedure wlogtxt(aResponse: PResponse);
    procedure AddCounResp;
    procedure addError;
  public
    constructor create(hostip, hostport: string; sleeptime, timeout: integer); virtual;
    destructor destroy; override;
  end;
type
  TRep = class(TThread)
  private
    TcpReport: TTcpClient;
    Receive: CTSMSHeader;
    XMLReport: TSPPack;
    StatuStr: string;
    StatuEStr: string;
    Response: boolean;
    ftimeout: integer;
    fsleeptime: integer;
    Createstr: string;
  protected
    procedure execute; override;
    procedure SendReport;
    procedure wlogtxt(xReport: PReport);
    procedure upmemo;
    procedure upCreatestr;
    procedure showError;
    procedure SocketError(Sender: TObject; SocketError: integer);
    procedure addcou;
    procedure addError;
  public
    constructor create(hostip, hostport: string; sleeptime, timeout: integer); virtual;
    destructor destroy; override;
  end;

implementation
uses U_main, NetDisconnect;
{ TReThread }
constructor TResp.create(hostip, hostport: string; sleeptime, timeout: integer);
begin
  inherited create(True);
  FreeOnTerminate := True;
  TcpResp := TTcpClient.create(nil);
  TcpResp.OnError := SocketError;
  TcpResp.RemoteHost := hostip;
  TcpResp.RemotePort := hostport;
  fsleeptime := sleeptime;
  ftimeout := timeout;
  Createstr := '【' + datetimetostr(now()) + '】发送回馈报告线程创建成功,服务器IP:' + hostip + ',ThreadID:' + inttostr(self.ThreadID);
  synchronize(upCreatestr);
  Resume;
end;
destructor TResp.destroy;
begin
  FreeAndNil(TcpResp);
  GRespTList.Remove(self);
  Createstr := '【' + datetimetostr(now()) + '】发送回馈报告线程停止,ThreadID:' + inttostr(self.ThreadID);
  synchronize(upCreatestr);
  SMGPGateWay.TBResponse.Tag := 0;
  SMGPGateWay.TBResponse.Caption := 'Start Response';
  LogList.AddLog('10' + Createstr);
  inherited;
end;
procedure TResp.wlogtxt(aResponse: PResponse);
begin
  StatuStr := '[' + datetimetostr(now()) + '](Submit_Resp):';
  StatuStr := StatuStr + aResponse^.Mid + #32;
  StatuStr := StatuStr + aResponse^.Submit_resp.MsgID + #32;
  StatuStr := StatuStr + inttostr(aResponse^.Submit_resp.Status);
  LogList.AddLog('03' + StatuStr);
end;
procedure TResp.execute;
var
  Status_ID, Version: string;
  Command_ID, Sequence_ID: word;
begin
  inherited;
  FillChar(xMLResp, SizeOf(xMLResp), 0);
  FillChar(Receive, SizeOf(Receive), 0);
  readproto(Status_ID, Version, Response);
  readRespSequence(Sequence_ID, Command_ID);
  xMLResp.Header.Command_ID := Command_ID;
  xMLResp.Header.Status_ID := strtoint(Status_ID);
  xMLResp.Header.Sequence_ID := Sequence_ID;
  xMLResp.Header.Version := strtoint(Version);
  while not Terminated do
  begin
    try
      SendResp;
    except
    end;
    sleep(fsleeptime);
  end;
end;
procedure TResp.SendResp;
var
  PackegLen: integer;
  XML: string;
  aList: TList;
  aResponse: PResponse;
  empty: boolean;
  Warning: FullWarnning;
begin
  empty := False;
  XML := '';
  aList := ResponseList.LockList;
  try
    if aList.Count > 0 then
    begin
      aResponse := PResponse(aList.First);
      aList.Delete(0);
    end
    else
      empty := True;
  finally
    ResponseList.UnlockList;
  end;
  if empty then exit; //如果队列中没有回馈报告，退出这个过程
  try
    if TcpResp.Connect then
    begin {//SOCKET连接}
      XML := writeXMLResponse(aResponse^);
      if XML = '' then exit;
      PackegLen := length(XML) + SizeOf(CTSMSHeader); //消息长度
      xMLResp.Header.Total_Length := PackegLen;
      strpcopy(xMLResp.Body, XML);
      if Terminated then
      begin
        ResponseList.Add(aResponse);
        exit;
      end;
      FillChar(Receive, SizeOf(Receive), 0);
      if PackegLen = TcpResp.SendBuf(xMLResp, PackegLen) then
      begin
        if TcpResp.WaitForData(ftimeout) then
        begin
          if TcpResp.ReceiveBuf(Receive, SizeOf(Receive)) = SizeOf(CTSMSHeader) then
            if Receive.Status_ID = 21 then
            begin {//发送成功}
              wlogtxt(aResponse);
              try
                Dispose(aResponse);
              except
              end;
              AddCounResp;
              synchronize(upmemo);
            end
            else
            begin {中间层接收失败}
              ResponseList.Add(aResponse);
              StatuEStr := '【' + datetimetostr(now()) + '】GateWay-->Server Response Error Status_ID:' + inttostr(Receive.Status_ID);
              if Receive.Status_ID = 13 then Warning := FullWarnning.create;
              sleep(5000);
              synchronize(showError);
            end;
        end
        else
        begin {连接超时}
          ResponseList.Add(aResponse);
          StatuEStr := '【' + datetimetostr(now()) + '】GateWay-->Server Response Connect Timeout';
          synchronize(showError);
        end;
      end
      else {发送不成功}
        ResponseList.Add(aResponse);
    end
    else {连接失败}
      ResponseList.Add(aResponse);
  finally
    TcpResp.Close;
  end;
end;

procedure TResp.SocketError(Sender: TObject; SocketError: integer);
begin
  synchronize(addError);
  StatuEStr := '【' + datetimetostr(now) + '】Disconnect, Response SocketError: ' + inttostr(SocketError);
  SocketError := 0;
  synchronize(showError);
end;
procedure TResp.AddCounResp;
begin
  if GRespToS_cou > 2147483600 then GRespToS_cou := 0
  else
    inc(GRespToS_cou);
end;
procedure TResp.addError;
begin
  if RespError > 20000 then RespError := 0
  else
    inc(RespError);
end;
procedure TResp.upmemo;
begin
  if SMGPGateWay.Memo2.Lines.Count > 500 then SMGPGateWay.Memo2.Clear;
  if SMGPGateWay.N3.Checked then
    SMGPGateWay.Memo2.Lines.Add(StatuStr + #13#10);
  SMGPGateWay.StatusBar1.Panels[3].Text := 'T:' + inttostr(GRespToS_cou) + 'E:' + inttostr(RespError);
end;
procedure TResp.showError;
begin
  if SMGPGateWay.Memo2.Lines.Count > 500 then SMGPGateWay.Memo2.Clear;
  if SMGPGateWay.N2.Checked then
    SMGPGateWay.Memo2.Lines.Add(StatuEStr + #13#10);
end;
procedure TResp.upCreatestr;
begin
  SMGPGateWay.Memo3.Lines.Add(Createstr);
end;
{ TReport }
procedure TRep.addcou;
begin
  if GRepToS_cou > 2147483600 then GRepToS_cou := 0
  else
    inc(GRepToS_cou);
end;

procedure TRep.addError;
begin
  if RepError > 20000 then RepError := 0
  else
    inc(RepError);
end;

constructor TRep.create(hostip, hostport: string; sleeptime, timeout: integer);
begin
  inherited create(True);
  FreeOnTerminate := True;
  TcpReport := TTcpClient.create(nil);
  TcpReport.RemoteHost := hostip;
  TcpReport.RemotePort := hostport;
  TcpReport.OnError := SocketError;
  fsleeptime := sleeptime;
  ftimeout := timeout;
  Createstr := '【' + datetimetostr(now()) + '】发送递送报告线程创建成功,服务器IP:' + hostip + ',ThreadID:' + inttostr(self.ThreadID);
  synchronize(upCreatestr);
  Resume;
end;

destructor TRep.destroy;
begin
  FreeAndNil(TcpReport);
  GRepTList.Remove(self);
  Createstr := '【' + datetimetostr(now()) + '】发送递送报告线程停止,ThreadID:' + inttostr(self.ThreadID);
  synchronize(upCreatestr);
  SMGPGateWay.TBReport.Tag := 0;
  SMGPGateWay.TBReport.Caption := 'Start Report';
  //SMGPGateWay.TBReport.Update;
  LogList.AddLog('10' + Createstr);
  inherited;
end;

procedure TRep.execute;
var
  Status_ID, Version: string;
  Command_ID, Sequence_ID: word;
begin
  inherited;
  FillChar(XMLReport, SizeOf(XMLReport), 0);
  FillChar(Receive, SizeOf(Receive), 0);
  readproto(Status_ID, Version, Response);
  readRepsequence(Sequence_ID, Command_ID);
  XMLReport.Header.Command_ID := Command_ID;
  XMLReport.Header.Status_ID := strtoint(Status_ID);
  XMLReport.Header.Sequence_ID := Sequence_ID;
  XMLReport.Header.Version := strtoint(Version);
  while not Terminated do
  begin
    try
      SendReport;
    except
    end;
    sleep(fsleeptime);
  end;
end;

procedure TRep.SendReport;
var
  PackegLen: integer;
  XML: string;
  aList: TList;
  empty: boolean;
  aReport: PReport;
  Warning: FullWarnning;
begin
  empty := False;
  XML := '';
  aList := ReportList.LockList;
  try
    if aList.Count > 0 then
    begin
      aReport := PReport(aList.items[0]);
      aList.Delete(0);
    end
    else empty := True;
  finally
    ReportList.UnlockList;
  end;
  if empty then exit;
  try
    if TcpReport.Connect then
    begin {SOCKET连接}
      XML := writeXmlReport(aReport^);
      if XML = '' then exit;
      PackegLen := length(XML) + SizeOf(CTSMSHeader);
      XMLReport.Header.Total_Length := PackegLen;
      strpcopy(XMLReport.Body, XML);
      if Terminated then
      begin
        ReportList.Add(aReport);
        exit;
      end;
      FillChar(Receive, SizeOf(Receive), 0);
      if PackegLen = TcpReport.SendBuf(XMLReport, PackegLen) then
      begin
        if TcpReport.WaitForData(ftimeout) then
        begin
          if TcpReport.ReceiveBuf(Receive, SizeOf(Receive)) = SizeOf(CTSMSHeader) then
            if Receive.Status_ID = 21 then
            begin
              wlogtxt(aReport);
              Dispose(aReport);
              synchronize(addcou);
              synchronize(upmemo);
            end
            else
            begin {中间层接收失败}
              ReportList.Add(aReport);
              StatuEStr := '【' + datetimetostr(now()) + '】GateWay-->Server Report Error Status_ID:' + inttostr(Receive.Status_ID);
              if Receive.Status_ID = 13 then Warning := FullWarnning.create;
              sleep(5000);
              synchronize(showError);
            end;
        end
        else
        begin {连接超时}
          ReportList.Add(aReport);
          StatuEStr := '【' + datetimetostr(now()) + '】GateWay-->Server Report Connect Timeout';
          synchronize(showError);
        end
      end
      else {发送失败}
        ReportList.Add(aReport);
    end
    else {连接失败}
      ReportList.Add(aReport);
  finally
    TcpReport.Close;
  end;
end;

procedure TRep.SocketError(Sender: TObject; SocketError: integer);
begin
  synchronize(addError);
  StatuEStr := '【' + datetimetostr(now) + '】Report Disconnect,SocketError: ' + inttostr(SocketError);
  SocketError := 0;
  synchronize(showError);
end;

procedure TRep.upmemo;
begin
  if SMGPGateWay.Memo2.Lines.Count > 500 then SMGPGateWay.Memo2.Clear;
  if SMGPGateWay.N3.Checked then
    SMGPGateWay.Memo2.Lines.Add(StatuStr + #13#10);
  SMGPGateWay.StatusBar1.Panels[5].Text := 'T:' + inttostr(GRepToS_cou) + 'E:' + inttostr(RepError);
end;
procedure TRep.showError;
begin
  if SMGPGateWay.Memo2.Lines.Count > 500 then SMGPGateWay.Memo2.Clear;
  if SMGPGateWay.N2.Checked then
    SMGPGateWay.Memo2.Lines.Add(StatuEStr + #13#10);
end;

procedure TRep.wlogtxt(xReport: PReport);
begin
  StatuStr := '[' + datetimetostr(now) + '](Report):';
  StatuStr := StatuStr + xReport^.id + #32;
  StatuStr := StatuStr + xReport^.Submit_date + #32;
  StatuStr := StatuStr + xReport^.done_date + #32;
  StatuStr := StatuStr + xReport^.Stat + #32;
  StatuStr := StatuStr + xReport^.Err;
  LogList.AddLog('05' + StatuStr);
end;


procedure TRep.upCreatestr;
begin
  SMGPGateWay.Memo3.Lines.Add(Createstr);
end;
end.

