unit UntRegFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Registry, UntReg ;

type
  TForm1 = class(TForm)
    Btn1: TButton;
    Btn2: TButton;
    Btn3: TButton;
    Btn4: TButton;
    Edt1: TEdit;
    Edt2: TEdit;
    Edt3: TEdit;
    Edt4: TEdit;
    Btn5: TButton;
    Btn6: TButton;
    Btn7: TButton;
    procedure Btn1Click(Sender: TObject);
    procedure Btn2Click(Sender: TObject);
    procedure Btn3Click(Sender: TObject);
    procedure Btn4Click(Sender: TObject);
    procedure Btn5Click(Sender: TObject);
    procedure Btn7Click(Sender: TObject);
    procedure Btn6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Btn1Click(Sender: TObject);
begin
  Edt1.Text := GetIdeSerialNumber;
end;

procedure TForm1.Btn2Click(Sender: TObject);
begin
  if Registration(uppercase(Edt3.Text)) then
    Edt4.Text := 'True'
  else Edt4.Text := 'False';
end;

procedure TForm1.Btn3Click(Sender: TObject);
begin
  Edt2.Text := SnToAscii(Edt1.Text);
end;

procedure TForm1.Btn4Click(Sender: TObject);
begin
  Edt3.Text:=AsciiToRegCode(Edt2.Text);
end;
procedure TForm1.Btn5Click(Sender: TObject);
begin
  if RegToRegTab(Edt2.Text,Edt3.Text) then
    ShowMessage('写注册表成功')
  else ShowMessage('写注册表失败');
end;

procedure TForm1.Btn6Click(Sender: TObject);
begin
  if InitToRegTab then
    ShowMessage('初始化成功')
  else ShowMessage('初始化失败');
end;

procedure TForm1.Btn7Click(Sender: TObject);
begin
  if VerifyRegInfo then
    ShowMessage('已注册')
  else ShowMessage('未注册');
end;

end.
