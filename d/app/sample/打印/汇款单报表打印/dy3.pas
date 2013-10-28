unit dy3;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, QRCtrls, ExtCtrls, StdCtrls, DB, DBTables, Buttons;

type
  TForm1 = class(TForm)
    Table1: TTable;
    QuickRep1: TQuickRep;
    TitleBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRLabel2: TQRLabel;
    QRShape3: TQRShape;
    QRLabel4: TQRLabel;
    QRLabel3: TQRLabel;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRMemo1: TQRMemo;
    QRLabel7: TQRLabel;
    QRMemo3: TQRMemo;
    QRMemo5: TQRMemo;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    DBtext1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn4: TBitBtn;
    QRShape4: TQRShape;
    QRShape21: TQRShape;
    QRLabel20: TQRLabel;
    QRShape22: TQRShape;
    QRDBText1: TQRDBText;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRShape23: TQRShape;
    QRShape24: TQRShape;
    QRShape25: TQRShape;
    QRShape26: TQRShape;
    QRLabel23: TQRLabel;
    QRDBText9: TQRDBText;
    QRLabel24: TQRLabel;
    QRDBText10: TQRDBText;
    QRShape27: TQRShape;
    QRMemo2: TQRMemo;
    QRShape28: TQRShape;
    QRLabel25: TQRLabel;
    QRShape29: TQRShape;
    QRMemo4: TQRMemo;
    QRDBText11: TQRDBText;
    QRShape30: TQRShape;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRDBText12: TQRDBText;
    QRShape31: TQRShape;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRDBText13: TQRDBText;
    QRShape32: TQRShape;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRDBText14: TQRDBText;
    QRMemo6: TQRMemo;
    QRDBText15: TQRDBText;
    QRShape33: TQRShape;
    QRShape34: TQRShape;
    QRShape35: TQRShape;
    QRShape36: TQRShape;
    QRShape37: TQRShape;
    QRLabel32: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    QRLabel37: TQRLabel;
    Table2: TTable;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    QRShape38: TQRShape;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  QuickRep1.Preview;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  QuickRep1.Print ;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
  if Not Table1.Bof then
    Table1.Prior;
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
  if Not Table1.Eof then
    Table1.Next;
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
  if Not Table2.Bof then
    Table2.Prior;
end;

procedure TForm1.BitBtn7Click(Sender: TObject);
begin
  if Not Table2.Eof then
    Table2.Next;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  Close;
end;

end.
