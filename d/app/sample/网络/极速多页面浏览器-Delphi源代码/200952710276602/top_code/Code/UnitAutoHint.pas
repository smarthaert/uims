unit UnitAutoHint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons,
  IniFiles, ShellAPI,
  TLHelp32;

type
  TFormAutoHint = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    CBH1: TComboBox;
    Label5: TLabel;
    CBM1: TComboBox;
    Label6: TLabel;
    Memo1: TMemo;
    Timer1: TTimer;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    CBH2: TComboBox;
    CBM2: TComboBox;
    Memo2: TMemo;
    Panel3: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    CBH3: TComboBox;
    CBM3: TComboBox;
    Memo3: TMemo;
    Panel4: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    CBH4: TComboBox;
    CBM4: TComboBox;
    Memo4: TMemo;
    Panel5: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    CBH5: TComboBox;
    CBM5: TComboBox;
    Memo5: TMemo;
    Panel6: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    CBH6: TComboBox;
    CBM6: TComboBox;
    Memo6: TMemo;
    Panel7: TPanel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    CBH7: TComboBox;
    CBM7: TComboBox;
    Memo7: TMemo;
    Label_1: TLabel;
    Label_2: TLabel;
    Label_3: TLabel;
    Label_4: TLabel;
    Label_5: TLabel;
    Label_6: TLabel;
    Label_7: TLabel;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox5: TCheckBox;
    TabSheetShutDown: TTabSheet;
    Panel8: TPanel;
    GroupBox3: TGroupBox;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    LTime: TLabel;
    CBHour1: TComboBox;
    CBHour2: TComboBox;
    CBMinute1: TComboBox;
    CBMinute2: TComboBox;
    PanelShutDown: TPanel;
    TimerShutDown: TTimer;
    Label29: TLabel;
    LabelShutDown: TLabel;
    BShutDown1: TSpeedButton;
    BCancelShutDown: TSpeedButton;
    TimerShutDownTo: TTimer;
    LBProcess: TListBox;
    ListBoxProcess: TListBox;
    ButtonKillProcess: TButton;
    Label30: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CBH1Change(Sender: TObject);
    procedure CBH2Change(Sender: TObject);
    procedure CBH3Change(Sender: TObject);
    procedure CBH4Change(Sender: TObject);
    procedure CBH5Change(Sender: TObject);
    procedure CBH6Change(Sender: TObject);
    procedure CBH7Change(Sender: TObject);
    procedure CBM1Change(Sender: TObject);
    procedure CBM2Change(Sender: TObject);
    procedure CBM3Change(Sender: TObject);
    procedure CBM4Change(Sender: TObject);
    procedure CBM5Change(Sender: TObject);
    procedure CBM6Change(Sender: TObject);
    procedure CBM7Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBox6Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CBHour1Change(Sender: TObject);
    procedure CBMinute1Change(Sender: TObject);
    procedure CBHour2Change(Sender: TObject);
    procedure CBMinute2Change(Sender: TObject);
    procedure TimerShutDownTimer(Sender: TObject);
    procedure TimerShutDownToTimer(Sender: TObject);
    procedure ButtonKillProcessClick(Sender: TObject);
    procedure BShutDown1Click(Sender: TObject);
    procedure BCancelShutDownClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAutoHint: TFormAutoHint;
  ShutDownOK1, ShutDownOK2: Boolean;
  ShutDownTime: Word = 41;

implementation

uses var_, const_, Public, UnitMain, UnitHintShow;

{$R *.dfm}

procedure TFormAutoHint.FormCreate(Sender: TObject);
var
  IniFile:TIniFile;
