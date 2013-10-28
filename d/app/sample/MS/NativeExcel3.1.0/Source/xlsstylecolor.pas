//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsstylecolor
//
//
//      Description:  color object
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

unit xlsstylecolor;
{$Q-}
{$R-}

interface
{$I xlsdef.inc}
uses Classes;

type 

  TXLSStyleColor = class;

  TXLSThemeColors = class
  private
     FArr: array[0..11] of longword;
  public
     constructor Create;
     destructor Destroy; override;
     procedure SetThemeSysColor(index: integer; SysColor: integer); overload;
     procedure SetThemeSysColor(index: integer; SysColor: integer; LastRGBColor: longword); overload;
     procedure SetThemeRGBColor(index: integer; Color: longword);
     function GetThemeSysColor(index: integer): integer;
     function GetThemeRGBColor(index: integer): longword; overload;
     function GetThemeRGBColor(index: integer; tint: double): longword; overload;
     function IsSysColor(index: integer): boolean;
     procedure SetDefaultScheme;
  end;

  TXLSColorManager = class
  private
     FPalette: array [0..63] of longword;
     FPaletteIsChanged: boolean;
     FTheme: TXLSThemeColors;
     function GetPaletteValue(index: integer): longword;
     procedure SetPaletteValue(index: integer; value: longword); 
  public
     constructor Create;
     destructor Destroy; override;
     procedure SetPaletteColor(Index: integer; const Value: LongWord);
     function  GetPaletteColor(ExternalColorIndex: integer): LongWord;
     procedure SetPaletteXL97;
     function  GetPaletteColorIndex(Value: LongWord): integer;
     property Palette[index: integer]: longword read GetPaletteValue write SetPaletteValue;
     property ColorTheme: TXLSThemeColors read FTheme;

     function GetRGBColor(color: TXLSStyleColor): longword;
     function GetThemeColor(color: TXLSStyleColor): longword;
     function GetColorIndex(color: TXLSStyleColor): longword;
     function GetColorIndexToSore(color: TXLSStyleColor): longword;

     procedure SetColorIndex(color: TXLSStyleColor; value: longword);
     procedure SetColorRGB(color: TXLSStyleColor; value: longword);
     procedure SetThemeColor(color: TXLSStyleColor; value: longword; tintandshade: double);
     procedure TransformColor(color: TXLSStyleColor; TransformMode: integer);

     property PaletteIsChanged: boolean read FPaletteIsChanged;

  end;
  
  TXLSStyleColor = class
  private
     FColorType: byte; {0-colorindex; 1-theme index; 2-rgb value}
     FColorValue: longword;
     FTintAndShade: double;
     function GetIsNone: boolean;
  public
     constructor Create;
     destructor Destroy; override;
     function Clone: TXLSStyleColor;
     function _GetHashCode: longint;
     function _Equals(obj: TObject): boolean;
     function IsEqual(AColorType: byte; AColorValue: longword; ATintAndShade: double): boolean;
     procedure Assign(AColorType: byte; AColorValue: longword; ATintAndShade: double); overload;
     procedure Assign(AColor: TXLSStyleColor); overload;

     property ColorType: byte read FColorType;
     property ColorValue: longword read FColorValue;
     property TintAndShade: double read FTintAndShade write FTintAndShade;
     property IsNone: boolean read GetIsNone;
  end;

const 
    kernel32  = 'kernel32.dll';
    user32    = 'user32.dll';

type
  {$EXTERNALSYM DWORD}
  DWORD = LongWord;

{$EXTERNALSYM GetSysColor}
function GetSysColor(nIndex: Integer): DWORD; stdcall;
function GetSysColor; external user32 name 'GetSysColor';


implementation
uses xlshash, sysutils, xlsrgb;

{$I xlsbase.inc}


{TXLSThemeColors}
constructor TXLSThemeColors.Create;
begin
  inherited Create;
  SetDefaultScheme;
end;

destructor TXLSThemeColors.Destroy;
begin
  inherited Destroy;
end;

procedure TXLSThemeColors.SetThemeSysColor(index: integer; SysColor: integer);
var LastRGBValue: longword;
begin
  if (SysColor >= 0) and (SysColor <= 30) then begin
      LastRGBValue := GetSysColor(SysColor);
      SetThemeSysColor(index, SysColor, LastRGBValue);
  end;
