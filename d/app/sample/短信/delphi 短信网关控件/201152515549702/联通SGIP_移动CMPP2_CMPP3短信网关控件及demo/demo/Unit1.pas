unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,  ExtCtrls, ScktComp, IdBaseComponent,ActiveX,
  IdComponent, IdTCPConnection, IdTCPClient,inifiles, sms_client, DB, ADODB;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button3: TButton;
    LabeledEdit17: TLabeledEdit;
    GroupBox1: TGroupBox;
    Memo2: TMemo;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    GroupBox5: TGroupBox;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit11: TLabeledEdit;
    LabeledEdit12: TLabeledEdit;
    LabeledEdit13: TLabeledEdit;
    LabeledEdit14: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit15: TLabeledEdit;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    LabeledEdit16: TLabeledEdit;
    sms_send1: Tsms_send;
    CheckBox1: TCheckBox;
    LabeledEdit18: TLabeledEdit;
    Button7: TButton;
    Panel1: TPanel;
    ADOStoredProc1: TADOStoredProc;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure sms_send1SGIP_DELIVER(Phone, Msg: String);
    procedure Button2Click(Sender: TObject);
    procedure sms_send1loginout;
    procedure sms_send1login(var User, Pass: String);
    procedure sms_send1loginerror(var Errormsg: String);
    procedure sms_send1sendsms(var Phone, MessageContent: String;
      var Sseqid: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sms_send1returnerror(var Error: Integer);
    procedure sms_send1sendsmserror(var Errormsg: String);
    procedure sms_send1_sgip_deliver(var SPNumber, Phone, Msg,
      linkids: String; var Ssendseq: Int64; var MessageCoding,
      Registered_Deliver: Byte);
    procedure Button7Click(Sender: TObject);
    procedure sms_send1Afterlogin(var Msg: String; status: Integer);
    procedure sms_send1connecterror(var Errormsg: String);
    procedure sms_send1_sgip_report(var Phone, Statemsg: String;
      var Ssendseq: Integer; var State, ErrorCode: Byte);
    procedure sms_send1Aftersendsms(var Msg: String; var seqid,
      msgid: Integer; SendResult: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  seq:integer;
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
sms_send1.Host:=LabeledEdit1.Text;
sms_send1.Port:=strtoint(LabeledEdit2.Text);
sms_send1.LocalPort:=strtoint(LabeledEdit3.Text);
sms_send1.User:=LabeledEdit4.Text;
sms_send1.Pass:=LabeledEdit5.Text;
sms_send1.SPNumber:=LabeledEdit6.Text;
sms_send1.ChargeNumber:=LabeledEdit7.Text;
sms_send1.SNumber:=strtoint64(LabeledEdit8.Text);
sms_send1.CorpID:=LabeledEdit9.Text;
sms_send1.ServiceType:=LabeledEdit10.Text;
sms_send1.FeeTypes:=strtoint(LabeledEdit11.Text);
sms_send1.FeeValue:=LabeledEdit12.Text;
sms_send1.GivenValue:=LabeledEdit13.Text;
sms_send1.AgentFlag:=strtoint(LabeledEdit14.Text);
sms_send1.ExpireTime:=LabeledEdit15.Text;
sms_send1.LoginTimeout:=strtoint(LabeledEdit16.Text);
sms_send1.Startserver:=CheckBox1.Checked;
sms_send1.TMessageCoding:=strtoint(LabeledEdit18.Text);
case ComboBox1.ItemIndex of
  0:begin sms_send1.Pacttype:=SGIP2;sms_send1.Port:=8801; end;
  1:begin sms_send1.Pacttype:=CMPP2;sms_send1.Port:=7890; end;
  2:begin sms_send1.Pacttype:=CMPP3;sms_send1.Port:=7890; end;
  3:begin sms_send1.Pacttype:=SMGP32;sms_send1.Port:=3058; end;
end;
if not sms_send1.Open then exit;  // 0 表示联通SGIP 1表示移动CMPP3.0
memo1.Lines.Add('网关服务器已开启...');
Button1.Enabled:=false;
Button3.Enabled:=true;
end;

procedure TForm1.sms_send1SGIP_DELIVER(Phone, Msg: String);
begin
memo1.Lines.Add('手机：'+Phone);
memo1.Lines.Add('信息：'+Msg);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
//短信发送
seq:=seq+1;
sms_send1.SPNumber:=LabeledEdit6.Text;
sms_send1.Phone:=LabeledEdit17.Text; //手机号码
sms_send1.MessageContent:=memo2.Text;//短信内容
sms_send1.Seqid:=seq;
if not sms_send1.sendsms then //启动信息发送
memo1.Lines.Add('短信发送失败');


end;

procedure TForm1.sms_send1loginout; //当网关客户端登陆网关服务器超过预定的logintimeout则出发注销断开网关服务器
begin
//memo1.Lines.Add('成功注销...');
end;

procedure TForm1.sms_send1login(var User, Pass: String);//网关客户端登陆触发
begin
memo1.Lines.Add('');
memo1.Lines.Add('用户名：'+User);
memo1.Lines.Add('密  码：'+pass);
end;

procedure TForm1.sms_send1loginerror(var Errormsg: String);//网关登陆发生错误触发
begin
memo1.Lines.Add('登陆发生错误：'+Errormsg);
end;

procedure TForm1.sms_send1sendsms(var Phone, MessageContent: String; //短信发送前触发
  var Sseqid: Integer);
begin
memo1.Lines.Add('');
memo1.Lines.Add('发送序列：'+inttostr(Sseqid)); //建议不要重复，网关服务器发送返回的 Sseqid
memo1.Lines.Add('发送号码：'+Phone);
memo1.Lines.Add('发送信息:['+MessageContent+']');
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
inifile:Tinifile;
begin

inifile:=Tinifile.Create(ExtractFilePath(application.ExeName)+'sms_test.ini');
inifile.WriteInteger('msg_option','seq',seq);
inifile.Destroy;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
if sms_send1.Active then
begin
if sms_send1.Close then
begin
Button3.Enabled:=false;
Button1.Enabled:=true;
memo1.Lines.Add('网关服务器已关闭...');
end;
end;

end;

procedure TForm1.FormCreate(Sender: TObject);
var
inifile:Tinifile;
begin
inifile:=Tinifile.Create(ExtractFilePath(application.ExeName)+'sms_test.ini');
LabeledEdit1 .Text:=inifile.ReadString('tcp_ip_option','host','130.51.79.50');
LabeledEdit2.Text:=inifile.ReadString('tcp_ip_option','port','8881');
LabeledEdit3.Text:=inifile.ReadString('tcp_ip_option','locat_port','4321');
LabeledEdit4.Text:=inifile.ReadString('tcp_ip_option','user','sms_user');
LabeledEdit5.Text:=inifile.ReadString('tcp_ip_option','pass','user_sms');
LabeledEdit6.Text:=inifile.ReadString('msg_option','SrcNumber','11760');
LabeledEdit7.Text:=inifile.ReadString('msg_option','ChargeNumber','000000000000000000000');
LabeledEdit8.Text:=inifile.ReadString('msg_option','SNumber','3020032288');
LabeledEdit9.Text:=inifile.ReadString('msg_option','CorpId','32288');
LabeledEdit10.Text:=inifile.ReadString('msg_option','ServiceType','a');
LabeledEdit11.Text:=inifile.ReadString('msg_option','FeeType','1');
LabeledEdit12.Text:=inifile.ReadString('msg_option','FeeValue','0');
LabeledEdit13.Text:=inifile.ReadString('msg_option','GivenValue','0');
LabeledEdit14.Text:=inifile.ReadString('msg_option','ExpireTime','0');
LabeledEdit16.Text:=inifile.ReadString('msg_option','logintimeout','10000');
seq:=inifile.ReadInteger('msg_option','seq',0);
Adostoredproc1.ConnectionString:=inifile.ReadString('adooption','ConnectionString','');
end;

procedure TForm1.sms_send1returnerror(var Error: Integer);
begin
memo1.Lines.Add('短信中心返回错误：'+inttostr(Error));
end;

procedure TForm1.sms_send1sendsmserror(var Errormsg: String);//短信发送发生错误触发
begin
memo1.Lines.Add('XXXXXXXXXXXXXXXXXXXXXXXXXXXX');
memo1.Lines.Add('短信发送发生错误：'+Errormsg);
end;

procedure TForm1.sms_send1_sgip_deliver(var SPNumber, Phone, Msg,
  linkids: String; var Ssendseq: Int64; var MessageCoding,
  Registered_Deliver: Byte); //收到短信触发
begin
  if Registered_Deliver=0 then
  begin
   memo1.Lines.Add('');
   memo1.Lines.Add('上行短信信息');
   memo1.Lines.Add('SP号码：'+SPNumber);
   memo1.Lines.Add('手机号码：'+phone);
   memo1.Lines.Add('短信内容：'+Msg);
   memo1.Lines.Add('短信序列：'+inttostr(Ssendseq));
   memo1.Lines.Add('短信编码：'+inttostr(MessageCoding));
   memo1.Lines.Add('Linkid号：'+linkids);
   with Adostoredproc1 do
   begin
    procedurename:='smsrec';
    Parameters.Clear;
    with Parameters.AddParameter do begin
    Value:=SPNumber;DataType:=ftstring;Name:='@spnum';end;

    with Parameters.AddParameter do begin
    Value:=phone;DataType:=ftstring;Name:='@phone';end;

    with Parameters.AddParameter do begin
    Value:=Msg;DataType:=ftstring;Name:='@MessageContent';end;

    with Parameters.AddParameter do begin
    Value:=linkids;DataType:=ftstring;Name:='@linkid';end;


    try
     CoInitialize(nil);
     //ExecProc;
    finally
      CoUninitialize;
    end;
    
   end;
  end
  else
  begin
//   memo1.Lines.Add('网关服务器端返回回执报告');
//   memo1.Lines.Add('回执内容：'+Msg);
  end;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
 sms_send1.connecttest;
end;

procedure TForm1.sms_send1Afterlogin(var Msg: String; status: Integer);
begin
 Memo1.Lines.Add('验证返回：'+Msg)
end;

procedure TForm1.sms_send1connecterror(var Errormsg: String);
begin
 Memo1.Lines.Add('连接发生错误：'+Errormsg);
end;

procedure TForm1.sms_send1_sgip_report(var Phone, Statemsg: String;
  var Ssendseq: Integer; var State, ErrorCode: Byte);
begin
memo1.Lines.Add('');
memo1.Lines.Add('网关服务器端回执报告');
memo1.Lines.Add('短信序列：'+inttostr(Ssendseq));
memo1.Lines.Add('手机号码：'+phone);
memo1.Lines.Add('发送状态：'+Statemsg+'，返回代码：'+inttostr(State)+',错误代码：'+inttostr(ErrorCode));
end;

procedure TForm1.sms_send1Aftersendsms(var Msg: String; var seqid,
  msgid: Integer; SendResult: Integer);
begin
memo1.Lines.Add('');
memo1.Lines.Add('短信网关短信接收情况');
memo1.Lines.Add('流水号：'+inttostr(seqid)+#13#10+'MSGID：'+inttostr(msgid)+#13#10+'返回结果：['+Msg+']'+#13#10+'代码：'+inttostr(SendResult));

end;

end.
