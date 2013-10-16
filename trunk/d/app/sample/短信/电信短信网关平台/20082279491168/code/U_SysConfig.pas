{***************************************************
                   参数配置单元
                    Author:LUOXINXI
                     Datetime:2004/3/11
***************************************************}
unit U_SysConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzTabs, Buttons, ComCtrls, inifiles, RzLine, mmsystem,
  ExtCtrls, RzButton, Mask, RzEdit, RzSpnEdt;

type
  TFSysConfig = class(TForm)
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    GroupBox1: TGroupBox;
    TMTCom: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    TMTSeq: TEdit;
    TSta: TEdit;
    Label11: TLabel;
    GroupBox2: TGroupBox;
    TSPID: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    TSC: TEdit;
    TCTIP: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    TCTPort: TEdit;
    GroupBox3: TGroupBox;
    Label15: TLabel;
    Label17: TLabel;
    TSerIP: TEdit;
    CBTimeout: TComboBox;
    GroupBox4: TGroupBox;
    Edit1: TEdit;
    Label16: TLabel;
    Label18: TLabel;
    Edit2: TEdit;
    CheckBox1: TCheckBox;
    Label7: TLabel;
    ERetry: TEdit;
    Label8: TLabel;
    Label19: TLabel;
    TRespSeq: TEdit;
    TabSheet2: TRzTabSheet;
    TMOSeq: TEdit;
    Label6: TLabel;
    TVision: TEdit;
    Label33: TLabel;
    TMOCom: TEdit;
    Label34: TLabel;
    TRespCom: TEdit;
    Label35: TLabel;
    TReportSeq: TEdit;
    Label36: TLabel;
    TReCom: TEdit;
    TabSheet4: TRzTabSheet;
    GroupBox5: TGroupBox;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    RzLine1: TRzLine;
    RzLine2: TRzLine;
    RzLine3: TRzLine;
    Label41: TLabel;
    RzLine4: TRzLine;
    Label42: TLabel;
    RzLine5: TRzLine;
    Label43: TLabel;
    Label44: TLabel;
    RzLine6: TRzLine;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    RzLine7: TRzLine;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    CheckBox2: TCheckBox;
    GroupBox6: TGroupBox;
    Label51: TLabel;
    Edit3: TEdit;
    Label52: TLabel;
    Edit11: TEdit;
    UpDown2: TUpDown;
    GroupBox7: TGroupBox;
    Label58: TLabel;
    Label59: TLabel;
    CBLoginMode1: TComboBox;
    ConnectMode1: TComboBox;
    Label61: TLabel;
    EClientID: TEdit;
    Label60: TLabel;
    HVision: TEdit;
    GroupBox8: TGroupBox;
    Label5: TLabel;
    CBLoginMode: TComboBox;
    ConnectMode: TComboBox;
    Label20: TLabel;
    GroupBox9: TGroupBox;
    Label21: TLabel;
    TCTDeliverN: TEdit;
    Label27: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label28: TLabel;
    Label29: TLabel;
    Edit7: TEdit;
    Edit8: TEdit;
    Label30: TLabel;
    Label31: TLabel;
    Edit9: TEdit;
    Edit10: TEdit;
    Label32: TLabel;
    EReport: TEdit;
    TResponse: TEdit;
    TSubmitRes: TEdit;
    TSPsubmitN: TEdit;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label54: TLabel;
    EDSeq: TEdit;
    Label55: TLabel;
    ESSeq: TEdit;
    TabSheet5: TRzTabSheet;
    Label53: TLabel;
    Edit4: TEdit;
    Label56: TLabel;
    Edit12: TEdit;
    Label57: TLabel;
    Edit13: TEdit;
    OpenDialog1: TOpenDialog;
    OpenDialog2: TOpenDialog;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Label63: TLabel;
    Edit14: TEdit;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    OpenDialog3: TOpenDialog;
    GroupBox10: TGroupBox;
    Label65: TLabel;
    ERespTime: TEdit;
    Label66: TLabel;
    ESendCou: TEdit;
    Label67: TLabel;
    SpeedButton12: TSpeedButton;
    Label68: TLabel;
    Edit15: TEdit;
    GroupBox11: TGroupBox;
    CheckBox3: TCheckBox;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    EIP: TEdit;
    EPort: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    CheckBox4: TCheckBox;
    SpeedButton6: TSpeedButton;
    SpeedButton13: TSpeedButton;
    Label14: TLabel;
    TMTPort: TEdit;
    Label12: TLabel;
    TMOPort: TEdit;
    Label13: TLabel;
    TRePort: TEdit;
    Label74: TLabel;
    CheckBox5: TCheckBox;
    RzBitBtn1: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    RzBitBtn3: TRzBitBtn;
    RzBitBtn4: TRzBitBtn;
    RzBitBtn5: TRzBitBtn;
    RzBitBtn6: TRzBitBtn;
    GroupBox12: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    GroupBox13: TGroupBox;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit16: TEdit;
    Bevel1: TBevel;
    Bevel2: TBevel;
    GroupBox14: TGroupBox;
    CheckBox6: TCheckBox;
    Label78: TLabel;
    RzSpinEdit1: TRzSpinEdit;
    Label79: TLabel;
    Label80: TLabel;
    RzSpinEdit2: TRzSpinEdit;
    Label81: TLabel;
    Edit17: TEdit;
    TSPDeliverN: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure RzBitBtn3Click(Sender: TObject);
    procedure RzBitBtn4Click(Sender: TObject);
    procedure RzBitBtn5Click(Sender: TObject);
    procedure RzBitBtn6Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure IPEditKeyPress(Sender: TObject; var Key: Char);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
  end;

