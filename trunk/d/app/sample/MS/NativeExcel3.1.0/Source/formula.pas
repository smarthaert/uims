//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         formula
//
//
//      Description:  Lexical and syntax analysis, compilation of Excel formula
//                    TXLSLexer  - Lexical analysis 
//                    TXLSSyntax - Syntax analysis 
//                    TXLSFormula - Formula compiler 
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

unit formula;

{$I xlsdef.inc}

{$Q-}
{$R-}

interface

uses
  SysUtils, Classes, xlshash, xlsBlob, xlsExtern, xlsstrb;

const
//Type of syntax element
 SA_RANGE         = 1;
 SA_NUMBER        = 2;
 SA_STRING        = 3;
 SA_EXPRLIST      = 4;
 SA_GROUP         = 5;
 SA_BOOL          = 6;
 SA_ARRAY         = 7;

 SA_UNARMINUS     = 1000;
 SA_UNARPLUS      = 1001;
 SA_MUL           = 1002;
 SA_DIV           = 1003;
 SA_ADD           = 1004;
 SA_SUB           = 1005;
 SA_CONCAT        = 1006;
 SA_EQ            = 1007;
 SA_NE            = 1008;
 SA_GT            = 1009;
 SA_LT            = 1010;
 SA_GE            = 1011;
 SA_LE            = 1012;
 SA_POWER         = 1013;
 SA_PERCENT       = 1014;
 SA_LIST          = 1015;
 SA_FUNC          = 2000;
 SA_MEMFUNC       = 2001;
 SA_NAME          = 2002;

{Range Types}
 REF2D            = 1;
 REF3D            = 2;
 RANGE2D          = 3;
 RANGE3D          = 4; 
 RANGEERROR       = 8;
 REF2DERR         = REF2D + RANGEERROR;
 REF3DERR         = REF3D + RANGEERROR;
 RANGE2DERR       = RANGE2D + RANGEERROR;
 RANGE3DERR       = RANGE3D + RANGEERROR; 

type

//  TGetSheetIndex     = procedure (SheetName: widestring; Var SheetIndex: integer) of object;
//  TGetSheetIDByName  = procedure (SheetName: widestring; Var SheetID: integer) of object;
//  TGetSheetIndexByID = procedure (SheetID: integer; Var SheetIndex: integer) of object;

  THashFuncEntry = class (THashEntry)
  public
    FPtg:      integer;
    FArgsCnt:  integer;
    FRetClass: integer;
    FClass:    integer;
    FVol:      integer;   
    FArgClass: array of byte;
    FArgClassLen: smallint;
    function GetArgClass(ArgNo: integer): byte;
    property ArgClass[Index: integer]: byte read GetArgClass;
  end;

  THashFunc = class(THash)
  protected
    function  CreateEntry: THashEntry; override;
  private
    FExtraPack: THashFunc;
    FPtgHash: THashWideString;
    procedure SetValue(aFuncName: WideString; aPtg, aRetClass, aArgsCnt, aClass, aVol: integer); overload;
    procedure SetValue(aFuncName: WideString; aPtg, aRetClass, aArgsCnt, aClass, aVol: integer; ArgsClass: string); overload;
    function  GetValue(aFuncName: WideString): THashFuncEntry;
    function  GetName(aPtg: integer): WideString;
    function  GetArgsCnt(aPtg: integer): integer;
  public
    property  Values[Key: WideString]: THashFuncEntry read GetValue; default;
    property  FuncName[aPtg: integer]: WideString read GetName;
    property  ArgsCnt[aPtg: integer]: integer read GetArgsCnt;
    constructor Create;
    destructor Destroy; override;
    procedure SetExtraPack(extrapack: THashFunc);
    function GetExtraFunctionPtg(Name: String): integer;
    function GetExtraFunctionEntry(Name: String): THashFuncEntry;
  end;

  TXLSToken = class
  private
    FTokenType: integer;
    FValue:     widestring;
//    FNext:      TXLSToken;
//    FPrev:      TXLSToken;
  public
    constructor Create;
//    destructor Destroy; override;
    property Value: widestring read FValue write FValue;
    property TokenType: integer read FTokenType write FTokenType;
//    property Next: TXLSToken read FNext write FNext;
//    property Prev: TXLSToken read FPrev write FPrev;
  end;

  TXLSTokens = class
  private
    FArr: array of TXLSToken;
    FArrSize: integer;

    FCur: integer;

//    FFirst: TXLSToken;
//    FLast: TXLSToken;
//    FCurrent: TXLSToken;

    FEOF: boolean;
    FCount: integer;

    function GetTokenType:  integer;
    function GetTokenValue: widestring;
    function GetToken(offset: integer): TXLSToken;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure  Next;
    procedure  Prev;
    procedure  GoToFirst;
    procedure AddToken(ATokenType: integer; AValue: widestring);
    property isEOF: boolean read FEof;
    property Count: integer read FCount;
    property TokenType: integer read GetTokenType;
    property TokenValue: widestring read GetTokenValue;
    property Item[offset: integer]: TXLSToken read GetToken; default;
  end;


  TXLSLexer = class
  private
    FSource: widestring;
    FSourcePos: integer;
    FSourceLen: integer;
    FDecimalSeparator: widechar;
    FListSeparator: widechar;
    FTokens: TXLSTokens;
    FValue: TWideStringBuilder;
    function GetSymbol(Offset: integer): widechar;
    function GetEof: boolean;
    procedure SetSource(Value: widestring);
    procedure AddToken(ATokenType: integer; AValue: widestring);
    procedure AddSymbolToken(ATokenType: integer);
  public
    constructor Create;
    procedure Clear;
    destructor Destroy; override;
    procedure  Next;
    property   Source: widestring read FSource write SetSource;
    property   Symbol[Offset: integer]: widechar read GetSymbol;
    property   Eof: boolean read GetEof;
    function   Analyse: integer;
  end;

 TXLSRangeItem = class
 public
     FFirstRow:    integer;
     FFirstRowRel: boolean;

     FLastRow:     integer;
     FLastRowRel:  boolean;

     FFirstCol:    integer;
     FFirstColRel: boolean;

     FLastCol:     integer;
     FLastColRel:  boolean;

     FRangeType:   integer;
     FExternID:    integer;
     FRelative:    boolean;
//     FSheet1Id:    integer;
//     FSheet2Id:    integer;
     function CopyObject(DeltaRow, DeltaCol: integer): TXLSRangeItem; overload;
     function CopyObject(row1, col1, row2, col2, drow, dcol: integer): TXLSRangeItem; overload;
 end;

 {$HPPEMIT 'class DELPHICLASS TXLSSyntaxItem;'}

 TXLSSyntaxItem = class
   private
     FItemType:   integer;
     FValue:      widestring;
     FDecValue:   double;
     FIntValue:   integer;
     FChildCount: integer;
     FRangeValue: TXLSRangeItem;
     FChild: array of TXLSSyntaxItem;
     FParent: TXLSSyntaxItem;
     function GetChild(Index: integer):TXLSSyntaxItem;
   public
     constructor Create;
     destructor Destroy; override;
     function CopyObject(DeltaRow, DeltaCol: integer): TXLSSyntaxItem; overload;
     function CopyObject(row1, col1, row2, col2, drow, dcol: integer): TXLSSyntaxItem; overload;
     procedure AddChild(Item: TXLSSyntaxItem);
     procedure PushChild(Item: TXLSSyntaxItem);
     property Range: TXLSRangeItem read FRangeValue  write FRangeValue;
     property ItemType:   integer  read FItemType    write FItemType;
     property Value:      widestring   read FValue       write FValue;
     property DecValue:   double   read FDecValue    write FDecValue;
     property IntValue:   integer  read FIntValue    write FIntValue;
     property ChildCount: integer  read FChildCount;
     property Child[Index: integer]: TXLSSyntaxItem read GetChild;
     property Parent: TXLSSyntaxItem read FParent; 
 end;

 TXLSSyntaxStack = class
 private
    FItems: array of TXLSSyntaxItem;
    FCount: integer;
    FMaxCount: integer;
 public
   constructor Create;
   destructor Destroy; override;
   function Pop: TXLSSyntaxItem;
   procedure Push(Value: TXLSSyntaxItem);
   property Count: integer read FCount;
 end;

 TXLSSyntax = class
  private
    FTokens: TXLSTokens;
    FDecimalSeparator: char;
    FSyntaxTree: TXLSSyntaxItem;
    FFuncs: THashFunc;
    FExtern: TXLSExternSheet;
    FCurSheetID: integer;
//    FGetSheetIDByName: TGetSheetIDByName;
    function    Parse_expr(Var Item: TXLSSyntaxItem): integer;
    function    Parse_expr1(Var Item: TXLSSyntaxItem): integer;
    function    Parse_expr0(Var Item: TXLSSyntaxItem): integer;
    function    Parse_operand(Var Item: TXLSSyntaxItem): integer;
    function    Parse_operand1(Var Item: TXLSSyntaxItem): integer;
    function    Parse_operand2(Var Item: TXLSSyntaxItem): integer;
    function    Parse_exprlist(Var Item: TXLSSyntaxItem): integer;
    function    Parse_range(Item: TXLSSyntaxItem; Value: widestring): integer;
    function    Parse_Name(Item: TXLSSyntaxItem; Value: WideString): integer;
    function    Parse_Cell(Cell: widestring; Var row, col: integer; Var rowrel, colrel: boolean): integer;
    procedure   SetTokens(Value: TXLSTokens);
    function    GetRangeType(Range: widestring): integer;
//    function    GetSheetIdByName(SheetName: WideString;Var SheetID: integer): integer;
  public
//    constructor Create(Funcs: THashFunc; AGetSheetIdByName: TGetSheetIDByName);
    constructor Create(Funcs: THashFunc; AExtern: TXLSExternSheet);
    destructor  Destroy; override;
    procedure Clear;
    function    Parse(SheetID: integer): integer;

    property    Tokens: TXLSTokens read FTokens write SetTokens;
    property    SyntaxTree:TXLSSyntaxItem read FSyntaxTree write FSyntaxTree;
 end;

 TXLSFormula = class
  private
    FLex: TXLSLexer;
    FFuncs: THashFunc;
    FSyntax: TXLSSyntax;
//    FGetSheetIndex: TGetSheetIndex;
    FExtern: TXLSExternSheet;
    FCurSheetID: integer;
    FMode: Char;

    FDecimalSeparator: widechar;
    FListSeparator: widechar;

    FIsArrayFormula: boolean;
    FIsArrayTransform: boolean;
//    FGetSheetIDByName: TGetSheetIDByName;
//    FGetSheetIndexByID: TGetSheetIndexByID;
    function GetDataSize(Item: TXLSSyntaxItem): integer;
    function GetItemData(Item: TXLSSyntaxItem; Data: TXLSBlob; aClass: integer; CurRow, CurCol: integer): integer;
    function GetRangeData(Range: TXLSSyntaxItem; Data: TXLSBlob; aClass: integer; CurRow, CurCol: integer): integer;
    function GetNameData(Item: TXLSSyntaxItem; Data: TXLSBlob; aClass: integer): integer;
    function GetNameXData(Item: TXLSSyntaxItem; Data: TXLSBlob; aClass: integer): integer;
    function GetRange3DData(Range: TXLSSyntaxItem; RangeType:integer; Data: TXLSBlob; aClass: integer; CurRow, CurCol: integer): integer;
    function GetFuncData(Item: TXLSSyntaxItem; Data: TXLSBlob; aClass: integer; CurRow, CurCol: integer): integer;
    function GetMemFuncData(Item: TXLSSyntaxItem; Data: TXLSBlob; aClass: integer; CurRow, CurCol: integer): integer;
    function GetNumberData(Item: TXLSSyntaxItem; Data: TXLSBlob; aClass: integer): integer;
    function GetBoolData(Item: TXLSSyntaxItem; Data: TXLSBlob; aClass: integer): integer;
    function GetArrayData(Item: TXLSSyntaxItem; Data: TXLSBlob; aClass: integer): integer;
    function GetStringData(Item: TXLSSyntaxItem; Data: TXLSBlob; aClass: integer): integer;
    function CellToRowCol(Range: TXLSRangeItem; First: boolean; CurRow, CurCol: integer; Var aRow, aCol: integer): integer;
    function GetFuncNameByPtg(aPtg: integer): widestring;
    procedure  InitFuncHash;
    procedure  InitExtraFuncHash(ExtraPack: THashFunc);
    function   Compile( aFormula: widestring; SheetID: integer): integer;
    function   GetData(Var Data: TXLSBlob; CurRow, CurCol, CurSheetID: integer): integer; overload;
    function   GetData(Var Data: TXLSBlob; CurRow, CurCol, CurSheetID: integer; aClass: integer): integer; overload;
    procedure  SetCompiled(aFormula:TXLSSyntaxItem);
    function  TranslateUnary(lData: TXLSBlob; Var Offset: longword;
                             BiffVer: word; Stack: TXLSSyntaxStack): integer;
    function  TranslateBinary(lData: TXLSBlob; Var Offset: longword;
                             BiffVer: word; Stack: TXLSSyntaxStack): integer;
    function  TranslateAttr(lData: TXLSBlob; Var Offset: longword;
                             BiffVer: word; Stack: TXLSSyntaxStack): integer;
    function  TranslateConst(lData: TXLSBlob; Var Offset: longword;
                             BiffVer: word; Stack: TXLSSyntaxStack): integer;
    function  TranslateFunc(lData: TXLSBlob; Var Offset: longword;
                             BiffVer: word; Stack: TXLSSyntaxStack): integer;
    function  TranslateName(lData: TXLSBlob; Var Offset: longword;
                             BiffVer: word; Stack: TXLSSyntaxStack): integer;
    function  TranslateMemFunc(lData: TXLSBlob; Var Offset: longword;
                             BiffVer: word; Stack: TXLSSyntaxStack): integer;
    function  TranslateRange(lData: TXLSBlob; Var Offset: longword;
                             BiffVer: word; Stack: TXLSSyntaxStack): integer;
    procedure SetDecimalSeparator(Value: WideChar);
    procedure SetListSeparator(Value: WideChar);
  public
    FFileFormat: TXLSFileFormat;
//    constructor Create(AGetSheetIDByName:  TGetSheetIDByName;
//                       AGetSheetIndexByID: TGetSheetIndexByID);
    constructor Create(AExtern: TXLSExternSheet);
    destructor  Destroy; override;
    function    GetCompiled( aFormula: widestring; SheetID: integer): TXLSSyntaxItem;
//    function    SetStoreData(lData: TXLSBlob; Var aFormula: TXLSSyntaxItem): integer;
    function    GetTranslated(lData: TXLSBlob; var Offset: longword; BiffVer: word):TXLSSyntaxItem; overload;
    function    GetTranslated(lData: TXLSBlob; var Offset: longword; FormulaSize: longword; BiffVer: word):TXLSSyntaxItem; overload;

    function    GetStoreData(aFormula:TXLSSyntaxItem; Var lData: TXLSBlob; CurRow, CurCol, CurSheetID: integer): integer;
    function    GetStoreDataExt(aFormula:TXLSSyntaxItem; Var lData: TXLSBlob; CurRow, CurCol, CurSheetID: integer; aClass: integer): integer;
    procedure   SetMode(AMode: char);    
//    property    GetSheetIndex: TGetSheetIndex read FGetSheetIndex write FGetSheetIndex;
//    property    GetSheetIndexByID: TGetSheetIndexByID read FGetSheetIndexByID write FGetSheetIndexByID;
//    property    GetSheetIDByName: TGetSheetIDByName read FGetSheetIDByName write FGetSheetIDByName;
    property    FuncNamebyPtg[aPtg: integer]: wideString read GetFuncNameByPtg;
    property DecimalSeparator: WideChar read FDecimalSeparator write SetDecimalSeparator;
    property ListSeparator: WideChar read FListSeparator write SetListSeparator;
 end;

 function XLSTryStrToFloat(StringValue: WideString; Var Value: double): boolean;

implementation
//uses performance;

const //XLSXMaxRow: Word = $FFFF;
      //XLSXMaxCol: Byte = $FF;

      XLSXMaxRow: integer = $FFFFF;
      XLSXMaxCol: integer = $3FFF;


const
 {Lex state}
 ST_NONE      = 0;
 ST_IDENT     = 1;
 ST_STRING    = 2;
 ST_NUM       = 3;
 ST_RANGE     = 4;
 ST_3DRANGE   = 5;
 ST_NAME3D    = 6;
 ST_NUM_E     = 7;  // Merc: number exponential part 1 (parsed 1.2e)
 ST_NUM_ENUM  = 8;  // Merc: number exponential part 2 (parsed 1.2e+ or 1.2e+3)

 {Lexeme type}
 LT_NONE      = -1; 
 LT_IDENT     = 1;
 LT_NUMBER    = 2;
 LT_STRING    = 3;
 LT_LBR       = 4;
 LT_RBR       = 5;
 LT_LISTSEP   = 6;
 LT_PLUS      = 7;
 LT_MINUS     = 8;
 LT_MUL       = 9;
 LT_DIV       = 10;
 LT_RANGE     = 11;
 LT_CONCAT    = 12;
 LT_EQ        = 13;
 LT_NE        = 14;
 LT_GT        = 15;
 LT_LT        = 16;
 LT_GE        = 17;
 LT_LE        = 18;
 LT_POWER     = 19;
 LT_PERCENT   = 20;
 LT_3DRANGE   = 21;

 function XLSTryStrToFloat(StringValue: WideString; Var Value: double): boolean;
 begin
    {$IFDEF D45}
    try
      Value := strtofloat(StringValue);                           
      Result := true;
    except
       on E:Exception do begin
          //Error
          Result := false 
       end; 
    end;
    {$ELSE}
    Result := TryStrToFloat(StringValue, Value);
    {$ENDIF}
 end;

{THashFuncEntry}
function THashFuncEntry.GetArgClass(ArgNo: integer): byte;
begin
  if FArgClassLen < ArgNo then Result := FClass
  else Result := FArgClass[ArgNo - 1];
end;

{THashFunc}
constructor THashFunc.Create;
begin
  inherited Create;
  FPtgHash := THashWideString.Create; 
  FExtraPack := nil;
end;

destructor THashFunc.Destroy;
begin
  FExtraPack.Free;
  FPtgHash.Free;
  inherited Destroy;
end;

function THashFunc.CreateEntry: THashEntry;
begin
  Result := THashFuncEntry.Create;
end;

function THashFunc.GetValue(aFuncName: widestring): THashFuncEntry;
var
  CurEntry: THashFuncEntry;
begin
  CurEntry := THashFuncEntry(FindHashEntry(aFuncName));
  if CurEntry = nil then
     Result := nil
  else
     Result := CurEntry;
end;

function THashFunc.GetName(aPtg: integer): widestring;
begin
  Result := FPtgHash[inttostr(aPtg)];
end;

