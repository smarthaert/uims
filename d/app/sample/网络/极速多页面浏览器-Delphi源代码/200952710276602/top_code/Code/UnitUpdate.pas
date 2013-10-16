unit UnitUpdate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls,
  IniFiles, UrlMon,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  ExtCtrls;

type
  TFormUpdate = class(TForm)
    IdHTTP1: TIdHTTP;
    Label1: TLabel;
    PB_Cur: TProgressBar;
    btn_Update: TBitBtn;
    Btn_Cancel: TBitBtn;
    LabelShowInfo: TLabel;
    LabelFlag: TLabel;
    TimerStartRun: TTimer;
    procedure IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure btn_UpdateClick(Sender: TObject);
    procedure Btn_CancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TimerStartRunTimer(Sender: TObject);
    procedure LLUpdateUrlClick(Sender: TObject);
  private
    { Private declarations }
    procedure StartUpdate;
    procedure HttpDownLoad(aURL, aFile: string; bResume: Boolean);
  protected
    //procedure CreateParams(var Params: TCreateParams);override;
  public
    { Public declarations }
    AbortTransfer: Boolean;
  end;
  
type
  RunProcess = class(TThread)   //线程类
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

var
  FormUpdate: TFormUpdate;
  ThreadFlag: Word;
  RunProcess1: RunProcess;  //子线程
  BytesToTransfer: LongWord; //下载总大小
  CopyFileDown: Boolean = false;
  uTitle: String = '在线升级:';
  NewVerInt, NewVer, CopyFileUpdate: String;

implementation

uses UnitMain, const_, var_;

{$R *.dfm}

{
procedure TFormUpdate.CreateParams(var Params: TCreateParams);
begin
try
  inherited CreateParams(Params);
  Params.WndParent:=GetActiveWindow;
except end;
end;
}

//下载文件
function DownloadFile(SourceFile,TargetFile:PChar):Boolean;
begin
try
  Result:=UrlDownloadToFile(nil,Pchar(SourceFile),Pchar(TargetFile),0,nil)=0;
except
  Result:=False;
end;
end;

procedure RunProcess.Execute;   //线程
var
  TempFile: String;
  IniFile: TIniFile;
  //ToExit: Boolean;