var
  FSysConfig: TFSysConfig;
  udpsrvip: string;
  udpport: integer;


procedure readLogParam(var ServerIP, Port, clientID, sharesecret, SPID: string); {登陆电信参数}
procedure writeLogParam(const ServerIP, Port, clientID, sharesecret, SPID: string);
procedure readLogParam1(var Loginmode, ConnectMode: string); {登陆电信参数,MO}
procedure writeLogParam1(const Loginmode, ConnectMode: string);
procedure readLogParam2(var Loginmode, ConnectMode: string); {登陆电信参数,MT}
procedure writeLogParam2(const Loginmode, ConnectMode: string);
procedure writevision(const vision: byte; const RetryTime: integer;const GateID:string);
procedure readvision(var vision: byte);

procedure readRetryTime(var RetryTime: integer);
procedure readProto(var Status_ID, Version: string; var Response: Boolean);
procedure writeProto(const Status_ID, Version: string; const Response: Boolean);
procedure writeseq(const Mtseq, Moseq, RespSeq, RepSeq, questC_ID, sendC_ID: word); {写队列和命令字}
{读取业务对应的中间服务器队列命令字}
procedure readsequence(var Mtseq, Moseq, RespSeq, RepSeq, questC_ID, sendC_ID: word);
procedure readDsequence(var DeliverSequence, Command_ID: word); {发送上行短信队列和命令字}
procedure readSsequence(var Sequence_ID, Command_ID: word); {请求下行短信队列和命令字}
procedure readRespsequence(var Sequence_ID, Command_ID: word); {发送回馈报告队列和命令字}
procedure readRepsequence(var Sequence_ID, Command_ID: word); {发送递送报告}
{读取登陆服务器参数}
procedure readSerIp(var ip: string; var timeout: integer); {ip地址}
procedure readport(var MTport, Moport, Report,iGateID: string); {端口}
{读取业务对应的登陆服务器的端口号}
procedure readMTport(var Port: string; var SubmitReqN, SReqsleep: integer); {请求下行短信端口、线程数和时间}
procedure readMoport(var Port: string; var SpdeliverN, SpDsleep: integer); {发送上行短信端口、线程数和时间}
procedure readRepport(var Port: string; var ReportN, Repsleep: integer); {递送报告端口、线程数和时间}
procedure readRespport(var Port: string; var ResponseN, Respsleep: integer); {回馈报告端口、线程数和时间}
procedure writeServer(const ip, MTport, Moport, Report: string; const timeout: integer);
{线程数}
procedure readThread(var CTDeliverN, SpsubmitN, SpdeliverN, SubmitReqN, ResponseN, ReportN: integer; var CTDsleep, Spssleep, SpDsleep, SReqsleep, Respsleep, Repsleep: integer);
procedure writeThread(const CTDeliverN, SpsubmitN, SpdeliverN, SubmitReqN, ResponseN, ReportN: integer; const CTDsleep, Spssleep, SpDsleep, SReqsleep, Respsleep, Repsleep: integer);
procedure readCTDNumber(var CTDeliverN, CTDsleep: integer); {电信上行}
procedure readSPSNumber(var SpsubmitN, Spssleep: integer); {下行到电信}
procedure readlogth(var udpsrvip: string; var Port, Threadnumber, sleeptime: integer; var autowrite: Boolean);
procedure writeudp(const udpsrvip: string; const Port: integer);
procedure writelogth(const Threadnumber, sleeptime: integer; const autowirte: Boolean);
{sequenceID}
procedure readsequID(var dsequenceID, ssequenceID: integer);
procedure writesequID(const dsequenceID, ssequenceID: integer);
procedure readtime(var activetime, timeout: integer);
procedure writetime(const activetime, timeout: integer);
{warnning}
procedure readfile(var filename1, filename2, filename3: string; var n: integer);
procedure writefile(const filename1, filename2, filename3: string; const n: integer);

procedure readtimes(var resptime, sendcou: integer);
procedure writetimes(const resptime, sendcou: integer);

procedure ReadAppTitle(var Title: string);
implementation
uses NetDisconnect, u_main;
{$R *.dfm}
procedure ReadAppTitle(var Title: string);
var
  inifile: Tinifile;
  Inifilename: string;
begin
  Inifilename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(Inifilename);
    Title := inifile.ReadString('ApplicationTitle', 'TitleStr', '');
  finally
    inifile.Free;
  end;
end;
procedure readLogParam(var ServerIP, Port, clientID, sharesecret, SPID: string);
var
  inifile: Tinifile;
  Inifilename: string;
begin
  Inifilename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(Inifilename);
    clientID := inifile.ReadString('Loginparams', 'ClientID', '');
    ServerIP := inifile.ReadString('loginparams', 'ServerIP', '');
    Port := inifile.ReadString('loginparams', 'ServerPort', '');
    sharesecret := inifile.ReadString('loginparams', 'sharesecret', '');
    SPID := inifile.ReadString('loginparams', 'SPID', '');
  finally
    inifile.Free;
  end;
