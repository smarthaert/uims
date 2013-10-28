unit Unit2;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, QuickRpt, ExtCtrls, QRCtrls;

type
  TForm2 = class(TForm)
    QuickRep1: TQuickRep;
    DetailBand1: TQRBand;
    ADOConnection1: TADOConnection;
    ADODataSet1: TADODataSet;
    ADODataSet1DSDesigner: TWideStringField;
    ADODataSet1DSDesigner2: TWideStringField;
    ADODataSet1DSDesigner3: TWideStringField;
    ADODataSet1DSDesigner4: TWideStringField;
    ADODataSet1DSDesigner5: TWideStringField;
    ADODataSet1DSDesigner6: TWideStringField;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRDBText4: TQRDBText;
    QRLabel3: TQRLabel;
    QRDBText5: TQRDBText;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
  //Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Liang\¥Ú”°–≈∑‚\jxcgl.mdb;Persist Security Info=False
  ADOConnection1.Connected:=False;
  ADOConnection1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source=.\jxcgl.mdb;Persist Security Info=False';
  ADOConnection1.Connected:=True;
  ADODataSet1.Active:=True;
  
end;

end.
