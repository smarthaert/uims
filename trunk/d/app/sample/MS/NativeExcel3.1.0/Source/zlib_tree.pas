//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         zlib_tree
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

unit zlib_tree;
{$Q-}
{$R-}

interface
{$I xlsdef.inc}

uses zlib_deftype, zlib_const, zlib_pendingbuf, zlib_tree_desc, 
     zlib_static_tree, sysutils;

type

   TTree = class
   private
      FDyn_ltree:TArrSmallint; //* literal and length tree */     
      FDyn_dtree:TArrSmallint; //* distance tree */               
      FBl_tree:TArrSmallint;   //* Huffman tree for bit lengths */
      FL_desc:TTree_desc;             //* desc. for literal tree */   
      FD_desc:TTree_desc;   //* desc. for distance tree */  
      FBl_desc:TTree_desc;  //* desc. for bit length tree */
      FBl_count:TArrSmallint; //* number of codes at each bit length for an optimal tree */
      FLast_lit:longword;      //* running index in l_buf */
      FHeap:TArrLongint;        //* FHeap used to build the Huffman trees */
      FHeap_len:longint;        //* number of elements in the FHeap */
      FHeap_max:longint;        //* element of largest frequency */
         //* The sons of FHeap[n] are FHeap[2*n] and FHeap[2*n+1]. FHeap[0] is not used.
         //* The same FHeap array is used to build all trees.
         

      FDepth:TArrByte;
         //* Depth of each subtree used as tie breaker for trees of equal frequency

      FOpt_len:longword;  //ulong     //* bit length of current block with optimal trees */
      FStatic_len:longword; //ulong   //* bit length of current block with static trees */
      FMatches:longword;       //* number of string FMatches in current block */
      FLast_eob_len:longint;  //* bit length of EOB code for last block */

      FBi_buf:smallint; 
         //* Output buffer. bits are inserted starting at the bottom (least significant bits).
      FBi_valid:longint;
         //* Number of valid bits in FBi_buf.  All bits above the last valid bit
         //* are always zero.
       

      //*for debug*/
      //compressed_len:longword; //ulong //* total bit length of compressed file mod 2^32 */
      //bits_sent:longword;      //ulong //* bit length of compressed data sent mod 2^32 */
      FPending_buf:TPendingBuf; 
 
      procedure tr_init();
      procedure init_block(); 
      procedure send_code(c:longint; tree:TArrSmallint);
      procedure send_bits(value, length:longint); 
      procedure copy_block(buf:TArrByte; buf_offset:longint; len:longword; header:boolean);
      procedure build_tree(desc:TTree_desc);
      procedure pqdownheap(tree:TArrSmallint; k:longint);
      function  smaller(tree:TArrSmallint; n, m:longint; adepth:TArrByte):boolean;
      procedure bi_windup();
      procedure send_tree(tree:TArrSmallInt; max_code:longint);
      procedure bi_flush();
      procedure send_all_trees(lcodes, dcodes, blcodes:longint);
      function  d_code(dist:longword):longword;
      procedure compress_block(ltree, dtree:TArrSmallint); 
      procedure gen_bitlen(desc:TTree_desc);
      procedure gen_codes (tree:TArrSmallint; max_code:longint; FBl_count:TArrSmallint);
      function  bi_reverse(code, len:longint):longword;
      function  build_bl_tree():longint;
      procedure scan_tree (tree:TArrSmallint; max_code:longint);

   public
      constructor Create(Apending_buf:TPendingBuf); 
      destructor Destroy;override;

      procedure _tr_align();
      procedure _tr_stored_block(buf:TArrByte; buf_offset:longint; stored_len:longword; eof:boolean);
      function  _tr_tally(dist, lc:longword):boolean;
      function  get_data_type():DataType;
      function  GetHashCode():longint; {$ifdef D2009}override;{$endif}
      procedure _tr_flush_block (buf:TArrByte; buf_offset:longint; stored_len:longword; 
                                eof:boolean; level:longint; strategy:CompressionStrategy); 
      function  ToString(): string; {$ifdef D2009}override;{$endif}
   end;

implementation

Const  SMALLEST:longint = 1;

constructor TTree.Create(Apending_buf:TPendingBuf); 
begin
   FL_desc  := TTree_desc.Create();
   FD_desc  := TTree_desc.Create();
   FBl_desc := TTree_desc.Create();

   setLength(FDyn_ltree, 2 * (ZLibConst_HEAP_SIZE));        //* literal and length tree */     
   setLength(FDyn_dtree, 2 * (2 * ZLibConst_D_CODES + 1));  //* distance tree */               
   setLength(FBl_tree, 2 * (2 * ZLibConst_BL_CODES + 1)); //* Huffman tree for bit lengths */

   setLength(FBl_count, ZLibConst_MAX_BITS + 1);

   setLength(FHeap, ZLibConst_HEAP_SIZE);
   FDepth := TArrByte.Create(ZLibConst_HEAP_SIZE);

   self.FPending_buf := Apending_buf;

   tr_init();
end; 