end;
procedure writeLogParam(const ServerIP, Port, clientID, sharesecret, SPID: string);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    inifile.WriteString('Loginparams', 'ServerIP', ServerIP);
    inifile.WriteString('Loginparams', 'ServerPort', Port);
    inifile.WriteString('Loginparams', 'ClientID', clientID);
    inifile.WriteString('Loginparams', 'sharesecret', sharesecret);
    inifile.WriteString('Loginparams', 'SPID', SPID);
  finally
    inifile.Free;
  end;
end;
procedure readLogParam1(var Loginmode, ConnectMode: string);
var
  inifile: Tinifile;
  Inifilename: string;
begin
  Inifilename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(Inifilename);
    Loginmode := inifile.ReadString('loginparams1', 'Loginmode', '');
    ConnectMode := inifile.ReadString('loginparams1', 'connectmode', '');
  finally
    inifile.Free;
  end;
end;
procedure writeLogParam1(const Loginmode, ConnectMode: string);
var
  inifile: Tinifile;
  Inifilename: string;
begin
  Inifilename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(Inifilename);
    inifile.WriteString('loginparams1', 'Loginmode', Loginmode);
    inifile.WriteString('loginparams1', 'connectmode', ConnectMode);
  finally
    inifile.Free;
  end;
end;
procedure readLogParam2(var Loginmode, ConnectMode: string); {登陆电信参数}
var
  inifile: Tinifile;
  Inifilename: string;
begin
  Inifilename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(Inifilename);
    Loginmode := inifile.ReadString('loginparams2', 'Loginmode', '');
    ConnectMode := inifile.ReadString('loginparams2', 'connectmode', '');
  finally
    inifile.Free;
  end;
end;
procedure writeLogParam2(const Loginmode, ConnectMode: string);
var
  inifile: Tinifile;
  Inifilename: string;
begin
  Inifilename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(Inifilename);
    inifile.WriteString('loginparams2', 'Loginmode', Loginmode);
    inifile.WriteString('loginparams2', 'connectmode', ConnectMode);
  finally
    inifile.Free;
  end;
end;
procedure readvision(var vision: byte);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    vision := inifile.ReadInteger('Loginparams', 'vision', vision);
  finally
    inifile.Free;
  end;
end;
procedure writevision(const vision: byte; const RetryTime: integer;const GateID:string);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    inifile.WriteInteger('Loginparams', 'vision', vision);
    inifile.WriteInteger('time', 'retryTime', RetryTime);
    inifile.WriteString('Protocal','GateID',GateID);
  finally
    inifile.Free;
  end;
end;
procedure readRetryTime(var RetryTime: integer);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    RetryTime := inifile.ReadInteger('time', 'retryTime', 1000);
  finally
    inifile.Free;
  end;
end;
procedure readProto(var Status_ID, Version: string; var Response: Boolean);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  inifile := Tinifile.Create(filename);
  try
    Status_ID := inifile.ReadString('protocal', 'Status_ID', '');
    Version := inifile.ReadString('protocal', 'Version', '');
    Response := inifile.ReadBool('protocal', 'Response', true);
  finally
    inifile.Free;
  end;
end;
procedure readsequence(var Mtseq, Moseq, RespSeq, RepSeq, questC_ID, sendC_ID: word);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  inifile := Tinifile.Create(filename);
  try
    Moseq := inifile.ReadInteger('SequenceID', 'DSequence_ID', 0);
    Mtseq := inifile.ReadInteger('SequenceID', 'SSequence_ID', 0);
    RespSeq := inifile.ReadInteger('SequenceID', 'RespSequence_ID', 0);
    RepSeq := inifile.ReadInteger('SequenceID', 'ReportSequence_ID', 0);
    questC_ID := inifile.ReadInteger('Command_ID', 'questCommand_ID', 0);
    sendC_ID := inifile.ReadInteger('Command_ID', 'sendCommand_ID', 0);
    //User_F_S_SeqID := inifile.ReadInteger('SequenceID', 'User_F_S_SeqID', 0);
    //DefSquence := inifile.ReadInteger('SequenceID', 'DefSequence_ID', 0)
  finally
    inifile.Free;
  end;
end;

procedure readDsequence(var DeliverSequence,  Command_ID: word);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  inifile := Tinifile.Create(filename);
  try
    DeliverSequence := inifile.ReadInteger('SequenceID', 'DSequence_ID', 2400);
    //User_F_S_SeqID := inifile.ReadInteger('SequenceID', 'User_F_S_SeqID', 2799);
   // defsequence := inifile.ReadInteger('SequenceID', 'DefSequence_ID', 2798);
    Command_ID := inifile.ReadInteger('Command_ID', 'sendCommand_ID', 0);
  finally
    inifile.Free;
  end;
end;
procedure readSsequence(var Sequence_ID, Command_ID: word);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  inifile := Tinifile.Create(filename);
  try
    Sequence_ID := inifile.ReadInteger('SequenceID', 'SSequence_ID', 0);
    Command_ID := inifile.ReadInteger('Command_ID', 'questCommand_ID', 0);
  finally
    inifile.Free;
  end;
end;
procedure readRespsequence(var Sequence_ID, Command_ID: word);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  inifile := Tinifile.Create(filename);
  try
    Sequence_ID := inifile.ReadInteger('SequenceID', 'RespSequence_ID', 0);
    Command_ID := inifile.ReadInteger('Command_ID', 'sendCommand_ID', 0);
  finally
    inifile.Free;
  end;
end;

