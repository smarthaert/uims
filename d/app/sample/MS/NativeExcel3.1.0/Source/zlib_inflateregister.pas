//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         zlib_inflaterregister
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

unit zlib_inflateregister;
{$Q-}
{$R-}


interface

uses zlib_deftype, zlib_mapped_arr;

type
   TInflateRegister = class
   public
      FNext:TMapped_arr;
      FPut:TMapped_arr;
      //* available input and output */
      FHave:longword;
      FLeft:longword; 
      FHold:longword;//ulong  //* bit buffer */
      Fbits:longword;   //* bits in bit buffer */

      constructor Create;
      destructor Destroy;override;
      function  BITS(n:longint):longword;
      procedure DROPBITS(n:longint);
      procedure INITBITS;
      procedure BYTEBITS;
      procedure Copy(count:longword);
   
   end;

implementation

constructor TInflateRegister.Create;
Var arr1, arr2:TArrByte;
begin
   inherited Create;

   arr1 := nil;
   arr2 := nil;
   FNext := TMapped_arr.Create(arr1, 0); //* FNext input  */  
   FPut := TMapped_arr.Create(arr2, 0);  //* FNext output */  
end;

destructor TInflateRegister.Destroy;
begin
   FNext.Free;
   FPut.Free;

   inherited Destroy;
end;

//* Return the low n bits of the bit accumulator (n < 16) */
function TInflateRegister.BITS(n:longint):longword;
begin
   result := longword(FHold and ((longword($00000001) shl n) - 1)); 
end; 

//* Remove n bits from the bit accumulator */
procedure TInflateRegister.DROPBITS(n:longint);
begin
   FHold := FHold shr n; 
   Fbits := Fbits - longword(n);
end;

//* Clear the input bit accumulator */
procedure TInflateRegister.INITBITS;
begin
   FHold := 0; 
   Fbits := 0; 
end;

//* Remove zero to seven bits as needed to go to a byte boundary */
procedure TInflateRegister.BYTEBITS;
begin
   FHold := FHold shr longint(Fbits and 7); 
   Fbits := Fbits - (Fbits and 7); 
end;

//*Copy from FNext to FPut*/
procedure TInflateRegister.Copy(count:longword);
begin
   ArrayCopy(FNext.ArrByte, FNext.Offset, FPut.ArrByte, FPut.Offset, count);
   FHave := FHave - count; 
   FNext.Offset := FNext.Offset + longint(count);
   FLeft := FLeft - count;
   FPut.Offset := FPut.Offset + longint(count);
end;

end.
