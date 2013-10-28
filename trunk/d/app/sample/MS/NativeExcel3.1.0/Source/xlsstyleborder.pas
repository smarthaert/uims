//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsstyleborder
//
//
//      Description:  border formatting
//
//////////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2004-2009 NikaSoft. All rights reserved.
//     Author: A.V.Nikulitsa
//
//       site: http://www.nika-soft.com/ 
//     e-mail: support@nika-soft.com
//
//////////////////////////////////////////////////////////////////////////////

unit xlsstyleborder;
{$Q-}
{$R-}

interface
{$I xlsdef.inc}
uses Classes, xlsstylecolor, xlsBlob, xlslist2, xlshashtable;

type 

  TXLSStyleBorder = class;
  
  TXLSStyleBorders = class(TXLSObjectKeyList)
  private
     FColorManager: TXLSColorManager;
     function ColorIndex2InternalColorIndex(const Value: LongWord): LongWord;
     function InternalColorIndex2ColorIndex(const Value: LongWord): LongWord;
  public
     constructor Create(ColorManager: TXLSColorManager);
     destructor Destroy; override;

     function GetBorder(Index: integer): TXLSStyleBorder;
     function SetBorder(Index: integer; Value: TXLSStyleBorder): integer;

     function GetBottomColorIndex(Index: integer): LongWord;
     function GetBottomThemeColor(Index: integer): longword;
     function GetBottomTintAndShade(Index: integer): double;
     function GetBottomColor(Index: integer): longword;
     function GetBottomStyle(Index: integer): byte;
     function GetBottomLineStyle(Index: integer): LongWord;
     function GetBottomWeight(Index: integer): LongWord;

     function GetDiagonalUpColorIndex(Index: integer): LongWord;
     function GetDiagonalUpThemeColor(Index: integer): longword;
     function GetDiagonalUpTintAndShade(Index: integer): double;
     function GetDiagonalUpColor(Index: integer): longword;
     function GetDiagonalUpStyle(Index: integer): byte;
     function GetDiagonalUpLineStyle(Index: integer): LongWord;
     function GetDiagonalUpWeight(Index: integer): LongWord;


     function GetDiagonalDownColorIndex(Index: integer): LongWord;
     function GetDiagonalDownThemeColor(Index: integer): longword;
     function GetDiagonalDownTintAndShade(Index: integer): double;
     function GetDiagonalDownColor(Index: integer): longword;
     function GetDiagonalDownStyle(Index: integer): byte;
     function GetDiagonalDownLineStyle(Index: integer): LongWord;
     function GetDiagonalDownWeight(Index: integer): LongWord;

     function GetTopColorIndex(Index: integer): LongWord;
     function GetTopThemeColor(Index: integer): longword;
     function GetTopTintAndShade(Index: integer): double;
     function GetTopColor(Index: integer): longword;
     function GetTopStyle(Index: integer): byte;
     function GetTopLineStyle(Index: integer): LongWord;
     function GetTopWeight(Index: integer): LongWord;

     function GetLeftColorIndex(Index: integer): LongWord;
     function GetLeftThemeColor(Index: integer): longword;
     function GetLeftTintAndShade(Index: integer): double;
     function GetLeftColor(Index: integer): longword;
     function GetLeftStyle(Index: integer): byte;
     function GetLeftLineStyle(Index: integer): LongWord;
     function GetLeftWeight(Index: integer): LongWord;

     function GetRightColorIndex(Index: integer): LongWord;
     function GetRightThemeColor(Index: integer): longword;
     function GetRightTintAndShade(Index: integer): double;
     function GetRightColor(Index: integer): longword;
     function GetRightStyle(Index: integer): byte;
     function GetRightLineStyle(Index: integer): LongWord;
     function GetRightWeight(Index: integer): LongWord;


     function GetSaveIndex(Index: integer): integer; override;

     property Border[Index: integer]: TXLSStyleBorder read GetBorder;

     property BottomColorIndex[Index: integer]: LongWord read GetBottomColorIndex;
     property BottomColor[Index: integer]: LongWord read GetBottomColor;
     property BottomThemeColor[Index: integer]: LongWord read GetBottomThemeColor;
     property BottomTintAndShade[Index: integer]: double read GetBottomTintAndShade;


     function SetBottomColorIndex(const Index: integer; const Value: LongWord): integer;
     function SetBottomColor(const Index: integer; const Value: LongWord): integer;
     function SetBottomThemeColor(const Index: integer; const Value: LongWord): integer;
     function SetBottomTintAndShade(const Index: integer; const Value: double): integer;
     function SetBottomStyle(const Index: integer; const Value: byte): integer;
     function SetBottomLineStyle(const Index: integer; const Value: Longword): integer;
     function SetBottomWeight(const Index: integer; const Value: Longword): integer;

     function SetLeftColorIndex(const Index: integer; const Value: LongWord): integer;
     function SetLeftColor(const Index: integer; const Value: LongWord): integer;
     function SetLeftThemeColor(const Index: integer; const Value: LongWord): integer;
     function SetLeftTintAndShade(const Index: integer; const Value: double): integer;
     function SetLeftStyle(const Index: integer; const Value: byte): integer;
     function SetLeftLineStyle(const Index: integer; const Value: Longword): integer;
     function SetLeftWeight(const Index: integer; const Value: Longword): integer;

     function SetRightColorIndex(const Index: integer; const Value: LongWord): integer;
     function SetRightColor(const Index: integer; const Value: LongWord): integer;
     function SetRightThemeColor(const Index: integer; const Value: LongWord): integer;
     function SetRightTintAndShade(const Index: integer; const Value: double): integer;
     function SetRightStyle(const Index: integer; const Value: byte): integer;
     function SetRightLineStyle(const Index: integer; const Value: Longword): integer;
     function SetRightWeight(const Index: integer; const Value: Longword): integer;

     function SetTopColorIndex(const Index: integer; const Value: LongWord): integer;
     function SetTopColor(const Index: integer; const Value: LongWord): integer;
     function SetTopThemeColor(const Index: integer; const Value: LongWord): integer;
     function SetTopTintAndShade(const Index: integer; const Value: double): integer;
     function SetTopStyle(const Index: integer; const Value: byte): integer;
     function SetTopLineStyle(const Index: integer; const Value: Longword): integer;
     function SetTopWeight(const Index: integer; const Value: Longword): integer;

     function SetDiagonalUpColorIndex(const Index: integer; const Value: LongWord): integer;
     function SetDiagonalUpColor(const Index: integer; const Value: LongWord): integer;
     function SetDiagonalUpThemeColor(const Index: integer; const Value: LongWord): integer;
     function SetDiagonalUpTintAndShade(const Index: integer; const Value: double): integer;
     function SetDiagonalUpStyle(const Index: integer; const Value: byte): integer;
     function SetDiagonalUpLineStyle(const Index: integer; const Value: Longword): integer;
     function SetDiagonalUpWeight(const Index: integer; const Value: Longword): integer;

     function SetDiagonalDownColorIndex(const Index: integer; const Value: LongWord): integer;
     function SetDiagonalDownColor(const Index: integer; const Value: LongWord): integer;
     function SetDiagonalDownThemeColor(const Index: integer; const Value: LongWord): integer;
     function SetDiagonalDownTintAndShade(const Index: integer; const Value: double): integer;
     function SetDiagonalDownStyle(const Index: integer; const Value: byte): integer;
     function SetDiagonalDownLineStyle(const Index: integer; const Value: Longword): integer;
     function SetDiagonalDownWeight(const Index: integer; const Value: Longword): integer;


     procedure SetBorderData(Index: integer; Data: TXLSBlob; FileFormat: TXLSFileFormat);

     function TransformKey(Key: THashtableKey): THashtableKey; override;
     function GetReferredBorder(Index: integer): TXLSStyleBorder;

     procedure SetDefaultCount(Value: integer); 
     property DefaultKey: THashtableKey read FDefaultKey;
  end;

  TXLSStyleBorderLine = class(THashTableKey)
  private
     FStyle: byte;
     FColor: TXLSStyleColor;
     function GetLineStyleFromBorderStyle(const BorderStyle: byte): LongWord;
     function GetWeightFromBorderStyle(const BorderStyle: byte): LongWord;
     function SetLineStyleToBorderStyle(ABorderStyle: byte; ALineStyle: Longword): byte;
     function SetWeightToBorderStyle(ABorderStyle: byte; AWeight: Longword): byte;
     function GetLineStyle: Longword;
     function GetWeight: Longword;
     procedure SetLineStyle(Value: Longword);
     procedure SetWeight(Value: Longword);
  public
     constructor Create;
     destructor Destroy; override;

     function CloneBIFF8(AColorManager: TXLSColorManager): TXLSStyleBorderLine;
     function CloneBIFF5(AColorManager: TXLSColorManager): TXLSStyleBorderLine;
     function Clone: THashTableKey; override;
     function _GetHashCode: longint; override;
     function _Equals(obj: THashTableKey): boolean; override;
     procedure Assign(Value: TXLSStyleBorderLine);
     procedure AfterChangeColor;
     property Color: TXLSStyleColor read FColor;
     property Style: byte read FStyle write FStyle;

     property LineStyle: Longword read GetLineStyle write SetLineStyle;
     property Weight: Longword read GetWeight write SetWeight;

  end;


  TXLSStyleBorder = class(THashTableKey)
  private
     FBottom: TXLSStyleBorderLine;
     FRight: TXLSStyleBorderLine;
     FLeft: TXLSStyleBorderLine;
     FTop: TXLSStyleBorderLine;
     FDiagonal: TXLSStyleBorderLine;
     FDiagonalUp: boolean;
     FDiagonalDown: boolean;
  public
     constructor Create;
     destructor Destroy; override;

     function CloneBIFF8(AColorManager: TXLSColorManager): TXLSStyleBorder;
     function CloneBIFF5(AColorManager: TXLSColorManager): TXLSStyleBorder;
     function Clone: THashTableKey; override;
     function _GetHashCode: longint; override;
     function _Equals(obj: THashTableKey): boolean; override;

     property Bottom: TXLSStyleBorderLine  read FBottom;
     property Top:TXLSStyleBorderLine      read FTop;
     property Left:TXLSStyleBorderLine     read FLeft;
     property Right:TXLSStyleBorderLine    read FRight;
     property Diagonal:TXLSStyleBorderLine read FDiagonal;
     property DiagonalUp: boolean          read FDiagonalUp write FDiagonalUp;
     property DiagonalDown: boolean         read FDiagonalDown write FDiagonalDown;
  end;

