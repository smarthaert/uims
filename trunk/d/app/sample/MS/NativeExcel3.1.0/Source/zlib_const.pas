//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         zlib_const
//
//      Description:  constants
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

unit zlib_const;
{$Q-}
{$R-}



interface

uses zlib_deftype, zlib_config;

const
        
     ZLibConst_MAX_WBITS = longint(15); // 32K LZ77 window    
     ZLibConst_DEF_WBITS = longint(ZLibConst_MAX_WBITS);

     ZLibConst_MAX_MEM_LEVEL = longint(8);
     {$IFDEF ZLibConst_MAX_MEM_LEVEL > 8} 
        ZLibConst_DEF_MEM_LEVEL = longint(8);
     {$ELSE} 
        ZLibConst_DEF_MEM_LEVEL = longint(ZLibConst_MAX_MEM_LEVEL);
     {$ENDIF} 

     ZLibConst_MIN_MATCH  = longint(3);
     ZLibConst_MAX_MATCH  = longint(258);
     ZLibConst_MIN_LOOKAHEAD = longint(ZLibConst_MAX_MATCH + ZLibConst_MIN_MATCH + 1);
     //* Minimum amount of lookahead, except at the end of the input file.
     //* See deflate.c for comments about the MIN_MATCH+1.
         
     ZLibConst_TOO_FAR = longint(4096);

     ZLibConst_sizeof_ush = longint(2);

     ZLibConst_LENGTH_CODES = longint(29); 
     //* number of length codes, not counting the special END_BLOCK code */

     ZLibConst_LITERALS = longint(256); 
     //* number of literal bytes 0..255 */

     ZLibConst_L_CODES = longint((ZLibConst_LITERALS + 1 + ZLibConst_LENGTH_CODES));
     //* number of Literal or Length codes, including the END_BLOCK code */

     ZLibConst_D_CODES = longint(30);
     //* number of distance codes */

     ZLibConst_BL_CODES = longint(19);
     //* number of codes used to transfer the bit lengths */

     ZLibConst_HEAP_SIZE = longint((2 * ZLibConst_L_CODES + 1));
     //* maximum heap size */

     ZLibConst_MAX_BITS = longint(15);
     //* All codes must not exceed MAX_BITS bits */

     ZLibConst_MAX_BL_BITS = longint(7);
     //* Bit length codes must not exceed MAX_BL_BITS bits */

     ZLibConst_END_BLOCK = longint(256);
     //* end of block literal code */

     ZLibConst_REP_3_6     = longint(16);
     //* repeat previous bit length 3-6 times (2 bits of repeat count) */

     ZLibConst_REPZ_3_10   = longint(17);
     //* repeat a zero length 3-10 times  (3 bits of repeat count) */

     ZLibConst_REPZ_11_138 = longint(18);
     //* repeat a zero length 11-138 times  (7 bits of repeat count) */


     ZLibConst_PRESET_DICT = longint($20); 
     //* preset dictionary flag in zlib header */

     ZLibConst_Buf_size = longint(8 * 2);

     ZLibConst_STORED_BLOCK = longint(0);
     ZLibConst_STATIC_TREES = longint(1);
     ZLibConst_DYN_TREES    = longint(2);
     //* The three kinds of block type */

     ZLibConst_OS_CODE:byte     = $0b; //WIN32
        
     //*inflater's consts*/
     {/* Maximum size of dynamic tree.  The maximum found in a long but non-
           exhaustive search was 1444 code structures (852 for length/literals
           and 592 for distances, the latter actually the result of an
           exhaustive search).  The true maximum is not known, but the value
           below is more than safe. */}
     ZLibConst_ENOUGH  = longint(2048);
     ZLibConst_MAXD    = longint(592);
     ZLibConst_MAXBITS = longint(15);


     //* gzip flag byte */
     ZLibConst_ASCII_FLAG  = longint($01); //* bit 0 set: file probably ascii text */
     ZLibConst_HEAD_CRC    = longint($02); //* bit 1 set: header CRC present */
     ZLibConst_EXTRA_FIELD = longint($04); //* bit 2 set: extra field present */
     ZLibConst_ORIG_NAME   = longint($08); //* bit 3 set: original file name present */
     ZLibConst_COMMENT     = longint($10); //* bit 4 set: file comment present */
     ZLibConst_RESERVED    = longint($E0); //* bits 5..7: reserved */

