//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         xlsescher
//
//
//      Description:  Excel Drawing Layer
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

unit xlsescher;
{$Q-}
{$R-}

interface

{$I xlsdef.inc}

//////////////////////////////// IMPORTANT ///////////////////////////////////////
//
//   PngImage
//
//   To be able to convert and compress BMP to PNG image, WMF and EMF to PNG
//   and optimization of palette ,
//   you have to install TPNGImage from http://pngdelphi.sourceforge.net/
//   If you want to use TPNGImage, rename the "{.$DEFINE USEPNGLIB}"
//   in xlsdef.inc to  "{$DEFINE USEPNGLIB}".
///////////////////////////////////////////////////////////////////////////////////

//Add Gamma Computer
uses
{$IFDEF D2012}
     Winapi.Windows, Vcl.Graphics, System.Classes,
{$ELSE}
     Windows,Graphics, Classes,
{$ENDIF}
     xlsblob, xlshash, xlsdrw , xlschart  , xlscalc
     {$IFDEF USEPNGLIB},PngImage{$ENDIF};

type

  _TTFBSEWMF = packed Record
 //  rgbUid:  array[0..15] of byte;  // Identifier of blip
    m_cb: LongWord;           // Cache of the metafile size
    m_rcBounds: TSmallRect;     // Boundary of metafile drawing commands
    m_ptSize: TPoint ;    // Array[0..1] of integer;       // Size of metafile in EMUs
    m_cbSave: LongWord;       // Cache of saved size (size of m_pvBits)
    m_fCompression: byte; // MSOBLIPCOMPRESSION
    m_fFilter: byte;      // always msofilterNone
    width : Double;
    height : Double;
    EmfRgbUid :  array[0..15] of byte;
    C_Stream : Tmemorystream;
  end;

 TMsoBlipType = ( msoblipERROR,   // An error occured during loading
                  msoblipUNKNOWN, // An unknown blip type
                  msoblipEMF,     // Windows Enhanced Metafile
                  msoblipWMF,     // Windows Metafile
                  msoblipPICT,    // Macintosh PICT
                  msoblipJPEG,    // JFIF
                  msoblipPNG,     // PNG
                  msoblipDIB);    // Windows DIB


 TMSOHeader = class
 private
   FRecordType: LongWord;
   FRecordLength: Longword;
   function GetVer: byte;
   function GetInst: word;
   function GetFbt: word;
   procedure SetVer(Value: byte);
   procedure SetInst(Value: word);
   procedure SetFbt(Value: word);
   function GetIsFolder: boolean;
 public
   constructor Create(DataList: TXLSBlobList; Var Offset: LongWord); overload;
   constructor Create(Header: TMSOHeader); overload;
   constructor Create(AVer: byte; AInst: word; AFbt: word; ALength: Longword); overload;
   function AddHeader(Data: TXLSBlob): integer;
   property Length: LongWord read FRecordLength write FRecordLength;
   property ver: byte read GetVer write SetVer;
   property inst: word read GetInst write SetInst;
   property fbt: word read GetFbt write SetFbt;
   property isFolder: boolean read GetIsFolder;
   procedure DebugOutput; overload;
   procedure DebugOutput(level: integer); overload;
 end;


 TMsoFbt = class
 private  
   FHeader: TMSOHeader;
   function GetSize: integer; virtual; abstract;
 public
   constructor Create;
   destructor Destroy; override;
   procedure SetHeader(AHeader: TMSOHeader);
   function AddData(Data: TXLSBlob): integer; virtual; abstract;
   function GetData: TXLSBlob; virtual;
   function ParseData(AHeader: TMSOHeader; Data: TXLSBlob): integer;
   function Parse(AHeader: TMSOHeader; DataList: TXLSBlobList; Offset: LongWord; DataLength: Longword): integer; virtual;
    
   property Size: integer read GetSize; 
 end;

 TMsoFbtUnknown = class(TMsoFbt)
 private
   FData: TXLSBlob;
   function GetSize: integer; override;  
 public
   function AddData(Data: TXLSBlob): integer; override;
   function Parse(AHeader: TMSOHeader; DataList: TXLSBlobList; Offset: LongWord; DataLength: Longword): integer;  override;   
   
   destructor Destroy; override; 
 end;

 TMsoFbtOptItem = class
 private
   FOption: Word;
   FValue: Longword;
   FExtraData: TXLSBlob; 
   function GetIsComplex: boolean;
   procedure SetIsComplex(AValue: boolean);
   function GetIsBlipID: boolean;
   procedure SetIsBlipID(AValue: boolean);
   function GetPid: Word;
   procedure SetPid(AValue: Word);
   function GetWideStringValue: WideString;
   procedure SetWideStringValue(AValue: WideString);
   function GetSize: integer;
   function ParseData(DataList: TXLSBlobList; Offset: LongWord): integer;
   function ParseExtraData(DataList: TXLSBlobList; Offset: LongWord): integer;
   
 public
   destructor Destroy; override;
   procedure AddData(Data: TXLSBlob);
   procedure AddExtraData(Data: TXLSBlob);
   property Pid: Word read GetPid write SetPid;
   property isComplex: boolean read GetIsComplex write SetIsComplex;
   property isBlipID: boolean read GetIsBlipID write SetIsBlipID; 
   property Value: Longword read FValue write FValue;
   property WideStringValue: WideString read GetWideStringValue write SetWideStringValue;
   property Size: integer read GetSize;
 end;

 TWordArray = array of word;

 TMsoFbtOpt = class(TMsoFbt)
 private
   FFbt: word;
   FArr: TObjectArray;
   function GetIsDefined(Pid: Word): boolean;
   function GetSize: integer; override;
   function GetItem(Pid: Word): TMsoFbtOptItem;
   procedure SetItem(Pid: Word; Value: TMsoFbtOptItem);
   function GetCount: integer;
   function GetSortedKeys: TWordArray;
   function GetLongValue(Pid: Word): Longword;
   procedure SetLongValue(Pid: Word; Value: Longword);
   function GetWideStringValue(Pid: Word): WideString;
   procedure SetWideStringValue(Pid: Word; Value: WideString);
   procedure Clear;
   
 public
   constructor Create;
   destructor Destroy; override;
   function AddData(Data: TXLSBlob): integer; override;
   procedure DeleteItem(Pid: Word);   
   function Parse(AHeader: TMSOHeader; DataList: TXLSBlobList; Offset: LongWord; DataLength: Longword): integer; override;
   function DumpData: integer;
   
   property isDefined[Pid: Word]: boolean read GetIsDefined;
   property Item[Pid: Word]: TMsoFbtOptItem read GetItem write SetItem; default;
   property WideStringValue[Pid: Word]: WideString read GetWideStringValue write SetWideStringValue;
   property LongValue[Pid: Word]: LongWord read GetLongValue write SetLongValue;
   property Count: integer read GetCount;
 end;

 TMsoDrawing = class;

 TMsoFbtDGGItem = class  
 private
   FDgId: longword;
   FSpidCur: longword;
 public 
   constructor Create(ADgId: Word);
   function Parse(Data: TXLSBlob; Offset: LongWord): integer;
   
   function AddData(Data: TXLSBlob): integer;
   property DgId: longword read FDgId write FDgId;
   property SpidCur: longword read FSpidCur write FSpidCur;
 end;

 TMsoFbtDGGList = class(TList)
 private
   function GetSize: integer; 
   function GetItem(Index: integer): TMsoFbtDGGItem;
 public 
   destructor Destroy; override;
   function AddData(Data: TXLSBlob): integer;
   function Parse(DataList: TXLSBlobList; Offset: LongWord; DataLength: Longword): integer;
   
   property Size: integer read GetSize; 
   property Entries[Index: integer]: TMsoFbtDGGItem read GetItem; default;
 end;

 TMsoFbtDGG = class(TMsoFbt)
 private
   FList: TMsoFbtDGGList;
   FSpidMax: longword;  // The current maximum shape ID
   FSpSaved: longword;  // The total number of shapes saved
                        // (including deleted shapes, if undo
                        // information was saved)

   FDgSaved: longword;  // The total number of drawings saved
   FCurDrawingID: word;
   function GetSize: integer; override;
   function GetCount: integer;
   procedure RemoveDrawing(FDrawingID: Word);
   function  FindDggItem(ADrawingId: word): integer;
   procedure PrepareStore;
   procedure RegisterSavedShapeID(AShapeID: longword);
 public
   constructor Create;
   destructor Destroy; override;  
   function AddData(Data: TXLSBlob): integer; override;
   function Parse(AHeader: TMSOHeader; DataList: TXLSBlobList; Offset: LongWord; DataLength: Longword): integer; override;
   
   property Count: integer read GetCount;
   function RegisterDrawing(Var ADrawingId: word): integer;
   function GetShapeId(ADrawingId: word): longword;
 end;

 TMsoFbtClientAnchor = class(TMsoFbt)
 private
   FOption: word;
   FCol1, FCol1Offs: word;
   FRow1, FRow1Offs: word;
   FCol2, FCol2Offs: word;
   FRow2, FRow2Offs: word;
   function GetSize: integer; override;
 public
   constructor Create; overload;
   constructor Create(Data: TXLSBlob); overload;
   
   destructor Destroy; override;  
   function ParseData(AData: TXLSBlob): integer;
   
   function AddData(Data: TXLSBlob): integer; override;
   procedure SetClientAnchor(ARow1, ARow1Offs, ACol1, ACol1Offs, ARow2, ARow2Offs, ACol2, ACol2Offs: Word);
   property Col1: word read FCol1 write FCol1;
   property Col2: word read FCol2 write FCol2;
   property Row1: word read FRow1 write FRow1;
   property Row2: word read FRow2 write FRow2;
   property Col1Offs: word read FCol1Offs write FCol1Offs;
   property Col2Offs: word read FCol2Offs write FCol2Offs;
   property Row1Offs: word read FRow1Offs write FRow1Offs;
   property Row2Offs: word read FRow2Offs write FRow2Offs; 
   property Option: word read FOption write FOption;
 end;

 TMsoFbtSp = class(TMsoFbt)
 private
   FVer: byte;
   FShapeType: Word;
   FPersistent: Longword;
   FShapeID: Longword;
   function GetSize: integer; override;
 public
   constructor Create(AVer: byte; AShapeType: Word; APErsistent: longword); overload;
   constructor Create(Header: TMSOHeader; Data: TXLSBlob); overload;
   destructor Destroy; override;  
   function AddData(Data: TXLSBlob): integer; override;
   property ShapeType: Word read FShapeType;
   property ShapeId: Longword read FShapeID write FShapeID;
 end;


 TObjFormula = class
 private
   FRecID: integer;
   FData: TXLSBlob;
   FCompiledFormula: TXLSCompiledFormula; 
 public
   constructor Create;
   destructor Destroy; override;
   function ParseObj(RecID: word; var RecLen: word; Data: TXLSBlob; offset: integer; FDrawing: TMSODrawing): integer;
   function GetData(FDrawing: TMSODrawing): TXLSBlob;
 end;

 TMsoShapeContainer = class
 private
   FSp: TMsoFbtSp;
   FOpt: TMsoFbtOpt;

   FTertiaryOpt: TMsoFbtOpt;
   FClientAnchor: TMsoFbtClientAnchor;

   FObjRecftPictFrmla: TObjFormula;

   FObjectID: word;
   FObjectType: word;
   FObjectOptions: word;
   {!!!}
   FWidth: Double;
   FHeight: Double;
   FDrawing: TMSODrawing;

   function GetDgSize: integer; virtual;
   function GetDataSize: integer; virtual;
   function GetOpt: TMsoFbtOpt;
   function GetTertiaryOpt: TMsoFbtOpt;
   function GetClientAnchor: TMsoFbtClientAnchor;
   procedure Flush(Data: TXLSBlob; DataList: TXLSBlobList);
   function ParseObj(Data: TXLSBlob): integer; virtual;
   
   function GetVisible: boolean; virtual;
   procedure SetVisible(Value: boolean); virtual;
 public
   constructor Create(ADrawing: TMSODrawing; AVer: byte; AShapeType: Word; APersistent: longword); overload;
   constructor Create(ADrawing: TMSODrawing; Header: TMSOHeader; ShapeData: TXLSBlob); overload;
   constructor Create(ShapeContainer: TMsoShapeContainer); overload;
   procedure Assign(ShapeContainer: TMsoShapeContainer);
   procedure Move(drow, dcol: integer);
   function GetCustomColor(ColorIndex: integer): Longword;
   Destructor Destroy; override;
   function Store(Data: TXLSBlob; DataList: TXLSBlobList; AEncrypt: boolean): integer; virtual;
   property Sp: TMsoFbtSp read FSp;
   property Opt: TMsoFbtOpt read GetOpt;
   property TertiaryOpt: TMsoFbtOpt read GetTertiaryOpt;
   property ClientAnchor: TMsoFbtClientAnchor read GetClientAnchor;
   property Size: integer read GetDgSize;
   property ObjectID: word read FObjectID write FObjectID;
   property ObjectType: word read FObjectType write FObjectType;
   property ObjectOptions: word read FObjectOptions write FObjectOptions;
   property Width: double read FWidth write FWidth;
   property Height: double read FHeight write FHeight;
   property Visible: boolean read GetVisible write SetVisible;
 end;



 TMSOShapeHostControl = class (TMSOShapeContainer)
 private
 public
 end;

 TMSOShapeChart = class (TMSOShapeHostControl)
 private
    FChart: TXLSCustomChart;
    function    AddObj(Data: TXLSBlob; ObjType, ObjId, Options: word): integer;
 public
    constructor Create(HostControl: TMSOShapeHostControl);
    destructor  Destroy; override;
    function    Store(Data: TXLSBlob; DataList: TXLSBlobList; AEncrypt: boolean): integer; override;
    function    SetChartData(Value: TXLSCustomChart): integer;
 end;


 TMSOShapeCheckBox = class (TMSOShapeHostControl)
 private
    FText: Widestring;
    function AddObj(Data: TXLSBlob; ObjType, ObjId, Options: word): integer;
    function GetDgSize: integer; override;
 public
    constructor Create(HostControl: TMSOShapeHostControl);
    function ParseTXO(DataList: TXLSBlobList): integer;
    function Store(Data: TXLSBlob; DataList: TXLSBlobList; AEncrypt: boolean): integer; override;
    property Text: Widestring read FText write FText;
 end;

 TMSOShapePicture = class (TMSOShapeHostControl)
 private
    FText: Widestring;

    ftCfValue: integer;
    ftPioGrbit: integer;

    function AddObj(Data: TXLSBlob; ObjType, ObjId, Options: word): integer;
    function GetDgSize: integer; override;
 public
    constructor Create(HostControl: TMSOShapeHostControl);
    function ParseObj(Data: TXLSBlob): integer; override;
    function ParseTXO(DataList: TXLSBlobList): integer;
    function Store(Data: TXLSBlob; DataList: TXLSBlobList; AEncrypt: boolean): integer; override;
    property Text: Widestring read FText write FText;
    Destructor Destroy; override;
 end;


 


 TMSOShapeComboBox = class (TMSOShapeHostControl)
 private

    FIsAutofilter: boolean;
    FRow: integer;
    FCol: integer;

    FObjRec_SBS: TXLSBlob;  
    FObjRec_SBSFrmla: TXLSBlob;  
    FObjRec_LBSData: TXLSBlob;  
    FLBSFormula: TXLSCompiledFormula; 

    function AddObj(Data: TXLSBlob; ObjType, ObjId, Options: word): integer;
    function GetDgSize: integer; override;
    procedure SetDefault(ARow, ACol: integer);
 public
    constructor Create(HostControl: TMSOShapeHostControl); overload;
    constructor Create(ADrawing: TMSODrawing; ARow, ACol: integer; AIsAutofilter: boolean); overload;
    Destructor Destroy; override;

    function ParseObj(Data: TXLSBlob): integer; override;
    
    function Store(Data: TXLSBlob; DataList: TXLSBlobList; AEncrypt: boolean): integer; override;
    property IsAutofilter: boolean read FIsAutofilter;

    property Row: integer read FRow;
    property Col: integer read FCol;
 end;


 TMSOShapeListBox = class (TMSOShapeHostControl)
 private

    FRow: integer;
    FCol: integer;

    FObjRec_SBS: TXLSBlob;  
    FObjRec_SBSFrmla: TXLSBlob;  
    FObjRec_LBSData: TXLSBlob;  
    FLBSFormula: TXLSCompiledFormula; 

    function AddObj(Data: TXLSBlob; ObjType, ObjId, Options: word): integer;
    function GetDgSize: integer; override;
    procedure SetDefault(ARow, ACol: integer);
 public
    constructor Create(HostControl: TMSOShapeHostControl); overload;
    constructor Create(ADrawing: TMSODrawing; ARow, ACol: integer); overload;
    Destructor Destroy; override;

    function ParseObj(Data: TXLSBlob): integer; override;
    
    function Store(Data: TXLSBlob; DataList: TXLSBlobList; AEncrypt: boolean): integer; override;

    property Row: integer read FRow;
    property Col: integer read FCol;
 end;


 TMSOShapeTextBox = class (TMSOShapeContainer)
 private
   FText: Widestring;
   FRow: Word;
   FCol: Word;
   FOptions: Word;
   {!!!!}FAuthor: WideString;
   function GetDgSize: integer; override;
   function GetDataSize: integer; override;
   function AddObj(Data: TXLSBlob; ObjType, ObjId, Options: word): integer;
   procedure SetDefault(ARow, ACol: integer);
   function GetVisible: boolean; override;
   procedure SetVisible(Value: boolean); override;
 public
   function ParseTXO(DataList: TXLSBlobList; ADecrypt: boolean): integer;
   
   function Store(Data: TXLSBlob; DataList: TXLSBlobList; AEncrypt: boolean): integer; override;
   function SetNoteData(ARow, ACol: Word; AOptions: Word; AAuthor: WideString): integer;
   property Text: Widestring read FText write FText;
   property Row: Word read FRow write FRow;
   property Col: Word read FCol write FCol;
 end;


 TMSOPicture = class
 private
   FData: TXLSBlob;   
   FPictureType: TMsoBlipType;  
   FRefCount: Longword;
   FHash: TXLSBlob;
   FBlipID: LongWord;
   FBlipName: WideString;
   FFileName: AnsiString;        // -----> GC
   FBSEWMF: _TTFBSEWMF;      // -----> GC

   procedure CalcHash;
   function GetSize: integer;
   function GetBlipInst: Word;
   function GetHashKey: String;
   function ExtToPictureType(Ext: WideString): TMsoBlipType;
 public
   constructor Create;
   destructor Destroy; override;
   function LoadFromFile(AFileName: WideString): integer;
   function LoadFromFileBMP(Bitmap: TBitmap): integer;   // -----> GC
   property Data: TXLSBlob read FData;
   property PictureType: TMsoBlipType read FPictureType;
   property BlipID: LongWord read FBlipID write FBlipID;
   function Parse(AHeader: TMSOHeader; DataList: TXLSBlobList; Offset: LongWord): integer;
   
   property Filename: AnsiString read FFileName ;       // -----> GC  non usato
   property BSEWMF: _TTFBSEWMF read FBSEWMF ;       // -----> GC
   function SaveAs(Fname: String): integer;
   property Size: integer read GetSize;
   property RefCount: LongWord read FRefCount;
   function GetData: TXLSBlob;
   property HashKey: String read GetHashKey;
 end;

 TMSOShapePictureFrame = class (TMSOShapeContainer)
 private
   //FObjRecftPictFrmla: TXLSBlob;
   ftCfValue: integer;
   ftPioGrbit: integer;
   function GetDgSize: integer; override;
   function GetDataSize: integer; override;
   function GetPictureId: integer;
   procedure SetPictureId(Value: integer);
   function AddObj(Data: TXLSBlob; ObjType, ObjId, Options: word): integer;
   procedure SetDefault(ARow, ACol: integer);
   function GetVisible: boolean; override;
   procedure SetVisible(Value: boolean); override;
   procedure SetTransparentColor(Value: Longword);        // -----> GC
   function  GetTransparentColor: Longword;        // -----> GC
   function GetTransparentColorDefined: boolean;
   function ParseObj(Data: TXLSBlob): integer; override;
   
 public
   constructor Create(ADrawing: TMSODrawing; AVer: byte; AShapeType: Word; APersistent: longword); overload;
   constructor Create(ADrawing: TMSODrawing; Header: TMSOHeader; ShapeData: TXLSBlob); overload;
   function Store(Data: TXLSBlob; DataList: TXLSBlobList; AEncrypt: boolean): integer; override;
   property PictureId: integer read GetPictureId write SetPictureID;
   property TransparentColor: Longword read GetTransparentColor write SetTransparentColor;
   property TransparentColorDefined: boolean read GetTransparentColorDefined;
   procedure ClearTransparentColor;
   function GetPicture: TMSOPicture;
   Destructor Destroy; override;
 end;

 TMSOPictureList = class(TList)
 private
   FCurBlipID: integer; 
   FPicturesHash: THashObject;
   function GetPicture(Index: integer): TMSOPicture;
   function GetSize: integer;
   function Add(Item: Pointer): integer; 
 public
    constructor Create;
    destructor Destroy; override;
    function LoadFromFileBmp(Bitmap: TBitmap): TMSOPicture;   // -----> GC
    function LoadFromFile(AFileName: WideString): TMSOPicture;   
    property Item[Index: integer]: TMSOPicture read GetPicture; default;
   function Parse(DataList: TXLSBlobList; Offset: LongWord; DataLength: Longword): integer;
    
    property Size: integer read GetSize;
 end;

 TMSODrawingGroup = class
 private
   FOpt: TMsoFbtOpt;
   FDgg: TMsoFbtDgg;
   FPictures: TMSOPictureList;
   FSplitMenuColors: TMsoFbtUnknown;

   function GetOpt: TMsoFbtOpt;
   function GetSize: integer;
   procedure RemoveDrawing(FDrawingID: Word);
  
 public
   constructor Create;
   destructor Destroy; override;
   procedure Clear;
   function Parse(DataList: TXLSBlobList): integer;
    
   function Store(DataList: TXLSBlobList; BiffRecSize: integer): integer;
   procedure PrepareStore;

   property Opt: TMsoFbtOpt read GetOpt;
   property Dgg: TMsoFbtDgg read FDgg;
   property Pictures: TMSOPictureList read FPictures;
   property Size: integer read GetSize;
 end;

