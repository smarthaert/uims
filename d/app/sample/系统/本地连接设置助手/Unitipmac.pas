// what：IP/MAC
// use：设置本地连接，静态网关，查询MAC
// who：xiedingan
// time:20120803

//Download by http://www.codefans.net

unit Unitipmac;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,WinSock,IniFiles;

type
  Tformarp = class(TForm)
    setip: TGroupBox;
    editmyip: TLabeledEdit;
    btnsetip: TButton;
    editgateip: TLabeledEdit;
    editdns: TLabeledEdit;
    editsubnet: TLabeledEdit;
    gatemac: TGroupBox;
    btnsetmac: TButton;
    arp: TGroupBox;
    btnARP: TButton;
    findmac: TGroupBox;
    btnfindmac: TButton;
    editfindmac: TEdit;
    editgatemac: TEdit;
    TrayIconarp: TTrayIcon;
    procedure TrayIconarpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnsetipClick(Sender: TObject);
    procedure btnfindmacClick(Sender: TObject);
    procedure btnsetmacClick(Sender: TObject);
    procedure btnARPClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private

  procedure WMSysCommand( var Message: TMessage); message WM_SYSCOMMAND;  //系统托盘
    { Private declarations }
  public
    { Public declarations }
  end;


var
  formarp: Tformarp;
  ipcmd,dnscmd,maccmd: string;
  h: THandle;
  id: DWORD;
  btn: boolean;
  ini: tinifile;


implementation

{$R *.dfm}



//程序初始化
procedure Tformarp.FormCreate(Sender: TObject);
begin
  trayiconarp.Icon := application.Icon;
  id := 0;
  btn := true;
  ini := Tinifile.Create('arptmp.ini');             //读配置文件
  editmyip.Text := ini.ReadString('IP','myip','192.168.1.100');
  editsubnet.Text := ini.ReadString('IP','subnet','255.255.255.0');
  editgateip.Text := ini.ReadString('IP','gateip','192.168.1.1');
  editdns.Text := ini.ReadString('IP','dns','8.8.8.8');
  editgatemac.Text := ini.ReadString('mac','gatemac','ff-ff-ff-ff-ff-ff');
end;



//系统托盘事件
procedure Tformarp.WMSysCommand(var Message:TMessage);
begin
   if Message.WParam = SC_MINIMIZE then
     begin
      Formarp.Visible := False;
     end
   else
     begin
     DefWindowProc(Formarp.Handle,Message.Msg,Message.WParam,Message.LParam);
   end;
end;

procedure Tformarp.TrayIconarpClick(Sender: TObject);
begin
  Formarp.Visible := True;
end;



//获取MAC函数
Function sendarp(ipaddr:ulong; temp:dword; ulmacaddr:pointer; ulmacaddrleng:pointer) : DWord; StdCall; External 'Iphlpapi.dll' Name 'SendARP';



//设ip
procedure Tformarp.btnsetipClick(Sender: TObject);
var
  Aip: ulong;
  Amac: array[0..5] of byte;
  Amaclength: ulong;
  Ai: dword;
begin
  ipcmd := 'netsh interface ip set address name="本地连接"   source=static addr="' + editmyip.Text + '"  mask="' + editsubnet.Text + '"  gateway="' + editgateip.Text + '"  gwmetric=1';
  dnscmd := 'netsh interface ip set dns name="本地连接" source=static addr="' + editdns.Text + '" register=PRIMARY';
  winexec(PAnsiChar(AnsiString(ipcmd)),sw_hide);            //调用cmd命令设ＩＰ
  winexec(PAnsiChar(AnsiString(dnscmd)),sw_hide);
  Aip := inet_addr(PAnsiChar(AnsiString(editgateip.Text)));  //同时获取网关mac
  Amaclength := length(Amac);
  Ai := sendarp(Aip,0,@Amac,@Amaclength);
  if Ai = NO_ERROR then
    begin
      editgatemac.Text := format('%2.2x-%2.2x-%2.2x-%2.2x-%2.2x-%2.2x', [Amac[0],Amac[1],Amac[2],Amac[3],Amac[4],Amac[5]]);
    end
  else
    begin
      editgatemac.Text := '网关IP不正确！';
  end;
  ini.writestring('ip','myip',editmyip.Text);               //保存ＩＰ设置
  ini.writestring('ip','subnet',editsubnet.Text);
  ini.writestring('ip','gateip',editgateip.Text);
  ini.writestring('ip','dns',editdns.Text);
  ini.writestring('mac','gatemac',editgatemac.Text);
end;



//查MAC
procedure Tformarp.btnfindmacClick(Sender: TObject);
var
  Aip: ulong;
  Amac: array[0..5] of byte;
  Amaclength: ulong;
  Ai: dword;
begin
  Aip := inet_addr(PAnsiChar(AnsiString(editfindmac.Text)));
  Amaclength := length(Amac);
  Ai := sendarp(Aip,0,@Amac,@Amaclength);
  if Ai = NO_ERROR then
    begin
      editfindmac.Text := format('%2.2x-%2.2x-%2.2x-%2.2x-%2.2x-%2.2x', [Amac[0],Amac[1],Amac[2],Amac[3],Amac[4],Amac[5]]);
    end
    else
      begin
      editfindmac.Text := '该主机不在线！';
  end;
end;


//设MAC
procedure Tformarp.btnsetmacClick(Sender: TObject);
begin
  maccmd := 'arp -s  ' + Editgateip.Text + ' ' + Editgatemac.Text;
  winexec('arp -d',sw_hide);
  winexec(PAnsiChar(AnsiString(maccmd)),sw_hide);
end;


//arp函数
function Fun(p: Pointer): Integer; stdcall;
begin
  maccmd := 'arp -s  ' + formarp.Editgateip.Text + ' ' + formarp.Editgatemac.Text;
  while true do
    begin
      winexec('arp -d',sw_hide);
      winexec(PAnsiChar(AnsiString(maccmd)),sw_hide);
      sleep(3000);
    end;
end;


//开ARP
procedure Tformarp.btnARPClick(Sender: TObject); //一个按钮启动与暂停
begin
  if  btn = true then//启动线程
    begin
      if id = 0 then                //如果没有线程就创建它
        begin
          h := CreateThread(nil, 0, @Fun, nil, 0, id);
          btnarp.Caption:='暂停';
          btn := false;
          editgatemac.Color := cllime;
        end
      else                         //如果已存在线程就唤醒它
        begin
          ResumeThread(h);
          btnarp.Caption:='暂停';
          btn := false;
          editgatemac.Color := cllime;
        end;
    end
  else              //暂停线程
    begin
      SuspendThread(h);
      btnarp.Caption := '启动';
      btn := true;
      editgatemac.Color := clWindow
  end;
end;

//关闭程序
procedure Tformarp.FormDestroy(Sender: TObject);
begin
  ini.free;
end;

end.