function  THashFunc.GetArgsCnt(aPtg: integer): integer;
Var lFuncName: widestring;
    CurEntry: THashFuncEntry;
begin
  Result := -2;
  lFuncName := GetName(aPtg);
  if lFuncName <> '' then begin
     CurEntry := Values[lFuncName];
     if Assigned(CurEntry) then Result := CurEntry.FArgsCnt;
  end;
end;

procedure THashFunc.SetValue(aFuncName: widestring; aPtg, aRetClass, aArgsCnt, aClass, aVol: integer);
var
  CurEntry: THashFuncEntry;
begin
  FPtgHash[inttostr(aPtg)] := aFuncName;
  CurEntry := THashFuncEntry(GetHashEntry(aFuncName));
  if CurEntry <> nil then begin
     CurEntry.FPtg      := aPtg;
     CurEntry.FArgsCnt  := aArgsCnt;
     CurEntry.FClass    := aClass;
     CurEntry.FVol      := aVol;
     CurEntry.FRetClass := aRetClass; 
     CurEntry.FArgClassLen := 0;
  end;
end;

procedure THashFunc.SetValue(aFuncName: widestring; aPtg, aRetClass, aArgsCnt, aClass, aVol: integer; ArgsClass: string);
var
  CurEntry: THashFuncEntry;
  i: integer;
begin
  FPtgHash[inttostr(aPtg)] := aFuncName;
  CurEntry := THashFuncEntry(GetHashEntry(aFuncName));
  if CurEntry <> nil then begin
     CurEntry.FPtg      := aPtg;
     CurEntry.FArgsCnt  := aArgsCnt;
     CurEntry.FClass    := aClass;
     CurEntry.FVol      := aVol;
     CurEntry.FRetClass := aRetClass; 
     CurEntry.FArgClassLen := Length(ArgsClass);
     if CurEntry.FArgClassLen > 0 then begin
        SetLength(CurEntry.FArgClass, CurEntry.FArgClassLen);
        for i := 1 to CurEntry.FArgClassLen do begin
           CurEntry.FArgClass[i - 1] := strtoint(ArgsClass[i] + '');
        end;
     end; 
  end;
end;


procedure THashFunc.SetExtraPack(extrapack: THashFunc);
begin
   FExtraPack := extrapack;
end;

function THashFunc.GetExtraFunctionPtg(Name: String): integer;
var
  CurEntry: THashFuncEntry;
begin
   Result := -1;
   if Assigned(FExtraPack) then begin
      CurEntry := FExtraPack[Name];
      if Assigned(CurEntry) then begin
         Result := CurEntry.FPtg;
      end;
   end;
end;

function THashFunc.GetExtraFunctionEntry(Name: String): THashFuncEntry;
begin
   if Assigned(FExtraPack) then begin
      Result := FExtraPack[Name];
   end else begin
      Result := nil;
   end;
end;

{TXLSToken}
constructor TXLSToken.Create();
begin
  inherited Create();
end;                  

{destructor TXLSToken.Destroy();
begin
  if Assigned(FNext) then FNext.Free();
  inherited Destroy();
end;                  }

{TXLSLexer}
constructor TXLSLexer.Create();
begin
  inherited Create();
  FSource           := '';
  FSourcePos        := 0;
  FSourceLen        := 0;        
  FDecimalSeparator := '.';
  FListSeparator    := ';';
  FTokens := TXLSTokens.Create();
  FValue := TWideStringBuilder.Create(50)
end;                  

destructor TXLSLexer.Destroy();
begin
  FTokens.Free();
  FValue.Free();
  inherited Destroy();
end;        

procedure TXLSLexer.Clear();
begin
  FSource := '';
  FSourcePos := 0;
  FSourceLen := 0;
  FValue.Clear;
  FTokens.Clear;
end;

procedure TXLSLexer.SetSource(Value: widestring);
begin
  FSource := Value;
  FSourcePos := 1;
  FSourceLen := Length(Value);
  FTokens.Clear;
end;


procedure TXLSLexer.Next;
begin
  inc(FSourcePos);
end;

function TXLSLexer.GetEof: boolean;
begin Result := (FSourcePos > FSourceLen); end;

function TXLSLexer.GetSymbol(Offset: integer): widechar;
Var Index: integer;
begin
  Index := FSourcePos + Offset;
  if (Index >= 1) and (Index <= FSourceLen) then begin
     Result := FSource[Index];
  end else begin
     Result := chr(0);
  end; 
end;

function TXLSLexer.Analyse(): integer;
Var lState: integer;
//    lValue: widestring;
    lChar:  widechar;
    lnChar: widechar;

 procedure _addtoken(TokenType: integer);
 begin
   AddToken(TokenType, FValue.Value);
//   lValue := '';
   FValue.Clear;
   lState := ST_NONE;  
 end;

begin
  Result := 1;
  lState := ST_NONE;
  FValue.Clear;
  repeat
    lChar := Symbol[0];
    if not(Eof) then begin
       case lState of
          ST_NONE: 
             begin
              //Alpha
              if ((lChar >= 'a') and (lChar <= 'z')) or
                 ((lChar >= 'A') and (lChar <= 'Z')) then begin
                    lState := ST_IDENT;
                    FValue.Add(lChar);
                    Next;
              //Digit
              end else if ((lChar >= '0') and (lChar <= '9')) or 
                          (lChar = FDecimalSeparator) then begin
                    lState := ST_NUM;
                    FValue.Add(lChar);
                    Next;
              //Space
              end else if  lChar = ' '  then begin
                    Next;
              //begin of string
              end else if  lChar = '"'  then begin
                    lState := ST_STRING;
                    FValue.Clear;
                    Next;
              end else if  lChar = ''''  then begin
                    lState := ST_NAME3D;
                    FValue.Clear;
                    Next;
              end 
              else if  lChar = FListSeparator then AddSymbolToken(LT_LISTSEP)
              else if  lChar = '('  then AddSymbolToken(LT_LBR)
              else if  lChar = ')'  then AddSymbolToken(LT_RBR)
              else if  lChar = '+'  then AddSymbolToken(LT_PLUS)
              else if  lChar = '-'  then AddSymbolToken(LT_MINUS)
              else if  lChar = '/'  then AddSymbolToken(LT_DIV)
              else if  lChar = '*'  then AddSymbolToken(LT_MUL)
              else if  lChar = '^'  then AddSymbolToken(LT_POWER)
              else if  lChar = '='  then AddSymbolToken(LT_EQ)
              else if  lChar = '&'  then AddSymbolToken(LT_CONCAT)
              else if  lChar = '%'  then AddSymbolToken(LT_PERCENT)
              //dollar sign (only in range)	
              else if  lChar = '$'  then begin
                    lState := ST_RANGE;
                    FValue.Add(lChar);
                    Next;
              //equal
              //>=, >
              end else if  lChar = '>'  then begin
                    lnChar := Symbol[+1];
                    if lnChar = '=' then begin
                       AddToken(LT_GE, '>='); 
                       Next;
                       Next;
                    end else AddSymbolToken(LT_GT); 
              //<=, <>, <
              end else if  lChar = '<'  then begin
                    lnChar := Symbol[+1];
                    if lnChar = '=' then begin
                       AddToken(LT_LE, '<='); 
                       Next;
                       Next;
                    end else if lnChar = '>' then begin
                       AddToken(LT_NE, '<>');
                       Next;
                       Next;
                    end else AddSymbolToken(LT_LT); 
              end else begin
                    lState := ST_IDENT;
                    FValue.Add(lChar);
                    Next;
              end;
             end;      
          ST_IDENT:
             begin
              //Alpha
              if ((lChar >= 'a') and (lChar <= 'z')) or
                 ((lChar >= 'A') and (lChar <= 'Z')) or 
                 ((lChar >= '0') and (lChar <= '9')) or 
                 (lChar = '_') then begin
                 FValue.Add(lChar);
                 Next;
              //dollar sign and : (only in range)	
              end else if (lChar = '$') or (lChar = ':') then begin
                 FValue.Add(lChar);
                 Next;
                 lState := ST_RANGE;
              end else if (lChar = '!') then begin
                 FValue.Add(lChar);
                 Next;
                 lState := ST_3DRANGE;
              end else if (lChar = '''') then begin
                 Next;
                 lState := ST_NAME3D;
              //Space
              //begin of string
              end 
              else if  lChar = ' '  then _addtoken(LT_IDENT)
              else if  lChar = '"'  then _addtoken(LT_IDENT)
              else if  lChar = '''' then _addtoken(LT_IDENT)
              else if  lChar = FListSeparator then _addtoken(LT_IDENT)
              else if  lChar = '('  then _addtoken(LT_IDENT)
              else if  lChar = ')'  then _addtoken(LT_IDENT)
              else if  lChar = '+'  then _addtoken(LT_IDENT)
              else if  lChar = '-'  then _addtoken(LT_IDENT)
              else if  lChar = '/'  then _addtoken(LT_IDENT)
              else if  lChar = '*'  then _addtoken(LT_IDENT)
              else if  lChar = '^'  then _addtoken(LT_IDENT)
              else if  lChar = '='  then _addtoken(LT_IDENT)
              else if  lChar = '&'  then _addtoken(LT_IDENT)
              else if  lChar = '%'  then _addtoken(LT_IDENT)
              else if  lChar = '>'  then _addtoken(LT_IDENT)
              else if  lChar = '<'  then _addtoken(LT_IDENT)
              else if  lChar = FDecimalSeparator then _addtoken(LT_IDENT)
              else begin
                 FValue.Add(lChar);
                 Next;
              end;
             end;
          ST_RANGE, ST_3DRANGE: 
             begin
              //Alpha, Digit, $, :
              if ((lChar >= 'a') and (lChar <= 'z')) or
                 ((lChar >= 'A') and (lChar <= 'Z')) or
                 ((lChar >= '0') and (lChar <= '9')) or
                 (lChar = '_') or (lChar = '$') or
                 (lChar = ':') or (lChar = '!') then begin
                 FValue.Add(lChar);
                 Next;
              end else if lChar = '''' then begin
                 Next;
                 lState := ST_NAME3D;
              end else begin
                 if lState = ST_RANGE then _addtoken(LT_RANGE) 
                                      else _addtoken(LT_3DRANGE);
              end;
             end;      
          ST_NAME3D:
             begin
                Next;
                if lChar = '''' then begin
                   if Symbol[0] = '''' then begin
                      FValue.Add(lChar);
                      Next;
                   end else begin
                      lState := ST_3DRANGE;
                   end;
                end else FValue.Add(lChar);
             end;
          ST_STRING:
             begin
                Next;
                if lChar = '"' then begin
                   if Symbol[0] = '"' then begin
                      FValue.Add(lChar);
                      Next;
                   end else _addtoken(LT_STRING); //end of string
                end else FValue.Add(lChar);
             end;
          ST_NUM:
             begin
                //Digit, .
                if ((lChar >= '0') and (lChar <= '9')) or
                   (lChar = FDecimalSeparator) then begin
                   FValue.Add(lChar);
                   Next;
                //Merc: Seen E in number => start making exponential part
                end else if (lChar = 'e') or (lChar= 'E') then begin
                   FValue.Add(lChar);
                   Next;
                   lState := ST_NUM_E;
                //: (only in range)
                end else if (lChar = ':') then begin
                   FValue.Add(lChar);
                   Next;
                   lState := ST_RANGE;
                end else _addtoken(LT_NUMBER);
             end;

          // Merc: Right now we've parsed 1.2e
          ST_NUM_E:
            begin
              if ((lChar >= '0') and (lChar <= '9'))
                   or (lChar = '+') or (lChar = '-')
              then begin
                FValue.Add(lChar);
                Next;
                lState := ST_NUM_ENUM;
              end else _addtoken(LT_NUMBER);
            end;

          // Merc: Right now we've parsed 1.2e+ or 1.2e+3
          // nExcel uses native Delphi's floating-point parsing libraries =>
          //   we don't need any more details here!
          ST_NUM_ENUM:
            begin
              if ((lChar >= '0') and (lChar <= '9'))
              then begin
                FValue.Add(lChar);
                Next;
                //lState := ST_NUM_ENUM;
              end else _addtoken(LT_NUMBER);
            end;
       end;
    end else begin
      case lState of
         ST_IDENT:   AddToken(LT_IDENT,   FValue.Value);
         ST_RANGE:   AddToken(LT_RANGE,   FValue.Value);
         ST_3DRANGE: AddToken(LT_3DRANGE, FValue.Value);
         ST_STRING:  Result := -1; //string not terminated
         ST_NAME3D:  Result := -1; //name not terminated
         ST_NUM_E: Result := -1; // number not terminated
         ST_NUM, ST_NUM_ENUM: AddToken(LT_NUMBER,  FValue.Value);
      end;
      break;
    end;
  until not(Result = 1)
end;

procedure TXLSLexer.AddToken(ATokenType: integer; AValue: widestring);
begin
  FTokens.AddToken(ATokenType, AValue);
end;

procedure TXLSLexer.AddSymbolToken(ATokenType: integer);
begin
  FTokens.AddToken(ATokenType, Symbol[0]);
  Next;
end;

{TXLSTokens}
constructor TXLSTokens.Create;
begin
  inherited Create();
  FArrSize := 0;
  FCount   := 0;
  FCur := 0;
  FEOF     := true;
end;

destructor TXLSTokens.Destroy;
var i: integer;
begin
  if FArrSize > 0 then begin
     for i := 0 to FArrSize - 1 do begin
         FArr[i].Free;
     end;
     SetLength(FArr, 0);
  end;
  inherited Destroy();
end;

procedure TXLSTokens.Clear;
begin
  FCount   := 0;
  FCur := 0;
  FEOF     := true;
end;

procedure  TXLSTokens.Next;
begin
  if (FCur < FCount) and (FCur >= 0) then Inc(FCur);
  FEOF := (FCur >= FCount) or (FCur < 0);
end;

procedure  TXLSTokens.Prev;
begin
  if (FCur < FCount) and (FCur >= 0) then Dec(FCur);
  FEOF := (FCur >= FCount) or (FCur < 0);
end;

procedure  TXLSTokens.GoToFirst;
begin
  FCur := 0;
  FEOF := (FCur >= FCount) or (FCur < 0);
end;

function TXLSTokens.GetTokenType:  integer;
begin
  if (FCur >= 0) and (FCur < FCount) then begin
      Result := FArr[FCur].TokenType;
  end else begin
      Result := LT_NONE;
  end;
end;

function TXLSTokens.GetTokenValue: widestring;
begin
  if (FCur >= 0) and (FCur < FCount) then begin
      Result := FArr[FCur].Value;
  end else begin
      Result := '';
  end;
end;

procedure TXLSTokens.AddToken(ATokenType: integer; AValue: widestring);
Var Token:TXLSToken;
begin
  if FArrSize = FCount then begin
     FArrSize := FArrSize + 20;
     SetLength(FArr, FArrSize);
  end;
  
  Inc(FCount);
  Token := FArr[FCount - 1];
  if Not(Assigned(Token)) then begin
      Token := TXLSToken.Create();
      FArr[FCount - 1] := Token; 
  end;
  Token.TokenType := ATokenType;
  Token.Value     := AValue;
  FEOF := false;
  if FCount = 1 then FCur := 0;
end;

function TXLSTokens.GetToken(offset: integer): TXLSToken;
var ind: integer;
begin
  ind := FCur;
  Result := nil;
  if (ind < FCount) and (ind >= 0) then begin
     ind := ind + offset;
     if (ind < FCount) and (ind >= 0) then begin
         Result := FArr[ind];
     end;
  end 
end;


function TXLSRangeItem.CopyObject(DeltaRow, DeltaCol: integer): TXLSRangeItem;
Var tmp: integer;
begin
  Result := TXLSRangeItem.Create();

  if FFirstRowRel or FRelative 
                       then Result.FFirstRow := FFirstRow
                       else Result.FFirstRow := FFirstRow + DeltaRow;
  Result.FFirstRowRel := FFirstRowRel;

  if FFirstColRel or FRelative
                       then Result.FFirstCol := FFirstCol
                       else Result.FFirstCol := FFirstCol + DeltaCol;
  Result.FFirstColRel := FFirstColRel;

  if (FRangeType = RANGE2D) or (FRangeType = RANGE3D) then begin
     if FLastRowRel or FRelative
                         then  Result.FLastRow  := FLastRow
                         else  Result.FLastRow  := FLastRow + DeltaRow;
     Result.FLastRowRel  := FLastRowRel;

     if FLastColRel or FRelative
                         then  Result.FLastCol  := FLastCol
                         else  Result.FLastCol  := FLastCol + DeltaCol;
     Result.FLastColRel  := FLastColRel;
  end else begin
     Result.FLastRowRel := Result.FFirstRowRel;
     Result.FLastColRel := Result.FFirstColRel;
     Result.FLastRow    := Result.FFirstRow;
     Result.FLastCol    := Result.FFirstCol;
  end;
  if Not(FRelative) then begin
     With Result do begin
        if FLastRow < FFirstRow then begin
           tmp := FFirstRow;
           FFirstRow := FLastRow;
           FLastRow := tmp;  
           if FFirstRowRel <> FLastRowRel then begin
              FFirstRowRel := not(FFirstRowRel);
              FLastRowRel := not(FLastRowRel);
           end;
        end;
        if FLastCol < FFirstCol then begin
           tmp := FFirstCol;
           FFirstCol := FLastCol;
           FLastCol := tmp;  
           if FFirstColRel <> FLastColRel then begin
              FFirstColRel := not(FFirstColRel);
              FLastColRel := not(FLastColRel);
           end;
        end;
     end;
  end;

  Result.FRelative    := FRelative;
  Result.FRangeType   := FRangeType;
  Result.FExternID    := FExternID;
end;


function TXLSRangeItem.CopyObject(row1, col1, row2, col2, drow, dcol: integer): TXLSRangeItem;
Var 
    l_drow: integer;
    l_dcol: integer;
