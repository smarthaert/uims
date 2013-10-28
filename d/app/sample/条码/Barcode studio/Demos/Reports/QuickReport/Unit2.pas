unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, ExtCtrls, psReportQuick, QRCtrls, StdCtrls, Buttons,
  psCodeRes, psCodeFN, ComCtrls, DB, DBTables, DBCtrls, Grids, DBGrids,
  psBarcode, psBarcodeFmt;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    StatusBar1: TStatusBar;
    ZAL: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    DBNavigator1: TDBNavigator;
    Table1: TTable;
    RadioGroup1: TRadioGroup;
    SH_SAMPLE: TTabSheet;
    BarcodeSample: TpsBarcode;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    QR: TQuickRep;
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
  QR.Preview;
end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
  QR.Print;
end;

procedure TForm2.BitBtn3Click(Sender: TObject);
begin
  QR.PrinterSetup;
end;

procedure TForm2.BitBtn5Click(Sender: TObject);
begin
  ZAL.ActivePage := SH_SAMPLE;
  EditBarcode(BarcodeSample);
end;

procedure TForm2.BitBtn6Click(Sender: TObject);
begin
  bsHelp('quickreport');
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
    Caption := {constAboutBarcodeStudio + } 'Barcode studio - Demo project for Quick report';
end;

end.
