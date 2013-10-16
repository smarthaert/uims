unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, Menus, SysTray, ExtCtrls, StdCtrls, TFlatCheckBoxUnit,
  TFlatTabControlUnit, TFlatEditUnit, TFlatSpeedButtonUnit, TFlatButtonUnit,
  FileCtrl,shellapi, jpeg,comobj,registry, CheckLst,tool, ComCtrls,shlobj,
  TFlatProgressBarUnit, TFlatGaugeUnit, XPMenu,typeunit,TLHelp32,
  TFlatCheckListBoxUnit, BlindGuardian;
  const
   PROCESS_TERMINATE=$0001;
   type
  TRegDataType=(rdtString,rdtDword,rdtBin);  //定义注册表的数据类型
 type
  TRegInfo=packed record               //定义使用的注册表数据结构
    Key:string;                 //主键
    Name:string;                //键名
    Value:string;               //保存字符串类型的数据值
    RootKey:Hkey;               //根键
    DataType:TRegDataType;      //数据类型
    DataSize:integer;           //数据大小，仅对rdtBin类型起作用
    Modify:boolean;             //是否修改的标志
  end;


type
  TForm1 = class(TForm)
    Timer1: TTimer;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Timer2: TTimer;
    Timer3: TTimer;
    SysTray1: TSysTray;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    PopupMenu2: TPopupMenu;
    N10: TMenuItem;
    ImageList1: TImageList;
    FlatButton4: TFlatButton;
    closeme: TFlatButton;
    uninstallme: TFlatButton;
    Notebook1: TNotebook;
    GroupBox1: TGroupBox;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    FlatSpeedButton1: TFlatSpeedButton;
    Label4: TLabel;
    Image1: TImage;
    filterkeys: TListBox;
    newurl: TFlatEdit;
    baddkey: TFlatButton;
    bdelkey: TFlatButton;
    bsavetofile: TFlatButton;
    bloadfromfile: TFlatButton;
    savechange: TFlatButton;
    FlatTabControl1: TFlatTabControl;
    FileListBox1: TFileListBox;
    DirectoryListBox1: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    showall: TMemo;
    ListBox1: TListBox;
    moresetup: TFlatSpeedButton;
    Label5: TLabel;
    oldpass: TFlatEdit;
    Label6: TLabel;
    newpass: TFlatEdit;
    Label7: TLabel;
    truepass: TFlatEdit;
    FlatButton2: TFlatButton;
    FlatButton3: TFlatButton;
    Bevel2: TBevel;
    Label16: TLabel;
    aboutcl: TFlatButton;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    Image2: TImage;
    cleartemp: TFlatButton;
    C1c: TFlatCheckBox;
    clearhis: TFlatButton;
    c2c: TFlatCheckBox;
    cleardoc: TFlatButton;
    c3c: TFlatCheckBox;
    c4c: TFlatCheckBox;
    clearfav: TFlatButton;
    clearadd: TFlatButton;
    c5c: TFlatCheckBox;
    wincheck: TFlatCheckBox;
    FlatButton1: TFlatButton;
    upclearall: TFlatCheckBox;
    LimitRunGB: TGroupBox;
    Label27: TLabel;
    Label28: TLabel;
    RestRunLB: TListBox;
    RestRunPopMNU: TPopupMenu;
    S1: TMenuItem;
    P1: TMenuItem;
    MenuItem1: TMenuItem;
    D2: TMenuItem;
    A2: TMenuItem;
    RestRunCB: TFlatCheckBox;
    AddRestRunEdt: TFlatEdit;
    Bevel3: TBevel;
    BrowserRestRunBtn: TFlatSpeedButton;
    LimitGB: TGroupBox;
    LimitClb: TCheckListBox;
    OpenDlg: TOpenDialog;
    allsetup: TFlatSpeedButton;
    ProgressBar: TProgressBar;
    downtime: TTimer;
    ListBox2: TListBox;
    XPMenu1: TXPMenu;
    moreiesetup: TFlatSpeedButton;
    ieconfigtab: TFlatTabControl;
    ieNotebook: TNotebook;
    Label8: TLabel;
    AutoRunLV: TListView;
    Memo1: TMemo;
    FlatSpeedButton2: TFlatSpeedButton;
    Label9: TLabel;
    lsvProcess: TListView;
    lsiSmallIcon: TImageList;
    refbutton: TFlatSpeedButton;
    PopupMenu3: TPopupMenu;
    N17: TMenuItem;
    Label10: TLabel;
    FlatSpeedButton3: TFlatSpeedButton;
    IEcheck: TFlatCheckListBox;
    FlatSpeedButton4: TFlatSpeedButton;
    FlatSpeedButton5: TFlatSpeedButton;
    BlindGuardian1: TBlindGuardian;
    procedure Timer1Timer(Sender: TObject);
    procedure baddkeyClick(Sender: TObject);
    procedure bdelkeyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bsavetofileClick(Sender: TObject);
    procedure bloadfromfileClick(Sender: TObject);
    procedure FlatSpeedButton1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure FileListBox1DblClick(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure AppMinimize(Sender: TObject);
    procedure ShowMainWindow;
    procedure N4Click(Sender: TObject);
    procedure FlatButton4Click(Sender: TObject);
    procedure filterkeysKeyPress(Sender: TObject; var Key: Char);
    procedure SysTray1IconDoubleClick(Sender: TObject;
      Button: TMouseButton; X, Y: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure clearhisClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure uninstallmeClick(Sender: TObject);
    procedure newurlChange(Sender: TObject);
    procedure savechangeClick(Sender: TObject);
    procedure wincheckClick(Sender: TObject);
    procedure upclearallClick(Sender: TObject);
    procedure filterkeysMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure oldpassKeyPress(Sender: TObject; var Key: Char);
    procedure newpassKeyPress(Sender: TObject; var Key: Char);
    procedure truepassKeyPress(Sender: TObject; var Key: Char);
    procedure FlatButton3Click(Sender: TObject);
    procedure FlatButton2Click(Sender: TObject);
    procedure closemeClick(Sender: TObject);
    procedure cleartempClick(Sender: TObject);
    procedure cleardocClick(Sender: TObject);
    procedure clearfavClick(Sender: TObject);
    procedure clearaddClick(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure moresetupClick(Sender: TObject);
    procedure aboutclClick(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure AddRestRunEdtKeyPress(Sender: TObject; var Key: Char);
    procedure BrowserRestRunBtnClick(Sender: TObject);
    procedure RestRunCBClick(Sender: TObject);
    procedure RestRunDelete;
    procedure RestRunLBKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure S1Click(Sender: TObject);
    procedure P1Click(Sender: TObject);
    procedure D2Click(Sender: TObject);
    procedure A2Click(Sender: TObject);
    procedure allsetupClick(Sender: TObject);
    procedure LimitClbClickCheck(Sender: TObject);
    procedure LimitClbClick(Sender: TObject);
    procedure LimitClbProc(bInit: boolean=true);
    procedure downtimeTimer(Sender: TObject);
    procedure C1cClick(Sender: TObject);
    procedure moreiesetupClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure AutoRunClbProc(bInit:boolean=true);
    procedure N16Click(Sender: TObject);
    procedure ieconfigtabMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure refbuttonClick(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure FlatSpeedButton4Click(Sender: TObject);
    procedure FlatSpeedButton5Click(Sender: TObject);
    procedure FlatSpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
    FSnapshotHandle:THandle;
    FProcessEntry32:TProcessEntry32;
    PROCEDURE winisclose(var mess:tmessage);message WM_QUERYENDSESSION;
    procedure LimitRunGBProc(bInit: boolean=true);

  //  PROCEDURE winisres(var mess:tmessage);message WM_ENDSESSION;
  public
    { Public declarations }
  end;


var
  Form1: TForm1;
  sKey:String;{全局变量}
  temp,sss,allinone,sel:integer;
  fAtom : TAtom;
  LimitRunRegInfo:treginfo;
  quit:boolean=false;
  LimitReginfo:array[0..3] of treginfo;
  const programpath='\Software\dhsoft\config';
  const K = '\Software\Microsoft\Windows\CurrentVersion\Run';
  const s_ExplorerKey='Software\Microsoft\Windows\CurrentVersion\Policies\Explorer';
  const s_SystemKey='Software\Microsoft\Windows\CurrentVersion\Policies\system';

implementation

uses des,Unit2, Unit3;

{$R *.DFM}


const
	ID_BIT	=	$200000;			// EFLAGS ID bit
type
	TCPUID	= array[1..4] of Longint;
	TVendor	= array [0..11] of char;

function IsCPUID_Available : Boolean; register;
asm
	PUSHFD							{direct access to flags no possible, only via stack}
  POP     EAX					{flags to EAX}
  MOV     EDX,EAX			{save current flags}
  XOR     EAX,ID_BIT	{not ID bit}
  PUSH    EAX					{onto stack}
  POPFD								{from stack to flags, with not ID bit}
  PUSHFD							{back to stack}
  POP     EAX					{get back to EAX}
  XOR     EAX,EDX			{check if ID bit affected}
  JZ      @exit				{no, CPUID not availavle}
  MOV     AL,True			{Result=True}
@exit:
end;

function GetCPUID : TCPUID; assembler; register;
asm
  PUSH    EBX         {Save affected register}
  PUSH    EDI
  MOV     EDI,EAX     {@Resukt}
  MOV     EAX,1
  DW      $A20F       {CPUID Command}
  STOSD			          {CPUID[1]}
  MOV     EAX,EBX
  STOSD               {CPUID[2]}
  MOV     EAX,ECX
  STOSD               {CPUID[3]}
  MOV     EAX,EDX
  STOSD               {CPUID[4]}
  POP     EDI					{Restore registers}
  POP     EBX
end;

function GetCPUVendor : TVendor; assembler; register;
asm
  PUSH    EBX					{Save affected register}
  PUSH    EDI
  MOV     EDI,EAX			{@Result (TVendor)}
  MOV     EAX,0
  DW      $A20F				{CPUID Command}
  MOV     EAX,EBX
  XCHG		EBX,ECX     {save ECX result}
  MOV			ECX,4
@1:
  STOSB
  SHR     EAX,8
  LOOP    @1
  MOV     EAX,EDX
  MOV			ECX,4
@2:
  STOSB
  SHR     EAX,8
  LOOP    @2
  MOV     EAX,EBX
  MOV			ECX,4
@3:
  STOSB
  SHR     EAX,8
  LOOP    @3
  POP     EDI					{Restore registers}
  POP     EBX
end;

type
  TSTATURL = record
    cbSize: DWORD;
    pwcsUrl: DWORD;
    pwcsTitle: DWORD;
    ftLastVisited: FILETIME;
    ftLastUpdated: FILETIME;
    ftExpires: FILETIME;
    dwFlags: DWORD;
  end;

type
  IEnumSTATURL = interface(IUnknown)
    ['{3C374A42-BAE4-11CF-BF7D-00AA006946EE}']
    function Next(celt: Integer; out elt; pceltFetched: PLongint): HRESULT; stdcall;
    function Skip(celt: Longint): HRESULT; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppenum: IEnumSTATURL): HResult; stdcall;
    function SetFilter(poszFilter: PWideChar; dwFlags: DWORD): HResult; stdcall;
  end;

type
  IUrlHistoryStg = interface(IUnknown)
    ['{3C374A41-BAE4-11CF-BF7D-00AA006946EE}']
    function AddUrl(pocsUrl: PWideChar; pocsTitle: PWideChar; dwFlags: Integer): HResult; stdcall;
    function DeleteUrl(pocsUrl: PWideChar; dwFlags: Integer): HResult; stdcall;
    function QueryUrl(pocsUrl: PWideChar; dwFlags: Integer; var lpSTATURL: TSTATURL): HResult; stdcall;
    function BindToObject(pocsUrl: PWideChar; var riid: TGUID; out ppvOut: Pointer): HResult; stdcall;
    function EnumUrls(out ppenum: IEnumSTATURL): HResult; stdcall;
  end;

type
  IUrlHistoryStg2 = interface(IUrlHistoryStg)
    ['{AFA0DC11-C313-11D0-831A-00C04FD5AE38}']
    function AddUrlAndNotify(pocsUrl: PWideChar; pocsTitle: PWideChar; dwFlags: Integer;
      fWriteHistory: Integer; var poctNotify: Pointer;
      const punkISFolder: IUnknown): HResult; stdcall;
    function ClearHistory: HResult; stdcall;
  end;


function ClearIEHistory:integer;
const
    CLSID_CUrlHistory: TGUID = '{3C374A40-BAE4-11CF-BF7D-00AA006946EE}';
var
  IEHistory:IUrlHistoryStg2;
begin
  IEHistory:=CreateComObject(CLSID_CUrlHistory) as IUrlHistoryStg2;
  IEHistory.ClearHistory;
end;

function GetWinDir1: String;
var
Buf: array[0..MAX_PATH] of char;
begin
GetWindowsDirectory(Buf, MAX_PATH);
Result := Buf;
if Result[Length(Result)]<>'\' then Result := Result + '\';
end;

procedure MyDeleteFiles(Dir, Filetype: String);
var SearchRec : TSearchRec;
begin
  FindFirst(Dir + '\' + FileType , $00000020 , SearchRec);

  if SearchRec.Name = '' then
  begin
    SysUtils.FindClose(SearchRec);
    Exit;
  end;
    DeleteFile(Pchar(Dir + '\' + SearchRec.Name));

  while FindNext(SearchRec) = 0 do
   	DeleteFile(Pchar(Dir + '\' + SearchRec.Name));

	SysUtils.FindClose(SearchRec);
end;
function DelDirectory(const Source:string): boolean;
var
  fo: TSHFILEOPSTRUCT;
begin
  FillChar(fo, SizeOf(fo), 0);
  with fo do
  begin
    Wnd := 0;
    wFunc := FO_DELETE;
    pFrom := PChar(source+#0);
    pTo := #0#0;
    fFlags := FOF_NOCONFIRMATION+FOF_SILENT;//FOF_SILENT表示不出现对话框。
  end;
  Result := (SHFileOperation(fo) = 0);
end;

//删除一个目录，包含子目录和其目录下的所有文件
procedure MyDeleteDirectory(const Directory: String);
var SearchRec : TSearchRec;
	  i : Integer;
begin
	if not DirectoryExists(Directory) then Exit;
    MyDeleteFiles(Directory, '*.*');
   i := FindFirst(Directory+'\*.*', faDirectory, SearchRec);
   if (i=0) and (SearchRec.Attr and faDirectory > 0)  and
     (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
       MyDeleteDirectory(Directory +'\'+ SearchRec.Name );

  Repeat
  	if (i=0) and (SearchRec.Attr and faDirectory > 0)  and
    	 (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
        MyDeleteDirectory(Directory +'\'+ SearchRec.Name );
         i := FindNext(SearchRec);
        Until i <> 0;
  SysUtils.FindClose(SearchRec);
 if directory<>(getwindir1+'Favorites') then
// showmessage(directory+#13+getwindir1+'Favorites');
 DelDirectory(Directory);
end;

procedure MyDeleteDirectory1(const Directory: String);
var SearchRec : TSearchRec;
	  i : Integer;
begin
	if not DirectoryExists(Directory) then Exit;
    MyDeleteFiles(Directory, '*.*');
   i := FindFirst(Directory+'\*.*', faDirectory, SearchRec);
   if (i=0) and (SearchRec.Attr and faDirectory > 0)  and
     (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
       MyDeleteDirectory(Directory +'\'+ SearchRec.Name );
  Repeat
  	if (i=0) and (SearchRec.Attr and faDirectory > 0)  and
    	 (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
        MyDeleteDirectory(Directory +'\'+ SearchRec.Name );
         i := FindNext(SearchRec);
           Until i <> 0;
  SysUtils.FindClose(SearchRec);
// if directory<>(getwindir1+'Temporary Internet Files') then
 //showmessage(directory+#13+getwindir1+'Temporary Internet Files');
// DelDirectory(Directory);
end;

function RegisterServiceProcess(dwprocessID,dwType:Integer):Integer;
    stdcall;external 'KERNEL32.DLL'; //注册使按ctrl+Alt+Del不出现在任务栏中
procedure Tform1.AppMinimize(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_HIDE);
  SysTray1.Active := true;
end;
function filter(url:pchar):boolean;
var i:integer;
s:string;
begin
  result:=false;
  s:=lowercase(strpas(url));
  with form1.filterkeys do
  for i:=0 to items.count -1 do
  if pos(items[i],s)>0 then
  begin
   result:=true;
   exit;
  end;
end;
function EnumChildProc(
  hwnd:HWND;
  IParam:LPARAM
  ):bool;stdcall;
  var buf:array[0..250] of char;
  rsize:integer;
begin
  result:=true;
  Getclassname(hwnd,buf,sizeof(buf));
  if strpas(buf)='Edit' then
   begin
     rsize:=sendmessage(hwnd,WM_GETTEXT,sizeof(buf),integer(@buf));
     if rsize>0 then
      if strpas(buf)<>form1.newurl.Text then
      if filter(buf) then
       begin
        sendmessage(hwnd,WM_SETTEXT,0,integer(form1.newurl.Text));
        postmessage(hwnd,WM_KEYDOWN,$D,$1c0001);
        postmessage(hwnd,WM_KEYUP,$d,$c01c0001);
       end;
   result:=false;
   end;
   end;
procedure TForm1.baddkeyClick(Sender: TObject);
var value:string;
    i:integer;
begin
 if inputquery('添加url关键字','请输入禁止访问的网址关键字如Sex,或ＸＸＸ等',value) then
 begin
 if value='' then exit;
  with form1.filterkeys do
  for i:=0 to items.count -1 do
  if items[i]=LOWERCASE(value) then
  begin
   showmessage('此关键字已经存在!');
   exit;
  end;
   filterkeys.items.add(lowercase(value));
   filterkeys.SetFocus;
   savechange.Enabled:=true;
   savechange.Font.style:=[fsbold];
 end;
end;

procedure TForm1.bdelkeyClick(Sender: TObject);
var i:integer;
begin
  i:=0;
  while i<=filterkeys.Items.Count-1 do
  if filterkeys.Selected[i] then
  filterkeys.Items.Delete(i)
  // if filterkeys.Itemindex=0 then
 //  begin
  //  filterkeys.Items.Delete(filterkeys.itemindex);
 //   exit;
//  end
  else
    inc(i);
    filterkeys.SetFocus;
    savechange.Enabled:=true;
    savechange.Font.style:=[fsbold];
end;

function GetWinDir: String;
var
Buf: array[0..MAX_PATH] of char;
begin
GetSystemDirectory(Buf, MAX_PATH);
Result := Buf;
if Result[Length(Result)]<>'\' then Result := Result + '\';
end;

procedure TForm1.FormCreate(Sender: TObject);
 var
  myname: string;
  CPUID : TCPUID;
  I     : Integer;
 // S			: TVendor;
  pw,pw1,pw2,id1:string;
begin

   myname := 'dwProcess.exe'; //获得文件名
  with tregistry.Create do
   try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   newurl.Text:=readstring('url');
   finally
   free;
   end;
   if newurl.Text='' then
   begin
if MessageDlg('您是第一次运行本程序，需要安装，'+#13+'安装后可以通过程序设置完全卸载本程序',mtConfirmation, [mbYes, mbNo], 0)=mrYes then
begin
if extractfilepath(application.ExeName)+'dwProcess.exe'<> GetWindir + myname then //如果文件不是在Windows\System\那么..
begin
 	for I := Low(CPUID) to High(CPUID)  do CPUID[I] := -1;
  if IsCPUID_Available then begin
	  CPUID	:= GetCPUID;
	  id1:=IntToHex(CPUID[1],8)+IntToHex(CPUID[4],8);
        pw:=copy(EncryStrHex(id1,'i'),1,6);
     //  pw1:=copy(EncryStrHex(copy(inttostr(SerialNum^),1,3),'i'),7,10);
        pw1:=copy(EncryStrHex(id1,'i'),7,6);
   //  pw2:=copy(EncryStrHex(copy(inttostr(SerialNum^),4,3),'love'),7,10);
      pw2:=copy(EncryStrHex(id1,'i'),13,4)+copy(EncryStrHex(copy(id1,3,3),'you'),1,2);
      end;
 newurl.Text:='http://www.delphi6th.com';//extractfilepath(paramstr(0))+'aa.htm';
  with  Tregistry.Create do
   try
   RootKey := HKEY_CURRENT_USER;
   OpenKey( programpath, TRUE );
   writestring('url',newurl.text);
   writestring('run','1');
   writestring('clearall','0');
   writestring('PW','');
   writestring('AK',pw+pw1+pw2);
   writestring('M4','');
   finally
   free;
   end;
   end;
    with TRegistry.Create do
try
RootKey := HKEY_LOCAL_MACHINE;
OpenKey( K, TRUE );
writestring( 'syspler',getwindir+myname);
finally
free;
end;
   copyfile(pchar(application.Exename), pchar(GetWindir + myname), False);{将自己拷贝到Windows\System\下}
   Winexec(pchar(GetWindir + myname), sw_hide);//运行Windows\System\下的新文件
   application.Terminate;//退出
  end
 else
 application.Terminate;
 end
 else
 begin
     if extractfilepath(application.ExeName)+'dwProcess.exe'<> GetWindir + myname then //如果文件不是在Windows\System\那么..
    begin
     copyfile(pchar(application.Exename), pchar(GetWindir + myname), False);{将自己拷贝到Windows\System\下}
     Winexec(pchar(GetWindir + myname), sw_hide);//运行Windows\System\下的新文件
     application.Terminate;//退出
   end;
 end;
  if GlobalFindAtom('PROGRAM_RUNNING') = 0 then
      fAtom := GlobalAddAtom('PROGRAM_RUNNING')
  else begin
      { 如果有同的程序则退出 }
       Halt;
   end;
 //  try
  RegisterServiceProcess(GetCurrentProcessID,1);
  // except
  // form1.Caption:='';
  // end;
//  SystemParametersInfo( SPI_SCREENSAVERRUNNING, 1, @temp, 0);
  form1.WindowState:=wsMinimized;
  Application.OnMinimize := AppMinimize;
  savechange.Enabled:=false;
  savechange.Font.style:=[];
  // if BlindGuardian1.Registered=false then
 //  if blindguardian1.DaysPassed >= blindguardian1.TrialPeriod then
    //  begin
     //     about:=tabout.Create(self);
     //     about.ShowModal;
     //     about.FlatSpeedButton1.Enabled:=false;
    //  end
   //   else
   //   begin
  try
  listbox1.Items.LoadFromFile(extractfilepath(application.exename)+'urtypes.dat');
  filterkeys.Items.Text:=listbox1.items.text;//DecryStr(listbox1.items.text,'delphi6th');
  except
    allinone:=0;
  end;
   with tregistry.Create do
   try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   newurl.Text:=readstring('url');
   if readstring('run')='1' then  wincheck.Checked:=true
   else
   wincheck.Checked:=false;
   if readstring('clearall')='1' then
     begin
     upclearall.Checked:=true;
     ClearIEHistory;
     MyDeleteFiles(getwindir1+'Recent','*.*');
     MyDeleteDirectory(getwindir1+'Favorites');
     MyDeleteDirectory1(getwindir1+'Temporary Internet Files');
      with TRegistry.Create do
       try
       RootKey := HKEY_CURRENT_USER;
       OpenKey( '\Software\Microsoft\Internet Explorer', TRUE );
       deletekey('TypedUrls');
       createkey('TypedUrls');
       finally
    free;
 end;
     end
     else
     upclearall.Checked:=false;
   finally
   free;
   end;
   savechange.Enabled:=false;
 //  end;
end;

procedure TForm1.bsavetofileClick(Sender: TObject);
begin
  if savedialog1.Execute then
  filterkeys.Items.SaveToFile(savedialog1.filename);
end;

procedure TForm1.bloadfromfileClick(Sender: TObject);
var
l:integer;
f:TextFile;
fn,s:string;
lines:tstrings;
begin
if opendialog1.Execute then
begin
 lines:=tstringlist.Create;
 lines.LoadFromFile(OpenDialog1.FileName);
 fn:=OpenDialog1.FileName;
  AssignFile(f,fn);
  ReSet(f);
  for l:=0 to lines.Count-1 do
    begin
     ReadLn(f,s);
     if filterkeys.items.IndexOf(lowercase(s))=-1 then
         filterkeys.items.add(lowercase(s));
     end;
      CloseFile(f);
      savechange.Enabled:=true;
      savechange.Font.style:=[fsbold];
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
 fwnd:thandle;
 buf2,buf:array[0..250] of char;
begin
  fwnd:=GetForegroundWindow;
  Getclassname(fwnd,buf,sizeof(buf));
  Getwindowtext(fwnd,buf2,sizeof(buf2));
  if (strpas(buf)='CabinetWClass') or (strpas(buf)='IEFrame') or (pos('Netscape',strpas(buf2))>0) or (pos('Opera',strpas(buf2))>0) or (pos('Tencent',strpas(buf2))>0) or (pos('浏览',strpas(buf2))>0) then
    EnumChildWindows(fwnd,@enumchildproc,0);
 end;
procedure TForm1.FlatSpeedButton1Click(Sender: TObject);
begin
 if FlatTabControl1.Height<235 then
   timer2.Enabled:=true
   else
   timer3.Enabled:=true
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  if FlatTabControl1.Height<=235 then
 FlatTabControl1.Height:=FlatTabControl1.Height+30
 else
 timer2.Enabled:=false;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
   if FlatTabControl1.Height>=0 then
   begin
 FlatTabControl1.Height:=FlatTabControl1.Height-30;
  if FlatTabControl1.Height<=0 then
   timer3.Enabled:=false
  end
   else
 timer3.Enabled:=false;
end;

procedure TForm1.FileListBox1DblClick(Sender: TObject);
begin
  newurl.Text:=filelistbox1.FileName;
  FlatSpeedButton1.Click;
end;

procedure TForm1.N9Click(Sender: TObject);
begin
  sel:=3;
     with tregistry.Create do
  try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   if readstring('PW')='' then
    begin
      allinone:=1;
      form1.close;
    end
    else
    begin
 password:=tpassword.Create(self);
 password.ShowModal;
 end;
 finally
 free;
 end;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
 timer1.Enabled:=true;
 n1.ImageIndex:=0;
 n1.Default:=true;
 n2.ImageIndex:=1;
 //n1.Checked:=true;
 //n2.Checked:=false;
 n2.Default:=false;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
 sel:=1;
 with tregistry.Create do
  try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   if readstring('PW')='' then
    begin
     form1.timer1.Enabled:=false;
   //  form1.n1.Checked:=false;
  //   form1.n2.Checked:=true;
     form1.n2.ImageIndex:=0;
     form1.n2.Default:=true;
     form1.n1.ImageIndex:=1;
     form1.n1.Default:=false;
    // application.Minimize;
    // Application.OnMinimize := form1.appMinimize;
    FlatButton4.Click;
    end
    else
    begin
 password:=tpassword.Create(self);
 password.ShowModal;
 end;
 finally
 free;
 end;
 end;

procedure Tform1.ShowMainWindow;
begin
    Application.Restore;
  //  WindowState := wsNormal;
  //  ShowWindow(Application.Handle,SW_SHOWNORMAL);
    Application.BringToFront;
end;
procedure TForm1.N4Click(Sender: TObject);
begin
  sel:=2;
   with tregistry.Create do
  try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   if readstring('PW')='' then
    begin
     form1.ShowMainWindow;
     form1.notebook1.ActivePage:='1';
     form1.SysTray1.Active:=false;
    end
    else
    begin
 password:=tpassword.Create(self);
 password.ShowModal;
 end;
 finally
 free;
 end;
end;


procedure TForm1.FlatButton4Click(Sender: TObject);
begin
 if (BlindGuardian1.Registered=false) and (blindguardian1.DaysPassed >= blindguardian1.TrialPeriod)
   then
         begin
          about:=tabout.Create(self);
          about.ShowModal;
          about.FlatSpeedButton1.Enabled:=false;
        end
      else
      begin
  application.Minimize;
  Application.OnMinimize := AppMinimize;
  closeme.Enabled:=true;
  uninstallme.Enabled:=true;
  SysTray1.Active:=true;
  n2.Enabled:=true;
  n4.Enabled:=true;
  n9.Enabled:=true;
  sss:=0;
   end;
end;

procedure TForm1.filterkeysKeyPress(Sender: TObject; var Key: Char);
 var
  I:integer;
begin
  if key in ['A'..'Z','a'..'z','0'..'9'] then
  sKey:=Skey+key;
for i:=0 to filterkeys.items.count-1 do
  if skey=filterkeys.items.Strings[i]  then
  begin
    filterkeys.itemindex:=I;
    Break;
  end;

end;

procedure TForm1.SysTray1IconDoubleClick(Sender: TObject;
  Button: TMouseButton; X, Y: Integer);
begin
  n4.Click;
end;

procedure TFORM1.Winisclose(var mess:tmessage);
BEGIN
  allinone:=1;
  close;
  inherited;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if uninstallme.Enabled=false then
 begin
   form1.WindowState:=wsMinimized;
   Application.OnMinimize := AppMinimize;
   canclose:=true;
 //  SystemParametersInfo( SPI_SCREENSAVERRUNNING, 0, @temp, 0);
   exit;
 end;
 if allinone=1 then//(Application.MessageBox('    你真的要退出吗？？','确认',MB_YESNO )=IDYES) and (allinone=1) then
 begin
   form1.WindowState:=wsMinimized;
   Application.OnMinimize := AppMinimize;
 //  SystemParametersInfo( SPI_SCREENSAVERRUNNING, 0, @temp, 0);
      with tregistry.Create do
   try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   newurl.Text:=readstring('url');
   if wincheck.Checked=true then
   begin
   with tregistry.Create do
   try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   writestring('run','1');
   finally
   free
   end;
     with TRegistry.Create do
     try
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey( K, TRUE );
      writestring( 'syspler',getwindir+'dwProcess.exe');
     finally
     free;
   end;
   end
   else
   wincheck.Checked:=false;
   if readstring('clearall')='1' then
     begin
     upclearall.Checked:=true;
     ClearIEHistory;
     MyDeleteFiles(getwindir1+'Recent','*.*');
     MyDeleteDirectory(getwindir1+'Favorites');
     MyDeleteDirectory1(getwindir1+'Temporary Internet Files');
      with TRegistry.Create do
       try
       RootKey := HKEY_CURRENT_USER;
       OpenKey( '\Software\Microsoft\Internet Explorer', TRUE );
       deletekey('TypedUrls');
       createkey('TypedUrls');
       finally
       free;
       end;
      end
     else
     upclearall.Checked:=false;
   finally
   free;
   end;
    with TRegistry.Create do
     try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   if readstring('c1c')='1' then  MyDeleteDirectory1(getwindir1+'Temporary Internet Files');
   if readstring('c2c')='1' then  ClearIEHistory;
   if readstring('c3c')='1' then  MyDeleteFiles(getwindir1+'Recent','*.*');
   if readstring('c4c')='1' then  MyDeleteDirectory(getwindir1+'Favorites');
   if readstring('c5c')='1' then
   begin
       with TRegistry.Create do
       try
       RootKey := HKEY_CURRENT_USER;
       OpenKey( '\Software\Microsoft\Internet Explorer', TRUE );
       deletekey('TypedUrls');
       createkey('TypedUrls');
       finally
       free;
       end;
      end;
      finally
      end;
   canclose:=true;
  end
  else
  begin
   canclose:=false;
  end;
end;

procedure TForm1.clearhisClick(Sender: TObject);
begin
 try
  ClearIEHistory;
  showmessage('历史记录清空完毕!');
 except
  showmessage('历史记录无法清空，请重启后再试!');
 end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
   GlobalDeleteAtom(fAtom);
end;

procedure TForm1.uninstallmeClick(Sender: TObject);
  var
F:TextFile;
begin
 if MessageDlg('真的要完全卸载本程序吗？'+#13+'卸载后则无法过滤网站!',mtWarning, [mbYes, mbNo], 0)=mrYes then
 begin
 allinone:=1;
  with TRegistry.Create do
   try
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey( K, TRUE );
    deletevalue('syspler');
   finally
   free;
 end;
   with TRegistry.Create do
   try
    RootKey := HKEY_CURRENT_USER;
    OpenKey('\SoftWare' , TRUE );
    deletekey('dhsoft');
   finally
   free;
 end;
 uninstallme.Enabled:=false;
 AssignFile(F,GetWinDir+'Delself.bat');
 Rewrite(F);
 Writeln(F, 'del '+GetWinDir+'dwProcess.exe');
 Writeln(F, 'del %0');
 CloseFile(f);
 close;
 winexec(Pchar(GetwinDir+'Delself.bat'),SW_HIDE);
 end;
end;

procedure TForm1.newurlChange(Sender: TObject);
begin
  savechange.Enabled:=true;
  savechange.Font.style:=[fsbold];
end;

procedure TForm1.savechangeClick(Sender: TObject);
begin
  if newurl.Text='' then
  begin
   showmessage('要定向的网址和HTML不可为空!');
   with tregistry.Create do
   try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   newurl.Text:=readstring('url');
   finally
   free;
   end;
  end;
  with tregistry.Create do
   try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   writestring('url',newurl.text);
   finally
   free;
   end;
  listbox1.items.text:=filterkeys.items.text;//EncryStr(filterkeys.Items.Text,'delphi6th');
  listbox1.Items.SaveToFile(extractfilepath(application.exename)+'urtypes.dat');
  savechange.Enabled:=false;
  savechange.Font.style:=[];
end;

procedure TForm1.wincheckClick(Sender: TObject);
begin
   if wincheck.Checked=true then
   begin
     with tregistry.Create do
   try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   writestring('run','1')
   finally
   free
   end;
     with TRegistry.Create do
     try
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey( K, TRUE );
      writestring( 'syspler',getwindir+'dwProcess.exe');
     finally
     free;
    end;
   end
   else
   begin
       with tregistry.Create do
   try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   writestring('run','0')
   finally
   free
   end;
       with TRegistry.Create do
   try
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey( K, TRUE );
    deletevalue('syspler');
   finally
   free;
 end;
   end;
end;

procedure TForm1.upclearallClick(Sender: TObject);
begin
    allsetup.Enabled:=true;
    if upclearall.Checked =true then
    begin
   c1c.Checked:=true;
   c2c.Checked:=true;
   c3c.Checked:=true;
   c4c.Checked:=true;
   c5c.Checked:=true;
   c1c.Enabled:=false;
   c2c.Enabled:=false;
   c3c.Enabled:=false;
   c4c.Enabled:=false;
   c5c.Enabled:=false;
   end
   else
   begin
   c1c.Checked:=false;
   c2c.Checked:=false;
   c3c.Checked:=false;
   c4c.Checked:=false;
   c5c.Checked:=false;
   c1c.Enabled:=true;
   c2c.Enabled:=true;
   c3c.Enabled:=true;
   c4c.Enabled:=true;
   c5c.Enabled:=true;
   end;
end;

procedure TForm1.filterkeysMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  try
  showall.Lines.Text:=filterkeys.Items[filterkeys.ItemIndex];;
  except
  showall.Lines.Text:='';
  end;
end;

procedure TForm1.oldpassKeyPress(Sender: TObject; var Key: Char);
var
 pp:string;
begin
   if key=#13 then
   begin
      with tregistry.Create do
   try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   pp:=readstring('PW');
   if oldpass.text=DecryStrHex(pp,'delphi6th') then
    begin
    newpass.Enabled:=true;
    truepass.Enabled:=true;
    newpass.SetFocus;
    end
   else
    begin
     showmessage('密码错误！请重新输入！');
     oldpass.Text:='';
     oldpass.SetFocus;
    end;
   finally
   free
   end;
   end;
end;

procedure TForm1.newpassKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
   truepass.SetFocus;
end;

procedure TForm1.truepassKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
   if newpass.Text=truepass.Text then
         flatbutton2.Click
        else
     begin
      showmessage('校验密码错误！');
      truepass.Text:='';
     end;
  end;
end;

procedure TForm1.FlatButton3Click(Sender: TObject);
begin
  oldpass.Text:='';
  newpass.text:='';
  newpass.Enabled:=false;
  truepass.Text:='';
  truepass.Enabled:=false;
end;

procedure TForm1.FlatButton2Click(Sender: TObject);
var pp:string;
begin
    if (newpass.Text='') and (truepass.Text='') and (oldpass.Text='') then
    exit;
     with tregistry.Create do
   try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   pp:=readstring('PW');
   if oldpass.text=DecryStrHex(pp,'delphi6th') then
    begin
    newpass.Enabled:=true;
    truepass.Enabled:=true;
    newpass.SetFocus;
    end
   else
    begin
     showmessage('密码错误！请重新输入！');
     oldpass.Text:='';
     oldpass.SetFocus;
     exit;
    end;
   finally
   free
   end;
    if (newpass.Text=truepass.Text) then
    begin
      with tregistry.Create do
       try
        rootkey:=HKEY_CURRENT_USER;
        openkey(programpath,true);
        writestring('PW',EncryStrHex(truepass.text,'delphi6th'));
        showmessage('修改密码完成！');
      finally
      free;
     end;
    end
    else
     begin
      showmessage('校验密码错误！');
      truepass.Text:='';
     end;
    flatbutton3.Click;
end;

procedure TForm1.closemeClick(Sender: TObject);
begin
 allinone:=1;
 close;
end;

procedure TForm1.cleartempClick(Sender: TObject);
begin
   try
  // MyDeleteFiles(getwindir1+'Temporary Internet Files','*.*');
   MyDeleteDirectory1(getwindir1+'Temporary Internet Files');
   showmessage('IE临时文件夹清空完毕!');
  except
   showmessage('IE临时文件夹无法清空，请重启后再试!');
  end;

end;

procedure TForm1.cleardocClick(Sender: TObject);
begin
  try
   MyDeleteFiles(getwindir1+'Recent','*.*');
   showmessage('文档清空完毕!');
  except
   showmessage('文档无法清空，请重启后再试!');
  end;

 //  if directoryexists(getwindir1+'Recent') then
 // exit
 // else
 // ForceDirectories(getwindir1+'Recent');
end;

procedure TForm1.clearfavClick(Sender: TObject);
begin
   try
   MyDeleteDirectory(getwindir1+'Favorites');
   showmessage('收藏夹网址清空完毕!');
   except
   showmessage('收藏夹网址无法清空，请重启后再试!');
  end;

end;

procedure TForm1.clearaddClick(Sender: TObject);
begin
  try
   with TRegistry.Create do
    try
    RootKey := HKEY_CURRENT_USER;
    OpenKey( '\Software\Microsoft\Internet Explorer', TRUE );
    deletekey('TypedUrls');
    createkey('TypedUrls');
     finally
      free;
     end;
    showmessage('IE地址栏网址清空完毕!,需重新打开IE后有效！');
    except
     showmessage('IE地址栏网址无法清空，请重启后再试!');
    end;
end;

procedure TForm1.N11Click(Sender: TObject);
begin
   ShellExecute(Application.Handle,nil,'http://www.delphi6th.com',nil,nil,SW_SHOWNORMAL);
end;

procedure TForm1.N7Click(Sender: TObject);
begin
  ShellExecute(Application.Handle,nil,'mailto:dhzyx@elong.com',nil,nil,SW_SHOWNORMAL);
end;

procedure TForm1.moresetupClick(Sender: TObject);
var
 i:integer;
begin
 notebook1.ActivePage:='3';
 LimitClbProc;
 LimitRunGBProc;
 if RestRunCB.Checked=false then
 begin
 try
 listbox2.Items.LoadFromFile(extractfilepath(application.exename)+'confineliem.dat');
 RestRunLB.Items.Text:=listbox2.items.text;//DecryStr(listbox2.items.text,'6th');
 except
 allinone:=0;
 end;
 end;
   with tregistry.Create do
   try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   if readstring('downla')='1' then
   begin
      LimitClb.Checked[3]:=true;
      downtime.Enabled:=true;
   end
   else
   begin
     LimitClb.Checked[3]:=false;
     downtime.Enabled:=false;
   end;
   finally
   free;
   end;
    with TRegistry.Create do
     try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   if readstring('c1c')='1' then  c1c.Checked:=true;
   if readstring('c2c')='1' then  c2c.Checked:=true;
   if readstring('c3c')='1' then  c3c.Checked:=true;
   if readstring('c4c')='1' then  c4c.Checked:=true;
   if readstring('c5c')='1' then  c5c.Checked:=true;
   finally
   end;
 for i:=0 to ControlCount-1 do Controls[i].Tag:=0;
 allsetup.Enabled:=false;
end;



procedure TForm1.aboutclClick(Sender: TObject);
//var
 { SerialNum : pdword;
  a, b : dword;
  Buffer  : array [0..255] of char; }

begin

    //if GetVolumeInformation('C:\', Buffer, SizeOf(Buffer), SerialNum, a, b, nil, 0) then
 //  begin
//showmessage(inttostr(SerialNum^));
   //  edit1.Text:=copy(EncryStrHex(inttostr(SerialNum^),'i'),1,6);
     //  pw1:=copy(EncryStrHex(copy(inttostr(SerialNum^),1,3),'i'),7,10);
   ///  edit2.Text:=copy(EncryStrHex(inttostr(SerialNum^),'i'),7,6);
   //  pw2:=copy(EncryStrHex(copy(inttostr(SerialNum^),4,3),'love'),7,10);
   //  edit3.Text:=copy(EncryStrHex(inttostr(SerialNum^),'i'),13,4)+copy(EncryStrHex(copy(inttostr(SerialNum^),3,3),'you'),1,2);
 //    fw:=edit1.Text+edit2.Text+edit3.Text;
    // pw3:=copy(EncryStrHex(copy(inttostr(SerialNum^),7,3),'you'),7,10);
//   end;

  about:=tabout.Create(self);
  about.ShowModal;
end;

procedure TForm1.FlatButton1Click(Sender: TObject);
begin
  notebook1.ActivePage:='1';
end;

procedure TForm1.AddRestRunEdtKeyPress(Sender: TObject; var Key: Char);
begin
   if key=#13 then
    if trim(AddRestRunEdt.Text)<>'' then
      if RestRunLB.Items.IndexOf(AddRestRunEdt.Text)=-1 then
        begin
          RestRunLB.Items.Add(AddRestRunEdt.Text);
          AddRestRunEdt.Text:='';
          allsetup.Enabled:=true;
        end;
end;

procedure TForm1.BrowserRestRunBtnClick(Sender: TObject);
var
  i:integer;
begin
  opendlg.Filter:='可执行文件(*.exe;*.com;*.bat;*.lnk;*.pif)|*.exe;*.com;*.bat;*.lnk;*.pif';
  opendlg.Title:='请选择程序';
  opendlg.Options:=opendlg.Options+[ofAllowMultiSelect];
  if opendlg.Execute then
  begin
    for i:=0 to opendlg.Files.Count-1 do
      if RestRunLB.Items.IndexOf(opendlg.Files.Strings[i])=-1 then
        RestRunLB.Items.Add(extractfilename(opendlg.Files.Strings[i]));
  end;
  opendlg.Options:=opendlg.Options-[ofAllowMultiSelect];
end;

procedure TForm1.RestRunCBClick(Sender: TObject);
begin
  RestRunLB.Enabled:=RestRunCB.Checked;
  RestRunCB.Tag:=$ff;
  allsetup.Enabled:=true;
  BrowserRestRunBtn.Enabled:=RestRunCB.Checked;
  AddRestRunEdt.Enabled:=RestRunCB.Checked;
end;

procedure Tform1.RestRunDelete;
var
  i:integer;
  buf:tstrings;
begin
  begin
    buf:=tstringlist.Create;
    for i:=0 to RestRunLB.Items.Count-1 do
      if not RestRunLB.Selected[i] then
        buf.Add(RestRunLB.Items.Strings[i]);
    RestRunLB.Items:=buf;
    buf.Free;
    allsetup.Enabled:=true;
  end;
end;

procedure Tform1.LimitRunGBProc(bInit: boolean=true);
var
  reg:tregistry;
  i:integer;
  buf:tstrings;
begin
  LimitRunRegInfo.Key:=s_ExplorerKey;
  LimitRunRegInfo.RootKey:=HKEY_CURRENT_USER;
  LimitRunRegInfo.Name:='RestrictRun';
  reg:=tregistry.Create;
  buf:=tstringlist.Create;
  reg.RootKey:=LimitRunReginfo.RootKey;
  if binit then
  begin
      RestRunLB.Items.Clear;
      if reg.OpenKey(LimitRunRegInfo.Key,false) then
    begin
      if reg.ValueExists(LimitRunRegInfo.Name) then
      try
        RestRunCB.Checked:=reg.ReadInteger(LimitRunRegInfo.Name)>=1;
      except
        reg.DeleteValue(LimitRunRegInfo.Name);
      end;
      RestRunCBClick(self);
      if reg.KeyExists(LimitRunRegInfo.Name) then
        if reg.OpenKey(LimitRunRegInfo.Name,false) then
        begin
          reg.GetValueNames(buf);
          for i:=0 to buf.Count-1 do
            if buf.Strings[i]<>'' then
              RestRunLB.Items.Add(reg.ReadString(buf.Strings[i]));
        end;
    end;
  end
  else   //Apply
  begin
    if reg.OpenKey(LimitRunRegInfo.Key,true) then
    begin
      reg.DeleteKey(LimitRunRegInfo.Name);
      if RestRunCB.Checked then
      begin
        reg.WriteInteger(LimitRunRegInfo.Name,1);
        if reg.OpenKey(LimitRunRegInfo.Name,true) then
        begin
          reg.WriteString('',extractfilename(paramstr(0)));
          for i:=0 to RestRunLB.Items.Count-1 do
            reg.WriteString(inttostr(i+1),RestRunLB.Items.Strings[i]);
        end;
      end
      else
        reg.DeleteValue(LimitRunRegInfo.Name);
    end;
  end;
  reg.CloseKey;
  reg.Free;
  buf.Free;
end;

procedure TForm1.RestRunLBKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key=vk_delete then
    RestRunDelete;
end;
procedure RestRunCallBack(const info:TSearchRec;var bquit,bsub:boolean);
var
  buf:string;
begin
  application.ProcessMessages;
  buf:=lowercase(extractfileext(info.Name));
  if (buf='.exe') or (buf='.bat') or (buf='.com') or (buf='.lnk') or (buf='.pif') then
  with form1 do
  begin
    if RestRunLB.Items.IndexOf(info.Name)=-1 then
      RestRunLB.Items.Add(info.Name);
    ProgressBar.Stepit;
    bquit:=quit;
  end;
end;

procedure TForm1.S1Click(Sender: TObject);
var
  buf:string;
  bquit:boolean;
begin
  bquit:=false;
  quit:=false;
  p1.Enabled:=true;
  if Tool.SelectDirectory(handle,'请选择开始搜索的目录：','',buf) then
  begin
  progressbar.Visible:=true;
  findfile(bquit,buf,'*.*',RestRunCallBack,true);
  p1.Enabled:=false;
  ProgressBar.Position:=ProgressBar.Min;
  progressbar.Visible:=false;
  allsetup.Enabled:=true;
  end;
end;

procedure TForm1.P1Click(Sender: TObject);
begin
  if MessageBox(handle,'你真的要终止搜索吗？',pchar(application.Title),MB_OKCANCEL+MB_ICONINFORMATION)=idOK then
  begin
    quit:=true;
    p1.Enabled:=false;
  end;
end;

procedure TForm1.D2Click(Sender: TObject);
begin
  RestRunDelete;
end;

procedure TForm1.A2Click(Sender: TObject);
begin
  RestRunLB.Items.Clear;
  allsetup.Enabled:=true;
end;

procedure TForm1.allsetupClick(Sender: TObject);
var
  i:integer;
begin
   allsetup.Enabled:=false;
   if restruncb.Checked=false then  showmessage('如果你在本次程序运行中打开过(启用保护U)，'+#13+'那你必须重新启动计算机后,可执行程序才能恢复运行！');
   if RestRunCB.Tag=$ff  then   LimitRunGBProc(false);
   if LimitClb.Tag=$ff then LimitClbProc(false);
   if c1c.Checked=true then
   begin
    with  Tregistry.Create do
   try
   RootKey := HKEY_CURRENT_USER;
   OpenKey( programpath, TRUE );
   writestring('c1c','1');
   finally
   free;
   end;
   end
   else
   begin
      with  Tregistry.Create do
     try
    RootKey := HKEY_CURRENT_USER;
    OpenKey( programpath, TRUE );
    writestring('c1c','0');
     finally
    free;
    end;
   end;

   if c2c.Checked=true then
   begin
    with  Tregistry.Create do
   try
   RootKey := HKEY_CURRENT_USER;
   OpenKey( programpath, TRUE );
   writestring('c2c','1');
   finally
   free;
   end;
   end
   else
   begin
      with  Tregistry.Create do
     try
    RootKey := HKEY_CURRENT_USER;
    OpenKey( programpath, TRUE );
    writestring('c2c','0');
     finally
    free;
    end;
   end;

   if c3c.Checked=true then
   begin
    with  Tregistry.Create do
   try
   RootKey := HKEY_CURRENT_USER;
   OpenKey( programpath, TRUE );
   writestring('c3c','1');
   finally
   free;
   end;
   end
   else
   begin
      with  Tregistry.Create do
     try
    RootKey := HKEY_CURRENT_USER;
    OpenKey( programpath, TRUE );
    writestring('c3c','0');
     finally
    free;
    end;
   end;


   if c4c.Checked=true then
   begin
    with  Tregistry.Create do
   try
   RootKey := HKEY_CURRENT_USER;
   OpenKey( programpath, TRUE );
   writestring('c4c','1');
   finally
   free;
   end;
   end
   else
   begin
      with  Tregistry.Create do
     try
    RootKey := HKEY_CURRENT_USER;
    OpenKey( programpath, TRUE );
    writestring('c4c','0');
     finally
    free;
    end;
   end;

   if c5c.Checked=true then
   begin
    with  Tregistry.Create do
   try
   RootKey := HKEY_CURRENT_USER;
   OpenKey( programpath, TRUE );
   writestring('c5c','1');
   finally
   free;
   end;
   end
   else
   begin
      with  Tregistry.Create do
     try
    RootKey := HKEY_CURRENT_USER;
    OpenKey( programpath, TRUE );
    writestring('c5c','0');
     finally
    free;
    end;
   end;


   if RestRunCB.Checked=true then
    begin
    with  Tregistry.Create do
   try
   RootKey := HKEY_CURRENT_USER;
   OpenKey( programpath, TRUE );
   writestring('liemit','1');
   finally
   free;
   end;
   end
   else
   begin
      with  Tregistry.Create do
     try
    RootKey := HKEY_CURRENT_USER;
    OpenKey( programpath, TRUE );
    writestring('liemit','0');
     finally
    free;
    end;
   end;
    if LimitClb.Checked[3]=true then
   begin
    with  Tregistry.Create do
   try
   RootKey := HKEY_CURRENT_USER;
   OpenKey( programpath, TRUE );
   writestring('downla','1');
   finally
   free;
   end;
   end
   else
   begin
      with  Tregistry.Create do
     try
    RootKey := HKEY_CURRENT_USER;
    OpenKey( programpath, TRUE );
    writestring('downla','0');
     finally
    free;
    end;
   end;
   if upclearall.Checked=true then
 begin
   with tregistry.Create do
   try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   writestring('clearall','1')
   finally
   free
   end;
   end
 else
 begin
  with tregistry.Create do
   try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   writestring('clearall','0')
   finally
   free
   end;
  end;
   if LimitClb.Checked[3]=true then downtime.Enabled:=true
   else
    downtime.Enabled:=false;
   for i:=0 to ControlCount-1 do Controls[i].Tag:=0;
   RefreshSystem;
  listbox2.items.text:=restrunlb.Items.Text;// EncryStr(RestRunLB.Items.Text,'6th');
  listbox2.Items.SaveToFile(extractfilepath(application.exename)+'confineliem.dat');

end;

procedure TForm1.LimitClbClickCheck(Sender: TObject);
begin
  allsetup.Enabled:=true;
  (Sender as TControl).Tag:=$ff;
end;

procedure TForm1.LimitClbClick(Sender: TObject);

begin
//   if lowercase((sender as Tchecklistbox).Name)='limitclb' then
 //   LimitClb.Hint:=LimitRegInfo[LimitClb.ItemIndex].Name+'|'+LimitRegInfo[LimitClb.ItemIndex].Key;
end;
procedure Tform1.LimitClbProc(bInit: boolean);
var
  reg:tregistry;
  i:integer;
begin
LimitReginfo[0].RootKey:=hkey_current_user;
  LimitReginfo[0].Key:='Software\Microsoft\Windows\CurrentVersion\Policies\WinOldapp';
  LimitReginfo[0].Name:='Disabled';
  LimitReginfo[0].DataType:=rdtdword;

  LimitReginfo[1].RootKey:=hkey_current_user;
  LimitReginfo[1].Key:='Software\Microsoft\Windows\CurrentVersion\Policies\WinOldapp';
  LimitReginfo[1].Name:='NoRealMode';
  LimitReginfo[1].DataType:=rdtdword;

  LimitReginfo[2].RootKey:=hkey_current_user;
  LimitReginfo[2].Key:=s_SystemKey;
  LimitReginfo[2].Name:='DisableRegistryTools';
  LimitReginfo[2].DataType:=rdtdword;

  reg:=tregistry.Create;
  if binit then
  begin
    for i:=low(LimitRegInfo) to high(LimitRegInfo) do
    begin
      reg.RootKey:=LimitRegInfo[i].RootKey;
      reg.CloseKey;
      if reg.OpenKey(LimitRegInfo[i].Key,false) then
        if reg.ValueExists(LimitRegInfo[i].Name) then
        try
          LimitClb.Checked[i]:=reg.ReadInteger(LimitRegInfo[i].Name)>=1;
        except
          reg.DeleteValue(LimitRegInfo[i].Name);
        end;
    end;
  end
  else
  begin
    for i:=low(LimitRegInfo) to high(LimitRegInfo) do
    begin
      reg.RootKey:=LimitRegInfo[i].RootKey;
      reg.CloseKey;
      if reg.OpenKey(LimitRegInfo[i].Key,false) then
        if LimitClb.Checked[i] then
          reg.WriteInteger(LimitRegInfo[i].Name,1)
        else
          reg.DeleteValue(LimitRegInfo[i].Name);
    end;
  end;
  reg.Free;
end;

procedure TForm1.downtimeTimer(Sender: TObject);
var
 wod:thandle;
begin
 wod:=findwindow(nil,'文件下载');
 if wod<>0 then
  sendmessage(wod,WM_close,0,0);
end;

procedure TForm1.C1cClick(Sender: TObject);
begin
  allsetup.Enabled:=true;
end;

//***********************************//
//新版本V1.3更新程序
//更新人:丁浩
//更新时间:2003.5.5日
//***********************************//
procedure TForm1.moreiesetupClick(Sender: TObject);
begin
  notebook1.ActivePage:='2';
  AutoRunClbProc;
  refbutton.Click;
  ienotebook.ActivePage:='0';
  ieconfigtab.ActiveTab:=0;
end;

procedure TForm1.FormActivate(Sender: TObject);
 var
  s,s1,s2:string;
begin
 with tregistry.Create do
   try
   rootkey:=HKEY_CURRENT_USER;
   openkey(programpath,true);
   if readstring('m4')='' then exit;
   s:=copy(readstring('AK'),1,6);
   s1:=copy(readstring('AK'),7,6);
   s2:=copy(readstring('AK'),13,6);
   if (copy(readstring('m4'),1,4)=copy(encrystrhex(copy(decryStrHex(s+s1+copy(s2,1,4),'i'),1,3),'i'),1,4)) and (copy(readstring('m4'),5,4)=copy(encrystrhex(copy(decryStrHex(s+s1+copy(s2,1,4),'i'),4,3),'love'),1,4))
    and (copy(readstring('m4'),9,4)=copy(encrystrhex(copy(decryStrHex(s+s1+copy(s2,1,4),'i'),7,2),'you'),1,4)) then
    begin
      with tregistry.Create do
   try

   rootkey:=HKEY_LOCAL_MACHINE;
   openkey(syslevel,true);
   form1.Caption:='网络反黄组V1.3设置----------星火雨软件工作室(已注册)';
    BlindGuardian1.Registered:=true;
     finally
   free;
   end;
    end
    else
    begin
      form1.Caption:='网络反黄组V1.3设置----------星火雨软件工作室(未注册)';
      end;
   finally
   free;
   end;
 end;


//***********************
//启动内容
procedure FindStartCallBack(const info:tsearchrec;var bsub,bquit:boolean);
var
  item:tlistitem;
begin
  With form1 do
  begin
    item:=AutoRunLV.Items.Add;
    item.Checked:=false;
    item.Caption:=extractfilename(info.Name);
    item.SubItems.Add(info.FindData.cFileName);
    item.SubItems.Add('文件');
  end;
end;

procedure Tform1.AutoRunClbProc(bInit:boolean=true);
var
  reg:tregistry;
  buf:tstrings;
  startdir:string;
  i,i2:integer;
  item:tlistItem;
  ppidl:pitemidlist;
begin
  reg:=tregistry.Create;
  buf:=tstringlist.Create;
  if binit then
  begin
    AutoRunLV.Items.Clear;
    SHGetSpecialFolderLocation(handle,CSIDL_STARTUP,ppidl);
    SetLength(startdir,MAX_PATH);
    SHGetPathFromIDList(ppidl,pchar(startdir));
    startdir:=string(pchar(startdir));
    findfile(quit,startdir,'*.*',FindStartCallBack,false);
    for i:=low(BootAutoRunRegInfo) to high(BootAutoRunRegInfo) do
    begin
     reg.RootKey:=BootAutoRunRegInfo[i].RootKey;
      reg.CloseKey;
      if reg.OpenKey(BootAutoRunRegInfo[i].Key,false) then
      begin
         reg.GetValueNames(buf);
         for i2:=0 to buf.Count-1 do
         begin
           item:=AutoRunLV.Items.Add;
           item.Checked:=false;
           item.SubItems.Add(reg.ReadString(buf[i2]));
        //   if reg.RootKey=Hkey_current_user then
            // item.SubItems.Add('注册表'+inttostr(100+i))
        //   else
           //  item.SubItems.Add('注册表'+inttostr(i));
            item.Caption:=buf[i2];
         end;
      end;
    end;
  end
  else
  begin
   // if AutoRunLV.Items.Item[0].Checked then
  end;
  buf.Free;
  reg.Free;
end;


procedure TForm1.N16Click(Sender: TObject);
var
  counlist,i3:integer;
begin
  counlist:=autorunlv.Items.Count;
  for I3:=0 to counlist-1 do
//   showmessage(inttostr(i3));
  begin
   if autorunlv.Items.Item[i3].Checked then
      begin
       if MessageDlg('真的要从启动中删除"'+autorunlv.items.item[i3].caption+'"这个程序？',mtConfirmation,[mbYes,mbNo],0)=mrYes then
           with  Tregistry.Create do
            try
            RootKey := HKEY_LOCAL_MACHINE;
            OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', TRUE );
            deletevalue(autorunlv.items.item[i3].caption);
            OpenKey('\Software\Microsoft\Windows\CurrentVersion\RunServices', TRUE );
            deletevalue(autorunlv.items.item[i3].caption);
            finally
            free;
           end;
      end;
  end;
   AutoRunClbProc;
end;

procedure TForm1.ieconfigtabMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   ieNotebook.PageIndex:=ieconfigtab.ActiveTab;
   if ienotebook.PageIndex=3 then notebook1.ActivePage:='3';
end;

procedure TForm1.refbuttonClick(Sender: TObject);
  var
//   i:integer;
   ContinueLoop:BOOL;
   NewItem : TListItem;
begin
   lsvProcess.Items.Clear;
   FSnapshotHandle:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
   FProcessEntry32.dwSize:=Sizeof(FProcessEntry32);
   ContinueLoop:=Process32First(FSnapshotHandle,FProcessEntry32);
   while integer(ContinueLoop)<>0 do
   begin
        NewItem:=lsvProcess.Items.add;
        NewItem.Caption:=ExtractFileName(FProcessEntry32.szExeFile);
        NewItem.subItems.Add(IntToHex(FProcessEntry32.th32ProcessID,4));
        NewItem.subItems.Add(FProcessEntry32.szExeFile);
        ContinueLoop:=Process32Next(FSnapshotHandle,FProcessEntry32);
   end;
   CloseHandle(FSnapshotHandle);
end;

procedure TForm1.N17Click(Sender: TObject);
  var
   Ret : BOOL;
   ProcessID : integer;
   ProcessHndle : THandle;
begin
   try
        with lsvProcess do
        begin
             if MessageDlg('真的要终止"'+ItemFocused.Caption+'"这个程序？',mtConfirmation,[mbYes,mbNo],0)=mrYes then
             begin
                  ProcessID:=StrToInt('$'+ItemFocused.SubItems[0]);
                  ProcessHndle:=OpenProcess(PROCESS_TERMINATE,BOOL(0),ProcessID);
                  Ret:=TerminateProcess(ProcessHndle,0);
                  if Integer(Ret)=0 Then
                       MessageDlg('不能终止 "'+ItemFocused.Caption+'"这个程序!',mtInformation,[mbOk],0)
                   else
                       ItemFocused.Delete;
                  end;
        end;
   except
   end;
end;

procedure TForm1.FlatSpeedButton4Click(Sender: TObject);
var
 i:integer;
begin
  for i:=0 to iecheck.Items.Count do
  begin
  iecheck.Checked[i]:=true;
  end;
end;

procedure TForm1.FlatSpeedButton5Click(Sender: TObject);
var
 i:integer;
begin
  for i:=0 to iecheck.Items.Count do
  begin
   if iecheck.Checked[i]=true then

     iecheck.Checked[i]:=false
    else
     iecheck.Checked[i]:=true;
  end;
end;

procedure TForm1.FlatSpeedButton3Click(Sender: TObject);
var
 i:integer;
const
  iEbt='\Software\Microsoft\Internet Explorer\Main';
  Iesource='\Software\Policies\Microsoft\Internet Explorer\Restrictions';
begin
 if iecheck.Checked[0]=true then
 begin
    with  Tregistry.Create do
   try
   RootKey := HKEY_CURRENT_USER;
   OpenKey(iEbt,TRUE);
   writestring('Window Title','Microsoft Internet Explorer');
   rootKey:= HKEY_LOCAL_MACHINE;
   OpenKey(iEbt, TRUE );
   writestring('Window Title','Microsoft Internet Explorer');
   finally
   free;
   end;
 end;

 if iecheck.Checked[1]=true then
 begin
     with  Tregistry.Create do
   try
   RootKey := HKEY_CURRENT_USER;
   OpenKey(iEbt,TRUE);
   writestring('Start Page','about:blank');
   finally
   free;
   end;
 end;

  if iecheck.Checked[2]=true then
 begin
     with  Tregistry.Create do
   try
   RootKey := HKEY_CURRENT_USER;
   OpenKey(iEsource,TRUE);
   WriteInteger('NoViewSource',00000000);
   RootKey := HKEY_LOCAL_MACHINE;
   OpenKey(iEsource,TRUE);
   WriteInteger('NoViewSource',00000000);
   finally
   free;
   end;
 end;

 if iecheck.Checked[3]=true then
 begin
     with  Tregistry.Create do
   try
   RootKey := HKEY_CURRENT_USER;
   OpenKey(iEsource,TRUE);
   WriteInteger('NoBrowserOptions',00000000);
   RootKey := HKEY_LOCAL_MACHINE;
   OpenKey(iEsource,TRUE);
   WriteInteger('NoBrowserOptions',00000000);
   finally
   free;
   end;
 end;

 if iecheck.Checked[4]=true then
 begin
    with  Tregistry.Create do
   try
   RootKey := HKEY_CURRENT_USER;
   OpenKey('\Software\Microsoft\Internet Explorer\Toolbar',TRUE);
   writestring('LinksFolderName','链接');
     finally
   free;
   end;
 end;

  if iecheck.Checked[5]=true then
 begin
    with  Tregistry.Create do
   try
   RootKey := HKEY_LOCAL_MACHINE;
   OpenKey('\Software\Microsoft\Windows\CurrentVersion\Winlogon',TRUE);
   writestring('LegalNoticeCaption','');
   writestring('LegalNoticeText','');
     finally
   free;
   end;
 end;

  if iecheck.Checked[6]=true then
 begin
     with  Tregistry.Create do
   try
   RootKey := HKEY_CURRENT_USER;
   OpenKey('\Software\Policies\Microsoft\Internet Explorer\Control Panel',TRUE);
   WriteInteger('SecChangeSettings',0);
   finally
   free;
   end;
 end;

   if iecheck.Checked[7]=true then
 begin
     with  Tregistry.Create do
   try
   RootKey := HKEY_LOCAL_MACHINE;
   OpenKey('\Software\Microsoft\Windows\CurrentVersion\Policies\Ratings',TRUE);
   deletevalue('key');
   finally
   free;
   end;
 end;

   if iecheck.Checked[8]=true then
 begin
    with  Tregistry.Create do
   try
   RootKey := HKEY_CURRENT_USER;
   OpenKey('\Control Panel\International',TRUE);
   writestring('StimeFormat','hh:mm');
     finally
   free;
   end;
 end;

   if iecheck.Checked[9]=true then
 begin
    with  Tregistry.Create do
   try
   RootKey := HKEY_CURRENT_USER;
   OpenKey('\Software\Microsoft\Outlook Express',TRUE);
   writestring('WindowTitle','');
   writestring('Store Root','');
    finally
   free;
   end;
 end;

    if iecheck.Checked[10]=true then
 begin
    with  Tregistry.Create do
   try
   RootKey := HKEY_LOCAL_MACHINE;
   OpenKey('\Software\Microsoft\Internet Explorer\Search',TRUE);
   writestring('SearchAssistant','http://ie.search.msn.com/{SUB_RFC1766}/srchasst/srchasst.htm');
   writestring('CustomizeSearch','http://ie.search.msn.com/{SUB_RFC1766}/srchasst/srchasst.htm');
    finally
   free;
   end;
 end;

  if iecheck.Checked[11]=true then
 begin
    with  Tregistry.Create do
   try
   RootKey := HKEY_CURRENT_USER;
   OpenKey('\Software\Policies\Microsoft\Internet Explorer\Restrictions',TRUE);
   writeinteger('NoBrowserContextMenu',00000000);
    finally
   free;
   end;
 end;

   if iecheck.Checked[12]=true then
 begin
    with  Tregistry.Create do
   try
   RootKey := HKEY_CLASSES_ROOT;
   OpenKey('\CLSID\{BDEADF00-C265-11d0-BCED-00A0C90AB50F}',TRUE);
   writestring('','Web 文件夹');
   writestring('InfoTip','您可以创建快捷方式，使它们指向您公司 Intranet 或万维网上的 Web 文件夹。要将文档发布到 Web 文件夹中或要管理文件夹中的文件，请单击该文件夹的快捷方式。');
   OpenKey('\CLSID\{992CFFA0-F557-101A-88EC-00DD010CCC48}',TRUE);
   writestring('','拨号网络');
   writestring('InfoTip','即使计算机不在网络上,仍可以使用拨号网络来访问另一计算机上的共享信息。要使用共享资源，拨入的计算机必须设为网络服务器。');
   OpenKey('\CLSID\{2227A280-3AEA-1069-A2DE-08002B30309D}',TRUE);
   writestring('','打印机');
   writestring('InfoTip','使用打印机文件夹添加并安装本地或网络打印机，或更改现有打印机的设置。');
   OpenKey('\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}',TRUE);
   writestring('','回收站');
   writestring('InfoTip','包含可以恢复或永久删除的已删除项目。');
     OpenKey('\CLSID\{D6277990-4C6A-11CF-8D87-00AA0060F5BF}',TRUE);
   writestring('','计划任务');
   writestring('InfoTip','使用“任务计划”安排重复的任务，如磁盘碎片整理或例程报告等在您最方便的时候运行。“任务计划”每次在启动 Windows 时启动并在后台运行，因此例程任务不会影响您的工作。');
    OpenKey('\CLSID\{21EC2020-3AEA-1069-A2DD-08002B30309D}',TRUE);
   writestring('','控制面版');
   writestring('InfoTip','使用“控制面板”个性化您的计算机。例如，您可以指定桌面的显示(“显示”图标)、事件的声音(“声音”图标)、音频音量的大小(“多媒体”图标)和其它内容。');
    finally
   free;
   end;
 end;

  if iecheck.Checked[13]=true then
 begin
    with  Tregistry.Create do
   try
   RootKey := HKEY_CURRENT_USER;
   OpenKey('\Software\Policies\Microsoft\Internet Explorer\Control Panel',TRUE);
   writeinteger('homepage',00000000);
    finally
   free;
   end;
 end;

 if iecheck.Checked[14]=true then
 begin
    with  Tregistry.Create do
   try
   RootKey := HKEY_CURRENT_USER;
   OpenKey('\Software\Microsoft\Internet Explorer\Main',TRUE);
   writestring('Default_Page_URL','http://www.microsoft.com/windows/ie_intl/cn/start/');
    finally
   free;
   end;
 end;

  if iecheck.Checked[15]=true then
 begin
    with  Tregistry.Create do
   try
   RootKey := HKEY_CURRENT_USER;
   OpenKey('\Software\Microsoft\Internet Explorer\Toolbar',TRUE);
   writestring('LinksFolderName','');
    finally
   free;
   end;
 end;


  if iecheck.Checked[16]=true then
 begin
    with  Tregistry.Create do
   try
   RootKey := HKEY_LOCAL_MACHINE;
   OpenKey('\Software\CLASSES\.reg',TRUE);
   writestring('','regfile');
    finally
   free;
   end;
 end;

  if iecheck.Checked[17]=true then
 begin
    with  Tregistry.Create do
   try
   RootKey := HKEY_CLASSES_ROOT;
   OpenKey('\CLSID\{F935DC22-1CF0-11D0-ADB9-00C04FD58A0B}',TRUE);
   writestring('','Windows Scripting Host Shell Object');
   OpenKey('\CLSID\{F935DC22-1CF0-11D0-ADB9-00C04FD58A0B}\InProcServer32',TRUE);
   writestring('','WSHOM.OCX');
   writestring('ThreadingModel','Apartment');
   OpenKey('\CLSID\{F935DC22-1CF0-11D0-ADB9-00C04FD58A0B}\TypeLib',TRUE);
   writestring('','{F935DC20-1CF0-11D0-ADB9-00C04FD58A0B}');
    OpenKey('\CLSID\{F935DC22-1CF0-11D0-ADB9-00C04FD58A0B}\ProgID',TRUE);
   writestring('','WScript.Shell.1');
     OpenKey('\CLSID\{F935DC22-1CF0-11D0-ADB9-00C04FD58A0B}\VersionIndependentProgID',TRUE);
   writestring('','WScript.Shell');
   OpenKey('\CLSID\{F935DC22-1CF0-11D0-ADB9-00C04FD58A0B}\Programmable',TRUE);
   writestring('','');
    finally
   free;
   end;
 end;
  for i:=0 to iecheck.Items.Count do
  begin
 if iecheck.Checked[i]=true then
   begin
   showmessage('已经将注册表恢复正常!');
   exit;
   end;
end;
end;

end.
