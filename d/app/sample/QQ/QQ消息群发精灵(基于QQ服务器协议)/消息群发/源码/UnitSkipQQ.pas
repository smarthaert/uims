//**********************************
//源码名称：QQ消息群发精灵(基于QQ服务器协议)
//开发环境：Delphi7.0+WinXP
//源码作者：源码天空
//官方网站：http://www.codesky.net
//特别感谢：微程 提供QQ协议分析
//请尊重原作者的劳动，你可以任意修改源码，但请保持以上信息的完整性。
// **********************************
unit UnitSkipQQ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,inifiles;

Const inifn='config.ini';

type
  TfrmSetSkipQQ = class(TForm)
    meoSkipQQ: TMemo;
    Label1: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure ReadData;
    procedure SaveData;
  public
    { Public declarations }
    procedure SetSkipQQ;

  end;

var
  frmSetSkipQQ: TfrmSetSkipQQ;

implementation

{$R *.dfm}
procedure TfrmSetSkipQQ.SetSkipQQ;
begin
ReadData;
self.ShowModal;
end;

procedure TfrmSetSkipQQ.ReadData;
var
fini:tinifile;
filename:String;
SkipQQ:String;
begin
filename:=extractfilepath(application.Exename)+inifn;
try
fini:=tinifile.Create(filename);
SkipQQ:=fini.ReadString('Config','SkipQQ','');
SkipQQ:=stringreplace(SkipQQ,',',#13#10,[rfReplaceAll]);
meoSkipQQ.Lines.Text:=SkipQQ;
finally
fini.Free;
end;
end;

procedure TfrmSetSkipQQ.SaveData;
var
fini:tinifile;
filename:String;
SkipQQ:String;
begin
filename:=extractfilepath(application.Exename)+inifn;
SkipQQ:=meoSkipQQ.Lines.Text;
SkipQQ:=stringreplace(SkipQQ,#13#10,',',[rfReplaceAll]);
try
fini:=tinifile.Create(filename);
fini.WriteString('Config','SkipQQ',SkipQQ);
finally
fini.Free;
end;
end;

procedure TfrmSetSkipQQ.Button1Click(Sender: TObject);
begin
SaveData;
end;

end.
