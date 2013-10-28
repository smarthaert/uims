//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         zlib_code
//
//      Description:  Structure for decoding tables (zlib)
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

unit zlib_code;
{$Q-}
{$R-}

interface
{/* Structure for decoding tables.  Each entry provides either the
   information needed to do the operation requested by the code that
   indexed that table entry, or it provides a pointer to another
   table that indexes more bits of the code.  FOp indicates whether
   the entry is a pointer to another table, a literal, a length or
   distance, an end-of-block, or an invalid code.  For a table
   pointer, the low four bits of FOp is the number of index bits of
   that table.  For a length or distance, the low four bits of FOp
   is the number of extra bits to get after the code.  bits is
   the number of bits in this code or part of the code to drop off
   of the bit buffer.  FVal is the actual byte to output in the case
   of a literal, the base length or distance, or the FOffset from
   the current table to the next table.  Each entry is four bytes. */}
uses zlib_deftype;

type 
   TCode = record
      FOp:byte;           //* operation, extra bits, table bits */
      FBits:byte;         //* bits in this part of the code */
      FVal:word;          //* FOffset in table or code value */
   end;
{/* FOp values as set by inflate_table():
    00000000 - literal
    0000tttt - table link, tttt != 0 is the number of table index bits
    0001eeee - length or distance, eeee is the number of extra bits
    01100000 - end of block
    01000000 - invalid code
 */}


   TCodes = class
   private
      FArr:TArrWord;
      FOffset:longword;// = 0
   public   
      constructor Create(Size:longint);overload;
      constructor Create(ref_codes:TCodes; offset:longword);overload;
      constructor Create(ref_arr:TArrWord; offset:longword);overload;
   
      function  getOp(Index:longword):byte;
      function  getBits(Index:longword):byte;
      function  getVal(Index:longword):byte;
      function  getCode(Index:longword):TCode;
      procedure setCode(Index:longword; op, bits:byte; val:word);overload;
      procedure setCode(Index:longword; code:TCode);overload;
      procedure Assign(ref_codes:TCodes; offset:longword);overload;
      procedure Assign(ref_arr:TArrWord; offset:longword);overload;
   end;

Var
   Code_lenfix:TArrWord;
   Code_distfix:TArrWord;

implementation

constructor TCodes.Create(Size:longint);
begin
   inherited Create;

   setLength(FArr, size * 3);
end;

constructor TCodes.Create(ref_codes:TCodes; offset:longword);
begin
   inherited Create;

   FArr := ref_codes.FArr;
   self.FOffset := offset;
end;

constructor TCodes.Create(ref_arr:TArrWord; offset:longword);
begin
   inherited Create;
  
   FArr := ref_arr;
   self.FOffset := offset;
end;

procedure TCodes.Assign(ref_codes:TCodes; offset:longword);
begin
   FArr := ref_codes.FArr;
   self.FOffset := offset;
end;

procedure TCodes.Assign(ref_arr:TArrWord; offset:longword);
begin
   FArr := ref_arr;
   self.FOffset := offset;
end;

function TCodes.getOp(Index:longword):byte;
begin
   result := byte(FArr[(FOffset + Index) * 3 + 0]); 
end;

function TCodes.getBits(Index:longword):byte;
begin
   result := byte(FArr[(FOffset + Index) * 3 + 1]); 
end;

function TCodes.getVal(Index:longword):byte;
begin
   result := byte(FArr[(FOffset + Index) * 3 + 2]); 
end;

function TCodes.getCode(Index:longword):TCode;
Var i:longword;
    rec:TCode;
begin
   i := word(FOffset + Index) * 3;  
   
   rec.FOp := byte(FArr[i]);
   rec.FBits := byte(FArr[i + 1]);
   rec.FVal := word(FArr[i + 2]);

   result := rec;
end;

procedure TCodes.setCode(Index:longword; op, bits:byte; val:word);
Var i:longword;
begin
   i := longword(FOffset + Index) * 3;  
   FArr[i] := op;
   FArr[i + 1] := bits;
   FArr[i + 2] := val;
