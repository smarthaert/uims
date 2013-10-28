unit config;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, WinSkinForm, WinSkinData,inifiles, XPMenu;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    WinSkinForm1: TWinSkinForm;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    XPMenu1: TXPMenu;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
 configini:tinifile;
 province,city,time:string;

implementation
uses main;
{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
configini:=tinifile.Create(extractfilepath(application.ExeName)+'config.ini');
province:=configini.ReadString('config','province','');
city:=configini.ReadString('config','city','');
time:=configini.ReadString('config','time','');
configini.Free;
combobox1.Text:=province;
combobox2.Text:=city;
edit3.Text:=time; 
end;

procedure TForm2.SpeedButton1Click(Sender: TObject);
begin
combobox1.Text:='';
combobox2.Text:='';
edit3.Text:='';
end;

procedure TForm2.SpeedButton2Click(Sender: TObject);
begin
if (combobox1.Text='省份') or (combobox1.Text='') then
begin
showmessage('请选择省份');
abort;
end;
if (combobox2.Text='城市') or (combobox2.Text='') then
begin
showmessage('请选择城市');
abort;
end;
if edit3.Text='' then
begin
showmessage('请填写时间');
abort;
end;
configini:=tinifile.Create(extractfilepath(application.ExeName)+'config.ini');
configini.writeString('config','province',combobox1.Text);
configini.writeString('config','city',combobox2.Text);
configini.writeString('config','time',edit3.Text);
configini.Free;
getdatathread.Create(false);
close;

end;

procedure TForm2.ComboBox1Change(Sender: TObject);
begin
combobox2.Items.LoadFromFile(ExtractFilePath(Application.Exename)+'/city/'+combobox1.Text+'.txt');
end;

end.
