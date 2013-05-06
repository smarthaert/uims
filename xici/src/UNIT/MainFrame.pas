unit MainFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdHTTP, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdSSLOpenSSLHeaders, IdIOHandler, IdIOHandlerSocket,
  IdSSLOpenSSL, RegExpr, HtmlHelper, MSHTML, SHDocVw, OleCtrls;

type
  TForm1 = class(TForm)
    testUrl: TEdit;
    action: TButton;
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocket1: TIdSSLIOHandlerSocket;
    proxyUrl: TEdit;
    WebBrowser1: TWebBrowser;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Button2: TButton;
    procedure actionClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  protected
    ProxyIp: array[0..200] of string;
    ProxyPort: array[0..200] of Integer;
    ProxyAddr: array[0..200] of string;
    function TestProxyByUrl(ip: string; port: Integer; url: string): Boolean;
    function GetAddr(ip: string; port: Integer): string;
    function ListProxys(url: string): Boolean;
    procedure GetPorxyList(url: string);
    function GetProxyInfos(TextToCheck: string): Integer;
    procedure checkProxys(doc: IHTMLDocument2);
  public
    { Public declarations }
  end;
  
var
  Form1: TForm1;
  checkFlag:Boolean;

implementation

{$R *.dfm}


procedure TForm1.actionClick(Sender: TObject);
begin
  {
  with IdHTTP1.ProxyParams do
  begin
  ProxyServer := '61.135.179.183'; //代理地址
  //ProxyServer := '125.39.68.130'; //代理地址
  ProxyPort := 80; //代理端口
  ProxyUsername := '';//你的用户名
  ProxyPassword := '';//你的密码
  end;

  IdSSLIOHandlerSocket1.SSLOptions.Method := sslvSSLv3;
  IdHTTP1.IOHandler := IdSSLIOHandlerSocket1;
  try
  s :=IdHTTP1.Get('https://login.taobao.com/member/login.jhtml');
  except on e:EIdHTTPProtocolException do
    s:='not ok';
  end;
  ShowMessage(s);//验证成功,小心啊...呵呵
  }


  //GetPorxyList(proxyUrl.Text);
  {
  isOk := testProxyByUrl('61.135.179.183', 80, 'https://login.taobao.com/member/login.jhtml');
  if isOk then
    ShowMessage('OK')
  else
    ShowMessage('Not OK');
   }
  ListProxys(proxyUrl.Text);
end;

procedure TForm1.GetPorxyList(url: string);
var
  html: string;
  Response: TStringStream;

  I: Integer;
  //isOk: Boolean;
  num: Integer;
begin
  try
    Response := TStringStream.Create('');
    IdHTTP1.Get(url, Response);
    html := Response.DataString;
    html := Utf8ToAnsi(html);
  except on e: EIdHTTPProtocolException do

  end;
  //ShowMessage(html);
  num := GetProxyInfos(html);

  for I := 0 to num do
  begin
    testProxyByUrl(ProxyIp[I], ProxyPort[I], testUrl.Text);
    //if isOk then
      //okProxys.Lines.Add(IntToStr(I) + ': ' + ProxyIp[I] + ' : ' + IntToStr(ProxyPort[I]));
      //ShowMessage(ProxyIp[I] + ':' + IntToStr(ProxyPort[I]));
  end;

end;


function TForm1.testProxyByUrl(ip: string; port: Integer; url: string): Boolean;
var
  s: string;
begin

  with IdHTTP1.ProxyParams do
  begin
    ProxyServer := ip; //代理地址
  //ProxyServer := '125.39.68.130'; //代理地址
    ProxyPort := port; //代理端口
    ProxyUsername := ''; //你的用户名
    ProxyPassword := ''; //你的密码
  end;

  IdSSLIOHandlerSocket1.SSLOptions.Method := sslvSSLv3;
  IdHTTP1.IOHandler := IdSSLIOHandlerSocket1;
  //Application.ProcessMessages;
  try
    s := IdHTTP1.Get(url);
  except on e: Exception do
      s := 'false';
  end;
  if s <> 'false' then
    Result := True
  else
    Result := False;
end;

function TForm1.GetAddr(ip: string; port: Integer): string;
var
  s: string;
  addrExpr: TRegExpr;
