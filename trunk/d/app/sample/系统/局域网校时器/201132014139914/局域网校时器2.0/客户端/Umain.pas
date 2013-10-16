unit Umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdAntiFreezeBase, IdAntiFreeze, SkinCaption, WinSkinData,
  ComCtrls, Buttons;

type
  TForm1 = class(TForm)
    EdtHost: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EdtPort: TEdit;
    BtnConnect: TButton;
    IdTCPClient: TIdTCPClient;
    IdAntiFreeze1: TIdAntiFreeze;
    LbLog: TMemo;
    SkinData1: TSkinData;
    SkinCaption1: TSkinCaption;
    StatusBar1: TStatusBar;
    CB1: TCheckBox;
    CB2: TCheckBox;
    BitBtn1: TBitBtn;
    procedure BtnConnectClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CB1Click(Sender: TObject);
    procedure CB2Click(Sender: TObject);
    procedure EdtHostChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
TRWINI = function(RT:integer;INIPATH:string;Item,ItemDetail,Value:string):pchar; stdcall;
var
  Form1: TForm1;
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
//设置客户机系统时钟
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
  // If Result then ShowMessage('成功改变时间!');
End;

procedure TForm1.BtnConnectClick(Sender: TObject);
var T:string;
begin
  IdTCPClient.Disconnect();
  IdTCPClient.Host := EdtHost.Text;
  IdTCPClient.Port := StrToInt(EdtPort.Text);
  with IdTCPClient do
    begin
      try
        Connect(5000);
          try  
            T:=trim(ReadLn());
            if T = 'TER' then
               begin
                 LbLog.lines.Add(datetimetostr(now)+' 服务端获取互联网时间出错!请检查服务器的网络或互联网校时服务器是否不能访问...');
                 exit;
               end
            else
              LbLog.lines.Add(T);
            if ReadINI('自动设置系统时间','开关') = '1' then
               begin
                 SetSystemtime2(strtodatetime(T));
               end
            else
              begin
                if cb1.Checked = true then
                   SetSystemtime2(strtodatetime(T));
              end;
            TipTime:=T;
            if ReadINI('弹出提示窗','开关') = '1' then
               begin
                 tip:=Ttip.Create(self);
                 tip.ShowModal;
                 tip.Free;
               end;
          except
            LbLog.lines.Add(datetimetostr(now)+' 远程主机无响应！');
            IdTCPClient.Disconnect();
            //MessageBox(Handle, '校时失败', '错误提示', MB_ICONEXCLAMATION);
          end;//end try
      except
        LbLog.lines.Add(datetimetostr(now)+' 无法建立到' + EdtHost.Text + '的连接！');
        //MessageBox(Handle, '校时失败', '错误提示', MB_ICONEXCLAMATION);
      end;//end try
    end;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  IdTCPClient.Disconnect();
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
BtnConnectClick(sender);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if readini('自动设置系统时间','开关') = '1' then cb1.Checked :=true
  else cb1.Checked :=false;
  if readini('弹出提示窗','开关') = '1' then cb2.Checked :=true
  else cb2.Checked :=false;
  LbLog.Lines.Add(datetimetostr(now)+' 正在连接...'); 
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  EdtHost.Text:=trim(ReadINI('服务器连接设置','IP地址'));
  EdtPort.Text:=trim(ReadINI('服务器连接设置','连接端口'));
end;

procedure TForm1.CB1Click(Sender: TObject);
begin
  if cb1.Checked = true then writeini('自动设置系统时间','开关','1')
  else writeini('自动设置系统时间','开关','0');
end;

procedure TForm1.CB2Click(Sender: TObject);
begin
  if cb2.Checked = true then writeini('弹出提示窗','开关','1')
  else writeini('弹出提示窗','开关','0');
end;

procedure TForm1.EdtHostChange(Sender: TObject);
begin
  writeini('服务器连接设置','IP地址',trim(EdtHost.Text));
  writeini('服务器连接设置','连接端口',trim(EdtPort.Text));
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  application.Terminate ;   
end;

end.
