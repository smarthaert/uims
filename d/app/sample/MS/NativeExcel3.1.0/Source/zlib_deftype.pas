//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         zlib_deftype
//
//      Description:  type declarations
//                    This file is a part of the zlib data 
//                    compression library for delphi
//                    (re-implementation of zlib-1.2.3 in pure Delphi)     
//
//////////////////////////////////////////////////////////////////////////////
//
//     Authors: A.V.Nikulitsa, A.V.Tomikhin
//
//       site: http://www.nika-soft.com/ 
//     e-mail: support@nika-soft.com
//
// The original zlib source code is available at  http://www.zlib.net/
//
// This software is provided 'as-is', without any express or implied
// warranty.
//
//////////////////////////////////////////////////////////////////////////////
//
//  ORIGINAL COPYRIGHT of zlib.h:
//
//  zlib.h -- interface of the 'zlib' general purpose compression library
//  version 1.2.3, July 18th, 2005
//
//  Copyright (C) 1995-2005 Jean-loup Gailly and Mark Adler
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//     claim that you wrote the original software. If you use this software
//     in a product, an acknowledgment in the product documentation would be
//     appreciated but is not required.
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//  3. This notice may not be removed or altered from any source distribution.
//
//  Jean-loup Gailly        Mark Adler
//  jloup@gzip.org          madler@alumni.caltech.edu
//
//  The data format used by the zlib library is described by RFCs (Request for
//  Comments) 1950 to 1952 in the files http://www.ietf.org/rfc/rfc1950.txt
//  (zlib format), rfc1951.txt (deflate format) and rfc1952.txt (gzip format).
//
///////////////////////////////////////////////////////////////////////////////

unit zlib_deftype;
{$I xlsdef.inc}
{$Q-}
{$R-}


interface

uses sysutils;

type 

   TArrSmallint = array of smallint;  
   TArrLongint  = array of longint;   
   TArrLongword = array of longword;   
   TArrWord     = array of word;   

   {$ifdef D45}
   PByte = ^byte;
   {$endif}
   
   TArrByte     = class
   private 
      Fbuffer:Pointer;
      FSize:longword;
      FDestroy:boolean;

      function getLength():longword;
      function getBuffer(offset:longword):pointer;
      function getByte(index:longword):byte;
      procedure setByte(index:longword; value:byte);
   public
      constructor Create(const abuffer; asize:longword);overload;
      constructor Create(scr:array of byte);overload;
      constructor Create(asize:longword);overload;
      destructor Destroy;override;

       
      function ToString():string; {$ifdef D2009} override; {$endif}

      property bf[index:longword]:byte read getByte write setByte;default;
      property Length:longword read getlength;
      property Buffer[offset:longword]:Pointer read getBuffer;
   end;   
   
{$ifdef D45}
const  
   DeflateMethod_Z_DEFLATED = 8;
type 
   DeflateMethod = byte;
{$else}
   DeflateMethod = (DeflateMethod_Z_DEFLATED = 8);
{$endif}


{$ifdef D45}
const
   DataType_Z_BINARY   = 0;
   DataType_Z_TEXT     = 1;
   DataType_Z_UNKNOWN  = 2;
type
   DataType = byte;

{$else}
   DataType = (DataType_Z_BINARY,
               DataType_Z_TEXT,
               DataType_Z_UNKNOWN);
{$endif}

{$ifdef D45}
const
  FlushMode_Z_NEGATIVE      = -1;
  FlushMode_Z_NO_FLUSH      = 0;
  FlushMode_Z_PARTIAL_FLUSH = 1; //* will be removed, use Z_SYNC_FLUSH instead */
  FlushMode_Z_SYNC_FLUSH    = 2;
  FlushMode_Z_FULL_FLUSH    = 3;
  FlushMode_Z_FINISH        = 4;
  FlushMode_Z_BLOCK         = 5;
type
   FlushMode = integer;
{$else}
   FlushMode = (FlushMode_Z_NEGATIVE      = -1,
                FlushMode_Z_NO_FLUSH      = 0,
                FlushMode_Z_PARTIAL_FLUSH = 1, //* will be removed, use Z_SYNC_FLUSH instead */
                FlushMode_Z_SYNC_FLUSH    = 2,
                FlushMode_Z_FULL_FLUSH    = 3,
                FlushMode_Z_FINISH        = 4,
                FlushMode_Z_BLOCK         = 5);
{$endif}

{$ifdef D45}
const
   StreamStatus_INIT_STATE    = 42;
   StreamStatus_EXTRA_STATE   = 69;
   StreamStatus_NAME_STATE    = 73;
   StreamStatus_COMMENT_STATE = 91;
   StreamStatus_HCRC_STATE    = 103;
   StreamStatus_BUSY_STATE    = 113;
   StreamStatus_FINISH_STATE  = 666;

type
   StreamStatus = word;

