unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,ShellAPI,JPEG, ExtCtrls,Wininet,
  ComCtrls, OleCtrls, pngimage,IdHTTP, IdCookieManager, IdBaseComponent,
  IdComponent,IdTCPConnection, IdTCPClient,unit2, IdAntiFreezeBase, IniFiles ,
  IdAntiFreeze ;
type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    GroupBox6: TGroupBox;
    Button2: TButton;
    IdHTTP1: TIdHTTP;
    Button1: TButton;
    Button6: TButton;
    GroupBox4: TGroupBox;
    Memo1: TMemo;
    Button7: TButton;
    IdAntiFreeze1: TIdAntiFreeze;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Label4: TLabel;
    Timer1: TTimer;
    Button3: TButton;
    Label5: TLabel;
    Edit5: TEdit;
    Button4: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    thread1:requestform;
  public
    { Public declarations }
  end;
var
  Form1: TForm1;
  Achr  : array[0..60] of Char = ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
                                  'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
                                  'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3',
                                  'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
                                  'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3',
                                  '4', '5', '6', '7', '8', '9', 'g', 'h', 'i', 'j',
                                  '3');

implementation


{$R *.dfm}


procedure TForm1.Button2Click(Sender: TObject);
begin
login;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
thread1:=requestform.Create(true);
thread1.Resume;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
thread1.Suspend;//暂停
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
thread1.Resume; //恢复
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
form1.Memo1.Text:='';
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  ini:Tinifile;
begin
ini:=Tinifile.create(ExtractFilePath(Paramstr(0))+'config.ini');
ini.WriteString('充值信息','user',trim(form1.edit1.text));
ini.WriteString('充值信息','pass',trim(form1.edit2.text));
ini.WriteString('充值信息','con',trim(form1.edit3.text));
ini.WriteString('充值信息','con1',trim(form1.edit4.text));
showmessage('保存成功！');
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  ini:Tinifile;
begin
ini:=Tinifile.create(ExtractFilePath(Paramstr(0))+'config.ini');
form1.Edit1.Text:=ini.ReadString('充值信息','user','');
form1.Edit2.Text:=ini.ReadString('充值信息','pass','');
form1.Edit3.Text:=ini.ReadString('充值信息','con','');
form1.Edit4.Text:=ini.ReadString('充值信息','con1','');
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  Response: TStringStream;
  mepostdata:tstrings;
  loginurl:string;
  name:string;
  ini:Tinifile;
begin
        loginurl:='http://www.discuz.net/register.php?regsubmit=yes';
          mePostData:= TStringlist.Create;
          with mePostData do
            begin
             Clear;
              Add('formhash=3bd8bc0a');
              Add('referer=http://www.discuz.net/index.php');
              Add('username='+form1.Edit1.text);
              Add('password='+form1.Edit1.text);
              Add('password2='+form1.Edit1.text);
              Add('email=asdfdsaf11@sdf.com');
              Add('questionid=0');
              Add('answer=');
              Add('gendernew=0');
              Add('bday=0000-00-00');
              Add('locationnew=');
              Add('site=');
              Add('qq=');
              Add('icq=');
              Add('yahoo=');
              Add('msn=');
              Add('taobao=');
              Add('alipay=');
              Add('bio=');
              Add('styleidnew=');
              Add('tppnew=0');
              Add('pppnew=0');
              Add('timeoffsetnew=9999');
              Add('timeformatnew=0');
              Add('dateformatnew=0');
              Add('cdateformatnew=');
              Add('pmsoundnew=1');
              Add('showemailnew=1');
              Add('newsletter=1');
              Add('signature=');
              Add('register=http://www.discuz.net/register.php');
            end;
          Response := TStringStream.Create('');
          try
            form1.IdHTTP1.HandleRedirects:=true;
            form1.IdAntiFreeze1.OnlyWhenIdle:=False;
            form1.IdHTTP1.Post(loginurl, mePostData, Response);
            if pos('该用户名已经被注册了，请返回重新填写',response.DataString)>0 then
              form1.Memo1.Lines.Add('该用户名已经被注册了，请返回重新填写')
            else if pos('非常感谢您的注册，现在将以会员身份登录论坛',response.DataString)>0 then
              form1.Memo1.Lines.Add('非常感谢您的注册，现在将以会员身份登录论坛')
            else
              form1.memo1.Lines.Text:=response.DataString;
    except
      Response.Free;
      mePostData.Free;
    end;
end;


end.
