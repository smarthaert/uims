//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlscalc
//
//
//      Description:  Calculate the result of compiled formula
//                    Uncompile formula to string                          
//
//////////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2004-2011 NikaSoft. All rights reserved.
//     Author: A.V.Nikulitsa
//
//       site: http://www.nika-soft.com/ 
//     e-mail: support@nika-soft.com
//
//////////////////////////////////////////////////////////////////////////////
//13.10.08 MD added YEAR,MONTH,DAY

unit xlscalc;
{$Q-}
{$R-}

{$I xlsdef.inc}

interface
uses formula, xlsblob, xlsextern, xlsfrmt, xlshash, xlsstrb;

function VarIsNumeric(Value: Variant): boolean;
function VarIsNull(Value: Variant): boolean;
function VarIsBoolean(Value: Variant): boolean;
function VarIsString(Value: Variant): boolean;
function NormSInv(p: Double): Double;
const
  xlsErrorNull  = $00; // #NULL! Intersection of two cell ranges is empty
  xlsErrorDIV0  = $07; // #DIV/0! Division by zero
  xlsErrorValue = $0F; // #VALUE! Wrong type of operand
  xlsErrorRef   = $17; // #REF! Illegal or deleted cell reference
  xlsErrorName  = $1D; // #NAME? Wrong function or range name
  xlsErrorNum   = $24; // #NUM! Value range overflow
  xlsErrorNA    = $2A; // #N/A! Argument or function not available

  xlsErrorNotSupported = -100;
  xlsErrorCircumRef    = -101;
  xlsErrorOther        = -102; 
  xlsOk = 1;

  xlsErrors = [xlsErrorNull, xlsErrorDIV0, xlsErrorValue, 
               xlsErrorRef,  xlsErrorName, xlsErrorNum, xlsErrorNA];
type 
  TXLSCompCond = (xlsCompNone, 
                 xlsCompLT,  {<} 
                 xlsCompLE,  {<=}
                 xlsCompEQ,  {=}
                 xlsCompGE,  {>=}
                 xlsCompGT,  {>}
                 xlsCompNE  {<>}
                );

//  TGetSheetNameByID  = procedure (SheetID: integer; Var SheetName: widestring) of object;
  TXLSRetValueType = (xlVariantValue, xlNumberValue, xlStringValue, xlBooleanValue);
  TXLSProcessFunc  = function(Func: integer; Value: Variant; Var AddValue: Variant; Var RValue: Variant): integer of object;
  TXLSGetValue     = function(SheetIndex, row, col: integer; Var Value: Variant; Var OutOfUsedRange: boolean): integer of object;


type

  TXLSFormulatArrayItem = class
  private
     FValue: Variant;
     FValueType: integer;
  public
     constructor Create;
     function GetDataSize(AFileFormat: integer): integer;
     function GetCopy: TXLSFormulatArrayItem;
  end;

  TXLSFormulatArray = class
  private
     FItems: TObjectArray;
     FRowsCount: integer;
     FColsCount: integer;
     function GetItem(Row: integer; Col: integer):TXLSFormulatArrayItem;
     procedure SetItem(Row: integer; Col: integer; Value: TXLSFormulatArrayItem);
  public
     constructor Create;
     destructor Destroy; override;
     function GetCopy: TXLSFormulatArray;
     function GetDataSize(AFileFormat: integer): integer;
     function Parse(Data: TXLSBlob; Var Offset: longword; BiffVer: Word): integer;
     function GetData(Data: TXLSBlob; AFileFormat: integer): integer;
     property RowsCount: integer read FRowsCount;
     property ColsCount: integer read FColsCount; 
     property Items[Row: integer; Col: integer]: TXLSFormulatArrayItem read GetItem write SetItem;
  end;

  TXLSFormulatArrays = class
  private
     FArrays: TObjectArray;
     function GetCount: integer;
     function GetItem(Index: integer): TXLSFormulatArray;
  public
     constructor Create;
     destructor Destroy; override;
     function GetCopy: TXLSFormulatArrays;  
     function Add(Value: TXLSFormulatArray): integer;
     function GetDataSize(AFileFormat: integer): integer;
     function Parse(Data: TXLSBlob; Offset: longword; BiffVer: Word): integer;
     function GetData(Data: TXLSBlob; AFileFormat: integer): integer;
     property Count: integer read GetCount;
     property Item[Index: integer]: TXLSFormulatArray read GetItem;
  end;
  
  TXLSCompiledFormula = class;

  TXLSArrayFormula = class
  private
    FFirstRow: integer;
    FFirstCol: integer;
    FLastRow: integer;
    FLastCol: integer;
    FRootRow: integer;
    FRootCol: integer;
    FIsRootFormula: boolean;
    FRootFormula: TXLSCompiledFormula;
  public
    constructor Create(ARootRow, ARootCol, AFirstRow, AFirstCol,ALastRow, ALastCol: integer;
                       ARootFormula: TXLSCompiledFormula); overload;
    constructor Create(ARootRow, ARootCol: integer; ARootFormula: TXLSCompiledFormula); overload;
    property FirstRow: integer read FFirstRow;
    property FirstCol: integer read FFirstCol;
    property LastRow:  integer read FLastRow;
    property LastCol:  integer read FLastCol;
    property RootRow: integer read FRootRow;
    property RootCol: integer read FRootCol;
    property IsRootFormula: boolean read FIsRootFormula;
    property RootFormula: TXLSCompiledFormula read FRootFormula;
  end;

  TXLSCompiledFormula = class
  private
     FTree: TXLSSyntaxItem;
     FExtData: TXLSFormulatArrays;
     FInCalculate: boolean;
     FValue: Variant;
     FChangeID: Longword;
     FArrayFormula: TXLSArrayFormula;
     function GetIsExternalData: boolean;
     function GetIsArrayFormula: boolean;
     procedure SetValue(AValue: variant);
  public
     constructor Create(ATree: TXLSSyntaxItem; AExtData: TXLSFormulatArrays); overload;
     constructor Create(AArrayFormula: TXLSArrayFormula); overload;
     destructor Destroy; override;
     function GetCopy: TXLSCompiledFormula; overload;  
     function GetCopy(DeltaRow, DeltaCol: integer): TXLSCompiledFormula; overload;
     function GetCopy(row1, col1, row2, col2, drow, dcol: integer): TXLSCompiledFormula; overload;
     function GetExternalData(Var Data: TXLSBlob; AFileFormat: integer): integer;
     procedure SetArrayFormula(AArrayFormula: TXLSArrayFormula);
     property InCalculate: boolean read FInCalculate write FInCalculate;
     property ChangeID: longword read FChangeID write FChangeID;
     property Value: variant read FValue write SetValue;
     property IsExternalData: boolean read GetIsExternalData;
     property IsArrayFormula: boolean read GetIsArrayFormula;
     property ArrayFormula: TXLSArrayFormula read FArrayFormula;
  end;

  TXLSCalcRange = class
  private
     FRow1: integer;
     FCol1: integer;
     FRow2: integer;
     FCol2: integer;
     FSheetIndex: integer;
  public 
     Constructor Create(row1, col1, row2, col2, sheetindex: integer);
     property Row1: integer read FRow1;
     property Col1: integer read FCol1;
     property Row2: integer read FRow2;
     property Col2: integer read FCol2;
     property SheetIndex: integer read FSheetIndex;
  end;   

  ICalcRangeList = interface
    ['{0CAF8E11-CE38-A2D4-1AFC-01C04FE17B72}']
    function GetCount: integer;
    function GetItem(index: integer): TXLSCalcRange;
    property Count: integer read GetCount;
    property Item[index: integer] : TXLSCalcRange read GetItem; default;
  end;

  TXLSCalcRangeList = class(TInterfacedObject, ICalcRangeList)
  private
     FArr: array of TXLSCalcRange;
     FCount: integer;
  protected
     procedure Add(row1, col1, row2, col2, sheet: integer);
  public 
     function GetCount: integer;
     function GetItem(index: integer): TXLSCalcRange;
     constructor Create(row1, col1, row2, col2, sheet1, sheet2: integer);   
     destructor Destroy; override;
     property Count: integer read FCount;
     property Item[index: integer] : TXLSCalcRange read GetItem; default;
  end;  


  TXLSCalculator = class
  private
    FFormula:  TXLSFormula; 
    FExtern:   TXLSExternSheet;
    FGetValue: TXLSGetValue;
    FFormater: TXLSFormater;
    FDecimalSeparator: WideChar;
    FListSeparator: WideChar;
    FStoredDecimalSeparator: WideChar;
    FStoredListSeparator: WideChar;
    FStrBuilder: TWideStringBuilder;
    function  GetFormulaRangeItem(Range: TXLSRangeItem; CurRow, CurCol: integer; Formula: TWideStringBuilder): integer;
    function  GetFormulaFuncItem (Item: TXLSSyntaxItem; CurRow, CurCol, CurSheetID: integer; Formula: TWideStringBuilder): integer;
    function  GetFormulaItem     (Item: TXLSSyntaxItem; CurRow, CurCol, CurSheetID: integer; Formula: TWideStringBuilder): integer;
    procedure SetFileFormat(aFileFormat: integer);
    function  GetFileFormat: integer;
    function  GetRetValueType(Value: variant): TXLSRetValueType;
    function  ConvertValue(Var Value: variant; ValueType: TXLSRetValueType): integer;
    function  GetRange(CurSheetIndex: integer; CurRow, CurCol: integer; Item: TXLSSyntaxItem; Var Range: ICalcRangeList): integer;
    function  GetNameRange(CurSheetIndex: integer; CurRow, CurCol: integer; Item: TXLSSyntaxItem; Var Range: ICalcRangeList): integer;
    function  GetValueOffset(SheetIndex: integer; Item:TXLSSyntaxItem;  CurRow, CurCol: integer; Var Value: Variant): integer;
    function  GetValueLookup(SheetIndex: integer; Item:TXLSSyntaxItem;  CurRow, CurCol: integer; Var Value: Variant): integer;
    function  Lookup(SheetIndex: integer; Item:TXLSSyntaxItem;  CurRow, CurCol: integer; Var Value: Variant): integer;

    function  CalcColumn(SheetIndex:integer; Item: TXLSSyntaxItem; CurRow, CurCol: integer; Var Value: Variant): integer;
    function  CalcRow(SheetIndex:integer; Item: TXLSSyntaxItem; CurRow, CurCol: integer; Var Value: Variant): integer;
    function  CalcColumns(SheetIndex:integer; Item: TXLSSyntaxItem; CurRow, CurCol: integer; Var Value: Variant): integer;
    function  CalcRows(SheetIndex:integer; Item: TXLSSyntaxItem; CurRow, CurCol: integer; Var Value: Variant): integer;
    function  GetValueItem(SheetIndex:integer; Item: TXLSSyntaxItem; CurRow, CurCol: integer; Var Value: Variant; ValueType: TXLSRetValueType; RetClass: integer): integer; overload;
    function  GetValueItem(SheetIndex:integer; Item: TXLSSyntaxItem; CurRow, CurCol: integer; Var Value: Variant; ValueType: TXLSRetValueType): integer; overload;
    function  GetValueItemFunc(SheetIndex:integer; Item: TXLSSyntaxItem; CurRow, CurCol: integer; Var Value: Variant; ValueType: TXLSRetValueType; RetClass: integer): integer;
    function  GetValueItemNV(SheetIndex:integer; Item: TXLSSyntaxItem; Func:Integer; Proc:TXLSProcessFunc; CurRow, CurCol: integer; Var RValue: Variant): integer;
    function  GetValueItemNR(SheetIndex:integer; Item: TXLSSyntaxItem; Func:Integer; Proc:TXLSProcessFunc; CurRow, CurCol: integer; Var RValue: Variant): integer;
    function  GetValueItem0A(SheetIndex:integer; Item: TXLSSyntaxItem; Func:Integer; Var RValue: Variant): integer;
    function  GetValueItem1A(SheetIndex:integer; Item: TXLSSyntaxItem; Func:Integer; CurRow, CurCol: integer; Var RValue: Variant): integer;
    function  GetValueItem2A(SheetIndex:integer; Item: TXLSSyntaxItem; Func:Integer; CurRow, CurCol: integer; Var RValue: Variant): integer;
    function  GetValueItem3A(SheetIndex:integer; Item: TXLSSyntaxItem; Func:Integer; CurRow, CurCol: integer; Var RValue: Variant; RetClass: integer): integer;
    function  GetRangeInfo(SheetIndex: integer; CurRow, CurCol: integer; Range: TXLSSyntaxItem; var row1, row2, col1, col2, sheet1, sheet2: integer): integer;
    function  GetValueItemRange(SheetIndex:integer; Item: TXLSSyntaxItem; Func:Integer; Proc:TXLSProcessFunc; CurRow, CurCol: integer; Var AddValue: Variant; Var RValue: Variant): integer; overload;
    function  GetValueItemRange(SheetIndex:integer; Item: TXLSSyntaxItem; CurRow, CurCol: integer; Var RValue: Variant): integer; overload;
    function  GetValueItemRange(SheetIndex: integer; Item: TXLSSyntaxItem; Func:Integer; Proc:TXLSProcessFunc; CurRow, CurCol: integer; 
                                Var AddValue: Variant; Var RValue: Variant;
                                CompCond: TXLSCompCond; CompValue: Variant): integer; overload;
    function  GetValueItemRange2(SheetIndex: integer; RangeCond, RangeVal: TXLSSyntaxItem;  
                                 Func:Integer; Proc:TXLSProcessFunc; CurRow, CurCol: integer; 
                                 Var RValue: Variant;
                                 CompCond: TXLSCompCond; CompValue: Variant): integer;
    function  ExcelSum(Func: integer; Value: Variant; Var AddValue: Variant; Var RValue: Variant): integer;
    function  ExcelLog(Func: integer; Value: Variant; Var AddValue: Variant; Var RValue: Variant): integer;
    function  ParseCondition(Value: Variant; Var CompCond: TXLSCompCond; Var CompVal: Variant): integer;
    function  CalcCountIF(SheetIndex: integer; Item: TXLSSyntaxItem; CurRow, CurCol: integer; Var RValue: Variant): integer;
    function  CalcSumIF(SheetIndex: integer; Item: TXLSSyntaxItem; CurRow, CurCol: integer; Var RValue: Variant): integer;
    function  CalcConcatenate(SheetIndex: integer; Item: TXLSSyntaxItem; CurRow, CurCol: integer; Var RValue: Variant): integer;
    function  CompareVarValues(Operation: integer; Var Value: Variant; Value2: Variant): integer;
    function  CompareVariants(value1: variant; value2: variant): integer;
    function  CalcNPV(SheetIndex: integer; Item:TXLSSyntaxItem;  CurRow, CurCol: integer; Var Value: Variant): integer;
    function  CalcSUMPRODUCT(SheetIndex: integer; Item:TXLSSyntaxItem;  CurRow, CurCol: integer; Var Value: Variant): integer;
    function  GetFormulaData(CompiledFormula: TXLSCompiledFormula; Var lData: TXLSBlob; CurRow, CurCol, CurSheetID: integer; aClass: integer): integer;
    function  ItemIsRange(Item: TXLSSyntaxItem): boolean;
  public
    constructor Create(AExtern: TXLSExternSheet; AGetValue: TXLSGetValue);
    destructor  Destroy; override;
    function GetRangeValue(SheetIndex:integer; CompiledFormula: TXLSCompiledFormula; CurRow, CurCol: integer; Var Value: Variant; aChangeID: LongWord): integer;
    function GetValue(SheetIndex:integer; CompiledFormula: TXLSCompiledFormula; CurRow, CurCol: integer; Var Value: Variant; aChangeID: LongWord): integer;
    function GetCompiledFormula(UncompiledFormula: widestring; SheetID: integer): TXLSCompiledFormula;
    function GetTranslatedFormula(Data: TXLSBlob; Offset: longword; FormulaSize: longword; BiffVer: Word): TXLSCompiledFormula; overload;
    function GetTranslatedFormula(Data: TXLSBlob; Offset: longword; BiffVer: Word): TXLSCompiledFormula; overload;
    function GetUnCompiledFormula(CompiledFormula: TXLSCompiledFormula; CurRow, CurCol, CurSheetID: integer): widestring;
    property FileFormat: integer read GetFileFormat write SetFileFormat;
    function GetArrayFormulaData(CompiledFormula: TXLSCompiledFormula; ACurSheetID: integer; Var AData: TXLSBlob): integer;
    function GetStoreData(CompiledFormula: TXLSCompiledFormula; Var lData: TXLSBlob; CurRow, CurCol, CurSheetID: integer): integer;
    function GetStoreDataExt(CompiledFormula: TXLSCompiledFormula; Var lData: TXLSBlob; CurRow, CurCol, CurSheetID: integer; aClass: integer): integer;
    procedure SetMode(AMode: Char);
    procedure Set2007Settings;
    procedure RestoreSettings;
  end;


function VarIsRange(Value: Variant): boolean; overload;
function VarIsRange(Value: Variant; var int: ICalcRangeList): boolean; overload;
function RangeToVariant(Value: TXLSCalcRangeList): variant;
function xlsfloattostr(value: double; decsep: widechar): widestring;
function xlsstrtofloat(value: widestring; decsep: widechar): double;

implementation
uses Classes, sysutils, math, xlsmasks,
     {$IFDEF D45}
         ComObj
     {$ELSE}
         Variants
     {$ENDIF};

