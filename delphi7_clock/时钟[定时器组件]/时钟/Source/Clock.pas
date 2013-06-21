{*******************************************************}
{                                                       }
{       系统名称 时钟组件类                             }
{       版权所有 (C) http://blog.csdn.net/akof1314      }
{       单元名称 Clock.pas                              }
{       单元功能 时钟组件（利用定时器）                 }
{                                                       }
{*******************************************************}
unit Clock;

interface

uses
  SysUtils, Classes, Controls, Graphics, Windows, ExtCtrls;

type
  TClockStyle = (NumberStyle, PointerStyle);
  TClock = class(TGraphicControl)
  private
    FHourValue, FMinuteValue, FSecondValue: Integer; //时针、分针、秒针值
    FHourWidth, FMinuteWidth, FSecondWidth: Integer; //时针、分针、秒针宽度
    FHourColor, FMinuteColor, FSecondColor: TColor;
    FIsEnable: Boolean; //是否运行
    FRadius: Integer; //半径
    FClockStyle: TClockStyle; //时针风格
    FClockLeft, FClockTop: Integer;
    FTime: TTimer;
    procedure SetHourValue(Value: Integer);
    procedure SetMinuteValue(Value: Integer);
    procedure SetSecondValue(Value: Integer);
    procedure SetHourColor(Value: TColor);
    procedure SetMinuteColor(Value: TColor);
    procedure SetSecondColor(Value: TColor);
    procedure SetIsEnable(Value: Boolean);
    procedure SetClockStyle(Value: TClockStyle);
    procedure SetRadius(Value: Integer);
    procedure DrawClock;
    procedure DrawPointerStyle;
    procedure DrawNumberStyle;
    procedure EverySecondDraw(sender: TObject);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property HourValue: Integer read FHourValue write SetHourValue;
    property MinuteValue: Integer read FMinuteValue write SetMinuteValue;
    property SecondValue: Integer read FSecondValue write SetSecondValue;
    property HourColor: TColor read FHourColor write SetHourColor;
    property MinuteColor: TColor read FMinuteColor write SetMinuteColor;
    property SecondColor: TColor read FSecondColor write SetSecondColor;
    property Radius: Integer read FRadius write SetRadius;
    property ClockStyle: TClockStyle read FClockStyle write SetClockStyle default PointerStyle;
    property Enabled: Boolean read FIsEnable write SetIsEnable;
  end;
procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TClock]);
end;

constructor TClock.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHourValue := StrToInt(FormatDateTime('hh', Now));
  FMinuteValue := StrToInt(FormatDateTime('nn', Now));
  FSecondValue := StrToInt(FormatDateTime('ss', Now));
  FHourWidth := 3;
  FMinuteWidth := 2;
  FSecondWidth := 1;
  FHourColor := clBlack;
  FMinuteColor := clBlack;
  FSecondColor := clBlack;
  FClockLeft := 15;
  FClockTop := 15;
  FRadius := 50;
  Width := FRadius * 2 + 45;
  Height := FRadius * 2 + 30;
  FClockStyle := PointerStyle;
  FIsEnable := True;
  Canvas.Brush.Style := bsClear;
  FTime := TTimer.Create(Self);
  FTime.Interval := 1000;
  FTime.OnTimer := EverySecondDraw; 
  if csDesigning in ComponentState then
    FTime.Enabled := False;
end;

destructor TClock.Destroy;
begin
  FTime.Free;
  inherited Destroy;
end;

procedure TClock.SetHourValue(Value: Integer);
begin
  FHourValue := Value;
  Invalidate;
end;

procedure TClock.SetMinuteValue(Value: Integer);
begin
  FMinuteValue := Value;
  Invalidate;
end;

procedure TClock.SetSecondValue(Value: Integer);
begin
  FSecondValue := Value;
  Invalidate;
end;

procedure TClock.SetHourColor(Value: TColor);
begin
  FHourColor := Value;
  Invalidate;