implementation
uses xlshash;

{TXLSStyleBorderLine}
constructor TXLSStyleBorderLine.Create;
begin
  inherited Create;
  FColor := TXLSStyleColor.Create;
end;

destructor TXLSStyleBorderLine.Destroy; 
begin
  FColor.Free;
  inherited Destroy;
end;

function TXLSStyleBorderLine._GetHashCode: longint;
Var HashCode:longword;
begin
   HashCode := 33  + longword(FStyle);
   if FStyle > 0 then begin
      HashCode := 33 * HashCode + longword(FColor._GetHashCode);
   end;
   HashCode := HashCode + HashCode shr 5;
   Result := longint(HashCode);
end;

function TXLSStyleBorderLine.CloneBIFF8(AColorManager: TXLSColorManager): TXLSStyleBorderLine;
var b: TXLSStyleBorderLine;
begin
   b := TXLSStyleBorderLine.Create;
   b.FColor.Assign(FColor);
   AColorManager.TransformColor(b.FColor, $600); 
   b.FStyle := FStyle;
   Result := b;
end;

function TXLSStyleBorderLine.CloneBIFF5(AColorManager: TXLSColorManager): TXLSStyleBorderLine;
var b: TXLSStyleBorderLine;
begin
   b := TXLSStyleBorderLine.Create;
   b.FColor.Assign(FColor);
   AColorManager.TransformColor(b.FColor, $500); 
   b.FStyle := FStyle;

   if b.FStyle > $07 then begin
      b.FStyle := $03;
   end;

   Result := b;
end;

function TXLSStyleBorderLine.Clone: THashTableKey;
var b: TXLSStyleBorderLine;
begin
   b := TXLSStyleBorderLine.Create;
   b.FColor.Assign(FColor);
   b.FStyle := FStyle;
   Result := b;
end;

