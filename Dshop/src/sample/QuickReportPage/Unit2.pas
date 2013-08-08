unit Unit2;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TqrTest = class(TQuickRep)
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    ChildBand1: TQRChildBand;
    QRLabel1: TQRLabel;
    procedure DetailBand1AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure DetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public

  end;

var
  qrTest: TqrTest;

implementation

uses Unit1;

{$R *.DFM}

procedure TqrTest.DetailBand1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  i := i + 1;
  PrintCount := PrintCount+1;
end;

procedure TqrTest.DetailBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if i < n then
  begin
    PrintBand := True;
  end else
  begin
    NewPage;
    i:= 0;    
  end;
end;

procedure TqrTest.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if PrintCount >= DataSet.RecordCount then
    PrintBand := True
  else
    PrintBand := False;
end;

end.
