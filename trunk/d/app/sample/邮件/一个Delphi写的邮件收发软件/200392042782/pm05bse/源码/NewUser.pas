{------------------------P-Mail 0.5 beta版-----------------
编程工具：Delphi 6 + D6_upd2 
制作：广西百色 PLQ工作室
声明：本代码纯属免费，仅供学习使用，希望您在使用她时保留这段话
如果您对本程序作了改进，也希望您能与我联系
My E-Mail:plq163001@163.com
	  plq163003@163.com
-----------------------------------------------------2002.5.19}


unit NewUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfmAddNewUser = class(TForm)
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
    btnClear: TBitBtn;
    btnOK: TBitBtn;
    procedure btnSetClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAddNewUser: TfmAddNewUser;

implementation

uses main;

{$R *.dfm}

{新建帐户:判断是否与原帐户重名，
否->则将相应信息插入UserMail table
 的一条新记录建立一个TreeNode of tvUser}



procedure TfmAddNewUser.btnSetClick(Sender: TObject);
{var
        temp:string;}
begin
        {fmMain.adoqUser.Close;
        fmMain.adoqUser.SQL.Clear;
        fmMain.adoqUser.SQL.Text:='select * from User where UserName='''+trim(edtUserName.Text)+'''';
        fmMain.adoqUser.Open;}

        fmMain.adoqUserQuery(edtUserName.Text);

        if fmMain.adoqUser.RecordCount=0 then
        begin
                if  (edtUserName.Text<>'') and (edtUserID.Text<>'') and (edtPopHost.Text<>'') and (edtSmtpHost.Text<>'') and  (edtPwd.Text<>'') and (edtUserAddress.Text<>'') then
                begin
                fmMain.adoqUser.Edit;
                fmMain.adoqUser.Insert;
                fmMain.adoqUser.FieldByName('UserName').AsString:=trim(edtUserName.Text);
                fmMain.adoqUser.FieldByName('UserID').AsString:=trim(edtUserID.Text);
                fmMain.adoqUser.FieldByName('UserAddress').AsString:=trim(edtUserAddress.Text);
                {temp:=trim(edtPwd.Text);
                temp:=fmMain.Encrypt(temp,200);}
                fmMain.adoqUser.FieldByName('Pwd').AsString:=trim(edtPwd.Text);
                fmMain.adoqUser.FieldByName('PopHost').AsString:=trim(edtPopHost.Text);
                fmMain.adoqUser.FieldByName('SmtpHost').AsString:=trim(edtSmtpHost.Text);
                fmMain.adoqUser.Post;
                fmMain.adoqUser.Close;

                
                fmMain.tvUser.Items.Clear;
                fmMain.UpdatetvUser(Sender);
                end
                else
                begin
                        ShowMessage('内容不能为空');    //无效处理
                end;


        end

        else
        begin
                fmMain.adoqUser.Close;
                showmessage('您的帐户名与原有帐户重名了，请换一个帐户名!');
        end;
end;

procedure TfmAddNewUser.btnClearClick(Sender: TObject);
begin
        edtUserName.Text:='';
        edtUserID.Text:='';
        edtUserAddress.Text:='';
        edtPwd.Text:='';
        edtPopHost.Text:='';
        edtSmtpHost.Text:='';
end;

procedure TfmAddNewUser.btnOKClick(Sender: TObject);
begin
        close;
end;

end.
