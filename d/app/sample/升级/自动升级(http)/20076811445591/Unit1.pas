unit Unit1;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, IdBaseComponent, IdAntiFreezeBase, IdAntiFreeze, IniFiles,
  IdThreadComponent, IdFTP, ExtCtrls, IdRawBase, IdRawClient, IdIcmpClient,
  RzCmboBx, AbBase, AbBrowse, AbZBrows, AbUnzper;

type
  TThread1 = class(TThread)

  private
    fCount, tstart, tlast: integer;
    tURL, tFile, temFileName: string;
    tResume: Boolean;
    tStream: TFileStream;
  protected
    procedure Execute; override;
  public
    constructor create1(aURL, aFile, fileName: string; bResume: Boolean; Count,
      start, last: integer);
    procedure DownLodeFile(); //下载文件
  end;
type
  TForm1 = class(TForm)
    IdAntiFreeze1: TIdAntiFreeze;
    IdHTTP1: TIdHTTP;
    Button1: TButton;
    IdThreadComponent1: TIdThreadComponent;
    Button3: TButton;
    ListBox1: TListBox;
    Image1: TImage;
    ICMP: TIdIcmpClient;
    StatusBar1: TStatusBar;
    ProgressBar1: TProgressBar;
    Button5: TButton;
    IdHTTP2: TIdHTTP;
    Edit1: TRzComboBox;
    AbUnZipper1: TAbUnZipper;
    procedure Button1Click(Sender: TObject);
    procedure IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure Button2Click(Sender: TObject);
    procedure IdHTTP1Status(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
    procedure Button3Click(Sender: TObject);
    procedure ICMPReply(ASender: TComponent;
      const AReplyStatus: TReplyStatus);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
     g_path: string;
    sys_id: string;
    AppIni: TIniFile;

  public
    nn, aFileSize, avg: integer;
    MyThread: array[1..10] of TThread;
    progressBarRect:TRect;
    procedure GetThread();
    procedure AddFile();
    function GetURLFileName(aURL: string): string;
    function GetFileSize(aURL: string): integer;
  end;

var
  Form1: TForm1;
implementation
var
  AbortTransfer: Boolean;
  aURL, aFile: string;
  tcount: integer; //检查文件是否全部下载完毕
  ip_address,FPath,Tver,over:string;   //下载地址
  DownFile:string;
  oFile: TIniFile;
{$R *.dfm}
function TForm1.GetURLFileName(aURL: string): string;
var
  i: integer;
  s: string;
begin //返回下载地址的文件名
  s := aURL;
  i := Pos('/', s);
  while i <> 0 do //去掉"/"前面的内容剩下的就是文件名了
  begin
    Delete(s, 1, i);
    i := Pos('/', s);
  end;
  Result := s;
end;

//get FileSize

function TForm1.GetFileSize(aURL: string): integer;
var
  FileSize: integer;
begin
  try
  IdHTTP1.Head(aURL);
  FileSize := IdHTTP1.Response.ContentLength;
  IdHTTP1.Disconnect;
  Result :=FileSize;
  except
      Showmessage('文件检测失败,请检查下载地址!');
      Exit;
    end;
end;

//执行下载

procedure TForm1.Button1Click(Sender: TObject);
var
  j: integer;
begin
 ProgressBar1.Position := 0;
 ListBox1.Items.Clear ;
 statusbar1.panels[0].Text:='开始下载';
  tcount := 0;
  aURL := trim(Edit1.Text)+downfile; //下载地址
  aFile := GetURLFileName(aURL); //得到文件名
  aFileSize := GetFileSize(aURL);
  if   aFileSize<1 then  begin
      nn :=0 ;//线程数
      ListBox1.ItemIndex := Form1.ListBox1.Items.Add('下载失败!');
      exit;
    end
  else
    nn :=5 ;//线程数
  ListBox1.Items.Add('正在下载,请耐心等候...');  
  j := 1;
  avg := trunc(aFileSize / nn);
  begin
    try
      GetThread();
      while j <= nn do
      begin
        MyThread[j].Resume; //唤醒线程
        j := j + 1;
      end;
    except
      Showmessage('创建线程失败!');
      Exit;
    end;
  end; 
end;

//开始下载前,将ProgressBar1的最大值设置为需要接收的数据大小.

procedure TForm1.IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCountMax: Integer);
begin
    AbortTransfer := False;
    ProgressBar1.Max := AWorkCountMax;
    ProgressBar1.Min := 0;
    ProgressBar1.Position := 0;
end;

//接收数据的时候,进度将在ProgressBar1显示出来.

