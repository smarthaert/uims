unit Unit1;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ImgList, ComCtrls, ToolWin, StdCtrls, ExtCtrls,
  OleCtrls, SHDocVw;

type
  TForm1 = class(TForm)
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Browser1: TWebBrowser;
    StatusBar1: TStatusBar;
    SpeedButton6: TSpeedButton;
    Dialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Browser1DownloadBegin(Sender: TObject);
    procedure Browser1DownloadComplete(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Browser1.Navigate(Edit1.Text);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  Try
    Browser1.GoBack;
  Except
  End;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  Try
    Browser1.GoForward;
  Except
  End;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  Browser1.GoHome;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  Browser1.Refresh;
end;

procedure TForm1.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key  = vk_Return then
    Button1Click(Sender);
end;

procedure TForm1.Browser1DownloadBegin(Sender: TObject);
begin
  StatusBar1.Panels[0].Text := '正在连接地址：'+Edit1.Text;
end;

procedure TForm1.Browser1DownloadComplete(Sender: TObject);
begin
  StatusBar1.Panels[0].Text := '完成：'+Browser1.LocationURL;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
  if Dialog1.Execute   then
    Edit1.Text := Dialog1.FileName;
end;

end.
