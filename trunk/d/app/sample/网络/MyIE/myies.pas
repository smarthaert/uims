unit myies;
// Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls,Registry,wininet, ExtCtrls, StdCtrls, Buttons, jpeg,
  CoolTrayIcon, XPMenu, Menus;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    GroupBox1: TGroupBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton25: TSpeedButton;
    SpeedButton26: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SpeedButton22: TSpeedButton;
    SpeedButton21: TSpeedButton;
    SpeedButton23: TSpeedButton;
    SpeedButton24: TSpeedButton;
    SpeedButton19: TSpeedButton;
    SpeedButton20: TSpeedButton;
    GroupBox2: TGroupBox;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton27: TSpeedButton;
    SpeedButton28: TSpeedButton;
    SpeedButton29: TSpeedButton;
    SpeedButton30: TSpeedButton;
    SpeedButton31: TSpeedButton;
    SpeedButton32: TSpeedButton;
    SpeedButton33: TSpeedButton;
    SpeedButton34: TSpeedButton;
    SpeedButton35: TSpeedButton;
    SpeedButton36: TSpeedButton;
    SpeedButton37: TSpeedButton;
    SpeedButton38: TSpeedButton;
    SpeedButton39: TSpeedButton;
    SpeedButton40: TSpeedButton;
    SpeedButton41: TSpeedButton;
    SpeedButton42: TSpeedButton;
    SpeedButton43: TSpeedButton;
    SpeedButton44: TSpeedButton;
    GroupBox3: TGroupBox;
    SpeedButton45: TSpeedButton;
    SpeedButton46: TSpeedButton;
    SpeedButton47: TSpeedButton;
    SpeedButton48: TSpeedButton;
    SpeedButton49: TSpeedButton;
    SpeedButton50: TSpeedButton;
    SpeedButton51: TSpeedButton;
    SpeedButton52: TSpeedButton;
    SpeedButton53: TSpeedButton;
    SpeedButton54: TSpeedButton;
    SpeedButton55: TSpeedButton;
    SpeedButton56: TSpeedButton;
    SpeedButton57: TSpeedButton;
    SpeedButton58: TSpeedButton;
    SpeedButton59: TSpeedButton;
    SpeedButton60: TSpeedButton;
    SpeedButton61: TSpeedButton;
    SpeedButton62: TSpeedButton;
    SpeedButton63: TSpeedButton;
    SpeedButton64: TSpeedButton;
    SpeedButton65: TSpeedButton;
    SpeedButton66: TSpeedButton;
    SpeedButton67: TSpeedButton;
    SpeedButton68: TSpeedButton;
    SpeedButton69: TSpeedButton;
    SpeedButton70: TSpeedButton;
    SpeedButton71: TSpeedButton;
    SpeedButton72: TSpeedButton;
    SpeedButton73: TSpeedButton;
    SpeedButton74: TSpeedButton;
    SpeedButton75: TSpeedButton;
    SpeedButton76: TSpeedButton;
    TabSheet4: TTabSheet;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    SpeedButton77: TSpeedButton;
    SpeedButton78: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Edit3: TEdit;
    SpeedButton79: TSpeedButton;
    SpeedButton80: TSpeedButton;
    SpeedButton81: TSpeedButton;
    Label5: TLabel;
    Timer1: TTimer;
    SpeedButton82: TSpeedButton;
    Label6: TLabel;
    SpeedButton83: TSpeedButton;
    SpeedButton84: TSpeedButton;
    SpeedButton85: TSpeedButton;
    SpeedButton86: TSpeedButton;
    Image1: TImage;
    Panel1: TPanel;
    SpeedButton87: TSpeedButton;
    SpeedButton88: TSpeedButton;
    Comments: TLabel;
    Timer2: TTimer;
    XPMenu1: TXPMenu;
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton25Click(Sender: TObject);
    procedure SpeedButton26Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton17Click(Sender: TObject);
    procedure SpeedButton18Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure SpeedButton21Click(Sender: TObject);
    procedure SpeedButton22Click(Sender: TObject);
    procedure SpeedButton23Click(Sender: TObject);
    procedure SpeedButton24Click(Sender: TObject);
    procedure SpeedButton19Click(Sender: TObject);
    procedure SpeedButton20Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton28Click(Sender: TObject);
    procedure SpeedButton27Click(Sender: TObject);
    procedure SpeedButton29Click(Sender: TObject);
    procedure SpeedButton30Click(Sender: TObject);
    procedure SpeedButton31Click(Sender: TObject);
    procedure SpeedButton32Click(Sender: TObject);
    procedure SpeedButton33Click(Sender: TObject);
    procedure SpeedButton34Click(Sender: TObject);
    procedure SpeedButton35Click(Sender: TObject);
    procedure SpeedButton36Click(Sender: TObject);
    procedure SpeedButton37Click(Sender: TObject);
    procedure SpeedButton38Click(Sender: TObject);
    procedure SpeedButton39Click(Sender: TObject);
    procedure SpeedButton40Click(Sender: TObject);
    procedure SpeedButton41Click(Sender: TObject);
    procedure SpeedButton42Click(Sender: TObject);
    procedure SpeedButton43Click(Sender: TObject);
    procedure SpeedButton44Click(Sender: TObject);
    procedure SpeedButton45Click(Sender: TObject);
    procedure SpeedButton46Click(Sender: TObject);
    procedure SpeedButton47Click(Sender: TObject);
    procedure SpeedButton48Click(Sender: TObject);
    procedure SpeedButton49Click(Sender: TObject);
    procedure SpeedButton50Click(Sender: TObject);
    procedure SpeedButton61Click(Sender: TObject);
    procedure SpeedButton62Click(Sender: TObject);
    procedure SpeedButton63Click(Sender: TObject);
    procedure SpeedButton64Click(Sender: TObject);
    procedure SpeedButton68Click(Sender: TObject);
    procedure SpeedButton67Click(Sender: TObject);
    procedure SpeedButton69Click(Sender: TObject);
    procedure SpeedButton70Click(Sender: TObject);
    procedure SpeedButton71Click(Sender: TObject);
    procedure SpeedButton72Click(Sender: TObject);
    procedure SpeedButton75Click(Sender: TObject);
    procedure SpeedButton76Click(Sender: TObject);
    procedure SpeedButton73Click(Sender: TObject);
    procedure SpeedButton74Click(Sender: TObject);
    procedure SpeedButton51Click(Sender: TObject);
    procedure SpeedButton52Click(Sender: TObject);
    procedure SpeedButton53Click(Sender: TObject);
    procedure SpeedButton54Click(Sender: TObject);
    procedure SpeedButton55Click(Sender: TObject);
    procedure SpeedButton56Click(Sender: TObject);
    procedure SpeedButton57Click(Sender: TObject);
    procedure SpeedButton58Click(Sender: TObject);
    procedure SpeedButton59Click(Sender: TObject);
    procedure SpeedButton60Click(Sender: TObject);
    procedure SpeedButton65Click(Sender: TObject);
    procedure SpeedButton66Click(Sender: TObject);
    procedure SpeedButton77Click(Sender: TObject);
    procedure SpeedButton78Click(Sender: TObject);
    procedure SpeedButton79Click(Sender: TObject);
    procedure SpeedButton80Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure SpeedButton81Click(Sender: TObject);
    procedure SpeedButton82Click(Sender: TObject);
    procedure SpeedButton83Click(Sender: TObject);
    procedure SpeedButton84Click(Sender: TObject);
    procedure SpeedButton85Click(Sender: TObject);
    procedure SpeedButton86Click(Sender: TObject);
    procedure SpeedButton87Click(Sender: TObject);
    procedure SpeedButton88Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CoolTrayIcon1DblClick(Sender: TObject);
  private
    { Private declarations }
    startpage:string;
  public
    { Public declarations }
     function Get_DiskSerialNo(DriveID : char) : string;
  end;

