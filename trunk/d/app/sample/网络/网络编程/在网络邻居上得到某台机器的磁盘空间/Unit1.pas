unit Unit1;
{Download by http://www.codefans.net}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    Edit3: TEdit;
    Edit4: TEdit;
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

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
  dirname:pchar;
  FreeAvailable,TotalSpace:TLargeInteger;
  TotalFree: PLargeInteger;
begin
  dirname:=pchar(edit1.text);
  getmem(totalfree,100);
//为totalfree指针获得内存
try
  if GetDiskFreeSpaceEx(dirname,FreeAvailable,TotalSpace,totalfree)=true then
     edit2.text:=inttostr(FreeAvailable);
finally
  freemem(totalfree);
//无论是否有异常，都要释放内存
end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  free:Int64;
begin
   free:=diskfree(strtoint(edit3.text));
   //已经将\\Night-stalker\mp3映射成G盘，即是edit3.text应添为7
   edit4.text:=inttostr(free);
end;

end.
