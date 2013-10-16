{－－－－－－－－－－－－－－－－－－－－－－－－}
{                  Deliver线程                   }
{                          LUOXX                 }
{                            2004/3/11           }
{－－－－－－－－－－－－－－－－－－－－－－－－}


unit U_CTDeliver;
interface
uses
  Windows, classes, Sockets, U_MsgInfo, Smgp13_XML, U_RequestID, Htonl, SysUtils,
  winsock, ScktComp, md5, NetDisconnect, DateUtils,strutils;
{MO Thread}
type
  TCPCTDeliver = class(TThread)
  private
    CTDeliver: TTcpClient;
    Statustr: string;
    StatuTxt: string;
    StatustrE: string;
    fsleeptime: integer;
    ClientID: string;
    sharesecret: string;
    loginmode: byte;
    timeout: integer;
    HadLogin: boolean;
    Active_test_time: TDateTime; // integer;
    MO_Warnning: byte;
    ErrWarnning: TWarnning;
    ErrMsg: array of char;
    SockCanExit: boolean;
    ReceiveDeliverTime: TDateTime;

    FServiceID : String;
  protected
    procedure Execute; override;
    procedure LoginCT; {登陆过程}
    function ExitCT: boolean; {退出过程}
    procedure MO_ActiveTest; {发送链路检测包}
//    procedure Receive; {接收上行链路数据}
    procedure MOSocketError(Sender: TObject;
      SocketError: integer);
    procedure SP_Deliver_Resp(MSg_id: array of char; SequenceID: Longword);
    procedure MO_ActiveTest_Resp(CTsequence: Longword);
    procedure WriteReport(const Msgid: array of char; const Source: array of char);
    procedure SaveToDeliverList(aDeliver: TCTDeliver;const LinkID:string);
    procedure showDeliver(aDeliver: TCTDeliver;const LinkID:string);
    procedure ReceiveHead;
    procedure ReceiveBody(CTRequestID, CTsequence, Len: Longword);

    procedure ReceiveDeliver(CTsequence, Len: Longword);

    procedure upmemo;
    procedure showError;
    procedure showstatu;
    procedure AddsSeq;
    procedure AddCou;
    //3.0
    function ReceiveTLVMsg(const MsgLen:integer;var LinkID:string;var DealReslt:byte):byte;// SubmitMsgType.value
    procedure AddSyncOrdCelMsg(aDeliver: TCTDeliver;const LinkID:string);
    procedure DealWithSyncMsgCont(const msgcontent:string; var ServiceID, MsgContPart:string);
    function GetInstruct(const msgcontent:string):string;

    function GetAccessNoByServiceID(aServiceID : String) : String;
  public
    constructor create(xCT_IP, xCT_port, xClientID, xsharesecret: string; xsleeptime, xtimeout: integer; xloginmode: byte); virtual;
    destructor destroy; override;
  end;

implementation
uses U_Main, U_CTThread;

{ TCPCTDeliver }
constructor TCPCTDeliver.create(xCT_IP, xCT_port, xClientID, xsharesecret: string; xsleeptime, xtimeout: integer; xloginmode: byte);
begin
  inherited create(True);
  FreeOnTerminate := True;
  CTDeliver := TTcpClient.create(nil);
  CTDeliver.RemoteHost := xCT_IP;
  CTDeliver.RemotePort := xCT_port;
  CTDeliver.OnError := MOSocketError;
  ClientID := xClientID;
  sharesecret := xsharesecret;
  fsleeptime := xsleeptime;
  timeout := xtimeout;
  loginmode := xloginmode;
  StatuTxt := '【' + datetimetostr(now) + '】上行线程创建,电信网关服务器' + xCT_IP + ',ThreadID:' + inttostr(self.ThreadID);
  synchronize(showstatu);
  Resume;
