/////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsstylexf
//
//
//      Description:  xf
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

unit xlsstylexf;
{$Q-}
{$R-}

interface
{$I xlsdef.inc}
uses Classes, xlsstylecolor, xlsBlob, xlslist2, xlshashtable,
     xlsstylefont, xlsstyleborder, xlsstylefill, 
     xlslist, xlshash;

type 
  TSetXFProperty = function (const XFIndex: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer of object;
  TSetXFBorderProperty = function (const XFIndex: integer; BorderMask: byte; const Value: OleVariant; const ReplaceIndex: boolean): integer of object;

  TXLSNumFormatList = class(TXLSStringList)
  protected
    FBuiltin: TXLSStringList;
    FDateFlags: TBoolArray;
    function GetItem(Index: integer): widestring; override;
    function GetShortDateFormat: widestring;
    function GetShortTimeFormat: widestring;
    procedure FillBuiltin;
  public
    constructor Create;
    destructor Destroy; override;
    function GetNumFormatBlob(Index: integer; FileFormat:TXLSFileFormat):TXLSBlob;
    function AddValue(Value: widestring): integer; override;
    function IsDateFormatValue(Format: Widestring): boolean;
    function IsDateFormat(index: integer): boolean;
    function FmtExists(value: widestring): boolean;
    procedure SetItem(Index: integer; Value: widestring); override;
  end;

  TXLSStyleEntry = class
  private
     FXFIndex: integer;
     FName: widestring;
     FBuiltinID: integer;
     FILevel: integer;
     FHidden: boolean;
     FCustom: boolean;
  public
     constructor Create;
     property XFIndex: integer read FXFIndex write FXFIndex;
     property Name: widestring read FName write FName;
     property BuiltinID: integer read FBuiltinID write FBuiltinID;
     property ILevel: integer read FILevel write FILevel;
     property Hidden: boolean read FHidden write FHidden;
     property Custom: boolean read FCustom write FCustom;
  end;


  TXLSStyleXFs = class;

  TXLSStyles = class
  private
    FXFList: TXLSStyleXFs;
    FArr: TList;
    function GetCount: integer;
  public
    constructor Create (XFList: TXLSStyleXFs);
    destructor Destroy; override;
    function GetXFIndex(Index: integer): integer;
    procedure Add(style: TXLSStyleEntry);
    procedure AddStyle(Name: widestring; XFIndex: integer);
    procedure AddBuiltinStyle(Code: byte; XFIndex: integer; iLevel: integer);
    function GetStyleBlob(Index: integer; FileFormat: TXLSFileFormat): TXLSBlob;
    function GetStyleEntry(Index: integer): TXLSStyleEntry;
    procedure _Clear;
    property Count: integer read GetCount;
  end;

  TXLSStyleXF = class;
  TXLSStyleXFFullState = class;
  
  TXLSStyleXFs = class(TXLSObjectKeyList)
  private
     FColorManager: TXLSColorManager;
     FBorders: TXLSStyleBorders;
     FStyles: TXLSStyles;
     FFills: TXLSStyleFills;
     FFormats: TXLSNumFormatList;
     FFonts: TXLSStyleFonts;

     function SetNumFormatIndex(Index, Value: integer; ReplaceIndex: boolean): integer;
     function GetFontIndex(Index: integer): integer;
     function SetFontIndex(Index: integer; Value: integer; ReplaceIndex: boolean): integer;
     function GetNumFormatIndex(Index: integer): integer;
     function GetBorderIndex(Index: integer): integer;
     function SetBorderIndex(Index: integer; Value: integer; ReplaceIndex: boolean): integer;
     function GetFillIndex(Index: integer): integer;
     function SetFillIndex(Index: integer; Value: integer; ReplaceIndex: boolean): integer;
     function GetProtection(Index: integer): byte;
     function SetProtection(Index: integer; const Value: byte; ReplaceIndex: boolean): integer;

     function GetAlignmentIndex(Index: integer): integer;
     procedure SetTransformMode(Value: integer);
     function CloneCellXf(f: TXLSStyleXF; Index: integer): TXLSStyleXF; 

  public
     constructor Create(ColorManager: TXLSColorManager);
     destructor Destroy; override;
     function CreateNewXFormat: TXLSStyleXF;
     procedure CreateDefaultFills;
     procedure CreateDefault;
     procedure CreateDefault2007;
     //numformat
     function GetNumFormat(Index: integer): widestring;
     function SetNumFormat(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function IsDateFormat(Index: integer): boolean;
     //font
     function GetFontBold(Index: integer): boolean;
     function GetFontCharSet(Index: integer): byte;
     function GetFontColorIndex(Index: integer): LongWord;
     function GetFontColor(Index: integer): LongWord;
     function GetFontTintAndShade(Index: integer): double;
     function GetFontThemeColor(Index: integer): LongWord;
     function GetFontFamily(Index: integer): byte;
     function GetFontItalic(Index: integer): boolean;
     function GetFontName(Index: integer): widestring;
     function GetFontOutLineFont(Index: integer): boolean;
     function GetFontShadow(Index: integer): boolean;
     function GetFontSize(Index: integer): Single;
     function GetFontStrikethrough(Index: integer): boolean;
     function GetFontSubScript(Index: integer): boolean;
     function GetFontSuperScript(Index: integer): boolean;
     function GetFontUnderLine(Index: integer): byte;
     function SetFontName(const XFIndex: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function SetFontBold(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function SetFontCharSet(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function SetFontColorIndex(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function SetFontColor(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function SetFontThemeColor(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function SetFontTintAndShade(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function SetFontFamily(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function SetFontItalic(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function SetFontOutLineFont(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function SetFontShadow(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function SetFontSize(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function SetFontStrikethrough(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function SetFontSubScript(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function SetFontSuperScript(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function SetFontUnderLine(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     //protection
     function GetLocked(Index: integer): boolean;
     function SetLocked(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function GetHidden(Index: integer): boolean;
     function SetHidden(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     //alignment
     function GetHorAlign(const Index: integer): byte;
     function SetHorAlign(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function GetVerAlign(const Index: integer): byte;
     function SetVerAlign(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function GetWrap(const Index: integer): boolean;
     function SetWrap(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function GetOrientation(const Index: integer): byte;
     function SetOrientation(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function GetIndentLevel(const Index: integer): byte;
     function SetIndentLevel(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function GetShrinkToFit(const Index: integer): boolean;
     function SetShrinkToFit(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function GetReadingOrder(const Index: integer): integer;
     function SetReadingOrder(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     //border
     function GetLineStyleFromBorderStyle(const BorderStyle: byte): LongWord;
     function GetWeightFromBorderStyle(const BorderStyle: byte): LongWord;
     function GetBorderStyle(const Index: integer; BorderMask: byte): byte;
     function GetBorderLineStyle(const Index: integer; BorderMask: byte): LongWord;
     function SetBorderLineStyle(const Index: integer; BorderMask: byte; const Value: OleVariant; const ReplaceIndex: boolean): integer;

     function GetBorderColorIndex(const Index: integer; BorderMask: byte): LongWord;
     function SetBorderColorIndex(const Index: integer; BorderMask: byte; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function GetBorderColor(const Index: integer; BorderMask: byte): LongWord;
     function SetBorderColor(const Index: integer; BorderMask: byte; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function GetBorderThemeColor(const Index: integer; BorderMask: byte): LongWord;
     function SetBorderThemeColor(const Index: integer; BorderMask: byte; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function GetBorderTintAndShade(const Index: integer; BorderMask: byte): double;
     function SetBorderTintAndShade(const Index: integer; BorderMask: byte; const Value: OleVariant; const ReplaceIndex: boolean): integer;

     function GetBorderWeight(const Index: integer; BorderMask: byte): LongWord;
     function SetBorderWeight(const Index: integer; BorderMask: byte; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function GetBordersDefined(Index: integer): boolean;
     //fill
     function GetInteriorPattern(const Index: integer): byte;
     function SetInteriorPattern(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;

     function GetInteriorPatternColorIndex(const Index: integer): longword;
     function GetInteriorPatternColor(const Index: integer): longword;
     function GetInteriorPatternThemeColor(const Index: integer): longword;
     function GetInteriorPatternTintAndShade(const Index: integer): double;

     function SetInteriorPatternColorIndex(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function SetInteriorPatternColor(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function SetInteriorPatternThemeColor(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function SetInteriorPatternTintAndShade(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;

     function GetInteriorColorIndex(const Index: integer): longword;
     function GetInteriorColor(const Index: integer): longword;
     function GetInteriorThemeColor(const Index: integer): longword;
     function GetInteriorTintAndShade(const Index: integer): double;

     function SetInteriorColorIndex(const Index: integer;  const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function SetInteriorColor(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function SetInteriorThemeColor(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
     function SetInteriorTintAndShade(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;

     procedure CreateAllReferredList(ATransformMode: integer);
     procedure _Clear; 

     function GetXF(Index: integer): TXLSStyleXF;
     function SetXF(Index: integer; Value: TXLSStyleXF): integer;
     function GetReferredXf(Index: integer): TXLSStyleXF;
     function GetXFBlob(Index: integer; FileFormat: TXLSFileFormat): TXLSBlob;

     function GetSaveIndex(Index: integer): integer; override;
     function TransformKey(Key: THashtableKey): THashtableKey; override;

     function GetFullFormat(Index: integer): TXLSStyleXFFullState;
     function SetFullFormat(Value: TXLSStyleXFFullState): integer;

     procedure SetDefaultCount(Value: integer); 
     procedure CopyFormat(SrcIndex, DstIndex: integer);
     property DefaultKey: THashtableKey read FDefaultKey;
     property XF[Index: integer]: TXLSStyleXF read GetXF;

     property Fonts: TXLSStyleFonts read FFonts;
     property Borders: TXLSStyleBorders read FBorders;
     property Formats: TXLSNumFormatList read FFormats;
     property Styles: TXLSStyles read FStyles;
     property Fills: TXLSStyleFills read FFills;
  end;

  TXLSStyleXFFullState = class
  private
     FXF: TXLSStyleXF;
     FFont: TXLSStyleFont;
     FNumFormat: widestring;
     FBorder: TXLSStyleBorder;
     FFill: TXLSStyleFill;
  public 
     constructor Create(xf: TXLSStyleXF; 
                        fnt: TXLSStyleFont; 
                        numformat: widestring;
                        brd: TXLSStyleBorder;
                        fill: TXLSStyleFill);
     destructor Destroy;  override;
  end;

  TXLSStyleXF = class(THashTableKey)
  private
     FFontIndex: integer;
     FNumFormatIndex: integer;
     FBorderIndex: integer;
     FFillIndex: integer;
     FParentStyleIndex: integer;
     //Alignment
     FReadingOrder: byte; //0,1,2
     FShrinkToFit: boolean;

     FIndentLevel: byte;
     FRelativeIndent: integer; //An integer value (used only in a dxf element) to indicate the additional number of spaces
                               //of indentation to adjust for text in a cell.
     FOrientation: byte;
     FWrapText: boolean;
     FVerAlign: byte;
     FHorAlign: byte;
     FJustifyLastLine: boolean;
     //protection
     FProtection: byte;
     FUsedAttributes: byte;

     function GetLocked: boolean;
     procedure SetLocked(Value: boolean);
     function GetHidden: boolean;
     procedure SetHidden(Value: boolean);
     function GetIsStyleXF: boolean;
     procedure SetIsStyleXF(value: boolean);
     function GetApplyAlignment: boolean;
     procedure SetApplyAlignment(Value: boolean);
     function GetApplyFont: boolean;
     procedure SetApplyFont(Value: boolean);
     function GetApplyBorder: boolean;
     procedure SetApplyBorder(Value: boolean);
     function GetApplyFill: boolean;
     procedure SetApplyFill(Value: boolean);
     function GetApplyNumFormat: boolean;
     procedure SetApplyNumFormat(Value: boolean);
     function GetApplyProtection: boolean;
     procedure SetApplyProtection(Value: boolean);

  public
     constructor Create;
     destructor Destroy; override;

     function CloneBIFF8(AColorManager: TXLSColorManager; Parent: TXLSStyleXFs): TXLSStyleXF;
     function CloneBIFF5(AColorManager: TXLSColorManager; Parent: TXLSStyleXFs): TXLSStyleXF;
     function Clone: THashTableKey; override;
     function _GetHashCode: longint; override;
     function _Equals(obj: THashTableKey): boolean; override;
     procedure CopyAlignment(SrcXF: TXLSStyleXF);
     function IsEqualAlignment(SrcXF: TXLSStyleXF): boolean;

     property FontIndex: integer        read FFontIndex         write FFontIndex;
     property NumFormatIndex: integer   read FNumFormatIndex    write FNumFormatIndex;
     property FillIndex: integer        read FFillIndex         write FFillIndex;
     property BorderIndex: integer      read FBorderIndex       write FBorderIndex;
     property ParentStyleIndex: integer read FParentStyleIndex  write FParentStyleIndex;
     property ReadingOrder:byte         read FReadingOrder      write FReadingOrder;
     property ShrinkToFit: boolean      read FShrinkToFit       write FShrinkToFit;
     property IndentLevel: byte         read FIndentLevel       write FIndentLevel;
     property RelativeIndent: integer   read FRelativeIndent    write FRelativeIndent;
     property Orientation: byte         read FOrientation       write FOrientation;
     property WrapText: boolean         read FWrapText          write FWrapText;
     property VerAlign: byte            read FVerAlign          write FVerAlign;
     property HorAlign: byte            read FHorAlign          write FHorAlign;
     property JustifyLastLine: boolean  read FJustifyLastLine   write FJustifyLastLine;
     property Protection: byte          read FProtection        write FProtection;

     property Locked: boolean           read GetLocked          write SetLocked; 
     property Hidden: boolean           read GetHidden          write SetHidden;
     property IsStyleXF: boolean        read GetIsStyleXF       write SetIsStyleXF;
 
     property UsedAttributes: byte      read FUsedAttributes    write FUsedAttributes;

     property ApplyAlignment: boolean   read GetApplyAlignment  write SetApplyAlignment;
     property ApplyFont: boolean        read GetApplyFont       write SetApplyFont;
     property ApplyBorder: boolean      read GetApplyBorder     write SetApplyBorder;
     property ApplyFill: boolean        read GetApplyFill       write SetApplyFill;
     property ApplyNumFormat: boolean   read GetApplyNumFormat  write SetApplyNumFormat;
     property ApplyProtection: boolean  read GetApplyProtection write SetApplyProtection;
  end;

implementation
uses sysutils, wstream;


{TXLSStyleXFFullState}
constructor TXLSStyleXFFullState.Create(xf: TXLSStyleXF; 
                        fnt: TXLSStyleFont;
                        numformat: widestring;
                        brd: TXLSStyleBorder;
                        fill: TXLSStyleFill);
begin
  inherited Create;
  FXF := xf;
  FFont := fnt;
  FNumFormat := numformat;
  FBorder := brd;
  FFill := fill; 
end;

destructor TXLSStyleXFFullState.Destroy; 
begin
  FXF.Free;
  FFont.Free;
  FBorder.Free; 
  FFill.Free;
  inherited Destroy;
end;


{TXLSStyleXF}
constructor TXLSStyleXF.Create;
begin
  inherited Create;
  FVerAlign := 2;
end;

destructor TXLSStyleXF.Destroy; 
begin
  inherited Destroy;
end;

function TXLSStyleXF._GetHashCode: longint;
Var HashCode: longint;
begin
   HashCode := 1;   
   HashCode := 33 * HashCode + FFontIndex;
   HashCode := 33 * HashCode + FNumFormatIndex;
   HashCode := 33 * HashCode + FFillIndex;
   HashCode := 33 * HashCode + FBorderIndex;
   HashCode := 33 * HashCode + FParentStyleIndex;
   HashCode := 33 * HashCode + FReadingOrder;
   HashCode := 33 * HashCode + integer(FShrinkToFit);
   HashCode := 33 * HashCode + FIndentLevel;
   HashCode := 33 * HashCode + FRelativeIndent;
   HashCode := 33 * HashCode + FOrientation;
   HashCode := 33 * HashCode + integer(FWrapText);
   HashCode := 33 * HashCode + FVerAlign;
   HashCode := 33 * HashCode + FHorAlign;
   HashCode := 33 * HashCode + integer(FJustifyLastLine);
   HashCode := 33 * HashCode + FProtection;
   HashCode := 33 * HashCode + integer(FUsedAttributes);
   HashCode := HashCode + HashCode shr 5;
   Result := HashCode;
end;

function TXLSStyleXF.CloneBIFF8(AColorManager: TXLSColorManager; Parent: TXLSStyleXFs): TXLSStyleXF;
var b: TXLSStyleXF;
begin
   b := TXLSStyleXF.Create;
   b.FFontIndex        := Parent.Fonts.SaveIndex[FFontIndex];
   b.FNumFormatIndex   := FNumFormatIndex;
   b.FFillIndex        := Parent.Fills.SaveIndex[FFillIndex];
   b.FBorderIndex      := Parent.Borders.SaveIndex[FBorderIndex]; 
   b.FParentStyleIndex := FParentStyleIndex;
   b.FReadingOrder     := FReadingOrder;
   b.FShrinkToFit      := FShrinkToFit;
   b.FIndentLevel      := FIndentLevel;
   b.FRelativeIndent   := 0;
   b.FOrientation      := FOrientation;
   b.FWrapText         := FWrapText;
   b.FVerAlign         := FVerAlign;
   b.FHorAlign         := FHorAlign;
   b.FJustifyLastLine  := FJustifyLastLine;
   b.FProtection       := FProtection;
   b.FUsedAttributes   := FUsedAttributes;
   Result := b;
end;

function TXLSStyleXF.CloneBIFF5(AColorManager: TXLSColorManager; Parent: TXLSStyleXFs): TXLSStyleXF;
var b: TXLSStyleXF;
begin
   b := TXLSStyleXF.Create;
   b.FFontIndex        := Parent.Fonts.SaveIndex[FFontIndex];
   b.FNumFormatIndex   := FNumFormatIndex;
   b.FFillIndex        := Parent.Fills.SaveIndex[FFillIndex];
   b.FBorderIndex      := Parent.Borders.SaveIndex[FBorderIndex]; 
   b.FParentStyleIndex := FParentStyleIndex;
   b.FReadingOrder     := FReadingOrder;
   b.FShrinkToFit      := FShrinkToFit;
   b.FIndentLevel      := FIndentLevel;
   b.FRelativeIndent   := 0;

   if      (FOrientation = 255)  then b.FOrientation := 1
   else if (FOrientation > 135)  then b.FOrientation := 3 
   else if (FOrientation > 45)   then b.FOrientation := 2 
   else b.FOrientation := 0; 

   b.FWrapText         := FWrapText;
   b.FVerAlign         := FVerAlign;
   b.FHorAlign         := FHorAlign;
   b.FJustifyLastLine  := false;
   b.FProtection       := FProtection;
   b.FUsedAttributes   := FUsedAttributes;
   Result := b;
end;

function TXLSStyleXF.Clone: THashTableKey;
var b: TXLSStyleXF;
begin
   b := TXLSStyleXF.Create;

   b.FFontIndex        := FFontIndex;
   b.FNumFormatIndex   := FNumFormatIndex;
   b.FFillIndex        := FFillIndex;
   b.FBorderIndex      := FBorderIndex;
   b.FParentStyleIndex := FParentStyleIndex;
   b.FReadingOrder     := FReadingOrder;
   b.FShrinkToFit      := FShrinkToFit;
   b.FIndentLevel      := FIndentLevel;
   b.FRelativeIndent   := FRelativeIndent;
   b.FOrientation      := FOrientation;
   b.FWrapText         := FWrapText;
   b.FVerAlign         := FVerAlign;
   b.FHorAlign         := FHorAlign;
   b.FJustifyLastLine  := FJustifyLastLine;
   b.FProtection       := FProtection;
   b.FUsedAttributes   := FUsedAttributes;
   Result := b;
end;

procedure TXLSStyleXF.CopyAlignment(SrcXF: TXLSStyleXF);
begin
   FReadingOrder     := SrcXF.FReadingOrder;
   FShrinkToFit      := SrcXF.FShrinkToFit;
   FIndentLevel      := SrcXF.FIndentLevel;
   FRelativeIndent   := SrcXF.FRelativeIndent;
   FOrientation      := SrcXF.FOrientation;
   FWrapText         := SrcXF.FWrapText;
   FVerAlign         := SrcXF.FVerAlign;
   FHorAlign         := SrcXF.FHorAlign;
   FJustifyLastLine  := SrcXF.FJustifyLastLine;
end;

function TXLSStyleXF.IsEqualAlignment(SrcXF: TXLSStyleXF): boolean;
begin
   Result := 
   (FReadingOrder     = SrcXF.FReadingOrder)    and
   (FShrinkToFit      = SrcXF.FShrinkToFit)     and
   (FIndentLevel      = SrcXF.FIndentLevel)     and
   (FRelativeIndent   = SrcXF.FRelativeIndent)  and
   (FOrientation      = SrcXF.FOrientation)     and
   (FWrapText         = SrcXF.FWrapText)        and
   (FVerAlign         = SrcXF.FVerAlign)        and
   (FHorAlign         = SrcXF.FHorAlign)        and
   (FJustifyLastLine  = SrcXF.FJustifyLastLine); 
end;


function TXLSStyleXF._Equals(obj: THashTableKey): boolean;
var o: TXLSStyleXF;
begin
   if Not(Assigned(obj)) then begin
      Result := false;
   end else if self = obj then begin
      Result := true;
   end else begin
      o := TXLSStyleXF(obj);
     Result := (FFontIndex        = o.FFontIndex);
     if not(Result) then exit;
     Result := (FNumFormatIndex   = o.FNumFormatIndex);
     if not(Result) then exit;
     Result := (FFillIndex        = o.FFillIndex);
     if not(Result) then exit;
     Result := (FBorderIndex      = o.FBorderIndex);
     if not(Result) then exit;
     Result := (FParentStyleIndex = o.FParentStyleIndex);
     if not(Result) then exit;
     Result := (FReadingOrder     = o.FReadingOrder);
     if not(Result) then exit;
     Result := (FShrinkToFit      = o.FShrinkToFit);
     if not(Result) then exit;
     Result := (FIndentLevel      = o.FIndentLevel);
     if not(Result) then exit;
     Result := (FRelativeIndent   = o.FRelativeIndent);
     if not(Result) then exit;
     Result := (FOrientation      = o.FOrientation);
     if not(Result) then exit;
     Result := (FWrapText         = o.FWrapText);
     if not(Result) then exit;
     Result := (FVerAlign         = o.FVerAlign);
     if not(Result) then exit;
     Result := (FHorAlign         = o.FHorAlign);
     if not(Result) then exit;
     Result := (FJustifyLastLine  = o.FJustifyLastLine);
     if not(Result) then exit;
     Result := (FProtection       = o.FProtection);
     if not(Result) then exit;
     Result := (FUsedAttributes   = o.FUsedAttributes);
     if not(Result) then exit;
   end;
end;


function TXLSStyleXF.GetApplyNumFormat: boolean;
begin
  //0 bit
  Result := (FUsedAttributes and $01) = $01;
end;

procedure TXLSStyleXF.SetApplyNumFormat(Value: boolean);
begin
  //0 bit
  if Value then FUsedAttributes := FUsedAttributes or $01
           else FUsedAttributes := FUsedAttributes and not($01); 
end;


function TXLSStyleXF.GetApplyFont: boolean;
begin
  //1 bit
  Result := (FUsedAttributes and $02) = $02;
end;

procedure TXLSStyleXF.SetApplyFont(Value: boolean);
begin
  //1 bit
  if Value then FUsedAttributes := FUsedAttributes or $02
           else FUsedAttributes := FUsedAttributes and not($02); 
end;

function TXLSStyleXF.GetApplyAlignment: boolean;
begin
  //2 bit
  Result := (FUsedAttributes and $04) = $04;
end;

procedure TXLSStyleXF.SetApplyAlignment(Value: boolean);
begin
  //2 bit
  if Value then FUsedAttributes := FUsedAttributes or $04
           else FUsedAttributes := FUsedAttributes and not($04); 
end;


function TXLSStyleXF.GetApplyBorder: boolean;
begin
  //3 bit
  Result := (FUsedAttributes and $08) = $08;
end;

procedure TXLSStyleXF.SetApplyBorder(Value: boolean);
begin
  //3 bit
  if Value then FUsedAttributes := FUsedAttributes or $08
           else FUsedAttributes := FUsedAttributes and not($08); 
end;

function TXLSStyleXF.GetApplyFill: boolean;
begin
  //4 bit
  Result := (FUsedAttributes and $10) = $10;
end;

procedure TXLSStyleXF.SetApplyFill(Value: boolean);
begin
  //4 bit
  if Value then FUsedAttributes := FUsedAttributes or $10
           else FUsedAttributes := FUsedAttributes and not($10); 
end;

function TXLSStyleXF.GetApplyProtection: boolean;
begin
  //5 bit
  Result := (FUsedAttributes and $20) = $20;
end;

procedure TXLSStyleXF.SetApplyProtection(Value: boolean);
begin
  //5 bit
  if Value then FUsedAttributes := FUsedAttributes or $20
           else FUsedAttributes := FUsedAttributes and not($20); 
end;

function TXLSStyleXF.GetLocked: boolean;
begin
   Result := (FProtection and $01) = $01;
end;

function TXLSStyleXF.GetHidden: boolean;
begin
   Result := (FProtection and $02) = $02;
end;

procedure TXLSStyleXF.SetLocked(Value: boolean);
begin
   if Value then FProtection := FProtection or $01
            else FProtection := FProtection and $FE;
end;

procedure TXLSStyleXF.SetHidden(Value: boolean);
begin
   if Value then FProtection := FProtection or $02
            else FProtection := FProtection and $FD;
end;

function TXLSStyleXF.GetIsStyleXF: boolean;
begin
   Result := (FProtection and $04) = $04;
end;

procedure TXLSStyleXF.SetIsStyleXF(value: boolean);
begin
   if value then begin
      FProtection := FProtection or $04;
      FParentStyleIndex := -1; 
   end else begin
      FProtection := FProtection and $FB;
      if FParentStyleIndex = -1 then FParentStyleIndex := 0;
   end;
end;


{TXLSStyleXFs}
constructor TXLSStyleXFs.Create(ColorManager: TXLSColorManager);
var d: TXLSStyleXF;
begin
  inherited Create;
  FColorManager := ColorManager;
  FDefaultCount := 21;
  FStartIndex := 0;

  FStyles := TXLSStyles.Create(self);
  FFormats := TXLSNumFormatList.Create;
  FFonts := TXLSStyleFonts.Create(FColorManager);
  FBorders := TXLSStyleBorders.Create(FColorManager);
  FFills   := TXLSStyleFills.Create(FColorManager);
 
  d := TXLSStyleXF.Create();
  d.Protection := $5;
 
  FDefaultKey := d;
end;

destructor TXLSStyleXFs.Destroy;
begin
  FDefaultKey.Free;
  FDefaultKey := nil;
  FStyles.Free;
  FFormats.Free;
  FFonts.Free;
  FBorders.Free;
  FFills.Free;
  inherited Destroy;
end;

function TXLSStyleXFs.CloneCellXf(f: TXLSStyleXF; Index: integer): TXLSStyleXF; 
begin
   Result := TXLSStyleXF(f.Clone()); 
   if Result.IsStyleXF then begin
      Result.IsStyleXF := false;
      Result.ParentStyleIndex := Index;
   end;
end;

function TXLSStyleXFs.CreateNewXFormat: TXLSStyleXF;
begin
  Result := TXLSStyleXF.Create;
  with Result do begin
     Protection := 1;
     ApplyProtection := false;
     VerAlign := 2;
     ApplyAlignment := false;
     FillIndex := 0;
     ApplyFill := false;
  end;
end;  

procedure TXLSStyleXFs.CreateDefaultFills;
var
    fill: TXLSStyleFill;
begin
  //fills
  FFills.SetKeyItem(0, FFills.DefaultKey.Clone());
  fill := TXLSStyleFill(FFills.DefaultKey.Clone());
  fill.PatternType := 17;
  FFills.SetKeyItem(1, fill);
end;

procedure TXLSStyleXFs.CreateDefault;
var f: TXLSStyleXF;
    i: integer;
begin
  //add default styles
  FStyles.AddBuiltinStyle(3, $13, -1);
  FStyles.AddBuiltinStyle(4, $10, -1);
  FStyles.AddBuiltinStyle(6, $14, -1);
  FStyles.AddBuiltinStyle(7, $11, -1);
  FStyles.AddBuiltinStyle(5, $12, -1);
  FStyles.AddBuiltinStyle(0, $00, -1);

  //add default formats
  FFormats.Value[5] := '"$"#,##0_);("$"#,##0)';
  FFormats.Value[6] := '"$"#,##0_);[Red]("$"#,##0)';
  FFormats.Value[7] := '"$"#,##0.00_);("$"#,##0.00)';
  FFormats.Value[8] := '"$"#,##0.00_);[Red]("$"#,##0.00)';

  {...}

  //add default fonts
  FFonts.SetKeyItem(0, FFonts.DefaultKey.Clone());
  FFonts.SetKeyItem(1, FFonts.DefaultKey.Clone());
  FFonts.SetKeyItem(2, FFonts.DefaultKey.Clone());
  FFonts.SetKeyItem(3, FFonts.DefaultKey.Clone());
  FFonts.SetKeyIndex(FFonts.DefaultKey, 0);

  //borders
  FBorders.SetKeyItem(0, FBorders.DefaultKey.Clone());

  //fills
  CreateDefaultFills;

  //add default xfs

  f := CreateNewXFormat;
  f.ParentStyleIndex := -1;
  f.isStyleXF := true;
  f.UsedAttributes := $00;

  SetKeyItem(0, f.Clone());

  f.fontIndex := 1;
  f.UsedAttributes := $F4;

  SetKeyItem(1, f.Clone());
  SetKeyItem(2, f.Clone());

  f.FontIndex := 2;
  SetKeyItem(3, f.Clone());
  SetKeyItem(4, f.Clone());

  f.FontIndex := 0;
  for i := 5 to 14 do SetKeyItem(i, f.Clone());

  SetKeyItem(15, CreateNewXFormat);

  f.Free;
  f := CreateNewXFormat;
  f.NumFormatIndex := $2C;
  f.ParentStyleIndex := -1; 
  f.isStyleXF := true;
  f.fontIndex      := 1;  
  f.UsedAttributes := $3E;
  SetKeyItem(16, f.Clone());
  f.NumFormatIndex := $2A; 
  SetKeyItem(17, f.Clone());
  f.NumFormatIndex := $09; 
  SetKeyItem(18, f.Clone());
  f.NumFormatIndex := $2B; 
  SetKeyItem(19, f.Clone());
  f.NumFormatIndex := $29; 
  SetKeyItem(20, f.Clone());
  f.Free;
end;

procedure TXLSStyleXFs.CreateDefault2007;
var f: TXLSStyleXF;
    fnt: TXLSStyleFont;
    i: integer;
begin
  //add default styles
  FStyles.AddBuiltinStyle(3, $13, -1);
  FStyles.AddBuiltinStyle(4, $10, -1);
  FStyles.AddBuiltinStyle(6, $14, -1);
  FStyles.AddBuiltinStyle(7, $11, -1);
  FStyles.AddBuiltinStyle(5, $12, -1);
  FStyles.AddBuiltinStyle(0, $00, -1);

  //add default formats
  FFormats.Value[5] := '"$"#,##0_);("$"#,##0)';
  FFormats.Value[6] := '"$"#,##0_);[Red]("$"#,##0)';
  FFormats.Value[7] := '"$"#,##0.00_);("$"#,##0.00)';
  FFormats.Value[8] := '"$"#,##0.00_);[Red]("$"#,##0.00)';
  {...}

  //add default fonts
  fnt := TXLSStyleFont(FFonts.DefaultKey);
  fnt.Name := 'Calibri'; 
  fnt.Size := 11;

  FFonts.SetKeyItem(0, FFonts.DefaultKey.Clone());
  FFonts.SetKeyItem(1, FFonts.DefaultKey.Clone());
  FFonts.SetKeyItem(2, FFonts.DefaultKey.Clone());
  FFonts.SetKeyItem(3, FFonts.DefaultKey.Clone());
  FFonts.SetKeyIndex(FFonts.DefaultKey, 0);

  //borders
  FBorders.SetKeyItem(0, FBorders.DefaultKey.Clone());

  //fills
  CreateDefaultFills;

  //add default xfs

  f := CreateNewXFormat;
  f.ParentStyleIndex := -1;
  f.isStyleXF := true;
  f.UsedAttributes := $00;

  SetKeyItem(0, f.Clone());

  f.fontIndex := 1;
  f.UsedAttributes := $F4;

  SetKeyItem(1, f.Clone());
  SetKeyItem(2, f.Clone());

  f.FontIndex := 2;
  SetKeyItem(3, f.Clone());
  SetKeyItem(4, f.Clone());

  f.FontIndex := 0;
  for i := 5 to 14 do SetKeyItem(i, f.Clone());

  SetKeyItem(15, CreateNewXFormat);

  f.Free;
  f := CreateNewXFormat;
  f.NumFormatIndex := $2C;
  f.ParentStyleIndex := -1; 
  f.isStyleXF := true;
  f.fontIndex      := 1;  
  f.UsedAttributes := $3E;
  SetKeyItem(16, f.Clone());
  f.NumFormatIndex := $2A; 
  SetKeyItem(17, f.Clone());
  f.NumFormatIndex := $09; 
  SetKeyItem(18, f.Clone());
  f.NumFormatIndex := $2B; 
  SetKeyItem(19, f.Clone());
  f.NumFormatIndex := $29; 
  SetKeyItem(20, f.Clone());
  f.Free;
end;


function TXLSStyleXFs.GetFontIndex(Index: integer): integer;
Var f: TXLSStyleXF;
    StyleIndex: integer;
begin
  if Index = 0 then Index := 15;
  f := XF[Index];
  Result := f.FontIndex;
  if not(f.ApplyFont) then begin
     StyleIndex := f.ParentStyleIndex;

     if StyleIndex < 0 then
         f := XF[0]
     else 
         f := XF[StyleIndex];

     if not(f.ApplyFont) then begin
         Result := f.FontIndex;
     end;
  end;
end;


function TXLSStyleXFs.SetFontIndex(Index: integer; Value: integer; ReplaceIndex: boolean): integer;
Var f: TXLSStyleXF;
begin
  if Index = 0 then Index := 15;
  f := XF[Index];
  if f.FontIndex <> Value then begin
     f := CloneCellXf(f, Index);

     f.FontIndex := Value;
     f.ApplyFont := true;

     Result := SetXF(Index, f);
  end else begin
     Result := Index
  end;  
end;

function TXLSStyleXFs.GetNumFormatIndex(Index: integer): integer;
Var f: TXLSStyleXF;
    StyleIndex: integer;
begin
  if Index = 0 then Index := 15;
  f := XF[Index];
  Result := f.NumFormatIndex;
  if not(f.ApplyNumFormat) and  
     (Result <= 0) {excel bug} then begin
     StyleIndex := f.ParentStyleIndex;

     if StyleIndex < 0 then
         f := XF[0]
     else 
         f := XF[StyleIndex];

     if not(f.ApplyNumFormat) then begin
         Result := f.NumFormatIndex;
     end;
  end;
end;


function TXLSStyleXFs.SetNumFormatIndex(Index: integer; Value: integer; ReplaceIndex: boolean): integer;
Var f: TXLSStyleXF;
begin
  if Index = 0 then Index := 15;
  f := XF[Index];
  if f.NumFormatIndex <> Value then begin
     f := CloneCellXf(f, Index);
     f.NumFormatIndex := Value;
     f.ApplyNumFormat := true;
     Result := SetXF(Index, f);
  end else begin
     Result := Index
  end;  
end;

function TXLSStyleXFs.GetBorderIndex(Index: integer): integer;
Var f: TXLSStyleXF;
    StyleIndex: integer;
begin
  if Index = 0 then Index := 15;
  f := XF[Index];
  Result := f.BorderIndex;
  if not(f.ApplyBorder) then begin
     StyleIndex := f.ParentStyleIndex;

     if StyleIndex < 0 then
         f := XF[0]
     else 
         f := XF[StyleIndex];

     if not(f.ApplyBorder) then begin
         Result := f.BorderIndex;
     end;
  end;
end;

function TXLSStyleXFs.SetBorderIndex(Index: integer; Value: integer; ReplaceIndex: boolean): integer;
Var f: TXLSStyleXF;
begin
  if Index = 0 then Index := 15;
  f := XF[Index];
  if f.BorderIndex <> Value then begin
     f := CloneCellXf(f, Index);
     f.BorderIndex := Value;
     f.ApplyBorder := true;
     Result := SetXF(Index, f);
  end else begin
     Result := Index
  end;  
end;

function TXLSStyleXFs.GetFillIndex(Index: integer): integer;
Var f: TXLSStyleXF;
    StyleIndex: integer;
begin
  if Index = 0 then Index := 15;
  f := XF[Index];
  Result := f.FillIndex;
  if not(f.ApplyFill) then begin
     StyleIndex := f.ParentStyleIndex;

     if StyleIndex < 0 then
         f := XF[0]
     else 
         f := XF[StyleIndex];

     if not(f.ApplyFill) then begin
         Result := f.FillIndex;
     end;
  end;
end;

function TXLSStyleXFs.SetFillIndex(Index: integer; Value: integer; ReplaceIndex: boolean): integer;
Var f: TXLSStyleXF;
begin
  if Index = 0 then Index := 15;
  f := XF[Index];
  if f.FillIndex <> Value then begin
     f := CloneCellXf(f, Index);
     f.FillIndex := Value;
     f.ApplyFill := true;
     Result := SetXF(Index, f);
  end else begin
     Result := Index
  end;  
end;


function TXLSStyleXFs.GetProtection(Index: integer): byte;
Var f: TXLSStyleXF;
    StyleIndex: integer;
begin
  if Index = 0 then Index := 15;
  f := XF[Index];
  Result := f.Protection;
  if not(f.ApplyProtection) then begin
     StyleIndex := f.ParentStyleIndex;

     if StyleIndex < 0 then
         f := XF[0]
     else 
         f := XF[StyleIndex];

     if not(f.ApplyProtection) then begin
         Result := f.Protection;
     end;
  end;
end;


function TXLSStyleXFs.SetProtection(Index: integer;
  const Value: byte; ReplaceIndex: boolean): integer;
Var f: TXLSStyleXF;
begin
  if Index = 0 then Index := 15;
  f := XF[Index];
  if f.Protection <> Value then begin
     f := CloneCellXf(f, Index);
     f.Protection := Value;
     f.ApplyProtection := true;
     if f.isStyleXF then f.isStyleXF := false;
     Result := SetXF(Index, f);
  end else begin
     Result := Index
  end;  
end;

function TXLSStyleXFs.IsDateFormat(Index: integer): boolean;
begin
  Result := FFormats.IsDateFormat(GetNumFormatIndex(Index));
end;

function TXLSStyleXFs.GetSaveIndex(Index: integer): integer; 
begin
  Result := inherited GetSaveIndex(Index);
end;

procedure TXLSStyleXFs.SetDefaultCount(Value: integer);
begin
  FDefaultCount := Value;
end;

function TXLSStyleXFs.GetFullFormat(Index: integer): TXLSStyleXFFullState;
Var f: TXLSStyleXF;
    fnt: TXLSStyleFont;
    numformat: widestring;
    brd: TXLSStyleBorder;
    fill: TXLSStyleFill;
begin
   f := TXLSStyleXF(XF[Index].Clone());

   if f.ApplyFont then begin
      fnt := TXLSStyleFont(Fonts.Font[f.FontIndex].Clone());
   end else begin
      fnt := TXLSStyleFont(Fonts.Font[GetFontIndex(Index)].Clone());
   end;

   if f.ApplyNumFormat then begin
      numformat := FFormats.Value[f.NumFormatIndex];
   end else begin
      numformat := GetNumFormat(Index);
   end;

   if f.ApplyBorder then begin
      brd := TXLSStyleBorder(Borders.GetBorder(f.BorderIndex).Clone());
   end else begin
      brd := TXLSStyleBorder(Borders.GetBorder(GetBorderIndex(Index)).Clone());
   end;

   if f.ApplyFill then begin
      fill := TXLSStyleFill(Fills.GetFill(f.FillIndex).Clone());
   end else begin
      fill := TXLSStyleFill(Fills.GetFill(GetFillIndex(Index)).Clone());
   end;

   if not(f.ApplyProtection) then begin
      f.Protection := GetProtection(Index);
   end;

   if not(f.ApplyAlignment) then begin
      f.CopyAlignment(XF[GetAlignmentIndex(Index)]);
   end;

   Result := TXLSStyleXFFullState.Create(f, fnt, numformat, brd, fill);
end;

function TXLSStyleXFs.SetFullFormat(Value: TXLSStyleXFFullState): integer;
Var f: TXLSStyleXF;
    fnt: TXLSStyleFont;
    brd: TXLSStyleBorder;
    fill: TXLSStyleFill;
begin
   f := TXLSStyleXF(Value.FXF.Clone());
   f.ParentStyleIndex  := 0;
   //font
   if not(f.ApplyFont) and FFonts.Font[GetFontIndex(f.ParentStyleIndex)]._Equals(Value.FFont) then begin
      f.FontIndex := 0;  
   end else begin
      fnt := TXLSStyleFont(Value.FFont.Clone());
      f.FontIndex := Fonts.SetFont(-1, fnt);
      f.ApplyFont := true;
   end;

   //numformat
   if not(f.ApplyNumFormat) and (GetNumFormat(f.ParentStyleIndex) = Value.FNumFormat) then begin
      f.NumFormatIndex := 0;
   end else begin
      f.NumFormatIndex := FFormats.AddValue(Value.FNumFormat);
      f.ApplyNumFormat := true;
   end;

   //border
   if not(f.ApplyBorder) and Borders.Border[GetBorderIndex(f.ParentStyleIndex)]._Equals(Value.FBorder) then begin
      f.BorderIndex := 0;  
   end else begin
      brd := TXLSStyleBorder(Value.FBorder.Clone());
      f.BorderIndex := Borders.SetBorder(-1, brd);
      f.ApplyBorder := true;
   end;

   //fill
   if not(f.ApplyFill) and Fills.Fill[GetFillIndex(f.ParentStyleIndex)]._Equals(Value.FFill) then begin
      f.FillIndex := 0;  
   end else begin
      fill := TXLSStyleFill(Value.FFill.Clone());
      f.FillIndex := Fills.SetFill(-1, fill);
      f.ApplyFill := true;
   end;

   //protect
   if not(f.ApplyProtection) and (GetProtection(f.ParentStyleIndex) = f.Protection) then begin
   end else begin
      f.ApplyProtection := true; 
   end; 

   if not(f.ApplyAlignment) and f.IsEqualAlignment(XF[GetAlignmentIndex(f.ParentStyleIndex)]) then begin
   end else begin
      f.ApplyAlignment := true;
   end;   

   Value.Free;
   Result := SetXF(-1, f);
end;

function TXLSStyleXFs.TransformKey(Key: THashtableKey): THashtableKey;
var b: TXLSStyleXF;
begin
  if TransformMode = $500 then begin
     //biff5
     if Assigned(Key) then begin
        b := TXLSStyleXF(Key).CloneBiff5(FColorManager, self);
        Result := b;
     end else begin
        Result := nil;
     end; 
  end else if TransformMode = $600 then begin
     //biff8
     if Assigned(Key) then begin
        b := TXLSStyleXF(Key).CloneBiff8(FColorManager, self);
        Result := b;
     end else begin
        Result := nil;
     end; 
  end else begin
     Result := Key.Clone;
  end; 
end;

function TXLSStyleXFs.GetXF(Index: integer): TXLSStyleXF;
begin
  Result := TXLSStyleXF(Key[Index]);
end;

function TXLSStyleXFs.SetXF(Index: integer; Value: TXLSStyleXF): integer;
begin
  Result := SetKey(Index, Value, true);
end;

function TXLSStyleXFs.GetNumFormat(Index: integer): widestring;
begin
  Result := FFormats.Value[GetNumFormatIndex(Index)];
end;

function TXLSStyleXFs.SetNumFormat(const Index: integer; const Value: OleVariant; const ReplaceIndex: boolean): integer;
Var NumFormatIndex: integer;
begin
  NumFormatIndex := FFormats.AddValue(Value);
  Result := SetNumFormatIndex(Index, NumFormatIndex, ReplaceIndex);
end;

function TXLSStyleXFs.GetFontBold(Index: integer): boolean;
begin
  Result := FFonts.GetBold(GetFontIndex(Index));
end;

function TXLSStyleXFs.GetFontCharSet(Index: integer): byte;
begin
  Result := FFonts.GetCharSet(GetFontIndex(Index));
end;

function TXLSStyleXFs.GetFontColorIndex(Index: integer): LongWord;
begin
  Result := FFonts.GetColorIndex(GetFontIndex(Index));
end;

function TXLSStyleXFs.GetFontColor(Index: integer): LongWord;
begin
  Result := FFonts.GetColor(GetFontIndex(Index));
end;

function TXLSStyleXFs.GetFontThemeColor(Index: integer): LongWord;
begin
  Result := FFonts.GetThemeColor(GetFontIndex(Index));
end;

function TXLSStyleXFs.GetFontTintAndShade(Index: integer): double;
begin
  Result := FFonts.GetTintAndShade(GetFontIndex(Index));
end;

function TXLSStyleXFs.GetFontFamily(Index: integer): byte;
begin
  Result := FFonts.GetFamily(GetFontIndex(Index));
end;

function TXLSStyleXFs.GetFontItalic(Index: integer): boolean;
begin
  Result := FFonts.GetItalic(GetFontIndex(Index));
end;

function TXLSStyleXFs.GetFontName(Index: integer): widestring;
begin
  Result := FFonts.GetName(GetFontIndex(Index));
end;

function TXLSStyleXFs.GetFontOutLineFont(Index: integer): boolean;
begin
  Result := FFonts.GetOutLineFont(GetFontIndex(Index));
end;

function TXLSStyleXFs.GetFontShadow(Index: integer): boolean;
begin
  Result := FFonts.GetShadow(GetFontIndex(Index));
end;

function TXLSStyleXFs.GetFontSize(Index: integer): Single;
begin
  Result := FFonts.GetSize(GetFontIndex(Index));
end;

function TXLSStyleXFs.GetFontStrikethrough(Index: integer): boolean;
begin
  Result := FFonts.GetStrikethrough(GetFontIndex(Index));
end;

function TXLSStyleXFs.GetFontSubScript(Index: integer): boolean;
begin
  Result := FFonts.GetSubScript(GetFontIndex(Index));
end;

function TXLSStyleXFs.GetFontSuperScript(Index: integer): boolean;
begin
  Result := FFonts.GetSuperScript(GetFontIndex(Index));
end;

function TXLSStyleXFs.GetFontUnderLine(Index: integer): byte;
begin
  Result := FFonts.GetUnderLine(GetFontIndex(Index));
end;

function TXLSStyleXFs.SetFontName(const XFIndex: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFontIndex(XFIndex, FFonts.SetName(GetFontIndex(XFIndex), Value), ReplaceIndex);
end;

function TXLSStyleXFs.SetFontBold(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFontIndex(Index, FFonts.SetBold(GetFontIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.SetFontCharSet(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFontIndex(Index, FFonts.SetCharSet(GetFontIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.SetFontColorIndex(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFontIndex(Index, FFonts.SetColorIndex(GetFontIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.SetFontColor(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFontIndex(Index, FFonts.SetColor(GetFontIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.SetFontThemeColor(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFontIndex(Index, FFonts.SetThemeColor(GetFontIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.SetFontTintAndShade(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFontIndex(Index, FFonts.SetTintAndShade(GetFontIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.SetFontFamily(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFontIndex(Index, FFonts.SetFamily(GetFontIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.SetFontItalic(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFontIndex(Index, FFonts.SetItalic(GetFontIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.SetFontOutLineFont(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFontIndex(Index, FFonts.SetOutLineFont(GetFontIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.SetFontShadow(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFontIndex(Index, FFonts.SetShadow(GetFontIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.SetFontSize(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFontIndex(Index, FFonts.SetSize(GetFontIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.SetFontStrikethrough(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFontIndex(Index, FFonts.SetStrikethrough(GetFontIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.SetFontSubScript(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFontIndex(Index, FFonts.SetSubScript(GetFontIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.SetFontSuperScript(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFontIndex(Index, FFonts.SetSuperScript(GetFontIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.SetFontUnderLine(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFontIndex(Index, FFonts.SetUnderLine(GetFontIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.GetLocked(Index: integer): boolean;
begin
  Result := (GetProtection(Index) and 1) = 1
end;

function TXLSStyleXFs.SetLocked(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
Var Locked: byte;
begin
  if Value then Locked := 1 else Locked := 0;
  Result := SetProtection(Index, ((GetProtection(Index) and $FFFE) or Locked), ReplaceIndex)
end;

function TXLSStyleXFs.GetHidden(Index: integer): boolean;
begin
  Result := (GetProtection(Index) and 2) = 2
end;

function TXLSStyleXFs.SetHidden(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
Var Hidden: byte;
begin
  if Value then Hidden := 2 else Hidden := 0;
  Result := SetProtection(Index, ((GetProtection(Index) and $FFFD) or Hidden), ReplaceIndex)
end;

function TXLSStyleXFs.GetAlignmentIndex(Index: integer): integer;
Var f: TXLSStyleXF;
    StyleIndex: integer;
begin
  if Index = 0 then Index := 15;
  f := XF[Index];
  Result := Index;
  if not(f.ApplyAlignment) then begin
     StyleIndex := f.ParentStyleIndex;

     if StyleIndex < 0 then
         Index := 0
     else 
         Index := StyleIndex;


     if not(XF[Index].ApplyAlignment) then 
        Result := Index; 
  end;
end;

function TXLSStyleXFs.GetHorAlign(const Index: integer): byte;
begin
  Result := XF[GetAlignmentIndex(Index)].HorAlign;
end;

function TXLSStyleXFs.SetHorAlign(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
var AlignIndex: integer;
    f: TXLSStyleXF;
    i: integer;
begin          
  i := Index;
  if i = 0 then i := 15;
  AlignIndex := GetAlignmentIndex(Index);
  f := CloneCellXf(XF[i], i);

  if AlignIndex <> i then begin
     f.CopyAlignment(XF[AlignIndex]);
  end;

  f.HorAlign := (Value and $07);
  f.ApplyAlignment := true;

  if (f.HorAlign <> 1{left}) and 
     (f.HorAlign <> 3{right}) and 
     (f.IndentLevel > 0) then begin
     //if indentlevel > 0 set indentlevel to 0;
     f.IndentLevel := 0;
  end;

  Result := SetXF(i, f);
end;


function TXLSStyleXFs.GetVerAlign(const Index: integer): byte;
begin
  Result := XF[GetAlignmentIndex(Index)].VerAlign;
end;

function TXLSStyleXFs.SetVerAlign(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
var AlignIndex: integer;
    f: TXLSStyleXF;
    i: integer;
begin          
  i := Index;
  if i = 0 then i := 15;
  AlignIndex := GetAlignmentIndex(Index);
  f := CloneCellXf(XF[i], i);

  if AlignIndex <> i then begin
     f.CopyAlignment(XF[AlignIndex]);
  end;

  f.VerAlign := (Value and $07);
  f.ApplyAlignment := true;

  Result := SetXF(i, f);
end;

function TXLSStyleXFs.GetWrap(const Index: integer): boolean;
begin
  Result := XF[GetAlignmentIndex(Index)].WrapText;
end;

function TXLSStyleXFs.SetWrap(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
var AlignIndex: integer;
    f: TXLSStyleXF;
    i: integer;
begin          
  i := Index;
  if i = 0 then i := 15;
  AlignIndex := GetAlignmentIndex(Index);
  f := CloneCellXf(XF[i], i);

  if AlignIndex <> i then begin
     f.CopyAlignment(XF[AlignIndex]);
  end;

  f.WrapText := Value;
  f.ApplyAlignment := true;

  Result := SetXF(i, f);
end;


function TXLSStyleXFs.GetOrientation(const Index: integer): byte;
begin
  Result := XF[GetAlignmentIndex(Index)].Orientation;
end;

function TXLSStyleXFs.SetOrientation(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
var AlignIndex: integer;
    f: TXLSStyleXF;
    i: integer;
begin          
  i := Index;
  if i = 0 then i := 15;
  AlignIndex := GetAlignmentIndex(Index);
  f := CloneCellXf(XF[i], i);

  if AlignIndex <> i then begin
     f.CopyAlignment(XF[AlignIndex]);
  end;

  f.Orientation := Value;
  f.ApplyAlignment := true;

  Result := SetXF(i, f);
end;

function TXLSStyleXFs.GetIndentLevel(const Index: integer): byte;
begin
  Result := XF[GetAlignmentIndex(Index)].IndentLevel;
end;

function TXLSStyleXFs.SetIndentLevel(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
var AlignIndex: integer;
    f: TXLSStyleXF;
    i: integer;
begin          
  i := Index;
  if i = 0 then i := 15;
  AlignIndex := GetAlignmentIndex(Index);
  f := CloneCellXf(XF[i], i);

  if AlignIndex <> i then begin
     f.CopyAlignment(XF[AlignIndex]);
  end;

  f.IndentLevel := Value;
  f.ApplyAlignment := true;

  if Value > 0 then begin
     if (f.HorAlign <> 1) and (f.HorAlign <> 3) then begin
        //if horalign is not left or right set horalign to left
        f.HorAlign := 1;
     end; 
  end;

  Result := SetXF(i, f);
end;

function TXLSStyleXFs.GetShrinkToFit(const Index: integer): boolean;
begin
  Result := XF[GetAlignmentIndex(Index)].ShrinkToFit;
end;

function TXLSStyleXFs.GetReadingOrder(const Index: integer): integer;
begin
  Result := XF[GetAlignmentIndex(Index)].ReadingOrder;
end;


function TXLSStyleXFs.SetShrinkToFit(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
var AlignIndex: integer;
    f: TXLSStyleXF;
    i: integer;
begin          
  i := Index;
  if i = 0 then i := 15;
  AlignIndex := GetAlignmentIndex(Index);
  f := CloneCellXf(XF[i], i);

  if AlignIndex <> i then begin
     f.CopyAlignment(XF[AlignIndex]);
  end;

  f.ShrinkToFit := Value;
  f.ApplyAlignment := true;

  Result := SetXF(i, f);
end;


function TXLSStyleXFs.SetReadingOrder(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
var AlignIndex: integer;
    f: TXLSStyleXF;
    i: integer;
begin          
  i := Index;
  if i = 0 then i := 15;
  AlignIndex := GetAlignmentIndex(Index);
  f := CloneCellXf(XF[i], i);

  if AlignIndex <> i then begin
     f.CopyAlignment(XF[AlignIndex]);
  end;

  f.ReadingOrder := Value and $03;
  f.ApplyAlignment := true;

  Result := SetXF(i, f);
end;

procedure TXLSStyleXFs.CopyFormat(SrcIndex, DstIndex: integer);
begin
   SetKey(DstIndex, XF[SrcIndex].Clone, true);  
   DecReferredCount(srcindex);
end;

function TXLSStyleXFs.GetBorderStyle(const Index: integer;
  BorderMask: byte): byte;
begin
  if ((BorderMask and 1) = 1) then  //left
     Result := FBorders.GetLeftStyle(GetBorderIndex(Index))
  else if ((BorderMask and 2) = 2) then  //right
     Result := FBorders.GetRightStyle(GetBorderIndex(Index))
  else if ((BorderMask and 4) = 4) then  //top
     Result := FBorders.GetTopStyle(GetBorderIndex(Index))
  else if ((BorderMask and 8) = 8) then  //bottom
     Result := FBorders.GetBottomStyle(GetBorderIndex(Index))
  else if ((BorderMask and 16) = 16) then //diagonal down
     Result := FBorders.GetDiagonalDownStyle(GetBorderIndex(Index))
  else if ((BorderMask and 32) = 32) then //diagonal up
     Result := FBorders.GetDiagonalUpStyle(GetBorderIndex(Index))
  else 
     Result := 0;
end;

function TXLSStyleXFs.GetLineStyleFromBorderStyle(
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

function TXLSStyleXFs.GetWeightFromBorderStyle(
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

function TXLSStyleXFs.GetBorderLineStyle(const Index: integer;
  BorderMask: byte): LongWord;
begin
  if ((BorderMask and 1) = 1) then  //left
     Result := FBorders.GetLeftLineStyle(GetBorderIndex(Index))
  else if ((BorderMask and 2) = 2) then  //right
     Result := FBorders.GetRightLineStyle(GetBorderIndex(Index))
  else if ((BorderMask and 4) = 4) then  //top
     Result := FBorders.GetTopLineStyle(GetBorderIndex(Index))
  else if ((BorderMask and 8) = 8) then  //bottom
     Result := FBorders.GetBottomLineStyle(GetBorderIndex(Index))
  else if ((BorderMask and 16) = 16) then //diagonal down
     Result := FBorders.GetDiagonalDownLineStyle(GetBorderIndex(Index))
  else if ((BorderMask and 32) = 32) then //diagonal up
     Result := FBorders.GetDiagonalUpLineStyle(GetBorderIndex(Index))
  else 
     Result := 0;
end;

function TXLSStyleXFs.SetBorderLineStyle(const Index: integer;
  BorderMask: byte; const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := Index;
  if (BorderMask and 63) > 0 then begin
    if (BorderMask and 1) = 1 then begin   //left
       Result := SetBorderIndex(Result, FBorders.SetLeftLineStyle(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 2) = 2 then begin  //right
       Result := SetBorderIndex(Result, FBorders.SetRightLineStyle(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 4) = 4 then begin  //top
       Result := SetBorderIndex(Result, FBorders.SetTopLineStyle(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 8) = 8 then begin   //bottom
       Result := SetBorderIndex(Result, FBorders.SetBottomLineStyle(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 16) = 16 then begin   //diagonal down
       Result := SetBorderIndex(Result, FBorders.SetDiagonalDownLineStyle(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 32) = 32 then begin   //diagonal up
       Result := SetBorderIndex(Result, FBorders.SetDiagonalUpLineStyle(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
  end;
end;

function TXLSStyleXFs.GetBorderColorIndex(const Index: integer;
  BorderMask: byte): LongWord;
begin
  if ((BorderMask and 1) = 1) then  //left
     Result := FBorders.GetLeftColorIndex(GetBorderIndex(Index))
  else if ((BorderMask and 2) = 2) then  //right
     Result := FBorders.GetRightColorIndex(GetBorderIndex(Index))
  else if ((BorderMask and 4) = 4) then  //top
     Result := FBorders.GetTopColorIndex(GetBorderIndex(Index))
  else if ((BorderMask and 8) = 8) then  //bottom
     Result := FBorders.GetBottomColorIndex(GetBorderIndex(Index))
  else if ((BorderMask and 16) = 16) then  //diagonal down
     Result := FBorders.GetDiagonalDownColorIndex(GetBorderIndex(Index))
  else if ((BorderMask and 32) = 32) then  //diagonal up
     Result := FBorders.GetDiagonalUpColorIndex(GetBorderIndex(Index))
  else 
     Result := xlColorIndexNone;
end;

function TXLSStyleXFs.SetBorderColorIndex(const Index: integer;
  BorderMask: byte; const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := Index;
  if (BorderMask and 63) > 0 then begin
    if (BorderMask and 1) = 1 then begin   //left
       Result := SetBorderIndex(Result, FBorders.SetLeftColorIndex(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 2) = 2 then begin  //right
       Result := SetBorderIndex(Result, FBorders.SetRightColorIndex(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 4) = 4 then begin  //top
       Result := SetBorderIndex(Result, FBorders.SetTopColorIndex(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 8) = 8 then begin   //bottom
       Result := SetBorderIndex(Result, FBorders.SetBottomColorIndex(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 16) = 16 then begin   //diagonal down
       Result := SetBorderIndex(Result, FBorders.SetDiagonalDownColorIndex(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 32) = 32 then begin   //diagonal up
       Result := SetBorderIndex(Result, FBorders.SetDiagonalUpColorIndex(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
  end;
end;

function TXLSStyleXFs.GetBorderColor(const Index: integer;
  BorderMask: byte): LongWord;
begin
  if ((BorderMask and 1) = 1) then  //left
     Result := FBorders.GetLeftColor(GetBorderIndex(Index))
  else if ((BorderMask and 2) = 2) then  //right
     Result := FBorders.GetRightColor(GetBorderIndex(Index))
  else if ((BorderMask and 4) = 4) then  //top
     Result := FBorders.GetTopColor(GetBorderIndex(Index))
  else if ((BorderMask and 8) = 8) then  //bottom
     Result := FBorders.GetBottomColor(GetBorderIndex(Index))
  else if ((BorderMask and 16) = 16) then  //diagonal down
     Result := FBorders.GetDiagonalDownColor(GetBorderIndex(Index))
  else if ((BorderMask and 32) = 32) then  //diagonal up
     Result := FBorders.GetDiagonalUpColor(GetBorderIndex(Index))
  else 
     Result := 0;
end;

function TXLSStyleXFs.SetBorderColor(const Index: integer;
  BorderMask: byte; const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := Index;
  if (BorderMask and 63) > 0 then begin
    if (BorderMask and 1) = 1 then begin   //left
       Result := SetBorderIndex(Result, FBorders.SetLeftColor(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 2) = 2 then begin  //right
       Result := SetBorderIndex(Result, FBorders.SetRightColor(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 4) = 4 then begin  //top
       Result := SetBorderIndex(Result, FBorders.SetTopColor(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 8) = 8 then begin   //bottom
       Result := SetBorderIndex(Result, FBorders.SetBottomColor(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 16) = 16 then begin   //diagonal down
       Result := SetBorderIndex(Result, FBorders.SetDiagonalDownColor(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 32) = 32 then begin   //diagonal up
       Result := SetBorderIndex(Result, FBorders.SetDiagonalUpColor(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
  end;
end;

function TXLSStyleXFs.GetBorderThemeColor(const Index: integer;
  BorderMask: byte): LongWord;
begin
  if ((BorderMask and 1) = 1) then  //left
     Result := FBorders.GetLeftThemeColor(GetBorderIndex(Index))
  else if ((BorderMask and 2) = 2) then  //right
     Result := FBorders.GetRightThemeColor(GetBorderIndex(Index))
  else if ((BorderMask and 4) = 4) then  //top
     Result := FBorders.GetTopThemeColor(GetBorderIndex(Index))
  else if ((BorderMask and 8) = 8) then  //bottom
     Result := FBorders.GetBottomThemeColor(GetBorderIndex(Index))
  else if ((BorderMask and 16) = 16) then  //diagonal down
     Result := FBorders.GetDiagonalDownThemeColor(GetBorderIndex(Index))
  else if ((BorderMask and 32) = 32) then  //diagonal up
     Result := FBorders.GetDiagonalUpThemeColor(GetBorderIndex(Index))
  else 
     Result := 0;
end;

function TXLSStyleXFs.SetBorderThemeColor(const Index: integer;
  BorderMask: byte; const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := Index;
  if (BorderMask and 63) > 0 then begin
    if (BorderMask and 1) = 1 then begin   //left
       Result := SetBorderIndex(Result, FBorders.SetLeftThemeColor(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 2) = 2 then begin  //right
       Result := SetBorderIndex(Result, FBorders.SetRightThemeColor(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 4) = 4 then begin  //top
       Result := SetBorderIndex(Result, FBorders.SetTopThemeColor(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 8) = 8 then begin   //bottom
       Result := SetBorderIndex(Result, FBorders.SetBottomThemeColor(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 16) = 16 then begin   //diagonal down
       Result := SetBorderIndex(Result, FBorders.SetDiagonalDownThemeColor(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 32) = 32 then begin   //diagonal up
       Result := SetBorderIndex(Result, FBorders.SetDiagonalUpThemeColor(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
  end;
end;

function TXLSStyleXFs.GetBorderTintAndShade(const Index: integer;
  BorderMask: byte): double;
begin
  if ((BorderMask and 1) = 1) then  //left
     Result := FBorders.GetLeftTintAndShade(GetBorderIndex(Index))
  else if ((BorderMask and 2) = 2) then  //right
     Result := FBorders.GetRightTintAndShade(GetBorderIndex(Index))
  else if ((BorderMask and 4) = 4) then  //top
     Result := FBorders.GetTopTintAndShade(GetBorderIndex(Index))
  else if ((BorderMask and 8) = 8) then  //bottom
     Result := FBorders.GetBottomTintAndShade(GetBorderIndex(Index))
  else if ((BorderMask and 16) = 16) then  //diagonal down
     Result := FBorders.GetDiagonalDownTintAndShade(GetBorderIndex(Index))
  else if ((BorderMask and 32) = 32) then  //diagonal up
     Result := FBorders.GetDiagonalUpTintAndShade(GetBorderIndex(Index))
  else 
     Result := 0;
end;

function TXLSStyleXFs.SetBorderTintAndShade(const Index: integer;
  BorderMask: byte; const Value: OleVariant; const ReplaceIndex: boolean): integer;
var d: double;
begin
  d := (Value/1000000000) - 1;
  Result := Index;
  if (BorderMask and 63) > 0 then begin
    if (BorderMask and 1) = 1 then begin   //left
       Result := SetBorderIndex(Result, FBorders.SetLeftTintAndShade(GetBorderIndex(Result), d), ReplaceIndex);
    end;
    if (BorderMask and 2) = 2 then begin  //right
       Result := SetBorderIndex(Result, FBorders.SetRightTintAndShade(GetBorderIndex(Result), d), ReplaceIndex);
    end;
    if (BorderMask and 4) = 4 then begin  //top
       Result := SetBorderIndex(Result, FBorders.SetTopTintAndShade(GetBorderIndex(Result), d), ReplaceIndex);
    end;
    if (BorderMask and 8) = 8 then begin   //bottom
       Result := SetBorderIndex(Result, FBorders.SetBottomTintAndShade(GetBorderIndex(Result), d), ReplaceIndex);
    end;
    if (BorderMask and 16) = 16 then begin   //diagonal down
       Result := SetBorderIndex(Result, FBorders.SetDiagonalDownTintAndShade(GetBorderIndex(Result), d), ReplaceIndex);
    end;
    if (BorderMask and 32) = 32 then begin   //diagonal up
       Result := SetBorderIndex(Result, FBorders.SetDiagonalUpTintAndShade(GetBorderIndex(Result), d), ReplaceIndex);
    end;
  end;
end;

function TXLSStyleXFs.GetBorderWeight(const Index: integer;
  BorderMask: byte): LongWord;
begin
  if ((BorderMask and 1) = 1) then  //left
     Result := FBorders.GetLeftWeight(GetBorderIndex(Index))
  else if ((BorderMask and 2) = 2) then  //right
     Result := FBorders.GetRightWeight(GetBorderIndex(Index))
  else if ((BorderMask and 4) = 4) then  //top
     Result := FBorders.GetTopWeight(GetBorderIndex(Index))
  else if ((BorderMask and 8) = 8) then  //bottom
     Result := FBorders.GetBottomWeight(GetBorderIndex(Index))
  else if ((BorderMask and 16) = 16) then  //diagonal down
     Result := FBorders.GetDiagonalDownWeight(GetBorderIndex(Index))
  else if ((BorderMask and 32) = 32) then  //diagonal up
     Result := FBorders.GetDiagonalUpWeight(GetBorderIndex(Index))
  else 
     Result := 0;
end;

function TXLSStyleXFs.SetBorderWeight(const Index: integer; BorderMask: byte;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := Index;
  if (BorderMask and 63) > 0 then begin
    if (BorderMask and 1) = 1 then begin   //left
       Result := SetBorderIndex(Result, FBorders.SetLeftWeight(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 2) = 2 then begin  //right
       Result := SetBorderIndex(Result, FBorders.SetRightWeight(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 4) = 4 then begin  //top
       Result := SetBorderIndex(Result, FBorders.SetTopWeight(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 8) = 8 then begin   //bottom
       Result := SetBorderIndex(Result, FBorders.SetBottomWeight(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 16) = 16 then begin   //diagonal down
       Result := SetBorderIndex(Result, FBorders.SetDiagonalDownWeight(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
    if (BorderMask and 32) = 32 then begin   //diagonal up
       Result := SetBorderIndex(Result, FBorders.SetDiagonalUpWeight(GetBorderIndex(Result), Value), ReplaceIndex);
    end;
  end;
end;


function TXLSStyleXFs.GetBordersDefined(Index: integer): boolean;
begin
  if Index = 0 then Index := 15;
  Result := XF[Index].ApplyBorder;
end;



function TXLSStyleXFs.GetInteriorPattern(const Index: integer): byte;
begin
  Result := FFills.GetPatternType(GetFillIndex(Index));
end;

function TXLSStyleXFs.SetInteriorPattern(const Index: integer;
   const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFillIndex(Index, FFills.SetPatternType(GetFillIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.GetInteriorPatternColorIndex(const Index: integer): longword;
begin
  Result := FFills.GetFgColorIndex(GetFillIndex(Index));
end;

function TXLSStyleXFs.GetInteriorPatternColor(const Index: integer): longword;
begin
  Result := FFills.GetFgColor(GetFillIndex(Index));
end;

function TXLSStyleXFs.GetInteriorPatternThemeColor(const Index: integer): longword;
begin
  Result := FFills.GetFgThemeColor(GetFillIndex(Index));
end;

function TXLSStyleXFs.GetInteriorPatternTintAndShade(const Index: integer): double;
begin
  Result := FFills.GetFgTintAndShade(GetFillIndex(Index));
end;

function TXLSStyleXFs.SetInteriorPatternColorIndex(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFillIndex(Index, FFills.SetFgColorIndex(GetFillIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.SetInteriorPatternColor(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFillIndex(Index, FFills.SetFgColor(GetFillIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.SetInteriorPatternThemeColor(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFillIndex(Index, FFills.SetFgThemeColor(GetFillIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.SetInteriorPatternTintAndShade(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFillIndex(Index, FFills.SetFgTintAndShade(GetFillIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.GetInteriorColorIndex(const Index: integer): longword;
begin
  Result := FFills.GetBgColorIndex(GetFillIndex(Index));
end;

function TXLSStyleXFs.GetInteriorColor(const Index: integer): longword;
begin
  Result := FFills.GetBgColor(GetFillIndex(Index));
end;

function TXLSStyleXFs.GetInteriorThemeColor(const Index: integer): longword;
begin
  Result := FFills.GetBgThemeColor(GetFillIndex(Index));
end;

function TXLSStyleXFs.GetInteriorTintAndShade(const Index: integer): double;
begin
  Result := FFills.GetBgTintAndShade(GetFillIndex(Index));
end;

function TXLSStyleXFs.SetInteriorColorIndex(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFillIndex(Index, FFills.SetBgColorIndex(GetFillIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.SetInteriorColor(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFillIndex(Index, FFills.SetBgColor(GetFillIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.SetInteriorThemeColor(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFillIndex(Index, FFills.SetBgThemeColor(GetFillIndex(Index), Value), ReplaceIndex);
end;

function TXLSStyleXFs.SetInteriorTintAndShade(const Index: integer;
  const Value: OleVariant; const ReplaceIndex: boolean): integer;
begin
  Result := SetFillIndex(Index, FFills.SetBgTintAndShade(GetFillIndex(Index), Value), ReplaceIndex);
end;

procedure TXLSStyleXFs.SetTransformMode(Value: integer);
begin
  self.TransformMode := Value; 
  FFonts.TransformMode := Value;
  FBorders.TransformMode := Value;
  FFills.TransformMode := Value;
end;

procedure TXLSStyleXFs._Clear;
begin
  inherited _Clear;
  FStartIndex := 0;
  FDefaultCount := 16;
  FStyles._Clear;
  FFormats.Free;
  FFormats := TXLSNumFormatList.Create;
  FFonts._Clear;
  FBorders._Clear;
  FFills._Clear;
end;

function TXLSStyleXFs.GetReferredXf(Index: integer): TXLSStyleXF;
begin
  Result := TXLSStyleXF(FReferredList[Index].FKey);
end;

function TXLSStyleXFs.GetXFBlob(Index: integer; FileFormat: TXLSFileFormat): TXLSBlob;
Var f: TXLSStyleXF;
    lSize: word;
    si: integer;
    bval: byte;
    wval: word;
begin
   f := TXLSStyleXF(FReferredList[Index].FKey);
   if FileFormat = xlExcel5 then lSize := 20 else lSize := 24;
   Result := TXLSBlob.Create(lSize);

   with Result do begin
     AddWord($00E0);              //Record
     AddWord(lSize - 4);          //Length
     AddWord(FFonts.SaveIndex[f.FontIndex]);
     AddWord(f.NumFormatIndex);      
     if f.ParentStyleIndex = -1 then begin
        wval := $FFF4;
     end else begin
        wval := (f.ParentStyleIndex and $FFF) shl 4;
     end;
     wval := wval or (f.Protection and $03);
     AddWord(wval);

     //alignment
     bval := (f.HorAlign and $07) or 
             ((f.VerAlign and $07) shl 4);
     if f.WrapText then bval := bval or $08;
     AddByte(bval);

     if FileFormat = xlExcel5 then begin
        //BIFF5
        bval :=  (f.Orientation and $03) or 
                 (f.UsedAttributes shl 2);
        AddByte(bval);
        AddLong(0);
        AddLong(0);
     end else begin
        //BIFF8 
        //rotation 
        AddByte(f.Orientation);
        //indentlevel&shrinkToFit
        bval := f.IndentLevel and $0F;
        if f.ShrinkToFit then bval := bval or $10;
        bval := bval or ((f.ReadingOrder and $03) shl 6);
        AddByte(bval); 
        //used attribute
        AddByte(f.UsedAttributes shl 2);
        //border styles
        AddLong(0);
        AddLong(0);
        AddWord(0);
     end;
   end;

   si := FBorders.SaveIndex[f.BorderIndex];  
   FBorders.SetBorderData(si, Result, FileFormat);

   si := FFills.SaveIndex[f.FillIndex]; 
   FFills.SetFillData(si, Result, FileFormat);

end;

procedure TXLSStyleXFs.CreateAllReferredList(ATransformMode: integer);
Var i: integer;
    ifnt: integer;
    ibrd: integer;
    ifls: integer;
    f: TXLSStyleXF;
begin
//  w rite('1. blocks:', AllocMemCount, ' size:', AllocMemSize);
//  w riteln(' free:', GetHeapStatus.TotalFree);

  SetTransformMode(ATransformMode);

  FFonts.ClearAllReferredCount;
  FBorders.ClearAllReferredCount;
  FFills.ClearAllReferredCount;

  if ListSize > 0 then begin
     for i := 0 to ListSize - 1 do begin
       if IsUsed(i) then begin
          f := XF[i];
          ifnt := f.FontIndex;
          FFonts.IncReferredCount(ifnt);

          ibrd := f.BorderIndex;
          FBorders.IncReferredCount(ibrd);

          ifls := f.FillIndex;
          FFills.IncReferredCount(ifls);

       end;
     end;
  end;

  FFonts.CreateUniqueList;
  FFonts.CreateReferredList2;
  FFonts.ClearUniqueList; 

  FBorders.CreateUniqueList;
  FBorders.CreateReferredList2;
  FBorders.ClearUniqueList; 

  FFills.CreateUniqueList;
  FFills.CreateReferredList2;
  FFills.ClearUniqueList; 
  
  CreateUniqueList;
  CreateReferredList2;
  ClearUniqueList;

  SetTransformMode(0);
end;



{ TXLSNumFormatList }
constructor TXLSNumFormatList.Create;
begin
  FListSize := 164;
  FDateFlags := TBoolArray.Create;
  FBuiltin := TXLSStringList.Create;
  FillBuiltin;
  inherited Create;
end;

destructor TXLSNumFormatList.Destroy;
begin
  FDateFlags.Free;
  FBuiltin.Free;
  Inherited Destroy;
end;

function TXLSNumFormatList.GetShortDateFormat: Widestring;
begin
  Result := UpperCase({$IFDEF D2011}FormatSettings.{$ENDIF}ShortDateFormat);
end;

function TXLSNumFormatList.GetShortTimeFormat: Widestring;
begin
  Result := {$IFDEF D2011}FormatSettings.{$ENDIF}ShortTimeFormat;
  Result := StringReplaceW(Result, 'AMPM', 'AM/PM');
end;


procedure TXLSNumFormatList.FillBuiltin;
begin
  FBuiltin.Index['General']   := 0;
  FBuiltin.Index['0']         := 1;
  FBuiltin.Index['0.00']      := 2;
  FBuiltin.Index['#,##0']     := 3;
  FBuiltin.Index['#,##0.00']  := 4;
  FBuiltin.Index['"$"#,##0_);("$"#,##0)']            := 5;  //!!! Dollar sign
  FBuiltin.Index['"$"#,##0_);[Red]("$"#,##0)']       := 6;
  FBuiltin.Index['"$"#,##0.00_);("$"#,##0.00)']      := 7;
  FBuiltin.Index['"$"#,##0.00_);[Red]("$"#,##0.00)'] := 8;
  FBuiltin.Index['0%']        := 9;
  FBuiltin.Index['0.00%']      := 10;
  FBuiltin.Index['0.00E+00']   := 11;
  FBuiltin.Index['# ?/?']      := 12;
  FBuiltin.Index['# ??/??']    := 13;
  FBuiltin.Index[GetShortDateFormat()]     := 14;
  FBuiltin.Index['D-MMM-YY']    := 15;
  FBuiltin.Index['D-MMM']      := 16;
  FBuiltin.Index['MMM-YY']     := 17;

  FBuiltin.Index['h:mm AM/PM']     := 18;
  FBuiltin.Index['h:mm:ss AM/PM']  := 19;
  FBuiltin.Index['h:mm']           := 20;
  FBuiltin.Index['h:mm:ss']        := 21;
  FBuiltin.Index[GetShortDateFormat + ' ' +
                 GetShortTimeFormat] := 22;

  FBuiltin.Index['#,##0_);(#,##0)']            := 37;
  FBuiltin.Index['#,##0_);[Red](#,##0)']       := 38;
  FBuiltin.Index['#,##0.00_);(#,##0.00)']      := 39;
  FBuiltin.Index['#,##0.00_);[Red](#,##0.00)'] := 40;

  FBuiltin.Index['_(* #,##0_);_(* (#,##0);_(* "-"_);_(@_)'] := 41;
  FBuiltin.Index['_("$"* #,##0_);_("$"* (#,##0);_("$"* "-"_);_(@_)'] := 42;
  FBuiltin.Index['_(* #,##0.00_);_(* (#,##0.00);_(* "-"??_);_(@_)'] := 43;
  FBuiltin.Index['_("$"* #,##0.00_);_("$"* (#,##0.00);_("$"* "-"??_);_(@_)'] := 44;

  FBuiltin.Index['mm:ss']     := 45;
  FBuiltin.Index['[h]:mm:ss'] := 46;
  FBuiltin.Index['mm:ss.0']   := 47;
  FBuiltin.Index['##0.0E+0']  := 48;
  FBuiltin.Index['@']         := 49;

  FDateFlags[14] := true;
  FDateFlags[15] := true;
  FDateFlags[16] := true;
  FDateFlags[17] := true;
  FDateFlags[18] := true;
  FDateFlags[19] := true;
  FDateFlags[20] := true;
  FDateFlags[21] := true;
  FDateFlags[22] := true;
  FDateFlags[45] := true;
  FDateFlags[46] := true;
  FDateFlags[47] := true;

end;

function TXLSNumFormatList.GetItem(Index: integer): widestring;
begin
  Result := Inherited GetItem(Index);
  if Result = '' then 
     if Index < 164 then Result := FBuiltin.Value[Index];
end;

function TXLSNumFormatList.AddValue(Value: widestring): integer;
begin
  if FHash.KeyExists(Value) then begin
     Result := inherited AddValue(Value);
     if IsDateFormatValue(Value) then begin
        FDateFlags[Result] := true;
     end;
  end else begin
     if FBuiltin.Exist[Value] then begin
         Result := FBuiltin.Index[Value]
     end else begin
         Result := inherited AddValue(Value);
         if IsDateFormatValue(Value) then begin
            FDateFlags[Result] := true;
         end;
     end;
  end;
end;

function TXLSNumFormatList.FmtExists(value: widestring): boolean;
begin
  Result := FHash.KeyExists(value);
end;

function TXLSNumFormatList.IsDateFormatValue(Format: Widestring): boolean;
begin
  Format := UpperCase(Format);
  {$ifdef D2009}
  Result := (Pos(widestring('DD'), Format) > 0) or
            (Pos(widestring('MM'), Format) > 0) or
            (Pos(widestring('YY'), Format) > 0) or
            (Pos(widestring('HH'), Format) > 0) or
            (Pos(widestring('SS'), Format) > 0); 
  {$else}
  Result := (Pos('DD', Format) > 0) or
            (Pos('MM', Format) > 0) or
            (Pos('YY', Format) > 0) or
            (Pos('HH', Format) > 0) or
            (Pos('SS', Format) > 0); 
  {$endif} 
end;


function TXLSNumFormatList.IsDateFormat(index: integer): boolean;
begin
  Result := FDateFlags[index];
end;

function TXLSNumFormatList.GetNumFormatBlob(Index: integer; FileFormat:TXLSFileFormat): TXLSBlob;
Var lFormat: WideString;
begin
  lFormat := Value[Index];
  if (lFormat <> '') and (FHash.KeyExists(lFormat)) then begin
    if FileFormat = xlExcel5 then
       Result := TXLSBlob.Create(7 + Length(lFormat))
    else
       Result := TXLSBlob.Create(8 + Length(lFormat) * SizeOF(WideChar) + 1);
    With Result do begin
      AddWord($041E);                  //Record
      //Result.AddWord($0003 + Length(Value[Index])); //Length
      AddWord($0000);  //Length
      AddWord(Index);                  //Index
      if FileFormat = xlExcel5 then begin
         AddByte(Length(lFormat));   //Format length
         {$ifdef D2009}
         AddString(AnsiString(lFormat)); //Format
         {$else}
         AddString(lFormat);          //Format
         {$endif} 
      end else begin 
         AddWord(Length(lFormat));   //Format length
         AddByte($01);                    //Unicode flag
         AddWideString(lFormat)      //Format
      end;
      SetWord(DataLength - 4, 2);         //Length
    end;
    
  end else
    Result := nil;
end;


procedure TXLSNumFormatList.SetItem(Index: integer; Value: widestring);
begin
  inherited SetItem(Index, Value);
  FDateFlags[Index] := IsDateFormatValue(Value); 
end;

{TXLSStyleEntry}
constructor TXLSStyleEntry.Create;
begin
   inherited Create;
   FILevel := -1;
end;


{ TXLSStyles }

procedure TXLSStyles.Add(style: TXLSStyleEntry);
begin
  FArr.Add(style);
end;

procedure TXLSStyles.AddBuiltinStyle(Code: byte; XFIndex: integer; iLevel: integer);
Var Entry: TXLSStyleEntry;
begin
  Entry := TXLSStyleEntry.Create;
  Entry.BuiltinID := code;
  Entry.XFIndex := XFIndex;
  Entry.ILevel := iLevel;
  FArr.Add(Entry);
end;

procedure TXLSStyles.AddStyle(Name: widestring; XFIndex: integer);
Var Entry: TXLSStyleEntry;
begin
  Entry := TXLSStyleEntry.Create;
  Entry.BuiltinID := -1;
  Entry.XFIndex := XFIndex;
  Entry.Custom := true;
  Entry.Name := Name; 
  FArr.Add(Entry);
end;

constructor TXLSStyles.Create(XFList: TXLSStyleXFs);
begin
  inherited Create;
  FArr := TList.Create;
  FXFList := XFList;
end;

destructor TXLSStyles.Destroy;
var i, cnt: integer;
begin
  cnt := Count;
  if cnt > 0 then begin
     for i := 0 to cnt - 1 do begin
        TXLSStyleEntry(FArr[i]).Free;
     end;
  end;
  FArr.Free;
  inherited Destroy;
end;

procedure TXLSStyles._Clear;
var i, cnt: integer;
begin
  cnt := Count;
  if cnt > 0 then begin
     for i := 0 to cnt - 1 do begin
        TXLSStyleEntry(FArr[i]).Free;
     end;
  end;
  FArr.Free;
  FArr := TList.Create();
end;

function TXLSStyles.GetCount: integer;
begin
  Result := FArr.Count;
end;

function TXLSStyles.GetStyleBlob(Index: integer; FileFormat: TXLSFileFormat): TXLSBlob;
Var Style:TXLSStyleEntry;
    lSize:LongWord;
    lLen: Word;
begin
   Style := TXLSStyleEntry(FArr[Index]);
   if (Style.Custom) or (Style.BuiltinID > 9)  then begin
      //user defined
     lLen := Length(Style.Name);
     if FileFormat = xlExcel5 then 
          lSize := lLen + 7 
     else 
          lSize := lLen * 2 + 6 + 3;
     Result := TXLSBlob.Create(lSize);
     Result.AddWord($0293);        //Record
     Result.AddWord(lSize - 4);    //Length
     Result.AddWord(((FXFList.SaveIndex[Style.XFIndex] - 1) and $0FFF)); //ixfe
     if FileFormat = xlExcel5 then begin
        Result.AddByte(lLen);    //Length
        {$ifdef D2009}
        Result.AddString(AnsiString(Style.Name));
        {$else}
        Result.AddString(Style.Name);
        {$endif} 
     end else begin
        Result.AddWord(lLen);    //Length
        Result.AddByte($01);     //option
        Result.AddWideString(Style.Name);
     end;
   end else begin
     //builtin
     Result := TXLSBlob.Create(8);
     Result.AddWord($0293);        //Record
     Result.AddWord($0004);        //Length
     Result.AddWord($8000 or
                    ((FXFList.SaveIndex[Style.FXFIndex] - 1) and $0FFF));        //ixfe
     Result.AddByte(Style.BuiltinID);           //BuiltIn
     if Style.ILevel < 0 then begin
         Result.AddByte($FF);           //iLevel
     end else begin
         Result.AddByte(Style.ILevel);  //iLevel
     end;
   end;  
end;

function TXLSStyles.GetStyleEntry(Index: integer): TXLSStyleEntry;
begin
  Result := TXLSStyleEntry(FArr[Index]);
end;

function TXLSStyles.GetXFIndex(Index: integer): integer;
Var Entry: TXLSStyleEntry;
begin
  Entry :=  TXLSStyleEntry(FArr[Index]);
  if Assigned(Entry) then
     Result := Entry.XFIndex
  else
     Result := 0;
end;


end.