end;

procedure TCodes.setCode(Index:longword; code:TCode);
Var i:longword;
begin
   i := longword(FOffset + Index) * 3;  
   FArr[i] := code.FOp;
   FArr[i + 1] := code.FBits;
   FArr[i + 2] := code.FVal;
end;

procedure initArrayWord(Var Arr:TArrWord; scr:array of word);
Var i:longint;
begin
  SetLength(Arr, length(scr));
  for i := 0 to length(scr) - 1 do
      Arr[i] := scr[i];
end;

initialization

initArrayWord(Code_lenfix, 
        [  96,7,0 , 0,8,80 , 0,8,16 , 20,8,115 , 18,7,31 , 0,8,112 , 0,8,48 ,
           0,9,192 , 16,7,10 , 0,8,96 , 0,8,32 , 0,9,160 , 0,8,0 , 0,8,128 ,
           0,8,64 , 0,9,224 , 16,7,6 , 0,8,88 , 0,8,24 , 0,9,144 , 19,7,59 ,
           0,8,120 , 0,8,56 , 0,9,208 , 17,7,17 , 0,8,104 , 0,8,40 , 0,9,176 ,
           0,8,8 , 0,8,136 , 0,8,72 , 0,9,240 , 16,7,4 , 0,8,84 , 0,8,20 ,
           21,8,227 , 19,7,43 , 0,8,116 , 0,8,52 , 0,9,200 , 17,7,13 , 0,8,100 ,
           0,8,36 , 0,9,168 , 0,8,4 , 0,8,132 , 0,8,68 , 0,9,232 , 16,7,8 ,
           0,8,92 , 0,8,28 , 0,9,152 , 20,7,83 , 0,8,124 , 0,8,60 , 0,9,216 ,
           18,7,23 , 0,8,108 , 0,8,44 , 0,9,184 , 0,8,12 , 0,8,140 , 0,8,76 ,
           0,9,248 , 16,7,3 , 0,8,82 , 0,8,18 , 21,8,163 , 19,7,35 , 0,8,114 ,
           0,8,50 , 0,9,196 , 17,7,11 , 0,8,98 , 0,8,34 , 0,9,164 , 0,8,2 ,
           0,8,130 , 0,8,66 , 0,9,228 , 16,7,7 , 0,8,90 , 0,8,26 , 0,9,148 ,
           20,7,67 , 0,8,122 , 0,8,58 , 0,9,212 , 18,7,19 , 0,8,106 , 0,8,42 ,
           0,9,180 , 0,8,10 , 0,8,138 , 0,8,74 , 0,9,244 , 16,7,5 , 0,8,86 ,
           0,8,22 , 64,8,0 , 19,7,51 , 0,8,118 , 0,8,54 , 0,9,204 , 17,7,15 ,
           0,8,102 , 0,8,38 , 0,9,172 , 0,8,6 , 0,8,134 , 0,8,70 , 0,9,236 ,
           16,7,9 , 0,8,94 , 0,8,30 , 0,9,156 , 20,7,99 , 0,8,126 , 0,8,62 ,
           0,9,220 , 18,7,27 , 0,8,110 , 0,8,46 , 0,9,188 , 0,8,14 , 0,8,142 ,
           0,8,78 , 0,9,252 , 96,7,0 , 0,8,81 , 0,8,17 , 21,8,131 , 18,7,31 ,
           0,8,113 , 0,8,49 , 0,9,194 , 16,7,10 , 0,8,97 , 0,8,33 , 0,9,162 ,
           0,8,1 , 0,8,129 , 0,8,65 , 0,9,226 , 16,7,6 , 0,8,89 , 0,8,25 ,
           0,9,146 , 19,7,59 , 0,8,121 , 0,8,57 , 0,9,210 , 17,7,17 , 0,8,105 ,
           0,8,41 , 0,9,178 , 0,8,9 , 0,8,137 , 0,8,73 , 0,9,242 , 16,7,4 ,
           0,8,85 , 0,8,21 , 16,8,258 , 19,7,43 , 0,8,117 , 0,8,53 , 0,9,202 ,
           17,7,13 , 0,8,101 , 0,8,37 , 0,9,170 , 0,8,5 , 0,8,133 , 0,8,69 ,
           0,9,234 , 16,7,8 , 0,8,93 , 0,8,29 , 0,9,154 , 20,7,83 , 0,8,125 ,
           0,8,61 , 0,9,218 , 18,7,23 , 0,8,109 , 0,8,45 , 0,9,186 , 0,8,13 ,
           0,8,141 , 0,8,77 , 0,9,250 , 16,7,3 , 0,8,83 , 0,8,19 , 21,8,195 ,
           19,7,35 , 0,8,115 , 0,8,51 , 0,9,198 , 17,7,11 , 0,8,99 , 0,8,35 ,
           0,9,166 , 0,8,3 , 0,8,131 , 0,8,67 , 0,9,230 , 16,7,7 , 0,8,91 ,
           0,8,27 , 0,9,150 , 20,7,67 , 0,8,123 , 0,8,59 , 0,9,214 , 18,7,19 ,
           0,8,107 , 0,8,43 , 0,9,182 , 0,8,11 , 0,8,139 , 0,8,75 , 0,9,246 ,
           16,7,5 , 0,8,87 , 0,8,23 , 64,8,0 , 19,7,51 , 0,8,119 , 0,8,55 ,
           0,9,206 , 17,7,15 , 0,8,103 , 0,8,39 , 0,9,174 , 0,8,7 , 0,8,135 ,
           0,8,71 , 0,9,238 , 16,7,9 , 0,8,95 , 0,8,31 , 0,9,158 , 20,7,99 ,
           0,8,127 , 0,8,63 , 0,9,222 , 18,7,27 , 0,8,111 , 0,8,47 , 0,9,190 ,
           0,8,15 , 0,8,143 , 0,8,79 , 0,9,254 , 96,7,0 , 0,8,80 , 0,8,16 ,
           20,8,115 , 18,7,31 , 0,8,112 , 0,8,48 , 0,9,193 , 16,7,10 , 0,8,96 ,
           0,8,32 , 0,9,161 , 0,8,0 , 0,8,128 , 0,8,64 , 0,9,225 , 16,7,6 ,
           0,8,88 , 0,8,24 , 0,9,145 , 19,7,59 , 0,8,120 , 0,8,56 , 0,9,209 ,
           17,7,17 , 0,8,104 , 0,8,40 , 0,9,177 , 0,8,8 , 0,8,136 , 0,8,72 ,
           0,9,241 , 16,7,4 , 0,8,84 , 0,8,20 , 21,8,227 , 19,7,43 , 0,8,116 ,
           0,8,52 , 0,9,201 , 17,7,13 , 0,8,100 , 0,8,36 , 0,9,169 , 0,8,4 ,
           0,8,132 , 0,8,68 , 0,9,233 , 16,7,8 , 0,8,92 , 0,8,28 , 0,9,153 ,
           20,7,83 , 0,8,124 , 0,8,60 , 0,9,217 , 18,7,23 , 0,8,108 , 0,8,44 ,
           0,9,185 , 0,8,12 , 0,8,140 , 0,8,76 , 0,9,249 , 16,7,3 , 0,8,82 ,
           0,8,18 , 21,8,163 , 19,7,35 , 0,8,114 , 0,8,50 , 0,9,197 , 17,7,11 ,
           0,8,98 , 0,8,34 , 0,9,165 , 0,8,2 , 0,8,130 , 0,8,66 , 0,9,229 ,
           16,7,7 , 0,8,90 , 0,8,26 , 0,9,149 , 20,7,67 , 0,8,122 , 0,8,58 ,
           0,9,213 , 18,7,19 , 0,8,106 , 0,8,42 , 0,9,181 , 0,8,10 , 0,8,138 ,
           0,8,74 , 0,9,245 , 16,7,5 , 0,8,86 , 0,8,22 , 64,8,0 , 19,7,51 ,
           0,8,118 , 0,8,54 , 0,9,205 , 17,7,15 , 0,8,102 , 0,8,38 , 0,9,173 ,
           0,8,6 , 0,8,134 , 0,8,70 , 0,9,237 , 16,7,9 , 0,8,94 , 0,8,30 ,
           0,9,157 , 20,7,99 , 0,8,126 , 0,8,62 , 0,9,221 , 18,7,27 , 0,8,110 ,
           0,8,46 , 0,9,189 , 0,8,14 , 0,8,142 , 0,8,78 , 0,9,253 , 96,7,0 ,
           0,8,81 , 0,8,17 , 21,8,131 , 18,7,31 , 0,8,113 , 0,8,49 , 0,9,195 ,
           16,7,10 , 0,8,97 , 0,8,33 , 0,9,163 , 0,8,1 , 0,8,129 , 0,8,65 ,
           0,9,227 , 16,7,6 , 0,8,89 , 0,8,25 , 0,9,147 , 19,7,59 , 0,8,121 ,
           0,8,57 , 0,9,211 , 17,7,17 , 0,8,105 , 0,8,41 , 0,9,179 , 0,8,9 ,
           0,8,137 , 0,8,73 , 0,9,243 , 16,7,4 , 0,8,85 , 0,8,21 , 16,8,258 ,
           19,7,43 , 0,8,117 , 0,8,53 , 0,9,203 , 17,7,13 , 0,8,101 , 0,8,37 ,
           0,9,171 , 0,8,5 , 0,8,133 , 0,8,69 , 0,9,235 , 16,7,8 , 0,8,93 ,
           0,8,29 , 0,9,155 , 20,7,83 , 0,8,125 , 0,8,61 , 0,9,219 , 18,7,23 ,
           0,8,109 , 0,8,45 , 0,9,187 , 0,8,13 , 0,8,141 , 0,8,77 , 0,9,251 ,
           16,7,3 , 0,8,83 , 0,8,19 , 21,8,195 , 19,7,35 , 0,8,115 , 0,8,51 ,
           0,9,199 , 17,7,11 , 0,8,99 , 0,8,35 , 0,9,167 , 0,8,3 , 0,8,131 ,
           0,8,67 , 0,9,231 , 16,7,7 , 0,8,91 , 0,8,27 , 0,9,151 , 20,7,67 ,
           0,8,123 , 0,8,59 , 0,9,215 , 18,7,19 , 0,8,107 , 0,8,43 , 0,9,183 ,
           0,8,11 , 0,8,139 , 0,8,75 , 0,9,247 , 16,7,5 , 0,8,87 , 0,8,23 ,
           64,8,0 , 19,7,51 , 0,8,119 , 0,8,55 , 0,9,207 , 17,7,15 , 0,8,103 ,
           0,8,39 , 0,9,175 , 0,8,7 , 0,8,135 , 0,8,71 , 0,9,239 , 16,7,9 ,
           0,8,95 , 0,8,31 , 0,9,159 , 20,7,99 , 0,8,127 , 0,8,63 , 0,9,223 ,
           18,7,27 , 0,8,111 , 0,8,47 , 0,9,191 , 0,8,15 , 0,8,143 , 0,8,79 ,
           0,9,255
        ]);  

initArrayWord(Code_distfix,
        [  16,5,1 , 23,5,257 , 19,5,17 , 27,5,4097 , 17,5,5 , 25,5,1025 ,
           21,5,65 , 29,5,16385 , 16,5,3 , 24,5,513 , 20,5,33 , 28,5,8193 ,
           18,5,9 , 26,5,2049 , 22,5,129 , 64,5,0 , 16,5,2 , 23,5,385 ,
           19,5,25 , 27,5,6145 , 17,5,7 , 25,5,1537 , 21,5,97 , 29,5,24577 ,
           16,5,4 , 24,5,769 , 20,5,49 , 28,5,12289 , 18,5,13 , 26,5,3073 ,
           22,5,193 , 64,5,0 
        ]);
end.