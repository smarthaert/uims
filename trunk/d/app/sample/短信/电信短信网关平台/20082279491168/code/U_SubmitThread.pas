{－－－－－－－－－－－－－－－－－－－－－－－－}
{           向中间服务器请求SUBMIT线程           }
{               Author: LUOXINXI                 }
{                DateTime: 2004/3/11             }
{－－－－－－－－－－－－－－－－－－－－－－－－}
unit U_SubmitThread;

interface
uses
  windows,
  classes,
  Sockets,
  U_MsgInfo,
  Smgp13_XML,
  StrUtils,
  SysUtils,
  U_SysConfig;
type
  TSubmitThread = class(TThread)
  private
    TcpSubmit: TTcpClient;
    xmlSubmit: TSPPack; //从中间服务器接收SUBMIT 短信
    SMSReq: CTSMSHeader; //向中间服务器请求数据
    Response: boolean;
    ftimeout: integer;
    fsleeptime: integer;
    statustr: string;
    StatuEstr: string;
    SendLen: integer;
    Createstr: string;
    StopSubmitTimes:integer;
  protected
    procedure execute; override;
    procedure upmemo;
    procedure upCreatestr;
    procedure showError;
    procedure catchsubmit; //向中间服务器请求数据
    procedure madesubmit(aSubmit: TTCSubmit); //生成下发短信格式
    procedure madeSecondSubmit(aSubmit: TTCSubmit; SecondMsg: string);
    procedure SocketError(Sender: TObject; SocketError: integer);
    function countchar(const Str: string): integer; //统计汉字字节数
    function countChina(const Str: string): integer; // 统计汉字个数
    procedure SplitPack(Source: string; var First, Second: string);
    procedure addSCou;
    procedure addE;

    procedure SaveToDeliverList();
  public
    constructor create(hostip, hostport: string; sleeptime, timeout: integer); virtual;
    destructor destroy; override;
  end;
implementation
uses U_main;
{ TSubmitThread }
constructor TSubmitThread.create(hostip, hostport: string; sleeptime, timeout: integer);
begin
  inherited create(True);
  FreeOnTerminate := True;
  TcpSubmit := TTcpClient.create(nil);
  TcpSubmit.RemoteHost := hostip;
  TcpSubmit.RemotePort := hostport;
  TcpSubmit.OnError := SocketError;
  ftimeout := timeout;
  fsleeptime := sleeptime;
  Createstr := '【' + datetimetostr(now) + '】请求下行短信线程创建成功,服务器IP:' + hostip + ',ThreadID:' + inttostr(self.ThreadID);
  synchronize(upCreatestr);
  Resume;
end;

destructor TSubmitThread.destroy;
begin
  FreeAndNil(TcpSubmit);
  GSubmitTList.Remove(self);
  Createstr := '【' + datetimetostr(now) + '】请求下行短信线程停止,ThreadID:' + inttostr(self.ThreadID);
  synchronize(upCreatestr);
  SMGPGateWay.TBSubmitReq.Tag := 0;
  SMGPGateWay.TBSubmitReq.Caption := 'Start Request'; // SMGPGateWay.TBDToS.Update;
  LogList.AddLog('10' + Createstr);
  inherited;
end;

procedure TSubmitThread.execute;
var
  Status_ID, Version: string;
  Command_ID, Sequence_ID: word;
begin
  inherited;
  Fillchar(SMSReq, sizeof(CTSMSHeader), 0);
  readProto(Status_ID, Version, Response);
  readSsequence(Sequence_ID, Command_ID);
  SMSReq.Command_ID := Command_ID;
  SMSReq.Status_ID := strtoint(Status_ID);
  SMSReq.Sequence_ID := Sequence_ID;
  SMSReq.Version := strtoint(Version);
  SendLen := sizeof(CTSMSHeader);
  SMSReq.Total_Length := SendLen;
  StopSubmitTimes := 0;
  while not Terminated do
  begin
    Fillchar(xmlSubmit, sizeof(TSPPack), 0);
    if StopCatchSMS then
    begin
      statustr := '【' + datetimetostr(now) + '】与电信连接断开,暂停从中间层读取数据';
      synchronize(upmemo);
      sleep(2000);//停2秒
      inc(StopSubmitTimes); //当StopSubmitTimes = 900 得时候发送上行警报
      if StopSubmitTimes = 900 then SaveToDeliverList;
      continue;
    end; 
    try
      catchsubmit; //请求短信
    except
    end;
    sleep(fsleeptime);
  end;
end;
procedure TSubmitThread.catchsubmit;
var
  //aSubmit: xSubmit; //生成下发短信
  aSubmit: TTCSubmit;