TXLSDrawingParserItem = class
 private
   FParent: TXLSDrawingParserItem;
   FHeader: TMSOHeader;
   FData:   TXLSBlob;
   FLength: integer;
   FCurLength: integer;
   FChildCount: integer;
   FLevel: integer;
   FChild: array of TXLSDrawingParserItem;
   FSkip: boolean;
   function GetChild(Index: integer): TXLSDrawingParserItem;
 public
   constructor Create(AParent: TXLSDrawingParserItem; AHeader: TMSOHeader);
   destructor Destroy; override;
   function AddChild(AHeader: TMSOHeader): TXLSDrawingParserItem;
   procedure InitData;
   property ChildCount: integer read FChildCount;
   property Child[Index: integer]: TXLSDrawingParserItem read GetChild;
   property Length: integer read FLength;
   property CurLength: integer read FCurLength write FCurLength;
   property Level: integer read FLevel;
   property Parent: TXLSDrawingParserItem read FParent;
   property Header: TMSOHeader read FHeader;
   property Data: TXLSBlob read FData;
 end;


TOnStartParseItem = procedure (Sender: TObject; Header: TMSOHeader;
                                isContainer: boolean; Var Skip: boolean) of object;

 TOnParseItem = procedure (Sender: TObject; Header: TMSOHeader;
                           Data: TXLSBlob) of object;

 TOnEndParseItem = procedure (Sender: TObject; Header: TMSOHeader;
                              isContainer: boolean) of object;

 TOnEndParse     = procedure (Sender: TObject) of object;


TXLSDrawingParser = class
 private
   FLength: integer;
   FRoot: TXLSDrawingParserItem;
   FCurrentNode: TXLSDrawingParserItem;
   FOnStartParseItem: TOnStartParseItem;
   FOnParseItem:      TOnParseItem;
   FOnEndParseItem:   TOnEndParseItem;
   FOnEndParse:       TOnEndParse;
   procedure ParseNode(DataList: TXLSBlobList; Var Offset: longword);
 public
   constructor Create;
   destructor Destroy; override;
   procedure Parse(DataList: TXLSBlobList); overload;
   procedure Parse(DataList: TXLSBlobList; StartIndex: integer); overload;
   property OnStartParseItem: TOnStartParseItem read FOnStartParseItem write FOnStartParseItem;
   property OnParseItem:      TOnParseItem      read FOnParseItem      write FOnParseItem;
   property OnEndParseItem:   TOnEndParseItem   read FOnEndParseItem   write FOnEndParseItem;
   property OnEndParse:       TOnEndParse       read FOnEndParse       write FOnEndParse;
 end;


TParserState = (psNone, 
                  psDgContainer, 
                    psDg, 
                    psSpGrContainer, psSpContainer, 
                 psSp, psSpOpt,psSpTertiaryOpt, psClientAnchor);


 TGetShapeRect = procedure (Row, Col: Word; Height, Width: Double; 
                            Var Row1, Row1Offset, Row2, Row2Offset,
                                Col1, Col1Offset, Col2, Col2Offset: Word) of object;

 TGetShapeRect2 = procedure (Row1, Row1Offset, Col1, Col1Offset: Word; Height, Width: Double; 
                         Var Row2, Row2Offset, Col2, Col2Offset: Word) of object;

 TGetCurRowCol = procedure (Var Row, Col: Word) of object;

 TGetShapeSize = procedure (Row1, Row1Offset, Row2, Row2Offset,
                            Col1, Col1Offset, Col2, Col2Offset: Word;
                            Var Width, Height: Double) of object;
 TGetCustomColor = function (ColorIndex: integer): LongWord of object;

 TSetAutofilterShape = procedure (ARow, ACol: integer; Shape: TObject) of object;

 TMsoShapeList = class(TList)
 private
   FGetShapeRect: TGetShapeRect;
   FGetShapeRect2: TGetShapeRect2;
   FShapeByObjID: TObjectArray;
   function GetItem(Index: integer): TMsoShapeContainer;
   function GetSize: integer;
 public
   constructor Create(AGetShapeRect: TGetShapeRect; AGetShapeRect2: TGetShapeRect2);
   destructor Destroy; override;
   procedure AddItem(Item: TMsoShapeContainer); 
   procedure DeleteShape(Item: TMsoShapeContainer);
   function Store(Data: TXLSBlob; DataList: TXLSBlobList; AEncrypt: boolean): integer;
   property Items[Index: integer]: TMsoShapeContainer read GetItem; default;
   property ShapeByObjId: TObjectArray read FShapeByObjId;
   property Size: integer read GetSize;
  
 end;

 TMSODrawing = class
 private
   FDrawingGroup: TMSODrawingGroup;
   FDrawingId: word;
   FCurObjectId: integer; 
   FCurShapeID: integer;
   //!!!
   FFirstShapeID: integer;
   FSheetID: integer;
   FParser: TXLSDrawingParser;
   FParserState: TParserState;
   

   FShapeList: TMsoShapeList;

   FCurParseShape: TMsoShapeContainer;
   

   FComments: TXLSComments;
   FPictures: TXLSShapes;

   FGetShapeRect:   TGetShapeRect;
   FGetShapeRect2:  TGetShapeRect2;
   FGetCurRowCol:   TGetCurRowCol;
   FGetShapeSize:   TGetShapeSize;
   FGetCustomColor: TGetCustomColor; 
   FSetAutofilterShape: TSetAutofilterShape;

   FCalculator: TXLSCalculator;

   procedure OnStartParseItem(Sender: TObject; Header: TMSOHeader; isContainer: boolean; Var Skip: boolean);
   procedure OnParseItem(Sender: TObject; Header: TMSOHeader; Data: TXLSBlob);
   procedure OnEndParseItem(Sender: TObject; Header: TMSOHeader; isContainer: boolean);
   procedure OnEndParse(Sender: TObject);
   procedure InitParser;
   
   function  AddDg(Data: TXLSBlob): integer;
   function  GetRootSize: integer;
   function  GetSize: integer;
 public
   constructor Create(ADrawingGroup: TMSODrawingGroup; AGetShapeRect: TGetShapeRect;
                      AGetShapeSize: TGetShapeSize;
                      AGetShapeRect2: TGetShapeRect2;
                      AGetCurRowCol: TGetCurRowCol;
                      AGetCustomColor: TGetCustomColor;
                      ASetAutofilterShape: TSetAutofilterShape;
                      ACalculator: TXLSCalculator;
                      ASheetID: integer);
   destructor Destroy; override; 
   function GetCustomColor(ColorIndex: integer): LongWord;
   function GetNewObjectID: integer;
   procedure UpdateCurObjectID(Value: integer);
   function Parse(DataList: TXLSBlobList): integer; overload;
   function Parse(DataList: TXLSBlobList; StartIndex: integer): integer; overload;
   function ParseObj(DataList: TXLSBlobList): integer;
   function ParseTXO(DataList: TXLSBlobList; ADecrypt: boolean): integer;
   function FinalizeParse: integer;
   function SetChartData(ChartData: TXLSCustomChart): integer;
   
   function Store(DataList: TXLSBlobList; BiffRecSize: integer; AEncrypt: boolean): integer;
   function StoreNotes(DataList: TXLSBlobList; ABiffVersion: word): integer;
   function SetNoteData(AObjId: Word; ARow, ACol: Word; AOptions: Word; AAuthor: WideString): integer;
   function GetNewShapeId: longword;
   function AddComment(ARow, ACol: integer): TMSOShapeTextBox;
   function AddAutofilterShape(ARow, ACol: integer): TMSOShapeComboBox;

   function AddPicture(AFileName: WideString): TMSOShapePictureFrame; overload;
   function AddPicture(Bitmap: TBitmap): TMSOShapePictureFrame; overload;

   procedure DeleteShape(Item: TMsoShapeContainer);
   procedure PrepareStore;
   property DrawingGroup: TMSODrawingGroup read FDrawingGroup;
   property Shapes: TMsoShapeList read FShapeList;
   property Size: integer read GetSize;
   property Comments: TXLSComments read FComments;
   property Pictures: TXLSShapes read FPictures;
 end;



 MSOFO = Longword;

// FBSE - File Blip Store Entry
 TFBSE = packed record
   btWin32: TMsoBlipType;    // Required type on Win32
   btMacOS: TMsoBlipType;    // Required type on Mac
   rgbUid:  array[0..15] of byte;  // Identifier of blip
   tag:     word;        // currently unused
   size:    Longword;    // Blip size in stream
   cRef:    Longword;    // Reference count on the blip
   foDelay: MSOFO;       // File offset in the delay stream
   usage:   byte;        // How this blip is used (MSOBLIPUSAGE)
   cbName:  byte;        // length of the blip name
   unused2: byte;        // for the future
   unused3: byte;        // for the future
 end;

 TXLSFBSE = class
 private
   FFBSE: TFBSE;
   FPictureName: String;       // -----> GC
   function GetNameLength: byte;
   procedure SetNameLength(Value: byte);
   function GetPictureType: TMsoBlipType;
   procedure SetPictureType(Value: TMsoBlipType);
   function GetRefCount: longword;
   procedure SetRefCount(Value: longword);
   function GetSize: longword;
   procedure SetSize(Value: longword);
   function GetDataSize: longword;
   procedure SetPictureName(Value: String);       // -----> GC
   function GetPictureName: String;               // -----> GC
 public
   constructor Create;
   function Parse(DataList: TXLSBlobList; Var Offset: LongWord; DataLength: Longword): integer;
   
   procedure SetHash(Value: TXLSBlob);
   property NameLength: byte read GetNameLength write SetNameLength;
   property PictureType: TMsoBlipType read GetPictureType write SetPictureType;
   property RefCount: longword read GetRefCount write SetRefCount;
   property Size: longword read GetSize write SetSize;
   function AddData(Data: TXLSBlob): integer;
   property DataSize: longword read GetDataSize;
   property PictureName: string read GetPictureName write SetPictureName;  // -----> GC
 end;

{
function ParseMSODrawingGroup(DataList: TXLSBlobList): integer;
}


implementation


uses xlsdrwtp, xlsmd4, xlsimg{$IFDEF OPEN_EMFWMF}, xlsemf{$ENDIF}, wstream,
{$IFDEF D2012}
     System.SysUtils;
{$ELSE}
     SysUtils;
{$ENDIF}

const
  msoHeaderSize         = 8;    

  msofbtDggContainer    = $F000;
  msofbtBstoreContainer = $F001;
  msofbtDgContainer     = $F002;
  msofbtSpgrContainer   = $F003; 
  msofbtSpContainer     = $F004; 
  msofbtDgg             = $F006;
  msofbtBSE             = $F007; 
  msofbtDg              = $F008;
  msofbtSpgr            = $F009; 
  msofbtSp              = $F00A; 
  msofbtOpt             = $F00B;
  msofbtClientTextbox   = $F00D;
  msofbtClientAnchor    = $F010; 
  msofbtClientData      = $F011; 
  msofbtBlipFirst       = $F018;
  msofbtBlipLast        = $F117;
  msofbtTertiaryOpt     = $F122;

const
  msosptNotPrimitive    = 0;
  msosptPictureFrame    = 75;
  msosptTextBox         = 202;
  msosptHostControl     = $0C9;

const
   spoGroup             = $00000001;
   spoPatriarch         = $00000004;

const
   ShapeIDBlockSize     = $400;  

const
   spoHaveAnchor      = $00000200;
   spoHaveSpt         = $00000800;

type 

 TXLSBiffWriter = class
 private
   FDstList: TXLSBlobList;
   FTotalLength: integer;
   FRestLength: integer;
   FBiffRecSize: integer;
   FRestRecSize: integer;
   FData: TXLSBlob;
 public
   Constructor Create(DstList: TXLSBlobList; BiffRecSize: integer);
   procedure StartNewBiff(RecID: word; RecLength: integer);
   procedure AddData(Data: TXLSBlob);
   procedure Flush;
 end;

procedure DataEncrypt(Data: TXLSBlob);
  var i, cnt: integer;
      b: byte;
begin
   cnt := Data.DataLength;
   if cnt > 4 then begin
      for i := 4 to cnt - 1 do begin
          b := Data.GetByte(i);
          b := ((b and 7) shl 5) or (b shr 3);
          Data.SetByte(b, i);   
      end;
   end;
end;

procedure DataDecrypt(Data: TXLSBlob);
  var i, cnt: integer;
      b: byte;
begin
   cnt := Data.DataLength;
   for i := 0 to cnt - 1 do begin
       b := Data.GetByte(i);
       b :=  (b shr 5) or (b shl 3);
       Data.SetByte(b, i);   
   end;
end;
 

function AddHeader(Data: TXLSBlob; AVer: byte; AInst: word; AFbt: word; ALength: Longword): integer;
Var Header: TMSOHeader;
begin
  Header := TMSOHeader.Create(AVer, AInst, AFbt, ALength);
  Header.AddHeader(Data);
  Header.Free; 
  Result := 1;
end;

{
function parsemsodrawinggroup(DataList: TXLSBlobList): integer;
Var MSODrawingGroup: TMSODrawingGroup;
    i: integer;
begin
  MSODrawingGroup := TMSODrawingGroup.Create;
  MSODrawingGroup.Parse(DataList);
  for i := 0 to MSODrawingGroup.Pictures.Count - 1 do begin
    MSODrawingGroup.Pictures[i].SaveAs('Picture' + inttostr(i+1) + '.jpg'); 
  end;
    
  MSODrawingGroup.Free;
  Result := 1;
end;
}

function min(v1, v2: integer): integer;
begin
  if v1 > v2 then Result := v2 else Result := v1;
end;


function FBTCodeToName(fbt: word): string;
begin
  case fbt of
    $F000: Result := 'msofbtDggContainer';
    $F001: Result := 'msofbtBstoreContainer';
    $F002: Result := 'msofbtDgContainer';
    $F003: Result := 'msofbtSpgrContainer';
    $F004: Result := 'msofbtSpContainer';
    $F005: Result := 'msofbtSolverContainer';
    $F006: Result := 'msofbtDgg';
    $F007: Result := 'msofbtBSE';
    $F008: Result := 'msofbtDg';
    $F009: Result := 'msofbtSpgr';
    $F00A: Result := 'msofbtSp';
    $F00B: Result := 'msofbtOPT';
    $F00C: Result := 'msofbtTextbox';
    $F00D: Result := 'msofbtClientTextbox';
    $F11E: Result := 'msofbtSplitMenuColors';
    $F010: Result := 'msofbtClientAnchor';
    $F011: Result := 'msofbtClientData';
    else Result := 'Unknown'
  end;
end;

function ShapeIDToShapeName(inst: integer): string;
begin
  case inst of
      0:  Result := 'msosptNotPrimitive';
      1:  Result := 'msosptRectangle';
      2:  Result := 'msosptRoundRectangle';
      3:  Result := 'msosptEllipse';
      4:  Result := 'msosptDiamond';
      5:  Result := 'msosptIsocelesTriangle';
      6:  Result := 'msosptRightTriangle';
      7:  Result := 'msosptParallelogram';
      8:  Result := 'msosptTrapezoid';
      9:  Result := 'msosptHexagon';
      10: Result := 'msosptOctagon';
      11: Result := 'msosptPlus';
      12: Result := 'msosptStar';
      13: Result := 'msosptArrow';
      14: Result := 'msosptThickArrow';
      15: Result := 'msosptHomePlate';
      16: Result := 'msosptCube';
      17: Result := 'msosptBalloon';
      18: Result := 'msosptSeal';
      19: Result := 'msosptArc';
      20: Result := 'msosptLine';
      21: Result := 'msosptPlaque';
      22: Result := 'msosptCan';
      23: Result := 'msosptDonut';
      24: Result := 'msosptTextSimple';
      25: Result := 'msosptTextOctagon';
      26: Result := 'msosptTextHexagon';
      27: Result := 'msosptTextCurve';
      28: Result := 'msosptTextWave';
      29: Result := 'msosptTextRing';
      30: Result := 'msosptTextOnCurve';
      31: Result := 'msosptTextOnRing';
      32: Result := 'msosptStraightConnector1';
      33: Result := 'msosptBentConnector2';
      34: Result := 'msosptBentConnector3';
      35: Result := 'msosptBentConnector4';
      36: Result := 'msosptBentConnector5';
      37: Result := 'msosptCurvedConnector2';
      38: Result := 'msosptCurvedConnector3';
      39: Result := 'msosptCurvedConnector4';
      40: Result := 'msosptCurvedConnector5';
      41: Result := 'msosptCallout1';
      42: Result := 'msosptCallout2';
      43: Result := 'msosptCallout3';
      44: Result := 'msosptAccentCallout1';
      45: Result := 'msosptAccentCallout2';
      46: Result := 'msosptAccentCallout3';
      47: Result := 'msosptBorderCallout1';
      48: Result := 'msosptBorderCallout2';
      49: Result := 'msosptBorderCallout3';
      50: Result := 'msosptAccentBorderCallout1';
      51: Result := 'msosptAccentBorderCallout2';
      52: Result := 'msosptAccentBorderCallout3';
      53: Result := 'msosptRibbon';
      54: Result := 'msosptRibbon2';
      55: Result := 'msosptChevron';
      56: Result := 'msosptPentagon';
      57: Result := 'msosptNoSmoking';
      58: Result := 'msosptSeal8';
      59: Result := 'msosptSeal16';
      60: Result := 'msosptSeal32';
      61: Result := 'msosptWedgeRectCallout';
      62: Result := 'msosptWedgeRRectCallout';
      63: Result := 'msosptWedgeEllipseCallout';
      64: Result := 'msosptWave';
      65: Result := 'msosptFoldedCorner';
      66: Result := 'msosptLeftArrow';
      67: Result := 'msosptDownArrow';
      68: Result := 'msosptUpArrow';
      69: Result := 'msosptLeftRightArrow';
      70: Result := 'msosptUpDownArrow';
      71: Result := 'msosptIrregularSeal1';
      72: Result := 'msosptIrregularSeal2';
      73: Result := 'msosptLightningBolt';
      74: Result := 'msosptHeart';
      75: Result := 'msosptPictureFrame';
      76: Result := 'msosptQuadArrow';
      77: Result := 'msosptLeftArrowCallout';
      78: Result := 'msosptRightArrowCallout';
      79: Result := 'msosptUpArrowCallout';
      80: Result := 'msosptDownArrowCallout';
      81: Result := 'msosptLeftRightArrowCallout';
      82: Result := 'msosptUpDownArrowCallout';
      83: Result := 'msosptQuadArrowCallout';
      84: Result := 'msosptBevel';
      85: Result := 'msosptLeftBracket';
      86: Result := 'msosptRightBracket';
      87: Result := 'msosptLeftBrace';
      88: Result := 'msosptRightBrace';
      89: Result := 'msosptLeftUpArrow';
      90: Result := 'msosptBentUpArrow';
      91: Result := 'msosptBentArrow';
      92: Result := 'msosptSeal24';
      93: Result := 'msosptStripedRightArrow';
      94: Result := 'msosptNotchedRightArrow';
      95: Result := 'msosptBlockArc';
      96: Result := 'msosptSmileyFace';
      97: Result := 'msosptVerticalScroll';
      98: Result := 'msosptHorizontalScroll';
      99: Result := 'msosptCircularArrow';
      100:Result := 'msosptNotchedCircularArrow';
      101:Result := 'msosptUturnArrow';
      102:Result := 'msosptCurvedRightArrow';
      103:Result := 'msosptCurvedLeftArrow';
      104:Result := 'msosptCurvedUpArrow';
      105:Result := 'msosptCurvedDownArrow';
      106:Result := 'msosptCloudCallout';
      107:Result := 'msosptEllipseRibbon';
      108:Result := 'msosptEllipseRibbon2';
      109:Result := 'msosptFlowChartProcess';
      110:Result := 'msosptFlowChartDecision';
      111:Result := 'msosptFlowChartInputOutput';
      112:Result := 'msosptFlowChartPredefinedProcess';
      113:Result := 'msosptFlowChartInternalStorage';
      114:Result := 'msosptFlowChartDocument';
      115:Result := 'msosptFlowChartMultidocument';
      116:Result := 'msosptFlowChartTerminator';
      117:Result := 'msosptFlowChartPreparation';
      118:Result := 'msosptFlowChartManualInput';
      119:Result := 'msosptFlowChartManualOperation';
      120:Result := 'msosptFlowChartConnector';
      121:Result := 'msosptFlowChartPunchedCard';
      122:Result := 'msosptFlowChartPunchedTape';
      123:Result := 'msosptFlowChartSummingJunction';
      124:Result := 'msosptFlowChartOr';
      125:Result := 'msosptFlowChartCollate';
      126:Result := 'msosptFlowChartSort';
      127:Result := 'msosptFlowChartExtract';
      128:Result := 'msosptFlowChartMerge';
      129:Result := 'msosptFlowChartOfflineStorage';
      130:Result := 'msosptFlowChartOnlineStorage';
      131:Result := 'msosptFlowChartMagneticTape';
      132:Result := 'msosptFlowChartMagneticDisk';
      133:Result := 'msosptFlowChartMagneticDrum';
      134:Result := 'msosptFlowChartDisplay';
      135:Result := 'msosptFlowChartDelay';
      136:Result := 'msosptTextPlainText';
      137:Result := 'msosptTextStop';
      138:Result := 'msosptTextTriangle';
      139:Result := 'msosptTextTriangleInverted';
      140:Result := 'msosptTextChevron';
      141:Result := 'msosptTextChevronInverted';
      142:Result := 'msosptTextRingInside';
      143:Result := 'msosptTextRingOutside';
      144:Result := 'msosptTextArchUpCurve';
      145:Result := 'msosptTextArchDownCurve';
      146:Result := 'msosptTextCircleCurve';
      147:Result := 'msosptTextButtonCurve';
      148:Result := 'msosptTextArchUpPour';
      149:Result := 'msosptTextArchDownPour';
      150:Result := 'msosptTextCirclePour';
      151:Result := 'msosptTextButtonPour';
      152:Result := 'msosptTextCurveUp';
      153:Result := 'msosptTextCurveDown';
      154:Result := 'msosptTextCascadeUp';
      155:Result := 'msosptTextCascadeDown';
      156:Result := 'msosptTextWave1';
      157:Result := 'msosptTextWave2';
      158:Result := 'msosptTextWave3';
      159:Result := 'msosptTextWave4';
      160:Result := 'msosptTextInflate';
      161:Result := 'msosptTextDeflate';
      162:Result := 'msosptTextInflateBottom';
      163:Result := 'msosptTextDeflateBottom';
      164:Result := 'msosptTextInflateTop';
      165:Result := 'msosptTextDeflateTop';
      166:Result := 'msosptTextDeflateInflate';
      167:Result := 'msosptTextDeflateInflateDeflate';
      168:Result := 'msosptTextFadeRight';
      169:Result := 'msosptTextFadeLeft';
      170:Result := 'msosptTextFadeUp';
      171:Result := 'msosptTextFadeDown';
      172:Result := 'msosptTextSlantUp';
      173:Result := 'msosptTextSlantDown';
      174:Result := 'msosptTextCanUp';
      175:Result := 'msosptTextCanDown';
      176:Result := 'msosptFlowChartAlternateProcess';
      177:Result := 'msosptFlowChartOffpageConnector';
      178:Result := 'msosptCallout90';
      179:Result := 'msosptAccentCallout90';
      180:Result := 'msosptBorderCallout90';
      181:Result := 'msosptAccentBorderCallout90';
      182:Result := 'msosptLeftRightUpArrow';
      183:Result := 'msosptSun';
      184:Result := 'msosptMoon';
      185:Result := 'msosptBracketPair';
      186:Result := 'msosptBracePair';
      187:Result := 'msosptSeal4';
      188:Result := 'msosptDoubleWave';
      189:Result := 'msosptActionButtonBlank';
      190:Result := 'msosptActionButtonHome';
      191:Result := 'msosptActionButtonHelp';
      192:Result := 'msosptActionButtonInformation';
      193:Result := 'msosptActionButtonForwardNext';
      194:Result := 'msosptActionButtonBackPrevious';
      195:Result := 'msosptActionButtonEnd';
      196:Result := 'msosptActionButtonBeginning';
      197:Result := 'msosptActionButtonReturn';
      198:Result := 'msosptActionButtonDocument';
      199:Result := 'msosptActionButtonSound';
      200:Result := 'msosptActionButtonMovie';
      201:Result := 'msosptHostControl';
      202:Result := 'msosptTextBox';
     else Result := 'Unknown'
  end;
