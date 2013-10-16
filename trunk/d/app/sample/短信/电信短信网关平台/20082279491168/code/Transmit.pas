{－－－－－－－－－－－－－－－－－－－－－－－－}
{                  Transmit线程(收发模式)        }
{                    Author:  LUOXINXI           }
{                    DateTime: 2004/7/28         }
{－－－－－－－－－－－－－－－－－－－－－－－－}
unit Transmit;

interface
uses
  Windows, classes, Sockets, U_MsgInfo, Smgp13_XML, U_RequestID, Htonl, SysUtils,
  winsock, ScktComp, md5, NetDisconnect, DateUtils,strutils;

{收发 Thread}
type
  TTransmit = class(TThread)
  private
    CTDeliver: TTcpClient; //socket 连接
    Statustr: string;
    StatuTxt: string;
    StatustrE: string;
    fsleeptime: integer;
    ClientID: string;
    sharesecret: string;
    loginmode: byte;
    timeout: integer;
    HadLogin: boolean;
    Active_test_time: TDateTime; //integer;
    Warnning: byte;
    resptime, sendtimes: integer;
    ErrWarnning: TWarnning; //上行链路出错时警报
    CTSubmit_Resp: TSMGPDeliver_Resp; //回馈报告
    SocketBuff: array of char;
    SockCanExit: boolean;
    ReceiveDeliverTime: TDateTime;
  protected
    procedure Execute; override;
    procedure LoginCT; {登陆过程}
    function ExitCT: boolean; {退出过程}

    procedure ReceiveHead;
    procedure ReceiveBody(CTRequestID, CTsequence, Len: Longword);

    procedure ActiveTest; {链路测试}
    procedure ActiveTest_Resp(CTsequence: Longword); {链路测试回复}
    procedure SocketError(Sender: TObject;
      SocketError: integer);
    procedure SP_Deliver_Resp(Msg_id: array of char; SequenceID: Longword); {上行回复}
    procedure WriteReport(const Msgid: array of char; const Source: array of char); {写状态报告}
    procedure SaveToDeliverList(aDeliver: TCTDeliver; const LinkID:string); {保存上行短信}
    procedure ShowDeliver(aDeliver: TCTDeliver; const LinkID:string); {上行包记录}
    function SP_Submit: boolean; {下行短信}
    procedure ReSubmit(SequenceID: Longword; statu: Longword); {重发}
    function DeleteMT(SequenceID: Longword; var aMid: string): boolean; {删除下行短信缓冲区短信,返回MID}
    function MakeSockBuff(var SubmitLen: integer; rSubmit: xSubmit): Longword; //设置socket传输消息 返回值是该消息序列号
    procedure NoResponse_Resubmit; //在指定时间没有返回回馈报告的重发
    procedure upmemo;
    procedure showError;
    procedure showstatu;
    procedure AddsSeq;
    procedure AddCou;

    procedure ReceiveDeliver(CTsequence, Len: Longword);
    function ReceiveTLVMsg(const MsgLen:integer;var LinkID:string;var DealReslt:byte):byte;// SubmitMsgType.value
    procedure AddSyncOrdCelMsg(aDeliver: TCTDeliver;const LinkID:string);
    procedure DealWithSyncMsgCont(const msgcontent:string; var ServiceID, MsgContPart:string);
    function GetInstruct(const msgcontent:string):string;
  public
    constructor create(xCT_IP, xCT_port, xClientID, xsharesecret: string; xsleeptime, xtimeout, xresptime, xsendtimes: integer; xloginmode: byte); virtual;
    destructor destroy; override;
  end;

implementation
uses U_Main;

{ TCPCTDeliver }
constructor TTransmit.create(xCT_IP, xCT_port, xClientID, xsharesecret: string; xsleeptime, xtimeout, xresptime, xsendtimes: integer; xloginmode: byte);
begin
  inherited create(True);
  FreeOnTerminate := True;
  CTDeliver := TTcpClient.create(nil);
  CTDeliver.RemoteHost := xCT_IP;
  CTDeliver.RemotePort := xCT_port;
  CTDeliver.OnError := SocketError;
  ClientID := xClientID;
  sharesecret := xsharesecret;
  fsleeptime := xsleeptime;
  timeout := xtimeout;
  loginmode := xloginmode;
  sendtimes := xsendtimes;
  loginmode := xloginmode;
  StatuTxt := '【' + datetimetostr(now) + '】收发线程创建,电信网关服务器' + xCT_IP + ',ThreadID:' + inttostr(self.ThreadID);
  synchronize(showstatu);
  Resume;
end;

destructor TTransmit.destroy;
begin
  StopCatchSMS := True;
  FreeAndNil(CTDeliver);
  SocketBuff := nil;
  StatuTxt := '【' + datetimetostr(now) + '】收发线程中止,ThreadID:' + inttostr(self.ThreadID);
  synchronize(showstatu);
  LogList.AddLog('10' + StatuTxt);
  SMGPGateWay.Label8.Caption := 'Warning:收发线程停止';
  inherited;
end;
procedure TTransmit.Execute;
begin
  HadLogin := False;
  Warnning := 0;
  while not Terminated do
  try
    if not HadLogin then
    begin
      if TransmitExit then
      begin
        TransmitExit := False;
        break;
      end;
      LoginCT; //登陆
    end
    else
    begin //已经登陆
      if TransmitExit then //如果发送退出命令
      begin
        if HadLogin then
        begin
          ExitCT; //发送退出命令
        end
        else
        begin
          TransmitExit := False;
          break;
        end;
      end
      else
      begin
        NoResponse_Resubmit;
        if not SP_Submit then
          ActiveTest; //发送链路测试
      end;
      ReceiveHead; //接收包头 调用接收包体过程
      if SockCanExit then
      begin
        TransmitExit := False;
        break;
      end;
      sleep(fsleeptime);
    end;
  except
    on e: exception do
    begin
      Statustr := '[' + datetimetostr(now) + ']' + 'Thread Error:' + e.Message;
      LogList.AddLog('10' + Statustr);
      upmemo;
    end;
  end;
end;