destructor TTree.Destroy;
begin
   FDepth.Free;
   FL_desc.Free;
   FD_desc.Free;
   FBl_desc.Free;

   inherited Destroy;
end;


procedure TTree.tr_init();
begin
   FL_desc.FDyn_tree  := FDyn_ltree;
   FL_desc.FStat_desc := StaticTree.FStatic_l_desc;

   FD_desc.FDyn_tree  := FDyn_dtree;
   FD_desc.FStat_desc := StaticTree.FStatic_d_desc;

   FBl_desc.FDyn_tree := FBl_tree;
   FBl_desc.FStat_desc := StaticTree.FStatic_bl_desc;

   FBi_buf := 0;
   FBi_valid := 0;
   FLast_eob_len := 8; //* enough lookahead for inflate */

   //* Initialize the first block of the first file: */
   init_block();
end;

procedure TTree.init_block(); 
Var  n:longint; //* iterates over tree elements */
begin

   //* Initialize the trees. */
   for n := 0 to ZLibConst_L_CODES - 1 do FDyn_ltree[n * 2] := 0;
   for n := 0 to ZLibConst_D_CODES - 1 do FDyn_dtree[n * 2] := 0;
   for n := 0 to ZLibConst_BL_CODES - 1 do FBl_tree[n * 2]  := 0;

   FDyn_ltree[ZLibConst_END_BLOCK * 2] := 1;
   FOpt_len := 0;
   FStatic_len := 0;
   FLast_lit := 0;
   FMatches := 0;
end;


procedure TTree.send_code(c:longint; tree:TArrSmallint);
begin
   send_bits(tree[c * 2] and $FFFF, tree[c * 2 + 1] and $FFFF);
end;


procedure TTree.send_bits(value, length:longint); 
Var len, val:longint;
begin
   len := length;
   if (FBi_valid > (ZLibConst_Buf_size - len)) then begin
      val := value;
      FBi_buf := smallint(word(FBi_buf) or word(val shl FBi_valid)); 
      FPending_buf.put_short(word(FBi_buf));
      FBi_buf := smallint(longword(val) shr (ZLibConst_Buf_size - FBi_valid));
      FBi_valid := FBi_valid + (len - ZLibConst_Buf_size); 
   end
   else begin
      FBi_buf := smallint(word(FBi_buf) or word(value shl FBi_valid));
      FBi_valid := FBi_valid + len;
   end; 
end;

{/* ===========================================================================
* Send one empty static block to give enough lookahead for inflate.
* This takes 10 bits, of which 7 may remain in the bit buffer.
* The current inflate code requires 9 bits of lookahead. If the
* last two codes for the previous block (real code plus EOB) were coded
* on 5 bits or less, inflate may have only 5+3 bits of lookahead to decode
* the last real code. In this case we send two empty static blocks instead
* of one. (There are no problems if the previous block is stored or fixed.)
* To simplify the code, we assume the worst case of last real code encoded
* on one bit only.
*/}
procedure TTree._tr_align();
begin
   send_bits(ZLibConst_STATIC_TREES shl 1, 3);
   send_code(ZLibConst_END_BLOCK, ZLibConst_static_ltree);

   bi_flush();
   {/* Of the 10 bits for the empty block, we have already sent
     * (10 - FBi_valid) bits. The lookahead for the last real code (before
     * the EOB of the previous block) was thus at least one plus the length
     * of the EOB plus what we have just sent of the empty static block.
     */}
   if (1 + FLast_eob_len + 10 - FBi_valid) < 9 then begin
      send_bits(ZLibConst_STATIC_TREES shl 1, 3);
      send_code(ZLibConst_END_BLOCK, ZLibConst_static_ltree);

      bi_flush();
   end;
   FLast_eob_len := 7;
end;   


//* ===========================================================================
//* Send a stored block
//* ===========================================================================
procedure TTree._tr_stored_block(
              buf:TArrByte;        //* input block */
              buf_offset:longint;    //* input block offset */
              stored_len:longword;  //* length of input block */
              eof:boolean);          //* true if this is the last block for a file */
Var p:longint;
begin
   if eof then p := 1 else p := 0;
   send_bits((ZLibConst_STORED_BLOCK shl 1) + p, 3);  //* send block type */
   copy_block(buf, buf_offset, stored_len, true);     //* with header */
end;

//* ===========================================================================
//* Copy a stored block, storing first the length and its
//* one's complement if requested.
//* ===========================================================================
procedure TTree.copy_block(
              buf:TArrByte;        //* input data */
              buf_offset:longint;    //* input data offset */
              len:longword;         //* its length */
              header:boolean);      //* true if block header must be written */
begin
   bi_windup();       //* align on byte boundary */
   FLast_eob_len := 8; //* enough lookahead for inflate */

   if (header) then begin
      FPending_buf.put_short(word(len));
      FPending_buf.put_short(word(not(len)));
   end;

   FPending_buf.put_bytes(buf, buf_offset, longint(len));
end;

{/* ===========================================================================
  * Construct one Huffman tree and assigns the code bit strings and lengths.
  * Update the total bit length for the current block.
  * IN assertion: the field freq is set for all tree elements.
  * OUT assertions: the fields len and code are set to the optimal bit length
  *     and corresponding code. The length FOpt_len is updated; FStatic_len is
  *     also updated if stree is not null. The field max_code is set.
  */}