end;

procedure TXLSThemeColors.SetThemeSysColor(index: integer; SysColor: integer; LastRGBColor: longword);
begin
  if (SysColor >= 0) and (SysColor <= 30) then begin
     FArr[index] := (($80 or longword(SysColor)) shl 24) or (LastRGBColor and $FFFFFF);
  end;
end;

procedure TXLSThemeColors.SetThemeRGBColor(index: integer; Color: longword);
begin
   FArr[index] := (Color and $FFFFFF);
end;

function TXLSThemeColors.GetThemeSysColor(index: integer): integer;
var v: longword;
begin
  v := FArr[index];
  if (v and $80000000) = $80000000 then begin
     Result := (v shr 24) and $1F;
  end else begin
     Result := -1;
  end;
end;

function TXLSThemeColors.GetThemeRGBColor(index: integer): longword;
var syscolor: integer;
begin
  if IsSysColor(index) then begin
     syscolor := GetThemeSysColor(index);
     Result := GetSysColor(syscolor);
  end else begin
     Result := FArr[index] and $FFFFFF;
  end;
end;

function TXLSThemeColors.GetThemeRGBColor(index: integer; tint: double): longword;
begin
  Result := GetThemeRGBColor(index);
  if tint <> 0 then begin
     Result := xlsrgb.GetRGBTInt(Result, tint);
  end;
end;

function TXLSThemeColors.IsSysColor(index: integer): boolean;
begin
  Result := ((FArr[index] and $80000000) = $80000000); 
end;

procedure TXLSThemeColors.SetDefaultScheme;
begin
  FArr[0] :=  $85FFFFFF;  //lt1 window     FFFFFF
  FArr[1] :=  $88000000;  //dk1 windowText 000000
  FArr[2] :=  $00E1ECEE;  //lt2     EEECE1
  FArr[3] :=  $007D491F;  //dk2     1F497D
  FArr[4] :=  $00BD814F;  //accent1 4F81BD
  FArr[5] :=  $004D50C0;  //accent2 C0504D
  FArr[6] :=  $0059BB9B;  //accent3 9BBB59
  FArr[7] :=  $00A26480;  //accent4 8064A2
  FArr[8] :=  $00C6AC4B;  //accent5 4BACC6
  FArr[9] :=  $004696F7;  //accent6 F79646
  FArr[10] := $00FF0000;  //hlink   0000FF
  FArr[11] := $00800080;  //foHlink 800080
end;


{TXLSColorManager}

constructor TXLSColorManager.Create;
begin
   inherited Create;
   FPaletteIsChanged := false;
   FTheme := TXLSThemeColors.Create;
end;

destructor TXLSColorManager.Destroy; 
begin
   FTheme.Free;
   inherited Destroy;
end;


