unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons, Math, ExtCtrls, psBarcode;

const IntelligentMailMask='';

type
  TForm1 = class(TForm)
    ED: TEdit;
    BitBtn1: TBitBtn;
    BC: TpsBarcode;
    Image2: TImage;
    procedure EDChange(Sender: TObject);
  private
  public
    { Public declarations }
  end;


var
  Form1: TForm1;

implementation

{$R *.dfm}



procedure TForm1.EDChange(Sender: TObject);
begin
  BC.BarCode:=ED.Text;
end;

end.
