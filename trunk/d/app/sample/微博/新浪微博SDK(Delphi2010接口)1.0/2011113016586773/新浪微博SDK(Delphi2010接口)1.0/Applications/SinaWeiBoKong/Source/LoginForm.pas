unit LoginForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  OleCtrls, MSHTML, ComObj, ActiveX,
  ComCtrls,
  ulkJSON,
  SHDocVw,
  uMyOAuth,
  uSinaWeiboAPI,
  uSinaWeiboAPIConst,
  uSinaWeiboUser,
  uSinaWeiboClient,
  uSinaWeiboParam;

type
  TfrmLogin = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    IdHTTP1: TIdHTTP;
    RequestTokenButton: TButton;
    AuthButton: TButton;
    RequestAccessButton: TButton;
    Button3: TButton;
    EWBAuthorize: TWebBrowser;
    Label3: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Label4: TLabel;
    procedure RequestTokenButtonClick(Sender: TObject);
    procedure AuthButtonClick(Sender: TObject);
    procedure RequestAccessButtonClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function ShowLoginForm: Boolean;

implementation

uses
  UserInfoForm;


var
  frmLogin: TfrmLogin;

function ShowLoginForm: Boolean;
begin
  Result := False;
  if frmLogin = nil then
    frmLogin := TfrmLogin.Create(Application);
  frmLogin.ShowModal;
  if frmLogin.ModalResult = mrOK then
  begin
    Result := True;
  end;
end;

{$R *.dfm}

procedure TfrmLogin.RequestAccessButtonClick(Sender: TObject);
begin
  Client.OAuth.RequestAccessToken('http://api.t.sina.com.cn/oauth/access_token');
end;

procedure TfrmLogin.AuthButtonClick(Sender: TObject);
begin
  Client.OAuth.Authorize(Self.EWBAuthorize,
                          'http://api.t.sina.com.cn/oauth/authorize',
                          'oob',
                          Self.Edit1.Text,
                          Self.Edit2.Text);
end;

procedure TfrmLogin.Button1Click(Sender: TObject);
begin
  Client.OAuth.AppKey:=Self.Edit4.Text;
  Client.OAuth.AppSecret:=Self.Edit3.Text;
  Client.OAuth.OAuthUserName:=Self.Edit1.Text;
  Client.OAuth.OAuthPassword:=Self.Edit2.Text;

  if Client.OAuth.RequestToken('http://api.t.sina.com.cn/oauth/request_token') then
  begin
    if Client.OAuth.Authorize(Self.EWBAuthorize,
                          'http://api.t.sina.com.cn/oauth/authorize',
                          'oob',
                          Self.Edit1.Text,
                          Self.Edit2.Text) then
    begin
      if Client.OAuth.RequestAccessToken('http://api.t.sina.com.cn/oauth/access_token') then
      begin
        Client.User.UserName:=Self.Edit1.Text;
        Client.User.Password:=Self.Edit2.Text;
        ShowMessage('µÇÂ½³É¹¦£¡');
      end;
    end;
  end;
end;

procedure TfrmLogin.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmLogin.Button3Click(Sender: TObject);
begin
  if Client.SyncUserInfo then
    ShowUserInfo(Client);
end;

procedure TfrmLogin.RequestTokenButtonClick(Sender: TObject);
begin
  Client.OAuth.RequestToken('http://api.t.sina.com.cn/oauth/request_token');
end;

end.
