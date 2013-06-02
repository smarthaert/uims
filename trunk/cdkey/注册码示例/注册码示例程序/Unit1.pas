
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
  Dialogs, StdCtrls,Registry,GetCPUSerialNumberp;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button888888: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button33333: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button33333Click(Sender: TObject);
    procedure Button888888Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    RegisterCode:String;
    HasReg:boolean;
    function Decrypt(const s: string; key: word): string;
    procedure CheckReg;
  end;

var
  Form1: TForm1;

implementation

uses Unit2;

{$R *.dfm}

//机器标识加密，得到注册码
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


procedure TForm1.FormCreate(Sender: TObject);
var
 ARegistry:TRegistry;
begin
  ARegistry := TRegistry.Create;
  with ARegistry do
  begin
    RootKey:=HKEY_LOCAL_MACHINE;
    if OpenKey('Software\RegisterExample',false ) then
      RegisterCode:=ReadString('RegisterCode');
    ARegistry.Free;
  end;
  //根据机器标识算出注册码，和已保存的注册码比较，看是否已注册
  HasReg:=RegisterCode=Decrypt(GetCPUSerialNumber,100);
  CheckReg;
end;

//注册
procedure TForm1.Button33333Click(Sender: TObject);
var
 ARegistry:TRegistry;
begin
  with TForm2.Create(self) do
  begin
    Editid.Text:=GetCPUSerialNumber;
    if showmodal=mrOk then  //如输入的注册码正确，则把注册码保存到注册表
    begin
      ARegistry := TRegistry.Create;
      with ARegistry do
      begin
        RootKey:=HKEY_LOCAL_MACHINE;
        if OpenKey('Software\RegisterExample',True) then
          WriteString('RegisterCode',Editcode.text);
        Free;
      end;
      HasReg:=True;
      CheckReg;
    end;
    Free;
  end;
end;

procedure TForm1.Button888888Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.CheckReg;
begin
  Button33333.Visible:=not HasReg;
  Button1.Enabled:=HasReg;
  Edit1.Enabled:=HasReg;
  Edit2.Enabled:=HasReg;
  Label3.Visible:=not HasReg;
end;

end.