function TXLSStyleBorderLine._Equals(obj: THashTableKey): boolean;
var o: TXLSStyleBorderLine;
begin
   if Not(Assigned(obj)) then begin
      Result := false;
   end else if self = obj then begin
      Result := true;
   end else begin
      o := TXLSStyleBorderLine(obj);
      Result := (FStyle = o.FStyle);
      if not(Result) then exit;
      if FStyle > 0 then begin
         Result := FColor._Equals(o.FColor);        
         if not(Result) then exit;
      end;
   end;
end;

function TXLSStyleBorderLine.GetLineStyleFromBorderStyle(
  const BorderStyle: byte): LongWord;
begin
  Result := xlLineStyleNone;
  case BorderStyle of
      1:   Result := xlContinuous;
      2:   Result := xlContinuous;
      3:   Result := xlDash;
      4:   Result := xlDot;
      5:   Result := xlContinuous;
      6:   Result := xlDouble;
      7:   Result := xlContinuous;
      8:   Result := xlDash;
      9:   Result := xlDashDot;
     10:   Result := xlDashDot;
     11:   Result := xlDashDotDot;
     12:   Result := xlDashDotDot;
     13:   Result := xlSlantDashDot;
   end;
end;

function TXLSStyleBorderLine.GetWeightFromBorderStyle(
  const BorderStyle: byte): LongWord;
begin
  case BorderStyle of
     2:           Result := xlMedium;
     5,6:         Result := xlThick;
     7:           Result := xlHairline;
     8,10,12,13:  Result := xlMedium;
  else
                  Result := xlThin;
  end;  
end;

function TXLSStyleBorderLine.SetLineStyleToBorderStyle(ABorderStyle: byte;
  ALineStyle: LongWord): byte;
var lWeight: Longword;
begin
  Result := 0;
  lWeight := GetWeightFromBorderStyle(ABorderStyle);
  case ALineStyle of
     xlContinuous:
         case lWeight of
            xlHairline:       Result := 7;
            xlThick:          Result := 5;
            xlMedium:         Result := 2;
            else              Result := 1;
         end;
     xlDashDot:      //biff8 only
         case lWeight of
            xlMedium:         Result := 10;
            else              Result := 9;
         end;
     xlDashDotDot:   //biff8 only
         case lWeight of
            xlMedium:         Result := 12;
            else              Result := 11;
         end;
     xlSlantDashDot:          Result := 13; //biff8 only
     xlLineStyleNone:         Result := 0;
     xlDouble:                Result := 6;
     xlDot:                   Result := 4;
     xlDash:
         case lWeight of
            xlMedium:         Result := 8; //biff8 only
            else              Result := 3;
         end;
  end;
end;


function TXLSStyleBorderLine.SetWeightToBorderStyle(ABorderStyle: byte;
  AWeight: LongWord): byte;
var lLineStyle: Longword;
begin
  Result := 0;
  lLineStyle := GetLineStyleFromBorderStyle(ABorderStyle);
  case AWeight of
       xlHairline:               Result := 7;
       xlThin: case lLineStyle of
                 xlDashDot:      Result := 9; //biff8 only
                 xlDashDotDot:   Result := 11;
                 xlDot:          Result := 4;
                 xlDash:         Result := 3;
                 else            Result := 1;
               end;
      xlThick: case lLineStyle of
                 xlDouble:       Result := 6; 
                 else            Result := 5;
               end;
       xlMedium:
              case lLineStyle of
                 xlDashDot:      Result := 10;
                 xlDashDotDot:   Result := 12;
                 xlSlantDashDot: Result := 13;
                 xlDash:         Result := 8;
                 else            Result := 2;
               end;
  end;
end;


function TXLSStyleBorderLine.GetLineStyle: Longword;
begin
  Result := GetLineStyleFromBorderStyle(FStyle);
end;

function TXLSStyleBorderLine.GetWeight: Longword;
begin
  Result := GetWeightFromBorderStyle(FStyle);
end;

procedure TXLSStyleBorderLine.Assign(Value: TXLSStyleBorderLine);
begin
  FStyle := Value.FStyle;
  FColor.Assign(Value.FColor);
end;

procedure TXLSStyleBorderLine.AfterChangeColor;
begin
  if FColor.IsNone then begin
     if FStyle > 0 then FStyle := 0;
  end else begin
     if FStyle = 0 then FStyle := 1;
  end;
end;


procedure TXLSStyleBorderLine.SetLineStyle(Value: Longword);
begin
  FStyle := SetLineStyleToBorderStyle(FStyle, Value);
  if FStyle > 0 then begin
     if FColor.IsNone then FColor.Assign(0, 64, 0);
  end else begin
     if not(FColor.IsNone) then FColor.Assign(0, 0, 0);
  end;
end;

procedure TXLSStyleBorderLine.SetWeight(Value: Longword);
begin
  FStyle := SetWeightToBorderStyle(FStyle, Value);
  if FStyle > 0 then begin
     if FColor.IsNone then FColor.Assign(0, 64, 0);
  end else begin
     if not(FColor.IsNone) then FColor.Assign(0, 0, 0);
  end;
end;


{TXLSStyleBorder}
constructor TXLSStyleBorder.Create;
begin
  inherited Create;
  FBottom := TXLSStyleBorderLine.Create;
  FTop    := TXLSStyleBorderLine.Create;
  FRight  := TXLSStyleBorderLine.Create;
  FLeft   := TXLSStyleBorderLine.Create;
  FDiagonal := TXLSStyleBorderLine.Create;
  FDiagonalUp := false;
  FDiagonalDown := false;
end;

destructor TXLSStyleBorder.Destroy; 
begin
  FBottom.Free;
  FTop.Free;
  FRight.Free;
  FLeft.Free;
  FDiagonal.Free;
  inherited Destroy;
end;

function TXLSStyleBorder._GetHashCode: longint;
Var HashCode:longword;
begin
   HashCode := 1;   
   HashCode := 33 * HashCode + longword(FBottom._GetHashCode);
   HashCode := 33 * HashCode + longword(FLeft._GetHashCode);
   HashCode := 33 * HashCode + longword(FRight._GetHashCode);
   HashCode := 33 * HashCode + longword(FTop._GetHashCode);
   HashCode := 33 * HashCode + longword(FDiagonal._GetHashCode);
   HashCode := 33 * HashCode + longword(FDiagonalUp);
   HashCode := 33 * HashCode + longword(FDiagonalDown);
   HashCode := HashCode + HashCode shr 5;
   Result := longint(HashCode);
