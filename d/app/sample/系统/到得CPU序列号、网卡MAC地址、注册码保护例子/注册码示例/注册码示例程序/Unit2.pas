unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Editid: TEdit;
    Editcode: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  if Editcode.Text=TForm1(owner).Decrypt(Editid.Text,100) then
    ModalResult:=mrOk
  else
    MessageBox(Handle,pchar('对不起，注册码不正确，请把机器标识发给联系作者，以获得注册码'),pchar('系统提示'),mb_ok or mb_iconwarning);

end;

end.
