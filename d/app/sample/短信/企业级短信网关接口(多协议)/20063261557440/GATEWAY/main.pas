{
2005/12/25
圣诞节，把所有的程序再整理一次，公布，不过此代码还属于半成品，SGIP没有开发完，因
为没有实际的网关可以用 CMPP也有2.0,CMPP3.0同样原因没有开发。
如果谁采用此代码，并有修改成功的代码，请发扬共享精神，也为了DLEPHI更好的发展，公
布成果。如果不公布代码：请看此结果，根据51JOB搜索，非DELPHI工作机会>2000；DELPHI
的<10;哥们，您说呢？我将公布更多的代码，都是实际运用企业级的，一套代码的价值都在
20万以上，这些都是市场的回报，很有潜力。共同延续一下DELPHI的生命。

请访问：www.cnrenwy.com 也许您看到的时候，还没有建设
特别注意：www.cnrenwy.com 我将着力建设 请随时留意 不定期放出 代码；特别是这些代
码在某些收费网站需要 一定金额才可以获得。（争取1月挂出）
注：此份代码部分参考网络 上寻得的部分代码 采用时 提供方未申诉权益
 
unit main;

interface

uses

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, IdBaseComponent, IdComponent, IdTCPConnection, md5, IdTCPClient,
  ComCtrls, StdCtrls, ExtCtrls, IdUDPBase, IdUDPClient, Buffer, DB, ADODB,
  IdAntiFreezeBase, IdAntiFreeze, SPPO10,global,  SMGP13, cmpp20, SGIP12, Activex;

type
  //电信，小灵通
  TOutPacket = class
  public
    pac: TSMGP13_PACKET;
    constructor Create(p: TSMGP13_PACKET);
    destructor destroy; override;
  end;

  //移动
  TOutcmppPacket = class
  public
    pac: TCMPP20_PACKET;
    constructor Create(p: TCMPP20_PACKET);
    destructor destroy; override;
  end;

  //联通
  TOutSgipPacket = class
  public
    pac: TSGIP12_PACKET;
    constructor Create(p: TSGIP12_PACKET);
    destructor destroy; override;
  end;

  //MT群发线程
  TMtQfThread = class(TThread)
    LastActiveTime: TDateTime;
    ErrMsg: string;
    AdoConnection: TADOConnection;
    AdoQuery: TAdoQuery;
    HaveMc: boolean;
  private
    Seqid: integer;
    function GetSeqid: integer;
    function GetInMsgId: string;
  protected
    procedure Execute; override;
    procedure AddMsgToMemo(const Msg: string);
    procedure ThAddMsgToMemo;
  public
    constructor Create(CreateSuspended: boolean); overload;
    destructor destroy; override;
    procedure ConnectDB;

    //话单优先级最高，高优先级是指优先级为9的群发数据，低优先级是指9以下的群发数据
    procedure LowPriorityQf; //低优先级群发
    procedure HighPriovityQf; //高优先级群发
    procedure McQf; //话单群发
  end;

  //监控线程
  TMonitorThreadObj = class(TThread)
    LastActiveTime: TDateTime;
    OutListview: TListView;
    InListview: TListView;
    InMonitorBuffer: TMonitorInBufferObj;
    OutMonitorBuffer: TMonitorOutBufferObj;
    OutMonitorcmppBuffer: TMonitorOutcmppBufferObj;
    OutMonitorSgipBuffer: TMonitorOutSgipBufferObj;
    ErrMsg: string;
    LastPrcExpireTime: TDateTime;
  protected
    procedure Execute; override;
    procedure AddMsgToMemo(const Msg: string);
    procedure ThAddMsgToMemo;
  public
    constructor Create(CreateSuspended: boolean); overload;
    destructor destroy; override;
    procedure ShowOutPac(pac: TSMGP13_PACKET);
    procedure ShowOutcmppPac(pac: TCMPP20_PACKET);
    procedure ShowOutSgipPac(pac: TSGIP12_PACKET);
  end;

  //MT消息预处理线程
  TMtPrePrcThreadObj = class(TThread)
    LastActiveTime: TDateTime;
    ErrMsg: string;
  protected
    procedure Execute; override;
    procedure AddMsgToMemo(const Msg: string);
    procedure ThAddMsgToMemo;
  public
    constructor Create(CreateSuspended: boolean); overload;
    destructor destroy; override;
    procedure MtPrePrc;
  end;

  //日志记录线程
  TLogThreadObj = class(TThread)
    LastActiveTime: TDateTime;
    ErrMsg: string;
    AdoConnection: TADOConnection;
    AdoQuery: TAdoQuery;
  private
    procedure LogMt;
    procedure LogMo;
    procedure LogRpt;
  protected
    procedure AddMsgToMemo(const Msg: string);
    procedure ThAddMsgToMemo;
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: boolean); overload;
    destructor destroy; override;
    procedure ConnectDB;
    procedure CreateRpt(Buffer: TMtBuffer);
  end;

  //SMGP MT消息发送线程
  TMtSendSMGPThreadObj = class(TThread)
    LastActiveTime: TDateTime;
    ErrMsg: string;
  protected
    procedure Execute; override;
    procedure AddMsgToMemo(const Msg: string);
    procedure ThAddMsgToMemo;
  public
    constructor Create(CreateSuspended: boolean); overload;
    destructor destroy; override;
    procedure MtPrc;
  end;

  //外部网关消息接收线程   (到运营商SMGP主要线程)
  TOutReadSMGPThreadObj = class(TThread)
    FTCPClient: TIdTCPClient;
    FRecBuffer: TCOMMBuffer;
    FlocPacketIn: TSMGP13_PACKET;
    FnetPacketIn: TSMGP13_PACKET;
    FLogined: boolean; //是否已登录成功
    FMoCount: Cardinal; //Mo计数器
    FMtCount: Cardinal; //Mt计数器
    FMtRespCount: Cardinal; //Mt应答计数哭
    FMtRefuseCount: Cardinal; //Mt拒绝计数哭
    FRptCount: Cardinal; //状态报告计数器
    FLastActiveTime: TDateTime; //最后活动时间
    LastSendActiveTime: TDateTime; //最后发送活动测试包的时间
    LastLoginTime: TDateTime; //最后发送登录包的时间
    ErrMsg: string; //错误消息
    MtMessage: string;
    MtNumber: string;
    MtUnsend: integer;
    MtHasUnsendMessage: boolean;
    WindowSize: integer; //滑动窗口大小
    Seqid: Cardinal; //序号
    log_smgp_time: integer;
  protected
    procedure Execute; override;
    procedure AddMsgToMemo(const Msg: string);
    procedure ThAddMsgToMemo;
  public
    constructor Create(CreateSuspended: boolean); overload;
    destructor destroy; override;
    procedure ClientRead;
    function CreatePacket(const RequestID: Cardinal): TSMGP13_PACKET;
    function CreateRespPacket(const recpac: TSMGP13_PACKET): TSMGP13_PACKET;
    function GetSeqid: Cardinal;
    procedure SendPacket(pac: TSMGP13_PACKET);
    procedure SendMt(i: integer);
    procedure PrcMt;
  end;

  //CMPP MT消息发送线程
  TMtSendCMPPThreadObj = class(TThread)
    LastActiveTime: TDateTime;
    ErrMsg: string;
  protected
    procedure Execute; override;
    procedure AddMsgToMemo(const Msg: string);
    procedure ThAddMsgToMemo;
  public
    constructor Create(CreateSuspended: boolean); overload;
    destructor destroy; override;
    procedure MtPrc;
  end;

  //外部网关消息接收线程   (到运营商cmpp主要线程)
  TOutReadCMPPThreadObj = class(TThread)
    FTCPCmppClient: TIdTCPClient; //下行
    FRecCmppBuffer: TCOMMBuffer;
    FlocCmppPacketIn: TCMPP20_PACKET;
    FnetCmppPacketIn: TCMPP20_PACKET;
    FLogined: boolean; //是否已登录成功
    FMoCount: Cardinal; //Mo计数器
    FMtCount: Cardinal; //Mt计数器
    FMtRespCount: Cardinal; //Mt应答计数哭
    FMtRefuseCount: Cardinal; //Mt拒绝计数哭
    FRptCount: Cardinal; //状态报告计数器
    FLastActiveTime: TDateTime; //最后活动时间
    LastSendActiveTime: TDateTime; //最后发送活动测试包的时间
    LastLoginTime: TDateTime; //最后发送登录包的时间
    ErrMsg: string; //错误消息
    MtMessage: string;
    MtNumber: string;
    MtUnsend: integer;
    MtHasUnsendMessage: boolean;
    WindowSize: integer; //滑动窗口大小
    Seqid: Cardinal; //序号
    log_cmpp_time: integer;
    log_port: integer; //尝试同时 一个端口 两个 端口号同时登陆 ？？？？
  protected
    procedure Execute; override;
    procedure AddMsgToMemo(const Msg: string);
    procedure ThAddMsgToMemo;
  public
    constructor Create(CreateSuspended: boolean); overload;
    destructor destroy; override;
    procedure ClientRead;
    function CreatePacket(const RequestID: Cardinal): TCMPP20_PACKET; //构建CMPP包
    function CreateRespPacket(const recpac: TCMPP20_PACKET): TCMPP20_PACKET;
    function GetSeqid: Cardinal;
    procedure SendPacket(pac: TCMPP20_PACKET); //构建CMPP包
    procedure SendMt(i: integer);
    procedure PrcMt;
  end;

  //CMPP0 MT消息发送线程
  TMtSendCMPP0ThreadObj = class(TThread)
    LastActiveTime: TDateTime;
    ErrMsg: string;
  protected
    procedure Execute; override;
    procedure AddMsgToMemo(const Msg: string);
    procedure ThAddMsgToMemo;
  public
    constructor Create(CreateSuspended: boolean); overload;
    destructor destroy; override;
    procedure MtPrc;
  end;

  //外部网关消息接收线程   (到运营商cmpp0主要线程)
  TOutReadCMPP0ThreadObj = class(TThread)
    FTCPCmppClient: TIdTCPClient; //下行
    FRecCmppBuffer: TCOMMBuffer;
    FlocCmppPacketIn: TCMPP20_PACKET;
    FnetCmppPacketIn: TCMPP20_PACKET;
    FLogined: boolean; //是否已登录成功
    FMoCount: Cardinal; //Mo计数器
    FMtCount: Cardinal; //Mt计数器
    FMtRespCount: Cardinal; //Mt应答计数哭
    FMtRefuseCount: Cardinal; //Mt拒绝计数哭
    FRptCount: Cardinal; //状态报告计数器
    FLastActiveTime: TDateTime; //最后活动时间
    LastSendActiveTime: TDateTime; //最后发送活动测试包的时间
    LastLoginTime: TDateTime; //最后发送登录包的时间
    ErrMsg: string; //错误消息
    MtMessage: string;
    MtNumber: string;
    MtUnsend: integer;
    MtHasUnsendMessage: boolean;
    WindowSize: integer; //滑动窗口大小
    Seqid: Cardinal; //序号
    log_cmpp_time: integer;
    log_port: integer; //尝试同时 一个端口 两个 端口号同时登陆 ？？？？
  protected
    procedure Execute; override;
    procedure AddMsgToMemo(const Msg: string);
    procedure ThAddMsgToMemo;
  public
    constructor Create(CreateSuspended: boolean); overload;
    destructor destroy; override;
    procedure ClientRead;
    function CreatePacket(const RequestID: Cardinal): TCMPP20_PACKET; //构建CMPP包
    function CreateRespPacket(const recpac: TCMPP20_PACKET): TCMPP20_PACKET;
    function GetSeqid: Cardinal;
    procedure SendPacket(pac: TCMPP20_PACKET); //构建CMPP包
    procedure PrcMt;
  end;

  //Sgip MT消息发送线程
  TMtSendSgipThreadObj = class(TThread)
    LastActiveTime: TDateTime;
    ErrMsg: string;
  protected
    procedure Execute; override;
    procedure AddMsgToMemo(const Msg: string);
    procedure ThAddMsgToMemo;
  public
    constructor Create(CreateSuspended: boolean); overload;
    destructor destroy; override;
    procedure MtPrc;
  end;

  //外部网关消息接收线程   (到运营商SGIP主要线程)
  TOutReadSgipThreadObj = class(TThread)
    FTCPClient: TIdTCPClient;
    FRecBuffer: TCOMMBuffer;
    FlocPacketIn: TSGIP12_PACKET;
    FnetPacketIn: TSGIP12_PACKET;
    FLogined: boolean; //是否已登录成功
    FMoCount: Cardinal; //Mo计数器
    FMtCount: Cardinal; //Mt计数器
    FMtRespCount: Cardinal; //Mt应答计数哭
    FMtRefuseCount: Cardinal; //Mt拒绝计数哭
    FRptCount: Cardinal; //状态报告计数器
    FLastActiveTime: TDateTime; //最后活动时间
    LastSendActiveTime: TDateTime; //最后发送活动测试包的时间
    LastLoginTime: TDateTime; //最后发送登录包的时间
    ErrMsg: string; //错误消息
    MtMessage: string;
    MtNumber: string;
    MtUnsend: integer;
    MtHasUnsendMessage: boolean;
    WindowSize: integer; //滑动窗口大小
    Seqid: Cardinal; //序号
    log_smgp_time: integer;
  protected
    procedure Execute; override;
    procedure AddMsgToMemo(const Msg: string);
    procedure ThAddMsgToMemo;
  public
    constructor Create(CreateSuspended: boolean); overload;
    destructor destroy; override;
    procedure ClientRead;
    function CreatePacket(const RequestID: Cardinal): TSGIP12_PACKET;
    function CreateRespPacket(const recpac: TSGIP12_PACKET): TSGIP12_PACKET;
    function GetSeqid: Cardinal;
    procedure SendPacket(pac: TSGIP12_PACKET);
    procedure SendMt(i: integer); //发送线程
    procedure PrcMt;
  end;

  TMainForm = class(TForm)
    SMGPTCPClient: TIdTCPClient;
    CmppTCPClient: TIdTCPClient;
    Cmpp0TCPClient: TIdTCPClient;
    SgipTCPClient: TIdTCPClient;
    PageControl1: TPageControl;
    StatusBar1: TStatusBar;
    TabSheet1: TTabSheet;
    TabSheet3: TTabSheet;
    Panel1: TPanel;
    OutListview: TListView;
    Splitter2: TSplitter;
    OutPMemo: TMemo;
    MonitorMemo: TMemo;
    IdAntiFreeze1: TIdAntiFreeze;
    AdoConnection: TADOConnection;
    AdoQuery: TAdoQuery;
    OutPopupMenu: TPopupMenu;
    OutMonitor: TMenuItem;
    N11: TMenuItem;
    MonitorTimer: TTimer;
    Timer1: TTimer;
    Label3: TLabel;
    Splitter1: TSplitter;
    MOMemo: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SMGPTCPClientConnected(Sender: TObject);
    procedure SMGPTCPClientDisconnected(Sender: TObject);
    procedure CmppTCPClientConnected(Sender: TObject);
    procedure CmppTCPClientDisconnected(Sender: TObject);
    procedure Cmpp0TCPClientConnected(Sender: TObject);
    procedure Cmpp0TCPClientDisconnected(Sender: TObject);
    procedure SgipTCPClientConnected(Sender: TObject);
    procedure SgipTCPClientDisconnected(Sender: TObject);
    procedure OutListViewAdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: boolean);
    procedure OutListViewDblClick(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure InListViewAdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: boolean);
    procedure N9Click(Sender: TObject);
    procedure MonitorTimerTimer(Sender: TObject);
    procedure MonitorMemoChange(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    { Private declarations }
    OutLastConnectTime: TDateTime; //SMGP 最后连接时间
    OutLastCMPPConnectTime: TDateTime; //cmpp 最后连接时间
    OutLastCMPP0ConnectTime: TDateTime; //cmpp0 最后连接时间
    OutLastSgipConnectTime: TDateTime; //SGiP 最后连接时间
  public
    procedure ShowToMemo(s: string; m: TMemo);
    function ReadConfig: boolean; //读取备至文件
    procedure ConnectDB(AdoConnection: TADOConnection); //连接到数据库
    procedure LoadServiceCode; //暂时不使用 自己研究吧
    procedure LoadProtocol; //暂时不使用 自己研究吧
    procedure smcmo; //SMGP MO处理 SMG--SP
    procedure smcmo0; //CMPP MO处理 SMG--SP
    procedure smcmt; //MT处理 SP--SMG
  end;

var
  MainForm: TMainForm;
  MonitorThread: TMonitorThreadObj;
  MtPrePrcThread: TMtPrePrcThreadObj;
  MtQfThread: TMtQfThread;
  LogThread: TLogThreadObj;
  OutReadThread: TOutReadSMGPThreadObj; //smgp 线程
  MtSendThread: TMtSendSMGPThreadObj;
  OutReadCMPPThread: TOutReadCMPPThreadObj; //cmpp 线程
  MtSendCMPPThread: TMtSendCMPPThreadObj;
  OutReadCMPP0Thread: TOutReadCMPP0ThreadObj; //cmpp0 线程
  MtSendCMPP0Thread: TMtSendCMPP0ThreadObj;
  OutReadSgipThread: TOutReadSgipThreadObj; //sgip 线程
  MtSendSgipThread: TMtSendSgipThreadObj;
implementation
uses
  WinSock, Md5unit, Cryptcon, IniFiles, DateUtils;
{$R *.dfm}

{ TMtQfThread }
procedure TMtQfThread.AddMsgToMemo(const Msg: string);
begin
  ErrMsg := Msg;
  Synchronize(ThAddMsgToMemo);
end;

constructor TMtQfThread.Create(CreateSuspended: boolean);
begin
  inherited;
  LastActiveTime := now;
  AdoConnection := TADOConnection.Create(nil);
  AdoQuery := TAdoQuery.Create(nil);
  AdoQuery.Connection := AdoConnection;
  Seqid := 1;
  HaveMc := false;
end;

destructor TMtQfThread.destroy;
begin
  AdoQuery.Free;
  AdoConnection.Free;
  LastActiveTime := 0;
  inherited;
end;

procedure TMtQfThread.Execute;
var
  iHour: integer;
  strSql: string;
  iDay: integer;
begin
  FreeOnTerminate := True;
  while not Terminated do
  begin
    try
      try
        if AdoConnection.Connected then
        begin
          iHour := hourof(now);
          iDay := Dayof(now);
          {if MainForm.HUADAN.Checked then
          begin
            if (iDay >= GGATECONFIG.MCSTART) and (iDay < GGATECONFIG.MCEND) then
            begin
              McQf;
            end;
          end;
        }
          //高优先级
          HighPriovityQf;

          //低优先级,有限制时段
          {if (iHour in [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21]) and (HaveMc = false) then
          begin
            if MainForm.QUNFA.Checked then
            begin
              LowPriorityQf;
            end;
          end; }

          //将已处理，且有状态报告的数据删除
          strSql := 'delete MTSEND where PrcEd = 1 and Gateid = ' + inttostr(GSMSCENTERCONFIG.GateId) + ' and status is not null';
          AdoConnection.Execute(strSql);
          //将已过72小时，都未有状态报告的，更新状态报告为2，发送失败
          strSql := 'update MTSEND set status = 2 where PrcEd = 1 and Gateid = ' + inttostr(GSMSCENTERCONFIG.GateId) + ' and getdate() - sendtime > 3';
          AdoConnection.Execute(strSql);
        end
        else
        begin
          ConnectDB;
          sleep(3000);
        end;
      except
        on e: exception do
        begin
          AddMsgToMemo('MT群发线程:' + e.Message);

          if e.Message = '连接失败' then
          begin
            AdoConnection.Close;
          end;

        end;
      end;
    finally
      LastActiveTime := now;
      sleep(1000);
    end;
  end;
end;

function TMtQfThread.GetInMsgId: string;
var
  str: string;
  i: integer;
begin
  //3位网关号 + 14 yyyymmddhhnnss + 3序号,共20
  str := copy(inttostr(GSMSCENTERCONFIG.GateId), 2, 3) + FormatDatetime('yyyymmddhhnnss', now);
  i := GetSeqid;
  if i >= 100 then
  begin
    str := str + inttostr(i);
  end
  else if i >= 10 then
  begin
    str := str + '0' + inttostr(i);
  end
  else
  begin
    str := str + '00' + inttostr(i);
  end;
  result := str;
end;

function TMtQfThread.GetSeqid: integer;
begin
  result := Seqid;
  inc(Seqid);
  if Seqid >= 1000 then
  begin
    Seqid := 1;
  end;
end;

procedure TMtQfThread.HighPriovityQf;
var
  MtBufferCount: integer;
  strSql: string;
  pac: TSPPO_PACKET;
  Autoid: integer;
  MtInMsgId: string;
begin
  MtBufferCount := mtbuffer.Count;
  if MtBufferCount < GGATECONFIG.Flux then
  begin
    strSql := 'select top ' + inttostr(GGATECONFIG.Flux) + ' * from mtsend where gateid = ' + inttostr(GSMSCENTERCONFIG.GateId) + ' and Prced = 0 and Priority = 9 order by autoid';
    ;
    AdoQuery.Close;
    AdoQuery.SQL.Text := strSql;
    AdoQuery.Open;
    while not AdoQuery.Eof do
    begin
      ZeroMemory(@pac, sizeof(TSPPO_PACKET));
      Autoid := AdoQuery.fieldbyname('Autoid').AsInteger;
      pac.Body.Mt.MtLogicId := 1; //群发
      pac.Body.Mt.MtMsgType := 1; //非MO引起的MT
      pac.Body.Mt.MoOutMsgId := '';
      pac.Body.Mt.MoInMsgId := '';
      MtInMsgId := GetInMsgId;
      HexToChar(MtInMsgId, pac.Body.Mt.MtInMsgId);
      pac.Body.Mt.MoLinkId := '';

      SetPchar(pac.Body.Mt.MtSpAddr, AdoQuery.fieldbyname('MtSpAddr').AsString, sizeof(pac.Body.Mt.MtSpAddr));
      SetPchar(pac.Body.Mt.MtUserAddr, AdoQuery.fieldbyname('MtUserAddr').AsString, sizeof(pac.Body.Mt.MtUserAddr));
      SetPchar(pac.Body.Mt.MtFeeAddr, AdoQuery.fieldbyname('MtUserAddr').AsString, sizeof(pac.Body.Mt.MtFeeAddr));
      SetPchar(pac.Body.Mt.MtServiceId, AdoQuery.fieldbyname('MtServiceId').AsString, sizeof(pac.Body.Mt.MtServiceId));
      pac.Body.Mt.MtMsgFmt := 15;
      pac.Body.Mt.MtMsgLenth := length(AdoQuery.fieldbyname('MtMsgContent').AsString);
      SetPchar(pac.Body.Mt.MtMsgContent, AdoQuery.fieldbyname('MtMsgContent').AsString, pac.Body.Mt.MtMsgLenth);

      mtbuffer.Add(pac);
      strSql := 'update MTSEND set PrcEd = 1, MtInMsgId = ' + Quotedstr(MtInMsgId) + ' where autoid = ' + inttostr(Autoid);
      AdoConnection.Execute(strSql);
      AdoQuery.MoveBy(1);
    end;
    AdoQuery.Close;
  end;
end;

procedure TMtQfThread.LowPriorityQf;
var
  MtBufferCount: integer;
  strSql: string;
  pac: TSPPO_PACKET;
  Autoid: integer;
  MtInMsgId: string;
  ValidTime: string;
begin
  MtBufferCount := mtbuffer.Count;
  if MtBufferCount < GGATECONFIG.Flux then
  begin
    strSql := 'select top ' + inttostr(GGATECONFIG.Flux * 3) + ' * from mtsend where gateid = ' + inttostr(GSMSCENTERCONFIG.GateId) + ' and Prced = 0 order by autoid';
    AdoQuery.Close;
    AdoQuery.SQL.Text := strSql;
    AdoQuery.Open;
    while not AdoQuery.Eof do
    begin
      ZeroMemory(@pac, sizeof(TSPPO_PACKET));
      Autoid := AdoQuery.fieldbyname('Autoid').AsInteger;
      pac.Body.Mt.MtLogicId := 1; //群发
      pac.Body.Mt.MtMsgType := 1; //非MO引起的MT
      pac.Body.Mt.MoOutMsgId := '';
      pac.Body.Mt.MoInMsgId := '';
      MtInMsgId := GetInMsgId;
      HexToChar(MtInMsgId, pac.Body.Mt.MtInMsgId);
      pac.Body.Mt.MoLinkId := '';

      SetPchar(pac.Body.Mt.MtSpAddr, AdoQuery.fieldbyname('MtSpAddr').AsString, sizeof(pac.Body.Mt.MtSpAddr));
      SetPchar(pac.Body.Mt.MtUserAddr, AdoQuery.fieldbyname('MtUserAddr').AsString, sizeof(pac.Body.Mt.MtUserAddr));
      SetPchar(pac.Body.Mt.MtFeeAddr, AdoQuery.fieldbyname('MtUserAddr').AsString, sizeof(pac.Body.Mt.MtFeeAddr));
      SetPchar(pac.Body.Mt.MtServiceId, AdoQuery.fieldbyname('MtServiceId').AsString, sizeof(pac.Body.Mt.MtServiceId));
      pac.Body.Mt.MtMsgFmt := 15;
      pac.Body.Mt.MtMsgLenth := length(AdoQuery.fieldbyname('MtMsgContent').AsString);
      SetPchar(pac.Body.Mt.MtMsgContent, AdoQuery.fieldbyname('MtMsgContent').AsString, pac.Body.Mt.MtMsgLenth);

      mtbuffer.Add(pac);
      strSql := 'update MTSEND set PrcEd = 1, MtInMsgId = ' + Quotedstr(MtInMsgId) + ' where autoid = ' + inttostr(Autoid);
      AdoConnection.Execute(strSql);
      AdoQuery.MoveBy(1);
    end;
    AdoQuery.Close;
  end;
end;

procedure TMtQfThread.McQf;
var
  MtBufferCount: integer;
  strSql: string;
  pac: TSPPO_PACKET;
  Autoid: integer;
  MtInMsgId: string;
begin
  //发送话单
  MtBufferCount := mtbuffer.Count;
  if MtBufferCount < GGATECONFIG.Flux then
  begin
    strSql := 'select top ' + inttostr(GGATECONFIG.Flux * 3) + ' * from mcsend where gateid = ' + inttostr(GSMSCENTERCONFIG.GateId) + ' and Prced = 0 and Priority = 9 order by autoid';
    ;
    AdoQuery.Close;
    AdoQuery.SQL.Text := strSql;
    AdoQuery.Open;
    if not AdoQuery.Eof then
    begin
      //有话单数据
      while not AdoQuery.Eof do
      begin
        ZeroMemory(@pac, sizeof(TSPPO_PACKET));
        Autoid := AdoQuery.fieldbyname('Autoid').AsInteger;
        pac.Body.Mt.MtLogicId := 2; //话单
        pac.Body.Mt.MtMsgType := AdoQuery.fieldbyname('InMtMsgType').AsInteger;
        pac.Body.Mt.MoOutMsgId := '';
        pac.Body.Mt.MoInMsgId := '';
        MtInMsgId := GetInMsgId;
        HexToChar(MtInMsgId, pac.Body.Mt.MtInMsgId);
        pac.Body.Mt.MoLinkId := '';
        SetPchar(pac.Body.Mt.MtSpAddr, AdoQuery.fieldbyname('MtSpAddr').AsString, sizeof(pac.Body.Mt.MtSpAddr));
        SetPchar(pac.Body.Mt.MtUserAddr, AdoQuery.fieldbyname('MtUserAddr').AsString, sizeof(pac.Body.Mt.MtUserAddr));
        SetPchar(pac.Body.Mt.MtFeeAddr, AdoQuery.fieldbyname('MtUserAddr').AsString, sizeof(pac.Body.Mt.MtFeeAddr));
        SetPchar(pac.Body.Mt.MtServiceId, AdoQuery.fieldbyname('MtServiceId').AsString, sizeof(pac.Body.Mt.MtServiceId));
        pac.Body.Mt.MtMsgFmt := 15;
        pac.Body.Mt.MtMsgLenth := length(AdoQuery.fieldbyname('MtMsgContent').AsString);
        SetPchar(pac.Body.Mt.MtMsgContent, AdoQuery.fieldbyname('MtMsgContent').AsString, pac.Body.Mt.MtMsgLenth);
        mtbuffer.Add(pac);
        strSql := 'update MCSEND set PrcEd = 1, MtInMsgId = ' + Quotedstr(MtInMsgId) + ', Sendtime = getdate() where autoid = ' + inttostr(Autoid);
        AdoConnection.Execute(strSql);
        AdoQuery.MoveBy(1);
      end;
      HaveMc := True;
    end
    else
    begin
      HaveMc := false;
    end;
    AdoQuery.Close;

    if HaveMc = false then
    begin
      //发送本月已经发送，但发送失败的话单
      strSql := 'select top 1 * from MCSEND where gateid = ' + inttostr(GSMSCENTERCONFIG.GateId) + ' and PrcEd = 1 and McMonth = ' + Quotedstr(FormatDatetime('yyyymm', now)) + ' and (Status <> 1 or status is null) and getdate() > sendtime + 1 order by autoid';
      AdoQuery.Close;
      AdoQuery.SQL.Text := strSql;
      AdoQuery.Open;
      if not AdoQuery.Eof then
      begin
        ZeroMemory(@pac, sizeof(TSPPO_PACKET));
        Autoid := AdoQuery.fieldbyname('Autoid').AsInteger;
        pac.Body.Mt.MtLogicId := 2; //话单
        pac.Body.Mt.MtMsgType := AdoQuery.fieldbyname('InMtMsgType').AsInteger;
        pac.Body.Mt.MoOutMsgId := '';
        pac.Body.Mt.MoInMsgId := '';
        MtInMsgId := GetInMsgId;
        HexToChar(MtInMsgId, pac.Body.Mt.MtInMsgId);
        pac.Body.Mt.MoLinkId := '';
        SetPchar(pac.Body.Mt.MtSpAddr, AdoQuery.fieldbyname('MtSpAddr').AsString, sizeof(pac.Body.Mt.MtSpAddr));
        SetPchar(pac.Body.Mt.MtUserAddr, AdoQuery.fieldbyname('MtUserAddr').AsString, sizeof(pac.Body.Mt.MtUserAddr));
        SetPchar(pac.Body.Mt.MtFeeAddr, AdoQuery.fieldbyname('MtUserAddr').AsString, sizeof(pac.Body.Mt.MtFeeAddr));
        SetPchar(pac.Body.Mt.MtServiceId, AdoQuery.fieldbyname('MtServiceId').AsString, sizeof(pac.Body.Mt.MtServiceId));
        pac.Body.Mt.MtMsgFmt := 15;
        pac.Body.Mt.MtMsgLenth := length(AdoQuery.fieldbyname('MtMsgContent').AsString);
        SetPchar(pac.Body.Mt.MtMsgContent, AdoQuery.fieldbyname('MtMsgContent').AsString, pac.Body.Mt.MtMsgLenth);
        mtbuffer.Add(pac);
        strSql := 'update MCSEND set PrcEd = 1, MtInMsgId = ' + Quotedstr(MtInMsgId) + ', Sendtime = getdate() where autoid = ' + inttostr(Autoid);
        AdoConnection.Execute(strSql);
        HaveMc := True;
      end
      else
      begin
        HaveMc := false;
      end;
    end;
    AdoQuery.Close;
  end;
end;

procedure TMtQfThread.ThAddMsgToMemo;
begin
  if MainForm <> nil then
  begin
    MainForm.ShowToMemo(ErrMsg, MainForm.MonitorMemo);
  end;
end;

{ TMtPrePrcThreadObj }
procedure TMtPrePrcThreadObj.AddMsgToMemo(const Msg: string);
begin
  ErrMsg := Msg;
  Synchronize(ThAddMsgToMemo);
end;

constructor TMtPrePrcThreadObj.Create(CreateSuspended: boolean);
begin
  inherited;
  LastActiveTime := now;
end;

destructor TMtPrePrcThreadObj.destroy;
begin
  LastActiveTime := 0;
  inherited;
end;

procedure TMtPrePrcThreadObj.Execute;
begin
  FreeOnTerminate := True;
  while not Terminated do
  begin
    try
      try
        MtPrePrc;
      except
        on e: exception do
        begin
          AddMsgToMemo('MO预处理:' + e.Message);
        end;
      end;
    finally
      LastActiveTime := now;
      sleep(10);
    end;
  end;
end;

procedure TMtPrePrcThreadObj.MtPrePrc;
var
  Seqid: integer;
  Mt: TMtBuffer;
  i: integer;
  j: integer;
  preprced: boolean;
begin
  if mtbuffer = nil then exit;
  Seqid := mtbuffer.GetPrePrc;
  if Seqid > 0 then
  begin
    Mt := mtbuffer.Read(Seqid);
    if Mt.Mt.MtLogicId = 2 then
    begin
      for j := 0 to high(Protocol) do
      begin
        if (Protocol[j].GateCode = Mt.Mt.MtServiceId) and (Protocol[j].MsgType = Mt.Mt.MtMsgType) then
        begin
          mtbuffer.UpdatePrePrced(Seqid, j);
        end;
      end;
    end
    else
    begin
      //先做业务代码校验和转换
      preprced := false;
      for i := 0 to high(ServiceCode) do
      begin
        if (UpperCase(Mt.Mt.MtServiceId) = ServiceCode[i].LogicCode) and (Mt.Mt.MtLogicId = ServiceCode[i].LogicId) then
        begin
          for j := 0 to high(Protocol) do
          begin
            if (Protocol[j].GateCode = ServiceCode[i].GateCode) and (Mt.Mt.MtMsgType = Protocol[j].MsgType) then
            begin
              mtbuffer.UpdatePrePrced(Seqid, j);
              preprced := True;
              break;
            end;
          end;
        end;
      end;
      if preprced = false then
      begin
        //业务代码校验和转换失内败
        //预处理无对应类型的业务代码
        mtbuffer.UpdateFailPrePrced(Seqid, 1);
      end;
    end;
  end;
end;

procedure TMtPrePrcThreadObj.ThAddMsgToMemo;
begin
  if MainForm <> nil then
  begin
    MainForm.ShowToMemo(ErrMsg, MainForm.MonitorMemo);
  end;
end;

{ TMonitorThreadObj }
procedure TMonitorThreadObj.AddMsgToMemo(const Msg: string);
begin
  ErrMsg := Msg;
  Synchronize(ThAddMsgToMemo);
end;

constructor TMonitorThreadObj.Create(CreateSuspended: boolean);
begin
  inherited;
  InMonitorBuffer := TMonitorInBufferObj.Create;
  OutMonitorBuffer := TMonitorOutBufferObj.Create;
  OutMonitorcmppBuffer := TMonitorOutcmppBufferObj.Create;
end;

destructor TMonitorThreadObj.destroy;
begin
  OutMonitorBuffer.Free;
  InMonitorBuffer.Free;
  inherited;
end;

procedure TMonitorThreadObj.Execute;
var
  i: integer;
begin
  FreeOnTerminate := True;
  while not Terminated do
  begin
    try
      try
        for i := 0 to high(OutMonitorBuffer.Buffers) do
        begin
          if OutMonitorBuffer.Buffers[i].IsUsed = 1 then
          begin
            ShowOutPac(OutMonitorBuffer.Buffers[i].pac);
            OutMonitorBuffer.Delete(i);
            break;
          end;
        end;

        for i := 0 to high(OutMonitorcmppBuffer.Buffers) do
        begin
          if OutMonitorcmppBuffer.Buffers[i].IsUsed = 1 then
          begin
            ShowOutcmppPac(OutMonitorcmppBuffer.Buffers[i].pac);
            OutMonitorcmppBuffer.Delete(i);
            break;
          end;
        end;

        //每2分钟，删除过期数据
        if now - LastPrcExpireTime > 2 / 60 / 24 then
        begin
          if mobuffer <> nil then
          begin
            mobuffer.DelExpired;
            mobuffer.BakBuffer;
          end;

          if mocmppbuffer <> nil then
          begin
            mocmppbuffer.DelExpired;
            mocmppbuffer.BakBuffer;
          end;

          if mtbuffer <> nil then
          begin
            mtbuffer.DelExpired;
            mtbuffer.BakBuffer;
          end;

          if mtcmppbuffer <> nil then
          begin
            mtcmppbuffer.DelExpired;
            mtcmppbuffer.BakBuffer;
          end;

          if rptbuffer <> nil then
          begin
            rptbuffer.DelExpired;
            rptbuffer.BakBuffer;
          end;

          if rptcmppbuffer <> nil then
          begin
            rptcmppbuffer.DelExpired;
            rptcmppbuffer.BakBuffer;
          end;
          LastPrcExpireTime := now;
        end;
      except
        on e: exception do
        begin
          AddMsgToMemo('数据包监控线程:' + e.Message);
        end;
      end;
    finally
      LastActiveTime := now;
      sleep(10);
    end;
  end;
end;

procedure TMonitorThreadObj.ShowOutPac(pac: TSMGP13_PACKET);
var
  li: TListItem;
  p: TOutPacket;
begin

  if (pac.MsgHead.RequestID <> SMGP13_ACTIVE_TEST) and (pac.MsgHead.RequestID <> SMGP13_ACTIVE_TEST_RESP) then
  begin
    if OutListview = nil then exit;

    if OutListview.Items.Count > 100 then
    begin
      OutListview.Items.BeginUpdate;
      TOutPacket(OutListview.Items[OutListview.Items.Count - 1].Data).Free;
      OutListview.Items[OutListview.Items.Count - 1].Data := nil;
      OutListview.Items.Delete(OutListview.Items.Count - 1);
      OutListview.Items.EndUpdate;
    end;

    if OutListview.Items.Count > 0 then
    begin
      li := OutListview.Items.Insert(0);
    end
    else
    begin
      li := OutListview.Items.Add;
    end;

    li.SubItems.Add(inttostr(pac.MsgHead.SequenceID));
    li.SubItems.Add(FormatDatetime('yyyy-mm-dd hh:nn:ss', now()));

    p := TOutPacket.Create(pac);
    li.Data := p;

    case pac.MsgHead.RequestID of
      SMGP13_LOGIN:
        begin
          li.Caption := '登录';
        end;

      SMGP13_LOGIN_RESP:
        begin
          li.Caption := '登录应答';
        end;

      SMGP13_DELIVER:
        begin
          if pac.MsgBody.DELIVER.IsReport = 0 then
            li.Caption := '上行'
          else li.Caption := '报告';
        end;

      SMGP13_DELIVER_RESP:
        begin
          if pac.MsgBody.DELIVER_RESP.MsgID = '' then
            li.Caption := '报告应答'
          else li.Caption := '上行应答';
        end;

      SMGP13_SUBMIT:
        begin
          li.Caption := '下行';
        end;

      SMGP13_SUBMIT_RESP:
        begin
          li.Caption := '下行应答';
        end;
    end;
  end;
end;

procedure TMonitorThreadObj.ShowOutcmppPac(pac: TCMPP20_PACKET);
var
  li: TListItem;
  p: TOutcmppPacket;
begin
  if (pac.MsgHead.Command_ID <> CMPP_ACTIVE_TEST) and (pac.MsgHead.Command_ID <> CMPP_ACTIVE_TEST_RESP) then
  begin
    if OutListview = nil then exit;

    if OutListview.Items.Count > 100 then
    begin
      OutListview.Items.BeginUpdate;
      TOutcmppPacket(OutListview.Items[OutListview.Items.Count - 1].Data).Free;
      OutListview.Items[OutListview.Items.Count - 1].Data := nil;
      OutListview.Items.Delete(OutListview.Items.Count - 1);
      OutListview.Items.EndUpdate;
    end;

    if OutListview.Items.Count > 0 then
    begin
      li := OutListview.Items.Insert(0);
    end
    else
    begin
      li := OutListview.Items.Add;
    end;

    li.SubItems.Add(inttostr(pac.MsgHead.Sequence_ID));
    li.SubItems.Add(FormatDatetime('yyyy-mm-dd hh:nn:ss', now()));

    p := TOutcmppPacket.Create(pac);
    li.Data := p;

    case pac.MsgHead.Command_ID of
      CMPP_CONNECT:
        begin
          li.Caption := '登录';
        end;

      CMPP_CONNECT_RESP:
        begin
          li.Caption := '登录应答';
        end;

      CMPP_DELIVER:
        begin
          if pac.MsgBody.CMPP_DELIVER.Registered_Delivery = 0 then
            li.Caption := '上行'
          else li.Caption := '报告';
        end;

      CMPP_DELIVER_RESP:
        begin
          if pac.MsgBody.CMPP_DELIVER_RESP.Msg_Id = 0 then
            li.Caption := '报告应答'
          else li.Caption := '上行应答';
        end;

      CMPP_SUBMIT:
        begin
          li.Caption := '下行';
        end;

      CMPP_SUBMIT_RESP:
        begin
          li.Caption := '下行应答';
        end;
    end;
  end;
end;

procedure TMonitorThreadObj.ShowOutSgipPac(pac: TSGIP12_PACKET);
var
  li: TListItem;
  p: TOutcmppPacket;
begin
  { if (pac.MsgHead.Command_ID <> CMPP_ACTIVE_TEST) and (pac.MsgHead.Command_ID <> CMPP_ACTIVE_TEST_RESP) then
   begin
     if OutListview = nil then exit;

     if OutListview.Items.Count > 100 then
     begin
       OutListview.Items.BeginUpdate;
       TOutcmppPacket(OutListview.Items[OutListview.Items.Count - 1].Data).Free;
       OutListview.Items[OutListview.Items.Count - 1].Data := nil;
       OutListview.Items.Delete(OutListview.Items.Count - 1);
       OutListview.Items.EndUpdate;
     end;

     if OutListview.Items.Count > 0 then
     begin
       li := OutListview.Items.Insert(0);
     end
     else
     begin
       li := OutListview.Items.Add;
     end;

     li.SubItems.Add(inttostr(pac.MsgHead.Sequence_ID));
     li.SubItems.Add(FormatDatetime('yyyy-mm-dd hh:nn:ss', now()));

     p := TOutcmppPacket.Create(pac);
     li.Data := p;

     case pac.MsgHead.Command_ID of
       CMPP_CONNECT:
         begin
           li.Caption := '登录';
         end;

       CMPP_CONNECT_RESP:
         begin
           li.Caption := '登录应答';
         end;

       CMPP_DELIVER:
         begin
           if pac.MsgBody.CMPP_DELIVER.Registered_Delivery = 0 then
             li.Caption := '上行'
           else li.Caption := '报告';
         end;

       CMPP_DELIVER_RESP:
         begin
           if pac.MsgBody.CMPP_DELIVER_RESP.Msg_Id = 0 then
             li.Caption := '报告应答'
           else li.Caption := '上行应答';
         end;

       CMPP_SUBMIT:
         begin
           li.Caption := '下行';
         end;

       CMPP_SUBMIT_RESP:
         begin
           li.Caption := '下行应答';
         end;
     end;
   end;     }
end;

procedure TMonitorThreadObj.ThAddMsgToMemo;
begin
  if MainForm <> nil then
  begin
    MainForm.ShowToMemo(ErrMsg, MainForm.MonitorMemo);
  end;
end;

{ TOutPacket }
constructor TOutPacket.Create(p: TSMGP13_PACKET);
begin
  pac := p;
end;

destructor TOutPacket.destroy;
begin
  inherited;
end;

{ TOutcmppPacket }
constructor TOutcmppPacket.Create(p: TCMPP20_PACKET);
begin
  pac := p;
end;

destructor TOutcmppPacket.destroy;
begin
  inherited;
end;

{ TOutSgipPacket }
constructor TOutSgipPacket.Create(p: TSGIP12_PACKET);
begin
  pac := p;
end;

destructor TOutSgipPacket.destroy;
begin
  inherited;
end;

procedure TMainForm.ShowToMemo(s: string; m: TMemo);
begin
  if m <> nil then
  begin
    m.Lines.Add('[' + FormatDatetime('yyyy-mm-dd hh:nn:ss', now) + ']' + s);
  end;
end;

procedure TMainForm.SMGPTCPClientConnected(Sender: TObject);
begin
  try
    ShowToMemo('外部网关SMGP已连接', MonitorMemo);
    if MtSendThread <> nil then
    begin
      MtSendThread.Terminate;
      MtSendThread := nil;
    end;

    if OutReadThread <> nil then
    begin
      OutReadThread.Terminate;
      OutReadThread := nil;
    end;

    OutReadThread := TOutReadSMGPThreadObj.Create(True);
    OutReadThread.FTCPClient := SMGPTCPClient;
    OutReadThread.Resume;

    MtSendThread := TMtSendSMGPThreadObj.Create(True);
    MtSendThread.Resume;
  except

  end;
end;

//SMGP  小灵通 电信
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
{SMGP  TMtSendSmgpThreadObj }
procedure TMtSendSMGPThreadObj.AddMsgToMemo(const Msg: string);
begin
  ErrMsg := Msg;
  Synchronize(ThAddMsgToMemo);
end;

constructor TMtSendSMGPThreadObj.Create(CreateSuspended: boolean);
begin
  inherited;
  LastActiveTime := now;
end;

destructor TMtSendSMGPThreadObj.destroy;
begin
  LastActiveTime := 0;
  inherited;
end;

procedure TMtSendSMGPThreadObj.Execute;
begin
  FreeOnTerminate := True;
  while not Terminated do
  begin
    try
      try
        MtPrc;
      except
        on e: exception do
        begin
          AddMsgToMemo('MT消息发送线程:' + e.Message);
        end;
      end;
    finally
      LastActiveTime := now;
      //这里需要做流量限制
      sleep(1000 div GGATECONFIG.Flux);
    end;
  end;
end;

procedure TMtSendSMGPThreadObj.MtPrc;
begin
  if OutReadThread <> nil then
  begin
    OutReadThread.PrcMt;
  end;
end;

procedure TMtSendSMGPThreadObj.ThAddMsgToMemo;
begin
  if MainForm <> nil then
  begin
    MainForm.ShowToMemo(ErrMsg, MainForm.MonitorMemo);
  end;
end;

{SMGP TOutReadSmgpThreadObj }
procedure TOutReadSMGPThreadObj.AddMsgToMemo(const Msg: string);
begin
  ErrMsg := Msg;
  Synchronize(ThAddMsgToMemo);
end;

procedure TOutReadSMGPThreadObj.ClientRead;
begin
  try
    try
      FTCPClient.CheckForGracefulDisconnect();
    except
      on e: exception do
      begin
        AddMsgToMemo('TOutReadSmgpThreadObj' + e.Message);
        sleep(1000);
      end;
    end;

    if FTCPClient.Connected then
    begin
      if FRecBuffer.BufferSize = 0 then
      begin
        //初始化结构体，用来分别存放网络数据包和本地数据包
        ZeroMemory(@FlocPacketIn, sizeof(TSMGP13_PACKET));
        ZeroMemory(@FnetPacketIn, sizeof(TSMGP13_PACKET));

        //这里阻塞读取数据包头
        FTCPClient.ReadBuffer(FRecBuffer.Buffer, sizeof(TSMGP13_HEAD));
        FRecBuffer.BufferSize := sizeof(TSMGP13_HEAD);

        //将读到的包头数据复制到网络结构体中
        Move(FRecBuffer.Buffer, FnetPacketIn.MsgHead, sizeof(TSMGP13_HEAD));
        //经网络字节序转换后，将网络结构体包头复制到本地结构体中
        FlocPacketIn.MsgHead.PacketLength := ntohl(FnetPacketIn.MsgHead.PacketLength);
        FlocPacketIn.MsgHead.RequestID := ntohl(FnetPacketIn.MsgHead.RequestID);
        FlocPacketIn.MsgHead.SequenceID := ntohl(FnetPacketIn.MsgHead.SequenceID);
      end;

      case FlocPacketIn.MsgHead.RequestID of
        SMGP13_LOGIN_RESP:
          begin
            //登录应答包，读取对应的长度，并复制到网络结构体和本地结构体中
            FTCPClient.ReadBuffer(FRecBuffer.Buffer[FRecBuffer.BufferSize], sizeof(TSMGP13_LOGIN_RESP));
            FRecBuffer.BufferSize := FRecBuffer.BufferSize + sizeof(TSMGP13_LOGIN_RESP);
            Move(FRecBuffer.Buffer, FnetPacketIn, FRecBuffer.BufferSize);
            FlocPacketIn.MsgBody.LOGIN_RESP := FnetPacketIn.MsgBody.LOGIN_RESP;
            FlocPacketIn.MsgBody.LOGIN_RESP.Status := ntohl(FnetPacketIn.MsgBody.LOGIN_RESP.Status);
          end;

        SMGP13_SUBMIT_RESP:
          begin
            //下行应答包，读取对应的长度，并复制到网络结构体和本地结构体中
            FTCPClient.ReadBuffer(FRecBuffer.Buffer[FRecBuffer.BufferSize], sizeof(TSMGP13_SUBMIT_RESP));
            FRecBuffer.BufferSize := FRecBuffer.BufferSize + sizeof(TSMGP13_SUBMIT_RESP);
            Move(FRecBuffer.Buffer, FnetPacketIn, FRecBuffer.BufferSize);
            FlocPacketIn.MsgBody.SUBMIT_RESP := FnetPacketIn.MsgBody.SUBMIT_RESP;
            FlocPacketIn.MsgBody.SUBMIT_RESP.Status := ntohl(FnetPacketIn.MsgBody.SUBMIT_RESP.Status);
          end;

        SMGP13_DELIVER:
          begin
            FTCPClient.ReadBuffer(FRecBuffer.Buffer[FRecBuffer.BufferSize], FlocPacketIn.MsgHead.PacketLength - FRecBuffer.BufferSize);
            FRecBuffer.BufferSize := FlocPacketIn.MsgHead.PacketLength;
            Move(FRecBuffer.Buffer, FnetPacketIn, FRecBuffer.BufferSize);
            FnetPacketIn.MsgBody.DELIVER.MsgLength := FlocPacketIn.MsgHead.PacketLength - sizeof(TSMGP13_HEAD) - 77;
            FlocPacketIn.MsgBody.DELIVER := FnetPacketIn.MsgBody.DELIVER;

            ZeroMemory(@FlocPacketIn.MsgBody.DELIVER.MsgContent, sizeof(FlocPacketIn.MsgBody.DELIVER.MsgContent));
            ZeroMemory(@FlocPacketIn.MsgBody.DELIVER.Reserve, sizeof(FlocPacketIn.MsgBody.DELIVER.Reserve));

            Move(FnetPacketIn.MsgBody.DELIVER.MsgContent, FlocPacketIn.MsgBody.DELIVER.MsgContent, FlocPacketIn.MsgBody.DELIVER.MsgLength);
            Move(FnetPacketIn.MsgBody.DELIVER.MsgContent[FlocPacketIn.MsgBody.DELIVER.MsgLength], FlocPacketIn.MsgBody.DELIVER.Reserve, sizeof(FlocPacketIn.MsgBody.DELIVER.Reserve));

            FnetPacketIn.MsgBody := FlocPacketIn.MsgBody;
          end;

        SMGP13_ACTIVE_TEST:
          begin
          end;

        SMGP13_ACTIVE_TEST_RESP:
          begin
          end;
      else
        begin
          FTCPClient.Disconnect;
        end;
      end;

      if MainForm.OutMonitor.Checked then
      begin
        MonitorThread.OutMonitorBuffer.Add(FlocPacketIn);
      end;

      case FlocPacketIn.MsgHead.RequestID of
        SMGP13_LOGIN_RESP:
          begin
            if FlocPacketIn.MsgBody.LOGIN_RESP.Status = 0 then
            begin
              FLogined := True;
              AddMsgToMemo('SMGP外部网关登录成功');
            end
            else
            begin
              FLogined := false;
              AddMsgToMemo('SMGP外部网关登录失败');
            end;
          end;

        SMGP13_SUBMIT_RESP:
          begin
            mtbuffer.UpdateResp(FlocPacketIn.MsgHead.SequenceID, FlocPacketIn.MsgBody.SUBMIT_RESP.MsgID, FlocPacketIn.MsgBody.SUBMIT_RESP.Status);
            inc(FMtRespCount);
            WindowSize := WindowSize - 1;
            if WindowSize < 0 then WindowSize := 0;
          end;

        SMGP13_DELIVER: //mo上行过来的写入缓冲
          begin
            //写入缓冲，或是状态报告
            if FlocPacketIn.MsgBody.DELIVER.IsReport = 1 then
            begin
              //状态报告,写入状态报告缓冲中
              rptbuffer.Add(FlocPacketIn);
              inc(FRptCount);
            end
            else
            begin
              //MO,将Mo写入Mo缓冲中
              mobuffer.Add(FlocPacketIn);
              inc(FMoCount);
            end;
            //应答
            SendPacket(CreateRespPacket(FlocPacketIn));
          end;

        SMGP13_ACTIVE_TEST:
          begin
            WindowSize := 0;
            SendPacket(CreateRespPacket(FlocPacketIn));
          end;

        SMGP13_ACTIVE_TEST_RESP:
          begin
            WindowSize := 0;
          end;
      end;

      FRecBuffer.BufferSize := 0;
      ZeroMemory(@FRecBuffer.Buffer, sizeof(FRecBuffer.Buffer));
    end;
  except
    on e: exception do
    begin
      AddMsgToMemo('SMGP外部网关接收线程:' + e.Message);
      sleep(1000);
      FTCPClient.Disconnect;
    end;
  end;
end;

constructor TOutReadSMGPThreadObj.Create(CreateSuspended: boolean);
begin
  inherited;
  ZeroMemory(@FRecBuffer.Buffer, sizeof(FRecBuffer.Buffer));
  FRecBuffer.BufferSize := 0;
  ZeroMemory(@FlocPacketIn, sizeof(TSMGP13_PACKET));
  ZeroMemory(@FnetPacketIn, sizeof(TSMGP13_PACKET));
  FLogined := false;
  FMoCount := 0;
  FMtCount := 0;
  FRptCount := 0;
  FMtRespCount := 0;
  FMtRefuseCount := 0;
  Seqid := 1;
  WindowSize := 0;
  FLastActiveTime := now;
  MtHasUnsendMessage := false;
  MtMessage := '';
  MtNumber := '';
  MtUnsend := 100;
end;

function TOutReadSMGPThreadObj.CreatePacket(
  const RequestID: Cardinal): TSMGP13_PACKET;
var
  pac: TSMGP13_PACKET;
  Time: string;
  strTemp: string;
  tempArray: array[0..255] of char;
  tempbArray: array[0..255] of byte;
  md5: TMD5;
begin
  ZeroMemory(@pac, sizeof(TSMGP13_PACKET));
  pac.MsgHead.RequestID := RequestID;

  case RequestID of
    SMGP13_LOGIN:
      begin
        pac.MsgHead.PacketLength := sizeof(TSMGP13_HEAD) + sizeof(TSMGP13_LOGIN);
        pac.MsgHead.SequenceID := GetSeqid;

        with pac.MsgBody.LOGIN do
        begin
          SetPchar(ClientID, GGATECONFIG.ClientID, sizeof(ClientID));
          LoginMode := 2;
          Time := FormatDatetime('MMDDHHNNSS', now);
          TimeStamp := strtoint(Time);
          Version := SMGP13_VERSION;

          strTemp := GGATECONFIG.ClientID + #0#0#0#0#0#0#0 + GGATECONFIG.ClientSecret + Time;
          SetPchar(tempArray, strTemp, sizeof(tempArray));
          Move(tempArray, tempbArray, sizeof(tempbArray));

          md5 := TMD5.Create(nil);
          try
            md5.InputType := SourceByteArray;
            md5.InputLength := 17 + length(GGATECONFIG.ClientID) + length(GGATECONFIG.ClientSecret);
            md5.pInputArray := @tempbArray;
            md5.pOutputArray := @AuthenticatorClient;
            md5.MD5_Hash;
          finally
            md5.Free;
          end;
        end;
      end;

    SMGP13_SUBMIT:
      begin
        pac.MsgBody.SUBMIT.NeedReport := 1;
        pac.MsgBody.SUBMIT.Priority := 0;
        pac.MsgBody.SUBMIT.DestTermIDCount := 1;
      end;

    SMGP13_ACTIVE_TEST:
      begin
        pac.MsgHead.PacketLength := sizeof(TSMGP13_HEAD);
        pac.MsgHead.SequenceID := GetSeqid;
      end;
  end;
  result := pac;
end;

function TOutReadSMGPThreadObj.CreateRespPacket(
  const recpac: TSMGP13_PACKET): TSMGP13_PACKET;
var
  pac: TSMGP13_PACKET;
begin
  ZeroMemory(@pac, sizeof(TSMGP13_PACKET));

  case recpac.MsgHead.RequestID of
    SMGP13_DELIVER:
      begin
        pac.MsgHead.RequestID := SMGP13_DELIVER_RESP;
        pac.MsgHead.PacketLength := sizeof(TSMGP13_HEAD) + sizeof(TSMGP13_DELIVER_RESP);
        pac.MsgHead.SequenceID := recpac.MsgHead.SequenceID;
        Move(recpac.MsgBody.DELIVER_RESP.MsgID, pac.MsgBody.DELIVER_RESP.MsgID, sizeof(pac.MsgBody.DELIVER_RESP.MsgID));
        pac.MsgBody.DELIVER_RESP.Status := 0;
      end;

    SMGP13_ACTIVE_TEST:
      begin
        pac.MsgHead.PacketLength := sizeof(TSMGP13_HEAD);
        pac.MsgHead.RequestID := SMGP13_ACTIVE_TEST_RESP;
        pac.MsgHead.SequenceID := recpac.MsgHead.SequenceID;
      end;
  end;
  result := pac;
end;

destructor TOutReadSMGPThreadObj.destroy;
begin
  FTCPClient := nil;
  inherited;
end;

procedure TOutReadSMGPThreadObj.Execute;
begin
  FreeOnTerminate := True;
  while not Terminated do
  begin
    try
      ClientRead;
      FLastActiveTime := now(); //如果最后活动时间和现在超过2分钟，发送活动测试包
    finally
      sleep(0);
    end;
  end;
end;

function TOutReadSMGPThreadObj.GetSeqid: Cardinal;
begin
  result := Seqid;
  inc(Seqid);
  if Seqid >= 4294967295 then
  begin
    Seqid := 1;
  end;
end;

// 实际的发送信息到终端的处理过程
procedure TOutReadSMGPThreadObj.PrcMt;
var
  MtSeqId: integer;
begin
  if FTCPClient.Connected then
  begin
    if FLogined then
    begin
      if now - FLastActiveTime > 30 / 3600 / 24 then
      begin
        if now - FLastActiveTime > 90 / 3600 / 24 then
        begin
          FTCPClient.Disconnect;
        end
        else
        begin
          if now - LastSendActiveTime > 10 / 3600 / 24 then
          begin
            //发送活动测试包
            SendPacket(CreatePacket(SMGP13_ACTIVE_TEST));
            //更新最后发送活动测试包时间
            LastSendActiveTime := now();
          end;
        end;
      end
      else
      begin
        // 发送消息(1)
        MtSeqId := mtbuffer.Get;
        if MtSeqId > 0 then
        begin
          SendMt(MtSeqId);
        end;
      end;
    end
    else
    begin
      if now - LastLoginTime > 6 / 3600 / 24 then
      begin
        SendPacket(CreatePacket(SMGP13_LOGIN));
        LastLoginTime := now;
      end;
    end;
  end;
end;
// 对外发送函数
procedure TOutReadSMGPThreadObj.SendMt(i: integer);
var
  Buffer: TMtBuffer;
  outpac: TSMGP13_PACKET;
begin
  Buffer := mtbuffer.Read(i);
  outpac := CreatePacket(SMGP13_SUBMIT);
  outpac.MsgHead.SequenceID := i;
  outpac.MsgBody.SUBMIT.MsgType := Buffer.OutMsgType;
  Move(Buffer.OutServiceID, outpac.MsgBody.SUBMIT.ServiceID, sizeof(Buffer.OutServiceID));
  Move(Buffer.OutFeeType, outpac.MsgBody.SUBMIT.FeeType, sizeof(Buffer.OutFeeType));
  Move(Buffer.OutFixedFee, outpac.MsgBody.SUBMIT.FixedFee, sizeof(Buffer.OutFixedFee));
  Move(Buffer.OutFeeCode, outpac.MsgBody.SUBMIT.FeeCode, sizeof(Buffer.OutFeeCode));
  outpac.MsgBody.SUBMIT.MsgFormat := Buffer.Mt.MtMsgFmt;
  Move(Buffer.Mt.MtValidTime, outpac.MsgBody.SUBMIT.ValidTime, sizeof(Buffer.Mt.MtValidTime));
  Move(Buffer.Mt.MtAtTime, outpac.MsgBody.SUBMIT.AtTime, sizeof(Buffer.Mt.MtAtTime));
  Move(Buffer.Mt.MtSpAddr, outpac.MsgBody.SUBMIT.SrcTermID, sizeof(TSMGP13PhoneNum));
  Move(Buffer.Mt.MtFeeAddr, outpac.MsgBody.SUBMIT.ChargeTermID, sizeof(TSMGP13PhoneNum));
  Move(Buffer.Mt.MtUserAddr, outpac.MsgBody.SUBMIT.DestTermID, sizeof(TSMGP13PhoneNum));
  outpac.MsgBody.SUBMIT.MsgLength := Buffer.Mt.MtMsgLenth;
  Move(Buffer.Mt.MtMsgContent, outpac.MsgBody.SUBMIT.MsgContent, Buffer.Mt.MtMsgLenth);
  outpac.MsgHead.PacketLength := sizeof(TSMGP13_HEAD) + sizeof(TSMGP13_SUBMIT) - sizeof(outpac.MsgBody.SUBMIT.MsgContent) + Buffer.Mt.MtMsgLenth;
  SendPacket(outpac);
end;

procedure TOutReadSMGPThreadObj.SendPacket(pac: TSMGP13_PACKET);
var
  sendbuffer: TCOMMBuffer;
  NetPacOut, LocPacOut: TSMGP13_PACKET;
begin
  //初始化变量
  ZeroMemory(@sendbuffer, sizeof(TCOMMBuffer));
  sendbuffer.BufferSize := 0;
  NetPacOut := pac;
  LocPacOut := pac;

  //包头部分，进行网络字节序转换
  //htonl（将32位主机字符顺序转换成网络字符顺序）.
  NetPacOut.MsgHead.PacketLength := htonl(LocPacOut.MsgHead.PacketLength);
  NetPacOut.MsgHead.RequestID := htonl(LocPacOut.MsgHead.RequestID);
  NetPacOut.MsgHead.SequenceID := htonl(LocPacOut.MsgHead.SequenceID);

  //将包头复制到发送缓冲中
  //move函数的作用是将输入数组中的元素从后面开始，两两交换，循环次数用n控制
  Move(NetPacOut.MsgHead, sendbuffer.Buffer, sizeof(TSMGP13_HEAD));
  sendbuffer.BufferSize := sizeof(TSMGP13_HEAD);

  case pac.MsgHead.RequestID of
    SMGP13_LOGIN:
      begin
        NetPacOut.MsgBody.LOGIN.TimeStamp := htonl(LocPacOut.MsgBody.LOGIN.TimeStamp);
        Move(NetPacOut.MsgBody.LOGIN, sendbuffer.Buffer[sendbuffer.BufferSize], sizeof(TSMGP13_LOGIN));
        sendbuffer.BufferSize := sendbuffer.BufferSize + sizeof(TSMGP13_LOGIN);
      end;

    SMGP13_SUBMIT:
      begin
        Move(NetPacOut.MsgBody.SUBMIT, sendbuffer.Buffer[sendbuffer.BufferSize], 127);
        sendbuffer.BufferSize := sendbuffer.BufferSize + 127;
        Move(NetPacOut.MsgBody.SUBMIT.MsgContent, sendbuffer.Buffer[sendbuffer.BufferSize], NetPacOut.MsgBody.SUBMIT.MsgLength);
        sendbuffer.BufferSize := sendbuffer.BufferSize + NetPacOut.MsgBody.SUBMIT.MsgLength;
        Move(NetPacOut.MsgBody.SUBMIT.Reserve, sendbuffer.Buffer[sendbuffer.BufferSize], sizeof(NetPacOut.MsgBody.SUBMIT.Reserve));
        sendbuffer.BufferSize := sendbuffer.BufferSize + sizeof(NetPacOut.MsgBody.SUBMIT.Reserve);
      end;

    SMGP13_DELIVER_RESP:
      begin
        NetPacOut.MsgBody.DELIVER_RESP.Status := htonl(LocPacOut.MsgBody.DELIVER_RESP.Status);
        Move(NetPacOut.MsgBody.DELIVER_RESP, sendbuffer.Buffer[sendbuffer.BufferSize], sizeof(TSMGP13_DELIVER_RESP));
        sendbuffer.BufferSize := sendbuffer.BufferSize + sizeof(TSMGP13_DELIVER_RESP);
      end;

    SMGP13_ACTIVE_TEST:
      begin

      end;

    SMGP13_ACTIVE_TEST_RESP:
      begin

      end;
  end;

  if sendbuffer.BufferSize = LocPacOut.MsgHead.PacketLength then
  begin
    if LocPacOut.MsgHead.RequestID = SMGP13_SUBMIT then
    begin
      inc(WindowSize);
      mtbuffer.Update(LocPacOut.MsgHead.SequenceID);
      inc(FMtCount);
    end;

    if MainForm.OutMonitor.Checked then
    begin
      MonitorThread.OutMonitorBuffer.Add(LocPacOut);
    end;

    try
      FTCPClient.WriteBuffer(sendbuffer.Buffer, sendbuffer.BufferSize);
    except
      on e: exception do
      begin
        AddMsgToMemo('SMGP外部网关发送线程' + e.Message);
        FTCPClient.Disconnect;
      end;
    end;
  end;
end;

procedure TOutReadSMGPThreadObj.ThAddMsgToMemo;
begin
  if MainForm <> nil then
  begin
    MainForm.ShowToMemo(ErrMsg, MainForm.MonitorMemo);
  end;
end;
//SMGP
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


//CMPP
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
{CMPP0 移动 7890  TMtSendCMPPThreadObj}
procedure TMtSendCMPPThreadObj.AddMsgToMemo(const Msg: string);
begin
  ErrMsg := Msg;
  Synchronize(ThAddMsgToMemo);
end;

constructor TMtSendCMPPThreadObj.Create(CreateSuspended: boolean);
begin
  inherited;
  LastActiveTime := now;
end;

destructor TMtSendCMPPThreadObj.destroy;
begin
  LastActiveTime := 0;
  inherited;
end;

procedure TMtSendCMPPThreadObj.Execute;
begin
  FreeOnTerminate := True;
  while not Terminated do
  begin
    try
      try
        MtPrc;
      except
        on e: exception do
        begin
          AddMsgToMemo('MTCMPP消息发送线程:' + e.Message);
        end;
      end;
    finally
      LastActiveTime := now;
      //这里需要做流量限制
      sleep(1000 div GGATECONFIG.Flux);
    end;
  end;
end;

procedure TMtSendCMPPThreadObj.MtPrc;
begin
  if OutReadCMPPThread <> nil then
  begin
    OutReadCMPPThread.PrcMt;
  end;
end;

procedure TMtSendCMPPThreadObj.ThAddMsgToMemo;
begin
  if MainForm <> nil then
  begin
    MainForm.ShowToMemo(ErrMsg, MainForm.MonitorMemo);
  end;
end;

{CMPP0 移动 7890  TOutReadCMPPThreadObj}
procedure TOutReadCMPPThreadObj.AddMsgToMemo(const Msg: string);
begin
  ErrMsg := Msg;
  Synchronize(ThAddMsgToMemo);
end;

procedure TOutReadCMPPThreadObj.ClientRead;
begin
  //CMPP 读取到CMPP缓冲
  try
    try
      FTCPCmppClient.CheckForGracefulDisconnect();
    except
      on e: exception do
      begin
        AddMsgToMemo('TOutReadCmppThreadObj' + e.Message);
        sleep(1000);
      end;
    end;

    if FTCPCmppClient.Connected then
    begin
      if FRecCmppBuffer.BufferSize = 0 then
      begin
        //初始化结构体，用来分别存放网络数据包和本地数据包
        ZeroMemory(@FlocCmppPacketIn, sizeof(TCMPP20_PACKET));
        ZeroMemory(@FnetCmppPacketIn, sizeof(TCMPP20_PACKET));
        //这里阻塞读取数据包头
        FTCPCmppClient.ReadBuffer(FRecCmppBuffer.Buffer, sizeof(TCMPP_HEAD));
        FRecCmppBuffer.BufferSize := sizeof(TCMPP_HEAD);
        //将读到的包头数据复制到网络结构体中
        Move(FRecCmppBuffer.Buffer, FnetCmppPacketIn.MsgHead, sizeof(TCMPP_HEAD));
        //经网络字节序转换后，将网络结构体包头复制到本地结构体中
        FlocCmppPacketIn.MsgHead.Total_Length := ntohl(FnetCmppPacketIn.MsgHead.Total_Length);
        FlocCmppPacketIn.MsgHead.Command_ID := ntohl(FnetCmppPacketIn.MsgHead.Command_ID);
        FlocCmppPacketIn.MsgHead.Sequence_ID := ntohl(FnetCmppPacketIn.MsgHead.Sequence_ID);
      end;

      case FlocCmppPacketIn.MsgHead.Command_ID of
        CMPP_CONNECT_RESP:
          begin
            //登录应答包，读取对应的长度，并复制到网络结构体和本地结构体中
            FTCPCmppClient.ReadBuffer(FRecCmppBuffer.Buffer[FRecCmppBuffer.BufferSize], sizeof(TCMPP_CONNECT_RESP));
            FRecCmppBuffer.BufferSize := FRecCmppBuffer.BufferSize + sizeof(TCMPP_CONNECT_RESP);
            Move(FRecCmppBuffer.Buffer, FnetCmppPacketIn, FRecCmppBuffer.BufferSize);
            FlocCmppPacketIn.MsgBody.CMPP_CONNECT_RESP := FnetCmppPacketIn.MsgBody.CMPP_CONNECT_RESP;
            FlocCmppPacketIn.MsgBody.CMPP_CONNECT_RESP.Status := ntohl(FnetCmppPacketIn.MsgBody.CMPP_CONNECT_RESP.Status);
          end;

        CMPP_SUBMIT_RESP:
          begin
            //下行应答包，读取对应的长度，并复制到网络结构体和本地结构体中
            FTCPCmppClient.ReadBuffer(FRecCmppBuffer.Buffer[FRecCmppBuffer.BufferSize], sizeof(TCMPP_SUBMIT_RESP));
            FRecCmppBuffer.BufferSize := FRecCmppBuffer.BufferSize + sizeof(TCMPP_SUBMIT_RESP);
            Move(FRecCmppBuffer.Buffer, FnetCmppPacketIn, FRecCmppBuffer.BufferSize);
            FlocCmppPacketIn.MsgBody.CMPP_SUBMIT_RESP := FnetCmppPacketIn.MsgBody.CMPP_SUBMIT_RESP;
            FlocCmppPacketIn.MsgBody.CMPP_SUBMIT_RESP.result := ntohl(FnetCmppPacketIn.MsgBody.CMPP_SUBMIT_RESP.result);
          end;

        CMPP_DELIVER:
          begin
            FTCPCmppClient.ReadBuffer(FRecCmppBuffer.Buffer[FRecCmppBuffer.BufferSize], FlocCmppPacketIn.MsgHead.Total_Length - FRecCmppBuffer.BufferSize);
            FRecCmppBuffer.BufferSize := FlocCmppPacketIn.MsgHead.Total_Length;
            Move(FRecCmppBuffer.Buffer, FnetCmppPacketIn, FRecCmppBuffer.BufferSize);
            FnetCmppPacketIn.MsgBody.CMPP_DELIVER.MSG_LENGTH := FlocCmppPacketIn.MsgHead.Total_Length - sizeof(TCMPP_HEAD) - 77;
            FlocCmppPacketIn.MsgBody.CMPP_DELIVER := FnetCmppPacketIn.MsgBody.CMPP_DELIVER;
            ZeroMemory(@FlocCmppPacketIn.MsgBody.CMPP_DELIVER.Msg_Content, sizeof(FlocCmppPacketIn.MsgBody.CMPP_DELIVER.Msg_Content));
            ZeroMemory(@FlocCmppPacketIn.MsgBody.CMPP_DELIVER.Reserved, sizeof(FlocCmppPacketIn.MsgBody.CMPP_DELIVER.Reserved));
            Move(FnetCmppPacketIn.MsgBody.CMPP_DELIVER.Msg_Content, FlocCmppPacketIn.MsgBody.CMPP_DELIVER.Msg_Content, FlocCmppPacketIn.MsgBody.CMPP_DELIVER.MSG_LENGTH);
            Move(FnetCmppPacketIn.MsgBody.CMPP_DELIVER.Msg_Content[FlocCmppPacketIn.MsgBody.CMPP_DELIVER.MSG_LENGTH], FlocCmppPacketIn.MsgBody.CMPP_DELIVER.Reserved, sizeof(FlocCmppPacketIn.MsgBody.CMPP_DELIVER.Reserved));
            FnetCmppPacketIn.MsgBody := FlocCmppPacketIn.MsgBody;
          end;

        CMPP_ACTIVE_TEST:
          begin
            //AddMsgToMemo('CMPP外部网关活动测试要求');
          end;

        CMPP_ACTIVE_TEST_RESP:
          begin
            //AddMsgToMemo('CMPP外部网关活动测试回复');
          end;
        CMPP_TERMINATE:
          begin
            AddMsgToMemo('CMPP外部网关要求终止连接');
          end;
        CMPP_TERMINATE_RESP:
          begin
            AddMsgToMemo('CMPP外部网关要求终止连接应答');
          end;

      else
        begin
          FTCPCmppClient.Disconnect;
        end;
      end;

      if MainForm.OutMonitor.Checked then
      begin
        //暂时取消监控 2005/11/12
        MonitorThread.OutMonitorcmppBuffer.Add(FlocCmppPacketIn);
      end;

      case FlocCmppPacketIn.MsgHead.Command_ID of
        CMPP_CONNECT_RESP:
          begin
            if (FlocCmppPacketIn.MsgBody.CMPP_CONNECT_RESP.Status = 0) and (FlocCmppPacketIn.MsgBody.CMPP_CONNECT_RESP.Version <> 0) then
            begin
              FLogined := True;
              AddMsgToMemo('CMPP外部网关端口登录成功');
            end
            else
            begin
              FLogined := false;
              AddMsgToMemo('CMPP外部网关登录失败');
            end;
          end;

        CMPP_SUBMIT_RESP:
          begin
            if FlocCmppPacketIn.MsgBody.CMPP_SUBMIT_RESP.Msg_Id = 0 then
            begin
              AddMsgToMemo('NO');
            end else
            begin
              AddMsgToMemo('YES');
            end;
            mtcmppbuffer.UpdateResp(FlocCmppPacketIn.MsgHead.Command_ID, FlocCmppPacketIn.MsgBody.CMPP_SUBMIT_RESP.Msg_Id, FlocCmppPacketIn.MsgBody.CMPP_SUBMIT_RESP.result);
            inc(FMtRespCount);
            WindowSize := WindowSize - 1;
            if WindowSize < 0 then WindowSize := 0;
          end;

        CMPP_DELIVER: //mo上行过来的写入缓冲
          begin
            //写入缓冲，或是状态报告
            if FlocCmppPacketIn.MsgBody.CMPP_DELIVER.Registered_Delivery = 1 then
            begin
              //状态报告,写入状态报告缓冲中
              rptcmppbuffer.Add(FlocCmppPacketIn);
              inc(FRptCount);
            end
            else
            begin
              //MO,将Mo写入Mo缓冲中
              mocmppbuffer.Add(FlocCmppPacketIn);
              inc(FMoCount);
            end;

            //应答
            SendPacket(CreateRespPacket(FlocCmppPacketIn));
          end;

        CMPP_ACTIVE_TEST:
          begin
            WindowSize := 0;
            SendPacket(CreateRespPacket(FlocCmppPacketIn));
            LastSendActiveTime := now();
          end;

        CMPP_ACTIVE_TEST_RESP:
          begin
            WindowSize := 0;
            LastSendActiveTime := now();
          end;
      end;

      FRecCmppBuffer.BufferSize := 0;
      ZeroMemory(@FRecCmppBuffer.Buffer, sizeof(FRecCmppBuffer.Buffer));
    end;
  except
    on e: exception do
    begin
      AddMsgToMemo('CMPP外部网关接收线程:' + e.Message);
      sleep(1000);
      FTCPCmppClient.Disconnect;
    end;
  end;

end;

constructor TOutReadCMPPThreadObj.Create(CreateSuspended: boolean);
begin
  inherited;
  ZeroMemory(@FRecCmppBuffer.Buffer, sizeof(FRecCmppBuffer.Buffer));
  FRecCmppBuffer.BufferSize := 0;
  ZeroMemory(@FlocCmppPacketIn, sizeof(TCMPP20_PACKET));
  ZeroMemory(@FnetCmppPacketIn, sizeof(TCMPP20_PACKET));
  FLogined := false;
  FMoCount := 0;
  FMtCount := 0;
  FRptCount := 0;
  FMtRespCount := 0;
  FMtRefuseCount := 0;
  Seqid := 1;
  WindowSize := 0;
  FLastActiveTime := now;
  MtHasUnsendMessage := false;
  MtMessage := '';
  MtNumber := '';
  MtUnsend := 100;
  log_port := 0;
end;

function TOutReadCMPPThreadObj.CreatePacket(
  const RequestID: Cardinal): TCMPP20_PACKET;
var
  pac: TCMPP20_PACKET;
  Time: string;
  strTemp: string;
  tempArray: array[0..255] of char;
  tempbArray: array[0..255] of byte;
  md5: TMD5;
  md5str: md5digest;
  md5_con: MD5Context;
  Md5UpLen, i: integer; //MD5Update Length;
  str1: array[0..31] of char;
begin
  ZeroMemory(@pac, sizeof(TCMPP20_PACKET));
  pac.MsgHead.Command_ID := RequestID;

  case RequestID of
    CMPP_CONNECT:
      begin
        //01200 端口登陆 1端口登陆
        pac.MsgHead.Total_Length := sizeof(TCMPP_HEAD) + sizeof(TCMPP_CONNECT);
        pac.MsgHead.Sequence_ID := GetSeqid;
        with pac.MsgBody.CMPP_CONNECT do
        begin
          SetPchar(Source_Addr, GGATECONFIG.cmppClientID, sizeof(Source_Addr));
          DateTimeToString(Time, 'MMDDHHMMSS', now);
          Version := CMPP_VERSION;
          strTemp := GGATECONFIG.cmppClientID + '000000000' + GGATECONFIG.cmppClientSecret + Time;
          StrPCopy(str1, strTemp);
          for i := length(GGATECONFIG.cmppClientID) to (length(GGATECONFIG.cmppClientID) + 8) do
            str1[i] := #0;
          Md5UpLen := length(GGATECONFIG.cmppClientID) + 9 + length(GGATECONFIG.cmppClientSecret) + 10;
          MD5Init(md5_con);
          MD5Update(md5_con, str1, Md5UpLen);
          MD5Final(md5_con, md5str);
          Move(md5str, AuthenticatorSource, 16);
          TimeStamp := strtoint(Time);
        end;
      end;

    CMPP_SUBMIT:
      begin
        pac.MsgBody.CMPP_SUBMIT.Registered_Delivery := 1;
        pac.MsgBody.CMPP_SUBMIT.Msg_level := 0;
        pac.MsgBody.CMPP_SUBMIT.DestUsr_tl := 1;
      end;

    CMPP_ACTIVE_TEST:
      begin
        pac.MsgHead.Total_Length := sizeof(TCMPP_HEAD);
        pac.MsgHead.Sequence_ID := GetSeqid;
      end;
  end;

  result := pac;
end;

function TOutReadCMPPThreadObj.CreateRespPacket(
  const recpac: TCMPP20_PACKET): TCMPP20_PACKET;
var
  pac: TCMPP20_PACKET;
begin
  ZeroMemory(@pac, sizeof(TCMPP20_PACKET));
  case recpac.MsgHead.Command_ID of
    CMPP_DELIVER:
      begin
        pac.MsgHead.Command_ID := CMPP_DELIVER_RESP;

        pac.MsgHead.Total_Length := sizeof(TCMPP_HEAD) + sizeof(TCMPP_DELIVER_RESP);
        pac.MsgHead.Sequence_ID := recpac.MsgHead.Sequence_ID;
        Move(recpac.MsgBody.CMPP_DELIVER_RESP.Msg_Id, pac.MsgBody.CMPP_DELIVER_RESP.Msg_Id, sizeof(pac.MsgBody.CMPP_DELIVER_RESP.Msg_Id));
        pac.MsgBody.CMPP_DELIVER_RESP.result := 0;
      end;

    CMPP_ACTIVE_TEST:
      begin
        pac.MsgHead.Command_ID := CMPP_ACTIVE_TEST_RESP;
        pac.MsgHead.Total_Length := sizeof(TCMPP_HEAD) + sizeof(TCMPP_ACTIVE_TEST_RESP);
        pac.MsgHead.Sequence_ID := recpac.MsgHead.Sequence_ID;
        pac.MsgBody.CMPP_ACTIVE_TEST_RESP.Success_Id := 0;
      end;
  end;
  result := pac;
end;

destructor TOutReadCMPPThreadObj.destroy;
begin
  FTCPCmppClient := nil;
  inherited;
end;

procedure TOutReadCMPPThreadObj.Execute;
begin
  FreeOnTerminate := True;
  while not Terminated do
  begin
    try
      ClientRead;
      FLastActiveTime := now(); //如果最后活动时间和现在超过2分钟，发送活动测试包
    finally
      sleep(0);
    end;
  end;
end;

function TOutReadCMPPThreadObj.GetSeqid: Cardinal;
begin
  result := Seqid;
  inc(Seqid);
  if Seqid >= 4294967295 then
  begin
    //Seqid := 1;
    Seqid := 0;
  end;
end;

// 处理登陆 发送登陆信息
procedure TOutReadCMPPThreadObj.PrcMt;
var
  MtSeqId: integer;
begin
  if FTCPCmppClient.Connected then
  begin
    if FLogined then
    begin
      if now - FLastActiveTime > 30 / 3600 / 24 then
      begin
        if now - FLastActiveTime > 90 / 3600 / 24 then
        begin
          FTCPCmppClient.Disconnect;
        end
        else
        begin
          if now - LastSendActiveTime > 10 / 3600 / 24 then
          begin
            //发送活动测试包
            SendPacket(CreatePacket(CMPP_ACTIVE_TEST));
            //更新最后发送活动测试包时间
            LastSendActiveTime := now();
            //AddMsgToMemo('发送测试包');
          end;
        end;
      end
      else
      begin
        // 发送消息(1)
        MtSeqId := mtcmppbuffer.Get;
        if MtSeqId > 0 then
        begin
          SendMt(MtSeqId);
        end;
      end;
    end
    else
    begin
      if now - LastLoginTime > 6 / 3600 / 24 then
      begin
        //移动登陆测试
        //log_port := 1;
        SendPacket(CreatePacket(CMPP_CONNECT));
        LastLoginTime := now;
      end;
    end;
  end;
end;

// 对外发送函数
procedure TOutReadCMPPThreadObj.SendMt(i: integer);
var
  Buffer: TMtBuffer;
  outpac: TCMPP20_PACKET;
begin
  ZeroMemory(@Buffer, sizeof(TMtBuffer));
  // 设置Buffer
  Buffer := mtcmppbuffer.Read(i);
  outpac := CreatePacket(CMPP_SUBMIT);
  outpac.MsgHead.Sequence_ID := GetSeqid;
  outpac.MsgBody.CMPP_SUBMIT.Pk_total := 1; //赵君增加  pk_total
  outpac.MsgBody.CMPP_SUBMIT.Pk_number := 1; //赵君增加  pk_number
  outpac.MsgBody.CMPP_SUBMIT.Msg_Fmt := Buffer.Mt.MtMsgFmt;
  Move(Buffer.Mt.msg_src, outpac.MsgBody.CMPP_SUBMIT.msg_src, sizeof(Buffer.Mt.msg_src));
  Move(Buffer.Mt.OutFeeCode, outpac.MsgBody.CMPP_SUBMIT.FeeCode, sizeof(Buffer.Mt.OutFeeCode));
  Move(Buffer.Mt.OutServiceID, outpac.MsgBody.CMPP_SUBMIT.service_id, sizeof(Buffer.Mt.OutServiceID));
  Move(Buffer.Mt.OutFeeType, outpac.MsgBody.CMPP_SUBMIT.FeeType, sizeof(Buffer.Mt.OutFeeType));
  Move(Buffer.Mt.MtValidTime, outpac.MsgBody.CMPP_SUBMIT.Valid_Time, sizeof(Buffer.Mt.MtValidTime));
  Move(Buffer.Mt.MtAtTime, outpac.MsgBody.CMPP_SUBMIT.At_Time, sizeof(Buffer.Mt.MtAtTime));
  Move(Buffer.Mt.MtSpAddr, outpac.MsgBody.CMPP_SUBMIT.Src_ID, sizeof(TCMPPPhoneNum));
  Move(Buffer.Mt.MtUserAddr, outpac.MsgBody.CMPP_SUBMIT.dest_terminal_id, sizeof(TCMPPPhoneNum));
  outpac.MsgBody.CMPP_SUBMIT.MSG_LENGTH := Buffer.Mt.MtMsgLenth;
  outpac.MsgHead.Total_Length := sizeof(TCMPP_HEAD) + sizeof(TCMPP_SUBMIT) - sizeof(outpac.MsgBody.CMPP_SUBMIT.Msg_Content) + Buffer.Mt.MtMsgLenth;
  Move(Buffer.Mt.MtMsgContent, outpac.MsgBody.CMPP_SUBMIT.Msg_Content, Buffer.Mt.MtMsgLenth);
  SendPacket(outpac);
  mtcmppbuffer.Delete(i);
end;

procedure TOutReadCMPPThreadObj.SendPacket(pac: TCMPP20_PACKET);
var
  sendbuffer: TCOMMBuffer;
  sendbuffer0: TCOMMBuffer;
  NetPacOut, LocPacOut: TCMPP20_PACKET;
  Filestream: Tfilestream;
  i: integer;
begin
  //初始化变量
  ZeroMemory(@sendbuffer, sizeof(TCOMMBuffer));
  sendbuffer.BufferSize := 0;
  NetPacOut := pac;
  LocPacOut := pac;
  //包头部分，进行网络字节序转换
  //htonl（将32位主机字符顺序转换成网络字符顺序）.
  NetPacOut.MsgHead.Total_Length := htonl(LocPacOut.MsgHead.Total_Length);
  NetPacOut.MsgHead.Command_ID := htonl(LocPacOut.MsgHead.Command_ID);
  NetPacOut.MsgHead.Sequence_ID := htonl(LocPacOut.MsgHead.Sequence_ID);
  //将包头复制到发送缓冲中
  //move函数的作用是将输入数组中的元素从后面开始，两两交换，循环次数用n控制
  Move(NetPacOut.MsgHead, sendbuffer.Buffer, sizeof(TCMPP_HEAD));
  sendbuffer.BufferSize := sizeof(TCMPP_HEAD);

  case pac.MsgHead.Command_ID of
    CMPP_CONNECT:
      begin
        NetPacOut.MsgBody.CMPP_CONNECT.TimeStamp := htonl(LocPacOut.MsgBody.CMPP_CONNECT.TimeStamp);
        Move(NetPacOut.MsgBody.CMPP_CONNECT, sendbuffer.Buffer[sendbuffer.BufferSize], sizeof(TCMPP_CONNECT));
        sendbuffer.BufferSize := sendbuffer.BufferSize + sizeof(TCMPP_CONNECT);
      end;

    CMPP_SUBMIT:
      begin
        Move(NetPacOut.MsgBody.CMPP_SUBMIT, sendbuffer.Buffer[sendbuffer.BufferSize], 139);
        sendbuffer.BufferSize := sendbuffer.BufferSize + 139;
        //把内容 发送到发送内存中
        Move(NetPacOut.MsgBody.CMPP_SUBMIT.Msg_Content, sendbuffer.Buffer[sendbuffer.BufferSize], NetPacOut.MsgBody.CMPP_SUBMIT.MSG_LENGTH);
        //包体的长度 = 包体前面字节 + 内容的长度
        sendbuffer.BufferSize := sendbuffer.BufferSize + NetPacOut.MsgBody.CMPP_SUBMIT.MSG_LENGTH;
        //把 Reserve的值赋给 buffersize去
        Move(NetPacOut.MsgBody.CMPP_SUBMIT.Reserve, sendbuffer.Buffer[sendbuffer.BufferSize], sizeof(NetPacOut.MsgBody.CMPP_SUBMIT.Reserve));
        //加上 reserve的 8个字节
        sendbuffer.BufferSize := sendbuffer.BufferSize + sizeof(NetPacOut.MsgBody.CMPP_SUBMIT.Reserve);

      end;

    CMPP_DELIVER_RESP:
      begin
        NetPacOut.MsgBody.CMPP_DELIVER_RESP.result := htonl(LocPacOut.MsgBody.CMPP_DELIVER_RESP.result);

        Move(NetPacOut.MsgBody.CMPP_DELIVER_RESP, sendbuffer.Buffer[sendbuffer.BufferSize], sizeof(TCMPP_SUBMIT_RESP));
        sendbuffer.BufferSize := sendbuffer.BufferSize + sizeof(TCMPP_SUBMIT_RESP);
      end;

    CMPP_ACTIVE_TEST:
      begin

      end;

    CMPP_ACTIVE_TEST_RESP:
      begin
        NetPacOut.MsgBody.CMPP_ACTIVE_TEST_RESP.Success_Id := htonl(LocPacOut.MsgBody.CMPP_ACTIVE_TEST_RESP.Success_Id);

        Move(NetPacOut.MsgBody.CMPP_ACTIVE_TEST_RESP, sendbuffer.Buffer[sendbuffer.BufferSize], sizeof(TCMPP_ACTIVE_TEST_RESP));
        sendbuffer.BufferSize := sendbuffer.BufferSize + sizeof(TCMPP_ACTIVE_TEST_RESP);
      end;
  end;

  if sendbuffer.BufferSize = LocPacOut.MsgHead.Total_Length then
  begin
    if LocPacOut.MsgHead.Command_ID = CMPP_SUBMIT then
    begin
      inc(WindowSize);
      mtcmppbuffer.Update(LocPacOut.MsgHead.Sequence_ID);
      inc(FMtCount);
    end;

    if MainForm.OutMonitor.Checked then
    begin
      //暂时去掉监控包 2005/11/12
      MonitorThread.OutMonitorcmppBuffer.Add(LocPacOut);
    end;

    try
      FTCPCmppClient.WriteBuffer(sendbuffer.Buffer, sendbuffer.BufferSize);
      //AddMsgToMemo('cmpp外部网关发送完毕');
    except
      on e: exception do
      begin
        AddMsgToMemo('cmpp外部网关发送错误：' + e.Message);
        FTCPCmppClient.Disconnect;
      end;
    end;
  end;
end;

procedure TOutReadCMPPThreadObj.ThAddMsgToMemo;
begin
  if MainForm <> nil then
  begin
    MainForm.ShowToMemo(ErrMsg, MainForm.MonitorMemo);
  end;
end;

{CMPP0 移动 7910  TMtSendThreadObj }
procedure TMtSendCMPP0ThreadObj.AddMsgToMemo(const Msg: string);
begin
  ErrMsg := Msg;
  Synchronize(ThAddMsgToMemo);
end;

constructor TMtSendCMPP0ThreadObj.Create(CreateSuspended: boolean);
begin
  inherited;
  LastActiveTime := now;
end;

destructor TMtSendCMPP0ThreadObj.destroy;
begin
  LastActiveTime := 0;
  inherited;
end;

procedure TMtSendCMPP0ThreadObj.Execute;
begin
  FreeOnTerminate := True;
  while not Terminated do
  begin
    try
      try
        MtPrc;
      except
        on e: exception do
        begin
          AddMsgToMemo('MTCMPP消息发送线程:' + e.Message);
        end;
      end;
    finally
      LastActiveTime := now;
      //这里需要做流量限制
      sleep(1000 div GGATECONFIG.Flux);
    end;
  end;
end;

procedure TMtSendCMPP0ThreadObj.MtPrc;
begin
  if OutReadCMPP0Thread <> nil then
  begin
    OutReadCMPP0Thread.PrcMt;
  end;
end;

procedure TMtSendCMPP0ThreadObj.ThAddMsgToMemo;
begin
  if MainForm <> nil then
  begin
    MainForm.ShowToMemo(ErrMsg, MainForm.MonitorMemo);
  end;
end;


{CMPP0 7910端口 TOutReadCMPP0ThreadObj}
procedure TOutReadCMPP0ThreadObj.AddMsgToMemo(const Msg: string);
begin
  ErrMsg := Msg;
  Synchronize(ThAddMsgToMemo);
end;

procedure TOutReadCMPP0ThreadObj.ClientRead;
var
  deliver_file: Tfilestream;
  i, i0, i1: integer;
  HEXS, MSG_CON: string;
begin
  //CMPP 读取到CMPP缓冲
  try
    try
      //FTCPCmppClient.CheckForGracefulDisconnect(false);
      FTCPCmppClient.CheckForGracefulDisconnect();
    except
      on e: exception do
      begin
        AddMsgToMemo('TOutReadCMPP0ThreadObj' + e.Message);
        sleep(1000);
      end;
    end;

    if FTCPCmppClient.Connected then
    begin
      if FRecCmppBuffer.BufferSize = 0 then
      begin
        //初始化结构体，用来分别存放网络数据包和本地数据包
        ZeroMemory(@FlocCmppPacketIn, sizeof(TCMPP20_PACKET));
        ZeroMemory(@FnetCmppPacketIn, sizeof(TCMPP20_PACKET));

        //这里阻塞读取数据包头
        FTCPCmppClient.ReadBuffer(FRecCmppBuffer.Buffer, sizeof(TCMPP_HEAD));
        FRecCmppBuffer.BufferSize := sizeof(TCMPP_HEAD);

        //将读到的包头数据复制到网络结构体中
        Move(FRecCmppBuffer.Buffer, FnetCmppPacketIn.MsgHead, sizeof(TCMPP_HEAD));
        //经网络字节序转换后，将网络结构体包头复制到本地结构体中
        FlocCmppPacketIn.MsgHead.Total_Length := ntohl(FnetCmppPacketIn.MsgHead.Total_Length);
        FlocCmppPacketIn.MsgHead.Command_ID := ntohl(FnetCmppPacketIn.MsgHead.Command_ID);
        FlocCmppPacketIn.MsgHead.Sequence_ID := ntohl(FnetCmppPacketIn.MsgHead.Sequence_ID);
      end;

      case FlocCmppPacketIn.MsgHead.Command_ID of
        CMPP_CONNECT_RESP:
          begin
            //登录应答包，读取对应的长度，并复制到网络结构体和本地结构体中
            {FTCPCmppClient.ReadBuffer(FRecCmppBuffer.Buffer[FRecCmppBuffer.BufferSize], sizeof(TCMPP_CONNECT_RESP));
            FRecCmppBuffer.BufferSize := FRecCmppBuffer.BufferSize + sizeof(TCMPP_CONNECT_RESP);
            Move(FRecCmppBuffer.Buffer, FnetCmppPacketIn, FRecCmppBuffer.BufferSize);
            FlocCmppPacketIn.MsgBody.CMPP_CONNECT_RESP := FnetCmppPacketIn.MsgBody.CMPP_CONNECT_RESP;
            FlocCmppPacketIn.MsgBody.CMPP_CONNECT_RESP.Status := ntohl(FnetCmppPacketIn.MsgBody.CMPP_CONNECT_RESP.Status);
            }
            //登录应答包，读取对应的长度，并复制到网络结构体和本地结构体中
            FTCPCmppClient.ReadBuffer(FRecCmppBuffer.Buffer[FRecCmppBuffer.BufferSize], sizeof(TCMPP_CONNECT_RESP));
            FRecCmppBuffer.BufferSize := FRecCmppBuffer.BufferSize + sizeof(TCMPP_CONNECT_RESP);
            Move(FRecCmppBuffer.Buffer, FnetCmppPacketIn, FRecCmppBuffer.BufferSize);
            FlocCmppPacketIn.MsgBody.CMPP_CONNECT_RESP := FnetCmppPacketIn.MsgBody.CMPP_CONNECT_RESP;
            FlocCmppPacketIn.MsgBody.CMPP_CONNECT_RESP.Status := ntohl(FnetCmppPacketIn.MsgBody.CMPP_CONNECT_RESP.Status);

          end;

        CMPP_SUBMIT_RESP:
          begin
            //下行应答包，读取对应的长度，并复制到网络结构体和本地结构体中
            FTCPCmppClient.ReadBuffer(FRecCmppBuffer.Buffer[FRecCmppBuffer.BufferSize], sizeof(TCMPP_SUBMIT_RESP));
            FRecCmppBuffer.BufferSize := FRecCmppBuffer.BufferSize + sizeof(TCMPP_SUBMIT_RESP);
            Move(FRecCmppBuffer.Buffer, FnetCmppPacketIn, FRecCmppBuffer.BufferSize);
            FlocCmppPacketIn.MsgBody.CMPP_SUBMIT_RESP := FnetCmppPacketIn.MsgBody.CMPP_SUBMIT_RESP;
            FlocCmppPacketIn.MsgBody.CMPP_SUBMIT_RESP.result := ntohl(FnetCmppPacketIn.MsgBody.CMPP_SUBMIT_RESP.result);
          end;

        CMPP_DELIVER:
          begin
            //继续从网络端口 读取 包头约定的数据包长度 - 包头的长度，得到剩余的包体部分
            //FRecCmppBuffer.Buffer 已经包含了包头，在从包头结束，包体开始的位置再读取剩余部分得到整体包
            FTCPCmppClient.ReadBuffer(FRecCmppBuffer.Buffer[FRecCmppBuffer.BufferSize], FlocCmppPacketIn.MsgHead.Total_Length - FRecCmppBuffer.BufferSize);
            //得到包体总长度
            FRecCmppBuffer.BufferSize := FlocCmppPacketIn.MsgHead.Total_Length;
            //得到总的包 放到  FnetCmppPacketIn 里面 FnetCmppPacketIn为整体包
            Move(FRecCmppBuffer.Buffer, FnetCmppPacketIn, FRecCmppBuffer.BufferSize);

            FnetCmppPacketIn.MsgBody.CMPP_DELIVER.MSG_LENGTH := FlocCmppPacketIn.MsgHead.Total_Length - sizeof(TCMPP_HEAD) - 70; //77
            //FnetCmppPacketIn.MsgBody.CMPP_DELIVER.MSG_LENGTH := FlocCmppPacketIn.MsgHead.Total_Length - sizeof(TCMPP_HEAD) - 77;
            FlocCmppPacketIn.MsgBody.CMPP_DELIVER := FnetCmppPacketIn.MsgBody.CMPP_DELIVER;
            ZeroMemory(@FlocCmppPacketIn.MsgBody.CMPP_DELIVER.Msg_Content, sizeof(FlocCmppPacketIn.MsgBody.CMPP_DELIVER.Msg_Content));
            ZeroMemory(@FlocCmppPacketIn.MsgBody.CMPP_DELIVER.Reserved, sizeof(FlocCmppPacketIn.MsgBody.CMPP_DELIVER.Reserved));
            Move(FnetCmppPacketIn.MsgBody.CMPP_DELIVER.Msg_Content, FlocCmppPacketIn.MsgBody.CMPP_DELIVER.Msg_Content, FlocCmppPacketIn.MsgBody.CMPP_DELIVER.MSG_LENGTH);
            Move(FnetCmppPacketIn.MsgBody.CMPP_DELIVER.Msg_Content[FlocCmppPacketIn.MsgBody.CMPP_DELIVER.MSG_LENGTH], FlocCmppPacketIn.MsgBody.CMPP_DELIVER.Reserved, sizeof(FlocCmppPacketIn.MsgBody.CMPP_DELIVER.Reserved));
            FnetCmppPacketIn.MsgBody := FlocCmppPacketIn.MsgBody;
            //deliver_file := TFileStream.Create( 'Deliver' + inttostr(FnetCmppPacketIn.MsgBody.CMPP_DELIVER.Msg_Id) + '.del', fmCreate );
            //deliver_file.WriteBuffer(  FnetCmppPacketIn.MsgBody.CMPP_DELIVER.Msg_Content,FlocCmppPacketIn.MsgBody.CMPP_DELIVER.MSG_LENGTH);
            HEXS := '';
            for i0 := 0 to FnetCmppPacketIn.MsgBody.CMPP_DELIVER.MSG_LENGTH - 1 do
              HEXS := HEXS + IntToHex(byte(FnetCmppPacketIn.MsgBody.CMPP_DELIVER.Msg_Content[i0]), 2);
            //MainForm.MOMemo.Lines.Add(HEXS);
            case FnetCmppPacketIn.MsgBody.CMPP_DELIVER.Msg_Fmt of
              8:
                begin
                  for i1 := 0 to (length(HEXS) div 4) - 1 do
                  begin
                    //  MSG_CON :=MSG_CON + WChar(StrToInt('$' +  HEXS[i1 * 4 + 1] + HEXS[i1 * 4 + 2]) shl 8
                     //   + StrToInt('$' + HEXS[i1 * 4 + 3] +  HEXS[i1 * 4 + 4]));
                    MSG_CON := MSG_CON + wchar(strtoint('$' + HEXS[i1 * 4 + 1] + HEXS[i1 * 4 + 2]
                      + HEXS[i1 * 4 + 3] + HEXS[i1 * 4 + 4]));
                  end;
                  //MainForm.MOMemo.Lines.Add(MSG_CON);
                  // MSG_CON := Ucs2ToGBK(Buffer.mo.Msg_Fmt, HEXS);
                end;
              0:
                begin
                  MSG_CON := FnetCmppPacketIn.MsgBody.CMPP_DELIVER.Msg_Content;
                end;
              15:
                begin
                  MSG_CON := FnetCmppPacketIn.MsgBody.CMPP_DELIVER.Msg_Content;
                end;
              25:
                begin
                  MSG_CON := BIG5TOGB(FnetCmppPacketIn.MsgBody.CMPP_DELIVER.Msg_Content);
                end;
              //:= htonl(length());
            end;
            //FlocCmppPacketIn.MsgBody.CMPP_DELIVER.MSG_LENGTH := length(trim(MSG_CON));
            //FlocCmppPacketIn.MsgBody.CMPP_DELIVER.Msg_Content := MSG_CON;
           // SetPchar(Move(MSG_CON, FlocCmppPacketIn.MsgBody.CMPP_DELIVER.Msg_Content, FlocCmppPacketIn.MsgBody.CMPP_DELIVER.MSG_LENGTH));
            SetPchar(FlocCmppPacketIn.MsgBody.CMPP_DELIVER.Msg_Content, MSG_CON, FlocCmppPacketIn.MsgBody.CMPP_DELIVER.MSG_LENGTH);
            //MainForm.MOMemo.Lines.Add(MSG_CON);
            //MainForm.MOMemo.Lines.Add(inttostr(FlocCmppPacketIn.MsgBody.CMPP_DELIVER.MSG_LENGTH));
           // MainForm.MOMemo.Lines.Add(FlocCmppPacketIn.MsgBody.CMPP_DELIVER.Msg_Content);
            //
            //end;
          end;

        CMPP_ACTIVE_TEST:
          begin
            //AddMsgToMemo('CMPP0外部网关活动测试要求');
          end;

        CMPP_ACTIVE_TEST_RESP:
          begin
            //AddMsgToMemo('CMPP0外部网关活动测试回复');
          end;
        CMPP_TERMINATE:
          begin
            AddMsgToMemo('CMPP0外部网关要求终止连接');
          end;
        CMPP_TERMINATE_RESP:
          begin
            AddMsgToMemo('CMPP0外部网关要求终止连接应答');
          end;
      else
        begin
          FTCPCmppClient.Disconnect;
        end;
      end;

      if MainForm.OutMonitor.Checked then
      begin
        //暂时取消监控 2005/11/12
        MonitorThread.OutMonitorcmppBuffer.Add(FlocCmppPacketIn);
      end;

      case FlocCmppPacketIn.MsgHead.Command_ID of
        CMPP_CONNECT_RESP:
          begin
            if FlocCmppPacketIn.MsgBody.CMPP_CONNECT_RESP.Status = 0 then
            begin
              FLogined := True;
              AddMsgToMemo('CMPP外部网关0端口登录成功');
            end
            else
            begin
              FLogined := false;
              AddMsgToMemo('CMPP外部网关0登录失败');
            end;
          end;

        CMPP_SUBMIT_RESP:
          begin
            mtcmppbuffer.UpdateResp(FlocCmppPacketIn.MsgHead.Command_ID, FlocCmppPacketIn.MsgBody.CMPP_SUBMIT_RESP.Msg_Id, FlocCmppPacketIn.MsgBody.CMPP_SUBMIT_RESP.result);
            inc(FMtRespCount);

            WindowSize := WindowSize - 1;
            if WindowSize < 0 then WindowSize := 0;
          end;

        CMPP_DELIVER: //mo上行过来的写入缓冲
          begin
            //写入缓冲，或是状态报告
            if FlocCmppPacketIn.MsgBody.CMPP_DELIVER.Registered_Delivery = 1 then
            begin
              //状态报告,写入状态报告缓冲中
              rptcmppbuffer.Add(FlocCmppPacketIn);
              inc(FRptCount);
            end
            else
            begin
              //MO,将Mo写入Mo缓冲中
              mocmppbuffer.Add(FlocCmppPacketIn);
              inc(FMoCount);
            end;

            //应答
            SendPacket(CreateRespPacket(FlocCmppPacketIn));
          end;

        CMPP_ACTIVE_TEST:
          begin
            WindowSize := 0;
            SendPacket(CreateRespPacket(FlocCmppPacketIn));
            //AddMsgToMemo('cmpp外部网关0发送长连接测试包完毕');
            //2005/11/21
            LastSendActiveTime := now();
          end;

        CMPP_ACTIVE_TEST_RESP:
          begin
            WindowSize := 0;
            //2005/11/21
            LastSendActiveTime := now();
          end;
      end;

      FRecCmppBuffer.BufferSize := 0;
      ZeroMemory(@FRecCmppBuffer.Buffer, sizeof(FRecCmppBuffer.Buffer));
    end;
  except
    on e: exception do
    begin
      AddMsgToMemo('CMPP外部网关0接收线程:' + e.Message);
      sleep(1000);
      FTCPCmppClient.Disconnect;
    end;
  end;

end;

constructor TOutReadCMPP0ThreadObj.Create(CreateSuspended: boolean);
begin
  inherited;
  ZeroMemory(@FRecCmppBuffer.Buffer, sizeof(FRecCmppBuffer.Buffer));
  FRecCmppBuffer.BufferSize := 0;

  ZeroMemory(@FlocCmppPacketIn, sizeof(TCMPP20_PACKET));
  ZeroMemory(@FnetCmppPacketIn, sizeof(TCMPP20_PACKET));

  FLogined := false;
  FMoCount := 0;
  FMtCount := 0;
  FRptCount := 0;
  FMtRespCount := 0;
  FMtRefuseCount := 0;
  Seqid := 1;
  WindowSize := 0;
  FLastActiveTime := now;
  MtHasUnsendMessage := false;
  MtMessage := '';
  MtNumber := '';
  MtUnsend := 100;
  log_port := 0;
end;

function TOutReadCMPP0ThreadObj.CreatePacket(
  const RequestID: Cardinal): TCMPP20_PACKET;
var
  //pac: TSMGP13_PACKET;
  pac: TCMPP20_PACKET;
  Time: string;
  strTemp: string;
  tempArray: array[0..255] of char;
  tempbArray: array[0..255] of byte;
  md5: TMD5;
  md5str: md5digest;
  md5_con: MD5Context;
  Md5UpLen, i: integer; //MD5Update Length;
  str1: array[0..31] of char;
begin
  ZeroMemory(@pac, sizeof(TCMPP20_PACKET));
  pac.MsgHead.Command_ID := RequestID;

  case RequestID of
    CMPP_CONNECT:
      begin
        pac.MsgHead.Total_Length := sizeof(TCMPP_HEAD) + sizeof(TCMPP_CONNECT);
        pac.MsgHead.Sequence_ID := GetSeqid;
        with pac.MsgBody.CMPP_CONNECT do
        begin
          SetPchar(Source_Addr, GGATECONFIG.cmppClientID, sizeof(Source_Addr));
          DateTimeToString(Time, 'MMDDHHMMSS', now);
          Version := CMPP_VERSION;
          strTemp := GGATECONFIG.cmppClientID + '000000000' + GGATECONFIG.cmppClientSecret + Time;
          StrPCopy(str1, strTemp);
          for i := length(GGATECONFIG.cmppClientID) to (length(GGATECONFIG.cmppClientID) + 8) do
            str1[i] := #0;
          Md5UpLen := length(GGATECONFIG.cmppClientID) + 9 + length(GGATECONFIG.cmppClientSecret) + 10;
          MD5Init(md5_con);
          MD5Update(md5_con, str1, Md5UpLen);
          MD5Final(md5_con, md5str);
          Move(md5str, AuthenticatorSource, 16);
          TimeStamp := strtoint(Time);
        end;

      end;

    CMPP_SUBMIT:
      begin
        pac.MsgBody.CMPP_SUBMIT.Registered_Delivery := 1;
        pac.MsgBody.CMPP_SUBMIT.Msg_level := 0;
        pac.MsgBody.CMPP_SUBMIT.DestUsr_tl := 1;
      end;

    CMPP_ACTIVE_TEST:
      begin
        pac.MsgHead.Total_Length := sizeof(TCMPP_HEAD);
        pac.MsgHead.Sequence_ID := GetSeqid;
      end;
  end;

  result := pac;
end;

function TOutReadCMPP0ThreadObj.CreateRespPacket(
  const recpac: TCMPP20_PACKET): TCMPP20_PACKET;
var
  pac: TCMPP20_PACKET;
begin
  ZeroMemory(@pac, sizeof(TCMPP20_PACKET));

  case recpac.MsgHead.Command_ID of
    CMPP_DELIVER:
      begin
        pac.MsgHead.Command_ID := CMPP_DELIVER_RESP;
        pac.MsgHead.Total_Length := sizeof(TCMPP_HEAD) + sizeof(TCMPP_DELIVER_RESP);
        pac.MsgHead.Sequence_ID := recpac.MsgHead.Sequence_ID;
        Move(recpac.MsgBody.CMPP_DELIVER_RESP.Msg_Id, pac.MsgBody.CMPP_DELIVER_RESP.Msg_Id, sizeof(pac.MsgBody.CMPP_DELIVER_RESP.Msg_Id));
        pac.MsgBody.CMPP_DELIVER_RESP.result := 0;
      end;

    CMPP_ACTIVE_TEST:
      begin
        {pac.MsgHead.Total_Length := sizeof(TCMPP_HEAD);
        pac.MsgHead.Command_ID := CMPP_ACTIVE_TEST_RESP;
        pac.MsgHead.Sequence_ID := recpac.MsgHead.Sequence_ID;}
        pac.MsgHead.Command_ID := CMPP_ACTIVE_TEST_RESP;
        pac.MsgHead.Total_Length := sizeof(TCMPP_HEAD) + sizeof(TCMPP_ACTIVE_TEST_RESP);
        pac.MsgHead.Sequence_ID := recpac.MsgHead.Sequence_ID;
        pac.MsgBody.CMPP_ACTIVE_TEST_RESP.Success_Id := 0;
      end;
  end;

  result := pac;
end;

destructor TOutReadCMPP0ThreadObj.destroy;
begin
  FTCPCmppClient := nil;
  inherited;
end;

procedure TOutReadCMPP0ThreadObj.Execute;
begin
  FreeOnTerminate := True;
  while not Terminated do
  begin
    try
      ClientRead;
      FLastActiveTime := now(); //如果最后活动时间和现在超过2分钟，发送活动测试包
    finally
      sleep(0);
    end;
  end;
end;

function TOutReadCMPP0ThreadObj.GetSeqid: Cardinal;
begin
  result := Seqid;
  inc(Seqid);
  if Seqid >= 4294967295 then
  begin
    Seqid := 1;
  end;
end;

// 处理登陆 发送登陆信息
procedure TOutReadCMPP0ThreadObj.PrcMt;
var
  MtSeqId: integer;
begin
  if FTCPCmppClient.Connected then
  begin
    if FLogined then
    begin
      if now - FLastActiveTime > 30 / 3600 / 24 then
      begin
        if now - FLastActiveTime > 90 / 3600 / 24 then
        begin
          FTCPCmppClient.Disconnect;
        end
        else
        begin
          if now - LastSendActiveTime > 10 / 3600 / 24 then
          begin
            //发送活动测试包
            SendPacket(CreatePacket(CMPP_ACTIVE_TEST));
            //更新最后发送活动测试包时间
            LastSendActiveTime := now();
          end;
        end;
      end
      else
      begin

      end;
    end
    else
    begin
      if now - LastLoginTime > 6 / 3600 / 24 then
      begin
        //移动登陆测试
        SendPacket(CreatePacket(CMPP_CONNECT));
        LastLoginTime := now;
      end;
    end;
  end;
end;

procedure TOutReadCMPP0ThreadObj.SendPacket(pac: TCMPP20_PACKET);
var
  sendbuffer: TCOMMBuffer;
  NetPacOut, LocPacOut: TCMPP20_PACKET;
begin
  //初始化变量
  ZeroMemory(@sendbuffer, sizeof(TCOMMBuffer));
  sendbuffer.BufferSize := 0;
  NetPacOut := pac;
  LocPacOut := pac;

  //包头部分，进行网络字节序转换
  //htonl（将32位主机字符顺序转换成网络字符顺序）.
  NetPacOut.MsgHead.Total_Length := htonl(LocPacOut.MsgHead.Total_Length);
  NetPacOut.MsgHead.Command_ID := htonl(LocPacOut.MsgHead.Command_ID);
  NetPacOut.MsgHead.Sequence_ID := htonl(LocPacOut.MsgHead.Sequence_ID);

  //将包头复制到发送缓冲中
  //move函数的作用是将输入数组中的元素从后面开始，两两交换，循环次数用n控制
  Move(NetPacOut.MsgHead, sendbuffer.Buffer, sizeof(TCMPP_HEAD));
  sendbuffer.BufferSize := sizeof(TCMPP_HEAD);

  case pac.MsgHead.Command_ID of
    CMPP_CONNECT:
      begin
        NetPacOut.MsgBody.CMPP_CONNECT.TimeStamp := htonl(LocPacOut.MsgBody.CMPP_CONNECT.TimeStamp);
        Move(NetPacOut.MsgBody.CMPP_CONNECT, sendbuffer.Buffer[sendbuffer.BufferSize], sizeof(TCMPP_CONNECT));
        sendbuffer.BufferSize := sendbuffer.BufferSize + sizeof(TCMPP_CONNECT);
      end;

    CMPP_SUBMIT:
      begin
        Move(NetPacOut.MsgBody.CMPP_SUBMIT, sendbuffer.Buffer[sendbuffer.BufferSize], 127);
        sendbuffer.BufferSize := sendbuffer.BufferSize + 127;

        Move(NetPacOut.MsgBody.CMPP_SUBMIT.Msg_Content, sendbuffer.Buffer[sendbuffer.BufferSize], NetPacOut.MsgBody.CMPP_SUBMIT.MSG_LENGTH);
        sendbuffer.BufferSize := sendbuffer.BufferSize + NetPacOut.MsgBody.CMPP_SUBMIT.MSG_LENGTH;

        Move(NetPacOut.MsgBody.CMPP_SUBMIT.Reserve, sendbuffer.Buffer[sendbuffer.BufferSize], sizeof(NetPacOut.MsgBody.CMPP_SUBMIT.Reserve));
        sendbuffer.BufferSize := sendbuffer.BufferSize + sizeof(NetPacOut.MsgBody.CMPP_SUBMIT.Reserve);
      end;

    CMPP_DELIVER_RESP:
      begin
        NetPacOut.MsgBody.CMPP_DELIVER_RESP.result := htonl(LocPacOut.MsgBody.CMPP_DELIVER_RESP.result);

        Move(NetPacOut.MsgBody.CMPP_DELIVER_RESP, sendbuffer.Buffer[sendbuffer.BufferSize], sizeof(TCMPP_SUBMIT_RESP));
        sendbuffer.BufferSize := sendbuffer.BufferSize + sizeof(TCMPP_SUBMIT_RESP);
      end;

    CMPP_ACTIVE_TEST:
      begin

      end;

    CMPP_ACTIVE_TEST_RESP:
      begin
        NetPacOut.MsgBody.CMPP_ACTIVE_TEST_RESP.Success_Id := htonl(LocPacOut.MsgBody.CMPP_ACTIVE_TEST_RESP.Success_Id);

        Move(NetPacOut.MsgBody.CMPP_ACTIVE_TEST_RESP, sendbuffer.Buffer[sendbuffer.BufferSize], sizeof(TCMPP_ACTIVE_TEST_RESP));
        sendbuffer.BufferSize := sendbuffer.BufferSize + sizeof(TCMPP_ACTIVE_TEST_RESP);

      end;
  end;

  if sendbuffer.BufferSize = LocPacOut.MsgHead.Total_Length then
  begin
    if LocPacOut.MsgHead.Command_ID = CMPP_SUBMIT then
    begin
      inc(WindowSize);
      mtcmppbuffer.Update(LocPacOut.MsgHead.Sequence_ID);
      inc(FMtCount);
    end;

    if MainForm.OutMonitor.Checked then
    begin
      MonitorThread.OutMonitorcmppBuffer.Add(LocPacOut);
    end;

    try
      FTCPCmppClient.WriteBuffer(sendbuffer.Buffer, sendbuffer.BufferSize);
    except
      on e: exception do
      begin
        AddMsgToMemo('cmpp0外部网关发送错误:' + e.Message);
        FTCPCmppClient.Disconnect;
      end;
    end;
  end;
end;

procedure TOutReadCMPP0ThreadObj.ThAddMsgToMemo;
begin
  if MainForm <> nil then
  begin
    MainForm.ShowToMemo(ErrMsg, MainForm.MonitorMemo);
  end;
end;
//CMPP 移动
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


//sgip 联通
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
{SGIP  TMtSendThreadObj }
procedure TMtSendSgipThreadObj.AddMsgToMemo(const Msg: string);
begin
  ErrMsg := Msg;
  Synchronize(ThAddMsgToMemo);
end;

constructor TMtSendSgipThreadObj.Create(CreateSuspended: boolean);
begin
  inherited;
  LastActiveTime := now;
end;

destructor TMtSendSgipThreadObj.destroy;
begin
  LastActiveTime := 0;
  inherited;
end;

procedure TMtSendSgipThreadObj.Execute;
begin
  FreeOnTerminate := True;
  while not Terminated do
  begin
    try
      try
        MtPrc;
      except
        on e: exception do
        begin
          AddMsgToMemo('MT消息发送线程:' + e.Message);
        end;
      end;
    finally
      LastActiveTime := now;
      //这里需要做流量限制
      sleep(1000 div GGATECONFIG.Flux);
    end;
  end;
end;

procedure TMtSendSgipThreadObj.MtPrc;
begin
  if OutReadSgipThread <> nil then
  begin
    OutReadSgipThread.PrcMt;
  end;
end;

procedure TMtSendSgipThreadObj.ThAddMsgToMemo;
begin
  if MainForm <> nil then
  begin
    MainForm.ShowToMemo(ErrMsg, MainForm.MonitorMemo);
  end;
end;

{Sgip TOutReadSgipThreadObj }
procedure TOutReadSgipThreadObj.AddMsgToMemo(const Msg: string);
begin
  ErrMsg := Msg;
  Synchronize(ThAddMsgToMemo);
end;

procedure TOutReadSgipThreadObj.ClientRead;
begin
  try
    try
      FTCPClient.CheckForGracefulDisconnect();
    except
      on e: exception do
      begin
        AddMsgToMemo('TOutReadSgipThreadObj' + e.Message);
        sleep(1000);
      end;
    end;

    if FTCPClient.Connected then
    begin
      if FRecBuffer.BufferSize = 0 then
      begin
        //初始化结构体，用来分别存放网络数据包和本地数据包
        ZeroMemory(@FlocPacketIn, sizeof(TSGIP12_PACKET));
        ZeroMemory(@FnetPacketIn, sizeof(TSGIP12_PACKET));

        //这里阻塞读取数据包头
        FTCPClient.ReadBuffer(FRecBuffer.Buffer, sizeof(TSGIP12_HEAD));
        FRecBuffer.BufferSize := sizeof(TSGIP12_HEAD);

        //将读到的包头数据复制到网络结构体中
        Move(FRecBuffer.Buffer, FnetPacketIn.MsgHead, sizeof(TSGIP12_HEAD));
        //经网络字节序转换后，将网络结构体包头复制到本地结构体中
        FlocPacketIn.MsgHead.Message_Length := ntohl(FnetPacketIn.MsgHead.Message_Length);
        FlocPacketIn.MsgHead.Command_ID := ntohl(FnetPacketIn.MsgHead.Command_ID);
        FlocPacketIn.MsgHead.SNumber1 := ntohl(FnetPacketIn.MsgHead.SNumber1);
      end;

      case FlocPacketIn.MsgHead.Command_ID of
        SGIP12_Bind_RESP:
          begin
            //登录应答包，读取对应的长度，并复制到网络结构体和本地结构体中
            FTCPClient.ReadBuffer(FRecBuffer.Buffer[FRecBuffer.BufferSize], sizeof(TSGIP12_Bind_RESP));
            FRecBuffer.BufferSize := FRecBuffer.BufferSize + sizeof(TSGIP12_Bind_RESP);
            Move(FRecBuffer.Buffer, FnetPacketIn, FRecBuffer.BufferSize);
            FlocPacketIn.MsgBody.LOGIN_RESP := FnetPacketIn.MsgBody.LOGIN_RESP;
            FlocPacketIn.MsgBody.LOGIN_RESP.result := ntohl(FnetPacketIn.MsgBody.LOGIN_RESP.result);
          end;

        SGIP12_SUBMIT_RESP:
          begin
            //下行应答包，读取对应的长度，并复制到网络结构体和本地结构体中
            FTCPClient.ReadBuffer(FRecBuffer.Buffer[FRecBuffer.BufferSize], sizeof(TSGIP12_SUBMIT_RESP));
            FRecBuffer.BufferSize := FRecBuffer.BufferSize + sizeof(TSGIP12_SUBMIT_RESP);
            Move(FRecBuffer.Buffer, FnetPacketIn, FRecBuffer.BufferSize);
            FlocPacketIn.MsgBody.SUBMIT_RESP := FnetPacketIn.MsgBody.SUBMIT_RESP;
            FlocPacketIn.MsgBody.SUBMIT_RESP.result := ntohl(FnetPacketIn.MsgBody.SUBMIT_RESP.result);
          end;

        SGIP12_DELIVER:
          begin
            FTCPClient.ReadBuffer(FRecBuffer.Buffer[FRecBuffer.BufferSize], FlocPacketIn.MsgHead.Message_Length - FRecBuffer.BufferSize);
            FRecBuffer.BufferSize := FlocPacketIn.MsgHead.Message_Length;
            Move(FRecBuffer.Buffer, FnetPacketIn, FRecBuffer.BufferSize);
            FnetPacketIn.MsgBody.DELIVER.MessageLength := FlocPacketIn.MsgHead.Message_Length - sizeof(TSGIP12_HEAD) - 77;
            FlocPacketIn.MsgBody.DELIVER := FnetPacketIn.MsgBody.DELIVER;

            ZeroMemory(@FlocPacketIn.MsgBody.DELIVER.MessageContent, sizeof(FlocPacketIn.MsgBody.DELIVER.MessageContent));
            ZeroMemory(@FlocPacketIn.MsgBody.DELIVER.Reserve, sizeof(FlocPacketIn.MsgBody.DELIVER.Reserve));

            Move(FnetPacketIn.MsgBody.DELIVER.MessageContent, FlocPacketIn.MsgBody.DELIVER.MessageContent, FlocPacketIn.MsgBody.DELIVER.MessageLength);
            Move(FnetPacketIn.MsgBody.DELIVER.MessageContent[FlocPacketIn.MsgBody.DELIVER.MessageLength], FlocPacketIn.MsgBody.DELIVER.Reserve, sizeof(FlocPacketIn.MsgBody.DELIVER.Reserve));

            FnetPacketIn.MsgBody := FlocPacketIn.MsgBody;
          end;

        {SGIP12_ACTIVE_TEST:
          begin

          end;

        SGIP12_ACTIVE_TEST_RESP:
          begin

          end;    }

      else
        begin
          FTCPClient.Disconnect;
        end;
      end;

      if MainForm.OutMonitor.Checked then
      begin
        MonitorThread.OutMonitorSgipBuffer.Add(FlocPacketIn);
      end;

      case FlocPacketIn.MsgHead.Command_ID of
        SGIP12_Bind_RESP:
          begin
            if FlocPacketIn.MsgBody.LOGIN_RESP.result = 0 then
            begin
              FLogined := True;
              AddMsgToMemo('SGIP外部网关登录成功');
            end
            else
            begin
              FLogined := false;
              AddMsgToMemo('SGIP外部网关登录失败');
            end;
          end;

        SGIP12_SUBMIT_RESP:
          begin
            mtbuffer.UpdateResp(FlocPacketIn.MsgHead.SNumber1, FlocPacketIn.MsgBody.SUBMIT_RESP.Reserve, FlocPacketIn.MsgBody.SUBMIT_RESP.result);
            inc(FMtRespCount);

            WindowSize := WindowSize - 1;
            if WindowSize < 0 then WindowSize := 0;
          end;

        SGIP12_DELIVER: //mo上行过来的写入缓冲
          begin
            //写入缓冲，或是状态报告
            {if FlocPacketIn.MsgBody.DELIVER. = 1 then
            begin
              //状态报告,写入状态报告缓冲中
              rptbuffer.Add(FlocPacketIn);
              inc(FRptCount);
            end
            else
            begin    }
              //MO,将Mo写入Mo缓冲中
            moSgipbuffer.Add(FlocPacketIn);
            inc(FMoCount);
            //end;

            //应答
            SendPacket(CreateRespPacket(FlocPacketIn));
          end;

        {SGIP12_ACTIVE_TEST:
          begin
            WindowSize := 0;
            SendPacket(CreateRespPacket(FlocPacketIn));
          end;

        SGIP12_ACTIVE_TEST_RESP:
          begin
            WindowSize := 0;
          end;   }
      end;

      FRecBuffer.BufferSize := 0;
      ZeroMemory(@FRecBuffer.Buffer, sizeof(FRecBuffer.Buffer));
    end;
  except
    on e: exception do
    begin
      AddMsgToMemo('SGIP外部网关接收线程:' + e.Message);
      sleep(1000);
      FTCPClient.Disconnect;
    end;
  end;
end;

constructor TOutReadSgipThreadObj.Create(CreateSuspended: boolean);
begin
  inherited;
  ZeroMemory(@FRecBuffer.Buffer, sizeof(FRecBuffer.Buffer));
  FRecBuffer.BufferSize := 0;

  ZeroMemory(@FlocPacketIn, sizeof(TSGIP12_PACKET));
  ZeroMemory(@FnetPacketIn, sizeof(TSGIP12_PACKET));

  FLogined := false;
  FMoCount := 0;
  FMtCount := 0;
  FRptCount := 0;
  FMtRespCount := 0;
  FMtRefuseCount := 0;
  Seqid := 1;
  WindowSize := 0;
  FLastActiveTime := now;
  MtHasUnsendMessage := false;
  MtMessage := '';
  MtNumber := '';
  MtUnsend := 100;
end;

function TOutReadSgipThreadObj.CreatePacket(
  const RequestID: Cardinal): TSGIP12_PACKET;
var
  pac: TSGIP12_PACKET;
  Time: string;
  strTemp: string;
  tempArray: array[0..255] of char;
  tempbArray: array[0..255] of byte;
  md5: TMD5;
  FV_Date1_S, FV_Date2_S: string;
  str_i, SendSize: integer;
  abc, bc: longword;
begin
  ZeroMemory(@pac, sizeof(TSGIP12_PACKET));
  pac.MsgHead.Command_ID := RequestID;

  case RequestID of
    SGIP12_BIND:
      begin
        pac.MsgHead.Message_Length := sizeof(TSGIP12_HEAD) + sizeof(TSGIP12_Bind);
        pac.MsgHead.SNumber1 := GetSeqid;


        DateTimeToString(FV_Date1_S, 'mmddhhnnss', now);
        DateTimeToString(FV_Date2_S, 'zzz', now);
        //FillChar(sBind,sizeof(sBind),0);
        //FillChar(sHead,sizeof(sHead),0);
        str_i := sizeof(TSGIP12_HEAD) + sizeof(TSGIP12_Bind);
        pac.MsgBody.LOGIN.LonginType := 1;
        StrPCopy(pac.MsgBody.LOGIN.LonginPass, GGATECONFIG.sgipClientSecret);
        StrPCopy(pac.MsgBody.LOGIN.LonginName, GGATECONFIG.sgipClientID);
        abc := 3053112345;
        pac.MsgHead.SNumber1 := abc;
        pac.MsgHead.SNumber2 := htonl(strtoint(FV_Date1_S));
        pac.MsgHead.SNumber3 := htonl(strtoint(FV_Date2_S));
      end;

    SGIP12_SUBMIT:
      begin
        //pac.MsgBody.SUBMIT.NeedReport := 1;
        pac.MsgBody.SUBMIT.Priority := 0;
        pac.MsgBody.SUBMIT.UserCount := 1;
      end;

    {SMGP13_ACTIVE_TEST:
      begin
        pac.MsgHead.PacketLength := sizeof(TSGIP12_HEAD);
        pac.MsgHead.SequenceID := GetSeqid;
      end; }
  end;

  result := pac;
end;

function TOutReadSgipThreadObj.CreateRespPacket(
  const recpac: TSGIP12_PACKET): TSGIP12_PACKET;
var
  pac: TSGIP12_PACKET;
begin
  ZeroMemory(@pac, sizeof(TSGIP12_PACKET));

  case recpac.MsgHead.Command_ID of
    SGIP12_DELIVER:
      begin
        pac.MsgHead.Command_ID := SGIP12_DELIVER_RESP;

        pac.MsgHead.Message_Length := sizeof(TSGIP12_HEAD) + sizeof(TSGIP12_DELIVER_RESP);
        pac.MsgHead.SNumber1 := recpac.MsgHead.SNumber1;
        Move(recpac.MsgBody.DELIVER_RESP.result, pac.MsgBody.DELIVER_RESP.result, sizeof(pac.MsgBody.DELIVER_RESP.result));
        pac.MsgBody.DELIVER_RESP.result := 0;
      end;

    {SGIP12_ACTIVE_TEST:
      begin
        pac.MsgHead.PacketLength := sizeof(TSGIP12_HEAD);
        pac.MsgHead.RequestID := SMGP13_ACTIVE_TEST_RESP;
        pac.MsgHead.SequenceID := recpac.MsgHead.SequenceID;
      end; }
  end;

  result := pac;
end;

destructor TOutReadSgipThreadObj.destroy;
begin
  FTCPClient := nil;
  inherited;
end;

procedure TOutReadSgipThreadObj.Execute;
begin
  FreeOnTerminate := True;

  while not Terminated do
  begin
    try
      ClientRead;
      FLastActiveTime := now(); //如果最后活动时间和现在超过2分钟，发送活动测试包
    finally
      sleep(0);
    end;
  end;
end;

function TOutReadSgipThreadObj.GetSeqid: Cardinal;
begin
  result := Seqid;
  inc(Seqid);
  if Seqid >= 4294967295 then
  begin
    Seqid := 1;
  end;
end;

// 实际的发送信息到终端的处理过程
procedure TOutReadSgipThreadObj.PrcMt;
var
  MtSeqId: integer;
begin
  {log_smgp_time := log_smgp_time + 1;
  if log_smgp_time = 5 then
  begin
    FTCPClient.Disconnect;
    OutReadThread.Terminate;
  end;      }
  if FTCPClient.Connected then
  begin
    if FLogined then
    begin
      if now - FLastActiveTime > 30 / 3600 / 24 then
      begin
        if now - FLastActiveTime > 90 / 3600 / 24 then
        begin
          FTCPClient.Disconnect;
        end
        else
        begin
          if now - LastSendActiveTime > 10 / 3600 / 24 then
          begin
            //发送活动测试包
            SendPacket(CreatePacket(SMGP13_ACTIVE_TEST));
            //更新最后发送活动测试包时间
            LastSendActiveTime := now();
          end;
        end;
      end
      else
      begin
        // 发送消息(1)
        MtSeqId := mtbuffer.Get;
        if MtSeqId > 0 then
        begin
          SendMt(MtSeqId);
        end;

      end;
    end
    else
    begin
      if now - LastLoginTime > 6 / 3600 / 24 then
      begin
        SendPacket(CreatePacket(SMGP13_LOGIN));
        LastLoginTime := now;
      end;
    end;
  end;
end;

// 对外发送函数
procedure TOutReadSgipThreadObj.SendMt(i: integer);
var
  Buffer: TMtBuffer;
  outpac: TSGIP12_PACKET;
begin
  { Buffer := mtbuffer.Read(i);
   outpac := CreatePacket(SMGP13_SUBMIT);
   outpac.MsgHead.SequenceID := i;
   outpac.MsgBody.SUBMIT.MsgType := Buffer.OutMsgType;
   Move(Buffer.OutServiceID, outpac.MsgBody.SUBMIT.ServiceID, sizeof(Buffer.OutServiceID));
   Move(Buffer.OutFeeType, outpac.MsgBody.SUBMIT.FeeType, sizeof(Buffer.OutFeeType));
   Move(Buffer.OutFixedFee, outpac.MsgBody.SUBMIT.FixedFee, sizeof(Buffer.OutFixedFee));
   Move(Buffer.OutFeeCode, outpac.MsgBody.SUBMIT.FeeCode, sizeof(Buffer.OutFeeCode));
   outpac.MsgBody.SUBMIT.MsgFormat := Buffer.Mt.MtMsgFmt;
   Move(Buffer.Mt.MtValidTime, outpac.MsgBody.SUBMIT.ValidTime, sizeof(Buffer.Mt.MtValidTime));
   Move(Buffer.Mt.MtAtTime, outpac.MsgBody.SUBMIT.AtTime, sizeof(Buffer.Mt.MtAtTime));
   Move(Buffer.Mt.MtSpAddr, outpac.MsgBody.SUBMIT.SrcTermID, sizeof(TSMGP13PhoneNum));
   Move(Buffer.Mt.MtFeeAddr, outpac.MsgBody.SUBMIT.ChargeTermID, sizeof(TSMGP13PhoneNum));
   Move(Buffer.Mt.MtUserAddr, outpac.MsgBody.SUBMIT.DestTermID, sizeof(TSMGP13PhoneNum));
   outpac.MsgBody.SUBMIT.MsgLength := Buffer.Mt.MtMsgLenth;
   Move(Buffer.Mt.MtMsgContent, outpac.MsgBody.SUBMIT.MsgContent, Buffer.Mt.MtMsgLenth);
   outpac.MsgHead.PacketLength := sizeof(TSGIP12_HEAD) + sizeof(TSGIP12_SUBMIT) - sizeof(outpac.MsgBody.SUBMIT.MsgContent) + Buffer.Mt.MtMsgLenth;
   SendPacket(outpac);  }
end;

procedure TOutReadSgipThreadObj.SendPacket(pac: TSGIP12_PACKET);
var
  sendbuffer: TCOMMBuffer;
  NetPacOut, LocPacOut: TSGIP12_PACKET;
begin
  //初始化变量
  ZeroMemory(@sendbuffer, sizeof(TCOMMBuffer));
  sendbuffer.BufferSize := 0;
  NetPacOut := pac;
  LocPacOut := pac;

  //包头部分，进行网络字节序转换
  //htonl（将32位主机字符顺序转换成网络字符顺序）.
  NetPacOut.MsgHead.Message_Length := htonl(LocPacOut.MsgHead.Message_Length);
  NetPacOut.MsgHead.Command_ID := htonl(LocPacOut.MsgHead.Command_ID);
  NetPacOut.MsgHead.SNumber1 := htonl(LocPacOut.MsgHead.SNumber1);

  //将包头复制到发送缓冲中
  //move函数的作用是将输入数组中的元素从后面开始，两两交换，循环次数用n控制
  Move(NetPacOut.MsgHead, sendbuffer.Buffer, sizeof(TSGIP12_HEAD));
  sendbuffer.BufferSize := sizeof(TSGIP12_HEAD);

  case pac.MsgHead.Command_ID of
    SGIP12_BIND:
      begin
        Move(NetPacOut.MsgBody.LOGIN, sendbuffer.Buffer[sendbuffer.BufferSize], sizeof(TSGIP12_Bind));
        sendbuffer.BufferSize := sendbuffer.BufferSize + sizeof(TSGIP12_Bind);
      end;

    SGIP12_SUBMIT:
      begin
        { Move(NetPacOut.MsgBody.SUBMIT, sendbuffer.Buffer[sendbuffer.BufferSize], 127);
         sendbuffer.BufferSize := sendbuffer.BufferSize + 127;

         Move(NetPacOut.MsgBody.SUBMIT.MsgContent, sendbuffer.Buffer[sendbuffer.BufferSize], NetPacOut.MsgBody.SUBMIT.MsgLength);
         sendbuffer.BufferSize := sendbuffer.BufferSize + NetPacOut.MsgBody.SUBMIT.MsgLength;

         Move(NetPacOut.MsgBody.SUBMIT.Reserve, sendbuffer.Buffer[sendbuffer.BufferSize], sizeof(NetPacOut.MsgBody.SUBMIT.Reserve));
         sendbuffer.BufferSize := sendbuffer.BufferSize + sizeof(NetPacOut.MsgBody.SUBMIT.Reserve);  }
      end;

    SGIP12_DELIVER_RESP:
      begin
        { NetPacOut.MsgBody.DELIVER_RESP.Status := htonl(LocPacOut.MsgBody.DELIVER_RESP.Status);

         Move(NetPacOut.MsgBody.DELIVER_RESP, sendbuffer.Buffer[sendbuffer.BufferSize], sizeof(TSGIP12_DELIVER_RESP));
         sendbuffer.BufferSize := sendbuffer.BufferSize + sizeof(TSGIP12_DELIVER_RESP); }
      end;

    {SGIP12_ACTIVE_TEST:
      begin

      end;

    SGIP12_ACTIVE_TEST_RESP:
      begin

      end;   }
  end;

  if sendbuffer.BufferSize = LocPacOut.MsgHead.Message_Length then
  begin
    if LocPacOut.MsgHead.Command_ID = SGIP12_SUBMIT then
    begin
      inc(WindowSize);
      mtbuffer.Update(LocPacOut.MsgHead.SNumber1);
      inc(FMtCount);
    end;

    if MainForm.OutMonitor.Checked then
    begin
      MonitorThread.OutMonitorSgipBuffer.Add(LocPacOut);
    end;

    try
      FTCPClient.WriteBuffer(sendbuffer.Buffer, sendbuffer.BufferSize);
    except
      on e: exception do
      begin
        AddMsgToMemo('SGIP外部网关发送线程' + e.Message);
        FTCPClient.Disconnect;
      end;
    end;
  end;
end;

procedure TOutReadSgipThreadObj.ThAddMsgToMemo;
begin
  if MainForm <> nil then
  begin
    MainForm.ShowToMemo(ErrMsg, MainForm.MonitorMemo);
  end;
end;
//SGIP 监控线程结束
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


procedure TMainForm.FormCreate(Sender: TObject);
var
  ZAppName: array[0..127] of char;
  Hold: string;
  Found: HWND;
begin
  ReadConfig;
  Application.Title := inttostr(GSMSCENTERCONFIG.GateId);
  ChDir(Extractfilepath(Application.exename));
  Hold := Application.Title;
  Application.Title := 'Cnrenwy' + inttostr(HInstance); // 暂时修改窗口标题
  StrPCopy(ZAppName, Hold); // 原窗口标题
  Found := FindWindow(nil, ZAppName); // 查找窗口
  Application.Title := Hold; // 恢复窗口标题
  MainForm.Caption := '短信网关：' + Hold;
  if Found <> 0 then
  begin
    // 若找到则激活已运行的程序并结束自身
    ShowWindow(Found, SW_SHOWDEFAULT);
    SetForegroundWindow(Found);
    Application.Terminate;
  end
  else
  begin
    //创建errlog
    if not DirectoryExists(Extractfilepath(Application.exename) + '\errlog') then
    begin
      CreateDir('errlog');
    end;
    //CoInitialize(nil);

    //连接数据库
    ConnectDB(AdoConnection);
    //载入业务代码转换数据
    LoadServiceCode;
    //载入协议表
    LoadProtocol;
    //初始化缓冲
    mobuffer := TMoBufferObj.Create;
    mocmppbuffer := TMocmppBufferObj.Create;
    moSgipbuffer := TMoSgipBufferObj.Create;
    mtbuffer := TMtBufferObj.Create;
    mtcmppbuffer := TMtcmppBufferObj.Create;
    mtSgipbuffer := TMtSgipBufferObj.Create;
    rptbuffer := TRptLogBufferObj.Create;
    rptcmppbuffer := TRptLogcmppBufferObj.Create;
    rptSgipbuffer := TRptLogSgipBufferObj.Create;

    //数据包监控线程
    MonitorThread := TMonitorThreadObj.Create(True);
    MonitorThread.OutListview := OutListview;
    MonitorThread.Resume;

    //MO,Mt,状态报告消息日志线程
    LogThread := TLogThreadObj.Create(false);
    //MT消息预处理线程
    MtPrePrcThread := TMtPrePrcThreadObj.Create(false);
    //MT群发线程
    MtQfThread := TMtQfThread.Create(false);

    Timer1.Enabled := True;
  end;
end;

//从配置文件中读取配置
function TMainForm.ReadConfig: boolean;
var
  iniFile: Tinifile;
  iniPath: string;
begin
  result := false;
  iniPath := Extractfilepath(Application.exename) + 'Config.ini';
  if FileExists(iniPath) then
  begin
    try
      iniFile := Tinifile.Create(iniPath);
      try
        //SMGP
        GGATECONFIG.RemoteIp := iniFile.ReadString('SMGPGATEWAY', 'SMGPADDRESS', '127.0.0.1');
        GGATECONFIG.RemotePort := iniFile.ReadInteger('SMGPGATEWAY', 'SMGPPORT', 18906);
        GGATECONFIG.ClientID := iniFile.ReadString('SMGPGATEWAY', 'SMGPCLIENTID', '');
        GGATECONFIG.ClientSecret := iniFile.ReadString('SMGPGATEWAY', 'SMGPPASSWORD', '');
        GGATECONFIG.Smgp_Tag := iniFile.ReadInteger('SMGPGATEWAY', 'Smgp_Tag', 0);

        GGATECONFIG.SPNUM := iniFile.ReadString('GATEWAY', 'SPNUM', '1291');
        GGATECONFIG.Flux := iniFile.ReadInteger('GATEWAY', 'FLUX', 5);
        GGATECONFIG.MCSTART := iniFile.ReadInteger('GATEWAY', 'MCSTART', 1);
        GGATECONFIG.MCEND := iniFile.ReadInteger('GATEWAY', 'MCEND', 21);

        //CMPP
        GGATECONFIG.cmppRemoteIp := iniFile.ReadString('CMPPGATEWAY', 'CMPPADDRESS', '127.0.0.1');
        GGATECONFIG.cmppRemotePort := iniFile.ReadInteger('CMPPGATEWAY', 'CMPPPORT', 18906);
        GGATECONFIG.cmppRemotePort0 := iniFile.ReadInteger('CMPPGATEWAY', 'CMPPPORT0', 18906);
        GGATECONFIG.cmppClientID := iniFile.ReadString('CMPPGATEWAY', 'CMPPCLIENTID', '');
        GGATECONFIG.cmppClientSecret := iniFile.ReadString('CMPPGATEWAY', 'CMPPPASSWORD', '');
        GGATECONFIG.Cmpp_Tag := iniFile.ReadInteger('SMGPGATEWAY', 'Cmpp_Tag', 0);

        GGATECONFIG.SPNUM := iniFile.ReadString('GATEWAY', 'SPNUM', '1291');
        GGATECONFIG.Flux := iniFile.ReadInteger('GATEWAY', 'FLUX', 5);
        GGATECONFIG.MCSTART := iniFile.ReadInteger('GATEWAY', 'MCSTART', 1);
        GGATECONFIG.MCEND := iniFile.ReadInteger('GATEWAY', 'MCEND', 21);

        //Sgip
        GGATECONFIG.SgipRemoteIp := iniFile.ReadString('SgipGATEWAY', 'SgipADDRESS', '127.0.0.1');
        GGATECONFIG.SgipRemotePort := iniFile.ReadInteger('SgipGATEWAY', 'SgipPORT', 18906);
        GGATECONFIG.sgipClientID := iniFile.ReadString('SgipGATEWAY', 'SgipCLIENTID', '');
        GGATECONFIG.sgipClientSecret := iniFile.ReadString('SgipGATEWAY', 'SgipPASSWORD', '');
        GGATECONFIG.Sgip_Tag := iniFile.ReadInteger('SMGPGATEWAY', 'Sgip_Tag', 0);

        GGATECONFIG.SPNUM := iniFile.ReadString('GATEWAY', 'SPNUM', '1291');
        GGATECONFIG.Flux := iniFile.ReadInteger('GATEWAY', 'FLUX', 5);
        GGATECONFIG.MCSTART := iniFile.ReadInteger('GATEWAY', 'MCSTART', 1);
        GGATECONFIG.MCEND := iniFile.ReadInteger('GATEWAY', 'MCEND', 21);

        //SMSCENTER
        GSMSCENTERCONFIG.GateId := iniFile.ReadInteger('SMSCENTER', 'GateId', 0);
        GSMSCENTERCONFIG.Gatename := iniFile.ReadString('SMSCENTER', 'Gatename', '1182333');
        GSMSCENTERCONFIG.GateDesc := iniFile.ReadString('SMSCENTER', 'GateDesc', '0');
        GSMSCENTERCONFIG.Flux := iniFile.ReadInteger('SMSCENTER', 'FLUX', 20);

        //GDBCONFIG
        GDBCONFIG.Address := iniFile.ReadString('DBCONFIG', 'ADDRESS', '127.0.0.1');
        GDBCONFIG.User := iniFile.ReadString('DBCONFIG', 'USER', 'sa');
        GDBCONFIG.Pass := iniFile.ReadString('DBCONFIG', 'PASS', '');
        GDBCONFIG.TnsName := iniFile.ReadString('DBCONFIG', 'TNSNAME', '1291log');
      finally
        iniFile.Free;
      end;
    except
      result := false;
    end;
  end;
end;

procedure TMainForm.ConnectDB(AdoConnection: TADOConnection);
begin
  if {false}  AdoConnection.Connected = false then
  begin
    AdoConnection.ConnectionString := 'Provider=SQLOLEDB.1;Password='
      + GDBCONFIG.Pass
      + ';Persist Security Info=True;Application Name='
      + GSMSCENTERCONFIG.GateDesc
      + ';User ID='
      + GDBCONFIG.User
      + ';Initial Catalog='
      + GDBCONFIG.TnsName
      + ';Data Source='
      + GDBCONFIG.Address;
    try
      // ADOConnection.Open();
      ShowToMemo('数据库连接成功', MonitorMemo);
    except
      on e: exception do
      begin
        ShowToMemo('数据库连接失败', MonitorMemo);
        ShowToMemo(e.Message, MonitorMemo);
      end;
    end;
  end;
end;

procedure TMainForm.LoadServiceCode;
var
  strSql: string;
  i: integer;
begin
  if AdoConnection.Connected then
  begin
    strSql := 'select LogicId, LogicCode, ServiceId from ServiceCodeConvertView where GateId = ' + inttostr(GSMSCENTERCONFIG.GateId);
    AdoQuery.Close;
    AdoQuery.SQL.Text := strSql;
    AdoQuery.Open;
    if high(ServiceCode) = -1 then
    begin
      setlength(ServiceCode, AdoQuery.RecordCount);
    end
    else
    begin
      ServiceCode := nil;
      setlength(ServiceCode, AdoQuery.RecordCount);
    end;
    i := 0;
    while not AdoQuery.Eof do
    begin
      ServiceCode[i].LogicId := AdoQuery.fieldbyname('LogicId').AsInteger;
      //内部业务代码全为大写
      SetPchar(ServiceCode[i].LogicCode, UpperCase(AdoQuery.fieldbyname('LogicCode').AsString), sizeof(ServiceCode[i].LogicCode));
      SetPchar(ServiceCode[i].GateCode, AdoQuery.fieldbyname('ServiceId').AsString, sizeof(ServiceCode[i].GateCode));
      inc(i);
      AdoQuery.MoveBy(1);
    end;
    AdoQuery.Close;
  end;
end;



procedure TMainForm.SMGPTCPClientDisconnected(Sender: TObject);
begin
  try
    ShowToMemo('外部网关SMGP连接已断开', MonitorMemo);

    if MtSendThread <> nil then
    begin
      MtSendThread.Terminate;
      MtSendThread := nil;
    end;

    if OutReadThread <> nil then
    begin
      OutReadThread.Terminate;
      OutReadThread := nil;
    end;
  except
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MonitorTimer.Enabled := false;
  Timer1.Enabled := false;
  try
    //CoUninitialize();
    SMGPTCPClient.CheckForGracefulDisconnect(false);
    if SMGPTCPClient.Connected then
    begin
      SMGPTCPClient.Disconnect;
    end;
  except
    on e: exception do
    begin
      ShowToMemo('1:' + e.Message, MonitorMemo);
    end;
  end;

  try
    //CoUninitialize();
    CmppTCPClient.CheckForGracefulDisconnect(false);
    if CmppTCPClient.Connected then
    begin
      CmppTCPClient.Disconnect;
    end;
  except
    on e: exception do
    begin
      ShowToMemo('1:' + e.Message, MonitorMemo);
    end;
  end;

  try
    Cmpp0TCPClient.CheckForGracefulDisconnect(false);
    if Cmpp0TCPClient.Connected then
    begin
      Cmpp0TCPClient.Disconnect;
    end;
  except
    on e: exception do
    begin
      ShowToMemo('1:' + e.Message, MonitorMemo);
    end;
  end;

  try
    if MtSendThread <> nil then
    begin
      MtSendThread.Terminate;
      MtSendThread := nil;
    end;
  except
    on e: exception do
    begin
      ShowToMemo('2' + e.Message, MonitorMemo);
    end;
  end;

  try
    if OutReadThread <> nil then
    begin
      OutReadThread.Terminate;
      OutReadThread := nil;
    end;
  except
    on e: exception do
    begin
      ShowToMemo('3:' + e.Message, MonitorMemo);
    end;
  end;

  try
    SgipTCPClient.CheckForGracefulDisconnect(false);
    if SgipTCPClient.Connected then
    begin
      SgipTCPClient.Disconnect;
    end;
  except
    on e: exception do
    begin
      ShowToMemo('4:' + e.Message, MonitorMemo);
    end;
  end;

  try
    MtQfThread.Terminate;
    MtQfThread := nil;
  except
    on e: exception do
    begin
      ShowToMemo('7:' + e.Message, MonitorMemo);
    end;
  end;

  try
    MtPrePrcThread.Terminate;
    MtPrePrcThread := nil;
  except
    on e: exception do
    begin
      ShowToMemo('8:' + e.Message, MonitorMemo);
    end;
  end;

  try
    LogThread.Terminate;
    LogThread := nil;
  except
    on e: exception do
    begin
      ShowToMemo('9:' + e.Message, MonitorMemo);
    end;
  end;

  try
    MonitorThread.Terminate;
    MonitorThread := nil;
  except
    on e: exception do
    begin
      ShowToMemo('10:' + e.Message, MonitorMemo);
    end;
  end;

  mobuffer.Free;
  mobuffer := nil;
  mtbuffer.Free;
  mtbuffer := nil;
  mtcmppbuffer.Free;
  mtcmppbuffer := nil;
  mtSgipbuffer.Free;
  mtSgipbuffer := nil;
  rptbuffer.Free;
  rptbuffer := nil;

  ServiceCode := nil;

  MonitorMemo.Lines.SaveToFile('ErrLog\' + FormatDatetime('yyyymmddhhnnss', now()) + '.log');
  MonitorMemo.Clear;
end;

{ TLogThreadObj }
procedure TLogThreadObj.AddMsgToMemo(const Msg: string);
begin
  ErrMsg := Msg;
  Synchronize(ThAddMsgToMemo);
end;

procedure TLogThreadObj.ConnectDB;
begin
  if false {ADOConnection.Connected = false} then
  begin
    AdoConnection.ConnectionString := 'Provider=SQLOLEDB.1;Password='
      + GDBCONFIG.Pass
      + ';Persist Security Info=True;Application Name='
      + GSMSCENTERCONFIG.GateDesc
      + ';User ID='
      + GDBCONFIG.User
      + ';Initial Catalog='
      + GDBCONFIG.TnsName
      + ';Data Source='
      + GDBCONFIG.Address;
    try
      AdoConnection.Open();
    except
      on e: exception do
      begin
        AddMsgToMemo('日志线程数据库连接失败');
        AddMsgToMemo(e.Message);
      end;
    end;
  end;
end;

constructor TLogThreadObj.Create(CreateSuspended: boolean);
begin
  inherited;
  LastActiveTime := now;
  AdoConnection := TADOConnection.Create(nil);
  AdoQuery := TAdoQuery.Create(nil);
  AdoQuery.Connection := AdoConnection;
end;

procedure TLogThreadObj.CreateRpt(Buffer: TMtBuffer);
var
  rptbuff: TRptBuffer;
  Rpt: TSMGP13RPT;
begin
  ZeroMemory(@rptbuff, sizeof(TRptBuffer));
  ZeroMemory(@Rpt, sizeof(TSMGP13RPT));

  rptbuff.MtLogicId := Buffer.Mt.MtLogicId;
  rptbuff.MtInMsgId := Buffer.Mt.MtInMsgId;
  rptbuff.MtSpAddr := Buffer.Mt.MtSpAddr;
  rptbuff.MtUserAddr := Buffer.Mt.MtUserAddr;

  if Buffer.PrePrcResult <> 0 then
  begin
    Rpt.stat := 'PRECERR';
    Rpt.Err := '001';
  end
  else
  begin
    Rpt.stat := 'RESPERR';
    SetPchar(Rpt.Err, SMGP13_StatusToStr(Buffer.Status), sizeof(Rpt.Err));
  end;
  rptbuff.Rpt.MsgLength := sizeof(Rpt);
  Move(Rpt, rptbuff.Rpt.MsgContent, sizeof(Rpt));
  rptbuffer.SendBuffers.Add(rptbuff);
end;

destructor TLogThreadObj.destroy;
begin
  AdoQuery.Free;
  AdoConnection.Free;
  LastActiveTime := 0;
  inherited;
end;

procedure TLogThreadObj.Execute;
begin
  //CoInitialize(nil);
  FreeOnTerminate := True;
  while not Terminated do
  begin
    try
      try
        if AdoConnection.Connected then
        begin
          LogMt;
          LogMo;
          LogRpt;
        end
        else
        begin
          ConnectDB;
          sleep(3000);
        end;
      except
        on e: exception do
        begin
          AddMsgToMemo('日志线程:' + e.Message);

          if e.Message = '连接失败' then
          begin
            AdoConnection.Close;
          end;
        end;
      end;
    finally
      LastActiveTime := now;
      sleep(10);
    end;
  end;
  //CoUninitialize;
end;

procedure TLogThreadObj.LogMo;
var
  logseqid: integer;
  strSql: string;
  Buffer: TMoBuffer;
begin
  //logseqid := mobuffer.LogBuffers.Get;
  logseqid := mobuffer.Get;
  if logseqid > 0 then
  begin
    //buffer := mobuffer.LogBuffers.Read(logseqid);
    Buffer := mobuffer.Read(logseqid);
    ConvertNull(Buffer.mo.MsgContent, Buffer.mo.MsgLength, Buffer.mo.MsgContent);
    strSql := 'insert into OutMo (MoOutMsgId, MoInMsgId, MoSpAddr, MoUserAddr, MoMsgFmt, MoMsgLenth, MoMsgContent, MoReserve, OutRecTime, G2CED, SPPOrcTimes, G2CLastPrcTime, MoGateId) values (';
    strSql := strSql + Quotedstr(Chartohex(Buffer.mo.MsgID)) + ',';
    strSql := strSql + Quotedstr(Chartohex(Buffer.MoInMsgId)) + ',';
    strSql := strSql + Quotedstr(Buffer.mo.DestTermID) + ',';
    strSql := strSql + Quotedstr(Buffer.mo.SrcTermID) + ',';
    strSql := strSql + inttostr(Buffer.mo.MsgFormat) + ',';
    strSql := strSql + inttostr(Buffer.mo.MsgLength) + ',';
    strSql := strSql + Quotedstr(Buffer.mo.MsgContent) + ',';
    strSql := strSql + '''''' + ',';
    strSql := strSql + Quotedstr(FormatDatetime('yyyy-mm-dd hh:nn:ss:zzz', Buffer.RecTime)) + ',';
    strSql := strSql + inttostr(Buffer.Prced) + ',';
    strSql := strSql + inttostr(Buffer.PrcTimes) + ',';
    strSql := strSql + Quotedstr(FormatDatetime('yyyy-mm-dd hh:nn:ss:zzz', Buffer.LastPrcTime)) + ',';
    strSql := strSql + inttostr(GSMSCENTERCONFIG.GateId);
    strSql := strSql + ')';
  end;
end;

procedure TLogThreadObj.LogMt;
var
  logseqid: integer;
  strSql: string;
  Buffer: TMtBuffer;
  qfSql: string;
  hdSql: string;
begin
  logseqid := mtbuffer.LogBuffers.Get;
  if logseqid > 0 then
  begin
    Buffer := mtbuffer.LogBuffers.Read(logseqid);
    ConvertNull(Buffer.Mt.MtMsgContent, Buffer.Mt.MtMsgLenth, Buffer.Mt.MtMsgContent);
    if Buffer.Status = 0 then
    begin
      if Buffer.Mt.MtLogicId = 2 then
      begin
        //广东电信发送话单有成功应答就算是成功的
        strSql := 'insert into OUTMTLOG (L2CMtMsgType, MoOutMsgId, MoInMsgId, MtGateId, MoLinkId, MtSpAddr, MtUserAddr, MtFeeAddr, L2CMtServiceId, MtTpPid, MtTpUdhi, MtMsgFmt, MtValidTime, MtAtTime, MtMsgLenth, MtMsgContent, MtReserve, MtInMsgId, MtLogicId, PrePrcResult, ';
        strSql := strSql + 'OutMsgType, OutServiceID, OutFeeType, OutFixedFee, OutFeeCode, RealFeeCode, C2GRecTime, OUTStatus, OutMtMsgid, OutPrced, OutPrcTimes, OutLastprctime, OutRptSubDate, OutRptDonDate, OutRptStat, OutRptErr, OutRptRecTime) values (';
        strSql := strSql + inttostr(Buffer.Mt.MtMsgType) + ',';
        strSql := strSql + Quotedstr(Chartohex(Buffer.Mt.MoOutMsgId)) + ',';
        strSql := strSql + Quotedstr(Chartohex(Buffer.Mt.MoInMsgId)) + ',';
        strSql := strSql + inttostr(GSMSCENTERCONFIG.GateId) + ',';
        strSql := strSql + Quotedstr(Buffer.Mt.MoLinkId) + ',';
        strSql := strSql + Quotedstr(Buffer.Mt.MtSpAddr) + ',';
        strSql := strSql + Quotedstr(Buffer.Mt.MtUserAddr) + ',';
        strSql := strSql + Quotedstr(Buffer.Mt.MtFeeAddr) + ',';
        strSql := strSql + Quotedstr(Buffer.Mt.MtServiceId) + ',';
        strSql := strSql + inttostr(Buffer.Mt.MtTpPid) + ',';
        strSql := strSql + inttostr(Buffer.Mt.MtTpUdhi) + ',';
        strSql := strSql + inttostr(Buffer.Mt.MtMsgFmt) + ',';
        strSql := strSql + Quotedstr(Buffer.Mt.MtValidTime) + ',';
        strSql := strSql + Quotedstr(Buffer.Mt.MtAtTime) + ',';
        strSql := strSql + inttostr(Buffer.Mt.MtMsgLenth) + ',';
        strSql := strSql + Quotedstr(Buffer.Mt.MtMsgContent) + ',';
        strSql := strSql + Quotedstr(Buffer.Mt.MtReserve) + ',';
        strSql := strSql + Quotedstr(Chartohex(Buffer.Mt.MtInMsgId)) + ',';
        strSql := strSql + inttostr(Buffer.Mt.MtLogicId) + ',';
        strSql := strSql + inttostr(Buffer.PrePrcResult) + ','; //PrePrcResult
        strSql := strSql + inttostr(Buffer.OutMsgType) + ','; //OutMsgType
        strSql := strSql + Quotedstr(Buffer.OutServiceID) + ','; //OutServiceID
        strSql := strSql + Quotedstr(Buffer.OutFeeType) + ','; //OutFeeType
        strSql := strSql + Quotedstr(Buffer.OutFixedFee) + ','; //OutFixedFee
        strSql := strSql + Quotedstr(Buffer.OutFeeCode) + ','; //OutFeeCode
        strSql := strSql + inttostr(Buffer.RealFeeCode) + ','; //RealFeeCode
        strSql := strSql + Quotedstr(FormatDatetime('yyyy-mm-dd hh:nn:ss:zzz', Buffer.RecTime)) + ','; //C2GRecTime
        strSql := strSql + inttostr(Buffer.Status) + ','; //OUTStatus
        strSql := strSql + Quotedstr(Chartohex(Buffer.OutMtMsgid)) + ','; //OutMtMsgid
        strSql := strSql + inttostr(Buffer.Prced) + ','; //OutPrced
        strSql := strSql + inttostr(Buffer.PrcTimes) + ','; //OutPrcTimes
        strSql := strSql + Quotedstr(FormatDatetime('yyyy-mm-dd hh:nn:ss:zzz', Buffer.LastPrcTime)) + ','; //OutLastprctime
        strSql := strSql + '''''' + ','; //OutRptSubDate
        strSql := strSql + '''''' + ','; //OutRptDonDate
        strSql := strSql + Quotedstr('DELIVRD') + ','; //OutRptStat
        strSql := strSql + Quotedstr('000') + ','; //OutRptErr
        strSql := strSql + Quotedstr(FormatDatetime('yyyy-mm-dd hh:nn:ss:zzz', Buffer.LastPrcTime)); //OutRptRecTime
        strSql := strSql + ')';
        hdSql := 'update MCSEND set Status = 1 where MtInMsgId = ' + Quotedstr(Chartohex(Buffer.Mt.MtInMsgId)) + ' and gateid = ' + inttostr(GSMSCENTERCONFIG.GateId);
      end
      else
      begin
        //应答正常
        strSql := 'insert into OUTMT (L2CMtMsgType, MoOutMsgId, MoInMsgId, MtGateId, MoLinkId, MtSpAddr, MtUserAddr, MtFeeAddr, L2CMtServiceId, MtMsgFmt, MtValidTime, MtAtTime, MtMsgLenth, MtMsgContent, MtReserve, MtInMsgId, MtLogicId, ';
        strSql := strSql + 'PrePrcResult, OutMsgType, OutServiceID, OutFeeType, OutFixedFee, OutFeeCode, RealFeeCode, C2GRecTime, OUTStatus, OutMtMsgid, OutPrced, OutPrcTimes, OutLastprctime) values (';
        strSql := strSql + inttostr(Buffer.Mt.MtMsgType) + ',';
        strSql := strSql + Quotedstr(Chartohex(Buffer.Mt.MoOutMsgId)) + ',';
        strSql := strSql + Quotedstr(Chartohex(Buffer.Mt.MoInMsgId)) + ',';
        strSql := strSql + inttostr(GSMSCENTERCONFIG.GateId) + ',';
        strSql := strSql + Quotedstr(Buffer.Mt.MoLinkId) + ',';
        strSql := strSql + Quotedstr(Buffer.Mt.MtSpAddr) + ',';
        strSql := strSql + Quotedstr(Buffer.Mt.MtUserAddr) + ',';
        strSql := strSql + Quotedstr(Buffer.Mt.MtFeeAddr) + ',';
        strSql := strSql + Quotedstr(Buffer.Mt.MtServiceId) + ',';
        strSql := strSql + inttostr(Buffer.Mt.MtMsgFmt) + ',';
        strSql := strSql + Quotedstr(Buffer.Mt.MtValidTime) + ',';
        strSql := strSql + Quotedstr(Buffer.Mt.MtAtTime) + ',';
        strSql := strSql + inttostr(Buffer.Mt.MtMsgLenth) + ',';
        strSql := strSql + Quotedstr(Buffer.Mt.MtMsgContent) + ',';
        strSql := strSql + Quotedstr(Buffer.Mt.MtReserve) + ',';
        strSql := strSql + Quotedstr(Chartohex(Buffer.Mt.MtInMsgId)) + ',';
        strSql := strSql + inttostr(Buffer.Mt.MtLogicId) + ',';
        strSql := strSql + inttostr(Buffer.PrePrcResult) + ',';
        strSql := strSql + inttostr(Buffer.OutMsgType) + ',';
        strSql := strSql + Quotedstr(Buffer.OutServiceID) + ',';
        strSql := strSql + Quotedstr(Buffer.OutFeeType) + ',';
        strSql := strSql + Quotedstr(Buffer.OutFixedFee) + ',';
        strSql := strSql + Quotedstr(Buffer.OutFeeCode) + ',';
        strSql := strSql + inttostr(Buffer.RealFeeCode) + ',';
        strSql := strSql + Quotedstr(FormatDatetime('yyyy-mm-dd hh:nn:ss:zzz', Buffer.RecTime)) + ',';
        strSql := strSql + inttostr(Buffer.Status) + ',';
        strSql := strSql + Quotedstr(Chartohex(Buffer.OutMtMsgid)) + ',';
        strSql := strSql + inttostr(Buffer.Prced) + ',';
        strSql := strSql + inttostr(Buffer.PrcTimes) + ',';
        strSql := strSql + Quotedstr(FormatDatetime('yyyy-mm-dd hh:nn:ss:zzz', Buffer.LastPrcTime));
        strSql := strSql + ')';
      end;
    end
    else
    begin
      //应答失败或预处理错误
      strSql := 'insert into OUTERRMTLOG (L2CMtMsgType, MoOutMsgId, MoInMsgId, MtGateId, MoLinkId, MtSpAddr, MtUserAddr, MtFeeAddr, L2CMtServiceId, MtMsgFmt, MtValidTime, MtAtTime, MtMsgLenth, MtMsgContent, MtReserve, MtInMsgId, MtLogicId, ';
      strSql := strSql + 'PrePrcResult, OutMsgType, OutServiceID, OutFeeType, OutFixedFee, OutFeeCode, RealFeeCode, C2GRecTime, OUTStatus, OutMtMsgid, OutPrced, OutPrcTimes, OutLastprctime) values (';
      strSql := strSql + inttostr(Buffer.Mt.MtMsgType) + ',';
      strSql := strSql + Quotedstr(Chartohex(Buffer.Mt.MoOutMsgId)) + ',';
      strSql := strSql + Quotedstr(Chartohex(Buffer.Mt.MoInMsgId)) + ',';
      strSql := strSql + inttostr(GSMSCENTERCONFIG.GateId) + ',';
      strSql := strSql + Quotedstr(Buffer.Mt.MoLinkId) + ',';
      strSql := strSql + Quotedstr(Buffer.Mt.MtSpAddr) + ',';
      strSql := strSql + Quotedstr(Buffer.Mt.MtUserAddr) + ',';
      strSql := strSql + Quotedstr(Buffer.Mt.MtFeeAddr) + ',';
      strSql := strSql + Quotedstr(Buffer.Mt.MtServiceId) + ',';
      strSql := strSql + inttostr(Buffer.Mt.MtMsgFmt) + ',';
      strSql := strSql + Quotedstr(Buffer.Mt.MtValidTime) + ',';
      strSql := strSql + Quotedstr(Buffer.Mt.MtAtTime) + ',';
      strSql := strSql + inttostr(Buffer.Mt.MtMsgLenth) + ',';
      strSql := strSql + Quotedstr(Buffer.Mt.MtMsgContent) + ',';
      strSql := strSql + Quotedstr(Buffer.Mt.MtReserve) + ',';
      strSql := strSql + Quotedstr(Chartohex(Buffer.Mt.MtInMsgId)) + ',';
      strSql := strSql + inttostr(Buffer.Mt.MtLogicId) + ',';
      strSql := strSql + inttostr(Buffer.PrePrcResult) + ',';
      strSql := strSql + inttostr(Buffer.OutMsgType) + ',';
      strSql := strSql + Quotedstr(Buffer.OutServiceID) + ',';
      strSql := strSql + Quotedstr(Buffer.OutFeeType) + ',';
      strSql := strSql + Quotedstr(Buffer.OutFixedFee) + ',';
      strSql := strSql + Quotedstr(Buffer.OutFeeCode) + ',';
      strSql := strSql + inttostr(Buffer.RealFeeCode) + ',';
      strSql := strSql + Quotedstr(FormatDatetime('yyyy-mm-dd hh:nn:ss:zzz', Buffer.RecTime)) + ',';
      strSql := strSql + inttostr(Buffer.Status) + ',';
      strSql := strSql + Quotedstr(Chartohex(Buffer.OutMtMsgid)) + ',';
      strSql := strSql + inttostr(Buffer.Prced) + ',';
      strSql := strSql + inttostr(Buffer.PrcTimes) + ',';
      strSql := strSql + Quotedstr(FormatDatetime('yyyy-mm-dd hh:nn:ss:zzz', Buffer.LastPrcTime));
      strSql := strSql + ')';
      if Buffer.Mt.MtLogicId = 1 then
      begin
        //群发
        qfSql := 'update MTSEND set Status = 2 where MtInMsgId = ' + Quotedstr(Chartohex(Buffer.Mt.MtInMsgId)) + ' and gateid = ' + inttostr(GSMSCENTERCONFIG.GateId);
      end
      else if Buffer.Mt.MtLogicId = 2 then
      begin
        //话单
      end
      else if Buffer.Mt.MtLogicId = 3 then
      begin
        //系统信息
      end
      else
      begin
        //其他业务，需要生成错误状态报告
        CreateRpt(Buffer);
      end;
    end;

    try
      AdoConnection.Execute(strSql);
      mtbuffer.LogBuffers.Delete(logseqid);

      if qfSql <> '' then
      begin
        AdoConnection.Execute(qfSql);
      end;

      if hdSql <> '' then
      begin
        AdoConnection.Execute(hdSql);
      end;
    except
      on e: exception do
      begin
        AddMsgToMemo('MT日志异常:' + e.Message);

        if e.Message = '连接失败' then
        begin
          AdoConnection.Close;
        end;
      end;
    end;
  end;
end;

procedure TLogThreadObj.LogRpt;
var
  logseqid: integer;
  strSql: string;
  Buffer: TRptBuffer;
  MtOutMsgId: string;
  MtOutSubDate: string;
  MtOutDonDate: string;
  MtOutStat: string;
  MtOutErr: string;
  Rpt: TSMGP13RPT;
  MtInMsgId: string;
  MtLogicId: Cardinal;
  MtSpAddr: string;
  MtUserAddr: string;
begin
  logseqid := rptbuffer.Get;
  if logseqid > 0 then
  begin
    //取得一缓冲包
    Buffer := rptbuffer.Read(logseqid);

    ZeroMemory(@Rpt, sizeof(Rpt));
    Move(Buffer.Rpt.MsgContent, Rpt, Buffer.Rpt.MsgLength);

    MtOutMsgId := Chartohex(Rpt.ID); //转成16进制
    MtOutSubDate := Rpt.SUBMITDATE;
    MtOutDonDate := Rpt.DONEDATE;
    MtOutStat := Rpt.stat;
    MtOutErr := Rpt.Err;

    strSql := 'select * from OUTMT where OutMtMsgid = ' + Quotedstr(MtOutMsgId);
    AdoQuery.Close;
    AdoQuery.SQL.Text := strSql;
    AdoQuery.Open;
    if not AdoQuery.Eof then
    begin
      MtInMsgId := AdoQuery.fieldbyname('MtInMsgId').AsString;
      MtLogicId := AdoQuery.fieldbyname('MtLogicId').AsInteger;
      MtSpAddr := AdoQuery.fieldbyname('MtSpAddr').AsString;
      MtUserAddr := AdoQuery.fieldbyname('MtUserAddr').AsString;

      if MtLogicId = 1 then
      begin
        //群发
        if MtOutStat = 'DELIVRD' then
        begin
          strSql := 'update mtsend set Status = 1 where MtInMsgId = ' + Quotedstr(AdoQuery.fieldbyname('MtInMsgId').AsString) + ' and gateid = ' + inttostr(GSMSCENTERCONFIG.GateId);
          AdoConnection.Execute(strSql);
        end
        else
        begin
          strSql := 'update mtsend set Status = 2 where MtInMsgId = ' + Quotedstr(AdoQuery.fieldbyname('MtInMsgId').AsString) + ' and gateid = ' + inttostr(GSMSCENTERCONFIG.GateId);
          AdoConnection.Execute(strSql);
        end;
      end;

      if MtLogicId = 2 then
      begin
        //话单
        if MtOutStat = 'DELIVRD' then
        begin
          strSql := 'update mcsend set Status = 1 where MtInMsgId = ' + Quotedstr(AdoQuery.fieldbyname('MtInMsgId').AsString) + ' and gateid = ' + inttostr(GSMSCENTERCONFIG.GateId);
          AdoConnection.Execute(strSql);
        end
        else
        begin
          strSql := 'update mcsend set Status = 2 where MtInMsgId = ' + Quotedstr(AdoQuery.fieldbyname('MtInMsgId').AsString) + ' and gateid = ' + inttostr(GSMSCENTERCONFIG.GateId);
          AdoConnection.Execute(strSql);
        end;
      end;

      if MtOutStat = 'DELIVRD' then
      begin
        strSql := 'insert into OUTMTLOG (L2CMtMsgType, MoOutMsgId, MoInMsgId, MtGateId, MoLinkId, MtSpAddr, MtUserAddr, MtFeeAddr, L2CMtServiceId, MtMsgFmt, MtValidTime, MtAtTime, MtMsgLenth, MtMsgContent, MtReserve, MtInMsgId, MtLogicId, ';
        strSql := strSql + 'PrePrcResult, OutMsgType, OutServiceID, OutFeeType, OutFixedFee, OutFeeCode, RealFeeCode, C2GRecTime, OUTStatus, OutMtMsgid, OutPrced, OutPrcTimes, OutLastprctime, OutRptSubDate, OutRptDonDate, OutRptStat, OutRptErr, OutRptRecTime) values (';
        strSql := strSql + AdoQuery.fieldbyname('L2CMtMsgType').AsString + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('MoOutMsgId').AsString) + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('MoInMsgId').AsString) + ',';
        strSql := strSql + AdoQuery.fieldbyname('MtGateId').AsString + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('MoLinkId').AsString) + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('MtSpAddr').AsString) + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('MtUserAddr').AsString) + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('MtFeeAddr').AsString) + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('L2CMtServiceId').AsString) + ',';
        strSql := strSql + AdoQuery.fieldbyname('MtMsgFmt').AsString + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('MtValidTime').AsString) + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('MtAtTime').AsString) + ',';
        strSql := strSql + AdoQuery.fieldbyname('MtMsgLenth').AsString + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('MtMsgContent').AsString) + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('MtReserve').AsString) + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('MtInMsgId').AsString) + ',';
        strSql := strSql + AdoQuery.fieldbyname('MtLogicId').AsString + ',';
        strSql := strSql + AdoQuery.fieldbyname('PrePrcResult').AsString + ',';
        strSql := strSql + AdoQuery.fieldbyname('OutMsgType').AsString + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('OutServiceID').AsString) + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('OutFeeType').AsString) + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('OutFixedFee').AsString) + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('OutFeeCode').AsString) + ',';
        strSql := strSql + AdoQuery.fieldbyname('RealFeeCode').AsString + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('C2GRecTime').AsString) + ',';
        strSql := strSql + AdoQuery.fieldbyname('OUTStatus').AsString + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('OutMtMsgid').AsString) + ',';
        strSql := strSql + AdoQuery.fieldbyname('OutPrced').AsString + ',';
        strSql := strSql + AdoQuery.fieldbyname('OutPrcTimes').AsString + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('OutLastprctime').AsString) + ',';
        strSql := strSql + Quotedstr(MtOutSubDate) + ',';
        strSql := strSql + Quotedstr(MtOutDonDate) + ',';
        strSql := strSql + Quotedstr(MtOutStat) + ',';
        strSql := strSql + Quotedstr(MtOutErr) + ',';
        strSql := strSql + Quotedstr(FormatDatetime('yyyy-mm-dd hh:nn:ss:zzz', Buffer.RecTime)) + ')';
      end
      else
      begin
        strSql := 'insert into OUTERRMTLOG (L2CMtMsgType, MoOutMsgId, MoInMsgId, MtGateId, MoLinkId, MtSpAddr, MtUserAddr, MtFeeAddr, L2CMtServiceId, MtMsgFmt, MtValidTime, MtAtTime, MtMsgLenth, MtMsgContent, MtReserve, MtInMsgId, MtLogicId, ';
        strSql := strSql + 'PrePrcResult, OutMsgType, OutServiceID, OutFeeType, OutFixedFee, OutFeeCode, RealFeeCode, C2GRecTime, OUTStatus, OutMtMsgid, OutPrced, OutPrcTimes, OutLastprctime, OutRptSubDate, OutRptDonDate, OutRptStat, OutRptErr, OutRptRecTime) values (';
        strSql := strSql + AdoQuery.fieldbyname('L2CMtMsgType').AsString + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('MoOutMsgId').AsString) + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('MoInMsgId').AsString) + ',';
        strSql := strSql + AdoQuery.fieldbyname('MtGateId').AsString + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('MoLinkId').AsString) + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('MtSpAddr').AsString) + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('MtUserAddr').AsString) + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('MtFeeAddr').AsString) + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('L2CMtServiceId').AsString) + ',';
        strSql := strSql + AdoQuery.fieldbyname('MtMsgFmt').AsString + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('MtValidTime').AsString) + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('MtAtTime').AsString) + ',';
        strSql := strSql + AdoQuery.fieldbyname('MtMsgLenth').AsString + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('MtMsgContent').AsString) + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('MtReserve').AsString) + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('MtInMsgId').AsString) + ',';
        strSql := strSql + AdoQuery.fieldbyname('MtLogicId').AsString + ',';
        strSql := strSql + AdoQuery.fieldbyname('PrePrcResult').AsString + ',';
        strSql := strSql + AdoQuery.fieldbyname('OutMsgType').AsString + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('OutServiceID').AsString) + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('OutFeeType').AsString) + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('OutFixedFee').AsString) + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('OutFeeCode').AsString) + ',';
        strSql := strSql + AdoQuery.fieldbyname('RealFeeCode').AsString + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('C2GRecTime').AsString) + ',';
        strSql := strSql + AdoQuery.fieldbyname('OUTStatus').AsString + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('OutMtMsgid').AsString) + ',';
        strSql := strSql + AdoQuery.fieldbyname('OutPrced').AsString + ',';
        strSql := strSql + AdoQuery.fieldbyname('OutPrcTimes').AsString + ',';
        strSql := strSql + Quotedstr(AdoQuery.fieldbyname('OutLastprctime').AsString) + ',';
        strSql := strSql + Quotedstr(MtOutSubDate) + ',';
        strSql := strSql + Quotedstr(MtOutDonDate) + ',';
        strSql := strSql + Quotedstr(MtOutStat) + ',';
        strSql := strSql + Quotedstr(MtOutErr) + ',';
        strSql := strSql + Quotedstr(FormatDatetime('yyyy-mm-dd hh:nn:ss:zzz', Buffer.RecTime)) + ')';
      end;

      AdoQuery.Close;

      try
        AdoConnection.Execute(strSql);
        AdoConnection.Execute('delete OUTMT where OutMtMsgid = ' + Quotedstr(MtOutMsgId));
        rptbuffer.UpdateMsgId(logseqid, MtInMsgId, MtLogicId, MtSpAddr, MtUserAddr);
      except
        on e: exception do
        begin
          rptbuffer.Update(logseqid);
          AddMsgToMemo('RPT日志异常' + e.Message);
          if e.Message = '连接失败' then
          begin
            AdoConnection.Close;
          end;
        end;
      end;
    end
    else
    begin
      rptbuffer.Update(logseqid);
    end;
  end;