begin
try
  if AutoHintReadOK then exit;
  try
  if not DirectoryExists(MyDir+AutoHintDir) then MkDir(MyDir+AutoHintDir);
  AutoHintFile := MyDir + AutoHintDir + GetDateTime2(1) + GetDateTime2(2) + GetDateTime2(3) + '.txt';
  HintStaticFile := MyDir + AutoHintDir + 'StaticHint.ini';
  //ShowMessage(HintStaticFile);
  if FileExists(AutoHintFile) then
  begin
    AutoHintReadOK := true;
    IniFile := TIniFile.Create(AutoHintFile);
    CBH1.Text := IniFile.ReadString('Data','CBH1','');
    CBM1.Text := IniFile.ReadString('Data','CBM1','');
    Memo1.Text := IniFile.ReadString('Data','Memo1','');

    CBH2.Text := IniFile.ReadString('Data','CBH2','');
    CBM2.Text := IniFile.ReadString('Data','CBM2','');
    Memo2.Text := IniFile.ReadString('Data','Memo2','');
    CBH3.Text := IniFile.ReadString('Data','CBH3','');
    CBM3.Text := IniFile.ReadString('Data','CBM3','');
    Memo3.Text := IniFile.ReadString('Data','Memo3','');
    CBH4.Text := IniFile.ReadString('Data','CBH4','');
    CBM4.Text := IniFile.ReadString('Data','CBM4','');
    Memo4.Text := IniFile.ReadString('Data','Memo4','');
    CBH5.Text := IniFile.ReadString('Data','CBH5','');
    CBM5.Text := IniFile.ReadString('Data','CBM5','');
    Memo5.Text := IniFile.ReadString('Data','Memo5','');
    CBH6.Text := IniFile.ReadString('Data','CBH6','');
    CBM6.Text := IniFile.ReadString('Data','CBM6','');
    Memo6.Text := IniFile.ReadString('Data','Memo6','');
    CBH7.Text := IniFile.ReadString('Data','CBH7','');
    CBM7.Text := IniFile.ReadString('Data','CBM7','');
    Memo7.Text := IniFile.ReadString('Data','Memo7','');

    IniFile.Free;
  end;
  finally

  if FileExists(HintStaticFile) then
  begin
    IniFile := TIniFile.Create(HintStaticFile);
    try
    if IniFile.ReadString('Data','Static5','0') = '1' then
    begin
      CBH5.Text := IniFile.ReadString('Data','CBH5','');
      CBM5.Text := IniFile.ReadString('Data','CBM5','');
      Memo5.Text := IniFile.ReadString('Data','Memo5','');
      CheckBox5.Checked := true;
    end;
    if IniFile.ReadString('Data','Static6','0') = '1' then
    begin
      CBH6.Text := IniFile.ReadString('Data','CBH6','');
      CBM6.Text := IniFile.ReadString('Data','CBM6','');
      Memo6.Text := IniFile.ReadString('Data','Memo6','');
      CheckBox6.Checked := true;
    end;
    if IniFile.ReadString('Data','Static7','0') = '1' then
    begin
      CBH7.Text := IniFile.ReadString('Data','CBH7','');
      CBM7.Text := IniFile.ReadString('Data','CBM7','');
      Memo7.Text := IniFile.ReadString('Data','Memo7','');
      CheckBox7.Checked := true;
    end;

    CBHour1.Text := IniFile.ReadString('Data','CBHour1','');
    CBMinute1.Text := IniFile.ReadString('Data','CBMinute1','');
    CBHour2.Text := IniFile.ReadString('Data','CBHour2','');
    CBMinute2.Text := IniFile.ReadString('Data','CBMinute2','');
    if (Trim(CBMinute1.Text) <> '') or (Trim(CBMinute2.Text) <> '') then TimerShutDown.Enabled := true;
    
    finally
    IniFile.Free;
    end;
  end;
    {
    Label_1.Caption := 'NO.';
    Label_2.Caption := 'NO.';
    Label_3.Caption := 'NO.';
    Label_4.Caption := 'NO.';
    Label_5.Caption := 'NO.';
    Label_6.Caption := 'NO.';
    Label_7.Caption := 'NO.';
    }
    Timer1.Enabled := true;
  end;
except end;
end;

