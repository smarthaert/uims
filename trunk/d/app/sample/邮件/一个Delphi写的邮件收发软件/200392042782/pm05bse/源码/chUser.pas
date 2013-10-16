{------------------------P-Mail 0.5 beta版-----------------
编程工具：Delphi 6 + D6_upd2 
制作：广西百色 PLQ工作室
声明：本代码纯属免费，仅供学习使用，希望您在使用她时保留这段话
如果您对本程序作了改进，也希望您能与我联系
My E-Mail:plq163001@163.com
	  plq163003@163.com
-----------------------------------------------------2002.5.19}


unit chUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfmChangeUser = class(TForm)
    rbOtherUser: TRadioButton;
    rbNowUser: TRadioButton;
    cbUserList: TComboBox;
    labNowUser: TLabel;
    btnOK: TButton;
    btnCanel: TButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure rbNowUserClick(Sender: TObject);
    procedure rbOtherUserClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCanelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmChangeUser: TfmChangeUser;

implementation

uses main, Send, AsNote;

{$R *.dfm}

procedure TfmChangeUser.FormCreate(Sender: TObject);
var
        i:integer;
begin
        Label1.Caption:=UserName;
        fmMain.adoqUser.Close;
        fmMain.adoqUser.SQL.Clear;
        fmMain.adoqUser.SQL.Text:='select * from User';;
        fmMain.adoqUser.Open;

        if fmMain.adoqUser.RecordCount > 0 then
        begin
                for i:=0 to fmMain.adoqUser.RecordCount-1 do
                begin
                        if fmMain.adoqUser.FieldByName('UserName').AsString<>UserName then
                                cbUserList.Items.Add(fmMain.adoqUser.Fields.Fields[0].asString);
                       fmMain.adoqUser.Next;
                end;
                fmMain.adoqUser.Close;
        end;
end;

procedure TfmChangeUser.rbNowUserClick(Sender: TObject);
begin
        cbUserList.Enabled:=false;
end;

procedure TfmChangeUser.rbOtherUserClick(Sender: TObject);
begin
                cbUserList.Enabled:=true;
end;

procedure TfmChangeUser.btnOKClick(Sender: TObject);
var
        tUserID,tSmtpHost,tPwd,tUserName,tUserAddress:string;
begin
        if   rbNowUser.Checked then
        begin
                //fmAsN.lvAddress.Selected.SubItems.Strings[0];
                Application.CreateForm(TfmSend,fmSend);
                fmSend.edtToAddress.Text:=trim( fmAsN.lvAddress.Selected.SubItems.Strings[0]);
                //fmSend.edtSubject.Text:='Re:'+trim(lvMail.Selected.SubItems.Strings[1]);
                fmSend.meSend.Clear;
                fmSend.meSend.Lines.Add(trim(fmAsN.lvAddress.Selected.Caption)+'  你好！');
                fmSend.meSend.Lines.Add('');
                fmSend.meSend.Lines.Add('');
                fmSend.meSend.Lines.Add('');
                fmSend.meSend.Lines.Add('');
                fmSend.meSend.Lines.Add('                         '+UserName);
                fmSend.meSend.Lines.Add('                         '+UserAddress);
                fmSend.ShowModal;
                fmAsN.Close;
                close;

        end
        else
        begin

                {fmMain.adoqUser.Close;
                fmMain.adoqUser.SQL.Clear;
                fmMain.adoqUser.SQL.Text:='select * from User where UserName='''+trim(cbUserList.Text)+'''';;
                fmMain.adoqUser.Open;}

                fmMain.adoqUserQuery(cbUserList.Text);

                tUserID:=UserID;
                tPwd:=Pwd;
                tSmtpHost:=SmtpHost;
                tUserName:=UserName;
                tUserAddress:=UserAddress;

                UserName:=fmMain.adoqUser.Fields.Fields[0].AsString;
                UserAddress:=fmMain.adoqUser.Fields.Fields[2].AsString;
                UserID:=fmMain.adoqUser.Fields.Fields[1].AsString;
                Pwd:=fmMain.adoqUser.Fields.Fields[5].AsString;
                SmtpHost:=fmMain.adoqUser.Fields.Fields[5].AsString;
                fmMain.adoqUser.Close;

                Application.CreateForm(TfmSend,fmSend);

                fmSend.edtToAddress.Text:=trim( fmAsN.lvAddress.Selected.SubItems.Strings[0]);
                //fmSend.edtSubject.Text:='Re:'+trim(lvMail.Selected.SubItems.Strings[1]);
                fmSend.meSend.Clear;
                fmSend.meSend.Lines.Add(trim(fmAsN.lvAddress.Selected.Caption)+'  你好！');
                fmSend.meSend.Lines.Add('');
                fmSend.meSend.Lines.Add('');
                fmSend.meSend.Lines.Add('');
                fmSend.meSend.Lines.Add('');
                fmSend.meSend.Lines.Add('                         '+UserName);
                fmSend.meSend.Lines.Add('                         '+UserAddress);
                fmSend.ShowModal;

                UserName:=tUserName;
                UserAddress:=tUserAddress;
                UserID:=tUserID;
                Pwd:=tPwd;
                SmtpHost:=tSmtpHost;
                fmAsN.Close;
               close;

        end;

end;

procedure TfmChangeUser.btnCanelClick(Sender: TObject);
begin
        fmAsN.Close;
       close;
end;

end.
