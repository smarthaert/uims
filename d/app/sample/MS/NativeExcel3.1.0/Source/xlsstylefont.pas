//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsstylefont
//
//
//      Description:  font object
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

unit xlsstylefont;
{$Q-}
{$R-}

interface
{$I xlsdef.inc}
uses Classes, xlsstylecolor, xlsBlob, xlslist2, xlshashtable;

type 

  TXLSStyleFont = class;
  
  TXLSStyleFonts = class(TXLSObjectKeyList)
  private
     FColorManager: TXLSColorManager;
  public
     constructor Create(ColorManager: TXLSColorManager);
     destructor Destroy; override;

     function GetFont(Index: integer): TXLSStyleFont;


     function GetName(Index: integer): widestring;
     function GetSize(Index: integer): Single;
     function GetBold(Index: integer): boolean;
     function GetItalic(Index: integer): boolean;
     function GetStrikethrough(Index: integer): boolean;
     function GetOutLineFont(Index: integer): boolean;
     function GetShadow(Index: integer): boolean;
     function GetUnderLine(Index: integer): byte;
     function GetSubScript(Index: integer): boolean;
     function GetSuperScript(Index: integer): boolean;
     function GetFamily(Index: integer): byte;
     function GetCharSet(Index: integer): byte;
     function GetColorIndex(Index: integer): LongWord;
     function GetThemeColor(Index: integer): longword;
     function GetTintAndShade(Index: integer): double;
     function GetColor(Index: integer): longword;


     function SetFont(Index: integer; Value: TXLSStyleFont): integer;

     function GetSaveIndex(Index: integer): integer; override;

     property Font[Index: integer]: TXLSStyleFont read GetFont;
     property Name[Index: integer]: widestring read GetName;
     property Size[Index: integer]: Single read GetSize;

     property ColorIndex[Index: integer]: LongWord read GetColorIndex;
     property Color[Index: integer]: LongWord read GetColor;
     property ThemeColor[Index: integer]: LongWord read GetThemeColor;
     property TintAndShade[Index: integer]: double read GetTintAndShade;

     property Bold[Index: integer]: boolean read GetBold;
     property Italic[Index: integer]: boolean read GetItalic;
     property Strikethrough[Index: integer]: boolean read GetStrikethrough;
     property OutLineFont[Index: integer]: boolean read GetOutLineFont;
     property Shadow[Index: integer]: boolean read GetShadow;
     property Underline[Index: integer]: byte read GetUnderline;
     property SubScript[Index: integer]: boolean read GetSubScript;
     property SuperScript[Index: integer]: boolean read GetSuperScript;
     property Family[Index: integer]: byte read GetFamily;
     property CharSet[Index: integer]: byte read GetCharSet;

     function SetSize(const Index: integer; const Value: Single): integer;

     function SetColorIndex(const Index: integer; const Value: LongWord): integer;
     function SetColor(const Index: integer; const Value: LongWord): integer;
     function SetThemeColor(const Index: integer; const Value: LongWord): integer;
     function SetTintAndShade(const Index: integer; const Value: double): integer;

     function SetBold(const Index: integer; const Value: boolean): integer;
     function SetItalic(const Index: integer; const Value: boolean): integer;
     function SetStrikethrough(const Index: integer; const Value: boolean): integer;
     function SetOutLineFont(const Index: integer; const Value: boolean): integer;
     function SetShadow(const Index: integer; const Value: boolean): integer;
     function SetUnderLine(const Index: integer; const Value: byte): integer;
     function SetSubScript(const Index: integer; const Value: boolean): integer;
     function SetSuperScript(const Index: integer; const Value: boolean): integer;
     function SetFamily(const Index: integer; const Value: byte): integer;
     function SetCharSet(const Index: integer; const Value: byte): integer;
     function SetName(const Index: integer; const Value: widestring): integer;
     function GetFontData(Index: integer; FileFormat: TXLSFileFormat): TXLSBlob;
     function GetReferredFont(Index: integer): TXLSStyleFont;

     function TransformKey(Key: THashtableKey): THashtableKey; override;

     procedure SetDefaultCount(Value: integer); 
     property DefaultKey: THashtableKey read FDefaultKey;
  end;

  TXLSStyleFont = class(THashTableKey)
  private
     FName: widestring;
     FSize: word;
     FBold: boolean;
     FItalic: boolean;
     FStrikethrough: boolean;
     FOutLineFont: boolean;
     FUnderline: byte;
     FSubScript: boolean;
     FSuperScript: boolean;
     FFamily: byte;
     FCharSet: byte;   
     FShadow: boolean;
     FColor: TXLSStyleColor;

     function GetName: widestring;
     function GetSize: Single;
     function GetBold: boolean;
     function GetItalic: boolean;
     function GetStrikethrough: boolean;
     function GetOutLineFont: boolean;
     function GetShadow: boolean;
     function GetUnderLine: byte;
     function GetSubScript: boolean;
     function GetSuperScript: boolean;
     function GetFamily: byte;
     function GetCharSet: byte;

     procedure SetSize(const Value: Single);
     procedure SetBold(const Value: boolean);
     procedure SetItalic(const Value: boolean);
     procedure SetStrikethrough(const Value: boolean);
     procedure SetOutLineFont(const Value: boolean);
     procedure SetShadow(const Value: boolean);
     procedure SetUnderLine(const Value: byte);
     procedure SetSubScript(const Value: boolean);
     procedure SetSuperScript(const Value: boolean);
     procedure SetFamily(const Value: byte);
     procedure SetCharSet(const Value: byte);
     procedure SetName(const Value: widestring);
  public
     constructor Create;
     destructor Destroy; override;
     function CloneBIFF8(AColorManager: TXLSColorManager): THashTableKey;
     function CloneBIFF5(AColorManager: TXLSColorManager): THashTableKey;
     function Clone: THashTableKey; override;
     function _GetHashCode: longint; override;
     function _Equals(obj: THashTableKey): boolean; override;
     property Name: widestring read GetName write SetName;
     property Size: Single read GetSize write SetSize;
     property Color: TXLSStyleColor read FColor;
     property Bold: boolean read GetBold write SetBold;
     property Italic: boolean read GetItalic write SetItalic;
     property Strikethrough: boolean read GetStrikethrough write SetStrikethrough;
     property OutLineFont: boolean read GetOutLineFont write SetOutLineFont;
     property Shadow: boolean read GetShadow write SetShadow;
     property Underline: byte read GetUnderline write SetUnderline;
     property SubScript: boolean read GetSubScript write SetSubScript;
     property SuperScript: boolean read GetSuperScript write SetSuperScript;
     property Family: byte read GetFamily write SetFamily;
     property CharSet: byte read GetCharSet write SetCharset;
  end;

