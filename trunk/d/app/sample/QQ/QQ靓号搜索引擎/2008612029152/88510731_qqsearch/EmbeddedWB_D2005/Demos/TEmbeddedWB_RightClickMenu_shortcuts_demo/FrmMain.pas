//  EmbeddedWB RightClickMenu Demo
//  by: Eran Bodankin (bsalsa)
//  mail: bsalsa@bsalsa.com
//  Date: 27/05/2005

//NOTE: Please, Do not mail me that I could use Menu Autocheck property! I am tired from those mails.
// I have Delphi 5 users also.

unit FrmMain;

interface

uses
  Classes, Forms, Menus, Controls, OleCtrls, EmbeddedWB,
  SHDocVw_EWB;

type
  TForm1 = class(TForm)
    EmbeddedWB1: TEmbeddedWB;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    DisableAllMenu1: TMenuItem;
    DisableAnchorMenu1: TMenuItem;
    DisableControlsMenu1: TMenuItem;
    DisableCtrlN1: TMenuItem;
    DisableDebugMenu1: TMenuItem;
    DisableDefaultMenu1: TMenuItem;
    DisableImageArtMenu1: TMenuItem;
    DisableImagesMenu1: TMenuItem;
    DisableImgDynSrcMenu1: TMenuItem;
    DisableOpenInANewWindow1: TMenuItem;
    DisableSelectedText1: TMenuItem;
    DisableTable: TMenuItem;
    DisableUnknownMenu1: TMenuItem;
    DisableViewSource1: TMenuItem;
    EnableAllMenus: TMenuItem;
    Exit1: TMenuItem;
    Note2: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Note1: TMenuItem;
    RightClickMenu1: TMenuItem;
    Shortcuts1: TMenuItem;
    DisableOpenLink1: TMenuItem;
    procedure DisableOpenInANewWindow1Click(Sender: TObject);
    procedure DisableCtrlN1Click(Sender: TObject);
    procedure DisableViewSource1Click(Sender: TObject);
    procedure DisableDefaultMenu1Click(Sender: TObject);
    procedure EnableAllMenusClick(Sender: TObject);
    procedure DisableSelectedText1Click(Sender: TObject);
    procedure DisableDebugMenu1Click(Sender: TObject);
    procedure DisableImageArtMenu1Click(Sender: TObject);
    procedure DisableImgDynSrcMenu1Click(Sender: TObject);
    procedure DisableUnknownMenu1Click(Sender: TObject);
    procedure DisableAnchorMenu1Click(Sender: TObject);
    procedure DisableControlsMenu1Click(Sender: TObject);
    procedure DisableTableClick(Sender: TObject);
    procedure DisableImagesMenu1Click(Sender: TObject);
    procedure DisableAllMenu1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DisableOpenLink1Click(Sender: TObject);

  private
     procedure UpdateMenu();
     procedure ResetEmbeddedWBMenus();
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure TForm1.ResetEmbeddedWBMenus();
begin
    EmbeddedWB1.RightClickMenu.DIsableAllMenus := true;
    EmbeddedWB1.RightClickMenu.DefaultMenu := true;
    EmbeddedWB1.RightClickMenu.ImageMenu := true;
    EmbeddedWB1.RightClickMenu.ControlMenu := true;
    EmbeddedWB1.RightClickMenu.TableMenu := true;
    EmbeddedWB1.RightClickMenu.SelTextMenu := true;
    EmbeddedWB1.RightClickMenu.AnchorMenu := true;
    EmbeddedWB1.RightClickMenu.UnKnownMenu := true;
    EmbeddedWB1.RightClickMenu.ImgDynSrcMenu := true;
    EmbeddedWB1.RightClickMenu.ImageArtMenu  := true;
end;

procedure TForm1.UpdateMenu();
begin
    DisableAllMenu1.Checked := False;
    DisableAnchorMenu1.Checked := False;
    DisableControlsMenu1.Checked := False;
    DisableCtrlN1.Checked := False;
    DisableDebugMenu1.Checked := False;
    DisableDefaultMenu1.Checked := False;
    DisableImageArtMenu1.Checked := False;
    DisableImagesMenu1.Checked := False;
    DisableImgDynSrcMenu1.Checked := False;
    DisableSelectedText1.Checked := False;
    DisableTable.Checked := False;
    DisableUnknownMenu1.Checked := False;
    EnableAllMenus.Checked := False;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
   EnableAllMenus.Checked := true;
   EmbeddedWB1.Navigate('www.bsalsa.com');
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
   Close;
end;

procedure TForm1.DisableAllMenu1Click(Sender: TObject);
begin
   UpdateMenu();
   ResetEmbeddedWBMenus();
   DisableAllMenu1.Checked := true;
   EmbeddedWB1.RightClickMenu.DIsableAllMenus := false;
end;

