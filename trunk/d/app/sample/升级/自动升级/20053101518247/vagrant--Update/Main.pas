unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Registry, StdCtrls,shellapi, WinSkinData, ComCtrls, ExtCtrls,
  Buttons, ImgList, IdFTP, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP,IniFiles;

type
  TFrm_Main = class(TForm)
    Memo1: TMemo;
    SkinData1: TSkinData;
    btn_Update: TBitBtn;
    PB_Cur: TProgressBar;
    Panel1: TPanel;
    Image1: TImage;
    PB_Whole: TProgressBar;
    Label2: TLabel;
    Label1: TLabel;
    Btn_Cancel: TBitBtn;
    IdHTTP1: TIdHTTP;
    IdFTP1: TIdFTP;
    Label3: TLabel;
    procedure btn_UpdateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Btn_CancelClick(Sender: TObject);
    procedure IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    LocalVer,NetVer:Double;
    LocalVerStr,NetVerStr:String;
    SQLCount:integer;  //需执行SQL的总数
    nDownFileCount:integer; //需下载的文件数
    DispStr:String;   //显示正在执行哪个动作的信息
    procedure CreateScript;
    procedure RunScript(const sSQL: String);
    function  GetFileVer(const AFileName: string;AIndex:integer): Cardinal;
    function  GetFileVerStr(AFileName:String): String;
    procedure ClearReg;
    procedure WriteErrLog(ErrStr:String);
  private
    AbortTransfer: Boolean; //是否中断
    BytesToTransfer: LongWord; //下载总大小
    aHint,NoRunSQL:Boolean;
    WinPath,TmpURL,MyURL:String;
    NetIni:TIniFile;
    WebStr:String;
    procedure FtpDownLoad(aURL, aFile: string; bResume: Boolean);
    procedure HttpDownLoad(aURL, aFile: string; bResume: Boolean);
    procedure MyDownLoad(aURL, aFile: string; bResume: Boolean);
    function  GetProt(aURL: string): Byte;
    function  GetURLFileName(aURL: string): string;
    procedure GetFTPParams(aURL: string; var sName, sPass, sHost, sPort,sDir: string);  
    procedure BakOldFile;
    procedure DownNetUpdateIni;
    procedure DispPanelVer;
    procedure DownAFile(aName:String);
  public
    { Public declarations }
  end;

var
  Frm_Main: TFrm_Main;
  TxtFile:TextFile;
  DownList,ExeList:TStringList;
  AverageSpeed: Double = 0;
implementation

uses DM, DBTables, DB, ADODB;

{$R *.dfm}

//检测下载的地址是http还是ftp
function TFrm_Main.GetProt(aURL: string): Byte;
begin
  Result := 0;
  if Pos('http', LowerCase(aURL))= 1 then  Result := 1; //http协议
  if Pos('ftp', LowerCase(aURL)) = 1 then  Result := 2; //ftp协议
end;

 //返回下载地址的文件名
function TFrm_Main.GetURLFileName(aURL: string): string;
var
  i: integer;
  s: string;
begin
  s := aURL;
  i := Pos('/', s);
  while i <> 0 do //去掉"/"前面的内容剩下的就是文件名了
    begin
      Delete(s, 1, i);
      i := Pos('/', s);
    end;
  Result := s;
end;

//分析ftp地址的登陆用户名，密码和目录
procedure TFrm_Main.GetFTPParams(aURL: string; var sName, sPass, sHost, sPort, sDir: string);
var
  i, j: integer;
  s, tmp: string;
begin
  s := aURL;
  if Pos('ftp://', LowerCase(s)) <> 0 then  Delete(s, 1, 6);//去掉ftp头
  i := Pos('@', s);
  if i <> 0 then //地址含用户名，也可能含密码
    begin
      tmp := Copy(s, 1, i - 1);
      s := copy(s, i+1, Length(s));
      j := Pos(':', tmp);
      if j <> 0 then //包含密码
        begin
          sName := Copy(tmp, 1, j - 1); //得到用户名
          sPass := Copy(tmp, j + 1, i - j - 1); //得到密码
        end
      else
        begin
          sName := tmp;
          sPass := Inputbox('输入框','请输入登陆ftp密码','');
        end;
    end
  else //匿名用户
    begin
      sName := 'anonymous';
      sPass := 'test@ftp.com';
    end;
  i := Pos(':', s);
  j := Pos('/', s);
  sHost := Copy(s, 1, j - 1); //主机
  if i <> 0 then  sPort := Copy(s, i + 1, j - i - 1)//含端口
  else  sPort := '21'; //默认21端口
  tmp := Copy(s, j + 1, Length(s));
  while j <> 0 do
    begin
      Delete(s, 1, j);
      j := Pos('/', s);
    end; //目录
  sDir := '/' + Copy(tmp, 1, Length(tmp) - Length(s) - 1);
