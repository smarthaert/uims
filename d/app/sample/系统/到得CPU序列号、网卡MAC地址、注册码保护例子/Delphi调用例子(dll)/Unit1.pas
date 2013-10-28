unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label2: TLabel;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Button2: TButton;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  function GetCPUSerialNumber:pchar;stdcall;external 'ComputerId.dll' name 'GetCPUSerialNumber';
  function GetMacAddress:pchar;stdcall;external 'ComputerId.dll' name 'GetMacAddress';
var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Edit1.Text:=GetCPUSerialNumber;

end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  Edit1.Text:=GetCPUSerialNumber;
  Edit2.Text:=GetMacAddress;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Edit2.Text:=GetMacAddress;
end;

end.
