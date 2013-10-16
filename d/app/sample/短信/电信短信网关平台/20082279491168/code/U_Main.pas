{---------------------------------------------}
{单元名称：U_Main.pas
{Authonr:  LUOXINXI
{Datetime: 2004/03/18
{单元描述：电信网关平台2.0协议应用程序主界面
{Other:
{---------------------------------------------}

unit U_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, ToolWin, Sockets, U_MsgInfo, U_CTThread,
  U_SPDeliverThread, U_SPReThread, U_CTDeliver, U_SubmitThread, ThreadSafeList, Log, ImgList,
  Menus, winsock, ScktComp, xmldom, XMLIntf, msxmldom, XMLDoc, StrUtils, NetDisconnect,
  RzButton, Transmit, SaveMessage, Buttons;

const
  CM_RESTORE = WM_USER + $1000;
  WZGL_APP_NAME = 'FJCTGateWay_System';

type
  TSMGPGateWay = class(TForm)
    StatusBar1: TStatusBar;
    Panel2: TPanel;
    Memo3: TMemo;
    Splitter2: TSplitter;
    Panel4: TPanel;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton12: TToolButton;
    Panel5: TPanel;
    ToolBar2: TToolBar;
    ToolButton11: TToolButton;
    TBSubmitReq: TToolButton;
    ToolButton18: TToolButton;
    TBResponse: TToolButton;
    ToolButton20: TToolButton;
    TBReport: TToolButton;
    ToolButton22: TToolButton;
    TBDToS: TToolButton;
    ToolButton24: TToolButton;
    TBCreateAll: TToolButton;
    ToolButton26: TToolButton;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    N111: TMenuItem;
    N221: TMenuItem;
    N1: TMenuItem;
    Splitter3: TSplitter;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Edit3: TEdit;
    Label5: TLabel;
    Edit4: TEdit;
    Label6: TLabel;
    Edit5: TEdit;
    Label7: TLabel;
    Edit6: TEdit;
    ToolButton7: TToolButton;
    ToolButton13: TToolButton;
    PopupMenu1: TPopupMenu;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    CheckBox1: TCheckBox;
    N5: TMenuItem;
    N6: TMenuItem;
    ToolButton17: TToolButton;
    ToolButton19: TToolButton;
    PopupMenu2: TPopupMenu;
    MOExit1: TMenuItem;
    N7: TMenuItem;
    MTExit1: TMenuItem;
    N8: TMenuItem;
    AllExit1: TMenuItem;
    PopupMenu3: TPopupMenu;
    AllLogin1: TMenuItem;
    N9: TMenuItem;
    MTLogin1: TMenuItem;
    N10: TMenuItem;
    MOLogin1: TMenuItem;
    N11: TMenuItem;
    Memo11: TMenuItem;
    N12: TMenuItem;
    Memo21: TMenuItem;
    N13: TMenuItem;
    Memo31: TMenuItem;
    Label8: TLabel;
    Label9: TLabel;
    Image1: TImage;
    Label10: TLabel;
    ToolButton16: TToolButton;
    ToolButton21: TToolButton;
    RzBitBtn1: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    RzBitBtn3: TRzBitBtn;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    N33: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    PopupMenu4: TPopupMenu;
    N37: TMenuItem;
    Panel1: TPanel;
    Panel3: TPanel;
    Memo1: TMemo;
    Panel6: TPanel;
    Memo2: TMemo;
    Splitter1: TSplitter;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    CheckBox2: TCheckBox;
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TBSubmitReqClick(Sender: TObject);
    procedure TBResponseClick(Sender: TObject);
    procedure TBReportClick(Sender: TObject);
    procedure TBDToSClick(Sender: TObject);
    procedure TBCreateAllClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure ToolButton15Click(Sender: TObject);
    procedure ToolButton17Click(Sender: TObject);
    procedure MOExit1Click(Sender: TObject);
    procedure MTExit1Click(Sender: TObject);
    procedure AllExit1Click(Sender: TObject);
    procedure AllLogin1Click(Sender: TObject);
    procedure MTLogin1Click(Sender: TObject);
    procedure MOLogin1Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure Memo11Click(Sender: TObject);
    procedure Memo21Click(Sender: TObject);
    procedure Memo31Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure ToolButton16Click(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure RzBitBtn3Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N34Click(Sender: TObject);
    procedure N37Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure createParams(var Params: TCreateParams); override;
    procedure RestoreRequest(var message: TMessage); message CM_RESTORE;
  end;

var
  SMGPGateWay: TSMGPGateWay;
  DCanExit: Boolean = True; //上行连接没有退出与电信的连接不能退出程序
  SCanExit: Boolean = True; //下行连接没有退出与电信的连接不能退出程序
  MTExit: Boolean = False; //下行链路退出
  MOExit: Boolean = False;
  TransmitExit: Boolean = False;
  {List}
  DeliverList: TThreadList; //上行队列
  SubmitList: TThreadList; //  下行队列
  ResponseList: TThreadList; //下行回馈队列
  ReportList: TThreadList; //递送报告队列
  SaveSubmitList: TThreadList; //保存已经下行短信，（重发）
  {序列号}
  dSequence: integer; //上行包头序列号
  sSequence: integer; //下行包头序列号
  {thread}
  xTCPCTDeliver: TCPCTDeliver; //电信上行
  xCPSubmit: TCPSubmit; //SP下行
  xDeliverThread: TSPDeliverThread; //网关上行非报告类短信到中间服务器
  xSubmitThread: TSubmitThread; //网关向中间服务器请求短信
  xRespThread: TResp; //网关向中间服务器发送回馈报告
  xRepThread: TRep; //网关向中间服务器发送递送报告
  xWriteLog: WriteLog; //写日志线程
  xTransmit: TTransmit;
  GWMoniter: GWWarnning;
  {save thread list}
  GDeliverTList: Tlist; {gateway to server}
  GSubmitTList: Tlist; {gateway to server}
  GRespTList: Tlist; {gateway to server}
  GRepTList: Tlist; {gateway to server}
  {Thread is Free}
  SubmitRequest: Boolean = False;
  Send_Deliver: Boolean = False;
  Send_Resp: Boolean = False;
  Send_Report: Boolean = False;
  WriteLog_Free: Boolean = True;
  {Log list}
  LogList: TThreadSafeStringList; //对日志分类
  {counter}
  CTD_cou: integer = 0; //电信上行数
  SPS_cou: integer = 0; //网关下行数
  GDToS_cou: integer = 0; //网关上行短信数
  GRespToS_cou: integer = 0; //网关上行回馈报告数
  GRepToS_cou: integer = 0; //网关上行递送报告数
  SToG_cou: integer = 0; //中间层下发短信数
  {connect Error Counter}
  SToG_E: integer = 0;
  RespError: integer = 0;
  RepError: integer = 0;
  SPdeliError: integer = 0;
  {retry time}
  RetryTime: integer = 0;
  {share login params}
  sharesecret, ServerIP, Port, ClientID,SPID: string;
  {当与电信断开连接时 向中间层取数据停止标志}
  StopCatchSMS: Boolean = True;

  ReadMessage: TReadMessage;
  SaveMessage: TSaveMessage;

  AppTitle:string;
  ActiveTestTime:integer;
  {当电信网关在NoReceiveDeliver分钟后没有上行发送提醒消息，如果一直没有上行发送连续发送次}
  //---------------------------------------------------------------------------
  SendWarn:boolean=True;
  NoReceiveDeliver:integer=30;
  SendCount:integer=10;
  Counter:integer=0;
  LastSendWarnMsgTime:TDateTime;
  GateID:string;
  //---------------------------------------------------------------------------

  //------------------------------以下为 Endo Add
  AccessNoStrList : TStrings; // Endo Add
//function GetSequenceID(const DestTermID, instructor: string): word;

implementation

{$R *.dfm}
uses
  U_SysConfig, md5, Htonl, Smgp13_XML, U_RequestID, GW_Submit, U_DeliverTest;

procedure TSMGPGateWay.FormCreate(Sender: TObject);
var
  sleeptime, logNumber: integer;
  udpsrvip: string;
  udpport: integer;
  autowrite: Boolean; 
begin
  ReadAppTitle(AppTitle);
  Caption:=AppTitle;
  Application.Title:=AppTitle;
  DeliverList := TThreadList.create;
  SubmitList := TThreadList.create;
  ResponseList := TThreadList.create;
  ReportList := TThreadList.create;
  SaveSubmitList := TThreadList.create;
  GDeliverTList := Tlist.create;
  GSubmitTList := Tlist.create;
  GRespTList := Tlist.create;
  GRepTList := Tlist.create;
  DeliverList.Clear;
  SubmitList.Clear;
  ResponseList.Clear;
  ReportList.Clear;
  SaveSubmitList.Clear;
  GDeliverTList.Clear;
  GSubmitTList.Clear;
  GRespTList.Clear;
  GRepTList.Clear;
  LogList := TThreadSafeStringList.create;
  readlogth(udpsrvip, udpport, logNumber, sleeptime, autowrite);
  xWriteLog := WriteLog.create(udpsrvip, udpport, sleeptime);
  readsequID(dSequence, sSequence); //读取包头序列号
  //initializeCriticalSection(CSXML); //临界区
  readRetrytime(RetryTime);
  Label10.Caption := '启动时间:' + datetimetostr(now);
  ReadMessage := TReadMessage.create;
  AccessNoStrList := TStringList.Create; // Endo Add
  AccessNoStrList.Clear;
  AccessNoStrList.LoadFromFile(ExtractFilePath(application.ExeName) + 'AccessNo.txt');
end;

{退出电信}
procedure TSMGPGateWay.FormDestroy(Sender: TObject);
begin
  FreeAndNil(DeliverList);
  FreeAndNil(SubmitList);
  FreeAndNil(SaveSubmitList);
  FreeAndNil(ResponseList);
  FreeAndNil(ReportList);
  FreeAndNil(GDeliverTList);
  FreeAndNil(GSubmitTList);
  FreeAndNil(GRespTList);
  FreeAndNil(GRepTList);
  FreeAndNil(LogList);
  FreeAndNil(AccessNoStrList);
  writesequID(dSequence, sSequence); //保存序列号
end;

procedure TSMGPGateWay.TBSubmitReqClick(Sender: TObject);
var
  ip, Port: string;
  ThreadN, i: integer;
  sleeptime: integer;
  timeout: integer;
begin
  readMTport(Port, ThreadN, sleeptime);
  if TBSubmitReq.Tag = 0 then
  begin
    readSerIp(ip, timeout);
    try
      for i := 0 to ThreadN - 1 do
      begin
        xSubmitThread := TSubmitThread.create(ip, Port, sleeptime, timeout); //创建线程
        GSubmitTList.Add(xSubmitThread);
      end;
      SubmitRequest := True;
      TBSubmitReq.Caption := 'Stop Request';
      TBSubmitReq.Tag := 1;
    except
    end;
  end
  else
  begin
    for i := 0 to ThreadN - 1 do
    begin
      TSubmitThread(GSubmitTList[i]).Terminate; //中止线程
    end;
    SubmitRequest := False;
    TBSubmitReq.Tag := 0;
    TBSubmitReq.Caption := 'Start Request';
  end;
end;

procedure TSMGPGateWay.TBResponseClick(Sender: TObject);
var
  ip, Port: string;
  ThreadN, i: integer;
  sleeptime: integer;
  timeout: integer;
begin
  readRespport(Port, ThreadN, sleeptime);
  if TBResponse.Tag = 0 then
  begin
    readSerIp(ip, timeout);
    for i := 0 to ThreadN - 1 do
    begin
      xRespThread := TResp.create(ip, Port, sleeptime, timeout); //创建线程
      GRespTList.Add(xRespThread);
    end;
    Send_Report := True;
    TBResponse.Caption := 'Stop Response';
    TBResponse.Tag := 1;
  end
  else
  begin
    for i := 0 to ThreadN - 1 do
    begin
      TResp(GRespTList[i]).Terminate; //中止线程
    end;
    Send_Report := False;
    TBResponse.Tag := 0;
    TBResponse.Caption := 'Start Response';
  end;
end;

procedure TSMGPGateWay.TBReportClick(Sender: TObject);
var
  ip, Port: string;
  ThreadN, i: integer;
  sleeptime: integer;
  timeout: integer;
begin
  readRepport(Port, ThreadN, sleeptime);
  if TBReport.Tag = 0 then
  begin
    readSerIp(ip, timeout);
    for i := 0 to ThreadN - 1 do
    begin
      xRepThread := TRep.create(ip, Port, sleeptime, timeout); //创建线程
      GRepTList.Add(xRepThread);
    end;
    Send_Resp := True;
    TBReport.Caption := 'Stop Report';
    TBReport.Tag := 1;
  end
  else
  begin
    for i := 0 to ThreadN - 1 do
    begin
      TRep(GRepTList[i]).Terminate; //中止线程
    end;
    Send_Resp := False;
    TBReport.Tag := 0;
    TBReport.Caption := 'Start Report';
  end;
end;

procedure TSMGPGateWay.TBDToSClick(Sender: TObject);
var
  ip, Port: string;
  ThreadN, i: integer;
  sleeptime: integer;
  timeout: integer;
begin
  readMoport(Port, ThreadN, sleeptime);
  if TBDToS.Tag = 0 then
  begin
    readSerIp(ip, timeout);
{    try
      XMLService.XML.Clear;
      XMLService.LoadFromFile(extractfilepath(application.ExeName) + 'Service.xml');
      if XMLService.Active then XMLService.Active := False;
      XMLService.Active := True;
      Memo3.Lines.Add('【' + datetimetostr(now) + '】加载XML配置文件成功......');
    except
      on E: Exception do
      begin
        Memo3.Lines.Add('【' + datetimetostr(now) + '】加载XML配置文件错误,发送上行短信线程不能创建!');
        exit;
      end;
    end; }
    for i := 0 to ThreadN - 1 do
    begin
      xDeliverThread := TSPDeliverThread.create(ip, Port, sleeptime, timeout); //创建线程
      GDeliverTList.Add(xDeliverThread);
    end;
    Send_Deliver := True;
    TBDToS.Tag := 1;
    TBDToS.Caption := 'Stop  DeliToSer';
  end
  else
  begin
    for i := 0 to ThreadN - 1 do
    try
      TSPDeliverThread(GDeliverTList[i]).Terminate; //中止线程
    except
    end;
    //XMLService.Active := False;
    Send_Deliver := False;
    TBDToS.Tag := 0;
    TBDToS.Caption := 'Start DeliToSer';
  end;
end;

procedure TSMGPGateWay.TBCreateAllClick(Sender: TObject);
begin
  if TBCreateAll.Tag = 0 then //创建
  begin
    if TBSubmitReq.Tag = 0 then
      TBSubmitReq.Click;
    if TBDToS.Tag = 0 then
      TBDToS.Click;
    if TBResponse.Tag = 0 then
      TBResponse.Click;
    if TBReport.Tag = 0 then
      TBReport.Click;
    TBCreateAll.Tag := 1;
    TBCreateAll.Caption := 'Stop ALL';
  end
  else if TBCreateAll.Tag = 1 then //停止
  begin
    if TBSubmitReq.Tag = 1 then
      TBSubmitReq.Click;
    if TBResponse.Tag = 1 then
      TBResponse.Click;
    if TBReport.Tag = 1 then
      TBReport.Click;
    if TBDToS.Tag = 1 then
      TBDToS.Click;
    TBCreateAll.Tag := 0;
    TBCreateAll.Caption := 'CreateAll';
  end;
end;

procedure TSMGPGateWay.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := False;
  if DCanExit and SCanExit then
    CanClose := True
  else
  begin
    messagebox(handle, '连接未中断，请先断开与电信的连接', '警告', mb_ok + MB_ICONWARNING);
    exit;
  end;
  if Send_Deliver then
  begin
    showmessage('往中间层发送短信线程没停止，不能退出'); CanClose := False; exit; end;
  if SubmitRequest then
  begin
    showmessage('请求下行短信线程没停止，不能退出'); CanClose := False; exit; end;
  if Send_Resp then
  begin
    showmessage('往中间层发送回馈报告线程没停止，不能退出'); CanClose := False; exit; end;
  if Send_Report then
  begin
    showmessage('往中间层发送递送报告线程没停止，不能退出'); CanClose := False; exit; end;

  if not counteList then
  begin
    if application.messagebox('缓冲区队列有数据未发送，如果要强行退出系统请保存数据！', '提示', mb_okCancel + MB_ICONWARNING) = 2 then
    begin
      CanClose := False;
      exit;
    end
    else
    begin
      //把下行的短信写入数据表中
      CanClose := False;
      n37.Enabled:=True;
      SaveMessage := TSaveMessage.create;
      exit;
    end;
  end;
  if LogList.Count = 0 then
  begin
    xWriteLog.Terminate;
    Sleep(100);
    CanClose := True;
  end
  else
  begin
    messagebox(handle, '日志没有写完，不能退出程序', '警告', mb_ok + MB_ICONWARNING);
    CanClose := False;
  end;
end;

{function GetSequenceID(const DestTermID, instructor: string): word;
var
  i: integer;
  ValueNode: IXMLNode; //根节点
  NextNode: IXMLNode; //业务节点
  s: string; //配置中服务代码
  SpNumber: string; //用户发送的目的号码
  TY: Boolean;
  j: integer;
begin
  Result := 0;
  TY := False;
  SpNumber := AnsiUpperCase(Trim(DestTermID)); //用户发送的目的号码
  try
    ValueNode := SMGPGateWay.XMLService.ChildNodes['Service']; //'Service节点'
    for i := 0 to ValueNode.ChildNodes.Count - 1 do //业务节点数
    begin
      NextNode := ValueNode.ChildNodes[i]; //各业务节点
      s := AnsiUpperCase(NextNode.ChildNodes['SPNumber'].Text);
      if NextNode.ChildNodes['Extend'].Text = '0' then //特服号精确匹配
      begin
        if s = SpNumber then
        begin //节点找到
          Result := strtoint(NextNode.ChildNodes['SequenceID'].Text);
          exit;
        end;
      end
      else if NextNode.ChildNodes['Extend'].Text = '1' then
      begin //特服号模糊匹配
        if AnsiStartsText(s, SpNumber) then
        begin
          Result := strtoint(NextNode.ChildNodes['SequenceID'].Text);
          exit;
        end
      end
      else if NextNode.ChildNodes['Extend'].Text = '2' then
      begin
        if s = SpNumber then
          if AnsiStartsText(NextNode.ChildNodes['Instructor'].Text, instructor) then
          begin
            Result := strtoint(NextNode.ChildNodes['SequenceID'].Text);
            exit;
          end
      end
      else if NextNode.ChildNodes['Extend'].Text = '5' then
      begin
        if AnsiStartsText(s, SpNumber) then //指令和特服号双重匹配(特服号,指令模糊匹配)
          if AnsiStartsText(NextNode.ChildNodes['Instructor'].Text, instructor) then
          begin
            Result := strtoint(NextNode.ChildNodes['SequenceID'].Text);
            exit;
          end
      end
      else if NextNode.ChildNodes['Extend'].Text = '3' then
      begin
        if s = SpNumber then
        begin //该节点找到特服号 指令和特服号双重匹配
          if CompareText(NextNode.ChildNodes['Instructor'].Text, instructor) = 0 then
          begin //定购指令
            Result := strtoint(NextNode.ChildNodes['SequenceID'].Text);
            exit;
          end
          else if CompareText(NextNode.ChildNodes['Enter'].Text, instructor) = 0 then
          begin //二次确认指令
            Result := strtoint(NextNode.ChildNodes['SequenceID'].Text);
            exit;
          end
          else if CompareText(NextNode.ChildNodes['QXInstructor'].Text, instructor) = 0 then
          begin //取消指令
            Result := strtoint(NextNode.ChildNodes['SequenceID'].Text);
            exit;
          end;
        end
      end
      else if NextNode.ChildNodes['Extend'].Text = '4' then //通用指令
        if s = SpNumber then //特服号精确匹配
        begin
          if CompareText(instructor, NextNode.ChildNodes['Instructor40'].Text) = 0 then //0000
            TY := True
          else if CompareText(instructor, NextNode.ChildNodes['Instructor50'].Text) = 0 then //00000
            TY := True
          else if AnsiStartsText(NextNode.ChildNodes['InstructorQ'].Text, instructor) then //Q模糊匹配
          begin
            if length(instructor) >= 2 then
            begin
              for j := 2 to length(instructor) do
              begin
                if not (instructor[2] in ['1'..'9']) then //第一为必须是1..9
                  break;
                if not (instructor[j] in ['0'..'9']) then //Q指令后带的不是是数字0..9
                  break;
              end;
              if j > length(instructor) then
                TY := True;
            end
            else //Q指令
            begin
              TY := True;
            end;
          end
          else if CompareText(instructor, NextNode.ChildNodes['InstructorNO'].Text) = 0 then //1186185
            TY := True
          else
          begin
            if ord(instructor[1]) = 163 then //中文的问号？
            begin
              if length(instructor) = 2 then
                TY := True;
            end
            else if CompareText(instructor, NextNode.ChildNodes['InstructorHelp'].Text) = 0 then //?
              TY := True;
          end;
          if TY then
          begin
            Result := strtoint(NextNode.ChildNodes['SequenceID'].Text);
            exit;
          end;
        end;
    end;
  except
    on E: Exception do
      SMGPGateWay.Memo3.Lines.Add(E.message);
  end;
  if Result = 0 then //如果没找到业务,发送到客服队列中
  begin
    NextNode := ValueNode.ChildNodes['KF'];
    Result := strtoint(NextNode.ChildNodes['SequenceID'].Text);
  end;
end; }
procedure AddDSeq;
begin
  if dSequence >= 4294967200 then dSequence := 0;
  dSequence := dSequence + 1;
end;
procedure TSMGPGateWay.N2Click(Sender: TObject);
begin
  N2.Checked := not N2.Checked;
end;

procedure TSMGPGateWay.N3Click(Sender: TObject);
begin
  N3.Checked := not N3.Checked;
end;

procedure TSMGPGateWay.N4Click(Sender: TObject);
begin
  N4.Checked := N4.Checked;
end;

procedure TSMGPGateWay.ToolButton15Click(Sender: TObject);
begin
  {  if ToolButton15.Tag = 0 then begin
      ToolButton15.Tag := 1;
      ToolButton15.Caption := 'Stop ReTry';
    end
    else begin
      ToolButton15.Tag := 0;
      ToolButton15.Caption := 'StartReTry';
    end; }

end;
procedure TSMGPGateWay.ToolButton8Click(Sender: TObject);
begin
  close;
end;

procedure TSMGPGateWay.ToolButton1Click(Sender: TObject);
begin
  FSysConfig.ShowModal;
end;
procedure TSMGPGateWay.ToolButton17Click(Sender: TObject);
begin
  GW_MT.Show;
end;

procedure TSMGPGateWay.MOExit1Click(Sender: TObject);
begin
  MOExit := True; //中止上行线程
  MOExit1.Enabled := False;
  MOLogin1.Enabled := True;
  if (not MOExit1.Enabled) and (not MTExit1.Enabled) then
    AllLogin1.Enabled := True;
end;

procedure TSMGPGateWay.MTExit1Click(Sender: TObject);
begin
  MTExit := True; //中止上行线程
  MTExit1.Enabled := False;
  MTLogin1.Enabled := True;
  if (not MOExit1.Enabled) and (not MTExit1.Enabled) then
    AllLogin1.Enabled := True;
end;

procedure TSMGPGateWay.AllExit1Click(Sender: TObject);
begin
  MOExit := True; //中止上行线程
  MTExit := True; //中止上行线程
  AllExit1.Enabled := False;
  MTExit1.Enabled := False;
  MOExit1.Enabled := False;
  AllLogin1.Enabled := True;
  MTLogin1.Enabled := True;
  MOLogin1.Enabled := True;
end;

procedure TSMGPGateWay.AllLogin1Click(Sender: TObject);
var
  loginmode1, connectmode1: string;
  loginmode2, connectmode2: string;
  timeout, sleeptime, resptime, sendtimes: integer;
begin
 // readLogParam(ServerIP, Port, ClientID, sharesecret);
  readLogParam2(loginmode2, connectmode2);
  readLogParam1(loginmode1, connectmode1);
  timeout := strtoint(Trim(FSysConfig.Edit1.Text));
  sleeptime := strtoint(Trim(FSysConfig.Edit6.Text));
  ReadTimes(resptime, sendtimes);
  try
    xTCPCTDeliver := TCPCTDeliver.create(ServerIP, Port, ClientID, sharesecret, sleeptime,
      timeout, strtoint(loginmode1));
  except
  end;
  try
    xCPSubmit := TCPSubmit.create(ServerIP, Port, ClientID, sharesecret, sleeptime,
      timeout, resptime, sendtimes, strtoint(loginmode2));
  except
  end;
  MOExit := False;
  MTExit := False;
  AllLogin1.Enabled := False;
  MTLogin1.Enabled := False;
  MOLogin1.Enabled := False;
  AllExit1.Enabled := True;
  MOExit1.Enabled := True;
  MTExit1.Enabled := True;
  Label8.Caption := '';
  Label9.Caption := '';
end;

procedure TSMGPGateWay.MTLogin1Click(Sender: TObject);
var
  loginmode2, connectmode2: string;
  timeout, sleeptime, resptime, sendtimes: integer;
begin
  readLogParam2(loginmode2, connectmode2);
  ReadTimes(resptime, sendtimes);
  timeout := strtoint(Trim(FSysConfig.Edit1.Text));
  sleeptime := strtoint(Trim(FSysConfig.Edit6.Text));
  try
    xCPSubmit := TCPSubmit.create(ServerIP, Port, ClientID, sharesecret, sleeptime,
      timeout, resptime, sendtimes, strtoint(loginmode2));
  except
  end;
  MTLogin1.Enabled := False;
  AllLogin1.Enabled := False;
  MTExit1.Enabled := True;
  if not MOLogin1.Enabled then
    AllExit1.Enabled := True;
  Label8.Caption := '';
end;

procedure TSMGPGateWay.MOLogin1Click(Sender: TObject);
var
  loginmode1, connectmode1: string;
  timeout, sleeptime: integer;
begin
  readLogParam1(loginmode1, connectmode1);
  timeout := strtoint(Trim(FSysConfig.Edit1.Text));
  sleeptime := strtoint(Trim(FSysConfig.Edit6.Text));
  try
    xTCPCTDeliver := TCPCTDeliver.create(ServerIP, Port, ClientID, sharesecret, sleeptime,
      timeout, strtoint(loginmode1));
  except
  end;
  MOLogin1.Enabled := False;
  AllLogin1.Enabled := False;
  MOExit1.Enabled := True;
  if not MTLogin1.Enabled then
    AllExit1.Enabled := True;
  Label9.Caption := '';
end;

procedure TSMGPGateWay.ToolButton6Click(Sender: TObject);
begin
  if ToolButton6.Tag = 0 then
  begin
    try
      GWMoniter := GWWarnning.create;
      ToolButton6.Tag := 1;
      ToolButton6.Caption := '关闭监控';
    except
    end;
  end
  else
  begin
    try
      GWMoniter.Terminate;
      ToolButton6.Tag := 0;
      ToolButton6.Caption := '线程监控';
    except
    end;
  end;
end;

procedure TSMGPGateWay.Memo11Click(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TSMGPGateWay.Memo21Click(Sender: TObject);
begin
  Memo2.Clear;
end;

procedure TSMGPGateWay.Memo31Click(Sender: TObject);
begin
  Memo3.Clear;
end;

procedure TSMGPGateWay.createParams(var Params: TCreateParams);
begin
  inherited createParams(Params);
  Params.WinClassName := WZGL_APP_NAME;
end;

procedure TSMGPGateWay.RestoreRequest(var message: TMessage);
begin
  if IsIconic(application.handle) = True then
    application.Restore
  else
    application.BringToFront;
end;

procedure TSMGPGateWay.CheckBox2Click(Sender: TObject);
begin
  Memo1.WordWrap := CheckBox2.Checked;
  Memo2.WordWrap := CheckBox2.Checked;
  if CheckBox2.Checked then
  begin
    Memo1.ScrollBars := ssVertical;
    Memo2.ScrollBars := ssVertical;
  end
  else
  begin
    Memo1.ScrollBars := ssBoth;
    Memo2.ScrollBars := ssBoth;
  end;
end;

procedure TSMGPGateWay.ToolButton16Click(Sender: TObject);
var
  sleeptime, logNumber: integer;
  udpsrvip: string;
  udpport: integer;
  autowrite: Boolean;
begin
  if not WriteLog_Free then
  begin
    xWriteLog.Terminate;
    ToolButton16.Caption := '重启日志';
  end
  else
  begin
    readlogth(udpsrvip, udpport, logNumber, sleeptime, autowrite);
    xWriteLog := WriteLog.create(udpsrvip, udpport, sleeptime);
    ToolButton16.Enabled := False;
    ToolButton16.Caption := '停写日志';
  end;
end;

procedure TSMGPGateWay.RzBitBtn1Click(Sender: TObject);
var
  Cou1, cou2, cou3, cou4, Cou5, cou6: integer;
  aList: Tlist;
begin
  aList := DeliverList.LockList;
  try
    Cou1 := aList.Count;
  finally
    DeliverList.UnlockList;
  end;
  aList := SubmitList.LockList;
  try
    cou2 := aList.Count;
  finally
    SubmitList.UnlockList;
  end;
  aList := ResponseList.LockList;
  try
    cou3 := aList.Count;
  finally
    ResponseList.UnlockList;
  end;
  aList := ReportList.LockList;
  try
    cou4 := aList.Count;
  finally
    ReportList.UnlockList;
  end;
  Cou5 := LogList.Count;
  aList := SaveSubmitList.LockList;
  try
    cou6 := aList.Count;
  finally
    SaveSubmitList.UnlockList;
  end;
  Edit1.Text := inttostr(Cou1);
  Edit2.Text := inttostr(cou2);
  Edit3.Text := inttostr(cou3);
  Edit4.Text := inttostr(cou4);
  Edit5.Text := inttostr(Cou5);
  Edit6.Text := inttostr(cou6);
end;

procedure TSMGPGateWay.RzBitBtn2Click(Sender: TObject);
begin
  Memo1.Clear;
  Memo2.Clear;
  if Memo3.Lines.Count > 10000 then
    Memo3.Clear;
end;

procedure TSMGPGateWay.RzBitBtn3Click(Sender: TObject);
begin
  CTD_cou := 0; //电信上行数
  SPS_cou := 0; //网关下行数
  GDToS_cou := 0; //网关上行短信数
  GRespToS_cou := 0; //网关上行回馈报告数
  GRepToS_cou := 0; //网关上行递送报告数
  SToG_cou := 0; //中间层下发短信数
end;

procedure TSMGPGateWay.N15Click(Sender: TObject);
var
  timeout, sleeptime, resptime, sendtimes: integer;
begin
  ReadTimes(resptime, sendtimes);
  timeout := strtoint(Trim(FSysConfig.Edit1.Text));
  sleeptime := strtoint(Trim(FSysConfig.Edit6.Text));
  xTransmit := TTransmit.create(ServerIP, Port, ClientID, sharesecret, sleeptime,
    timeout, resptime, sendtimes, 2);
  Label9.Caption:='';
  Label8.Caption:='';
end;

procedure TSMGPGateWay.N17Click(Sender: TObject);
begin
  if not TransmitExit then
    TransmitExit := True;
end;

procedure TSMGPGateWay.N34Click(Sender: TObject);
begin
  GW_MT.Show;
end;

procedure TSMGPGateWay.N37Click(Sender: TObject);
begin
   SaveSubmitList.Clear;
end;

procedure TSMGPGateWay.SpeedButton1Click(Sender: TObject);
begin
  AccessNoStrList.Clear;
  AccessNoStrList.LoadFromFile(ExtractFilePath(application.ExeName) + 'AccessNo.txt');
end;

procedure TSMGPGateWay.SpeedButton2Click(Sender: TObject);
begin
  F_DeliverTest.Show;
end;

end.

