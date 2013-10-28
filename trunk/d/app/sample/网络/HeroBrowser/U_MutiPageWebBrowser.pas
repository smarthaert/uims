unit U_MutiPageWebBrowser;

interface

Uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ComCtrls, StdCtrls, ExtCtrls, SHDocVw, EmbeddedWB, Mshtml_tlb;

Const
  C_BLANKADDR = 'about:blank';


  False = Boolean(0);
  True = Boolean(1);

Type

  TMutiPageWebBrowser = Class;

  TWebTabSheet = class(TTabSheet)
  private
    FWebBrowser: TEmbeddedWB;

    FCurUrl: string;

    FNavigateUrl: String;

    FMutiPageWeb: TMutiPageWebBrowser;    
    procedure CreateWebBrowser;
    function GetIsBlank: Boolean;
    procedure OnBeforeNavigate(Sender: TObject; const pDisp: IDispatch; var URL:
        OleVariant; var Flags: OleVariant; var TargetFrameName: OleVariant; var
        PostData: OleVariant; var Headers: OleVariant; var Cancel: WordBool);
    procedure OnNewWindow(Sender: TObject; var ppDisp: IDispatch; var Cancel:
        WordBool);
    procedure SetCurUrl(const Value: string);
  protected
  public
    constructor Create(OwnerPageControl: TMutiPageWebBrowser; UrlStr: String);
    procedure GoBack;
    procedure GoForward;
    procedure Refresh;
    procedure Stop;
    property IsBlank: Boolean read GetIsBlank;
    property CurUrl: string read FCurUrl write SetCurUrl;
    property WebBrowser: TEmbeddedWB read FWebBrowser;
    
  published
  end;


  TMutiPageWebBrowser = Class(TPageControl)
  private
    function GetCurPage: TWebTabSheet;
    procedure SetCurPage(const Value: TWebTabSheet);
  public
    constructor Create(AOwner: TComponent); override;
    procedure NewPage(UrlStr: String);
    property CurPage: TWebTabSheet read GetCurPage write SetCurPage;
  End;

implementation

constructor TWebTabSheet.Create(OwnerPageControl: TMutiPageWebBrowser; UrlStr:
    String);
begin
  inherited Create(OwnerPageControl);

  PageControl := OwnerPageControl;

  FMutiPageWeb := OwnerPageControl;
  

  CreateWebBrowser;
  
  CurUrl := UrlStr;
end;

procedure TWebTabSheet.CreateWebBrowser;
begin
  //´´½¨WEBBROWSER
  FWebBrowser := TEmbeddedWB.Create(Self);
  FWebBrowser.ParentWindow := Handle;
  FWebBrowser.Align := alClient;
  FWebBrowser.Width := Width;
  FWebBrowser.Height := Height;

  FWebBrowser.OnNewWindow2 := OnNewWindow;
  FWebBrowser.OnBeforeNavigate2 := OnBeforeNavigate;
end;

function TWebTabSheet.GetIsBlank: Boolean;
begin
  Result := SameText(FCurUrl, C_BLANKADDR);
end;

procedure TWebTabSheet.GoBack;
begin
  FWebBrowser.GoBack;
end;

procedure TWebTabSheet.GoForward;
begin
  FWebBrowser.GoForward;
end;

procedure TWebTabSheet.OnBeforeNavigate(Sender: TObject; const pDisp:
    IDispatch; var URL: OleVariant; var Flags: OleVariant; var TargetFrameName:
    OleVariant; var PostData: OleVariant; var Headers: OleVariant; var Cancel:
    WordBool);
begin
  FNavigateUrl := URL;
end;

procedure TWebTabSheet.OnNewWindow(Sender: TObject; var ppDisp: IDispatch; var
    Cancel: WordBool);
begin
  FMutiPageWeb.NewPage(FNavigateUrl);
  Cancel := True;
end;

procedure TWebTabSheet.Refresh;
begin
  FWebBrowser.Refresh2;
end;

procedure TWebTabSheet.SetCurUrl(const Value: string);
begin
  If Not SameText(FCurUrl, Value) Then
  Begin
    FCurUrl := Value;
    FWebBrowser.Go(CurUrl);

    Caption := CurUrl;
  End;
end;

procedure TWebTabSheet.Stop;
begin
  FWebBrowser.Stop;
end;

constructor TMutiPageWebBrowser.Create(AOwner: TComponent);
begin
  inherited;
  Style := tsFlatButtons;
end;

function TMutiPageWebBrowser.GetCurPage: TWebTabSheet;
begin
  Result := TWebTabSheet(ActivePage);
end;

procedure TMutiPageWebBrowser.NewPage(UrlStr: String);
begin
  TWebTabSheet.Create(Self, UrlStr);
end;

procedure TMutiPageWebBrowser.SetCurPage(const Value: TWebTabSheet);
begin
  ActivePage := Value;
end;

end.