procedure TTree.build_tree(desc:TTree_desc);
Var tree, stree:TArrSmallint;
   elems, 
   n, m, //* iterate over FHeap elements */
   max_code, //* largest code with non zero frequency */
   node:longint; //* new node being created */
begin
   tree     := desc.FDyn_tree;
   stree    := desc.FStat_desc.FStatic_tree;
   elems    := desc.FStat_desc.FElems;
   max_code := -1; 

   //* Construct the initial FHeap, with least frequent element in
   //* FHeap[SMALLEST]. The sons of FHeap[n] are FHeap[2*n] and FHeap[2*n+1].
   //* FHeap[0] is not used.
   FHeap_len := 0;
   FHeap_max := ZLibConst_HEAP_SIZE;

   for n := 0 to elems - 1 do begin
      if (tree[n * 2] <> 0) then begin
         FHeap_len := FHeap_len + 1;
         FHeap[FHeap_len] := n;
         max_code := n;
         FDepth[n] := 0;
      end
      else 
         tree[n * 2 + 1] := 0;
   end;


   //* The pkzip format requires that at least one distance code exists,
   //* and that at least one bit should be sent even if there is only one
   //* possible code. So to avoid special checks later on we force at least
   //* two codes of non zero frequency.
   while (FHeap_len < 2) do begin
      if max_code < 2 then begin
         max_code := max_code + 1;
         node := max_code;
         FHeap_len := FHeap_len + 1;
         FHeap[FHeap_len] := max_code;
      end
      else begin
         node := 0;
         FHeap_len := FHeap_len + 1;
         FHeap[FHeap_len] := 0;
      end;
      tree[node * 2] := 1;
      FDepth[node] := 0;
      FOpt_len := FOpt_len - 1; 
      if (Length(stree) <> 0) then 
         FStatic_len := FStatic_len - longword(stree[node * 2 + 1]);
      //* node is 0 or 1 so it does not have extra bits */
   end;

   desc.FMax_code := max_code;

   //* The elements FHeap[FHeap_len/2+1 .. FHeap_len] are leaves of the tree,
   //* establish sub-heaps of increasing lengths:
   for n := trunc(FHeap_len/2) downto 1 do 
      pqdownheap(tree, n);

   //* Construct the Huffman tree by repeatedly combining the least two
   //* frequent nodes.
   node := elems;              //* next internal node of the tree */
   repeat
      //* n := node of least frequency */
      n := FHeap[SMALLEST];
      FHeap[SMALLEST] := FHeap[FHeap_len]; 
      FHeap_len := FHeap_len - 1;
      pqdownheap(tree, SMALLEST); 

      m := FHeap[SMALLEST];    //* m := node of next least frequency */

      FHeap_max := FHeap_max - 1;
      FHeap[FHeap_max] := n; //* keep the nodes sorted by frequency */
      FHeap_max := FHeap_max - 1;
      FHeap[FHeap_max] := m;

      //* Create a new node father of n and m */
      tree[node * 2] := smallint(tree[n * 2] + tree[m * 2]);
      if FDepth[n] >= FDepth[m] then
         FDepth[node] := byte(FDepth[n] + 1)
      else
         FDepth[node] := byte(FDepth[m] + 1);
      tree[n * 2 + 1] := smallint(node);
      tree[m * 2 + 1] := smallint(node);

      //* and insert the new node in the FHeap */
      FHeap[SMALLEST] := node;
      node := node + 1;
      pqdownheap(tree, SMALLEST);

   until not (FHeap_len >= 2); 

   FHeap_max := FHeap_max - 1;
   FHeap[FHeap_max] := FHeap[SMALLEST];

   //* At this point, the fields freq and dad are set. We can now
   //* generate the bit lengths.
   gen_bitlen(desc);

   //* The field len is now set, we can generate the bit codes */
   gen_codes (tree, max_code, FBl_count);
end;


{/* ===========================================================================
  * Restore the FHeap property by moving down the tree starting at node k,
  * exchanging a node with the smallest of its two sons if necessary, stopping
  * when the FHeap property is re-established (each father smaller than its
  * two sons).
  */}
procedure TTree.pqdownheap(tree:TArrSmallint;  //* the tree to restore */
                           k:longint);         //* node to move down */
Var v, j:longint;
begin
   v := FHeap[k];
   j := k shl 1;  //* left son of k */
   while (j <= FHeap_len) do begin
      //* Set j to the smallest of the two sons: */
      if ((j < FHeap_len) and smaller(tree, FHeap[j + 1], FHeap[j], FDepth)) then
         inc(j);
      //* Exit if v is smaller than both sons */
      if (smaller(tree, v, FHeap[j], FDepth)) then break;

      //* Exchange v with the smallest son */
      FHeap[k] := FHeap[j];  
      k := j;

      //* And continue down the tree, setting j to the left son of k */
      j := j shl 1;
   end;
   FHeap[k] := v;
end; 