procedure TForm1.DisableImagesMenu1Click(Sender: TObject);
begin
   UpdateMenu();
   ResetEmbeddedWBMenus();
   DisableImagesMenu1.Checked := true;
   EmbeddedWB1.RightClickMenu.ImageMenu := false;
end;

procedure TForm1.DisableControlsMenu1Click(Sender: TObject);
begin
   UpdateMenu();
   ResetEmbeddedWBMenus();
   DisableControlsMenu1.Checked := true;
   EmbeddedWB1.RightClickMenu.ControlMenu := false;
end;

procedure TForm1.DisableTableClick(Sender: TObject);
begin
   UpdateMenu();
   ResetEmbeddedWBMenus();
   DisableTable.Checked := true;
   EmbeddedWB1.RightClickMenu.TableMenu := false;
end;

procedure TForm1.DisableSelectedText1Click(Sender: TObject);
begin
   UpdateMenu();
   ResetEmbeddedWBMenus();
   DisableSelectedText1.Checked := true;
   EmbeddedWB1.RightClickMenu.SelTextMenu := false;
end;

procedure TForm1.DisableAnchorMenu1Click(Sender: TObject);
begin
   UpdateMenu();
   ResetEmbeddedWBMenus();
   DisableAnchorMenu1.Checked := true;
   EmbeddedWB1.RightClickMenu.AnchorMenu := false;
end;

procedure TForm1.DisableUnknownMenu1Click(Sender: TObject);
begin
   UpdateMenu();
   ResetEmbeddedWBMenus();
   DisableUnknownMenu1.Checked := true;
   EmbeddedWB1.RightClickMenu.UnKnownMenu := false;
end;

procedure TForm1.DisableImgDynSrcMenu1Click(Sender: TObject);
begin
   UpdateMenu();
   ResetEmbeddedWBMenus();
   DisableImgDynSrcMenu1.Checked := true;
   EmbeddedWB1.RightClickMenu.ImgDynSrcMenu := false;
end;

procedure TForm1.DisableImageArtMenu1Click(Sender: TObject);
begin
  UpdateMenu();
  ResetEmbeddedWBMenus();
  DisableImageArtMenu1.Checked := true;
  EmbeddedWB1.RightClickMenu.ImageArtMenu := false;
end;

procedure TForm1.DisableDebugMenu1Click(Sender: TObject);
begin
  UpdateMenu();
  ResetEmbeddedWBMenus();
  DisableImageArtMenu1.Checked := true;
  EmbeddedWB1.RightClickMenu.DebugMenu := false;
end;

procedure TForm1.DisableDefaultMenu1Click(Sender: TObject);
begin
   UpdateMenu();
   ResetEmbeddedWBMenus();
   DisableDefaultMenu1.Checked := true;
   EmbeddedWB1.RightClickMenu.DefaultMenu := false;
end;

procedure TForm1.EnableAllMenusClick(Sender: TObject);
begin
   UpdateMenu();
   ResetEmbeddedWBMenus();
   EnableAllMenus.Checked := true;
end;

procedure TForm1.DisableViewSource1Click(Sender: TObject);
begin
  if DisableViewSource1.Checked = false then
      begin
        EmbeddedWB1.RightClickShortCuts.DisableViewSource:= true;
        DisableViewSource1.Checked := true;
      end
 else
     begin
        EmbeddedWB1.RightClickShortCuts.DisableViewSource:=false;
        DisableViewSource1.Checked := false;
     end;
end;

procedure TForm1.DisableCtrlN1Click(Sender: TObject);
begin
  if DisableCtrlN1.Checked = false then
      begin
        DisableCtrlN1.Checked := true;
        EmbeddedWB1.ShortCuts.DisableCTRL_N:= true;
      end
 else
      begin
        DisableCtrlN1.Checked := false;
        EmbeddedWB1.ShortCuts.DisableCTRL_N:=false;
      end;
end;

procedure TForm1.DisableOpenInANewWindow1Click(Sender: TObject);
begin
 if DisableOpenInANewWindow1.Checked = false then
     begin
       EmbeddedWB1.RightClickShortCuts.DisableOpenInNewWindow:=true;
       DisableOpenInANewWindow1.Checked := true;
     end
 else
     begin
       EmbeddedWB1.RightClickShortCuts.DisableOpenInNewWindow:= false;
       DisableOpenInANewWindow1.Checked := false;
     end;
end;

procedure TForm1.DisableOpenLink1Click(Sender: TObject);
begin
    if DisableOpenLink1.Checked = false then
     begin
       EmbeddedWB1.RightClickShortCuts.DisableOpenLink:=true;
       DisableOpenLink1.Checked := true;
     end
 else
     begin
       EmbeddedWB1.RightClickShortCuts.DisableOpenLink:= false;
       DisableOpenLink1.Checked := false;
     end;
end;

end.