Var

   ZLibConst_static_ltree:TArrSmallint;
   ZLibConst_static_dtree:TArrSmallint;
   ZLibConst_base_length:TArrLongint;
   ZLibConst_base_dist:TArrLongint;
   ZLibConst_dist_code:TArrByte;
   ZLibConst_length_code:TArrLongint;
   //* extra bits for each length code */
   ZLibConst_extra_lbits:TArrLongint;
   //* extra bits for each distance code */
   ZLibConst_extra_dbits:TArrLongint;
   //* extra bits for each bit length code */
   ZLibConst_extra_blbits:TArrLongint;
   ZLibConst_bl_order:TArrLongint;
   //* The lengths of the bit length codes are sent in order of decreasing
   //* probability, to avoid transmitting the lengths for unused bit length codes.
   ZLibConst_configuration_table:array [0..9] of TConfig; 



function ZLibConst_GetHashCodeForVal(val:TArrSmallint):longword;overload;
function ZLibConst_GetHashCodeForVal(val:array of word):longword;overload;
function ZLibConst_GetHashCodeForVal(val:TArrByte):longword;overload;
//function ZLibConst_GetHashCodeForVal(val:array of longint):longword;overload;
function ZLibConst_GetHashCodeForVal(val:TArrLongInt):longword;overload;

procedure initArraySmallint(Var Arr:TArrSmallint; scr:array of smallint);
procedure initArrayLongint(Var Arr:TArrLongint; scr:array of longint);
procedure initArrayWord(Var Arr:TArrWord; scr:array of word);
//procedure initArrayByte(Var Arr:TArrByte; scr:array of byte);

implementation

      function ZLibConst_GetHashCodeForVal(val:TArrSmallint):longword;
      Var hash, i:longword;
      begin
          hash := $FFF;   
          if (Length(val) = 0) then 
             result := 1
          else begin
             for i := 0 to Length(val) - 1 do
             begin
                hash := hash + hash * 33 + longword(word(val[i]));
                hash := hash shr 5;
             end;
             result := hash; 
          end;
      end;

      function ZLibConst_GetHashCodeForVal(val:array of word):longword;
      Var hash, i:longword;
      begin
          hash := $FFF;   
          if (Length(val) = 0) then 
             result := 1
          else begin
             for i := 0 to Length(val) - 1 do
             begin
                hash := hash + hash * 33 + longword(val[i]);
                hash := hash shr 5
             end;
             result := hash; 
          end;
      end;

      function ZLibConst_GetHashCodeForVal(val:TArrByte):longword;
      Var hash, i:longword;
      begin
          hash := $FFF;   
          if not Assigned(val) then 
             result := 1
          else begin
             for i := 0 to val.Length - 1 do
             begin
                hash := hash + hash * 33 + longword(val[i]);
                hash := hash shr 5;
             end;
             result := hash; 
          end;
      end;

      function ZLibConst_GetHashCodeForVal(val:TArrLongint):longword;
      Var hash, i:longword;
      begin
          hash := $FFF;   
          if (Length(val) = 0) then 
             result := 1
          else begin
             for i := 0 to Length(val) - 1 do
             begin
                hash := hash + hash * 33 + longword(val[i]);
                hash := hash shr 5;
             end;
             result := hash; 
          end;
      end;


procedure initArraySmallint(Var Arr:TArrSmallint; scr:array of smallint);
Var i:longint;
begin
  SetLength(Arr, length(scr));
  for i := 0 to length(scr) - 1 do
      arr[i] := scr[i];
end;

procedure initArrayWord(Var Arr:TArrWord; scr:array of word);
Var i:longint;
begin
  SetLength(Arr, length(scr));
  for i := 0 to length(scr) - 1 do
      arr[i] := scr[i];
end;

procedure initArrayLongint(Var Arr:TArrLongint; scr:array of longint);
Var i:longint;
begin
  SetLength(Arr, length(scr));
  for i := 0 to length(scr) - 1 do
      arr[i] := scr[i];
end;

{
procedure initArrayByte(Var Arr:TArrByte; scr:array of byte);
//Var i:longint;
begin
  SetLength(Arr, length(scr));
  for i := 0 to length(scr) - 1 do
      arr[i] := scr[i];
end;
}

