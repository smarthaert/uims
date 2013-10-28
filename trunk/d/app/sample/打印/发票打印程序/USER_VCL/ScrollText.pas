{----------------------------------------------------------
 TScrollText: Version 1.0  14 October, 1996.
 by Darryl West (dwest@dot.net.au)
 ----------------------------------------------------------
 This component is released as Freeware. It was developed
 using Delphi 2. If you have any suggestions, comments or
 bugs please E-mail me.
 ----------------------------------------------------------}
unit ScrollText;
interface
uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls;

type
  TTextStyle = (tsNormal, tsRaised, tsLowered, tsShaddow);
  TScrollDirection = (sdStatic, sdRightToLeft, sdLeftToRight, sdTopToBottom, sdBottomToTop);
  TAlignment = (taCenter, taLeftJustify, taRightJustify);

  TCustomScrollText = class(TGraphicControl)
  private
    FAlignment: TAlignment;
    FTextStyle: TTextStyle;
    FScrollDirection: TScrollDirection;
    FTimer: TTimer;
    FItems: TStringList;
    FColor: TColor;
    FContinuous: Boolean;
    FFont: TFont;
    FOnBegin, FOnStep, FOnEnd: TNotifyEvent;
    FSteps, FSpeed, FDepth, LineHi, FCurrentStep, FTextWidth,
      FTextHeight, XPos, YPos: Integer;
    procedure SetAlignment(Value: TAlignment);
    procedure SetContinuous(Value: Boolean);
    procedure SetItems(Value: TStringList);
    procedure DataChanged;
    procedure SetTextStyle(Value: TTextStyle);
    procedure SetDirection(Value: TScrollDirection);
    procedure SetSteps(Value: Integer);
    procedure SetSpeed(Value: Integer);
    procedure SetColor(Value: TColor);
    procedure SetFont(Value: TFont);
    procedure SetDepth(Value: Integer);
    procedure SetSizeParams;
    procedure FontChanged(Sender: TObject);
    procedure DoTextOut(ACanvas: TCanvas; X, Y: Integer; AText: string);
  protected
    procedure Paint; override;
    procedure TimerTick(Sender: TObject);
    property Alignment: TAlignment read FAlignment write SetAlignment;
    property Depth: Integer read FDepth write SetDepth default 1;
    property ScrollDirection: TScrollDirection read FScrollDirection
      write SetDirection default sdRightToLeft;
    property Items: TStringList read FItems write SetItems;
    property OnBegin: TNotifyEvent read FOnBegin write FOnBegin;
    property OnStep: TNotifyEvent read FOnStep write FOnStep;
    property OnEnd: TNotifyEvent read FOnEnd write FOnEnd;
  public
    property CurrentStep: Integer read FCurrentStep;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ReverseDirection;
    procedure ScrollStart(StartingStep: Integer);
    procedure ScrollStop;
  published
    property TextStyle: TTextStyle read FTextStyle write SetTextStyle default tsNormal;
    property Steps: Integer read FSteps write SetSteps default 66;
    property Speed: Integer read FSpeed write SetSpeed default 200;
    property Color: TColor read FColor write SetColor default clBtnFace;
    property Continuous: Boolean read FContinuous write SetContinuous;
    property Font: TFont read FFont write SetFont;
  end;

  TScrollText = class(TCustomScrollText)
  published
    property Align;
    property Alignment;
    property Color;
    property Depth;
    property Items;
    property TextStyle;
    property ParentShowHint;
    property Font;
    property ScrollDirection;
    property ShowHint;
    property Speed;
    property Steps;
    property Visible;
    property OnBegin;
    property OnStep;
    property OnEnd;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('ScrollText', [TScrollText]);
end;

constructor TCustomScrollText.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csOpaque];
  FItems := TStringList.Create;
  FItems.Add('ScrollText');

  Width := 200;
  Height := 20;
  FColor := clBtnFace;
  FSteps := 80;
  FCurrentStep := 0;
  FDepth := 1;
  FContinuous := True;
  FTextStyle := tsNormal;
  FAlignment := taCenter;

  FFont := TFont.Create;
  with FFont do begin
    Name := 'Arial';
    Size := 10;
    Color := clBlack;
  end;
  FFont.OnChange := FontChanged;

  FTimer := TTimer.Create(Self);
  FSpeed := 100;
  with FTimer do begin
    Enabled := False;
    OnTimer := TimerTick;
    Interval := FSpeed;
  end;

  FScrollDirection := sdRightToLeft;
  SetDirection(FScrollDirection); { Start scrolling if necessary. }
