unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WinSkinForm, WinSkinData, ComCtrls, StdCtrls, ExtCtrls, jpeg,
  inifiles, Menus,IdGlobal, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, IdBaseComponent, IdAntiFreezeBase, IdAntiFreeze,shellapi,
  Grids, hxCalendar, XPMenu,Registry;
const
  mousemsg = wm_user + 1; //自定义消息，用于处理用户在图标上点击鼠标的事件
  iid = 100; //用户自定义数值，在TnotifyIconDataA类型全局变量ntida中使用
type
  TForm1 = class(TForm)
    SkinData1: TSkinData;
    WinSkinForm1: TWinSkinForm;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Memo1: TMemo;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Timer1: TTimer;
    StatusBar1: TStatusBar;
    IdAntiFreeze1: TIdAntiFreeze;
    IdHTTP1: TIdHTTP;
    N7: TMenuItem;
    Calendar1: ThxCalendar;
    Image4: TImage;
    XPMenu1: TXPMenu;
    N4: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
  private
    { Private declarations }
    //自定义消息处理函数，处理鼠标点击图标事件
    procedure mousemessage(var message: tmessage); message
      mousemsg;
  public
    { Public declarations }
  end;

  getdatathread=class(TThread)
protected
procedure execute;override;
end;

var
  Form1: TForm1;
  mystr:string;
  ntida: TNotifyIcondataA;//用于增加和删除系统状态图标
implementation

uses config, about;

{$R *.dfm}
procedure TForm1.mousemessage(var message: tmessage);
var
  mousept: TPoint; //鼠标点击位置
begin
  inherited;
  if message.LParam = wm_rbuttonup then begin //用鼠标右键点击图标
      getcursorpos(mousept); //获取光标位置
      popupmenu1.popup(mousept.x, mousept.y);
      //在光标位置弹出选单
    end;
  if message.LParam = wm_lbuttonup then begin //用鼠标左键点击图标
      //显示应用程序窗口
      ShowWindow(Handle, SW_SHOW);
      //在任务栏上显示应用程序窗口
      ShowWindow(Application.handle, SW_SHOW);
      SetWindowLong(Application.Handle, GWL_EXSTYLE,
        not (GetWindowLong(Application.handle, GWL_EXSTYLE)
        or WS_EX_TOOLWINDOW and not WS_EX_APPWINDOW));
    end;
  message.Result := 0;
end;

procedure getdatathread.execute;
var
d1,d2,d3,min1,min2,min3,max1,max2,max3,n1,n2,n3:string;
times,provinces,citys:string;
configsini:tinifile;
function CenterStr(Src:String;Before,After:String):String;
  var
    Pos1,Pos2:WORD;

  begin
    Pos1:=Pos(Before,Src)+Length(Before);
    Pos2:=Pos(After,Src);
    Result:=Copy(Src,Pos1,Pos2-Pos1);
  end;
