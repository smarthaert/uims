{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *


Unit:         Remote Access Service Dialer (RAS-DIALER)
Creation:     Feb 18, 1997.
EMail:        francois.piette@pophost.eunet.be    francois.piette@rtfm.be
              http://www.rtfm.be/fpiette
Legal issues: Copyright (C) 1996, 1997, 1998 by François PIETTE
              Rue de Grady 24, 4053 Embourg, Belgium. Fax: +32-4-365.74.56
              <francois.piette@pophost.eunet.be>

              This software is provided 'as-is', without any express or
              implied warranty.  In no event will the author be held liable
              for any  damages arising from the use of this software.

              Permission is granted to anyone to use this software for any
              purpose, including commercial applications, and to alter it
              and redistribute it freely, subject to the following
              restrictions:

              1. The origin of this software must not be misrepresented,
                 you must not claim that you wrote the original software.
                 If you use this software in a product, an acknowledgment
                 in the product documentation would be appreciated but is
                 not required.

              2. Altered source versions must be plainly marked as such, and
                 must not be misrepresented as being the original software.

              3. This notice may not be removed or altered from any source
                 distribution.
Updates:
Sep 25, 1998  V1.10  Added RasGetIPAddress. Thanks to Jan Tomasek
              <xtomasej@fel.cvut.cz> for his help.


 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
unit RasDialer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, IniFiles, Ras, FormAuto, LogMsg, ExtCtrls, Menus, ShellApi;


const
  WM_AUTOCONNECT = WM_USER + 1;

type
  TRasDialerForm = class(TAutoForm)
    ConnectButton: TButton;
    InfoListBox: TListBox;
    CancelButton: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    PasswordEdit: TEdit;
    SavePWCheckBox: TCheckBox;
    CheckTimer: TTimer;
    EntryNameComboBox: TComboBox;
    UserNameComboBox: TComboBox;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    MnuQuit: TMenuItem;
    MnuConnect: TMenuItem;
    MnuProperties: TMenuItem;
    MnuNew: TMenuItem;
    MnuAbout: TMenuItem;
    MnuCancel: TMenuItem;
    N1: TMenuItem;
    MnuOptions: TMenuItem;
    MnuConfigure: TMenuItem;
    RunInternetBrowser1: TMenuItem;
    RunInternetMailReader1: TMenuItem;
    RunInternetNewsReader1: TMenuItem;
    N2: TMenuItem;
    DurationLabel: TLabel;
    MnuClearduration: TMenuItem;
    TimeRestrictions1: TMenuItem;
    IPButton: TButton;
    procedure ConnectButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CheckTimerTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EntryNameComboBoxChange(Sender: TObject);
    procedure UserNameComboBoxChange(Sender: TObject);
    procedure MnuQuitClick(Sender: TObject);
    procedure MnuConnectClick(Sender: TObject);
    procedure MnuPropertiesClick(Sender: TObject);
    procedure MnuNewClick(Sender: TObject);
    procedure MnuAboutClick(Sender: TObject);
    procedure MnuCancelClick(Sender: TObject);
    procedure MnuConfigureClick(Sender: TObject);
    procedure RunInternetNewsReader1Click(Sender: TObject);
    procedure RunInternetBrowser1Click(Sender: TObject);
    procedure RunInternetMailReader1Click(Sender: TObject);
    procedure MnuCleardurationClick(Sender: TObject);
    procedure TimeRestrictions1Click(Sender: TObject);
    procedure IPButtonClick(Sender: TObject);
  private
    { Private declarations }
    hRasConn        : THRASCONN;
    ConnectTime     : DWORD;
    aRasConn        : array [0..10] of TRASCONN;
    nRasConnCount   : DWORD;
    DialingServer   : String;
    DialingUserName : String;
    DialingPassword : String;
    procedure WMAutoConnect(var Msg : TMessage); message WM_AUTOCONNECT;
    procedure Connected;
    procedure Disconnected;
    procedure GetActiveConn;
    procedure DisplayActiveConn;
    function  GetActiveConnHandle(szName : String) : THRASCONN;
    procedure SaveSettings;
    procedure LoadPhoneBook;
    procedure SelectPhoneBookEntry(EntryName : String);
    procedure GetUserNameList;
    procedure GetUserPassword;
    procedure GetDuration;
    function  GetKeyDuration : String;
    procedure DoConnect;
    procedure DoDuration;
    procedure DoProperties;
    procedure DoNew;
    procedure DoCancel;
    procedure DoConfigure;
  public
    { Public declarations }
    procedure Dial(EntryName, UserName, Password : String);
    procedure WndProc(var Msg: TMessage); override;
    procedure LogMessage(Msg : String);
  end;

var
  RasDialerForm: TRasDialerForm;
  Log:           TLogMsg;

implementation

uses
    RasDial2, RasDial3, RasDial4;

{$R *.DFM}
const
    ProgName = 'RasDial';
    ProgVer  = 'V1.11';
    
function Encrypt(S : String) : String; forward;
function CrunchName(S : String) : String; forward;

var
  g_hWnd: HWND;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.WMAutoConnect(var Msg : TMessage);
begin
    LogMessage('AutoConnect on startup');
    DoConnect;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.LogMessage(Msg : String);
begin
    Log.Text('!', Msg);
    InfoListBox.Items.Add(Msg);
    InfoListBox.Refresh;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure RasDialFunc(unMsg : DWORD;
                      RasConnState : TRASCONNSTATE;
                      dwError : DWORD); stdcall;
begin
    PostMessage(g_hWnd,
                WM_RASDIALEVENT,
                RasConnState,
                dwError);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.Connected;
begin
    ConnectTime          := GetTickCount;
    CancelButton.Caption := '&Disconnect';
    CheckTimer.Enabled   := TRUE;
    Caption              := ProgName + ' - Connected';
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.Disconnected;
begin
    if hRasConn <> 0 then begin
        RasHangUpA(hRasConn);
        hRasConn          := 0;
    end;
    CancelButton.Enabled  := FALSE;
    ConnectButton.Enabled := TRUE;
    CancelButton.Caption  := 'Ca&ncel';
    CheckTimer.Enabled    := FALSE;
    ConnectTime           := 0;
    Caption               := ProgName;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.WndProc(var Msg: TMessage);
var
    Buf      : array [0..255] of Char;
begin
    if Msg.Msg <> WM_RASDIALEVENT then begin
        inherited WndProc(Msg);
        Exit;
    end;
    LogMessage(RasConnectionStateToString(Msg.wParam));
    if Msg.wParam = RASCS_Connected then begin
        Connected;
        ConfigureAutoForm.ExecuteMailAuto;
        ConfigureAutoForm.ExecuteNewsAuto;
        ConfigureAutoForm.ExecuteBrowserAuto;
    end
    else if Msg.wParam = RASCS_Disconnected then begin
        RasGetErrorStringA(Msg.lParam, @Buf[0], SizeOf(Buf));
        LogMessage(Buf);
        Disconnected;
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function TRasDialerForm.GetKeyDuration : String;
begin
    if ConfigureAutoForm.MonthlyDuration then
        Result := 'DurationFor' + FormatDateTime('mm', Date)
    else
        Result := 'Duration';
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.MnuCleardurationClick(Sender: TObject);
var
    Duration    : Integer;
    IniFile     : TIniFile;
    Section     : String;
    Key         : String;
begin
    if Application.MessageBox('Clear cumulated duration ?', 'Warning',
                              mb_YESNO + mb_DEFBUTTON2) <> IDYES then
        Exit;

    Key     := GetKeyDuration;
    IniFile := TIniFile.Create(FIniFileName);
    Section := 'RAS_ENTRY_' + CrunchName(EntryNameComboBox.Text);
    Duration := IniFile.ReadInteger(Section, Key, 0);
    LogMessage(Key + '''' +
               EntryNameComboBox.Text + ''' cleared. It was ' +
               IntToStr(Duration) + ' Sec');
    IniFile.WriteInteger(Section, Key, 0);
    IniFile.Free;
    GetDuration;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.GetDuration;
var
    Duration    : TDateTime;
    IniFile     : TIniFile;
    Section     : String;
    Key         : String;
begin
    Key     := GetKeyDuration;
    IniFile := TIniFile.Create(FIniFileName);
    Section := 'RAS_ENTRY_' + CrunchName(EntryNameComboBox.Text);
    Duration := IniFile.ReadInteger(Section, Key, 0) / 24 / 3600;
    if Duration >= 2.0 then
        DurationLabel.Caption := IntToStr(Trunc(Duration)) + ' days '
    else if Duration >= 1.0 then
        DurationLabel.Caption := IntToStr(Trunc(Duration)) + ' day '
    else
        DurationLabel.Caption := '';

    DurationLabel.Caption := 'Total: ' + DurationLabel.Caption +
                             TimeToStr(Frac(Duration));
    IniFile.Free;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.DoDuration;
var
    Duration    : Integer;
    OldDuration : Integer;
    IniFile     : TIniFile;
    Section     : String;
    Key         : String;
begin
    if (ConnectTime = 0) or (ConnectTime = $FFFFFFFF) then
        Exit;

    Key      := GetKeyDuration;
    Duration := (GetTickCount - ConnectTime) div 1000;
    LogMessage(Key + ': ' + IntToStr(Duration) +
               ' Sec with ' + DialingServer);
    ConnectTime := 0;

    IniFile := TIniFile.Create(FIniFileName);
    Section := 'RAS_ENTRY_' + CrunchName(DialingServer);
    OldDuration := IniFile.ReadInteger(Section, Key, 0);
    IniFile.WriteInteger(Section, Key, OldDuration + Duration);
    LogMessage('Cumulated ' + Key + ': ' +
               IntToStr(OldDuration + Duration) + ' Sec');
    IniFile.Free;
    GetDuration;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.CheckTimerTimer(Sender: TObject);
var
    RasConnStatus : TRASCONNSTATUS;
    Status        : DWORD;
    Buf           : array [0..255] of Char;
begin
    if hRasConn = 0 then
        Exit;

    FillChar(RasConnStatus, SizeOf(RasConnStatus), 0);
    RasConnStatus.dwSize := SizeOf(RasConnStatus);
    Status := RasGetConnectStatusA(hRasConn, @RasConnStatus);
    if Status = ERROR_INVALID_HANDLE then begin
        LogMessage('Connection closed');
        DoDuration;
        Disconnected;
        Exit;
    end;

    if Status <> 0 then begin
        Buf := '';
        RasGetErrorStringA(Status, @Buf[0], SizeOf(Buf));
        LogMessage('Error #' + IntToStr(Status) + ' : ' + Buf);
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.Dial(EntryName, UserName, Password : String);
var
    rdParams : TRASDIALPARAMS;
    dwRet    : DWORD;
    Buf      : array [0..255] of Char;
begin
    hRasConn := GetActiveConnHandle(EntryName);
    if hRasConn <> 0 then begin
        LogMessage('Connection already active');
        Connected;
        ConnectTime := $FFFFFFFF;
        Exit;
    end;

    // setup RAS Dial Parameters
    FillChar(rdParams, SizeOf(rdParams), 0);
    rdParams.dwSize              := SizeOf(TRASDIALPARAMS);
    strCopy(rdParams.szUserName,  PChar(UserName));
    strCopy(rdParams.szPassword,  PChar(Password));
    strCopy(rdParams.szEntryName, PChar(EntryName));
    rdParams.szPhoneNumber[0]    := #0;
    rdParams.szCallbackNumber[0] := '*';
    rdParams.szDomain            := '*';

    g_hWnd := Handle;
    hRasConn := 0;;
    dwRet  := RasDialA(nil, nil, @rdParams, 0, @RasDialFunc, @hRasConn);
    if dwRet <> 0 then begin
        RasGetErrorStringA(dwRet, @Buf[0], SizeOf(Buf));
        LogMessage(IntToStr(dwRet) + ' ' + Buf);
        Disconnected;
    end
    else begin
        LogMessage('Dialing ''' + EntryName + '''');
        CancelButton.Enabled  := TRUE;
        ConnectButton.Enabled := FALSE;
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.SaveSettings;
var
    IniFile : TIniFile;
    EntryName : String;
    UserName  : String;
begin
    IniFile := TIniFile.Create(FIniFileName);
    IniFile.WriteString('Last', 'EntryName', EntryNameComboBox.Text);
    IniFile.WriteString('Last', 'UserName',  UserNameComboBox.Text);
    IniFile.WriteInteger('Last', 'AutoPW',    ord(ConfigureAutoForm.AutoPassword));
    IniFile.WriteInteger('Last', 'AutoUN',    ord(ConfigureAutoForm.AutoUserName));
    IniFile.WriteInteger('Last', 'AutoConnect',        ord(ConfigureAutoForm.AutoConnect));
    IniFile.WriteInteger('Last', 'AutoExecuteBrowser', ord(ConfigureAutoForm.AutoExecuteBrowser));
    IniFile.WriteInteger('Last', 'AutoExecuteMail',    ord(ConfigureAutoForm.AutoExecuteMail));
    IniFile.WriteInteger('Last', 'AutoExecuteNews',    ord(ConfigureAutoForm.AutoExecuteNews));
    IniFile.WriteInteger('Last', 'MonthlyDuration',    ord(ConfigureAutoForm.MonthlyDuration));
    IniFile.WriteString('Last', 'BrowserExe',          ConfigureAutoForm.BrowserExe);
    IniFile.WriteString('Last', 'MailExe',             ConfigureAutoForm.MailExe);
    IniFile.WriteString('Last', 'NewsExe',             ConfigureAutoForm.NewsExe);
    IniFile.WriteString('Last', 'BrowserDir',          ConfigureAutoForm.BrowserDir);
    IniFile.WriteString('Last', 'MailDir',             ConfigureAutoForm.MailDir);
    IniFile.WriteString('Last', 'NewsDir',             ConfigureAutoForm.NewsDir);
    if SavePWCheckBox.Checked then begin
        IniFile.WriteString('Last', '   Password', EnCrypt(PasswordEdit.Text));
        IniFile.WriteString('Last',     'SavePW',  '1');
        EntryName := CrunchName(Trim(EntryNameComboBox.Text));
        UserName  := CrunchName(Trim(UserNameComboBox.Text));
        if (UserName <> '') and (EntryName <> '') then
            IniFile.WriteString('RAS_ENTRY_' + EntryName,
                                'USER_' + UserName,
                                EnCrypt(PasswordEdit.Text));
    end
    else begin
        IniFile.WriteString('Last',     'Password', '');
        IniFile.WriteString('Last',     'SavePW',   '0');
    end;

    IniFile.Free;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.ConnectButtonClick(Sender: TObject);
begin
    DoConnect;
end;

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.DoConnect;
begin
    SaveSettings;
    InfoListBox.Clear;
    Caption := ProgName + ' - Dialing';
    TimeAutoForm.Section := 'RAS_ENTRY_' + CrunchName(EntryNameComboBox.Text);
    if not TimeAutoForm.Check then begin
        LogMessage('Time Restriction Apply');
        Disconnected;
        Exit;
    end;
    DialingServer   := EntryNameComboBox.Text;
    DialingUserName := UserNameComboBox.Text;
    DialingPassword := PasswordEdit.Text;
    Dial(DialingServer, DialingUserName, DialingPassword);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    CheckTimer.Enabled    := FALSE;
    inherited;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
    Status  : Integer;
begin
    SaveSettings;

    if hRasConn <> 0 then begin
        Status := Application.MEssageBox('Disconnect before exit ?',
                                         'Warning',
                                         MB_YESNOCANCEL);
        if Status = IDCANCEL then begin
            CanClose := FALSE;
            Exit;
        end;
        if Status = IDOK then begin
            RasHangUpA(hRasConn);
            hRasConn := 0;
        end;
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.CancelButtonClick(Sender: TObject);
begin
    DoCancel;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.DoCancel;
begin
    if ConnectTime = 0 then
        LogMessage('Canceled')
    else begin
        LogMessage('Disconnecting');
        DoDuration;
    end;

    Disconnected;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function Encrypt(S : String) : String;
type
    PWORD = ^WORD;
var
    Len    : Integer;
    I      : Integer;
    V      : DWORD;
    P      : PChar;
    Buffer : String[255];
begin
    Buffer := S;
    Len := Length(Buffer) + 1;
    if (Len mod 2) <> 0 then
        Inc(Len);

    if Len < 10 then
        Len := 10;

    I := Length(Buffer);
    if I = 0 then
        Buffer := IntToStr(GetTickCount)
    else
        while Length(Buffer) < 10 do
            Buffer := Buffer + Buffer;
    SetLength(Buffer, I);

    Result := '';
    P := PChar(@Buffer[0]);
    for I := 1 to Len div 2 do begin
        V := 34567 + PWORD(P)^;
        P := P + 2;
        Result := Result + Format('%5.5d', [V]);
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function Decrypt(S : String) : String;
type
    PWORD = ^WORD;
var
    Buffer : String;
    PW  : String[255];
    P   : PWORD;
    I   : Integer;
    V   : Integer;
begin
    PW := '                                   ';
    P := PWORD(@PW[0]);
    I := 1;
    while I <= Length(S) do begin
        Buffer := Copy(S, I, 5);
        I   := I + 5;
        V   := StrToInt(Buffer) - 34567;
        P^  := V;
        Inc(P);
    end;
    Result := PW;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.GetActiveConn;
var
    dwRet    : DWORD;
    nCB      : DWORD;
    Buf      : array [0..255] of Char;
begin
    aRasConn[0].dwSize := SizeOf(aRasConn[0]);
    nCB   := SizeOf(aRasConn);
    dwRet := RasEnumConnectionsA(@aRasConn, @nCB, @nRasConnCount);
    if dwRet <> 0 then begin
        RasGetErrorStringA(dwRet, @Buf[0], SizeOf(Buf));
        LogMessage(Buf);
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function TRasDialerForm.GetActiveConnHandle(szName : String) : THRASCONN;
var
    I : Integer;
begin
    GetActiveConn;
    if nRasConnCount > 0 then begin
        for I := 0 to nRasConnCount - 1 do begin
            if StrIComp(PChar(szName), aRasConn[I].szEntryName) = 0 then begin
                Result := aRasConn[I].hRasConn;
                Exit;
            end;
        end;
    end;
    Result := 0;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.DisplayActiveConn;
var
    I : Integer;
begin
    if nRasConnCount > 0 then begin
        LogMessage(IntToStr(nRasConnCount) + ' Existing connections');
        for I := 0 to nRasConnCount - 1 do
            LogMessage(aRasConn[I].szEntryName);
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.FormShow(Sender: TObject);
var
  FirstTime : Boolean;
  IniFile   : TIniFile;
  SavePW    : String;
  AutoPW    : String;
  AutoFlag  : String;
  EntryName : String;
begin
  inherited;

  FirstTime:=TRUE;
  if FirstTime then
  begin
    FirstTime:=FALSE;
    Caption:=ProgName;
    AboutForm.ProgNameLabel.Caption:=ProgName+' '+ProgVer;
    LoadPhoneBook;
    IniFile:=TIniFile.Create(FIniFileName);
    EntryName:=IniFile.ReadString('Last','EntryName','');
    SelectPhoneBookEntry(EntryName);
    UserNameComboBox.Text:=IniFile.ReadString('Last','UserName','');
    AutoPW:=IniFile.ReadString('Last','AutoPW','1');
    ConfigureAutoForm.AutoPassword:=(AutoPW<>'0');
    AutoFlag:=IniFile.ReadString('Last','AutoUN','1');
    ConfigureAutoForm.AutoUserName:=(AutoFlag<>'0');
    AutoFlag:=IniFile.ReadString('Last','AutoConnect','0');
    ConfigureAutoForm.AutoConnect:=(AutoFlag<>'0');
    AutoFlag:=IniFile.ReadString('Last','AutoExecuteBrowser','0');
    ConfigureAutoForm.AutoExecuteBrowser:=(AutoFlag<>'0');
    AutoFlag:=IniFile.ReadString('Last','AutoExecuteMail','0');
    ConfigureAutoForm.AutoExecuteMail:=(AutoFlag<>'0');
    AutoFlag:=IniFile.ReadString('Last','AutoExecuteNews','0');
    ConfigureAutoForm.AutoExecuteNews:=(AutoFlag<>'0');
    AutoFlag:=IniFile.ReadString('Last','MonthlyDuration','1');
    ConfigureAutoForm.MonthlyDuration:=(AutoFlag<>'0');
    ConfigureAutoForm.BrowserExe:=IniFile.ReadString('Last','BrowserExe','IEXPLORE.EXE');
    ConfigureAutoForm.MailExe:=IniFile.ReadString('Last','MailExe',
      'EXPLORER.EXE /root,Internet Mail.{89292102-4755-11cf-9DC2-00AA006C2B84}');
    ConfigureAutoForm.NewsExe:=IniFile.ReadString('Last','NewsExe',
            'EXPLORER.EXE /root,Internet News.{89292103-4755-11cf-9DC2-00AA006C2B84}');
    ConfigureAutoForm.BrowserDir:=IniFile.ReadString('Last','BrowserDir','');
    ConfigureAutoForm.MailDir:=IniFile.ReadString('Last','MailDir','');
    ConfigureAutoForm.NewsDir:=IniFile.ReadString('Last','NewsDir','');
    SavePW:= IniFile.ReadString('Last','Password','');
    if SavePW<>'' then
      PasswordEdit.Text:=DeCrypt(SavePW)
    else
      PasswordEdit.Text:='';
    SavePW:=IniFile.ReadString('Last','SavePW','0');
    SavePWCheckBox.Checked:=(SavePW='1');
    IniFile.Free;
    CancelButton.Enabled:=FALSE;
    ConnectButton.Enabled:=TRUE;
    GetActiveConn;
    DisplayActiveConn;
    GetDuration;
    TimeAutoForm.Section:='RAS_ENTRY_'+CrunchName(EntryNameComboBox.Text);
    TimeAutoForm.LoadFromIniFile;
    if ConfigureAutoForm.AutoConnect then
      PostMessage(Handle,WM_AUTOCONNECT,0,0);
  end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.FormResize(Sender: TObject);
begin
  inherited;
  InfoListBox.Height:=ClientHeight-InfoListBox.Top;
  InfoListBox.Width:=ClientWidth;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function CrunchName(S:String):String;
var
  I:Integer;
begin
  Result:='';
  for I:=1 to Length(S) do
  begin
    case S[I] of
      ' ': Result:=Result+'_';
      '=': Result:=Result+'\-';
      '@': Result:=Result+'\A';
      '_': Result:=Result+'\_';
      '\': Result:=Result+'\\';
      else
           Result:=Result+S[I];
    end;
  end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.SelectPhoneBookEntry(EntryName : String);
var
  I:Integer;
begin
  for I:=0 to EntryNameComboBox.Items.Count-1 do
  begin
    if EntryNameComboBox.Items[I]=EntryName then
    begin
      EntryNameComboBox.ItemIndex:=I;
      Exit;
    end;
  end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.LoadPhoneBook;
var
  Entries:array [0..15] of TRASENTRYNAME;
  cb:DWORD;
  cEntries:DWORD;
  dwRet:DWORD;
  Buf: array [0..127] of char;
  I:Integer;
begin
  FillChar(Entries,SizeOf(Entries),0);
  Entries[0].dwSize:=SizeOf(TRASENTRYNAME);
  cb:=SizeOf(Entries);
  cEntries:=0;
  dwRet:=RasEnumEntriesA(NIL,NIL,@Entries[0],@cb,@cEntries);
  if dwRet<>0 then
  begin
    RasGetErrorStringA(dwRet,@Buf[0],SizeOf(Buf));
    LogMessage(Buf);
  end;
  EntryNameComboBox.Items.Clear;
  for I:=0 to cEntries-1 do
    EntryNameComboBox.Items.Add(Entries[I].szEntryName);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.GetUserPassword;
var
    IniFile  : TIniFile;
    Password : String;
    EntryName : String;
    UserName : String;
begin
    if not ConfigureAutoForm.AutoPassword then
        Exit;

    IniFile   := TIniFile.Create(FIniFileName);
    EntryName := CrunchName(Trim(EntryNameComboBox.Text));
    UserName  := CrunchName(Trim(UserNameComboBox.Text));
    Password  := IniFile.ReadString('RAS_ENTRY_' + EntryName,
                                    'USER_' + UserName, '*');
    IniFile.Free;

    if Password <> '*' then
        PasswordEdit.Text := DeCrypt(Password)
    else
        PasswordEdit.Text := '';
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.GetUserNameList;
var
    IniFile : TIniFile;
    List    : TStringList;
    I       : Integer;
    Buffer  : String;
begin
    if not ConfigureAutoForm.AutoUserName then
        Exit;

    List    := TStringList.Create;
    IniFile := TIniFile.Create(FIniFileName);
    IniFile.ReadSection('RAS_ENTRY_' + CrunchName(Trim(EntryNameComboBox.Text)),
                                     List);
    UserNameComboBox.Items.Clear;
    if List.Count > 0 then begin
        for I := 0 to List.Count - 1 do begin
            Buffer := List.Strings[I];
            if Copy(Buffer, 1, 5) = 'USER_' then
                UserNameComboBox.Items.Add(Copy(Buffer, 6, 100));
        end;
        if UserNameComboBox.Items.Count > 0 then
            UserNameComboBox.Text := UserNameComboBox.Items[0];
    end;
    IniFile.Free;
    List.DEstroy;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.EntryNameComboBoxChange(Sender: TObject);
begin
    GetDuration;
    GetUserNameList;
    GetUserPassword;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.UserNameComboBoxChange(Sender: TObject);
begin
    GetUserPassword;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.DoProperties;
var
    dwRet         : DWORD;
    Buf           : Array [0..127] of char;
begin
    dwRet := RasEditPhonebookEntryA(Handle, nil, PChar(EntryNameComboBox.Text));
    if dwRet <> 0 then begin
        RasGetErrorStringA(dwRet, @Buf[0], SizeOf(Buf));
        LogMessage(Buf);
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.DoNew;
var
    EntryName : String;
    dwRet     : DWORD;
    Buf       : Array [0..127] of char;
begin
    dwRet := RasCreatePhonebookEntryA(Handle, nil);
    if dwRet <> 0 then begin
        RasGetErrorStringA(dwRet, @Buf[0], SizeOf(Buf));
        LogMessage(Buf);
    end
    else begin
        EntryName := EntryNameCombobox.Text;
        LoadPhoneBook;
        SelectPhoneBookEntry(EntryName);
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.MnuQuitClick(Sender: TObject);
begin
    Close;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.MnuConnectClick(Sender: TObject);
begin
    DoConnect;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.MnuPropertiesClick(Sender: TObject);
begin
    DoProperties;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.MnuNewClick(Sender: TObject);
begin
    DoNew;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.MnuAboutClick(Sender: TObject);
begin
    AboutForm.ShowModal;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.MnuCancelClick(Sender: TObject);
begin
    DoCancel;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.MnuConfigureClick(Sender: TObject);
begin
    DoConfigure;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.DoConfigure;
begin
    ConfigureAutoForm.Configure;
    GetDuration;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.RunInternetNewsReader1Click(Sender: TObject);
begin
    ConfigureAutoForm.ExecuteNews;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.RunInternetBrowser1Click(Sender: TObject);
begin
    ConfigureAutoForm.ExecuteBrowser;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.RunInternetMailReader1Click(Sender: TObject);
begin
    ConfigureAutoForm.ExecuteMail;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.TimeRestrictions1Click(Sender: TObject);
begin
    inherited;
    with TimeAutoForm do begin
        Section := 'RAS_ENTRY_' + CrunchName(EntryNameComboBox.Text);
        Execute;
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TRasDialerForm.IPButtonClick(Sender: TObject);
var
    IPAddr : String;
begin
    IPAddr := RasGetIPAddress;
    if IPAddr > '' then
        InfoListBox.Items.Add('IP=' + IPAddr)
    else
        InfoListBox.Items.Add('IP unknown');
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

end.

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

