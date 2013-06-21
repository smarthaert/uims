{*******************************************************}
{                                                       }
{       系统名称 时钟组件类                             }
{       版权所有 (C) http://blog.csdn.net/akof1314      }
{       单元名称 Clock.pas                              }
{       单元功能 时钟组件（利用IGDI+和定时器）          }
{                                                       }
{*******************************************************}
unit Clock;

interface

uses
  SysUtils, Classes, Controls, Graphics, Windows, ExtCtrls, IGDIPlus;

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
    AGraphics: IGPGraphics;   //GDI+接口
    APen: IGPPen;
    AFont: IGPFont;
    ABrush: IGPSolidBrush;
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
  APen := TGPPen.Create($FF000000);
  AFont := TGPFont.Create('宋体',11);
  ABrush := TGPSolidBrush.Create($FF000000);
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
  AGraphics := TGPGraphics.Create(Canvas);
  AGraphics.SmoothingMode := SmoothingModeAntiAlias;
  AGraphics.TextRenderingHint := TextRenderingHintAntiAlias;
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
  OriginalColor := APen.Color;
  with AGraphics do
  begin
    APen.Width := 3;
    DrawEllipseF(APen,FClockLeft, FClockTop,  FRadius * 2,  FRadius * 2);
    APen.Width := 1;
    APen.DashStyle := DashStyleDot;
    DrawEllipseF(APen,FClockLeft + 20, FClockTop + 20,  FRadius * 2 - 40,  FRadius * 2 - 40);
    APen.Width := 2;
    APen.DashStyle := DashStyleSolid;
    for i := 1 to 12 do
    begin
      DrawEllipseF(APen,(RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) - 1, (RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) - 1, 2,  2);
      case i of
        1: DrawStringF(IntToStr(i),AFont,MakePointF((RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) + 0, (RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) - 15), ABrush);
        2: DrawStringF(IntToStr(i),AFont,MakePointF((RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) + 2, (RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) - 13), ABrush);
        3: DrawStringF(IntToStr(i),AFont,MakePointF((RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) + 3, (RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) - 8), ABrush);
        4: DrawStringF(IntToStr(i),AFont,MakePointF((RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) + 0, (RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) -2), ABrush);
        5: DrawStringF(IntToStr(i),AFont,MakePointF((RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) + 0, (RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) -0), ABrush);
        6: DrawStringF(IntToStr(i),AFont,MakePointF((RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) - 6, (RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) + 1), ABrush);
        7: DrawStringF(IntToStr(i),AFont,MakePointF((RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) - 11, (RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) + 1), ABrush);
        8: DrawStringF(IntToStr(i),AFont,MakePointF((RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) - 13, (RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) - 2), ABrush);
        9: DrawStringF(IntToStr(i),AFont,MakePointF((RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) - 16, (RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) - 7), ABrush);
        10: DrawStringF(IntToStr(i),AFont,MakePointF((RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) - 20, (RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) - 13), ABrush);
        11: DrawStringF(IntToStr(i),AFont,MakePointF((RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) - 17, (RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) - 15), ABrush);
        12: DrawStringF(IntToStr(i),AFont,MakePointF((RadiusPoint.X + (FRadius - 20) * Sin(i * pi / 6)) - 11, (RadiusPoint.Y - (FRadius - 20) * Cos(i * pi / 6)) - 18), ABrush);
      end;
    end;
    DrawEllipseF(APen,RadiusPoint.X - 1, RadiusPoint.Y - 1,  2, 2);

    APen.SetColor(MakeColor(FHourColor));
    APen.SetWidth(FHourWidth);
    DrawLineF(APen,(RadiusPoint.X - 1 * Sin(((FHourValue mod 12) * 5 + FMinuteValue / 12) * Pi / 30)), (RadiusPoint.Y + 1 * Cos(((FHourValue mod 12) * 5 + FMinuteValue / 12) * Pi / 30)),
                   (RadiusPoint.X + (FRadius - 20) * Sin(((FHourValue mod 12) * 5 + FMinuteValue / 12) * Pi / 30)), (RadiusPoint.Y - (FRadius - 20) * Cos(((FHourValue mod 12) * 5 + FMinuteValue / 12) * Pi / 30)));

    APen.SetColor(MakeColor(FMinuteColor));
    APen.SetWidth(FMinuteWidth);
    DrawLineF(APen,(RadiusPoint.X - 1 * Sin(FMinuteValue * Pi / 30)), (RadiusPoint.Y + 1 * Cos(FMinuteValue * Pi / 30)),
                   (RadiusPoint.X + (FRadius - 12) * Sin(FMinuteValue * pi / 30)), (RadiusPoint.Y - (FRadius - 12) * Cos(FMinuteValue * pi / 30)));

    APen.SetColor(MakeColor(FSecondColor));
    APen.SetWidth(FSecondWidth);
    DrawLineF(Apen,(RadiusPoint.X - 7 * Sin(FSecondValue * Pi / 30)), (RadiusPoint.Y + 7 * Cos(FSecondValue * Pi / 30)),
                    (RadiusPoint.X + (Radius - 7) * Sin(FSecondValue * pi / 30)), (RadiusPoint.Y - (FRadius - 7) * Cos(FSecondValue * pi / 30)));

    APen.Color := OriginalColor;
  end;
end;

procedure TClock.DrawNumberStyle;
var
  OriginalSzie: Single;
  FontPoint: TPointFloat;
  OriginalColor: TGPColor;
  Semicolon: string;
  MeasureSize: TGPSizeF;
begin
  OriginalSzie := AFont.Size;
  OriginalColor := ABrush.Color;
  FontPoint.X := 0;
  FontPoint.Y := 0;
  Semicolon := ':';
  AFont := TGPFont.Create(AFont.Family, FRadius div 2);
  ABrush.Color := MakeColor(FHourColor);
  AGraphics.DrawStringF(IntToStr(FHourValue),AFont,MakePointF(FontPoint.X, FontPoint.Y),ABrush);
  MeasureSize := AGraphics.MeasureStringF(IntToStr(FHourValue),AFont,nil);
  FontPoint.X := FontPoint.X + MeasureSize.Width - 10;

  ABrush.Color := MakeColor(clBlack);
  AGraphics.DrawStringF(Semicolon,AFont,MakePointF(FontPoint.X, FontPoint.Y), ABrush);
  MeasureSize := AGraphics.MeasureStringF(Semicolon,AFont,nil);
  FontPoint.X := FontPoint.X + MeasureSize.Width - 10;

  ABrush.Color := MakeColor(FMinuteColor);
  AGraphics.DrawStringF(Format('%.2d', [FMinuteValue]), AFont, MakePointF(FontPoint.X, FontPoint.Y),ABrush);
  MeasureSize := AGraphics.MeasureStringF(Format('%.2d', [FMinuteValue]),AFont,nil);
  FontPoint.X := FontPoint.X + MeasureSize.Width - 10;

  ABrush.Color := MakeColor(clBlack);
  AGraphics.DrawStringF(Semicolon, AFont, MakePointF(FontPoint.X, FontPoint.Y),ABrush);
  MeasureSize := AGraphics.MeasureStringF(Semicolon,AFont,nil);
  FontPoint.X := FontPoint.X + MeasureSize.Width - 10;

  ABrush.Color := MakeColor(FSecondColor);
  AGraphics.DrawStringF(Format('%.2d', [FSecondValue]), AFont, MakePointF(FontPoint.X, FontPoint.Y), ABrush);
  ABrush.Color := OriginalColor;
  AFont := TGPFont.Create(AFont.Family,OriginalSzie);
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
  if not (csDesigning in ComponentState) then
   DrawClock;
end;
end.

