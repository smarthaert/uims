unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, SUIButton, StdCtrls, SUIMemo, OleCtrls, SHDocVw_EWB, EwbCore,
  EmbeddedWB, IdCookieManager, ShellApi;

type
  Tmainfrm = class(TForm)
    idhtp: TIdHTTP;
    btnaction: TsuiButton;
    embdwb1: TEmbeddedWB;
    idckmngr1: TIdCookieManager;
    procedure btnactionClick(Sender: TObject);
    procedure httpget(url: string);
    procedure httppost(url: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  mainfrm: Tmainfrm;

implementation

{$R *.dfm}

procedure Tmainfrm.btnactionClick(Sender: TObject);
var
  o: OleVariant;
begin
  //httpget('http://www.baidu.com');
  embdwb1.Navigate('http://www.baidu.com');
  while embdwb1.ReadyState <> 4 do
    Application.ProcessMessages;


  o := embdwb1.OleObject.document.getelementbyid('kw');
  o.value := 'guaiguai';
  o := embdwb1.OleObject.document.getelementbyid('su');
  o.click;
  ShellExecute(0,'open','rundll32.exe','inetcpl.cpl,ClearMyTracksByProcess 2',nil,1);
end;

procedure Tmainfrm.httpget(url: string);      
var
  RStream: TStringStream;
begin                                  
  RStream := TStringStream.Create('');
  idhtp := TIdHTTP.Create(nil);
  idhtp.Request.CustomHeaders.Text :=
    'Accept: image/jpeg, application/x-ms-application, image/gif, application/xaml+xml, image/pjpeg, application/x-ms-xbap, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, */*' +
    #13 + #10 + 'Referer:http://url' +
    #13 + #10 + 'Accept-Language: zh-CN' +
    #13 + #10 + 'User-Agent: Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)' +
    #13 + #10 + 'Accept-Encoding: gzip, deflate' +
    #13 + #10 + 'Host: ***' +
    #13 + #10 + 'Connection: Keep-Alive' +
    #13 + #10 + 'Authorization: Basic *****=';
  idhtp.get(url,RStream);
  //mmo.Text := RStream.DataString;
  FreeAndNil(idhtp);
end;

procedure Tmainfrm.httppost(url: string);
var
  Param: TStringList;
  RStream: TStringStream;
begin
  Param := TStringList.Create;
  RStream := TStringStream.Create('');   
  idhtp := TIdHTTP.Create(nil);

  Param.Add('username=showlee000');
  Param.Add('normModPsp=********');
  Param.Add('mem_pass=true');
  idhtp.Post(url, Param, RStream);

  //mmo.Text := RStream.DataString;
  FreeAndNil(idhtp);
end;

end.

