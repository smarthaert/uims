unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  usnam: string;
  pssword: string;

implementation

uses client;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
   if edit1.Text='' then exit;
   if edit2.Text='' then exit;
   if edit2.Text=edit3.Text then
    begin
      usnam:=edit1.Text;
      pssword:=edit2.Text;
      form1.clientsocket1.Socket.SendText(usnam+'??**##'+pssword);
      close;
    end
   else
    begin
      showmessage('两次密码输入不同，请重新输入');
      edit2.Clear;
      edit3.Clear;
    end;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  close;
end;

end.
