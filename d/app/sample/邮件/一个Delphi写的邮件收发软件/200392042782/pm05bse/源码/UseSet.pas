{------------------------P-Mail 0.5 beta版-----------------
编程工具：Delphi 6 + D6_upd2 
制作：广西百色 PLQ工作室
声明：本代码纯属免费，仅供学习使用，希望您在使用她时保留这段话
如果您对本程序作了改进，也希望您能与我联系
My E-Mail:plq163001@163.com
	  plq163003@163.com
-----------------------------------------------------2002.5.19}



unit UseSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfmUserSet = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtUserName: TEdit;
    edtUserID: TEdit;
    edtPwd: TEdit;
    edtUserAddress: TEdit;
    edtPopHost: TEdit;
    edtSmtpHost: TEdit;
    btnSet: TBitBtn;
    btnOK: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnSetClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmUserSet: TfmUserSet;

implementation

uses main;

{$R *.dfm}

procedure TfmUserSet.FormCreate(Sender: TObject);
begin
        edtUserName.Text:=UserName;
        edtUserID.Text:=UserID;
        edtPwd.Text:=Pwd;
        edtUserAddress.Text:=UserAddress;
        edtPopHost.Text:=PopHost;
        edtSmtpHost.Text:=SmtpHost;
end;

procedure TfmUserSet.btnSetClick(Sender: TObject);
{var
        temp:string; }