begin
  Result := TXLSRangeItem.Create();
  l_drow := 0;
  if not(FRelative) and (drow <> 0) then begin
     if (row1 <= FFirstRow) and 
        (col1 <= FFirstCol) and 
        (col2 >= FLastCol) then begin

        if (drow < 0) and ((FFirstRow + drow) < row1) then begin
           l_drow := row1 - FFirstRow;
        end else begin
           l_drow := drow;
        end;

        if (FFirstRow = 0) and (FLastRow = XLSXMaxRow) then begin
           l_drow := 0;
        end;
     end;
  end;
  
  Result.FFirstRow := FFirstRow + l_drow;
  Result.FFirstRowRel := FFirstRowRel;

  l_dcol := 0;
  if not(FRelative) and (dcol <> 0) then begin
     if (col1 <= FFirstCol) and 
        (row1 <= FFirstRow) and 
        (row2 >= FLastRow) then begin
        if (dcol < 0) and ((FFirstCol + dcol) < col1) then begin
           l_dcol := col1 - FFirstCol;
        end else begin
           l_dcol := dcol;
        end;
        if (FFirstCol = 0) and (FLastCol = XLSXMaxCol) then begin
           l_dcol := 0;
        end;
     end;
  end;

  Result.FFirstCol := FFirstCol + l_dcol;
  Result.FFirstColRel := FFirstColRel;

  if (FRangeType = RANGE2D) or (FRangeType = RANGE3D) then begin

     l_drow := 0;
     if not(FRelative) and (drow <> 0) then begin
        if (row1 <= FLastRow) and 
           (col1 <= FFirstCol) and 
           (col2 >= FLastCol) then begin
           if (drow < 0) and ((FLastRow + drow) < row1) then begin
              l_drow := row1 - FLastRow;
           end else begin
              l_drow := drow;
           end;
        end;
        if (FFirstRow = 0) and (FLastRow = XLSXMaxRow) then begin
           l_drow := 0;
        end;
     end;

     Result.FLastRow := FLastRow + l_drow;
     if Result.FLastRow > XLSXMaxRow then Result.FLastRow := XLSXMaxRow;
     Result.FLastRowRel := FLastRowRel;

     l_dcol := 0;
     if not(FRelative) and (dcol <> 0) then begin
        if (col1 <= FLastCol) and 
           (row1 <= FFirstRow) and 
           (row2 >= FLastRow) then begin
           if (dcol < 0) and ((FLastCol + dcol) < col1) then begin
              l_dcol := col1 - FLastCol;
           end else begin
              l_dcol := dcol;
           end;
           if (FFirstCol = 0) and (FLastCol = XLSXMaxCol) then begin
              l_dcol := 0;
           end;
        end;
     end;

     Result.FLastCol := FLastCol + l_dcol;
     if Result.FLastCol > XLSXMaxCol then Result.FLastCol := XLSXMaxCol;
     Result.FLastColRel := FLastColRel;

  end else begin
     Result.FLastRowRel := Result.FFirstRowRel;
     Result.FLastColRel := Result.FFirstColRel;
     Result.FLastRow    := Result.FFirstRow;
     Result.FLastCol    := Result.FFirstCol;
  end;


  Result.FRelative    := FRelative;
  Result.FRangeType   := FRangeType;
  Result.FExternID    := FExternID;

  if ((Result.FRangeType = RANGE2D) or (Result.FRangeType = RANGE3D)) and
     (Result.FFirstRow = Result.FLastRow) and
     (Result.FFirstCol = Result.FLastCol) then begin
     Result.FLastRowRel := Result.FFirstRowRel;
     Result.FLastColRel := Result.FFirstColRel;
     if Result.FRangeType = RANGE2D then begin
        Result.FRangeType := REF2D;
     end else begin
        Result.FRangeType := REF3D;
     end;
  end;

  if Not(Result.FRelative) and (Result.FRangeType < RANGEERROR) then begin
     if (Result.FLastRow < Result.FFirstRow) or
        (Result.FLastCol < Result.FFirstCol) or
        (Result.FFirstRow > XLSXMaxRow) or
        (Result.FLastRow > XLSXMaxRow) or
        (Result.FFirstCol > XLSXMaxCol) or
        (Result.FLastCol > XLSXMaxCol) or
        (Result.FFirstCol < 0) or
        (Result.FFirstRow < 0) then begin
        Result.FRangeType := Result.FRangeType or RANGEERROR;
     end;
  end;

end;

{TXLSSyntaxItem}

constructor TXLSSyntaxItem.Create;
begin
  FChildCount := 0;
  FRangeValue := nil;
  inherited Create;
end;

destructor TXLSSyntaxItem.Destroy;
Var i: integer;
begin
  FRangeValue.Free;
  if FChildCount > 0 then begin
     for i := 1 to FChildCount do begin
       FChild[i - 1].Free; 
     end;
  end;
  SetLength(FChild, 0);
  inherited Destroy;
end;

function TXLSSyntaxItem.CopyObject(DeltaRow, DeltaCol: integer): TXLSSyntaxItem;
Var i: integer;
    lChild: TXLSSyntaxItem;
begin
  Result := TXLSSyntaxItem.Create();
  if Assigned(FRangeValue) then 
     Result.FRangeValue := FRangeValue.CopyObject(DeltaRow, DeltaCol);
  Result.FItemType := FItemType;
  Result.FValue    := FValue;
  Result.FDecValue := FDecValue;
  Result.FIntValue := FIntValue;
  Result.FParent   := nil;
  if FChildCount > 0 then begin
     for i := 1 to FChildCount do begin
       lChild := Child[i].CopyObject(DeltaRow, DeltaCol); 
       Result.AddChild(lChild);
     end;
  end;
end;

function TXLSSyntaxItem.CopyObject(row1, col1, row2, col2, drow, dcol: integer): TXLSSyntaxItem;
Var i: integer;
    lChild: TXLSSyntaxItem;
begin
  Result := TXLSSyntaxItem.Create();
  if Assigned(FRangeValue) then 
     Result.FRangeValue := FRangeValue.CopyObject(row1, col1, row2, col2, drow, dcol);
  Result.FItemType := FItemType;
  Result.FValue    := FValue;
  Result.FDecValue := FDecValue;
  Result.FIntValue := FIntValue;
  Result.FParent   := nil;
  if FChildCount > 0 then begin
     for i := 1 to FChildCount do begin
       lChild := Child[i].CopyObject(row1, col1, row2, col2, drow, dcol); 
       Result.AddChild(lChild);
     end;
  end;
end;

function TXLSSyntaxItem.GetChild(Index: integer):TXLSSyntaxItem;
begin
  if (Index > 0) and (Index <= FChildCount) then
     Result := FChild[Index - 1]
  else
     Result := nil;
end;

procedure TXLSSyntaxItem.AddChild(Item: TXLSSyntaxItem);
begin
  if (FChildCount and $000F) = 0 then begin
     SetLength(FChild, (FChildCount or $000F) + 1);
  end;
  Inc(FChildCount);
  FChild[FChildCount - 1] := Item;
  Item.FParent := self;
end;

procedure TXLSSyntaxItem.PushChild(Item: TXLSSyntaxItem);
Var i: integer;
begin
  if (FChildCount and $000F) = 0 then begin
     SetLength(FChild, (FChildCount or $000F) + 1);
  end;
  Inc(FChildCount);
  if FChildCount > 1 then begin
     for i := FChildCount - 1 downto 1 do
       FChild[i] := FChild[i - 1];  
  end;
  FChild[0] := Item;
  Item.FParent := self;
end;

{TXLSSyntaxStack}
constructor TXLSSyntaxStack.Create;
begin
  inherited Create;
  FCount := 0;
  FMaxCount := 0;
end;

destructor TXLSSyntaxStack.Destroy;
Var i: integer;
begin
  if FCount > 0 then 
     for i := FCount downto 1 do Pop.Free;
  SetLength(FItems, 0);
  inherited Destroy;
end;

function TXLSSyntaxStack.Pop: TXLSSyntaxItem;
begin
  if FCount > 0 then begin
     Result := FItems[FCount - 1];
     Dec(FCount);
  end else Result := nil;
end;

procedure TXLSSyntaxStack.Push(Value: TXLSSyntaxItem);
begin
  Inc(FCount);
  if FCount > FMaxCount then begin
     FMaxCount := FMaxCount + 5;
     SetLength(FItems, FMaxCount);
  end;
  FItems[FCount - 1] := Value;
end;

{TXLSSyntax}
//constructor TXLSSyntax.Create(Funcs: THashFunc; AGetSheetIDByName: TGetSheetIDByName);
constructor TXLSSyntax.Create(Funcs: THashFunc; AExtern: TXLSExternSheet);
begin
  inherited Create;
  FFuncs := Funcs;
//  FGetSheetIDByName := AGetSheetIDByName;
  FExtern := AExtern;
  FDecimalSeparator := '.';
end;

destructor TXLSSyntax.Destroy;
begin
  FSyntaxTree.Free;
  inherited Destroy;
end;

procedure TXLSSyntax.Clear;
begin
  FTokens := nil;
  FSyntaxTree.Free;
  FSyntaxTree := nil;
end;

procedure TXLSSyntax.SetTokens(Value: TXLSTokens);
begin
  FTokens := Value;
end;

function TXLSSyntax.Parse(SheetID: integer): integer;
begin
  FCurSheetID := SheetID;
  FSyntaxTree.Free;
  FTokens.GotoFirst;
  Result := Parse_expr(FSyntaxTree);
  if Result = 1 then
     if not(FTokens.isEOF) then begin
        Result := -1;
        FSyntaxTree.Free;
     end;
  if Result <> 1 then FSyntaxTree := nil;
  //if Result <> 1 then FSyntaxTree.Free;
end;

function  TXLSSyntax.Parse_expr(Var Item: TXLSSyntaxItem): integer;
Var lLex: integer;
    lChild: TXLSSyntaxItem;
begin
//expr = expr1 '>' expr  |
//       expr1 '<' expr  |
//       expr1 '<>' expr |
//       expr1 '=' expr  |
//       expr1 '>=' expr |
//       expr1 '<=' expr |
//       expr1
 Result := Parse_expr1(lChild);
 if Result = 1 then begin
    lLex := Tokens.TokenType;
    if lLex in [LT_EQ, LT_NE, LT_GE, LT_LE, LT_GT, LT_LT] then begin
       Item := TXLSSyntaxItem.Create();
       case lLex of
          LT_EQ: Item.ItemType := SA_EQ;
          LT_NE: Item.ItemType := SA_NE;
          LT_GE: Item.ItemType := SA_GE;
          LT_LE: Item.ItemType := SA_LE;
          LT_GT: Item.ItemType := SA_GT;
          LT_LT: Item.ItemType := SA_LT;
       end;
       Item.Value := Tokens.TokenValue;
       Tokens.Next;
       Item.AddChild(lChild);
       Result := Parse_expr(lChild);
       if Result = 1 then begin
          Item.AddChild(lChild);
       end else begin
          //Error
          Item.Free;
       end;
    end else begin
       Item := lChild;
    end;
  end;
end;

function  TXLSSyntax.Parse_expr1(Var Item: TXLSSyntaxItem): integer;
Var //lLex: integer;
    lChild: TXLSSyntaxItem;
begin
//expr = expr '+' expr0 |
//       expr '-' expr0 |
//       expr '&' expr0 |
//       expr0

 Result := Parse_expr0(Item);
 if Result = 1 then begin
    while (Tokens.TokenType in [LT_PLUS, LT_MINUS, LT_CONCAT]) 
          and (Result = 1) do begin
       lChild        := Item;
       Item          := TXLSSyntaxItem.Create();
       case Tokens.TokenType of
          LT_PLUS:   Item.ItemType := SA_ADD;
          LT_MINUS:  Item.ItemType := SA_SUB;
          LT_CONCAT: Item.ItemType := SA_CONCAT;
       end;
       Item.Value    := Tokens.TokenValue;
       Tokens.Next;
       Item.AddChild(lChild);
       Result := Parse_expr0(lChild);
       if Result = 1 then begin
          Item.AddChild(lChild);
       end else begin
          //Error
          Item.Free;
       end;
    end;
end;








//expr = expr0 '+' expr |
//       expr0 '-' expr |
//       expr0 '&' expr |
//       expr0
{ Result := Parse_expr0(lChild);
 if Result = 1 then begin
    lLex := Tokens.TokenType;
    if lLex in [LT_PLUS, LT_MINUS, LT_CONCAT] then begin
       Item := TXLSSyntaxItem.Create();
       case lLex of
          LT_PLUS:   Item.ItemType := SA_ADD;
          LT_MINUS:  Item.ItemType := SA_SUB;
          LT_CONCAT: Item.ItemType := SA_CONCAT;
       end;
       Item.Value := Tokens.TokenValue; 
       Tokens.Next;
       Item.AddChild(lChild);
       Result := Parse_expr(lChild);
       if Result = 1 then begin
          Item.AddChild(lChild);
       end else begin
          //Error
          Item.Free;
       end;
    end else begin
       Item := lChild;
    end;
  end;
}
end;

function  TXLSSyntax.Parse_expr0(Var Item: TXLSSyntaxItem): integer;
Var //lLex: integer;
    lChild: TXLSSyntaxItem;
begin
//expr0 = expr0 '*' operand |
//        expr0  /' operand |
//        operand

 Result := Parse_operand(Item);
 if Result = 1 then begin
    while (Tokens.TokenType in [LT_MUL, LT_DIV]) and (Result = 1) do begin
       lChild        := Item;
       Item          := TXLSSyntaxItem.Create();
       case Tokens.TokenType of
          LT_MUL:   Item.ItemType := SA_MUL;
          LT_DIV:   Item.ItemType := SA_DIV;
       end;
       Item.Value    := Tokens.TokenValue;
       Tokens.Next;
       Item.AddChild(lChild);
       Result := Parse_operand(lChild);
       if Result = 1 then begin
          Item.AddChild(lChild);
       end else begin
          //Error
          Item.Free;
       end;
    end;
 end;
{
 Result := Parse_operand(lChild);
// Result := Parse_expr0(lChild);
 if Result = 1 then begin
    lLex := Tokens.TokenType;
    if lLex in [LT_MUL, LT_DIV] then begin
       Item := TXLSSyntaxItem.Create();
       case lLex of
          LT_MUL:   Item.ItemType := SA_MUL;
          LT_DIV:   Item.ItemType := SA_DIV;
       end;
       Item.Value := Tokens.TokenValue;
       Tokens.Next;
       Item.AddChild(lChild);
       Result := Parse_expr0(lChild);
       //Result := Parse_operand(lChild);
       if Result = 1 then begin
          Item.AddChild(lChild);
       end else begin
          //Error
          Item.Free;
       end;
    end else begin
       Item := lChild;
    end;
  end;}
end;

function  TXLSSyntax.Parse_operand2(Var Item: TXLSSyntaxItem): integer;
Var lChild: TXLSSyntaxItem;
begin
//operand2 = operand1 % |
//           operand1
 Result := Parse_operand1(Item);
 if Result = 1 then begin
    while (Tokens.TokenType = LT_PERCENT) and (Result = 1) do begin
       lChild        := Item;
       Item          := TXLSSyntaxItem.Create();
       Item.ItemType := SA_PERCENT;
       Item.Value    := Tokens.TokenValue;
       Item.AddChild(lChild);   
       Tokens.Next;
    end;
 end;
end;


function  TXLSSyntax.Parse_operand(Var Item: TXLSSyntaxItem): integer;
Var lChild: TXLSSyntaxItem;
begin
//operand = operand '^' opearnd1 |
//          operand1
 Result := Parse_operand2(Item);
 if Result = 1 then begin
    while (Tokens.TokenType = LT_POWER) and (Result = 1) do begin
       lChild        := Item;
       Item          := TXLSSyntaxItem.Create();
       Item.ItemType := SA_POWER;
       Item.Value    := Tokens.TokenValue;
       Tokens.Next;
       Item.AddChild(lChild);
       Result := Parse_operand2(lChild);
       if Result = 1 then begin
          Item.AddChild(lChild);
       end else begin
          //Error
          Item.Free;
       end;
    end;
 end;
end;

function  TXLSSyntax.Parse_operand1(Var Item: TXLSSyntaxItem): integer;
Var lLex: integer;
    lChild: TXLSSyntaxItem;
    lToken: TXLSToken;
    lFunc: THashFuncEntry;
    ldval: double;    
    lfuncname: string;
    lexternid: integer;
    lnameid: integer;
    nm: TXLSSyntaxItem;
begin
//operand1 = '(' expr ')'|
//           '-' operand1 | !!!
//           '+' operand1 | !!!
//           'func' '(' exprlist ')' |
//           'number'   |
//           'string'   |
//           'range'
 Result := 1;
 lLex := Tokens.TokenType;
 if lLex = LT_IDENT then begin
    lToken := Tokens[ +1 ];
    if Assigned(lToken) then begin
       if (lToken.TokenType <> LT_LBR) then lLex := LT_RANGE;
    end else begin
       lLex := LT_RANGE;
    end;
 end;

 Item := TXLSSyntaxItem.Create();
 Item.Value := Tokens.TokenValue;
 Tokens.Next;

 case lLex of
   //'+' operand
   //'-' operand
   LT_MINUS, LT_PLUS:
      begin
        //unar minus or plus
         case lLex of
            LT_MINUS:   Item.ItemType := SA_UNARMINUS;
            LT_PLUS:    Item.ItemType := SA_UNARPLUS;
         end;
         Result := Parse_operand1(lChild);
         if Result = 1 then begin
            Item.AddChild(lChild);
         end else begin
            Item.Free;
         end;
       end;

   //'(' expr ')'
   LT_LBR:
       begin
         Item.ItemType := SA_GROUP;
         Result := Parse_expr(lChild);
         if Result = 1 then begin
            Item.AddChild(lChild);
            lLex := Tokens.TokenType;
            if lLex <> LT_RBR then begin
               //!!!error
               Result := -1;
            end else begin
               Tokens.Next;
            end;
         end;
         if Result <> 1 then Item.Free;
       end;

   //'func' '(' exprlist ')'
   LT_IDENT:
       begin
         if Tokens.TokenType <> LT_LBR then begin
            //!!!Error
             Result := -1;
         end;
         if Result = 1 then begin
            Item.ItemType := SA_FUNC; 
            Tokens.Next;
            if Tokens.TokenType <> LT_RBR then begin
               Result := Parse_exprlist(Item);
            end;
         end;
         if Result = 1 then begin
            if Tokens.TokenType <> LT_RBR then begin
               //!!!Error
               Result := -1;
            end;
         end;
         if Result = 1 then begin
            lfuncname := uppercase(Item.Value);
            lFunc := FFuncs[lfuncname];
            if Assigned(lFunc) then begin
                Item.IntValue := lFunc.FPtg
            end else begin
                lFunc := FFuncs.GetExtraFunctionEntry(lfuncname);
                if Assigned(lFunc) then begin
                   Item.IntValue := 255;
                   lexternid := FExtern.GetAddonFunctionExternID();
                   lnameid := FExtern.AddExtraFuncName(lfuncname);
                   if lnameid < 0 then begin
                      Result := -1;
                   end else begin
                      nm := TXLSSyntaxItem.Create();
                      nm.Value := lfuncname;
                      nm.ItemType := SA_NAME;
                      nm.IntValue := lnameid;
                      if not Assigned(nm.FRangeValue) then begin
                         nm.FRangeValue := TXLSRangeItem.Create;   
                      end;
                      nm.Range.FExternID := lexternid;
                      Item.PushChild(nm);
                   end;
                end else begin
              //invalid function name
              Result := -1;
            end;
         end;
         end;
         if Result = 1 then begin
            Tokens.Next;
         end else begin
            Item.Free;
         end;
       end;
   //'number', 'string', 'range'
   LT_NUMBER, LT_STRING, LT_RANGE, LT_3DRANGE:
       case lLex of
            LT_NUMBER:  begin
                          Item.ItemType := SA_NUMBER;
                          
                          if {$IFDEF D2011}FormatSettings.{$ENDIF}DecimalSeparator <> FDecimalSeparator then begin
                             Item.Value := StringReplace(Item.Value, FDecimalSeparator, {$IFDEF D2011}FormatSettings.{$ENDIF}DecimalSeparator, [rfReplaceAll])
                          end; 

                          if XLSTryStrToFloat(Item.Value, ldval) then begin
                              Item.DecValue := ldval;
                          end else begin   
                              Result := -1;
                          end;
                          if Result <> 1 then Item.Free;
                        end;
            LT_STRING:  Item.ItemType := SA_STRING;
            LT_RANGE, 
            LT_3DRANGE: begin
                          Result := Parse_Range(Item, Item.Value);
                          if Result <> 1 then Item.Free;
                        end
       end 
   //error
   else
       begin
         //!!!Error
         Item.Free;
         Tokens.Prev; 
         Result := -1;
       end;
 end;
