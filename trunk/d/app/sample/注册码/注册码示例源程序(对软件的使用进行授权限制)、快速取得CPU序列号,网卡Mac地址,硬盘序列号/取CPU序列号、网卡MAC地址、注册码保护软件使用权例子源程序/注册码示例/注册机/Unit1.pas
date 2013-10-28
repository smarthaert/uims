
  {*****************************************************************************}
  {作者：许运乾，QQ:415270083, 或E-mail:CxLing03@163.com或qian0303@sohu.com             }
  {在软件保护中,我们常常要用到机器的标识。根据作者的经验，在好些服务器上无法取  }
  {得硬盘序列号。特别是在那些使用了并列存储技术或做了镜象的硬盘。网卡也容易更换 }
  {，因此作者建议使用CPU序列号。在这里，作者提供了获得CPU序列号和网卡Mac地址的方}
  {法。1.Delphi中可这个控件或这个动态库。控件提供了两个属性，MacAddress和       }
  {CPUSerialNumber。2.Delphi外的语言，请使用这个动态库。动态库提供了两个函数，  }
  {GetCPUSerialNumber和GetMacAddress，这些函数和控件，在win2000和winXP中测试通过}
  {，在多CPU、多硬盘、使用了并列存储技术的大型服务器上，也测试通过。            }
  {*****************************************************************************}

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Editid: TEdit;
    Editcode: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Decrypt(const s: string; key: word): string;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
function TForm1.Decrypt(const s: string; key: word): string;
var
  i:byte;
  R:String;
const
  C1=50;
  C2=50;
begin
  SetLength(R,Length(s));
  for i:=1 to Length(s) do
  begin
    R[i]:=char(byte(s[i]) xor (key shr 8));
    key:=(byte(s[i])+key)+C1+C2
  end;
  Result:=R;
end;
procedure TForm1.Button1Click(Sender: TObject);
begin
  if Trim(Editid.Text)='' then
  begin
    MessageBox(Handle,pchar('对不起，机器标识不能为空'),pchar('系统提示'),mb_ok or mb_iconwarning);
    Editid.SetFocus;
    Exit;
  end;
  Editcode.Text:=Decrypt(Trim(Editid.Text),100);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Close;
end;

end.
 