end;
destructor TCPCTDeliver.destroy;
begin
  FreeAndNil(CTDeliver);
  StatuTxt := '【' + datetimetostr(now) + '】上行线程中止,ThreadID:' + inttostr(self.ThreadID);
  synchronize(showstatu);
  LogList.AddLog('10' + StatuTxt);
  SMGPGateWay.Label9.Caption := 'Warning:接收短信(MO)线程停止';
  ErrMsg := nil;
  inherited;
end;
procedure TCPCTDeliver.Execute;
begin
  HadLogin := False;
  MO_Warnning := 0;
  while not Terminated do
  try
    if not HadLogin then
    begin
      if MOExit then
      begin
        MOExit := False;
        break;
      end;
      LoginCT; //登陆;
    end
    else
    begin //已经登陆
      if MOExit then //如果发送退出命令
      begin
        if HadLogin then
        begin
          ExitCT; //发送退出命令
        end
        else
        begin
          MOExit := False;
          break;
        end;
      end
      else
        MO_ActiveTest; //发送链路测试
      ReceiveHead; //接收包头 调用接收包体过程
      if SockCanExit then
      begin
        MOExit := False;
        break;
      end;
      sleep(fsleeptime);
    end;

    {if MOExit then //退出
      if HadLogin then
      begin
        if ExitCT then
        begin
          MOExit := False;
          break;
        end; //退出线程
      end
      else
      begin
        MOExit := False;
        break;
      end; }
      //==============
    {if SockCanExit then
    begin
       MOExit:=False;
       break;
    end; }
    //==============
  except
    on e: exception do
    begin
      Statustr := '[' + datetimetostr(now) + ']' + 'MO Thread Error:' + e.Message;
      LogList.AddLog('10' + Statustr);
      Synchronize(upmemo);
    end;
  end;
end;
procedure TCPCTDeliver.LoginCT;
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
    str1 := ClientID + #0#0#0#0#0#0#0 + sharesecret + timestr; //用户名加密码+7个#0+登陆密码+时间
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
        StatuTxt := '【' + datetimetostr(now()) + '】SP-->CT(MO)LoginCT Request 上行连接发送登陆请求...';
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
                        StatuTxt := '【' + datetimetostr(now()) + '】(MO)Login_Resp-- >上行连接成功登陆中国电信'; HadLogin := True; MO_Warnning := 0; DCanExit := False; MOExit := False; ReceiveDeliverTime := now; LastSendWarnMsgTime := now; Counter := 0; end;
                    1:
                      begin
                        StatuTxt := '【' + datetimetostr(now()) + '】(MO)Login_Resp-- >上行连接电信回复系统忙，请稍候再拨'; CTDeliver.Close; sleep(RetryTime); end;
                    21:
                      begin
                        StatuTxt := '【' + datetimetostr(now()) + '】(MO)Login_Resp-- >上行连接电信回复认证错误！！'; CTDeliver.Close; sleep(RetryTime); end;
                  else
                    begin
                      StatuTxt := '【' + datetimetostr(now()) + '】(MO)Login_Resp-- >上行连接电信回复鉴别客户端接入请求状态 ' + inttostr(Status); CTDeliver.Close; sleep(RetryTime); end;
                  end;
                  LogList.AddLog('10' + StatuTxt);
                end;
              end
              else
              begin
                StatuTxt := '【' + datetimetostr(now()) + '】(MO)Login上行请求连接超时,链路关闭,等待' + inttostr(RetryTime div 1000) + '重新登陆...'; CTDeliver.Close; sleep(RetryTime); end;
          end;
        end
        else
        begin
          StatuTxt := '【' + datetimetostr(now()) + '】(MO)Login上行请求连接超时,链路关闭,等待' + inttostr(RetryTime div 1000) + '秒重新登陆...'; CTDeliver.Close; sleep(RetryTime); end;
        synchronize(showstatu);
      end;
  except
  end;
