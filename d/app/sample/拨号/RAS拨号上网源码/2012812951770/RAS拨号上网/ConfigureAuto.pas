{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

Copyright: François Piette
           This program can be used/modified freely provided this copyright
           notice remains here. If you like my code, find any bug or
           improve it, please feels free to let me know by sending an EMail at
           francois.piette@ping.be or francois.piette@f2202.n293.z2.fidonet.org


 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
unit ConfigureAuto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Formauto, StdCtrls, ShellApi, RasDial4;

type
  TConfigureAutoForm = class(TAutoForm)
    OkButton: TButton;
    CancelButton: TButton;
    AutoPasswordCheckBox: TCheckBox;
    AutoUserNameCheckBox: TCheckBox;
    GroupBox1: TGroupBox;
    AutoExecuteBrowserCheckBox: TCheckBox;
    BrowserExeEdit: TEdit;
    BrowserDirEdit: TEdit;
    GroupBox2: TGroupBox;
    AutoExecuteMailCheckBox: TCheckBox;
    MailExeEdit: TEdit;
    MailDirEdit: TEdit;
    GroupBox3: TGroupBox;
    AutoExecuteNewsCheckBox: TCheckBox;
    NewsExeEdit: TEdit;
    NewsDirEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    AutoConnectCheckBox: TCheckBox;
    MonthlyDurationCheckBox: TCheckBox;
    procedure CancelButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure AutoExecuteBrowserCheckBoxClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    function  GetAutoUserName : Boolean;
    procedure SetAutoUserName(newValue : Boolean);
    function  GetAutoConnect : Boolean;
    procedure SetAutoConnect(newValue : Boolean);
    function  GetAutoPassword : Boolean;
    procedure SetAutopassword(newValue : Boolean);
    function  GetAutoExecuteBrowser : Boolean;
    function  GetAutoExecuteMail : Boolean;
    function  GetAutoExecuteNews : Boolean;
    procedure SetAutoExecuteBrowser(newValue : Boolean);
    procedure SetAutoExecuteMail(newValue : Boolean);
    procedure SetAutoExecuteNews(newValue : Boolean);
    function  GetMonthlyDuration : Boolean;
    procedure SetMonthlyDuration(newValue : Boolean);
    function  GetBrowserExe : String;
    function  GetMailExe : String;
    function  GetNewsExe : String;
    function  GetBrowserDir : String;
    function  GetMailDir : String;
    function  GetNewsDir : String;
    procedure SetBrowserExe(newValue : String);
    procedure SetMailExe(newValue : String);
    procedure SetNewsExe(newValue : String);
    procedure SetBrowserDir(newValue : String);
    procedure SetMailDir(newValue : String);
    procedure SetNewsDir(newValue : String);
    procedure ExecuteProg(Exe, Dir : String);
  public
    { Public declarations }
    procedure Configure;
    procedure ExecuteBrowser;
    procedure ExecuteMail;
    procedure ExecuteNews;
    procedure ExecuteBrowserAuto;
    procedure ExecuteMailAuto;
    procedure ExecuteNewsAuto;
    property AutoConnect : Boolean  read GetAutoConnect  write SetAutoConnect;
    property AutoUserName : Boolean read GetAutoUserName write SetAutoUserName;
    property AutoPassword : Boolean read GetAutoPassword write SetAutopassword;
    property AutoExecuteBrowser : Boolean read GetAutoExecuteBrowser write SetAutoExecuteBrowser;
    property AutoExecuteMail : Boolean read GetAutoExecuteMail write SetAutoExecuteMail;
    property AutoExecuteNews : Boolean read GetAutoExecuteNews write SetAutoExecuteNews;
    property MonthlyDuration : Boolean read GetMonthlyDuration write SetMonthlyDuration;
    property BrowserExe : String             read GetBrowserExe write SetBrowserExe;
    property MailExe : String                read GetMailExe    write SetMailExe;
    property NewsExe : String                read GetNewsExe    write SetNewsExe;
    property BrowserDir : String             read GetBrowserDir write SetBrowserDir;
    property MailDir : String                read GetMailDir    write SetMailDir;
    property NewsDir : String                read GetNewsDir    write SetNewsDir;
  end;

var
  ConfigureAutoForm: TConfigureAutoForm;

implementation

{$R *.DFM}


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.Configure;
var
    OldAutoConnect     : Boolean;
    OldAutoPassword    : Boolean;
    OldAutoUserName    : Boolean;
    OldExecuteBrowser  : Boolean;
    OldExecuteMail     : Boolean;
    OldExecuteNews     : Boolean;
    OldMonthlyDuration : Boolean;
    OldBrowserExe      : String;
    OldBrowserDir      : String;
    OldMailExe         : String;
    OldMailDir         : String;
    OldNewsExe         : String;
    OldNewsDir         : String;
begin
    OldAutoConnect     := AutoConnectCheckBox.Checked;
    OldAutoPassword    := AutoPasswordCheckBox.Checked;
    OldAutoUserName    := AutoUserNameCheckBox.Checked;
    OldExecuteBrowser  := AutoExecuteBrowserCheckBox.Checked;
    OldExecuteMail     := AutoExecuteMailCheckBox.Checked;
    OldExecuteNews     := AutoExecuteNewsCheckBox.Checked;
    OldMonthlyDuration := MonthlyDurationCheckBox.Checked;
    OldBrowserExe      := BrowserExeEdit.Text;
    OldBrowserDir      := BrowserDirEdit.Text;
    OldMailExe         := MailExeEdit.Text;
    OldMailDir         := MailDirEdit.Text;
    OldNewsExe         := NewsExeEdit.Text;
    OldNewsDir         := NewsDirEdit.Text;

    if ShowModal <> mrOk then begin
        AutoConnectCheckBox.Checked        := OldAutoConnect;
        AutoPasswordCheckBox.Checked       := OldAutoPassword;
        AutoUserNameCheckBox.Checked       := OldAutoUserName;
        AutoExecuteBrowserCheckBox.Checked := OldExecuteBrowser;
        AutoExecuteMailCheckBox.Checked    := OldExecuteMail;
        AutoExecuteNewsCheckBox.Checked    := OldExecuteNews;
        MonthlyDurationCheckBox.Checked    := OldMonthlyDuration;
        BrowserExeEdit.Text                := OldBrowserExe;
        BrowserDirEdit.Text                := OldBrowserDir;
        MailExeEdit.Text                   := OldMailExe;
        MailDirEdit.Text                   := OldMailDir;
        NewsExeEdit.Text                   := OldNewsExe;
        NewsDirEdit.Text                   := OldNewsDir;
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    inherited;
    if ModalResult <> mrOk then begin
        if Application.MessageBox('Quit without saving ?', 'Warning',
                                  mb_YESNO + mb_DEFBUTTON2) <> IDYES then
            canClose := FALSE;
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function TConfigureAutoForm.GetBrowserExe : String;
begin
    Result := Trim(BrowserExeEdit.Text);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function TConfigureAutoForm.GetMailExe : String;
begin
    Result := Trim(MailExeEdit.Text);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function TConfigureAutoForm.GetNewsExe : String;
begin
    Result := Trim(NewsExeEdit.Text);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function TConfigureAutoForm.GetBrowserDir : String;
begin
    Result := Trim(BrowserDirEdit.Text);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function TConfigureAutoForm.GetMailDir : String;
begin
    Result := Trim(MailDirEdit.Text);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function TConfigureAutoForm.GetNewsDir : String;
begin
    Result := Trim(NewsDirEdit.Text);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.SetBrowserExe(newValue : String);
begin
    BrowserExeEdit.Text := newValue;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.SetNewsExe(newValue : String);
begin
    NewsExeEdit.Text := newValue;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.SetMailExe(newValue : String);
begin
    MailExeEdit.Text := newValue;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.SetBrowserDir(newValue : String);
begin
    BrowserDirEdit.Text := newValue;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.SetNewsDir(newValue : String);
begin
    NewsDirEdit.Text := newValue;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.SetMailDir(newValue : String);
begin
    MailDirEdit.Text := newValue;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function TConfigureAutoForm.GetMonthlyDuration : Boolean;
begin
    Result := MonthlyDurationCheckBox.Checked;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.SetMonthlyDuration(newValue : Boolean);
begin
    MonthlyDurationCheckBox.Checked := newValue;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function TConfigureAutoForm.GetAutoExecuteBrowser : Boolean;
begin
    Result := AutoExecuteBrowserCheckBox.Checked;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function TConfigureAutoForm.GetAutoExecuteMail : Boolean;
begin
    Result := AutoExecuteMailCheckBox.Checked;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function TConfigureAutoForm.GetAutoExecuteNews : Boolean;
begin
    Result := AutoExecuteNewsCheckBox.Checked;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.SetAutoExecuteBrowser(newValue : Boolean);
begin
    AutoExecuteBrowserCheckBox.Checked := newValue;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.SetAutoExecuteMail(newValue : Boolean);
begin
    AutoExecuteMailCheckBox.Checked := newValue;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.SetAutoExecuteNews(newValue : Boolean);
begin
    AutoExecuteNewsCheckBox.Checked := newValue;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function TConfigureAutoForm.GetAutoUserName : Boolean;
begin
    Result := AutoUserNameCheckBox.Checked;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.SetAutoUserName(newValue : Boolean);
begin
    AutoUserNameCheckBox.Checked := newValue;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function TConfigureAutoForm.GetAutoConnect : Boolean;
begin
    Result := AutoConnectCheckBox.Checked;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.SetAutoConnect(newValue : Boolean);
begin
    AutoConnectCheckBox.Checked := newValue;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function TConfigureAutoForm.GetAutoPassword : Boolean;
begin
    Result := AutoPasswordCheckBox.Checked;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.SetAutopassword(newValue : Boolean);
begin
    AutoPasswordCheckBox.Checked := newValue;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.CancelButtonClick(Sender: TObject);
begin
    inherited;
    ModalResult := mrCancel;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.OkButtonClick(Sender: TObject);
begin
    inherited;
    ModalResult := mrOk;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.AutoExecuteBrowserCheckBoxClick(
  Sender: TObject);
begin
    SetAutoExecuteBrowser(AutoExecuteBrowserCheckBox.Checked);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.ExecuteBrowser;
begin
    ExecuteProg(BrowserExeEdit.Text, BrowserDirEdit.Text);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.ExecuteMail;
begin
    ExecuteProg(MailExeEdit.Text, MailDirEdit.Text);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.ExecuteNews;
begin
    ExecuteProg(NewsExeEdit.Text, NewsDirEdit.Text);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.ExecuteBrowserAuto;
begin
    if AutoExecuteBrowserCheckBox.Checked then
        ExecuteBrowser;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.ExecuteMailAuto;
begin
    if AutoExecuteNewsCheckBox.Checked then
    ExecuteMail;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.ExecuteNewsAuto;
begin
    if AutoExecuteNewsCheckBox.Checked then
        ExecuteNews;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TConfigureAutoForm.ExecuteProg(Exe, Dir : String);
var
    ExeName : String;
    Params  : String;
    I       : Integer;
    Status  : Integer;
    Msg     : String;
begin
    if Exe[1] = '"' then begin
        I := 2;
        while (I <= Length(Exe)) and (Exe[I] <> '"') do
            Inc(I);
        Params  := Trim(Copy(Exe, I + 1, Length(Exe)));
        ExeName := Trim(Copy(Exe, 2, I - 2));
    end
    else begin
        I := 1;
        while (I <= Length(Exe)) and
              not (Exe[I] in ['/', '*', '?', '"', '<', '>', '|']) do
            Inc(I);
        Params  := Trim(Copy(Exe, I, Length(Exe)));
        ExeName := Trim(Copy(Exe, 1, I - 1));
    end;

    Status := ShellExecute(Handle, 'open', PChar(ExeName),
                           PChar(Params), PChar(Dir), SW_SHOWNORMAL);
    if Status > 32 then
        Exit;

    case Status of
    0                      : Msg := 'The operating system is out of memory ' +
                                    'or resources.';
    ERROR_FILE_NOT_FOUND   : Msg := 'The specified file was not found.';
    ERROR_PATH_NOT_FOUND   : Msg := 'The specified path was not found.';
    ERROR_BAD_FORMAT	   : Msg := 'The .EXE file is invalid (non-Win32 ' +
                                    '.EXE or error in .EXE image).';
    SE_ERR_ACCESSDENIED	   : Msg := 'The operating system denied access to ' +
                                    'the specified file.';
    SE_ERR_ASSOCINCOMPLETE : Msg := 'The filename association is incomplete ' +
                                    'or invalid.';
    SE_ERR_DDEBUSY	   : Msg := 'The DDE transaction could not be ' +
                                    'completed because other DDE ' +
                                    'transactions were being processed.';
    SE_ERR_DDEFAIL	   : Msg := 'The DDE transaction failed.';
    SE_ERR_DDETIMEOUT	   : Msg := 'The DDE transaction could not be ' +
                                    'completed because the request timed out.';
    SE_ERR_DLLNOTFOUND	   : Msg := 'The specified dynamic-link library was ' +
                                    'not found.';
    SE_ERR_NOASSOC	   : Msg := 'There is no application associated with ' +
                                    'the given filename extension.';
    SE_ERR_OOM	           : Msg := 'There was not enough memory to complete ' +
                                    'the operation.';
    SE_ERR_SHARE	   : Msg := 'A sharing violation occurred.';
    else
                             Msg := 'ShellExecute failed with error #' +
                                    IntToStr(Status);
    end;
    MessageBeep(MB_OK);
    Msg := Msg + #10 + 'trying to execute ''' + Exe + '''';
    Application.MessageBox(PChar(Msg), 'Warning', MB_OK);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

end.

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
