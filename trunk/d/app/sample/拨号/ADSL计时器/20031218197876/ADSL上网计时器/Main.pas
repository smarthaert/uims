//=========================================================================//
//                                                                         //
//                              主窗口源代码                               //
//                               作者:沈杰                                 //
//                               2003-03-21                                //
//                实现了ADSL上网监视计时,可以实现最基本的用户需求          //
//                    希望大家不要删除本程序中这样的注释语句               //
//=========================================================================//

unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Menus, wininet, WinSock, XPMenu,
  ADSLStringRes, INIFiles, ImgList, SetupFrm, DateUtils, RzTray, Registry,
  ShellAPI;

type
  OSType = (osUnknown, osWin95, osWin98, osWin98se, osWinme, osWinnt4, osWin2k,
    osWinxp);

type
  TFrmADSLMain = class(TForm)
    MainMenu1: TMainMenu;
    Panel1: TPanel;
    MenuSetup: TMenuItem;
    MenuView: TMenuItem;
    MenuDropFrm: TMenuItem;
    MenuFrmTrans: TMenuItem;
    DateTimePicker1: TDateTimePicker;
    PanDate: TPanel;
    PanDateSelect: TPanel;
    TreeView1: TTreeView;
    StatusBar1: TStatusBar;
    panMain: TPanel;
    ListView1: TListView;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Memo1: TMemo;
    XPMenu1: TXPMenu;
    ilstTree: TImageList;
    tmrChecker: TTimer;
    tmrTime: TTimer;
    lblMonthStr: TLabel;
    lblCurStr: TLabel;
    lblStartStr: TLabel;
    RzTrayIcon1: TRzTrayIcon;
    pMenuMain: TPopupMenu;
    MenuShowDrop: TMenuItem;
    MenuShowMain: TMenuItem;
    MenuDropTran: TMenuItem;
    MenuN1: TMenuItem;
    MenuN2: TMenuItem;
    MenuClose: TMenuItem;
    MenuHelp: TMenuItem;
    MenuHelpTopic: TMenuItem;
    MenuAbout: TMenuItem;
    MenuN3: TMenuItem;
    MMenuDropSetup: TMenuItem;
    N1: TMenuItem;
    E1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MenuDropFrmClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuFrmTransClick(Sender: TObject);
    procedure MenuOptionClick(Sender: TObject);
    procedure tmrCheckerTimer(Sender: TObject);
    procedure tmrTimeTimer(Sender: TObject);
    procedure MenuCloseClick(Sender: TObject);
    procedure MenuShowMainClick(Sender: TObject);
    procedure MenuAboutClick(Sender: TObject);
    procedure MMenuDropSetupClick(Sender: TObject);
    procedure E1Click(Sender: TObject);
    procedure MenuHelpTopicClick(Sender: TObject);
  private
    { Private declarations }
    XSTimeMonth, XSTimeDay, JSDay: Byte; //每天限时的时间

    MonthDate: string; //本月用时,这个应该是一个累加的字符串变量，因为
    //Delphi里面的时间变量的小时数无法超过24.只能用字符串来代替
    CurrentDate, EndTime: TTime;

    MonthStart: TDateTime; //本月开始的时间和日期

    szCallSound: string; //报警声音的路径
    IsCallSound: Boolean; //是否报警
    IsDefaultSound: Boolean; //是否使用默认声音报警
    IsSetupDay: Boolean; //每个月重新计时那天是否已经重新计时
  public
    { Public declarations }
    procedure ShowDropFrm;
    procedure InitDateProc; //这个过程中还初始化了程序所在的目录地址
    procedure AddNameToTreeNode; //添加用户名到树型节点
    procedure AddIPToListView;
    procedure WriteTimeToFile(FileName: string; SumTime: string);
    procedure ReadFileToListView(FileName: string = '');
    procedure WM_MyAppendMenu(var msg: TWMSysCommand); message WM_SYSCOMMAND;
    function CheckOffline: boolean;
    function CountStrToDateTime(const str: string; DateTime: TDateTime): string;
  end;

var
  FrmADSLMain: TFrmADSLMain;
  hnd: THandle;

implementation

uses
  DropFrm, AboutFrm, DropSetupFrm, MMSystem;
{$R *.dfm}

function GetOSVersion: OSType;
var
  osVerInfo: TOSVersionInfo;
  majorVer, minorVer: Integer;