//* ===========================================================================
//* Compares to subtrees, using the tree FDepth as tie breaker when
//* the subtrees have equal frequency. This minimizes the worst case length.
function TTree.smaller(tree:TArrSmallint; n, m:longint; adepth:TArrByte):boolean;
begin
  result := (tree[n * 2] < tree[m * 2]) or 
            ((tree[n * 2] = tree[m * 2]) and (adepth[n] <= adepth[m]));
end; 


{/* ===========================================================================
  * Generate the codes for a given tree and bit counts (which need not be
  * optimal).
  * IN assertion: the array FBl_count contains the bit length statistics for
  * the given tree and the field len is set for all tree elements.
  * OUT assertion: the field code is set for all tree elements of non
  *     zero code length.
  */}
procedure TTree.gen_codes (
              tree:TArrSmallint;             //* the tree to decorate */
              max_code:longint;              //* largest code with non zero frequency */
              FBl_count:TArrSmallint);        //* number of codes at each bit length */
Var next_code:TArrSmallint;
    len,
    bits,                     //* bit index */
    n:longint;                //* code index */
    code:smallint;
begin
   //* next code value for each bit length */ 
   setLength(next_code, ZLibConst_MAX_BITS + 1); 
   code := 0;           //* running code value */

   //* The distribution counts are first used to generate the code values
   //* without bit reversal.
   for bits := 1 to ZLibConst_MAX_BITS do begin
       next_code[bits] := smallint((code + FBl_count[bits - 1]) shl 1);
       code := smallint((code + FBl_count[bits - 1]) shl 1);
   end;
   //* Check that the bit counts in FBl_count are consistent. The last code
   //* must be all ones.
   for n := 0 to max_code do begin
      len := tree[n * 2 + 1];
      if (len = 0) then continue;
      //* Now reverse the bits */
      tree[n * 2] := smallint(bi_reverse(next_code[len], len));
      inc(next_code[len]); 
   end;
end;


//* ===========================================================================
//* Reverse the first len bits of a code, using straightforward code (a faster
//* method would use a table)
//* IN assertion: 1 <= len <= 15
//* ===========================================================================
function TTree.bi_reverse(
             code, //* the value to invert */
             len:longint):longword;  //* its bit length */
Var l_code, res:longword;
begin
   l_code := longword(code);
   res := 0;
   repeat
      res := res or (l_code and 1);
      l_code := l_code shr 1;
      res := res shl 1;
      dec(len);
   until (len <= 0);

   result := res shr 1;
end;


{* ===========================================================================
 * Compute the optimal bit lengths for a tree and update the total bit length
 * for the current block.
 * IN assertion: the fields freq and dad are set, FHeap[FHeap_max] and
 *    above are the tree nodes sorted by increasing frequency.
 * OUT assertions: the field len is set to the optimal bit length, the
 *     array FBl_count contains the frequencies for each bit length.
 *     The length FOpt_len is updated; FStatic_len is also updated if stree is
 *     not null.
 *}
procedure TTree.gen_bitlen(desc:TTree_desc);
Var 
   tree:TArrSmallint;
   max_code:longint;
   stree:TArrSmallint;
   extra:TArrLongint;
   extra_base,
   max_length,
   h,              //* FHeap index */
   n, m,           //* iterate over the tree elements */
   bits,           //* bit length */
   xbits,          //* extra bits */
   overflow:longint;   //* number of elements with bit length too large */
   f:smallint;            //* frequency */
begin
   tree        := desc.FDyn_tree;
   max_code    := desc.FMax_code;
   stree       := desc.FStat_desc.FStatic_tree;
   extra       := desc.FStat_desc.FExtra_bits;
   extra_base  := desc.FStat_desc.FExtra_base;
   max_length  := desc.FStat_desc.FMax_length;
   overflow    := 0;   

   for bits := 0 to ZLibConst_MAX_BITS do
       FBl_count[bits] := 0;

   //* In a first pass, compute the optimal bit lengths (which may
   //* overflow in the case of the bit length tree).
   tree[FHeap[FHeap_max] * 2 + 1] := 0; //* root of the FHeap */

   for h := FHeap_max + 1 to ZLibConst_HEAP_SIZE - 1 do begin
      n := FHeap[h];
      bits := tree[tree[n * 2 + 1] * 2 + 1] + 1;
      if (bits > max_length) then begin
         bits := max_length;
         inc(overflow);
      end;
      tree[n * 2 + 1] := smallint(bits);
      //* We overwrite tree[n].Dad which is no longer needed */

      if (n > max_code) then continue; //* not a leaf node */

      inc(FBl_count[bits]);
      xbits := 0;
      if (n >= extra_base) then xbits := extra[n - extra_base];
      f := tree[n * 2];
      FOpt_len := FOpt_len + longword(f * (bits + xbits));
      if (length(stree) > 0) then 
         FStatic_len := FStatic_len + longword(f * (stree[n * 2 + 1] + xbits)); //ulong
   end;
   //
   h := ZLibConst_HEAP_SIZE;

   if (overflow = 0) then 
   else begin
              //* Find the first bit length which could increase: */
      repeat
         bits := max_length - 1;
         while (FBl_count[bits] = 0) do dec(bits);
         dec(FBl_count[bits]);         //* move one leaf down the tree */
         inc(FBl_count[bits + 1], 2);  //* move one overflow item as its brother */
         dec(FBl_count[max_length]);
         //* The brother of the overflow item also moves one step up,
         //* but this does not affect FBl_count[max_length]
         dec(overflow, 2);
      until (overflow <= 0);