const //XLSMaxRow: Word = $FFFF;
      //XLSMaxCol: Byte = $FF;

      XLSXMaxRow: integer = $FFFFF;
      XLSXMaxCol: integer = $3FFF;

type
  TVarType = Word;

{$I xlsbase.inc}

function VarIsNumeric(Value: Variant): boolean;
begin
  Result := (VarType(Value) and varTypeMask) in 
            [varByte,
             {$IFNDEF D45}
             varWord,  varLongWord,varInt64, varShortInt,
             {$ENDIF}
             {$IFDEF D2009}
             varUInt64,
             {$ENDIF}
             varSmallint, varDate, varInteger, varSingle, varDouble, varCurrency];
end;

function VarIsBoolean(Value: Variant): boolean;
begin
  Result := (VarType(Value) and varTypeMask) in [varBoolean];
end;

function VarIsNull(Value: Variant): boolean;
begin
  Result := (VarType(Value) and varTypeMask) in 
            [varEmpty, varNull];
end;

{$IFDEF D45}
//function VarSupports(Instance: IInterface; IID: TGUID): boolean; overload;
//function VarSupports(Instance: IInterface; IID: TGUID; Var Intf: IInterface): boolean; overload;

function VarSupports(Instance: IInterface; IID: TGUID): boolean;  overload;
var Intf: IInterface;
begin
  Result := (Instance <> nil) and (Instance.QueryInterface(IID, Intf) = 0);
end;

function VarSupports(Instance: IInterface; IID: TGUID; Var Intf: IInterface): boolean;  overload;
begin
  Result := (Instance <> nil) and (Instance.QueryInterface(IID, Intf) = 0);
end;

{$ENDIF}

function VarIsRange(Value: Variant): boolean;
begin
  if TVarData(Value).VType = varUnknown then begin
     Result := VarSupports(Value, ICalcRangeList);
  end else begin
      Result := false;
  end;
end;

function VarIsRange(Value: Variant; var int: ICalcRangeList): boolean;
Var l_int: IInterface;
begin
  int := nil;
  if TVarData(Value).VType = varUnknown then begin
     Result := VarSupports(Value, ICalcRangeList, l_int);
     if Result then begin
        int := ICalcRangeList(l_int);
     end;  
  end else begin
      Result := false;
  end;
end;

function RangeToVariant(Value: TXLSCalcRangeList): variant;
begin
  Result := ICalcRangeList(Value);
end;


function Sign(Value: Variant; Var RValue: Variant): integer;
begin
  Result := xlsOk;
  if VarIsNumeric(Value) then
     if Value > 0 then RValue := 1
     else if Value < 0 then RValue := -1
     else RValue := 0
  else Result := xlsErrorValue; 
end;

function VarIsString(Value: Variant): boolean;
var vt: TVarType;
begin
  vt := VarType(Value);
  Result := (vt = varString) or (vt = varOleStr) 
            {$ifdef D2009} or (vt = varUString){$endif};
end;


//col - zero-based index of column
//colref - relative flag
//Result A-style column index
function EncodeColumn(col: integer; colrel: boolean): String;
begin
  if (col >= 0) and (col <= (XLSXMaxCol)) then begin
     Result := '';
     while col >= 0 do begin
        Result := chr((col mod 26) + ord('A')) + Result;
        col := (col div 26) - 1;
     end;
     if colrel then Result := '$' + Result;
  end else begin
     Result := '';
  end;
end;

function EncodeCellRef(row, col: integer; rowrel, colrel: boolean): String;
begin
  Result := EncodeColumn(col, colrel);
  if rowrel then Result := Result + '$';
  Result := Result + inttostr(row + 1);
  if (col < 0) or (row < 0) or (col > XLSXMaxCol) or (row > XLSXMaxRow) then Result := '';
end;

function EncodeRangeRows(row1, row2: integer; row1rel, row2rel: boolean): String;
begin
  if row1rel then Result := '$' else Result := '';
  Result := Result + inttostr(row1 + 1);
  if row2rel then Result := Result + ':$' else Result := Result + ':';
  Result := Result + inttostr(row2 + 1);
  if (row1 < 0) or (row2 < 0) or (row1 > XLSXMaxRow) or (row2 > XLSXMaxRow) then Result := '';
end;

function EncodeRangeCols(col1, col2: integer; col1rel, col2rel: boolean): String;
begin
  Result := EncodeColumn(col1, col1rel) + ':' + EncodeColumn(col2, col2rel);
  if (col1 < 0) or (col2 < 0) or (col1 > XLSXMaxCol) or (col2 > XLSXMaxCol) then Result := '';
end;

function EncodeRange(row1, col1: integer; row1rel, col1rel: boolean;
                     row2, col2: integer; row2rel, col2rel: boolean): String;
var ret: String;
begin
  if (col1 = 0) and (col2 = XLSXMaxCol) then
      Result := EncodeRangeRows(row1, row2, row1rel, row2rel)
  else if (row1 = 0) and ((row2 = 65535) or (row2 = 16383) or (row2 = XLSXMaxRow)) then
      Result := EncodeRangeCols(col1, col2, col1rel, col2rel)
  else begin
      Result := EncodeCellRef(row1, col1, row1rel, col1rel);
      if Result <> '' then begin
         ret := EncodeCellRef(row2, col2, row2rel, col2rel);   
         if ret <> '' then
            Result := Result + ':' + ret
         else
            Result := '';
      end;   
  end;
end;


function xlsfloattostr(value: double; decsep: widechar): widestring;
var sds: char;
    dcs: char;
begin
  dcs := char(decsep);
  if {$IFDEF D2011}FormatSettings.{$ENDIF}DecimalSeparator <> dcs then begin
     sds := {$IFDEF D2011}FormatSettings.{$ENDIF}DecimalSeparator;
     try 
       {$IFDEF D2011}FormatSettings.{$ENDIF}DecimalSeparator := dcs;
       Result := floattostr(Value);
     finally
       {$IFDEF D2011}FormatSettings.{$ENDIF}DecimalSeparator := sds;
     end;
  end else begin
     Result := floattostr(Value);
  end;
end;

function xlsstrtofloat(value: widestring; decsep: widechar): double;
var sds: char;
    dcs: char;
begin
  dcs := char(decsep);
  if {$IFDEF D2011}FormatSettings.{$ENDIF}DecimalSeparator <> dcs then begin
     sds := {$IFDEF D2011}FormatSettings.{$ENDIF}DecimalSeparator;
     try 
       {$IFDEF D2011}FormatSettings.{$ENDIF}DecimalSeparator := dcs;
       Result := strtofloat(Value);
     finally
       {$IFDEF D2011}FormatSettings.{$ENDIF}DecimalSeparator := sds;
     end;
  end else begin
     Result := strtofloat(Value);
  end;
end;


