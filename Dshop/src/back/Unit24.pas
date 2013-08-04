unit Unit24;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, DBGrids, ComCtrls, Mask, RzEdit,
  Buttons, DB, ADODB, QRCtrls, QuickRpt;

type
  TFr_XianJinGuanLi = class(TForm)
    pnl1: TPanel;
    dbgrd1: TDBGrid;
    pnl2: TPanel;
    grp1: TGroupBox;
    grp2: TGroupBox;
    lbl1: TLabel;
    edt1: TEdit;
    lbl2: TLabel;
    edt2: TEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    btn1: TButton;
    lbl5: TLabel;
    edt5: TEdit;
    lbl6: TLabel;
    edt6: TEdit;
    lbl7: TLabel;
    lbl8: TLabel;
    edt8: TEdit;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    lbl9: TLabel;
    edt9: TEdit;
    lbl10: TLabel;
    edt10: TEdit;
    btn5: TButton;
    edt4: TEdit;
    edt3: TRzDateTimeEdit;
    edt7: TRzDateTimeEdit;
    btn7: TSpeedButton;
    ADOQuery1: TADOQuery;
    pnl3: TPanel;
    QuickRep1: TQuickRep;
    qrbndtitle1: TQRBand;
    qrshp1: TQRShape;
    qrlbl1: TQRLabel;
    qrbndtitle2: TQRBand;
    qrshp2: TQRShape;
    qrlbl2: TQRLabel;
    qrshp3: TQRShape;
    qrlbl3: TQRLabel;
    qrshp4: TQRShape;
    qrlbl4: TQRLabel;
    qrshp5: TQRShape;
    qrdbtxtid: TQRDBText;
    qrshp6: TQRShape;
    qrdbtxtname: TQRDBText;
    qrshp7: TQRShape;
    qrdbtxtnote: TQRDBText;
    procedure btn3Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_XianJinGuanLi: TFr_XianJinGuanLi;

implementation

uses Unit25;

{$R *.dfm}

procedure TFr_XianJinGuanLi.btn3Click(Sender: TObject);
begin
  Fr_XianJinGuanLi.Close;
end;

procedure TFr_XianJinGuanLi.btn7Click(Sender: TObject);
begin
  if Fr_BankCard<>nil then
    Fr_BankCard.ShowModal
  else begin
    Fr_BankCard:=TFr_BankCard.Create(Application);
    Fr_BankCard.ShowModal;
  end;
  edt2.Text:=Fr_BankCard.ADOQuery1.FieldByName('id').AsString;

  edt3.SetFocus;
end;

procedure TFr_XianJinGuanLi.btn1Click(Sender: TObject);
var
  s:string;
begin        
  s:='ÊÇ·ñ½«"';
  if messagedlg(s,mtconfirmation,[mbyes,mbno],0)=mryes then begin
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('Select * from kjfl');
    ADOQuery1.Open;
    ADOQuery1.Edit;
    ADOQuery1.FieldByName('amount').AsString        := edt1.Text;
    ADOQuery1.FieldByName('note').AsString      := edt2.Text;
    ADOQuery1.FieldByName('date').AsString     := edt3.Text;
    ADOQuery1.FieldByName('opt').AsString := edt4.Text;
    ADOQuery1.FieldByName('pzid').AsString  := edt9.Text;
    ADOQuery1.FieldByName('id').AsString  := '1';
    ADOQuery1.FieldByName('code').AsString  := '1';
    ADOQuery1.FieldByName('name').AsString  := '1';
    ADOQuery1.FieldByName('dc').AsString  := '1';
    ADOQuery1.Post;
    ADOQuery1.Close;
  end;
end;

procedure TFr_XianJinGuanLi.btn5Click(Sender: TObject);
begin
  ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('Select * from kjfl');
    ADOQuery1.Open;
  QuickRep1.Print;
end;

procedure TFr_XianJinGuanLi.btn4Click(Sender: TObject);
begin
QuickRep1.Preview;
end;

end.