//* Now recompute all bit lengths, scanning in increasing frequency.
//* h is still equal to HEAP_SIZE. (It is simpler to reconstruct all
//* lengths instead of fixing only the wrong ones. This idea is taken
//* from 'ar' written by Haruhiko Okumura.)
      for bits := max_length downto 1 do begin
         n := FBl_count[bits];
         while (n <> 0) do begin
           dec(h);
           m := FHeap[h];
           if (m > max_code) then continue;
           if (longword(tree[m * 2 + 1]) <> longword(bits)) then begin
              FOpt_len := longword(int64(FOpt_len) +
                                 (int64(bits) - int64(tree[m * 2 + 1])) *
                                      int64(tree[m * 2])); //ulong
              tree[m * 2 + 1] := smallint(bits);
           end;
           dec(n);
         end;
      end;
   end;
end;


function TTree.build_bl_tree():longint;
Var max_blindex:longint;  //* index of last bit length code of non zero freq */
begin

   //* Determine the bit length frequencies for literal and distance trees */
   scan_tree(FDyn_ltree, FL_desc.FMax_code);
   scan_tree(FDyn_dtree, FD_desc.FMax_code);

   //* Build the bit length tree: */
   build_tree(FBl_desc);
   //* FOpt_len now includes the length of the tree representations, except
   //* the lengths of the bit lengths codes and the 5+5+4 bits for the counts.

   //* Determine the number of bit length codes to send. The pkzip format
   //* requires that at least 4 bit length codes be sent. (appnote.txt says
   //* 3 but the actual value used is 4.)
   for max_blindex := ZLibConst_BL_CODES - 1 downto 3 do 
       if (FBl_tree[ZLibConst_bl_order[max_blindex] * 2 + 1] <> 0) then break;
   
//* Update FOpt_len to include the bit length tree and counts */
   FOpt_len := FOpt_len + longword(3 * (max_blindex + 1) + 5 + 5 + 4); //ulong

   result := max_blindex;
end;


//* ===========================================================================
//* Scan a literal or distance tree to determine the frequencies of the codes
//* in the bit length tree.
//* ===========================================================================
procedure TTree.scan_tree (
              tree:TArrSmallint;   //* the tree to be scanned */
              max_code:longint);   //* and its largest code of non zero frequency */
Var
   n,                 //* iterates over all tree elements */
   prevlen,           //* last emitted length */
   curlen,            //* length of current code */
   nextlen,           //* length of next code */
   count,             //* repeat count of the current code */
   max_count,         //* max repeat count */
   min_count:longint; //* min repeat count */
begin
   prevlen := -1;          
   nextlen := tree[0 * 2 + 1]; 
   count := 0;             
   max_count := 7;         
   min_count := 4;         

   if (nextlen = 0) then begin
      max_count := 138;
      min_count := 3;
   end;

   tree[(max_code + 1) * 2 + 1] := -1; //$ffff; //* guard */

   for n := 0 to max_code do begin
      curlen := nextlen; 
      nextlen := tree[(n + 1) * 2 + 1];
      inc(count);
      if (count < max_count) and (curlen = nextlen) then begin
         continue;
      end 
      else if (count < min_count) then begin
         FBl_tree[curlen * 2] := smallint(FBl_tree[curlen * 2] + count);
      end
      else if (curlen <> 0) then begin
         if (curlen <> prevlen) then inc(FBl_tree[curlen * 2]);
         inc(FBl_tree[ZLibConst_REP_3_6 * 2]);
      end
      else if (count <= 10) then begin
         inc(FBl_tree[ZLibConst_REPZ_3_10 * 2]);
      end
      else begin
         inc(FBl_tree[ZLibConst_REPZ_11_138 * 2]);
      end;
      count := 0; 
      prevlen := curlen;
      if (nextlen = 0) then begin
         max_count := 138; 
         min_count := 3;
      end
      else if (curlen = nextlen) then begin
         max_count := 6; 
         min_count := 3;
      end
      else begin
         max_count := 7; 
         min_count := 4;
      end;
   end;
end;

//* ===========================================================================
//* Determine the best encoding for the current block: dynamic trees, static
//* trees or store, and output the encoded block to the zip file.
//* ===========================================================================
procedure TTree._tr_flush_block (
              buf:TArrByte;        //* input block, or NULL if too old */
              buf_offset:longint;    //* input block offset */
              stored_len:longword; //ulong  //* length of input block */
              eof:boolean;          //* true if this is the last block for a file */
              level:longint;         //*compression level*/ 
              strategy:CompressionStrategy); //*compression strategy*/        
Var 
   opt_lenb, static_lenb:longword; //ulong  //* FOpt_len and FStatic_len in bytes */
   max_blindex:longint;
