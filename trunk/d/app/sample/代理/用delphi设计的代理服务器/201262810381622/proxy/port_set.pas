unit port_set;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  Tport_setup = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  port_setup: Tport_setup;

implementation

uses main;


{$R *.DFM}

procedure Tport_setup.Button1Click(Sender: TObject);
begin
    if edit1.text='' then showmessage('²»ÄÜÎª¿Õ!')
    else form1.portn:=strtoint(edit1.text);


end;

procedure Tport_setup.Button2Click(Sender: TObject);
begin
      form1.portn:=998;
      edit1.text:='998';
end;

procedure Tport_setup.Button3Click(Sender: TObject);
begin
     close;
end;

end.