end;

destructor TCustomScrollText.Destroy;
begin
  FItems.Free;
  FTimer.Free;
  FFont.Free;
  inherited Destroy;
end;

procedure TCustomScrollText.SetItems(Value: TStringList);
begin
  if FItems <> Value then begin
    FItems.Assign(Value);
    DataChanged;
  end;
end;

procedure TCustomScrollText.DoTextOut(ACanvas: TCanvas; X, Y: Integer; AText: string);
var TextAdjustment: Integer;
begin
  with ACanvas do begin
    Font := FFont;
    Brush.Style := bsClear;

    if FAlignment = taCenter then
      TextAdjustment := Round((FTextWidth / 2) - (TextWidth(AText) / 2))
    else if FAlignment = taRightJustify then
      TextAdjustment := Round(FTextWidth - TextWidth(AText))
    else TextAdjustment := 0;

    case FTextStyle of
      tsRaised: begin
        Font.Color := clBtnHighlight;
        TextOut(X - FDepth + TextAdjustment, Y - FDepth, AText);
        Font.Color := clBtnShadow;
        TextOut(X + FDepth + TextAdjustment, Y + FDepth, AText);
      end;
      tsLowered: begin
        Font.Color := clBtnShadow;
        TextOut(X - FDepth + TextAdjustment, Y - FDepth, AText);
        Font.Color := clBtnHighlight;
        TextOut(X + FDepth + TextAdjustment, Y + FDepth, AText);
      end;
      tsShaddow: begin
        Font.Color := clBtnShadow;
        TextOut(X + FDepth + TextAdjustment, Y + FDepth, AText);
      end;
    end;
    Font.Color := FFont.Color;
    TextOut(X + TextAdjustment, Y, AText);
  end;
end;

procedure TCustomScrollText.Paint;
var TmpBmp: TBitMap;
    StartXPos, StartYPos, I: Integer;
    PercentDone: Double;
begin
  SetSizeParams;
  TmpBmp := TBitMap.Create;
  try
    TmpBmp.Width := Width;
    TmpBmp.Height := Height;
    with TmpBmp.Canvas do begin
      Font := FFont;
      Brush.Color := FColor;
      Brush.Style := bsSolid;
      FillRect(ClipRect);
    end;

    if FTextWidth >= Width then XPos := 0 else XPos := (Width - FTextWidth) div 2;
    if FTextHeight >= Height then YPos := 0 else YPos := (Height - FTextHeight) div 2;

    if csDesigning in ComponentState then PercentDone := 0.5 
    else PercentDone := FCurrentStep / FSteps;

    case FScrollDirection of
      sdRightToLeft: begin
        StartYPos := YPos;
        StartXPos := Round((FTextWidth + Width) * (1 - PercentDone)) - FTextWidth;
      end;
      sdLeftToRight: begin
        StartYPos := YPos;
        StartXPos := Round((FTextWidth + Width) * PercentDone) - FTextWidth;
      end;
      sdBottomToTop: begin
        StartXPos := XPos;
        StartYPos := Round((FTextHeight + Height) * (1 - PercentDone)) - FTextHeight;
      end;
      sdTopToBottom: begin
        StartXPos := XPos;
        StartYPos := Round((FTextHeight + Height) * PercentDone) - FTextHeight;
      end;
      else begin { static }
        StartXPos := XPos;
        StartYPos := YPos;
      end
    end;

    I := 0;
    while I < FItems.Count do begin
      DoTextOut(TmpBmp.Canvas, StartXPos, StartYPos, FItems.Strings[I]);
      Inc(StartYPos, LineHi);
      Inc(I);
    end;
    Canvas.Draw(0, 0, TmpBmp);
  finally
    TmpBmp.Free;
  end;
end;

procedure TCustomScrollText.SetSizeParams;
var S: String;
    I, SWidth: Integer;
    Metrics: TTextMetric;