implementation
uses xlshash;

{TXLSStyleFont}
constructor TXLSStyleFont.Create;
begin
  inherited Create;
  FColor := TXLSStyleColor.Create;
end;

destructor TXLSStyleFont.Destroy; 
begin
  FColor.Free;
  inherited Destroy;
end;

function TXLSStyleFont.GetName: widestring;
begin
  Result := FName;
end;

function TXLSStyleFont.GetSize: Single;
begin
  Result := FSize / 20;
end;

function TXLSStyleFont.GetBold: boolean;
begin
  Result := FBold;
end;

function TXLSStyleFont.GetItalic: boolean;
begin
  Result := FItalic;
end;

function TXLSStyleFont.GetStrikethrough: boolean;
begin
  Result := FStrikethrough;
end;

function TXLSStyleFont.GetOutLineFont: boolean;
begin
   Result := FOutLineFont;
end;

function TXLSStyleFont.GetShadow: boolean;
begin
   Result := FShadow;
end;

function TXLSStyleFont.GetUnderLine: byte;
begin
   Result := FUnderLine;
end;

function TXLSStyleFont.GetSubScript: boolean;
begin
   Result := FSubScript;
end;

function TXLSStyleFont.GetSuperScript: boolean;
begin
   Result := FSuperScript;
end;

function TXLSStyleFont.GetFamily: byte;
begin
   Result := FFamily;
end;

function TXLSStyleFont.GetCharSet: byte;
begin
  Result := FCharSet;
end;

procedure TXLSStyleFont.SetSize(const Value: Single);
begin
  FSize :=  Round(Value * 20);
end;

procedure TXLSStyleFont.SetBold(const Value: boolean);
begin
   FBold := Value; 
end;

procedure TXLSStyleFont.SetItalic(const Value: boolean);
begin
   FItalic := Value; 
end;

procedure TXLSStyleFont.SetStrikethrough(const Value: boolean);
begin
  FStrikethrough := Value; 
end;

procedure TXLSStyleFont.SetOutLineFont(const Value: boolean);
begin
   FOutLineFont := Value; 
