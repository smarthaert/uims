//==========================================================================//
//                                                                          //
//                            拖动窗体代码                                  //
//                              作者:沈杰                                   //
//                              2003-03-20                                  //
//                  这个单元文件中的代码是拖拉窗体的代码                    //
//==========================================================================//

unit DropFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, XPMenu, StdCtrls, INIFiles;

type
  TFrmDrop = class(TForm)
    pelMain: TPanel;
    PopupMenu1: TPopupMenu;
    MenuDrop: TMenuItem;
    MenuShowMain: TMenuItem;
    MenuTrac: TMenuItem;
    XPMenu1: TXPMenu;
    Label1: TLabel;
    lblStr1: TLabel;
    lblStr2: TLabel;
    Label2: TLabel;
    MenuN1: TMenuItem;
    MenuDropSetup: TMenuItem;
    procedure pelMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MenuDropClick(Sender: TObject);
    procedure MenuTracClick(Sender: TObject);
    procedure MenuShowMainClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuDropSetupClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetDropFontStyle(FontStyle: TFontStyle);
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  FrmDrop: TFrmDrop;

implementation

uses Main, DropSetupFrm, ADSLStringRes;

{$R *.dfm}

procedure TFrmDrop.pelMainMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

procedure TFrmDrop.MenuDropClick(Sender: TObject);
begin
  MenuDrop.Checked := not MenuDrop.Checked;
  if MenuDrop.Checked then
    FrmDrop.Visible := True
  else
    FrmDrop.Visible := False;
end;

procedure TFrmDrop.MenuTracClick(Sender: TObject);
begin
  MenuTrac.Checked := not MenuTrac.Checked;
  if MenuTrac.Checked then
  begin
    FrmDrop.AlphaBlend := True;
    FrmDrop.AlphaBlendValue := 150;
  end
  else
    FrmDrop.AlphaBlend := False;
end;

procedure TFrmDrop.MenuShowMainClick(Sender: TObject);
begin
  MenuShowMain.Checked := not MenuShowMain.Checked;
  if MenuShowMain.Checked then
    FrmADSLMain.Visible := True
  else
    FrmADSLMain.Visible := False;
end;

procedure TFrmDrop.FormCreate(Sender: TObject);
var
  fINI: TINIFile;
  FontStyle: TFontStyle;
begin
  fINI := TINIFile.Create(Path + 'ADSL.ini');
  FrmDrop.AlphaBlendValue := fINI.ReadInteger('DropForm', 'Transparence', 150);
  pelMain.Color := fINI.ReadInteger('DropForm', 'FormColor', RGB(0, 0, 0));
  pelMain.Font.Name := fINI.ReadString('DropForm', 'FontName', '宋体');
  pelMain.Font.Size := 9;
  FontStyle := TFontStyle(StrToInt(fINI.ReadString('DropForm', 'FontStyle', '0')) - 1);
  SetDropFontStyle(FontStyle);
  pelMain.Font.Color := fINI.ReadInteger('DropForm', 'FontColor', RGB(0, 255, 0));
  FreeAndNil(fINI);

  
  if FrmADSLMain.Showing then
    MenuShowMain.Checked := True
  else
    MenuShowMain.Checked := False;
end;

procedure TFrmDrop.MenuDropSetupClick(Sender: TObject);
begin
  FrmDropSetup := TFrmDropSetup.Create(Self);
  FrmDropSetup.Visible := True;
end;

procedure TFrmDrop.FormShow(Sender: TObject);
begin
  FrmDrop.Left := 0;
  FrmDrop.Top := 0;
end;

procedure TFrmDrop.SetDropFontStyle(FontStyle: TFontStyle);
begin
  lblStr1.Font.Style := [FontStyle];
  lblStr2.Font.Style := [FontStyle];
  Label1.Font.Style := [FontStyle];
  Label2.Font.Style := [FontStyle];
end;

procedure TFrmDrop.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    EXStyle :=ExStyle or WS_EX_TOPMOST or WS_EX_TOOLWINDOW;
      WndParent := GetDesktopWindow; //关键一行，用SetParent都不行！！
  end;
end;

end.