{This function is a replacement for the Microsoft Excel Worksheet function NORMSINV.
 It uses the algorithm of Peter J. Acklam to compute the inverse normal cumulative
 distribution. Refer to http://home.online.no/~pjacklam/notes/invnorm/index.html for
 a description of the algorithm.
 Adapted to Pascal by Andrew Nikulitsa, http://www.nika-soft.com}

function NormSInv(p: Double): Double;
Const 
   a1 = -39.6968302866538;
   a2 = 220.946098424521;
   a3 = -275.928510446969;
   a4 = 138.357751867269;
   a5 = -30.6647980661472;
   a6 = 2.50662827745924;
   b1 = -54.4760987982241;
   b2 = 161.585836858041;
   b3 = -155.698979859887;
   b4 = 66.8013118877197; 
   b5 = -13.2806815528857;
   c1 = -7.78489400243029E-03;
   c2 = -0.322396458041136;
   c3 = -2.40075827716184;
   c4 = -2.54973253934373;
   c5 = 4.37466414146497;
   c6 = 2.93816398269878;
   d1 = 7.78469570904146E-03;
   d2 = 0.32246712907004;
   d3 = 2.445134137143;
   d4 = 3.75440866190742;
   p_low = 0.02425;
   p_high = 1 - p_low;
Var
  q: double;
  r: double;
begin
//  Result := 0;

  if (p <= 0) or (p >= 1) then begin
     //error
     raise Exception.Create('Invalid value in NormSInv');
  end else if p < p_low then begin
    q := Sqrt(-2 * Log10(p));
    Result := (((((c1 * q + c2) * q + c3) * q + c4) * q + c5) * q + c6) / 
               ((((d1 * q + d2) * q + d3) * q + d4) * q + 1);
  end else if p <= p_high then begin
      q := p - 0.5;
      r := q * q;
      Result := (((((a1 * r + a2) * r + a3) * r + a4) * r + a5) * r + a6) * q / 
                (((((b1 * r + b2) * r + b3) * r + b4) * r + b5) * r + 1);
  end else begin
      q := Sqrt(-2 * Log10(1 - p));
      Result := -(((((c1 * q + c2) * q + c3) * q + c4) * q + c5) * q + c6) / 
                  ((((d1 * q + d2) * q + d3) * q + d4) * q + 1);
  end;
end;

function d_Floor(Value: double): double;
begin
  Result := Trunc(Value);
  if Frac(Value) < 0 then Result := Result - 1;
end;

function d_Ceil(Value: double): double;
begin
  Result := Trunc(Value);
  if Frac(Value) > 0 then
     Result := Result + 1;
end;

const 
  DoubleResolution: double     = 0.000000000000005;
  DoubleMaxDigits               = 15;


function GetDecimalsCount(Value: double): integer;
begin
   if       Value < 0   then Result := -GetDecimalsCount(-Value)
   else if  Value < 1   then Result := 0
   else if  Value < 10  then Result := 1
   else                      Result := Trunc(Log10(Value)) + 1;
end;

function GetValueResolution(Value: double): double;
var dc: integer;
    mul: double;
begin
    Result := 0;
    dc := GetDecimalsCount(Value);
    if (dc - 1) < DoubleMaxDigits then begin
       mul := IntPower(10, dc);
       Result := DoubleResolution * mul/10;
    end;       
end;

function get_exponent(d: double): integer;
var l: word;
begin
  l := (PWord(PChar(@d) + 6)^ and $7FF0) shr 4;
  Result := integer(l) - integer($3FF);
end;

function FakeFloor(Value: double): double;
var f: double;
begin
   if Abs(Value) >= 1E+15 then begin
      Result := Value;  
   end else if Value >= 0 then begin
      Result := d_Floor(Value);
      if Frac(Value) > (1 - GetValueResolution(Value)) then Result := Result + 1;
   end else begin
      Result := d_Floor(Value);
      if Abs(Value) > 0.5 then begin {Strange MS Excel behavior}
         f := Frac(Abs(Value));
         if f > 0 then begin
            if f <= GetValueResolution(Abs(Value)) then Result := Result + 1;
         end;
      end;
   end;
   if Abs(Result) < 0.5 then Result := 0;
end;

function FakeCeil(Value: double): double;
var f: double;
begin
   if Abs(Value) >= 1E+15 then begin
      Result := Value;  
   end else if Value >= 0 then begin
      Result := d_Ceil(Value);
      if Value > 0.5 then begin {Strange MS Excel behavior}
         f := Frac(Value);
         if f > 0 then begin
            if f <= GetValueResolution(Value) then Result := Result - 1;
         end; 
      end;
   end else begin
      Result := d_Ceil(Value);
      if Value < -0.5 then begin {Strange MS Excel behavior}
         if Frac(Abs(Value)) > (1 - GetValueResolution(Abs(Value))) then Result := Result - 1;
      end;
   end;
   if Abs(Result) < 0.5 then Result := 0;
end;

function FakeTrunc(Value: double): double;
begin
   if Value >= 0 then begin
      Result := FakeFloor(Value);
   end else begin
      Result := -FakeFloor(-Value);
   end;
   if Abs(Result) < 0.5 then Result := 0;
end;

function TruncTo(Value: double; Digits: double): double;
Var idig: integer; 
    mul: double;
begin
  idig := Integer(Round(Digits));
  if (idig >= 0) then begin
       mul := IntPower(10, idig);
       Result := FakeTrunc(Value * mul) / mul;
  end else begin
       mul := IntPower(10, -idig);
       Result := FakeTrunc(Value / mul) * mul;
  end;
end;


function FakeRound(Value: double): double;
begin
   Result := FakeFloor(Abs(Value) + 0.5);
   if Value < 0 then Result := -Result;
end;

function FakeRoundUp(Value: double): double;
begin
   if Value < 0 then Result := FakeFloor(Value)
   else Result := FakeCeil(Value);
end;


function RoundTo(Value: double; Digits: double): double;
Var idig: integer; 
    mul: double;
begin
  idig := Integer(Round(Digits));
  if (idig >= 0) then begin
      mul := IntPower(10, idig);
      Result := FakeRound(Value * mul) / mul;
  end else begin
      mul := IntPower(10, -idig);
      Result := FakeRound(Value / mul) * mul;
  end;
end;

function RoundUp(Value: double; Digits: double): double;
Var idig: integer; 
    mul: double;
begin
  idig := Integer(Round(Digits));
  if (idig >= 0) then begin
      mul := IntPower(10, idig);
      Result := FakeRoundUp(Value * mul) / mul;
  end else begin
      mul := IntPower(10, -idig);
      Result := FakeRoundUp(Value / mul) * mul;
  end;
end;

function RoundDown(Value: double; Digits: double): double;
begin
   Result := TruncTo(Value, Digits);
end;

{TXLSFormulatArrayItem}
constructor TXLSFormulatArrayItem.Create;
begin
  inherited Create;
  FValue := 0;
  FValueType := 0;
end;

function TXLSFormulatArrayItem.GetDataSize(AFileFormat: integer): integer;
var len: integer;
begin
  if FValueType = $02 then begin
     len := Length(FValue);
     if AFileFormat = xlExcel5 then begin
        Result := 1 + 1 + len; 
     end else begin
        Result := 1 + 2 + 1 + len * 2;
     end;
  end else begin
     Result := 9;
  end;
end;

function TXLSFormulatArrayItem.GetCopy: TXLSFormulatArrayItem;
begin
  Result := TXLSFormulatArrayItem.Create;
  Result.FValue := self.FValue;
end;

{TXLSFormulatArray}
constructor TXLSFormulatArray.Create;
begin
  inherited Create;
  FItems := TObjectArray.Create;
  FRowsCount := 1;
  FColsCount := 1;
end;

destructor TXLSFormulatArray.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

function TXLSFormulatArray.GetCopy: TXLSFormulatArray;
var r,c: integer;
begin
  Result := TXLSFormulatArray.Create;
  Result.FRowsCount := self.FRowsCount;
  Result.FColsCount := self.FColsCount;
  for r := 1 to FRowsCount do begin
      for c := 1 to FColsCount do begin
          Result.Items[r,c] := TXLSFormulatArrayItem(Items[r,c]).GetCopy;
      end;
  end;
end;

function TXLSFormulatArray.GetDataSize(AFileFormat: integer): integer;
var r,c: integer;
begin
  Result := 1 + 2;
  for r := 1 to FRowsCount do begin
    for c := 1 to FColsCount do begin
       Result := Result + Items[r, c].GetDataSize(AFileFormat);
    end;
  end;
end;

function TXLSFormulatArray.GetItem(Row: integer; Col: integer):TXLSFormulatArrayItem;
var Index: integer;
begin
  Index := FColsCount * (Row - 1) + (Col - 1);
  Result := TXLSFormulatArrayItem(FItems[Index]);
end; 

procedure TXLSFormulatArray.SetItem(Row: integer; Col: integer; Value: TXLSFormulatArrayItem);
var Index: integer;
begin
  Index := FColsCount * (Row - 1) + (Col - 1);
  FItems[Index] := Value;
end; 

function TXLSFormulatArray.Parse(Data: TXLSBlob; Var Offset: longword; BiffVer: Word): integer;
Var r, c: integer;
    val: TXLSFormulatArrayItem;
    valtype: byte;
begin
  Result := 1;
  c := Data.GetByte(Offset);
  Inc(Offset);
  r := Data.GetWord(Offset);
  Inc(Offset, 2);
  if BiffVer >= $0600 then  begin
     Inc(c);
     Inc(r);
  end else begin
     if c = 0 then c := 256;
  end;
  FColsCount := c;
  FRowsCount := r;

  for r := 1 to FRowsCount do begin
    for c := 1 to FColsCount do begin
      val := TXLSFormulatArrayItem.Create;
      valtype := Data.GetByte(Offset);
      Inc(Offset);
      val.FValueType := valtype;
      case valtype of 
         $00: begin
                //empty value
                val.FValue := null;
                Inc(Offset, 8);
              end;  
         $01: begin
                //double value 
                val.FValue := Data.GetDouble(Offset);
                Inc(Offset, 8);
              end;

         $02: begin
                //string value 
                val.FValue := Data.GetBiffString(Offset, (BiffVer < $0600), (BiffVer >= $0600));
              end;
         $04: begin
                //boolean value
                val.FValue := (Data.GetByte(Offset) = 1);
                Inc(Offset, 8); 
              end;
         $10: begin
                //error value
                val.FValue := integer(Data.GetByte(Offset));
                Inc(Offset, 8); 
              end;
      end;
      Items[r,c] := val;   
    end;  
  end;
end;


function TXLSFormulatArray.GetData(Data: TXLSBlob; AFileFormat: integer): integer;
var r,c: integer;
    val: TXLSFormulatArrayItem;
    valtype: byte;
    len: integer;
    strval: widestring;  
begin
  Result := 1;
  if AFileFormat = xlExcel5 then begin
     c := ColsCount; 
     if ColsCount = 256 then c := 0;
     r :=  RowsCount;
  end else begin
     c := ColsCount - 1; 
     r :=  RowsCount - 1;
  end;
  Data.AddByte(c);
  Data.AddWord(r);  
  for r := 1 to RowsCount do begin
      for c := 1 to ColsCount do begin
          val := Items[r,c];
          valtype := val.FValueType;
          Data.AddByte(valtype); 
          case valtype of 
             $00: begin
                    //empty value
                    Data.AddLong(0); 
                    Data.AddLong(0); 
                  end;  
             $01: begin
                    //double value 
                    Data.AddDouble(double(val.FValue));
                  end;

             $02: begin
                    //string value 
                    strval := WideString(val.FValue);
                    len := Length(strval);
                    if AFileFormat = xlExcel5 then begin
                       Data.AddByte(len);
                       {$ifdef D2009}
                       Data.AddString(ansistring(strval));      
                       {$else} 
                       Data.AddString(strval);      
                       {$endif}
                    end else begin
                       Data.AddWord(len);
                       Data.AddByte($01);
                       Data.AddWideString(strval);      
                    end; 

                  end;
             $04: begin
                    //boolean value
                    if val.FValue = true then begin
                       Data.AddByte(1); 
                    end else begin
                       Data.AddByte(0); 
                    end;     
                    Data.AddLong(0);
                    Data.AddWord(0);
                    Data.AddByte(0); 
                  end;
             $10: begin
                    //error value
                    Data.AddByte(integer(val.FValue));
                    Data.AddLong(0);
                    Data.AddWord(0);
                    Data.AddByte(0); 
                  end;
          end; 
      end;
  end;
end;


{TXLSFormulatArrays}
constructor TXLSFormulatArrays.Create;
begin
  FArrays := TObjectArray.Create;
end;

destructor TXLSFormulatArrays.Destroy;
begin
  FArrays.Free;
  inherited Destroy;
end;

function TXLSFormulatArrays.GetCount: integer;
begin
  Result := FArrays.Count;
end;

function TXLSFormulatArrays.GetItem(Index: integer): TXLSFormulatArray;
begin
  Result := TXLSFormulatArray(FArrays[Index]);
end;

function TXLSFormulatArrays.Add(Value: TXLSFormulatArray): integer;
begin
   Result := FArrays.Count + 1;
   FArrays[Result] := Value;
end;

function TXLSFormulatArrays.GetCopy: TXLSFormulatArrays;
var i: integer;
begin
  Result := TXLSFormulatArrays.Create;
  for i := 1 to Count do begin
      Result.Add(Item[i].GetCopy);
  end; 
end;

function TXLSFormulatArrays.GetDataSize(AFileFormat: integer): integer;
var i: integer;
begin
  Result := 0;
  for i := 1 to Count do begin
      Result := Result + Item[i].GetDataSize(AFileFormat);
  end; 
end;

function TXLSFormulatArrays.Parse(Data: TXLSBlob; Offset: longword; BiffVer: Word): integer;
Var lArray: TXLSFormulatArray;
begin
  Result := 1;
  while (Offset < Data.DataLength) and (Result = 1) do begin
     lArray := TXLSFormulatArray.Create;
     Result := lArray.Parse(Data, Offset, BiffVer);
     if Result = 1 then begin
        Add(lArray);
     end else begin 
        lArray.Free; 
     end;  
  end;
end;

function TXLSFormulatArrays.GetData(Data: TXLSBlob; AFileFormat: integer): integer;
var i: integer;
begin
  Result := 1;
  for i := 1 to Count do begin
      Result := Item[i].GetData(Data, AFileFormat);
      if Result <> 1 then break; 
  end; 
end;

{TXLSArrayFormula}

constructor TXLSArrayFormula.Create(ARootRow, ARootCol, AFirstRow, AFirstCol,ALastRow, ALastCol: integer;
                       ARootFormula: TXLSCompiledFormula);
begin
  inherited Create;
  FIsRootFormula := true;
  FFirstRow := AFirstRow;
  FLastRow := ALastRow;
  FFirstCol := AFirstCol;
  FLastCol := ALastCol;
  FRootRow := ARootRow;
  FRootCol := ARootCol;
  FRootFormula := ARootFormula;
end;

constructor TXLSArrayFormula.Create(ARootRow, ARootCol: integer; ARootFormula: TXLSCompiledFormula);
begin
  inherited Create;
  FIsRootFormula := false;
  FRootRow := ARootRow;
  FRootCol := ARootCol;
  FRootFormula := ARootFormula;
end;

{TXLSCompiledFormula}
constructor TXLSCompiledFormula.Create(ATree: TXLSSyntaxItem; AExtData: TXLSFormulatArrays);
begin
  inherited Create;
  FTree := ATree;
  FExtData := AExtData;
  FInCalculate := false;
  FChangeID := 0;
  FValue := null; 
  FArrayFormula := nil;
end;

constructor TXLSCompiledFormula.Create(AArrayFormula: TXLSArrayFormula); 
begin
  inherited Create;
  FTree := nil;
  FExtData := nil;
  FInCalculate := false;
  FChangeID := 0;
  FValue := null; 
  FArrayFormula := AArrayFormula;
end;

destructor TXLSCompiledFormula.Destroy; 
begin
  FTree.Free;
  FValue := null;
  if Assigned(FExtData) then FExtData.Free;
  if Assigned(FArrayFormula) then FArrayFormula.Free;

  inherited Destroy;
end;

procedure TXLSCompiledFormula.SetValue(AValue: variant);
begin
  FValue := AValue;
end;

function TXLSCompiledFormula.GetCopy: TXLSCompiledFormula;  
Var lTree: TXLSSyntaxItem;
    lExtData: TXLSFormulatArrays;
begin
  lTree := FTree.CopyObject(0, 0);
  lExtData := nil;
  if Assigned(FExtData) then lExtData := FExtData.GetCopy;
  Result := TXLSCompiledFormula.Create(lTree, lExtData);
end;

function TXLSCompiledFormula.GetCopy(DeltaRow, DeltaCol: integer): TXLSCompiledFormula;  
Var lTree: TXLSSyntaxItem;
    lExtData: TXLSFormulatArrays;
begin
//w riteln('getcopy ', deltarow, ',', deltacol);
  lTree := FTree.CopyObject(DeltaRow, DeltaCol);
  lExtData := nil;
  if Assigned(FExtData) then lExtData := FExtData.GetCopy;
  Result := TXLSCompiledFormula.Create(lTree, lExtData);
end;

function TXLSCompiledFormula.GetCopy(row1, col1, row2, col2, drow, dcol: integer): TXLSCompiledFormula;
Var lTree: TXLSSyntaxItem;
    lExtData: TXLSFormulatArrays;
begin
  lTree := FTree.CopyObject(row1, col1, row2, col2, drow, dcol);
  lExtData := nil;
  if Assigned(FExtData) then lExtData := FExtData.GetCopy;
  Result := TXLSCompiledFormula.Create(lTree, lExtData);
end;

function TXLSCompiledFormula.GetIsExternalData: boolean;
begin
  Result := Assigned(FExtData);
end;

function TXLSCompiledFormula.GetIsArrayFormula: boolean;
begin
  Result := Assigned(FArrayFormula);
end;

procedure TXLSCompiledFormula.SetArrayFormula(AArrayFormula: TXLSArrayFormula);
begin
 FArrayFormula := AArrayFormula;
end;


function TXLSCompiledFormula.GetExternalData(Var Data: TXLSBlob; AFileFormat: integer): integer;
Var lSize: integer;
begin
  lSize := FExtData.GetDataSize(AFileFormat);
  if lSize > 0 then begin
     Data := TXLSBlob.Create(lSize);
     Result := FExtData.GetData(Data, AFileFormat);
     if Result <> 1 then begin
        Data.Free;
        Data := nil;
     end; 
  end else begin
      Result := 1;
      Data := nil; 
  end;
end;



{TXLSCalcRange}
constructor TXLSCalcRange.Create(row1, col1, row2, col2, sheetindex: integer);
begin
  FRow1 := row1;
  FRow2 := row2;
  FCol1 := col1;
  FCol2 := col2;
  FSheetIndex := sheetindex;
end;

{TXLSCalcRangeList}

constructor TXLSCalcRangeList.Create(row1, col1, row2, col2, sheet1, sheet2: integer);
var tmp: integer;
    i: integer;
begin
  FCount := 0;
  if sheet1 > sheet2 then begin
     tmp := sheet1; sheet1 := sheet2; sheet2 := tmp;
  end;
  FCount := sheet2 - sheet1 + 1;
  SetLength(FArr, FCount);
  for i := sheet1 to sheet2 do begin
      FArr[i - sheet1] := TXLSCalcRange.Create(row1, col1, row2, col2, i);
  end;
end;

function TXLSCalcRangeList.GetCount: integer;
begin
   Result := FCount;
end;

procedure TXLSCalcRangeList.Add(row1, col1, row2, col2, sheet: integer);
Var item: TXLSCalcRange;
begin
   item := TXLSCalcRange.Create(row1, col1, row2, col2, sheet);
   Inc(FCount);
   SetLength(FArr, FCount);
   FArr[FCount - 1] := item;
end;

destructor TXLSCalcRangeList.Destroy;
var i: integer;  
begin
  if FCount > 0 then begin
     for i := 0 to FCount - 1 do begin
         FArr[i].Free;
         FArr[i] := nil; 
     end;
     SetLength(FArr, 0);
  end;
  inherited Destroy;
end;

function TXLSCalcRangeList.GetItem(index: integer): TXLSCalcRange;
begin
  if (index > 0) and (index <= Count) then begin
     Result := FArr[index - 1];
  end else begin
     Result := nil;
  end; 
end;


{TXLSCalculator}
constructor TXLSCalculator.Create(AExtern: TXLSExternSheet; AGetValue: TXLSGetValue);
begin
  inherited Create;
  FDecimalSeparator := '.';
  FListSeparator := ';';
  FStrBuilder := TWideStringBuilder.Create(100);

  FExtern   := AExtern;
  FGetValue := AGetValue;
  FFormula  := TXLSFormula.Create(FExtern);
  FFormater := TXLSFormater.Create(false);
  FFormula.DecimalSeparator := FDecimalSeparator;
  FFormula.ListSeparator := FListSeparator;
  SetMode('A');
end;

destructor TXLSCalculator.Destroy;
begin
  FFormula.Free;
  FFormater.Free;
  FStrBuilder.Free;
  inherited Destroy;
end;

function TXLSCalculator.GetValue(SheetIndex:integer; CompiledFormula: TXLSCompiledFormula; CurRow, CurCol: integer; Var Value: Variant; aChangeID: LongWord): integer;
var dval: double;
begin
  if CompiledFormula.InCalculate then
     Result := xlsErrorCircumRef
  else begin
     CompiledFormula.InCalculate := true;
     if (aChangeID = 0) or (CompiledFormula.ChangeID <> aChangeID) then begin
        if CompiledFormula.IsArrayFormula then begin
           Result := xlsErrorNotSupported;
        end else begin
            Result := GetValueItem(SheetIndex, CompiledFormula.FTree, CurRow, CurCol, Value, xlVariantValue);
        end;

        if Result = xlsOk then begin
           if VarIsNull(Value) then begin
              Value := 0;
           end else if VarIsNumeric(Value) then begin
              //to avoid Delphi bug: double value = -0
              dval := Value;  
              if dval = 0  then begin
                 Value := 0;
              end;
           end;
           CompiledFormula.Value := Value;
           CompiledFormula.ChangeID := aChangeID;
        end else begin
           CompiledFormula.ChangeID := 0;
           CompiledFormula.Value := null;
        end;
     end else begin 
        Result := xlsOk;
        Value := CompiledFormula.Value;
     end;
     CompiledFormula.InCalculate := false;
  end;
end;


function TXLSCalculator.GetRangeValue(SheetIndex:integer; CompiledFormula: TXLSCompiledFormula; CurRow, CurCol: integer; Var Value: Variant; aChangeID: LongWord): integer;
begin
  if CompiledFormula.InCalculate then
     Result := xlsErrorCircumRef
  else begin
     CompiledFormula.InCalculate := true;
     if (aChangeID = 0) or (CompiledFormula.ChangeID <> aChangeID) then begin

        if CompiledFormula.IsArrayFormula then begin
           Result := xlsErrorNotSupported;
        end else begin
            Result := GetValueItem(SheetIndex, CompiledFormula.FTree, CurRow, CurCol, Value, xlVariantValue, 0);
        end;

        if Result = xlsOk then begin
           CompiledFormula.Value := Value;
           CompiledFormula.ChangeID := aChangeID;
        end else begin
           CompiledFormula.ChangeID := 0;
           CompiledFormula.Value := null;
        end;
     end else begin 
        Result := xlsOk;
        Value := CompiledFormula.Value;
     end;
     CompiledFormula.InCalculate := false;
  end;
end;

function TXLSCalculator.GetRange(CurSheetIndex: integer; CurRow, CurCol: integer; Item: TXLSSyntaxItem; Var Range: ICalcRangeList): integer;
var iSheet1, iSheet2: integer;
    row1, col1, row2, col2: integer;
begin
   Result := xlsOK;
   Range := nil;
   if item.ItemType <> SA_RANGE then begin
      Result := xlsErrorValue;
   end;

   if Result = xlsOK then begin
      //retrieve range info
      Result := GetRangeInfo(CurSheetIndex, CurRow, CurCol, Item, row1, row2, col1, col2, isheet1, isheet2);
   end;

   if Result = xlsOK then begin
      Range := TXLSCalcRangeList.Create(row1, col1, row2, col2, isheet1, isheet2);
   end;
end;

function TXLSCalculator.GetNameRange(CurSheetIndex: integer; CurRow, CurCol: integer; Item: TXLSSyntaxItem; Var Range: ICalcRangeList): integer;
var iSheet1, iSheet2: integer;
    row1, col1, row2, col2: integer;
begin
   Result := xlsOK;
   Range := nil;
   if item.ItemType <> SA_NAME then begin
      Result := xlsErrorValue;
   end;

   if Result = xlsOK then begin
      //retrieve range info
      Result := GetRangeInfo(CurSheetIndex, CurRow, CurCol, Item, row1, row2, col1, col2, isheet1, isheet2);
   end;

   if Result = xlsOK then begin
      Range := TXLSCalcRangeList.Create(row1, col1, row2, col2, isheet1, isheet2);
   end;
end;


function  TXLSCalculator.ConvertValue(Var Value: variant; ValueType: TXLSRetValueType): integer;
 Var vt: TVarType;
     dval: double;
begin
  Result := xlsOk;
  if ValueType <> xlVariantValue then begin
     vt := VarType(Value);
     case vt of
        varBoolean:case ValueType of                   
                        xlStringValue: if Value then Value := 'TRUE' else Value := 'FALSE';    
                        xlNumberValue: if Value then Value := 1 else Value := 0;     
                   end;                                
        varEmpty,
        varNull:  case ValueType of
                       xlStringValue: Value := '';
                       xlNumberValue: Value := 0;
                       xlBooleanValue: Value := false; 
                  end;
        varByte,
        {$IFNDEF D45}
        varWord,
        varLongWord,
        varInt64,
        varShortInt,
        {$ENDIF}
        {$IFDEF D2009}
        varUInt64,
        {$ENDIF}
        varSmallint,
        varInteger,
        varSingle,
        varDouble,
        varCurrency,
        varDate:  case ValueType of             
                       xlStringValue: Value  := xlsfloattostr(Value, FDecimalSeparator);
                       xlBooleanValue: Value := (Value <> 0); 
                   end;
        {$IFDEF D2009}
        varUString,
        {$ENDIF}
        varOleStr,
        varString:   case ValueType of
                       xlNumberValue: 
                                      if Value = '' then begin
                                          Value := Null;
                                      end else if XLSTryStrToFloat(Value, dval) then begin
                                          Value := dval; 
                                      end else begin
                                          Result := xlsErrorValue;  
                                      end; 

                       xlBooleanValue:try
                                         Value := (uppercase(Value) = 'TRUE');
                                      except
                                        on E:Exception do begin
                                           Result := xlsErrorValue;  
                                        end; 
                                      end; 
                     end;
    else
       Result := xlsErrorValue;
    end;     
  end else begin
    //if VarIsNull(Value) then Value := 0;
  end;
end;

function  TXLSCalculator.GetRetValueType(Value: variant): TXLSRetValueType;
 Var vt: TVarType;
begin
  vt := VarType(Value);
  case vt of
     varBoolean: Result := xlBooleanValue;
     varEmpty,
     varNull: Result := xlNumberValue; 
     varByte,
     {$IFNDEF D45}
     varWord,  varLongWord,varInt64, varShortInt,
     {$ENDIF}
     {$IFDEF D2009}
     varUInt64,
     {$ENDIF}
     varSmallint, varInteger, varSingle, varDouble, varCurrency,
     varDate: Result := xlNumberValue;
     {$IFDEF D2009}
     varUString,
     {$ENDIF}
     varOleStr,
     varString: Result := xlStringValue;
    else
       Result := xlVariantValue;
    end;     
end;

function TXLSCalculator.ExcelSum(Func: integer; Value: Variant; Var AddValue: Variant; Var RValue: Variant): integer;
begin
  Result := xlsOk;
  case Func of 
     0: begin {COUNT}
          if VarIsNumeric(Value) then begin
             if VarIsNumeric(RValue) then 
                RValue := RValue + 1
             else 
                RValue := 1;
          end;
        end;   
     4: begin {SUM}
          if VarIsNumeric(Value) then begin
             if VarIsNumeric(RValue) then 
                RValue := RValue + Value
             else 
                RValue := Value;
          end;
        end;   
     5: begin {AVERAGE}
          if VarIsNumeric(Value) then begin
             if VarIsNumeric(RValue) then begin
                RValue := RValue * (AddValue/(AddValue + 1)) + Value/(AddValue + 1); 
                AddValue := AddValue + 1; 
             end else begin
                RValue := Value;
                AddValue := 1;
             end;
          end;
        end;
     6: begin  {MIN}
          if VarIsNumeric(Value) then begin
             if VarIsNumeric(RValue) then begin
                if RValue > Value then RValue := Value;
             end else RValue := Value;
          end;
        end;
     7: begin  {MAX}
          if VarIsNumeric(Value) then begin
             if VarIsNumeric(RValue) then begin
                if RValue < Value then RValue := Value;
             end else RValue := Value;
          end;
        end;
     169: begin {COUNTA} 
            if not(VarIsNull(Value)) then begin
               if VarIsNumeric(RValue) then RValue := RValue + 1
                                       else RValue := 1;
            end;
          end;
     345: begin {SUMIF} 
            if VarIsNumeric(Value) then begin
               if VarIsNumeric(RValue) then 
                  RValue := RValue + Value
               else 
                  RValue := Value;
            end;
          end;
     346: begin {COUNTIF} 
            if VarIsNumeric(RValue) then RValue := RValue + 1
                                    else RValue := 1;
          end;
     else Result := xlsErrorNotSupported;
  end;
end;

function TXLSCalculator.ExcelLog(Func: integer; Value: Variant; Var AddValue: Variant; Var RValue: Variant): integer;
begin
  Result := xlsOk;
  case Func of 
     36: begin {AND}
          if Not(VarIsNull(Value)) then begin
             Result := ConvertValue(Value, xlBooleanValue); 
             if Result = xlsOk then 
                if VarIsBoolean(RValue) then  RValue := RValue and Value
                                        else  RValue := Value; 
          end;
        end;   
     37: begin {OR}
           if Not(VarIsNull(Value)) then begin
             Result := ConvertValue(Value, xlBooleanValue); 
             if Result = xlsOk then 
                if VarIsBoolean(RValue) then  RValue := RValue or Value
                                        else  RValue := Value; 
          end;
        end;   
     else Result := xlsErrorNotSupported;
  end;
end;


function  TXLSCalculator.GetValueOffset(SheetIndex: integer; Item:TXLSSyntaxItem;  CurRow, CurCol: integer; Var Value: Variant): integer;
begin
   Result := xlsErrorNotSupported;
end;

function  TXLSCalculator.GetValueLookup(SheetIndex: integer; Item:TXLSSyntaxItem;  CurRow, CurCol: integer; Var Value: Variant): integer;
Var V: variant;
    SearchValue: variant;
    RangeSearch: boolean;
    isVertical: boolean;
    Offset: integer;
    Child: TXLSSyntaxItem;

    iSheet1, iSheet2: integer;
    row1, col1, row2, col2: integer;
    sheet, row, col: integer;
    outofusedrange: boolean;
    l_ret: integer;

    lfoundrow: integer;
    lfoundcol: integer;
    lfoundsheet: integer;
    lisfound: boolean;

  function VarIsEq(V1, V2: variant; RangeMode: boolean): integer;
  Var d1, d2: double; 
  begin
    Result := 1;

    if VarIsNull(V1) then begin
       if VarIsNull(V2) then begin
          Result := 0;
       end else if VarIsNumeric(V2) then begin
          Result := VarIsEq(0, V2, RangeMode);
       end else if VarIsString(V2) then begin
          Result := VarIsEq('', V2, RangeMode);
       end else if VarIsBoolean(V2) then begin
          Result := VarIsEq(false, V2, RangeMode);
       end;
    end else if VarIsNull(V2) then begin
       if VarIsNumeric(V1) then begin
          Result := VarIsEq(V1, 0, RangeMode);
       end else if VarIsString(V1) then begin
          Result := VarIsEq(V1, '', RangeMode);
       end else if VarIsBoolean(V1) then begin
          Result := VarIsEq(V1, false, RangeMode);
       end;
    end else begin
      if VarIsNumeric(V1) and VarIsNumeric(V2) then begin
         d1 := double(V1);
         d2 := double(V2);
         if abs(d2-d1) < 0.0000001 then begin
            Result := 0;
         end else if d1 < d2 then begin 
            Result := -1;
         end else begin
            Result := 1;
         end;
      end else begin
        try
           if V1 < V2 then begin
              Result := -1;
           end else if V1 = V2 then begin
              Result := 0;
           end else begin
              Result := 1; 
           end;
        except
          on E:Exception do begin
             Result := 1;
          end; 
        end; 
      end;
    end;
  end;

begin
  Result := xlsOk;
  Offset := 0;
  row1 := 0; row2 := 0;
  col1 := 0; col2 := 0;
  isVertical := (Item.IntValue = 102);
  RangeSearch := true;


  if (Item.IntValue <> 102) and
     (Item.IntValue <> 101) then begin
     Result := xlsErrorNotSupported;
  end;

  if Result = xlsOk then begin
     if Item.ChildCount = 4 then begin
       Result := GetValueItem(SheetIndex, Item.Child[4], CurRow, CurCol, V, xlBooleanValue);      
     end else if Item.ChildCount = 3 then begin
       V := true;
     end else begin
       Result := xlsErrorValue;
     end;
  end;

  if Result = xlsOk then begin
     RangeSearch := V;
//     if RangeSearch <> false then begin
//        Result := xlsErrorNotSupported;
//     end;
  end;


  if Result = xlsOk then begin
     Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, SearchValue, xlVariantValue); 
  end;

  if Result = xlsOk then begin
     Result := GetValueItem(SheetIndex, Item.Child[3], CurRow, CurCol, v, xlNumberValue); 
  end;

  if Result = xlsOk then begin
     try
       Offset := integer(v);
     except
       on E:Exception do begin
          Result := xlsErrorValue;
       end; 
     end; 
  end;
  

  if Result = xlsOk then begin
       Child :=  Item.Child[2];
       Result := GetRangeInfo(SheetIndex, CurRow, CurCol, Child,
                              row1, row2, col1, col2, iSheet1, iSheet2);
  end;

  if Result = xlsOk then begin
     if isVertical and 
        ((Offset > (col2 - col1 + 1)) or 
         (Offset < 1)
        ) then begin
        Result := xlsErrorValue;
     end;
     if not(isVertical) and 
        ((Offset > (row2 - row1 + 1)) or 
         (Offset < 1)
        ) then begin
        Result := xlsErrorValue;
     end;
  end;
      
  //iterations through the range
  if Result = xlsOk then begin
     if isVertical then begin

        lfoundsheet := -1;
        lfoundrow := -1;
        lisfound := false;

        for sheet := iSheet1 to iSheet2 do begin
          for row := row1 to row2 do begin
            //get cell's value 
            Result := FGetValue(sheet, row, col1, V, outofusedrange);
            if outofusedrange then begin
               if RangeSearch and  (lfoundrow >= 0) then begin
                  lisfound := true;
               end;
               break;
            end;


            if Result = xlsOk then begin
               l_ret := VarIsEq(V, SearchValue, RangeSearch);
               if RangeSearch then begin
                  if l_ret <= 0 then begin
                     lfoundsheet := sheet;
                     lfoundrow := row;
                     
                     if l_ret = 0 then begin
                        lisfound := true;
                        break;
                     end;
                  end else begin
                     if lfoundrow >= 0 then begin
                        lisfound := true;
                        break;
                     end;
                  end;    
               end else begin
                  if l_ret = 0 then begin
                     lfoundsheet := sheet;
                     lfoundrow := row;
                     lisfound := true;
                     break;
                  end;
               end; 
            end;
            if Result <> xlsOk then break;
          end;
          if (Result <> xlsOk) or lisfound then break; 
        end;

        if lfoundrow >= 0 then begin
           Result := FGetValue(lfoundsheet, lfoundrow, col1 + Offset - 1, Value, outofusedrange);
        end; 

     end else begin
        lfoundsheet := -1;
        lfoundcol := -1;
        lisfound := false;

        for sheet := iSheet1 to iSheet2 do begin
          for col := col1 to col2 do begin
            //get cell's value 
            Result := FGetValue(sheet, row1, col, V, outofusedrange);

            if outofusedrange then begin
               if RangeSearch and  (lfoundcol >= 0) then begin
                  lisfound := true;
               end;
               break;
            end;

            if Result = xlsOk then begin
               l_ret := VarIsEq(V, SearchValue, RangeSearch);
               if RangeSearch then begin
                  if l_ret <= 0 then begin
                     lfoundsheet := sheet;
                     lfoundcol := col;
                     
                     if l_ret = 0 then begin
                        lisfound := true;
                        break;
                     end;
                  end else begin
                     if lfoundcol >= 0 then begin
                        lisfound := true;
                        break;
                     end;
                  end;    
               end else begin
                  if l_ret = 0 then begin
                     lfoundsheet := sheet;
                     lfoundcol := col;
                     lisfound := true;
                     break;
                  end;
               end; 
            end;

            if Result <> xlsOk then break;
          end;
          if (Result <> xlsOk) or lisfound then break; 
        end;

        if lfoundcol >= 0 then begin
           Result := FGetValue(lfoundsheet, row1 + Offset - 1, lfoundcol, Value, outofusedrange);
        end; 

     end; 
  end;

