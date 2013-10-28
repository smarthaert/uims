//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsstylefill
//
//
//      Description:  fill formatting
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

unit xlsstylefill;
{$Q-}
{$R-}

interface
{$I xlsdef.inc}
uses Classes, xlsstylecolor, xlsBlob, xlslist2, xlshashtable;

type 

  TXLSStyleFill = class;
  
  TXLSStyleFills = class(TXLSObjectKeyList)
  private
     FColorManager: TXLSColorManager;
//     function ColorIndex2InternalColorIndex(const Value: LongWord): LongWord;
     function InternalColorIndex2ColorIndex(const Value: LongWord): LongWord;
  public
     constructor Create(ColorManager: TXLSColorManager);
     destructor Destroy; override;


     function GetFill(Index: integer): TXLSStyleFill;
     function SetFill(Index: integer; Value: TXLSStyleFill): integer;

     function GetSaveIndex(Index: integer): integer; override;
     procedure SetFillData(Index: integer; Data: TXLSBlob; FileFormat: TXLSFileFormat);
     function TransformKey(Key: THashtableKey): THashtableKey; override;


     function GetPatternType(Index: integer): byte;
     function SetPatternType(const Index: integer; const Value: byte): integer;

     function GetFgColorIndex(Index: integer): LongWord;
     function GetFgThemeColor(Index: integer): longword;
     function GetFgTintAndShade(Index: integer): double;
     function GetFgColor(Index: integer): longword;

     function SetFgColorIndex(const Index: integer; const Value: LongWord): integer;
     function SetFgColor(const Index: integer; const Value: LongWord): integer;
     function SetFgThemeColor(const Index: integer; const Value: LongWord): integer;
     function SetFgTintAndShade(const Index: integer; const Value: double): integer;

     function GetBgColorIndex(Index: integer): LongWord;
     function GetBgThemeColor(Index: integer): longword;
     function GetBgTintAndShade(Index: integer): double;
     function GetBgColor(Index: integer): longword;

     function SetBgColorIndex(const Index: integer; const Value: LongWord): integer;
     function SetBgColor(const Index: integer; const Value: LongWord): integer;
     function SetBgThemeColor(const Index: integer; const Value: LongWord): integer;
     function SetBgTintAndShade(const Index: integer; const Value: double): integer;

     function GetReferredFill(Index: integer): TXLSStyleFill;

     procedure SetDefaultCount(Value: integer); 
     property DefaultKey: THashtableKey read FDefaultKey;
     property Fill[Index: integer]: TXLSStyleFill read GetFill;
  end;

  TXLSStyleFill = class(THashTableKey)
  private
     FPatternType: byte;
     FBgColor: TXLSStyleColor;
     FFgColor: TXLSStyleColor;
  public
     constructor Create;
     destructor Destroy; override;

     function CloneBIFF8(AColorManager: TXLSColorManager): TXLSStyleFill;
     function CloneBIFF5(AColorManager: TXLSColorManager): TXLSStyleFill;
     function Clone: THashTableKey; override;
     function _GetHashCode: longint; override;
     function _Equals(obj: THashTableKey): boolean; override;

     property FgColor: TXLSStyleColor read FFgColor;
     property BgColor: TXLSStyleColor read FBgColor;
     property PatternType: byte read FPatternType write FPatternType;
  end;

implementation
uses xlshash;

{TXLSStyleFill}
constructor TXLSStyleFill.Create;
begin
  inherited Create;
  FBgColor := TXLSStyleColor.Create; 
  FBgColor.Assign(0, 65, 0);
  FFgColor := TXLSStyleColor.Create; 
  FFgColor.Assign(0, 64, 0);
end;

destructor TXLSStyleFill.Destroy; 
begin
  FBgColor.Free;
  FFgColor.Free;
  inherited Destroy;
end;

function TXLSStyleFill._GetHashCode: longint;
Var HashCode:longword;
begin
   HashCode := 1;   
   HashCode := 33 * HashCode + FPatternType;
   if FPatternType > 0 then begin
     HashCode := 33 * HashCode + longword(FFgColor._GetHashCode());
     HashCode := 33 * HashCode + longword(FBgColor._GetHashCode());
   end;
   HashCode := HashCode + HashCode shr 5;
   Result := longint(HashCode);