begin
  try
    if TcpSubmit.Connect then
    begin
      Fillchar(aSubmit, sizeof(TTCSubmit), 0);
      if self.Terminated then exit;
      if SendLen = TcpSubmit.SendBuf(SMSReq, SendLen) then
        if TcpSubmit.WaitForData(ftimeout) then
        begin
          if SendLen = TcpSubmit.ReceiveBuf(xmlSubmit.Header, SendLen) then //接收包头
            case xmlSubmit.Header.Status_ID of
              11:
                if TcpSubmit.WaitForData(ftimeout) then
                  if (xmlSubmit.Header.Total_Length - SendLen) = TcpSubmit.ReceiveBuf(xmlSubmit.body, (xmlSubmit.Header.Total_Length - SendLen)) then
                  begin
                    addSCou;
                    if not ReadSubmit(xmlSubmit.body, aSubmit) then exit;
                    madesubmit(aSubmit);
                    synchronize(upmemo);
                    if Response then
                    begin
                      SMSReq.Status_ID := 31; SMSReq.Sequence_ID := xmlSubmit.Header.Sequence_ID;
                      TcpSubmit.SendBuf(SMSReq, SendLen);
                    end;
                  end
                  else
                    if Response then
                    begin
                      SMSReq.Status_ID := 32;
                      SMSReq.Sequence_ID := xmlSubmit.Header.Sequence_ID;
                      TcpSubmit.SendBuf(SMSReq, SendLen);
                    end;
            else
              begin
                StatuEstr := '【' + datetimetostr(now()) + '】Server-->GateWay Submit Status_ID:' + inttostr(xmlSubmit.Header.Status_ID);
                synchronize(showError);
                sleep(1000);
              end;
            end;
        end;
    end
    else
    begin
      StatuEstr := '【' + datetimetostr(now()) + '】Server-->GateWay Submit Connect Timeout';
      synchronize(showError);
    end;
  finally
    TcpSubmit.Close;
  end;
end;

procedure TSubmitThread.madesubmit(aSubmit: TTCSubmit);
var
  PSubmit: PxSubmit;
  First, Second: string;
  s: string;