begin
   max_blindex := 0;  //* index of last bit length code of non zero freq */
   //* Build the Huffman trees unless a stored block is forced */
   if (level > 0) then begin
      //* Construct the literal and distance trees */
      build_tree(FL_desc);
      build_tree(FD_desc);

      //* At this point, FOpt_len and FStatic_len are the total bit lengths of
      //* the compressed block data, excluding the tree representations.

      //* Build the bit length tree for the above two trees, and get the index
      //* in bl_order of the last bit length code to send.
      max_blindex := build_bl_tree();

      //* Determine the best encoding. Compute the block lengths in bytes. */
      opt_lenb := (FOpt_len + 3 + 7) shr 3;
      static_lenb := (FStatic_len + 3 + 7) shr 3;

      if (static_lenb <= opt_lenb) then opt_lenb := static_lenb;
   end
   else begin
      opt_lenb := stored_len + 5;
      static_lenb := stored_len + 5; //* force a stored block */
   end;

   if (stored_len + 4 <= opt_lenb) and Assigned(buf) then begin
      //* 4: two words for the lengths */
      //* The test buf != NULL is only necessary if LIT_BUFSIZE > WSIZE.
      //* Otherwise we can't have processed more than WSIZE input bytes since
      //* the last block flush, because compression would have been
      //* successful. If LIT_BUFSIZE <= WSIZE, it is never too late to
      //* transform a block into a stored block.
       _tr_stored_block(buf, buf_offset, stored_len, eof);
   end
   else if (strategy = CompressionStrategy_Z_FIXED) or (static_lenb = opt_lenb) then begin
       if eof then
          send_bits((ZLibConst_STATIC_TREES shl 1) + 1, 3)
       else
          send_bits((ZLibConst_STATIC_TREES shl 1) + 0, 3);
       compress_block(ZLibConst_static_ltree, ZLibConst_static_dtree);
   end
   else begin
      if eof then
         send_bits((ZLibConst_DYN_TREES shl 1) + 1, 3)
      else
         send_bits((ZLibConst_DYN_TREES shl 1) + 0, 3);
      send_all_trees(FL_desc.FMax_code + 1, FD_desc.FMax_code + 1, max_blindex + 1);
      compress_block(FDyn_ltree, FDyn_dtree);
   end;
   init_block();
   if (eof) then begin
      bi_windup();
   end;
end;


//* ===========================================================================
//* Send the block data compressed using the given Huffman trees
//* ===========================================================================
procedure TTree.compress_block(
              ltree,               //* literal tree */
              dtree:TArrSmallint); //* distance tree */
Var 
   dist,          //* distance of matched string */
   lx:longword;   //* running index in l_buf */
   code:longint;  //* the code to send */
   lc,            //* match length or unmatched char (if dist == 0) */
   extra:longint; //* number of extra bits to send */
begin

   lx := 0;
   if (FLast_lit <> 0) then
   repeat
      dist := FPending_buf.GetDBuf(lx);
      lc := FPending_buf.GetLBuf(lx);
      inc(lx);
      if (dist = 0) then begin
         send_code(lc, ltree); //* send a literal byte */
         //Tracecv(isgraph(lc), String.Format(" 'begin0end;' ", lc));
      end
      else begin
         //* Here, lc is the match length - MIN_MATCH */
         code := ZLibConst_length_code[lc];
         send_code(longint(code + ZLibConst_LITERALS + 1), ltree); //* send the length code */
         extra := ZLibConst_extra_lbits[code];
         if (extra <> 0) then begin
            lc := lc - ZLibConst_base_length[code];
            send_bits(lc, extra);       //* send the extra length bits */
         end;
         dec(dist); //* dist is now the match distance - 1 */
         code := d_code(dist);
         //Debug.Assert(code < ZLibConst_D_CODES, "bad d_code");

         send_code(longint(code), dtree);       //* send the distance code */
         extra := ZLibConst_extra_dbits[code];
         if (extra <> 0) then begin
            dist := dist - longword(ZLibConst_base_dist[code]);
            send_bits(longint(dist), extra);   //* send the extra distance bits */
         end;
      end; //* literal or match pair ? */
   //* Check that the overlay between FPending_buf and d_buf+l_buf is ok: */
   until (lx >= FLast_lit);

   send_code(ZLibConst_END_BLOCK, ltree);
   FLast_eob_len := ltree[ZLibConst_END_BLOCK * 2 + 1];
end;



//* ===========================================================================
//* Save the match info and tally the frequency counts. Return true if
//* the current block must be flushed.
//* ===========================================================================
function TTree._tr_tally(
              dist:longword;  //* distance of matched string */
              lc:longword):boolean;    //* match length-MIN_MATCH or unmatched char (if dist==0) */
