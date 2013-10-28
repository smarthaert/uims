{$DEFINE USEGRAPHICS}
{$IFDEF VER110}
  {$DEFINE D3UP}
{$ENDIF}
{$IFDEF VER120}
  {$DEFINE D3UP}
  {$DEFINE D4UP}
{$ENDIF}
{$IFDEF VER125}
  {$DEFINE D4UP}
{$ENDIF}
{$IFDEF VER130}
  {$DEFINE D3UP}
  {$DEFINE D4UP}
  {$DEFINE D5UP}
{$ENDIF}
{$IFDEF VER140}
  {$DEFINE D3UP}
  {$DEFINE D4UP}
  {$DEFINE D5UP}
  {$DEFINE D6UP}
{$ENDIF}
{$IFDEF VER150}
  {$DEFINE D3UP}
  {$DEFINE D4UP}
  {$DEFINE D5UP}
  {$DEFINE D6UP}
  {$DEFINE D7UP}
{$ENDIF}
{$IFDEF VER160}
  {$DEFINE D3UP}
  {$DEFINE D4UP}
  {$DEFINE D5UP}
  {$DEFINE D6UP}
  {$DEFINE D7UP}
  {$DEFINE D8UP}
{$ENDIF}
{$IFDEF VER170}
  {$DEFINE D3UP}
  {$DEFINE D4UP}
  {$DEFINE D5UP}
  {$DEFINE D6UP}
  {$DEFINE D7UP}
  {$DEFINE D8UP}
  {$DEFINE D9UP}
{$ENDIF}
{$IFDEF VER180}
  {$DEFINE D3UP}
  {$DEFINE D4UP}
  {$DEFINE D5UP}
  {$DEFINE D6UP}
  {$DEFINE D7UP}
  {$DEFINE D8UP}
  {$DEFINE D9UP}
  {$DEFINE D10UP}
{$ENDIF}
unit NativeXml;
interface
uses
  {$IFDEF D9UP}
  Windows,
  {$ENDIF}
  {$IFDEF CLR}
  System.Text,
  {$ENDIF}
  Classes,
  {$IFDEF USEGRAPHICS}
  {$IFDEF LINUX}
  QGraphics,
  {$ELSE}
  Graphics,
  {$ENDIF}
  {$ENDIF}
  SysUtils;
const
  cNativeXmlVersion = '2.20';
{$IFNDEF D4UP}
type
  TReplaceFlags = set of (rfReplaceAll, rfIgnoreCase);
function StringReplace(const S, OldPattern, NewPattern: string;
  Flags: TReplaceFlags): string;
{$ENDIF}
{$IFNDEF D5UP}
type
  widestring = string;
function AnsiPos(const Substr, S: string): Integer;
function AnsiQuotedStr(const S: string; Quote: Char): string;
function AnsiExtractQuotedStr(var Src: PChar; Quote: Char): string;
procedure FreeAndNil(var Obj);
{$ENDIF}
type
  {$IFDEF CLR}
  TPointer = TObject;
  {$ELSE}
  TPointer = Pointer;
  {$ENDIF}
{$IFNDEF D6UP}
type
  TSeekOrigin = Word;
const
  soBeginning = soFromBeginning;
  soCurrent = soFromCurrent;
  soEnd = soFromEnd;
{$ENDIF}
type
  TXmlFormatType = (
    xfReadable,
    xfCompact
  );
  TXmlElementType = (
    xeNormal,
    xeComment,
    xeCData,
    xeDeclaration,
    xeStylesheet,
    xeDoctype,
    xeElement,
    xeAttList,
    xeEntity,
    xeNotation,
    xeExclam,
    xeQuestion,
    xeCharData,
    xeUnknown
  );
  TBinaryEncodingType = (
    xbeBinHex,  { With this encoding, each byte is stored as a hexadecimal
                  number, e.g. 0 = 00 and 255 = FF.                        }
    xbeBase64   { With this encoding, each group of 3 bytes are stored as 4
                  characters, requiring 64 different characters.}
  );
  TStringEncodingType = (
    se8Bit,
    seUCS4BE,
    seUCS4LE,
    seUCS4_2143,
    seUCS4_3412,
    se16BitBE,
    se16BitLE,
    seUTF8,
    seUTF16BE,
    seUTF16LE,
    seEBCDIC
  );
  TXmlCompareOption = (
    xcNodeName,
    xcNodeType,
    xcNodeValue,
    xcAttribCount,
    xcAttribNames,
    xcAttribValues,
    xcChildCount,
    xcChildNames,
    xcChildValues,
    xcRecursive
  );
  TXmlCompareOptions = set of TXmlCompareOption;
const
  xcAll: TXmlCompareOptions = [xcNodeName, xcNodeType, xcNodeValue, xcAttribCount,
    xcAttribNames, xcAttribValues, xcChildCount, xcChildNames, xcChildValues,
    xcRecursive];
var
  cDefaultEncodingString:      string              = 'windows-1252';
  cDefaultExternalEncoding:    TStringEncodingType = se8bit;
  cDefaultVersionString:       string              = '1.0';
  cDefaultXmlFormat:           TXmlFormatType      = xfCompact;
  cDefaultWriteOnDefault:      boolean             = True;
  cDefaultBinaryEncoding:      TBinaryEncodingType = xbeBase64;
  cDefaultUtf8Encoded:         boolean             = False;
  cDefaultIndentString:        string              = '  ';
  cDefaultDropCommentsOnParse: boolean             = False;
  cDefaultUseFullNodes:        boolean             = False;
  cDefaultSortAttributes:      boolean             = False;
  
type
  TXmlNode = class;
  TNativeXml = class;
  TsdCodecStream = class;
  TXmlNodeEvent = procedure(Sender: TObject; Node: TXmlNode) of object;
  TXmlProgressEvent = procedure(Sender: TObject; Size: integer) of object;
  TXmlNodeCompareEvent = function(Sender: TObject; Node1, Node2: TXmlNode; Info: TPointer): integer of object;
  TXMLNodeCompareFunction = function(Node1, Node2: TXmlNode; Info: TPointer): integer;
  
  TXmlNode = class(TPersistent)
  private
    FAttributes: TStringList;
    FDocument: TNativeXml;
    FElementType: TXmlElementType;
    FName: string;
    FNodes: TList;
    FParent: TXmlNode;
    FTag: integer;
    FValue: string;
    function GetValueAsString: string;
    procedure SetAttributeName(Index: integer; const Value: string);
    procedure SetAttributeValue(Index: integer; const Value: string);
    procedure SetValueAsString(const AValue: string);
    function GetIndent: string;
    function GetLineFeed: string;
    function GetTreeDepth: integer;
    function GetAttributeCount: integer;
    function GetAttributePair(Index: integer): string;
    function GetAttributeName(Index: integer): string;
    function GetAttributeValue(Index: integer): string;
    function GetWriteOnDefault: boolean;
    function GetBinaryEncoding: TBinaryEncodingType;
    function GetCascadedName: string;
    function QualifyAsDirectNode: boolean;
    procedure SetName(const Value: string);
    function GetFullPath: string;
    procedure SetBinaryEncoding(const Value: TBinaryEncodingType);
    function GetBinaryString: string;
    procedure SetBinaryString(const Value: string);
    function UseFullNodes: boolean;
    function GetValueAsWidestring: widestring;
    procedure SetValueAsWidestring(const Value: widestring);
    function GetAttributeByName(const AName: string): string;
    procedure SetAttributeByName(const AName, Value: string);
    function GetValueAsInteger: integer;
    procedure SetValueAsInteger(const Value: integer);
    function GetValueAsFloat: double;
    procedure SetValueAsFloat(const Value: double);
    function GetValueAsDateTime: TDateTime;
    procedure SetValueAsDateTime(const Value: TDateTime);
    function GetValueAsBool: boolean;
    procedure SetValueAsBool(const Value: boolean);
    {$IFDEF D4UP}
    function GetValueAsInt64: int64;
    procedure SetValueAsInt64(const Value: int64);
    {$ENDIF}
    procedure CheckCreateAttributesList;
    function GetAttributeValueAsWidestring(Index: integer): widestring;
    procedure SetAttributeValueAsWidestring(Index: integer;
      const Value: widestring);
    function GetAttributeValueAsInteger(Index: integer): integer;
    procedure SetAttributeValueAsInteger(Index: integer;
      const Value: integer);
  protected
    function CompareNodeName(const NodeName: string): integer;
    function GetNodes(Index: integer): TXmlNode; virtual;
    function GetNodeCount: integer; virtual;
    procedure ParseTag(const AValue: string; TagStart, TagClose: integer);
    procedure ReadFromStream(S: TStream); virtual;
    procedure ReadFromString(const AValue: string); virtual;
    procedure ResolveEntityReferences;
    function UnescapeString(const AValue: string): string; virtual;
    function Utf8Encoded: boolean;
    function WriteInnerTag: string; virtual;
    procedure WriteToStream(S: TStream); virtual;
  public
    constructor Create(ADocument: TNativeXml); virtual;
    constructor CreateName(ADocument: TNativeXml; const AName: string); virtual;
    constructor CreateNameValue(ADocument: TNativeXml; const AName, AValue: string); virtual;
    constructor CreateType(ADocument: TNativeXml; AType: TXmlElementType); virtual;
    procedure Assign(Source: TPersistent); override;
    procedure Delete; virtual;
    procedure DeleteEmptyNodes;
    destructor Destroy; override;
    {$IFDEF D4UP}
    procedure AttributeAdd(const AName: string; AValue: integer); overload;
    {$ENDIF}
    procedure AttributeAdd(const AName, AValue: string); {$IFDEF D4UP}overload;{$ENDIF}
    procedure AttributeDelete(Index: integer);
    procedure AttributeExchange(Index1, Index2: integer);
    function AttributeIndexByname(const AName: string): integer;
    procedure AttributesClear; virtual;
    procedure BufferRead(var Buffer{$IFDEF CLR}: TBytes{$ENDIF}; Count: Integer); virtual;
    procedure BufferWrite(const Buffer{$IFDEF CLR}: TBytes{$ENDIF}; Count: Integer); virtual;
    function BufferLength: integer; virtual;
    procedure Clear; virtual;
    function FindNode(const NodeName: string): TXmlNode;
    procedure FindNodes(const NodeName: string; const AList: TList);
    function FromAnsiString(const s: string): string;
    function FromWidestring(const W: widestring): string;
    function HasAttribute(const AName: string): boolean; virtual;
    function IndexInParent: integer;
    function IsClear: boolean; virtual;
    function IsEmpty: boolean; virtual;
    function IsEqualTo(ANode: TXmlNode; Options: TXmlCompareOptions; MismatchNodes: TList {$IFDEF D4UP}= nil{$ENDIF}): boolean;
    function NodeAdd(ANode: TXmlNode): integer; virtual;
    function NodeByAttributeValue(const NodeName, AttribName, AttribValue: string;
      ShouldRecurse: boolean {$IFDEF D4UP}= True{$ENDIF}): TXmlNode;
    function NodeByElementType(ElementType: TXmlElementType): TXmlNode;
    function NodeByName(const AName: string): TXmlNode; virtual;
    procedure NodeDelete(Index: integer); virtual;
    procedure NodeExchange(Index1, Index2: integer);
    function NodeExtract(ANode: TXmlNode): TXmlNode; virtual;
    function NodeFindOrCreate(const AName: string): TXmlNode; virtual;
    function NodeIndexByName(const AName: string): integer; virtual;
    function NodeIndexByNameFrom(const AName: string; AFrom: integer): integer; virtual;
    function NodeIndexOf(ANode: TXmlNode): integer;
    procedure NodeInsert(Index: integer; ANode: TXmlNode); virtual;
    function NodeNew(const AName: string): TXmlNode; virtual;
    function NodeNewAtIndex(Index: integer; const AName: string): TXmlNode; virtual;
    function NodeRemove(ANode: TxmlNode): integer;
    procedure NodesClear; virtual;
    procedure NodesByName(const AName: string; const AList: TList);
    function ReadAttributeInteger(const AName: string; ADefault: integer {$IFDEF D4UP}= 0{$ENDIF}): integer; virtual;
    function ReadAttributeString(const AName: string; const ADefault: string {$IFDEF D4UP}= ''{$ENDIF}): string; virtual;
    function ReadBool(const AName: string; ADefault: boolean {$IFDEF D4UP}= False{$ENDIF}): boolean; virtual;
    {$IFDEF USEGRAPHICS}
    procedure ReadBrush(const AName: string; ABrush: TBrush); virtual;
    function ReadColor(const AName: string; ADefault: TColor {$IFDEF D4UP}= clBlack{$ENDIF}): TColor; virtual;
    procedure ReadFont(const AName: string; AFont: TFont); virtual;
    procedure ReadPen(const AName: string; APen: TPen); virtual;
    {$ENDIF}
    function ReadDateTime(const AName: string; ADefault: TDateTime {$IFDEF D4UP}= 0{$ENDIF}): TDateTime; virtual;
    function ReadFloat(const AName: string; ADefault: double {$IFDEF D4UP}= 0.0{$ENDIF}): double; virtual;
    {$IFDEF D4UP}
    function ReadInt64(const AName: string; ADefault: int64 {$IFDEF D4UP}= 0{$ENDIF}): int64; virtual;
    {$ENDIF}
    function ReadInteger(const AName: string; ADefault: integer {$IFDEF D4UP}= 0{$ENDIF}): integer; virtual;
    function ReadString(const AName: string; const ADefault: string {$IFDEF D4UP}= ''{$ENDIF}): string; virtual;
    function ReadWidestring(const AName: string; const ADefault: widestring {$IFDEF D4UP}= ''{$ENDIF}): widestring; virtual;
    procedure SortChildNodes(Compare: TXMLNodeCompareFunction {$IFDEF D4UP}= nil{$ENDIF}; Info: TPointer {$IFDEF D4UP}= nil{$ENDIF});
    function ToAnsiString(const s: string): string;
    function ToWidestring(const s: string): widestring;
    function ValueAsBoolDef(ADefault: boolean): boolean; virtual;
    function ValueAsDateTimeDef(ADefault: TDateTime): TDateTime; virtual;
    function ValueAsFloatDef(ADefault: double): double; virtual;
    {$IFDEF D4UP}
    function ValueAsInt64Def(ADefault: int64): int64; virtual;
    {$ENDIF}
    function ValueAsIntegerDef(ADefault: integer): integer; virtual;
    procedure WriteAttributeInteger(const AName: string; AValue: integer; ADefault: integer {$IFDEF D4UP}= 0{$ENDIF}); virtual;
    procedure WriteAttributeString(const AName: string; const AValue: string; const ADefault: string {$IFDEF D4UP}= ''{$ENDIF}); virtual;
    procedure WriteBool(const AName: string; AValue: boolean; ADefault: boolean {$IFDEF D4UP}= False{$ENDIF}); virtual;
    {$IFDEF USEGRAPHICS}
    procedure WriteBrush(const AName: string; ABrush: TBrush); virtual;
    procedure WriteColor(const AName: string; AValue: TColor; ADefault: TColor {$IFDEF D4UP}= clBlack{$ENDIF}); virtual;
    procedure WriteFont(const AName: string; AFont: TFont); virtual;
    procedure WritePen(const AName: string; APen: TPen); virtual;
    {$ENDIF}
    procedure WriteDateTime(const AName: string; AValue: TDateTime; ADefault: TDateTime {$IFDEF D4UP}= 0{$ENDIF}); virtual;
    procedure WriteFloat(const AName: string; AValue: double; ADefault: double {$IFDEF D4UP}= 0.0{$ENDIF}); virtual;
    procedure WriteHex(const AName: string; AValue: integer; Digits: integer; ADefault: integer {$IFDEF D4UP}= 0{$ENDIF}); virtual;
    {$IFDEF D4UP}
    procedure WriteInt64(const AName: string; AValue: int64; ADefault: int64 {$IFDEF D4UP}= 0{$ENDIF}); virtual;
    {$ENDIF}
    procedure WriteInteger(const AName: string; AValue: integer; ADefault: integer {$IFDEF D4UP}= 0{$ENDIF}); virtual;
    procedure WriteString(const AName, AValue: string; const ADefault: string {$IFDEF D4UP}= ''{$ENDIF}); virtual;
    function WriteToString: string; virtual;
    procedure WriteWidestring(const AName: string; const AValue: widestring; const ADefault: widestring {$IFDEF D4UP}= ''{$ENDIF}); virtual;
    property AttributeByName[const AName: string]: string read GetAttributeByName write
      SetAttributeByName;
    property AttributeCount: integer read GetAttributeCount;
    property AttributeName[Index: integer]: string read GetAttributeName write SetAttributeName;
    property AttributePair[Index: integer]: string read GetAttributePair;
    property AttributeValue[Index: integer]: string read GetAttributeValue write SetAttributeValue;
    property AttributeValueAsWidestring[Index: integer]: widestring read GetAttributeValueAsWidestring write SetAttributeValueAsWidestring;
    property AttributeValueAsInteger[Index: integer]: integer read GetAttributeValueAsInteger write SetAttributeValueAsInteger;
    property BinaryEncoding: TBinaryEncodingType read GetBinaryEncoding write SetBinaryEncoding;
    property BinaryString: string read GetBinaryString write SetBinaryString;
    property CascadedName: string read GetCascadedName;
    property Document: TNativeXml read FDocument write FDocument;
    property ElementType: TXmlElementType read FElementType write FElementType;
    property FullPath: string read GetFullPath;
    property Name: string read FName write SetName;
    property Parent: TXmlNode read FParent write FParent;
    property NodeCount: integer read GetNodeCount;
    property Nodes[Index: integer]: TXmlNode read GetNodes; default;
    property Tag: integer read FTag write FTag;
    property TreeDepth: integer read GetTreeDepth;
    property ValueAsBool: boolean read GetValueAsBool write SetValueAsBool;
    property ValueAsDateTime: TDateTime read GetValueAsDateTime write SetValueAsDateTime;
    {$IFDEF D4UP}
    property ValueAsInt64: int64 read GetValueAsInt64 write SetValueAsInt64;
    {$ENDIF}
    property ValueAsInteger: integer read GetValueAsInteger write SetValueAsInteger;
    property ValueAsFloat: double read GetValueAsFloat write SetValueAsFloat;
    property ValueAsString: string read GetValueAsString write SetValueAsString;
    property ValueAsWidestring: widestring read GetValueAsWidestring write SetValueAsWidestring;
    property ValueDirect: string read FValue write FValue;
    property WriteOnDefault: boolean read GetWriteOnDefault;
  end;
  
  TXmlNodeList = class(TList)
  private
    function GetItems(Index: Integer): TXmlNode;
    procedure SetItems(Index: Integer; const Value: TXmlNode);
  public
    property Items[Index: Integer]: TXmlNode read GetItems write SetItems; default;
  end;

  
  TNativeXml = class(TPersistent)
  private
    FAbortParsing: boolean;
    FBinaryEncoding: TBinaryEncodingType;
    FCodecStream: TsdCodecStream;
    FDropCommentsOnParse: boolean;
    FExternalEncoding: TStringEncodingType;
    FParserWarnings: boolean;
    FRootNodes: TXmlNode;
    FIndentString: string;
    FUseFullNodes: boolean;
    FUtf8Encoded: boolean;
    FWriteOnDefault: boolean;
    FXmlFormat: TXmlFormatType;
    FSortAttributes: boolean;
    FOnNodeCompare: TXmlNodeCompareEvent;
    FOnNodeNew: TXmlNodeEvent;
    FOnNodeLoaded: TXmlNodeEvent;
    FOnProgress: TXmlProgressEvent;
    FOnUnicodeLoss: TNotifyEvent;
    procedure DoNodeNew(Node: TXmlNode);
    procedure DoNodeLoaded(Node: TXmlNode);
    procedure DoUnicodeLoss(Sender: TObject);
    function GetCommentString: string;
    procedure SetCommentString(const Value: string);
    function GetEntityByName(AName: string): string;
    function GetRoot: TXmlNode;
    function GetEncodingString: string;
    procedure SetEncodingString(const Value: string);
    function GetVersionString: string;
    procedure SetVersionString(const Value: string);
    function GetStyleSheetString: string;
    procedure SetStyleSheetString(const Value: string);
  protected
    procedure CopyFrom(Source: TNativeXml); virtual;
    procedure DoProgress(Size: integer);
    function LineFeed: string; virtual;
    procedure ParseDTD(ANode: TXmlNode; S: TStream); virtual;
    procedure ReadFromStream(S: TStream); virtual;
    procedure WriteToStream(S: TStream); virtual;
    procedure SetDefaults; virtual;
  public
    constructor Create; virtual;
    constructor CreateName(const ARootName: string); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear; virtual;
    function IsEmpty: boolean; virtual;
    procedure LoadFromStream(Stream: TStream); virtual;
    procedure LoadFromFile(const FileName: string); virtual;
    procedure ReadFromString(const AValue: string); virtual;
    procedure ResolveEntityReferences;
    procedure SaveToStream(Stream: TStream); virtual;
    procedure SaveToFile(const FileName: string); virtual;
    function WriteToString: string; virtual;
    property AbortParsing: boolean read FAbortParsing write FAbortParsing;
    property BinaryEncoding: TBinaryEncodingType read FBinaryEncoding write FBinaryEncoding;
    property CommentString: string read GetCommentString write SetCommentString;
    property DropCommentsOnParse: boolean read FDropCommentsOnParse write FDropCommentsOnParse;
    property EncodingString: string read GetEncodingString write SetEncodingString;
    property EntityByName[AName: string]: string read GetEntityByName;
    property ExternalEncoding: TStringEncodingType read FExternalEncoding write FExternalEncoding;
    property IndentString: string read FIndentString write FIndentString;
    property Root: TXmlNode read GetRoot;
    property RootNodeList: TXmlNode read FRootNodes;
    property StyleSheetString: string read GetStyleSheetString write SetStyleSheetString;
    property UseFullNodes: boolean read FUseFullNodes write FUseFullNodes;
    property Utf8Encoded: boolean read FUtf8Encoded write FUtf8Encoded;
    property VersionString: string read GetVersionString write SetVersionString;
    property WriteOnDefault: boolean read FWriteOnDefault write FWriteOnDefault;
    property XmlFormat: TXmlFormatType read FXmlFormat write FXmlFormat;
    property ParserWarnings: boolean read FParserWarnings write FParserWarnings;
    property SortAttributes: boolean read FSortAttributes write FSortAttributes;
    property OnNodeCompare: TXmlNodeCompareEvent read FOnNodeCompare write FOnNodeCompare;
    property OnNodeNew: TXmlNodeEvent read FOnNodeNew write FOnNodeNew;
    property OnNodeLoaded: TXmlNodeEvent read FOnNodeLoaded write FOnNodeLoaded;
    property OnProgress: TXmlProgressEvent read FOnProgress write FOnProgress;
    property OnUnicodeLoss: TNotifyEvent read FOnUnicodeLoss write FOnUnicodeLoss;
  end;

  TsdStreamModeType = (
    umUnknown,
    umRead,
    umWrite
  );

  TBigByteArray = array[0..MaxInt - 1] of byte;
  PBigByteArray = ^TBigByteArray;
{$IFDEF CLR}
  TsdBufferedStream = class(TStream)
  private
    FStream: TStream;
    FOwned: Boolean;
  protected
    procedure SetSize(NewSize: Int64); override;
  public
    constructor Create(AStream: TStream; Owned: Boolean = False);
    destructor Destroy; override;
    function Read(var Buffer: array of Byte; Offset, Count: Longint): Longint; override;
    function Write(const Buffer: array of Byte; Offset, Count: Longint): Longint; override;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
  end;
  
  TsdBufferedReadStream = TsdBufferedStream;
  TsdBufferedWriteStream = TsdBufferedStream;
{$ELSE}
  TsdBufferedReadStream = class(TStream)
  private
    FStream: TStream;
    FBuffer: PBigByteArray;
    FPage: integer;
    FBufPos: integer;
    FBufSize: integer;
    FPosition: longint;
    FOwned: boolean;
    FMustCheck: boolean;
  protected
    procedure CheckPosition;
  public
    constructor Create(AStream: TStream; Owned: boolean{$IFDEF D4UP} = False{$ENDIF});
    destructor Destroy; override;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; override;
  end;

  TsdBufferedWriteStream = class(TStream)
  private
    FStream: TStream;
    FBuffer: PBigByteArray;
    FBufPos: integer;
    FPosition: longint;
    FOwned: boolean;
  protected
    procedure Flush;
  public
    constructor Create(AStream: TStream; Owned: boolean{$IFDEF D4UP} = False{$ENDIF});
    destructor Destroy; override;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; override;
  end;
{$ENDIF}

  TsdCodecStream = class(TStream)
  private
    FBuffer: string;
    FBufferPos: integer;
    FEncoding: TstringEncodingType;
    FMode: TsdStreamModeType;
    FPosMin1: integer;
    FPosMin2: integer;
    FStream: TStream;
    FSwapByteOrder: boolean;
    FWarningUnicodeLoss: boolean;
    FWriteBom: boolean;
    FOnUnicodeLoss: TNotifyEvent;
  protected
    function ReadByte: byte; virtual;
    procedure StorePrevPositions; virtual;
    procedure WriteByte(const B: byte); virtual;
    procedure WriteBuf(const Buffer{$IFDEF CLR}: TBytes{$ENDIF}; Offset, Count: longint); virtual;
    function InternalRead(var Buffer{$IFDEF CLR}: array of Byte{$ENDIF}; Offset, Count: Longint): Longint;
    function InternalSeek(Offset: Longint; Origin: TSeekOrigin): Longint;
    function InternalWrite(const Buffer{$IFDEF CLR}: array of Byte{$ENDIF}; Offset, Count: Longint): Longint;
    {$IFDEF CLR}
    procedure SetSize(NewSize: Int64); override;
    {$ENDIF}
  public
    constructor Create(AStream: TStream); virtual;
    {$IFDEF CLR}
    function Read(var Buffer: array of Byte; Offset, Count: Longint): Longint; override;
    {$ELSE}
    function Read(var Buffer; Count: Longint): Longint; override;
    {$ENDIF}
    {$IFDEF CLR}
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
    {$ELSE}
    function Seek(Offset: Longint; Origin: Word): Longint; override;
    {$ENDIF}
    {$IFDEF CLR}
    function Write(const Buffer: array of Byte; Offset, Count: Longint): Longint; override;
    {$ELSE}
    function Write(const Buffer; Count: Longint): Longint; override;
    {$ENDIF}
    property Encoding: TstringEncodingType read FEncoding write FEncoding;
    property WarningUnicodeLoss: boolean read FWarningUnicodeLoss;
    property OnUnicodeLoss: TNotifyEvent read FOnUnicodeLoss write FOnUnicodeLoss;
  end;
  
  TsdAnsiStream = class(TsdCodecStream)
  protected
    function ReadByte: byte; override;
    procedure WriteByte(const B: byte); override;
    procedure WriteBuf(const Buffer{$IFDEF CLR}: TBytes{$ENDIF}; Offset, Count: longint); override;
  end;
  
  TsdUtf8Stream = class(TsdCodecStream)
  private
  protected
    function ReadByte: byte; override;
    procedure WriteByte(const B: byte); override;
    procedure WriteBuf(const Buffer{$IFDEF CLR}: TBytes{$ENDIF}; Offset, Count: longint); override;
  end;
  
