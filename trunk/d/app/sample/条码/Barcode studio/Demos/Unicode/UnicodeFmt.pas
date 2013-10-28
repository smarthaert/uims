unit UnicodeFmt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, psBarcode, psTypes, psBarcodeComp, StdCtrls, Character, ComCtrls;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DATAMATRIX: TpsBarcode;
    QRCODE: TpsBarcode;
    Label1: TLabel;
    TabSheet3: TTabSheet;
    PDF417: TpsBarcode;
    procedure FormCreate(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private
    procedure UpdateBarcodes;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
    UpdateBarcodes;
end;

procedure TForm2.Memo1Change(Sender: TObject);
begin
    UpdateBarcodes;
end;

procedure TForm2.UpdateBarcodes;
var s : string;
begin
    s := Memo1.Text;
    DATAMATRIX.BarCode := s;
    QRCODE.BarCode     := s;
    PDF417.Barcode     := s;
end;


end.
