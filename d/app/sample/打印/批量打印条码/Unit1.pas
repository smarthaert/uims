unit Unit1;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RM_Common, RM_Class, RM_AsBarView, RM_BarCode,
  ExtCtrls, DB, ADODB, RM_Dataset, Grids, DBGrids;

type
  TForm1 = class(TForm)
    RMReport1: TRMReport;
    Button1: TButton;
    RMBarCodeObject1: TRMBarCodeObject;
    Button2: TButton;
    ADODataSet1: TADODataSet;
    RMDBDataSet1: TRMDBDataSet;
    ADOConnection1: TADOConnection;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin

   RMReport1.ShowReport;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ADOConnection1.Connected:=False;
  ADOConnection1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source=.\db_manpower.mdb;Persist Security Info=False';
  ADOConnection1.Connected:=True;
  ADODataSet1.Active:=True;

end;

end.