end;

procedure TXLSStyleFont.SetShadow(const Value: boolean);
begin
   FShadow := Value; 
end;

procedure TXLSStyleFont.SetUnderLine(const Value: byte);
begin
  FUnderLine := Value; 
end;

procedure TXLSStyleFont.SetSubScript(const Value: boolean);
begin
  FSubScript := Value; 
  if Value then FSuperScript := false;
end;

procedure TXLSStyleFont.SetSuperScript(const Value: boolean);
begin
  FSuperScript := Value; 
  if Value then FSubScript := false;
end;

procedure TXLSStyleFont.SetFamily(const Value: byte);
begin
  FFamily := Value; 
end;

procedure TXLSStyleFont.SetCharSet(const Value: byte);
begin
  FCharSet := Value; 
end;

procedure TXLSStyleFont.SetName(const Value: widestring);
begin
   FName := Value; 
end;

function TXLSStyleFont._GetHashCode: longint;
Var HashCode:longword;
begin
   HashCode := 1;   

   HashCode := 33 * HashCode + longword(FSize);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode +  ( longword(FBold) or 
                                 (longword(FItalic) shl 1) or
                                 (longword(FStrikethrough) shl 2) or
                                 (longword(FOutLineFont) shl 3) or
                                 (longword(FSubScript) shl 4) or
                                 (longword(FSuperScript) shl 5) or
                                 (longword(FShadow) shl 6)
                               );
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + ( longword(FUnderline) or 
                                 (longword(FFamily) shl 8) or
                                 (longword(FCharSet) shl 16)
                               );
   HashCode := 33 * HashCode + longword(xlshash.GetWideStringHashCode(FName));
   HashCode := 33 * HashCode + longword(FColor._GetHashCode);

   HashCode := HashCode + HashCode shr 5;

   HashCode := HashCode + HashCode shr 5;
   Result := longint(HashCode);
end;

function TXLSStyleFont.CloneBIFF8(AColorManager: TXLSColorManager): THashTableKey;
var f: TXLSStyleFont;
begin
   f := TXLSStyleFont.Create;
   f.FSize          := FSize;
   f.FName          := FName;
   f.FBold          := FBold;
   f.FItalic        := FItalic;
   f.FOutlineFont   := FOutlineFont;
   f.FStrikethrough := FStrikethrough;
   f.FSubscript     := FSubscript;
   f.FSuperscript   := FSuperscript;
   f.FShadow        := FShadow;
   f.FUnderline     := FUnderline;
   f.FFamily        := FFamily;
   f.FCharSet       := FCharSet;
   f.FColor.Assign(FColor);
   AColorManager.TransformColor(f.Color, $600); 
   Result := f;
end;

function TXLSStyleFont.CloneBIFF5(AColorManager: TXLSColorManager): THashTableKey;
var f: TXLSStyleFont;
begin
   f := TXLSStyleFont.Create;
   f.FSize          := FSize;
   f.FName          := FName;
   f.FBold          := FBold;
   f.FItalic        := FItalic;
   f.FOutlineFont   := FOutlineFont;
   f.FStrikethrough := FStrikethrough;
   f.FSubscript     := FSubscript;
   f.FSuperscript   := FSuperscript;
   f.FShadow        := FShadow;
   f.FUnderline     := FUnderline;
   f.FFamily        := FFamily;
   f.FCharSet       := FCharSet;
   f.FColor.Assign(FColor);
   AColorManager.TransformColor(f.Color, $500); 
   Result := f;
end;

function TXLSStyleFont.Clone: THashTableKey;
var f: TXLSStyleFont;
begin
   f := TXLSStyleFont.Create;
   f.FSize          := FSize;
   f.FName          := FName;
   f.FBold          := FBold;
   f.FItalic        := FItalic;
   f.FOutlineFont   := FOutlineFont;
   f.FStrikethrough := FStrikethrough;
   f.FSubscript     := FSubscript;
   f.FSuperscript   := FSuperscript;
   f.FShadow        := FShadow;
   f.FUnderline     := FUnderline;
   f.FFamily        := FFamily;
   f.FCharSet       := FCharSet;
   f.FColor.Assign(FColor);
   Result := f;
end;