var
  Form1: TForm1;

implementation

uses about;
var p:string;
{$R *.dfm}

//获取硬盘序列号
function tform1.Get_DiskSerialNo(DriveID : char) : string;
var
VolumeSerialNumber : DWORD;
MaximumComponentLength : DWORD;
FileSystemFlags : DWORD;
begin
result := '';
try
GetVolumeInformation(PChar(DriveID + ':\'),
nil, 0, @VolumeSerialNumber,
MaximumComponentLength, FileSystemFlags,
nil, 0);
result := IntToHex(HiWord(VolumeSerialNumber), 4) +
'-' + IntToHex(LoWord(VolumeSerialNumber), 4);
except

end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\system',true) then
 begin
      s:=dword(1);
      myregistry.WriteInteger('DisableRegistryTools',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('设置成功成功！');
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\system',true) then
 begin
      s:=dword(0);
      myregistry.WriteInteger('DisableRegistryTools',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('解除禁止成功成功！');
  end;
end;

procedure TForm1.SpeedButton25Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
  begin
      s:=dword(1);
      myregistry.WriteInteger('HomePage',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁止更改主页设置！');
  end;
end;

procedure TForm1.SpeedButton26Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
  begin
      s:=dword(0);
      myregistry.WriteInteger('HomePage',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用更改主页设置！');
  end;
end;
procedure TForm1.SpeedButton5Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(1);
      myregistry.WriteInteger('SecurityTab',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用安全项设置成功！');
  end;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(0);
      myregistry.WriteInteger('SecurityTab',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('解除禁用安全项设置成功！');
  end;
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(1);
      myregistry.WriteInteger('ContentTab',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用内容项设置成功！');
  end;
end;
procedure TForm1.SpeedButton8Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(0);
      myregistry.WriteInteger('ContentTab',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('解除禁用内容项设置成功！');
  end;
end;

procedure TForm1.SpeedButton17Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(1);
      myregistry.WriteInteger('ConnectionsTab',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用连接项设置成功！');
  end;
end;

procedure TForm1.SpeedButton18Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(0);
      myregistry.WriteInteger('ConnectionsTab',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('解除禁用连接项设置成功！');
  end;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(1);
      myregistry.WriteInteger('ProgramsTab',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用程序项设置成功！');
  end;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(0);
      myregistry.WriteInteger('ProgramsTab',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用程序项设置成功！');
  end;
end;

procedure TForm1.SpeedButton13Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(1);
      myregistry.WriteInteger('AdvancedTab',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用高级项设置成功！');
  end;
end;

procedure TForm1.SpeedButton14Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(1);
      myregistry.WriteInteger('AdvancedTab',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用高级项设置成功！');
  end;
end;

procedure TForm1.SpeedButton15Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(1);
      myregistry.WriteInteger('NoExternalBranding',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用IE的外部商标！');
  end;
end;
procedure TForm1.SpeedButton16Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(0);
      myregistry.WriteInteger('NoExternalBranding',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用IE的外部商标！');
  end;
end;
procedure TForm1.SpeedButton21Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Infodelivery\Restrictions ',true) then
  begin
      s:=dword(1);
      myregistry.WriteInteger('NoSplash',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用显示初始屏幕！');
  end;
end;
procedure TForm1.SpeedButton22Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Infodelivery\Restrictions ',true) then
  begin
      s:=dword(0);
      myregistry.WriteInteger('NoSplash',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用显示初始屏幕！');
  end;
end;

procedure TForm1.SpeedButton23Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Infodelivery\Restrictions ',true) then
  begin
      s:=dword(1);
      myregistry.WriteInteger('NoUpdateCheck',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用检查IE更新！');
  end;
end;
procedure TForm1.SpeedButton24Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Infodelivery\Restrictions ',true) then
  begin
      s:=dword(0);
      myregistry.WriteInteger('NoUpdateCheck',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用检查IE更新！');
  end;
end;

procedure TForm1.SpeedButton19Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Infodelivery',true) then
  begin
      s:=dword(1);
      myregistry.WriteInteger('RestrictionsNoJITSetup',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage(' 禁用IE组件自动安装！');
  end;
end;

procedure TForm1.SpeedButton20Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Infodelivery',true) then
  begin
      s:=dword(0);
      myregistry.WriteInteger('RestrictionsNoJITSetup',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用IE组件自动安装！');
  end;
end;
procedure TForm1.SpeedButton10Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(0);
      myregistry.WriteInteger('NoFindFiles',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用F3的查找功能！');
  end;
end;

procedure TForm1.SpeedButton9Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(1);
      myregistry.WriteInteger('NoFindFiles',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用F3的查找功能！');
  end;
end;

procedure TForm1.SpeedButton11Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(1);
      myregistry.WriteInteger('NoSearchCustomization',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用自定义搜索！');
  end;
end;

procedure TForm1.SpeedButton12Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(0);
      myregistry.WriteInteger('NoSearchCustomization',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用自定义搜索！');
  end;
end;
procedure TForm1.SpeedButton28Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(1);
      myregistry.WriteInteger('NoBrowserContextMenu',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用鼠标右键！');
  end;
end;
procedure TForm1.SpeedButton27Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(0);
      myregistry.WriteInteger('NoBrowserContextMenu',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用鼠标右键！');
  end;
end;

procedure TForm1.SpeedButton29Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(1);
      myregistry.WriteInteger('History',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用更改历史纪录设置成功！');
  end;
end;

procedure TForm1.SpeedButton30Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(0);
      myregistry.WriteInteger('History',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('解除禁用更改历史纪录设置成功！');
  end;
end;

procedure TForm1.SpeedButton31Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(1);
      myregistry.WriteInteger('Ratings',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用分级项设置成功！');
  end;
end;

procedure TForm1.SpeedButton32Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(0);
      myregistry.WriteInteger('Ratings',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('解除禁用分级项设置成功！');
  end;
end;

procedure TForm1.SpeedButton33Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(1);
      myregistry.WriteInteger('Certificates',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用更改证书项设置成功！');
  end;
end;

procedure TForm1.SpeedButton34Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(0);
      myregistry.WriteInteger('Certificates',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('解除禁用更改证书项设置成功！');
  end;
end;

procedure TForm1.SpeedButton35Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(1);
      myregistry.WriteInteger('FormSuggest',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用表单的自动完成功能设置成功！');
  end;
end;
procedure TForm1.SpeedButton36Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(0);
      myregistry.WriteInteger('FormSuggest',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('解除禁用表单的自动完成功能设置成功！');
  end;
end;
procedure TForm1.SpeedButton37Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(1);
      myregistry.WriteInteger('Profiles',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用禁止更改配置文件助理设置成功！');
  end;
end;
procedure TForm1.SpeedButton38Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(0);
      myregistry.WriteInteger('Profiles',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('解除禁用禁止更改配置文件助理设置成功！');
  end;
end;

procedure TForm1.SpeedButton39Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(1);
      myregistry.WriteInteger('DialupAutodetect',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用对拨号连接实行"自动检测"设置成功！');
  end;
end;

procedure TForm1.SpeedButton40Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Microsoft\Windows\CurrentVersion\Internet Settings',true) then
 begin
      s:=dword(0);
      myregistry.WriteInteger('DialupAutodetect',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('恢复对拨号连接实行"自动检测"设置成功！');
  end;
end;

procedure TForm1.SpeedButton41Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Microsoft\Windows\CurrentVersion\Internet Settings',true) then
 begin
      s:=dword(0);
      myregistry.WriteInteger('EnableAutoProxyResultCache',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用缓存自动代理脚本设置成功！');
  end;
end;
procedure TForm1.SpeedButton42Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Microsoft\Windows\CurrentVersion\Internet Settings',true) then
 begin
      s:=dword(1);
      myregistry.WriteInteger('EnableAutoProxyResultCache',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('解除禁用缓存自动代理脚本设置成功！');
  end;
end;


procedure TForm1.SpeedButton43Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(1);
      myregistry.WriteInteger('Connection Settings',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用更改连接设置成功！');
  end;
end;

procedure TForm1.SpeedButton44Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(0);
      myregistry.WriteInteger('Connection Settings',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('解除禁用更改连接设置成功！');
  end;
end;

procedure TForm1.SpeedButton45Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(1);
      myregistry.WriteInteger('Connwiz Admin Lock',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用连接向导设置成功！');
  end;
end;

procedure TForm1.SpeedButton46Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Control Panel',true) then
 begin
      s:=dword(0);
      myregistry.WriteInteger('Connwiz Admin Lock',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用连接向导设置成功！');
  end;
end;
procedure TForm1.SpeedButton47Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
       s:=dword(1);
      myregistry.WriteInteger('NoBrowserSaveAs',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁止用户使用"另存为"设置成功！');

  end;
end;

procedure TForm1.SpeedButton48Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
       s:=dword(0);
      myregistry.WriteInteger('NoBrowserSaveAs',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('解除禁止用户使用"另存为"设置成功！');

  end;
end;

procedure TForm1.SpeedButton49Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Infodelivery\Restrictions',true) then
  begin
      s:=dword(1);
      myregistry.WriteInteger('NoBrowserSaveWebComplete',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用另存为"Web页，全部"设置成功！');

  end;
end;

procedure TForm1.SpeedButton50Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Infodelivery\Restrictions',true) then
  begin
      s:=dword(0);
      myregistry.WriteInteger('NoBrowserSaveWebComplete',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用另存为"Web页，全部"设置成功！');

  end;
end;

procedure TForm1.SpeedButton61Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',true) then
  begin
      s:=dword(1);
      myregistry.WriteInteger('NoBandCustomize',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用自定义工具栏的按钮设置成功！');
  end;
end;

procedure TForm1.SpeedButton62Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',true) then
  begin
      s:=dword(0);
      myregistry.WriteInteger('NoBandCustomize',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用自定义工具栏的按钮设置成功！');
  end;
end;

procedure TForm1.SpeedButton63Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',true) then
  begin
      s:=dword(1);
      myregistry.WriteInteger('NoToolbarCustomize',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用自定义工具栏设置成功！');
  end;
end;

procedure TForm1.SpeedButton64Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',true) then
  begin
      s:=dword(0);
      myregistry.WriteInteger('NoToolbarCustomize',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用自定义工具栏设置成功！');
  end;
end;
procedure TForm1.SpeedButton68Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(0);
      myregistry.WriteInteger('NoBrowserOptions',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用"Internet选项"！');
  end;
end;


procedure TForm1.SpeedButton67Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(1);
      myregistry.WriteInteger('NoBrowserOptions',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用"Internet选项"！');
  end;
end;
procedure TForm1.SpeedButton69Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(1);
      myregistry.WriteInteger('NoHelpItemNetscapeHelp',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用"Netscape用户"！');
  end;
end;


procedure TForm1.SpeedButton70Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(0);
      myregistry.WriteInteger('NoHelpItemNetscapeHelp',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用"Netscape用户"！');
  end;
end;

procedure TForm1.SpeedButton71Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(1);
      myregistry.WriteInteger('NoHelpItemTipOfTheDay',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用"每日提示"！');
  end;
end;
procedure TForm1.SpeedButton72Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(0);
      myregistry.WriteInteger('NoHelpItemTipOfTheDay',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用"每日提示"！');
  end;
end;

procedure TForm1.SpeedButton75Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(1);
      myregistry.WriteInteger('NoHelpItemSendFeedback',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用"发送反馈意见"！');
  end;
end;

procedure TForm1.SpeedButton76Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(0);
      myregistry.WriteInteger('NoHelpItemSendFeedback',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用"发送反馈意见"！');
  end;
end;
procedure TForm1.SpeedButton73Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(1);
      myregistry.WriteInteger('NoHelpItemTutorial',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用"教程"！');
  end;
end;

procedure TForm1.SpeedButton74Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(0);
      myregistry.WriteInteger('NoHelpItemTutorial',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用"教程"！');
  end;
end;
procedure TForm1.SpeedButton51Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(1);
      myregistry.WriteInteger('NoBrowserClose',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用关闭浏览器设置成功！');

  end;
end;

procedure TForm1.SpeedButton52Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(0);
      myregistry.WriteInteger('NoBrowserClose',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用关闭浏览器设置成功！');

  end;
end;

procedure TForm1.SpeedButton53Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(1);
      myregistry.WriteInteger('NoFileNew',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用“新建”设置成功！');

  end;
end;


procedure TForm1.SpeedButton54Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(0);
      myregistry.WriteInteger('NoFileNew',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用“新建”设置成功！');

  end;
end;
procedure TForm1.SpeedButton55Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(1);
      myregistry.WriteInteger('NoFileOpen',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用“打开”设置成功！');

  end;
end;

procedure TForm1.SpeedButton56Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(0);
      myregistry.WriteInteger('NoFileOpen',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用“打开”设置成功！');

  end;
end;

procedure TForm1.SpeedButton57Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(1);
      myregistry.WriteInteger('NoTheaterMode',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用“全屏”设置成功！');

  end;
end;


procedure TForm1.SpeedButton58Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(0);
      myregistry.WriteInteger('NoTheaterMode',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用“全屏”设置成功！');

  end;
end;
procedure TForm1.SpeedButton59Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(1);
      myregistry.WriteInteger('NoViewSourc',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用“源文件”设置成功！');
  end;
end;
procedure TForm1.SpeedButton60Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(0);
      myregistry.WriteInteger('NoViewSourc',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用“源文件”设置成功！');
  end;
end;

procedure TForm1.SpeedButton65Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(1);
      myregistry.WriteInteger('NoFavorites',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('禁用收藏成功！');
  end;
end;

procedure TForm1.SpeedButton66Click(Sender: TObject);
var myregistry:tregistry;
    s:dword;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Policies\Microsoft\Internet Explorer\Restrictions',true) then
  begin
      s:=dword(0);
      myregistry.WriteInteger('NoFavorites',s);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('启用藏成功！');
  end;
end;

procedure TForm1.SpeedButton77Click(Sender: TObject);
var myregistry:tregistry;
    tt:string;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_LOCAL_MACHINE;
if myregistry.OpenKey('Software\Microsoft\Internet Explorer\Main',true) then
  begin
      tt:=edit1.Text ;
      myregistry.WriteString('Window Title',tt);
      myregistry.CloseKey;
      myregistry.Free;
      //showmessage('我的IE标题设置成功');
  end;
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Microsoft\Internet Explorer\Main',true) then
  begin
      tt:=edit1.Text ;
      myregistry.WriteString('Window Title',tt);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('我的IE标题设置成功');
  end;

end;

procedure TForm1.SpeedButton78Click(Sender: TObject);
var myregistry:tregistry;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_LOCAL_MACHINE;
if myregistry.OpenKey('Software\Microsoft\Internet Explorer\Main',true) then
  begin
      myregistry.DeleteValue('Window Title');
      myregistry.CloseKey;
      myregistry.Free;
  end;
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Microsoft\Internet Explorer\Main',true) then
  begin
      myregistry.DeleteValue('Window Title') ;
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('我的IE标题被清除了！');

  end;

end;
procedure TForm1.SpeedButton79Click(Sender: TObject);
var myregistry:tregistry;
    tt:string;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_LOCAL_MACHINE;
if myregistry.OpenKey('Software\Microsoft\Windows\CurrentVersion\Winlogon',true) then
  begin
      tt:=edit2.Text ;
      myregistry.WriteString('LegalNoticeCaption',tt);
      tt:=edit3.text;
      myregistry.WriteString('LegalNoticeText',tt);
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('我的开机信息设置成功');
  end;
end;
procedure TForm1.SpeedButton80Click(Sender: TObject);
var myregistry:tregistry;
   // tt:string;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_LOCAL_MACHINE;
if myregistry.OpenKey('Software\Microsoft\Windows\CurrentVersion\Winlogon',true) then
  begin
      //tt:=edit2.Text ;
      myregistry.DeleteValue('LegalNoticeCaption');
      //tt:=edit3.text;
      myregistry.DeleteValue('LegalNoticeText');
      myregistry.CloseKey;
      myregistry.Free;
      showmessage('我的开机信息被清除了！');
  end;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
var myregistry:tregistry;
    tt:string;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Microsoft\Internet Explorer\Main',true) then
  begin
      tt:=myregistry.ReadString('Start Page');
      if tt<>startpage then
      begin
      myregistry.WriteString('Start Page',startpage);
      end;
      myregistry.CloseKey;
      myregistry.Free;
  end;
end;



procedure TForm1.SpeedButton81Click(Sender: TObject);
var myregistry:tregistry;
begin
myregistry:=tregistry.Create;
myregistry.RootKey:=HKEY_CURRENT_USER;
if myregistry.OpenKey('Software\Microsoft\Internet Explorer\Main',true) then
  begin
      startpage:=myregistry.ReadString('Start Page');
      myregistry.CloseKey;
      myregistry.Free;
      timer1.Enabled:=true;
      showmessage('别人不会改我的主页了！');
      speedbutton81.Enabled:=false;
      speedbutton82.Enabled:=true;
  end;
end;


procedure TForm1.SpeedButton82Click(Sender: TObject);
begin
timer1.Enabled:=false;
speedbutton81.Enabled:=true;
speedbutton82.Enabled:=false;
showmessage('别人可修改你的主页，要小心了！');
end;

procedure TForm1.SpeedButton83Click(Sender: TObject);
var
  cache_info:PInternetCacheEntryInfo;
  cbSizeOf_Cache_info:dword;
  hw:hwnd;
  buf:tstrings;
begin
//删除IEcache0
  new(cache_info);
  hw:=FindFirstUrlCacheEntryEx(nil,0,NORMAL_CACHE_ENTRY or URLHISTORY_CACHE_ENTRY,0,cache_info,@cbSizeOf_Cache_info,nil,nil,nil);
  if hw<>0 then
  begin
    DeleteUrlCacheEntry(cache_info.lpszSourceUrlName);
    while FindNextUrlCacheEntryEx(hw,cache_info,@cbSizeOf_Cache_info,nil,nil,nil) do
      DeleteUrlCacheEntry(cache_info.lpszSourceUrlName);
  end;
  FindCloseUrlCache(hw);
  dispose(cache_info);
  showmessage('删除IE Cache 成功！');
end;

procedure TForm1.SpeedButton84Click(Sender: TObject);
var ss:string;
    c:string;
begin
c:=inputbox('输入硬盘ID','请输入欲获取的硬盘ID(c,d,...)','c');
ss:=form1.Get_DiskSerialNo('c');
showmessage(ss);
end;

procedure TForm1.SpeedButton85Click(Sender: TObject);
var
b: Bool;
begin
//Application.Initialize;
{ 首先检查屏幕保护程序是否存在 }
if (SystemParametersInfo(SPI_GETSCREENSAVEACTIVE, 0, @b, 0)) and (b) then
begin
{ 调用屏幕保护 }
PostMessage(GetDesktopWindow, WM_SYSCOMMAND, SC_SCREENSAVE, 0);
end
else
begin
showmessage('屏保不存在！');
//Application.Terminate;

end;

end;
procedure TForm1.SpeedButton86Click(Sender: TObject);
var
biosname,bioscopyright,biosdate,biosid:string;
begin
biosname:=^I+string(Pchar(Ptr($FE061)));
bioscopyright:=^I+string(Pchar(Ptr($FE091)));
biosdate:=^I+string(Pchar(Ptr($FFFF5)));
biosid:=^I+string(Pchar(Ptr($FEC71)));
showmessage('bios的名称为:'+biosname+' 版权为:'+bioscopyright+'日期为:'+biosdate+'序列号为:'+biosid);
end;


procedure TForm1.SpeedButton87Click(Sender: TObject);
begin
aboutbox.show;
//form1.Hide ;
form1.Enabled :=false;
aboutbox.enabled:=true;
end;

procedure TForm1.SpeedButton88Click(Sender: TObject);
begin
application.Terminate ;
end;

procedure TForm1.Timer2Timer(Sender: TObject);

begin
if (comments.top>=104) and (comments.top<=320) and (p='0') then
begin
Comments.top:=comments.top-5;
comments.Update ;
end;
if (comments.top>=104) and (comments.top<=320)and (p='1') then
begin
Comments.top:=comments.top+5;
comments.Update ;
end;
if comments.top<104 then
begin
p:='1';
comments.Top:=104;
end;
if comments.top>320 then
begin
p:='0';
comments.Top:=320;
end;


end;

procedure TForm1.FormCreate(Sender: TObject);
begin
p:='0';
end;

procedure TForm1.CoolTrayIcon1DblClick(Sender: TObject);
begin
form1.Show;
form1.Enabled:=true;
end;

end.