end;


function  TXLSCalculator.Lookup(SheetIndex: integer; Item:TXLSSyntaxItem;  CurRow, CurCol: integer; Var Value: Variant): integer;
var 
   V: variant;
   SearchValue: variant;
   isSearchVertical: boolean;
   isValueVertical: boolean;
   isVectorForm: boolean;
   CurValue: variant;
   isfound: boolean;
   s_row1, s_row2, s_col1, s_col2, s_iSheet1, s_iSheet2: integer;
   v_row1, v_row2, v_col1, v_col2, v_iSheet1, v_iSheet2: integer;
//   lfoundsheet: integer;
   lfoundrow: integer;
   lfoundcol: integer;
   sheet, row, col: integer;
   outofusedrange: boolean;
   l_ret: integer;
   offset: integer;


  function VarIsEq(V1, V2: variant): integer;
  Var d1, d2: double; 
  begin
    Result := 1;

    if VarIsNull(V1) then begin
       if VarIsNull(V2) then begin
          Result := 0;
       end else if VarIsNumeric(V2) then begin
          Result := VarIsEq(0, V2);
       end else if VarIsString(V2) then begin
          Result := VarIsEq('', V2);
       end else if VarIsBoolean(V2) then begin
          Result := VarIsEq(false, V2);
       end;
    end else if VarIsNull(V2) then begin
       if VarIsNumeric(V1) then begin
          Result := VarIsEq(V1, 0);
       end else if VarIsString(V1) then begin
          Result := VarIsEq(V1, '');
       end else if VarIsBoolean(V1) then begin
          Result := VarIsEq(V1, false);
       end;
    end else begin
      if VarIsNumeric(V1) and VarIsNumeric(V2) then begin
         d1 := double(V1);
         d2 := double(V2);
         if abs(d2-d1) < 0.0000001 then begin
            Result := 0;
         end else if d1 < d2 then begin 
            Result := -1;
         end else begin
            Result := 1;
         end;
      end else begin
        try
           if V1 < V2 then begin
              Result := -1;
           end else if V1 = V2 then begin
              Result := 0;
           end else begin
              Result := 1; 
           end;
        except
          on E:Exception do begin
             Result := 1;
          end; 
        end; 
      end;
    end;
  end;


begin
  Result := xlsOk;
  Value := null;
//  isValueVertical := true;
  isSearchVertical := true;
  isVectorForm:= false;

  if (Item.ChildCount < 2) or (Item.ChildCount > 3) then begin
     Result := xlsErrorValue;
  end;

  if Result = xlsOk then begin
     Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, SearchValue, xlVariantValue); 
  end;

  if Result = xlsOk then begin
       Result := GetRangeInfo(SheetIndex, CurRow, CurCol, Item.Child[2],
                              s_row1, s_row2, s_col1, s_col2, s_iSheet1, s_iSheet2);
  end;

  if Result = xlsOk then begin
     isSearchVertical := (s_row2 - s_row1) >= (s_col2 - s_col1);
     //Range for value 
     if Item.ChildCount = 3 then begin
         Result := GetRangeInfo(SheetIndex, CurRow, CurCol, Item.Child[3],
                              v_row1, v_row2, v_col1, v_col2, v_iSheet1, v_iSheet2);
        isVectorForm := true;
     end else begin
        v_row1 := s_row1;
        v_row2 := v_row2;
        v_col1 := v_col1;
        v_col2 := v_col2;
        v_iSheet1 := v_iSheet1;
        v_iSheet2 := v_iSheet2;
        isVectorForm := false;
     end;
  end;

  if Result = xlsOk then begin
     isValueVertical := (v_row2 - v_row1) >= (v_col2 - v_col1);
     CurValue := null;

     if isSearchVertical then begin
//       lfoundsheet := -1;
       lfoundrow := -1;
       isfound := false;

       sheet := s_iSheet1;
       for row := s_row1 to s_row2 do begin
         //get cell's value 
         Result := FGetValue(sheet, row, s_col1, V, outofusedrange);
         if outofusedrange then begin
            break;
         end;
         if Result = xlsOk then begin
            l_ret := VarIsEq(V, SearchValue);
             if l_ret <= 0 then begin
//                lfoundsheet := sheet;
                lfoundrow := row;
                  
                if l_ret = 0 then begin
                   isfound := true;
                end;
             end else begin
                if lfoundrow >= 0 then begin
                   isfound := true;
                end;
             end;    
         end; 

         if (Result <> xlsOk) or isfound then break; 

       end;

       if lfoundrow >= 0 then begin
           offset := 0;
           if isValueVertical then begin
               if not(isVectorForm) then offset := s_col2 - s_col1;
               Result := FGetValue(v_iSheet1, lfoundrow, v_col1 + Offset, Value, outofusedrange);
           end else begin
               if not(isVectorForm) then offset := s_row2 - s_row1;
               Result := FGetValue(v_iSheet1, v_row1 + Offset, lfoundrow, Value, outofusedrange);
           end;
       end; 

     end else begin
//       lfoundsheet := -1;
       lfoundcol := -1;
       isfound := false;
       sheet := s_iSheet1;

       for col := s_col1 to s_col2 do begin
         //get cell's value 
         Result := FGetValue(sheet, s_row1, col, V, outofusedrange);
         if outofusedrange then begin
            break;
         end;

         if Result = xlsOk then begin

             l_ret := VarIsEq(V, SearchValue);

             if l_ret <= 0 then begin
//                lfoundsheet := sheet;
                lfoundcol := col;
                  
                if l_ret = 0 then begin
                   isfound := true;
                end;
             end else begin
                if lfoundcol >= 0 then begin
                     isfound := true;
                end;
             end;    
         end; 
         if (Result <> xlsOk) or isfound then break; 
       end;

       if lfoundcol >= 0 then begin
           offset := 0;
           if isValueVertical then begin
               if not(isVectorForm) then offset := s_col2 - s_col1;
               Result := FGetValue(v_iSheet1, lfoundcol, v_col1 + offset, Value, outofusedrange);
           end else begin
               if not(isVectorForm) then offset := s_row2 - s_row1;
               Result := FGetValue(v_iSheet1, v_row1 + offset, lfoundcol, Value, outofusedrange);
           end;
       end; 

     end;

  end;
  
end;



function TXLSCalculator.GetValueItemFunc(SheetIndex: integer; Item: TXLSSyntaxItem; CurRow, CurCol: integer; Var Value: Variant; ValueType: TXLSRetValueType; RetClass: integer): integer;
begin
  Result := xlsErrorNotSupported;

  case Item.IntValue of
    0{COUNT}, 4{SUM},  5{AVERAGE}, 6{MIN}, 7{MAX}, 169{COUNTA}: 
       Result := GetValueItemNR(SheetIndex, Item, Item.IntValue, ExcelSum, CurRow, CurCol, Value);
    36,37{AND,OR}:
       Result := GetValueItemNV(SheetIndex, Item, Item.IntValue, ExcelLog, CurRow, CurCol, Value);
    78{OFFSET}:
       Result := GetValueOffset(SheetIndex, Item, CurRow, CurCol, Value);     
    101{HLOOKUP},102{VLOOKUP}:
       Result := GetValueLookup(SheetIndex, Item,  CurRow, CurCol, Value); 
    28{LOOKUP}:
       Result := Lookup(SheetIndex, Item,  CurRow, CurCol, Value); 
    11{NPV}:
       Result := CalcNPV(SheetIndex, Item,  CurRow, CurCol, Value); 
    10{NA}, 19{PI}, 34{TRUE}, 35{FALSE},  63{RAND}, 74{NOW},
    221{TODAY}: 
       Result := GetValueItem0A(SheetIndex, Item, Item.IntValue, Value); 

    228{SUMPRODUCT}:
       Result := CalcSUMPRODUCT(SheetIndex, Item,  CurRow, CurCol, Value); 

    15..18{SIN,COS,TAN,ATAN},
    20..26{SQRT,EXP,LN,LOG10,ABS,INT,SIGN},
    32{LEN},
    33{VALUE},
    38{NOT},
    76{ROWS}, 77{COLUMNS},
    112,113,114{LOWER,UPPER,PROPER},
    127{ISTEXT},
    129{ISBLANK},
    296{NORMSINV},
