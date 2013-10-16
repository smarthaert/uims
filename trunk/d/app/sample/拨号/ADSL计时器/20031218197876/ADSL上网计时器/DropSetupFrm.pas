unit DropSetupFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzEdit, RzCmboBx, ComCtrls, Mask, INIFiles, ExtCtrls,
  RzPanel;

type
  TFrmDropSetup = class(TForm)
    btnOK: TButton;
    gboxBasic: TGroupBox;
    gboxFont: TGroupBox;
    lblFont: TLabel;
    cboxFont: TRzFontComboBox;
    lblFontStyle: TLabel;
    cboxColor: TRzColorComboBox;
    lblFontColor: TLabel;
    cboxFontStyle: TRzComboBox;
    btnCancel: TButton;
    btnDefault: TButton;
    gboxTransparence: TGroupBox;
    lblTransparence: TLabel;
    edtTransparence: TRzEdit;
    udnTransparence: TUpDown;
    lblFormColor: TLabel;
    cboxFormColor: TRzColorComboBox;
    MemoTest: TRzPanel;
    procedure btnCancelClick(Sender: TObject);
    procedure cboxFontChange(Sender: TObject);
    procedure cboxFontStyleChange(Sender: TObject);
    procedure cboxColorChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboxFormColorChange(Sender: TObject);
    procedure edtTransparenceChange(Sender: TObject);
    procedure btnDefaultClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetDropFormFont(FontName: string);
    procedure SetDropFormColor(Color :TColor);
    procedure SetDropFormFontStyle(FontStyle :TFontStyle);
  end;

var
  FrmDropSetup: TFrmDropSetup;

implementation

uses DropFrm, ADSLStringRes;

{$R *.dfm}

procedure TFrmDropSetup.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmDropSetup.cboxFontChange(Sender: TObject);
begin
  MemoTest.Font.Assign(cboxFont.SelectedFont);
  MemoTest.Font.Size :=9;
  SetDropFormFont(MemoTest.Font.Name);
end;

procedure TFrmDropSetup.cboxFontStyleChange(Sender: TObject);
begin
  case cboxFontStyle.ItemIndex of    //
    0: MemoTest.Font.Style :=[];
    1: MemoTest.Font.Style :=[fsBold];
    2: MemoTest.Font.Style :=[fsItalic];
    3: MemoTest.Font.Style :=[fsUnderline];
  end;    // case
  SetDropFormFontStyle(TFontStyle(MemoTest.Font.Style));
end;

procedure TFrmDropSetup.cboxColorChange(Sender: TObject);
begin
  MemoTest.Font.Color :=cboxColor.SelectedColor ;
  SetDropFormColor(cboxColor.SelectedColor);
end;

procedure TFrmDropSetup.FormCreate(Sender: TObject);
var
  fINI :TINIFile;
begin
  fINI :=TINIFile.Create(Path + 'ADSL.ini');
  cboxFont.SelectedFont.Name :=fINI.ReadString('DropForm', 'FontName', 'ËÎÌו');
  cboxFontStyle.ItemIndex :=fINI.ReadInteger('DropForm', 'FontStyle', 0);
  cboxColor.SelectedColor :=fINI.ReadInteger('DropForm', 'FontColor', RGB(0, 0, 0));
  udnTransparence.Position :=fINI.ReadInteger('DropForm', 'Transparence', 150);
  cboxFormColor.SelectedColor :=fINI.ReadInteger('DropForm', 'FormColor', RGB(0, 0, 0)); 
  FreeAndNil(fINI);
  
  MemoTest.Font.Assign(cboxFont.SelectedFont);
  MemoTest.Font.Color :=cboxColor.SelectedColor ;
  MemoTest.Font.Style :=[TFontStyle(cboxFontStyle.ItemIndex - 1)];
  MemoTest.Font.Size :=9;
end;

procedure TFrmDropSetup.cboxFormColorChange(Sender: TObject);
begin
  FrmDrop.pelMain.Color :=cboxFormColor.SelectedColor ;
end;

procedure TFrmDropSetup.edtTransparenceChange(Sender: TObject);
begin
  FrmDrop.AlphaBlendValue :=udnTransparence.Position ;
end;

procedure TFrmDropSetup.btnDefaultClick(Sender: TObject);
begin
  cboxFontStyle.ItemIndex :=0;
  cboxColor.SelectedColor :=clBlack;
  udnTransparence.Position :=150;
  cboxFormColor.SelectedColor :=clBlack;
end;

procedure TFrmDropSetup.SetDropFormFont(FontName: string);
begin
  FrmDrop.Label1.Font.Name :=FontName;
  FrmDrop.Label2.Font.Name :=FontName;
  FrmDrop.lblStr1.Font.Name :=FontName;
  FrmDrop.lblStr2.Font.Name :=FontName;
end;

procedure TFrmDropSetup.SetDropFormColor(Color: TColor);
begin
  FrmDrop.Label1.Font.Color :=Color;
  FrmDrop.Label2.Font.Color :=Color;
  FrmDrop.lblStr1.Font.Color :=Color;
  FrmDrop.lblStr2.Font.Color :=Color;
end;

procedure TFrmDropSetup.SetDropFormFontStyle(FontStyle: TFontStyle);
begin
  FrmDrop.Label1.Font.Style :=[TFontStyle(integer(FontStyle) - 1)];
  FrmDrop.Label2.Font.Style :=[TFontStyle(integer(FontStyle) - 1)];
  FrmDrop.lblStr1.Font.Style :=[TFontStyle(integer(FontStyle) - 1)];
  FrmDrop.lblStr2.Font.Style :=[TFontStyle(integer(FontStyle) - 1)];
end;

procedure TFrmDropSetup.btnOKClick(Sender: TObject);
var
  fINI :TINIFile;
begin
  fINI :=TINIFile.Create(Path + 'ADSL.ini');
  fINI.WriteString('DropForm', 'FontName', cboxFont.SelectedFont.Name);
  fINI.WriteInteger('DropForm', 'FontStyle', cboxFontStyle.ItemIndex);
  fINI.WriteInteger('DropForm', 'FontColor', cboxColor.SelectedColor);
  fINI.WriteInteger('DropForm', 'Transparence', udnTransparence.Position);
  fINI.WriteInteger('DropForm', 'FormColor', cboxFormColor.SelectedColor);
  FreeAndNil(fINI);
  Close;
end;

end.
