//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         zlib_gzipstream
//
//      Description:  gzip stream
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

unit zlib_gzipstream;
{$I xlsdef.inc}
{$Q-}
{$R-}



interface

uses zlib_deftype, classes, sysUtils, 
     zlib_const, zlib_z_stream, zlib_mapped_arr, zlib_adler32;

type
   TGZipStream = class (TStream)
   private
      FBaseStream:TStream;
      FBaseStream_eof:boolean;// := false;
      FCompressionmode:CompressionMode;
      FFlush:FlushMode;
         
      FBuff:TArrByte; 
      FZ_stream:TZ_Stream;

      FZ_err:CompressionReturnCode;   //* error code for last stream operation */
         
      Fcrc:longword;     //* crc32 of uncompressed data */
         //string  msg;    //* error message */
         //string  path;   //* path name for debugging only */
      FTransparent:longint; //* 1 if input file is not a .gz file */

      FStart:int64;     //* FStart of compressed data in file (header skipped) */
      FL_in:int64;      //* bytes into deflate or inflate */
      FL_out:int64;     //* bytes out of deflate or inflate */

      FBack:longint;    //* one character push-FBack */
      FLast:boolean;    //* true if push-FBack is FLast character */
      FNext_out:Tmapped_arr;

      procedure Init(stream:TStream; Acompressionmode:CompressionMode; Acompressionlevel:CompressionLevel);
      function  get_byte():longint;
      function  getLong():longword;
      function  CheckHeader():CompressionReturnCode;
      procedure WriteSimpleGZHeader();
      function  Deflate(flush:FlushMode):CompressionReturnCode;

      function  do_flush(flush:FlushMode):CompressionReturnCode;
      function  getBaseStream:TStream;
      function  getCanRead:boolean;
      function  getLength:int64;
      function  getCanWrite:boolean;
      function  getCanSeek:boolean;
      function  getPosition:int64;
      procedure setPosition(value:int64);
   public
      constructor Create(stream:TStream; Acompressionmode:CompressionMode);overload;
      constructor Create(stream:TStream; Acompressionlevel:CompressionLevel);overload;
      destructor Destroy;override;

      procedure SetLength(value:int64);
      {$ifdef D45}
      function Seek(Offset: Longint; Origin: Word): Longint; override;
      {$else}
      function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
      {$endif}
      function  Read(Var buffer; count:longint):longint;override;
      function  Write(const buffer; count:longint):longint;override;
      procedure putLong(value:longword);
      procedure Flush();
      procedure Close();
      
      property BaseStream:TStream read getBaseStream;
      property CanLength:int64 read getLength;
      property CanRead:boolean read getCanRead;
      property CanWrite:boolean read getCanWrite;
      property CanSeek:boolean read getCanSeek;
      property Position:int64 read getPosition write setPosition;

   end;

implementation
const 
   EOF:longint = -1;
   buffsize:longword = $1000;

Var gz_magic:TArrbyte;

constructor TGZipStream.Create(stream:TStream; Acompressionmode:CompressionMode);
begin
   inherited Create;

   Init(stream, Acompressionmode, CompressionLevel_Z_DEFAULT_COMPRESSION); 
end;

constructor TGZipStream.Create(stream:TStream; Acompressionlevel:CompressionLevel);
begin
   inherited Create;

   Init(stream, CompressionMode_Compress, Acompressionlevel); 
end;

destructor TGZipStream.Destroy;
begin
   FBuff.Free;
   FNext_out.Free;
   FZ_stream.Free;

   inherited Destroy;
end;