begin
  osVerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  if (GetVersionEx(osVerInfo)) then
  begin
    majorVer := osVerInfo.dwMajorVersion;
    minorVer := osVerInfo.dwMinorVersion;
    case (osVerInfo.dwPlatformId) of
      VER_PLATFORM_WIN32_NT: { Windows NT/2000 }
        begin
          if (majorVer <= 4) then
            Result := osWinnt4
          else if ((majorVer = 5) and (minorVer = 0)) then
            Result := osWin2k
          else if ((majorVer = 5) and (minorVer = 1)) then
            Result := osWinxp
          else
            Result := OsUnknown;
        end;
      VER_PLATFORM_WIN32_WINDOWS: { Windows 9x/ME }
        begin
          if ((majorVer = 4) and (minorVer = 0)) then
            Result := osWin95
          else if ((majorVer = 4) and (minorVer = 10)) then
          begin
            if (osVerInfo.szCSDVersion[1] = 'A') then
              Result := osWin98se
            else
              Result := osWin98;
          end
          else if ((majorVer = 4) and (minorVer = 90)) then
            Result := OsWinME
          else
            Result := OsUnknown;
        end;
    else
      Result := OsUnknown;
    end; //end of case
  end
  else
    Result := OsUnknown;
end;

//获得本机IP地址(静态分配的IP)

