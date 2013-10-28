unit psCode2D;

interface

uses Classes, Graphics, Windows, psTypes, psCodeFNLite;

type

  TpsMatrix=class(TPersistent)
  private
    NC          : integer;  // total columns
    NR          : integer;  // total rows
    idxOut      : Integer;
  public
    Zoom1,Zoom2 : Integer;
    DrawingRect : TRect;
    cx,cy       : Integer;
    Pixels      : array of Char;
    PixelsBackup: array of Char;
    constructor   Create;
    destructor    Destroy; override;
    procedure     Initialize; virtual;
    procedure     InitializeWH(aWidth,aHeight:Integer); virtual;

    procedure   Clear;
    procedure   Backup;
    procedure   Restore;
    procedure   PutChar(ch:Char);
    procedure   Point2D(X,Y:Integer;  Value:Char );
    procedure   Line2D_H(X1,Y1,W:Integer; Color:Char);
    procedure   Line2D_V(X1,Y1,H:Integer; Color:Char);
    procedure   Rect2D(X1,Y1,X2,Y2:Integer; Color:Char);
    function    GetPoint2D(x,y:Integer):Char;
    procedure   SetDrawingParams(R:TRect); virtual;
    procedure   Rotate(Angle:Double);
    procedure   ConvertToBW;
    property    TotalColumns: Integer read NC;
    property    TotalRows:    Integer read NR;
    function    IsFunction(x,y:Integer): Boolean;
    function    IsData(x,y:Integer): Boolean;
    function    IsBlack(x,y:Integer): Boolean;

    procedure   Paint(C:TCanvas; R:TRect; rc:TPoint; BarcodeObject:TComponent);
  end;

implementation

uses psBarcodeComp;

procedure TpsMatrix.Initialize;
begin
    cx          := NC div 2;
    cy          := cx;
    Clear;
end;

procedure TpsMatrix.InitializeWH(aWidth,aHeight:Integer);
begin
  NC := aWidth;
  NR := aHeight;
  Initialize;
end;

function TpsMatrix.IsBlack(x, y: Integer): Boolean;
begin
    Result := ((Ord(GetPoint2D(x,y))-Ord0) mod 2)=1;
end;

function TpsMatrix.IsData(x, y: Integer): Boolean;
begin
    Result := GetPoint2D(x,y)<='1';
end;

function TpsMatrix.IsFunction(x, y: Integer): Boolean;
begin
    Result := GetPoint2D(x,y)>'1';
end;

procedure TpsMatrix.Point2D(X,Y:Integer;Value:Char);
begin
  if (x<0) or (x>=NC) or (y<0) or (y>=NR) then Exit;
  Pixels[NC*y + x] := Value;
end;

procedure TpsMatrix.Paint(C: TCanvas; R: TRect; rc:TPoint; BarcodeObject:TComponent);
var x,y           : Integer;
    R1            : TRect;
    modul_char    : Char;
    colorB,colorW : TColor;
    px_color      : TColor;
    use_x, use_y  : Integer;
    bc            : TpsBarcodeComponent;
begin
  bc := BarcodeObject as TpsBarcodeComponent;

  if boReflectanceReversal in bc.Options then begin
    colorW:=bc.LinesColor;
    colorB:=bc.BackGroundColor;
  end else begin
    colorB:=bc.LinesColor;
    colorW:=bc.BackGroundColor;
 end;

  // colorW := clWhite;
  // colorB := clBlack;

  SetDrawingParams(R);

  C.Pen.Style   := psClear;

  // if not (ps2DPaintColor in Options) then ConvertToBW;

{ TODO : Toto potom opravit tak, aby to netlacilo farebne }

  for x:=0 to NC-1 do
    for y:=0 to NR-1 do begin
        use_x := iif(boFlipHorizontal in bc.Options, NC-1-x, x);
        use_y := iif(boFlipVertical in bc.Options, NR-1-y, y);

        //use_x := x;
        //use_y := y;

        modul_char := GetPoint2D(use_x,use_y);
        R1.Left  :=DrawingRect.Left + MulDiv(x,Zoom1,Zoom2);
        R1.Top   :=DrawingRect.Top  + MulDiv(y,Zoom1,Zoom2);
        R1.Right :=DrawingRect.Left + MulDiv(x+1,Zoom1,Zoom2) ;
        R1.Bottom:=DrawingRect.Top  + MulDiv(y+1,Zoom1,Zoom2) ;

        px_color := clRed;
        { TODO : opravit na mod 2 }
        case (Ord(modul_char)-Ord0) mod 2  of
            0,2,4,6,8     : px_color := ColorW;
            1,3,5,7,9     : px_color := ColorB;
            10    : px_color := clYellow;
            11    : px_color := clMaroon;
            12    : px_color := clSilver;
            13    : px_color := clGreen;
            20    : px_color := clRed;
        end;

        if (px_color=colorW) and (boTransparent in bc.Options)then
            Continue;

        C.Brush.Color := px_color;
        if bc.Angle<>0 then
            DrawRotatedRect(C,R1,rc,bc.Angle)
        else
            C.FillRect(R1);

        if (Modul_char>='A') and (Modul_Char<='Z') then
          C.TextRect(R1,R1.Left,R1.Top,modul_char);
    end;
