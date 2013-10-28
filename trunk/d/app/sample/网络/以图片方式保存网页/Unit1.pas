unit Unit1;

interface
//download by http://www.codefans.net
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,shdocvw,MSHTML,ActiveX, OleCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    WebBrowser1: TWebBrowser;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
  ViewObject: IViewObject;
  sourceDrawRect: TRect;
begin
  if Webbrowser1.Document <> nil then
  try
    webbrowser1.Document.QueryInterface(IViewObject, ViewObject);
    if ViewObject <> nil then
      try
        sourceDrawRect := Rect(0, 0, Image1.Width, Image1.Height);
        ViewObject.Draw(DVASPECT_CONTENT, 1, nil, nil, Self.Handle,
          image1.Canvas.Handle, @sourceDrawRect, nil, nil, 0);
        image1.Repaint;  
      finally
        ViewObject._Release;
      end;
  except
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  WebBrowser1.Navigate(extractfilepath(paramstr(0))+'ËÑºüÐÂÎÅ.htm');
end;

end.