procedure TFormAutoHint.Timer1Timer(Sender: TObject);
begin
try
  if HintTabOK1 and HintTabOK2 and HintTabOK3 and HintTabOK4 and HintTabOK5 and HintTabOK6 and HintTabOK7 then
  begin
    Timer1.Enabled := false;
    exit;
  end;
  if not HintTabOK1 then
  if (CBH1.Text <> '') and (CBM1.Text <> '') then
  begin
  if (GetDateTime2(4) = CBH1.Text) and (GetDateTime2(5) = CBM1.Text) then
  begin
    HintTabOK1 := true;
    Label_1.Caption := 'OK.';
    FormHintShow.Caption := '提醒: ' + GetDateTime2(4) + ':' + GetDateTime2(5);
    FormHintShow.Memo1.Text := Memo1.Text;
    FormHintShow.Timer1.Enabled := true;
    FormHintShow.Show;
    FormHintShow.Panel1.SetFocus;
  end else if ((StrToInt(GetDateTime2(4)) >= StrToInt(CBH1.Text)) and (StrToInt(GetDateTime2(5)) > StrToInt(CBM1.Text))) then
  begin
    HintTabOK1 := true;
    Label_1.Caption := 'OK.';
  end;
  end else HintTabOK1 := true;
  if not HintTabOK2 then
  if (CBH2.Text <> '') and (CBM2.Text <> '') then
  begin
  if (GetDateTime2(4) = CBH2.Text) and (GetDateTime2(5) = CBM2.Text) then
  begin
    HintTabOK2 := true;
    Label_2.Caption := 'OK.';
    FormHintShow.Caption := '提醒: ' + GetDateTime2(4) + ':' + GetDateTime2(5);
    FormHintShow.Memo1.Text := Memo2.Text;
    FormHintShow.Timer1.Enabled := true;
    FormHintShow.Show;
    FormHintShow.Panel1.SetFocus;
  end else if ((StrToInt(GetDateTime2(4)) >= StrToInt(CBH2.Text)) and (StrToInt(GetDateTime2(5)) > StrToInt(CBM2.Text))) then
  begin
    HintTabOK2 := true;
    Label_2.Caption := 'OK.';
  end;
  end else HintTabOK2 := true;
  if not HintTabOK3 then
  if (CBH3.Text <> '') and (CBM3.Text <> '') then
  begin
  if (GetDateTime2(4) = CBH3.Text) and (GetDateTime2(5) = CBM3.Text) then
  begin
    HintTabOK3 := true;
    Label_3.Caption := 'OK.';
    FormHintShow.Caption := '提醒: ' + GetDateTime2(4) + ':' + GetDateTime2(5);
    FormHintShow.Memo1.Text := Memo3.Text;
    FormHintShow.Timer1.Enabled := true;
    FormHintShow.Show;
    FormHintShow.Panel1.SetFocus;
  end else if ((StrToInt(GetDateTime2(4)) >= StrToInt(CBH3.Text)) and (StrToInt(GetDateTime2(5)) > StrToInt(CBM3.Text))) then
  begin
    HintTabOK3 := true;
    Label_3.Caption := 'OK.';
  end;
  end  else HintTabOK3 := true;
  if not HintTabOK4 then
  if (CBH4.Text <> '') and (CBM4.Text <> '') then
  begin
  if (GetDateTime2(4) = CBH4.Text) and (GetDateTime2(5) = CBM4.Text) then
  begin
    HintTabOK4 := true;
    Label_4.Caption := 'OK.';
    FormHintShow.Caption := '提醒: ' + GetDateTime2(4) + ':' + GetDateTime2(5);
    FormHintShow.Memo1.Text := Memo4.Text;
    FormHintShow.Timer1.Enabled := true;
    FormHintShow.Show;
    FormHintShow.Panel1.SetFocus;
  end else if ((StrToInt(GetDateTime2(4)) >= StrToInt(CBH4.Text)) and (StrToInt(GetDateTime2(5)) > StrToInt(CBM4.Text))) then
  begin
    HintTabOK4 := true;
    Label_4.Caption := 'OK.';
  end;
  end  else HintTabOK4 := true;

  if not HintTabOK5 then
  if (CBH5.Text <> '') and (CBM5.Text <> '') then
  begin
    //if (FormatDateTime({'yyyy-mm-dd'}'dddd',now) <> '星期六') and (FormatDateTime({'yyyy-mm-dd'}'dddd',now) <> '星期日') then
    if (CheckBox5.Checked) and ((FormatDateTime({'yyyy-mm-dd'}'dddd',now) = '星期六') or (FormatDateTime({'yyyy-mm-dd'}'dddd',now) = '星期日')) then
    HintTabOK5 := true    
    else
    begin                                
      if (GetDateTime2(4) = CBH5.Text) and (GetDateTime2(5) = CBM5.Text) then
      begin
        HintTabOK5 := true;            
        Label_5.Caption := 'OK.';
        FormHintShow.Caption := '提醒: ' + GetDateTime2(4) + ':' + GetDateTime2(5);
        FormHintShow.Memo1.Text := Memo5.Text;
        FormHintShow.Timer1.Enabled := true;
        FormHintShow.Show;
        FormHintShow.Panel1.SetFocus;
      end
      else if ((StrToInt(GetDateTime2(4)) >= StrToInt(CBH5.Text)) and (StrToInt(GetDateTime2(5)) > StrToInt(CBM5.Text))) then
      begin
        HintTabOK5 := true;
        Label_5.Caption := 'OK.';
      end;
    end;
  end else HintTabOK5 := true;

  if not HintTabOK6 then
  if (CBH6.Text <> '') and (CBM6.Text <> '') then
  begin
  if (GetDateTime2(4) = CBH6.Text) and (GetDateTime2(5) = CBM6.Text) then
  begin
    HintTabOK6 := true;
    Label_6.Caption := 'OK.';
    FormHintShow.Caption := '提醒: ' + GetDateTime2(4) + ':' + GetDateTime2(5);
    FormHintShow.Memo1.Text := Memo6.Text;
    FormHintShow.Timer1.Enabled := true;
    FormHintShow.Show;
    FormHintShow.Panel1.SetFocus;
  end else if ((StrToInt(GetDateTime2(4)) >= StrToInt(CBH6.Text)) and (StrToInt(GetDateTime2(5)) > StrToInt(CBM6.Text))) then
  begin
    HintTabOK6 := true;
    Label_6.Caption := 'OK.';
  end;
  end  else HintTabOK6 := true;
  if not HintTabOK7 then                  
  if (CBH7.Text <> '') and (CBM7.Text <> '') then
  begin
  if (GetDateTime2(4) = CBH7.Text) and (GetDateTime2(5) = CBM7.Text) then
  begin
    HintTabOK7 := true;
    Label_7.Caption := 'OK.';
    FormHintShow.Caption := '提醒: ' + GetDateTime2(4) + ':' + GetDateTime2(5);
    FormHintShow.Memo1.Text := Memo7.Text;
    FormHintShow.Timer1.Enabled := true;
    FormHintShow.Show;
    FormHintShow.Panel1.SetFocus;
  end else if ((StrToInt(GetDateTime2(4)) >= StrToInt(CBH7.Text)) and (StrToInt(GetDateTime2(5)) > StrToInt(CBM7.Text))) then
  begin
    HintTabOK7 := true;
    Label_7.Caption := 'OK.';
  end;
  end  else HintTabOK7 := true;
