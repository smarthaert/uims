unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, RzForms, INIFiles;

type
  TRegKey = class(TForm)
    Panel1: TPanel;
    RzFormShape1: TRzFormShape;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegKey: TRegKey;

implementation

{$R *.dfm}

procedure TRegKey.FormCreate(Sender: TObject);
var
  vIniFile: TIniFile;
begin
  vIniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.Ini');
  Edit1.Text := vIniFile.Readstring('System', 'PCID', '');
  Edit2.Text := vIniFile.Readstring('System', 'Key', '');

end;

procedure TRegKey.SpeedButton1Click(Sender: TObject);
var
  vIniFile: TIniFile;
begin
  vIniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.Ini');
  vIniFile.WriteString('System', 'Key', UpperCase(Edit2.Text));
  if Edit2.Text <> '' then
    showmessage('感谢您注册本产品。请重新启动本软件~~!' + #13#13 + '如果您输入的注册码正确的话，窗口左上角将显示已注册~~!');
  SpeedButton2.Click;
end;

procedure TRegKey.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SpeedButton1.Click;
  end;
end;

procedure TRegKey.SpeedButton2Click(Sender: TObject);
begin
  RegKey.Close;
end;

procedure TRegKey.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE: SpeedButton2.Click;
  end;
end;

end.

