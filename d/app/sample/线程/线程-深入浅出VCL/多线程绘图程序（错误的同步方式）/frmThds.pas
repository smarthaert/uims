unit frmThds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    btnThdDraw: TButton;
    btnClean: TButton;
    Bevel1: TBevel;
    btnMainDraw: TButton;
    btnExit: TButton;
    procedure btnExitClick(Sender: TObject);
    procedure btnMainDrawClick(Sender: TObject);
    procedure btnThdDrawClick(Sender: TObject);
    procedure btnCleanClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Thds;

{$R *.dfm}

procedure TForm1.btnExitClick(Sender: TObject);
begin
  close;
end;

//随机椭圆
procedure TForm1.btnMainDrawClick(Sender: TObject);
var
  x,y,z,i:integer;
begin
  for i :=0  to 10 do
  begin
    y:=round(random(300)+PaintBox1.top);
    x:=round(random(600)+PaintBox1.left);
    PaintBox1.Canvas.Pen.Color := clBlack;
    PaintBox1.Canvas.Ellipse(x,y,x+round(random(200)),y+round(random(200)));
    for y:=1 to 1000000 do z:=round(random(sqr(x*sqr(y)))); //模拟运算延时
  end;
end;

procedure TForm1.btnThdDrawClick(Sender: TObject);
begin
  //创建线程
  TRectangleThread.create(PaintBox1);
  TCircleThread.create(PaintBox1);
end;

procedure TForm1.btnCleanClick(Sender: TObject);
begin
  PaintBox1.Canvas.Brush.Style:=bsSolid;
  PaintBox1.Canvas.Brush.Color:=PaintBox1.Color;
  PaintBox1.Canvas.FillRect(PaintBox1.BoundsRect);
end;

end.