end;

procedure TClock.SetMinuteColor(Value: TColor);
begin
  FMinuteColor := Value;
  Invalidate;
end;

procedure TClock.SetSecondColor(Value: TColor);
begin
  FSecondColor := Value;
  Invalidate;
end;

procedure TClock.SetIsEnable(Value: Boolean);
begin
  if FIsEnable <> Value then
  begin
    FIsEnable := Value;
    FTime.Enabled := Value;
  end;
end;

procedure TClock.SetClockStyle(Value: TClockStyle);
begin
  FClockStyle := Value;
  Invalidate;
end;

procedure TClock.SetRadius(Value: Integer);
begin
  FRadius := Value;
  Invalidate;
end;

procedure TClock.DrawClock;
begin
  if FClockStyle = PointerStyle then
    DrawPointerStyle
  else
    DrawNumberStyle;
end;

procedure TClock.DrawPointerStyle;
var
  i: Integer;
  RadiusPoint: TPoint;
  OriginalColor: TColor;
begin
  RadiusPoint.X := FClockLeft + FRadius;
  RadiusPoint.Y := FClockTop + FRadius;
  OriginalColor := Canvas.Pen.Color;
  with Canvas do
  begin
    Pen.Width := 3;
    Ellipse(FClockLeft, FClockTop, FClockLeft + FRadius * 2, FClockTop + FRadius * 2);
    Pen.Width := 1;
    Pen.Style := psDot;
    Ellipse(FClockLeft + 20, FClockTop + 20, FClockLeft + FRadius * 2 - 20, FClockTop + FRadius * 2 - 20);
    Pen.Width := 2;
    Pen.Style := psSolid;
    for i := 1 to 12 do
    begin
      Ellipse(Round(RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) - 1, Round(RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) - 1, Round(RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) + 2, Round(RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) + 2);
      case i of
        1: TextOut(Round(RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) + 2, Round(RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) - 13, IntToStr(i));
        2: TextOut(Round(RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) + 4, Round(RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) - 10, IntToStr(i));
        3: TextOut(Round(RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) + 5, Round(RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) - 6, IntToStr(i));
        4: TextOut(Round(RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) + 3, Round(RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) - 2, IntToStr(i));
        5: TextOut(Round(RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) + 3, Round(RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) + 1, IntToStr(i));
        6: TextOut(Round(RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) - 3, Round(RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) + 3, IntToStr(i));
        7: TextOut(Round(RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) - 7, Round(RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) + 2, IntToStr(i));
        8: TextOut(Round(RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) - 10, Round(RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) - 1, IntToStr(i));
        9: TextOut(Round(RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) - 11, Round(RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) - 5, IntToStr(i));
        10: TextOut(Round(RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) - 14, Round(RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) - 11, IntToStr(i));
        11: TextOut(Round(RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) - 10, Round(RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) - 14, IntToStr(i));
        12: TextOut(Round(RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) - 6, Round(RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) - 15, IntToStr(i));
      end;
    end;
    Ellipse(RadiusPoint.X - 3, RadiusPoint.Y - 3, RadiusPoint.X + 3, RadiusPoint.Y + 3);

    Pen.Color := FHourColor;
    Pen.Width := FHourWidth;
    MoveTo(Round(RadiusPoint.X - 1 * Sin(((FHourValue mod 12) * 5 + FMinuteValue / 12) * Pi / 30)), Round(RadiusPoint.Y + 1 * Cos(((FHourValue mod 12) * 5 + FMinuteValue / 12) * Pi / 30))); //转换成跟分针、秒针一样的60格制
    LineTo(Round(RadiusPoint.X + (FRadius - 20) * Sin(((FHourValue mod 12) * 5 + FMinuteValue / 12) * Pi / 30)), Round(RadiusPoint.Y - (FRadius - 20) * Cos(((FHourValue mod 12) * 5 + FMinuteValue / 12) * Pi / 30)));

    Pen.Color := FMinuteColor;
    Pen.Width := FMinuteWidth;
    MoveTo(Round(RadiusPoint.X - 1 * Sin(FMinuteValue * Pi / 30)), Round(RadiusPoint.Y + 1 * Cos(FMinuteValue * Pi / 30)));
    LineTo(Round(RadiusPoint.X + (FRadius - 12) * Sin(FMinuteValue * pi / 30)), Round(RadiusPoint.Y - (FRadius - 12) * Cos(FMinuteValue * pi / 30)));

    Pen.Color := FSecondColor;
    Pen.Width := FSecondWidth;
    MoveTo(Round(RadiusPoint.X - 7 * Sin(FSecondValue * Pi / 30)), Round(RadiusPoint.Y + 7 * Cos(FSecondValue * Pi / 30)));
    LineTo(Round(RadiusPoint.X + (Radius - 7) * Sin(FSecondValue * pi / 30)), Round(RadiusPoint.Y - (FRadius - 7) * Cos(FSecondValue * pi / 30)));

    Pen.Color := OriginalColor;
  end;
