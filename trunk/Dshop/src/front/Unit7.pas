unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, Mask, RzEdit, ExtCtrls, RzForms, INIFiles;

type
  TPos_Setup = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    RzFormShape1: TRzFormShape;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RzEdit1: TRzEdit;
    Label4: TLabel;
    RzEdit2: TRzEdit;
    Label5: TLabel;
    RzEdit3: TRzEdit;
    Label6: TLabel;
    RzEdit4: TRzEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    OpenDialog1: TOpenDialog;
    procedure SpeedButton2Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Pos_Setup: TPos_Setup;

implementation

{$R *.dfm}

procedure TPos_Setup.SpeedButton2Click(Sender: TObject);
begin
  Pos_Setup.Close;
end;

{控制钱箱打开的密钥文件}

procedure TPos_Setup.Label2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
  end
  else
  begin
  end;

end;

procedure TPos_Setup.SpeedButton1Click(Sender: TObject);
var
  vIniFile: TIniFile;
begin
  vIniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.Ini');
  vIniFile.WriteString('System', 'Name', RzEdit1.Text);
  vIniFile.WriteString('System', 'La1', RzEdit2.Text);
  vIniFile.WriteString('System', 'La2', RzEdit3.Text);
  vIniFile.WriteString('System', 'Tel', RzEdit4.Text);

  Pos_Setup.Close;
end;

procedure TPos_Setup.FormActivate(Sender: TObject);
var
  vIniFile: TIniFile;
begin
  vIniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.Ini');
  RzEdit1.Text := vIniFile.ReadString('System', 'Name', '');
  RzEdit2.Text := vIniFile.ReadString('System', 'La1', '');
  RzEdit3.Text := vIniFile.ReadString('System', 'La2', '');
  RzEdit4.Text := vIniFile.ReadString('System', 'Tel', '');
  Pos_Setup.SetFocus;
end;

procedure TPos_Setup.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE: SpeedButton2.Click;
  end;
end;

end.
