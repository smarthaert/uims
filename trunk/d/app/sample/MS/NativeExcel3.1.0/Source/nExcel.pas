//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         nExcel
//
//
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

unit nexcel;
{$Q-}
{$R-}

interface

{$I xlsdef.inc}

{
  +StoreNameShort
  +StoreNameLong
  +TXLSWorkbook.StoreNames
  +WriteMerge...
  +StoreSelection
  +StorePanes
  +StoreVBreak
  +StoreHBreak
  +IXLSWorksheet.MergeCells

  IXLSWorksheet.GetXPoint
  IXLSWorksheet.GetYPoint
  IXLSWorksheet.GetShapeRect
  IXLSWorksheet.GetShapeSize
  IXLSWorksheet.GetShapeRect2

  +IXLSWorksheet.StoreRowInfo
  +IXLSWorksheet.StoreDimensions
  xlsdv.pas
  xlscf.pas 
  xlsafilt.pas 
}
uses
     Classes, Ole, SysUtils, xlsHash,
     {$IFDEF D45}
        ComObj,
     {$ELSE}
        Variants,
     {$ENDIF}
     xlsnames, xlsescher, xlsdrw, xlsblob, xlsstylexf, xlssst, xlscalc, 
     xlsvba, xlsvbar, xlschart, xlscf, xlsdv,  
     xlsExtern, xlshyper, xlsafilt, xlsdbcell, xlsstylecolor, xlscols,
     xlsrows, avltree;

{$I xlsbase.inc}

type
 TMsoLineStyle = xlsdrw.TMsoLineStyle; 

const XLSMaxRow: Word = 65535;
      XLSMaxCol: Byte = 255;
      XLSStrMax: Byte = 255;

      XLSXMaxRow: integer = $FFFFF;
      XLSXMaxCol: integer = $3FFF;

      DefaultXFIndex: integer = $0F;

      kernel32  = 'kernel32.dll';
      user32    = 'user32.dll';
     {$EXTERNALSYM FILE_ATTRIBUTE_DIRECTORY}
      FILE_ATTRIBUTE_DIRECTORY            = $00000010;
      NativeExcelVersion = '3.1.0';
type

  {$EXTERNALSYM DWORD}
  DWORD = LongWord;

  TXLSFileFormat = xlsblob.TXLSFileFormat;

type
//  TPalette      = array [0..63, 0..3] of Byte;
  TXLSWorkbook  = class;
  IXLSWorksheet = class;
  TXLSValueType = (xlEmpty, xlString, xlDoubleNumber, xlDateTime, xlBoolean, xlFormula);
  TAddr         = string[6];
  IXLSRange     = interface;
  TXLSRange     = class;
  IXLSFont      = interface;
  TXLSFont      = class;
  IXLSInterior  = interface;
  TXLSInterior  = class;
  IXLSBorders   = interface;
  TXLSBorders   = class;
  TXLSPageBreak = class;

  TXlWindowView = (xlNormalView, xlPageBreakPreview, xlPageLayoutView);

  TXLSVPageBreaks = class;
  TXLSHPageBreaks = class;
  IXLSBorder      = interface;
  TXLSBorder      = class;


  TXLSObject = class(TInterfacedObject)
{   protected
    FCheckRefCount:    boolean;
    function _AddRef:  Integer; stdcall;
    function _Release: Integer; stdcall;}
  end;

  {$HPPEMIT '__interface IXLSWorkBook;'}
  {$HPPEMIT 'class DELPHICLASS TXLSPageBreak;'}

  IXLSHyperLink = interface
    procedure Delete;
    function  GetAddress: Widestring;
    procedure SetAddress(Value: Widestring);
    function  GetSubAddress: Widestring;
    procedure SetSubAddress(Value: Widestring);
    function  GetScreenTip: Widestring;
    procedure SetScreenTip(Value: Widestring);
    function  GetDisplayText: Widestring;
    procedure SetDisplayText(Value: Widestring);
    function  GetRange: IXLSRange;
    procedure SetRange(Value: IXLSRange);
    property  Address:     WideString   read GetAddress       write SetAddress;
    property  SubAddress:  WideString   read GetSubAddress    write SetSubAddress;
    property  ScreenTip:   WideString   read GetScreenTip     write SetScreenTip;
    property  DisplayText: WideString   read GetDisplayText   write SetDisplayText;    
    property  Range:       IXLSRange    read GetRange         write SetRange;
  end;
  
  TXLSHyperLink=class(TXLSObject, IXLSHyperlink)
  private
    FHyperLink: TXLSCustomHyperLink;
    function  GetAddress: Widestring;
    procedure SetAddress(Value: Widestring);
    function  GetSubAddress: Widestring;
    procedure SetSubAddress(Value: Widestring);
    function  GetScreenTip: Widestring;
    procedure SetScreenTip(Value: Widestring);
    function  GetDisplayText: Widestring;
    procedure SetDisplayText(Value: Widestring);
    function  GetRange: IXLSRange;
    procedure SetRange(Value: IXLSRange);
  public
    procedure Delete;
    constructor Create(AHyperLink: TXLSCustomHyperLink);
  end;

  IXLSHyperLinks = interface
    function GetCount: integer;
    function GetItem(Index: integer): IXLSHyperLink;
    procedure Delete;
    function Add(Anchor: IXLSRange; Address:WideString; SubAddress: WideString=''; ScreenTip:WideString=''; TextToDisplay: Widestring=''): IXLSHyperlink; 
    property Count: integer read GetCount;
    property Item[Index: integer]: IXLSHyperLink read GetItem; default;
  end;

  TXLSHyperLinks=class(TXLSObject, IXLSHyperlinks)
  private
    FRange: IXLSRange;
    FHyperLinks: TXLSCustomHyperLinks;
    function GetCount: integer;
    function GetItem(Index: integer): IXLSHyperLink;
  public
    procedure Delete;
    function Add(Anchor: IXLSRange; Address:WideString; SubAddress: WideString=''; ScreenTip:WideString=''; TextToDisplay: Widestring=''): IXLSHyperlink; 
    constructor Create(ARange: IXLSRange; AHyperLinks: TXLSCustomHyperLinks);
    destructor  Destroy; override;     
  end;

  TXLSCellRef = class(TAVLNode)
  private
    FRow: integer;
    FCol: integer;
    FXFIndex: integer;
    FCompiledFormula: TXLSCompiledFormula;
    FStringIndex: Integer;
    FDoubleValue: Double;
    FValueType: TXLSValueType;
    FMergeCell: TXLSCellRef;
    FMergeRowCount: integer;
    FMergeColCount: integer;
    FMerged: Boolean;
    procedure SetValue(Ws: IXLSWorksheet; const Value: variant);
    function  GetValue(Ws: IXLSWorksheet): variant;
    function  GetFormula(Ws: IXLSWorksheet): variant;  
    function  GetHasFormula: boolean;
  public
    constructor Create(Row: integer; Col: integer);
    destructor  Destroy; override;
    function  GetCellValue(Ws: IXLSWorksheet; Var Value: variant): integer;
    property Value[Ws: IXLSWorksheet]: Variant read GetValue write SetValue;
    property Formula[Ws: IXLSWorksheet]: Variant read GetFormula write SetValue;
    property Merged: boolean read FMerged;
    property Row: integer read FRow;
    property Col: integer read FCol;
    property XFIndex: Integer read FXFIndex write FXFIndex;
    property StringIndex: Integer     read FStringIndex;
    property DoubleValue: Double      read FDoubleValue;
    property ValueType: TXLSValueType read FValueType; 
    property MergeCell: TXLSCellRef   read FMergeCell; 
    property MergeRowCount: integer read FMergeRowCount;
    property MergeColCount: integer read FMergeColCount;
    property HasFormula: boolean read GetHasFormula;
  end;

  TXLSCellBlock = class(TAVLNode)
  private
     FCnt: shortint;
     FArr: array[0..$3F] of TXLSCellRef;
     function GetRow: integer;
  public
     constructor Create(AKey: Longint);
     destructor Destroy; override;
     procedure SetCell(Index: integer; Cell: TXLSCellRef);
     function GetFirstCell: TXLSCellRef;
     function GetNextCell(index: integer): TXLSCellRef;
     function DeleteCell(index: integer): TXLSCellRef;
     function IsEmpty: boolean;
     property Row: integer read GetRow;
  end;


 TXLSCellHeap = class(TAVLTree)
  private
    FOnDestroy: boolean;
    FWorkSheet: IXLSWorksheet;
    FMinRow, FMaxRow, FRowCount: integer;
    FMinCol, FMaxCol, FColCount: integer;
    FFreeSST: boolean;
    Procedure Create_Cell(Row: integer; Col: integer; Var Cell: TXLSCellRef);
    procedure CellDeleted(Row, Col: integer);
    procedure SetValue(Row, Col: integer; cell: TXLSCellRef);
  public
    constructor Create(const WorkSheet: IXLSWorksheet);
    destructor Destroy; override;
    function GetValue(Row: integer; Col: integer): TXLSCellRef;
    procedure DeleteValue(Row: integer; Col: integer);
    procedure EraseValue(Row: integer; Col: integer);
    function GetOrCreateValue(Row: integer; Col: integer): TXLSCellRef;
    function NodeCreate(AKey: Longint): TAVLNode; override;
    procedure NodeDeleted(ANode: TAVLNode); override;
    function GetFirstRowCell(Row: integer): TXLSCellRef;
    function GetNextRowCell(Cell: TXLSCellRef): TXLSCellRef;
    procedure MoveCell(srcrow, srccol, dstrow, dstcol: integer;
       keepformat: boolean; row1, col1, row2, col2, drow, dcol: integer);
  end;

  IXLSRowsRange = interface;
  IXLSColsRange = interface;
  IXLSRowRange  = interface;
  IXLSColRange  = interface;


 IXLSName = interface
   function GetName: WideString;
   function GetRefersTo: WideString;
   function GetRefersToRange: IXLSRange;
   procedure SetRefersTo(Value: Widestring);
   procedure SetName(Value: WideString);
   function GetIndex: integer;
   function  GetVisible: boolean;
   procedure SetVisible(Value: boolean);
   procedure Delete;

   property Name: WideString read GetName write SetName;
   property RefersTo: WideString read GetRefersTo write SetRefersTo;  
   property RefersToRange: IXLSRange read GetRefersToRange;  
   
   property Index: integer read GetIndex;
   property Visible: boolean read GetVisible write SetVisible;
 end;

 IXLSNames = interface
   function GetItem(Index: Variant): IXLSName;
   function GetCount: integer;
   function Add(Name: WideString; RefersTo: WideString; Visible: boolean): IXLSName; overload;
   function Add(Name: WideString; RefersTo: WideString): IXLSName; overload;
   property Item[Index: Variant]: IXLSName read GetItem; default;
   property Count: integer read GetCount;
 end;

 TXLSName = class(TInterfacedObject, IXLSName)
 private 
   FName: TXLSCustomName;
 public
   constructor Create(AName: TXLSCustomName);
   destructor Destroy; override;
   function GetName: WideString;
   function GetRefersTo: WideString;
   function GetRefersToRange: IXLSRange;
   procedure SetRefersTo(Value: Widestring);
   procedure SetName(Value: WideString);
   function GetIndex: integer;
   procedure Delete;
   function GetVisible: boolean;
   procedure SetVisible(Value: boolean);
 end;

 TXLSNames = class(TInterfacedObject, IXLSNames)
 private 
   FNames: TXLSCustomNames;
 public
   constructor Create(ANames: TXLSCustomNames);
   destructor Destroy; override;
   function GetItem(Index: Variant): IXLSName;
   function GetItemByIndex(Index: integer): IXLSName;
   function GetItemByName(Name: WideString): IXLSName;
   function GetCount: integer;
   function Add(Name: WideString; RefersTo: WideString; Visible: boolean): IXLSName; overload;
   function Add(Name: WideString; RefersTo: WideString): IXLSName; overload;
 end;


  IXLSRange = interface
    procedure PasteFrom(SrcRange: TXLSRange; PasteMode: Longword; CopyMode: boolean);
    function GetItem( Row: integer; Col: integer): IXLSRange;
    procedure SetValue(Value: Variant);
    function GetValue: Variant;
    function GetFormula: Variant;
    function GetEntireRow: IXLSRowsRange;
    function GetEntireColumn: IXLSColsRange;
    function GetRows: IXLSRowsRange;
    function GetColumns: IXLSColsRange;
    function GetOffsetRange(rowoffset, coloffset: integer): IXLSRange;
    procedure ShiftTo(row, col: integer);
    function GetRow: integer;
    function GetColumn: integer;
    function GetCellsCount: LongWord;
    function GetFont: IXLSFont;
    function GetInterior: IXLSInterior;
    function GetColumnWidth: OleVariant;
    function GetWidthInPixels: integer;
    function GetWidth: double;
    procedure SetColumnWidth(const Value: OleVariant);
    function GetRowHeight: OleVariant;
    procedure SetRowHeight(const Value: OleVariant);
    function GetWrapText: OleVariant;
    procedure SetWrapText(const Value: OleVariant);
    function GetOrientation: OleVariant;
    procedure SetOrientation(const Value: OleVariant);
    function GetBorders: IXLSBorders;
    function GetNumFormat: widestring;
    procedure SetNumFormat(Value: widestring);
    function GetLocked: boolean;
    procedure SetLocked(Value: boolean);
    function GetFormulaHidden: boolean;
    procedure SetFormulaHidden(Value: boolean);
    function GetShrinkToFit: boolean;
    procedure SetShrinkToFit(Value: boolean);
    function GetReadingOrder: XlReadingOrder;
    procedure SetReadingOrder(Value: XlReadingOrder);
    function GetHAlign:xlHAlign;
    procedure SetHAlign(Value: xlHAlign);
    function GetVAlign:xlVAlign;
    procedure SetVAlign(Value: xlVAlign);
    function GetCells: IXLSRange;
    procedure ExtendRange;
    procedure ContractRange;
    function GetHasFormula: boolean;

    procedure Autofilter; overload;
    procedure Autofilter(Field: integer; Criteria1: Variant); overload;
    procedure Autofilter(Field: integer; Criteria1: Variant; VisibleDropDown: boolean); overload;
    procedure Autofilter(Field: integer; Criteria1: Variant; Operator: XlAutoFilterOperator; Criteria2: Variant); overload;
    procedure Autofilter(Field: integer; Criteria1: Variant; Operator: XlAutoFilterOperator; Criteria2: Variant; VisibleDropDown: boolean); overload;

    property Item[Row: integer; Col: integer]: IXLSRange read GetItem;default;
    property Value: Variant read GetValue write SetValue;
    property Formula: Variant read GetFormula write SetValue;
    property EntireRow: IXLSRowsRange read GetEntireRow;
    property EntireColumn: IXLSColsRange read GetEntireColumn;
    property Rows: IXLSRowsRange read GetRows;
    property Columns: IXLSColsRange read GetColumns;
    property Offset[rowoffset: integer; coloffset: integer]: IXLSRange read GetOffsetRange;
    property Row: integer read GetRow;
    property Column: integer read GetColumn;
    property Count: LongWord read GetCellsCount;
    property Font: IXLSFont read GetFont;
    property Interior: IXLSInterior read GetInterior;
    property ColumnWidth: OleVariant read GetColumnWidth write SetColumnWidth;
    property WidthInPixels: integer read GetWidthInPixels;
    property Width: double read GetWidth;
    property RowHeight: OleVariant read GetRowHeight write SetRowHeight;
    property WrapText: OleVariant read GetWrapText write SetWrapText;
    property Orientation: OleVariant read GetOrientation write SetOrientation;
    property Borders: IXLSBorders read GetBorders;
    property NumberFormat: widestring read GetNumFormat write SetNumFormat;
    property Locked: boolean read GetLocked write SetLocked;  
    property FormulaHidden: boolean read GetFormulaHidden write SetFormulaHidden;  
    property ShrinkToFit: boolean read GetShrinkToFit write SetShrinkToFit;  
    property ReadingOrder: XlReadingOrder  read GetReadingOrder write SetReadingOrder;  
    property HorizontalAlignment:XlHAlign read GetHAlign write SetHAlign;
    property VerticalAlignment:XlVAlign read GetVAlign write SetVAlign;
    property Cells: IXLSRange read GetCells;
    property HasFormula: boolean read GetHasFormula;
    procedure Merge(Accros: OleVariant);overload;
    procedure Merge;overload;
    procedure Select;
    procedure ClearContents;
    procedure Clear;
    function Insert(Shift: OleVariant): OleVariant;
    function Delete(Shift: OleVariant): OleVariant;
    procedure Move(Destination: IXLSRange); overload;
    procedure Copy(Destination: IXLSRange); overload;
    procedure Move(Destination: IXLSRange; PasteMode: LongWord); overload;
    procedure Copy(Destination: IXLSRange; PasteMode: LongWord); overload;
    function AddComment: TXLSComment; overload;
    function AddComment(AText: WideString): TXLSComment; overload;
    procedure ClearComments;
    function  GetComment: TXLSComment;
    function GetHyperlinks: IXLSHyperlinks;

    function GetFirstCol: integer;
    function GetLastCol: integer;
    function GetFirstRow: integer;
    function GetLastRow: integer;
    procedure Unmerge;
    function  GetMergeCells: boolean;
    procedure SetMergeCells(Value: boolean);
    function  GetMergeArea: IXLSRange;

    function XFIndex: integer;

    property FirstCol: integer read GetFirstCol;
    property LastCol: integer read GetLastCol;
    property FirstRow: integer read GetFirstRow;
    property LastRow: integer read GetLastRow;
    property Comment: TXLSComment read GetComment;
    property MergeCells: boolean read GetMergeCells write SetMergeCells;
    property MergeArea: IXLSRange read GetMergeArea;
    property HyperLinks: IXLSHyperLinks read GetHyperLinks;

    function GetWorksheet: IXLSWorksheet;
    property Worksheet: IXLSWorksheet read GetWorksheet;
    procedure AutoFit(Columns: boolean);

    procedure Group(Rows: boolean = true); 
    procedure UnGroup(Rows: boolean = true); 

    procedure ClearOutline;
    function  GetRowsOutlineLevel: integer;
    procedure SetRowsOutlineLevel(Value: integer);
    property  OutlineLevel: integer read GetRowsOutlineLevel write SetRowsOutlineLevel;

    function  GetIndentLevel: integer;
    procedure SetIndentLevel(Value: integer);
    property IndentLevel: integer read GetIndentLevel write SetIndentLevel;

    function SaveAsCSV(FileName: WideString): integer;
    function SaveAs(FileName: WideString; FileFormat: TXLSFileFormat): integer; overload;
    function SaveAs(Stream: TStream; FileFormat: TXLSFileFormat): integer; overload;
  end;

  IXLSRowsRange = interface (IXLSRange)
    function  GetRowsCount: LongWord;
    function  GetRowsHidden: OleVariant;
    procedure SetRowsHidden(const Value: OleVariant);
    function  GetRowByIndex(row: integer): IXLSRowRange;
    property  Item[Row: integer]: IXLSRowRange read GetRowByIndex; default;
    property  Hidden: OleVariant read GetRowsHidden write SetRowsHidden;
    property  Count: LongWord read GetRowsCount;
    procedure AutoFit(Columns: boolean = false);
{    procedure Group(Rows: boolean = true); 
    procedure UnGroup(Rows: boolean = true); 
    function  GetRowsOutlineLevel: integer;
    procedure SetRowsOutlineLevel(Value: integer);
    property  OutlineLevel: integer read GetRowsOutlineLevel write SetRowsOutlineLevel;}
  end;

  IXLSRowRange = interface (IXLSRange)
    function GetColumnsCount: LongWord;
    function GetRowsHidden: OleVariant;
    procedure SetRowsHidden(const Value: OleVariant);
    function GetColByIndex(col: integer): IXLSColRange;
    property Item[Col: integer]: IXLSColRange read GetColByIndex; default;
    property Hidden: OleVariant read GetRowsHidden write SetRowsHidden;
    property Count: LongWord read GetColumnsCount;
    procedure AutoFit(Columns: boolean = false);
  end;


  IXLSColsRange = interface (IXLSRange)
    function GetColumnsCount: LongWord;
    function GetColumnsHidden: OleVariant;
    procedure SetColumnsHidden(const Value: OleVariant);
    function GetColByIndex(col: integer): IXLSColRange;
    property Item[Col: integer]: IXLSColRange read GetColByIndex; default;
    property Hidden: OleVariant read GetColumnsHidden write SetColumnsHidden;
    property Count: LongWord read GetColumnsCount;
    procedure AutoFit(Columns: boolean = true);
    procedure Group(Rows: boolean = false); 
    procedure UnGroup(Rows: boolean = false); 
    function  GetColumnsOutlineLevel: integer;
    procedure SetColumnsOutlineLevel(Value: integer);
    property  OutlineLevel: integer read GetColumnsOutlineLevel write SetColumnsOutlineLevel;
  end;

  IXLSColRange = interface (IXLSRange)
    function  GetRowsCount: LongWord;
    function GetColumnsHidden: OleVariant;
    procedure SetColumnsHidden(const Value: OleVariant);
    function  GetRowByIndex(row: integer): IXLSRowRange;
    property  Item[Row: integer]: IXLSRowRange read GetRowByIndex; default;
    property Hidden: OleVariant read GetColumnsHidden write SetColumnsHidden;
    procedure AutoFit(Columns: boolean = true);
    property  Count: LongWord read GetRowsCount;
    procedure Group(Rows: boolean = false); 
    procedure UnGroup(Rows: boolean = false); 
    function  GetColumnsOutlineLevel: integer;
    procedure SetColumnsOutlineLevel(Value: integer);
    property  OutlineLevel: integer read GetColumnsOutlineLevel write SetColumnsOutlineLevel;
  end;


  TXLSRange = class(TXLSObject, IXLSRange, IXLSRowsRange, IXLSColsRange, IXLSRowRange, IXLSColRange)
  private
    FWorkSheet: IXLSWorksheet;
    FFirstRow,FLastRow: integer;
    FFirstCol,FLastCol: integer;
    FOffsetRange: IXLSRange;
    procedure SetValue(Value: Variant);
    function GetValue: Variant;
    function GetFormula: Variant;
    function GetItem( Row: integer; Col: integer): IXLSRange;
    function GetEntireRow: IXLSRowsRange;
    function GetEntireColumn: IXLSColsRange;
    function GetOffsetRange(rowoffset, coloffset: integer): IXLSRange;
    procedure ShiftTo(row: integer; col: integer);
    procedure PasteFrom(SrcRange: TXLSRange; PasteMode: Longword; CopyMode: boolean);
    function GetRows: IXLSRowsRange;
    function GetColumns: IXLSColsRange;
    function GetRowByIndex(row: integer): IXLSRowRange;
    function GetColByIndex(col: integer): IXLSColRange;
    function GetCellsCount: LongWord;
    function GetRowsCount: LongWord;
    function GetColumnsCount: LongWord;
    procedure ExtendRange;
    procedure ContractRange;
    function GetFontName: widestring;
    function GetFontSize: Single;

    function GetFontColorIndex: LongWord;
    function GetFontColor: LongWord;
    function GetFontTintAndShade: double;
    function GetFontThemeColor: LongWord;

    function GetFontBold: boolean;
    function GetFontItalic: boolean;
    function GetFontStrikethrough: boolean;
    function GetFontOutLineFont: boolean;
    function GetFontShadow: boolean;
    function GetFontUnderLine: byte;
    function GetFontSubScript: boolean;
    function GetFontSuperScript: boolean;
    function GetFontCharSet: byte;
    function GetFontFamily: byte;
    procedure SetFontSize(const Value: Single);

    procedure SetFontColorIndex(const Value: LongWord);
    procedure SetFontColor(const Value: LongWord);
    procedure SetFontTintAndShade(const Value: double);
    procedure SetFontThemeColor(const Value: Longword);

    procedure SetFontBold(const Value: boolean);
    procedure SetFontItalic(const Value: boolean);
    procedure SetFontStrikethrough(const Value: boolean);
    procedure SetFontOutLineFont(const Value: boolean);
    procedure SetFontShadow(const Value: boolean);
    procedure SetFontUnderLine(const Value: byte);
    procedure SetFontSubScript(const Value: boolean);
    procedure SetFontSuperScript(const Value: boolean);
    procedure SetFontName(const Value: widestring);
    procedure SetFontCharset(const Value: byte);
    procedure SetFontFamily(const Value: byte);
    function GetBorderLineStyle(const BorderIndex: LongWord): LongWord;
    function GetBorderWeight(const BorderIndex: LongWord): LongWord;
    function GetBorderColorIndex(const BorderIndex: LongWord): LongWord;
    function GetBorderColor(const BorderIndex: LongWord): LongWord;
    function GetBorderThemeColor(const BorderIndex: LongWord): LongWord;
    function GetBorderTintAndShade(const BorderIndex: LongWord): double;

    procedure SetBorderProperty(const BorderIndex: LongWord; Value: LongWord; SetFunc: TSetXFBorderProperty);
    procedure SetBorderLineStyle(const BorderIndex: LongWord; Value: LongWord);
    procedure SetBorderWeight(const BorderIndex: LongWord; Value: LongWord);
    procedure SetBorderColorIndex(const BorderIndex: LongWord; Value: LongWord);
    procedure SetBorderColor(const BorderIndex: LongWord; Value: LongWord);
    procedure SetBorderThemeColor(const BorderIndex: LongWord; Value: LongWord);
    procedure SetBorderTintAndShade(const BorderIndex: LongWord; Value: double);

    procedure SetBordersProperty(Value: LongWord; SetFunc: TSetXFBorderProperty);
    procedure SetBordersLineStyle(Value: LongWord);
    procedure SetBordersWeight(Value: LongWord);
    procedure SetBordersColorIndex(Value: LongWord);
    procedure SetBordersColor(Value: LongWord);
    procedure SetBordersThemeColor(Value: LongWord);
    procedure SetBordersTintAndShade(Value: double);

    procedure SetRangeXFBordersProperty(Row1, Col1, Row2, Col2: integer; Optional: boolean; BorderMask: integer; _Value: LongWord; SetFunc: TSetXFBorderProperty);

    function  GetBorderAllStyle: integer;
    function  GetCellBorderColorIndex(Row1, Col1, Row2, Col2: integer; isVertical: boolean): LongWord;
    function  GetCellBorderColor(Row1, Col1, Row2, Col2: integer; isVertical: boolean): LongWord;
    function  GetCellBorderThemeColor(Row1, Col1, Row2, Col2: integer; isVertical: boolean): LongWord;
    function  GetCellBorderTintAndShade(Row1, Col1, Row2, Col2: integer; isVertical: boolean): double;
    function  GetCellBorderLineStyle(Row1, Col1, Row2, Col2: integer; isVertical: boolean): LongWord;
    function  GetCellBorderLineWeight(Row1, Col1, Row2, Col2: integer; isVertical: boolean): LongWord;

    function  GetBorderLeftColorIndex: LongWord;
    function  GetBorderDiagonalDownColorIndex: LongWord;
    function  GetBorderDiagonalUpColorIndex: LongWord;
    function  GetBorderDiagonalDownColor: LongWord;
    function  GetBorderDiagonalUpColor: LongWord;

    function  GetBorderRightColorIndex: LongWord;
    function  GetBorderVerticalInsideColorIndex: LongWord;
    function  GetBorderTopColorIndex: LongWord;
    function  GetBorderBottomColorIndex: LongWord;
    function  GetBorderHorizontalInsideColorIndex: LongWord;
    function  GetBorderAroundColorIndex: LongWord;
    function  GetBorderAllColorIndex: LongWord;
    function  GetBorderInsideAllColorIndex: LongWord;

    function  GetBorderDiagonalDownLineStyle: LongWord;
    function  GetBorderDiagonalUpLineStyle: LongWord;
    function  GetBorderLeftColor: LongWord;
    function  GetBorderRightColor: LongWord;
    function  GetBorderVerticalInsideColor: LongWord;
    function  GetBorderTopColor: LongWord;
    function  GetBorderBottomColor: LongWord;
    function  GetBorderHorizontalInsideColor: LongWord;

    function  GetBorderDiagonalDownThemeColor: LongWord;
    function  GetBorderDiagonalUpThemeColor: LongWord;
    function  GetBorderLeftThemeColor: LongWord;
    function  GetBorderRightThemeColor: LongWord;
    function  GetBorderVerticalInsideThemeColor: LongWord;
    function  GetBorderTopThemeColor: LongWord;
    function  GetBorderBottomThemeColor: LongWord;
    function  GetBorderHorizontalInsideThemeColor: LongWord;

    function  GetBorderDiagonalDownTintAndShade: double;
    function  GetBorderDiagonalUpTintAndShade: double;
    function  GetBorderLeftTintAndShade: double;
    function  GetBorderRightTintAndShade: double;
    function  GetBorderVerticalInsideTintAndShade: double;
    function  GetBorderTopTintAndShade: double;
    function  GetBorderBottomTintAndShade: double;
    function  GetBorderHorizontalInsideTintAndShade: double;

    function  GetBorderLeftLineStyle: LongWord;
    function  GetBorderRightLineStyle: LongWord;
    function  GetBorderVerticalInsideLineStyle: LongWord;
    function  GetBorderTopLineStyle: LongWord;
    function  GetBorderBottomLineStyle: LongWord;
    function  GetBorderHorizontalInsideLineStyle: LongWord;
    function  GetBorderAroundLineStyle: LongWord;
    function  GetBorderAllLineStyle: LongWord;
    function  GetBorderInsideAllLineStyle: LongWord;

    function  GetBorderDiagonalDownLineWeight: LongWord;
    function  GetBorderDiagonalUpLineWeight: LongWord;
    function  GetBorderLeftLineWeight: LongWord;
    function  GetBorderRightLineWeight: LongWord;
    function  GetBorderVerticalInsideLineWeight: LongWord;
    function  GetBorderTopLineWeight: LongWord;
    function  GetBorderBottomLineWeight: LongWord;
    function  GetBorderHorizontalInsideLineWeight: LongWord;
    function  GetBorderAroundLineWeight: LongWord;
    function  GetBorderAllLineWeight: LongWord;
    function  GetBorderInsideAllLineWeight: LongWord;

    procedure SetInteriorPatternColorIndex(const Value: longword);
    procedure SetInteriorPatternColor(const Value: longword);
    procedure SetInteriorPatternThemeColor(const Value: longword);
    procedure SetInteriorPatternTintAndShade(const Value: double);

    procedure SetInteriorColorIndex(const Value: longword);
    procedure SetInteriorColor(const Value: longword);
    procedure SetInteriorThemeColor(const Value: longword);
    procedure SetInteriorTintAndShade(const Value: double);

    procedure SetInteriorPattern(const Value: word);

    function GetInteriorPatternColorIndex: longword;
    function GetInteriorPatternColor: longword;
    function GetInteriorPatternThemeColor: longword;
    function GetInteriorPatternTintAndShade: double;

    function GetInteriorColorIndex: longword;
    function GetInteriorColor: longword;
    function GetInteriorThemeColor: longword;
    function GetInteriorTintAndShade: double;

    function GetInteriorPattern: word;
    function GetColumnWidth: OleVariant;
    procedure SetColumnWidth(const Value: OleVariant);
    function GetWidthInPixels: integer;
    function GetWidth: double;
    function GetRowHeight: OleVariant;
    procedure SetRowHeight(const Value: OleVariant);
    function GetRowsHidden: OleVariant;
    function GetColumnsHidden: OleVariant;
    procedure SetRowsHidden(const Value: OleVariant);
    procedure SetColumnsHidden(const Value: OleVariant);
    function GetWrapText: OleVariant;
    procedure SetWrapText(const Value: OleVariant);
    function GetOrientation: OleVariant;
    procedure SetOrientation(const Value: OleVariant);
    procedure SetXFProperty(const Value: OleVariant; SetFunc: TSetXFProperty);
    function GetFont: IXLSFont;
    function GetRangeType: integer;
    function GetInterior: IXLSInterior;
    function GetBorders: IXLSBorders;
    function GetRow: integer;
    function GetColumn: integer;
    function GetNumFormat: widestring;
    procedure SetNumFormat(Value: widestring);
    function GetLocked: boolean;
    procedure SetLocked(Value: boolean);
    function GetFormulaHidden: boolean;
    procedure SetFormulaHidden(Value: boolean);
    function GetShrinkToFit: boolean;
    procedure SetShrinkToFit(Value: boolean);
    function GetReadingOrder: XlReadingOrder;
    procedure SetReadingOrder(Value: XlReadingOrder);
    function GetHAlign:xlHAlign;
    procedure SetHAlign(Value: xlHAlign);
    function GetVAlign:xlVAlign;
    procedure SetVAlign(Value: xlVAlign);
    function GetCells: IXLSRange;
    function GetXFIndex(row, col: integer; Var ReplaceIndex: boolean): integer;
    procedure UnMergeOutgoingRanges(Row1, Col1, Row2, Col2: integer);
    function GetWorksheet: IXLSWorksheet;

    function GetFirstCol: integer;
    function GetLastCol: integer;
    function GetFirstRow: integer;
    function GetLastRow: integer;
    procedure UnMergeCell(Cell:TXLSCellRef);
    procedure CopyCell(SrcRow, SrcCol: integer; SrcWorksheet: IXLSWorkSheet;
                       DstRow, DstCol: integer; DstWorksheet: IXLSWorkSheet;
                       PasteMode: LongWord; ChangeFormula: boolean);
    procedure ClearCell(SrcRow, SrcCol: integer; SrcWorksheet: IXLSWorkSheet;
                      PasteMode: LongWord; KeepDefaultFormat: integer);
    procedure AfterDelete(RangeType: integer; isrows: boolean);
    procedure AfterInsert(RangeType: integer; isrows: boolean);
    function GetComment: TXLSComment;
    function GetMergeCells: boolean;
    procedure SetMergeCells(Value: boolean);
    function  GetMergeArea: IXLSRange;
    procedure ColumnsAutoFit;
    procedure RowsAutoFit;
    procedure AutoFit(Columns: boolean);
    function  GetHyperlinks: IXLSHyperlinks;
    procedure RowsGroup(Step: integer);
    procedure ColumnsGroup(Step: integer);
    procedure Group(Rows: boolean);
    procedure UnGroup(Rows: boolean);
    procedure ClearOutline;

    function  GetRowsOutlineLevel: integer;
    procedure SetRowsOutlineLevel(Value: integer);
    function  GetColumnsOutlineLevel: integer;
    procedure SetColumnsOutlineLevel(Value: integer);
    function  GetHasFormula: boolean;
    function  GetIndentLevel: integer;
    procedure SetIndentLevel(Value: integer);
    procedure DeleteRows;
    procedure DeleteColumns;
    procedure DeleteRange(isRows: boolean);
    procedure InsertRows;
    procedure InsertColumns;
    procedure InsertRange(isRows: boolean);
    procedure ClearRows(r1, r2, c1, c2: integer);
    procedure ClearColumns(c1, c2, r1, r2: integer);
    procedure ClearRange(r1, c1, r2, c2: integer; isrow: boolean);
    procedure MoveRows(r1, r2, distance, c1, c2: integer);
    procedure MoveColumns(c1, c2, distance, r1, r2: integer);
    procedure MoveRange(r1, c1, r2, c2: integer;
                        r_distance, c_distance: integer; 
                        keepformat: boolean);
    procedure DeleteCell(r, c: integer);
  public
    property Item[Row: integer; Col: integer]: IXLSRange read GetItem; 
    property Value: Variant read GetValue write SetValue;
    property Formula: Variant read GetFormula write SetValue;
    property EntireRow: IXLSRowsRange read GetEntireRow;
    property EntireColumn: IXLSColsRange read GetEntireColumn;
    property Offset[rowoffset: integer; coloffset: integer]: IXLSRange read GetOffsetRange;
    property Rows: IXLSRowsRange read GetRows;
    property Columns: IXLSColsRange read GetColumns;
    property Row: integer read GetRow;
    property Column: integer read GetColumn;

    property Orientation: OleVariant read GetOrientation write SetOrientation;
    property Font: IXLSFont read GetFont;
    property Interior: IXLSInterior read GetInterior;
    property ColumnWidth: OleVariant read GetColumnWidth write SetColumnWidth;
    property RowHeight: OleVariant read GetRowHeight write SetRowHeight;
    property WrapText: OleVariant read GetWrapText write SetWrapText;
    property Borders: IXLSBorders read GetBorders;
    property NumberFormat: widestring read GetNumFormat write SetNumFormat;
    property Locked: boolean read GetLocked write SetLocked;  
    property FormulaHidden: boolean read GetFormulaHidden write SetFormulaHidden;  
    property ShrinkToFit: boolean read GetShrinkToFit write SetShrinkToFit;  
    property ReadingOrder: XlReadingOrder read GetReadingOrder write SetReadingOrder;  
    property HorizontalAlignment:XlHAlign read GetHAlign write SetHAlign;
    property VerticalAlignment:XlVAlign read GetVAlign write SetVAlign;
    property Cells: IXLSRange read GetCells;
    property Comment: TXLSComment read GetComment;
    property MergeCells: boolean read GetMergeCells write SetMergeCells;
    property MergeArea: IXLSRange read GetMergeArea;
    property HasFormula: boolean read GetHasFormula;
    property IndentLevel: integer read GetIndentLevel write SetIndentLevel;
    constructor Create(const WorkSheet: IXLSWorksheet; Cell1: String; Cell2: String); overload;
    constructor Create(const WorkSheet: IXLSWorksheet; Row1, Col1, Row2, Col2: integer); overload;
    destructor Destroy; override;
    procedure Merge(Accros: OleVariant);overload;
    procedure Merge;overload;
    procedure Select;
    procedure ClearContents;
    procedure Clear;
    function AddComment: TXLSComment; overload;
    function AddComment(AText: WideString): TXLSComment; overload;
    procedure ClearComments;
    function Insert(Shift: OleVariant): OleVariant;
    function Delete(Shift: OleVariant): OleVariant;
    procedure Move(Destination: IXLSRange); overload;
    procedure Copy(Destination: IXLSRange); overload;
    procedure Move(Destination: IXLSRange; PasteMode: LongWord); overload;
    procedure Copy(Destination: IXLSRange; PasteMode: LongWord); overload;
    procedure Unmerge;
    function XFIndex: integer;
    function  SaveAsCSV(FileName: WideString): integer; overload;
    function SaveAs(FileName: WideString; FileFormat: TXLSFileFormat): integer; overload;
    function SaveAs(Stream: TStream; FileFormat: TXLSFileFormat): integer; overload;

    procedure Autofilter; overload;
    procedure Autofilter(Field: integer; Criteria1: Variant); overload;
    procedure Autofilter(Field: integer; Criteria1: Variant; VisibleDropDown: boolean); overload;
    procedure Autofilter(Field: integer; Criteria1: Variant; Operator: XlAutoFilterOperator; Criteria2: Variant); overload;
    procedure Autofilter(Field: integer; Criteria1: Variant; Operator: XlAutoFilterOperator; Criteria2: Variant; VisibleDropDown: boolean); overload;


    property FirstCol: integer read GetFirstCol;
    property LastCol: integer read GetLastCol;
    property FirstRow: integer read GetFirstRow;
    property LastRow: integer read GetLastRow;
    property Worksheet: IXLSWorksheet read GetWorksheet;
    property HyperLinks: IXLSHyperLinks read GetHyperLinks;
  end;

  IXLSFont = interface
     function GetName: widestring;
     function GetSize: Single;

     function GetColorIndex: LongWord;
     function GetColor: LongWord;
     function GetThemeColor: LongWord;
     function GetTintAndShade: double;

     function GetBold: boolean;
     function GetItalic: boolean;
     function GetStrikethrough: boolean;
     function GetOutLineFont: boolean;
     function GetShadow: boolean;
     function GetUnderLine: LongWord;
     function GetSubScript: boolean;
     function GetSuperScript: boolean;
     function GetCharSet: byte;
     function GetFamily: byte;
     procedure SetSize(const Value: Single);

     procedure SetColorIndex(const Value: LongWord);
     procedure SetColor(const Value: LongWord);
     procedure SetThemeColor(const Value: LongWord);
     procedure SetTintAndShade(const Value: double);

     procedure SetBold(const Value: boolean);
     procedure SetItalic(const Value: boolean);
     procedure SetStrikethrough(const Value: boolean);
     procedure SetOutLineFont(const Value: boolean);
     procedure SetShadow(const Value: boolean);
     procedure SetUnderLine(const Value: LongWord);
     procedure SetSubScript(const Value: boolean);
     procedure SetSuperScript(const Value: boolean);
     procedure SetName(const Value: widestring);
     procedure SetCharSet(const Value: byte);
     procedure SetFamily(const Value: byte);
     property Name: widestring read GetName write SetName;
     property Size: Single read GetSize write SetSize;
     property ColorIndex: LongWord read GetColorIndex write SetColorIndex;
     property Color: LongWord read GetColor write SetColor;
     property ThemeColor: LongWord read GetThemeColor write SetThemeColor;
     property TintAndShade: double read GetTintAndShade write SetTintAndShade;
     property Bold: boolean read GetBold write SetBold;
     property Italic: boolean read GetItalic write SetItalic;
     property Strikethrough: boolean read GetStrikethrough write SetStrikethrough;
     property OutLineFont: boolean read GetOutLineFont write SetOutLineFont;
     property Shadow: boolean read GetShadow write SetShadow;
     property Underline: LongWord read GetUnderline write SetUnderline;
     property SubScript: boolean read GetSubScript write SetSubScript;
     property SuperScript: boolean read GetSuperScript write SetSuperScript;
     property CharSet: byte read GetCharSet write SetCharSet;
     property Family: byte read GetFamily write SetFamily;
  end;

  TXLSFont = class(TXLSObject, IXLSFont)
  private
     FRange: TXLSRange;
     function GetName: widestring;
     function GetSize: Single;

     function GetColorIndex: LongWord;
     function GetColor: LongWord;
     function GetThemeColor: LongWord;
     function GetTintAndShade: double;

     function GetBold: boolean;
     function GetItalic: boolean;
     function GetStrikethrough: boolean;
     function GetOutLineFont: boolean;
     function GetShadow: boolean;
     function GetUnderLine: LongWord;
     function GetSubScript: boolean;
     function GetSuperScript: boolean;
     function GetCharSet: byte;
     function GetFamily: byte;

     procedure SetSize(const Value: Single);

     procedure SetColorIndex(const Value: LongWord);
     procedure SetColor(const Value: LongWord);
     procedure SetThemeColor(const Value: LongWord);
     procedure SetTintAndShade(const Value: double);

     procedure SetBold(const Value: boolean);
     procedure SetItalic(const Value: boolean);
     procedure SetStrikethrough(const Value: boolean);
     procedure SetOutLineFont(const Value: boolean);
     procedure SetShadow(const Value: boolean);
     procedure SetUnderLine(const Value: LongWord);
     procedure SetSubScript(const Value: boolean);
     procedure SetSuperScript(const Value: boolean);
     procedure SetName(const Value: widestring);
     procedure SetCharSet(const Value: byte);
     procedure SetFamily(const Value: byte);
  public
     constructor Create(const Range: TXLSRange);
     property Name: widestring read GetName write SetName;
     property Size: Single read GetSize write SetSize;

     property ColorIndex: LongWord read GetColorIndex write SetColorIndex;
     property Color: LongWord read GetColor write SetColor;
     property ThemeColor: LongWord read GetThemeColor write SetThemeColor;
     property TintAndShade: double read GetTintAndShade write SetTintAndShade;

     property Bold: boolean read GetBold write SetBold;
     property Italic: boolean read GetItalic write SetItalic;
     property Strikethrough: boolean read GetStrikethrough write SetStrikethrough;
     property OutLineFont: boolean read GetOutLineFont write SetOutLineFont;
     property Shadow: boolean read GetShadow write SetShadow;
     property Underline: LongWord read GetUnderline write SetUnderline;
     property SubScript: boolean read GetSubScript write SetSubScript;
     property SuperScript: boolean read GetSuperScript write SetSuperScript;
     property CharSet: byte read GetCharSet write SetCharSet;
     property Family: byte read GetFamily write SetFamily;
   end;


  IXLSBorders = interface
    function GetLineStyle: LongWord;

    function GetColor: LongWord;
    function GetColorIndex: LongWord;
    function GetThemeColor: LongWord;
    function GetTintAndShade: double;

    procedure SetColor(const Value: LongWord);
    procedure SetColorIndex(const Value: LongWord);
    procedure SetThemeColor(const Value: LongWord);
    procedure SetTintAndShade(const Value: double);

    procedure SetLineStyle(const Value: LongWord);
    function GetWeight: LongWord;
    procedure SetWeight(const Value: LongWord);
    function GetBorder(Index: LongWord): IXLSBorder;
    property Color: LongWord read GetColor write SetColor;
    property ColorIndex: LongWord read GetColorIndex write SetColorIndex;
    property ThemeColor: Longword read GetThemeColor write SetThemeColor;
    property TintAndShade: double read GetTintAndShade write SetTintAndShade;
    property LineStyle: LongWord read GetLineStyle write SetLineStyle;
    property Weight: LongWord read GetWeight write SetWeight;
    property Item[Index: LongWord]: IXLSBorder read GetBorder;default;
  end;

  TXLSBorders = class(TXLSObject, IXLSBorders)
  private
    FRange: TXLSRange;
    function GetLineStyle: LongWord;

    function GetColor: LongWord;
    function GetColorIndex: LongWord;
    function GetThemeColor: LongWord;
    function GetTintAndShade: double;

    procedure SetColor(const Value: LongWord);
    procedure SetColorIndex(const Value: LongWord);
    procedure SetThemeColor(const Value: LongWord);
    procedure SetTintAndShade(const Value: double);

    procedure SetLineStyle(const Value: LongWord);
    function GetWeight: LongWord;
    procedure SetWeight(const Value: LongWord);
    function GetBorder(Index: LongWord): IXLSBorder;
  public
    constructor Create(Range: TXLSRange);
    destructor Destroy; override;
  end;

  IXLSBorder = interface
    function GetLineStyle: LongWord;

    function GetColor: LongWord;
    function GetColorIndex: LongWord;
    function GetThemeColor: LongWord;
    function GetTintAndShade: double;

    procedure SetColor(const Value: LongWord);
    procedure SetColorIndex(const Value: LongWord);
    procedure SetThemeColor(const Value: LongWord);
    procedure SetTintAndShade(const Value: double);

    procedure SetLineStyle(const Value: LongWord);
    function GetWeight: LongWord;
    procedure SetWeight(const Value: LongWord);
    property Color: LongWord read GetColor write SetColor;
    property ColorIndex: LongWord read GetColorIndex write SetColorIndex;
    property ThemeColor: Longword read GetThemeColor write SetThemeColor;
    property TintAndShade: double read GetTintAndShade write SetTintAndShade;
    property LineStyle: LongWord read GetLineStyle write SetLineStyle;
    property Weight: LongWord read GetWeight write SetWeight;
  end;

  TXLSBorder = class(TXLSObject, IXLSBorder)
  private
    FRange: TXLSRange;
    FBorderIndex: LongWord;
    function GetLineStyle: LongWord;

    function GetColor: LongWord;
    function GetColorIndex: LongWord;
    function GetThemeColor: LongWord;
    function GetTintAndShade: double;

    procedure SetColor(const Value: LongWord);
    procedure SetColorIndex(const Value: LongWord);
    procedure SetThemeColor(const Value: LongWord);
    procedure SetTintAndShade(const Value: double);

    procedure SetLineStyle(const Value: LongWord);
    function GetWeight: LongWord;
    procedure SetWeight(const Value: LongWord);
  public
    constructor Create(Range: TXLSRange; BorderIndex: LongWord);
    property Color: LongWord read GetColor write SetColor;
    property ColorIndex: LongWord read GetColorIndex write SetColorIndex;
    property ThemeColor: Longword read GetThemeColor write SetThemeColor;
    property TintAndShade: double read GetTintAndShade write SetTintAndShade;
    property LineStyle: LongWord read GetLineStyle write SetLineStyle;
    property Weight: LongWord read GetWeight write SetWeight;
  end;

  IXLSInterior = interface
    procedure SetColor(const Value: LongWord);
    procedure SetColorIndex(const Value: LongWord);
    procedure SetThemeColor(const Value: LongWord);
    procedure SetTintAndShade(const Value: double);

    function GetColor: LongWord;
    function GetColorIndex: LongWord;
    function GetThemeColor: LongWord;
    function GetTintAndShade: double;

    procedure SetPatternColor(const Value: LongWord);
    procedure SetPatternColorIndex(const Value: LongWord);
    procedure SetPatternThemeColor(const Value: LongWord);
    procedure SetPatternTintAndShade(const Value: double);

    function GetPatternColor: LongWord;
    function GetPatternColorIndex: LongWord;
    function GetPatternThemeColor: LongWord;
    function GetPatternTintAndShade: double;

    procedure SetPattern(const Value: LongWord);

    function GetPattern: LongWord;
    property Pattern: LongWord read GetPattern write SetPattern;

    property PatternColorIndex: LongWord read GetPatternColorIndex write SetPatternColorIndex;
    property PatternColor: LongWord read GetPatternColor write SetPatternColor;
    property PatternThemeColor: LongWord read GetPatternThemeColor write SetPatternThemeColor;
    property PatternTintAndShade: double read GetPatternTintAndShade write SetPatternTintAndShade;

    property ColorIndex: LongWord read GetColorIndex write SetColorIndex;
    property Color: LongWord read GetColor write SetColor;
    property ThemeColor: LongWord read GetThemeColor write SetThemeColor;
    property TintAndShade: double read GetTintAndShade write SetTintAndShade;
  end;

  TXLSInterior = class(TXLSObject, IXLSInterior)
  private
    FRange: TXLSRange;
    procedure SetColor(const Value: LongWord);
    procedure SetColorIndex(const Value: LongWord);
    procedure SetThemeColor(const Value: LongWord);
    procedure SetTintAndShade(const Value: double);

    function GetColor: LongWord;
    function GetColorIndex: LongWord;
    function GetThemeColor: LongWord;
    function GetTintAndShade: double;

    procedure SetPatternColor(const Value: LongWord);
    procedure SetPatternColorIndex(const Value: LongWord);
    procedure SetPatternThemeColor(const Value: LongWord);
    procedure SetPatternTintAndShade(const Value: double);

    function GetPatternColor: LongWord;
    function GetPatternColorIndex: LongWord;
    function GetPatternThemeColor: LongWord;
    function GetPatternTintAndShade: double;

    procedure SetPattern(const Value: LongWord);
    function GetPattern: LongWord;
  public
    property Pattern: LongWord read GetPattern write SetPattern;

    property PatternColor: LongWord read GetPatternColor write SetPatternColor;
    property PatternColorIndex: LongWord read GetPatternColorIndex write SetPatternColorIndex;
    property PatternThemeColor: LongWord read GetPatternThemeColor write SetPatternThemeColor;
    property PatternTintAndShade: double read GetPatternTintAndShade write SetPatternTintAndShade;

    property ColorIndex: LongWord read GetColorIndex write SetColorIndex;
    property Color: LongWord read GetColor write SetColor;
    property ThemeColor: LongWord read GetThemeColor write SetThemeColor;
    property TintAndShade: double read GetTintAndShade write SetTintAndShade;

    Constructor Create(const Range: TXLSRange);
  end;

  IXLSPageSetup = interface
    function GetOrientation: LongWord;
    function GetOrder: LongWord;
    function GetPaperSize: LongWord;
    function GetBottomMargin: Double;
    function GetCenterFooter: widestring;
    function GetCenterHeader: widestring;
    function GetCenterHorizontally: boolean;
    function GetCenterVertically: boolean;
    function GetFitToPagesTall: Variant;
    function GetFitToPagesWide: Variant;
    function GetIsFitToPages: boolean;
    function GetFooterMargin: Double;
    function GetHeaderMargin: Double;
    function GetLeftFooter: widestring;
    function GetLeftHeader: widestring;
    function GetLeftMargin: Double;
    function FGetPrintArea: string;
    function GetPrintGridlines: boolean;
    function GetPrintHeadings: boolean;
    function GetPrintTitleColumns: string;
    function GetPrintTitleRows: string;
    function GetRightFooter: widestring;
    function GetRightHeader: widestring;
    function GetRightMargin: Double;
    function GetTopMargin: Double;
    function GetZoom: Variant;
    function GetDraft: boolean;
    function GetBlackAndWhite: boolean;
    function GetPrintNotes: boolean;

    procedure SetOrientation(const Value: LongWord);
    procedure SetOrder(const Value: LongWord);
    procedure SetPaperSize(const Value: LongWord);
    procedure SetBottomMargin(const Value: Double);
    procedure SetCenterFooter(const Value: widestring);
    procedure SetCenterHeader(const Value: widestring);
    procedure SetCenterHorizontally(const Value: boolean);
    procedure SetCenterVertically(const Value: boolean);
    procedure SetFitToPagesTall(const Value: Variant);
    procedure SetFitToPagesWide(const Value: Variant);
    procedure SetFooterMargin(const Value: Double);
    procedure SetHeaderMargin(const Value: Double);
    procedure SetLeftFooter(const Value: widestring);
    procedure SetLeftHeader(const Value: widestring);
    procedure SetLeftMargin(const Value: Double);
    procedure FSetPrintArea(const Value: string);
    procedure SetPrintGridlines(const Value: boolean);
    procedure SetPrintHeadings(const Value: boolean);
    procedure SetPrintTitleColumns(const Value: string);
    procedure SetPrintTitleRows(const Value: string);
    procedure SetRightFooter(const Value: widestring);
    procedure SetRightHeader(const Value: widestring);
    procedure SetRightMargin(const Value: Double);
    procedure SetTopMargin(const Value: Double);
    procedure SetZoom(const Value: Variant);
    procedure SetDraft(const Value: boolean);
    procedure SetBlackAndWhite(const Value: boolean);
    procedure SetPrintNotes(const Value: boolean);

    property Orientation: LongWord       read GetOrientation        write SetOrientation;
    property Order: LongWord             read GetOrder              write SetOrder;
    property PaperSize: LongWord         read GetPaperSize          write SetPaperSize;
    property BottomMargin: Double        read GetBottomMargin       write SetBottomMargin;
    property TopMargin: Double           read GetTopMargin          write SetTopMargin;
    property LeftMargin: Double          read GetLeftMargin         write SetLeftMargin;
    property RightMargin: Double         read GetRightMargin        write SetRightMargin;
    property CenterFooter: widestring    read GetCenterFooter       write SetCenterFooter;
    property RightFooter: widestring     read GetRightFooter        write SetRightFooter;
    property LeftFooter: widestring      read GetLeftFooter         write SetLeftFooter;
    property CenterHeader: widestring    read GetCenterHeader       write SetCenterHeader;
    property RightHeader: widestring     read GetRightHeader        write SetRightHeader;
    property LeftHeader: widestring      read GetLeftHeader         write SetLeftHeader;
    property CenterHorizontally: boolean read GetCenterHorizontally write SetCenterHorizontally;
    property CenterVertically: boolean   read GetCenterVertically   write SetCenterVertically;
    property FooterMargin: Double        read GetFooterMargin       write SetFooterMargin;
    property HeaderMargin: Double        read GetHeaderMargin       write SetHeaderMargin;
    property PrintGridlines: boolean     read GetPrintGridlines     write SetPrintGridlines;
    property PrintHeadings: boolean      read GetPrintHeadings      write SetPrintHeadings;
    property PrintTitleColumns: string   read GetPrintTitleColumns  write SetPrintTitleColumns;
    property PrintTitleRows: string      read GetPrintTitleRows     write SetPrintTitleRows;
    property PrintArea: string           read FGetPrintArea         write FSetPrintArea;
    property Zoom: Variant                  read GetZoom               write SetZoom;
    property FitToPagesTall: Variant        read GetFitToPagesTall     write SetFitToPagesTall;
    property FitToPagesWide: Variant        read GetFitToPagesWide     write SetFitToPagesWide;
    property Draft: boolean              read GetDraft              write SetDraft;
    property BlackAndWhite: boolean      read GetBlackAndWhite      write SetBlackAndWhite;
    property PrintNotes: boolean         read GetPrintNotes         write SetPrintNotes;
    property IsFitToPages: boolean       read GetIsFitToPages;
    procedure SetPrintArea(FirstRow, FirstCol, LastRow, LastCol: integer);
  end;

  TXLSPageSetup = class(TXLSObject, IXLSPageSetup)
  private
    FPrintAreaRowMin: integer;
    FPrintAreaRowMax: integer;
    FPrintAreaColMin: integer;
    FPrintAreaColMax: integer;
    FOrientation: Byte;
    FOrder: Byte;
    FPaperSize: Word;
    FPrintGridlines: boolean;
    FCenterHorizontally: boolean;
    FCenterVertically: boolean;
    FPrintHeadings: boolean;
    FHeaderMargin: Double;
    FFooterMargin: Double;
    FBottomMargin: Double;
    FRightMargin: Double;
    FLeftMargin: Double;
    FTopMargin: Double;
    FPrintArea: string;
    FCenterHeader: widestring;
    FRightHeader: widestring;
    FPrintTitleColumnFrom: integer;
    FPrintTitleColumnTo: integer;
    FRightFooter: widestring;
    FCenterFooter: widestring;
    FPrintTitleRowFrom: integer;
    FPrintTitleRowTo: integer;
    FLeftFooter: widestring;
    FLeftHeader: widestring;
    FFitToPagesWide: Word;
    FZoom: Word;
    FFitToPagesTall: Word;
    FIsFitToPages: boolean;
    FDraft: boolean;
    FBlackAndWhite: boolean;
    FPrintNotes: boolean;
    FWorkSheet: IXLSWorkSheet;
    FExternID: integer;

    function GetOrientation: LongWord;
    function GetOrder: LongWord;
    function GetPaperSize: LongWord;
    function GetBottomMargin: Double;
    function GetCenterFooter: widestring;
    function GetCenterHeader: widestring;
    function GetCenterHorizontally: boolean;
    function GetCenterVertically: boolean;
    function GetFitToPagesTall: Variant;
    function GetFitToPagesWide: Variant;
    function GetIsFitToPages: boolean;
    function GetFooterMargin: Double;
    function GetHeaderMargin: Double;
    function GetLeftFooter: widestring;
    function GetLeftHeader: widestring;
    function GetLeftMargin: Double;
    function FGetPrintArea: string;
    function GetPrintGridlines: boolean;
    function GetPrintHeadings: boolean;
    function GetPrintTitleColumns: string;
    function GetPrintTitleRows: string;
    function GetRightFooter: widestring;
    function GetRightHeader: widestring;
    function GetRightMargin: Double;
    function GetTopMargin: Double;
    function GetZoom: Variant;
    function GetDraft: boolean;
    function GetBlackAndWhite: boolean;
    function GetPrintNotes: boolean;

    procedure SetOrientation(const Value: LongWord);
    procedure SetOrder(const Value: LongWord);
    procedure SetPaperSize(const Value: LongWord);
    procedure SetBottomMargin(const Value: Double);
    procedure SetCenterFooter(const Value: widestring);
    procedure SetCenterHeader(const Value: widestring);
    procedure SetCenterHorizontally(const Value: boolean);
    procedure SetCenterVertically(const Value: boolean);
    procedure SetFitToPagesTall(const Value: Variant);
    procedure SetFitToPagesWide(const Value: Variant);
    procedure SetFooterMargin(const Value: Double);
    procedure SetHeaderMargin(const Value: Double);
    procedure SetLeftFooter(const Value: widestring);
    procedure SetLeftHeader(const Value: widestring);
    procedure SetLeftMargin(const Value: Double);
    procedure FSetPrintArea(const Value: string);
    procedure SetPrintGridlines(const Value: boolean);
    procedure SetPrintHeadings(const Value: boolean);
    procedure SetPrintTitleColumns(const Value: string);
    procedure SetPrintTitleRows(const Value: string);
    procedure SetRightFooter(const Value: widestring);
    procedure SetRightHeader(const Value: widestring);
    procedure SetRightMargin(const Value: Double);
    procedure SetTopMargin(const Value: Double);
    procedure SetZoom(const Value: Variant);
    procedure SetDraft(const Value: boolean);
    procedure SetBlackAndWhite(const Value: boolean);
    procedure SetPrintNotes(const Value: boolean);
  public
    property Orientation: LongWord       read GetOrientation        write SetOrientation;
    property Order: LongWord             read GetOrder              write SetOrder;
    property PaperSize: LongWord         read GetPaperSize          write SetPaperSize;
    property BottomMargin: Double        read GetBottomMargin       write SetBottomMargin;
    property TopMargin: Double           read GetTopMargin          write SetTopMargin;
    property LeftMargin: Double          read GetLeftMargin         write SetLeftMargin;
    property RightMargin: Double         read GetRightMargin        write SetRightMargin;
    property CenterFooter: widestring    read GetCenterFooter       write SetCenterFooter;
    property RightFooter: widestring     read GetRightFooter        write SetRightFooter;
    property LeftFooter: widestring      read GetLeftFooter         write SetLeftFooter;
    property CenterHeader: widestring    read GetCenterHeader       write SetCenterHeader;
    property RightHeader: widestring     read GetRightHeader        write SetRightHeader;
    property LeftHeader: widestring      read GetLeftHeader         write SetLeftHeader;
    property CenterHorizontally: boolean read GetCenterHorizontally write SetCenterHorizontally;
    property CenterVertically: boolean   read GetCenterVertically   write SetCenterVertically;
    property FooterMargin: Double        read GetFooterMargin       write SetFooterMargin;
    property HeaderMargin: Double        read GetHeaderMargin       write SetHeaderMargin;
    property PrintGridlines: boolean     read GetPrintGridlines     write SetPrintGridlines;
    property PrintHeadings: boolean      read GetPrintHeadings      write SetPrintHeadings;
    property PrintTitleColumns: string   read GetPrintTitleColumns  write SetPrintTitleColumns;
    property PrintTitleRows: string      read GetPrintTitleRows     write SetPrintTitleRows;
    property PrintArea: string           read FGetPrintArea         write FSetPrintArea;
    property Zoom: Variant               read GetZoom               write SetZoom;
    property FitToPagesTall: Variant     read GetFitToPagesTall     write SetFitToPagesTall;
    property FitToPagesWide: Variant     read GetFitToPagesWide     write SetFitToPagesWide;
    property Draft: boolean              read GetDraft              write SetDraft;
    property BlackAndWhite: boolean      read GetBlackAndWhite      write SetBlackAndWhite;
    property PrintNotes: boolean         read GetPrintNotes         write SetPrintNotes;
    property IsFitToPages: boolean       read GetIsFitToPages;
    procedure SetPrintArea(FirstRow, FirstCol, LastRow, LastCol: integer);
    constructor Create;
    destructor Destroy;override;
  end;

  TXLSPanes = class(TObject)
  private
    FFrozen: boolean;
    FX, FY: Single;
    FRow: integer;
    FCol: integer;
    FRowTop: integer;
    FColLeft: integer;
    procedure SetCol(const Value: integer);
    procedure SetColLeft(const Value: integer);
    procedure SetFrozen(const Value: boolean);
    procedure SetRow(const Value: integer);
    procedure SetRowTop(const Value: Integer);
    procedure SetX(const Value: Single);
    procedure SetY(const Value: Single);
  public
    property Frozen: boolean read FFrozen write SetFrozen;
    property X: Single read FX write SetX;
    property Y: Single read FY write SetY;
    property Row: integer read FRow write SetRow;
    property Col: integer read FCol write SetCol;
    property RowTop: integer read FRowTop write SetRowTop;
    property ColLeft: integer read FColLeft write SetColLeft;
    procedure Freeze(Const Row: integer; Const Col: integer;
                     Const RowTop: integer; Const ColLeft: integer);
    procedure Thaw(Const X: Single; Const Y: Single;
                   Const RowTop: integer; Const ColLeft: integer);
    procedure Clear;
    constructor Create;
  end;

  TXLSProtect = class(TObject)
  private
    FProtected: boolean;
    FIsPassword: boolean;
    FEncodedPassword: Word;
    FOptions: word;
    function rot15(Value: Word; n: integer): Word;
    function  EncodePassword(Password: string): Word;
  public
    constructor Create;
    procedure ProtectEncode(AEncodedPassword: Word);
    procedure SetProtected(Value: boolean);
    procedure SetOptions(AOptions: Word);  
    property isProtected: boolean read FProtected write FProtected;
    property isPassword: boolean read FIsPassword;
    property EncodedPassword: Word read FEncodedPassword;
    procedure Protect(Password: string);
    function UnProtect(Password: string; UsePassword: boolean): boolean;
  end;


  IXLSWorkSheets = class
  private
    FWorkSheets: array of IXLSWorkSheet;
    FCount: integer;
    FWorkbook: TXLSWorkbook;
    FActiveSheet: IXLSWorkSheet;
    FCurrentSheetID: integer; 
    function GetActiveSheet: IXLSWorkSheet;
    function GetNewSheetID: integer;
  protected
    function Get(Index: Integer): IXLSWorkSheet;
    function GetSheet(Index: Integer): IXLSWorkSheet;
    function GetIndexByName(SheetName: widestring): integer;
    function GetIDByName(ASheetName: widestring): integer;
    function GetIndexByID(SheetID: integer): integer;
    function GetNameByID(SheetID: integer): WideString;
    function GetCount: integer;
    function CheckName(Index: integer; Name: widestring): boolean;
    function GetNewName: widestring;
    function AddSheet(Index: integer): IXLSWorkSheet; overload;
    procedure MoveSheet(FromIndex, ToIndex: integer);
    procedure Deselect;
    property Items[Index: Integer]: IXLSWorkSheet read GetSheet;    
  public
    constructor Create(AWorkbook: TXLSWorkbook);
    destructor  Destroy; override;
    function    Add: IXLSWorkSheet; overload;
    function    Add(Before, After: IXLSWorkSheet): IXLSWorkSheet; overload;
    function    Add(Before, After: IXLSWorkSheet; Count: integer): IXLSWorkSheet; overload;
    function    Add(Before, After: IXLSWorkSheet; Count: integer; Type_: OleVariant): IXLSWorkSheet; overload;
    function    AddBefore(Index: integer): IXLSWorkSheet; overload;
    function    AddBefore(Name: WideString): IXLSWorkSheet; overload;
    function    AddBefore(WorkSheet:IXLSWorkSheet): IXLSWorkSheet; overload;
    function    AddAfter(Index: integer): IXLSWorkSheet; overload;
    function    AddAfter(Name: WideString): IXLSWorkSheet; overload;
    function    AddAfter(WorkSheet:IXLSWorkSheet): IXLSWorkSheet; overload;
    property    Entries[Index: Integer]: IXLSWorkSheet read Get; default;
    property    Count: integer read GetCount;
    property    Index[SheetName: widestring]: integer read GetIndexByName;
    procedure   Delete(Index: integer);
    property    IndexByID[SheetID: integer]: integer read GetIndexByID;
    property    IDByName[SheetName: WideString]: integer read GetIDByName;
    property    NameByID[SheetID: integer]: WideString read GetNameByID;
  end;

  TXLSOutline = class(TXLSObject)
  private
    FSummaryColumn: XlSummaryColumn;
    FSummaryRow: XlSummaryRow;
    procedure SetSummaryColumn(Value: XlSummaryColumn);
    procedure SetSummaryRow(Value: XlSummaryRow);
  public
    constructor Create;
    property SummaryColumn: XlSummaryColumn read FSummaryColumn write SetSummaryColumn;
    property SummaryRow: XlSummaryRow    read FSummaryRow    write SetSummaryRow;
  end;

  IXLSWorksheet = class(TXLSObject)
  private
    FCells: TXLSCellHeap;
    FCellsRange: IXLSRange;
    FPanes: TXLSPanes;
    FProtect: TXLSProtect;
    FSelection: IXLSRange;

    FPageSetup: TXLSPageSetup;
    FIPageSetup: IXLSPageSetup;

    FHPageBreaks: TXLSHPageBreaks;
    FVPageBreaks: TXLSVPageBreaks;
    FScreenGridLines: boolean;

    FRowInfo: TXLSRowInfoList;
    FColumnInfo: TXLSColumnInfoList;
    FOutline: TXLSOutline;
    FAutofilter: TXLSAutofilter;
    FDBCellIndex: TXLSDBCellIndex;
 
    FZoom: SmallInt;

    FDimRowMin: integer;
    FDimRowMax: integer;
    FDimColMin: integer;
    FDimColMax: integer;
    FDimChanged: boolean;

    FActivePane: SmallInt;
    FFrozen: boolean;
    FDisplayZeros: boolean;
    FDisplayRightToLeft: boolean;

    FDataPreHeader: TXLSBlobList;
    FDataHeader: TXLSBlobList;
    FDataBody:    TXLSBlobList;
    FDataComment: TXLSBlobList;
    FDataFooter:  TXLSBlobList;

    FWorkBook: TXLSWorkbook;

    FOffset: LongWord;
    FDataSize: LongWord;
    FIndex: Word;
    FWorksheetName: widestring;
    FCommentCount: LongWord;
    FStartCommentBlock: LongWord;
    FScrollRow: integer;
    FScrollColumn: integer;
    FSelected: boolean;

    FHyperlinks: TXLSCustomHyperlinks;
    FVisible: byte;
    FDrawing: TMSODrawing;
    FVBAObjectName: WideString;
    FView: TXlWindowView;

    FChart: TXLSCustomChart;
    FCondFormatter: TCondFormatter;
    FDataValidator: TDataValidator;

    FRid: widestring; 

    function Store01BA(DList: TXLSBlobList): integer;  
    function StoreChart: integer;
     

    
    function Close: integer;
    function StoreCells: integer;
    function Store: integer;
    function GetCells: IXLSRange;
    function GetSelection: IXLSRange;
    function FGetRange(Cell1: string; Cell2: string): IXLSRange;
    function GetRange(Cell1: string; Cell2: string): TXLSRange;
    function FGetRowColRange(row1, col1, row2, col2: integer): IXLSRange;
    function GetPageSetup: IXLSPageSetup;
    function GetIndex: Word;
    function GetHPageBreaks: TXLSHPageBreaks;
    function GetVPageBreaks: TXLSVPageBreaks;
    function GetDisplayGridLines: boolean;
    procedure SetDisplayGridLines(Value: boolean);
    function GetUsedRange:IXLSRange;
    function GetWorkSheetName: widestring;
    procedure SetWorkSheetName(Value: widestring);
    function GetNextWorkSheet: IXLSWorkSheet;
    function GetPreviousWorkSheet: IXLSWorkSheet;
    function GetHyperlinks: IXLSHyperlinks;

    function  AddContinue(Data: TXLSBlob):TXLSBlob;
    function  AppendData(Data: TXLSBlob; DataList: TXLSBlobList):integer;

    procedure ClearDimensions;
    function  CheckDimensions (Row, Col: integer):integer;
    function  StoreAutofilter: integer;
    function  StoreDimensions:integer;
    function  StoreWindow2:integer;
    function  StoreAllColumnInfo:integer;
    function  StoreAllRowInfo:integer;
    function  StoreRowInfo(FirstRow, LastRow: integer ): integer;
    function  StoreIndex: integer;
    function  StoreCalculationSettings:integer;
    function  StoreSelection(Selection: IXLSRange):integer;
    function  StoreExternCount(Count: Word):integer;
    function  StoreExternSheet(SheetName: widestring) :integer;
    function  StoreExternBook(): integer;
    function  StorePanes(Panes: TXLSPanes) :integer;
    function  StoreSetup :integer;
    function  StoreHeader :integer;
    function  StoreFooter :integer;
    function  StoreHcenter :integer;
    function  StoreVcenter :integer;
    function  StoreMarginLeft :integer;
    function  StoreMarginRight :integer;
    function  StoreMarginTop :integer;
    function  StoreMarginBottom :integer;
    function  MergeCells (FirstRow, FirstCol, LastRow, LastCol: integer):integer;
    function  StorePrintHeaders :integer;
    function  StorePrintGridLines :integer;
    function  StoreGridSet :integer;
    function  StoreGuts :integer;
    function  StoreWsbool :integer;
    function  StoreHBreak :integer;
    function  StoreVBreak :integer;
    function  StoreProtect :integer;
    function  StoreSheetProtection :integer;
    function  StorePassword :integer;
    function  StoreZoom :integer;
    function  StoreBof(BofType: Word):integer;
    function  StoreEof:integer;
    function  StoreDrawing: integer;
    function  WriteDouble(row:Word; col:Word; Value:Double; Format:integer): integer;
    function  MergeWriteDouble(FirstRow, FirstCol, LastRow, LastCol: integer; Value:Double; Format:integer): integer;
    function  WriteData (Book: IStream): Integer;

    function WriteRK(row:Word; col:Word; Value: Longword; Format:integer): integer;
    function WriteMulRK(row: integer; col: integer; count: integer): integer;

    function Write(row:Word; col:Word; Format:integer): integer;//overload;virtual;
    function WriteMulBlank(row: integer; col: integer; count: integer): integer;
    
    function WriteNumber(row:Word; col:Word; Value:Double; Format:integer): integer;//overload;virtual;
    function WriteString(row:Word; col:Word; Value:Integer; Format:integer): integer;//overload;virtual;
    function WriteArrayFormula(Value: TXLSCompiledFormula; Format: integer): integer;
    function WriteFormula(row:Word; col:Word; Value:TXLSCompiledFormula; Format:integer): integer;//overload;virtual;
    function  WriteBoolean(row:Word; col:Word; Value:Boolean; Format:integer): integer;

    function MergeWriteNumber(FirstRow, FirstCol, LastRow, LastCol: integer; Value:Double; Format:integer): integer;//overload;virtual;
    function MergeWriteString(FirstRow, FirstCol, LastRow, LastCol: integer; Value:Integer; Format:integer): integer;//overload;virtual;
    function MergeWriteFormula(FirstRow, FirstCol, LastRow, LastCol: integer; Value:TXLSCompiledFormula; Format:integer): integer;//overload;virtual;
    function  MergeWriteBoolean(FirstRow, FirstCol, LastRow, LastCol: integer; Value:Boolean; Format:integer): integer;
    function MergeWrite(FirstRow, FirstCol, LastRow, LastCol: integer; Format:integer): integer;//overload;virtual;

    function WriteFormulaString(Value:WideString): integer;

    function GetScrollRow: integer;
    function GetScrollColumn: integer;
    procedure SetScrollRow(Value: integer);
    procedure SetScrollColumn(Value: integer);
    procedure SetZoom(const Value: Variant);
    function  GetZoom: Variant;
    procedure SetStdHeight(Value: Double);
    procedure SetStdWidth(Value: Double);
    function  GetStdHeight: Double;
    function  GetStdWidth: Double;
    procedure SetVisible(const Value: Variant);
    function  GetVisible: Variant;
    function  GetXPoint(StartCol: integer; Offset: double;
                   Var RetCol: word; Var RetOffset: word): boolean;
    function  GetYPoint(StartRow: integer; Offset: double;
                   Var RetRow, RetOffset: word): boolean;
    procedure GetShapeRect(Row, Col: Word; Height, Width: Double; 
                       Var Row1, Row1Offset, Row2, Row2Offset,
                           Col1, Col1Offset, Col2, Col2Offset: Word);
    procedure GetShapeSize(Row1, Row1Offset,
                           Row2, Row2Offset,
                           Col1, Col1Offset,
                           Col2, Col2Offset: Word;
                       Var Width, Height: Double);
    procedure GetShapeRect2(Row1, Row1Offset, Col1, Col1Offset: Word; Height, Width: Double; 
                        Var Row2, Row2Offset, Col2, Col2Offset: Word);
    procedure SetAutofilterShape(ARow, ACol: integer; AShape: TObject);
    procedure GetCurRowCol(Var Row, Col: word);
    function  GetShapes: TXLSShapes;  
    function  GetIsProtected: boolean;
    function GetNames: IXLSNames;
  public
    FSheetID: integer;
    property Cells: IXLSRange read GetCells;
    property Selection: IXLSRange read GetSelection;
    property PageSetup: IXLSPageSetup read GetPageSetup;
    property RCRange[row1, col1, row2, col2: integer]: IXLSRange read FGetRowColRange;
    property Range[Cell1: string; Cell2: string]: IXLSRange read FGetRange;
    property UsedRange: IXLSRange read GetUsedRange;
    property Name: widestring read GetWorkSheetName write SetWorkSheetName;

    property Index: Word read GetIndex;
    property Next: IXLSWorkSheet          read GetNextWorkSheet;
    property Previous: IXLSWorkSheet      read GetPreviousWorkSheet;
    property HPageBreaks: TXLSHPageBreaks read GetHPageBreaks;
    property VPageBreaks: TXLSVPageBreaks read GetVPageBreaks;
    property DisplayGridLines: boolean    read GetDisplayGridLines write SetDisplayGridLines;
    property ScrollRow:        integer    read GetScrollRow        write SetScrollRow;
    property ScrollColumn:     integer    read GetScrollColumn     write SetScrollColumn;
    property Zoom:             Variant    read GetZoom             write SetZoom;
    property StandardWidth:    Double     read GetStdWidth         write SetStdWidth;
    property StandardHeight:   Double     read GetStdHeight        write SetStdHeight;
    property Selected:         Boolean    read FSelected           write FSelected;
    property Visible:          Variant    read GetVisible          write SetVisible;
    property DisplayZeros:     Boolean    read FDisplayZeros       write FDisplayZeros;
    property DisplayRightToLeft: Boolean  read FDisplayRightToLeft write FDisplayRightToLeft;

    property  _Protect: TXLSProtect read FProtect;

    constructor Create(Workbook: TXLSWorkbook; ASheetID: integer);
    destructor Destroy;override;
    procedure Delete; overload;
    procedure Delete(lcid: integer); overload;

    procedure Move(Before: IXLSWorkSheet; After: IXLSWorkSheet; lcid: integer);overload;
    procedure Move(Before: IXLSWorkSheet; After: IXLSWorkSheet);overload;
    procedure Move(Before: IXLSWorkSheet);overload;
    procedure Select;overload;
    procedure Select(Replace: boolean);overload;
    procedure Select(Replace: boolean; lcid: integer);overload;
    procedure ResetAllPageBreaks;

    procedure Activate;
    function SetFirstSheet: integer;virtual;
    function ThawPanes(Y:Single; X:Single; RowTop, ColLeft: integer): integer;virtual;
    function FreezePanes(row, col, RowTop, ColLeft: integer): integer;virtual;
    function RepeatRows(FirstRow, LastRow: integer): integer;virtual;
    function RepeatColumns(FirstCol, LastCol: integer): integer;virtual;

    procedure Protect();overload;
    procedure Protect(Password: string);overload;
    procedure UnProtect();overload;
    procedure UnProtect(Password: string);overload;
    procedure UnProtect(Password: string; lcid: integer);overload;
    function  SaveAsHTML(Filename: widestring): integer;
    function  Calculate(Formula: WideString): Variant;
    function  SaveAsCSV(FileName: WideString): integer; overload;
    function SaveAs(FileName: WideString; FileFormat: TXLSFileFormat): integer; overload;
    function SaveAs(Stream: TStream; FileFormat: TXLSFileFormat): integer; overload;
    function  GetOutline: TXLSOutline;
    function  SaveAsRTF(FileName: WideString): integer; overload;
    function  SaveAsRTF(Stream: TStream): integer; overload;

    property  Workbook: TXLSWorkbook read FWorkBook;
    property  Hyperlinks: IXLSHyperlinks read GetHyperlinks;
    property  Shapes: TXLSShapes read GetShapes;
    property  Outline: TXLSOutline read GetOutline;
    property  IsProtected: boolean read GetIsProtected;
    property  Names: IXLSNames read GetNames;

    function GetCustomHyperlinks: TXLSCustomHyperlinks;

    procedure _SetCompiledFormula(row, col: word; Formula: TXLSCompiledFormula);
    function  _GetCompiledFormula(row, col: word): TXLSCompiledFormula;
    function  _FGetRowColRange2(row1, col1, row2, col2: integer): TXLSRange;
    procedure _SetXF(row, col: word; xf: integer);
    function GetXFIndex(row, col: integer; Var ReplaceIndex: boolean): integer;
    function GetColumnXFIndex(col: integer): integer;
    function GetRowXFIndex(row: integer): integer;

    procedure _SetChartData(AData: TXLSCustomChart);
     
    property  _ColumnInfo: TXLSColumnInfoList read FColumnInfo;
    property  _RowInfo: TXLSRowInfoList read FRowInfo;
    property  _Hyperlinks: TXLSCustomHyperlinks read FHyperlinks;
    property  _Drawing: TMSODrawing read FDrawing;
    property  _Autofilter: TXLSAutofilter read FAutofilter;
    property  _Panes: TXLSPanes read FPanes;
    property  _CellsHeap: TXLSCellHeap read FCells;
    property  _VBAObjectName: WideString read FVBAObjectName write FVBAObjectName;
    property  _CF: TCondFormatter read FCondFormatter;
    property  _DV: TDataValidator read FDataValidator;
    property  _RID: widestring read FRid write FRid;
    
    property  View: TXlWindowView read FView write FView;

  end;

  TXLSPageBreaks = class(TObject)
  private
    FPageBreaks: array of TXLSPageBreak;
    FCount: integer;
    FVertical: Boolean;
    FWorkSheet: IXLSWorksheet;
    procedure Delete(Index: integer);
    function GetCount: integer;
    function Get(Index: integer): TXLSPageBreak;
    function GetLocation(Index: integer): TXLSRange;
    procedure ClearAll;
    function CreatePageBreak: TXLSPageBreak; virtual;
    function AddPageBreak(Before: IXLSRange): TXLSPageBreak;
  public
    constructor Create(Worksheet: IXLSWorksheet);
    destructor Destroy;override;
    property Count: integer read GetCount;
  end;


  TXLSPageBreak = class(TObject)
  private
    FIndex: integer;
    FPosition: integer;
    FPageBreaks: TXLSPageBreaks;
  public
    constructor Create(PageBreaks: TXLSPageBreaks);
    procedure Delete;
  end;

  TXLSVPageBreak = class(TXLSPageBreak)
  private
    function GetLocation: IXLSColsRange;
  public
    property Location: IXLSColsRange read GetLocation;
  end;

  TXLSHPageBreak = class(TXLSPageBreak)
  private
    function GetLocation: IXLSRowsRange;
  public
    property Location: IXLSRowsRange read GetLocation;
  end;

  TXLSVPageBreaks = class(TXLSPageBreaks)
  private
    function CreatePageBreak: TXLSPageBreak; override;
    function GetPageBreak(Index: integer): TXLSVPageBreak;
  public
    constructor Create(WorkSheet: IXLSWorksheet);
    property Item[Index: integer]: TXLSVPageBreak read GetPageBreak; default;
    function Add(Before: IXLSRange): TXLSVPageBreak;
  end;

  TXLSHPageBreaks = class(TXLSPageBreaks)
  private
    function CreatePageBreak: TXLSPageBreak; override;
    function GetPageBreak(Index: integer): TXLSHPageBreak;
  public
    constructor Create(WorkSheet: IXLSWorksheet);
    property Item[Index: integer]: TXLSHPageBreak read GetPageBreak; default;
    function Add(Before: IXLSRange): TXLSHPageBreak;
  end;

  IXLSWorkBook = interface
    function GetCustomColor2(Index: integer; lcid: integer): LongWord;
    procedure SetCustomColor(Index: integer; lcid: integer; const Value: LongWord);
      function SetCodePage(ACodePage: Word): integer;
    function GetWorksheets: IXLSWorksheets;
    function GetActiveSheet: IXLSWorkSheet;
    function Close: integer;
    function GetIsProtected: boolean;
    property Colors[Index: integer; lcid: integer]:LongWord read GetCustomColor2 write SetCustomColor;
    property WorkSheets: IXLSWorksheets read GetWorkSheets;
    property Sheets: IXLSWorksheets read GetWorkSheets;
    property ActiveSheet: IXLSWorkSheet read GetActiveSheet;
    procedure ResetColors;
    procedure Protect();overload;
    procedure Protect(Password: string);overload;
    procedure UnProtect();overload;
    procedure UnProtect(Password: string);overload;
    procedure UnProtect(Password: string; lcid: integer);overload;
    function  SaveAs(FileName: widestring): integer; overload;
    function  SaveAs(FileName: widestring; FileFormat: TXLSFileFormat): integer; overload;
    function  SaveAs(Stream: TStream): integer; overload;
    function  SaveAs(Stream: TStream; FileFormat: TXLSFileFormat): integer; overload;
    function  Save: integer;
    function  SaveAsHTML(FileName: widestring): integer;
    function  SaveAsRTF(FileName: widestring): integer; overload;
    function  SaveAsRTF(Stream: TStream): integer; overload;
    function  Calculate(Formula: WideString): Variant;
    function  GetReferenceStyle: integer;
    function  GetNames: IXLSNames;
    function GetDate1904: boolean;
    procedure SetDate1904(Value: boolean);
    procedure SetReferenceStyle(Value: integer);
    property  ReferenceStyle: integer read GetReferenceStyle write SetReferenceStyle;  
    property  IsProtected: boolean read GetIsProtected;
    property  Names: IXLSNames read GetNames;
    property  Date1904: boolean read GetDate1904 write SetDate1904;
    function  Open(Stream: TStream): integer;overload;
    function  Open(FileName: WideString): integer;overload;
    function  Open(Stream: TStream; APassword: WideString): integer;overload;
    function  Open(FileName: WideString; APassword: WideString): integer;overload;
    procedure ClearVBA;
    function  VBADefined: boolean;
    function  GetDisableGraphics:boolean;
    procedure SetDisableGraphics(Value: boolean);
    property _DisableGraphics: boolean read GetDisableGraphics write SetDisableGraphics;
    function GetVBAProject: TXLSVBAProject;
    property VBAProject: TXLSVBAProject read GetVBAProject;
    
  end;

  TXLSWorkbook = class(TXLSObject, IXLSWorkBook)
  private
     FDocStorage: IStorage;
     FFileClosed: boolean;
     FSheetName: widestring;
//     FPalette: TPalette;
     FColorManager: TXLSColorManager;
     FCodePage: Word;
     FXFList: TXLSStyleXFs;
     FDataSize: LongWord;
     FBiffSize: LongWord;
     FProtect: TXLSProtect;
     FLimit: Word;
     F1904: boolean;
     FXFIndex: Word;
     DataList: TXLSBlobList;
     DataList2: TXLSBlobList;
     FFileName: widestring;
     FFirstSheet: SmallInt;
     FBiffVersion: Word;
     FWorksheets: IXLSWorksheets;
     FSelected: SmallInt;
     FFormula: TXLSCalculator;
     FNames: TXLSCustomNames;
     FSST: TXLSStringTable;
     FDefaultFileFormat: TXLSFileFormat;
     FFileFormat: TXLSFileFormat;
     FExtern: TXLSExternSheet;
     FChangeID: longword;
     FDrawingGroup: TMSODrawingGroup;
     FReferenceStyle: integer; 
     FVBAObjectName: WideString;
     FOriginalFileFormat: TXLSFileFormat;
     FVBA: TXLSFileStorage;
     FVBAProject: TXLSVBAProject;
     FXLSXVBAProject: TXLSBlob;
     FCtls: TXLSFileStream;
     FDisableGraphics: boolean; 
     function Store01BA(DList: TXLSBlobList): integer;  
     function StoreObjProj(DList: TXLSBlobList): integer;  
     function GetVBAProject: TXLSVBAProject;
      
     function StoreWorkbook: integer;
     function Append(DList: TXLSBlobList; Data: TXLSBlob): integer;
     function AddContinue(Data: TXLSBlob): TXLSBlob;
     function StoreBof(DList: TXLSBlobList; BofType: SmallInt): integer;
     function StoreCodePage(DList: TXLSBlobList): integer;
     function StoreExterns(DList: TXLSBlobList): integer;
     function StoreNames(DList: TXLSBlobList): integer;
     function StoreWindow1(DList: TXLSBlobList): integer;
     function Store1904(DList: TXLSBlobList): integer;
     function StorePrecision(DList: TXLSBlobList): integer;
     function StoreRefMode(DList: TXLSBlobList): integer;
     function StoreBookBool(DList: TXLSBlobList): integer;
     function StoreBackup(DList: TXLSBlobList): integer;
     function StoreDSF(DList: TXLSBlobList): integer;
     function StoreFnGroupCount(DList: TXLSBlobList): integer;
     function StoreCountry(DList: TXLSBlobList): integer;
     function Store01C1(DList: TXLSBlobList): integer;
     function StoreProtect(DList: TXLSBlobList): integer;
     function StorePassword(DList: TXLSBlobList): integer;
     function StoreAllFonts(DList: TXLSBlobList): integer;
     function StoreAllNumFormats(DList: TXLSBlobList): integer;
     function StoreAllXFS(DList: TXLSBlobList): integer;
     function StoreAllStyles(DList: TXLSBlobList): integer;
     function StorePalette(DList: TXLSBlobList): integer;
     function GetAllBoundSheetSize: longword;
     function StoreBoundSheet(DList: TXLSBlobList; SheetName: widestring; Offset: LongWord; Visible: byte; SheetType: byte): integer;
     function StoreExternCount(DList: TXLSBlobList; Value: Word): integer;
     function StoreEof(DList: TXLSBlobList): integer;
     function StoreExternSheet(DList: TXLSBlobList; SheetName: widestring): integer;overload;
     function StoreExternSheet(DList: TXLSBlobList): integer; overload;
     function StoreExternBook(DList: TXLSBlobList): integer; 
     function StoreSupBook(DList: TXLSBlobList): integer;
     function StoreSST(DList: TXLSBlobList; Offset: LongWord): integer;
     function StoreDrawingGroup(DList: TXLSBlobList): integer;

     function StoreExtraSpace(Stream: IStream): integer;

     function StoreOleFile: integer;
     function StoreNameShort(DList: TXLSBlobList; ExternID: integer; NameType: Byte; RowMin, RowMax, ColMin, ColMAx: integer; grbit: word): integer;
     function StoreNameLong(DList: TXLSBlobList; ExternID: Integer; NameType: Byte; RowMin, RowMax, ColMin, ColMax: integer): integer;
//     function GetCustomColorIndex(Value: LongWord): integer;
     function GetCustomColor(Index: integer): LongWord;
     function GetCustomColor2(Index: integer; lcid: integer): LongWord;
     procedure SetCustomColor(Index: integer; lcid: integer; const Value: LongWord);
     function SetPaletteXL97: integer;
     function GetActiveSheet: IXLSWorkSheet;
     function GetWorksheets: IXLSWorksheets;
//     procedure GetSheetIndexByName(SheetName: widestring; Var SheetIndex: integer);
     procedure GetSheetIndexByID(SheetID: integer; Var SheetIndex: integer);
     procedure GetSheetIDByName(SheetName: widestring; Var SheetID: integer);
     function GetExcel5BookExternID(): integer;

     procedure GetSheetNameByIndex(SheetIndex: integer; Var SheetName: widestring);
     function GetCompiledFormula(aFormula: string; SheetID: integer): TXLSCompiledFormula;
     function GetUnCompiledFormula(aFormula: TXLSCompiledFormula; CurRow, CurCol, SheetID: integer): string;
     function GetFormulaValue(aSheetIndex: integer; aFormula: TXLSCompiledFormula; CurRow, CurCol: integer; Var Value: variant): integer;
     function GetCellValue(SheetIndex, row, col: integer; Var Value: Variant; Var OutOfUsedRange: boolean): integer;
     procedure IncChangeID;
     function SaveWorkbook(FileName: widestring; Stream: TStream; FileFormat: TXLSFileFormat): integer;
    function  GetReferenceStyle: integer;
    procedure SetReferenceStyle(Value: integer);
    function GetIsProtected: boolean;
    function GetDate1904: boolean;
    procedure SetDate1904(Value: boolean);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Close: integer; virtual;
    function SetTempDir(Const ATempDir: string): integer; virtual;
    function SetCodePage(ACodePage: Word): integer; virtual;
    property Colors[Index: integer; lcid: integer]:LongWord read GetCustomColor2 write SetCustomColor;
    property WorkSheets: IXLSWorksheets read GetWorkSheets;
    property Sheets: IXLSWorksheets read GetWorkSheets;
    property ActiveSheet: IXLSWorkSheet read GetActiveSheet;
    procedure ResetColors;
    procedure Protect();overload;
    procedure Protect(Password: string);overload;
    procedure UnProtect();overload;
    procedure UnProtect(Password: string);overload;
    procedure UnProtect(Password: string; lcid: integer);overload;
    function SaveAs(FileName: widestring): integer; overload;
    function SaveAs(FileName: widestring; FileFormat: TXLSFileFormat): integer; overload;
    function SaveAs(Stream: TStream): integer; overload;
    function SaveAs(Stream: TStream; FileFormat: TXLSFileFormat): integer; overload;
    function SaveAsHTML(FileName: widestring): integer;
    function SaveAsRTF(FileName: widestring): integer; overload;
    function SaveAsRTF(Stream: TStream): integer; overload;
    function Save: integer;

    function  Calculate(Formula: WideString): Variant;
    procedure InitFormula;
    property  _XFList: TXLSStyleXFs read FXFList;
    property  DrawingGroup: TMSODrawingGroup read FDrawingGroup;
    property  ReferenceStyle: integer read GetReferenceStyle write SetReferenceStyle;  
    property  IsProtected: boolean read GetIsProtected;
    property  Date1904: boolean read GetDate1904 write SetDate1904;
    property  _Names: TXLSCustomNames read FNames;
    function  GetNames: IXLSNames;
    property  _Formula: TXLSCalculator read FFormula;
    property  _Extern: TXLSExternSheet read FExtern;
    //property CodePage: word read FCodePage write FCodePage;
    property  _FirstSheet: SmallInt read FFirstSheet;
    property _SST: TXLSStringTable read FSST;
    property _VBAObjectName: WideString read FVBAObjectName write FVBAObjectName;
    property ColorManager: TXLSColorManager read FColorManager;
    property XLSXVBAProject: TXLSBlob read FXLSXVBAProject write FXLSXVBAProject;
    procedure ClearVBA;
    function  Open(Stream: TStream): integer; overload;
    function  Open(FileName: WideString): integer; overload;
    function  Open(Stream: TStream; APassword: WideString): integer;overload;
    function  Open(FileName: WideString; APassword: WideString): integer;overload;
    procedure _Clear; 
    property VBAProject: TXLSVBAProject read GetVBAProject;
    property VBA: TXLSFileStorage read FVBA write FVBA;
    property Ctls: TXLSFileStream read FCtls write FCtls;
    function  GetDisableGraphics:boolean;
    procedure SetDisableGraphics(Value: boolean);
    property _DisableGraphics: boolean read GetDisableGraphics write SetDisableGraphics;
    function  VBADefined: boolean;
    function  GetNewSheetID: integer;
     
    property  _Protect: TXLSProtect read FProtect;
  end;


function GetCellRef(cellref: String; Var row: integer; Var col: integer): integer;
function GetCellRange(Value: String; Var r1, c1, r2, c2: integer): integer;
function EncodeCellRef(row, col: integer):string;
function EncodeCellRange(r1, c1, r2, c2: integer):string;
function ColIndexToColName(Index: integer): string;
function ColNameToColIndex(Name: string): integer;
function RowDiapasonToValues(Diapason: string; Var FromIndex, ToIndex:integer): boolean;
function ValuesToRowDiapason(FromIndex, ToIndex:integer; Var Diapason: string): boolean;
function ColDiapasonToValues(Diapason: string; Var FromIndex, ToIndex:integer): boolean;
function ValuesToColDiapason(FromIndex, ToIndex:integer; Var Diapason: string): boolean;

function GetColorIndex(ColorName: string): Word;
function  Str2Xls(Value: widestring): widestring;

function DirExists(const Name: string): Boolean;
function FloattoHTML(Value: Double): string;
{$EXTERNALSYM GetFileAttributes}
function GetFileAttributes(lpFileName: PChar): DWORD; stdcall;
function GetFileAttributes; external kernel32 name 'GetFileAttributesA';
function ModifyRangeBIFF8(var r1, c1, r2, c2: integer): boolean;

//{$EXTERNALSYM GetSysColor}
//function GetSysColor(nIndex: Integer): DWORD; stdcall;
//function GetSysColor; external user32 name 'GetSysColor';

implementation

uses xlsread, xlsstrm, 
    xlshtml, wstream, xlsrtf, xlsafit, xlscsv, xlsxwrite,
    {$IFDEF D2012}Winapi.Windows{$ELSE}Windows{$ENDIF}
    ;



function DirExists(const Name: string): Boolean;
var
  Code: Integer;
begin
  Code := GetFileAttributes(PChar(Name));
  Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;

function Excel2DateTime(Value: double): Variant;
begin

  if (Value >= 0) and (Value < 60) then begin
     {02.29.1900 bug}
     Value := Value + 1; 
  end;

  Result := VarFromDateTime(Value); 
end;

function DateTime2Excel(Value: double): double;
begin

  if (Value >= 1) and (Value < 61) then begin
     {02.29.1900 bug}
     Value := Value - 1;
  end;

  Result := Value; 
end;

procedure swap(Var val1, val2:integer);
var tmp: integer;
begin  
  tmp := val1; val1 := val2; val2 := tmp; 
end; 

function ModifyRangeBIFF8(var r1, c1, r2, c2: integer): boolean;
begin
  Result := true;
  if r1 > r2 then swap(r1, r2);
  if c1 > c2 then swap(c1, c2);
  if r1 > XLSMaxRow then Result := false;
  if r2 > XLSMaxRow then r2 := XLSMaxRow;
  if c1 > XLSMaxCol then Result := false;
  if c2 > XLSMaxCol then c2 := XLSMaxCol;
end;


function GetColorIndex(ColorName: string): Word;
begin
  ColorName := Trim(LowerCase(ColorName));
  if ColorName = 'aqua'    then Result := 15 else
  if ColorName = 'cyan'    then Result := 15 else
  if ColorName = 'black'   then Result := 8  else
  if ColorName = 'blue'    then Result := 12 else
  if ColorName = 'brown'   then Result := 16 else
  if ColorName = 'magenta' then Result := 14 else
  if ColorName = 'fuchsia' then Result := 14 else
  if ColorName = 'gray'    then Result := 23 else
  if ColorName = 'grey'    then Result := 23 else
  if ColorName = 'green'   then Result := 17 else
  if ColorName = 'lime'    then Result := 11 else
  if ColorName = 'navy'    then Result := 18 else
  if ColorName = 'orange'  then Result := 53 else
  if ColorName = 'purple'  then Result := 20 else
  if ColorName = 'red'     then Result := 10 else
  if ColorName = 'silver'  then Result := 22 else
  if ColorName = 'white'   then Result := 9  else
  if ColorName = 'yellow'  then Result := 13 else
  Result := 32767;
end;



//cellref 'A1' cell address
//row, col -  zero-based indexes
function GetCellRef(cellref: String; Var row: integer; Var col: integer): integer;
Var i, cnt: integer;
    lrow, lcol: integer;
    ch: char; 
begin
  Result := 1;
  lCol   := 0;
  lRow   := 0;
  cnt    := Length(cellref);
  i := 1;
  //Check length of cellref
  if cnt < 2 then Result := -1;

  //column index
  if Result = 1 then begin
     //skip $ 
     if cellref[i] = '$' then Inc(i);

     while i <= cnt do begin
        ch := cellref[i];
        if (ch >= 'A') and (ch <= 'Z') then begin
           lcol := lcol * 26 + Ord(ch) - Ord('A') + 1;
        end else if (ch >= 'a') and (ch <= 'z') then begin
           lcol := lcol * 26 + Ord(ch) - Ord('a') + 1;
        end else begin
           break;
        end;
        Inc(i);
     end;
     if lcol <= 0 then Result := -2 else Dec(lcol);
  end;

  if Result = 1 then begin
     //skip $ 
     if cellref[i] = '$' then Inc(i);
     if i > cnt then Result := -3;
  end;

  //row index
  if Result = 1 then begin
     while i <= cnt do begin
        ch := cellref[i];
        if (ch >= '0') and (ch <= '9') then begin
           lrow := lrow * 10 + Ord(ch) - Ord('0');
        end else begin
           Result := -4;
           break;
        end;
        Inc(i);
     end;
     Dec(lrow);
  end;

  if Result = 1 then begin
     //Check row number
     if (lrow < 0) or (lrow > XLSXMaxRow) then Result := -5;
     if (lcol < 0) or (lcol > XLSXMaxCol) then Result := -6;
  end;

  if Result = 1 then begin
     //return the row and col numbers
     Row := lrow;
     Col := lcol;
  end;

end;

//value 'A1:A1' range
//r1, c1, r2, c2 -  zero-based indexes
function GetCellRange(Value: String; Var r1, c1, r2, c2: integer): integer;
Var cell1, cell2: String;
    i: integer;
begin
  i := Pos(':', Value);
  if i > 0 then begin
     Cell1 := Copy(Value, 1, i - 1);
     Cell2 := Copy(Value, i + 1, Length(Value) - i);
     Result := GetCellRef(Cell1, r1, c1);
     if Result = 1 then Result := GetCellRef(Cell2, r2, c2);
  end else begin
     Result := GetCellRef(Value, r1, c1);
     if Result = 1 then begin
        r2 := r1;
        c2 := c1;
     end;
  end;
end;

//row, col - zero based indexes of row and column
function EncodeCellRef(row, col: integer): string;
begin
  Result := ColIndexToColName(col + 1);
  Result := Result + inttostr(row + 1);
end;


//r1, c1, r2, c2: zero-based row/col indexes
function EncodeCellRange(r1, c1, r2, c2: integer):string;
var t: integer;
begin
  if (r1 < 0) or (r2 < 0) or (c1 < 0) or (c2 < 0) or
     (r1 > XLSXMaxRow) or (r2 > XLSXMaxRow) or 
     (c1 > XLSXMaxCol) or (c2 > XLSXMaxCol) then begin
     Result := '';
  end else begin
     if r2 < r1 then begin
        t := r2; r2 := r1; r1 := t;
     end; 
     if c2 < c1 then begin
        t := c2; c2 := c1; c1 := t;
     end; 
     if (r1 = r2) and (c1 = c2) then begin
        Result := EncodeCellRef(r1, c1);
     end else begin
        Result := EncodeCellRef(r1, c1) + ':' +
                  EncodeCellRef(r2, c2);
     end;
  end;
end;


//Index - one-based index of column
//Result A-style column index
function ColIndexToColName(Index: integer): string;
begin
  Dec(Index);
  if (Index >= 0) and (Index <= (XLSXMaxCol)) then begin
     Result := '' + chr((Index mod 26) + ord('A'));
     while Index > 25 do begin
        Index := (Index div 26) - 1;
        Result :=  chr((Index mod 26) + ord('A')) + Result;
     end;
  end else begin
     Result := '';
  end;
end;


//name - A-style column index
//result - one-based column index
function ColNameToColIndex(Name: string): integer;
Var i, cnt: integer;
    lcol: integer;
    ch: char; 
begin
  lCol   := 0;
  cnt    := Length(Name);
  i := 1;

  //column index
  if cnt >= 1 then begin
     //skip $ 
     if Name[i] = '$' then Inc(i);
     while i <= cnt do begin
        ch := Name[i];
        if (ch >= 'A') and (ch <= 'Z') then begin
           lcol := lcol * 26 + Ord(ch) - Ord('A') + 1;
        end else if (ch >= 'a') and (ch <= 'z') then begin
           lcol := lcol * 26 + Ord(ch) - Ord('a') + 1;
        end else begin
           lcol := -1;
           break; 
        end;
        Inc(i);
     end;
  end;

  if (lcol > 0) and (lcol <= (XLSXMaxCol + 1)) then begin
     Result := lcol;
  end else begin
     Result := -1;
  end;

end;


{
Procedure DumpData(D: TXLSBlob; FileName: string);
Var i, cnt: LongWord;
    c: Byte;
    cc: Byte;
    F: TextFile;
begin
   AssignFile(F, FileName);
   Rewrite(F);
   cnt := D.GetBuffSize;
   c := 0;
   cc:= 0;
   for i:= 0 to cnt - 1 do begin
      write(F, inttohex(D.GetByte(i), 2), ' ');
      if c = 3 then begin
         write(F, ' ');
         c := 0;
         if (cc = 3) and (i < (cnt - 1))then begin
            w riteln(F);
            write (F, '               ');
            cc := 0;
         end
         else Inc(cc);
      end
      else Inc(c);
   end;
   Close(F);
end;
}

function Str2Xls(Value: widestring): widestring;
  const r1: widestring = #$000D#$000A;
  const r2: widestring = #$000A;
  const d1: widestring = #$000D;

begin
  Result := StringReplaceW(Value, r1, d1);
  Result := StringReplaceW(Result, r2, d1);
end;

function DoubleToRK(SrcValue: double; var DstValue: Longword): boolean;
var testvalue: double;
    testvalue2: double;
    v2: longword;
    intval: integer;
    intval_compact: integer;
begin
   Result := false;

   if abs(SrcValue) >= $80000000 then begin
      //integer overflow
      exit; 
   end;

   try
     intval := Trunc(SrcValue);
   except
     on E:Exception do begin
        intval := 0;  
     end; 
   end;

   if intval >= 0 then  
      intval_compact := (intval and $1FFFFFFF)
   else
      intval_compact := integer(longword(intval) or $E0000000);

   if (intval = SrcValue) and (intval_compact = intval) then begin
      //integer 
      DstValue := intval_compact shl 2;
      DstValue := DstValue or $00000002;
      Result := true;
   end;

   if not(Result) then begin
         try
           intval := Round(SrcValue * 100);
         except
           on E:Exception do begin
              intval := 0;  
           end; 
         end;

         testvalue2 := intval/100;  

         if intval >= 0 then  
            intval_compact := (intval and $1FFFFFFF)
         else
            intval_compact := integer(longword(intval) or $E0000000);

         if (testvalue2 = SrcValue) and (intval_compact = intval) then begin
            //integer mul 100
            DstValue := intval_compact shl 2;
            DstValue := DstValue or $00000003;
            Result := true;
         end;
   end;
      
   if not(Result) then begin
      testvalue := SrcValue;
      v2 := PLongWord(PAnsiChar(@testvalue) + 4)^;
      v2 := v2 and $FFFFFFFC;
      PLongWord(PAnsiChar(@testvalue))^ := 0;
      PLongWord(PAnsiChar(@testvalue) + 4)^ := v2;
      if testvalue = SrcValue then begin
         //compact float 
         DstValue := v2;
         Result := true;
      end;
   end;

   if not(Result) then begin
      testvalue := SrcValue * 100;
      v2 := PLongWord(PAnsiChar(@testvalue) + 4)^;
      v2 := v2 and $FFFFFFFC;
      PLongWord(PAnsiChar(@testvalue))^ := 0;
      PLongWord(PAnsiChar(@testvalue) + 4)^ := v2;
      if testvalue = SrcValue * 100 then begin
         //compact float mul 100
         DstValue := v2 or $00000001;
         Result := true;
      end;
   end;

end;


function DoubleIsRk(Value: double): boolean;
var v: Longword;
begin
  Result := DoubleToRK(Value, v);
end;

function RowDiapasonToValues(Diapason: string; Var FromIndex, ToIndex:integer): boolean;
Var Value1, Value2: string;
    iPos: integer;
    iFromIndex, iToIndex: integer;
begin
   iPos := Pos(':', Diapason);
   if iPos > 0 then begin
      Value1 := Trim(Copy(Diapason, 1, iPos - 1));
      Value2 := Trim(Copy(Diapason, iPos + 1, Length(Diapason) - iPos));
      if Value1[1] = '$' then Value1 := trim(Copy(Value1, 2, Length(Value1) - 1));
      if Value2[1] = '$' then Value2 := trim(Copy(Value2, 2, Length(Value2) - 1));
      iFromIndex := StrToIntDef(Value1, -1);
      iToIndex := StrToIntDef(Value2, -1);
      if (iFromIndex = -1) or (iToIndex = -1) or
         (iFromIndex > XLSXMaxRow) or (iToIndex > XLSXMaxRow)  then
         Result := false
      else begin
         if iFromIndex > iToIndex then begin
            FromIndex := iToIndex;
            ToIndex := iFromIndex;
         end else begin
            FromIndex := iFromIndex;
            ToIndex := iToIndex;
         end;
         Result := true
      end;
   end else Result := false;
end;

function ValuesToRowDiapason(FromIndex, ToIndex:integer; Var Diapason: string): boolean;
begin
  if (FromIndex > 0) and (ToIndex > 0) then
      Diapason := '$' + inttostr(FromIndex) + ':$' + inttostr(ToIndex)
  else
      Diapason := '';
  Result := true;
end;

function ColDiapasonToValues(Diapason: string; Var FromIndex, ToIndex:integer): boolean;
Var Value1, Value2: string;
    iPos: integer;
    iFromIndex, iToIndex: integer;
begin
   iPos := Pos(':', Diapason);
   if iPos > 0 then begin
      Value1 := Trim(Copy(Diapason, 1, iPos - 1));
      Value2 := Trim(Copy(Diapason, iPos + 1, Length(Diapason) - iPos));
      if Value1[1] = '$' then Value1 := trim(Copy(Value1, 2, Length(Value1) - 1));
      if Value2[1] = '$' then Value2 := trim(Copy(Value2, 2, Length(Value2) - 1));
      iFromIndex := ColNameToColIndex(Value1);
      iToIndex := ColNameToColIndex(Value2);
      if (iFromIndex = -1) or (iToIndex = -1) or
         (iFromIndex > XLSXMaxRow) or (iToIndex > XLSXMaxRow)  then
         Result := false
      else begin
         if iFromIndex > iToIndex then begin
            FromIndex := iToIndex;
            ToIndex := iFromIndex;
         end else begin
            FromIndex := iFromIndex;
            ToIndex := iToIndex;
         end;
         Result := true
      end;
   end else Result := false;
end;

function ValuesToColDiapason(FromIndex, ToIndex:integer; Var Diapason: string): boolean;
begin
  if (FromIndex > 0) and (ToIndex > 0) then
      Diapason := '$' + ColIndexToColName(FromIndex) + ':$' + ColIndexToColName(ToIndex)
  else
      Diapason := '';
  Result := true;
end;

function FloattoHTML(Value: Double): string;
begin
  Result := FormatFloat('#.#', Value);
  Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
end;

{TXLSCellRef}
 constructor TXLSCellRef.Create(Row: integer; Col: integer);
 var lKey: Longint;
 begin
   lKey := Row;
   lKey := (lKey shl 14) or Col;
   inherited Create(lKey);
   FCol := Col;
   FRow := Row;
   FCompiledFormula := nil;
 end;

 destructor TXLSCellRef.Destroy;
 begin
   FCompiledFormula.Free;
   inherited Destroy;
 end;
 
 procedure TXLSRange.ClearCell(SrcRow, SrcCol: integer; SrcWorksheet: IXLSWorkSheet;
                     PasteMode: LongWord; KeepDefaultFormat: integer);
 Var SrcCell: TXLSCellRef;
     //ReplaceXFIndex: boolean;
     //SrcXFIndex: integer;
     rxf, cxf: integer;
 begin

   if (SrcRow < 0) or (SrcCol < 0) or 
      (SrcRow > XLSXMaxRow) or (SrcCol > XLSXMaxCol) then begin
      exit;
   end;

   SrcCell := SrcWorksheet.FCells.GetValue(SrcRow, SrcCol);
   if Assigned(SrcCell) then begin
      if PasteMode = xlPasteAll then begin
         SrcWorksheet.FCells.DeleteValue(SrcRow, SrcCol);
      end else begin
      //formats
      if ((Pastemode and xlPasteFormats) = xlPasteFormats) then begin 
         SrcWorkSheet.FWorkBook.FXFList.ReplaceIndex(SrcCell.FXFIndex, 0);
         SrcCell.FXFIndex := 0;
         //unmerge if merged
         if SrcCell.FMerged and (SrcCell.FMergeCell = SrcCell) then
            SrcWorksheet.Cells[SrcRow + 1, SrcCol + 1].Unmerge;
      end;
      //numformats
      if ((Pastemode and xlPasteNumberFormats) = xlPasteNumberFormats) and
         not((Pastemode and xlPasteFormats) = xlPasteFormats) then begin
         if SrcWorkSheet.Cells[SrcRow + 1, SrcCol + 1].NumberFormat <> 'General' then
            SrcWorkSheet.Cells[SrcRow + 1, SrcCol + 1].NumberFormat := 'General';   
      end; 
      //values
      if ((Pastemode and xlPasteValues) = xlPasteValues) then begin 
         SrcCell.Value[SrcWorksheet] := null;
      end;
      end; 
      //comments
      if ((Pastemode and xlPasteComments) = xlPasteComments) then begin 
         SrcWorksheet.Cells[SrcRow + 1, SrcCol + 1].ClearComments;
      end;
   end else begin
      if ((Pastemode and xlPasteFormats) = xlPasteFormats) then begin 
         cxf := SrcWorkSheet.GetColumnXFIndex(SrcCol);
         rxf := SrcWorkSheet.GetRowXFIndex(SrcRow);
         if KeepDefaultFormat = 2 then begin
            if (rxf <> 0) and (rxf <> cxf)  then begin
               SrcCell := SrcWorksheet.FCells.GetOrCreateValue(SrcRow, SrcCol);
               if Assigned(SrcCell) then SrcCell.FXFIndex := 0;
            end;
          end else if KeepDefaultFormat = 1 then begin
            if (rxf = 0) and (rxf <> cxf) then begin
               SrcCell := SrcWorksheet.FCells.GetOrCreateValue(SrcRow, SrcCol);
               if Assigned(SrcCell) then SrcCell.FXFIndex := 0;
            end;
          end else begin
             if ((rxf > 0) and (rxf <> 15)) or 
                ((rxf = 0) and ((cxf > 0) and (cxf <> 15))) then begin
               SrcCell := SrcWorksheet.FCells.GetOrCreateValue(SrcRow, SrcCol);
               if Assigned(SrcCell) then SrcCell.FXFIndex := 0;
             end;
          end;
      end;
   end;
 end;

 procedure TXLSRange.CopyCell(SrcRow, SrcCol: integer; SrcWorksheet: IXLSWorkSheet;
                              DstRow, DstCol: integer; DstWorksheet: IXLSWorkSheet;
                              PasteMode: LongWord; ChangeFormula: boolean);
 Var ReplaceXFIndex: boolean;
     SrcXFIndex, DstXFIndex: integer;
     SrcCell, DstCell: TXLSCellRef;
     rc, cc: integer;
     rng: TXLSRange; 
     delcell: boolean;
 begin
   if (SrcRow < 0) or (SrcCol < 0) or 
      (SrcRow > XLSXMaxRow) or (SrcCol > XLSXMaxCol) then begin
      ClearCell(DstRow, DstCol, DstWorksheet, PasteMode, 0);
      exit;
   end;

   if (SrcRow = DstRow) and (SrcCol = DstCol) and (SrcWorksheet = DstWorksheet) then begin
      exit;
   end;

   //w riteln('copycell ',srcrow,',', srccol, '->', dstrow, ',',dstcol);

   SrcCell := SrcWorksheet.FCells.GetValue(SrcRow, SrcCol);
   DstCell := DstWorksheet.FCells.GetValue(DstRow, DstCol);
   ReplaceXFIndex := false;
 
   //numformats
   if ((Pastemode and xlPasteNumberFormats) = xlPasteNumberFormats) and
      not((Pastemode and xlPasteFormats) = xlPasteFormats) then begin
      if SrcWorkSheet.Cells[SrcRow + 1, SrcCol + 1].NumberFormat <>
         DstWorkSheet.Cells[DstRow + 1, DstCol + 1].NumberFormat then begin
           DstWorkSheet.Cells[DstRow + 1, DstCol + 1].NumberFormat :=
           SrcWorkSheet.Cells[SrcRow + 1, SrcCol + 1].NumberFormat;
      end;
   end; 
   //Values
   if ((Pastemode and xlPasteValues) = xlPasteValues) then begin 
      if Assigned(SrcCell) then begin
         //copy src values to dst
         if not(Assigned(DstCell)) then
            DstCell := DstWorksheet.FCells.GetOrCreateValue(DstRow, DstCol);
         if Assigned(DstCell) then begin

            if DstCell.FValueType = xlFormula then begin
               DstCell.FCompiledFormula.Free;
               DstCell.FCompiledFormula := nil; 
            end;

            if DstWorkSheet.FWorkbook = SrcWorkSheet.FWorkbook then begin
               DstWorkSheet.FWorkbook.FSST.ReplaceIndex(DstCell.FStringIndex, SrcCell.FStringIndex);
               DstCell.FStringIndex := SrcCell.FStringIndex;
               DstCell.FDoubleValue := SrcCell.FDoubleValue;
               if SrcCell.FValueType = xlFormula then begin
                  if ChangeFormula then begin
                     DstCell.FCompiledFormula := SrcCell.FCompiledFormula.GetCopy(DstRow - SrcRow, DstCol - SrcCol)
                  end else begin
                     DstCell.FCompiledFormula := SrcCell.FCompiledFormula.GetCopy(0, 0);
                  end;
               end; 
               DstCell.FValueType := SrcCell.FValueType;
            end else begin
               DstCell.Value[DstWorkSheet] := SrcCell.Value[SrcWorkSheet];
            end;
         end;  

      end else if Assigned(DstCell) then begin
         //clear dst cell 
         delcell := false;
         if DstCell.FMerged then delcell := true;
         if not(delcell) then begin
            if Pastemode = xlPasteAll then begin
                SrcXFIndex := SrcWorkSheet.GetXFIndex(SrcRow, SrcCol, ReplaceXFIndex);
                DstXFIndex := DstWorkSheet.GetXFIndex(DstRow, DstCol, ReplaceXFIndex);
                if SrcXFIndex = DstXFIndex then begin
                   delcell := true;
                end;
            end;
         end;
         if delcell then begin
            DstCell.Value[DstWorkSheet] := null;
            DstWorksheet.FCells.DeleteValue(DstRow, DstCol);
            DstCell := nil;
            //w riteln('  delete dst cell');
         end else begin
            DstCell.Value[DstWorkSheet] := null;
            //w riteln('  set dst null value');
         end;
      end;
   end;

   //Formats
   if ((Pastemode and xlPasteFormats) = xlPasteFormats) then begin 
      //Unmerge dstcell if needed
      if Assigned(DstCell) then begin
         if DstCell.FMerged and (DstCell = DstCell.FMergeCell) then begin
            DstWorksheet.Cells[DstRow + 1, DstCol + 1].Unmerge;
         end; 
      end;
      //Merge dstcell if needed
      if Assigned(SrcCell) then begin
         if SrcCell.Merged and (SrcCell = SrcCell.FMergeCell) then begin
            rc := SrcCell.FMergeRowCount;
            cc := SrcCell.FMergeColCount;

            if Assigned(DstCell) then begin
               if DstCell.FMerged then begin             
                  DstWorksheet.RCRange[DstRow + 1, 
                                       DstCol + 1, 
                                       DstRow + 1, 
                                       DstCol + 1].Unmerge;
               end;
            end;

            rng := DstWorksheet._FGetRowColRange2(DstRow + 1, DstCol + 1, DstRow + rc, DstCol + cc);
            rng.UnMergeOutgoingRanges(DstRow, DstCol, DstRow + rc - 1, DstCol + cc - 1);
            rng.Merge;
            rng.Free;

         end;
      end;

      if DstWorkSheet.FWorkBook = SrcWorkSheet.FWorkBook then begin
         //get XF Indexes
         SrcXFIndex := SrcWorkSheet.GetXFIndex(SrcRow, SrcCol, ReplaceXFIndex);
         DstXFIndex := DstWorkSheet.GetXFIndex(DstRow, DstCol, ReplaceXFIndex);
         //copy format
         if SrcXFIndex <> DstXFIndex then begin
            if not(Assigned(DstCell)) then begin
               //w riteln('create ', dstrow, ',',dstcol);
               DstCell := DstWorksheet.FCells.GetOrCreateValue(DstRow, DstCol);
            end;

            if Assigned(DstCell) then begin
               if ReplaceXFIndex then 
                  DstWorkSheet.FWorkBook.FXFList.ReplaceIndex(DstXFIndex, SrcXFIndex)
               else
                  DstWorkSheet.FWorkBook.FXFList.ReplaceIndex(0, SrcXFIndex);
               DstCell.FXFIndex := SrcXFIndex;
            end; 
         end;
      end else begin
         if not(Assigned(DstCell)) then begin
            DstCell := DstWorksheet.FCells.GetOrCreateValue(DstRow, DstCol);
         end;
         if Assigned(DstCell) then begin
            SrcXFIndex := SrcWorkSheet.GetXFIndex(SrcRow, SrcCol, ReplaceXFIndex);
            DstCell.FXFIndex := DstWorkSheet.FWorkBook.FXFList.SetFullFormat(SrcWorkSheet.FWorkBook.FXFList.GetFullFormat(SrcXFIndex)); 
         end; 
      end;

   end;

   //Comments
   if ((Pastemode and xlPasteComments) = xlPasteComments) then begin 
      if Assigned(SrcCell) then begin
         if Assigned(SrcWorkSheet.Cells[SrcRow + 1, SrcCol + 1].Comment) then begin
            With DstWorkSheet.Cells[DstRow + 1, DstCol + 1].AddComment do begin
              Text := SrcWorkSheet.Cells[SrcRow + 1, SrcCol + 1].Comment.Text;
            end; 
         end else 
            DstWorkSheet.Cells[DstRow + 1, DstCol + 1].ClearComments;  
      end else if Assigned(DstCell) then begin
         //clear dst cell 
         DstWorkSheet.Cells[DstRow + 1, DstCol + 1].ClearComments;
      end;
   end;
 end;

 procedure TXLSCellRef.SetValue(Ws: IXLSWorksheet; const Value: variant);
 Var vt: TVarType;
     lStr: WideString;
     lLen: integer;
 begin
  if not(Merged) or (FMergeCell = self) then
   begin
     if FValueType = xlString then begin
        Ws.FWorkbook.FSST.Remove(FStringIndex);
        FValueType := xlEmpty;
        FStringIndex := -1;
     end else if FValueType = xlFormula then begin
        FValueType := xlEmpty;
        FCompiledFormula.Free;
        FCompiledFormula := nil;
     end;

     vt := VarType(Value);
     case vt of
        varEmpty,
        varNull:  begin
                    FValueType := xlEmpty;
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
        varCurrency :  begin
                         FValueType := xlDoubleNumber;
                         FDoubleValue := Double(Value);
                       end;
        varBoolean :  begin
                         FValueType := xlBoolean;
                         FDoubleValue := Ord(Boolean(Value));
                       end;
        varDate:      begin
                         FValueType := xlDateTime;
                         FDoubleValue := DateTime2Excel(Double(Value));
                       end;
        {$IFDEF D2009}
        varUString,
        {$ENDIF} 
        varOleStr,varString:  begin
                         lStr := widestring(Value);
                         lLen := Length(lStr);  
                         if lLen = 0 then begin
                           FValueType := xlEmpty;
                         end else if lStr[1] = '=' then begin
                           //Formula
                           FValueType := xlFormula;
                           FCompiledFormula := Ws.FWorkbook.GetCompiledFormula(Copy(lStr, 2, lLen - 1), Ws.FSheetID);
                           if not(Assigned(FCompiledFormula)) then begin
                              FValueType := xlString;
                              FStringIndex := Ws.FWorkbook.FSST.Add(lStr); 
                           end;
                         end else begin
                           FValueType := xlString;
                           if lStr[1] = '''' then lStr := Copy(lStr, 2, lLen - 1);
                           if Pos(WideChar(#10), lStr) > 0 then begin
                              Ws.Cells[FRow + 1, FCol + 1].WrapText := true;
                           end; 
                           FStringIndex := Ws.FWorkbook.FSST.Add(lStr); 
                         end;
                       end;
      end;
   end;
end;

function TXLSCellRef.GetCellValue(Ws: IXLSWorksheet; Var Value: variant): integer;
begin
  Result := 1;
  if Merged and (FMergeCell <> self) then
     Value := Null
  else
    case FValueType of
      xlString:
          Value := Ws.FWorkbook.FSST.Value[FStringIndex];
      xlDoubleNumber:
          Value := FDoubleValue;
      xlDateTime:
          Value := TDateTime(FDoubleValue);
      xlEmpty:
          Value := Null;
      xlBoolean:
          Value := Boolean(FDoubleValue > 0);
      xlFormula: 
          begin
             Result := Ws.FWorkbook.GetFormulaValue(Ws.Index, FCompiledFormula, FRow, FCol, Value);
          end; 
      else
          Result := -1;
    end;
end;

function TXLSCellRef.GetValue(Ws: IXLSWorksheet): variant;
Var Ret: integer;
begin
   Ret := GetCellValue(Ws, Result);
   if Ret <> 1 then Result := null;
end;

function TXLSCellRef.GetFormula(Ws: IXLSWorksheet): variant;
begin
  if Merged and (FMergeCell <> self) then begin
     Result := Null;
  end else if FValueType = xlFormula then begin
     Result := Ws.FWorkbook.GetUnCompiledFormula(FCompiledFormula, FRow, FCol, Ws.FSheetID);
     if Result = '' then Result := Null;
  end else begin
     GetCellValue(Ws, Result);
  end;
end;

function TXLSCellRef.GetHasFormula: boolean;
begin
  if Merged and (FMergeCell <> self) then begin
     Result := false;
  end else if FValueType = xlFormula then begin
     Result := true;
  end else begin
     Result := false;
  end;
end;

{ TXLSWorkbook }
constructor TXLSWorkbook.Create;
begin
  //FCheckRefCount := true;
  inherited Create();
  FCodePage := 1252;
  FXFIndex := 16;
  FFileClosed := true;
  FSheetName := 'Sheet';
  FReferenceStyle := xlA1;

  FWorksheets := IXLSWorksheets.Create(self);
  FColorManager := TXLSColorManager.Create;
  FXFList := TXLSStyleXFs.Create(FColorManager);
  FXFList.CreateDefault;
  FProtect := TXLSProtect.Create;

  FSST := TXLSStringTable.Create;
  //set colour palette
  SetPaletteXL97;
  FDefaultFileFormat := xlExcel97;
  FNames := TXLSCustomNames.Create(nil, 0, self);
  FExtern := TXLSExternSheet.Create(GetSheetIDByName, GetSheetIndexByID, GetSheetNameByIndex, 
                 FNames.GetNameByID, FNames.GetStoreIndexByID, FNames.GetNameIDByName,
                 FNames.GetSheetIDByNameID,
                 GetExcel5BookExternID,
                 FNames.GetCalcRange);
  FVBA := nil;
            FCtls := nil;
  
  FDrawingGroup := TMSODrawingGroup.Create;

  FChangeID := 1;
end;

destructor TXLSWorkbook.Destroy;
begin
  Close;
  FXFList.Free;
  FProtect.Free;
  FSST.Free;
  FSST := nil;
  FWorksheets.Free;
  FFormula.Free;
  FNames.Free; 
  FExtern.Free;
  FVBA.Free;
  FCtls.Free;
  FVBAProject.Free;
  FXLSXVBAProject.Free;
  
  FDrawingGroup.Free;
  FColorManager.Free;
  inherited Destroy;
end;
function  TXLSWorkbook.Open(Stream: TStream): integer;
begin
  Result := Open(Stream, '');
end;

function  TXLSWorkbook.Open(Stream: TStream; APassword: WideString): integer;
begin
  Result := OpenExcelStream(self, Stream, APassword, FFileFormat);
  if Result = 1 then begin
     FFileName := '';
     FOriginalFileFormat := FFileFormat;
     FChangeId := 1;
  end;
end;

function  TXLSWorkbook.Open(FileName: WideString): integer;
begin
  Result := Open(FileName, '');
end;


function  TXLSWorkbook.Open(FileName: WideString; APassword: WideString): integer;
begin
  Result := OpenExcelFile(self, FileName, APassword, FFileFormat);
  if Result = 1 then begin
     FFileName := FileName;
     FOriginalFileFormat := FFileFormat;
     FChangeId := 1;
  end;
end;


function  TXLSWorkbook.VBADefined: boolean;
begin
  Result := Assigned(FVBA);
end;


procedure TXLSWorkbook.ClearVBA;
begin
  FVBA.Free;
  FCtls.Free;
  FXLSXVBAProject.Free;
  FVBAProject.Free;

  FVBA := nil;
  FCtls := nil;
  FXLSXVBAProject := nil;
  FVBAProject := nil;
end;

function  TXLSWorkbook.GetNewSheetID: integer;
begin
  Result := Sheets.GetNewSheetID;
end;



function TXLSWorkbook.GetDisableGraphics:boolean;
begin
  Result := FDisableGraphics;
end;

procedure TXLSWorkbook.SetDisableGraphics(Value: boolean);
begin
  FDisableGraphics := Value;
end;

procedure TXLSWorkbook._Clear;
begin
  FFormula.Free;
  FFormula := nil;
  FProtect.Free;
  FProtect := TXLSProtect.Create; 
  FXFList._Clear;
  FExtern.Free;
  FNames.Free;
  FNames := TXLSCustomNames.Create(nil, 0, self);
  FExtern := TXLSExternSheet.Create(GetSheetIDByName, GetSheetIndexByID, GetSheetNameByIndex, 
                 FNames.GetNameByID, 
                 FNames.GetStoreIndexByID,
                 FNames.GetNameIDByName,
                 FNames.GetSheetIDByNameID,
                 GetExcel5BookExternID, FNames.GetCalcRange);
  FSST.Free;
  FSST := TXLSStringTable.Create;
  FWorksheets.Free;
  FWorksheets := IXLSWorksheets.Create(self);
  FDrawingGroup.Clear; 
  FVBA.Free;
  FVBA := nil;
  FCtls.Free;
  FCtls := nil;
  FReferenceStyle := 1;
  ResetColors;
  FVBAProject.Free;
  FVBAProject := nil;
  FXLSXVBAProject.Free;
  FXLSXVBAProject := nil;
end;


function TXLSWorkbook.GetCellValue(SheetIndex, row, col: integer; Var Value: Variant; Var OutOfUsedRange: boolean): integer;
Var lSheet: IXLSWorkSheet;
    Cell:   TXLSCellRef;
begin
  Result := 1;
  OutOfUsedRange := false;

  if (SheetIndex > 0) and 
     (SheetIndex <= FWorksheets.Count) and
     (row >= 0) and (row <= XLSXMaxRow) and
     (col >= 0) and (col <= XLSXMaxCol)
  then begin
     lSheet := FWorksheets.FWorkSheets[SheetIndex - 1];
     OutOfUsedRange := (row > lSheet.FCells.FMaxRow) or (col > lSheet.FCells.FMaxCol);
     Cell := lSheet.FCells.GetValue(Row, Col);
     if Assigned(Cell) then 
        Result := Cell.GetCellValue(lSheet, Value)
     else Value := Null;
  end else Result := -1;
end;

procedure TXLSWorkbook.IncChangeID;
begin
  if FChangeID = $FFFFFFFF then FChangeID := 1
  else Inc(FChangeID);
end;


function TXLSWorkbook.SetTempDir(const ATempDir: string): integer;
begin
  Result := -1;
end;

function TXLSWorkbook.AddContinue(Data: TXLSBlob): TXLSBlob;
Const iRecord =  $003C;
Var   NewSize :  LongWord;
      BlockSize: Word;
      Index:     LongWord;
      SrcSize:   LongWord;
      Cnt:       integer;
begin
  SrcSize := Data.GetDataSize;
  Cnt := (SrcSize - (FLimit + 4)) div FLimit; //number of full continue records
  NewSize := (Cnt + 1) * (FLimit + 4);
  if ((SrcSize - (FLimit + 4)) mod FLimit) > 0 then 
      NewSize := NewSize + 4 + ((SrcSize - (FLimit + 4)) mod FLimit); 

  Result := TXLSBlob.Create(NewSize);
  Result.CopyData(Data, 0, FLimit + 4);
  Result.SetWord(0, Data.GetWord(0));
  Result.SetWord(2, FLimit);

  Index := FLimit + 4;
  while Index < SrcSize do begin
     Result.AddWord(iRecord);
     if (SrcSize - Index) >= FLimit then BlockSize := FLimit
     else BlockSize := (SrcSize - Index);
     Result.AddWord(BlockSize);
     Result.CopyData(Data, Index, BlockSize);
     Index := Index + BlockSize;
  end;
  Data.Free;
end;

function TXLSWorkbook.Append(DList: TXLSBlobList; Data: TXLSBlob): integer;
begin
  if Data.GetBuffSize > (FLimit + 4) then begin
     Data := AddContinue(Data);
  end;
  FDataSize := FDataSize + Data.GetBuffSize;
  Result := DList.Append(Data);
end;

function TXLSWorkbook.GetAllBoundSheetSize: longword;
Var i: LongWord;
    BoundSheetSize: word;
begin
  Result := 0; 
  if FFileFormat = xlExcel5 then begin
     BoundSheetSize := 11;
     for i := 1 to FWorksheets.Count do
       Result := Result + 
                 BoundSheetSize + 
                 LongWord(Length(Worksheets[i].Name));
  end else begin
     BoundSheetSize := 12; 
     for i := 1 to FWorksheets.Count do
       Result := Result + 
                 BoundSheetSize + 
                 LongWord(Length(Worksheets[i].Name)) * 2;
  end;    
end;

function TXLSWorkbook.Close: integer;
begin
  Result := 1;
end;

function TXLSWorkbook.SetCodePage(ACodePage: Word): integer;
begin
  FCodePage := ACodePage;
  Result := 1;
end;

procedure TXLSWorkbook.SetCustomColor(Index: integer; lcid: integer; const Value: LongWord);
begin
  FColorManager.SetPaletteColor(Index, Value);
end;

procedure TXLSWorkbook.Protect;
begin
  FProtect.Protect('');
end;

procedure TXLSWorkbook.Protect(Password: string);
begin
  FProtect.Protect(Password);
end;

procedure TXLSWorkbook.UnProtect;
begin
  FProtect.UnProtect('', true);
end;

procedure TXLSWorkbook.UnProtect(Password: string);
begin
  FProtect.UnProtect(Password, true);
end;

procedure TXLSWorkbook.UnProtect(Password: string; lcid: integer);
begin
  FProtect.UnProtect(Password, true);
end;

function TXLSWorkbook.SaveAsHTML(FileName: widestring): integer;
Var Exporter: TXLSHTMLExport;
begin
  Exporter := TXLSHTMLExport.Create;
  try
    try
      Result := Exporter.SaveAsHTML(self, FileName);
    except
      on E:Exception do begin
         Result := -1;
      end; 
    end; 
  finally
    Exporter.Free;
  end;
end;


function TXLSWorkbook.SaveAsRTF(FileName: widestring): integer;
Var Exporter: TXLSRTFExport;
begin
  Exporter := TXLSRTFExport.Create;
  try
    Result := Exporter.SaveAsRTF(self, FileName);
  finally
    Exporter.Free;
  end;
end;


function TXLSWorkbook.SaveAsRTF(Stream: TStream): integer;
Var Exporter: TXLSRTFExport;
begin
  Exporter := TXLSRTFExport.Create;
  try
    Result := Exporter.SaveAsRTF(self, Stream);
  finally
    Exporter.Free;
  end;
end;

function TXLSWorkbook.Calculate(Formula: WideString): Variant;
Var CompiledFormula: TXLSCompiledFormula;
    Res: integer;
    lSheet: IXLSWorkSheet;
    lSheetIndex: integer;
begin
   CompiledFormula := GetCompiledFormula(Formula, 0);
   if Assigned(CompiledFormula) then begin
      lSheet := ActiveSheet;
      if Assigned(lSheet) then lSheetIndex := lSheet.Index else lSheetIndex := -1;
      Res := GetFormulaValue(lSheetIndex, CompiledFormula, 0, 0, Result);
      if Res <> 1 then Result := Null;
      CompiledFormula.Free; 
   end else Result := Null;
end;

function TXLSWorkbook.GetNames: IXLSNames;
begin
  Result := TXLSNames.Create(FNames);
end;


function TXLSWorkbook.SetPaletteXL97: integer;
begin
  FColorManager.SetPaletteXL97;
  Result := 1;
end;

procedure TXLSWorkbook.ResetColors;
begin
  SetPaletteXL97;
end;

function TXLSWorkbook.Store1904(DList: TXLSBlobList): integer;
Var lData: TXLSBlob;
begin
  lData := TXLSBlob.Create(6);
  lData.AddWord($0022);        //Record
  lData.AddWord($0002);        //Length
  lData.AddWord(ord(F1904));   //1904 flag
  Result := Append(DList, lData);
end;

function TXLSWorkbook.StorePrecision(DList: TXLSBlobList): integer;
Var lData: TXLSBlob;
begin
  lData := TXLSBlob.Create(6);
  lData.AddWord($000E);        //Record
  lData.AddWord($0002);        //Length
  lData.AddWord(1);            //Use real cell values
  Result := Append(DList, lData);
end;

function TXLSWorkbook.StoreRefMode(DList: TXLSBlobList): integer;
Var lData: TXLSBlob;
begin
  lData := TXLSBlob.Create(6);
  lData.AddWord($000F);        //Record
  lData.AddWord($0002);        //Length
  lData.AddWord(FReferenceStyle);   //Reference Style
  Result := Append(DList, lData);
end;


function TXLSWorkBook.StoreDSF(DList: TXLSBlobList): integer;
Var Data: TXLSBlob;
begin
  Data := TXLSBlob.Create(6);
  Data.AddWord($0161);        //Record identifier
  Data.AddWord($0002);        //Number of bytes to follow
  Data.AddWord($0000);        //
  Result := Append(DList, Data);
end;

function TXLSWorkBook.StoreBookBool(DList: TXLSBlobList): integer;
Var Data: TXLSBlob;
begin
  Data := TXLSBlob.Create(6);
  Data.AddWord($00DA);        //Record identifier
  Data.AddWord($0002);        //Number of bytes to follow
  Data.AddWord($0000);        //
  Result := Append(DList, Data);
end;

function TXLSWorkBook.StoreBackup(DList: TXLSBlobList): integer;
Var Data: TXLSBlob;
begin
  Data := TXLSBlob.Create(6);
  Data.AddWord($0040);        //Record identifier
  Data.AddWord($0002);        //Number of bytes to follow
  Data.AddWord($0000);        //
  Result := Append(DList, Data);
end;
function TXLSWorkBook.Store01BA(DList: TXLSBlobList): integer;
Var Data: TXLSBlob;
    Size: integer;
begin
  Result := 1;
  if Assigned(FVBA) and (FFileFormat = FOriginalFileFormat) and 
     (FVBAObjectName <> '') then begin
     Size := Length(FVBAObjectName) * 2 + 3 + 4;
     Data := TXLSBlob.Create(Size);
     Data.AddWord($01BA);        //Record identifier
     Data.AddWord(Size - 4);      //Number of bytes to follow
     Data.AddWord(Length(FVBAObjectName));
     Data.AddByte($01);
     Data.AddWideString(FVBAObjectName);
     Result := Append(DList, Data);
  end;
end;


function TXLSWorkBook.StoreObjProj(DList: TXLSBlobList): integer;
Var Data: TXLSBlob;
begin
  Result := 1;
  if Assigned(FVBA) and (FFileFormat = FOriginalFileFormat) then begin
     Data := TXLSBlob.Create(4);
     Data.AddWord($00D3);        //Record identifier
     Data.AddWord($0000);        //Number of bytes to follow
     Result := Append(DList, Data);
  end;
end;


function TXLSWorkBook.GetVBAProject: TXLSVBAProject;
var  lvba: TXLSFileStorage;
     rstrm: TXLSReadStream;
     res: integer;
begin
  if Not(Assigned(FVBAProject)) then begin
     if Assigned(FXLSXVBAProject) then begin
        //xlsx vba project
        rstrm := TXLSReadStream.Create('');
        try
          res := rstrm.OpenStorageFromBlob(FXLSXVBAProject);   
          if res = 1 then begin
             lvba := TXLSFileStorage.Create('_VBA_PROJECT_');
             try  
               lvba.LoadFolder(rstrm.Storage); 
               FVBAProject := TXLSVBAProject.Create();
               FVBAProject.Init(lvba);
             finally
               lvba.Free;
               rstrm.CloseStorage;
             end;
           end;
        finally
          rstrm.Free;
        end;  
     end else begin 
        FVBAProject := TXLSVBAProject.Create();
        FVBAProject.Init(FVBA);
     end;
  end;
  Result := FVBAProject;
end;



function TXLSWorkBook.StoreFnGroupCount(DList: TXLSBlobList): integer;
Var Data: TXLSBlob;
begin
  Data := TXLSBlob.Create(6);
  Data.AddWord($009C);        //Record identifier
  Data.AddWord($0002);        //Number of bytes to follow
  Data.AddWord($000E);        //14
  Result := Append(DList, Data);
end;

function TXLSWorkBook.StoreCountry(DList: TXLSBlobList): integer;
Var Data: TXLSBlob;
begin
  Data := TXLSBlob.Create(8);
  Data.AddWord($008C);        //Record identifier
  Data.AddWord($0004);        //Number of bytes to follow
  Data.AddWord($0001);        //USA
  Data.AddWord($0001);        //USA
  Result := Append(DList, Data);
end;

function TXLSWorkBook.Store01C1(DList: TXLSBlobList): integer;
Var Data: TXLSBlob;
begin
  Data := TXLSBlob.Create(12);
  Data.AddWord($01C1);        //Record identifier
  Data.AddWord($0008);        //Number of bytes to follow
  Data.AddLong($000001C1);        //Unknown
  Data.AddLong($00FFFFFF);        //Unknown
  Result := Append(DList, Data);
end;

function TXLSWorkBook.StoreProtect(DList: TXLSBlobList): integer;
Var Data: TXLSBlob;
begin
  Result := 1;
  if FProtect.isProtected then begin
    Data := TXLSBlob.Create(6);
    Data.AddWord($0012);        //Record identifier
    Data.AddWord($0002);        //Number of bytes to follow
    Data.AddWord(1);            //fLock
    Result := Append(DList, Data);
  end;
end;


function TXLSWorkBook.GetIsProtected: boolean;
begin 
  Result := FProtect.IsProtected;
end;

function TXLSWorkBook.GetDate1904: boolean;
begin 
  Result := F1904;
end;

procedure TXLSWorkBook.SetDate1904(Value: boolean);
begin 
  F1904 := Value;
end;

function TXLSWorkBook.StorePassword(DList: TXLSBlobList): integer;
Var Data: TXLSBlob;
    wPassword: Word;
begin
  Result := 1;
  if FProtect.IsProtected then begin
    wPassword := FProtect.EncodedPassword;
    Data := TXLSBlob.Create(6);
    Data.AddWord($0013);        //Record identifier
    Data.AddWord($0002);        //Number of bytes to follow
    Data.AddWord(wPassword);
    Result := Append(DList, Data);
  end;
end;


function TXLSWorkbook.StoreAllFonts(DList: TXLSBlobList): integer;
Var 
    i: integer;
    cnt: Integer;
    lData: TXLSBlob;
begin
 Result := 1;
 cnt := FXFList.Fonts.ReferredListSize;
 for i := 1 to cnt do begin
     lData := FXFList.Fonts.GetFontData(i - 1, FFileFormat);
     Result := Append(DList, lData);
     if Result <> 1 then break;
 end;
end;

function TXLSWorkbook.StoreAllNumFormats(DList: TXLSBlobList): integer;
Var NumFormat: TXLSBlob;
    i: integer;
    cnt: Integer;
begin
 Result := 1;
 cnt := FXFList.Formats.ListSize;
 for i := 0 to cnt - 1 do begin
     NumFormat := FXFList.Formats.GetNumFormatBlob(i, FFileFormat);
     if Assigned(NumFormat) then begin
        Result := Append(DList, NumFormat);
        if Result <> 1 then break;
     end;
 end;
end;

function TXLSWorkbook.StoreAllStyles(DList: TXLSBlobList): integer;
Var Style: TXLSBlob;
    i: integer;
    cnt: Integer;
begin
 Result := 1;
 cnt := FXFList.Styles.Count;
 for i := 0 to cnt - 1 do begin
     Style := FXFList.Styles.GetStyleBlob(i, FFileFormat);
     if Assigned(Style) then begin
        Result := Append(DList, Style);
        if Result <> 1 then break;
     end;
 end;
end;

function TXLSWorkbook.StoreAllXFS(DList: TXLSBlobList): integer;
Var 
    i: integer;
    cnt: Integer;
begin
 Result := 1;
 cnt := FXFList.ReferredListSize;
 for i := 1 to cnt do begin
     Result := Append(DList, FXFList.GetXFBlob(i - 1, FFileFormat));
     if Result <> 1 then break;
 end;
end;

function TXLSWorkbook.StoreBof(DList: TXLSBlobList; BofType: SmallInt): integer;
Var lData: TXLSBlob;
    lSize: Word;
begin
  // Excel BOF record
  // BofType = 5  for workbook
  // BofType = 61 for  worksheet
  if FFileFormat = xlExcel5 then lSize := $0008 else lSize := $0010;
  lData := TXLSBlob.Create(lSize + 4);

  lData.AddWord($0809);        //Record
  lData.AddWord(lSize);        //Length
  lData.AddWord(FBiffVersion);
  lData.AddWord(BofType);

  if FFileFormat = xlExcel5 then begin
     // According to the SDK Build and Year should be set to zero.
     // However, this throws a warning in Excel 5. So, use these
     // magic numbers.
     lData.AddWord($096C);     //build
     lData.AddWord(1993);      //year
  end else begin
     // According to the SDK Build and Year should be set to zero.
     // However, this throws a warning in Excel 97. So, use these
     // magic numbers.
     lData.AddWord($18AF);     //build
     lData.AddWord(1997);      //year

     lData.AddLong($000080C9); //HistoryFlag
     lData.AddLong($00000106); //Lowest Excel version that can read all records in this file
  end;

  Result := Append(DList, lData);
end;

function TXLSWorkbook.StoreBoundSheet(DList: TXLSBlobList; SheetName: widestring;
  Offset: LongWord; Visible: byte; SheetType: byte): integer;
Var lData: TXLSBlob;
    cch: Byte;
begin
  cch := Length(SheetName);
  if FFileFormat = xlExcel5 then 
     lData := TXLSBlob.Create(7 + 4 + cch)
  else 
     lData := TXLSBlob.Create(7 + 4 + 1 + cch * 2);
  lData.AddWord($0085);        //Record
  lData.AddWord($0000);  //Length
  lData.AddLong(Offset);       //Offset
  lData.AddByte(Visible);     //Visibility
  lData.AddByte(SheetType);          //SheetType (Worksheet/Chart)
  lData.AddByte(cch);          //cch
  if FFileFormat = xlExcel5 then 
     {$ifdef D2009}
     lData.AddString(AnsiString(SheetName))     //Sheet name
     {$else}
     lData.AddString(SheetName)     //Sheet name
     {$endif} 
  else begin
     lData.AddByte(1);              //Uncompressed widestring
     lData.AddWideString(SheetName) //Sheet name
  end;
  lData.SetWord(lData.DataLength - 4, 2); 
  Result := Append(DList, lData);
end;

function TXLSWorkbook.StoreCodePage(DList: TXLSBlobList): integer;
Var lData: TXLSBlob;
begin
  lData := TXLSBlob.Create(6);
  lData.AddWord($0042);        //Record
  lData.AddWord($0002);        //Length
  //The CODEPAGE record in BIFF8 always contains the code page 1200 (UTF-16).
  //Therefore it is not possible
  //to obtain the encoding used for a protection password (it is not UTF-16)
  if FFileFormat = xlExcel5 then
     lData.AddWord(FCodePage)  //CodePage
  else 
     lData.AddWord(1200);      //UTF-16
  Result := Append(DList, lData);
end;

function TXLSWorkbook.StoreEof(DList: TXLSBlobList): integer;
Var lData: TXLSBlob;
begin
  lData := TXLSBlob.Create(4);
  lData.AddWord($000A);        //Record identifier
  lData.AddWord($0000);        //Length
  Result := Append(DList, lData);
end;

function TXLSWorkbook.StoreExternCount(DList: TXLSBlobList; Value: Word): integer;
Var lData: TXLSBlob;
begin
  lData := TXLSBlob.Create(6);
  lData.AddWord($0016);        //Record
  lData.AddWord($0002);        //Length
  lData.AddWord(Value);        //cxals
  Result := Append(DList, lData);
end;

function TXLSWorkbook.StoreExterns(DList: TXLSBlobList): integer;
Var i, cnt: Word;
begin
 if FFileFormat = xlExcel97 then begin
    Result := StoreSupbook(DList);
    //Create one EXTERNSHEET record
    if Result = 1 then Result := StoreExternSheet(DList);
 end else begin
   cnt := WorkSheets.Count;
   //Create EXTERNCOUNT with number of worksheets
   //In BIFF8 this record is omitted because there
   //occurs only one EXTERNSHEET record.
   Result := StoreExternCount(DList, cnt + 1);
   //Create EXTERNSHEET for each worksheet
   if Result = 1 then begin
      for i := 1 to cnt do begin
         Result := StoreExternSheet(DList, WorkSheets[i].Name);
         if Result <> 1 then break
      end;
   end;
   if Result = 1 then begin
      Result := StoreExternBook(DList);
   end; 
 end;
end;

function TXLSWorkbook.StoreSupBook(DList: TXLSBlobList): integer;
//Var lData: TXLSBlob;
begin
//  lData := TXLSBlob.Create(8);
//  lData.AddWord($01AE);
//  lData.AddWord($0004);
//  lData.AddWord(FWorksheets.Count);
//  lData.AddWord($0401);
//  Append(DList, lData);
  Result := FExtern.SupBook.Store(DList, Worksheets.Count); 
end; 

function TXLSWorkbook.StoreExtraSpace(Stream: IStream): integer;
Var lData: TXLSBlob;
    i, cnt: integer;
    curpos: Largeint;
    lcurpos: Longword;
begin
  Stream.Seek(0, 1, curpos);
  lcurpos := trunc(curpos) - 1;
  cnt := not(lcurpos) and 511;

  if cnt > 0 then begin
     lData := TXLSBlob.Create(cnt);
     for i := 1 to cnt do lData.AddByte(0);
     lData.Write(Stream);
     lData.Free; 
  end;

  Result := 1;
end;

function TXLSWorkbook.StoreSST(DList: TXLSBlobList; Offset: LongWord): integer;
begin 
  Result := FSST.AddSSTData(DList, Offset); 
end;

function TXLSWorkbook.StoreExternSheet(DList: TXLSBlobList; SheetName: widestring): integer;
Var lData: TXLSBlob;
    cch: Byte;
begin
  cch := Length(SheetName);
  lData := TXLSBlob.Create(6 + cch);
  lData.AddWord($0017);        //Record identifier
  lData.AddWord($0002 + cch);  //Length
  lData.AddByte(cch);           //cch Length of sheet name
  lData.AddByte($03);           //rgch Filename encoding
  {$ifdef D2009}
  lData.AddString(AnsiString(SheetName));
  {$else}
  lData.AddString(SheetName);
  {$endif} 
  Result := Append(DList, lData);
end;

function TXLSWorkbook.StoreExternBook(DList: TXLSBlobList): integer;
Var lData: TXLSBlob;
begin
  lData := TXLSBlob.Create(6);
  lData.AddWord($0017);   //Record identifier
  lData.AddWord($0002);   //Length
  lData.AddByte($01);     //cch Length of sheet name
  lData.AddByte($04);     //rgch Filename encoding
  Result := Append(DList, lData);
end;


function TXLSWorkbook.StoreExternSheet(DList: TXLSBlobList): integer;
Var lData: TXLSBlob;
    count, i: Word;
    iSheet1, iSheet2: integer;
    SupBookIndex: integer;
begin
  Result := 1; 
  count := FExtern.ReferredCount;
  lData := TXLSBlob.Create(4 + 2 + 6 * count);
  lData.AddWord($0017);          //Record identifier
  lData.AddWord(2 + 6 * count);  //Length
  lData.AddWord(count);          //Sheets count

  for i := 1 to count do begin
    Result := FExtern.GetReferredIndexes(i, SupBookIndex, iSheet1, iSheet2);
    if Result <> 1 then break;
    lData.AddWord(SupBookIndex);  
    lData.AddWord(iSheet1 - 1);  
    lData.AddWord(iSheet2 - 1);  
  end;
  if Result = 1 then
     Result := Append(DList, lData)
  else lData.Free;
end;

function TXLSWorkbook.StoreNameShort(DList: TXLSBlobList; ExternID: integer; NameType: Byte; RowMin, RowMax, ColMin, ColMAx: integer; grbit: word): integer;
Var lData: TXLSBlob;
    lSize: Word;
    ExternIndex: integer;
    iSheet1, iSheet2: integer; 
    SupBookIndex: integer;
begin
  if not(ModifyRangeBIFF8(RowMin, ColMin, RowMax, ColMax)) then begin
      //skip this name
      Result := 1;
      exit;
  end;
  ExternIndex := 0;
  Result := FExtern.GetSheetIndexes(ExternID, SupBookIndex, iSheet1, iSheet2);

  if FFileFormat = xlExcel5 then begin
     lSize := $0024;
  end else begin
     ExternIndex := FExtern.GetExternIndex(ExternID);
     if ExternIndex < 1 then Result := -1;
     lSize := $001B;
  end;

  if Result <> 1 then exit;

  lData := TXLSBlob.Create(lSize + 4);
  lData.AddWord($0018);        //Record identifier
  lData.AddWord(lSize);        //Length

  lData.AddWord(grbit);        //grbit Option flags
  lData.AddByte($00);           //chKey Keyboard shortcut
  lData.AddByte($01);           //cch   Length of text name
  if FFileFormat = xlExcel5 then begin
     lData.AddWord($0015);        //cce   Length of formula size
     lData.AddWord(iSheet1);    //ixals Sheet index
  end else begin
     lData.AddWord($000B);       //cce   Length of formula size
     lData.AddWord(0);           //none
  end;
  lData.AddWord(iSheet1);    //itab  Equal to ixals
  lData.AddByte($00);           //cchCustMenu     Length of cust menu text
  lData.AddByte($00);           //cchDescription  Length of description text
  lData.AddByte($00);           //cchHelptopic    Length of help topic text
  lData.AddByte($00);           //cchStatustext   Length of status bar text
  if FFileFormat = xlExcel97 then
     lData.AddByte($00);        //BIFF8 (option byte for widestring)
  lData.AddByte(NameType);      //rgch  Built-in name type

  lData.AddByte($3B);           //unknown
  if FFileFormat = xlExcel5 then begin
    lData.AddWord($FFFF - (iSheet1 - 1)); //unknown  19
    lData.AddWord($0000);         //unknown not used
    lData.AddWord($0000);         //unknown not used
    lData.AddWord($1087);         //unknown not used
    lData.AddWord($8005);         //unknown not used
    lData.AddWord(iSheet1 - 1);   //Index
    lData.AddWord(iSheet1 - 1);   //Index
  end else begin
    //Extern index
    lData.AddWord(ExternIndex - 1);
  end;

  lData.AddWord(RowMin);        //RowMin
  lData.AddWord(RowMax);        //RowMax
  if FFileFormat = xlExcel5 then begin
     lData.AddByte(ColMin);         //ColMin
     lData.AddByte(ColMax);         //ColMax
  end else begin
     lData.AddWord(ColMin);         //ColMin
     lData.AddWord(ColMax);         //ColMax
  end;

  Result := Append(DList, lData);
end;

function TXLSWorkbook.StoreNameLong(DList: TXLSBlobList; ExternID: Integer; NameType: Byte; RowMin, RowMax,
  ColMin, ColMax: integer): integer;
Var lData: TXLSBlob;
    lSize: Word;
    ExternIndex: integer;
    iSheet1, iSheet2: integer; 
    SupBookIndex: integer;
begin

  if not(ModifyRangeBIFF8(RowMin, ColMin, RowMax, ColMax)) then begin
      //skip this name
      Result := 1;
      exit;
  end;

  ExternIndex := 0;
  Result := FExtern.GetSheetIndexes(ExternID, SupBookIndex, iSheet1, iSheet2);
  if FFileFormat = xlExcel5 then begin
     lSize := $003D;
  end else begin
     ExternIndex := FExtern.GetExternIndex(ExternID);
     if ExternIndex < 1 then Result := -1;
     lSize := $002A;
  end;

  if Result <> 1 then exit;

  lData := TXLSBlob.Create(lSize + 4);
  lData.AddWord ($0018);        //Record identifier
  lData.AddWord (lSize);        //Length

  lData.AddWord ($0020);        //grbit Option flags
  lData.AddByte  ($00);          //chKey Keyboard shortcut
  lData.AddByte  ($01);          //cch   Length of text name
  if FFileFormat = xlExcel5 then 
     lData.AddWord ($002E)      //cce   Length of text definition
  else
     lData.AddWord ($001A);        //cce   Length of text definition
  lData.AddWord(iSheet1);    //ixals Sheet index
  lData.AddWord(iSheet1);    //itab  Equal to ixals
  lData.AddByte  ($00);          //cchCustMenu     Length of cust menu text
  lData.AddByte  ($00);          //cchDescription  Length of description text
  lData.AddByte  ($00);          //cchHelptopic    Length of help topic text
  lData.AddByte  ($00);          //cchStatustext   Length of status bar text

  if FFileFormat = xlExcel97 then
     lData.AddByte($00);        //BIFF8 (option byte for widestring)
  lData.AddByte  (NameType);    //rgch  Built-in name type



  //Column definition
  lData.AddByte  ($29);      //tMemFunc unknown_1  only for BIFF5
  if FFileFormat = xlExcel5 then begin
     //BIFF5
     lData.AddWord ($002B);     //unknown_2  only for BIFF5
     lData.AddByte ($3B);           //unknown_3
     lData.AddWord($FFFF - (iSheet1 - 1)); //unknown_4
     lData.AddWord ($0000);         //unknown_5
     lData.AddWord ($0000);         //unknown_6
     lData.AddWord ($1087);         //unknown_7
     lData.AddWord ($8008);         //unknown_8
     lData.AddWord(iSheet1 - 1);   //Index
     lData.AddWord(iSheet1 - 1);   //Index
     lData.AddWord ($0000);         //RowMin
     lData.AddWord ($3FFF);         //RowMax
     lData.AddByte  (ColMin);        //ColMin
     lData.AddByte  (ColMax);        //ColMax
  end else begin
     //BIFF8
     lData.AddWord ($0017);         //unknown_4
     lData.AddByte ($3B);           //unknown_5
     lData.AddWord(ExternIndex - 1);//extref
     lData.AddWord (0);             //RowMin
     lData.AddWord (65535);         //RowMax
     lData.AddWord (ColMin);        //ColMin
     lData.AddWord (ColMax);        //ColMax
  end;

  //Row definition
  lData.AddByte  ($3B);           //unknown_3
  if FFileFormat = xlExcel5 then begin
     //BIFF5
     lData.AddWord($FFFF - (iSheet1 - 1)); //unknown_4
     lData.AddWord ($0000);         //unknown_5
     lData.AddWord ($0000);         //unknown_6
     lData.AddWord ($1087);         //unknown_7
     lData.AddWord ($8008);         //unknown_8
     lData.AddWord(iSheet1 - 1);   //Index
     lData.AddWord(iSheet1 - 1);   //Index
     lData.AddWord (RowMin);        //RowMin
     lData.AddWord (RowMax);        //RowMax
     lData.AddByte  ($00);           //ColMin
     lData.AddByte  ($FF);           //ColMax
  end else begin
     //BIFF8
     lData.AddWord(ExternIndex - 1);//extref
     lData.AddWord (RowMin);        //RowMin
     lData.AddWord (RowMax);        //RowMax
     lData.AddWord (0);             //ColMin
     lData.AddWord (255);           //ColMax
  end;
  //End of data
  lData.AddByte  ($10);           //End of data
  Result := Append(DList, lData);
end;

function TXLSWorkbook.StoreNames(DList: TXLSBlobList): integer;
Var i: Integer;
    Sheet: IXLSWorksheet;
    MaxRows: Word;
    OrderedSheet: array of integer;
    orderchanged: boolean;
    tmp: integer;
    sheetindex: integer;
    l_lastrow: integer;
//    externid: integer;
begin


  Result := FNames.StoreData(DList, FFileFormat, 0);
  for i := 1 to Worksheets.Count do begin
      FNames.StoreData(DList, FFileFormat, Worksheets[i].FSheetID);
  end;

  if FFileFormat = xlExcel5 then MaxRows := $3FFF
  else MaxRows := $FFFF; 

  if Result = 1 then begin
       SetLength(OrderedSheet, Worksheets.Count);

       for i := 1 to Worksheets.Count do OrderedSheet[i - 1] := i;
       orderchanged := true;

       while orderchanged and (Worksheets.Count > 1) do begin
          orderchanged := false;
          for i := 1 to Worksheets.Count - 1 do begin
             if (Worksheets[OrderedSheet[i - 1]].Name > Worksheets[OrderedSheet[i]].Name) then begin
                 orderchanged := true;
                 tmp := OrderedSheet[i - 1];
                 OrderedSheet[i - 1] := OrderedSheet[i];
                 OrderedSheet[i] := tmp;
             end;
          end;
       end;
  end;

  if Result = 1 then begin    
     //Create the print area NAME records
     for i := 1 to Worksheets.Count do begin
         sheetindex := OrderedSheet[i - 1];
         Sheet :=  FWorksheets.Items[sheetindex];
         //Write a Name record if the print area has been defined

         if Sheet.FPageSetup.FPrintAreaRowMin >= 0  then begin
            Result := StoreNameShort(DList,
                                     Sheet.FPageSetup.FExternID, {!!!i - 1, }
                                     $06,
                                     Sheet.FPageSetup.FPrintAreaRowMin, 
                                     Sheet.FPageSetup.FPrintAreaRowMax,
                                     Sheet.FPageSetup.FPrintAreaColMin, 
                                     Sheet.FPageSetup.FPrintAreaColMax,
                                     $0020);
            if Result <> 1 then Break;
         end;
     end;
  end;

  if Result = 1 then begin
    //Create the print title NAME records
    for i := 1 to FWorksheets.Count do begin
      sheetindex := OrderedSheet[i - 1];
      Sheet :=  FWorksheets.Items[sheetindex];
      if (Sheet.FPageSetup.FPrintTitleRowFrom > 0) and
         (Sheet.FPageSetup.FPrintTitleColumnFrom > 0) then begin
         Result := StoreNameLong( DList,
                                  Sheet.FPageSetup.FExternID,
                                  {i - 1,}  $07,
                                  Sheet.FPageSetup.FPrintTitleRowFrom - 1,  
                                  Sheet.FPageSetup.FPrintTitleRowTo - 1,
                                  Sheet.FPageSetup.FPrintTitleColumnFrom - 1, 
                                  Sheet.FPageSetup.FPrintTitleColumnTo - 1);
         if Result <> 1 then Break;
      end
      else if Sheet.FPageSetup.FPrintTitleRowFrom > 0 then begin
         Result := StoreNameShort(DList, 
                                  Sheet.FPageSetup.FExternID, {!!!i - 1,}
                                  $07,
                                  Sheet.FPageSetup.FPrintTitleRowFrom - 1, 
                                  Sheet.FPageSetup.FPrintTitleRowTo - 1,
                                  0, 255, $0020);
         if Result <> 1 then Break;
      end
      else if Sheet.FPageSetup.FPrintTitleColumnFrom > 0 then begin
         Result := StoreNameShort(DList, 
                                  Sheet.FPageSetup.FExternID, {!!!i - 1,}
                                  $07,
                                  $0000, MaxRows,
                                  Sheet.FPageSetup.FPrintTitleColumnFrom - 1, 
                                  Sheet.FPageSetup.FPrintTitleColumnTo - 1, $0020);
         if Result <> 1 then Break;
      end;
    end;
  end;

  if Result = 1 then begin
     //Create the autofilter NAME records
     for i := 1 to FWorksheets.Count do begin
         sheetindex := OrderedSheet[i - 1];
         Sheet :=  FWorksheets.Items[sheetindex];
         if (Sheet._Autofilter.Defined) then begin

             if Sheet._Autofilter.LastRow > 0 then begin
                l_lastrow := Sheet._Autofilter.LastRow;
             end else begin 
                 With Sheet.UsedRange do begin
                   l_lastrow := Row + integer(Rows.Count) - 1;
                 end;
             end;

             if l_lastrow <=  Sheet._Autofilter.FirstRow then begin
                l_lastrow := Sheet._Autofilter.FirstRow + 1;
             end;

             //externid :=  FExtern.GetExternID(sheetindex, sheetindex);

             Result := StoreNameShort(DList, 
                                      FExtern.GetExternID(sheetindex, sheetindex),
                                      $0D,
                                      Sheet._Autofilter.FirstRow - 1, 
                                      l_lastrow - 1,
                                      Sheet._Autofilter.FirstCol - 1, 
                                      Sheet._Autofilter.FirstCol + Sheet._Autofilter.FieldCount - 2,
                                      $0021 {builtin, hidden});
             if Result <> 1 then Break;
         end;
     end; 
  end;


end;

function TXLSWorkbook.StoreOleFile: integer;
Var Hr: HResult;
    i: SmallInt;
    Book: IStream;
    Sheet: IXLSWorkSheet;
    lName: widestring;
begin
  Result := 1;
  case FFileFormat of
     xlExcel5:  lName := 'Book';
     else       lName := 'Workbook';
  end;
  Hr := FDocStorage.CreateStream( PWideChar(lName),
                             STGM_CREATE or STGM_WRITE or
                             STGM_DIRECT or STGM_SHARE_EXCLUSIVE,
                             0,
                             0,
                             Book);
  //Was is opened?
  if not(ole.SUCCEEDED(Hr)) then begin
     Result := -1;
  end;
  if Result = 1 then Result :=  DataList.Write(Book);
  if Result = 1 then Result :=  DataList2.Write(Book);

  if Result = 1 then begin
     for i := 1 to FWorksheets.Count do begin
        Sheet := FWorksheets.Items[i];
        Result := Sheet.WriteData(Book);
        if Result <> 1 then Break;
     end;
  end;
  //openoffice2.0.2 fix
  StoreExtraSpace(Book);

  Book.Release;
  if Assigned(FVBA) and 
   (FFileFormat = FOriginalFileFormat) then  FVBA.Write(FDocStorage);
 if Assigned(FCtls) and 
   (FFileFormat = FOriginalFileFormat) then  FCtls.Write(FDocStorage);
  
end;

function TXLSWorkbook.StorePalette(DList: TXLSBlobList): integer;
Var lData: TXLSBlob;
    lSize: Word;
    ccv: Word;
    i: Word;
begin
  ccv := 64;
  lSize := 2 + 4 * (ccv - 8);
  lData := TXLSBlob.Create(lSize + 4);
  lData.AddWord($0092);                  //Record
  lData.AddWord(lSize);                  //Length
  lData.AddWord(ccv - 8);                    //Count

  for i:= 8 to ccv - 1 do
    lData.AddLong(FColorManager.Palette[i]);     //Color

  Result := Append(DList, lData);
end;

function TXLSWorkbook.StoreWindow1(DList: TXLSBlobList): integer;
Var lData: TXLSBlob;
begin
  lData := TXLSBlob.Create(22);
  lData.AddWord($003D);        //Record
  lData.AddWord($0012);        //Length
  lData.AddWord($0000);        //xWn
  lData.AddWord($0000);        //yWn
  lData.AddWord($25BC);        //dxWn
  lData.AddWord($1572);        //dyWn
  lData.AddWord($0038);        //grbit
  lData.AddWord(ActiveSheet.Index - 1); //ActiveSheet
  lData.AddWord(FFirstSheet);  //FirstSheet
  lData.AddWord(FSelected);    //Option flags
  lData.AddWord($0258);        //Tab to scrollbar ratio
  Result := Append(DList, lData);
end;

function TXLSWorkbook.StoreDrawingGroup(DList: TXLSBlobList): integer;
begin
  Result := 1;
  if FFileFormat >= xlExcel97 then begin
     Result := FDrawingGroup.Store(DList, FLimit);
  end;
end;

function TXLSWorkbook.StoreWorkbook: integer;
Var i: integer;
    Sheet: IXLSWorkSheet;
    lStartCommentBlock: LongWord; 
    AbsoluteOffset: longword;
    transformmode: integer;
begin
   DataList := TXLSBlobList.Create;
   DataList2 := TXLSBlobList.Create;
   if Assigned(FFormula) then FFormula.FileFormat := FFileFormat;
   //Set max BIFF item size
   if FFileFormat = xlExcel5 then begin
      FLimit       := 2080;
      FBiffVersion := $0500;
   end else begin 
      FLimit       := 8224;
      FBiffVersion := $0600;
   end;
   FSST.BiffSizeLimit := FLimit;
   FDataSize := 0;

   Result := 1;
  //Ensure that at least one worksheet has been selected.
   if Worksheets.Count = 0 then begin
      WorkSheets.Add;
      if (Worksheets.Count = 0) then Result := -1;
   end;

   if FFileFormat = xlExcel97 then begin
      FDrawingGroup.PrepareStore;
   end;

  //Calculate the number of selected worksheet tabs and call the finalization
  // methods for each worksheet
   if Result = 1 then
      for i := 1 to FWorksheets.Count do begin
          Sheet := FWorksheets.Items[i];
          if Assigned(Sheet.FChart) then begin
             Sheet.FDataBody    := TXLSBlobList.Create;
             continue;
          end;
           
          
          if Sheet.FSelected then Inc(FSelected);
          Sheet.FDataBody    := TXLSBlobList.Create;
          Sheet.FDataPreHeader  := TXLSBlobList.Create;
          Sheet.FDataHeader  := TXLSBlobList.Create;
          
          Sheet.FDataFooter  := TXLSBlobList.Create;
          
          Sheet.FDataComment := TXLSBlobList.Create;
          Sheet.FDataSize  := 0;
          
          if FFileFormat = xlExcel97 then begin
             Sheet.FDrawing.PrepareStore;
             if Sheet._Autofilter.Defined then begin
                //assign externid
                FExtern.GetExternID(i,i);  
             end;
          end;
      end;

   if Result = 1 then begin
      if FFileFormat = xlExcel5 then transformmode := $500
                                else transformmode := $600;
      FXFList.CreateAllReferredList(transformmode);
   end;

   if (Result = 1) and (FFileFormat <> xlExcel5) then begin
       FSST.InitExtIndex;
       FExtern.CreateReferredList;
   end;
   //Add Workbook globals
   if Result = 1 then Result := StoreBof(DataList, 5);  //0x0005
   if Result = 1 then Result := StoreCodePage(DataList);

   if (Result = 1) and (FFileFormat = xlExcel97) then 
                      Result := StoreDSF(DataList);

   if FFileFormat = xlExcel5 then begin
      if Result = 1 then Result := StoreExterns(DataList); 
      if Result = 1 then Result := StoreNames(DataList);   
   end;

   if Result = 1 then Result := StoreWindow1(DataList);
   if Result = 1 then Result := StoreBackup(DataList);
   if Result = 1 then Result := Store1904(DataList);
   if Result = 1 then Result := StorePrecision(DataList);
   if Result = 1 then Result := StoreRefMode(DataList);

   if Result = 1 then Result := StoreObjProj(DataList);
   if Result = 1 then Result := Store01BA(DataList);
   

   if (Result = 1) and (FFileFormat = xlExcel97) then begin
      Result := StoreFnGroupCount(DataList);
   end;
 
   //Append the book protection
   if Result = 1 then Result := StoreProtect(DataList);
   //Append the book password
   if Result = 1 then Result := StorePassword(DataList);
   if Result = 1 then Result := StoreBookBool(DataList);
   if Result = 1 then Result := StoreAllFonts(DataList);
   if Result = 1 then Result := StoreAllNumFormats(DataList);
   if Result = 1 then Result := StoreAllXfs(DataList);
   if Result = 1 then Result := StoreAllStyles(DataList);
   if Result = 1 then Result := StorePalette(DataList);

   if FFileFormat = xlExcel97 then begin
      if Result = 1 then Result := StoreCountry(DataList);
      if Result = 1 then Result := Store01C1(DataList);
      if Result = 1 then Result := StoreSST(DataList, FDataSIze);
      if Result = 1 then Result := StoreExterns(DataList2); 
      if Result = 1 then Result := StoreNames(DataList2);   
   end;

   if Result = 1 then Result := StoreDrawingGroup(DataList2);

   if Result = 1 then Result := StoreEof(DataList2);


   FDataSize := DataList.TotalSize + DataList2.TotalSize;

   if Result = 1 then begin
      AbsoluteOffset := FDataSize + GetAllBoundSheetSize();
      lStartCommentBlock := 1;
      for i := 1 to FWorksheets.Count do begin

          Sheet := FWorksheets.Items[i];
          Sheet.FOffset := AbsoluteOffset;

          if Assigned(Sheet.FChart) then begin
             Sheet.StoreChart();
             AbsoluteOffset := AbsoluteOffset +  Sheet.FDataBody.TotalSize;
             continue;
          end;
           
          Sheet.FCommentCount := 0;
          Sheet.FStartCommentBlock := lStartCommentBlock;
 
          Sheet.Store;

          lStartCommentBlock := lStartCommentBlock + (Sheet.FCommentCount div $400) + 1; 

          AbsoluteOffset := AbsoluteOffset +  Sheet.FDataSize;

      end;
      FBiffSize := AbsoluteOffset;
   end;

//   if Result = 1 then Result := CalcSheetOffsets;

   //Add BOUNDSHEET records
   if Result = 1 then
      for i := 1 to FWorksheets.Count do begin
          Sheet := FWorksheets.Items[i];
          if Assigned(Sheet.FChart) then  
             Result := StoreBoundSheet(DataList, Sheet.Name, Sheet.FOffset, Sheet.FVisible, $02)
          else
           
             Result := StoreBoundSheet(DataList, Sheet.Name, Sheet.FOffset, Sheet.FVisible, $00);
          if Result <> 1 then break;
      end;

   if Result = 1 then Result := StoreOleFile;

   DataList.Free;
   DataList2.Free;

   for i := 1 to FWorksheets.Count do begin
      Sheet := FWorksheets.Items[i];
      Sheet.FDataBody.Free;
      Sheet.FDataComment.Free; 
      Sheet.FDataPreHeader.Free;
      Sheet.FDataHeader.Free;
      Sheet.FDataFooter.Free; 
   end;
end;

//function TXLSWorkbook.GetCustomColorIndex(Value: LongWord): integer;
//begin
//  Result := FColorManager.GetPaletteColorIndex(Value);
//end;

function TXLSWorkbook.GetCustomColor(Index: integer): LongWord;
begin
  Result := FColorManager.GetPaletteColor(Index);
end;

function TXLSWorkbook.GetCustomColor2(Index: integer; lcid: integer): LongWord;
begin
  Result := GetCustomColor(Index)
end;

function TXLSWorkbook.GetActiveSheet: IXLSWorkSheet;
begin
  Result := FWorkSheets.GetActiveSheet;
end;

function TXLSWorkbook.GetWorksheets: IXLSWorksheets;
begin
  Result := FWorkSheets;
end;

function  TXLSWorkbook.GetReferenceStyle: integer;
begin
  Result := FReferenceStyle;
end;

procedure TXLSWorkbook.SetReferenceStyle(Value: integer);
begin
  if Value = 0 then FReferenceStyle := 0 else FReferenceStyle := 1;
end;


function TXLSWorkbook.SaveAs(FileName: widestring): integer;
begin 
  Result := SaveWorkbook(FileName, nil, FDefaultFileFormat) 
end;

function TXLSWorkbook.Save: integer;
begin
  if (FFileName <> '') and (FFileFormat in [xlExcel5, xlExcel97, xlHTML] ) then begin
     Result := SaveAs(FFileName, FFileFormat);
  end else begin
     Result := -4;
  end;
end;

function TXLSWorkbook.SaveAs(FileName: widestring; FileFormat: TXLSFileFormat): integer;
begin 
  Result := SaveWorkbook(FileName, nil, FileFormat) 
end;

function TXLSWorkbook.SaveAs(Stream: TStream; FileFormat: TXLSFileFormat): integer;
begin 
  Result := SaveWorkbook('', Stream, FileFormat) 
end;

function TXLSWorkbook.SaveAs(Stream: TStream): integer;
begin 
  Result := SaveWorkbook('', Stream, FDefaultFileFormat) 
end;

function TXLSWorkbook.SaveWorkbook(FileName: widestring; Stream: TStream; FileFormat: TXLSFileFormat): integer;
Var wFileName: WideString;
    Hr:  HResult;
    Ret: integer;
    LockBytes: ILockBytes;
    DHandle: HGLOBAL;
    Buff: Pointer;
begin

  if FileFormat = xlHTML then begin
     Result := SaveAsHTML(FileName);
  end else if FileFormat = xlRTF then begin
     if Assigned(Stream) then begin
        Result := SaveAsRTF(Stream);
     end else begin
        Result := SaveAsRTF(FileName);
     end;
  end else if (FileFormat = xlCSV) or (FileFormat = xlUnicodeCSV) then begin
     if Assigned(Stream) then begin
        Result := ActiveSheet.SaveAs(Stream, FileFormat);
     end else begin
        Result := ActiveSheet.SaveAs(FileName, FileFormat);
     end;
  end else if (FileFormat = xlText) or (FileFormat = xlUnicodeText) then begin
     if Assigned(Stream) then begin
        Result := ActiveSheet.SaveAs(Stream, FileFormat);
     end else begin
        Result := ActiveSheet.SaveAs(FileName, FileFormat);
     end;
  end else if (FileFormat = xlOpenXMLWorkbook) then begin
    FFileFormat := FileFormat;
    Result := 1;
    //check filename
    if (trim(FileName) = '') and not(Assigned(Stream)) then begin
        //MessageDlg('File name must be specified', mtError, [mbOk], 0);
        //RiseException;
        Result := -1;
    end;
    if Result = 1 then begin
       if Assigned(Stream) then begin
          Result := SaveXLSXStream(Self, Stream, '', FileFormat);
       end else begin
          Result := SaveXLSXFile(Self, FileName, '', FileFormat);
       end;
    end;
  end else begin
    FFileFormat := FileFormat;
    Ret := 1;
    //check filename
    if (trim(FileName) = '') and not(Assigned(Stream)) then begin
        //MessageDlg('File name must be specified', mtError, [mbOk], 0);
        //RiseException;
        Ret := -1;
    end;

    //open file for write
    if Ret = 1 then begin
        if Assigned(Stream) then begin
           {Try open the Stream} 
           Hr := CreateILockBytesOnHGlobal(0, True, LockBytes);
           if (ole.SUCCEEDED(Hr)) then begin
               Hr := StgCreateDocfileOnILockBytes(LockBytes, 
                                      STGM_CREATE or
                                      STGM_READWRITE or
                                      STGM_DIRECT or
                                      STGM_SHARE_EXCLUSIVE,
                                      0, 
                                      FDocStorage);
           end;

           if (ole.SUCCEEDED(Hr)) then begin
              FFileClosed := false;
           end else begin
              Ret := -3;
           end;

        end else begin
           {Try open the DocFile}
           wFileName := FileName;
           Hr := StgCreateDocFile(PWideChar(wFileName),
                                  STGM_CREATE or
                                  STGM_READWRITE or
                                  STGM_DIRECT or
                                  STGM_SHARE_EXCLUSIVE,
                                  0,
                                  FDocStorage);
           {Was is opened?}
           if (ole.SUCCEEDED(Hr)) then begin
              (* Success *)
              FFileClosed := false;
              FFileName := FileName;
           end
           else begin
              (*  Fail  *)
              //MessageDlg('File sharing violation' + Chr(10) + Chr(13) +
              //           'Cannot open the file: ' + AFileName, mtError, [mbOk], 0);
              //RiseException;
              Ret := -2;
           end;
        end;
     end;

     if Ret = 1 then begin
        
        StoreWorkbook;

        if Assigned(Stream) then begin
           LockBytes.Flush;
           FDocStorage.Commit(STGC_DEFAULT);
           GetHGlobalFromILockBytes(LockBytes, DHandle);
           Buff := GlobalLock(DHandle);
           try
             Stream.WriteBuffer(Buff^, GlobalSize(DHandle));
           finally
             GlobalUnlock(DHandle);
           end;
        end;
        FDocStorage.Release;
        FFileClosed := true;
     end;
     Result := Ret;
  end;
end;

procedure TXLSWorkbook.GetSheetIDByName(SheetName: widestring; Var SheetID: integer);
begin
  SheetID := Sheets.IDByName[SheetName];
end;

function TXLSWorkbook.GetExcel5BookExternID(): integer;
begin
  Result := Sheets.Count + 1;
end;


procedure TXLSWorkbook.GetSheetIndexByID(SheetID: integer; Var SheetIndex: integer);
begin
  SheetIndex := Sheets.IndexByID[SheetID];
end;

procedure TXLSWorkbook.GetSheetNameByIndex(SheetIndex: integer; Var SheetName: widestring);
var ws: IXLSWorksheet;
begin
  ws := Sheets[SheetIndex];
  if Assigned(ws) then 
     SheetName := Sheets[SheetIndex].Name
  else
     SheetName := '';    
end;

procedure TXLSWorkbook.InitFormula;
begin
  if not(Assigned(FFormula)) then begin
//     FFormula := TXLSCalculator.Create(GetSheetIDByName, GetSheetIndexByID, GetSheetNameByID);
     FFormula := TXLSCalculator.Create(FExtern, GetCellValue);
     FFormula.FileFormat := FFileFormat;
  end;
end;

function TXLSWorkbook.GetCompiledFormula(aFormula: string; SheetID: integer): TXLSCompiledFormula;
begin
  InitFormula;
  Result := FFormula.GetCompiledFormula(aFormula, SheetID); 
end;

function TXLSWorkbook.GetUnCompiledFormula(aFormula: TXLSCompiledFormula; CurRow, CurCol, SheetID: integer): string;
begin
  InitFormula;
  Result := FFormula.GetUnCompiledFormula(aFormula, CurRow, CurCol, SheetID); 
end;

function TXLSWorkbook.GetFormulaValue(aSheetIndex: integer; aFormula: TXLSCompiledFormula; CurRow, CurCol: integer; Var Value: variant): integer;
begin
  InitFormula;
  Result := FFormula.GetValue(aSheetIndex, aFormula, CurRow, CurCol, Value, FChangeID); 
  if Result <> 1 then Value := null;
end;


{TXLSOutline}
constructor TXLSOutline.Create;
begin
  Inherited Create;
  SummaryRow := xlBelow;
  SummaryColumn := xlRight;
end;

procedure TXLSOutline.SetSummaryColumn(Value: XlSummaryColumn);
begin
  if (Value <= 1) then FSummaryColumn := Value;
end;

procedure TXLSOutline.SetSummaryRow(Value: XlSummaryRow);
begin
  if (Value <= 1) then FSummaryRow := Value;
end;


{ IXLSWorksheet }
function IXLSWorksheet.SaveAsHTML(Filename: widestring): integer;
Var Exporter: TXLSHTMLExport;
begin
  Exporter := TXLSHTMLExport.Create;
  try
    try
      Result := Exporter.SaveAsHTML(self, FileName);
    except
      on E:Exception do begin
         Result := -1;
      end; 
    end; 
  finally
    Exporter.Free;
  end;
end;

function  IXLSWorksheet.GetOutline: TXLSOutline;
begin
  if Not(Assigned(FOutline)) then begin
     FOutline := TXLSOutline.Create();
  end;
  Result := FOutline;
end;


function  IXLSWorksheet.SaveAsCSV(FileName: WideString): integer;
begin
  try
    Result := UsedRange.SaveAsCSV(FileName);
  except
    on E:Exception do begin
       Result := -1;
    end; 
  end; 
end;

function  IXLSWorksheet.SaveAs(Stream: TStream; FileFormat: TXLSFileFormat): integer;
begin
  case FileFormat of

     xlHTML, 
     xlCSV, 
     xlText,
     xlUnicodeCSV, 
     xlUnicodeText:  Result := UsedRange.SaveAs(Stream, FileFormat);

     xlRTF:   Result := SaveAsRTF(Stream);

     else 
              Result := -1;
  end; 
end;

function  IXLSWorksheet.SaveAs(FileName: wideString; FileFormat: TXLSFileFormat): integer;
begin
  case FileFormat of

     xlHTML, 
     xlCSV, 
     xlText,
     xlUnicodeCSV, 
     xlUnicodeText:  Result := UsedRange.SaveAs(FileName, FileFormat);

     xlRTF:   Result := SaveAsRTF(FileName);

     else 
              Result := -1;
  end; 
end;

function  IXLSWorksheet.SaveAsRTF(FileName: wideString): integer;
Var RTFExport: TXLSRTFExport;
begin
  RTFExport := TXLSRTFExport.Create();
  try
    Result := RTFExport.SaveAsRTF(Self, FileName);
  finally
    RTFExport.Free;
  end;
end;

function  IXLSWorksheet.SaveAsRTF(Stream: TStream): integer;
Var RTFExport: TXLSRTFExport;
begin
  RTFExport := TXLSRTFExport.Create();
  try
    Result := RTFExport.SaveAsRTF(Self, Stream);
  finally
    RTFExport.Free;
  end;
end;


function IXLSWorksheet.Calculate(Formula: WideString): Variant;
Var CompiledFormula: TXLSCompiledFormula;
    Res: integer;
begin
   CompiledFormula := FWorkbook.GetCompiledFormula(Formula, FSheetID);
   if Assigned(CompiledFormula) then begin
      Res := FWorkbook.GetFormulaValue(self.Index, CompiledFormula, 0, 0, Result);
      if Res <> 1 then Result := Null;
      CompiledFormula.Free; 
   end else Result := Null;
end;

procedure IXLSWorksheet._SetCompiledFormula(row, col: word; Formula: TXLSCompiledFormula);
Var Cell: TXLSCellRef;
begin
  Cell := FCells.GetOrCreateValue(row, col);
  if Assigned(Cell) and Assigned(Formula) then begin
     if Cell.FValueType = xlFormula then Cell.FCompiledFormula.Free;
     Cell.FValueType := xlFormula;
     Cell.FCompiledFormula := Formula;
  end;
end;

function IXLSWorksheet._GetCompiledFormula(row, col: word): TXLSCompiledFormula;
Var Cell: TXLSCellRef;
begin
  Result := nil;
  Cell := FCells.GetValue(row, col);
  if Assigned(Cell) then begin
     if Cell.FValueType = xlFormula then Result := Cell.FCompiledFormula;
  end;
end;

procedure IXLSWorksheet._SetXF(row, col: word; xf: integer);
Var Cell: TXLSCellRef;
    CurXFIndex: integer;
    ReplaceCurXFIndex: boolean;
begin
  Cell := FCells.GetOrCreateValue(row, col);
  if Assigned(Cell) then begin
     CurXFIndex := GetXFIndex(row, col, ReplaceCurXFIndex);
     if not(ReplaceCurXFIndex) then CurXFIndex := 0;
     FWorkBook.FXFList.ReplaceIndex(CurXFIndex, xf);
     Cell.FXFIndex := xf;
  end;
end;

function  IXLSWorksheet.GetRange(Cell1: string; Cell2: string): TXLSRange;
begin
  Result := TXLSRange.Create(self, Cell1, Cell2);
end;

function  IXLSWorksheet.FGetRange(Cell1: string; Cell2: string): IXLSRange;
begin
  Result := TXLSRange.Create(self, Cell1, Cell2);
end;

function  IXLSWorksheet.FGetRowColRange(row1, col1, row2, col2: integer): IXLSRange;
begin
  Result := _FGetRowColRange2(row1, col1, row2, col2);
end;

function  IXLSWorksheet._FGetRowColRange2(row1, col1, row2, col2: integer): TXLSRange;
begin
  if row1 < 1 then row1 := 1;
  if row2 < 1 then row2 := 1;
  if col1 < 1 then col1 := 1;
  if col2 < 1 then col2 := 1;
  if row1 > (XLSXMaxRow + 1) then  row1 := XLSXMaxRow + 1;
  if row2 > (XLSXMaxRow + 1) then  row2 := XLSXMaxRow + 1;
  if col1 > (XLSXMaxCol + 1) then  col1 := XLSXMaxCol + 1;
  if col2 > (XLSXMaxCol + 1) then  col2 := XLSXMaxCol + 1;
  if row2 < row1 then swap(row1, row2);
  if col2 < col1 then swap(col1, col2);
  Result := TXLSRange.Create(self, row1 - 1, col1 - 1,
                                   row2 - 1, col2 - 1);
end;

function IXLSWorksheet.GetCells: IXLSRange;
begin Result := FCellsRange; end;

function IXLSWorksheet.GetSelection: IXLSRange;
begin Result := FSelection; end;

procedure IXLSWorksheet.Activate;
begin
  if not(FSelected) then begin
     FWorkBook.FWorkSheets.Deselect;
     FSelected := true;
  end;   
  FWorkBook.FWorkSheets.FActiveSheet := self;
end;

function IXLSWorksheet.FreezePanes(row, col, RowTop,
  ColLeft: integer): integer;
begin
  Result := 1;
  if not(Assigned(FPanes)) then FPanes := TXLSPanes.Create;
  FPanes.Y := row;
  FPanes.X := col;
  FPanes.RowTop := rowTop;
  FPanes.ColLeft := colLeft;
  FFrozen := true;
  FPanes.FFrozen := true;
end;

function IXLSWorksheet.GetPageSetup: IXLSPageSetup;
begin
  Result := FIPageSetup;
end;

function IXLSWorksheet.GetIndex: Word;
begin
  Result := FIndex;
end;

function IXLSWorksheet.GetWorkSheetName: widestring;
begin
  Result := FWorksheetName;
end;

procedure IXLSWorksheet.SetWorkSheetName(Value: widestring);
begin
  if FWorkBook.FWorkSheets.CheckName(Findex, Value) then
      FWorkSheetName := Value
  else begin
    //!!exeption invalid or duplicate worksheetname
  end;
end;

function IXLSWorksheet.GetScrollRow: integer;
begin Result := FScrollRow + 1 end;

function IXLSWorksheet.GetScrollColumn: integer;
begin Result := FScrollColumn + 1 end;

procedure IXLSWorksheet.SetScrollRow(Value: integer);
begin
  if (Value > 0) and (Value <= (XLSXMaxRow + 1)) then FScrollRow := Value - 1;
end;

procedure IXLSWorksheet.SetScrollColumn(Value: integer);
begin
  if (Value > 0) and (Value <= (XLSXMaxCol + 1)) then FScrollColumn := Value - 1;
end;

function IXLSWorksheet.GetHPageBreaks: TXLSHPageBreaks;
begin
  Result := FHPageBreaks;
end;

function IXLSWorksheet.GetVPageBreaks: TXLSVPageBreaks;
begin
  Result := FVPageBreaks;
end;

function IXLSWorksheet.GetDisplayGridLines: boolean;
begin
  Result := FScreenGridLines;
end;

procedure IXLSWorksheet.SetDisplayGridLines(Value: boolean);
begin
  FScreenGridLines :=  Value;
end;

procedure IXLSWorksheet.ResetAllPageBreaks;
begin
  HPageBreaks.ClearAll;
  VPageBreaks.ClearAll;
end;

procedure IXLSWorksheet.Delete;
begin
  FWorkBook.FWorkSheets.Delete(FIndex);
end;

procedure IXLSWorksheet.Delete(lcid: integer);
begin
  Delete;
end;

procedure IXLSWorksheet.Move(Before, After: IXLSWorksheet; lcid: integer);
Var iBefore, iAfter, ToIndex: integer;
    Sheet: IXLSWorksheet;
begin
  if Assigned(Before) then begin
     Sheet := Before;
     iBefore := Sheet.FIndex;
  end else begin
     iBefore := 0;
  end;

  if Assigned(After) then begin
     Sheet := After;
     iAfter := Sheet.FIndex;
  end else begin
     iAfter := 0;
  end;

  if iBefore > 0 then begin
     if FIndex < iBefore then ToIndex := iBefore - 1
     else  ToIndex := iBefore
  end else if iAfter > 0 then begin
     if FIndex < iAfter then ToIndex := iAfter
     else ToIndex := iAfter + 1
  end else ToIndex := FIndex;

  if ToIndex <> FIndex then begin
     FWorkBook.FWorkSheets.MoveSheet(FIndex, ToIndex);
  end;

end;

procedure IXLSWorksheet.Move(Before, After: IXLSWorksheet);
begin
  Move(Before, After, 0);
end;

procedure IXLSWorksheet.Move(Before: IXLSWorksheet);
begin
  Move(Before, nil, 0);
end;

procedure IXLSWorksheet.Protect;
begin
  FProtect.Protect('');
end;

procedure IXLSWorksheet.Protect(Password: string);
begin
  FProtect.Protect(Password);
end;

procedure IXLSWorksheet.UnProtect;
begin
  FProtect.UnProtect('', false);
end;

procedure IXLSWorksheet.UnProtect(Password: string);
begin
  FProtect.UnProtect(Password, true);
end;

procedure IXLSWorksheet.UnProtect(Password: string; lcid: integer);
begin
  FProtect.UnProtect(Password, true);
end;

function IXLSWorksheet.MergeWrite(FirstRow, FirstCol, LastRow, LastCol: integer; Format: integer): integer;
Var rwFirst, rwLast, colFirst, colLast: integer;
    i, j: Word;
    Cell: TXLSCellRef;
begin
  Result := 1;
  rwFirst  := FirstRow;
  colFirst := FirstCol;
  rwLast   := LastRow;
  colLast  := LastCol;

  if Result = 1 then begin
    if rwFirst > rwLast then begin
       rwFirst  := LastRow;
       rwLast   := FirstRow;
    end;

    if colFirst > colLast then begin
       colFirst  := LastCol;
       colLast   := FirstCol;
    end;

    if rwLast > XLSMaxRow then rwLast := XLSMaxRow;
    if colLast > XLSMaxCol then colLast := XLSMaxCol;
  end;

  //Write the first cell
  if Result = 1 then Result := Write(rwFirst, colFirst, Format);

  if Result = 1 then begin
    //Pad out the rest of the area with formatted blank cells
    for i := rwFirst to rwLast do begin
      for j := colFirst to colLast do begin
          if (i = rwFirst) and (j = colFirst) then continue;
          Cell := FCells.GetValue(i, j);
          if Assigned(Cell) then
              Result := Write(i, j, Cell.FXFIndex)
          else
              Result := Write(i, j, Format);
          if Result <> 1 then Break;
      end;
      if Result <> 1 then Break;
    end;
  end;
  if Result = 1 then Result := MergeCells(rwFirst, colFirst, rwLast, colLast);
end;

function IXLSWorksheet.MergeWriteNumber(FirstRow, FirstCol, LastRow, LastCol: integer;
 Value: Double; Format: integer): integer;
begin
  Result := MergeWriteDouble(FirstRow, FirstCol, LastRow,
            LastCol, Value, Format);
end;

function IXLSWorksheet.MergeWriteString(FirstRow, FirstCol, LastRow, LastCol: integer;
  Value: Integer; Format: integer): integer;
Var rwFirst, rwLast, colFirst, colLast: integer;
    i, j: Word;
    Cell: TXLSCellRef;
begin
  Result := 1;
  rwFirst  := FirstRow;
  colFirst := FirstCol;
  rwLast   := LastRow;
  colLast  := LastCol;

  if Result = 1 then begin
    if rwFirst > rwLast then begin
       rwFirst  := LastRow;
       rwLast   := FirstRow;
    end;

    if colFirst > colLast then begin
       colFirst  := LastCol;
       colLast   := FirstCol;
    end;

    if rwLast > XLSMaxRow then rwLast := XLSMaxRow;
    if colLast > XLSMaxCol then colLast := XLSMaxCol;
  end;

  //Write the first cell
  if Result = 1 then Result := WriteString(rwFirst, colFirst, Value, Format);

  if Result = 1 then begin
    //Pad out the rest of the area with formatted blank cells
    for i := rwFirst to rwLast do begin
      for j := colFirst to colLast do begin
          if (i = rwFirst) and (j = colFirst) then continue;
          Cell := FCells.GetValue(i, j);
          if Assigned(Cell) then
              Result := Write(i, j, Cell.FXFIndex)
          else
              Result := Write(i, j, Format);
          if Result <> 1 then Break;
      end;
      if Result <> 1 then Break;
    end;
  end;
  if Result = 1 then Result := MergeCells(rwFirst, colFirst, rwLast, colLast);
end;


function IXLSWorksheet.MergeWriteFormula(FirstRow, FirstCol, LastRow, LastCol: integer;
  Value: TXLSCompiledFormula; Format: integer): integer;
Var rwFirst, rwLast, colFirst, colLast: integer;
    i, j: Word;
    Cell: TXLSCellRef;
begin
  Result := 1;
  rwFirst  := FirstRow;
  colFirst := FirstCol;
  rwLast   := LastRow;
  colLast  := LastCol;

  if Result = 1 then begin
    if rwFirst > rwLast then begin
       rwFirst  := LastRow;
       rwLast   := FirstRow;
    end;

    if colFirst > colLast then begin
       colFirst  := LastCol;
       colLast   := FirstCol;
    end;

    if rwLast > XLSMaxRow then rwLast := XLSMaxRow;
    if colLast > XLSMaxCol then colLast := XLSMaxCol;
  end;


  //Write the first cell
  if Result = 1 then Result := WriteFormula(rwFirst, colFirst, Value, Format);

  if Result = 1 then begin
    //Pad out the rest of the area with formatted blank cells
    for i := rwFirst to rwLast do begin
      for j := colFirst to colLast do begin
          if (i = rwFirst) and (j = colFirst) then continue;
          Cell := FCells.GetValue(i, j);
          if Assigned(Cell) then
              Result := Write(i, j, Cell.FXFIndex)
          else
              Result := Write(i, j, Format);
          if Result <> 1 then Break;
      end;
      if Result <> 1 then Break;
    end;
  end;
  if Result = 1 then Result := MergeCells(rwFirst, colFirst, rwLast, colLast);
end;


function IXLSWorksheet.RepeatColumns(FirstCol, LastCol: integer): integer;
begin
  Result := -1;
end;

function IXLSWorksheet.RepeatRows(FirstRow, LastRow: integer): integer;
begin
  Result := -1;
end;

procedure IXLSWorksheet.Select;
begin
  Select(true, 0);
end;

procedure IXLSWorksheet.Select(Replace: boolean);
begin
  Select(Replace, 0);
end;

procedure IXLSWorksheet.Select(Replace: boolean; lcid: integer);
begin
   if Replace then begin
      FWorkBook.FWorkSheets.Deselect;
      FWorkBook.FWorkSheets.FActiveSheet := self;
   end;
   FSelected := true;
end;

function IXLSWorksheet.SetFirstSheet: integer;
begin
  FWorkBook.FFirstSheet := FIndex - 1;
  Result := 1;
end;

procedure IXLSWorksheet.SetZoom(const Value: Variant);
Var vt: TVarType;
    v: Word;
begin
  vt := VarType(Value);
  case vt of
     varBoolean: if not(Value) then FZoom := 100;
     else begin
        v := Word(Value);
        if (v < 10) or (v > 400) then begin
           //exception
        end else begin
           FZoom := v;
        end;
     end;
  end;
end;


function IXLSWorksheet.GetZoom: Variant;
begin Result := FZoom; end;

procedure IXLSWorksheet.SetVisible(const Value: Variant);
Var vt: TVarType;
begin
  vt := VarType(Value);
  case vt of
     varBoolean: if Value then FVisible := xlSheetVisible
                          else FVisible := xlSheetHidden;
     else if (Value = xlSheetHidden) or 
             (Value = xlSheetVeryHidden) or
             (Value = xlSheetVisible) then   FVisible := Byte(Value);
  end;
end;

function IXLSWorksheet.GetVisible: Variant;
begin Result := FVisible;  end;


procedure  IXLSWorksheet.SetStdHeight(Value: Double);
begin FRowInfo.StdHeight := Value end;

procedure  IXLSWorksheet.SetStdWidth(Value: Double);
begin  FColumnInfo.StdWidth := Value end;

function  IXLSWorksheet.GetStdHeight: Double;
begin Result := FRowInfo.StdHeight end;

function  IXLSWorksheet.GetStdWidth: Double;
begin Result := FColumnInfo.StdWidth end;

function IXLSWorksheet.ThawPanes(Y, X: Single; RowTop,
  ColLeft: integer): integer;
begin
  if Not(Assigned(FPanes)) then FPanes := TXLSPanes.Create;
  FPanes.Y := Y;
  FPanes.X := X;
  FPanes.RowTop := RowTop;
  FPanes.ColLeft := ColLeft;
  FPanes.FFrozen := false;
  FFrozen := false;
  Result := 1;
end;

function IXLSWorksheet.WriteString(row, col: Word; Value: Integer;
  Format: integer): integer;
Var Data: TXLSBlob;
    lxf: Word;
    Str: {$ifdef D2009}AnsiString{$else}String{$endif};
    StrLen: LongWord;
begin
  Result := 1;
  StrLen := 0;
  if CheckDimensions(row, col) <> 1 then Result := -2;
  if (Result = 1) and (FWorkbook.FFileFormat = xlExcel5) then begin
     Str := AnsiString(Str2xls(FWorkbook.FSST.Value[Value]));
     StrLen := Length(Str);
     if (StrLen > XlsStrMax) then begin//LABEL must be < 255 chars
        StrLen := XlsStrMax;
        Str := Copy(Str, 1, StrLen);
     end;
  end;  
  if Result = 1 then begin
     if Format > 0 then lxf := FWorkBook.FXFList.SaveIndex[Format] - 1
        else lxf := 0;
     if FWorkbook.FFileFormat = xlExcel5 then begin
        Data := TXLSBlob.Create(4 + 8 + StrLen);
        Data.AddWord($0204);        //Record identifier
        Data.AddWord(8 + StrLen);   //Number of bytes to follow
        Data.AddWord(Row);          //row
        Data.AddWord(Col);          //col
        Data.AddWord(lxf);          //xf
        Data.AddWord(StrLen);       //StrLen
        Data.AddString(Str);         //Value
     end else begin
        Data := TXLSBlob.Create(4 + 10);
        Data.AddWord($00FD);   //Record identifier
        Data.AddWord($000A);   //Number of bytes to follow
        Data.AddWord(Row);     //row
        Data.AddWord(Col);     //col
        Data.AddWord(lxf);     //xf
        Data.AddLong(FWorkbook.FSST.ExtIndex[Value]); //SST index
     end; 
     Result := AppendData(Data, FDataBody);
  end;
end;

function IXLSWorksheet.WriteArrayFormula(Value: TXLSCompiledFormula; Format: integer): integer;
Var Data:   TXLSBlob;
    Header: TXLSBlob;
begin
   FWorkBook.InitFormula;
   Result := FWorkBook.FFormula.GetArrayFormulaData(Value, self.FSheetID, Data); 
   if Result = 1 then begin
      Header := TXLSBlob.Create(4); 
      Header.AddWord($0221);
      Header.AddWord(Data.GetDataSize);
      AppendData(Header, FDataBody);
      AppendData(Data, FDataBody);
   end;
end;


function IXLSWorksheet.WriteFormula(row, col: Word; Value: TXLSCompiledFormula;
  Format: integer): integer;
Var Data:   TXLSBlob;
    Header: TXLSBlob;
    lxf: Word;
    FormulaValue: Variant;
    lDecResult: double;
    lBoolResult: boolean;
    lStringResult: WideString;
    isCalculated: integer;
    Res: integer;
    lErrorCode: byte;
    isdt: boolean;
    ReplaceIndex: boolean;
begin
  Result := 1;
  lxf := 0;
  isCalculated := 0;
  lDecResult := 0;
  lBoolResult := false;
  lStringResult := '';
  lErrorCode := 0;
 
 
  if CheckDimensions(row, col) <> 1 then Result := -2;
  if Result = 1 then begin
     if Format > 0 then lxf := FWorkBook.FXFList.SaveIndex[Format] - 1
        else lxf := 0;
     FWorkBook.InitFormula;
     Result := FWorkBook.FFormula.GetStoreData(Value, Data, row, col, self.FSheetID); 
  end;

  if Result = 1 then begin
     Res := FWorkBook.GetFormulaValue(self.index, Value, row, col, FormulaValue);
     if Res = 1 then begin
        if VarIsNumeric(FormulaValue) then begin
           isCalculated := 1;
           lDecResult := FormulaValue;
           
           if FWorkbook.F1904 then begin
              if Format > 0 then begin
                 isdt := FWorkbook._XFList.isDateFormat(Format);
              end else begin
                 isdt := FWorkbook._XFList.isDateFormat(GetXFIndex(row, col, ReplaceIndex));
              end;
              if isdt then begin
                 if lDecResult >= 1462 then begin
                    lDecResult := lDecResult - 1462;
                 end else begin
                    lDecResult := 0;
                 end;
              end;  
           end;
        end else if VarIsBoolean(FormulaValue) then begin
           isCalculated := 2;
           lBoolResult := FormulaValue;
        end else if VarIsNull(FormulaValue) then begin
           isCalculated := 3;
        end else if VarIsString(FormulaValue) then begin
           isCalculated := 4;
           lStringResult := FormulaValue;
           if lStringResult = '' then isCalculated := 3;
        end;
     end else begin
       if Res in xlsErrors then begin
          isCalculated := 5;
          lErrorCode := Res;
       end;
     end;
  end;

  if Result = 1 then begin
     Header := TXLSBlob.Create(4 + 20); 
     Header.AddWord($0006);
     Header.AddWord(20 + Data.GetDataSize);
     Header.AddWord(Row);          //row
     Header.AddWord(Col);          //col
     Header.AddWord(lxf);          //xf
     case isCalculated of 
        0: begin
              Header.AddDouble(0);          //non calculated
           end;
        1: Header.AddDouble(lDecResult); //decimal result
        2: begin //boolean result
             Header.AddWord($0001); 
             Header.AddByte(Ord(lBoolResult)); 
             Header.AddWord($0000); 
             Header.AddByte($00); 
             Header.AddWord($FFFF); 
           end;
        3: begin //empty result
             if FWorkbook.FFileFormat = xlExcel5 then
                Header.AddDouble(0)
             else begin
                Header.AddWord($0003); 
                Header.AddLong($00000000); 
                Header.AddWord($FFFF); 
             end;
           end;
        4: begin //string result
                Header.AddWord($0000); 
                Header.AddLong($00000000); 
                Header.AddWord($FFFF); 
           end;
        5: begin //error
                Header.AddWord($0002); 
                Header.AddByte(lErrorCode); 
                Header.AddByte($00); 
                Header.AddWord($00000); 
                Header.AddWord($FFFF); 
           end;
     end;
     
     if isCalculated = 0 then Header.AddWord($0002) 
                         else Header.AddWord($0000); 
     Header.AddWord($0000); 
     Header.AddWord($0000); 
     Result := AppendData(Header, FDataBody);
  end;
  if Result = 1 then Result := AppendData(Data, FDataBody);

  if Result = 1 then begin
     if Value.IsArrayFormula then begin
        if Value.ArrayFormula.IsRootFormula then begin
           Result := WriteArrayFormula(Value, Format);      
        end;
     end; 
  end;

  if (Result = 1) and (isCalculated = 4) then begin
     Result := WriteFormulaString(lStringResult);
  end;
end;


function IXLSWorksheet.WriteFormulaString(Value: WideString): integer;
Var Data: TXLSBlob;
    Str: {$ifdef D2009}AnsiString{$else}String{$endif};
    StrLen: LongWord;
begin
  Result := 1;

  if FWorkbook.FFileFormat = xlExcel5 then begin
     Str := AnsiString(Str2xls(Value));
     StrLen := Length(Str);
  end else begin
     Value := Str2xls(Value);
     StrLen := Length(Value);
  end;  

  if Result = 1 then begin
     if FWorkbook.FFileFormat = xlExcel5 then
        Data := TXLSBlob.Create(4 + 2 + StrLen)
     else 
        Data := TXLSBlob.Create(4 + 3 + StrLen * 2);
   
     Data.AddWord($0207);        //Record identifier
     if FWorkbook.FFileFormat = xlExcel5 then begin
        Data.AddWord(2 + StrLen);   //Number of bytes to follow
        Data.AddWord(StrLen);       //StrLen
        Data.AddString(Str);         //Value
     end else begin
        Data.AddWord(3 + StrLen * 2); //Number of bytes to follow
        Data.AddWord(StrLen);         //StrLen
        Data.AddByte(1);              //option
        Data.AddWideString(Value);    //Value
     end; 
     Result := AppendData(Data, FDataBody);
  end;
end;

function IXLSWorksheet.Write(row, col: Word; Format: integer): integer;
Var Data: TXLSBlob;
    lxf: Word;
begin
  Result := 1;
  if Format > 0 then lxf := FWorkBook.FXFList.SaveIndex[Format] - 1
     else lxf := 0;
  if lxf = 0 then exit;
 
  if CheckDimensions(row, col) <> 1 then Result := -2;
  if Result = 1 then begin
     Data := TXLSBlob.Create(10);
     Data.AddWord($0201);        //Record identifier
     Data.AddWord($0006);        //Number of bytes to follow
     Data.AddWord(Row);          //row
     Data.AddWord(Col);          //col
     Data.AddWord(lxf);          //xf
     Result := AppendData(Data, FDataBody);
  end;
end;

function IXLSWorksheet.WriteRK(row, col: Word; Value: Longword;
  Format: integer): integer;
Var Data: TXLSBlob;
    lxf: Word;
begin
  Result := 1;
  if CheckDimensions(row, col) <> 1 then Result := -2;
  if Result = 1 then begin
     if Format > 0 then lxf := FWorkBook.FXFList.SaveIndex[Format] - 1
       else lxf := 0;

     Data := TXLSBlob.Create(14);
     Data.AddWord($027E);        //Record identifier
     Data.AddWord($000A);        //Number of bytes to follow
     Data.AddWord(Row);          //row
     Data.AddWord(Col);          //col
     Data.AddWord(lxf);          //xf
     Data.AddLong(Value);        //Value
     Result := AppendData(Data, FDataBody);
  end;
end;

function IXLSWorksheet.WriteMulRK(row: integer; col: integer; count: integer): integer;
var i: integer;
    Cell: TXLSCellRef;
    Data: TXLSBlob;
    lxf: Word;
    coli: integer;
    size: integer;
    v: Longword; 
    doublevalue: double;
    ReplaceIndex: boolean;
    isdt: boolean;
begin
  if count = 1 then begin
     Cell := FCells.GetValue(row, col);
     doublevalue := Cell.FDoubleValue;
     if FWorkbook.F1904 then begin
        if Cell.FValueType = xlDateTime then begin
           isdt := true;
        end else begin
           if Cell.FXFIndex > 0 then begin
              isdt := FWorkbook._XFList.isDateFormat(Cell.FXFIndex);
           end else begin
              isdt := FWorkbook._XFList.isDateFormat(GetXFIndex(Cell.FRow, Cell.FCol, ReplaceIndex));
           end; 
        end;
        if isdt then begin
           if doublevalue >= 1462 then begin
              doublevalue := doublevalue - 1462;
           end else begin
              doublevalue := 0;
           end;
        end;  
     end;
     Result := WriteNumber(Cell.FRow, Cell.FCol, doublevalue, Cell.FXFIndex);
  end else begin
     size := 4 + 4 + 6*count + 2;
     Data := TXLSBlob.Create(size);
     Data.AddWord($00BD);        //Record identifier
     Data.AddWord(size - 4);        //Number of bytes to follow
     Data.AddWord(row);          //row
     Data.AddWord(col);          //col
     for i := 1 to count do begin
         coli := col + i - 1;
         Cell := FCells.GetValue(row, coli); 

         doublevalue := Cell.FDoubleValue;
         if FWorkbook.F1904 then begin
            if Cell.FValueType = xlDateTime then begin
               isdt := true;
            end else begin
               if Cell.FXFIndex > 0 then begin
                  isdt := FWorkbook._XFList.isDateFormat(Cell.FXFIndex);
               end else begin
                  isdt := FWorkbook._XFList.isDateFormat(GetXFIndex(Cell.FRow, Cell.FCol, ReplaceIndex));
               end; 
            end;
            if isdt then begin
               if doublevalue >= 1462 then begin
                  doublevalue := doublevalue - 1462;
               end else begin
                  doublevalue := 0;
               end;
            end;  
         end;

         DoubleToRK(doublevalue, v);
         CheckDimensions(row, coli);
         if Cell.FXFIndex > 0 then 
            lxf := FWorkBook.FXFList.SaveIndex[Cell.FXFIndex] - 1
         else 
            lxf := 0;

         Data.AddWord(lxf);
         Data.AddLong(v);   
     end;   
     Data.AddWord(col + count - 1);
     Result := AppendData(Data, FDataBody);
  end;
end;

function IXLSWorksheet.WriteMulBlank(row: integer; col: integer; count: integer): integer;
var i: integer;
    Cell: TXLSCellRef;
    Data: TXLSBlob;
    lxf: Word;
    coli: integer;
    size: integer;
begin
  if count = 1 then begin
     Cell := FCells.GetValue(row, col);
     Result := Write(Cell.FRow, Cell.FCol, Cell.FXFIndex);
  end else begin
     size := 4 + 4 + 2*count + 2;
     Data := TXLSBlob.Create(size);
     Data.AddWord($00BE);       //Record identifier
     Data.AddWord(size - 4);    //Number of bytes to follow
     Data.AddWord(row);         //row
     Data.AddWord(col);         //col
     for i := 1 to count do begin
         coli := col + i - 1;
         Cell := FCells.GetValue(row, coli); 
         CheckDimensions(row, coli);
         if Cell.FXFIndex > 0 then 
            lxf := FWorkBook.FXFList.SaveIndex[Cell.FXFIndex] - 1
         else 
            lxf := 0;
         Data.AddWord(lxf);
     end;   
     Data.AddWord(col + count - 1);
     Result := AppendData(Data, FDataBody);
  end;
end;


function IXLSWorksheet.WriteNumber(row, col: Word; Value: Double;
  Format: integer): integer;
var DstValue: Longword;
begin
  if DoubleToRK(Value, DstValue) then
     Result := WriteRK(row, col, DstValue, Format)
  else
     Result := WriteDouble(row, col, Value, Format);
end;

function IXLSWorksheet.Close: integer;
Var j: LongWord;
  sz: integer;
  
begin

  //**********************************
  //* Header
  //**********************************
  Result := 1;
  //Append CalculationSettings Block
  if Result = 1 then begin
     Result := StoreCalculationSettings;
  end;

  //Append the autofilter
  if Result = 1 then Result := StoreAutofilter;

  //Append the COLINFO records if they exist
  if Result = 1 then begin
     Result := StoreAllColumnInfo;
  end;


  //Append the RowINFO records if they exist
  if Result = 1 then begin
     Result := StoreAllRowInfo;
  end;

  if FWorkbook.FFileFormat = xlExcel5  then begin
    //Skip in BIFF8 
    //Append the EXTERNCOUNT of external references.
    if Result = 1 then Result := StoreExternCount(FWorkbook.WorkSheets.Count + 1);

    //Append EXTERNSHEET references
    if Result = 1 then begin
       for j := 1 to FWorkBook.Worksheets.Count do begin
          Result := StoreExternSheet(FWorkBook.Worksheets[j].Name);
          if Result <> 1 then Break;
       end;
    end;
    if Result = 1 then begin
       Result := StoreExternBook();
    end;  
  end;

  //Append PRINTHEADERS
  if Result = 1 then Result := StorePrintHeaders;
  //Append PRINTGRIDLINES
  if Result = 1 then Result := StorePrintGridLines;
  //Append GRIDSET
  if Result = 1 then Result := StoreGridSet;

  if Result = 1 then Result := StoreGuts;
  //Append WSBOOL
  if Result = 1 then Result := StoreWSBool;
  //Append the horizontal page breaks
  if Result = 1 then Result := StoreHBreak;
  //Append the vertical page breaks
  if Result = 1 then Result := StoreVBreak;
  //Append the page setup
  if Result = 1 then Result := StoreSetup;
  //Append the sheet protection
  if Result = 1 then Result := StoreProtect;
  //Append the sheet password
  if Result = 1 then Result := StorePassword;

  //Append the autofilter
//  if Result = 1 then Result := StoreAutofilter;
  //Append the sheet dimensions
  if Result = 1 then Result := StoreDimensions;

  //**********************************
  //* End of header
  //**********************************


  //**********************************
  //* PreHeader
  //**********************************

  //Append the BOF record
  if Result = 1 then Result := StoreBof($0010);
  //Append Index
  if Result = 1 then Result := StoreIndex;

  //**********************************
  //* End of PreHeader
  //**********************************



  //**********************************
  //* Data
  //**********************************
  if Result = 1 then Result := StoreDrawing;

  //**********************************
  //* Footer
  //**********************************

  //Append the bottom margin
  if Result = 1 then Result := StoreMarginBottom;
  //Append the top margin
  if Result = 1 then Result := StoreMarginTop;
  //Append the right margin
  if Result = 1 then Result := StoreMarginRight;
  //Append the left margin
  if Result = 1 then Result := StoreMarginLeft;
  //Append the page vertical centering
  if Result = 1 then Result := StoreVCenter;
  //Append the page horizontal centering
  if Result = 1 then Result := StoreHCenter;
  //Append the page footer
  if Result = 1 then Result := StoreFooter;
  //Append the page header
  if Result = 1 then Result := StoreHeader;

  //Append the Window2
  if Result = 1 then Result := StoreWindow2;
  //Append the Zoom
  if Result = 1 then Result := StoreZoom;


  //Append the Panes
  if Result = 1 then begin
    if Assigned(FPanes) then Result := StorePanes(FPanes);
  end;

  //Append the Selection
  if Result = 1 then Result := StoreSelection(FSelection);

  //Append StarndardColWidth
//  if (FWorkbook.FFileFormat = xlExcel5) and (false) then  
     if Result = 1 then Result := AppendData(FColumnInfo.GetDefColInfoBlob, FDataFooter);

  if (FWorkbook.FFileFormat = xlExcel97) then  
     if (Result = 1) and Assigned(FHyperlinks) then 
         Result := FHyperlinks.Store(FDataFooter, FDataSize);

  if (FWorkbook.FFileFormat = xlExcel97) then begin
      if (Assigned(FCondFormatter)) then begin
          sz := FCondFormatter.Store(FDataFooter);
          if sz >= 0 then begin
              FDataSize := FDataSize + longword(sz);
          end else begin
              Result := -1;
          end;
      end;
      if Result = 1 then begin
         if (Assigned(FDataValidator)) then begin
             sz := FDataValidator.Store(FDataFooter);
             if sz >= 0 then begin
                 FDataSize := FDataSize + longword(sz);
             end else begin
                 Result := -1;
             end;
         end;
      end;

  end;

  if Result = 1 then Result := Store01BA(FDataFooter);

  

  //Sheet protection
  if Result = 1 then Result := StoreSheetProtection;

  //Append the Eof
  if Result = 1 then Result := StoreEof;

  //**********************************
  //* End of data
  //**********************************

end;

function IXLSWorksheet.AddContinue(Data: TXLSBlob): TXLSBlob;
Const iRecord =  $003C;
Var   NewSize :  LongWord;
      BlockSize: Word;
      Index:     LongWord;
      SrcSize:   LongWord;
      Cnt:       LongWord;
      FLimit:    LongWord;
begin
  FLimit := FWorkbook.FLimit;
  SrcSize := Data.GetDataSize;
  Cnt := (SrcSize - (FLimit + 4)) div FLimit; //number of full continue records
  NewSize := (Cnt + 1) * (FLimit + 4);
  if ((SrcSize - (FLimit + 4)) mod FLimit) > 0 then 
      NewSize := NewSize + 4 + ((SrcSize - (FLimit + 4)) mod FLimit); 

  Result := TXLSBlob.Create(NewSize);
  Result.CopyData(Data, 0, FLimit + 4);
  Result.SetWord(0, Data.GetWord(0));
  Result.SetWord(2, FLimit);

  Index := FLimit + 4;
  while Index < SrcSize do begin
     Result.AddWord(iRecord);
     if (SrcSize - Index) >= FLimit then BlockSize := FLimit
     else BlockSize := (SrcSize - Index);
     Result.AddWord(BlockSize);
     Result.CopyData(Data, Index, BlockSize);
     Index := Index + BlockSize;
  end;
  Data.Free;
end;


function IXLSWorksheet.AppendData(Data: TXLSBlob; DataList: TXLSBlobList): integer;
begin
  if Assigned(Data) then begin 
     if Data.GetDataSize > (FWorkbook.FLimit + 4) then begin
        Data := AddContinue(Data)
     end;
     FDataSize := FDataSize + Data.GetDataSize;
     Result := DataList.Append(Data);
  end else begin
     Result := 1;
  end;
end;

procedure IXLSWorksheet.ClearDimensions;
begin
  FDimChanged := false;
  FDimRowMin  := -1;
  FDimRowMax  := -1;
  FDimColMin  := -1;
  FDimColMax  := -1;
end;

function IXLSWorksheet.CheckDimensions(Row, Col: integer): integer;
begin
  Result := 1;
  if (Row < 0) or (Col < 0) or (Row > XLSXMaxRow) or (Col > XLSXMaxCol) then
     Result := -2
  else begin
    if (Row < FDimRowMin) or not(FDimChanged) then FDimRowMin := Row;
    if (Row > FDimRowMax) or not(FDimChanged) then FDimRowMax := Row;
    if (Col < FDimColMin) or not(FDimChanged) then FDimColMin := Col;
    if (Col > FDimColMax) or not(FDimChanged) then FDimColMax := Col;
    FDimChanged := true;
  end;
end;

function IXLSWorksheet.StoreDimensions: integer;
Var RowMin, RowMax, ColMin, ColMax: integer;
    Data: TXLSBlob;
    lSize: Word;
begin
  RowMin := FDimRowMin;
  RowMax := FDimRowMax;
  ColMin := FDimColMin;
  ColMax := FDimColMax;

  if FDimChanged and 
     ModifyRangeBiff8(RowMin, ColMin, RowMax, ColMax) then begin
      Inc(RowMax);
      Inc(ColMax);
  end else begin
      RowMin := 0;
      RowMax := 0;
      ColMin := 0;
      ColMax := 256;
  end;

  if FWorkbook.FFileFormat = xlExcel5 then lSize := $000E else lSize := $0012;
  Data := TXLSBlob.Create(lSize);
  Data.AddWord($0200);  //Record identifier
  Data.AddWord(lSize - 4);  //Number of bytes to follow
  if FWorkbook.FFileFormat = xlExcel5 then begin
    Data.AddWord(RowMin);
    Data.AddWord(RowMax);
  end else begin
    Data.AddLong(RowMin);
    Data.AddLong(RowMax);
  end;
  Data.AddWord(ColMin);
  Data.AddWord(ColMax);
  Data.AddWord($0000);  //Reserved
  Result := AppendData(Data, FDataHeader);
end;

function IXLSWorksheet.StoreWindow2: integer;
Var Data: TXLSBlob;
    lSize: Word;
    rwtop, colleft: word;
    grbit: Word; 
begin
   if FWorkbook.FFileFormat = xlExcel5 then lSize := 14 else lSize := 22;
   Data := TXLSBlob.Create(lSize);
   Data.AddWord($023E);     //Record identifier
   Data.AddWord(lSize - 4); //Number of bytes to follow
   grbit := 
                 $0 or                            //fDspFmla
                 ord(FScreenGridLines) shl 1  or  //fDspGrid
                 $1                    shl 2  or  //fDspRwCol
                 ord(FFrozen)          shl 3  or  //fFrozen
                 ord(FDisplayZeros)    shl 4  or  //fDspZeros
                 $1                    shl 5  or  //fDefaultHdr
             ord(FDisplayRightToLeft)  shl 6  or  //fArabic
                 $1                    shl 7  or  //fDspGuts
                 $0                    shl 8  or  //fFrozenNoSplit
                 ord(FSelected)        shl 9;      //fSelected
   if FVisible = xlSheetVisible then  grbit := grbit or (1 shl 10); 

   if FWorkbook.FFileFormat <> xlExcel5 then begin
      if FView <> xlNormalView then grbit := grbit or (1 shl 11);
   end;

   Data.AddWord(grbit);           //grbit

   rwtop := FRowInfo.GetFirstVisible;
   if (rwtop < FScrollRow) or (FScrollRow = 0) then begin
       rwtop := FScrollRow;
   end;

   colleft := FColumnInfo.GetFirstVisible;
   if colleft > 255 then colleft := 0;
   if (colleft < FScrollColumn) or (FScrollColumn = 0) then begin
       colleft := FScrollColumn;
   end;

   Data.AddWord(rwtop);      //rwTop    Top row visible in window
   Data.AddWord(colleft);      //colLeft  Leftmost column visible in window
   if FWorkbook.FFileFormat = xlExcel5 then
      Data.AddLong($00000000)  //Row/column heading and gridline color
   else begin
      Data.AddWord($0040);     {Grid color index (64)}
      Data.AddWord($0000);     {not used}
      Data.AddWord($0000);     {Cached magnification factor 
                                in page break preview (in percent); 
                                0 = Default (60%)}
      Data.AddWord($0000);     {Cached magnification factor 
                                in normal view (in percent); 
                                0 = Default (100%)}
      Data.AddLong($00000000); {not used}
   end;
   Result := AppendData(Data, FDataFooter);
end;

function IXLSWorksheet.StoreSelection(Selection: IXLSRange): integer;
Var Data: TXLSBlob;
    rwFirst, rwLast, colFirst, colLast: integer;
begin
   Result := 1;

   rwFirst  := Selection.FirstRow;
   rwLast   := Selection.LastRow;
   colFirst := Selection.FirstCol;
   colLast  := Selection.LastCol;

   if ModifyRangeBIFF8(rwFirst, colFirst, rwLast, colLast) then begin
      Data := TXLSBlob.Create(19);
      Data.AddWord($001D);  //Record identifier
      Data.AddWord($000F);  //Number of bytes to follow
      Data.AddByte(FActivePane);
      Data.AddWord(rwFirst);   //RwAct Active row
      Data.AddWord(colFirst);  //ColAct Active column
      Data.AddWord($0000);               //irefAct Active cell ref
      Data.AddWord($0001);               //cref Number of ref
      Data.AddWord(rwFirst);
      Data.AddWord(rwLast);
      Data.AddByte(colFirst);
      Data.AddByte(colLast);
      Result := AppendData(Data, FDataFooter);
   end;
end;

function IXLSWorksheet.StoreAutofilter: integer;
Var Data: TXLSBlob;
begin
  Result := 1;

  Data := FAutofilter.GetDataFilterMode(FWorkbook.FFileFormat);
  AppendData(Data, FDataHeader);

  Data := FAutofilter.GetData(FWorkbook.FFileFormat);
  if Assigned(Data) then begin
     Result := AppendData(Data, FDataHeader);
     if Result = 1 then begin
        Result := FAutofilter.AddAutofilterData(FDataHeader, FDataSize, FWorkbook.FFileFormat);  
     end;
  end; 
end;


function IXLSWorksheet.StoreExternCount(Count: Word): integer;
Var Data: TXLSBlob;
begin
  Data := TXLSBlob.Create(6);
  Data.AddWord($0016);        //Record
  Data.AddWord($0002);        //Length
  Data.AddWord(Count);        //ExternCount
  Result := AppendData(Data, FDataHeader);
end;

function IXLSWorksheet.StoreExternSheet(SheetName: widestring): integer;
Var Data: TXLSBlob;
    iLength, cch, rgch: Word;
begin
   //References to the current sheet are encoded differently to references to
   //external sheets.
   if Name = SheetName then begin
      SheetName := '';
      iLength := 2;     //0x02 The following 2 bytes
      cch := 1;         //The following byte
      rgch := $02;      //Self reference
   end
   else begin
     cch := Length(SheetName);
     iLength := 2 + cch;
     rgch   := $03;     //Reference to a sheet in the current workbook
   end;
  Data := TXLSBlob.Create(iLength + 4);
  Data.AddWord($0017);        //Record
  Data.AddWord(iLength);        //Length
  Data.AddByte(cch);
  Data.AddByte(rgch);
  if Length(SheetName) > 0 then Data.AddString(AnsiString(SheetName));
  Result := AppendData(Data, FDataHeader);
end;

function IXLSWorksheet.StoreExternBook(): integer;
Var lData: TXLSBlob;
begin
  lData := TXLSBlob.Create(6);
  lData.AddWord($0017);   //Record identifier
  lData.AddWord($0002);   //Length
  lData.AddByte($01);     //cch Length of sheet name
  lData.AddByte($04);     //rgch Filename encoding
  Result := AppendData(lData, FDataHeader);
end;


function IXLSWorksheet.StoreFooter: integer;
Var Data: TXLSBlob;
    cch: Word;
    FFooter: widestring;
    lSize: LongWord;
begin
  FFooter := '';
  if PageSetup.LeftFooter <> '' then
     FFooter := FFooter + '&L' + PageSetup.LeftFooter;
  if PageSetup.CenterFooter <> '' then
     FFooter := FFooter + '&C' + PageSetup.CenterFooter;
  if PageSetup.RightFooter <> '' then
     FFooter := FFooter + '&R' + PageSetup.RightFooter;
  cch := Length(FFooter);
  if FWorkbook.FFileFormat = xlExcel5 then lSize := 4 + 1 + cch
     else lSize := 4 + 3 + cch * 2;
  Data := TXLSBlob.Create(lSize);
  Data.AddWord($0015);        //Record
  Data.AddWord(lSize - 4);      //Length
  if FWorkbook.FFileFormat = xlExcel5 then begin
     Data.AddByte(cch);
     Data.AddString(AnsiString(FFooter));
  end else begin
     Data.AddWord(cch);
     Data.AddByte($01);
     Data.AddWideString(FFooter);
  end;
  Result := AppendData(Data, FDataFooter);
end;

function  IXLSWorksheet.StoreDrawing: integer;
Var Encrypt: boolean;
begin
  Result := 1;
  if FWorkbook.FFileFormat >= xlExcel97 then begin
     Encrypt := FWorkbook.FProtect.IsProtected and FWorkbook.FProtect.IsPassword;
     Result := FDrawing.Store(FDataComment, FWorkbook.FLimit, Encrypt);
  end;

  if Result = 1 then begin
     Result := FDrawing.StoreNotes(FDataComment, FWorkbook.FBiffVersion);
  end;

  FDataSize := FDataSize + FDataComment.TotalSize;
end;

function IXLSWorksheet.StoreGridSet: integer;
Var Data: TXLSBlob;
begin
  Data := TXLSBlob.Create(6);
  Data.AddWord($0082);        //Record identifier
  Data.AddWord($0002);        //Number of bytes to follow
  Data.AddWord(ord(not(PageSetup.PrintGridlines)));
  Result := AppendData(Data, FDataHeader);
end;

function IXLSWorksheet.StoreGuts: integer;
Var Data: TXLSBlob;
begin
  Data := TXLSBlob.Create(12);
  Data.AddWord($0080);        //Record identifier
  Data.AddWord($0008);        //Number of bytes to follow

  Data.AddWord(FRowInfo.MaxOutlineLevel * $1D);
  Data.AddWord(FColumnInfo.MaxOutlineLevel * $1D);

  if FRowInfo.MaxOutlineLevel > 0 then
     Data.AddWord(FRowInfo.MaxOutlineLevel + 1)
  else
     Data.AddWord($0000);

  if FColumnInfo.MaxOutlineLevel > 0 then
     Data.AddWord(FColumnInfo.MaxOutlineLevel + 1)
  else
     Data.AddWord($0000);

  Result := AppendData(Data, FDataHeader);
end;


function IXLSWorksheet.StoreHBreak: integer;
Var Data: TXLSBlob;
    cbrk: Word;
    i, cnt: integer;
    lSize: LongWord;
begin
  Result := 1;
  cnt := HPageBreaks.Count;
  cbrk := 0;
  if cnt > 0 then begin
     for i := 1 to cnt do begin
        if HPageBreaks.Item[i].FPosition > XLSMaxRow then begin
           break;
        end;
        cbrk := i;
     end;
  end;

  if cbrk > 0 then begin
     if FWorkbook.FFileFormat = xlExcel5 then lSize := 6 + cbrk * 2
        else lSize := 6 + cbrk * 6;     
     Data := TXLSBlob.Create(lSize);
     Data.AddWord($001B);        //Record identifier
     Data.AddWord(lSize - 4);    //Number of bytes to follow
     Data.AddWord(cbrk);         //cbrk
     for i := 1 to cbrk do begin
        Data.AddWord(HPageBreaks.Item[i].FPosition);
        if FWorkbook.FFileFormat <> xlExcel5 then begin
           Data.AddWord(0);
           Data.AddWord(255);
        end;
     end;
     Result := AppendData(Data, FDataHeader);
  end;
end;

function IXLSWorksheet.StoreHcenter: integer;
Var Data: TXLSBlob;
begin
  Data := TXLSBlob.Create(6);
  Data.AddWord($0083);        //Record
  Data.AddWord(2);           //Length
  Data.AddWord(ord(PageSetup.CenterHorizontally));
  Result := AppendData(Data, FDataFooter);
end;

function  IXLSWorksheet.StoreIndex: integer;
Var Data: TXLSBlob;
    DataBodyOffset: longword;
    Size: longword; 
begin
  Result := 1;
  DataBodyOffset := FOffset + FDataHeader.TotalSize + FDataPreHeader.TotalSize;
  Size := FDBCellIndex.GetDataSize(FWorkbook.FFileFormat);
  if Size > 0 then begin
     DataBodyOffset := DataBodyOffset + Size;
     Data := FDBCellIndex.GetData(FWorkbook.FFileFormat, DataBodyOffset);
     Result := AppendData(Data, FDataPreHeader);
  end;
end;

function IXLSWorksheet.StoreHeader: integer;
Var Data: TXLSBlob;
    cch: Word;
    FHeader: widestring;
    lSize: Word;
begin
  FHeader := '';
  if PageSetup.LeftHeader <> '' then
     FHeader := FHeader + '&L' + PageSetup.LeftHeader;
  if PageSetup.CenterHeader <> '' then
     FHeader := FHeader + '&C' + PageSetup.CenterHeader;
  if PageSetup.RightHeader <> '' then
     FHeader := FHeader + '&R' + PageSetup.RightHeader;
  cch := Length(FHeader);
  if FWorkbook.FFileFormat = xlExcel5 then lSize := 4 + 1 + cch
     else lSize := 4 + 3 + cch * 2;
  Data := TXLSBlob.Create(lSize);
  Data.AddWord($0014);        //Record
  Data.AddWord(lSize - 4);      //Length
  if FWorkbook.FFileFormat = xlExcel5 then begin
     Data.AddByte(cch);
     Data.AddString(AnsiString(FHeader));
  end else begin
     Data.AddWord(cch);
     Data.AddByte($01);
     Data.AddWideString(FHeader);
  end;
  Result := AppendData(Data, FDataFooter);
end;

function IXLSWorksheet.StoreMarginBottom: integer;
Var Data: TXLSBlob;
begin
  Data := TXLSBlob.Create(12);
  Data.AddWord($0029);        //Record
  Data.AddWord(8);           //Length
  Data.AddDouble(PageSetup.BottomMargin);
  Result := AppendData(Data, FDataFooter);
end;

function IXLSWorksheet.StoreMarginLeft: integer;
Var Data: TXLSBlob;
begin
  Data := TXLSBlob.Create(12);
  Data.AddWord($0026);        //Record
  Data.AddWord(8);           //Length
  Data.AddDouble(PageSetup.LeftMargin);
  Result := AppendData(Data, FDataFooter);
end;

function IXLSWorksheet.StoreMarginRight: integer;
Var Data: TXLSBlob;
begin
  Data := TXLSBlob.Create(12);
  Data.AddWord($0027);        //Record
  Data.AddWord(8);           //Length
  Data.AddDouble(PageSetup.RightMargin);
  Result := AppendData(Data, FDataFooter);
end;

function IXLSWorksheet.StoreMarginTop: integer;
Var Data: TXLSBlob;
begin
  Data := TXLSBlob.Create(12);
  Data.AddWord($0028);        //Record
  Data.AddWord(8);           //Length
  Data.AddDouble(PageSetup.TopMargin);
  Result := AppendData(Data, FDataFooter);
end;

function IXLSWorksheet.StorePanes(Panes: TXLSPanes): integer;
Var Data: TXLSBlob;
    y, x, rwTop, colLeft, pnnAct: Word;
begin
  //Code specific to frozen or thawed panes.
  if FFrozen then begin
     //Set default values for rwTop and colLeft
     y := Round(Panes.Y);
     x := Round(Panes.X);

     if Panes.RowTop >= 0 then begin
          if Panes.RowTop > XLSMaxRow then rwTop := XLSMaxRow 
                                      else rwTop := Panes.RowTop;
     end else begin
          rwTop := y;
     end;

     if Panes.ColLeft >= 0 then begin
         if Panes.ColLeft > XLSMaxCol then colLeft := XLSMaxCol
                                      else colLeft := Panes.ColLeft;
     end else begin 
         colLeft := x;
     end;
  end else begin
     //Set default values for rwTop and colLeft
     if Panes.RowTop >= 0 then begin
        if Panes.RowTop > XLSMaxRow then rwTop := XLSMaxRow 
                                    else rwTop := Panes.RowTop;
     end else begin
        rwTop := 0;
     end;

     if Panes.ColLeft >= 0 then begin
         if Panes.ColLeft > XLSMaxCol then colLeft := XLSMaxCol
                                      else colLeft := Panes.ColLeft;
     end else begin 
         colLeft := 0;
     end;
     //Convert Excel's row and column units to the internal units.
     //The default row height is 12.75
     //The default column width is 8.43
     //The following slope and intersection values were interpolated
     if (Panes.y > 0) or (Panes.x > 0) then begin
       y := Round(20 * Panes.y + 255);
       x := Round(113.879 * Panes.x + 390);
     end else begin
       x := 0;
       y := 0;
     end;
  end;

  // Determine which pane should be active. There is also the undocumented
  // option to override this should it be necessary: may be removed later.
  if (x <> 0) and (y <> 0)  then pnnAct := 0       //Bottom right
  else if (x <> 0) and (y = 0)   then pnnAct := 1  //Top right
  else if (x = 0)  and (y <> 0)  then pnnAct := 2  //Bottom left
  else pnnAct := 3;                                //Top left
  FActivePane := pnnAct; //Used in _store_selection

  Data := TXLSBlob.Create(14);
  Data.AddWord($0041);        //Record
  Data.AddWord($000A);        //Length
  Data.AddWord(x);            //Horizontal split position
  Data.AddWord(y);            //Vertical split position
  Data.AddWord(rwTop);        //Top row visible
  Data.AddWord(colLeft);      //Leftmost column visible
  Data.AddWord(pnnAct);       //Active pane
  Result := AppendData(Data, FDataFooter);
end;


function IXLSWorksheet.GetIsProtected: boolean;
begin 
  Result := FProtect.IsProtected;
end;

function IXLSWorksheet.GetNames: IXLSNames;
begin 
  Result := TXLSNames.Create(FWorkbook._Names.GetOrCreateChild(FSheetID));
end;

function IXLSWorksheet.StorePassword: integer;
Var Data: TXLSBlob;
    wPassword: Word;
begin
  Result := 1;
  if FProtect.IsProtected then begin
     wPassword := FProtect.EncodedPassword;
     Data := TXLSBlob.Create(6);
     Data.AddWord($0013);        //Record identifier
     Data.AddWord($0002);        //Number of bytes to follow
     Data.AddWord(wPassword);
     Result := AppendData(Data, FDataHeader);
  end;
end;

function IXLSWorksheet.StorePrintGridLines: integer;
Var Data: TXLSBlob;
begin
  Data := TXLSBlob.Create(6);
  Data.AddWord($002B);        //Record identifier
  Data.AddWord($0002);        //Number of bytes to follow
  Data.AddWord(ord(PageSetup.PrintGridlines));
  Result := AppendData(Data, FDataHeader);
end;

function IXLSWorksheet.StorePrintHeaders: integer;
Var Data: TXLSBlob;
begin
  Data := TXLSBlob.Create(6);
  Data.AddWord($002A);        //Record
  Data.AddWord($0002);        //Length
  Data.AddWord(ord(PageSetup.PrintHeadings));
  Result := AppendData(Data, FDataHeader);
end;

function IXLSWorksheet.StoreProtect: integer;
Var Data: TXLSBlob;
begin
  Result := 1;
  if FProtect.isProtected then begin
     Data := TXLSBlob.Create(6);
     Data.AddWord($0012);        //Record identifier
     Data.AddWord($0002);        //Number of bytes to follow
     Data.AddWord(1);            //fLock
     Result := AppendData(Data, FDataHeader);

     if Result = 1 then begin
        //Scen protect 
        Data := TXLSBlob.Create(6);
        Data.AddWord($00DD);        //Record identifier
        Data.AddWord($0002);        //Number of bytes to follow
        Data.AddWord(((FProtect.FOptions shl 1) and 1) xor 1); //Protect 
        Result := AppendData(Data, FDataHeader);
     end;

     if Result = 1 then begin
        //Object protect 
        Data := TXLSBlob.Create(6);
        Data.AddWord($0063);        //Record identifier
        Data.AddWord($0002);        //Number of bytes to follow
        Data.AddWord(((FProtect.FOptions shl 0) and 1) xor 1);            //Protect 
        Result := AppendData(Data, FDataHeader);
     end;

  end;
end;


function IXLSWorksheet.StoreSheetProtection: integer;
Var Data: TXLSBlob;
begin
  Result := 1;
  if FProtect.isProtected then begin

     if (Result = 1) and (FWorkbook.FFileFormat = xlExcel97) then begin
        //SheetProtect 
        Data := TXLSBlob.Create(23 + 4);
        Data.AddWord($0867);        //Record identifier
        Data.AddWord(23);           //Number of bytes to follow
        Data.AddWord($0867);        //Record identifier

        Data.AddLong(0);Data.AddLong(0);Data.AddByte(0); //not used

        //unknown 
        Data.AddByte($00);  Data.AddByte($02); 
        Data.AddByte($00);  Data.AddByte($01);
        Data.AddByte($FF);  Data.AddByte($FF);
        Data.AddByte($FF);  Data.AddByte($FF);
           
        Data.AddWord(FProtect.FOptions); //Options 
        Data.AddWord(0); //not used

        Result := AppendData(Data, FDataFooter);
     end;
  end;
end;


function IXLSWorksheet.StoreSetup: integer;
Var Data: TXLSBlob;
    opt: Word;
begin
  Data := TXLSBlob.Create(38);
  Data.AddWord($00A1);        //Record
  Data.AddWord($0022);        //Length
  Data.AddWord(FPageSetup.FPaperSize);
  Data.AddWord(FPageSetup.FZoom);
  Data.AddWord($0001);        //iPageStart 
  Data.AddWord(FPageSetup.FFitToPagesWide);
  Data.AddWord(FPageSetup.FFitToPagesTall);
  opt :=         (FPageSetup.FOrder and $01) shl 0  or   // 0 - Print over then down 
                 FPageSetup.FOrientation     shl 1  or   // page orientation
                 $0            shl 2  or   //fNoPls   Setup not read from printer
                 $0            shl 3  or   //fNoColor Print black and white
                 $0            shl 4  or   //fDraft   Print draft quality
                 $0            shl 5  or   //fNotes   Print notes
                 $0            shl 6  or   //fNoOrient Orientation not set
                 $0            shl 7 ;    //fUsePage  Use custom starting page
  if (FPageSetup.FBlackAndWhite) then opt := opt or (1 shl 3);               
  if (FPageSetup.FDraft) then opt := opt or (1 shl 4);               
  if (FPageSetup.FPrintNotes) then opt := opt or (1 shl 5);               

  Data.AddWord( opt);              //grbit
  Data.AddWord($0258);      //Print resolution
  Data.AddWord($0258);      //Vertical print resolution
  Data.AddDouble(PageSetup.HeaderMargin);
  Data.AddDouble(PageSetup.FooterMargin);
  Data.AddWord($0001);      //Number of copies
  Result := AppendData(Data, FDataHeader);
end;

function IXLSWorksheet.StoreVBreak: integer;
Var Data: TXLSBlob;
    cbrk: Word;
    lSize: LongWord;
    i, cnt: integer;
begin
  Result := 1;
  cnt := VPageBreaks.Count;
  cbrk := 0;
  if cnt > 0 then begin
     for i := 1 to cnt do begin
        if VPageBreaks.Item[i].FPosition > XLSMaxCol then begin
           break;
        end;
        cbrk := i; 
     end;
  end;

  if cbrk > 0 then begin
     if FWorkbook.FFileFormat = xlExcel5 then lSize := 6 + cbrk * 2
                                         else lSize := 6 + cbrk * 6;

     Data := TXLSBlob.Create(lSize);
     Data.AddWord($001A);        //Record identifier
     Data.AddWord(lSize - 4);    //Number of bytes to follow
     Data.AddWord(cbrk);         //cbrk
     for i := 1 to cbrk do begin
        Data.AddWord(VPageBreaks.Item[i].FPosition);
        if FWorkbook.FFileFormat <> xlExcel5 then begin
           Data.AddWord(0);
           Data.AddWord(65535);
        end;
     end;
     Result := AppendData(Data, FDataHeader);
  end;
end;

function IXLSWorksheet.StoreVcenter: integer;
Var Data: TXLSBlob;
begin
  Data := TXLSBlob.Create(6);
  Data.AddWord($0084);        //Record
  Data.AddWord(2);           //Length
  Data.AddWord(ord(PageSetup.CenterVertically));
  Result := AppendData(Data, FDataFooter);
end;

function IXLSWorksheet.MergeCells(FirstRow, FirstCol, LastRow,
  LastCol: integer): integer;
Var rwFirst, colFirst, rwLast, colLast: Word;
    Data: TXLSBlob;
begin
   rwFirst  := FirstRow;
   colFirst := FirstCol;
   rwLast   := LastRow;
   colLast  := LastCol;
   Result := 1;

   if (rwFirst = rwLast) and (colFirst = colLast) then
      exit;
   if Result = 1 then begin
     if rwFirst > rwLast then begin
        rwFirst  := LastRow;
        rwLast   := FirstRow;
     end;

     if colFirst > colLast then begin
        colFirst  := LastCol;
        colLast   := FirstCol;
     end;

     Data := TXLSBlob.Create(14);
     Data.AddWord($00E5);        //Record
     Data.AddWord($000A);           //Length
     Data.AddWord($0001);        //clref
     Data.AddWord(rwFirst);
     Data.AddWord(rwLast);
     Data.AddWord(colFirst);
     Data.AddWord(colLast);
     Result := AppendData(Data, FDataBody);
   end;
end;

function IXLSWorksheet.StoreWsbool: integer;
Var Data: TXLSBlob;
    grbit: Word;
begin
  //The only option that is of interest is the flag for fit to page. So we
  //set all the options in one go.
  grbit := $0401; 

  if Outline.SummaryRow = xlBelow then grbit := grbit or $0040;
  if Outline.SummaryColumn = xlRight then grbit := grbit or $0080;

  if PageSetup.Zoom = false then grbit := grbit or $0100; 
  Data := TXLSBlob.Create(6);
  Data.AddWord($0081);        //Record identifier
  Data.AddWord($0002);        //Number of bytes to follow
  Data.AddWord(grbit);
  Result := AppendData(Data, FDataHeader);
end;
function IXLSWorksheet.Store01BA(DList: TXLSBlobList): integer;
Var Data: TXLSBlob;
    Size: integer;
begin
  Result := 1;
  if Assigned(Workbook.FVBA) and (Workbook.FFileFormat = Workbook.FOriginalFileFormat) and 
     (FVBAObjectName <> '') then begin
     Size := Length(FVBAObjectName) * 2 + 3 + 4;
     Data := TXLSBlob.Create(Size);
     Data.AddWord($01BA);        //Record identifier
     Data.AddWord(Size - 4);      //Number of bytes to follow
     Data.AddWord(Length(FVBAObjectName));
     Data.AddByte($01);
     Data.AddWideString(FVBAObjectName);
     Result := AppendData(Data, DList);
  end;
end;



function IXLSWorksheet.StoreChart: integer;
begin
  Result := 1;
  FChart.Store(FDataBody, FWorkbook.FFileFormat);
end;
 


function IXLSWorksheet.Store: integer;
begin
  FDBCellIndex := TXLSDBCellIndex.Create;

  ClearDimensions;
  FRowInfo.MaxOutlineLevel := 0;
  StoreCells;
  Close;

  FDBCellIndex.Free;
  FDBCellIndex := nil;

  Result := 1; 
end;



function IXLSWorksheet.StoreCells: integer;
Var Cell, CellNext: TXLSCellRef;

    rk_col, rk_row, rk_cnt: integer;
    blank_col, blank_row, blank_cnt: integer;
    rowmin, rowmax: integer;
    row: integer;  
 
    dbcell: TXLSDBCell; 
    doublevalue: double;
    ReplaceIndex: boolean;
    isdt: boolean;

    procedure CommitRk();
    begin
       if rk_cnt > 0 then begin
          WriteMulRk(rk_row, rk_col, rk_cnt);
          rk_cnt := 0; 
          rk_col := 0;
          rk_row := 0;
       end;
    end;

    procedure CommitBlank();
    begin
       if blank_cnt > 0 then begin
          WriteMulBlank(blank_row, blank_col, blank_cnt);
          blank_cnt := 0; 
          blank_col := 0;
          blank_row := 0;
       end;
    end;
  
    procedure AddRk(row: integer; col: integer);
    begin
       if rk_cnt > 0 then begin
          inc(rk_cnt); 
       end else begin
          rk_cnt := 1;
          rk_col := col;
          rk_row := row; 
       end;
    end;

    procedure AddBlank(row: integer; col: integer);
    begin
       if blank_cnt > 0 then begin
          inc(blank_cnt); 
       end else begin
          blank_cnt := 1;
          blank_col := col;
          blank_row := row; 
       end;
    end;

    procedure StartRowBlock(AFirstRow: integer);
    begin
      dbcell := TXLSDBCell.Create(AFirstRow, FDataBody.TotalSize); 
      StoreRowInfo(AFirstRow, AFirstRow + 31);
    end;

    procedure FinalRowBlock(ALastRow: integer);
    Var data: TXLSBlob;
    begin
      dbcell.FinalRowBlock(ALastRow, FDataBody.TotalSize);
      data := dbcell.GetData(FWorkbook.FFileFormat);

      FDBCellIndex.RegisterRowBlock( dbcell.BookmarkFirstRow, 
                                     dbcell.BookmarkLastRow, 
                                     FDataBody.TotalSize);
      AppendData(Data, FDataBody);
      dbcell.Free;
      dbcell := nil; 
    end;

    procedure AddRowBookmark(ARow: integer);
    begin
      dbcell.AddRowBookmark(ARow, FDataBody.TotalSize);
    end;
    
begin
  Result := 1;
  rk_cnt := 0;
  blank_cnt := 0;
  doublevalue := 0;

  rowmin := FRowInfo.MinRow;
  rowmax := FRowInfo.MaxRow;

  if rowmin > XLSMaxRow then exit;
  if rowmax > XLSMaxRow then rowmax := XLSMaxRow;

  for row := rowmin to rowmax do begin
     
      if (((row - rowmin) and $1F) = $00) and
         (row >= rowmin      ) and 
         (row <= rowmax      ) then begin
         //start new rowblock
         StartRowBlock(row); 
      end;

      if Assigned(FRowInfo.Rows[row]) then begin
         AddRowBookmark(row);   
      end; 
      Cell := FCells.GetFirstRowCell(row);
      if Assigned(Cell) then begin
         if Cell.Col > XLSMaxCol then Cell := nil;
      end;

      while Assigned(Cell) do begin

         if (Cell.FValueType = xlDoubleNumber) or 
            (Cell.FValueType = xlDateTime) then begin
            doublevalue := Cell.FDoubleValue;
            if FWorkbook.F1904 then begin
               if Cell.FValueType = xlDateTime then begin
                  isdt := true;
               end else begin
                  if Cell.FXFIndex > 0 then begin
                     isdt := FWorkbook._XFList.isDateFormat(Cell.FXFIndex);
                  end else begin
                     isdt := FWorkbook._XFList.isDateFormat(GetXFIndex(Cell.FRow, Cell.FCol, ReplaceIndex));
                  end; 
               end;
               if isdt then begin
                  if doublevalue >= 1462 then begin
                     doublevalue := doublevalue - 1462;
                  end else begin
                     doublevalue := 0;
                  end;
               end;  
            end;
         end;

         if Cell.Merged then begin
            CommitRk();
            CommitBlank();
            if Cell.FMergeCell = Cell then begin

               case Cell.FValueType of
                  xlString: MergeWriteString(Cell.FRow, Cell.FCol,
                                             Cell.FRow + Cell.FMergeRowCount - 1,
                                             Cell.FCol + Cell.FMergeColCount - 1, 
                                             Cell.FStringIndex, 
                                             Cell.FXFIndex);
                  xlDoubleNumber: MergeWriteNumber(Cell.FRow, Cell.FCol,
                                             Cell.FRow + Cell.FMergeRowCount - 1,
                                             Cell.FCol + Cell.FMergeColCount - 1, doublevalue, Cell.FXFIndex);
                  xlBoolean: MergeWriteBoolean(Cell.FRow, Cell.FCol,
                                             Cell.FRow + Cell.FMergeRowCount - 1,
                                             Cell.FCol + Cell.FMergeColCount - 1, (Cell.FDoubleValue > 0), Cell.FXFIndex);
                  xlDateTime: MergeWriteDouble(Cell.FRow, Cell.FCol,
                                             Cell.FRow + Cell.FMergeRowCount - 1,
                                             Cell.FCol + Cell.FMergeColCount - 1, doublevalue, Cell.FXFIndex);
                  xlEmpty: MergeWrite(Cell.FRow, Cell.FCol,
                                             Cell.FRow + Cell.FMergeRowCount - 1,
                                             Cell.FCol + Cell.FMergeColCount - 1, Cell.FXFIndex);
                  xlFormula: //implement
                           MergeWriteFormula(Cell.FRow, Cell.FCol,
                                             Cell.FRow + Cell.FMergeRowCount - 1,
                                             Cell.FCol + Cell.FMergeColCount - 1, Cell.FCompiledFormula, Cell.FXFIndex);
               end;
            end;
         end else begin
           if Cell.FValueType = xlDoubleNumber then begin
              CommitBlank();
              if DoubleIsRk(doublevalue) then begin
                 AddRk(Cell.FRow, Cell.FCol);
              end else begin
                 CommitRk();
                 WriteDouble( Cell.FRow, Cell.FCol, doublevalue, Cell.FXFIndex);
              end;
           end else if Cell.FValueType = xlEmpty then begin
              CommitRk();
              AddBlank(Cell.FRow, Cell.FCol);
           end else begin
              CommitRk();
              CommitBlank();
              case Cell.FValueType of
                 xlString:       WriteString( Cell.FRow, Cell.FCol, Cell.FStringIndex, Cell.FXFIndex);
                 xlDateTime:     WriteDouble( Cell.FRow, Cell.FCol, doublevalue, Cell.FXFIndex);
                 xlBoolean:      WriteBoolean( Cell.FRow, Cell.FCol, (Cell.FDoubleValue > 0), Cell.FXFIndex);
                 xlFormula:      WriteFormula(Cell.FRow, Cell.FCol, Cell.FCompiledFormula, Cell.FXFIndex);//implement
              end;
           end;
         end;
                     
         CellNext := FCells.GetNextRowCell(Cell);
         if Assigned(CellNext) then begin
            if CellNext.Col > XLSMaxCol then CellNext := nil;
         end;

         if Not(Assigned(CellNext)) then begin
               CommitRk();
               CommitBlank();
         end else begin
            if Cell.Col <> (CellNext.Col - 1) then begin
               CommitRk();
               CommitBlank();
            end;
         end;
         Cell := CellNext;
      end;

      if (row = rowmax) or 
         ((((row - rowmin) and $1F) = $1F) and 
          (row >= rowmin      ) and 
          (row <= rowmax      )) then begin
        //final rowblock
        FinalRowBlock(row); 
      end;
   end;

   Result := 1;
end;


function IXLSWorksheet.StoreZoom: integer;
Var Data: TXLSBlob;
begin
  Result := 1;
  //If scale is 100 we don't need to write a record
  if FZoom <> 100 then begin
     Data := TXLSBlob.Create(8);
     Data.AddWord($00A0);        //Record identifier
     Data.AddWord($0004);        //Number of bytes to follow
     Data.AddWord(FZoom);        //Zoom
     Data.AddWord(100);
     Result := AppendData(Data, FDataFooter);
  end;
end;

function IXLSWorksheet.StoreBof(BofType: Word): integer;
Var lData: TXLSBlob;
    lSize: Word;
begin
  // Excel BOF record
  // BofType = 5  for workbook
  // BofType = 61 for  worksheet
  if FWorkbook.FFileFormat = xlExcel5 then lSize := $0008 else lSize := $0010;
  lData := TXLSBlob.Create(lSize + 4);

  lData.AddWord($0809);        //Record
  lData.AddWord(lSize);        //Length
  lData.AddWord(FWorkbook.FBiffVersion);
  lData.AddWord(BofType);

  if FWorkbook.FFileFormat = xlExcel5 then begin
     // According to the SDK Build and Year should be set to zero.
     // However, this throws a warning in Excel 5. So, use these
     // magic numbers.
     lData.AddWord($096C);     //build
     lData.AddWord(1993);      //year
  end else begin
     // According to the SDK Build and Year should be set to zero.
     // However, this throws a warning in Excel 97. So, use these
     // magic numbers.
     lData.AddWord($18AF);     //build
//     lData.AddWord($1EDE);     //build
     lData.AddWord(1997);      //year
//     lData.AddLong($00004041); //HistoryFlag
     lData.AddLong($000080C9); //HistoryFlag
//     lData.AddLong($00000009); //HistoryFlag
     lData.AddLong($00000106); //Lowest Excel version that can read all records in this file
  end;
  Result := AppendData(lData, FDataPreHeader);
end;

function IXLSWorksheet.StoreEof: integer;
Var Data: TXLSBlob;
begin
  Data := TXLSBlob.Create(4);
  Data.AddWord($000A);        //Record identifier
  Data.AddWord($0000);        //Length
  Result := AppendData(Data, FDataFooter);
end;

function IXLSWorksheet.WriteBoolean(row, col: Word; Value: Boolean;
  Format: integer): integer;
Var Data: TXLSBlob;
    lxf: Word;
begin
  Result := 1;
  if CheckDimensions(row, col) <> 1 then Result := -2;
  if Result = 1 then begin
     if Format > 0 then lxf := FWorkBook.FXFList.SaveIndex[Format] - 1
       else lxf := 0;

     Data := TXLSBlob.Create(18);
     Data.AddWord($0205);        //Record identifier
     Data.AddWord($0008);        //Number of bytes to follow
     Data.AddWord(Row);          //row
     Data.AddWord(Col);          //col
     Data.AddWord(lxf);          //xf
     Data.AddByte(Ord(Value));   //Value
     Data.AddByte(0); 
     Result := AppendData(Data, FDataBody);
  end;
end;

function IXLSWorksheet.WriteDouble(row, col: Word; Value: Double;
  Format: integer): integer;
Var Data: TXLSBlob;
    lxf: Word;
begin
  Result := 1;
  if CheckDimensions(row, col) <> 1 then Result := -2;
  if Result = 1 then begin
     if Format > 0 then lxf := FWorkBook.FXFList.SaveIndex[Format] - 1
       else lxf := 0;

     Data := TXLSBlob.Create(18);
     Data.AddWord($0203);        //Record identifier
     Data.AddWord($000E);        //Number of bytes to follow
     Data.AddWord(Row);          //row
     Data.AddWord(Col);          //col
     Data.AddWord(lxf);           //xf
     Data.AddDouble(Value);      //Value
     Result := AppendData(Data, FDataBody);
  end;
end;

function IXLSWorksheet.MergeWriteDouble(FirstRow, FirstCol, LastRow,
  LastCol: integer; Value: Double; Format: integer): integer;
Var rwFirst, rwLast, colFirst, colLast: integer;
    i, j: Word;
    Cell: TXLSCellRef;
begin
  Result := 1;
  rwFirst  := FirstRow;
  colFirst := FirstCol;
  rwLast   := LastRow;
  colLast  := LastCol;

  if Result = 1 then begin
    if rwFirst > rwLast then begin
       rwFirst  := LastRow;
       rwLast   := FirstRow;
    end;

    if colFirst > colLast then begin
       colFirst  := LastCol;
       colLast   := FirstCol;
    end;

    if rwLast > XLSMaxRow then rwLast := XLSMaxRow;
    if colLast > XLSMaxCol then colLast := XLSMaxCol;
  end;

  //Write the first cell
  if Result = 1 then Result := WriteDouble(rwFirst, colFirst, Value, Format);

  if Result = 1 then begin
    //Pad out the rest of the area with formatted blank cells
    for i := rwFirst to rwLast do begin
      for j := colFirst to colLast do begin
          if (i = rwFirst) and (j = colFirst) then continue;
          Cell := FCells.GetValue(i, j);
          if Assigned(Cell) then
              Result := Write(i, j, Cell.FXFIndex)
          else
              Result := Write(i, j, Format);
          if Result <> 1 then Break;
      end;
      if Result <> 1 then Break;
    end;
  end;
  if Result = 1 then Result := MergeCells(rwFirst, colFirst, rwLast, colLast);
end;


function IXLSWorksheet.MergeWriteBoolean(FirstRow, FirstCol, LastRow,
  LastCol: integer; Value: Boolean; Format: integer): integer;
Var rwFirst, rwLast, colFirst, colLast: integer;
    i, j: Word;
    Cell: TXLSCellRef;
begin
  Result := 1;
  rwFirst  := FirstRow;
  colFirst := FirstCol;
  rwLast   := LastRow;
  colLast  := LastCol;

  if Result = 1 then begin
    if rwFirst > rwLast then begin
       rwFirst  := LastRow;
       rwLast   := FirstRow;
    end;

    if colFirst > colLast then begin
       colFirst  := LastCol;
       colLast   := FirstCol;
    end;

    if rwLast > XLSMaxRow then rwLast := XLSMaxRow;
    if colLast > XLSMaxCol then colLast := XLSMaxCol;
  end;

  //Write the first cell
  if Result = 1 then Result := WriteBoolean(rwFirst, colFirst, Value, Format);

  if Result = 1 then begin
    //Pad out the rest of the area with formatted blank cells
    for i := rwFirst to rwLast do begin
      for j := colFirst to colLast do begin
          if (i = rwFirst) and (j = colFirst) then continue;
          Cell := FCells.GetValue(i, j);
          if Assigned(Cell) then
              Result := Write(i, j, Cell.FXFIndex)
          else
              Result := Write(i, j, Format);
          if Result <> 1 then Break;
      end;
      if Result <> 1 then Break;
    end;
  end;
  if Result = 1 then Result := MergeCells(rwFirst, colFirst, rwLast, colLast);
end;

function IXLSWorksheet.GetUsedRange: IXLSRange;
Var FirstCell, LastCell: string;
begin
  if (FCells.FRowCount > 0) and (FCells.FColCount > 0) then begin
     FirstCell := EncodeCellRef(FCells.FMinRow, FCells.FMinCol);
     LastCell := EncodeCellRef(FCells.FMaxRow, FCells.FMaxCol);
     Result := GetRange(FirstCell, LastCell);
  end else begin
     Result := GetRange('A1', 'A1');
  end;
end;

function IXLSWorksheet.WriteData(Book: IStream): Integer;
begin
 if Assigned(FChart) then begin
    Result := FDataBody.Write(book);
 end else  begin
  
    Result := FDataPreHeader.Write(book);
    if Result = 1 then Result := FDataHeader.Write(book);
    if Result = 1 then Result := FDataBody.Write(book);
    if Result = 1 then Result := FDataComment.Write(book);
    if Result = 1 then Result := FDataFooter.Write(book);
 end;
  
end;

function IXLSWorksheet.GetNextWorkSheet: IXLSWorkSheet;
begin
  Result := FWorkBook.WorkSheets[FIndex + 1];
end;

function IXLSWorksheet.GetPreviousWorkSheet: IXLSWorkSheet;
begin
  Result := FWorkBook.WorkSheets[FIndex - 1];
end;

function IXLSWorksheet.GetCustomHyperlinks: TXLSCustomHyperlinks;
begin
  if not(Assigned(FHyperlinks)) then FHyperlinks := TXLSCustomHyperlinks.Create(self);
  Result := FHyperlinks;
end;

function IXLSWorksheet.GetHyperlinks: IXLSHyperlinks;
begin
  Result := TXLSHyperLinks.Create(nil, self.GetCustomHyperlinks());
end;

procedure IXLSWorksheet.SetAutofilterShape(ARow, ACol: integer; AShape: TObject);
begin
  _Autofilter.SetAutofilterShape(ARow, ACol, AShape);
end;

constructor IXLSWorksheet.Create(Workbook :TXLSWorkbook; ASheetID: integer);
begin
  FSheetID := ASheetID;
  FCells := TXLSCellHeap.Create(self);
  FProtect := TXLSProtect.Create;

  FPageSetup := TXLSPageSetup.Create;
  FPageSetup.FWorkSheet := self;
  FIPageSetup := FPageSetup;

  FHPageBreaks := TXLSHPageBreaks.Create(self);
  FVPageBreaks := TXLSVPageBreaks.Create(self);
  FCommentCount := 0;
  FStartCommentBlock := 0;
  FActivePane := 3;
  FScreenGridLines := true;
  FZoom := 100;
  FDisplayZeros := true;
  FView := xlNormalView;

  //FLimit := 2080;
  FWorkBook := WorkBook;

  FColumnInfo := TXLSColumnInfoList.Create(FWorkBook.FXFList);
  FRowInfo := TXLSRowInfoList.Create(FWorkBook.FXFList);

  FCellsRange := _FGetRowColRange2(1,1,XLSXMaxRow + 1, XLSXMaxCol + 1);

  //FCellsRange.FCheckRefCount := false;
  FSelection := GetRange('A1', 'A1');
  //FCheckRefCount := false;

  FWorkBook.InitFormula;

  FDrawing := TMSODrawing.Create(FWorkBook.DrawingGroup, 
                                 self.GetShapeRect, self.GetShapeSize,
                                 self.GetShapeRect2, self.GetCurRowCol,
                                 self.FWorkbook.GetCustomColor,
                                 self.SetAutofilterShape,
                                 FWorkBook.FFormula,
                                 FSheetID);

  FAutofilter := TXLSAutofilter.Create(FDrawing);

  FChart := nil;
  FCondFormatter := TCondFormatter.Create(FSheetID,FWorkBook.FFormula);
  FDataValidator := TDataValidator.Create(FSheetID,FWorkBook.FFormula, FDrawing);
   

end;

destructor IXLSWorksheet.Destroy;
begin
  inherited Destroy;
  FCellsRange := nil;
  FCells.Free;
  FDrawing.Free;
  if Assigned(FPanes) then FPanes.Free;
  FProtect.Free;
  //FSelection.Free;
  //FPageSetup.Free;
  FIPageSetup := nil;

  FHPageBreaks.Free;
  FVPAgeBreaks.Free;

  FColumnInfo.Free;
  FRowInfo.Free;
  FAutofilter.Free;
  
  if Assigned(FHyperlinks) then FHyperlinks.Free;
  if Assigned(FOutline) then FOutline.Free;
  if Assigned(FChart) then FChart.Free;
  FCondFormatter.Free;
  FDataValidator.Free;
   
end;



function IXLSWorksheet.GetXFIndex(row, col: integer;
  var ReplaceIndex: boolean): integer;
Var CurCell: TXLSCellRef;
    rowinfo: TXLSRowInfo;
begin
  Result := 0;
  ReplaceIndex := false;
  CurCell := FCells.GetValue(row, col);
  if Assigned(CurCell) then begin
     if CurCell.FXFIndex > 0 then begin
        Result := CurCell.FXFIndex;
        ReplaceIndex := true;
     end;
  end;

  if Result = 0 then begin
     rowinfo := FRowInfo.GetRowInfo(row);
     if Assigned(rowinfo) then begin
        if (rowinfo.XFIndexSet) then Result := rowinfo.XFIndex;
     end;
  end;
  
  if Result = 0 then begin
     Result := FColumnInfo.XFIndex[col];
  end;

end;


function IXLSWorksheet.GetColumnXFIndex(col: integer): integer;
begin
   Result := FColumnInfo.XFIndex[col];
end;

function IXLSWorksheet.GetRowXFIndex(row: integer): integer;
begin
   Result := FRowInfo.XFIndex[row];
end;

function IXLSWorksheet.GetXPoint(StartCol: integer; Offset: double;
                   Var RetCol, RetOffset: word): boolean;
var dc: integer;
    w: double;
    i: integer;
    CurOffset: double;
begin
  Result := true;

  if Offset < 0 then begin
     dc := -1; 
     Offset := -Offset;
  end else begin
     dc := 1;
  end;

  i := StartCol + dc;
  CurOffset := 0;

  while (true) do begin
     if (i > XLSXMaxCol) or (i < 0) then begin 
        Result := false;
        break;
     end;

     with self.Cells.Columns[i + 1] do begin
        if Hidden then w := 0
                  else w := Round(ColumnWidth / 40 * 225 * 100) / 100; 
     end;

     if Offset > (CurOffset + w) then begin
        CurOffset := CurOffset + w;
        i := i + dc; 
     end else if Offset = (CurOffset + w) then begin
           //ok
         if i > XLSMaxCol then begin 
             Result := false;
         end else begin
             RetCol := word(i);
             if dc > 0 then RetOffset := 1024
                       else RetOffset := 0;
         end;
         break;
     end else begin
         if i > XLSMaxCol {limit for <=BIFF8} then begin 
             Result := false;
         end else begin
            RetCol := i;
            if dc > 0 then begin
               RetOffset := Word(Round(((Offset - CurOffset)/w * 1024)));
            end else begin
              RetOffset := Word(Round(((1 - (Offset - CurOffset)/w) * 1024)));
            end;
         end;
         break;
     end; 
  end;
end;


function IXLSWorksheet.GetYPoint(StartRow: integer; Offset: double;
                   Var RetRow, RetOffset: word): boolean;
var dc: integer;
    h: double;
    i: integer;
    CurOffset: double;
begin
  Result := true;

  if Offset < 0 then begin
     dc := -1; 
     Offset := -Offset;
  end else begin
     dc := 1;
  end;

  i := StartRow + dc;
  CurOffset := 0;

  while (true) do begin
     if (i > XLSMaxRow) or (i < 0) then begin 
        Result := false;
        break;
     end;

     with self.cells.Rows[i + 1] do begin
        if Hidden then h := 0
                  else h := Round(RowHeight * 100) / 100; 
     end;

     if Offset > (CurOffset + h) then begin
        CurOffset := CurOffset + h;
        i := i + dc; 
     end else if Offset = (CurOffset + h) then begin
           //ok
         RetRow := word(i);
         if dc > 0 then RetOffset := 256
                   else RetOffset := 0;
         break;
     end else begin
         RetRow := word(i);
         if dc > 0 then begin
            RetOffset := Word(Round(((Offset - CurOffset)/h * 256)));
         end else begin
            RetOffset := Word(Round(((1 - (Offset - CurOffset)/h) * 256)));
         end;
         break;
     end; 
  end;
end;


procedure  IXLSWorksheet.GetShapeRect(Row, Col: Word; Height, Width: Double; 
                                     Var Row1, Row1Offset, Row2, Row2Offset,
                                         Col1, Col1Offset, Col2, Col2Offset: Word);
Var Res: boolean;

begin

  Res := GetXPoint(Col, 10.5, Col1, Col1Offset);
  if Res then Res := GetXPoint(Col, 10.5 + Width, Col2, Col2Offset);
  if not(Res) then begin
     Res := GetXPoint(Col, -10.5, Col2, Col2Offset);
     if Res then Res := GetXPoint(Col, -(10.5 + Width), Col1, Col1Offset);
  end;

  if not(Res) then begin
     if Col >= 253 then Col1 := Col - 1 
                   else Col1 := Col + 1;
     Col1Offset := $C0;
     Col2       := Col1 + 1;
     Col2Offset := $0326;
  end;

  Res := GetYPoint(Row, -10.5, Row1, Row1Offset);
  if Res then Res := GetYPoint(Row - 1, Height - 10.5, Row2, Row2Offset);
  if not(Res) then begin
     Res := GetYPoint(Row, 0, Row1, Row1Offset);
     if Res then Res := GetYPoint(Row, Height, Row2, Row2Offset);
  end;

  if not(Res) then begin
     Res := GetYPoint(Row, -(Height + 5), Row1, Row1Offset);
     if Res then Res := GetYPoint(Row, -5, Row2, Row2Offset);
  end;

  if not(Res) then begin
     if      Row = 0                         then Row1 := Row
     else if Row >= (integer(XLSMaxRow) - 3) then Row1 := Row - 4
                                             else Row1 := Row - 1;
     Row1Offset := $69;
      Row2       := Row1 + 4;
     Row2Offset := $C4;
  end;

end;

procedure IXLSWorksheet.GetShapeSize(Row1, Row1Offset, Row2, Row2Offset,
                                     Col1, Col1Offset, Col2, Col2Offset: Word;
                                     Var Width, Height: Double);
var r1o, r2o, c1o, c2o: double;
    v: double;
    i: integer;
    Res: integer;
begin
  Res := 1;
  r1o := 0; 
  r2o := 0; 
  c1o := 0; 
  c2o := 0; 

  if (Row2 < Row1) or (Col2 < Col1) then   Res := -1;

  if Res = 1 then begin
     r1o :=  Row1Offset/256; 
     r2o :=  Row2Offset/256; 
     c1o :=  Col1Offset/1024; 
     c2o :=  Col2Offset/1024; 
  end;

  if (r1o > 1) or (r2o > 1) or (c1o > 1) or (c2o > 1) then begin
     Res := -1;
  end;

  if Res = 1 then begin
     Width := 0;
     Height := 0;
     for i := Col1 to Col2 do begin
       if not(Cells.Columns[i + 1].Hidden) then begin
         v := Round(Cells.Columns[i + 1].ColumnWidth / 40 * 225 * 100) / 100;
         Width := Width + v;
         if i = Col1 then Width := Width - v * c1o;
         if i = Col2 then Width := Width - v * (1 - c2o);
       end;
     end;

     for i := Row1 to Row2 do begin
       if not(Cells.Rows[i + 1].Hidden) then begin
         v := Round(Cells.Rows[i + 1].RowHeight * 100) / 100;
         Height := Height + v;
         if i = Row1 then Height := Height - v * r1o;
         if i = Row2 then Height := Height - v * (1 - r2o);
       end;
    end;
  end;
  if Res <> 1 then begin
     Width  := 10;
     Height := 10;
  end;
end;


procedure  IXLSWorksheet.GetShapeRect2(Row1, Row1Offset, Col1, Col1Offset: Word; Height, Width: Double; 
                         Var Row2, Row2Offset, Col2, Col2Offset: Word);
var r1o, r2o, c1o, c2o: double;
    v, pv: double;
    Res: integer;
begin
  Res := 1;
  r2o := 0; 
  c2o := 0; 
  r1o :=  Row1Offset/256; 
  c1o :=  Col1Offset/1024; 
  Col2 := Col1;
  Row2 := Row1;

  if (r1o > 1) or (r1o > 1) then begin
     Res := -1;
  end;

  if Res = 1 then begin
     Col2 := Col1;
     while (width > 0) and (col2 <= XLSMaxCol) do begin
       if not(Cells.Columns[col2 + 1].Hidden) then begin
         v := Round(Cells.Columns[col2 + 1].ColumnWidth / 40 * 225 * 100) / 100;
         if col2 = col1 then pv := v * (1 - c1o)
                        else pv := v;

         if pv >= Width then begin
            c2o := Width/v;
            if col2 = col1 then c2o := c1o + c2o;
            break;
         end;
         Width := Width - pv;
       end;
       Inc(Col2);
     end; 

     if Col2 = 256 then begin
        Col2 := 255;
        c2o  := 1;
     end;

     if c2o > 1 then c2o := 1;
  end;

  if Res = 1 then begin
     Row2 := Row1;
     while (Height > 0) and (Row2 <  65535) do begin
       if not(Cells.Rows[Row2 + 1].Hidden) then begin
         v := Round(Cells.Rows[Row2 + 1].RowHeight * 100) / 100;

         if Row2 = Row1 then pv := v * (1 - r1o)
                        else pv := v;

         if pv >= Height then begin
            r2o := Height/v;
            if Row2 = Row1 then r2o := r1o + r2o;
            break;
         end;
         Height := Height - pv;
       end;
       Inc(Row2);
     end; 

     if Row2 = 65535 then begin
        Row2 := 65534;
        r2o  := 1;
     end;

     if r2o > 1 then r2o := 1;
  end;

  Row2Offset := trunc(r2o * 256);
  Col2Offset := trunc(c2o * 1024);
end;

procedure IXLSWorksheet.GetCurRowCol(Var Row, Col: word);
begin
  Row := (Selection.Row - 1);
  Col := (Selection.Column - 1);
end;

function IXLSWorksheet.GetShapes: TXLSShapes;
begin
  Result := FDrawing.Pictures;
end;

procedure IXLSWorksheet._SetChartData(AData: TXLSCustomChart);
begin
  if Assigned(FChart) then FChart.Free;
  FChart := AData;
end;
 






{ TXLSInterior }

procedure TXLSInterior.SetPatternColorIndex(const Value: LongWord);
Var ColorIndex: LongWord;
    Err: boolean;
begin
  Err := false;
  ColorIndex := 0;

  if Value = xlColorIndexAutomatic then
     ColorIndex := 64
  else if (Value = xlColorIndexNone) or (Value = 0) then
     ColorIndex := 0
  else if Value > 56 then
     //exception
     Err := true
  else
     ColorIndex := Value + 7;
  if not(Err) then
     FRange.SetInteriorPatternColorIndex(ColorIndex);
end;

procedure TXLSInterior.SetPatternColor(const Value: LongWord);
begin
   FRange.SetInteriorPatternColor(Value);
end;

procedure TXLSInterior.SetPatternThemeColor(const Value: LongWord);
begin
   FRange.SetInteriorPatternThemeColor(Value);
end;

procedure TXLSInterior.SetPatternTintAndShade(const Value: double);
begin
   FRange.SetInteriorPatternTintAndShade(Value);
end;


procedure TXLSInterior.SetPattern(Const Value: LongWord);
Var lValue:Word;
begin
  case Value of
    xlPatternSolid:            lValue := 1;
    xlPatternChecker:          lValue := 9;
    xlPatternSemiGray75:       lValue := 10;
    xlPatternLightHorizontal:  lValue := 11;
    xlPatternLightVertical:    lValue := 12;
    xlPatternLightDown:        lValue := 13;
    xlPatternLightUp:          lValue := 14;
    xlPatternGrid:             lValue := 15;
    xlPatternCrissCross:       lValue := 16;
    xlPatternGray16:           lValue := 17;
    xlPatternGray8:            lValue := 18;
    xlPatternVertical:         lValue := 6;
    xlPatternUp:               lValue := 8;
    xlPatternNone:             lValue := 0;
    xlPatternHorizontal:       lValue := 5;
    xlPatternGray75:           lValue := 3;
    xlPatternGray50:           lValue := 2;
    xlPatternGray25:           lValue := 4;
    xlPatternDown:             lValue := 7;
    xlPatternAutomatic:        lValue := 1;
  else                         lValue := 0;
  end;
  FRange.SetInteriorPattern(lValue);
end;

constructor TXLSInterior.Create(const Range: TXLSRange);
begin
  FRange := Range;
  //FCheckRefCount := true;
end;

function TXLSInterior.GetPattern: LongWord;
begin
  Result := FRange.GetInteriorPattern;
  case Result of
     0: Result := xlPatternNone;
     1: Result := xlPatternSolid;
     2: Result := xlPatternGray50;
     3: Result := xlPatternGray75;
     4: Result := xlPatternGray25;
     5: Result := xlPatternHorizontal;
     6: Result := xlPatternVertical;
     7: Result := xlPatternDown;
     8: Result := xlPatternUp;
     9..18:;
  else Result := 0;
  end;
end;

procedure TXLSInterior.SetColorIndex(const Value: LongWord);
Var ColorIndex: Word;
    Err: boolean;
begin
  Err := false;
  ColorIndex := 0;
  
  if Value = xlColorIndexAutomatic then
     ColorIndex := 65
  else if (Value = xlColorIndexNone) or (Value = 0) then
     ColorIndex := 0
  else if Value > 56 then
     //exception
     Err := true
  else
     ColorIndex := Value + 7;

  if not(Err) then
     FRange.SetInteriorColorIndex(ColorIndex)
end;

procedure TXLSInterior.SetColor(const Value: LongWord);
begin
   FRange.SetInteriorColor(Value);
end;

procedure TXLSInterior.SetThemeColor(const Value: LongWord);
begin
   FRange.SetInteriorThemeColor(Value);
end;

procedure TXLSInterior.SetTintAndShade(const Value: double);
begin
   FRange.SetInteriorTintAndShade(Value);
end;


function TXLSInterior.GetColorIndex: LongWord;
begin
  Result := FRange.GetInteriorColorIndex;
end;

function TXLSInterior.GetColor: LongWord;
begin
  Result := FRange.GetInteriorColor;
end;

function TXLSInterior.GetThemeColor: LongWord;
begin
  Result := FRange.GetInteriorThemeColor;
end;

function TXLSInterior.GetTintAndShade: double;
begin
  Result := FRange.GetInteriorTintAndShade;
end;

function TXLSInterior.GetPatternColorIndex: LongWord;
begin
  Result := FRange.GetInteriorPatternColorIndex;
end;


function TXLSInterior.GetPatternColor: LongWord;
begin
  Result := FRange.GetInteriorPatternColor;
end;

function TXLSInterior.GetPatternThemeColor: LongWord;
begin
  Result := FRange.GetInteriorPatternThemeColor;
end;

function TXLSInterior.GetPatternTintAndShade: double;
begin
  Result := FRange.GetInteriorPatternTintAndShade;
end;

{ TXLSPanes }
procedure TXLSPanes.Clear;
begin
  Self.Row := 0;
  Self.Col := 0;
  Self.RowTop := -1;
  Self.ColLeft := -1;
  Self.Frozen := false;
  Self.X := 0;
  Self.Y := 0;
end;

constructor TXLSPanes.Create;
begin
  RowTop := -1;
  ColLeft := -1;
end;

procedure TXLSPanes.Freeze(Const Row: integer; Const Col: integer;
                           Const RowTop: integer; Const ColLeft: integer);
begin
  Self.Row := Row;
  Self.Col := Col;
  Self.RowTop := RowTop;
  Self.ColLeft := ColLeft;
  Self.Frozen := true;
  Self.X := 0;
  Self.Y := 0;
end;

procedure TXLSPanes.SetCol(const Value: integer);
begin
  if (Value >= 0) and (Value <= XLSXMaxCol) then FCol := Value;
end;

procedure TXLSPanes.SetColLeft(const Value: integer);
begin
  if (Value >= -1) and (Value <= XLSXMaxCol) then  FColLeft := Value;
end;

procedure TXLSPanes.SetFrozen(const Value: boolean);
begin
  FFrozen := Value;
end;

procedure TXLSPanes.SetRow(const Value: Integer);
begin
  if (Value >= 0) and (Value <= XLSXMaxRow) then FRow := Value;
end;

procedure TXLSPanes.SetRowTop(const Value: Integer);
begin
  if (Value >= -1) and (Value <= XLSXMaxRow) then FRowTop := Value;
end;

procedure TXLSPanes.SetX(const Value: Single);
begin
  if Value >= 0 then FX := Value;
end;

procedure TXLSPanes.SetY(const Value: Single);
begin
  if Value >= 0 then FY := Value;
end;

procedure TXLSPanes.Thaw(const X, Y: Single; const RowTop: integer;
  const ColLeft: integer);
begin
  Self.Row := 0;
  Self.Col := 0;
  Self.RowTop := RowTop;
  Self.ColLeft := ColLeft;
  Self.Frozen := false;
  Self.X := X;
  Self.Y := Y;
end;


{ TXLSProtect }
constructor TXLSProtect.Create;
begin
   inherited Create;
   FOptions := $4400;
end;

function TXLSProtect.rot15(Value: Word; n: integer): Word;
begin
  while n > 15 do begin
    n := n - 15;
  end;
  Value := Value and $7FFF;
  Result := ((Value shl n) and $7FFF) or (Value shr (15 - n));
end;

function TXLSProtect.EncodePassword(Password: string): Word;
Var Count, i: Word;
    Item: LongWord;
begin
  Result := 0;
  Count := Length(Password);
  if Count > 0 then begin
     for i:= 1 to Count do begin
        Item := rot15(Ord(Password[i]), i);
        Result := Result xor Item;
     end;
     Result := Result xor Count;
     Result := Result xor $CE4B;
  end;
end;

procedure TXLSProtect.SetOptions(AOptions: Word);
begin
  FOptions := AOptions;
end;

procedure TXLSProtect.SetProtected(Value: boolean);
begin
  FProtected := Value;
end;

procedure TXLSProtect.ProtectEncode(AEncodedPassword: Word);
begin
  FEncodedPassword := AEncodedPassword;
  if AEncodedPassword > 0 then begin
//     FProtected := true;
     FIsPassword := true;
  end else begin
//     FProtected := false;
     FIsPassword := false;
  end;
end;

procedure TXLSProtect.Protect(Password: string);
Var Res: boolean;
begin
  Res := true;
  if isPassword then begin
     //check password
     Res := (FEncodedPassword = EncodePassword(Password));
  end;

  if Res then begin
     FProtected := true;
     if Password <> '' then begin
        FEncodedPassword := EncodePassword(Password);
        FIsPassword := true;
     end else begin
        FEncodedPassword := 0;
        FIsPassword := false;
     end;
  end else begin
     //wrong password
     //exception
  end;
end;

function TXLSProtect.UnProtect(Password: string;
  UsePassword: boolean): boolean;
begin

  Result := true;

  if UsePassword then begin
     if FProtected and FIsPassword then begin
        if (FEncodedPassword <> EncodePassword(Password)) then begin
           //Wrong password
           Result := false
        end;
     end;
  end;

 if Result then begin
    FProtected := false;
    FEncodedPassword := 0;
    FIsPassword := false;
  end;

end;

{ TXLSPageSetup }

constructor TXLSPageSetup.Create;
begin

    FPrintAreaRowMin := -1;
    FPrintAreaRowMax := -1;
    FPrintAreaColMin := -1;
    FPrintAreaColMax := -1;

    FOrder := 0;
    FOrientation := 1;

    FHeaderMargin := 0.50;
    FFooterMargin := 0.50;
    FLeftMargin := 0.75;
    FRightMargin := 0.75;
    FTopMargin := 1.00;
    FBottomMargin := 1.00;
//  FPrintGridLines := true;

    FZoom := 100;
    FIsFitToPages := false;
    FExternID := -1;
end;

destructor TXLSPageSetup.Destroy;
begin
  inherited Destroy;
end;

function TXLSPageSetup.GetOrientation: LongWord;
begin 
  case FOrientation of
     0: Result := xlLandscape;
     1: Result :=  xlPortrait;
     else Result :=  xlPortrait;
  end;
end;

function TXLSPageSetup.GetOrder: LongWord;
begin 
   if FOrder = 0 then Result := xlDownThenOver
   else Result :=  xlOverThenDown;
end;

function TXLSPageSetup.GetPaperSize: LongWord;
begin
  if FPaperSize = 0 then
     Result := xlPaperUser
  else Result := FPaperSize;
end;

function TXLSPageSetup.GetBottomMargin: Double;
begin Result := FBottomMargin end;

function TXLSPageSetup.GetCenterFooter: widestring;
begin Result := FCenterFooter end;

function TXLSPageSetup.GetCenterHeader: widestring;
begin Result := FCenterHeader end;

function TXLSPageSetup.GetCenterHorizontally: boolean;
begin Result := FCenterHorizontally end;

function TXLSPageSetup.GetCenterVertically: boolean;
begin Result := FCenterVertically end;

function TXLSPageSetup.GetDraft: boolean;
begin Result := FDraft end;

function TXLSPageSetup.GetBlackAndWhite: boolean;
begin Result := FBlackAndWhite end;

function TXLSPageSetup.GetPrintNotes: boolean;
begin Result := FPrintNotes end;

function TXLSPageSetup.GetFitToPagesTall: Variant;
begin
  if FFitToPagesTall > 0 then
     Result := FFitToPagesTall
  else
     Result := false;
end;

function TXLSPageSetup.GetFitToPagesWide: Variant;
begin
  if FFitToPagesWide > 0 then
     Result := FFitToPagesWide
  else
     Result := false;
end;

function TXLSPageSetup.GetIsFitToPages: boolean;
begin
  Result := (FFitToPagesTall > 0) or (FFitToPagesWide > 0);
end;


function TXLSPageSetup.GetFooterMargin: Double;
begin Result := FFooterMargin end;

function TXLSPageSetup.GetHeaderMargin: Double;
begin Result := FHeaderMargin end;

function TXLSPageSetup.GetLeftFooter: widestring;
begin Result := FLeftFooter end;

function TXLSPageSetup.GetLeftHeader: widestring;
begin Result := FLeftHeader end;

function TXLSPageSetup.GetLeftMargin: Double;
begin Result := FLeftMargin end;

function TXLSPageSetup.FGetPrintArea: string;
begin Result := FPrintArea end;

function TXLSPageSetup.GetPrintGridlines: boolean;
begin Result := FPrintGridlines end;

function TXLSPageSetup.GetPrintHeadings: boolean;
begin Result := FPrintHeadings end;

function TXLSPageSetup.GetRightFooter: widestring;
begin Result := FRightFooter end;

function TXLSPageSetup.GetRightHeader: widestring;
begin Result := FRightHeader end;

function TXLSPageSetup.GetRightMargin: Double;
begin Result := FRightMargin end;

function TXLSPageSetup.GetTopMargin: Double;
begin Result := FTopMargin end;

function TXLSPageSetup.GetZoom: Variant;
begin
  if FIsFitToPages then 
     Result := false
  else 
     Result := FZoom;
end;
 
procedure TXLSPageSetup.SetBottomMargin(const Value: Double);
begin
  FBottomMargin := Value;
end;

procedure TXLSPageSetup.SetCenterFooter(const Value: widestring);
begin
  FCenterFooter := Value;
end;

procedure TXLSPageSetup.SetCenterHeader(const Value: widestring);
begin
  FCenterHeader := Value;
end;

procedure TXLSPageSetup.SetCenterHorizontally(const Value: boolean);
begin
  FCenterHorizontally := Value;
end;

procedure TXLSPageSetup.SetDraft(const Value: boolean);
begin
  FDraft := Value;
end;

procedure TXLSPageSetup.SetBlackAndWhite(const Value: boolean);
begin
  FBlackAndWhite := Value;
end;

procedure TXLSPageSetup.SetPrintNotes(const Value: boolean);
begin
  FPrintNotes := Value;
end;

procedure TXLSPageSetup.SetCenterVertically(const Value: boolean);
begin
  FCenterVertically := Value;
end;

procedure TXLSPageSetup.SetFitToPagesTall(const Value: Variant);
Var vt: TVarType;
begin
  vt := VarType(Value);
  case vt of
     varBoolean: 
          begin
            if boolean(Value) = false then FFitToPagesTall := 0;
            FIsFitToPages := boolean(Value);
          end;
     else 
          begin
            FFitToPagesTall := Word(Value);
            FIsFitToPages := true;
          end;
  end;
end;

procedure TXLSPageSetup.SetFitToPagesWide(const Value: Variant);
Var vt: TVarType;
begin
  vt := VarType(Value);
  case vt of
     varBoolean: 
          begin
            if boolean(Value) = false then FFitToPagesWide := 0;
            FIsFitToPages := boolean(Value);
          end;
     else 
          begin
            FFitToPagesWide := Word(Value);
            FIsFitToPages := true;
          end;
  end;
end;

procedure TXLSPageSetup.SetFooterMargin(const Value: Double);
begin
  FFooterMargin := Value;
end;

procedure TXLSPageSetup.SetHeaderMargin(const Value: Double);
begin
  FHeaderMargin := Value;
end;

procedure TXLSPageSetup.SetLeftFooter(const Value: widestring);
begin
  FLeftFooter := Value;
end;

procedure TXLSPageSetup.SetLeftHeader(const Value: widestring);
begin
  FLeftHeader := Value;
end;

procedure TXLSPageSetup.SetLeftMargin(const Value: Double);
begin
  FLeftMargin := Value;
end;

procedure TXLSPageSetup.SetOrientation(const Value: LongWord);
begin
  case Value of
    xlPortrait: FOrientation := 1;
    xlLandscape: FOrientation := 0;
  end;
end;

procedure TXLSPageSetup.SetOrder(const Value: LongWord);
begin
  case Value of
    xlDownThenOver: FOrder := 0;
    xlOverThenDown: FOrder := 1;
  end;
end;

procedure TXLSPageSetup.SetPaperSize(const Value: LongWord);
begin
  if Value =  xlPaperUser then
     FPaperSize := 0
  else
     FPaperSize := Word(Value);
end;

procedure TXLSPageSetup.FSetPrintArea(const Value: string);
Var FirstRow, LastRow: integer;
    FirstCol, LastCol: integer;
begin
  if Value = '' then begin
      FPrintAreaRowMin := -1;
      FPrintAreaColMin := -1;
      FPrintAreaRowMax := -1;
      FPrintAreaColMax := -1;
      FPrintArea := '';
  end else
    if GetCellRange(Value, FirstRow, FirstCol, LastRow, LastCol) = 1 then
       SetPrintArea(FirstRow, FirstCol, LastRow, LastCol)
end;

procedure TXLSPageSetup.SetPrintArea(FirstRow, FirstCol, LastRow,
  LastCol: integer);
begin
   if (FirstRow <= LastRow) and
      (FirstCol <= LastCol) and
      (LastRow <= XLSXMaxRow) and
      (LastCol <= XLSXMaxCol) then begin
      FPrintAreaRowMin := FirstRow;
      FPrintAreaColMin := FirstCol;
      FPrintAreaRowMax := LastRow;
      FPrintAreaColMax := LastCol;
      FPrintArea := EncodeCellRange(FirstRow, FirstCol, LastRow, LastCol);

      if FExternID <= 0 then 
         FExternID := FWorksheet.FWorkbook.FExtern.GetExternID(FWorksheet.Index, 
                                                               FWorksheet.Index);
   end;
end;

procedure TXLSPageSetup.SetPrintGridlines(const Value: boolean);
begin
  FPrintGridlines := Value;
end;

procedure TXLSPageSetup.SetPrintHeadings(const Value: boolean);
begin
  FPrintHeadings := Value;
end;

procedure TXLSPageSetup.SetPrintTitleColumns(const Value: string);
begin
  if not(ColDiapasonToValues(Value, FPrintTitleColumnFrom, FPrintTitleColumnTo)) then begin
    //!!exception
  end else begin
      if FExternID <= 0 then 
         FExternID := FWorksheet.FWorkbook.FExtern.GetExternID(FWorksheet.Index, 
                                                               FWorksheet.Index);
  end;
end;

procedure TXLSPageSetup.SetPrintTitleRows(const Value: string);
begin
  if not(RowDiapasonToValues(Value, FPrintTitleRowFrom, FPrintTitleRowTo)) then begin
    //!!exception
  end else begin
      if FExternID <= 0 then 
         FExternID := FWorksheet.FWorkbook.FExtern.GetExternID(FWorksheet.Index, 
                                                               FWorksheet.Index);
  end;
end;

procedure TXLSPageSetup.SetRightFooter(const Value: widestring);
begin
  FRightFooter := Value;
end;

procedure TXLSPageSetup.SetRightHeader(const Value: widestring);
begin
  FRightHeader := Value;
end;

procedure TXLSPageSetup.SetRightMargin(const Value: Double);
begin
  FRightMargin := Value;
end;

procedure TXLSPageSetup.SetTopMargin(const Value: Double);
begin
  FTopMargin := Value;
end;

procedure TXLSPageSetup.SetZoom(const Value: Variant);
Var vt: TVarType;
    v: Word;
begin
  vt := VarType(Value);
  case vt of
     varBoolean: FIsFitToPages := not(boolean(Value));
     else begin
        v := Word(Value);
        if (v < 10) or (v > 400) then begin
           //exception
        end else begin
           FZoom := v;
           FIsFitToPages := false;
        end;
     end;

  end;
end;

function TXLSPageSetup.GetPrintTitleColumns: string;
begin
  ValuesToColDiapason(FPrintTitleColumnFrom, FPrintTitleColumnTo, Result);
  if FExternID <= 0 then 
     FExternID := FWorksheet.FWorkbook.FExtern.GetExternID(FWorksheet.Index, 
                                                           FWorksheet.Index);
end;

function TXLSPageSetup.GetPrintTitleRows: string;
begin
  ValuesToRowDiapason(FPrintTitleRowFrom, FPrintTitleRowTo, Result);
  if FExternID <= 0 then 
     FExternID := FWorksheet.FWorkbook.FExtern.GetExternID(FWorksheet.Index, 
                                                           FWorksheet.Index);
end;

{ TXLSRange }

constructor TXLSRange.Create(const WorkSheet: IXLSWorksheet; Cell1,
  Cell2: String);
Var ret: integer;
    tmp: integer;
begin
  //FCheckRefCount := true;
  FWorkSheet := WorkSheet;

  ret := GetCellRef(Cell1, FFirstRow, FFirstCol);
  if ret = 1 then ret := GetCellRef(Cell2, FLastRow, FLastCol);
  if ret = 1 then begin

     if FFirstRow > FLastRow then begin
        tmp := FFirstRow;
        FFirstRow := FLastRow;
        FLastRow := tmp;
     end;

     if FFirstCol > FLastCol then begin
        tmp := FFirstCol;
        FFirstCol := FLastCol;
        FLastCol := tmp;
     end;

  end;

  if ret <> 1 then begin
     //exception
     //ret := -1
  end;
end;

constructor TXLSRange.Create(const WorkSheet: IXLSWorksheet;
                             Row1, Col1, Row2, Col2: integer);
begin
  //FCheckRefCount := true;
  FWorkSheet := WorkSheet;

  if row1 > row2 then begin
    FFirstRow  := row2;
    FLastRow   := row1;
  end else begin
    FFirstRow  := row1;
    FLastRow   := row2;
  end;

  if col1 > col2 then begin
     FFirstCol  := col2;
     FLastCol   := col1;
  end else begin
     FFirstCol  := col1;
     FLastCol   := col2;
  end;
end;

procedure TXLSRange.Merge;
begin Self.Merge(False); end;

function TXLSRange.GetMergeCells: boolean;
Var C: TXLSCellRef;
begin
  C := FWorkSheet.FCells.GetValue(FirstRow, FirstCol);
  if Assigned(C) then Result := C.FMerged
                 else Result := false;
  if Result then begin
     Result :=  (C.FMergeCell.FRow <= FirstRow) and
                ((C.FMergeCell.FRow + C.FMergeCell.FMergeRowCount - 1) >= LastRow) and
                (C.FMergeCell.FCol <= FirstCol) and
                ((C.FMergeCell.FCol + C.FMergeCell.FMergeColCount - 1) >= LastCol);
  end;
  
end;

procedure TXLSRange.SetMergeCells(Value: boolean);
begin 
  if Value then Self.Merge(False)
           else Self.Unmerge; 
end;

function TXLSRange.GetMergeArea: IXLSRange;
Var C: TXLSCellRef;
begin
  C := nil;
  if Self.MergeCells then
     C := FWorkSheet.FCells.GetValue(FirstRow, FirstCol);
  if Assigned(C) then C := C.FMergeCell;
  if Assigned(C) then
     Result := FWorksheet.RCRange[C.FRow + 1,               C.FCol + 1, 
                                  C.FRow + C.FMergeRowCount,C.FCol + C.FMergeColCount]
  else
     Result := Self;
end;


procedure TXLSRange.Merge(Accros: OleVariant);
Var row, col: integer;
    MergeCell: TXLSCellRef;
    CurCell: TXLSCellRef;
    bAccros: boolean;
    FirstRow, LastRow: integer;
    FirstCol, LastCol: integer;
begin
  {$IFNDEF D45}
  if VarIsEmptyParam(Accros) then
     bAccros := false
  else
     bAccros := ((Accros = true) or (Accros > 0));
  {$ELSE}
  if VarType(Accros) = varBoolean then
     bAccros := (Accros = true)
  else
     bAccros := false;
  {$ENDIF}

  ExtendRange;
  FirstRow := FFirstRow;
  LastRow := FLastRow;
  FirstCol := FFirstCol;
  LastCol := FLastCol;
  MergeCell := nil;
  for row := 0 to (LastRow - FirstRow) do begin
    for col := 0 to (LastCol - FirstCol) do begin
       CurCell := FWorkSheet.FCells.GetOrCreateValue(FirstRow + row, FirstCol + col);

       if ((row = 0) and (col = 0) and not(bAccros)) or
          ((col = 0) and bAccros)  then begin
           MergeCell := FWorkSheet.FCells.GetOrCreateValue(FirstRow + row, FirstCol + col);
           if bAccros then
              MergeCell.FMergeRowCount := 1
           else
              MergeCell.FMergeRowCount := LastRow - FirstRow + 1;
           MergeCell.FMergeColCount := LastCol - FirstCol + 1;
       end
       else begin
         CurCell.SetValue(FWorkSheet, Null);
       end;
       CurCell.FMergeCell := MergeCell;
       CurCell.FMerged := true;
     end;
  end;
end;

function TXLSRange.GetItem(Row: integer; Col: integer): IXLSRange;
Var lrow, lcol :integer;
begin
  lrow := FFirstRow + row - 1;
  lcol := FFirstCol + Col - 1;
  if (lrow >= 0) and (lcol >= 0) and 
     (lrow <= XLSXMaxRow) and (lcol <= XLSXMaxCol) then begin
     Result := TXLSRange.Create(FWorksheet, lrow, lcol, lrow, lcol)
  end else begin
     raise Exception.Create('Invalid row/column index');
  end;
end;

function TXLSRange.GetEntireRow: IXLSRowsRange;
begin
  Result := TXLSRange.Create(FWorkSheet,
                             FFirstRow, 0,
                             FLastRow, XLSXMaxCol);
end;

function TXLSRange.GetEntireColumn: IXLSColsRange;
begin
  Result := TXLSRange.Create(FWorkSheet,
                             0, FFirstCol,
                             XLSXMaxRow, FLastCol);
end;

function TXLSRange.GetOffsetRange(rowoffset, coloffset: integer): IXLSRange;
begin
  if not(assigned(FOffsetRange)) then begin
     FOffsetRange := TXLSRange.Create(FWorkSheet,
                                      FFirstRow, FFirstCol,
                                      FLastRow,  FLastCol);
  end;
  FOffsetRange.ShiftTo(FFirstRow + rowoffset, FFirstCol + coloffset);
  Result := FOffsetRange;
end;

procedure TXLSRange.ShiftTo(row, col: integer);
Var lHeight, lWidth: integer;
begin
  lHeight := FLastRow - FFirstRow;
  lWidth  := FLastCol - FFirstCol;
  FFirstRow := row;
  FLastRow  := row + lHeight;
  FFirstCol := col;
  FLastCol  := col + lWidth;
//  FCell1    := EncodeCellRef(FFirstRow, FFirstCol);
//  FCell2    := EncodeCellRef(FLastRow,  FLastCol);
end;

procedure TXLSRange.PasteFrom(SrcRange: TXLSRange; PasteMode: Longword; CopyMode: boolean);
Var drow, drow1, drow2, dcol, dcol1, dcol2: integer;
    srow, srow1, srow2, scol, scol1, scol2: integer;
    rowstep, colstep, row, col: integer;
    copycolw:     boolean;
begin
  rowstep := 1; colstep := 1;

  drow1 := FFirstRow;          drow2 := FLastRow;
  dcol1 := FFirstCol;          dcol2 := FLastCol;
  srow1 := SrcRange.FFirstRow; srow2 := SrcRange.FLastRow;
  scol1 := SrcRange.FFirstCol; scol2 := SrcRange.FLastCol;

  if drow1 > drow2 then swap(drow1, drow2);
  if dcol1 > dcol2 then swap(dcol1, dcol2);
  if srow1 > srow2 then swap(srow1, srow2);
  if scol1 > scol2 then swap(scol1, scol2);

  if drow1 > srow1 then begin
     rowstep := -1;
     swap(srow1, srow2);
     swap(drow1, drow2);
  end;

  if dcol1 > scol1 then begin
     colstep := -1;
     swap(scol1, scol2);
     swap(dcol1, dcol2);
  end;

  copycolw     := ((pastemode and xlPasteColumnWidths) = xlPasteColumnWidths);

  //Copy Cells
  row := 0;
  while (row <= abs(drow2 - drow1)) do begin
    drow := drow1 + row * rowstep;
    srow := srow1 + (row * rowstep) mod (abs(srow2 - srow1) + 1);
    col := 0;
    while (col <= abs(dcol2 - dcol1)) do begin
      dcol := dcol1 + col * colstep;
      scol := scol1 + (col * colstep) mod (abs(scol2 - scol1) + 1);
      if copycolw and (row = 0) then begin
         self.FWorkSheet.Cells[drow + 1, dcol + 1].ColumnWidth :=   
         SrcRange.FWorkSheet.Cells[srow + 1, scol + 1].ColumnWidth;
      end;
      CopyCell(srow, scol, SrcRange.FWorkSheet, 
               drow, dcol, FWorkSheet, PasteMode, true);
      inc(col); 
    end;
    inc(row)
  end; 

  if (PasteMode and xlPasteValues) > 0 then begin
     FWorksheet.FWorkbook.IncChangeID; 
  end;

  //Clear Cells
  if not(CopyMode) then begin
     if drow2 < drow1 then swap(drow1, drow2);
     if srow2 < srow1 then swap(srow1, srow2);
     if dcol2 < dcol1 then swap(dcol1, dcol2);
     if scol2 < scol1 then swap(scol1, scol2);
     for row := srow1 to srow2 do 
       for col := scol1 to scol2 do
         if not((row >= drow1) and (row <= drow2) and
                (col >= dcol1) and (col <= dcol2))  then begin
            ClearCell(row, col, SrcRange.FWorkSheet, PasteMode, 0);
         end;
  end;
  if not(CopyMode) and 
     ((PasteMode and xlPasteValues) > 0) then begin
     SrcRange.FWorkSheet.FWorkbook.IncChangeID;
  end;
      

end;

procedure TXLSRange.Move(Destination: IXLSRange; PasteMode: LongWord);
begin
  Destination.PasteFrom(self, PasteMode, false);
end;

procedure TXLSRange.Copy(Destination: IXLSRange; PasteMode: LongWord);
begin
  Destination.PasteFrom(self, PasteMode, true);
end;

procedure TXLSRange.Move(Destination: IXLSRange);
begin
  Move(Destination, xlPasteAll);
end;

procedure TXLSRange.Copy(Destination: IXLSRange);
begin
  Copy(Destination, xlPasteAll);
end;

function TXLSRange.GetRows: IXLSRowsRange;
begin Result := self; end;

function TXLSRange.GetColumns: IXLSColsRange;
begin  Result := self; end;

function TXLSRange.GetRowByIndex(row: integer): IXLSRowRange;
begin
  Result := TXLSRange.Create(FWorkSheet,
               FFirstRow + row -1, FFirstCol,
               FFirstRow + row -1, FLastCol);
end;


function TXLSRange.GetColByIndex(col: integer): IXLSColRange;
begin
  Result := TXLSRange.Create(FWorkSheet,
                             FFirstRow, FFirstCol + col -1,
                             FLastRow, FFirstCol  + col -1);
end;

function TXLSRange.GetCellsCount: LongWord;
begin
  Result := (Abs(FLastRow - FFirstRow) + 1) * (Abs(FLastCol - FFirstCol) + 1);
end;

function TXLSRange.GetRowsCount: LongWord;
begin
  Result := Abs(integer(FLastRow) - integer(FFirstRow)) + 1;
end;

function TXLSRange.GetColumnsCount: LongWord;
begin
  Result := Abs(integer(FLastCol) - integer(FFirstCol)) + 1;
end;

function TXLSRange.GetValue: Variant;
Var row, col: integer;
    Cell: TXLSCellRef;
    ReplaceIndex: boolean;
begin
  if (FLastRow = FFirstRow) and (FLastCol = FFirstCol) then begin
     Cell := FWorkSheet.FCells.GetValue(FFirstRow, FFirstCol);
     if Assigned(Cell) then begin
        Result := Cell.Value[FWorkSheet];
        try
           if VarType(Result) = varDouble then begin
              if FWorkSheet.FWorkBook.FXFList.isDateFormat(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex)) then begin
                 Result := Excel2DateTime(Result);
              end;
           end;
        except
          on E:Exception do begin
             Result := Null;  
          end; 
        end;
     end else Result := Null;
  end else begin
    Result := VarArrayCreate([0, FLastRow - FFirstRow, 0, FLastCol - FFirstCol], varVariant);
    for row := 0 to (FLastRow - FFirstRow) do begin
      for col := 0 to (FLastCol - FFirstCol) do begin
         Cell := FWorkSheet.FCells.GetValue(FFirstRow + row, FFirstCol + col);
         if Assigned(Cell) then begin
            Result[row, col] := Cell.Value[FWorkSheet];
            try  
               if VarType(Result[row, col]) = varDouble then
                  if FWorkSheet.FWorkBook.FXFList.isDateFormat(GetXFIndex(FFirstRow + row, FFirstCol + col, ReplaceIndex)) then begin
                     Result[row,col] := Excel2DateTime(Result[row,col]); 
                  end;
            except
              on E:Exception do begin
                 Result[row, col] :=  Null;  
              end; 
            end;
              
         end else Result[row, col] := Null;
      end;
    end;
  end;
end;

function TXLSRange.GetFormula: Variant;
Var row, col: integer;
    Cell: TXLSCellRef;
begin
  if (FLastRow = FFirstRow) and (FLastCol = FFirstCol) then begin
     Cell := FWorkSheet.FCells.GetValue(FFirstRow, FFirstCol);
     if Assigned(Cell) then Result := Cell.Formula[FWorkSheet]
        else Result := Null;
  end else begin
    Result := VarArrayCreate([0, FLastRow - FFirstRow, 0, FLastCol - FFirstCol], varVariant);
    for row := 0 to (FLastRow - FFirstRow) do begin
      for col := 0 to (FLastCol - FFirstCol) do begin
         Cell := FWorkSheet.FCells.GetValue(FFirstRow + row, FFirstCol + col);
         if Assigned(Cell) then Result[row, col] := Cell.Formula[FWorkSheet]
            else Result[row, col] := Null;
      end;
    end;
  end;
end;

function TXLSRange.GetHasFormula: boolean;
Var Cell: TXLSCellRef;
    row, col: integer;
begin
  Result := False;
  if (FLastRow = FFirstRow) and (FLastCol = FFirstCol) then begin
     Cell := FWorkSheet.FCells.GetValue(FFirstRow, FFirstCol);
     if Assigned(Cell) then Result := Cell.HasFormula;
  end else begin
    row := 0;
    while not(Result) and (row <= (FLastRow - FFirstRow)) do begin
       col := 0;
       while not(Result) and (col <= (FLastCol - FFirstCol)) do begin
          Cell := FWorkSheet.FCells.GetValue(FFirstRow + row, FFirstCol + col);
          if Assigned(Cell) then Result := Cell.HasFormula;
          Inc(col);
       end;
       Inc(row);
    end;
  end;
end;


procedure TXLSRange.SetValue(Value: Variant);
Var vt: TVarType;
    row, col: integer;
    aRow, aCol: Integer;
    dim_count: integer;
    ARowCount, AColCount, AFirstRow, AFirstCol: Integer;
    nodata: boolean;
begin
   aCol := 0;
   aRow := 0;
   vt := VarType(Value);
   if (vt and varArray) > 0 then begin
     dim_count := VarArrayDimCount(Value);
     if (dim_count > 2) or (dim_count < 1) then  exit;//exception
     if dim_count = 1 then begin
        AFirstCol := VarArrayLowBound(Value, 1);
        AColCount := VarArrayHighBound(Value, 1) - AFirstCol + 1;
        AFirstRow := 0;
        ARowCount := 0;
     end
     else begin
        AFirstRow := VarArrayLowBound(Value, 1);
        ARowCount := VarArrayHighBound(Value, 1) - AFirstRow + 1;
        AFirstCol := VarArrayLowBound(Value, 2);
        AColCount := VarArrayHighBound(Value, 2) - AFirstCol + 1;
     end;
     for row := 0 to (FLastRow - FFirstRow) do begin
       for col := 0 to (FLastCol - FFirstCol) do begin
         nodata := false;
         if dim_count = 1 then begin
            if col < AColCount then aCol := col + AFirstCol
            else if AColCount = 1 then aCol := AFirstCol
            else nodata := true;
            if not(nodata) then
               FWorkSheet.FCells.GetOrCreateValue(FFirstRow + row, FFirstCol + col).Value[FWorkSheet] := Value[aCol]
            else
               FWorkSheet.FCells.GetOrCreateValue(FFirstRow + row, FFirstCol + col).Value[FWorkSheet] := '#N/D';
         end //dim_count = 1
         else begin
            if row < ARowCount then aRow := row + AFirstRow
               else if ARowCount = 1 then aRow := AFirstRow
                  else nodata := true;
            if col < AColCount then aCol := col + AFirstCol
               else if AColCount = 1 then aCol := AFirstCol
                  else nodata := true;
            if not(nodata) then
               FWorkSheet.FCells.GetOrCreateValue(FFirstRow + row, FFirstCol + col).Value[FWorkSheet] := Value[aRow, aCol]
            else
               FWorkSheet.FCells.GetOrCreateValue(FFirstRow + row, FFirstCol + col).Value[FWorkSheet] := '#N/D';
         end; //dim_count = 2
       end;  //for col...
     end;// for row...
   end //array
   else
     //single value
     for row := 0 to (FLastRow - FFirstRow) do begin
       for col := 0 to (FLastCol - FFirstCol) do begin
         FWorkSheet.FCells.GetOrCreateValue(FFirstRow + row, FFirstCol + col).Value[FWorkSheet] := Value;
       end;
     end;
  FWorksheet.FWorkbook.IncChangeID; 
end;

procedure TXLSRange.ExtendRange;
Var row, col: integer;
    CurCell: TXLSCellRef;
    MCell: TXLSCellRef;
    NewRange: boolean;
    FirstRow, LastRow: integer;
    FirstCol, LastCol: integer;
begin
     FirstRow := FFirstRow;
     LastRow := FLastRow;
     FirstCol := FFirstCol;
     LastCol := FLastCol;

     NewRange := true;
     while NewRange do begin
       NewRange := false;
       for row := 0 to (LastRow - FirstRow) do begin
         CurCell := FWorkSheet.FCells.GetValue(FirstRow + row, FirstCol); 
         if Assigned(CurCell) then begin
            if CurCell.Merged then begin
               MCell := CurCell.FMergeCell;
               if FirstCol > MCell.FCol then begin
                  FirstCol := MCell.FCol;
                  NewRange := true;
                  break;
               end;
               if (FirstCol = LastCol) and  
                  (LastCol < (MCell.FCol + MCell.FMergeColCount - 1)) then begin
                    LastCol := MCell.FCol + MCell.FMergeColCount - 1;
                    NewRange := true;
                    break;
               end;
            end;
         end;
         if (FirstCol <> LastCol) then begin
            CurCell := FWorkSheet.FCells.GetValue(FirstRow + row, LastCol); 
            if Assigned(CurCell) then begin
               if CurCell.Merged then begin
                  MCell := CurCell.FMergeCell;
                  if LastCol < (MCell.FCol + MCell.FMergeColCount - 1) then begin
                       LastCol := MCell.FCol + MCell.FMergeColCount - 1;
                       NewRange := true;
                       break;
                  end;
               end;
            end;
         end;
       end;

       if NewRange then continue;

       for col := 0 to (LastCol - FirstCol) do begin
         CurCell := FWorkSheet.FCells.GetValue(FirstRow, FirstCol + col); 
         if Assigned(CurCell) then begin
            if CurCell.Merged then begin
               MCell := CurCell.FMergeCell;
               if FirstRow > MCell.FRow then begin
                  FirstRow := MCell.FRow;
                  NewRange := true;
                  break;
               end;
               if (FirstRow = LastRow) and  
                  (LastRow < (MCell.FRow + MCell.FMergeRowCount - 1)) then begin
                    LastRow := MCell.FRow + MCell.FMergeRowCount - 1;
                    NewRange := true;
                    break;
               end;
            end;
         end;
         if (FirstRow <> LastRow) then begin
            CurCell := FWorkSheet.FCells.GetValue(LastRow, FirstCol + col); 
            if Assigned(CurCell) then begin
               if CurCell.Merged then begin
                  MCell := CurCell.FMergeCell;
                  if LastRow < (MCell.FRow + MCell.FMergeRowCount - 1) then begin
                       LastRow := MCell.FRow + MCell.FMergeRowCount - 1;
                       NewRange := true;
                       break;
                  end;
               end;
            end;
         end;
       end;
     end;
     
     FFirstRow := FirstRow;
     FLastRow := LastRow;
     FFirstCol := FirstCol;
     FLastCol := LastCol;
end;


procedure TXLSRange.ContractRange;
Var row, col: integer;
    CurCell: TXLSCellRef;
    MCell: TXLSCellRef;
    NewRange: boolean;
    FirstRow, LastRow: integer;
    FirstCol, LastCol: integer;
begin
     FirstRow := FFirstRow;
     LastRow := FLastRow;
     FirstCol := FFirstCol;
     LastCol := FLastCol;

     NewRange := true;
     while NewRange and (FirstRow <= LastRow) and  (FirstCol <= LastCol) do begin
       NewRange := false;
       for row := 0 to (LastRow - FirstRow) do begin
         CurCell := FWorkSheet.FCells.GetValue(FirstRow + row, FirstCol); 
         if Assigned(CurCell) then begin
            if CurCell.Merged then begin
               MCell := CurCell.FMergeCell;
               if (FirstCol > MCell.FCol) and
                  (FirstCol <= (MCell.FCol + MCell.FMergeColCount - 1)) then begin
                  FirstCol := MCell.FCol + MCell.FMergeColCount;
                  NewRange := true;
                  break;
               end;
               if (FirstCol = LastCol) and  
                  (LastCol >= MCell.FCol) and
                  (LastCol < (MCell.FCol + MCell.FMergeColCount - 1)) then begin
                    LastCol := MCell.FCol - 1;
                    NewRange := true;
                    break;
               end;
            end;
         end;
         if (FirstCol <> LastCol) then begin
            CurCell := FWorkSheet.FCells.GetValue(FirstRow + row, LastCol); 
            if Assigned(CurCell) then begin
               if CurCell.Merged then begin
                  MCell := CurCell.FMergeCell;
                  if (LastCol >= MCell.FCol) and
                     (LastCol < (MCell.FCol + MCell.FMergeColCount - 1)) then begin
                     LastCol := MCell.FCol - 1;
                     NewRange := true;
                     break;
                  end;
               end;
            end;
         end;
       end;

       if NewRange then continue;

       for col := 0 to (LastCol - FirstCol) do begin
         CurCell := FWorkSheet.FCells.GetValue(FirstRow, FirstCol + col); 
         if Assigned(CurCell) then begin
            if CurCell.Merged then begin
               MCell := CurCell.FMergeCell;
               if (FirstRow > MCell.FRow) and
                  (FirstRow <= (MCell.FRow + MCell.FMergeRowCount - 1)) then begin
                  FirstRow := MCell.FRow + MCell.FMergeRowCount;
                  NewRange := true;
                  break;
               end;
               if (FirstRow = LastRow) and  
                  (LastRow >= MCell.FRow) and
                  (LastRow < (MCell.FRow + MCell.FMergeRowCount - 1)) then begin
                    LastRow := MCell.FRow - 1;
                    NewRange := true;
                    break;
               end;
            end;
         end;
         if (FirstRow <> LastRow) then begin
            CurCell := FWorkSheet.FCells.GetValue(LastRow, FirstCol + col); 
            if Assigned(CurCell) then begin
               if CurCell.Merged then begin
                  MCell := CurCell.FMergeCell;
                  if (LastRow >= MCell.FRow) and
                     (LastRow < (MCell.FRow + MCell.FMergeRowCount - 1)) then begin
                     LastRow := MCell.FRow - 1;
                     NewRange := true;
                     break;
                  end;
               end;
            end;
         end;
       end;
     end;
     
    if (FirstRow <= LastRow) and
       (FirstCol <= LastCol) then begin
       FFirstRow := FirstRow;
       FLastRow := LastRow;
       FFirstCol := FirstCol;
       FLastCol := LastCol;
    end; 
end;

function TXLSRange.GetComment: TXLSComment;
begin
  Result := FWorksheet.FDrawing.Comments.GetComment(FFirstRow, FFirstCol);
end;

function TXLSRange.AddComment(AText: WideString): TXLSComment;
begin
  Result := AddComment;
  if Assigned(Result) then Result.Text := AText;
end;

function TXLSRange.AddComment: TXLSComment;
begin
  Result := FWorkSheet.FDrawing.Comments.AddComment(FFirstRow, FFirstCol);
end;

procedure TXLSRange.ClearComments;
Var row1, col1, row2, col2: integer;
begin
  row1 := FFirstRow; row2 := FLastRow; if row2 < row1 then swap(row1, row2);
  col1 := FFirstCol; col2 := FLastCol; if col2 < col1 then swap(col1, col2);
  FWorksheet._Drawing.Comments.ClearComments(row1, col1, row2, col2); 
end;

function TXLSRange.GetFontBold: boolean;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetFontBold(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetFontName: widestring;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetFontName(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetFontSize: Single;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetFontSize(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetFontColorIndex: LongWord;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetFontColorIndex(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetFontColor: LongWord;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetFontColor(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetFontThemeColor: LongWord;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetFontThemeColor(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetFontTintAndShade: double;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetFontTintAndShade(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetFontItalic: boolean;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetFontItalic(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetFontStrikethrough: boolean;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetFontStrikethrough(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetFontOutLineFont: boolean;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetFontOutLineFont(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetFontShadow: boolean;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetFontShadow(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetFontCharset: byte;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetFontCharset(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetFontFamily: byte;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetFontFamily(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetFontUnderLine: byte;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetFontUnderLine(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetFontSubScript: boolean;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetFontSubScript(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetFontSuperScript: boolean;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetFontSuperScript(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

procedure TXLSRange.SetFontBold(const Value: boolean);
begin
  SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetFontBold)
end;

procedure TXLSRange.SetFontColorIndex(const Value: LongWord);
begin
  SetXFProperty(Integer(Value), FWorkSheet.FWorkBook.FXFList.SetFontColorIndex)
end;

procedure TXLSRange.SetFontColor(const Value: LongWord);
begin
  SetXFProperty(Integer(Value), FWorkSheet.FWorkBook.FXFList.SetFontColor)
end;

procedure TXLSRange.SetFontThemeColor(const Value: LongWord);
begin
  SetXFProperty(Integer(Value), FWorkSheet.FWorkBook.FXFList.SetFontThemeColor)
end;


procedure TXLSRange.SetFontTintAndShade(const Value: double);
begin
  SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetFontTintAndShade)
end;

procedure TXLSRange.SetFontItalic(const Value: boolean);
begin
  SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetFontItalic)
end;


procedure TXLSRange.SetFontCharset(const Value: byte);
begin
  SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetFontCharset)
end;

procedure TXLSRange.SetFontFamily(const Value: byte);
begin
  SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetFontFamily)
end;

procedure TXLSRange.SetFontName(const Value: widestring);
begin
  SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetFontName)
end;

procedure TXLSRange.SetFontOutLineFont(const Value: boolean);
begin
  SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetFontOutLineFont)
end;

procedure TXLSRange.SetFontShadow(const Value: boolean);
begin
  SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetFontShadow)
end;

procedure TXLSRange.SetFontSize(const Value: Single);
begin
  SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetFontSize)
end;

procedure TXLSRange.SetFontStrikethrough(const Value: boolean);
begin
  SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetFontStrikethrough)
end;

procedure TXLSRange.SetFontSubScript(const Value: boolean);
begin
  SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetFontSubScript)
end;

procedure TXLSRange.SetFontSuperScript(const Value: boolean);
begin
  SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetFontSuperScript)
end;

procedure TXLSRange.SetFontUnderLine(const Value: byte);
begin
  SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetFontUnderLine)
end;

destructor TXLSRange.Destroy;
begin
  inherited Destroy;
end;

function TXLSRange.GetWidthInPixels: integer;
  Var col: integer;
      FAutoFit: TXLSAutoFit;
begin
  FAutoFit := TXLSAutoFit.Create(Self);
  Result := 0;
  try
    for col := 0 to (FLastCol - FFirstCol) do begin
      Result := Result + 
      FAutoFit.ExcelWidthToPixels(FWorkSheet.FColumnInfo.Width[FFirstCol + col]);
    end;
  finally
    FAutoFit.Free;
  end;
end;

function TXLSRange.GetWidth: double;
  Var col: integer;
      FAutoFit: TXLSAutoFit;
      w: integer;
begin
  FAutoFit := TXLSAutoFit.Create(Self);
  w := 0;
  try
    for col := 0 to (FLastCol - FFirstCol) do begin
      w := w + 
      FAutoFit.ExcelWidthToPixels(FWorkSheet.FColumnInfo.Width[FFirstCol + col]);
    end;
    Result := Round(FAutoFit.PixelsToExcelHeight(w)*100)/100;
  finally
    FAutoFit.Free;
  end;
end;

function TXLSRange.GetColumnWidth: OleVariant;
Var col: integer;
begin
  if (FLastCol = FFirstCol) then begin
    Result := FWorkSheet.FColumnInfo.Width[FFirstCol];
  end else begin
    Result := VarArrayCreate([0, FLastCol - FFirstCol], varVariant);
    for col := 0 to (FLastCol - FFirstCol) do begin
      Result[col] := FWorkSheet.FColumnInfo.Width[FFirstCol + col];
    end;
  end;
end;

procedure TXLSRange.SetColumnWidth(const Value: OleVariant);
Var vt: TVarType;
    col: integer;
    aCol: Integer;
    dim_count: integer;
    AColCount, AFirstCol: Integer;
    nodata: boolean;
begin
   aCol := 0;
   vt := VarType(Value);
   if (vt and varArray) > 0 then begin
     dim_count := VarArrayDimCount(Value);
     if (dim_count <> 1) then  exit;//exception
     AFirstCol := VarArrayLowBound(Value, 1);
     AColCount := VarArrayHighBound(Value, 1) - AFirstCol + 1;
     for col := 0 to (FLastCol - FFirstCol) do begin
       nodata := false;
       if col < AColCount then aCol := col + AFirstCol
       else if AColCount = 1 then aCol := AFirstCol
       else nodata := true;
       if not(nodata) then begin
          if Value[Col] > 255 then
             FWorkSheet.FColumnInfo.Width[FFirstCol + col] := 255
          else
             FWorkSheet.FColumnInfo.Width[FFirstCol + col] := Value[aCol];
       end;
     end;  //for col...
   end //array
   else begin
     //single value
     for col := 0 to (FLastCol - FFirstCol) do begin
        if Value > 255 then 
           FWorkSheet.FColumnInfo.Width[FFirstCol + col] := 255
        else
           FWorkSheet.FColumnInfo.Width[FFirstCol + col] := Value;
     end;
   end;
end;

function TXLSRange.GetRowHeight: OleVariant;
Var row: integer;
begin
  if (FLastRow = FFirstRow) then begin
    Result := FWorkSheet.FRowInfo.Height[FFirstRow];
  end else begin
    Result := VarArrayCreate([0, FLastRow - FFirstRow], varVariant);
    for row := 0 to (FLastRow - FFirstRow) do begin
      Result[row] := FWorkSheet.FRowInfo.Height[FFirstRow + row];
    end;
  end;
end;

procedure TXLSRange.SetRowHeight(const Value: OleVariant);
Var vt: TVarType;
    row: integer;
    aRow: Integer;
    dim_count: integer;
    ARowCount, AFirstRow: Integer;
    nodata: boolean;
begin
   aRow := 0;
   vt := VarType(Value);
   if (vt and varArray) > 0 then begin
     dim_count := VarArrayDimCount(Value);
     if (dim_count <> 1) then  exit;//exception
     AFirstRow := VarArrayLowBound(Value, 1);
     ARowCount := VarArrayHighBound(Value, 1) - AFirstRow + 1;
     for row := 0 to (FLastRow - FFirstRow) do begin
       nodata := false;
       if row < ARowCount then aRow := row + AFirstRow
       else if ARowCount = 1 then aRow := AFirstRow
       else nodata := true;
       if not(nodata) then
          FWorkSheet.FRowInfo.Height[FFirstRow + row] := Value[aRow]
     end;  //for col...
   end //array
   else
     //single value
     for row := 0 to (FLastRow - FFirstRow) do begin
        FWorkSheet.FRowInfo.Height[FFirstRow + row] := Value;
     end;
end;

function TXLSRange.GetColumnsHidden: OleVariant;
Var i: integer;
begin
  if (FLastCol = FFirstCol) then begin
     Result := FWorkSheet.FColumnInfo.Hidden[FFirstCol];
  end else begin
     Result := VarArrayCreate([0, FLastCol - FFirstCol], varVariant);
     for i := 0 to (FLastCol - FFirstCol) do begin
        Result[i] := FWorkSheet.FRowInfo.Hidden[FFirstCol + i];
     end;
  end;
end;

function TXLSRange.GetRowsHidden: OleVariant;
Var i: integer;
begin
   if (FLastRow = FFirstRow) then begin
      Result := FWorkSheet.FRowInfo.Hidden[FFirstRow];
   end else begin
      Result := VarArrayCreate([0, FLastRow - FFirstRow], varVariant);
      for i := 0 to (FLastRow - FFirstRow) do begin
         Result[i] := FWorkSheet.FRowInfo.Hidden[FFirstRow + i];
      end;
   end;
end;

procedure TXLSRange.SetRowsHidden(const Value: OleVariant);
Var vt: TVarType;
    i: integer;
    ai: Integer;
    dim_count: integer;
    ACount, AFirst: Integer;
    nodata: boolean;
begin
  ai := 0;
  vt := VarType(Value);
  if (vt and varArray) > 0 then begin
     dim_count := VarArrayDimCount(Value);
     if (dim_count <> 1) then  exit;//exception
     AFirst := VarArrayLowBound(Value, 1);
     ACount := VarArrayHighBound(Value, 1) - AFirst + 1;
     for i := 0 to (FLastRow - FFirstRow) do begin
         nodata := false;
         if i < ACount then ai := i + AFirst
         else if ACount = 1 then ai := AFirst
         else nodata := true;
         if not(nodata) then
            FWorkSheet.FRowInfo.Hidden[FFirstRow + i] := Value[ai];
     end;  //for row...
  end //array
  else
     //single value
    for i := 0 to (FLastRow - FFirstRow) do begin
       FWorkSheet.FRowInfo.Hidden[FFirstRow + i] := Value;
    end;
end;

procedure TXLSRange.SetColumnsHidden(const Value: OleVariant);
Var vt: TVarType;
    i: integer;
    ai: Integer;
    dim_count: integer;
    ACount, AFirst: Integer;
    nodata: boolean;
begin
  ai := 0;
  vt := VarType(Value);
  if (vt and varArray) > 0 then begin
     dim_count := VarArrayDimCount(Value);
     if (dim_count <> 1) then  exit;//exception
     AFirst := VarArrayLowBound(Value, 1);
     ACount := VarArrayHighBound(Value, 1) - AFirst + 1;
     for i := 0 to (FLastCol - FFirstCol) do begin
         nodata := false;
         if i < ACount then ai := i + AFirst
         else if ACount = 1 then ai := AFirst
         else nodata := true;
         if not(nodata) then
                FWorkSheet.FColumnInfo.Hidden[FFirstCol + i] := Value[ai];
     end;  //for col...
  end //array
  else
    //single value
    for i := 0 to (FLastCol - FFirstCol) do begin
       FWorkSheet.FColumnInfo.Hidden[FFirstCol + i] := Value;
    end;
end;

procedure TXLSRange.Select;
begin
  ExtendRange;
  FWorkSheet.FSelection := TXLSRange.Create(FWorkSheet, FFirstRow, FFirstCol, FLastRow, FLastCol);
end;

procedure TXLSRange.SetXFProperty(const Value: OleVariant;
  SetFunc: TSetXFProperty);
Var  CurCell: TXLSCellRef;
     CurXFIndex: integer;
     ReplaceCurXFIndex: boolean;
     row, col: integer;
     imin, imax: integer;
     LastIndex, NewIndex : Integer;
     UsedRange: IXLSRange;
     RangeType: integer;
     //colinfo: TXLSColumnInfo;
begin
  RangeType := GetRangeType;
  case RangeType of
    0: begin
         LastIndex := -1;
         NewIndex := -1;
         for row := FFirstRow to FLastRow do begin
           for col := FFirstCol to FLastCol do begin
             CurCell := FWorkSheet.FCells.GetOrCreateValue(row, col);
             if not(CurCell.Merged) or (CurCell.FMergeCell = CurCell) then begin

                //must be replaced to function
                CurXFIndex := GetXFIndex(row, col, ReplaceCurXFIndex);

                if LastIndex = CurXFIndex then begin
                   if ReplaceCurXFIndex then begin
                      FWorkSheet.FWorkBook.FXFList.ReplaceIndex(LastIndex, NewIndex);
                   end else begin
                      FWorkSheet.FWorkBook.FXFList.IncReferredCount(NewIndex);
                   end;
                   CurCell.FXFIndex := NewIndex;
                end
                else begin
                   LastIndex := CurXFIndex;
                   NewIndex := SetFunc(LastIndex, Value, ReplaceCurXFIndex);
                   CurCell.FXFIndex := NewIndex;
                end;
              end;
           end;
         end;
       end;
   1:begin
        {columns}
        UsedRange := FWorkSheet.UsedRange;
        imin := UsedRange.FirstRow;
        imax := UsedRange.LastRow;

        if FWorkSheet.FRowInfo.RowCount > 0 then begin
           if FWorkSheet.FRowInfo.MinRow < imin then
               imin := FWorkSheet.FRowInfo.MinRow;
           if FWorkSheet.FRowInfo.MaxRow > imax then
               imax := FWorkSheet.FRowInfo.MaxRow;
        end;

        for col := FFirstCol to FLastCol do begin
            LastIndex := FWorkSheet.FColumnInfo.XFIndex[col];
            NewIndex := SetFunc(LastIndex, Value, true);
            FWorkSheet.FColumnInfo.XFIndex[col] := NewIndex;

            for row := imin to imax do begin
               CurXFIndex := GetXFIndex(row, col, ReplaceCurXFIndex);
               if LastIndex <> CurXFIndex then begin
                  LastIndex := CurXFIndex;
                  NewIndex := SetFunc(LastIndex, Value, ReplaceCurXFIndex);
               end;

               if LastIndex <> NewIndex then begin
                  FWorksheet._SetXF(row, col, NewIndex);
               end;
            end;
        end;
     end;
   2: begin
        {rows}
        UsedRange := FWorkSheet.UsedRange;
        imin := UsedRange.FirstCol;
        imax := UsedRange.LastCol;

        for row := FFirstRow to FLastRow do begin

            LastIndex := FWorkSheet.FRowInfo.XFIndex[row];
            NewIndex := SetFunc(LastIndex, Value, true);
            FWorkSheet.FRowInfo.XFIndex[row] := NewIndex;

            for col := imin to imax do begin
               CurXFIndex := GetXFIndex(row, col, ReplaceCurXFIndex);
               if LastIndex <> CurXFIndex then begin
                  LastIndex := CurXFIndex;
                  NewIndex := SetFunc(LastIndex, Value, ReplaceCurXFIndex);
               end;

               if LastIndex <> NewIndex then begin
                  FWorksheet._SetXF(row, col, NewIndex);
               end;
            end;
        end;
      end;
    end;
end;

function TXLSRange.GetRangeType: integer;
begin
  Result := 0;
  if (FFirstCol = 0) and 
     ((FLastCol = XLSMaxCol) or (FLastCol = XLSXMaxCol)) then Result := 2;
  if (FFirstRow = 0) and 
     ((FLastRow = XLSMaxRow) or (FLastRow = XLSXMaxRow)) then Result := 1;
end;

function TXLSRange.GetInterior: IXLSInterior;
begin
  Result := TXLSInterior.Create(self);
end;

function TXLSRange.GetFont: IXLSFont;
begin
  Result := TXLSFont.Create(self);
end;

procedure TXLSRange.SetInteriorColorIndex(const Value: longword);
begin
  SetXFProperty(integer(Value), FWorkSheet.FWorkBook.FXFList.SetInteriorColorIndex)
end;

procedure TXLSRange.SetInteriorColor(const Value: longword);
begin
  SetXFProperty(integer(Value), FWorkSheet.FWorkBook.FXFList.SetInteriorColor)
end;

procedure TXLSRange.SetInteriorThemeColor(const Value: longword);
begin
  SetXFProperty(integer(Value), FWorkSheet.FWorkBook.FXFList.SetInteriorThemeColor)
end;

procedure TXLSRange.SetInteriorTintAndShade(const Value: double);
begin
  SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetInteriorTintAndShade);
end;

procedure TXLSRange.SetInteriorPattern(const Value: word);
begin
  SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetInteriorPattern)
end;

procedure TXLSRange.SetInteriorPatternColorIndex(const Value: longword);
begin
  SetXFProperty(integer(Value), FWorkSheet.FWorkBook.FXFList.SetInteriorPatternColorIndex)
end;

procedure TXLSRange.SetInteriorPatternColor(const Value: longword);
begin
  SetXFProperty(integer(Value), FWorkSheet.FWorkBook.FXFList.SetInteriorPatternColor)
end;

procedure TXLSRange.SetInteriorPatternThemeColor(const Value: longword);
begin
  SetXFProperty(integer(Value), FWorkSheet.FWorkBook.FXFList.SetInteriorPatternThemeColor)
end;

procedure TXLSRange.SetInteriorPatternTintAndShade(const Value: double);
begin
  SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetInteriorPatternTintAndShade)
end;

function TXLSRange.GetInteriorColorIndex: longword;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetInteriorColorIndex(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetInteriorColor: longword;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetInteriorColor(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetInteriorThemeColor: longword;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetInteriorThemeColor(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetInteriorTintAndShade: double;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetInteriorTintAndShade(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;


function TXLSRange.GetWrapText: OleVariant;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetWrap(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

procedure TXLSRange.SetWrapText(const Value: OleVariant);
begin
  SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetWrap)
end;

function TXLSRange.GetOrientation: OleVariant;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetOrientation(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
  if (Result <> 255) and (Result > 90) then Result := 90 - Result;
end;

procedure TXLSRange.SetOrientation(const Value: OleVariant);
Var iValue: integer; 
begin
  iValue := integer(Value);
  if iValue < 0 then iValue := 90 - iValue;
  if not((iValue > 180) and (iValue <> 255)) then 
     SetXFProperty(iValue, FWorkSheet.FWorkBook.FXFList.SetOrientation)
end;


function TXLSRange.GetInteriorPattern: word;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetInteriorPattern(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetInteriorPatternColorIndex: longword;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetInteriorPatternColorIndex(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetInteriorPatternColor: longword;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetInteriorPatternColor(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetInteriorPatternThemeColor: longword;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetInteriorPatternThemeColor(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetInteriorPatternTintAndShade: double;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetInteriorPatternTintAndShade(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

function TXLSRange.GetBorders: IXLSBorders;
begin
  Result := TXLSBorders.Create(self);
end;

function TXLSRange.GetBorderColorIndex(const BorderIndex: LongWord): LongWord;
begin
  Result := 0;
  case BorderIndex of
     xlDiagonalDown:     Result := GetBorderDiagonalDownColorIndex;
     xlDiagonalUp:       Result := GetBorderDiagonalUpColorIndex;
     xlEdgeLeft:         Result := GetBorderLeftColorIndex;
     xlEdgeTop:          Result := GetBorderTopColorIndex;
     xlEdgeBottom:       Result := GetBorderBottomColorIndex;
     xlEdgeRight:        Result := GetBorderRightColorIndex;
     xlInsideVertical:   Result := GetBorderVerticalInsideColorIndex;
     xlInsideHorizontal: Result := GetBorderHorizontalInsideColorIndex;
     xlAround:           Result := GetBorderAroundColorIndex;
     xlInsideAll:        Result := GetBorderInsideAllColorIndex;
  end;
end;

function TXLSRange.GetBorderColor(const BorderIndex: LongWord): LongWord;
begin
  Result := 0;
  case BorderIndex of
     xlDiagonalDown:     Result := GetBorderDiagonalDownColor;
     xlDiagonalUp:       Result := GetBorderDiagonalUpColor;
     xlEdgeLeft:         Result := GetBorderLeftColor;
     xlEdgeTop:          Result := GetBorderTopColor;
     xlEdgeBottom:       Result := GetBorderBottomColor;
     xlEdgeRight:        Result := GetBorderRightColor;
     xlInsideVertical:   Result := GetBorderVerticalInsideColor;
     xlInsideHorizontal: Result := GetBorderHorizontalInsideColor;
     xlAround:           Result := GetBorderTopColor;
     xlInsideAll:        Result := GetBorderVerticalInsideColor;
  end;
end;

function TXLSRange.GetBorderThemeColor(const BorderIndex: LongWord): LongWord;
begin
  Result := 0;
  case BorderIndex of
     xlDiagonalDown:     Result := GetBorderDiagonalDownThemeColor;
     xlDiagonalUp:       Result := GetBorderDiagonalUpThemeColor;
     xlEdgeLeft:         Result := GetBorderLeftThemeColor;
     xlEdgeTop:          Result := GetBorderTopThemeColor;
     xlEdgeBottom:       Result := GetBorderBottomThemeColor;
     xlEdgeRight:        Result := GetBorderRightThemeColor;
     xlInsideVertical:   Result := GetBorderVerticalInsideThemeColor;
     xlInsideHorizontal: Result := GetBorderHorizontalInsideThemeColor;
     xlAround:           Result := GetBorderTopThemeColor;
     xlInsideAll:        Result := GetBorderVerticalInsideThemeColor;
  end;
end;

function TXLSRange.GetBorderTintAndShade(const BorderIndex: LongWord): double;
begin
  Result := 0;
  case BorderIndex of
     xlDiagonalDown:     Result := GetBorderDiagonalDownTintAndShade;
     xlDiagonalUp:       Result := GetBorderDiagonalUpTintAndShade;
     xlEdgeLeft:         Result := GetBorderLeftTintAndShade;
     xlEdgeTop:          Result := GetBorderTopTintAndShade;
     xlEdgeBottom:       Result := GetBorderBottomTintAndShade;
     xlEdgeRight:        Result := GetBorderRightTintAndShade;
     xlInsideVertical:   Result := GetBorderVerticalInsideTintAndShade;
     xlInsideHorizontal: Result := GetBorderHorizontalInsideTintAndShade;
     xlAround:           Result := GetBorderTopTintAndShade;
     xlInsideAll:        Result := GetBorderVerticalInsideTintAndShade;
  end;
end;

function TXLSRange.GetCellBorderColorIndex(Row1, Col1, Row2, Col2: integer; isVertical: boolean): LongWord;
Var  Index: integer;
     BorderMask1, BorderMask2: byte;
     ResultDefined: boolean;
     ReplaceCurXFIndex: boolean;
begin
   Result := xlColorIndexNone;
   ResultDefined := false;
   if isVertical then begin
      BorderMask1 := 2; BorderMask2 := 1;
   end else begin
      BorderMask1 := 8; BorderMask2 := 4;
   end;
   if (Row1 >= 0) and (Col1 >= 0) and (Row1 <= XLSXMaxRow) and (Col1 <= XLSXMaxCol) then begin
      Index := GetXFIndex(Row1, Col1, ReplaceCurXFIndex);
      if FWorkSheet.FWorkBook.FXFList.GetBordersDefined(Index) then begin
         if FWorkSheet.FWorkBook.FXFList.GetBorderLineStyle(Index, BorderMask1) <> xlLineStyleNone then begin
            Result := FWorkSheet.FWorkBook.FXFList.GetBorderColorIndex(Index, BorderMask1);
            ResultDefined := true;
         end;
      end;
   end;
   if (Row2 >= 0) and (Col2 >= 0) and (Row2 <= XLSXMaxRow) and (Col2 <= XLSXMaxCol) then begin
     if not(ResultDefined) then begin
        Index := GetXFIndex(Row2, Col2, ReplaceCurXFIndex);
        if FWorkSheet.FWorkBook.FXFList.GetBordersDefined(Index) then begin
           if FWorkSheet.FWorkBook.FXFList.GetBorderLineStyle(Index, BorderMask2) <> xlLineStyleNone then begin
              Result := FWorkSheet.FWorkBook.FXFList.GetBorderColorIndex(Index, BorderMask2);
           end;
         end;
     end;
   end;
end;

function TXLSRange.GetCellBorderColor(Row1, Col1, Row2, Col2: integer; isVertical: boolean): LongWord;
Var  Index: integer;
     BorderMask1, BorderMask2: byte;
     ResultDefined: boolean;
     ReplaceCurXFIndex: boolean;
begin
   Result := 0;
   ResultDefined := false;
   if isVertical then begin
      BorderMask1 := 2; BorderMask2 := 1;
   end else begin
      BorderMask1 := 8; BorderMask2 := 4;
   end;
   if (Row1 >= 0) and (Col1 >= 0) and (Row1 <= XLSXMaxRow) and (Col1 <= XLSXMaxCol) then begin
      Index := GetXFIndex(Row1, Col1, ReplaceCurXFIndex);
      if FWorkSheet.FWorkBook.FXFList.GetBordersDefined(Index) then begin
         if FWorkSheet.FWorkBook.FXFList.GetBorderLineStyle(Index, BorderMask1) <> xlLineStyleNone then begin
            Result := FWorkSheet.FWorkBook.FXFList.GetBorderColor(Index, BorderMask1);
            ResultDefined := true;
         end;
      end;
   end;
   if (Row2 >= 0) and (Col2 >= 0) and (Row2 <= XLSXMaxRow) and (Col2 <= XLSXMaxCol) then begin
     if not(ResultDefined) then begin
        Index := GetXFIndex(Row2, Col2, ReplaceCurXFIndex);
        if FWorkSheet.FWorkBook.FXFList.GetBordersDefined(Index) then begin
           if FWorkSheet.FWorkBook.FXFList.GetBorderLineStyle(Index, BorderMask2) <> xlLineStyleNone then begin
              Result := FWorkSheet.FWorkBook.FXFList.GetBorderColor(Index, BorderMask2);
           end;
         end;
     end;
   end;
end;

function TXLSRange.GetCellBorderThemeColor(Row1, Col1, Row2, Col2: integer; isVertical: boolean): LongWord;
Var  Index: integer;
     BorderMask1, BorderMask2: byte;
     ResultDefined: boolean;
     ReplaceCurXFIndex: boolean;
begin
   Result := 0;
   ResultDefined := false;
   if isVertical then begin
      BorderMask1 := 2; BorderMask2 := 1;
   end else begin
      BorderMask1 := 8; BorderMask2 := 4;
   end;
   if (Row1 >= 0) and (Col1 >= 0) and (Row1 <= XLSXMaxRow) and (Col1 <= XLSXMaxCol) then begin
      Index := GetXFIndex(Row1, Col1, ReplaceCurXFIndex);
      if FWorkSheet.FWorkBook.FXFList.GetBordersDefined(Index) then begin
         if FWorkSheet.FWorkBook.FXFList.GetBorderLineStyle(Index, BorderMask1) <> xlLineStyleNone then begin
            Result := FWorkSheet.FWorkBook.FXFList.GetBorderThemeColor(Index, BorderMask1);
            ResultDefined := true;
         end;
      end;
   end;
   if (Row2 >= 0) and (Col2 >= 0) and (Row2 <= XLSXMaxRow) and (Col2 <= XLSXMaxCol) then begin
     if not(ResultDefined) then begin
        Index := GetXFIndex(Row2, Col2, ReplaceCurXFIndex);
        if FWorkSheet.FWorkBook.FXFList.GetBordersDefined(Index) then begin
           if FWorkSheet.FWorkBook.FXFList.GetBorderLineStyle(Index, BorderMask2) <> xlLineStyleNone then begin
              Result := FWorkSheet.FWorkBook.FXFList.GetBorderThemeColor(Index, BorderMask2);
           end;
         end;
     end;
   end;
end;

function TXLSRange.GetCellBorderTintAndShade(Row1, Col1, Row2, Col2: integer; isVertical: boolean): double;
Var  Index: integer;
     BorderMask1, BorderMask2: byte;
     ResultDefined: boolean;
     ReplaceCurXFIndex: boolean;
begin
   Result := 0;
   ResultDefined := false;
   if isVertical then begin
      BorderMask1 := 2; BorderMask2 := 1;
   end else begin
      BorderMask1 := 8; BorderMask2 := 4;
   end;
   if (Row1 >= 0) and (Col1 >= 0) and (Row1 <= XLSXMaxRow) and (Col1 <= XLSXMaxCol) then begin
      Index := GetXFIndex(Row1, Col1, ReplaceCurXFIndex);
      if FWorkSheet.FWorkBook.FXFList.GetBordersDefined(Index) then begin
         if FWorkSheet.FWorkBook.FXFList.GetBorderLineStyle(Index, BorderMask1) <> xlLineStyleNone then begin
            Result := FWorkSheet.FWorkBook.FXFList.GetBorderTintAndShade(Index, BorderMask1);
            ResultDefined := true;
         end;
      end;
   end;
   if (Row2 >= 0) and (Col2 >= 0) and (Row2 <= XLSXMaxRow) and (Col2 <= XLSXMaxCol) then begin
     if not(ResultDefined) then begin
        Index := GetXFIndex(Row2, Col2, ReplaceCurXFIndex);
        if FWorkSheet.FWorkBook.FXFList.GetBordersDefined(Index) then begin
           if FWorkSheet.FWorkBook.FXFList.GetBorderLineStyle(Index, BorderMask2) <> xlLineStyleNone then begin
              Result := FWorkSheet.FWorkBook.FXFList.GetBorderTintAndShade(Index, BorderMask2);
           end;
         end;
     end;
   end;
end;


function TXLSRange.GetCellBorderLineStyle(Row1, Col1, Row2, Col2: integer;
  isVertical: boolean): LongWord;
Var  Index: integer;
     BorderMask1, BorderMask2: byte;
     ResultDefined: boolean;
     ReplaceCurXFIndex: boolean;
begin
   Result := xlLineStyleNone;
   ResultDefined := false;
   if isVertical then begin
      BorderMask1 := 2; BorderMask2 := 1;
   end else begin
      BorderMask1 := 8; BorderMask2 := 4;
   end;

   if (Row1 >= 0) and (Row1 <= XLSXMaxRow) and 
      (Col1 >= 0) and (Col1 <= XLSXMaxCol) then begin
     Index := GetXFIndex(Row1, Col1, ReplaceCurXFIndex);
     if FWorkSheet.FWorkBook.FXFList.GetBordersDefined(Index) then begin
        Result := FWorkSheet.FWorkBook.FXFList.GetBorderLineStyle(Index, BorderMask1);
        if Result <> xlLineStyleNone then ResultDefined := true;
     end;
   end;

   if (Row2 >= 0) and (Row2 <= XLSXMaxRow) and 
      (Col2 >= 0) and (Col2 <= XLSXMaxCol) then begin
     if not(ResultDefined) then begin
       Index := GetXFIndex(Row2, Col2, ReplaceCurXFIndex);
       if FWorkSheet.FWorkBook.FXFList.GetBordersDefined(Index) then begin
          Result := FWorkSheet.FWorkBook.FXFList.GetBorderLineStyle(Index, BorderMask2);
       end;
     end;
   end;
end;

function TXLSRange.GetCellBorderLineWeight(Row1, Col1, Row2, Col2: integer;
  isVertical: boolean): LongWord;
Var  Index: integer;
     BorderMask1, BorderMask2: byte;
     ResultDefined: boolean;
     ReplaceCurXFIndex: boolean;
begin
   Result := xlThin;
   ResultDefined := false;
   if isVertical then begin
      BorderMask1 := 2; BorderMask2 := 1;
   end else begin
      BorderMask1 := 8; BorderMask2 := 4;
   end;
   if (Row1 >= 0) and (Col1 >= 0) and (Row1 <= XLSXMaxRow) and (Col1 <= XLSXMaxCol) then begin
     Index := GetXFIndex(Row1, Col1, ReplaceCurXFIndex);
     if FWorkSheet.FWorkBook.FXFList.GetBordersDefined(Index) then begin
        Result := FWorkSheet.FWorkBook.FXFList.GetBorderWeight(Index, BorderMask1);
        if Result <> xlThin then ResultDefined := true;
     end;
   end;
   if (Row2 >= 0) and (Col2 >= 0) and (Row2 <= XLSXMaxRow) and (Col2 <= XLSXMaxCol) then begin
     if not(ResultDefined) then begin
         Index := GetXFIndex(Row2, Col2, ReplaceCurXFIndex);
         if FWorkSheet.FWorkBook.FXFList.GetBordersDefined(Index) then begin
            Result := FWorkSheet.FWorkBook.FXFList.GetBorderWeight(Index, BorderMask2);
         end;
      end;
   end;
end;

function TXLSRange.GetBorderDiagonalDownColorIndex: LongWord;
var ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetBorderColorIndex(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex), 16);
end;

function TXLSRange.GetBorderDiagonalUpColorIndex: LongWord;
var ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetBorderColorIndex(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex), 32);
end;

function TXLSRange.GetBorderDiagonalDownLineStyle: LongWord;
var ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetBorderLineStyle(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex), 16);
end;

function TXLSRange.GetBorderDiagonalUpLineStyle: LongWord;
var ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetBorderLineStyle(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex), 32);
end;

function TXLSRange.GetBorderDiagonalDownLineWeight: LongWord;
var ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetBorderWeight(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex), 16);
end;

function TXLSRange.GetBorderDiagonalUpLineWeight: LongWord;
var ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetBorderWeight(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex), 32);
end;

function TXLSRange.GetBorderLeftColorIndex: LongWord;
begin
   Result := GetCellBorderColorIndex(FFirstRow, FFirstCol - 1, FFirstRow, FFirstCol, true);
end;

function TXLSRange.GetBorderRightColorIndex: LongWord;
begin
   Result := GetCellBorderColorIndex(FLastRow, FLastCol, FLastRow, FLastCol + 1, true);
end;

function TXLSRange.GetBorderVerticalInsideColorIndex: LongWord;
begin
   Result := 0;
   if FFirstCol >= FLastCol then exit;
   Result := GetCellBorderColorIndex(FFirstRow, FFirstCol, FFirstRow, FFirstCol + 1, true);
end;

function TXLSRange.GetBorderTopColorIndex: LongWord;
begin
   Result := GetCellBorderColorIndex(FFirstRow - 1, FFirstCol, FFirstRow, FFirstCol, false);
end;


function TXLSRange.GetBorderBottomColorIndex: LongWord;
begin
   Result := GetCellBorderColorIndex(FLastRow, FLastCol, FLastRow + 1, FLastCol, false);
end;

function TXLSRange.GetBorderHorizontalInsideColorIndex: LongWord;
begin
   Result := 0;
   if FFirstRow >= FLastRow then exit;
   Result := GetCellBorderColorIndex(FFirstRow, FFirstCol, FFirstRow + 1, FFirstCol, false);
end;

function TXLSRange.GetBorderAroundColorIndex: LongWord;
begin
   Result := GetBorderTopColorIndex;
end;

function TXLSRange.GetBorderAllColorIndex: LongWord;
Var bstyle: integer;
    Index: integer;
    res: LongWord;
    ReplaceCurXFIndex: boolean;
begin
  bstyle := GetBorderAllStyle;
  if bstyle = 0 then begin
     Result := xlColorIndexNone;
  end else if bstyle = -1 then begin
     Result := 0;
  end else begin
     Index := GetXFIndex(FFirstRow, FFirstCol, ReplaceCurXFIndex);
     Result := FWorkSheet.FWorkBook.FXFList.GetBorderColorIndex(Index, 1);
     res := FWorkSheet.FWorkBook.FXFList.GetBorderColorIndex(Index, 2);
   if Result <> res then Result := 0;
   if Result = 0 then exit;
     res := FWorkSheet.FWorkBook.FXFList.GetBorderColorIndex(Index, 4);
   if Result <> res then Result := 0;
   if Result = 0 then exit;
     res := FWorkSheet.FWorkBook.FXFList.GetBorderColorIndex(Index, 8);
   if Result <> res then Result := 0;
end;
end;

function TXLSRange.GetBorderInsideAllColorIndex: LongWord;
Var res: Longword;
begin
   Result := GetBorderHorizontalInsideColorIndex;
   if Result = 0 then exit;
   res := GetBorderVerticalInsideColorIndex;
   if Result <> res then Result := 0;
end;

function TXLSRange.GetBorderLeftColor: LongWord;
Var  Row1, Col1, Row2, Col2: integer;
begin
   Row1 := FFirstRow;
   Col1 := FFirstCol - 1;
   Row2 := FFirstRow;
   Col2 := FFirstCol;
   Result := GetCellBorderColor(Row1, Col1, Row2, Col2, true);
end;

function TXLSRange.GetBorderRightColor: LongWord;
Var  Row1, Col1, Row2, Col2: integer;
begin
   Row1 := FFirstRow;
   Col1 := FLastCol;
   Row2 := FFirstRow;
   Col2 := FLastCol + 1;
   Result := GetCellBorderColor(Row1, Col1, Row2, Col2, true);
end;

function TXLSRange.GetBorderDiagonalDownColor: LongWord;
var ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetBorderColor(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex), 16);
end;

function TXLSRange.GetBorderDiagonalUpColor: LongWord;
var ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetBorderColor(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex), 32);
end;

function TXLSRange.GetBorderVerticalInsideColor: LongWord;
Var  Row1, Col1, Row2, Col2: integer;
begin
   Result := 0;
   Row1 := FFirstRow;
   Col1 := FFirstCol;
   Row2 := FFirstRow;
   Col2 := FFirstCol + 1;
   if Col2 <= FLastCol then
      Result := GetCellBorderColor(Row1, Col1, Row2, Col2, true);
end;

function TXLSRange.GetBorderTopColor: LongWord;
Var  Row1, Col1, Row2, Col2: integer;
begin
   Row1 := FFirstRow - 1;
   Col1 := FFirstCol;
   Row2 := FFirstRow;
   Col2 := FFirstCol;
   Result := GetCellBorderColor(Row1, Col1, Row2, Col2, false);
end;

function TXLSRange.GetBorderBottomColor: LongWord;
Var  Row1, Col1, Row2, Col2: integer;
begin
   Row1 := FLastRow;
   Col1 := FFirstCol;
   Row2 := FLastRow + 1;
   Col2 := FFirstCol;
   Result := GetCellBorderColor(Row1, Col1, Row2, Col2, false);
end;

function TXLSRange.GetBorderHorizontalInsideColor: LongWord;
Var  Row1, Col1, Row2, Col2: integer;
begin
   Result := 0;
   Row1 := FFirstRow;
   Col1 := FFirstCol;
   Row2 := FFirstRow + 1;
   Col2 := FFirstCol;
   if Row2 <= FLastRow then
      Result := GetCellBorderColor(Row1, Col1, Row2, Col2, false);
end;


function  TXLSRange.GetBorderDiagonalDownThemeColor: LongWord;
var ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetBorderThemeColor(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex), 16);
end;

function  TXLSRange.GetBorderDiagonalUpThemeColor: LongWord;
var ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetBorderThemeColor(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex), 32);
end;

function TXLSRange.GetBorderLeftThemeColor: LongWord;
Var  Row1, Col1, Row2, Col2: integer;
begin
   Row1 := FFirstRow;
   Col1 := FFirstCol - 1;
   Row2 := FFirstRow;
   Col2 := FFirstCol;
   Result := GetCellBorderThemeColor(Row1, Col1, Row2, Col2, true);
end;

function TXLSRange.GetBorderRightThemeColor: LongWord;
Var  Row1, Col1, Row2, Col2: integer;
begin
   Row1 := FFirstRow;
   Col1 := FLastCol;
   Row2 := FFirstRow;
   Col2 := FLastCol + 1;
   Result := GetCellBorderThemeColor(Row1, Col1, Row2, Col2, true);
end;


function TXLSRange.GetBorderVerticalInsideThemeColor: LongWord;
Var  Row1, Col1, Row2, Col2: integer;
begin
   Result := 0;
   Row1 := FFirstRow;
   Col1 := FFirstCol;
   Row2 := FFirstRow;
   Col2 := FFirstCol + 1;
   if Col2 <= FLastCol then
      Result := GetCellBorderThemeColor(Row1, Col1, Row2, Col2, true);
end;

function TXLSRange.GetBorderTopThemeColor: LongWord;
Var  Row1, Col1, Row2, Col2: integer;
begin
   Row1 := FFirstRow - 1;
   Col1 := FFirstCol;
   Row2 := FFirstRow;
   Col2 := FFirstCol;
   Result := GetCellBorderThemeColor(Row1, Col1, Row2, Col2, false);
end;

function TXLSRange.GetBorderBottomThemeColor: LongWord;
Var  Row1, Col1, Row2, Col2: integer;
begin
   Row1 := FLastRow;
   Col1 := FFirstCol;
   Row2 := FLastRow + 1;
   Col2 := FFirstCol;
   Result := GetCellBorderThemeColor(Row1, Col1, Row2, Col2, false);
end;

function TXLSRange.GetBorderHorizontalInsideThemeColor: LongWord;
Var  Row1, Col1, Row2, Col2: integer;
begin
   Result := 0;
   Row1 := FFirstRow;
   Col1 := FFirstCol;
   Row2 := FFirstRow + 1;
   Col2 := FFirstCol;
   if Row2 <= FLastRow then
      Result := GetCellBorderThemeColor(Row1, Col1, Row2, Col2, false);
end;



function TXLSRange.GetBorderDiagonalDownTintAndShade: double;
var ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetBorderTintAndShade(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex), 16);
end;

function TXLSRange.GetBorderDiagonalUpTintAndShade: double;
var ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetBorderTintAndShade(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex), 32);
end;

function TXLSRange.GetBorderLeftTintAndShade: double;
Var  Row1, Col1, Row2, Col2: integer;
begin
   Row1 := FFirstRow;
   Col1 := FFirstCol - 1;
   Row2 := FFirstRow;
   Col2 := FFirstCol;
   Result := GetCellBorderTintAndShade(Row1, Col1, Row2, Col2, true);
end;

function TXLSRange.GetBorderRightTintAndShade: double;
Var  Row1, Col1, Row2, Col2: integer;
begin
   Row1 := FFirstRow;
   Col1 := FLastCol;
   Row2 := FFirstRow;
   Col2 := FLastCol + 1;
   Result := GetCellBorderTintAndShade(Row1, Col1, Row2, Col2, true);
end;


function TXLSRange.GetBorderVerticalInsideTintAndShade: double;
Var  Row1, Col1, Row2, Col2: integer;
begin
   Result := 0;
   Row1 := FFirstRow;
   Col1 := FFirstCol;
   Row2 := FFirstRow;
   Col2 := FFirstCol + 1;
   if Col2 <= FLastCol then
      Result := GetCellBorderTintAndShade(Row1, Col1, Row2, Col2, true);
end;

function TXLSRange.GetBorderTopTintAndShade: double;
Var  Row1, Col1, Row2, Col2: integer;
begin
   Row1 := FFirstRow - 1;
   Col1 := FFirstCol;
   Row2 := FFirstRow;
   Col2 := FFirstCol;
   Result := GetCellBorderTintAndShade(Row1, Col1, Row2, Col2, false);
end;

function TXLSRange.GetBorderBottomTintAndShade: double;
Var  Row1, Col1, Row2, Col2: integer;
begin
   Row1 := FLastRow;
   Col1 := FFirstCol;
   Row2 := FLastRow + 1;
   Col2 := FFirstCol;
   Result := GetCellBorderTintAndShade(Row1, Col1, Row2, Col2, false);
end;

function TXLSRange.GetBorderHorizontalInsideTintAndShade: double;
Var  Row1, Col1, Row2, Col2: integer;
begin
   Result := 0;
   Row1 := FFirstRow;
   Col1 := FFirstCol;
   Row2 := FFirstRow + 1;
   Col2 := FFirstCol;
   if Row2 <= FLastRow then
      Result := GetCellBorderTintAndShade(Row1, Col1, Row2, Col2, false);
end;


function TXLSRange.GetBorderLineStyle(
  const BorderIndex: LongWord): LongWord;
begin
  Result := xlLineStyleNone;
  case BorderIndex of
     xlDiagonalDown:     Result := GetBorderDiagonalDownLineStyle;
     xlDiagonalUp:       Result := GetBorderDiagonalUpLineStyle;
     xlEdgeLeft:         Result := GetBorderLeftLineStyle;
     xlEdgeTop:          Result := GetBorderTopLineStyle;
     xlEdgeBottom:       Result := GetBorderBottomLineStyle;
     xlEdgeRight:        Result := GetBorderRightLineStyle;
     xlInsideVertical:   Result := GetBorderVerticalInsideLineStyle;
     xlInsideHorizontal: Result := GetBorderHorizontalInsideLineStyle;
     xlAround:           Result := GetBorderAroundLineStyle;
     xlInsideAll:        Result := GetBorderInsideAllLineStyle;
  end;
end;

function TXLSRange.GetBorderWeight(const BorderIndex: LongWord): LongWord;
begin
  Result := xlThin;
  case BorderIndex of
     xlDiagonalDown:     Result := GetBorderDiagonalDownLineWeight;
     xlDiagonalUp:       Result := GetBorderDiagonalUpLineWeight;
     xlEdgeLeft:         Result := GetBorderLeftLineWeight;
     xlEdgeTop:          Result := GetBorderTopLineWeight;
     xlEdgeBottom:       Result := GetBorderBottomLineWeight;
     xlEdgeRight:        Result := GetBorderRightLineWeight;
     xlInsideVertical:   Result := GetBorderVerticalInsideLineWeight;
     xlInsideHorizontal: Result := GetBorderHorizontalInsideLineWeight;
     xlAround:           Result := GetBorderAroundLineWeight;
     xlInsideAll:        Result := GetBorderInsideAllLineWeight;
  end;
end;

procedure TXLSRange.SetBordersProperty(Value: LongWord; SetFunc: TSetXFBorderProperty);
Var  Row1, Row2: integer;
     Col1, Col2: integer;
begin
  Row1 := FFirstRow;
  Row2 := FLastRow;
  Col1 := FFirstCol;
  Col2 := FLastCol;

  SetRangeXFBordersProperty(Row1, Col1, Row2, Col2, 
                            false, integer(1 + 2 + 4 + 8) {all}, Value,  
                            SetFunc);

  Row1 := FFirstRow - 1;
  if Row1 >= 0 then begin
     SetRangeXFBordersProperty(Row1, FFirstCol, Row1, FLastCol, 
                               true, 8{bottom}, Value,  
                               SetFunc);
  end; 

  Row1 := FLastRow + 1;
  if Row1 >= 0 then begin
     SetRangeXFBordersProperty(Row1, FFirstCol, Row1, FLastCol, 
                               true, 4{top}, Value,  
                               SetFunc);
  end; 

  Col1 := FFirstCol - 1;
  if Col1 >= 0 then begin
     SetRangeXFBordersProperty(FFirstRow, Col1, FLastRow, Col1, 
                               true, 2{rigth}, Value,  
                               SetFunc);
  end; 

  Col1 := FLastCol + 1;
  if Col1 >= 0 then begin
     SetRangeXFBordersProperty(FFirstRow, Col1, FLastRow, Col1, 
                               true, 1{left}, Value,  
                               SetFunc);
  end; 

end;

procedure TXLSRange.SetBordersColorIndex(Value: LongWord);
begin
  SetBordersProperty(Value, FWorkSheet.FWorkBook.FXFList.SetBorderColorIndex);  
end;

procedure TXLSRange.SetBordersColor(Value: LongWord);
begin
  SetBordersProperty(Value, FWorkSheet.FWorkBook.FXFList.SetBorderColor);  
end;

procedure TXLSRange.SetBordersThemeColor(Value: LongWord);
begin
  SetBordersProperty(Value, FWorkSheet.FWorkBook.FXFList.SetBorderThemeColor);  
end;

procedure TXLSRange.SetBordersTintAndShade(Value: double);
var lValue: longword;
begin
  if Value < -1 then Value := -1;
  if Value > 1 then Value := 1;
  
  lValue := Trunc((Value + 1) * 1000000000);
  SetBordersProperty(lValue, FWorkSheet.FWorkBook.FXFList.SetBorderTintAndShade);  
end;

procedure TXLSRange.SetBordersLineStyle(Value: LongWord);
begin
  SetBordersProperty(Value, FWorkSheet.FWorkBook.FXFList.SetBorderLineStyle);  
end;

procedure TXLSRange.SetBordersWeight(Value: LongWord);
begin
  SetBordersProperty(Value, FWorkSheet.FWorkBook.FXFList.SetBorderWeight);  
end;


procedure TXLSRange.SetBorderProperty(const BorderIndex: LongWord; Value: LongWord; SetFunc: TSetXFBorderProperty);
Var  Row1, Row2: integer;
     Col1, Col2: integer;
begin
  {1 - left, 2 - right, 4 - top, 8 - bottom}
  case BorderIndex of
     xlDiagonalDown:     begin 
                           SetRangeXFBordersProperty(FFirstRow, FFirstCol, FLastRow, FLastCol, 
                                                     false, 16 {diagonal down}, Value,  
                                                     SetFunc);
                         end;
     xlDiagonalUp:       begin                                                                
                           SetRangeXFBordersProperty(FFirstRow, FFirstCol, FLastRow, FLastCol,
                                                     false, 32 {diagonal up}, Value,        
                                                     SetFunc);                                
                         end;                                                                 
                     
     xlEdgeLeft:         begin
                            {left}
                            Col1 := FFirstCol;
                            Col2 := Col1 - 1;
                            {1 - left, 2 - right, 4 - top, 8 - bottom}
                            SetRangeXFBordersProperty(FFirstRow, Col1, FLastRow, Col1, 
                                                      false, 1 {left}, Value,  
                                                      SetFunc);
                            if Col2 >= 0 then begin
                               SetRangeXFBordersProperty(FFirstRow, Col2, FLastRow, Col2,   
                                                         true, 2 {right}, Value,  
                                                         SetFunc);
                            end;  
                         end; 

     xlEdgeTop:          begin
                            {top}
                            Row1 := FFirstRow;
                            Row2 := Row1 - 1;
                            {1 - left, 2 - right, 4 - top, 8 - bottom}
                            SetRangeXFBordersProperty(Row1, FFirstCol, Row1, FLastCol, 
                                                      false, 4 {top}, Value,  
                                                      SetFunc);
                            if Row2 >= 0 then begin
                               SetRangeXFBordersProperty(Row2, FFirstCol, Row2, FLastCol,  
                                                         true, 8 {bottom}, Value,  
                                                         SetFunc);
                            end;  
                         end; 

     xlEdgeBottom:       begin
                            {bottom}
                            Row1 := FLastRow;
                            Row2 := Row1 + 1;
                            {1 - left, 2 - right, 4 - top, 8 - bottom}
                            SetRangeXFBordersProperty(Row1, FFirstCol, Row1, FLastCol, 
                                                      false, 8 {bottom}, Value,  
                                                      SetFunc);
                            if Row2 >= 0 then begin
                               SetRangeXFBordersProperty(Row2, FFirstCol, Row2, FLastCol,  
                                                         true, 4 {top}, Value,  
                                                         SetFunc);
                            end;  
                         end; 

     xlEdgeRight:        begin
                            {right}
                            Col1 := FLastCol;
                            Col2 := Col1 + 1;
                            {1 - left, 2 - right, 4 - top, 8 - bottom}
                            SetRangeXFBordersProperty(FFirstRow, Col1, FLastRow, Col1, 
                                                      false, 2 {right}, Value,  
                                                      SetFunc);
                            if Col2 >= 0 then begin
                               SetRangeXFBordersProperty(FFirstRow, Col2, FLastRow, Col2,   
                                                         true, 1 {left}, Value,  
                                                         SetFunc);
                            end;  
                         end; 

     xlInsideVertical:   begin
                            Col1 := FFirstCol;
                            Col2 := FLastCol;  
                            if Col1 < Col2 then begin
                               SetRangeXFBordersProperty(FFirstRow, Col1, FLastRow, Col1, 
                                                         false, 2 {right}, Value,  
                                                         SetFunc);
                               SetRangeXFBordersProperty(FFirstRow, Col2, FLastRow, Col2, 
                                                         false, 1 {left}, Value,  
                                                         SetFunc);
                               if (Col1 + 1) <= (Col2 - 1) then begin
                                  SetRangeXFBordersProperty(FFirstRow, Col1 + 1, FLastRow, Col2 - 1, 
                                                            false, 1 {left} + 2 {right}, Value,  
                                                            SetFunc);
                               end;
                            end;

                         end;


     xlInsideHorizontal: begin
                            Row1 := FFirstRow;
                            Row2 := FLastRow;;  
                            if Row1 < Row2 then begin
                               SetRangeXFBordersProperty(Row1, FFirstCol, Row1, FLastCol, 
                                                         false, 8 {bottom}, Value,  
                                                         SetFunc);
                               SetRangeXFBordersProperty(Row2, FFirstCol, Row2, FLastCol, 
                                                         false, 4 {top}, Value,  
                                                         SetFunc);
                               if (Row1 + 1) <= (Row2 - 1) then begin
                                  SetRangeXFBordersProperty(Row1 + 1, FFirstCol, Row2 - 1, FLastCol, 
                                                            false, 8 {bottom} + 4 {top}, Value,  
                                                            SetFunc);
                               end;
                            end;

                         end;

     xlInsideAll:        begin
                           SetBorderProperty(xlInsideHorizontal, Value, SetFunc);
                           SetBorderProperty(xlInsideVertical, Value, SetFunc);
                         end;
     xlAround:           begin 
                           SetBorderProperty(xlEdgeRight,  Value, SetFunc);
                           SetBorderProperty(xlEdgeTop,    Value, SetFunc);
                           SetBorderProperty(xlEdgeBottom, Value, SetFunc);
                           SetBorderProperty(xlEdgeLeft,   Value, SetFunc);
                         end;
   end;
end;

procedure TXLSRange.SetBorderColorIndex(const BorderIndex: LongWord;
  Value: LongWord);
begin
  SetBorderProperty(BorderIndex, Value, FWorkSheet.FWorkBook.FXFList.SetBorderColorIndex);  
end;

procedure TXLSRange.SetBorderColor(const BorderIndex: LongWord;
  Value: LongWord);
begin
  SetBorderProperty(BorderIndex, Value, FWorkSheet.FWorkBook.FXFList.SetBorderColor);  
end;

procedure TXLSRange.SetBorderThemeColor(const BorderIndex: LongWord;
  Value: LongWord);
begin
  SetBorderProperty(BorderIndex, Value, FWorkSheet.FWorkBook.FXFList.SetBorderThemeColor);  
end;

procedure TXLSRange.SetBorderTintAndShade(const BorderIndex: LongWord;
  Value: double);
var lValue: longword;
begin
  if Value < -1 then Value := -1;
  if Value > 1 then Value := 1;
  lValue := Trunc((Value + 1) * 1000000000);
  SetBorderProperty(BorderIndex, lValue, FWorkSheet.FWorkBook.FXFList.SetBorderTintAndShade);  
end;

procedure TXLSRange.SetBorderLineStyle(const BorderIndex: LongWord;
  Value: LongWord);
begin
  SetBorderProperty(BorderIndex, Value, FWorkSheet.FWorkBook.FXFList.SetBorderLineStyle);  
end;

procedure TXLSRange.SetBorderWeight(const BorderIndex: LongWord;
  Value: LongWord);
begin
  SetBorderProperty(BorderIndex, Value, FWorkSheet.FWorkBook.FXFList.SetBorderWeight);  
end;


function TXLSRange.GetBorderBottomLineStyle: LongWord;
begin
  Result := GetCellBorderLineStyle(FLastRow, FLastCol, FLastRow + 1, FLastCol, false);
end;

function TXLSRange.GetBorderHorizontalInsideLineStyle: LongWord;
begin
   Result := xlLineStyleUndefined;
   if FFirstRow >= FLastRow then exit;
   Result := GetCellBorderLineStyle(FFirstRow, FFirstCol, FFirstRow + 1, FFirstCol, false);
end;

function TXLSRange.GetBorderLeftLineStyle: LongWord;
begin
  Result := GetCellBorderLineStyle(FFirstRow, FFirstCol - 1, FFirstRow, FFirstCol, true);
end;

function TXLSRange.GetBorderInsideAllLineStyle: LongWord;
Var res: Longword;
begin
   Result := GetBorderHorizontalInsideLineStyle;
   if Result = xlLineStyleUndefined then exit;
   res := GetBorderVerticalInsideLineStyle;
   if Result <> res then Result := xlLineStyleUndefined;
end;

procedure TXLSRange.SetRangeXFBordersProperty(Row1, Col1, Row2, Col2: integer; Optional: boolean; BorderMask: integer; _Value: LongWord; SetFunc: TSetXFBorderProperty);
Var  ReplaceCurXFIndex: boolean;
     Cell1: TXLSCellRef;
     Index, NewIndex: integer;
     row, col: integer;
     HashIndex, HashNewIndex: integer;
begin
   HashIndex    := -1;
   HashNewIndex := -1; 

   if Row1 < 0 then Row1 := 0;
   if Col1 < 0 then Col1 := 0;
   if Row2 > XLSXMaxRow then Row2 := XLSXMaxRow;
   if Col2 > XLSXMaxCol then Col2 := XLSXMaxCol;

   if Row1 > Row2 then exit;
   if Col1 > Col2 then exit;

   for row := Row1 to Row2 do begin
     for col := Col1 to Col2 do begin
        if Optional then begin
           Cell1 := FWorkSheet.FCells.GetValue(row, col);
        end else begin
           Cell1 := FWorkSheet.FCells.GetOrCreateValue(row, col);
        end;
        if Assigned(Cell1) then begin
           Index := GetXFIndex(row, col, ReplaceCurXFIndex);
           if Index = HashIndex then begin
              NewIndex  := HashNewIndex;
              if ReplaceCurXFIndex then begin
                 FWorkSheet.FWorkBook.FXFList.ReplaceIndex(HashIndex, HashNewIndex);
              end else begin
                 FWorkSheet.FWorkBook.FXFList.IncReferredCount(HashNewIndex);
              end;
           end else begin 
              if Optional then begin
                 if FWorkSheet.FWorkBook.FXFList.GetBordersDefined(Index) then begin
                    //Clear border in the secondary cell
                    NewIndex := FWorkSheet.FWorkBook.FXFList.SetBorderLineStyle(Index, BorderMask, OleVariant(xlLineStyleNone), ReplaceCurXFIndex);                 
                 end else begin
                    NewIndex := Index;
                 end;
              end else begin
                 //Set property value
                 NewIndex := SetFunc(Index, BorderMask, OleVariant(_Value), ReplaceCurXFIndex);
              end;
              HashIndex := Index;
              HashNewIndex := NewIndex; 
           end;
           Cell1.FXFIndex := NewIndex;
        end;
     end;
   end;
end;

function TXLSRange.GetBorderRightLineStyle: LongWord;
begin
  Result := GetCellBorderLineStyle(FLastRow, FLastCol, FLastRow, FLastCol + 1, true);
end;

function TXLSRange.GetBorderTopLineStyle: LongWord;
begin
  Result := GetCellBorderLineStyle(FFirstRow - 1, FFirstCol, FFirstRow, FFirstCol, false);
end;

function TXLSRange.GetBorderVerticalInsideLineStyle: LongWord;
begin
   Result := xlLineStyleUndefined;
   if FFirstCol >= FLastCol then exit;
   Result := GetCellBorderLineStyle(FFirstRow, FFirstCol, FFirstRow, FFirstCol + 1, true);
end;


function TXLSRange.GetBorderAllStyle: integer;
Var  Index: integer;
     res: integer;
     ReplaceCurXFIndex: boolean;
begin
  Index := GetXFIndex(FFirstRow, FFirstCol, ReplaceCurXFIndex);
  Result := 0;
  if FWorkSheet.FWorkBook.FXFList.GetBordersDefined(Index) then begin
     //top
     Result := FWorkSheet.FWorkBook.FXFList.GetBorderStyle(Index, 4);
     //bottom
     res := FWorkSheet.FWorkBook.FXFList.GetBorderStyle(Index, 8);
            if Result <> res then begin
        Result := -1;
     end;
     //left
     if Result <> -1 then begin
        res := FWorkSheet.FWorkBook.FXFList.GetBorderStyle(Index, 1);
        if Result <> res then begin
           Result := -1;
         end;
      end;
     //right
     if Result <> -1 then begin
        res := FWorkSheet.FWorkBook.FXFList.GetBorderStyle(Index, 2);
        if Result <> res then begin
           Result := -1;
   end;
end;
   end;
end;

function TXLSRange.GetBorderAroundLineStyle: LongWord;
begin
   Result := GetBorderTopLineStyle;
end;

function TXLSRange.GetBorderAllLineStyle: LongWord;
Var bstyle: integer;
begin
   Result := xlLineStyleUndefined;
   bstyle := GetBorderAllStyle;
   if bstyle >= 0 then begin
      Result := FWorkSheet.FWorkBook.FXFList.GetLineStyleFromBorderStyle(bstyle);
   end;   
   end;

function TXLSRange.GetBorderBottomLineWeight: LongWord;
begin
   Result := GetCellBorderLineWeight(FLastRow, FLastCol, FLastRow + 1, FLastCol, false);
end;

function TXLSRange.GetBorderHorizontalInsideLineWeight: LongWord;
begin
   Result := xlLineStyleUndefined;
   if FFirstRow >= FLastRow then exit;
   Result := GetCellBorderLineStyle(FFirstRow, FFirstCol, FFirstRow + 1, FFirstCol, false);
end;

function TXLSRange.GetBorderLeftLineWeight: LongWord;
begin
   Result := GetCellBorderLineWeight(FFirstRow, FFirstCol - 1, FFirstRow, FFirstCol, true);
end;

function TXLSRange.GetBorderRightLineWeight: LongWord;
begin
   Result := GetCellBorderLineWeight(FLastRow, FLastCol, FLastRow, FLastCol + 1, true);
end;

function TXLSRange.GetBorderTopLineWeight: LongWord;
begin
   Result := GetCellBorderLineWeight(FFirstRow - 1, FFirstCol, FFirstRow, FFirstCol, false);
end;

function TXLSRange.GetBorderVerticalInsideLineWeight: LongWord;
begin
   Result := xlBorderWeightUndefined;
   if FFirstCol >= FLastCol then exit;
   Result := GetCellBorderLineWeight(FFirstRow, FFirstCol, FFirstRow, FFirstCol + 1, true);
end;

function TXLSRange.GetBorderAroundLineWeight: LongWord;
begin
   Result := GetBorderTopLineWeight;
end;

function TXLSRange.GetBorderAllLineWeight: LongWord;
Var bstyle: integer;
begin
   Result := xlLineStyleUndefined;
   bstyle := GetBorderAllStyle;
   if bstyle >= 0 then begin
      Result := FWorkSheet.FWorkBook.FXFList.GetWeightFromBorderStyle(bstyle);
   end;   
end;

function TXLSRange.GetBorderInsideAllLineWeight: LongWord;
Var res: Longword;
begin
   Result := GetBorderHorizontalInsideLineWeight;
   if Result = xlBorderWeightUndefined then exit;
   res := GetBorderVerticalInsideLineWeight;
   if Result <> res then Result := xlBorderWeightUndefined;
end;

function TXLSRange.GetColumn: integer;
begin
  Result := FFirstCol + 1;
end;

function TXLSRange.GetRow: integer;
begin
  Result := FFirstRow + 1;
end;

function TXLSRange.GetNumFormat: widestring;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetNumFormat(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

procedure TXLSRange.SetNumFormat(Value: widestring);
begin
  SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetNumFormat)
end;

function TXLSRange.GetLocked: boolean;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetLocked(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

procedure TXLSRange.SetLocked(Value: boolean);
begin
  SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetLocked)
end;


function TXLSRange.GetFormulaHidden: boolean;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetHidden(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

procedure TXLSRange.SetFormulaHidden(Value: boolean);
begin
  SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetHidden)
end;


function TXLSRange.GetShrinkToFit: boolean;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetShrinkToFit(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

procedure TXLSRange.SetShrinkToFit(Value: boolean);
begin
  SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetShrinkToFit);
end;

function TXLSRange.GetReadingOrder: XlReadingOrder;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetReadingOrder(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

procedure TXLSRange.SetReadingOrder(Value: XlReadingOrder);
begin
  SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetReadingOrder);
end;


function TXLSRange.GetHAlign: xlHAlign;
Var  ReplaceIndex: boolean;
     Value: integer;
begin
  Value := FWorkSheet.FWorkBook.FXFList.GetHorAlign(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
  case Value of
     0: Result := xlHAlignGeneral;
     1: Result := xlHAlignLeft;
     2: Result := xlHAlignCenter;
     3: Result := xlHAlignRight;
     4: Result := xlHAlignFill;
     5: Result := xlHAlignJustify;
     6: Result := xlHAlignCenterAcrossSelection;
     7: Result := xlHAlignDistributed;
     else Result := 0
   end;
end;

function TXLSRange.GetVAlign: xlVAlign;
Var
  ReplaceIndex: boolean;
  Value: integer;
begin
  Value := FWorkSheet.FWorkBook.FXFList.GetVerAlign(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
  case Value of
     0: Result := xlVAlignTop;
     1: Result := xlVAlignCenter;
     2: Result := xlVAlignBottom;
     3: Result := xlVAlignJustify;
     4: Result := xlVAlignDistributed;  //BIFF8X only
     else Result := 0
   end;
end;

procedure TXLSRange.SetHAlign(Value: xlHAlign);
Var SetValue: Word;
    Valid: boolean;
begin
  Valid := true;
  SetValue := 0;
  case Value of
     xlHAlignGeneral:               SetValue := 0;
     xlHAlignFill:                  SetValue := 4;
     xlHAlignCenterAcrossSelection: SetValue := 6;
     xlHAlignRight:                 SetValue := 3;
     xlHAlignLeft:                  SetValue := 1;
     xlHAlignJustify:               SetValue := 5;
     xlHAlignDistributed:           SetValue := 7;
     xlHAlignCenter:                SetValue := 2;
   else Valid := false;
  end;
  if Valid then
     SetXFProperty(SetValue, FWorkSheet.FWorkBook.FXFList.SetHorAlign);
end;

procedure TXLSRange.SetVAlign(Value: xlVAlign);
Var SetValue: Word;
    Valid: boolean;
begin
  Valid := true;
  SetValue := 0;
  case Value of
    xlVAlignTop:         SetValue := 0;
    xlVAlignJustify:     SetValue := 3;
    xlVAlignDistributed: SetValue := 4;  //BIFF8X only
    xlVAlignCenter:      SetValue := 1;
    xlVAlignBottom:      SetValue := 2;
    else Valid := false;
  end;
  if Valid then
     SetXFProperty(SetValue, FWorkSheet.FWorkBook.FXFList.SetVerAlign);
end;

function TXLSRange.GetCells: IXLSRange;
begin
    Result := self;
end;

procedure TXLSRange.ClearContents;
Var  Row, Col: integer;
     Cell: TXLSCellRef;
begin
  for Col := FFirstCol to FLastCol do
    for row := FFirstRow to FLastRow do begin
       Cell := FWorkSheet.FCells.GetValue(row, col);
       if Assigned(Cell) then Cell.Value[FWorksheet] := null;
    end;
end;

procedure TXLSRange.Clear;
Var  Row, Col: integer;
     Cell: TXLSCellRef;
begin
  for Col := FFirstCol to FLastCol do
    for row := FFirstRow to FLastRow do begin
       Cell := FWorkSheet.FCells.GetValue(row, col);
       if Assigned(Cell) then begin
          Cell.Value[FWorksheet] := null;
          FWorkSheet.FWorkBook.FXFList.ReplaceIndex(Cell.FXFIndex, 0);
          Cell.FXFIndex := 0;
       end;
    end;
  ClearComments; 
  FWorksheet.FCondFormatter.ClearRange(FFirstRow, FFirstCol,
                                    FLastRow,  FLastCol);
  FWorksheet.FDataValidator.ClearRange(FFirstRow, FFirstCol,
                                       FLastRow,  FLastCol);
   
  FWorksheet.GetCustomHyperlinks.ClearRange(FFirstRow, FFirstCol,
                                            FLastRow,  FLastCol);
end;

function TXLSRange.GetXFIndex(row, col: integer;
         var ReplaceIndex: boolean): integer;
begin
  Result := FWorkSheet.GetXFIndex(row, col, ReplaceIndex);
end;

procedure TXLSRange.ColumnsAutoFit;
Var FAutoFit: TXLSAutoFit;
begin
  FAutoFit := TXLSAutoFit.Create(Self);
  try
    FAutoFit.ColumnsAutoFit;
  finally
    FAutoFit.Free;
  end;
end;

procedure TXLSRange.RowsAutoFit;
Var FAutoFit: TXLSAutoFit;
begin
  FAutoFit := TXLSAutoFit.Create(Self);
  try
    FAutoFit.RowsAutoFit;
  finally
    FAutoFit.Free;
  end;
end;

procedure TXLSRange.AutoFit(Columns: boolean);
begin
  if Columns then ColumnsAutoFit else RowsAutoFit;
end;

function TXLSRange.GetHyperlinks: IXLSHyperlinks;
begin
  Result := TXLSHyperLinks.Create(Self, Self.WorkSheet.GetCustomHyperlinks());
end;

function TXLSRange.GetWorksheet: IXLSWorksheet;
begin Result := FWorkSheet end;

function TXLSRange.GetFirstCol: integer;
begin Result := FFirstCol end;

function TXLSRange.GetLastCol: integer;
begin Result := FLastCol end;

function TXLSRange.GetFirstRow: integer;
begin Result := FFirstRow end;

function TXLSRange.GetLastRow: integer;
begin Result := FLastRow end;

   
procedure TXLSRange.DeleteRows;
var r1,r2: integer;
    UsedRange: IXLSRange;
    mr1, mr2, mc1, mc2: integer;
    distance: integer;
    isentiresheet: boolean;
begin
   r1 := FirstRow;
   r2 := LastRow;
   //c1 := FirstCol;
   //c2 := LastCol;
   isentiresheet := (r1 = 0) and (r2 = XLSXMaxRow);

   UsedRange := FWorkSheet.UsedRange;
   mr1 := UsedRange.FirstRow;
   mr2 := UsedRange.LastRow;
   mc1 := UsedRange.FirstCol;
   mc2 := UsedRange.LastCol;

   if FWorksheet._RowInfo.RowCount > 0 then begin
      if FWorksheet._RowInfo.MaxRow > mr2 then begin
         mr2 := FWorksheet._RowInfo.MaxRow; 
      end;
      if FWorksheet._RowInfo.MinRow < mr1 then begin
         mr1 := FWorksheet._RowInfo.MinRow; 
      end;
   end;

   if r1 > mr2 then begin
      exit;
   end;

   if r2 > mr2 then r2 := mr2;

   if r2 >= mr1 then begin
      if r1 <= mr1 then begin
         //need to clear rows from mr1 to r2
         UnMergeOutgoingRanges(mr1, mc1, r2, mc2);
         ClearRows(mr1, r2, mc1, mc2);
         mr1 := r2 + 1;
      end else begin
         //need to clear rows from r1 to r2
         UnMergeOutgoingRanges(r1, mc1, r2, mc2);
         ClearRows(r1, r2, mc1, mc2);
      end;
   end;

   if (mr1 <= mr2) and (r2 < mr2) then begin
      distance := r2 - r1 + 1;
      if (r2 >= mr1) then begin
         UnMergeOutgoingRanges(r2, mc1, mr2, mc2);
         moverows(r2 + 1, mr2, -distance, mc1, mc2);
      end else begin
         UnMergeOutgoingRanges(mr1, mc1, mr2, mc2);
         moverows(mr1, mr2, -distance, mc1, mc2);
      end;
   end;

   if isentiresheet then begin
      while FWorksheet.FColumnInfo.ColCount > 0 do begin
        FWorkSheet.FColumnInfo.DeleteCol(FWorksheet.FColumnInfo.MinCol);
      end;
   end;
end;

procedure TXLSRange.DeleteColumns;
var c1,c2: integer;
    UsedRange: IXLSRange;
    mr1, mr2, mc1, mc2: integer;
    distance: integer;
    isentiresheet: boolean;
begin
   c1 := FirstCol;
   c2 := LastCol;

   isentiresheet := (c1 = 0) and (c2 = XLSXMaxCol);

   UsedRange := FWorkSheet.UsedRange;
   mr1 := UsedRange.FirstRow;
   mr2 := UsedRange.LastRow;
   mc1 := UsedRange.FirstCol;
   mc2 := UsedRange.LastCol;

   if FWorksheet.FColumnInfo.ColCount > 0 then begin
      if FWorksheet.FColumnInfo.MaxCol > mc2 then begin
         mc2 := FWorksheet.FColumnInfo.MaxCol; 
      end;
      if FWorksheet.FColumnInfo.MinCol < mc1 then begin
         mc1 := FWorksheet.FColumnInfo.MinCol; 
      end;
   end;

   if c1 > mc2 then begin
      exit;
   end;

   if c2 > mc2 then c2 := mc2;

   if c2 >= mc1 then begin
      if c1 <= mc1 then begin
         //need to clear columns from mc1 to c2
         UnMergeOutgoingRanges(mr1, mc1, mr2, c2);
         ClearColumns(mc1, c2, mr1, mr2);
         mc1 := c2 + 1;
      end else begin
         //need to clear columns from c1 to c2
         UnMergeOutgoingRanges(mr1, c1, mr2, c2);
         ClearColumns(c1, c2, mr1, mr2);
      end;
   end;

   if (mc1 <= mc2) and (c2 < mc2) then begin
      distance := c2 - c1 + 1;
      if (c2 >= mc1) then begin
         UnMergeOutgoingRanges(mr1, c2, mr2, mc2);
         movecolumns(c2 + 1, mc2, -distance, mr1, mr2);
      end else begin
         UnMergeOutgoingRanges(mr1, mc1, mr2, mc2);
         movecolumns(mc1, mc2, -distance, mr1, mr2);
      end;
   end;

   if isentiresheet then begin
      while FWorksheet.FRowInfo.RowCount > 0 do begin
        FWorkSheet.FRowInfo.DeleteRow(FWorksheet.FRowInfo.MinRow);
      end;
   end;
end;

procedure TXLSRange.ClearRows(r1, r2, c1, c2: integer);
var 
    row, col: integer;
begin
   for row := r1 to r2 do begin
      for col := c1 to c2 do begin
         DeleteCell(row, col);
      end;
      FWorkSheet.FRowInfo.DeleteRow(row);
   end;
end;

procedure TXLSRange.ClearColumns(c1, c2, r1, r2: integer);
var 
    row, col: integer;
begin
   for col := c1 to c2 do begin
      for row := r1 to r2 do begin
         DeleteCell(row, col);
      end;
      FWorkSheet.FColumnInfo.DeleteCol(col);
   end;
end;

procedure TXLSRange.ClearRange(r1, c1, r2, c2: integer; isrow: boolean);
var 
    row, col: integer;
    xfindex: integer;
    rowinfo: TXLSRowInfo;
    colinfo: TXLSColumnInfo;

begin
   if isRow then begin
      for row := r1 to r2 do begin
         rowinfo := FWorksheet.FRowInfo.GetRowInfo(row);
         for col := c1 to c2 do begin
            DeleteCell(row, col);
            if Assigned(rowinfo) and 
               rowinfo.XFIndexSet and 
               (rowinfo.XFIndex <> 0) then begin
               xfindex := FWorksheet.FColumnInfo.XFIndex[col];
               if xfindex <> rowinfo.XFIndex then begin
                  FWorksheet._SetXF(row, col, xfindex);
               end;
            end;
         end;
      end;
   end else begin
      for col := c1 to c2 do begin
         colinfo := FWorksheet.FColumnInfo.GetColumnInfo(col);
         for row := r1 to r2 do begin
            DeleteCell(row, col);
            if Assigned(colinfo) and (colinfo.XFIndex <> DefaultXFIndex) then begin
               xfindex := FWorksheet.FRowInfo.XFIndex[row];
               if xfindex = 0 then begin
                  FWorksheet._SetXF(row, col, DefaultXFIndex);
               end;
            end;
         end;
      end;
   end;
end;

procedure TXLSRange.DeleteCell(r, c: integer);
begin
   if (r < 0) or (c < 0) or 
      (r > XLSXMaxRow) or (c > XLSXMaxCol) then begin
      exit;
   end;
   FWorksheet.FCells.DeleteValue(r, c);
end;

procedure TXLSRange.MoveRows(r1, r2, distance, c1, c2: integer);
var 
    row, col: integer;
begin
   if distance < 0 then begin
   for row := r1 to r2 do begin
      for col := c1 to c2 do begin
            fworksheet.fcells.movecell(row, col, row + distance, col, false, 
               ffirstrow, ffirstcol, flastrow, flastcol, distance, 0);
      end;
         fworksheet.frowinfo.copyrowformat(row + distance, fworksheet.frowinfo.rows[row]);
         fworksheet.frowinfo.deleterow(row);
   end;
   end else if distance > 0 then begin
      for row := r2 downto r1 do begin
         for col := c1 to c2 do begin
            fworksheet.fcells.movecell(row, col, row + distance, col, false, 
               ffirstrow, ffirstcol, flastrow, flastcol, distance, 0);
end;
         fworksheet.frowinfo.copyrowformat(row + distance, fworksheet.frowinfo.rows[row]);
         fworksheet.frowinfo.deleterow(row);
      end;
   end;
end;

procedure TXLSRange.MoveColumns(c1, c2, distance, r1, r2: integer);
var 
    row, col: integer;
begin
   if distance < 0 then begin
   for col := c1 to c2 do begin
      for row := r1 to r2 do begin
            FWorksheet.FCells.MoveCell(row, col, row, col + distance, false,
               FFirstRow, FFirstCol, FLastRow, FLastCol, 0, distance);
      end;
      FWorkSheet.FColumnInfo.CopyColFormat(col + distance,
      FWorkSheet.FColumnInfo.GetColumnInfo(col));
      FWorkSheet.FColumnInfo.DeleteCol(col);
   end;
   end else if distance > 0 then begin
      for col := c2 downto c1 do begin
         for row := r1 to r2 do begin
            FWorksheet.FCells.MoveCell(row, col, row, col + distance, false,
               FFirstRow, FFirstCol, FLastRow, FLastCol, 0, distance);
end;
         FWorkSheet.FColumnInfo.CopyColFormat(col + distance,
            FWorkSheet.FColumnInfo.GetColumnInfo(col));
            FWorkSheet.FColumnInfo.DeleteCol(col);
      end;
   end;
end;

procedure TXLSRange.MoveRange(r1, c1, r2, c2: integer;
                        r_distance, c_distance: integer; 
                        keepformat: boolean);
var 
    row, col: integer;
    lr1, lr2, lrs: integer;
    lc1, lc2, lcs: integer;
begin

   if r_distance < 0 then begin
      lr1 := r1; lr2 := r2; lrs := 1;
   end else begin 
      lr1 := r2; lr2 := r1; lrs := -1;
   end;

   if c_distance < 0 then begin
      lc1 := c1; lc2 := c2; lcs := 1;
   end else begin
      lc1 := c2; lc2 := c1; lcs := -1;
   end;

   row := lr1;
   while ((lrs > 0) and (row <= lr2)) or 
      ((lrs < 0) and (row >= lr2)) do begin
      col := lc1;
      while ((lcs > 0) and (col <= lc2)) or 
         ((lcs < 0) and (col >= lc2)) do begin
         FWorksheet.FCells.MoveCell(row, col,
            row + r_distance, col + c_distance, keepformat,
            FFirstRow, FFirstCol, FLastRow, FLastCol, r_distance, c_distance);
         col := col + lcs;
      end;
      row := row + lrs;
   end;
end;

procedure TXLSRange.DeleteRange(isRows: boolean);
var c1,c2,r1,r2: integer;
    UsedRange: IXLSRange;
    mr1, mr2, mc1, mc2: integer;
    distance: integer;
begin
   c1 := FirstCol;
   c2 := LastCol;
   r1 := FirstRow;
   r2 := LastRow;
   UsedRange := FWorkSheet.UsedRange;
   mr1 := UsedRange.FirstRow;
   mr2 := UsedRange.LastRow;
   mc1 := UsedRange.FirstCol;
   mc2 := UsedRange.LastCol;

   if FWorksheet.FColumnInfo.ColCount > 0 then begin
      if FWorksheet.FColumnInfo.MaxCol > mc2 then begin
         mc2 := FWorksheet.FColumnInfo.MaxCol; 
      end;
      if FWorksheet.FColumnInfo.MinCol < mc1 then begin
         mc1 := FWorksheet.FColumnInfo.MinCol; 
      end;
   end;

   if FWorksheet._RowInfo.RowCount > 0 then begin
      if FWorksheet._RowInfo.MaxRow > mr2 then begin
         mr2 := FWorksheet._RowInfo.MaxRow; 
      end;
      if FWorksheet._RowInfo.MinRow < mr1 then begin
         mr1 := FWorksheet._RowInfo.MinRow; 
      end;
   end;

   if isRows then begin
      if r1 > mr2 then exit;
      if r2 > mr2 then r2 := mr2;
   end else begin
      if c1 > mc2 then exit;
      if c2 > mc2 then c2 := mc2;
   end;

   UnMergeOutgoingRanges(r1, c1, r2, c2);

   if isRows then begin
      //shift up
      distance := -(r2 - r1 + 1);
      if (r2 < mr2) then begin
         //move range
         moverange(r2 + 1, c1, mr2, c2, distance, 0, true);
      end;

      if (mr2 + distance) < mr1 then begin
         clearrange(mr1, c1, mr2, c2, isRows);
      end else begin
         clearrange(mr2 + distance + 1, c1, mr2, c2, isRows);
      end;
   end else begin
      //shift left
      distance := -(c2 - c1 + 1);
      if (c2 < mc2) then begin
         //move range
         moverange(r1, c2 + 1, r2, mc2, 0, distance, true);
      end;

      if (mc2 + distance) < mc1 then begin
         clearrange(r1, mc1, r2, mc2, isRows);
      end else begin
         clearrange(r1, mc2 + distance + 1, r2, mc2, isRows);
      end;
   end;
end;

function TXLSRange.Delete(Shift: OleVariant): OleVariant;
Var RangeType: integer;
    isRows: boolean;
    vt: TVarType;
    Value: LongWord;
    ShiftDefined: boolean;
    r1,r2,c1,c2: integer;
begin
  Result := true;
  RangeType := GetRangeType;
  isRows := false;

  r1 := FFirstRow;
  r2 := FLastRow;
  c1 := FFirstCol;
  c2 := FLastCol; 

  vt := VarType(Shift);
  ShiftDefined := false;

  if vt = varInteger then begin
     Value := LongWord(Shift);
     case Value of
        xlShiftToLeft: begin
                         isRows := false;
                         ShiftDefined := true;
                         if RangeType = 2 then begin
                            if not((r1 = 0) and (r2 = XLSXMaxRow)) then
                            begin
                               RangeType := 0;
                            end;
                         end;
                       end;
        xlShiftUp:     begin
                         isRows := true;
                         ShiftDefined := true;
                         if RangeType = 1 then begin
                            if not((c1 = 0) and (c2 = XLSXMaxCol)) then
                            begin
                               RangeType := 0;
                            end;
                         end;
                       end;
     end;
  end;
  if not(ShiftDefined) then begin
     case RangeType of
       0: isRows := true;//cells
       1: isRows := false;//columns
       2: isRows := true;//rows
     end;
  end;

  if (RangeType = 2) then begin
     DeleteRows;
  end else if (RangeType = 1) then begin
     DeleteColumns;
  end else begin
     DeleteRange(isRows);
  end;

  AfterDelete(RangeType, isrows);
end;

procedure TXLSRange.AfterDelete(RangeType: integer; isrows: boolean);
var d_col, d_row: integer;
begin
   d_col := 0;
   d_row := 0;
   if isRows then begin
      d_row := - (FLastRow - FFirstRow + 1);
   end else begin
      d_col := - (FLastCol - FFirstCol + 1);
   end;
   
   if RangeType = 1 then begin
      //entire columns
      FWorksheet.FCondFormatter.ClearRange(-1, FFirstCol,
         -1, FLastCol);
      FWorksheet.FCondFormatter.MoveRange(-1, FLastCol + 1,
         -1, -1, 0, d_col); 
      FWorksheet.FDataValidator.ClearRange(-1, FFirstCol,
         -1, FLastCol);
      FWorksheet.FDataValidator.MoveRange(-1, FLastCol + 1,
         -1, -1, 0, d_col); 
   end else if RangeType = 2 then begin
      //entire rows
      FWorksheet.FCondFormatter.ClearRange(FFirstRow, -1,
         FLastRow,  -1);
      FWorksheet.FCondFormatter.MoveRange(FLastRow + 1, -1,
         -1,  -1, d_row, 0);
      FWorksheet.FDataValidator.ClearRange(FFirstRow, -1,
         FLastRow,  -1);
      FWorksheet.FDataValidator.MoveRange(FLastRow + 1, -1,
         -1,  -1, d_row, 0);
   end else begin
      //range
      FWorksheet.FCondFormatter.ClearRange(FFirstRow, FFirstCol,
         FLastRow,  FLastCol);
      FWorksheet.FDataValidator.ClearRange(FFirstRow, FFirstCol,
         FLastRow,  FLastCol);
      if isRows then begin
         FWorksheet.FCondFormatter.MoveRange(FLastRow + 1, FFirstCol,
            -1,  FLastCol, d_row, 0);
         FWorksheet.FDataValidator.MoveRange(FLastRow + 1, FFirstCol,
            -1,  FLastCol, d_row, 0);
      end else begin
         FWorksheet.FCondFormatter.MoveRange(FFirstRow, FLastCol + 1,
            FLastRow,  -1, 0, d_col);
         FWorksheet.FDataValidator.MoveRange(FFirstRow, FLastCol + 1,
            FLastRow,  -1, 0, d_col);
      end;
   end;
    

   FWorksheet._Drawing.Comments.ClearComments(FFirstRow, FFirstCol, FLastRow, FLastCol);
   FWorksheet.GetCustomHyperlinks.ClearRange(FFirstRow, FFirstCol, FLastRow, FLastCol);
   if isrows then begin
      FWorksheet._Drawing.Comments.MoveComments(FLastRow + 1, FFirstCol, XLSXMaxRow, FLastCol, d_row, d_col);
      FWorksheet.GetCustomHyperlinks.Move(FLastRow + 1, FFirstCol, XLSMaxRow, FLastCol, d_row, d_col);
   end else begin
      FWorksheet._Drawing.Comments.MoveComments(FFirstRow, FLastCol + 1, FLastRow, XLSXMaxCol, d_row, d_col);
      FWorksheet.GetCustomHyperlinks.Move(FFirstRow, FLastCol + 1, FLastRow, XLSMaxCol, d_row, d_col);
   end;

   FWorksheet.FWorkbook.IncChangeID;
end;

procedure TXLSRange.InsertRows;
var r,r1,r2: integer;
    UsedRange: IXLSRange;
    c, mr2, mc1, mc2: integer;
    distance: integer;
    rinfo: TXLSRowInfo;
    srcxf: integer;
    dstxf: integer;
    tmp: boolean;
begin
   r1 := FirstRow;
   r2 := LastRow;
   distance := r2 - r1 + 1;

   UsedRange := FWorkSheet.UsedRange;
   mr2 := UsedRange.LastRow;
   mc1 := UsedRange.FirstCol;
   mc2 := UsedRange.LastCol;

   if FWorksheet._RowInfo.RowCount > 0 then begin
      if FWorksheet._RowInfo.MaxRow > mr2 then begin
         mr2 := FWorksheet._RowInfo.MaxRow; 
      end;
   end;

   if r1 > mr2 + 1 then begin
      exit;
   end;

   if (mr2 + distance) > XLSXMaxRow then begin
      //exception
      exit;
   end;

   //move rows down
   UnMergeOutgoingRanges(r1, mc1, r2, mc2);
   if r1 <= mr2 then begin
      moverows(r1, mr2, distance, mc1, mc2);
   end;

   //copy row and cell format from previous row
   rinfo := FWorkSheet.FRowInfo.Rows[r1 - 1];
   srcxf := -1;
   for c := mc1 to mc2 do begin

      if r1 > 0 then begin
         srcxf := FWorksheet.GetXFIndex(r1 - 1, c, tmp);
      end;

      for r := r1 to r2 do begin
         if (c = mc1) and Assigned(rinfo) then begin
            FWorkSheet.FRowInfo.CopyRowFormat(r, rinfo);
         end;
         if srcxf >= 0 then begin
            dstxf := FWorksheet.GetXFIndex(r, c, tmp);
            if srcxf <> dstxf then begin
               FWorksheet._SetXF(r, c, srcxf);
            end;
         end;
      end;
   end;

end;

procedure TXLSRange.InsertColumns;
var c,c1,c2: integer;
    UsedRange: IXLSRange;
    r, mr1, mr2, mc2: integer;
    distance: integer;
    cinfo: TXLSColumnInfo;
    srcxf: integer;
    dstxf: integer;
    tmp: boolean;
begin
   c1 := FirstCol;
   c2 := LastCol;
   distance := c2 - c1 + 1;

   UsedRange := FWorkSheet.UsedRange;
   mr1 := UsedRange.FirstRow;
   mr2 := UsedRange.LastRow;
   mc2 := UsedRange.LastCol;

   if FWorksheet.FColumnInfo.ColCount > 0 then begin
      if FWorksheet.FColumnInfo.MaxCol > mc2 then begin
         mc2 := FWorksheet.FColumnInfo.MaxCol; 
      end;
   end;

   if c1 > (mc2 + 1) then begin
      exit;
   end;

   if (mc2 + distance) > XLSXMaxCol then begin
      //exception
      exit;
   end;

   //move columns left
   UnMergeOutgoingRanges(mr1, c1, mr2, c2);
   if c1 <= mc2 then begin
      movecolumns(c1, mc2, distance, mr1, mr2);
   end;

   //copy col and cell format from previous col
   cinfo := FWorkSheet.FColumnInfo.GetColumnInfo(c1 - 1);
   srcxf := -1;
   for r := mr1 to mr2 do begin

      if c1 > 0 then begin
         srcxf := FWorksheet.GetXFIndex(r, c1 - 1, tmp);
      end;

      for c := c1 to c2 do begin
         if (r = mr1) and Assigned(cinfo) then begin
            FWorkSheet.FColumnInfo.CopyColFormat(c, cinfo);
         end;
         if srcxf >= 0 then begin
            dstxf := FWorksheet.GetXFIndex(r, c, tmp);
            if srcxf <> dstxf then begin
               FWorksheet._SetXF(r, c, srcxf);
            end;
         end;
      end;
   end;
end;

procedure TXLSRange.InsertRange;
var c1,c2,r1,r2: integer;
    UsedRange: IXLSRange;
    mr1, mr2, mc1, mc2: integer;
    distance: integer;
    r, c: integer;
    tmp: boolean;
    srcxf, dstxf: integer;
begin
   c1 := FirstCol;
   c2 := LastCol;
   r1 := FirstRow;
   r2 := LastRow;
   UsedRange := FWorkSheet.UsedRange;
   mr1 := UsedRange.FirstRow;
   mr2 := UsedRange.LastRow;
   mc1 := UsedRange.FirstCol;
   mc2 := UsedRange.LastCol;

   if FWorksheet.FColumnInfo.ColCount > 0 then begin
      if FWorksheet.FColumnInfo.MaxCol > mc2 then begin
         mc2 := FWorksheet.FColumnInfo.MaxCol; 
      end;
      if FWorksheet.FColumnInfo.MinCol < mc1 then begin
         mc1 := FWorksheet.FColumnInfo.MinCol; 
      end;
   end;

   if FWorksheet._RowInfo.RowCount > 0 then begin
      if FWorksheet._RowInfo.MaxRow > mr2 then begin
         mr2 := FWorksheet._RowInfo.MaxRow; 
      end;
      if FWorksheet._RowInfo.MinRow < mr1 then begin
         mr1 := FWorksheet._RowInfo.MinRow; 
      end;
   end;

   if isRows then begin
      distance := r2 - r1 + 1;
      if r1 > (mr2 + 1) then exit;
      if (mr2 + distance) > XLSXMaxRow then begin
         //exception
         exit;
      end;
   end else begin
      distance := c2 - c1 + 1;
      if c1 > (mc2 + 1) then exit;
      if (mc2 + distance) > XLSXMaxCol then begin
         //exception
         exit;
      end;
   end;

   UnMergeOutgoingRanges(r1, c1, r2, c2);

   if isRows then begin
      //shift down 
      //move range
      moverange(r1, c1, mr2, c2, distance, 0, true);

      //copy cell format from previous row
      srcxf := -1;
      for c := mc1 to mc2 do begin
         if r1 > 0 then begin
            srcxf := FWorksheet.GetXFIndex(r1 - 1, c, tmp);
         end;

         for r := r1 to r2 do begin
            if srcxf >= 0 then begin
               dstxf := FWorksheet.GetXFIndex(r, c, tmp);
               if srcxf <> dstxf then begin
                  FWorksheet._SetXF(r, c, srcxf);
               end;
            end;
         end;
      end;

   end else begin
      //shift right
      //move range
      moverange(r1, c1, r2, mc2, 0, distance, true);

      //copy cell format from previous col
      srcxf := -1;
      for r := mr1 to mr2 do begin
         if c1 > 0 then begin
            srcxf := FWorksheet.GetXFIndex(r, c1 - 1, tmp);
         end;

         for c := c1 to c2 do begin
            if srcxf >= 0 then begin
               dstxf := FWorksheet.GetXFIndex(r, c, tmp);
               if srcxf <> dstxf then begin
                  FWorksheet._SetXF(r, c, srcxf);
               end;
            end;
         end;
      end;

   end;
end;

function TXLSRange.Insert(Shift: OleVariant): OleVariant;
Var RangeType: integer;
    isRows: boolean;
    vt: TVarType;
    Value: LongWord;
    ShiftDefined: boolean;
    r1,r2,c1,c2: integer;
begin
  Result := true;
  RangeType := GetRangeType;
  isRows := false;

  r1 := FFirstRow;
  r2 := FLastRow;
  c1 := FFirstCol;
  c2 := FLastCol; 

  vt := VarType(Shift);
  ShiftDefined := false;

  if vt = varInteger then begin
     Value := LongWord(Shift);
     case Value of
        xlShiftToRight: begin
                         isRows := false;
                         ShiftDefined := true;
                         if RangeType = 2 then begin
                            if not((r1 = 0) and (r2 = XLSXMaxRow)) then
                            begin
                               RangeType := 0;
                            end;
                         end;
                       end;
        xlShiftDown:     begin
                         isRows := true;
                         ShiftDefined := true;
                         if RangeType = 1 then begin
                            if not((c1 = 0) and (c2 = XLSXMaxCol)) then
                            begin
                               RangeType := 0;
                            end;
                         end;
                       end;
     end;
  end;
  if not(ShiftDefined) then begin
     case RangeType of
       0: isRows := true;//cells
       1: isRows := false;//columns
       2: isRows := true;//rows
     end;
  end;

  if (RangeType = 2) then begin
     InsertRows;
  end else if (RangeType = 1) then begin
     InsertColumns;
  end else begin
     InsertRange(isRows);
  end;

  AfterInsert(RangeType, isrows);
end;

procedure TXLSRange.AfterInsert(RangeType: integer; isrows: boolean);
var d_col, d_row: integer;
begin
   d_col := 0;
   d_row := 0;
   if isRows then begin
      d_row :=  (FLastRow - FFirstRow + 1);
   end else begin
      d_col :=  (FLastCol - FFirstCol + 1);
   end;
   
   if RangeType = 1 then begin
      //entire columns
        FWorksheet.FCondFormatter.MoveRange(-1, FFirstCol,
                                            -1, FLastCol, 0, d_col); 
        FWorksheet.FDataValidator.MoveRange(-1, FFirstCol,
                                            -1, FLastCol, 0, d_col); 
   end else if RangeType = 2 then begin
      //entire rows
      FWorksheet.FCondFormatter.MoveRange(FFirstRow, -1,
                                          FLastRow,  -1, d_row, 0);
      FWorksheet.FDataValidator.MoveRange(FFirstRow, -1,
                                          FLastRow,  -1, d_row, 0);
   end else begin
      //range
      if isRows then begin
         FWorksheet.FCondFormatter.MoveRange(FFirstRow, FFirstCol,
                                             -1,  FLastCol, d_row, 0);
         FWorksheet.FDataValidator.MoveRange(FFirstRow, FFirstCol,
                                             -1,  FLastCol, d_row, 0);
      end else begin
         FWorksheet.FCondFormatter.MoveRange(FFirstRow, FFirstCol,
                                             FLastRow,  -1, 0, d_col);
         FWorksheet.FDataValidator.MoveRange(FFirstRow, FFirstCol,
                                             FLastRow,  -1, 0, d_col);
      end;
   end;
    

   if isrows then begin
      FWorksheet._Drawing.Comments.MoveComments(FFirstRow, FFirstCol, 
         XLSXMaxRow, FLastCol, d_row, d_col);
      FWorksheet.GetCustomHyperlinks.Move(FFirstRow, FFirstCol, 
         XLSMaxRow, FLastCol, d_row, d_col);
   end else begin
      FWorksheet._Drawing.Comments.MoveComments(FFirstRow, FFirstCol, 
         FLastRow, XLSXMaxCol, d_row, d_col);
      FWorksheet.GetCustomHyperlinks.Move(FFirstRow, FFirstCol, 
         FLastRow, XLSMaxCol, d_row, d_col);
   end;

   FWorksheet.FWorkbook.IncChangeID;
end;


procedure TXLSRange.UnMergeOutgoingRanges(Row1, Col1, Row2,
  Col2: integer);
Var row, col: integer;
    Cell: TXLSCellRef;
    MergeCell: TXLSCellRef;
begin
  //top edge
  row := Row1;
  for col := Col1 to Col2 do begin
      Cell := FWorkSheet.FCells.GetValue(row, col);
      if Assigned(Cell) then begin
         if Cell.FMerged then begin
            MergeCell := Cell.FMergeCell;
            if MergeCell.FRow < Row1 then begin
               UnmergeCell(MergeCell);
            end;
         end;
      end;
  end;

  //bottom edge
  row := Row2;
  for col := Col1 to Col2 do begin
      Cell := FWorkSheet.FCells.GetValue(row, col);
      if Assigned(Cell) then begin
         if Cell.FMerged then begin
            MergeCell := Cell.FMergeCell;
            if integer(MergeCell.FRow + MergeCell.FMergeRowCount - 1) > Row2 then begin
               UnmergeCell(MergeCell);
            end;
         end;
      end;
  end;

  //left edge
  col := col1;
  for row := Row1 to Row2 do begin
      Cell := FWorkSheet.FCells.GetValue(row, col);
      if Assigned(Cell) then begin
         if Cell.FMerged then begin
            MergeCell := Cell.FMergeCell;
            if MergeCell.FCol < Col1 then begin
               UnmergeCell(MergeCell);
            end;
         end;
      end;
  end;

  //right edge
  col := col2;
  for row := Row1 to Row2 do begin
      Cell := FWorkSheet.FCells.GetValue(row, col);
      if Assigned(Cell) then begin
         if Cell.FMerged then begin
            MergeCell := Cell.FMergeCell;
            if (MergeCell.FCol + MergeCell.FMergeColCount - 1) > Col2 then begin
               UnmergeCell(MergeCell);
            end;
         end;
      end;
  end;

end;

procedure TXLSRange.UnMerge;
Var row, col: integer;
    row1, row2, col1, col2: integer;
    UsedRange: IXLSRange;
    Cell: TXLSCellRef;
begin
  row1 := FFirstRow;
  row2 := FLastRow;
  col1 := FFirstCol;
  col2 := FLastCol;
  UsedRange := FWorkSheet.UsedRange;
  if row1 < UsedRange.FirstRow then row1 := UsedRange.FirstRow;
  if row2 > UsedRange.LastRow  then row2 := UsedRange.LastRow;
  if col1 < UsedRange.FirstCol then col1 := UsedRange.FirstCol;
  if col2 > UsedRange.LastCol  then col2 := UsedRange.LastCol;
  UsedRange := nil;
  if (row2 >= row1) and (col2 >= col1) then begin
    for row := row1 to row2 do begin
       for col := col1 to col2 do begin
          Cell := FWorkSheet.FCells.GetValue(row, col);
          if Assigned(Cell) then begin
             if Cell.Merged then begin
                UnMergeCell(Cell.FMergeCell);
             end;
          end;
       end;
    end;
  end;
end;

function TXLSRange.XFIndex: integer;
Var r: boolean;
begin
  Result := GetXFIndex(Row - 1, Column - 1, r);
end;


procedure TXLSRange.UnMergeCell(Cell: TXLSCellRef);
Var CurCell: TXLSCellRef;
    row, col: integer;
    rc, cc: integer;
begin
  rc := Cell.FMergeRowCount;
  cc := Cell.FMergeColCount;
  for row := 0 to rc - 1 do begin
     for col := 0 to cc - 1 do begin
          CurCell := FWorkSheet.FCells.GetValue(row + Cell.FRow, col + Cell.FCol);
          if Assigned(CurCell) then begin
             CurCell.FMergeCell := nil;
             CurCell.FMergeRowCount := 0;
             CurCell.FMergeColCount := 0;
             CurCell.FMerged := false;
          end;
     end;
  end;
end;

procedure TXLSRange.RowsGroup(Step: integer);
var row, row1, row2: integer;
begin
  row1 := FFirstRow;
  row2 := FLastRow;
  With FWorksheet do begin
    for row := row1 to row2 do begin
      _RowInfo.OutlineLevel[row] := _RowInfo.OutlineLevel[row] + Step;
    end;
  end;
end;

procedure TXLSRange.ColumnsGroup(Step: integer);
var col, col1, col2: integer;
begin
  col1 := FFirstCol;
  col2 := FLastCol;
  With FWorksheet do begin
    for col := col1 to col2 do begin
      _ColumnInfo.OutlineLevel[col] := _ColumnInfo.OutlineLevel[col] + Step;
    end;
  end;
end;

procedure TXLSRange.Group(Rows: boolean);
begin
  if Rows then RowsGroup(1) else ColumnsGroup(1);
end;

procedure TXLSRange.UnGroup(Rows: boolean);
begin
  if Rows then RowsGroup(-1) else ColumnsGroup(-1);
end;

procedure TXLSRange.ClearOutline;
begin
  Columns.OutlineLevel := 1;
  Rows.OutlineLevel := 1;
end;


function  TXLSRange.GetIndentLevel: integer;
Var  ReplaceIndex: boolean;
begin
  Result := FWorkSheet.FWorkBook.FXFList.GetIndentLevel(GetXFIndex(FFirstRow, FFirstCol, ReplaceIndex));
end;

procedure TXLSRange.SetIndentLevel(Value: integer);
begin
  if (Value >= 0) and (Value <= 15) then begin
     SetXFProperty(Value, FWorkSheet.FWorkBook.FXFList.SetIndentLevel);
  end;
end;

function TXLSRange.GetRowsOutlineLevel: integer;
var row, row1, row2: integer;
    lev: integer;
begin
  Result := 1;
  row1 := FFirstRow;
  row2 := FLastRow;
  With FWorksheet do begin
    for row := row1 to row2 do begin
      lev := _RowInfo.OutlineLevel[row];
      if lev > Result then Result := lev;
    end;
  end;
end;


procedure TXLSRange.SetRowsOutlineLevel(Value: integer);
var row, row1, row2: integer;
begin
  row1 := FFirstRow;
  row2 := FLastRow;
  With FWorksheet do begin
    for row := row1 to row2 do begin
      _RowInfo.OutlineLevel[row] := Value;
    end;
  end;
end;


function TXLSRange.GetColumnsOutlineLevel: integer;
var col, col1, col2: integer;
    lev: integer;
begin
  Result := 1;
  col1 := FFirstCol;
  col2 := FLastCol;
  With FWorksheet do begin
    for col := col1 to col2 do begin
      lev := _ColumnInfo.OutlineLevel[col];
      if lev > Result then Result := lev;
    end;
  end;
end;


procedure TXLSRange.SetColumnsOutlineLevel(Value: integer);
var col, col1, col2: integer;
begin
  col1 := FFirstCol;
  col2 := FLastCol;
  With FWorksheet do begin
    for col := col1 to col2 do begin
      _ColumnInfo.OutlineLevel[col] := Value;
    end;
  end;
end;


function TXLSRange.SaveAs(FileName: wideString; FileFormat: TXLSFileFormat): integer;
Var CSVSaver: TXLSCSVSaver;
    HTMLSaver: TXLSHTMLExport;
begin
  case FileFormat of
     xlHTML: begin
               HTMLSaver := TXLSHTMLExport.Create;
               try
                  try
                      Result := HTMLSaver.SaveAsHTML(self, FileName);
                  except
                    on E:Exception do begin
                       Result := -1;
                    end; 
                  end; 
               finally
                  HTMLSaver.Free;
               end;
             end;
 
     xlCSV,
     xlUnicodeCSV:
           begin
               CSVSaver := TXLSCSVSaver.Create(FileFormat=xlUnicodeCSV);
               try
                  try 
                      Result := CSVSaver.SaveAs(FileName, self.Value); 
                  except
                    on E:Exception do begin
                       Result := -1;
                    end; 
                  end; 
               finally
                 CSVSaver.Free;  
               end;
            end;
 
     xlText,
     xlUnicodeText:
             begin
               CSVSaver := TXLSTSVSaver.Create(FileFormat=xlUnicodeText);
               try
                  try 
                      Result := CSVSaver.SaveAs(FileName, self.Value); 
                  except
                    on E:Exception do begin
                       Result := -1;
                    end; 
                  end; 
               finally
                 CSVSaver.Free;  
               end;
             end;
     else 
              Result := -1;
  end; 
end;

function TXLSRange.SaveAs(Stream: TStream; FileFormat: TXLSFileFormat): integer;
Var CSVSaver: TXLSCSVSaver;
    HTMLSaver: TXLSHTMLExport;
begin
  case FileFormat of
     xlHTML: begin
               HTMLSaver := TXLSHTMLExport.Create;
               try
                  try
                      Result := HTMLSaver.SaveAsHTML(self, Stream);
                  except
                    on E:Exception do begin
                       Result := -1;
                    end; 
                  end; 
               finally
                  HTMLSaver.Free;
               end;
             end;
 
     xlCSV,
     xlUnicodeCSV:
            begin
               CSVSaver := TXLSCSVSaver.Create(FileFormat=xlUnicodeCSV);
               try
                  try 
                      Result := CSVSaver.SaveAs(Stream, self.Value); 
                  except
                    on E:Exception do begin
                       Result := -1;
                    end; 
                  end; 
               finally
                 CSVSaver.Free;  
               end;
            end;
 
     xlText,
     xlUnicodeText: 
            begin
               CSVSaver := TXLSTSVSaver.Create(FileFormat=xlUnicodeText);
               try
                  try 
                      Result := CSVSaver.SaveAs(Stream, self.Value); 
                  except
                    on E:Exception do begin
                       Result := -1;
                    end; 
                  end; 
               finally
                 CSVSaver.Free;  
               end;
            end;
     else 
              Result := -1;
  end; 
end;




function TXLSRange.SaveAsCSV(FileName: WideString): integer;
Var Saver: TXLSCSVSaver;
begin
  Saver := TXLSCSVSaver.Create;
  try
    Result := Saver.SaveAs(FileName, self.Value); 
  finally
    Saver.Free;  
  end;
end;

procedure TXLSRange.Autofilter;
begin
  if FWorksheet._Autofilter.Defined then begin 
     FWorksheet._Autofilter.Clear(true);   
  end else begin
     FWorksheet._Autofilter.Add(Row, Column, 
                                Row + integer(Rows.Count) - 1, 
                                Column + integer(Columns.Count) - 1);  
  end;
end;

procedure TXLSRange.Autofilter(Field: integer; Criteria1: Variant);
begin
end;

procedure TXLSRange.Autofilter(Field: integer; Criteria1: Variant; VisibleDropDown: boolean); 
begin
end;

procedure TXLSRange.Autofilter(Field: integer; Criteria1: Variant; Operator: XlAutoFilterOperator; Criteria2: Variant); 
begin
end;

procedure TXLSRange.Autofilter(Field: integer; Criteria1: Variant; Operator: XlAutoFilterOperator; Criteria2: Variant; VisibleDropDown: boolean); 
begin
end;

{TXLSCellBlock}
constructor TXLSCellBlock.Create(AKey: Longint);
begin
   inherited Create(AKey);     
   FCnt := 0;
end;

destructor TXLSCellBlock.Destroy;
var i: integer;
begin
   if FCnt > 0 then begin
      for i := 0 to $3F do begin
         if Assigned(FArr[i]) then begin
            FArr[i].Free;
         end;
      end;
   end;
   inherited Destroy;
end;

function TXLSCellBlock.GetRow: integer;
begin
   Result := Key shr 8;
end;

procedure TXLSCellBlock.SetCell(Index: integer; Cell: TXLSCellRef);
begin
   FArr[Index] := Cell;
   Inc(FCnt);
end;

function TXLSCellBlock.GetFirstCell: TXLSCellRef;
var i: integer;
begin
   Result := nil;
   for i := 0 to $3F do begin
      if Assigned(FArr[i]) then begin
         Result := FArr[i];
         break;
      end;
   end;
end;

function TXLSCellBlock.GetNextCell(index: integer): TXLSCellRef;
var i: integer;
begin
   Result := nil;
   if index < $3F then begin
      for i := index + 1 to $3F do begin
         if Assigned(FArr[i]) then begin
            Result := FArr[i];
            break;
         end;
      end;
   end;
end;

function TXLSCellBlock.DeleteCell(index: integer): TXLSCellRef;
begin
   Result := FArr[index];
   if Assigned(Result) then begin
      Dec(FCnt);
      FArr[index] := nil;
   end;
end;

function TXLSCellBlock.IsEmpty: boolean;
begin
   Result := FCnt = 0;
end;

{ TXLSCellHeap }
constructor TXLSCellHeap.Create(const WorkSheet: IXLSWorksheet);
begin
  inherited Create();
  FOnDestroy := false;
  FWorkSheet := WorkSheet;
end;

procedure TXLSCellHeap.MoveCell(srcrow, srccol,
   dstrow, dstcol: integer; keepformat: boolean;
   row1, col1, row2, col2, drow, dcol: integer);
var srccell: TXLSCellRef;
    srcxfindex: integer;
    dstxfindex: integer;
    tmp: boolean;
    compiledformula: TXLSCompiledFormula;
begin
   if (dstrow <> srcrow) or (dstcol <> srccol) then begin
      DeleteValue(dstrow, dstcol);
      srccell := GetValue(srcrow, srccol);

      if Assigned(srccell) then begin

         if keepformat and (srccell.FXFIndex = 0) then begin
            srccell.FXFIndex := FWorksheet.GetXFIndex(srcrow, srccol, tmp);
         end;


         if srccell.FValueType = xlFormula then begin
            compiledformula := srccell.FCompiledFormula;
            srccell.FCompiledFormula := compiledformula.GetCopy(row1, col1, row2, col2, drow, dcol); 
            compiledformula.Free;
         end;

         if (srccell.FValueType = xlEmpty) and
            (srccell.FMerged = false) and
            (FWorksheet.GetXFIndex(dstrow, dstcol, tmp) = srccell.FXFIndex) then
         begin
            //keep dst cell empty
            DeleteValue(srcrow, srccol);
         end else begin
            //set dst cell
            SetValue(dstrow, dstcol, srccell);
            //delete src cell
            EraseValue(srcrow, srccol);
         end;
      end else begin
         if keepformat then begin
            srcxfindex := FWorksheet.GetXFIndex(srcrow, srccol, tmp);
            dstxfindex := FWorksheet.GetXFIndex(dstrow, dstcol, tmp);
            if srcxfindex <> dstxfindex then begin
               FWorksheet._SetXF(dstrow, dstcol, srcxfindex);
            end;
         end;
      end;
   end;
end;

function TXLSCellHeap.NodeCreate(AKey: Longint): TAVLNode;
begin
   Result := TXLSCellBlock.Create(AKey);
end;

procedure TXLSCellHeap.NodeDeleted(ANode: TAVLNode);
var b: TXLSCellBlock;
    c: TXLSCellRef;
    i: integer;
begin
   if FOnDestroy then begin
      b := TXLSCellBlock(ANode);
      if FFreeSST then begin
         for i := 0 to $3F do begin
            c := b.FArr[i];
            if Assigned(c) then begin
               if c.FValueType = xlString then
                  FWorksheet.FWorkbook.FSST.Remove(c.FStringIndex);
            end;
         end;
      end;
      b.Free;
   end;
end;

procedure TXLSCellHeap.Create_Cell(Row: integer; Col: integer; var Cell: TXLSCellRef);
var tmp: boolean;
    c: TXLSCellRef;
    RowInfo: TXLSRowInfo;
begin
   if Not(Assigned(Cell)) then begin
      c := TXLSCellRef.Create(Row, Col);
      c.FXFIndex := FWorksheet.GetXFIndex(row, col, tmp);
      Cell := c;
  
      if Cell.FXFIndex > 0 then
         FWorkSheet.FWorkBook.FXFList.ReplaceIndex(0, Cell.FXFIndex);
   end else begin
      Cell.FRow := Row;
      Cell.FCol := Col;
   end;

   if (FMinRow > Row) or (FRowCount = 0) then begin
      FMinRow := Row;
      FRowCount := FMaxRow - FMinRow + 1;
   end;
   if (FMaxRow < Row) or (FRowCount = 0) then begin
      FMaxRow := Row;
      FRowCount := FMaxRow - FMinRow + 1;
   end;
   if (FMinCol > Col) or (FColCount = 0) then begin
      FMinCol := Col;
      FColCount := FMaxCol - FMinCol + 1;
   end;
   if (FMaxCol < Col) or (FColCount = 0) then begin
      FMaxCol := Col;
      FColCount := FMaxCol - FMinCol + 1;
   end;

   RowInfo := FWorksheet._RowInfo.GetOrCreateRowInfo(Row);
   if (RowInfo.MinCol < 0) or (RowInfo.MinCol > Col) then begin
      RowInfo.MinCol := Col;
   end;
   if (RowInfo.MaxCol < Col) then begin
      RowInfo.MaxCol := Col;
   end;

end;

destructor TXLSCellHeap.Destroy;
begin
  FFreeSST := false;
  FOnDestroy := true;
  if Assigned(FWorksheet) then
     if Assigned(FWorksheet.FWorkbook) then
        if Assigned(FWorksheet.FWorkbook.FSST) then FFreeSST := true;
  inherited Destroy;
end;


function TXLSCellHeap.GetOrCreateValue(Row, Col: integer): TXLSCellRef;
Var
  lKey: Longint;
  b: TXLSCellBlock;
begin
  lKey := Row;
  lKey := (lKey shl 8) or (Col shr 6);
  b := TXLSCellBlock(GetOrCreateNode(lKey));
  if Assigned(b) then begin
     Result := b.FArr[Col and $3F];
     if not(Assigned(Result)) then begin
        Create_Cell(Row, Col, Result);
        b.SetCell(Col and $3F, Result);
     end;
  end else begin
     Result := nil;
  end;
end;

procedure TXLSCellHeap.SetValue(Row, Col: integer; cell: TXLSCellRef);
var
  lKey: Longint;
  b: TXLSCellBlock;
begin
  lKey := Row;
  lKey := (lKey shl 8) or (Col shr 6);
  b := TXLSCellBlock(GetOrCreateNode(lKey));
  if Assigned(b) then begin
     if Assigned(b.FArr[Col and $3F]) then begin
        DeleteValue(row,col);
        b := TXLSCellBlock(GetOrCreateNode(lKey));
     end;
  end;

  if Assigned(b) then begin
     b.SetCell(Col and $3F, cell);
     Create_Cell(row, col, cell);
  end;
end;

function TXLSCellHeap.GetFirstRowCell(Row: integer): TXLSCellRef;
var 
   lKey: Longint;
   b: TXLSCellBlock;
begin
  lKey := Row;
  lKey := (lKey shl 8);
  b := TXLSCellBlock(GetNodeGE(lKey));
  if Assigned(b) then begin
     if b.Row <> Row then begin
        Result := nil;
     end else begin
        Result := b.GetFirstCell();
     end;
  end else begin
     Result := nil;
  end;
end;

function TXLSCellHeap.GetNextRowCell(Cell: TXLSCellRef): TXLSCellRef;
var 
   lKey: Longint;
   b: TXLSCellBlock;
begin
  Result := nil;
  lKey := Cell.Row;
  lKey := (lKey shl 8) or (Cell.Col shr 6);
  if (Cell.Col and $3F) < $3F then begin
     b := TXLSCellBlock(GetNode(lKey));
     if Assigned(b) then begin
        Result := b.GetNextCell(Cell.Col and $3F);
     end;
  end;
  if not(Assigned(Result)) then begin
     b := TXLSCellBlock(GetNodeNext(lKey));
     if Assigned(b) then begin
        if b.Row = Cell.Row then begin
           Result := b.GetFirstCell();
        end;
     end;
  end;
end;

function TXLSCellHeap.GetValue(Row, Col: integer): TXLSCellRef;
Var
   lKey: Longint;
   b: TXLSCellBlock;
begin
   lKey := Row;
   lKey := (lKey shl 8) or (Col shr 6);
   b := TXLSCellBlock(GetNode(lKey));
   if Assigned(b) then begin
      Result := b.FArr[Col and $3F];
   end else begin
      Result := nil;
   end;
end;

//the same to DeleteValue but without cell free
procedure TXLSCellHeap.EraseValue(Row, Col: integer);
Var
   cell: TXLSCellRef;
   lKey: Longint;
   b: TXLSCellBlock;
begin
   lKey := Row;
   lKey := (lKey shl 8) or (Col shr 6);
   b := TXLSCellBlock(GetNode(lKey));
   if Assigned(b) then begin
      cell := b.DeleteCell(Col and $3F);
      if Assigned(cell) then begin
         //if cell.FValueType = xlString then begin
         //   FWorksheet.FWorkbook.FSST.Remove(cell.FStringIndex);
         //end;
         //cell.Free;
         if b.IsEmpty then begin
            DeleteNode(lKey);
            b.Free;
         end;
         CellDeleted(row, col);
      end;
   end;
end;

procedure TXLSCellHeap.DeleteValue(Row, Col: integer);
Var
   cell: TXLSCellRef;
   lKey: Longint;
   b: TXLSCellBlock;
begin
   lKey := Row;
   lKey := (lKey shl 8) or (Col shr 6);
   b := TXLSCellBlock(GetNode(lKey));
   if Assigned(b) then begin
      cell := b.DeleteCell(Col and $3F);
      if Assigned(cell) then begin
         if cell.FValueType = xlString then begin
            FWorksheet.FWorkbook.FSST.Remove(cell.FStringIndex);
         end;
         cell.Free;
         if b.IsEmpty then begin
            DeleteNode(lKey);
            b.Free;
         end;
         CellDeleted(row, col);
      end;
   end;
end;

procedure TXLSCellHeap.CellDeleted(Row, Col: integer);
var RowInfo: TXLSRowInfo;
    c1,c2: integer;
    rowisempty: boolean;
    c,r: integer;
begin
   rowisempty := false;
   RowInfo := FWorksheet._RowInfo.GetRowInfo(Row);

   if Assigned(RowInfo) then begin
      //change row's dimensions
      c1 := RowInfo.MinCol;
      c2 := RowInfo.MaxCol;
      if (c1 = Col) and (c2 = Col) then begin
         //last cell in the row
         if FWorksheet._RowInfo.IsEqualsToDefault(RowInfo) then begin
            FWorksheet._RowInfo.DeleteRow(Row);
         end else begin
            RowInfo.MinCol := -1;
            RowInfo.MaxCol := -1;
         end;
         rowisempty := true;
      end else if (c1 < c2) and (c1 = Col) then begin
         //change row dimensions
         for c := c1 + 1 to c2 do begin
            if Assigned(GetValue(Row, c)) then begin
               RowInfo.MinCol := c;
               break;
            end;
         end;
      end else if (c1 < c2) and (c2 = Col) then begin
         //change row dimensions
         for c := c2 - 1 downto c1 do begin
            if Assigned(GetValue(Row, c)) then begin
               RowInfo.MaxCol := c;
               break;
            end;
         end;
      end;
   end;

   if rowisempty and (FRowCount > 0) then begin
      if (row = FMinRow) and (row = FMaxRow) then begin
         //sheet is empty
         FRowCount := 0;
         FMinRow := 0;
         FMaxRow := 0;
         FMinCol := 0;
         FMaxCol := 0;
         FColCount := 0;
      end else if (row = FMinRow) then begin
         //row is the first row of used range
         for r := FMinRow + 1 to FMaxRow do begin
            RowInfo := FWorksheet._RowInfo.GetRowInfo(r);
            if Assigned(RowInfo) and (RowInfo.MinCol >= 0) then begin
               FMinRow := r;
               FRowCount := FMaxRow - FMinRow + 1;
               break;
            end;
         end;
      end else if (row = FMaxRow) then begin
         //row is the last row of used range
         for r := FMaxRow - 1 downto FMinRow do begin
            RowInfo := FWorksheet._RowInfo.GetRowInfo(r);
            if Assigned(RowInfo) and (RowInfo.MinCol >= 0) then begin
               FMaxRow := r;
               FRowCount := FMaxRow - FMinRow + 1;
               break;
            end;
         end;
      end;;
   end;

   if (Col = FMinCol) and (FRowCount > 0) then begin
      //col is the first column of used range
      c := FMaxCol;
      for r := FMinRow to FMaxRow do begin
         RowInfo := FWorksheet._RowInfo.GetRowInfo(r);
         if Assigned(RowInfo) and (RowInfo.MinCol >= 0) then begin
            if RowInfo.MinCol < c then begin
               c := RowInfo.MinCol;
               if c = FMinCol then break;
            end;
         end;
      end;
      if c > FMinCol then begin
         FMinCol := c;
         FColCount := FMaxCol - FMinCol + 1;
      end;
   end else if (Col = FMaxCol) and (FRowCount > 0) then begin
      //col is the first column of used range
      c := FMinCol;
      for r := FMinRow to FMaxRow do begin
         RowInfo := FWorksheet._RowInfo.GetRowInfo(r);
         if Assigned(RowInfo) and (RowInfo.MaxCol >= 0) then begin
            if RowInfo.MaxCol > c then begin
               c := RowInfo.MaxCol;
               if c = FMaxCol then break;
            end;
         end;
      end;
      if c < FMaxCol then begin
         FMaxCol := c;
         FColCount := FMaxCol - FMinCol + 1;
      end;
   end;
end;

{ TXLSFont }
constructor TXLSFont.Create(const Range: TXLSRange);
begin
   inherited Create;
   //FCheckRefCount := true;
   FRange := Range;
end;

function TXLSFont.GetBold: boolean;
begin
  Result := FRange.GetFontBold;
end;

function TXLSFont.GetColor: LongWord;
begin
  Result := FRange.GetFontColor;
end;

function TXLSFont.GetThemeColor: LongWord;
begin
  Result := FRange.GetFontThemeColor;
end;

function TXLSFont.GetTintAndShade: double;
begin
  Result := FRange.GetFontTintAndShade;
end;

function TXLSFont.GetColorIndex: LongWord;
begin
  Result := FRange.GetFontColorIndex;
end;

function TXLSFont.GetItalic: boolean;
begin
  Result := FRange.GetFontItalic;
end;

function TXLSFont.GetName: widestring;
begin
  Result := FRange.GetFontName;
end;

function TXLSFont.GetOutLineFont: boolean;
begin
  Result := FRange.GetFontOutLineFont;
end;

function TXLSFont.GetShadow: boolean;
begin
  Result := FRange.GetFontShadow;
end;

function TXLSFont.GetSize: Single;
begin
  Result := FRange.GetFontSize;
end;


function TXLSFont.GetCharSet: Byte;
begin
  Result := FRange.GetFontCharSet;
end;

function TXLSFont.GetFamily: Byte;
begin
  Result := FRange.GetFontFamily;
end;

function TXLSFont.GetStrikethrough: boolean;
begin
  Result := FRange.GetFontStrikethrough;
end;

function TXLSFont.GetSubScript: boolean;
begin
  Result := FRange.GetFontSubScript;
end;

function TXLSFont.GetSuperScript: boolean;
begin
  Result := FRange.GetFontSuperScript;
end;

function TXLSFont.GetUnderLine: LongWord;
Var Value: byte;
begin
  Result := xlUnderlineStyleNone;
  Value := FRange.GetFontUnderLine;
  case Value of
     0: Result := xlUnderlineStyleNone;
     1: Result := xlUnderlineStyleSingle;
     2: Result := xlUnderlineStyleDouble;
    33: Result := xlUnderlineStyleSingleAccounting;
    34: Result := xlUnderlineStyleDoubleAccounting;
  end;
end;

procedure TXLSFont.SetBold(const Value: boolean);
begin
  FRange.SetFontBold(Value);
end;

procedure TXLSFont.SetColor(const Value: LongWord);
begin
  FRange.SetFontColor(Value);
end;

procedure TXLSFont.SetThemeColor(const Value: LongWord);
begin
  FRange.SetFontThemeColor(Value);
end;

procedure TXLSFont.SetTintAndShade(const Value: double);
begin
  FRange.SetFontTintAndShade(Value);
end;

procedure TXLSFont.SetColorIndex(const Value: LongWord);
begin
  FRange.SetFontColorIndex(Value);
end;

procedure TXLSFont.SetItalic(const Value: boolean);
begin
  FRange.SetFontItalic(Value);
end;

procedure TXLSFont.SetName(const Value: widestring);
begin
  FRange.SetFontName(Value);
end;

procedure TXLSFont.SetOutLineFont(const Value: boolean);
begin
  FRange.SetFontOutLineFont(Value);
end;

procedure TXLSFont.SetShadow(const Value: boolean);
begin
  FRange.SetFontShadow(Value);
end;

procedure TXLSFont.SetSize(const Value: Single);
begin
  FRange.SetFontSize(Value);
end;

procedure TXLSFont.SetStrikethrough(const Value: boolean);
begin
  FRange.SetFontStrikethrough(Value);
end;

procedure TXLSFont.SetSubScript(const Value: boolean);
begin
  FRange.SetFontSubScript(Value);
end;

procedure TXLSFont.SetSuperScript(const Value: boolean);
begin
  FRange.SetFontSuperScript(Value);
end;

procedure TXLSFont.SetCharSet(const Value: byte);
begin
  FRange.SetFontCharSet(Value);
end;

procedure TXLSFont.SetFamily(const Value: byte);
begin
  FRange.SetFontFamily(Value);
end;

procedure TXLSFont.SetUnderLine(const Value: LongWord);
Var set_value: byte;
    Err: boolean;
begin
  Err := false;
  set_value := 0;
  case Value of
              xlUnderlineStyleSingle: set_value := 1;
    xlUnderlineStyleSingleAccounting: set_value := 33;
    xlUnderlineStyleDoubleAccounting: set_value := 34;
                xlUnderlineStyleNone: set_value := 0;
              xlUnderlineStyleDouble: set_value := 2;
  else Err := true;
  end;

  if Not(Err) then FRange.SetFontUnderLine(set_value);
end;

{IXLSWorksheet}
function IXLSWorksheet.StoreCalculationSettings: integer;
Var Data: TXLSBlob;
begin
  //Calc mode
  Data := TXLSBlob.Create(6);
  Data.AddWord($000D);
  Data.AddWord($0002);
  Data.AddWord($0001); //automatically (default)
  Result := AppendData(Data, FDataHeader);
  if Result <> 1 then exit;

  //Calc count
  Data := TXLSBlob.Create(6);
  Data.AddWord($000C);
  Data.AddWord($0002);
  Data.AddWord($0064);
  Result := AppendData(Data, FDataHeader);
  if Result <> 1 then exit;

  //Ref mode
  Data := TXLSBlob.Create(6);
  Data.AddWord($000F);
  Data.AddWord($0002);
  Data.AddWord($0001); //A1 mode
  Result := AppendData(Data, FDataHeader);
  if Result <> 1 then exit;

  //Iterations
  Data := TXLSBlob.Create(6);
  Data.AddWord($0011);
  Data.AddWord($0002);
  Data.AddWord(0); //Iterations off 
  Result := AppendData(Data, FDataHeader);
  if Result <> 1 then exit;

  //Delta
  Data := TXLSBlob.Create(12);
  Data.AddWord($0010);
  Data.AddWord($0008);
  Data.AddDouble(0.001); 
  Result := AppendData(Data, FDataHeader);
  if Result <> 1 then exit;

  //SaveRecalc
  Data := TXLSBlob.Create(6);
  Data.AddWord($005F);
  Data.AddWord($0002);
  Data.AddWord(1); //recalc before save 
  Result := AppendData(Data, FDataHeader);
  if Result <> 1 then exit;
  
end;


function IXLSWorksheet.StoreAllColumnInfo: integer;
Var i: integer;
    startcol, count: integer;
    Data: TXLSBlob;
    storecur: boolean;
    colinfo: TXLSColumnInfo;
    startcolinfo: TXLSColumnInfo;
begin
  FColumnInfo.MaxOutlinelevel := 0;
  Data := FColumnInfo.GetDefColWidthBlob;
  Result := AppendData(Data, FDataHeader);
  if Result <> 1 then exit;
  startcol := -1; count := 0;
  storecur := false; 
  startcolinfo := nil;

  for i := 0 to 255 do begin
    colinfo := FColumnInfo.GetColumnInfo(i);   
    if Assigned(colinfo) then begin
       if startcol < 0 then begin
          startcol := i;
          startcolinfo := colinfo; 
          count := 1;
       end;
       if (startcol < i) then begin
          if colinfo.isEqual(startcolinfo) then
             Inc(count)
          else 
             storecur := true;
       end;    
    end else 
       if (startcol < i) and (startcol >= 0) then storecur := true;

    if storecur then begin
       Data := FColumnInfo.GetColInfoBlob(startcol, FWorkbook.FFileFormat, count);
       Result := AppendData(Data, FDataHeader);
       if Result <> 1 then exit;
       storecur := false;

       if Assigned(colinfo) then begin       
          count := 1; startcol := i; startcolinfo := colinfo
       end else begin
          count := 0; startcol := -1; startcolinfo := nil;
       end;
    end;
  end;

  if count > 0 then begin
     Data := FColumnInfo.GetColInfoBlob(startcol, FWorkbook.FFileFormat, count);
     Result := AppendData(Data, FDataHeader);
     if Result <> 1 then exit;
  end;

end;

function IXLSWorksheet.StoreAllRowInfo: integer;
Var {i, min, max: integer;}
    Data: TXLSBlob;
begin
//  FRowInfo.MaxOutlineLevel := 0;
  Data := FRowInfo.GetDefRowInfoBlob;
  Result := AppendData(Data, FDataHeader);
{  if Result <> 1 then exit;
  if FRowInfo.RowCount > 0 then begin
     min := FRowInfo.MinRow;
     max := FRowInfo.MaxRow;
     for i := min to max do begin
       if Assigned(FRowInfo.Rows[i]) then begin
          Data := FRowInfo.GetRowInfoBlob(i);
          Result := AppendData(Data, FDataHeader);
          if Result <> 1 then exit;
       end;
     end;
  end;}
end;

function IXLSWorksheet.StoreRowInfo(FirstRow, LastRow: integer ): integer;
Var i, min, max: integer;
    Data: TXLSBlob;
begin
  Result := 1;  
  if FRowInfo.RowCount > 0 then begin

     min := FRowInfo.MinRow;
     max := FRowInfo.MaxRow;

     if FirstRow > min then min := FirstRow;
     if LastRow < max then max := LastRow;
     if min <= max then begin   
        for i := min to max do begin
          if Assigned(FRowInfo.Rows[i]) then begin
             Data := FRowInfo.GetRowInfoBlob(i);
             Result := AppendData(Data, FDataBody);
             if Result <> 1 then exit;
          end;
        end;
     end; 
  end;
end;



{ TXLSBorder }

constructor TXLSBorder.Create(Range: TXLSRange; BorderIndex: LongWord);
begin
  FRange := Range;
  //FCheckRefCount := true;
  FBorderIndex := BorderIndex;
end;


function TXLSBorder.GetColor: LongWord;
begin
  Result := FRange.GetBorderColor(FBorderIndex);
end;

function TXLSBorder.GetColorIndex: LongWord;
begin
  Result := FRange.GetBorderColorIndex(FBorderIndex);
end;

function TXLSBorder.GetThemeColor: LongWord;
begin
  Result := FRange.GetBorderThemeColor(FBorderIndex);
end;

function TXLSBorder.GetTintAndShade: double;
begin
  Result := FRange.GetBorderTintAndShade(FBorderIndex);
end;

function TXLSBorder.GetLineStyle: LongWord;
begin
  Result := FRange.GetBorderLineStyle(FBorderIndex);
end;

function TXLSBorder.GetWeight: LongWord;
begin
  Result := FRange.GetBorderWeight(FBorderIndex);
end;

procedure TXLSBorder.SetColor(const Value: LongWord);
begin
  FRange.SetBorderColor(FBorderIndex, Value);
end;

procedure TXLSBorder.SetColorIndex(const Value: LongWord);
begin
  FRange.SetBorderColorIndex(FBorderIndex, Value);
end;

procedure TXLSBorder.SetThemeColor(const Value: LongWord);
begin
  FRange.SetBorderThemeColor(FBorderIndex, Value);
end;

procedure TXLSBorder.SetTintAndShade(const Value: double);
begin
  FRange.SetBorderTintAndShade(FBorderIndex, Value);
end;

procedure TXLSBorder.SetLineStyle(const Value: LongWord);
begin
  FRange.SetBorderLineStyle(FBorderIndex, Value);
end;

procedure TXLSBorder.SetWeight(const Value: LongWord);
begin
  FRange.SetBorderWeight(FBorderIndex, Value);
end;

{ IXLSWorkSheets }


function IXLSWorkSheets.Add: IXLSWorkSheet;
begin
  Result := AddSheet(FCount + 1);
end;

function IXLSWorkSheets.Add(Before, After: IXLSWorkSheet): IXLSWorkSheet;
begin
  Result := Add(Before, After, 1, null);
end;

function IXLSWorkSheets.Add(Before, After: IXLSWorkSheet; Count: integer): IXLSWorkSheet;
begin
  Result := Add(Before, After, Count, null);
end;

function IXLSWorkSheets.Add(Before, After: IXLSWorkSheet; Count: integer;
  Type_: OleVariant): IXLSWorkSheet;
Var iBefore, iAfter, Index: integer;
    Sheet: IXLSWorkSheet;
    i: Integer;
begin
  if Assigned(Before) then begin
     Sheet := Before;
     iBefore := Sheet.Index;
  end else begin
     iBefore := 0;
  end;

  if Assigned(After) then begin
     Sheet := After;
     iAfter := Sheet.Index;
  end else begin
     iAfter := 0;
  end;

  if iBefore > 0 then Index := iBefore
  else if iAfter > 0 then Index := iAfter + 1
  else Index := self.Count + 1;

  Result := nil;
  if Count > 0 then begin
     for i := 1 to Count do begin
       Result := AddSheet(Index + i - 1);
     end;
   end;
end;

function IXLSWorkSheets.AddBefore(Index: integer): IXLSWorkSheet;
begin
  if (Index > 0) and (Index <= Count) then
    Result := Add(self[Index], nil, 1, null)
  else
    Result := Add;
end;

function IXLSWorkSheets.AddBefore(Name: WideString): IXLSWorkSheet;
begin
  Result := AddBefore(GetIndexByName(Name));
end;

function IXLSWorkSheets.AddBefore(WorkSheet: IXLSWorkSheet): IXLSWorkSheet;
begin
  Result := Add(WorkSheet, nil, 1, null);
end;

function IXLSWorkSheets.AddAfter(Index: integer): IXLSWorkSheet;
begin
  if (Index > 0) and (Index <= Count) then
    Result := Add(nil, self[Index], 1, null)
  else
    Result := Add;
end;

function IXLSWorkSheets.AddAfter(Name: WideString): IXLSWorkSheet;
begin
  Result := AddAfter(GetIndexByName(Name));
end;

function IXLSWorkSheets.AddAfter(WorkSheet: IXLSWorkSheet): IXLSWorkSheet;
begin
  Result := Add(nil, WorkSheet, 1, null);
end;

function IXLSWorkSheets.AddSheet(Index: integer): IXLSWorksheet;
Var SheetName: widestring;
    WorkSheet: IXLSWorksheet;
    i: integer;
begin
  SheetName := GetNewName();
  WorkSheet := IXLSWorksheet.Create(FWorkbook, GetNewSheetID());
  WorkSheet.FWorkSheetName := SheetName;
  Inc(FCount);
  SetLength(FWorkSheets, FCount);
  if Index < FCount then begin
     for i := FCount downto Index + 1 do begin
        FWorksheets[i - 1] := FWorksheets[i - 2];
        FWorksheets[i - 1].FIndex := i; 
     end;
  end;
  WorkSheet.FIndex := Index;
  FWorksheets[Index - 1] := WorkSheet;
  if FCount = 1 then WorkSheet.Activate;
  Result := WorkSheet;
end;

function IXLSWorkSheets.CheckName(Index: integer; Name: widestring): boolean;
Var i: SmallInt;
begin
  Result := true;

  //check length of worksheet name
  if Length(Name) > 31 then begin
     //MessageDlg('Length of Worksheet name must be less then 31 symbols', mtError, [mbOk], 0);
     Result := false;
     //exception
  end;

  //check symbols
  if Result then
    if (Pos(Name, '[') > 0) or
       (Pos(Name, ':') > 0) or
       (Pos(Name, '*') > 0) or
       (Pos(Name, '?') > 0) or
       (Pos(Name, '/') > 0) or
       (Pos(Name, '\') > 0) or
       (Pos(Name, ']') > 0) then begin
       //MessageDlg('Invalid worksheet name', mtError, [mbOk], 0);
       Result := false;
       //exception
    end;

  if Result then
    for i := 1 to FCount do begin
       if i <> Index then
         if FWorkSheets[i - 1].Name = Name then begin
           //MessageDlg('Duplicate worksheet name', mtError, [mbOk], 0);
           Result := false;
         end;
    end;

end;

constructor IXLSWorkSheets.Create(AWorkbook: TXLSWorkbook);
begin
  inherited Create;
  FCount := 0;
  FWorkBook := AWorkBook;
  FCurrentSheetID := 0;
end;

procedure IXLSWorkSheets.Delete(Index: integer);
Var i: integer;
    ActiveDropped: boolean;
    DelSheet: IXLSWorksheet;
begin
  DelSheet := nil;
  ActiveDropped := false;
  if (Index > 0) and (Index <= FCount) then begin
     if FWorkSheets[Index - 1] = FActiveSheet then ActiveDropped := true;
     DelSheet := FWorkSheets[Index - 1];
     FWorkSheets[Index - 1] := nil;
     for i := Index + 1 to FCount do begin
       FWorkSheets[i - 2] := FWorkSheets[i - 1];
       FWorkSheets[i - 2].FIndex := i - 1;
     end;
     Dec(FCount);
     SetLength(FWorkSheets, FCount);
     if ActiveDropped then begin
        if FCount > 0 then FWorkSheets[0].Activate
        else FActiveSheet := nil;
     end;
  end;
  if Assigned(DelSheet) then begin
     DelSheet.Free;
  end;
end;

procedure IXLSWorkSheets.Deselect;
Var i: integer;
begin
  for i := 1 to FCount do begin
      FWorkSheets[i - 1].FSelected := false;
  end;
end;

destructor IXLSWorkSheets.Destroy;
Var i: integer;
begin
  for i := 1 to FCount do begin
    if Assigned(FWorkSheets[i - 1]) then FWorkSheets[i - 1].Free;
  end;
  inherited Destroy;
end;

function IXLSWorkSheets.Get(Index: Integer): IXLSWorkSheet;
begin
  Result := GetSheet(Index);
end;

function IXLSWorkSheets.GetActiveSheet: IXLSWorksheet;
begin
  Result := FActiveSheet;
end;

function IXLSWorkSheets.GetCount: integer;
begin
  Result := FCount;
end;

function IXLSWorkSheets.GetNewName: widestring;
Var StartIndex: integer;

begin
   StartIndex := FCount + 1;
   Result :=  FWorkbook.FSheetName + inttostr(StartIndex);
   while not(CheckName(0, Result)) do begin
     Inc(StartIndex);
     Result :=  FWorkbook.FSheetName + inttostr(StartIndex);
   end;
end;

function IXLSWorkSheets.GetSheet(Index: Integer): IXLSWorksheet;
begin
  if (Index > 0) and (Index <= FCount) then
     Result := FWorkSheets[Index - 1]
  else
     Result := nil;
end;

function IXLSWorkSheets.GetIndexByName(SheetName: widestring): integer;
Var i: integer;
begin
  Result := -1;
  if FCount > 0 then begin
     for i := 1 to FCount do begin
         if SheetName = FWorkSheets[i - 1].Name then begin
            Result := i; 
            break; 
         end;
     end;
  end;
end;

function IXLSWorkSheets.GetIDByName(ASheetName: widestring): integer;
Var i: integer;
begin
  Result := -1;
  if FCount > 0 then begin
     for i := 1 to FCount do begin
         if ASheetName = FWorkSheets[i - 1].Name then begin
            Result := FWorkSheets[i - 1].FSheetID; 
            break; 
         end;
     end;
  end;
  if Result <= 0 then Result := -1;
end;

function IXLSWorkSheets.GetIndexByID(SheetID: integer): integer;
Var i: integer;
begin
  Result := -1;
  if FCount > 0 then begin
     for i := 1 to FCount do begin
         if SheetID = FWorkSheets[i - 1].FSheetID then begin
            Result := i; 
            break; 
         end;
     end;
  end;
end;

function IXLSWorkSheets.GetNameByID(SheetID: integer): widestring;
Var i: integer;
begin
  Result := '';
  if FCount > 0 then begin
     for i := 1 to FCount do begin
         if SheetID = FWorkSheets[i - 1].FSheetID then begin
            Result := FWorkSheets[i - 1].Name; 
            break; 
         end;
     end;
  end;
end;

procedure IXLSWorkSheets.MoveSheet(FromIndex, ToIndex: integer);
Var i: integer;
    Sheet: IXLSWorksheet;
begin
  if FromIndex <> ToIndex then begin
     Sheet := FWorkSheets[FromIndex - 1];
     if FromIndex < ToIndex then begin
        for i := FromIndex + 1 to ToIndex do begin
            FWorkSheets[i - 2] := FWorkSheets[i - 1];
            FWorkSheets[i - 2].FIndex := i - 1;
        end;
      end else begin
        for i := FromIndex - 1 downto ToIndex do begin
            FWorkSheets[i] := FWorkSheets[i - 1];
            FWorkSheets[i].FIndex := i + 1;
        end;
      end;
      FWorkSheets[ToIndex - 1] := Sheet;
      Sheet.FIndex := ToIndex;


  end;
end;

function IXLSWorksheets.GetNewSheetID: integer;
begin
  Inc(FCurrentSheetID);
  Result := FCurrentSheetID;
end;



{ TXLSBorders }

constructor TXLSBorders.Create(Range: TXLSRange);
begin
   inherited Create;
   //FCheckRefCount := true;
   FRange := Range;
end;

destructor TXLSBorders.Destroy;
begin
  inherited Destroy;
end;

function TXLSBorders.GetBorder(Index: LongWord): IXLSBorder;
begin
  Result := TXLSBorder.Create(FRange, Index);
end;

function TXLSBorders.GetColor: LongWord;
begin
  Result := FRange.FWorkSheet.FWorkBook.GetCustomColor(GetColorIndex);
end;

function TXLSBorders.GetThemeColor: LongWord;
Var Border: TXLSBorder;
begin
  Border := TXLSBorder.Create(FRange, xlEdgeTop);
  Result := Border.GetThemeColor;
  Border.Free;
end;

function TXLSBorders.GetTintAndShade: double;
Var Border: TXLSBorder;
begin
  Border := TXLSBorder.Create(FRange, xlEdgeTop);
  Result := Border.GetTintAndShade;
  Border.Free;
end;

function TXLSBorders.GetColorIndex: LongWord;
begin
  Result := FRange.GetBorderAllColorIndex;
end;

function TXLSBorders.GetLineStyle: LongWord;
begin
  Result := FRange.GetBorderAllLineStyle;
end;

function TXLSBorders.GetWeight: LongWord;
begin
  Result := FRange.GetBorderAllLineWeight;
end;

procedure TXLSBorders.SetColor(const Value: LongWord);
begin
  FRange.SetBordersColor(Value);
end;

procedure TXLSBorders.SetThemeColor(const Value: LongWord);
begin
  FRange.SetBordersThemeColor(Value);
end;

procedure TXLSBorders.SetTintAndShade(const Value: double);
begin
  FRange.SetBordersTintAndShade(Value);
end;

procedure TXLSBorders.SetColorIndex(const Value: LongWord);
begin
  FRange.SetBordersColorIndex(Value);
end;

procedure TXLSBorders.SetLineStyle(const Value: LongWord);
begin
  FRange.SetBordersLineStyle(Value);
end;

procedure TXLSBorders.SetWeight(const Value: LongWord);
begin
  FRange.SetBordersWeight(Value);
end;

{ TXLSPageBreaks }

function TXLSPageBreaks.AddPageBreak(Before: IXLSRange): TXLSPageBreak;
Var Position: integer;
    CurPosition: integer;
    Found: boolean;
    BeforeIndex: integer;
    i: integer;
begin
  if FVertical then
     Position := Before.FirstCol
  else
     Position := Before.FirstRow;

  Found := false;
  BeforeIndex := FCount + 1;
  if FCount > 0 then begin
     i := FCount;
     while i > 0 do begin
       CurPosition := FPageBreaks[i - 1].FPosition;
       if CurPosition > Position then begin
          BeforeIndex := i;
          Dec(i);
       end else if CurPosition = Position then begin
          BeforeIndex := i;
          Found := true;
          Break;
       end else begin
          Break;
       end;
     end;
  end;
  if Found then Result := FPageBreaks[BeforeIndex - 1]
  else begin
    Result := CreatePageBreak;
    Result.FPosition := Position;
    Inc(FCount);
    SetLength(FPageBreaks, FCount);
    if (BeforeIndex <= (FCount - 1)) and (FCount > 1) then begin
       for i := FCount - 1 downto BeforeIndex do begin
          FPageBreaks[i] := FPageBreaks[i - 1];
          FPageBreaks[i].FIndex := i - 1;
       end;
    end;
    FPageBreaks[BeforeIndex - 1] := Result;
    Result.FIndex := BeforeIndex;
  end;
end;

procedure TXLSPageBreaks.ClearAll;
Var i: integer;
begin
  if FCount > 0 then begin
     for i := 0 to FCount - 1 do begin
       FPageBreaks[i].Free;
     end;
  end;
  SetLength(FPageBreaks, 0);
  FCount := 0;
end;

constructor TXLSPageBreaks.Create(Worksheet: IXLSWorksheet);
begin
  FWorkSheet := Worksheet;
  FCount := 0;
end;

function TXLSPageBreaks.CreatePageBreak: TXLSPageBreak;
begin
  Result := nil;
end;

procedure TXLSPageBreaks.Delete(Index: integer);
Var i: integer;
begin
  if (Index > 0) and (Index <= FCount) then begin
     FPageBreaks[Index - 1].Free;
     for i := Index to FCount - 1 do begin
       FPageBreaks[i - 1] := FPageBreaks[i];
       FPageBreaks[i - 1].FIndex := i;
     end;
     Dec(FCount);
     SetLength(FPageBreaks, FCount);
  end;
end;

destructor TXLSPageBreaks.Destroy;
begin
  ClearAll;
  inherited Destroy;
end;

function TXLSPageBreaks.Get(Index: integer): TXLSPageBreak;
begin
  if (Index > 0) and (Index <= FCount) then
     Result := FPageBreaks[Index - 1]
  else
     Result := nil;
end;

function TXLSPageBreaks.GetCount: integer;
begin
  Result := FCount;
end;

function TXLSPageBreaks.GetLocation(Index: integer): TXLSRange;
Var row1, row2: integer;
    col1, col2: integer;
    PageBreak: TXLSPageBreak;
begin
   PageBreak := Get(Index);
   if Assigned(PageBreak) then begin
      if FVertical then begin
         row1 := 0;         col1 := PageBreak.FPosition;
         row2 := xlsXMaxRow; col2 := col1;  
      end else begin
         row1 := PageBreak.FPosition;  col1 := 0;
         row2 := row1;                 col2 := xlsXMaxCol;  
      end;
      Result := TXLSRange.Create(FWorkSheet, row1, col1, row2, col2);
  end else Result := nil;
end;

{ TXLSPageBreak }

constructor TXLSPageBreak.Create(PageBreaks: TXLSPageBreaks);
begin
  FPageBreaks := PageBreaks;
end;

procedure TXLSPageBreak.Delete;
begin
  FPageBreaks.Delete(FIndex);
end;

function TXLSVPageBreak.GetLocation: IXLSColsRange;
begin
  Result := FPageBreaks.GetLocation(FIndex);
end;

function TXLSHPageBreak.GetLocation: IXLSRowsRange;
begin
  Result := FPageBreaks.GetLocation(FIndex);
end;

{ TXLSVPageBreaks }

function TXLSVPageBreaks.Add(Before: IXLSRange): TXLSVPageBreak;
begin
  Result := AddPageBreak(Before) as TXLSVPageBreak;
end;

constructor TXLSVPageBreaks.Create(WorkSheet: IXLSWorksheet);
begin
  inherited Create(WorkSheet);
  FVertical := true;
end;

function TXLSVPageBreaks.CreatePageBreak: TXLSPageBreak;
begin
  Result := TXLSVPageBreak.Create(self);
end;

function TXLSVPageBreaks.GetPageBreak(Index: integer): TXLSVPageBreak;
begin
  Result := Get(Index) as TXLSVPageBreak;
end;

{ TXLSHPageBreaks }

function TXLSHPageBreaks.Add(Before: IXLSRange): TXLSHPageBreak;
begin
  Result := AddPageBreak(Before) as TXLSHPageBreak;
end;

constructor TXLSHPageBreaks.Create(WorkSheet: IXLSWorksheet);
begin
  inherited Create(WorkSheet);
  FVertical := false;
end;

function TXLSHPageBreaks.CreatePageBreak: TXLSPageBreak;
begin
  Result := TXLSHPageBreak.Create(self);
end;

function TXLSHPageBreaks.GetPageBreak(Index: integer): TXLSHPageBreak;
begin
  Result := Get(Index) as TXLSHPageBreak;
end;


{TXLSHyperLink}
constructor TXLSHyperLink.Create(AHyperLink: TXLSCustomHyperLink);
begin
  inherited Create;
  FHyperLink := AHyperLink;
end;

procedure TXLSHyperLink.Delete;
begin
 if Assigned(FHyperLink) then FHyperLink.Delete;
end;

function  TXLSHyperLink.GetAddress: Widestring;
begin
 if Assigned(FHyperLink) then Result := FHyperLink.Address
                         else Result := '';
end;

procedure TXLSHyperLink.SetAddress(Value: Widestring);
begin
 if Assigned(FHyperLink) then FHyperLink.Address := Value;
end;

function  TXLSHyperLink.GetSubAddress: Widestring;
begin
 if Assigned(FHyperLink) then Result := FHyperLink.SubAddress
                         else Result := '';
end;

procedure TXLSHyperLink.SetSubAddress(Value: Widestring);
begin
 if Assigned(FHyperLink) then FHyperLink.SubAddress := Value;
end;

function  TXLSHyperLink.GetScreenTip: Widestring;
begin
 if Assigned(FHyperLink) then Result := FHyperLink.ScreenTip
                         else Result := '';
end;

procedure TXLSHyperLink.SetScreenTip(Value: Widestring);
begin
 if Assigned(FHyperLink) then FHyperLink.ScreenTip := Value;
end;

function  TXLSHyperLink.GetDisplayText: Widestring;
begin
 if Assigned(FHyperLink) then Result := FHyperLink.DisplayText
                         else Result := '';
end;

procedure TXLSHyperLink.SetDisplayText(Value: Widestring);
begin
 if Assigned(FHyperLink) then FHyperLink.DisplayText := Value;
end;

function  TXLSHyperLink.GetRange: IXLSRange;
begin
 if Assigned(FHyperLink) then Result := IXLSRange(FHyperLink.Range)
                         else Result := nil;
end;

procedure TXLSHyperLink.SetRange(Value: IXLSRange);
begin
 if Assigned(FHyperLink) then FHyperLink.Range := Value;
end;

{TXLSHyperLinks}
constructor TXLSHyperLinks.Create(ARange: IXLSRange; AHyperLinks: TXLSCustomHyperLinks);
begin
  inherited Create;
  FRange := ARange;
  FHyperLinks := AHyperLinks;
end;

destructor  TXLSHyperLinks.Destroy; 
begin
  FRange := nil;
  inherited Destroy;
end;

function TXLSHyperLinks.GetCount: integer; 
begin
  if Assigned(FRange) then Result := FHyperlinks.GetCount(FRange)
                      else Result := FHyperlinks.Count;
end;

function TXLSHyperLinks.GetItem(Index:integer): IXLSHyperLink; 
begin
  if Assigned(FRange) then Result := TXLSHyperLink.Create(FHyperlinks.GetItem(FRange, Index))
                      else Result := TXLSHyperLink.Create(FHyperlinks[Index]);
end;

procedure TXLSHyperLinks.Delete;
begin
  if Assigned(FRange) then FHyperlinks.Delete(FRange)
                      else FHyperlinks.Delete;
end;

function TXLSHyperLinks.Add(Anchor: IXLSRange; Address:WideString; SubAddress: WideString=''; ScreenTip:WideString=''; TextToDisplay: Widestring=''): IXLSHyperlink; 
begin
  Result := TXLSHyperLink.Create(FHyperlinks.Add(Anchor, Address, SubAddress, ScreenTip, TextToDisplay));
end;


{TXLSName}
constructor TXLSName.Create(AName: TXLSCustomName);
begin
  inherited Create;
  FName := AName;
end;

destructor TXLSName.Destroy;
begin
  inherited Destroy;
end;

function TXLSName.GetName: WideString;
begin
  Result := FName.Name;
end;

function TXLSName.GetRefersTo: WideString;
begin
  Result := FName.GetRefersTo();
end;

procedure TXLSName.SetRefersTo(Value: Widestring);
begin
  FName.SetRefersTo(Value);
end;


function TXLSName.GetRefersToRange: IXLSRange;
var v: IInterface;
begin
   v := FName.GetRange();
   if Assigned(v) then Result := IXLSRange(v) else Result := nil;
end;

procedure TXLSName.SetName(Value: WideString);
begin
  FName.SetName(Value);
end;

function TXLSName.GetIndex: integer;
begin
  Result := FName.GetIndex();
end;

procedure TXLSName.Delete;
begin
  FName.Delete;
end;

function TXLSName.GetVisible: boolean;
begin
  Result := not(FName.IsHidden);
end;

procedure TXLSName.SetVisible(Value: boolean);
begin
  FName.IsHidden := not(Value);
end;


{TXLSNames}
constructor TXLSNames.Create(ANames: TXLSCustomNames);
begin
  inherited Create;
  FNames := ANames;
end;

destructor TXLSNames.Destroy; 
begin
  inherited Destroy;
end;

function TXLSNames.GetItem(Index: variant): IXLSName;
begin
  if VarIsNumeric(Index) then begin
     Result := GetItemByIndex(integer(Index));
  end else begin
     Result := GetItemByName(WideString(Index));
  end;
end;

function TXLSNames.GetItemByIndex(Index: integer): IXLSName;
Var name: TXLSCustomName; 
begin
  name := FNames.Item[Index];
  if Assigned(name) then begin
     Result := TXLSName.Create(name);
  end else begin
     Result := nil;
  end;
end;


function TXLSNames.GetItemByName(Name: WideString): IXLSName;
Var item: TXLSCustomName; 
begin
  item := FNames.GetItemByName(Name);
  if Assigned(item) then begin
     Result := TXLSName.Create(item);
  end else begin
     Result := nil;
  end;
end;


function TXLSNames.GetCount: integer;
begin
  Result := FNames.Count;
end;

function TXLSNames.Add(Name: WideString; RefersTo: WideString; Visible: boolean): IXLSName;
Var item: TXLSCustomName; 
begin
  item := FNames.Add(Name, RefersTo, Visible);
  if Assigned(item) then begin
     Result := TXLSName.Create(item);
  end else begin
     Result := nil;
  end;
end;

function TXLSNames.Add(Name: WideString; RefersTo: WideString): IXLSName;
begin
  Result := Add(Name, RefersTo, true);
end;



begin



end.