end;

{TMSODrawingGroup}
constructor TMSODrawingGroup.Create;
begin
  inherited Create;
  FPictures := TMSOPictureList.Create;
  FDgg := TMsoFbtDGG.Create;
  FOpt := TMsoFbtOpt.Create;
  FSplitMenuColors := TMsoFbtUnknown.Create;

  FSplitMenuColors.FHeader := TMSOHeader.Create($0, $004, $F11E, 16);
  FSplitMenuColors.FData := TXLSBlob.Create(16);

  with FSplitMenuColors.FData do begin
    AddLong($0800000D); AddLong($0800000C);
    AddLong($08000017); AddLong($100000F7);
  end;

end;

destructor TMSODrawingGroup.Destroy;
begin
  FDgg.Free;
  FOpt.Free;
  FPictures.Free;
  FSplitMenuColors.Free;
  inherited Destroy;
end;

procedure TMSODrawingGroup.PrepareStore;
begin
  //reset dgg
  FDgg.PrepareStore;
  //!!!FDgg.Free;
  //!!!FDgg := TMsoFbtDGG.Create;
  //!!!!Reset picture RefCount
end;

procedure TMSODrawingGroup.Clear;
begin
  FDgg.Free;
  FOpt.Free;
  FPictures.Free;

  FPictures := TMSOPictureList.Create;
  FDgg := TMsoFbtDGG.Create;
  FOpt := TMsoFbtOpt.Create;
end;


function TMSODrawingGroup.GetSize: integer;
begin
  Result := msoHeaderSize; //msofbtDggContainer
  Inc(Result, Dgg.Size);
  Inc(Result, FPictures.Size);
  Inc(Result, FOpt.Size);  //msofbtOpt
  Inc(Result, FSplitMenuColors.Size);
end;

procedure TMSODrawingGroup.RemoveDrawing(FDrawingID: Word);
begin
  DGG.RemoveDrawing(FDrawingID);
end;


function TMSODrawingGroup.Store(DataList: TXLSBlobList; BiffRecSize: integer): integer;
Const iRecord = $00EB;
Var sz: integer;
    Data: TXLSBlob;
    Writer: TXLSBiffWriter;
    i: integer;
begin
  Result := 1;
  Writer := TXLSBiffWriter.Create(DataList, BiffRecSize);

  sz := Size;
  Writer.StartNewBiff(iRecord, sz);

  //DggContainer
  Data := TXLSBlob.Create(msoHeaderSize);
  AddHeader(Data, $0F, $0000, msofbtDggContainer, sz - msoHeaderSize);
  Writer.AddData(Data); 

  //Dgg
  Writer.AddData(Dgg.GetData());

  //Pictures
  if FPictures.Count > 0 then begin
     //msofbtBStoreContainer
     sz := FPictures.Size;

     Data := TXLSBlob.Create(msoHeaderSize);
     AddHeader(Data, $0F, FPictures.Count, msofbtBstoreContainer, sz - msoHeaderSize);
     Writer.AddData(Data);
    
     for i := 0 to FPictures.Count - 1 do begin
        Data := FPictures[i].GetData(); 
        Writer.AddData(Data);
        Writer.AddData(nil);
     end;
  end;

  Data := Opt.GetData(); 
  Writer.AddData(Data);

  Writer.AddData(FSplitMenuColors.GetData());

  Writer.Flush;
  Writer.Free;  
end;

function TMSODrawingGroup.Parse(DataList: TXLSBlobList): integer;
Var Header: TMSOHeader;
    Offset: LongWord;
    length: Longword;
begin
  Offset := 0;
  Result := 1;
  Header := TMSOHeader.Create(DataList, Offset);
  if Header.fbt = msofbtDggContainer then begin
     length := Header.Length;
     while length > 0 do begin
       if length < msoHeaderSize then begin
          raise Exception.Create('length < Header.Length');
          Result := -1;
          break;
       end;
       length := length - msoHeaderSize;
       Header.Free;
       Header := TMSOHeader.Create(DataList, Offset);
       case Header.fbt of 
          msofbtBstoreContainer: 
            begin
              Result := FPictures.Parse(DataList, Offset, Header.Length); 
              if Result <> 1 then raise Exception.Create('Pictures parse error');
            end; 
          msofbtOpt: 
            begin
              Result := Opt.Parse(Header, DataList, Offset, Header.Length);
            end; 

          msofbtDgg: 
            begin
              Result := Dgg.Parse(Header, DataList, Offset, Header.Length);
            end; 
          else begin

          end;       
       end;     

       if length < Header.Length then begin
          raise Exception.Create('length < Header.Length');
          break;
       end;

       length := length - Header.Length;
       Offset := Offset + Header.Length;
       if Result <> 1 then break;
     end;
  end;
  Header.Free;
end;
 

function TMSODrawingGroup.GetOpt: TMsoFbtOpt;
begin
  if Not(Assigned(FOpt)) then FOpt := TMsoFbtOpt.Create;
  Result := FOpt; 
end;


{TMSOHeader}
function TMSOHeader.GetVer: byte;
begin
  Result := FRecordType and $0000000F;
end;

function TMSOHeader.GetInst: word;
begin
  Result := (FRecordType and $0000FFF0) shr 4;
end;


function TMSOHeader.GetFbt: word;
begin
  Result := (FRecordType and $FFFF0000) shr 16;
end;

function TMSOHeader.GetIsFolder: boolean;
begin
  Result := (Ver = $F);
end;

procedure TMSOHeader.SetVer(Value: byte);
begin
  FRecordType := (FRecordType and $FFFFFFF0) or (Value and $0F);
end;

procedure TMSOHeader.SetInst(Value: word);
begin
  FRecordType := (FRecordType and $FFFF000F) or ((Value and $0FFF) shl 4);
end;

procedure TMSOHeader.SetFbt(Value: word);
begin
  FRecordType := (FRecordType and $0000FFFF) or ((LongWord(Value) and $0000FFFF) shl 16);
end;


constructor TMSOHeader.Create(DataList: TXLSBlobList; Var Offset: LongWord);
Var Data: TXLSBlob;
begin
  inherited Create;
  Data := nil;
  DataList.GetData(Offset, msoHeaderSize, Data);
  Offset := Offset + msoHeaderSize;
  FRecordType := Data.GetLong(0);
  FRecordLength := Data.GetLong(4);
  Data.Free;
end;

constructor TMSOHeader.Create(Header: TMSOHeader);
begin
  inherited Create;
  FRecordType := Header.FRecordType;
  FRecordLength := Header.FRecordLength;
end;

constructor TMSOHeader.Create(AVer: byte; AInst: word; AFbt: word; ALength: Longword);
begin
  inherited Create;
  ver := AVer;
  inst := AInst;
  fbt  := AFbt;
  Length := ALength;
end;

procedure TMSOHeader.DebugOutput;
begin
  DebugOutput(0);
end;

procedure TMSOHeader.DebugOutput(level: integer);
var i: integer;
    shapename: string;
begin
  if level > 0 then begin
    for i := 0 to level - 1 do write('  ');
  end;

  if fbt = $F00A then shapename := ' shape=' + ShapeIDToShapeName(inst)
                 else shapename := '';
  writeln('inst=', inttohex(inst, 3), 
          ' ver=', inttohex(ver, 1), 
          ' fbt=', inttohex(fbt, 4), 
          ' len=', Length,
          ' name=', FBTCodeToName(fbt),
          shapename);
end;


function TMSOHeader.AddHeader(Data: TXLSBlob): integer;
begin
  Result := 1;
  if not(Assigned(Data)) then Result := -1;
  if Result = 1 then begin
     if (Data.GetBuffSize - Data.DataLength) < msoHeaderSize then Result := -1;
  end;
  if Result = 1 then begin
     Data.AddLong(FRecordType);
     Data.AddLong(FRecordLength);
  end;
end;

{TMSOPicture}

constructor TMSOPicture.Create;
begin
  Inherited Create;
  //FHash := TXLSBlob.Create(16);
end;

destructor TMSOPicture.Destroy;
begin
  FData.Free;
  FHash.Free;
  Inherited Destroy;
end;

procedure TMSOPicture.CalcHash;
Var
   h: TMD4Hash; 
begin
   h := TMD4Hash.Create;
   try
     h.Init;
     h.Update(FData.Buff^, FData.DataLength);
     h.MDFinal(FHash.buff^);
   finally
     h.Free;
   end;
end;

function TMSOPicture.GetHashKey: String;
var i, cnt: integer;
begin
  Result := '';
  if Assigned(FHash) then begin
     cnt := FHash.DataLength;
     if cnt > 0 then begin
       for i := 0 to cnt - 1 do begin
         Result := Result + inttohex(FHash.GetByte(i), 2);
       end;
     end;
  end;
end;


function TMSOPicture.GetSize: integer;
Var FBSE: TXLSFBSE; 
begin
  Result := msoHeaderSize;
  FBSE := TXLSFBSE.Create;
  Inc(Result, FBSE.DataSize);
  FBSE.Free; 
  if FBlipName <> '' then begin
     Inc(Result, Length(FBlipName) * 2);
  end;
  if not(pictureType = msoblipError) then begin
     Inc(Result, msoHeaderSize);
     Inc(Result, 16); //Hash  
     Inc(Result, 1);
     if pictureType in [msoblipWMF, msoblipEMF] then     // -----> GC
     Inc(Result, 33);     // -----> GC
     if Assigned(FData) then Inc(Result, FData.DataLength);
  end;
end;

function TMSOPicture.GetBlipInst: Word;
begin
  case PictureType of
    msoblipEMF:   Result := $03D4;
    msoblipWMF:   Result := $0216;                         
    msoblipPICT:  Result := $0542;
    msoblipJPEG:  Result := $046A;
//    msoblipPNG:   Result := $06E1;
    msoblipPNG:   Result := $06E0;
    msoblipDIB:   Result := $07A8;
    else          Result := $0000; 
  end;
end;


function TMSOPicture.GetData: TXLSBlob;
var sz: integer;
    i: integer;
    FBSE: TXLSFBSE; 
begin
  sz := Size;
  if sz > 0 then begin
     Result := TXLSBlob.Create(sz);
     //msofbtBse Header
     Dec(sz, msoHeaderSize);
     AddHeader(Result, $02, Word(FPictureType), msofbtBse, sz);
     //BSE record
     FBSE := TXLSFBSE.Create;
     Dec(sz, FBSE.DataSize);
     FBSE.NameLength := Length(FBlipName) * 2;
     FBSE.PictureType:= PictureType;
     FBSE.RefCount   := RefCount;
     FBSE.Size := sz;
  
     if not(pictureType = msoblipError) then begin
         // -----> GC
         //Hash  non compressed EMF
         if PictureType = msoblipEMF then begin         
           for i := 0 to 15 do begin                    
             FBSE.FFBSE.rgbUid[i]:= BSEWMF.EmfRgbUid[i];
           end;
         end else begin
           FBSE.SetHash(FHash);
         end;
     end;

     FBSE.AddData(Result);
     FBSE.Free;

     if not(pictureType = msoblipError) then begin
         //msofbtBlip Header
         Dec(sz, msoHeaderSize);


         AddHeader(Result, $00, GetBlipInst(), msofbtBlipFirst + Word(PictureType), sz);
         // -----> GC  Start
         if PictureType = msoblipEMF then begin
           for i := 0 to 15 do begin
             Result.AddByte(BSEWMF.EmfRgbUid[i]);
           end;
         end else begin 
           Result.CopyData(FHash);
         end;
      
         if not (PictureType in [msoblipWMF, msoblipEMF]) then begin
           //Tag
           Result.AddByte($00);
           //Result.AddByte($FF);
         end else begin
           FFilename := 'xxxx';    // not used
           Result.AddLong(BSEWMF.m_cb);
           Result.AddLong(BSEWMF.m_rcBounds.Left);
           Result.AddLong(BSEWMF.m_rcBounds.Top);
           Result.AddLong(BSEWMF.m_rcBounds.Right);
           Result.AddLong(BSEWMF.m_rcBounds.Bottom);
           Result.AddLong(BSEWMF.m_ptSize.X);
           Result.AddLong(BSEWMF.m_ptSize.Y);
           Result.AddLong(BSEWMF.m_cbSave);
           Result.AddByte(BSEWMF.m_fCompression);
           Result.AddByte(BSEWMF.m_fFilter);
         end;
      // -----> GC  End
         if Assigned(FData) then begin
            Result.CopyData(FData);
         end;

     end; 
  end else begin
     Result := nil;
  end;
end;

// -----> GC - Gamma Computer snc Settino T. Italy
function TMSOPicture.LoadFromFileBMP(Bitmap: TBitmap): integer;
Var Stream: TMemoryStream;  
    {$IFDEF USEPNGLIB}PngImage: TPNGObject;{$ENDIF}
    PictureSize: integer;
begin
  Stream := TMemoryStream.Create;
  Result := 1;
  if Bitmap.PixelFormat in [PfDevice, pf32Bit] then  
     Bitmap.PixelFormat := pf24Bit;
  {$IFDEF USEPNGLIB}
  FPictureType := msoblipPng; /// Type BMP
  PngImage := TPNGObject.Create;
  try
    PngImage.Assign(Bitmap);
    PngImage.SaveToStream(Stream);
  finally
    PngImage.Free;
  end;
  {$Else}
  Bitmap.SaveToStream(Stream);
  FPictureType := msoblipDIB;   ///Type BMP
  {$ENDIF}
  Stream.Position := 0;
  PictureSize := Stream.Size;

  if Result = 1 then begin
     FRefCount   := 1;
     if Assigned(FData) then FData.Free;
     if PictureType = msoblipDIB then begin
        //skip bmp header
        Dec(PictureSize, 14);
        Stream.Seek(14, soFromCurrent);
     end;
     FData := TXLSBlob.Create(PictureSize);
     Stream.Read(FData.Buff^, PictureSize);
     Data.DataLength := PictureSize;
     if not(Assigned(FHash)) then begin
        FHash := TXLSBlob.Create(16);
        FHash.DataLength := 16;
     end;
     CalcHash;
  end;
  Stream.Free;
end;

// -----> GC
function TMSOPicture.LoadFromFile(AFileName: WideString): integer;
Var Stream: TStream;   
    Bitmap: TBitmap;
    {$IFDEF USEPNGLIB}
    MetaFile: TMetafile; 
    {$ENDIF}
    PictureSize: integer;
    {$IFDEF OPEN_EMFWMF}
    {$IFNDEF USEPNGLIB}
    i: integer;
    FfWmfRead : TGWmfEmfRead;
    {$ENDIF}
    {$ENDIF}
begin
  PictureSize := 0;
  FFilename := AnsiString(AFileName);
  Result := 1;
  Stream := nil;
  FPictureType := ExtToPictureType(Copy(ExtractFileExt(AFileName), 2, 5));
  if not(FPictureType in [msoblipJPEG, 
                          msoblipPNG, 
                          msoblipDIB
                          {$IFDEF USEPNGLIB}
                          , msoblipWMF, 
                          msoblipEMF
                          {$ELSE}
                            {$IFDEF OPEN_EMFWMF}
                            , msoblipWMF, 
                            msoblipEMF
                            {$ENDIF}
                          {$ENDIF}
                         ]) then begin
     raise Exception.Create('Unsupported picture type');
  end;

  if (FPictureType in [msoblipJPEG, msoblipPNG]) then begin
    //Jpeg, Png
    Stream := TWFileStream.Create(AFileName, fmOpenRead);
    Stream.Position := 0;
    PictureSize := Stream.Size;
  end else if FPictureType = msoblipDIB then begin
    //Bmp 
    Stream := TWFileStream.Create(AFileName, fmOpenRead);
    Stream.Position := 0;
    Bitmap := TBitmap.Create;
    Bitmap.LoadFromStream(Stream);
    Stream.Free;
    Result := LoadFromFileBMP(Bitmap);
    Bitmap.Free;
    exit;
  end else if FPictureType in [msoblipWMF, msoblipEMF] then begin
  {$IFDEF USEPNGLIB}
    Metafile := TMetaFile.Create;
    Bitmap   := TBitmap.Create;
    Bitmap.PixelFormat := pf24Bit;
    MetaFile.LoadFromFile(AFileName);
    Bitmap.Height := MetaFile.Height;
    Bitmap.Width  := MetaFile.Width;
    FBSEWMF.Width := MetaFile.Width * 0.75;
    FBSEWMF.Height:= MetaFile.Height * 0.75;

    Bitmap.Canvas.Draw(0, 0, MetaFile);
    MetaFile.Free;
    Result := LoadFromFileBMP(Bitmap);
    Bitmap.Free;
    exit;
  {$ELSE}
    {$IFDEF OPEN_EMFWMF}
    FfWmfRead := TGWmfEmfRead.Create(AFileName);

    FBSEWMF.m_cb       := FfWmfRead.BSEWMF.m_cb;
    FBSEWMF.m_rcBounds := FfWmfRead.BSEWMF.m_rcBounds;
    FBSEWMF.m_ptSize   := FfWmfRead.BSEWMF.m_ptSize;
    FBSEWMF.m_cbSave   := FfWmfRead.BSEWMF.m_cbSave;
    FBSEWMF.m_fCompression := FfWmfRead.BSEWMF.m_fCompression;
    FBSEWMF.m_fFilter  := FfWmfRead.BSEWMF.m_fFilter;
    FBSEWMF.Width      := FfWmfRead.Width;
    FBSEWMF.Height     := FfWmfRead.Height;

    if PictureType in [msoblipEMF] then begin
      for i := 0 to 15 do begin
        FBSEWMF.EmfRgbUid[i] := FfWmfRead.BSEWMF.EmfRgbUid[i];
      end;
    end;

    Stream := TMemoryStream.Create;
    TMemoryStream(Stream).LoadFromStream(FfWmfRead.C_Stream);
    Stream.Position := 0;
    PictureSize := FBSEWMF.m_cbSave;
    FfWmfRead.Free;
    {$ENDIF}
  {$ENDIF}
  end;

  if Result = 1 then begin
     FRefCount := 1;
     if Assigned(FData) then FData.Free;
     FData := TXLSBlob.Create(PictureSize);
     Stream.Read(FData.Buff^, PictureSize);
     Data.DataLength := PictureSize;
     if not(Assigned(FHash)) then begin
        FHash := TXLSBlob.Create(16);
        FHash.DataLength := 16;
     end;
     CalcHash;
  end;

  Stream.Free;
end;


function TMSOPicture.ExtToPictureType(Ext: WideString): TMsoBlipType;
Var lExt: WideString;
begin
  lExt := LowerCase(Ext);
  if      lExt = 'emf'  then Result := msoblipEMF
  else if lExt = 'wmf'  then Result := msoblipWMF
  else if lExt = 'pict' then Result := msoblipPICT
  else if lExt = 'jpg'  then Result := msoblipJPEG
  else if lExt = 'jpeg' then Result := msoblipJPEG
  else if lExt = 'png'  then Result := msoblipPNG
  else if lExt = 'bmp'  then Result := msoblipDIB
  else Result := msoblipUNKNOWN;  
end;

function TMSOPicture.Parse(AHeader: TMSOHeader; DataList: TXLSBlobList; Offset: LongWord): integer;
Var FBSE: TXLSFBSE;
    lHeader: TMSOHeader;
    sz: longword;
    Data: TXLSBlob;
    addsize: integer; 
    i: integer;