end;


function TXLSSyntax.GetRangeType(Range: widestring): integer;
Var l_pos: integer;
begin
   l_pos := Pos('!', Range);
   if l_pos > 0 then begin
      Range := Copy(Range, l_pos + 1, Length(Range) - l_pos); 
      if Pos(':', Range) > 0 then Result := RANGE3D else Result := REF3D
   end else  
      if Pos(':', Range) > 0 then Result := RANGE2D else Result := REF2D;
end;

{function TXLSSyntax.GetSheetIdByName(SheetName: WideString; Var SheetID: integer): integer;
begin
  Result := 1;
  if Assigned(FGetSheetIdByName) then begin
     FGetSheetIdByName(SheetName, SheetID);
     if SheetID < 1 then Result := -1;
  end else Result := -1;
end;
}


function TXLSSyntax.Parse_Cell(Cell: widestring; 
                               Var row, col: integer; 
                               Var rowrel, colrel: boolean): integer;
Var lChar: wideChar;
    lPos: integer; 
    cnt: integer;
begin
  Result := 1;
  RowRel := false;
  Cell := UpperCase(Cell);
  cnt := Length(Cell);
  lPos := 1; 

  if lPos > cnt then Result := -1; 

  if Result > 0 then begin
     //Col
     ColRel := (Cell[lPos] = '$');
     if ColRel then begin
        Inc(lPos);
        if lPos > cnt then Result := -1; 
     end;
  end;
   
  if Result > 0 then begin
     lChar := Cell[lPos];
     if (lChar >= 'A') and (lChar <= 'Z') then begin
        Col := 0; 
        while (lChar >= 'A') and (lChar <= 'Z') and (Col <= (XLSXMaxCol + 1)) do begin
           Col := Col * 26 + Ord(lChar) - Ord('A') + 1;
           Inc(lPos);
           if lPos > cnt then break;
           lChar := Cell[lPos];
        end;
     end else if (lChar >= '0') and (lChar <= '9') then begin
        //entire row  
        Col := 0;
        RowRel := ColRel;
        ColRel := false;
        Result := 2; 
     end else begin
        Result := -1;
     end;
  end;

  //Row
  if Result = 1 then begin
     if lPos <= cnt then begin
        RowRel := (Cell[lPos] = '$');
        if RowRel then begin
           Inc(lPos);
           if lPos > cnt then Result := -1;  
        end;
     end;
  end;

  if (Result = 1) or (Result = 2) then begin 
     Cell := Copy(Cell, lPos, Length(Cell) - lPos + 1);
     if Cell = '' then begin
        if RowRel then Result := -1
        else if Result = 2 then Result := -1
        else begin
           Result := 3; //entire column 
           RowRel := true;
           Row := 0; 
        end;
     end else begin 
        Row := strtointdef(Cell, -1);
     end; 
  end;

  //check ranges
  if Result = 1 then begin
     if (Row < 1) or (Row > (XLSXMaxRow + 1)) then Result := -1;
     if (Col < 1) or (Col > (XLSXMaxCol + 1)) then Result := -1;
     Dec(Row);
     Dec(Col);
  end else if Result = 2 then begin
     if (Row < 1) or (Row > (XLSXMaxRow  + 1)) then Result := -1;
     Dec(Row);
     Col := 0;
  end else if Result = 3 then begin
     if (Col < 1) or (Col > (XLSXMaxCol + 1))   then Result := -1;
     Dec(Col);
     Row := 0;
  end;
end;

function  TXLSSyntax.Parse_Name(Item: TXLSSyntaxItem; Value: WideString): integer;
var l_pos: integer;
    l_ExternID: integer;
    lSheet1: WideString;
    lSheet1ID: integer;
    lSheet2ID: integer;
    lSupBookIndex: integer;
    l_NameID: integer;
begin
  //Separate sheet and range
  Result := 1;
  l_pos := pos('!', Value);
  l_ExternID := 0;
  l_NameID := 0;
  lSheet1ID := FCurSheetID;

  if l_pos > 0 then begin
     lSheet1 := Copy(Value, 1, l_pos - 1);
     Value   := Copy(Value, l_pos + 1, Length(Value) - l_pos);
     l_ExternID := FExtern.GetExternID(lSheet1, lSheet1);
     if l_ExternID < 1 then Result := -1;
     if Result = 1 then begin
        Result := FExtern.GetSheetIDs(l_ExternID, lSupBookIndex, lSheet1ID, lSheet2ID);
     end;
  end;

  if Result = 1 then begin
     l_NameID := FExtern.GetNameIDByName(Value, lSheet1ID);
     if l_NameID < 1 then Result := -1;
  end;

  if Result = 1 then begin
     Item.ItemType := SA_NAME;
     Item.IntValue := l_NameID;
     if not Assigned(Item.FRangeValue) then begin
         Item.FRangeValue := TXLSRangeItem.Create;   
     end;
     Item.Range.FExternID := l_ExternID;
  end;
  
end;


function  TXLSSyntax.Parse_Range(Item: TXLSSyntaxItem; Value: widestring): integer;
Var l_pos: integer;
    lCell1, lCell2: widestring;
    lSheet1, lSheet2: widestring;
    lStoredRangeType: integer;
    ret: integer;
    lValue: WideString;
begin
  Result := 1;
  lValue := Value;

  if (lowercase(lValue) = 'true') or
     (lowercase(lValue) = 'false') then begin
     Item.ItemType := SA_BOOL; 
     Item.IntValue := Ord((lowercase(lValue) = 'true'));
     exit;
  end;

  if not Assigned(Item.FRangeValue) then begin
     Item.FRangeValue := TXLSRangeItem.Create;   
     Item.ItemType := SA_RANGE;
     Item.Value := '';
  end;

  with Item.FRangeValue do begin
     FRangeType := GetRangeType(lValue);
     case FRangeType of
        Ref2D: begin
                  Result := Parse_cell(lValue, FFirstRow, FFirstCol, FFirstRowRel, FFirstColRel); 
                  if Result <> 1 then Result := -1;
               end;
        Range2D: 
           begin
             l_pos := Pos(':', lValue);
             ret := -1;

             if l_pos > 0 then begin
                lCell1 := Copy(lValue, 1, l_pos - 1);
                lCell2 := Copy(lValue, l_pos + 1, length(lValue) - l_pos);
                ret := Parse_cell(lCell1, FFirstRow, FFirstCol, FFirstRowRel, FFirstColRel); 
             end;

             if ret > 0 then begin
                Result := Parse_cell(lCell2, FLastRow, FLastCol, FLastRowRel, FLastColRel);
                if Result <> ret then Result := -1;
                if Result > 0 then begin
                   case ret of 
                       2: begin
                            //entire row
                            FFirstCol := 0;
                            FLastCol  := XLSXMaxCol;
                            Result := 1;   
                          end;
                       3: begin
                            //entire column
                            FFirstRow := 0;
                            FLastRow  := XLSXMaxRow;
                            Result := 1;   
                          end;
                   end;  
                end; 
             end else 
                Result := -1
           end;
         Ref3D,Range3D: 
             begin
               //Separate sheet and range
               l_pos := pos('!', lValue);

               if l_pos > 0 then begin
                  lSheet1 := Copy(lValue, 1, l_pos - 1);
                  lValue   := Copy(lValue, l_pos + 1, Length(lValue) - l_pos);
                  lStoredRangeType := FRangeType;
                  //Parse range
                  //FRangeType := Range2D;
                  Result := Parse_Range(Item, lValue);
                  FRangeType := lStoredRangeType;
               end else begin
                  Result := -1; 
               end;

               //Separate sheet names  
               if Result = 1 then begin
                  l_pos := pos(':', lSheet1);
                  if l_pos > 0 then begin
                     lSheet2 := Copy(lSheet1, l_pos + 1, Length(lSheet1) - l_pos);
                     lSheet1  := Copy(lSheet1, 1, l_pos - 1);
                  end else begin
                     lSheet2 := lSheet1;
                  end;
               end;
  
               if Result = 1 then begin
                  //Sheet ID
                  FExternID := FExtern.GetExternID(lSheet1, lSheet2);
                  if FExternID < 1 then Result := -1;
               end;

             end;  
     end;
  end;
  if Result <> 1 then begin
     Result := Parse_name(Item, Value);
  end;
end;


function  TXLSSyntax.Parse_exprlist(Var Item: TXLSSyntaxItem): integer;
Var lChild: TXLSSyntaxItem;
begin
  Result := Parse_expr(lChild);
  if Result = 1 then begin
     Item.AddChild(lChild);
     while (Tokens.TokenType = LT_LISTSEP) and (Result = 1) do begin
        Tokens.Next;
        Result := Parse_expr(lChild);
        if Result = 1 then begin
           Item.AddChild(lChild);
        end;
     end;
  end;
  //if Result <> 1 then Item.Free;
end;

{TXLSFormula}
//constructor TXLSFormula.Create(AGetSheetIDByName:  TGetSheetIDByName;
//                               AGetSheetIndexByID: TGetSheetIndexByID 
//                               );

constructor TXLSFormula.Create(AExtern: TXLSExternSheet);
var ExtraPack: THashFunc;
begin
  inherited Create;
  FMode := 'A';
  FExtern := AExtern;
//  FGetSheetIDByName := AGetSheetIDByName;
//  FGetSheetIndexByID := AGetSheetIndexByID;
  FDecimalSeparator := '.';
  FListSeparator := ';';

  FLex := TXLSLexer.Create;
  FLex.FDecimalSeparator := FDecimalSeparator;
  FLex.FListSeparator := FListSeparator;

  FFuncs := THashFunc.Create;
  ExtraPack := THashFunc.Create;
//  FSyntax := TXLSSyntax.Create(FFuncs, FGetSheetIDByName);
  FSyntax := TXLSSyntax.Create(FFuncs, FExtern);
  
  InitFuncHash;
  InitExtraFuncHash(ExtraPack);
  FFuncs.SetExtraPack(ExtraPack);
end;

destructor TXLSFormula.Destroy;
begin
  FLex.Free;
  FSyntax.Free;
  FFuncs.Free;
  inherited Destroy;
end;

function TXLSFormula.Compile( aFormula: widestring; SheetID: integer): integer;
begin

  if not(Assigned(FLex)) then begin
     FLex    := TXLSLexer.Create;
     FLex.FDecimalSeparator := FDecimalSeparator;
     FLex.FListSeparator := FListSeparator;
  end;

  if not(Assigned(FSyntax)) then begin
     FSyntax := TXLSSyntax.Create(FFuncs, FExtern);
  end else begin
     FSyntax.Clear;
  end;

  //Lexical analysis
  FLex.Source := aFormula;
  Result := FLex.Analyse;
  if Result = 1 then begin
     //Syntax analysis
     FSyntax.Tokens := FLex.FTokens;
     Result := FSyntax.Parse(SheetID);
  end else begin
//    w riteln('analyse error in ', aFormula);
  end;
end;

function  TXLSFormula.GetCompiled( aFormula: widestring; SheetID: integer): TXLSSyntaxItem;
Var ret: integer;
begin
  ret := Compile(aFormula, SheetID);
  if ret = 1 then begin
     Result := FSyntax.SyntaxTree;
     FSyntax.SyntaxTree := nil;
  end else
     Result := nil; 
  //FLex.Clear;
  //FSyntax.Clear;

end;

function TXLSFormula.GetDataSize(Item: TXLSSyntaxItem): integer;
Var lArgsCnt: integer;
    i: integer;
    lRet: integer;
    lFunc: THashFuncEntry;
    lRangeType: integer;
    lIsNameX: boolean;
begin
  if Assigned(Item) then begin
    case Item.ItemType of
       SA_NUMBER: Result := 9;
       SA_BOOL:   Result := 2;
       SA_ARRAY:  Result := 8;
       SA_STRING: 
          begin
             if FFileFormat = xlExcel5 then
                 Result := 2 + Length(Item.Value)
             else 
                 Result := 3 + Length(Item.Value) * 2;
          end;
       SA_GROUP, SA_UNARMINUS, SA_UNARPLUS, SA_PERCENT:
          begin
            lRet := GetDataSize(Item.Child[1]);
            if lRet > 0 then Result := lRet + 1 else Result := -1
          end;
       SA_MUL, SA_DIV, SA_ADD, SA_SUB, SA_CONCAT,
       SA_LT,  SA_LE,  SA_GT,  SA_GE,
       SA_EQ,  SA_NE,  SA_POWER, SA_LIST:
          begin
            lRet := GetDataSize(Item.Child[1]);
            if lRet > 0 then Result := lRet else Result := -1;
            if Result > 0 then begin
               lRet := GetDataSize(Item.Child[2]);
               if lRet > 0 then Result := Result + lRet else Result := -1;
            end;
            if Result > 0 then Inc(Result);
          end;
       SA_RANGE:
          begin
            lRangeType := Item.FRangeValue.FRangeType;
            if FFileFormat = xlExcel5 then begin 
                case lRangeType of
                     REF2D:   Result :=  4;
                     REF3D:   Result :=  14 + 4;
                     RANGE2D: Result :=  7;
                     RANGE3D: Result :=  14 + 7;

                     REF2DERR:   Result :=  4;
                     REF3DERR:   Result :=  18;
                     RANGE2DERR: Result :=  7;
                     RANGE3DERR: Result :=  21;

                     else     Result := -1;
                end;
            end else begin
                case lRangeType of
                     REF2D:   Result :=  5;
                     REF3D:   Result :=  2 + 5;
                     RANGE2D: Result :=  9;
                     RANGE3D: Result :=  2 + 9;

                     REF2DERR:   Result :=  5;
                     REF3DERR:   Result :=  2 + 5;
                     RANGE2DERR: Result :=  9;
                     RANGE3DERR: Result :=  2 + 9;

                     else     Result := -1;
                end;
            end; 
          end;
       SA_MEMFUNC:
          begin
             lArgsCnt := Item.FChildCount;
             Result := 3;
             for i := 1 to lArgsCnt do begin
                 lRet := GetDataSize(Item.Child[i]);
                 if lRet > 0 then begin
                    Result := Result + lRet;
                 end else begin
                    Result := -1;
                    break;
                 end;
             end;
          end;
       SA_FUNC:
          begin
            lFunc := FFuncs[uppercase(Item.Value)];
            lArgsCnt := 0;
            Result := 0;

            if not(Assigned(lFunc)) then begin
               if (Item.IntValue = 255) then begin
                   lArgsCnt := -1;
               end else begin
                   Result := -1;
               end;
            end else begin
               lArgsCnt := lFunc.FArgsCnt;
            end;

            if not(Result < 0) then begin
               if lArgsCnt >= 0 then begin
                  if lArgsCnt <> Item.FChildCount then begin
                     Result := -1;
                  end else begin
                     Result := 3;
                  end;
               end else begin
                  Result := 4;
                  lArgsCnt := Item.FChildCount;
               end;
            end;

            if Result > 0 then begin
               if lArgsCnt > 0 then begin
                  for i := 1 to lArgsCnt do begin
                    lRet := GetDataSize(Item.Child[i]);
                    if lRet > 0 then begin
                       Result := Result + lRet;
                    end else begin
                       Result := -1;
                       break;
                    end;
                  end;
               end;
            end;
          end;
       SA_NAME: 
          begin
            lIsNameX := false;
            if Assigned(Item.Range) then begin
               lIsNameX := (Item.Range.FExternID > 0);
            end; 
            if lIsNameX then begin
               Result := 1 + 2; 
               if FFileFormat = xlExcel5 then begin
                  Result := Result + 8 + 2 + 12;  
               end else begin
                  Result := Result + 2 + 2;  
               end;   
            end else begin
               Result := 1 + 2; 
               if FFileFormat = xlExcel5 then begin
                  Result := Result + 12;  
               end else begin
                  Result := Result + 2;  
               end;   
            end;
          end;
       else begin
          Result := -1
       end;
    end;
  end else begin
    Result := -1;
  end;
end;

function TXLSFormula.CellToRowCol(Range: TXLSRangeItem; First: boolean; CurRow, CurCol: integer; Var aRow, aCol: integer): integer;
Var lRowRel: boolean;
    lColRel: boolean;
begin
  Result := 1;

  if First then begin
     lRowRel := Range.FFirstRowRel;
     lColRel := Range.FFirstColRel;
     aRow    := Range.FFirstRow;
     aCol    := Range.FFirstCol;
  end else begin
     lRowRel := Range.FLastRowRel;
     lColRel := Range.FLastColRel;
     aRow    := Range.FLastRow;
     aCol    := Range.FLastCol;
  end;


  if Range.FRelative then begin
     if FMode <> 'B' then begin
        if not(lRowRel) then aRow := aRow + CurRow; 
        if not(lColRel) then aCol := aCol + CurCol; 
     end;
  end;

  //check ranges
  if Result = 1 then begin
     if FMode = 'A' then begin
        if aRow < 0 then begin
           aRow := 0;
           Result := -1;
        end;
        if aCol < 0 then begin
           aCol := 0;
           Result := -1;
        end;


        if FFileFormat = xlExcel5 then begin
           if (aRow > 16383) then begin
              aRow := 16383;  
              if First then Result := -1; 
           end;
        end else begin
           if (aRow > 65535) then begin
              aRow := 65535;  
              if First then Result := -1; 
           end;
        end;

        if aCol > 255   then begin
           aCol := 255;
           if First then Result := -1;
        end; 
     end else if FMode = 'B' then begin
        if FFileFormat = xlExcel5 then begin
           if (aRow > 8191) then begin
              aRow := 8191;  
              Result := -1; 
           end;
           if (aRow < -8192) then begin
              aRow := -8192;  
              Result := -1; 
           end;
        end else begin
           if (aRow > 32767) then begin
              aRow := 32767;  
              Result := -1; 
           end;
           if (aRow < -32768) then begin
              aRow := -32768;  
              Result := -1; 
           end;
        end;

        if aCol > 127   then begin
           aCol := 127;
           Result := -1;
        end; 
        if aCol < -128   then begin
           aCol := -128;
           Result := -1;
        end; 
     end;

  end;

  //add relation option 
  if Result = 1 then begin
     if FFileFormat = xlExcel5 then begin
        if not(lRowRel) then aRow := aRow or $8000;
        if not(lColRel) then aRow := aRow or $4000;
     end else begin
        if not(lRowRel) then aCol := aCol or $8000;
        if not(lColRel) then aCol := aCol or $4000;
     end;
  end;

