{*******************************************************}
{                                                       }
{       系统名称 时钟实现程序                           }
{       版权所有 (C) http://blog.csdn.net/akof1314      }
{       单元名称 UnitMainForm.pas                       }
{       单元功能 主单元                                 }
{                                                       }
{*******************************************************}

{-------------------------------------------------------------------------------
 思路:
 先画外圈圆，再画内圆和各个时刻的数字值，再绘制指针
-------------------------------------------------------------------------------}
unit UnitMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Spin, Buttons;

type
  TfrmMainForm = class(TForm)
    bvl1: TBevel;
    tmr_Clock: TTimer;
    rg_Style: TRadioGroup;
    bvl2: TBevel;
    grp_Set: TGroupBox;
    se_Left: TSpinEdit;
    se_Top: TSpinEdit;
    se_Radius: TSpinEdit;
    lbl_Left: TLabel;
    lbl_Top: TLabel;
    lbl_Radius: TLabel;
    lbl_Hour: TLabel;
    lbl_Minute: TLabel;
    lbl_Second: TLabel;
    se_Hour: TSpinEdit;
    se_Minute: TSpinEdit;
    se_Second: TSpinEdit;
    btn_Run: TBitBtn;
    lbl7: TLabel;
    lbl_Size: TLabel;
    se_Size: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure DrawPointer(nHour, nMinute, nSecond: Integer);
    procedure tmr_ClockTimer(Sender: TObject);
    procedure se_LeftChange(Sender: TObject);
    procedure rg_StyleClick(Sender: TObject);
    procedure se_SecondChange(Sender: TObject);
    procedure btn_RunClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  frmMainForm: TfrmMainForm;
  HourValue, MinuteValue, SecondValue: Integer; //时针、分针、秒针值
  HourWidth, MinuteWidth, SecondWidth: Integer; //时针、分针、秒针宽度
  isEnable: Boolean;  //是否运行
  Radius: Integer; //半径
  ClockLeft, ClockTop: Integer; //时钟起始位置
  StyleClock: (NumberStyle, PointerStyle); //时针风格
implementation

{$R *.dfm}
{-------------------------------------------------------------------------------
  过程名:    TfrmMainForm.FormCreate
  功能:      窗体创建初始化
  参数:      Sender: TObject
  返回值:    无
  更新说明:
  2011.02.22  wjs  Add 创建此过程
-------------------------------------------------------------------------------}

procedure TfrmMainForm.FormCreate(Sender: TObject);
begin
  isEnable := True;
  HourValue := StrToInt(FormatDateTime('hh', Now));
  MinuteValue := StrToInt(FormatDateTime('nn', Now));
  SecondValue := StrToInt(FormatDateTime('ss', Now));
  HourWidth := 3;
  MinuteWidth := 2;
  SecondWidth := 1;
  Radius := 50;
  ClockLeft := 15;
  ClockTop := 15;
  StyleClock := PointerStyle;
  se_Left.Value := ClockLeft;
  se_Top.Value := ClockTop;
  se_Radius.Value := Radius;
  se_Size.Value := 11;
  se_Size.Top := se_Radius.Top;
  lbl_Size.Top := lbl_Radius.Top;
  se_Size.Visible := False;
  lbl_Size.Visible := False;
end;

{-------------------------------------------------------------------------------
  过程名:    TfrmMainForm.FormPaint
  功能:      窗体绘制函数
  参数:      Sender: TObject
  返回值:    无
  更新说明:
  2011.02.22  wjs  Add 创建此过程
-------------------------------------------------------------------------------}

procedure TfrmMainForm.FormPaint(Sender: TObject);
var
  i,OriginalSzie: Integer;
  RadiusPoint: TPoint;
begin
  if StyleClock = PointerStyle then
  begin
    Self.Canvas.Pen.Width := 3;
    Self.Canvas.Ellipse(ClockLeft, ClockTop, ClockLeft + Radius * 2, ClockTop + Radius * 2);
    Self.Canvas.Pen.Width := 1;
    Self.Canvas.Pen.Style := psDot;
    Self.Canvas.Ellipse(ClockLeft + 20, ClockTop + 20, ClockLeft + Radius * 2 - 20, ClockTop + Radius * 2 - 20);
    Self.Canvas.Pen.Width := 2;
    Self.Canvas.Pen.Style := psSolid;
    RadiusPoint.X := ClockLeft + Radius;
    RadiusPoint.Y := ClockTop + Radius;
    for i := 1 to 12 do
    begin
      Self.Canvas.Ellipse(Round(RadiusPoint.X + (Radius - 20) * Sin(i * pi / 6)) - 1, Round(RadiusPoint.Y - (Radius - 20) * Cos(i * pi / 6)) - 1, Round(RadiusPoint.X + (Radius - 20) * Sin(i * pi / 6)) + 2, Round(RadiusPoint.Y - (Radius - 20) * Cos(i * pi / 6)) + 2);
      case i of
        1: Self.Canvas.TextOut(Round(RadiusPoint.X + (Radius - 20) * Sin(i * pi / 6)) + 2, Round(RadiusPoint.Y - (Radius - 20) * Cos(i * pi / 6)) - 13, IntToStr(i));
        2: Self.Canvas.TextOut(Round(RadiusPoint.X + (Radius - 20) * Sin(i * pi / 6)) + 4, Round(RadiusPoint.Y - (Radius - 20) * Cos(i * pi / 6)) - 10, IntToStr(i));
        3: Self.Canvas.TextOut(Round(RadiusPoint.X + (Radius - 20) * Sin(i * pi / 6)) + 5, Round(RadiusPoint.Y - (Radius - 20) * Cos(i * pi / 6)) - 6, IntToStr(i));
        4: Self.Canvas.TextOut(Round(RadiusPoint.X + (Radius - 20) * Sin(i * pi / 6)) + 3, Round(RadiusPoint.Y - (Radius - 20) * Cos(i * pi / 6)) - 2, IntToStr(i));
        5: Self.Canvas.TextOut(Round(RadiusPoint.X + (Radius - 20) * Sin(i * pi / 6)) + 3, Round(RadiusPoint.Y - (Radius - 20) * Cos(i * pi / 6)) + 1, IntToStr(i));
        6: Self.Canvas.TextOut(Round(RadiusPoint.X + (Radius - 20) * Sin(i * pi / 6)) - 3, Round(RadiusPoint.Y - (Radius - 20) * Cos(i * pi / 6)) + 3, IntToStr(i));
        7: Self.Canvas.TextOut(Round(RadiusPoint.X + (Radius - 20) * Sin(i * pi / 6)) - 7, Round(RadiusPoint.Y - (Radius - 20) * Cos(i * pi / 6)) + 2, IntToStr(i));
        8: Self.Canvas.TextOut(Round(RadiusPoint.X + (Radius - 20) * Sin(i * pi / 6)) - 10, Round(RadiusPoint.Y - (Radius - 20) * Cos(i * pi / 6)) - 1, IntToStr(i));
        9: Self.Canvas.TextOut(Round(RadiusPoint.X + (Radius - 20) * Sin(i * pi / 6)) - 11, Round(RadiusPoint.Y - (Radius - 20) * Cos(i * pi / 6)) - 5, IntToStr(i));
        10: Self.Canvas.TextOut(Round(RadiusPoint.X + (Radius - 20) * Sin(i * pi / 6)) - 14, Round(RadiusPoint.Y - (Radius - 20) * Cos(i * pi / 6)) - 11, IntToStr(i));
        11: Self.Canvas.TextOut(Round(RadiusPoint.X + (Radius - 20) * Sin(i * pi / 6)) - 10, Round(RadiusPoint.Y - (Radius - 20) * Cos(i * pi / 6)) - 14, IntToStr(i));
        12: Self.Canvas.TextOut(Round(RadiusPoint.X + (Radius - 20) * Sin(i * pi / 6)) - 6, Round(RadiusPoint.Y - (Radius - 20) * Cos(i * pi / 6)) - 15, IntToStr(i));
      end;
    end;
    Self.Canvas.Ellipse(RadiusPoint.X - 3, RadiusPoint.Y - 3, RadiusPoint.X + 3, RadiusPoint.Y + 3);
    DrawPointer(HourValue, MinuteValue, SecondValue);
  end
  else
  begin
    OriginalSzie := Self.Canvas.Font.Size;
    Self.Canvas.Font.Size := se_Size.Value;
    Self.Canvas.TextOut(ClockLeft,ClockTop,IntToStr(HourValue)+':'+Format('%.2d',[MinuteValue])+':'+Format('%.2d',[SecondValue]));
    Self.Canvas.Font.Size := OriginalSzie;
  end;
end;

{-------------------------------------------------------------------------------
  过程名:    TfrmMainForm.DrawPointer
  功能:      绘制指针
  参数:      nHour, nMinute, nSecond: Integer
  返回值:    无
  更新说明:
  2011.02.22  wjs  Add 创建此过程
-------------------------------------------------------------------------------}

procedure TfrmMainForm.DrawPointer(nHour, nMinute, nSecond: Integer);
var
  RadiusPoint: TPoint;
begin
  RadiusPoint.X := ClockLeft + Radius;
  RadiusPoint.Y := ClockTop + Radius;
  Self.Canvas.Pen.Color := clBlack;
  Self.Canvas.Pen.Width := SecondWidth;
  Self.Canvas.MoveTo(Round(RadiusPoint.X - 7 * Sin(nSecond * Pi / 30)), Round(RadiusPoint.Y + 7 * Cos(nSecond * Pi / 30)));
  Self.Canvas.LineTo(Round(RadiusPoint.X + (Radius - 7) * Sin(nSecond * pi / 30)), Round(RadiusPoint.Y - (Radius - 7) * Cos(nSecond * pi / 30)));
  Self.Canvas.Pen.Width := MinuteWidth;
  Self.Canvas.MoveTo(Round(RadiusPoint.X - 1 * Sin(nMinute * Pi / 30)), Round(RadiusPoint.Y + 1 * Cos(nMinute * Pi / 30)));
  Self.Canvas.LineTo(Round(RadiusPoint.X + (Radius - 12) * Sin(nMinute * pi / 30)), Round(RadiusPoint.Y - (Radius - 12) * Cos(nMinute * pi / 30)));
  Self.Canvas.Pen.Width := HourWidth;
  Self.Canvas.MoveTo(Round(RadiusPoint.X - 1 * Sin(((nHour mod 12) * 5 + nMinute / 12) * Pi / 30)), Round(RadiusPoint.Y + 1 * Cos(((nHour mod 12) * 5 + nMinute / 12) * Pi / 30))); //转换成跟分针、秒针一样的60格制
  Self.Canvas.LineTo(Round(RadiusPoint.X + (Radius - 20) * Sin(((nHour mod 12) * 5 + nMinute / 12) * Pi / 30)), Round(RadiusPoint.Y - (Radius - 20) * Cos(((nHour mod 12) * 5 + nMinute / 12) * Pi / 30)));
end;

{-------------------------------------------------------------------------------
  过程名:    TfrmMainForm.tmr1Timer
  功能:      定时器走动时钟
  参数:      Sender: TObject
  返回值:    无
  更新说明:
  2011.02.22  wjs  Add 创建此过程
-------------------------------------------------------------------------------}

procedure TfrmMainForm.tmr_ClockTimer(Sender: TObject);
var
  rc: TRect;
  OriginalSzie: Integer;
  FontSize:TSize;
begin
  SecondValue := SecondValue + 1;
  if SecondValue = 60 then
  begin
    SecondValue := 0;
    MinuteValue := MinuteValue + 1;
    if MinuteValue = 60 then
    begin
      MinuteValue := 0;
      HourValue := HourValue + 1;
      if HourValue = 24 then
        HourValue := 0;
    end;
  end;
  rc.Left := ClockLeft;
  rc.Top := ClockTop;
  if StyleClock = PointerStyle then
  begin
    rc.Right := rc.Left + Radius * 2;
    rc.Bottom := rc.Top + Radius * 2;
  end
  else
  begin
    OriginalSzie := Self.Canvas.Font.Size;
    Self.Canvas.Font.Size := se_Size.Value;
    GetTextExtentPoint32(Self.Canvas.Handle,PChar(IntToStr(HourValue)+':'+Format('%.2d',[MinuteValue])+':'+Format('%.2d',[SecondValue])),Length(IntToStr(HourValue)+':'+Format('%.2d',[MinuteValue])+':'+Format('%.2d',[SecondValue])),FontSize);
    rc.Right := rc.Left + FontSize.cx;
    rc.Bottom := rc.Top + FontSize.cy;
    Self.Canvas.Font.Size := OriginalSzie;
  end;
  InvalidateRect(Self.Handle, @rc, True);
end;

{-------------------------------------------------------------------------------
  过程名:    TfrmMainForm.se1Change
  功能:      时钟位置改动
  参数:      Sender: TObject
  返回值:    无
  更新说明:
  2011.02.22  wjs  Add 创建此过程
-------------------------------------------------------------------------------}
procedure TfrmMainForm.se_LeftChange(Sender: TObject);
begin
  ClockLeft := se_Left.Value;
  ClockTop := se_Top.Value;
  Radius := se_Radius.Value;
  if StyleClock = PointerStyle then
  begin
    if (ClockLeft + Radius * 2 + 40) > grp_Set.Left then
    begin
      Self.Width := Self.Width + (ClockLeft + Radius * 2 + 40) - grp_Set.Left;
      grp_Set.Left := grp_Set.Left +((ClockLeft + Radius * 2 + 40) - grp_Set.Left);
      bvl1.Left := grp_Set.Left - 16;
    end;
    if (ClockTop + Radius * 2 + 38) > rg_Style.Top then
    begin
      rg_Style.Top := rg_Style.Top + ((ClockTop + Radius * 2 + 38) - rg_Style.Top);
      Self.Height := rg_Style.Top + 132;
      bvl2.Top := rg_Style.Top - 12;
    end;
  end;
  Self.Invalidate;
end;

{-------------------------------------------------------------------------------
  过程名:    TfrmMainForm.rg1Click
  功能:      时钟显示模式变化        
  参数:      Sender: TObject
  返回值:    无
  更新说明:
  2011.02.23  wjs  Add 创建此过程
-------------------------------------------------------------------------------}
procedure TfrmMainForm.rg_StyleClick(Sender: TObject);
begin
  if (rg_Style.ItemIndex = 0) and (StyleClock<>PointerStyle) then
  begin
    StyleClock := PointerStyle;
    lbl_Radius.Visible := True;
    lbl_Size.Visible := False;
    se_Radius.Visible := True;
    se_Size.Visible := False;
    Self.Invalidate;
  end
  else
  begin
    if StyleClock<>NumberStyle then
    begin
      StyleClock := NumberStyle;
      lbl_Radius.Visible := False;
      lbl_Size.Visible := True;
      se_Radius.Visible := False;
      se_Size.Visible := True;
      Self.Invalidate;
    end;
  end;
end;

{-------------------------------------------------------------------------------
  过程名:    TfrmMainForm.se6Change
  功能:      调整时间        
  参数:      Sender: TObject
  返回值:    无
  更新说明:
  2011.02.23  wjs  Add 创建此过程
-------------------------------------------------------------------------------}
procedure TfrmMainForm.se_SecondChange(Sender: TObject);
begin
  HourValue := se_Hour.Value;
  MinuteValue := se_Minute.Value;
  SecondValue := se_Second.Value;
  Self.Invalidate;
end;

{-------------------------------------------------------------------------------
  过程名:    TfrmMainForm.btn_RunClick
  功能:      开启运行暂停
  参数:      Sender: TObject
  返回值:    无
  更新说明:
  2011.02.23  wjs  Add 创建此过程
-------------------------------------------------------------------------------}
procedure TfrmMainForm.btn_RunClick(Sender: TObject);
begin
  if isEnable then
  begin
    isEnable := False;
    btn_Run.Kind := bkNo;
    btn_Run.Caption := '暂停';
    tmr_Clock.Enabled := False;
  end
  else
  begin
    isEnable := True;
    btn_Run.Kind := bkOK;
    btn_Run.Caption := '运行';
    tmr_Clock.Enabled := true;
  end;
end;

end.

