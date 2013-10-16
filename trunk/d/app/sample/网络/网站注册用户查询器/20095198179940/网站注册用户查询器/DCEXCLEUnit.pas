unit DCEXCLEUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzPanel, RzBckgnd, StdCtrls, RzLabel, pngimage, Grids,
  DBGrids,ComObj, Buttons;

type
  TDCEXCLEForm = class(TForm)
    RzPanel1: TRzPanel;
    Image6: TImage;
    lblts: TRzLabel;
    RzSeparator6: TRzSeparator;
    DBGrid1: TDBGrid;
    sbtnDREXCEL: TSpeedButton;
    procedure CopyDbDataToExcel(Args: array of const);
    procedure sbtnDREXCELClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DCEXCLEForm: TDCEXCLEForm;

implementation

uses dmUnit;

{$R *.dfm}

{ TDCEXCLEForm }

procedure TDCEXCLEForm.CopyDbDataToExcel(Args: array of const);
var
  iCount, jCount: Integer;
  XLApp: Variant;
  Sheet: Variant;
  I: Integer;
begin
Screen.Cursor := crHourGlass;
  if not VarIsEmpty(XLApp) then
  begin
    XLApp.DisplayAlerts := False;
    XLApp.Quit;
    VarClear(XLApp);
  end;
 //-----------------------------------------------------------------------------
  try
    XLApp := CreateOleObject('Excel.Application');
  except
    Screen.Cursor := crDefault;
    Exit;
  end;
 //-----------------------------------------------------------------------------
  XLApp.WorkBooks.Add;
  XLApp.SheetsInNewWorkbook := High(Args) + 1;
 //-----------------------------------------------------------------------------
  for I := Low(Args) to High(Args) do
  begin
    XLApp.WorkBooks[1].WorkSheets[I+1].Name := TDBGrid(Args[I].VObject).Name;
    Sheet := XLApp.Workbooks[1].WorkSheets[TDBGrid(Args[I].VObject).Name];

    if not TDBGrid(Args[I].VObject).DataSource.DataSet.Active then
    begin
      Screen.Cursor := crDefault;
      Exit;
    end;
 //-----------------------------------------------------------------------------
    TDBGrid(Args[I].VObject).DataSource.DataSet.first;
    for iCount := 0 to TDBGrid(Args[I].VObject).Columns.Count - 1 do
      Sheet.Cells[1, iCount + 1] := TDBGrid(Args[I].VObject).Columns.Items[iCount].Title.Caption;
    jCount := 1;
    while not TDBGrid(Args[I].VObject).DataSource.DataSet.Eof do
    begin
      for iCount := 0 to TDBGrid(Args[I].VObject).Columns.Count - 1 do
        Sheet.Cells[jCount + 1, iCount + 1] :=TDBGrid(Args[I].VObject).Columns.Items[iCount].Field.AsString;
      Inc(jCount);
      TDBGrid(Args[I].VObject).DataSource.DataSet.Next;
    end;
    XlApp.Visible := True;
  end;
  Screen.Cursor := crDefault;
end;

procedure TDCEXCLEForm.sbtnDREXCELClick(Sender: TObject);
begin
//开发导出按钮
CopyDbDataToExcel([DBGrid1]);
end;

end.