begin
  with Canvas do begin
    Font := FFont;
    GetTextMetrics(Handle, Metrics);
    LineHi := Metrics.tmHeight + Metrics.tmInternalLeading;
    if FTextStyle in [tsRaised, tsLowered] then LineHi := LineHi + 2 * FDepth
    else if FTextStyle in [tsShaddow] then LineHi := LineHi + FDepth;
  end;
  FTextWidth := 0;
  I := 0;
  while I < FItems.Count do begin
    S := FItems.Strings[I];
    SWidth := Canvas.TextWidth(S);
    if FTextStyle in [tsRaised, tsLowered] then SWidth := SWidth + 2 * FDepth
    else if FTextStyle in [tsShaddow] then SWidth := SWidth + FDepth;
    if FTextWidth < SWidth then FTextWidth := SWidth;
    Inc(I);
  end;
  FTextHeight := LineHi * FItems.Count;
  if FTextWidth >= Width then XPos := 0 else XPos := (Width - FTextWidth) div 2;
  if FTextHeight >= Height then YPos := 0 else YPos := (Height - FTextHeight) div 2;
end;

procedure TCustomScrollText.DataChanged;
begin
  SetSizeParams;
  Invalidate;
end;

procedure TCustomScrollText.SetTextStyle(Value: TTextStyle);
begin
  if FTextStyle <> Value then begin
    FTextStyle := Value;
    DataChanged;
  end;
end;

procedure TCustomScrollText.SetDirection(Value: TScrollDirection);
begin
  if FScrollDirection <> Value then begin
    FScrollDirection := Value;
  end;
  if FScrollDirection = sdStatic then ScrollStop
  else ScrollStart(FCurrentStep);
end;

procedure TCustomScrollText.SetContinuous(Value: Boolean);
begin
  if FContinuous <> Value then begin
    FContinuous := Value;
    if FScrollDirection <> sdStatic then ScrollStart(FCurrentStep);
  end;
end;

procedure TCustomScrollText.SetSteps(Value: Integer);
begin
  if FSteps <> Value then begin
    FSteps := Value;
    if csDesigning in ComponentState then Invalidate;
  end;
end;

procedure TCustomScrollText.SetSpeed(Value: Integer);
begin
  if FSpeed <> Value then begin
    if Value > 1000 then Value := 1000
    else if Value < 1 then Value := 1;
    FSpeed := Value;
    if FTimer <> nil then FTimer.Interval := FSpeed;
  end;
end;

procedure TCustomScrollText.SetColor(Value: TColor);
begin
  if FColor <> Value then begin
    FColor := Value;
    DataChanged;
  end;
end;

procedure TCustomScrollText.FontChanged(Sender: TObject);
begin
  DataChanged;
end;

procedure TCustomScrollText.SetFont(Value: TFont);
begin
  if FFont <> Value then begin
    FFont.Assign(Value);
    DataChanged;
  end;
end;

procedure TCustomScrollText.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then begin
    FAlignment := Value;
    DataChanged;
  end;
end;

procedure TCustomScrollText.SetDepth(Value: Integer);
begin
  if FDepth <> Value then begin
    FDepth := Value;
    DataChanged;
  end;
end;

procedure TCustomScrollText.ScrollStart(StartingStep: Integer);
begin
  if FTimer.Enabled then Exit;
  if (StartingStep >= 0) and (StartingStep <= FSteps) then FCurrentStep := StartingStep;
  FTimer.Enabled := True;
end;

procedure TCustomScrollText.ScrollStop;
begin
  FTimer.Enabled := False;
end;

procedure TCustomScrollText.ReverseDirection;
begin
  if FScrollDirection = sdStatic then Exit;
  FCurrentStep := FSteps - FCurrentStep;
  case FScrollDirection of
    sdLeftToRight: FScrollDirection := sdRightToLeft;
    sdRightToLeft: FScrollDirection := sdLeftToRight;
    sdTopToBottom: FScrollDirection := sdBottomToTop;
    sdBottomToTop: FScrollDirection := sdTopToBottom;
  end;
end;

procedure TCustomScrollText.TimerTick(Sender: TObject);
begin
  if not FTimer.Enabled then Exit;
  if (FCurrentStep = 0) and Assigned(FOnBegin) then FOnBegin(Self);
  Inc(FCurrentStep);
  Paint;
  if Assigned(FOnStep) then FOnStep(Self);
  if FCurrentStep > FSteps then begin
    FTimer.Enabled := False;
    if Assigned(FOnEnd) then FOnEnd(Self);
    FCurrentStep := 0;
    if FContinuous then ScrollStart(FCurrentStep);
  end;
end;

end.