//<<md12.10.08
    67{DAY},
    68{MONTH},
    69{YEAR}:
//>>md12.10.08
       Result := GetValueItem1A(SheetIndex, Item, Item.IntValue, CurRow, CurCol, Value);
    345{SUMIF}:
       Result := CalcSumIF(SheetIndex, Item, CurRow, CurCol, Value);
    336{CONCATENATE}:
       Result := CalcConcatenate(SheetIndex, Item, CurRow, CurCol, Value);
    346{COUNTIF}:
       Result := CalcCountIF(SheetIndex, Item, CurRow, CurCol, Value);
    27{Round}, 39{MOD}, 48{TEXT}, 109{LOG}, 115{LEFT}, 116{RIGHT}, 197{TRUNC},
    212{RoundUp}, 213{RoundDown},
//<<md13.10.08
    70{WEEKDAY},
//>>md13.10.08
    285{Floor}, 288{Ceiling}, 337{Power}:
       Result := GetValueItem2A(SheetIndex, Item, Item.IntValue, CurRow, CurCol, Value);
    1{IF}, 31{mid}, 65{Date}:
       Result := GetValueItem3A(SheetIndex, Item, Item.IntValue, CurRow, CurCol, Value, RetClass);
    8{Row}:
       Result := CalcRow(SheetIndex, Item, CurRow, CurCol, Value);
    9{COLUMN}:
       Result := CalcColumn(SheetIndex, Item, CurRow, CurCol, Value);
  end;

  if Result <> xlsOk then begin
     //w riteln(Item.IntValue, ' unsupported (', Result ,')');
  end;

  if Result = xlsOk then begin
     Result := ConvertValue(Value, ValueType);
  end;

end;

function TXLSCalculator.GetValueItemRange(SheetIndex: integer; Item: TXLSSyntaxItem; CurRow, CurCol: integer; Var RValue: Variant): integer; 
Var AddValue: Variant;
begin
  AddValue := null;
  Result := GetValueItemRange(SheetIndex, Item, -1, ExcelSum, CurRow, CurCol, AddValue, RValue,
            xlsCompNone, null);
end;

function TXLSCalculator.GetValueItemRange(SheetIndex: integer; Item: TXLSSyntaxItem; Func:Integer; Proc:TXLSProcessFunc; CurRow, CurCol: integer; Var AddValue: Variant; Var RValue: Variant): integer;
begin
  Result := GetValueItemRange(SheetIndex, Item, Func, ExcelSum, CurRow, CurCol, AddValue, RValue,
            xlsCompNone, null);
end;

function TXLSCalculator.GetRangeInfo(SheetIndex: integer; CurRow, CurCol: integer; Range: TXLSSyntaxItem; var row1, row2, col1, col2, sheet1, sheet2: integer): integer;
Var lSupBookIndex: integer;
    lret: integer;
    r: ICalcRangeList;
    ir: IInterface;
    ii: IInterface;
begin

  while Range.ItemType = SA_GROUP do begin
        Range := Range.Child[1];
  end;

  if Range.ItemType = SA_NAME then begin
     lret := FExtern.GetCalcRange(Range.IntValue, SheetIndex, ir);
     if lret = xlsOk then begin
        if VarSupports(ir, ICalcRangeList, ii) then begin
           r := ICalcRangeList(ii); 
           ii := nil;
           if r.Count <> 1 then lret := -1;
           if lret = xlsOk then begin
              row1 := r[1].Row1;
              row2 := r[1].Row2; 
              col1 := r[1].Col1;
              col2 := r[1].Col2; 
              sheet1 := r[1].SheetIndex;
              sheet2 := sheet1;
           end; 
        end else begin
           lret := -1;
        end;
     end;
     Result := lret;
  end else if Range.ItemType = SA_RANGE then begin
     Result := xlsOk;
     with Range.Range do begin
       case FRangeType of
          ref3d, ref2d, range3d, range2d: 
            begin
               row1 := FFirstRow;  
               if FRelative and not(FFirstRowRel) then row1 := row1 + CurRow;
               row2 := row1;
               col1 := FFirstCol;  
               if FRelative and not(FFirstColRel) then col1 := col1 + CurCol;
               col2 := col1;
               if (FRangeType = range2d) or 
                  (FRangeType = range3d) then begin
                  row2 := FLastRow;
                  if FRelative and not(FLastRowRel) then row2 := row2 + CurRow;
                  col2 := FLastCol;
                  if FRelative and not(FLastColRel) then col2 := col2 + CurCol;
               end;
               if (FRangeType = ref3d) or 
                  (FRangeType = range3d) then begin
                  Result := FExtern.GetSheetIndexes(FExternID, lSupBookIndex, sheet1, sheet2);
                  if (Result = 1) and (lSupBookIndex <> FExtern.SupBook.SelfBookIndex) then begin
                      Result := -1;
                  end;
               end else begin
                  sheet1 := SheetIndex; //current worksheet index
                  sheet2 := sheet1;
               end;
            end;
          else  Result := xlsErrorRef;
       end;  
     end;
  end else begin
      Result := xlsErrorValue;
  end;
end;

function TXLSCalculator.GetValueItemRange(SheetIndex: integer; Item: TXLSSyntaxItem; Func:Integer; Proc:TXLSProcessFunc; CurRow, CurCol: integer; 
         Var AddValue: Variant; Var RValue: Variant;
         CompCond: TXLSCompCond; CompValue: Variant): integer;
var iSheet1, iSheet2: integer;
    row1, col1, row2, col2: integer;
    sheet, row, col: integer;
    Res: Variant;
    lCompOk: boolean;
    outofusedrange: boolean;
begin
  //retrieve range info
  Result := GetRangeInfo(SheetIndex, CurRow, CurCol, Item, row1, row2, col1, col2, isheet1, isheet2);
  if (Func = -1) and 
     ((row2 > row1) or (col2 > col1) or (iSheet2 > iSheet1)) then
     Func := 4; {SUM} 
  
  outofusedrange := false;
  //iterations through the range
  if Result = xlsOk then begin
     for sheet := iSheet1 to iSheet2 do begin
       for row := row1 to row2 do begin
         for col := col1 to col2 do begin
           //get cell's value 
           Result := FGetValue(sheet, row, col, Res, outofusedrange);
           if outofusedrange then break;

           if Result = xlsOk then begin
              if Func = -1 then begin
                 RValue := Res;
                 break;
              end else begin
                 lCompOk := true;
                 if CompCond <> xlsCompNone then begin 
                   try  
                     case CompCond of
                       xlsCompEQ: 
                           begin
                             if VarIsString(Res) and VarIsString(CompValue) then begin
                                try
                                  lCompOk := MatchesMask(Res, CompValue);
                                except
                                  on E:Exception do begin
                                     lCompOk := false;
                                  end; 
                                end; 
                             end else begin
                                lCompOk := (Res =  CompValue);
                             end;
                           end;
                       xlsCompNE: lCompOk := (Res <> CompValue);
                       xlsCompLT: lCompOk := (Res <  CompValue);  
                       xlsCompGT: lCompOk := (Res >  CompValue);  
                       xlsCompGE: lCompOk := (Res >= CompValue);  
                       xlsCompLE: lCompOk := (Res <= CompValue);  
                     end;
                   except
                     on E:Exception do begin
                        lCompOk := false;
                     end; 
                   end; 
                 end;
                 if lCompOk then begin
                   Result := Proc(Func, Res, AddValue, RValue);
                 end;
              end;  
           end;
           if Result <> xlsOk then break;
         end;
         if outofusedrange and (col = col1) then break;
         if (Func = -1) or (Result <> xlsOk) then break; 
       end;
       if (Func = -1) or (Result <> xlsOk) then break; 
     end;
  end;
end;

function  TXLSCalculator.GetValueItemRange2(SheetIndex: integer; RangeCond, RangeVal: TXLSSyntaxItem;  
                             Func:Integer; Proc:TXLSProcessFunc; CurRow, CurCol: integer; 
                             Var RValue: Variant;
                             CompCond: TXLSCompCond; CompValue: Variant): integer;
var c_Sheet1, c_Sheet2: integer;
    c_row1, c_col1, c_row2, c_col2, c_rowcnt, c_colcnt: integer;
    v_Sheet1, v_Sheet2: integer;
    v_row1, v_col1, v_row2, v_col2, v_rowcnt, v_colcnt: integer;
    row, col: integer;
    Res, Val: Variant;
    AddValue: Variant;
    lCompOk: boolean;
    outofusedrange: boolean;
begin
  AddValue := null;
  c_rowcnt := 0;
  c_colcnt := 0;
  v_rowcnt := 0;
  v_colcnt := 0;
  //retrieve condition range info
  Result := GetRangeInfo(SheetIndex, CurRow, CurCol, RangeCond, c_row1, c_row2, c_col1, c_col2, c_sheet1, c_sheet2);
  if Result = xlsOk then begin
    c_rowcnt := (c_row2 - c_row1);
    c_colcnt := (c_col2 - c_col1);
    if c_Sheet1 <> c_Sheet2 then begin
      Result := xlsErrorValue;
    end; 
  end;

  if Result = xlsOk then begin
    //retrieve value range info
    Result := GetRangeInfo(SheetIndex, CurRow, CurCol, RangeVal, v_row1, v_row2, v_col1, v_col2, v_sheet1, v_sheet2);
    if Result = xlsOk then begin
      v_rowcnt := (v_row2 - v_row1);
      v_colcnt := (v_col2 - v_col1);
      if v_Sheet1 <> v_Sheet2 then begin
        Result := xlsErrorValue;
      end; 
    end;
  end;

  if Result = xlsOk then begin
    if c_rowcnt > v_rowcnt then c_rowcnt := v_rowcnt;
    if c_colcnt > v_colcnt then c_colcnt := v_colcnt;
  end;

  //iterations through the range
  if Result = xlsOk then begin
     outofusedrange := false; 
     for row := 0 to c_rowcnt do begin
       for col := 0 to c_colcnt do begin
         //get cell's value 
         Result := FGetValue(c_sheet1, c_row1 + row, c_col1 + col, Res, outofusedrange);
         if outofusedrange then break;
         if Result = xlsOk then Result := FGetValue(v_sheet1, v_row1 + row, v_col1 + col, Val, outofusedrange);
         if outofusedrange then break;

         if Result = xlsOk then begin
           lCompOk := true;
           if CompCond <> xlsCompNone then begin 
             try  
               case CompCond of
                 xlsCompEQ: 
                    begin
                      if VarIsString(Res) and VarIsString(CompValue) then begin
                         try
                           lCompOk := MatchesMask(Res, CompValue);
                         except
                           on E:Exception do begin
                              lCompOk := false;
                           end; 
                         end; 
                      end else begin
                         lCompOk := (Res =  CompValue);
                      end;
                    end;
                 xlsCompNE: lCompOk := (Res <> CompValue);
                 xlsCompLT: lCompOk := (Res <  CompValue);  
                 xlsCompGT: lCompOk := (Res >  CompValue);  
                 xlsCompGE: lCompOk := (Res >= CompValue);  
                 xlsCompLE: lCompOk := (Res <= CompValue);  
               end;
             except
               on E:Exception do begin
                  lCompOk := false;
               end; 
             end; 
           end;

           if lCompOk then begin
             Result := Proc(Func, Val, AddValue, RValue);
           end;
         end;
         if Result <> xlsOk then break; 
       end;
       if outofusedrange and (col = 0) then break;
       if Result <> xlsOk then break; 
     end;
  end;
end;



function  TXLSCalculator.GetValueItem0A(SheetIndex:integer; Item: TXLSSyntaxItem; Func:Integer; Var RValue: Variant): integer;
begin
  Result := 1;
  case Func of
    10: {NA}    Result := xlsErrorNotSupported; //!!!!
    19: {PI}    RValue := Pi;  
    34: {TRUE}  RValue := true;  
    35: {FALSE} RValue := false;  
    63: {RAND}  RValue := Random; //Result := xlsErrorNotSupported;
    74: {NOW}    begin
                  RValue := now();
                end; 
   221: {TODAY} begin
                  RValue := date();
                end; 
    else  Result := xlsErrorNotSupported;
  end;
end;

function  TXLSCalculator.GetValueItem1A(SheetIndex:integer; Item: TXLSSyntaxItem; Func:Integer; CurRow, CurCol: integer; Var RValue: Variant): integer;
Var Op: Variant;
//<<md12.10.08
  function ExtractYear(ADate: TDateTime): integer;
  var
    AYear, AMonth, ADay: word;
  begin
    DecodeDate(ADate, AYear, AMonth, ADay);
    Result := AYear;
  end;

  function ExtractMonth(ADate: TDateTime): integer;
  var
    AYear, AMonth, ADay: word;
  begin
    DecodeDate(ADate, AYear, AMonth, ADay);
    Result := AMonth;
  end;

  function ExtractDay(ADate: TDateTime): integer;
  var
    AYear, AMonth, ADay: word;
  begin
    DecodeDate(ADate, AYear, AMonth, ADay);
    Result := ADay;
  end;
//>>md12.10.08
begin
  Result := xlsOk;
  if Item.ChildCount <> 1 then Result := xlsErrorValue; //!!!!
  if Result = xlsOk  then begin

     case Func of
       67{DAY}: begin
                  Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlNumberValue);
                  if Result = xlsOk then RValue := ExtractDay(op);
                end;
       68{MONTH}: begin
                  Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlNumberValue);
                  if Result = xlsOk then RValue := ExtractMonth(op);
                end;
       69{YEAR}: begin
                  Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlNumberValue);
                  if Result = xlsOk then RValue := ExtractYear(op);
                end;
       15{SIN}: begin
                  Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlNumberValue);
                  if Result = xlsOk then RValue := Sin(op);
                end;
       16{COS}: begin
                  Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlNumberValue); 
                  if Result = xlsOk then RValue := Cos(op);
                end;
       17{TAN}: begin
                  Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlNumberValue); 
                  if Result = xlsOk then RValue := Tan(op);
                end;
       18{ATAN}: begin
                  Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlNumberValue); 
                  if Result = xlsOk then RValue := Arctan(op);
                end;
       20{SQRT}: begin
                  Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlNumberValue); 
                  if Result = xlsOk then RValue := sqrt(op);
                end;
       21{EXP}: begin
                  Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlNumberValue); 
                  if Result = xlsOk then RValue := exp(op); 
                end;
       22{Ln}: begin
                  Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlNumberValue); 
                  if Result = xlsOk then RValue := ln(op);
                end;
       23{Log10}: begin
                  Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlNumberValue); 
                  if Result = xlsOk then RValue := math.Log10(op);
                end;
       24{Abs}: begin
                  Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlNumberValue); 
                  if Result = xlsOk then RValue := Abs(op);
                end;
       25{INT}: begin
                  Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlNumberValue); 
                  if Result = xlsOk then begin
                     try 
                       RValue := FakeTrunc(op);
                     except
                       on E:Exception do begin
                          Result := xlsErrorNum;
                end;
                     end;
                  end;
                end;
       26{SIGN}: begin
                  Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlNumberValue); 
                  if Result = xlsOk then Result := Sign(op, RValue);
                end;
       32{LEN}: begin
                  Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlStringValue); 
                  if Result = xlsOk then RValue := Length(op);
                end;
       33{Value}: begin
                    Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlVariantValue); 
                    if Result = xlsOK then begin
                       Result := ConvertValue(op, xlNumberValue);
                    end;           
                    if Result = xlsOk then RValue := op;
                  end;
       38{NOT}: begin
                  Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlBooleanValue); 
                  if Result = xlsOk then RValue := Not(op);
                end;
      76{ROWS}: begin
                  Result := CalcRows(SheetIndex, Item, CurRow, CurCol, RValue);
                end;
   77{COLUMNS}: begin
                  Result := CalcColumns(SheetIndex, Item, CurRow, CurCol, RValue);
                end;
      112{LOWER}: begin
                  Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlStringValue); 
                  if Result = xlsOk then RValue := xlsLowercase(op);
                end;
      113{UPPER}: begin
                  Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlStringValue); 
                  if Result = xlsOk then RValue := xlsUppercase(op);
                end;
      114{PROPER}: begin
                  Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlStringValue); 
                  if Result = xlsOk then RValue := xlsPropercase(op);
                end;
      127{ISTEXT}:
                begin
                  Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlVariantValue); 
                  if Result = xlsOk then RValue := VarIsString(Op);
                end;
      129{ISBLANK}:
                begin
                  Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlVariantValue); 
                  if Result = xlsOk then RValue := VarIsNull(Op);
                end;
      296{NORMSINV}:
                begin
                  Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlNumberValue); 
                  if Result = xlsOk then begin
                     try
                       RValue := normsinv(op);
                     except
                       on E:Exception do begin
                          Result := xlsErrorNum;
                       end; 
                     end; 
                  end else begin
                    Result := xlsErrorValue;
                  end;
                end;
       else  Result := xlsErrorNotSupported;
     end;
  end;
end;

function  TXLSCalculator.CalcColumn(SheetIndex:integer; Item: TXLSSyntaxItem; CurRow, CurCol: integer; Var Value: Variant): integer;
var Op: Variant;
    r: ICalcRangeList;
