unit timeform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ComCtrls, ExtCtrls, IdTCPConnection,
  IdTCPClient, IdDayTime, IdComponent, IdBaseComponent, Buttons,
  inifiles;

type
  TFormTime = class(TForm)
    Label1: TLabel;
    btnTime: TButton;
    btnClose: TButton;
    Timer1: TTimer;
    Bevel1: TBevel;
    StatusBar1: TStatusBar;
    IdDayTime1: TIdDayTime;
    Label4: TLabel;
    dthost: TEdit;
    Label5: TLabel;
    dtport: TEdit;
    GroupBox2: TGroupBox;
    useproxy: TCheckBox;
    Label2: TLabel;
    proxyhost: TEdit;
    Label3: TLabel;
    proxyport: TEdit;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    userchk: TCheckBox;
    useredit: TEdit;
    passwordedit: TEdit;
    sockstype: TComboBox;
    SpeedButton1: TSpeedButton;
    procedure btnTimeClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IdDayTime1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure IdDayTime1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure IdDayTime1Disconnected(Sender: TObject);
    procedure useproxyClick(Sender: TObject);
    procedure userchkClick(Sender: TObject);
    procedure sockstypeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTime: TFormTime;
  tini:tinifile;
  filename:string;
implementation

uses IdSocks;

{$R *.DFM}
function SetSystemtime2(ATime: TDateTime) : boolean;
Var
  ADateTime:TSystemTime;
  yy,mon,dd,hh,min,ss,ms : Word;
Begin
  decodedate(ATime ,yy,mon,dd);
  decodetime(ATime ,hh,min,ss,ms);
  With ADateTime Do
    Begin
      wYear:=yy;
      wMonth:=mon;
      wDay:=dd;
      wHour:=hh;
      wMinute:=min;
      wSecond:=ss;
      wMilliseconds:=ms;
    End;
   Result:=SetLocalTime(ADateTime);
   SendMessage(HWND_BROADCAST,WM_TIMECHANGE,0,0) ;
   //If Result then ShowMessage('成功改变时间!');
End;

procedure TFormTime.btnTimeClick(Sender: TObject);
var
  s : string;
  dtime : TDatetime;
begin
  IdDayTime1 .Host := dthost .Text ;
  IdDayTime1 .Port :=strtoint(dtport.Text );
  IdDayTime1 .SocksInfo .Version :=svNoSocks ;
  if useproxy .Checked then
  begin
      if sockstype .Text ='Socks4' then IdDayTime1 .SocksInfo .Version :=svSocks4;
      if sockstype .Text ='Socks4A' then IdDayTime1 .SocksInfo .Version :=svSocks4A;
      if sockstype .Text ='Socks5' then IdDayTime1 .SocksInfo .Version :=svSocks5;
      IdDayTime1 .SocksInfo .Host :=proxyhost .Text ;
      IdDayTime1 .SocksInfo .Port :=strtoint(proxyport .Text );
      if userchk .Checked then
        begin
          //需要验证User Password
          IdDayTime1 .SocksInfo .Authentication :=saUsernamePassword  ;
          IdDayTime1 .SocksInfo.UserID :=useredit .Text ;
          IdDayTime1 .SocksInfo .Password :=passwordedit .Text ;
        end;
    end;
  StatusBar1.SimpleText := '正在连接服务器...';
  s := IdDayTime1 .DayTimeStr ;
  s := copy(s,8,17);
  dtime:= strtodatetime(s);
  s:=DateToStr(now)+' '+TimeToStr(now);
  SetSystemtime2 (dtime+8/24);
  StatusBar1.SimpleText := '时间已由 '+s+' 调整到 '+DateToStr(dtime)+' '+TimeToStr(dtime+8/24);

end;


procedure TFormTime.btnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TFormTime.Timer1Timer(Sender: TObject);
var
  s: string;
begin
  DateTimeToString(s,'yyyy-mm-dd hh:mm:ss',now);
  Label1.Caption:= s;

end;

procedure TFormTime.FormCreate(Sender: TObject);
var
  s: string;
begin
  DateTimeToString(s,'yyyy-mm-dd hh:mm:ss',now);
  Label1.Caption:= s;
end;



procedure TFormTime.IdDayTime1WorkBegin(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCountMax: Integer);
begin
  StatusBar1.SimpleText := '正在取时间...';
end;

procedure TFormTime.IdDayTime1WorkEnd(Sender: TObject;
  AWorkMode: TWorkMode);
begin
  StatusBar1.SimpleText := '成功！';
end;

procedure TFormTime.IdDayTime1Disconnected(Sender: TObject);
begin
  StatusBar1.SimpleText := '已经断开连接';
end;

procedure TFormTime.useproxyClick(Sender: TObject);
begin
  proxyhost .Enabled :=useproxy  .Checked ;
  proxyport .Enabled :=useproxy  .Checked ;
  sockstype .Enabled :=useproxy .Checked ;
  userchk .Enabled :=useproxy .Checked ;
  Label2 .Enabled :=useproxy .Checked ;
  Label3 .Enabled :=useproxy .Checked ;
end;

procedure TFormTime.userchkClick(Sender: TObject);
begin
  useredit .Enabled :=userchk .Checked ;
  passwordedit .Enabled :=userchk .Checked ;
  Label6 .Enabled :=userchk .Checked ;
  Label7 .Enabled :=userchk .Checked ;
end;

procedure TFormTime.sockstypeChange(Sender: TObject);
begin
  if sockstype .Text <> 'Socks4' then
    userchk .Enabled :=true
  else
    userchk .Enabled :=false;
end;

procedure TFormTime.FormShow(Sender: TObject);
begin
  Filename:=ExtractFilePath(Paramstr(0))+'setup.ini';
  tini:=Tinifile.Create(filename);
  dthost  .Text:=tini.ReadString('Host','ServerName','192.43.244.18');
  dtport  .Text:=tini.ReadString('Host','ServerPort','13');
  proxyhost  .Text :=tini.ReadString('Proxy','ProxyHost','172.16.51.130');
  proxyport  .Text :=tini.ReadString('Proxy','ProxyPort','1080');
  useproxy .Checked :=tini.ReadBool('Proxy','UserProxy',false);
  sockstype .Text :=tini.ReadString('Proxy','Sockstype','Socks5');
end;

procedure TFormTime.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tini.WriteString ('Host','ServerName',dthost .Text );
  tini.WriteString ('Host','ServerPort',dtport .Text );
  tini.WriteString ('Proxy','ProxyHost',proxyhost .Text );
  tini.WriteString ('Proxy','ProxyPort',proxyport .Text );
  tini.WriteBool ('Proxy','UserProxy',useproxy .Checked );
  tini.WriteString('Proxy','Sockstype',sockstype .Text );
end;

end.
