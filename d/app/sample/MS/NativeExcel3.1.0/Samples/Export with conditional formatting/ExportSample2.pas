unit ExportSample2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Dataset2Excel, Grids, DBGrids, Db, DBTables, nExcel;

type
  TFormCondFormatting = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    DBGrid1: TDBGrid;
    Dataset2Excel1: TDataset2Excel;
    SaveDialog1: TSaveDialog;
    SaveAs: TButton;
    procedure Dataset2Excel1AfterDetailRow(Sender: TObject;
      Range: IXLSRange; RowIndex: Integer);
    procedure SaveAsClick(Sender: TObject);
    procedure Dataset2Excel1AfterHeaderCell(Sender: TObject;
      Cell: IXLSRange; FieldIndex: Integer; Field: TField);
    procedure Dataset2Excel1AfterExport(Sender: TObject; Range: IXLSRange);
    procedure Dataset2Excel1AfterHeader(Sender: TObject; Range: IXLSRange);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCondFormatting: TFormCondFormatting;

implementation

{$R *.DFM}


procedure TFormCondFormatting.Dataset2Excel1AfterDetailRow(Sender: TObject;
  Range: IXLSRange; RowIndex: Integer);
Var FPopulation: TField;
begin
  FPopulation := Dataset2Excel1.Dataset.FieldByName('population');
  if FPopulation.AsInteger >= 100000000 then begin
     //Population >= 100000000
     Range.Interior.Color := RGB(255, 153, 0);
     Range.Font.Color := RGB(128, 0, 0);
  end else if FPopulation.AsInteger >= 10000000 then begin
     //Population between 99000000 and 10000000
     Range.Interior.Color := RGB(153, 204, 255);
     Range.Font.Color := clNavy;
  end else begin
     //Population less 10000000
     Range.Interior.Color := RGB(204, 255, 204);
     Range.Font.Color := RGB(0, 51, 0);
  end;
  //First column
  Range.Item[1,1].Interior.Color := RGB(255, 255, 153);
  Range.Item[1,1].Font.Color := clNavy;
end;

procedure TFormCondFormatting.SaveAsClick(Sender: TObject);
begin
  If SaveDialog1.Execute then begin
     SaveAs.Enabled := false;
     Dataset2Excel1.SaveDatasetAs(SaveDialog1.FileName);
     Dataset2Excel1.Workbook := nil;
     SaveAs.Enabled := true;
  end;
end;

procedure TFormCondFormatting.Dataset2Excel1AfterHeaderCell(Sender: TObject;
  Cell: IXLSRange; FieldIndex: Integer; Field: TField);
begin
  if Field.FieldName = 'Population' then Cell.EntireColumn.ColumnWidth := 17;
end;

procedure TFormCondFormatting.Dataset2Excel1AfterExport(Sender: TObject;
  Range: IXLSRange);
begin
  With Range.Borders[xlAround] do begin
    LineStyle := xlContinuous;
    Weight    := xlMedium;
  end;
  Range.Columns.Autofit;
end;

procedure TFormCondFormatting.Dataset2Excel1AfterHeader(Sender: TObject;
  Range: IXLSRange);
begin
  With Range.Borders[xlAround] do begin
   LineStyle := xlContinuous;
   Weight := xlMedium;
  end;
end;

end.
