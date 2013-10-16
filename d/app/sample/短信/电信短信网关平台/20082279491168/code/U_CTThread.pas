{－－－－－－－－－－－－－－－－－－－－－－－－}
{                  SUBMIT线程                    }
{                  Author: LUOXINXI              }
{                  DateTime: 2004/3/11           }
{－－－－－－－－－－－－－－－－－－－－－－－－}


unit U_CTThread;
interface
uses
  Windows, classes, Sockets, U_MsgInfo, Smgp13_XML, U_RequestID, Htonl,
  SysUtils, winsock, ScktComp, md5, DateUtils, NetDisconnect;
{MT Thread}
type
  TCPSubmit = class(TThread)
  private
    CTClient: TTcpClient;
    Statustr: string;
    StatuTxt: string;
    StatustrE: string;
    fsleeptime: integer;
    ClientID: string;
    sharesecret: string;
    SocketBuff: array of char;
    loginmode: byte;
    timeout: integer;
    HadLogin: boolean;
    Active_test_time: TDateTime; // integer;
    resptime, sendtimes: integer;
    MT_Warnning: byte;
    ErrWarnning: TWarnning;
    ErrMsg: array of char;
  protected
    procedure Execute; override;
    procedure LoginCT; {登陆过程}
    function ExitCT: boolean; {退出过程}
    procedure MT_ActiveTest; {发送链路检测包}
    function SP_Submit: boolean; {下行短信}
    procedure Receive; {接收下行链路数据}
    procedure MTSocketError(Sender: TObject;
      SocketError: integer);
    procedure ReSubmit(SequenceID: Longword; statu: Longword); {重发}
    function DeleteMT(SequenceID: Longword; var aMid: string): boolean; {删除下行短信缓冲区短信,返回MID}
    procedure MTActive_Test_Resp(CTsequence: Longword); {回复链路检测包}
    function SubmitButDisConn(DisConnTime: TDateTime): integer; //已经下发短信但没有回馈下行链路断开
    function MakeSockBuff(var SubmitLen: integer; rSubmit: xSubmit): Longword; //设置socket传输消息 返回值是该消息序列号
    procedure upmemo;
    procedure NoResponse_Resubmit; //在指定时间没有返回回馈报告的重发
    procedure showError;
    procedure showstatu;
    procedure AddsSeq;
    procedure AddCou;
  public
    constructor create(xCT_IP, xCT_port, xClientID, xsharesecret: string; xsleeptime, xtimeout, xresptime, xsendtimes: integer; xloginmode: byte); virtual;
    destructor destroy; override;
  end;

implementation
uses U_Main;

{ TCPSubmit }
constructor TCPSubmit.create(xCT_IP, xCT_port, xClientID, xsharesecret: string; xsleeptime, xtimeout, xresptime, xsendtimes: integer; xloginmode: byte);
begin
  inherited create(True);
  FreeOnTerminate := True;
  CTClient := TTcpClient.create(nil);
  CTClient.RemoteHost := xCT_IP;
  CTClient.RemotePort := xCT_port;
  CTClient.OnError := MTSocketError;
  ClientID := xClientID;
  sharesecret := xsharesecret;
  fsleeptime := xsleeptime;
  timeout := xtimeout;
  resptime := xresptime;
  sendtimes := xsendtimes;
  loginmode := xloginmode;
  StatuTxt := '【' + datetimetostr(now) + '】下行线程创建,电信网关服务器' + xCT_IP + ',ThreadID:' + inttostr(self.ThreadID);
  synchronize(showstatu);
  Resume;
end;
destructor TCPSubmit.destroy;
begin
  StopCatchSMS := True;
  FreeAndNil(CTClient);
  SocketBuff := nil;
  ErrMsg:=nil;
  StatuTxt := '【' + datetimetostr(now) + '】下行线程中止,ThreadID:' + inttostr(self.ThreadID);
  synchronize(showstatu);
  LogList.AddLog('10' + StatuTxt);
  SMGPGateWay.Label8.Caption := 'Warning:发送短信(MT)线程停止';
  MTExit := False;
  SMGPGateWay.MTLogin1.Enabled := True;
  inherited;
