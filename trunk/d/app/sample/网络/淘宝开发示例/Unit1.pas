unit Unit1;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,shellapi, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP,md5;
const
  secrect_key='test';
  app_key='test';
type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
function URLDecode(const S: string): string;
var
Idx: Integer;   // loops thru chars in string
Hex: string;    // string of hex characters
Code: Integer; // hex character code (-1 on error)
begin
// Intialise result and string index
Result := '';
Idx := 1;
// Loop thru string decoding each character
while Idx <= Length(S) do
begin
    case S[Idx] of
      '%':
      begin
        // % should be followed by two hex digits - exception otherwise
        if Idx <= Length(S) - 2 then
        begin
          // there are sufficient digits - try to decode hex digits
          Hex := S[Idx+1] + S[Idx+2];
          Code := SysUtils.StrToIntDef('$' + Hex, -1);
          Inc(Idx, 2);
        end
        else
          // insufficient digits - error
          Code := -1;
        // check for error and raise exception if found
        if Code = -1 then
          raise SysUtils.EConvertError.Create(
            'Invalid hex digit in URL'
          );
        // decoded OK - add character to result
        Result := Result + Chr(Code);
      end;
      '+':
        // + is decoded as a space
        Result := Result + ' '
      else
        // All other characters pass thru unchanged
        Result := Result + S[Idx];
    end;
    Inc(Idx);
end;
end;


function URLEncode(const S: string; const InQueryString: Boolean): string;
var
Idx: Integer; // loops thru characters in string
begin
Result := '';
for Idx := 1 to Length(S) do
begin
    case S[Idx] of
      'A'..'Z', 'a'..'z', '0'..'9', '-', '_', '.':
        Result := Result + S[Idx];
      ' ':
        if InQueryString then
          Result := Result + '+'
        else
          Result := Result + '%20';
      else
        Result := Result + '%' + SysUtils.IntToHex(Ord(S[Idx]), 2);
    end;
end;
end;
 

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShellExecute(handle,'open','http://open.taobao.com/isv/authorize.php?appkey='+app_key,nil,nil,SW_SHOWNORMAL);
end;

procedure TForm1.Button2Click(Sender: TObject);
 var memstr: TMemoryStream;
    ss,ss2,ss3: string;
begin
 ShortDateFormat:='yyyy-mm-dd';
  memstr:= TMemoryStream.Create;

 //用授权码获取 session
  IdHTTP1.Get('http://container.api.tbsandbox.com/container?authcode='+memo1.Text,memstr);
  setlength(ss,memstr.Size);
  memstr.Position:= 0;
  memstr.Read(ss[1],memstr.Size);
   ss:= Utf8ToAnsi(ss);

  //切分session top_session=282730527fc47c5e27838f5dd8aeb098afefd&top_sign=LiTSTYs/DQHpRAGA4OPEZA==
  ss:= copy(ss,pos('top_session=',ss)+12,255);
  ss:= copy(ss,1,pos('&',ss)-1);
  memo1.Lines.Add(ss);
  //制作签名
  ss2:=secrect_key+'app_key'+app_Key +
       'fields'+'tid,seller_nick,buyer_nick,status,orders.title,orders.price,orders.num'+
        'format'+ 'xml'+
	      'method'+'taobao.trades.sold.get'+
       	'session'+ss+
        'sign_method'+'md5'+
        'timestamp'+datetimetostr(now)+
	      'v'+ '2.0'+ secrect_key;
	    
  ss2:= UpperCase(StrMD5(ss2));    //生成签名md5

   //合成参数 如果参数内有中文，需进行utf8编码
   ss3:= 'app_key='+app_Key +
       '&fields='+'tid,seller_nick,buyer_nick,status,orders.title,orders.price,orders.num'+
        '&format='+ 'xml'+
	      '&method='+'taobao.trades.sold.get'+
       	'&session='+ss+
        '&sign_method='+'md5'+
        '&timestamp='+ URLEncode(datetimetostr(now),true)+
	      '&v='+ '2.0'+
        '&sign='+ ss2;

   //取得数据
    memstr.Clear;
    IdHTTP1.Get('http://gw.api.tbsandbox.com/router/rest?'+ss3,memstr);
    setlength(ss,memstr.Size);
  memstr.Position:= 0;
  memstr.Read(ss[1],memstr.Size);
   ss:= Utf8ToAnsi(ss);
   memo1.Lines.Add(ss);
 memstr.Free;
end;

end.
