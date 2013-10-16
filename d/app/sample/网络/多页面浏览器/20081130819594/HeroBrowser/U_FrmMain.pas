unit U_FrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ToolWin, ActnMan, ActnCtrls, XPStyleActnCtrls,
  OleCtrls, SHDocVw, EmbeddedWB, ActnMenus, CustomizeDlg, ImgList,
  ComCtrls, StdCtrls, ExtCtrls, U_WebForm, U_WebToolBar, Menus,
  U_PublicInterface, Gauges, IEUtils, FavMenu, CommCtrl,
  IETravelLog, Buttons, U_SideBar, HttpApp, IEAddress, SecurityManager,
  ImportFavorites, ExportFavorites, U_UndoList, AppEvnts;

type
  TFrmMain = class(TForm, IMainUiHandler, IPageControl)
    imgToolBar: TImageList;
    StatusBar: TStatusBar;
    IETravelLog: TIETravelLog;
    ActionList: TActionList;
    Ac_Forward: TAction;
    Ac_Back: TAction;
    Ac_Stop: TAction;
    Ac_Refresh: TAction;
    Ac_Blank: TAction;
    Ac_Go: TAction;
    MainMenu: TMainMenu;
    F1: TMenuItem;
    N1: TMenuItem;
    E1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    CoolBar: TCoolBar;
    tblMainToolBar: TToolBar;
    ToolButton1: TToolButton;
    ToolButton6: TToolButton;
    btnBack: TToolButton;
    btnForward: TToolButton;
    ToolButton7: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    tblAddressBar: TToolBar;
    lblAddress: TLabel;
    btnAddress: TToolButton;
    pmnBack: TPopupMenu;
    pmnForward: TPopupMenu;
    N7: TMenuItem;
    Ac_Favorites: TAction;
    Ac_History: TAction;
    ToolButton9: TToolButton;
    btnFavorites: TToolButton;
    btnHistory: TToolButton;
    Splitter: TSplitter;
    pnlLeftDockBar: TPanel;
    cobAddress: TIEAddress;
    SecurityManager: TSecurityManager;
    Ac_AllowActivex: TAction;
    N8: TMenuItem;
    N9: TMenuItem;
    ACTIVEX1: TMenuItem;
    Ac_AllowScript: TAction;
    Ac_AllowImage: TAction;
    Ac_AllowVideo: TAction;
    Ac_AllowBkSound: TAction;
    Ac_AllowJava: TAction;
    N10: TMenuItem;
    N11: TMenuItem;
    JAVA1: TMenuItem;
    Script1: TMenuItem;
    AcAllowVideo1: TMenuItem;
    Opd: TOpenDialog;
    Sdl: TSaveDialog;
    ImportFavorite: TImportFavorite;
    ExportFavorite: TExportFavorite;
    Ac_About: TAction;
    N12: TMenuItem;
    SOEASY2: TMenuItem;
    Ac_Cut: TAction;
    Ac_Copy: TAction;
    Ac_Paste: TAction;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N18: TMenuItem;
    Ac_SelectAll: TAction;
    Ac_Search: TAction;
    N17: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    Ac_CurPage: TAction;
    N21: TMenuItem;
    N22: TMenuItem;
    Ac_Open: TAction;
    Ac_SaveAs: TAction;
    Ac_Print: TAction;
    Ac_PrintSet: TAction;
    Ac_Preview: TAction;
    Ac_OffLine: TAction;
    Ac_Close: TAction;
    Ac_CloseAll: TAction;
    Ac_Quit: TAction;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    N33: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    Ac_Property: TAction;
    N37: TMenuItem;
    N38: TMenuItem;
    Ac_ViewSource: TAction;
    N39: TMenuItem;
    N40: TMenuItem;
    Ac_HighLight: TAction;
    N41: TMenuItem;
    Ac_IeOption: TAction;
    Internet1: TMenuItem;
    Ac_SendUrlEmail: TAction;
    Ac_SendPageEmail: TAction;
    Ac_SendShotCut: TAction;
    N42: TMenuItem;
    N43: TMenuItem;
    N44: TMenuItem;
    N45: TMenuItem;
    N46: TMenuItem;
    Ac_HomePage: TAction;
    N47: TMenuItem;
    CoolBarPageControl: TCoolBar;
    PageControl: TTabControl;
    imgPageControl: TImageList;
    FavoritesMenu: TFavoritesMenu;
    imgFavorite: TImageList;
    ToolButton2: TToolButton;
    Ac_UnDo: TAction;
    ToolButton3: TToolButton;
    ToolButton8: TToolButton;
    pmnUndo: TPopupMenu;
    ToolBar1: TToolBar;
    ApplicationEvents: TApplicationEvents;
    procedure Ac_ForwardExecute(Sender: TObject);
    procedure Ac_BackExecute(Sender: TObject);
    procedure Ac_StopExecute(Sender: TObject);
    procedure Ac_RefreshExecute(Sender: TObject);
    procedure Ac_BlankExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cobAddressNavigateUrl(Sender: TObject; Url: String);
    procedure FormShow(Sender: TObject);
    procedure StatusBarResize(Sender: TObject);
    procedure FavoritesMenuURLSelected(Sender: TObject; Url: String);
    procedure Ac_GoExecute(Sender: TObject);
    procedure tblAddressBarResize(Sender: TObject);
    procedure IETravelLogEntry(Title, Url: String; var Cancel: Boolean);
    procedure pmnBackPopup(Sender: TObject);
    procedure pmnForwardPopup(Sender: TObject);
    procedure Ac_FavoritesExecute(Sender: TObject);
    procedure FormGetSiteInfo(Sender: TObject; DockClient: TControl;
      var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
    procedure OnSideBarPageControlChange(Sender: TObject);
    procedure pnlLeftDockBarDockDrop(Sender: TObject;
      Source: TDragDockObject; X, Y: Integer);
    procedure pnlLeftDockBarDockOver(Sender: TObject;
      Source: TDragDockObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean);
    procedure pnlLeftDockBarUnDock(Sender: TObject; Client: TControl;
      NewTarget: TWinControl; var Allow: Boolean);
    procedure Ac_AllowImageExecute(Sender: TObject);
    procedure FavoritesMenuExportClick(Sender: TObject;
      var LocalPath: String);
    procedure FavoritesMenuImportClick(Sender: TObject;
      var LocalPath: String);
    procedure Ac_AboutExecute(Sender: TObject);
    procedure Ac_OpenExecute(Sender: TObject);
    procedure Ac_CurPageExecute(Sender: TObject);
    procedure Ac_SaveAsExecute(Sender: TObject);
    procedure Ac_PrintSetExecute(Sender: TObject);
    procedure Ac_PrintExecute(Sender: TObject);
    procedure Ac_PreviewExecute(Sender: TObject);
    procedure Ac_OffLineExecute(Sender: TObject);
    procedure Ac_CloseExecute(Sender: TObject);
    procedure Ac_CloseAllExecute(Sender: TObject);
    procedure Ac_QuitExecute(Sender: TObject);
    procedure Ac_CutExecute(Sender: TObject);
    procedure Ac_CopyExecute(Sender: TObject);
    procedure Ac_PasteExecute(Sender: TObject);
    procedure Ac_SelectAllExecute(Sender: TObject);
    procedure Ac_SearchExecute(Sender: TObject);
    procedure Ac_PropertyExecute(Sender: TObject);
    procedure Ac_ViewSourceExecute(Sender: TObject);
    procedure Ac_HighLightExecute(Sender: TObject);
    procedure Ac_IeOptionExecute(Sender: TObject);
    procedure Ac_SendUrlEmailExecute(Sender: TObject);
    procedure Ac_SendPageEmailExecute(Sender: TObject);
    procedure Ac_SendShotCutExecute(Sender: TObject);
    procedure Ac_HomePageExecute(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure PageControlMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PageControlMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FavoritesMenuItemImageIndex(Sender: TObject;
      MenuItem: TMenuItem; MenuType: TMenuType; var ImageIndex: Integer);
    procedure Ac_UnDoExecute(Sender: TObject);
  private
    FProgressBar: TGauge;

    PopUpItems: array[0..9] of TMenuItem;
    ItemsCounter: Integer;
    FSideBar: TFrmSideBar;
    FRowCount: Integer;
    FPageUndoList: IPageUndoList;
  protected
    {IMainUiHandler}
    procedure ActiveWebChange; stdcall;
    procedure ChangeAddress(Address: String); stdcall;
    procedure RefreshProgress(Progress: Integer); stdcall;
    procedure ShowStatus(StatusText: String); stdcall;
    procedure CommandStateChange(Command: Integer; Enable: WordBool); stdcall;
    function GetPageControl: IPageControl; stdcall;
    {IPageControl}
    function InsertPage(PageText: String; PageObject: TObject): Integer; stdcall;
    procedure DeletePage(PageObject: TObject); stdcall;
    procedure ChagePageImage(PageObject: TObject; ImageIndex: Integer); stdcall;
    function GetPageCount: Integer; stdcall;
    procedure SetPageText(PageObject: TObject; Text: String); stdcall;
    function GetPageText(PageObject: TObject): string; stdcall;
  public
    procedure AdjustPageControl;
    procedure CreateFavoritesBar;
    procedure CreateProgress;
    function CurrentWebForm: TFrmWeb;
    procedure LoadOptionForAll;
    function NewPage(UrlStr: String; IsActive: Boolean): TFrmWeb;
    procedure OnSideBarClose(Sender: TObject; var Action: TCloseAction);
    procedure OnSideBarGotoUrl(Sender: TObject; const URL: String);
    procedure OnSideBarURLSelected(Sender: TObject; Url: String);
    procedure OnTravelLogItemClick(Sender: TObject);
    procedure OnUndoItemClick(Sender: TObject);
    procedure ShowDockPanel(APanel: TPanel; MakeVisible: Boolean; Client: TControl);
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses Unicode, U_UserConfig, U_FrmAbout;



{$R *.dfm}

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  CreateProgress;
  tblAddressBarResize(Nil);
  FRowCount := 1;

  FavoritesMenu.Images := imgFavorite;

  FPageUndoList := TPageUndoList.Create;
  FPageUndoList.MaxItemCount := 20;
end;


procedure TFrmMain.CreateFavoritesBar;
begin
  FSideBar := TFrmSideBar.Create(Self);
  FSideBar.OnClose := OnSideBarClose;
  FSideBar.FavoritesTree.OnNavigate := OnSideBarGotoUrl;
  FSideBar.HistoryListView.OnURLSelected := OnSideBarURLSelected;
  FSideBar.PageControl.OnChange := OnSideBarPageControlChange;
  FSideBar.ManualDock(pnlLeftDockBar);
  FSideBar.Visible := True;
end;

procedure TFrmMain.CreateProgress;
begin
  FProgressBar := TGauge.Create(Self);
  With FProgressBar Do
  Begin
    Parent := StatusBar;
    BorderStyle := bsNone;
    BackColor := StatusBar.Color;
    Left := StatusBar.Panels[0].Width + 3;
    Width := StatusBar.Panels[1].Width - 4;
    Top := 3;
    Height := StatusBar.Height - 4;

    MaxValue := 10000;
  End;
end;


procedure TFrmMain.FormDestroy(Sender: TObject);
begin
//
end;

procedure TFrmMain.Ac_ForwardExecute(Sender: TObject);
begin
  CurrentWebForm.GoForward;
end;

procedure TFrmMain.Ac_BackExecute(Sender: TObject);
begin
  If CurrentWebForm <> Nil Then
  CurrentWebForm.GoBack;
end;

procedure TFrmMain.Ac_StopExecute(Sender: TObject);
begin
  If CurrentWebForm <> Nil Then
    CurrentWebForm.Stop;
end;

procedure TFrmMain.Ac_RefreshExecute(Sender: TObject);
begin
  If CurrentWebForm <> Nil Then
    CurrentWebForm.Refresh;
end;

procedure TFrmMain.Ac_BlankExecute(Sender: TObject);
begin
  NewPage(C_BLANKADDR, True);
  cobAddress.SetFocus;
end;

function TFrmMain.CurrentWebForm: TFrmWeb;
begin
  Result := TFrmWeb(ActiveMDIChild);
end;

function TFrmMain.NewPage(UrlStr: String; IsActive: Boolean): TFrmWeb;
begin
  If MDIChildCount = 0 Then
    IsActive := True;

  Result := TFrmWeb.Create(UrlStr, IsActive, Self);
end;


procedure TFrmMain.cobAddressNavigateUrl(Sender: TObject; Url: String);
begin
  Ac_Go.Execute;
end;

procedure TFrmMain.ChangeAddress(Address: String);
begin
  cobAddress.Url := Address;
end;

procedure TFrmMain.RefreshProgress(Progress: Integer);
begin
  FProgressBar.Progress := Progress;
end;

procedure TFrmMain.ShowStatus(StatusText: String);
begin
  StatusBar.Panels[0].Text := StatusText;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  cobAddress.SetFocus;
  Ac_Blank.Execute;
  FavoritesMenu.CreateMenu;
  CreateFavoritesBar;
end;

procedure TFrmMain.StatusBarResize(Sender: TObject);
begin
  StatusBar.Panels[0].Width := StatusBar.Width
    - StatusBar.Panels[1].Width - StatusBar.Panels[2].Width;
  FProgressBar.Left := StatusBar.Panels[0].Width + 3;
  FProgressBar.Width := StatusBar.Panels[1].Width - 4;
  FProgressBar.Top := 3;
  FProgressBar.Height := StatusBar.Height - 4;
end;


procedure TFrmMain.FavoritesMenuURLSelected(Sender: TObject; Url: String);
begin
  NewPage(Url, False);
end;

procedure TFrmMain.CommandStateChange(Command: Integer; Enable: WordBool);
begin
  if Command = CSC_NAVIGATEFORWARD then
    Ac_Forward.Enabled := Enable;

  if Command = CSC_NAVIGATEBACK then
    Ac_Back.Enabled := Enable;

end;

procedure TFrmMain.ActiveWebChange;
Var
  WebForm: TFrmWeb;
begin
  WebForm := CurrentWebForm;
  If WebForm = Nil Then Exit;

  //改变地址栏
  cobAddress.Url := WebForm.WebUrl;

  PageControl.TabIndex := PageControl.Tabs.IndexOfObject(WebForm);
//  WebForm.ToolButton.Down := True;

  //刷新访问历史
//  IeTravelLog.Webbrowser := WebForm.WebBrowser;
//  IeTravelLog.Connect;

  FavoritesMenu.EmbeddedWB := WebForm.WebBrowser;

  //刷新进度条
  RefreshProgress(WebForm.Progress);

  WebForm.WebBrowser.SetFocusToDoc;
end;


procedure TFrmMain.Ac_GoExecute(Sender: TObject);
Var
  eWebForm: TFrmWeb;
begin
  eWebForm := CurrentWebForm;

  If eWebForm = Nil Then
    eWebForm := NewPage(cobAddress.Url, True)
  Else
    eWebForm.Go(cobAddress.Url, False);

  eWebForm.WebBrowser.SetFocusToDoc;
end;

procedure TFrmMain.tblAddressBarResize(Sender: TObject);
begin
  cobAddress.Width := tblAddressBar.Width - lblAddress.Width - btnAddress.Width;
end;

procedure TFrmMain.IETravelLogEntry(Title, Url: String;
  var Cancel: Boolean);
begin
  PopUpItems[itemsCounter] := TMenuItem.Create(Self);
  PopUpItems[itemsCounter].Caption := Title;
  PopUpItems[itemsCounter].Hint := Url;
  PopUpItems[itemsCounter].OnClick := OnTravelLogItemClick;

  If IETravelLog.IsBack Then
    pmnBack.Items.Add(PopUpItems[itemsCounter])
  ELse
    pmnForward.Items.Add(PopUpItems[itemsCounter]);

  Inc(ItemsCounter);
  if ItemsCounter = 10 then Cancel := True;
end;

procedure TFrmMain.OnTravelLogItemClick(Sender: TObject);
var
  index: Integer;
begin
  with Sender as TMenuItem do
    if IETravelLog.IsBack then
      Index := 0 - pmnBack.Items.IndexOf(Sender as TmenuItem) - 1
    else
      Index := pmnForward.Items.IndexOf(Sender as TmenuItem) + 1;

  IETravelLog.TravelTo(Index);
end;

procedure TFrmMain.pmnBackPopup(Sender: TObject);
Var
  eWebForm: TFrmWeb;
begin
  eWebForm := CurrentWebForm;

  If eWebForm = Nil Then Exit;

  pmnBack.Items.Clear;
  //刷新访问历史
  IeTravelLog.Webbrowser := eWebForm.WebBrowser;
  IeTravelLog.Connect;

  IETravellog.EnumerateBack;
end;

procedure TFrmMain.pmnForwardPopup(Sender: TObject);
Var
  eWebForm: TFrmWeb;
begin
  eWebForm := CurrentWebForm;

  If eWebForm = Nil Then Exit;

  pmnForward.Items.Clear;
  //刷新访问历史
  IeTravelLog.Webbrowser := eWebForm.WebBrowser;
  IeTravelLog.Connect;

  IETravellog.EnumerateForward;
end;


procedure TFrmMain.Ac_FavoritesExecute(Sender: TObject);
begin
  If btnFavorites.Down or btnHistory.Down Then
    pnlLeftDockBar.Visible := True
  Else
    pnlLeftDockBar.Visible := False;

  If Not TAction(Sender).Checked Then
    Exit;

  If Sender = Ac_Favorites Then
    FSideBar.SideBarType := sbtFavorites
  Else
    FSideBar.SideBarType := sbtHistory;
end;

procedure TFrmMain.FormGetSiteInfo(Sender: TObject; DockClient: TControl;
  var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
begin
  CanDock := DockClient Is TFrmSideBar;
end;

procedure TFrmMain.OnSideBarClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caNone;
  If FSideBar.HostDockSite <> Nil Then
    FSideBar.HostDockSite.Hide;
  Ac_Favorites.Checked := False;
  Ac_History.Checked := False;
end;

procedure TFrmMain.OnSideBarGotoUrl(Sender: TObject; const URL: String);
Var
  eWebForm: TFrmWeb;
begin
  eWebForm := CurrentWebForm;

  If eWebForm = Nil Then Exit;

  eWebForm.Go(URL, False);
end;

procedure TFrmMain.OnSideBarPageControlChange(Sender: TObject);
begin
  Case FSideBar.SideBarType Of
    sbtFavorites:
    Begin
      Ac_Favorites.Checked := True;
      Ac_History.Checked := False;
    End;
    sbtHistory:
    Begin
      Ac_Favorites.Checked := False;
      Ac_History.Checked := True;
    End;
  End;
end;

procedure TFrmMain.OnSideBarURLSelected(Sender: TObject; Url: String);
Var
  eWebForm: TFrmWeb;
begin
  eWebForm := CurrentWebForm;

  If eWebForm = Nil Then Exit;

  eWebForm.Go(URL, False);
end;

procedure TFrmMain.pnlLeftDockBarDockDrop(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer);
begin
  if (Sender as TPanel).DockClientCount = 1 then
    ShowDockPanel(Sender as TPanel, True, nil);
  (Sender as TPanel).DockManager.ResetBounds(True);
end;

procedure TFrmMain.pnlLeftDockBarDockOver(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
var
  ARect: TRect;
begin
  Accept := True;
  if Accept then
  begin
    //Modify the DockRect to preview dock area.
    ARect.TopLeft := pnlLeftDockBar.ClientToScreen(Point(0, 0));
    ARect.BottomRight := pnlLeftDockBar.ClientToScreen(
      Point(Self.ClientWidth div 3, pnlLeftDockBar.Height));
    Source.DockRect := ARect;
  end;
end;


procedure TFrmMain.pnlLeftDockBarUnDock(Sender: TObject; Client: TControl;
  NewTarget: TWinControl; var Allow: Boolean);
begin
  if (Sender as TPanel).DockClientCount = 0 then
    ShowDockPanel(Sender as TPanel, False, nil);
end;

procedure TFrmMain.ShowDockPanel(APanel: TPanel; MakeVisible: Boolean; Client:
    TControl);
begin
  if not MakeVisible and (APanel.VisibleDockClientCount > 1) then
    Exit;

  Splitter.Visible := MakeVisible;

  if MakeVisible then
  Begin
//    APanel.Width := ClientWidth div 3;
    APanel.Width := ClientWidth div 4;
    Splitter.Left := APanel.Width + Splitter.Width;
  End else
    APanel.Width := 0;

  if MakeVisible and (Client <> nil) then Client.Show;
end;

procedure TFrmMain.Ac_AllowImageExecute(Sender: TObject);
begin
  UserConfig.Down_AllowActivex := Ac_AllowActivex.Checked;
  UserConfig.Down_AllowImage := Ac_AllowImage.Checked;
  UserConfig.Down_AllowJava := Ac_AllowJava.Checked;
  UserConfig.Down_AllowVideo := Ac_AllowVideo.Checked;
  UserConfig.Down_AllowScript := Ac_AllowScript.Checked;
  UserConfig.Down_AllowBkSound := Ac_AllowBkSound.Checked;

  LoadOptionForAll;
end;

procedure TFrmMain.LoadOptionForAll;
Var
  I: Integer;
begin
  For I := 0 To MDIChildCount - 1 Do
    TFrmWeb(MdiChildren[I]).LoadOption;
end;

procedure TFrmMain.FavoritesMenuExportClick(Sender: TObject;
  var LocalPath: String);
begin
  Sdl.FileName := LocalPath;
  If Not Sdl.Execute Then
  Begin
    LocalPath := '';
    Exit;
  End;

  LocalPath := Sdl.FileName;
  LocalPath := ChangeFileExt(LocalPath, '.htm');
end;

procedure TFrmMain.FavoritesMenuImportClick(Sender: TObject;
  var LocalPath: String);
begin
  Opd.FileName := LocalPath;
  If Not Opd.Execute Then  Begin
    LocalPath := '';
    Exit;
  End;

  LocalPath := Opd.FileName;
end;

procedure TFrmMain.Ac_AboutExecute(Sender: TObject);
begin
  With TAboutBox.Create(Self) Do
  Begin
    ShowModal;
    Free;
  End;
end;

procedure TFrmMain.Ac_OpenExecute(Sender: TObject);
begin
  If CurrentWebForm = Nil Then Exit;

  CurrentWebForm.WebBrowser.OpenDialog;;
end;

procedure TFrmMain.Ac_CurPageExecute(Sender: TObject);
begin
  If CurrentWebForm = Nil Then Exit;

  CurrentWebForm.WebBrowser.OpenOtherWBFavorites;
end;

procedure TFrmMain.Ac_SaveAsExecute(Sender: TObject);
begin
  If CurrentWebForm = Nil Then Exit;

  CurrentWebForm.WebBrowser.SaveDialog;
end;

procedure TFrmMain.Ac_PrintSetExecute(Sender: TObject);
begin
  If CurrentWebForm = Nil Then Exit;

  CurrentWebForm.WebBrowser.PrintSetup;
end;

procedure TFrmMain.Ac_PrintExecute(Sender: TObject);
begin
  If CurrentWebForm = Nil Then Exit;

  CurrentWebForm.WebBrowser.Print;
end;

procedure TFrmMain.Ac_PreviewExecute(Sender: TObject);
begin
  If CurrentWebForm = Nil Then Exit;

  CurrentWebForm.WebBrowser.PrintPreView;

end;

procedure TFrmMain.Ac_OffLineExecute(Sender: TObject);
begin
  If CurrentWebForm = Nil Then Exit;

  If Ac_OffLine.Checked Then
    CurrentWebForm.WebBrowser.WorkOffline
  Else
    CurrentWebForm.WebBrowser.WorkOnline;
end;

procedure TFrmMain.Ac_CloseExecute(Sender: TObject);
begin
  If CurrentWebForm = Nil Then Exit;

  CurrentWebForm.Close;
end;

procedure TFrmMain.Ac_CloseAllExecute(Sender: TObject);
begin

  While MDIChildCount <> 0 Do
    MDIChildren[MDIChildCount - 1].Free;
end;

procedure TFrmMain.Ac_QuitExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmMain.Ac_CutExecute(Sender: TObject);
begin
  If Not cobAddress.Focused Then
    CurrentWebForm.WebBrowser.Cut
  Else
    cobAddress.Perform(WM_CUT, 0, 0);
end;

procedure TFrmMain.Ac_CopyExecute(Sender: TObject);
begin
  If Not cobAddress.Focused Then
    CurrentWebForm.WebBrowser.Copy
  Else
    cobAddress.Perform(WM_COPY, 0, 0);
end;

procedure TFrmMain.Ac_PasteExecute(Sender: TObject);
begin
  If Not cobAddress.Focused Then
    CurrentWebForm.WebBrowser.Paste
  Else
    cobAddress.Perform(WM_PASTE, 0, 0);
end;

procedure TFrmMain.Ac_SelectAllExecute(Sender: TObject);
begin
  If CurrentWebForm = Nil Then Exit;

  CurrentWebForm.WebBrowser.SelectAll;
end;

procedure TFrmMain.Ac_SearchExecute(Sender: TObject);
begin
  If CurrentWebForm = Nil Then Exit;

  CurrentWebForm.WebBrowser.ShowFindDialog;
end;

procedure TFrmMain.Ac_PropertyExecute(Sender: TObject);
begin
  If CurrentWebForm = Nil Then Exit;

  CurrentWebForm.WebBrowser.ShowPageProperties;
end;

procedure TFrmMain.Ac_ViewSourceExecute(Sender: TObject);
begin
  If CurrentWebForm = Nil Then Exit;

  CurrentWebForm.WebBrowser.ViewPageSourceHtml;
end;

procedure TFrmMain.Ac_HighLightExecute(Sender: TObject);
Var
  eText: String;
begin
  If CurrentWebForm = Nil Then Exit;

  if Not InputQuery('高亮显示', '请输入搜索的字符：', eText) Then Exit;  

  CurrentWebForm.WebBrowser.SearchAndHighlight(eText);
end;

procedure TFrmMain.Ac_IeOptionExecute(Sender: TObject);
begin
  If CurrentWebForm = Nil Then Exit;

  CurrentWebForm.WebBrowser.ShowInternetOptions;
end;

procedure TFrmMain.Ac_SendUrlEmailExecute(Sender: TObject);
begin
  If CurrentWebForm = Nil Then Exit;

  CurrentWebForm.WebBrowser.SendURLInMail;
end;

procedure TFrmMain.Ac_SendPageEmailExecute(Sender: TObject);
begin
  If CurrentWebForm = Nil Then Exit;

  CurrentWebForm.WebBrowser.SendPageInMail(CurrentWebForm.WebBrowser.LocationName);
end;

procedure TFrmMain.Ac_SendShotCutExecute(Sender: TObject);
begin
  If CurrentWebForm = Nil Then Exit;

  CurrentWebForm.WebBrowser.CreateADesktopShortcut;
end;

procedure TFrmMain.Ac_HomePageExecute(Sender: TObject);
begin
  If CurrentWebForm = Nil Then Exit;

  CurrentWebForm.WebBrowser.GoHome;    
end;

procedure TFrmMain.AdjustPageControl;
Var
  eAlign : TAlign;
Begin
  if PageControl.Tabs.Count = 0 Then Exit;

  If FRowCount = PageControl.RowCount Then Exit;

  FRowCount := PageControl.RowCount;
  eAlign := CoolBarPageControl.Align;
  CoolBarPageControl.Align := alNone;
  PageControl.Height := PageControl.RowCount * PageControl.TabHeight +
    PageControl.RowCount * 2;
  CoolBarPageControl.Align := eAlign;  
end;

function TFrmMain.GetPageControl: IPageControl;
begin
  Result := Self;
end;

procedure TFrmMain.DeletePage(PageObject: TObject);
Var
  Index: Integer;
  UndoItem: TUndoItem;
  eUndoItem: PUndoItem;
  MenuItem: TMenuItem;
begin
  Index := PageControl.Tabs.IndexOfObject(PageObject);
  If Index = -1 Then Exit;

  If FPageUndoList.ItemCount = FPageUndoList.MaxItemCount Then
    pmnUndo.Items[pmnUndo.Items.Count - 1].Free;

  UndoItem.Name := TFrmWeb(PageObject).WebTitle;
  UndoItem.Url := TFrmWeb(PageObject).WebUrl;
  UndoItem.DateTime := Now;
  eUndoItem := FPageUndoList.Add(UndoItem);

  MenuItem := TMenuItem.Create(pmnUndo);
  MenuItem.Caption := UndoItem.Name;
  MenuItem.Hint := UndoItem.Url;
  MenuItem.Tag := Integer(eUndoItem);
  MenuItem.OnClick := OnUndoItemClick;
  pmnUndo.Items.Insert(0, MenuItem);


  PageControl.Tabs.Delete(Index);

  AdjustPageControl;


  If (PageControl.TabIndex = -1) And (MDIChildCount = 1) Then
  Begin
    PageControl.TabIndex := 0;
    PageControlChange(Nil);
  End;
end;

function TFrmMain.GetPageCount: Integer;
begin
  Result := PageControl.Tabs.Count;
end;

function TFrmMain.InsertPage(PageText: String; PageObject: TObject): Integer;
begin
  PageControl.Tabs.InsertObject(PageControl.TabIndex + 1,PageText, PageObject);
  Result := PageControl.TabIndex + 1;

  AdjustPageControl;
end;

procedure TFrmMain.SetPageText(PageObject: TObject; Text: String);
Var
  Index: Integer;
begin
  Index := PageControl.Tabs.IndexOfObject(PageObject);
  If Index = -1 Then Exit;

  PageControl.Tabs.Strings[Index] := Text;
end;

function TFrmMain.GetPageText(PageObject: TObject): string;
Var
  Index: Integer;
begin
  Index := PageControl.Tabs.IndexOfObject(PageObject);
  If Index = -1 Then Exit;

  Result := PageControl.Tabs.Strings[Index];
end;

procedure TFrmMain.ChagePageImage(PageObject: TObject; ImageIndex: Integer);
Var
  Index: Integer;
  TCItem: TTCItem;
begin
  Index := PageControl.Tabs.IndexOfObject(PageObject);
  If Index = -1 Then Exit;

  TCItem.mask := TCIF_IMAGE;
  TCItem.iImage := ImageIndex;
  SendMessage(PageControl.Handle, TCM_SETITEM, Index, Longint(@TCItem));

  PageControl.Refresh;
//  TabsChanged;
end;

procedure TFrmMain.PageControlChange(Sender: TObject);
begin
  If PageControl.TabIndex = -1 Then Exit;

  TFrmWeb(PageControl.Tabs.Objects[PageControl.TabIndex]).ShowWebForm;
end;

procedure TFrmMain.PageControlMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
  Index: Integer;
begin
  If ssDouble in Shift Then
  Begin
    Index := PageControl.IndexOfTabAt(X, Y);
    If Index = -1 Then Exit;

    TFrmWeb(PageControl.Tabs.Objects[Index]).Close;
  End;
end;


procedure TFrmMain.PageControlMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
Var
  TabIndex: Integer;
begin
  TabIndex := PageControl.IndexOfTabAt(X, Y);
  If TabIndex = -1 Then Exit;

  PageControl.Hint := PageControl.Tabs[TabIndex];
end;

procedure TFrmMain.FavoritesMenuItemImageIndex(Sender: TObject;
  MenuItem: TMenuItem; MenuType: TMenuType; var ImageIndex: Integer);
begin
  Case MenuType Of
    mtFolder, mtEmptyFolder: ImageIndex := 0;
    mtItem: ImageIndex := 1;
    mtAddFavorite: ImageIndex := 2;
    mtOrganizeFavorites: ImageIndex := 3;
    mtImportFavorites: ImageIndex := 4;
    mtExportFavorites: ImageIndex := 5;
  End;
end;

procedure TFrmMain.OnUndoItemClick(Sender: TObject);
Var
  Url: String;
begin
  Url := TMenuItem(Sender).Hint;

  NewPage(Url, False);

  FPageUndoList.Delete(PUndoItem(TMenuItem(Sender).Tag));
  Sender.Free;
end;

procedure TFrmMain.Ac_UnDoExecute(Sender: TObject);
begin
  If pmnUndo.Items.Count = 0 Then Exit;

  pmnUndo.Items[0].Click;
end;

end.
