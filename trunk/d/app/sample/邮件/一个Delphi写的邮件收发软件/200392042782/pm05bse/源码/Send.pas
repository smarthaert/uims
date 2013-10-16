{------------------------P-Mail 0.5 beta版-----------------
编程工具：Delphi 6 + D6_upd2 
制作：广西百色 PLQ工作室
声明：本代码纯属免费，仅供学习使用，希望您在使用她时保留这段话
如果您对本程序作了改进，也希望您能与我联系
My E-Mail:plq163001@163.com
	  plq163003@163.com
-----------------------------------------------------2002.5.19}

unit Send;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IdMessage, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP;

type
  TfmSend = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cobPriority: TComboBox;
    Label4: TLabel;
    edtSubject: TEdit;
    edtToAddress: TEdit;
    edtCToAddress: TEdit;
    btnAddFNote1: TButton;
    btnAddFNote2: TButton;
    GroupBox2: TGroupBox;
    lbAF: TListBox;
    btnAddAF: TButton;
    btnDeleAF: TButton;
    GroupBox3: TGroupBox;
    meSend: TMemo;
    btnSend: TBitBtn;
    btnCanel: TBitBtn;
    IdMessage1: TIdMessage;
    IdSmtp1: TIdSMTP;
    OpenDialog1: TOpenDialog;
    procedure btnSendClick(Sender: TObject);
    procedure btnAddAFClick(Sender: TObject);
    procedure btnDeleAFClick(Sender: TObject);
    procedure btnCanelClick(Sender: TObject);
    procedure btnAddFNote1Click(Sender: TObject);
    procedure btnAddFNote2Click(Sender: TObject);

    private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSend: TfmSend;


implementation

uses main, AsNote;

{$R *.dfm}

procedure TfmSend.btnSendClick(Sender: TObject);
{var
        index:integer;}
begin

        {if lbAF.Count>0 then
        //begin
                //for index:=0 to lbAF.Count-1 do
                begin
                        if IdMessAge1.MessageParts.
                        TIdAttachment.Create(IdMessage.TIdMessageParts)
                end;
        end;}
       Screen.Cursor := crHourglass;
       with IdMessage1 do
       begin
                Body.Assign(meSend.Lines);      //加入正文
                From.Text :=UserAddress;
                Recipients.EMailAddresses:=edtToAddress.Text;          //收件人
                Subject := edtSubject.Text;
                Priority :=TIdMessagePriority(cobPriority.ItemIndex);   //邮件优先级
                CCList.EMailAddresses := edtCToAddress.Text;            //抄送地址
                //BccList.EMailAddresses := edtBCC.Text; //暗送地址
       end;

       IdSmtp1.AuthenticationType:=atLogin;     //发送类型为需要身份验证

       IdSmtp1.UserId:=UserID;
       IdSmtp1.Password:=Pwd;
       IdSmtp1.Host:=SmtpHost;
       IdSmtp1.Port:=25;
       try
                IdSmtp1.Connect;
       except
                Screen.Cursor := crDefault;
                showmessage('发送失败!');
                
                exit;
       end;

       try
                IdSmtp1.Send(IdMessage1);
       finally
                IdSmtp1.Disconnect;
                ShowMessage('发送成功!');
                edtToAddress.Text:='';
                edtSubject.Text:='';
                lbAF.Clear;
                meSend.Clear;
                Screen.Cursor := crDefault;
                
       end;


end;

procedure TfmSend.btnAddAFClick(Sender: TObject);
begin
         if OpenDialog1.Execute then
         begin
                 TIdAttachment.Create(IdMessage1.MessageParts,OpenDialog1.FileName);
                 lbAF.Items.Add(OpenDialog1.FileName);
        end;
end;

procedure TfmSend.btnDeleAFClick(Sender: TObject);
begin
         IdMessage1.MessageParts.Items[lbAF.ItemIndex].Free;
         lbAF.DeleteSelected;

end;

procedure TfmSend.btnCanelClick(Sender: TObject);
begin
        

          edtToAddress.Text:='';
          edtSubject.Text:='';
          lbAF.Clear;
          meSend.Clear;

          close;
end;

procedure TfmSend.btnAddFNote1Click(Sender: TObject);
begin
        Application.CreateForm(TfmAsN,fmAsN);
        fmAsN.btnInsertTo.Visible:=true;
        fmAsN.ShowModal;
end;


procedure TfmSend.btnAddFNote2Click(Sender: TObject);
begin
           Application.CreateForm(TfmAsN,fmAsN);
           fmAsN.btnInserCTo.Visible:=true;
           fmAsN.ShowModal;
end;

end.