end;

procedure TLogThreadObj.ThAddMsgToMemo;
begin
  if MainForm <> nil then
  begin
    MainForm.ShowToMemo(ErrMsg, MainForm.MonitorMemo);
  end;
end;

procedure TMainForm.OutListViewAdvancedCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage; var DefaultDraw: boolean);
begin
  try
    DefaultDraw := True;
    with OutListview.Canvas do
    begin
      lock;
      if Item.Index mod 2 = 0 then
        Brush.Color := clWhite
      else
        Brush.Color := TColor($C0C0C0);
      unlock;
    end;
  except
  end;
end;

procedure TMainForm.OutListViewDblClick(Sender: TObject);
var
  li: TListItem;
  p: TOutPacket;
  Rpt: TSMGP13RPT;
  temp: array[0..119] of char;
begin
  try
    if OutListview.Selected = nil then exit;
    li := OutListview.Selected;
    p := TOutPacket(li.Data);
    OutPMemo.Text := '';
    OutPMemo.Lines.Add('[PacketLength]' + inttostr(p.pac.MsgHead.PacketLength));
    OutPMemo.Lines.Add('[RequestID]' + inttostr(p.pac.MsgHead.RequestID));
    OutPMemo.Lines.Add('[SequenceID]' + inttostr(p.pac.MsgHead.SequenceID));

    case p.pac.MsgHead.RequestID of
      SMGP13_LOGIN:
        begin
          OutPMemo.Lines.Add('[ClientID]' + p.pac.MsgBody.LOGIN.ClientID);
          OutPMemo.Lines.Add('[AuthenticatorClient]' + Chartohex(p.pac.MsgBody.LOGIN.AuthenticatorClient));
          OutPMemo.Lines.Add('[LoginMode]' + inttostr(p.pac.MsgBody.LOGIN.LoginMode));
          OutPMemo.Lines.Add('[TimeStamp]' + inttostr(p.pac.MsgBody.LOGIN.TimeStamp));
          OutPMemo.Lines.Add('[Version]' + inttostr(p.pac.MsgBody.LOGIN.Version));
        end;

      SMGP13_LOGIN_RESP:
        begin
          OutPMemo.Lines.Add('[Status]' + inttostr(p.pac.MsgBody.LOGIN_RESP.Status));
          OutPMemo.Lines.Add('[AuthenticatorServer]' + p.pac.MsgBody.LOGIN_RESP.AuthenticatorServer);
          OutPMemo.Lines.Add('[Version]' + inttostr(p.pac.MsgBody.LOGIN_RESP.Version));
        end;

      SMGP13_SUBMIT:
        begin
          OutPMemo.Lines.Add('[MsgType]' + inttostr(p.pac.MsgBody.SUBMIT.MsgType));
          OutPMemo.Lines.Add('[NeedReport]' + inttostr(p.pac.MsgBody.SUBMIT.NeedReport));
          OutPMemo.Lines.Add('[Priority]' + inttostr(p.pac.MsgBody.SUBMIT.Priority));
          OutPMemo.Lines.Add('[ServiceID]' + (p.pac.MsgBody.SUBMIT.ServiceID));
          OutPMemo.Lines.Add('[FeeType]' + (p.pac.MsgBody.SUBMIT.FeeType));
          OutPMemo.Lines.Add('[FixedFee]' + (p.pac.MsgBody.SUBMIT.FixedFee));
          OutPMemo.Lines.Add('[FeeCode]' + (p.pac.MsgBody.SUBMIT.FeeCode));
          OutPMemo.Lines.Add('[MsgFormat]' + inttostr(p.pac.MsgBody.SUBMIT.MsgFormat));
          OutPMemo.Lines.Add('[ValidTime]' + (p.pac.MsgBody.SUBMIT.ValidTime));
          OutPMemo.Lines.Add('[AtTime]' + (p.pac.MsgBody.SUBMIT.AtTime));
          OutPMemo.Lines.Add('[SrcTermID]' + (p.pac.MsgBody.SUBMIT.SrcTermID));
          OutPMemo.Lines.Add('[ChargeTermID]' + (p.pac.MsgBody.SUBMIT.ChargeTermID));
          OutPMemo.Lines.Add('[DestTermIDCount]' + inttostr(p.pac.MsgBody.SUBMIT.DestTermIDCount));
          OutPMemo.Lines.Add('[DestTermID]' + (p.pac.MsgBody.SUBMIT.DestTermID));
          OutPMemo.Lines.Add('[MsgLength]' + inttostr(p.pac.MsgBody.SUBMIT.MsgLength));
          OutPMemo.Lines.Add('[MsgContent]' + (p.pac.MsgBody.SUBMIT.MsgContent));
          OutPMemo.Lines.Add('[Reserve]' + (p.pac.MsgBody.SUBMIT.Reserve));
        end;

      SMGP13_SUBMIT_RESP:
        begin
          OutPMemo.Lines.Add('[MsgID]' + Chartohex(p.pac.MsgBody.SUBMIT_RESP.MsgID));
          OutPMemo.Lines.Add('[Status]' + inttostr(p.pac.MsgBody.SUBMIT_RESP.Status));
        end;

      SMGP13_DELIVER:
        begin
          OutPMemo.Lines.Add('[MsgID]' + Chartohex(p.pac.MsgBody.DELIVER.MsgID));
          OutPMemo.Lines.Add('[IsReport]' + inttostr(p.pac.MsgBody.DELIVER.IsReport));
          OutPMemo.Lines.Add('[MsgFormat]' + inttostr(p.pac.MsgBody.DELIVER.MsgFormat));
          OutPMemo.Lines.Add('[RecvTime]' + p.pac.MsgBody.DELIVER.RecvTime);
          OutPMemo.Lines.Add('[SrcTermID]' + p.pac.MsgBody.DELIVER.SrcTermID);
          OutPMemo.Lines.Add('[DestTermID]' + p.pac.MsgBody.DELIVER.DestTermID);
          OutPMemo.Lines.Add('[MsgLength]' + inttostr(p.pac.MsgBody.DELIVER.MsgLength));
          if p.pac.MsgBody.DELIVER.IsReport = 0 then
          begin
            OutPMemo.Lines.Add('[MsgContent]' + p.pac.MsgBody.DELIVER.MsgContent);
          end
          else
          begin
            Move(p.pac.MsgBody.DELIVER.MsgContent, Rpt, sizeof(Rpt));
            Move(p.pac.MsgBody.DELIVER.MsgContent[13], temp, sizeof(temp));
            OutPMemo.Lines.Add('[MsgContent]' + Rpt.TID + Chartohex(Rpt.ID) + temp);
          end;
          OutPMemo.Lines.Add('[Reserve]' + p.pac.MsgBody.DELIVER.Reserve);
        end;

      SMGP13_DELIVER_RESP:
        begin
          OutPMemo.Lines.Add('[MsgID]' + Chartohex(p.pac.MsgBody.DELIVER_RESP.MsgID));
          OutPMemo.Lines.Add('[Status]' + inttostr(p.pac.MsgBody.DELIVER_RESP.Status));
        end;

      SMGP13_ACTIVE_TEST:
        begin

        end;

      SMGP13_ACTIVE_TEST_RESP:
        begin

        end;
    end;
  except
  end;