begin
  Result := 1;
  FBSE := nil;
  lHeader := nil;

  //Load header
  if AHeader.fbt <> msofbtBse then begin
     Result := -1;
  end;

  //FBSE structure
  if Result = 1 then begin
     FBSE := TXLSFBSE.Create;
     Result := FBSE.Parse(DataList, Offset, AHeader.Length);
  end;

  //FBlipName if exists
  if Result = 1 then begin
     if FBSE.NameLength > 0 then begin
        Result := DataList.GetWideString(Offset, FBSE.NameLength, FBlipName, sz);
        Inc(Offset, sz);
     end;
  end;

  if Result = 1 then begin
     FRefCount    := FBSE.RefCount;
     FPictureType := FBSE.PictureType; 
     if FPictureType = msoblipERROR then begin
        Result := 2;
     end;
  end;

  
  if Result = 1 then begin

     lHeader := TMSOHeader.Create(DataList, Offset);
     if lHeader.FBT <> (msofbtBlipFirst + Ord(FPictureType)) then begin
        Result := -1;
     end;

     if (lHeader.FBT < msofbtBlipFirst) or (lHeader.FBT > msofbtBlipLast) then begin
        Result := -1;
     end;

  end;

  //Hash
  if Result = 1 then begin
     Result := DataList.GetData(Offset, 16, FHash);

     if PictureType = msoblipEMF then begin
        for i := 0 to 15 do begin
           FBSEWMF.EmfRgbUid[i] := FHash.GetByte(i);   
        end;        
     end;

     Inc(Offset, FHash.DataLength);

     if FBSE.size <> (lHeader.Length + msoHeaderSize) then begin
        Result := -1;
     end;
  end;

  if Result = 1 then begin
     if FPictureType in [msoblipJPEG, msoblipPNG, msoblipDIB, msoblipWMF, msoblipEMF] then begin

        if not (PictureType in [msoblipWMF, msoblipEMF]) then begin

            Inc(Offset); //Skip tag
            addsize := 1;

        end else begin
            //WMF, EMF
            addsize := 8 * 4 + 2; 
            Result := DataList.GetData(Offset, addsize, Data);  

            if Result = 1 then begin
               FBSEWMF.m_cb              := Data.GetLong(0); Inc(Offset, 4);
               FBSEWMF.m_rcBounds.Left   := Data.GetLong(4); Inc(Offset, 4);
               FBSEWMF.m_rcBounds.Top    := Data.GetLong(8); Inc(Offset, 4);
               FBSEWMF.m_rcBounds.Right  := Data.GetLong(12); Inc(Offset, 4);
               FBSEWMF.m_rcBounds.Bottom := Data.GetLong(16); Inc(Offset, 4);
               FBSEWMF.m_ptSize.X        := Data.GetLong(20); Inc(Offset, 4);
               FBSEWMF.m_ptSize.Y        := Data.GetLong(24); Inc(Offset, 4);
               FBSEWMF.m_cbSave          := Data.GetLong(28); Inc(Offset, 4);
                
               FBSEWMF.m_fCompression    := Data.GetByte(32); Inc(Offset, 1);
               FBSEWMF.m_fFilter         := Data.GetByte(33); Inc(Offset, 1);

               Data.Free;
            end;
        end;

        //Load picture data
        Result := DataList.GetData(Offset, (lHeader.Length - FHash.DataLength - Longword(addsize)), FData);

        CalcHash;
     end else begin
        //
     end;


  end else begin
     if Result = 2 then Result := 1 else Result := -1;
  end;

  lHeader.Free;
  FBSE.Free;
end;
 

function TMSOPicture.SaveAs(Fname: String): integer;
var
  FileHandle: Integer;
begin
  FileHandle := FileCreate(FName);
  if FileHandle > 0 then begin
     FileWrite(FileHandle, FData.Buff^, FData.DataLength);
     FileClose(FileHandle);
  end;
  Result := 1;
end;

{TMSOPictureList}

function TMSOPictureList.GetPicture(Index: integer): TMSOPicture;
begin
  if Index >= Count then Result := nil
                    else Result := TMSOPicture(inherited Get(Index));
end;

constructor TMSOPictureList.Create;
begin
  Inherited Create;
  FCurBlipID := 0;
  FPicturesHash := THashObject.Create;
  FPicturesHash.FreeOnDestroy := false;
end;


destructor TMSOPictureList.Destroy;
var i, cnt: integer;
begin
  cnt := Count;
  if cnt > 0 then begin
     for i := 0 to cnt - 1 do begin
       Item[i].Free;
     end;
  end;
  FPicturesHash.Free;
  Inherited Destroy;
end;


// -----> GC -  Gamma Computer snc Settino T. Italy
function TMSOPictureList.LoadFromFileBmp(Bitmap: TBitmap): TMSOPicture;
Var LHashKey: String;
    Pict: TMsoPicture;
begin
  Result := TMSOPicture.Create;

  try
    Result.LoadFromFileBmp(Bitmap);
  except
    on E:Exception do begin
       Result.Free;
       Result := nil;
    end; 
  end;

  if Assigned(Result) then begin
     LHashKey := Result.HashKey;
     Pict := TMsoPicture(FPicturesHash[lHashKey]);
     if Assigned(Pict) then begin
        Inc(TMsoPicture(Pict).FRefCount); // <----- ADD for all Images equal
        Result.Free;
        Result := Pict;
     end else begin
        Add(Result);
        Result.BlipID := FCurBlipID;
        Inc(FCurBlipID);
     end;
  end;
end;


function TMSOPictureList.LoadFromFile(AFileName: WideString): TMSOPicture;
Var LHashKey: String;
    Pict: TMsoPicture;
begin
  Result := TMSOPicture.Create;
  try
    Result.LoadFromFile(AFileName);
  except
    on E:Exception do begin
       Result.Free;
       Result := nil;
    end; 
  end;
  
  if Assigned(Result) then begin
     LHashKey := Result.HashKey;
     Pict := TMsoPicture(FPicturesHash[lHashKey]);
     if Assigned(Pict) then begin
        Inc(TMsoPicture(Pict).FRefCount); // <----- ADD for all Images equal
        Result.Free;
        Result := Pict;
     end else begin
        
        Add(Result);
        Result.BlipID := FCurBlipID;
        Inc(FCurBlipID);
     end;
  end;
end;


function TMSOPictureList.Add(Item: Pointer): Integer;
begin
  Result := inherited Add(Item);
  FPicturesHash[TMsoPicture(Item).HashKey] := Item;
end;


function TMSOPictureList.GetSize: integer;
Var i, cnt: integer;
begin
  Result  := 0;
  cnt := Count;
  if cnt > 0 then begin
     for i := 0 to cnt - 1 do begin
       if Assigned(Item[i]) then begin
          //if Item[i].RefCount > 0 then begin
             Inc(Result, Item[i].Size);
          //end;
       end;
     end;
  end;
  if Result > 0 then Inc(Result, msoHeaderSize);
end;

function TMSOPictureList.Parse(DataList: TXLSBlobList; Offset: LongWord; DataLength: Longword): integer;
var
  Picture: TMSOPicture;
  Header: TMSOHeader;
  Len: integer;
  CurDataLength: integer;
begin
  Picture := nil;
  FCurBlipID := 0;
  Result := 1;
  CurDataLength := DataLength;
  while CurDataLength > 0 do begin
    Header := TMSOHeader.Create(DataList, Offset);
    Len := Header.Length;  
    try
      try
        Picture := TMSOPicture.Create;
        Result := Picture.Parse(Header, DataList, Offset);
        if Result <> 1 then raise Exception.Create('Picture parse failed');
        Picture.BlipID := FCurBlipID;
        Add(Picture);
      except
        on E:Exception do begin
           Picture.Free;
        end; 
      end;
    finally
      Inc(FCurBlipID);
      Header.Free;
      Dec(CurDataLength, msoHeaderSize + Len);
      Inc(Offset, Len);
    end;
  end;
end;
 

{TXLSFBSE}
constructor TXLSFBSE.Create;
begin
  inherited Create;
//!!  FFBSE.unused2 := $88;
//!!  FFBSE.unused3 := $02;

  FFBSE.unused2 := $00; 
  FFBSE.unused3 := $00; 

  FFBSE.tag     := $00FF;
end;

function TXLSFBSE.AddData(Data: TXLSBlob): integer;
var FData: TXLSBlob;
begin
  FData := TXLSBlob.Create(Sizeof(TFBSE));
  System.Move(FFBSE, FData.Buff^, Sizeof(TFBSE));
  Data.CopyData(FData, 0, Sizeof(TFBSE));
  FData.Free;
  Result := 1;
end;

function TXLSFBSE.Parse(DataList: TXLSBlobList; Var Offset: LongWord; DataLength: Longword): integer;
Var Data: TXLSBlob;
begin
  Result := 1;
  if DataLength < SizeOf(TFBSE) then Result := -1;
  if Result = 1 then begin
     Result := DataList.GetData(Offset, SizeOf(TFBSE), Data);
     if Result = 1 then begin
        System.Move(Data.Buff^, FFBSE, Sizeof(TFBSE));
     end;
     Data.Free;
     Offset := Offset + SizeOf(TFBSE);
  end;
end;


function TXLSFBSE.GetPictureName: String;
begin
  Result := FPictureName;
end;

procedure TXLSFBSE.SetPictureName(Value: String);
begin
  FPictureName := Value;
end ;
   // -----> GC  end
function TXLSFBSE.GetNameLength: byte;
begin
  Result := FFBSE.cbName;
end;

procedure TXLSFBSE.SetNameLength(Value: byte);
begin
  FFBSE.cbName := Value;
end;


procedure TXLSFBSE.SetHash(Value: TXLSBlob);
var i: integer;
begin
  for i := 0 to 15 do FFBSE.rgbUid[i] := Value.GetByte(i);
end;

function TXLSFBSE.GetDataSize: longword;
begin
  Result := SizeOf(TFBSE);
end;


procedure TXLSFBSE.SetPictureType(Value: TMsoBlipType);
begin
  FFBSE.btWin32 :=  Value;
  FFBSE.btMacOs :=  Value;
  if Value = msoblipEMF then FFBSE.btMacOs := msoblipPICT;
end;

procedure TXLSFBSE.SetRefCount(Value: longword);
begin
  FFBSE.cRef := Value;
end;

procedure TXLSFBSE.SetSize(Value: longword);
begin
  FFBSE.Size := Value;
end;

function TXLSFBSE.GetPictureType: TMsoBlipType;
begin
  Result := FFBSE.btWin32;
end;

function TXLSFBSE.GetRefCount: longword;
begin
  Result := FFBSE.cRef;
end;

function TXLSFBSE.GetSize: longword;
begin
  Result := FFBSE.Size;
end;

{TXLSDrawingParser}
constructor TXLSDrawingParser.Create;
begin
  inherited Create;
end;

destructor TXLSDrawingParser.Destroy;
begin
  FRoot.Free;
  inherited Destroy;
end;

procedure TXLSDrawingParser.ParseNode(DataList: TXLSBlobList; Var Offset: longword);
Var Header: TMSOHeader;
    Rest: longword;
begin
  Header := TMSOHeader.Create(DataList, Offset);
  while FLength > 0 do begin
    FLength := FLength - msoHeaderSize;

    if Not(Assigned(FCurrentNode)) then begin
       FCurrentNode := TXLSDrawingParserItem.Create(nil, Header);
       if Not(Assigned(FRoot)) then FRoot := FCurrentNode;
    end else begin
       FCurrentNode := FCurrentNode.AddChild(Header);     
    end;

    FCurrentNode.FSkip := false;
    if Assigned(FOnStartParseItem) then FOnStartParseItem(Self, Header, Header.isFolder, FCurrentNode.FSkip);
    

    if not(Header.isFolder) or FCurrentNode.FSkip  then begin
       Rest := Min(FLength, Header.Length);
       FCurrentNode.CurLength := FCurrentNode.CurLength + integer(Rest);
       if Not(FCurrentNode.FSkip) then begin
          FCurrentNode.InitData();
          DataList.CopyData(Offset, Rest, FCurrentNode.Data);        
       end;
       Dec(FLength, Rest);
       Inc(Offset,  Rest);
    end;

    while FCurrentNode.Length = FCurrentNode.CurLength do begin
      if not(FCurrentNode.Header.isFolder) then begin
         if Assigned(FOnParseItem) and not(FCurrentNode.FSkip) then begin
            FOnParseItem(self, FCurrentNode.Header, FCurrentNode.Data);
         end;
      end;

      if Assigned(FOnEndParseItem) and not(FCurrentNode.FSkip) then begin
         FOnEndParseItem(self, FCurrentNode.Header, FCurrentNode.Header.isFolder);
      end;   
      
      FCurrentNode := FCurrentNode.Parent;
      if Not(Assigned(FCurrentNode)) then begin
         if Assigned(FOnEndParse) then FOnEndParse(Self);
         break;
      end;
    end; 

    if FLength > 0 then begin
       Header := TMSOHeader.Create(DataList, Offset);
    end;
  end; 
end;

procedure TXLSDrawingParser.Parse(DataList: TXLSBlobList);
var Offset: longword;
begin
  FLength := DataList.TotalSize;
  Offset := 0;
  ParseNode(DataList, Offset);
end;

procedure TXLSDrawingParser.Parse(DataList: TXLSBlobList; StartIndex: integer);
var Offset: longword;
    i: integer;
begin

  FLength := DataList.TotalSize;
  Offset := 0;
  if StartIndex > 0 then begin
     for i:=0 to StartIndex - 1 do begin
         Offset := Offset + DataList[i].DataLength;
     end;
     FLength := FLength - integer(Offset);
  end;
  ParseNode(DataList, Offset);
end;


{TXLSDrawingParserItem}
constructor TXLSDrawingParserItem.Create(AParent: TXLSDrawingParserItem; AHeader: TMSOHeader);
begin
  inherited Create;
  FHeader := AHeader;
  FParent := AParent;
  FChildCount := 0;
  FLength := FHeader.Length;
  FSkip := false;
  if Assigned(FParent) then FLevel := FParent.Level + 1
                       else FLevel := 0;
end;

destructor TXLSDrawingParserItem.Destroy;
var i: integer;
begin
  FHeader.Free;
  FData.Free;
  if ChildCount > 0 then begin
    for i := 1 to ChildCount do begin
      Child[i].Free;
    end;
    SetLength(FChild, 0);
    FChildCount := 0;
  end;
  inherited Destroy;
end;

function TXLSDrawingParserItem.GetChild(Index: integer): TXLSDrawingParserItem;
begin
  if (Index <= ChildCount) and (Index > 0) then begin
     Result := FChild[Index - 1];
  end else begin
     Result := nil;
  end;
end;

function TXLSDrawingParserItem.AddChild(AHeader: TMSOHeader): TXLSDrawingParserItem;
begin
  Inc(FChildCount, 1);
  SetLength(FChild, FChildCount);
  Inc(FCurLength, AHeader.Length + msoHeaderSize);
  FChild[FChildCount - 1] := TXLSDrawingParserItem.Create(self, AHeader);
  Result := FChild[FChildCount - 1]; 
end;

procedure TXLSDrawingParserItem.InitData;
begin
  if not(Assigned(FData)) then FData := TXLSBlob.Create(FLength);
end;


{TMsoFbt}
constructor TMsoFbt.Create;
begin
  inherited Create; 
end;

destructor TMsoFbt.Destroy;
begin
  FHeader.Free;
  inherited Destroy;
end;

procedure TMsoFbt.SetHeader(AHeader: TMSOHeader);
begin
  FHeader := TMSOHeader.Create(AHeader);
end;

function TMsoFbt.ParseData(AHeader: TMSOHeader; Data: TXLSBlob): integer;
var DList: TXLSBlobList; 
begin
  DList := TXLSBlobList.Create;
  try
    DList[0] := Data;
    Result := Parse(AHeader, DList, 0, AHeader.Length);
    DList[0] := nil;
  finally
    DList.Free;
  end;
end;

function TMsoFbt.Parse(AHeader: TMSOHeader; DataList: TXLSBlobList; Offset: LongWord; DataLength: Longword): integer;
begin
  Result := -1;
end;


function TMsoFbt.GetData: TXLSBlob;
Var Sz: integer;
begin
  Sz := Size;
  Result := nil;
  if Sz > 0 then begin
     Result := TXLSBlob.Create(Sz);
     AddData(Result);
  end;
end;

{TMsoFbtUnknown}
function TMsoFbtUnknown.AddData(Data: TXLSBlob): integer;
begin
  FHeader.AddHeader(Data);
  Data.CopyData(FData);
  Result := 1;
end;

function TMsoFbtUnknown.Parse(AHeader: TMSOHeader; DataList: TXLSBlobList; Offset: LongWord; DataLength: Longword): integer;
begin
  FHeader := TMSOHeader.Create(AHeader);
  if Assigned(FData) then begin
     FData.Free;
     FData := nil;
  end;
  Result := DataList.GetData(Offset, DataLength, FData);
end;


function TMsoFbtUnknown.GetSize: integer;
begin
  if Assigned(FHeader) then begin
     Result := msoHeaderSize;
     if Assigned(FData) then Inc(Result, FData.DataLength);
  end else Result := 0
end;

destructor TMsoFbtUnknown.Destroy; 
begin
  FData.Free;
//  FHeader.Free;
  inherited Destroy;
end;


{TMsoFbtDGGItem}
constructor TMsoFbtDGGItem.Create(ADgId: Word);
begin
  inherited Create();
  FDgId    := ADgId;
  FSpidCur := 0;  
end;

function TMsoFbtDGGItem.Parse(Data: TXLSBlob; Offset: LongWord): integer;
begin
  FDgId    := Data.GetLong(Offset);
  FSpidCur := Data.GetLong(Offset + 4);  
  Result := 1;
end;


function TMsoFbtDGGItem.AddData(Data: TXLSBlob): integer;
begin
  Data.AddLong(FDgID);
  Data.AddLong(FSpidCur);
  Result := 1;
end;

{TMsoFbtDGGList}

destructor TMsoFbtDGGList.Destroy;
var i, cnt: integer;
begin
  cnt := Count;
  if cnt > 0 then begin
     for i := 0 to cnt - 1 do begin
       Entries[i].Free;
     end;
  end;
  inherited Destroy;
end;

function TMsoFbtDGGList.GetSize: integer;
begin
  Result := Count * 8;
end;

function TMsoFbtDGGList.AddData(Data: TXLSBlob): integer;
var i: integer;
begin
  Result := 1;
  for i := 0 to Count - 1 do begin
    Entries[i].AddData(Data);
  end;
end;

function TMsoFbtDGGList.Parse(DataList: TXLSBlobList; Offset: LongWord; DataLength: Longword): integer;
var i, cnt: integer;
    Item: TMsoFbtDGGItem;
    Data: TXLSBlob;
begin
  Result := 1;
  if DataLength > 0 then begin
//     Data := TXLSBlob.Create(DataLength);
     Data := nil; 
     DataList.GetData(Offset, DataLength, Data);
     cnt := DataLength div 8;
     for i := 0 to cnt - 1 do begin
       Item := TMsoFbtDGGItem.Create(0);
       Item.Parse(Data, i * 8);
       Add(Item); 
     end;
     Data.Free;
  end;
end;



function TMsoFbtDGGList.GetItem(Index: integer): TMsoFbtDGGItem;
begin
  Result := TMsoFbtDGGItem(Items[Index]);
end;


{TMsoFbtDGG}
constructor TMsoFbtDGG.Create;
begin
  inherited Create;
  FCurDrawingID := 0;
  FList := TMsoFbtDGGList.Create; 
end;

destructor TMsoFbtDGG.Destroy;
begin
  FList.Free;
//  FHeader.Free;
  inherited Destroy;
end;

procedure TMsoFbtDGG.PrepareStore;
begin
   FSpidMax:= 0;  // The current maximum shape ID
   FSpSaved:= 0;  // The total number of shapes saved
                        // (including deleted shapes, if undo
                        // information was saved)
   FDgSaved:= 0;  // The total number of drawings saved
end;

procedure TMsoFbtDGG.RegisterSavedShapeID(AShapeID: longword);
begin
   if FSpidMax < AShapeID then FSpidMax := AShapeID;
   if AShapeID > 0 then Inc(FSpSaved);
end;


function TMsoFbtDGG.GetSize: integer;
begin
  if Count > 0 then begin
     Result := msoHeaderSize;
     Inc(Result, 16);
     Inc(Result, FList.Size);
  end else Result := 0  
end;

function TMsoFbtDGG.GetCount: integer;
begin
  Result := FList.Count;
end;

function TMsoFbtDGG.RegisterDrawing(Var ADrawingId: word): integer;
begin
  Inc(FDgSaved);
  if ADrawingID = 0 then begin
     Inc(FCurDrawingID);
     ADrawingID := FCurDrawingID; 
  end else if FCurDrawingID < ADrawingId then begin
     FCurDrawingID := ADrawingId;
  end;
  Result := 1;
end;

function TMsoFbtDGG.FindDggItem(ADrawingId: word): integer;
var cnt: integer;
    i: integer;
begin
  cnt := Count;
  Result := -1;
  for i := 0 to cnt - 1 do begin
    if (FList[i].DgId = ADrawingId) and
       (FList[i].SpidCur < ShapeIDBlockSize) then begin
       Result := i;
    end;
  end;
end;

function TMsoFbtDGG.GetShapeId(ADrawingId: word): longword;
Var i: integer;
    Item: TMsoFbtDGGItem;
begin
  i := FindDggItem(ADrawingId);
  if i < 0 then begin
    Item := TMsoFbtDGGItem.Create(ADrawingId);
    FList.Add(Item);
    i := Count - 1;  
  end;

  Result := (longword(i + 1) * ShapeIDBlockSize) + FList[i].SpidCur;
  FList[i].SpidCur := FList[i].SpidCur + 1;

  //if Result > FSpidMax then FSpidMax := Result;
  //Inc(FSpSaved);
end;

procedure TMsoFbtDGG.RemoveDrawing(FDrawingID: Word);
var i: integer;
begin
  if (Count > 0) and (FDrawingID <> 0) then begin
    for i := 0 to Count - 1 do begin
      if FList[i].DgId = FDrawingID then begin
         FList[i].DgId := 0;
         //FList[i].Free;
         //FList.Delete(i);
         //if FDgSaved > 0 then Dec(FDgSaved);
         //break;
      end;
    end;
  end;
end;

function TMsoFbtDGG.AddData(Data: TXLSBlob): integer;
var sz: integer;                     
begin
  sz := Size;
  if sz > 0 then begin
     //MSOHeader
     AddHeader(Data, $00, $0000, msofbtDgg, sz - msoHeaderSize);
     //DGG fixed size
     Data.AddLong(FSpidMax + 1);
     Data.AddLong(Count + 1);
     Data.AddLong(FSpSaved);
     Data.AddLong(FDgSaved);     
     //DGG array 
     FList.AddData(Data);
  end;
  Result := 1;
end;