procedure readRepsequence(var Sequence_ID, Command_ID: word);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  inifile := Tinifile.Create(filename);
  try
    Sequence_ID := inifile.ReadInteger('SequenceID', 'ReportSequence_ID', 0);
    Command_ID := inifile.ReadInteger('Command_ID', 'sendCommand_ID', 0);
  finally
    inifile.Free;
  end;
end;
procedure writeProto(const Status_ID, Version: string; const Response: Boolean);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    inifile.WriteString('protocal', 'Status_ID', Status_ID);
    inifile.WriteString('protocal', 'Version', Version);
    inifile.WriteBool('protocal', 'Response', Response);
  finally
    inifile.Free;
  end;
end;
procedure writeseq(const Mtseq, Moseq, RespSeq, RepSeq, questC_ID, sendC_ID: word);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    inifile.WriteInteger('SequenceID', 'DSequence_ID', Moseq);
    inifile.WriteInteger('SequenceID', 'SSequence_ID', Mtseq);
    inifile.WriteInteger('SequenceID', 'RespSequence_ID', RespSeq);
    inifile.WriteInteger('SequenceID', 'ReportSequence_ID', RepSeq);
    inifile.WriteInteger('Command_ID', 'questCommand_ID', questC_ID);
    inifile.WriteInteger('Command_ID', 'sendCommand_ID', sendC_ID);
  finally
    inifile.Free;
  end;
end;
procedure readSerIp(var ip: string; var timeout: integer);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    ip := inifile.ReadString('Socket', 'IPaddress', '');
    timeout := inifile.ReadInteger('Socket', 'Timeout', 5000);
  finally
    inifile.Free;
  end;
end;
procedure readport(var MTport, Moport, Report, iGateID: string);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    Moport := inifile.ReadString('port', 'MOPort', '');
    MTport := inifile.ReadString('port', 'MTPort', '');
    Report := inifile.ReadString('port', 'RePort', '');
    iGateID := inifile.ReadString('Protocal', 'GateID', '');
  finally
    inifile.Free;
  end;
end;
{读取业务对应的登陆服务器的端口号}
procedure readMTport(var Port: string; var SubmitReqN, SReqsleep: integer);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    Port := inifile.ReadString('port', 'MTPort', '');
    SubmitReqN := inifile.ReadInteger('ThreadNumber', 'SubmitReqN', 1);
    SReqsleep := inifile.ReadInteger('Threadsleeptime', 'SubmitReq', 1);
  finally
    inifile.Free;
  end;
end;
procedure readMoport(var Port: string; var SpdeliverN, SpDsleep: integer);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    Port := inifile.ReadString('port', 'MOPort', '');
    SpdeliverN := inifile.ReadInteger('ThreadNumber', 'SpdeliverN', 1);
    SpDsleep := inifile.ReadInteger('Threadsleeptime', 'Spdeliver', 1);
  finally
    inifile.Free;
  end;
end;
procedure readRepport(var Port: string; var ReportN, Repsleep: integer);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    Port := inifile.ReadString('port', 'RePort', '');
    ReportN := inifile.ReadInteger('ThreadNumber', 'ReportN', 1);
    Repsleep := inifile.ReadInteger('Threadsleeptime', 'Report', 1);
  finally
    inifile.Free;
  end;
end;
procedure readRespport(var Port: string; var ResponseN, Respsleep: integer);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    Port := inifile.ReadString('port', 'RePort', '');
    ResponseN := inifile.ReadInteger('ThreadNumber', 'ResponseN', 1);
    Respsleep := inifile.ReadInteger('Threadsleeptime', 'Response', 1);
  finally
    inifile.Free;
  end;
end;
procedure writeServer(const ip, MTport, Moport, Report: string; const timeout: integer);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    inifile.WriteString('socket', 'IPaddress', ip);
    inifile.WriteInteger('socket', 'timeout', timeout);
    inifile.WriteString('port', 'MTport', MTport);
    inifile.WriteString('port', 'Moport', Moport);
    inifile.WriteString('port', 'Report', Report);
  finally
    inifile.Free;
  end;
end;
procedure readThread(var CTDeliverN, SpsubmitN, SpdeliverN, SubmitReqN, ResponseN, ReportN: integer;
  var CTDsleep, Spssleep, SpDsleep, SReqsleep, Respsleep, Repsleep: integer);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    CTDeliverN := inifile.ReadInteger('ThreadNumber', 'CTDeliverN', 1); {接收电信上行线程数}
    SpsubmitN := inifile.ReadInteger('ThreadNumber', 'SpsubmitN', 1); {下发到电信线程数}
    SpdeliverN := inifile.ReadInteger('ThreadNumber', 'SpdeliverN', 1); {上行到中间服务器线程数}
    SubmitReqN := inifile.ReadInteger('ThreadNumber', 'SubmitReqN', 1); {请求下行短信线程数}
    ResponseN := inifile.ReadInteger('ThreadNumber', 'ResponseN', 1); {发送回馈报告到中间服务器线程数}
    ReportN := inifile.ReadInteger('ThreadNumber', 'ReportN', 1); {发送递送报告到中间服务器线程数}

    CTDsleep := inifile.ReadInteger('Threadsleeptime', 'CTDeliver', 1);
    Spssleep := inifile.ReadInteger('Threadsleeptime', 'Spsubmit', 1);
    SpDsleep := inifile.ReadInteger('Threadsleeptime', 'Spdeliver', 1);
    SReqsleep := inifile.ReadInteger('Threadsleeptime', 'SubmitReq', 1);
    Respsleep := inifile.ReadInteger('Threadsleeptime', 'Response', 1);
    Repsleep := inifile.ReadInteger('Threadsleeptime', 'Report', 1);
  finally
    inifile.Free;
  end;