end;


procedure TMainForm.N7Click(Sender: TObject);
begin
  try
    LoadServiceCode;
    LoadProtocol;
  except
  end;
end;

procedure TMainForm.InListViewAdvancedCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage; var DefaultDraw: boolean);
begin
  { try
     DefaultDraw := True;
     with InListview.Canvas do
     begin
       lock;
       if Item.Index mod 2 = 0 then
         Brush.Color := clWhite
       else
         Brush.Color := TColor($C0C0C0);
       unlock;
     end;
   except
   end;  }
end;


procedure TMainForm.N9Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.MonitorTimerTimer(Sender: TObject);
var
  bad: boolean;
begin
  smcmo0;
  smcmt;
  smcmo;
end;

procedure TMainForm.MonitorMemoChange(Sender: TObject);
begin
  try
    if MonitorMemo.Lines.Count > 200 then
    begin
      MonitorMemo.Lines.SaveToFile('ErrLog\' + FormatDatetime('yyyymmddhhnnss', now()) + '.log');
      MonitorMemo.Clear;
    end;
  except
  end;
end;

procedure TMainForm.N11Click(Sender: TObject);
var
  i: integer;
begin
  try
    for i := 0 to OutListview.Items.Count - 1 do
    begin
      TOutPacket(OutListview.Items[i].Data).Free;
      OutListview.Items[i].Data := nil;
    end;

    OutListview.Items.BeginUpdate;
    try
      OutListview.Clear;
    finally
      OutListview.Items.EndUpdate;
    end;
  except
  end;
end;

procedure TMtQfThread.ConnectDB;
begin
  if false {ADOConnection.Connected = false} then
  begin
    AdoConnection.ConnectionString := 'Provider=SQLOLEDB.1;Password='
      + GDBCONFIG.Pass
      + ';Persist Security Info=True;Application Name='
      + GSMSCENTERCONFIG.GateDesc
      + ';User ID='
      + GDBCONFIG.User
      + ';Initial Catalog='
      + GDBCONFIG.TnsName
      + ';Data Source='
      + GDBCONFIG.Address;
    try
      AdoConnection.Open();
    except
      on e: exception do
      begin
        AddMsgToMemo('日志线程数据库连接失败');
        AddMsgToMemo(e.Message);
      end;
    end;
  end;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  try
    if now - OutLastConnectTime > 5 / 3600 / 24 then
    begin
      SMGPTCPClient.CheckForGracefulDisconnect(false);
      if SMGPTCPClient.Connected then
      begin
        OutLastConnectTime := now;
      end
      else
      begin
        SMGPTCPClient.Host := GGATECONFIG.RemoteIp;
        SMGPTCPClient.Port := GGATECONFIG.RemotePort;
        try
          if GGATECONFIG.Smgp_Tag = 1 then
            SMGPTCPClient.Connect();
        except
          on e: exception do
          begin
            ShowToMemo('连接运行商SMGPSMC失败:' + e.Message, MonitorMemo);
          end;
        end;
        OutLastConnectTime := now;
      end;
    end;

    //cmpp 下行端口
    if now - OutLastCMPPConnectTime > 5 / 3600 / 24 then
    begin
      CmppTCPClient.CheckForGracefulDisconnect(false);
      if CmppTCPClient.Connected then
      begin
        OutLastCMPPConnectTime := now;
      end
      else
      begin
        CmppTCPClient.Host := GGATECONFIG.cmppRemoteIp;
        CmppTCPClient.Port := GGATECONFIG.cmppRemotePort;
        try
          if GGATECONFIG.Cmpp_Tag = 1 then
            CmppTCPClient.Connect();
        except
          on e: exception do
          begin
            ShowToMemo('连接运行商CMPPSMC失败:' + e.Message, MonitorMemo);
          end;
        end;
        OutLastCMPPConnectTime := now;
      end;
    end;

    //cmpp 上行端口
    if now - OutLastCMPP0ConnectTime > 5 / 3600 / 24 then
    begin
      Cmpp0TCPClient.CheckForGracefulDisconnect(false);
      if Cmpp0TCPClient.Connected then
      begin
        OutLastCMPP0ConnectTime := now;
      end
      else
      begin
        Cmpp0TCPClient.Host := GGATECONFIG.cmppRemoteIp;
        Cmpp0TCPClient.Port := GGATECONFIG.cmppRemotePort0;
        try
          if GGATECONFIG.Cmpp_Tag = 1 then
            Cmpp0TCPClient.Connect();
        except
          on e: exception do
          begin
            ShowToMemo('连接运行商CMPPSMC0失败:' + e.Message, MonitorMemo);
          end;
        end;
        OutLastCMPP0ConnectTime := now;
      end;
    end;

    //Sgip
    if now - OutLastSgipConnectTime > 5 / 3600 / 24 then
    begin
      SgipTCPClient.CheckForGracefulDisconnect(false);
      if SgipTCPClient.Connected then
      begin
        OutLastSgipConnectTime := now;
      end
      else
      begin
        SgipTCPClient.Host := GGATECONFIG.SgipRemoteIp;
        SgipTCPClient.Port := GGATECONFIG.SgipRemotePort;
        try
          if GGATECONFIG.Smgp_Tag = 1 then
            SgipTCPClient.Connect();
        except
          on e: exception do
          begin
            ShowToMemo('连接运行商SMGPSMC失败:' + e.Message, MonitorMemo);
          end;
        end;
        OutLastSgipConnectTime := now;
      end;
    end;

  except
  end;
  MonitorTimer.Enabled := True; //监控开始
end;

//把所需要的信息取出来，SMC到网关的信息
procedure TMainForm.smcmo;
var
  MoSeqId: integer;
  strSql: string;
  Buffer: TMoBuffer;
begin
  MoSeqId := mobuffer.Get;
  if MoSeqId > 0 then
  begin
    Buffer := mobuffer.Read(MoSeqId);
    ConvertNull(Buffer.mo.MsgContent, Buffer.mo.MsgLength, Buffer.mo.MsgContent);
    strSql := 'insert into SmcMo (MoOutMsgId, MoInMsgId, MoSpAddr, MoUserAddr, MoMsgFmt, MoMsgLenth, MoMsgContent, MoReserve, OutRecTime, G2CED, SPPOrcTimes, G2CLastPrcTime, MoGateId,smc_tag) values (';
    strSql := strSql + Quotedstr(Chartohex(Buffer.mo.MsgID)) + ',';
    strSql := strSql + Quotedstr(Chartohex(Buffer.MoInMsgId)) + ',';
    strSql := strSql + Quotedstr(Buffer.mo.DestTermID) + ',';
    strSql := strSql + Quotedstr(Buffer.mo.SrcTermID) + ',';
    strSql := strSql + inttostr(Buffer.mo.MsgFormat) + ',';
    strSql := strSql + inttostr(Buffer.mo.MsgLength) + ',';
    strSql := strSql + Quotedstr(Buffer.mo.MsgContent) + ',';
    strSql := strSql + '0' + ',';
    strSql := strSql + Quotedstr(FormatDatetime('yyyy-mm-dd hh:nn:ss:zzz', Buffer.RecTime)) + ',';
    strSql := strSql + inttostr(Buffer.Prced) + ',';
    strSql := strSql + inttostr(Buffer.PrcTimes) + ',';
    strSql := strSql + Quotedstr(FormatDatetime('yyyy-mm-dd hh:nn:ss:zzz', Buffer.LastPrcTime)) + ',';
    strSql := strSql + inttostr(GSMSCENTERCONFIG.GateId) + ',';
    strSql := strSql + inttostr(0);
    strSql := strSql + ')';
    MainForm.MOMemo.Lines.Add('MO用户号码：' + Buffer.mo.SrcTermID);
    MainForm.MOMemo.Lines.Add('MO端口：' + Buffer.mo.DestTermID);
    MainForm.MOMemo.Lines.Add('MO内容：' + Buffer.mo.MsgContent);
    try
      AdoConnection.Execute(strSql);
      mobuffer.Delete(MoSeqId);
    except
    end;
  end;
end;

procedure TMainForm.smcmo0;
var
  MoSeqId: integer;
  strSql: string;
  Buffer: TMocmppBuffer;
  strtest: string;
  i: integer;
  str0: string;
  InValue: string;
  dest_str: string;
  MSG_CON: string;
  HEXS: string;
  i0: integer;
  function DecodeWideString(Value: string): WideString;
  var
    i: integer;
  begin
    result := '';
    for i := 0 to (length(Value) div 4) - 1 do
    begin
      result := result + wchar(strtoint('$' + Value[i * 4 + 1] + Value[i * 4 + 2]) shl 8
        + strtoint('$' + Value[i * 4 + 3] + Value[i * 4 + 4]));
    end;
  end;
begin
  MoSeqId := mocmppbuffer.Get;
  if MoSeqId > 0 then
  begin
    Buffer := mocmppbuffer.Read(MoSeqId);
    ConvertNull(Buffer.mo.Msg_Content, Buffer.mo.MSG_LENGTH, Buffer.mo.Msg_Content);
    strSql := 'insert into SmcMo (MoOutMsgId, MoInMsgId, MoSpAddr, MoUserAddr, MoMsgFmt, MoMsgLenth, MoMsgContent, MoReserve, OutRecTime, G2CED, SPPOrcTimes, G2CLastPrcTime, MoGateId,smc_tag) values (';
    strSql := strSql + inttostr(Buffer.mo.Msg_Id) + ',';
    strSql := strSql + Quotedstr(Chartohex(Buffer.MoInMsgId)) + ',';
    strSql := strSql + Quotedstr(Buffer.mo.Dest_Id) + ',';
    strSql := strSql + Quotedstr(Buffer.mo.Src_terminal_Id) + ',';
    strSql := strSql + inttostr(Buffer.mo.Msg_Fmt) + ',';
    strSql := strSql + inttostr(Buffer.mo.MSG_LENGTH) + ',';
    strSql := strSql + Quotedstr(Buffer.mo.Msg_Content) + ',';
    strSql := strSql + '0' + ',';
    strSql := strSql + Quotedstr(FormatDatetime('yyyy-mm-dd hh:nn:ss:zzz', Buffer.RecTime)) + ',';
    strSql := strSql + inttostr(Buffer.Prced) + ',';
    strSql := strSql + inttostr(Buffer.PrcTimes) + ',';
    strSql := strSql + Quotedstr(FormatDatetime('yyyy-mm-dd hh:nn:ss:zzz', Buffer.LastPrcTime)) + ',';
    strSql := strSql + inttostr(GSMSCENTERCONFIG.GateId) + ',';
    strSql := strSql + inttostr(1);
    strSql := strSql + ')';
    MainForm.MOMemo.Lines.Add('MO用户号码：' + Buffer.mo.Src_terminal_Id);
    MainForm.MOMemo.Lines.Add('MO端口：' + Buffer.mo.Dest_Id);
    MainForm.MOMemo.Lines.Add('MO内容：' + Buffer.mo.Msg_Content);
    try
      AdoConnection.Execute(strSql);
      mocmppbuffer.Delete(MoSeqId);
    except
    end;
  end;
end;

procedure TMainForm.smcmt;
var
  MoSeqId: integer;
  strSql: string;
  strtest: string;
  querytemp: TAdoQuery;
  querytemp0: TAdoQuery;
  Buffercmpp: TMtBuffer;
  outpac: TSPPO_PACKET;
  sendbuffer: TCOMMBuffer;
  NetPacOut, LocPacOut: TSPPO_PACKET;
  pac: TSPPO_PACKET;
  Seqid: integer;
  Autoid: integer;
  MtInMsgId: string;
  spcode: string; //SP sumbit 上行的编号

  function GetSeqid: Cardinal;
  begin
    result := Seqid;
    inc(Seqid);
    if Seqid >= 4294967295 then
    begin
      Seqid := 1;
    end;
  end;

  function GetInMsgId: string;
  var
    str: string;
    i: integer;
  begin
    //3位网关号 + 14 yyyymmddhhnnss + 3序号,共20
    str := copy(inttostr(GSMSCENTERCONFIG.GateId), 2, 3) + FormatDatetime('yyyymmddhhnnss', now);
    i := GetSeqid;
    if i >= 100 then
    begin
      str := str + inttostr(i);
    end
    else if i >= 10 then
    begin
      str := str + '0' + inttostr(i);
    end
    else
    begin
      str := str + '00' + inttostr(i);
    end;
    result := str;
  end;

  function GetSmsNum(sms: string): integer;
  var
    i, i1, i0: integer;
    sms0: string;
  begin
    sms0 := sms;
    i0 := 1;
    for i := 0 to 10 do
    begin
      if length(sms0) - 140 >= 0 then
      begin
        i0 := i0 + 1;
      end;
      if length(sms0) >= 140 then
      begin
        sms0 := copy(sms0, 141, length(sms0));
      end;
      //inc(i);
    end;
    result := i0;
  end;
begin
  querytemp := TAdoQuery.Create(self);
  querytemp.Connection := AdoConnection;
  querytemp0 := TAdoQuery.Create(self);
  querytemp0.Connection := AdoConnection;
  querytemp.Close;
  querytemp.SQL.Clear;
  //添加了判断是否属于本网关的 读取程序
  //querytemp.SQL.Add('select * from zxsp_sendsms where zx_send_tag=''1'' and msg_src=''' + GSMSCENTERCONFIG.Gatename + ''' and port_tag=0');
  querytemp.SQL.Add('select * from sendsms where send_tag=''1''  and port_tag=0');
  //querytemp.Open;
  with querytemp do
  begin
    Close;
    try
      Open;
    except
    end;
    First;
    while not Eof do
    begin
      SetPchar(Buffercmpp.Mt.MtMsgContent, trim(fieldbyname('sms_text').AsString), sizeof(Buffercmpp.Mt.MtMsgContent));
      Buffercmpp.Mt.MtMsgLenth := length(trim(fieldbyname('sms_text').AsString));
      if length(trim(fieldbyname('sms_text').AsString)) > 140 then
      begin
      end;
      spcode := fieldbyname('code_id').AsString;
      ZeroMemory(@Buffercmpp, sizeof(TMtBuffer));
      {Buffercmpp.OutMsgType := 3;
      SetPchar(Buffercmpp.OutServiceID, trim(fieldbyname('sms_ywcode').AsString), sizeof(Buffercmpp.OutServiceID));
      Buffercmpp.OutFeeType := '01'; //
      Buffercmpp.OutFixedFee := '00';
      Buffercmpp.OutFeeCode := '000000';   }
      SetPchar(Buffercmpp.Mt.OutServiceID, trim(fieldbyname('sms_ywcode').AsString), sizeof(Buffercmpp.Mt.OutServiceID));
      Buffercmpp.Mt.OutFeeType := '01'; //
      Buffercmpp.Mt.OutFixedFee := '00';
      Buffercmpp.Mt.OutFeeCode := '000000';
      Buffercmpp.Mt.MtMsgFmt := 15;
      Buffercmpp.Mt.MtValidTime := '20051222140000';
      Buffercmpp.Mt.MtAtTime := '20051222140000';
      //端口号
      SetPchar(Buffercmpp.Mt.MtSpAddr, trim(fieldbyname('source_num').AsString), sizeof(Buffercmpp.Mt.MtSpAddr));
      //SP_ID
      SetPchar(Buffercmpp.Mt.msg_src, trim(fieldbyname('msg_src').AsString), sizeof(Buffercmpp.Mt.msg_src));
      //Buffer.Mt.MtFeeAddr :='13883722170';
      //Buffer.Mt.MtUserAddr :='13883722170';
      //SetPchar 这个是把一个字符串赋值给一个 排列类值
      SetPchar(Buffercmpp.Mt.MtUserAddr, trim(fieldbyname('sms_mob').AsString), sizeof(Buffercmpp.Mt.MtUserAddr));
      SetPchar(Buffercmpp.Mt.MtFeeAddr, trim(fieldbyname('sms_mob').AsString), sizeof(Buffercmpp.Mt.MtFeeAddr));
      Buffercmpp.Mt.MtMsgLenth := length(trim(fieldbyname('sms_text').AsString));
      SetPchar(Buffercmpp.Mt.MtMsgContent, trim(fieldbyname('sms_text').AsString), sizeof(Buffercmpp.Mt.MtMsgContent));
      ZeroMemory(@outpac, sizeof(TSPPO_PACKET));
      outpac.Head.CmdId := htonl(SPPO_MT);
      outpac.Head.Seqid := htonl(Seqid);
      //outpac.Head.Seqid := htonl(fieldbyname('zx_code_id').AsVariant);
      outpac.Head.length := htonl(sizeof(TSPPO_HEAD) + sizeof(TSPPO_MT) - sizeof(outpac.Body.Mt.MtMsgContent) + Buffercmpp.Mt.MtMsgLenth);
      Move(Buffercmpp.Mt, outpac.Body.Mt, sizeof(Buffercmpp.Mt));
      case fieldbyname('smc_tag').AsInteger of
        0:
          begin
            mtbuffer.Add(outpac);
          end;
        1: //移动
          begin
            mtcmppbuffer.Add(outpac);
          end;
        2:
          begin
          end;
      end;
      with querytemp0 do
      begin
        Close;
        SQL.Clear;
        SQL.Add('update sendsms set  send_tag=''2'' where code_id =''' + spcode + '''');
        ExecSql;
      end;
      next;
    end;
  end;
  querytemp.Free;
  querytemp0.Free;
end;

procedure TMainForm.LoadProtocol;
var
  strSql: string;
  i: integer;
begin
  if AdoConnection.Connected then
  begin
    strSql := 'select Serviceid,msgtype,gatefeetype,gatefeecode,gatemsgtype,gatefixfee,realfeecode from ProtocolView where gateid = ' + inttostr(GSMSCENTERCONFIG.GateId);
    AdoQuery.Close;
    AdoQuery.SQL.Text := strSql;
    AdoQuery.Open;
    if high(Protocol) = -1 then
    begin
      setlength(Protocol, AdoQuery.RecordCount);
    end
    else
    begin
      Protocol := nil;
      setlength(Protocol, AdoQuery.RecordCount);
    end;
    i := 0;
    while not AdoQuery.Eof do
    begin
      SetPchar(Protocol[i].GateCode, AdoQuery.fieldbyname('Serviceid').AsString, sizeof(ServiceCode[i].GateCode));
      Protocol[i].MsgType := AdoQuery.fieldbyname('msgtype').AsInteger;
      SetPchar(Protocol[i].GateFeeType, AdoQuery.fieldbyname('gatefeetype').AsString, sizeof(Protocol[i].GateFeeType));
      SetPchar(Protocol[i].gatefeecode, AdoQuery.fieldbyname('gatefeecode').AsString, sizeof(Protocol[i].gatefeecode));
      SetPchar(Protocol[i].gatefeecode, AdoQuery.fieldbyname('gatefeecode').AsString, sizeof(Protocol[i].gatefeecode));
      Protocol[i].GateMsgType := AdoQuery.fieldbyname('GateMsgType').AsInteger;
      SetPchar(Protocol[i].GateFixFee, AdoQuery.fieldbyname('GateFixFee').AsString, sizeof(Protocol[i].GateFixFee));
      Protocol[i].RealFeeCode := AdoQuery.fieldbyname('realfeecode').AsInteger;
      inc(i);
      AdoQuery.MoveBy(1);
    end;
    AdoQuery.Close;
  end;
end;

procedure TMainForm.N3Click(Sender: TObject);
begin
  try
    LoadProtocol;
  except
  end;
end;


procedure TMainForm.CmppTCPClientConnected(Sender: TObject);
begin
  try
    if MtSendCMPPThread <> nil then
    begin
      MtSendCMPPThread.Terminate;
      MtSendCMPPThread := nil;
    end;
    if OutReadCMPPThread <> nil then
    begin
      OutReadCMPPThread.Terminate;
      OutReadCMPPThread := nil;
    end;
    OutReadCMPPThread := TOutReadCMPPThreadObj.Create(True);
    OutReadCMPPThread.FTCPCmppClient := CmppTCPClient;
    OutReadCMPPThread.Resume;
    MtSendCMPPThread := TMtSendCMPPThreadObj.Create(True);
    MtSendCMPPThread.Resume;
  except

  end;
end;

procedure TMainForm.CmppTCPClientDisconnected(Sender: TObject);
begin
  try
    ShowToMemo('CMPP连接已断开', MonitorMemo);
    if MtSendCMPPThread <> nil then
    begin
      MtSendCMPPThread.Terminate;
      MtSendCMPPThread := nil;
    end;
    if OutReadCMPPThread <> nil then
    begin
      OutReadCMPPThread.Terminate;
      OutReadCMPPThread := nil;
    end;
  except
  end;
end;

procedure TMainForm.Cmpp0TCPClientConnected(Sender: TObject);
begin
  try
    if MtSendCMPP0Thread <> nil then
    begin
      MtSendCMPP0Thread.Terminate;
      MtSendCMPP0Thread := nil;
    end;
    if OutReadCMPP0Thread <> nil then
    begin
      OutReadCMPP0Thread.Terminate;
      OutReadCMPP0Thread := nil;
    end;
    OutReadCMPP0Thread := TOutReadCMPP0ThreadObj.Create(True);
    OutReadCMPP0Thread.FTCPCmppClient := Cmpp0TCPClient;
    OutReadCMPP0Thread.Resume;
    MtSendCMPP0Thread := TMtSendCMPP0ThreadObj.Create(True);
    MtSendCMPP0Thread.Resume;
  except

  end;
end;

procedure TMainForm.Cmpp0TCPClientDisconnected(Sender: TObject);
begin
  try
    ShowToMemo('CMPP0连接已断开', MonitorMemo);
    if MtSendCMPP0Thread <> nil then
    begin
      MtSendCMPP0Thread.Terminate;
      MtSendCMPP0Thread := nil;
    end;

    if OutReadCMPP0Thread <> nil then
    begin
      OutReadCMPP0Thread.Terminate;
      OutReadCMPP0Thread := nil;
    end;
  except
  end;
end;

procedure TMainForm.SgipTCPClientConnected(Sender: TObject);
begin
  try
    if MtSendSgipThread <> nil then
    begin
      MtSendSgipThread.Terminate;
      MtSendSgipThread := nil;
    end;

    if OutReadSgipThread <> nil then
    begin
      OutReadSgipThread.Terminate;
      OutReadSgipThread := nil;
    end;
    OutReadSgipThread := TOutReadSgipThreadObj.Create(True);
    OutReadSgipThread.FTCPClient := SgipTCPClient;
    OutReadSgipThread.Resume;
    MtSendSgipThread := TMtSendSgipThreadObj.Create(True);
    MtSendSgipThread.Resume;
  except

  end;
end;

procedure TMainForm.SgipTCPClientDisconnected(Sender: TObject);
begin
  try
    ShowToMemo('Sgip连接已断开', MonitorMemo);
    if MtSendSgipThread <> nil then
    begin
      MtSendSgipThread.Terminate;
      MtSendSgipThread := nil;
    end;
    if OutReadSgipThread <> nil then
    begin
      OutReadSgipThread.Terminate;
      OutReadSgipThread := nil;
    end;
  except
  end;
end;

end.

