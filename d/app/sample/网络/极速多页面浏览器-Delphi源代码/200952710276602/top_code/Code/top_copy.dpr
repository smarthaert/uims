program top_copy;

uses
  Windows,
  Messages,
  SysUtils,
  IniFiles,
  Classes,
  TLHelp32;

const
  APPNAME = '0*****9990';
  APPTAG = 88888;
  CloseMsg = '0*MSGOFCLOSE*0';
  WM_OPENPAGE = WM_USER + 1;
  WM_FOUNDHE = WM_USER + 2;
const CopyNeedIniFile = 'Copy.ini';

type
  RunProcess = class(TThread)   //线程类
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

var
  RunProcess1: RunProcess;  //子线程

{
//获得系统目录
function GetSysDir:string;
var
  SysDir:string;
begin
try
  SetLength(SysDir,128);
  GetSystemDirectory(PChar(SysDir),128);
  SetLength(SysDir,Strlen(PChar(SysDir)));
  if SysDir[Length(SysDir)]<>'\' then SysDir:=SysDir+'\';
  Result:=SysDir;
  //////////
  GetMem(PPChar,200);
  StrpCopy(PPChar,SysDir);
  GetSysDir:=PPChar;
  FreeMem(PPChar);
  //////////
except
  Result:='';
end;
end;
}

{
//删除自己
function DeleteMe:Boolean;
var
  BatFile: TextFile;
  BatFileName:PChar;
begin
try
  BatFileName := PChar(ExtractFilePath(ParamStr(0)) + '_deleteme.bat');
  AssignFile(BatFile, BatFileName);
  Rewrite(BatFile);
  Writeln(BatFile, ':try');
  Writeln(BatFile, 'del "' + ParamStr(0) + '"');
  Writeln(BatFile,
    'if exist "' + ParamStr(0) + '"' + ' goto try');
  Writeln(BatFile, 'del %0');
  CloseFile(BatFile);
  WinExec(PChar(ExtractFilePath(ParamStr(0)) + '_deleteme.bat'),SW_HIDE);
  Result:=True;
  Halt;
except
  Result:=False;
end;
end;
}

//结束进程
function KillProcess(ProcessName:PChar):Boolean;
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

procedure PostCloseMsgo;
var
  Found: HWND;
  ds: TCopyDataStruct;
begin
try           
  Found := FindWindow('0*****0', nil);
  if (Found <> 0) and (SendMessage(Found, WM_FOUNDHE, 0, 0) = APPTAG) then
  begin
    ds.cbData := Length (CloseMsg) + 1;
    GetMem (ds.lpData, ds.cbData ); //为传递的数据区分配内存
    StrCopy (ds.lpData, PChar (CloseMsg));
    SendMessage (Found, WM_COPYDATA, 0, Cardinal(@ds));
    FreeMem (ds.lpData);
  end;
except end;
end;

procedure PostCloseMsg;
var
  Found: HWND;
  ds: TCopyDataStruct;
begin
try
  Found := FindWindow(AppName, nil);
  if (Found <> 0) and (SendMessage(Found, WM_FOUNDHE, 0, 0) = APPTAG) then
  begin
    ds.cbData := Length (CloseMsg) + 1;
    GetMem (ds.lpData, ds.cbData ); //为传递的数据区分配内存
    StrCopy (ds.lpData, PChar (CloseMsg));
    SendMessage (Found, WM_COPYDATA, 0, Cardinal(@ds));
    FreeMem (ds.lpData);
  end;
except end;
end;

procedure Work999;
var
  MyDir: String;
  I: Integer;
  Same: Boolean;
  IniFile: TIniFile;
  IniFileFullName: String;
  MasterDir, RunFile, RunFile2: String;
  TargetFileFullName, TargetFileFullName2: String;
