unit Unit26;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, Grids, DBGrids, StdCtrls, QRCtrls, QuickRpt, ADODB;

type
  TFr_YingShouYingFu = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label6: TLabel;
    Panel3: TPanel;
    Panel5: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Panel4: TPanel;
    DetailBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRSysData1: TQRSysData;
    QRLabel3: TQRLabel;
    QRShape8: TQRShape;
    QRLabel4: TQRLabel;
    QRShape9: TQRShape;
    QRLabel5: TQRLabel;
    QRShape10: TQRShape;
    QRLabel6: TQRLabel;
    QRShape11: TQRShape;
    QRLabel7: TQRLabel;
    QRShape12: TQRShape;
    QRLabel8: TQRLabel;
    QRShape13: TQRShape;
    QRLabel9: TQRLabel;
    QRShape7: TQRShape;
    QRShape6: TQRShape;
    QRShape5: TQRShape;
    QRShape19: TQRShape;
    QRShape18: TQRShape;
    QRShape17: TQRShape;
    QRShape16: TQRShape;
    QRShape15: TQRShape;
    QRShape14: TQRShape;
    QRDBText5: TQRDBText;
    QRDBText4: TQRDBText;
    qrdbtxtnote: TQRDBText;
    qrdbtxtname: TQRDBText;
    qrdbtxtid: TQRDBText;
    ADOQuery1: TADOQuery;  
    QuickRep1: TQuickRep;
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_YingShouYingFu: TFr_YingShouYingFu;

implementation

uses Unit14;

{$R *.dfm}

procedure TFr_YingShouYingFu.FormCreate(Sender: TObject);
begin
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('Select * from bankcard');
  ADOQuery1.Open;
end;

procedure TFr_YingShouYingFu.Button3Click(Sender: TObject);
begin
  Fr_YingShouYingFu.Close;  
  ADOQuery1.Close;
end;

procedure TFr_YingShouYingFu.Button1Click(Sender: TObject);
begin
  QuickRep1.Print;   
  ADOQuery1.Close;
end;

procedure TFr_YingShouYingFu.Button2Click(Sender: TObject);
begin    
  QuickRep1.Preview;
  ADOQuery1.Close;
end;

end.
