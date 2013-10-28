//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         zlib_zlibstream
//
//      Description:  This file is a part of the zlib data 
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

unit zlib_zlibstream;
{$I xlsdef.inc}
{$Q-}
{$R-}


interface

uses classes, sysutils, zlib_deftype, zlib_const, zlib_z_stream;

type 
   TZLibStream = class(TStream)
   private
      FBaseStream:TStream;
      FBaseStream_eof:boolean; //:= false
      FCompressionmode:CompressionMode;
      FFlush:FlushMode;
      FBuff:TArrByte; 
      FZ_stream:TZ_Stream;
      FFreeBaseStreamOnDestroy: boolean;
      FPosition: int64;

      function Deflate(flush:FlushMode):CompressionReturnCode;
      procedure Init(stream:TStream; Acompressionmode:CompressionMode; compressionlevel:longint; windowBits:longint);
      function getBaseStream:TStream;
      function getLength:int64;
      function getCanWrite:boolean;
      function getCanRead:boolean;
      function getCanSeek:boolean;
      procedure Close();
//      procedure Flush();

   public 
      constructor Create(stream:TStream; compressionlevel:longint; windowBits:longint);overload;
      constructor Create(stream:TStream; compressionlevel:longint);overload;
      constructor Create(stream:TStream; Acompressionmode:CompressionMode; windowBits:longint);overload;
      constructor Create(stream:TStream; Acompressionmode:CompressionMode);overload;
      destructor Destroy;override;

      procedure SetLength(value:int64);

      {$ifdef D45}
      function Seek(Offset: Longint; Origin: Word): Longint; override;
      {$else}
      function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
      {$endif}
      function  Read(Var buffer; count:longint):longint;override;
      function  Write(const buffer; count:longint):longint;override;

      property BaseStream:TStream read getBaseStream;
      property Length:int64 read getLength;
      property CanWrite:boolean read getCanWrite;
      property CanRead:boolean read getCanRead;        
      property CanSeek:boolean read getCanSeek;
      property FreeBaseStreamOnDestroy: boolean read FFreeBaseStreamOnDestroy write FFreeBaseStreamOnDestroy;
   end;


implementation

const buffsize:longint = $1000;

constructor TZLibStream.Create(stream:TStream; Acompressionmode:CompressionMode);
begin
   FPosition := 0;
   FFreeBaseStreamOnDestroy := false;
   Init(stream, Acompressionmode, ord(CompressionLevel_Z_DEFAULT_COMPRESSION), ZLibConst_MAX_WBITS); 
end;

constructor TZLibStream.Create(stream:TStream; Acompressionmode:CompressionMode; windowBits:longint);
begin
   FPosition := 0;
   FFreeBaseStreamOnDestroy := false;
   Init(stream, Acompressionmode, ord(CompressionLevel_Z_DEFAULT_COMPRESSION), windowBits); 
end;

constructor TZLibStream.Create(stream:TStream; compressionlevel:longint);
begin
   FPosition := 0;
   FFreeBaseStreamOnDestroy := false;
   Init(stream, CompressionMode_Compress, compressionlevel, ZLibConst_MAX_WBITS); 
end;

constructor TZLibStream.Create(stream:TStream; compressionlevel:longint; windowBits:longint);
begin
   FPosition := 0;
   FFreeBaseStreamOnDestroy := false;
   Init(stream, CompressionMode_Compress, compressionlevel, windowBits); 
end;

destructor TZLibStream.Destroy;
begin
   Close();
   FBuff.Free;
   FZ_stream.Free;
end;

procedure TZLibStream.Init(stream:TStream; Acompressionmode:CompressionMode; compressionlevel:longint; windowBits:longint);
Var ArrNull:TArrByte;
begin
   ArrNull := nil;
   FBaseStream := stream;
   FCompressionmode := Acompressionmode; 
   FFlush := FlushMode_Z_NO_FLUSH;
   FBuff := TArrByte.Create(buffsize);
   FZ_stream := TZ_Stream.Create();
   if (FCompressionmode = CompressionMode_Compress) then begin
      FZ_stream.PrepareInBuffer(ArrNull, 0, 0);
      FZ_stream.PrepareOutBuffer(FBuff, 0, buffsize);

      FZ_stream.DeflateInit(compressionlevel, windowBits);   
   end
   else begin
      FZ_stream.PrepareInBuffer(FBuff, 0, 0); 

      FZ_stream.InflateInit(windowBits);
   end;
end;
         
