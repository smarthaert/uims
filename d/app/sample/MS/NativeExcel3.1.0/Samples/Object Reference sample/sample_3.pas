unit sample_3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, nExcel;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    function CreateWorkbook: IXLSWorkbook;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

function TForm1.CreateWorkbook: IXLSWorkbook;
Var Book: IXLSWorkbook;
    ws: IXLSWorksheet;
begin
  //Create workbook
  Book := TXLSWorkbook.Create;
  //Add new sheet
  ws := Book.Sheets.Add;
  ws.Name := 'IXLSWorkbook description';

  //column width
  ws.Range['A1', 'A1'].ColumnWidth := 2.57;
  ws.Range['B1', 'B1'].ColumnWidth := 13.29;
  ws.Range['C1', 'C1'].ColumnWidth := 45.57;

 //Formatting for the whole table
  With ws.Range['B2', 'C13'] do begin
    Font.ColorIndex := 9;
    Borders.ColorIndex := 9;
    Borders.Weight := xlMedium;
    Borders[xlInsideHorizontal].Weight := xlThin;
    Borders[xlInsideVertical].Weight := xlThin;
    WrapText := true;
  end;

  //Formatting for the left column
  With ws.Range['B2', 'B13'] do begin
    Interior.ColorIndex := 45;
    Font.Bold := true;
    VerticalAlignment := xlVAlignTop;
    Item[1, 1].Font.Italic := true;
    Item[1, 1].HorizontalAlignment := xlHAlignCenter;
  end;

  //Formatting for the right column
  With ws.Range['C2', 'C13'] do begin
    Interior.ColorIndex := 19;
    Item[1, 1].Font.Italic := true;
    Item[1, 1].Font.Bold := true;
    Item[1, 1].HorizontalAlignment := xlHAlignCenter;
  end;

  //Formatting for the first subheader
  With ws.Range['B3', 'C4'] do begin
     Interior.ColorIndex := 9;
     Font.ColorIndex := 2;
     VerticalAlignment := xlVAlignBottom;
  end;

  //IXLSWorkbook row
  With ws.Range['B3', 'C3'] do begin
     Merge(false);
     HorizontalAlignment := xlHAlignCenter;
  end;

  //Formatting for the second subheader
  With ws.Range['B9', 'C9'] do begin
     Interior.ColorIndex := 9;
     Font.ColorIndex := 2;
     VerticalAlignment := xlVAlignBottom;
     RowHeight := 21.75;
  end;

  //Values of table
  With ws.Range['B2', 'C13'] do begin
     Item[1,1].Value := 'Name';
     Item[1,2].Value := 'Description';
     Item[2,1].Value := 'IXLSWorkbook';
     Item[3,1].Value := 'Methods';
     Item[4,1].Value := 'ResetColors';
     Item[4,2].Value := 'Resets the color palette to the default colors.';
     Item[5,1].Value := 'Protect';
     Item[5,2].Value := 'Protects a workbook so that it cannot be modified.';
     Item[6,1].Value := 'UnProtect';
     Item[6,2].Value := 'Removes protection from a workbook. ' +
                        'This method has no effect if the workbook ' +
                        'is not protected.';
     Item[7,1].Value := 'SaveAs';
     Item[7,2].Value := 'Saves changes to the workbook in a different file.';
     Item[8,1].Value := 'Properties';
     Item[9,1].Value := 'Colors';
     Item[9,2].Value := 'Returns or sets colors in the palette for the ' +
                        'workbook. The palette has 56 entries, each ' +
                        'represented by an RGB value. Read/write LongWord.';
     Item[10,1].Value := 'Worksheets';
     Item[10,2].Value := 'Returns a Worksheets collection that represents ' +
                         'all the sheets in the specified workbook. ' +
                         'Read-only Worksheets object.';
     Item[11,1].Value := 'Sheets';
     Item[11,2].Value := 'Returns a Sheets collection that represents ' +
                         'all the sheets in the specified workbook. ' +
                         'Read-only Worksheets object.';
     Item[12,1].Value := 'ActiveSheet';
     Item[12,2].Value := 'Returns an object that represents the active ' +
                         'sheet in the specified workbook. Returns ' +
                         'Nothing if no sheet is active. Read-only.';
  end;

  Result := Book;
end;

procedure TForm1.Button1Click(Sender: TObject);
Var Book: IXLSWorkbook;
begin
  //Create workbook
  Book := CreateWorkbook;
  Book.SaveAs('IXLSWorkbook.xls');
  MessageDlg('IXLSWorkbook.xls is created', mtInformation, [mbOk], 0);

end;

procedure TForm1.Button2Click(Sender: TObject);
Var Book: IXLSWorkbook;
begin
  //Create workbook
  Book := CreateWorkbook;
  Book.SaveAs('IXLSWorkbook.html', xlHTML);
  MessageDlg('IXLSWorkbook.html is created', mtInformation, [mbOk], 0);

end;

procedure TForm1.Button3Click(Sender: TObject);
Var Book: IXLSWorkbook;
begin
  //Create workbook
  Book := CreateWorkbook;
  Book.SaveAs('IXLSWorkbook.rtf', xlRTF);
  MessageDlg('IXLSWorkbook.rtf is created', mtInformation, [mbOk], 0);
end;

end.
