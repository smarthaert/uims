unit U_WebForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, EmbeddedWB, U_MutiPageWebBrowser, ComCtrls,
  CommCtrl, MSHTML_TLB, Activex, StdCtrls, U_PublicInterface;

Const
  C_BLANKADDR = 'about:blank';
  True = Boolean(1);
  False = Boolean(0);

  C_BUTTONTEXTWIDTH = 10;

type

  TFrmWeb = Class;

  TWebToolButton = Class(TToolButton)
  private
    FWebForm: TFrmWeb;
  protected
    procedure Message_CheckButton(var Message: TMessage); message TB_CHECKBUTTON;
  public
    constructor Create(AOwner: TComponent); override;
    property OnDblClick;
    property WebForm: TFrmWeb read FWebForm write FWebForm;
  End;

  TFrmWeb = class(TForm, IDropTarget)
    WebBrowser: TEmbeddedWB;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WebBrowserNewWindow2(Sender: TObject; var ppDisp: IDispatch;
      var Cancel: WordBool);
    procedure FormActivate(Sender: TObject);
    procedure WebBrowserNavigateComplete2(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure WebBrowserBeforeNavigate2(Sender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    function WebBrowserGetDropTarget(const pDropTarget: IDropTarget;
      out ppDropTarget: IDropTarget): HRESULT;
    procedure WebBrowserProgressChange(Sender: TObject; Progress,
      ProgressMax: Integer);
    procedure WebBrowserStatusTextChange(Sender: TObject;
      const Text: WideString);
    procedure WebBrowserCommandStateChange(Sender: TObject;
      Command: Integer; Enable: WordBool);
    function WebBrowserTranslateAccelerator(const lpMsg: PMsg;
      const pguidCmdGroup: PGUID; const nCmdID: Cardinal): HRESULT;
    procedure FormDestroy(Sender: TObject);
    procedure WebBrowserDocumentComplete(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
  private
    FMainUiHandler : IMainUiHandler;
    FProgress: Integer;
    FWebTitle: String;
    FWebUrl: String;
    FPageItemImageIndex: Integer;
    function GetIsBlank: Boolean;
    function GetWebTitle: String;
    function GetWebUrl: string;
    procedure RefreshUi;
    procedure SetPageItemImageIndex(const Value: Integer);
    procedure SetWebUrl(const Value: string);
    { Private declarations }
  protected
    function IDropTarget.DragEnter = IDropTarget_DragEnter;
    function IDropTarget.DragLeave = IDropTarget_DragLeave;
    function IDropTarget.DragOver = IDropTarget_DragOver;
    function IDropTarget.Drop = IDropTarget_Drop;
    function IDropTarget_DragEnter(const dataObj: IDataObject; grfKeyState:
        Longint; pt: TPoint; var dwEffect: Longint): HResult; stdcall;
    function IDropTarget_DragLeave: HResult; stdcall;
    function IDropTarget_DragOver(grfKeyState: Longint; pt: TPoint; var dwEffect:
        Longint): HResult; stdcall;
    function IDropTarget_Drop(const dataObj: IDataObject; grfKeyState: Longint; pt:
        TPoint; var dwEffect: Longint): HResult; stdcall;
  public
    constructor Create(UrlStr: String; IsActive: Boolean; MainUi: IMainUiHandler);
    destructor Destroy; override;
    procedure Go(aUrlStr: String; OpenNewPage: Boolean);
    procedure ToolButtonDBClick(Sender: TObject);
    procedure GoBack;
    procedure GoForward;
    procedure LoadOption;
    procedure Refresh;
    procedure ShowWebForm;
    procedure Stop;
    procedure WndProc(Var Message: TMessage); override;
    property WebUrl: string read GetWebUrl write SetWebUrl;
    property IsBlank: Boolean read GetIsBlank;
    property PageItemImageIndex: Integer read FPageItemImageIndex write
        SetPageItemImageIndex;
    property Progress: Integer read FProgress;
    property WebTitle: String read GetWebTitle write FWebTitle;
    { Public declarations }
  end;

function ShortenString(aStr: String): string;

{-------------------------------------------------------------------------------
  说明:      保护模式执行一个过程
  参数:      Proc: TThreadMethod
  返回值:    Boolean
  备注:
-------------------------------------------------------------------------------}
function SafeExecuteProc(Proc: TThreadMethod): Boolean;

Var
  CF_URL: UINT;
  URLFormatEtc, TextFormatEtc: TFormatEtc;


implementation

uses U_FrmMain, StrUtils, U_UserConfig, U_PublicUnit;

{$R *.dfm}

function ShortenString(aStr: String): string;
Var
  I: Integer;
  eStr: String;
begin
  If Length(aStr) > C_BUTTONTEXTWIDTH Then
    Result := Copy(aStr, 1, C_BUTTONTEXTWIDTH - 3) + '...'
  Else Begin
    For I := 0 To (C_BUTTONTEXTWIDTH - Length(aStr)) div 2 Do
      eStr := eStr + ' ';

    Result := eStr + aStr + eStr;
  End;
end;

function SafeExecuteProc(Proc: TThreadMethod): Boolean;
begin
  Try
    Proc;
    Result:= True;
  Except
   On E: Exception Do
   Begin
     Result:= False;
     
   End;
  End;
end;

constructor TWebToolButton.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csDoubleClicks];
end;


procedure TWebToolButton.Message_CheckButton(var Message: TMessage);
begin
  inherited;
  If (Index = Message.LParam) And (Boolean(Message.WParam)) Then
  Begin
    If (Not FWebForm.Active) And Assigned(OnClick) Then
      OnClick(Self);
  End;
end;


constructor TFrmWeb.Create(UrlStr: String; IsActive: Boolean; MainUi:
    IMainUiHandler);
begin
  FMainUiHandler := MainUi;

  FMainUiHandler.PageControl.InsertPage(UrlStr, Self);

  FWebUrl := UrlStr;
  FWebTitle := UrlStr;

  inherited Create(Nil);

  LoadOption;

  If IsActive Then
    ShowWebForm;

  Go(FWebUrl, False);

  RefreshUi;

end;

destructor TFrmWeb.Destroy;
begin
  inherited;
end;



procedure TFrmWeb.RefreshUi;
Var
  eCaption, eAddr: String;
begin
  eCaption := WebTitle;
  eAddr := WebUrl;

  FMainUiHandler.PageControl.SetPageText(Self, (eCaption));

  Caption := eCaption;


  If Active And FormatUrl(eAddr) Then
    FMainUiHandler.ChangeAddress(eAddr);
  
end;

function TFrmWeb.IDropTarget_DragEnter(const dataObj: IDataObject; grfKeyState:
    Longint; pt: TPoint; var dwEffect: Longint): HResult;
begin
  Result := S_OK;
end;

function TFrmWeb.IDropTarget_DragLeave: HResult;
begin
  Result := S_OK;
end;

function TFrmWeb.IDropTarget_DragOver(grfKeyState: Longint; pt: TPoint; var
    dwEffect: Longint): HResult;
begin
  Result := S_OK;
end;

function TFrmWeb.IDropTarget_Drop(const dataObj: IDataObject; grfKeyState:
    Longint; pt: TPoint; var dwEffect: Longint): HResult;
var
  Data: TSTGMEDIUM;
  Buffer: PChar;
  eStr: String;
begin
  Result := dataObj.GetData(URLFormatEtc, Data);
  if (Result = S_OK) and (Data.tymed = TYMED_HGLOBAL) then
  begin
    Buffer := GlobalLock(Data.hGlobal);
    eStr := Buffer;
    GlobalFree(Data.hGlobal);

    Go(eStr, True);

    Exit;
  end;

  Result := dataObj.GetData(TextFormatEtc, Data);
  if (Result = S_OK) and (Data.tymed = TYMED_HGLOBAL) then
  begin
    Buffer := GlobalLock(Data.hGlobal);
    eStr := Buffer;
    GlobalFree(Data.hGlobal);

    Go(eStr, True);

    Exit;
  end;
end;

procedure TFrmWeb.ToolButtonDBClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmWeb.GoBack;
begin
  SafeExecuteProc(WebBrowser.GoBack);
end;

procedure TFrmWeb.GoForward;
begin
  SafeExecuteProc(WebBrowser.GoForward);
end;

procedure TFrmWeb.Stop;
begin
  SafeExecuteProc(WebBrowser.Stop);
end;

procedure TFrmWeb.Refresh;
begin
  SafeExecuteProc(WebBrowser.Refresh2);
end;

function TFrmWeb.GetIsBlank: Boolean;
begin
  Result := SameText(WebUrl, C_BLANKADDR);
end;

procedure TFrmWeb.SetWebUrl(const Value: string);
begin
  Go(FWebUrl, False);
end;

procedure TFrmWeb.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;

end;

procedure TFrmWeb.FormActivate(Sender: TObject);
begin
  FMainUiHandler.ActiveWebChange;
  WebBrowser.SetFocusToDoc;
end;

function TFrmWeb.GetWebUrl: string;
Var
  eDoc: IHtmlDocument2;
begin
  If (WebBrowser.Document <> Nil) And
    (WebBrowser.Document.QueryInterface(IHtmlDocument2, eDoc) = S_OK) Then
    FWebUrl := eDoc.url;

  Result := FWebUrl;
end;

procedure TFrmWeb.Go(aUrlStr: String; OpenNewPage: Boolean);
Var
  eUrl, eFlage: OleVariant;
begin
  If OpenNewPage Then
    eFlage := navOpenInNewWindow
  Else
    eFlage := EmptyParam;
    
  eUrl := aUrlStr;
  WebBrowser.Navigate2(eUrl, eFlage);
end;

procedure TFrmWeb.WebBrowserNewWindow2(Sender: TObject;
  var ppDisp: IDispatch; var Cancel: WordBool);
begin
  ppDisp := FrmMain.NewPage(C_BLANKADDR, False).WebBrowser.Application;
end;

procedure TFrmWeb.WebBrowserNavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  RefreshUi;
end;

procedure TFrmWeb.WebBrowserBeforeNavigate2(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
begin
//  屏蔽广告窗口
  If WebBrowser.ToolBar = 0 Then
    Close;

  RefreshUi;
end;

function TFrmWeb.WebBrowserGetDropTarget(const pDropTarget: IDropTarget;
  out ppDropTarget: IDropTarget): HRESULT;
begin
  Result := QueryInterface(IDropTarget, ppDropTarget);
end;

function TFrmWeb.GetWebTitle: String;
Var
  eDoc: IHTMLDocument2;
begin
  If (WebBrowser.Document <> Nil) And
    (WebBrowser.Document.QueryInterface(IHtmlDocument2, eDoc) = S_OK) And
    (eDoc.title <> '') Then
    FWebTitle := eDoc.title;

  Result := FWebTitle;
end;

procedure TFrmWeb.LoadOption;
Begin
  If UserConfig.Down_AllowActivex Then
    WebBrowser.DownloadOptions := WebBrowser.DownloadOptions -
      [DLCTL_NO_RUNACTIVEXCTLS, DLCTL_NO_DLACTIVEXCTLS]
  Else
    WebBrowser.DownloadOptions := WebBrowser.DownloadOptions +
      [DLCTL_NO_RUNACTIVEXCTLS, DLCTL_NO_DLACTIVEXCTLS];

  If UserConfig.Down_AllowImage Then
    WebBrowser.DownloadOptions := WebBrowser.DownloadOptions +
      [DLCTL_DLIMAGES]
  Else
    WebBrowser.DownloadOptions := WebBrowser.DownloadOptions -
      [DLCTL_DLIMAGES];

  If UserConfig.Down_AllowJava Then
    WebBrowser.DownloadOptions := WebBrowser.DownloadOptions +
      [DLCTL_NO_JAVA]
  Else
    WebBrowser.DownloadOptions := WebBrowser.DownloadOptions -
      [DLCTL_NO_JAVA];

  If UserConfig.Down_AllowVideo Then
    WebBrowser.DownloadOptions := WebBrowser.DownloadOptions +
      [DLCTL_VIDEOS]
  Else
    WebBrowser.DownloadOptions := WebBrowser.DownloadOptions -
      [DLCTL_VIDEOS];

  If UserConfig.Down_AllowScript Then
    WebBrowser.DownloadOptions := WebBrowser.DownloadOptions -
      [DLCTL_NO_SCRIPTS]
  Else
    WebBrowser.DownloadOptions := WebBrowser.DownloadOptions +
      [DLCTL_NO_SCRIPTS];

  If UserConfig.Down_AllowScript Then
    WebBrowser.DownloadOptions := WebBrowser.DownloadOptions +
      [DLCTL_BGSOUNDS]
  Else
    WebBrowser.DownloadOptions := WebBrowser.DownloadOptions -
      [DLCTL_BGSOUNDS];

end;


procedure TFrmWeb.ShowWebForm;
begin
  FormStyle := fsMDIChild;
  Visible := True;

  Show;
end;

procedure TFrmWeb.WebBrowserProgressChange(Sender: TObject; Progress,
  ProgressMax: Integer);
Var
  ImageIndex: Integer;
begin
  FProgress := Progress;

  If Active Then
    FMainUiHandler.RefreshProgress(Progress);

  If (ProgressMax = 0) Or (Progress = 0) Then
    ImageIndex := 4
  Else
    ImageIndex := Trunc((Progress / ProgressMax) * 10) div 2;

  If ImageIndex > 4 Then ImageIndex := 4;
                                     
  PageItemImageIndex := ImageIndex;
end;


procedure TFrmWeb.SetPageItemImageIndex(const Value: Integer);
begin
  if FPageItemImageIndex <> Value then
  begin
    FPageItemImageIndex := Value;

    FMainUiHandler.PageControl.ChagePageImage(Self, FPageItemImageIndex);
  end;
end;


procedure TFrmWeb.WebBrowserStatusTextChange(Sender: TObject;
  const Text: WideString);
begin
  If Active Then
    FMainUiHandler.ShowStatus(Text);
end;

procedure TFrmWeb.WebBrowserCommandStateChange(Sender: TObject;
  Command: Integer; Enable: WordBool);
begin
  If Active Then
    FMainUiHandler.CommandStateChange(Command, Enable);
end;

procedure TFrmWeb.WndProc(Var Message: TMessage);
begin


  inherited;
end;

function TFrmWeb.WebBrowserTranslateAccelerator(const lpMsg: PMsg;
  const pguidCmdGroup: PGUID; const nCmdID: Cardinal): HRESULT;
Const
  HotKeyArray = 'N'; 
Var
  IsCtrl, IsShift: Boolean;
begin
  Result := S_OK;

  IsCtrl := Getkeystate(VK_CONTROL) < 0;
  IsShift := Getkeystate(VK_SHIFT) < 0;

  if IsCtrl And (Pos(Char(lpmsg.wParam), HotKeyArray) <> 0) then
    PostMessage(Application.MainForm.Handle, lpMsg.message, lpMsg.wParam, lpMsg.lParam)
  else
    result := S_FALSE;
end;

procedure TFrmWeb.FormDestroy(Sender: TObject);
begin
  FMainUiHandler.PageControl.DeletePage(Self);
end;

procedure TFrmWeb.WebBrowserDocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  PageItemImageIndex := 4;
end;

initialization

  CF_URL := RegisterClipboardFormat('UniformResourceLocator');

  with URLFormatEtc do
  begin
    cfFormat := CF_URL;
    ptd := nil;
    dwAspect := DVASPECT_CONTENT;
    lindex := -1;
    tymed := TYMED_HGLOBAL;
  end;

  With TextFormatEtc Do
  Begin
    cfFormat := CF_TEXT;
    ptd := nil;
    dwAspect := DVASPECT_CONTENT;
    lindex := -1;
    tymed := TYMED_HGLOBAL;
  End;

end.