end;

function TXLSStyleFill.CloneBIFF8(AColorManager: TXLSColorManager): TXLSStyleFill;
var b: TXLSStyleFill;
begin
   b := TXLSStyleFill.Create;
   b.FPatternType := FPatternType;
   b.FFgColor.Assign(FFgColor);
   AColorManager.TransformColor(b.FFgColor, $600); 
   b.FBgColor.Assign(FBgColor);
   AColorManager.TransformColor(b.FBgColor, $600); 
   Result := b;
end;

function TXLSStyleFill.CloneBIFF5(AColorManager: TXLSColorManager): TXLSStyleFill;
var b: TXLSStyleFill;
begin
   b := TXLSStyleFill.Create;
   b.FPatternType := FPatternType;
   b.FFgColor.Assign(FFgColor);
   AColorManager.TransformColor(b.FFgColor, $500); 
   b.FBgColor.Assign(FBgColor);
   AColorManager.TransformColor(b.FBgColor, $500); 
   Result := b;
end;

function TXLSStyleFill.Clone: THashTableKey;
var b: TXLSStyleFill;
begin
   b := TXLSStyleFill.Create;
   b.FPatternType := FPatternType;
   b.FBgColor.Assign(FBgColor);
   b.FFgColor.Assign(FFgColor);
   Result := b;
end;

function TXLSStyleFill._Equals(obj: THashTableKey): boolean;
var o: TXLSStyleFill;
begin
   if Not(Assigned(obj)) then begin
      Result := false;
   end else if self = obj then begin
      Result := true;
   end else begin
      o := TXLSStyleFill(obj);
      Result := (FPatternType = o.FPatternType);
      if not(Result) then exit;
      if FPatternType > 0 then begin
         Result := FBgColor._Equals(o.FBgColor);
         if not(Result) then exit;
         Result := FFgColor._Equals(o.FFgColor);
        if not(Result) then exit;
      end;
   end;
end;

{TXLSStyleFills}
constructor TXLSStyleFills.Create(ColorManager: TXLSColorManager);
var d: TXLSStyleFill;
begin
  inherited Create;
  FColorManager := ColorManager;
  FDefaultCount := 2;
  FStartIndex := 0;
  d := TXLSStyleFill.Create();
  FDefaultKey := d;
end;

destructor TXLSStyleFills.Destroy;
begin
  FDefaultKey.Free;
  FDefaultKey := nil;
  inherited Destroy;
end;

function TXLSStyleFills.GetSaveIndex(Index: integer): integer; 
begin
  Result := inherited GetSaveIndex(Index);
end;

{function TXLSStyleFills.ColorIndex2InternalColorIndex(const Value: LongWord): LongWord;
begin
  //!!!!!!!!!
  Result := 0;
  if (Value = xlColorIndexNone) or (Value = 0) then Result := 0
  else if Value = xlColorIndexAutomatic then Result := 64
  else if Value <= 56 then begin
     Result := Value + 7;
  end;
end;
}

function TXLSStyleFills.InternalColorIndex2ColorIndex(const Value: LongWord): LongWord;
begin
  //!!!!!!!!!!!
  Result := Value;
  if Result = 0 then Result := xlColorIndexNone
  else if Result = 64 then Result := xlColorIndexAutomatic
  else if Result = 65 then Result := xlColorIndexAutomatic
  else if Result > 7 then Result := Result - 7;
end;

procedure TXLSStyleFills.SetFillData(Index: integer; Data: TXLSBlob; FileFormat: TXLSFileFormat);
Var b: TXLSStyleFill;
    v: longword;
    ci: longword;
