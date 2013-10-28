unit Thds;

interface

uses
  Classes, Graphics, ExtCtrls;

type
  TDrawThread=class(TThread)
    FCanvas: TCanvas;
    FL,FT,FH,FW: Integer;
  protected
    procedure Drawing;virtual;
    procedure Execute; override;
  public
    constructor Create(Box: TPaintBox);
  end;

  TCircleThread=class(TDrawThread)
  public
    procedure Drawing;override;
  end;

  TRectangleThread=class(TDrawThread)
  public
    procedure Drawing;override;
  end;


implementation

constructor TDrawThread.Create(Box:TPaintBox);
begin
  FL:=Box.Left;
  FT:=Box.Top;
  FH:=Box.Height;
  FW:=Box.Width;
  FCanvas:=Box.Canvas;
  inherited Create(False);
end;

procedure TDrawThread.Execute;
begin
  FreeOnTerminate := True;
  //synchronize(drawing); 没有使用VCL的同步机制
  drawing;
end;

procedure TDrawThread.Drawing;
begin
  FCanvas.Brush.Style:=bsClear;
end;

//随机画圆
procedure  TCircleThread.Drawing;
var
  x,y,z,i:integer;
begin
  inherited Drawing;
  for i :=0  to 10 do
  begin
    y:=round(random(FH)+FT);
    x:=round(random(FW)+FL);
    z:=round(random(50));
    FCanvas.lock; //加锁
    FCanvas.Pen.Color := clRed;
    FCanvas.Ellipse(x,y,(x+z),(y+z));
    FCanvas.unlock;//解锁
    //模拟运算延时
    for y:=1 to 10000000 do z:=round(random(sqr(x*sqr(y))));
  end;
end;

//随机画方
procedure  TRectangleThread.Drawing;
var
  x,y,z,i:integer;
begin
  inherited Drawing;
  for i :=0  to 10 do
  begin
    y:=round(random(FH)+FT);
    x:=round(random(FW)+FL);
    z:=round(random(50));
    FCanvas.lock;//加锁
    FCanvas.Pen.Color := clBlue;
    FCanvas.Rectangle(x,y,(x+z),(y+z));
    FCanvas.unlock; //解锁
    //模拟运算延时
    for y:=1 to 10000000 do z:=round(random(sqr(x*sqr(y))));
  end;
end;

end.