begin
  Result := xlsOk;
  if (Item.ChildCount = 0) then begin
     Value := CurCol + 1;
  end else if (Item.ChildCount = 1) then begin
     Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlVariantValue, 0);
     if Result = xlsOk then begin
        if VarIsRange(Op, r) then begin
           Value := r[1].Col1 + 1;
           r := nil;
        end else begin
          Result := xlsErrorNotSupported;
        end; 
     end;
  end else begin
     Result := xlsErrorNotSupported;
  end;
end;

function  TXLSCalculator.CalcColumns(SheetIndex:integer; Item: TXLSSyntaxItem; CurRow, CurCol: integer; Var Value: Variant): integer;
var Op: Variant;
    r: ICalcRangeList;
begin
  if (Item.ChildCount = 1) then begin
     Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlVariantValue, 0);
     if Result = xlsOk then begin
        if VarIsRange(Op, r) then begin
           Value := Abs(r[1].Col2 - r[1].Col1) + 1;
           r := nil;
        end else begin
          Result := xlsErrorNotSupported;
        end; 
     end;
  end else begin
     Result := xlsErrorNotSupported;
  end;
end;

function  TXLSCalculator.CalcRow(SheetIndex:integer; Item: TXLSSyntaxItem; CurRow, CurCol: integer; Var Value: Variant): integer;
var Op: Variant;
    r: ICalcRangeList;
begin
  Result := xlsOk;
  if (Item.ChildCount = 0) then begin
     Value := CurRow + 1;
  end else if (Item.ChildCount = 1) then begin
     Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlVariantValue, 0);
     if Result = xlsOk then begin
        if VarIsRange(Op, r) then begin
           Value := r[1].Row1 + 1;
           r := nil;
        end else begin
          Result := xlsErrorNotSupported;
        end; 
     end;
  end else begin
     Result := xlsErrorNotSupported;
  end;
end;

function  TXLSCalculator.CalcRows(SheetIndex:integer; Item: TXLSSyntaxItem; CurRow, CurCol: integer; Var Value: Variant): integer;
var Op: Variant;
    r: ICalcRangeList;
begin
  if (Item.ChildCount = 1) then begin
     Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op, xlVariantValue, 0);
     if Result = xlsOk then begin
        if VarIsRange(Op, r) then begin
           Value := Abs(r[1].Row2 - r[1].Row1) + 1;
           r := nil;
        end else begin
          Result := xlsErrorNotSupported;
        end; 
     end;
  end else begin
     Result := xlsErrorNotSupported;
  end;
end;


function  TXLSCalculator.GetValueItem2A(SheetIndex:integer; Item: TXLSSyntaxItem; Func:Integer; CurRow, CurCol: integer; Var RValue: Variant): integer;
Var Op1, Op2: Variant;
    w: Widestring;
    n: integer;
begin
  Result := xlsOk;
  case Func of
//<<md13.10.08
    70{WEEKDAY}:
        begin
          if (Item.ChildCount > 2) or (Item.ChildCount < 1) then Result := xlsErrorValue; //!!!

          if Result = xlsOk  then begin
             Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op1, xlNumberValue);
             if Result = xlsOk then begin
                if Item.ChildCount = 2 then begin
                   Op2 := 1;
                   Result := GetValueItem(SheetIndex, Item.Child[2], CurRow, CurCol, Op2, xlNumberValue);
                end else begin
                   Op2 := 2;
                end;
             end;
          end;

          if Result = xlsOk then begin
             try
                RValue := DayOfWeek(Op1);  //Sonntag=1
                if (Op2 = 2) or    //1..7 -> 7,1..6
                   (Op2 = 3) then  //1..7 -> 6,0..5
                begin
                  RValue := RValue - 1;
                  if RValue = 0 then
                    RValue := 7;
                  if Op2 = 3 then
                    RValue := RValue - 1;
                end;
             except
               on E:Exception do begin
                  Result := xlsErrorValue;
               end;
             end;
          end;

        end;
//>>md13.10.08

    109{LOG}:
        begin
          if (Item.ChildCount > 2) or (Item.ChildCount < 1) then Result := xlsErrorValue; //!!!

          if Result = xlsOk  then begin
             Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op1, xlNumberValue); 
             if Result = xlsOk then begin
                if Item.ChildCount = 2 then begin
                   Result := GetValueItem(SheetIndex, Item.Child[2], CurRow, CurCol, Op2, xlNumberValue);
                end else begin
                   Op2 := 10;
                end;
             end;
          end; 

          if Result = xlsOk then begin
             try
                RValue := math.LogN(op2, op1);
             except
               on E:Exception do begin
                  Result := xlsErrorValue;
               end; 
             end; 
          end;

        end;

    197{TRUNC}:
        begin
          if (Item.ChildCount > 2) or (Item.ChildCount < 1) then Result := xlsErrorValue; //!!!

          if Result = xlsOk  then begin
             Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op1, xlNumberValue); 
             if Result = xlsOk then begin
                if Item.ChildCount = 2 then begin
                   Result := GetValueItem(SheetIndex, Item.Child[2], CurRow, CurCol, Op2, xlNumberValue);
                end else begin
                   Op2 := 0;
                end;
             end;
          end; 

          if Result = xlsOk then begin
             try
                RValue := TruncTo(op1, op2);
             except
               on E:Exception do begin
                  Result := xlsErrorValue;
               end; 
             end; 
          end;

        end;

    212{RoundUp}:
        begin
          if (Item.ChildCount > 2) or (Item.ChildCount < 1) then Result := xlsErrorValue; //!!!

          if Result = xlsOk  then begin
             Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op1, xlNumberValue); 
             if Result = xlsOk then begin
                if Item.ChildCount = 2 then begin
                   Result := GetValueItem(SheetIndex, Item.Child[2], CurRow, CurCol, Op2, xlNumberValue);
                end else begin
                   Op2 := 0;
                end;
             end;
          end; 

          if Result = xlsOk then begin
             try
                RValue := RoundUp(op1, op2);
             except
               on E:Exception do begin
                  Result := xlsErrorValue;
               end; 
             end; 
          end;

        end;
    213{RoundDown}:
        begin
          if (Item.ChildCount > 2) or (Item.ChildCount < 1) then Result := xlsErrorValue; //!!!

          if Result = xlsOk  then begin
             Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op1, xlNumberValue); 
             if Result = xlsOk then begin
                if Item.ChildCount = 2 then begin
                   Result := GetValueItem(SheetIndex, Item.Child[2], CurRow, CurCol, Op2, xlNumberValue);
                end else begin
                   Op2 := 0;
                end;
             end;
          end; 

          if Result = xlsOk then begin
             try
                RValue := RoundDown(op1, op2);
             except
               on E:Exception do begin
                  Result := xlsErrorValue;
               end; 
             end; 
          end;

        end;
 
    27{Round}: 
        begin
          if Item.ChildCount <> 2 then Result := xlsErrorValue; //!!!
          if Result = xlsOk  then begin
             Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op1, xlNumberValue); 
             if Result = xlsOk then Result := GetValueItem(SheetIndex, Item.Child[2], CurRow, CurCol, Op2, xlNumberValue);
             if Result = xlsOk then begin
                 try
                   RValue := RoundTo(op1, op2);
                 except
                   on E:Exception do begin
                      Result := xlsErrorValue;
                   end; 
                 end; 
             end;
          end;
        end;

    39{MOD}: 
        begin
          if Item.ChildCount <> 2 then Result := xlsErrorValue; //!!!
          if Result = xlsOk  then begin
             Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op1, xlNumberValue); 
             if Result = xlsOk then Result := GetValueItem(SheetIndex, Item.Child[2], CurRow, CurCol, Op2, xlNumberValue);
             if Result = xlsOk then begin
                 try
                   if op2 = 0 then begin
                      Result := xlsErrorDIV0;
                   end else begin
                     RValue := op1 mod op2;
                   end;
                 except
                   on E:Exception do begin
                      Result := xlsErrorDIV0;
                   end; 
                 end; 
             end;
          end;
        end;
    48{TEXT}: 
        begin
          if Item.ChildCount <> 2 then Result := xlsErrorValue; //!!!
          if Result = xlsOk  then 
             Result := GetValueItem(SheetIndex, Item.Child[2], CurRow, CurCol, Op2, xlStringValue);
          if Result = xlsOk  then 
             Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op1, xlVariantValue);
          if Result = xlsOk  then begin
             try
                 w := op2;
                 w := DelocalizeFormat(w);
                 RValue := FFormater.GetDisplayValue(op1, w, false);
             except
               on E:Exception do begin
                  RValue := Null; 
               end; 
             end; 
          end; 
        end;
    115{LEFT},116{RIGHT}: 
        begin
          if (Item.ChildCount < 1) or (Item.ChildCount > 2) then Result := xlsErrorValue; //!!!
          if Result = xlsOk  then begin
             if (Item.ChildCount = 2) then 
                Result := GetValueItem(SheetIndex, Item.Child[2], CurRow, CurCol, Op2, xlNumberValue)
             else 
                Op2 := 1;
             if Result = xlsOk then Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op1, xlStringValue);
             if Result = xlsOk then begin
                 try
                    if op1 = Null then 
                       RValue := Null
                    else begin
                       w := op1;
                       n := integer(op2);
                       if Func = 115 then 
                          RValue := Copy(w, 1, n)
                       else 
                          RValue := Copy(w, length(w) - n + 1, n);
                    end;
                 except
                   on E:Exception do begin
                      RValue := Null; 
                   end; 
                 end; 
             end;
          end;
        end;
    285 {FLOOR}:
        begin
           
          if Item.ChildCount <> 2 then Result := xlsErrorValue; //!!!

          if Result = xlsOk  then begin
             Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op1, xlNumberValue); 
             if Result = xlsOk then Result := GetValueItem(SheetIndex, Item.Child[2], CurRow, CurCol, Op2, xlNumberValue);
          end;

          if Result = xlsOk then begin

             if op1 = 0 then begin
                 RValue := 0;
             end else begin

                 if Result = xlsOk then begin
                     if op2 = 0 then begin
                        Result := xlsErrorDIV0;
                     end;
                 end; 

                 if Result = xlsOk then begin
                     if ((op1 > 0) and (op2 < 0)) or
                        ((op1 < 0) and (op2 > 0)) then begin  
                        Result  := xlsErrorValue;
                     end;
                 end; 

                 if Result = xlsOk then begin
                     try
                       RValue := FakeFloor(op1 / op2);
                       if RValue <> 0 then RValue := RValue * op2;
                     except
                       on E:Exception do begin
                          Result := xlsErrorValue;
                       end; 
                     end; 
                 end;
             end;                    
          end;
        end;  
    288 {CEILING}:
        begin
           
          if Item.ChildCount <> 2 then Result := xlsErrorValue; //!!!

          if Result = xlsOk  then begin
             Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op1, xlNumberValue); 
             if Result = xlsOk then Result := GetValueItem(SheetIndex, Item.Child[2], CurRow, CurCol, Op2, xlNumberValue);

          end;  

          if Result = xlsOk then begin

             if op1 = 0 then begin
                 RValue := 0;
             end else begin

                 if Result = xlsOk then begin
                     if op2 = 0 then begin
                        Result := xlsErrorDIV0;
                     end;
                 end; 

                 if Result = xlsOk then begin
                     if ((op1 > 0) and (op2 < 0)) or
                        ((op1 < 0) and (op2 > 0)) then begin  
                        Result  := xlsErrorValue;
                     end;
                 end; 

                 if Result = xlsOk then begin
                     try
                       RValue := FakeCeil(op1 / op2);
                       if RValue <> 0 then RValue := RValue * op2;
                     except
                       on E:Exception do begin
                          Result := xlsErrorValue;
                       end; 
                     end; 
                 end;
             end;                    
          end;
        end;  
    337 {Power}:
        begin
           
          if Item.ChildCount <> 2 then Result := xlsErrorValue; //!!!

          if Result = xlsOk  then begin
             Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op1, xlNumberValue); 
             if Result = xlsOk then Result := GetValueItem(SheetIndex, Item.Child[2], CurRow, CurCol, Op2, xlNumberValue);
          end;  

          if Result = xlsOk then begin

             if op1 = 0 then begin
                 RValue := 0;
             end else begin
                 try
                   RValue := Power(op1, op2);
                 except
                   on E:Exception do begin
                      Result := xlsErrorValue;
                   end; 
                 end; 
             end;                    
          end;
        end;  
    else  Result := xlsErrorNotSupported;
  end;
end;

function TXLSCalculator.GetValueItemNV(SheetIndex: integer; Item: TXLSSyntaxItem; Func:Integer; Proc:TXLSProcessFunc; CurRow, CurCol: integer; Var RValue: Variant): integer;
Var i: integer;
    Res: Variant;
    AddValue: Variant;
    Child: TXLSSyntaxItem;
begin
  Result   := xlsOk;
  RValue   := Null;
  Res      := Null;
  AddValue := Null;
  if Item.ChildCount > 0 then begin
     //iteration throught all operands
     for i := 1 to Item.ChildCount do begin
       Child := Item.Child[i];
       Result := GetValueItem(SheetIndex, Child, CurRow, CurCol, Res, xlVariantValue);
  
       if Result = xlsOk then Result := Proc(Func, Res, AddValue, RValue); 
       if Result <> xlsOk then break;
     end;
  end; 
end;

function TXLSCalculator.ParseCondition(Value: Variant; Var CompCond: TXLSCompCond; Var CompVal: Variant): integer;
Var lwOper: Widestring;
    lwCond: Widestring;
begin
  Result := xlsOk;
  CompCond := xlsCompEQ;
  CompVal :=  Value;

  if VarIsString(Value) then begin
    lwOper := Value; 

    if Length(lwOper) > 0 then begin
      lwCond := copy(lwOper, 1, 1);
      if lwCond = '=' then begin
        CompCond := xlsCompEQ;
        lwOper  := Copy(lwOper, 2, Length(lwOper) - 1);
      end else if lwCond = '>' then begin
        CompCond := xlsCompGT;
        lwOper  := Copy(lwOper, 2, Length(lwOper) - 1);
      end else if lwCond = '<' then begin
        CompCond := xlsCompLT;
        lwOper  := Copy(lwOper, 2, Length(lwOper) - 1);
      end;
    end;

    if (Length(lwOper) > 0) and 
       ((CompCond = xlsCompLT) or (CompCond = xlsCompGT)) then begin
      lwCond := copy(lwOper, 1, 1);
      if (lwCond = '=') and (CompCond = xlsCompLT) then begin
        CompCond := xlsCompLE;
        lwOper  := Copy(lwOper, 2, Length(lwOper) - 1);
      end else if (lwCond = '=') and (CompCond = xlsCompGT) then begin
        CompCond := xlsCompGE;
        lwOper  := Copy(lwOper, 2, Length(lwOper) - 1);
      end else if (lwCond = '>') and (CompCond = xlsCompLT) then begin
        CompCond := xlsCompNE;
        lwOper  := Copy(lwOper, 2, Length(lwOper) - 1);
      end;
    end;

    CompVal := lwOper;
    if ConvertValue(CompVal, xlNumberValue) <> xlsOk then begin
       CompVal := lwOper;
    end;
  end;
end;

function TXLSCalculator.CalcCountIF(SheetIndex: integer; Item: TXLSSyntaxItem; CurRow, CurCol: integer; Var RValue: Variant): integer;
Var lOper: Variant;
    lRange: TXLSSyntaxItem;
    lCompCond: TXLSCompCond;
    lCompVal: Variant;
    AddValue: Variant;
begin
  Result   := xlsOk;
  RValue   := Null;
  lRange := nil;

  if Item.ChildCount <> 2 then begin
     Result := xlsErrorNA;
  end;

  if Result = xlsOk then begin
     //first operand should be a range
     lRange := Item.Child[1];
  end;

  if Result = xlsOk then begin
    //second operand should be value
    Result := GetValueItem(SheetIndex, Item.Child[2], CurRow, CurCol, lOper, xlVariantValue);
  end;

  if Result = xlsOk then begin
    Result := ParseCondition(lOper, lCompCond, lCompVal);
  end;

  if Result = xlsOk then begin
    AddValue := Null;
    Result := GetValueItemRange(SheetIndex, lRange, Item.IntValue, ExcelSum, 
                                CurRow, CurCol, 
                                AddValue, RValue, 
                                lCompCond, lCompVal);
  end;

  if Result = xlsOK then Result := ConvertValue(RValue, xlNumberValue);
end;

function TXLSCalculator.CalcSumIF(SheetIndex: integer; Item: TXLSSyntaxItem; CurRow, CurCol: integer; Var RValue: Variant): integer;
Var lOper: Variant;
    lRange: TXLSSyntaxItem;
    lRange2: TXLSSyntaxItem;
    lCompCond: TXLSCompCond;
    lCompVal: Variant;
begin
  Result   := xlsOk;
  RValue   := Null;
  lRange := nil;
  lRange2 := nil;

  if not((Item.ChildCount = 2) or (Item.ChildCount = 3)) then begin
     Result := xlsErrorNA;
  end;

  if Result = xlsOk then begin
     //first operand should be range
     lRange := Item.Child[1];
  end;

  if Result = xlsOk then begin
     if Item.ChildCount = 3 then begin
       //third operand should be range
       lRange2 := Item.Child[3];
     end else begin
       lRange2 := lRange; 
     end;
  end;

  if Result = xlsOk then begin
    //second operand should be value
    Result := GetValueItem(SheetIndex, Item.Child[2], CurRow, CurCol, lOper, xlVariantValue);
  end;

  if Result = xlsOk then begin
    Result := ParseCondition(lOper, lCompCond, lCompVal);
  end;

  if Result = xlsOk then begin
    Result := GetValueItemRange2(SheetIndex, lRange, lRange2, 
                                 Item.IntValue, ExcelSum, CurRow, CurCol, 
                                 RValue, 
                                 lCompCond, lCompVal);
  end;

  if Result = xlsOK then Result := ConvertValue(RValue, xlNumberValue);
