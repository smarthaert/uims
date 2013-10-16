// 通过调用Api函数gethostname,gethostbyname,wsastartup
//uses中加winsock
//介绍wsadata,phostent msdn
//另外gethostaddress,
unit Unit1;
  {Download by http://www.codefans.net}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,winsock, ExtCtrls,nb30;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    Panel1: TPanel;
    Edit4: TEdit;
    Button2: TButton;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    Edit5: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

Function NBGetAdapterAddress(a:integer):String;

implementation

{$R *.DFM}

function NBGetAdapterAddress(a: integer): String;
//a指定多个网卡适配器中的哪一个0，1，2...
Var
  NCB:TNCB; // Netbios control block file://NetBios控制块
  ADAPTER : TADAPTERSTATUS; // Netbios adapter status//取网卡状态
  LANAENUM : TLANAENUM; // Netbios lana
  intIdx : Integer; // Temporary work value//临时变量
  cRC : Char; // Netbios return code//NetBios返回值
  strTemp : String; // Temporary string//临时变量

Begin
  // Initialize
  Result := '';

  Try
    // Zero control blocl
    ZeroMemory(@NCB, SizeOf(NCB));

    // Issue enum command
    NCB.ncb_command:=Chr(NCBENUM);
    cRC := NetBios(@NCB);

    // Reissue enum command
    NCB.ncb_buffer := @LANAENUM;
    NCB.ncb_length := SizeOf(LANAENUM);
    cRC := NetBios(@NCB);
    If Ord(cRC)<>0 Then
      exit;

    // Reset adapter
    ZeroMemory(@NCB, SizeOf(NCB));
    NCB.ncb_command := Chr(NCBRESET);
    NCB.ncb_lana_num := LANAENUM.lana[a];
    cRC := NetBios(@NCB);
    If Ord(cRC)<>0 Then
      exit;

    // Get adapter address
    ZeroMemory(@NCB, SizeOf(NCB));
    NCB.ncb_command := Chr(NCBASTAT);
    NCB.ncb_lana_num := LANAENUM.lana[a];
    StrPCopy(NCB.ncb_callname, '*');
    NCB.ncb_buffer := @ADAPTER;
    NCB.ncb_length := SizeOf(ADAPTER);
    cRC := NetBios(@NCB);

    // Convert it to string
    strTemp := '';
    For intIdx := 0 To 5 Do
      strTemp := strTemp + InttoHex(Integer(ADAPTER.adapter_address[intIdx]),2);
    Result := strTemp;
  Finally
  End;

end;

procedure TForm1.Button1Click(Sender: TObject);
var
 Ip:string;
 Ipstr:string;
 buffer:array[1..32] of char;
 i:integer;
 WSData:TWSAData;
 Host:PHostEnt;
begin
if WSAstartup(2,WSData)<>0 then  //为程序使用WS2_32.DLL初始化
  begin
    showmessage('WS2_32.DLL初始化失败!');
    halt;
  end;
try
if gethostname(@buffer[1],32)<>0 then
  begin
    showmessage('没有得到主机名！');
    halt;
  end;

except
  showmessage('没有成功返回主机名');
  halt;
end;
  Host:=gethostbyname(@buffer[1]);
  if Host=nil then
   begin
    showmessage('IP地址为空！');
    halt;
   end
    else
      begin
        edit2.text:=host.h_name;
        edit3.text:=chr(host.h_addrtype+64);
        for i:=1 to 4 do
          begin
           Ip:=inttostr(Ord(Host.h_addr^[i-1]));
           showmessage('分段Ip地址为:'+Ip);
           Ipstr:=Ipstr+Ip;
           if i<4 then
             Ipstr:=Ipstr+'.'
             else
               edit1.text:=Ipstr;
          end;
      end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
Edit4.Text:='第'+edit5.text+'个适配器的MAC地址为'+NBGetAdapterAddress(StrtoInt(Edit5.Text));
end;

end.
//WSAstartup在使用gethostname,gethostbyname前
//一定不要忘了初始化WS2_32.DLL