end;

function TXLSFormula.GetFuncNameByPtg(aPtg: integer): widestring;
begin
  Result := FFuncs.FuncName[aPtg];
end;

function TXLSFormula.GetItemData(Item: TXLSSyntaxItem; Data: TXLSBlob; aClass: integer; CurRow, CurCol: integer): integer;
Var lItemType: integer;
begin
  Result := 1;
  if not(Assigned(Item)) then Result := -1;
  if Result = 1 then begin
     lItemType := item.ItemType;
     case lItemType of
        SA_NUMBER:  Result := GetNumberData (Item, Data, aClass);
        SA_BOOL:    Result := GetBoolData   (Item, Data, aClass);
        SA_Array:   Result := GetArrayData   (Item, Data, aClass);
        SA_RANGE:   Result := GetRangeData  (Item, Data, aClass, CurRow, CurCol);
        SA_FUNC:    Result := GetFuncData   (Item, Data, aClass, CurRow, CurCol);
        SA_MEMFUNC: Result := GetMemFuncData   (Item, Data, aClass, CurRow, CurCol);
        SA_STRING:  Result := GetStringData (Item, Data, aClass); 
        SA_GROUP, SA_UNARMINUS, SA_UNARPLUS, SA_PERCENT:
           begin
             Result := GetItemData(Item.Child[1], Data, 1, CurRow, CurCol);
             if Result = 1 then begin
                case lItemType of
                  SA_GROUP:     Data.AddByte(21); {tParen  0x15}
                  SA_UNARMINUS: Data.AddByte(19); {tUminus 0x13}
                  SA_UNARPLUS:  Data.AddByte(18); {tUplus  0x12}
                  SA_PERCENT:   Data.AddByte($14); {tUplus  0x14}
                end;  
             end;
           end;
        SA_MUL, SA_DIV, SA_ADD, SA_SUB, SA_LT, 
        SA_GT,  SA_LE,  SA_GE,  SA_EQ,  SA_NE, SA_CONCAT, SA_POWER, SA_LIST:
           begin

             {if lItemType = SA_LIST then begin
                aClass := 1;
             end else begin
                aClass := 2;
             end;}

             Result := GetItemData(Item.Child[1], Data, 1, CurRow, CurCol);
             if Result = 1 then begin
	        Result := GetItemData(Item.Child[2], Data, 1, CurRow, CurCol);
             end;  
             if Result = 1 then begin
                case lItemType of                        
                  SA_ADD:      Data.AddByte($03);  {tAdd   0x03}
                  SA_SUB:      Data.AddByte($04);  {tSub   0x04}
                  SA_MUL:      Data.AddByte($05);  {tMul   0x05}
                  SA_DIV:      Data.AddByte($06);  {tDiv   0x06}
                  SA_POWER:    Data.AddByte($07);  {tPower 0x07}
                  SA_CONCAT:   Data.AddByte($08); {tConcat 0x08}
                  SA_LT:       Data.AddByte($09);  {tLT    0x09}
                  SA_LE:       Data.AddByte($0A); {tLE    0x0A}
                  SA_EQ:       Data.AddByte($0B); {tEQ    0x0B}
                  SA_GE:       Data.AddByte($0C); {tGE    0x0C}
                  SA_GT:       Data.AddByte($0D); {tGT    0x0D}
                  SA_NE:       Data.AddByte($0E); {tNE    0x0E}
                  SA_LIST:     Data.AddByte($10); {tList  0x10}
                  else Result := -1;
                end;  
             end;
           end;
        SA_NAME: Result := GetNameData(Item, Data, aClass);
        else Result := -1;
     end;
  end;
end;


function TXLSFormula.GetData(Var Data: TXLSBlob; CurRow, CurCol, CurSheetID: integer; aClass: integer): integer;
Var lSize: integer;
begin
  FIsArrayFormula := false;
  FIsArrayTransform := false;
  FCurSheetID := CurSheetID;
  if aClass = 2 then begin
     FIsArrayFormula := true;
     aClass := 1;
  end;
  lSize := GetDataSize(FSyntax.SyntaxTree);
  if lSize > 0 then begin
     Data := TXLSBlob.Create(lSize + 2);
     Data.AddWord(lSize);  
     Result := GetItemData(FSyntax.SyntaxTree, Data, aClass, CurRow, CurCol);
     if Result <> 1 then Data.Free;
  end else begin
      Result := -1;
  end;
  FCurSheetID := 0;
end;

function TXLSFormula.GetData(Var Data: TXLSBlob; CurRow, CurCol, CurSheetID: integer): integer;
begin
  Result := GetData(Data, CurRow, CurCol, CurSheetID, 1);
end;

function TXLSFormula.GetNumberData(Item: TXLSSyntaxItem; Data: TXLSBlob; aClass: integer): integer;
Var lValue: Double;
begin
  Result := 1;
  lValue := Item.DecValue;
  Data.AddByte(31); //tNum 0x1F
  Data.AddDouble(lValue);
end;

function TXLSFormula.GetBoolData(Item: TXLSSyntaxItem; Data: TXLSBlob; aClass: integer): integer;
Var lValue: integer;
begin
  Result := 1;
  lValue := Item.IntValue;
  Data.AddByte($1D); //tBool 0x1D
  Data.AddByte(lValue);
end;

function TXLSFormula.GetArrayData(Item: TXLSSyntaxItem; Data: TXLSBlob; aClass: integer): integer;
var
  lPtg: integer;
begin
  Result := 1;
  lPtg := $60;
  if aClass = 1 then lPtg := $40;
  Data.AddByte(lPtg); //tArray 0x20,0x40,0x60
  Data.AddWord(0); //not used
  Data.AddWord(0); //not used
  Data.AddWord(0); //not used
  Data.AddByte(0); //not used 
end;

function TXLSFormula.GetStringData(Item: TXLSSyntaxItem; Data: TXLSBlob; aClass: integer): integer;
begin
  Data.AddByte(23); //tStr 0x17
  Data.AddByte(Length(Item.Value));
  if FFileFormat = xlExcel5 then
     Data.AddString({$ifdef D2009}AnsiString(Item.Value){$else}Item.Value{$endif})
  else begin
     Data.AddByte($01);
     Data.AddWideString(Item.Value);
  end;
  Result := 1;
end;

function TXLSFormula.GetRangeData(Range: TXLSSyntaxItem; Data: TXLSBlob; aClass: integer; CurRow, CurCol: integer): integer;
Var lRangeType: integer;
    lRefPtg: integer;
    lrow1, lrow2: integer;
    lcol1, lcol2: integer;
    lRefErr: boolean;
begin
  if FIsArrayTransform and (aClass = 1) then begin
     aClass := 2;
  end;

  lRangeType := Range.Range.FRangeType;
  lRefErr := false;

  case lRangeType of
       REF2DERR: begin
          lRefErr := true;
          lRangeType := REF2D;
       end;

       RANGE2DERR: begin
          lRefErr := true;
          lRangeType := RANGE2D;
       end;
  end;

  case lRangeType of
     REF2D, RANGE2D:
        begin
           
          Result := 1;
          lRefPtg := $24 + $20 * aClass;

          if not(lRefErr) then begin
             if CellToRowCol(Range.FRangeValue, true, CurRow, CurCol, lrow1, lcol1) <> 1 then lRefErr := true;
          end;

          if lRangeType = RANGE2D then begin
             if not(lRefErr) then begin
                if CellToRowCol(Range.FRangeValue, false, CurRow, CurCol, lrow2, lcol2) <> 1 then lRefErr := true;
             end;
             Inc(lRefPtg);
          end;

          if lRefErr then begin
             Inc(lRefPtg, 6);
             lrow1 := 0; lrow2 := 0;
             lcol1 := 0; lcol2 := 0;
          end else if Range.FRangeValue.FRelative and (FMode = 'B') then begin
             Inc(lRefPtg, 8);
          end;

          if Result = 1 then begin
             //Add binary data
             Data.AddByte(lRefPtg);
             Data.AddWord(lrow1);
             if lRangeType = RANGE2D then Data.AddWord(lrow2);
             if FFileFormat = xlExcel5 then Data.AddByte(lcol1)
                                       else Data.AddWord(lcol1);
             if lRangeType = RANGE2D then 
                if FFileFormat = xlExcel5 then  Data.AddByte(lcol2)
                                          else  Data.AddWord(lcol2);
          end; 
        end;
     REF3D, 
     RANGE3D, 
     REF3DERR, 
     RANGE3DERR: Result := GetRange3DData(Range, lRangeType, Data, aClass, CurRow, CurCol);
     else Result := -1;
  end;
end;

function TXLSFormula.GetRange3DData(Range: TXLSSyntaxItem; RangeType:integer; Data: TXLSBlob; aClass: integer; CurRow, CurCol: integer): integer;
var iSheet1, iSheet2: integer; 
    lRow1, lCol1, lRow2, lCol2: integer;
    lRefPtg: integer;
    lRefErr: boolean;
    lSupBookIndex: integer;
begin
  lRefPtg := 0;
  iSheet1 := 0;
  iSheet2 := 0;
  Result  := 1;

  lRefErr := false;

  case RangeType of
       REF3DERR: begin
          lRefErr := true;
          RangeType := REF3D;
       end;

       RANGE3DERR: begin
          lRefErr := true;
          RangeType := RANGE3D;
       end;
  end;


  if Result = 1 then begin
     if FFileFormat = xlExcel5 then begin
        Result := FExtern.GetSheetIndexes(Range.FRangeValue.FExternID, lSupBookIndex, iSheet1, iSheet2);
        //!!!!!lSupBookIndex????!!!!
     end else begin
        iSheet1 := FExtern.GetExternIndex(Range.FRangeValue.FExternID);
        if iSheet1 < 1 then Result := -1;
     end;
  end;

  if Result = 1 then begin
     lRefPtg := $3A + $20 * aClass;
     if Not(lRefErr) then begin
        if CellToRowCol(Range.FRangeValue, true, CurRow, CurCol, lrow1, lcol1) <> 1 then lRefErr := true;
     end;

     if RangeType = RANGE3D then begin
        Inc(lRefPtg);
        if Not(lRefErr) then begin
           if CellToRowCol(Range.FRangeValue, false, CurRow, CurCol, lrow2, lcol2) <> 1 then lRefErr := true; 
        end;
     end;
     if lRefErr then begin
        Inc(lRefPtg, 2);
        lcol1 := 0; lcol2 := 0;
        lrow1 := 0; lrow2 := 0;
     end;
  end;

  if Result = 1 then begin
      Data.AddByte(lRefPtg);
      if FFileFormat = xlExcel5 then begin
         Data.AddWord($FFFF - iSheet1 + 1);
         Data.AddDouble(0);
         Data.AddWord(iSheet1 - 1);
         Data.AddWord(iSheet2 - 1);
      end else begin
         Data.AddWord(iSheet1 - 1);
      end;

      Data.AddWord(lrow1);
      if RangeType = RANGE3D then Data.AddWord(lrow2);
      if FFileFormat = xlExcel5 then Data.AddByte(lcol1)
                                else Data.AddWord(lcol1);
      if RangeType = RANGE3D then 
         if FFileFormat = xlExcel5 then Data.AddByte(lcol2)
                                   else Data.AddWord(lcol2);
  end;
end;

function TXLSFormula.GetNameXData(Item: TXLSSyntaxItem; Data: TXLSBlob; aClass: integer): integer;
var //lSheet1ID, lSheet2ID: integer; 
    StoreExternID: integer; 
    lPtg: integer;
    lExternID: integer;
//    lSupBookIndex: integer;
//    lExternID: integer;
    lNameIndex: integer;
    lIsExtBook: boolean;
begin
  Result := 1;
  lPtg := $39 + $20 * aClass;
  lExternID := Item.Range.FExternID;
  lIsExtBook := not(FExtern.IsTheSameWorkbook(lExternID));
  if lIsExtBook then begin
     lNameIndex := Item.IntValue;
  end else begin
  lNameIndex := FExtern.GetNameStoreIndexByID(Item.IntValue);
  end;

  if FFileFormat = xlExcel5 then begin
     StoreExternID := FExtern.GetExcel5BookExternID();
  end else begin
     StoreExternID := FExtern.GetExternIndex(Item.FRangeValue.FExternID);
     if StoreExternID < 1 then Result := -1;
  end;

  if Result = 1 then begin
     Data.AddByte(lPtg); 
      if FFileFormat = xlExcel5 then begin
         Data.AddWord($FFFF - StoreExternID + 1); //negative one-based index
         Data.AddDouble(0);
         Data.AddWord(lNameIndex);
         Data.AddDouble(0);
         Data.AddLong(0);
      end else begin
         Data.AddWord(StoreExternID - 1); //positive zero-based index
         Data.AddWord(lNameIndex);
         Data.AddWord(0);
      end;
  end;

end;

function TXLSFormula.GetNameData(Item: TXLSSyntaxItem; Data: TXLSBlob; aClass: integer): integer;
var lPtg: integer;
    lExternID: integer;
    lNameIndex: integer;
begin
   lExternID := 0;
   Result := 1;

   if FIsArrayTransform and (aClass = 1) then begin
      aClass := 2;
   end;

   if Assigned(Item.Range) then begin
      if Item.Range.FExternID > 0 then begin
         lExternID := Item.Range.FExternID;
      end;
   end;
 
   if lExternID > 0 then begin
      Result := GetNameXData(Item, Data, aClass);
   end else begin
      lPtg := $23 + $20 * aClass;
      lNameIndex := FExtern.GetNameStoreIndexByID(Item.IntValue);
      if lNameIndex < 0 then lNameIndex := 0;
      Data.AddByte(lPtg);
      Data.AddWord(lNameIndex);
      Data.AddWord(0); //not used  
      if FFileFormat = xlExcel5 then begin
         Data.AddLong(0); //not used  
         Data.AddLong(0); //not used  
         Data.AddWord(0); //not used  
      end;
  end;
end;



function TXLSFormula.GetMemFuncData(Item: TXLSSyntaxItem; Data: TXLSBlob; aClass: integer; CurRow, CurCol: integer): integer;
Var lArgsCnt: integer;
    i: integer;
    pos: longword;
    sz: integer;
begin
  Result := 1;
  lArgsCnt := Item.ChildCount;
  if Result = 1 then begin
     Data.AddByte($29);
     pos := Data.DataLength; 
     Data.AddWord(0); 
     if lArgsCnt > 0 then begin
        for i := 1 to lArgsCnt do begin
           Result := GetItemData(Item.Child[i], Data, aClass, CurRow, CurCol);
           if Result <> 1 then break;
        end;
        sz := Data.DataLength - pos - 2; 
        Data.SetWord(sz, pos); 
     end;
  end;
end;


function TXLSFormula.GetFuncData(Item: TXLSSyntaxItem; Data: TXLSBlob; aClass: integer; CurRow, CurCol: integer): integer;
Var lArgsCnt: integer;
    lFuncArgsCnt: integer;
    //lClass: integer;
    i: integer;
    lFuncInfo: THashFuncEntry;
    tFunc: byte;
    lRetClass: integer;
    lArgClass: integer;
    ltransf: boolean;
    lIsExtra: boolean;
    lFuncPtg: integer;
    lExternID: integer;
    lNameID: integer;
    lFuncName: string;
begin
  Result := 1;
  lIsExtra := false;
  lFuncArgsCnt := -1;
  lArgsCnt := Item.ChildCount;
  lFuncInfo := FFuncs[UpperCase(Item.Value)];
  lRetClass := aClass;
  lFuncPtg := -1;

  if not(Assigned(lFuncInfo)) then begin
     if Item.IntValue = 255 then begin
        //extra func
        lFuncPtg := 255;
        lIsExtra := true;
        lExternId := Item.Child[1].Range.FExternId; 
        lNameId := Item.Child[1].IntValue;
        lFuncName := FExtern.GetExtraFuncName(lExternId, lNameId);
        lFuncInfo := FFuncs.GetExtraFunctionEntry(lFuncName);
        if not(Assigned(lFuncInfo)) then begin
           Result := -1;
        end;
     end else begin
        Result := -1;
     end;
  end else begin
     lFuncPtg := lFuncInfo.FPtg;
     lFuncArgsCnt := lFuncInfo.FArgsCnt;
     lRetClass := lFuncInfo.FRetClass;
  end;

  if Result = 1 then begin
     if (lFuncArgsCnt >= 0) and (lFuncArgsCnt <> lArgsCnt) then begin
        //!!!Error invalid number of arguments
        Result := -1;
     end;
  end;

  if (Result = 1) and (lIsExtra) then begin
     if (lArgsCnt < 1) then begin
        //for extra function should be at least one argument
        Result := -1;
     end;

     if (lFuncInfo.FArgsCnt >= 0) and (lFuncInfo.FArgsCnt <> (lArgsCnt - 1)) then begin
        //!!!Error invalid number of arguments
        Result := -1;
     end;
  end;

  if Result = 1 then begin
     if lArgsCnt > 0 then begin
        for i := 1 to lArgsCnt do begin
           lArgClass := lFuncInfo.ArgClass[i];
           ltransf := false;

           if lIsExtra and (i = 1) then begin
              lArgClass := 0;
           end else begin
           if FIsArrayFormula and not(FIsArrayTransform) then begin
              if lArgClass = 0 then begin
                 ltransf := true;
                 FIsArrayTransform := true;
              end else if (lArgClass = 1) and (lRetClass = 0) then begin
                 ltransf := true;
                 FIsArrayTransform := true;
              end;
           end;
           end;

           Result := GetItemData(Item.Child[i], Data, lArgClass , CurRow, CurCol);

           if ltransf then begin
              FIsArrayTransform := false;
           end;

           if Result <> 1 then break;
        end;
     end;
  end;

  if Result = 1 then begin

     if ((aClass <= 1) and (FIsArrayTransform) and (lRetClass = 1)) or
        ((aClass = 1) and (FIsArrayTransform) and (lRetClass = 0)) then begin
        lRetClass := 2;
     end else begin
     if (lRetClass = 0) and (aClass = 1) then begin
        lRetClass := aClass;
     end;     
     end;
      
     if lFuncArgsCnt >= 0 then begin
        tFunc := $21 + $20 * lRetClass;
     end else begin
        tFunc := $22 + $20 * lRetClass;
     end; 

     Data.AddByte(tFunc);

     if lFuncArgsCnt < 0 then begin
        Data.AddByte(lArgsCnt);
     end;

     Data.AddWord(lFuncPtg);

  end;  
end;

