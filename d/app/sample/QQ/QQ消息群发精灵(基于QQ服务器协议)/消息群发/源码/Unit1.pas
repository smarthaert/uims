//**********************************
//源码名称：QQ消息群发精灵(基于QQ服务器协议)
//开发环境：Delphi7.0+WinXP
//源码作者：源码天空
//官方网站：http://www.codesky.net
//特别感谢：微程 提供QQ协议分析
//请尊重原作者的劳动，你可以任意修改源码，但请保持以上信息的完整性。
// **********************************
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP,UnitMD5,comctrls,UnitSkipQQ,inifiles, HttpProt,
  Gauges, ExtCtrls;

type
  TfrmMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    edtQQPws: TEdit;
    edtQQNumber: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button3: TButton;
    GroupBox2: TGroupBox;
    meoQQMsg: TMemo;
    ProgressBar1: TGauge;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    cnt:integer;
    function split(s,s1:string):TStringList;
    function GetQQList(QQNumber,QQPws:String):String;
    procedure ReadData;
  public
    { Public declarations }
    SkipQQ:String;
  end;

  
TSendMsg= class(TThread)
  public
    constructor Create(tQQNumberList:TStringList;tSkipQQ:String;tMsg:String;tUserQQ:String;tUserPws:string;progress:TComponent);
  private
    { Private declarations }
    QQNumberList:TStringList;
    UserQQ,UserPws,Msg,SkipQQ:String;
    FProgress:TGauge;
    procedure SetProgressPos(p:integer);
    function PostMsg(url,para:String;TimeOut:Integer):String;
  protected
    procedure Execute; override;
    procedure Terminate;
end;

var
  frmMain: TfrmMain;
  SendMsg:TSendMsg;

implementation
uses UnitAbout;
{$R *.dfm}

constructor TSendMsg.Create(tQQNumberList:TStringList;tSkipQQ:String;tMsg:String;tUserQQ:String;tUserPws:string;progress:TComponent);
begin
FreeOnTerminate:=true;
Msg:=tMsg;
QQNumberList:=tQQNumberList;
UserQQ:=tUserQQ;
UserPws:=tUserPws;
SkipQQ:=tSkipQQ;
FProgress:=TGauge(progress);
inherited Create(false);
end;

function TSendMsg.PostMsg(url,para:String;TimeOut:Integer):String;
var
  QQHTTP:TIdHTTP;
  retrun:String;
  Proxy:String;
  i:Integer;
  paralist:TStrings;
