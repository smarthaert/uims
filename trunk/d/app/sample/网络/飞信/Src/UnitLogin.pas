unit UnitLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TFormLogin = class(TForm)
    labUsername: TLabel;
    labPassword: TLabel;
    Image2: TImage;
    edPhoneNum: TEdit;
    btLogin: TButton;
    edPassword: TEdit;
    btCancel: TButton;
    procedure btLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edPhoneNumKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLogin: TFormLogin;

implementation

{$R *.dfm}

uses UnitMain;

procedure TFormLogin.btLoginClick(Sender: TObject);
begin
  if not FormMain.Login(edPhoneNum.Text, edPassword.Text) then
  begin
    ShowMessage('帐号错误或网络故障，无法登录。');
    ModalResult := mrNone;
    Exit;
  end;
end;

procedure TFormLogin.edPhoneNumKeyPress(Sender: TObject; var Key: Char);
begin
  if ( (Key>#31) and (Key<#128) ) then
  if ( (Key<'0') or (Key>'9') ) then
    Key := #0;
end;

procedure TFormLogin.FormCreate(Sender: TObject);
begin
  SetWindowLong(Handle,GWL_EXSTYLE,WS_EX_APPWINDOW); // 显示在任务栏
end;

end.
