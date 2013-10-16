unit AboutUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, shellapi, Gauges, ComCtrls, MPlayer, Buttons,
  OleCtrls, SHDocVw, jpeg;

type
  TAboutForm = class(TForm)
    Bevel1: TBevel;
    Button2: TButton;
    LTitle: TLabel;
    LPage: TLabel;
    Label4: TLabel;
    LVersion: TLabel;
    Label25: TLabel;
    Label2: TLabel;
    LEmail: TLabel;
    LBrowserName: TLabel;
    LThanks: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LPageClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LEmailClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure CreateParams(var Params: TCreateParams);override;
  public
    { Public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

uses UnitMain, const_, UnitPublic, var_;

{$R *.dfm}

procedure TAboutForm.CreateParams(var Params: TCreateParams);
begin
try
  inherited CreateParams(Params);
  Params.WndParent:=GetActiveWindow;
except end;
end;

procedure TAboutForm.Button2Click(Sender: TObject);
begin
try
  Close;
except end;
end;

//ShellExecute(handle, 'open', pchar('http://www.skin-studio.com'), nil, nil, SW_SHOWNORMAL);


procedure TAboutForm.FormCreate(Sender: TObject);
begin
try   
  AboutForm.Caption:=Application.Title;
  LTitle.Caption:=TitleStr;
  LVersion.Caption:='版本:'+Version;
  LPage.Caption:=BrowserHomePage;
  LEmail.Caption:=BugToEMail;
  LThanks.Caption:='感谢所有支持'+BrowserName+'的朋友们!';
  LBrowserName.Caption:=BrowserName;
except end;
end;

procedure TAboutForm.LPageClick(Sender: TObject);
begin
try
  //MainForm.TBAddNew.OnClick(Sender);
  FormMain.CBURL.Text:=BrowserHomePage;
  FormMain.BBGO.Click;   
  AboutForm.Close;
  {
  if MainForm.PclParent.ActivePageIndex>0 then
    MainForm.CurrWebBrowserNavigate(Trim('http://www.cnlogin.com/tob'))
  else
    MainForm.FrameWebBrowserDefault.WebBrowser.Navigate(Trim('http://www.cnlogin.com/tob'));
  AboutForm.Hide;
  //ShellExecute(Handle,'open','http://www.cnlogin.com/tob',nil,nil,0);
  }
except end;
end;

procedure TAboutForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
try
  FormPublic.DocumentSetFocus;
  //FormMain.InterfaceRepaint;
except end;
end;

procedure TAboutForm.LEmailClick(Sender: TObject);
begin
try
  //ShellExecute(Handle,'open',PChar('mailto:'+Trim(LEmail.Caption)),nil,nil,0);
  ShellExecute(Handle, 'open', PChar('MailTo:' + Trim(LEmail.Caption) + '?Subject='+'关于"' + TitleStr + '"'), nil, nil, SW_SHOW);
  AboutForm.Close;
except end;
end;

end.