begin
form1.Memo1.Text :='';
form1.StatusBar1.Panels[0].Text:='';
configsini:=tinifile.Create(extractfilepath(application.ExeName)+'config.ini');
provinces:=configsini.ReadString('config','province','');
citys:=configsini.ReadString('config','city','');
times:=configsini.ReadString('config','time','');
configsini.Free;
form1.Caption:='天气预报——'+provinces+' '+citys+' 天气';
form1.IdAntiFreeze1.OnlyWhenIdle:=False;//设置使程序有反应.
try
//MyStr:=form1.IdHTTP1.Get('http://localhost/t7/data.htm');
//form1.NMHTTP1.Get('http://www.lonetear.com/weather/getdata.asp?v=1.6&p=江苏&c=苏州');
//mystr:=form1.NMHTTP1.Body;
MyStr:=form1.IdHTTP1.Get('http://www.lonetear.com/weather/getdata.asp?v=1.8&p='+provinces+'&c='+citys);
form1.memo1.Lines.Add(mystr);
if  FileExists(ExtractFilePath(Application.Exename)+'data.htm') then    //删除掉原来的文件，以免多次写入文件
deletefile(ExtractFilePath(Application.Exename)+'data.htm');
form1.memo1.Lines.SaveToFile(ExtractFilePath(Application.Exename)+'data.htm');
except
form1.memo1.Lines.LoadFromFile(ExtractFilePath(Application.Exename)+'data.htm');
form1.StatusBar1.Panels[0].Text:='   载入时网络错误，载入旧记录';
mystr:=form1.memo1.Text ;
end;
begin
d1:=CenterStr(mystr,'[D1]','[/D1]');
d2:=CenterStr(mystr,'[D2]','[/D2]');
d3:=CenterStr(mystr,'[D3]','[/D3]');
form1.label5.Caption :=d1;
form1.label6.Caption :=d2;
form1.label7.Caption :=d3;
max1:=CenterStr(mystr,'[MAX1]','[/MAX1]');
max2:=CenterStr(mystr,'[MAX2]','[/MAX2]');
max3:=CenterStr(mystr,'[MAX3]','[/MAX3]');
form1.label8.Caption :=max1+'℃';
form1.label9.Caption :=max2+'℃';
form1.label10.Caption :=max3+'℃';
min1:=CenterStr(mystr,'[MIN1]','[/MIN1]');
min2:=CenterStr(mystr,'[MIN2]','[/MIN2]');
min3:=CenterStr(mystr,'[MIN3]','[/MIN3]');
form1.label11.Caption :=min1+'℃';
form1.label12.Caption :=min2+'℃';
form1.label13.Caption :=min3+'℃';
n1:=CenterStr(mystr,'[M1]','[/M1]');
n2:=CenterStr(mystr,'[M2]','[/M2]');
n3:=CenterStr(mystr,'[M3]','[/M3]');
if (pos('雨',n1)>0 )then
form1.Image1.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/bdr1__.jpg')
else if (pos('晴',n1)>0 )and (pos('转',n1)>0 )and (pos('多云',n1)>0)then
form1.Image1.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/wb____.jpg')
else if (pos('多云',n1)>0) and (pos('阴',n1)>0) then
form1.Image1.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/bd____.jpg')
else if (pos('阴',n1)>0 )and (pos('雨',n1)>0) then
form1.Image1.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/bdr2__.jpg')
else if  pos('晴',n1)>0 then
form1.Image1.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/so____.jpg')
else if pos('阴',n1)>0 then
form1.Image1.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/bd____.jpg')
else if pos('多云',n1)>0 then
form1.Image1.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/ms____(1).jpg')
else
form1.Image1.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/bdr2__.jpg');
//第一天结束
if (pos('雨',n2)>0 )then
form1.Image2.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/bdr1__.jpg')
else if (pos('晴',n2)>0 )and (pos('转',n2)>0 )and (pos('多云',n2)>0)then
form1.Image2.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/wb____.jpg')
else if (pos('多云',n2)>0) and (pos('阴',n2)>0) then
form1.Image2.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/bd____.jpg')
else if (pos('阴',n2)>0 )and (pos('雨',n2)>0) then
form1.Image2.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/bdr2__.jpg')
else if  pos('晴',n2)>0 then
form1.Image2.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/so____.jpg')
else if pos('阴',n2)>0 then
form1.Image2.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/bd____.jpg')
else if pos('多云',n2)>0 then
form1.Image2.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/ms____(1).jpg')
else
form1.Image2.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/bdr2__.jpg');
//第二天结束
if (pos('雨',n3)>0 )then
form1.Image3.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/bdr1__.jpg')
else if (pos('晴',n3)>0 )and (pos('转',n3)>0 )and (pos('多云',n3)>0)then
form1.Image3.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/wb____.jpg')
else if (pos('多云',n3)>0) and (pos('阴',n3)>0) then
form1.Image3.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/bd____.jpg')
else if (pos('阴',n3)>0 )and (pos('雨',n3)>0) then
form1.Image3.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/bdr2__.jpg')
else if  pos('晴',n3)>0 then
form1.Image3.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/so____.jpg')
else if pos('阴',n3)>0 then
form1.Image3.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/bd____.jpg')
else if pos('多云',n3)>0 then
form1.Image3.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/ms____(1).jpg')
else
form1.Image3.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'/图标/jpg/bdr2__.jpg');
//第三天结束
form1.Image1.Hint:=n1;
form1.Image2.Hint:=n2;
form1.Image3.Hint:=n3;
end;
self.FreeOnTerminate :=true;
 form1.Timer1.Interval:=strtocard(inttostr(strtoint(times)*60000));
end;


procedure TForm1.FormCreate(Sender: TObject);
var
HzDate:THzDate;
flag:string;
configsini:tinifile;
begin
configsini:=tinifile.Create(extractfilepath(application.ExeName)+'config.ini');
flag:=configsini.ReadString('run','flag','');
configsini.Free;
if flag='true' then
n8.Checked:=true;
if flag='false' then
n8.Checked:=false;

