unit Unit1;
{Download by http://www.codefans.net}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,winsock, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    GroupBox2: TGroupBox;
    Edit3: TEdit;
    Button2: TButton;
    Memo1: TMemo;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
  WSAData: TWSAData;
  HostEnt: PHostEnt;
  sComputerName, sIP: string;
begin
  sComputername:=edit1.text;
  WSAStartup(2, WSAData);
  HostEnt := gethostbyname(PChar(sComputerName));
  if HostEnt <> nil then
  begin
    with HostEnt^ do
      sIP := Format('%d.%d.%d.%d', [Byte(h_addr^[0]), Byte(h_addr^[1]), Byte(h_addr^[2]), Byte(h_addr^[3])]);

  end;
  WSACleanup;
  edit2.text:=sIP;
end;


procedure TForm1.Button2Click(Sender: TObject);
var
  WSAData:TWSAData;
  p:PHostEnt;
  sIP:string;
  InetAddr:dword;
begin
  WSAStartup(2, WSAData);
  sIP:=edit3.text;
  InetAddr:= inet_addr(PChar(sIP));
try
  try
  p:=GetHostByAddr(@InetAddr, Length(sIP), PF_Inet);
  memo1.lines.add('IP地址：'+sIP);
  memo1.lines.add('计算机名：'+p^.h_name);
  memo1.lines.add('别名：'+string(p^.h_aliases));
  memo1.lines.add('地址类型：'+chr(p^.h_addrtype+64));
  //p^.h_addrtype为1时对应地址类型为A，65为ASCII码A对应的数值
  //当返回值p^.h_addrtype为1时地址类型是A，返回2时地址类型是B，以此类推
  memo1.lines.add('地址长度：'+inttostr(p^.h_length)+'字节');
  //一般IPv4地址长度为4个字节
  memo1.lines.add('---------------------------');
finally
  WSACleanup;
  //注意要释放资源，无论有否异常
end;
except
  memo1.lines.add('无法得到该IP地址对应的计算机名！');
end;
end;


end.