function TMsoFbtDGG.Parse(AHeader: TMSOHeader; DataList: TXLSBlobList; Offset: LongWord; DataLength: Longword): integer;
var i, cnt: integer;
begin
  FHeader := TMSOHeader.Create(AHeader);
  FCurDrawingID := 0;
  Result := FList.Parse(DataList, Offset + 16, DataLength - 16);
  if Result = 1 then begin
     cnt := FList.Count;
     if cnt > 0 then begin
        for i := 0 to cnt - 1 do begin
            if FCurDrawingID < FList[i].DgID then FCurDrawingID := FList[i].DgID;
        end;
     end;
  end;
end;



function TMsoFbtOptItem.GetPid: Word;
begin
  Result := (FOption and $3FFF);
end;

function TMsoFbtOptItem.GetIsComplex: boolean;
begin
  Result := ((FOption and $8000) = $8000);
end;

procedure TMsoFbtOptItem.SetIsComplex(AValue: boolean);
begin
  FOption := FOption and $7FFF;
  if AValue then FOption := (FOption or $8000); 
end;

function TMsoFbtOptItem.GetIsBlipID: boolean;
begin
  Result := ((FOption and $4000) = $4000);
end;

procedure TMsoFbtOptItem.SetIsBlipID(AValue: boolean);
begin
  FOption := (FOption and $BFFF);
  if AValue then FOption := (FOption or $4000);
end;

procedure TMsoFbtOptItem.SetPid(AValue: Word);
begin
  if (AValue and $3FFF) = AValue then begin
    FOption := (FOption and $C000) or AValue;
  end;
end;

function TMsoFbtOptItem.GetWideStringValue: WideString;
begin
  Result := '';
  if isComplex then begin
    if Assigned(FExtraData) and (Value > 0) then begin
       Result := FExtraData.GetWideString(0, Value - 2);
    end;
  end;
end;

procedure TMsoFbtOptItem.SetWideStringValue(AValue: WideString);
begin
 if Assigned(FExtraData) then FExtraData.Free;
 Value := Length(AValue) * 2 + 2;
 isComplex := true;
 FExtraData := TXLSBlob.Create(Value);
 FExtraData.AddWideString(AValue);
 FExtraData.AddWord($0000);
end;

function TMsoFbtOptItem.GetSize: integer;
begin
  Result := 2 + 4;
  if isComplex then begin
     if (Value > 0) and Assigned(FExtraData) then begin
        Result := Result + integer(FExtraData.DataLength);
     end;
  end;
end;

procedure TMsoFbtOptItem.AddData(Data: TXLSBlob);
begin
  Data.AddWord(FOption);
  Data.AddLong(FValue);
end;

procedure TMsoFbtOptItem.AddExtraData(Data: TXLSBlob);
begin
  if Assigned(FExtraData) then Data.CopyData(FExtraData);
end;

function TMsoFbtOptItem.ParseData(DataList: TXLSBlobList; Offset: LongWord): integer;
Var Data: TXLSBlob;
begin
  Result := 1;
  try
    DataList.GetData(Offset, 6, Data); 
    FOption := Data.GetWord(0);
    FValue := Data.GetLong(2);
  finally
    Data.Free;
  end;
end;

function TMsoFbtOptItem.ParseExtraData(DataList: TXLSBlobList; Offset: LongWord): integer;
begin 
  Result := DataList.GetData(Offset, FValue, FExtraData); 
end;



destructor TMsoFbtOptItem.Destroy; 
begin
  FExtraData.Free;
  inherited Destroy;
end;


{TMsoFbtOpt}
constructor TMsoFbtOpt.Create;
begin
  inherited Create;
  FFbt := msofbtOpt;
  FArr := TObjectArray.Create;
end;

destructor TMsoFbtOpt.Destroy;
begin
  FArr.Free;
  inherited Destroy;
end;

function TMsoFbtOpt.GetIsDefined(Pid: Word): boolean;
begin
  Result := FArr.KeyExists(Pid);
end;

function TMsoFbtOpt.GetItem(Pid: Word): TMsoFbtOptItem;
var lValue: TObject;
begin
  lValue := FArr[Pid];
  if Assigned(lValue) then Result := TMsoFbtOptItem(lValue)
                      else Result := nil;
end;

procedure TMsoFbtOpt.SetItem(Pid: Word; Value: TMsoFbtOptItem);
begin
  FArr[Pid] := Value;
end;

procedure TMsoFbtOpt.DeleteItem(Pid: Word);   
begin
  FArr.Delete(Pid);
end;


function TMsoFbtOpt.GetCount: integer;
begin
  Result := FArr.Count;
end;

function TMsoFbtOpt.GetSortedKeys: TWordArray;
var Keys: TStringList;
    i, cnt: integer;
    val: word;
    isChanged: boolean;
begin
  Keys := FArr.Keys;
  try
    cnt := Keys.Count;
    SetLength(Result, cnt);
    if cnt > 0 then begin
       for i := 0 to cnt - 1 do begin
         Result[i] := strtoint(Keys[i]);
       end;
       //Sort Result
       isChanged := true;
       while isChanged and (cnt > 1) do begin
         isChanged := false;
         for i := 0 to cnt - 2 do begin
           if Result[i] > Result[i + 1] then begin
              val := Result[i];
              Result[i] := Result[i + 1];
              Result[i + 1] := val;
              isChanged := true;
           end;
         end; 
       end;
    end;
  finally 
    Keys.Free;
  end;
end;



function TMsoFbtOpt.GetSize: integer; 
var Keys: TStringList;
    i, cnt: integer;
begin
  Result := msoHeaderSize;
  Keys := FArr.Keys;
  try 
    cnt := Keys.Count;
    if cnt > 0 then begin
       for i := 0 to cnt - 1 do begin
         Result := Result + Item[strtoint(Keys[i])].Size;
       end;
    end;
  finally
    Keys.Free;
  end;
end;

function TMsoFbtOpt.DumpData: integer;
Var
    Keys: TWordArray;
    i, cnt: integer; 
    str: string;
begin
  Keys := nil;
  cnt := Count;
  if cnt > 0 then begin
     Keys := GetSortedKeys();
     for i := 0 to cnt - 1 do begin
       with Item[Keys[i]] do begin
         str := '  pid:' + inttostr(Keys[i]) + '  ' + inttostr(Value) + '    $' + inttohex(Value, 8);
         writeln(str);
       end;
     end; 
  end;
  Result := 1;
end;


function TMsoFbtOpt.AddData(Data: TXLSBlob): integer;
var sz: integer;
    Keys: TWordArray;
    i, cnt: integer;
    HasComplex: boolean;
begin
  Keys := nil;
  sz := Size;
  if sz > 0 then begin
     cnt := Count;
     AddHeader(Data, $03, cnt, FFbt, sz - msoHeaderSize);
     if cnt > 0 then begin
       Keys := GetSortedKeys();
       HasComplex := false;
       for i := 0 to cnt - 1 do begin
         with Item[Keys[i]] do begin
           AddData(Data);
           if isComplex then HasComplex := true;
         end;
       end; 
       if HasComplex then begin
         for i := 0 to cnt - 1 do begin
           with Item[Keys[i]] do begin
             if isComplex then AddExtraData(Data);
           end;
         end; 
       end;
     end;   
  end;
  Result := 1;
end;

procedure TMsoFbtOpt.Clear;
begin
  FArr.Free;
  FArr := TObjectArray.Create;
end;


function TMsoFbtOpt.Parse(AHeader: TMSOHeader; DataList: TXLSBlobList; Offset: LongWord; DataLength: Longword): integer;
var len: integer;
    lItem: TMsoFbtOptItem;
    Arr: TWordArray;
    i, cnt: integer;
begin
  Clear;
  len := DataLength;
  cnt := 0;
  FFbt := AHeader.Fbt;
  //parse options
  while len > 0 do begin
    lItem := TMsoFbtOptItem.Create;
    lItem.ParseData(DataList, Offset);
    Dec(len, 6);
    Dec(DataLength, 6);
    Inc(Offset, 6);
    if lItem.isComplex then begin
       Dec(len, lItem.Value);
       //keep pid with extra data
       Inc(cnt, 1);
       SetLength(Arr, cnt);
       Arr[cnt - 1] := lItem.pid;
    end;
    FArr[lItem.pid] := lItem;
  end;

  //parse extra data
  if cnt > 0 then begin
    len := DataLength;
    for i := 0 to cnt - 1 do begin
      if len > 0 then begin
         with Item[Arr[i]] do begin
           ParseExtraData(DataList, Offset);
           Offset := Offset + Value;
           len := len - integer(Value);
         end;  
      end;
    end;
    SetLength(Arr, 0);
  end;
  Result := 1;
end;


function TMsoFbtOpt.GetLongValue(Pid: Word): Longword;
Var OptItem: TMsoFbtOptItem;
begin
  OptItem := Item[Pid];
  if Assigned(OptItem) then Result := OptItem.Value
                       else Result := 0;
end;

procedure TMsoFbtOpt.SetLongValue(Pid: Word; Value: Longword);
Var OptItem: TMsoFbtOptItem;
begin
  OptItem := Item[Pid];
  if Not(Assigned(OptItem)) then begin
     OptItem := TMsoFbtOptItem.Create();
     OptItem.Pid := Pid;
     Item[Pid] := OptItem;
  end; 
  OptItem.Value := Value;
end;

function TMsoFbtOpt.GetWideStringValue(Pid: Word): WideString;
Var OptItem: TMsoFbtOptItem;
begin
  OptItem := Item[Pid];
  if Assigned(OptItem) then begin
    Result := OptItem.WideStringValue;
  end else begin
    Result := '';
  end;
end;

procedure TMsoFbtOpt.SetWideStringValue(Pid: Word; Value: WideString);
Var OptItem: TMsoFbtOptItem;
begin
  OptItem := Item[Pid];
  if Not(Assigned(OptItem)) then begin
     OptItem := TMsoFbtOptItem.Create();
     OptItem.Pid := Pid;
     Item[Pid] := OptItem;
  end; 
  OptItem.WideStringValue := Value;
end;


{TMsoFbtClientAnchor}
function TMsoFbtClientAnchor.GetSize: integer;
begin
  Result := msoHeaderSize + 9 * sizeof(word);
end;

constructor TMsoFbtClientAnchor.Create;
begin
  inherited Create;
end;

constructor TMsoFbtClientAnchor.Create(Data: TXLSBlob);
begin
  inherited Create;
  ParseData(Data);
end;


destructor TMsoFbtClientAnchor.Destroy;
begin
  inherited Destroy;
end;

procedure TMsoFbtClientAnchor.SetClientAnchor(ARow1, ARow1Offs, ACol1, ACol1Offs, ARow2, ARow2Offs, ACol2, ACol2Offs: Word);
begin
  FRow1 := ARow1;
  FRow2 := ARow2;
  FRow1Offs := ARow1Offs;
  FRow2Offs := ARow2Offs;
  FCol1 := ACol1;
  FCol2 := ACol2;
  FCol1Offs := ACol1Offs;
  FCol2Offs := ACol2Offs;
end;

function TMsoFbtClientAnchor.ParseData(AData: TXLSBlob): integer;
begin
  if AData.DataLength <> 18 then raise Exception.Create('Invalid MsoFbtClientAnchor size');
  FOption   := AData.GetWord(0);
  FCol1     := AData.GetWord(2);
  FCol1Offs := AData.GetWord(4);
  FRow1     := AData.GetWord(6);
  FRow1Offs := AData.GetWord(8);
  FCol2     := AData.GetWord(10);
  FCol2Offs := AData.GetWord(12);
  FRow2     := AData.GetWord(14);
  FRow2Offs := AData.GetWord(16);
  Result := 1;
end;



function TMsoFbtClientAnchor.AddData(Data: TXLSBlob): integer;
Var Sz: integer;
begin
  Sz := Size;
  AddHeader(Data, $0, $0000, msofbtClientAnchor, Sz - msoHeaderSize);
  With Data do begin
    AddWord(FOption);
    AddWord(FCol1);
    AddWord(FCol1Offs);
    AddWord(FRow1);
    AddWord(FRow1Offs);
    AddWord(FCol2);
    AddWord(FCol2Offs);
    AddWord(FRow2);
    AddWord(FRow2Offs);
  end;
  Result := 1;
end;

{TMsoFbtSp}

constructor TMsoFbtSp.Create(AVer: byte; AShapeType: Word; APErsistent: longword);
begin
  inherited Create;
  FShapeType  := AShapeType;
  FVer        := AVer;
  FPersistent := APersistent;
end;

constructor TMsoFbtSp.Create(Header: TMSOHeader; Data: TXLSBlob);
begin
  inherited Create;
  if not(Assigned(Data)) then raise Exception.Create('msofbtSp data is not assigned');
  if Data.DataLength < 8 then raise Exception.Create('msofbtSp data is invalid');
  FShapeType  := Header.inst;
  FVer        := Header.ver;
  FShapeId    := Data.GetLong(0);
  FPersistent := Data.GetLong(4);
end;

destructor TMsoFbtSp.Destroy;  
begin
  inherited Destroy;
end;

function TMsoFbtSp.GetSize: integer; 
begin
  Result := msoHeaderSize + 8;
end;

function TMsoFbtSp.AddData(Data: TXLSBlob): integer; 
begin
  AddHeader(Data, FVer, FShapeType, msofbtSp, 8);
  Data.AddLong(FShapeID);
  Data.AddLong(FPersistent);
  Result := 1;
end;

{TMsoShapeList}
constructor TMsoShapeList.Create(AGetShapeRect: TGetShapeRect; AGetShapeRect2: TGetShapeRect2);
begin
  inherited Create;
  FGetShapeRect := AGetShapeRect;
  FGetShapeRect2 := AGetShapeRect2;
  FShapeByObjID := TObjectArray.Create;
  FShapeByObjID.FreeOnDestroy := false;
end;

destructor TMsoShapeList.Destroy;
var i, cnt: integer;
begin
  FShapeByObjID.Free;
  cnt := Count;
  if cnt > 0 then begin
     for i := 0 to cnt - 1 do begin
       Items[i].Free;
     end;
  end;
  inherited Destroy;
end;

function TMsoShapeList.GetItem(Index: integer): TMsoShapeContainer;
begin
  Result := TMsoShapeContainer(inherited Items[Index]);
end;

procedure TMsoShapeList.AddItem(Item: TMsoShapeContainer);
begin
  if Assigned(Item) then begin
     FShapeByObjID[Item.ObjectID] := Item;
     inherited Add(Item);
  end;
end;

procedure TMsoShapeList.DeleteShape(Item: TMsoShapeContainer);
begin
  Remove(Item);
end;

function TMsoShapeList.Store(Data: TXLSBlob; DataList: TXLSBlobList; AEncrypt: boolean): integer;
var i: integer;
begin
  for i := 0 to Count - 1 do begin
    if Items[i] is TMsoShapeTextBox then begin
       With TMsoShapeTextBox(Items[i]) do begin
          FGetShapeRect(Row, Col, Height, Width,
                        ClientAnchor.FRow1, ClientAnchor.FRow1Offs,
                        ClientAnchor.FRow2, ClientAnchor.FRow2Offs,
                        ClientAnchor.FCol1, ClientAnchor.FCol1Offs,
                        ClientAnchor.FCol2, ClientAnchor.FCol2Offs);
       end;
    end;

    if Items[i] is TMsoShapePictureFrame then begin
       With TMsoShapePictureFrame(Items[i]) do begin
         FGetShapeRect2(ClientAnchor.FRow1, ClientAnchor.FRow1Offs,
                        ClientAnchor.FCol1, ClientAnchor.FCol1Offs,
                        Height, Width,
                        ClientAnchor.FRow2, ClientAnchor.FRow2Offs,
                        ClientAnchor.FCol2, ClientAnchor.FCol2Offs);
       end;
    end;
    if Items[i] is TMsoShapeChart then begin
       With TMsoShapeChart(Items[i]) do begin
         FGetShapeRect2(ClientAnchor.FRow1, ClientAnchor.FRow1Offs,
                        ClientAnchor.FCol1, ClientAnchor.FCol1Offs,
                        Height, Width,
                        ClientAnchor.FRow2, ClientAnchor.FRow2Offs,
                        ClientAnchor.FCol2, ClientAnchor.FCol2Offs);
       end;
    end;

    if Items[i] is TMsoShapeCheckBox then begin
       With TMsoShapeCheckBox(Items[i]) do begin
         FGetShapeRect2(ClientAnchor.FRow1, ClientAnchor.FRow1Offs,
                        ClientAnchor.FCol1, ClientAnchor.FCol1Offs,
                        Height, Width,
                        ClientAnchor.FRow2, ClientAnchor.FRow2Offs,
                        ClientAnchor.FCol2, ClientAnchor.FCol2Offs);
       end;
    end;

    if Items[i] is TMsoShapePicture then begin
       With TMsoShapePicture(Items[i]) do begin
         FGetShapeRect2(ClientAnchor.FRow1, ClientAnchor.FRow1Offs,
                        ClientAnchor.FCol1, ClientAnchor.FCol1Offs,
                        Height, Width,
                        ClientAnchor.FRow2, ClientAnchor.FRow2Offs,
                        ClientAnchor.FCol2, ClientAnchor.FCol2Offs);
       end;
    end;

    

    if Items[i] is TMsoShapeComboBox then begin
       With TMsoShapeComboBox(Items[i]) do begin
         FGetShapeRect2(ClientAnchor.FRow1, ClientAnchor.FRow1Offs,
                        ClientAnchor.FCol1, ClientAnchor.FCol1Offs,
                        Height, Width,
                        ClientAnchor.FRow2, ClientAnchor.FRow2Offs,
                        ClientAnchor.FCol2, ClientAnchor.FCol2Offs);
       end;
    end;

    if Items[i] is TMsoShapeListBox then begin
       With TMsoShapeListBox(Items[i]) do begin
         FGetShapeRect2(ClientAnchor.FRow1, ClientAnchor.FRow1Offs,
                        ClientAnchor.FCol1, ClientAnchor.FCol1Offs,
                        Height, Width,
                        ClientAnchor.FRow2, ClientAnchor.FRow2Offs,
                        ClientAnchor.FCol2, ClientAnchor.FCol2Offs);
       end;
    end;


    Items[i].Store(Data, DataList, AEncrypt);
  end;
  Result := 1;
end;


function TMsoShapeList.GetSize: integer;
var i: integer;
begin
  Result := 0;
  if Count > 0 then begin
    for i := 0 to Count - 1 do begin
      Inc(Result, Items[i].Size);
    end;
  end;
end;


{TXLSBiffWriter}

constructor TXLSBiffWriter.Create(DstList: TXLSBlobList; BiffRecSize: integer);
begin
 inherited Create;
 FDstList := DstList;
 FTotalLength := 0;
 FRestLength := 0;
 FBiffRecSize := BiffRecSize;
 FData := nil;
 FRestRecSize := 0; 
end;

procedure TXLSBiffWriter.StartNewBiff(RecID: word; RecLength: integer);
var sz: integer;
begin
  FTotalLength := RecLength;
  FRestLength := RecLength;
  sz := RecLength;
  if sz > FBiffRecSize then sz := FBiffRecSize;
  if Assigned(FData) then Flush;
  FData := TXLSBlob.Create(sz + 4);
  FData.AddWord(RecId);
  FData.AddWord(sz);
  FRestRecSize := sz;
end;

procedure TXLSBiffWriter.AddData(Data: TXLSBlob);
Var len: integer;
    cnt: integer;
    pos: integer;
begin
  if Not(Assigned(Data)) then exit;
  len := Data.DataLength;
  pos := 0;
  while len > 0 do begin
    cnt := len;
    if cnt > FRestRecSize then cnt := FRestRecSize;
    FData.CopyData(Data, pos, cnt);
    pos := pos + cnt;
    len := len - cnt;
    FRestRecSize := FRestRecSize - cnt;
    FRestLength := FRestLength - cnt;

    if FRestRecSize = 0 then begin
       Flush;
       if FRestLength > 0 then begin
          //new continue block
          FRestRecSize := FRestLength;
          if FRestRecSize > FBiffRecSize then FRestRecSize := FBiffRecSize;
          FData := TXLSBlob.Create(FRestRecSize + 4);
          FData.AddWord($003C); //Continue;
          FData.AddWord(FRestRecSize);
       end;
    end;
  end;
  Data.Free;
end;

procedure TXLSBiffWriter.Flush;
begin
  if Assigned(FData) then FDstList.Append(FData);
  FData := nil;
end;


{TMSODrawing}
constructor TMSODrawing.Create(ADrawingGroup: TMSODrawingGroup; AGetShapeRect: TGetShapeRect;
                      AGetShapeSize: TGetShapeSize;
                      AGetShapeRect2: TGetShapeRect2;
                      AGetCurRowCol: TGetCurRowCol;
                      AGetCustomColor: TGetCustomColor;
                      ASetAutofilterShape: TSetAutofilterShape;
                      ACalculator: TXLSCalculator;
                      ASheetID: integer);
begin
  inherited Create;
  FSheetID      := ASheetID;
  FCurObjectId  := 0;
  FDrawingGroup := ADrawingGroup;
  FParser := nil;
  FParserState   := psNone;
  

  FCalculator     := ACalculator;
  FGetShapeRect   := AGetShapeRect;
  FGetShapeSize   := AGetShapeSize;
  FGetShapeRect2  := AGetShapeRect2;
  FGetCurRowCol   := AGetCurRowCol;
  FGetCustomColor := AGetCustomColor;
  FSetAutofilterShape := ASetAutofilterShape;

  FShapeList := TMsoShapeList.Create(FGetShapeRect, FGetShapeRect2);
  FComments  := TXLSComments.Create(Self);
  FPictures  := TXLSShapes.Create(Self);
end;

destructor TMSODrawing.Destroy;
begin
  DrawingGroup.RemoveDrawing(FDrawingID);
  FParser.Free;
  
  FShapeList.Free;
  FComments.Free;
  FPictures.Free;
  inherited Destroy;
end;

function TMSODrawing.GetNewObjectID: integer;
begin
  Inc(FCurObjectId);
  Result := FCurObjectId;
end;

function TMSODrawing.GetCustomColor(ColorIndex: integer): LongWord;
begin
  Result := 0;
  if Assigned(FGetCustomColor) then Result := FGetCustomColor(ColorIndex);
end;