except end;
end;

procedure TFormAutoHint.CBH1Change(Sender: TObject);
begin
try
  HintTabOK1 := false;
  Label_1.Caption := 'NO.';
  WritePrivateProfileString('Data','CBH1',PChar(CBH1.Text),PChar(AutoHintFile));
  //if Length(CBH1.Text) = 2 then CBM1.SetFocus;
except end;
end;

procedure TFormAutoHint.CBH2Change(Sender: TObject);
begin
try
  HintTabOK2 := false;
  Label_2.Caption := 'NO.';
  WritePrivateProfileString('Data','CBH2',PChar(CBH2.Text),PChar(AutoHintFile));
except end;
end;

procedure TFormAutoHint.CBH3Change(Sender: TObject);
begin
try
  HintTabOK3 := false;
  Label_3.Caption := 'NO.';
  WritePrivateProfileString('Data','CBH3',PChar(CBH3.Text),PChar(AutoHintFile));
except end;
end;

procedure TFormAutoHint.CBH4Change(Sender: TObject);
begin
try
  HintTabOK4 := false;
  Label_4.Caption := 'NO.';
  WritePrivateProfileString('Data','CBH4',PChar(CBH4.Text),PChar(AutoHintFile));
except end;
end;

procedure TFormAutoHint.CBH5Change(Sender: TObject);
begin
try
  HintTabOK5 := false;
  Label_5.Caption := 'NO.';
  WritePrivateProfileString('Data','CBH5',PChar(CBH5.Text),PChar(AutoHintFile));