procedure TXLSFormula.SetCompiled(aFormula:TXLSSyntaxItem);
begin
  if not(Assigned(FSyntax)) then begin
     FSyntax := TXLSSyntax.Create(FFuncs, FExtern);
  end else begin
     FSyntax.Clear;
  end;
  FSyntax.SyntaxTree := aFormula;
end;

function TXLSFormula.GetStoreData(aFormula:TXLSSyntaxItem; Var lData: TXLSBlob; CurRow, CurCol, CurSheetID: integer): integer;
begin
 SetCompiled(aFormula);
 Result := GetData(lData, CurRow, CurCol, CurSheetID);
 FSyntax.SyntaxTree := nil;
end;

function TXLSFormula.GetStoreDataExt(aFormula:TXLSSyntaxItem; Var lData: TXLSBlob; CurRow, CurCol, CurSheetID: integer; aClass: integer): integer;
begin
 SetCompiled(aFormula);
 Result := GetData(lData, CurRow, CurCol, CurSheetID, aClass);
 FSyntax.SyntaxTree := nil;
end;


{>>>>>>>>>>>>>>>>>>>>TRANSLATE }
function  TXLSFormula.TranslateUnary(lData: TXLSBlob; Var Offset: longword;
                                     BiffVer: word; 
                                     Stack: TXLSSyntaxStack): integer;
Var tokenid: byte;
    Item: TXLSSyntaxItem;
begin
  Result := 1; 
  tokenid := lData.GetByte(offset);
  inc(offset); 
  case tokenid of
     {Unary Operator Tokens}
     $12,$13,$14,$15:
     begin
       if Stack.Count < 1 then Result := -1;
       if Result = 1 then begin
          Item := TXLSSyntaxItem.Create();
          case tokenid of
             $12 {tUplus Unary plus}  : Item.ItemType    := SA_UNARPLUS; 
             $13 {tUminus Unary minus}: Item.ItemType    := SA_UNARMINUS;
             $15 {tParen Parentheses} : Item.ItemType    := SA_GROUP;
             $14 {tPercent Percent}   : Item.ItemType    := SA_PERCENT;
          end;
          Item.AddChild(Stack.Pop());
          Stack.Push(Item); 
       end;
     end; 
     else Result := -1;
  end;
end;

function  TXLSFormula.TranslateBinary(lData: TXLSBlob; Var Offset: longword;
                                      BiffVer: word; 
                                      Stack: TXLSSyntaxStack): integer;
Var tokenid: byte;
    Item: TXLSSyntaxItem;
begin
  Result := 1; 
  tokenid := lData.GetByte(offset);
  inc(offset); 
  case tokenid of
     {Binary Operator Tokens}
     $03..$0E, $10{,$OF..$11}:
     begin
       if Stack.Count < 2 then Result := -1;
       if Result = 1 then begin
          Item := TXLSSyntaxItem.Create();
          case tokenid of
             $03:Item.ItemType    := SA_ADD;  
             $04:Item.ItemType    := SA_SUB;  
             $05:Item.ItemType    := SA_MUL;  
             $06:Item.ItemType    := SA_DIV;  
             $07:Item.ItemType    := SA_POWER;  
             $08:Item.ItemType    := SA_CONCAT;  
             $09:Item.ItemType    := SA_LT;  
             $0A:Item.ItemType    := SA_LE;  
             $0B:Item.ItemType    := SA_EQ;  
             $0C:Item.ItemType    := SA_GE;  
             $0D:Item.ItemType    := SA_GT;  
             $0E:Item.ItemType    := SA_NE;  
             $10:Item.ItemType    := SA_LIST;  
          end;
          Item.PushChild(Stack.Pop());
          Item.PushChild(Stack.Pop());
          Stack.Push(Item); 
       end;
     end; 
     else Result := -1;
  end;
end;

function  TXLSFormula.TranslateAttr(lData: TXLSBlob; Var Offset: longword;
                                      BiffVer: word; 
                                      Stack: TXLSSyntaxStack): integer;
Var option: byte;
    Child: TXLSSyntaxItem;  
    Item: TXLSSyntaxItem;
    cnt: integer;
begin
  Result := 1;
  Inc(Offset);
  option := lData.GetByte(offset);   
  Inc(Offset);
  if option = $10 then begin
     Inc(Offset, 2);
     //sum with one argument
     if Stack.Count < 1 then Result := -1;
     if Result = 1 then begin
        Child := Stack.Pop;
        Item := TXLSSyntaxItem.Create();
        Item.ItemType := SA_FUNC;
        Item.IntValue := 4;
        Item.Value := 'SUM';
        Item.AddChild(Child);
        Stack.Push(Item); 
     end;
  end else if option = $04 then begin {bitFAttrChoose}
     cnt := lData.GetWord(offset);
     Inc(Offset, 2);
     Inc(Offset, (cnt + 1) * 2);
  end else begin
     Inc(Offset, 2);
  end;
end;


function  TXLSFormula.TranslateConst(lData: TXLSBlob; Var Offset: longword;
                                     BiffVer: word; 
                                     Stack: TXLSSyntaxStack): integer;
Var tokenid: byte;
    Item: TXLSSyntaxItem;
begin
  Result := 1; 
  tokenid := lData.GetByte(offset);
  case tokenid of
     $16 {tMissArg Missing argument}: Result := -1;
     $17 {pgStr String constant}:
         begin
           inc(offset);
           Item := TXLSSyntaxItem.Create();
           Item.ItemType    := SA_STRING;
           Item.Value := lData.GetBiffStringWithZero(offset, true, (BiffVer >= $0600));
           Stack.Push(Item); 
         end; 
     $1C {tErr Error constant} :      Result := -1;
     $1D {tBool Boolean constant}: 
         begin
           Item := TXLSSyntaxItem.Create();
           Item.ItemType    := SA_BOOL;
           Item.IntValue := lData.GetByte(offset + 1);
           offset := offset + 2;
           Stack.Push(Item); 
         end;
     $20,$40,$60 {tArray Array constant}: 
         begin
           Item := TXLSSyntaxItem.Create();
           Item.ItemType    := SA_ARRAY;
           offset := offset + 8;
           Stack.Push(Item); 
         end;
     $1E {tInt Integer constant}:
         begin
           Item := TXLSSyntaxItem.Create();
           Item.ItemType    := SA_NUMBER;
           Item.DecValue := lData.GetWord(offset + 1);
           offset := offset + 3;
           Stack.Push(Item); 
         end; 
     $1F {tNum Floating-point constant}:
         begin
           Item := TXLSSyntaxItem.Create();
           Item.ItemType    := SA_NUMBER;
           Item.DecValue := lData.GetDouble(offset + 1);
           offset := offset + 9;
           Stack.Push(Item); 
         end; 
     else Result := -1;
  end;
end;

function  TXLSFormula.TranslateRange(lData: TXLSBlob; Var Offset: longword;
                                     BiffVer: word; 
                                     Stack: TXLSSyntaxStack): integer;
Var tokenid: byte;
    Item: TXLSSyntaxItem;
    Value: Word;
    Ind: smallint;
    iSheet1, iSheet2: Word;  
    lSheet1, lSheet2: integer; 
    lSupBookIndex: integer;   

  function TranslateEncodedCell: integer;
  Var Value: Word;
  begin
    Result := 1; 
    with Item.Range do begin
      Value := lData.GetWord(offset);
      offset := offset + 2;
      if BiffVer >= $0600 then  begin
         FFirstRow := Value;
         Value := lData.GetWord(offset);
         FFirstCol  := Value and $00FF;
         FFirstRowRel := not((Value and $8000) = $8000);
         FFirstColRel := not((Value and $4000) = $4000);
         if FRelative then begin
            if not(FFirstRowRel) and ((FFirstRow and $8000) = $8000) then begin
               FFirstRow := -(((FFirstRow xor $FFFF) and $FFFF) + 1);
            end; 
            if not(FFirstColRel) and ((FFirstCol and $80) = $80) then begin
               FFirstCol := -(((FFirstCol xor $FF) and $FF) + 1);
            end; 
         end;
         offset := offset + 2;
      end else begin
         FFirstRow := Value and $3FFF;
         FFirstRowRel := not((Value and $8000) = $8000);
         FFirstColRel := not((Value and $4000) = $4000);
         FFirstCol := lData.GetByte(offset); 
         if FRelative then begin
            if not(FFirstRowRel) and ((FFirstRow and $2000) = $2000) then begin
               FFirstRow := -(((FFirstRow xor $3FFF) and $3FFF) + 1);
            end; 
            if not(FFirstColRel) and ((FFirstCol and $80) = $80) then begin
               FFirstCol := -(((FFirstCol xor $FF) and $FF) + 1);
            end; 
         end;
         inc(offset);
      end;
      FLastRow  := FFirstRow;
      FLastCol := FFirstCol;
      FLastRowRel := FFirstRowRel;
      FLastColRel := FFirstColRel;
    end;
  end;

  function TranslateEncodedCellErr: integer;
  begin
    Result := 1; 
    with Item.Range do begin
      FFirstRow := 0;
      FFirstCol := 0;
      FFirstRowRel := true;
      FFirstColRel := true;
      FLastRow    := FFirstRow;
      FLastCol    := FFirstCol;
      FLastRowRel := FFirstRowRel;
      FLastColRel := FFirstColRel;

      if BiffVer >= $0600 then  begin
         offset := offset + 4;
      end else begin
         offset := offset + 3;
      end;

    end;
  end;


  function TranslateEncodedRange: integer;
  Var Value: Word;
  begin
    Result := 1; 
    with Item.Range do begin
      Value := lData.GetWord(offset);
      offset := offset + 2;
      if BiffVer >= $0600 then  begin
         FFirstRow := Value;
         FLastRow  := lData.GetWord(offset);
         offset := offset + 2;
         Value := lData.GetWord(offset);
         FFirstCol  := Value and $00FF;
         FFirstRowRel := not((Value and $8000) = $8000);
         FFirstColRel := not((Value and $4000) = $4000);
         offset := offset + 2;
         Value := lData.GetWord(offset);
         FLastCol  := Value and $00FF;
         FLastRowRel := not((Value and $8000) = $8000);
         FLastColRel := not((Value and $4000) = $4000);
         offset := offset + 2;
         if FRelative then begin
            if not(FFirstRowRel) and ((FFirstRow and $8000) = $8000) then begin
               FFirstRow := -(((FFirstRow xor $FFFF) and $FFFF) + 1);
            end; 
            if not(FFirstColRel) and ((FFirstCol and $80) = $80) then begin
               FFirstCol := -(((FFirstCol xor $FF) and $FF) + 1);
            end; 
            if not(FLastRowRel) and ((FLastRow and $8000) = $8000) then begin
               FLastRow := -(((FLastRow xor $FFFF) and $FFFF) + 1);
            end; 
            if not(FLastColRel) and ((FLastCol and $80) = $80) then begin
               FLastCol := -(((FLastCol xor $FF) and $FF) + 1);
            end; 
         end;
      end else begin
         FFirstRow := Value and $3FFF;
         FFirstRowRel := not((Value and $8000) = $8000);
         FFirstColRel := not((Value and $4000) = $4000);
         Value := lData.GetWord(offset);
         offset := offset + 2;
         FLastRow := Value and $3FFF;
         FLastRowRel := not((Value and $8000) = $8000);
         FLastColRel := not((Value and $4000) = $4000);
         FFirstCol := lData.GetByte(offset); 
         inc(offset);
         FLastCol := lData.GetByte(offset); 
         inc(offset);

         if FRelative then begin
            if not(FFirstRowRel) and ((FFirstRow and $2000) = $2000) then begin
               FFirstRow := -(((FFirstRow xor $3FFF) and $3FFF) + 1);
            end; 
            if not(FFirstColRel) and ((FFirstCol and $80) = $80) then begin
               FFirstCol := -(((FFirstCol xor $FF) and $FF) + 1);
            end; 
            if not(FLastRowRel) and ((FLastRow and $2000) = $2000) then begin
               FLastRow := -(((FLastRow xor $3FFF) and $3FFF) + 1);
            end; 
            if not(FFirstColRel) and ((FLastCol and $80) = $80) then begin
               FLastCol := -(((FLastCol xor $FF) and $FF) + 1);
            end; 
         end;

      end;
    end;
  end;
  
  function TranslateEncodedRangeErr: integer;
  begin
    Result := 1; 
    with Item.Range do begin
      FFirstRow := 0;
      FFirstCol := 0;
      FFirstRowRel := true;
      FFirstColRel := true;
      FLastRow    := FFirstRow;
      FLastCol    := FFirstCol;
      FLastRowRel := FFirstRowRel;
      FLastColRel := FFirstColRel;

      if BiffVer >= $0600 then  begin
         offset := offset + 8;
      end else begin
         offset := offset + 6;
      end;

    end;
  end;

begin
  Result := 1; 
  tokenid := lData.GetByte(offset);
  inc(offset);

  Item := TXLSSyntaxItem.Create();
  Item.ItemType := SA_RANGE;
  Item.Range    := TXLSRangeItem.Create;
  Item.IntValue := tokenid;
  case tokenid of
     $24, $44, $64, {tRef 2D cell reference}
     $2C, $4C, $6C: {tRefN A reference to a cell in the same sheet}   
          begin
            Item.Range.FRangeType := REF2D;
            Item.Range.FRelative := ((tokenid and $8) = $8);
            Result := TranslateEncodedCell();
          end;

     $2A, $4A, $6A: {tRefErr 2D cell reference}
          begin
            Item.Range.FRangeType := REF2DERR;
            Item.Range.FRelative := false;
            Result := TranslateEncodedCellErr();
          end;

     $25, $45, $65, {tArea 2D reference to a cell range}
     $2D, $4D, $6D: { tAreaN a reference to a cell range in the same sheet}
          begin
            Item.Range.FRangeType := RANGE2D;
            Item.Range.FRelative := ((tokenid and $8) = $8);
            Result := TranslateEncodedRange();
          end;

     $2B, $4B, $6B: {tAreaErr 2D cell reference}
          begin
            Item.Range.FRangeType := RANGE2DERR;
            Item.Range.FRelative := false;
            Result := TranslateEncodedRangeErr();
          end;


     $3A, $5A, $7A, {tRef3d A 3D reference or an external reference to a cell}
     $3C, $5C, $7C, {tRef3dErr A 3D reference or an external reference to a cell}
     $3B, $5B, $7B, {tArea3d A 3D reference or an external reference to a cell range}
     $3D, $5D, $7D: {tArea3dErr A 3D reference or an external reference to a cell range}
          begin
            with Item.Range do begin
              case tokenid of
                 $3A, $5A, $7A: FRangeType := REF3D;
                 $3C, $5C, $7C: FRangeType := REF3DERR;
                 $3B, $5B, $7B: FRangeType := RANGE3D;
                 $3D, $5D, $7D: FRangeType := RANGE3DERR;
              end; 

              Item.Range.FRelative := false;
             
              Value := lData.GetWord(offset);
              offset := offset + 2;
              iSheet1 := 0;
              iSheet2 := 0; 
              //is the onebased index to EXTERNSHEET record
              if BiffVer < $0600 then begin
                 //version < biff8
                 Ind := smallint(Value);
                 if Ind > 0 then Result := -1; //External reference is not supported  
                 offset := offset + 8;
                 if Result = 1 then begin
                    iSheet1 := lData.GetWord(offset);
                    if iSheet1 = $FFFF then Result := -1; //Deleted Sheet
                    offset := offset + 2;
                    iSheet2 := lData.GetWord(offset);
                    if iSheet2 = $FFFF then Result := -1; //Deleted Sheet
                    offset := offset + 2;
                 end;
                 if Result = 1 then begin
                    FExternID := FExtern.GetExternID(iSheet1 + 1, iSheet2 + 1);
                 end; 
              end else begin
                 //version >= biff8
                 FExternID := Value + 1;
                 //check FExternID
                 Result    := FExtern.GetSheetIndexes(FExternID, lSupBookIndex, lSheet1, lSheet2);
              end;

              //Encode cell/range address
              if Result = 1 then begin
                 case FRangeType of
                    REF3D:   Result := TranslateEncodedCell();
                    RANGE3D: Result := TranslateEncodedRange();  
                    REF3DERR:   Result := TranslateEncodedCellErr();
                    RANGE3DERR: Result := TranslateEncodedRangeErr();  
                 end;
              end;
            end;
          end;
     else Result := -1;
  end;

  if Result = 1 then Stack.Push(Item) 
                else Item.Free;
end;

function  TXLSFormula.TranslateMemFunc(lData: TXLSBlob; Var Offset: longword;
                                       BiffVer: word; 
                                       Stack: TXLSSyntaxStack): integer;
Var tokenid: byte;
    len: integer;
    Item: TXLSSyntaxItem;
    subTree: TXLSSyntaxItem;
begin
  Result := 1; 

  len := 0;
  tokenid := lData.GetByte(offset);
  inc(offset); 
  Item  := TXLSSyntaxItem.Create();
  Item.ItemType    := SA_MEMFUNC;

  case tokenid of 
     $29, $49, $69 {tMemFunc}:
        begin
          len := lData.GetWord(offset);
        end;
     else Result := -1;
  end;

  if (Result = 1) and (len > 0) then begin
     subTree := GetTranslated(lData, Offset, BiffVer); 
     if Assigned(subTree) then begin
        Item.PushChild(subTree); 
        //Inc(Offset, len + 2);
     end else begin
        Result := -1; 
     end;  
  end;

  if Result = 1 then begin
     Stack.Push(Item);
  end else begin 
     Item.Free;
  end;

end;



function  TXLSFormula.TranslateFunc(lData: TXLSBlob; Var Offset: longword;
                                    BiffVer: word; 
                                    Stack: TXLSSyntaxStack): integer;
Var tokenid: byte;
    argsn, i : integer;
    Item: TXLSSyntaxItem;
begin
  Result := 1; 
  tokenid := lData.GetByte(offset);
  inc(offset); 
  Item  := TXLSSyntaxItem.Create();
  Item.ItemType    := SA_FUNC;
  argsn := 0;
  case tokenid of 
     $21, $41, $61 {tFunc}:
        begin
          if BiffVer >= $0600 then  begin
             Item.IntValue := lData.GetWord(offset);
             offset := offset + 2
          end else begin
             Item.IntValue := lData.GetByte(offset);
             offset := offset + 1;
          end;
          argsn := FFuncs.ArgsCnt[Item.IntValue];
        end;
     $22, $42, $62 {tFuncVar}:
        begin
          argsn := lData.GetByte(offset);
          inc(offset);
          Item.IntValue := lData.GetWord(offset);
          offset := offset + 2;
        end;
     else Result := -1;
  end;

  if Result = 1 then Item.Value := FFuncs.FuncName[Item.IntValue]; 
  
  if (Result = 1) and (argsn < 0) then Result := -1;

  if Result = 1 then begin
      if argsn > 0 then begin
         if argsn <= Stack.Count then
            for i := 1 to argsn do Item.PushChild(Stack.Pop)
         else begin   
           Result := -1; 
         end;
      end;
      if Result = 1 then Stack.Push(Item);
  end;
  if Result = -1 then Item.Free;