begin
  retrun:='';
  try
    paralist:=TStringList.Create;
    paralist.Text:=StringReplace(para,'&',#13#10,[rfReplaceAll]);
    QQHTTP:=TIdHTTP.Create(nil);
    QQHTTP.ReadTimeout:=TimeOut;
    for i:=1 to 3 do
    begin
      try
        retrun:=QQHTTP.Post(url,paralist);
      except end;
      if retrun<>'' then break;
    end;
  finally
      QQHTTP.Disconnect;
      FreeAndNil(QQHTTP);
      FreeAndNil(paralist);
  end;

  Result:=retrun;
end;

procedure TSendMsg.SetProgressPos(p:integer);
begin
FProgress.Progress:=p;
end;

procedure TSendMsg.Execute;
var
poststr,rstr,tt:String;
Count,i:Integer;
begin
tt:=Copy(inttostr(GetTickCount()),1,5);
//登陆
//poststr:='VER=1.1&CMD=Login&SEQ='+tt+'&UIN='+UserQQ+'&PS='+UserPws+'&M5=1&LC=9326B87B234E7235';
//rstr:=PostMsg('http://tqq.tencent.com:8000',AnsiToUtf8(rstr),2000);
Count:=QQNumberList.Count;
FProgress.MinValue:=0;
FProgress.MaxValue:=Count;
Msg:=Msg+'(本消息由《QQ消息群发精灵》发送！下载地址：http://www.codesky.net/showhtml/4049.htm)';
Msg:=stringreplace(Msg,#13#10,'',[rfReplaceAll]);
if Count>0 then begin
  for i:=0 to Count-1 do begin
    tt:=Copy(inttostr(GetTickCount()),1,5);
    poststr:='VER=1.1&CMD=CLTMSG&SEQ='+tt+'&UIN='+UserQQ+'&UN='+QQNumberList[i]+'&MG='+Msg;
    if pos(QQNumberList[i],SkipQQ)<1 then   //
      rstr:=PostMsg('http://tqq.tencent.com:8000',AnsiToUtf8(poststr),2000);
    SetProgressPos(i+1);
    sleep(1000);
  end;
end;
end;

procedure TSendMsg.Terminate;
begin

end;

function PostWebPage(url,para:String;TimeOut:Integer):String;
var
  QQHTTP:TIdHTTP;
  retrun:String;
  Proxy:String;
  i:Integer;
  paralist:TStrings;
begin
  retrun:='';
  try
    paralist:=TStringList.Create;
    paralist.Text:=StringReplace(para,'&',#13#10,[rfReplaceAll]);
    QQHTTP:=TIdHTTP.Create(nil);
    QQHTTP.ReadTimeout:=TimeOut;
    for i:=1 to 3 do
    begin
      try
        retrun:=QQHTTP.Post(url,paralist);
      except end;
      if retrun<>'' then break;
    end;
  finally
     QQHTTP.Disconnect;
      FreeAndNil(QQHTTP);
      FreeAndNil(paralist);
  end;

  Result:=retrun;
end;

function TfrmMain.split(s,s1:string):TStringList;
var
L:integer;
begin
  Result:=TStringList.Create;
  L:=Pos(s1,s);
  while L>0 do
  begin
     Result.Add(Copy(s,1,L-1));
     Delete(s,1,L);
     L:=Pos(s1,s);
  end;
end;

function TfrmMain.GetQQList(QQNumber,QQPws:String):String;
var
rstr,tt:string;
poststr:String;
L:integer;
begin

tt:=Copy(inttostr(GetTickCount()),1,5);
poststr:='VER=1.1&CMD=Login&SEQ='+tt+'&UIN='+QQNumber+'&PS='+QQPws+'&M5=1&LC=9326B87B234E7235';
rstr:=PostWebPage('http://tqq.tencent.com:8000',AnsiToUtf8(poststr),5000);
poststr:='VER=1.1&CMD=List&SEQ='+tt+'&UIN='+QQNumber+'&TN=160&UN=0';
rstr:=PostWebPage('http://tqq.tencent.com:8000',AnsiToUtf8(poststr),5000);
L:=pos('UN=',rstr);
result:=copy(rstr,L+3,length(rstr));

end;

procedure TfrmMain.Button1Click(Sender: TObject);
var
QQNumber,QQPws,Msg:String;
rstr,tt:string;
poststr:String;
QQNumberList:TStringList;
i:integer;
begin
QQNumber:=edtQQNumber.Text;
QQPws:=edtQQPws.Text;
if (QQNumber='') or (QQPws='') then begin
  showmessage('发送者QQ号或密码不能为空！');
  exit;
end;
Button1.Enabled:=false;
QQPws:=RivestStr(QQPws);
tt:=Copy(inttostr(GetTickCount()),1,5);
poststr:='VER=1.1&CMD=Login&SEQ='+tt+'&UIN='+QQNumber+'&PS='+QQPws+'&M5=1&LC=9326B87B234E7235';
rstr:=PostWebPage('http://tqq.tencent.com:8000',AnsiToUtf8(poststr),5000);
if pos('LI=300',Utf8ToAnsi(rstr))>1 then begin
  ReadData;
  QQNumberList:=split(GetQQList(QQNumber,QQPws),',');
  cnt:=QQNumberList.Count;
  Msg:=meoQQMsg.Lines.Text;
  Timer1.Enabled:=true;
  SendMsg:=TSendMsg.Create(QQNumberList,SkipQQ,Msg,QQNumber,QQPws,ProgressBar1);
end
else begin
  showmessage('QQ号与密码不符！请重新输入！');
  Button1.Enabled:=true;
end;

end;


procedure TfrmMain.ReadData;
var
fini:tinifile;
filename:String;
begin
filename:=extractfilepath(application.Exename)+inifn;
try
fini:=tinifile.Create(filename);
SkipQQ:=fini.ReadString('Config','SkipQQ','');
finally
fini.Free;
end;
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
if ProgressBar1.Progress=ProgressBar1.MaxValue then begin
  Timer1.Enabled:=false;
  showmessage('发送已完成！'+'共：'+inttostr(cnt)+'个！');
  ProgressBar1.Progress:=0;
  Button1.Enabled:=true;
end;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
frmSetSkipQQ.SetSkipQQ;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin
frmAbout.ShowModal;
end;

end.
