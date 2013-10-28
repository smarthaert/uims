unit pdfMainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, psBarcode, ExtCtrls, StdCtrls, Buttons,
  psCodeFN, psCodeProf, psCodeFNLite, psCodeExports,
  QuickRpt, ComCtrls;

  // ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZAB

  // ABC0123456789012345ABC987654321098765ABC123
  //    0123456789012345ABC987654321098765ABC123
type
  TForm6 = class(TForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    bc: TpsBarcode;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    CheckBox1: TCheckBox;
    cbMode: TComboBox;
    cbECL: TComboBox;
    Mode: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edCols: TEdit;
    edRows: TEdit;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    grMacro: TGroupBox;
    TabSheet3: TTabSheet;
    meToEncode: TMemo;
    cbKind: TComboBox;
    Label4: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblUsedMode: TLabel;
    lblUsedECL: TLabel;
    lblUsedCols: TLabel;
    lblUsedRows: TLabel;
    BitBtn5: TBitBtn;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label15: TLabel;
    Label16: TLabel;
    Shape3: TShape;
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure meToEncodeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbModeChange(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
  private
    procedure UpdateUsedLabels;
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

procedure TForm6.BitBtn3Click(Sender: TObject);
begin
    bsHome;
end;

procedure TForm6.BitBtn4Click(Sender: TObject);
begin
    if MessageDlg('Can you terminate this demo ?', mtInformation, [mbYes,mbNo], 0)=mrYes then
        Application.Terminate;
end;

procedure TForm6.BitBtn5Click(Sender: TObject);
begin
    // bcSave(bc);
end;

procedure TForm6.cbModeChange(Sender: TObject);
begin
    if sender = cbMode then
          bc.Params.PDF417.Mode :=TpsPDF417Mode(cbMode.ItemIndex);
    if sender = cbECL then
          bc.Params.PDF417.SecurityLevel :=TpsPDF417ErrorCorrection(cbECL.ItemIndex);
    if sender = cbKind then
          bc.Params.PDF417.Kind :=TpsPDF417Kind(cbKind.ItemIndex);
    if sender=edCols then
          bc.Params.PDF417.Cols := StrToInt(edCols.Text);
    if sender=edRows then
          bc.Params.PDF417.Rows := StrToInt(edRows.Text);
    UpdateUsedLabels;
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
    cbMode.ItemIndex := psFillItems(cbMode.Items, TypeInfo(TpsPDF417Mode), 0, Integer(bc.Params.PDF417.Mode));
    cbECL.ItemIndex  := psFillItems(cbECL.Items,  TypeInfo(TpsPDF417ErrorCorrection), 0,
          Integer(bc.Params.PDF417.SecurityLevel));
    cbKind.ItemIndex := psFillItems(cbKind.Items, TypeInfo(TpsPDF417Kind), 0,
          Integer(bc.Params.PDF417.Kind));

    meToEncode.Text   := bc.BarCode;

    UpdateUsedLabels;
end;

procedure TForm6.meToEncodeChange(Sender: TObject);
begin
  bc.BarCode := meToEncode.Text;
  UpdateUsedLabels;
end;

procedure TForm6.UpdateUsedLabels;
begin
    lblUsedMode.Caption := psGetEnumPropertyName(bc, 'Params.PDF417.Mode');
    lblUsedECL.Caption  := psGetEnumPropertyName(bc, 'Params.PDF417.SecurityLevel');
    lblUsedCols.Caption := IntToStr(bc.Params.PDF417.UsedCols);
    lblUsedRows.Caption := IntToStr(bc.Params.PDF417.UsedRows);
end;

end.
