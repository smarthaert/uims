unit AceRptU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SctVar, ExtCtrls, SctRep, SctCtrl, psReportACE;

type
  TRpt1 = class(TForm)
    SctReport1: TSctReport;
    ReportPage: TSctGrouppage;
    ReportHeaderBand: TSctBand;
    ReportHeaderBandlevel: TSctLevel;
    PageHeaderBand: TSctBand;
    PageHeaderBandlevel: TSctLevel;
    DetailBand: TSctBand;
    DetailBandlevel: TSctLevel;
    PageFooterBand: TSctBand;
    PageFooterBandlevel: TSctLevel;
    ReportFooterBand: TSctBand;
    ReportFooterBandlevel: TSctLevel;
    psACEBarcode1: TpsACEBarcode;
    SctLine1: TSctLine;
    Sctvarlabel1: TSctvarlabel;
    svarDateTime: TSctDateTimeVar;
    svarPage: TSctPageVar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Rpt1: TRpt1;

implementation

{$R *.dfm}

end.