begin
   b := TXLSStyleFill(FReferredList[Index - 1].FKey);
   if FileFormat = xlExcel5 then begin
      //BIFF5
      b := b.CloneBiff5(FColorManager);
      v := Data.GetLong(8 + 4);
      v := v and $FFC00000;
      ci := FColorManager.GetColorIndexToSore(b.FgColor);
      v := v or (ci and $7F);
      ci := FColorManager.GetColorIndexToSore(b.BgColor);
      v := v or ((ci and $7F) shl 7);
      v := v or ((b.PatternType and $3F) shl 16);
      Data.SetLong(v, 8 + 4);
      b.Free;
   end else begin 
      //BIFF8
      b := b.CloneBiff8(FColorManager);
      v := Data.GetLong(14 + 4);
      v := v and $03FFFFFF;
      v := v or ((b.PatternType and $3F) shl 26);
      Data.SetLong(v, 14 + 4);

      v := 0;
      ci := FColorManager.GetColorIndexToSore(b.FgColor);
      v := v or (ci and $7F);
      ci := FColorManager.GetColorIndexToSore(b.BgColor);
      v := v or ((ci and $7F) shl 7);
      Data.SetWord(v, 18 + 4);
      b.Free; 
   end;
end;

procedure TXLSStyleFills.SetDefaultCount(Value: integer);
begin
  FDefaultCount := Value;
end;

function TXLSStyleFills.TransformKey(Key: THashtableKey): THashtableKey;
var b: TXLSStyleFill;
begin
  if TransformMode = $500 then begin
     //biff5
     if Assigned(Key) then begin
        b := TXLSStyleFill(Key).CloneBiff5(FColorManager);
        Result := b;
     end else begin
        Result := nil;
     end; 
  end else if TransformMode = $600 then begin
     //biff8
     if Assigned(Key) then begin
        b := TXLSStyleFill(Key).CloneBiff8(FColorManager);
        Result := b;
     end else begin
        Result := nil;
     end; 
  end else begin
     Result := Key.Clone;
  end; 
end;

function TXLSStyleFills.GetFill(Index: integer): TXLSStyleFill;
begin
  Result := TXLSStyleFill(Key[Index]);
end;

function TXLSStyleFills.SetFill(Index: integer; Value: TXLSStyleFill): integer;
begin
  Result := SetKey(Index, Value, true);
end;


function TXLSStyleFills.GetPatternType(Index: integer): byte;
begin
   Result := Fill[Index].PatternType;
end;

function TXLSStyleFills.SetPatternType(const Index: integer; const Value: byte): integer;
var b: TXLSStyleFill;
    tmpColor: TXLSStyleColor;
begin
   b := Fill[Index];
   if (b.PatternType <> Value) then begin
       if Value = 0 then begin
          b := TXLSStyleFill(b.Clone());
          b.PatternType := 0;
          b.FgColor.Assign(0, 64, 0);
          b.BgColor.Assign(0, 65, 0);
       end else if ((b.PatternType = 1) and (Value <> 1)) or
                   ((b.PatternType <> 1) and (Value = 1)) then begin
          b := TXLSStyleFill(b.Clone());
          b.PatternType := Value and 127;
          TmpColor := b.FFgColor;
          b.FFgColor := b.FBgColor;
          b.FBgColor := TmpColor;
       end else begin
          b := TXLSStyleFill(b.Clone());
          b.PatternType := Value and 127;
       end;

       Result := SetFill(Index, b);
   end else begin
       Result := Index;
   end;
end;


function TXLSStyleFills.GetFgColorIndex(Index: integer): LongWord;
var b: TXLSStyleFill;
    Pattern: byte;
begin
   b := Fill[Index];
   Pattern := b.PatternType;
   if Pattern = 0 then begin
      Result := 0;
   end else if Pattern = 1 then begin
      Result := FColorManager.GetColorIndex(b.BgColor);
      Result := InternalColorIndex2ColorIndex(Result);
   end else begin
      Result := FColorManager.GetColorIndex(b.FgColor);
      Result := InternalColorIndex2ColorIndex(Result);
   end;
end;

function TXLSStyleFills.GetFgThemeColor(Index: integer): longword;
var b: TXLSStyleFill;
    Pattern: byte;
