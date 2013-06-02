unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComputerId;

type
  TForm1 = class(TForm)
    ComputerId1: TComputerId;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Button3: TButton;
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormActivate(Sender: TObject);
begin
  Edit1.Text:=ComputerId1.CPUSerialNumber;
  Edit2.Text:=ComputerId1.MacAddress;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Edit1.Text:=ComputerId1.CPUSerialNumber;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Edit2.Text:=ComputerId1.MacAddress;
end;

end.
