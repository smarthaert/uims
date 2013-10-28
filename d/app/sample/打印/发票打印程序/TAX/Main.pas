unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, ExtCtrls, Wall, ExtDlgs, Jpeg;

type
  TFrmMain = class(TForm)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    miJBInput: TMenuItem;
    miChargeInput: TMenuItem;
    miEPriseReg: TMenuItem;
    N5: TMenuItem;
    miExit: TMenuItem;
    N7: TMenuItem;
    miJBQuery: TMenuItem;
    miChargeQuery: TMenuItem;
    miEPriseQuery: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    miBackGround: TMenuItem;
    Timer1: TTimer;
    Wallpaper1: TWallpaper;
    BackGroundDialog: TOpenPictureDialog;
    N2: TMenuItem;
    procedure Timer1Timer(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure miBackGroundClick(Sender: TObject);
    procedure miJBInputClick(Sender: TObject);
    procedure miChargeInputClick(Sender: TObject);
    procedure miEPriseRegClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses Tools, ChargeInput, EPriseReg, JBInput, IMESet, Login;

{$R *.DFM}

procedure TFrmMain.Timer1Timer(Sender: TObject);
begin
  StatusBar1.Panels[2].Text:=FormatDateTime('dddddd ,hh:mm:ss AM/PM',Now);
end;

procedure TFrmMain.miExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Application.MessageBox('真的要退出系统吗？','提示信息',MB_OKCANCEL+MB_ICONQUESTION)=IDOK then
    Action:=caFree
  else
    Action:=caNone;
end;

procedure TFrmMain.miBackGroundClick(Sender: TObject);
var
  BackFile:String;
begin
    BackFile:=regReadString('\SOFTWARE\Fly Dance Software\Tax','BackGround');
    BackGroundDialog.InitialDir:=JustPathName(BackFile);

    if BackGroundDialog.Execute then
    begin
      Wallpaper1.Wallpaper.LoadFromFile(BackGroundDialog.FileName);
      regWriteString('\SOFTWARE\Fly Dance Software\Tax','BackGround',BackGroundDialog.FileName)
    end;
end;

procedure TFrmMain.miJBInputClick(Sender: TObject);
var
  FrmJBInput: TFrmJBInput;
begin
  FrmJBInput:=TFrmJBInput.Create(Self);
  try
    FrmJBInput.ShowModal;
  finally
    FrmJBInput.Free;
  end;
end;

procedure TFrmMain.miChargeInputClick(Sender: TObject);
var
  FrmChargeInput: TFrmChargeInput;
begin
  FrmChargeInput:=TFrmChargeInput.Create(Self);
  try
    FrmChargeInput.ShowModal;
  finally
    FrmChargeInput.Free;
  end;
end;

procedure TFrmMain.miEPriseRegClick(Sender: TObject);
var
  FrmEPriseReg: TFrmEPriseReg;
begin
  FrmEPriseReg:= TFrmEPriseReg.Create(Self);
  try
    FrmEPriseReg.ShowModal;
  finally
    FrmEPriseReg.Free;
  end;
end;

procedure TFrmMain.N2Click(Sender: TObject);
var
  FrmIMESet: TFrmIMESet;
begin
  FrmIMESet:=TFrmIMESet.Create(Self);
  try
    FrmIMESet.ShowModal;
  finally
    FrmIMESet.Free;
  end;
end;

procedure TFrmMain.FormActivate(Sender: TObject);
var
  BackFile:String;
  Pic:TPicture;
begin
  Pic:=TPicture.Create;
  try
      BackFile:=regReadString('\SOFTWARE\Fly Dance Software\Tax','BackGround');
      if (Length(BackFile)>0)and(FileExists(BackFile))  then
      begin
        Pic.LoadFromFile(BackFile);
        Wallpaper1.Wallpaper:=Pic;
      end;

  finally
    Pic.Free;
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  FrmLogin: TFrmLogin;
begin
  FrmLogin:=TFrmLogin.Create(Self);
  try
    FrmLogin.ShowModal;
  finally
    FrmLogin.Free;
  end;
end;

end.
