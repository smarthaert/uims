unit Umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPServer,StrUtils,
  IdTCPConnection, IdTCPClient, IdDayTime, IdSocks, SkinCaption,
  WinSkinData, ComCtrls, Buttons;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    EdtPort: TEdit;
    IdTCPServer: TIdTCPServer;
    IdSocksInfo1: TIdSocksInfo;
    IdDayTime1: TIdDayTime;
    LbLog: TMemo;
    Button1: TButton;
    SkinData1: TSkinData;
    SkinCaption1: TSkinCaption;
    StatusBar1: TStatusBar;
    WebHost: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    WebHostPort: TEdit;
    BitBtn1: TBitBtn;
    procedure IdTCPServerConnect(AThread: TIdPeerThread);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EdtPortChange(Sender: TObject);
    procedure WebHostChange(Sender: TObject);
    procedure WebHostPortChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    procedure GetTimeSyncTime(THost,TPort:string);
   // procedure FormMin(var Msg: TWMSYSCOMMAND); message WM_SYSCOMMAND; //截取窗口右上角的关闭按钮事件
  public
    { Public declarations }
  end;
TRWINI = function(RT:integer;INIPATH:string;Item,ItemDetail,Value:string):pchar; stdcall;
var
  Form2: TForm2;
  //s:='TER' : string;
  s : string;
  //s:='TER';
  TipTime:string;
implementation

uses Utip;

{$R *.dfm}
//定义动态调用DLL读取本地INI文件中inifile参数,取得远程ini文件路径
function ReadINI(Item,detail:string):string;
var DLLHandle: THandle;
    Func:TRWINI;
begin
  DLLHandle:= LoadLibrary('RWINI.dll');
  try
    @Func := GetProcAddress(DLLHandle, 'RWINI');
    if Assigned(@Func) then
       begin
         result:=Func(1,ExtractFilePath(Application.ExeName)+'config.ini',Item,detail,'');
       end;
  finally
    FreeLibrary(DLLHandle);
  end;
end;
//定义动态调用DLL写本地INI文件中inifile参数
function WriteINI(Item,detail:string;value:string):string;
var DLLHandle: THandle;
    Func:TRWINI;
begin
  DLLHandle:= LoadLibrary('RWINI.dll');
  try
    @Func := GetProcAddress(DLLHandle, 'RWINI');
    if Assigned(@Func) then
       begin
         result:=Func(2,ExtractFilePath(Application.ExeName)+'config.ini',Item,detail,value);
       end;
  finally
    FreeLibrary(DLLHandle);
  end;
end; 
//截取窗口右上角的关闭按钮事件
{procedure TForm2.FormMin(var Msg: TWMSYSCOMMAND);
begin
  if (Msg.CmdType=SC_CLOSE) then
    Msg.CmdType:=SC_MINIMIZE;  //使其最小化
  Inherited;
end;  }

//取得互联网时间并同步客户时间过程
procedure Tform2.GetTimeSyncTime(THost,TPort:string);
var
//  s : string;
  dtime : TDatetime;
begin
  IdDayTime1 .Host := THost ;
  IdDayTime1 .Port :=strtoint(TPort);
  IdSocksInfo1.Version:=svNoSocks ;
  try
    s := IdDayTime1 .DayTimeStr ;
  except
     //s:='服务端获取互联网时间出错!请检查服务器的网络或互联网校时服务器是否不能访问...';
     s:='TER';
     Exit;
  end;
  s := copy(s,7,17);
  dtime:= strtodatetime(s);
  s:= datetimetostr((dtime+8/24));
  //s:=DateToStr(now)+' '+TimeToStr(now);
  //SetSystemtime2 (dtime+8/24);
end;

procedure TForm2.IdTCPServerConnect(AThread: TIdPeerThread);
var T:string;
begin
  GetTimeSyncTime(ReadINI('互联网校时服务器','服务器地址'),ReadINI('互联网校时服务器','连接端口'));
  T:=s;
  if T = 'TER' then
     begin
     LbLog.Lines.Add(datetimetostr(now)+' 获取互联网时间出错!请检查服务器的网络或互联网校时服务器是否不能访问...');
     //exit;
     end
  else
    LbLog.Lines.Add(S);
  // AThread.Connection.WriteLn('OK');
  AThread.Connection.WriteLn(s);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
//IdTCPServer.DefaultPort := StrToInt(EdtPort.Text);
//IdTCPServer.Active := True;
EdtPort.Text :=trim(ReadINI('连接设置','连接端口'));
WebHost.Text :=trim(ReadINI('互联网校时服务器','服务器地址'));
WebHostPort.Text :=trim(ReadINI('互联网校时服务器','连接端口'));
Button1Click(sender);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
IdTCPServer.Active := false;
IdTCPServer.DefaultPort := StrToInt(EdtPort.Text);
IdTCPServer.Active := True;
lblog.Lines.Add(datetimetostr(now)+' 服务端启动成功!');
application.Title :='校时服务器'+'   运行中...';
end;

procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  IdTCPServer.Active := false;
 { if MessageBox(Handle, '是否退出校时服务端?', '提示', MB_ICONQUESTION or MB_YESNO) = IDYES then
     begin
       IdTCPServer.Active := false;
       application.Terminate ;
     end
  else
    canclose:= false;  }
end;

procedure TForm2.EdtPortChange(Sender: TObject);
begin
  writeini('连接设置','连接端口',trim(EdtPort.Text));
end;

procedure TForm2.WebHostChange(Sender: TObject);
begin
  writeini('互联网校时服务器','服务器地址',trim(WebHost.Text));
end;

procedure TForm2.WebHostPortChange(Sender: TObject);
begin
  writeini('互联网校时服务器','连接端口',trim(WebHostPort.Text));
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
var T:string;
begin
  GetTimeSyncTime(ReadINI('互联网校时服务器','服务器地址'),ReadINI('互联网校时服务器','连接端口'));
  T:=s;
  if T = 'TER' then
     begin
     LbLog.Lines.Add(datetimetostr(now)+' 获取互联网时间出错!请检查服务器的网络或互联网校时服务器是否不能访问...');
     TipTime:=datetimetostr(now);
     exit;
     end
  else
    begin
    LbLog.Lines.Add(S);
    TipTime:=s;
   // showmessage(s);
    end;

 // showmessage(TipTime);
  tip:=Ttip.Create(self);
  tip.ShowModal;
  tip.Free;
end;

end.
