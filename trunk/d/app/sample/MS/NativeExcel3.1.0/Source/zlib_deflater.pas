//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         zlib_deflater
//
//      Description:  Deflater (zlib)
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

unit zlib_deflater;
{$Q-}
{$R-}


interface
{$I xlsdef.inc}

uses zlib_deftype, zlib_z_stream, zlib_adler32, 
     zlib_const,   zlib_tree,     zlib_pendingbuf, 
     zlib_gz_header, sysutils;
type

   TDeflater = class
   private

      FStrm:TZ_Stream;
      FTree:TTree;
      FStatus:StreamStatus;    //* as the name implies

      FPending_buf:TPendingBuf;

      FWrap:longint;        //* bit 0 true for zlib, bit 1 true for gzip
      FMethod:byte;         //* STORED (for zip only) or DEFLATED
      FLast_flush:FlushMode;//* value of flush param for previous deflate call
      FW_size:longint;      //* LZ77 window size (32K by default)
      FW_bits:longint;      //* log2(FW_size)  (8..16)
      FW_mask:longint;      //* FW_size - 1

      FPrev_match:longword; //* previous match

{$IFDEF GZIP}
      FGZhead:Tgz_header;   //* gzip header information to write
      FGZindex:longword;    //* where in extra, name, or comment
{$ENDIF}


      FWindow:TArrByte;
      //* Sliding window. Input bytes are read into the second half of the window,
      //*and move to the first half later to keep a dictionary of at least wSize
      //*bytes. With this organization, matches are limited to a distance of
      //*wSize-MAX_MATCH bytes, but this ensures that IO is always
      //*performed with a length multiple of the block size. Also, it limits
      //*the window size to 64K, which is quite useful on MSDOS.
      //*To do: use the user input buffer as sliding window.
      

      FWindow_size:longword;
      //* Actual size of window: 2*wSize, except when the user input buffer
      //*is directly used as sliding window.
      

      FPrev:TArrSmallint;
      //* Link to older string with same hash index. To limit the size of this
      //*array to 64K, this link is maintained only for the last 32K strings.
      //*An index in this array is thus a window index modulo 32K.
      

      FHead:TArrSmallint;      //* Heads of the hash chains or NIL.

      FIns_h:longword;         //* hash index of string to be inserted
      FHash_size:longint;      //* number of elements in hash table
      FHash_bits:longint;      //* log2(FHash_size)
      FHash_mask:longint;      //* FHash_size-1

      FHash_shift:longint;
      //* Number of bits by which FIns_h must be shifted at each input
      //*step. It must be such that after MIN_MATCH steps, the oldest
      //*byte no longer takes part in the hash key, that is:
      //*  FHash_shift//*MIN_MATCH >= FHash_bits
      

      FBlock_start:int64;
      //* Window position at the beginning of the current output block. Gets
      //*negative when the window is moved backwards.
      

      FMatch_length:longword;   //* length of best match
      FMatch_available:boolean; //* set if previous match exists
      FStrstart:longword;       //* start of string to insert
      FMatch_start:longword;    //* start of matching string
      FLookahead:longword;      //* number of valid bytes ahead in window

      FPrev_length:longword;
      //* Length of the best match at previous step. Matches not greater than this
      //*are discarded. This is used in the lazy match evaluation.
      

      FMax_chain_length:longword;
      //* To speed up deflation, hash chains are never searched beyond this
      //*length.  A higher limit improves compression ratio but degrades the
      //*speed.
      

      FMax_lazy_match:longword;
      //* Attempt to find a better match only when the current match is strictly
      //*smaller than this value. This mechanism is used only for compression
      //*levels >= 4.
      

      //#define FMax_insert_length  FMax_lazy_match
      //* Insert new strings in the hash table only if the match length is not
      //*greater than this length. This saves time but degrades compression.
      //*FMax_insert_length is used only for compression levels <= 3.
      
      FLevel:longint;  //* compression FLevel (1..9)
      FStrategy:CompressionStrategy; //* favor or force Huffman coding*/
      FGood_match:longword; //* Use a faster search when the previous match is longer than this
      FNice_match:longword; //* Stop searching when current match exceeds this

      function DeflateInit(z_stream:TZ_Stream; FLevel:longint; method:DeflateMethod; 
                           windowBits, memLevel:longint; strategy:CompressionStrategy):CompressionReturnCode;

      procedure flush_block_only(eof:boolean); 
      function  deflate_stored(flush:FlushMode):block_state;
      procedure tr_flush_block(buf:TArrByte; buf_offset:longint;
                            stored_len:longword; eof:boolean);
      procedure fill_window(); 
      function  update_hash(h:longword; c:byte):longword;
      function  insert_string(str:longword; FMatch_head:longint):longint;
      function  deflate_fast(flush:FlushMode):block_state; 
      function  deflate_slow(flush:FlushMode):block_state;
      procedure flush_pending(); 
      function  DeflateReset():CompressionReturnCode; 
      procedure lm_init();
      function  longest_match(cur_match:longword):longword; 
      function  longest_FMatch_fast(cur_match:longword):longword; 
   public
      constructor Create(z_stream:TZ_Stream; FLevel, windowBits:longint);
      destructor Destroy;override;

      function ToString(): string; {$ifdef D2009}override;{$endif}
      function GetHashCode():longint; {$ifdef D2009}override;{$endif}
      function Deflate(flush:FlushMode):CompressionReturnCode;
   end;


implementation


constructor TDeflater.Create(z_stream:TZ_Stream; FLevel, windowBits:longint);
begin
   inherited Create;

   DeflateInit(z_stream, FLevel, DeflateMethod_Z_DEFLATED,
               windowBits, ZLibConst_DEF_MEM_LEVEL, 
               CompressionStrategy_Z_DEFAULT_STRATEGY);
end; 

destructor TDeflater.Destroy;
begin
   FPending_buf.Free;
   FWindow.Free;
   FTree.Free;

   inherited Destroy;
end;


function TDeflater.ToString(): string;
Var ret:string;
begin
   ret := Format(' FStatus:%d',[longint(ord(FStatus))]); 
   if not Assigned(FTree) then
      ret := ret +  ' FTree:0'   
   else
      ret := ret +  Format(' #tree:%d',[longint(FTree.GetHashCode())]);   
   if Assigned(FTree) then ret := ret + FTree.ToString();
   if not Assigned(FPending_buf) then
      ret := ret +  ' FPending_buf:0'   
   else
      ret := ret +  Format(' #pending_buf:%d',[longint(FPending_buf.GetHashCode())]);   
   ret := ret +  Format(' FLast_flush:%d',[longint(ord(FLast_flush))]);   
   ret := ret +  Format(' FW_size:%d',[longint(FW_size)]);  
   ret := ret +  Format(' FW_bits:%d',[longint(FW_bits)]);  
   ret := ret +  Format(' FW_mask:%d',[longint(FW_mask)]);  
   ret := ret +  Format(' FPrev_match:%d',[longint(FPrev_match)]);   
   ret := ret +  Format(' #window:%d',[longint(ZLibConst_GetHashCodeForVal(FWindow))]);   
   ret := ret +  Format(' FWindow_size:%d',[longint(FWindow_size)]); 
