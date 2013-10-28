unit ZLibEx;

interface

uses
  Windows, Classes;

const
  ZLIB_VERSION = '1.2.3';

type
  TZAlloc = function(opaque: Pointer; items, size: Integer): Pointer;
  TZFree = procedure(opaque, block: Pointer);
  TZCompressionLevel = (zcNone, zcFastest, zcDefault, zcMax);

  TZStreamRec = packed record
    next_in: PChar; // next input byte
    avail_in: Longint; // number of bytes available at next_in
    total_in: Longint; // total nb of input bytes read so far
    next_out: PChar; // next output byte should be put here
    avail_out: Longint; // remaining free space at next_out
    total_out: Longint; // total nb of bytes output so far
    msg: PChar; // last error message, NULL if no error
    state: Pointer; // not visible by applications
    zalloc: TZAlloc; // used to allocate the internal state
    zfree: TZFree; // used to free the internal state
    opaque: Pointer; // private data object passed to zalloc and zfree
    data_type: Integer; // best guess about the data type: ascii or binary
    adler: Longint; // adler32 value of the uncompressed data
    reserved: Longint; // reserved for future use
  end;

procedure ZCompressStream(inStream, outStream: TStream; level: TZCompressionLevel = zcDefault);
procedure ZDecompressStream(inStream, outStream: TStream);

function adler32(adler: LongInt; const buf: PChar; len: Integer): LongInt;
procedure MoveI32(const Source; var Dest; Count: Integer);
function deflateInit_(var strm: TZStreamRec; level: Integer; version: PChar; recsize: Integer): Integer;
function DeflateInit2_(var strm: TZStreamRec; level: integer; method: integer; windowBits: integer; memLevel: integer; strategy: integer; version: PChar; recsize: integer): integer;
function deflate(var strm: TZStreamRec; flush: Integer): Integer;
function deflateEnd(var strm: TZStreamRec): Integer;
function inflateInit_(var strm: TZStreamRec; version: PChar; recsize: Integer): Integer;
function inflateInit2_(var strm: TZStreamRec; windowBits: integer;  version: PChar; recsize: integer): integer;
function inflate(var strm: TZStreamRec; flush: Integer): Integer;
function inflateEnd(var strm: TZStreamRec): Integer;
function inflateReset(var strm: TZStreamRec): Integer; 

implementation

{** bcc32 -c -6 -O2 -Ve -X -pr -a8 -b -d -k- -vi -tWM -r -RT- -ff *.c **}
{$L adler32.obj}
{$L deflate.obj}
{$L infback.obj}
{$L inffast.obj}
{$L inflate.obj}
{$L inftrees.obj}
{$L trees.obj}
{$L compress.obj}

const
  Z_NO_FLUSH = 0;
  Z_PARTIAL_FLUSH = 1;
  Z_SYNC_FLUSH = 2;
  Z_FULL_FLUSH = 3;
  Z_FINISH = 4;

  Z_OK = 0;
  Z_STREAM_END = 1;
  Z_NEED_DICT = 2;
  Z_ERRNO = (-1);
  Z_STREAM_ERROR = (-2);
  Z_DATA_ERROR = (-3);
  Z_MEM_ERROR = (-4);
  Z_BUF_ERROR = (-5);
  Z_VERSION_ERROR = (-6);

  Z_NO_COMPRESSION = 0;
  Z_BEST_SPEED = 1;
  Z_BEST_COMPRESSION = 9;
  Z_DEFAULT_COMPRESSION = (-1);

  Z_FILTERED = 1;
  Z_HUFFMAN_ONLY = 2;
  Z_DEFAULT_STRATEGY = 0;

  Z_BINARY = 0;
  Z_ASCII = 1;
  Z_UNKNOWN = 2;

  Z_DEFLATED = 8;

  _z_errmsg: array[0..9] of PChar = (
    'need dictionary', // Z_NEED_DICT      (2)
    'stream end', // Z_STREAM_END     (1)
    '', // Z_OK             (0)
    'file error', // Z_ERRNO          (-1)
    'stream error', // Z_STREAM_ERROR   (-2)
    'data error', // Z_DATA_ERROR     (-3)
    'insufficient memory', // Z_MEM_ERROR      (-4)
    'buffer error', // Z_BUF_ERROR      (-5)
    'incompatible version', // Z_VERSION_ERROR  (-6)
    ''
    );

  ZLevels: array[TZCompressionLevel] of Shortint = (
    Z_NO_COMPRESSION,
    Z_BEST_SPEED,
    Z_DEFAULT_COMPRESSION,
    Z_BEST_COMPRESSION
    );

  SZInvalid = 'Invalid ZStream operation!';

procedure MoveI32(const Source; var Dest; Count: Integer); register;
asm
        cmp   ECX,0
        Je    @JustQuit
        push  ESI
        push  EDI
        mov   ESI, EAX
        mov   EDI, EDX
    @Loop:
	Mov   AL, [ESI]
        Inc   ESI
        mov   [EDI], AL
        Inc   EDI
        Dec   ECX
        Jnz   @Loop
        pop   EDI
        pop   ESI
    @JustQuit:
end;