end;

//ftp方式下载
procedure TFrm_Main.FtpDownLoad(aURL, aFile: string; bResume: Boolean);
var
  tStream: TFileStream;
  sName, sPass, sHost, sPort, sDir: string;
begin
  if FileExists(aFile) then tStream := TFileStream.Create(aFile, fmOpenWrite)
  else  tStream := TFileStream.Create(aFile, fmCreate); //建立文件流
  GetFTPParams(aURL, sName, sPass, sHost, sPort, sDir);
  with IdFTP1 do
  try
    if Connected then Disconnect; //重新连接
    Username := sName;
    Password := sPass;
    Host := sHost;
    Port := StrToInt(sPort);
    Connect;
  except
    exit;
  end;

  IdFTP1.ChangeDir(sDir); //改变目录
  BytesToTransfer := IdFTP1.Size(aFile);
  try
    if bResume then //续传
      begin
        tStream.Position := tStream.Size;
        IdFTP1.Get(aFile, tStream, True);
      end
    else
      begin
        IdFTP1.Get(aFile, tStream, False);
      end;
  finally
    tStream.Free;
  end;
end;

//http方式下载
procedure TFrm_Main.HttpDownLoad(aURL, aFile: string; bResume: Boolean);
var
  tStream: TFileStream;
begin
  try
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
        WriteErrLog('升级过程中出现了错误了,错误信息如下：'+E.Message);
        CopyFile(PChar(ExtractFilePath(ParamStr(0))+'Bak\KQSys.exe'),PChar(ExtractFilePath(ParamStr(0))),False);
        Abort;
      end;
  end;
end;

procedure TFrm_Main.MyDownLoad(aURL, aFile: string; bResume: Boolean);
begin
  case GetProt(aURL) of
    0: Application.MessageBox(PChar('不可识别的地址'),PChar('系统提示'),Mb_OK+MB_ICONERROR);
    1: HttpDownLoad(aURL, aFile, bResume);
    2: FtpDownLoad(aURL, aFile, bResume);
  end;
end;


procedure TFrm_Main.btn_UpdateClick(Sender: TObject);
var
  aURL, aFile: string;
  LStr:string;
  i:integer;
  dFileName,LangFold:string; //网络上Ini文件名(如Language\CHS.INI)跟语言文件夹
  aFileName:String;  //去掉路径后的文件名
