unit Unit1;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleServer, LabelManager2_TLB, ComCtrls, StdCtrls, Buttons,comobj;

type
  TForm1 = class(TForm)
  
    lbl1: TLabel;
    edt1: TEdit;
    lbl2: TLabel;
    edt2: TEdit;
    lbl3: TLabel;
    dtpscrq: TDateTimePicker;
    lbl4: TLabel;
    edt3: TEdit;
    lbl5: TLabel;
    edt4: TEdit;
    SpeedButton1: TSpeedButton;
    lbl6: TLabel;

    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  BarApp,BarDoc:Variant; // OLE ±‰¡ø
begin
  BarApp := CreateOleObject('lppx.Application');
  BarApp.Visible:=False;

  BarDoc:=BarApp.ActiveDocument;
  BarDoc.Open(ExtractFilePath(paramstr(0))+'Box1.Lab');

  BarDoc.Variables.Item('SHF').Value:=edt1.Text;
  BarDoc.Variables.Item('FHF').Value:=edt2.Text;
  BarDoc.Variables.Item('SCRQ').Value:=DateTimeToStr(dtpscrq.Date);
  BarDoc.Variables.Item('BZTM').Value:=edt3.Text;

  Bardoc.Printlabel(strtoint(edt4.Text));
  BarDoc.FormFeed;
  Bardoc.Close;
  BarApp.Quit;

end;

end.