//   ret := ret +  ' window_value:' + FWindow.ToString();
   ret := ret +  Format(' #prev:%d',[longint(ZLibConst_GetHashCodeForVal(FPrev))]); 
   ret := ret +  Format(' #head:%d',[longint(ZLibConst_GetHashCodeForVal(FHead))]); 
   ret := ret +  Format(' FIns_h:%d',[longint(FIns_h)]); 
   ret := ret +  Format(' FHash_size:%d',[longint(FHash_size)]);  
   ret := ret +  Format(' FHash_bits:%d',[longint(FHash_bits)]);  
   ret := ret +  Format(' FHash_mask:%d',[longint(FHash_mask)]);  
   ret := ret +  Format(' FHash_shift:%d',[longint(FHash_shift)]);   
   ret := ret +  Format(' FBlock_start:%d',[longint(FBlock_start)]); 
   ret := ret +  Format(' FMatch_length:%d',[longint(FMatch_length)]);  
   ret := ret +  Format(' FStrstart:%d',[longint(FStrstart)]); 
   ret := ret +  Format(' FMatch_start:%d',[longint(FMatch_start)]); 
   ret := ret +  Format(' FLookahead:%d',[longint(FLookahead)]);  
   ret := ret +  Format(' FPrev_length:%d',[longint(FPrev_length)]); 
   ret := ret +  Format(' FMax_chain_length:%d',[longint(FMax_chain_length)]);   
   ret := ret +  Format(' FMax_lazy_match:%d',[longint(FMax_lazy_match)]); 
               
   result := ret; 
end;

function TDeflater.GetHashCode():longint;
Var HashCode:longword;
begin
   HashCode := 1;   

   HashCode := 33 * HashCode + longword(FTree.GetHashCode());
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FPending_buf.GetHashCode());
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FStatus);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FLast_flush);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FW_size);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FW_bits);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FW_mask);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FPrev_match);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + ZLibConst_GetHashCodeForVal(FWindow);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FWindow_size);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + ZLibConst_GetHashCodeForVal(FPrev);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + ZLibConst_GetHashCodeForVal(FHead);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FIns_h);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FHash_size);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FHash_bits);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FHash_mask);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FHash_shift);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FBlock_start);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FMatch_length);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FStrstart);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FMatch_start);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FLookahead);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FPrev_length);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FMax_chain_length);
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FMax_lazy_match);
   HashCode := HashCode + HashCode shr 5;

   result := longint(HashCode);
end;


function TDeflater.Deflate(flush:FlushMode):CompressionReturnCode;
Var old_flush:FlushMode;
    ArrNull:TArrByte;
    bstate:block_state;
    FLevel_flags:longword;
    header:longword;
{$IFDEF GZIP}
    beg:longword;
    val:longint;
{$ENDIF}
begin

   ArrNull := nil;
   if (not Assigned(FStrm)) or 
         (flush > FlushMode_Z_FINISH) or 
            (flush < FlushMode_Z_NO_FLUSH) then begin
       result := CompressionReturnCode_Z_STREAM_ERROR;
       exit;
   end;

   if not (FStrm.CheckBuffer()) then begin
       result := CompressionReturnCode_Z_STREAM_ERROR;
       exit;
   end;
    
   if (FStatus = StreamStatus_FINISH_STATE) and 
         (flush <> FlushMode_Z_FINISH) then begin
       result := CompressionReturnCode_Z_STREAM_ERROR;
       exit;
   end;

   if (FStrm.AvailableOut = 0) then begin
       result := CompressionReturnCode_Z_BUF_ERROR;
       exit;
   end;

   old_flush := FLast_flush;
   FLast_flush := flush;

   //* Write zlib header
   if (FStatus = StreamStatus_INIT_STATE) then begin
{$IFDEF GZIP}
      if (FWrap = 2) then begin
         FStrm.FAdler := Adler32_crc32(0, ArrNull, 0, 0);
         FPending_buf.put_byte(31);
         FPending_buf.put_byte(139);
         FPending_buf.put_byte(8);

         if not Assigned(FGZhead) then begin
            FPending_buf.put_byte(0);
            FPending_buf.put_byte(0);
            FPending_buf.put_byte(0);
            FPending_buf.put_byte(0);
            FPending_buf.put_byte(0);
            if FLevel = 9 then
               FPending_buf.put_byte(byte(2))
            else 
               if (FStrategy >= CompressionStrategy_Z_HUFFMAN_ONLY) or 
                        (FLevel < 2) then
                  FPending_buf.put_byte(byte(4))
               else
                  FPending_buf.put_byte(byte(0));
            FPending_buf.put_byte(ZLibConst_OS_CODE);
            FStatus := StreamStatus_BUSY_STATE;
         end
         else begin

            FGZhead.WriteHeader(FPending_buf, FLevel, FStrategy); 
            if (FGZhead.hcrc > 0) then 
               FStrm.FAdler := Adler32_crc32(FStrm.FAdler, FPending_buf.BaseBuff, 0, FPending_buf.Pending);
            FGZindex := 0;
            FStatus := StreamStatus_EXTRA_STATE;
         end;
      end 
      else
{$ENDIF}
      begin
         header := longword((longint(DeflateMethod_Z_DEFLATED) + ((FW_bits - 8) shl 4)) shl 8);
         
       if (FStrategy >= CompressionStrategy_Z_HUFFMAN_ONLY) or (FLevel < 2) then begin
            FLevel_flags := 0;
         end 
         else if (FLevel < 6) then begin
             FLevel_flags := 1;
         end 
         else if (FLevel = 6) then begin
             FLevel_flags := 2;
         end 
         else begin
             FLevel_flags := 3;
         end;  

         header := header or (FLevel_flags shl 6);
         if (FStrstart <> 0) then header := header or longword(ZLibConst_PRESET_DICT);
         header := header + (31 - (header mod 31));

         FStatus := StreamStatus_BUSY_STATE;

         FPending_buf.putShortMSB(header);

         //* Save the adler32 of the preset dictionary:
         if (FStrstart <> 0) then begin
            FPending_buf.putShortMSB(longword(FStrm.FAdler shr 16));
            FPending_buf.putShortMSB(longword(FStrm.FAdler and $ffff));
         end;

         FStrm.FAdler := Adler32_adler32(0, ArrNull, 0, 0);
      end;
   end;