end;
procedure TCPCTDeliver.MO_ActiveTest;
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
        ActiveTest.SequenceID := HostToNet(dSequence);
      end;
      if sizeof(TSMGPHead) = CTDeliver.SendBuf(ActiveTest, sizeof(TSMGPHead), 0) then
      begin
        AddsSeq;
        StatuTxt := '【' + datetimetostr(now()) + '】(MO)ActiveTest 上行发送链路检测包 ' + inttostr(HostToNet(ActiveTest.SequenceID));
        synchronize(showstatu);
      end;
    end;
  end;
end;
function TCPCTDeliver.ExitCT: boolean;
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
      if sizeof(TSMGPHead) = CTDeliver.SendBuf(SMGPExit, sizeof(TSMGPHead), 0) then
      begin
        AddsSeq;
        StatuTxt := '【' + datetimetostr(now()) + '】SP-->CT(MO)ExitCT Request 上行连接发送退出请求...';
        synchronize(showstatu);
      end;
     if CTDeliver.WaitForData(timeout) then
     begin
       if sizeof(TSMGPHead) = CTDeliver.ReceiveBuf(SMGPExit_Resp, sizeof(TSMGPHead)) then
       begin
         temp := winsock.Htonl(SMGPExit_Resp.RequestID);
         if temp = Exit_resp then
         begin
           CTDeliver.Close;
           Result := True;
           DCanExit := True;
           StatuTxt := '【' + datetimetostr(now()) + '】MO ExitCT 上行连接退出与电信的连接';
           synchronize(showstatu);
         end;
           {else
             NOExitRespReceive(SMGPExit_Resp.RequestID,SMGPExit_Resp.SequenceID,SMGPExit_Resp.PacketLength);}
       end;
     end
     else
     begin
       CTDeliver.Close;
       DCanExit := True;
       Result := True;
       StatuTxt := '【' + datetimetostr(now()) + '】MO ExitCT Request 上行连接发送退出请求超时，连接已经关闭';
       synchronize(showstatu);
     end;
  except
  end;
end;

function TCPCTDeliver.ReceiveTLVMsg(const MsgLen: integer; var LinkID:string;var DealReslt:byte):byte;
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

//截取同步消息中的短信内容的业务代码,还有:号前面的部分
procedure TCPCTDeliver.DealWithSyncMsgCont(const msgcontent: string;
  var ServiceID, MsgContPart: string);
var
  pos1,pos2:integer;
