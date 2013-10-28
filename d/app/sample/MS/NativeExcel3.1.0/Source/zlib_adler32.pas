//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         zlib_adler32
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


unit zlib_adler32;
{$Q-}
{$R-}


interface
uses zlib_deftype;


function Adler32_adler32(adler:longword; buf:TArrByte; offset, len:longword):longword; //ulong
function Adler32_crc32(crc:longword; buf:TArrByte; offset, len:longword):longword; overload;
function Adler32_crc32(crc:longword; const buffer; len:longword):longword; overload;

Var Adler32_crc32table:TArrLongword;

implementation

const BASE:longword = 65521; //ulong


function Adler32_adler32(adler:longword; buf:TArrByte; offset, len:longword):longword; //ulong
Var sum2:longword;
begin
   sum2 := ((adler shr 16) and $FFFF);
   adler := adler and $FFFF;
   ///* initial Adler-32 value (deferred check for len == 1 speed) */
   if not Assigned(buf) then
      result := 1
   else begin
      while (len > 0) do begin
         adler := adler + buf[offset];
         inc(offset);
         sum2 := sum2 + adler;
         dec(len);
      end;

      adler := adler mod BASE;
      sum2 := sum2 mod BASE;    
      //* return recombined sums */
      result := (adler or (sum2 shl 16));
   end;
end;


{/*
       private ulong adler32_combine(ulong adler1, ulong adler2, ulong len2);
       begin
           uint rem = (uint)(len2 % BASE);
           ulong sum1 = adler1 & 0xFFFF;
           ulong sum2 = rem * sum1;
           sum2 %= BASE;
           sum1 += (adler2 & 0xffff) + BASE - 1;
           sum2 += ((adler1 >> 16) & 0xFFFF) + ((adler2 >> 16) & 0xFFFF) + BASE - rem;
           if (sum1 > BASE) sum1 -= BASE;
           if (sum1 > BASE) sum1 -= BASE;
           if (sum2 > (BASE << 1)) sum2 -= (BASE << 1);
           if (sum2 > BASE) sum2 -= BASE;
           return sum1 | (sum2 << 16);
       end;
*/}


function Adler32_crc32(crc:longword; buf:TArrByte; offset, len:longword):longword;//ulong
Var lasti:longword;
begin
   if not Assigned(buf) then
      result := 0
   else begin
      lasti := offset + len;
      crc := crc xor $ffffffff;
      while (offset < lasti) do begin
         crc := (crc shr 8) xor Adler32_crc32table[buf[offset] xor byte(crc and $FF)];
         inc(offset);
      end;
      result := crc xor $ffffffff;
   end;
end;

function Adler32_crc32(crc:longword; const buffer; len:longword):longword;
var CurP: PAnsiChar;
    LastP: PAnsiChar;
begin
   CurP := PAnsiChar(@buffer);
   if not Assigned(CurP) then begin
      result := 0;
   end else begin
      LastP := CurP + len;
      crc := crc xor $ffffffff;
      while not(CurP = LastP) do begin
         crc := (crc shr 8) xor Adler32_crc32table[byte(CurP^) xor byte(crc and $FF)];
         CurP := CurP + 1;
      end;
      result := crc xor $ffffffff;
   end;
end;


procedure initArrayLongword(Var Arr:TArrLongword; scr:array of longword);
Var i:longint;
begin
  SetLength(Arr, length(scr));
  for i := 0 to length(scr) - 1 do
      arr[i] := scr[i];
end;

initialization

