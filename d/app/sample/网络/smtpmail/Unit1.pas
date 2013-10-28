unit Unit1;
//download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdMessage, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP, ExtCtrls;

type
  TForm1 = class(TForm)
    SMTP1: TIdSMTP;
    IdMsg: TIdMessage;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label3: TLabel;
    Memo1: TMemo;
    Edit3: TEdit;
    Button2: TButton;
    Label6: TLabel;
    Edit4: TEdit;
    Label7: TLabel;
    Edit5: TEdit;
    Label8: TLabel;
    Edit6: TEdit;
    OpenDialog1: TOpenDialog;
    Edit7: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin

SMTP1.AuthenticationType := atLogin;

SMTP1.username:= edit2.text;
SMTP1.Password := edit1.text;

SMTP1.Host := edit3.text;
SMTP1.Port :=25;
  try
   SMTP1.Connect;
   except
    Showmessage('连接SMTP服务器失败!');
    Exit;
    end;
 try
   with IdMsg do
    begin
     body.Clear;
     Body.Assign(memo1.lines);
     From.address := edit5.text;
     Recipients.EMailAddresses :=edit6.text;
     Subject:=edit4.text
   end;
  SMTP1.Send(IdMsg);
  finally
  showmessage('您的信件已成功发送');
  SMTP1.Disconnect;
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
if opendialog1.Execute then
memo1.Lines.Add(opendialog1.filename);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
   close;
end;

end.
