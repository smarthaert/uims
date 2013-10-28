unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SctCtrl, psReportACE, SctVar, ExtCtrls, SctRep, ComCtrls, StdCtrls,
  Buttons, DB, DBTables, Grids, DBGrids, AcePrev,

  psCodeFN,

  AceRptU;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Data: TTabSheet;
    Symbologies: TTabSheet;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    About: TTabSheet;
    DBGrid1: TDBGrid;
    Table1: TTable;
    DataSource1: TDataSource;
    RG_REPORTS: TRadioGroup;
    btnPreview: TBitBtn;
    btnPrint: TBitBtn;
    BitBtn3: TBitBtn;
    AcePreview1: TAcePreview;
    BitBtn1: TBitBtn;
    btnEmail: TBitBtn;
    btnHome: TBitBtn;
    btnOrder: TBitBtn;
    btnEncyclopedia: TBitBtn;
    procedure btnEmailClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnEmailClick(Sender: TObject);
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

procedure TForm1.btnPrintClick(Sender: TObject);
begin
  Rpt1.ShowModal;
end;

end.
