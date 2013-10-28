
{*******************************************************}
{                                                       }
{       IEBar 图文快存                                  }
{                                                       }
{       版权所有 (C) 2005　毕耜祯           　　　　　　}
{            转载请保留此信息 　　　　　　　　　　　　  }
{       网址：batconv.512j.com                          }
{       batconv@163.com                                 }
{*******************************************************}

unit ShizhiUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, inifiles,ExtCtrls;

type
  TfrmShizhi = class(TForm)
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Label1: TLabel;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Bevel1: TBevel;
    CheckBox6: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
    MyInifile: TInifile;
  public
    { Public declarations }
    
  end;

var
  frmShizhi: TfrmShizhi;
  

implementation

{$R *.dfm}

procedure TfrmShizhi.FormCreate(Sender: TObject);
var
  vIniFileName :string;
  vSysPath: array[0..255] of char;
begin
  GetSystemDirectory(vSysPath, 256);
  vIniFileName := vSysPath + '\QC.ini';
  MyInifile := TInifile.Create(vIniFileName);
  CheckBox1.Checked:=myinifile.ReadBool('CBVisible', 'CB1', True);
  CheckBox2.Checked:=myinifile.ReadBool('CBVisible', 'CB2', True);
  CheckBox3.Checked:=myinifile.ReadBool('CBVisible', 'CB3', True);
  CheckBox4.Checked:=myinifile.ReadBool('CBVisible', 'CB4', True);
  CheckBox5.Checked:=myinifile.ReadBool('CBVisible', 'CB5', True);
  CheckBox6.Checked:=myinifile.ReadBool('CBVisible', 'CB6', True);
  Edit1.Text:=myinifile.Readstring('App','SavePath','C:\WWQC');
end;

procedure TfrmShizhi.FormDestroy(Sender: TObject);
begin
  MyInifile.Destroy;
end;

procedure TfrmShizhi.SpeedButton2Click(Sender: TObject);
begin
  myinifile.WriteBool('CBVisible', 'CB1', CheckBox1.Checked);
  myinifile.WriteBool('CBVisible', 'CB2', CheckBox2.Checked);
  myinifile.WriteBool('CBVisible', 'CB3', CheckBox3.Checked);
  myinifile.WriteBool('CBVisible', 'CB4', CheckBox4.Checked);
  myinifile.WriteBool('CBVisible', 'CB5', CheckBox5.Checked);
  myinifile.WriteBool('CBVisible', 'CB6', CheckBox6.Checked);
  if trim(Edit1.Text) <>'' then
    MyIniFile.WriteString('App','SavePath',trim(Edit1.Text));
  Close;
end;

end.
