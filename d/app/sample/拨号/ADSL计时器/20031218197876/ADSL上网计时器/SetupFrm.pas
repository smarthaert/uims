//============================================================================//
//                          作者:沈杰                                         //
//                          2003-03-17 0:05                                   //
//                          ADSL计时器选项单元                                //
//               考虑到速度，现在改用直接写设置进入INI文件                    //
//                                                                            //
//============================================================================//
unit SetupFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ADSLStringRes, INIFiles;

type
  TFrmSetup = class(TForm)
    lblJF: TLabel;
    edtJFDate: TEdit;
    udnMonthTime: TUpDown;
    lblMonthTime: TLabel;
    edtTimeLimit: TEdit;
    udnTimeLimit: TUpDown;
    lblHour1: TLabel;
    lblDateLimit: TLabel;
    edtDateLimit: TEdit;
    udnDateLimit: TUpDown;
    lblHour2: TLabel;
    gbxOther: TGroupBox;
    cbxDropTransparency: TCheckBox;
    gbxOverTime: TGroupBox;
    cbxSound: TCheckBox;
    cbxForm: TCheckBox;
    gbxSound: TGroupBox;
    cbxDefaultSound: TCheckBox;
    Label1: TLabel;
    edtSoundPath: TEdit;
    btnOpenSound: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    btnDefault: TButton;
    OpenDialog1: TOpenDialog;
    procedure cbxSoundClick(Sender: TObject);
    procedure cbxDefaultSoundClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDefaultClick(Sender: TObject);
    procedure btnOpenSoundClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSetup: TFrmSetup;

implementation

{$R *.dfm}

procedure TFrmSetup.cbxSoundClick(Sender: TObject);
begin
  if cbxSound.Checked then
    gbxSound.Enabled :=cbxSound.Checked
  else
    gbxSound.Enabled :=False;
end;

procedure TFrmSetup.cbxDefaultSoundClick(Sender: TObject);
begin
  if cbxDefaultSound.Checked = False then
  begin
    btnOpenSound.Enabled :=True;
    edtSoundPath.Enabled :=True;
  end
  else begin
    btnOpenSound.Enabled :=False;
    edtSoundPath.Enabled :=False;
  end;
end;

procedure TFrmSetup.btnOKClick(Sender: TObject);
var
  fINI :TINIFile;
begin
  fINI :=TINIFile.Create(Path + 'ADSL.ini');
  fINI.WriteString('Setup', 'Start', edtJFDate.Text);
  fINI.WriteString('Setup', 'MonthDate', edtTimeLimit.Text);
  fINI.WriteString('Setup', 'Date', edtDateLimit.Text);
  fINI.WriteBool('Setup', 'DropTrans', cbxDropTransparency.Checked);
  fINI.WriteBool('Setup', 'Sound', cbxSound.Checked);
  fINI.WriteBool('Setup', 'Form', cbxForm.Checked);
  fINI.WriteBool('Setup', 'DefaultSound', cbxDefaultSound.Checked);
  fINI.WriteString('Setup', 'SoundPath', edtSoundPath.Text);
  fINI.Free ;
  Close;
end;

procedure TFrmSetup.FormCreate(Sender: TObject);
var
  fINI :TINIFile;
begin
  fINI :=TINIFile.Create(Path + 'ADSL.ini');
  udnMonthTime.Position :=StrToInt(fINI.ReadString('Setup', 'Start', '21'));
  udnTimeLimit.Position :=StrToInt(fINI.ReadString('Setup', 'Start', '120'));
  udnDateLimit.Position :=StrToInt(fINI.ReadString('Setup', 'Date', '5'));
  cbxDropTransparency.Checked :=fINI.ReadBool('Setup', 'DropTrans', True);
  cbxSound.Checked :=fINI.ReadBool('Setup', 'Sound', False);
  cbxForm.Checked :=fINI.ReadBool('Setup', 'Form', True);
  cbxDefaultSound.Checked :=fINI.ReadBool('Setup', 'DefaultSound', True);
  edtSoundPath.Text :=fINI.ReadString('Setup', 'SoundPath', '');
end;

procedure TFrmSetup.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmSetup.btnDefaultClick(Sender: TObject);
begin
  udnMonthTime.Position :=21;
  udnTimeLimit.Position :=120;
  udnDateLimit.Position :=5;
  cbxDropTransparency.Checked :=True;
  cbxSound.Checked :=False;
  cbxForm.Checked :=True;
  cbxDefaultSound.Checked :=True;
  gbxSound.Enabled :=False;
  edtSoundPath.Enabled :=False;
  btnOpenSound.Enabled :=False;
end;

procedure TFrmSetup.btnOpenSoundClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    edtSoundPath.Text :=OpenDialog1.FileName ;
end;

end.