initArrayLongword(Adler32_crc32table, 
         [  $00000000, $77073096, $EE0E612C, $990951BA,  
            $076DC419, $706AF48F, $E963A535, $9E6495A3,  
            $0EDB8832, $79DCB8A4, $E0D5E91E, $97D2D988,  
            $09B64C2B, $7EB17CBD, $E7B82D07, $90BF1D91,  
            $1DB71064, $6AB020F2, $F3B97148, $84BE41DE,  
            $1ADAD47D, $6DDDE4EB, $F4D4B551, $83D385C7,  
            $136C9856, $646BA8C0, $FD62F97A, $8A65C9EC,  
            $14015C4F, $63066CD9, $FA0F3D63, $8D080DF5,  
            $3B6E20C8, $4C69105E, $D56041E4, $A2677172,  
            $3C03E4D1, $4B04D447, $D20D85FD, $A50AB56B,  
            $35B5A8FA, $42B2986C, $DBBBC9D6, $ACBCF940,  
            $32D86CE3, $45DF5C75, $DCD60DCF, $ABD13D59,  
            $26D930AC, $51DE003A, $C8D75180, $BFD06116,  
            $21B4F4B5, $56B3C423, $CFBA9599, $B8BDA50F,  
            $2802B89E, $5F058808, $C60CD9B2, $B10BE924,  
            $2F6F7C87, $58684C11, $C1611DAB, $B6662D3D,  

            $76DC4190, $01DB7106, $98D220BC, $EFD5102A,  
            $71B18589, $06B6B51F, $9FBFE4A5, $E8B8D433,  
            $7807C9A2, $0F00F934, $9609A88E, $E10E9818,  
            $7F6A0DBB, $086D3D2D, $91646C97, $E6635C01,  
            $6B6B51F4, $1C6C6162, $856530D8, $F262004E,  
            $6C0695ED, $1B01A57B, $8208F4C1, $F50FC457,  
            $65B0D9C6, $12B7E950, $8BBEB8EA, $FCB9887C,  
            $62DD1DDF, $15DA2D49, $8CD37CF3, $FBD44C65,  
            $4DB26158, $3AB551CE, $A3BC0074, $D4BB30E2,  
            $4ADFA541, $3DD895D7, $A4D1C46D, $D3D6F4FB,  
            $4369E96A, $346ED9FC, $AD678846, $DA60B8D0,  
            $44042D73, $33031DE5, $AA0A4C5F, $DD0D7CC9,  
            $5005713C, $270241AA, $BE0B1010, $C90C2086,  
            $5768B525, $206F85B3, $B966D409, $CE61E49F,  
            $5EDEF90E, $29D9C998, $B0D09822, $C7D7A8B4,  
            $59B33D17, $2EB40D81, $B7BD5C3B, $C0BA6CAD,  

            $EDB88320, $9ABFB3B6, $03B6E20C, $74B1D29A,  
            $EAD54739, $9DD277AF, $04DB2615, $73DC1683,  
            $E3630B12, $94643B84, $0D6D6A3E, $7A6A5AA8,  
            $E40ECF0B, $9309FF9D, $0A00AE27, $7D079EB1,  
            $F00F9344, $8708A3D2, $1E01F268, $6906C2FE,  
            $F762575D, $806567CB, $196C3671, $6E6B06E7,  
            $FED41B76, $89D32BE0, $10DA7A5A, $67DD4ACC,  
            $F9B9DF6F, $8EBEEFF9, $17B7BE43, $60B08ED5,  
            $D6D6A3E8, $A1D1937E, $38D8C2C4, $4FDFF252,  
            $D1BB67F1, $A6BC5767, $3FB506DD, $48B2364B,  
            $D80D2BDA, $AF0A1B4C, $36034AF6, $41047A60,  
            $DF60EFC3, $A867DF55, $316E8EEF, $4669BE79,  
            $CB61B38C, $BC66831A, $256FD2A0, $5268E236,  
            $CC0C7795, $BB0B4703, $220216B9, $5505262F,  
            $C5BA3BBE, $B2BD0B28, $2BB45A92, $5CB36A04,  
            $C2D7FFA7, $B5D0CF31, $2CD99E8B, $5BDEAE1D,  

            $9B64C2B0, $EC63F226, $756AA39C, $026D930A,  
            $9C0906A9, $EB0E363F, $72076785, $05005713,  
            $95BF4A82, $E2B87A14, $7BB12BAE, $0CB61B38,  
            $92D28E9B, $E5D5BE0D, $7CDCEFB7, $0BDBDF21,  
            $86D3D2D4, $F1D4E242, $68DDB3F8, $1FDA836E,  
            $81BE16CD, $F6B9265B, $6FB077E1, $18B74777,  
            $88085AE6, $FF0F6A70, $66063BCA, $11010B5C,  
            $8F659EFF, $F862AE69, $616BFFD3, $166CCF45,  
            $A00AE278, $D70DD2EE, $4E048354, $3903B3C2,  
            $A7672661, $D06016F7, $4969474D, $3E6E77DB,  
            $AED16A4A, $D9D65ADC, $40DF0B66, $37D83BF0,  
            $A9BCAE53, $DEBB9EC5, $47B2CF7F, $30B5FFE9,  
            $BDBDF21C, $CABAC28A, $53B39330, $24B4A3A6,  
            $BAD03605, $CDD70693, $54DE5729, $23D967BF,  
            $B3667A2E, $C4614AB8, $5D681B02, $2A6F2B94,  
            $B40BBE37, $C30C8EA1, $5A05DF1B, $2D02EF8D
          ]
       );

end.
