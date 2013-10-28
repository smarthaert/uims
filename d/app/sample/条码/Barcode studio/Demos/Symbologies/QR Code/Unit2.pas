unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, psCodeExports, ComCtrls, ExtDlgs,
  psBarcode, psTypes, psBoxes, psCodeStudio;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Label1: TLabel;
    meBarcode: TMemo;
    Label2: TLabel;
    cbMode: TComboBox;
    Label3: TLabel;
    cbECC: TComboBox;
    cbMicro: TCheckBox;
    Label4: TLabel;
    cbVersion: TComboBox;
    Label5: TLabel;
    Shape1: TShape;
    Label7: TLabel;
    cbMask: TComboBox;
    SB: TStatusBar;
    SavePictureDialog1: TSavePictureDialog;
    psBarcode1: TpsBarcode;
    ex: TpsExportImport;
    procedure BitBtn4Click(Sender: TObject);
    procedure meBarcodeChange(Sender: TObject);
    procedure cbModeChange(Sender: TObject);
    procedure cbECCChange(Sender: TObject);
    procedure cbVersionChange(Sender: TObject);
    procedure cbMicroClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure cbMaskChange(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure UpdateUsedParams;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
  psBarcode1.CopyToClipboardWMF;
  MessageDlg('Barcode copied to clipboard.'#13#10'Use Ctrl+V or Paste to paste into another application.',
      mtInformation, [mbOK],0);
end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
    // ex.Execute;
end;

procedure TForm2.BitBtn3Click(Sender: TObject);
var R:TpsRect;
begin
  R.Left    := 20;
  R.Top     := 30;
  R.Width   := 45.5;
  R.Height  := 25;
  if psGetPrintRectangle(R) then ;
end;

procedure TForm2.BitBtn4Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm2.cbECCChange(Sender: TObject);
begin
  psBarcode1.Params.QRCode.EccLevel:= TpsQREccLevel(cbECC.ItemIndex);
  UpdateUsedParams;
end;

procedure TForm2.cbMaskChange(Sender: TObject);
begin
  psBarcode1.Params.QRCode.Mask := cbMask.ItemIndex;
  UpdateUsedParams;
end;

procedure TForm2.cbMicroClick(Sender: TObject);
begin
  psBarcode1.Params.QRCode.MicroQR:= cbMicro.Checked;
  UpdateUsedParams;
end;

procedure TForm2.cbModeChange(Sender: TObject);
begin
  psBarcode1.Params.QRCode.Mode := TpsQRMode(cbMode.ItemIndex);
  UpdateUsedParams;
end;

procedure TForm2.cbVersionChange(Sender: TObject);
begin
  psBarcode1.Params.QRCode.Version:= cbVersion.ItemIndex;
  UpdateUsedParams;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  meBarcode.Text      := psBarcode1.BarCode;
  cbMode.ItemIndex    := Integer(psBarcode1.Params.QRCode.Mode);
  cbVersion.ItemIndex := psBarcode1.Params.QRCode.Version;
  cbECC.ItemIndex     := Integer(psBarcode1.Params.QRCode.EccLevel);
  cbMicro.Checked     := psBarcode1.Params.QRCode.MicroQR;
  cbMask.ItemIndex    := psBarcode1.Params.QRCode.Mask;
  UpdateUsedParams;
end;

procedure TForm2.meBarcodeChange(Sender: TObject);
begin
  psBarcode1.BarCode := meBarcode.Text;
  UpdateUsedParams;
end;

procedure TForm2.UpdateUsedParams;
begin
  psBarcode1.Repaint;
  SB.Panels[0].Text := Format('Used : Version:%d, ECL:%s, Mode:%s, Mask:%d',
      [ psBarcode1.Params.QRCode.UsedVersion,
        qrECCDescription(psBarcode1.Params.QRCode.UsedECCLevel),
        qrModeDescription(psBarcode1.Params.QRCode.UsedMode),
        psBarcode1.Params.QRCode.UsedMask
      ]);
end;

end.
