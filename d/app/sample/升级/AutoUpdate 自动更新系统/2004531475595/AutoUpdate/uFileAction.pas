unit uFileAction;

interface
uses
  Windows, SysUtils;

type
  TFileAction = class(TObject)
  private
    FFileName: string;
    function GetFileExit: Boolean;
  public
    function GetBuildInfo(var V1, V2, V3, V4: Word): Boolean;
    constructor Create(FileName: String);
    function GetFileVersionAsText: string;
    property FileName: string read FFileName write FFileName;
    property FileExit: Boolean read GetFileExit;
    Function GetFileSize: LongInt;
    Function GetFileDate: TDatetime;
    Function Execute(Visibility: integer):Cardinal;
  end;

implementation

function TFileAction.GetBuildInfo(var V1, V2, V3, V4: Word):
    Boolean;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
begin
  Result := true;
  VerInfoSize := GetFileVersionInfoSize(PChar(FFileName), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(Pchar(FFileName), 0, VerInfoSize, VerInfo);
  try
    try
      VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
      with VerValue^ do
      begin
        V1 := dwFileVersionMS shr 16;

        V2 := dwFileVersionMS and $FFFF;
        V3 := dwFileVersionLS shr 16;
        V4 := dwFileVersionLS and $FFFF;
      end;
    except
      Result := false;
    end;
  finally
    FreeMem(VerInfo, VerInfoSize);
  end;
end;

constructor TFileAction.Create(FileName: String);
begin
  // TODO -cMM: TFileAction.Create default body inserted
  inherited Create;
  FFileName := FileName;
end;

function TFileAction.GetFileExit: Boolean;
begin
  // TODO -cMM: TFileAction.GetFileExit default body inserted
  Result := FileExists(FFileName);
end;

function TFileAction.GetFileVersionAsText: string;
var
  V1, V2, V3, V4: Word;
begin
  // TODO -cMM: TFileAction.GetFileVersionAsText default body inserted
  if (not FileExit) then
    raise Exception.Create('制定文件未找到');
  GetBuildInfo(V1, V2, V3, V4);
  Result := IntToStr(V1) + '.' + IntToStr(V2) + '.' + IntToStr(V3) + '.' + IntToStr(V4);
end;

function TFileAction.GetFileSize: LongInt;
var
  SearchRec: TSearchRec;
begin
  try
    if FindFirst(ExpandFileName(FileName), faAnyFile, SearchRec) = 0 then
      Result := SearchRec.Size
    else Result := -1;
  finally
    SysUtils.FindClose(SearchRec);
  end;
end;

function TFileAction.GetFileDate: TDatetime;
var
  SearchRec: TSearchRec;
begin
  try
    if FindFirst(ExpandFileName(FileName), faAnyFile, SearchRec) = 0 then
      Result := FileDateToDateTime(SearchRec.Time)
    else
      Result := -1;
  finally
    SysUtils.FindClose(SearchRec);
  end;
end;

function TFileAction.Execute(Visibility: integer): Cardinal;
var
  zAppName: array[0..1024] of char;
  zCurDir: array[0..1024] of char;
  WorkDir: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  StrPCopy(zAppName, FileName);
  GetDir(0, WorkDir);
  StrPCopy(zCurDir, WorkDir);
  FillChar(StartupInfo, Sizeof(StartupInfo), #0);
  StartupInfo.cb := Sizeof(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := Visibility;
  if not CreateProcess(nil,
    zAppName,               { pointer to command line string }
    nil,                    { pointer to process security attributes }
    nil,                    { pointer to thread security attributes }
    true,                   { handle inheritance flag }
    CREATE_NEW_CONSOLE or   { creation flags }
    NORMAL_PRIORITY_CLASS,
    nil,                    { pointer to new environment block }
    nil,                    { pointer to current directory name, PChar}
    StartupInfo,            { pointer to STARTUPINFO }
    ProcessInfo)            { pointer to PROCESS_INF }
    then Result := INFINITE {-1} else
  begin
    WaitforSingleObject(ProcessInfo.hProcess, INFINITE);
    GetExitCodeProcess(ProcessInfo.hProcess, Result);
    CloseHandle(ProcessInfo.hProcess);  { to prevent memory leaks }
    CloseHandle(ProcessInfo.hThread);
  end;
end;

end.
