unit Unit1;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppPrnabl, ppClass, ppCtrls, ppBarCode2D, ppCache, ppBands,
  ppComm, ppRelatv, ppProd, ppReport, StdCtrls;

type
  TForm1 = class(TForm)
    btn1: TButton;
    prprt1: TppReport;
    pdtlbnd1: TppDetailBand;
    p2dbrcd1: Tpp2DBarCode;
    procedure prprt1BeforePrint(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.prprt1BeforePrint(Sender: TObject);
begin
    p2dbrcd1.Data :='asdfasdf'; //传值给条码
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
    prprt1.Print ;
end;

end.
