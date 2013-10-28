unit Environment;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, EditNew, DrLabel, ExtDlgs, BrowseDr;

type
  TFrmEnvironment = class(TForm)
    Panel1: TPanel;
    BBtnOK: TBitBtn;
    BBtnCancel: TBitBtn;
    DRLabel1: TDRLabel;
    EdtDBFPath: TEditN;
    CmbIMEName: TComboBox;
    DRLabel2: TDRLabel;
    BitBtn1: TBitBtn;
    DRLabel3: TDRLabel;
    EdtSplash: TEditN;
    BBtnSplash: TBitBtn;
    OpenPictureDialog1: TOpenPictureDialog;
    BrowseDirectoryDlg1: TBrowseDirectoryDlg;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BBtnCancelClick(Sender: TObject);
    procedure BBtnOKClick(Sender: TObject);
    procedure CmbIMENameEnter(Sender: TObject);
    procedure CmbIMENameExit(Sender: TObject);
    procedure BBtnSplashClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEnvironment: TFrmEnvironment;

implementation

uses GlbVar;

{$R *.DFM}

procedure TFrmEnvironment.FormCreate(Sender: TObject);
begin

  CmbIMEName.Items := Screen.Imes;
end;

procedure TFrmEnvironment.FormActivate(Sender: TObject);
begin
  EdtDBFPath.Text := CurrEnvironment.ReadDBFPath;
  EdtSplash.Text := CurrEnvironment.ReadSplashPath;
  CmbIMEName.ItemIndex := CmbIMEName.Items.IndexOf(CurrEnvironment.ReadIMEName);
end;

procedure TFrmEnvironment.BitBtn1Click(Sender: TObject);
begin
  if BrowseDirectoryDlg1.Execute then
    EdtDBFPath.Text := BrowseDirectoryDlg1.Selection;
end;

procedure TFrmEnvironment.BBtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmEnvironment.BBtnOKClick(Sender: TObject);
begin
  CurrEnvironment.WriteDBFPath(Trim(EdtDBFPath.Text));
  CurrEnvironment.WriteIMEName(CmbIMEName.Text);
  CurrEnvironment.WriteSplashPath(Trim(EdtSplash.Text));
  Close;
end;

procedure TFrmEnvironment.CmbIMENameEnter(Sender: TObject);
begin
  if CmbIMEName.CanFocus then
    CmbIMEName.Color := clWhite;
end;

procedure TFrmEnvironment.CmbIMENameExit(Sender: TObject);
begin
  CmbIMEName.Color := clSilver;
end;

procedure TFrmEnvironment.BBtnSplashClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
    EdtSplash.Text := OpenPictureDialog1.FileName;
end;

end.