function TXLSStyleFont._Equals(obj: THashTableKey): boolean;
var o: TXLSStyleFont;
begin
   if Not(Assigned(obj)) then begin
      Result := false;
   end else if self = obj then begin
      Result := true;
   end else begin
      o := TXLSStyleFont(obj);
      Result := (FName = o.FName);
      if not(Result) then exit;
      Result := (FSize = o.FSize);  
      if not(Result) then exit;
      Result := (FBold          = o.FBold);         
      if not(Result) then exit;
      Result := (FItalic        = o.FItalic);       
      if not(Result) then exit;
      Result := (FOutlineFont   = o.FOutlineFont);  
      if not(Result) then exit;
      Result := (FStrikethrough = o.FStrikethrough);
      if not(Result) then exit;
      Result := (FSubscript     = o.FSubscript);    
      if not(Result) then exit;
      Result := (FSuperscript   = o.FSuperscript);  
      if not(Result) then exit;
      Result := (FShadow        = o.FShadow);       
      if not(Result) then exit;
      Result := (FUnderline     = o.FUnderline);    
      if not(Result) then exit;
      Result := (FFamily        = o.FFamily);                
      if not(Result) then exit;
      Result := (FCharSet       = o.FCharSet);        
      if not(Result) then exit;
      Result := FColor._Equals(o.FColor);        
      if not(Result) then exit;
   end;
end;


{TXLSStyleFonts}
constructor TXLSStyleFonts.Create(ColorManager: TXLSColorManager);
var d: TXLSStyleFont;
begin
  inherited Create;
  FColorManager := ColorManager;
  FDefaultCount := 4;
  FStartIndex := 0;
  d := TXLSStyleFont.Create();
  d.Color.Assign(0, $7FFF, 0);
  d.Size := 10;
  d.Name := 'Arial';
  FDefaultKey := d;
end;

destructor TXLSStyleFonts.Destroy;
begin
  FDefaultKey.Free;
  FDefaultKey := nil;
  inherited Destroy;
end;

function TXLSStyleFonts.GetFont(Index: integer): TXLSStyleFont;
begin
  Result := TXLSStyleFont(Key[Index]);
end;

function TXLSStyleFonts.SetFont(Index: integer; Value: TXLSStyleFont): integer;
begin
  Result := SetKey(Index, Value, true);
end;

function TXLSStyleFonts.GetName(Index: integer): widestring;
begin
  Result := Font[Index].Name;
end;

function TXLSStyleFonts.GetSize(Index: integer): Single;
begin
  Result := Font[Index].Size;
end;

function TXLSStyleFonts.GetColorIndex(Index: integer): LongWord;
begin
  Result := FColorManager.GetColorIndex(Font[Index].Color);

  if (Result > 7) and (Result < 64) then 
     Result := Result - 7
  else if Result = 0 then 
     Result := xlColorIndexNone
  else if Result = $7FFF then 
     Result := xlColorIndexAutomatic;
end;

function TXLSStyleFonts.GetThemeColor(Index: integer): longword;
begin
  Result := FColorManager.GetThemeColor(Font[Index].Color);
end;

function TXLSStyleFonts.GetTintAndShade(Index: integer): double;
begin
  Result := Font[Index].Color.TintAndShade;
end;

function TXLSStyleFonts.GetColor(Index: integer): longword;
begin
  Result := FColorManager.GetRGBColor(Font[Index].Color);
end;

function TXLSStyleFonts.GetBold(Index: integer): boolean;
begin
  Result := Font[Index].Bold;
end;

function TXLSStyleFonts.GetItalic(Index: integer): boolean;
begin
  Result := Font[Index].Italic;
end;

function TXLSStyleFonts.GetStrikethrough(Index: integer): boolean;
begin
  Result := Font[Index].Strikethrough;
end;

function TXLSStyleFonts.GetOutLineFont(Index: integer): boolean;
begin
  Result := Font[Index].OutLineFont;
end;

function TXLSStyleFonts.GetShadow(Index: integer): boolean;
begin
  Result := Font[Index].Shadow;
end;

function TXLSStyleFonts.GetUnderLine(Index: integer): byte;
begin
  Result := Font[Index].UnderLine;
end;

function TXLSStyleFonts.GetSubScript(Index: integer): boolean;
begin
  Result := Font[Index].SubScript;
end;

function TXLSStyleFonts.GetSuperScript(Index: integer): boolean;
begin
  Result := Font[Index].SuperScript;
end;

function TXLSStyleFonts.GetFamily(Index: integer): byte;
begin
  Result := Font[Index].Family;
end;

function TXLSStyleFonts.GetCharSet(Index: integer): byte;
begin
  Result := Font[Index].CharSet;