initialization

   initArraySmallint(ZLibConst_static_ltree, 
         [     12,  8, 140,  8,  76,  8, 204,  8,  44,  8,
              172,  8, 108,  8, 236,  8,  28,  8, 156,  8,
               92,  8, 220,  8,  60,  8, 188,  8, 124,  8,
              252,  8,   2,  8, 130,  8,  66,  8, 194,  8,
               34,  8, 162,  8,  98,  8, 226,  8,  18,  8,
              146,  8,  82,  8, 210,  8,  50,  8, 178,  8,
              114,  8, 242,  8,  10,  8, 138,  8,  74,  8,
              202,  8,  42,  8, 170,  8, 106,  8, 234,  8,
               26,  8, 154,  8,  90,  8, 218,  8,  58,  8,
              186,  8, 122,  8, 250,  8,   6,  8, 134,  8,
               70,  8, 198,  8,  38,  8, 166,  8, 102,  8,
              230,  8,  22,  8, 150,  8,  86,  8, 214,  8,
               54,  8, 182,  8, 118,  8, 246,  8,  14,  8,
              142,  8,  78,  8, 206,  8,  46,  8, 174,  8,
              110,  8, 238,  8,  30,  8, 158,  8,  94,  8,
              222,  8,  62,  8, 190,  8, 126,  8, 254,  8,
                1,  8, 129,  8,  65,  8, 193,  8,  33,  8,
              161,  8,  97,  8, 225,  8,  17,  8, 145,  8,
               81,  8, 209,  8,  49,  8, 177,  8, 113,  8,
              241,  8,   9,  8, 137,  8,  73,  8, 201,  8,
               41,  8, 169,  8, 105,  8, 233,  8,  25,  8,
              153,  8,  89,  8, 217,  8,  57,  8, 185,  8,
              121,  8, 249,  8,   5,  8, 133,  8,  69,  8,
              197,  8,  37,  8, 165,  8, 101,  8, 229,  8,
               21,  8, 149,  8,  85,  8, 213,  8,  53,  8,
              181,  8, 117,  8, 245,  8,  13,  8, 141,  8,
               77,  8, 205,  8,  45,  8, 173,  8, 109,  8,
              237,  8,  29,  8, 157,  8,  93,  8, 221,  8,
               61,  8, 189,  8, 125,  8, 253,  8,  19,  9,
              275,  9, 147,  9, 403,  9,  83,  9, 339,  9,
              211,  9, 467,  9,  51,  9, 307,  9, 179,  9,
              435,  9, 115,  9, 371,  9, 243,  9, 499,  9,
               11,  9, 267,  9, 139,  9, 395,  9,  75,  9,
              331,  9, 203,  9, 459,  9,  43,  9, 299,  9,
              171,  9, 427,  9, 107,  9, 363,  9, 235,  9,
              491,  9,  27,  9, 283,  9, 155,  9, 411,  9,
               91,  9, 347,  9, 219,  9, 475,  9,  59,  9,
              315,  9, 187,  9, 443,  9, 123,  9, 379,  9,
              251,  9, 507,  9,   7,  9, 263,  9, 135,  9,
              391,  9,  71,  9, 327,  9, 199,  9, 455,  9,
               39,  9, 295,  9, 167,  9, 423,  9, 103,  9,
              359,  9, 231,  9, 487,  9,  23,  9, 279,  9,
              151,  9, 407,  9,  87,  9, 343,  9, 215,  9,
              471,  9,  55,  9, 311,  9, 183,  9, 439,  9,
              119,  9, 375,  9, 247,  9, 503,  9,  15,  9,
              271,  9, 143,  9, 399,  9,  79,  9, 335,  9,
              207,  9, 463,  9,  47,  9, 303,  9, 175,  9,
              431,  9, 111,  9, 367,  9, 239,  9, 495,  9,
               31,  9, 287,  9, 159,  9, 415,  9,  95,  9,
              351,  9, 223,  9, 479,  9,  63,  9, 319,  9,
              191,  9, 447,  9, 127,  9, 383,  9, 255,  9,
              511,  9,   0,  7,  64,  7,  32,  7,  96,  7,
               16,  7,  80,  7,  48,  7, 112,  7,   8,  7,
               72,  7,  40,  7, 104,  7,  24,  7,  88,  7,
               56,  7, 120,  7,   4,  7,  68,  7,  36,  7,
              100,  7,  20,  7,  84,  7,  52,  7, 116,  7,
                3,  8, 131,  8,  67,  8, 195,  8,  35,  8,
              163,  8,  99,  8, 227,  8
         ]);


         initArraySmallint(ZlibConst_static_dtree,
         [      0, 5, 16, 5,  8, 5, 24, 5,  4, 5,
               20, 5, 12, 5, 28, 5,  2, 5, 18, 5,
               10, 5, 26, 5,  6, 5, 22, 5, 14, 5,
               30, 5,  1, 5, 17, 5,  9, 5, 25, 5,
                5, 5, 21, 5, 13, 5, 29, 5,  3, 5,
               19, 5, 11, 5, 27, 5,  7, 5, 23, 5
         ]);



         initArrayLongint(ZlibConst_base_length,
         [
               0,  1,  2,  3, 4, 5, 6, 7, 8, 10, 
              12, 14, 16, 20, 24, 28, 32, 40, 48, 56,
              64, 80, 96, 112, 128, 160, 192, 224, 0
         ]);


         initArrayLongint(ZlibConst_base_dist,
         [   0,     1,     2,     3,     4,     6,     8,    12,    16,    24,
            32,    48,    64,    96,   128,   192,   256,   384,   512,   768,
          1024,  1536,  2048,  3072,  4096,  6144,  8192, 12288, 16384, 24576
         ]);



         ZlibConst_dist_code := TArrByte.Create(
         [ 
             0,  1,  2,  3,  4,  4,  5,  5,  6,  6,  6,  6,  7,  7,  7,  7,  8,  8,  8,  8,
             8,  8,  8,  8,  9,  9,  9,  9,  9,  9,  9,  9, 10, 10, 10, 10, 10, 10, 10, 10,
            10, 10, 10, 10, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
            11, 11, 11, 11, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12,
            12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 13, 13, 13, 13,
            13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13,
            13, 13, 13, 13, 13, 13, 13, 13, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
            14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
            14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
            14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 15, 15, 15, 15, 15, 15, 15, 15,
            15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15,
            15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15,
            15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15,  0,  0, 16, 17,
            18, 18, 19, 19, 20, 20, 20, 20, 21, 21, 21, 21, 22, 22, 22, 22, 22, 22, 22, 22,
            23, 23, 23, 23, 23, 23, 23, 23, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24,
            24, 24, 24, 24, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
            26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26,
            26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 27, 27, 27, 27, 27, 27, 27, 27,
            27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27,
            27, 27, 27, 27, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28,
            28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28,
            28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28,
            28, 28, 28, 28, 28, 28, 28, 28, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29,
            29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29,
            29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29,
            29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29
         ]);

         initArrayLongint(ZlibConst_length_code,
         [      0,  1,  2,  3,  4,  5,  6,  7,  8,  8,  9,  9, 10, 10, 11, 11, 12, 12, 12, 12,
               13, 13, 13, 13, 14, 14, 14, 14, 15, 15, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16,
               17, 17, 17, 17, 17, 17, 17, 17, 18, 18, 18, 18, 18, 18, 18, 18, 19, 19, 19, 19,
               19, 19, 19, 19, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20,
               21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 22, 22, 22, 22,
               22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 23, 23, 23, 23, 23, 23, 23, 23,
               23, 23, 23, 23, 23, 23, 23, 23, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24,
               24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24,
               25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
               25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 26, 26, 26, 26, 26, 26, 26, 26,
               26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26,
               26, 26, 26, 26, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27,
               27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 28
         ]);


         //* extra bits for each length code */
         initArrayLongint(ZlibConst_extra_lbits,
         [0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,0]);


         //* extra bits for each distance code */
         initArrayLongint(ZlibConst_extra_dbits,
         [0,0,0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13]);

         //* extra bits for each bit length code */
         initArrayLongint(ZlibConst_extra_blbits,
         [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,3,7]);


         initArrayLongint(ZlibConst_bl_order,
         [16,17,18,0,8,7,9,6,10,5,11,4,12,3,13,2,14,1,15]);
         //* The lengths of the bit length codes are sent in order of decreasing
         //* probability, to avoid transmitting the lengths for unused bit length codes.

   //init ZLibConst_configuration_table
   //*      good lazy nice chain */
   ZLibConst_configuration_table[0] := TConfig.Create(0,    0,  0,    0,  compress_func_deflate_stored); //* store only */
   ZLibConst_configuration_table[1] := TConfig.Create(4,    4,  8,    4,  compress_func_deflate_fast);   //* max speed, no lazy matches */
   ZLibConst_configuration_table[2] := TConfig.Create(4,    5, 16,    8,  compress_func_deflate_fast);
   ZLibConst_configuration_table[3] := TConfig.Create(4,    6, 32,   32,  compress_func_deflate_fast);
   ZLibConst_configuration_table[4] := TConfig.Create(4,    4, 16,   16,  compress_func_deflate_slow);   //* lazy matches */
   ZLibConst_configuration_table[5] := TConfig.Create(8,   16, 32,   32,  compress_func_deflate_slow);
   ZLibConst_configuration_table[6] := TConfig.Create(8,   16, 128, 128,  compress_func_deflate_slow);
   ZLibConst_configuration_table[7] := TConfig.Create(8,   32, 128, 256,  compress_func_deflate_slow);
   ZLibConst_configuration_table[8] := TConfig.Create(32, 128, 258, 1024, compress_func_deflate_slow);
   ZLibConst_configuration_table[9] := TConfig.Create(32, 258, 258, 4096, compress_func_deflate_slow);
   //* max compression */


finalization

ZlibConst_dist_code.Free;

ZLibConst_configuration_table[0].Free;
ZLibConst_configuration_table[1].Free;
ZLibConst_configuration_table[2].Free;
ZLibConst_configuration_table[3].Free;
ZLibConst_configuration_table[4].Free;
ZLibConst_configuration_table[5].Free;
ZLibConst_configuration_table[6].Free;
ZLibConst_configuration_table[7].Free;
ZLibConst_configuration_table[8].Free;
ZLibConst_configuration_table[9].Free;

end.


