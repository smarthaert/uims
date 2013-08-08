unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Table1: TTable;
    Splitter1: TSplitter;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label2: TLabel;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  n,i,PrintCount: Integer; //要求,实际打印的记录数;已打印页数；


implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin


  n := StrToInt(Edit1.Text);
  PrintCount := 0;
  i:= 0;
  try
  qrTest.Prepare;
  qrTest.FTotalPages := qrTest.QRPRinter.PageCount;
  finally
  qrTest.QRPrinter.Cleanup;
   end;  
  qrTest.Preview;

end;

end.