end;

function TXLSStyleFonts.GetSaveIndex(Index: integer): integer; 
begin
  Result := inherited GetSaveIndex(Index);
  if (Result > 0) and (Result < 5) then Dec(Result);
end;

function TXLSStyleFonts.SetSize(const Index: integer; const Value: Single): integer;
var f: TXLSStyleFont;
begin
   f := Font[Index];
   if (f.Size <> Value) then begin
       f := TXLSStyleFont(TXLSStyleFont(f.Clone()));
       f.Size := Value;
       Result := SetFont(Index, f);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleFonts.SetColorIndex(const Index: integer; const Value: LongWord): integer;
var f: TXLSStyleFont;
    ColorIndex: LongWord;
begin
  ColorIndex := Value;
  if (ColorIndex = xlColorIndexAutomatic) or 
     (ColorIndex = xlColorIndexNone) or 
     (ColorIndex <= 56) then begin

     if (ColorIndex > 0) and (ColorIndex <= 56) then 
         ColorIndex := ColorIndex + 7;
       
     f := Font[Index];
     if not(f.Color.IsEqual(0, ColorIndex, 0)) then begin
         f := TXLSStyleFont(f.Clone());
         f.Color.Assign(0, ColorIndex, 0);
         Result := SetFont(Index, f);
     end else begin
         Result := Index;
     end;
  end else begin
     Result := Index;
  end;
end;


function TXLSStyleFonts.SetColor(const Index: integer; const Value: LongWord): integer;
var f: TXLSStyleFont;
begin
   f := Font[Index];
   if not(f.Color.IsEqual(2, Value, 0)) then begin
       f := TXLSStyleFont(f.Clone());
       f.Color.Assign(2, Value, 0);
       Result := SetFont(Index, f);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleFonts.SetThemeColor(const Index: integer; const Value: LongWord): integer;
var f: TXLSStyleFont;
begin
   f := Font[Index];
   if not(f.Color.IsEqual(1, Value, 0)) then begin
       f := TXLSStyleFont(f.Clone());
       f.Color.Assign(1, Value, 0);
       Result := SetFont(Index, f);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleFonts.SetTintAndShade(const Index: integer; const Value: double): integer;
var f: TXLSStyleFont;
begin
   f := Font[Index];
   if not(f.Color.IsEqual(f.Color.ColorType, f.Color.ColorValue, Value)) then begin
       f := TXLSStyleFont(f.Clone());
       f.Color.TintAndShade := Value;
       Result := SetFont(Index, f);
   end else begin
       Result := Index;
   end;
end;


function TXLSStyleFonts.SetBold(const Index: integer; const Value: boolean): integer;
var f: TXLSStyleFont;
begin
   f := Font[Index];
   if (f.Bold <> Value) then begin
       f := TXLSStyleFont(f.Clone());
       f.Bold := Value;
       Result := SetFont(Index, f);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleFonts.SetItalic(const Index: integer; const Value: boolean): integer;
var f: TXLSStyleFont;
begin
   f := Font[Index];
   if (f.Italic <> Value) then begin
       f := TXLSStyleFont(f.Clone());
       f.Italic := Value;
       Result := SetFont(Index, f);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleFonts.SetStrikethrough(const Index: integer; const Value: boolean): integer;
var f: TXLSStyleFont;
begin
   f := Font[Index];
   if (f.Strikethrough <> Value) then begin
       f := TXLSStyleFont(f.Clone());
       f.Strikethrough := Value;
       Result := SetFont(Index, f);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleFonts.SetOutLineFont(const Index: integer; const Value: boolean): integer;
var f: TXLSStyleFont;
begin
   f := Font[Index];
   if (f.OutLineFont <> Value) then begin
       f := TXLSStyleFont(f.Clone());
       f.OutLineFont := Value;
       Result := SetFont(Index, f);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleFonts.SetShadow(const Index: integer; const Value: boolean): integer;
var f: TXLSStyleFont;
begin
   f := Font[Index];
   if (f.Shadow <> Value) then begin
       f := TXLSStyleFont(f.Clone());
       f.Shadow := Value;
       Result := SetFont(Index, f);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleFonts.SetUnderLine(const Index: integer; const Value: byte): integer;
var f: TXLSStyleFont;
begin
   f := Font[Index];
   if (f.UnderLine <> Value) then begin
       f := TXLSStyleFont(f.Clone());
       f.UnderLine := Value;
       Result := SetFont(Index, f);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleFonts.SetSubScript(const Index: integer; const Value: boolean): integer;