end;

function TXLSStyleBorder.CloneBIFF8(AColorManager: TXLSColorManager): TXLSStyleBorder;
var b: TXLSStyleBorder;
begin
   b := TXLSStyleBorder.Create;

   b.FBottom.Free;
   b.FTop.Free;
   b.FLeft.Free;
   b.FRight.Free;
   b.FDiagonal.Free;

   b.FBottom := FBottom.CloneBiff8(AColorManager);
   b.FTop    := FTop.CloneBiff8(AColorManager);
   b.FLeft   := FLeft.CloneBiff8(AColorManager);
   b.FRight  := FRight.CloneBiff8(AColorManager);
   b.FDiagonalUp := FDiagonalUp;
   b.FDiagonalDown := FDiagonalDown;

   if FDiagonal.Style = 0 then begin
      b.FDiagonalUp := false;
      b.FDiagonalDown := false;
   end;

   if b.FDiagonalUp or b.FDiagonalDown then begin
      b.FDiagonal  := FDiagonal.CloneBiff8(AColorManager);
   end else begin
      b.FDiagonal := TXLSStyleBorderLine.Create(); 
   end;

   Result := b;
end;

function TXLSStyleBorder.CloneBIFF5(AColorManager: TXLSColorManager): TXLSStyleBorder;
var b: TXLSStyleBorder;
begin
   b := TXLSStyleBorder.Create;

   b.FBottom.Free;
   b.FTop.Free;
   b.FLeft.Free;
   b.FRight.Free;
   b.FDiagonal.Free;

   b.FBottom := FBottom.CloneBiff5(AColorManager);
   b.FTop    := FTop.CloneBiff5(AColorManager);
   b.FLeft   := FLeft.CloneBiff5(AColorManager);
   b.FRight  := FRight.CloneBiff5(AColorManager);

   b.FDiagonal  := TXLSStyleBorderLine.Create();
   b.FDiagonalUp  := false;
   b.FDiagonalDown  := false;

   Result := b;
end;

function TXLSStyleBorder.Clone: THashTableKey;
var b: TXLSStyleBorder;
begin
   b := TXLSStyleBorder.Create;
   b.FBottom.Assign(FBottom);
   b.FLeft.Assign(FLeft);
   b.FRight.Assign(FRight);
   b.FTop.Assign(FTop);
   b.FDiagonal.Assign(FDiagonal);
   b.FDiagonalDown := FDiagonalDown;
   b.FDiagonalUp := FDiagonalUp;
   Result := b;
end;

function TXLSStyleBorder._Equals(obj: THashTableKey): boolean;
var o: TXLSStyleBorder;
begin
   if Not(Assigned(obj)) then begin
      Result := false;
   end else if self = obj then begin
      Result := true;
   end else begin
      o := TXLSStyleBorder(obj);
      Result := FBottom._Equals(o.FBottom);
      if not(Result) then exit;
      Result := FTop._Equals(o.FTop);
      if not(Result) then exit;
      Result := FLeft._Equals(o.FLeft);
      if not(Result) then exit;
      Result := FRight._Equals(o.FRight);
      if not(Result) then exit;
      Result := FDiagonal._Equals(o.FDiagonal);
      if not(Result) then exit;
      Result := (FDiagonalUp = o.FDiagonalUp);
      if not(Result) then exit;
      Result := (FDiagonalDown = o.FDiagonalDown);
      if not(Result) then exit;
   end;
end;

{TXLSStyleBorders}
constructor TXLSStyleBorders.Create(ColorManager: TXLSColorManager);
var d: TXLSStyleBorder;
begin
  inherited Create;
  FColorManager := ColorManager;
  FDefaultCount := 0;
  FStartIndex := 0;
  d := TXLSStyleBorder.Create();
  FDefaultKey := d;
end;

destructor TXLSStyleBorders.Destroy;
begin
  FDefaultKey.Free;
  FDefaultKey := nil;
  inherited Destroy;
end;

function TXLSStyleBorders.GetBorder(Index: integer): TXLSStyleBorder;
begin
  Result := TXLSStyleBorder(Key[Index]);
end;

function TXLSStyleBorders.SetBorder(Index: integer; Value: TXLSStyleBorder): integer;
begin
  Result := SetKey(Index, Value, true);
end;

function TXLSStyleBorders.GetBottomColorIndex(Index: integer): LongWord;
begin
  Result := FColorManager.GetColorIndex(Border[Index].Bottom.Color);
  Result := InternalColorIndex2ColorIndex(Result);
end;

function TXLSStyleBorders.GetLeftColorIndex(Index: integer): LongWord;
begin
  Result := FColorManager.GetColorIndex(Border[Index].Left.Color);
  Result := InternalColorIndex2ColorIndex(Result);
end;

function TXLSStyleBorders.GetRightColorIndex(Index: integer): LongWord;
begin
  Result := FColorManager.GetColorIndex(Border[Index].Right.Color);
  Result := InternalColorIndex2ColorIndex(Result);
end;

function TXLSStyleBorders.GetTopColorIndex(Index: integer): LongWord;
begin
  Result := FColorManager.GetColorIndex(Border[Index].Top.Color);
  Result := InternalColorIndex2ColorIndex(Result);
end;


function TXLSStyleBorders.GetDiagonalUpColorIndex(Index: integer): LongWord;
begin
  if Border[Index].DiagonalUp then begin
     Result := FColorManager.GetColorIndex(Border[Index].Diagonal.Color);
     Result := InternalColorIndex2ColorIndex(Result);
  end else begin
     Result := xlColorIndexNone; 
  end;
end;

function TXLSStyleBorders.GetDiagonalDownColorIndex(Index: integer): LongWord;
begin
  if Border[Index].DiagonalDown then begin
     Result := FColorManager.GetColorIndex(Border[Index].Diagonal.Color);
     Result := InternalColorIndex2ColorIndex(Result);
  end else begin
     Result := 0;
  end; 
end;

function TXLSStyleBorders.GetBottomThemeColor(Index: integer): longword;
begin
  Result := FColorManager.GetThemeColor(Border[Index].Bottom.Color);