function EscapeString(const AValue: string): string;
function UnEscapeStringUTF8(const AValue: string): string;
function UnEscapeStringANSI(const AValue: string): string;
function QuoteString(const AValue: string): string;
function UnQuoteString(const AValue: string): string;
function AddControlChars(const AValue: string; const Chars: string; Interval: integer): string;
function RemoveControlChars(const AValue: string): string;
function sdDateTimeFromString(const ADate: string): TDateTime;
function sdDateTimeFromStringDefault(const ADate: string; ADefault: TDateTime): TDateTime;
function sdDateTimeToString(ADate: TDateTime): string;
function sdUnicodeToUtf8(const W: widestring): string;
function sdAnsiToUtf8(const S: string): string;
function sdUtf8ToUnicode(const S: string): widestring;
function sdUtf8ToAnsi(const S: string): string;
function FindString(const SubString: string; const S: string; Start, Close: integer; var APos: integer): boolean;
function MatchString(const SubString: string; const S: string; Start: integer): boolean;
procedure ParseAttributes(const AValue: string; Start, Close: integer; Attributes: TStrings);
function TrimPos(const AValue: string; var Start, Close: integer): boolean;
function EncodeBase64(const Source: string): string;
function DecodeBase64(const Source: string): string;
function EncodeBinHex(const Source: string): string;
function DecodeBinHex(const Source: string): string;
{$IFDEF D4UP}
resourcestring
{$ELSE}
const
{$ENDIF}

  sxeErrorCalcStreamLength       = 'Error while calculating streamlength';
  sxeMissingDataInBinaryStream   = 'Missing data in binary stream';
  sxeMissingElementName          = 'Missing element name';
  sxeMissingCloseTag             = 'Missing close tag in element %s';
  sxeMissingDataAfterGreaterThan = 'Missing data after "<" in element %s';
  sxeMissingLessThanInCloseTag   = 'Missing ">" in close tag of element %s';
  sxeIncorrectCloseTag           = 'Incorrect close tag in element %s';
  sxeIllegalCharInNodeName       = 'Illegal character in node name "%s"';
  sxeMoreThanOneRootElement      = 'More than one root element found in xml';
  sxeMoreThanOneDeclaration      = 'More than one xml declaration found in xml';
  sxeDeclarationMustBeFirstElem  = 'Xml declaration must be first element';
  sxeMoreThanOneDoctype          = 'More than one doctype declaration found in root';
  sxeDoctypeAfterRootElement     = 'Doctype declaration found after root element';
  sxeNoRootElement               = 'No root element found in xml';
  sxeIllegalElementType          = 'Illegal element type';
  sxeCDATAInRoot                 = 'No CDATA allowed in root';
  sxeRootElementNotDefined       = 'XML root element not defined.';
  sxeCodecStreamNotAssigned      = 'Encoding stream unassigned';
  sxeUnsupportedEncoding         = 'Unsupported string encoding';
  sxeCannotReadCodecForWriting   = 'Cannot read from a conversion stream opened for writing';
  sxeCannotWriteCodecForReading  = 'Cannot write to an UTF stream opened for reading';
  sxeCannotReadMultipeChar       = 'Cannot read multiple chars from conversion stream at once';
  sxeCannotPerformSeek           = 'Cannot perform seek on codec stream';
  sxeCannotSeekBeforeReadWrite   = 'Cannot seek before reading or writing in conversion stream';
  sxeCannotSeek                  = 'Cannot perform seek in conversion stream';
  sxeCannotWriteToOutputStream   = 'Cannot write to output stream';
  sxeXmlNodeNotAssigned          = 'XML Node is not assigned';
  sxeCannotConverToBool          = 'Cannot convert value to bool';
  sxeCannotConvertToFloat        = 'Cannot convert value to float';

implementation

{$IFDEF TRIALXML}
uses
  Dialogs;
{$ENDIF}

type

  
  TTagType = record
    FStart: string;
    FClose: string;
    FStyle: TXmlElementType;
  end;
  PByte = ^byte;

  TBomInfo = packed record
    BOM: array[0..3] of byte;
    Len: integer;
    Enc: TStringEncodingType;
    HasBOM: boolean;
  end;