procedure TGZipStream.Init(stream:TStream; Acompressionmode:CompressionMode; Acompressionlevel:CompressionLevel);
Var ArrNull:TArrByte;
begin
   ArrNull := nil;

   FBaseStream := stream;
   FCompressionmode := Acompressionmode; 
   FFlush := FlushMode_Z_NO_FLUSH;
   
   FBuff := TArrByte.Create(buffsize);
   FZ_stream := TZ_Stream.Create();

   FZ_err := CompressionReturnCode_Z_OK;
   FBaseStream_eof := false;
   FL_in := 0;
   FL_out := 0;
   FBack := EOF;
   Fcrc := Adler32_crc32(0, ArrNull, 0, 0);
   FTransparent := 0;
   FNext_out := TMapped_arr.Create(ArrNull, 0);

   if (FCompressionmode = CompressionMode_Compress) then begin
      FZ_stream.PrepareInBuffer(ArrNull, 0, 0);
      FZ_stream.PrepareOutBuffer(FBuff, 0, buffsize);

      FZ_stream.DeflateInit(ord(Acompressionlevel), -ZLibConst_MAX_WBITS);   
      WriteSimpleGZHeader();
   end
   else begin
      FZ_stream.PrepareInBuffer(FBuff, 0, 0);
      FZ_stream.InflateInit(-ZLibConst_MAX_WBITS);
      //* windowBits is passed < 0 to tell that there is no zlib header.
      //*Note that in this case inflate *requires* an extra 'dummy' byte
      //*after the compressed stream in order to complete decompression and
      //*return Z_STREAM_END. Here the gzip CRC32 ensures that 4 bytes are
      //*present after the compressed stream.
      
      if (CheckHeader() <> CompressionReturnCode_Z_OK) then begin
         raise Exception.Create('Invalid header'); 
      end; 
   end;
end;


//* ===========================================================================
//*     Read a byte from a gz_stream; update next_in and avail_in. Return EOF
//*   for end of file.
//*   IN assertion: the stream s has been sucessfully opened for reading.
         
function TGZipStream.get_byte():longint;
Var cnt:longint;
begin
   if (FBaseStream_eof) then begin
      result := EOF;
      exit;
   end;
   if (FZ_stream.AvailableIn = 0) then begin
      cnt := FBaseStream.Read(PByte(FBuff.buffer[0])^, buffsize);
      FZ_stream.PrepareInBuffer(FBuff, 0, cnt);  

      if (FZ_stream.AvailableIn = 0) then begin
         FBaseStream_eof := true;
         result := EOF;
         exit;
      end;
   end;
   FZ_stream.UpdateNextIn(+1);
   result := longint(FZ_stream.get_next_in(-1));
end;

//* ===========================================================================
//*    Reads a long in LSB order from the given gz_stream. Sets FZ_err in case
//*    of error.

function TGZipStream.getLong():longword;
Var x:longword;
    c:longint;
begin
   x := longword(get_byte());
    
   x := x + (longword(get_byte()) shl 8);
   x := x + (longword(get_byte()) shl 16);
   c := get_byte();
   if (c = EOF) then FZ_err := CompressionReturnCode_Z_DATA_ERROR;
   x := x + (longword(c) shl 24);
   
   result := x;
end;


function TGZipStream.CheckHeader():CompressionReturnCode;
Var len:longword;
    c, cnt, flags, method:longint;
begin
     //* Assure two bytes in the buffer so we can peek ahead -- handle case
     //* where first byte of header is at the end of the buffer after the FLast
     //* gzip segment 
     len := FZ_stream.AvailableIn;
     if (len < 2) then begin
         cnt := FBaseStream.Read(PByte(FBuff.buffer[0])^, longint(buffsize - len));
         if (cnt = 0) then begin
            result := CompressionReturnCode_Z_ERRNO;
            exit;
         end;
         FZ_stream.PrepareInBuffer(FBuff, 0, longint(len) + cnt);

         if (FZ_stream.AvailableIn < 2) then begin
             FTransparent := longint(FZ_stream.AvailableIn);
             result := CompressionReturnCode_Z_OK; 
             exit;
         end;
     end;

     //* Peek ahead to check the gzip magic header */
     if (FZ_stream.get_next_in(0) <> gz_magic[0])  or 
         (FZ_stream.get_next_in(1) <> gz_magic[1]) then begin
         FTransparent := 1;
         result := CompressionReturnCode_Z_OK;
         exit;
     end;

     FZ_stream.UpdateNextIn(+2); 

     //* Check the rest of the gzip header */
     method := get_byte();
     flags  := get_byte();

     if (method <> longint(DeflateMethod_Z_DEFLATED))  or  
         ((flags and ZLibConst_RESERVED) <> 0) then begin
         result := CompressionReturnCode_Z_DATA_ERROR;
         exit;
     end;

     //* Discard time, xflags and OS code: */
     for len := 0 to 5 do 
         get_byte();

     if ((flags and ZLibConst_EXTRA_FIELD) <> 0) then begin //* skip the extra field */
         len := longword(get_byte());
         len := len + (longword(get_byte()) shl 8);
         //* len is garbage if EOF but the loop below will quit anyway */
         while (len <> 0) and (get_byte() <> EOF) do
            dec(len);
     end;

     if ((flags and ZLibConst_ORIG_NAME) <> 0) then begin //* skip the original file name */
        c := get_byte();
        while ((c <> 0) and (c <> EOF)) do
           c := get_byte();
     end;

     if ((flags and ZLibConst_COMMENT) <> 0) then begin   //* skip the .gz file comment */
        c := get_byte();
        while ((c  <> 0) and (c <> EOF)) do
           c := get_byte();
     end;

     if ((flags and ZLibConst_HEAD_CRC) <> 0) then begin  //* skip the header Fcrc */
        for len := 0 to 1 do 
           get_byte();
     end;

     if FBaseStream_eof then 
        result := CompressionReturnCode_Z_DATA_ERROR 
     else
        result := CompressionReturnCode_Z_OK; 