{$IFDEF GZIP}
   if (FStatus = StreamStatus_EXTRA_STATE) then begin
      if Length(FGZhead.extra) = 0 then begin
         beg := FPending_buf.Pending;  //* start of bytes to update crc

         while (FGZindex < (FGZhead.extra_len and $ffff)) then begin
            if (FPending_buf.Pending = FPending_buf.Size) then begin
               if (FGZhead.hcrc > 0 and FPending_buf.Pending > beg) then
                     FStrm.FAdler := Adler32_crc32(FStrm.FAdler, FPending_buf.BaseBuff, beg, FPending_buf.Pending - beg);
               flush_pending();
               beg := FPending_buf.Pending;
               if (FPending_buf.Pending = FPending_buf.Size) then break;
             end;
             FPending_buf.put_byte(FGZhead.extra[FGZindex]);
             inc(FGZindex);
         end;
         if (FGZhead.hcrc > 0 and FPending_buf.Pending > beg) then
            FStrm.FAdler := Adler32_crc32(FStrm.FAdler, FPending_buf.BaseBuff, beg, FPending_buf.Pending - beg);
         if (FGZindex = FGZhead.extra_len) then begin
            FGZindex := 0;
            FStatus := StreamStatus_NAME_STATE;
         end;
      end
      else
         FStatus := StreamStatus_NAME_STATE;
   end;
   if (FStatus = StreamStatus_NAME_STATE) then begin
      if (FGZhead.name <> nil) then begin
         beg := FPending_buf.Pending;  //* start of bytes to update crc

         repeat
            if (FPending_buf.Pending = FPending_buf.Size) then begin
               if (FGZhead.hcrc > 0 and FPending_buf.Pending > beg) then
                  FStrm.FAdler := Adler32_crc32(FStrm.FAdler, FPending_buf.BaseBuff, beg, 
                                   FPending_buf.Pending - beg);
               flush_pending();
               beg := FPending_buf.Pending;
               if (FPending_buf.Pending = FPending_buf.Size) then begin
                  val := 1;
                  break;
               end;
            end;
            val := FGZhead.name[FGZindex];
            inc(FGZindex);
            FPending_buf.put_byte(byte(val));
         until not(val <> 0);

         if (FGZhead.hcrc > 0) and (FPending_buf.Pending > beg) then
             FStrm.FAdler := Adler32_crc32(FStrm.FAdler, FPending_buf.BaseBuff, beg, 
                                        FPending_buf.Pending - beg);
         if (val = 0) then begin
            FGZindex := 0;
            FStatus := StreamStatus_COMMENT_STATE;
         end;
      end
      else
        FStatus := StreamStatus_COMMENT_STATE;
   end;
   if (FStatus = StreamStatus_COMMENT_STATE) then begin
      if (FGZhead.comment <> nil) then begin
         beg := FPending_buf.Pending;  //* start of bytes to update crc

         repeat
            if (FPending_buf.Pending = FPending_buf.Size) then begin
               if (FGZhead.hcrc > 0) and (FPending_buf.Pending > beg) then
                  FStrm.FAdler := Adler32_crc32(FStrm.FAdler, FPending_buf.BaseBuff, beg, 
                                                FPending_buf.Pending - beg);
               flush_pending();
               beg := FPending_buf.Pending;
               if (FPending_buf.Pending = FPending_buf.Size) then begin
                  val := 1;
                  break;
               end;
            end;
            val := FGZhead.comment[FGZindex];
            inc(FGZindex);
            FPending_buf.put_byte(byte(val));
         until not (val <> 0);

         if (FGZhead.hcrc > 0 and FPending_buf.Pending > beg) then
             FStrm.FAdler := Adler32_crc32(FStrm.FAdler, FPending_buf.BaseBuff, beg, 
                                        FPending_buf.Pending - beg);
         if (val = 0) then FStatus := StreamStatus_HCRC_STATE;
      end
      else
         FStatus := StreamStatus_HCRC_STATE;
   end;
   if (FStatus = StreamStatus_HCRC_STATE) then begin
      if (FGZhead.hcrc > 0) then begin
         if (FPending_buf.Pending + 2 > FPending_buf.Size) then flush_pending();
         
         if (FPending_buf.Pending + 2 <= FPending_buf.Size) then begin
             FPending_buf.put_byte(byte(FStrm.FAdler and $ff));
             FPending_buf.put_byte(byte((FStrm.FAdler shr 8) and $ff));
             FStrm.FAdler := Adler32_crc32(0, ArrNull, 0, 0); 
             FStatus := StreamStatus_BUSY_STATE;
         end;
      end
      else
         FStatus := StreamStatus_BUSY_STATE;
   end;
{$ENDIF}

   //* Flush as much pending output as possible
   if (FPending_buf.Pending <> 0) then begin
      flush_pending();
      if (FStrm.AvailableOut = 0) then begin
      //* Since avail_out is 0, deflate will be called again with
      //*more output space, but possibly with both pending and
      //*avail_in equal to zero. There won't be anything to do,
      //*but this is not an error situation so make sure we
      //*result := OK instead of BUF_ERROR at next call of deflate:
         
         FLast_flush := FlushMode_Z_NEGATIVE;
         result := CompressionReturnCode_Z_OK;
         exit;
      end;

      //* Make sure there is something to do and avoid duplicate consecutive
      //*flushes. For repeated and useless calls with Z_FINISH, we keep
      //*returning Z_STREAM_END instead of Z_BUF_ERROR.
              
   end 
   else if (FStrm.AvailableIn = 0) and (flush <= old_flush) and 
            (flush <> FlushMode_Z_FINISH) then begin
      result := CompressionReturnCode_Z_BUF_ERROR;
      exit;
   end;

   //* User must not provide more input after the first FINISH:
   if (FStatus = StreamStatus_FINISH_STATE) and 
         (FStrm.AvailableIn <> 0) then begin
      result := CompressionReturnCode_Z_BUF_ERROR;
      exit;
   end;

   //* Start a new block or continue the current one.
              
   if ((FStrm.AvailableIn <> 0) or (FLookahead <> 0))  or 
           ((flush <> FlushMode_Z_NO_FLUSH) and 
               (FStatus <> StreamStatus_FINISH_STATE)) then begin
      case (ZLibConst_configuration_table[FLevel].FFunc) of
         compress_func_deflate_stored: begin
                bstate := deflate_stored(flush);
            end;
         compress_func_deflate_fast: begin
                bstate := deflate_fast(flush);
            end;
         compress_func_deflate_slow: begin
                bstate := deflate_slow(flush);
            end;
      else begin
            result := CompressionReturnCode_Z_OTHER_ERROR;
            exit;
         end;
      end;

      if (bstate = Block_State_finish_started) or 
            (bstate = Block_State_finish_done) then begin
         FStatus := StreamStatus_FINISH_STATE;
      end;

      if (bstate = Block_State_need_more) or 
            (bstate = Block_State_finish_started) then begin

         if (FStrm.AvailableOut = 0) then begin
             FLast_flush := FlushMode_Z_NEGATIVE; //* avoid BUF_ERROR next call, see above
         end;

         result := CompressionReturnCode_Z_OK;
         exit;
         //* If flush <> Z_NO_FLUSH and avail_out = 0, the next call
         //*of deflate should use the same flush parameter to make sure
         //*that the flush is complete. So we don't have to output an
         //*empty block here, this will be done at next call. This also
         //*ensures that for a very small output buffer, we emit at most
         //*one empty block.
      end;

      if (bstate = Block_State_block_done) then begin
         if (flush = FlushMode_Z_PARTIAL_FLUSH) then begin
            FTree._tr_align();
         end 
         else begin //* FULL_FLUSH or SYNC_FLUSH
            FTree._tr_stored_block(FWindow, 0, 0, false);
              //* For a full flush, this empty block will be recognized
              //*as a special marker by inflate_sync().
              
            if (flush = FlushMode_Z_FULL_FLUSH) then begin
               ArraySmallintClear(FHead, 0, FHash_size); //* forget history
            end;
         end;

         flush_pending();

         if (FStrm.AvailableOut = 0) then begin
            FLast_flush := FlushMode_Z_NEGATIVE; //* avoid BUF_ERROR at next call, see above
            result := CompressionReturnCode_Z_OK;
            exit;
         end;
      end;
   end;

   if (flush <> FlushMode_Z_FINISH) then begin
      result := CompressionReturnCode_Z_OK;
      exit;
   end;
   if (FWrap <= 0) then  begin
      result := CompressionReturnCode_Z_STREAM_END;
      exit;
   end;

   //* Write the trailer
{$IFDEF GZIP}
   if (FWrap = 2) then begin
       FPending_buf.put_byte(byte(FStrm.FAdler and $ff));
       FPending_buf.put_byte(byte((FStrm.FAdler shr 8) and $ff));
       FPending_buf.put_byte(byte((FStrm.FAdler shr 16) and $ff));
       FPending_buf.put_byte(byte((FStrm.FAdler shr 24) and $ff));

       FPending_buf.put_byte(byte(FStrm.TotalIn and $ff));
       FPending_buf.put_byte(byte((FStrm.TotalIn shr 8) and $ff));
       FPending_buf.put_byte(byte((FStrm.TotalIn shr 16) and $ff));
       FPending_buf.put_byte(byte((FStrm.TotalIn shr 24) and $ff));
   end
   else
{$ENDIF}
   begin 
       FPending_buf.putShortMSB(longword(FStrm.FAdler shr 16));
       FPending_buf.putShortMSB(longword(FStrm.FAdler and $ffff));
   end;

   flush_pending();
   //* If avail_out is zero, the application will call deflate again
   //*to flush the rest.
   

   if (FWrap > 0) then FWrap := -FWrap; //* write the trailer only once!
   if FPending_buf.Pending <> 0 then
      result := CompressionReturnCode_Z_OK
   else
      result := CompressionReturnCode_Z_STREAM_END;
