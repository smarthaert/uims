unit SJKBFUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzPanel, Buttons, ComCtrls, AAFont, AACtrls, RzBckgnd,
  pngimage,shellapi,StdCtrls, RzLabel;

type
  TSJKBFForm = class(TForm)
    RzPanel1: TRzPanel;
    Image6: TImage;
    RzSeparator6: TRzSeparator;
    ProgressBar1: TProgressBar;
    sbtnKSBF: TSpeedButton;
    lblts: TRzLabel;
    procedure sbtnKSBFClick(Sender: TObject);
    //用进度条来显示备份的进度
    procedure mycopyfile(sourcef,targetf:string);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SJKBFForm: TSJKBFForm;
  bflf:string;//存放备份路径的变量
  ml:string;//获取运行文件所在的目录
  
implementation

uses DCEXCLEUnit;

{$R *.dfm}

procedure TSJKBFForm.mycopyfile(sourcef, targetf: string);
var
  FromF, ToF: file;
  NumRead, NumWritten: Integer;
  Buf: array[1..2048] of Char;
  n:integer;
begin
//用进度条来显示备份的进度
AssignFile(FromF, sourcef);
Reset(FromF, 1);//数据大小为1
AssignFile(ToF,targetf);//打开备份的文件
Rewrite(ToF, 1);//数据大小为1
n:=0;
repeat
    BlockRead(FromF, Buf, SizeOf(Buf), NumRead);
    ProgressBar1.Position:=sizeof(buf)*n*100 div FileSize(FromF);
    lblts.Caption:='正在备份';
    application.ProcessMessages;
    //显示进度
    BlockWrite(ToF, Buf, NumRead, NumWritten);
    inc(n);
until (NumRead = 0) or (NumWritten <> NumRead);
lblts.Caption:='备份完成';
CloseFile(FromF);
CloseFile(ToF);
end;

procedure TSJKBFForm.sbtnKSBFClick(Sender: TObject);
begin
//开始备份按钮
bflf:=trim(ExtractFilePath(Application.ExeName))+'数据库备份\'+'webstation.mdb';
try
  if bflf<>'' then
  begin
    mycopyfile(ml+'webstation.mdb',bflf);
    application.MessageBox(pchar('备份成功!'+#13+bflf),'网站注册用户查询器',mb_ok+mb_iconinformation);
    lblts.Caption:='备份完成';
  end;
except
  begin
    application.MessageBox(pchar('备份失败!'+#13+bflf),'网站注册用户查询器',mb_ok+mb_iconwarning);
    abort;
  end;
end;
end;

procedure TSJKBFForm.FormShow(Sender: TObject);
begin
ml:=ExtractFilePath(Application.ExeName);
end;

end.
