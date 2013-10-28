unit ReportBuilderMainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, DB, Grids, DBGrids, DBCtrls,
  Menus, DBTables,
  psBarcode, psCodeFN, psBoxes, psCodeRes, psTypes, psCodeSpecs,
  psReportBuilder, psBarcodeFmt, TypInfo,
  ppPrnabl,
  ppClass, ppCtrls, ppDB, ppViewr, ppDBPipe, ppDBBDE, ppEndUsr,
  ppParameter, ppBands, ppCache, ppComm, ppRelatv, ppProd, ppReport, ppStrtch,
  ppBarCod, ppTypes, ppRichTx, ppVar, ppTxPipe;

type
  TForm5 = class(TForm)
    btnPanel: TPanel;
    btnEdit: TBitBtn;
    btnHome: TBitBtn;
    btnOrder: TBitBtn;
    btnEncyclopedia: TBitBtn;
    btnSymbologies: TBitBtn;
    MainPageControl: TPageControl;
    SheetMain: TTabSheet;
    SheetData: TTabSheet;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Table1: TTable;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    psBarcodeLabel3: TpsBarcodeLabel;
    btnEmail: TBitBtn;
    BitBtn1: TBitBtn;
    TabSheet1: TTabSheet;
    ppReport2: TppReport;
    ppParameterList1: TppParameterList;
    ppDesigner: TppDesigner;
    ppBDEPipeline1: TppBDEPipeline;
    ppViewer1: TppViewer;
    GroupBox2: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    psComboSelectedSymbology: TpsComboBox;
    psBarcodeValueToEncode: TMemo;
    GroupBox3: TGroupBox;
    Label12: TLabel;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    lblName: TpsBarcodeLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblLongName: TpsBarcodeLabel;
    lblSymbolType: TpsBarcodeLabel;
    Label6: TLabel;
    Label7: TLabel;
    lblCharset: TpsBarcodeLabel;
    Panel2: TPanel;
    psBarcode: TpsBarcode;
    RG_REPORTS: TRadioGroup;
    btnPreview: TBitBtn;
    btnPrint: TBitBtn;
    BitBtn3: TBitBtn;
    ppTextPipeline1: TppTextPipeline;
    ppTextPipeline1ppField1: TppField;
    ppTextPipeline1ppField2: TppField;
    ppTextPipeline1ppField3: TppField;
    ppTextPipeline1ppField4: TppField;
    ppReport3: TppReport;
    ppParameterList2: TppParameterList;
    ppTitleBand1: TppTitleBand;
    ppLabel5: TppLabel;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand2: TppDetailBand;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText1: TppDBText;
    psRBBarcodeRpt3: TpsRBBarcode;
    ppFooterBand1: TppFooterBand;
    ppTextPipeline1ppField5: TppField;
    ppReport1: TppReport;
    ppParameterList3: TppParameterList;
    ppHeaderBand2: TppHeaderBand;
    ppLabel7: TppLabel;
    psRBBarcode1: TpsRBBarcode;
    ppLabel8: TppLabel;
    psRBBarcode2: TpsRBBarcode;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    psRBBarcode3: TpsRBBarcode;
    ppLabel11: TppLabel;
    psRBBarcode4: TpsRBBarcode;
    psRBBarcode5: TpsRBBarcode;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    psRBBarcode6: TpsRBBarcode;
    psRBBarcode7: TpsRBBarcode;
    psRBBarcode8: TpsRBBarcode;
    psRBBarcode9: TpsRBBarcode;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLabel16: TppLabel;
    psRBBarcode10: TpsRBBarcode;
    ppLabel17: TppLabel;
    psRBBarcode11: TpsRBBarcode;
    ppLabel18: TppLabel;
    psRBBarcode12: TpsRBBarcode;
    ppLabel19: TppLabel;
    psRBBarcode13: TpsRBBarcode;
    ppDetailBand3: TppDetailBand;
    ppFooterBand2: TppFooterBand;
    ppTitleBand2: TppTitleBand;
    ppLabel1: TppLabel;
    ppShape1: TppShape;
    ppRichText1: TppRichText;
    ppHeaderBand3: TppHeaderBand;
    ppLine1: TppLine;
    ppLabel20: TppLabel;
    ppLabel21: TppLabel;
    ppLabel22: TppLabel;
    ppLabel23: TppLabel;
    ppLabel24: TppLabel;
    ppLabel25: TppLabel;
    ppLabel26: TppLabel;
    ppLabel27: TppLabel;
    ppLabel28: TppLabel;
    ppDetailBand1: TppDetailBand;
    ppDBText5: TppDBText;
    ppDBImage1: TppDBImage;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    psRbDBBarcode1: TpsRbDBBarcode;
    psRbDBBarcode2: TpsRbDBBarcode;
    psRbDBBarcode3: TpsRbDBBarcode;
    ppFooterBand3: TppFooterBand;
    ppLine2: TppLine;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    ppTextPipeline1ppField6: TppField;
    ppDBText9: TppDBText;
    ppDBText4: TppDBText;
    ppTextPipeline1ppField7: TppField;
    ppReport5: TppReport;
    ppParameterList4: TppParameterList;
    ppHeaderBand4: TppHeaderBand;
    ppDetailBand4: TppDetailBand;
    ppFooterBand4: TppFooterBand;
    ppTitleBand3: TppTitleBand;
    ppLabel2: TppLabel;
    ppSystemVariable3: TppSystemVariable;
    ppSystemVariable4: TppSystemVariable;
    ppDBText10: TppDBText;
    ppLabel3: TppLabel;
    ppDBText11: TppDBText;
    ppLabel4: TppLabel;
    ppDBText12: TppDBText;
    ppLabel6: TppLabel;
    ppDBText13: TppDBText;
    ppDBText14: TppDBText;
    ppLabel30: TppLabel;
    ppDBText15: TppDBText;
    ppLabel31: TppLabel;
    ppLine3: TppLine;
    ppLine4: TppLine;
    ppReport4: TppReport;
    ppParameterList5: TppParameterList;
    ppDetailBand5: TppDetailBand;
    ppDBText16: TppDBText;
    psRBBarcode14: TpsRBBarcode;
    ppReport6: TppReport;
    ppParameterList6: TppParameterList;
    ppDetailBand6: TppDetailBand;
    ppDBText17: TppDBText;
    psRBBarcode15: TpsRBBarcode;
    procedure psComboSelectedSymbologyChange(Sender: TObject);
    procedure psBarcodeValueToEncodeChange(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnOrderClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RG_REPORTSClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure psRBBarcodeRpt3Print(Sender: TObject);
    procedure psRBBarcode14Print(Sender: TObject);
    procedure psRBBarcode15Print(Sender: TObject);
  private
    // CurrentSymbology : TpsBarcodeSymbology;
    Rpt : TppReport;
    procedure UpdateControls(bs:TpsBarcodeSymbology);
    procedure RG_SelectReport;
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.BitBtn1Click(Sender: TObject);
begin
  if MessageDlg('Can you exit ?', mtWarning, [mbYes, mbNo], 0) = mrYes then
      Application.Terminate;
end;

procedure TForm5.BitBtn2Click(Sender: TObject);
begin
  EditBarcode(psBarcode);
end;

procedure TForm5.BitBtn3Click(Sender: TObject);
begin
  rpt.DeviceType := dtPrinter;
  rpt.Print;
end;

procedure TForm5.btnOrderClick(Sender: TObject);
var s:string;
begin
  s := '';
  if Sender=btnOrder then s:='http://www.psoft.sk/register.php';
  if Sender=btnEmail then s:='mailto:barcode@psoft.sk';
  if Sender=btnHome  then s:='http://www.psoft.sk';
  if Sender=btnEncyclopedia then s:='http://barcode-software.eu/encyclopedia';

  if s<>'' then
    ConnectWebLink(s);
end;

procedure TForm5.btnPreviewClick(Sender: TObject);
begin
  ppViewer1.Report := rpt;
  rpt.DeviceType   := dtScreen;
  rpt.Print;
end;

procedure TForm5.btnPrintClick(Sender: TObject);
begin
  ppDesigner.Report := rpt;
  ppDesigner.ShowModal;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  Caption  := ' Barcode studio : Report Builder demo project, http://barcode-software.eu';
  psCreateSymbologyList('symbologies.txt');

  rpt      := ppReport1;
  psComboSelectedSymbology.SelectedSymbology := bcEan13;
  UpdateControls(psComboSelectedSymbology.SelectedSymbology);
end;

procedure TForm5.psBarcodeValueToEncodeChange(Sender: TObject);
begin
  try
    psBarcode.Barcode := psBarcodeValueToEncode.Text;
  finally
    ;
  end;
end;

procedure TForm5.psComboSelectedSymbologyChange(Sender: TObject);
begin
  UpdateControls(psComboSelectedSymbology.SelectedSymbology);
end;

procedure TForm5.psRBBarcode14Print(Sender: TObject);
begin
  psRBBarcode14.BarcodeSymbology :=
      TpsBarcodeSymbology( ppTextPipeline1['bcSymbologyID'] );
end;

procedure TForm5.psRBBarcode15Print(Sender: TObject);
begin
  psRBBarcode15.BarcodeSymbology :=
      TpsBarcodeSymbology( ppTextPipeline1['bcSymbologyID'] );
end;

procedure TForm5.psRBBarcodeRpt3Print(Sender: TObject);
// var s:string;
begin
  // s := ;
  psRBBarcodeRpt3.BarcodeSymbology :=
      TpsBarcodeSymbology( ppTextPipeline1['bcSymbologyID'] );
  // ShowMessage(IntToStr( ppTextPipeline1['bcSymbologyID'] ) );
end;

procedure TForm5.RG_REPORTSClick(Sender: TObject);
begin
  RG_SelectReport;
end;

procedure TForm5.RG_SelectReport;
var s:string;
begin
    case RG_REPORTS.ItemIndex of
        0 : rpt := ppReport1;
        1 : rpt := ppReport2;
        2 : rpt := ppReport3;
        3 : rpt := ppReport4;
        4 : rpt := ppReport5;
        5 : rpt := ppReport6;
    end;

  ppViewer1.Report := rpt;

//    s:='report'+IntToStr(RG_REPORTS.ItemIndex)+'.rtm';
//    ppReport.Template.Filename := s;
//    ppReport.Template.LoadFromFile;
end;


procedure TForm5.UpdateControls(bs: TpsBarcodeSymbology);
begin
  psBarcode.BarcodeSymbology  := bs;
  psBarcodeValueToEncode.Text := psBarcode.BarCode;

  // update info panel

  lblName.BarcodeSymbology := bs;
  lblLongName.BarcodeSymbology := bs;
  lblSymbolType.BarcodeSymbology := bs;
  lblCharset.BarcodeSymbology := bs;

end;

end.