procedure TForm1.IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin
  if AbortTransfer then
  begin
    IdHTTP1.Disconnect; //中断下载
  end;
  ProgressBar1.Position:=ProgressBar1.Position+AWorkCount;
  statusbar1.panels[0].Text:='已下载:'+inttostr((ProgressBar1.Position div 1024)*5)+'K字节,总共:'+inttostr((ProgressBar1.Max div 1024)*5)+'K字节,约'+inttostr(ProgressBar1.Position*100 div ProgressBar1.Max)+'%';
  Application.ProcessMessages;
end;

//中断下载

procedure TForm1.Button2Click(Sender: TObject);
begin
  AbortTransfer := True;
  IdHTTP1.Disconnect;
end;

//状态显示

procedure TForm1.IdHTTP1Status(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: string);
begin
    // ListBox1.ItemIndex := ListBox1.Items.Add('正在下载');
end;

//退出程序

procedure TForm1.Button3Click(Sender: TObject);
begin
  application.Terminate;

end;

//循环产生线程

procedure TForm1.GetThread();
var
  i: integer;
  start: array[1..100] of integer;
  last: array[1..100] of integer;   //改用了数组，也可不用
  fileName: string;
begin
  i := 1;
  while i <= nn do
  begin
    start[i] := avg * (i - 1);
    last[i] := avg * i -1; //这里原先是last:=avg*i;
    if i = nn then
    begin
      last[i] := avg*i + aFileSize-avg*nn; //这里原先是aFileSize
    end;
    fileName := aFile + IntToStr(i);
    MyThread[i] := TThread1.create1(aURL, aFile, fileName, false, i, start[i],
      last[i]);
    i := i + 1;
  end;
end;

procedure TForm1.AddFile(); //合并文件
var
  mStream1, mStream2: TMemoryStream;
  i: integer;
begin
  i := 1;
  mStream1 := TMemoryStream.Create;
  mStream2 := TMemoryStream.Create;
  mStream1.loadfromfile(FPath+downfile + '1');
  while i < nn do
  begin
    mStream2.loadfromfile(FPath+downfile + IntToStr(i + 1));
    mStream1.seek(mStream1.size, soFromBeginning);
    mStream1.copyfrom(mStream2, mStream2.size);
    mStream2.clear;
    i := i + 1;
  end;
  mStream2.free;
  mStream1.SaveToFile(FPath+downfile);
  mStream1.free;
  //删除临时文件
  i:=1;
   while i <= nn do
  begin
    deletefile(FPath+downfile + IntToStr(i));
    i := i + 1;
  end;
  Form1.ListBox1.ItemIndex := Form1.ListBox1.Items.Add('下载成功');
end;

//构造函数

constructor TThread1.create1(aURL, aFile, fileName: string; bResume: Boolean;
  Count, start, last: integer);
begin
  inherited create(true);
  FreeOnTerminate := true;
  tURL := aURL;
  tFile := aFile;
  fCount := Count;
  tResume := bResume;
  tstart := start;
  tlast := last;
  temFileName := fileName;
end;
//下载文件函数

procedure TThread1.DownLodeFile();
var
  temhttp: TIdHTTP;
begin
  temhttp := TIdHTTP.Create(nil);
  temhttp.onWorkBegin := Form1.IdHTTP1WorkBegin;
  temhttp.onwork := Form1.IdHTTP1work;
  temhttp.onStatus := Form1.IdHTTP1Status;
  Form1.IdAntiFreeze1.OnlyWhenIdle := False; //设置使程序有反应.
  if FileExists(temFileName) then //如果文件已经存在
    tStream := TFileStream.Create(temFileName, fmOpenWrite)
  else
    tStream := TFileStream.Create(temFileName, fmCreate);
  if tResume then //续传方式
  begin
    exit;
  end
  else //覆盖或新建方式
  begin
    temhttp.Request.ContentRangeStart := tstart;
    temhttp.Request.ContentRangeEnd := tlast;
  end;

  try
    temhttp.Get(tURL, tStream); //开始下载
  finally
    //tStream.Free;
    freeandnil(tstream);
    temhttp.Disconnect;
  end;

end;

procedure TThread1.Execute;
var s :string;