procedure TXLSColorManager.SetPaletteXL97;
begin
  FPalette[0]  :=  $00000000;    //   $00, $00, $00, $00
  FPalette[1]  :=  $00FFFFFF;    //   $FF, $FF, $FF, $00
  FPalette[2]  :=  $000000FF;    //   $FF, $00, $00, $00
  FPalette[3]  :=  $0000FF00;    //   $00, $FF, $00, $00
  FPalette[4]  :=  $00FF0000;    //   $00, $00, $FF, $00
  FPalette[5]  :=  $0000FFFF;    //   $FF, $FF, $00, $00
  FPalette[6]  :=  $00FF00FF;    //   $FF, $00, $FF, $00
  FPalette[7]  :=  $00FFFF00;    //   $00, $FF, $FF, $00
  FPalette[8]  :=  $00000000;    //     0,   0,   0,   0
  FPalette[9]  :=  $00FFFFFF;    //   255, 255, 255,   0
  FPalette[10] :=  $000000FF;    //   255,   0,   0,   0
  FPalette[11] :=  $0000FF00;    //     0, 255,   0,   0
  FPalette[12] :=  $00FF0000;    //     0,   0, 255,   0
  FPalette[13] :=  $0000FFFF;    //   255, 255,   0,   0
  FPalette[14] :=  $00FF00FF;    //   255,   0, 255,   0
  FPalette[15] :=  $00FFFF00;    //     0, 255, 255,   0
  FPalette[16] :=  $0000007F;    //   128,   0,   0,   0
  FPalette[17] :=  $00007F00;    //     0, 128,   0,   0
  FPalette[18] :=  $007F0000;    //     0,   0, 128,   0
  FPalette[19] :=  $00007F7F;    //   128, 128,   0,   0
  FPalette[20] :=  $007F007F;    //   128,   0, 128,   0
  FPalette[21] :=  $007F7F00;    //     0, 128, 128,   0
  FPalette[22] :=  $00C0C0C0;    //   192, 192, 192,   0
  FPalette[23] :=  $007F7F7F;    //   128, 128, 128,   0 
  FPalette[24] :=  $00FF9999;    //   153, 153, 255,   0 
  FPalette[25] :=  $00663399;    //   153,  51, 102,   0 
  FPalette[26] :=  $00CCFFFF;    //   255, 255, 204,   0 
  FPalette[27] :=  $00FFFFCC;    //   204, 255, 255,   0 
  FPalette[28] :=  $00660066;    //   102,   0, 102,   0 
  FPalette[29] :=  $007F7FFF;    //   255, 128, 128,   0 
  FPalette[30] :=  $00CC6600;    //     0, 102, 204,   0 
  FPalette[31] :=  $00FFCCCC;    //   204, 204, 255,   0 
  FPalette[32] :=  $007F0000;    //     0,   0, 128,   0 
  FPalette[33] :=  $00FF00FF;    //   255,   0, 255,   0 
  FPalette[34] :=  $0000FFFF;    //   255, 255,   0,   0 
  FPalette[35] :=  $00FFFF00;    //     0, 255, 255,   0 
  FPalette[36] :=  $007F007F;    //   128,   0, 128,   0 
  FPalette[37] :=  $0000007F;    //   128,   0,   0,   0 
  FPalette[38] :=  $007F7F00;    //     0, 128, 128,   0 
  FPalette[39] :=  $00FF0000;    //     0,   0, 255,   0 
  FPalette[40] :=  $00FFCC00;    //     0, 204, 255,   0 
  FPalette[41] :=  $00FFFFCC;    //   204, 255, 255,   0 
  FPalette[42] :=  $00CCFFCC;    //   204, 255, 204,   0 
  FPalette[43] :=  $0099FFFF;    //   255, 255, 153,   0 
  FPalette[44] :=  $00FFCC99;    //   153, 204, 255,   0 
  FPalette[45] :=  $00CC99FF;    //   255, 153, 204,   0 
  FPalette[46] :=  $00FF99CC;    //   204, 153, 255,   0 
  FPalette[47] :=  $0099CCFF;    //   255, 204, 153,   0 
  FPalette[48] :=  $00FF6633;    //    51, 102, 255,   0 
  FPalette[49] :=  $00CCCC33;    //    51, 204, 204,   0 
  FPalette[50] :=  $0000CC99;    //   153, 204,   0,   0 
  FPalette[51] :=  $0000CCFF;    //   255, 204,   0,   0 
  FPalette[52] :=  $000099FF;    //   255, 153,   0,   0 
  FPalette[53] :=  $000066FF;    //   255, 102,   0,   0 
  FPalette[54] :=  $00996666;    //   102, 102, 153,   0 
  FPalette[55] :=  $00969696;    //   150, 150, 150,   0 
  FPalette[56] :=  $00663300;    //     0,  51, 102,   0 
  FPalette[57] :=  $00669933;    //    51, 153, 102,   0 
  FPalette[58] :=  $00003300;    //     0,  51,   0,   0 
  FPalette[59] :=  $00003333;    //    51,  51,   0,   0 
  FPalette[60] :=  $00003399;    //   153,  51,   0,   0 
  FPalette[61] :=  $00663399;    //   153,  51, 102,   0 
  FPalette[62] :=  $00993333;    //    51,  51, 153,   0 
  FPalette[63] :=  $00333333;    //    51,  51,  51,   0 
  FPaletteIsChanged := false;
end;                                 

function TXLSColorManager.GetPaletteValue(index: integer): longword;
begin
   Result := FPalette[index];
end;
procedure TXLSColorManager.SetPaletteValue(index: integer; value: longword); 
begin
  if (index >= 0) and (index <= 63) then begin
     if FPalette[index] <> (value and $FFFFFF) then begin
        FPaletteIsChanged := true;
     end;
     FPalette[index] := value;
  end;