begin
        {fmMain.adoqUser.Close;
        fmMain.adoqUser.SQL.Clear;
        fmMain.adoqUser.SQL.Text:='select * from User where UserName='''+trim(edtUserName.Text)+'''';
        fmMain.adoqUser.Open;}

        fmMain.adoqUserQuery(edtUserName.Text);

        if  fmMain.adoqUser.RecordCount<=1 then
        begin
              if  fmMain.adoqUser.RecordCount=1 then
              begin
                    if edtUserName.Text<>UserName then
                    begin
                        showmessage('您的帐户名与原有帐户重名了，请换一个帐户名!');
                        fmMain.adoqUser.Close;
                        exit;
                    end
                    else
                    begin
                        if  (edtUserName.Text<>'') and (edtUserID.Text<>'') and (edtPopHost.Text<>'') and (edtSmtpHost.Text<>'') and  (edtPwd.Text<>'') and (edtUserAddress.Text<>'') then
                         begin
                         {fmMain.adoqUser.Close;
                         fmMain.adoqUser.SQL.Clear;
                         fmMain.adoqUser.SQL.Text:='select * from User where UserName='''+trim(fmMain.tvUser.Selected.Text)+'''';
                         fmMain.adoqUser.Open;}

                                fmMain.adoqUserQuery(fmMain.tvUser.Selected.Text);

                                fmMain.adoqUser.Edit;
                                fmMain.adoqUser.FieldByName('UserName').AsString:=trim(edtUserName.Text);
                                fmMain.adoqUser.FieldByName('UserID').AsString:=trim(edtUserID.Text);
                                fmMain.adoqUser.FieldByName('UserAddress').AsString:=trim(edtUserAddress.Text);
                         //temp:=fmMain.Encrypt(temp,100);
                        //fmMain.adoqUser.FieldByName('Pwd').AsString:=trim(temp);
                       { temp:=trim(edtPwd.Text);
                        temp:=fmMain.Encrypt(temp,100);}
                                fmMain.adoqUser.FieldByName('Pwd').AsString:=trim(edtPwd.Text);
                                fmMain.adoqUser.FieldByName('PopHost').AsString:=trim(edtPopHost.Text);
                                fmMain.adoqUser.FieldByName('SmtpHost').AsString:=trim(edtSmtpHost.Text);
                                fmMain.adoqUser.Post;
                                fmMain.adoqUser.Close;

                                fmMain.adoqMail.Close;
                                fmMain.adoqMail.SQL.Clear;
                                fmMain.adoqMail.SQL.Text:='Update Mail set UserName='''+trim(edtUserName.Text)+''' where UserName='''+UserName+'''';
                                fmMain.adoqMail.ExecSQL;
                                fmMain.adoqMail.Close;

                                fmMain.adoqAF.Close;
                                fmMain.adoqAF.SQL.Clear;
                                fmMain.adoqAF.SQL.Text:='Update AFP set UserName='''+trim(edtUserName.Text)+''' where UserName='''+UserName+'''';
                                fmMain.adoqAF.ExecSQL;
                                fmMain.adoqAF.Close;

                                fmMain.tvUser.Items.Clear;
                                fmMain.UpdatetvUser(Sender);
                        end
                         else
                         begin
                        ShowMessage('内容不能为空');    //无效处理
                        end;


              end;
              end
              else
              begin

                if  (edtUserName.Text<>'') and (edtUserID.Text<>'') and (edtPopHost.Text<>'') and (edtSmtpHost.Text<>'') and  (edtPwd.Text<>'') and (edtUserAddress.Text<>'') then
                        begin

              {fmMain.adoqUser.Close;
              fmMain.adoqUser.SQL.Clear;
              fmMain.adoqUser.SQL.Text:='select * from User where UserName='''+trim(fmMain.tvUser.Selected.Text)+'''';
              fmMain.adoqUser.Open;}

              fmMain.adoqUserQuery(fmMain.tvUser.Selected.Text);

              fmMain.adoqUser.Edit;
              fmMain.adoqUser.FieldByName('UserName').AsString:=trim(edtUserName.Text);
              fmMain.adoqUser.FieldByName('UserID').AsString:=trim(edtUserID.Text);
              fmMain.adoqUser.FieldByName('UserAddress').AsString:=trim(edtUserAddress.Text);
             { temp:=trim(edtPwd.Text);
              temp:=fmMain.Encrypt(temp,100);}
              fmMain.adoqUser.FieldByName('Pwd').AsString:=trim(edtPwd.Text);
              fmMain.adoqUser.FieldByName('PopHost').AsString:=trim(edtPopHost.Text);
              fmMain.adoqUser.FieldByName('SmtpHost').AsString:=trim(edtSmtpHost.Text);
              fmMain.adoqUser.Post;
              fmMain.adoqUser.Close;

              fmMain.adoqMail.Close;
              fmMain.adoqMail.SQL.Clear;
              fmMain.adoqMail.SQL.Text:='Update Mail set UserName='''+trim(edtUserName.Text)+''' where UserName='''+UserName+'''';
              fmMain.adoqMail.ExecSQL;
              fmMain.adoqMail.Close;

              fmMain.adoqAF.Close;
              fmMain.adoqAF.SQL.Clear;
              fmMain.adoqAF.SQL.Text:='Update AFP set UserName='''+trim(edtUserName.Text)+''' where UserName='''+UserName+'''';
              fmMain.adoqAF.ExecSQL;
              fmMain.adoqAF.Close;




              UserName:=edtUserName.Text;
              UserID:=edtUserID.Text;
              Pwd:=edtPwd.Text;
              UserAddress:=edtUserAddress.Text;
              PopHost:=edtPopHost.Text;
              SmtpHost:=edtSmtpHost.Text;

              {fmMain.tvUser.Selected.Text:=edtUserName.Text;
              
              fmMain.tvUser.Update;}

              fmMain.tvUser.Items.Clear;
              fmMain.UpdatetvUser(Sender);

              close;

             end
              else
                begin
                        ShowMessage('内容不能为空');    //无效处理
                end;
              end
        end

        else
        begin

               showmessage('您的帐户名与原有帐户重名了，请换一个帐户名!');
               fmMain.adoqUser.Close;
        end;


end;

procedure TfmUserSet.btnOKClick(Sender: TObject);
begin
        close;
end;

end.
