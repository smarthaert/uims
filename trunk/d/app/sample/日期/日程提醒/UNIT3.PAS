unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, ImgList, Buttons,inifiles, Mask,mmsystem,Registry,
  BTOdeum;

type
  TForm3 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    OpenDialog1: TOpenDialog;
    Bevel3: TBevel;
    Label9: TLabel;
    SpeedButton6: TSpeedButton;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    Edit6: TEdit;
    SpeedButton7: TSpeedButton;
    Panel4: TPanel;
    Label8: TLabel;
    Label7: TLabel;
    MaskEdit3: TMaskEdit;
    Label4: TLabel;
    Label5: TLabel;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    MaskEdit2: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Edit2: TEdit;
    MaskEdit1: TMaskEdit;
    SpeedButton5: TSpeedButton;
    Label6: TLabel;
    TabSheet4: TTabSheet;
    Panel5: TPanel;
    Bevel2: TBevel;
    Bevel4: TBevel;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    ComboBox1: TComboBox;
    Beeper1: TBTBeeper;
    CheckBox7: TCheckBox;
    ComboBox2: TComboBox;
    CheckBox10: TCheckBox;
    SpeedButton10: TSpeedButton;
    Bevel5: TBevel;
    procedure Panel1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  fn:tinifile;
implementation

uses shortcut;



{$R *.DFM}

//激活所选页
procedure TForm3.Panel1Click(Sender: TObject);
begin
  case (sender as tpanel).tag of
    1:PageControl1.ActivePage:=TabSheet1;
    2:PageControl1.ActivePage:=TabSheet2;
    3:PageControl1.ActivePage:=TabSheet3;
    4:PageControl1.ActivePage:=TabSheet4;
  end;
end;


procedure TForm3.SpeedButton4Click(Sender: TObject);
begin
close;
end;

//保存设置到INI文件
procedure TForm3.SpeedButton3Click(Sender: TObject);
Var
 RegF:TRegistry;
 f:string;
begin
  RegF:=TRegistry.Create;
  RegF.RootKey:=HKEY_LOCAL_MACHINE;
  f:=application.ExeName;
  if checkbox4.Checked then
    try
      RegF.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run',True);
      RegF.WriteString('CoolClocker', f);
    finally
      RegF.Free;
    end
  else
    try
      RegF.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run',True);
      RegF.DeleteValue('CoolClocker');
    finally
      RegF.Free;
    end;

    fn.Writeinteger('BaoShi','speeker',comboBox2.ItemIndex);
    fn.Writeinteger('BaoShi','Show',integer(CheckBox2.checked));
    fn.WriteString('BaoShi','Delay',maskedit1.Text);
    fn.Writeinteger('BaoShi','CanPlay',integer(CheckBox3.checked));
    fn.WriteString('BaoShi','Play',edit2.Text);

    fn.Writeinteger('Start','AutoStart',integer(CheckBox4.checked));
    fn.Writeinteger('Start','ShowTodayList',integer(CheckBox5.checked));
    fn.WriteString('Start','Delay',maskedit2.Text);
    fn.Writeinteger('Start','AutoClose',integer(CheckBox6.checked));

    fn.Writeinteger('tixing','speeker',comboBox1.ItemIndex);
    fn.Writeinteger('Tixing','AutoClose',integer(CheckBox8.checked));
    fn.WriteString('Tixing','Delay',maskedit3.Text);
    fn.Writeinteger('Tixing','CanPlay',integer(CheckBox9.checked));
    fn.WriteString('Tixing','Play',edit6.Text);

    close;
end;