end;


procedure TpsMatrix.Line2D_H(X1, Y1, W: Integer; Color: Char);
var i:Integer;
begin
  for i:=X1 to X1+W do
    Point2D(i,Y1,Color);
end;

procedure TpsMatrix.Line2D_V(X1, Y1, H: Integer; Color: Char);
var i:integer;
begin
  for i:=Y1 to Y1+H do
    Point2D(X1,i,Color);
end;

procedure TpsMatrix.Rect2D(X1, Y1, X2, Y2: Integer; Color: Char);
begin
  Line2D_H(X1,Y1, X2-X1,Color);
  Line2D_V(X2,Y1, Y2-Y1,Color);
  Line2d_H(X1,Y2, X2-X1,Color);
  Line2D_V(X1,Y1, Y2-Y1,Color);
end;

procedure TpsMatrix.Restore;
var i:Integer;
begin
    // Move(PixelsBackup, Pixels, Length(Pixels));
    for I := 0 to Length(Pixels)- 1 do
      Pixels[i]:=PixelsBackup[i];
end;

function TpsMatrix.GetPoint2D(x, y: Integer): Char;
begin
  if (x>=0) and (x<NC) and (y>=0) and (y<NR) then
    Result := Pixels[ NC*y+x]
  else
    Result := ' ';
end;


procedure TpsMatrix.SetDrawingParams(R: TRect);
var // dx,dy:Integer;
    zx:Double;
    // qx,qy:Integer;
begin
  if (NC<=0) or (NR<=0) then Exit;

{  if psAddQuietZone in Options then begin
    qx := (R.Right-R.Left) div ( NC+2);
    qy := (R.Bottom-R.Top) div ( NR+2);
    Inc(R.Left,  qx);
    Dec(R.Right, qx);
    Inc(R.Top,   qy);
    Dec(R.Bottom,qy);
  end;
}
  DrawingRect := R;

  zx:=(R.Right-R.Left)/NC;
  if NR*zx>=(R.Bottom-R.Top) then
    zx := (R.Bottom-R.Top)/NR;

  Zoom1 := Trunc(constZoomFactor*zx);
  Zoom2 := constZoomFactor;

{  if ps2DCenter in Options then begin
    dx := (R.Right-R.Left-MulDiv(NC,Zoom1,constZoomFactor)) div 2;
    dy := (R.Bottom-R.Top-MulDiv(NR,Zoom1,constZoomFactor)) div 2;

    with DrawingRect do begin
      Inc(Left,dx);
      Dec(Right,dx);
      Inc(Top,dy);
      Dec(Bottom,dy);
    end;
  end;
}
end;

procedure TpsMatrix.Rotate(Angle: Double);
begin
  { TODO : Dorobit rotaciu, reflectance, flip, etc. }
  {}
end;

procedure TpsMatrix.ConvertToBW;
// convert from psoft training mode to black/white ....
// 0,2,4,6,8 is space, but 2,4,6,8 is in control, separator, timing pattern zone,
//  alignment, finder etc...
// only 0 and 1 is right for print....
var i : integer;
begin
  for i:=0 to NR*NC-1 do
    Pixels[i] := Chr( Ord0+(Ord(Pixels[i]) mod 2) );
end;

function GetSeparate(s:string):String;
var i:Integer;
begin
        Result :='';
        i:=1;
        while i<=Length(s) do begin
                Result:=Result+' '+Copy(s,i,8);
                Inc(i,8);
        end;
end;


constructor TpsMatrix.Create;
begin
  inherited;
end;

destructor TpsMatrix.Destroy;
begin
  inherited;
end;

procedure TpsMatrix.Backup;
var i:Integer;
begin
//    Move(Pixels, PixelsBackup, Length(Pixels));
    for I := 0 to Length(Pixels)- 1 do
      PixelsBackup[i]:=Pixels[i];
end;

procedure TpsMatrix.Clear;
var i:Integer;
begin
  SetLength(Pixels, NR*NC);
  SetLength(PixelsBackup, NR*NC);
  for i:=0 to NR*NC-1 do begin
      Pixels[i]       := '0';
      PixelsBackup[i] := '0';
  end;
  idxOut := 0;
end;

procedure TpsMatrix.PutChar(ch: Char);
begin
  Pixels[idxOut]:=ch;
  Inc(idxOut);
end;


end.