end;


function TXLSCalculator.CalcConcatenate(SheetIndex: integer; Item: TXLSSyntaxItem; CurRow, CurCol: integer; Var RValue: Variant): integer;
Var i, cnt: integer;
    Value:  Variant;
begin
  Result   := xlsOk;
  RValue   := Null;
  if Item.ChildCount > 0 then begin
     cnt := Item.ChildCount;
     for i := 1 to cnt do begin
         Result := GetValueItem(SheetIndex, Item.Child[i], CurRow, CurCol, Value, xlStringValue);
         if Result <> xlsOK then break;
         if i = 1 then 
            RValue := Value
         else 
            RValue := RValue + Value;
     end;
  end;
end;

function  TXLSCalculator.CalcNPV(SheetIndex: integer; Item:TXLSSyntaxItem;  CurRow, CurCol: integer; Var Value: Variant): integer;
var Op1: variant;
    rate: double;
    sum: double;
    f: double;
    ff: double; 
    i, cnt: integer;
    Child: TXLSSyntaxItem;
    row1, row2, col1, col2, isheet1, isheet2: integer;
    row, col, sheet: integer;
    outofusedrange: boolean;
    Val: variant;
    res: integer;
begin

  Value := Null;
  Result   := xlsOk;
  rate := 0;

  if (Item.ChildCount < 2) then begin
     Result := xlsErrorNA;
  end;

  if Result = xlsOk  then begin
    //first operand should be numberic value (rate)
     Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Op1, xlNumberValue); 
     if Result = xlsOk then begin
          rate := double(Op1);
          if rate = -1 then begin
             Result := xlsErrorDIV0;
          end;
     end; 
  end;

  if Result = xlsOk then begin
     sum := 0;
     f := 1;
     ff := 1 / (1 + rate);
     cnt := Item.ChildCount;

     for i := 2 to cnt do begin
         Child := Item.Child[i];
         res := GetRangeInfo(SheetIndex, CurRow, CurCol, Child, row1, row2, col1, col2, isheet1, isheet2);
         if res = xlsOk then begin
              //it's a range
              outofusedrange := false;
              //iterations through the range
              if Result = xlsOk then begin
                 for sheet := iSheet1 to iSheet2 do begin
                   for row := row1 to row2 do begin
                     for col := col1 to col2 do begin
                       //get cell's value 
                       Result := FGetValue(sheet, row, col, Val, outofusedrange);
                       if outofusedrange then break;

                       if Result = xlsOk then begin
                           if VarIsNumeric(Val) then begin
                              f := f * ff;
                              sum := sum + double(Val) * f;  
                           end;
                       end;
                       if Result <> xlsOk then break;
                     end;
                     if outofusedrange and (col = col1) then break;
                     if Result <> xlsOk then break; 
                   end;
                   if Result <> xlsOk then break; 
                 end;
              end;
         end else begin 
            //it isn't a range, try it as value 
            Result := GetValueItem(SheetIndex, Child, CurRow, CurCol, Val, xlVariantValue);
            if Result = xlsOk then begin
                if VarIsNumeric(Val) then begin
                   f := f * ff;
                   sum := sum + double(Val) * f;  
                end;
            end;
         end;
     end;

     if Result = xlsOk then begin
         Value := sum; 
     end;

  end; 

end;


function  TXLSCalculator.CalcSUMPRODUCT(SheetIndex: integer; Item:TXLSSyntaxItem;  CurRow, CurCol: integer; Var Value: Variant): integer;
Var aSheets: array of integer;
    aRow:    array of integer;
    aCol:    array of integer;
    lRange:  TXLSSyntaxItem;
    i:       integer;
    rowcnt, colcnt: integer;
    currowcnt, curcolcnt: integer;
    iSheet1, iSheet2: integer;
    row, col: integer;
    cursum: double;
    outofusedrange: boolean;
    Res: variant;
    row1, row2, col1, col2: integer;

begin
  Result   := xlsOk;
  rowcnt := 0;
  colcnt := 0;
  Value := 0;
 
  if Item.ChildCount > 1 then begin
     SetLength(aSheets, Item.ChildCount); 
     SetLength(aRow, Item.ChildCount); 
     SetLength(aCol, Item.ChildCount); 

     for i := 1 to Item.ChildCount do begin
        lRange := Item.Child[i];

        Result := GetRangeInfo(SheetIndex, CurRow, CurCol, lRange, 
                     row1, row2, col1, col2, isheet1, isheet2);

        if Result <> xlsOk then break;

        aRow[i - 1] := row1;  
        aCol[i - 1] := col1;  
        currowcnt := row2 - row1 + 1;
        curcolcnt := col2 - col1 + 1;

        if iSheet1 <> iSheet2 then Result := xlsErrorValue;
    
        if Result = xlsOk then begin
           aSheets[i - 1] := iSheet1;
           if i = 1 then begin
              rowcnt := currowcnt;
              colcnt := curcolcnt;
           end else begin
              if (rowcnt <> currowcnt) or (colcnt <> curcolcnt) then begin
                 Result := xlsErrorValue; 
              end;
           end;
        end else begin
           break;  
        end;
     end;

     //iterate cells
     if Result = xlsOk then begin
        outofusedrange := false; 

        for row := 0 to rowcnt - 1 do begin
          for col := 0 to colcnt - 1 do begin
             cursum := 0;
             for i := 0 to Item.ChildCount - 1 do begin

               //get cell's value 
               Result := FGetValue(aSheets[i],  aRow[i] + row, aCol[i] + col, Res, outofusedrange);

               if outofusedrange then begin
                  cursum := 0;
                  break;
               end;

               if Result = xlsOk then begin
                  if VarIsNumeric(Res) then begin

                     if i = 0 then cursum := double(Res)
                     else cursum := cursum * double(Res);
                  end else begin
                     cursum := 0; 
                  end;
               end;

               if (cursum = 0) or (Result <> xlsOk) then break; 
             end;


             if Result = xlsOk then begin
                Value := Value + cursum;
             end else begin
                break;
             end; 

          end;
          if Result <> xlsOk then break;
        end;
     end;
  end else begin
     Result := xlsErrorNA;
  end; 
end;

function TXLSCalculator.ItemIsRange(Item: TXLSSyntaxItem): boolean;
begin
   while Item.ItemType = SA_GROUP do 
      Item := Item.Child[1];
   Result := (Item.ItemType = SA_RANGE) or (Item.ItemType = SA_NAME);
end;

function TXLSCalculator.GetValueItemNR(SheetIndex: integer; Item: TXLSSyntaxItem; Func:Integer; Proc:TXLSProcessFunc; CurRow, CurCol: integer; Var RValue: Variant): integer;
Var i: integer;
    Res: Variant;
    AddValue: Variant;
    Child: TXLSSyntaxItem;
begin
  Result   := xlsOk;
  RValue   := Null;
  Res      := Null;
  AddValue := Null;
  if Item.ChildCount > 0 then begin
     //iteration throught all operands
     for i := 1 to Item.ChildCount do begin
       Child := Item.Child[i];
       if ItemIsRange(Child) then begin
          Result := GetValueItemRange(SheetIndex, Child, Func, Proc, CurRow, CurCol, AddValue, RValue)
       end else begin 
          Result := GetValueItem(SheetIndex, Child, CurRow, CurCol, Res, xlVariantValue);
          if Result = xlsOK then Result := Proc(Func, Res, AddValue, RValue); 
       end;

       if Result <> xlsOK then break;
     end;
  end; 
  if Result = xlsOK then Result := ConvertValue(RValue, xlNumberValue);
end;

function TXLSCalculator.GetValueItem3A(SheetIndex: integer; Item: TXLSSyntaxItem; Func:Integer; CurRow, CurCol: integer; Var RValue: Variant; RetClass: integer): integer;
Var Res: Variant;
    v1, v2, v3: variant;
    a1, a2, a3: integer;
    s1: widestring;
begin
  case Func of
    1{IF}:
        begin
          Result   := xlsOK;
          RValue   := Null;
          Res      := Null;
          if (Item.ChildCount < 2) or (Item.ChildCount > 3) then Result := xlsErrorValue; //!!!
          if Result = xlsOK then Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Res, xlBooleanValue);
          if Result = xlsOK then begin
             if Res then Result := GetValueItem(SheetIndex, Item.Child[2], CurRow, CurCol, RValue, xlVariantValue, RetClass)
                    else begin
                         if Item.ChildCount = 3 then begin
                            Result := GetValueItem(SheetIndex, Item.Child[3], CurRow, CurCol, RValue, xlVariantValue, RetClass);
                         end else begin
                            RValue := false;
                         end; 
                    end;
          end;  
        end;
     65{Date}:
        begin
          Result   := xlsOK;
          RValue := Null;
          if Result = xlsOk then
             Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, v1, xlNumberValue); 
          if Result = xlsOk then
             Result := GetValueItem(SheetIndex, Item.Child[2], CurRow, CurCol, v2, xlNumberValue); 
          if Result = xlsOk then
             Result := GetValueItem(SheetIndex, Item.Child[3], CurRow, CurCol, v3, xlNumberValue); 
          a1 := 0; a2 := 0; a3 := 0;
          if Result = xlsOk then begin
             try
                a1 := integer(v1);
                a2 := integer(v2);
                a3 := integer(v3);
             except
               on E:Exception do begin
                  Result := xlsErrorValue;
               end; 
             end;
          end;

          if Result = xlsOk then begin
             if a1 < 1900 then a1 := a1 + 1900; 
             try
                RValue := VarFromDateTime(EncodeDate(a1, a2, a3));
             except
               on E:Exception do begin
                  Result := xlsErrorValue;
               end; 
             end; 
          end;
        end; 
     31{Mid}:
        begin
          Result   := xlsOK;
          RValue := Null;
          if Result = xlsOk then
             Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, v1, xlStringValue); 
          if Result = xlsOk then
             Result := GetValueItem(SheetIndex, Item.Child[2], CurRow, CurCol, v2, xlNumberValue); 
          if Result = xlsOk then
             Result := GetValueItem(SheetIndex, Item.Child[3], CurRow, CurCol, v3, xlNumberValue); 
          s1 := ''; a2 := 0; a3 := 0;
          if Result = xlsOk then begin
             try
                s1 := widestring(v1);
                a2 := integer(v2);
                a3 := integer(v3);
             except
               on E:Exception do begin
                  Result := xlsErrorValue;
               end; 
             end;
          end;

          if Result = xlsOk then begin
             RValue := System.Copy(s1, a2, a3);
          end;
        end; 
    else  
        Result := xlsErrorNotSupported;
  end;
end;


function TXLSCalculator.GetValueItem(SheetIndex: integer; Item: TXLSSyntaxItem; CurRow, CurCol: integer; Var Value: Variant; ValueType: TXLSRetValueType): integer;
begin
  Result := GetValueItem(SheetIndex, Item, CurRow, CurCol, Value, ValueType, 1);
end;

function TXLSCalculator.GetValueItem(SheetIndex: integer; Item: TXLSSyntaxItem; CurRow, CurCol: integer; Var Value: Variant; ValueType: TXLSRetValueType; RetClass: integer): integer;
Var lItemType: integer;
    SubValue: Variant;
    r: ICalcRangeList;
    d1, d2, res: double;
begin
  Result := xlsOK;
  if not(Assigned(Item)) then Result := xlsErrorOther;
  if Result = 1 then begin
     lItemType := item.ItemType;
     case lItemType of

        SA_NUMBER: begin
                     Value := Item.DecValue;
                     Result := ConvertValue(Value, ValueType);
                   end;

        SA_BOOL: begin
                     Value := (Item.IntValue = 1);
                     Result := ConvertValue(Value, ValueType);
                 end;

        SA_RANGE:  begin
                     if (RetClass <> 1) and (ValueType = xlVariantValue) then begin
                         Result :=  GetRange(SheetIndex, CurRow, CurCol, Item, r);
                         if Result = xlsOK then Value := r;
                     end else begin
                         Result := GetValueItemRange(SheetIndex, Item, CurRow, CurCol, Value);
                         if Result = xlsOK then 
                            Result := ConvertValue(Value, ValueType);
                     end;
                   end;

        SA_NAME:  begin
                     if (RetClass <> 1) and (ValueType = xlVariantValue) then begin
                         Result :=  GetNameRange(SheetIndex, CurRow, CurCol, Item, r);
                         if Result = xlsOK then Value := r;
                     end else begin
                         Result := GetValueItemRange(SheetIndex, Item, CurRow, CurCol, Value);
                         if Result = xlsOK then 
                            Result := ConvertValue(Value, ValueType);
                     end;
                   end;

        SA_FUNC:   Result := GetValueItemFunc(SheetIndex, Item, CurRow, CurCol, Value, ValueType, RetClass);

        SA_STRING: begin
                     Value := Item.Value;
                     Result := ConvertValue(Value, ValueType);
                   end;

        SA_GROUP: Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Value, ValueType, RetClass);

        SA_UNARMINUS, SA_PERCENT:
           begin
             Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Value, xlNumberValue);
             if Result = xlsOK then begin
                case  lItemType of
                    SA_UNARMINUS: Value := -Value;
                    SA_PERCENT:   Value := Value/100;
                end;
             end;
             if Result = xlsOK then begin
                Result := ConvertValue(Value, ValueType);
             end;
           end;

        SA_UNARPLUS:  
           begin
             Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Value, xlVariantValue);
             if Result = xlsOK then begin
                 if (ValueType = xlVariantValue) then begin
                    if VarIsNull(Value) then Value := 0;
                 end else begin
                    Result := ConvertValue(Value, ValueType);
                 end;
             end;
           end;

        SA_CONCAT:
           begin
             Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Value, xlStringValue);
             if Result = xlsOK then begin
	        Result := GetValueItem(SheetIndex, Item.Child[2], CurRow, CurCol, SubValue, xlStringValue);
             end;  
             if Result = xlsOK then begin
                Value := Value + SubValue;
             end;
             if Result = xlsOK then begin
                Result := ConvertValue(Value, ValueType);
             end;
           end;
        SA_LT, SA_GT,  SA_LE,  SA_GE,  SA_EQ,  SA_NE:
           begin

             Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Value, xlVariantValue);
             if Result = xlsOk then begin
	        Result := GetValueItem(SheetIndex, Item.Child[2], CurRow, CurCol, SubValue, xlVariantValue);
	     end;

             if Result = xlsOk then begin
                Result := CompareVarValues(lItemType, Value, SubValue);
             end;

             {
             Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Value, xlVariantValue);
             vType := xlVariantValue;
             if Result = xlsOK then begin
                vType := GetRetValueType(Value);
                Result := ConvertValue(Value, vType);  
             end;
    
             if Result = xlsOK then begin
	        Result := GetValueItem(SheetIndex, Item.Child[2], CurRow, CurCol, SubValue, vType);
             end;  

             if Result = xlsOK then begin
                case lItemType of                        
                  SA_LT:       Value := (Value < SubValue);
                  SA_LE:       Value := (Value <= SubValue);
                  SA_EQ:       Value := (Value = SubValue);
                  SA_GE:       Value := (Value >= SubValue);
                  SA_GT:       Value := (Value > SubValue);
                  SA_NE:       Value := (Value <> SubValue);
                  else Result := xlsErrorOther;
                end;  
             end;
             } 
             if Result = xlsOK then begin
                Result := ConvertValue(Value, ValueType);
             end;           
           end;

        SA_MUL, SA_DIV, SA_ADD, SA_SUB, SA_POWER: 
           begin
             Result := GetValueItem(SheetIndex, Item.Child[1], CurRow, CurCol, Value, xlNumberValue);
             if Result = xlsOK then begin
	        Result := GetValueItem(SheetIndex, Item.Child[2], CurRow, CurCol, SubValue, xlNumberValue);
             end;  
             if Result = xlsOK then begin
                case lItemType of                        
                  SA_ADD: begin 
                            if not(Assigned(Item.Parent)) then begin
                                {top level}
                                d1 := Value;
                                d2 := SubValue;
                                res := d1 + d2;
                                if (res <> 0) and (res < 1) and (res > -1) then begin
                                   if (get_exponent(d1) - get_exponent(res)) > 49 then
                                       res := 0;    
                                end;
                                Value := res; 
                            end else begin
                                Value := Value + SubValue; 
                            end;
                          end;
                  SA_SUB: begin
                            if not(Assigned(Item.Parent)) then begin
                                {top level}
                                d1 := Value;
                                d2 := SubValue;
                                res := d1 - d2;
                                if (res <> 0) and (res < 1) and (res > -1) then begin
                                   if (get_exponent(d1) - get_exponent(res)) > 49 then
                                       res := 0;    
                                end;
                                Value := res; 
                            end else begin
                                Value := Value - SubValue; 
                            end;
                          end;

                  SA_MUL:      begin {w riteln(Value,'*',SubValue,'=',Value * SubValue);} Value := Value * SubValue; end;
                  SA_DIV:      begin 
                                 try
                                   {w riteln(Value,'/',SubValue,'=',Value / SubValue);} 
                                   if SubValue = 0 then begin
                                      Result := xlsErrorDIV0;
                                   end else begin
                                      Value := Value / SubValue; 
                                   end;
                                 except
                                   on E:Exception do begin
                                      Result := xlsErrorDIV0; 
                                   end; 
                                 end; 
                               end;
                  SA_POWER:    begin Value := Power(Value, SubValue); end;
                  else Result := xlsErrorOther;
                end;  
             end;
             if Result = xlsOK then begin
                Result := ConvertValue(Value, ValueType);
             end;
           end;

        else Result := xlsErrorOther;
     end;
  end;