procedure TMSODrawing.UpdateCurObjectID(Value: integer);
begin
  if FCurObjectId < Value then FCurObjectId := Value;
end;

procedure TMSODrawing.OnStartParseItem(Sender: TObject; Header: TMSOHeader; isContainer: boolean; Var Skip: boolean);
begin
  case FParserState of
    //Initial state
    psNone: begin
      if Header.fbt = msofbtDgContainer then begin
        Skip := false;
        FParserState := psDgContainer;
      end else begin
        Skip := true;
      end;
    end;
    //Drawing container
    psDgContainer: begin
      case Header.fbt of

        msofbtDg: begin
          FParserState := psDg; 
        end;

        msofbtSpgrContainer: begin
          FParserState := psSpGrContainer; 
        end;         

        else begin
          Skip := true;
        end;
      end;
    end;

    //Shape Group Container
    psSpGrContainer: begin
      case Header.fbt of

        msofbtSpGrContainer: begin
           //inherited container group
          if Assigned(FCurParseShape) then begin
             FCurParseShape := nil; 
          end;
          Skip := true;  
        end;

        msofbtSpContainer: begin
          FParserState := psSpContainer; 
        end;

        else begin
          Skip := true; 
        end;
      end;
    end;

    //Shape Container
    psSpContainer: begin
      case Header.fbt of
        msofbtSp:  FParserState := psSp; 
        msofbtOpt: FParserState := psSpOpt; 
        msofbtTertiaryOpt: FParserState := psSpTertiaryOpt; 
        msofbtClientAnchor: FParserState := psClientAnchor; 
        else Skip := true; 
      end;
    end;

    else begin
      Skip := true;
    end; 
  end;
end;

procedure TMSODrawing.OnParseItem(Sender: TObject; Header: TMSOHeader; Data: TXLSBlob);
begin
  case FParserState of
    //Shape
    psSp: begin 

      if Assigned(FCurParseShape) then begin
         if FCurParseShape.ObjectID <= 0 then begin
           raise Exception.Create('Previous Shape is not parsed completely');
         end else begin
           FCurParseShape := nil;
         end;
      end;

      case Header.inst of
        //Picture
        msosptPictureFrame: begin
          FCurParseShape := TMSOShapePictureFrame.Create(self, Header, Data); 
        end;
        //Comment  
        msosptTextBox: begin
          FCurParseShape := TMSOShapeTextBox.Create(self, Header, Data);
        end;             
        //HostControl
        //it may be a chart
        msosptHostControl: begin
          FCurParseShape := TMSOShapeHostControl.Create(self, Header, Data); 
        end;

        msosptNotPrimitive: begin
           if FFirstShapeID = 0 then begin
               FFirstShapeID := Data.GetLong(0); 
           end;
        end;
      end;
    end;


    //Shape Options
    psSpOpt: begin 
      if Assigned(FCurParseShape) then begin
         FCurParseShape.Opt.ParseData(Header, Data);
      end;
    end;

    //Shape Options
    psSpTertiaryOpt: begin 
      if Assigned(FCurParseShape) then begin
         FCurParseShape.TertiaryOpt.ParseData(Header, Data);
      end;
    end;

    //Shape Client Anchor
    psClientAnchor: begin 
      if Assigned(FCurParseShape) then begin
         FCurParseShape.ClientAnchor.ParseData(Data);
      end;
    end;

    psDg: begin 
        FDrawingID := Header.inst;
        FDrawingGroup.Dgg.RegisterDrawing(FDrawingId);
    end;

  end;
end;


procedure TMSODrawing.OnEndParseItem(Sender: TObject; Header: TMSOHeader; isContainer: boolean);
begin
  case FParserState of
    //Initial state
    psNone: begin
      raise Exception.Create('psNone!!!');
    end;

    psDgContainer: begin
      FParserState := psNone;
    end;

    psDg: begin
      FParserState := psDgContainer;
    end;

    psSpGrContainer: begin
      FParserState := psDgContainer;
    end;

    psSpContainer: begin
      FParserState := psSpGrContainer;
      if Assigned(FCurParseShape) then begin
         if FCurParseShape.Sp.ShapeType = msosptPictureFrame then begin
//            FCurParseShape.Opt.DumpData;
         end;
         if FCurParseShape.Sp.ShapeType = msosptTextBox then begin
//            FCurParseShape.Opt.DumpData;
         end;
         if FCurParseShape.Sp.ShapeType = msosptHostControl then begin
//            FCurParseShape.Opt.DumpData;
         end;
      end;
    end;

    psSp: begin
      FParserState := psSpContainer;
    end;

    psSpOpt: begin
      FParserState := psSpContainer;
    end;

    psSpTertiaryOpt: begin
      FParserState := psSpContainer;
    end;

    psClientAnchor: begin
      FParserState := psSpContainer;
    end;

    else             raise Exception.Create('Unknown fbt parsed $' + inttohex(Header.fbt, 4));    
  end;
end;

procedure TMSODrawing.OnEndParse(Sender: TObject);
begin
  FParserState := psNone;
end;

procedure TMSODrawing.InitParser;
begin
  if Assigned(FParser) then FParser.Free;
  FParser := TXLSDrawingParser.Create;
  FParser.OnStartParseItem := self.OnStartParseItem;
  FParser.OnParseItem      := self.OnParseItem;
  FParser.OnEndParseItem   := self.OnEndParseItem;
  FParser.OnEndParse       := self.OnEndParse;
  FParserState := psNone;
end;

function TMSODrawing.Parse(DataList: TXLSBlobList): integer;
begin
  if not(Assigned(FParser)) then InitParser;
  FParser.Parse(DataList);

  if FParserState = psNone then begin
     FParser.Free;
     FParser := nil;
  end;

  Result := 1;
end;

function TMSODrawing.Parse(DataList: TXLSBlobList; StartIndex: integer): integer;
begin
  if not(Assigned(FParser)) then InitParser;

  FParser.Parse(DataList, StartIndex);

  if FParserState = psNone then begin
     FParser.Free;
     FParser := nil;
  end;

  Result := 1;
end;


function TMSODrawing.ParseObj(DataList: TXLSBlobList): integer;
Var Tmp: TMSOShapeContainer;
begin
  Result := -1;
  if Assigned(FCurParseShape) then begin
     Result := FCurParseShape.ParseObj(DataList[0]);
     if Result = 1 then begin
       UpdateCurObjectId(FCurParseShape.ObjectId); 
       if FCurParseShape is TMSOShapeHostControl then begin
          //it may be a chart
          if  FCurParseShape.ObjectType = $0005 then begin
             Tmp := FCurParseShape;
             FCurParseShape := TMSOShapeChart.Create(Tmp as TMSOShapeHostControl);
             Tmp.Free();
          {Checkbox} 
          end else if  FCurParseShape.ObjectType = $000B then begin
             Tmp := FCurParseShape;
             FCurParseShape := TMSOShapeCheckBox.Create(Tmp as TMSOShapeHostControl);
             Tmp.Free();
          end else if  FCurParseShape.ObjectType = $0008 then begin
             Tmp := FCurParseShape;
             FCurParseShape := TMSOShapePicture.Create(Tmp as TMSOShapeHostControl);
             FCurParseShape.ParseObj(DataList[0]); 
             Tmp.Free();
          {ComboBox} 
          end else if  FCurParseShape.ObjectType = $0014 then begin
             Tmp := FCurParseShape;
             FCurParseShape := TMSOShapeComboBox.Create(Tmp as TMSOShapeHostControl);
             FCurParseShape.ParseObj(DataList[0]); 

             if not(TMSOShapeComboBox(FCurParseShape).IsAutofilter) then begin
                //only autofilter!!!! 
                // FCurParseShape.Free; 
                // FCurParseShape := nil; 
             end else begin
                if Assigned(FSetAutofilterShape) then begin
                   With TMSOShapeComboBox(FCurParseShape) do begin
                       FSetAutofilterShape(Row, Col, FCurParseShape)
                   end;
                end;
             end;
             
             Tmp.Free();
          {ListBox} 
          end else if  FCurParseShape.ObjectType = $0012 then begin
             Tmp := FCurParseShape;
             FCurParseShape := TMSOShapeListBox.Create(Tmp as TMSOShapeHostControl);
             FCurParseShape.ParseObj(DataList[0]); 
             Tmp.Free();
          end else begin
             //other TMSOShapeHostControl for example checkbox etc.
             FCurParseShape.Free; 
             FCurParseShape := nil; 
          end;
       end;

       if Assigned(FCurParseShape) then begin
          if FCurParseShape.ObjectType = $0006 then begin
             //TextBox conflicts with comment. Fix
             FCurParseShape.Free; 
             FCurParseShape := nil; 
          end;
       end;

       FShapeList.AddItem(FCurParseShape);
     end else begin
       FCurParseShape.Free; 
       FCurParseShape := nil; 
     end;
  end;
  if DataList.Count > 1 then begin
     Parse(DataList, 1);
  end;
end;

function TMSODrawing.ParseTXO(DataList: TXLSBlobList; ADecrypt: boolean): integer;
var data: TXLSBlob;
    skiptxo: boolean;
begin
  Result := -1;

  skiptxo := false;

  if DataList.Count > 1 then begin
     data := DataList[1];
     if data.GetByte(0) = $0F then skiptxo := true;
  end;


  if Assigned(FCurParseShape) and not(skiptxo) then begin
     
       if FCurParseShape is TMSOShapeTextBox then begin
         Result := TMSOShapeTextBox(FCurParseShape).ParseTXO(DataList, ADecrypt); 
       end;
       if FCurParseShape is TMSOShapeCheckBox then begin
         Result := TMSOShapeCheckBox(FCurParseShape).ParseTXO(DataList); 
       end;
       if FCurParseShape is TMSOShapePicture then begin
         Result := TMSOShapePicture(FCurParseShape).ParseTXO(DataList); 
       end;
//    if FCurParseShape is TMSOShapeComboBox then begin
//      Result := TMSOShapeComboBox(FCurParseShape).ParseTXO(DataList); 
//    end;
  end;

  if skiptxo then begin
     Parse(DataList, 1);
  end else if DataList.Count > 3 then begin
     //it may be a bug in excel file 003C(continue) instead of 00EC(drawing)
     Parse(DataList, 3);
  end;

end;


function TMSODrawing.SetNoteData(AObjId: Word; ARow, ACol: Word; AOptions: Word; AAuthor: WideString): integer;
Var Shape: TMsoShapeContainer;
begin
  Result := -1;
  Shape := TMsoShapeContainer(Shapes.ShapeByObjId[AObjID]);
  if Assigned(Shape) then begin
    if Shape is TMSOShapeTextBox then begin
      Result := TMSOShapeTextBox(Shape).SetNoteData(ARow, ACol, AOptions, AAuthor);
    end;
  end else begin

  end; 
end;

procedure TMSODrawing.PrepareStore;
Var cnt, i: integer;
begin
  //FCurObjectId := 0;
  cnt := Shapes.Count;
  if cnt > 0 then begin
    FDrawingGroup.Dgg.RegisterDrawing(FDrawingId);

    if FFirstShapeID = 0 then begin
       FFirstShapeID := GetNewShapeId;
    end;
    FDrawingGroup.Dgg.RegisterSavedShapeID(FFirstShapeID);

    for i := 0 to cnt - 1 do begin
      //reset shape id
      if Shapes[i].Sp.ShapeID = 0 then begin
         Shapes[i].Sp.ShapeID  := GetNewShapeId;
      end;
      FDrawingGroup.Dgg.RegisterSavedShapeID(Shapes[i].Sp.ShapeID);

      //reset object id
      //Shapes[i].ObjectID  := GetNewObjectId;

      if Shapes[i] is TMSOShapePictureFrame then begin
         //!!!!
         //change PictureId ref count; 
      end;
    end;
  end;
end;

function TMSODrawing.GetNewShapeId: longword;
begin
  if FDrawingId <= 0 then begin
     FDrawingGroup.Dgg.RegisterDrawing(FDrawingId);
  end;
  FCurShapeID := FDrawingGroup.Dgg.GetShapeId(FDrawingId);
  Result := FCurShapeID;
end;

function TMSODrawing.FinalizeParse: integer;
Var i, cnt: integer;
begin
  FParser.Free;
  FParser := nil;

  cnt := Shapes.Count;
  if cnt > 0 then begin
     for i := 0 to cnt - 1 do begin
       if Shapes[i] is TMsoShapeTextBox then begin
          Comments.RegisterComment(Shapes[i]);
          With TMsoShapeTextBox(Shapes[i]) do begin
             FGetShapeSize(ClientAnchor.Row1, ClientAnchor.Row1Offs,
                           ClientAnchor.Row2, ClientAnchor.Row2Offs,
                           ClientAnchor.Col1, ClientAnchor.Col1Offs,
                           ClientAnchor.Col2, ClientAnchor.Col2Offs,
                           FWidth, FHeight);
          end;
       end;
       if Shapes[i] is TMsoShapePictureFrame then begin
          Pictures.RegisterPicture(Shapes[i]);
          With TMsoShapePictureFrame(Shapes[i]) do begin
             FGetShapeSize(ClientAnchor.Row1, ClientAnchor.Row1Offs,
                           ClientAnchor.Row2, ClientAnchor.Row2Offs,
                           ClientAnchor.Col1, ClientAnchor.Col1Offs,
                           ClientAnchor.Col2, ClientAnchor.Col2Offs,
                           FWidth, FHeight);
          end;
       end;


       if Shapes[i] is TMsoShapeChart then begin
          //!!!!Charts.RegisterChart(Shapes[i]);
          With TMsoShapeChart(Shapes[i]) do begin
             FGetShapeSize(ClientAnchor.Row1, ClientAnchor.Row1Offs,
                           ClientAnchor.Row2, ClientAnchor.Row2Offs,
                           ClientAnchor.Col1, ClientAnchor.Col1Offs,
                           ClientAnchor.Col2, ClientAnchor.Col2Offs,
                           FWidth, FHeight);
          end;
       end;

       if Shapes[i] is TMsoShapeCheckBox then begin
          //!!!!CheckBoxes.RegisterCheckBox(Shapes[i]);
          With TMsoShapeCheckbox(Shapes[i]) do begin
             FGetShapeSize(ClientAnchor.Row1, ClientAnchor.Row1Offs,
                           ClientAnchor.Row2, ClientAnchor.Row2Offs,
                           ClientAnchor.Col1, ClientAnchor.Col1Offs,
                           ClientAnchor.Col2, ClientAnchor.Col2Offs,
                           FWidth, FHeight);
          end;
       end;

       if Shapes[i] is TMsoShapePicture then begin
          With TMsoShapePicture(Shapes[i]) do begin
             FGetShapeSize(ClientAnchor.Row1, ClientAnchor.Row1Offs,
                           ClientAnchor.Row2, ClientAnchor.Row2Offs,
                           ClientAnchor.Col1, ClientAnchor.Col1Offs,
                           ClientAnchor.Col2, ClientAnchor.Col2Offs,
                           FWidth, FHeight);
          end;
       end;


       //!!!!!!!!!!!!!!!!!!!!!
       if Shapes[i] is TMsoShapeComboBox then begin
          //!!!!ComboBoxes.RegisterComboBox(Shapes[i]);
          With TMsoShapeCombobox(Shapes[i]) do begin
             FGetShapeSize(ClientAnchor.Row1, ClientAnchor.Row1Offs,
                           ClientAnchor.Row2, ClientAnchor.Row2Offs,
                           ClientAnchor.Col1, ClientAnchor.Col1Offs,
                           ClientAnchor.Col2, ClientAnchor.Col2Offs,
                           FWidth, FHeight);
          end;
       end;

       if Shapes[i] is TMsoShapeListBox then begin
          //!!!!ComboBoxes.RegisterListBox(Shapes[i]);
          With TMsoShapeListbox(Shapes[i]) do begin
             FGetShapeSize(ClientAnchor.Row1, ClientAnchor.Row1Offs,
                           ClientAnchor.Row2, ClientAnchor.Row2Offs,
                           ClientAnchor.Col1, ClientAnchor.Col1Offs,
                           ClientAnchor.Col2, ClientAnchor.Col2Offs,
                           FWidth, FHeight);
          end;
       end;


     end;
  end;
  Result := 1;
end;


function TMSODrawing.SetChartData(ChartData: TXLSCustomChart): integer;
begin
  Result := -1;
  if Assigned(FCurParseShape) then begin
    if FCurParseShape is TMSOShapeChart then begin
      Result := TMSOShapeChart(FCurParseShape).SetChartData(ChartData); 
    end;
  end;

  if Result <> 1 then begin
     ChartData.Free;
  end;

end;




function  TMSODrawing.GetRootSize: integer;
begin
  Result := 0;
  if Shapes.Count > 0 then begin
     Inc(Result, msoHeaderSize); //msofbtDgContainer
       Inc(Result, msoHeaderSize); //msofbtDg
         Inc(Result, 8);
       Inc(Result, msoHeaderSize); //msofbtSpgrContainer
         Inc(Result, msoHeaderSize); //msofbtSpContainer
           Inc(Result, msoHeaderSize); //msofbtSpgr
             Inc(Result, 16);
           Inc(Result, msoHeaderSize); //msofbtSp
             Inc(Result, 8);
  end;
end;


function  TMSODrawing.GetSize: integer;
begin
  Result := 0;
  if Shapes.Count > 0 then begin
     Result := GetRootSize;
     Inc(Result, Shapes.Size);
  end;
end;

function TMSODrawing.AddDg(Data: TXLSBlob): integer;
begin
  AddHeader(Data, $00, FDrawingId, msofbtDg, 8);
  Data.AddLong(Shapes.Count + 1);
  Data.AddLong(FCurShapeId);
  Result := 1;
end;

function TMSODrawing.Store(DataList: TXLSBlobList; BiffRecSize: integer; AEncrypt: boolean): integer;
Var Sz: integer;
    Data: TXLSBlob;
begin
  Result := 1;
  Sz := Size;
  if Sz > 0 then begin
//    try
      Data := TXLSBlob.Create(BiffRecSize + 4);
      Data.AddWord($00EC); Data.AddWord($0000);
      Dec(Sz, msoHeaderSize);
      AddHeader(Data, $0F, $0000, msofbtDgContainer, Sz);

      AddDg(Data); 
      Dec(Sz, msoHeaderSize + 8);

      Dec(Sz, msoHeaderSize);
      AddHeader(Data, $0F, $0000, msofbtSpgrContainer, Sz);

      AddHeader(Data, $0F, $0000, msofbtSpContainer, 40);
        AddHeader(Data, $01, $0000, msofbtSpgr, 16);
          Data.AddLong($00000000);Data.AddLong($00000000);
          Data.AddLong($00000000);Data.AddLong($00000000); 
        AddHeader(Data, $02, msosptNotPrimitive, msofbtSp, 8);  
          Data.AddLong(FFirstShapeID);
          Data.AddLong(spoGroup or spoPatriarch);

      Shapes.Store(Data, DataList, AEncrypt);

  //!!!  finally
      Data.Free;
//    end;
  end;
end;

function TMSODrawing.StoreNotes(DataList: TXLSBlobList; ABiffVersion: word): integer;
var i, cnt: integer;
    lSize: integer;
    Data: TXLSBlob;
    lLen: integer;
begin
  cnt := Shapes.Count;
  if cnt > 0 then begin
    if ABiffVersion >= $0600 then begin
      lSize := 4 + 8 + 4;
      Data := TXLSBlob.Create(lSize);

      for i := 0 to cnt - 1 do begin
        if Shapes[i] is TMSOShapeTextBox then begin
           with TMSOShapeTextBox(Shapes[i]) do begin
             Data.AddWord($001C); Data.AddWord(lSize - 4);
             Data.AddWord(Row);
             Data.AddWord(Col);
             Data.AddWord(FOptions);
             Data.AddLong(ObjectId);
             Data.AddWord(0);
             DataList.Append(Data, true);
             Data.Reset;
           end;
        end;
      end;
      Data.Free;
    end else begin
      for i := 0 to cnt - 1 do begin
        if Shapes[i] is TMSOShapeTextBox then begin
           with TMSOShapeTextBox(Shapes[i]) do begin
             lLen := Length(Text);
             lSize := 4 + 4 + 2 + lLen;
             if (lLen < 2048) then begin   //!!!!!
                Data := TXLSBlob.Create(lSize);
                Data.AddWord($001C);        //Record identifier
                Data.AddWord(lSize - 4);    //Number of bytes to follow
                Data.AddWord(Row);
                Data.AddWord(Col);  
                Data.AddWord(lLen);
                
                Data.AddString({$ifdef D2009}AnsiString(Text){$else}Text{$endif});
                DataList.Append(Data);
             end;
           end;
        end;
      end;
    end;
  end;
  Result := 1;
end;


// ----------->  Start 31/01/2006	Gamma Computer snc Settino T. Italy
function TMSODrawing.AddPicture(AFileName: WideString): TMSOShapePictureFrame;
var Pict: TMsoPicture;  
    Row, Col: Word; 
    Ret: Integer;
    Width, Height: Double;
begin
  Result := nil;

  Ret := GetImageSize(AFileName, Width, Height);

  if Ret <> 1 then begin
     Height := 100;
     Width := 100;
  end;
//  Width := (Width * 1.1296296296296296296296296296296) ;
  Pict := FDrawingGroup.Pictures.LoadFromFile(AFileName);

  if Assigned(Pict) then begin

    if Ret = 7 then begin
      Height := Pict.FBSEWMF.Height;
      Width  := Pict.FBSEWMF.Width;
//      Width := (Width * 1.1296296296296296296296296296296) ;
    end;

    Result := TMSOShapePictureFrame.Create(self, 2, msosptPictureFrame, (spoHaveAnchor or spoHaveSpt));
    FGetCurRowCol(Row, Col);
    Result.Width  := Width;
    Result.Height := Height;
    Result.SetDefault(Row, Col);
    Result.PictureID := Pict.BlipID + 1;
    Shapes.AddItem(Result);
  end;

end;

function TMSODrawing.AddPicture(Bitmap: TBitmap): TMSOShapePictureFrame;
var Pict: TMsoPicture;
    Row, Col: Word;
    Width, Height: Double;
begin
  Result := nil;
  if Bitmap.PixelFormat in [PfDevice, pf32Bit] then Bitmap.PixelFormat := Pf24bit;  

  if GetBmpSizeStream(Bitmap, Width, Height) <> 1 then begin
     Height := 100;
     Width := 100;
  end;
