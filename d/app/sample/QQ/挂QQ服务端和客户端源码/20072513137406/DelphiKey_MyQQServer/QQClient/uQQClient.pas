//挂QQ服务端，如需WEB版挂QQ的，自己来改造，本人现在没有精力改造了
//不需要的东西都已经取消了
//提供该程序只是用来学习目的，千万不要用于非法用途，后果自负
//用到RX控件，和JCL库，请大家自行下载
//如果不能挂QQ的话，那就请看LumqQQ中的相关协议，改成新协议即可
//如有更新希望发一份给我 QQ:709582502 Email:Touchboy@126.com 

unit uQQClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ToolEdit, CurrEdit,Class_Record,Class_QQTEA,
  OleCtrls, MSWinsockLib_TLB,Class_QQOutPacket,Class_QQInPacket, ComCtrls,
  ExtCtrls, WinSkinData, ScktComp;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    PassWordEdt: TEdit;
    QQNumEdt: TCurrencyEdit;
    RadioButton2: TRadioButton;
    OnLineRB: TRadioButton;
    Image1: TImage;
    SetupPnl: TPanel;
    BeginPnl: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    ServerIPEdt: TEdit;
    PortEdt: TCurrencyEdit;
    SetupBtn: TButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    SkinData1: TSkinData;
    TCPSend: TClientSocket;
    Label5: TLabel;
    Label6: TLabel;
    EndTimeDTP: TDateTimePicker;
    Label7: TLabel;
    BeginTimeDTP: TDateTimePicker;
    CheckBox1: TCheckBox;
    Timer1: TTimer;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SetupBtnClick(Sender: TObject);
    procedure ServerIPEdtChange(Sender: TObject);
    procedure TCPSendConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure Timer1Timer(Sender: TObject);
  private
    FBSetup:Boolean;
    SendPacket:Array [0..61] of Byte;
    FFilename:String;
    FIsConnect:Boolean;
    FSocket :TCustomWinSocket;

    FChecked:boolean;

    MYQQInfo :TQQInfo;
    procedure SendLogin(nOperator,QQNum:Integer;PassWord:String;AutoReplay,QQHide:Boolean;
       OneHour,OneMin,TwoHour,TwoMin,UserType:integer);
    procedure SetPanel;

    procedure SendQQpacket(Socket:TCustomWinSocket);
  public

  end;

var
  Form1: TForm1;

implementation
Uses NWIniFile,JclDateTime;

{$R *.dfm}

{ TForm1 }


procedure TForm1.BitBtn1Click(Sender: TObject);
begin

    if Trim(QQNumEdt.Text)='' then
    begin
      ShowMessage('QQ号码不能为空');
      QQNumEdt.SetFocus;
      Exit;
    end;
    if Trim(PassWordEdt.Text)='' then
    begin
      ShowMessage('QQ密码不能为空');
      PassWordEdt.SetFocus;
      Exit;
    end;

  if HourOfTime(BeginTimeDTP.Time)>HourOfTime(EndTimeDTP.Time) then
  begin
    ShowMessage('开始时间不到大于结束时间');
    BeginTimeDTP.SetFocus;
    Exit;
  end;
  if (HourOfTime(BeginTimeDTP.Time)=HourOfTime(EndTimeDTP.Time)) and
     (MinuteOfTime(BeginTimeDTP.Time)> MinuteOfTime(EndTimeDTP.Time))then
  begin
    ShowMessage('开始时间不到大于结束时间');
    BeginTimeDTP.SetFocus;
    Exit;
  end;
    //TCPSend.Close;
    if not TCPSend.Active then TCPSend.Active:=True;
    if Assigned(FSocket) then
       SendQQpacket(FSocket);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  App:String;
  s:String;
begin
  App:=Sysutils.ExtractFilePath(Application.ExeName);
  if App[Length(App)]<>'\' then App :=App+'\';
  FFilename :=App+'IP.ini';
  SkinData1.Active :=True;

  TCPSend.Host :=ReadiniString(FFilename,'IP','Server','192.168.1.2');
  TCPSend.Port :=ReadIniInteger(FFilename,'IP','port',17999);
  QQNumEdt.AsInteger:=ReadIniInteger(FFilename,'IP','QQNum',481889);
  S:=ReadiniString(FFilename,'IP','QQPassWord','0000');
 
  PassWordEdt.Text :=S;

  QQTEA:=TQQTEA.Create;
  FBSetup :=False;
  SetPanel;
  ServerIPEdt.Text :=ReadiniString(FFilename,'IP','Server','192.168.1.2');
  PortEdt.AsInteger:=ReadIniInteger(FFilename,'IP','port',8000);

  FChecked :=False;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.SendLogin(nOperator,QQNum: Integer; PassWord: String; AutoReplay,
  QQHide: Boolean;OneHour,OneMin,TwoHour,TwoMin,UserType:integer);
