unit ExportSample;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Dataset2Excel, Grids, DBGrids, Db, DBTables, nExcel;

type
  TDs2ExcelSample = class(TForm)
    Table1: TTable;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    ExportToNewFile: TButton;
    Dataset2Excel1: TDataset2Excel;
    TableList: TComboBox;
    Label1: TLabel;
    SaveDialog1: TSaveDialog;
    AddSheet: TButton;
    SingleSheetExportGroup: TGroupBox;
    MultiSheetExportGroup: TGroupBox;
    SaveAs: TButton;
    SheetsCountLabel: TLabel;
    SheetsCount: TLabel;
    CondFormatting: TCheckBox;
    procedure ExportToNewFileClick(Sender: TObject);
    procedure TableListChange(Sender: TObject);
    procedure AddSheetClick(Sender: TObject);
    procedure SaveAsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Dataset2Excel1AfterExport(Sender: TObject; Range: IXLSRange);
    procedure Dataset2Excel1AfterHeader(Sender: TObject; Range: IXLSRange);
    procedure Dataset2Excel1AfterHeaderCell(Sender: TObject;
      Cell: IXLSRange; FieldIndex: Integer; Field: TField);
    procedure Dataset2Excel1AfterDetailRow(Sender: TObject;
      Range: IXLSRange; RowIndex: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Ds2ExcelSample: TDs2ExcelSample;

implementation

{$R *.DFM}

procedure TDs2ExcelSample.ExportToNewFileClick(Sender: TObject);
begin
  If SaveDialog1.Execute then begin
     ExportToNewFile.Enabled := false;
     Dataset2Excel1.WorksheetName := Table1.TableName;
     Dataset2Excel1.SaveDatasetAs(SaveDialog1.FileName);
     //destroy workbook
     Dataset2Excel1.Workbook := nil;
     ExportToNewFile.Enabled := true;
     SaveAs.Enabled := false;
     SheetsCount.Caption := '0';
  end;
end;

procedure TDs2ExcelSample.TableListChange(Sender: TObject);
begin
  Table1.Active := false;
  Table1.TableName := TableList.Text + '.db';
  Table1.Active := true;
end;

procedure TDs2ExcelSample.AddSheetClick(Sender: TObject);
begin
  ExportToNewFile.Enabled := false;
  AddSheet.Enabled := false;
  Dataset2Excel1.WorksheetName := Table1.TableName;
  Dataset2Excel1.ExportDataset;
  AddSheet.Enabled := true;
  SaveAs.Enabled := true;
  SheetsCount.Caption := inttostr(Dataset2Excel1.Workbook.Sheets.Count);
end;

procedure TDs2ExcelSample.SaveAsClick(Sender: TObject);
begin
  If SaveDialog1.Execute then begin
     SaveAs.Enabled := false;
     Dataset2Excel1.SaveAs(SaveDialog1.FileName);
     ExportToNewFile.Enabled := true;
     //destroy workbook
     Dataset2Excel1.Workbook := nil;
     SheetsCount.Caption := '0';
  end;
end;

procedure TDs2ExcelSample.FormCreate(Sender: TObject);
begin
  TableList.ItemIndex := 0;
end;

procedure TDs2ExcelSample.Dataset2Excel1AfterExport(Sender: TObject;
  Range: IXLSRange);
begin
  if CondFormatting.Checked then
    With Range.Borders[xlAround] do begin
       LineStyle := xlContinuous;
       Weight := xlThick;
    end;
end;

procedure TDs2ExcelSample.Dataset2Excel1AfterHeader(Sender: TObject;
  Range: IXLSRange);
begin
  if CondFormatting.Checked then
    With Range.Borders[xlAround] do begin
       LineStyle := xlContinuous;
       Weight := xlThick;
    end;
end;

procedure TDs2ExcelSample.Dataset2Excel1AfterHeaderCell(Sender: TObject;
  Cell: IXLSRange; FieldIndex: Integer; Field: TField);
begin
  if CondFormatting.Checked then
    Cell.Value := StringReplace(Cell.Value, '_', ' ', [rfReplaceAll]);
end;

procedure TDs2ExcelSample.Dataset2Excel1AfterDetailRow(Sender: TObject;
  Range: IXLSRange; RowIndex: Integer);
begin
  if CondFormatting.Checked then
     if Odd(RowIndex + 1) then Range.Interior.Color := clSilver;
end;

end.
