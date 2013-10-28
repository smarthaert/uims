unit Unit1;

interface
//Download by http://www.codefans.net
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Inifiles;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Timer1: TTimer;
    CheckBox1: TCheckBox;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  myinifile:TInifile;

implementation

{$R *.dfm}

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  // 每格一秒增加1
  Edit2.Text := IntToStr(StrToInt(Edit2.Text) + 1);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  FileName:string;
begin
  // 获取当前程序所在路径
  FileName := 'c:\myini.ini';
  // 创建myinifile对象，并创建或打开myini.ini文件
  myinifile := TInifile.Create(FileName);
  // 读取值
  Edit1.Text := myinifile.ReadString('程序参数', '用户名称', '缺省的用户名称');
  Edit2.Text := IntToStr(myinifile.ReadInteger('程序参数', '已运行时间', 0));
  Checkbox1.Checked := myinifile.ReadBool('程序参数', '是否正式用户', False);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // 在程序关闭时写入myini.ini文件
  myinifile.WriteString('程序参数', '用户名称', Edit1.Text);
  myinifile.WriteInteger('程序参数', '已运行时间', StrToInt(Edit2.Text));
  myinifile.WriteBool('程序参数', '是否正式用户', CheckBox1.Checked);

  // 释放myinifile对象
  myinifile.Destroy; 
end;

end.
