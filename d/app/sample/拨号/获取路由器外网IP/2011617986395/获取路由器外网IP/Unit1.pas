unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComObj, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetIP: string;
    function GetIP2: string;

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

function TForm1.GetIP: string;
var
  xml: OleVariant;
  r: string;
  p1, p2: Integer;
begin
  xml := CreateOleObject('Microsoft.XMLHTTP');
  xml.Open('GET', 'http://www.net.cn/static/customercare/yourIP.asp', False);
  xml.Send;
  r := xml.responseText;
  Memo1.Lines.Clear;
  Memo1.Lines.Add(r);
  p1 := Pos('<h2>', r); // 找到 h2 标签
  p2 := Pos('</h2>', r); // 找到 h2 结束标签
  Result := Copy(r, p1 + 4, p2 - p1 - 4);
end;


function TForm1.GetIP2: string;
var
  xml: OleVariant;
  r: string;
  p1, p2: Integer;
begin
  xml := CreateOleObject('Microsoft.XMLHTTP');
  xml.Open('GET', 'http://www.ip38.com', False);
  xml.Send;
  r := (xml.responseText);
  p1 := Pos('<h2>', r); // 找到 h2 标签
  p2 := Pos('</h2>', r); // 找到 h2 结束标签   Result := Copy(r, p1+17, p2-p1-84);
  Result := Copy(r, p1 + 25, p2 - p1 - 94);
end;



procedure TForm1.Button1Click(Sender: TObject);
begin
  edit1.Text := GetIP;
  Edit2.Text := GetIP2;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Close;
end;

end.

 