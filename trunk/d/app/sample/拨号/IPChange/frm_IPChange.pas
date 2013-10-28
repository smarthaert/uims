unit frm_IPChange;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Registry, StdCtrls, XPMan, ExtCtrls;

type
  TFrmIPAddr = class(TForm)
    GBxIPList: TGroupBox;
    EdIPaddr: TEdit;
    BtnReadIp: TButton;
    BtnWrite: TButton;
    RGCardList: TRadioGroup;
    procedure BtnReadIpClick(Sender: TObject);
    procedure BtnWriteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RGCardListClick(Sender: TObject);
  private
    CardIdLt:TStrings;
    function readIPAddr:string;
    procedure setIPAddr(const IPaddr:string);
    Procedure GetCard;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmIPAddr: TFrmIPAddr;

implementation

{$R *.dfm}

function TFrmIPAddr.readIPAddr:string;
var
  reg:TRegistry;
  name:array [0..255] of char;
  ID,CardNum:string;
  Psize:Dword;
begin
  reg:=TRegistry.Create;
  name:='';
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  ID:=RGcardList.Items.Strings[RGCardList.itemindex];
  cardNum:=copy(ID,pos(';',ID)+1,length(ID));
  reg.CloseKey;
  if length(CardNum) < 2 then
    CardNum:='00'+CardNum;
  if LengTh(CardNum) < 3 then
    CardNum:='0'+CardNum;
  reg.OpenKey('SYSTEM\ControlSet'+CardNum+'\Services',false);
  reg.OpenKey('Tcpip\Parameters\Interfaces',false);
  ID:=CardIdLt.Strings[CardIDLt.IndexOf(ID)+1];
  reg.OpenKey(id,false);
  RegqueryValueEx(reg.CurrentKey,'IPAddress',nil,nil,@name,@Psize);
  result:=copy(name,0,strlen(name));
  Reg.CloseKey;
  reg.Free;
end;




Procedure TFrmIPAddr.GetCard;
var
  reg:TRegistry;
  i:integer;
  name:array [0..255] of char;
  ID:string;
  lS:TStrings;
begin
  ls:=TStringlist.Create;
  reg:=TRegistry.Create;
  name:='';
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  ID:='SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkCards\';
  reg.OpenKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkCards',false);
  Reg.GetKeyNames(Ls);
  for i:=0 to Ls.Count-1 do
  begin
    reg.CloseKey;
    reg.OpenKey(ID+ls.Strings[i],false);
    RGCardList.Items.Add(reg.ReadString('Description')+';'+inttostr(i+1));
    CardIdLt.Add(reg.ReadString('Description')+';'+inttostr(i+1));
    CardIdLt.Add(reg.ReadString('ServiceName'));
  end;
  RGCardList.ItemIndex:=0;
  ls.Free;
  reg.Free;
end;


procedure TFrmIPAddr.setIPAddr(const IPaddr:string);
var
  reg:TRegistry;
  name:array [0..255] of char;
  ID,CardNum:string;
begin
  reg:=TRegistry.Create;
  StrLcopy(name,pchar(IPaddr),length(IPaddr));
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  ID:=RGcardList.Items.Strings[RGCardList.itemindex];
  cardNum:=copy(ID,pos(';',ID)+1,length(ID));
  reg.CloseKey;
  if length(CardNum) < 2 then
    CardNum:='00'+CardNum;
  if LengTh(CardNum) < 3 then
    CardNum:='0'+CardNum;
  reg.OpenKey('SYSTEM\ControlSet'+CardNum+'\Services',false);
  reg.OpenKey('Tcpip\Parameters\Interfaces',false);
  ID:=CardIdLt.Strings[CardIDLt.IndexOf(ID)+1];
  reg.OpenKey(id,false);
  RegSetValueEx(reg.CurrentKey,'IPAddress',0,REG_MULTI_SZ,@name,13);
  Reg.CloseKey;
  reg.Free;
end;

procedure TFrmIPAddr.BtnReadIpClick(Sender: TObject);
begin
  EDIPaddr.Text:=readIPAddr;
end;

procedure TFrmIPAddr.BtnWriteClick(Sender: TObject);
begin
  if Application.MessageBox('您确认IP地址书写正确和修改本机IP地址吗？','提示',MB_YESNO+MB_ICONQUESTION) = ID_YES then
  begin
  if trim(EDipAddr.Text) <> '' then
    setIPAddr(EDIpAddr.Text);
    showmessage('请您重新启动计算机！');
  end;
end;

procedure TFrmIPAddr.FormCreate(Sender: TObject);
begin
  CardIdLt:=TStringlist.Create;
end;

procedure TFrmIPAddr.FormDestroy(Sender: TObject);
begin
  CardIdLt.Free;
end;

procedure TFrmIPAddr.FormShow(Sender: TObject);
begin
  GetCard;
end;

procedure TFrmIPAddr.RGCardListClick(Sender: TObject);
begin
  EDIPaddr.Text:=readIPAddr;
end;

end.
