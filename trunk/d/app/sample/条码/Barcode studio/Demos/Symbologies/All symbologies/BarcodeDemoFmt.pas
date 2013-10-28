unit BarcodeDemoFmt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, psBarcode, StdCtrls, psBoxes;

type
  TForm8 = class(TForm)
    bc: TpsBarcode;
    cbSymbology: TpsComboBox;
    Label1: TLabel;
    Label2: TLabel;
    edValue: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure cbSymbologyChange(Sender: TObject);
    procedure edValueChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}

procedure TForm8.cbSymbologyChange(Sender: TObject);
begin
    bc.BarcodeSymbology := cbSymbology.SelectedSymbology;
    edValue.Text        := bc.BarCode;
end;

procedure TForm8.edValueChange(Sender: TObject);
begin
    bc.BarCode := edValue.Text;
end;

procedure TForm8.FormCreate(Sender: TObject);
begin
    cbSymbology.SelectedSymbology := bc.BarcodeSymbology;
    edValue.Text                  := bc.BarCode;
end;

end.
