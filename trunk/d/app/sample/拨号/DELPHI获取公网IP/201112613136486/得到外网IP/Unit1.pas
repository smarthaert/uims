unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,UrlMon ,ComObj ;

type
  TForm1 = class(TForm)
    edt1: TEdit;
    btn1: TButton;
    btn2: TButton;
    edt2: TEdit;
    procedure btn2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
function DownloadFile(SourceFile, DestFile: string): Boolean; //下载函数
begin //可以下载网页,图片等任何文件,如 上海门禁系统
try
    result := UrlDownloadToFile(nil,PChar(SourceFile),PChar(DestFile), 0, nil) = 0;
   except
    result := False;
   end;
end;

function Fenli(Src: string; Before, After: string): string; //字符串分离函数
var
Pos1, Pos2: Word;
Temp: string;
begin //使用方法:Fenli('www.zhuanhou.cn','www.','.cn') 得到的结果为:zhuanhou
Temp := Src;
Pos1 := Pos(Before, Temp);
Delete(Temp, 1, Pos1 + Length(Before));
Pos2 := Pos(After, Temp);
if (Pos1 = 0) or (Pos2 = 0) then
begin
result := '';
Exit;
end;
Pos1 := Pos1 + Length(Before);
result := Copy(Src, Pos1, Pos2);
end;





procedure TForm1.btn2Click(Sender: TObject);
var
   i:Integer;
   LadTxt:TstringList;
begin
//下载文件,我认为这种方法下载的文件其实就相当于webbrowser访问这个地址
//IP.txt 为保存的文件
DownloadFile('http://www.ip138.com/ip2city.asp','IP.txt');
LadTxt:=TStringList.Create;
LadTxt.LoadFromFile('IP.txt');
//循环读取 IP.txt 文件
for i:=0 to LadTxt.Count -1 do
   begin
     //如果当前行包含 您的IP地址是：并且包含 ]
     if (Pos('您的IP地址是：',LadTxt[i])>0) and (Pos(']',LadTxt[i])>0) then
      begin
       edt2.Text:=Fenli(LadTxt[i],'[',']');    //赋值 分离得到当前IP地址
       Text:='获取外网IP地址成功! www.akux.cn';//更改标题
       Exit;                                   //退出循环
      end;
   end;

end;


function GetIP: string; //获取外网IP
var
xml : OleVariant;
r:string;
p1,p2 : Integer;
begin
xml := CreateOleObject('Microsoft.XMLHTTP');
xml.Open('GET',' http://www.ip138.com/ip2city.asp', False);
xml.Send;
r := xml.responseText;
p1:=Pos('[',r);
p2:=Pos(']',r);
Result := Copy(r, p1+1, p2-p1-1);
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  edt1.Text:= GetIP;
end;

end.