begin
try
  FreeOnTerminate := True;
  case ThreadFlag of
  1:
  begin
    ThreadFlag := 0;
    //ToExit := false;
    if FormUpdate.LabelFlag.Caption = '1' then
      FormUpdate.LabelFlag.Caption := '0'
    else
      FormUpdate.LabelFlag.Caption := '1';
    //FormUpdate.btn_Update.Enabled := false;
    LocalCopyFile := LocalCopyFileConst;
    FormUpdate.LabelShowInfo.Caption := '正在版本检查中...';
    TempFile:=UpdateDir+'update.txt';
    if FileExists(TempFile) then DeleteFile(TempFile);
    DownloadFile(PChar(UpdateVerFileUrl),PChar(TempFile));
    if not FileExists(TempFile) then
    DownloadFile(PChar(UpdateVerFileUrl),PChar(TempFile));
    if not FileExists(TempFile) then exit;
    IniFile:=TIniFile.Create(TempFile);
    try
    NewVerInt := IniFile.ReadString('RunData','NewVersionInt','0');   //NewVersionInt
    NewVer := IniFile.ReadString('RunData','NewVer','0');
    CopyFileUpdate := IniFile.ReadString('RunData','CopyFileUpdate','0');
    HostUpdateDir := IniFile.ReadString('RunData','URL',HostUpdateDir);
    MasterFileName := IniFile.ReadString('RunData','RunFile',MasterFileName);
    LocalCopyFile := IniFile.ReadString('RunData','LocalCopyFile',LocalCopyFile);
    //WritePrivateProfileString('RunData','NewVerInt',PChar(NewVerInt),PChar(UpdateDir + CopyNeedIniFile));
    MasterFileUrl := HostUpdateDir + MasterFileName;
    //IniFile.WriteString('RunData','CurrentVer',Version);
    //IniFile.WriteString('RunData','Dir',PChar(ExtractFilePath(ParamStr(0))));   kkkkkkk
    //MessageBox(0,PChar(RunFileName),'',0);
    FormUpdate.Caption := uTitle + ' v' + Version + ' to v' + NewVer;
    FormUpdate.LabelShowInfo.Caption := '目前版本' + Version+ '  ' + '最新版本：' + NewVer;
    //{
    if (CopyFileUpdate = '0') and (FileExists(UpdateDir + LocalCopyFile)) then
    begin
    CopyFileDown := false;
    //ShowMessage('ok.');
    end
    else
    CopyFileDown := true;
    //}
    //{
    if VersionInt<StrToInt(NewVerInt) then
    begin
      FormUpdate.btn_Update.SetFocus;
      if not FormUpdate.Visible then
      if MessageBox(FormMain.Handle,PChar('浏览器已经有最新版本:<' + NewVer + '>' + '目前版本:<' + Version + '>'  + #10 + #13 + '是否下载最新的版本?'),TitleStr + ' 询问:',MB_YESNO+MB_ICONINFORMATION)=ID_NO then
      begin
        FormUpdate.btn_Update.Enabled := true;
        exit;
      end;
      //exit;
      {
      if FileExists(UpdateDir + CopyNeedIniFile) then
      begin
        IniFile2:=TIniFile.Create(UpdateDir + CopyNeedIniFile);
        try   //MessageBox(0,PChar(MD5File(PChar(UpdateDir + MasterFileName))),PChar(IniFile2.ReadString('RunData','MD5FILE','')),0); exit;
        //if (IniFile2.ReadString('RunData','DownOK','0') = '1') and (FileExists(UpdateDir + LocalCopyFile)) and (FileExists(UpdateDir + MasterFileName)) then
        if (NewVerInt=IniFile2.ReadString('RunData','NewVerInt','')) and (MD5File(PChar(UpdateDir + MasterFileName)) = IniFile2.ReadString('RunData','MD5FILE','')) and (FileExists(UpdateDir + LocalCopyFile)) then
        begin
          if MessageBox(FormMain.Handle,PChar('目前版本:<' + Version + '> 最新版本:<' + NewVer + '>' + #10 + #13 + '浏览器的更新文件已经下载完毕,是否更新到最新版本？'),TitleStr + ' 询问:',MB_YESNO+MB_ICONINFORMATION)=ID_YES then
          begin
            //ToExit := true;
            AppCloseHint := false;
            FormUpdate.Hide;
            WinExec(PChar(UpdateDir + LocalCopyFile), SW_Hide);
            //dddddddd
            FormUpdate.Close;
            //Halt;
            FormMain.Close;
            exit;
          end
          else
          begin
            //WritePrivateProfileString('RunData','NewVerInt',PChar(NewVerInt),PChar(UpdateDir + CopyNeedIniFile));
            exit;
          end;
        end;
        finally
          IniFile2.Free;
        end;
      end;
      }
      //FormUpdate.btn_Update.Caption := '开始升级';
      //if not ToExit then
      {
      if FormUpdate.LabelFlag.Caption = '1' then   
      begin
        //FormUpdate.BShow.Click;
        ThreadFlag := 9;             
        RunProcess1:=RunProcess.Create(false);
        RunProcess1.Resume;
        Sleep(1000);
      end;
      }
      //if FormUpdate.IdHTTP1.
      //FormUpdate.btn_Update.Enabled := true;
      //if FormUpdate.Visible then FormUpdate.btn_Update.SetFocus;  //kk
    end
    else
    begin
      //FormUpdate.btn_Update.Caption := '检查最新';
      FormUpdate.btn_Update.Enabled := true;
      if FormUpdate.Visible then
      FormUpdate.Btn_Cancel.SetFocus;
    end;
    //}
    finally
      IniFile.Free;
    end;
  end;
  9:
  begin
    ThreadFlag := 0;
    FreeOnTerminate:=True;
    FormUpdate.StartUpdate;
    //Sleep(10000);
    //Application.Terminate;
  end;
  end;
except end;
end;

procedure TFormUpdate.StartUpdate;
begin
try
  try
    //FormUpdate.Caption := FormUpdate.Caption + ' v' + Version + ' to v' + NewVer;
    //if not FormUpdate.Visible then FormUpdate.Show;
    //WritePrivateProfileString('RunData','DownOK','0',PChar(UpdateDir + CopyNeedIniFile));
    btn_Update.Enabled := false;
    LabelShowInfo.Caption:='开始准备升级...';
    //ShowMessage(MasterFileUrl);
    //ShowMessage(UpdateDir + RunFileName); exit;
    DeleteFile(UpdateDir + {LocalMasterFileName}MasterFileName);
    if FileExists(UpdateDir + MasterFileName) then
    begin
      LabelShowInfo.Caption := '要创建的临时文件正在使用中....';
      btn_Update.Enabled := true;
      exit;
    end;   //CopyFileDown := true;
    btn_Update.Enabled:=False;
    LabelShowInfo.Caption:='开始下载所需要文件,请等待...';
    HttpDownLoad(MasterFileUrl, UpdateDir + MasterFileName, false);
    //ShowMessage('ok.');
    //{
    if CopyFileDown then        
    begin
      if Trim(LocalCopyFile) = '' then LocalCopyFile := LocalCopyFileConst;
      LabelShowInfo.Caption:='主程序已经下载完毕,开始下载所需的拷贝文件...';
      //PB_Cur.Max := PB_Cur.Max div 10000;
      DeleteFile(UpdateDir + LocalCopyFile);
      HttpDownLoad(UpdateCopyFileUrl, UpdateDir + LocalCopyFile, false);
    end;
    //}       
    //ShowMessage('ok.');
    LabelShowInfo.Caption:='所需要的更新文件已经下载完毕...';
    if AbortTransfer then exit;
    WritePrivateProfileString('RunData','MasterDir',PChar(ExtractFilePath(ParamStr(0))),PChar(UpdateDir + CopyNeedIniFile));
    WritePrivateProfileString('RunData','RunFile',PChar(MasterFileName),PChar(UpdateDir + CopyNeedIniFile));
    WritePrivateProfileString('RunData','RunFile2',PChar(ExtractFileName(ParamStr(0))),PChar(UpdateDir + CopyNeedIniFile));
    if AbortTransfer then exit;
    Btn_Cancel.Caption := '开始运行';
    FormUpdate.btn_Update.Enabled := false;
    if {(BCheck.Caption = '1'} not FormUpdate.Visible then
    begin
      if FileExists(UpdateDir + MasterFileName) and (not AbortTransfer) then
      //if MessageBox(FormMain.Handle,PChar('目前版本:<' + Version + '> 最新版本:<' + NewVer + '>' + #10 + #13 + '浏览器的更新文件已经下载完毕,是否更新到最新版本？'),TitleStr + ' 询问:',MB_YESNO+MB_ICONINFORMATION)=ID_YES then
      MessageBox(FormMain.Handle,PChar('目前版本:<' + Version + '> 最新版本:<' + NewVer + '>' + #10 + #13 + '浏览器的更新文件已经下载完毕,点击确定更新到最新版本!'),TitleStr + ' 询问:', 0);
      begin
        AppCloseHint := false;
        FormUpdate.Hide;
        WinExec(PChar(UpdateDir + LocalCopyFile), SW_Hide);
        FormUpdate.Close;
        //Halt;
        FormMain.Close;
      end;
      {
      else
      begin
        LabelShowInfo.Caption := '准备升级...';
        WritePrivateProfileString('RunData','NewVerInt',PChar(NewVerInt),PChar(UpdateDir + CopyNeedIniFile));
        WritePrivateProfileString('RunData','MD5FILE',MD5File(PChar(UpdateDir + MasterFileName)),PChar(UpdateDir + CopyNeedIniFile));
        FormUpdate.Hide;
        FormUpdate.Close;
      end;}
    end
    else FormUpdate.TimerStartRun.Enabled := true;
    //WritePrivateProfileString('RunData','DownOK','1',PChar(UpdateDir + CopyNeedIniFile));
    //ShowMessage('');
    //Refresh;
  finally
    //FormMain.Close;
  end;
except end;
end;

//http方式下载
procedure TFormUpdate.HttpDownLoad(aURL, aFile: string; bResume: Boolean);
var
  tStream: TFileStream;
begin
  try  //ShowMessage(aFile);    exit;
    //aFile := '999.exe';
    //aUrl := 'http://www.aijisu.com/update/top.exe';       //haha
     //如果文件已经存在
    if FileExists(aFile) then DeleteFile(aFile);
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
  except
    {
    on E:Exception do
      begin
        if (Pos('Operation aborted',E.Message)>=0) and AbortTransfer then
          begin
            E.Message:='已被用户中断';
          end;
        Application.MessageBox(PChar('升级过程中出现了错误了,错误信息如下：'+#13+#13+E.Message),PChar('系统提示'),Mb_OK+MB_ICONERROR);
        //WriteErrLog('升级过程中出现了错误了,错误信息如下：'+E.Message);
        //Abort;
      end;
    }
  end;
end;
  
procedure TFormUpdate.IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin
  try
    if AbortTransfer then
      begin //中断下载
        LabelShowInfo.Caption := '准备升级...';
        Btn_Cancel.Enabled := true;
        Btn_Cancel.Caption := '退出升级';
        IdHTTP1.Disconnect; 
      end;
    
    PB_Cur.Position := AWorkCount;
    //Application.ProcessMessages;
  except
    //WriteErrLog('错误，出现在事件IdHTTP1Work中');
  end;
end;

procedure TFormUpdate.IdHTTP1WorkBegin(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCountMax: Integer);
begin
  try
    AbortTransfer := False;
    if AWorkCountMax > 0 then PB_Cur.Max := AWorkCountMax
    else  PB_Cur.Max := BytesToTransfer;
  except
  end;
end;

procedure TFormUpdate.IdHTTP1WorkEnd(Sender: TObject;
  AWorkMode: TWorkMode);
begin
try
  if AbortTransfer then
    begin
      Abort;
      LabelShowInfo.Caption := '准备升级...';
      //IdHTTP1.Disconnect;
      //Application.Terminate;
    end
  else
    begin
      //if aHint then Application.MessageBox(PChar('OK,程序升级成功!'),PChar('系统提示'),MB_OK+MB_ICONINFORMATION);
    end;
  PB_Cur.Position := 0;
except end;
end;

procedure TFormUpdate.btn_UpdateClick(Sender: TObject);
begin
try
  //if btn_Update.Caption = '开始升级' then
  //begin
    btn_Update.Enabled:=False;
    Btn_Cancel.Caption:='取消升级';
    ThreadFlag := 9;
    RunProcess1:=RunProcess.Create(false);
    RunProcess1.Resume;
    Sleep(1000);
  //end;
except end;
end;

procedure TFormUpdate.Btn_CancelClick(Sender: TObject);
begin
try
  try     //Abort; exit;
  if Btn_Cancel.Caption = '退出升级' then
  begin
    AbortTransfer := true;
    LabelShowInfo.Caption := '准备升级...';
    PB_Cur.Position := 0;
    FormUpdate.Close;
    exit;
  end
  else if Btn_Cancel.Caption = '取消升级' then
  begin
    AbortTransfer := true;
    LabelShowInfo.Caption := '准备升级...';
    PB_Cur.Position := 0;
    FormUpdate.Hide;
    exit;
  end
  else if Btn_Cancel.Caption = '开始运行' then
  begin
    AppCloseHint := false;
    FormUpdate.Hide;
    WinExec(PChar(UpdateDir + LocalCopyFile), SW_HIDE);
    FormMain.Close;
  end;
  finally
  //WritePrivateProfileString('RunData','DownOK','0',PChar(UpdateDir + CopyNeedIniFile));
  end;
except end;
end;

procedure TFormUpdate.FormShow(Sender: TObject);
begin
try
  //{
  if FormUpdate.LabelFlag.Caption = '1' then
  begin
    FormUpdate.btn_Update.Enabled := true;
    //if VersionInt >= StrToInt(NewVerInt) then
    Btn_Cancel.SetFocus;
    exit;
  end;
  FormUpdate.Caption := uTitle;
  ThreadFlag := 1;
  RunProcess1:=RunProcess.Create(false);
  RunProcess1.Resume;
  Sleep(1000);
  //}
except end;
end;

procedure TFormUpdate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
try
  AbortTransfer := true;
except end;
end;

procedure TFormUpdate.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
try
  AbortTransfer := true;
  IdHTTP1.Disconnect;
  //CanClose := false;
  //FormUpdate.Hide;
except end;
end;

procedure TFormUpdate.TimerStartRunTimer(Sender: TObject);
begin
try
  Btn_Cancel.Click;
except end;
end;

procedure TFormUpdate.LLUpdateUrlClick(Sender: TObject);
begin
try
  FormMain.CBURL.Text := UpdateUrl;
  FormMain.BBGO.OnClick(Sender);
except end;
end;

end.