end;
procedure TCPSubmit.Execute;
begin
  HadLogin := False;
  MT_Warnning := 0;
  while not Terminated do
  try
    if not HadLogin then
      LoginCT //登陆
    else
    begin
      NoResponse_Resubmit;
      if not SP_Submit then {发送短信  {if MT List is null then send ActiveTest To CT}
        MT_ActiveTest; //短信发送不成功或没有短信发送则发送链路测试
      Receive;
    end;
    if MTExit then //退出
      if HadLogin then
      begin
        if ExitCT then
        begin
          MTExit := False; break; end; //退出线程
      end
      else
      begin
        MTExit := False; break;
      end;
      sleep(fsleeptime);
  except
    on e: exception do
    begin
      Statustr := '[' + datetimetostr(now) + ']' + 'MT Thread Error:' + e.Message;
      LogList.AddLog('10' + StatuTxt);
      synchronize(upmemo);
    end;
  end;
end;
procedure TCPSubmit.LoginCT;
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
    body.Version := GetVision; //系统支持的版本号$20;
    body.loginmode := loginmode;
    DateTimeToString(timestr, 'MMDDHHMMSS', now);
    xLogin.body.Timestamp := winsock.Htonl(StrToInt(timestr));
    str1 := ClientID + #0#0#0#0#0#0#0 + sharesecret + timestr;
    MD5Init(md5_con);
    MD5Update(md5_con, pchar(str1), length(str1));
    MD5Final(md5_con, md5str);
    move(md5str, body.AuthenticatorClient, 16);
  end;
  try
    CTClient.Close;
  except
  end;
  try
    if CTClient.Connect then
      if sizeof(TLogin) = CTClient.SendBuf(xLogin, sizeof(xLogin), 0) then
      begin {//发送}
        AddsSeq;
        StatuTxt := '【' + datetimetostr(now()) + '】SP-->CT(MT)LoginCT Request 下行连接发送登陆请求...';
        synchronize(showstatu);
        if CTClient.WaitForData(timeout) then
        begin
          if sizeof(TSMGPHead) = CTClient.ReceiveBuf(Head, sizeof(TSMGPHead), 0) then
          begin {//   收头}
            Active_test_time := now; //StrToInt(formatdatetime('ss', now)); //登陆回复时间
            temp := winsock.Htonl(Head.RequestID);
            if Login_resp = temp then
              if CTClient.WaitForData(timeout) then
              begin
                if sizeof(TSMGPLogin_resp) = CTClient.ReceiveBuf(xLogin_resp, sizeof(TSMGPLogin_resp), 0) then
                begin
                  Status := HostToNet(xLogin_resp.Status);
                  case Status of
                    0:
                      begin
                        StatuTxt := '【' + datetimetostr(now()) + '】(MT)Login_Resp-- >下行连接成功登陆中国电信'; HadLogin := True; MT_Warnning := 0; SCanExit := False; MTExit := False; StopCatchSMS := False; end;
                    1:
                      begin
                        StatuTxt := '【' + datetimetostr(now()) + '】(MT)Login_Resp-- >下行连接电信回复系统忙，请稍候再拨'; CTClient.Close; sleep(RetryTime); StopCatchSMS := True; end;
                    21:
                      begin
                        StatuTxt := '【' + datetimetostr(now()) + '】(MT)Login_Resp-- >下行连接电信回复认证错误！！'; CTClient.Close; sleep(RetryTime); StopCatchSMS := True; end;
                  else
                    begin
                      StatuTxt := '【' + datetimetostr(now()) + '】(MT)Login_Resp-- >下行连接电信回复鉴别客户端接入请求状态 ' + inttostr(Status); CTClient.Close; sleep(RetryTime); StopCatchSMS := True; end;
                  end;
                  LogList.AddLog('10' + StatuTxt);
                end;
              end
              else
              begin
                StatuTxt := '【' + datetimetostr(now()) + '】(MT)Login下行请求连接超时,链路关闭,等待' + inttostr(RetryTime div 1000) + '重新登陆...'; CTClient.Close; sleep(RetryTime); end;
          end;
        end
        else
        begin
          StatuTxt := '【' + datetimetostr(now()) + '】(MT)Login下行请求连接超时,链路关闭,等待' + inttostr(RetryTime div 1000) + '秒重新登陆...'; CTClient.Close; sleep(RetryTime); end;
        synchronize(showstatu);
      end;
  except
  end;
end;
procedure TCPSubmit.MT_ActiveTest;
var
  ActiveTest: TSMGPHead;
begin
  FillChar(ActiveTest, sizeof(TSMGPHead), 0);
  if CTClient.Connected then
  begin
    if DateUtils.SecondsBetween(now, Active_test_time) >= (ActiveTestTime div 1000) then
    begin
      with ActiveTest do
      begin
        ActiveTest.PacketLength := HostToNet(sizeof(TSMGPHead));
        ActiveTest.RequestID := HostToNet(Active_test);
        ActiveTest.SequenceID := HostToNet(sSequence);
      end;
      if sizeof(TSMGPHead) = CTClient.SendBuf(ActiveTest, sizeof(TSMGPHead), 0) then
      begin
        AddsSeq;
        StatuTxt := '【' + datetimetostr(now()) + '】(MT)ActiveTest 下行发送链路检测包 ' + inttostr(HostToNet(ActiveTest.SequenceID));
        synchronize(showstatu);
      end;
    end;
  end;
end;
function TCPSubmit.ExitCT: boolean;
var
  SMGPExit: TSMGPHead;
  SMGPExit_Resp: TSMGPHead;
  temp: Longword;
begin
  Result := False;
  FillChar(SMGPExit, sizeof(TSMGPHead), 0);
  FillChar(SMGPExit_Resp, sizeof(TSMGPHead), 0);
  with SMGPExit do
  begin
    SMGPExit.PacketLength := HostToNet(sizeof(TSMGPHead));
    SMGPExit.RequestID := HostToNet(xExit);
    SMGPExit.SequenceID := HostToNet(sSequence);
  end;
  try
    if HadLogin then
      if sizeof(TSMGPHead) = CTClient.SendBuf(SMGPExit, sizeof(TSMGPHead), 0) then
      begin
        AddsSeq;
        StatuTxt := '【' + datetimetostr(now()) + '】SP-->CT(MT)ExitCT Request 下行连接发送退出请求...';
        synchronize(showstatu);
        if CTClient.WaitForData(timeout) then
        begin
          if sizeof(TSMGPHead) = CTClient.ReceiveBuf(SMGPExit_Resp, sizeof(TSMGPHead), 0) then
          begin
            temp := HostToNet(SMGPExit_Resp.RequestID);
            if temp = Exit_resp then
            begin
              CTClient.Close;
              Result := True;
              SCanExit := True;
              StatuTxt := '【' + datetimetostr(now()) + '】MT ExitCT --> 下行连接退出与电信的连接';
              synchronize(showstatu);
            end;
          end;
        end
        else
        begin
          CTClient.Close;
          SCanExit := True;
          Result := True;
          StatuTxt := '【' + datetimetostr(now()) + '】MT ExitCT Request 下行连接发送退出请求超时，连接已经关闭';
          synchronize(showstatu);
        end;
      end;
  except
  end;
end;

procedure TCPSubmit.MTSocketError(Sender: TObject; SocketError: integer);
var
  Error: integer;
begin
  Error := SocketError;
  SocketError := 0;
  SCanExit := True;
  StatuTxt := '【' + datetimetostr(now) + '】(MT)下行链路发生网络故障' + inttostr(Error) + ',等待' + inttostr(RetryTime div 1000) + '秒再次登陆...';
  StopCatchSMS := True;
  //SubmitButDisConn(now);
  synchronize(showstatu);
  LogList.AddLog('10' + StatuTxt);
  inc(MT_Warnning);
  if MT_Warnning > 10 then ErrWarnning := TWarnning.create;
  HadLogin := False;
  sleep(RetryTime);
end;

function TCPSubmit.SP_Submit: boolean;
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
  //=======================================================
  {2.0协议后}
  {FillChar(SMGPSubmit2011, sizeof(TSMGPSubmit2011), 0);
  FillChar(SMGPSubmit203, sizeof(TSMGPSubmit203), 0);
  FillChar(SMGPSubmit2021, sizeof(TSMGPSubmit2021), 0);
  FillChar(SMGPSubmit2022, sizeof(TSMGPSubmit2022), 0); }
  //=======================================================
  FillChar(rSubmit, sizeof(xSubmit), 0);
  if CTClient.Connected then
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
    SubmitSequence := MakeSockBuff(SubmitLen, rSubmit);
    try
      if (SubmitLen) = CTClient.SendBuf(SocketBuff[0], SubmitLen) then
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
        synchronize(upmemo);
      end
      else
      begin //发送不成功
        new(xTCSubmit);
        xTCSubmit^ := rSubmit;
        SubmitList.Add(xTCSubmit);
      end;
      {    end;
  end
  else
  begin
    new(xTCSubmit);
    xTCSubmit^ := rSubmit;
    SubmitList.Add(xTCSubmit);
  end; }
    except
    end;
    SocketBuff := nil;
  end;
end;


procedure TCPSubmit.Receive;
var
  Head: TSMGPHead;
  CTSubmit_Resp: TSMGPDeliver_Resp; 
  SPResponse: PResponse;
  CTRequestID: Longword;
  CTsequence: Longword;
  Status: Longword;
  Rec_Len: Longword;
  MID: string;
begin
  FillChar(Head, sizeof(TSMGPHead), 0);
  FillChar(CTSubmit_Resp, sizeof(TSMGPDeliver_Resp), 0);
  CTRequestID := 0;
  CTsequence := 0;
  if CTClient.Connected then
    if CTClient.WaitForData(timeout) then
    begin
      if sizeof(TSMGPHead) = CTClient.ReceiveBuf(Head, sizeof(TSMGPHead)) then
      begin
        Active_test_time := now;  //下行链路回复时间
        CTRequestID := HostToNet(Head.RequestID); //请求命令
        CTsequence := HostToNet(Head.SequenceID); //序列号
        Rec_Len := HostToNet(Head.PacketLength);
        if Active_test_resp = CTRequestID then
        begin {//电信发送链路测试回复}
          StatuTxt := '【' + datetimetostr(now) + '】(MT)Active_Test_Resp 电信回复下行链路正常...' + inttostr(CTsequence) + #32;
          LogList.AddLog('08' + StatuTxt);
          synchronize(showstatu);
        end
        else if Submit_resp = CTRequestID then
        begin {回馈报告Submit_response}
          if CTClient.ReceiveBuf(CTSubmit_Resp, sizeof(TSMGPDeliver_Resp)) = sizeof(TSMGPDeliver_Resp) then
          begin
            Status := HostToNet(CTSubmit_Resp.Status);
            if ((Status > 0) and (Status < 10)) or (Status = 39) then //返回这些代码的时候重发短信
              ReSubmit(CTsequence, Status)
            else if Status = 0 then
            begin //电信网关正确接收
              if not DeleteMT(CTsequence, MID) then //删除缓冲区短信 并返回MID
                Statustr := '【' + datetimetostr(now) + '】删除缓冲区短信时没有返回正确的MID';
              new(SPResponse);
              SPResponse^.MID := MID;
              strpcopy(SPResponse^.Submit_resp.MsgID, BCDToHex(CTSubmit_Resp.MsgID, sizeof(CTSubmit_Resp.MsgID)));
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
              DeleteMT(CTsequence, MID); //删除缓冲区短信
              new(SPResponse);
              SPResponse^.MID := MID;
              strpcopy(SPResponse^.Submit_resp.MsgID, BCDToHex(CTSubmit_Resp.MsgID, sizeof(CTSubmit_Resp.MsgID)));
              SPResponse^.Submit_resp.Status := Status;
              ResponseList.Add(SPResponse); //放入下行回馈队列中
              Statustr := '【' + datetimetostr(now) + '】Submit_Resp:' + MID + '返回状态=' + inttostr(Status) + ',短消息已经被删除';
              LogList.AddLog('09' + Statustr);
              synchronize(upmemo);
            end;
          end;
        end
        else if Active_test = CTRequestID then
        begin {电信发送链路检测包}
          StatuTxt := '【' + datetimetostr(now) + '】CT-->SP(MT) ActiveTest ' + inttostr(CTsequence);
          synchronize(showstatu);
          MTActive_Test_Resp(CTsequence);
        end
        else if Exit_resp = CTRequestID then
        begin
          CTClient.Close;
          SCanExit := True;
          StatuTxt := '【' + datetimetostr(now()) + '】MT ExitCT 下行连接退出与电信的连接';
          synchronize(showstatu);
        end
        else
        begin //错误的包头命令字
          try
            SetLength(ErrMsg, Rec_Len - 12);
            CTClient.ReceiveBuf(ErrMsg, Rec_Len - 12);
            //SetLength(ErrMsg, 0);
            ErrMsg := nil;
          except
          end;
          StatuTxt := '【' + datetimetostr(now()) + '】MT 接收到类型错误的消息包'; 
          synchronize(showstatu);
        end;
      end;
    end;
  {else begin
    CTClient.Close;
    HadLogin := False;
    SCanExit := True;
    StatuTxt := '【' + datetimetostr(now) + '】(MT)接收等待超时,链路关闭,等待' + inttostr(RetryTime div 1000) + '秒重新登陆';
    synchronize(showstatu);
    sleep(RetryTime);
  end;}
end;
procedure TCPSubmit.MTActive_Test_Resp(CTsequence: Longword);
var
  spActiveTest_Resp: TSMGPHead;
begin
  FillChar(spActiveTest_Resp, sizeof(TSMGPHead), 0);
  spActiveTest_Resp.SequenceID := HostToNet(CTsequence);
  spActiveTest_Resp.PacketLength := HostToNet(sizeof(TSMGPHead));
  spActiveTest_Resp.RequestID := HostToNet(Active_test_resp);
  if CTClient.Connected then
    if sizeof(TSMGPHead) = CTClient.SendBuf(spActiveTest_Resp, sizeof(TSMGPHead)) then
    begin
      StatuTxt := '【' + datetimetostr(now()) + '】SP-->CT(MT)ActiveTest_Resp SP回复下行链路正常... ' + inttostr(CTsequence);
      synchronize(showstatu);
    end;
end;

procedure TCPSubmit.ReSubmit(SequenceID, statu: Longword);
var
  i: integer;
  cSubmit: PxSubmit;
  aList: TList;
  MID: string;
begin
  aList := SaveSubmitList.LockList;
  try
    for i := 0 to aList.count - 1 do
    begin
      cSubmit := PxSubmit(aList.Items[i]);
      if SequenceID = cSubmit^.SequenceID then
        if cSubmit^.Resend >= sendtimes then
        begin //重发4次失败，不再重发
          MID := cSubmit^.sSubmit.MID;
          dispose(cSubmit);
          aList.Delete(i);
          StatustrE := '【' + datetimetostr(now()) + '】Submit_Resp MID=' + MID + ' 电信网关返回状态=' + inttostr(statu) + '序列号=' + inttostr(SequenceID) + ',第4发送次失败，短消息已被删除';
          LogList.AddLog('09' + StatustrE);
          synchronize(showError);
          break;
        end
        else
        begin
          SubmitList.Add(cSubmit);
          aList.Delete(i);
          MID := cSubmit^.sSubmit.MID;
          StatustrE := '【' + datetimetostr(now()) + '】Submit_Resp MID=' + MID + ' 电信网关返回状态=' + inttostr(statu) + '发送失败,等待再发...';
          synchronize(showError);
          break;
        end;
    end;
  finally
    SaveSubmitList.UnlockList;
  end;
end;
function TCPSubmit.DeleteMT(SequenceID: Longword; var aMid: string): boolean; //回馈报告
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
        aMid := cSubmit^.sSubmit.MID; //返回MID
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
          Statustr := '【' + datetimetostr(now()) + '】MID=' + #32 + cSubmit^.sSubmit.MID + #32 + '在发送' + inttostr(resptime) + '分钟后仍未接收到电信回馈报告,网关作重发处理';
          synchronize(upmemo);
          LogList.AddLog('07' + Statustr);
        end;
      end;
    end;
  finally
    SaveSubmitList.UnlockList;
  end;
end;

procedure TCPSubmit.upmemo;
begin
  if SMGPGateWay.Memo1.Lines.count > 500 then SMGPGateWay.Memo1.Clear;
  if SMGPGateWay.N3.Checked then
    SMGPGateWay.Memo1.Lines.Add(Statustr + #13#10);
  SMGPGateWay.StatusBar1.Panels[7].Text := 'T: ' + inttostr(SPS_cou);
  SMGPGateWay.StatusBar1.Refresh;
end;

procedure TCPSubmit.showError;
begin
  if SMGPGateWay.Memo1.Lines.count > 500 then SMGPGateWay.Memo1.Clear;
  if SMGPGateWay.N2.Checked then
    SMGPGateWay.Memo1.Lines.Add(StatustrE + #13#10);
end;
procedure TCPSubmit.showstatu;
begin
  if SMGPGateWay.MeMO3.Lines.count > 1000 then SMGPGateWay.MeMO3.Clear;
  SMGPGateWay.MeMO3.Lines.Add(StatuTxt);
end;

procedure TCPSubmit.AddCou;
begin
  if SPS_cou > 2147483600 then SPS_cou := 1;
  inc(SPS_cou);
end;

procedure TCPSubmit.AddsSeq;
begin
  if sSequence >= 4294967200 then sSequence := 1;
  sSequence := sSequence + 1;
end;
function TCPSubmit.SubmitButDisConn(DisConnTime: TDateTime): integer;
var
  i, FirstCount: integer;
  cSubmit: PxSubmit;
  aList: TList;
  SPResponse: PResponse;
begin
  Result := 0; //返回MID
  aList := SaveSubmitList.LockList;
  FirstCount := aList.count - 1; //列表初始元素个数
  try
    for i := FirstCount downto 0 do //扫描保存区列表一遍
    begin
      cSubmit := PxSubmit(aList.Items[i]);
      if SecondsBetween(DisConnTime, cSubmit^.Then_DateTime) <= 5 then //下行链路断开前5秒没有回复回馈报告的不重发
      begin
        inc(Result);
        new(SPResponse);
        SPResponse^.MID := cSubmit^.sSubmit.MID;
        SPResponse^.Submit_resp.Status:=0;
        strpcopy(SPResponse^.Submit_resp.MsgID, '1186185' + formatdatetime('yymmddhhnn', now) + format('%.3d', [Result])); //手动生成MsgID
        ResponseList.Add(SPResponse); //放入下行回馈队列中
        Statustr := '【' + datetimetostr(now) + '】短信MID=' + #32 + cSubmit^.sSubmit.MID + #32 + '刚下发链路断开没有收到回馈报告,系统不作重发处理并当作电信网关已经成功接受';
        dispose(cSubmit);
        aList.Delete(i);
        synchronize(upmemo);
        LogList.AddLog('07' + Statustr);
      end;
    end;
  finally
    SaveSubmitList.UnlockList;
  end;
end;

procedure TCPSubmit.NoResponse_Resubmit;
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
        Statustr := '【' + datetimetostr(now()) + '】MID=' + #32 + cSubmit^.sSubmit.MID + #32 + '在' + inttostr(resptime) + '分钟后没有接收到电信回馈报告,网关作重发处理';
        synchronize(upmemo);
        LogList.AddLog('07' + Statustr);
      end;
    end;
  finally
    SaveSubmitList.UnlockList;
  end;
end;

function TCPSubmit.MakeSockBuff(var SubmitLen: integer; rSubmit: xSubmit): Longword;
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
end.