except end;
end;

procedure TFormAutoHint.CBH6Change(Sender: TObject);
begin
try
  HintTabOK6 := false;
  Label_6.Caption := 'NO.';
  WritePrivateProfileString('Data','CBH6',PChar(CBH6.Text),PChar(AutoHintFile));
except end;
end;

procedure TFormAutoHint.CBH7Change(Sender: TObject);
begin
try
  HintTabOK7 := false;
  Label_7.Caption := 'NO.';
  WritePrivateProfileString('Data','CBH7',PChar(CBH7.Text),PChar(AutoHintFile));
except end;
end;

procedure TFormAutoHint.CBM1Change(Sender: TObject);
begin
try
  HintTabOK1 := false;
  Label_1.Caption := 'NO.';
  if not Timer1.Enabled then Timer1.Enabled := true;
  WritePrivateProfileString('Data','CBM1',PChar(CBM1.Text),PChar(AutoHintFile));
except end;
end;

procedure TFormAutoHint.CBM2Change(Sender: TObject);
begin
try
  HintTabOK2 := false;
  Label_2.Caption := 'NO.';
  if not Timer1.Enabled then Timer1.Enabled := true;
  WritePrivateProfileString('Data','CBM2',PChar(CBM2.Text),PChar(AutoHintFile));
except end;
end;

procedure TFormAutoHint.CBM3Change(Sender: TObject);
begin
try
  HintTabOK3 := false;
  Label_3.Caption := 'NO.';
  if not Timer1.Enabled then Timer1.Enabled := true;
  WritePrivateProfileString('Data','CBM3',PChar(CBM3.Text),PChar(AutoHintFile));
except end;
end;

procedure TFormAutoHint.CBM4Change(Sender: TObject);
begin
try
  HintTabOK4 := false;
  Label_4.Caption := 'NO.';
  if not Timer1.Enabled then Timer1.Enabled := true;
  WritePrivateProfileString('Data','CBM4',PChar(CBM4.Text),PChar(AutoHintFile));
except end;
end;

procedure TFormAutoHint.CBM5Change(Sender: TObject);
begin
try
  HintTabOK5 := false;
  Label_5.Caption := 'NO.';
  if not Timer1.Enabled then Timer1.Enabled := true;
  WritePrivateProfileString('Data','CBM5',PChar(CBM5.Text),PChar(AutoHintFile));
except end;
end;

procedure TFormAutoHint.CBM6Change(Sender: TObject);
begin
try
  HintTabOK6 := false;
  Label_6.Caption := 'NO.';
  if not Timer1.Enabled then Timer1.Enabled := true;
  WritePrivateProfileString('Data','CBM6',PChar(CBM6.Text),PChar(AutoHintFile));
except end;
end;

procedure TFormAutoHint.CBM7Change(Sender: TObject);
begin
try
  HintTabOK7 := false;
  Label_7.Caption := 'NO.';
  if not Timer1.Enabled then Timer1.Enabled := true;
  WritePrivateProfileString('Data','CBM7',PChar(CBM7.Text),PChar(AutoHintFile));
except end;
end;

