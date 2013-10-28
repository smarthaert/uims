unit UnitSet;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles, Registry, ExtCtrls;

type
  TFormSet = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    SaveBootCB: TCheckBox;
    SaveTimeCB: TCheckBox;
    SaveSkinCB: TCheckBox;
    SaveExecCB: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSet: TFormSet;
  FileName: String;

implementation

uses UnitMain;

{$R *.dfm}

procedure SetStart;
var
  Reg: TRegistry;
begin
  Reg:= TRegistry.Create;
  try
    Reg.RootKey:= HKEY_CURRENT_USER;
    if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run',True) then
    begin
      Reg.WriteString(Application.Title, ParamStr(0));
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure CloStart;
var
  Reg: TRegistry;
begin
  Reg:= TRegistry.Create;
  try
    Reg.RootKey:= HKEY_CURRENT_USER;
    if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run\',True) then
    begin
      Reg.DeleteValue(Application.Title);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TFormSet.Button1Click(Sender: TObject);
begin
  FileName:= ExtractFilePath(ParamStr(0))+Ini;
  UnitMain.MyIni:= TIniFile.Create(FileName);
  if SaveTimeCB.Checked then
  begin
    UnitMain.MyIni.Writebool('系统参数','保存定时设置',True);
    UnitMain.MyIni.WriteInteger('定时设置','时',FormMain.HnSE.Value);
    UnitMain.MyIni.WriteInteger('定时设置','分',FormMain.MnSE.Value);
    UnitMain.MyIni.WriteInteger('定时设置','秒',FormMain.SnSE.Value);
    UnitMain.MyIni.WriteInteger('定时设置','计时方式',FormMain.TimeWayRG.ItemIndex);
    UnitMain.MyIni.WriteBool('定时设置','关机提醒',FormMain.AlertCB.Checked);
  end
  else
  begin
    UnitMain.MyIni.Writebool('系统参数','保存定时设置',False);
    UnitMain.MyIni.WriteInteger('定时设置','时',0);
    UnitMain.MyIni.WriteInteger('定时设置','分',0);
    UnitMain.MyIni.WriteInteger('定时设置','秒',30);
    UnitMain.MyIni.WriteInteger('定时设置','计时方式',0);
    UnitMain.MyIni.WriteBool('定时设置','关机提醒',FormMain.AlertCB.Checked);
  end;
  if SaveSkinCB.Checked then
  begin
    UnitMain.MyIni.WriteBool('皮肤设置','加载皮肤',True);
  end
  else
  begin
    UnitMain.MyIni.WriteBool('皮肤设置','加载皮肤',False);
  end;
  if SaveBootCB.Checked then
  begin
    UnitMain.MyIni.Writebool('系统参数','随系统启动而启动',True);
    SetStart;
  end
  else
  begin
    UnitMain.MyIni.Writebool('系统参数','随系统启动而启动',False);
    CloStart;
  end;
  if SaveExecCB.Checked then
  begin
    UnitMain.MyIni.WriteBool('启动设置','启动时执行定时任务',True);
  end
  else
  begin
    UnitMain.MyIni.WriteBool('启动设置','启动时执行定时任务',False);
  end;
  FormSet.Close;
end;

procedure TFormSet.FormCreate(Sender: TObject);
begin
  if FileExists(UnitMain.CurrentDir+'\'+Ini) then
  begin
    SaveTimeCB.Checked:= UnitMain.MyIni.ReadBool('系统参数','保存定时设置', False);
    SaveSkinCB.Checked:= UnitMain.MyIni.ReadBool('皮肤设置','加载皮肤', True);
    SaveBootCB.Checked:= UnitMain.MyIni.ReadBool('系统参数','随系统启动而启动', False);
    SaveExecCB.Checked:= UnitMain.MyIni.ReadBool('启动设置','启动时执行定时任务', False);
  end;
end;
end.
