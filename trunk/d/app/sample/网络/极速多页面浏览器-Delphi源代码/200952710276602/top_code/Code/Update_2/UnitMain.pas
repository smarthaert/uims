unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, StdCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  IniFiles, TlHelp32, ShellApi, ComCtrls, AppEvnts, Menus;

type
  TFormMain = class(TForm)
    Memo1: TMemo;
    btn_Update: TBitBtn;
    PB_Cur: TProgressBar;
    Panel1: TPanel;
    Image1: TImage;
    PB_Whole: TProgressBar;
    Label2: TLabel;
    Label1: TLabel;
    Btn_Cancel: TBitBtn;
    IdHTTP1: TIdHTTP;
    LabelShowInfo: TLabel;
    TimerAppClose: TTimer;
    TimerFormMin: TTimer;
    ApplicationEvents1: TApplicationEvents;
    PopupMenuIcon: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure btn_UpdateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Btn_CancelClick(Sender: TObject);
    procedure IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TimerAppCloseTimer(Sender: TObject);
    procedure TimerFormMinTimer(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    { Private declarations }
    procedure HttpDownLoad(aURL, aFile: string; bResume: Boolean);

    procedure CreateStrList;
    procedure ImpUpdateInfo;
    Procedure SeperateStrToStrList(Str, Ch: string; Mystring: TStrings);

    procedure ReadIni;
    procedure StartUpdate;
    function KillProcess(ProcessName:PChar):Boolean;
    //托盘图标被单击的事件处理
    procedure IconClick(var Msg:TMessage);message WM_USER+1;
    function InstallIcon(IsTrue:Boolean;Handle:THandle;IconHandle:THandle;szTipStr:PChar):Boolean;
    //procedure WriteErrLog(ErrStr:String);
  public
    { Public declarations }
  end;

type
  RunProcess = class(TThread)   //线程类
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;
  
const
  UpdateDirName = 'Update';
  UpdateFile = 'update.txt';
  HomePage = 'http://www.aisoho.com/';
  UpdateVerFile = 'http://www.aisoho.com/update/updatelist.exe';
  AuthorInformation = 'TOP_Browser_Update @BeiJing 2005-2008';

var
  FormMain: TFormMain;
  MyDir: String;
  UpdateDir: String;
  TitleStr: String;
  Url: String; //
  RunFile: string;
  CurrentVer, NewVer: String;
  CurrentVerInt, NewVerInt: Integer;
  AutoUpdateI: Integer; //是否自动更新标志
  RunProcess1: RunProcess;  //子线程
  UpdateFileStr, DeleteFileStr:String;
  UpdateList, DeleteList:TStringList; //定义链表对象
  AbortTransfer: Boolean; //是否中断
  BytesToTransfer: LongWord; //下载总大小
  nDownFileCount: integer; //需下载的文件数
  NeedRun: Boolean; //升级后是否需要调用执行主程序?

implementation

{$R *.dfm}

procedure RunProcess.Execute;   //线程
begin
try
  FreeOnTerminate:=True;
  FormMain.StartUpdate;
  //Sleep(10000);
  //Application.Terminate;
except end;
end;

function ReadConfig(IniSetFileName,SectionName,ValueName:String):String;
var
  IniHandle:TIniFile;
begin
try
  If FileExists(ExtractFilePath(Application.ExeName)+IniSetFileName) then
  begin
    IniHandle := TIniFile.Create(ExtractFilePath(Application.ExeName)+IniSetFileName);
    Result:=IniHandle.ReadString(SectionName,ValueName,'');
    IniHandle.free;
  end;
except end;
end;

procedure TFormMain.ReadIni;
var
  IniFile: TIniFile;
  NewVer: String;
begin                       
try
  IniFile:=TIniFile.Create(MyDir + UpdateFile);
    try
      TitleStr:=IniFile.ReadString('RunData','TitleStr','');
      //ShowMessage(Url);
      NewVer := IniFile.ReadString('RunData', 'NewVer', NewVer);
      Url:=ReadConfig(UpdateFile,'RunData','URL');
      RunFile:=ReadConfig(UpdateFile,'RunData','RunFile');
      if (Trim(TitleStr)<>'') then
      begin
        Application.Title:=Trim(TitleStr)+'  '+'在线升级';
        Self.Caption:=Application.Title;
      end;
      //LVersion.Caption:='最新版本:'+'0'+'  '+'当前版本:'+CurrentVer;
      Panel1.Caption:=Format('从旧版本( %S )升级到新版本( %S )',[CurrentVer, NewVer]);
    finally
      FreeAndNil(IniFile);
    end;
except end;
end;

//http方式下载
procedure TFormMain.HttpDownLoad(aURL, aFile: string; bResume: Boolean);
var
  tStream: TFileStream;
begin
  try
    //aFile := '999.exe';
    //aUrl := 'http://www.aisoho.com/update/top.exe';       //haha
     //如果文件已经存在
    if FileExists(aFile) then tStream := TFileStream.Create(aFile, fmOpenWrite)
    else tStream := TFileStream.Create(aFile, fmCreate);
    if bResume then //续传方式
      begin
        IdHTTP1.Request.ContentRangeStart := tStream.Size - 1;
        tStream.Position := tStream.Size - 1; //移动到最后继续下载
        IdHTTP1.Head(aURL);
        IdHTTP1.Request.ContentRangeEnd := IdHTTP1.Response.ContentLength;
      end
    else //覆盖或新建方式
      begin
        IdHTTP1.Request.ContentRangeStart := 0;
      end;
    try
      IdHTTP1.Get(aURL, tStream); //开始下载
    finally
      tStream.Free;
    end;
  Except
    on E:Exception do
      begin
        if (Pos('Operation aborted',E.Message)>=0) and AbortTransfer then
          begin
            E.Message:='已被用户中断';
          end;
        Application.MessageBox(PChar('升级过程中出现了错误了,错误信息如下：'+#13+#13+E.Message),PChar('系统提示'),Mb_OK+MB_ICONERROR);
        //WriteErrLog('升级过程中出现了错误了,错误信息如下：'+E.Message);
        Abort;
      end;
  end;
end;

{
procedure TFormMain.MyDownLoad(aURL, aFile: string; bResume: Boolean);
begin
  case GetProt(aURL) of
    0: Application.MessageBox(PChar('不可识别的地址'),PChar('系统提示'),Mb_OK+MB_ICONERROR);
    1: HttpDownLoad(aURL, aFile, bResume);
    2: ;
  end;
end;
}

procedure TFormMain.btn_UpdateClick(Sender: TObject);
begin
try
try
  KillProcess(PChar(RunFile));
  finally
  btn_Update.Enabled:=False;
  Btn_Cancel.Caption:='取消升级';
  RunProcess1:=RunProcess.Create(false);
  RunProcess1.Resume;
  Sleep(1000);
  end;
except end;
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
try
  Action:=caFree;
  InstallIcon(false, FormMain.Handle,Application.Icon.Handle,PChar(TitleStr + '  正在升级过程中...'));
except end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  Str: String;
  Buffer, Buffer2, Buffer3, Buffer4: array[0..2047] of char;
  Hnd:THandle;
  Found: HWND;
  Atom: TAtom;
begin
try
  MyDir := ExtractFilePath(ParamStr(0));
  if MyDir[Length(MyDir)] <> '\' then MyDir := MyDir + '\';
  AutoUpdateI := 0;
  Hnd := CreateMutex(nil,False,PChar(AuthorInformation));
  if GetLastError=ERROR_ALREADY_EXISTS then
  begin
    //Close;
    Application.Terminate;
    exit;
  end;

  UpdateDir := MyDir + UpdateDirName;
  if UpdateDir[Length(UpdateDir)] <> '\' then UpdateDir := UpdateDir + '\';
  if not DirectoryExists(UpdateDir) then MkDir(UpdateDir);

  GetPrivateProfileString('RunData',PChar('NewOK'),nil,Buffer,SizeOf(Buffer),PChar({MyDir}UpdateDir + UpdateFile));
  GetPrivateProfileString('RunData',PChar('CurrentVer'),nil,Buffer2,SizeOf(Buffer2),PChar({MyDir}UpdateDir + UpdateFile));
  GetPrivateProfileString('RunData',PChar('AutoUpdate'),nil,Buffer3,SizeOf(Buffer3),PChar({MyDir}UpdateDir + UpdateFile));
  GetPrivateProfileString('RunData',PChar('NeedRun'),nil,Buffer4,SizeOf(Buffer4),PChar({MyDir}UpdateDir + UpdateFile));
  AutoUpdateI := StrToIntDef(String(Buffer3), 0);
  Str := String(Buffer);
  CurrentVer := String(Buffer2);
  if String(Buffer4) = '1' then NeedRun := true;
  //ShowMessage(Str);
  if (Trim(Str) = '0') or (Trim(Str) = '') then
  begin
    if FileExists(MyDir + UpdateFile) then DeleteFile(MyDir + UpdateFile);
    HttpDownLoad(UpdateVerFile, MyDir + UpdateFile, false);
  end;
  if not FileExists(MyDir + UpdateFile) then
  begin
    if not FileExists(MyDir + UpdateFile) then
    begin
      ShowMessage('配置文件：'+ MyDir + UpdateFile + ' 不存在!升级程序将退出!请在打开的网页中进行手动下载最新软件包!');
      ShellExecute(Handle,'open',HomePage, nil, nil, 0);
      Application.Terminate;
    end;
  end;

  ReadIni;

  CreateStrList;
  ImpUpdateInfo;

  if AutoUpdateI = 0 then
    //Application.ShowMainForm:=true
  else
  begin  
    //Application.ShowMainForm:=true;
    //InstallIcon(true,FormMain.Handle,Application.Icon.Handle,PChar(TitleStr + '正在升级过程中...'));
    //KillProcess(PChar(RunFile)); //kkkkkkkkkkkkkkkkkkkkkkkkkk
    btn_Update.Click;
  end;
  if not NeedRun then FormMain.Caption := FormMain.Caption + ('  升级完成将自动退出!');
except end;
end;

procedure TFormMain.Btn_CancelClick(Sender: TObject);
begin
try
  if not btn_Update.Enabled then
  begin
    exit;
    if Application.MessageBox(PChar('文件还没有下载完毕，确认要中断吗？'),PChar('系统提示'),MB_YESNO+MB_ICONQUESTION)=IDNo then Exit;
    AbortTransfer := True;
    Close;
  end
  else
  begin
    //if Application.MessageBox(PChar('确认要退出程序吗？'),PChar('系统提示'),MB_YESNO+MB_ICONQUESTION)=IDNo then Exit else Close;
    Close;
  end;
except end;
end;

procedure TFormMain.IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;const AWorkCount: Integer);
begin
  try
    if AbortTransfer then
      begin //中断下载
        IdHTTP1.Disconnect;
      end;
    PB_Cur.Position := AWorkCount;
    Application.ProcessMessages;
  except
    //WriteErrLog('错误，出现在事件IdHTTP1Work中');
  end;
end;

procedure TFormMain.IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;const AWorkCountMax: Integer);
begin
  try
    AbortTransfer := False;
    if AWorkCountMax > 0 then PB_Cur.Max := AWorkCountMax
    else  PB_Cur.Max := BytesToTransfer;
  except
    //WriteErrLog('错误，出现在事件IdHTTP1WorkBegin中');
  end;
end;

procedure TFormMain.IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
try
  if AbortTransfer then
    begin
      //Application.MessageBox(PChar('升级失败，已被用户中断'),PChar('系统提示'),MB_OK+MB_ICONERROR);
      Abort;
      Application.Terminate;
    end
  else
    begin
      //if aHint then Application.MessageBox(PChar('OK,程序升级成功!'),PChar('系统提示'),MB_OK+MB_ICONINFORMATION);
    end;
  PB_Cur.Position := 0;
except end;
end;

procedure TFormMain.CreateStrList;
begin
try
  UpdateList := TStringList.Create;
  DeleteList := TStringList.Create;
except end;
end;

procedure TFormMain.ImpUpdateInfo;
var
  i:integer;
  //aStr,aSql:String;
  MyIni:TIniFile;
begin
try
  if UpdateList<>nil then
  begin
    for i:=UpdateList.Count-1 downto 0 do
      UpdateList.Delete(i);
  end;
  if DeleteList<>nil then
  begin
    for i:=DeleteList.Count-1 downto 0 do
      DeleteList.Delete(i);
  end;

  MyIni := TIniFile.Create(MyDir+UpdateFile);
  try
    DeleteFileStr := ReadConfig(UpdateFile,'RunData','DeleteFileList');
    UpdateFileStr := ReadConfig(UpdateFile,'RunData','UpdateFileList');
    SeperateStrToStrList(DeleteFileStr,',',DeleteList);
    SeperateStrToStrList(UpdateFileStr,',',UpdateList);
  finally
    nDownFileCount := UpdateList.Count;
    FreeAndNil(MyIni);
  end;
except end;
end;

procedure TFormMain.SeperateStrToStrList(Str, Ch: string; Mystring: TStrings);
{字符串Str以Ch分隔成几段小字符串,该函数是将这些小字符串提取出来并保存在MyString中}
var 
  sit, n : integer;
  S : string;
begin
try
  if Mystring=nil then Exit;
  //Str:=StringReplace(Str,' ','',[]);
  if (Str='') Or (Ch='') then Exit;
  MyString.Clear;
  S := Str;
  n := Length(Ch);
  while True do
  begin
    if Pos(Ch, S) = 0 then
    begin
    MyString.Add(S);
    Break;
    end;
    sit := Pos(Ch, S);
    MyString.Add(Copy(S, 1, sit - 1));
    S := Copy(S, sit + n, Length(S));
  end;
except end;
end;

{
procedure TFormMain.DownAFile(aName: String);
var
  aURL, aFile: string;
  LStr:string;
begin
try    
  aUrl := 'http://';
  MyDownLoad(aURL, aFile, False); //建立新文件下载
except end;
end;
}

procedure TFormMain.StartUpdate;
var
  i:integer;
  //dFileName,LangFold:string;
  aFileName:String;  //去掉路径后的文件名
begin
try
  try
    with
    PB_Whole do
      begin
        Max:=2+2*nDownFileCount;
        Min:=0;
        Step:=1;
      end;

    LabelShowInfo.Caption:='开始准备升级...';
    PB_Whole.StepIt;
    Refresh;

    LabelShowInfo.Caption:='开始下载所需要文件,请等待...';
    PB_Whole.StepIt;
    Refresh;

    //下载新版本的文件 
    for i:=0 to UpdateList.Count-1 do
    begin
      HttpDownLoad(Url + UpdateList.Strings[i], UpdateDir + UpdateList.Strings[i], false);
      PB_Whole.StepIt;
      Refresh;
    end;

    LabelShowInfo.Caption:='所需要的更新文件已经下载完毕...';
    //PB_Whole.StepIt;
    PB_Whole.Position := PB_Whole.Max;  
    Refresh;    //kkkoo

    if AutoUpdateI = 0 then
    Application.MessageBox(PChar('恭喜，程序已经升级到最新版本'),PChar('系统提示'),MB_OK+MB_ICONINFORMATION);

    //StartRun;
    for i:=0 to UpdateList.Count-1 do
    CopyFile(PChar(UpdateDir + UpdateList.Strings[i]), PChar(MyDir + UpdateList.Strings[i]), false);
    if NeedRun then
    begin
      ShellExecute(0,'open', PChar(MyDir + RunFile),nil,nil,SW_SHOWNORMAL);
      WritePrivateProfileString('RunData','NeedRun','0',PChar(ExtractFilePath(ParamStr(0))+'update.txt'));
    end;
    for i:=0 to DeleteList.Count-1 do DeleteFile(UpdateDir + DeleteList.Strings[i]);
    //BBUpdate.Enabled := false;
  finally
    TimerAppClose.Enabled := true;
    btn_Update.Enabled:=True;
    //Screen.Cursor:=crDefault;
    PB_Cur.Position:=0;
    PB_Whole.Position:=0;
  end;
  FormMain.Close;
except end;
end;

//结束进程
function TFormMain.KillProcess(ProcessName:PChar):Boolean;
var
  ContinueLoop:BOOL;
  FSnapshotHandle:THandle;
  FProcessEntry32:TProcessEntry32;
  Path:String;
  ID:DWORD;
  hh:THandle;
  i:Integer;
begin
try
  i:=FindWindow(nil,PChar(ProcessName));
  if i<>0 then
    SendMessage(i,WM_CLOSE,0,0); //Sendmessage(i,$0010,0,0);
  FSnapshotHandle:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
  FProcessEntry32.dwSize:=SizeOf(FProcessEntry32);
  ContinueLoop:=Process32First(FSnapshotHandle,FProcessEntry32);
  while Integer(ContinueLoop)<>0 do
  begin
    if (((UpperCase(ExtractFileName(FProcessEntry32.szExeFile))=UpperCase(ProcessName))
    or (UpperCase(FProcessEntry32.szExeFile)=UpperCase(ProcessName))))  then
    begin //and (pos(UpperCase(path),UpperCase(FProcessEntry32.szExeFile))>1)
      Id:=FProcessEntry32.th32ProcessID;
      hh:=OpenProcess(PROCESS_ALL_ACCESS,True,Id);
      TerminateProcess(hh,0);
      Result:=True;
      Path:=FProcessEntry32.szExeFile;
      Break;
    end
    else Result:=False;
    ContinueLoop:=Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
except
  Result:=False;
end;
end;

//托盘图标的单击事件的处理过程
procedure TFormMain.IconClick(var Msg:TMessage);
var
  P:TPoint;
begin
try
  try
  if (Msg.LParam=WM_LBUTTONDOWN) then
  begin
    {
    FormMain.Visible := not FormMain.Visible;
    Application.Restore;
    }
    if FormMain.Visible then
    begin
      SendMessage(Application.Handle,WM_SYSCOMMAND,SC_MINimize,0);
      ShowWindow(Application.Handle, SW_HIDE );
      FormMain.Hide;
    end
    else
    begin
      Application.Restore;
      FormMain.Show;
    end;
  end
  else if (Msg.LParam=WM_RBUTTONDOWN) then
  begin
    GetCursorPos(P);
    PopupMenuIcon.Popup(P.X,P.Y);
    {
    if FormMain.Visible then
    begin
      SendMessage(Application.Handle,WM_SYSCOMMAND,SC_MINimize,0);
      ShowWindow(Application.Handle, SW_HIDE );
      FormMain.Hide;
    end
    else
    begin
      FormMain.Show;
      Application.Restore;
    end;
    }
  end;
  //if (Msg.LParam=WM_MBUTTONDOWN) then Halt;
  finally
  inherited;
  end;
except end;
end;

//{
//安装ICO到托盘
function TFormMain.InstallIcon(IsTrue:Boolean;Handle:THandle;IconHandle:THandle;szTipStr:PChar):Boolean;
var
  IconData:TNotifyIconData; //全局变量
begin
try
  IconData.cbSize:=SizeOf(IconData);
  IconData.Wnd:=Handle;
  IconData.uID:=1;
  IconData.uFlags:=NIF_ICON or NIF_MESSAGE or NIF_TIP;
  IconData.uCallBackMessage:=WM_USER+1;
  IconData.hIcon:=IconHandle;
  StrCopy(IconData.szTip,pchar(szTipStr));
  //IconData.szTip:=array(szTipStr);
  if IsTrue=True then
    Shell_NotifyIcon(NIM_ADD,@IconData)
  else
    Shell_NotifyIcon(NIM_Delete,@IconData);
  Result:=True;
except
  Result:=False;
end;
end;
//}

{
procedure TFrm_Main.WriteErrLog(ErrStr:String);
var
  LogFilename: String;
  LogFile: TextFile;
begin
  LogFilename:=ExtractFilePath(ParamStr(0))+'Error.Log';
  AssignFile(LogFile, LogFilename);
  if FileExists(LogFilename) then Append(LogFile)
  else Rewrite(LogFile);
  Writeln(Logfile,DateTimeToStr(now)+': '+ErrStr);
  CloseFile(LogFile);
end;
}

procedure TFormMain.FormDestroy(Sender: TObject);
begin
try
  try
  InstallIcon(false, FormMain.Handle,Application.Icon.Handle,PChar(TitleStr + '  正在升级过程中...'));
  finally
  UpdateList.Free;
  DeleteList.Free;
  FormMain:=nil;
  end;
except end;
end;

procedure TFormMain.TimerAppCloseTimer(Sender: TObject);
begin
try
  Application.Terminate;
except end;
end;

procedure TFormMain.TimerFormMinTimer(Sender: TObject);
begin
try
  TimerFormMin.Enabled := false;
  if not NeedRun then
  begin
    //FormMain.WindowState := wsMinimized;
    SendMessage(Application.Handle,WM_SYSCOMMAND,SC_MINimize,0);
    ShowWindow(Application.Handle, SW_HIDE );
    FormMain.Hide;
    InstallIcon(true, FormMain.Handle,Application.Icon.Handle,PChar(TitleStr + '  正在升级过程中...'));
  end;
except end;
end;

procedure TFormMain.ApplicationEvents1Minimize(Sender: TObject);
begin
try
  Hide;
except end;
end;

procedure TFormMain.N1Click(Sender: TObject);
begin
try
    if FormMain.Visible then
    begin
      SendMessage(Application.Handle,WM_SYSCOMMAND,SC_MINimize,0);
      ShowWindow(Application.Handle, SW_HIDE );
      FormMain.Hide;
    end
    else
    begin
      Application.Restore;
      FormMain.Show;
    end;
except end;
end;

procedure TFormMain.N3Click(Sender: TObject);
begin
try
  Application.Terminate;
except end;
end;

end.
