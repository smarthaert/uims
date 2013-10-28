unit Unit1;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ExtDlgs, Buttons, ComCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    TrackBar3: TTrackBar;
    Label3: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  p:array[1..400,1..400] of byte;
  t:Tcolor;
implementation

{$R *.dfm}

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
   if OpenPictureDialog1.Execute then
    image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var
  row,lie:integer;
begin
form1.Repaint;
for row:=Trackbar1.Position to trackbar2.Position do
  begin
    for lie:=1 to 400 do
    begin
      t:=Image1.canvas.pixels[row,lie];
      p[row,lie]:=getbvalue(t);
    end;
  end;

  for row:=Trackbar1.Position to trackbar2.Position do
  begin
    for lie:=1 to 400 do
    begin
      if p[row,lie]<trackBar3.Position then
        form1.Canvas.Pixels[row,lie]:=clred;
    end;
  end;
end;

end.