var f: TXLSStyleFont;
begin
   f := Font[Index];
   if (f.SubScript <> Value) then begin
       f := TXLSStyleFont(f.Clone());
       f.SubScript := Value;
       Result := SetFont(Index, f);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleFonts.SetSuperScript(const Index: integer; const Value: boolean): integer;
var f: TXLSStyleFont;
begin
   f := Font[Index];
   if (f.SuperScript <> Value) then begin
       f := TXLSStyleFont(f.Clone());
       f.SuperScript := Value;
       Result := SetFont(Index, f);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleFonts.SetFamily(const Index: integer; const Value: byte): integer;
var f: TXLSStyleFont;
begin
   f := Font[Index];
   if (f.Family <> Value) then begin
       f := TXLSStyleFont(f.Clone());
       f.Family := Value;
       Result := SetFont(Index, f);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleFonts.SetCharSet(const Index: integer; const Value: byte): integer;
var f: TXLSStyleFont;
begin
   f := Font[Index];
   if (f.CharSet <> Value) then begin
       f := TXLSStyleFont(f.Clone());
       f.CharSet := Value;
       Result := SetFont(Index, f);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleFonts.SetName(const Index: integer; const Value: widestring): integer;
var f: TXLSStyleFont;
begin
   f := Font[Index];
   if (f.Name <> Value) then begin
       f := TXLSStyleFont(f.Clone());
       f.Name := Value;
       Result := SetFont(Index, f);
   end else begin
       Result := Index;
   end;
end;

function TXLSStyleFonts.GetReferredFont(Index: integer): TXLSStyleFont;
begin
   Result := TXLSStyleFont(FReferredList[Index].FKey);
end;

function TXLSStyleFonts.GetFontData(Index: integer; FileFormat: TXLSFileFormat): TXLSBlob;
Var f: TXLSStyleFont;
    icv: word;
    grbit: word;
begin
   f := TXLSStyleFont(FReferredList[Index].FKey);
   
   if FileFormat = xlExcel5 then
      Result := TXLSBlob.Create(19 +  Length(f.Name))
   else
      Result := TXLSBlob.Create(20 +  Length(f.Name) * 2);
   Result.AddWord($0031);  //Record
   Result.AddWord($0000); //Length
   
   Result.AddWord(f.FSize);  //dyHeight
   grbit := 0;
   if f.Italic        then grbit := grbit or (1 shl 1);
   if f.Strikethrough then grbit := grbit or (1 shl 3);
   if f.OutLineFont   then grbit := grbit or (1 shl 4);
   if f.Shadow        then grbit := grbit or (1 shl 5);
   Result.AddWord(grbit);
   icv := FColorManager.GetColorIndexToSore(f.Color);
   if icv = 0 then icv := $7FFF;
   Result.AddWord(icv);        //icv

   if f.Bold then
      Result.AddWord(700)                  //bls
   else
      Result.AddWord(400);                  //bls

   grbit := 0;
   if f.SuperScript       then grbit := grbit or 1;
   if f.SubScript         then grbit := grbit or 2;
   Result.AddWord(grbit); 
   Result.AddByte(f.Underline);
   Result.AddByte(f.Family);
   Result.AddByte(f.Charset);
   Result.AddByte(0); //reserved
   Result.AddByte(Length(f.Name));
   if FileFormat = xlExcel5 then begin
      Result.AddString(AnsiString(f.Name));
   end else begin
      Result.AddByte(1); 
      Result.AddWideString(f.Name);            //rgch
   end;

   Result.SetWord(Result.DataLength - 4, 2); //SetLength
end;

procedure TXLSStyleFonts.SetDefaultCount(Value: integer);
begin
  FDefaultCount := Value;
end;

function TXLSStyleFonts.TransformKey(Key: THashtableKey): THashtableKey;
begin
  if TransformMode = $500 then begin
     //biff5
     if Assigned(Key) then begin
        Result := TXLSStyleFont(Key).CloneBiff5(FColorManager);
     end else begin
        Result := nil;
     end; 
  end else if TransformMode = $600 then begin
     //biff8
     if Assigned(Key) then begin
        Result := TXLSStyleFont(Key).CloneBiff8(FColorManager);
     end else begin
        Result := nil;
     end; 
  end else begin
     Result := Key.Clone;
  end; 
end;

end.