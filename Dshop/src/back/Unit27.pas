unit Unit27;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, QuickRpt, ExtCtrls, QRCtrls, DB, ADODB, jpeg;

type
  TFr_DaYinJiCeShi = class(TForm)
    pnl1: TPanel;
    QuickRep1: TQuickRep;
    pnl2: TPanel;
    btn1: TButton;
    btn2: TButton;
    qrbnd1: TQRBand;
    qrshp1: TQRShape;
    qrshp2: TQRShape;
    qrshp3: TQRShape;
    qrshp4: TQRShape;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrbnd2: TQRBand;
    qrshp7: TQRShape;
    qrshp8: TQRShape;
    qrshp9: TQRShape;
    qrdbtxtid: TQRDBText;
    qrdbtxtname: TQRDBText;
    qrdbtxtnote: TQRDBText;
    ADOQuery1: TADOQuery;
    qrbnd3: TQRBand;
    qrshp12: TQRShape;
    qrlbl5: TQRLabel;
    img1: TQRImage;
    qrsysdt1: TQRSysData;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_DaYinJiCeShi: TFr_DaYinJiCeShi;

implementation

{$R *.dfm}

procedure TFr_DaYinJiCeShi.FormCreate(Sender: TObject);
begin
  ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('select * from bankcard limit 4');
    ADOQuery1.Open;
end;

procedure TFr_DaYinJiCeShi.FormDestroy(Sender: TObject);
begin
   ADOQuery1.Close;
end;

procedure TFr_DaYinJiCeShi.btn1Click(Sender: TObject);
begin
QuickRep1.Preview;
end;

procedure TFr_DaYinJiCeShi.btn2Click(Sender: TObject);
begin
QuickRep1.Print;
end;

end.
