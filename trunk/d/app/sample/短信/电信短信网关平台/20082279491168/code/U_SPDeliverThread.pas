{－－－－－－－－－－－－－－－－－－－－－－－－}
{               向中间服务器发送DELIVER线程      }
{               Author:  LUOXINXI                }
{               Datetime:       2004/3/11        }
{－－－－－－－－－－－－－－－－－－－－－－－－}
unit U_SPDeliverThread;

interface
uses
  classes, Sockets, U_MsgInfo, Smgp13_XML, SysUtils, U_SysConfig, Htonl,
  forms, windows, mmsystem, NetDisconnect;
type
  TSPDeliverThread = class(TThread)
  private
    TcpDeliver: TTcpClient;
    StatuStr: string;
    StatuEStr: string;
    Createstr: string;
    SMLDeliver: TSPPack;
    Receive: CTSMSHeader;
    Response: boolean;
    ftimeout: integer;
    fsleeptime: integer;
    DeliverSequence: word;
    FeeSequence_ID: word;
    defSequence_id: word;
    Warning: FullWarnning;
  protected
    procedure execute; override;
    procedure SendDeliver;
    procedure TestSendDeliver(PackegLen: Longword); //(平台整合)测试发送
    procedure upmemo;
    procedure upcreatestr;
    procedure showError;
    procedure SocketError(Sender: TObject; SocketError: integer);
    procedure addcou;
    procedure addError;
    procedure wlogtxt(xDeliver: TTCDeliver; Sequence: Longword);
  public
    constructor create(hostip, hostport: string; sleeptime, timeout: integer); virtual;
    destructor destroy; override;
  end;
implementation
uses U_Main;
{ TSPDeliverThread }


constructor TSPDeliverThread.create(hostip, hostport: string; sleeptime, timeout: integer);
begin
  inherited create(True);
  FreeOnTerminate := True;
  TcpDeliver := TTcpClient.create(nil);
  TcpDeliver.RemoteHost := hostip;
  TcpDeliver.RemotePort := hostport;
  TcpDeliver.OnError := SocketError;
  fsleeptime := sleeptime;
  ftimeout := timeout;
  Createstr := '【' + datetimetostr(now()) + '】发送正常短信线程创建成功,服务器IP:' + hostip + ',ThreadID:' + inttostr(self.ThreadID);
  synchronize(upcreatestr);
  Resume;
end;

destructor TSPDeliverThread.destroy;
begin
  FreeAndNil(TcpDeliver);
  GDeliverTlist.Remove(self);
  Createstr := '【' + datetimetostr(now()) + '】发送正常短信线程停止,ThreadID:' + inttostr(self.ThreadID);
  synchronize(upcreatestr);
  SMGPGateWay.TBDToS.Tag := 0;
  SMGPGateWay.TBDToS.Caption := 'Start DeliToSer';
  LogList.AddLog('10' + Createstr);
  inherited;
end;

procedure TSPDeliverThread.execute;
var
  Status_ID, Version: string;
  Command_ID: word;
begin
  inherited;
  FillChar(SMLDeliver, SizeOf(SMLDeliver), 0);
  FillChar(Receive, SizeOf(Receive), 0);
  readproto(Status_ID, Version, Response);
  readDsequence(DeliverSequence, Command_ID); //
  SMLDeliver.Header.Command_ID := Command_ID;
  SMLDeliver.Header.Sequence_ID := DeliverSequence;
  SMLDeliver.Header.Status_ID := strtoint(Status_ID);
  SMLDeliver.Header.Version := strtoint(Version);
  while not Terminated do
  begin
    try
      SendDeliver;
    except
    end;
    sleep(fsleeptime);
  end;
end;
procedure TSPDeliverThread.wlogtxt(xDeliver: TTCDeliver; Sequence: Longword);
var
  logstr: string;
begin
  logstr := '[' + datetimetostr(now) + '](Deliver):';
  logstr := logstr + xDeliver.MsgID + #32;
  logstr := logstr + inttostr(xDeliver.IsReport) + #32;
  logstr := logstr + inttostr(xDeliver.MsgFormat) + #32;
  logstr := logstr + xDeliver.RecvTime + #32;
  logstr := logstr + xDeliver.SrcTermID + #32;
  logstr := logstr + xDeliver.DestTermID + #32;
  logstr := logstr + xDeliver.MsgContent + #32;
  logstr := logstr + 'ListID:' + inttostr(Sequence);
  LogList.AddLog('01' + logstr);
end;

procedure TSPDeliverThread.SendDeliver;
var
  aList: TList;
  PackegLen: integer;
  XML: string;
  pDeliver: PCTDeliver;
  empty: boolean;
  SequenceID: word;
  destID: string;
  xDeliver: TTCDeliver;
