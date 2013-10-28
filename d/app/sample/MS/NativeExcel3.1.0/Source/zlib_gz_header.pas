//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         zlib_gz_header
//
//      Description:  gz header
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

unit zlib_gz_header;

{$Q-}
{$R-}


interface

uses zlib_deftype, zlib_const, zlib_pendingbuf;
type 

   Tgz_header = class 

   public
      FText:longint;       ///* true if compressed data believed to be FText */
      FTime:longword;  //ulong     ///* modification FTime */
      Fxflags:longint;     ///* FExtra flags (not used when writing a gzip file) */
      Fos:longint;         ///* operating system */
      FExtra:TArrByte;      ///* pointer to FExtra field or Z_NULL if none */
      FExtra_len:longword;  ///* FExtra field length (valid if FExtra != Z_NULL) */
      FExtra_max:longword;  ///* space at FExtra (only when reading header) */
      FName:TArrByte;       ///* pointer to zero-terminated file FName or Z_NULL */
      FName_max:longword;   ///* space at FName (only when reading header) */
      FComment:TArrByte;    ///* pointer to zero-terminated FComment or Z_NULL */
      FComm_max:longword;   ///* space at FComment (only when reading header) */
      FHcrc:longint;       ///* true if there was or will be a header crc */
      FDone:longint;       ///* true when FDone reading gzip header (not used
                           //*             when writing a gzip file) */

      procedure WriteHeader(pb:TPendingBuf; level:longint; strategy:CompressionStrategy);
   end;

implementation

procedure Tgz_header.WriteHeader(pb:TPendingBuf; level:longint; strategy:CompressionStrategy);
Var b:byte;
    b1:byte;
begin
   if FText > 0 then b := 1 else b := 0;
   if FHcrc > 0 then b := b + 2 else b := b + 0;
   if not Assigned(FExtra)   then b := b + 0 else b := b + 4;
   if not Assigned(FName)    then b := b + 0 else b := b + 8;
   if not Assigned(FComment) then b := b + 0 else b := b + 16;

   pb.put_byte(byte(b));
   
   pb.put_byte(byte(FTime and $ff));
   pb.put_byte(byte((FTime shr  8) and $ff));
   pb.put_byte(byte((FTime shr 16) and $ff));
   pb.put_byte(byte((FTime shr 24) and $ff));


   if level = 9 then 
      b1 := 2
   else
      if (strategy >= CompressionStrategy_Z_HUFFMAN_ONLY) or (level < 2) then
         b1 := 4
      else
         b1 := 0;

   pb.put_byte(byte(b1));

   pb.put_byte(byte(Fos and $ff));
   if Assigned(FExtra) then begin
      pb.put_byte(byte(FExtra_len and $ff));
      pb.put_byte(byte((FExtra_len shr 8) and $ff));
   end;
end;

end.