function TZLibStream.Deflate(flush:FlushMode):CompressionReturnCode;
Var ret:CompressionReturnCode;
begin
   //ret := CompressionReturnCode_Z_OK;
   repeat
      FZ_stream.PrepareOutBuffer(FBuff, 0, buffsize);
      ret := FZ_stream.Deflate(flush);
      
      if ((ret <> CompressionReturnCode_Z_OK) and 
            (ret <> CompressionReturnCode_Z_STREAM_END)) then begin
         raise Exception.Create('Compression error: ' + FZ_stream.ErrorMessage);
      end
      else begin
         FBaseStream.Write(PByte(FBuff.Buffer[0])^, longint(buffsize - longint(FZ_stream.AvailableOut)));
      end;
   until not ((FZ_stream.AvailableIn > 0) or (FZ_stream.AvailableOut = 0));
   
   result := ret;
end;
         

function TZLibStream.getCanRead:boolean;
begin
   if (FCompressionmode = CompressionMode_Compress) then 
      result := false
   else
      raise Exception.Create('CanRead: Unsupported property');
//NI
//      result := FBaseStream.CanRead;   
end;


function TZLibStream.getCanSeek:boolean;
begin
   result := false;   
end;

function TZLibStream.getCanWrite:boolean;
begin
   if (FCompressionmode = CompressionMode_Decompress) then 
      result := false
   else
      result := true
//      raise Exception.Create('CanWrite: Unsupported property');
//NI
//      result := FBaseStream.CanWrite;   
end;


function TZLibStream.getLength:int64;
begin
   raise Exception.Create('Length: Unsupported feature');
end;


{$ifdef D45}
function TZLibStream.Seek(Offset: Longint; Origin: word): Longint;
{$else}
function TZLibStream.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
{$endif}
var pos: int64;
begin
   pos := FPosition;
{$ifdef D45}
   case origin of 
     soFromBeginning: pos := offset; 
     soFromCurrent:   pos := FPosition + offset; 
     soFromEnd:       pos := FPosition + offset;
   end;
{$else}
   case origin of 
     soBeginning: pos := offset; 
     soCurrent:   pos := FPosition + offset; 
     soEnd:       pos := FPosition + offset;
   end;
{$endif}
   if pos <> FPosition then raise Exception.Create('Seek: Unsupported feature');
   Result := FPosition; 
end;


procedure TZLibStream.SetLength(value:int64);
begin
  raise Exception.Create('SetLength: Unsupported feature');
end;

function TZLibStream.Read(Var buffer; count:longint):longint;
Var ret:CompressionReturnCode;
    cnt:longint;
    b:TArrByte;
begin
   b := nil;
   if (count = 0) then 
      result := 0
   else begin
      try
         b := TArrByte.Create(buffer, count);
         FZ_stream.PrepareOutBuffer(b, 0, count);
         repeat
            if (not(FBaseStream_eof) and (FZ_stream.AvailableIn = 0)) then begin
               cnt := FBaseStream.Read(PByte(FBuff.buffer[0])^, buffsize);
               if (cnt = -1) then begin
                  cnt := 0;
                  FBaseStream_eof := true;
               end; 
               FZ_stream.PrepareInBuffer(FBuff, 0, cnt);
            end;
            ret := FZ_stream.Inflate(FFlush);
         
            if ((ret <> CompressionReturnCode_Z_OK) and
               (ret <> CompressionReturnCode_Z_STREAM_END)) then begin
               raise Exception.Create('Decompression error: ' + FZ_stream.ErrorMessage);
            end;
         until not ((FZ_stream.AvailableOut > 0) and 
                  (ret = CompressionReturnCode_Z_OK));
      finally
         b.Free;
      end;
      result := (count - longint(FZ_stream.AvailableOut));
   end;
   FPosition := FPosition + Result;
end; 


function TZLibStream.Write(const buffer; count:longint):longint;
Var ret:CompressionReturnCode;
    b:TArrByte;
begin
   b := nil;
   if (count <> 0) then begin
      try
         b := TArrByte.Create(buffer, count);
         if not(CanWrite) then begin
            raise Exception.Create('You can write into decompress stream!');
         end;

         FZ_stream.PrepareInBuffer(b, 0, count);
         ret := Deflate(FFlush);
         if ((ret <> CompressionReturnCode_Z_OK) and 
                    (ret <> CompressionReturnCode_Z_STREAM_END)) then begin
            raise Exception.Create('Compression error: ' + FZ_stream.ErrorMessage);
         end; 
      finally
         b.Free;
      end;
   end;
   result := count;
   FPosition := FPosition + Result;
end;

function TZLibStream.getBaseStream:TStream;
begin
   result := FBaseStream; 
end;

procedure TZLibStream.Close();
begin
   try 
      if (FCompressionmode = CompressionMode_Compress) then begin
         Deflate(FlushMode_Z_FINISH);
      end;
   finally 
//NI      FBaseStream.Flush();
      if FFreeBaseStreamOnDestroy then begin
          FBaseStream.Free;
          FBaseStream := nil; 
      end;
   end;

end; 

end.