procedure TTransmit.LoginCT;
var
  xLogin: TLogin;
  xLogin_resp: TSMGPLogin_resp;
  Head: TSMGPHead;
  timestr: string;
  str1: string;
  md5str: md5digest;
  md5_con: MD5Context;
  temp: Longword;
  Status: Longword;
begin
  HadLogin := False;
  FillChar(xLogin, sizeof(TLogin), 0);
  FillChar(Head, sizeof(TSMGPHead), 0);
  FillChar(xLogin_resp, sizeof(TSMGPLogin_resp), 0);
  with xLogin do
  begin
    Head.PacketLength := winsock.Htonl(sizeof(TLogin));
    Head.RequestID := winsock.Htonl(Login);
    Head.SequenceID := winsock.Htonl(sSequence);
    strpcopy(body.ClientID, ClientID);
    body.Version := GetVision; //系统支持的版本号$13;
    body.loginmode := loginmode;
    DateTimeToString(timestr, 'MMDDHHMMSS', now); //时间转换为字符串
    xLogin.body.Timestamp := winsock.Htonl(StrToInt(timestr)); //字节系转换
    //MD5加密认证
    str1 := ClientID + #0#0#0#0#0#0#0 + sharesecret + timestr; //用户名＋密码＋7个#0＋登陆密码+时间
    MD5Init(md5_con); //初始化md5_con
    MD5Update(md5_con, pchar(str1), length(str1)); //MD5加密
    MD5Final(md5_con, md5str);
    move(md5str, body.AuthenticatorClient, 16); //复制到消息包中的"AuthenticatorClient"字段
  end;
  try
    CTDeliver.Close;
  except
  end;
  try
    if CTDeliver.Connect then
      if sizeof(TLogin) = CTDeliver.SendBuf(xLogin, sizeof(xLogin), 0) then
      begin {//发送}
        AddsSeq;
        StatuTxt := '【' + datetimetostr(now()) + '】SP-->CTLoginCT Request 发送登陆请求...';
        synchronize(showstatu);
        if CTDeliver.WaitForData(timeout) then
        begin
          if sizeof(TSMGPHead) = CTDeliver.ReceiveBuf(Head, sizeof(TSMGPHead), 0) then
          begin {//收头}
            Active_test_time := now; //StrToInt(formatdatetime('ss', now)); //登陆回复时间
            temp := winsock.Htonl(Head.RequestID);
            if Login_resp = temp then
              if CTDeliver.WaitForData(timeout) then
              begin
                if sizeof(TSMGPLogin_resp) = CTDeliver.ReceiveBuf(xLogin_resp, sizeof(TSMGPLogin_resp), 0) then
                begin
                  Status := HostToNet(xLogin_resp.Status);
                  case Status of
                    0:
                      begin
                        StatuTxt := '【' + datetimetostr(now()) + '】Login_Resp-->成功登陆中国电信'; HadLogin := True; Warnning := 0; DCanExit := False; TransmitExit := False; StopCatchSMS := False; ReceiveDeliverTime := now; Counter := 0; end;
                    1:
                      begin
                        StatuTxt := '【' + datetimetostr(now()) + '】Login_Resp-->电信回复系统忙，请稍候再拨'; CTDeliver.Close; sleep(RetryTime); StopCatchSMS := True; end;
                    21:
                      begin
                        StatuTxt := '【' + datetimetostr(now()) + '】Login_Resp-->电信回复认证错误！！！'; CTDeliver.Close; sleep(RetryTime); StopCatchSMS := True; end;
                  else
                    begin
                      StatuTxt := '【' + datetimetostr(now()) + '】Login_Resp-->电信回复鉴别客户端接入请求状态 ' + inttostr(Status); CTDeliver.Close; sleep(RetryTime); StopCatchSMS := True; end;
                  end;
                  LogList.AddLog('10' + StatuTxt);
                end;
              end
              else
              begin
                StatuTxt := '【' + datetimetostr(now()) + '】请求连接超时,链路关闭,等待' + inttostr(RetryTime div 1000) + '重新登陆...'; CTDeliver.Close; sleep(RetryTime); end;
          end;
        end
        else
        begin
          StatuTxt := '【' + datetimetostr(now()) + '】请求连接超时,链路关闭,等待' + inttostr(RetryTime div 1000) + '秒重新登陆...'; CTDeliver.Close; sleep(RetryTime); end;
        synchronize(showstatu);
      end;
  except
  end;
end;

procedure TTransmit.ActiveTest;
var
  ActiveTest: TSMGPHead;
begin
  FillChar(ActiveTest, sizeof(TSMGPHead), 0);
  if CTDeliver.Connected then
  begin
    if DateUtils.SecondsBetween(now, Active_test_time) >= (ActiveTestTime div 1000) then
    begin
      with ActiveTest do
      begin
        ActiveTest.PacketLength := HostToNet(sizeof(TSMGPHead));
        ActiveTest.RequestID := HostToNet(Active_test);
        ActiveTest.SequenceID := HostToNet(sSequence);
      end;
      if sizeof(TSMGPHead) = CTDeliver.SendBuf(ActiveTest, sizeof(TSMGPHead), 0) then
      begin
        AddsSeq;
        StatuTxt := '【' + datetimetostr(now()) + '】ActiveTest 发送链路检测包 ' + inttostr(HostToNet(ActiveTest.SequenceID));
        synchronize(showstatu);
      end;
    end;
  end;
end;

function TTransmit.ExitCT: boolean;
var
  SMGPExit: TSMGPHead;
  SMGPExit_Resp: TSMGPHead;
  temp: Longword;
begin
  Result := False;
  FillChar(SMGPExit, sizeof(TSMGPHead), 0);
  with SMGPExit do
  begin
    SMGPExit.PacketLength := HostToNet(sizeof(TSMGPHead));
    SMGPExit.RequestID := HostToNet(xExit);
    SMGPExit.SequenceID := HostToNet(sSequence);
  end;
  try
    if HadLogin then
      if sizeof(TSMGPHead) = CTDeliver.SendBuf(SMGPExit, sizeof(TSMGPHead), 0) then
      begin
        AddsSeq;
        StatuTxt := '【' + datetimetostr(now()) + '】SP-->CT ExitCT Request 发送退出请求...';
        synchronize(showstatu);
      end;
    if CTDeliver.WaitForData(timeout) then
    begin
      if sizeof(TSMGPHead) = CTDeliver.ReceiveBuf(SMGPExit_Resp, sizeof(TSMGPHead), 0) then
      begin
        temp := HostToNet(SMGPExit_Resp.RequestID);
        if temp = Exit_resp then
        begin
          CTDeliver.Close;
          Result := True;
          DCanExit := True;
          StatuTxt := '【' + datetimetostr(now()) + '】ExitCT 退出与电信的连接';
          synchronize(showstatu);
        end;
      end;
    end
    else
    begin
      CTDeliver.Close;
      DCanExit := True;
      Result := True;
      StatuTxt := '【' + datetimetostr(now()) + '】ExitCT Request 发送退出请求超时，连接已经关闭';
      synchronize(showstatu);
    end;
  except
  end;
end;

procedure TTransmit.SocketError(Sender: TObject; SocketError: integer);
var
  Error: integer;
begin
  Error := SocketError;
  SocketError := 0;
  DCanExit := True;
  StatuTxt := '【' + datetimetostr(now) + '】链路发生网络故障' + inttostr(Error) + ',等待' + inttostr(RetryTime div 1000) + '秒再次登陆...';
  StopCatchSMS := True;
  synchronize(showstatu);
  LogList.AddLog('10' + StatuTxt);
  inc(Warnning);
  if Warnning > 10 then ErrWarnning := TWarnning.create;
  HadLogin := False;
  sleep(RetryTime);
end;


procedure TTransmit.ActiveTest_Resp(CTsequence: Longword);
var
  spActiveTest_Resp: TSMGPHead;
begin
  FillChar(spActiveTest_Resp, sizeof(TSMGPHead), 0);
  spActiveTest_Resp.SequenceID := HostToNet(CTsequence);
  spActiveTest_Resp.PacketLength := HostToNet(sizeof(TSMGPHead));
  spActiveTest_Resp.RequestID := HostToNet(Active_test_resp);
  if CTDeliver.Active then
    if sizeof(TSMGPHead) = CTDeliver.SendBuf(spActiveTest_Resp, sizeof(TSMGPHead)) then
    begin
      StatuTxt := '【' + datetimetostr(now()) + '】SP-->CT ActiveTest_Resp SP回复链路正常... ' + inttostr(CTsequence);
      synchronize(showstatu);
    end;
end;

procedure TTransmit.upmemo;
begin
  if SMGPGateWay.MeMO1.Lines.count > 500 then SMGPGateWay.MeMO1.Clear;
  if SMGPGateWay.N3.Checked then
    SMGPGateWay.MeMO1.Lines.Add(Statustr + #13#10);
  SMGPGateWay.StatusBar1.Panels[1].Text := 'T: ' + inttostr(CTD_cou);
  SMGPGateWay.StatusBar1.Refresh;
end;

procedure TTransmit.showError;
begin
  if SMGPGateWay.MeMO1.Lines.count > 500 then SMGPGateWay.MeMO1.Clear;
  if SMGPGateWay.N2.Checked then
    SMGPGateWay.MeMO1.Lines.Add(StatustrE + #13#10);
end;
procedure TTransmit.showstatu;
begin
  if SMGPGateWay.MeMO3.Lines.count > 1000 then SMGPGateWay.MeMO3.Clear;
  SMGPGateWay.MeMO3.Lines.Add(StatuTxt);
end;

procedure TTransmit.AddCou;
begin
  if CTD_cou > 2147483600 then CTD_cou := 1;
  inc(CTD_cou);
end;

procedure TTransmit.AddsSeq;
begin
  if sSequence >= 4294967200 then sSequence := 1;
  sSequence := sSequence + 1;
end;

procedure TTransmit.WriteReport(const Msgid: array of char; const Source: array of char);
var
  CTReport: PReport;
  buff: array[0..19] of char;
  temp: string;
begin
  FillChar(buff, sizeof(buff), 0);
  new(CTReport);
  move(Source[3], buff, 10);
  CTReport^.id := BCDToHex(buff, 10); // 状态报告对应原短消息回馈报告中的MsgID
  FillChar(buff, sizeof(buff), 0);
  move(Source[18], buff, 3);
  CTReport^.sub := buff; //   sub
  FillChar(buff, sizeof(buff), 0);
  move(Source[28], buff, 3);
  CTReport^.dlvrd := buff; //   dlvrd
  FillChar(buff, sizeof(buff), 0);
  move(Source[44], buff, 10);
  CTReport^.Submit_date := buff; //   Submit_date
  FillChar(buff, sizeof(buff), 0);
  move(Source[65], buff, 10);
  CTReport^.done_date := buff; //   done_date
  FillChar(buff, sizeof(buff), 0);
  move(Source[81], buff, 7);
  CTReport^.Stat := buff; //    Stat
  FillChar(buff, sizeof(buff), 0);
  move(Source[93], buff, 3);
  CTReport^.Err := buff; //    Err
  FillChar(buff, sizeof(buff), 0);
  move(Source[101], buff, 3); // Txt前3个byte
  temp := buff;
  FillChar(buff, sizeof(buff), 0);
  move(Source[108], buff, 12); //后12个BYTE
  temp := temp + buff;
  CTReport^.Txt := temp;
  ReportList.Add(CTReport);
  Statustr := '[' + datetimetostr(now) + ']Report:';
  Statustr := Statustr +'<MsgID>'+CTReport^.id + #32;
  Statustr := Statustr +'<Submit_date>'+CTReport^.Submit_date + #32;
  Statustr := Statustr +'<done_date>'+ CTReport^.done_date + #32;
  Statustr := Statustr +'<Stat>'+ CTReport^.Stat + #32;
  Statustr := Statustr +'<Err>'+ CTReport^.Err;
  LogList.AddLog('04' + Statustr);
  upmemo;
end;

procedure TTransmit.ShowDeliver(aDeliver: TCTDeliver; const LinkID:string);
begin
  Statustr := '[' + datetimetostr(now) + ']Deliver:';
  Statustr := Statustr +'<Msgid>' +BCDToHex(aDeliver.Msgid, sizeof(aDeliver.Msgid)) + #32;
  //Statustr := Statustr + inttostr(aDeliver.IsReport) + #32;
  Statustr := Statustr +'<SrcTermID>' + aDeliver.SrcTermID + #32;
  Statustr := Statustr +'<DestTermID>' +aDeliver.DestTermID + #32;
  Statustr := Statustr +'<MsgFormat>' + inttostr(aDeliver.MsgFormat) + #13#10;
  Statustr := Statustr +'<LinkID>' +LinkID + #32;
  Statustr := Statustr +'<MsgContent>' + aDeliver.MsgContent;
  LogList.AddLog('00' + Statustr);
  upmemo;
end;

procedure TTransmit.SaveToDeliverList(aDeliver: TCTDeliver;const LinkID:string); //短信
var
  pDeliver: PCTDeliver;
begin
  new(pDeliver);
  pDeliver^.Msgid := BCDToHex(aDeliver.Msgid, sizeof(aDeliver.Msgid));
  pDeliver^.IsReport := aDeliver.IsReport;
  pDeliver^.MsgFormat := aDeliver.MsgFormat;
  pDeliver^.RecvTime := aDeliver.RecvTime;
  pDeliver^.SrcTermID := aDeliver.SrcTermID;
  pDeliver^.DestTermID := aDeliver.DestTermID;
  pDeliver^.MsgLength := aDeliver.MsgLength;
  if aDeliver.MsgFormat = 8 then {Unicode}
    pDeliver.MsgContent := Ucs2ToString(aDeliver.MsgContent)
  else if aDeliver.MsgFormat = 15 then
    pDeliver^.MsgContent := aDeliver.MsgContent
  else if aDeliver.IsReport = 9 then
  begin {用户拆机、停机消息}
    pDeliver^.MsgContent := copy(aDeliver.MsgContent, 1, 12);
    pDeliver^.MsgContent := pDeliver^.MsgContent + aDeliver.MsgContent[17];
  end;
  pDeliver^.LinkID := LinkID;
  DeliverList.Add(pDeliver); //放入DELIVER队列中
end;
procedure TTransmit.SP_Deliver_Resp(Msg_id: array of char; SequenceID: Longword);
var
  SPDeliver_Resp: TDeliver_Resp; // 上行回馈
  Msgid: string;
begin
  FillChar(SPDeliver_Resp, sizeof(TDeliver_Resp), 0);
  SPDeliver_Resp.Head.PacketLength := HostToNet(sizeof(TDeliver_Resp));
  SPDeliver_Resp.Head.RequestID := HostToNet(Deliver_resp);
  SPDeliver_Resp.Head.SequenceID := HostToNet(SequenceID);
  move(Msg_id, SPDeliver_Resp.body.Msgid, 10);
  Msgid := BCDToHex(Msg_id, 10);
  SPDeliver_Resp.body.Status := HostToNet(0);
  if CTDeliver.Connected then
    if sizeof(TDeliver_Resp) = CTDeliver.SendBuf(SPDeliver_Resp, sizeof(TDeliver_Resp)) then
    begin
      Statustr := '[' + datetimetostr(now()) + ']Deliver_Resp:' + Msgid;
      upmemo;
    end;
end;
function TTransmit.SP_Submit: boolean;
var
  xList: TList;
  SubmitLen: integer;
  Empty: boolean;
  xTCSubmit: PxSubmit; //系统内部数据消息包指针
  rSubmit: xSubmit; //系统内部数据消息包
  SubmitSequence: Longword;
begin
  Result := True;
  Empty := False;
  xTCSubmit := nil;
  FillChar(rSubmit, sizeof(xSubmit), 0);
  if CTDeliver.Connected then
  begin
    xList := SubmitList.LockList;
    try
      if xList.count > 0 then
      begin
        try
          xTCSubmit := PxSubmit(xList.First); //强制类型转换
          rSubmit := xTCSubmit^; //转换记录
          try
            dispose(xTCSubmit); //释放指针
            xList.Delete(0); //删除列表
            xTCSubmit := nil;
          except
          end;
        except
        end;
      end
      else
        Empty := True;
    finally
      SubmitList.UnlockList;
    end;
    if Empty then
    begin
      Result := False;
      exit;
    end;
    //设置socket传输消息包体
    SubmitSequence := MakeSockBuff(SubmitLen, rSubmit);
    //=============================================================================
    try
      if (SubmitLen) = CTDeliver.SendBuf(SocketBuff[0], SubmitLen) then
      begin
        AddsSeq;
        inc(rSubmit.Resend); //发送次数加1
        rSubmit.SequenceID := SubmitSequence; //HostToNet(SMGPSubmit2011.Head.SequenceID);
        rSubmit.Then_DateTime := now; //设置当前发送时间
        new(xTCSubmit);
        xTCSubmit^ := rSubmit;
        SaveSubmitList.Add(xTCSubmit); //SAVE SM
       Statustr := '[' + datetimetostr(now) + ']Submit:';
        Statustr := Statustr +'<SequenceID>'+inttostr(xTCSubmit^.SequenceID) + #32;
        Statustr := Statustr +'<Mid>'+ xTCSubmit^.sSubmit.Mid + #32;
        Statustr := Statustr +'<MsgType>'+ inttostr(xTCSubmit^.sSubmit.MsgType) + #32;
        //Statustr := Statustr +'<NeedReport>'+ inttostr(xTCSubmit^.sSubmit.NeedReport) + #32;
        Statustr := Statustr +'<ServiceID>'+ xTCSubmit^.sSubmit.ServiceID + #32;
        Statustr := Statustr +'<FeeCode>'+ xTCSubmit^.sSubmit.FeeCode + #32;
        Statustr := Statustr +'<FixedFee>'+ xTCSubmit^.sSubmit.FixedFee + #32;
        Statustr := Statustr +'<ChargeTermID>'+ xTCSubmit^.sSubmit.ChargeTermID + #32;
        Statustr := Statustr +'<DestTermID>'+ xTCSubmit^.sSubmit.DestTermID + #13#10;
        Statustr := Statustr +'<SrcTermID>'+ xTCSubmit^.sSubmit.SrcTermID + #32;
        Statustr := Statustr +'<SubmitMsgType>'+ inttostr(xTCSubmit^.sSubmit.SubmitMsgType) + #32;
        Statustr := Statustr +'<LinkID>'+ xTCSubmit^.sSubmit.LinkID + #32;
        Statustr := Statustr +'<MsgContent>'+ xTCSubmit^.sSubmit.MsgContent + #32;
        LogList.AddLog('07' + Statustr);
        AddCou;
        upmemo;
      end
      else
      begin {发送不成功}
        new(xTCSubmit);
        xTCSubmit^ := rSubmit;
        SubmitList.Add(xTCSubmit);
      end;
    except
    end;
    SocketBuff := nil;
  end;
end;

procedure TTransmit.ReSubmit(SequenceID, statu: Longword);
var
  i: integer;
  cSubmit: PxSubmit;
  aList: TList;
  Mid: string;
begin
  aList := SaveSubmitList.LockList;
  try
    for i := 0 to aList.count - 1 do
    begin
      cSubmit := PxSubmit(aList.Items[i]);
      if SequenceID = cSubmit^.SequenceID then
        if cSubmit^.Resend >= sendtimes then
        begin //重发4次失败，不再重发
          Mid := cSubmit^.sSubmit.Mid;
          dispose(cSubmit);
          aList.Delete(i);
          StatustrE := '【' + datetimetostr(now()) + '】Submit_Resp MID=' + Mid + ' 电信网关返回状态=' + inttostr(statu) + '序列号=' + inttostr(SequenceID) + ',第4发送次失败，短消息已被删除';
          LogList.AddLog('09' + StatustrE);
          synchronize(showError);
          break;
        end
        else
        begin
          SubmitList.Add(cSubmit);
          aList.Delete(i);
          Mid := cSubmit^.sSubmit.Mid;
          StatustrE := '【' + datetimetostr(now()) + '】Submit_Resp MID=' + Mid + ' 电信网关返回状态=' + inttostr(statu) + '发送失败,等待再发...';
          synchronize(showError);
          break;
        end;
    end;
  finally
    SaveSubmitList.UnlockList;
  end;
end;
function TTransmit.DeleteMT(SequenceID: Longword; var aMid: string): boolean; //回馈报告
var
  i, FirstCount: integer;
  cSubmit: PxSubmit;
  aList: TList;
begin
  Result := False; //返回MID
  aList := SaveSubmitList.LockList;
  FirstCount := aList.count - 1; //列表初始元素个数
  try
    for i := FirstCount downto 0 do //扫描保存区列表一遍
    begin
      cSubmit := PxSubmit(aList.Items[i]);
      if SequenceID = cSubmit^.SequenceID then
      begin
        aMid := cSubmit^.sSubmit.Mid; //返回MID
        dispose(cSubmit);
        aList.Delete(i);
        Result := True;
      end
      else
      begin {SaveSubmitList中有还没有回馈报告回来的短信}
        if minutesBetween(now, cSubmit^.Then_DateTime) > resptime then {大于10分钟没有回回馈报告重发}
        begin
          SubmitList.Add(cSubmit);
          aList.Delete(i);
          Statustr := '【' + datetimetostr(now()) + '】MID=' + #32 + cSubmit^.sSubmit.Mid + #32 + '在' + inttostr(resptime) + '分钟后没有接收到电信回馈报告,网关作重发处理';
          synchronize(upmemo);
          LogList.AddLog('07' + Statustr);
        end;
      end;
    end;
  finally
    SaveSubmitList.UnlockList;
  end;
end;
procedure TTransmit.NoResponse_Resubmit;
var
  i, FirstCount: integer;
  cSubmit: PxSubmit;
  aList: TList;
begin
  aList := SaveSubmitList.LockList;
  FirstCount := aList.count - 1; //列表初始元素个数
  try
    for i := FirstCount downto 0 do //扫描保存区列表一遍
    begin
      cSubmit := PxSubmit(aList.Items[i]);
      {SaveSubmitList中有还没有回馈报告回来的短信}
      if minutesBetween(now, cSubmit^.Then_DateTime) > resptime then {大于10分钟没有回回馈报告重发}
      begin
        SubmitList.Add(cSubmit);
        aList.Delete(i);
        Statustr := '【' + datetimetostr(now()) + '】MID=' + #32 + cSubmit^.sSubmit.Mid + #32 + '在' + inttostr(resptime) + '分钟后没有接收到电信回馈报告,网关作重发处理';
        synchronize(upmemo);
        LogList.AddLog('07' + Statustr);
      end;
    end;
  finally
    SaveSubmitList.UnlockList;
  end;
end;

function TTransmit.MakeSockBuff(var SubmitLen: integer;
  rSubmit: xSubmit): Longword;
var
  i, count: integer;
  onenumber, Source: string;
  tmpBuf: array[0..20] of char;
  {2.0协议后}
  SMGPSubmit2011: TSMGPSubmit2011; //包头＋包体1
  SMGPSubmit203: TSMGPSubmit203; //包体3
  SMGPTLV_tag:TSMGPTLV_tag;
  SMGPTLVLinkID_tag:TSMGPTLVLinkID_tag;
begin
  Result := 0;
  FillChar(SMGPSubmit2011, sizeof(TSMGPSubmit2011), 0);
  FillChar(SMGPSubmit203, sizeof(TSMGPSubmit203), 0);
  with SMGPSubmit203 do //包体3
  begin
    count := rSubmit.sSubmit.DestTermIDCount; //号码数
    Source := rSubmit.sSubmit.DestTermID; //号码列表
    if count > 1 then
    begin
      for i := 0 to count - 1 do
      begin
        FillChar(tmpBuf, sizeof(tmpBuf), 0);
        Source := ChtchOne(Source, onenumber); //获取单个号码
        strpcopy(tmpBuf, onenumber);
        move(tmpBuf, DestTermID[i * 21], 21);
      end;
    end
    else
      strpcopy(DestTermID, Source);
    DestTermIDCount := count;
    strpcopy(SrcTermID, rSubmit.sSubmit.SrcTermID);
    strpcopy(ChargeTermID, rSubmit.sSubmit.ChargeTermID);
    MsgLength := rSubmit.sSubmit.MsgLength;
    strpcopy(MsgContent, rSubmit.sSubmit.MsgContent);    
  end;
  SubmitLen := sizeof(TSMGPSubmit2011) + sizeof(TSMGPSubmit203) - 252 - 21 * (MAx_UserNumber - count) + SMGPSubmit203.MsgLength + 34; //34长度是可选参数中的三种 linkID submitmsgtype, spdealresult

  //包头和包体1
  with SMGPSubmit2011 do
  begin
    Head.PacketLength := winsock.Htonl(SubmitLen);
    Head.RequestID := winsock.Htonl(Submit);
    Head.SequenceID := winsock.Htonl(sSequence);
    body.MsgType := rSubmit.sSubmit.MsgType;
    body.NeedReport := rSubmit.sSubmit.NeedReport;
    body.Priority := rSubmit.sSubmit.Priority;
    body.MsgFormat := rSubmit.sSubmit.MsgFormat;
    strpcopy(body.ServiceID, rSubmit.sSubmit.ServiceID);
    strpcopy(body.FeeType, rSubmit.sSubmit.FeeType);
    strpcopy(body.FeeCode, rSubmit.sSubmit.FeeCode);
    strpcopy(body.FixedFee, rSubmit.sSubmit.FixedFee);
    body.MsgFormat := rSubmit.sSubmit.MsgFormat;
    strpcopy(body.ValidTime, rSubmit.sSubmit.ValidTime);
    strpcopy(body.ATTime, rSubmit.sSubmit.ATTime);
  end;
  //===========================================================
  SetLength(SocketBuff, SubmitLen);  
  FillChar(SocketBuff[0], SubmitLen, 0);
  move(SMGPSubmit2011, SocketBuff[0], 74);
  move(SMGPSubmit203, SocketBuff[74], 43);
  move(SMGPSubmit203.DestTermID, SocketBuff[74 + 43], 21 * count);
  move(SMGPSubmit203.MsgLength, SocketBuff[74 + 43 + 21 * count], 1);
  move(SMGPSubmit203.MsgContent, SocketBuff[74+ 43 + 21 * count + 1], SMGPSubmit203.MsgLength);
  move(SMGPSubmit203.Reserve, SocketBuff[74 + 43 + 21 * count + 1 + SMGPSubmit203.MsgLength], 8);
  //封装可选参数
  FillChar(SMGPTLVLinkID_tag,sizeof(TSMGPTLVLinkID_tag), 0);
  SMGPTLVLinkID_tag.Tag := winsock.htons(TLV_Lab_LinkID);
  SMGPTLVLinkID_tag.Length:=winsock.htons(20);
//  move(rSubmit.sSubmit.LinkID, SMGPTLVLinkID_tag.Value, 20);
  strpcopy(SMGPTLVLinkID_tag.Value, rSubmit.sSubmit.LinkID);
  move(SMGPTLVLinkID_tag, SocketBuff[74 + 43 + 21 * count + 1 + SMGPSubmit203.MsgLength+8], 24);
  FillChar(SMGPTLV_tag,sizeof(TSMGPTLV_tag),0);
  SMGPTLV_tag.Tag:=winsock.htons(TLV_Lab_SubmitMsgType);
  SMGPTLV_tag.Length:=winsock.htons(1);
  SMGPTLV_tag.Value := rSubmit.sSubmit.SubmitMsgType;
  move(SMGPTLV_tag, SocketBuff[74 + 43 + 21 * count + 1 + SMGPSubmit203.MsgLength+8 + 24], 5);
  FillChar(SMGPTLV_tag,sizeof(TSMGPTLV_tag),0);
  SMGPTLV_tag.Tag:=winsock.htons(TLV_Lab_SPDealReslt);
  SMGPTLV_tag.Length:=winsock.htons(1);
  SMGPTLV_tag.Value:=0;
  move(SMGPTLV_tag, SocketBuff[74 + 43 + 21 * count + 1 + SMGPSubmit203.MsgLength+8 + 24+5], 5);
  Result := HostToNet(SMGPSubmit2011.Head.SequenceID); //返回包序列号
end;

procedure TTransmit.ReceiveHead;
var
  Head: TSMGPHead;
  CTRequestID: Longword;
  CTsequence: Longword;
  Len: Longword;
begin
  FillChar(Head, sizeof(TSMGPHead), 0);
  if CTDeliver.Connected then
    if CTDeliver.WaitForData(timeout) then
      if sizeof(TSMGPHead) = CTDeliver.ReceiveBuf(Head, sizeof(TSMGPHead)) then
      begin
        Active_test_time := now;
        CTRequestID := winsock.Htonl(Head.RequestID); //请求命令
        Len := winsock.Htonl(Head.PacketLength); //消息长度
        CTsequence := winsock.Htonl(Head.SequenceID); //序列号
        ReceiveBody(CTRequestID, CTsequence, Len);
      end;
end;
procedure TTransmit.AddSyncOrdCelMsg(aDeliver: TCTDeliver;const LinkID:string);
var
  PSubmit: PxSubmit;
  srcMsg, ServiceID, MsgContent:string;
begin
  srcMsg:=Copy(aDeliver.MsgContent, 0, aDeliver.MsgLength);
  DealWithSyncMsgCont(srcMsg, ServiceID, MsgContent);
  new(PSubmit);
  PSubmit^.Resend := 0;
  PSubmit^.SequenceID := 0;
  PSubmit^.Then_DateTime := 0;
  PSubmit^.sSubmit.Mid := 'syc'+Formatdatetime('MMDDHHNNSS',now());
  PSubmit^.sSubmit.MsgType := 6;
  PSubmit^.sSubmit.NeedReport := 0;
  PSubmit^.sSubmit.Priority := 0;
  PSubmit^.sSubmit.ServiceID := ServiceID;//业务代码用短信内容体里的业务代码
  PSubmit^.sSubmit.FeeType := '0';
  PSubmit^.sSubmit.FeeCode := '0';
  PSubmit^.sSubmit.FixedFee := '0';
  PSubmit^.sSubmit.MsgFormat := 15;
  PSubmit^.sSubmit.SrcTermID := aDeliver.DestTermID;
  PSubmit^.sSubmit.ChargeTermID := aDeliver.SrcTermID;
  PSubmit^.sSubmit.DestTermIDCount := 1;
  PSubmit^.sSubmit.DestTermID := aDeliver.SrcTermID;
  PSubmit^.sSubmit.MsgLength := Length(MsgContent);
  PSubmit^.sSubmit.LinkID := LinkID;
  PSubmit^.sSubmit.MsgContent := MsgContent;//StringReplace(aSubmit.MsgContent, #13, '', [rfReplaceAll]); //去除回车符
  PSubmit^.sSubmit.SubmitMsgType := 15; //正常的点播信息
  SubmitList.Add(PSubmit);
end;
procedure TTransmit.DealWithSyncMsgCont(const msgcontent: string;
  var ServiceID, MsgContPart: string);
var
  pos1,pos2:integer;
begin
//  DG＋空格＋业务代码＋双空格＋受惠用户的终端号码＋冒号＋用户输入的内容
//  QX＋空格＋业务代码＋双空格＋受惠用户的终端号码＋冒号＋用户输入的内容
  if msgcontent ='00000' then
  begin
    ServiceID := msgcontent;
    MsgContPart := msgcontent;
    exit;
  end;
  pos1:=AnsiPos(#32,  msgcontent);
  pos2:=AnsiPos(#32#32,  msgcontent);
  ServiceID := MidStr(msgcontent, pos1+1, pos2-pos1-1);
  pos1:= AnsiPos(':',  msgcontent);
  MsgContPart:= MidStr(msgcontent, 1, pos1-1);// 截取冒号前面得字串
end;
//截取用户输入得短信内容,
function TTransmit.GetInstruct(const msgcontent: string): string;
var
  pos:integer;
begin
  if msgcontent ='00000' then //正向取消所有业务得时候
  begin
    result:= msgcontent;
    exit;
  end;
  pos:=AnsiPos(':',  msgcontent);
  if pos=0 then
    result:= msgcontent
  else
    result:=strutils.RightStr(msgcontent, length(msgcontent)-pos);
end;
procedure TTransmit.ReceiveBody(CTRequestID, CTsequence, Len: Longword);
var
  xLogin_resp: TSMGPLogin_resp;
  SPResponse: PResponse;
  xDeliver: TCTDeliver;
  ErrMsg: array of char;
  Status: Longword;
  isRep: byte;
  Mid: string;
begin
  FillChar(xLogin_resp, sizeof(TSMGPLogin_resp), 0);
  FillChar(xDeliver, sizeof(TCTDeliver), 0);
  if CTDeliver.Connected then
  begin
    if Active_test_resp = CTRequestID then
    begin {//电信发送链路测试回复}
      StatuTxt := '【' + datetimetostr(now) + '】Active_Test_Resp 电信回复链路正常...' + inttostr(CTsequence);
      LogList.AddLog('08' + StatuTxt);
      showstatu;
       if (MinutesBetween(now, LastSendWarnMsgTime) >= NoReceiveDeliver) and (MinutesBetween(now, ReceiveDeliverTime) >= NoReceiveDeliver) and (SendWarn) and (Counter < SendCount) then
      begin
        LogList.AddLog('10' + '电信网关于上次上行或登陆时间' + datetimetostr(ReceiveDeliverTime) + '到目前时间' + datetimetostr(now) + '已经超过' + inttostr(MinutesBetween(now, ReceiveDeliverTime)) + '分钟没有上行，请相关人员注意运行情况(系统将连续提醒' + inttostr(SendCount) + '次)');
        inc(Counter);
        if Counter = SendCount then
        begin
          LastSendWarnMsgTime := now;
          Counter := 0;
        end;
      end;
    end
    else if Deliver = CTRequestID then
    begin {//上行短信}
      ReceiveDeliver(CTsequence, Len);
      {ReceiveDeliverTime := now;
      if 69 = CTDeliver.ReceiveBuf(xDeliver, 69) then
        if xDeliver.MsgLength = CTDeliver.ReceiveBuf(xDeliver.MsgContent, xDeliver.MsgLength) then
          if 8 = CTDeliver.ReceiveBuf(xDeliver.Reserve, 8) then
          begin
            SP_Deliver_Resp(xDeliver.Msgid, CTsequence); //上行短信回馈CP-->CT
            isRep := xDeliver.IsReport;
            if isRep = 1 then
              WriteReport(xDeliver.Msgid, xDeliver.MsgContent)
            else
            begin
              SaveToDeliverList(xDeliver);
              synchronize(AddCou);
              ShowDeliver(xDeliver);
            end;
          end; }
    end
    else if Submit_resp = CTRequestID then
    begin {回馈报告Submit_response}
      if CTDeliver.ReceiveBuf(CTSubmit_Resp, sizeof(TSMGPDeliver_Resp)) = sizeof(TSMGPDeliver_Resp) then
      begin
        Status := HostToNet(CTSubmit_Resp.Status);
        if ((Status > 0) and (Status < 10)) or (Status = 39) then //返回这些代码的时候重发短信
          ReSubmit(CTsequence, Status)
        else if Status = 0 then
        begin //电信网关正确接收
          if not DeleteMT(CTsequence, Mid) then //删除缓冲区短信 并返回MID
            Statustr := '【' + datetimetostr(now) + '】删除缓冲区短信时没有返回正确的MID';
          new(SPResponse);
          SPResponse^.Mid := Mid;
          strpcopy(SPResponse^.Submit_resp.Msgid, BCDToHex(CTSubmit_Resp.Msgid, sizeof(CTSubmit_Resp.Msgid)));
          SPResponse^.Submit_resp.Status := Status;
          ResponseList.Add(SPResponse); //放入下行回馈队列中
          Statustr := '[' + datetimetostr(now) + ']Submit_Resp:';
          Statustr := Statustr +'<CTsequence>' +inttostr(CTsequence) + #32;
          Statustr := Statustr +'<Mid>' + Mid + #32;
          Statustr := Statustr +'<Msgid>' + SPResponse^.Submit_resp.Msgid + #32;
          Statustr := Statustr +'<Status>' + inttostr(Status);
          LogList.AddLog('02' + Statustr);
          synchronize(upmemo);
        end
        else
        begin //返回其他错误代码
          DeleteMT(CTsequence, Mid); //删除缓冲区短信
          Statustr := '【' + datetimetostr(now) + '】Submit_Resp:' + Mid + '返回状态=' + inttostr(Status) + ',短消息已经被删除';
          LogList.AddLog('09' + Statustr);
          synchronize(upmemo);
        end;
      end;
    end
    else if Active_test = CTRequestID then
    begin {电信发送上行链路检测包}
      StatuTxt := '【' + datetimetostr(now) + '】CT-->SPActiveTest 电信发送链路测试 ' + inttostr(CTsequence);
      showstatu;
      ActiveTest_Resp(CTsequence);
    end
    else if Exit_resp = CTRequestID then
    begin {退出回复}
      CTDeliver.Close;
      DCanExit := True;
      TransmitExit := False;
      SockCanExit := True; ;
      StatuTxt := '【' + datetimetostr(now()) + '】ExitCT --> 退出与中国电信的连接';
      LogList.AddLog('11' + StatuTxt);
      showstatu;
    end
    else
    begin //错误的包头命令字
      try
        setlength(ErrMsg, Len - 12);
        CTDeliver.ReceiveBuf(ErrMsg, Len - 12);
        ErrMsg := nil;
      except
      end;
      StatuTxt := '【' + datetimetostr(now()) + '】接收到类型错误的消息包';
      showstatu;
    end;
  end;
end;

function TTransmit.ReceiveTLVMsg(const MsgLen: integer; var LinkID:string;var DealReslt:byte):byte;
var
  tmpbuf:array of char;
  tag, Len:word;
  pos:integer;
  value:array of char;
begin
  SetLength(tmpbuf,MsgLen);
  result:=0;
  DealReslt:=0;
  if CTDeliver.ReceiveBuf(tmpbuf[0], MsgLen) = MsgLen then  //接收所有可选参数
  begin
    pos:=0;
    while(pos < MsgLen)do
    begin
      Len:=0;
      tag:=0;
      Move(tmpbuf[pos], tag, 2);
      Move(tmpbuf[pos+2], Len, 2);
      tag:=htons(tag);//标签
      len:=htons(len);
      SetLength(value,len);
      Move(tmpbuf[pos+4], value[0], Len);
      case tag of
        TLV_Lab_LinkID:
        begin
          //CopyMemory(@LinkID, @value, len);
          setLength(LinkID, len);
          Move(value[0],LinkID[1], len);
        end;
        TLV_Lab_SubmitMsgType:// 13 是同步定购, 15 是同步定购回复 0是正常上行
        begin
          //CopyMemory(@Result, @Value, 1);
          Move(value[0], Result, 1);
        end;
        TLV_Lab_SPDealReslt: //同步定购处理结果 0 成功,1 失败
        begin
          //CopyMemory(@DealReslt, @Value,1);
          Move(value[0], DealReslt, 1);
        end;
      end;
      value:=nil;
      inc(pos,4 + Len);
    end;
  end; 
  tmpbuf:=nil;
end;

procedure TTransmit.ReceiveDeliver(CTsequence, Len: Longword);
var
  xDeliver: TCTDeliver;
  isRep: byte;
  LinkID:string;
  SubmitMsgType,DealResult:byte;
  Msg:string;
begin
  FillChar(xDeliver, sizeof(TCTDeliver), 0);
  ReceiveDeliverTime := now;
  Counter := 0;
  if 69 = CTDeliver.ReceiveBuf(xDeliver, 69) then
    if xDeliver.MsgLength = CTDeliver.ReceiveBuf(xDeliver.MsgContent, xDeliver.MsgLength) then
      if 8 = CTDeliver.ReceiveBuf(xDeliver.Reserve, 8) then
      begin    //再收可选参数
        if (len - sizeof(CTSMSHeader) > 77+ xDeliver.MsgLength) then
        begin //接收可选参数,输入参数是 可选参数总长度, LinkID, DealResult==处理结果
          SubmitMsgType := ReceiveTLVMsg(len - (89 + xDeliver.MsgLength), LinkID, DealResult);
        end;
        SP_Deliver_Resp(xDeliver.Msgid, CTsequence); //上行短信回馈CP-->CT
        isRep := xDeliver.IsReport;
        if isRep = 1 then {//状态报告}
          WriteReport(xDeliver.Msgid, xDeliver.MsgContent)
        else
        begin {//正常的上行短信/或用户拆机停机 信息}
          case SubmitMsgType of
            13://需要回复下行, SubmitMsgType = 15,LinkID也需要, 内容体为"DG＋空格＋业务代码＋双空格＋受惠用户的终端号码
               //还需要再把短信内容只取用户输入的内容部分
               begin //正向定制,取消
                 AddSyncOrdCelMsg(xDeliver, LinkID);//写入submit队列,
                 //上行短信内容改为用户输入内容
                 msg:=Copy(xDeliver.MsgContent,0, xDeliver.MsgLength);
                 FillChar(xDeliver.MsgContent,sizeof(xDeliver.MsgContent),0);
                 StrpCopy(xDeliver.MsgContent, GetInstruct(msg));
               end;
            15://反向定制,取消 回复,需要把 ReSycQX+1个空格+ 上内容 + 1个空格 + DealReslt
               begin
                 msg:=Copy(xDeliver.MsgContent,0, xDeliver.MsgLength);
                 FillChar(xDeliver.MsgContent,sizeof(xDeliver.MsgContent),0);
                 StrpCopy(xDeliver.MsgContent, 'ReSyc '+ msg + #32 + inttostr(DealResult));
               end;
          end;
          SaveToDeliverList(xDeliver, LinkID);
          synchronize(AddCou);
          showDeliver(xDeliver,LinkID);
        end;
        {try
         fs:=Tfilestream.create( 'd:\Stream\D'+formatdatetime('ddhhnnss',now)+'.txt',fmCreate	);
         fs.WriteBuffer(xDeliver,sizeof(xDeliver));
        finally
         fs.free;
        end;}
      end;
end;

end.