begin
   b := Fill[Index];
   Pattern := b.PatternType;
   if Pattern = 0 then begin
      Result := 0;
   end else if Pattern = 1 then begin
      Result := FColorManager.GetThemeColor(b.BgColor);
   end else begin
      Result := FColorManager.GetThemeColor(b.FgColor);
   end;
end;

function TXLSStyleFills.GetFgTintAndShade(Index: integer): double;
var b: TXLSStyleFill;
    Pattern: byte;
begin
   b := Fill[Index];
   Pattern := b.PatternType;
   if Pattern = 0 then begin
      Result := 0;
   end else if Pattern = 1 then begin
      Result := b.BgColor.TintAndShade;
   end else begin
      Result := b.FgColor.TintAndShade;
   end;
end;

function TXLSStyleFills.GetFgColor(Index: integer): longword;
var b: TXLSStyleFill;
    Pattern: byte;
begin
   b := Fill[Index];
   Pattern := b.PatternType;
   if Pattern = 0 then begin
      Result := 0;
   end else if Pattern = 1 then begin
      Result := FColorManager.GetRGBColor(b.BgColor);
   end else begin
      Result := FColorManager.GetRGBColor(b.FgColor);
   end;
end;


function TXLSStyleFills.GetBgColorIndex(Index: integer): LongWord;
var b: TXLSStyleFill;
    Pattern: byte;
begin
   b := Fill[Index];
   Pattern := b.PatternType;
   if Pattern = 0 then begin
      Result := 0;
   end else if Pattern = 1 then begin
      Result := FColorManager.GetColorIndex(b.FgColor);
      Result := InternalColorIndex2ColorIndex(Result);
   end else begin
      Result := FColorManager.GetColorIndex(b.BgColor);
      Result := InternalColorIndex2ColorIndex(Result);
   end;
end;

function TXLSStyleFills.GetBgThemeColor(Index: integer): longword;
var b: TXLSStyleFill;
    Pattern: byte;
begin
   b := Fill[Index];
   Pattern := b.PatternType;
   if Pattern = 0 then begin
      Result := 0;
   end else if Pattern = 1 then begin
      Result := FColorManager.GetThemeColor(b.FgColor);
   end else begin
      Result := FColorManager.GetThemeColor(b.BgColor);
   end;
end;

function TXLSStyleFills.GetBgTintAndShade(Index: integer): double;
var b: TXLSStyleFill;
    Pattern: byte;
begin
   b := Fill[Index];
   Pattern := b.PatternType;
   if Pattern = 0 then begin
      Result := 0;
   end else if Pattern = 1 then begin
      Result := b.FgColor.TintAndShade;
   end else begin
      Result := b.BgColor.TintAndShade;
   end;
end;

function TXLSStyleFills.GetBgColor(Index: integer): longword;
var b: TXLSStyleFill;
    Pattern: byte;
begin
   b := Fill[Index];
   Pattern := b.PatternType;
   if Pattern = 0 then begin
      Result := 0;
   end else if Pattern = 1 then begin
      Result := FColorManager.GetRGBColor(b.FgColor);
   end else begin
      Result := FColorManager.GetRGBColor(b.BgColor);
   end;
end;