begin
  if Form1.Edit1.Text <> '' then
    DownLodeFile
  else
    exit;
  inc(tcount);
  if tcount = Form1.nn then //当tcount=nn时代表全部下载成功
  begin
    Form1.ListBox1.ItemIndex := Form1.ListBox1.Items.Add('正在合并文件');
    Form1.AddFile;
    Form1.ListBox1.ItemIndex := Form1.ListBox1.Items.Add('开始解压缩!');
  try
    with Form1.AbUnZipper1 do begin
      FileName:=FPath + DownFile;

      //showmessage(s)   ;
     if uppercase(copy(s,pos('.', downfile) + 1, 3))='ZIP' then
       begin
         BaseDirectory :=FPath;
         ExtractFiles( '*.*' );
        end
       else
        begin
         CloseArchive ;
         Form1.ListBox1.ItemIndex := Form1.ListBox1.Items.Add('文件格式不支持，文件下载成功');
        end
    end;
    Form1.AbUnZipper1.CloseArchive ;
    deletefile(FPath+'OVer.ini');
    RenameFile(FPath+'Ver.ini','OVer.ini');
    Form1.ListBox1.ItemIndex := Form1.ListBox1.Items.Add('升级成功!');
    Form1.Button1.Enabled:=false;
    except
      Form1.ListBox1.ItemIndex := Form1.ListBox1.Items.Add('解压缩zip文件失败!');
      Form1.ListBox1.ItemIndex := Form1.ListBox1.Items.Add('文件格式不支持,但文件下载成功');
      //Showmessage('解压缩失败!');
      Exit;
   end;
  end;
end;


procedure TForm1.ICMPReply(ASender: TComponent;
  const AReplyStatus: TReplyStatus);
var
  sTime: string;
begin
  if (AReplyStatus.MsRoundTripTime = 0) then
    sTime := '<1'
  else
    sTime := '=';
    ListBox1.Items.Add('网络测试成功');
end;

procedure TForm1.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
    progressBarRect:=Rect;
end;

procedure TForm1.IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
    ProgressBar1.Position:=ProgressBar1.Max;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  MyStream:TMemoryStream;
  iFile: TIniFile;
  i: integer;
begin
    FPath := ExtractFilePath(Application.ExeName);
    ip_address:=trim(Edit1.Text);
    oFile:= TIniFile.Create(FPath + 'OVer.ini');     //老版本号
    over:=oFile.ReadString('sVer', 'Ver', '未知版');
    ListBox1.Items.Clear;
    ICMP.OnReply := ICMPReply;
    ICMP.ReceiveTimeout := 1000;
    ICMP.Host:=copy(trim(Edit1.Text),8,Length(trim(Edit1.Text))-7);   //去掉http//
  try
  //  for i := 1 to 3 do begin
   //   ICMP.Ping;
   //   Application.ProcessMessages;
  //  end;
  except
        ListBox1.Items.Add('网络测试失败');
        exit;
     end;
     IdAntiFreeze1.OnlyWhenIdle:=False;//设置使程序有反应.
     MyStream:=TMemoryStream.Create;
  try
     ip_address:=trim(Edit1.Text);
     IdHTTP2.Get(ip_address+'/Ver.txt',MyStream); //若为INI文件不能下载
  except
     ListBox1.Items.Add('升级文件检测失败!');
     ListBox1.Items.Add('请更换升级网络地址!');
     MyStream.Free;
     Exit;
  end;
    MyStream.SaveToFile(FPath+'Ver.ini');   //将文件必改为INI
    MyStream.Free;
    iFile := TIniFile.Create(FPath + 'Ver.ini');
    Tver := iFile.ReadString('sVer', 'Ver', '未知版');
     if Tver=over then
    begin
      ListBox1.Items.Add('已经是最新版本,不用升级!');
       deletefile(FPath+'Ver.ini');
      Exit;
    end
    else
     begin
        Button1.Enabled:=true;
        ListBox1.Items.Add('应下载升级新版文件!!!');
        Button1Click(self);
     end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i,j:integer;
files:TStrings;
servers: TStringlist;
begin
    FPath := ExtractFilePath(Application.ExeName);
    files := TStringList.Create;
    try
 if copy(FPath, length(FPath), 1) <> '\' then FPath := FPath + '\';
    AppIni := TIniFile.Create(FPath + 'OVer.ini');
    sys_id := AppIni.ReadString('chis', 'SubSys', '');
    DownFile:=appini.ReadString('chis','exe','update.rar') ;
    servers := TStringList.Create;
    AppIni.ReadSectionValues('update', servers);
    edit1.Clear ;
    for i := 0 to servers.Count - 1 do
    begin

      edit1.AddItemValue(copy(servers[i], pos('=', servers[i]) + 1, length(servers[i])),copy(servers[i], pos('=', servers[i]) + 1, length(servers[i])));
      if i = 0 then edit1.Text := copy(servers[i], pos('=', servers[i]) + 1, length(servers[i]));
    end;
  finally
    AppIni.Free;
end;

end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
    ListBox1.Items.Clear ;
end;

end.