procedure TFormAutoHint.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
try
  try
    AutoHintFile := MyDir + AutoHintDir + GetDateTime2(1) + GetDateTime2(2) + GetDateTime2(3) + '.txt';
    if FileExists(AutoHintFile) then
    begin
    //if FormAutoHint.Memo1.Text <> '' then
    WritePrivateProfileString('Data','Memo1',PChar(FormAutoHint.Memo1.Text),PChar(AutoHintFile));
    //if FormAutoHint.Memo2.Text <> '' then
    WritePrivateProfileString('Data','Memo2',PChar(FormAutoHint.Memo2.Text),PChar(AutoHintFile));
    //if FormAutoHint.Memo3.Text <> '' then
    WritePrivateProfileString('Data','Memo3',PChar(FormAutoHint.Memo3.Text),PChar(AutoHintFile));
    //if FormAutoHint.Memo4.Text <> '' then
    WritePrivateProfileString('Data','Memo4',PChar(FormAutoHint.Memo4.Text),PChar(AutoHintFile));
    //if FormAutoHint.Memo5.Text <> '' then
    WritePrivateProfileString('Data','Memo5',PChar(FormAutoHint.Memo5.Text),PChar(AutoHintFile));
    //if FormAutoHint.Memo6.Text <> '' then
    WritePrivateProfileString('Data','Memo6',PChar(FormAutoHint.Memo6.Text),PChar(AutoHintFile));
    //if FormAutoHint.Memo7.Text <> '' then
    WritePrivateProfileString('Data','Memo7',PChar(FormAutoHint.Memo7.Text),PChar(AutoHintFile));
    end;
    if FormAutoHint.CheckBox6.Checked then
    begin
      WritePrivateProfileString('Data','Static6','1',PChar(HintStaticFile));
      WritePrivateProfileString('Data','CBH6',PChar(FormAutoHint.CBH6.Text),PChar(HintStaticFile));
      WritePrivateProfileString('Data','CBM6',PChar(FormAutoHint.CBM6.Text),PChar(HintStaticFile));
      WritePrivateProfileString('Data','Memo6',PChar(FormAutoHint.Memo6.Text),PChar(HintStaticFile));
    end;
    if FormAutoHint.CheckBox7.Checked then
    begin
      WritePrivateProfileString('Data','Static7','1',PChar(HintStaticFile));
      WritePrivateProfileString('Data','CBH7',PChar(FormAutoHint.CBH7.Text),PChar(HintStaticFile));
      WritePrivateProfileString('Data','CBM7',PChar(FormAutoHint.CBM7.Text),PChar(HintStaticFile));
      WritePrivateProfileString('Data','Memo7',PChar(FormAutoHint.Memo7.Text),PChar(HintStaticFile));
    end;
  finally
    Hide;
  end;
except end;
end;

procedure TFormAutoHint.CheckBox6Click(Sender: TObject);
begin
try
  if CheckBox6.Checked then
  begin
  try
  WritePrivateProfileString('Data','CBH6',PChar(CBH6.Text),PChar(HintStaticFile));
  WritePrivateProfileString('Data','CBM6',PChar(CBM6.Text),PChar(HintStaticFile));
  WritePrivateProfileString('Data','Memo6',PChar(Memo6.Text),PChar(HintStaticFile));
  finally
  WritePrivateProfileString('Data','Static6','1',PChar(HintStaticFile));
  end;
  end
  else
  WritePrivateProfileString('Data','Static6','0',PChar(HintStaticFile));
except end;
end;

procedure TFormAutoHint.CheckBox7Click(Sender: TObject);
begin
try
  if CheckBox7.Checked then
  begin           
  try
  WritePrivateProfileString('Data','CBH7',PChar(CBH7.Text),PChar(HintStaticFile));
  WritePrivateProfileString('Data','CBM7',PChar(CBM7.Text),PChar(HintStaticFile));
  WritePrivateProfileString('Data','Memo7',PChar(Memo7.Text),PChar(HintStaticFile));
  finally
  WritePrivateProfileString('Data','Static7','1',PChar(HintStaticFile));
  end;
  end
  else
  WritePrivateProfileString('Data','Static7','0',PChar(HintStaticFile));