begin
//  DG＋空格＋业务代码＋双空格＋受惠用户的终端号码＋冒号＋用户输入的内容
// DG mbqy010500  05974581934:05911234567
//  QX＋空格＋业务代码＋双空格＋受惠用户的终端号码＋冒号＋用户输入的内容
  if msgcontent ='00000' then
  begin
    ServiceID := msgcontent;
    FServiceID := msgcontent;
    MsgContPart := msgcontent;
    exit;
  end;
  pos1:=AnsiPos(#32,  msgcontent);
  pos2:=AnsiPos(#32#32,  msgcontent);
  ServiceID := MidStr(msgcontent, pos1+1, pos2-pos1-1);
  FServiceID := ServiceID;
  pos1:= AnsiPos(':',  msgcontent);
  if pos1=0 then
    MsgContPart := msgcontent
  else
    MsgContPart:= MidStr(msgcontent, 1, pos1-1);// 截取冒号前面得字串
end;
//截取用户输入得短信内容,
function TCPCTDeliver.GetInstruct(const msgcontent: string): string;
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

procedure TCPCTDeliver.AddSyncOrdCelMsg(aDeliver: TCTDeliver;const LinkID:string);
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
  PSubmit^.sSubmit.SubmitMsgType := 15;  
  SubmitList.Add(PSubmit);
end;

procedure TCPCTDeliver.ReceiveBody(CTRequestID, CTsequence, Len: Longword);
begin
  if CTDeliver.Connected then
  begin
    Active_test_time := now;
    if Active_test_resp = CTRequestID then
    begin {//电信发送链路测试回复}
      StatuTxt := '【' + datetimetostr(now) + '】(MO)Active_Test_Resp 电信回复上行链路正常...' + inttostr(CTsequence);
      LogList.AddLog('08' + StatuTxt);
      synchronize(showstatu);
      //提示信息
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
      Counter := 0;
      if 69 = CTDeliver.ReceiveBuf(xDeliver, 69) then
        if xDeliver.MsgLength = CTDeliver.ReceiveBuf(xDeliver.MsgContent, xDeliver.MsgLength) then
          if 8 = CTDeliver.ReceiveBuf(xDeliver.Reserve, 8) then
          begin    //再收可选参数
            if (len - sizeof(CTSMSHeader) > 69+ xDeliver.MsgLength + 8) then
            begin//接收可选参数
              SubmitMsgType := ReceiveTLVMsg(len - (77 + xDeliver.MsgLength), LinkID, DealResult)
            end;
            SP_Deliver_Resp(xDeliver.Msgid, CTsequence); //上行短信回馈CP-->CT
            isRep := xDeliver.IsReport;
            if isRep = 1 then //状态报告
              WriteReport(xDeliver.Msgid, xDeliver.MsgContent)
            else
            begin
              msg:=Copy(xDeliver.MsgContent,0, xDeliver.MsgLength);
              case SubmitMsgType of
                13://需要回复15的下行, SubmitMsgType = 15,LinkID也需要, 内容体为"DG＋空格＋业务代码＋双空格＋受惠用户的终端号码
                   //还需要再把短信内容只取用户输入的内容部分
                   begin //正向定制,取消
                     AddSyncOrdCelMsg(xDeliver, LinkID);//写入submit队列,                     
                     FillChar(xDeliver.MsgContent,sizeof(xDeliver.MsgContent),0);
                     StrpCopy(xDeliver.MsgContent, GetInstruct(msg));  //上行短信内容改为用户输入内容
                   end;
                15://反向定制,取消回复,需要把 ReSycQX+1个空格+ 上内容 + 1个空格 + DealReslt
                   begin
                      FillChar(xDeliver.MsgContent,sizeof(xDeliver.MsgContent),0);
                      StrpCopy(xDeliver.MsgContent, 'ReSyc '+ msg + #32 + inttostr(DealResult));
                   end;
              end;
              SaveToDeliverList(xDeliver, LinkID);
              synchronize(AddCou);
              showDeliver(xDeliver,LinkID);
            end; }
            {try
             fs:=Tfilestream.create( 'd:\Stream\D'+formatdatetime('ddhhnnss',now)+'.txt',fmCreate	);
             fs.WriteBuffer(xDeliver,sizeof(xDeliver));
            finally
             fs.free;
            end;}
//          end;
    end
    else if Active_test = CTRequestID then
    begin {电信发送上行链路检测包}
      StatuTxt := '【' + datetimetostr(now) + '】CT-->SP(MO)ActiveTest 电信发送上行链路测试 ' + inttostr(CTsequence);
      synchronize(showstatu);
      MO_ActiveTest_Resp(CTsequence);
    end
    else if Exit_resp = CTRequestID then
    begin {退出回复}
      CTDeliver.Close;
      DCanExit := True;
      StatuTxt := '【' + datetimetostr(now()) + '】MO ExitCT --> 上行链路退出与中国电信的连接';
      LogList.AddLog('11' + StatuTxt);
      synchronize(showstatu);
      SockCanExit := True;
      MOExit := False;
    end
    else
    begin //错误的包头命令字
      {try
        setlength(ErrMsg, Len - 12);
        CTDeliver.ReceiveBuf(ErrMsg, Len - 12);
        ErrMsg := nil;
      except
      end;
      StatuTxt := '【' + datetimetostr(now()) + '】MO 接收到类型错误的消息包';
      synchronize(showstatu); }
      CTDeliver.Close;
    end;
  end;
end;

procedure TCPCTDeliver.MOSocketError(Sender: TObject; SocketError: integer);
var
  Error: integer;
begin
  Error := SocketError;
  SocketError := 0;
  DCanExit := True;
  StatuTxt := '【' + datetimetostr(now) + '】(MO)上行链路发生网络故障' + inttostr(Error) + ',等待' + inttostr(RetryTime div 1000) + '秒再次登陆...';
  synchronize(showstatu);
  LogList.AddLog('10' + StatuTxt);
  inc(MO_Warnning);
  if MO_Warnning > 10 then ErrWarnning := TWarnning.create;
  HadLogin := False;
  sleep(RetryTime);
end;

procedure TCPCTDeliver.MO_ActiveTest_Resp(CTsequence: Longword);
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
      StatuTxt := '【' + datetimetostr(now()) + '】SP-->CT(MO)ActiveTest_Resp SP回复上行链路正常... ' + inttostr(CTsequence);
      synchronize(showstatu);
    end;
end;

procedure TCPCTDeliver.upmemo;
begin
  if SMGPGateWay.MeMO1.Lines.count > 500 then SMGPGateWay.MeMO1.Clear;
  if SMGPGateWay.N3.Checked then
    SMGPGateWay.MeMO1.Lines.Add(Statustr + #13#10);
  SMGPGateWay.StatusBar1.Panels[1].Text := 'T: ' + inttostr(CTD_cou);
  SMGPGateWay.StatusBar1.Refresh;
end;

procedure TCPCTDeliver.showError;
begin
  if SMGPGateWay.MeMO1.Lines.count > 500 then SMGPGateWay.MeMO1.Clear;
  if SMGPGateWay.N2.Checked then
    SMGPGateWay.MeMO1.Lines.Add(StatustrE + #13#10);
end;
procedure TCPCTDeliver.showstatu;
begin
  if SMGPGateWay.MeMO3.Lines.count > 1000 then SMGPGateWay.MeMO3.Clear;
  SMGPGateWay.MeMO3.Lines.Add(StatuTxt);
end;

procedure TCPCTDeliver.AddCou;
begin
  if CTD_cou > 2147483600 then CTD_cou := 1;
  inc(CTD_cou);
end;

procedure TCPCTDeliver.AddsSeq;
begin
  if dSequence >= 4294967200 then dSequence := 1;
  dSequence := dSequence + 1;
end;

procedure TCPCTDeliver.WriteReport(const Msgid: array of char; const Source: array of char);
var
  CTReport: PReport;
  buff: array[0..19] of char;
  //temp: string;
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
  {move(Source[101], buff, 3); // Txt前3个byte
  temp := buff;
  FillChar(buff, sizeof(buff), 0);
  move(Source[108], buff, 12); //后12个BYTE
  temp := temp + buff;
  CTReport^.Txt := temp; }
  move(Source[102], buff, 20);
  CTReport^.Txt := buff;
  ReportList.Add(CTReport);
  Statustr := '[' + datetimetostr(now) + ']Report:';
  Statustr := Statustr +'<MsgID>'+CTReport^.id + #32;
  Statustr := Statustr +'<Stat>'+ CTReport^.Stat + #32;
  Statustr := Statustr +'<Err>'+ CTReport^.Err;
  Statustr := Statustr +'<Submit_date>'+CTReport^.Submit_date + #32;
  Statustr := Statustr +'<done_date>'+ CTReport^.done_date + #32; 
  LogList.AddLog('04' + Statustr);
  synchronize(upmemo);
end;
//===============================================================================
procedure TCPCTDeliver.showDeliver(aDeliver: TCTDeliver;const LinkID:string);
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
  synchronize(upmemo);
end;
//===========================================================================
procedure TCPCTDeliver.SaveToDeliverList(aDeliver: TCTDeliver;const LinkID:string); //短信
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
  else if (aDeliver.MsgFormat = 15) or (aDeliver.MsgFormat = 0)  then
    pDeliver^.MsgContent := aDeliver.MsgContent
  else if aDeliver.IsReport = 9 then
  begin {用户拆机、停机消息}
    pDeliver^.MsgContent := copy(aDeliver.MsgContent, 1, 12);
    pDeliver^.MsgContent := pDeliver^.MsgContent + aDeliver.MsgContent[17];
  end;
  pDeliver^.LinkID := LinkID;
  DeliverList.Add(pDeliver); //放入DELIVER队列中
end;

//=================================================================================
procedure TCPCTDeliver.SP_Deliver_Resp(MSg_id: array of char; SequenceID: Longword);
var
  SPDeliver_Resp: TDeliver_Resp; // 上行回馈
  Msgid: string;
begin
  FillChar(SPDeliver_Resp, sizeof(TDeliver_Resp), 0);
  SPDeliver_Resp.Head.PacketLength := HostToNet(sizeof(TDeliver_Resp));
  SPDeliver_Resp.Head.RequestID := HostToNet(Deliver_resp);
  SPDeliver_Resp.Head.SequenceID := HostToNet(SequenceID);
  move(MSg_id, SPDeliver_Resp.body.Msgid, 10);
  Msgid := BCDToHex(MSg_id, 10);
  SPDeliver_Resp.body.Status := HostToNet(0);
  if CTDeliver.Connected then
    if sizeof(TDeliver_Resp) = CTDeliver.SendBuf(SPDeliver_Resp, sizeof(TDeliver_Resp)) then
    begin
      Statustr := '[' + datetimetostr(now()) + ']Deliver_Resp:' + Msgid;
      synchronize(upmemo);
    end;
end;

procedure TCPCTDeliver.ReceiveHead;
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

procedure TCPCTDeliver.ReceiveDeliver(CTsequence,
  Len: Longword);
var
  xDeliver: TCTDeliver;
  isRep: byte;
  LinkID, aStr:string;
  SubmitMsgType,DealResult:byte;
  Msg:string;

  pos1,pos2:integer;
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
               begin //正向  定制,取消回复
                 AddSyncOrdCelMsg(xDeliver, LinkID);//写入submit队列,
                 //上行短信内容改为用户输入内容
                 msg:=Copy(xDeliver.MsgContent,0, xDeliver.MsgLength);
                 FillChar(xDeliver.MsgContent,sizeof(xDeliver.MsgContent),0);
                 StrpCopy(xDeliver.MsgContent, GetInstruct(msg));

                 if (FServiceID<>'') and (FServiceID<>'00000') then
                 begin
                   aStr := GetAccessNoByServiceID(FServiceID);
                   StrpCopy(xDeliver.DestTermID, aStr);
                 end;  
               end;
            15://反向--定制,取消回复,  
               begin //重新整理格式 ReSyc+1个空格+上内容+1个空格+DealReslt
                 msg:=Copy(xDeliver.MsgContent,0, xDeliver.MsgLength);
                 FillChar(xDeliver.MsgContent,sizeof(xDeliver.MsgContent),0);
                 StrpCopy(xDeliver.MsgContent, 'RESYC '+ msg + #32 + inttostr(DealResult));
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

function TCPCTDeliver.GetAccessNoByServiceID(aServiceID: String): String;
var
  i, iPos : Integer;
  aStr : String;
begin
  Result := '';
  if aServiceID='' then Exit;
  if (AccessNoStrList=nil) or (AccessNoStrList.Count<1) then Exit;
  For i := 0 to AccessNoStrList.Count - 1 do
  begin
    aStr := AccessNoStrList.Strings[i];
    if AnsiPos(UpperCase(aServiceID), UpperCase(aStr))>0 then
    begin
      iPos := AnsiPos(':',aStr);
      Result := MidStr(aStr,iPos+1,Length(aStr)-iPos);
      Exit;
    end;
  end;  
end;

end.