{$else}
   StreamStatus = (StreamStatus_INIT_STATE    = 42,
                   StreamStatus_EXTRA_STATE   = 69,
                   StreamStatus_NAME_STATE    = 73,
                   StreamStatus_COMMENT_STATE = 91,
                   StreamStatus_HCRC_STATE    = 103,
                   StreamStatus_BUSY_STATE    = 113,
                   StreamStatus_FINISH_STATE  = 666);
{$endif}

{$ifdef D45}
const
   CompressionStrategy_Z_FILTERED          =  1;
   CompressionStrategy_Z_HUFFMAN_ONLY      =  2;
   CompressionStrategy_Z_RLE               =  3;
   CompressionStrategy_Z_FIXED             =  4;
   CompressionStrategy_Z_DEFAULT_STRATEGY  =  0;

type
   CompressionStrategy = byte;

{$else}
   CompressionStrategy = (CompressionStrategy_Z_FILTERED          =  1,
                          CompressionStrategy_Z_HUFFMAN_ONLY      =  2,
                          CompressionStrategy_Z_RLE               =  3,
                          CompressionStrategy_Z_FIXED             =  4,
                          CompressionStrategy_Z_DEFAULT_STRATEGY  =  0);
{$endif}

{$ifdef D45}
const
   CompressionReturnCode_Z_OK            =  0;
   CompressionReturnCode_Z_STREAM_END    =  1;
   CompressionReturnCode_Z_NEED_DICT     =  2;
   CompressionReturnCode_Z_ERRNO         = -1;
   CompressionReturnCode_Z_STREAM_ERROR  = -2;
   CompressionReturnCode_Z_DATA_ERROR    = -3;
   CompressionReturnCode_Z_MEM_ERROR     = -4;
   CompressionReturnCode_Z_BUF_ERROR     = -5;
   CompressionReturnCode_Z_VERSION_ERROR = -6;
   CompressionReturnCode_Z_OTHER_ERROR   = -7;
type
   CompressionReturnCode = shortint;

{$else}
   CompressionReturnCode = (CompressionReturnCode_Z_OK            =  0,
                            CompressionReturnCode_Z_STREAM_END    =  1,
                            CompressionReturnCode_Z_NEED_DICT     =  2,
                            CompressionReturnCode_Z_ERRNO         = -1,
                            CompressionReturnCode_Z_STREAM_ERROR  = -2,
                            CompressionReturnCode_Z_DATA_ERROR    = -3,
                            CompressionReturnCode_Z_MEM_ERROR     = -4,
                            CompressionReturnCode_Z_BUF_ERROR     = -5,
                            CompressionReturnCode_Z_VERSION_ERROR = -6,
                            CompressionReturnCode_Z_OTHER_ERROR   = -7);
{$endif}

{$ifdef D45}
const
   CompressionLevel_Z_NO_COMPRESSION      = 0;
   CompressionLevel_Z_BEST_SPEED          = 1;
   CompressionLevel_Z_BEST_COMPRESSION    = 9;
   CompressionLevel_Z_DEFAULT_COMPRESSION = -1;   
type
   CompressionLevel = shortint;
{$else}
   CompressionLevel = (CompressionLevel_Z_NO_COMPRESSION      = 0,
                       CompressionLevel_Z_BEST_SPEED          = 1,
                       CompressionLevel_Z_BEST_COMPRESSION    = 9,
                       CompressionLevel_Z_DEFAULT_COMPRESSION = -1);   
{$endif}

   CompressionMode = (CompressionMode_Compress, CompressionMode_Decompress);
   
   CodeType = (CodeType_CODES, CodeType_LENS, CodeType_DISTS);
   
   Block_State = (Block_State_need_more,      //* block not completed, need more input or more output */
                  Block_State_block_done,     //* block flush performed */
                  Block_State_finish_started, //* finish started, need only more output at next deflate */
                  Block_State_finish_done);   //* finish done, accept no more input or output */
    
   compress_func = (compress_func_deflate_stored,
                    compress_func_deflate_fast,
                    compress_func_deflate_slow);

    //* Possible inflate modes between inflate() calls */
    InflateMode = (
        InflateMode_HEAD,       //* 0i: waiting for magic header */
        InflateMode_FLAGS,      //* 1i: waiting for method and flags (gzip) */
        InflateMode_TIME,       //* 2i: waiting for modification time (gzip) */         
        InflateMode_OS,         //* 3i: waiting for extra flags and operating system (gzip) */
        InflateMode_EXLEN,      //* 4i: waiting for extra length (gzip) */
        InflateMode_EXTRA,      //* 5i: waiting for extra bytes (gzip) */
        InflateMode_NAME,       //* 6i: waiting for end of file name (gzip) */
        InflateMode_COMMENT,    //* 7i: waiting for end of comment (gzip) */
        InflateMode_HCRC,       //* 8i: waiting for header crc (gzip) */
        InflateMode_DICTID,     //* 9i: waiting for dictionary check value */
        InflateMode_DICT,       //* 10waiting for inflateSetDictionary() call */
            InflateMode_TYPE,       //* 11i: waiting for type bits, including last-flag bit */
            InflateMode_TYPEDO,     //* 12i: same, but skip check to exit inflate on new block */
            InflateMode_STORED,     //* 13i: waiting for stored FSize (length and complement) */
            InflateMode_COPY,       //* 14i/o: waiting for input or output to copy stored block */
            InflateMode_TABLE,      //* 15i: waiting for dynamic block table lengths */
            InflateMode_LENLENS,    //* 16i: waiting for code length code lengths */
            InflateMode_CODELENS,   //* 17i: waiting for length/lit and distance code lengths */
                InflateMode_LEN,        //* 18i: waiting for length/lit code */
                InflateMode_LENEXT,     //* 19i: waiting for length extra bits */
                InflateMode_DIST,       //* 20i: waiting for distance code */
                InflateMode_DISTEXT,    //* 21i: waiting for distance extra bits */
                InflateMode_MATCH,      //* 22o: waiting for output space to copy string */
                InflateMode_LIT,        //* 23o: waiting for output space to write literal */
        InflateMode_CHECK,      //* 24i: waiting for 32-bit check value */
        InflateMode_LENGTH,     //* 25i: waiting for 32-bit length (gzip) */
        InflateMode_DONE,       //* 26finished check, done -- remain here until reset */
        InflateMode_BAD,        //* 27got a data error -- remain here until reset */
        InflateMode_MEM,        //* 28got an inflate() memory error -- remain here until reset */
        InflateMode_SYNC        //* 29looking for synchronization bytes to restart inflate() */
    );