//  Width := (Width * 1.1296296296296296296296296296296) ;
  Pict := FDrawingGroup.Pictures.LoadFromFileBmp(Bitmap);

  if Assigned(Pict) then begin
    Result := TMSOShapePictureFrame.Create(self, 2, msosptPictureFrame, (spoHaveAnchor or spoHaveSpt));
    FGetCurRowCol(Row, Col);
    Result.Width  := Width;
    Result.Height := Height;
    Result.SetDefault(Row, Col);
    Result.PictureID := Pict.BlipID + 1;
    Shapes.AddItem(Result);
  end;
end;


function TMSODrawing.AddComment(ARow, ACol: integer): TMSOShapeTextBox;
begin
  Result := TMSOShapeTextBox.Create(self, 2, msosptTextBox, (spoHaveAnchor or spoHaveSpt));
  Result.SetDefault(ARow, ACol);
  Shapes.AddItem(Result);
end;

function TMSODrawing.AddAutofilterShape(ARow, ACol: integer): TMSOShapeComboBox;
begin
  Result := TMSOShapeComboBox.Create(self, ARow, ACol, true);
  Shapes.AddItem(Result);
end;



procedure TMsoDrawing.DeleteShape(Item: TMsoShapeContainer);
begin
  Shapes.DeleteShape(Item);
end;


{TMSOShapeContainer}
constructor TMSOShapeContainer.Create(ADrawing: TMSODrawing; AVer: byte; AShapeType: Word; APersistent: longword);
begin
  inherited Create;
  FSp := TMsoFbtSp.Create(AVer, AShapeType, APersistent);
  FOpt := nil;
  FClientAnchor := nil;
  FDrawing := ADrawing; 
  FObjectId := FDrawing.GetNewObjectId;
  FObjRecftPictFrmla := nil;
end;

constructor TMSOShapeContainer.Create(ADrawing: TMSODrawing; Header: TMSOHeader; ShapeData: TXLSBlob);
begin
  inherited Create;
  FSp := TMsoFbtSp.Create(Header, ShapeData);
  FOpt := nil;
  FClientAnchor := nil;
  FDrawing := ADrawing; 
  FObjRecftPictFrmla := nil;
end;

constructor TMSOShapeContainer.Create(ShapeContainer: TMsoShapeContainer);
begin
  inherited Create;
  Assign(ShapeContainer);
end;


destructor TMSOShapeContainer.Destroy; 
begin
  FOpt.Free;
  FTertiaryOpt.Free;
  FClientAnchor.Free;
  FSp.Free;
  FObjRecftPictFrmla.Free;
  inherited Destroy;
end;


procedure TMSOShapeContainer.Assign(ShapeContainer: TMsoShapeContainer);
begin
  self.FSp           := ShapeContainer.FSp;
  self.FOpt          := ShapeContainer.FOpt;
  self.FClientAnchor := ShapeContainer.FClientAnchor;
  self.FObjectType   := ShapeContainer.FObjectType;
  self.FObjectID     := ShapeContainer.FObjectID;
  self.FObjectOptions:= ShapeContainer.FObjectOptions;
  self.FWidth        := ShapeContainer.FWidth;
  self.FHeight       := ShapeContainer.FHeight;
  self.FDrawing      := ShapeContainer.FDrawing;
  self.FObjRecftPictFrmla         := ShapeContainer.FObjRecftPictFrmla;

  ShapeContainer.FSp := nil;          
  ShapeContainer.FOpt := nil;         
  ShapeContainer.FClientAnchor := nil;
  ShapeContainer.FObjectID := 0;    
  ShapeContainer.FDrawing := nil;   
  ShapeContainer.FObjRecftPictFrmla := nil;

end;

function TMSOShapeContainer.GetOpt: TMsoFbtOpt;
begin
  if not(Assigned(FOpt)) then FOpt := TMsoFbtOpt.Create;
  Result := FOpt;
end;

function TMSOShapeContainer.GetTertiaryOpt: TMsoFbtOpt;
begin
  if not(Assigned(FTertiaryOpt)) then FTertiaryOpt := TMsoFbtOpt.Create;
  Result := FTertiaryOpt;
end;

function TMSOShapeContainer.GetClientAnchor: TMsoFbtClientAnchor;
begin
  if not(Assigned(FClientAnchor)) then FClientAnchor := TMsoFbtClientAnchor.Create;
  Result := FClientAnchor;
end;

function TMSOShapeContainer.GetCustomColor(ColorIndex: integer): Longword;
begin
  Result := 0;
  if Assigned(FDrawing) then Result := FDrawing.GetCustomColor(ColorIndex);
end;


function TMSOShapeContainer.GetVisible: boolean;
begin
  Result := (Opt.LongValue[optfPrint] and $00000002) = $00000000
end;

procedure TMSOShapeContainer.SetVisible(Value: boolean);
Var v: longword;
begin
  v := Opt.LongValue[optfPrint];
  v := v and not($00000002);
  if not(Value) then v := v or $00000002;
  Opt.LongValue[optfPrint] := v;
end;

procedure TMSOShapeContainer.Flush(Data: TXLSBlob; DataList: TXLSBlobList);
begin
  if Data.DataLength > 0 then begin
     Data.SetWord(Data.DataLength - 4, 2);
     DataList.Append(Data, true);
     Data.Reset; 
  end;
end;


function TMSOShapeContainer.Store(Data: TXLSBlob; DataList: TXLSBlobList; AEncrypt: boolean): integer;
Var Sz: integer;
begin
  Sz := Size;
  if Sz > 0 then begin
    if Data.DataLength = 0 then begin
       Data.AddWord($00EC); Data.AddWord($0000);
    end;
    Dec(Sz, msoHeaderSize);
    AddHeader(Data, $0F, $0000, msofbtSpContainer, Sz);
    Sp.AddData(Data);
    Opt.AddData(Data);
    if Assigned(FTertiaryOpt) then FTertiaryOpt.AddData(Data);
    ClientAnchor.AddData(Data);
    //add client data
    AddHeader(Data, $00, $0000, msofbtClientData, 0);
  end;
  Result := 1;
end;

function TMSOShapeContainer.GetDgSize: integer;
begin
  Result := msoHeaderSize     +    //msofbtSpContainer
            Sp.Size           +    //msofbtSp
            Opt.Size          +    //msofbtOpt
            ClientAnchor.Size +    //msofbtClientAnchor
            msoHeaderSize;         //msofbtClientData    
  if Assigned(FTertiaryOpt) then Result := Result + FTertiaryOpt.Size;
end;

function TMSOShapeContainer.GetDataSize: integer;
begin
  Result := GetDgSize;
end;

procedure TMSOShapeContainer.Move(drow, dcol: integer);
var r,c: integer;
begin
  r := FClientAnchor.Row1 + drow;
  if r < 0 then r := 0;
  if r > $FFFF then r := $FFFF;
  FClientAnchor.Row1 := r;

  r := FClientAnchor.Row2 + drow;
  if r < 0 then r := 0;
  if r > $FFFF then r := $FFFF;
  FClientAnchor.Row2 := r;

  c := FClientAnchor.Col1 + dcol;
  if c < 0 then c := 0;
  if c > $FF then c := $FF;
  FClientAnchor.Col1 := c;

  c := FClientAnchor.Col2 + dcol;
  if c < 0 then c := 0;
  if c > $FF then c := $FF;
  FClientAnchor.Col2 := c;
end;


function TMSOShapeContainer.ParseObj(Data: TXLSBlob): integer;
var len: integer;
    pos: integer;
    RecId, RecLen: word;
begin
  len := Data.DataLength;
  pos := 0;
  Result := -1;
  while (len - pos) >= 4 do begin
    RecId  := Data.GetWord(Pos); Inc(pos, 2);
    RecLen := Data.GetWord(Pos); Inc(pos, 2);
    case RecID of 
      $0000 {OBJREC_END}: break;
      $0015 {OBJREC_CMO}: begin
         FObjectType := Data.GetWord(pos + 0);
         FObjectID := Data.GetWord(pos + 2);
         FObjectOptions := Data.GetWord(pos + 4);
         Result := 1;
      end;

      $0009: begin
             FObjRecftPictFrmla := TObjFormula.Create();
             FObjRecftPictFrmla.ParseObj(RecID, RecLen, Data, pos, FDrawing);
      end;
    end;
    Inc(pos, RecLen);
  end;
end;


{TMSOShapeTextBox}
procedure TMSOShapeTextBox.SetDefault(ARow, ACol: integer);
begin
  FRow := ARow;
  FCol := ACol;

  FWidth  := 96;
  FHeight := 55.5;
  FObjectType := $19; {comment}
//  FSp.Free;
//  FSp := TMsoFbtSp.Create(2, msosptTextBox, (spoHaveAnchor or spoHaveSpt));

  Opt.LongValue[optLTxid]           := $00BF0000;
  Opt.LongValue[optTxdir]           := $00000002;
  Opt.LongValue[optfFitTextToShape] := $00080008;
  Opt.LongValue[optFillColor]       := $08000050;
  Opt.LongValue[optFillBackColor]   := $08000050;
  Opt.LongValue[optfNoFillHitTest]  := $00100010;
  Opt.LongValue[optShadowColor]     := $00000000;
  Opt.LongValue[optfShadowObscured] := $00030003;
  Opt.LongValue[optfPrint]          := $00020002;

  FClientAnchor.Free;
  FClientAnchor := TMsoFbtClientAnchor.Create;
end;


function TMSOShapeTextBox.GetDgSize: integer;
begin
  Result := inherited GetDgSize;
  if Result > 0 then Inc(Result, 8);
end;

function TMSOShapeTextBox.GetDataSize: integer;
begin
  Result := 0;
end;

function TMSOShapeTextBox.SetNoteData(ARow, ACol: Word; AOptions: Word; AAuthor: WideString): integer;
begin
  FRow := ARow;
  FCol := ACol;
  FOptions := AOptions;
  FAuthor  := AAuthor;
  //!!! change hash (row, col)
  Result := 1;
end;

function TMSOShapeTextBox.GetVisible: boolean; 
const btMask = $0002;
begin
  Result := ((FOptions and btMask) = btMask);
end;

procedure TMSOShapeTextBox.SetVisible(Value: boolean);
const btMask = $0002;
begin
  inherited SetVisible(Value);
  FOptions := FOptions and not(btMask);
  if Value then FOptions := FOptions or btMask;
end;



function TMSOShapeTextBox.AddObj(Data: TXLSBlob; ObjType, ObjId, Options: word): integer;
var Sz: word;
    i: integer;
begin
   //ObjPicture
   Sz := $1A;
   Data.AddWord($005D); Data.AddWord(Sz);
   Data.AddWord($0015); Data.AddWord($0012); 
     Data.AddWord(ObjType);
     Data.AddWord(ObjId);
     Data.AddWord(Options);
     for i := 0 to 11 do Data.AddByte($00);

   Data.AddWord($0000); Data.AddWord($0000); 
   Result := 1;
end;


function TMSOShapeTextBox.Store(Data: TXLSBlob; DataList: TXLSBlobList; AEncrypt: boolean): integer;
Var lSize: integer;
    lLen: Word;
begin
  Result := inherited Store(Data, DataList, AEncrypt);
  Flush(Data, DataList);
  //Object
  AddObj(Data, FObjectType, FObjectID, $6011);
  Flush(Data, DataList);
  //
  Data.AddWord($00EC); Data.AddWord($0000);
  AddHeader(Data, $0, $000, msofbtClientTextbox, 0);
  Flush(Data, DataList);

  //01B6
  lSize := $12;
  lLen := Length(FText);
  Data.AddWord($01B6); Data.AddWord(lSize);
  Data.AddWord($0012);
  Data.AddLong($0);
  Data.AddLong($0);
  Data.AddWord(lLen);
  if lLen > 0 then begin
     Data.AddWord($0010); 
  end else begin
     Data.AddWord($0000); 
  end;
  Data.AddLong($0);
  Flush(Data, DataList);
  if lLen > 0 then begin
    //Continue (Comment text)
    lSize := 4 + 1 + lLen * 2;
    Data.AddWord($003C); Data.AddWord(lSize - 4);
    Data.AddByte($01);   Data.AddWideString(FText);
    if AEncrypt then DataEncrypt(Data); 
    Flush(Data, DataList);
    //Continue  formating runs
    lSize := $10 +  4;
    Data.AddWord($003C); Data.AddWord(lSize - 4);
    Data.AddWord($0000); Data.AddWord($0000); Data.AddLong($0000);
    Data.AddWord(lLen);  Data.AddWord($0000); Data.AddLong($0000);
    Flush(Data, DataList);
  end;
end;

function TMSOShapeTextBox.ParseTXO(DataList: TXLSBlobList; ADecrypt: boolean): integer;
Var Data: TXLSBlob;
begin  
  Result := -1;
  if Assigned(DataList) then begin
     if DataList.Count > 1 then begin
       Data := DataList[1];
       if ADecrypt then DataDecrypt(Data); 
       With Data do begin
         if (GetByte(0) and $01) = $01 then begin
           FText := GetWideString(1, DataLength - 1);
         end else begin
           FText := widestring(GetString(1, DataLength - 1));
         end; 
       end;
       Result := 1;
     end;
  end;
end;


{TMSOShapePictureFrame}
constructor TMSOShapePictureFrame.Create(ADrawing: TMSODrawing; AVer: byte; AShapeType: Word; APersistent: longword);
begin
  inherited Create(ADrawing, AVer, AShapeType, APersistent);
  ftCfValue := $FFFF;
  ftPioGrbit := $0000;
end;

constructor TMSOShapePictureFrame.Create(ADrawing: TMSODrawing; Header: TMSOHeader; ShapeData: TXLSBlob); 
begin
  inherited Create(ADrawing, Header, ShapeData);
  ftCfValue := $FFFF;
  ftPioGrbit := $0000;
end;

function TMSOShapePictureFrame.GetDgSize: integer;
begin
  Result := inherited GetDgSize;
end;

function TMSOShapePictureFrame.GetDataSize: integer;
begin
  //!!!!!
  Result := -1;
end;

procedure TMSOShapePictureFrame.SetDefault(ARow, ACol: integer);
begin
  FObjectType := $0008; {Picture}
  FClientAnchor.Free;
  FClientAnchor := TMsoFbtClientAnchor.Create;
  FClientAnchor.SetClientAnchor(ARow, 0, ACol, 0, ARow, 10, ACol, 10);
  Opt.LongValue[optfPrint]          := $00080000;
end;

function TMSOShapePictureFrame.AddObj(Data: TXLSBlob; ObjType, ObjId, Options: word): integer;
var Sz: word;
    i: integer;
    ObjRecftPictFrmla: TXLSBlob;
begin
   //ObjPicture
   Sz := $1A;
   ObjRecftPictFrmla := nil;

   if Assigned(FObjRecftPictFrmla) then begin
      ObjRecftPictFrmla := FObjRecftPictFrmla.GetData(FDrawing);
      if Assigned(ObjRecftPictFrmla) then begin
         Sz := Sz +  ObjRecftPictFrmla.DataLength;
      end;
   end;

   if (ftCfValue >= 0) then Inc(Sz, 6);
   if (ftPioGrbit >= 0) then Inc(Sz, 6);

   Data.AddWord($005D); Data.AddWord(Sz);
   Data.AddWord($0015); Data.AddWord($0012); 
     Data.AddWord(ObjType);
     Data.AddWord(ObjId);
     Data.AddWord(Options);
     for i := 0 to 11 do Data.AddByte($00);

   //OBJREC_CF
   if ftCfValue >= 0 then begin
       data.AddWord($0007);
       data.AddWord($0002); 
       data.AddWord(ftCfValue);
   end;

   //OBJREC_PIOGRBIT
   if ftPioGrbit >= 0 then begin
       data.AddWord($0008);
       data.AddWord($0002); 
       data.AddWord(ftPioGrbit);
   end;


   if Assigned(ObjRecftPictFrmla) then begin
      Data.CopyData(ObjRecftPictFrmla);
      ObjRecftPictFrmla.Free;
   end;

   Data.AddWord($0000); Data.AddWord($0000); 
   Result := 1;
end;


function TMSOShapePictureFrame.Store(Data: TXLSBlob; DataList: TXLSBlobList; AEncrypt: boolean): integer;
begin
  Result := inherited Store(Data, DataList, AEncrypt);
  Flush(Data, DataList);
  //Object
  AddObj(Data, FObjectType, FObjectID, $6011);
  Flush(Data, DataList); 
end;

function TMSOShapePictureFrame.GetPictureId: integer;
begin
  Result := Opt.LongValue[optPib];
end;

procedure TMSOShapePictureFrame.SetPictureId(Value: integer);
begin
  Opt.LongValue[optPib] := Value;
  Opt[optPib].isBlipId := true;
end;


function TMSOShapePictureFrame.GetVisible: boolean;
begin
  Result := (Opt.LongValue[optfPrint] and $00000002) = $00000000
end;

procedure TMSOShapePictureFrame.SetVisible(Value: boolean);
const btMask = $00020002;
Var v: longword;
begin
  if Opt.isDefined[optfPrint] then v := Opt.LongValue[optfPrint]
                              else v := $00080000;
  v := v and not(btMask);
  if not(Value) then v := v or btMask;
  Opt.LongValue[optfPrint] := v;
end;

// -----> GC
procedure TMSOShapePictureFrame.SetTransparentColor(Value: Longword);
begin
  Opt.LongValue[optPictureTransparent] := Value;
end;

function TMSOShapePictureFrame.GetTransparentColor: Longword;
begin
  Result := Opt.LongValue[optPictureTransparent];
end;

function TMSOShapePictureFrame.GetTransparentColorDefined: boolean;
begin
 Result := Opt.isDefined[optPictureTransparent];
end;

procedure TMSOShapePictureFrame.ClearTransparentColor;
begin
  if TransparentColorDefined then begin
     Opt.DeleteItem(optPictureTransparent);
  end;
end;

function TMSOShapePictureFrame.ParseObj(Data: TXLSBlob): integer;
var offs: integer;
    len: integer;
    rec: word;
    reclen: word;
    lend: boolean;
begin  
  Result := inherited ParseObj(Data);

  offs := 0;
  len := Data.DataLength;
  lend := false;

  while ((offs + 4) <= len) and not(lend) do begin
     rec := Data.GetWord(offs);
     reclen := Data.GetWord(offs + 2);   
     offs := offs + 4;
     case rec of
        $0000: begin  {OBJREC_END}
                  lend := true;
               end;
        $0015: begin
               end;
        $0007: begin
                  ftCfValue := Data.GetWord(offs);
               end;
        $0008: begin
                  ftPioGrbit := Data.GetWord(offs);
               end;
     end; 
     offs := offs + reclen;
  end;   
end;



function TMSOShapePictureFrame.GetPicture: TMSOPicture;
begin
   Result := FDrawing.DrawingGroup.Pictures[PictureID - 1];
end;

destructor TMSOShapePictureFrame.Destroy;
begin
  inherited Destroy;
end;


{TMSOShapeChart}
constructor TMSOShapeChart.Create(HostControl: TMSOShapeHostControl);
begin
  inherited Create(HostControl);
end;

destructor TMSOShapeChart.Destroy;
begin
  FChart.Free;
  inherited Destroy;
end;

function TMSOShapeChart.AddObj(Data: TXLSBlob; ObjType, ObjId, Options: word): integer;
var Sz: word;
    i: integer;
begin
   //ObjPicture
   Sz := $1A;
   Data.AddWord($005D); Data.AddWord(Sz);
   Data.AddWord($0015); Data.AddWord($0012); 
     Data.AddWord(ObjType);
     Data.AddWord(ObjId);
     Data.AddWord(Options);
     for i := 0 to 11 do Data.AddByte($00);

   Data.AddWord($0000); Data.AddWord($0000); 
   Result := 1;
end;

function TMSOShapeChart.SetChartData(Value: TXLSCustomChart): integer;
begin
  if Assigned(FChart) then begin
     FChart.Free;
  end;
  FChart := Value;
  Result := 1;
end;

function TMSOShapeChart.Store(Data: TXLSBlob; DataList: TXLSBlobList; AEncrypt: boolean): integer;
begin
  Result := inherited Store(Data, DataList, AEncrypt);
  Flush(Data, DataList);
  //Object
  AddObj(Data, FObjectType{ $0005 Chart}, FObjectID, $6011);
  Flush(Data, DataList); 
  FChart.Store(DataList, xlExcel97);
end;

{TMSOShapeCheckBox}
constructor TMSOShapeCheckBox.Create(HostControl: TMSOShapeHostControl);
begin
  inherited Create(HostControl);
end;

function TMSOShapeCheckBox.ParseTXO(DataList: TXLSBlobList): integer;
begin  
  Result := -1;
  if Assigned(DataList) then begin
     if DataList.Count > 1 then begin
       With DataList[1] do begin
         if (GetByte(0) and $01) = $01 then begin
           FText := GetWideString(1, DataLength - 1);
         end else begin
           FText := widestring(GetString(1, DataLength - 1));
         end; 
       end;
       Result := 1;
     end;
  end;
end;


function TMSOShapeCheckBox.AddObj(Data: TXLSBlob; ObjType, ObjId, Options: word): integer;
var Sz: word;
    i: integer;
begin
   //ObjPicture
   Sz := $1A;
   Data.AddWord($005D); Data.AddWord(Sz);
   Data.AddWord($0015); Data.AddWord($0012); 
     Data.AddWord(ObjType);
     Data.AddWord(ObjId);
     Data.AddWord(Options);
     for i := 0 to 11 do Data.AddByte($00);

   Data.AddWord($0000); Data.AddWord($0000); 
   Result := 1;
end;

function TMSOShapeCheckBox.GetDgSize: integer;
begin
  Result := inherited GetDgSize;
  if Result > 0 then Inc(Result, 8);
end;


function TMSOShapeCheckBox.Store(Data: TXLSBlob; DataList: TXLSBlobList; AEncrypt: boolean): integer;
Var lSize: integer;
    lLen: Word;
