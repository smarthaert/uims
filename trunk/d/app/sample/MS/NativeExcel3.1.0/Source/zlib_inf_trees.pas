//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         zlib_inf_trees
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

unit zlib_inf_trees;
{$Q-}
{$R-}


interface

uses zlib_deftype, zlib_const, zlib_code; 

const inflate_copyright:widestring =
             ' inflate 1.2.3 Copyright 1995-2005 Mark Adler ';

type
    TInfTrees = class  
    private

    public 
       function inflate_table
          (
               atype:codetype;
               lens_arr:TArrWord;
               lens_index,
               codes:longword;
               table_arr:TCodes;
               Var table_index:longword;
               Var bits:longword;
               work:TArrWord
          ):CompressionReturnCode;
    end;

Var       
   InfTrees:TInfTrees;

implementation

Var       
   lbase, //* Length codes 257..285 base */
   lext,  //* Length codes 257..285 extra */
   dbase, //* Distance codes 0..29 base */
   dext:TArrWord; //* Distance codes 0..29 extra */ 

       
          
          {/*
            If you use the zlib library in a product, an acknowledgment is welcome
            in the documentation of your product. If for some reason you cannot
            include such an acknowledgment, I would appreciate that you keep this
            copyright string in the executable of your product.
           */}

          {/*
             Build a set of tables to decode the provided canonical Huffman code.
             The code lengths are lens[0..codes-1].  The result starts at *table,
             whose indices are 0..2^bits-1.  work is a writable array of at least
             lens shorts, which is used as a work area.  type is the type of code
             to be generated, CODES, LENS, or DISTS.  On return, zero is success,
             -1 is an invalid code, and +1 means that ENOUGH isn't enough.  table
             on return points to the next available entry's address.  bits is the
             requested root table index bits, and on return it is the actual root
             table index bits.  It will differ if the request is greater than the
             longest code or if it is less than the shortest code.
           */}
function TInfTrees.inflate_table(atype:codetype;
                                 lens_arr:TArrWord;
                                 lens_index,
                                 codes:longword;
                                 table_arr:TCodes;
                                 Var table_index:longword;
                                 Var bits:longword;
                                 work:TArrWord):CompressionReturnCode;
Var
   len,               //* a code's length in bits */
   sym,               //* index of code symbols */
   min, max,          //* minimum and maximum code lengths */
   root,              //* number of index bits for root table */
   curr,              //* number of index bits for current table */
   drop:longword;              //* code bits to drop for sub-table */
   left:longint;                   //* number of prefix codes available */
   used,              //* code entries in table used */
   huff,              //* Huffman code */
   incr,              //* for incrementing code, index */
   fill,              //* index for replicating entries */
   low,               //* low bits for current root entry */
   mask:longword;              //* mask for low root bits */
   l_this:TCode;   //* table entry for duplication */
   next_index:longint;             //* next available space in table */
   l_base_arr:TArrWord;   //* base value table to use */
   l_base_off:longint;
   extra_arr:TArrWord;    //* extra bits table to use */
   extra_off:longint;
   lend:longint;                    //* use base and extra for symbol > end */
   count:TArrWord;  //* number of codes of each length */
   offs:TArrWord;  //* offsets in table for each length */
Begin
   l_this.FOp := 0;   //* table entry for duplication */
   l_this.FBits := 0;
   l_this.FVal := 0;