begin
   FPending_buf.SetDBuf(FLast_lit, word(dist));
   FPending_buf.SetLBuf(FLast_lit, byte(lc));
   inc(FLast_lit);

   if (dist = 0) then
      inc(FDyn_ltree[lc * 2]) //* lc is the unmatched char */
   else begin
      inc(FMatches);
      //* Here, lc is the match length - MIN_MATCH */
      dec(dist);             //* dist := match distance - 1 */

      inc(FDyn_ltree[(ZLibConst_length_code[lc] + ZLibConst_LITERALS + 1) * 2]);
      inc(FDyn_dtree[d_code(dist) * 2]);
   end;

   result := (FLast_lit = (FPending_buf.LitBufSize - 1));
   //* We avoid equality with lit_bufsize because of wraparound at 64K
   //* on 16 bit machines and because stored blocks are restricted to
   //* 64K-1 bytes.
end;

//* Mapping from a distance to a distance code. dist is the distance - 1 and
//* must not have side effects. _dist_code[256] and _dist_code[257] are never
//* used.
function TTree.d_code(dist:longword):longword;
begin
   if dist < 256 then
      result := ZLibConst_dist_code[dist]
   else
      result := ZLibConst_dist_code[256 + (dist shr 7)];
end;

//* ===========================================================================
//* Send the header for a block using dynamic Huffman trees: the counts, the
//* lengths of the bit length codes, the literal tree and the distance tree.
//* IN assertion: lcodes >= 257, dcodes >= 1, blcodes >= 4.
//* ===========================================================================
procedure TTree.send_all_trees(lcodes, dcodes, blcodes:longint);
//* number of codes for each tree */
Var rank:longint; //* index in bl_order */
begin
    
//              Debug.Assert(lcodes >= 257 and dcodes >= 1 and blcodes >= 4, "not enough codes"); 
//             Debug.Assert(lcodes <= ZLibConst_L_CODES and dcodes <= ZLibConst_D_CODES and blcodes <= ZLibConst_BL_CODES,
//                           "too many codes");
//              Trace.WriteLine("bl counts: ");
//              Trace.Indent();
   send_bits(lcodes - 257, 5); //* not +255 as stated in appnote.txt */
   send_bits(dcodes - 1,   5);
   send_bits(blcodes - 4,  4); //* not -3 as stated in appnote.txt */

   for rank := 0 to blcodes - 1 do begin
//      Trace.WriteLine(String.Format("bl code begin0end;", ZLibConst_bl_order[rank]));
      send_bits(FBl_tree[ZLibConst_bl_order[rank] * 2 + 1], 3);
   end;

//   Trace.Unindent();
//   Trace.WriteLine(String.Format("bl tree: sent begin0end;", bits_sent));

   send_tree(FDyn_ltree, lcodes - 1); //* literal tree */
//   Trace.WriteLine(String.Format("lit tree: sent begin0end;", bits_sent));

   send_tree(FDyn_dtree, dcodes - 1); //* distance tree */
//   Trace.WriteLine(String.Format("dist tree: sent begin0end;", bits_sent));
end;

//* ===========================================================================
//* Flush the bit buffer, keeping at most 7 bits in it.
//* ===========================================================================
procedure TTree.bi_flush();
begin
   if (FBi_valid = 16) then begin
      FPending_buf.put_short(word(FBi_buf));
      FBi_buf := 0;
      FBi_valid := 0;
   end
   else if (FBi_valid >= 8) then begin
      FPending_buf.put_byte(byte(FBi_buf));
      FBi_buf := smallint(word(FBi_buf shr 8));
      FBi_valid := FBi_valid - 8;
   end;
end;


//* ===========================================================================
//* Send a literal or distance tree in compressed form, using the codes in
//* FBl_tree.
//* ===========================================================================
procedure TTree.send_tree (
              tree:TArrSmallint;       //* the tree to be scanned */
              max_code:longint);       //* and its largest code of non zero frequency */
Var n,          //* iterates over all tree elements */
    prevlen,    //* last emitted length */
    curlen,     //* length of current code */
    nextlen,    //* length of next code */
    count,      //* repeat count of the current code */
    max_count,  //* max repeat count */
    min_count:longint;  //* min repeat count */
begin
   prevlen := -1;          
   nextlen := tree[0 * 2 + 1]; 
   count := 0;             
   max_count := 7;         
   min_count := 4;         

   //* tree[max_code+1].Len := -1; */  //* guard already set */
   if (nextlen = 0) then begin 
      max_count := 138; 
      min_count := 3; 
   end;

   for n := 0 to max_code do begin
      curlen  := nextlen; 
      nextlen := tree[(n + 1) * 2 + 1];

      count := count + 1;
      if (count < max_count) and (curlen = nextlen) then 
         continue
      else if (count < min_count) then begin
         repeat
            send_code(curlen, FBl_tree); 
            count := count - 1;
         until (count = 0);
      end 
      else if (curlen <> 0) then begin
        if (curlen <> prevlen) then begin
           send_code(curlen, FBl_tree); 
           count := count - 1;
        end;
//*        Debug.Assert(count >= 3 and count <= 6, " 3_6?");
        send_code(ZLibConst_REP_3_6, FBl_tree); 
        send_bits(count - 3, 2);
      end
      else if (count <= 10) then begin
         send_code(ZLibConst_REPZ_3_10, FBl_tree); 
         send_bits(count - 3, 3);
      end 
      else begin
         send_code(ZLibConst_REPZ_11_138, FBl_tree); 
         send_bits(count - 11, 7);
      end;

      count := 0; 
      prevlen := curlen;
      if (nextlen = 0) then begin
         max_count := 138;
         min_count := 3;
      end
      else if (curlen = nextlen) then begin
         max_count := 6;
         min_count := 3;
      end
      else begin
         max_count := 7;
         min_count := 4;
      end;
   end;