end;  

procedure TGZipStream.WriteSimpleGZHeader();
Var header:TArrByte;
begin
    //* Write a very simple .gz header:
    header := TArrByte.Create(
       [gz_magic[0], gz_magic[1], byte(DeflateMethod_Z_DEFLATED),
       0, 0, 0, 0, 0, 0, ZLibConst_OS_CODE]);
    FBaseStream.Write(Pbyte(header.buffer[0])^, header.Length);
    FStart := 10; 
    header.Free;
end;
               

         
function TGZipStream.Deflate(flush:FlushMode):CompressionReturnCode;
Var ret:CompressionReturnCode;
begin
   ret := CompressionReturnCode_Z_OK;

   while (FZ_stream.AvailableIn <> 0) do begin
      if (FZ_stream.AvailableOut = 0) then begin
          FBaseStream.Write(PByte(FBuff.buffer[0])^, buffsize);
          FZ_stream.PrepareOutBuffer(FBuff, 0, buffsize);
      end;

      FL_in := FL_in + FZ_stream.AvailableIn;
      FL_out := FL_out + FZ_stream.AvailableOut;

      ret := FZ_stream.Deflate(flush);

      FL_in := FL_in - FZ_stream.AvailableIn;
      FL_out := FL_out - FZ_stream.AvailableOut;

      if (ret <> CompressionReturnCode_Z_OK) then begin
          break;
      end;
   end;

   result := ret;
end;


function TGZipStream.getCanRead:boolean;
begin
   if (FCompressionmode = CompressionMode_Compress)  then
      result := false
   else
      result := true;//NI FBaseStream.CanRead;   
end;


function TGZipStream.getCanSeek:boolean;
begin
   result := false;   
end;

function TGZipStream.getCanWrite:boolean;
begin
   if (FCompressionmode = CompressionMode_Decompress) then
      result := false
   else
      result := true;//NIFBaseStream.CanWrite;   
end;

function TGZipStream.getLength:int64;
begin
   raise Exception.Create('Length: Unsupported feature');
end;

function TGZipStream.getPosition:int64;
begin
   raise Exception.Create('get Position: Unsupported feature');
end; 

procedure TGZipStream.setPosition(value:int64);
begin
   raise Exception.Create('set Position: Unsupported feature');
end;

  
{$ifdef D45}
function TGZipStream.Seek(Offset: Longint; Origin: word): Longint;
{$else}
function TGZipStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
{$endif}
begin
   raise Exception.Create('Seek: Unsupported feature');
end;

procedure TGZipStream.SetLength(value:int64);
begin
   raise Exception.Create('SetLength: Unsupported feature');
end;

function TGZipStream.do_flush(flush:FlushMode):CompressionReturnCode;
Var ret:CompressionReturnCode;
    ArrNull:TArrByte;
    done:boolean; 
    len:longint;