//   l_base_off := 0;
//   extra_off := 0;
   setLength(l_base_arr, 0);
   setLength(extra_arr, 0);
   setLength(count, ZLibConst_MAXBITS + 1);  //* number of codes of each length */
   setLength(offs, ZLibConst_MAXBITS + 1);  //* offsets in table for each length */

              {/*
                 Process a set of code lengths to create a canonical Huffman code.  The
                 code lengths are lens[0..codes-1].  Each length corresponds to the
                 symbols 0..codes-1.  The Huffman code is generated by first sorting the
                 symbols by length from short to long, and retaining the symbol order
                 for codes with equal lengths.  Then the code starts with all zero bits
                 for the first code of the shortest length, and the codes are integer
                 increments for the same length, and zeros are appended as the length
                 increases.  For the deflate format, these bits are stored backwards
                 from their more natural integer increment ordering, and so when the
                 decoding tables are built in the large loop below, the integer codes
                 are incremented backwards.

                 This routine assumes, but does not check, that all of the entries in
                 lens[] are in the range 0..MAXBITS.  The caller must assure this.
                 1..MAXBITS is interpreted as that code length.  zero means that that
                 symbol does not occur in this code.

                 The codes are sorted by computing a count of codes for each length,
                 creating from that a table of starting indices for each length in the
                 sorted table, and then entering the symbols in order in the sorted
                 table.  The sorted table is work[], with that space being provided by
                 the caller.

                 The length counts are used for other purposes as well, i.e. finding
                 the minimum and maximum length codes, determining if there are any
                 codes at all, checking for a valid set of lengths, and looking ahead
                 at length counts to determine sub-table sizes when building the
                 decoding tables.
               */}

   //* accumulate lengths for codes (assumes lens[] all in 0..MAXBITS) */
   for len := 0 to ZLibConst_MAXBITS do
      count[len] := 0;
   for sym := 0 to codes - 1 do
      inc(count[lens_arr[lens_index + sym]]);

   //* bound code lengths, force root to be within code lengths */
   root := bits;
   for max := ZLibConst_MAXBITS downto 1 do
       if (count[max] <> 0) then break;
   if (root > max) then root := max;

      if (max = 0) then begin                     //* no symbols to code at all */
         l_this.FOp   := 64;    //* invalid code marker */
         l_this.FBits := 1;
         l_this.FVal  := 0;
         table_arr.setCode(table_index, l_this); //* make a table to force an error */
         inc(table_index);
         table_arr.setCode(table_index, l_this);
         inc(table_index);
         bits := 1;
         result := CompressionReturnCode_Z_OK;  //* no symbols, but wait for decoding to report error */
         exit;
      end;

      for min := 1 to ZLibConst_MAXBITS do
          if (count[min] <> 0) then break;
      if (root < min) then root := min;

      //* check for an over-subscribed or incomplete set of lengths */
      left := 1;
      for len := 1 to ZLibConst_MAXBITS do begin
         left := left shl 1;
         left := left - count[len];
         if (left < 0) then break;        //* over-subscribed */
      end;
      if (left < 0) then begin
         result := CompressionReturnCode_Z_ERRNO;        //* over-subscribed */
         exit;
      end;

      if (left > 0) and ((atype = codetype_CODES) or (max <> 1)) then begin
         result := CompressionReturnCode_Z_ERRNO;  //* incomplete set */
         exit;
      end;
      //* generate offsets into symbol table for each length for sorting */
      offs[1] := 0;
      for len := 1 to ZLibConst_MAXBITS - 1 do
         offs[len + 1] := word(offs[len] + count[len]);

      //* sort symbols by length, by symbol order within each length */
      for sym := 0 to codes - 1 do
         if (lens_arr[lens_index + sym] <> 0) then begin
            work[offs[lens_arr[lens_index + sym]]] := word(sym);
            inc(offs[lens_arr[lens_index + sym]]);
         end;

              {/*
                 Create and fill in decoding tables.  In this loop, the table being
                 filled is at next and has curr index bits.  The code being used is huff
                 with length len.  That code is converted to an index by dropping drop
                 bits off of the bottom.  For codes where len is less than drop + curr,
                 those top drop + curr - len bits are incremented through all values to
                 fill the table with replicated entries.

                 root is the number of index bits for the root table.  When len exceeds
                 root, sub-tables are created pointed to by the root entry with an index
                 of the low root bits of huff.  This is saved in low to check for when a
                 new sub-table should be started.  drop is zero when the root table is
                 being filled, and drop is root when sub-tables are being filled.

                 When a new sub-table is needed, it is necessary to look ahead in the
                 code lengths to determine what size sub-table is needed.  The length
                 counts are used for this, and so count[] is decremented as codes are
                 entered in the tables.

                 used keeps track of how many table entries have been allocated from the
                 provided *table space.  It is checked when a LENS table is being made
                 against the space in *table, ENOUGH, minus the maximum space needed by
                 the worst case distance code, MAXD.  This should never happen, but the
                 sufficiency of ENOUGH has not been proven exhaustively, hence the check.
                 This assumes that when type := LENS, bits := 9.

                 sym increments through all symbols, and the loop terminates when
                 all codes of length max, i.e. all codes, have been processed.  This
                 routine permits incomplete codes, so another loop after this one fills
                 in the rest of the decoding tables with invalid code markers.
               */}

      //* set up for code type */
      case (atype) of
         codetype_CODES: begin
             l_base_arr := work;    //* dummy value--not used */
             l_base_off := 0;
             extra_arr := work;    
             extra_off := 0; 
             lend := 19;
         end;
         codetype_LENS: begin
             l_base_arr := lbase;
             l_base_off := -257;
             extra_arr := lext;
             extra_off := -257;  
             lend := 256;
             end;
      else  begin          //* DISTS */
         l_base_arr := dbase;
         l_base_off := 0;
         extra_arr := dext;
         extra_off := 0;
         lend := -1;
         end;
      end;

      //* initialize state for loop */
      huff := 0;                   //* starting code */
      sym := 0;                    //* starting code symbol */
      len := min;                  //* starting code length */
      next_index := longint(table_index);   //* current table to fill in */
      curr := root;                //* current table index bits */
      drop := 0;                   //* current bits to drop from code for index */
      low := 0; 
      dec(low);      //* trigger new sub-table when len > root */
      used := longword(1) shl longint(root);          //* use root table entries */
      mask := used - 1;            //* mask for comparing low */

      //* check available table space */
      if (atype = codetype_LENS) and (used >= ZLibConst_ENOUGH - ZLibConst_MAXD) then begin
         result := CompressionReturnCode_Z_STREAM_END;
         exit;
      end;
      //* process all codes and make table entries */
      repeat
         //* create table entry */
         l_this.FBits := byte(len - drop);
         if (longint(work[sym]) < lend) then begin
            l_this.FOp := 0;
            l_this.FVal := work[sym];
         end
         else if (longint(work[sym]) > lend) then begin
            l_this.FOp := byte(extra_arr[extra_off + work[sym]]);
            l_this.FVal := l_base_arr[l_base_off + work[sym]];
         end
         else begin
            l_this.FOp := 32 + 64;         //* end of block */
            l_this.FVal := 0;
         end;

         //* replicate for those indices with low len bits equal to huff */
         incr := longword(1) shl longint(len - drop);
         fill := longword(1) shl longint(curr);
         min := fill;                 //* save offset to next table */
         repeat
            fill := fill - incr;
            table_arr.setCode(longword(next_index) + (huff shr drop) + fill, l_this);
         until (fill = 0);

         //* backwards increment the len-bit code huff */
         incr := longword(1) shl longint(len - 1);
         while ((huff and incr) > 0) do
            incr := incr shr 1;
         if (incr <> 0) then begin
            huff := huff and (incr - 1); 
            huff := huff + incr;
         end
         else
            huff := 0;

         //* go to next symbol, update count, len */
         inc(sym);
         dec(count[len]);
         if (count[len] = 0) then begin
            if (len = max) then break;
            len := lens_arr[lens_index + work[sym]];
         end;

         //* create new sub-table if needed */
         if (len > root) and ((huff and mask) <> low) then begin
            //* if first time, transition to sub-tables */
            if (drop = 0) then drop := root;

            //* increment past last table */
            next_index := next_index + longint(min);            //* here min is 1 shl curr */

            //* determine length of next table */
            curr := len - drop;
            left := longint(1 shl longint(curr));
            while ((curr + drop) < max) do begin
               left := left - count[curr + drop];
               if (left <= 0) then break;
               inc(curr);
               left := left shl 1;
            end;

            //* check for enough space */
            used := used + (1 shl longint(curr)); 
            if (atype = codetype_LENS) and (used >= ZLibConst_ENOUGH - ZLibConst_MAXD) then begin
               result := CompressionReturnCode_Z_STREAM_END;
               exit;
            end;

            //* point entry in root table to sub-table */
            low := huff and mask;
            table_arr.setCode(table_index + low, 
                              byte(curr), byte(root), word(next_index - longint(table_index)));
         end;
      until false;

      {/*
        Fill in rest of table for incomplete codes.  This loop is similar to the
        loop above in incrementing huff for table indices.  It is assumed that
        len is equal to curr + drop, so there is no loop needed to increment
        through high index bits.  When the current sub-table is filled, the loop
        drops back to the root table to fill in any remaining entries there.
      */}
      l_this.FOp := 64;                //* invalid code marker */
      l_this.FBits := byte(len - drop);
      l_this.FVal := 0;
      while (huff <> 0) do begin
         //* when done with sub-table, drop back to root table */
         if (drop <> 0) and ((huff and mask) <> low) then begin
            drop := 0;
            len := root;
            next_index := longint(table_index);
            l_this.FBits := byte(len);
         end;
         //* put invalid code marker in table */
         table_arr.setCode(longword(next_index) + (huff shr drop), l_this);

         //* backwards increment the len-bit code huff */
         incr := longword(1) shl longint(len - 1);
         while ((huff and incr) > 0) do
            incr := incr shr 1;
         if (incr <> 0) then begin
            huff := huff and (incr - 1); 
            huff := huff + incr;
         end
         else
            huff := 0;
      end;

      //* set return parameters */
      table_index := table_index + used;
      bits := root;

      result := CompressionReturnCode_Z_OK;
end; 

initialization 

InfTrees := TInfTrees.Create;

initArrayWord(lbase,
              [3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31,
              35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258, 0, 0]
              );

initArrayWord(lext,
              [16, 16, 16, 16, 16, 16, 16, 16, 17, 17, 17, 17, 18, 18, 18, 18,
              19, 19, 19, 19, 20, 20, 20, 20, 21, 21, 21, 21, 16, 201, 196]
              );

initArrayWord(dbase,
              [1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193,
              257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145,
              8193, 12289, 16385, 24577, 0, 0]
              );

initArrayWord(dext,
              [16, 16, 16, 16, 17, 17, 18, 18, 19, 19, 20, 20, 21, 21, 22, 22,
              23, 23, 24, 24, 25, 25, 26, 26, 27, 27,
              28, 28, 29, 29, 64, 64]
              );

finalization

InfTrees.Free;
 
end.