function deflateInit_(var strm: TZStreamRec; level: Integer; version: PChar; recsize: Integer): Integer; external;
function DeflateInit2_(var strm: TZStreamRec; level: integer; method: integer; windowBits: integer; memLevel: integer; strategy: integer; version: PChar; recsize: integer): integer; external;
function deflate(var strm: TZStreamRec; flush: Integer): Integer; external;
function deflateEnd(var strm: TZStreamRec): Integer; external;
function inflateInit_(var strm: TZStreamRec; version: PChar; recsize: Integer): Integer; external;
function inflateInit2_(var strm: TZStreamRec; windowBits: integer; version: PChar; recsize: integer): integer; external;
function inflate(var strm: TZStreamRec; flush: Integer): Integer; external;
function inflateEnd(var strm: TZStreamRec): Integer; external;
function inflateReset(var strm: TZStreamRec): Integer; external;
function adler32; external;

function zcalloc(opaque: Pointer; items, size: Integer): Pointer;
begin
  GetMem(result, items * size);
end;

procedure zcfree(opaque, block: Pointer);
begin
  FreeMem(block);
end;

procedure _memset(p: Pointer; b: Byte; count: Integer); cdecl;
begin
  FillChar(p^, count, b);
end;

procedure _memcpy(dest, source: Pointer; count: Integer); cdecl;
begin
  Move(source^, dest^, count);
end;

function _malloc(Size: Integer): Pointer; cdecl;
begin
  GetMem(Result, Size);
end;

procedure _free(Block: Pointer); cdecl;
begin
  FreeMem(Block);
end;

function DeflateInit(var stream: TZStreamRec; level: Integer): Integer;
begin
  result := DeflateInit_(stream, level, ZLIB_VERSION, SizeOf(TZStreamRec));
end;

function DeflateInit2(var stream: TZStreamRec; level, method, windowBits, memLevel, strategy: Integer): Integer;
begin
  result := DeflateInit2_(stream, level, method, windowBits, memLevel, strategy, ZLIB_VERSION, SizeOf(TZStreamRec));
end;

function InflateInit(var stream: TZStreamRec): Integer;
begin
  result := InflateInit_(stream, ZLIB_VERSION, SizeOf(TZStreamRec));
end;

function InflateInit2(var stream: TZStreamRec; windowBits: Integer): Integer;
begin
  result := InflateInit2_(stream, windowBits, ZLIB_VERSION, SizeOf(TZStreamRec));
end;

function ZCompressCheck(code: Integer): Integer;
begin
  result := code;
end;

function ZDecompressCheck(code: Integer): Integer;
begin
  Result := code;
end;

procedure ZCompressStream(inStream, outStream: TStream; level: TZCompressionLevel);
const
  bufferSize = 32768;
var
  zstream: TZStreamRec;
  zresult: Integer;
  inBuffer: array[0..bufferSize - 1] of Char;
  outBuffer: array[0..bufferSize - 1] of Char;
  inSize: Integer;
  outSize: Integer;
begin
  FillChar(zstream, SizeOf(TZStreamRec), 0);
  ZCompressCheck(DeflateInit(zstream, ZLevels[level]));
  inSize := inStream.Read(inBuffer, bufferSize);
  while inSize > 0 do
  begin
    zstream.next_in := inBuffer;
    zstream.avail_in := inSize;
    repeat
      zstream.next_out := outBuffer;
      zstream.avail_out := bufferSize;
      ZCompressCheck(deflate(zstream, Z_NO_FLUSH));      
      outSize := bufferSize - zstream.avail_out; //outSize := zstream.next_out - outBuffer;
      outStream.Write(outBuffer, outSize);
    until (zstream.avail_in = 0) and (zstream.avail_out > 0);
    inSize := inStream.Read(inBuffer, bufferSize);
  end;

  repeat
    zstream.next_out := outBuffer;
    zstream.avail_out := bufferSize;
    zresult := ZCompressCheck(deflate(zstream, Z_FINISH));    
    outSize := bufferSize - zstream.avail_out; //outSize := zstream.next_out - outBuffer;
    outStream.Write(outBuffer, outSize);
  until (zresult = Z_STREAM_END) and (zstream.avail_out > 0);
  ZCompressCheck(deflateEnd(zstream));
end;

procedure ZDecompressStream(inStream, outStream: TStream);
const
  bufferSize = 32768;
var
  zstream: TZStreamRec;
  zresult: Integer;
  inBuffer: array[0..bufferSize - 1] of Char;
  outBuffer: array[0..bufferSize - 1] of Char;
  inSize: Integer;
  outSize: Integer;
begin
  FillChar(zstream, SizeOf(TZStreamRec), 0);
  ZCompressCheck(InflateInit(zstream));
  inSize := inStream.Read(inBuffer, bufferSize);
  while inSize > 0 do
  begin
    zstream.next_in := inBuffer;
    zstream.avail_in := inSize;
    repeat
      zstream.next_out := outBuffer;
      zstream.avail_out := bufferSize;
      ZCompressCheck(inflate(zstream, Z_NO_FLUSH));      
      outSize := bufferSize - zstream.avail_out; // outSize := zstream.next_out - outBuffer;
      outStream.Write(outBuffer, outSize);
    until (zstream.avail_in = 0) and (zstream.avail_out > 0);
    inSize := inStream.Read(inBuffer, bufferSize);
  end;

  repeat
    zstream.next_out := outBuffer;
    zstream.avail_out := bufferSize;
    zresult := ZCompressCheck(inflate(zstream, Z_FINISH));    
    outSize := bufferSize - zstream.avail_out; // outSize := zstream.next_out - outBuffer;
    outStream.Write(outBuffer, outSize);
  until (zresult = Z_STREAM_END) and (zstream.avail_out > 0);
  ZCompressCheck(inflateEnd(zstream));
end;

end.