function LocalIP: string;
type
  TaPInAddr = array[0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe: PHostEnt;
  pptr: PaPInAddr;
  Buffer: array[0..63] of char;
  I: Integer;
  GInitData: TWSADATA;
begin
  WSAStartup($101, GInitData);
  GetHostName(Buffer, SizeOf(Buffer));
  phe := GetHostByName(buffer);
  if phe = nil then
    Exit;
  pptr := PaPInAddr(Phe^.h_addr_list);
  I := 0;
  result := StrPas(inet_ntoa(pptr^[i]^));
  WSACleanup;
end;

function HostName: string;
var
  Buffer: array[0..127] of char;
  GInitData: TWSADATA;
begin
  WSAStartup($101, GInitData);
  result := '';
  GetHostName(Buffer, Sizeof(Buffer));
  result := StrPas(Buffer);
  WSACleanup;
end;

procedure TFrmADSLMain.InitDateProc;
var
  INI: TINIFile;
  Reg: TRegistry;
begin
  Path := ExtractFilePath(ParamStr(0));

  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', False) then
      if Reg.ReadString('ADSL') = '' then
        Reg.WriteString('ADSL', Application.ExeName);
  finally
    FreeAndNil(Reg);
  end;

  INI := TINIFile.Create(Path + 'ADSL.ini');
  try
      IsSetupDay := INI.ReadBool('Setup', 'SetupBool', False);
      XSTimeMonth := StrToInt(INI.ReadString('Setup', 'MonthDate', '120'));
      //每月的限时小时
      XSTimeDay := StrToInt(INI.ReadString('Setup', 'Date', '5'));
      //每天的限时小时
      JSDay := StrToInt(INI.ReadString('Setup', 'Start', '21')); //计时开始日期

      //是否使用声音报警
      IsCallSound := INI.ReadBool('Setup', 'Sound', False);
      IsDefaultSound := INI.ReadBool('Setup', 'DefaultSound', True);

      if (JSDay = DayOf(Now)) and (IsSetupDay = False) then
        //如果到了每个月的计时日期
      begin
        MonthDate := '00:00:00';
        INI.WriteBool('Setup', 'SetupBool', IsSetupDay);
      end
      else
      begin
        MonthDate := INI.ReadString('Date', 'SumTime', '00:00:00');
        INI.WriteBool('Setup', 'SetupBool', IsSetupDay);
      end;

      MonthStart := INI.ReadDateTime('Date', 'Start', Now);

      szCallSound := INI.ReadString('Setup', 'SoundPath', '');
  finally
    INI.Free;
  end;
  ReadFileToListView(Path + 'ADSL.trv');
  DateTimePicker1.Date := Now;
  AddNameToTreeNode;
  AddIPToListView;
end;

procedure TFrmADSLMain.FormCreate(Sender: TObject);
begin
  InitDateProc;

  lblMonthStr.Caption := Str1 + MonthDate;
  lblCurStr.Caption := Str2 + FormatDateTime('hh:mm:ss', CurrentDate);
  lblStartStr.Caption := Str3 + DateTimeToStr(MonthStart);
  case GetOSVersion of //
    osUnknown..osWinme:
      begin
        MenuFrmTrans.Enabled := False;
        MenuFrmTrans.Checked := False;
      end;
  end; // case
end;

procedure TFrmADSLMain.ShowDropFrm;
begin
  if FrmDrop.Showing = False then
  begin
    if MenuDropFrm.Checked then
    begin
      FrmDrop := TFrmDrop.Create(Self);
      FrmDrop.Visible := True;
      FrmADSLMain.Visible := True;
    end;
    if MenuFrmTrans.Checked then
    begin
      FrmDrop.AlphaBlend := True;
      FrmDrop.AlphaBlendValue := 150;
    end;
  end;
  FrmDrop.Label1.Caption := MonthDate;
  ListView1.SetFocus;
end;

procedure TFrmADSLMain.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  FreeAndNil(tmrChecker);
  FreeAndNil(tmrTime);
  EndTime := CurrentDate;
  //断网的时候并且需要给MonthDate字符串赋值新的时间
  MonthDate := CountStrToDateTime(MonthDate, EndTime);
  if (CurrentDate <> 0) or (EndTime <> 0) then
  begin
    MonthDate := CountStrToDateTime(MonthDate, EndTime);
    WriteTimeToFile(Path + 'ADSL.ini', MonthDate);
  end;

  SendMessage(FrmDrop.Handle, WM_CLOSE, 0, 0);
end;

procedure TFrmADSLMain.MenuDropFrmClick(Sender: TObject);
begin
  MenuDropFrm.Checked := not MenuDropFrm.Checked;
  MenuShowDrop.Checked := not MenuShowDrop.Checked;
  if MenuDropFrm.Checked then
  begin
    FrmDrop.Visible := True;
    FrmDrop.pelMain.Visible := True;
  end
  else
  begin
    FrmDrop.Hide;
  end;
end;

procedure TFrmADSLMain.FormShow(Sender: TObject);
begin
  ShowDropFrm;
end;

procedure TFrmADSLMain.MenuFrmTransClick(Sender: TObject);
begin
  MenuFrmTrans.Checked := not MenuFrmTrans.Checked;
  MenuDropTran.Checked := not MenuDropTran.Checked;
  if MenuFrmTrans.Checked then
  begin
    FrmDrop.AlphaBlend := True;
    FrmDrop.AlphaBlendValue := 150;
  end
  else
    FrmDrop.AlphaBlend := False;
end;

procedure TFrmADSLMain.AddNameToTreeNode;
var
  Node: TTreeNode;
begin
  Node := TTreeNode.Create(TreeView1.Items);
  TreeView1.Items.Add(Node, HostName);
end;

procedure TFrmADSLMain.AddIPToListView;
var
  Item: TListItem;
begin
  //ListView1.Clear;
  Item := ListView1.Items.Add;
  Item.Caption := FormatDateTime('yyyy-mm-dd hh:mm:ss', Now);
  Item.SubItems.Add('');
  Item.SubItems.Add('');
  Item.SubItems.Add(HostName);
  Item.SubItems.Add('ADSL');
  Item.SubItems.Add(LocalIP);
end;

procedure TFrmADSLMain.MenuOptionClick(Sender: TObject);
begin
  Application.CreateForm(TFrmSetup, FrmSetup);
  FrmSetup.ShowModal;
end;

//用来检查电脑是否连上网络

procedure TFrmADSLMain.tmrCheckerTimer(Sender: TObject);
begin
  if CheckOffline then
    tmrTime.Enabled := True
  else
  begin
    FrmDrop.Label1.Caption := MonthDate;
    tmrTime.Enabled := False;
    EndTime := CurrentDate; //断网的时候给EndTime赋值
  end;
end;

procedure TFrmADSLMain.tmrTimeTimer(Sender: TObject);
begin //这部分检测我自认为写的非常的烂，希望大家(比我厉害的人可以改进他)
  try
    CurrentDate := IncSecond(CurrentDate);
    EndTime := CurrentDate;
  except
    CurrentDate := 0;
    DateTimePicker1.Date := Now;
    MonthDate := CountStrToDateTime(MonthDate, EndTime);
    WriteTimeToFile(Path + 'ADSL.ini', MonthDate);
  end;

  if HourOf(CurrentDate) = XSTimeDay then
    //首先判断是否使用声音
    if IsCallSound = False then
    begin
      MessageBox(Handle, '今天上网的时间已经到了!', '提示', MB_OK);
      Sleep(100);
      tmrChecker.Enabled := False;
      tmrTime.Enabled := False;
    end
    else
    begin
      //如果是使用声音报警，那么先看是否是使用默认声音
      if IsDefaultSound then
      begin
        MessageBeep(0);
        Sleep(100);
        tmrChecker.Enabled := False;
        tmrTime.Enabled := False;
      end
      else
      begin
        PlaySound(PChar(szCallSound), 0, SND_ASYNC);
        Sleep(100);
        tmrChecker.Enabled := False;
        tmrTime.Enabled := False;
      end;
    end;

  if StrToInt(Copy(MonthDate, 1, Pos(':', MonthDate) - 1)) = XSTimeMonth then
    if IsCallSound = False then
    begin
      MessageBox(Handle, '本月上网时间已经到了!', '提示', MB_OK);
      Sleep(100);
      tmrChecker.Enabled := False;
      tmrTime.Enabled := False;
    end
    else
    begin
      //如果是使用声音报警，那么先看是否是使用默认声音
      if IsDefaultSound then
      begin
        MessageBeep(0);
        Sleep(100);
        tmrChecker.Enabled := False;
        tmrTime.Enabled := False;
      end
      else
      begin
        PlaySound(PChar(szCallSound), 0, SND_ASYNC);
        Sleep(100);
        tmrChecker.Enabled := False;
        tmrTime.Enabled := False;
      end;
    end;

  FrmDrop.Label1.Caption := MonthDate;
  lblMonthStr.Caption := Str1 + MonthDate;

  FrmDrop.Label2.Caption := FormatDateTime('hh:mm:ss', CurrentDate);
  lblCurStr.Caption := Str2 + FormatDateTime('hh:mm:ss', CurrentDate);
end;

procedure TFrmADSLMain.WriteTimeToFile(FileName: string; SumTime: string);
var
  fINI: TINIFile;
  fText: TextFile;
  i: integer;
  tmp: string;
begin
  if FileExists(FileName) = False then
    FileName := Path + 'ADSL.ini';

  //==============关闭程序的时候需要加入的东西=============//
  ListView1.Items[ListView1.Items.Count - 1].SubItems[0] :=
    FormatDateTime('yyyy-mm-dd hh:mm:ss', Now);
  ListView1.Items[ListView1.Items.Count - 1].SubItems[1] :=
    FormatDateTime('hh:mm:ss', EndTime);
  //=======================================================//

  AssignFile(fText, ExtractFilePath(FileName) + 'ADSL.trv');
  Rewrite(fText);
  try
    for i := 0 to ListView1.Items.Count - 1 do // Iterate
    begin
      try
        tmp := ListView1.Items[i].Caption + #7 +
          ListView1.Items[i].SubItems[0] + #7 +
          ListView1.Items[i].SubItems[1] + #7 +
          ListView1.Items[i].SubItems[2] + #7 +
          ListView1.Items[i].SubItems[3] + #7 +
          ListView1.Items[i].SubItems[4];
        Writeln(fText, tmp);
      except
        CloseFile(fText);
      end;
    end; // for
  finally
    CloseFile(fText);
  end;

  fINI := TINIFile.Create(FileName);
  fINI.WriteString('Date', 'SumTime', SumTime);
  if fINI.ReadDateTime('Date', 'Start', 0) = 0 then
    fINI.WriteDateTime('Date', 'Start', MonthStart);
  FreeAndNil(fINI);
end;

procedure TFrmADSLMain.WM_MyAppendMenu(var msg: TWMSysCommand);
begin
  if msg.CmdType = SC_CLOSE then
  begin
    Application.Minimize;
    MenuShowMain.Checked := False;
  end
  else
    inherited;
end;

procedure TFrmADSLMain.MenuCloseClick(Sender: TObject);
begin
  Close;
end;

function TFrmADSLMain.CheckOffline: boolean;
const
  //这里的代码就是检测是否在线的但是InternetGetConnectedState
 //这个API函数还是不强大，如果用户在局域网中，这个函数无效。2003-04-25
  INTERNET_CONNECTION_MODEM = 1;

  INTERNET_CONNECTION_LAN = 2;

  INTERNET_CONNECTION_PROXY = 4;

  INTERNET_CONNECTION_MODEM_BUSY = 8;
var
  dwConnectionTypes: DWORD;
begin
  dwConnectionTypes := INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN
    + INTERNET_CONNECTION_PROXY + INTERNET_CONNECTION_MODEM_BUSY;

  Result := InternetGetConnectedState(@dwConnectionTypes, 0);
end;

procedure TFrmADSLMain.MenuShowMainClick(Sender: TObject);
begin
  MenuShowMain.Checked := not MenuShowMain.Checked;

  if MenuShowMain.Checked = False then
    ShowWindow(FrmADSLMain.Handle, SW_HIDE)
  else
    ShowWindow(FrmADSLMain.Handle, SW_SHOW);
end;

procedure TFrmADSLMain.MenuAboutClick(Sender: TObject);
begin
  Application.CreateForm(TAboutBox, AboutBox);
  AboutBox.ShowModal;
end;

procedure TFrmADSLMain.MMenuDropSetupClick(Sender: TObject);
begin
  FrmDropSetup := TFrmDropSetup.Create(Self);
  FrmDropSetup.Visible := True;
end;

procedure TFrmADSLMain.ReadFileToListView(FileName: string);
var
  Item: TListItem;
  tmp, tmp1: string;
  Str: TStrings;
  fText: TextFile;
  i: integer;
begin
  Str := TStringList.Create;
  if FileExists(FileName) then
  begin
    AssignFile(fText, FileName);
    Reset(fText);
    try
      while not EOF(fText) do
      begin
        Readln(fText, tmp);
        while Pos(#7, tmp) <> 0 do
        begin
          tmp1 := Copy(tmp, 1, Pos(#7, tmp) - 1);
          tmp := Copy(tmp, Pos(#7, tmp) + 1, Length(tmp));
          Str.Add(tmp1);
        end; //while
        if tmp <> '' then
          Str.Add(tmp);
        if Str.Count <> 0 then
        begin
          //开始往ListView1里面装从文件中读取出来的东西
          Item := ListView1.Items.Add;
          Item.Caption := Str.Strings[0];
          for i := 1 to Str.Count - 1 do // Iterate
          begin
            Item.SubItems.Add(Str.Strings[i]);
          end; // for
          Str.Clear;
        end;
      end; // while
    finally
      CloseFile(fText);
    end;
  end;
end;

procedure TFrmADSLMain.E1Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'MailTo:jackyshenno1@163.com', nil, nil,
    SW_SHOW); //请不要更改这里的代码，如果需要您可以把这里修改为弹出窗口
  //让用户选择给哪位作者发送E-Mail
end;

function TFrmADSLMain.CountStrToDateTime(const str: string;
  DateTime: TDateTime): string;
var
  strs: TStrings;
  tmp: string;
  i: integer;
begin
  strs := TStringList.Create;
  tmp := str;
  while Pos(':', tmp) <> 0 do
  begin
    strs.Add(Copy(tmp, 1, Pos(':', tmp) - 1));
    tmp := Copy(tmp, Pos(':', tmp) + 1, Length(tmp));
  end; // while
  if tmp <> '' then
    strs.Add(tmp);
  tmp := '';
  //strs最多只能存在3个Items
  if strs.Count - 1 > 3 then
    result := DateTimeToStr(Now)
  else
  begin
    strs.Strings[0] := IntToStr(Hourof(DateTime) + StrToInt(strs.Strings[0]));
    strs.Strings[1] := IntToStr(MinuteOf(DateTime) + StrToInt(strs.Strings[1]));
    if StrToInt(strs.Strings[1]) > 60 then
    begin
      i := StrToInt(strs.Strings[1]) div 60;
      strs.Strings[0] := IntToStr(StrToInt(strs.Strings[0]) + i);
      strs.Strings[1] := IntToStr(StrToInt(strs.Strings[1]) - i * 60);
    end;

    strs.Strings[2] := IntToStr(SecondOf(DateTime) + StrToInt(strs.Strings[2]));
    if StrToInt(strs.Strings[2]) > 60 then
    begin
      i := StrToInt(strs.Strings[2]) div 60;
      strs.Strings[1] := IntToStr(StrToInt(strs.Strings[1]) + i);
      strs.Strings[2] := IntToStr(StrToInt(strs.Strings[2]) - i * 60);
    end;

    tmp := tmp + strs.Strings[0] + ':' + strs.Strings[1] + ':' +
      strs.Strings[2];
  end;
  result := tmp;
end;

procedure TFrmADSLMain.MenuHelpTopicClick(Sender: TObject);
begin
  ShowMessage('本程序是免费程序,没有自带帮助,如果您有兴趣可以写一个本程序的' +
    '的帮助文件,写完后一定要发给我一份哦!');
  //希望这次公开这个源代码，有热心人士可以写一个比较完善的帮助，当然完善的帮助
  //是需要建立在完善的程序上的。
end;

initialization
  //建立一个互斥对象，防止应用程序被重复开启
  hnd := CreateMutex(nil, True, 'ShenJie ADSL');
  if GetLastError = ERROR_ALREADY_EXISTS then
    Halt;
finalization
  if hnd <> 0 then
    CloseHandle(hnd);
end.