var
  i,j:Integer;
  Key  :array  of byte;
  Crypt:array of byte;
  Plain:TMYByte;
  nSendLen :integer;
begin
    SetLength(Crypt,43);
    SetLength(Key,16);
    for i:=0 to 58 do
    begin
      Plain[i]:=0;
      SendPacket[i]:=0;
    end;

    //if RadioButton1.Checked then
    //  SendPacket[18] :=1 else  SendPacket[18] :=3;

    SendPacket[1] :=OneHour;
    SendPacket[2] :=OneMin;
    SendPacket[3] :=TwoHour;
    SendPacket[4] :=TwoMin;
    SendPacket[5] :=UserType;

    SendPacket[18] :=nOperator;
    if AutoReplay then
    SendPacket[19] :=255 else  SendPacket[19] :=0;
    if QQHide then
    SendPacket[20] :=255 else  SendPacket[20] :=0;

    CopyMemory(@SendPacket[21],@QQNum,4);
    For i:=1 to Length(PassWord) do
       SendPacket[i+24]:=Byte(PassWord[i]);

    CopyMemory(@Key[0], @SendPacket[1], 16 ) ;
    CopyMemory(@Crypt[0], @SendPacket[18], 40);
    Plain := QQTEA.Encrypt(Crypt, Key,nSendLen);
    CopyMemory(@SendPacket[18],@Plain[0],40) ;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  WriteIniInteger(FFilename,'IP','QQNum',QQNumEdt.AsInteger);
  WriteiniString(FFilename,'IP','QQPassWord',PassWordEdt.Text);

  WriteiniString(FFilename,'IP','Server',ServerIPEdt.Text);
  WriteIniInteger(FFilename,'IP','PORT',PortEdt.AsInteger);
  FreeAndNil(QQTEA);
end;

procedure TForm1.SetupBtnClick(Sender: TObject);
begin
  FBSetup :=not FBSetup;
  SetPanel;
end;

procedure TForm1.SetPanel;
begin
  if FBSetup then
  begin
    BeginPnl.Top     :=239;
    SetupPnl.Visible :=True;
    Self.Height :=Self.Height+SetupPnl.Height;
  end else begin
      BeginPnl.Top     :=SetupPnl.top;
      SetupPnl.Visible :=False;
     Self.Height :=Self.Height-SetupPnl.Height;
  end;
end;

procedure TForm1.ServerIPEdtChange(Sender: TObject);
begin
  TCPSend.Host :=ServerIPEdt.Text;
  TCPSend.Port :=PortEdt.AsInteger;
end;

procedure TForm1.SendQQpacket(Socket: TCustomWinSocket);
var
  S:String;
  A:Array of Byte;
  i:integer;
   OneHour,OneMin,OneSec,OnesSec,
   TwoHour,TwoMin,TwoSec,TwosSec,UserType:WORD;
begin
   DecodeTime(BeginTimeDTP.Time,OneHour,OneMin,OneSec,OnesSec);
   DecodeTime(EndTimeDTP.Time,TwoHour,TwoMin,TwoSec,TwosSec);

   SetLength(S,59);
   For i:=1 to 59 do
     S[i]:=Chr($0);
   if OnLineRB.Checked then
   begin
     SendLogin(1,QQNumEdt.AsInteger,PassWordEdt.Text,True,CheckBox1.Checked,OneHour,OneMin,TwoHour,TwoMin,0);
     CopyMemory(@S[1],@SendPacket[0],59);
     Socket.SendText(S);
   end
   else begin
     SendLogin(3,QQNumEdt.AsInteger,PassWordEdt.Text,True,CheckBox1.Checked,OneHour,OneMin,TwoHour,TwoMin,0);
     CopyMemory(@S[1],@SendPacket[0],59);
     Socket.SendText(S);
   end;
end;

procedure TForm1.TCPSendConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
   FSocket :=Socket;
   SendQQpacket(FSocket);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
   SendQQpacket(FSocket);
   FChecked :=Not FChecked;
   if FChecked then
   begin
     OnLineRB.Checked    :=True;
     RadioButton2.Checked:=False;
   end else begin
     OnLineRB.Checked    :=False;
     RadioButton2.Checked:=True;
   end;
end;

end.