begin
  if (aSubmit.MsgContent = '') and (aSubmit.MsgType < 8) then
  begin
    statustr := '【' + datetimetostr(now) + '】Server-->GateWay Submit Error:下行短信内容空,MsgType:' + inttostr(aSubmit.MsgType) + ',MID:' + aSubmit.Mid; LogList.AddLog('09' + statustr); exit; end;
  if aSubmit.DestTermID = '' then
  begin
    statustr := '【' + datetimetostr(now) + '】Server-->GateWay Submit Error:下行短信目的号码空,MID:' + aSubmit.Mid; LogList.AddLog('09' + statustr); exit; end;
  if aSubmit.ServiceID = '' then
  begin
    statustr := '【' + datetimetostr(now) + '】Server-->GateWay Submit Error:业务代码空,MID:' + aSubmit.Mid; LogList.AddLog('09' + statustr); exit; end;
  if  not StrUtils.AnsiStartsText( SPID,aSubmit.SrcTermID) then
  begin
    statustr := '【' + datetimetostr(now) + '】Server-->GateWay Submit Error:服务代码有误,MID:' + aSubmit.Mid; LogList.AddLog('09' + statustr); exit; end;
  new(PSubmit);
  PSubmit^.Resend := 0;
  PSubmit^.SequenceID := 0;
  PSubmit^.Then_DateTime := 0;
  PSubmit^.sSubmit.Mid := aSubmit.Mid;
  PSubmit^.sSubmit.MsgType := aSubmit.MsgType;
  PSubmit^.sSubmit.NeedReport := aSubmit.NeedReport;
  PSubmit^.sSubmit.Priority := aSubmit.NeedReport;
  PSubmit^.sSubmit.ServiceID := aSubmit.ServiceID;
  PSubmit^.sSubmit.FeeType := aSubmit.FeeType;
  PSubmit^.sSubmit.FeeCode := aSubmit.FeeCode;
  PSubmit^.sSubmit.FixedFee := aSubmit.FixedFee;
  PSubmit^.sSubmit.MsgFormat := aSubmit.MsgFormat;
  if aSubmit.ValidTime <> '' then //2.0协议升级部分
    PSubmit^.sSubmit.ValidTime := aSubmit.ValidTime + '000R';
  if aSubmit.AtTime <> '' then //2.0协议升级部分
    PSubmit^.sSubmit.AtTime := aSubmit.AtTime + '000R';
  PSubmit^.sSubmit.SrcTermID := aSubmit.SrcTermID; //
  PSubmit^.sSubmit.ChargeTermID := aSubmit.ChargeTermID; //
  PSubmit^.sSubmit.DestTermIDCount := aSubmit.DestTermIDCount;
  PSubmit^.sSubmit.DestTermID := aSubmit.DestTermID;
  PSubmit^.sSubmit.MsgLength := aSubmit.MsgLength;
  PSubmit^.sSubmit.LinkID := aSubmit.LinkID;
  //短信内容是否超出250字符
  aSubmit.MsgContent := StringReplace(aSubmit.MsgContent, #13, '', [rfReplaceAll]); //去除回车符
  if LengTh(aSubmit.MsgContent) > 250 then
  begin
    SplitPack(aSubmit.MsgContent, First, Second);
    madeSecondSubmit(aSubmit, First); //第一包
    PSubmit^.sSubmit.MsgContent := Second; //第二包
    PSubmit^.sSubmit.MsgLength := LengTh(Second);
    s := #32#32'网关提醒:该包信息内容过长,系统已作分包下行处理';
  end
  else
    PSubmit^.sSubmit.MsgContent := aSubmit.MsgContent;
  PSubmit^.sSubmit.SubmitMsgType := 0; //正常的点播信息
  if (aSubmit.MsgContent = '00000')or(AnsiPos('QX ',aSubmit.MsgContent)>0) then     //endo add
    PSubmit^.sSubmit.SubmitMsgType := 13;  //反向取消定制 该值为13

  SubmitList.Add(PSubmit);
  statustr := '[' + datetimetostr(now) + '](Submit):';
  statustr := statustr + PSubmit^.sSubmit.Mid + #32;
  statustr := statustr + inttostr(PSubmit^.sSubmit.MsgType) + #32;
  statustr := statustr + inttostr(PSubmit^.sSubmit.NeedReport) + #32;
  statustr := statustr + PSubmit^.sSubmit.FeeType + #32;
  statustr := statustr + PSubmit^.sSubmit.FeeCode + #32;
  statustr := statustr + PSubmit^.sSubmit.ServiceID + #32;
  statustr := statustr + PSubmit^.sSubmit.SrcTermID + #32;
  statustr := statustr + inttostr(PSubmit^.sSubmit.DestTermIDCount) + #32;
  statustr := statustr + PSubmit^.sSubmit.ChargeTermID + #32;
  statustr := statustr + PSubmit^.sSubmit.DestTermID + #32;
  statustr := statustr + aSubmit.MsgContent + s;
  LogList.AddLog('06' + statustr);
end;
procedure TSubmitThread.madeSecondSubmit(aSubmit: TTCSubmit;
  SecondMsg: string);
var
  PSubmit: PxSubmit;
begin
  new(PSubmit);
  PSubmit^.Resend := 0;
  PSubmit^.SequenceID := 0;
  PSubmit^.Then_DateTime := 0;
  PSubmit^.sSubmit.Mid := aSubmit.Mid;
  PSubmit^.sSubmit.MsgType := aSubmit.MsgType;
  PSubmit^.sSubmit.NeedReport := aSubmit.NeedReport;
  PSubmit^.sSubmit.Priority := aSubmit.NeedReport;
  PSubmit^.sSubmit.ServiceID := aSubmit.ServiceID;
  PSubmit^.sSubmit.FeeType := aSubmit.FeeType;
  PSubmit^.sSubmit.FeeCode := aSubmit.FeeCode;
  PSubmit^.sSubmit.FixedFee := aSubmit.FixedFee;
  PSubmit^.sSubmit.MsgFormat := aSubmit.MsgFormat;
  //PSubmit^.sSubmit.ValidTime := aSubmit.ValidTime;
  //PSubmit^.sSubmit.AtTime := aSubmit.AtTime;
   if aSubmit.ValidTime <> '' then //2.0协议升级部分
    PSubmit^.sSubmit.ValidTime := aSubmit.ValidTime + '000R';
  if aSubmit.AtTime <> '' then //2.0协议升级部分
    PSubmit^.sSubmit.AtTime := aSubmit.AtTime + '000R';
    
  PSubmit^.sSubmit.SrcTermID := aSubmit.SrcTermID; //
  PSubmit^.sSubmit.ChargeTermID := aSubmit.ChargeTermID; //
  PSubmit^.sSubmit.DestTermIDCount := aSubmit.DestTermIDCount;
  PSubmit^.sSubmit.DestTermID := aSubmit.DestTermID;
  PSubmit^.sSubmit.MsgLength := LengTh(SecondMsg);
  PSubmit^.sSubmit.MsgContent := SecondMsg;
  PSubmit^.sSubmit.LinkID := aSubmit.LinkID;
  SubmitList.Add(PSubmit);
end;

procedure TSubmitThread.SocketError(Sender: TObject; SocketError: integer);
begin
  StatuEstr := '【' + datetimetostr(now) + '】请求短信Disconnect, SocketError: ' + inttostr(SocketError);
  SocketError := 0;
  addE;
  synchronize(showError);
end;
procedure TSubmitThread.addE;
begin
  if SToG_E > 20000 then SToG_E := 0
  else
    inc(SToG_E);
end;

procedure TSubmitThread.addSCou;
begin
  if SToG_cou > 2147483600 then SToG_cou := 0
  else
    inc(SToG_cou);
end;
procedure TSubmitThread.upmemo;
begin
  if SMGPGateWay.Memo2.Lines.Count > 400 then SMGPGateWay.Memo2.Clear;
  if SMGPGateWay.N3.Checked then
    SMGPGateWay.Memo2.Lines.Add(statustr + #13#10);
  SMGPGateWay.StatusBar1.Panels[9].Text := 'T:' + inttostr(SToG_cou) + 'E:' + inttostr(SToG_E);
  SMGPGateWay.StatusBar1.Refresh;
end;

procedure TSubmitThread.showError;
begin
  if SMGPGateWay.Memo2.Lines.Count > 400 then SMGPGateWay.Memo2.Clear;
  if SMGPGateWay.N2.Checked then
    SMGPGateWay.Memo2.Lines.Add(StatuEstr + #13#10);
end;
procedure TSubmitThread.upCreatestr;
begin
  SMGPGateWay.Memo3.Lines.Add(Createstr);
end;

function TSubmitThread.countchar(const Str: string): integer;
var
  i: integer;
  TmpStr: string;
begin
  TmpStr := trim(Str);
  Result := 0;
  i := 0;
  while (i <= LengTh(TmpStr)) and (LengTh(TmpStr) > 0) do
  begin
    inc(i);
    //英文字符
    if ord(TmpStr[i]) >= 128 then //中文字符
    begin
      inc(Result); //汉字字数加1
    end;
  end;
end;

function TSubmitThread.countChina(const Str: string): integer;
var
  i: integer;
  TmpStr: string;
begin
  TmpStr := trim(Str);
  Result := 0;
  i := 0;
  while (i <= LengTh(TmpStr)) and (LengTh(TmpStr) > 0) do
  begin
    inc(i);
    if ((i + 1) > LengTh(TmpStr)) then exit; //
    if (ord(TmpStr[i]) >= 128) and (ord(TmpStr[i + 1]) >= 128) then //中文字符
    begin
      inc(i);
      inc(Result); //汉字字符加1
    end;
  end;
end;
//拆短信  --当短信过长的时候分成2条短信下发 248个字节
procedure TSubmitThread.SplitPack(Source: string; var First,
  Second: string);
begin
  if ord(Source[248]) >= 128 then //汉字字节
  begin
    if (countchar(copy(Source, 1, 248)) mod 2) = 0 then //偶数个汉字字节
    begin
      First := copy(Source, 1, 248);
      Second := copy(Source, 249, LengTh(Source) - 248);
    end
    else //奇数
    begin
      if (countChina(copy(Source, 1, 248)) mod 2) = 0 then //偶数个汉字
      begin
        First := copy(Source, 1, 247);
        Second := copy(Source, 248, LengTh(Source) - 247);
      end
      else //奇数个汉字
      begin
        First := copy(Source, 1, 249);
        Second := copy(Source, 250, LengTh(Source) - 249);
      end;
    end;
  end
  else //非汉字字节
  begin
    First := copy(Source, 1, 248);
    Second := copy(Source, 249, LengTh(Source) - 248);
  end;
end;

procedure TSubmitThread.SaveToDeliverList(); //短信
var
  pDeliver: PCTDeliver;
begin
  new(pDeliver);
  pDeliver^.Msgid := '1190000000000';
  pDeliver^.IsReport := 0;
  pDeliver^.MsgFormat := 15;
  pDeliver^.RecvTime := formatdatetime('yymmddhhnnss', now);
  pDeliver^.SrcTermID := '1189109';
  pDeliver^.DestTermID := '1189109';
  pDeliver^.MsgLength := 0;
  pDeliver^.MsgContent := 'Warnning:福建电信3.0 网络故障持续30分钟,请检查网络鼓掌原因';
  pDeliver^.LinkID:='';
  pDeliver^.LinkID := '';
  DeliverList.Add(pDeliver); //放入DELIVER队列中
  StopSubmitTimes := 0;
end;

end.