end;


function  TXLSFormula.TranslateName(lData: TXLSBlob; Var Offset: longword;
                                    BiffVer: word; 
                                    Stack: TXLSSyntaxStack): integer;
Var tokenid: byte;
    Item: TXLSSyntaxItem;
    wValue: Word;
    Ind: smallint;
    id: integer;
    lSheet1, lSheet2: integer; 
    lSupBookIndex: integer;   
//    lExcel5ExternID: integer;
begin
  Result := 1; 
  tokenid := lData.GetByte(offset);
  inc(offset); 
  Item  := TXLSSyntaxItem.Create();
  Item.ItemType    := SA_NAME;
  case tokenid of 
     $23, $43, $63 {tName}:
        begin
          Item.IntValue := lData.GetWord(offset);
          if BiffVer >= $0600 then  begin
             offset := offset + 4
          end else begin
             offset := offset + 14;
          end;
        end;
     $39, $59, $79 {tNameX}:
        begin
          if not Assigned(Item.FRangeValue) then begin
             Item.FRangeValue := TXLSRangeItem.Create;   
          end;

          wValue := lData.GetWord(offset); 
          Inc(offset, 2);

          //is the onebased index to EXTERNSHEET record
          if BiffVer < $0600 then begin
             //version < biff8
             Result := 1;
             offset := offset + 8;
             Ind := smallint(wValue);
             if Ind >= 0 then begin
                Result := -1; //External reference is not supported  
             end;
               
          end else begin
             //version >= biff8
             Item.FRangeValue.FExternID := wValue;
             //check FExternID
             Result := FExtern.GetSheetIndexes(Item.FRangeValue.FExternID, lSupBookIndex, lSheet1, lSheet2);
          end;

          Item.IntValue := lData.GetWord(offset);
          if BiffVer >= $0600 then  begin
             offset := offset + 2 + 2
          end else begin
             offset := offset + 2 + 12;
             if Result = 1 then begin
                 //Get ExternID using NameID  
                 id := FExtern.GetExternIDByNameID(Item.IntValue);
                 if id < 0 then id := 0; 
                 Item.FRangeValue.FExternID := id;
             end;
          end;

        end;
     else Result := -1;
  end;

  if Result = 1 then begin
     Stack.Push(Item);
  end else begin
     Item.Free;
  end;
end;



function  TXLSFormula.GetTranslated(lData: TXLSBlob; var Offset: longword; BiffVer: word):TXLSSyntaxItem;
Var lsz:    longword;
begin
  lsz := lData.GetWord(offset);
  offset := offset + 2;
  Result := GetTranslated(lData, offset, lsz, BiffVer); 
end;

function  TXLSFormula.GetTranslated(lData: TXLSBlob; var Offset: longword; FormulaSize: longword; BiffVer: word):TXLSSyntaxItem;
Var lsz:    longword;
    tokenid: byte;
    Stack: TXLSSyntaxStack;
    Res: integer;
    curpos: longword; 
begin
  //StartTimer(3);
  lsz := FormulaSize;
  Stack := TXLSSyntaxStack.Create;
  Res := 1;
  curpos := offset;
  while ((offset - curpos) < lsz) and (Res = 1) do begin
    tokenid := lData.GetByte(offset);
    case tokenid of
       $03..$11: Res := TranslateBinary(lData, Offset, BiffVer, Stack);
       $19{tAttr}: Res := TranslateAttr(lData, Offset, BiffVer, Stack);

       {Unary Operator Tokens}
       $12,$13,$14,$15: Res := TranslateUnary(lData, Offset, BiffVer, Stack);
       {Constant Operand Tokens}
       $16,$17,$1C,$1D,
       $20,$40,$60,
       $1E,$1F: Res := TranslateConst(lData, Offset, BiffVer, Stack);
       $21, $41, $61, {tFunc}
       $22, $42, $62  {tFuncVar}:
                Res := TranslateFunc(lData, Offset, BiffVer, Stack);  
       $23, $43, $63,  {tName}
       $39, $59, $79   {tNameX}:
                Res := TranslateName(lData, Offset, BiffVer, Stack);  

       $29, $49, $69  {tMemFunc}:
                Res := TranslateMemFunc(lData, Offset, BiffVer, Stack);  

       $24, $44, $64, {tRef 2D cell reference}
       $2A, $4A, $6A, {tRefErr 2D cell reference}
       $25, $45, $65, {tArea 2D reference to a cell range}
       $2B, $4B, $6B, {tAreaErr 2D reference to a cell range}
       $2C, $4C, $6C, {tRefN A reference to a cell in the same sheet}   
       $2D, $4D, $6D, {tAreaN a reference to a cell range in the same sheet}
       $3A, $5A, $7A, {tRef3d A 3D reference or an external reference to a cell}
       $3C, $5C, $7C, {tRef3dErr A 3D reference or an external reference to a cell}
       $3B, $5B, $7B, {tArea3d A 3D reference or an external reference to a cell range}
       $3D, $5D, $7D: {tArea3dErr A 3D reference or an external reference to a cell range}
                 Res := TranslateRange(lData, Offset, BiffVer, Stack);
       else begin
          //w riteln('  unknown token');
          Res := -1;
       end;
       //if Res <> 1 then w riteln('error');
    end;
  end; 
  Result := nil;
  if (Res = 1) and (Stack.Count <> 1) then  begin
      Res := -1;
  end; 
  if Res = 1 then  Result := Stack.Pop;

  Stack.Free;
  //StopTimer(3);
end;

procedure TXLSFormula.SetMode(AMode: char);    
begin
  FMode := AMode;
end;

procedure TXLSFormula.SetDecimalSeparator(Value: WideChar);
begin
  FDecimalSeparator := Value;
  if Assigned(FLex) then FLex.FDecimalSeparator := Value;
end;

procedure TXLSFormula.SetListSeparator(Value: WideChar);
begin
  FListSeparator := Value;
  if Assigned(FLex) then FLex.FListSeparator := Value;
end;

{<<<<<<<<<<<<<<<<<<<<TRANSLATE}



procedure TXLSFormula.InitFuncHash;
begin
//class:  0-reference 1-value 2-array   
//funcname, ptg, retclass, argc, argclass, volatile
  FFuncs.SetValue('COUNT'        ,  0, 1,  -1,    0,    0 );  //ok
  FFuncs.SetValue('IF'           ,  1, 0,  -1,    1,    0, '100');  //ok
  FFuncs.SetValue('ISNA'         ,  2, 1,   1,    1,    0 );  //?
  FFuncs.SetValue('ISERROR'      ,  3, 1,   1,    1,    0 );  //?
  FFuncs.SetValue('SUM'          ,  4, 1,  -1,    0,    0 );  //ok
  FFuncs.SetValue('AVERAGE'      ,  5, 1,  -1,    0,    0 );  //ok
  FFuncs.SetValue('MIN'          ,  6, 1,  -1,    0,    0 );  //ok
  FFuncs.SetValue('MAX'          ,  7, 1,  -1,    0,    0 );  //ok
  FFuncs.SetValue('ROW'          ,  8, 1,  -1,    0,    0 );
  FFuncs.SetValue('COLUMN'       ,  9, 1,  -1,    0,    0 );
  FFuncs.SetValue('NA'           , 10, 1,   0,    0,    0 );
  FFuncs.SetValue('NPV'          , 11, 1,  -1,    0,    0, '1' );
  FFuncs.SetValue('STDEV'        , 12, 1,  -1,    0,    0 );
  FFuncs.SetValue('DOLLAR'       , 13, 1,  -1,    1,    0 );
  FFuncs.SetValue('FIXED'        , 14, 1,  -1,    1,    0 );
  FFuncs.SetValue('SIN'          , 15, 1,   1,    1,    0 ); //ok
  FFuncs.SetValue('COS'          , 16, 1,   1,    1,    0 ); //ok
  FFuncs.SetValue('TAN'          , 17, 1,   1,    1,    0 ); //ok
  FFuncs.SetValue('ATAN'         , 18, 1,   1,    1,    0 ); //ok
  FFuncs.SetValue('PI'           , 19, 1,   0,    1,    0 ); //ok
  FFuncs.SetValue('SQRT'         , 20, 1,   1,    1,    0 ); //ok
  FFuncs.SetValue('EXP'          , 21, 1,   1,    1,    0 ); 
  FFuncs.SetValue('LN'           , 22, 1,   1,    1,    0 );
  FFuncs.SetValue('LOG10'        , 23, 1,   1,    1,    0 ); //ok
  FFuncs.SetValue('ABS'          , 24, 1,   1,    1,    0 ); //ok
  FFuncs.SetValue('INT'          , 25, 1,   1,    1,    0 );
  FFuncs.SetValue('SIGN'         , 26, 1,   1,    1,    0 ); //ok
  FFuncs.SetValue('ROUND'        , 27, 1,   2,    1,    0 );
  FFuncs.SetValue('LOOKUP'       , 28, 1,  -1,    0,    0, '100');
  FFuncs.SetValue('INDEX'        , 29, 0,  -1,    0,    1, '0111' );
  FFuncs.SetValue('REPT'         , 30, 1,   2,    1,    0 );
  FFuncs.SetValue('MID'          , 31, 1,   3,    1,    0 );
  FFuncs.SetValue('LEN'          , 32, 1,   1,    1,    0 );
  FFuncs.SetValue('VALUE'        , 33, 1,   1,    1,    0 );
  FFuncs.SetValue('TRUE'         , 34, 1,   0,    1,    0 ); //ok
  FFuncs.SetValue('FALSE'        , 35, 1,   0,    1,    0 ); //ok
  FFuncs.SetValue('AND'          , 36, 1,  -1,    1,    0 ); //ok
  FFuncs.SetValue('OR'           , 37, 1,  -1,    1,    0 ); //ok
  FFuncs.SetValue('NOT'          , 38, 1,   1,    1,    0 ); //ok
  FFuncs.SetValue('MOD'          , 39, 1,   2,    1,    0 ); //ok
  FFuncs.SetValue('DCOUNT'       , 40, 1,   3,    0,    0 );
  FFuncs.SetValue('DSUM'         , 41, 1,   3,    0,    0 );
  FFuncs.SetValue('DAVERAGE'     , 42, 1,   3,    0,    0 );
  FFuncs.SetValue('DMIN'         , 43, 1,   3,    0,    0 );
  FFuncs.SetValue('DMAX'         , 44, 1,   3,    0,    0 );
  FFuncs.SetValue('DSTDEV'       , 45, 1,   3,    0,    0 );
  FFuncs.SetValue('VAR'          , 46, 1,  -1,    0,    0 );
  FFuncs.SetValue('DVAR'         , 47, 1,   3,    0,    0 );
  FFuncs.SetValue('TEXT'         , 48, 1,   2,    1,    0 );
  FFuncs.SetValue('LINEST'       , 49, 2,  -1,    0,    0, '0011' );
  FFuncs.SetValue('TREND'        , 50, 2,  -1,    0,    0, '0001' );
  FFuncs.SetValue('LOGEST'       , 51, 2,  -1,    0,    0, '0011');
  FFuncs.SetValue('GROWTH'       , 52, 2,  -1,    0,    0, '0001' );
  FFuncs.SetValue('PV'           , 56, 1,  -1,    1,    0 );
  FFuncs.SetValue('FV'           , 57, 1,  -1,    1,    0 );
  FFuncs.SetValue('NPER'         , 58, 1,  -1,    1,    0 );
  FFuncs.SetValue('PMT'          , 59, 1,  -1,    1,    0 );
  FFuncs.SetValue('RATE'         , 60, 1,  -1,    1,    0 );
  FFuncs.SetValue('MIRR'         , 61, 1,   3,    0,    0, '011');
  FFuncs.SetValue('IRR'          , 62, 1,  -1,    0,    0, '01');
  FFuncs.SetValue('RAND'         , 63, 1,   0,    1,    1 );
  FFuncs.SetValue('MATCH'        , 64, 1,  -1,    0,    0, '100');
  FFuncs.SetValue('DATE'         , 65, 1,   3,    1,    0 );
  FFuncs.SetValue('TIME'         , 66, 1,   3,    1,    0 );
  FFuncs.SetValue('DAY'          , 67, 1,   1,    1,    0 );
  FFuncs.SetValue('MONTH'        , 68, 1,   1,    1,    0 );
  FFuncs.SetValue('YEAR'         , 69, 1,   1,    1,    0 );
  FFuncs.SetValue('WEEKDAY'      , 70, 1,  -1,    1,    0 );
  FFuncs.SetValue('HOUR'         , 71, 1,   1,    1,    0 );
  FFuncs.SetValue('MINUTE'       , 72, 1,   1,    1,    0 );
  FFuncs.SetValue('SECOND'       , 73, 1,   1,    1,    0 );
  FFuncs.SetValue('NOW'          , 74, 1,   0,    1,    1 );
  FFuncs.SetValue('AREAS'        , 75, 1,   1,    0,    1 );
  FFuncs.SetValue('ROWS'         , 76, 1,   1,    0,    1 );
  FFuncs.SetValue('COLUMNS'      , 77, 1,   1,    0,    1 );
  FFuncs.SetValue('OFFSET'       , 78, 0,  -1,    1,    1, '011111' );
  FFuncs.SetValue('SEARCH'       , 82, 1,  -1,    1,    0 );
  FFuncs.SetValue('TRANSPOSE'    , 83, 2,   1,    1,    0 );
  FFuncs.SetValue('TYPE'         , 86, 1,   1,    1,    0 );
  FFuncs.SetValue('ATAN2'        , 97, 1,   2,    1,    0 );
  FFuncs.SetValue('ASIN'         , 98, 1,   1,    1,    0 );
  FFuncs.SetValue('ACOS'         , 99, 1,   1,    1,    0 );
  FFuncs.SetValue('CHOOSE'       ,100, 0,  -1,    0,    0, '10' );
  FFuncs.SetValue('HLOOKUP'      ,101, 1,  -1,    0,    0 , '1011'); //ok!
  FFuncs.SetValue('VLOOKUP'      ,102, 1,  -1,    0,    0 , '1011'); //ok!
  FFuncs.SetValue('ISREF'        ,105, 1,   1,    0,    0 );
  FFuncs.SetValue('LOG'          ,109, 1,  -1,    1,    0 );
  FFuncs.SetValue('CHAR'         ,111, 1,   1,    1,    0 );
  FFuncs.SetValue('LOWER'        ,112, 1,   1,    1,    0 ); //ok
  FFuncs.SetValue('UPPER'        ,113, 1,   1,    1,    0 ); //ok
  FFuncs.SetValue('PROPER'       ,114, 1,   1,    1,    0 );
  FFuncs.SetValue('LEFT'         ,115, 1,  -1,    1,    0 );
  FFuncs.SetValue('RIGHT'        ,116, 1,  -1,    1,    0 );
  FFuncs.SetValue('EXACT'        ,117, 1,   2,    1,    0 );
  FFuncs.SetValue('TRIM'         ,118, 1,   1,    1,    0 );
  FFuncs.SetValue('REPLACE'      ,119, 1,   4,    1,    0 );
  FFuncs.SetValue('SUBSTITUTE'   ,120, 1,  -1,    1,    0 );
  FFuncs.SetValue('CODE'         ,121, 1,   1,    1,    0 );
  FFuncs.SetValue('FIND'         ,124, 1,  -1,    1,    0 );
  FFuncs.SetValue('CELL'         ,125, 1,  -1,    0,    1, '10');
  FFuncs.SetValue('ISERR'        ,126, 1,   1,    1,    0 );
  FFuncs.SetValue('ISTEXT'       ,127, 1,   1,    1,    0 );
  FFuncs.SetValue('ISNUMBER'     ,128, 1,   1,    1,    0 );
  FFuncs.SetValue('ISBLANK'      ,129, 1,   1,    1,    0 );
  FFuncs.SetValue('T'            ,130, 1,   1,    0,    0 );
  FFuncs.SetValue('N'            ,131, 1,   1,    0,    0 );
  FFuncs.SetValue('DATEVALUE'    ,140, 1,   1,    1,    0 );
  FFuncs.SetValue('TIMEVALUE'    ,141, 1,   1,    1,    0 );
  FFuncs.SetValue('SLN'          ,142, 1,   3,    1,    0 );
  FFuncs.SetValue('SYD'          ,143, 1,   4,    1,    0 );
  FFuncs.SetValue('DDB'          ,144, 1,  -1,    1,    0 );
  FFuncs.SetValue('INDIRECT'     ,148, 0,  -1,    1,    1 );
  FFuncs.SetValue('CALL'         ,150, 1,  -1,    1,    0 );
  FFuncs.SetValue('CLEAN'        ,162, 1,   1,    1,    0 );
  FFuncs.SetValue('MDETERM'      ,163, 1,   1,    2,    0 );
  FFuncs.SetValue('MINVERSE'     ,164, 2,   1,    2,    0 );
  FFuncs.SetValue('MMULT'        ,165, 2,   2,    2,    0 );
  FFuncs.SetValue('IPMT'         ,167, 1,  -1,    1,    0 );
  FFuncs.SetValue('PPMT'         ,168, 1,  -1,    1,    0 );
  FFuncs.SetValue('COUNTA'       ,169, 1,  -1,    0,    0 );
  FFuncs.SetValue('PRODUCT'      ,183, 1,  -1,    0,    0 );
  FFuncs.SetValue('FACT'         ,184, 1,   1,    1,    0 );
  FFuncs.SetValue('DPRODUCT'     ,189, 1,   3,    0,    0 );
  FFuncs.SetValue('ISNONTEXT'    ,190, 1,   1,    1,    0 );
  FFuncs.SetValue('STDEVP'       ,193, 1,  -1,    0,    0 );
  FFuncs.SetValue('VARP'         ,194, 1,  -1,    0,    0 );
  FFuncs.SetValue('DSTDEVP'      ,195, 1,   3,    0,    0 );
  FFuncs.SetValue('DVARP'        ,196, 1,   3,    0,    0 );
  FFuncs.SetValue('TRUNC'        ,197, 1,  -1,    1,    0 );
  FFuncs.SetValue('ISLOGICAL'    ,198, 1,   1,    1,    0 );
  FFuncs.SetValue('DCOUNTA'      ,199, 1,   3,    0,    0 );
  FFuncs.SetValue('ROUNDUP'      ,212, 1,   2,    1,    0 );
  FFuncs.SetValue('ROUNDDOWN'    ,213, 1,   2,    1,    0 );
  FFuncs.SetValue('RANK'         ,216, 1,  -1,    0,    0, '101' );
  FFuncs.SetValue('ADDRESS'      ,219, 1,  -1,    1,    0 );
  FFuncs.SetValue('DAYS360'      ,220, 1,  -1,    1,    0 );
  FFuncs.SetValue('TODAY'        ,221, 1,   0,    1,    1 );
  FFuncs.SetValue('VDB'          ,222, 1,  -1,    1,    0 );
  FFuncs.SetValue('MEDIAN'       ,227, 1,  -1,    0,    0 );
  FFuncs.SetValue('SUMPRODUCT'   ,228, 1,  -1,    2,    0 );
  FFuncs.SetValue('SINH'         ,229, 1,   1,    1,    0 );
  FFuncs.SetValue('COSH'         ,230, 1,   1,    1,    0 );
  FFuncs.SetValue('TANH'         ,231, 1,   1,    1,    0 );
  FFuncs.SetValue('ASINH'        ,232, 1,   1,    1,    0 );
  FFuncs.SetValue('ACOSH'        ,233, 1,   1,    1,    0 );
  FFuncs.SetValue('ATANH'        ,234, 1,   1,    1,    0 );
  FFuncs.SetValue('DGET'         ,235, 1,   3,    0,    0 );
  FFuncs.SetValue('INFO'         ,244, 1,   1,    1,    1 );
  FFuncs.SetValue('DB'           ,247, 1,  -1,    1,    0 );
  FFuncs.SetValue('FREQUENCY'    ,252, 2,   2,    0,    0 );
  FFuncs.SetValue('ERROR.TYPE'   ,261, 1,   1,    1,    0 );
  FFuncs.SetValue('REGISTER.ID'  ,267, 1,  -1,    1,    0 );
  FFuncs.SetValue('AVEDEV'       ,269, 1,  -1,    0,    0 );
  FFuncs.SetValue('BETADIST'     ,270, 1,  -1,    1,    0 );
  FFuncs.SetValue('GAMMALN'      ,271, 1,   1,    1,    0 );
  FFuncs.SetValue('BETAINV'      ,272, 1,  -1,    1,    0 );
  FFuncs.SetValue('BINOMDIST'    ,273, 1,   4,    1,    0 );
  FFuncs.SetValue('CHIDIST'      ,274, 1,   2,    1,    0 );
  FFuncs.SetValue('CHIINV'       ,275, 1,   2,    1,    0 );
  FFuncs.SetValue('COMBIN'       ,276, 1,   2,    1,    0 );
  FFuncs.SetValue('CONFIDENCE'   ,277, 1,   3,    1,    0 );
  FFuncs.SetValue('CRITBINOM'    ,278, 1,   3,    1,    0 );
  FFuncs.SetValue('EVEN'         ,279, 1,   1,    1,    0 );
  FFuncs.SetValue('EXPONDIST'    ,280, 1,   3,    1,    0 );
  FFuncs.SetValue('FDIST'        ,281, 1,   3,    1,    0 );
  FFuncs.SetValue('FINV'         ,282, 1,   3,    1,    0 );
  FFuncs.SetValue('FISHER'       ,283, 1,   1,    1,    0 );
  FFuncs.SetValue('FISHERINV'    ,284, 1,   1,    1,    0 );
  FFuncs.SetValue('FLOOR'        ,285, 1,   2,    1,    0 );
  FFuncs.SetValue('GAMMADIST'    ,286, 1,   4,    1,    0 );
  FFuncs.SetValue('GAMMAINV'     ,287, 1,   3,    1,    0 );
  FFuncs.SetValue('CEILING'      ,288, 1,   2,    1,    0 );
  FFuncs.SetValue('HYPGEOMDIST'  ,289, 1,   4,    1,    0 );
  FFuncs.SetValue('LOGNORMDIST'  ,290, 1,   3,    1,    0 );
  FFuncs.SetValue('LOGINV'       ,291, 1,   3,    1,    0 );
  FFuncs.SetValue('NEGBINOMDIST' ,292, 1,   3,    1,    0 );
  FFuncs.SetValue('NORMDIST'     ,293, 1,   4,    1,    0 );
  FFuncs.SetValue('NORMSDIST'    ,294, 1,   1,    1,    0 );
  FFuncs.SetValue('NORMINV'      ,295, 1,   3,    1,    0 );
  FFuncs.SetValue('NORMSINV'     ,296, 1,   1,    1,    0 );
  FFuncs.SetValue('STANDARDIZE'  ,297, 1,   3,    1,    0 );
  FFuncs.SetValue('ODD'          ,298, 1,   1,    1,    0 );
  FFuncs.SetValue('PERMUT'       ,299, 1,   2,    1,    0 );
  FFuncs.SetValue('POISSON'      ,300, 1,   3,    1,    0 );
  FFuncs.SetValue('TDIST'        ,301, 1,   3,    1,    0 );
  FFuncs.SetValue('WEIBULL'      ,302, 1,   4,    1,    0 );
  FFuncs.SetValue('SUMXMY2'      ,303, 1,   2,    2,    0 );
  FFuncs.SetValue('SUMX2MY2'     ,304, 1,   2,    2,    0 );
  FFuncs.SetValue('SUMX2PY2'     ,305, 1,   2,    2,    0 );
  FFuncs.SetValue('CHITEST'      ,306, 1,   2,    2,    0 );
  FFuncs.SetValue('CORREL'       ,307, 1,   2,    2,    0 );
  FFuncs.SetValue('COVAR'        ,308, 1,   2,    2,    0 );
  FFuncs.SetValue('FORECAST'     ,309, 1,   3,    2,    0, '122');
  FFuncs.SetValue('FTEST'        ,310, 1,   2,    2,    0 );
  FFuncs.SetValue('INTERCEPT'    ,311, 1,   2,    2,    0 );
  FFuncs.SetValue('PEARSON'      ,312, 1,   2,    2,    0 );
  FFuncs.SetValue('RSQ'          ,313, 1,   2,    2,    0 );
  FFuncs.SetValue('STEYX'        ,314, 1,   2,    2,    0 );
  FFuncs.SetValue('SLOPE'        ,315, 1,   2,    2,    0 );
  FFuncs.SetValue('TTEST'        ,316, 1,   4,    2,    0, '2211');
  FFuncs.SetValue('PROB'         ,317, 1,  -1,    2,    0, '2211' );
  FFuncs.SetValue('DEVSQ'        ,318, 1,  -1,    0,    0 );
  FFuncs.SetValue('GEOMEAN'      ,319, 1,  -1,    0,    0 );
  FFuncs.SetValue('HARMEAN'      ,320, 1,  -1,    0,    0 );
  FFuncs.SetValue('SUMSQ'        ,321, 1,  -1,    0,    0 );
  FFuncs.SetValue('KURT'         ,322, 1,  -1,    0,    0 );
  FFuncs.SetValue('SKEW'         ,323, 1,  -1,    0,    0 );
  FFuncs.SetValue('ZTEST'        ,324, 1,  -1,    0,    0, '011' );
  FFuncs.SetValue('LARGE'        ,325, 1,   2,    0,    0, '01' );
  FFuncs.SetValue('SMALL'        ,326, 1,   2,    0,    0, '01' );
  FFuncs.SetValue('QUARTILE'     ,327, 1,   2,    0,    0, '01' );
  FFuncs.SetValue('PERCENTILE'   ,328, 1,   2,    0,    0, '01' );
  FFuncs.SetValue('PERCENTRANK'  ,329, 1,  -1,    0,    0, '011' );
  FFuncs.SetValue('MODE'         ,330, 1,  -1,    2,    0 );
  FFuncs.SetValue('TRIMMEAN'     ,331, 1,   2,    0,    0, '01' );
  FFuncs.SetValue('TINV'         ,332, 1,   2,    1,    0 );
  FFuncs.SetValue('CONCATENATE'  ,336, 1,  -1,    1,    0 );
  FFuncs.SetValue('POWER'        ,337, 1,   2,    1,    0 );
  FFuncs.SetValue('RADIANS'      ,342, 1,   1,    1,    0 );
  FFuncs.SetValue('DEGREES'      ,343, 1,   1,    1,    0 );
  FFuncs.SetValue('SUBTOTAL'     ,344, 1,  -1,    0,    0, '10' );
  FFuncs.SetValue('SUMIF'        ,345, 1,  -1,    0,    0, '010');
  FFuncs.SetValue('COUNTIF'      ,346, 1,   2,    0,    0, '010' );
  FFuncs.SetValue('COUNTBLANK'   ,347, 1,   1,    0,    0 );
  FFuncs.SetValue('ROMAN'        ,354, 1,  -1,    1,    0 );
  {new in BIFF8}
  FFuncs.SetValue('HYPERLINK'    ,359, 1,  -1,    1,    0 );
  FFuncs.SetValue('PHONETIC'     ,360, 1,  -1,    1,    0 );
  FFuncs.SetValue('AVERAGEA'     ,361, 1,  -1,    0,    0 );
  FFuncs.SetValue('MAXA'         ,362, 1,  -1,    0,    0 );
  FFuncs.SetValue('MINA'         ,363, 1,  -1,    0,    0 );
  FFuncs.SetValue('STDEVPA'      ,364, 1,  -1,    0,    0 );
  FFuncs.SetValue('VARPA'        ,365, 1,  -1,    0,    0 );
  FFuncs.SetValue('STDEVA'       ,366, 1,  -1,    0,    0 );
  FFuncs.SetValue('VARA'         ,367, 1,  -1,    0,    0 );