end;

//* ===========================================================================
//* Flush the bit buffer and align the output on a byte boundary
//* ===========================================================================
procedure TTree.bi_windup();
begin
   if (FBi_valid > 8) then
      FPending_buf.put_short(word(FBi_buf))
   else 
      if (FBi_valid > 0) then 
         FPending_buf.put_byte(byte(FBi_buf));

   FBi_buf := 0;
   FBi_valid := 0;
end;

{/* ===========================================================================
  * Gets the data type BINARY or TEXT, using a crude approximation:
  * gets Z_TEXT if all symbols are either printable characters (33 to 255)
  * or white spaces (9 to 13, or 32); or gets Z_BINARY otherwise.
  * IN assertion: the fields Freq of FDyn_ltree are set.
  */}
function TTree.get_data_type():DataType;
Var n:longint;
begin

   for n := 0 to 8 do
       if (FDyn_ltree[n * 2] <> 0) then break;

   if (n = 9) then
      for n := 14 to 31 do
         if (FDyn_ltree[n * 2] <> 0) then break;

   if (n = 32) then
      result := DataType_Z_TEXT
   else
      result := DataType_Z_BINARY;
end;                    

function TTree.ToString(): string;
Var ret:widestring;
begin
   ret := Format(' FDyn_ltree.Length:%d',     [longint(Length(FDyn_ltree))]);
   ret := ret +  Format(' #dyn_ltree:%d',     [longint(ZLibConst_GetHashCodeForVal(FDyn_ltree))]);  
   ret := ret +  Format(' #dyn_dtree:%d', [longint(ZLibConst_GetHashCodeForVal(FDyn_dtree))]);   
   ret := ret +  Format(' #bl_tree:%d', [longint(ZLibConst_GetHashCodeForVal(FBl_tree))]); 
   ret := ret +  Format(' #l_desc:%d', [longint(FL_desc.GetHashCode())]);   
   ret := ret +  Format(' #d_desc:%d', [longint(FD_desc.GetHashCode())]);   
   ret := ret +  Format(' #bl_desc:%d', [longint(FBl_desc.GetHashCode())]); 
   ret := ret +  Format(' #bl_count:%d', [longint(ZLibConst_GetHashCodeForVal(FBl_count))]);  
   ret := ret +  Format(' FLast_lit:%d', [longint(FLast_lit)]); 
   ret := ret +  Format(' #heap:%d', [longint(ZLibConst_GetHashCodeForVal(FHeap))]); 
   ret := ret +  Format(' FHeap_len:%d', [longint(FHeap_len)]); 
   ret := ret +  Format(' FHeap_max:%d', [longint(FHeap_max)]); 
   ret := ret +  Format(' #depth:%d', [longint(ZLibConst_GetHashCodeForVal(FDepth))]);
   ret := ret +  Format(' FDepth.length:%d', [longint(FDepth.Length)]);
//   ret := ret +  ' depth_value:' + FDepth.ToString();
   ret := ret +  Format(' FOpt_len:%d', [longint(FOpt_len)]);   
   ret := ret +  Format(' FStatic_len:%d', [longint(FStatic_len)]);   
   ret := ret +  Format(' FMatches:%d', [longint(FMatches)]);   
   ret := ret +  Format(' FLast_eob_len:%d', [longint(FLast_eob_len)]);  
   ret := ret +  Format(' FBi_buf:%d', [longint(FBi_buf)]);  
   ret := ret +  Format(' FBi_valid:%d', [longint(FBi_valid)]); 
               
   result := ret; 
end;


function TTree.GetHashCode():longint;
Var HashCode:longword;
begin
//            return 0;  
   HashCode := 1;   

   HashCode := 33 * HashCode + ZLibConst_GetHashCodeForVal(FDyn_ltree); //*short[]*/
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + ZLibConst_GetHashCodeForVal(FDyn_dtree); //*short[]*/
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + ZLibConst_GetHashCodeForVal(FBl_tree); //*short[]*/
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FL_desc.GetHashCode()); //*tree_desc*/
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FD_desc.GetHashCode()); //*tree_desc*/
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FBl_desc.GetHashCode()); //*tree_desc*/
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + ZLibConst_GetHashCodeForVal(FBl_count); //*short[]*/
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FLast_lit); 
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + ZLibConst_GetHashCodeForVal(FHeap); //*int[]*/
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FHeap_len); 
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FHeap_max); 
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + ZLibConst_GetHashCodeForVal(FDepth); //*byte[]*/
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FOpt_len); 
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FStatic_len); 
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FMatches); 
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FLast_eob_len); 
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FBi_buf); 
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FBi_valid); 
   HashCode := HashCode + HashCode shr 5;

   result := longint(HashCode);
               
end;


end.