HzDate := Calendar1.ToLunar(Calendar1.CalendarDate);
//label14.Caption :='农历：'+Calendar1.cyclical(HzDate.year-1900+36)+Calendar1.FormatLunarMonth(HzDate.Month,HzDate.isLeap)+Calendar1.FormatLunarDay(Hzdate.Day);
StatusBar1.Panels[1].Text:= FormatDateTime('dddddd', Calendar1.CalendarDate)+'  农历：'+Calendar1.cyclical(HzDate.year-1900+36)+Calendar1.FormatLunarMonth(HzDate.Month,HzDate.isLeap)+Calendar1.FormatLunarDay(Hzdate.Day);
getdatathread.Create(false);
ntida.cbSize := sizeof(tnotifyicondataa); //指定ntida的长度
  ntida.Wnd := handle; //取应用程序主窗体的句柄
  ntida.uID := iid; //用户自定义的一个数值，在uCallbackMessage参数指定的消息中使
  ntida.uFlags := nif_icon + nif_tip +
    nif_message; //指定在该结构中uCallbackMessage、hIcon和szTip参数都有效
  ntida.uCallbackMessage := mousemsg;
  //指定的窗口消息
  ntida.hIcon := Application.Icon.handle;
  //指定系统状态栏显示应用程序的图标句柄
  ntida.szTip := '天气预报';
  //当鼠标停留在系统状态栏该图标上时，出现该提示信息
  shell_notifyicona(NIM_ADD, @ntida);
  //在系统状态栏增加一个新图标
end;

procedure TForm1.N6Click(Sender: TObject);
begin
//为ntida赋值，指定各项参数
  ntida.cbSize := sizeof(tnotifyicondataa);
  ntida.wnd := handle;
  ntida.uID := iid;
  ntida.uFlags := nif_icon + nif_tip + nif_message;
  ntida.uCallbackMessage := mousemsg;
  ntida.hIcon := Application.Icon.handle;
  ntida.szTip := '天气预报';
  shell_notifyicona(NIM_DELETE, @ntida);
  //删除已有的应用程序图标
  Application.Terminate;
  //中断应用程序运行，退出应用程序
end;

procedure TForm1.N1Click(Sender: TObject);
begin
 form2.ShowModal;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
getdatathread.Create(false);
end;

procedure TForm1.N3Click(Sender: TObject);
begin
form3.ShowModal;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caNone; //不对窗体进行任何操作
  ShowWindow(Handle, SW_HIDE); //隐藏主窗体
  //隐藏应用程序窗口在任务栏上的显示
  ShowWindow(Application.Handle, SW_HIDE);
  SetWindowLong(Application.Handle, GWL_EXSTYLE,
    not (GetWindowLong(Application.handle, GWL_EXSTYLE)
    or WS_EX_TOOLWINDOW and not WS_EX_APPWINDOW));
end;

procedure TForm1.N7Click(Sender: TObject);
begin
 //显示应用程序窗口
      ShowWindow(Handle, SW_SHOW);
      //在任务栏上显示应用程序窗口
      ShowWindow(Application.handle, SW_SHOW);
      SetWindowLong(Application.Handle, GWL_EXSTYLE,
        not (GetWindowLong(Application.handle, GWL_EXSTYLE)
        or WS_EX_TOOLWINDOW and not WS_EX_APPWINDOW));
end;

procedure TForm1.N8Click(Sender: TObject);
var Rego:TRegistry;
flag:string;
configsini:tinifile;
begin
if n8.Checked=false then
begin
n8.Checked:=true;
configsini:=tinifile.Create(extractfilepath(application.ExeName)+'config.ini');
configsini.writestring('run','flag','true');
configsini.Free;
end
else
begin
n8.Checked:=false;
configsini:=tinifile.Create(extractfilepath(application.ExeName)+'config.ini');
configsini.writeString('run','flag','false');
configsini.Free;
end;
if n8.Checked=true then
begin
                Rego:=TRegistry.Create;
                Rego.RootKey:=HKEY_LOCAL_MACHINE;
                rego.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run',True);
                Rego.WriteString('weather',application.ExeName );

                Rego.Free;
                end
else
                begin
                Rego:=TRegistry.Create;
                Rego.RootKey:=HKEY_LOCAL_MACHINE;
                rego.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run',True);
                Rego.WriteString('weather','' );

                Rego.Free;
                end;
end;

procedure TForm1.N9Click(Sender: TObject);
begin
shellexecute(handle,nil,pchar((ExtractFilePath(Application.Exename)+'说明文档.htm')),nil,nil,sw_shownormal);
end;

end.
