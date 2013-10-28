unit Unit1;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, StdCtrls,msxml,uLkJSON,ExtCtrls;
type
  TComboBox = class(StdCtrls.TComboBox)
  private
    Values: TStringList;
  public
    constructor Create(AOwner: TComponent);override;

  end;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    Memo1: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    List: TStringList;
    HttpReq: IXMLHttpRequest;
  end;



var
  Form1: TForm1;

implementation
uses DateUtils;
{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  url: string;
  Json: TlkJSONobject;
  s:string;
  i:integer;
begin
  url := 'http://m.weather.com.cn/data/101270401.html';
  HttpReq.open('Get', Url, False, EmptyParam, EmptyParam);
  HttpReq.send(EmptyParam);//开始搜索
  Url := HttpReq.responseText;
  Json := Tlkjson.ParseText(URL) as TlkJSONobject;
  Memo1.Lines.Clear;
  //if Json.SelfType = jsObject then
  //begin
    //Showmessage(Json.Field['city'].Value);

    s:=TlkJSON.GenerateText(json);
   i := 0;
   s := GenerateReadableText(json,i);
    s:=   Json.getString('date_y');
    Memo1.Lines.Add('今日天气('+Json.getString('date_y')+' '+Json.getstring('week')+')：');
    Memo1.Lines.Add('     温度：'+Json.getstring('temp1'));
    Memo1.Lines.Add('     天气：'+Json.getstring('weather1'));
    //Memo1.Lines.Add('     风向：'+Vartostr(Json.Field['fx1'].Value)+ ' '+Vartostr(Json.Field['wind1'].Value));
    Memo1.Lines.Add('     风力：'+Json.getstring('wind1'));

    Memo1.Lines.Add('明日天气('+FormatDateTime('YYYY年MM月DD日 ',DateUtils.IncDay(now))+')：');
    Memo1.Lines.Add('     温度：'+Json.getstring('temp2'));
    Memo1.Lines.Add('     天气：'+Json.getstring('weather2'));
    //Memo1.Lines.Add('     风向：'+Vartostr(Json.Field['fx2'].Value)+ ' '+Vartostr(Json.Field['wind2'].Value));
    Memo1.Lines.Add('     风力：'+Json.getstring('wind2'));

    Memo1.Lines.Add(FormatDateTime('YYYY年MM月DD日 ',DateUtils.IncDay(now,2))+'：');
    Memo1.Lines.Add('     温度：'+Json.getString ('temp3'));
    Memo1.Lines.Add('     天气：'+Json.getstring('weather3'));
    //if True then

    //Memo1.Lines.Add('     风向：'+Json.getstring('fx3'+ ' '+Json.getstring('wind3');
    Memo1.Lines.Add('     风力：'+Json.getstring('wind3'));
    
    Memo1.Lines.Add(FormatDateTime('YYYY年MM月DD日 ',DateUtils.IncDay(now,3))+'：');
    Memo1.Lines.Add('     温度：'+Json.getstring('temp4'));
    Memo1.Lines.Add('     天气：'+Json.getstring('weather4'));
    //Memo1.Lines.Add('     风向：'+Json.getstring('fx4'+ ' '+Json.getstring('wind4');
    Memo1.Lines.Add('     风力：'+Json.getstring('wind4'));

    Memo1.Lines.Add(FormatDateTime('YYYY年MM月DD日 ',DateUtils.IncDay(now,4))+'：');
    Memo1.Lines.Add('     温度：'+Json.getstring('temp5'));
    Memo1.Lines.Add('     天气：'+Json.getstring('weather5'));
    //Memo1.Lines.Add('     风向：'+Json.getstring('fx5'+ ' '+Json.getstring('wind5');
    Memo1.Lines.Add('     风力：'+Json.getstring('wind5'));
  //end;
  json.Free;

end;


{ TComboBox }
constructor TComboBox.Create(AOwner: TComponent);
begin
  inherited;
  Values := TStringList.Create;
end;








procedure TForm1.FormCreate(Sender: TObject);
begin
  //http1:=tidhttp.create(self);
  //temp:=HTTP1.Get('http://www.ipseeker.cn');
  //http1.free;
  //temp:=Mmo1.Text;
  //i:=Pos('查询结果',temp);
  //str_1:=Copy(temp,i,254);
  //str_2:=pro_result(str_1);
  //Mmo2.Text:=str_2;
  //Caption := Trim(str_2);
  HttpReq := CoXMLHTTPRequest.Create;
  Button1.Click;
end;


end.
