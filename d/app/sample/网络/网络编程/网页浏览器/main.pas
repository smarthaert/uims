unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw, ComCtrls, ToolWin, ImgList,
  ExtCtrls;

type
  TForm1 = class(TForm)
    WebBrowser1: TWebBrowser;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ImageList1: TImageList;
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    StatusBar1: TStatusBar;
    procedure Button1Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure WebBrowser1DownloadBegin(Sender: TObject);
    procedure WebBrowser1DownloadComplete(Sender: TObject);
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
  WebBrowser1.Navigate(Edit1.Text);
end;

procedure TForm1.ToolButton8Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
  Try
    WebBrowser1.GoBack;
  except
    showmessage('已经达到最早历史纪录。');
    exit;
  end;

end;

procedure TForm1.ToolButton2Click(Sender: TObject);
begin
   Try
     WebBrowser1.GoForward;
   except
     showmessage('已经达到最后历史纪录。');
     exit;
   end;

end;

procedure TForm1.ToolButton4Click(Sender: TObject);
begin
  WebBrowser1.Stop;
end;

procedure TForm1.ToolButton5Click(Sender: TObject);
begin
  WebBrowser1.Refresh;
end;

procedure TForm1.ToolButton6Click(Sender: TObject);
begin
  WebBrowser1.GoHome;
end;
{Download by http://www.codefans.net}
procedure TForm1.WebBrowser1DownloadBegin(Sender: TObject);
begin
     StatusBar1.Panels[0].Text:='正在连接地址：'+Edit1.text;
end;

procedure TForm1.WebBrowser1DownloadComplete(Sender: TObject);
begin
   StatusBar1.Panels[0].Text:='完成'+WebBrowser1.LocationURL ;
end;

end.
