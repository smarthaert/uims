unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, GIFImage, WinInet, jpeg,
  IdCookieManager;

type
  TForm1 = class(TForm)
    aIdHTTP: TIdHTTP;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Edit3: TEdit;
    Memo1: TMemo;
    IdCookieManager1: TIdCookieManager;
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
var
  postList: Tstrings;
  Response: TStringStream;
  done: Boolean;
  code: string;
begin
  try
    postList := TStringList.Create;
    Response := TStringStream.Create('');
    postList.Add('UserName=' + Edit1.Text);
    postList.add('PassWord=' + Edit2.Text);
    postList.Add('CodeStr=' + Edit3.Text);
    //postList.Add('Submit=');
    aIdHTTP.Request.SetHeaders;
    aIdHTTP.Request.RawHeaders.Clear;
    aIdHTTP.HandleRedirects := true;
    aIdHTTP.Request.Accept := 'application/x-shockwave-flash, image/gif, image/jpeg, image/pjpeg, image/pjpeg, application/msword, application/vnd.ms-excel, application/xaml+xml, application/x-ms-xbap, application/x-ms-application, application/vnd.ms-xpsdocument, */*';
    aIdHTTP.Request.Referer := 'http://snsqw.com/snjob/adminn/Admin_Login.asp';
    aIdHTTP.Request.AcceptLanguage := 'zh-cn';
    aIdHTTP.Request.UserAgent := 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET4.0C; .NET4.0E; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; 360SE)';
    aIdHTTP.Request.ContentType := 'application/x-www-form-urlencoded';
    aIdHTTP.Request.AcceptEncoding := 'gzip, deflate';
    aIdHTTP.Request.Host := 'snsqw.com';
    aIdHTTP.Request.ContentLength := 72;
    aIdHTTP.Request.Connection := 'Keep-Alive';
    aIdHTTP.Request.CacheControl := 'no-cache';
    aIdHTTP.ReadTimeout := 30000;
    aIdHTTP.HTTPOptions:=aIdHTTP.HTTPOptions+[hoKeepOrigProtocol];
    aIdHTTP.ProtocolVersion:=pv1_1;
    aIdHTTP.Post('http://snsqw.com/snjob/adminn/Login_Check.asp', postList, Response);
    done := True;
  except
    done := false;
  end;
  if (done) and (Pos('200 OK', aIdHTTP.ResponseText) <> 0) then
    begin
      code := aIdHTTP.Get('http://snsqw.com/snjob/adminn/Index.asp');
      memo1.Clear;
      memo1.lines.add(code);
    end
  else
    begin
      memo1.lines.add('logon error,error code：' + aIdHTTP.Response.RawHeaders.Text);
    end;
  Response.Free;
  postList.Free;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  imagestream: TMemoryStream;
  Buffer: Word;
  jpg: TjpegImage;
  gif: TgifImage;
begin
  image1.Picture.Graphic := nil;
  imagestream := TMemoryStream.Create();
  try
    aIdHTTP.HandleRedirects :=True;
    aIdHTTP.Request.Accept := '*/*';
    aIdHTTP.Request.AcceptLanguage := 'zh-cn';
    aIdHTTP.Request.UserAgent := 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)';
    aIdHTTP.Request.Connection := 'Keep-Alive';
    aIdHTTP.Request.Referer := 'http://snsqw.com/snjob/adminn/Admin_Login.asp';
    aIdHTTP.Request.Host := 'snsqw.com';
    aIdHTTP.HTTPOptions := aIdHTTP.HTTPOptions + [hoKeepOrigProtocol];
    aIdHTTP.ProtocolVersion := pv1_1;
    try
      aIdHTTP.Get('http://snsqw.com/snjob/inc/CheckCode.asp', imagestream);
    except
      showmessage('连接失败！');
      exit;
    end;

    imagestream.Position := 0;
    if imagestream.Size = 0 then
      begin
        imagestream.Free;
        ShowMessage('错误!');
        exit;
      end;

    imagestream.ReadBuffer(Buffer, 2);
    imagestream.Position := 0;

    if Buffer = $4D42 then //bmp
      begin
        image1.Picture.Bitmap.LoadFromStream(imagestream);
      end
    else if Buffer = $D8FF then //jpg
      begin
        jpg := TjpegImage.Create;
        jpg.LoadFromStream(imagestream);
        image1.Picture.Assign(jpg);
        jpg.Free;
      end
    else if Buffer = $4947 then //gif
      begin
        gif := TGifImage.Create;
        gif.LoadFromStream(imagestream);
        image1.Picture.Assign(gif);
        gif.Free;
      end
    else if Buffer = $050A then
      begin
        ShowMessage('PCX');
      end
    else if Buffer = $5089 then
      begin
        ShowMessage('PNG');
      end
    else if Buffer = $4238 then
      begin
        ShowMessage('PSD');
      end
    else if Buffer = $A659 then
      begin
        ShowMessage('RAS');
      end
    else if Buffer = $DA01 then
      begin
        ShowMessage('SGI');
      end
    else if Buffer = $4949 then
      begin
        ShowMessage('TIFF');
      end
    else
      begin
        ShowMessage('ERROR');
      end;

  finally
    imagestream.Free;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  HTTP: TidHTTP;
  html, s: string;
  i: integer;
begin
  HTTP := TidHTTP.Create(nil);
  try
    HTTP.HandleRedirects := True;
    HTTP.AllowCookies := True;
    HTTP.Request.CustomHeaders.Values['Cookie'] := 'abcd'; //修改Cookie 抓包可见
    html := HTTP.Get('http://snsqw.com/snjob/adminn/Admin_Login.asp');
    s := 'Cookies: ';
    if HTTP.CookieManager.CookieCollection.Count > 0 then
      for i := 0 to HTTP.CookieManager.CookieCollection.Count - 1 do
        s := s + HTTP.CookieManager.CookieCollection.Items[i].CookieText;
    Memo1.Lines.Add(s); //取得Cookie
  finally
    FreeAndNil(HTTP);
  end;
end;

end.

