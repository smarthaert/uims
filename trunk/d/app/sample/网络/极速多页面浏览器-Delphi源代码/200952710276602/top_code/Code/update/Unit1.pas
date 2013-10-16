unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Httpget,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls,
  TLHelp32,
  ShellApi;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    pb: TProgressBar;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Timer1: TTimer;
    Label_status: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    hg:thttpget;
  public
     procedure onp(Sender: TObject; TotalSize, Readed: Integer);
     procedure ond(Sender: TObject; FileName: string; FileSize:
    Integer);
  end;

const
  UpdateDirName = 'Update';
  UpdateConFile = 'update.txt';
  HomePage = 'http://www.aisoho.com/';
  UpdateFullFile = 'http://www.aisoho.com/update/top.exe';

var
  Form1: TForm1;
  MyDir: String;
  UpdateDir: String;
  ShowOk: Boolean;
  NewVer: String;
  CurrentVer: string;
  AutoUpdateI: word;
  NeedRun: Boolean;

implementation

{$R *.dfm}

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

procedure TForm1.Button1Click(Sender: TObject);
begin
  if (Trim(edit1.Text) = '') or (Trim(edit2.Text) = '') then exit;
  Button1.Enabled := false;
  if FileExists(edit2.Text) then
  begin
    DeleteFile(edit2.Text);
    KillProcess(PChar(ExtractFileName(edit2.Text)));
  end;
  if FileExists(edit2.Text) then
  begin
    KillProcess(PChar(ExtractFileName(edit2.Text)));
    Sleep(50);
    DeleteFile(edit2.Text);
  end;
  hg:=thttpget.Create(self);
  hg.BinaryData:=true;
  hg.UseCache:=false;
  hg.FileName:=edit2.Text;
  hg.URL:=edit1.Text;
  hg.OnProgress:=onp;
  hg.OnDoneFile:=ond;       
  hg.GetFile;
end;

procedure TForm1.ond(Sender: TObject; FileName: string; FileSize: Integer);
begin
  pb.Position:=0;
  //showmessage('下载完了');
  //MessageBox(Form1.Handle, '升级完成!', '提示信息:', 0);
  Label_status.Caption := '升级已经完成!...';
  if NeedRun then WinExec(PChar(Trim(Edit2.Text)), SW_SHOW);   
  Close;
end;

procedure TForm1.onp(Sender: TObject; TotalSize, Readed: Integer);
begin
  pb.Max:=totalsize;
  pb.Position:=readed;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  hg.Abort;
  Button1.Enabled := true;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  hg.getfile;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Buffer, Buffer2, Buffer3, Buffer4: array[0..2047] of char;
begin
try
  MyDir := ExtractFilePath(ParamStr(0));
  if MyDir[Length(MyDir)] <> '\' then MyDir := MyDir + '\';
  //{
  UpdateDir := MyDir + UpdateDirName;
  if UpdateDir[Length(UpdateDir)] <> '\' then UpdateDir := UpdateDir + '\';
  if not DirectoryExists(UpdateDir) then MkDir(UpdateDir);
  
  GetPrivateProfileString('RunData',PChar('NewVer'),nil,Buffer,SizeOf(Buffer),PChar(UpdateDir + UpdateConFile));
  GetPrivateProfileString('RunData',PChar('CurrentVer'),nil,Buffer2,SizeOf(Buffer2),PChar(UpdateDir + UpdateConFile));
  GetPrivateProfileString('RunData',PChar('AutoUpdate'),nil,Buffer3,SizeOf(Buffer3),PChar(UpdateDir + UpdateConFile));
  GetPrivateProfileString('RunData',PChar('NeedRun'),nil,Buffer4,SizeOf(Buffer4),PChar(UpdateDir + UpdateConFile));
  NewVer := String(Buffer);
  CurrentVer := String(Buffer2);
  AutoUpdateI := StrToIntDef(String(Buffer3), 0);
  if String(Buffer4) = '1' then NeedRun := true;

  Caption := Caption + '  ' + '由 ' + CurrentVer + ' 升级到 ' + NewVer;

  //ShowMessage(IntToStr(AutoUpdateI));
  //}
except end;
end;

procedure TForm1.FormShow(Sender: TObject);
var
  str: string;
  i: integer;
begin
try
  if ShowOk then exit;
  ShowOk := true;
  Edit1.Text := UpdateFullFile;
  Str := ExtractFileName(ParamStr(0));
  i := Pos('_', Str);
  if i <> 0 then        
  Edit2.Text := MyDir + '' + Copy(Str, 1, i - 1) + '.exe';
  if Trim(Edit2.Text) = '' then Edit2.Text := MyDir + 'top.exe';
  Timer1.Enabled := true;
  if not NeedRun then Label_status.Caption := '升级完成后,将自动退出...';
except end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
try
  Timer1.Enabled := false;   
  if AutoUpdateI = 1 then
  Button1.OnClick(Sender);
except end;
end;

end.
