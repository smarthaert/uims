unit sample_1;

{$IFDEF VER150}
  {$DEFINE D7}
{$ENDIF}

{$IFDEF VER140}
  {$DEFINE D6}
{$ENDIF}

{$IFDEF VER130}
  {$DEFINE D5}
{$ENDIF}

{$IFDEF VER120}
  {$DEFINE D4}
{$ENDIF}

{$IFDEF D4}
  {$DEFINE D45}
{$ENDIF}

{$IFDEF D5}
  {$DEFINE D45}
{$ENDIF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, nExcel,
  StdCtrls {$IFNDEF D45}, Variants{$ENDIF};

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
    Arr: Variant;
begin
  //Create workbook
  Book := TXLSWorkbook.Create;
  //Add new sheet
  ws := Book.Sheets.Add;
  ws.Name := 'Order';

  //Left header of order
  With ws.Range['A2', 'D3'] do begin
    Merge(false);
    Font.Name := 'Times New Roman';
    Font.Size := 26;
    Font.Bold := true;
    Font.Italic := true;
    Value := 'Olson`s';
    HorizontalAlignment := xlHAlignCenter;
    VerticalAlignment := xlVAlignBottom;
  end;

  With ws.Range['A4', 'D5'] do begin
    Merge(false);
    Font.Name := 'Times New Roman';
    Font.Size := 16;
    Font.Italic := true;
    Value := 'Equipment Store';
    HorizontalAlignment := xlHAlignCenter;
    VerticalAlignment := xlVAlignTop;
  end;

  //Right header of order
  With ws.Range['E2', 'F4'] do begin
    Merge(true);
    Font.Name := 'Arial';
    Font.Size := 10;
    Font.Bold := true;
    HorizontalAlignment := xlHAlignRight;
    Item[1,1].Value := '2297 Front Street';
    Item[2,1].Value := 'Phoenix, Arizona 99065';
    Item[3,1].Value := 'Phone: (861) 930-1754';
  end;

  With ws.Range['A7', 'F7'].Borders[xlEdgeTop] do begin
    LineStyle := xlDouble;
    ColorIndex := 16;
  end;

  //Columns and rows settings
  With ws.Cells do begin
    Columns[1].ColumnWidth := 13.86;
    Columns[5].ColumnWidth := 15.29;
    Columns[6].ColumnWidth := 12.00;
    Rows[2].RowHeight := 24.75;
    Rows[5].RowHeight := 24.75;
  end;

  //Order body
  //Sold to
  With ws.Range['A9', 'C12'] do begin
    Merge(true);
    Item[1, 1].Font.Bold := true;

    //Values
    Item[1, 1].Value := 'Sold to:';
    Item[2, 1].Value := 'Mr. Bruce Kretchmer';
    Item[3, 1].Value := '1135 State Street';
    Item[4, 1].Value := 'Chicago, Illinois 60688';

    //Borders
    Borders[xlAround].Weight := xlThick;
    Borders[xlAround].ColorIndex := 16;
  end;

  //Shipped to
  With ws.Range['A14', 'C17'] do begin
    Merge(true);  
    Item[1, 1].Font.Bold := true;

    //Values
    Item[1, 1].Value := 'Shipped to:';
    Item[2, 1].Value := 'Kretchmer`s Appliance Store';
    Item[3, 1].Value := '811 Regent Street';
    Item[4, 1].Value := 'Chicago, Illinois 60688';

    //Borders
    Borders[xlAround].Weight := xlThick;
    Borders[xlAround].ColorIndex := 16;
  end;

  //Order information
  With ws.Range['D9', 'E12'] do begin
    Merge(true);
    Font.Bold := true;
    HorizontalAlignment := xlHAlignRight;
    //Values
    Item[1, 1].Value := 'Date ';
    Item[2, 1].Value := 'Order Number ';
    Item[3, 1].Value := 'Shipped Via ';
    Item[4, 1].Value := 'Prepaid or Collect ';
  end;

  With ws.Range['F9', 'F12'] do begin
    HorizontalAlignment := xlHAlignLeft;

    //Values
    Item[1, 1].Value := EncodeDate(2004, 2, 3);
    Item[1, 1].NumberFormat := 'DD/MM/YY';
    Item[2, 1].Value := '452';
    Item[3, 1].Value := 'UPS';
    Item[4, 1].Value := 'Prepaid';

    //Borders
    Borders[xlAround].Weight := xlThick;
    Borders[xlAround].ColorIndex := 16;
  end;

  With ws.Range['A20', 'F20'] do begin
    Font.Bold := true;
    HorizontalAlignment := xlHAlignCenter;
  end;

  ws.Range['A21', 'A23'].HorizontalAlignment := xlHAlignCenter;
  ws.Range['E21', 'F23'].NumberFormat := '$#,##0.00';

  With ws.Range['E25', 'E27'] do begin
    Font.Bold := true;
    HorizontalAlignment := xlHAlignRight;
  end;

  //background color
  ws.Range['F27', 'F27'].Interior.Color := clSilver;

  Arr := VarArrayCreate([0, 7, 0, 5], varVariant);
  Arr[0,0] := 'QUANTITY';    Arr[0,1] := 'ITEM';
  Arr[0,4] := 'UNIT PRICE';  Arr[0,5] := 'AMOUNT';

  {Quantity}               {Item}
  Arr[1,0] := 15;          Arr[1,1] := 'Item1';
  Arr[2,0] := 17;          Arr[2,1] := 'Item2';
  Arr[3,0] := 8;           Arr[3,1] := 'Item3';

  {Price}                  {Amount}
  Arr[1,4] := 32.50;       Arr[1,5] := '=A21*E21';  
  Arr[2,4] := 40.30;       Arr[2,5] := '=A22*E22';  
  Arr[3,4] := 15.20;       Arr[3,5] := '=A23*E23';  
 
  {Total labels}           {Total amount}
  Arr[5,4] := 'SUBTOTAL';  Arr[5,5] := '=SUM(F21:F23)'; 
  Arr[6,4] := 'TAX';       Arr[6,5] := '=F25*20/100';     
  Arr[7,4] := 'TOTAL';     Arr[7,5] := '=F25+F26'; 

  With ws.Range['A20', 'F27'] do begin
    //Values
    Value := Arr;
    //Borders
    Borders[xlAround].Weight := xlThick;
    Borders[xlAround].ColorIndex := 16;
  end;

  ws.Range['F25', 'F27'].NumberFormat := '$#,##0.00';

  //Footer
  With ws.Range['A29', 'F29'] do begin
     Merge;
     HorizontalAlignment := xlHAlignCenter;
     Value := 'Thank you for your business!';
     Font.Italic := true;
  end;

  //Page setup
  ws.PageSetup.PrintGridlines := false;
  ws.PageSetup.CenterHorizontally := true;

  Result := Book;
end;

procedure TForm1.Button1Click(Sender: TObject);
Var Book: IXLSWorkbook;
begin
  Book := CreateWorkbook;
  //Save workbook
  Book.SaveAs('Order.xls');
  MessageDlg('Order.xls is created', mtInformation, [mbOk], 0);
end;

procedure TForm1.Button2Click(Sender: TObject);
Var Book: IXLSWorkbook;
begin
  Book := CreateWorkbook;
  //Save workbook
  Book.SaveAs('Order.html', xlHTML);
  MessageDlg('Order.html is created', mtInformation, [mbOk], 0);
end;


procedure TForm1.Button3Click(Sender: TObject);
Var Book: IXLSWorkbook;
begin
  Book := CreateWorkbook;
  //Save workbook
  Book.SaveAs('Order.rtf', xlRTF);
  MessageDlg('Order.rtf is created', mtInformation, [mbOk], 0);
end;

end.