begin
  DispStr:='正在下载新版本文件%S,请稍候...';
  try
    Screen.Cursor:=crSQLWait;
    btn_Update.Enabled:=False;
    Btn_Cancel.Caption:='中断升级';
    try
      Label3.Caption:='正在获取升级配置文件,请稍候...';
      Refresh;
      DownNetUpdateIni;
    except
      on  E:Exception do
        begin
          Application.MessageBox(PChar('获取升级配置文件失败，请梢候重试'+#13+#13+E.Message),PChar('系统提示'),MB_OK+MB_ICONERROR);
          WriteErrLog('获取升级配置文件失败，错误信息如下:'+E.Message);
          Exit;
        end;
    end;
    with PB_Whole do
      begin
        Max:=6+2*nDownFileCount;
        Min:=0;
        Step:=1;
      end;

    Label3.Caption:='正在启动升级配置文件...';
    DispPanelVer;
    PB_Whole.StepIt;
    Refresh;

    Label3.Caption:='正在备份旧版本文件,请稍候...';
    BakOldFile;
    PB_Whole.StepIt;
    Refresh;

   //下载新版本的文件 
    for i:=0 to DownList.Count-1 do
      begin
        dFileName:=Copy(DownList.Strings[i],Pos('=',DownList.Strings[i])+1,Length(DownList.Strings[i]));
        if Pos('\',dFileName)>0 then
          begin
            LangFold :=copy(dFileName,0,Pos('\',dFileName)-1);
            aFileName:=copy(dFileName,Pos('\',dFileName)+1,Length(dFileName));
            Label3.Caption:=Format(DispStr,[aFileName]);
            Refresh;
            DownAFile(aFileName);
          end
        else
          begin
            Label3.Caption:=Format(DispStr,[dFileName]);
            Refresh;
            DownAFile(dFileName);
          end;
        PB_Whole.StepIt;  
      end;

    ClearReg;
    PB_Whole.StepIt;

    Memo1.Lines.LoadFromFile(ExtractFilePath(ParamStr(0))+'UpdateSQL.dll');
    DeleteFile(ExtractFilePath(ParamStr(0))+'UpdateSQL.dll');
    Label3.Caption:='正在更新数据库信息，请稍侯...';
    Refresh;
    CreateScript;
    PB_Whole.StepIt;

    Label3.Caption:='正在更新本地程序，请稍侯...';
    Refresh;
    CopyFile(PChar('CHS.ini'),PChar(ExtractFilePath(ParamStr(0)+'Language\CHS.ini')),False);
    CopyFile(PChar('CHT.ini'),PChar(ExtractFilePath(ParamStr(0)+'Language\CHT.ini')),False);
    CopyFile(PChar('MenuConf.ini'),PChar(WinPath+'MenuConf.ini'),False);
    Ini:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'SysData\Update.ini');
    with Ini do
      begin
        WriteString('WWW','URL',WebStr);
        Free;
      end;
    PB_Whole.StepIt;


    DeleteFile('CHS.INI');
    DeleteFile('CHT.INI');
    DeleteFile('MenuConf.INI');
    PB_Whole.StepIt;
    Application.MessageBox(PChar('恭喜，程序已经升级到最新版本'),PChar('系统提示'),MB_OK+MB_ICONINFORMATION);
  finally
    btn_Update.Enabled:=True;
    Screen.Cursor:=crDefault;
    PB_Cur.Position:=0;
    PB_Whole.Position:=0;
  end;
  Close;
end;

//创建数据库脚本(一个一个对象)
procedure TFrm_Main.CreateScript;
const
  sTAG = ';';
var
  Str : String;
  sSQL : String;
  iPos : Integer;
begin
  with PB_Cur do
    begin
      Max:=SQLCount;
      Min:=0;
      Step:=1;
    end;
  Str := Trim(Memo1.Lines.Text);
  while True do
    begin
      iPos := Pos(sTAG, Str);
      if (iPos > 0) then
        begin
          sSQL := Copy(Str, 1, iPos - 1);
          if not NoRunSql then RunScript(sSQL);
          Sleep(100);
          PB_Cur.StepIt;
          Delete(Str, 1, iPos);
          Application.ProcessMessages;
        end;
      if (Length(Str) = 0) then  break;
    end;
end;

//运行每个脚本
procedure TFrm_Main.RunScript(const sSQL: String);
begin
  Frm_DM.ADOQuery1.SQL.Text := sSQL;
  try
    Frm_DM.ADOQuery1.ExecSQL;
  except
    on E:Exception  do
      begin
         ShowMessage(E.Message);
         WriteErrLog(E.Message);
      end;
  end;
end;


procedure TFrm_Main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

//得到要升级文件版本
function TFrm_Main.GetFileVer(const AFileName: string;AIndex:integer): Cardinal;
var
  FileName: string;
  InfoSize, Wnd: DWORD;
  VerBuf: Pointer;
  FI: PVSFixedFileInfo;
  VerSize: DWORD;
begin
  Result := Cardinal(-1);
  FileName := AFileName;
  UniqueString(FileName);
  InfoSize := GetFileVersionInfoSize(PChar(FileName), Wnd);
  if InfoSize <> 0 then
  begin
    GetMem(VerBuf, InfoSize);
    try
      if GetFileVersionInfo(PChar(FileName), Wnd, InfoSize, VerBuf) then
        if VerQueryValue(VerBuf, '\', Pointer(FI), VerSize) then
          begin
            if AIndex=1      then    Result:= FI.dwFileVersionMS
            else if AIndex=2 then    Result:= FI.dwFileVersionLS;
          end;
    finally
      FreeMem(VerBuf);
    end;
  end;
end;


//得到要升级文件版本
function TFrm_Main.GetFileVerStr(AFileName:String): String;
var
	FileVersion: Cardinal;
	Major1, Major2, Minor1, Minor2: Integer;
begin
	FileVersion := GetFileVer(AFileName,1);
	Major1 := FileVersion shr 16;
	Major2 := FileVersion and $FFFF;

	FileVersion := GetFileVer(AFileName,2);
	Minor1 := FileVersion shr 16;
	Minor2 := FileVersion and $FFFF;
	Result := Format('%d.%d.%d.%d', [Major1, Major2, Minor1, Minor2] );
end;

procedure TFrm_Main.FormCreate(Sender: TObject);
var
  MyPath:String;
begin
  SetLength(MyPath,100);
  GetWindowsDirectory(Pchar(MyPath),100);
  SetLength(MyPath,strLen(Pchar(MyPath)));
  WinPath:=Trim(MyPath)+'\';
end;

procedure TFrm_Main.FormShow(Sender: TObject);
var
  WebIni:TIniFile;
begin
  DownList:=TStringList.Create;
  ExeList :=TStringList.Create;  
  Panel1.Caption:='欢迎使用考勤管理软件智能升级程序';
  WebIni:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'SysData\Update.ini');
  with WebIni do
     TmpURL:=ReadString('WWW','URL','http://free.efile.com.cn/');
  MyURL:=TmpURL+'vagrant/KQ/';   
  WebIni.Free;
end;

procedure TFrm_Main.Btn_CancelClick(Sender: TObject);
begin
  if not btn_Update.Enabled then
    begin
      if Application.MessageBox(PChar('文件还没有下载完毕，确认要中断吗？'),PChar('系统提示'),MB_YESNO+MB_ICONQUESTION)=IDNo then Exit;
      AbortTransfer := True;
    end
  else
    begin
      if Application.MessageBox(PChar('确认要退出程序吗？'),PChar('系统提示'),MB_YESNO+MB_ICONQUESTION)=IDNo then Exit;    
    end;
end;

procedure TFrm_Main.IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;const AWorkCount: Integer);
begin
  try
    if AbortTransfer then
      begin //中断下载
        IdHTTP1.Disconnect;
        IdFTP1.Abort;
      end;
    PB_Cur.Position := AWorkCount;
    Application.ProcessMessages;
  except
    WriteErrLog('错误，出现在事件IdHTTP1Work中');
  end;
end;

procedure TFrm_Main.IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;const AWorkCountMax: Integer);
begin
  try
    AbortTransfer := False;
    if AWorkCountMax > 0 then PB_Cur.Max := AWorkCountMax
    else  PB_Cur.Max := BytesToTransfer;
  except
    WriteErrLog('错误，出现在事件IdHTTP1WorkBegin中');
  end;
end;

procedure TFrm_Main.IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
  if AbortTransfer then
    begin
//      Application.MessageBox(PChar('升级失败，已被用户中断'),PChar('系统提示'),MB_OK+MB_ICONERROR);
      Abort;
      Application.Terminate;
    end
  else
    begin
      if aHint then Application.MessageBox(PChar('OK,程序升级成功!'),PChar('系统提示'),MB_OK+MB_ICONINFORMATION);
    end;
  PB_Cur.Position := 0;
end;

procedure TFrm_Main.ClearReg;
var
  MyReg:TRegistry;
  Code,ID,DT:String;
  aDate,DDate:TDate;
begin
  aDate:=Date;
  DDate:=EncodeDate(2004,12,31);
  if aDate<DDate then
    begin
       //
    end;
end;

procedure TFrm_Main.BakOldFile;
var
  BakPath,aFiles:String;
  i:integer;
  dFileName,LangFold:String;
begin
  BakPath:=ExtractFilePath(ParamStr(0))+'Bak';
  if not DirectoryExists(BakPath) then ForceDirectories(BakPath);
  For i:=0 to DownList.Count-1 do
    begin
      dFileName:=Copy(DownList.Strings[i],Pos('=',DownList.Strings[i])+1,Length(DownList.Strings[i]));
      if Pos('\',dFileName)>0 then
        begin
          LangFold:=copy(dFileName,0,Pos('\',dFileName)-1);
          if not DirectoryExists(BakPath+'\'+LangFold) then ForceDirectories(BakPath+'\'+LangFold);
        end;
      CopyFile(PChar(ExtractFilePath(ParamStr(0))+dFileName),PChar(BakPath+'\'+dFileName),False);
      PB_Whole.StepIt;        
    end;  
end;

procedure TFrm_Main.DownNetUpdateIni;
var
  aURL,aFile:String;
  FileStr:TStringList;
  i:integer;
begin
  FileStr:=TStringList.Create;
  aURL := MyURL+'NetUpdate.ini';
  FileStr.Add(IdHTTP1.Get(aURL));
  FileStr.SaveToFile(WinPath+'NetUpdate.ini');
  FileStr.Free;
  NetIni:=TIniFile.Create(WinPath+'NetUpdate.ini');
  with NetIni do
    begin
      ReadSectionValues('FilesList',DownList);
      ReadSectionValues('Exe FileList',ExeList);
      NetVerStr:=ReadString('Version Info','KQSys.exe','');
      SQLCount :=ReadInteger('SQL','SQLCount',15);
      WebStr   :=ReadString('WWW','URL','');
    end;
  nDownFileCount:=DownList.Count;
  NetVer:=StrToFloat(Copy(NetVerStr,1,3));
  DeleteFile(WinPath+'NetUpdate.ini');
end;

procedure TFrm_Main.DispPanelVer;
begin
  if FileExists('KQSys.exe') then
    begin
      LocalVerStr:=GetFileVerStr('KQSys.exe');
      if Pos('65535',LocalVerStr)>0 then Panel1.Caption:=Format('从旧版本升级到新版本( %S )',[NetVerStr])
      else  Panel1.Caption:=Format('从旧版本( %S )升级到新版本( %S )',[LocalVerStr,NetVerStr]);
    end
  else Panel1.Caption:=Format('从旧版本升级到新版本( %S )',[NetVerStr]);
end;


procedure TFrm_Main.DownAFile(aName: String);
var
  aURL, aFile: string;
  LStr:string;
begin
  aURL := MyURL+aName;  //下载地址
  aFile := GetURLFileName(aURL); //得到文件名，例如"KQSys.exe"
  if (aFile='KQSys.exe') or (aFile='Update.exe') then
    begin
      if FileExists(aFile) then
        begin
          if GetFileVerStr(aFile)=NetVerStr then  //说明是最新的版本了
            begin
               case Application.MessageBox(PChar('系统已经是最新版本了，是否还要升级？'),PChar('系统提示'),MB_YESNO+MB_ICONQUESTION) of
                  IDYes:
                    begin
                      aHint:=False;
                      NoRunSQL:=True;
                      MyDownLoad(aURL, aFile, False); //覆盖
                    end;
                  IDNo: Exit; //取消
               end;
            end
          else if Pos('65535',GetFileVerStr(aFile))>0 then
            begin
              case Application.MessageBox(PChar('系统检查到原先文件未下载完毕，是否续传？'),PChar('系统提示'),MB_YESNOCANCEL+MB_ICONQUESTION) of
                  IDYes:
                    begin
                      aHint:=False;
                      MyDownLoad(aURL, aFile, True); //续传
                    end;
                  IDNo:
                    begin
                      MyDownLoad(aURL, aFile, False); //覆盖
                    end;
                  IDCancel: Exit; //取消
              end;
            end
          else if StrToFloat(Copy(GetFileVerStr(aFile),1,3))<NetVer then //说明是旧版本的
            begin
              MyDownLoad(aURL, aFile, False); //建立新文件下载
            end;
        end
      else
        begin
          MyDownLoad(aURL, aFile, False); //建立新文件下载
        end;
    end
  else
    begin
      MyDownLoad(aURL, aFile, False); //建立新文件下载
    end;
end;

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

procedure TFrm_Main.FormDestroy(Sender: TObject);
begin
  DownList.Free;
  ExeList.Free;
  Frm_Main:=nil;
end;

end.
