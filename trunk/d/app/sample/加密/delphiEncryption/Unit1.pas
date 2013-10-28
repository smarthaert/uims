unit Unit1;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    Button3: TButton;
    Label1: TLabel;
    Memo2: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    Memo3: TMemo;
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
begin
  close;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
   s:string;
  i,j:integer;
begin
   memo2.Clear;
    for i:=0 to memo1.Lines.Count-1 do
      begin
        s:=memo1.lines.Strings[i];
        for j:=1 to length(s) do
          s[j]:=chr(ord(s[j])xor 255);
          memo2.Lines.Add(s);
       end;
    application.MessageBox('加密成功！','明日科技');
end;

procedure TForm1.Button3Click(Sender: TObject);
var
   s:string;
   i,j:integer;
begin
       memo3.Clear;
    for i:=0 to memo2.Lines.Count-1 do
      begin
        s:=memo2.lines.Strings[i];
        for j:=1 to length(s) do
          s[j]:=chr(ord(s[j])xor 255);
          memo3.Lines.Add(s);
       end;
   application.MessageBox('解密成功！','明日科技');
end;
end.