procedure ArrayCopy(src:TArrByte; src_offset:int64; dst:TArrByte; dst_offset:int64; cnt:integer);
procedure ArrayByteClear(src:TArrByte; offset, cnt:longint);
procedure ArraySmallIntClear(src:TArrSmallInt; offset, cnt:longint);

implementation

constructor TArrByte.Create(const abuffer; asize:longword);
begin
  inherited Create;
  Fbuffer := Pointer(@abuffer);
  FSize := asize;
  FDestroy := false;
end;

constructor TArrByte.Create(asize:longword);
begin
  inherited Create;
  FSize := asize;
  GetMem(Fbuffer, FSize);
  FDestroy := true;
end;

constructor TArrByte.Create(scr:array of byte);
Var i:longword;
begin
  inherited Create;

  FSize := system.length(scr);
  GetMem(Fbuffer, FSize);
  FDestroy := true;
  for i := 0 to FSize - 1 do
      bf[i] := scr[i];
end;

destructor TArrByte.Destroy;
begin
   if FDestroy then begin
      FreeMem(Fbuffer);
   end;

   inherited Destroy;
end;


function TArrByte.getByte(index:longword):byte;
begin
   result := PByte(PAnsiChar(Fbuffer) + index)^;
end;

procedure TArrByte.setByte(index:longword; value:byte);
begin
   if index >= FSize then raise Exception.Create('index out of range'); 
   PByte(PAnsiChar(Fbuffer) + index)^ := value;
end;

function TArrByte.getLength():longword;
begin
   result := FSize;
end;

function TArrByte.getBuffer(offset:longword):pointer;
begin
   result := Pointer(PAnsiChar(Fbuffer) + offset);
end;


function TArrByte.ToString():string;
Var ret:string;
      i:longint;
begin
  ret := '';
  for i := 0 to FSize - 1 do
    ret := ret +  Format('%d,', [bf[i]]); 
  result := ret;
end;


procedure ArrayCopy(src:TArrByte; src_offset:int64; dst:TArrByte; dst_offset:int64; cnt:integer);
Var i:integer;
begin
  if not Assigned(src) then raise Exception.Create('ArrayCopy src=nil');
  if not Assigned(dst) then raise Exception.Create('ArrayCopy dst=nil');
  if src.Length < (src_offset + cnt) then raise Exception.Create('ArrayCopy invalid cnt=' + inttostr(cnt));
  if dst.Length < (dst_offset + cnt) then raise Exception.Create('ArrayCopy invalid cnt=' + inttostr(cnt));

   for i := 0 to cnt - 1 do
      dst[dst_offset + i] := src[src_offset + i];

end;

procedure ArrayByteClear(src:TArrByte; offset, cnt:longint);
Var i:longint;

begin
  if not Assigned(src) then raise Exception.Create('ArrayByteClear src=nil');
  if src.Length < longword(offset + cnt) then raise Exception.Create('ArrayByteClear invalid cnt=' + inttostr(cnt));
  for i := 0 to cnt - 1 do
      src[offset + i] := 0;
end;

procedure ArraySmallIntClear(src:TArrSmallInt; offset, cnt:longint);
Var i:longint;

begin
  if length(src) < (offset + cnt) then raise Exception.Create('ArraySmallIntClear invalid cnt=' + inttostr(cnt));
  
  for i := 0 to cnt - 1 do
      src[i + offset] := 0;
end;

end.