end;
procedure writeThread(const CTDeliverN, SpsubmitN, SpdeliverN, SubmitReqN, ResponseN, ReportN: integer;
  const CTDsleep, Spssleep, SpDsleep, SReqsleep, Respsleep, Repsleep: integer);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    inifile.WriteInteger('ThreadNumber', 'CTDeliverN', CTDeliverN); {接收电信上行线程数}
    inifile.WriteInteger('ThreadNumber', 'SpsubmitN', SpsubmitN); {下发到电信线程数}
    inifile.WriteInteger('ThreadNumber', 'SpdeliverN', SpdeliverN); {上行到中间服务器线程数}
    inifile.WriteInteger('ThreadNumber', 'SubmitReqN', SubmitReqN); {请求下行短信线程数}
    inifile.WriteInteger('ThreadNumber', 'ResponseN', ResponseN); {发送回馈报告到中间服务器线程数}
    inifile.WriteInteger('ThreadNumber', 'ReportN', ReportN); {发送递送报告到中间服务器线程数}

    inifile.WriteInteger('Threadsleeptime', 'CTDeliver', CTDsleep);
    inifile.WriteInteger('Threadsleeptime', 'Spsubmit', Spssleep);
    inifile.WriteInteger('Threadsleeptime', 'Spdeliver', SpDsleep);
    inifile.WriteInteger('Threadsleeptime', 'SubmitReq', SReqsleep);
    inifile.WriteInteger('Threadsleeptime', 'Response', Respsleep);
    inifile.WriteInteger('Threadsleeptime', 'Report', Repsleep);
  finally
    inifile.Free;
  end;
end;
procedure readCTDNumber(var CTDeliverN, CTDsleep: integer); {电信上行}
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    CTDeliverN := inifile.ReadInteger('ThreadNumber', 'CTDeliverN', 1); {接收电信上行线程数}
    CTDsleep := inifile.ReadInteger('Threadsleeptime', 'CTDeliver', 1);
  finally
    inifile.Free;
  end;
end;
procedure readSPSNumber(var SpsubmitN, Spssleep: integer); {下行到电信}
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    SpsubmitN := inifile.ReadInteger('ThreadNumber', 'SpsubmitN', 1); {下发到电信线程数}
    Spssleep := inifile.ReadInteger('Threadsleeptime', 'Spsubmit', 1);
  finally
    inifile.Free;
  end;
end;
procedure readlogth(var udpsrvip: string; var Port, Threadnumber, sleeptime: integer; var autowrite: Boolean);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    udpsrvip := inifile.ReadString('UDP', 'ServerIP', '');
    Port := inifile.ReadInteger('UDP', 'port', 8117);
    Threadnumber := inifile.ReadInteger('writelog', 'threadnumber', 1);
    sleeptime := inifile.ReadInteger('writelog', 'sleeptime', 100);
    autowrite := inifile.ReadBool('writelog', 'autowrite', true);
  finally
    inifile.Free;
  end;

end;

procedure writelogth(const Threadnumber, sleeptime: integer; const autowirte: Boolean);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    inifile.WriteInteger('writelog', 'threadnumber', Threadnumber);
    inifile.WriteInteger('writelog', 'sleeptime', sleeptime);
    inifile.WriteBool('writelog', 'autowrite', autowirte);
  finally
    inifile.Free;
  end;
end;
procedure writeudp(const udpsrvip: string; const Port: integer);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    inifile.WriteString('UDP', 'ServerIP', udpsrvip);
    inifile.WriteInteger('UDP', 'port', Port);
  finally
    inifile.Free;
  end;
end;
procedure readsequID(var dsequenceID, ssequenceID: integer);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  inifile := Tinifile.Create(filename);
  try
    dsequenceID := inifile.ReadInteger('CTSequenceID', 'dsequenceID', 1);
    ssequenceID := inifile.ReadInteger('CTSequenceID', 'ssequenceID', 1);
  finally
    inifile.Free;
  end;
end;
procedure writesequID(const dsequenceID, ssequenceID: integer);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  inifile := Tinifile.Create(filename);
  try
    inifile.WriteInteger('CTSequenceID', 'dsequenceID', dsequenceID);
    inifile.WriteInteger('CTSequenceID', 'ssequenceID', ssequenceID);
  finally
    inifile.Free;
  end;
end;
procedure writetime(const activetime, timeout: integer);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    inifile.WriteInteger('time', 'activetime', activetime);
    inifile.WriteInteger('time', 'timeout', timeout);
  finally
    inifile.Free;
  end;
end;

procedure readtime(var activetime, timeout: integer);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    activetime := inifile.ReadInteger('time', 'activetime', 3000);
    timeout := inifile.ReadInteger('time', 'timeout', 3000);
  finally
    inifile.Free;
  end;
end;
procedure readfile(var filename1, filename2, filename3: string; var n: integer);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    filename1 := inifile.ReadString('warn', 'filename1', '');
    filename2 := inifile.ReadString('warn', 'filename2', '');
    filename3 := inifile.ReadString('warn', 'filename3', '');
    n := inifile.ReadInteger('warn', 'n', 10);
  finally
    inifile.Free;
  end;
