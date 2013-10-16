unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ShellApi,IniFiles, CoolTrayIcon,
  Buttons, Menus, ImgList;

type
  TSendType = (stStart, stStop);
  TmainSend = class(TForm)
    tmrSend: TTimer;
    pgc1: TPageControl;
    ts1: TTabSheet;
    mmo1: TMemo;
    ts2: TTabSheet;
    ts3: TTabSheet;
    img1: TImage;
    lbl1: TLabel;
    lbl3: TLabel;
    lbl6: TLabel;
    grp1: TGroupBox;
    grp2: TGroupBox;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    edit2: TEdit;
    edit3: TEdit;
    lbl12: TLabel;
    edit4: TEdit;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl21: TLabel;
    lbl22: TLabel;
    checkbox2: TCheckBox;
    CoolTrayIcon1: TCoolTrayIcon;
    btnStart: TSpeedButton;
    btnStop: TSpeedButton;
    btn6: TSpeedButton;
    btn5: TSpeedButton;
    btn4: TSpeedButton;
    btn1: TSpeedButton;
    btn7: TSpeedButton;
    lbl2: TLabel;
    lbl8: TLabel;
    lbl4: TLabel;
    pm1: TPopupMenu;
    mniN1: TMenuItem;
    mniN2: TMenuItem;
    mniN3: TMenuItem;
    mniN4: TMenuItem;
    mniN5: TMenuItem;
    mniN6: TMenuItem;
    mniN7: TMenuItem;
    mniN8: TMenuItem;
    img2: TImage;
    bvl5: TBevel;
    ts4: TTabSheet;
    lbl5: TLabel;
    pb1: TProgressBar;
    btn2: TSpeedButton;
    lbl7: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    img3: TImage;
    img4: TImage;
    img5: TImage;
    mniN9: TMenuItem;
    mniN10: TMenuItem;
    lbl18: TLabel;
    procedure edtTimeKeyPress(Sender: TObject; var Key: Char);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure tmrSendTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edit4Change(Sender: TObject);
    procedure lbl1Click(Sender: TObject);
    procedure lbl8Click(Sender: TObject);
    procedure lbl2Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure mniN8Click(Sender: TObject);
    procedure mniN4Click(Sender: TObject);
    procedure mniN6Click(Sender: TObject);
    procedure checkbox2Click(Sender: TObject);
    procedure CoolTrayIcon1DblClick(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
    procedure SetState(aSendType: TSendType);
    procedure MyExceptionHandler(Sender : TObject; E : Exception);
  public
    { Public declarations }
    senreg:Boolean;
    apppath:string;
  end;

var
  mainSend: TmainSend;
  fengshan:Integer;
implementation

uses orpas, userpas, regpas;

var
  hw, hb, he: THandle;
  i, iLength,startnum,endnum,sendnum: Integer;
  stopit:Boolean;
  sendQQMsg:string;

{$R *.dfm}
procedure TmainSend.MyExceptionHandler(Sender : TObject; E : Exception);
begin
//abort;
//EXIT
end;

function EnumWindowsProc(hwnd: HWND; lParam: LPARAM): boolean; stdcall;
var
  cName: array[0..180] of Char;
  wName: array[0..32] of Char;
begin
  GetClassName(hwnd, cName, 32);
  GetWindowText(hwnd, wName, 180);
  if Pos('会话中', StrPas(wName)) > 0then
  begin
    hw := hwnd;
    fengshan:=hwnd;
    if Pos('章鱼', StrPas(wName)) > 0 then hw := 0;
    result := false;
  end
  else
    result := true;
end;

function GetButtonHandle(hwnd: HWND; lParam: LPARAM):Boolean; stdcall;
var
  cName: array[0..180] of Char;
  wName: array[0..12] of Char;
begin
  result := true;
  GetClassName(hwnd, cName, 180);
  if StrPas(cName) = 'Button' then
  begin
    GetWindowText(hwnd, wName, 12);
    if StrPas(wName) = '发送(&S)' then
    begin
      PInteger(lParam)^ := hwnd;
      result := false;
    end;
  end;
end;

function GetEditHandle(hwnd: HWND; lParam: LPARAM):Boolean; stdcall;
var
  cName: array[0..180] of Char;
begin
  result := true;
  GetClassName(hwnd, cName, 180);
  if StrPas(cName) = 'RICHEDIT' then
  begin
    PInteger(lParam)^ := hwnd;
    if i = 1 then result := false;
    i := i + 1;
  end;
end;

procedure TmainSend.SetState(aSendType: TSendType);
begin
  case aSendType of
    stStart:
    begin
      btnStart.Enabled := true;
      btnStop.Enabled := false;
      mniN1.Enabled:=true;
      mniN2.Enabled:=False;
      mmo1.ReadOnly:=false;
      edit2.ReadOnly:=false;
      edit3.ReadOnly:=false;
      edit4.ReadOnly:=false;
    end;
    stStop:
    begin
      btnStart.Enabled := false;
      btnStop.Enabled := true;
      mniN2.Enabled:=true;
      mniN1.Enabled:=False;
      mmo1.ReadOnly:=True;
      edit2.ReadOnly:=True;
      edit3.ReadOnly:=True;
      edit4.ReadOnly:=true;
    end;
  end;
end;

procedure TmainSend.tmrSendTimer(Sender: TObject);
var
s: string;
i:Integer;
begin
if startnum>endnum then
  begin
  tmrSend.Enabled:=False;
  Exit
  end;
  
  begin
  s:='Tencent://Message/?Menu=YES&Exe=&Uin='+inttostr(startnum);
  Shellexecute(handle,nil,pchar(s),nil,nil,SW_MINIMIZE);

  EnumWindows(@EnumWindowsProc, 0);

  if hw <> 0 then
  begin
  if not senreg and (sendnum>30) then
  btnStop.Click;
  EnumChildWindows(hw, @GetButtonHandle, Integer(@hb));
  EnumChildWindows(hw, @GetEditHandle, Integer(@he));
  SendMessage(he, WM_SETTEXT, 180, Integer(PChar(sendQQMsg)));
  SendMessage(hb, WM_LBUTTONDOWN, 0, 0);
  SendMessage(hb, WM_LBUTTONUP, 0, 0);
  lbl22.Caption:=inttostr(sendnum)+' 条';
  Sleep(2000);
  SendMessage(fengshan, WM_SYSCOMMAND, SC_CLOSE, 0);
  Inc(startnum);
  Inc(sendnum);
  edit2.Text:=IntToStr(startnum);
  end
  else
  begin
  tmrSend.Enabled:=False;
  btnStart.Enabled:=true;
  mmo1.ReadOnly:=False;
  MessageBox(self.Handle, '群发信息前请确认你的QQ已经打开！', '提示', mb_IconInformation + mb_Ok);
  end;
  end;  
end;

procedure TmainSend.edtTimeKeyPress(Sender: TObject; var Key: Char);
begin
  SetState(stStart);
  tmrSend.Enabled := false;
end;

procedure TmainSend.btnStartClick(Sender: TObject);
begin
if mmo1.Text='' then exit;
if MessageBox(Handle,PChar('在群发前请确保系统中只运行了一个QQ，否则请关闭其它QQ！'),
'您的QQ只能运行一个',MB_OKCANCEL or MB_ICONWARNING)=mrCancel then exit;
sendQQMsg :=mmo1.text;
startnum:=StrToInt(edit2.Text);
endnum:=StrToInt(edit3.Text);
Shellexecute(handle,nil,pchar('Tencent://Message/?Menu=YES&Exe=&Uin='+inttostr(startnum)),nil,nil,SW_MINIMIZE);
SetState(stStop);
sleep(3000);
tmrSend.Enabled := true;
end;

procedure TmainSend.btnStopClick(Sender: TObject);
begin
  SetState(stStart);
  tmrSend.Enabled := false;
end;

procedure TmainSend.FormCreate(Sender: TObject);
var ini:tinifile;
msgs:string;
begin
Application.OnException := MyExceptionHandler;
Application.ShowHint := true;
Application.HintColor := clLime;
senreg:=False;
startnum:=0;
sendnum:=1;
stopit:=True;
apppath:=extractfilepath(Application.ExeName);

msgs:=#13#10+'★QQ任我发，在线宣传的利器，网络时代的信使！'+#13#10+
'★欢迎登录我们的主页：http://www.prowt.com'+#13#10+#13#10+
'★作者QQ：289161766'+#13#10+
'★2005年07月31日';
if FileExists(apppath+'msg.dat') then
mmo1.Lines.LoadFromFile(apppath+'msg.dat') else
mmo1.Text:=msgs;
  try
  ini:=tinifile.Create(apppath+'config.ini');
  if ini.ReadString('Reginfo','regcode','')='6CR98D0510NNVG4BR29A75M3' then
  begin
  mainSend.Caption:='QQ任我发--'+'已注册';
  senreg:=True
  end else
  begin
  mainSend.Caption:='QQ任我发--未注册';
  senreg:=false;
  end;
  edit2.Text:=ini.ReadString('QQinfo','startnums','100000');
  startnum:=StrToInt(ini.ReadString('QQinfo','startnums','100000'));
  edit3.Text:=ini.ReadString('QQinfo','endnums','999999999');
  endnum:=StrToInt(ini.ReadString('QQinfo','endnums','999999999'));
  mainSend.Top:=ini.ReadInteger('Form','top',124);
  mainSend.left:=ini.ReadInteger('Form','left',163);
  edit4.Text:=ini.ReadString('QQinfo','speed','3');
  tmrSend.Interval:=ini.ReadInteger('QQinfo','speed',3)*1000;
  checkbox2.checked:=ini.ReadBool('Application','mintray',True);
  finally
  ini.Free
  end;
end;

procedure TmainSend.FormClose(Sender: TObject; var Action: TCloseAction);
begin
btn4.Click;
Shellexecute(handle,nil,pchar('http://www.prowt.com/soft/showsoft.asp?id=16'),nil,nil,0);
end;

procedure TmainSend.edit4Change(Sender: TObject);
begin
try
tmrSend.Interval:=StrToInt(edit4.Text)*1000;
finally
end;
end;

procedure TmainSend.lbl1Click(Sender: TObject);
begin
Shellexecute(handle,nil,pchar('http://www.prowt.com'),nil,nil,0);
end;

procedure TmainSend.lbl8Click(Sender: TObject);
begin
  ShellExecute(self.Handle, nil, 'mailto:selonboy@163.com?subject=QQ任我发1.0', nil, nil, SW_SHOWNORMAL);
end;

procedure TmainSend.lbl2Click(Sender: TObject);
begin
try
regform:=Tregform.create(Self);
regform.showmodal;
finally
end
end;

procedure TmainSend.btn5Click(Sender: TObject);
begin
close
end;

procedure TmainSend.btn6Click(Sender: TObject);
begin
Application.Minimize
end;

procedure TmainSend.btn4Click(Sender: TObject);
var ini:tinifile;
begin
  try
  ini:=tinifile.Create(apppath+'config.ini');
  ini.WriteString('QQinfo','startnums',edit2.Text);
  ini.WriteString('QQinfo','endnums',edit3.Text);
  ini.WriteInteger('QQinfo','speed',strtoint(edit4.text));
  ini.WriteInteger('Form','top',top);
  ini.WriteInteger('Form','left',left);
  ini.WriteBool('Application','mintray',checkbox2.checked);
  mmo1.Lines.SaveToFile(apppath+'msg.dat');    
  if stopit then
  MessageBox(Handle,'保存设置成功！','信息',MB_OK or MB_ICONINFORMATION);
  finally
  ini.Free
  end;
end;

procedure TmainSend.btn1Click(Sender: TObject);
begin
try
ornumform:=Tornumform.create(Self);
ornumform.showmodal;
finally
end
end;

procedure TmainSend.btn7Click(Sender: TObject);
begin
try
userform:=tuserform.create(Self);
userform.showmodal;
finally
end
end;

procedure TmainSend.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
stopit:=False;
case MessageBox(Handle,'按“确定”退出软件。','QQ任我发',MB_OKCANCEL or MB_ICONQUESTION) of
mrOk: CanClose:=true;
mrCancel:CanClose:=False
end
end;

procedure TmainSend.mniN8Click(Sender: TObject);
begin
close
end;

procedure TmainSend.mniN4Click(Sender: TObject);
begin
pgc1.ActivePageIndex:=2
end;

procedure TmainSend.mniN6Click(Sender: TObject);
begin
pgc1.ActivePageIndex:=3
end;

procedure TmainSend.checkbox2Click(Sender: TObject);
begin
CoolTrayIcon1.MinimizeToTray:=checkbox2.Checked
end;

procedure TmainSend.CoolTrayIcon1DblClick(Sender: TObject);
begin
CoolTrayIcon1.ShowMainForm;
end;

procedure TmainSend.btn2Click(Sender: TObject);
begin
MessageBox(Handle,'已经是最新版本！','更新',MB_OK or MB_ICONINFORMATION);
end;

end.
