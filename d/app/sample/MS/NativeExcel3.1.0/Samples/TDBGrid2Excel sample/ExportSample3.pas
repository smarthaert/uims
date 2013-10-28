unit ExportSample3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, Db, DBTables, nExcel,
  DBGrid2Excel;

type
  TDBGrid2ExcelSample = class(TForm)
    Table1: TTable;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    SaveAsSingleSheet: TButton;
    SaveDialog1: TSaveDialog;
    SingleSheetExportGroup: TGroupBox;
    MultiSheetExportGroup: TGroupBox;
    OriginalFormatting: TCheckBox;
    DBGrid2Excel1: TDBGrid2Excel;
    SaveAsMultiSheet: TButton;
    procedure FormCreate(Sender: TObject);
    procedure SaveAsSingleSheetClick(Sender: TObject);
    procedure SaveAsMultiSheetClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DBGrid2ExcelSample: TDBGrid2ExcelSample;

implementation

{$R *.DFM}

procedure TDBGrid2ExcelSample.FormCreate(Sender: TObject);
begin
  //set specified formatting options
  Dbgrid2Excel1.DetailColor := RGB(255, 255, 153);
  Dbgrid2Excel1.HeaderColor := RGB(51, 153, 102);
  Dbgrid2Excel1.DetailFont.Color := RGB(51, 153, 102);
  Dbgrid2Excel1.HeaderFont.Color := RGB(255, 255, 153);
  Dbgrid2Excel1.HeaderFont.Name := 'Times New Roman';
  Dbgrid2Excel1.HeaderFont.Size := 14;
  Dbgrid2Excel1.DetailFont.Name := 'Arial';
  Dbgrid2Excel1.DetailFont.Size := 10;
  Dbgrid2Excel1.HeaderBorderStyle := BorderStyleSingleThin;
  Dbgrid2Excel1.DetailBorderStyle := BorderStyleSingleThin;
  Dbgrid2Excel1.HeaderBorderColor := RGB(0, 51, 0);
  Dbgrid2Excel1.DetailBorderColor := RGB(0, 51, 0);
end;

procedure TDBGrid2ExcelSample.SaveAsSingleSheetClick(Sender: TObject);
begin
  If SaveDialog1.Execute then begin
     //disable buttons
     SaveAsSingleSheet.Enabled := false;
     SaveAsMultiSheet.Enabled := false;
     //Worksheet name
     if OriginalFormatting.Checked then
        Dbgrid2Excel1.WorksheetName := 'Original formatting'
     else
        Dbgrid2Excel1.WorksheetName := 'Specified formatting';
     //Set options
     Dbgrid2Excel1.OriginalHeaderFont := OriginalFormatting.Checked;
     Dbgrid2Excel1.OriginalDetailFont := OriginalFormatting.Checked;
     Dbgrid2Excel1.OriginalHeaderColor := OriginalFormatting.Checked;
     Dbgrid2Excel1.OriginalDetailColor := OriginalFormatting.Checked;
     //Export DBGrid
     Dbgrid2Excel1.SaveDBGridAs(SaveDialog1.FileName);
     //destroy workbook
     Dbgrid2Excel1.Workbook := nil;
     //enable buttons
     SaveAsSingleSheet.Enabled := true;
     SaveAsMultiSheet.Enabled := true;
  end;
end;

procedure TDBGrid2ExcelSample.SaveAsMultiSheetClick(Sender: TObject);
begin
  If SaveDialog1.Execute then begin
      //disable buttons
      SaveAsMultiSheet.Enabled := false;
      SaveAsSingleSheet.Enabled := false;
      //first sheet with original formatting
      Dbgrid2Excel1.WorksheetName := 'Original formatting';
      //options
      Dbgrid2Excel1.OriginalHeaderFont := true;
      Dbgrid2Excel1.OriginalDetailFont := true;
      Dbgrid2Excel1.OriginalHeaderColor := true;
      Dbgrid2Excel1.OriginalDetailColor := true;
      //Export dbgrid
      Dbgrid2Excel1.ExportDBGrid;
      //Second sheet with specified formatting
      Dbgrid2Excel1.WorksheetName := 'Specified formatting';
      //options
      Dbgrid2Excel1.OriginalHeaderFont := false;
      Dbgrid2Excel1.OriginalDetailFont := false;
      Dbgrid2Excel1.OriginalHeaderColor := false;
      Dbgrid2Excel1.OriginalDetailColor := false;
      //Export dbgrid
      Dbgrid2Excel1.ExportDBGrid;
      //save workbook
      Dbgrid2Excel1.SaveAs(SaveDialog1.FileName);
      //destroy workbook
      Dbgrid2Excel1.Workbook := nil;
      //enable buttons
      SaveAsMultiSheet.Enabled := true;
      SaveAsSingleSheet.Enabled := true;
   end;
end;

end.