begin
  empty := False;
  pDeliver := nil;
  FillChar(xDeliver, SizeOf(TTCDeliver), 0); // clear 0
  FillChar(SMLDeliver.Body, SizeOf(SMLDeliver.Body), 0); // clear 0
  aList := DeliverList.LockList;
  try
    if aList.Count > 0 then
    begin
      pDeliver := PCTDeliver(aList.First); //取上行短信
      xDeliver := pDeliver^;
      aList.Delete(0);
    end
    else
      empty := True;
  finally
    DeliverList.UnlockList;
  end;
  if empty then exit; //队列中无数据退出过程
  
  {if xDeliver.IsReport = 9 then SequenceID := FeeSequence_ID //包月/定制用户拆机信息
  else if xDeliver.DestTermID = '' then
    SequenceID := defSequence_id
  else
  begin
    SequenceID := GetSequenceID(xDeliver.DestTermID, trim(xDeliver.MsgContent)); //根据服务号查找业务队列号
  end;}
  if xDeliver.IsReport = 9 then
    SMLDeliver.Header.Sequence_ID := 2999;
  XML := WriteDeliver(xDeliver); //生成XML包
  if XML = '' then exit;
  //SMLDeliver.Header.Sequence_ID := SequenceID;
  PackegLen := length(XML) + SizeOf(CTSMSHeader); //消息长度
  SMLDeliver.Header.Total_Length := PackegLen;
  strpcopy(SMLDeliver.Body, XML);
  if Terminated then
  begin
    DeliverList.Add(pDeliver);
    exit;
  end;
  try
    if TcpDeliver.Connect then
    begin //连接中间层
      if PackegLen = TcpDeliver.SendBuf(SMLDeliver, PackegLen) then {//发送}
      begin
        if TcpDeliver.WaitForData(ftimeout) then
        begin
          TcpDeliver.ReceiveBuf(Receive, SizeOf(Receive)); //等待中间服务器返回
          if Receive.Status_ID = 21 then
          begin {发送成功}
            Dispose(pDeliver);
            addcou;
            wlogtxt(xDeliver, SequenceID); //-----
            StatuStr := '【' + datetimetostr(now) + '】(Deliver):' + xDeliver.MsgID + #32 + xDeliver.MsgContent + #32 + xDeliver.DestTermID + #32 + 'Send To:' + inttostr(DeliverSequence);
            synchronize(upmemo);
          end
          else
          begin {中间层接收失败}
            DeliverList.Add(pDeliver);
            StatuEStr := '【' + datetimetostr(now()) + '】GateWay-->Server Deliver Error Status_ID:' + inttostr(Receive.Status_ID);
            if Receive.Status_ID = 13 then Warning := FullWarnning.create;
            sleep(5000);
            synchronize(showError);
          end;
        end
        else
        begin {连接超时}
          DeliverList.Add(pDeliver);
          StatuEStr := '【' + datetimetostr(now()) + '】GateWay-->Server Deliver Connect Timeout';
          synchronize(showError);
        end;
      end
      else {发送失败}
        DeliverList.Add(pDeliver);
    end
    else {连接失败}
      DeliverList.Add(pDeliver);
  finally
    TcpDeliver.Close;
  end;
  //TestSendDeliver(PackegLen);
end;

procedure TSPDeliverThread.SocketError(Sender: TObject;
  SocketError: integer);
begin
  addError;
  StatuEStr := '【' + datetimetostr(now) + '】GateWay-->server Deliver SocketError: ' + inttostr(SocketError);
  SocketError := 0;
  synchronize(showError);
end;
procedure TSPDeliverThread.upmemo;
begin
  if SMGPGateWay.Memo2.Lines.Count > 400 then SMGPGateWay.Memo2.Clear;
  if SMGPGateWay.N3.Checked then
    SMGPGateWay.Memo2.Lines.Add(StatuStr + #13#10);
  SMGPGateWay.StatusBar1.Panels[11].Text := 'T:' + inttostr(GDToS_cou) + 'E:' + inttostr(SPdeliError);
end;
procedure TSPDeliverThread.showError;
begin
  if SMGPGateWay.Memo2.Lines.Count > 400 then SMGPGateWay.Memo2.Clear;
  if SMGPGateWay.N2.Checked then
    SMGPGateWay.Memo2.Lines.Add(StatuEStr + #13#10);
end;
procedure TSPDeliverThread.addcou;
begin
  if GDToS_cou > 2147483600 then GDToS_cou := 0
  else
    inc(GDToS_cou);
end;

procedure TSPDeliverThread.addError;
begin
  if SPdeliError > 20000 then SPdeliError := 0
  else
    inc(SPdeliError);
end;
procedure TSPDeliverThread.upcreatestr;
begin
  SMGPGateWay.Memo3.Lines.Add(Createstr);
end;

procedure TSPDeliverThread.TestSendDeliver(PackegLen: Longword);
begin
  SMLDeliver.Header.Sequence_ID := DeliverSequence; //平台整理后队列（固定队列）
  try
    if TcpDeliver.Connect then
      if PackegLen = TcpDeliver.SendBuf(SMLDeliver, PackegLen) then {//发送}
        if TcpDeliver.WaitForData(ftimeout) then
          TcpDeliver.ReceiveBuf(Receive, SizeOf(Receive)); //等待中间服务器返回
  finally
    TcpDeliver.Close;
  end;
end;

end.