begin
try
  try
  MyDir := ExtractFilePath(ParamStr(0));
  if MyDir[Length(MyDir)] <> '\' then MyDir := MyDir + '\';
  IniFileFullName := MyDir + CopyNeedIniFile;
  //MessageBox(0, PChar(IniFileFullName), '', 0);  exit;
  //WritePrivateProfileString('RunData','at','1',PChar(IniFileFullName));
  if not FileExists(IniFileFullName) then exit;    
  //WritePrivateProfileString('RunData','at','2',PChar(IniFileFullName));
  IniFile := TIniFile.Create(IniFileFullName);
  MasterDir := IniFile.ReadString('RunData','MasterDir','');
  RunFile := IniFile.ReadString('RunData','RunFile',IniFileFullName);
  RunFile2 := IniFile.ReadString('RunData','RunFile2',IniFileFullName);
  //WritePrivateProfileString('RunData','at','3',PChar(IniFileFullName));
  if MasterDir = '' then exit;
  PostCloseMsgo;
  PostCloseMsg;
  Sleep(1500);
  if MasterDir[Length(MasterDir)] <> '\' then MasterDir := MasterDir + '\';
  //MessageBox(0, PChar(MasterDir), '', 0);
  //WritePrivateProfileString('RunData','at','4',PChar(IniFileFullName));
  if not DirectoryExists(MasterDir) then MkDir(MasterDir);
  TargetFileFullName := MasterDir + RunFile;
  //MessageBox(0, PChar(RunFile), PChar(RunFile2 + '.2.'), 0);
  if LowerCase(RunFile) = LowerCase(RunFile2) then Same := true
  else
  TargetFileFullName2 := MasterDir + RunFile2;
  //WritePrivateProfileString('RunData','at','5',PChar(IniFileFullName));
  Sleep(1000);  //add
  if FileExists(TargetFileFullName) then DeleteFile(TargetFileFullName);
  I := 0;
  //if FileExists(TargetFileFullName) then
  //begin
    PostCloseMsg;
    Sleep(1500);
  //end;
  //MessageBox(0, PChar(TargetFileFullName), '', 0); exit;
  if not Same then DeleteFile(TargetFileFullName2);
  //WritePrivateProfileString('RunData','at','6',PChar(IniFileFullName));
  if (FileExists(TargetFileFullName)) {or (FileExists(TargetFileFullName2))} then
  begin
    PostCloseMsg;
    Sleep(1500);
    KillProcess(PChar(RunFile));
    DeleteFile(TargetFileFullName);
  end;
  if not Same then
  if (FileExists(TargetFileFullName2)) {or (FileExists(TargetFileFullName2))} then
  begin
    PostCloseMsg;
    Sleep(1500);
    KillProcess(PChar(ExtractFileName(TargetFileFullName2)));
    DeleteFile(TargetFileFullName2);
  end;
  if (FileExists(TargetFileFullName)) then
  begin
    PostCloseMsg;
    Sleep(1500);
    KillProcess(PChar(RunFile));
    DeleteFile(TargetFileFullName);
  end;
  //WritePrivateProfileString('RunData','at','7',PChar(IniFileFullName));
  KillProcess(PChar(TargetFileFullName));
  if not Same then KillProcess(PChar(ExtractFileName(TargetFileFullName2))); //KillProcess(PChar(TargetFileFullName2));
  KillProcess(PChar(RunFile));
  {
  KillProcess(PChar(RunFile));
  while I < 221 do
  begin
    Inc(I);
    //KillProcess(PChar(RunFile));
    DeleteFile(TargetFileFullName);
  end;
  }
  //WritePrivateProfileString('RunData','at','8',PChar(IniFileFullName));
  CopyFile(PChar(MyDir + RunFile), PChar(TargetFileFullName), False);
  if not Same then
  CopyFile(PChar(MyDir + RunFile), PChar(TargetFileFullName2), False);
  //if Same then
  //MessageBox(0,PChar(TargetFileFullName2),'',0); exit;
  if Same then
  WinExec(PChar(TargetFileFullName), SW_SHOW) else
  WinExec(PChar(TargetFileFullName2), SW_SHOW);
  WritePrivateProfileString('RunData','at','9',PChar(IniFileFullName));
  finally
  //DeleteFile(MyDir + RunFile);
  DeleteFile(MyDir + 'update.txt');
  if not FileExists(MyDir + 'txt.txt') then
  begin
    //DeleteMe;
    //WinExeC(PChar(ExtractFilePath(ParamStr(0)) + '_deleteme.bat'), SW_HIDE);
  end;
  Halt;
  end;
except end;
end;

procedure RunProcess.Execute;   //线程
begin
try
  FreeOnTerminate := True;
  Work999;
except end;
end;

begin
try
  RunProcess1:=RunProcess.Create(false);
  RunProcess1.Resume;
  Sleep(11000);
except end;
end.