const
  
  cEscapeCount = 5;
  
  cEscapes: array[0..cEscapeCount - 1] of string = ('&', '<', '>', '''', '"');
  
  cReplaces: array[0..cEscapeCount - 1] of string =
    ('&amp;', '&lt;', '&gt;', '&apos;', '&quot;');

  cQuoteChars: set of char = ['"', ''''];
  cControlChars: set of char = [#9, #10, #13, #32]; {Tab, LF, CR, Space}
  cTagCount = 12;

  cTags: array[0..cTagCount - 1] of TTagType = (
    (FStart: '<![CDATA[';        FClose: ']]>'; FStyle: xeCData),
    (FStart: '<!DOCTYPE';        FClose: '>';   FStyle: xeDoctype),
    (FStart: '<!ELEMENT';        FClose: '>';   FStyle: xeElement),
    (FStart: '<!ATTLIST';        FClose: '>';   FStyle: xeAttList),
    (FStart: '<!ENTITY';         FClose: '>';   FStyle: xeEntity),
    (FStart: '<!NOTATION';       FClose: '>';   FStyle: xeNotation),
    (FStart: '<?xml-stylesheet'; FClose: '?>';  FStyle: xeStylesheet),
    (FStart: '<?xml';            FClose: '?>';  FStyle: xeDeclaration),
    (FStart: '<!--';             FClose: '-->'; FStyle: xeComment),
    (FStart: '<!';               FClose: '>';   FStyle: xeExclam),
    (FStart: '<?';               FClose: '?>';  FStyle: xeQuestion),
    (FStart: '<';                FClose: '>';   FStyle: xeNormal) );
  
  cHexChar:       array[0..15] of char = '0123456789ABCDEF';
  cHexCharLoCase: array[0..15] of char = '0123456789abcdef';

  
  cBase64Char: array[0..63] of char ='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  cBase64PadChar: char = '=';
  cNodeValueBuf = 2048;
  const cBomInfoCount = 15;
  const cBomInfo: array[0..cBomInfoCount - 1] of TBomInfo =
  ( (BOM: ($00,$00,$FE,$FF); Len: 4; Enc: seUCS4BE;    HasBOM: true),
    (BOM: ($FF,$FE,$00,$00); Len: 4; Enc: seUCS4LE;    HasBOM: true),
    (BOM: ($00,$00,$FF,$FE); Len: 4; Enc: seUCS4_2143; HasBOM: true),
    (BOM: ($FE,$FF,$00,$00); Len: 4; Enc: seUCS4_3412; HasBOM: true),
    (BOM: ($FE,$FF,$00,$00); Len: 2; Enc: seUTF16BE;   HasBOM: true),
    (BOM: ($FF,$FE,$00,$00); Len: 2; Enc: seUTF16LE;   HasBOM: true),
    (BOM: ($EF,$BB,$BF,$00); Len: 3; Enc: seUTF8;      HasBOM: true),
    (BOM: ($00,$00,$00,$3C); Len: 4; Enc: seUCS4BE;    HasBOM: false),
    (BOM: ($3C,$00,$00,$00); Len: 4; Enc: seUCS4LE;    HasBOM: false),
    (BOM: ($00,$00,$3C,$00); Len: 4; Enc: seUCS4_2143; HasBOM: false),
    (BOM: ($00,$3C,$00,$00); Len: 4; Enc: seUCS4_3412; HasBOM: false),
    (BOM: ($00,$3C,$00,$3F); Len: 4; Enc: seUTF16BE;   HasBOM: false),
    (BOM: ($3C,$00,$3F,$00); Len: 4; Enc: seUTF16LE;   HasBOM: false),
    (BOM: ($3C,$3F,$78,$6D); Len: 4; Enc: se8Bit;      HasBOM: false),
    (BOM: ($4C,$6F,$A7,$94); Len: 4; Enc: seEBCDIC;    HasBOM: false)
  );

{$IFNDEF CLR}
type
  TBytes = TBigByteArray;
{$ENDIF}

{$IFNDEF D4UP}
type
  TStringStream = class(TMemoryStream)
  public
    constructor Create(const S: string);
    function DataString: string;
  end;

constructor TStringStream.Create(const S: string);
begin
  SetSize(length(S));
  if Size > 0 then begin
    Write(S[1], Size);
    Position := 0;
  end;
end;

function TStringStream.DataString: string;
begin
  SetLength(Result, Size);
  if Size > 0 then begin
    Position := 0;
    Read(Result[1], length(Result));
  end;
end;

function StringReplace(const S, OldPattern, NewPattern: string;
  Flags: TReplaceFlags): string;
var
  SearchStr, Patt, NewStr: string;
  Offset: Integer;
begin
  if rfIgnoreCase in Flags then
  begin
    SearchStr := UpperCase(S);
    Patt := UpperCase(OldPattern);
  end else
  begin
    SearchStr := S;
    Patt := OldPattern;
  end;
  NewStr := S;
  Result := '';
  while SearchStr <> '' do
  begin
    Offset := Pos(Patt, SearchStr);
    if Offset = 0 then
    begin
      Result := Result + NewStr;
      Break;
    end;
    Result := Result + Copy(NewStr, 1, Offset - 1) + NewPattern;
    NewStr := Copy(NewStr, Offset + Length(OldPattern), MaxInt);
    if not (rfReplaceAll in Flags) then
    begin
      Result := Result + NewStr;
      Break;
    end;
    SearchStr := Copy(SearchStr, Offset + Length(Patt), MaxInt);
  end;
end;
{$ENDIF}

{$IFNDEF D5UP}
function AnsiPos(const Substr, S: string): Integer;
begin
  Result := Pos(Substr, S);
end;

function AnsiQuotedStr(const S: string; Quote: Char): string;
var
  P, Src, Dest: PChar;
  AddCount: Integer;
begin
  AddCount := 0;
  P := StrScan(PChar(S), Quote);
  while P <> nil do begin
    Inc(P);
    Inc(AddCount);
    P := StrScan(P, Quote);
  end;
  if AddCount = 0 then begin
    Result := Quote + S + Quote;
    Exit;
  end;
  SetLength(Result, Length(S) + AddCount + 2);
  Dest := Pointer(Result);
  Dest^ := Quote;
  Inc(Dest);
  Src := Pointer(S);
  P := StrScan(Src, Quote);
  repeat
    Inc(P);
    Move(Src^, Dest^, P - Src);
    Inc(Dest, P - Src);
    Dest^ := Quote;
    Inc(Dest);
    Src := P;
    P := StrScan(Src, Quote);
  until P = nil;
  P := StrEnd(Src);
  Move(Src^, Dest^, P - Src);
  Inc(Dest, P - Src);
  Dest^ := Quote;
end;

function AnsiExtractQuotedStr(var Src: PChar; Quote: Char): string;
var
  P, Dest: PChar;
  DropCount: Integer;
begin
  Result := '';
  if (Src = nil) or (Src^ <> Quote) then Exit;
  Inc(Src);
  DropCount := 1;
  P := Src;
  Src := StrScan(Src, Quote);
  while Src <> nil do begin
    Inc(Src);
    if Src^ <> Quote then Break;
    Inc(Src);
    Inc(DropCount);
    Src := StrScan(Src, Quote);
  end;
  if Src = nil then Src := StrEnd(P);
  if ((Src - P) <= 1) then Exit;
  if DropCount = 1 then
    SetString(Result, P, Src - P - 1)
  else begin
    SetLength(Result, Src - P - DropCount);
    Dest := PChar(Result);
    Src := StrScan(P, Quote);
    while Src <> nil do begin
      Inc(Src);
      if Src^ <> Quote then Break;
      Move(P^, Dest^, Src - P);
      Inc(Dest, Src - P);
      Inc(Src);
      P := Src;
      Src := StrScan(Src, Quote);
    end;
    if Src = nil then Src := StrEnd(P);
    Move(P^, Dest^, Src - P - 1);
  end;
end;

procedure FreeAndNil(var Obj);
var
  P: TObject;
begin
  P := TObject(Obj);
  TObject(Obj) := nil;
  P.Free;
end;
{$ENDIF}


function StreamWrite(Stream: TStream; const Buffer{$IFDEF CLR}: TBytes{$ENDIF}; Offset, Count: Longint): Longint;
begin
{$IFDEF CLR}
  Result := Stream.Write(Buffer, Offset, Count);
{$ELSE}
  Result := Stream.Write(TBytes(Buffer)[Offset], Count);
{$ENDIF}
end;


function Min(A, B: integer): integer;
begin
  if A < B then Result := A else Result := B;
end;

function Max(A, B: integer): integer;
begin
  if A > B then Result := A else Result := B;
end;

function EscapeString(const AValue: string): string;
var
  i: integer;
begin
  Result := AValue;
  for i := 0 to cEscapeCount - 1 do
    Result := StringReplace(Result, cEscapes[i], cReplaces[i], [rfReplaceAll]);
end;

function UnEscapeStringUTF8(const AValue: string): string;
var
  SearchStr, Reference, Replace: string;
  i, Offset, Code: Integer;
  W: word;
begin
  SearchStr := AValue;
  Result := '';
  while SearchStr <> '' do begin
    
    Offset := AnsiPos('&', SearchStr);
    if Offset = 0 then begin
      
      Result := Result + SearchStr;
      Break;
    end;
    Result := Result + Copy(SearchStr, 1, Offset - 1);
    SearchStr := Copy(SearchStr, Offset, MaxInt);
    
    Offset := AnsiPos(';', SearchStr);
    if Offset = 0 then begin
      
      
      Result := Result + SearchStr;
      Break;
    end;
    
    Reference := copy(SearchStr, 1, Offset);
    SearchStr := Copy(SearchStr, Offset + 1, MaxInt);
    Replace := Reference;
    
    if copy(Reference, 1, 2) = '&#' then begin
      Reference := copy(Reference, 3, length(Reference) - 3);
      if length(Reference) > 0 then begin
        if lowercase(Reference[1]) = 'x' then
          
          Reference[1] := '$';
        Code := StrToIntDef(Reference, -1);
        if (Code >= 0) and (Code < $FFFF) then begin
          W := Code;
          {$IFDEF D5UP}
          Replace := sdUnicodeToUtf8(WideChar(W));
          {$ELSE}
          Replace := char(W and $FF);
          {$ENDIF}
        end;
      end;
    end else begin
      
      for i := 0 to cEscapeCount - 1 do
        if Reference = cReplaces[i] then begin
          
          Replace := cEscapes[i];
          Break;
        end;
    end;
    
    Result := Result + Replace;
  end;
end;

function UnEscapeStringANSI(const AValue: string): string;
var
  SearchStr, Reference, Replace: string;
  i, Offset, Code: Integer;
  B: byte;
begin
  SearchStr := AValue;
  Result := '';
  while SearchStr <> '' do begin
    
    Offset := AnsiPos('&', SearchStr);
    if Offset = 0 then begin
      
      Result := Result + SearchStr;
      Break;
    end;
    Result := Result + Copy(SearchStr, 1, Offset - 1);
    SearchStr := Copy(SearchStr, Offset, MaxInt);
    
    Offset := AnsiPos(';', SearchStr);
    if Offset = 0 then begin
      
      
      Result := Result + SearchStr;
      Break;
    end;
    
    Reference := copy(SearchStr, 1, Offset);
    SearchStr := Copy(SearchStr, Offset + 1, MaxInt);
    Replace := Reference;
    
    if copy(Reference, 1, 2) = '&#' then begin
      Reference := copy(Reference, 3, length(Reference) - 3);
      if length(Reference) > 0 then begin
        if lowercase(Reference[1]) = 'x' then
          
          Reference[1] := '$';
        Code := StrToIntDef(Reference, -1);
        if (Code >= 0) and (Code < $FF) then begin
          B := Code;
          Replace := char(B);
        end;
      end;
    end else begin
      
      for i := 0 to cEscapeCount - 1 do
        if Reference = cReplaces[i] then begin
          
          Replace := cEscapes[i];
          Break;
        end;
    end;
    
    Result := Result + Replace;
  end;
end;

function QuoteString(const AValue: string): string;
var
  AQuoteChar: char;
begin
  AQuoteChar := '"';
  if Pos('"', AValue) > 0 then
    AQuoteChar := '''';
{$IFDEF CLR}
  Result := QuotedStr(AValue, AQuoteChar);
{$ELSE}
  Result := AnsiQuotedStr(AValue, AQuoteChar);
{$ENDIF}
end;

function UnQuoteString(const AValue: string): string;
{$IFNDEF CLR}
var
  P: PChar;
{$ENDIF}
begin
  if Length(AValue) < 2 then begin
    Result := AValue;
    exit;
  end;
  if AValue[1] in cQuoteChars then begin
  {$IFDEF CLR}
    Result := DequotedStr(AValue, AValue[1]);
  {$ELSE}
    P := PChar(AValue);
    Result := AnsiExtractQuotedStr(P, AValue[1]);
  {$ENDIF}
  end else
    Result := AValue;
end;

function AddControlChars(const AValue: string; const Chars: string; Interval: integer): string;
var
  i, j, ALength: integer;
procedure InsertControlChars;
var
  k: integer;
begin
  for k := 1 to Length(Chars) do begin
    Result[j] := Chars[k];
    inc(j);
  end;
end;
begin
  if (Length(Chars) = 0) or (Interval <= 0) then begin
    Result := AValue;
    exit;
  end;

  
  ALength := Length(AValue) + ((Length(AValue) - 1) div Interval + 3) * Length(Chars);
  SetLength(Result, ALength);

  
  j := 1;
  for i := 1 to Length(AValue) do begin
    if (i mod Interval) = 1 then begin
      
      InsertControlChars;
    end;
    Result[j] := AValue[i];
    inc(j);
  end;
  InsertControlChars;

  
  dec(j);
  if ALength > j then
    SetLength(Result, j);
end;

function RemoveControlChars(const AValue: string): string;
var
  i, j: integer;
begin
  Setlength(Result, Length(AValue));
  i := 1;
  j := 1;
  while i <= Length(AValue) do
    if AValue[i] in cControlChars then
      inc(i)
    else begin
      Result[j] := AValue[i];
      inc(i);
      inc(j);
    end;
  
  if i <> j then
    SetLength(Result, j - 1);
end;

function FindString(const SubString: string; const S: string; Start, Close: integer; var APos: integer): boolean;
var
  CharIndex: integer;
begin
  Result := False;
  APos   := 0;
  for CharIndex := Start to Close - Length(SubString) do
    if MatchString(SubString, S, CharIndex) then begin
      APos := CharIndex;
      Result := True;
      exit;
    end;
end;

function MatchString(const SubString: string; const S: string; Start: integer): boolean;
var
  CharIndex: integer;
begin
  Result := False;
  
  if (Length(S) - Start + 1) < Length(Substring) then exit;

  CharIndex := 0;
  while CharIndex < Length(SubString) do
    if Upcase(SubString[CharIndex + 1]) = Upcase(S[Start + CharIndex]) then
      inc(CharIndex)
    else
      exit;
  
  Result := True;
end;

procedure ParseAttributes(const AValue: string; Start, Close: integer; Attributes: TStrings);
var
  i: integer;
  InQuotes: boolean;
  AQuoteChar: char;
begin
  InQuotes := False;
  AQuoteChar := '"';
  if not assigned(Attributes) then exit;
  if not TrimPos(AValue, Start, Close) then exit;

  
  Attributes.Clear;

  
  for i := Start to Close - 1 do begin

    
    if InQuotes then begin
      if AValue[i] = AQuoteChar then
        InQuotes := False;
    end else begin
      if AValue[i] in cQuoteChars then begin
        InQuotes   := True;
        AQuoteChar := AValue[i];
      end;
    end;

    
    if not InQuotes then
      if AValue[i] in cControlChars then begin
        if i > Start then
          Attributes.Add(copy(AValue, Start, i - Start));
        Start := i + 1;
      end;
  end;
  
  if Start < Close then
    Attributes.Add(copy(AValue, Start, Close - Start));

  
  for i := Attributes.Count - 1 downto 1 do
    if Attributes[i][1] = '=' then begin
      Attributes[i - 1] := Attributes[i - 1] + Attributes[i];
      Attributes.Delete(i);
    end;
  
  for i := Attributes.Count - 1 downto 1 do
    if (Attributes[i][1] in cQuoteChars) and (Pos('=', Attributes[i - 1]) > 0) then begin
      Attributes[i - 1] := Attributes[i - 1] + Attributes[i];
      Attributes.Delete(i);
    end;
end;

function TrimPos(const AValue: string; var Start, Close: integer): boolean;
begin
  
  Start := Max(1, Start);
  Close := Min(Length(AValue) + 1, Close);
  if Close <= Start then begin
    Result := False;
    exit;
  end;

  
  while
    (Start < Close) and
    (AValue[Start] in cControlChars) do
    inc(Start);

  
  while
    (Start < Close) and
    (AValue[Close - 1] in cControlChars) do
    dec(Close);

  
  Result := Close > Start;
end;

procedure WriteStringToStream(S: TStream; const AString: string);
begin
  if Length(AString) > 0 then
  {$IFDEF CLR}
    S.Write(BytesOf(AString), Length(AString));
  {$ELSE}
    S.Write(AString[1], Length(AString));
  {$ENDIF}
end;

function ReadOpenTag(S: TStream; var Surplus: string): integer;
var
  AIndex, i: integer;
  Found: boolean;
  Ch: char;
  Candidates: array[0..cTagCount - 1] of boolean;
begin
  Surplus := '';
  Result := cTagCount - 1;
  for i := 0 to cTagCount - 1 do Candidates[i] := True;
  AIndex := 1;
  repeat
    Found := False;
    inc(AIndex);
    S.Read(Ch, 1);
    Surplus := Surplus + Ch;
    for i := cTagCount - 1 downto 0 do
      if Candidates[i] and (length(cTags[i].FStart) >= AIndex) then begin
        if cTags[i].FStart[AIndex] = Ch then begin
          Found := True;
          if length(cTags[i].FStart) = AIndex then
            Result := i;
        end else
          Candidates[i] := False;
      end;
  until Found = False;
  
  Surplus := copy(Surplus, length(cTags[Result].FStart), length(Surplus));
  
end;

function ReadStringFromStreamUntil(S: TStream; const ASearch: string;
  var ASurplus, AValue: string): boolean;
var
  AIndex, ValueIndex, SearchIndex: integer;
  LastSearchChar, Ch: char;
begin
  Result := False;

  
  AIndex := length(ASearch);
  if AIndex = 0 then exit;
  LastSearchChar := ASearch[AIndex];

  AValue := '';
  repeat
    
    if length(ASurplus) > 0 then begin
      Ch := ASurplus[1];
      ASurplus := copy(ASurplus, 2, length(ASurplus));
    end else
      if S.Read(Ch, 1) = 0 then exit;

    AValue := AValue + Ch;

    
    if Ch = LastSearchChar then begin

      
      ValueIndex  := length(AValue) - 1;
      SearchIndex := length(ASearch) - 1;
      if ValueIndex < SearchIndex then continue;

      Result := True;
      while (SearchIndex > 0)and Result do begin
        Result := AValue[ValueIndex] = ASearch[SearchIndex];
        dec(ValueIndex);
        dec(SearchIndex);
      end;
    end;
  until Result;

  
  AValue := copy(AValue, 1, length(AValue) - length(ASearch));
end;

function ReadStringFromStreamWithQuotes(S: TStream; const Terminator: string;
  var AValue: string): boolean;
var
  Ch, QuoteChar: char;
  InQuotes: boolean;
begin
  AValue := '';
  QuoteChar := #0;
  Result := False;
  InQuotes := False;
  repeat
    if S.Read(Ch, 1) = 0 then exit;
    if not InQuotes then begin
      if (Ch = '"') or (Ch = '''') then begin
        InQuotes := True;
        QuoteChar := Ch;
      end;
    end else begin
      if Ch = QuoteChar then
        InQuotes := False;
    end;
    if not InQuotes and (Ch = Terminator) then
      break;
    AValue := AValue + Ch;
  until False;
  Result := True;
end;

function sdDateTimeFromString(const ADate: string): TDateTime;
var
  AYear, AMonth, ADay, AHour, AMin, ASec, AMSec: word;
begin
  AYear  := StrToInt(copy(ADate, 1, 4));
  AMonth := StrToInt(copy(ADate, 6, 2));
  ADay   := StrToInt(copy(ADate, 9, 2));
  if Length(ADate) > 16 then begin 
    AHour := StrToInt(copy(ADate, 12, 2));
    AMin  := StrToInt(copy(ADate, 15, 2));
    ASec  := StrToIntDef(copy(ADate, 18, 2), 0); 
    AMSec := StrToIntDef(copy(ADate, 21, 3), 0); 
  end else begin
    AHour := 0;
    AMin  := 0;
    ASec  := 0;
    AMSec := 0;
  end;
  Result :=
    EncodeDate(AYear, AMonth, ADay) +
    EncodeTime(AHour, AMin, ASec, AMSec);
end;

function sdDateTimeFromStringDefault(const ADate: string; ADefault: TDateTime): TDateTime;
begin
  try
    Result := sdDateTimeFromString(ADate);
  except
    Result := ADefault;
  end;
end;

function sdDateTimeToString(ADate: TDateTime): string;
var
  AYear, AMonth, ADay, AHour, AMin, ASec, AMSec: word;
begin
  DecodeDate(ADate, AYear, AMonth, ADay);
  DecodeTime(ADate, AHour, AMin, ASec, AMSec);
  if frac(ADate) = 0 then begin
    Result := Format('%.4d-%.2d-%.2d', [AYear, AMonth, ADay]);
  end else begin
    Result := Format('%.4d-%.2d-%.2dT%.2d:%.2d:%.2d.%.3dZ',
      [AYear, AMonth, ADay, AHour, AMin, ASec, AMSec]);
  end;
end;

{$IFDEF CLR}

function sdUnicodeToUtf8(const W: widestring): string;
begin
  Result := Encoding.UTF8.GetBytes(W);
end;

function sdUtf8ToUnicode(const S: string): widestring;
begin
  Result := Encoding.UTF8.GetString(BytesOf(S));
end;

function EncodeBase64Buf(const Buffer: TBytes; Count: Integer): string;
begin
  Result := Convert.ToBase64String(Buffer, 0, Count);
end;

function EncodeBase64(const Source: string): string;
begin
  Result := Convert.ToBase64String(BytesOf(Source));
end;

procedure DecodeBase64Buf(const Source: string; var Buffer: TBytes; Count: Integer);
var
  ADecoded: TBytes;
begin
  ADecoded := Convert.FromBase64String(Source);
  if Count > Length(ADecoded) then
    raise EFilerError.Create(sxeMissingDataInBinaryStream);
  SetLength(ADecoded, Count);
  Buffer := ADecoded;
end;

function DecodeBase64(const Source: string): string;
begin
  Result := AnsiString(Convert.FromBase64String(Source));
end;

{$ELSE}

function PtrUnicodeToUtf8(Dest: PChar; MaxDestBytes: Cardinal; Source: PWideChar; SourceChars: Cardinal): Cardinal;
var
  i, count: Cardinal;
  c: Cardinal;
begin
  Result := 0;
  if not assigned(Source) or not assigned(Dest) then exit;

  count := 0;
  i := 0;

  while (i < SourceChars) and (count < MaxDestBytes) do begin
    c := Cardinal(Source[i]);
    Inc(i);
    if c <= $7F then begin
      Dest[count] := Char(c);
      Inc(count);
    end else
      if c > $7FF then begin
        if count + 3 > MaxDestBytes then
          break;
        Dest[count] := Char($E0 or (c shr 12));
        Dest[count+1] := Char($80 or ((c shr 6) and $3F));
        Dest[count+2] := Char($80 or (c and $3F));
        Inc(count,3);
      end else begin 
        if count + 2 > MaxDestBytes then
          break;
        Dest[count] := Char($C0 or (c shr 6));
        Dest[count+1] := Char($80 or (c and $3F));
        Inc(count,2);
      end;
  end;
  if count >= MaxDestBytes then
    count := MaxDestBytes-1;
  Dest[count] := #0;
  Result := count + 1;  
end;

function PtrUtf8ToUnicode(Dest: PWideChar; MaxDestChars: Cardinal; Source: PChar;
  SourceBytes: Cardinal): Cardinal;
var
  i, count: Cardinal;
  c: Byte;
  wc: Cardinal;
begin
  if not assigned(Dest) or not assigned(Source) then begin
    Result := 0;
    Exit;
  end;
  Result := Cardinal(-1);
  count := 0;
  i := 0;
  while (i < SourceBytes) and (count < MaxDestChars) do begin
    wc := Cardinal(Source[i]);
    Inc(i);
    if (wc and $80) <> 0 then begin
      if i >= SourceBytes then
        
        Exit;
      wc := wc and $3F;
      if (wc and $20) <> 0 then begin
        c := Byte(Source[i]);
        Inc(i);
        if (c and $C0) <> $80 then
          
          Exit;
        if i >= SourceBytes then
          
          Exit;
        wc := (wc shl 6) or (c and $3F);
      end;
      c := Byte(Source[i]);
      Inc(i);
      if (c and $C0) <> $80 then
        
        Exit;
      Dest[count] := WideChar((wc shl 6) or (c and $3F));
    end else
      Dest[count] := WideChar(wc);
    Inc(count);
  end;

  if count >= MaxDestChars then
    count := MaxDestChars-1;

  Dest[count] := #0;
  Result := count + 1;
end;

function sdUnicodeToUtf8(const W: widestring): string;
var
  L: integer;
  Temp: string;
begin
  Result := '';
  if W = '' then Exit;
  SetLength(Temp, Length(W) * 3); 

  L := PtrUnicodeToUtf8(PChar(Temp), Length(Temp) + 1, PWideChar(W), Length(W));
  if L > 0 then
    SetLength(Temp, L - 1)
  else
    Temp := '';
  Result := Temp;
end;

function sdUtf8ToUnicode(const S: string): widestring;
var
  L: Integer;
  Temp: WideString;
begin
  Result := '';
  if S = '' then Exit;
  SetLength(Temp, Length(S));

  L := PtrUtf8ToUnicode(PWideChar(Temp), Length(Temp)+1, PChar(S), Length(S));
  if L > 0 then
    SetLength(Temp, L-1)
  else
    Temp := '';
  Result := Temp;
end;

function EncodeBase64Buf(const Buffer; Count: Integer): string;
var
  i, j: integer;
  ACore: integer;
  ALong: cardinal;
  S: PByte;
begin
  
  
  ACore := (Count + 2) div 3;

  
  SetLength(Result, ACore * 4);
  S := @Buffer;
  
  for i := 0 to ACore - 1 do begin
    ALong := 0;
    for j := 0 to 2 do begin
      ALong := ALong shl 8 + S^;
      inc(S);
    end;
    for j := 0 to 3 do begin
      Result[i * 4 + 4 - j] := cBase64Char[ALong and $3F];
      ALong := ALong shr 6;
    end;
  end;
  
  
  case ACore * 3 - Count of
  0:;
  1: 
    Result[ACore * 4] := cBase64PadChar;
  2: 
    begin
      Result[ACore * 4    ] := cBase64PadChar;
      Result[ACore * 4 - 1] := cBase64PadChar;
    end;
  end;
end;

function EncodeBase64(const Source: string): string;
begin
  if length(Source) > 0 then
    Result := EncodeBase64Buf(Source[1], length(Source))
  else
    Result := '';
end;

procedure DecodeBase64Buf(var Source: string; var Buffer; Count: Integer);
var
  i, j: integer;
  APos, ACore: integer;
  ALong: cardinal;
  D: PByte;
  Map: array[Char] of byte;
begin
  
  ACore := Length(Source) div 4;
  if Count > ACore * 3 then
    raise EFilerError.Create(sxeMissingDataInBinaryStream);

  
  for i := 0 to 63 do
    Map[cBase64Char[i]] := i;
  D := @Buffer;

  
  
  APos := length(Source);
  if (APos > 0) and (Source[APos] = cBase64PadChar) then begin
    Source[APos] := cBase64Char[0];
    dec(APos);
    if (APos > 0) and (Source[APos] = cBase64PadChar) then
      Source[APos] := cBase64Char[0];
  end;

  
  for i := 0 to ACore - 1 do begin
    ALong := 0;
    
    for j := 0 to 3 do
      ALong := ALong shl 6 + Map[Source[i * 4 + j + 1]];
    
    for j := 2 downto 0 do begin
      
      if integer(D) - integer(@Buffer) >= Count then
        exit;
      D^ := ALong shr (j * 8) and $FF;
      inc(D);
    end;
  end;
end;

function DecodeBase64(const Source: string): string;
var
  AData: string;
  ASize, APos: integer;
begin
  AData := RemoveControlChars(Source);

  
  ASize := length(AData) div 4;
  if ASize * 4 <> length(AData) then
    raise EFilerError.Create(sxeErrorCalcStreamLength);
  ASize := ASize * 3;
  
  APos := length(AData);
  if (APos > 0) and (AData[APos] = cBase64PadChar) then begin
    dec(APos);
    dec(ASize);
    if (APos > 0) and (AData[APos] = cBase64PadChar) then
      dec(ASize);
  end;
  Setlength(Result, ASize);

  
  if ASize > 0 then
    DecodeBase64Buf(AData, Result[1], ASize);
end;

{$ENDIF}

function sdAnsiToUtf8(const S: string): string;
begin
  Result := sdUnicodeToUtf8(S);
end;

function sdUtf8ToAnsi(const S: string): string;
begin
  Result := sdUtf8ToUnicode(S);
end;

function EncodeBinHexBuf(const Source; Count: Integer): string;
var
{$IFDEF CLR}
  Text: TBytes;
{$ELSE}
  Text: string;
{$ENDIF}
begin
  SetLength(Text, Count * 2);
{$IFDEF CLR}
  BinToHex(TBytes(Source), 0, Text, 0, Count);
{$ELSE}
{$IFDEF D4UP}
  BinToHex(PChar(@Source), PChar(Text), Count);
{$ELSE}
  raise Exception.Create(sxeUnsupportedEncoding);
{$ENDIF}
{$ENDIF}
  Result := Text;
end;

function EncodeBinHex(const Source: string): string;
var
{$IFDEF CLR}
  Text: TBytes;
{$ELSE}
  Text: string;
{$ENDIF}
begin
  SetLength(Text, Length(Source) * 2);
{$IFDEF CLR}
  BinToHex(BytesOf(Source), 0, Text, 0, Length(Source));
{$ELSE}
{$IFDEF D4UP}
  BinToHex(PChar(Source), PChar(Text), Length(Source));
{$ELSE}
  raise Exception.Create(sxeUnsupportedEncoding);
{$ENDIF}
{$ENDIF}
  Result := Text;
end;

procedure DecodeBinHexBuf(const Source: string; var Buffer{$IFDEF CLR}: TBytes{$ENDIF}; Count: Integer);
begin
  if Length(Source) div 2 < Count then
    raise EFilerError.Create(sxeMissingDataInBinaryStream);

{$IFDEF CLR}
  HexToBin(BytesOf(Source), 0, Buffer, 0, Count);
{$ELSE}
{$IFDEF D4UP}
  HexToBin(PChar(Source), PChar(@Buffer), Count);
{$ELSE}
  raise Exception.Create(sxeUnsupportedEncoding);
{$ENDIF}
{$ENDIF}
end;

function DecodeBinHex(const Source: string): string;
var
  AData: string;
  ASize: integer;
{$IFDEF CLR}
  Buffer: TBytes;
{$ELSE}
  Buffer: string;
{$ENDIF}
begin
  AData := RemoveControlChars(Source);

  
  ASize := length(AData) div 2;
  if ASize * 2 <> length(AData) then
    raise EFilerError.Create(sxeErrorCalcStreamLength);

  SetLength(Buffer, ASize);
{$IFDEF CLR}
  HexToBin(BytesOf(AData), 0, Buffer, 0, ASize);
{$ELSE}
{$IFDEF D4UP}
  HexToBin(PChar(AData), PChar(Buffer), ASize);
{$ELSE}
  raise Exception.Create(sxeUnsupportedEncoding);
{$ENDIF}
{$ENDIF}
  Result := Buffer;
end;

{ TXmlNode }

procedure TXmlNode.Assign(Source: TPersistent);
var
  i: integer;
  ANode: TXmlNode;
begin
  if Source is TXmlNode then begin
    
    Clear;

    
    FElementType := TXmlNode(Source).FElementType;
    FName := TXmlNode(Source).FName;
    FTag := TXmlNode(Source).FTag;
    FValue := TXmlNode(Source).FValue;

    
    if assigned(TXmlNode(Source).FAttributes) then begin
      CheckCreateAttributesList;
      FAttributes.Assign(TXmlNode(Source).FAttributes);
    end;

    
    for i := 0 to TXmlNode(Source).NodeCount - 1 do begin
      ANode := NodeNew('');
      ANode.Assign(TXmlNode(Source).Nodes[i]);
    end;
  end else if Source is TNativeXml then begin
    Assign(TNativeXml(Source).FRootNodes);
  end else
    inherited;
end;

procedure TXmlNode.AttributeAdd(const AName, AValue: string);
var
  Attr: string;
begin
  Attr := Format('%s=%s', [AName, QuoteString(EscapeString(AValue))]);
  CheckCreateAttributesList;
  FAttributes.Add(Attr);
end;

{$IFDEF D4UP}
procedure TXmlNode.AttributeAdd(const AName: string; AValue: integer);
begin
  AttributeAdd(AName, IntToStr(AValue));
end;
{$ENDIF}

procedure TXmlNode.AttributeDelete(Index: integer);
begin
  if (Index >= 0) and (Index < AttributeCount) then
    FAttributes.Delete(Index);
end;

procedure TXmlNode.AttributeExchange(Index1, Index2: integer);
var
  Temp: string;
begin
  if (Index1 <> Index2) and
     (Index1 >= 0) and (Index1 < FAttributes.Count) and
     (Index2 >= 0) and (Index2 < FAttributes.Count) then
  begin
    Temp := FAttributes[Index1];
    FAttributes[Index1] := FAttributes[Index2];
    FAttributes[Index2] := Temp;
  end;
end;

function TXmlNode.AttributeIndexByname(const AName: string): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to AttributeCount - 1 do
    if AnsiCompareText(AttributeName[i], AName) = 0 then begin
      Result := i;
      exit;
    end;
end;

procedure TXmlNode.AttributesClear;
begin
  FreeAndNil(FAttributes);
end;

function TXmlNode.BufferLength: integer;
var
  AData: string;
  APos: integer;
begin
  AData := RemoveControlChars(FValue);
  case BinaryEncoding of
  xbeBinHex:
    begin
      Result := length(AData) div 2;
      if Result * 2 <> length(AData) then
        raise EFilerError.Create(sxeErrorCalcStreamLength);
    end;
  xbeBase64:
    begin
      Result := length(AData) div 4;
      if Result * 4 <> length(AData) then
        raise EFilerError.Create(sxeErrorCalcStreamLength);
      Result := Result * 3;
      
      APos := length(AData);
      if (APos > 0) and (AData[APos] = cBase64PadChar) then begin
        dec(APos);
        dec(Result);
        if (APos > 0) and (AData[APos] = cBase64PadChar) then
          dec(Result);
      end;
    end;
  else
    Result := 0; 
  end;
end;

procedure TXmlNode.BufferRead(var Buffer{$IFDEF CLR}: TBytes{$ENDIF}; Count: Integer);
var
  AData: string;
begin
  AData := RemoveControlChars(FValue);
  case BinaryEncoding of
  xbeBinHex:
    DecodeBinHexBuf(AData, Buffer, Count);
  xbeBase64:
    DecodeBase64Buf(AData, Buffer, Count);
  end;
end;

procedure TXmlNode.BufferWrite(const Buffer{$IFDEF CLR}: TBytes{$ENDIF}; Count: Integer);
var
  AData: string;
begin
  if Count > 0 then
    case BinaryEncoding of
    xbeBinHex:
      AData := EncodeBinHexBuf(Buffer, Count);
    xbeBase64:
      AData := EncodeBase64Buf(Buffer, Count);
    end;

  
  FValue := AddControlChars(AData, GetLineFeed + GetIndent, 76);
end;

procedure TXmlNode.CheckCreateAttributesList;
begin
  if not assigned(FAttributes) then begin
    FAttributes := TStringList.Create;
    if assigned(FDocument) then
      FAttributes.Sorted := FDocument.SortAttributes;
  end;
end;

procedure TXmlNode.Clear;
begin
  
  FName  := '';
  FValue := '';
  
  AttributesClear;
  NodesClear;
end;

function TXmlNode.CompareNodeName(const NodeName: string): integer;
begin
  
  if (length(NodeName) > 0) and (NodeName[1] = '/') then
    Result := AnsiCompareText(FullPath, NodeName)
  else
    Result := AnsiCompareText(Name, NodeName);
end;

constructor TXmlNode.Create(ADocument: TNativeXml);
begin
  inherited Create;
  FDocument := ADocument;
end;

constructor TXmlNode.CreateName(ADocument: TNativeXml;
  const AName: string);
begin
  Create(ADocument);
  Name := AName;
end;

constructor TXmlNode.CreateNameValue(ADocument: TNativeXml; const AName,
  AValue: string);
begin
  Create(ADocument);
  Name := AName;
  ValueAsString := AValue;
end;

constructor TXmlNode.CreateType(ADocument: TNativeXml;
  AType: TXmlElementType);
begin
  Create(ADocument);
  FElementType  := AType;
end;

procedure TXmlNode.Delete;
begin
  if assigned(Parent) then
    Parent.NodeRemove(Self);
end;

procedure TXmlNode.DeleteEmptyNodes;
var
  i: integer;
  ANode: TXmlNode;
begin
  for i := NodeCount - 1 downto 0 do begin
    ANode := Nodes[i];
    
    ANode.DeleteEmptyNodes;
    
    if ANode.IsEmpty then
      NodeDelete(i);
  end;
end;

destructor TXmlNode.Destroy;
begin
  NodesClear;
  AttributesClear;
  inherited;
end;

function TXmlNode.FindNode(const NodeName: string): TXmlNode;
var
  i: integer;
begin
  Result := nil;
  
  for i := 0 to NodeCount - 1 do begin
    Result := Nodes[i];
    
    if Result.CompareNodeName(NodeName) = 0 then
      exit;
    
    Result := Result.FindNode(NodeName);
    if assigned(Result) then
      exit;
  end;
end;

procedure TXmlNode.FindNodes(const NodeName: string; const AList: TList);
procedure FindNodesRecursive(ANode: TXmlNode; AList: TList);
var
  i: integer;
begin
  with ANode do
    for i := 0 to NodeCount - 1 do begin
      if Nodes[i].CompareNodeName(NodeName) = 0 then
        AList.Add(Nodes[i]);
      FindNodesRecursive(Nodes[i], AList);
    end;
end;
begin
  AList.Clear;
  FindNodesRecursive(Self, AList);
end;

function TXmlNode.FromAnsiString(const s: string): string;
begin
  if Utf8Encoded then
    Result := sdAnsiToUtf8(s)
  else
    Result := s;
end;

function TXmlNode.FromWidestring(const W: widestring): string;
begin
  if Utf8Encoded then
    Result := sdUnicodeToUtf8(W)
  else
    Result := W;
end;

function TXmlNode.GetAttributeByName(const AName: string): string;
begin
  if assigned(FAttributes) then
    Result := UnEscapeString(UnQuoteString(FAttributes.Values[AName]))
  else
    Result := '';
end;

function TXmlNode.GetAttributeCount: integer;
begin
  if assigned(FAttributes) then
    Result := FAttributes.Count
  else
    Result := 0;
end;

function TXmlNode.GetAttributeName(Index: integer): string;
begin
  if (Index >= 0) and (Index < AttributeCount) then
    Result := FAttributes.Names[Index];
end;

function TXmlNode.GetAttributePair(Index: integer): string;
begin
  if (Index >= 0) and (Index < AttributeCount) then
    Result := FAttributes[Index];
end;

function TXmlNode.GetAttributeValue(Index: integer): string;
var
  P: integer;
  S: string;
begin
  Result := '';
  if (Index >= 0) and (Index < AttributeCount) then begin
    S := FAttributes[Index];
    P := AnsiPos('=', S);
    if P > 0 then
      Result := UnEscapeString(UnQuoteString(Copy(S, P + 1, MaxInt)));
  end;
end;

function TXmlNode.GetAttributeValueAsInteger(Index: integer): integer;
begin
  Result := StrToIntDef(GetAttributeValue(Index), 0);
end;

function TXmlNode.GetAttributeValueAsWidestring(Index: integer): widestring;
begin
  Result := ToWidestring(GetAttributeValue(Index));
end;

function TXmlNode.GetBinaryEncoding: TBinaryEncodingType;
begin
  Result := xbeBinHex;
  if assigned(Document) then
    Result := Document.BinaryEncoding;
end;

function TXmlNode.GetBinaryString: string;
var
  OldEncoding: TBinaryEncodingType;
{$IFDEF CLR}
  Buffer: TBytes;
{$ENDIF}
begin
  
  OldEncoding := BinaryEncoding;
  try
    BinaryEncoding := xbeBase64;
    {$IFDEF CLR}
    SetLength(Buffer, BufferLength);
    if length(Buffer) > 0 then
      BufferRead(Buffer, length(Buffer));
    Result := Buffer;
    {$ELSE}
    SetLength(Result, BufferLength);
    if length(Result) > 0 then
      BufferRead(Result[1], length(Result));
    {$ENDIF}
  finally
    BinaryEncoding := OldEncoding;
  end;
end;

function TXmlNode.GetCascadedName: string;
var
  AName: string;
begin
  AName :=  Format('%s%.4d', [Name, StrToIntDef(AttributeByName['Index'], 0)]);
  if assigned(Parent) then
    Result := Format('%s_%s', [Parent.CascadedName, AName])
  else
    Result := AName;
end;

function TXmlNode.GetFullPath: string;
begin
  Result := '/' + Name;
  if Treedepth > 0 then
    
    Result := Parent.GetFullPath + Result;
end;

function TXmlNode.GetIndent: string;
var
  i: integer;
begin
  if assigned(Document) then
    case Document.XmlFormat of
    xfCompact: Result := '';
    xfReadable:
      for i := 0 to TreeDepth - 1 do
        Result := Result + Document.IndentString;
    end
  else
    Result := ''
end;

function TXmlNode.GetLineFeed: string;
begin
  if assigned(Document) then
    case Document.XmlFormat of
    xfCompact: Result := '';
    xfReadable: Result := #13#10;
    else
      Result := #10;
    end
  else
    Result := '';
end;

function TXmlNode.GetNodeCount: integer;
begin
  if Assigned(FNodes) then
    Result := FNodes.Count
  else
    Result := 0;
end;

function TXmlNode.GetNodes(Index: integer): TXmlNode;
begin
  if (Index >= 0) and (Index < NodeCount) then
    Result := TXmlNode(FNodes[Index])
  else
    Result := nil;
end;

function TXmlNode.GetTreeDepth: integer;
begin
  Result := -1;
  if assigned(Parent) then
    Result := Parent.TreeDepth + 1;
end;

function TXmlNode.GetValueAsBool: boolean;
var
  Ch: Char;
begin
  if Length(FValue) > 0 then begin
    Ch := UpCase(FValue[1]);
    if Ch in ['T', 'Y'] then begin
      Result := True;
      exit;
    end;
    if Ch in ['F', 'N'] then begin
      Result := False;
      exit;
    end;
  end;
  raise Exception.Create(sxeCannotConverToBool);
end;

function TXmlNode.GetValueAsDateTime: TDateTime;
begin
  Result := sdDateTimeFromString(ValueAsString);
end;

function TXmlNode.GetValueAsFloat: double;
var
  Code: integer;
begin
  val(StringReplace(FValue, ',', '.', []), Result, Code);
  if Code > 0 then
    raise Exception.Create(sxeCannotConvertToFloat);
end;

{$IFDEF D4UP}
function TXmlNode.GetValueAsInt64: int64;
begin
  Result := StrToInt(FValue);
end;
{$ENDIF}

function TXmlNode.GetValueAsInteger: integer;
begin
  Result := StrToInt(FValue);
end;

function TXmlNode.GetValueAsString: string;
begin
  Result := UnEscapeString(FValue);
end;

function TXmlNode.GetValueAsWidestring: widestring;
begin
  Result := ToWidestring(ValueAsString);
end;

function TXmlNode.GetWriteOnDefault: boolean;
begin
  Result := True;
  if assigned(Document) then
    Result := Document.WriteOnDefault;
end;

function TXmlNode.HasAttribute(const AName: string): boolean;
var
  i: integer;
begin
  Result := False;
  for i := 0 to AttributeCount - 1 do
    if AnsiCompareText(AName, AttributeName[i]) = 0 then begin
      Result := True;
      exit;
    end;
end;

function TXmlNode.IndexInParent: integer;
var
  i: integer;
begin
  Result := -1;
  if assigned(Parent) then
    for i := 0 to Parent.NodeCount - 1 do
      if Self = Parent.Nodes[i] then begin
        Result := i;
        exit;
      end;
end;

function TXmlNode.IsClear: boolean;
begin
  Result := (Length(FName) = 0) and IsEmpty;
end;

function TXmlNode.IsEmpty: boolean;
begin
  Result := (Length(FValue) = 0) and (NodeCount = 0) and (AttributeCount = 0);
end;

function TXmlNode.IsEqualTo(ANode: TXmlNode; Options: TXmlCompareOptions;
  MismatchNodes: TList): boolean;
var
  i, AIndex: integer;
  NodeResult, ChildResult: boolean;
begin
  
  Result := False;
  NodeResult := False;
  if not assigned(ANode) then exit;

  
  ChildResult := True;

  
  if (xcChildNames in Options) or (xcChildValues in Options) or (xcRecursive in Options) then
    for i := 0 to NodeCount - 1 do begin
      
      AIndex := ANode.NodeIndexByName(Nodes[i].Name);
      
      if AIndex < 0 then begin
        
        if xcChildNames in Options then begin
          if assigned(MismatchNodes) then MismatchNodes.Add(Nodes[i]);
          ChildResult := False;
        end;
      end else begin
        
        if xcChildValues in Options then
          if AnsiCompareText(Nodes[i].ValueAsString, ANode.Nodes[AIndex].ValueAsString) <> 0 then begin
            if assigned(MismatchNodes) then MismatchNodes.Add(Nodes[i]);
            ChildResult := False;
          end;
        
        if xcRecursive in Options then
          if not Nodes[i].IsEqualTo(ANode.Nodes[AIndex], Options, MismatchNodes) then
            ChildResult := False;
      end;
    end;

  try
    
    NodeResult := False;

    
    if xcNodeName in Options then
      if AnsiCompareText(Name, ANode.Name) <> 0 then exit;

    if xcNodeType in Options then
      if ElementType <> ANode.ElementType then exit;

    if xcNodeValue in Options then
      if AnsiCompareText(ValueAsString, ANode.ValueAsString) <> 0 then exit;

    
    if xcAttribCount in Options then
      if AttributeCount <> ANode.AttributeCount then exit;

    
    if (xcAttribNames in Options) or (xcAttribValues in Options) then
      for i := 0 to AttributeCount - 1 do begin
        AIndex := ANode.AttributeIndexByName(AttributeName[i]);
        if AIndex < 0 then
          if xcAttribNames in Options then
            exit
          else
            continue;
        if xcAttribValues in Options then
          if AnsiCompareText(AttributeValue[i], ANode.AttributeValue[AIndex]) <> 0 then
            exit;
      end;

    
    if xcChildCount in Options then
      if NodeCount <> ANode.NodeCount then exit;

    
    NodeResult := True;

  finally

    Result := ChildResult and NodeResult;
    if (not NodeResult) and assigned(MismatchNodes) then
      MismatchNodes.Insert(0, Self);

  end;
end;

function TXmlNode.NodeAdd(ANode: TXmlNode): integer;
begin
  if assigned(ANode) then begin
    ANode.Parent := Self;
    if not assigned(FNodes) then FNodes := TList.Create;
    Result := FNodes.Add(ANode);
  end else
    Result := -1;
end;

function TXmlNode.NodeByAttributeValue(const NodeName, AttribName, AttribValue: string;
  ShouldRecurse: boolean): TXmlNode;
var
  i: integer;
  ANode: TXmlNode;
begin
  Result := nil;
  
  for i := 0 to NodeCount - 1 do begin
    ANode := Nodes[i];
    if (AnsiCompareText(ANode.Name, NodeName) = 0) and
        ANode.HasAttribute(AttribName) and
       (AnsiCompareText(ANode.AttributeByName[AttribName], AttribValue) = 0) then begin
      Result := ANode;
      exit;
    end;
    
    if ShouldRecurse then
      Result := ANode.NodeByAttributeValue(NodeName, AttribName, AttribValue, True);
    if assigned(Result) then exit;
  end;
end;

function TXmlNode.NodeByElementType(
  ElementType: TXmlElementType): TXmlNode;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to NodeCount - 1 do
    if Nodes[i].ElementType = ElementType then begin
      Result := Nodes[i];
      exit;
    end;
end;

function TXmlNode.NodeByName(const AName: string): TXmlNode;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to NodeCount - 1 do
    if AnsiCompareText(Nodes[i].Name, AName) = 0 then begin
      Result := Nodes[i];
      exit;
    end;
end;

procedure TXmlNode.NodeDelete(Index: integer);
begin
  if (Index >= 0) and (Index < NodeCount) then begin
    TXmlNode(FNodes[Index]).Free;
    FNodes.Delete(Index);
  end;
end;

procedure TXmlNode.NodeExchange(Index1, Index2: integer);
begin
  if (Index1 >= 0) and (Index1 < Nodecount) and
     (Index2 >= 0) and (Index2 < Nodecount) then
    FNodes.Exchange(Index1, Index2);
end;

function TXmlNode.NodeExtract(ANode: TXmlNode): TXmlNode;
var
  AIndex: integer;
begin
  
  Result := nil;
  if assigned(FNodes) then begin
    AIndex := FNodes.IndexOf(ANode);
    if AIndex >= 0 then begin
      Result := ANode;
      FNodes.Delete(AIndex);
    end;
  end;
end;

function TXmlNode.NodeFindOrCreate(const AName: string): TXmlNode;
begin
  Result := NodeByName(AName);
  if not assigned(Result) then
    Result := NodeNew(AName);
end;

function TXmlNode.NodeIndexByName(const AName: string): integer;
begin
  Result := 0;
  while Result < NodeCount do begin
    if AnsiCompareText(Nodes[Result].Name, AName) = 0 then exit;
    inc(Result);
  end;
  if Result = NodeCount then Result := -1;
end;

function TXmlNode.NodeIndexByNameFrom(const AName: string;
  AFrom: integer): integer;
begin
  Result := AFrom;
  while Result < NodeCount do begin
    if AnsiCompareText(Nodes[Result].Name, AName) = 0 then exit;
    inc(Result);
  end;
  if Result = NodeCount then Result := -1;
end;

function TXmlNode.NodeIndexOf(ANode: TXmlNode): integer;
begin
  if assigned(ANode) and assigned(FNodes) then
    Result := FNodes.IndexOf(ANode)
  else
    Result := -1;
end;

procedure TXmlNode.NodeInsert(Index: integer; ANode: TXmlNode);
begin
  if not assigned(ANode) then exit;
  if (Index >=0) and (Index <= NodeCount) then begin
    if not assigned(FNodes) then FNodes := TList.Create;
    ANode.Parent := Self;
    FNodes.Insert(Index, ANode);
  end;
end;

function TXmlNode.NodeNew(const AName: string): TXmlNode;
begin
  Result := Nodes[NodeAdd(TXmlNode.CreateName(Document, AName))];
end;

function TXmlNode.NodeNewAtIndex(Index: integer;
  const AName: string): TXmlNode;
begin
  if (Index >= 0) and (Index <= NodeCount) then begin
    Result := TXmlNode.CreateName(Document, AName);
    NodeInsert(Index, Result);
  end else
    Result := nil;
end;

function TXmlNode.NodeRemove(ANode: TxmlNode): integer;
begin
  Result := NodeIndexOf(ANode);
  if Result >= 0 then
    NodeDelete(Result);
end;

procedure TXmlNode.NodesByName(const AName: string; const AList: TList);
var
  i: integer;
begin
  if not assigned(AList) then exit;
  AList.Clear;
  for i := 0 to NodeCount - 1 do
    if AnsiCompareText(Nodes[i].Name, AName) = 0 then
      AList.Add(Nodes[i]);
end;

procedure TXmlNode.NodesClear;
var
  i: integer;
begin
  for i := 0 to NodeCount - 1 do
    TXmlNode(FNodes[i]).Free;
  FreeAndNil(FNodes);
end;

procedure TXmlNode.ParseTag(const AValue: string; TagStart,
  TagClose: integer);
var
  FItems: TStringList;
begin
  
  FItems := TStringList.Create;
  try
    ParseAttributes(AValue, TagStart, TagClose, FItems);

    
    case ElementType of
    xeDeclaration:
      FName := 'xml';
    xeStyleSheet:
      begin
        FName := 'xml-stylesheet';
        
        ValueDirect := trim(copy(AValue, TagStart, TagClose - TagStart));
      end;
    else
      
      if FItems.Count = 0 then
        raise EFilerError.Create(sxeMissingElementName);

      
      FName := FItems[0];
      FItems.Delete(0);
    end;

    
    if FItems.Count > 0 then begin
      CheckCreateAttributesList;
      FAttributes.Assign(FItems);
    end;

  finally
    FItems.Free;
  end;
end;

function TXmlNode.QualifyAsDirectNode: boolean;
begin
  Result :=
    (Length(FValue) = 0) and
    (NodeCount = 0) and
    (ElementType = xeNormal) and
    not UseFullNodes and
    (TreeDepth > 0);
end;

function TXmlNode.ReadAttributeInteger(const AName: string;
  ADefault: integer): integer;
begin
  Result := StrToIntDef(AttributeByName[AName], ADefault);
end;

function TXmlNode.ReadAttributeString(const AName: string; const ADefault: string): string;
begin
  Result := AttributeByName[AName];
  if length(Result) = 0 then
    Result := ADefault;
end;

function TXmlNode.ReadBool(const AName: string;
  ADefault: boolean): boolean;
var
  AIndex: integer;
begin
  Result := ADefault;
  AIndex := NodeIndexByName(AName);
  if AIndex >= 0 then
    Result := Nodes[AIndex].ValueAsBoolDef(ADefault);
end;

{$IFDEF USEGRAPHICS}
procedure TXmlNode.ReadBrush(const AName: string; ABrush: TBrush);
var
  AChild: TXmlNode;
begin
  AChild := NodeByName(AName);
  if assigned(AChild) then with AChild do begin
    
    ABrush.Color  := ReadColor('Color', clWhite);
    ABrush.Style  := TBrushStyle(ReadInteger('Style', integer(bsSolid)));
  end else begin
    
    ABrush.Bitmap := nil;
    ABrush.Color  := clWhite;
    ABrush.Style  := bsSolid;
  end;
end;

function TXmlNode.ReadColor(const AName: string; ADefault: TColor): TColor;
var
  AIndex: integer;
begin
  Result := ADefault;
  AIndex := NodeIndexByName(AName);
  if AIndex >= 0 then
    Result := StrToInt(Nodes[AIndex].ValueAsString);
end;
{$ENDIF}

function TXmlNode.ReadDateTime(const AName: string;
  ADefault: TDateTime): TDateTime;
begin
  Result := sdDateTimeFromStringDefault(ReadString(AName, ''), ADefault);
end;

function TXmlNode.ReadFloat(const AName: string; ADefault: double): double;
var
  AIndex: integer;
begin
  Result := ADefault;
  AIndex := NodeIndexByName(AName);
  if AIndex >= 0 then
    Result := Nodes[AIndex].ValueAsFloatDef(ADefault);
end;

{$IFDEF USEGRAPHICS}
procedure TXmlNode.ReadFont(const AName: string; AFont: TFont);
var
  AChild: TXmlNode;
begin
  AChild := NodeByName(AName);
  AFont.Style := [];
  if assigned(AChild) then with AChild do begin
    
    AFont.Name  := ReadString('Name', 'Arial');
    AFont.Color := ReadColor('Color', clBlack);
    AFont.Size  := ReadInteger('Size', 14);
    if ReadBool('Bold', False)      then AFont.Style := AFont.Style + [fsBold];
    if ReadBool('Italic', False)    then AFont.Style := AFont.Style + [fsItalic];
    if ReadBool('Underline', False) then AFont.Style := AFont.Style + [fsUnderline];
    if ReadBool('Strikeout', False) then AFont.Style := AFont.Style + [fsStrikeout];
  end else begin
    
    AFont.Name  := 'Arial';
    AFont.Color := clBlack;
    AFont.Size  := 14;
  end;
end;
{$ENDIF}

procedure TXmlNode.ReadFromStream(S: TStream);
var
  Ch: Char;
  i: integer;
  ATagIndex: integer;
  AValue, ASurplus: string;
  ALength: integer;
  ANode: TXmlNode;
  ANodeValue: string;
  AValuePos, AValueLength: integer;
  AClose: integer;
  HasCR: boolean;
  HasSubtags: boolean;
  Words: TStringList;
  IsDirect: boolean;
function ReadCharSkipBlanks: boolean;
begin
  Result := False;
  repeat
    
    if S.Read(Ch, 1) = 0 then exit;
    
    if not (Ch in cControlchars) then break;
  until False;
  Result := True;
end;
procedure AddCharDataNode;
var
  AValue: string;
  ANode: TXmlNode;
begin
  
  if AValuePos > 0 then begin
    AValue := copy(ANodeValue, 1, AValuePos);
    if length(trim(AValue)) > 0 then begin
      ANode := TXmlNode.CreateType(Document, xeCharData);
      ANode.ValueDirect := AValue;
      NodeAdd(ANode);
    end;
    AValuePos := 0;
  end;
end;
begin
  
  if assigned(Document) and Document.AbortParsing then exit;
  
  AValuePos := 0;
  AValueLength := 80;
  SetLength(ANodeValue, AValueLength);
  HasCR := False;
  HasSubTags := False;
  
  if not ReadCharSkipBlanks then exit;

  
  if Ch = '<' then begin
    
    ATagIndex := ReadOpenTag(S, ASurplus);
    if ATagIndex >= 0 then begin
      try
        ElementType := cTags[ATagIndex].FStyle;
        case ElementType of
        xeNormal, xeDeclaration, xeStyleSheet:
          begin
            
            ReadStringFromStreamUntil(S, cTags[ATagIndex].FClose, ASurplus, AValue);
            ALength := length(AValue);

            
            IsDirect := False;
            if (ElementType = xeNormal) and (ALength > 0) and (AValue[ALength] = '/') then begin
              dec(ALength);
              IsDirect := True;
            end;
            ParseTag(AValue, 1, ALength + 1);

            
            if assigned(Document) then begin
              Document.DoNodeNew(Self);
              if Document.AbortParsing then exit;
            end;

            
            if IsDirect or (ElementType in [xeDeclaration, xeStyleSheet]) then exit;

            
            repeat

              
              if S.Read(Ch, 1) <> 1 then
                raise EFilerError.CreateFmt(sxeMissingCloseTag, [Name]);

              
              if Ch = '<' then begin
                if not ReadCharSkipBlanks then
                  raise EFilerError.CreateFmt(sxeMissingDataAfterGreaterThan, [Name]);
                if Ch = '/' then begin

                  
                  if not ReadStringFromStreamUntil(S, '>', ASurplus, AValue) then
                    raise EFilerError.CreateFmt(sxeMissingLessThanInCloseTag, [Name]);
                  if AnsiCompareText(trim(AValue), Name) <> 0 then
                    raise EFilerError.CreateFmt(sxeIncorrectCloseTag, [Name]);
                  AValue := '';
                  break;

                end else begin

                  
                  AddCharDataNode;

                  
                  
                  HasCR := False;

                  
                  HasSubTags := True;
                  S.Seek(-2, soCurrent);
                  ANode := TXmlNode.Create(Document);
                  NodeAdd(ANode);
                  ANode.ReadFromStream(S);

                  
                  if assigned(Document) and Document.DropCommentsOnParse and
                     (ANode.ElementType = xeComment) then
                    NodeDelete(NodeIndexOf(ANode));

                end;
              end else begin

                
                
                if Ch = #13 then HasCR := True;

                
                inc(AValuePos);
                if AValuePos > AValueLength then begin
                  inc(AValueLength, cNodeValueBuf);
                  SetLength(ANodeValue, AValueLength);
                end;
                ANodeValue[AValuePos] := Ch;

              end;
            until False;

            
            AddCharDataNode;

            
            
            if HasSubtags and HasCR then begin
              for i := 0 to NodeCount - 1 do
                if Nodes[i].ElementType = xeCharData then begin
                  AClose := length(Nodes[i].FValue);
                  while (AClose > 0) and (Nodes[i].FValue[AClose] in [#10, #13, ' ']) do
                    dec(AClose);
                  Nodes[i].FValue := copy(Nodes[i].FValue, 1, AClose);
                end;
            end;

            
            if (NodeCount > 0) and (Nodes[0].ElementType = xeCharData) then begin
              ValueDirect := Nodes[0].ValueDirect;
              NodeDelete(0);
            end;

          end;
        xeDocType:
          begin
            Name := 'DTD';
            if assigned(Document) then begin
              Document.DoNodeNew(Self);
              if Document.AbortParsing then exit;
            end;
            
            if assigned(Document) then Document.ParseDTD(Self, S);
          end;
        xeElement, xeAttList, xeEntity, xeNotation:
          begin
            
            ReadStringFromStreamWithQuotes(S, cTags[ATagIndex].FClose, AValue);
            ALength := length(AValue);
            Words := TStringList.Create;
            try
              ParseAttributes(AValue, 1, ALength + 1, Words);
              if Words.Count > 0 then begin
                Name := Words[0];
                Words.Delete(0);
              end;
              ValueDirect := trim(Words.Text);
            finally
              Words.Free;
            end;
            if assigned(Document) then begin
              Document.DoNodeNew(Self);
              if Document.AbortParsing then exit;
            end;
          end;
        else
          case ElementType of
          xeComment:  Name := 'Comment';
          xeCData:    Name := 'CData';
          xeExclam:   Name := 'Special';
          xeQuestion: Name := 'Special';
          else
            Name := 'Unknown';
          end;

          
          if assigned(Document) then begin
            Document.DoNodeNew(Self);
            if Document.AbortParsing then exit;
          end;

          
          ReadStringFromStreamUntil(S, cTags[ATagIndex].FClose, ASurplus, AValue);
          ValueDirect := AValue;
        end;
      finally
        
        if assigned(Document) and not Document.AbortParsing then begin
          Document.DoProgress(S.Position);
          Document.DoNodeLoaded(Self);
        end;
      end;
    end;
  end;

end;

procedure TXmlNode.ReadFromString(const AValue: string);
var
  S: TStream;
begin
  S := TStringStream.Create(AValue);
  try
    ReadFromStream(S);
  finally
    S.Free;
  end;
end;

{$IFDEF D4UP}
function TXmlNode.ReadInt64(const AName: string; ADefault: int64): int64;
var
  AIndex: integer;
begin
  Result := ADefault;
  AIndex := NodeIndexByName(AName);
  if AIndex >= 0 then
    Result := Nodes[AIndex].ValueAsInt64Def(ADefault);
end;
{$ENDIF}

function TXmlNode.ReadInteger(const AName: string; ADefault: integer): integer;
var
  AIndex: integer;
begin
  Result := ADefault;
  AIndex := NodeIndexByName(AName);
  if AIndex >= 0 then
    Result := Nodes[AIndex].ValueAsIntegerDef(ADefault);
end;

{$IFDEF USEGRAPHICS}
procedure TXmlNode.ReadPen(const AName: string; APen: TPen);
var
  AChild: TXmlNode;
begin
  AChild := NodeByName(AName);
  if assigned(AChild) then with AChild do begin
    
    APen.Color := ReadColor('Color', clBlack);
    APen.Mode  := TPenMode(ReadInteger('Mode', integer(pmCopy)));
    APen.Style := TPenStyle(ReadInteger('Style', integer(psSolid)));
    APen.Width := ReadInteger('Width', 1);
  end else begin
    
    APen.Color := clBlack;
    APen.Mode := pmCopy;
    APen.Style := psSolid;
    APen.Width := 1;
  end;
end;
{$ENDIF}

function TXmlNode.ReadString(const AName: string;
  const ADefault: string): string;
var
  AIndex: integer;
begin
  Result := ADefault;
  AIndex := NodeIndexByName(AName);
  if AIndex >= 0 then
    Result := Nodes[AIndex].ValueAsString;
end;

function TXmlNode.ReadWidestring(const AName: string;
  const ADefault: widestring): widestring;
begin
  Result := ToWidestring(ReadString(AName, FromWidestring(ADefault)));
end;

procedure TXmlNode.ResolveEntityReferences;
function SplitReference(const AValue: string; var Text1, Text2: string): string;
var
  APos: integer;
begin
  Result := '';
  APos := Pos('&', AValue);
  Text1 := '';
  Text2 := AValue;
  if APos = 0 then exit;
  Text1 := copy(AValue, 1, APos - 1);
  Text2 := copy(AValue, APos + 1, length(AValue));
  APos := Pos(';', Text2);
  if APos = 0 then exit;
  Result := copy(Text2, 1, APos - 1);
  Text2 := copy(Text2, APos + 1, length(Text2));
end;
function ReplaceEntityReferenceByNodes(ARoot: TXmlNode; const AValue: string; var InsertPos: integer; var Text1, Text2: string): boolean;
var
  Reference: string;
  Entity: string;
  ANode: TXmlNode;
  S: TStream;
begin
  Result := False;
  Reference := SplitReference(AValue, Text1, Text2);
  if (length(Reference) = 0) or not assigned(Document) then exit;

  
  Entity := Document.EntityByName[Reference];

  
  if (length(Entity) > 0) and (Pos('<', Entity) > 0) then begin
    S := TStringStream.Create(Entity);
    try
      while S.Position < S.Size do begin
        ANode := TXmlNode.Create(Document);
        ANode.ReadFromStream(S);
        if ANode.IsEmpty then
          ANode.Free
        else begin
          ARoot.NodeInsert(InsertPos, ANode);
          inc(InsertPos);
          Result := True;
        end;
      end;
    finally
      S.Free;
    end;
  end;
end;
var
  i: integer;
  InsertPos: integer;
  Text1, Text2: string;
  ANode: TXmlNode;
  AValue, Reference, Replace, Entity, First, Last: string;
begin
  if length(FValue) > 0 then begin
    
    if ElementType = xeNormal then begin
      InsertPos := 0;
      if ReplaceEntityReferenceByNodes(Self, FValue, InsertPos, Text1, Text2) then begin
        FValue := Text1;
        if length(trim(Text2)) > 0 then begin
          ANode := TXmlNode.CreateType(Document, xeCharData);
          ANode.ValueDirect := Text2;
          NodeInsert(InsertPos, ANode);
        end;
      end;
    end else if (ElementType = xeCharData) and assigned(Parent) then begin
      InsertPos := Parent.NodeIndexOf(Self);
      if ReplaceEntityReferenceByNodes(Parent, FValue, InsertPos, Text1, Text2) then begin
        FValue := Text1;
        if length(trim(FValue)) = 0 then FValue := '';
        if length(trim(Text2)) > 0 then begin
          ANode := TXmlNode.CreateType(Document, xeCharData);
          ANode.ValueDirect := Text2;
          Parent.NodeInsert(InsertPos, ANode);
        end;
      end;
    end;
  end;

  
  for i := 0 to AttributeCount - 1 do begin
    Last := AttributeValue[i];
    AValue := '';
    repeat
      Reference := SplitReference(Last, First, Last);
      Replace := '';
      if length(Reference) > 0 then begin
        Entity := Document.EntityByName[Reference];
        if length(Entity) > 0 then
           Replace := Entity
        else
          Replace := '&' + Reference + ';';
      end;
      AValue := AValue + First + Replace + Last;
    until length(Reference) = 0;
    AttributeValue[i] := AValue;
  end;

  
  i := 0;
  while i < NodeCount do begin
    Nodes[i].ResolveEntityReferences;
    inc(i);
  end;

  
  for i := NodeCount - 1 downto 0 do
    if (Nodes[i].ElementType = xeCharData) and (length(Nodes[i].ValueDirect) = 0) then
      NodeDelete(i);
end;

procedure TXmlNode.SetAttributeByName(const AName, Value: string);
begin
  CheckCreateAttributesList;
  FAttributes.Values[AName] := QuoteString(EscapeString(Value));
end;

procedure TXmlNode.SetAttributeName(Index: integer; const Value: string);
var
  S: string;
  P: integer;
begin
  if (Index >= 0) and (Index < AttributeCount) then begin
    S := FAttributes[Index];
    P := AnsiPos('=', S);
    if P > 0 then
      FAttributes[Index] := Format('%s=%s', [Value, Copy(S, P + 1, MaxInt)]);
  end;
end;

procedure TXmlNode.SetAttributeValue(Index: integer; const Value: string);
begin
  if (Index >= 0) and (Index < AttributeCount) then
    FAttributes[Index] := Format('%s=%s', [AttributeName[Index],
      QuoteString(EscapeString(Value))]);
end;

procedure TXmlNode.SetAttributeValueAsInteger(Index: integer;
  const Value: integer);
begin
  SetAttributeValue(Index, IntToStr(Value));
end;

procedure TXmlNode.SetAttributeValueAsWidestring(Index: integer;
  const Value: widestring);
begin
  SetAttributeValue(Index, FromWidestring(Value));
end;

procedure TXmlNode.SetBinaryEncoding(const Value: TBinaryEncodingType);
begin
  if assigned(Document) then
    Document.BinaryEncoding := Value;
end;

procedure TXmlNode.SetBinaryString(const Value: string);
var
  OldEncoding: TBinaryEncodingType;
begin
  
  OldEncoding := BinaryEncoding;
  try
    BinaryEncoding := xbeBase64;
    if length(Value) = 0 then begin
      ValueAsString := '';
      exit;
    end;
    
    {$IFDEF CLR}
    BufferWrite(BytesOf(Value), length(Value));
    {$ELSE}
    BufferWrite(Value[1], length(Value));
    {$ENDIF}
  finally
    BinaryEncoding := OldEncoding;
  end;
end;

procedure TXmlNode.SetName(const Value: string);
var
  i: integer;
begin
  if FName <> Value then begin
    
    
    for i := 1 to length(Value) do
      if Value[i] in cControlChars then
        raise Exception.Create(Format(sxeIllegalCharInNodeName, [Value]));
    FName := Value;
  end;
end;

procedure TXmlNode.SetValueAsBool(const Value: boolean);
const
  cBoolValues: array[boolean] of string = ('False', 'True');
begin
  FValue := cBoolValues[Value];
end;

procedure TXmlNode.SetValueAsDateTime(const Value: TDateTime);
begin
  ValueAsString := sdDateTimeToString(Value);
end;

procedure TXmlNode.SetValueAsFloat(const Value: double);
begin
  FValue := FloatToStr(Value);
end;

{$IFDEF D4UP}
procedure TXmlNode.SetValueAsInt64(const Value: int64);
begin
  FValue := IntToStr(Value);
end;
{$ENDIF}

procedure TXmlNode.SetValueAsInteger(const Value: integer);
begin
  FValue := IntToStr(Value);
end;

procedure TXmlNode.SetValueAsString(const AValue: string);
begin
  FValue := EscapeString(AValue);
end;

procedure TXmlNode.SetValueAsWidestring(const Value: widestring);
begin
  ValueAsString := FromWidestring(Value);
end;

procedure TXmlNode.SortChildNodes(Compare: TXMLNodeCompareFunction;
  Info: TPointer);
function DoNodeCompare(Node1, Node2: TXmlNode): integer;
begin
  if assigned(Compare) then
    Result := Compare(Node1, Node2, Info)
  else
    if assigned(Document) and assigned(Document.OnNodeCompare) then
      Result := Document.OnNodeCompare(Document, Node1, Node2, Info)
    else
      Result := AnsiCompareText(Node1.Name, Node2.Name);
end;
procedure QuickSort(iLo, iHi: Integer);
var
  Lo, Hi, Mid: longint;
begin
  Lo := iLo;
  Hi := iHi;
  Mid:= (Lo + Hi) div 2;
  repeat
    while DoNodeCompare(Nodes[Lo], Nodes[Mid]) < 0 do
      Inc(Lo);
    while DoNodeCompare(Nodes[Hi], Nodes[Mid]) > 0 do
      Dec(Hi);
    if Lo <= Hi then begin
      
      NodeExchange(Lo, Hi);
      if Mid = Lo then
        Mid := Hi
      else
        if Mid = Hi then
          Mid := Lo;
      Inc(Lo);
      Dec(Hi);
    end;
  until Lo > Hi;
  if Hi > iLo then QuickSort(iLo, Hi);
  if Lo < iHi then QuickSort(Lo, iHi);
end;
begin
  if NodeCount > 1 then
    QuickSort(0, NodeCount - 1);
end;

function TXmlNode.ToAnsiString(const s: string): string;
begin
  if Utf8Encoded then
    Result := sdUtf8ToAnsi(s)
  else
    Result := s;
end;

function TXmlNode.ToWidestring(const s: string): widestring;
begin
  if Utf8Encoded then
    Result := sdUtf8ToUnicode(s)
  else
    Result := s;
end;

function TXmlNode.UnescapeString(const AValue: string): string;
begin
  if Utf8Encoded then
    Result := UnescapeStringUTF8(AValue)
  else
    Result := UnescapeStringAnsi(AValue);
end;

function TXmlNode.UseFullNodes: boolean;
begin
  Result := False;
  if assigned(Document) then Result := Document.UseFullNodes;
end;

function TXmlNode.Utf8Encoded: boolean;
begin
  Result := False;
  if assigned(Document) then
    Result := Document.Utf8Encoded;
end;

function TXmlNode.ValueAsBoolDef(ADefault: boolean): boolean;
var
  Ch: Char;
begin
  Result := ADefault;
  if Length(FValue) = 0 then exit;
  Ch := UpCase(FValue[1]);
  if Ch in ['T', 'Y'] then begin
    Result := True;
    exit;
  end;
  if Ch in ['F', 'N'] then begin
    Result := False;
    exit;
  end;
end;

function TXmlNode.ValueAsDateTimeDef(ADefault: TDateTime): TDateTime;
begin
  Result := sdDateTimeFromStringDefault(ValueAsString, ADefault);
end;

function TXmlNode.ValueAsFloatDef(ADefault: double): double;
var
  Code: integer;
begin
  try
    val(StringReplace(FValue, ',', '.', []), Result, Code);
    if Code > 0 then
      Result := ADefault;
  except
    Result := ADefault;
  end;
end;

{$IFDEF D4UP}
function TXmlNode.ValueAsInt64Def(ADefault: int64): int64;
begin
  Result := StrToIntDef(FValue, ADefault);
end;
{$ENDIF}

function TXmlNode.ValueAsIntegerDef(ADefault: integer): integer;
begin
  Result := StrToIntDef(FValue, ADefault);
end;

procedure TXmlNode.WriteAttributeInteger(const AName: string; AValue: integer; ADefault: integer);
var
  AIndex: integer;
begin
  AIndex := AttributeIndexByName(AName);
  if AIndex >= 0 then
    AttributeValue[AIndex] := IntToStr(AValue)
  else
    AttributeAdd(AName, IntToStr(AValue));
end;

procedure TXmlNode.WriteAttributeString(const AName, AValue,
  ADefault: string);
var
  AIndex: integer;
begin
  AIndex := AttributeIndexByName(AName);
  if AIndex >= 0 then
    AttributeValue[AIndex] := AValue
  else
    AttributeAdd(AName, AValue);
end;

procedure TXmlNode.WriteBool(const AName: string; AValue: boolean; ADefault: boolean);
const
  cBoolValues: array[boolean] of string = ('False', 'True');
begin
  if WriteOnDefault or (AValue <> ADefault) then
    with NodeFindOrCreate(AName) do
      ValueAsString := cBoolValues[AValue];
end;

{$IFDEF USEGRAPHICS}
procedure TXmlNode.WriteBrush(const AName: string; ABrush: TBrush);
begin
  with NodeFindOrCreate(AName) do begin
    WriteColor('Color', ABrush.Color, clBlack);
    WriteInteger('Style', integer(ABrush.Style), 0);
  end;
end;

procedure TXmlNode.WriteColor(const AName: string; AValue, ADefault: TColor);
begin
  if WriteOnDefault or (AValue <> ADefault) then
    WriteHex(AName, ColorToRGB(AValue), 8, 0);
end;
{$ENDIF}

procedure TXmlNode.WriteDateTime(const AName: string; AValue,
  ADefault: TDateTime);
begin
  if WriteOnDefault or (AValue <> ADefault) then
    WriteString(AName, sdDateTimeToString(AValue), '');
end;

procedure TXmlNode.WriteFloat(const AName: string; AValue: double; ADefault: double);
begin
  if WriteOnDefault or (AValue <> ADefault) then
    with NodeFindOrCreate(AName) do
      ValueAsString := FloatToStr(AValue);
end;

{$IFDEF USEGRAPHICS}
procedure TXmlNode.WriteFont(const AName: string; AFont: TFont);
begin
  with NodeFindOrCreate(AName) do begin
    WriteString('Name', AFont.Name, 'Arial');
    WriteColor('Color', AFont.Color, clBlack);
    WriteInteger('Size', AFont.Size, 14);
    WriteBool('Bold', fsBold in AFont.Style, False);
    WriteBool('Italic', fsItalic in AFont.Style, False);
    WriteBool('Underline', fsUnderline in AFont.Style, False);
    WriteBool('Strikeout', fsStrikeout in AFont.Style, False);
  end;
end;
{$ENDIF}

procedure TXmlNode.WriteHex(const AName: string; AValue, Digits: integer; ADefault: integer);
begin
  if WriteOnDefault or (AValue <> ADefault) then
    with NodeFindOrCreate(AName) do
      ValueAsString := '$' + IntToHex(AValue, Digits);
end;

function TXmlNode.WriteInnerTag: string;
var
  i: integer;
begin
  
  for i := 0 to AttributeCount - 1 do begin
    Result := Result + ' ' + AttributePair[i];
  end;
  
  if QualifyAsDirectNode then
    Result := Result + '/';
end;

{$IFDEF D4UP}
procedure TXmlNode.WriteInt64(const AName: string; AValue, ADefault: int64);
begin
  if WriteOnDefault or (AValue <> ADefault) then
    with NodeFindOrCreate(AName) do
      ValueAsString := IntToStr(AValue);
end;
{$ENDIF}

procedure TXmlNode.WriteInteger(const AName: string; AValue: integer; ADefault: integer);
begin
  if WriteOnDefault or (AValue <> ADefault) then
    with NodeFindOrCreate(AName) do
      ValueAsString := IntToStr(AValue);
end;

{$IFDEF USEGRAPHICS}
procedure TXmlNode.WritePen(const AName: string; APen: TPen);
begin
  with NodeFindOrCreate(AName) do begin
    WriteColor('Color', APen.Color, clBlack);
    WriteInteger('Mode', integer(APen.Mode), 0);
    WriteInteger('Style', integer(APen.Style), 0);
    WriteInteger('Width', APen.Width, 0);
  end;
end;
{$ENDIF}

procedure TXmlNode.WriteString(const AName, AValue: string; const ADefault: string);
begin
  if WriteOnDefault or (AValue <> ADefault) then
    with NodeFindOrCreate(AName) do
      ValueAsString := AValue;
end;

procedure TXmlNode.WriteToStream(S: TStream);
var
  i: integer;
  AIndent: string;
  ALineFeed: string;
  ALine: string;
  ThisNode, NextNode: TXmlNode;
  AddLineFeed: boolean;
begin
  AIndent   := GetIndent;
  ALineFeed := GetLineFeed;

  
  ALine := {ALineFeed + }AIndent;

  
  case ElementType of
  xeDeclaration: 
    ALine := AIndent + Format('<?xml%s?>', [WriteInnerTag]);
  xeStylesheet: 
    ALine := AIndent + Format('<?xml-stylesheet%s?>', [WriteInnerTag]);
  xeDoctype:
    begin
      if NodeCount = 0 then
        ALine := AIndent + Format('<!DOCTYPE %s %s>', [Name, ValueDirect])
      else begin
        ALine := AIndent + Format('<!DOCTYPE %s %s [', [Name, ValueDirect]) + ALineFeed;
        WriteStringToStream(S, ALine);
        for i := 0 to NodeCount - 1 do begin
          Nodes[i].WriteToStream(S);
          WriteStringToStream(S, ALineFeed);
        end;
        ALine := ']>';
      end;
    end;
  xeElement:
    ALine := AIndent + Format('<!ELEMENT %s %s>', [Name, ValueDirect]);
  xeAttList:
    ALine := AIndent + Format('<!ATTLIST %s %s>', [Name, ValueDirect]);
  xeEntity:
    ALine := AIndent + Format('<!ENTITY %s %s>', [Name, ValueDirect]);
  xeNotation:
    ALine := AIndent + Format('<!NOTATION %s %s>', [Name, ValueDirect]);
  xeComment: 
    ALine := AIndent + Format('<!--%s-->', [ValueDirect]);
  xeCData: 
    ALine := AIndent + Format('<![CDATA[%s]]>', [ValueDirect]);
  xeExclam: 
    ALine := AIndent + Format('<!%s>', [ValueDirect]);
  xeQuestion: 
    ALine := AIndent + Format('<?%s?>', [ValueDirect]);
  xeCharData:
    ALine := FValue;
  xeUnknown: 
    ALine := AIndent + Format('<%s>', [ValueDirect]);
  xeNormal: 
    begin
      
      ALine := ALine + Format('<%s%s>', [FName, WriteInnerTag]);

      
      ALine := ALine + FValue;
      if (NodeCount > 0) then
        
        ALine := ALine + ALineFeed;

      WriteStringToStream(S, ALine);

      
      for i := 0 to NodeCount - 1 do begin
        ThisNode := Nodes[i];
        NextNode := Nodes[i + 1];
        ThisNode.WriteToStream(S);
        AddLineFeed := True;
        if ThisNode.ElementType = xeCharData then AddLineFeed := False;
        if assigned(NextNode) and (NextNode.ElementType = xeCharData) then AddLineFeed := False;
        if AddLineFeed then
          WriteStringToStream(S, ALineFeed);
      end;

      
      ALine := '';
      if not QualifyAsDirectNode then begin
        if NodeCount > 0 then
          ALine := AIndent;
        ALine := ALine + Format('</%s>', [FName]);
      end;
    end;
  else
    raise EFilerError.Create(sxeIllegalElementType);
  end;
  WriteStringToStream(S, ALine);

  
  if assigned(Document) then Document.DoProgress(S.Position);
end;

function TXmlNode.WriteToString: string;
var
  S: TStringStream;
begin
  
  
  S := TStringStream.Create('');
  try
    WriteToStream(S);
    Result := S.DataString;
  finally
    S.Free;
  end;
end;

procedure TXmlNode.WriteWidestring(const AName: string;
  const AValue: widestring; const ADefault: widestring);
begin
  WriteString(AName, FromWidestring(AValue), ADefault);
end;

{ TXmlNodeList }

function TXmlNodeList.GetItems(Index: Integer): TXmlNode;
begin
  Result := TXmlNode(Get(Index));
end;

procedure TXmlNodeList.SetItems(Index: Integer; const Value: TXmlNode);
begin
  Put(Index, TPointer(Value));
end;

{ TNativeXml }

procedure TNativeXml.Assign(Source: TPersistent);
procedure SetDocumentRecursively(ANode: TXmlNode; ADocument: TNativeXml);
var
  i: integer;
begin
  ANode.Document := ADocument;
  for i := 0 to ANode.NodeCount - 1 do
    SetDocumentRecursively(ANode.Nodes[i], ADocument);
end;
begin
  if Source is TNativeXml then begin
    
    FBinaryEncoding := TNativeXml(Source).FBinaryEncoding;
    FDropCommentsOnParse := TNativeXml(Source).FDropCommentsOnParse;
    FExternalEncoding := TNativeXml(Source).FExternalEncoding;
    FParserWarnings := TNativeXml(Source).FParserWarnings;
    FIndentString := TNativeXml(Source).FIndentString;
    FUseFullNodes := TNativeXml(Source).FUseFullNodes;
    FUtf8Encoded := TNativeXml(Source).FUtf8Encoded;
    FWriteOnDefault := TNativeXml(Source).FWriteOnDefault;
    FXmlFormat := TNativeXml(Source).FXmlFormat;
    FSortAttributes := TNativeXml(Source).FSortAttributes;
    
    FRootNodes.Assign(TNativeXml(Source).FRootNodes);
    
    SetDocumentRecursively(FRootNodes, Self);
  end else if Source is TXmlNode then begin
    
    FRootNodes.Assign(Source);
    
    SetDocumentRecursively(FRootNodes, Self);
  end else
    inherited;
end;

procedure TNativeXml.Clear;
var
  ANode: TXmlNode;
begin
  
  SetDefaults;
  
  FRootNodes.Clear;
  
  
  ANode := TXmlNode.CreateType(Self, xeDeclaration);
  ANode.Name := 'xml';
  ANode.AttributeAdd('version', cDefaultVersionString);
  ANode.AttributeAdd('encoding', cDefaultEncodingString);
  FRootNodes.NodeAdd(ANode);
  
  FRootNodes.NodeNew('');
end;

procedure TNativeXml.CopyFrom(Source: TNativeXml);
begin
  if not assigned(Source) then exit;
  Assign(Source);
end;

constructor TNativeXml.Create;
begin
  inherited Create;
  FRootNodes := TXmlNode.Create(Self);
  Clear;
end;

constructor TNativeXml.CreateName(const ARootName: string);
begin
  Create;
  Root.Name := ARootName;
end;

destructor TNativeXml.Destroy;
begin
  FreeAndNil(FRootNodes);
  inherited;
end;

procedure TNativeXml.DoNodeLoaded(Node: TXmlNode);
begin
  if assigned(FOnNodeLoaded) then
    FOnNodeLoaded(Self, Node);
end;

procedure TNativeXml.DoNodeNew(Node: TXmlNode);
begin
  if assigned(FOnNodeNew) then
    FOnNodeNew(Self, Node);
end;

procedure TNativeXml.DoProgress(Size: integer);
begin
  if assigned(FOnProgress) then FOnProgress(Self, Size);
end;

procedure TNativeXml.DoUnicodeLoss(Sender: TObject);
begin
  if assigned(FOnUnicodeLoss) then FOnUnicodeLoss(Self);
end;

function TNativeXml.GetCommentString: string;
var
  ANode: TXmlNode;
begin
  Result := '';
  ANode := FRootNodes.NodeByElementType(xeComment);
  if assigned(ANode) then
    Result := ANode.ValueAsString;
end;

function TNativeXml.GetEncodingString: string;
begin
  Result := '';
  if (FRootNodes.NodeCount > 0) and (FRootNodes[0].ElementType = xeDeclaration) then
    Result := FRootNodes[0].AttributeByName['encoding'];
end;

function TNativeXml.GetEntityByName(AName: string): string;
var
  i, j: integer;
begin
  Result := '';
  for i := 0 to FRootNodes.NodeCount - 1 do
    if FRootNodes[i].ElementType = xeDoctype then with FRootNodes[i] do begin
      for j := 0 to NodeCount - 1 do
        if (Nodes[j].ElementType = xeEntity) and (Nodes[j].Name = AName) then begin
          Result := UnQuoteString(Trim(Nodes[j].ValueDirect));
          exit;
        end;
    end;
end;

function TNativeXml.GetRoot: TXmlNode;
begin
  Result := FRootNodes.NodeByElementType(xeNormal);
end;

function TNativeXml.GetStyleSheetString: string;
var
  ANode: TXmlNode;
begin
  Result := '';
  ANode := FRootNodes.NodeByElementType(xeStyleSheet);
  if assigned(ANode) then
    Result := ANode.ValueAsString;
end;

function TNativeXml.GetVersionString: string;
begin
  Result := '';
  if (FRootNodes.NodeCount > 0) and (FRootNodes[0].ElementType = xeDeclaration) then
    Result := FRootNodes[0].AttributeByName['version'];
end;

function TNativeXml.IsEmpty: boolean;
var
  ARoot: TXmlNode;
begin
  Result := True;
  ARoot := GetRoot;
  if assigned(ARoot) then Result := ARoot.IsClear;
end;

function TNativeXml.LineFeed: string;
begin
  case XmlFormat of
  xfReadable: Result := #13#10;
  xfCompact:  Result := #10;
  else
    Result := #10;
  end;
end;

procedure TNativeXml.LoadFromFile(const FileName: string);
var
  S: TStream;
begin
  S := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(S);
  finally
    S.Free;
  end;
end;

procedure TNativeXml.LoadFromStream(Stream: TStream);
var
  B: TsdBufferedReadStream;
begin
  
  
  B := TsdBufferedReadStream.Create(Stream, False);
  try
    
    if Utf8Encoded then
      FCodecStream := TsdUtf8Stream.Create(B)
    else
      FCodecStream := TsdAnsiStream.Create(B);
    try
      
      FCodecStream.OnUnicodeLoss := DoUnicodeLoss;
      
      ReadFromStream(FCodecStream);
      
      FExternalEncoding := FCodecStream.Encoding;
      
      if (ExternalEncoding = seUtf8) or (EncodingString = 'UTF-8') then
        FUtf8Encoded := True;
    finally
      FreeAndNil(FCodecStream);
    end;
  finally
    B.Free;
  end;
end;

procedure TNativeXml.ParseDTD(ANode: TXmlNode; S: TStream);
procedure ParseMarkupDeclarations;
var
  Ch: char;
begin
  repeat
    ANode.NodeNew('').ReadFromStream(S);
    
    repeat
      if S.Read(Ch, 1) = 0 then exit;
    
    until not (Ch in cControlChars);
    if Ch = ']' then break;
    S.Seek(-1, soCurrent);
  until False;
end;
var
  Prework: string;
  Ch: char;
  Words: TStringList;
begin
  
  Prework := '';
  repeat
    
    if S.Read(Ch, 1) = 0 then exit;
    
    if Ch in ['[', '>'] then break;
    Prework := Prework + Ch;
  until False;
  Words := TStringList.Create;
  try
    ParseAttributes(Prework, 1, length(Prework) + 1, Words);
    
    if Words.Count > 0 then begin
      ANode.Name := Words[0];
      Words.Delete(0);
      
      ANode.ValueDirect := Trim(StringReplace(Words.Text, #13#10, ' ', [rfReplaceAll]));
    end;
  finally
    Words.Free;
  end;

  if Ch = '[' then begin

    
    ParseMarkupDeclarations;

    
    repeat
      if S.Read(Ch, 1) = 0 then exit;
      if Ch = '>' then break;
    until False;

  end;

end;

procedure TNativeXml.ReadFromStream(S: TStream);
var
  i: integer;
  ANode: TXmlNode;
  AEncoding: string;
  NormalCount, DeclarationCount,
  DoctypeCount, CDataCount: integer;
  NormalPos, DoctypePos: integer;
begin
  FAbortParsing := False;
  with FRootNodes do begin
    
    Clear;
    DoProgress(0);
    repeat
      ANode := NodeNew('');
      ANode.ReadFromStream(S);
      if AbortParsing then exit;

      
      if ANode.ElementType = xeDeclaration then begin
        if ANode.HasAttribute('encoding') then
          AEncoding := ANode.AttributeByName['encoding'];
        
        if assigned(FCodecStream) and (AEncoding = 'UTF-8') then
          FCodecStream.Encoding := seUTF8;
      end;
      
      if ANode.IsClear then
        NodeDelete(NodeCount - 1);
    until S.Position >= S.Size;
    DoProgress(S.Size);

    
    NormalCount      := 0;
    DeclarationCount := 0;
    DoctypeCount     := 0;
    CDataCount       := 0;
    NormalPos        := -1;
    DoctypePos       := -1;
    for i := 0 to NodeCount - 1 do begin
      
      case Nodes[i].ElementType of
      xeNormal:
        begin
          inc(NormalCount);
          NormalPos := i;
        end;
      xeDeclaration: inc(DeclarationCount);
      xeDoctype:
        begin
          inc(DoctypeCount);
          DoctypePos := i;
        end;
      xeCData: inc(CDataCount);
      end;
    end;

    
    if NormalCount = 0 then
      raise EFilerError.Create(sxeNoRootElement);

    
    if FParserWarnings then begin

      
      if NormalCount > 1 then raise EFilerError.Create(sxeMoreThanOneRootElement);

      
      if DeclarationCount > 1 then raise EFilerError.Create(sxeMoreThanOneDeclaration);

      
      if (DeclarationCount = 1) and (Nodes[0].ElementType <> xeDeclaration) then
        raise EFilerError.Create(sxeDeclarationMustBeFirstElem);

      
      if DoctypeCount > 1 then raise EFilerError.Create(sxeMoreThanOneDoctype);

      
      if (DoctypeCount = 1) and (DoctypePos > NormalPos) then
        raise EFilerError.Create(sxeDoctypeAfterRootElement);

      
      if CDataCount > 0 then
        raise EFilerError.Create(sxeCDataInRoot);
    end;
  end;
end;

procedure TNativeXml.ReadFromString(const AValue: string);
var
  S: TStream;
begin
  S := TStringStream.Create(AValue);
  try
    ReadFromStream(S);
  finally
    S.Free;
  end;
end;

procedure TNativeXml.ResolveEntityReferences;
begin
  if assigned(Root) then
    Root.ResolveEntityReferences;
end;

procedure TNativeXml.SaveToFile(const FileName: string);
var
  S: TStream;
begin
  S := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(S);
  finally
    S.Free;
  end;
end;

procedure TNativeXml.SaveToStream(Stream: TStream);
var
  B: TsdBufferedWriteStream;
begin
  
  
  B := TsdBufferedWriteStream.Create(Stream, False);
  try
    
    if Utf8Encoded then
      FCodecStream := TsdUtf8Stream.Create(B)
    else
      FCodecStream := TsdAnsiStream.Create(B);
    try
      
      FCodecStream.Encoding := FExternalEncoding;
      WriteToStream(FCodecStream);
    finally
      FCodecStream.Free;
    end;
  finally
    B.Free;
  end;
end;

procedure TNativeXml.SetCommentString(const Value: string);
var
  ANode: TXmlNode;
begin
  ANode := FRootNodes.NodeByElementType(xeComment);
  if not assigned(ANode) and (length(Value) > 0) then begin
    ANode := TXmlNode.CreateType(Self, xeComment);
    FRootNodes.NodeInsert(1, ANode);
  end;
  if assigned(ANode) then ANode.ValueAsString := Value;
end;

procedure TNativeXml.SetDefaults;
begin
  
  FExternalEncoding    := cDefaultExternalEncoding;
  FXmlFormat           := cDefaultXmlFormat;
  FWriteOnDefault      := cDefaultWriteOnDefault;
  FBinaryEncoding      := cDefaultBinaryEncoding;
  FUtf8Encoded         := cDefaultUtf8Encoded;
  FIndentString        := cDefaultIndentString;
  FDropCommentsOnParse := cDefaultDropCommentsOnParse;
  FUseFullNodes        := cDefaultUseFullNodes;
  FSortAttributes      := cDefaultSortAttributes;
end;

procedure TNativeXml.SetEncodingString(const Value: string);
var
  ANode: TXmlNode;
begin
  if Value = GetEncodingString then exit;
  ANode := FRootNodes[0];
  if not assigned(ANode) or (ANode.ElementType <> xeDeclaration) then begin
    if length(Value) > 0 then begin
      ANode := TXmlNode.CreateType(Self, xeDeclaration);
      FRootNodes.NodeInsert(0, ANode);
    end;
  end;
  if assigned(ANode) then
    ANode.AttributeByName['encoding'] := Value;
end;

procedure TNativeXml.SetStyleSheetString(const Value: string);
var
  ANode: TXmlNode;
begin
  if Value = GetStyleSheetString then exit;
  ANode := FRootNodes.NodeByElementType(xeStylesheet);
  if assigned(ANode) then
    ANode.ValueAsString := Value;
end;

procedure TNativeXml.SetVersionString(const Value: string);
var
  ANode: TXmlNode;
begin
  if Value = GetVersionString then exit;
  ANode := FRootNodes[0];
  if not assigned(ANode) or (ANode.ElementType <> xeDeclaration) then begin
    if length(Value) > 0 then begin
      ANode := TXmlNode.CreateType(Self, xeDeclaration);
      FRootNodes.NodeInsert(0, ANode);
    end;
  end;
  if assigned(ANode) then
    ANode.AttributeByName['version'] := Value;
end;

procedure TNativeXml.WriteToStream(S: TStream);
var
  i: integer;
begin
  if not assigned(Root) and FParserWarnings then
    raise EFilerError.Create(sxeRootElementNotDefined);

  DoProgress(0);

  
  for i := 0 to FRootNodes.NodeCount - 1 do begin
    FRootNodes[i].WriteToStream(S);
    WriteStringToStream(S, LineFeed);
  end;

  DoProgress(S.Size);
end;

function TNativeXml.WriteToString: string;
var
  S: TStringStream;
begin
  S := TStringStream.Create('');
  try
    WriteToStream(S);
    Result := S.DataString;
  finally
    S.Free;
  end;
end;

{ TsdCodecStream }

constructor TsdCodecStream.Create(AStream: TStream);
begin
  inherited Create;
  FStream := AStream;
end;

function TsdCodecStream.InternalRead(var Buffer{$IFDEF CLR}: array of Byte{$ENDIF}; Offset, Count: Longint): Longint;
var
  i, j: integer;
  BOM: array[0..3] of byte;
  BytesRead: integer;
  Found: boolean;
begin
  Result := 0;
  if FMode = umUnknown then begin
    FMode := umRead;
    
    if not assigned(FStream) then
      raise EStreamError.Create(sxeCodecStreamNotAssigned);

    
    FEncoding := se8Bit;
    BytesRead := FStream.Read(BOM, 4);
    for i := 0 to cBomInfoCount - 1 do begin
      Found := True;
      for j := 0 to Min(BytesRead, cBomInfo[i].Len) - 1 do begin
        if BOM[j] <> cBomInfo[i].BOM[j] then begin
          Found := False;
          break;
        end;
      end;
      if Found then break;
    end;
    if Found then begin
      FEncoding := cBomInfo[i].Enc;
      FWriteBom := cBomInfo[i].HasBOM;
    end else begin
      
      FEncoding := se8Bit;
      FWriteBom := False;
    end;

    
    if FEncoding in [seUCS4BE, seUCS4_2143, seUCS4_2143, seUCS4_3412, seEBCDIC] then
      raise EStreamError.Create(sxeUnsupportedEncoding);

    
    if FWriteBom then
      FStream.Seek(cBomInfo[i].Len - BytesRead, soCurrent)
    else
      FStream.Seek(-BytesRead, soCurrent);

    
    if FEncoding in [se16BitBE, seUTF16BE] then
      FSwapByteOrder := True;

  end;

  
  if FMode <> umRead then
    raise EStreamError.Create(sxeCannotReadCodecForWriting);

  
  if Count <> 1 then
    raise EStreamError.Create(sxeCannotReadMultipeChar);

  
  TBytes(Buffer)[Offset] := ReadByte;
  if TBytes(Buffer)[Offset] <> 0 then Result := 1;
end;

{$IFDEF CLR}

function TsdCodecStream.Read(var Buffer: array of Byte; Offset, Count: Longint): Longint;
begin
  Result := InternalRead(Buffer, Offset, Count);
end;

{$ELSE}

function TsdCodecStream.Read(var Buffer; Count: Longint): Longint;
begin
  Result := InternalRead(Buffer, 0, Count);
end;

{$ENDIF}

function TsdCodecStream.ReadByte: byte;
begin
  
  Result := 0;
end;

function TsdCodecStream.InternalSeek(Offset: Longint; Origin: TSeekOrigin): Longint;
begin
  Result := 0;
  if FMode = umUnknown then
    raise EStreamError.Create(sxeCannotSeekBeforeReadWrite);

  if Origin = soCurrent then begin
    if Offset = 0 then begin
      
      Result := FStream.Position;
      exit;
    end;
    if (FMode = umRead) and ((Offset = -1) or (Offset = -2)) then begin
      FBuffer := '';
      case Offset of
      -1: FStream.Seek(FPosMin1, soBeginning);
      -2: FStream.Seek(FPosMin2, soBeginning);
      end;
      exit;
    end;
  end;
  if (Origin = soEnd) and (Offset = 0) then begin
    
    Result := FStream.Size;
    exit;
  end;
  
  if Origin = soBeginning then exit;
  
  raise EStreamError.Create(sxeCannotPerformSeek);
end;

{$IFDEF CLR}

function TsdCodecStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
begin
  Result := InternalSeek(Offset, Origin);
end;

{$ELSE}

function TsdCodecStream.Seek(Offset: Longint; Origin: Word): Longint;
begin
  Result := InternalSeek(Offset, TSeekOrigin(Origin));
end;

{$ENDIF}

procedure TsdCodecStream.StorePrevPositions;
begin
  FPosMin2 := FPosMin1;
  FPosMin1 := FStream.Position;
end;

function TsdCodecStream.InternalWrite(const Buffer{$IFDEF CLR}: array of Byte{$ENDIF}; Offset, Count: Longint): Longint;
var
  i: integer;
begin
  if FMode = umUnknown then begin
    FMode := umWrite;

    
    if FEncoding in [seUCS4BE, seUCS4_2143, seUCS4_2143, seUCS4_3412, seEBCDIC] then
      raise EStreamError.Create(sxeUnsupportedEncoding);

    
    for i := 0 to cBomInfoCount - 1 do
      if cBomInfo[i].Enc = FEncoding then begin
        FWriteBom := cBomInfo[i].HasBOM;
        break;
      end;

    
    if FWriteBom then
      FStream.WriteBuffer(cBomInfo[i].BOM, cBomInfo[i].Len);

    
    if FEncoding in [se16BitBE, seUTF16BE] then
      FSwapByteOrder := True;
  end;

  if FMode <> umWrite then
    raise EStreamError.Create(sxeCannotWriteCodecForReading);
  WriteBuf(Buffer, Offset, Count);
  Result := Count;
end;

{$IFDEF CLR}

function TsdCodecStream.Write(const Buffer: array of Byte; Offset, Count: Longint): Longint;
begin
  Result := InternalWrite(Buffer, Offset, Count);
end;

{$ELSE}

function TsdCodecStream.Write(const Buffer; Count: Longint): Longint;
begin
  Result := InternalWrite(Byte(Buffer), 0, Count);
end;

{$ENDIF}

procedure TsdCodecStream.WriteBuf(const Buffer{$IFDEF CLR}: TBytes{$ENDIF}; Offset, Count: longint);
var
  i: integer;
begin
  
  
  for i := 0 to Count - 1 do
  {$IFDEF CLR}
    WriteByte(Buffer[Offset + i]);
  {$ELSE}
    WriteByte(TBytes(Buffer)[Offset + i]);
  {$ENDIF}
end;

procedure TsdCodecStream.WriteByte(const B: byte);
begin
end;

{$IFDEF CLR}

procedure TsdCodecStream.SetSize(NewSize: Int64);
begin
end;

{$ENDIF}

{ TsdAnsiStream }

function TsdAnsiStream.ReadByte: byte;
var
  B: byte;
  W: word;
begin
  StorePrevPositions;

  case FEncoding of
  se8Bit, seUTF8:
    begin
      
      
      B := 0;
      FStream.Read(B, 1);
      Result := B;
    end;
  se16BitBE,se16BitLE,seUTF16BE,seUTF16LE:
    begin
      
      W := 0;
      FStream.Read(W, 2);
      
      if FSwapByteOrder then
        W := swap(W);
      
      if ((W and $FF00) > 0) and not FWarningUnicodeLoss then begin
        FWarningUnicodeLoss := True;
        if assigned(FOnUnicodeLoss) then
          FOnUnicodeLoss(Self);
        
        Result := ord('?');
      end else
        Result := W and $FF;
    end;
  else
    raise EStreamError.Create(sxeUnsupportedEncoding);
  end;
end;

procedure TsdAnsiStream.WriteBuf(const Buffer{$IFDEF CLR}: TBytes{$ENDIF}; Offset, Count: longint);
begin
  case FEncoding of
  se8Bit:
    begin
      
      if StreamWrite(FStream, Buffer, Offset, Count) <> Count then
        raise EStreamError.Create(sxeCannotWriteToOutputStream);
    end;
  else
    inherited;
  end;
end;

procedure TsdAnsiStream.WriteByte(const B: byte);
var
  SA, SU: string;
  W: word;
begin
  case FEncoding of
  se8Bit:
    begin
      
      FStream.Write(B, 1);
    end;
  seUTF8:
    begin
      
      SA := char(B);
      SU := sdAnsiToUTF8(SA);
      
      if FStream.Write(SU[1], length(SU)) = 0 then
        raise EStreamError.Create(sxeCannotWriteToOutputStream);
    end;
  se16BitBE,se16BitLE,seUTF16BE,seUTF16LE:
    begin
      
      W := B;
      
      if FSwapByteOrder then
        W := swap(W);
      
      if FStream.Write(W, 2) = 0 then
        raise EStreamError.Create(sxeCannotWriteToOutputStream);
    end;
  else
    raise EStreamError.Create(sxeUnsupportedEncoding);
  end;
end;

{ TsdUtf8Stream }

function TsdUtf8Stream.ReadByte: byte;
var
  B, B1, B2, B3: byte;
  W: word;
  SA: string;
begin
  Result := 0;

  
  if (Length(FBuffer) = 0) or (FBufferPos > length(FBuffer)) then begin
    StorePrevPositions;
    FBufferPos := 1;
    
    case FEncoding of
    se8Bit:
      begin
        
        B := 0;
        FStream.Read(B, 1);
        SA := char(B);
        
        FBuffer := sdAnsiToUtf8(SA);
      end;
    seUTF8:
      begin
        
        B1 := 0;
        FStream.Read(B1, 1);
        FBuffer := char(B1);
        if (B1 and $80) > 0 then begin
          if (B1 and $20) <> 0 then begin
            B2 := 0;
            FStream.Read(B2, 1);
            FBuffer := FBuffer + char(B2);
          end;
          B3 := 0;
          FStream.Read(B3, 1);
          FBuffer := FBuffer + char(B3);
        end;
      end;
    se16BitBE,se16BitLE,seUTF16BE,seUTF16LE:
      begin
        
        W := 0;
        FStream.Read(W, 2);
        
        if FSwapByteOrder then
          W := swap(W);
        
        {$IFDEF D5UP}
        FBuffer := sdUnicodeToUtf8(widechar(W));
        {$ELSE}
        FBuffer := sdUnicodeToUtf8(char(W and $FF));
        {$ENDIF}
      end;
    else
      raise EStreamError.Create(sxeUnsupportedEncoding);
    end;
  end;

  
  if (FBufferPos > 0) and (FBufferPos <= length(FBuffer)) then
    Result := byte(FBuffer[FBufferPos]);
  inc(FBufferPos);
end;

procedure TsdUtf8Stream.WriteBuf(const Buffer{$IFDEF CLR}: TBytes{$ENDIF}; Offset, Count: longint);
begin
  case FEncoding of
  seUtf8:
    begin
      
      if StreamWrite(FStream, Buffer, Offset, Count) <> Count then
        raise EStreamError.Create(sxeCannotWriteToOutputStream);
    end
  else
    inherited;
  end;
end;

procedure TsdUtf8Stream.WriteByte(const B: byte);
var
  SA: string;
  SW: widestring;
  MustWrite: boolean;
begin
  case FEncoding of
  se8Bit,se16BitBE,se16BitLE,seUTF16BE,seUTF16LE:
    begin
      MustWrite := True;
      case Length(FBuffer) of
      0:
        begin
          FBuffer := char(B);
          if (B and $80) <> 0 then MustWrite := False;
        end;
      1:
        begin
          FBuffer := FBuffer + char(B);
          if (byte(FBuffer[1]) and $20) <> 0 then MustWrite := False;
        end;
      2: FBuffer := FBuffer + char(B);
      end;
      if MustWrite then begin
        if FEncoding = se8Bit then begin
          
          SA := sdUtf8ToAnsi(FBuffer);
          
          if length(SA) = 1 then
            if FStream.Write(SA[1], 1) <> 1 then
              raise EStreamError.Create(sxeCannotWriteToOutputStream);
        end else begin
          
          SW := sdUtf8ToUnicode(FBuffer);
          
          if length(SW) = 1 then
            if FStream.Write(SW[1], 2) <> 2 then
              raise EStreamError.Create(sxeCannotWriteToOutputStream);
        end;
        FBuffer := '';
      end;
    end;
  seUTF8:
    begin
      
      if FStream.Write(B, 1) <> 1 then
        raise EStreamError.Create(sxeCannotWriteToOutputStream);
    end;
  else
    raise EStreamError.Create(sxeUnsupportedEncoding);
  end;
end;

{$IFDEF CLR}

{ TsdBufferedStream }

constructor TsdBufferedStream.Create(AStream: TStream; Owned: Boolean = False);
begin
  inherited Create;
  FStream := AStream;
  FOwned := Owned;
end;

destructor TsdBufferedStream.Destroy;
begin
  if FOwned then FreeAndNil(FStream);
  inherited Destroy;
end;

function TsdBufferedStream.Read(var Buffer: array of Byte; Offset, Count: Longint): Longint;
begin
  Result := FStream.Read(Buffer, Offset, Count);
end;

function TsdBufferedStream.Write(const Buffer: array of Byte; Offset, Count: Longint): Longint;
begin
  Result := FStream.Write(Buffer, Offset, Count);
end;

function TsdBufferedStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
begin
  Result := FStream.Seek(Offset, Origin);
end;

procedure TsdBufferedStream.SetSize(NewSize: Int64);
begin
  FStream.Size := NewSize;
end;

{$ELSE}

{ TsdBufferedReadStream }

const
  cMaxBufferSize = $10000; 

procedure TsdBufferedReadStream.CheckPosition;
var
  NewPage: integer;
  FStartPos: longint;
begin
  
  NewPage := FPosition div cMaxBufferSize;
  FBufPos := FPosition mod cMaxBufferSize;

  
  if (NewPage <> FPage) then begin
    
    FPage := NewPage;

    
    FStartPos := FPage * cMaxBufferSize;
    FBufSize  := Min(cMaxBufferSize, FStream.Size - FStartPos);

    FStream.Seek(FStartPos, soBeginning);
    if FBufSize > 0 then
      FStream.Read(FBuffer^, FBufSize);
  end;
  FMustCheck := False;
end;

constructor TsdBufferedReadStream.Create(AStream: TStream; Owned: boolean);
begin
  inherited Create;
  FStream := AStream;
  FOwned := Owned;
  FMustCheck := True;
  FPage := -1; 
  ReallocMem(FBuffer, cMaxBufferSize);
end;

destructor TsdBufferedReadStream.Destroy;
begin
  if FOwned then FreeAndNil(FStream);
  ReallocMem(FBuffer, 0);
  inherited;
end;

function TsdBufferedReadStream.Read(var Buffer; Count: longint): Longint;
var
  Packet: PByte;
  PacketCount: integer;
begin
  
  if FMustCheck then CheckPosition;

  
  if (Count = 1) and (FBufPos < FBufSize - 1) then begin
    byte(Buffer) := FBuffer^[FBufPos];
    inc(FBufPos);
    inc(FPosition);
    Result := 1;
    exit;
  end;

  
  Packet := @Buffer;
  Result := 0;
  while Count > 0 do begin
    PacketCount := min(FBufSize - FBufPos, Count);
    if PacketCount <= 0 then exit;
    Move(FBuffer^[FBufPos], Packet^, PacketCount);
    dec(Count, PacketCount);
    inc(Packet, PacketCount);
    inc(Result, PacketCount);
    inc(FPosition, PacketCount);
    inc(FBufPos, PacketCount);
    if FBufPos >= FBufSize then CheckPosition;
  end;
end;

function TsdBufferedReadStream.Seek(Offset: longint; Origin: Word): Longint;
begin
  case Origin of
  soFromBeginning:
    FPosition := Offset;
  soFromCurrent:
    begin
      
      if Offset = 0 then begin
        Result := FPosition;
        exit;
      end;
      FPosition := FPosition + Offset;
    end;
  soFromEnd:
    FPosition := FStream.Size + Offset;
  end;
  Result := FPosition;
  FMustCheck := True;
end;

function TsdBufferedReadStream.Write(const Buffer; Count: longint): Longint;
begin
  raise EStreamError.Create(sxeCannotWriteCodecForReading);
end;

{ TsdBufferedWriteStream }

constructor TsdBufferedWriteStream.Create(AStream: TStream;
  Owned: boolean);
begin
  inherited Create;
  FStream := AStream;
  FOwned := Owned;
  ReallocMem(FBuffer, cMaxBufferSize);
end;

destructor TsdBufferedWriteStream.Destroy;
begin
  Flush;
  if FOwned then FreeAndNil(FStream);
  ReallocMem(FBuffer, 0);
  inherited;
end;

procedure TsdBufferedWriteStream.Flush;
begin
  
  if FBufPos > 0 then begin
    FStream.Write(FBuffer^, FBufPos);
    FBufPos := 0;
  end;
end;

function TsdBufferedWriteStream.Read(var Buffer; Count: longint): Longint;
begin
  raise EStreamError.Create(sxeCannotReadCodecForWriting);
end;

function TsdBufferedWriteStream.Seek(Offset: longint; Origin: Word): Longint;
begin
  case Origin of
  soFromBeginning:
    if Offset = FPosition then begin
      Result := FPosition;
      exit;
    end;
  soFromCurrent:
    begin
      
      if Offset = 0 then begin
        Result := FPosition;
        exit;
      end;
    end;
  soFromEnd:
    if Offset = 0 then begin
      Result := FPosition;
      exit;
    end;
  end;
  raise EStreamError.Create(sxeCannotPerformSeek);
end;

function TsdBufferedWriteStream.Write(const Buffer; Count: longint): Longint;
var
  Packet: PByte;
  PacketCount: integer;
begin
  
  if (FBufPos + Count < cMaxBufferSize) then begin
    Move(Buffer, FBuffer^[FBufPos], Count);
    inc(FBufPos, Count);
    inc(FPosition, Count);
    Result := Count;
    exit;
  end;

  
  Packet := @Buffer;
  Result := 0;
  while Count > 0 do begin
    PacketCount := min(cMaxBufferSize - FBufPos, Count);
    if PacketCount <= 0 then exit;
    Move(Packet^, FBuffer^[FBufPos], PacketCount);
    dec(Count,     PacketCount);
    inc(Result,    PacketCount);
    inc(FPosition, PacketCount);
    inc(Packet,    PacketCount);
    inc(FBufPos,   PacketCount);
    if FBufPos = cMaxBufferSize then Flush;
  end;
end;

{$ENDIF}

initialization

  {$IFDEF TRIALXML}
  ShowMessage(
    'This is the unregistered version of NativeXml.pas'#13#13 +
    'Please visit http:
    'registered version for Eur 29.95 (source included).');
  {$ENDIF}

end.