end;

function TXLSCalculator.CompareVariants(value1: variant; value2: variant): integer;
Var
   vType1: TXLSRetValueType; 
   vType2: TXLSRetValueType; 
   isnull1, isnull2: boolean;
begin
  isnull1 := VarIsNull(value1);
  isnull2 := VarIsNull(value2);

  if isnull1 and isnull2 then begin
        Result := 0;
     end else begin
     vType1 := GetRetValueType(value1); 
     vType2 := GetRetValueType(value2);

     if isnull1 and not(isnull2) then begin
        ConvertValue(value1, vType2);  
     end else if isnull2 and not(isnull1) then begin
        ConvertValue(value2, vType1);  
        end;  

        if vType1 = vType2 then begin
           case vType1 of
               xlBooleanValue: 
                   begin
                      if Value1 = Value2 then begin
                         Result := 0;
                      end else if Value1 then begin
                         Result := 1;
                      end else begin
                         Result := -1;
                   end;
                end;
                xlNumberValue: 
                   begin
                      if Value1 = Value2 then begin
                         Result := 0;
                      end else if Value1 > Value2 then begin
                         Result := 1;
                      end else begin
                         Result := -1;
                   end;
                end;
               xlStringValue: 
                   begin
                      Value1 := xlsUpperCase(Value1);
                      Value2 := xlsUpperCase(Value2);
                      if Value1 = Value2 then begin
                         Result := 0;
                      end else if Value1 > Value2 then begin
                         Result := 1;
                      end else begin
                         Result := -1;
                      end;
                   end;
           else 
              Result := 0
           end;
        end else begin
            Value1 := Ord(vType1);
            Value2 := Ord(vType2);
            if Value1 = Value2 then begin
               Result := 0;
            end else if Value1 > Value2 then begin
               Result := 1;
            end else begin
               Result := -1;
            end;
        end;  
     end;
  end;

function TXLSCalculator.CompareVarValues(Operation: integer; Var Value: Variant; Value2: Variant): integer;
Var
   res: integer;
begin
  Result := xlsOk;
  res := CompareVariants(Value, Value2);
  case Operation of                        
    SA_LT:       Value := res < 0;
    SA_LE:       Value := res <= 0;
    SA_EQ:       Value := res = 0;
    SA_GE:       Value := res >= 0;
    SA_GT:       Value := res > 0;
    SA_NE:       Value := res <> 0;
    else Result := xlsErrorOther;
  end;  
end;

function TXLSCalculator.GetFormulaFuncItem(Item: TXLSSyntaxItem; CurRow, CurCol, CurSheetID: integer; Formula: TWideStringBuilder): integer;
Var lArgsCnt: integer;
    i: integer;
    sval: widestring;
    start_pos: integer;
    isextra: boolean;
begin
  Result := 1;
  lArgsCnt := Item.ChildCount;
  if Item.IntValue = 255 then begin
     start_pos := 2;
     isextra := true;
  end else begin
     start_pos := 1;
     isextra := false;
  end;
   
  if isextra then begin
     sval := FExtern.GetExtraFuncName(Item.Child[1].Range.FExternID, Item.Child[1].IntValue);
  end else begin
     sval := FFormula.FuncNamebyPtg[Item.IntValue];
  end;

  if sval = '' then begin
     Result := -1; 
  end else begin
     Formula.AddString(sval);
     Formula.Add('(');
  end;

  if Result = 1 then begin
     if lArgsCnt > 0 then begin
        for i := start_pos to lArgsCnt do begin
           if i > start_pos then Formula.Add(FListSeparator);
           Result := GetFormulaItem(Item.Child[i], CurRow, CurCol, CurSheetID, Formula);
           if Result <> 1 then break;
        end;
     end;
  end;

  if Result = 1 then begin
     Formula.Add(')'); 
  end;

end;


function TXLSCalculator.GetFormulaRangeItem(Range: TXLSRangeItem; CurRow, CurCol: integer; Formula: TWideStringBuilder): integer;
Var SheetNames: WideString;
    RangeName: WideString;
//    RangeName2: WideString;
    lErrRef: boolean;
    r1, c1: integer; 
    r2, c2: integer; 
begin
  Result := 1;
  RangeName := '';  
  lErrRef := false;
  case Range.FRangeType of
     Ref2D, Ref3D, Range2D, Range3D:
       begin
          r1 := Range.FFirstRow;
          c1 := Range.FFirstCol;
          if Range.FRelative and not(Range.FFirstRowRel) then r1 := r1 + CurRow;
          if Range.FRelative and not(Range.FFirstColRel) then c1 := c1 + CurCol;

         //Ref or Range name
         if (Range.FRangeType = Ref2D) or 
            (Range.FRangeType = Ref3D) then begin
            RangeName := EncodeCellRef(r1, c1, Range.FFirstRowRel, Range.FFirstColRel);
            if RangeName = '' then lErrRef := true;
         end else begin
            r2 := Range.FLastRow;
            c2 := Range.FLastCol;
            if Range.FRelative and not(Range.FLastRowRel) then r2 := r2 + CurRow;
            if Range.FRelative and not(Range.FLastColRel) then c2 := c2 + CurCol;
            RangeName := EncodeRange(r1, c1, Range.FFirstRowRel, Range.FFirstColRel,
                                     r2, c2, Range.FLastRowRel, Range.FLastColRel); 
            if RangeName = '' then lErrRef := true;
         end;
       end;
     Ref2DErr, Ref3DErr, Range2DErr, Range3DErr:
       begin
         lErrRef := true; 
       end;
  end; 

  //Sheet or Sheets name
  if not(lErrRef) then begin
    if (Range.FRangeType = Ref3D) or (Range.FRangeType = Range3D) then begin
       Result := FExtern.GetSheetNames(Range.FExternID, SheetNames);
       if Result = 1 then begin
          Formula.AddString(SheetNames);
          Formula.Add('!');
       end;
    end;
  end;

  if (Result = 1) and not(lErrRef) then begin
      Formula.AddString(RangeName);
  end else begin
      Formula.AddString('#REF!');
  end;
end;

function TXLSCalculator.GetFormulaItem(Item: TXLSSyntaxItem; CurRow, CurCol, CurSheetID: integer; Formula: TWideStringBuilder): integer;
Var lItemType: integer;
    SubValue: WideString;
begin
  Result := 1;
  if not(Assigned(Item)) then Result := -1;
  if Result = 1 then begin
     lItemType := item.ItemType;
     case lItemType of
        SA_NUMBER: Formula.AddString(xlsfloattostr(Item.DecValue, FDecimalSeparator));
        SA_BOOL:   if Item.IntValue = 1 then Formula.AddString('TRUE') else Formula.AddString('FALSE');
        SA_RANGE:  Result := GetFormulaRangeItem(Item.Range, CurRow, CurCol, Formula);       
        SA_FUNC:   Result := GetFormulaFuncItem(Item, CurRow, CurCol, CurSheetID, Formula);
        SA_STRING: begin
                     Formula.Add('"');
                     Formula.AddString(StringReplace(Item.Value, '"', '""', [rfReplaceAll]));
                     Formula.Add('"');
                   end;
        SA_GROUP, SA_UNARMINUS, SA_UNARPLUS, SA_PERCENT:
           begin
             case lItemType of
               SA_GROUP:     Formula.Add('(');
               SA_UNARMINUS: Formula.Add('-');
               SA_UNARPLUS:  Formula.Add('+');
             end;  
             Result := GetFormulaItem(Item.Child[1], CurRow, CurCol, CurSheetID, Formula);
             if Result = 1 then begin
                case lItemType of
                  SA_GROUP:     Formula.Add(')');
                  SA_PERCENT:   Formula.Add('%');
                end;  
             end;
           end;
        SA_MUL, SA_DIV, SA_ADD, SA_SUB, SA_LT, 
        SA_GT,  SA_LE,  SA_GE,  SA_EQ,  SA_NE, SA_CONCAT, SA_POWER:
           begin
             Result := GetFormulaItem(Item.Child[1], CurRow, CurCol, CurSheetID, Formula);

             if Result = 1 then begin
                case lItemType of                        
                  SA_ADD:      Formula.Add('+');
                  SA_SUB:      Formula.Add('-');
                  SA_MUL:      Formula.Add('*');
                  SA_DIV:      Formula.Add('/');
                  SA_POWER:    Formula.Add('^');
                  SA_CONCAT:   Formula.Add('&');
                  SA_LT:       Formula.Add('<');
                  SA_LE:       Formula.AddString('<=');
                  SA_EQ:       Formula.AddString('=');
                  SA_GE:       Formula.AddString('>=');
                  SA_GT:       Formula.AddString('>');
                  SA_NE:       Formula.AddString('<>');
                  else Result := -1;
                end;  
             end;

             if Result = 1 then begin
	        Result := GetFormulaItem(Item.Child[2], CurRow, CurCol, CurSheetID, Formula);
             end;  

           end;
        SA_NAME:
           begin
             //Sheet or Sheets name
             if Assigned(Item.Range) then begin
               if (Item.Range.FExternID > 0) then begin
                  Result := FExtern.GetSheetNames(Item.Range.FExternID, SubValue);
                  if Result = 1 then begin
                     Formula.AddString(SubValue);
                     Formula.Add('!') ;
                  end;
               end;
             end;
             if Result = 1 then begin
                SubValue := FExtern.GetNameByID(Item.IntValue);
                if SubValue = '' then begin
                   SubValue := 'NAME!'
                end;
                Formula.AddString(SubValue);
             end;
           end;
        else Result := -1;
     end;
  end;
end;

function TXLSCalculator.GetCompiledFormula(UncompiledFormula: widestring; SheetID: integer): TXLSCompiledFormula;
Var lTree: TXLSSyntaxItem;
begin
  lTree := FFormula.GetCompiled(UncompiledFormula, SheetID);
  if Assigned(lTree) then
     Result := TXLSCompiledFormula.Create(lTree, nil {!!!!!!!!}) 
  else 
     Result := nil;
end;

function TXLSCalculator.GetTranslatedFormula(Data: TXLSBlob; Offset: longword; FormulaSize: longword; BiffVer: Word): TXLSCompiledFormula;
Var lTree: TXLSSyntaxItem;
    lExData: TXLSFormulatArrays; 
    lRet: integer; 
    lStartOffset: longword;
begin
  lExData := nil;                                   
  lStartOffset := Offset;
  lTree := FFormula.GetTranslated(Data, Offset, FormulaSize, BiffVer);
  if Assigned(lTree) then begin
     
     if (Offset - lStartOffset) < FormulaSize then begin
        //external data
        lExData := TXLSFormulatArrays.Create;
        lRet := lExData.Parse(Data, Offset, BiffVer);
        if lRet <> 1 then begin
           lExData.Free;
           lExData := nil; 
        end; 
     end;

     Result := TXLSCompiledFormula.Create(lTree, lExData);
  end else begin
     Result := nil;
  end;
end;

function TXLSCalculator.GetTranslatedFormula(Data: TXLSBlob; Offset: longword; BiffVer: Word): TXLSCompiledFormula;
Var lTree: TXLSSyntaxItem;
    lExData: TXLSFormulatArrays; 
    lRet: integer; 
begin
  lExData := nil; 
  lTree := FFormula.GetTranslated(Data, Offset, BiffVer);
  if Assigned(lTree) then begin
     
     if Data.DataLength > Offset then begin
        //external data
        lExData := TXLSFormulatArrays.Create;
        lRet := lExData.Parse(Data, Offset, BiffVer);
        if lRet <> 1 then begin
           lExData.Free;
           lExData := nil; 
        end; 
     end;

     Result := TXLSCompiledFormula.Create(lTree, lExData);
  end else begin
     Result := nil;
  end;
end;

function TXLSCalculator.GetUnCompiledFormula(CompiledFormula: TXLSCompiledFormula; CurRow, CurCol, CurSheetID: integer): widestring;
Var isArrayFormula: boolean;
begin
  FStrBuilder.Clear;
  isArrayFormula := CompiledFormula.IsArrayFormula;
  if isArrayFormula then FStrBuilder.Add('{');
  FStrBuilder.Add('=');

  if isArrayFormula then begin
     if not(CompiledFormula.ArrayFormula.IsRootFormula) then begin
        CompiledFormula := CompiledFormula.ArrayFormula.RootFormula;
        CurRow := CompiledFormula.ArrayFormula.RootRow;
        CurCol := CompiledFormula.ArrayFormula.RootCol;
     end;  
  end;
  if GetFormulaItem(CompiledFormula.FTree, CurRow, CurCol, CurSheetID, FStrBuilder) = 1 then  begin
     if isArrayFormula then FStrBuilder.Add('}');
     Result := FStrBuilder.Value; 
  end else begin
     Result := '';
  end;
end;

procedure TXLSCalculator.SetFileFormat(aFileFormat: integer);
begin
  FFormula.FFileFormat := aFileFormat;
end;

function TXLSCalculator.GetFileFormat: integer;
begin
  Result := FFormula.FFileFormat;
end;

function TXLSCalculator.GetArrayFormulaData(CompiledFormula: TXLSCompiledFormula; ACurSheetID: integer; Var AData: TXLSBlob): integer;
var lData: TXLSBlob;
    lArrF: TXLSArrayFormula;
begin
  lArrF := CompiledFormula.ArrayFormula;
  AData := TXLSBlob.Create(12);
  AData.AddWord(lArrF.FirstRow);
  AData.AddWord(lArrF.LastRow);
  AData.AddByte(lArrF.FirstCol);
  AData.AddByte(lArrF.LastCol);
  AData.AddWord($0002); //option flag
  AData.AddLong(0); //Not used
  Result := GetFormulaData(CompiledFormula, lData, 
                           lArrF.RootRow, lArrF.RootCol, ACurSheetID, 2);
  if Result = 1 then begin
     AData.Add(lData);
     lData.Free; 
  end else begin
     AData.Free;
     AData := nil;
  end;
end;

function TXLSCalculator.GetFormulaData(CompiledFormula: TXLSCompiledFormula; Var lData: TXLSBlob; CurRow, CurCol, CurSheetID: integer; aClass: integer): integer;
var lExtData: TXLSBlob;
begin
  Result := FFormula.GetStoreDataExt(CompiledFormula.FTree, lData, CurRow, CurCol, CurSheetID, aClass);
  if Result = 1 then begin
     if CompiledFormula.IsExternalData then begin
        Result := CompiledFormula.GetExternalData(lExtData, FileFormat);  
        if Result = 1 then begin
           if Assigned(lExtData) then begin
              lData.Add(lExtData);
              lExtData.Free;           
           end;   
        end else begin
           lData.Free;
           lData := nil; 
        end;
     end;  
  end;
end;

function TXLSCalculator.GetStoreData(CompiledFormula: TXLSCompiledFormula; Var lData: TXLSBlob; CurRow, CurCol, CurSheetID: integer): integer;
begin
  if CompiledFormula.IsArrayFormula then begin
     lData := TXLSBlob.Create(2 + 5);
     lData.AddWord(5); //Length
     lData.AddByte(1); //tExp
     lData.AddWord(CompiledFormula.ArrayFormula.RootRow); //Row
     lData.AddWord(CompiledFormula.ArrayFormula.RootCol); //Col
     Result := 1;
  end else begin
     Result := GetFormulaData(CompiledFormula, lData, CurRow, CurCol, CurSheetID, 1);
  end;
end;

function TXLSCalculator.GetStoreDataExt(CompiledFormula: TXLSCompiledFormula; Var lData: TXLSBlob; CurRow, CurCol, CurSheetID: integer; aClass: integer): integer;
var lExtData: TXLSBlob;
begin
  Result := FFormula.GetStoreDataExt(CompiledFormula.FTree, lData, CurRow, CurCol, CurSheetID, aClass);
  if Result = 1 then begin
     if CompiledFormula.IsExternalData then begin
        Result := CompiledFormula.GetExternalData(lExtData, FileFormat);  
        if Result = 1 then begin
           if Assigned(lExtData) then begin
              lData.Add(lExtData);
           end;   
        end else begin
           lData.Free;
           lData := nil; 
        end;
     end;  
  end;
end;

procedure TXLSCalculator.SetMode(AMode: Char);
begin
   FFormula.SetMode(AMode);
end;

procedure TXLSCalculator.Set2007Settings;
begin
  FStoredDecimalSeparator :=  FDecimalSeparator;
  FStoredListSeparator := FListSeparator;
  FListSeparator := ',';
  FDecimalSeparator := '.';
  FFormula.ListSeparator := FListSeparator;
  FFormula.DecimalSeparator := FDecimalSeparator;
end;

procedure TXLSCalculator.RestoreSettings;
begin
  FDecimalSeparator :=  FStoredDecimalSeparator;
  FListSeparator := FStoredListSeparator;
  FFormula.ListSeparator := FListSeparator;
  FFormula.DecimalSeparator := FDecimalSeparator;
end;


end.
