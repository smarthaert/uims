unit ImagesSample;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  nExcel, StdCtrls;

type
  TNativeExcelImages = class(TForm)
    Hint: TLabel;
    Makeit: TButton;
    procedure MakeitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NativeExcelImages: TNativeExcelImages;

implementation

{$R *.DFM}

procedure TNativeExcelImages.MakeitClick(Sender: TObject);
var book: IXLSWorkbook;
begin
  //create workbook object
  book := TXLSWorkbook.Create;
  //Add new worksheet
  with book.Sheets.Add do begin
    //Change name of worksheet
    Name := 'Sheet with image';
    //select upper-left corner ("B3") for image
    Cells[3,2].Select;
    //Add picture into sheet
    Shapes.AddPicture('image1.jpg');
  end;
  //Save workbook
  book.SaveAs('book.xls');
  MessageDlg('book.xls is created', mtInformation, [mbOk], 0);
end;

end.