begin
   ArrNull := nil;
   ret := CompressionReturnCode_Z_OK;

   if (FCompressionmode = CompressionMode_Compress) then begin

      done := false; 
      FZ_stream.PrepareInBuffer(ArrNull, 0, 0); //* should be zero already anyway */
      
      repeat
          len := longint(buffsize - FZ_stream.AvailableOut);
          if (len <> 0) then begin
              FBaseStream.Write(PByte(FBuff.buffer[0])^, len);
              FZ_stream.PrepareOutBuffer(FBuff, 0, buffsize);
          end;

          if (done) then break;
          FL_out := FL_out + FZ_stream.AvailableOut;
          ret := FZ_stream.Deflate(flush);
          FL_out := FL_out - FZ_stream.AvailableOut;

          //* Ignore the second of two consecutive flushes: */
          if (len = 0) and (ret = CompressionReturnCode_Z_BUF_ERROR) then
               ret := CompressionReturnCode_Z_OK;

          //* deflate has finished flushing only when it hasn't used up
          //*all the available space in the output buffer:
          
          done := (FZ_stream.AvailableOut <> 0) or (ret = CompressionReturnCode_Z_STREAM_END);

          if (ret <> CompressionReturnCode_Z_OK) and (ret <> CompressionReturnCode_Z_STREAM_END) then break;
      until false;
   end;
   if ret = CompressionReturnCode_Z_STREAM_END then
      result := CompressionReturnCode_Z_OK
   else
      result := ret;
end;

procedure TGZipStream.Flush();
Var ret:CompressionReturnCode;
begin
   if (FCompressionmode = CompressionMode_Compress) then begin
      ret := do_flush(FlushMode_Z_FULL_FLUSH);
      if (ret <> CompressionReturnCode_Z_OK) then raise Exception.Create(FZ_stream.ErrorMessage);
//NI      FBaseStream.Flush();
   end; 
end;

function TGZipStream.Read(Var buffer; count:longint):longint;
Var //ret:CompressionReturnCode;
    FStart:Tmapped_arr;
    n:longword;
    readcnt, cnt:longint;
    b:TArrByte;

begin
   b := nil;
   FStart := nil;
   if (count = 0) then begin
      result := 0;
      exit;
   end;
try
   b := TArrByte.Create(buffer, count);
   
   FZ_stream.PrepareOutBuffer(b, 0, count);
   FStart := TMapped_arr.Create(b, 0);
   
   if (not Assigned(FZ_stream)) or (FCompressionmode <> CompressionMode_Decompress) then
      raise Exception.Create('Stream error');
    
   if (FZ_err = CompressionReturnCode_Z_DATA_ERROR)  or  
         (FZ_err = CompressionReturnCode_Z_ERRNO) then
      raise Exception.Create('Data error');

   if (FZ_err = CompressionReturnCode_Z_STREAM_END) then begin
      result := 0;  //* EOF */
      exit;
   end;
   FNext_out.Assign(b, 0);
   

   if (FZ_stream.AvailableOut > 0) and (FBack <> EOF) then begin
       FNext_out.PUSH(byte(FBack));

       FZ_stream.UpdateNextOut(+1);

       FBack := EOF;
       inc(FL_out);
       FStart.Offset := FStart.Offset + 1;

       if (FLast) then begin
          FZ_err := CompressionReturnCode_Z_STREAM_END;
          result := 1;
          exit;
       end;
   end;
   while (FZ_stream.AvailableOut <> 0) do begin

       if (FTransparent > 0) then begin
           //* Copy first the lookahead bytes: */
           n := FZ_stream.AvailableIn;
           if (n > FZ_stream.AvailableOut) then n := FZ_stream.AvailableOut;
           if (n > 0) then begin
              FZ_stream.CopyInToOut(longint(n)); 
           end;

           if (FZ_stream.AvailableOut > 0) then begin
              readcnt := FBaseStream.Read(PByte(FNext_out.ArrByte.Buffer[FNext_out.Offset])^, longint(FZ_stream.AvailableOut));
              FZ_stream.UpdateNextOut(readcnt);  
           end;

           count := count - longint(FZ_stream.AvailableOut);
           FL_in  := FL_in + count;
           FL_out := FL_out + count;
           if (count = 0) then FBaseStream_eof := true;
           result := longint(count);
           exit;
       end;

       if (FZ_stream.AvailableIn = 0) and (not(FBaseStream_eof)) then begin
           cnt := FBaseStream.Read(PByte(FBuff.buffer[0])^, buffsize);
           FZ_stream.PrepareInBuffer(FBuff, 0, cnt);  

           if (FZ_stream.AvailableIn = 0) then begin
              FBaseStream_eof := true;
           end;
       end;
       FL_in := FL_in + FZ_stream.AvailableIn;
       FL_out := FL_out + FZ_stream.AvailableOut;
       FZ_err := FZ_stream.Inflate(FlushMode_Z_NO_FLUSH);
       FL_in := FL_in - FZ_stream.AvailableIn;
       FL_out := FL_out - FZ_stream.AvailableOut;

       if (FZ_err = CompressionReturnCode_Z_STREAM_END) then begin
           //* Check CRC and original size */
           Fcrc := Adler32_crc32(Fcrc, FStart.ArrByte, longword(FStart.Offset), FZ_stream.NextOut - longword(FStart.Offset));
           FStart.Assign(FBuff, longint(FZ_stream.NextOut)); 

           if (getLong() <> Fcrc) then begin
               FZ_err := CompressionReturnCode_Z_DATA_ERROR;
           end
           else begin
               getLong();
               //* The uncompressed length returned by above getlong() may be
               //*different from s->out in case of concatenated .gz files.
               //*Check for such files:
                
               //check_header();
               //if (FZ_err = CompressionReturnCode_Z_OK) then begin
                    
                   //inflateReset(&(s->stream));
                   //Fcrc := Adler32_crc32(0L, nil, 0, 0);
               //end;
           end;
       end;
       if (FZ_err <> CompressionReturnCode_Z_OK) or (FBaseStream_eof) then break;
   end;
   Fcrc := Adler32_crc32(Fcrc, FStart.ArrByte, longword(FStart.Offset), FZ_stream.NextOut - longword(FStart.Offset));
   if (longword(count) = FZ_stream.AvailableOut) and
       ((FZ_err = CompressionReturnCode_Z_DATA_ERROR) or  
        (FZ_err = CompressionReturnCode_Z_ERRNO)) then
       raise Exception.Create('Data error'); //result := -1;
