unit UnitWebBrowser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, StdCtrls, ToolWin, ComCtrls,
  EmbeddedWB,
  MSHTML,  //IHTMLWindow2
  ComObj,
  ActiveX,
  ExtCtrls,
  ShellApi;

type
  TFormWebBrowser = class(TForm)
    Panel1: TPanel;
    WebBrowser2: TWebBrowser;
    WebBrowser1: TEmbeddedWB;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure WebBrowser1TitleChange(Sender: TObject;
      const Text: WideString);
    procedure WebBrowser1CommandStateChange(Sender: TObject;
      Command: Integer; Enable: WordBool);
    procedure WebBrowser1DownloadBegin(Sender: TObject);
    procedure WebBrowser1DownloadComplete(Sender: TObject);
    procedure WebBrowser1DocumentComplete(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure WebBrowser1NavigateComplete2(Sender: TObject;   
      const pDisp: IDispatch; var URL: OleVariant);
    procedure WebBrowser1NewWindow2(Sender: TObject; var ppDisp: IDispatch;
      var Cancel: WordBool);
    {
    function GetppDisp:IDispatch;
    property _ppDisp:IDispatch read GetppDisp;
    }
    procedure WebBrowser1ProgressChange(Sender: TObject; Progress,
      ProgressMax: Integer);
    function WebBrowser1ShowContextMenu(const dwID: Cardinal;
      const ppt: PPoint; const pcmdtReserved: IInterface;
      const pdispReserved: IDispatch): HRESULT;
    procedure WebBrowser1ScriptError(Sender: TObject; ErrorLine,
      ErrorCharacter, ErrorCode, ErrorMessage, ErrorUrl: String;
      var ContinueScript, Showdialog: Boolean);
    procedure WebBrowser1CloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure WebBrowser1StatusTextChange(Sender: TObject;
      const Text: WideString);
    function WebBrowser1GetExternal(out ppDispatch: IDispatch): HRESULT;
    procedure WebBrowser1BeforeNavigate2(Sender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    //procedure WebBrowser1DragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    //procedure TimerWebAutoRefreshCreate(Sender: TObject);
  private
    { Private declarations }
    UserIO: TUserInterfaceOptions;
    DownloadCO: TDownloadControlOptions;
  public
    { Public declarations }
    WebBrowser: TEmbeddedWB;  //TWebBrowser;
    Bool_Back: Boolean;
    Bool_Forward: Boolean;
    WebTitle, WebUrl: String;
    IsPopup: Boolean; //广告屏蔽
    CleanADWhite: Boolean;
    NoCleanAd: Boolean;
    NoCleanFlash: Boolean;
    TabLock: Boolean;
    AllMode: Boolean;
    Closeing: Boolean;
    DownIcon: Boolean;
    UpdateWebIconOk: Boolean;
    //Search: Boolean;
    TimerWebAutoRefresh: TTimer;
    procedure TimerWebAutoRefreshCreate;
    procedure TimerWebAutoRefreshOnTimer(Sender: TObject);
    //ProBar:TProgressBar;  //状态进度条
  end;

var
  FormWebBrowser: TFormWebBrowser;

implementation

uses UnitMain, Public, var_, KillAd, UnitPublic, const_, UnitHintShow,
  idispatch_interface;

{$R *.dfm}

procedure TFormWebBrowser.FormCreate(Sender: TObject);
{
var
  UserIO: TUserInterfaceOptions;
  DownloadCO: TDownloadControlOptions;
}
begin
try
  try    //exit;
  //LockWindowUpdate(FormMain.PanelWBMain.Handle);
  //LockWindowUpdate(FormWebBrowser.Handle);
  //LockWindowUpdate(FormMain.Handle);
  WindowState := wsMaximized;
  Bool_Back := false;
  Bool_Forward := false;
  NoCleanAd := true;
  NoCleanFlash := not StopFlashAd;
  IsPopup := true;
  CleanADWhite := false;
  Closeing := false;
  TabLock := false;
  AllMode := true;
  DownIcon := false;
  //if not MoreUrlOpen then
  UpdateWebIconOk := false;
  //else                      
  //UpdateWebIconOk := true;
  //Search := false;
  WebBrowser := TEmbeddedWB.Create(nil);

  //TControl(WebBrowser).Parent := Self;  WebBrowser.Silent := true;  WebBrowser.fpExceptions := false;
  WebBrowser.EnableDDE := true;
  //WebBrowser.DragMode := dmAutomatic;
  //WebBrowser.RegisterAsDropTarget := True;     
  WebBrowser.Align := alClient;
                            
  if FormsAutoComplete then
  begin
    //定义用户界面接口         
    Include(UserIO, NO3DBORDER);
    //
    Include(UserIO, ENABLE_FORMS_AUTOCOMPLETE);
    //Include(UserIO, SCROLL_NO);
    Include(UserIO, Theme);
    WebBrowser.UserInterfaceOptions := UserIO;
  end;

  if IsWhite then IsWhite := false
  else
  begin
  //DownloadCO := WebBrowser.DownloadOptions;
  //{
  //定义下载内容
  if not NoImage then
  Include(DownloadCO, DLCTL_DLIMAGES);
  if not NoVideo then
  Include(DownloadCO, DLCTL_VIDEOS);
  if not NoBgsound then
  Include(DownloadCO, DLCTL_BGSOUNDS);
  if NoJava then
  Include(DownloadCO, DLCTL_NO_JAVA);
  if NoScript then
  Include(DownloadCO, DLCTL_NO_SCRIPTS);
  if NoActivex then
  begin
    Include(DownloadCO, DLCTL_NO_DLACTIVEXCTLS);
    Include(DownloadCO, DLCTL_NO_RUNACTIVEXCTLS);    
  end;
  //}
    {
    with WebBrowser do
    begin
      if not NoImage then
      DownloadOptions := DownloadOptions + [DLCTL_DLIMAGES]
      else
      DownloadOptions := DownloadOptions - [DLCTL_DLIMAGES];
      if not NoVideo then
      DownloadOptions := DownloadOptions + [DLCTL_VIDEOS]
      else
      DownloadOptions := DownloadOptions - [DLCTL_VIDEOS];
      if not NoBgsound then
      DownloadOptions := DownloadOptions + [DLCTL_BGSOUNDS]
      else
      DownloadOptions := DownloadOptions - [DLCTL_BGSOUNDS];
      if NoJava then
      DownloadOptions := DownloadOptions + [DLCTL_NO_JAVA]
      else
      DownloadOptions := DownloadOptions - [DLCTL_NO_JAVA];
      if NoScript then
      DownloadOptions := DownloadOptions + [DLCTL_NO_SCRIPTS]
      else
      DownloadOptions := DownloadOptions - [DLCTL_NO_SCRIPTS];
      if NoActivex then
      begin
      DownloadOptions := DownloadOptions + [DLCTL_NO_DLACTIVEXCTLS];
      DownloadOptions := DownloadOptions + [DLCTL_NO_RUNACTIVEXCTLS];
      end
      else
      begin
      DownloadOptions := DownloadOptions - [DLCTL_NO_DLACTIVEXCTLS];
      DownloadOptions := DownloadOptions - [DLCTL_NO_RUNACTIVEXCTLS];
      end;
    end;
    }
  //DLCTL_OFFLINE and DLCTL_OFFLINEIFNOTCONNECTED  - 脱机
  WebBrowser.DownloadOptions:=DownloadCO;
  end;
  //}
  WebBrowser.RegisterAsDropTarget := false;

  WebBrowser.OnTitleChange := Webbrowser1TitleChange;
  //{
  WebBrowser.OnCommandStateChange := Webbrowser1CommandStateChange;
  WebBrowser.OnDownloadBegin := Webbrowser1DownloadBegin;
  WebBrowser.OnDownloadComplete := Webbrowser1DownloadComplete;
  WebBrowser.OnDocumentComplete := WebBrowser1DocumentComplete;
  WebBrowser.OnNavigateComplete2 := WebBrowser1NavigateComplete2;
  WebBrowser.OnNewWindow2 := Webbrowser1NewWindow2;
  //WebBrowser.OnBeforeNavigate2 := WebBrowser1BeforeNavigate2;

  WebBrowser.OnProgressChange := Webbrowser1ProgressChange;
  WebBrowser.OnStatusTextChange := WebBrowser1StatusTextChange;

  if LoadLastOpenFlag then
  WebBrowser.OnGetExternal := WebBrowser1GetExternal;

  WebBrowser.OnShowContextMenu := Webbrowser1ShowContextMenu;
  WebBrowser.OnScriptError := Webbrowser1ScriptError;

  //WebBrowser.OnDragOver := WebBrowser1DragOver;
  //}
  //WebBrowser.OnBeforeNavigate2:=WebBrowserBeforeNavigate2;
  WebBrowser.Loaded;
  Webbrowser.OnCloseQuery := Webbrowser1CloseQuery;  if HideBorder then  Webbrowser.HideBorders := true;  {  WebBrowser.DefaultInterface.Left := 0;  WebBrowser.DefaultInterface.Top  := 0;  WebBrowser.DefaultInterface.Width := 0;  WebBrowser.DefaultInterface.Height := 0;  }  //}
  finally
  TControl(WebBrowser).Parent := Self;    {  if CleanADWhite then NoCleanFlash := true  else  NoCleanFlash := not StopFlashAd;  }  end;
except end;
end;

procedure TFormWebBrowser.FormShow(Sender: TObject);
begin
try
  //LockWindowUpdate(FormWebBrowser.Handle);
  if wbList.IndexOf(Self) <> PageIndex then SendToBack;
  //TFormWebBrowser(wbList[PageIndex]).WebBrowser.Loaded;
  //WebBrowser.Loaded;
  //LockWindowUpdate(0);
except end;
end;

procedure TFormWebBrowser.TimerWebAutoRefreshCreate;
begin
try
  TimerWebAutoRefresh := TTimer.Create(Self);
  TimerWebAutoRefresh.Enabled := false;
  TFormWebBrowser(wbList[PageIndex]).TimerWebAutoRefresh.Interval := 0;
  TimerWebAutoRefresh.OnTimer := TimerWebAutoRefreshOnTimer;
except end;
end;

procedure TFormWebBrowser.TimerWebAutoRefreshOnTimer(Sender: TObject);
var
  FWB: TFormWebBrowser;      
begin
try
  if AutoRefresh then  begin          FWB := (Sender as TTimer).Owner as TFormWebBrowser;  //TimerWebAutoRefresh
    FWB.WebBrowser.Refresh;
  end
  else
  begin
    FormHintShow.Caption := '定时提醒: ';
    FormHintShow.Memo1.Text := AutoRefreshTxt;
    FormHintShow.Show;
    FormHintShow.Panel1.SetFocus;
  end;
  //TFormWebBrowser(wbList[FWB.Index]).WebBrowser.Refresh;
  //(Sender as TTimer).Enabled := false; 
  //xxx
except end;
end;

{
procedure TFormWebBrowser.WebBrowser2TitleChange(Sender: TObject;
  const Text: WideString);
var
  I, Index: Integer;
begin
try
  Index := wbList.IndexOf(Self);
  for I := 0 to FormMain.ToolBarTabParent.ButtonCount-1 do
  if FormMain.ToolBarTabParent.Buttons[I].Hint = TFormWebBrowser(wbList[Index]).WebBrowser.Hint then
  FormMain.ToolBarTabParent.Buttons[I].Caption := Text;
except end;
end;
}

procedure TFormWebBrowser.WebBrowser1TitleChange(Sender: TObject;
  const Text: WideString);
var
  Index: Integer;
  Str: String;
begin
try
  if Closeing then exit;
  if CloseApp then exit;
  Str := LowerCase(Trim(Text));
  if  Str = 'about:blank' then
  begin
    if LANGUAGE <= 1 then Str := '空白页'
    else Str := 'about:blank';
  end;
  WebTitle := Str;
  //if Length(Str) + 30 >= TabWidth then Str := Copy(Str,1,TabWidth - 10) + '...';
  //{
  if ShowWebIcon then
  begin
    Case WebIconNeedBlankCount of
    2: Str := '  ' + Str;
    3: Str := '   ' + Str;
    4: Str := '    ' + Str;
    5: Str := '     ' + Str;
    6: Str := '      ' + Str;
    end;
  end;
  //}    
  //if (wbList.Count = 1) and (EnabledInitPage) and (WebUrl = InitPage) then exit;
  Caption := Str;
  Index := wbList.IndexOf(Self);
  {$IFDEF TabButtonHint}
  FormMain.ToolBarTabParent.Buttons[Index].Hint := Str;     
  {$ELSE}
  {$ENDIF}
  FormMain.ToolBarTabParent.Buttons[Index].Repaint;
  {
  if ShowRunOK then
  begin
    //FormMain.ToolBarMenu.Repaint;
    FormPublic.TabClick2(999);
  end;
  }
  //FormMain.ToolBarMenu.Repaint;
except end;                   
end;

procedure TFormWebBrowser.WebBrowser1CommandStateChange(Sender: TObject;
  Command: Integer; Enable: WordBool);
begin
try
  if Closeing then exit;
  if CloseApp then exit;
  if wbList.Count = 0 then exit;
  //if TFormWebBrowser(wbList[wbList.IndexOf(Self)]).WebBrowser.LocationURL = 'about:blank' then exit;
  if Command=CSC_NAVIGATEBACK then
  begin
    Bool_Back := Enable;
    if wbList.IndexOf(Self) = PageIndex then
    begin
      BackEnabled := Bool_Back;  //Enable;
      {
      case FaceStyle of
        0: FormMain.TBGoBack.Enabled := BackEnabled;
        1:
        begin
        end;
      end;
      }
      if CurrBack <> BackEnabled then
      begin
        CurrBack := BackEnabled;

        if (CurrBack and CurrForward) then bfState := 4
        else if (CurrBack and not CurrForward) then bfState := 2
        else if (not CurrBack and CurrForward) then bfState := 3
        else if (not CurrBack and not CurrForward) then bfState := 1;

      end;
      FormMain.TBGoBack.Enabled := BackEnabled;
      //if not BackEnabled then FormMain.ImageGoBack.Picture := FormMain.ImageGoBack0.Picture;
    end;
  end
  else if Command=CSC_NAVIGATEFORWARD then
  begin
    Bool_Forward := Enable;
    //if TFormWebBrowser(wbList[PageIndex]).WebBrowser.Handle = WebBrowser.Handle then
    if wbList.IndexOf(Self) = PageIndex then
    begin
      //FormMain.Caption := IntToStr(RanDom(9999999)); FormMain.ToolBarMenu.Repaint;
      ForwardEnabled := Bool_Forward;  //Enable;
      {
      case FaceStyle of
        0: FormMain.TBGoForward.Enabled := ForwardEnabled;
        1:
        begin
        end;
      end;
      }
      if CurrForward <> ForwardEnabled then
      begin
        CurrForward := ForwardEnabled;
        
        if (CurrBack and CurrForward) then bfState := 4
        else if (CurrBack and not CurrForward) then bfState := 2
        else if (not CurrBack and CurrForward) then bfState := 3
        else if (not CurrBack and not CurrForward) then bfState := 1;

      end;
      FormMain.TBGoForward.Enabled := ForwardEnabled;
      //if not ForwardEnabled then FormMain.ImageGoForward.Picture := FormMain.ImageGoForward0.Picture;
    end;
  end;
except end;
end;

procedure TFormWebBrowser.WebBrowser1DownloadBegin(Sender: TObject);
var
  Url: string;
  I: integer;
  H: THandle;
begin
try
  if CloseApp then exit;
  if Closeing then exit;
  if wbList.Count = 0 then exit;
  //if StatusTextEnabled then exit;
  if wbList.IndexOf(Self) = PageIndex then
  begin
    {
    if (Trim(StatusText) <> '') and (Trim(StatusText) <> 'about:blank') then
    Url := StatusText
    else
    }
    
    Url := Trim(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationURL);
    //
    for I := 0 to WhiteList.Count - 1 do //ShowMessage(Copy(WhiteList[I], 2, Length(WhiteList[I]) - 1));
    if (Pos(Copy(WhiteList[I], 2, Length(WhiteList[I]) - 1), Url) <> 0)  or (Pos(WhiteList[I], Url) <> 0) then
    begin
      TFormWebBrowser(wbList[PageIndex]).CleanADWhite := true;
      TFormWebBrowser(wbList[PageIndex]).NoCleanFlash := true;
      FormMain.ToolBarStatusBar.Repaint;
    end;

    if ((Trim(Url) <> '') and (LowerCase(Trim(Url)) <> 'about:blank')) then
    begin
      //if Url <> InitPage then FormMain.StatusBar.Panels[0].Text := '>>正在连接地址:' + '<' + Url + '>';
      //if FormMain.Active then DocumentSetfocus;
      //if CurrentDocumentFocus then

      H := FormMain.CBUrl.Handle;
      if not IsChild(h, GetFocus) then
      FormMain.CBURL.Text := Url;

      if wbList.Count = 1 then
      begin
        FormMain.CBURL.Text := Url;
        FormPublic.DocumentSetFocus;
      end;
    end
    else
    begin
      if wbList.Count = 1 then
      begin
        if TFormWebBrowser(wbList[PageIndex]).WebUrl = 'init' then
        begin
          FormMain.CBURL.Text := 'init';
          FormPublic.DocumentSetFocus;
        end;
        if HoldOneTab then
        begin
          exit;
        end;
      end;
    end;
  end;
except end;
end;

procedure TFormWebBrowser.WebBrowser1DownloadComplete(Sender: TObject);
var
  Title, Url:string;
  I: Integer;
  I2: Integer;
  //H: THandle;
  //I_11: Integer;
  //Str_11: String;
  //Str: string;
begin
try
  if Closeing then exit;
  //if StatusTextEnabled then exit;
  if CloseApp then exit;             
  if wbList.Count = 0 then exit
  else if wbList.Count > 2 then if Closeing then exit;
  try
  if wbList.IndexOf(Self) = PageIndex then
  begin
    Title := WebTitle;
    if (Trim(Title) = '') or (Trim(Title)  ='about:blank') then
    Title := Trim(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationName);

    Url := Trim(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationURL);
    if ((Trim(Url) = '') or (Trim(Url) = 'about:blank')) then
    Url := WebUrl;

    if LoadLastOpenFlag then                        //ShowMessage(MyDir + DataDir + '\' + LastOpenLoadFile);
    if {(wbList.Count = 1) and} (Pos('/' + DataDir + '/' + LastOpenLoadFile, Url) <> 0) then
    begin   
      if LoadLastOpenOK then
      begin

      //if (TFormWebBrowser(wbList[PageIndex]).WebUrl <> 'init') then
      //begin
      FormMain.CBURL.Text := 'about:blank';
      FormMain.CBURL.SetFocus;
      //end;
      end
      else
      begin
      //if (TFormWebBrowser(wbList[PageIndex]).WebUrl <> 'init') then
      //begin
      FormMain.CBURL.Text := BrowserName + '://Data/' + LastOpenLoadFile;
      FormPublic.DocumentSetFocus;
      //end;
      end;
      exit;
    end;
    //LastOpenLoadFile

    {
    if (wbList.Count = 1) then
    begin
      case StartPageTo of
      1:
      begin    
        //if (TFormWebBrowser(wbList[PageIndex]).WebBrowser.Hint = 'init') then
        if (TFormWebBrowser(wbList[PageIndex]).WebUrl = 'init') and (StartPageTo = 1) then
        begin
          FormMain.CBURL.Text := 'init';
          FormPublic.DocumentSetFocus;   
          exit;
        end;
      end;
      2:
      begin
        if (TFormWebBrowser(wbList[PageIndex]).WebBrowser.Hint = 'OPENTOURL') then
        begin
          FormMain.CBURL.Text := OpenToUrl;
          exit;
        end;
      end;
      end;
    end;
    }

    Title := FormPublic.KBDString(Title);
    Url := FormPublic.KBDString(Url);

    if ((Trim(Url) <> '') and (Trim(Url) <> 'about:blank')) then
    begin
      {
      if EnableTitle then
      begin
        if Length(Title) <= 52 then
        FormMain.Caption := Title + '  -  ' + TitleStr
        else
        FormMain.Caption := Copy(Title, 0, 52) + '...' + '  -  ' + TitleStr;
      end;
      }
      //{
      if not IsChild(FormMain.CBUrl.Handle, GetFocus) then 
      begin
        if wbList.Count = 1 then
        begin
          if (TFormWebBrowser(wbList[0]).WebUrl = 'init') and (StartPageTo = 1) then
          begin
            FormMain.CBURL.Text := 'init';
            //TFormWebBrowser(wbList[0]).WebBrowser
          end;
        end
        else
        FormMain.CBURL.Text := Url;
      end;
      //}

      if EnableTitle then
      begin
        {
        if Length(Title) <= 52 then
        FormMain.Caption := Title + '  -  ' + TitleStr
        else
        FormMain.Caption := Copy(Title, 0, 52) + '...' + '  -  ' + TitleStr;
        }
        //if ShowMenu then
        //if Length(Title) > 80 then Title := Copy(Title,1,80) + '...';
        case LANGUAGE of
        0,1: FormMain.Caption := TitleStr + '  -  ' + Title;
        2,3: FormMain.Caption := BrowserName + '  -  ' + Title;
        99: FormMain.Caption := BrowserName + '  -  ' + Title;
        end;
      end;
        {
        if ShowWebIcon then
        begin
          Case WebIconNeedBlankCount of
          2: Title := Copy(Title, 3, 22);
          3: Title := Copy(Title, 4, 22);
          4: Title := Copy(Title, 5, 22);
          5: Title := Copy(Title, 6, 22);
          6: Title := Copy(Title, 7, 22);
          end;
        end;
        }

      FormMain.Panel_StatusBar1.Caption := ' >>' + '完成:' + Title + '<' + Url + '>';     //kokoko
      {
        if FormMain.Active then
        if TEmbeddedWB(WBList[CurrentIndex]).Document<>nil then
        IHTMLWindow2(IHTMLDocument2(TEmbeddedWB(WBList[CurrentIndex]).Document).ParentWindow).focus;
      }
      //ClearAd(TEmbeddedWB(WBList[CurrentIndex]));
    end
    else
    begin
      if wbList.Count = 1 then
      begin
        {
        if HoldOneTab then
        begin
          if Url = InitPage then
          begin
            FormMain.CBURL.Text := InitPage;
            //if FormMain.Active then FormWebbrowser.DocumentSetFocus;
          end
          else
          begin
            FormMain.CBURL.Text := 'about:blank';
            FormMain.StatusBar.Panels[0].Text := '';
            WebTitle := '';
            Url:='';
          end;
        end
        else
        begin
          if not TFormWebBrowser(wbList[PageIndex]).WebBrowser.Busy then
          begin
            FormMain.CBURL.Text := 'about:blank';
            FormMain.StatusBar.Panels[0].Text := '';
            WebTitle := '';
            Url:='';
          end;
        end;
        }
      end;
      if ((ProBar<>nil) and (ProBar.Visible)) then
      begin
        ProBar.Position := 0;
        ProBar.Visible := false;
        //LabelPro.Visible := false;
      end;
    end;
  end;
    {
    if (FormMain.CBURL.Items.Count>0) and (Trim(SUrl)<>'') then
    begin
      for i:=0 to FormMain.CBURL.Items.Count-1 do
      begin
        if SUrl=FormMain.CBURL.Items[i] then exit;
      end;
    end;
    if (Trim(SUrl)<>'') then
    FormMain.CBURL.Items.Add(SUrl);
    SUrl:='';
    }
    {
    if ((Sender as TEmbeddedWB).Hint <> '') and ((Sender as TEmbeddedWB).Hint <> 'SEARCH') then
    if not FileExists(TempDir + (Sender as TEmbeddedWB).Hint) then
    else
    begin
      FormMain.ImageWebIcon.Picture.LoadFromFile(TempDir + (Sender as TEmbeddedWB).Hint);
      if (FormMain.ImageWebIcon.Height <> 16) or (FormMain.ImageWebIcon.Width <> 16) then
      begin
        //FormMain.ImageWebIcon.Picture.LoadFromFile(FormMain.ImageWebIcon2.Picture.Icon);
        FormPublic.GetWebIconOK := true;
        exit;
      end;
      FormMain.ImageListWebIcon.ReplaceIcon(FormPublic.WebIndex, FormMain.ImageWebIcon.Picture.Icon);
      FormMain.ToolBarTabParent.Repaint;
      FormPublic.GetWebIconOK := true;
    end;
    }
  finally
    //FormMain.ToolBarMenu.Repaint;
    I2 := wbList.IndexOf(Self);
    if (wbList.Count = 1) or (I2 = 0) then
    if (ShowWebIcon) and (not TFormWebBrowser(wbList[I2]).DownIcon) {and (TFormWebBrowser(wbList[I2]).WebBrowser.LocationURL <> 'about:blank')} then
    if (TFormWebBrowser(wbList[I2]).WebBrowser.LocationURL <> '') and (TFormWebBrowser(wbList[I2]).WebBrowser.LocationURL <> 'about:blank') then
    begin
      {
      if Trim(TFormWebBrowser(wbList[wbList.IndexOf(Self)]).WebBrowser.LocationURL) <> 'about:blank' then
      FormPublic.GetWebIcon2(wbList.IndexOf(Self), TFormWebBrowser(wbList[wbList.IndexOf(Self)]).WebBrowser.LocationURL);
      }
      //if ((Sender as TEmbeddedWB).LocationURL <> 'about:blank') then
      //FormPublic.GetWebIcon2(wbList.IndexOf(Self), (Sender as TEmbeddedWB).LocationURL);
      //{
      TFormWebBrowser(wbList[I2]).DownIcon := true;
      FormPublic.WebIndex := I2; //wbList.IndexOf(Self);
      FormPublic.WebUrl := TFormWebBrowser(wbList[I2{wbList.IndexOf(Self)}]).WebBrowser.LocationURL;
      //ShowMessage(IntToStr(I2));
      //WebIconFile := 'WebIcon' + IntToStr(RanDom(999999999)) + '.ico';
      //TFormWebBrowser(wbList[wbList.IndexOf(Self)]).WebBrowser.Hint := WebIconFile;
      ThreadI := 9;
      RunProcess.Create(False);
      //FormPublic.GetWebIconOK
      //}
    end;
    end;
    if {(Trim(Url) <> '') and (Trim(Url) <> 'about:blank') and} ((Sender as TEmbeddedWB).Hint <> ':file') then
    begin
    if (not CleanADWhite) {and (TFormWebBrowser(wbList[I2]).NoCleanAd)} then
    begin
      ClearAd((Sender as TEmbeddedWB), TFormWebBrowser(wbList[I2]).NoCleanFlash);
      //TFormWebBrowser(wbList[I2]).NoCleanAd := false;
    end;
    {
    if (Trim(Url) <> '') and (Trim(Url) <> 'about:blank') and ((Sender as TEmbeddedWB).Hint <> ':file') then
    begin
    if (not CleanADWhite) and (TFormWebBrowser(wbList[I2]).NoCleanAd) then
    begin
      ClearAd((Sender as TEmbeddedWB), TFormWebBrowser(wbList[I2]).NoCleanFlash);
      //if not TFormWebBrowser(wbList[PageIndex]).NoCleanAd then exit;
      TFormWebBrowser(wbList[I2]).NoCleanAd := false;
    end;
    }
    {
    if LowerCase((sender as TEmbeddedWB).LocationURL)<>'about:blank' then
    begin
      (sender as TEmbeddedWB).DefaultInterface.Left := 0;
      (sender as TEmbeddedWB).DefaultInterface.Top  := 0;
    end;
    }
    {
    if FormMain.PageControl.PageCount<=2 then
    FormMain.OpenURLListSave(1)
    else //if FormMain.PclParent.PageCount>1 then
    FormMain.OpenURLListSave(2);
    }

    {
    H := FormMain.CBUrl.Handle;
    if not IsChild(h, GetFocus) then
    if wbList.IndexOf(Self) = PageIndex then
    begin
      H := TFormWebBrowser(wbList[PageIndex]).WebBrowser.Handle;
      if not IsChild(h, GetFocus) then
      begin
        if LowerCase(Trim(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationURL)) <> 'about:blank' then
        if FormMain.Active then
        FormPublic.DocumentSetFocus;
      end;
    end;
    }
    {
    Url := (Sender as TEmbeddedWB).LocationURL;
    if EnabledGGHideSearch then
    if Pos('http://www.baidu.com/s?', Url) <> 0 then
    begin
      //http://www.baidu.com/s?wd=999&cl=3
      //http://www.baidu.com/s?ie=gb2312&bs=%D6%D0%B9%FA&sr=&z=&cl=3&f=8&wd=%D6%D0%B9%FA&ct=0
      I_11 := Pos('wd=', Url);
      if I_11 <> 0 then
      begin         //ShowMessage(IntToStr(I11));
        Str_11 := Copy(Url, I_11 + 3, Length(Url));    //ShowMessage(Str11);
        I_11 := Pos('&', Str_11);   //ShowMessage(IntToStr(I11));
        if I_11 <> 0 then
        begin
          Str_11 := Copy(Str_11, 1, I_11 - 1);
          //ShowMessage(Str11);

          Url := StringReplace(SearchID2Url, 'KEYWORD_', Str_11, [rfReplaceAll,rfIgnoreCase]);
          //FormPublic.NewPage(PageIndex + 1, Url, True);
          //TFormWebBrowser(wbList[PageIndex]).WebBrowser.Navigate(Url);
          FormMain.WBInitPage.Navigate(Url);
          FormMain.WBInitPage.HandleNeeded;
          //ShowMessage(Url);
          //exit;
                   
        end;
      end;
    end;
    }

  end;

except
  //ShowMessage('error.');
end;
end;

procedure TFormWebBrowser.WebBrowser1DocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
  Title: String;
  H: THandle;
  //Str: String;
begin
try   
  if wbList.Count = 0 then exit;
  //if Closeing then exit;
  if CloseApp then exit;
  if Closeing then exit;
    //Title := (Sender as TEmbeddedWB).LocationName;
  //if ((Sender as TEmbeddedWB).Tag = CloseTag) then exit;
  try
  //Str := (Sender as TEmbeddedWB).Hint;
  if wbList.IndexOf(Self) = PageIndex then
  begin
    Title := TFormWebBrowser(wbList[PageIndex]).WebTitle;
    {
    if (Title = 'http 404 未找到') or (Title = 'internet explorer 无法显示该网页') then
    begin
      (Sender as TEmbeddedWB).Go('http://www.te99.com');
      exit;
    end;
    }
    if EnableTitle then
    begin
      {
      if Length(Title) <= 52 then
      FormMain.Caption := Title + '  -  ' + TitleStr
      else
      FormMain.Caption := Copy(Title, 0, 52) + '...' + '  -  ' + TitleStr;
      }
      //FormMain.Caption := TitleStr + '  -  ' + Title;
        //if ShowMenu then
        //if Length(Title) > 80 then Title := Copy(Title,1,80) + '...';
        case LANGUAGE of
        0,1: FormMain.Caption := TitleStr + '  -  ' + Title;
        2,3: FormMain.Caption := BrowserName + '  -  ' + Title;
        99: FormMain.Caption := BrowserName + '  -  ' + Title;
        end;
    end;
    if ((Sender as TEmbeddedWB).Hint = ':BLANK') then
    begin
      FormMain.CBURL.Text := 'about:blank';
      (Sender as TEmbeddedWB).Hint := '';
    end;
  end;
  //if Closeing then exit;
  //if StatusTextEnabled then exit;
    if wbList.Count <= 2 then
    FormPublic.OpenURLListSave(1)
    else 
    FormPublic.OpenURLListSave(2);
  finally
    //if wbList.Count > 1 then FormPublic.TabClick2(999);
    FormMain.ToolBarMenu.Repaint;
    //FormMain.ProBar.Hide;
    //if (wbList.Count = 1) then
    //if TFormWebBrowser(wbList[0]).WebBrowser.LocationUrl = 'about:blank' then FormMain.CBURL.Text := 'about:blank';

    //if FormMain.NStopPopup.Checked then

    if (wbList.Count = 1) then
    begin
      if ((Sender as TEmbeddedWB).Hint = 'Close0') or (((Sender as TEmbeddedWB).Hint = ':BLANK')) then
      begin
        FormMain.CBURL.Text := 'about:blank';
        FormPublic.DocumentSetFocus;
        (Sender as TEmbeddedWB).Hint := '';
      end;
    end
    else
    begin
    //{
    H := FormMain.CBUrl.Handle;
    if not IsChild(h, GetFocus) then
    if wbList.IndexOf(Self) = PageIndex then
    begin
      H := TFormWebBrowser(wbList[PageIndex]).WebBrowser.Handle;
      if not IsChild(h, GetFocus) then
      begin
        if LowerCase(Trim(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationURL)) <> 'about:blank' then
        if FormMain.Active then
        FormPublic.DocumentSetFocus;      //sfsdf 如果忙时不SET CBUR.TEXT
      end;
    end;
    //}
    end;
    if PageUnLock then FormPublic.NUnLockWebPage.OnClick(Sender);
    //if wbList.Count = 1 then  FormMain.ToolBarAddress.Repaint;

    //if (sender as TEmbeddedWB).Document = nil then exit;
    (sender as TEmbeddedWB).OleObject.Document.Body.Style.Zoom := ZoomStr;
    if ((sender as TEmbeddedWB).Tag <> LastUnCloseFlag) then (sender as TEmbeddedWB).Tag := ZoomTag;
    if gotonewpage then
    begin
      FormMain.ToolButton100.Caption := ZoomStr;
      FormMain.ToolButton100.Hint := ZoomStr;
    end;
  end;
except end;
end;

procedure TFormWebBrowser.WebBrowser1NavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
  //H:THandle;
  I: integer;
  Str: String;
begin
try
  {
  FormMain.Caption := IntToStr(RanDom(99999));
  FormMain.ToolBarMenu.Repaint;
  }
  if Closeing then exit;
  if CloseApp then exit;
  if wbList.Count = 0 then exit;
  if (Sender as TEmbeddedWB).Hint = 'NAVIGATE_OK' then exit;
  //if (Sender as TEmbeddedWB).Hint = 'NAVIGATE_OK+SEARCH' then exit;
  //if (Sender as TEmbeddedWB).Hint = 'SEARCH' then (Sender as TEmbeddedWB).Hint := 'NAVIGATE_OK+SEARCH' else
  try
  {
  H := FormMain.CBUrl.Handle;
  if IsChild(h, GetFocus) then exit;
  if wbList.IndexOf(Self) = PageIndex then
  begin
    H := TFormWebBrowser(wbList[PageIndex]).WebBrowser.Handle;
    if not IsChild(h, GetFocus) then
    begin
      if LowerCase(Trim(TFormWebBrowser(wbList[PageIndex]).WebBrowser.LocationURL)) <> 'about:blank' then
      if FormMain.Active then
      FormPublic.DocumentSetFocus;      //sfsdf 如果忙时不SET CBUR.TEXT
    end;
    //ClearAd(TEmbeddedWB(WBList[CurrentIndex]));
  end;
  }
  {
    if TEmbeddedWB(wbList[PageIndex]).LocationURL = InitPage then
    begin
      FormMain.CBURL.Text := InitPage;
    end;
  }
  {
  if ((ProBar<>nil) and (ProBar.Visible)) then
  begin
    ProBar.Position := 0;
    ProBar.Visible := false;
    //LabelPro.Visible := false;
  end;
  }
  finally
    if ShowWebIcon then
    begin
      I := wbList.IndexOf(Self);
      Str := TFormWebBrowser(wbList[I]).WebBrowser.LocationURL;
      if (Str <> 'about:blank') then
      begin
        TFormWebBrowser(wbList[I]).WebUrl := Str;
        (Sender as TEmbeddedWB).Hint := 'NAVIGATE_OK';
        if I > 0 then
        if (not TFormWebBrowser(wbList[I]).DownIcon) and (not TFormWebBrowser(wbList[I]).Closeing) then
        begin
          TFormWebBrowser(wbList[I]).DownIcon := true;
          FormPublic.WebIndex := I;
          FormPublic.WebUrl := Str;
          //WebIconFile := 'WebIcon' + IntToStr(RanDom(999999999)) + '.ico';
          //TFormWebBrowser(wbList[wbList.IndexOf(Self)]).WebBrowser.Hint := WebIconFile;
          ThreadI := 9;
          RunProcess.Create(False);
          //FormPublic.GetWebIconOK
          //}
        end;
      {
      if not IsChild(FormMain.CBUrl.Handle, GetFocus) then
      begin
        if wbList.Count = 1 then
        begin
        end
        else
        FormMain.CBURL.Text := Str;
      end;
      }
      end;
    end;
  end;
except end;
end;

procedure TFormWebBrowser.WebBrowser1NewWindow2(Sender: TObject;
  var ppDisp: IDispatch; var Cancel: WordBool);
var
  I: Integer;
begin
try
  try
  //if CloseApp then exit;
  //StopPopup := true;
  //if not StopPopup then halt;
  {
  if (GISPop) and (wbList.IndexOf(Self) = PageIndex) then
  begin
    Cancel:=true;
    ppDisp := nil;
    GISPop := false;
    exit;
  end;
  }
  //{
  if StopPopup {or StopPopupO2} then
  begin
    //showmessage('kl');

    //if (not StopPopupMode1) and (not StopPopupMode2) then exit;
    if (wbList.IndexOf(Self) <> PageIndex) then
    begin
      //if IsPopup then halt;
      if (not CleanADWhite) then   //ddddddddddddddddddddd
      begin
        IsPopup := true;
        Cancel:=true;
        ppDisp := nil;
        exit;
      end;
      //else TFormWebBrowser(wbList[wbList.IndexOf(Self)]).IsPopup := false;
    end
    //else if CleanADWhite then IsPopup := false;
    else
    //if StopPopupMode2 then
    begin
      if {TFormWebBrowser(wbList[PageIndex]).}IsPopup and (not CleanADWhite) then   
      begin
        //IsPopup := true;
        //GISPop := false;
        Cancel:=true;
        ppDisp := nil;
        exit;
      end;
    end;
  end;
  {
  else
  begin

  end;
  }
  //}
  {
  //if not StopPopup then halt;
  if StopPopup then
  begin
    if IsPopup and (not CleanADWhite) then
    begin
      //IsPopup := true;
      Cancel:=true;
      ppDisp := nil;
      exit;
    end;
  end;
  }
  //LockWindowUpdate(Form.Handle);
  //NewPage;
  {
  if IsPopup then
  else
  }
  if StopPopup then IsPopup:=true;
  //if (Sender as TEmbeddedWB).Hint = BlackListTag then (Sender as TEmbeddedWB).Hint := '';
  //if Pos('上次退出未关闭页', FormMain.Caption) = 0 then exit else FormMain.Caption := '999999999999999';
  FormPublic.NewPage(PageIndex + 1, '', GoToNewPage);
  //===
  if AppendTab then
  begin
  if GoToNewPage then
  I := PageIndex
  else
  I := PageIndex + 1;
  end
  else
  begin
  if GoToNewPage then
  I := PageIndex
  else
  I := wbList.Count - 1;
  end;
      //ddddddddd
  //===
  //TFormWebBrowser(wbList[I]).WebBrowser.Go('about:blank');
                      //ShowMessage(CurrentUrl);
  TFormWebBrowser(wbList[I]).WebUrl := CurrentUrl;    

  ppDisp := TFormWebBrowser(wbList[I]).WebBrowser.DefaultDispatch;//_ppDisp;

  if StopPopup then IsPopup:=true;
  LockWindowUpdate(FormMain.PanelWBMain.Handle);
  if not GoToNewPage then TFormWebBrowser(wbList[I]).WebBrowser.HandleNeeded;
  //DocumentSetFocus2(I);
  finally
    LockWindowUpdate(0);
    FormPublic.DocumentSetFocus;
  end;
except end;
end;

{
function TFormWebBrowser.GetppDisp:IDispatch;
var
  I: Integer;
begin
try
  if GoToNewPage then
  I := PageIndex
  else
  I := PageIndex + 1;   
  //else
  //I := wbList.Count - 1;           

  Result := TFormWebBrowser(wbList[I]).WebBrowser.Application;
  //result:=TEmbeddedWB(WBList[i]).Application;
  //i:=FormMain.PageControl.PageCount-1;

  if GoToNewPage then
  begin
    FormMain.ToolBarTabParent.Buttons[I].Click;
    DocumentSetFocus;
  end
  else
  begin
    //{
    LockWindowUpdate(FormMain.Handle);
    try
    TFormWebBrowser(wbList[I]).WebBrowser.HandleNeeded;  //TEmbeddedWB(WBList[I]).HandleNeeded;
    //TFormWebBrowser(wbList[I]).WebBrowser.Show;
    //TFormWebBrowser(wbList[I]).WebBrowser.Hide;
    TFormWebBrowser(wbList[I]).WebBrowser.HandleNeeded;
    finally
      LockWindowUpdate(0);
      //Form.Perform(WM_SETREDRAW,1,0);
      //RedrawWindow(Handle,nil,0,RDW_FRAME+RDW_INVALIDATE+RDW_ALLCHILDREN+RDW_NOINTERNALPAINT);
    end;
  end;
except end;
end;
}

procedure TFormWebBrowser.WebBrowser1ProgressChange(Sender: TObject;
  Progress, ProgressMax: Integer);
begin
try
  if CloseApp then exit;
  if wbList.Count <= 0 then exit;
  if Closeing then
  begin
    {
    if ((ProBar<>nil) and (ProBar.Visible)) then
    begin
      ProBar.Position := 0;
      ProBar.Visible := false;
      //LabelPro.Visible := false;
    end;
    }
    if  (ProBar <> nil) and (ProBar.Visible) then    
    begin       
      ProBar.Position := 0;
      ProBar.Visible := false;
      //if LabelPro.Visible then LabelPro.Visible := false;
    end;
    exit;
  end;
  if wbList.IndexOf(Self) = PageIndex then  
  begin
    if probar <> nil then
    begin
      //{
      if ProgressMax - Progress <= 2 then
      begin
        LabelPro.Caption := '100%';
        ProBar.Visible := false;
        //LabelPro.Visible := false;
        exit;                         
      end;
      if not ProBar.Visible then ProBar.Show;
      if not LabelPro.Visible then LabelPro.Show;
      //probar.Position := 0;
      if probar.max <> ProgressMax then
      probar.max := ProgressMax;
      //if not ProBar.Smooth then probar.Smooth := true;
      probar.position := Progress;
      LabelPro.Caption := IntToStr((Progress * 100) div ProgressMax) + '%';
      //}
    end;
    {
    else
    begin
      probar := TProgressBar.create(self);
      probar.parent := FormMain.StatusBar;
      //probar.parent := FormMain.StatusBar.Panels[1];
      probar.min := 0;
      if probar.max <> ProgressMax then
      probar.max := ProgressMax;
      probar.Smooth :=  true;
      probar.height := FormMain.StatusBar.Height - 2;
      probar.width := FormMain.StatusBar.Panels[1].Width;
      probar.left := FormMain.StatusBar.Panels[0].Width;
      probar.top := 0+2;
      probar.position := 0;
      probar.Visible := true;
      LabelPro := TLabel.Create(Self);
      LabelPro.Transparent := true;
      LabelPro.Parent := ProBar;
      LabelPro.Left := 0 + (ProBar.Width div 2) - (LabelPro.Width div 2);
      //LabelPro.Top := ProBar.Top + 4;
      LabelPro.Top := ProBar.Top + (ProBar.Height div 2) - (LabelPro.Height div 2);
    end;
    }
  end;
except
  ProBar.Position := 0;
  ProBar.Visible := false;
  //LabelPro.Visible := false;
end;
end;

function TFormWebBrowser.WebBrowser1ShowContextMenu(const dwID: Cardinal;
  const ppt: PPoint; const pcmdtReserved: IInterface;
  const pdispReserved: IDispatch): HRESULT;
begin
try
  if CanShowContextMenu then
  Result:=S_FALSE //让菜单能够弹出
  else
  Result:=S_OK;  //禁止菜单弹出
except end;
end;

procedure TFormWebBrowser.WebBrowser1ScriptError(Sender: TObject; ErrorLine,
  ErrorCharacter, ErrorCode, ErrorMessage, ErrorUrl: String;
  var ContinueScript, Showdialog: Boolean);
begin
try
  {
  if CloseApp then exit;
  if Closeing then exit;
  }
  ContinueScript:=true;
  Showdialog:=false;
except end;
end;

procedure TFormWebBrowser.WebBrowser1CloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
try
  if CloseApp then exit;
  if Closeing then exit;
  CanClose:=False;
  FormPublic.ClosePage(wbList.IndexOf(Self));
except end;
end;

procedure TFormWebBrowser.WebBrowser1StatusTextChange(Sender: TObject;
  const Text: WideString);
var
  Str: String;
  I: Integer;
begin
try
  if CloseApp then exit;
  if Closeing then exit;

  if (not StatusTextEnabled) {and (not PagePreview)} then exit;
  //if (wbList.Count = 1) and (EnabledInitPage) and (WebUrl = InitPage) then exit;
  try
  if wbList.IndexOf(Self) = PageIndex then
  begin
    if (Trim(Text) = '') or (Trim(Text) = '完毕') then
    begin
      FormMain.Panel_StatusBar1.Caption := ' .';
      exit;
    end;
    //if (wbList.Count = 1) and (EnabledInitPage) and (WebUrl = InitPage) then exit;
    //StatusText := Text;
    CurrentUrl := Str;
    Str := '>>' + Text;
    //OldStatusText := Str;
    //FormMain.TimerPagePreview.Enabled := true;
    if StatusTextEnabled then
    begin
      Str := FormPublic.KBDString(Str);
      FormMain.Panel_StatusBar1.Caption := ' ' + Str;
    end;
  end;
  finally
    {
    if ShowCloseHint then
    begin
      if FormMain.ToolBarTabClose.Visible then FormMain.ToolBarTabClose.Visible := false;
    end;
    }
  end;
except end;
end;

function TFormWebBrowser.WebBrowser1GetExternal(
  out ppDispatch: IDispatch): HRESULT;
var
  MyIDispatch : TTBrowserToDelphi;
begin
try
  if CloseApp then exit;
  if Closeing then exit;
  MyIDispatch := TTBrowserToDelphi.Create;
  ppDispatch := MyIDispatch;
  result := S_OK;
except end;
end;

{
procedure TFormWebBrowser.WebBrowser1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
try
  //Accept := true;
except end;
end;
}

procedure TFormWebBrowser.WebBrowser1BeforeNavigate2(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
{
var
  i: integer;
  Str: string;
  }
begin
try
  exit;
  {
  if not StopPopupO2 then exit;
  if BlackList.Count <=0 then exit;
  for i := 0 to BlackList.Count - 1 do
  begin
    Str := BlackList[i];
    if Pos(Str, Url) <> 0 then
    begin
      //GISPop := true;
      //TFormWebBrowser(wbList[wbList.IndexOf(Self)]).IsPopup := true;
      //TFormWebBrowser(wbList[wbList.IndexOf(Self)]).CleanADWhite := false;
      //if wbList.IndexOf(Self) = PageIndex then
      //(Sender as TEmbeddedWB).Hint := BlackListTag;
      //if wbList.IndexOf(Self) = PageIndex then GISPop := true; // else GISPop := false;
      Cancel := true;
      //GISPop := false;
      Break;
      exit;
    end;
  end;
  }
  {
  if FormPublic.EnabledDownExt(Url) then //if Pos('.exe', Url) <> 0 then
  begin
    Cancel := true;
    //ShowMessage(Url);
    ShellExecute(0, 'open', PChar(KEY_URL_GSDown+'://'+String(Url)), nil, nil, SW_NORMAL);
    //kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
  end;
  }
except end;
end;

end.