end;


//* ===========================================================================
//*Copy without compression as much as possible from the input stream, return
//*the current block state.
//*This function does not insert new strings in the dictionary since
//*uncompressible data is probably not useful. This function is used
//*only for the FLevel=0 compression option.
//*NOTE: this function should be optimized to avoid extra copying from
//*FWindow to FPending_buf.
        
function TDeflater.deflate_stored(flush:FlushMode):block_state;
Var FMax_block_size,
    FMax_start:longword;
begin
   //* Stored blocks are limited to $ffff bytes, FPending_buf is limited
   //*to pending_buf_size, and each stored block has a 5 byte header:

   FMax_block_size := $ffff;
   if (FMax_block_size > FPending_buf.Size - 5) then begin
      FMax_block_size := FPending_buf.Size - 5;
   end;

   //* Copy as much as possible from input to output:
   while (true) do begin
      //* Fill the FWindow as much as possible:
      if (FLookahead <= 1) then begin
         fill_window();
         if (FLookahead = 0) and (flush = FlushMode_Z_NO_FLUSH) then begin
            result := Block_State_need_more;
            exit;
         end;
         if (FLookahead = 0) then break; //* flush the current block
      end;

      FStrstart := FStrstart + FLookahead;
      FLookahead := 0;

      //* Emit a stored block if FPending_buf will be full:
      FMax_start := longword(FBlock_start) + FMax_block_size;
      if (FStrstart = 0) or (FStrstart >= FMax_start) then begin
         //* FStrstart = 0 is possible when wraparound on 16-bit machine
         FLookahead := longword(FStrstart - FMax_start);
         FStrstart := longword(FMax_start);

         //FLUSH_BLOCK
         flush_block_only(false);
         if (FStrm.AvailableOut = 0) then begin 
            result := Block_State_need_more;
            exit;
         end;

      end;
      //* Flush if we may have to slide, otherwise FBlock_start may become
      //*negative and the data will be gone:
                   
      if (FStrstart - FBlock_start) >= (FW_size - ZLibConst_MIN_LOOKAHEAD) then begin
         flush_block_only(false);
         if (FStrm.AvailableOut = 0) then begin 
            result := Block_State_need_more;
            exit;
         end;
      end;
   end;

   flush_block_only(flush = FlushMode_Z_FINISH);
   if (FStrm.AvailableOut = 0) then begin 
      if (flush = FlushMode_Z_FINISH) then
         result := Block_State_finish_started
      else
         result := Block_State_need_more;
      exit;
   end;

   if flush = FlushMode_Z_FINISH then
      result := Block_State_finish_done
   else
      result := Block_State_block_done;
end;


//* ===========================================================================
//*Flush the current block, with given end-of-file flag.
//*IN assertion: FStrstart is set to the end of the current match.
procedure TDeflater.flush_block_only(eof:boolean); 
//Var h:longint;
begin 
   if (FBlock_start >= 0) then begin
      self.tr_flush_block(FWindow, longint(FBlock_start), longword(FStrstart - FBlock_start), eof);
   end 
   else begin
      self.tr_flush_block(nil, -1, longword(FStrstart - FBlock_start), eof);
   end;

   FBlock_start := FStrstart;
   flush_pending();
end;

//* ===========================================================================
//*Determine the best encoding for the current block: dynamic trees, static
//*trees or store, and output the encoded block to the zip file.
procedure TDeflater.tr_flush_block (
             buf:TArrByte;        //* input block, or nil if too old
             buf_offset:longint;  //* input block offset
             stored_len:longword; //* length of input block
             eof:boolean);         //* true if this is the last block for a file
begin
   if (FLevel > 0) then begin
   //* Check if the file is binary or text
      if (stored_len > 0) and (FStrm.Data_Type = DataType_Z_UNKNOWN) then
         FStrm.Data_Type := FTree.get_data_type();
   end;
   FTree._tr_flush_block(buf, buf_offset, stored_len, eof, FLevel, FStrategy);
end;

//* ===========================================================================
//*Fill the FWindow when the FLookahead becomes insufficient.
//*Updates FStrstart and FLookahead.
//*IN assertion: FLookahead < MIN_LOOKAHEAD
//*OUT assertions: FStrstart <= FWindow_size-MIN_LOOKAHEAD
//*   At least one byte has been read, or avail_in = 0; reads are
//*   performed for at least two bytes (required for the zip translate_eol
//*   option -- not supported here).
         
procedure TDeflater.fill_window(); 
Var n, m:longint;
    more:longint;    //* Amount of free space at the end of the FWindow.
