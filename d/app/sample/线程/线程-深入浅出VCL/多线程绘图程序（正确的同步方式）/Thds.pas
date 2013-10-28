unit Thds;

interface

uses
  Classes, Graphics, ExtCtrls;

type
  TDrawThread=class(TThread)
    FCanvas: TCanvas;
    FL,FT,FH,FW: Integer;
    x,y,z:Integer;
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
  FreeOnTerminate := True;
  inherited Create(False);
end;

procedure TDrawThread.Execute;
var
  i,j:Integer;
begin
  for i :=1  to 10 do
  begin
    y:=round(random(FH)+FT);
    x:=round(random(FW)+FL);
    z:=round(random(50));
    synchronize(drawing);//同步时间越短越好
    //模拟运算延时
    for j:=1 to 10000000 do z:=round(random(sqr(x*sqr(j))));
  end;
end;

procedure TDrawThread.Drawing;
begin
  FCanvas.Brush.Style:=bsClear;
end;

//随机画圆
procedure  TCircleThread.Drawing;
begin
  inherited Drawing;
  FCanvas.Pen.Color := clRed;
  FCanvas.Ellipse(x,y,(x+z),(y+z));
end;

//随机画方
procedure  TRectangleThread.Drawing;
begin
  inherited Drawing;
  FCanvas.Pen.Color := clBlue;
  FCanvas.Rectangle(x,y,(x+z),(y+z));
end;

end.