procedure TForm3.SpeedButton1Click(Sender: TObject);
begin
  opendialog1.Filter:='声音文件（*.wav）|*.wav';
  opendialog1.Title:='选择声音文件';
  opendialog1.Options:= [ofFileMustExist, ofHideReadOnly];
  opendialog1.Execute;
  if opendialog1.FileName<>'' then
    edit2.Text:=OpenDialog1.FileName;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  //根据配置文件设置窗体各选项
  fn:= tinifile.Create(extractfilepath(application.exename)+'clocker.ini');

  //page1 提醒设置
  combobox1.ItemIndex:=fn.readinteger('tixing','speeker',0);
  combobox2.ItemIndex:=fn.readinteger('BaoShi','speeker',0);

  checkbox2.Checked:=(fn.readString('BaoShi','show','1')='1');
  maskedit1.text:=fn.readString('BaoShi','delay','2');
  checkbox3.Checked:=(fn.readString('BaoShi','canplay','1')='1');
  edit2.text:=fn.readString('BaoShi','play',extractfilepath(application.exename)+'clocker.wav');
  // page2
  checkbox4.Checked:=(fn.readString('start','autostart','1')='1');
  checkbox5.Checked:=(fn.readString('start','showtodaylist','1')='1');
  maskedit2.text:=fn.readString('start','delay','2');
  checkbox6.Checked:=(fn.readString('start','autoclose','1')='1');
  //page3
  checkbox8.Checked:=(fn.readString('tixing','autoclose','1')='1');
  maskedit3.text:=fn.readString('tixing','delay','2');
  checkbox9.Checked:=(fn.readString('tixing','canplay','1')='1');
  edit6.text:=fn.readString('tixing','play',extractfilepath(application.exename)+'clocker.wav');

end;
//恢复默认值
procedure TForm3.SpeedButton2Click(Sender: TObject);
begin
checkbox2.Checked:=true;
checkbox3.Checked:=true;
checkbox4.Checked:=true;
checkbox5.Checked:=true;
checkbox6.Checked:=true;
checkbox7.Checked:=true;
checkbox8.Checked:=false;
checkbox9.Checked:=true;
combobox1.ItemIndex:=0;
combobox2.ItemIndex:=0;
edit2.text:=extractfilepath(application.exename)+'clocker.wav';
edit6.text:=extractfilepath(application.exename)+'clocker.wav';
maskedit1.Text:='2';
maskedit2.Text:='2';
maskedit3.Text:='2';
end;

procedure TForm3.SpeedButton6Click(Sender: TObject);
begin
  opendialog1.Filter:='声音文件（*.wav）|*.wav';
  opendialog1.Title:='选择声音文件';
  opendialog1.Options:= [ofFileMustExist, ofHideReadOnly];
  opendialog1.Execute;
  if opendialog1.FileName<>'' then
    edit6.Text:=OpenDialog1.FileName;
end;

procedure TForm3.SpeedButton5Click(Sender: TObject);
var
  FSoundFile:string;
begin
  FSoundFile:=edit2.Text;
  sndPlaySound(pchar(FSoundFile), snd_Async or snd_NoDefault);
end;

procedure TForm3.SpeedButton7Click(Sender: TObject);
var
  FSoundFile:string;
begin
  FSoundFile:=edit6.Text;
  sndPlaySound(pchar(FSoundFile), snd_Async or snd_NoDefault);
end;

procedure TForm3.CheckBox3Click(Sender: TObject);
begin
speedbutton1.Enabled :=checkbox3.Checked;
speedbutton5.Enabled :=checkbox3.Checked;
edit2.Enabled :=checkbox3.Checked;

end;

procedure TForm3.CheckBox9Click(Sender: TObject);
begin
speedbutton6.Enabled :=checkbox9.Checked;
speedbutton7.Enabled :=checkbox9.Checked;
edit6.Enabled :=checkbox9.Checked;
end;

procedure TForm3.CheckBox8Click(Sender: TObject);
begin
panel4.Enabled:=checkbox8.Checked;
end;

procedure TForm3.SpeedButton8Click(Sender: TObject);
var
  f,s:string;
  l:shortcuttype;
begin
  f:=application.ExeName;
  s:='电子提醒簿';
  l:=_DESKTOP;
  frmshortcut.CreateShortcut(F,s,L);
  close;
end;

procedure TForm3.SpeedButton10Click(Sender: TObject);
begin
Beeper1.PlayPresetSound(TPresetSound(combobox2.ItemIndex));
end;

procedure TForm3.SpeedButton9Click(Sender: TObject);
begin
Beeper1.PlayPresetSound(TPresetSound(combobox1.ItemIndex));

end;

end.