begin

   repeat
      more := longint(FWindow_size - FLookahead - FStrstart);

     //* If the FWindow is almost full and there is insufficient FLookahead,
      //*move the upper half to the lower one to make room in the upper half.
                 
      if (FStrstart >= longword(FW_size + FW_size - ZLibConst_MIN_LOOKAHEAD)) then begin

         ArrayCopy(FWindow, FW_size, FWindow, 0, FW_size);
         FMatch_start := FMatch_start - longword(FW_size);
         FStrstart    := FStrstart - longword(FW_size); // we now have FStrstart >= MAX_DIST
         FBlock_start := FBlock_start - FW_size;

         {/* Slide the hash table (could be avoided with 32 bit values
             at the expense of memory usage). We slide even when FLevel = 0
             to keep the hash table consistent if we switch back to FLevel > 0
             later. (Using FLevel 0 permanently is not an optimal usage of
             zlib, so we don't care about this pathological case.)}
         //* %%% avoid this when Z_RLE
         for n := 0 to FHash_size - 1 do begin
            m := FHead[n];
            if m >= FW_size then
               FHead[n] := smallint(m - FW_size)
            else
               FHead[n] := smallint(0);
         end; 

         for n := 0 to FW_size - 1 do begin
            m := FPrev[n]; 
            if m >= FW_size then
               FPrev[n] := smallint(m - FW_size)
            else
               FPrev[n] := smallint(0);
         end; 

         more := more + FW_size;

      end;
      if (FStrm.AvailableIn = 0) then exit;

      //* If there was no sliding:
      //*   FStrstart <= WSIZE+MAX_DIST-1 and FLookahead <= MIN_LOOKAHEAD - 1  and 
      //*   more = FWindow_size - FLookahead - FStrstart
      //*=> more >= FWindow_size - (MIN_LOOKAHEAD-1 + WSIZE + MAX_DIST-1)
      //*=> more >= FWindow_size - 2*WSIZE + 2
      //*In the BIG_MEM or MMAP case (not yet supported),
      //*  FWindow_size = input_size + MIN_LOOKAHEAD   and 
      //*  FStrstart + s->FLookahead <= input_size => more >= MIN_LOOKAHEAD.
      //*Otherwise, FWindow_size = 2*WSIZE so more >= 2.
      //*If there was sliding, more >= WSIZE. So in all cases, more >= 2.
      //Assert(more >= 2, 'more < 2');

      n := FStrm.read_buf(FWindow, FStrstart + FLookahead, longword(more), FWrap);
      FLookahead := FLookahead + longword(n);

      //* Initialize the hash value now that we have some input:
      if (FLookahead >= longword(ZLibConst_MIN_MATCH)) then begin
         FIns_h := FWindow[FStrstart];
         FIns_h := update_hash(FIns_h, FWindow[FStrstart + 1]);
      end;
      //* If the whole input has less than MIN_MATCH bytes, FIns_h is garbage,
      //*but this is not important since only literal bytes will be emitted.

   until not( (FLookahead < longword(ZLibConst_MIN_LOOKAHEAD)) and (FStrm.AvailableIn <> 0));
end;


//* ===========================================================================
//*Update a hash value with the given input byte
//*IN  assertion: all calls to to UPDATE_HASH are made with consecutive
//*   input characters, so that a running hash key can be computed from the
//*   previous key instead of complete recalculation each time.
function TDeflater.update_hash(h:longword; c:byte):longword;
begin
   result := ((h shl FHash_shift) xor c) and longword(FHash_mask);
end; 


//* ===========================================================================
//*Insert string str in the dictionary and set FMatch_head to the previous FHead
//*of the hash chain (the most recent string with same hash key). Return
//*the previous length of the hash chain.
//*If this file is compiled with -DFASTEST, the compression FLevel is forced
//*to 1, and no hash chains are maintained.
//*IN  assertion: all calls to to INSERT_STRING are made with consecutive
//*   input characters and the first MIN_MATCH bytes of str are valid
//*   (except for the last MIN_MATCH-1 bytes of the input file).
function TDeflater.insert_string(str:longword; FMatch_head:longint):longint;
begin
////Console.WriteLine('     FHash_shift:begin0end; FWindow[]:begin1end;',FHash_shift, FWindow[str + ZLibConst_MIN_MATCH - 1]);  
   FIns_h := update_hash(FIns_h, FWindow[str + longword(ZLibConst_MIN_MATCH) - 1]); 
   ////Console.WriteLine('     FHead[begin0end;]=begin1end;',FIns_h, FHead[FIns_h]);  
   FMatch_head := word(FHead[FIns_h]); 
   FPrev[str and FW_mask] := FHead[FIns_h];
   ////Console.WriteLine('     FW_mask:begin0end;', FW_mask);  
   FHead[FIns_h] := smallint(str);
   result := FMatch_head;
end; 


function TDeflater.deflate_fast(flush:FlushMode):block_state; 
Var FHash_head:longint;
    bflush:boolean;
begin
   FHash_head := 0;   //* FHead of the hash chain
   //bflush := false;  //* set if current block must be flushed
   //bool ___log := (GetHashCode() = 1493301384);
   //int _v := 0;
   repeat
      //bool _log := (_v==40) and ___log; 
      //* Make sure that we always have enough FLookahead, except
      //*at the end of the input file. We need MAX_MATCH bytes
      //*for the next match, plus MIN_MATCH bytes to insert the
      //*string following the next match.

      if (FLookahead < longword(ZLibConst_MIN_LOOKAHEAD)) then begin
         //if (_log) Console.WriteLine(' 1 begin0end;<begin1end;', FLookahead, ZLibConst_MIN_LOOKAHEAD);
         //Console.WriteLine(' fill_window 1 ()');  
         fill_window();
         if (FLookahead < longword(ZLibConst_MIN_LOOKAHEAD)) and (flush = FlushMode_Z_NO_FLUSH) then begin
            result := Block_State_need_more;
            exit;
         end;
         if (FLookahead = 0) then break; //* flush the current block
      end;

      //* Insert the string FWindow[FStrstart .. FStrstart+2] in the
      //*dictionary, and set FHash_head to the FHead of the hash chain:
                 
      if (FLookahead >= longword(ZLibConst_MIN_MATCH)) then begin
         //if (_log) Console.WriteLine(' 1 begin0end;>=begin1end;', FLookahead, ZLibConst_MIN_MATCH);
         //Console.WriteLine(' insert_string 1 (begin0end;,begin1end;) FIns_h=begin2end;',FStrstart, FHash_head, FIns_h);  
         FHash_head := insert_string(FStrstart, FHash_head);
         //if (_log) Console.WriteLine(' FHash_head:begin0end; FIns_h=begin1end;', FHash_head, FIns_h);  
      end;

      //* Find the longest match, discarding those <= FPrev_length.
      //*At this point we have always FMatch_length < MIN_MATCH
                 
      //if (_log) Console.WriteLine(' 1 begin0end; <> 0 and begin1end; - begin0end; <= begin2end; - begin3end;', FHash_head, FStrstart, FW_size, ZLibConst_MIN_LOOKAHEAD);
      if (FHash_head <> 0) and 
         ((FStrstart - longword(FHash_head)) <= 
            longword(FW_size - ZLibConst_MIN_LOOKAHEAD)) then begin
         //* To simplify the code, we prevent matches with the string
         //*of FWindow index 0 (in particular we have to avoid a match
         //*of the string with itself at the start of the input file).
                     
//         #ifdef FASTEST
//       if ((FStrategy <> CompressionStrategy_Z_HUFFMAN_ONLY and FStrategy <> CompressionStrategy_Z_RLE)  or 
//                         (FStrategy = CompressionStrategy_Z_RLE and FStrstart - FHash_head = 1)) begin
//                         FMatch_length := longest_FMatch_fast(FHash_head);
//       end;
//         #else
         //if (_log) Console.WriteLine(' 1 begin0end; <> 0 and begin1end; - begin0end; <= begin2end; - begin3end;', FHash_head, FStrstart, FW_size, ZLibConst_MIN_LOOKAHEAD);
         if (FStrategy <> CompressionStrategy_Z_HUFFMAN_ONLY) and (FStrategy <> CompressionStrategy_Z_RLE) then begin
            //Console.WriteLine(' longest_match(begin0end;)',longword(FHash_head);  
            //if (_log) Console.WriteLine('longest_match(begin0end;)',longword(FHash_head);
            FMatch_length := longest_match(longword(FHash_head));
            //Console.WriteLine(' res=begin0end;', FMatch_length);  
         end 
         else if (FStrategy = CompressionStrategy_Z_RLE) and (FStrstart - longword(FHash_head) = 1) then begin
            //Console.WriteLine(' longest_FMatch_fast(begin0end;)',longword(FHash_head);  
            //if (_log) Console.WriteLine('longest_FMatch_fast(begin0end;)',longword(FHash_head);
            FMatch_length := longest_FMatch_fast(longword(FHash_head));
            //Console.WriteLine(' res=begin0end;', FMatch_length);  
         end;
//         {$ENDIF}
         //* longest_match() or longest_FMatch_fast() sets FMatch_start
      end;
      if (FMatch_length >= longword(ZLibConst_MIN_MATCH)) then begin
         //check_match for debug mode 
         //check_match(FStrstart, FMatch_start, FMatch_length);

         //_tr_tally_dist(FStrstart - FMatch_start, FMatch_length - ZLibConst_MIN_MATCH, bflush);
         //Console.WriteLine(' _tr_tally(begin0end;,begin1end;)',FStrstart - FMatch_start, FMatch_length - ZLibConst_MIN_MATCH);  
         //if (_log) Console.WriteLine('_tr_tally(begin0end;-begin1end;, begin2end; - begin3end;)',FStrstart, FMatch_start, FMatch_length, ZLibConst_MIN_MATCH);
         bflush := FTree._tr_tally(FStrstart - FMatch_start, 
                                 FMatch_length - longword(ZLibConst_MIN_MATCH));

         //Console.WriteLine(' bflush=begin0end;', bflush);  
         FLookahead := FLookahead - FMatch_length;

         //* Insert new strings in the hash table only if the match length
         //*is not too large. This saves time but degrades compression.
                     
//         #ifndef FASTEST
         if (FMatch_length <= FMax_lazy_match)  and 
               (FLookahead >= longword(ZLibConst_MIN_MATCH)) then begin
            dec(FMatch_length); //* string at FStrstart already in table
            repeat
               inc(FStrstart);
               //Console.WriteLine(' insert_string 2 (begin0end;,begin1end;) FIns_h=begin2end;',FStrstart, FHash_head, FIns_h);  
               FHash_head := insert_string(FStrstart, FHash_head);
               //Console.WriteLine(' FHash_head:begin0end; FIns_h=begin1end;', FHash_head, FIns_h);  
               //* FStrstart never exceeds WSIZE-MAX_MATCH, so there are
               //*always MIN_MATCH bytes ahead.
               dec(FMatch_length);
            until not(FMatch_length <> 0);
            inc(FStrstart);
         end
         else
//         {$ENDIF}
         begin
            FStrstart := FStrstart + FMatch_length;
            FMatch_length := 0;
            FIns_h := FWindow[FStrstart];
            FIns_h := update_hash(FIns_h, FWindow[FStrstart + 1]);
            //* If FLookahead < MIN_MATCH, FIns_h is garbage, but it does not
            //*matter since it will be recomputed at next deflate call.
         end;
      end 
      else begin
         //* No match, output a literal byte
         //Tracevv((stderr,'%c', s->FWindow[s->FStrstart]));

         //_tr_tally_lit(FWindow[FStrstart], bflush);
         //Console.WriteLine(' _tr_tally 2(begin0end;,begin1end;)',0, FWindow[FStrstart]);  
         //if (_log) Console.WriteLine('_tr_tally(0, begin0end;)',FWindow[FStrstart]);
         bflush := FTree._tr_tally(0, FWindow[FStrstart]);
         //Console.WriteLine(' bflush=begin0end;', bflush);  
         dec(FLookahead);
         inc(FStrstart);
      end;

      if (bflush) then begin
         //FLUSH_BLOCK(false)
         flush_block_only(false);
         if (FStrm.AvailableOut = 0) then begin 
            result := Block_State_need_more;
            exit;
         end;
      end;
   until false;

// FLUSH_BLOCK(flush = FlushMode_Z_FINISH);
   flush_block_only(flush = FlushMode_Z_FINISH);
   //Console.WriteLine('deflate_fast end');
   //Console.WriteLine('AvailableOut=begin0end; AvailableIn=begin1end;', FStrm.AvailableOut, FStrm.AvailableIn);

   if (FStrm.AvailableOut = 0) then begin 
      if (flush = FlushMode_Z_FINISH) then
         result := Block_State_finish_started
      else
         result := Block_State_need_more;
      exit;
   end;

   if flush = FlushMode_Z_FINISH then
      result := Block_State_finish_done
   else
      result := Block_State_block_done;
end;

//* ===========================================================================
//*Same as above, but achieves better compression. We use a lazy
//*evaluation for matches: a match is finally adopted only if there is
//*no better match at the next FWindow position.
//* ===========================================================================
function TDeflater.deflate_slow(flush:FlushMode):block_state;
Var FHash_head:longint;
    bflush:boolean;
    FMax_insert:longword;
begin

   FHash_head := 0;   //* FHead of the hash chain
   //bflush := false;  //* set if current block must be flushed
   //* Process the input block.
   //_v := 0;
   repeat
      //* Console.WriteLine(' iteration for(;;) begin0end;', ++_v);  
      //* Make sure that we always have enough FLookahead, except
      //* at the end of the input file. We need MAX_MATCH bytes
      //* for the next match, plus MIN_MATCH bytes to insert the
      //* string following the next match.
      if (FLookahead < longword(ZLibConst_MIN_LOOKAHEAD)) then begin
         ////Console.WriteLine(' fill_window 1 ()');  
                     
         fill_window();
         if (FLookahead < longword(ZLibConst_MIN_LOOKAHEAD)) and (flush = FlushMode_Z_NO_FLUSH) then begin
            result := Block_State_need_more;
            exit;
         end;
         if (FLookahead = 0) then break; //* flush the current block
      end;

      //* Insert the string FWindow[FStrstart .. FStrstart+2] in the
      //*dictionary, and set FHash_head to the FHead of the hash chain:
                 

      if (FLookahead >= longword(ZLibConst_MIN_MATCH)) then begin
         FHash_head := insert_string(FStrstart, FHash_head);
      end;

      //* Find the longest match, discarding those <= FPrev_length.
                 
      FPrev_length := FMatch_length;
      FPrev_match :=  FMatch_start;
      FMatch_length := ZLibConst_MIN_MATCH - 1;

      if (FHash_head <> 0) and (FPrev_length < FMax_lazy_match)  and 
         (FStrstart - longword(FHash_head) <= longword(FW_size - ZLibConst_MIN_LOOKAHEAD)) then begin
         //* To simplify the code, we prevent matches with the string
         //*of FWindow index 0 (in particular we have to avoid a match
         //*of the string with itself at the start of the input file).
                     
         if (FStrategy <> CompressionStrategy_Z_HUFFMAN_ONLY) and 
            (FStrategy <> CompressionStrategy_Z_RLE) then begin
            FMatch_length := longest_match(longword(FHash_head));
         end 
         else if (FStrategy = CompressionStrategy_Z_RLE) and 
                 (FStrstart - longword(FHash_head) = 1) then begin
            FMatch_length := longest_FMatch_fast(longword(FHash_head));
         end;
         //* longest_match() or longest_FMatch_fast() sets FMatch_start

         if ((FMatch_length <= 5) and 
                           ((FStrategy = CompressionStrategy_Z_FILTERED)  or 
                             ((FMatch_length = longword(ZLibConst_MIN_MATCH)) and 
                              (FStrstart - FMatch_start > longword(ZLibConst_TOO_FAR)))
                           )
            ) then begin
            //* If FPrev_match is also MIN_MATCH, FMatch_start is garbage
            //*but we will ignore the current match anyway.
                         
            FMatch_length := ZLibConst_MIN_MATCH - 1;
         end;
      end;
      //* If there was a match at the previous step and the current
      //*match is not better, output the previous match:
                 
      if (FPrev_length >= longword(ZLibConst_MIN_MATCH)) and 
         (FMatch_length <= FPrev_length) then begin
         FMax_insert := FStrstart + FLookahead - longword(ZLibConst_MIN_MATCH);
         //* Do not insert strings in hash table beyond self.
         //check_match for debug mode 
         //check_match(FStrstart - 1, FPrev_match, FPrev_length);

         //_tr_tally_dist(FStrstart - 1 - FPrev_match, FPrev_length - ZLibConst_MIN_MATCH, bflush);
         ////Console.WriteLine(' _tr_tally(begin0end;,begin1end;)',FStrstart - 1 - FPrev_match, FPrev_length - ZLibConst_MIN_MATCH);  
         bflush := FTree._tr_tally(FStrstart - 1 - FPrev_match, 
                                  FPrev_length - longword(ZLibConst_MIN_MATCH));
         ////Console.WriteLine(' bflush=begin0end;', bflush);  

         //* Insert in hash table all strings up to the end of the match.
         //*FStrstart-1 and FStrstart are already inserted. If there is not
         //*enough FLookahead, the last two strings are not inserted in
         //*the hash table.
                     
         FLookahead := FLookahead - (FPrev_length - 1);
         FPrev_length := FPrev_length - 2;

         repeat
            inc(FStrstart);
            if (FStrstart <= FMax_insert) then begin
               ////Console.WriteLine(' insert_string 2 (begin0end;,begin1end;) FIns_h=begin2end;',FStrstart, FHash_head, FIns_h);  
               FHash_head := insert_string(FStrstart, FHash_head);
               ////Console.WriteLine(' FHash_head:begin0end; FIns_h=begin1end;', FHash_head, FIns_h);  
            end;
            dec(FPrev_length);
         until not(FPrev_length <> 0);
         
         FMatch_available := false;
         FMatch_length := ZLibConst_MIN_MATCH - 1;
         inc(FStrstart);

         if (bflush) then begin
            //FLUSH_BLOCK(false)
            flush_block_only(false);
            if (FStrm.AvailableOut = 0) then begin 
               result := Block_State_need_more;
               exit;
            end;
         end;
      end 

      else if (FMatch_available) then begin
         //* If there was no match at the previous position, output a
         //*single literal. If there was a match but the current match
         //*is longer, truncate the previous match to a single literal.
                     

         //_tr_tally_lit(FWindow[FStrstart - 1], bflush);
         bflush := FTree._tr_tally(0, FWindow[FStrstart - 1]);

         if (bflush) then begin
            flush_block_only(false);
         end;
         inc(FStrstart);
         dec(FLookahead);
         if (FStrm.AvailableOut = 0) then begin
            result := Block_State_need_more;
            exit;
         end;
      end 
      else begin
         //* There is no previous match to compare with, wait for
         //*the next step to decide.
         
         FMatch_available := true;
         inc(FStrstart);
         dec(FLookahead);
      end;
   until false;

   if (FMatch_available) then begin
//      bflush := FTree._tr_tally(0, FWindow[FStrstart - 1]);
      FTree._tr_tally(0, FWindow[FStrstart - 1]);
      FMatch_available := false;
   end;

// FLUSH_BLOCK(flush = FlushMode_Z_FINISH);
   flush_block_only(flush = FlushMode_Z_FINISH);
   if (FStrm.AvailableOut = 0) then begin 
      if flush = FlushMode_Z_FINISH then begin
         result := Block_State_finish_started;
         exit;
      end
      else begin
         result := Block_State_need_more;
         exit;
      end;
   end;
   if (flush = FlushMode_Z_FINISH) then
      result := Block_State_finish_done
   else
      result := Block_State_block_done;
end;

procedure TDeflater.flush_pending(); 
Var len:longword;
begin

   len := FPending_buf.Pending;
   if (len > FStrm.AvailableOut) then len := FStrm.AvailableOut;
   if (len = 0) then exit;

   FPending_buf.CopyToStrmOut(FStrm, len);
end; 
       
function TDeflater.DeflateInit(
               z_stream:TZ_Stream; 
               FLevel:longint; 
               method:DeflateMethod; 
               windowBits, 
               memLevel:longint;
               strategy:CompressionStrategy):CompressionReturnCode;
Var FWrap:longint;
begin 
// Console.WriteLine('DeflateInit: windowBits=begin0end;', windowBits);
                
   FWrap := 1; 
   if not Assigned(z_stream) then begin
      result := CompressionReturnCode_Z_STREAM_ERROR;
      exit;
   end;
   FStrm := z_stream;
   FStrm.ErrorMessage := '';  


{$IFDEF FASTEST}
   if (FLevel <> 0) then FLevel := 1;
{$ELSE}
   if (FLevel = ord(CompressionLevel_Z_DEFAULT_COMPRESSION)) then begin
      FLevel := 6;
   end; 
{$ENDIF}
// Console.WriteLine('DeflateInit: windowBits=begin0end;', windowBits);
{$IFDEF GZIP}
   if (windowBits < 0) then begin //* suppress zlib wrapper
      FWrap := 0;
      windowBits := -windowBits;
   end
   else if (windowBits > 15) then begin
      FWrap := 2;       //* write gzip wrapper instead
      windowBits := - 16;
   end;
{$ELSE}
   if (windowBits < 0) then begin //* suppress zlib wrapper
      FWrap := 0;
      windowBits := -windowBits;
   end;
{$ENDIF}

   if (memLevel < 1) or 
         (memLevel > ZLibConst_MAX_MEM_LEVEL)  or 
             (method  <> DeflateMethod_Z_DEFLATED) or 
                 (windowBits < 8)                      or 
                     (windowBits > 15)                     or 
                        (FLevel < 0) or (FLevel > 9) then begin
      result := CompressionReturnCode_Z_STREAM_ERROR;
      exit;
   end;

   if (windowBits = 8) then windowBits := 9;  //* until 256-byte FWindow bug fixed

   self.FWrap   := FWrap;
   self.FW_bits := windowBits;
   self.FW_size := 1 shl self.FW_bits;
   self.FW_mask := self.FW_size - 1;

   self.FHash_bits := memLevel + 7;
   self.FHash_size := 1 shl self.FHash_bits;
   self.FHash_mask := self.FHash_size - 1;
   self.FHash_shift := longint(trunc((self.FHash_bits + ZLibConst_MIN_MATCH - 1) / ZLibConst_MIN_MATCH));


   self.FWindow := TArrByte.Create(self.FW_size * 2);
   setLength(self.FPrev, self.FW_size);
   setLength(self.FHead, self.FHash_size);

   self.FPending_buf := TPendingBuf.Create(longword(1 shl (memLevel + 6))); //* 16K elements by default

   self.FLevel := FLevel;
   self.FStrategy := strategy;
   self.FMethod := byte(method);

   ArrayByteClear(FWindow, 0, FWindow.Length);
//Console.WriteLine(self.ToString());
   result := DeflateReset();
end;

function TDeflater.DeflateReset():CompressionReturnCode; 
Var ArrNull:TArrByte;
begin
   ArrNull := nil;

   if not Assigned(FStrm) then begin
      result := CompressionReturnCode_Z_STREAM_ERROR;
      exit;
   end;

   FStrm.Reset();

   FPending_buf.Reset();

   if (FWrap < 0) then begin
      FWrap := -FWrap; //* was made negative by deflate(..., Z_FINISH);
   end;

   if FWrap > 0 then
      FStatus := StreamStatus_INIT_STATE
   else
      FStatus := StreamStatus_BUSY_STATE;
//                Console.WriteLine('DeflateReset: FWrap=begin0end; FStatus:begin1end;', FWrap, FStatus);
{$IFDEF GZIP}
   if FWrap = 2 then
      FStrm.FAdler := Adler32_crc32(0, ArrNull, 0, 0)
   else
      FStrm.FAdler := Adler32_adler32(0, ArrNull, 0, 0);
{$ELSE}
   FStrm.FAdler := Adler32_adler32(0, ArrNull, 0, 0);
{$ENDIF}

   FLast_flush := FlushMode_Z_NO_FLUSH;

   FTree :=  TTree.Create(FPending_buf);

   lm_init();

   result := CompressionReturnCode_Z_OK;
end;


//* ===========================================================================
//*Initialize the 'longest match' routines for a new zlib stream
         
procedure TDeflater.lm_init();
begin
   FWindow_size := longword(2 * FW_size);
   ArraySmallintClear(FHead, 0, FHash_size);

   //* Set the default configuration parameters:
             
   FMax_lazy_match   := ZLibConst_configuration_table[FLevel].FMax_lazy;
   FGood_match       := ZLibConst_configuration_table[FLevel].FGood_length;
   FNice_match       := longword(ZLibConst_configuration_table[FLevel].FNice_length);
   FMax_chain_length := ZLibConst_configuration_table[FLevel].FMax_chain;

   FStrstart := 0;
   FBlock_start := 0;
   FLookahead := 0;
   FMatch_length := ZLibConst_MIN_MATCH - 1;
   FPrev_length := ZLibConst_MIN_MATCH - 1;
   FMatch_available := false;
   FIns_h := 0;
end;

//* ===========================================================================
//*Set FMatch_start to the longest match starting at the given string and
//*result := its length. Matches shorter or equal to FPrev_length are discarded,
//*in which case the result is equal to FPrev_length and FMatch_start is
//*garbage.
//*IN assertions: cur_match is the FHead of the hash chain for the current
//*  string (FStrstart) and its distance is <= MAX_DIST, and FPrev_length >= 1
//*OUT assertion: the match length is not greater than s->FLookahead.
         
function TDeflater.longest_match(cur_match:longword):longword; 
Var chain_length,       //* max hash chain length
    scan,               //* current string (index for FWindow)*/
    match,              //* matched string (index for FWindow)*/
    len,                //* length of current match
    best_len,           //* best match length so far
    _FNice_match,         //* stop if match long enough
    limit,
    wmask,
    strend:longword;     //index for FWindow
    scan_end1, scan_end:byte;
    lb_break:boolean;
    i:longint;
label l;
begin
   chain_length := FMax_chain_length;
   scan := FStrstart;            
   best_len := FPrev_length;     
   _FNice_match := self.FNice_match;

   //MAX_DIST := FW_size - ZLibConst_MIN_LOOKAHEAD;
   if FStrstart > longword(FW_size - ZLibConst_MIN_LOOKAHEAD) then
      limit := longword(FStrstart - longword(FW_size - ZLibConst_MIN_LOOKAHEAD))
   else
      limit := longword(0);
   //* Stop when cur_match becomes <= limit. To simplify the code,
   //*we prevent matches with the string of FWindow index 0.
             
   //int FPrev := 0; //*index for short[] self.FPrev*/
   wmask := longword(FW_mask);
   strend := (FStrstart + longword(ZLibConst_MAX_MATCH)); //index for FWindow
   scan_end1 := FWindow[scan + best_len - 1];
   scan_end  := FWindow[scan + best_len];
   //* The code is optimized for HASH_BITS >= 8 and MAX_MATCH-2 multiple of 16.
   //*It is easy to get rid of this optimization if necessary.
             
   //Debug.Assert(FHash_bits >= 8 and ZLibConst_MAX_MATCH = 258, 'Code too clever');

   //* Do not waste too much time if we already have a good match:
   if (FPrev_length >= FGood_match) then begin
      chain_length := chain_length shr 2;
   end;
   //* Do not look for matches beyond the end of the input. This is necessary
   //*to make deflate deterministic.
             
   if (_FNice_match > FLookahead) then _FNice_match := FLookahead;

   repeat
      match := cur_match;
      //           Debug.Assert(cur_match < FStrstart, 'no future');
      //* Skip to next match if the match length cannot increase
      //*or if the match length is less than 2.  Note that the checks below
      //*for insufficient FLookahead only occur occasionally for performance
      //*reasons.  Therefore uninitialized memory will be accessed, and
      //*conditional jumps will be made that depend on those values.
      //*However the length of the match is limited to the FLookahead, so
      //*the output of deflate is not affected by the uninitialized values.
                 
      //Console.WriteLine('do 3 match:begin0end; best_len:begin1end; scan:begin2end;', match, best_len, scan);

      if (FWindow[match + best_len] <> scan_end) or 
            (FWindow[match + best_len - 1] <> scan_end1) or 
               (FWindow[match] <> FWindow[scan]) then begin
         goto l;//continue;
      end
      else
         inc(match);
      if (FWindow[match] <> FWindow[scan + 1]) then goto l;//continue; 
      //* The check at best_len-1 can be removed because it will be made
      //*again later. (This heuristic is not always a win.)
      //*It is not necessary to compare scan[2] and match[2] since they
      //*are always equal when the other bytes match, given that
      //*the hash keys are equal and that HASH_BITS >= 8.
                 
      scan := scan + 2;
      match := match + 1;
      //Debug.Assert(FWindow[scan] = FWindow[match], 'match[2]?');

      //* We check for insufficient FLookahead only every 8th comparison;
      //*the 256th check will be made at FStrstart+258.
                 
      //Console.WriteLine('do 4');
      lb_break := false;
      repeat
         for i := 1 to 8 do begin
            inc(scan); inc(match);
            if FWindow[scan] <> FWindow[match] then begin
               lb_break := true;
               break;
            end;
         end;
      until (scan >= strend) or lb_break;

      len := longword(ZLibConst_MAX_MATCH) - (strend - scan);
      scan := strend - longword(ZLibConst_MAX_MATCH);

      if (len > best_len) then begin
         FMatch_start := cur_match;
         best_len := len;
         if (len >= _FNice_match) then break;
         scan_end1 := FWindow[scan + best_len - 1];
         scan_end  := FWindow[scan + best_len];
      end;
l:
      cur_match := word(FPrev[cur_match and wmask]);
      if not(cur_match > limit) then break;
      dec(chain_length);
   until not(chain_length <> 0);

   if (longword(best_len) <= FLookahead) then 
      result := longword(best_len)
   else
      result := FLookahead;
end;

//* ---------------------------------------------------------------------------
//*Optimized version for FLevel = 1 or FStrategy = Z_RLE only
         
function TDeflater.longest_FMatch_fast(cur_match:longword):longword; 
Var scan,           //* current string (index for FWindow)*/
   match,           //* matched string (index for FWindow)*/
   len,             //* length of current match
   strend:longword; //index for FWindow
   lb_break:boolean;
   i:longint;
begin
   scan := FStrstart;
   strend := FStrstart + longword(ZLibConst_MAX_MATCH);

   //* The code is optimized for HASH_BITS >= 8 and MAX_MATCH-2 multiple of 16.
   //*It is easy to get rid of this optimization if necessary.
             
   //Debug.Assert(FHash_bits >= 8 and ZLibConst_MAX_MATCH = 258, 'Code too clever');

   //Debug.Assert(FStrstart <= FWindow_size - ZLibConst_MIN_LOOKAHEAD, 'need FLookahead');

   //         Debug.Assert(cur_match < FStrstart, 'no future');

   match := cur_match;

   //* result := failure if the match length is less than 2:
             
   if (FWindow[match] <> FWindow[scan]) or 
         (FWindow[match + 1] <> FWindow[scan + 1]) then begin
      result := ZLibConst_MIN_MATCH - 1;
      exit;
   end;

   //* The check at best_len-1 can be removed because it will be made
   //*again later. (This heuristic is not always a win.)
   //*It is not necessary to compare scan[2] and match[2] since they
   //*are always equal when the other bytes match, given that
   //*the hash keys are equal and that HASH_BITS >= 8.
             
   scan := scan + 2; 
   match := match + 2;

   //* We check for insufficient FLookahead only every 8th comparison;
   //*the 256th check will be made at FStrstart+258.
   lb_break := false;
   repeat
      for i := 1 to 8 do begin
         inc(scan); inc(match);
         if FWindow[scan] <> FWindow[match] then begin
            lb_break := true;
            break;
         end;
      end;
   until (scan >= strend) or lb_break;

   len := longword(ZLibConst_MAX_MATCH) - (strend - scan);

   if (len < longword(ZLibConst_MIN_MATCH)) then
      result := ZLibConst_MIN_MATCH - 1
   else begin
      FMatch_start := cur_match;
      if len <= FLookahead then
         result := len
      else
         result := FLookahead;
   end;
end;
          
end.