begin
  Result := inherited Store(Data, DataList, AEncrypt);
  Flush(Data, DataList);
  //Object
  AddObj(Data, FObjectType{ $000B CheckBox}, FObjectID, ObjectOptions);
  Flush(Data, DataList); 
  //
  Data.AddWord($00EC); Data.AddWord($0000);
  AddHeader(Data, $0, $000, msofbtClientTextbox, 0);
  Flush(Data, DataList);

  //01B6
  lSize := $12;
  lLen := Length(FText);
  Data.AddWord($01B6); Data.AddWord(lSize);
  Data.AddWord($0222);
  Data.AddLong($0);
  Data.AddLong($0);
  Data.AddWord(lLen);
  if lLen > 0 then 
     Data.AddWord($0010)
  else
     Data.AddWord($0000);
  Data.AddLong($0);
  Flush(Data, DataList);

  if lLen > 0 then begin
    //Continue (text of checkbox)
    lSize := 4 + 1 + lLen * 2;
    Data.AddWord($003C); Data.AddWord(lSize - 4);
    Data.AddByte($01);   Data.AddWideString(FText);
    Flush(Data, DataList);
    //Continue  formating runs
    lSize := $10 +  4;
    Data.AddWord($003C); Data.AddWord(lSize - 4);
    Data.AddWord($0000); Data.AddWord($0000); Data.AddLong($0000);
    Data.AddWord(lLen);  Data.AddWord($0000); Data.AddLong($0000);
    Flush(Data, DataList);
  end;

end;


{TMSOShapePicture}
constructor TMSOShapePicture.Create(HostControl: TMSOShapeHostControl);
begin
  inherited Create(HostControl);
  ftCfValue  := -1;
  ftPioGrbit := -1;
end;

function TMSOShapePicture.ParseTXO(DataList: TXLSBlobList): integer;
begin  
  Result := -1;
  if Assigned(DataList) then begin
     if DataList.Count > 1 then begin
       With DataList[1] do begin
         if (GetByte(0) and $01) = $01 then begin
           FText := GetWideString(1, DataLength - 1);
         end else begin
           FText := widestring(GetString(1, DataLength - 1));
         end; 
       end;
       Result := 1;
     end;
  end;
end;


function TMSOShapePicture.AddObj(Data: TXLSBlob; ObjType, ObjId, Options: word): integer;
var Sz: word;
    i: integer;
    ObjRecftPictFrmla: TXLSBlob;
begin
   Sz := $001A;
   ObjRecftPictFrmla := nil;
   if Assigned(FObjRecftPictFrmla) then begin
       ObjRecftPictFrmla := FObjRecftPictFrmla.GetData(FDrawing);
       if Assigned(ObjRecftPictFrmla) then begin
          Sz := Sz +  ObjRecftPictFrmla.DataLength;
       end;
   end;

   if (ftCfValue >= 0) then Inc(Sz, 6);
   if (ftPioGrbit >= 0) then Inc(Sz, 6);

   Data.AddWord($005D); Data.AddWord(Sz);
   Data.AddWord($0015); Data.AddWord($0012); 
     Data.AddWord(ObjectType);
     Data.AddWord(ObjectID);
     Data.AddWord(options);
     for i := 0 to 11 do Data.AddByte($00);

   if ftCfValue >= 0 then begin
       data.AddWord($0007);
       data.AddWord($0002); 
       data.AddWord(ftCfValue);
   end;

   if ftPioGrbit >= 0 then begin
       data.AddWord($0008);
       data.AddWord($0002); 
       data.AddWord(ftPioGrbit);
   end;

   if Assigned(ObjRecftPictFrmla) then begin
      //!!!!!FObjRecftPictFrmla.SetLong(0, 4);
      //!!!!!FObjRecftPictFrmla.SetLong(0, 9);
      Data.CopyData(ObjRecftPictFrmla); 
      ObjRecftPictFrmla.Free;
   end;

   Data.AddWord($0000); Data.AddWord($0000); 
   Result := 1;
end;

function TMSOShapePicture.GetDgSize: integer;
begin
  Result := inherited GetDgSize;
end;


function TMSOShapePicture.ParseObj(Data: TXLSBlob): integer;
var offs: integer;
    len: integer;
    rec: word;
    reclen: word;
    lend: boolean;
begin  
  Result := 1;
  offs := 0;
  len := Data.DataLength;
  lend := false;

  while ((offs + 4) <= len) and not(lend) do begin
     rec := Data.GetWord(offs);
     reclen := Data.GetWord(offs + 2);   
     offs := offs + 4;
     case rec of
        $0000: begin  {OBJREC_END}
                  lend := true;
               end;
        $0015: begin
               end;
        $0007: begin
                  ftCfValue := Data.GetWord(offs);
               end;
        $0008: begin
                  ftPioGrbit := Data.GetWord(offs);
               end;
     end; 
     offs := offs + reclen;
  end;   
end;


function TMSOShapePicture.Store(Data: TXLSBlob; DataList: TXLSBlobList; AEncrypt: boolean): integer;
begin
  Result := inherited Store(Data, DataList, AEncrypt);
  Flush(Data, DataList);
  //Object
  AddObj(Data, FObjectType{ $000B CheckBox}, FObjectID, ObjectOptions);
  Flush(Data, DataList); 
end;


Destructor TMSOShapePicture.Destroy;
begin
  inherited Destroy;
end;





{TMSOShapeComboBox}
constructor TMSOShapeComboBox.Create(HostControl: TMSOShapeHostControl);
begin
  inherited Create(HostControl);
  ObjectType := $0014;
    
  FIsAutofilter := false;
end;

constructor TMSOShapeComboBox.Create(ADrawing: TMSODrawing; ARow, ACol: integer; AIsAutofilter: boolean); 
begin
  inherited Create(ADrawing, 2, msosptHostControl, (spoHaveAnchor or spoHaveSpt));
  FIsAutofilter := AIsAutofilter;
  SetDefault(ARow, ACol);
end;


function TMSOShapeComboBox.ParseObj(Data: TXLSBlob): integer;
var offs: integer;
    len: integer;
    rec: word;
    reclen: word;
    tmplen: integer;
    tmpdata: TXLSBlob;
begin  
  Result := 1;

  FIsAutofilter := (ObjectOptions and $0100) > 0;
  if FIsAutofilter then begin
      FRow := FClientAnchor.Row1;
      FCol := FClientAnchor.Col1;
  end else begin
      offs := 0;
      len := Data.DataLength;
      while (offs + 4) <= len do begin
         rec := Data.GetWord(offs);
         reclen := Data.GetWord(offs + 2);   
         offs := offs + 4;
         case rec of
            $0015: begin
                   end;
            $000C: begin
                     FObjRec_SBS := TXLSBlob.Create(reclen);
                     FObjRec_SBS.CopyData(Data, offs, reclen);
                   end;
            $000E: begin
                     FObjRec_SBSFrmla := TXLSBlob.Create(reclen);
                     FObjRec_SBSFrmla.CopyData(Data, offs, reclen);
                   end;
            $0013: begin
                     reclen := len - offs; 
                     FObjRec_LBSData := TXLSBlob.Create(reclen);
                     FObjRec_LBSData.CopyData(Data, offs, reclen);
                     tmplen := FObjRec_LBSData.GetWord(2);
                     if tmplen > 0 then begin
                        tmpdata := TXLSBlob.Create(tmplen + 2);
                        tmpdata.AddWord(tmplen); 
                        tmpdata.CopyData(FObjRec_LBSData, 8, tmplen);   
                        FLBSFormula := FDrawing.FCalculator.GetTranslatedFormula(tmpdata, 0, $0600);
                        tmpdata.Free; 
                     end; 
                   end;
         end; 
         offs := offs + reclen;
      end;   
  end;
end;




function TMSOShapeComboBox.AddObj(Data: TXLSBlob; ObjType, ObjId, Options: word): integer;
var Sz: word;
    i: integer;
    lbsformula: TXLSBlob;
    lbsdata: TXLSBlob;
begin
   //
   Sz := $12 + $04;
   lbsdata := nil;
 
   if Assigned(FObjRec_SBS) then begin
       Sz := Sz + FObjRec_SBS.DataLength + $04;
   end else begin
       Sz := Sz + $14 + $04;
   end;

   if Assigned(FObjRec_SBSFrmla) then begin
       Sz := Sz + FObjRec_SBSFrmla.DataLength + $04;
   end;

   if Assigned(FObjRec_LBSData) then begin
      Sz := Sz + FObjRec_LBSData.DataLength + $04;
      if Assigned(FLBSFormula) then begin
         FDrawing.FCalculator.GetStoreDataExt(FLBSFormula, lbsformula, 0, 0, FDrawing.FSheetID, 0);   
      end;
      if Assigned(lbsformula) then begin
          lbsdata := TXLSBlob.Create(FObjRec_LBSData.DataLength - FObjRec_LBSData.GetWord(2) +
                                     lbsformula.DataLength - 2);
          lbsdata.CopyData(FObjRec_LBSData, 0, 8);
          lbsdata.CopyData(lbsformula, 2, lbsformula.DataLength - 2);
          lbsdata.CopyData(FObjRec_LBSData, 8 + FObjRec_LBSData.GetWord(2), 
                           FObjRec_LBSData.DataLength - 8 - FObjRec_LBSData.GetWord(2));
          lbsdata.SetWord(lbsformula.DataLength - 2, 2);       
      end;

   end else begin
      Sz := Sz + 
            $10 + $04 +
            $00 + $04;
   end;

   Data.AddWord($005D); Data.AddWord(Sz);

   Data.AddWord($0015); Data.AddWord($0012); 
     Data.AddWord(ObjType);
     Data.AddWord(ObjId);
     Data.AddWord(Options);
     for i := 0 to 11 do Data.AddByte($00);

   if Assigned(FObjRec_SBS) then begin
      Data.AddWord($000C); Data.AddWord(FObjRec_SBS.DataLength);  
      Data.CopyData(FObjRec_SBS); 
   end else begin
      Data.AddWord($000C); Data.AddWord($0014);
        Data.AddWord($0000);  Data.AddWord($0000); 
        Data.AddWord($0000);  Data.AddWord($0000); 
        Data.AddWord($0064);  Data.AddWord($0001); 
        Data.AddWord($000A);  Data.AddWord($0000); 
        Data.AddWord($0010);  Data.AddWord($0001); 
   end;

   if Assigned(FObjRec_SBSFrmla) then begin
      Data.AddWord($000E); Data.AddWord(FObjRec_SBSFrmla.DataLength);  
      Data.CopyData(FObjRec_SBSFrmla); 
   end;

   if Assigned(FObjRec_LBSData) then begin
      Data.AddWord($0013); Data.AddWord($1FDE);
      if Assigned(lbsdata) then begin
         Data.CopyData(lbsdata);
         lbsdata.Free; 
      end else begin
         Data.CopyData(FObjRec_LBSData); 
      end;
   end else begin
      Data.AddWord($0013); Data.AddWord($1FEE);

        Data.AddWord($0000);  Data.AddWord($0000); 
        Data.AddWord($0004);  Data.AddWord($0301); 
        Data.AddWord($0000);  Data.AddWord($0002); 

        Data.AddWord($0008); //number of rows
        Data.AddWord($00A2);

      Data.AddWord($0000); Data.AddWord($0000); 
   end;
   Result := 1;
end;

function TMSOShapeComboBox.GetDgSize: integer;
begin
  Result := inherited GetDgSize;
//  if Result > 0 then Inc(Result, 8);
end;


function TMSOShapeComboBox.Store(Data: TXLSBlob; DataList: TXLSBlobList; AEncrypt: boolean): integer;
{Var lSize: integer;
    lLen: Word;}
begin
  if IsAutofilter then 
     FClientAnchor.SetClientAnchor(FRow, 0, FCol, 0, FRow + 1, 0, FCol + 1, 0);

  Result := inherited Store(Data, DataList, AEncrypt);
  Flush(Data, DataList);
  //Object
  AddObj(Data, FObjectType, FObjectID, ObjectOptions);
  Flush(Data, DataList); 
end;

procedure TMSOShapeComboBox.SetDefault(ARow, ACol: integer);
begin
  ObjectType := $0014;
  FIsAutofilter := true;
  ObjectOptions := $0121;
  
  FRow := ARow;
  FCol := ACol;

  Opt.LongValue[optfLockAgainstGrouping] := $01040104;
  Opt.LongValue[optfFitTextToShape]      := $00080008;
  Opt.LongValue[optfNoLineDrawDash]      := $00080000;
  Opt.LongValue[optfPrint]               := $00020000;

  FClientAnchor.Free;
  FClientAnchor := TMsoFbtClientAnchor.Create;

end;

Destructor TMSOShapeComboBox.Destroy;
begin
  FObjRec_SBS.Free;
  FObjRec_SBSFrmla.Free;
  FObjRec_LBSData.Free;
  FLBSFormula.Free;
  inherited Destroy;
end;



{TMSOShapeListBox}
constructor TMSOShapeListBox.Create(HostControl: TMSOShapeHostControl);
begin
  inherited Create(HostControl);
  ObjectType := $0012;
end;

constructor TMSOShapeListBox.Create(ADrawing: TMSODrawing; ARow, ACol: integer); 
begin
  inherited Create(ADrawing, 2, msosptHostControl, (spoHaveAnchor or spoHaveSpt));
  SetDefault(ARow, ACol);
end;


function TMSOShapeListBox.ParseObj(Data: TXLSBlob): integer;
var offs: integer;
    len: integer;
    rec: word;
    reclen: word;
    tmplen: integer;
    tmpdata: TXLSBlob;
begin  
  Result := 1;

      offs := 0;
      len := Data.DataLength;
      while (offs + 4) <= len do begin
         rec := Data.GetWord(offs);
         reclen := Data.GetWord(offs + 2);   
         offs := offs + 4;
         case rec of
            $0015: begin
                   end;
            $000C: begin
                     FObjRec_SBS := TXLSBlob.Create(reclen);
                     FObjRec_SBS.CopyData(Data, offs, reclen);
                   end;
            $000E: begin
                     FObjRec_SBSFrmla := TXLSBlob.Create(reclen);
                     FObjRec_SBSFrmla.CopyData(Data, offs, reclen);
                   end;
            $0013: begin
                     reclen := len - offs; 
                     FObjRec_LBSData := TXLSBlob.Create(reclen);
                     FObjRec_LBSData.CopyData(Data, offs, reclen);
                     tmplen := FObjRec_LBSData.GetWord(2);
                     if tmplen > 0 then begin
                        tmpdata := TXLSBlob.Create(tmplen + 2);
                        tmpdata.AddWord(tmplen); 
                        tmpdata.CopyData(FObjRec_LBSData, 8, tmplen);   
                        FLBSFormula := FDrawing.FCalculator.GetTranslatedFormula(tmpdata, 0, $0600);
                        tmpdata.Free; 
                     end; 
                   end;
         end; 
         offs := offs + reclen;
     end;
end;




function TMSOShapeListBox.AddObj(Data: TXLSBlob; ObjType, ObjId, Options: word): integer;
var Sz: word;
    i: integer;
    lbsformula: TXLSBlob;
    lbsdata: TXLSBlob;
begin
   //
   Sz := $12 + $04;
   lbsdata := nil;
 
   if Assigned(FObjRec_SBS) then begin
       Sz := Sz + FObjRec_SBS.DataLength + $04;
   end else begin
       Sz := Sz + $14 + $04;
   end;

   if Assigned(FObjRec_SBSFrmla) then begin
       Sz := Sz + FObjRec_SBSFrmla.DataLength + $04;
   end;

   if Assigned(FObjRec_LBSData) then begin
      Sz := Sz + FObjRec_LBSData.DataLength + $04;
      if Assigned(FLBSFormula) then begin
         FDrawing.FCalculator.GetStoreDataExt(FLBSFormula, lbsformula, 0, 0, FDrawing.FSheetID, 0);   
      end;
      if Assigned(lbsformula) then begin
          lbsdata := TXLSBlob.Create(FObjRec_LBSData.DataLength - FObjRec_LBSData.GetWord(2) +
                                     lbsformula.DataLength - 2);
          lbsdata.CopyData(FObjRec_LBSData, 0, 8);
          lbsdata.CopyData(lbsformula, 2, lbsformula.DataLength - 2);
          lbsdata.CopyData(FObjRec_LBSData, 8 + FObjRec_LBSData.GetWord(2), 
                           FObjRec_LBSData.DataLength - 8 - FObjRec_LBSData.GetWord(2));
          lbsdata.SetWord(lbsformula.DataLength - 2, 2);       
      end;

   end else begin
      Sz := Sz + 
            $10 + $04 +
            $00 + $04;
   end;

   Data.AddWord($005D); Data.AddWord(Sz);

   Data.AddWord($0015); Data.AddWord($0012); 
     Data.AddWord(ObjType);
     Data.AddWord(ObjId);
     Data.AddWord(Options);
     for i := 0 to 11 do Data.AddByte($00);

   if Assigned(FObjRec_SBS) then begin
      Data.AddWord($000C); Data.AddWord(FObjRec_SBS.DataLength);  
      Data.CopyData(FObjRec_SBS); 
   end else begin
      Data.AddWord($000C); Data.AddWord($0014);
        Data.AddWord($0000);  Data.AddWord($0000); 
        Data.AddWord($0000);  Data.AddWord($0000); 
        Data.AddWord($0064);  Data.AddWord($0001); 
        Data.AddWord($000A);  Data.AddWord($0000); 
        Data.AddWord($0010);  Data.AddWord($0001); 
   end;

   if Assigned(FObjRec_SBSFrmla) then begin
      Data.AddWord($000E); Data.AddWord(FObjRec_SBSFrmla.DataLength);  
      Data.CopyData(FObjRec_SBSFrmla); 
   end;

   if Assigned(FObjRec_LBSData) then begin
      Data.AddWord($0013); Data.AddWord($1FDE);
      if Assigned(lbsdata) then begin
         Data.CopyData(lbsdata);
         lbsdata.Free; 
      end else begin
         Data.CopyData(FObjRec_LBSData); 
      end;
   end else begin
      Data.AddWord($0013); Data.AddWord($1FEE);

        Data.AddWord($0000);  Data.AddWord($0000); 
        Data.AddWord($0004);  Data.AddWord($0301); 
        Data.AddWord($0000);  Data.AddWord($0002); 

        Data.AddWord($0008); //number of rows
        Data.AddWord($00A2);

      Data.AddWord($0000); Data.AddWord($0000); 
   end;
   Result := 1;
end;

function TMSOShapeListBox.GetDgSize: integer;
begin
  Result := inherited GetDgSize;
//  if Result > 0 then Inc(Result, 8);
end;


function TMSOShapeListBox.Store(Data: TXLSBlob; DataList: TXLSBlobList; AEncrypt: boolean): integer;
{Var lSize: integer;
    lLen: Word;}
begin

  Result := inherited Store(Data, DataList, AEncrypt);
  Flush(Data, DataList);
  //Object
  AddObj(Data, FObjectType, FObjectID, ObjectOptions);
  Flush(Data, DataList); 
end;

procedure TMSOShapeListBox.SetDefault(ARow, ACol: integer);
begin
  ObjectType := $0012;
  ObjectOptions := $0121;
  
  FRow := ARow;
  FCol := ACol;

  Opt.LongValue[optfLockAgainstGrouping] := $01040104;
  Opt.LongValue[optfFitTextToShape]      := $00080008;
  Opt.LongValue[optfNoLineDrawDash]      := $00080000;
  Opt.LongValue[optfPrint]               := $00020000;

  FClientAnchor.Free;
  FClientAnchor := TMsoFbtClientAnchor.Create;

end;


Destructor TMSOShapeListBox.Destroy;
begin
  FObjRec_SBS.Free;
  FObjRec_SBSFrmla.Free;
  FObjRec_LBSData.Free;
  FLBSFormula.Free;
  inherited Destroy;
end;


//TObjFormula
constructor TObjFormula.Create;
begin
  inherited Create;
end;

destructor TObjFormula.Destroy;
begin
  FData.Free;
  FCompiledFormula.Free;
  inherited Destroy;
end;

function TObjFormula.ParseObj(RecID: word; var RecLen: word; Data: TXLSBlob; offset: integer; FDrawing: TMSODrawing): integer;
var l_reclen: integer;
    tmpdata: TXLSBlob;
    l_formulalen: integer;
begin
  FRecID := RecID;

  if RecLen > (integer(Data.DataLength) - offset) then begin
     l_reclen := integer(Data.DataLength) - offset;
  end else begin
     l_reclen := RecLen;
  end;

  FData := TXLSBlob.Create(l_reclen);
  FData.CopyData(Data, offset, l_reclen);
  l_formulalen := FData.GetWord(2);
  if l_formulalen > 0 then begin
     tmpdata := TXLSBlob.Create(l_formulalen + 2);
     tmpdata.AddWord(l_formulalen); 
     tmpdata.CopyData(FData, 8, l_formulalen);   
     FCompiledFormula := FDrawing.FCalculator.GetTranslatedFormula(tmpdata, 0, $0600);
     tmpdata.Free; 
   end; 

   RecLen := l_reclen;
   Result := 1;
end;

function TObjFormula.GetData(FDrawing: TMSODrawing): TXLSBlob;
var formuladata: TXLSBlob;
    Data: TXLSBlob;
begin
   formuladata := nil;
   Data := nil;
   if Assigned(FData) then begin
      if Assigned(FCompiledFormula) then begin
         FDrawing.FCalculator.GetStoreDataExt(FCompiledFormula, formuladata, 0, 0, FDrawing.FSheetID, 0);   
      end;

      if Assigned(formuladata) then begin
         Data := TXLSBlob.Create(4 + FData.DataLength - FData.GetWord(2) +
                                 formuladata.DataLength - 2);
         Data.AddWord(FRecID);
         Data.AddWord(0); 
         Data.CopyData(FData, 0, 8);
         Data.CopyData(formuladata, 2, formuladata.DataLength - 2);
         Data.CopyData(FData, 8 + FData.GetWord(2), 
                       FData.DataLength - 8 - FData.GetWord(2));
         Data.SetWord(formuladata.DataLength - 2, 2 + 4);       
         Data.SetWord(Data.DataLength - 4, 2);
      end else begin
         Data := TXLSBlob.Create(4 + FData.DataLength);
         Data.AddWord(FRecID);
         Data.AddWord(0); 
         Data.CopyData(FData, 0, FData.DataLength);
         Data.SetWord(Data.DataLength - 4, 2);
      end;
   end;
   formuladata.Free;
   Result := Data;
end;

end.