end;
procedure writefile(const filename1, filename2, filename3: string; const n: integer);
var
  inifile: Tinifile;
  filename: string;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  try
    inifile := Tinifile.Create(filename);
    inifile.WriteString('warn', 'filename1', filename1);
    inifile.WriteString('warn', 'filename2', filename2);
    inifile.WriteString('warn', 'filename3', filename3);
    inifile.WriteInteger('warn', 'n', n);
  finally
    inifile.Free;
  end;
end;
procedure readtimes(var resptime, sendcou: integer);
var
  filename: string;
  inifile: Tinifile;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  inifile := Tinifile.Create(filename);
  try
    resptime := inifile.ReadInteger('submit', 'resptime', 10);
    sendcou := inifile.ReadInteger('submit', 'sendtimes', 4);
  finally
    inifile.Free;
  end;
end;
procedure writetimes(const resptime, sendcou: integer);
var
  filename: string;
  inifile: Tinifile;
begin
  filename := extractfilepath(application.ExeName) + 'SMGPConfig.ini';
  inifile := Tinifile.Create(filename);
  try
    inifile.WriteInteger('submit', 'resptime', resptime);
    inifile.WriteInteger('submit', 'sendtimes', sendcou);
  finally
    inifile.Free;
  end;
end;

procedure TFSysConfig.FormCreate(Sender: TObject);
var
  Loginmode, xconnectmode: string;
  Status_ID, Version: string;
  questC_ID, sendC_ID: word;
  Response: Boolean;
  MTport, Moport, Report: string;
  Mtseq, Moseq, RespSeq, RepSeq: word;
  ip: string;
  timeout: integer;
  CTDeliverN, SpsubmitN, SpdeliverN, SubmitReqN, ResponseN, ReportN: integer;
  CTDsleep, Spssleep, SpDsleep, SReqsleep, Respsleep, Repsleep: integer;
  Threadnumber, sleeptime: integer;
  autowrite: Boolean;
  dsequenceID, ssequenceID: integer;
  str: string;
  activetime, CTtimeout, RetryTime: integer;
  vision: byte;
  filename1, filename2, filename3: string;
  n, resptime, sendtimes: integer;
begin
  //设置文本框允许输入字符
  //IP地址
  Edit15.Text := AppTitle;
  TCTIP.OnKeyPress := IPEditKeyPress;
  TSerIP.OnKeyPress := IPEditKeyPress;
  EIP.OnKeyPress := IPEditKeyPress;
  TCTPort.OnKeyPress := EditKeyPress;
  TMTPort.OnKeyPress := EditKeyPress;
  TMOPort.OnKeyPress := EditKeyPress;
  TRePort.OnKeyPress := EditKeyPress;
  EPort.OnKeyPress := EditKeyPress;
  Edit1.OnKeyPress := EditKeyPress;
  Edit2.OnKeyPress := EditKeyPress;
  ERetry.OnKeyPress := EditKeyPress;
  TVision.OnKeyPress := EditKeyPress;
  TMTSeq.OnKeyPress := EditKeyPress;
  TMOPort.OnKeyPress := EditKeyPress;
  TRespSeq.OnKeyPress := EditKeyPress;
  TReportSeq.OnKeyPress := EditKeyPress;
  TMOSeq.OnKeyPress := EditKeyPress;
//  EdefSeq.OnKeyPress := EditKeyPress;
  TSta.OnKeyPress := EditKeyPress;
  TMTCom.OnKeyPress := EditKeyPress;
  TMOCom.OnKeyPress := EditKeyPress;
  TRespCom.OnKeyPress := EditKeyPress;
  TReCom.OnKeyPress := EditKeyPress;
  Edit5.OnKeyPress := EditKeyPress;
  Edit6.OnKeyPress := EditKeyPress;
  Edit7.OnKeyPress := EditKeyPress;
  Edit8.OnKeyPress := EditKeyPress;
  Edit9.OnKeyPress := EditKeyPress;
  Edit10.OnKeyPress := EditKeyPress;
  ERespTime.OnKeyPress := EditKeyPress;
  ESendCou.OnKeyPress := EditKeyPress;
  TSPsubmitN.OnKeyPress := EditKeyPress;
  TSPDeliverN.OnKeyPress := EditKeyPress;
  TSubmitRes.OnKeyPress := EditKeyPress;
  TResponse.OnKeyPress := EditKeyPress;
  EReport.OnKeyPress := EditKeyPress;
  Edit13.OnKeyPress := EditKeyPress;
  Edit17.OnKeyPress := EditKeyPress;
  readLogParam(ServerIP, Port, clientID, sharesecret, SPID);
  readLogParam1(Loginmode, xconnectmode);
  readfile(filename1, filename2, filename3, n);
  readsequence(Mtseq, Moseq, RespSeq, RepSeq, questC_ID, sendC_ID);
  readport(MTport, Moport, Report,GateID);
  readSerIp(ip, timeout);
  readProto(Status_ID, Version, Response);
  readThread(CTDeliverN, SpsubmitN, SpdeliverN, SubmitReqN, ResponseN, ReportN, CTDsleep, Spssleep, SpDsleep, SReqsleep, Respsleep, Repsleep);
  readlogth(udpsrvip, udpport, Threadnumber, sleeptime, autowrite);
  readsequID(dsequenceID, ssequenceID);
  readtime(activetime, CTtimeout);
  readtimes(resptime, sendtimes);
  TSC.Text := sharesecret;
  TCTIP.Text := ServerIP;
  TCTPort.Text := Port;
  EClientID.Text := clientID;
  TSPID.Text := SPID;
  str := CBLoginMode.Items[strtointdef(Loginmode, 2)];
  CBLoginMode.Text := str;
  str := ConnectMode.Items[strtointdef(xconnectmode, 1) - 1];
  ConnectMode.Text := str;
  {登陆中间层参数}
  TSerIP.Text := ip;
  CBTimeout.Text := inttostr(timeout);
  if Response then CheckBox1.Checked := true;
  TMTSeq.Text := inttostr(Mtseq); TMTCom.Text := inttostr(questC_ID);
  TMOSeq.Text := inttostr(Moseq); TMOCom.Text := inttostr(sendC_ID);
  TRespSeq.Text := inttostr(RespSeq); TRespCom.Text := inttostr(sendC_ID);
  TReportSeq.Text := inttostr(RepSeq); TReCom.Text := inttostr(sendC_ID);
