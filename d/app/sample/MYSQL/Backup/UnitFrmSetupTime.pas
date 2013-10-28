unit UnitFrmSetupTime;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ExtCtrls, Buttons,inifiles;

type
  TFrmSetupTime = class(TForm)
    Bevel1: TBevel;
    Label1: TLabel;
    RBtnNone: TRadioButton;
    RBtnEveryTime: TRadioButton;
    RBtnEveryDay: TRadioButton;
    RBtnEveryWeek: TRadioButton;
    RBtnEveryMonth: TRadioButton;
    Bevel2: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    CmbWeek: TComboBox;
    EdtDay: TSpinEdit;
    EdtTime: TSpinEdit;
    EdtMinute: TSpinEdit;
    Label6: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure RBtnNoneClick(Sender: TObject);
    procedure RBtnEveryTimeClick(Sender: TObject);
    procedure RBtnEveryDayClick(Sender: TObject);
    procedure RBtnEveryWeekClick(Sender: TObject);
    procedure RBtnEveryMonthClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    FilePath:String;
    BackupType,EveryTime,EveryDay,EveryMonth,EveryWeek:integer;
    //EveryWeek:String;
    ServerName,DatabaseName,UserName,Password:string;
    BackupIniFile:TInifile;
  public
    { Public declarations }
  end;

var
  FrmSetupTime: TFrmSetupTime;

implementation

uses UnitBackup;

{$R *.dfm}

procedure TFrmSetupTime.RBtnNoneClick(Sender: TObject);
begin
  if RBtnNone.Checked then
  begin
    CmbWeek.Enabled:=False;
    EdtDay.Enabled:=False;
    EdtTime.Enabled:=False;
    EdtMinute.Enabled:=False;
    BackupType:=0;
  end;
end;

procedure TFrmSetupTime.RBtnEveryTimeClick(Sender: TObject);
begin
  if RBtnEveryTime.Checked then
  begin
    CmbWeek.Enabled:=False;
    EdtDay.Enabled:=False;
    EdtTime.Enabled:=False;
    EdtMinute.Enabled:=True;
    BackupType:=1;
  end;
end;

procedure TFrmSetupTime.RBtnEveryDayClick(Sender: TObject);
begin
  if RBtnEveryDay.Checked then
  begin
    CmbWeek.Enabled:=False;
    EdtDay.Enabled:=False;
    EdtTime.Enabled:=True;
    EdtMinute.Enabled:=True;
    BackupType:=2;
  end;
end;

procedure TFrmSetupTime.RBtnEveryWeekClick(Sender: TObject);
begin
  if RBtnEveryWeek.Checked then
  begin
    CmbWeek.Enabled:=True;
    EdtDay.Enabled:=False;
    EdtTime.Enabled:=True;
    EdtMinute.Enabled:=True;
    BackupType:=3;
  end;
end;

procedure TFrmSetupTime.RBtnEveryMonthClick(Sender: TObject);
begin
  if RBtnEveryMonth.Checked then
  begin
    CmbWeek.Enabled:=False;
    EdtDay.Enabled:=True;
    EdtTime.Enabled:=True;
    EdtMinute.Enabled:=True;
    BackupType:=4;
  end;
end;

procedure TFrmSetupTime.BitBtn1Click(Sender: TObject);
begin
  try
    BackupIniFile.WriteInteger('Backup','BackupType',BackupType);
    BackupIniFile.WriteInteger('Backup','EveryTime',EdtMinute.Value);
    BackupIniFile.WriteInteger('Backup','EveryDay',EdtTime.Value);
    BackupIniFile.WriteInteger('Backup','EveryWeek',CmbWeek.ItemIndex);
    BackupIniFile.WriteInteger('Backup','EveryMonth',EdtDay.Value);

    frmBackup.BackupType:=BackupType;
    frmBackup.EveryTime:=EdtMinute.Value;
    frmBackup.EveryDay:=EdtTime.Value;
    frmBackup.EveryMonth:=EdtDay.Value;
    frmBackup.EveryWeek:=CmbWeek.ItemIndex;
    Close;
    //BackupType,EveryTime,EveryDay,EveryWeek,EveryMonth:integer;
  except
    MessageBox(handle,'保存数据错误！','错误',mb_IconWarning+mb_Ok);
    Exit;
  end;
end;

procedure TFrmSetupTime.FormCreate(Sender: TObject);
begin
  //建立ini文件对象
  FilePath:=ExtractFilePath(Application.ExeName)+'System.ini';
  BackupIniFile:=TIniFile.Create(FilePath);
  BackupType:=BackupIniFile.ReadInteger('Backup','BackupType',0);
  EveryTime:=BackupIniFile.ReadInteger('Backup','EveryTime',0);
  EveryDay:=BackupIniFile.ReadInteger('Backup','EveryDay',0);
  EveryWeek:=BackupIniFile.ReadInteger('Backup','EveryWeek',0);
  EveryMonth:=BackupIniFile.ReadInteger('Backup','EveryMonth',0);
  case BackupType of
  0:begin//不备份
      RBtnNone.Checked:=True;
      RBtnNoneClick(RBtnNone);
    end;
  1:begin//每小时
      RBtnEveryTime.Checked:=True;
      RBtnEveryTimeClick(RBtnEveryTime);
      EdtMinute.Value:=EveryTime;
    end;
  2:begin//每天
      RBtnEveryDay.Checked:=True;
      RBtnEveryDayClick(RBtnEveryDay);
      EdtTime.Value:=EveryDay;
      EdtMinute.Value:=EveryTime;
    end;
  3:begin//每周
      RBtnEveryWeek.Checked:=True;
      RBtnEveryWeekClick(RBtnEveryWeek);
      CmbWeek.ItemIndex:=EveryWeek;
    end;
  4:begin//每月
      RBtnEveryMonth.Checked:=True;
      RBtnEveryMonthClick(RBtnEveryMonth);
      EdtDay.Value:=EveryMonth;
    end;
  end;
end;

procedure TFrmSetupTime.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

end.
