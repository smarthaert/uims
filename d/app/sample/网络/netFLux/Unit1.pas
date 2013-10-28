unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,netFlux, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
begin
  frmNetFlux := TFrmNetFlux.create(nil);
  frmNetFlux.Parent:= self.Panel1;
  frmNetFlux.show;
end;

end.