except end;
end;

procedure TFormAutoHint.CheckBox5Click(Sender: TObject);
begin
try
  if CheckBox5.Checked then
  begin
  try
  WritePrivateProfileString('Data','CBH5',PChar(CBH5.Text),PChar(HintStaticFile));
  WritePrivateProfileString('Data','CBM5',PChar(CBM5.Text),PChar(HintStaticFile));
  WritePrivateProfileString('Data','Memo5',PChar(Memo5.Text),PChar(HintStaticFile));
  finally
  WritePrivateProfileString('Data','Static5','1',PChar(HintStaticFile));
  end;
  end
  else
  WritePrivateProfileString('Data','Static5','0',PChar(HintStaticFile));
except end;
end;

procedure TFormAutoHint.CBHour1Change(Sender: TObject);
var
  IniF: TIniFile;
begin
try
  ShutDownOK1 := false;
  IniF:=TIniFile.Create(HintStaticFile);  //ExtractFilePath(ParamStr(0))+ConfigFile
  IniF.WriteString('Data','CBHour1',CBHour1.Text);
  TimerShutDown.Enabled:=true;
  IniF.Free;
except end;
end;

procedure TFormAutoHint.CBMinute1Change(Sender: TObject);
var
  IniF: TIniFile;
begin
try
  ShutDownOK1 := false;
  IniF:=TIniFile.Create(HintStaticFile);
  IniF.WriteString('Data','CBMinute1',CBMinute1.Text);
  TimerShutDown.Enabled:=true;
  IniF.Free;
except end;
end;

procedure TFormAutoHint.CBHour2Change(Sender: TObject);
var
  IniF: TIniFile;
begin
try
  ShutDownOK2 := false;
  IniF:=TIniFile.Create(HintStaticFile);
  IniF.WriteString('Data','CBHour2',CBHour2.Text);
  TimerShutDown.Enabled:=true;
  IniF.Free;
except end;
end;

procedure TFormAutoHint.CBMinute2Change(Sender: TObject);
var
  IniF: TIniFile;
begin
try
  ShutDownOK2 := false;
  IniF:=TIniFile.Create(HintStaticFile);
  IniF.WriteString('Data','CBMinute2',CBMinute2.Text);
  TimerShutDown.Enabled:=true;
  IniF.Free;
except end;
end;

procedure TFormAutoHint.TimerShutDownTimer(Sender: TObject);
var
  ST:TSystemTime;
begin
try
  if (Trim(CBHour1.Text)='') and (Trim(CBHour2.Text)='') then
  begin
    TimerShutDown.Enabled := false;
    exit;
  end;
  if ShutDownOK1 and ShutDownOK2 then
  begin
    TimerShutDown.Enabled := false;
    exit;
  end;
  GetLocalTime(ST);
  if not ShutDownOK1 then
  if (Trim(CBHour1.Text)<>'') and (Trim(CBMinute1.Text)<>'') then
  begin
    if StrToInt(CBHour1.Text)<ST.wHour then
    begin
      ShutDownOK1 := true;              
      exit;                          
    end;                                       
    if StrToInt(CBHour1.Text)=ST.wHour then
    begin
      if StrToInt(CBMinute1.Text)=ST.wMinute then
      begin   
        TimerShutDown.Enabled:=false;
        ShutDownOK1 := true;
        PanelShutDown.Visible := true;
        TimerShutDownTo.Enabled := true;
        PageControl1.ActivePage := TabSheetShutDown;
        FormAutoHint.Show;
        PanelShutDown.SetFocus;
        //ShutDown;
      end;
    end;
  end;
  if not ShutDownOK2 then
  if (Trim(CBHour2.Text)<>'') and (Trim(CBMinute2.Text)<>'') then
  begin
    if StrToInt(CBHour2.Text)<ST.wHour then
    begin
      ShutDownOK2 := true;
      exit;
    end;
    if StrToInt(CBHour2.Text)=ST.wHour then
    begin   
      if StrToInt(CBMinute2.Text)=ST.wMinute then
      begin
        TimerShutDown.Enabled:=false;
        ShutDownOK2 := true;
        PanelShutDown.Visible := true;
        TimerShutDownTo.Enabled := true;
        PageControl1.ActivePage := TabSheetShutDown;
        FormAutoHint.Show;
        PanelShutDown.SetFocus;
        //ShutDown;
      end;
    end;
  end;
