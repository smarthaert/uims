unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,wininet, ExtCtrls, Tlhelp32, IniFiles,ShellAPI, RzTray;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Timer1: TTimer;
    frequency: TLabel;
    Edit2: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    Edit3: TEdit;
    cbxWatch: TCheckBox;
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbxWatchClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  sLogFileName: string;

implementation

{$R *.dfm}
function CheckUrl(url: string): Boolean; 
var
  hSession, hfile, hRequest: hInternet;
  dwindex, dwcodelen: dword;
  dwcode: array[1..20] of Char;
  res: PChar;
begin
  Result := false;
  if Pos('http://', LowerCase(url)) = 0 then  url := 'http://' + url;
  hSession := InternetOpen('InetURL:/1.0', INTERNET_OPEN_TYPE_PRECONFIG,
    nil, nil, 0);
  if Assigned(hsession) then
  begin
    hfile := InternetOpenUrl(hsession, PChar(url), nil, 0, INTERNET_FLAG_RELOAD, 0);
    dwIndex := 0;
    dwCodeLen := 10;
    HttpQueryInfo(hfile, HTTP_QUERY_STATUS_CODE, @dwcode, dwcodeLen, dwIndex);
    res := PChar(@dwcode);
    Result := (res = '200') or (res = '302'); //200,302未重定位标志
    if Assigned(hfile) then
      InternetCloseHandle(hfile);
     InternetCloseHandle(hsession);
  end;
end;

function KillTask(ExeFileName:string):Integer;
const   
  PROCESS_TERMINATE=$0001;   
var
  ContinueLoop:BOOL;
  FSnapshotHandle:THandle;
  FProcessEntry32:TProcessEntry32;
begin   
  Result:= 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle,FProcessEntry32);
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
    UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
    UpperCase(ExeFileName))) then
    Result := Integer(TerminateProcess( OpenProcess(PROCESS_TERMINATE,BOOL(0),FProcessEntry32.th32ProcessID),0));
    ContinueLoop := Process32Next(FSnapshotHandle,   FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);   
end;

function CheckTask(ExeFileName: string): Boolean; 
const 
  PROCESS_TERMINATE=$0001;
var 
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  result := False;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle,FProcessEntry32);
  while integer(ContinueLoop) <> 0 do begin
        if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =UpperCase(ExeFileName))
        or (UpperCase(FProcessEntry32.szExeFile) =UpperCase(ExeFileName))) then
          result := True;
        ContinueLoop := Process32Next(FSnapshotHandle,FProcessEntry32);
  end;
end; 



function GetModulePath(const Module: HMODULE): string;
var
  L: Integer;
begin
  L := MAX_PATH + 1;
  SetLength(Result, L);
  L := Windows.GetModuleFileName(Module, Pointer(Result), L);
  SetLength(Result, L);
end;

procedure LogToFile(const FileName: string; Msg: string);
var
  T: Text;
begin
  Msg := FormatDateTime('yyyy-MM-dd hh:nn:ss', Now) + ' | ' + Msg;

  Assign(T, FileName);
  if not FileExists(FileName) then
    Rewrite(T)
  else
    Append(T);
  try
    WriteLn(T, Msg);
  finally
    Close(T);
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if not CheckUrl(Edit1.Text) then
  begin
    LogToFile(sLogFileName, '检测失败，重新执行批处理中。。。');
    try
      KillTask('cmd.exe');
      Sleep(2000);
      KillTask('Python.exe');
      Sleep(2000);
      ShellExecute(0,'Open',PChar(Edit3.text),nil,PChar(ExtractFilePath(Application.ExeName)),SW_MINIMIZE);
      LogToFile(sLogFileName, '重新执行完成[执行成功]！');
    except
       LogToFile(sLogFileName, '重新执行未完成[执行错误]！');
       Exit;
    end;
  end;
//  if CheckUrl(edit1.Text) then
//  begin
//    //检测成功
//  end
//  else
//  begin
//    try
//      LogToFile(sLogFileName, '检测不成功，重新执行批处理！');
//      KillTask('cmd.exe');
//      KillTask('Python.exe');
//      ShellExecute(0,'Open',PChar(Edit3.text),nil,PChar(ExtractFilePath(Application.ExeName)),SW_MINIMIZE);
//    except
//    end;
//  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  sIniFile: string;
  Ini: TIniFile;
begin
  sIniFile := ChangeFileExt(GetModulePath(HInstance), '.ini');
  Ini := TIniFile.Create(sIniFile);
  try
    Ini.WriteString('UrlWatch', 'Url',Edit1.Text);
    Ini.WriteString('UrlWatch', 'frequency',Edit2.Text);
    Ini.WriteString('UrlWatch', 'FilePath',Edit3.Text);
    MessageDlg('保存成功', mtInformation, [mbOK], 0);
  finally
    Ini.Free;
  end;
  if Trim(edit2.Text) = '' then
  raise Exception.Create('请先填写频率!');
  Timer1.Interval:=StrToInt(Edit2.Text)*60*1000;
  Timer1.Enabled := cbxWatch.Checked;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Ini: TIniFile;
  sIniFile: string;
begin
  sIniFile := ChangeFileExt(GetModulePath(HInstance), '.ini');
  Ini := TIniFile.Create(sIniFile);
  try
    edit1.Text:=Ini.ReadString('UrlWatch','Url','');
    edit2.Text:=Ini.ReadString('UrlWatch','frequency','');
    edit3.Text:=Ini.ReadString('UrlWatch','FilePath','');
    cbxWatch.Checked:=Ini.ReadBool('UrlWatch','Active',True);
  finally
    Ini.Free;
  end;
end;

procedure TForm1.cbxWatchClick(Sender: TObject);
var
  sIniFile: string;
  Ini: TIniFile;
begin
  Timer1.Interval:=StrToInt(Edit2.Text)*60*1000;
  Timer1.Enabled := cbxWatch.Checked;
  sIniFile := ChangeFileExt(GetModulePath(HInstance), '.ini');
  Ini := TIniFile.Create(sIniFile);
  try
    Ini.WriteBool('UrlWatch', 'Active', cbxWatch.Checked);
  finally
    Ini.Free;
  end;
end;

initialization
  sLogFileName := IncludeTrailingPathDelimiter(ExtractFilePath(GetModulePath(HInstance))) + 'log.txt';
finalization
end.
