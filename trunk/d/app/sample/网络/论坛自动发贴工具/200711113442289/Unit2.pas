unit Unit2;

interface

uses  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,ShellAPI,JPEG, ExtCtrls,Wininet,
  ComCtrls, OleCtrls, IdHTTP, IdCookieManager, IdBaseComponent,
  IdComponent,IdTCPConnection, IdTCPClient,IniFiles;

type
  requestform = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;
  function request:integer;
  function login:integer;
  function reg:integer;
var
 passcount:integer;
 cou:integer;
implementation

uses Unit1;

function request:integer;
var
  Response: TStringStream;
  mepostdata:tstrings;
  loginurl:string;
  name:string;
  ini:Tinifile;
  bb:string;
begin
        loginurl:='http://www.discuz.net/bbs/post.php?action=newthread&fid=4&extra=page%3D1&topicsubmit=yes';
          mePostData:= TStringlist.Create;
          with mePostData do
            begin
             Clear;
              Add('formhash='+form1.Edit5.text);
              Add('isblog=');
              Add('fid=4');
              Add('subject='+form1.Edit3.text);
              Add('iconid=0');
              Add('message='+form1.Edit4.text);
              Add('wysiwyg=0');
              Add('input=http://www.discuz.net/post.php?action=newthread&fid=26&extra=page%3D1');
            end;
          Response := TStringStream.Create('');
          try
            form1.IdHTTP1.HandleRedirects:=true;
            form1.IdAntiFreeze1.OnlyWhenIdle:=False;
            form1.IdHTTP1.Post(loginurl, mePostData, Response);
            if pos('非常感谢，您的主题已经发布，现在将转入主题页',response.DataString)>0 then
             begin
              form1.Memo1.Lines.Add('非常感谢，您的主题已经发布，现在将转入主题页');
              bb:=copy(response.DataString,pos('',response.DataString)+9,8);
              bb:=form1.IdHTTP1.Get('http://www.discuz.net/logging.php?action=logout&formhash='+bb);
              form1.memo1.Lines.Add(bb);
             end
            else if pos('对不起，您两次发表间隔少于',response.DataString)>0 then
             begin
              form1.Memo1.Lines.Add('对不起，您两次发表间隔少于 15 秒，请不要灌水！');
              bb:=copy(response.DataString,pos('',response.DataString)+9,8);
              bb:=form1.IdHTTP1.Get('http://www.discuz.net/logging.php?action=logout&formhash='+bb);
              form1.memo1.Lines.Add(bb);
             end

            else if pos('您所在的用户组(禁止发言)无法进行此操作',response.DataString)>0 then
              begin
              form1.Memo1.Lines.Add('您所在的用户组(禁止发言)无法进行此操作');
              reg;
              end
            else if pos('现在将转入登录前页面',response.DataString)>0 then
              begin
              form1.Memo1.Lines.Add('现在将转入登录前页面');
              end
            else
              form1.memo1.Lines.Text:=response.DataString;
    except
      Response.Free;
      mePostData.Free;
    end;
end;

function reg:integer;
var
  Response: TStringStream;
  mepostdata:tstrings;
  loginurl:string;
  name:string;
  ini:Tinifile;
  DateTime : TDateTime;
  str: string;
  kk:integer;
  bb:string;
begin
ini:=Tinifile.create(ExtractFilePath(Paramstr(0))+'config.ini');
  DateTime := Time;
  str := TimeToStr(DateTime);
  kk:=strtoint(copy(str,length(str)-1,2));
  if kk<10 then kk:=kk+10;
  name:=Achr[Random(kk)]+Achr[Random(kk)]+Achr[Random(kk)]+Achr[Random(kk)]+Achr[Random(kk)]+Achr[Random(kk)]+Achr[Random(kk)]+Achr[Random(kk)]+Achr[Random(kk)]+Achr[Random(kk)];
  form1.Edit1.Text:=name;
  form1.Edit2.Text:=name;
ini.WriteString('充值信息','user',trim(form1.edit1.text));
ini.WriteString('充值信息','pass',trim(form1.edit2.text));
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
            else if pos('现在将转入登录前页面',response.DataString)>0 then
            begin
              form1.Memo1.Lines.Add('现在将转入登录前页面');
              login;
            end
            else if pos('非常感谢您的注册，现在将以会员身份登录论坛',response.DataString)>0 then
             begin
              form1.Memo1.Lines.Add('非常感谢您的注册，现在将以会员身份登录论坛');
              login;
             end
            else
              form1.memo1.Lines.Text:=response.DataString;
    except
      Response.Free;
      mePostData.Free;
    end;
end;


function login;
var
  Response: TStringStream;
  mepostdata:tstrings;
  loginurl:string;
begin
        loginurl:='http://www.discuz.net/logging.php?action=login';

          mePostData:= TStringlist.Create;
          with mePostData do
            begin
             Clear;
              Add('referer=index.php');
              Add('loginmode=');
              Add('styleid=');
              Add('cookietime=2592000');
              Add('loginfield=username');
              Add('username='+trim(form1.Edit1.text));
              Add('password='+trim(form1.Edit2.text));
              Add('questionid=0');
              Add('answer=');
              Add('loginsubmit=提 &nbsp; 交');
            end;
          Response := TStringStream.Create('');
          try
            form1.IdHTTP1.HandleRedirects:=true;
            form1.IdAntiFreeze1.OnlyWhenIdle:=False;
            form1.IdHTTP1.Post(loginurl, mePostData, Response);
            if pos('欢迎您回来',response.DataString)>0 then
              begin
              form1.memo1.Lines.Add('登录成功！');
              form1.Edit5.Text:=copy(response.DataString,pos('formhash=',response.DataString)+9,8);
              request;
              end
            else if pos('累计 5 次错误尝试，15 分钟内您将不能登录论坛',response.DataString)>0 then
              form1.memo1.Lines.Add('累计 5 次错误尝试，15 分钟内您将不能登录论坛')
            else
            form1.Memo1.Lines.Add(response.DataString);
    finally
      Response.Free;
      mePostData.Free;

end;
end;

procedure requestform.Execute;
var
ss:boolean;
begin
while ss do
begin
request;
end;
end;

end.
