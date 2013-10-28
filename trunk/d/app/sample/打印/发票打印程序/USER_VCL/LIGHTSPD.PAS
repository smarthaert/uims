unit LightSpd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, ExtCtrls ;

type
  PStar =^TStar;
  TStar =record
    C,         {color}
    X,Y,       {center X,Y}
    W :integer;{width}
    L,T,R,B,   {coordiants}
    S :single; {step}
  end;

  TLightSpeedSpeed =(lsSlower,lsSlow,lsNormal,lsFast,lsFaster,lsLight);
  TLightSpeedOption =(loColored,loMultiplay);
  TLightSpeedOptions = set of TLightSpeedOption;

  TLightSpeed = class(TGraphicControl)
  private
    FStarsCount :byte;
    FBrightness :byte;
    FSpeed :TLightSpeedSpeed;
    FOptions :TLightSpeedOptions;
    FInterval :integer;
    FCenterX,FCenterY :integer;
    FActive :boolean;

    Timer: TTimer;
    Stars: array[1..255] of tStar;
    LX,LY,LS :integer;

    procedure SetInterval (Value :integer);
    procedure SetActive (Value :boolean);

  protected
    procedure Go(Sender: TObject);
    procedure Paint; override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

  published
    property StarsCount :byte read FStarsCount write FStarsCount default 100;
    property Brightness :byte read FBrightness write FBrightness default 96;
    property Speed :TLightSpeedSpeed read FSpeed write FSpeed default lsNormal;
    property Options :TLightSpeedOptions read FOptions write FOptions;
    property Interval :integer read FInterval write SetInterval default 50;
    property Active :boolean read FActive write SetActive default false;
    property ParentShowHint;
    property ShowHint;
    property Color default clBlack;
    property ParentColor;
    property Width default 200;
    property Height default 160;
    property Align default alNone;
    property Visible;
    property CenterX :integer read FCenterX write FCenterX;
    property CenterY :integer read FCenterY write FCenterY;
  end;

procedure Register;

implementation

function Min (X,Y :integer) :integer;
begin
  if X<Y then Min:=X else Min:=Y;
end;

constructor TLightSpeed.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FStarsCount:=100;
  FBrightness:=96;
  FSpeed:=lsNormal;
  FOptions:=[loColored,loMultiplay];
  FInterval:=50;
  FActive:=false;

  Width:=200;
  Height:=160;
  Align:=alNone;
  Color:=clBlack;

  FCenterX:=Width div 2; FCenterY:=Height div 2;
  LX:=Min(FCenterX,FCenterY); LY:=LX;
  LS:=round(sqrt(LX*LX/2));

  randomize;
  fillchar(Stars,sizeof(Stars),$FF);

  Timer:=TTimer.Create(Self);
  Timer.Interval:=0;
  Timer.OnTimer:=Go;
end;

destructor TLightSpeed.Destroy;
begin
  Timer.Free;
  inherited;
end;

procedure TLightSpeed.SetInterval(Value :integer);
begin
  if Value<>FInterval then begin
    FInterval:=Value;
    Timer.Interval:=FInterval;
  end;
end;

procedure TLightSpeed.SetActive(Value :boolean);
begin
  if Value<>FActive then begin
    FActive:=Value;
    if FActive then Timer.Interval:=FInterval
    else Timer.Interval:=0;
  end;
end;

{procedure TLightSpeed.SetColor(Value :tColor);
begin
  if Value<>Color then begin
    Canvas.Brush.Color:=Value;
    Repaint;
  end;
  inherited;
end;
}
procedure TLightSpeed.Paint;
begin
  Canvas.Brush.Color := Color;
  Canvas.FillRect(Rect(0,0,Width,Height));

{  Canvas.Pen.Color := clBtnShadow;
  Canvas.PolyLine([Point(0,Height-1), Point(0,0), Point(Width-1,0)]);

  Canvas.Pen.Color := clBtnHighlight;
  Canvas.PolyLine([Point(Width-1,0), Point(Width-1,Height-1), Point(0,Height-1)]);}
end;

procedure TLightSpeed.Go(Sender: TObject);
var
  Dot :integer;
  red,green,blue :byte;
begin
  LX:=Min(Height div 4,Width div 4); LY:=LX;
  LS:=round(sqrt(LX*LX/2));
  if not Visible and not (csDesigning in ComponentState) then exit;
  for Dot:=1 to 255 do with Stars[Dot] do begin
    if C<>-1 then begin
      {clear line}
      Canvas.Pen.Width:=W;
      Canvas.Pen.Color:=Color;
      Canvas.MoveTo(round(X+L),round(Y+T));
      Canvas.LineTo(round(X+R),round(Y+B));
    end
    else begin
      {define new line}
      if Dot>FStarsCount then continue;
      repeat
        L:=random(LX)-LX div 2;
        T:=random(LY)-LY div 2;
        S:=sqrt(L*L+T*T);
      until (S>6);
      S:=1+succ(ord(FSpeed))/(S*S/LS*5);
      R:=L*S*1.01; B:=T*S*1.01;  {length 1 - 1.1}
      blue:=random($40);
      if loColored in FOptions then begin green:=random($40); red:=random($40); end
      else begin green:=blue; red:=blue; end;
      C:=FBrightness shl 16 + FBrightness shl 8 + FBrightness +
          blue shl 16 + green shl 8 + red;
      W:=1+byte(random(20)=0)+byte(random(20)=0);
    end;
    X:=FCenterX; Y:=FCenterY;
    {draw line}
    L:=L*S; R:=R*S;
    T:=T*S; B:=B*S;

    if loMultiplay in FOptions then begin
      blue := Min($FF, C shr 16          + random(round((S*S*S*S))));
      if loColored in FOptions then begin
        green:= Min($FF, C shr 8 and $FF + random(round((S*S*S*S))));
        red  := Min($FF, C and $FF       + random(round((S*S*S*S))));
      end
      else begin green:=blue; red:=blue; end;
      C:=integer(blue) shl 16 + green shl 8 + red;
    end;

    Canvas.Pen.Width:=W; Canvas.Pen.Color:=C;
    Canvas.MoveTo(round(X+L),round(Y+T));
    Canvas.LineTo(round(X+R),round(Y+B));

    if ((X+L<-5) or (X+L>ClientWidth+5))
    or ((Y+T<-5) or (Y+T>ClientHeight+5))
    then C:=-1;
  end;
end;

procedure Register;
begin
  RegisterComponents('LightSpeed', [TLightSpeed]);
end;

end.
