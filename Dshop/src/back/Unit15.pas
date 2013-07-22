unit Unit15;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, Grids, DBGrids, StdCtrls, QRCtrls, QuickRpt;

type
  TFr_KuCunPanDian_1 = class(TForm)
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
    QuickRep1: TQuickRep;
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
    QRDBText3: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText1: TQRDBText;
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_KuCunPanDian_1: TFr_KuCunPanDian_1;

implementation

uses Unit14;

{$R *.dfm}

procedure TFr_KuCunPanDian_1.Button3Click(Sender: TObject);
begin
  Fr_KuCunPanDian_1.Close;
end;

procedure TFr_KuCunPanDian_1.Button1Click(Sender: TObject);
begin
  QuickRep1.Print;
end;

procedure TFr_KuCunPanDian_1.Button2Click(Sender: TObject);
begin
    QuickRep1.Preview;
end;

end.