end;

function TXLSStyleBorders.GetTopThemeColor(Index: integer): longword;
begin
  Result := FColorManager.GetThemeColor(Border[Index].Top.Color);
end;

function TXLSStyleBorders.GetLeftThemeColor(Index: integer): longword;
begin
  Result := FColorManager.GetThemeColor(Border[Index].Left.Color);
end;

function TXLSStyleBorders.GetRightThemeColor(Index: integer): longword;
begin
  Result := FColorManager.GetThemeColor(Border[Index].Right.Color);
end;

function TXLSStyleBorders.GetDiagonalUpThemeColor(Index: integer): longword;
begin
  if Border[Index].DiagonalUp then begin
     Result := FColorManager.GetThemeColor(Border[Index].Diagonal.Color);
  end else begin
     Result := 0;
  end;
end;

function TXLSStyleBorders.GetDiagonalDownThemeColor(Index: integer): longword;
begin
  if Border[Index].DiagonalDown then begin
     Result := FColorManager.GetThemeColor(Border[Index].Diagonal.Color);
  end else begin
     Result := 0;
  end;
end;

function TXLSStyleBorders.GetBottomTintAndShade(Index: integer): double;
begin
  Result := Border[Index].Bottom.Color.TintAndShade;
end;

function TXLSStyleBorders.GetTopTintAndShade(Index: integer): double;
begin
  Result := Border[Index].Top.Color.TintAndShade;
end;

function TXLSStyleBorders.GetLeftTintAndShade(Index: integer): double;
begin
  Result := Border[Index].Left.Color.TintAndShade;
end;

function TXLSStyleBorders.GetRightTintAndShade(Index: integer): double;
begin
  Result := Border[Index].Right.Color.TintAndShade;
end;

function TXLSStyleBorders.GetDiagonalUpTintAndShade(Index: integer): double;
begin
  if Border[Index].DiagonalUp then begin
     Result := Border[Index].Diagonal.Color.TintAndShade;
  end else begin
     Result := 0;
  end;
end;

function TXLSStyleBorders.GetDiagonalDownTintAndShade(Index: integer): double;
begin
  if Border[Index].DiagonalDown then begin
     Result := Border[Index].Diagonal.Color.TintAndShade;
  end else begin
     Result := 0;
  end;
end;

function TXLSStyleBorders.GetBottomColor(Index: integer): longword;
begin
  Result := FColorManager.GetRGBColor(Border[Index].Bottom.Color);
end;

function TXLSStyleBorders.GetTopColor(Index: integer): longword;
begin
  Result := FColorManager.GetRGBColor(Border[Index].Top.Color);
end;

function TXLSStyleBorders.GetLeftColor(Index: integer): longword;
begin
  Result := FColorManager.GetRGBColor(Border[Index].Left.Color);
end;

function TXLSStyleBorders.GetRightColor(Index: integer): longword;
begin
  Result := FColorManager.GetRGBColor(Border[Index].Right.Color);
end;


function TXLSStyleBorders.GetDiagonalUpColor(Index: integer): longword;
begin
  if Border[Index].DiagonalUp then begin
     Result := FColorManager.GetRGBColor(Border[Index].Diagonal.Color);
  end else begin
     Result := 0;
  end;

end;

function TXLSStyleBorders.GetDiagonalDownColor(Index: integer): longword;
begin
  if Border[Index].DiagonalDown then begin
     Result := FColorManager.GetRGBColor(Border[Index].Diagonal.Color);
  end else begin
     Result := 0;
  end;
end;

function TXLSStyleBorders.GetBottomStyle(Index: integer): byte;
begin
  Result := Border[Index].Bottom.Style;
end;

function TXLSStyleBorders.GetTopStyle(Index: integer): byte;
begin
  Result := Border[Index].Top.Style;
end;

function TXLSStyleBorders.GetLeftStyle(Index: integer): byte;
begin
  Result := Border[Index].Left.Style;
end;

function TXLSStyleBorders.GetRightStyle(Index: integer): byte;
begin
  Result := Border[Index].Right.Style;
end;

function TXLSStyleBorders.GetDiagonalUpStyle(Index: integer): byte;
begin
  if Border[Index].DiagonalUp then begin
     Result := Border[Index].Diagonal.Style;
  end else begin
     Result := 0;
  end;
end;

function TXLSStyleBorders.GetDiagonalDownStyle(Index: integer): byte;
begin
  if Border[Index].DiagonalDown then begin
     Result := Border[Index].Diagonal.Style;
  end else begin
     Result := 0;
  end;
end;

function TXLSStyleBorders.GetBottomLineStyle(Index: integer): LongWord;
begin
  Result := Border[Index].Bottom.LineStyle;
end;

function TXLSStyleBorders.GetDiagonalUpLineStyle(Index: integer): LongWord;
begin
  if Border[Index].DiagonalUp then begin
     Result := Border[Index].Diagonal.LineStyle;
  end else begin
     Result := xlLineStyleNone;
  end;
end;

function TXLSStyleBorders.GetDiagonalDownLineStyle(Index: integer): LongWord;
begin
  if Border[Index].DiagonalDown then begin
     Result := Border[Index].Diagonal.LineStyle;
  end else begin
     Result := xlLineStyleNone;
  end;
end;

function TXLSStyleBorders.GetLeftLineStyle(Index: integer): LongWord;
begin
  Result := Border[Index].Left.LineStyle;
end;

function TXLSStyleBorders.GetRightLineStyle(Index: integer): LongWord;
begin
  Result := Border[Index].Right.LineStyle;
end;

function TXLSStyleBorders.GetTopLineStyle(Index: integer): LongWord;
begin
  Result := Border[Index].Top.LineStyle;
end;

function TXLSStyleBorders.GetBottomWeight(Index: integer): LongWord;
begin
  Result := Border[Index].Bottom.Weight;
end;

function TXLSStyleBorders.GetDiagonalUpWeight(Index: integer): LongWord;
begin
  if Border[Index].DiagonalUp then begin
     Result := Border[Index].Diagonal.Weight;
  end else begin
     Result := xlThin;
  end;
end;

function TXLSStyleBorders.GetDiagonalDownWeight(Index: integer): LongWord;
begin
  if Border[Index].DiagonalDown then begin
     Result := Border[Index].Diagonal.Weight;
  end else begin
     Result := xlThin;
  end;
