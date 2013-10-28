unit sample_2;

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
    function CreateBook: IXLSWorkbook;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

function TForm1.CreateBook: IXLSWorkbook;
Var Book: IXLSWorkbook;
    ws: IXLSWorksheet;
    i, j: integer;
begin
  //Create workbook
  Book := TXLSWorkbook.Create;
  //Add new sheet
  ws := Book.Sheets.Add;
  ws.Name := 'Ten times table';

  //General settings
  With ws.Range['B2', 'M14'] do begin
     Font.Size := 12;
     Font.Bold := true;
     ColumnWidth := 5.71;
     Interior.ColorIndex := 45;
     Borders.ColorIndex := xlColorIndexAutomatic;
     HorizontalAlignment := xlHAlignCenter;
  end;

  //Title
  With ws.Range['B2', 'M2'] do begin
    Merge(false);
    Font.Size := 14;
    Value := 'Ten Times Table';
  end;

  //columns header
  With ws.Range['C3', 'M3'] do begin
     Interior.ColorIndex := 53;
     Font.Color := clWhite;
  end;

  //rows header
  With ws.Range['B4', 'B14'] do begin
     Interior.ColorIndex := 53;
     Font.Color := clWhite;
  end;

  //Table values
  for i := 0 to 10 do begin
    //column header
    ws.Cells.Item[3, i + 3].Value := i;
    //row header
    ws.Cells.Item[i + 4, 2].Value := i;
    //time table
    for j := 0 to 10 do begin
       ws.Range['C4', 'M14'].Item[i + 1, j + 1].Value := i * j;
    end;
  end;

  Result := Book;

end;

procedure TForm1.Button1Click(Sender: TObject);
Var Book: IXLSWorkbook;
begin
  Book := CreateBook;
  Book.SaveAs('TenTimesTable.xls');
  MessageDlg('TenTimesTable.xls is created', mtInformation, [mbOk], 0);
end;

procedure TForm1.Button2Click(Sender: TObject);
Var Book: IXLSWorkbook;
begin
  Book := CreateBook;
  Book.SaveAs('TenTimesTable.html', xlHTML);
  MessageDlg('TenTimesTable.html is created', mtInformation, [mbOk], 0);
end;

procedure TForm1.Button3Click(Sender: TObject);
Var Book: IXLSWorkbook;
begin
  Book := CreateBook;
  Book.SaveAs('TenTimesTable.rtf', xlRTF);
  MessageDlg('TenTimesTable.rtf is created', mtInformation, [mbOk], 0);
end;

end.