//  EUser_FS.Text := inttostr(User_F_S_SeqID);
  TMTPort.Text := MTport;
  TMOPort.Text := Moport;
  TRePort.Text := Report;
  TSta.Text := Status_ID;
  TVision.Text := Version;
  Edit1.Text := inttostr(CTtimeout);
  Edit2.Text := inttostr(activetime);
  TCTDeliverN.Text := inttostr(CTDeliverN); Edit5.Text := inttostr(CTDsleep);
  TSPsubmitN.Text := inttostr(SpsubmitN); Edit6.Text := inttostr(Spssleep);
  TSPDeliverN.Text := inttostr(SpdeliverN); Edit7.Text := inttostr(SpDsleep);
  TSubmitRes.Text := inttostr(SubmitReqN); Edit8.Text := inttostr(SReqsleep);
  TResponse.Text := inttostr(ResponseN); Edit9.Text := inttostr(Respsleep);
  EReport.Text := inttostr(ReportN); Edit10.Text := inttostr(Repsleep);
  Edit3.Text := inttostr(Threadnumber); Edit11.Text := inttostr(sleeptime);
  if autowrite then CheckBox2.Checked := true;
  EDSeq.Text := inttostr(dsequenceID);
  ESSeq.Text := inttostr(ssequenceID);
  readLogParam2(Loginmode, xconnectmode);
  str := CBLoginMode1.Items[strtointdef(Loginmode, 2)];
  CBLoginMode1.Text := str;
  str := ConnectMode1.Items[strtointdef(xconnectmode, 1) - 1];
  ConnectMode1.Text := str;
  readvision(vision);
  HVision.Text := inttostr(vision);
  readRetryTime(RetryTime);
  ERetry.Text := inttostr(RetryTime);
  Edit4.Text := filename1;
  Edit12.Text := filename2;
  Edit14.Text := filename3;
  Edit13.Text := inttostr(n);
//  EdefSeq.Text := inttostr(DefSequence_ID);
  ERespTime.Text := inttostr(resptime);
  ESendCou.Text := inttostr(sendtimes);
  EIP.Text := udpsrvip;
  EPort.Text := inttostr(udpport);
  OpenDialog1.DefaultExt := application.ExeName;
  OpenDialog2.DefaultExt := application.ExeName;
  OpenDialog3.DefaultExt := application.ExeName;
  Edit16.Text := inttostr(sSequence);
  Edit17.Text := GateID;
  ActiveTestTime := StrToInt(Edit2.Text);
end;

procedure TFSysConfig.FormShow(Sender: TObject);
begin
  RzPageControl1.ActivePageIndex := 0;
end;

procedure TFSysConfig.SpeedButton8Click(Sender: TObject);
var
  xFullWarnning: FullWarnning;
begin
  xFullWarnning := FullWarnning.Create;
end;

procedure TFSysConfig.SpeedButton10Click(Sender: TObject);
begin
  if OpenDialog3.Execute then
    Edit14.Text := OpenDialog3.filename;
end;
procedure TFSysConfig.EditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #13, #8]) then
    Key := #0;
end;

procedure TFSysConfig.IPEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #13, #8, #46]) then
    Key := #0;
end;
procedure TFSysConfig.SpeedButton6Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Edit4.Text := OpenDialog1.filename;
end;

procedure TFSysConfig.SpeedButton13Click(Sender: TObject);
begin
  if OpenDialog2.Execute then
    Edit12.Text := OpenDialog2.filename;
end;

procedure TFSysConfig.RzBitBtn1Click(Sender: TObject);
var
  Loginmode: string;
  xconnectmode: string;