end;

function TXLSColorManager.GetPaletteColorIndex(Value: LongWord): integer;
Var Distance, NewDistance: integer;
    cnt: integer;
    i :integer;
    R, G, B:byte;
begin
  B := (Value and $FF0000) shr 16;
  G := (Value and $FF00) shr 8;
  R := (Value and $FF);  Distance := 768;

  Result := 0;
  cnt := 64;

  for i := 8 to cnt - 1 do begin
      NewDistance := abs(integer(R) - integer(FPalette[i] and $FF)) +
                     abs(integer(G) - (integer(FPalette[i] and $FF00) shr 8)) +
                     abs(integer(B) - (integer(FPalette[i] and $FF0000) shr 16));
      if NewDistance < Distance then begin
         Result := i - 7;
         Distance := NewDistance;
         if Distance = 0 then break;
      end;
  end;
end;

procedure TXLSColorManager.SetPaletteColor(Index: integer; const Value: LongWord);
Var lIndex: integer;
begin
  if (Index < 1) or (Index > 57) then begin
      raise Exception.Create('Invalid color index value! (' + inttostr(Index) + ')');
  end else begin
      lIndex := Index + 7;
      if FPalette[lIndex] <> (Value and $FFFFFF) then begin
         FPaletteIsChanged := true;
      end;
      FPalette[lIndex] := Value and $FFFFFF;
//      FPalette[lIndex] := (Value and $FF);
//      FPalette[lIndex, 1] := ((Value and $FF00) shr 8);
//      FPalette[lIndex, 2] := ((Value and $FF0000) shr 16);
//      FPalette[lIndex, 3] := 0;
  end;
end;

function TXLSColorManager.GetPaletteColor(ExternalColorIndex: integer): LongWord;
Var ccv: Word;
begin
  if (ExternalColorIndex < 0) or (ExternalColorIndex > 57 ) then begin
     if ((ExternalColorIndex and $FFFF) = $EFF0)  or 
        ((ExternalColorIndex and $FFFF) = $EFF7)  then 
       Result := GetSysColor(COLOR_WINDOWTEXT)
     else if ExternalColorIndex = 80 then
       Result := GetSysColor(COLOR_INFOBK)
     else 
       Result := 0;
     //exception
  end else begin
     ccv := 64;
     if (ExternalColorIndex + 7) >= ccv then Result := 0
     else begin
          if ExternalColorIndex > 0 then ExternalColorIndex := ExternalColorIndex + 7;
          Result := FPalette[ExternalColorIndex];
     end;
  end; 
end;

function TXLSColorManager.GetRGBColor(color: TXLSStyleColor): longword;
var ind: longword;
begin
  case color.ColorType of
     0: begin
          ind := color.ColorValue;
          if (ind > 7) and (ind < 64) then begin
             ind := ind - 7;
          end else if ind = 0 then begin
             ind := xlColorIndexNone;
          end;
          Result := xlsrgb.GetRGBTInt(GetPaletteColor(ind), color.TintAndShade); 
        end;
     1: begin
          Result := FTheme.GetThemeRGBColor(color.ColorValue, color.TintAndShade);
        end;
     else 
        begin
          Result := xlsrgb.GetRGBTInt(color.ColorValue, color.TintAndShade); 
        end;
  end;
end;

function TXLSColorManager.GetThemeColor(color: TXLSStyleColor): longword;
begin
  if color.ColorType = 1 then Result := color.ColorValue
                         else Result := 0;
end;

function TXLSColorManager.GetColorIndex(color: TXLSStyleColor): longword;
var rgb: longword;
begin
  case color.ColorType of
     0: begin
          Result := color.ColorValue;
        end; 
     1: begin
          rgb := FTheme.GetThemeRGBColor(color.ColorValue, color.TintAndShade);
          Result := GetPaletteColorIndex(rgb);
        end;
     else
        begin
          rgb := xlsrgb.GetRGBTInt(color.ColorValue, color.TintAndShade); 
          Result := GetPaletteColorIndex(rgb);
        end;
  end;
end;

