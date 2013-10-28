unit frm_SendMail;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdPOP3, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdMessageClient, IdSMTP,IdMessage, XPMan;

type
  TFrmSendMail = class(TForm)
    SMTP: TIdSMTP;
    BtnSend: TButton;
    GroupBox1: TGroupBox;
    EdServerName: TEdit;
    LblServer: TLabel;
    EdUserName: TEdit;
    LblUserName: TLabel;
    LblSendTo: TLabel;
    EdToName: TEdit;
    LabA: TLabel;
    EDToServer: TEdit;
    GBxText: TGroupBox;
    MmText: TMemo;
    EdPass: TEdit;
    Label1: TLabel;
    EdTitle: TEdit;
    CBxPrio: TComboBox;
    Label2: TLabel;
    CBxAuth: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    BtnClose: TButton;
    procedure BtnSendClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure MailSend;
    { Public declarations }
  end;

var
  FrmSendMail: TFrmSendMail;

implementation

{$R *.dfm}
procedure TFrmSendMail.MailSend;
var
  TM:TIdMessage;
begin
  TM:=TIDMEssage.Create(nil);
  With TM do
  begin
    Body.Assign(MMtext.Lines);
    From.Text:=EDuserName.Text;
    Recipients.EMailAddresses:=EdToName.Text+'@'+EDToServer.Text;
    Subject:=EdTitle.Text;
    Priority:=TIDMessagePriority(CBxPrio.ItemIndex);
  end;

  case CBxAuth.ItemIndex of
  0:Smtp.AuthenticationType:=atLogin;  //需要认证
  1:Smtp.AuthenticationType:=atNone;   //无需认证
  end;

  SMTP.Host:=EdServerName.Text;
  SMTP.Username:=EdUserName.Text;
  SMTP.Password:=EDPass.Text;
  try
    SMTP.Connect;
  except
    showmessage('无法连接到服务器！');
    exit;
  end;

  Try
    SMTP.Send(TM);
  Finally
    Smtp.Disconnect;
  end;
end;

procedure TFrmSendMail.BtnSendClick(Sender: TObject);
begin
  if (Trim(EdServerName.Text) = '')or
  (Trim(EdToName.Text) = '') or
  (Trim(EdToServer.Text) = '')  then
  begin
    showmessage('请输入完整信息！');
    exit;
  end;
  MailSend;
//  (Trim(EdServerEx.Text) = '')or
end;

procedure TFrmSendMail.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
