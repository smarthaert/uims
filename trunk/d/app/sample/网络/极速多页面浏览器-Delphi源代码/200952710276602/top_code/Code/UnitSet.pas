unit UnitSet;

interface

{$DEFINE WINNT}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Buttons, StdCtrls, TLHelp32, ExtCtrls, 
  IniFiles, Gauges, CheckLst,
  Registry, Menus, OleCtrls, SHDocVw;
  //XPMan;

type proc=procedure;

type
  TSetForm = class(TForm)
    TimerStatusBar: TTimer;
    OpenDialogList: TOpenDialog;
    SaveDialog: TSaveDialog;
    PopupMenuQuickLink: TPopupMenu;
    N2: TMenuItem;
    NSBEditCurrentQLData: TMenuItem;
    NSaveQuickLink: TMenuItem;
    PopupMenuProxy: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    PopupMenuWhiteList: TPopupMenu;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    PanelMain: TPanel;
    TabSheet1: TTabSheet;
    SBOKCG: TSpeedButton;
    GroupBox2: TGroupBox;
    CBLoadBrowserHis: TCheckBox;
    CBLoadFavorite: TCheckBox;
    Panel1: TPanel;
    Label12: TLabel;
    RBOpenHome: TRadioButton;
    RBOpenDefault: TRadioButton;
    RBOpenNull: TRadioButton;
    CBLoadLastTime: TCheckBox;
    CBCreateOneLabel: TCheckBox;
    GroupBox4: TGroupBox;
    Label18: TLabel;
    CBCleanAddress: TCheckBox;
    CBCleanCache: TCheckBox;
    CBCleanHistory: TCheckBox;
    CBCleanCookies: TCheckBox;
    CBCleanRecent: TCheckBox;
    CBExitCleanAllHistory: TCheckBox;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    SBStatusBarSet: TSpeedButton;
    EStatusBar: TEdit;
    GroupBox7: TGroupBox;
    Panel2: TPanel;
    Label24: TLabel;
    RBAtCurentPage: TRadioButton;
    RBGoToNewPage: TRadioButton;
    Panel3: TPanel;
    Label25: TLabel;
    RBInstallTrayIconON: TRadioButton;
    RBInstallTrayIconNOON: TRadioButton;
    Panel8: TPanel;
    Label23: TLabel;
    RBTabAt0: TRadioButton;
    RBTabAt1: TRadioButton;
    PanelAppendPage: TPanel;
    Label32: TLabel;
    RBAppenPageYes: TRadioButton;
    RBAppenPageNo: TRadioButton;
    Panel6: TPanel;
    Label33: TLabel;
    RBHoldOneYes: TRadioButton;
    RBHoldOneNo: TRadioButton;
    Panel18: TPanel;
    Label36: TLabel;
    RBCRCurrentNo: TRadioButton;
    RBCloseOnly: TRadioButton;
    Panel5: TPanel;
    Label37: TLabel;
    RBCloseGoTab1: TRadioButton;
    RBCloseGoTab2: TRadioButton;
    Panel7: TPanel;
    Label39: TLabel;
    RBNewTabY: TRadioButton;
    RBNewTabN: TRadioButton;
    TabSheetButton: TTabSheet;
    GroupBox10: TGroupBox;
    Label40: TLabel;
    Label41: TLabel;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    BToolReplace1010: TSpeedButton;
    BToolReplace1012: TSpeedButton;
    BToolReplace1013: TSpeedButton;
    BToolReplace1014: TSpeedButton;
    BToolReplace1015: TSpeedButton;
    BToolReplace1016: TSpeedButton;
    BToolReplace1111: TSpeedButton;
    BToolReplace1112: TSpeedButton;
    BToolReplace1113: TSpeedButton;
    BToolReplace1114: TSpeedButton;
    BToolReplace1115: TSpeedButton;
    BToolReplace1116: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    SpeedButton19: TSpeedButton;
    SpeedButton21: TSpeedButton;
    SpeedButton22: TSpeedButton;
    SpeedButton23: TSpeedButton;
    SpeedButton24: TSpeedButton;
    SpeedButton25: TSpeedButton;
    Label56: TLabel;
    SpeedButton36: TSpeedButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox12: TCheckBox;
    TabSheetMousssTable: TTabSheet;
    Panel17: TPanel;
    GroupBox8: TGroupBox;
    SpeedButton27: TSpeedButton;
    SpeedButton28: TSpeedButton;
    SpeedButton29: TSpeedButton;
    SpeedButton31: TSpeedButton;
    SpeedButton32: TSpeedButton;
    SpeedButton33: TSpeedButton;
    CBSSTop: TComboBox;
    CBUseSS: TCheckBox;
    ButtonSSOK: TButton;
    CBSSButtom: TComboBox;
    CBSSLeft: TComboBox;
    CBSSRight: TComboBox;
    CBSSRightTop: TComboBox;
    CBSSRightButtom: TComboBox;
    GroupBox5: TGroupBox;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    ENickName: TEdit;
    BInputTable: TButton;
    EUserName: TEdit;
    EPassWord: TEdit;
    EEmail: TEdit;
    ERealName: TEdit;
    TabSheetQuickLink: TTabSheet;
    Panel16: TPanel;
    Label45: TLabel;
    Label46: TLabel;
    SpeedButton20: TSpeedButton;
    SpeedButton26: TSpeedButton;
    ListBoxQuickLink: TListBox;
    EQLTitle: TEdit;
    EQLUrl: TEdit;
    BQuickLinkOK: TButton;
    BAddQuickLink: TButton;
    BLoadQuickLink: TButton;
    Button3: TButton;
    TabSheetProxy: TTabSheet;
    Panel9: TPanel;
    Label31: TLabel;
    Label38: TLabel;
    SpeedButton34: TSpeedButton;
    SpeedButton35: TSpeedButton;
    EProxyAddress: TEdit;
    EProxyNumber: TEdit;
    BProxySetOK: TButton;
    BAddToProxyList: TButton;
    BLoadProxyList: TButton;
    BSaveProxyList: TButton;
    ListBoxProxyList: TListBox;
    Panel20: TPanel;
    CBUseProxy: TCheckBox;
    CBNoUseProxy: TCheckBox;
    TabSheetHistory: TTabSheet;
    Panel14: TPanel;
    SBCleanAddress: TSpeedButton;
    SBDelete: TSpeedButton;
    SBCleanHistoryList: TSpeedButton;
    SBHistorySave: TSpeedButton;
    SBLoadNewly: TSpeedButton;
    ListBoxHistory: TListBox;
    TabSheet11: TTabSheet;
    Panel4: TPanel;
    TabSheetWhiteList: TTabSheet;
    Panel11: TPanel;
    Label26: TLabel;
    Label27: TLabel;
    ListBoxWhiteList: TListBox;
    EditWhiteList: TEdit;
    BAddWhiteList: TButton;
    BWhiteListSaveOK: TButton;
    BWhiteListClear: TButton;
    BWhiteListLoad: TButton;
    TabSheetOther: TTabSheet;
    Panel12: TPanel;
    GroupBox9: TGroupBox;
    LabelF: TLabel;
    LabelFavddddoriteDir: TLabel;
    Button1: TButton;
    ButtonImport: TButton;
    GroupBox6: TGroupBox;
    Label21: TLabel;
    Label22: TLabel;
    CBWeather2: TComboBox;
    ListBoxWeather: TListBox;
    RBWeatherPageSource1: TRadioButton;
    RBWeatherPageSource2: TRadioButton;
    SBWeatherOK: TButton;
    CBWeather: TComboBoxEx;
    GroupBox3: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label17: TLabel;
    BUnlockReg: TButton;
    BDefaultTXTType: TButton;
    BDefaultAll: TButton;
    Button4: TButton;
    BLockAll: TButton;
    TabSheetSystem: TTabSheet;
    Panel10: TPanel;
    Pie: TGauge;
    SBGetAutoRunKey: TSpeedButton;
    SBMemoryOptimize: TSpeedButton;
    SBProcessList: TSpeedButton;
    SBAllProcess: TSpeedButton;
    SBProcessPath: TSpeedButton;
    SBSystemInfo: TSpeedButton;
    ListBoxRegKey: TListBox;
    CLBox1_: TCheckListBox;
    LBProcess: TListBox;
    ListBoxProcess: TListBox;
    MemoSystemInfo: TMemo;
    EditDefaultPage: TEdit;
    EAnswer: TEdit;
    Label47: TLabel;
    PageControl1: TPageControl;
    Panel13: TPanel;
    RBBlackList: TRadioButton;
    RBWhiteList: TRadioButton;
    EFavoriteDir: TEdit;
    RBUseSys: TRadioButton;
    RBUseSelf: TRadioButton;
    BFavOk: TButton;
    ComboBox1: TComboBox;
    HotKey1: THotKey;
    Label48: TLabel;
    procedure SBSystemInfoClick(Sender: TObject);
    procedure SBProcessPathClick(Sender: TObject);
    procedure SBAllProcessClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SBProcessListClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SBMemoryOptimizeClick(Sender: TObject);
    procedure EStatusBarChange(Sender: TObject);
    procedure TimerStatusBarTimer(Sender: TObject);
    procedure SBStatusBarSetClick(Sender: TObject);
    procedure CBLoadBrowserHisClick(Sender: TObject);
    procedure SBOKCGClick(Sender: TObject);
    procedure CBLoadFavoriteClick(Sender: TObject);
    procedure CBCleanAddressClick(Sender: TObject);
    procedure CBCleanHistoryClick(Sender: TObject);
    procedure CBCleanCacheClick(Sender: TObject);
    procedure CBCleanCookiesClick(Sender: TObject);
    procedure RBOpenDefaultClick(Sender: TObject);
    procedure RBOpenHomeClick(Sender: TObject);
    procedure RBOpenNullClick(Sender: TObject);
    procedure BUnlockRegClick(Sender: TObject);
    procedure BDefaultAllClick(Sender: TObject);
    procedure BDefaultTXTTypeClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerPlayerTimer(Sender: TObject);
    procedure CBLoopPlayClick(Sender: TObject);
    procedure SBWeatherOKClick(Sender: TObject);
    procedure RBWeatherPageSource1Click(Sender: TObject);
    procedure RBWeatherPageSource2Click(Sender: TObject);
    procedure BLockAllClick(Sender: TObject);
    procedure RBTabAt0Click(Sender: TObject);
    procedure RBTabAt1Click(Sender: TObject);
    procedure RBAtCurentPageClick(Sender: TObject);
    procedure RBGoToNewPageClick(Sender: TObject);
    procedure RBInstallTrayIconONClick(Sender: TObject);
    procedure RBInstallTrayIconNOONClick(Sender: TObject);
    procedure CBCleanRecentClick(Sender: TObject);
    procedure SBGetAutoRunKeyClick(Sender: TObject);
    procedure CLBox1_DblClick(Sender: TObject);
    procedure LBProcessDblClick(Sender: TObject);
    procedure ListBoxRegKeyDblClick(Sender: TObject);
    procedure CBLoadLastTimeClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RBAppenPageYesClick(Sender: TObject);
    procedure NoClick(Sender: TObject);
    procedure CBCreateOneLabelClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RBHoldOneYesClick(Sender: TObject);
    procedure RBHoldOneNoClick(Sender: TObject);
    procedure ButtonImportClick(Sender: TObject);
    procedure SBCleanAddressClick(Sender: TObject);
    procedure SBDeleteClick(Sender: TObject);
    procedure SBCleanHistoryListClick(Sender: TObject);
    procedure SBHistorySaveClick(Sender: TObject);
    procedure SBLoadNewlyClick(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure CBUseSSClick(Sender: TObject);
    procedure CBSSTopChange(Sender: TObject);
    procedure CBSSButtomChange(Sender: TObject);
    procedure CBSSLeftChange(Sender: TObject);
    procedure CBSSRightChange(Sender: TObject);
    procedure ButtonSSOKClick(Sender: TObject);
    procedure BAddQuickLinkClick(Sender: TObject);
    procedure BQuickLinkOKClick(Sender: TObject);              
    procedure ListBoxQuickLinkDblClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure BLoadQuickLinkClick(Sender: TObject);
    procedure NSBEditCurrentQLDataClick(Sender: TObject);
    procedure NSaveQuickLinkClick(Sender: TObject);
    procedure EQLTitleKeyPress(Sender: TObject; var Key: Char);
    procedure EQLUrlKeyPress(Sender: TObject; var Key: Char);
    procedure Button3Click(Sender: TObject);
    procedure SpeedButton20Click(Sender: TObject);
    procedure SpeedButton26Click(Sender: TObject);
    procedure CBSSRightTopChange(Sender: TObject);
    procedure CBSSRightButtomChange(Sender: TObject);
    procedure RBCRCurrentNoClick(Sender: TObject);
    procedure RBCloseOnlyClick(Sender: TObject);
    procedure CBNoUseProxyClick(Sender: TObject);
    procedure CBUseProxyClick(Sender: TObject);
    procedure BProxySetOKClick(Sender: TObject);
    procedure SpeedButton34Click(Sender: TObject);
    procedure SpeedButton35Click(Sender: TObject);
    procedure BAddToProxyListClick(Sender: TObject);
    procedure ListBoxProxyListDblClick(Sender: TObject);
    procedure BLoadProxyListClick(Sender: TObject);
    procedure BSaveProxyListClick(Sender: TObject);
    procedure EProxyAddressKeyPress(Sender: TObject; var Key: Char);
    procedure EProxyNumberKeyPress(Sender: TObject; var Key: Char);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure CBExitCleanAllHistoryClick(Sender: TObject);
    procedure BWhiteListSaveOKClick(Sender: TObject);
    procedure BWhiteListClearClick(Sender: TObject);
    procedure BAddWhiteListClick(Sender: TObject);
    procedure EditWhiteListKeyPress(Sender: TObject; var Key: Char);
    procedure BWhiteListLoadClick(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure BInputTableClick(Sender: TObject);
    procedure ENickNameChange(Sender: TObject);
    procedure EUserNameChange(Sender: TObject);
    procedure EPassWordChange(Sender: TObject);
    procedure EEmailChange(Sender: TObject);
    procedure ERealNameChange(Sender: TObject);
    procedure ENickNameKeyPress(Sender: TObject; var Key: Char);
    procedure EUserNameKeyPress(Sender: TObject; var Key: Char);
    procedure EPassWordKeyPress(Sender: TObject; var Key: Char);
    procedure EEmailKeyPress(Sender: TObject; var Key: Char);
    procedure ERealNameKeyPress(Sender: TObject; var Key: Char);
    procedure RBCloseGoTab1Click(Sender: TObject);
    procedure RBCloseGoTab2Click(Sender: TObject);
    procedure RBNewTabYClick(Sender: TObject);
    procedure RBNewTabNClick(Sender: TObject);
    procedure BToolReplace1010Click(Sender: TObject);
    procedure BToolReplace1012Click(Sender: TObject);
    procedure BToolReplace1013Click(Sender: TObject);
    procedure BToolReplace1014Click(Sender: TObject);
    procedure BToolReplace1015Click(Sender: TObject);
    procedure BToolReplace1016Click(Sender: TObject);
    procedure BToolReplace1111Click(Sender: TObject);
    procedure BToolReplace1112Click(Sender: TObject);
    procedure BToolReplace1113Click(Sender: TObject);
    procedure BToolReplace1114Click(Sender: TObject);
    procedure BToolReplace1115Click(Sender: TObject);
    procedure BToolReplace1116Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
    procedure CheckBox11Click(Sender: TObject);
    procedure EditDefaultPageChange(Sender: TObject);
    procedure EAnswerChange(Sender: TObject);
    procedure EAnswerKeyPress(Sender: TObject; var Key: Char);
    procedure MeasureSubItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
    procedure DrawSubItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
    procedure BFavOkClick(Sender: TObject);
    procedure RBUseSysClick(Sender: TObject);
    procedure RBUseSelfClick(Sender: TObject);
    procedure EFavoriteDirChange(Sender: TObject);
    procedure HotKey1Change(Sender: TObject);
    procedure EQLTitleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EQLUrlKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    //procedure GetIniData;
    procedure AddQuickLinkClick(Sender:TObject);
    procedure QuickLinkClick(Sender:TObject);
  public
    { Public declarations }
    procedure SetFavoriteDir(Dir:string;ShowMess:Boolean);
    //procedure AddQuickLinkItem(STitle,SUrl:string);
    //procedure DeleteQuickLinkItem(SUrl:string);
    procedure LoadQuickLink(MenuItem:TMenuItem;_ListBox:TListBox);
  end;

//const WeatherFile='weather.asp';

var
  SetForm:TSetForm;
  FirstShow:Boolean=true;
  ms:TMemoryStatus;
  Totalmem:longint;
  bussy:Boolean;
  //Flags:Byte=0;
  FileName:string;
  HistoryFlag:Byte=0;

  QuickLiniStr:Array [0..3] of string;

implementation

uses Public, Unitcpu, KillAd, GetPathUnit, UnitMain,
  UnitWebbrowser, const_, UnitPublic, var_;

{$R *.dfm}

procedure TSetForm.MeasureSubItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
begin
try
  Width := Width + 20;
  Height := Height + 2;
except end;
end;

//绘制子菜单内容
procedure TSetForm.DrawSubItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
const
  SubMenuBackColor      : TColor = $FFFFFF; //$FDFEFF; //$F7F8F9;
  SubMenuBorderColor    : TColor = $EEEEE2;
  SubMenuSelectedBackColor  : TColor = $EED2C1;  //$FFFFFF; //
  SubMenuSelectedBorderColor: TColor = $C08000;
  SubMenuLineColor      : TColor = $C8D0D4;
  //SubMenuHotLightBorderColor: TColor = $C08000;
  SubMenuGrayedBackColor  : TColor = $F7F8F9;//$DEEDEF;
var
  BrushColor, PenColor: TColor;
  TextRect: TRECT;
  str: String;
  //ImageList: TCustomImageList;
begin
try
  if (odGrayed in State) and not(TMenuItem(Sender).IsLine) then
  begin
    BrushColor := SubMenuGrayedBackColor;
    ////if odSelected in State then
      ////PenColor := SubMenuSelectedBorderColor
    ////else////
      PenColor := SubMenuGrayedBackColor;
  end
  else
    if odSelected in State then
    begin
      BrushColor := SubMenuSelectedBackColor;
      PenColor := SubMenuSelectedBorderColor;
    end
    else
    begin
      BrushColor := SubMenuBackColor;
      PenColor := SubMenuBackColor;
    end;
  ACanvas.Brush.Color := BrushColor;
  ACanvas.Pen.Color := PenColor;
  ACAnvas.Rectangle(ARect);
  if not(odSelected in State) or (odGrayed in State) then
  begin
    ACanvas.Brush.Color := SubMenuBorderColor;
    ACanvas.FillRect(Rect(ARect.Left, ARect.Top, ARect.Left+20, ARect.Bottom));
  end;
  //绘文字和快捷键
  if TMenuItem(Sender).IsLine then
  begin
    ACanvas.Brush.Color := SubMenuLineColor;
    ACanvas.Pen.Color := SubMenuLineColor;
    ACanvas.FillRect(Rect(ARect.Left+23, ARect.Top+(ARect.Bottom-ARect.Top) div 2-1,
             ARect.Right-2, ARect.Top+(ARect.Bottom-ARect.Top) div 2));
  end
  else
  begin
    ACanvas.Brush.Style := bsClear;
    if odGrayed in State then
      ACanvas.Font.Color := clBtnShadow
    else
      ACanvas.Font.Color := clBlack;
    str := TMenuItem(Sender).Caption;
    SetRect(TextRect, ARect.Left+24, ARect.Top+3, ARect.Right, ARect.Bottom);
    DrawText(ACanvas.Handle, PChar(str), Length(str), TextRect, DT_LEFT);
    str := ShortCutToText(TMenuItem(Sender).ShortCut);
    SetRect(TextRect, ARect.Left+24, ARect.Top+3, ARect.Right-10, ARect.Bottom);
    DrawText(ACanvas.Handle, PChar(str), Length(str), TextRect, DT_RIGHT);
    //
    if TMenuItem(Sender).Checked then
    begin
      ACanvas.Font.Charset := DEFAULT_CHARSET;
      ACanvas.Font.Name := 'Webdings';
      if TMenuItem(Sender).RadioItem then
        ACanvas.TextOut(ARect.Left+4, ARect.Top, '=')
      else
      begin
        ACanvas.Font.Height := -16;
        ACanvas.TextOut(ARect.Left+2, ARect.Top, 'a');
      end;
    end;
  end;
  {
  //绘制图片
  ImageList := TMenuItem(Sender).GetImageList;
  if ImageList<>nil then
    if (odSelected in State) and not(odGrayed in State) then
      FormPublic.ImageListOther.Draw(ACanvas, ARect.left+2, ARect.Top+2, TMenuItem(Sender).ImageIndex)
    else
      FormPublic.ImageListOther.Draw(ACanvas, ARect.left+3, ARect.Top+3,
               TMenuItem(Sender).ImageIndex, TMenuItem(Sender).Enabled);
  }
except end;
end;

{
procedure TSetForm.GetIniData;
var
  IniFile:TIniFile;
  StatusBarStrDT:string;
begin
try
  try
  IniFile:=TIniFile.Create(MyDir+ConfigFile);
  StatusBarStrDT:=IniFile.ReadString('setting','StatusBarStrDT','A-B-C_D:E:F');
  EStatusBar.Text:=StatusBarStrDT;
  SBStatusBarSet.Enabled:=false;
  finally
  IniFile.Free;
  end;
except end;
end;
}

procedure TSetForm.SetFavoriteDir(Dir:string;ShowMess:Boolean);
begin
try
  if Win32Platform=VER_PLATFORM_WIN32_NT then
  begin
    SetRegValue(HKEY_CURRENT_USER,'\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders',0,'Favorites',PChar(Dir));
    SetRegValue(HKEY_CURRENT_USER,'\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders',0,'Favorites',PChar(Dir));
  end
  else
  SetRegValue(HKEY_USERS,'\.DEFAULT\Software\Microsoft\Windows\CurrentVersion \Explorer\User Shell Folders',0,'Favorites',PChar(Dir));
  //FavoritFolder:=Dir;
  if ShowMess then
  begin
    EFavoriteDir.Text:=Dir;
    ShowMessage('收藏夹目录已经成功更改,所做修改在重新运行本软件后生效！');
    FavoritFolder:=Dir;
    //FormMain.NReloadFavorit.Click;
    //FormMain.ReadTypedURL(1);
    //FormMain.ReadTypedURL(2);
    FormPublic.GetFavoritFolder;
  end;
except end;
end;

procedure TSetForm.AddQuickLinkClick(Sender:TObject);
begin
try
  //SetForm.PageControl1.ActivePageIndex:=3;
  SetForm.PageControl1.ActivePage := TabSheetQuickLink;
  SetForm.BLoadQuickLink.OnClick(Sender);
  SetForm.Show;
except end;
end;

procedure TSetForm.QuickLinkClick(Sender:TObject);
begin
try
  FormMain.CBURL.Text:= TMenuItem(Sender).Hint;
  FormMain.BBGO.OnClick(Sender);
except end;
end;

{
procedure TSetForm.AddQuickLinkItem(STitle,SUrl:string);
var
  Item,MenuItem:TMenuItem; 
begin
try
  MenuItem:=FormMain.NQuickLink;
  Item:=TMenuItem.Create(nil);
  Item.Caption:=STitle;
  Item.Hint:=SUrl;
  Item.Visible:=true;
  Item.OnClick:=QuickLinkClick;
  MenuItem.Add(Item);
  Item.Free;
except end;
end;

procedure TSetForm.DeleteQuickLinkItem(SUrl:string);
var
  MenuItem:TMenuItem;
  i:integer;
begin
try
  MenuItem:=FormMain.NQuickLink;
  if MenuItem.Count>3 then
  for i:=1 to MenuItem.Count-1 do
  begin
    if MenuItem.Items[i].Caption=SUrl then
    MenuItem.Delete(i);
  end;
except end;
end;
}

procedure TSetForm.LoadQuickLink(MenuItem:TMenuItem;_ListBox:TListBox);
var
  i:integer;
  Item:TMenuItem;
begin
try
  //{
  if MenuItem.Count>1 then
  begin
    for i:=1 to MenuItem.Count-1 do
    //MenuItem.Delete(i);
    MenuItem.Items[i].Visible:=false;
  end;
  //}
  //if ListBoxQuickLink.Items.Count > 0 then ListBoxQuickLink.Items.SaveToFile(MyDir+QuickLinkFile);
  ListBoxQuickLink.Items.Clear;
  QuickLiniStr[0] := '';
  QuickLiniStr[1] := '';
  QuickLiniStr[2] := '';
  QuickLiniStr[3] := '';
  if FileExists(MyDir+QuickLinkFile) then
  _ListBox.Items.LoadFromFile(MyDir+QuickLinkFile);
  if _ListBox.Items.Count>0 then
  begin
    //{
    Item:=TMenuItem.Create(nil);
    Item.Caption:='-';
    Item.Hint:='';
    Item.OnAdvancedDrawItem := DrawSubItem;
    Item.OnMeasureItem := MeasureSubItem;
    Item.Visible:=true;
    Item.OnClick:=nil;
    MenuItem.Add(Item);
    //}
  for i:=0 to _ListBox.Items.Count-1 do
  begin
    Item:=TMenuItem.Create(nil);
    Item.Caption:=Copy(_ListBox.Items[i],1,Pos('=',_ListBox.Items[i])-1);
    Item.Hint:=Copy(_ListBox.Items[i],Pos('=',_ListBox.Items[i])+1,Length(_ListBox.Items[i])-Pos('=',_ListBox.Items[i]));
    Item.OnAdvancedDrawItem := DrawSubItem;
    Item.OnMeasureItem := MeasureSubItem;
    Item.Visible:=true;
    case i of
    0:
    begin
      QuickLiniStr[0]:=Item.Hint;
      Item.ShortCut:=ShortCut(VK_F1,[]);
    end;
    1:
    begin
      QuickLiniStr[1]:=Item.Hint;
      Item.ShortCut:=ShortCut(VK_F2,[]);
    end;
    2:
    begin
      QuickLiniStr[2]:=Item.Hint;
      Item.ShortCut:=ShortCut(VK_F3,[]);
    end;
    3:
    begin
      QuickLiniStr[3]:=Item.Hint;
      Item.ShortCut:=ShortCut(VK_F4,[]);
    end;
    end;
    Item.OnClick:= QuickLinkClick;
    MenuItem.Add(Item);
    //Item.Free;
  end;
  end;

    Item:=TMenuItem.Create(nil);
    Item.Caption:='-';
    Item.Hint:='';
    Item.OnAdvancedDrawItem := DrawSubItem;
    Item.OnMeasureItem := MeasureSubItem;
    Item.Visible:=true;
    Item.OnClick:=nil;
    MenuItem.Add(Item);
    
    //Item.Free;

    Item:=TMenuItem.Create(nil);
    case Language of
    0,1: Item.Caption:='设置快捷网址';
    2,3,99: Item.Caption:='Set Quick Url';
    end;
    Item.OnAdvancedDrawItem := DrawSubItem;
    Item.OnMeasureItem := MeasureSubItem;
    Item.Visible:=true;
    Item.OnClick:= AddQuickLinkClick;
    MenuItem.Add(Item);
    //Item.Free;
except end;
end;

procedure idle;
begin
try
  Application.ProcessMessages;
  {$IFDEF WINNT}
  SetForm.Pie.progress:=SetForm.Pie.progress+1;
  {$ENDIF}
except end;
end;

procedure defragmem(limit : integer; x: proc);
var
    tab : array [0..1024] of pointer;
    i : integer;
    p : pointer;
    lim : integer;
begin
try
     if bussy then exit;
     bussy:=true;
     lim:=limit;
     if lim>1024 then lim:=1024;
     for i:=0 to lim do tab [i]:=nil;
       for i:=0 to lim-1 do
       begin
            p:=VirtualAlloc(nil, 1024*1024, MEM_COMMIT,
                            PAGE_READWRITE + PAGE_NOCACHE);
            tab[i]:=p;
            asm
               pushad
               pushfd
               mov   edi, p
               mov   ecx, 1024*1024/4
               xor   eax, eax
               cld
               repz  stosd
               popfd
               popad
            end;
            if assigned(x) then x;
       end;
       for i:=0 to lim-1 do
       begin
            VirtualFree(Tab[i], 0, MEM_RELEASE);
            if assigned(x) then x;
       end;
     bussy:=false;
except end;
end;

procedure TSetForm.SBSystemInfoClick(Sender: TObject);
var
  ms:TMemoryStatus;
  a,b,c,d:string;
begin
try
  try
  MemoSystemInfo.Clear;
  if IsWin32 then d:='WIN32:'+GetOSInfo
  else d:=GetOSInfo;
  GetVersionInfo(a,b,c);
  MemoSystemInfo.Lines.Add('操作系统类型:'+d);
  MemoSystemInfo.Lines.Add('操作系统版本:');
  if Trim(c)='' then MemoSystemInfo.Lines.Add(a)
  else MemoSystemInfo.Lines.Add(a+'-'+c);
  MemoSystemInfo.Lines.Add('');
  MemoSystemInfo.Lines.Add('硬盘序列号:');
  MemoSystemInfo.Lines.Add(GetDiskNumber);
  MemoSystemInfo.Lines.Add('');
  MemoSystemInfo.Lines.Add('CPU ID:'+IntToStr(GetCPUID));
  MemoSystemInfo.Lines.Add('目前CPU运行速度:'+(Format('%5.2f',[GetCPUSpeed]))+'MHz'); //FloatToStr
  //MemoSystemInfo.Lines.Add('');
  MemoSystemInfo.Lines.Add('');
  MemoSystemInfo.Lines.Add('屏幕大小:'+GetScreenWH(''));
  MemoSystemInfo.Lines.Add('显示器刷新频率:'+IntToStr(GetDisplayFrequency)+'Hz');
  MemoSystemInfo.Lines.Add('');
  ms.dwLength:=sizeof(ms);
  GlobalMemoryStatus(ms);
  MemoSystemInfo.Lines.Add('物理内存总量:'+Format('%d'+'MB', [ms.dwTotalPhys div (1024*1024)]));
  //MemoSystemInfo.Lines.Add('可用物理内存:'+Format('%d'+'B',[ms.dwAvailPhys]));
  //MemoSystemInfo.Lines.Add('对换区的总量:'+Format('%d'+'B',[ms.dwTotalPageFile]));
  //MemoSystemInfo.Lines.Add('可用的对的区:'+Format('%d'+'B', [ms.dwAvailPageFile]));
  //MemoSystemInfo.Lines.Add('虚拟内存总量:'+Format('%d'+'B', [ms.dwTotalVirtual]));
  //MemoSystemInfo.Lines.Add('可用虚拟内存:'+Format('%d'+'B',[ms.dwAvailVirtual]));
  MemoSystemInfo.Lines.Add('总内存使用比率:'+Format('%d%%',[ms.dwMemoryLoad]));
  MemoSystemInfo.Lines.Add('');
  CollectCPUData;
  MemoSystemInfo.Lines.Add('总CPU已使用:'+Format('%5.2f%%',[GetCPUUsage(0)*100]));
  MemoSystemInfo.Lines.Add('');
  MemoSystemInfo.Lines.Add('本软件目前使用内存:'+MeUseMem);
  MemoSystemInfo.Lines.Add('');
  //MemoSystemInfo.Lines.Add('...');
  finally
    //DefaultAll;
  end;
except end;
end;

procedure TSetForm.SBProcessPathClick(Sender: TObject);
var
  I:Integer;
  S:string;
  Str:string;
begin
try
  try
  LBProcess.Items.Clear;
  SBProcessList.OnClick(Sender);
  //SBAllProcess.OnClick(Sender);
  if ListBoxProcess.Items.Count=0 then exit;
  ListBoxProcess.ItemIndex:=ListBoxProcess.Items.Count-1;
  for i:=ListBoxProcess.Items.Count-1 downto 0 do
  begin
    ListBoxProcess.ItemIndex:=I;
    ListBoxProcess.Selected[ListBoxProcess.ItemIndex];
    Str:=ListBoxProcess.Items[ListBoxProcess.ItemIndex];
    S:=GetProcessFilePath(PChar(Str));
    if (S<>'') and (DirectoryExists(S)) then
    begin
    //MemoProcess.Lines.Add(Str+'  '+'#'+S+'#');  //+#10+#13
    LBProcess.Items.Add(Str);
    LBProcess.Items.Add('#'+S+'#');
    end;
  end;
  finally
  //Flags:=2;
  ListBoxRegKey.Visible:=false;
  LBProcess.Visible:=true;
  SBProcessPath.Tag:=255;
  SBAllProcess.Tag:=0;
  //LBProcess.Items.SaveToFile(MyDir+ProcessListFile);
  end;
except end;
end;

procedure TSetForm.SBAllProcessClick(Sender: TObject);
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
  //path: string;
begin
try
  try
  ListBoxProcess.Clear;
  LBProcess.Items.Clear;
  FSnapshotHandle:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop:=Process32First(FSnapshotHandle, FProcessEntry32);
  while ContinueLoop do
  begin
    ListBoxProcess.Items.Add(FProcessEntry32.szExeFile);
    LBProcess.Items.Add(FProcessEntry32.szExeFile);
    ContinueLoop:=Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
  finally
    //Flags:=1;
    ListBoxRegKey.Visible:=false;
    LBProcess.Visible:=true;
    SBProcessPath.Tag:=0;
    SBAllProcess.Tag:=255;
  end;
except end;
end;

procedure TSetForm.FormShow(Sender: TObject);
begin
try
  try
  //TabSheetButton.Visible := false;
  if FirstShow then
  begin
    FirstShow:=false;
    FormPublic.UseSetData(Sender);
    //TVolumeInit;  //hhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
    ms.dwLength:=sizeof(ms);
    GlobalMemoryStatus(ms);          
    TotalMem:=(ms.dwTotalPhys shr 20)+1;
    CollectCPUData;
  end;
  finally
  //TabSheet9.TabVisible:=false;
  SBSystemInfo.OnClick(Sender);
  end;
except end;
end;

procedure TSetForm.SBProcessListClick(Sender: TObject);
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
  //path: string;
begin
try
  ListBoxProcess.Clear;
  FSnapshotHandle:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop:=Process32First(FSnapshotHandle, FProcessEntry32);
  while ContinueLoop do
  begin
    ListBoxProcess.Items.Add(FProcessEntry32.szExeFile);
    ContinueLoop:=Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
except end;
end;

procedure TSetForm.FormCreate(Sender: TObject);
begin
try
  try               
  SetForm.Caption:=BrowserName+' '+'选项';

  SetForm.EditDefaultPage.Text:=OpenToUrl;

  if Trim(StatusBarStrDT) <> '' then
  SetForm.EStatusBar.Text := StatusBarStrDT;

  SetForm.SBStatusBarSet.Enabled := false;

  if Trim(WeatherCityName) <> '' then
  SetForm.CBWeather.Text := WeatherCityName;
  //GetIniData;
  finally
  //{
  //if not Debug then
  //if not FileExists(MyDir+'txt.txt') then PageControl1.Pages[5].Destroy;
  PageControl1.ActivePageIndex:=0;
  if FileExists(MyDir+'txt.txt') then
  begin
    BLockAll.Visible := true;
    BDefaultAll.Visible := true;
  end;
  //}
  {
  if FormPublic.NUseIEProxy.Checked then
  CBUseProxy.Checked:=true
  else
  if FormPublic.NNoUseProxy.Checked then
  CBNoUseProxy.Checked:=true;
  }
  //BProxySetOK.Enabled:=false;
  //FormMain.ShowRun(Sender);
  //PageControl1.Pages[2].Visible := false;
  end;
except end;
end;

procedure TSetForm.SBMemoryOptimizeClick(Sender: TObject);
begin
try
  try
  SBSystemInfo.Enabled:=false;
  SBMemoryOptimize.Enabled:=false;
  MemoSystemInfo.Visible:=false;
  {$IFDEF WINNT}
  pie.Progress:=0;
  pie.Visible:=true;
  pie.MaxValue:=Totalmem*2;
  {$ENDIF}
  Defragmem(Totalmem,idle);
  //MessageBox(Application.Handle,'内存优化整理完毕!','系统提示',MB_OK);
  finally
    {$IFDEF WINNT}
    pie.Visible:=false;
    {$ENDIF}
    MemoSystemInfo.Visible:=true;
    SBSystemInfo.Enabled:=true;
    SBMemoryOptimize.Enabled:=true;
  end;
except
  {$IFDEF WINNT}
  pie.Visible:=false;
  {$ENDIF}
  SBSystemInfo.OnClick(Sender);
  MemoSystemInfo.Visible:=true;
  SBSystemInfo.Enabled:=true;
  SBMemoryOptimize.Enabled:=true;
end;
end;

procedure TSetForm.EStatusBarChange(Sender: TObject);
begin
try
  if SBStatusBarSet.Enabled=false then
  SBStatusBarSet.Enabled:=true;
  TimerStatusBar.Enabled:=true;
except end;
end;

procedure TSetForm.TimerStatusBarTimer(Sender: TObject);
var
  S:string;
  i:integer;
  NewS:string;
begin
try
  NewS:='';
  //S:=Trim(EStatusBar.Text);
  S:=EStatusBar.Text;
  if Trim(S)='' then
  begin
    TimerStatusBar.Enabled:=false;
    FormMain.Panel_StatusBar3.Caption := '';
    exit;
  end;
  for i:=1 to Length(S) do
  begin
    ms.dwLength:=sizeof(ms);
    GlobalMemoryStatus(ms);
    case S[i] of
    'A':NewS:=NewS+GetDateTime2(1);
    'B':NewS:=NewS+GetDateTime2(2);
    'C':NewS:=NewS+GetDateTime2(3);
    'D':NewS:=NewS+GetDateTime2(4);
    'E':NewS:=NewS+GetDateTime2(5);
    'F':NewS:=NewS+GetDateTime2(6);
    'G':NewS:=NewS+FormatDateTime({'yyyy-mm-dd'}'dddd',now);
    'H':NewS:=NewS+' '; //NewS:=NewS+Format('%d'+'MB',[ms.dwAvailPhys/1000.00]);  
    'I':NewS:=NewS+Format('%d%%',[ms.dwMemoryLoad]);
    'J':
      begin
        CollectCPUData;
        NewS:=NewS+Format('%5.2f%%',[GetCPUUsage (0)*100]);
      end;
    'K':NewS:=NewS+Format('%d',[ms.dwAvailPhys div (1024*1024)]);
    'L':NewS:=NewS+GetIPAddress;  //Format('%d',[ms.dwAvailVirtual div (1024*1024)]);
    'W':NewS:=NewS+' ';
    ':':NewS:=NewS+':';
    '-':NewS:=NewS+'-';
    '_':NewS:=NewS+'_';
    ' ':NewS:=NewS+' ';
    else NewS:=NewS+S[i];
    end;
  end;
  FormMain.Panel_StatusBar3.Caption := NewS;
except end;
end;

procedure TSetForm.SBStatusBarSetClick(Sender: TObject);
begin
try
  WritePrivateProfileString('setting','StatusBarStrDT',PChar(EStatusBar.Text),PChar(MyDir+ConfigFile));
  if Trim(EStatusBar.Text) <> '' then
  if not TimerStatusBar.Enabled then TimerStatusBar.Enabled := true; 
  SBStatusBarSet.Enabled:=false;
except end;
end;

procedure TSetForm.CBLoadBrowserHisClick(Sender: TObject);
begin
try
  //CBBrowserHis.Checked:=not CBBrowserHis.Checked;
  SBOKCG.Enabled:=true;
except end;
end;

procedure TSetForm.SBOKCGClick(Sender: TObject);
begin
try
  try
  if CBLoadBrowserHis.Checked then
  WritePrivateProfileString('setting','LoadUrlHistory','1',PChar(MyDir+ConfigFile))
  else
  WritePrivateProfileString('setting','LoadUrlHistory','0',PChar(MyDir+ConfigFile));
  if CBLoadFavorite.Checked then
  WritePrivateProfileString('setting','FavoritMenu','1',PChar(MyDir+ConfigFile))
  else
  WritePrivateProfileString('setting','FavoritMenu','0',PChar(MyDir+ConfigFile));
  if CBLoadLastTime.Checked then
  WritePrivateProfileString('setting','LoadLastTime','1',PChar(MyDir+ConfigFile))
  else
  begin
  WritePrivateProfileString('setting','LoadLastTime','0',PChar(MyDir+ConfigFile));
  WritePrivateProfileString('setting','NextTimeNoAsk','0',PChar(MyDir+ConfigFile));
  end;
  if CBCreateOneLabel.Checked then
  WritePrivateProfileString('setting','CreateOneTab','1',PChar(MyDir+ConfigFile))
  else
  WritePrivateProfileString('setting','CreateOneTab','0',PChar(MyDir+ConfigFile));

  if RBOpenNull.Checked then
  WritePrivateProfileString('setting','StartPageTo','0',PChar(MyDir+ConfigFile))
  else if RBOpenDefault.Checked then
  WritePrivateProfileString('setting','StartPageTo','1',PChar(MyDir+ConfigFile))
  else if RBOpenHome.Checked then
  WritePrivateProfileString('setting','StartPageTo','2',PChar(MyDir+ConfigFile));

  if CBExitCleanAllHistory.Checked then
  WritePrivateProfileString('setting','ExitCleanAllHistory','1',PChar(MyDir+ConfigFile))
  else
  WritePrivateProfileString('setting','ExitCleanAllHistory','0',PChar(MyDir+ConfigFile));

  if CBCleanAddress.Checked then
  WritePrivateProfileString('setting','CleanAddress','1',PChar(MyDir+ConfigFile))
  else
  WritePrivateProfileString('setting','CleanAddress','0',PChar(MyDir+ConfigFile));
  if CBCleanHistory.Checked then
  WritePrivateProfileString('setting','CleanHistory','1',PChar(MyDir+ConfigFile))
  else
  WritePrivateProfileString('setting','CleanHistory','0',PChar(MyDir+ConfigFile));
  if CBCleanCache.Checked then     
  WritePrivateProfileString('setting','CleanCache','1',PChar(MyDir+ConfigFile))
  else
  WritePrivateProfileString('setting','CleanCache','0',PChar(MyDir+ConfigFile));
  if CBCleanCookies.Checked then
  WritePrivateProfileString('setting','CleanCookies','1',PChar(MyDir+ConfigFile))
  else
  WritePrivateProfileString('setting','CleanCookies','0',PChar(MyDir+ConfigFile));
  if CBCleanRecent.Checked then
  WritePrivateProfileString('setting','CleanRecent','1',PChar(MyDir+ConfigFile))
  else
  WritePrivateProfileString('setting','CleanRecent','0',PChar(MyDir+ConfigFile));
  finally
  SBOKCG.Enabled:=false;
  OpenToUrl := EditDefaultPage.Text;
  WritePrivateProfileString('setting','OpenToUrl',PChar(OpenToUrl),PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TSetForm.CBLoadFavoriteClick(Sender: TObject);
begin
try
  //CBLoadFavorite.Checked:=not CBLoadFavorite.Checked;
  SBOKCG.Enabled:=true;
except end;
end;

procedure TSetForm.CBCleanAddressClick(Sender: TObject);
begin
try
  //CBCleanAddress.Checked:=not CBCleanAddress.Checked;
  CleanAddress := CBCleanAddress.Checked;
  SBOKCG.Enabled:=true;
except end;
end;

procedure TSetForm.CBCleanHistoryClick(Sender: TObject);
begin
try
  //CBCleanHistory.Checked:=not CBCleanHistory.Checked;
  CleanHistory := CBCleanHistory.Checked;
  SBOKCG.Enabled:=true;
except end;
end;

procedure TSetForm.CBCleanCacheClick(Sender: TObject);
begin
try
  //CBCleanCache.Checked:=not CBCleanCache.Checked;
  CleanCache := CBCleanCache.Checked;
  SBOKCG.Enabled:=true;
except end;
end;

procedure TSetForm.CBCleanCookiesClick(Sender: TObject);
begin
try
  //CBCleanCookies.Checked:=not CBCleanCookies.Checked;
  CleanCookies := CBCleanCookies.Checked;
  SBOKCG.Enabled:=true;
except end;
end;

procedure TSetForm.RBOpenDefaultClick(Sender: TObject);
begin
try
  //CBOpenHomePage.Checked:=not CBOpenHomePage.Checked;
  SBOKCG.Enabled:=true;
except end;
end;

procedure TSetForm.RBOpenHomeClick(Sender: TObject);
begin
try
  //CBOpenTOBHome.Checked:=not CBOpenTOBHome.Checked;
  SBOKCG.Enabled:=true;
except end;
end;

procedure TSetForm.RBOpenNullClick(Sender: TObject);
begin
try
  //CBOpenHomePage.Checked:=not CBOpenHomePage.Checked;
  SBOKCG.Enabled:=true;
except end;
end;

procedure TSetForm.BUnlockRegClick(Sender: TObject);
begin
try
  LockReg(false);
except end;
end;

procedure TSetForm.BDefaultAllClick(Sender: TObject);
begin
try
  DefaultAll;
except end;
end;

procedure TSetForm.BDefaultTXTTypeClick(Sender: TObject);
begin
try
  LinkTxtType('',false);
except end;
end;

procedure TSetForm.Button4Click(Sender: TObject);
begin
try
  DefaultIE;
except end;
end;

//{
procedure TSetForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
try
  try
  Hide;   
  //PageControl1.ActivePageIndex:=0;
  ListBoxHistory.Items.Clear;
  ListBoxRegKey.Items.Clear;
  LBProcess.Items.Clear;
  //ListBoxProcess.Items.Clear;
  {
  if (SetForm.SBStop_Play.Enabled) and (SetForm.SBStop_Play.Caption='停止播放') then SetForm.SBStop_Play.Click;
  if (MediaPlayer.Mode=mpPlaying) or (MediaPlayer.Mode=mpPaused) then
  begin
    MediaPlayer.Stop;
    //MediaPlayer.Close;
  end;
  MediaPlayer.Close;
  }
  finally
    PageControl1.ActivePageIndex:=0;
    FormPublic.DocumentSetFocus;
    //FormMain.InterfaceRepaint;
  end;
except end;
end;
//}

//{
procedure TSetForm.TimerPlayerTimer(Sender: TObject);
begin

end;
//}

procedure TSetForm.CBLoopPlayClick(Sender: TObject);
begin
try
  //CBLoopPlay.Checked:=not CBLoopPlay.Checked;
  //if CBLoopPlay.Checked then TimerPlayer.Enabled:=true;
except end;
end;

procedure TSetForm.SBWeatherOKClick(Sender: TObject);
var
  cityName:string;
begin
try
  case WeatherSource of
  1:
  begin
    //http://weather.cncn.com/weather.htm
    MoreUrlOpen := false;
    FormMain.CBURL.Text := 'http://weather.cncn.com/weather.htm';
    FormMain.BBGO.OnClick(Sender);
    Self.Hide;
  end;
  2:
  begin
  cityName:=Trim(CBWeather.Text);
  try
  if cityName='' then exit;

  //if not FileExists(MyDir+WeatherFile) then
  //ListBoxWeather.Items.SaveToFile(MyDir+WeatherFile);
  MoreUrlOpen := false;
  Self.Hide;
  {
  //if RBWeatherPageSource1.Checked then
  if RBWeatherPageSource2.Checked then
  begin
    //MainForm.CBURL.Text:=TOBHomePage+WeatherFile+'?cityNumber='+IntToStr(cityNumber)+'&cityName='+cityName;
  end;
  }
  FormMain.CBURL.Text:='http://weather.tq121.com.cn/detail.php?city='+cityName;
  FormMain.BBGO.OnClick(Sender);
  //'http://www.t7online.com/cgi-bin/citydruck?WMO=54511&LANG=cn&TIME=1082108632';
  finally
    WritePrivateProfileString('setting','WeatherCityName',PChar(cityName),PChar(MyDir+ConfigFile));
  end;
  end;
  end;
except end;
end;

procedure TSetForm.RBWeatherPageSource1Click(Sender: TObject);
begin
try
  WeatherSource := 1;
  WritePrivateProfileString('setting','WeatherPageSource','1',PChar(MyDir+ConfigFile));
except end;
end;

procedure TSetForm.RBWeatherPageSource2Click(Sender: TObject);
begin
try
  WeatherSource := 2;
  WritePrivateProfileString('setting','WeatherPageSource','2',PChar(MyDir+ConfigFile));
except end;
end;

procedure TSetForm.BLockAllClick(Sender: TObject);
begin
try
  LockAll;
except end;
end;

procedure TSetForm.RBTabAt0Click(Sender: TObject);
begin
try
  try
  if ShowOptionOK then
  begin
  WritePrivateProfileString('setting','TabAt','0',PChar(MyDir+ConfigFile));
  end;
  finally
    {
    if ShowCloseHint and ShowOptionOK then
    ShowMessage('本设置在下次启动浏览器时生效!')
    else
    }
    {
    if ShowCloseHint then
    begin
      FormMain.ToolBarTabClose.Hide;
      FormMain.ToolBarTabClose.Show;
    end;
    }
    begin
      //FormMain.PaintPanelMTop.Parent := FormMain.CoolBar1;
      TabAt := 0;
      ShowCloseOK := false;
      FormMain.PaintPanelMTop.Align := alTop;
      FormMain.ToolBarTabParent.Repaint;
    end;
  end;
except end;           
end;

procedure TSetForm.RBTabAt1Click(Sender: TObject);
begin
try
  try
  if ShowOptionOK then
  begin
  WritePrivateProfileString('setting','TabAt','1',PChar(MyDir+ConfigFile));
  end;
  finally
    {
    if ShowCloseHint and ShowOptionOK then
    ShowMessage('本设置在下次启动浏览器时生效!')
    else
    }
    {
    if ShowCloseHint then
    begin
      FormMain.ToolBarTabClose.Hide;
      FormMain.ToolBarTabClose.Show;
    end;
    }
    begin
      //FormMain.PaintPanelMTop.Parent := FormMain;
      TabAt := 1;
      ShowCloseOK := false;
      FormMain.PaintPanelMTop.Align := alBottom;
      FormMain.ToolBarTabParent.Repaint;
    end;
  end;
except end;
end;

procedure TSetForm.RBAtCurentPageClick(Sender: TObject);
var
  Res: TReSourceStream;
begin
try
  if ShowOptionOK then
  begin
  GoToNewPage := false;
  try
  Res:=TResourceStream.Create(Hinstance,'lastunclose2_htm',PChar('htm'));
  Res.SaveToFile(MyDir + DataDir + '\' + LastOpenLoadFile);
  Res.Free;
  finally
  WritePrivateProfileString('setting','GoToNewPage','0',PChar(MyDir+ConfigFile));
  end;
  end;
except end;
end;

procedure TSetForm.RBGoToNewPageClick(Sender: TObject);
var
  Res:TReSourceStream;
begin
try
  if ShowOptionOK then
  begin
  GoToNewPage := true;
  try
  Res:=TResourceStream.Create(Hinstance,'lastunclose_htm',PChar('htm'));
  Res.SaveToFile(MyDir + DataDir + '\' + LastOpenLoadFile);
  Res.Free;
  finally
  WritePrivateProfileString('setting','GoToNewPage','1',PChar(MyDir+ConfigFile));
  end;
  end;
except end;
end;

procedure TSetForm.RBInstallTrayIconONClick(Sender: TObject);
begin
try
  if ShowOptionOK then
  begin                      
  WritePrivateProfileString('setting','InstallTrayIcon','1',PChar(MyDir+ConfigFile));
  end;
  if InstallTrayIcon then exit;
  InstallTrayIcon := true;
  InstallIcon(true,FormMain.Handle,FormMain.Icon.Handle,TitleStr);
except end;
end;
                       
procedure TSetForm.RBInstallTrayIconNOONClick(Sender: TObject);
begin
try
  if ShowOptionOK then
  begin
  WritePrivateProfileString('setting','InstallTrayIcon','0',PChar(MyDir+ConfigFile));
  end;
  if not InstallTrayIcon then exit;
  InstallTrayIcon := false;
  InstallIcon(false,FormMain.Handle,FormMain.Icon.Handle,TitleStr);
except end;
end;

procedure TSetForm.CBCleanRecentClick(Sender: TObject);
begin
try
  CleanRecent := CBCleanRecent.Checked;
  SBOKCG.Enabled:=true;
except end;
end;

procedure TSetForm.SBGetAutoRunKeyClick(Sender: TObject);
var
  Reg:TRegistry;
  StrList:TStringList;
  //StrList:TStrings;
  //Strs:TStrings;
  I:Integer;
  str:string;
begin
try
    StrList:=TStringList.Create(); //如果我用 Tstrings.Ctreate;就报错。
    try
    ListBoxRegKey.Items.Clear;
    //10
    Reg:=TRegistry.Create;
    Reg.RootKey:=HKEY_CURRENT_USER;
    if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run',False) then
    begin 
      Reg.GetValueNames(StrList);
      //ListBoxRegKey.Items.Clear;
      for i:=0 to StrList.Count-1 do
      begin
        str:=ReadRegValue(Reg.RootKey,'Software\Microsoft\Windows\CurrentVersion\Run',0,PChar(StrList[i]));
        //CLBox1.Items.Add('*'+StrList[i]+'#'+str);
        ListBoxRegKey.Items.Add('10:'+StrList[i]);
        ListBoxRegKey.Items.Add('#'+str);
      end;
    end;
    //10_end
    //Strs:=TStrings.Create;
    //00
    Reg:=TRegistry.Create;
    Reg.RootKey:=HKEY_LOCAL_MACHINE;
    //Reg.RootKey:=HKEY_CURRENT_USER;     //Reg.GetValueNames();
    if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run',False) then
    begin    //Reg.GetValueNames();
      //Reg.GetKeyNames(CLBox1.Items);
      //Reg.GetValueNames(CLBox1.Items);
      Reg.GetValueNames(StrList);
      for i:=0 to StrList.Count-1 do
      begin
        str:=ReadRegValue(Reg.RootKey,'Software\Microsoft\Windows\CurrentVersion\Run',0,PChar(StrList[i]));
        //CLBox1.Items.Add('*'+StrList[i]+'#'+str);
        ListBoxRegKey.Items.Add('00:'+StrList[i]);
        ListBoxRegKey.Items.Add('#'+str);
      end;
      //List.SaveToFile(ExtractFilePath(ParamStr(0))+'';);
      //ShowMessage(IntToStr(StrList.Count));
      //StrList.SaveToFile(TempDir+'Temp.txt');
      //CLBox1.Items.LoadFromFile(TempDir+'Temp.txt');
      //Reg.
    end;
    //00_end;
    //01
    Reg:=TRegistry.Create;
    Reg.RootKey:=HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\RunOnce',False) then
    begin 
      Reg.GetValueNames(StrList);
      //ListBoxRegKey.Items.Clear;
      for i:=0 to StrList.Count-1 do
      begin
        str:=ReadRegValue(Reg.RootKey,'Software\Microsoft\Windows\CurrentVersion\RunOnce',0,PChar(StrList[i]));
        //CLBox1.Items.Add('*'+StrList[i]+'#'+str);
        ListBoxRegKey.Items.Add('01:'+StrList[i]);
        ListBoxRegKey.Items.Add('#'+str);
      end;
    end;
    //01_end
    //02
    Reg:=TRegistry.Create;
    Reg.RootKey:=HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\RunOnceEx',False) then
    begin
      Reg.GetValueNames(StrList);
      //ListBoxRegKey.Items.Clear;
      for i:=0 to StrList.Count-1 do
      begin
        str:=ReadRegValue(Reg.RootKey,'Software\Microsoft\Windows\CurrentVersion\RunOnceEx',0,PChar(StrList[i]));
        //CLBox1.Items.Add('*'+StrList[i]+'#'+str);
        ListBoxRegKey.Items.Add('02:'+StrList[i]);
        ListBoxRegKey.Items.Add('#'+str);
      end;
    end;
    //02_end
    //03
    Reg:=TRegistry.Create;
    Reg.RootKey:=HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\RunServices',False) then
    begin
      Reg.GetValueNames(StrList);
      //ListBoxRegKey.Items.Clear;
      for i:=0 to StrList.Count-1 do
      begin
        str:=ReadRegValue(Reg.RootKey,'Software\Microsoft\Windows\CurrentVersion\RunServices',0,PChar(StrList[i]));
        //CLBox1.Items.Add('*'+StrList[i]+'#'+str);
        ListBoxRegKey.Items.Add('03:'+StrList[i]);
        ListBoxRegKey.Items.Add('#'+str);
      end;
    end;
    //03_end
    {
    //11
    Reg:=TRegistry.Create;
    Reg.RootKey:=HKEY_CURRENT_USER;
    if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\RunOnceEx',False) then
    begin 
      Reg.GetValueNames(StrList);
      //ListBoxRegKey.Items.Clear;
      for i:=0 to StrList.Count-1 do
      begin
        str:=ReadRegValue(Reg.RootKey,'Software\Microsoft\Windows\CurrentVersion\RunOnceEx',0,PChar(StrList[i]));
        //CLBox1.Items.Add('*'+StrList[i]+'#'+str);
        ListBoxRegKey.Items.Add('11:'+StrList[i]);
        ListBoxRegKey.Items.Add('#'+str);
      end;
    end;
    //11_end
    }
    //取HKEY_CURRENT_USER 第2个键名 GetRegKeyNameByIndex(1)
  finally
    LBProcess.Visible:=false;
    ListBoxRegKey.Visible:=true;
    StrList.Free;
    Reg.CloseKey;
    Reg.Free;
    //Val.Free;
  end;
except
  //ListBoxRegKey.Items.Clear;
end;
end;

procedure TSetForm.CLBox1_DblClick(Sender: TObject);
begin
  {
    if Reg.ValueExists(Value) then
  begin
    Reg.DeleteValue(Value);
    }
end;

procedure TSetForm.LBProcessDblClick(Sender: TObject);
begin
try
  //ShowMessage(LBProcess.Items[LBProcess.ItemIndex]);
  KillProcess(PChar(LBProcess.Items[LBProcess.ItemIndex]));
  KillProcess(PChar(ExtractFileName(LBProcess.Items[LBProcess.ItemIndex])));
  {
  if Flags=1 then SBAllProcess.OnClick(Sender);
  if Flags=2 then SBProcessPath.OnClick(Sender);
  }
  if SBProcessPath.Tag=255 then SBProcessPath.OnClick(Sender)
  else if SBAllProcess.Tag=255 then SBAllProcess.OnClick(Sender);
except end;
end;

procedure TSetForm.ListBoxRegKeyDblClick(Sender: TObject);
var
  str:string;
  sValue:string;
  Reg:TRegistry;
begin
try
  try
  if ListBoxRegKey.ItemIndex<0 then exit;
  //if MessageDlg('确实要删除注册表中的此自动运行键值吗？',mtconfirmation,[mbyes,mbno],0)=mrNo then exit;
  //ShowMessage(LBProcess.Items[LBProcess.ItemIndex]);
  str:=(ListBoxRegKey.Items[ListBoxRegKey.ItemIndex]);
  if Trim(str)='' then exit;
  sValue:=Copy(str,4,Length(str)-3);
  //ShowMessage(sValue); 
  if Pos('#',str)=1 then
  begin //exit;
    if ListBoxRegKey.ItemIndex<=0 then exit;
    str:=(ListBoxRegKey.Items[ListBoxRegKey.ItemIndex-1]);
    if Trim(str)='' then exit;
    sValue:=Copy(str,4,Length(str)-3);
    if Pos('#',str)=1 then exit;
  end;
  if MessageDlg('确实要删除注册表中的此自动运行键值吗？',mtconfirmation,[mbyes,mbno],0)=mrNo then exit;
  {
  case Copy(str,1,2) of //DeleteRegValue(RootKey:HKEY;OpenKey:PChar;Value:PChar):Boolean;
  10:DeleteRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Run',str);
  00:DeleteRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Windows\CurrentVersion\Run',str);
  01:DeleteRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Windows\CurrentVersion\RunOnce',str);
  02:DeleteRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Windows\CurrentVersion\RunOnceEx',str);
  end;
  }
  str:=Copy(str,1,2);   //ShowMessage(str);
  if str='10' then
  DeleteRegValue(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Run',PChar(sValue));
  if str='00' then
  begin  //ShowMessage(sValue);
  DeleteRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Windows\CurrentVersion\Run',PChar(sValue));
  //DeleteRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Windows\CurrentVersion\Run',PChar(Copy(str,4,Length(str)-3)));
    Reg:=TRegistry.Create;
    Reg.RootKey:=HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run',False) then
    begin
      //if Reg.ValueExists(sValue) then
      Reg.DeleteValue(sValue);
    end;
  end;
  if str='01' then
  DeleteRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Windows\CurrentVersion\RunOnce',PChar(sValue));
  if str='02' then
  DeleteRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Windows\CurrentVersion\RunOnceEx',PChar(sValue));
  if str='03' then
  DeleteRegValue(HKEY_LOCAL_MACHINE,'Software\Microsoft\Windows\CurrentVersion\RunServices',PChar(sValue));

  finally
    SBGetAutoRunKey.OnClick(Sender);
  end;
except end;
end;

procedure TSetForm.CBLoadLastTimeClick(Sender: TObject);
begin
try
  //CBLoadLastTime.Checked:=not CBLoadLastTime.Checked;
  SBOKCG.Enabled:=true;
except end;
end;

procedure TSetForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
try
  try
  //PageControl1.ActivePageIndex:=0;
  ListBoxHistory.Items.Clear;
  ListBoxQuickLink.Items.Clear;
  ListBoxRegKey.Items.Clear;
  LBProcess.Items.Clear;
  EQLTitle.Text:='';
  EQLUrl.Text:='';
  //ListBoxProcess.Items.Clear;

    {
    if FormMain.PanelAddress.Parent=FormMain.ToolBarAddress then
    begin
      FormMain.PanelMusicPlay.Parent:=FormMain.PanelToolExtended;
      SetForm.Hide;
    end           
    else SetForm.WindowState:=wsMinimized;
    }
    {
    else
    begin
      if FormMain.PanelAddress.Parent=FormMain.ToolBar then
      FormMain.PanelMusicPlay.Parent:=FormMain.ToolBarMenu
      else if FormMain.PanelAddress.Parent=FormMain.ToolBarMenu then
      FormMain.PanelMusicPlay.Parent:=FormMain.ToolBar;
    end;
    }
    {
    if FormMain.MediaPlayer.Mode=mpPaused then
    FormMain.SBPause_Play.Glyph:=FormMain.SBPlay.Glyph
    else
    FormMain.SBPause_Play.Glyph:=FormMain.SBPause.Glyph;
    }
  finally
    //PageControl1.ActivePageIndex:=0;
  end;
except end;
end;

procedure TSetForm.RBAppenPageYesClick(Sender: TObject);
begin
try
  if ShowOptionOK then
  begin
  WritePrivateProfileString('setting','AppendTab','1',PChar(MyDir+ConfigFile));
  end;
  AppendTab:=true;
except end;
end;

procedure TSetForm.NoClick(Sender: TObject);
begin
try
  if ShowOptionOK then
  begin
  WritePrivateProfileString('setting','AppendTab','0',PChar(MyDir+ConfigFile));
  end;
  AppendTab:=false;
except end;
end;

procedure TSetForm.CBCreateOneLabelClick(Sender: TObject);
begin
try
  SBOKCG.Enabled:=true;
except end;
end;

procedure TSetForm.Button1Click(Sender: TObject);
begin
try
  //GetPathForm.Show;
  GetPathForm:=TGetPathForm.Create(Self);
  GetPathForm.Caption:='请选择收藏夹目录:';
  if DirectoryExists(FavoritFolder) then
  GetPathForm.DirectoryListBox1.Directory:=FavoritFolder;
  GetPathForm.ShowModal;
except end;
end;

procedure TSetForm.RBHoldOneYesClick(Sender: TObject);
begin
try
  if ShowOptionOK then
  begin
  WritePrivateProfileString('setting','HoldOneTab','1',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TSetForm.RBHoldOneNoClick(Sender: TObject);
begin
try
  if ShowOptionOK then
  begin
  WritePrivateProfileString('setting','HoldOneTab','0',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TSetForm.ButtonImportClick(Sender: TObject);
begin
try
  SetForm.Hide;
  FormPublic.NImport.OnClick(Sender);
  SetForm.Show;
  FormPublic.DocumentSetFocus;
except end;
end;

procedure TSetForm.SBCleanAddressClick(Sender: TObject);
begin
try
  if FileExists(MyDir+URLFile) then
  ListBoxHistory.items.LoadFromFile(MyDir+URLFile);
  HistoryFlag:=1;
  SBHistorySave.Enabled:=false;
except end;
end;

procedure TSetForm.SBDeleteClick(Sender: TObject);
var
  i:integer;
begin
try
  //ListBoxMusicList.Items.Delete(ListBoxMusicList.ItemIndex);
  if ListBoxHistory.SelCount<=0 then exit;
  for i:=1 to ListBoxHistory.SelCount do
  begin
    //if ListBoxHistory.Items[ListBoxHistory.ItemIndex]<>''then
    ListBoxHistory.Items.Delete(ListBoxHistory.ItemIndex);
  end;
  SBHistorySave.Enabled:=true;
except end;
end;

procedure TSetForm.SBCleanHistoryListClick(Sender: TObject);
begin
try
  if ListBoxHistory.Items.Count<=0 then exit;

  ListBoxHistory.Items.Clear;
  SBHistorySave.Enabled:=true;
  //if HistoryFlag=2 then FormMain.EditSearch.Text:='';
except end;
end;

procedure TSetForm.SBHistorySaveClick(Sender: TObject);
begin
try
  case HistoryFlag of
  1:
  begin
    ListBoxHistory.items.SaveToFile(MyDir+URLFile);
    FormMain.CBURL.items.Clear;
    FormMain.CBURL.items.LoadFromFile(MyDir+URLFile);
  end;
  2:
  begin
    //ListBoxHistory.items.SaveToFile(MyDir+SearchHistoryFile);
    //FormMain.EditSearch.Text := '';
  end;
  3:
  begin
    //ListBoxHistory.items.SaveToFile(MyDir+NewlyBrowserFile);
    //FormPublic.LoadNewly;
  end;
  end;
  //ShowMessage('记录已经成功保存!');
  ListBoxHistory.Items.Clear;
  SBHistorySave.Enabled:=false;
except end;
end;

procedure TSetForm.SBLoadNewlyClick(Sender: TObject);
begin
try
  {
  if FileExists(MyDir+NewlyBrowserFile) then
  ListBoxHistory.items.LoadFromFile(MyDir+NewlyBrowserFile);
  }
  FormPublic.CleanNewly;
  HistoryFlag:=3;
  SBHistorySave.Enabled:=false;
except end;
end;

procedure TSetForm.SpeedButton7Click(Sender: TObject);
var
  NewIndex:Integer;
begin
try
  if FormMain.ListBoxMusicList.SelCount<=0 then exit;
  if FormMain.ListBoxMusicList.ItemIndex>0 then
  begin
    NewIndex := FormMain.ListBoxMusicList.ItemIndex-1;
    FormMain.ListBoxMusicList.Items.Insert(NewIndex,FormMain.ListBoxMusicList.Items.Strings[FormMain.ListBoxMusicList.itemIndex]);
    FormMain.ListBoxMusicList.DeleteSelected;
    FormMain.ListBoxMusicList.Selected[NewIndex]:=true;
    //ListBoxMusicList.ItemIndex:=NewIndex+1;
  end;
except end;
end;

procedure TSetForm.SpeedButton5Click(Sender: TObject);
var
  NewIndex:Integer;
begin
try
  if FormMain.ListBoxMusicList.SelCount<=0 then exit;
  if (FormMain.ListBoxMusicList.ItemIndex>-1) and (FormMain.ListBoxMusicList.ItemIndex<FormMain.ListBoxMusicList.Items.Count-1) then
  begin
    NewIndex := FormMain.ListBoxMusicList.ItemIndex+2;
    FormMain.ListBoxMusicList.Items.Insert(NewIndex,FormMain.ListBoxMusicList.Items.Strings[FormMain.ListBoxMusicList.itemIndex]);
    FormMain.ListBoxMusicList.DeleteSelected;
    FormMain.ListBoxMusicList.Selected[NewIndex-1]:=true;
  end;
except end;
end;

procedure TSetForm.CBUseSSClick(Sender: TObject);
begin
try
  //CBUseSS.Checked:=not CBUseSS.Checked;
  if CBUseSS.Checked then
  begin
    UseMouseSS:=true;
    WritePrivateProfileString('setting','UseMouseSS','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    UseMouseSS:=false;
    WritePrivateProfileString('setting','UseMouseSS','0',PChar(MyDir+ConfigFile));
  end;
  ButtonSSOK.Enabled:=true;
  //ButtonSSOK.SetFocus;
except end;
end;

procedure TSetForm.CBSSTopChange(Sender: TObject);
begin
try
  SSTop:=CBSSTop.ItemIndex;
  WritePrivateProfileString('setting','SSTop',PChar(IntToStr(CBSSTop.ItemIndex)),PChar(MyDir+ConfigFile));
  ButtonSSOK.Enabled:=true;
  //ButtonSSOK.SetFocus;
except end;
end;

procedure TSetForm.CBSSButtomChange(Sender: TObject);
begin
try
  SSButtom:=CBSSButtom.ItemIndex;
  WritePrivateProfileString('setting','SSButtom',PChar(IntToStr(CBSSButtom.ItemIndex)),PChar(MyDir+ConfigFile));
  ButtonSSOK.Enabled:=true;
  //ButtonSSOK.SetFocus;
except end;
end;

procedure TSetForm.CBSSLeftChange(Sender: TObject);
begin
try
  SSLeft:=CBSSLeft.ItemIndex;
  WritePrivateProfileString('setting','SSLeft',PChar(IntToStr(CBSSLeft.ItemIndex)),PChar(MyDir+ConfigFile));
  ButtonSSOK.Enabled:=true;
  //ButtonSSOK.SetFocus;
except end;
end;

procedure TSetForm.CBSSRightChange(Sender: TObject);
begin
try
  SSRight:=CBSSRight.ItemIndex;
  WritePrivateProfileString('setting','SSRight',PChar(IntToStr(CBSSRight.ItemIndex)),PChar(MyDir+ConfigFile));
  ButtonSSOK.Enabled:=true;
  //ButtonSSOK.SetFocus;
except end;
end;

procedure TSetForm.ButtonSSOKClick(Sender: TObject);
begin
try
  ButtonSSOK.Enabled:=false;
except end;
end;

procedure TSetForm.BAddQuickLinkClick(Sender: TObject);
var
  STitle,SUrl:string;
begin
try
  STitle:=Trim(EQLTitle.Text);
  SUrl:=Trim(EQLUrl.Text);
  if (STitle='') or (SUrl='') then
  begin
    ShowMessage('网站名和网址都不能为空，请正确填写！');
    if Trim(EQLUrl.Text)='' then EQLUrl.SetFocus;
    if Trim(EQLTitle.Text)='' then EQLTitle.SetFocus;
    exit;
  end;
  ListBoxQuickLink.Items.Add(STitle+'='+SUrl);
  ListBoxQuickLink.Items.SaveToFile(MyDir+QuickLinkFile);
  EQLTitle.Text:='';
  EQLUrl.Text:='';
  EQLTitle.SetFocus;
  //*
  //AddQuickLinkItem(STitle,SUrl);
  //*
  BQuickLinkOK.Enabled:=true;
except end;
end;

procedure TSetForm.BQuickLinkOKClick(Sender: TObject);
{
var
  STitle,SUrl:string;
}
begin
try
  {
  try
  STitle:=Trim(EQLTitle.Text);
  SUrl:=Trim(EQLUrl.Text);
  if (STitle='') or (SUrl='') then exit;
  ListBoxQuickLink.Items.Add(STitle+'='+SUrl);
  AddQuickLinkItem(STitle,SUrl);
  finally
  }
  NSaveQuickLink.OnClick(Sender);
  ListBoxQuickLink.Items.Clear;
  LoadQuickLink(FormPublic.NQuickLink,ListBoxQuickLink);
  BQuickLinkOK.Enabled:=false;
  //end;
except end;
end;

procedure TSetForm.ListBoxQuickLinkDblClick(Sender: TObject);
begin
try
  //NSBEditCurrentQLData.OnClick(Sender);
  if ListBoxQuickLink.Count<=0 then exit;
  if ListBoxQuickLink.SelCount<=0 then exit;
  if ListBoxQuickLink.ItemIndex<0 then exit;
  FormMain.CBURL.Text:=Copy(ListBoxQuickLink.Items[ListBoxQuickLink.ItemIndex],Pos('=',ListBoxQuickLink.Items[ListBoxQuickLink.ItemIndex])+1,Length(ListBoxQuickLink.Items[ListBoxQuickLink.ItemIndex])-Pos('=',ListBoxQuickLink.Items[ListBoxQuickLink.ItemIndex]));
  FormMain.BBGO.OnClick(Sender);
except end;
end;

procedure TSetForm.N2Click(Sender: TObject);
var
  i:integer;
begin
try
  if ListBoxQuickLink.Count<=0 then exit;
  //ListBoxQuickLink.Items.Delete(LListBoxQuickLink.ItemIndex);
  if ListBoxQuickLink.SelCount<=0 then exit;
  for i:=1 to ListBoxQuickLink.SelCount do
  begin
    //if ListBoxQuickLink.Items[ListBoxMusicList.ItemIndex]<>''then
    ListBoxQuickLink.Items.Delete(ListBoxQuickLink.ItemIndex);
    //DeleteQuickLinkItem(Copy(ListBoxQuickLink.Items[ListBoxQuickLink.ItemIndex],Pos('=',ListBoxQuickLink.Items[ListBoxQuickLink.ItemIndex])+1,Length(ListBoxQuickLink.Items[ListBoxQuickLink.ItemIndex])-Pos('=',ListBoxQuickLink.Items[ListBoxQuickLink.ItemIndex])));
  end;
  NSaveQuickLink.OnClick(Sender);
  BQuickLinkOK.Enabled := true;
  //QuickLiniStr[3]
  //kkend
except end;
end;

procedure TSetForm.BLoadQuickLinkClick(Sender: TObject);
begin
try
  if FileExists(MyDir+QuickLinkFile) then
  ListBoxQuickLink.Items.LoadFromFile(MyDir+QuickLinkFile);
except end;
end;

procedure TSetForm.NSBEditCurrentQLDataClick(Sender: TObject);
begin
try
  if ListBoxQuickLink.Count<=0 then exit;
  if ListBoxQuickLink.ItemIndex<0 then exit;
  if Trim(ListBoxQuickLink.Items[ListBoxQuickLink.ItemIndex])<>'' then
  begin
    EQLTitle.Text:=Copy(ListBoxQuickLink.Items[ListBoxQuickLink.ItemIndex],1,Pos('=',ListBoxQuickLink.Items[ListBoxQuickLink.ItemIndex])-1);
    EQLUrl.Text:=Copy(ListBoxQuickLink.Items[ListBoxQuickLink.ItemIndex],Pos('=',ListBoxQuickLink.Items[ListBoxQuickLink.ItemIndex])+1,Length(ListBoxQuickLink.Items[ListBoxQuickLink.ItemIndex])-Pos('=',ListBoxQuickLink.Items[ListBoxQuickLink.ItemIndex]));
    ListBoxQuickLink.Items.Delete(ListBoxQuickLink.ItemIndex);
    //DeleteQuickLinkItem(EQLUrl.Text);
    //BQuickLinkOK.Enabled := true;
  end;
except end;
end;

procedure TSetForm.NSaveQuickLinkClick(Sender: TObject);
begin
try
  ListBoxQuickLink.Items.SaveToFile(MyDir+QuickLinkFile);
except end;
end;

procedure TSetForm.EQLTitleKeyPress(Sender: TObject; var Key: Char);
begin
try
  if Key=#13 then
  if Trim(EQLTitle.Text)<>'' then EQLUrl.SetFocus;
except end;
end;

procedure TSetForm.EQLUrlKeyPress(Sender: TObject; var Key: Char);
begin
try
  if Key=#13 then
  if Trim(EQLTitle.Text)<>'' then BAddQuickLink.OnClick(Sender);
except end;
end;

procedure TSetForm.Button3Click(Sender: TObject);
begin
try
  LoadQuickLink(FormPublic.NQuickLink,ListBoxQuickLink);
except end;
end;

procedure TSetForm.SpeedButton20Click(Sender: TObject);
var
  NewIndex:Integer;
begin
try
  if ListBoxQuickLink.SelCount<=0 then exit;
  if ListBoxQuickLink.ItemIndex>0 then
  begin
    NewIndex := ListBoxQuickLink.ItemIndex-1;
    ListBoxQuickLink.Items.Insert(NewIndex,ListBoxQuickLink.Items.Strings[ListBoxQuickLink.itemIndex]);
    ListBoxQuickLink.DeleteSelected;
    ListBoxQuickLink.Selected[NewIndex]:=true;
    //ListBoxMusicList.ItemIndex:=NewIndex+1;
    BQuickLinkOK.Enabled:=true;
  end;
except end;
end;

procedure TSetForm.SpeedButton26Click(Sender: TObject);
var
  NewIndex:Integer;
begin
try
  if ListBoxQuickLink.SelCount<=0 then exit;
  if (ListBoxQuickLink.ItemIndex>-1) and (ListBoxQuickLink.ItemIndex<ListBoxQuickLink.Items.Count-1) then
  begin
    NewIndex := ListBoxQuickLink.ItemIndex+2;
    ListBoxQuickLink.Items.Insert(NewIndex,ListBoxQuickLink.Items.Strings[ListBoxQuickLink.itemIndex]);
    ListBoxQuickLink.DeleteSelected;
    ListBoxQuickLink.Selected[NewIndex-1]:=true;
    BQuickLinkOK.Enabled:=true;
  end;
except end;
end;

procedure TSetForm.CBSSRightTopChange(Sender: TObject);
begin
try
  SSRightTop:=CBSSRightTop.ItemIndex;
  WritePrivateProfileString('setting','SSRightTop',PChar(IntToStr(CBSSRightTop.ItemIndex)),PChar(MyDir+ConfigFile));
  ButtonSSOK.Enabled:=true;
  //ButtonSSOK.SetFocus;
except end;
end;

procedure TSetForm.CBSSRightButtomChange(Sender: TObject);
begin
try
  SSRightButtom:=CBSSRightButtom.ItemIndex;
  WritePrivateProfileString('setting','SSRightButtom',PChar(IntToStr(CBSSRightButtom.ItemIndex)),PChar(MyDir+ConfigFile));
  ButtonSSOK.Enabled:=true;
  //ButtonSSOK.SetFocus;
except end;
end;

procedure TSetForm.RBCRCurrentNoClick(Sender: TObject);
begin
try
  if ShowOptionOK then
  begin
  WritePrivateProfileString('setting','RightClickClose','0',PChar(MyDir+ConfigFile));
  end;
  RightClickClose := false;
except end;
end;

procedure TSetForm.RBCloseOnlyClick(Sender: TObject);
begin
try
  if ShowOptionOK then
  begin
  WritePrivateProfileString('setting','RightClickClose','1',PChar(MyDir+ConfigFile));
  end;
  RightClickClose := true;
except end;
end;

procedure TSetForm.CBNoUseProxyClick(Sender: TObject);
begin
try
  {
  DisableProxy;
  if FormMain.NUseIEProxy.Checked then NotProxy;
  }
  //FormMain.NUseIEProxy.Checked:=false;
  //FormMain.NNoUseProxy.Checked:=true;
  if CBNoUseProxy.Checked then
  CBUseProxy.Checked:=false;
  //CBNoUseProxy.Checked:=true;
  BProxySetOK.Enabled:=true;
except end;
end;

procedure TSetForm.CBUseProxyClick(Sender: TObject);
begin
try
  //FormMain.NUseIEProxy.Checked:=true;
  //FormMain.NNoUseProxy.Checked:=false;
  //CBUseProxy.Checked:=true;
  if CBUseProxy.Checked then
  CBNoUseProxy.Checked:=false;
  BProxySetOK.Enabled:=true;
except end;
end;

procedure TSetForm.BProxySetOKClick(Sender: TObject);
var
  str:string;
begin
try        
  try
  if CBUseProxy.Checked then
  begin
    if ListBoxProxyList.Count<=0 then //exit;
    begin
      ShowMessage('代理地址列表为空！请填加或者载入现有的代理地址列表！');
      exit;
    end;
    //EnableProxy;
    //FormPublic.NUseIEProxy.OnClick(Sender);
    str:=ListBoxProxyList.Items.Strings[0];
    FormPublic.NUseIEProxy.Checked := false;
    FormPublic.NNoUseProxy.Checked := false;
    FormPublic.NSetProxy.Checked := true;
    WritePrivateProfileString('RunData','UseProxy','1',PChar(MyDir+ConfigFile));
    WritePrivateProfileString('RunData','UseIEProxy','0',PChar(MyDir+ConfigFile));
    UseProxy(str);      
  end
  else 
  begin
    //DisableProxy;
    FormPublic.NNoUseProxy.OnClick(Sender);
    FormPublic.NSetProxy.Checked := false;
    FormPublic.NUseIEProxy.Checked := false;
    FormPublic.NNoUseProxy.Checked := true;
    WritePrivateProfileString('RunData','UseProxy','0',PChar(MyDir+ConfigFile));
    //WritePrivateProfileString('RunData','UseIEProxy','0',PChar(MyDir+ConfigFile));
    NotProxy;
  end;
  finally
  ListBoxProxyList.Items.SaveToFile(MyDir+ProxyFile);
  BProxySetOK.Enabled:=false;
  end;
except end;
end;

procedure TSetForm.SpeedButton34Click(Sender: TObject);
var
  NewIndex:Integer;
begin
try
  if ListBoxProxyList.SelCount<=0 then exit;
  if ListBoxProxyList.ItemIndex>0 then
  begin
    NewIndex := ListBoxProxyList.ItemIndex-1;
    ListBoxProxyList.Items.Insert(NewIndex,ListBoxProxyList.Items.Strings[ListBoxProxyList.itemIndex]);
    ListBoxProxyList.DeleteSelected;
    ListBoxProxyList.Selected[NewIndex]:=true;
    //ListBoxMusicList.ItemIndex:=NewIndex+1;
    BProxySetOK.Enabled:=true;
  end;
except end;
end;

procedure TSetForm.SpeedButton35Click(Sender: TObject);
var
  NewIndex:Integer;
begin
try
  if ListBoxProxyList.SelCount<=0 then exit;
  if (ListBoxProxyList.ItemIndex>-1) and (ListBoxProxyList.ItemIndex<ListBoxProxyList.Items.Count-1) then
  begin
    NewIndex := ListBoxProxyList.ItemIndex+2;
    ListBoxProxyList.Items.Insert(NewIndex,ListBoxProxyList.Items.Strings[ListBoxProxyList.itemIndex]);
    ListBoxProxyList.DeleteSelected;
    ListBoxProxyList.Selected[NewIndex-1]:=true;
    BProxySetOK.Enabled:=true;
  end;
except end;
end;

procedure TSetForm.BAddToProxyListClick(Sender: TObject);
begin
try
  if (Trim(EProxyAddress.Text)<>'') and (Trim(EProxyNumber.Text)<>'') then
  ListBoxProxyList.Items.Add(Trim(EProxyAddress.Text)+':'+Trim(EProxyNumber.Text));
  EProxyAddress.Text:='';
  EProxyNumber.Text:='';
  EProxyAddress.SetFocus;
  BProxySetOK.Enabled:=true;
except end;
end;

procedure TSetForm.ListBoxProxyListDblClick(Sender: TObject);
var
  str:string;
begin
try
  if ListBoxProxyList.Items.Count<=0 then exit;
  //if ListBoxProxyList.ItemIndex<0 then
  //if ListBoxProxyList.SelCount<=0 then exit;
  str:=ListBoxProxyList.Items.Strings[ListBoxProxyList.itemIndex];
  if MessageBox(Handle,'确认要使用此代理地址吗？','询问',MB_YESNO+MB_ICONINFORMATION)=ID_NO then exit;
  CBNoUseProxy.Checked:=false;
  CBUseProxy.Checked:=true;
  ListBoxProxyList.Items.Insert(0,ListBoxProxyList.Items.Strings[ListBoxProxyList.itemIndex]);
  ListBoxProxyList.DeleteSelected;
  FormPublic.NUseIEProxy.Checked := false;
  FormPublic.NNoUseProxy.Checked := false;
  BProxySetOK.Enabled:=true;
  BProxySetOK.Click;
except end;
end;

procedure TSetForm.BLoadProxyListClick(Sender: TObject);
begin
try
  if FileExists(MyDir+ProxyFile) then
  ListBoxProxyList.Items.LoadFromFile(MyDir+ProxyFile);
except end;
end;

procedure TSetForm.BSaveProxyListClick(Sender: TObject);
begin
try
  ListBoxProxyList.Items.SaveToFile(MyDir+ProxyFile);
except end;
end;

procedure TSetForm.EProxyAddressKeyPress(Sender: TObject; var Key: Char);
begin
try
  if key=#13 then
  if (Trim(EProxyAddress.Text)<>'') then
  EProxyNumber.SetFocus;
except end;
end;

procedure TSetForm.EProxyNumberKeyPress(Sender: TObject; var Key: Char);
begin
try
  if key=#13 then
  if (Trim(EProxyNumber.Text)<>'') then
  BAddToProxyList.OnClick(Sender);
except end;
end;

procedure TSetForm.MenuItem2Click(Sender: TObject);
var
  i:integer;
begin
try
  if ListBoxProxyList.Count<=0 then exit;
  //ListBoxQuickLink.Items.Delete(LListBoxQuickLink.ItemIndex);
  if ListBoxProxyList.SelCount<=0 then exit;
  for i:=1 to ListBoxProxyList.SelCount do
  begin
    //if ListBoxQuickLink.Items[ListBoxMusicList.ItemIndex]<>''then
    ListBoxProxyList.Items.Delete(ListBoxProxyList.ItemIndex);
    //DeleteQuickLinkItem(Copy(ListBoxQuickLink.Items[ListBoxQuickLink.ItemIndex],Pos('=',ListBoxQuickLink.Items[ListBoxQuickLink.ItemIndex])+1,Length(ListBoxQuickLink.Items[ListBoxQuickLink.ItemIndex])-Pos('=',ListBoxQuickLink.Items[ListBoxQuickLink.ItemIndex])));
  end;
  //kkend
  BProxySetOK.Enabled:=true;
except end;
end;

procedure TSetForm.MenuItem1Click(Sender: TObject);
begin
try
  if ListBoxProxyList.Count<=0 then exit;
  if ListBoxProxyList.ItemIndex<0 then exit;
  if Trim(ListBoxProxyList.Items[ListBoxProxyList.ItemIndex])<>'' then
  begin
    EProxyAddress.Text:=Copy(ListBoxProxyList.Items[ListBoxProxyList.ItemIndex],1,Pos(':',ListBoxProxyList.Items[ListBoxProxyList.ItemIndex])-1);
    EProxyNumber.Text:=Copy(ListBoxProxyList.Items[ListBoxProxyList.ItemIndex],Pos(':',ListBoxProxyList.Items[ListBoxProxyList.ItemIndex])+1,Length(ListBoxProxyList.Items[ListBoxProxyList.ItemIndex])-Pos(':',ListBoxProxyList.Items[ListBoxProxyList.ItemIndex]));
    ListBoxProxyList.Items.Delete(ListBoxProxyList.ItemIndex);
    //DeleteQuickLinkItem(EQLUrl.Text);
  end;
  BProxySetOK.Enabled:=true;
except end;
end;

procedure TSetForm.CBExitCleanAllHistoryClick(Sender: TObject);
begin
try
  SBOKCG.Enabled:=true;
  if CBExitCleanAllHistory.Checked then
  begin
    CBCleanAddress.Checked := true;
    CBCleanHistory.Checked := true;
    CBCleanCache.Checked := true;
    CBCleanCookies.Checked := true;
    CBCleanRecent.Checked := true;
    ExitCleanAllHistory := true;
  end
  else
  begin
    CBCleanAddress.Checked := false;
    CBCleanHistory.Checked := false;
    CBCleanCache.Checked := false;
    CBCleanCookies.Checked := false;
    CBCleanRecent.Checked := false;
    ExitCleanAllHistory := false;
  end;
except end;
end;

procedure TSetForm.BWhiteListSaveOKClick(Sender: TObject);
begin
try
  try
  if RBWhiteList.Checked then
  ListBoxWhiteList.Items.SaveToFile(MyDir + WhiteListFile)
  else if RBBlackList.Checked then
  ListBoxWhiteList.Items.SaveToFile(MyDir + BlackListFile);
  EditWhiteList.Text := '';
  BWhiteListSaveOK.Enabled := false;
  finally
    if RBWhiteList.Checked then
    begin
      if FileExists(MyDir + WhiteListFile) then
      WhiteList.LoadFromFile(MyDir + WhiteListFile);
    end
    else if RBBlackList.Checked then
    begin
      if FileExists(MyDir + BlackListFile) then
      BlackList.LoadFromFile(MyDir + BlackListFile);
      FormPublic.ProBlackList;
    end
  end;
except end;
end;

procedure TSetForm.BWhiteListClearClick(Sender: TObject);
begin
try
  ListBoxWhiteList.Items.Clear;
  BWhiteListSaveOK.Enabled := true;
except end;
end;

procedure TSetForm.BAddWhiteListClick(Sender: TObject);
begin
try
  if Trim(EditWhiteList.Text) = '' then exit;
  if Pos('.', Trim(EditWhiteList.Text)) = 0 then exit;
  ListBoxWhiteList.Items.Add(Trim(EditWhiteList.Text));
  BWhiteListSaveOK.Enabled := true;
except end;
end;

procedure TSetForm.EditWhiteListKeyPress(Sender: TObject; var Key: Char);
begin
try
  if Key = #13 then BAddWhiteList.OnClick(Sender);
except end;
end;

procedure TSetForm.BWhiteListLoadClick(Sender: TObject);
begin
try
  {
  //WhiteList.SaveToFile(MyDir + WhiteListFile);
  if FileExists(MyDir + WhiteListFile) then
  ListBoxWhiteList.Items.LoadFromFile(MyDir + WhiteListFile);
  //BWhiteListSaveOK.Enabled := false;
  }
  BWhiteListClear.Click;
  if (SetForm.RBWhiteList.Checked) then
  begin
    if FileExists(MyDir + WhiteListFile) then
    ListBoxWhiteList.Items.LoadFromFile(MyDir + WhiteListFile);
  end
  else if (SetForm.RBBlackList.Checked) then
  begin
    if FileExists(MyDir + BlackListFile) then
    ListBoxWhiteList.Items.LoadFromFile(MyDir + BlackListFile);
  end
except end;
end;

procedure TSetForm.MenuItem3Click(Sender: TObject);
begin
try
  if ListBoxWhiteList.Count<=0 then exit;
  if ListBoxWhiteList.ItemIndex<0 then exit;
  if Trim(ListBoxWhiteList.Items[ListBoxWhiteList.ItemIndex])<>'' then
  begin
    EditWhiteList.Text:=(ListBoxWhiteList.Items[ListBoxWhiteList.ItemIndex]);
    ListBoxWhiteList.Items.Delete(ListBoxWhiteList.ItemIndex);
  end;
except end;
end;

procedure TSetForm.MenuItem4Click(Sender: TObject);
var
  i:integer;
begin
try
  if ListBoxWhiteList.Count<=0 then exit;
  if ListBoxWhiteList.SelCount<=0 then exit;
  for i:=1 to ListBoxWhiteList.SelCount do
  begin
    ListBoxWhiteList.Items.Delete(ListBoxWhiteList.ItemIndex);
  end;
  BWhiteListSaveOK.Enabled:=true;
except end;
end;

procedure TSetForm.MenuItem5Click(Sender: TObject);
begin
try
  BWhiteListSaveOK.OnClick(Sender);
except end;
end;

procedure TSetForm.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
try
  //if PageControl1.ActivePage = TabSheetWhiteList then BWhiteListLoad.OnClick(Sender);
except end;
end;                                          

procedure TSetForm.BInputTableClick(Sender: TObject);
begin
try
  //{
  try
  NickName := Trim(ENickName.Text);
  UserName := Trim(EUserName.Text);
  PassWord := Trim(EPassWord.Text);
  Answer := Trim(EAnswer.Text);
  Email := Trim(EEmail.Text);
  RealName := Trim(ERealName.Text);
  BInputTable.Enabled := false;
  finally
    WritePrivateProfileString('setting','NickName',PChar(NickName),PChar(MyDir+ConfigFile));
    WritePrivateProfileString('setting','UserName',PChar(UserName),PChar(MyDir+ConfigFile));
    WritePrivateProfileString('setting','PassWord',PChar(PassWord),PChar(MyDir+ConfigFile));
    WritePrivateProfileString('setting','Answer',PChar(Answer),PChar(MyDir+ConfigFile));
    WritePrivateProfileString('setting','Email',PChar(Email),PChar(MyDir+ConfigFile));
    WritePrivateProfileString('setting','RealName',PChar(RealName),PChar(MyDir+ConfigFile));
  end;
  //}
except end;   
end;

procedure TSetForm.ENickNameChange(Sender: TObject);
begin
try
  if not BInputTable.Enabled then
  BInputTable.Enabled := true;
except end;
end;

procedure TSetForm.EUserNameChange(Sender: TObject);
begin
try
  if not BInputTable.Enabled then
  BInputTable.Enabled := true;
except end;
end;

procedure TSetForm.EPassWordChange(Sender: TObject);
begin
try
  if not BInputTable.Enabled then
  BInputTable.Enabled := true;
except end;
end;

procedure TSetForm.EEmailChange(Sender: TObject);
begin
try
  if not BInputTable.Enabled then
  BInputTable.Enabled := true;
except end;
end;

procedure TSetForm.ERealNameChange(Sender: TObject);
begin
try
  if not BInputTable.Enabled then
  BInputTable.Enabled := true;
except end;
end;

procedure TSetForm.ENickNameKeyPress(Sender: TObject; var Key: Char);
begin
try
  if Key = #13 then
  EUserName.SetFocus;
except end;
end;

procedure TSetForm.EUserNameKeyPress(Sender: TObject; var Key: Char);
begin
try
  if Key = #13 then
  EPassWord.SetFocus;
except end;
end;

procedure TSetForm.EPassWordKeyPress(Sender: TObject; var Key: Char);
begin
try
  if Key = #13 then
  EAnswer.SetFocus;
except end;
end;

procedure TSetForm.EEmailKeyPress(Sender: TObject; var Key: Char);
begin
try
  if Key = #13 then
  ERealName.SetFocus;
except end;
end;

procedure TSetForm.ERealNameKeyPress(Sender: TObject; var Key: Char);
begin
try
  if Key = #13 then
  BInputTable.Click;
except end;
end;

procedure TSetForm.RBCloseGoTab1Click(Sender: TObject);
begin
try
  CloseGoTab := false;
  if ShowOptionOK then
  begin
  WritePrivateProfileString('setting','CloseGoTab','1',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TSetForm.RBCloseGoTab2Click(Sender: TObject);
begin
try
  CloseGoTab := true;
  if ShowOptionOK then
  begin
  WritePrivateProfileString('setting','CloseGoTab','0',PChar(MyDir+ConfigFile));
  end;
except end;
end;

procedure TSetForm.RBNewTabYClick(Sender: TObject);
begin
try
  if ShowOptionOK then
  begin
    AlwaysNewTab := false;
    WritePrivateProfileString('setting','AlwaysNewTab','0',PChar(MyDir+ConfigFile));
    //MessageBox(SetForm.Handle,'此项功能将在下次启动浏览器时起作用!', '提示:', 0);
  end;
except end;
end;

procedure TSetForm.RBNewTabNClick(Sender: TObject);
begin
try
  if ShowOptionOK then
  begin
    AlwaysNewTab := true;
    WritePrivateProfileString('setting','AlwaysNewTab','1',PChar(MyDir+ConfigFile));
    //MessageBox(SetForm.Handle,'此项功能将在下次启动浏览器时起作用!', '提示:', 0);
  end;
except end;
end;

procedure TSetForm.BToolReplace1010Click(Sender: TObject);
begin
try
  FormMain.TBOption.ImageIndex:=BToolReplace1010.Tag;
  FormMain.TBOption.Tag:=BToolReplace1010.Tag;
  FormMain.TBOption.Hint:='选项';
  WritePrivateProfileString('setting','Replace10','10',PChar(MyDir+ConfigFile));
except end;
end;

procedure TSetForm.BToolReplace1012Click(Sender: TObject);
begin
try
  FormMain.TBOption.ImageIndex:=BToolReplace1012.Tag;
  FormMain.TBOption.Tag:=BToolReplace1012.Tag;
  FormMain.TBOption.Hint:='复制';
  WritePrivateProfileString('setting','Replace10','12',PChar(MyDir+ConfigFile));
except end;
end;

procedure TSetForm.BToolReplace1013Click(Sender: TObject);
begin
try
  FormMain.TBOption.ImageIndex:=BToolReplace1013.Tag;
  FormMain.TBOption.Tag:=BToolReplace1013.Tag;
  FormMain.TBOption.Hint:='侧边栏';
  WritePrivateProfileString('setting','Replace10','13',PChar(MyDir+ConfigFile));
except end;
end;

procedure TSetForm.BToolReplace1014Click(Sender: TObject);
begin
try
  FormMain.TBOption.ImageIndex:=BToolReplace1014.Tag;
  FormMain.TBOption.Tag:=BToolReplace1014.Tag;
  FormMain.TBOption.Hint:='打印预览';
  WritePrivateProfileString('setting','Replace10','14',PChar(MyDir+ConfigFile));
except end;
end;

procedure TSetForm.BToolReplace1015Click(Sender: TObject);
begin
try
  FormMain.TBOption.ImageIndex:=BToolReplace1015.Tag;
  FormMain.TBOption.Tag:=BToolReplace1015.Tag;
  FormMain.TBOption.Hint:='打印';
  WritePrivateProfileString('setting','Replace10','15',PChar(MyDir+ConfigFile));
except end;
end;

procedure TSetForm.BToolReplace1016Click(Sender: TObject);
begin
try
  FormMain.TBOption.ImageIndex:=BToolReplace1016.Tag;
  FormMain.TBOption.Tag:=BToolReplace1016.Tag;
  FormMain.TBOption.Hint:='另存为...';
  WritePrivateProfileString('setting','Replace10','16',PChar(MyDir+ConfigFile));
except end;
end;

procedure TSetForm.BToolReplace1111Click(Sender: TObject);
begin
try
  FormMain.TBTools.ImageIndex:=BToolReplace1111.Tag;
  FormMain.TBTools.Tag:=BToolReplace1111.Tag;
  FormMain.TBTools.Hint:='工具';
  FormMain.TBTools.Style:=tbsDropDown;
  FormMain.TBTools.DropdownMenu:=FormMain.PopupMenuTools;
  WritePrivateProfileString('setting','Replace11','11',PChar(MyDir+ConfigFile));
except end;
end;

procedure TSetForm.BToolReplace1112Click(Sender: TObject);
begin
try
  FormMain.TBTools.ImageIndex:=BToolReplace1112.Tag;
  FormMain.TBTools.Tag:=BToolReplace1112.Tag;
  FormMain.TBTools.Hint:='复制';
  FormMain.TBTools.Style:=tbsButton;
  FormMain.TBTools.DropdownMenu:=nil;
  WritePrivateProfileString('setting','Replace11','12',PChar(MyDir+ConfigFile));
except end;
end;

procedure TSetForm.BToolReplace1113Click(Sender: TObject);
begin
try
  FormMain.TBTools.ImageIndex:=BToolReplace1113.Tag;
  FormMain.TBTools.Tag:=BToolReplace1113.Tag;
  FormMain.TBTools.Hint:='侧边栏';
  FormMain.TBTools.Style:=tbsButton;
  FormMain.TBTools.DropdownMenu:=nil;
  WritePrivateProfileString('setting','Replace11','13',PChar(MyDir+ConfigFile));
except end;
end;

procedure TSetForm.BToolReplace1114Click(Sender: TObject);
begin
try
  FormMain.TBTools.ImageIndex:=BToolReplace1114.Tag;
  FormMain.TBTools.Tag:=BToolReplace1114.Tag;
  FormMain.TBTools.Hint:='打印预览';
  FormMain.TBTools.Style:=tbsButton;
  FormMain.TBTools.DropdownMenu:=nil;
  WritePrivateProfileString('setting','Replace11','14',PChar(MyDir+ConfigFile));
except end;
end;

procedure TSetForm.BToolReplace1115Click(Sender: TObject);
begin
try
  FormMain.TBTools.ImageIndex:=BToolReplace1115.Tag;
  FormMain.TBTools.Tag:=BToolReplace1115.Tag;
  FormMain.TBTools.Hint:='打印';
  FormMain.TBTools.Style:=tbsButton;
  FormMain.TBTools.DropdownMenu:=nil;
  WritePrivateProfileString('setting','Replace11','15',PChar(MyDir+ConfigFile));
except end;
end;

procedure TSetForm.BToolReplace1116Click(Sender: TObject);
begin
try
  FormMain.TBTools.ImageIndex:=BToolReplace1116.Tag;
  FormMain.TBTools.Tag:=BToolReplace1116.Tag;
  FormMain.TBTools.Hint:='另存为...';
  FormMain.TBTools.Style:=tbsButton;
  FormMain.TBTools.DropdownMenu:=nil;
  WritePrivateProfileString('setting','Replace11','16',PChar(MyDir+ConfigFile));
except end;
end;

procedure TSetForm.CheckBox1Click(Sender: TObject);
begin
try
  //CheckBox1.Checked:=not CheckBox1.Checked;
  if CheckBox1.Checked then
  begin
    FormMain.TBAddNew.Visible:=true;
    FormMain.ButtonSplitter1.Visible := true;
    WritePrivateProfileString('setting','ToolButton1','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    FormMain.TBAddNew.Visible:=false;
    FormMain.ButtonSplitter1.Visible := false;
    WritePrivateProfileString('setting','ToolButton1','0',PChar(MyDir+ConfigFile));
  end;

  FormMain.FormResize(Sender);
  //FormMain.OnResize(Sender);
  //FormMain.CBURL.Left := FormMain.ToolBarButton.Left + FormMain.ToolBarButton.Width + 6;
  //ImageGo.Left := PaintPanelButtonAddress.Left + PaintPanelButtonAddress.Width - PaintPanelGoRefreshStop.Width -ImageGo.Width - 2;
  //FormMain.CBURL.Width := FormMain.PaintPanelButtonAddress.Width - FormMain.ToolBarButton.Width - FormMain.PaintPanelGoRefreshStop.Width - FormMain.ImageGo.Width - 12;

except end;
end;

procedure TSetForm.CheckBox2Click(Sender: TObject);
begin
try
  //CheckBox2.Checked:=not CheckBox2.Checked;
  if CheckBox2.Checked then
  begin
    FormMain.TBGoBack.Visible:=true;
    WritePrivateProfileString('setting','ToolButton2','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    FormMain.TBGoBack.Visible:=false;
    WritePrivateProfileString('setting','ToolButton2','0',PChar(MyDir+ConfigFile));
  end;
  FormMain.FormResize(Sender);
except end;
end;

procedure TSetForm.CheckBox3Click(Sender: TObject);
begin
try
  //CheckBox3.Checked:=not CheckBox3.Checked;
  if CheckBox3.Checked then
  begin
    FormMain.TBGoForward.Visible:=true;
    WritePrivateProfileString('setting','ToolButton3','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    FormMain.TBGoForward.Visible:=false;
    WritePrivateProfileString('setting','ToolButton3','0',PChar(MyDir+ConfigFile));
  end;
  FormMain.FormResize(Sender);
except end;
end;

procedure TSetForm.CheckBox4Click(Sender: TObject);
begin
try
  //CheckBox4.Checked:=not CheckBox4.Checked;
  if CheckBox4.Checked then
  begin
    FormMain.TBStop.Visible:=true;
    WritePrivateProfileString('setting','ToolButton4','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    FormMain.TBStop.Visible:=false;
    WritePrivateProfileString('setting','ToolButton4','0',PChar(MyDir+ConfigFile));
  end;
  FormMain.FormResize(Sender);
except end;
end;

procedure TSetForm.CheckBox5Click(Sender: TObject);
begin
try
  //CheckBox5.Checked:=not CheckBox5.Checked;
  if CheckBox5.Checked then
  begin
    FormMain.TBRefresh.Visible:=true;
    WritePrivateProfileString('setting','ToolButton5','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    FormMain.TBRefresh.Visible:=false;
    WritePrivateProfileString('setting','ToolButton5','0',PChar(MyDir+ConfigFile));
  end;
  FormMain.FormResize(Sender);
except end;
end;

procedure TSetForm.CheckBox6Click(Sender: TObject);
begin
try
  //CheckBox6.Checked:=not CheckBox6.Checked;
  if CheckBox6.Checked then
  begin                            
    FormMain.TBGoHome.Visible:=true;
    WritePrivateProfileString('setting','ToolButton6','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    FormMain.TBGoHome.Visible:=false;
    WritePrivateProfileString('setting','ToolButton6','0',PChar(MyDir+ConfigFile));
  end;
  if not Auto then
  FormMain.FormResize(Sender);
  Auto := false;
except end;
end;

procedure TSetForm.CheckBox7Click(Sender: TObject);
begin
try
  //CheckBox7.Checked:=not CheckBox7.Checked;
  if CheckBox7.Checked then
  begin
    FormMain.TBFavorite.Visible:=true;
    WritePrivateProfileString('setting','ToolButton7','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    FormMain.TBFavorite.Visible:=false;
    WritePrivateProfileString('setting','ToolButton7','0',PChar(MyDir+ConfigFile));
  end;
  //FormMain.FormResize(Sender);
except end;
end;

procedure TSetForm.CheckBox8Click(Sender: TObject);
begin
try
  //CheckBox8.Checked:=not CheckBox8.Checked;
  if CheckBox8.Checked then
  begin
    FormMain.TBClose.Visible:=true;
    WritePrivateProfileString('setting','ToolButton8','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    FormMain.TBClose.Visible:=false;
    WritePrivateProfileString('setting','ToolButton8','0',PChar(MyDir+ConfigFile));
  end;
  FormMain.FormResize(Sender);
  {
  if (FormMain.TBClose.Visible = false) and (FormMain.TBNewly.Visible = false) then
  FormMain.ToolButtonS6.Visible := false;
  }
except end;
end;

procedure TSetForm.CheckBox9Click(Sender: TObject);
begin
try
  //CheckBox9.Checked:=not CheckBox9.Checked;
  if CheckBox9.Checked then
  begin
    FormMain.TBNewly.Visible:=true;
    if not Auto then
    WritePrivateProfileString('setting','ToolButton9','1',PChar(MyDir+ConfigFile));
    //FormMain.OnResize(Sender);
  end
  else
  begin
    FormMain.TBNewly.Visible:=false;
    if not Auto then
    WritePrivateProfileString('setting','ToolButton9','0',PChar(MyDir+ConfigFile));
  end;
  {
  FormMain.FormResize(Sender);
  if (FormMain.TBClose.Visible = false) and (FormMain.TBNewly.Visible = false) then
  FormMain.ToolButtonS6.Visible := false;
  }
  if not Auto then
  FormMain.OnResize(Sender);
  Auto := false;
except end;
end;

procedure TSetForm.CheckBox10Click(Sender: TObject);
begin
try
  //CheckBox10.Checked:=not CheckBox10.Checked;
  if CheckBox10.Checked then
  begin
    FormMain.TBOption.Visible:=true;
    WritePrivateProfileString('setting','ToolButton10','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    FormMain.TBOption.Visible:=false;
    WritePrivateProfileString('setting','ToolButton10','0',PChar(MyDir+ConfigFile));
  end;
  //FormMain.FormResize(Sender);
except end;
end;

procedure TSetForm.CheckBox11Click(Sender: TObject);
begin
try
  //CheckBox11.Checked:=not CheckBox11.Checked;
  if CheckBox11.Checked then
  begin
    FormMain.TBTools.Visible:=true;
    WritePrivateProfileString('setting','ToolButton11','1',PChar(MyDir+ConfigFile));
  end
  else
  begin
    FormMain.TBTools.Visible:=false;
    WritePrivateProfileString('setting','ToolButton11','0',PChar(MyDir+ConfigFile));
  end;
  //FormMain.FormResize(Sender);
except end;
end;

procedure TSetForm.EditDefaultPageChange(Sender: TObject);
begin
try
  SBOKCG.Enabled:=true;
except end;
end;

procedure TSetForm.EAnswerChange(Sender: TObject);
begin
try
  if not BInputTable.Enabled then
  BInputTable.Enabled := true;
except end;
end;

procedure TSetForm.EAnswerKeyPress(Sender: TObject; var Key: Char);
begin
try
  if Key = #13 then
  EEmail.SetFocus;
except end;
end;

procedure TSetForm.BFavOkClick(Sender: TObject);
begin
try
  if RBUseSys.Checked then
  WritePrivateProfileString('setting','FavDirMe','0',PChar(MyDir + ConfigFile))
  else
  WritePrivateProfileString('setting','FavDirMe','1',PChar(MyDir + ConfigFile));
  WritePrivateProfileString('setting','FavoritFolder',PChar(EFavoriteDir.Text),PChar(MyDir + ConfigFile));
  FavoritFolder := EFavoriteDir.Text;
  BFavOk.Enabled := false;
except end;
end;

procedure TSetForm.RBUseSysClick(Sender: TObject);
begin
try
  BFavOk.Enabled := true;
  WritePrivateProfileString('setting','FavDirMe','0',PChar(MyDir + ConfigFile));
except end;
end;

procedure TSetForm.RBUseSelfClick(Sender: TObject);
begin
try
  BFavOk.Enabled := true;
  WritePrivateProfileString('setting','FavDirMe','1',PChar(MyDir + ConfigFile));
except end;
end;

procedure TSetForm.EFavoriteDirChange(Sender: TObject);
begin
try
  BFavOk.Enabled := true;
except end;
end;

procedure TSetForm.HotKey1Change(Sender: TObject);
begin
try
  BossKey := ShortCutToText(HotKey1.HotKey);
  WritePrivateProfileString('setting','BossKey',PChar(ShortCutToText(HotKey1.HotKey)),PChar(MyDir+ConfigFile));
  FormMain.AddHotKey;
  //ShowMessage('重新启动浏览器后生效!');
except end;
end;

procedure TSetForm.EQLTitleKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
try
  //BQuickLinkOK.Enabled := true;
except end;
end;

procedure TSetForm.EQLUrlKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
try
  //BQuickLinkOK.Enabled := true;
except end;
end;

end.
