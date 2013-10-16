unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, RzEdit, RzLabel, RzButton, DialUp,
  RzSpnEdt, RzRadChk,inifiles, ExtCtrls,winsock, RzPanel, OleCtrls, SHDocVw,
  ImgList, bsSkinData, BusinessSkinForm;

type
  TForm1 = class(TForm)
    DialUp1: TDialUp;
    RzBitBtn1: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    RzLabel1: TRzLabel;
    RzEdit1: TRzEdit;
    RzLabel2: TRzLabel;
    RzEdit2: TRzEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    RzLabel3: TRzLabel;
    RzEdit3: TRzEdit;
    RzLabel4: TRzLabel;
    RzEdit4: TRzEdit;
    RzCheckBox1: TRzCheckBox;
    RzLabel5: TRzLabel;
    RzSpinEdit1: TRzSpinEdit;
    RzLabel6: TRzLabel;
    RzBitBtn3: TRzBitBtn;
    Memo1: TMemo;
    RzLabel7: TRzLabel;
    ComboBox1: TComboBox;
    Timer1: TTimer;
    RzPanel1: TRzPanel;
    WebBrowser1: TWebBrowser;
    Timer2: TTimer;
    Timer3: TTimer;
    ImageList1: TImageList;
    bsbsnsknfrm1: TbsBusinessSkinForm;
    bskndt1: TbsSkinData;
    bscmprsdstrdskn1: TbsCompressedStoredSkin;
    procedure FormCreate(Sender: TObject);
    procedure RzBitBtn3Click(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure WebBrowser1NavigateComplete2(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure RzPanel1Click(Sender: TObject);
  private
  procedure WriteLog(str:string);
  procedure Openurl;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  LocalFile:string;
  Rmote:string;
  SWeb:TWebBrowser;
implementation
{$R *.dfm}

//获取IP地址
function getLocalIP:string;   //获取本地机器IP地址
type 
   TaPInAddr = array [0..10] of PInAddr; 
   PaPInAddr = ^TaPInAddr;
var
   phe  : PHostEnt; 
   pptr : PaPInAddr; 
   Buffer : array [0..63] of char; 
   I    : Integer; 
   GInitData      : TWSADATA; 

begin 
   WSAStartup($101, GInitData); 
   Result := ''; 
   GetHostName(Buffer, SizeOf(Buffer)); 
   phe :=GetHostByName(buffer); 
   if phe = nil then Exit; 
   pptr := PaPInAddr(Phe^.h_addr_list); 
   I := 0; 
   while pptr^[I] <> nil do 
   begin 
     result:=StrPas(inet_ntoa(pptr^[I]^)); 
     Inc(I); 
   end; 
   WSACleanup; 
end;

procedure Delay(MSecs: Extended);
//延时函数，MSecs单位为毫秒(千分之1秒)
var
  FirstTickCount, Now: Extended;
begin
  FirstTickCount := GetTickCount();
  repeat
    Application.ProcessMessages;
    Now := GetTickCount();
  until (Now - FirstTickCount >= MSecs) or (Now < FirstTickCount);
end;
procedure TForm1.WriteLog(str:string);
begin
  memo1.Lines.Add(str+'-----'+Formatdatetime('YYYY-mm-dd hh:mm:ss',now));
  if memo1.lines.Count>=1000 then
  begin
   memo1.Lines.SaveToFile(Formatdatetime('YYYYmmddhhmmss',now)+'.txt');
   memo1.Lines.Clear;
  end;
end;
procedure TForm1.FormCreate(Sender: TObject);
var
 ini:Tinifile;
begin
 ini:=Tinifile.Create(extractfilepath(application.ExeName)+'\Config.ini');
 rzedit1.Text:=ini.ReadString('Main','UserName','LS');
 rzedit2.Text:=ini.ReadString('Main','PassWord','LS');
 LocalFile:=ini.ReadString('Main','LocalFile','LS');
 Rmote:=ini.ReadString('Main','Url','LS');
 if Ini.ReadInteger('Main','Auto',0)=1 then
  begin
  rzcheckbox1.Checked :=true;
  RzBitBtn1.Enabled:=false;
  end
 else
 begin
  rzcheckbox1.Checked :=False;
  RzBitBtn1.Enabled:=true;
  end;
 RzSpinEdit1.Text:=ini.ReadString('Main','JG','5');
 ini.Free;
 Combobox1.Items:=DialUp1.PossibleConnections;
 Combobox1.ItemIndex:=0;
 timer1.Interval:=strtoint(RzSpinEdit1.Text)*60000;
 if rzcheckbox1.Checked then timer1.Enabled:=true
 else timer1.Enabled :=false;
 writelog('系统初始化!');

end;

procedure TForm1.RzBitBtn3Click(Sender: TObject);
var
 ini:Tinifile;
begin
try
 ini:=Tinifile.Create(extractfilepath(application.ExeName)+'\Config.ini');
 ini.Writestring('Main','UserName',rzedit3.Text);
 ini.Writestring('Main','PassWord',rzedit4.Text);
 if  rzcheckbox1.Checked then ini.WriteInteger('Main','Auto',1)
 else ini.WriteInteger('Main','Auto',0);
 ini.Writestring('Main','JG',RzSpinEdit1.Text);
 ini.Free;
 showmessage('数据保存成功！请重新启动程序！');
except
 showmessage('数据保存失败！');
end;
end;

procedure TForm1.RzBitBtn1Click(Sender: TObject);
var
 myIP:string;
begin
  try
      DialUp1.Username:=Trim(rzedit1.Text);
      DialUp1.Password:=Trim(rzedit2.Text);
      DialUp1.ConnectTo:=Trim(combobox1.Text);
      DialUp1.GoOffline;
      writelog('断线成功！');
      Delay(2000);
      if DialUp1.GoOnline then
      begin
       delay(1000);
       myIP:=getLocalIP;
       writelog('连接成功,本机IP:'+myip+'！');
       Openurl;
      end;
  except
    writelog('连接出错，请检查连接文件中用户名和密码！');
  end;
end;

procedure TForm1.RzBitBtn2Click(Sender: TObject);
begin
 try
  DialUp1.GoOffline;
  writelog('断线成功！');
 except
  writelog('断线失败！');
 end;
end;
procedure TForm1.Openurl;

begin
SWeb:=TWebBrowser.Create(self);
Sweb.Navigate(Rmote);
end;

procedure TForm1.WebBrowser1NavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
 Timer2.Enabled :=True;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
 var
  H,hc:   HWND;
  begin
  H   :=   findwindow(nil,   'Microsoft Internet Explorer');
      if   H   >   0   then
          begin
              hc   :=   FindWindowEx(h,0,'Button','确定');
              SendMessage(hc,   BM_CLICK,   0,   0);
              Timer2.Enabled :=False;
              timer3.Enabled:=true;
          end;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
   var
  H,hc:   HWND;

  begin
  H   :=   findwindow(nil,   'Microsoft Internet Explorer');
      if   H   >   0   then
          begin
              hc   :=   FindWindowEx(h,0,'Button','是(&Y)');
              SendMessage(hc,   BM_CLICK,   0,   0);
             Timer3.Enabled :=False;
             RzBitBtn2Click(sender);
             DeleteFile(pchar('C:\Documents and Settings\Administrator\Cookies\'+LocalFile));
             Sweb.Free;
          end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled :=False;
  timer2.Enabled :=False;
  Timer3.Enabled:=False;
  RzBitBtn1Click(sender);
  Timer1.Enabled:=true;
end;

procedure TForm1.RzPanel1Click(Sender: TObject);
begin
  showmessage('如有技术问题请联系!请不要用于非法用途,后果自负!');
end;

end.