function TXLSColorManager.GetColorIndexToSore(color: TXLSStyleColor): longword;
var rgb: longword;
begin
  case color.ColorType of
     0: begin
          if color.TintAndShade = 0 then begin
             Result := color.ColorValue;
          end else begin
              rgb := GetRGBColor(color);
              Result := GetPaletteColorIndex(rgb);
              if (Result > 0) and (Result <= 56) then Result := Result + 7;
          end;
        end; 
     1: begin
          rgb := FTheme.GetThemeRGBColor(color.ColorValue, color.TintAndShade);
          Result := GetPaletteColorIndex(rgb);
              if (Result > 0) and (Result <= 56) then Result := Result + 7;
        end;
     else
        begin
          rgb := xlsrgb.GetRGBTInt(color.ColorValue, color.TintAndShade); 
          Result := GetPaletteColorIndex(rgb);
          if (Result > 0) and (Result <= 56) then Result := Result + 7;
        end;
  end;
end;

procedure TXLSColorManager.SetColorIndex(color: TXLSStyleColor; value: longword);
begin
  color.Assign(0, value, 0);
end;

procedure TXLSColorManager.SetColorRGB(color: TXLSStyleColor; value: longword);
begin
  color.Assign(0, value, 0);
  color.FColorType := 1;
  color.FColorValue := value;
  color.FTintAndShade := 0;
end;

procedure TXLSColorManager.SetThemeColor(color: TXLSStyleColor; value: longword; tintandshade: double);
begin
  color.Assign(2, value, tintandshade);
end;

procedure TXLSColorManager.TransformColor(color: TXLSStyleColor; TransformMode: integer);
begin
  if (TransformMode >= $500) and (TransformMode <= $600) then  
     color.Assign(0, GetColorIndexToSore(color), 0);
end;


{TXLSStyleFont}
constructor TXLSStyleColor.Create;
begin
  inherited Create;
end;

destructor TXLSStyleColor.Destroy; 
begin
  inherited Destroy;
end;

function TXLSStyleColor._GetHashCode: longint;
Var HashCode:longword;
begin
   HashCode := 1;   

   HashCode := 33 * HashCode + longword(FColorType);
   HashCode := HashCode + HashCode shr 5;
   HashCode := 33 * HashCode + longword(FColorValue);
   HashCode := HashCode + HashCode shr 5;
   HashCode := 33 * HashCode + longword(GetDoubleHashCode(FTintAndShade));
   HashCode := HashCode + HashCode shr 5;
   Result := longint(HashCode);
end;

function TXLSStyleColor.Clone: TXLSStyleColor;
begin
   Result := TXLSStyleColor.Create;
   Result.FColorType          := FColorType;
   Result.FColorValue         := FColorValue;
   Result.FTintAndShade       := FTintAndShade;
end;

function TXLSStyleColor._Equals(obj: TObject): boolean;
var o: TXLSStyleColor;
begin
   if Not(Assigned(obj)) then begin
      Result := false;
   end else if self = obj then begin
      Result := true;
   end else begin
      o := TXLSStyleColor(obj);
      Result := (FColorType = o.FColorType);
      if not(Result) then exit;
      Result := (FColorValue = o.FColorValue);
      if not(Result) then exit;
      Result := (FTintAndShade = o.FTintAndShade);
   end;
end;

procedure TXLSStyleColor.Assign(AColorType: byte; AColorValue: longword; ATintAndShade: double);
begin
  if AColorType > 2 then raise Exception.Create('Invalid ColorType value');
  if (ATintAndShade < -1) or (ATintAndShade > 1) then raise Exception.Create('Invalid TintAndShade value');
  FColorType := AColorType;
  FColorValue := AColorValue;
  FTintAndShade := ATintAndShade;
end;

procedure TXLSStyleColor.Assign(AColor: TXLSStyleColor);
begin
  FColorType := AColor.FColorType;
  FColorValue := AColor.FColorValue;
  FTintAndShade := AColor.FTintAndShade;
end;


function TXLSStyleColor.IsEqual(AColorType: byte; AColorValue: longword; ATintAndShade: double): boolean;
begin
  Result := (FColorType = AColorType);
  if Result then Result := (FColorValue = AColorValue);
  if Result then Result := (FTintAndShade = ATintAndShade);
end;

function TXLSStyleColor.GetIsNone: boolean;
begin
  Result := ((FColorType = 0) and (FColorValue = 0) and (FTintAndShade = 0));
end;

end.