end;                                   

procedure  TXLSFormula.InitExtraFuncHash(ExtraPack: THashFunc);
begin

//class:  0-reference 1-value 2-array   
//funcname, ptg, retclass, argc, argclass, volatile
  ExtraPack.SetValue('ACCRINT'     ,     0,            1,     -1{5-7},               1,       0);  
  ExtraPack.SetValue('ACCRINTM'    ,     1,            1,     -1{3-5},               1,       0);  
  ExtraPack.SetValue('AMORDEGRC'   ,     2,            1,     -1{6-7},               1,       0);
  ExtraPack.SetValue('AMORLINC'    ,     3,            1,     -1{6-7},               1,       0);
  ExtraPack.SetValue('BESSELI'     ,     4,            1,      2,                    1,       0);
  ExtraPack.SetValue('BESSELJ'     ,     5,            1,      2,                    1,       0);
  ExtraPack.SetValue('BESSELK'     ,     6,            1,      2,                    1,       0);
  ExtraPack.SetValue('BESSELY'     ,     7,            1,      2,                    1,       0);
  ExtraPack.SetValue('BIN2DEC'     ,     8,            1,      1,                    1,       0);
  ExtraPack.SetValue('BIN2HEX'     ,     9,            1,     -1{1-2},               1,       0);
  ExtraPack.SetValue('BIN2OCT'     ,    10,            1,     -1{1-2},               1,       0);
  ExtraPack.SetValue('COMPLEX'     ,    11,            1,     -1{2-3},               1,       0);
  ExtraPack.SetValue('CONVERT'     ,    12,            1,      3,                    1,       0);
  ExtraPack.SetValue('COUPDAYBS'   ,    13,            1,     -1{3-4},               1,       0);
  ExtraPack.SetValue('COUPDAYS'    ,    14,            1,     -1{3-4},               1,       0);
  ExtraPack.SetValue('COUPDAYSNC'  ,    15,            1,     -1{3-4},               1,       0);
  ExtraPack.SetValue('COUPNCD'     ,    16,            1,     -1{3-4},               1,       0);
  ExtraPack.SetValue('COUPNUM'     ,    17,            1,     -1{3-4},               1,       0);
  ExtraPack.SetValue('COUPPCD'     ,    18,            1,     -1{3-4},               1,       0);
  ExtraPack.SetValue('CUMIPMT'     ,    19,            1,      6,                    1,       0);
  ExtraPack.SetValue('CUMPRINC'    ,    20,            1,      6,                    1,       0);
  ExtraPack.SetValue('DEC2BIN'     ,    21,            1,     -1{1-2},               1,       0);
  ExtraPack.SetValue('DEC2HEX'     ,    22,            1,     -1{1-2},               1,       0);
  ExtraPack.SetValue('DEC2OCT'     ,    23,            1,     -1{1-2},               1,       0);
  ExtraPack.SetValue('DELTA'       ,    24,            1,     -1{1-2},               1,       0);
  ExtraPack.SetValue('DISC'        ,    25,            1,     -1{4-5},               1,       0);
  ExtraPack.SetValue('DOLLARDE'    ,    26,            1,      2,                    1,       0);
  ExtraPack.SetValue('DOLLARFR'    ,    27,            1,      2,                    1,       0);
  ExtraPack.SetValue('DURATION'    ,    28,            1,     -1{5-6},               1,       0);
  ExtraPack.SetValue('EDATE'       ,    29,            1,      2,                    1,       0);
  ExtraPack.SetValue('EFFECT'      ,    30,            1,      2,                    1,       0);
  ExtraPack.SetValue('EOMONTH'     ,    31,            1,      2,                    1,       0);
  ExtraPack.SetValue('ERF'         ,    32,            1,     -1{1-2},               1,       0);
  ExtraPack.SetValue('ERFC'        ,    33,            1,      1,                    1,       0);
  ExtraPack.SetValue('FACTDOUBLE'  ,    34,            1,      1,                    1,       0);
  ExtraPack.SetValue('FVSCHEDULE'  ,    35,            1,      2,                    1,       0, '12');
  ExtraPack.SetValue('GCD'         ,    36,            1,     -1,                    0,       0);
  ExtraPack.SetValue('GESTEP'      ,    37,            1,     -1{1-2},               1,       0);
  ExtraPack.SetValue('HEX2BIN'     ,    38,            1,     -1{1-2},               1,       0);
  ExtraPack.SetValue('HEX2DEC'     ,    39,            1,      1,                    1,       0);
  ExtraPack.SetValue('HEC2OCT'     ,    40,            1,     -1{1-2},               1,       0);
  ExtraPack.SetValue('IMABS'       ,    41,            1,      1,                    1,       0);
  ExtraPack.SetValue('IMAGINARY'   ,    42,            1,      1,                    1,       0);
  ExtraPack.SetValue('IMARGUMENT'  ,    43,            1,      1,                    1,       0);
  ExtraPack.SetValue('IMCONJUGATE' ,    44,            1,      1,                    1,       0);
  ExtraPack.SetValue('IMCOS'       ,    45,            1,      1,                    1,       0);
  ExtraPack.SetValue('IMDIV'       ,    46,            1,      2,                    1,       0);
  ExtraPack.SetValue('IMEXP'       ,    47,            1,      1,                    1,       0);
  ExtraPack.SetValue('IMLN'        ,    48,            1,      1,                    1,       0);
  ExtraPack.SetValue('IMLOG10'     ,    49,            1,      1,                    1,       0);
  ExtraPack.SetValue('IMLOG2'      ,    50,            1,      1,                    1,       0);
  ExtraPack.SetValue('IMPOWER'     ,    51,            1,      2,                    1,       0);
  ExtraPack.SetValue('IMPRODUCT'   ,    52,            1,     -1,                    0,       0);
  ExtraPack.SetValue('IMREAL'      ,    53,            1,      1,                    1,       0);
  ExtraPack.SetValue('IMSIN'       ,    54,            1,      1,                    1,       0);
  ExtraPack.SetValue('IMSQRT'      ,    55,            1,      1,                    1,       0);
  ExtraPack.SetValue('IMSUB'       ,    56,            1,      2,                    1,       0);
  ExtraPack.SetValue('IMSUM'       ,    57,            1,     -1,                    0,       0);
  ExtraPack.SetValue('INTRATE'     ,    58,            1,     -1{4-5},               1,       0);
  ExtraPack.SetValue('ISEVEN'      ,    59,            1,      1,                    1,       0);
  ExtraPack.SetValue('ISODD'       ,    60,            1,      1,                    1,       0);
  ExtraPack.SetValue('LCM'         ,    61,            1,     -1,                    0,       0);
  ExtraPack.SetValue('MDURATION'   ,    62,            1,     -1{5-6},               1,       0);
  ExtraPack.SetValue('MROUND'      ,    63,            1,      2,                    1,       0);
  ExtraPack.SetValue('MULTINOMIAL' ,    64,            1,     -1,                    0,       0);
  ExtraPack.SetValue('NETWORKDAYS' ,    65,            1,     -1{2-3},               1,       0, '110');
  ExtraPack.SetValue('NOMINAL'     ,    66,            1,      2,                    1,       0);
  ExtraPack.SetValue('OCT2BIN'     ,    67,            1,     -1{1-2},               1,       0);
  ExtraPack.SetValue('OCT2DEC'     ,    68,            1,      1,                    1,       0);
  ExtraPack.SetValue('OCT2HEX'     ,    69,            1,     -1{1-2},               1,       0);
  ExtraPack.SetValue('ODDFPRICE'   ,    70,            1,     -1{8-9},               1,       0);
  ExtraPack.SetValue('ODDFYIELD'   ,    71,            1,     -1{8-9},               1,       0);
  ExtraPack.SetValue('ODDLPRICE'   ,    72,            1,     -1{7-8},               1,       0);
  ExtraPack.SetValue('ODDLYIELD'   ,    73,            1,     -1{7-8},               1,       0);
  ExtraPack.SetValue('PRICE'       ,    74,            1,     -1{6-7},               1,       0);
  ExtraPack.SetValue('PRICEDISC'   ,    75,            1,     -1{4-5},               1,       0);
  ExtraPack.SetValue('PRICEMAT'    ,    76,            1,     -1{5-6},               1,       0);
  ExtraPack.SetValue('QUOTIENT'    ,    77,            1,      2,                    1,       0);
  ExtraPack.SetValue('RANDBETWEEN' ,    78,            1,      2,                    1,       1);
  ExtraPack.SetValue('RECEIVED'    ,    79,            1,     -1{4-5},               1,       0);
  ExtraPack.SetValue('SERIESSUM'   ,    80,            1,      4,                    1,       0, '1110');
  ExtraPack.SetValue('SQRTPI'      ,    81,            1,      2,                    1,       0);
  ExtraPack.SetValue('TBILLEQ'     ,    82,            1,      3,                    1,       0);
  ExtraPack.SetValue('TBILLPRICE'  ,    83,            1,      3,                    1,       0);
  ExtraPack.SetValue('TBILLYIELD'  ,    84,            1,      3,                    1,       0);
  ExtraPack.SetValue('WEEKNUM'     ,    85,            1,     -1{1-2},               1,       0);
  ExtraPack.SetValue('WORKDAY'     ,    86,            1,     -1{2-3},               1,       0, '110');
  ExtraPack.SetValue('XIRR'        ,    87,            1,     -1{2-3},               0,       0, '001');
  ExtraPack.SetValue('XNPV'        ,    88,            1,      3,                    0,       0, '100');
  ExtraPack.SetValue('YEARFRAC'    ,    89,            1,     -1{2-3},               1,       0);
  ExtraPack.SetValue('YIELD'       ,    90,            1,     -1{6-7},               1,       0);
  ExtraPack.SetValue('YIELDDISC'   ,    91,            1,     -1{4-5},               1,       0);
  ExtraPack.SetValue('YIELDMAT'    ,    92,            1,     -1{5-6},               1,       0);
end;

end.