begin
  ActiveTestTime := StrToInt(Edit2.Text);
  if CBLoginMode.Text = '0发送短消息' then Loginmode := '0'
  else if CBLoginMode.Text = '1接收短消息' then Loginmode := '1'
  else if CBLoginMode.Text = '2收发短消息' then Loginmode := '2'
  else Loginmode := '3';
  if ConnectMode.Text = '1长连接' then xconnectmode := '1'
  else xconnectmode := '2';
  writeLogParam1(Loginmode, xconnectmode);
  if CBLoginMode1.Text = '0发送短消息' then Loginmode := '0'
  else if CBLoginMode1.Text = '1接收短消息' then Loginmode := '1'
  else if CBLoginMode1.Text = '2收发短消息' then Loginmode := '2'
  else Loginmode := '3';
  if ConnectMode1.Text = '1长连接' then xconnectmode := '1'
  else xconnectmode := '2';
  writeLogParam(TCTIP.Text, TCTPort.Text, EClientID.Text, TSC.Text, Trim(TSPID.Text));
  writeLogParam2(Loginmode, xconnectmode);
  writetime(StrToInt(Trim(Edit2.Text)), StrToInt(Trim(Edit1.Text)));
  GateID:=edit17.Text;
  writevision(StrToInt(Trim(HVision.Text)), StrToInt(Trim(ERetry.Text)),GateID);

  readLogParam(ServerIP, Port, clientID, sharesecret, SPID);
  RetryTime := StrToInt(Trim(ERetry.Text));
  if messagebox(handle, '系统参数配置完成,现在要退出配置模块吗?', '成功', mb_okCancel + MB_ICONinformation) = 1 then
    close;
end;

procedure TFSysConfig.RzBitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure TFSysConfig.RzBitBtn3Click(Sender: TObject);
begin
  writeseq(StrToInt(TMTSeq.Text), StrToInt(TMOSeq.Text), StrToInt(TRespSeq.Text), StrToInt(TReportSeq.Text), StrToInt(TMTCom.Text), StrToInt(TMOCom.Text));
  writeProto(TSta.Text, TVision.Text, CheckBox1.Checked);
  writeServer(TSerIP.Text, TMTPort.Text, TMOPort.Text, TRePort.Text, StrToInt(CBTimeout.Text));
  if messagebox(handle, '系统参数配置完成,现在要退出配置模块吗?', '成功', mb_okCancel + MB_ICONinformation) = 1 then
    close;
end;

procedure TFSysConfig.RzBitBtn4Click(Sender: TObject);
begin
  writeThread(StrToInt(TCTDeliverN.Text), StrToInt(TSPsubmitN.Text), StrToInt(TSPDeliverN.Text), StrToInt(TSubmitRes.Text), StrToInt(TResponse.Text), StrToInt(EReport.Text),
    StrToInt(Edit5.Text), StrToInt(Edit6.Text), StrToInt(Edit7.Text), StrToInt(Edit8.Text), StrToInt(Edit9.Text), StrToInt(Edit10.Text));
  writetimes(StrToInt(ERespTime.Text), StrToInt(ESendCou.Text));
  if messagebox(handle, '系统参数配置完成,现在要退出配置模块吗?', '成功', mb_okCancel + MB_ICONinformation) = 1 then
    close;
end;

procedure TFSysConfig.RzBitBtn5Click(Sender: TObject);
begin
  writelogth(StrToInt(Edit3.Text), StrToInt(Edit11.Text), CheckBox2.Checked);
  if messagebox(handle, '系统参数配置完成,现在要退出配置模块吗?', '成功', mb_okCancel + MB_ICONinformation) = 1 then
    close;
end;

procedure TFSysConfig.RzBitBtn6Click(Sender: TObject);
var
  s: string;
begin
  writefile(Trim(Edit4.Text), Trim(Edit12.Text), Trim(Edit14.Text), StrToInt(Trim(Edit13.Text)));
  if (udpsrvip <> EIP.Text) or (udpport <> StrToInt(EPort.Text)) then
  begin
    writeudp(EIP.Text, StrToInt(EPort.Text));
    SMGPGateWay.Toolbutton16.Enabled := true;
    s := '修改监控消息配置参数,请重启日志处理线程！';
  end;
  s := '系统参数配置完成,现在要退出配置模块吗?' + #13#10 + s;
  SendWarn := CheckBox6.Checked;
  NoReceiveDeliver := StrToInt(RzSpinEdit1.Text);
  SendCount := StrToInt(RzSpinEdit2.Text);
  if messagebox(handle, PAnsiChar(s), '成功', mb_okCancel + MB_ICONinformation) = 1 then
    close;
end;

procedure TFSysConfig.RadioButton1Click(Sender: TObject);
begin
  if RadioButton1.Checked then
  begin
    SMGPGateWay.N15.Enabled := False;
    SMGPGateWay.N17.Enabled := False;
    SMGPGateWay.AllLogin1.Enabled := true;
    SMGPGateWay.MTLogin1.Enabled := true;
    SMGPGateWay.MOLogin1.Enabled := true;
    SMGPGateWay.AllExit1.Enabled := true;
    SMGPGateWay.MTExit1.Enabled := true;
    SMGPGateWay.MOExit1.Enabled := true;
    GroupBox13.Visible := False;
    GroupBox7.Visible := true;
    GroupBox8.Visible := true;
  end
end;

procedure TFSysConfig.RadioButton2Click(Sender: TObject);
begin
  if RadioButton2.Checked then
  begin
    SMGPGateWay.N15.Enabled := true;
    SMGPGateWay.N17.Enabled := true;
    SMGPGateWay.AllLogin1.Enabled := False;
    SMGPGateWay.MTLogin1.Enabled := False;
    SMGPGateWay.MOLogin1.Enabled := False;
    SMGPGateWay.AllExit1.Enabled := False;
    SMGPGateWay.MTExit1.Enabled := False;
    SMGPGateWay.MOExit1.Enabled := False;  
    GroupBox13.Visible := true;
    GroupBox7.Visible := False;
    GroupBox8.Visible := False;
  end;
end;

end.

