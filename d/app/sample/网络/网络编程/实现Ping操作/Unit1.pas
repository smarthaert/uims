unit Unit1;

interface
{Download by http://www.codefans.net}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,winsock, ExtCtrls;

type
    PIPOptionInformation = ^TIPOptionInformation;
    TIPOptionInformation=packed record
      TTL: Byte;
      TOS: Byte;
      Flags: Byte;
      OptionsSize: Byte;      OptionsData: PChar;    end;    PIcmpEchoReply = ^TIcmpEchoReply;    TIcmpEchoReply = packed record      Address: DWORD;      Status: DWORD;      RTT: DWORD;
      DataSize:Word;
      Reserved: Word;
      Data: Pointer;
      Options: TIPOptionInformation;
   end;
   TIcmpCreateFile = function: THandle; stdcall;
   TIcmpCloseHandle = function(IcmpHandle: THandle): Boolean; stdcall;
   TIcmpSendEcho =
       function(IcmpHandle:THandle;
                DestinationAddress:DWORD;
                RequestData: Pointer;
                RequestSize: Word;
                RequestOptions: PIPOptionInformation;
                ReplyBuffer: Pointer;
                ReplySize: DWord;
                Timeout: DWord ):DWord; stdcall;
  TTMyPing = class(TForm)
    PingEdit: TEdit;
    StatusShow: TMemo;
    exebtn: TButton;
    Panel1: TPanel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    procedure exebtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    hICMP: THANDLE;
     IcmpCreateFile : TIcmpCreateFile;
     IcmpCloseHandle:TIcmpCloseHandle;
     IcmpSendEcho: TIcmpSendEcho;
  public
   WSAData:TWSAData;
       { Public declarations }
  end;

var
  TMyPing: TTMyPing;

implementation

{$R *.DFM}

procedure TTMyPing.exebtnClick(Sender: TObject);
var
   IPOpt:TIPOptionInformation;// IP Options for packet to send
   FIPAddress:DWORD;
   pReqData,pRevData:PChar;
   pIPE:PIcmpEchoReply;// ICMP Echo reply buffer
   FSize: DWORD;
   MyString:string;
   FTimeOut:DWORD;
   BufferSize:DWORD;
begin
  if PingEdit.Text <> '' then
   begin
     FIPAddress:=inet_addr(pchar(Pingedit.text));
       FSize := 40;
       BufferSize := SizeOf(TICMPEchoReply) + FSize;
       GetMem(pRevData,FSize);
       GetMem(pIPE,BufferSize);
       FillChar(pIPE^, SizeOf(pIPE^), 0);
       pIPE^.Data := pRevData;
       MyString := '-------Hello,World!---------------';
       pReqData := PChar(MyString);
       FillChar(IPOpt, Sizeof(IPOpt), 0);
       IPOpt.TTL := 64;
       FTimeOut := 4000;
       IcmpSendEcho(hICMP, FIPAddress, pReqData, Length(MyString),
                    @IPOpt, pIPE, BufferSize, FTimeOut);
 try
  try
    if pReqData^ = pIPE^.Options.OptionsData^ then
     begin
       StatusShow.Lines.Add(PChar(PingEdit.Text) + '-----'
           +IntToStr(pIPE^.DataSize) + '-----' +IntToStr(pIPE^.RTT));
     end;
    except
     showmessage('没有找到Ip地址!');
   end;
  finally
      FreeMem(pRevData);
      FreeMem(pIPE);
  end;
 end
else
  showmessage('请输入Ip地址');
end;
// 　　通过上面的编程，我们就实现了Ping功能的界面操作。实际上，ICMP协议的功能还
//有很多，都可以通过对Icmp.dll的函数调用来实现。


procedure TTMyPing.FormCreate(Sender: TObject);
var
 hICMPdll: HMODULE;begin // Load the icmp.dll stuff
  WSAStartup(2,WSAData);
  hICMPdll := LoadLibrary('icmp.dll');
  @ICMPCreateFile := GetProcAddress(hICMPdll, 'IcmpCreateFile');
  @IcmpCloseHandle := GetProcAddress(hICMPdll, 'IcmpCloseHandle');
  @IcmpSendEcho := GetProcAddress(hICMPdll, 'IcmpSendEcho');
  hICMP :=IcmpCreateFile;
   StatusShow.Text := '';
    StatusShow.Lines.Add('目的IP地址-----字节数----返回时间(毫秒)');
end;
// 接下来，就要进行如下所示的Ping操作的实际编程过程了。

procedure TTMyPing.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 WSACleanup();
end;

end.