end;

function TXLSStyleBorders.GetLeftWeight(Index: integer): LongWord;
begin
  Result := Border[Index].Left.Weight;
end;

function TXLSStyleBorders.GetRightWeight(Index: integer): LongWord;
begin
  Result := Border[Index].Right.Weight;
end;

function TXLSStyleBorders.GetTopWeight(Index: integer): LongWord;
begin
  Result := Border[Index].Top.Weight;
end;

function TXLSStyleBorders.GetSaveIndex(Index: integer): integer; 
begin
  Result := inherited GetSaveIndex(Index);
end;

function TXLSStyleBorders.ColorIndex2InternalColorIndex(const Value: LongWord): LongWord;
begin
  Result := 0;
  if (Value = xlColorIndexNone) or (Value = 0) then Result := 0
  else if Value = xlColorIndexAutomatic then Result := 64
  else if Value <= 56 then begin
     Result := Value + 7;
  end;
end;

function TXLSStyleBorders.InternalColorIndex2ColorIndex(const Value: LongWord): LongWord;
begin
  Result := Value;
  if Result = 0 then Result := xlColorIndexNone
  else if Result = 64 then Result := xlColorIndexAutomatic
  else if Result > 7 then Result := Result - 7;
end;

{set bottom}
function TXLSStyleBorders.SetBottomColorIndex(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleBorder;
    ci: longword;
begin
   ci := ColorIndex2InternalColorIndex(Value);
   b := Border[Index];
   if not(b.Bottom.Color.IsEqual(0, ci, 0)) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Bottom.Color.Assign(0, ci, 0);
       b.Bottom.AfterChangeColor;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleBorders.SetBottomColor(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if not(b.Bottom.Color.IsEqual(2, Value, 0)) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Bottom.Color.Assign(2, Value, 0);
       b.Bottom.AfterChangeColor;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;


function TXLSStyleBorders.SetBottomThemeColor(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if not(b.Bottom.Color.IsEqual(1, Value, 0)) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Bottom.Color.Assign(1, Value, 0);
       b.Bottom.AfterChangeColor;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleBorders.SetBottomTintAndShade(const Index: integer; const Value: double): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if not(b.Bottom.Color.IsEqual(b.Bottom.Color.ColorType, b.Bottom.Color.ColorValue, Value)) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Bottom.Color.TintAndShade := Value;
       b.Bottom.AfterChangeColor;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleBorders.SetBottomStyle(const Index: integer; const Value: byte): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if (b.Bottom.Style <> Value) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Bottom.Style := Value;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleBorders.SetBottomLineStyle(const Index: integer; const Value: Longword): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if (b.Bottom.LineStyle <> Value) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Bottom.LineStyle := Value;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleBorders.SetBottomWeight(const Index: integer; const Value: Longword): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if (b.Bottom.Weight <> Value) or (b.Bottom.Style = 0) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Bottom.Weight := Value;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;

{set diagonalup}
function TXLSStyleBorders.SetDiagonalUpColorIndex(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleBorder;
    ci: longword;
begin
   ci := ColorIndex2InternalColorIndex(Value);
   b := Border[Index];
   b := TXLSStyleBorder(b.Clone());

   if ci = 0 then begin
      b.FDiagonalUp := false;
      if not(b.FDiagonalDown) then begin
         b.Diagonal.Color.Assign(0, 0, 0);
         b.Diagonal.Style := 0;  
      end;
   end else begin
      b.Diagonal.Color.Assign(0, ci, 0);
      b.Diagonal.AfterChangeColor;

      if b.Diagonal.Style > 0 then begin
         b.FDiagonalUp := true;
      end else begin
         b.FDiagonalUp   := false;
         b.FDiagonalDown := false;
      end;
   end;

   Result := SetBorder(Index, b);
end;

function TXLSStyleBorders.SetDiagonalUpColor(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   b := TXLSStyleBorder(b.Clone());
   b.Diagonal.Color.Assign(2, Value, 0);
   b.Diagonal.AfterChangeColor;
   if b.Diagonal.Style > 0 then begin
      b.FDiagonalUp := true;
   end else begin
      b.FDiagonalUp   := false;
      b.FDiagonalDown := false;
   end;
   Result := SetBorder(Index, b);
end;


function TXLSStyleBorders.SetDiagonalUpThemeColor(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   b := TXLSStyleBorder(b.Clone());
   b.Diagonal.Color.Assign(1, Value, 0);
   b.Diagonal.AfterChangeColor;
   if b.Diagonal.Style > 0 then begin
      b.FDiagonalUp := true;
   end else begin
      b.FDiagonalUp   := false;
      b.FDiagonalDown := false;
   end;
   Result := SetBorder(Index, b);
end;

function TXLSStyleBorders.SetDiagonalUpTintAndShade(const Index: integer; const Value: double): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   b := TXLSStyleBorder(b.Clone());
   b.Diagonal.Color.TintAndShade := Value;
   b.Diagonal.AfterChangeColor;

   if b.Diagonal.Style > 0 then begin
      b.FDiagonalUp := true;
   end else begin
      b.FDiagonalUp   := false;
      b.FDiagonalDown := false;
   end;

   Result := SetBorder(Index, b);
end;

function TXLSStyleBorders.SetDiagonalUpStyle(const Index: integer; const Value: byte): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   b := TXLSStyleBorder(b.Clone());

   if Value = 0 then begin
      b.FDiagonalUp := false;
      if not(b.FDiagonalDown) then b.FDiagonal.Style := Value;
   end else begin
      b.Diagonal.Style := Value;
      b.FDiagonalUp := true;
   end;

   Result := SetBorder(Index, b);
end;

function TXLSStyleBorders.SetDiagonalUpLineStyle(const Index: integer; const Value: Longword): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   b := TXLSStyleBorder(b.Clone());

   if Value = xlLineStyleNone then begin
      b.FDiagonalUp := false;
      if not(b.FDiagonalDown) then b.FDiagonal.Style := 0;
   end else begin
      b.Diagonal.LineStyle := Value;
      b.FDiagonalUp := true;
   end;

   Result := SetBorder(Index, b);
end;

function TXLSStyleBorders.SetDiagonalUpWeight(const Index: integer; const Value: Longword): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   b := TXLSStyleBorder(b.Clone());
   b.Diagonal.Weight := Value;
   if b.Diagonal.Style > 0 then begin
      b.FDiagonalUp := true;
   end else begin
      b.FDiagonalUp := false;
      b.FDiagonalDown := false;
   end;  

   Result := SetBorder(Index, b);
end;




{set diagonaldown}
function TXLSStyleBorders.SetDiagonalDownColorIndex(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleBorder;
    ci: longword;
begin
   ci := ColorIndex2InternalColorIndex(Value);
   b := Border[Index];
   b := TXLSStyleBorder(b.Clone());

   if ci = 0 then begin
      b.FDiagonalDown := false;
      if not(b.FDiagonalUp) then begin
         b.Diagonal.Color.Assign(0, 0, 0);
         b.Diagonal.Style := 0;  
      end;
   end else begin
      b.Diagonal.Color.Assign(0, ci, 0);
      b.Diagonal.AfterChangeColor;

      if b.Diagonal.Style > 0 then begin
         b.FDiagonalDown := true;
      end else begin
         b.FDiagonalUp   := false;
         b.FDiagonalDown := false;
      end;
   end;

   Result := SetBorder(Index, b);
end;

function TXLSStyleBorders.SetDiagonalDownColor(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   b := TXLSStyleBorder(b.Clone());
   b.Diagonal.Color.Assign(2, Value, 0);
   b.Diagonal.AfterChangeColor;
   if b.Diagonal.Style > 0 then begin
      b.FDiagonalDown := true;
   end else begin
      b.FDiagonalUp   := false;
      b.FDiagonalDown := false;
   end;
   Result := SetBorder(Index, b);
end;


function TXLSStyleBorders.SetDiagonalDownThemeColor(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   b := TXLSStyleBorder(b.Clone());
   b.Diagonal.Color.Assign(1, Value, 0);
   b.Diagonal.AfterChangeColor;
   if b.Diagonal.Style > 0 then begin
      b.FDiagonalDown := true;
   end else begin
      b.FDiagonalUp   := false;
      b.FDiagonalDown := false;
   end;
   Result := SetBorder(Index, b);
end;

function TXLSStyleBorders.SetDiagonalDownTintAndShade(const Index: integer; const Value: double): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   b := TXLSStyleBorder(b.Clone());
   b.Diagonal.Color.TintAndShade := Value;
   b.Diagonal.AfterChangeColor;

   if b.Diagonal.Style > 0 then begin
      b.FDiagonalDown := true;
   end else begin
      b.FDiagonalUp   := false;
      b.FDiagonalDown := false;
   end;

   Result := SetBorder(Index, b);
end;

function TXLSStyleBorders.SetDiagonalDownStyle(const Index: integer; const Value: byte): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   b := TXLSStyleBorder(b.Clone());

   if Value = 0 then begin
      b.FDiagonalDown := false;
      if not(b.FDiagonalUp) then b.FDiagonal.Style := Value;
   end else begin
      b.Diagonal.Style := Value;
      b.FDiagonalDown := true;
   end;

   Result := SetBorder(Index, b);
end;

function TXLSStyleBorders.SetDiagonalDownLineStyle(const Index: integer; const Value: Longword): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   b := TXLSStyleBorder(b.Clone());

   if Value = xlLineStyleNone then begin
      b.FDiagonalDown := false;
      if not(b.FDiagonalUp) then b.FDiagonal.Style := 0;
   end else begin
      b.Diagonal.LineStyle := Value;
      b.FDiagonalDown := true;
   end;

   Result := SetBorder(Index, b);
end;

function TXLSStyleBorders.SetDiagonalDownWeight(const Index: integer; const Value: Longword): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   b := TXLSStyleBorder(b.Clone());
   b.Diagonal.Weight := Value;
   if b.Diagonal.Style > 0 then begin
      b.FDiagonalDown := true;
   end else begin
      b.FDiagonalUp := false;
      b.FDiagonalDown := false;
   end;  

   Result := SetBorder(Index, b);
end;



{set top}
function TXLSStyleBorders.SetTopColorIndex(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleBorder;
    ci: longword;
begin
   ci := ColorIndex2InternalColorIndex(Value);
   b := Border[Index];
   if not(b.Top.Color.IsEqual(0, ci, 0)) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Top.Color.Assign(0, ci, 0);
       b.Top.AfterChangeColor;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleBorders.SetTopColor(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if not(b.Top.Color.IsEqual(2, Value, 0)) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Top.Color.Assign(2, Value, 0);
       b.Top.AfterChangeColor;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;


function TXLSStyleBorders.SetTopThemeColor(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if not(b.Top.Color.IsEqual(1, Value, 0)) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Top.Color.Assign(1, Value, 0);
       b.Top.AfterChangeColor;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleBorders.SetTopTintAndShade(const Index: integer; const Value: double): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if not(b.Top.Color.IsEqual(b.Top.Color.ColorType, b.Top.Color.ColorValue, Value)) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Top.Color.TintAndShade := Value;
       b.Top.AfterChangeColor;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleBorders.SetTopStyle(const Index: integer; const Value: byte): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if (b.Top.Style <> Value) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Top.Style := Value;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;


function TXLSStyleBorders.SetTopLineStyle(const Index: integer; const Value: Longword): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if (b.Top.LineStyle <> Value) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Top.LineStyle := Value;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleBorders.SetTopWeight(const Index: integer; const Value: Longword): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if (b.Top.Weight <> Value) or (b.Top.Style = 0) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Top.Weight := Value;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;


{set left}
function TXLSStyleBorders.SetLeftColorIndex(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleBorder;
    ci: longword;
begin
   ci := ColorIndex2InternalColorIndex(Value);
   b := Border[Index];
   if not(b.Left.Color.IsEqual(0, ci, 0)) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Left.Color.Assign(0, ci, 0);
       b.Left.AfterChangeColor;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleBorders.SetLeftColor(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if not(b.Left.Color.IsEqual(2, Value, 0)) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Left.Color.Assign(2, Value, 0);
       b.Left.AfterChangeColor;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;


function TXLSStyleBorders.SetLeftThemeColor(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if not(b.Left.Color.IsEqual(1, Value, 0)) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Left.Color.Assign(1, Value, 0);
       b.Left.AfterChangeColor;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleBorders.SetLeftTintAndShade(const Index: integer; const Value: double): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if not(b.Left.Color.IsEqual(b.Left.Color.ColorType, b.Left.Color.ColorValue, Value)) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Left.Color.TintAndShade := Value;
       b.Left.AfterChangeColor;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleBorders.SetLeftStyle(const Index: integer; const Value: byte): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if (b.Left.Style <> Value) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Left.Style := Value;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleBorders.SetLeftLineStyle(const Index: integer; const Value: Longword): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if (b.Left.LineStyle <> Value) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Left.LineStyle := Value;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleBorders.SetLeftWeight(const Index: integer; const Value: Longword): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if (b.Left.Weight <> Value) or (b.Left.Style = 0) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Left.Weight := Value;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;

{set right}
function TXLSStyleBorders.SetRightColorIndex(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleBorder;
    ci: longword;
begin
   ci := ColorIndex2InternalColorIndex(Value);
   b := Border[Index];
   if not(b.Right.Color.IsEqual(0, ci, 0)) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Right.Color.Assign(0, ci, 0);
       b.Right.AfterChangeColor;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleBorders.SetRightColor(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if not(b.Right.Color.IsEqual(2, Value, 0)) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Right.Color.Assign(2, Value, 0);
       b.Right.AfterChangeColor;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;


function TXLSStyleBorders.SetRightThemeColor(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if not(b.Right.Color.IsEqual(1, Value, 0)) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Right.Color.Assign(1, Value, 0);
       b.Right.AfterChangeColor;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleBorders.SetRightTintAndShade(const Index: integer; const Value: double): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if not(b.Right.Color.IsEqual(b.Right.Color.ColorType, b.Right.Color.ColorValue, Value)) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Right.Color.TintAndShade := Value;
       b.Right.AfterChangeColor;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleBorders.SetRightStyle(const Index: integer; const Value: byte): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if (b.Right.Style <> Value) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Right.Style := Value;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;


function TXLSStyleBorders.SetRightLineStyle(const Index: integer; const Value: Longword): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if (b.Right.LineStyle <> Value) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Right.LineStyle := Value;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;


function TXLSStyleBorders.SetRightWeight(const Index: integer; const Value: Longword): integer;
var b: TXLSStyleBorder;
begin
   b := Border[Index];
   if (b.Right.Weight <> Value) or (b.Right.Style = 0) then begin
       b := TXLSStyleBorder(b.Clone());
       b.Right.Weight := Value;
       Result := SetBorder(Index, b);
   end else begin
       Result := Index;
   end;
end;



procedure TXLSStyleBorders.SetBorderData(Index: integer; Data: TXLSBlob; FileFormat: TXLSFileFormat);
Var b: TXLSStyleBorder;
    v: longword;
    ls: byte;
    ci: longword;
begin
   b := TXLSStyleBorder(FReferredList[Index - 1].FKey);
   if FileFormat = xlExcel5 then begin

      b := b.CloneBiff5(FColorManager);
      //BIFF5
      v := Data.GetLong(8 + 4);
      ls := b.Bottom.Style;
      ci := FColorManager.GetColorIndexToSore(b.Bottom.Color);
      v := (v and $FFC00000) or ((ls and $07) shl 22);
      v := v or ((ci and $7F) shl 25); 
      Data.SetLong(v, 8 + 4);  

      v := (b.Top.Style and $07) or 
           ((b.Left.Style and $07) shl 3) or
           ((b.Right.Style and $07) shl 6);
      ci := FColorManager.GetColorIndexToSore(b.Top.Color);
      v := v or ((ci and $7F) shl 9);
      ci := FColorManager.GetColorIndexToSore(b.Left.Color);
      v := v or ((ci and $7F) shl 16);
      ci := FColorManager.GetColorIndexToSore(b.Right.Color);
      v := v or ((ci and $7F) shl 23);
      Data.SetLong(v, 12 + 4);  
      b.Free;
   end else begin 
      //BIFF8
      b := b.CloneBiff8(FColorManager);
      v := (b.Left.Style and $0F) or
           ((b.Right.Style and $0F) shl 4) or
           ((b.Top.Style and $0F) shl 8) or
           ((b.Bottom.Style and $0F) shl 12);
      ci := FColorManager.GetColorIndexToSore(b.Left.Color);
      v := v or ((ci and $7F) shl 16);
      ci := FColorManager.GetColorIndexToSore(b.Right.Color);
      v := v or ((ci and $7F) shl 23);
      if b.DiagonalDown then v := v or $40000000;
      if b.DiagonalUp   then v := v or $80000000;

      Data.SetLong(v, 10 + 4);  

      v := Data.GetLong(14 + 4);
      v := v and $FC000000;
      ci := FColorManager.GetColorIndexToSore(b.Top.Color);
      v := v or (ci and $7F);
      ci := FColorManager.GetColorIndexToSore(b.Bottom.Color);
      v := v or ((ci and $7F) shl 7);
      ci := FColorManager.GetColorIndexToSore(b.Diagonal.Color);
      v := v or ((ci and $7F) shl 14);
      v := v or ((b.Diagonal.Style and $0F) shl 21);
      Data.SetLong(v, 14 + 4);  
      b.Free;
   end;
      
end;

procedure TXLSStyleBorders.SetDefaultCount(Value: integer);
begin
  FDefaultCount := Value;
end;

function TXLSStyleBorders.TransformKey(Key: THashtableKey): THashtableKey;
var b: TXLSStyleBorder;
begin
  if TransformMode = $500 then begin
     //biff5
     if Assigned(Key) then begin
        b := TXLSStyleBorder(Key).CloneBiff5(FColorManager);
        Result := b;
     end else begin
        Result := nil;
     end; 
  end else if TransformMode = $600 then begin
     //biff8
     if Assigned(Key) then begin
        b := TXLSStyleBorder(Key).CloneBiff8(FColorManager);
        Result := b;
     end else begin
        Result := nil;
     end; 
  end else begin
     Result := Key.Clone;
  end; 
end;

function TXLSStyleBorders.GetReferredBorder(Index: integer): TXLSStyleBorder;
begin
   Result := TXLSStyleBorder(FReferredList[Index].FKey);
end;


end.