begin

  with IdHTTP1.ProxyParams do
  begin
    ProxyServer := ip; //代理地址
  //ProxyServer := '125.39.68.130'; //代理地址
    ProxyPort := port; //代理端口
    ProxyUsername := ''; //你的用户名
    ProxyPassword := ''; //你的密码
  end;

  try
    s := IdHTTP1.Get('http://www.baidu.com/s?wd=ip%E6%9F%A5%E8%AF%A2&rsv_bp=0&ch=&tn=baidu&bar=&rsv_spt=3&ie=utf-8&rsv_sug3=7&rsv_sug=0&rsv_sug4=13915&oq=ip&rsp=0&f=3&rsv_sug2=1&rsv_sug5=0&inputT=6003');
  except on e: Exception do
      s := 'false';
  end;
  if s <> 'false' then
  begin
    addrExpr := TRegExpr.Create;
    try
      addrExpr.Expression := 'nbsp;([^a-z0-9]*)<\/p>';
      if addrExpr.Exec(s) then
        repeat
          Result := addrExpr.Match[1];
        until not addrExpr.ExecNext;
    finally
      addrExpr.Free;
    end;
  end
  else
    Result := '';
end;


function TForm1.ListProxys(url: string): Boolean;
begin
  WebBrowser1.Navigate(url);
  Result := False;
end;


function TForm1.GetProxyInfos(TextToCheck: string): Integer;
var
  htmlExpr: TRegExpr;
  ipportExpr: TRegExpr;
  html: string;
  I: Integer;
  s: string;
begin

//获得列表
  htmlExpr := TRegExpr.Create;
  try
    htmlExpr.Expression := 'id=\"ip_list\">(.*)<\/table';
    if htmlExpr.Exec(TextToCheck) then
      repeat
//aList.Add(myExpr.Match[1]);
//ShowMessage(myExpr.Match[1]);
        html := htmlExpr.Match[1];
      until not htmlExpr.ExecNext;
  finally
    htmlExpr.Free;
  end;



//获得ip 端口
  I := 0;
  ipportExpr := TRegExpr.Create;
  try
    ipportExpr.Expression := '<td\>([0-9.]*)<\/td>';
//myExpr.Expression := '<td\>([^a-z]*)<\/td>';
    if ipportExpr.Exec(html) then
      repeat
//okProxys.Text := myExpr.Match[1];
//ShowMessage(myExpr.Match[1]);
        if I mod 2 <> 0 then
        begin
          ProxyIp[I div 2] := s;
          ProxyPort[I div 2] := StrToInt(ipportExpr.Match[1]);
        end
        else
        begin
          s := ipportExpr.Match[1];
        end;
        I := I + 1;
      until not ipportExpr.ExecNext;
  finally
    ipportExpr.Free;
  end;
  Result := I div 2;

{
//获得地点
I := 0;
addrExpr := TRegExpr.Create;
Try
//myExpr.Expression := '<td\>([0-9.]*)<\/td>';
//myExpr.Expression := '<td\>([^a-z]*)<\/td>';
addrExpr.Expression := '\">([^a-z]*)<\/a>|<td\>([^a-z0-9]*)<\/td>';
if addrExpr.Exec(html) then
repeat
//okProxys.Text := myExpr.Match[1];
//ShowMessage(addrExpr.Match[1]);
ProxyAddr[I] :=  addrExpr.Match[1];
I := I + 1;
until not addrExpr.ExecNext;
finally
addrExpr.Free;
end;
}
end;

procedure TForm1.Button1Click(Sender: TObject);
var 
  ID: THandle;
  doc: IHTMLDocument2;
begin
  doc := IHTMLDocument2(WebBrowser1.Document);
  checkProxys(doc);
end;

procedure TForm1.checkProxys(doc: IHTMLDocument2);
var
  list: IHTMLElementCollection;
  table: IHTMLTable;
  row: IHTMLTableRow;
  cell: IHTMLElement;
  s: string;
  i: Integer;
  ip, port: IHTMLElement;
  isOk: Boolean;
begin
  checkFlag := True;
  //doc := IHTMLDocument2(WebBrowser1.Document);
  list := doc.all.tags('table') as IHTMLElementCollection;

  table := list.item(0, 0) as IHTMLTable;

  for i := 1 to table.rows.length do
  //for i := 1 to 10 do
  begin
    if not checkFlag then Exit;
    row := table.rows.item(i, i) as IHTMLTableRow;
    cell := row.cells.item(0, 0) as IHTMLElement;
    //ShowMessage(cell.innerText);
    cell.innerText := '检测中'; //去掉图标
    Application.ProcessMessages;
    
    ip := row.cells.item(1, 1) as IHTMLElement;
    port := row.cells.item(2, 2) as IHTMLElement;
    isOk := testProxyByUrl(ip.innerText, StrToInt(Trim(port.innerText)), testUrl.Text);
    if isOk then
      cell.innerText := '可用==>' //去掉图标
    else
      cell.innerText := '无效'; //去掉图标;

    Application.ProcessMessages;
  end;
end;


procedure TForm1.Button2Click(Sender: TObject);
begin
  checkFlag := False;
end;

end.

