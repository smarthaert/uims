unit MainFmt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ShellAPI, Buttons, ComCtrls, frxClass, frxDesgn,
  psCodeRes, psBoxes, psTypes, psCodeSpecs,
  DB, DBTables, DBCtrls, Grids,
  DBGrids, frxDBSet,
  psReportFast, frxPreview, psBarcode;

type

  TForm1 = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    r1: TfrxReport;
    r2: TfrxReport;
    r3: TfrxReport;
    designer: TfrxDesigner;
    SB: TStatusBar;
    DataSource1: TDataSource;
    Table1: TTable;
    Reports: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label9: TLabel;
    lblProduct: TLabel;
    psBarcodeWebLabel8: TpsBarcodeWebLabel;
    Panel2: TPanel;
    Label1: TLabel;
    Shape1: TShape;
    Image1: TImage;
    psBarcodeWebLabel1: TpsBarcodeWebLabel;
    psBarcodeWebLabel2: TpsBarcodeWebLabel;
    psBarcodeWebLabel3: TpsBarcodeWebLabel;
    psBarcodeWebLabel4: TpsBarcodeWebLabel;
    psBarcodeWebLabel5: TpsBarcodeWebLabel;
    psBarcodeWebLabel6: TpsBarcodeWebLabel;
    psBarcodeWebLabel7: TpsBarcodeWebLabel;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    DBNavigator1: TDBNavigator;
    frxDBDataset1: TfrxDBDataset;
    frxUserDataSet1: TfrxUserDataSet;
    BitBtn2: TBitBtn;
    rpt001: TfrxReport;
    // TabSheet2: TTabSheet;
    frxPreview1: TfrxPreview;
    Panel4: TPanel;
    btnPrepare: TButton;
    btnDesign: TButton;
    btnPreview: TButton;
    btnPrint: TButton;
    cbReports: TComboBox;
    rpt000: TfrxReport;
    rpt002: TfrxReport;
    rpt003: TfrxReport;
    rpt004: TfrxReport;
    rpt005: TfrxReport;
    psBarcode1: TpsBarcode;
    psBarcode2: TpsBarcode;
    psBarcode3: TpsBarcode;
    bcpdf: TpsBarcode;
    psBarcode5: TpsBarcode;
    psBarcode4: TpsBarcode;
    procedure Label2MouseEnter(Sender: TObject);
    procedure Label2MouseLeave(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Show(Sender: TObject);
    procedure frxUserDataSet1GetValue(const VarName: string;
      var Value: Variant);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnPrepareClick(Sender: TObject);
    procedure cbReportsChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

// uses Rpt1, Rpt2, Rpt3;

{$R *.dfm}

type TFormClass=class of TForm;

procedure ShowFormModal(F:TFormClass);
var fmt:Tform;
begin
  fmt:=F.Create(Application);
  try
    fmt.ShowModal;
  finally
    fmt.Free;
  end;
end;

procedure TForm1.Label2MouseEnter(Sender: TObject);
var L:TLabel;
begin
  L:= Sender as TLabel;
  L.Font.Color := clBlue;
  L.Font.Style := [fsUnderline];
end;

procedure TForm1.Label2MouseLeave(Sender: TObject);
var L:TLabel;
begin
  L:= Sender as TLabel;
  L.Font.Color := clBlack;
  L.Font.Style := [];
end;

procedure TForm1.frxUserDataSet1GetValue(const VarName: string;
  var Value: Variant);
var BI:TpsBarcodeInfo;
begin
  BI:=BarcodeInfo(TpsBarcodeSymbology(frxUserDataSet1.RecNo), '');
  if CompareText(VarName, 'SymbologyName') = 0 then
    Value := BI.Name;
end;

procedure TForm1.Label2Click(Sender: TObject);
var L:TLabel;
begin
  L:= Sender as TLabel;
  ShellExecute(Application.Handle,'open', PChar(L.Hint),
    nil,nil,SW_SHOWNORMAL);end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  // psShowSymbologiesMap;
end;

procedure TForm1.btnPrepareClick(Sender: TObject);
var rpt:TfrxReport;
begin
  case cbReports.ItemIndex of
    0 : rpt := rpt000;
    1 : rpt := rpt001;
    2 : rpt := rpt002;
    3 : rpt := rpt003;
    4 : rpt := rpt004;
    5 : rpt := rpt005;
  end;

  if Sender=btnPrepare then begin
      rpt.Preview := frxPreview1;
      rpt.PrepareReport;
  end;

  if Sender=btnDesign then
      rpt.DesignReport;

  if Sender=btnPreview then begin
      rpt.Preview := nil;
      rpt.ShowReport;
      rpt.Preview := frxPreview1;
  end;

  if Sender=btnPrint then begin
      rpt001.Print;
  end;

end;

procedure TForm1.cbReportsChange(Sender: TObject);
begin
    // btnPrepare.Click;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Caption             := 'Barcode studio - Fast report demo';
  lblProduct.Caption  := 'Fast report components';
  cbReports.ItemIndex := 3;
  btnPrepareClick(btnPrepare);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
              {i := 0;
              for s:=Low(TpsBarcodeSymbology) to High(TpsBarcodeSymbology) do
                Inc(i);
              frxUserDataSet1.RangeEnd      := reCount;
              frxUserDataSet1.RangeEndCount := i;
              ShowMessage(IntToStr(i));
              r2.ShowReport;
          end;
  end;         }

end;

procedure TForm1.Show(Sender: TObject);
begin
  if not Table1.Active then
    Table1.Active:=True;
end;

end.