finally
   b.Free;
   FStart.Free;
end;
   result := longint(longword(count) - FZ_stream.AvailableOut);
end; 

function TGZipStream.Write(const buffer; count:longint):longint;
Var ret:CompressionReturnCode;
    b:TArrByte;
begin
   b := nil;
   result := 0;
   if (count = 0) then begin
      exit;
   end;
try
   b := TArrByte.Create(buffer, count);

   if not(CanWrite) then begin
       raise Exception.Create('You can not write into decompress stream!');
   end;
   FZ_stream.PrepareInBuffer(b, 0, count);
   ret := Deflate(FFlush);
   Fcrc := Adler32_crc32(Fcrc, b, 0, longword(count));

   if (ret <> CompressionReturnCode_Z_OK) and 
       (ret <> CompressionReturnCode_Z_STREAM_END) then begin
       raise Exception.Create('Compression error: ' + FZ_stream.ErrorMessage);
   end; 

   if (FZ_stream.AvailableIn > 0) then
       raise Exception.Create('Compression error: ' + FZ_stream.ErrorMessage);
finally
   b.Free;
end;
   result := count;
end;


function TGZipStream.getBaseStream:TStream;
begin
   result := FBaseStream; 
end;


procedure TGZipStream.putLong(value:longword);
Var buf:TArrByte;
    i:longint;
begin
   buf := TArrByte.Create(4);

   for i := 0  to 3 do begin
      buf[i] := byte(value and $FF);
      value := value shr 8;  
   end;   
   FBaseStream.Write(PByte(buf.buffer[0])^, 4);
   buf.Free;
end; 


procedure TGZipStream.Close();
begin
   try 
      if (FCompressionmode = CompressionMode_Compress) then begin
         if (do_flush(FlushMode_Z_FINISH) <> CompressionReturnCode_Z_OK) then begin
            raise Exception.Create(FZ_stream.ErrorMessage);
         end; 

         putLong(Fcrc);
         putLong(longword(FL_in and $FFFFFFFF));

//NI         FBaseStream.Flush(); 
      end;
   finally begin
//NI       FBaseStream.Close();
       FBaseStream.Free;
       FBaseStream := nil; 
      end;
   end;

end; 

initialization

gz_magic := TArrByte.Create([$1f, $8b]);

finalization
gz_magic.Free;
end.