function TXLSStyleFills.SetFgColorIndex(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleFill;
begin
   b := Fill[Index];
   b := TXLSStyleFill(b.Clone());
   if Value = 0 then begin
       b.PatternType := 0;
       b.BgColor.Assign(0, 65, 0);
       b.FgColor.Assign(0, 64, 0);
   end else if b.PatternType = 0 then begin
       b.PatternType := 1;
       b.FgColor.Assign(b.BgColor);
       b.BgColor.Assign(0, Value and 127, 0);
   end else if b.PatternType = 1 then begin
       b.BgColor.Assign(0, Value and 127, 0);
   end else begin
       b.FgColor.Assign(0, Value and 127, 0);
   end;
   Result := SetFill(Index, b);
end;

function TXLSStyleFills.SetFgColor(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleFill;
begin
   b := Fill[Index];
   b := TXLSStyleFill(b.Clone());
   if b.PatternType = 0 then begin
      b.PatternType := 1;
      b.FgColor.Assign(b.BgColor);
      b.BgColor.Assign(2, Value, 0);
   end else if b.PatternType = 1 then begin
       b.BgColor.Assign(2, Value, 0);
   end else begin
       b.FgColor.Assign(2, Value, 0);
   end;
   Result := SetFill(Index, b);
end;

function TXLSStyleFills.SetFgThemeColor(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleFill;
begin
   b := Fill[Index];
   b := TXLSStyleFill(b.Clone());
   if b.PatternType = 0 then begin
      b.PatternType := 1;
      b.FgColor.Assign(b.BgColor);
      b.BgColor.Assign(1, Value, 0);
   end else if b.PatternType = 1 then begin
       b.BgColor.Assign(1, Value, 0);
   end else begin
       b.FgColor.Assign(1, Value, 0);
   end;
   Result := SetFill(Index, b);
end;

function TXLSStyleFills.SetFgTintAndShade(const Index: integer; const Value: double): integer;
var b: TXLSStyleFill;
begin
   b := Fill[Index];
   b := TXLSStyleFill(b.Clone());
   if b.PatternType = 0 then begin
      b.PatternType := 1;
      b.FgColor.Assign(b.BgColor);
      b.BgColor.TintAndShade := Value;
   end else if b.PatternType = 1 then begin
       b.BgColor.TintAndShade := Value;
   end else begin
       b.FgColor.TintAndShade := Value;
   end;
   Result := SetFill(Index, b);
end;


function TXLSStyleFills.SetBgColorIndex(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleFill;
begin
   b := Fill[Index];
   b := TXLSStyleFill(b.Clone());
   if Value = 0 then begin
       b.PatternType := 0;
       b.BgColor.Assign(0, 65, 0);
       b.FgColor.Assign(0, 64, 0);
   end else if b.PatternType = 0 then begin
       b.PatternType := 1;
       b.BgColor.Assign(b.FgColor);
       b.FgColor.Assign(0, Value and 127, 0);
   end else if b.PatternType = 1 then begin
       b.FgColor.Assign(0, Value and 127, 0);
   end else begin
       b.BgColor.Assign(0, Value and 127, 0);
   end;

   Result := SetFill(Index, b);
end;

function TXLSStyleFills.SetBgColor(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleFill;
begin
   b := Fill[Index];
   b := TXLSStyleFill(b.Clone());
   if b.PatternType = 0 then begin
      b.PatternType := 1;
      b.BgColor.Assign(b.FgColor);
      b.FgColor.Assign(2, Value, 0);
   end else if b.PatternType = 1 then begin
       b.FgColor.Assign(2, Value, 0);
   end else begin
       b.BgColor.Assign(2, Value, 0);
   end;
   Result := SetFill(Index, b);
end;

function TXLSStyleFills.SetBgThemeColor(const Index: integer; const Value: LongWord): integer;
var b: TXLSStyleFill;
begin
   b := Fill[Index];
   b := TXLSStyleFill(b.Clone());
   if b.PatternType = 0 then begin
      b.PatternType := 1;
      b.BgColor.Assign(b.FgColor);
      b.FgColor.Assign(1, Value, 0);
   end else if b.PatternType = 1 then begin
       b.FgColor.Assign(1, Value, 0);
   end else begin
       b.BgColor.Assign(1, Value, 0);
   end;
   Result := SetFill(Index, b);
end;

function TXLSStyleFills.SetBgTintAndShade(const Index: integer; const Value: double): integer;
var b: TXLSStyleFill;
begin
   b := Fill[Index];
   b := TXLSStyleFill(b.Clone());
   if b.PatternType = 0 then begin
      b.PatternType := 1;
      b.BgColor.Assign(b.FgColor);
      b.FgColor.TintAndShade := Value;
   end else if b.PatternType = 1 then begin
       b.FgColor.TintAndShade := Value;
   end else begin
       b.BgColor.TintAndShade := Value;
   end;
   Result := SetFill(Index, b);
end;


function TXLSStyleFills.GetReferredFill(Index: integer): TXLSStyleFill;
begin
   Result := TXLSStyleFill(FReferredList[Index].FKey);
end;

end.