end;

procedure TClock.DrawNumberStyle;
var
  OriginalSzie: Integer;
  FontSize: TSize;
  FontPoint: TPoint;
  OriginalColor: TColor;
  Semicolon: string;
begin
  OriginalSzie := Canvas.Font.Size;
  OriginalColor := Canvas.Font.Color;
  FontPoint.X := FClockLeft;
  FontPoint.Y := FClockTop;
  Semicolon := ':';
  Canvas.Font.Size := FRadius div 2;
  Canvas.Font.Color := FHourColor;
  Canvas.TextOut(FontPoint.X, FontPoint.Y, IntToStr(FHourValue));
  GetTextExtentPoint32(Canvas.Handle, PChar(IntToStr(FHourValue)), Length(IntToStr(FHourValue)), FontSize);
  FontPoint.X := FontPoint.X + FontSize.cx;

  Canvas.Font.Color := clBlack;
  Canvas.TextOut(FontPoint.X, FontPoint.Y, Semicolon);
  GetTextExtentPoint32(Canvas.Handle, PChar(Semicolon), Length(Semicolon), FontSize);
  FontPoint.X := FontPoint.X + FontSize.cx;

  Canvas.Font.Color := FMinuteColor;
  Canvas.TextOut(FontPoint.X, FontPoint.Y, Format('%.2d', [FMinuteValue]));
  GetTextExtentPoint32(Canvas.Handle, PChar(Format('%.2d', [FMinuteValue])), Length(Format('%.2d', [FMinuteValue])), FontSize);
  FontPoint.X := FontPoint.X + FontSize.cx;

  Canvas.Font.Color := clBlack;
  Canvas.TextOut(FontPoint.X, FontPoint.Y, Semicolon);
  GetTextExtentPoint32(Canvas.Handle, PChar(Semicolon), Length(Semicolon), FontSize);
  FontPoint.X := FontPoint.X + FontSize.cx;

  Canvas.Font.Color := FSecondColor;
  Canvas.TextOut(FontPoint.X, FontPoint.Y, Format('%.2d', [FSecondValue]));
  Canvas.Font.Color := OriginalColor;
  Canvas.Font.Size := OriginalSzie;
end;

procedure TClock.EverySecondDraw(sender: TObject);
begin
  FSecondValue := FSecondValue + 1;
  if FSecondValue = 60 then
  begin
    FSecondValue := 0;
    FMinuteValue := FMinuteValue + 1;
    if FMinuteValue = 60 then
    begin
      FMinuteValue := 0;
      FHourValue := FHourValue + 1;
      if FHourValue = 24 then
        FHourValue := 0;
    end;
  end;
  Invalidate;
end;

procedure TClock.Paint;
begin
 if Self.Parent.DoubleBuffered <> True then
    Self.Parent.DoubleBuffered := True;
  DrawClock;
end;
end.

