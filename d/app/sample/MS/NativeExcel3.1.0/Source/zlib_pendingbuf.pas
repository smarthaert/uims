//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         zlib_pendingbuf
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

unit zlib_pendingbuf;
{$Q-}
{$R-}


interface
{$I xlsdef.inc}

uses zlib_deftype, zlib_const, zlib_z_stream;

type 
   TPendingBuf = class  
   private 
         FPending_buf:TArrByte;     //* output still pending */
         FPending_buf_size:longword;//ulong  //* size of pending_buf */
         FPending_out:longword;     //* next pending byte to output to the stream */
         FPending:longword;         //* nb of bytes in the pending buffer */


         //*!!!!to tree*/ 
         FL_buf:longword;  //ulong //* buffer for literals or lengths */

         //*!!!!to tree*/ 
         FLit_bufsize:longword;
         {/* Size of match buffer for literals/lengths.  There are 4 reasons for
          * limiting FLit_bufsize to 64K:
          *   - frequencies can be kept in 16 bit counters
          *   - if compression is not successful for the first block, all input
          *     data is still in the window so we can still emit a stored block even
          *     when input comes from standard input.  (This can also be done for
          *     all blocks if FLit_bufsize is not greater than 32K.)
          *   - if compression is not successful for a file smaller than 64K, we can
          *     even emit a stored file instead of a stored block (saving 5 bytes).
          *     This is applicable only for zip (not gzip or zlib).
          *   - creating new Huffman trees less frequently may not provide fast
          *     adaptation to changes in the input data statistics. (Take for
          *     example a binary file with poorly compressible code followed by
          *     a highly compressible string table.) Smaller buffer sizes give
          *     fast adaptation but have of course the overhead of transmitting
          *     trees more frequently.
          *   - I can't count above 4
          */}


          //*!!!!to tree*/
          FD_buf:longword; //ulong
          //* Buffer for distances. To simplify the code, FD_buf and FL_buf have
          //* the same number of elements. To use different lengths, an extra flag
          //* array would be necessary.

      function getBaseBuff:TArrByte;
      function getPending:longword;
      function getSize:longword;
      function getLitBufSize:longword;

   public
      constructor Create(lit_bufsize:longword);
      destructor Destroy;override;

      function  GetHashCode:longint; {$ifdef D2009}override;{$endif}
      procedure put_byte(c:byte);
      procedure put_bytes(srcbuf:TArrByte; offset, length:longint);


      procedure put_short(c:word);
      procedure putShortMSB(b:longword);
      procedure Reset();
      procedure CopyToStrmOut(strm:TZ_Stream; len:longword);
     
      function  GetDBuf(index:longword):longword;
      function  GetLBuf(index:longword):longint;
      procedure SetLBuf(index:longword; value:byte);
      procedure SetDBuf(index:longword; value:word);

   
      property LitBufSize:longword read getLitBufSize;
      property Size:longword read getSize;
      property Pending:longword read getPending;
      property BaseBuff:TArrByte read getBaseBuff;
   
   end;


implementation

function TPendingBuf.GetHashCode():longint;
Var HashCode:longword;
begin
   HashCode := 1;   

   HashCode := 33 * HashCode + longword(ZLibConst_GetHashCodeForVal(FPending_buf)); 
   HashCode := HashCode + HashCode shr 5;
   HashCode := 33 * HashCode + longword(FPending_buf_size);
   HashCode := HashCode + HashCode shr 5;
   HashCode := 33 * HashCode + longword(FPending_out);
   HashCode := HashCode + HashCode shr 5;
   HashCode := 33 * HashCode + longword(FPending);
   HashCode := HashCode + HashCode shr 5;
   HashCode := 33 * HashCode + longword(FL_buf);
   HashCode := HashCode + HashCode shr 5;
   HashCode := 33 * HashCode + longword(FLit_bufsize);
   HashCode := HashCode + HashCode shr 5;
   HashCode := 33 * HashCode + longword(FD_buf);
   HashCode := HashCode + HashCode shr 5;

   result := longint(HashCode);  
end;

constructor TPendingBuf.Create(lit_bufsize:longword);
begin
   inherited Create;

   self.FLit_bufsize := lit_bufsize;
   self.FPending_buf_size := longword(FLit_bufsize) * (ZLibConst_sizeof_ush + 2);
   self.FPending_buf := TArrByte.Create(FPending_buf_size);
   self.FD_buf := longword(FLit_bufsize);
   self.FL_buf := longword(1 + ZLibConst_sizeof_ush) * longword(FLit_bufsize);
end;

destructor TPendingBuf.Destroy;
begin
   self.FPending_buf.Free;

   inherited Destroy;
end;


procedure TPendingBuf.put_byte(c:byte);
begin
   FPending_buf[FPending] := c;
   FPending := FPending + 1;
end;

procedure TPendingBuf.put_bytes(srcbuf:TArrByte; offset, length:longint);
begin
   ArrayCopy(srcbuf, offset, FPending_buf, FPending, length);
   FPending := FPending + longword(length);
end;


//* :===========================================================================
//* Output a short LSB first on the stream.
//* ===========================================================================
procedure TPendingBuf.put_short(c:word);
begin
   FPending_buf[FPending] := byte(c and $ff);
   FPending := FPending + 1;
   FPending_buf[FPending] := byte(c shr 8);
   FPending := FPending + 1;
end;

procedure TPendingBuf.putShortMSB(b:longword);
begin
   FPending_buf[FPending] := byte(b shr 8);
   FPending := FPending + 1;
   FPending_buf[FPending] := byte(b and $ff);
   FPending := FPending + 1;
end;

procedure TPendingBuf.Reset();
begin
   FPending := 0;
   FPending_out := 0;
end;

procedure TPendingBuf.CopyToStrmOut(strm:TZ_Stream; len:longword);
begin
   strm.CopyToOutBuf(FPending_buf, FPending_out, len);
   FPending_out    := FPending_out + len;
   FPending        := FPending - len;

   if (FPending = 0) then
      FPending_out := 0;
            
end;


function TPendingBuf.getBaseBuff:TArrByte;
begin
   result := FPending_buf;
end;


function TPendingBuf.getPending:longword;
begin
   result := FPending;
end;


function TPendingBuf.getSize:longword;
begin
   result := FPending_buf_size;
end;


function TPendingBuf.getLitBufSize:longword;
begin
   result := FLit_bufsize;
end;


function TPendingBuf.GetDBuf(index:longword):longword;
begin
   result := longword(
            ((FPending_buf[FD_buf + index * 2] shl 8) and $ff00) or
            (FPending_buf[FD_buf + index * 2 + 1] and $ff)
          );
end;

function TPendingBuf.GetLBuf(index:longword):longint;
begin
   result := (FPending_buf[FL_buf + index] and $ff);
end;


procedure TPendingBuf.SetDBuf(index:longword; value:word);
begin
   FPending_buf[FD_buf + index * 2] := byte((value shr 8) and $FF);
   FPending_buf[FD_buf + index * 2 + 1] := byte(value and $FF);
end;

procedure TPendingBuf.SetLBuf(index:longword; value:byte);
begin
   FPending_buf[FL_buf + index] := value;
end;

end.