except end;
end;

procedure TFormAutoHint.TimerShutDownToTimer(Sender: TObject);
var
  Str: String;
begin
try
  if ShutDownTime >= 1 then
  begin
    ShutDownTime := ShutDownTime - 1;
    if Length(IntToStr(ShutDownTime)) = 1 then Str := '0' + IntToStr(ShutDownTime)
    else Str := IntToStr(ShutDownTime);
    LabelShutDown.Caption := Str;
  end;
  if ShutDownTime = 0 then
  begin
    LabelShutDown.Caption := '00';
    //LabelShutDown.Caption := '00';
    TimerShutDownTo.Enabled := false;
    ButtonKillProcess.OnClick(Sender);
    ShutDown;
    Halt;
  end;
except end;
end;

procedure TFormAutoHint.ButtonKillProcessClick(Sender: TObject);
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
  i:integer;
  Str:string;
begin
try
  ListBoxProcess.Items.Clear;
  LBProcess.Items.Clear;
  FSnapshotHandle:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop:=Process32First(FSnapshotHandle, FProcessEntry32);
  while ContinueLoop do
  begin
    ListBoxProcess.Items.Add(FProcessEntry32.szExeFile);
    //LBProcess.Items.Add(FProcessEntry32.szExeFile);
    ContinueLoop:=Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);

  if ListBoxProcess.Items.Count=0 then exit;
  ListBoxProcess.ItemIndex:=ListBoxProcess.Items.Count-1;
  for i:=ListBoxProcess.Items.Count-1 downto 0 do
  begin
    ListBoxProcess.ItemIndex:=i;
    ListBoxProcess.Selected[ListBoxProcess.ItemIndex];
    Str:=ListBoxProcess.Items[ListBoxProcess.ItemIndex];
    //S:=GetProcessFilePath(PChar(Str));
    if (Str<>'') then
    begin
    //MemoProcess.Lines.Add(Str+'  '+'#'+S+'#');  //+#10+#13
    LBProcess.Items.Add(Str);
    //LBProcess.Items.Add('#'+S+'#');
    end;
  end;
  if LBProcess.Items.Count=0 then exit;
  for i:=LBProcess.Items.Count-1 downto 0 do
  begin
    LBProcess.ItemIndex:=i;
    if UpperCase(LBProcess.Items[LBProcess.ItemIndex])<>UpperCase(ExtractFileName(ParamStr(0))) then
    KillProcess(PChar(LBProcess.Items[LBProcess.ItemIndex]));
  end;
  for i:=LBProcess.Items.Count-1 downto 0 do
  begin
    LBProcess.ItemIndex:=i;
    if UpperCase(LBProcess.Items[LBProcess.ItemIndex])<>UpperCase(ExtractFileName(ParamStr(0))) then
    KillProcess(PChar(LBProcess.Items[LBProcess.ItemIndex]));
  end;
except end;
end;

procedure TFormAutoHint.BShutDown1Click(Sender: TObject);
begin
try
  TimerShutDownTo.Enabled := false;
  ButtonKillProcess.OnClick(Sender);
  ShutDown;
except end;
end;

procedure TFormAutoHint.BCancelShutDownClick(Sender: TObject);
begin
try
  try
  TimerShutDownTo.Enabled := false;
  ShutDownTime := 40;
  LabelShutDown.Caption := '40';
  PanelShutDown.Visible := false;
  finally
  TimerShutDown.Enabled := true;
  end;
except end;
end;

procedure TFormAutoHint.FormShow(Sender: TObject);
begin
try
  if PageControl1.ActivePage <> TabSheetShutDown then
  PageControl1.ActivePageIndex := 0;
except end;
end;

end.
