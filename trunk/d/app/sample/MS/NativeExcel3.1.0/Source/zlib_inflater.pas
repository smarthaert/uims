//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         zlib_inflater
//
//      Description:  Inflater
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

unit zlib_inflater;
{$Q-}
{$R-}

//{$DEFINE GUNZIP}
//{$DEFINE INFLATE_STRICT}

interface

uses sysutils, zlib_deftype, zlib_const, zlib_z_stream, zlib_code, 
      zlib_inflateregister, zlib_mapped_arr, zlib_adler32, 
      zlib_gz_header, zlib_inf_trees;
type
   //InfLeave = class(Exception);

   TInflater = class
   private

      FStrm:TZ_Stream;

      FMode:InflateMode; //* current inflate FMode */
      FLast:boolean;        //* true if processing FLast block */
      FWrap:longint;        //* bit 0 true for zlib, bit 1 true for gzip */
      FHavedict:boolean;    //* true if dictionary provided */
{$IFDEF GUNZIP}
      FFlags:longint;       //* gzip header method and FFlags (0 if zlib) */
{$ENDIF}
      FDmax:longword;        //* zlib header max distance (INFLATE_STRICT) */
      FCheck:longword;      //* protected copy of FCheck value */
      FTotal:longword;      //* protected copy of output count */
      FHead:TGZ_header;   //* where to save gzip FHeader information */

      //* sliding window */
      FWbits:longword;       //* log base 2 of requested window size */
      FWsize:longword;       //* window size or zero if not using window */
      FWhave:longword;       //* valid bytes in the window */
      FWrite:longword;       //* FWindow FWrite index */
      FWindow:TArrByte;    //* allocated sliding FWindow, if needed */
      FOffset:longword;      //* distance back to copy string from */
       
        //* for table and code decoding */
      FExtra:longword;       //* FExtra Fbits needed */

      //* fixed and dynamic code tables */
      FLencode:TCodes;     //* starting table for length/literal codes */
      FDistcode:TCodes;    //* starting table for distance codes */
      FLenbits:longword;      //* index Fbits for FLencode */
      FDistbits:longword;     //* index Fbits for FDistcode */

      //* dynamic table building */
      FNcode:longword;       //* number of code length code lengths */
      FNlen:longword;        //* number of length code lengths */
      FNdist:longword;       //* number of distance code lengths */
      FHave:longword;        //* number of code lengths in lens[] */

      FNext:longword;    //* FNext available space in codes[] */
      FLens:TArrWord;    //* temporary storage for code lengths */
      FWork:TArrWord;    //* FWork area for code table building */
      FCodes:TCodes;   //* space for code tables */

{$IFDEF GUNZIP}
      //* buffer for gzip FHeader crc calculation */ 
      FHbuf:TArrByte;
{$ENDIF}

      function InflateInit(z_stream:TZ_Stream; 
                              WindowBits:longint):CompressionReturnCode;
      function inflateReset():CompressionReturnCode;
      function UPDATE(adler:longword; buf:TArrByte; offset, len:longword):longword;
{$IFDEF GUNZIP}
      function CRC2(FCheck:longword; aword:word):longword;
      function CRC4(FCheck:longword; aword:longword):longword;
{$ENDIF}
      procedure fixedtables();
      function REVERSE(q:longword):longword;
      function updateFWindow(a_out:longword):longint;
      procedure inflate_fast(start:longword);
   public
      //* bit accumulator */
      FHold:longword;       //* input bit accumulator */
      Fbits:longword;       //* number of Fbits in 'in' */

      //* for string and stored block copying */
      FLength:longword;      //* literal or FLength of data to copy */

      constructor Create(z_stream:TZ_Stream; WindowBits:longint);
      destructor Destroy;override;

      function Inflate(flush:FlushMode):CompressionReturnCode;
//      function ToString():string;
   end;

Var 
   //* permutation of code FLengths */
   order:TArrWord;

implementation

constructor TInflater.Create(z_stream:TZ_Stream; WindowBits:longint);
Var res:CompressionReturnCode;
    ArrNull:TArrWord;
begin
   inherited Create;
   setLength(ArrNull, 0);
{$IFDEF GUNZIP}
   setLength(FHbuf, 4);
{$ENDIF}
   setLength(FLens, 320);
   setLength(FWork, 288);
   FCodes := TCodes.Create(ZLibConst_ENOUGH);  
   FLencode := TCodes.Create(ArrNull, 0);
   FDistcode := TCodes.Create(ArrNull, 0);
   res := InflateInit(z_stream, WindowBits);
   if (res <> CompressionReturnCode_Z_OK) then 
      raise Exception.Create('Inflater initialization error');
end; 

destructor TInflater.Destroy;
begin
  FCodes.Free;
  FLencode.Free;
  FDistcode.Free;
  FWindow.Free;
end;


function TInflater.InflateInit(z_stream:TZ_Stream; 
                              WindowBits:longint):CompressionReturnCode;
begin 

      if not Assigned(z_stream) then begin
         result := CompressionReturnCode_Z_STREAM_ERROR;
         exit;
      end;
      FStrm := z_stream;
      FStrm.ErrorMessage := '';  

      //Trace.WriteLine('inflate: allocated');

      if (WindowBits < 0) then begin
         FWrap := 0;
         WindowBits := -WindowBits;
      end
      else begin
         FWrap := (WindowBits shr 4) + 1;
{$IFDEF GUNZIP}
         if (WindowBits < 48) then WindowBits := WindowBits and 15;
{$ENDIF}
      end;
      if (WindowBits < 8) or (WindowBits > 15) then begin
         result := CompressionReturnCode_Z_STREAM_ERROR;
         exit;
      end;
      FWbits := longword(WindowBits);
      FWindow := nil;
      result := inflateReset();
end;

function TInflater.inflateReset():CompressionReturnCode;
begin

    if not Assigned(FStrm) then begin
       result := CompressionReturnCode_Z_STREAM_ERROR;
       exit;
    end;
    FStrm.Reset();
//*!!!!!*/    FStrm.adler := 1;        //* to support ill-conceived Java test suite */

    FTotal := 0;
    FMode  := InflateMode_HEAD; 
    FLast := false;
    FHavedict := false;
    FDmax := 32768;
    FHead := nil;
    FWsize := 0;
    FWhave := 0;
    FWrite := 0;
    FHold := 0;
    Fbits := 0;

    FNext := 0;
//    if Assigned(FLencode) then FLencode.Free;
//    FLencode := TCodes.Create(FCodes, FNext);
    FLencode.Assign(FCodes, FNext);
//    if Assigned(FDistcode) then FDistcode.Free;
//    FDistcode := TCodes.Create(FCodes, FNext);
    FDistcode.Assign(FCodes, FNext);
    //Trace.WriteLine('inflate: reset');
    result := CompressionReturnCode_Z_OK;
end;

//* FCheck function to use adler32() for zlib or crc32() for gzip */
function TInflater.UPDATE(adler:longword; buf:TArrByte; offset, len:longword):longword;
begin
{$IFDEF GUNZIP}
   if FFlags > 0 then 
      result := Adler32_crc32(adler, buf, offset, len)
   else
      result := Adler32_adler32(adler, buf, offset, len);
{$ELSE}
   result := Adler32_adler32(adler, buf, offset, len);
{$ENDIF}
end; 


//* FCheck macros for FHeader crc */
{$IFDEF GUNZIP}

function TInflater.CRC2(FCheck:longword; aword:word):longword;
begin 
    FHbuf[0] := byte(aword);
    FHbuf[1] := byte(aword shr 8);
    result := Adler32_crc32(FCheck, FHbuf, 0, 2); 
end; 

function TInflater.CRC4(FCheck:longword; aword:longword):longword;
begin 
    FHbuf[0] := byte(aword);
    FHbuf[1] := byte(aword shr 8);
    FHbuf[2] := byte(aword shr 16);
    FHbuf[3] := byte(aword shr 24);
    result := Adler32_crc32(FCheck, FHbuf, 0, 4); 
end; 
{$ENDIF}


{/*
   Return state with FLength and distance decoding tables and index sizes set to
   fixed code decoding.  Normally this returns fixed tables from inffixed.h.
   If BUILDFIXED is defined, then instead this routine builds the tables the
   first time it's called, and returns those tables the first time and
   thereafter.  This reduces the size of the code by about 2K bytes, in
   exchange for a little execution time.  However, BUILDFIXED should not be
   used for threaded applications, since the rewriting of the tables and virgin
   may not be thread-safe.
 */}
procedure TInflater.fixedtables();
begin
//    if Assigned(FLencode) then FLencode.Free;
//    FLencode := TCodes.Create(Code_lenfix, 0);
    FLencode.Assign(Code_lenfix, 0);    
    FLenbits := 9;
//    if Assigned(FDistcode) then FDistcode.Free;
//    FDistcode := TCodes.Create(Code_distfix, 0);
    FDistcode.Assign(Code_distfix, 0);
    FDistbits := 5;
end;



//* Reverse the bytes in a 32-bit value */
function TInflater.REVERSE(q:longword):longword;
begin
   result := ((q shr 24) and $ff) or ((q shr 8) and $ff00) or
   ((q and $ff00) shl 8) or ((q and $ff) shl 24);
end;

{/*
   Update the FWindow with the FLast FWsize (normally 32K) bytes written before
   returning.  If FWindow does not exist yet, create it.  This is only called
   when a FWindow is already in use, or when output has been written during this
   inflate call, but the end of the deflate stream has not been reached yet.
   It is also called to create a FWindow for dictionary data when a dictionary
   is loaded.

   Providing output buffers larger than 32K to inflate() should provide a speed
   advantage, since only the FLast 32K of output is copied to the sliding FWindow
   upon return from inflate(), and since all distances after the first 32K of
   output will fall in the output data, making match copies simpler and faster.
   The advantage may be dependent on the size of the processor's data caches.
 */}
function TInflater.updateFWindow(a_out:longword):longint;
Var copy, dist:longword;
begin

   //* if it hasn't been done already, allocate space for the FWindow */
   if not Assigned(FWindow) then begin
      FWindow := TArrByte.Create(1 shl longint(FWbits));
      if not Assigned(FWindow) then begin
         result := 1;
         exit;
      end;
   end;

   //* if FWindow not in use yet, initialize */
   if (FWsize = 0) then begin
      FWsize := longword(1) shl longint(FWbits);
      FWrite := 0;
      FWhave := 0;
   end;

    //* copy FWsize or less output bytes into the circular FWindow */
    copy := a_out - FStrm.AvailableOut;
    if (copy >= FWsize) then begin
        FStrm.read_from_out_buf(FStrm.NextOut - FWsize, FWindow, 0, FWsize);
        FWrite := 0;
        FWhave := FWsize;
    end
    else begin
        dist := FWsize - FWrite;
        if (dist > copy) then dist := copy;
        FStrm.read_from_out_buf(FStrm.NextOut - copy, FWindow, FWrite, dist);
        copy := copy - dist;
        if (copy > 0) then begin
           FStrm.read_from_out_buf(FStrm.NextOut - copy, FWindow, 0, copy);
           FWrite := copy;
           FWhave := FWsize;
        end
        else begin
           FWrite := FWrite + dist;
           if (FWrite = FWsize) then FWrite := 0;
           if (FWhave < FWsize) then FWhave := FWhave + dist;
        end;
    end;
    result := 0;
end;



{/*
 inflate() uses a state machine to process as much input data and generate as
 much output data as possible before returning.  The state machine is
 structured roughly as follows:

  for (;;) switch (state) then begin
  ...
  case STATEn:
      if (not enough input data or output space to make progress)
 return;
      ... make progress ...
      state := STATEm;
      break;
  ...
  end;

 so when inflate() is called again, the same case is attempted again, and
 if the appropriate resources are provided, the machine proceeds to the
 FNext state.  The NEEDBITS() macro is usually the way the state evaluates
 whether it can proceed or should return.  NEEDBITS() does the return if
 the requested Fbits are not available.  The typical use of the BITS macros
 is:

      NEEDBITS(n);
      ... do something with BITS(n) ...
      DROPBITS(n);

 where NEEDBITS(n) either returns from inflate() if there isn't enough
 input FLeft to load n Fbits into the accumulator, or it continues.  BITS(n)
 gives the low n Fbits in the accumulator.  When done, DROPBITS(n) drops
 the low n Fbits off the accumulator.  INITBITS() clears the accumulator
 and sets the number of available Fbits to zero.  BYTEBITS() discards just
 enough Fbits to FPut the accumulator on a byte boundary.  After BYTEBITS()
 and a NEEDBITS(8), then BITS(8) would return the FNext byte in the stream.

 NEEDBITS(n) uses PULLBYTE() to get an available byte of input, or to return
 if there is no input available.  The decoding of variable FLength FCodes uses
 PULLBYTE() directly in order to pull just enough bytes to decode the FNext
 code, and no more.

 Some states loop until they get enough input, making sure that enough
 state information is maintained to continue the loop where it FLeft off
 if NEEDBITS() returns in the loop.  For example, want, need, and keep
 would all FHave to actually be part of the saved state in case NEEDBITS()
 returns:

  case STATEw:
      while (want < need) then begin
 NEEDBITS(n);
 keep[want++] := BITS(n);
 DROPBITS(n);
      end;
      state := STATEx;
  case STATEx:

 As shown above, if the FNext state is also the FNext case, then the break
 is omitted.

 A state may also return if there is not enough output space available to
 complete that state.  Those states are copying stored data, writing a
 literal byte, and copying a matching string.

 When returning, a 'goto inf_leave' is used to update the FTotal counters,
 update the FCheck value, and determine whether any progress has been made
 during that inflate() call in order to return the proper return code.
 Progress is defined as a change in either FStrm->avail_in or FStrm->avail_out.
 When there is a FWindow, goto inf_leave will update the FWindow with the FLast
 output written.  If a goto inf_leave occurs in the middle of decompression
 and there is no FWindow currently, goto inf_leave will create one and copy
 output to the FWindow for the FNext call of inflate().

 In this implementation, the flush parameter of inflate() only affects the
 return code (per zlib.h).  inflate() always FWrites as much as possible to
 FStrm->next_out, given the space available and the provided input--the effect
 documented in zlib.h of Z_SYNC_FLUSH.  Furthermore, inflate() always defers
 the allocation of and copying into a sliding FWindow until necessary, which
 provides the effect documented in zlib.h for Z_FINISH when the entire input
 stream available.  So the only thing the flush parameter actually does is:
 when flush is set to Z_FINISH, inflate() cannot return Z_OK.  Instead it
 will return Z_BUF_ERROR if it has not reached the end of the stream.
*/}

function TInflater.Inflate(flush:FlushMode):CompressionReturnCode;
Var  l_in, l_out:longword;     //* save starting available input and output */
   reg:TInflateRegister;
   len:longword;     //* FLength to copy for repeats, Fbits to drop */
   copy:longword;    //* number of stored or match bytes to copy */
   l_this:TCode;      //* current decoding table entry */
   l_FLast:TCode;      //* parent table entry */
   from:Tmapped_arr;
   ret:CompressionReturnCode;
   ex: boolean;
//   _n:longint;
   ArrNull:TArrByte;
begin
   reg := nil;
   from := nil;
try
   ArrNull := nil;
   reg := TInflateRegister.Create();
   from := TMapped_arr.Create(ArrNull, 0);
   copy := 0; // warning compile
   len := 0; // warning compile

   if not Assigned(FStrm) then begin
      result := CompressionReturnCode_Z_STREAM_ERROR;
      exit;
   end;

   if not (FStrm.CheckBuffer()) then begin
      result := CompressionReturnCode_Z_STREAM_ERROR;
      exit;
   end;

   if (FMode = InflateMode_TYPE) then FMode := InflateMode_TYPEDO;  //* skip FCheck */

   //LOAD
   FStrm.LoadToInflateRegister(reg);

   l_in  := reg.FHave;
   l_out := reg.FLeft;

   ret := CompressionReturnCode_Z_OK;
   repeat
      case FMode of 

         InflateMode_HEAD: begin
            if (FWrap = 0) then begin
               FMode := InflateMode_TYPEDO;
               continue;
            end;
            if not(FStrm.NEEDBITS(16, reg)) then break;
{$IFDEF GUNZIP}
            if (((FWrap and 2) > 0) and (FHold = $8b1f)) then begin  //* gzip FHeader */
               FCheck := Adler32_crc32(0, nil, 0, 0);
               FCheck := CRC2(FCheck, word(FHold));
               reg.INITBITS();
               FMode := InflateMode_FLAGS;
               continue;
            end;
            FFlags := 0;  //* expect zlib FHeader */
            if Assigned(FHead) then FHead.done := -1;
            if (((FWrap and 1) = 0) or   //* FCheck if zlib FHeader allowed */
{$ELSE}
            if (
{$ENDIF}
                 ((((reg.BITS(8) shl 8) + (reg.FHold shr 8)) mod 31) > 0)) then begin
               FStrm.ErrorMessage := 'incorrect FHeader FCheck';
               FMode := InflateMode_BAD;
               continue;
            end;

            if (reg.BITS(4) <> longword(DeflateMethod_Z_DEFLATED)) then begin
               FStrm.ErrorMessage := 'unknown compression method';
               FMode := InflateMode_BAD;
               continue;
            end;
            reg.DROPBITS(4);
            len := reg.BITS(4) + 8;
            if (len > FWbits) then begin
               FStrm.ErrorMessage := 'invalid FWindow size';
               FMode := InflateMode_BAD;
               continue;
            end;

            
            FDmax := longword(1) shl longint(len);
             //Trace.WriteLine('inflate:   zlib FHeader ok');
            FStrm.FAdler := Adler32_adler32(0, nil, 0, 0);
            FCheck := Adler32_adler32(0, nil, 0, 0);
            if (reg.FHold and $200) > 0 then
               FMode := InflateMode_DICTID
            else
               FMode := InflateMode_TYPE;
            //Console.WriteLine('FMode: begin0end;', FMode); 
            reg.INITBITS();
         end;
{$IFDEF GUNZIP}

         InflateMode_FLAGS: begin
            if not(FStrm.NEEDBITS(16, reg)) then break;
            FFlags := longint(reg.FHold);
            if ((FFlags and $ff) <> longint(DeflateMethod_Z_DEFLATED)) then begin
                FStrm.ErrorMessage := 'unknown compression method';
                FMode := InflateMode_BAD;
                continue;
            end;
            if ((FFlags and $e000) > 0) then begin
                FStrm.ErrorMessage := 'unknown FHeader FFlags set';
                FMode := InflateMode_BAD;
                continue;
            end;
            if Assigned(FHead) then FHead.text := longint((reg.FHold shr 8) and 1);
            if ((FFlags and $0200) > 0) then FCheck := CRC2(FCheck, word(reg.FHold));
            reg.INITBITS();
            FMode := InflateMode_TIME;
            continue; //goto InflateMode_TIME;
         end;

         InflateMode_TIME: begin
            if not(FStrm.NEEDBITS(32, reg)) then break;
            if Assigned(FHead) then FHead.time := FHold;
            if ((FFlags and $0200) > 0) then FCheck := CRC4(FCheck, longword(reg.FHold));
            reg.INITBITS();
            FMode := InflateMode_OS;
            continue; //goto InflateMode_OS;
         end;

         InflateMode_OS: begin
            if not(FStrm.NEEDBITS(16, reg)) then break;
            if Assigned(FHead) then begin
                FHead.xFFlags := longint(reg.FHold and $ff);
                FHead.os := longint(reg.FHold shr 8);
            end;
            if ((FFlags and $0200) > 0) then FCheck := CRC2(FCheck, word(reg.FHold));
            reg.INITBITS();
            FMode := InflateMode_EXLEN;
            continue; //goto InflateMode_EXLEN;
         end;

         InflateMode_EXLEN: begin
            if ((FFlags and $0400) > 0) then begin
               if not(FStrm.NEEDBITS(16, reg)) then break;
                FLength := longword(reg.FHold);
                if Assigned(FHead) then FHead.extra_len := longword(reg.FHold);
                if ((FFlags and $0200) > 0) then FCheck := CRC2(FCheck, word(reg.FHold));
                reg.INITBITS();
            end
            else 
               if Assigned(FHead) then FHead.FExtra := nil;
            FMode := InflateMode_EXTRA;
            continue; //goto InflateMode_EXTRA;
         end;

         InflateMode_EXTRA: begin
            if ((FFlags and $0400) > 0) then begin
               copy := FLength;
               if (copy > reg.FHave) then copy := reg.FHave;
               if (copy > 0) then begin
                  if Assigned(FHead) then
                     if (FHead.FExtra <> nil) then begin
                        len := FHead.extra_len - FLength;
                        if (len + copy) > FHead.extra_max then
                           ArrayCopy(reg.FNext.Buffer, reg.FNext.Offset, 
                              FHead.FExtra, len, FHead.extra_max - len)
                        else
                           ArrayCopy(reg.FNext.Buffer, reg.FNext.Offset, 
                              FHead.FExtra, len, copy);
                        end;
                  if ((FFlags and $0200) > 0) then FCheck := Adler32_crc32(FCheck, reg.FNext.Buffer, longword(reg.FNext.Offset), copy);
                  reg.FHave := reg.FHave - copy;
                  reg.FNext.Offset := reg.FNext.Offset + longint(copy);
                  FLength := FLength - copy;
               end;
               if (FLength > 0) then break;
            end;
            self.FLength := 0;
            FMode := InflateMode_NAME;
            continue; //goto InflateMode_NAME;
         end;

         InflateMode_NAME: begin
            if ((FFlags and $0800) > 0) then begin
               if (reg.FHave = 0) then break;
               copy := 0;
               repeat
                  len := longword(reg.FNext[longint(copy)]);
                  inc(copy);
                  if Assigned(FHead) then
                     if (FHead.name <> nil) and (FLength < FHead.name_max) then begin
                        FHead.name[FLength] := byte(len);
                        inc(FLength);
                     end;
               until not ((len > 0) and (copy < reg.FHave));
               if ((FFlags and $0200) > 0) then 
                    FCheck := Adler32_crc32(FCheck, reg.FNext.Buffer, longword(reg.FNext.Offset), copy);
               reg.FHave := reg.FHave - copy;
               reg.FNext.Offset := reg.FNext.Offset + longint(copy);
               if (len > 0) then break;
            end
            else 
               if Assigned(FHead) then FHead.name := nil;
            FLength := 0;
            FMode := InflateMode_COMMENT;
            continue; //goto InflateMode_COMMENT;
         end;

         InflateMode_COMMENT: begin
            if ((FFlags and $1000) > 0) then begin
               if (reg.FHave = 0) then break;
               copy := 0;
               repeat
                  len := longword(reg.FNext[longint(copy)]);
                  inc(copy);
                  if Assigned(FHead) then
                     if (FHead.comment <> nil) and (FLength < FHead.comm_max) then begin
                        FHead.comment[FLength] := byte(len);
                        inc(FLength);
                     end;
               until not ((len > 0) and (copy < reg.FHave));
               if ((FFlags and $0200) > 0) then
                    FCheck := Adler32_crc32(FCheck, reg.FNext.Buffer, longword(reg.FNext.Offset), copy);
               reg.FHave := reg.FHave - copy;
               reg.FNext.Offset := reg.FNext.Offset + longint(copy);
               if (len > 0) then break;
            end
            else 
               if Assigned(FHead) then FHead.comment := nil;
            FMode := InflateMode_HCRC;
            continue; //goto InflateMode_HCRC;
         end;

         InflateMode_HCRC: begin
            if ((FFlags and $0200) > 0) then begin
               if not(FStrm.NEEDBITS(16, reg)) then break;
               if (reg.FHold <> (FCheck and $ffff)) then begin
                  FStrm.ErrorMessage := 'FHeader crc mismatch';
                  FMode := InflateMode_BAD;
                  continue;
               end;
               reg.INITBITS();
            end;
            if Assigned(FHead) then begin
               FHead.hcrc := longint((FFlags shr 9) and 1);
               FHead.done := 1;
            end;
            FStrm.FAdler := Adler32_crc32(0, ArrNull, 0, 0);
            FCheck := Adler32_crc32(0, ArrNull, 0, 0);
            FMode := InflateMode_TYPE;
            continue;
         end;
{$ENDIF}

         InflateMode_DICTID: begin
            if not(FStrm.NEEDBITS(32, reg)) then break;
            FStrm.FAdler := REVERSE(reg.FHold);
            FCheck := REVERSE(reg.FHold);
            reg.INITBITS();
            FMode := InflateMode_DICT;
            continue; //goto InflateMode_DICTID;
         end;

         InflateMode_DICT: begin
            if not (FHavedict) then begin
               FStrm.RestoreFromInflateRegister(reg); 
               result := CompressionReturnCode_Z_NEED_DICT;
               exit;
            end;
            FStrm.FAdler := Adler32_adler32(0, ArrNull, 0, 0);
            FCheck := Adler32_adler32(0, ArrNull, 0, 0);
            FMode := InflateMode_TYPE;
            continue; //goto InflateMode_TYPE;
         end;

         InflateMode_TYPE: begin
            if (flush = FlushMode_Z_BLOCK) then break;
            FMode := InflateMode_TYPEDO;
            continue; //goto InflateMode_TYPEDO;
         end;

         InflateMode_TYPEDO: begin
            if (FLast) then begin
               reg.BYTEBITS();
               FMode := InflateMode_CHECK;
               continue;
            end;
            if not(FStrm.NEEDBITS(3, reg)) then break;
            FLast := (reg.BITS(1) > 0);
            reg.DROPBITS(1);
            case (reg.BITS(2)) of
               0:  //* stored block */
                //Trace.WriteLine(String.Format('inflate:     stored blockbegin0end;',
                //        FLast ? ' (FLast)' : ''));
                FMode := InflateMode_STORED;
               1: begin //* fixed block */ 
                  fixedtables();
                //Trace.WriteLine(String.Format('inflate:     fixed FCodes blockbegin0end;',
                //       FLast ? ' (FLast)' : ''));
                  FMode := InflateMode_LEN;     //* decode FCodes */
                end;
               2:  //* dynamic block */
                //Trace.WriteLine(String.Format('inflate:     dynamic FCodes blockbegin0end;',
                //       FLast ? ' (FLast)' : ''));
                  FMode := InflateMode_TABLE;
               3: begin
                  FStrm.ErrorMessage := 'invalid block type';
                  FMode := InflateMode_BAD;
                end;
            end;
            reg.DROPBITS(2);
            continue;
         end;

         InflateMode_STORED: begin
            reg.BYTEBITS();        //* go to byte boundary */
            if not(FStrm.NEEDBITS(32, reg)) then break;
            if ((reg.FHold and $ffff) <> ((reg.FHold shr 16) xor $ffff)) then begin
               FStrm.ErrorMessage := 'invalid stored block FLengths';
               FMode := InflateMode_BAD;
               continue;
            end;
            FLength := longword(reg.FHold and $ffff);
            //Trace.WriteLine(String.Format('inflate:       stored FLength begin0end;', FLength));
            reg.INITBITS();
            FMode := InflateMode_COPY;
            continue; //goto InflateMode_COPY;
         end;

         InflateMode_COPY: begin
            copy := self.FLength;
            if (copy > 0) then begin
               if (copy > reg.FHave) then copy := reg.FHave;
               if (copy > reg.FLeft) then copy := reg.FLeft;
               if (copy = 0) then break;
            
               FStrm.Copy(reg, copy);
               continue;
            end;
            //Trace.WriteLine('inflate:       stored end');
            FMode := InflateMode_TYPE;
            continue;
         end;

         InflateMode_TABLE: begin
            if not(FStrm.NEEDBITS(14, reg)) then break;
            self.FNlen := reg.BITS(5) + 257;
            reg.DROPBITS(5);
            self.FNdist := reg.BITS(5) + 1;
            reg.DROPBITS(5);
            self.FNcode := reg.BITS(4) + 4;
            reg.DROPBITS(4);
            {$IFNDEF PKZIP_BUG_WORKAROUND}
            if (self.FNlen > 286) or (self.FNdist > 30) then begin
                FStrm.ErrorMessage := 'too many FLength or distance symbols';
                FMode := InflateMode_BAD;
                continue;
            end;
            {$ENDIF}
            //Trace.WriteLine('inflate:       table sizes ok');
            self.FHave := 0;
            self.FMode := InflateMode_LENLENS;
            continue; //goto InflateMode_LENLENS;
         end;

         InflateMode_LENLENS: begin
            ex := false;
            while (self.FHave < self.FNcode) do begin
               if not(FStrm.NEEDBITS(3, reg)) then begin
                  ex := true;
                  break;
               end;
               self.FLens[order[self.FHave]] := word(reg.BITS(3));
               inc(self.FHave);
               reg.DROPBITS(3);
            end;
            if ex then break;
            
            while (self.FHave < 19) do begin
               self.FLens[order[self.FHave]] := 0;
               inc(self.FHave);
            end;
            self.FNext := 0;
            //if Assigned(self.FLencode) then self.FLencode.Free;
            //self.FLencode := TCodes.Create(self.FCodes, 0);
            FLencode.Assign(self.FCodes, 0);
            self.FLenbits := 7;
            
            ret := InfTrees.inflate_table(codetype_CODES, self.FLens, 0, 19, 
                                self.FCodes, self.FNext,
                                self.FLenbits, self.FWork);
            
            if (ret <> CompressionReturnCode_Z_OK ) then begin
               FStrm.ErrorMessage := 'invalid code FLengths set';
               FMode := InflateMode_BAD;
               continue;
            end;
             
            //Trace.WriteLine('inflate:       code FLengths ok');
            self.FHave := 0;
            FMode := InflateMode_CODELENS;
            continue; //goto InflateMode_CODELENS;
         end;

         InflateMode_CODELENS: begin
            ex := false;
            while (self.FHave < (self.FNlen + self.FNdist)) do begin
               repeat
                  l_this := self.FLencode.getCode(reg.BITS(longint(self.FLenbits)));
                  if (longword(l_this.Fbits) <= reg.Fbits) then break; 
                  if not(FStrm.PULLBYTE(reg)) then begin
                     ex := true;
                     break;
                  end;
               until false;
               if ex then break;

               if (l_this.FVal < 16) then begin
                  if not(FStrm.NEEDBITS(l_this.Fbits, reg)) then begin
                     ex := true;
                     break;
                  end;
                  reg.DROPBITS(l_this.Fbits);
                  self.FLens[self.FHave] := l_this.FVal;
                  inc(self.FHave);
               end
               else begin
                  if (l_this.FVal = 16) then begin
                     if not(FStrm.NEEDBITS(l_this.Fbits + 2, reg)) then begin
                        ex := true;
                        break;
                     end;
                     reg.DROPBITS(l_this.Fbits);
                     if (self.FHave = 0) then begin
                        FStrm.ErrorMessage := 'invalid bit FLength repeat';
                        FMode := InflateMode_BAD;
                        break;
                     end;
                     len := self.FLens[self.FHave - 1];
                     copy := 3 + reg.BITS(2);
                     reg.DROPBITS(2);
                  end
                  else if (l_this.FVal = 17) then begin
                     if not(FStrm.NEEDBITS(l_this.Fbits + 3, reg)) then begin
                        ex := true;
                        break;
                     end;
                     reg.DROPBITS(l_this.Fbits);
                     len := 0;
                     copy := 3 + reg.BITS(3);
                     reg.DROPBITS(3);
                  end
                  else begin
                     if not(FStrm.NEEDBITS(l_this.Fbits + 7, reg)) then begin
                        ex := true;
                        break;
                     end;
                     reg.DROPBITS(l_this.Fbits);
                     len := 0;
                     copy := 11 + reg.BITS(7);
                     reg.DROPBITS(7);
                  end;
                  if (self.FHave + copy > self.FNlen + self.FNdist) then begin
                     FStrm.ErrorMessage := 'invalid bit FLength repeat';
                     FMode := InflateMode_BAD;
                     break;
                  end;
                  while (copy > 0) do begin
                     dec(copy);
                     self.FLens[self.FHave] := word(len);
                     inc(self.FHave);
                  end;
               end;
            end;
            if ex then break;

            //* handle error breaks in while */
            if (FMode = InflateMode_BAD) then continue;
         
            //* build code tables */
            self.FNext := 0;
            //if Assigned(self.FLencode) then self.FLencode.Free;
            //self.FLencode := TCodes.Create(self.FCodes, 0);
            FLencode.Assign(self.FCodes, 0);
            self.FLenbits := 9;
            ret := InfTrees.inflate_table(codetype_LENS, 
                        self.FLens, 0, self.FNlen, 
                        self.FCodes, self.FNext,
                        self.FLenbits, self.FWork);
         
            if (ret <> CompressionReturnCode_Z_OK ) then begin
               FStrm.ErrorMessage := 'invalid literal/FLengths set';
               FMode := InflateMode_BAD;
               continue;
            end;
            //if Assigned(self.FDistcode) then self.FDistcode.Free;
            //self.FDistcode := TCodes.Create(self.FCodes, self.FNext);
            FDistcode.Assign(self.FCodes, self.FNext);
            self.FDistbits := 6;
            ret := InfTrees.inflate_table(codetype_DISTS, 
                     self.FLens, self.FNlen, self.FNdist, 
                     self.FCodes, self.FNext,
                     self.FDistbits, self.FWork);
            if (ret <> CompressionReturnCode_Z_OK ) then begin
               FStrm.ErrorMessage := 'invalid distances set';
               FMode := InflateMode_BAD;
               continue;
            end;
            //Trace.WriteLine('inflate:       FCodes ok');
            FMode := InflateMode_LEN;
            continue; //goto InflateMode_LEN;
         end;

         InflateMode_LEN: begin

            if (reg.FHave >= 6) and (reg.FLeft >= 258) then begin
               FStrm.RestoreFromInflateRegister(reg); 
               inflate_fast(l_out);
               FStrm.LoadToInflateRegister(reg); 
               continue;
            end;

            ex := false;
            repeat
               l_this := self.FLencode.getCode(reg.BITS(longint(self.FLenbits)));
               if (longword(l_this.Fbits) <= reg.Fbits) then break;
               if not(FStrm.PULLBYTE(reg)) then begin
                  ex := true;
                  break;
               end;
            until false;
            if ex then break;

            if (l_this.FOp > 0) and ((l_this.FOp and $f0) = 0) then begin
               l_FLast := l_this;
               repeat
                    l_this := self.FLencode.getCode(l_FLast.FVal +
                            (reg.BITS(l_FLast.Fbits + l_FLast.FOp) shr l_FLast.Fbits));
                    if (longword(l_FLast.Fbits + l_this.Fbits) <= reg.Fbits) then break;
                    if not(FStrm.PULLBYTE(reg)) then begin
                       ex := true;
                       break;
                    end;
               until false;
               if ex then break;
               reg.DROPBITS(l_FLast.Fbits);
            end;
            reg.DROPBITS(l_this.Fbits);
            self.FLength := longword(l_this.FVal);
            if (longint(l_this.FOp) = 0) then begin
               FMode := InflateMode_LIT;
               continue;
            end;
            if ((l_this.FOp and 32) > 0) then begin
               //Trace.WriteLine('inflate:end of block');
               FMode := InflateMode_TYPE;
               continue;
            end;
            if ((l_this.FOp and 64) > 0) then begin
               FStrm.ErrorMessage := 'invalid literal/FLength code';
               FMode := InflateMode_BAD;
               continue;
            end;
            self.FExtra := longword(l_this.FOp) and 15;
            FMode := InflateMode_LENEXT;
            continue; //goto InflateMode_LENEXT;
         end;

         InflateMode_LENEXT: begin
            if (self.FExtra > 0) then begin
               if not(FStrm.NEEDBITS(longint(self.FExtra), reg)) then break;
               self.FLength := self.FLength + reg.BITS(longint(self.FExtra));
               reg.DROPBITS(longint(self.FExtra));
            end;
            //Trace.WriteLine(String.Format('inflate:FLength begin0end;', self.FLength));
            FMode := InflateMode_DIST;
            continue; //goto InflateMode_DIST; 
         end;

         InflateMode_DIST: begin
            ex := false;
            repeat
                l_this := self.FDistcode.getCode(reg.BITS(longint(self.FDistbits)));
                if (longword(l_this.Fbits) <= reg.Fbits) then break;
                if not(FStrm.PULLBYTE(reg)) then begin
                   ex := true;
                   break;
                end;
            until false;
            if ex then break;

            if ((l_this.FOp and $f0) = 0) then begin
               l_FLast := l_this;
               repeat
                  l_this := self.FDistcode.getCode(l_FLast.FVal +
                            (reg.BITS(l_FLast.Fbits + l_FLast.FOp) shr l_FLast.Fbits));
                  if (longword(l_FLast.Fbits + l_this.Fbits) <= reg.Fbits) then break;
                  if not(FStrm.PULLBYTE(reg)) then begin
                     ex := true;
                     break;
                  end;
               until false;
               if ex then break;
               reg.DROPBITS(l_FLast.Fbits);
            end;
            reg.DROPBITS(l_this.Fbits);
            if ((l_this.FOp and 64) > 0) then begin
               FStrm.ErrorMessage := 'invalid distance code';
               FMode := InflateMode_BAD;
               continue;
            end;
            self.FOffset := longword(l_this.FVal);
            self.FExtra := longword(l_this.FOp) and 15;
            FMode := InflateMode_DISTEXT;
            continue; //goto InflateMode_DISTEXT;
         end;

         InflateMode_DISTEXT: begin
            if (self.FExtra > 0) then begin
               if not(FStrm.NEEDBITS(longint(self.FExtra), reg)) then break;
               self.FOffset := self.FOffset + reg.BITS(longint(self.FExtra));
               reg.DROPBITS(longint(self.FExtra));
            end;
            {$IFDEF INFLATE_STRICT}
            if (self.FOffset > self.FDmax) then begin
               FStrm.ErrorMessage := 'invalid distance too far back';
               FMode := InflateMode_BAD;
               continue;
            end;
            {$ENDIF}
            if (self.FOffset > self.FWhave + l_out - reg.FLeft) then begin
               FStrm.ErrorMessage := 'invalid distance too far back';
               FMode := InflateMode_BAD;
               continue;
            end;
            
            //Trace.WriteLine(String.Format('inflate:distance begin0end;', self.FOffset));
            FMode := InflateMode_MATCH;
            continue; //goto InflateMode_MATCH;
         end;

         InflateMode_MATCH: begin
            if (reg.FLeft = 0) then break;
            copy := l_out - reg.FLeft;
            if (self.FOffset > copy) then begin//* copy from FWindow */
               copy := self.FOffset - copy;
               if (copy > self.FWrite) then begin
                  copy := copy - self.FWrite;
                  from.Assign(self.FWindow, longint(self.FWsize - copy));
               end
               else
                  from.Assign(self.FWindow, longint(self.FWrite - copy));
               if (copy > self.FLength) then copy := self.FLength;
            end
            else begin   //* copy from output */
                from.Assign(reg.FPut, longint(-self.FOffset));
                copy := self.FLength;
            end;
            if (copy > reg.FLeft) then copy := reg.FLeft;
            reg.FLeft := reg.FLeft - copy;
            self.FLength := self.FLength - copy;
            repeat
               reg.FPut.PUSH(from.POP());
               dec(copy);
            until not (copy > 0);
            if (self.FLength = 0) then FMode := InflateMode_LEN;
            continue;
         end;

         InflateMode_LIT: begin
            if (reg.FLeft = 0) then break;
            reg.FPut.PUSH(byte(self.FLength)); 
            dec(reg.FLeft);
            FMode := InflateMode_LEN;
            continue;
         end;

         InflateMode_CHECK: begin
            if (self.FWrap > 0) then begin
               if not(FStrm.NEEDBITS(32, reg)) then break;
               l_out := l_out - reg.FLeft;
               FStrm.TotalOut := FStrm.TotalOut + l_out;
               self.FTotal := self.FTotal + l_out;
               if (l_out > 0) then begin
                   FStrm.FAdler := UPDATE(FCheck, reg.FPut.ArrByte, longword(reg.FPut.Offset) - l_out, l_out);
                   FCheck := UPDATE(FCheck, reg.FPut.ArrByte, longword(reg.FPut.Offset) - l_out, l_out);
               end;
               l_out := reg.FLeft;
            {$IFDEF GUNZIP}
               if (((self.FFlags > 0) and (reg.FHold <> self.FCheck)) or
                     (not(self.FFlags > 0) and (REVERSE(reg.FHold) <> self.FCheck))) then begin
            {$ELSE}
               if ((
                  REVERSE(reg.FHold)) <> self.FCheck) then begin
            {$ENDIF}
                  FStrm.ErrorMessage := 'incorrect data FCheck';
                  FMode := InflateMode_BAD;
                  continue;
               end;
               reg.INITBITS();
             //Trace.WriteLine('inflate:   FCheck matches trailer');
            end;
            {$IFDEF GUNZIP }
            FMode := InflateMode_LENGTH;
            continue; //goto InflateMode_LENGTH;
         end;

         InflateMode_LENGTH: begin
            if (FWrap > 0) and (self.FFlags > 0) then begin
               if not(FStrm.NEEDBITS(32, reg)) then break;
               if (reg.FHold <> (self.FTotal and longword($ffffffff))) then begin
                  FStrm.ErrorMessage := 'incorrect data FCheck';
                  FMode := InflateMode_BAD;
                  continue;
               end;
               reg.INITBITS();
                //Trace.WriteLine('inflate:   FLength matches trailer');
            end;
            {$ENDIF}
            FMode := InflateMode_DONE;
            continue; //goto InflateMode_DONE;
         end;

         InflateMode_DONE: begin
            ret := CompressionReturnCode_Z_STREAM_END;
            break;
         end;

         InflateMode_BAD: begin
            ret := CompressionReturnCode_Z_DATA_ERROR;
            break;
         end;

         InflateMode_MEM: begin
            result := CompressionReturnCode_Z_MEM_ERROR;
            exit;
         end;

         InflateMode_SYNC:
       else begin
         //Console.WriteLine('case default  FMode:begin0end;', FMode);
            result := CompressionReturnCode_Z_STREAM_ERROR;
            exit;
         end;
      end;
   until false;

      {/*
        Return from inflate(), updating the FTotal counts and the FCheck value.
        If there was no progress during the inflate() call, return a buffer
        error.  Call updateFWindow() to create and/or update the FWindow state.
        Note: a memory error from inflate() is non-recoverable.
      */}
   FStrm.RestoreFromInflateRegister(reg); 
   if ((self.FWsize > 0) or 
         ((self.FMode < InflateMode_CHECK) and (l_out <> FStrm.AvailableOut))) then
      if (updateFWindow(l_out) <> 0) then begin
         self.FMode := InflateMode_MEM;
         result := CompressionReturnCode_Z_MEM_ERROR;
         exit;
      end;


   l_in  := l_in - FStrm.AvailableIn;
   l_out := l_out - FStrm.AvailableOut;

   FStrm.TotalIn := FStrm.TotalIn + l_in;
   FStrm.TotalOut := FStrm.TotalOut + l_out;
   self.FTotal := self.FTotal + l_out;

   if (self.FWrap > 0) and (l_out > 0) then begin
      FStrm.FAdler := UPDATE(FCheck, FStrm.FBuff_out, FStrm.NextOut - l_out, l_out);
      FCheck := UPDATE(FCheck, FStrm.FBuff_out, FStrm.NextOut - l_out, l_out);
   end;   
   //FCheck := FStrm.UPDATE_ADLER_BUFF_OUT(FCheck, FStrm.NextOut - l_out, l_out);

   //!!!!not used!!! FStrm.data_type := Fbits + (FLast ? 64 : 0) +
   //        (FMode = InflateMode_TYPE ? 128 : 0);
    if ((((l_in = 0) and (l_out = 0)) or 
         (flush = FlushMode_Z_FINISH)) and 
            (ret = CompressionReturnCode_Z_OK)) then
      ret := CompressionReturnCode_Z_BUF_ERROR;
finally
  reg.Free;
  from.Free;
end;
   result := ret;
end;

{/*
   Decode literal, FLength, and distance FCodes and FWrite out the resulting
   literal and match bytes until either not enough input or output is
   available, an end-of-block is encountered, or a data error is encountered.
   When large enough input and output buffers are supplied to inflate(), for
   example, a 16K input buffer and a 64K output buffer, more than 95% of the
   inflate execution time is spent in this routine.

   Entry assumptions:

        state->FMode = LEN
        FStrm->avail_in >= 6
        FStrm->avail_out >= 258
        start >= FStrm->avail_out
        state->Fbits < 8

   On return, state->FMode is one of:

        LEN -- ran out of enough output space or enough available input
        TYPE -- reached end of block code, inflate() to interpret FNext block
        BAD -- error in block data

   Notes:

    - The maximum input Fbits used by a FLength/distance pair is 15 Fbits for the
      FLength code, 5 Fbits for the FLength FExtra, 15 Fbits for the distance code,
      and 13 Fbits for the distance FExtra.  This FTotals 48 Fbits, or six bytes.
      Therefore if FStrm->avail_in >= 6, then there is enough input to avoid
      FChecking for available input while decoding.

    - The maximum bytes that a single FLength/distance pair can output is 258
      bytes, which is the maximum FLength that can be coded.  inflate_fast()
      requires FStrm->avail_out >= 258 for each loop to avoid FChecking for
      output space.
 */}

procedure TInflater.inflate_fast(start:longword); //* inflate()'s starting value for FStrm->avail_out */
Var 
{$IFDEF INFLATE_STRICT}
       FDmax:longword;     //* maximum distance from zlib FHeader */
{$ENDIF}
       l_in:TMapped_arr;
       FLast:TMapped_arr;
       l_out:TMapped_arr;
       beg:TMapped_arr;
       aend:TMapped_arr;

       FWsize:longword;    //* FWindow size or zero if not using FWindow */
       FWhave:longword;    //* valid bytes in the FWindow */
       FWrite:longword;    //* FWindow FWrite index */

       FWindow:TArrByte;   //* allocated sliding FWindow, if FWsize <> 0 */
       FHold:longword;     //* local FStrm->FHold */
       Fbits:longword;     //* local FStrm->Fbits */
       lcode:TCodes;      //* local FStrm->FLencode */
       dcode:TCodes;      //* local FStrm->FDistcode */

       lmask:longword;    //* mask for first level of FLength FCodes */
       dmask:longword;    //* mask for first level of distance FCodes */
       l_this:TCode;       //* retrieved table entry */
       FOp:longword;       //* code Fbits, operation, FExtra Fbits, or */

       len:longword;      //* match FLength, unused bytes */
       dist:longword;     //* match distance */
       from:TMapped_arr;  //* where to copy match from */
       arrbyte:TArrByte;
   label dolen, dodist;
begin
   arrbyte := nil;
   from := nil;
   l_in := nil;
   FLast := nil;
   l_out := nil;
   beg := nil;
   aend := nil;
{$IFDEF INFLATE_STRICT}
   FDmax := self.FDmax;     //* maximum distance from zlib FHeader */
{$ENDIF}
try
   l_in := FStrm.GetInMappedArray(-1);
   FLast := TMapped_arr.Create(l_in, longint(FStrm.AvailableIn) - 5);
   l_out := FStrm.GetOutMappedArray(-1);
   beg   := TMapped_arr.Create(l_out, longint(-(start - FStrm.AvailableOut)));
   aend   := TMapped_arr.Create(l_out, longint(FStrm.AvailableOut) - 257);

   FWsize := self.FWsize;    //* FWindow size or zero if not using FWindow */
   FWhave := self.FWhave;    //* valid bytes in the FWindow */
   FWrite := self.FWrite;    //* FWindow FWrite index */

   FWindow  := self.FWindow;//* allocated sliding FWindow, if FWsize <> 0 */
   FHold    := self.FHold;  //* local FStrm->FHold */
   Fbits    := self.Fbits;  //* local FStrm->Fbits */
   lcode   := self.FLencode;        //* local FStrm->FLencode */
   dcode   := self.FDistcode;       //* local FStrm->FDistcode */  

   lmask := (longword(1) shl longint(self.FLenbits)) - 1;  //* mask for first level of FLength FCodes */
   dmask := (longword(1) shl longint(self.FDistbits)) - 1; //* mask for first level of distance FCodes */
   from := TMapped_arr.Create(arrbyte, 0);        //* where to copy match from */


   //* decode literals and FLength/distances until end-of-block or not enough
   //*   input data or output space */
   repeat
      if (Fbits < 15) then begin
         FHold := FHold + (longword(l_in.PUP) shl longint(Fbits));
         Fbits := Fbits + 8;
         FHold := FHold + (longword(l_in.PUP) shl longint(Fbits));
         Fbits := Fbits + 8;
      end;
      l_this := lcode.getCode(longword(FHold and lmask));
   dolen:
      FOp := longword(l_this.Fbits);
      FHold := FHold shr longint(FOp);
      Fbits := Fbits - FOp;
      FOp := longword(l_this.FOp);
      if (FOp = 0) then begin        //* literal */
   //      //Trace.WriteLine(l_this.FVal >= $20 and self.FVal < $7f ?
   //     'inflate:literal '%c'\n' :
   //     'inflate:literal $%02x\n', self.FVal));
         l_out.PUP := byte(l_this.FVal);
      end
      else if ((FOp and 16) > 0) then begin   //* FLength base */
         len := longword(l_this.FVal);
         FOp := FOp and 15;//* number of FExtra Fbits */
         if (FOp > 0) then begin
            if (Fbits < FOp) then begin
               FHold := FHold + longword(l_in.PUP) shl longint(Fbits);
               Fbits := Fbits + 8;
            end;
            len := len + longword(FHold) and ((longword(1) shl longint(FOp)) - 1);
            FHold := FHold shr longint(FOp);
            Fbits := Fbits - FOp;
         end;
         //Trace.WriteLine(String.Format('inflate:FLength begin0end;', len));
         if (Fbits < 15) then begin
            FHold := FHold + longword(l_in.PUP) shl longint(Fbits);
            Fbits := Fbits + 8;
            FHold := FHold + longword(l_in.PUP) shl longint(Fbits);
            Fbits := Fbits + 8;
         end;

         l_this := dcode.getCode(longword(FHold and dmask));
     dodist:
         FOp := longword(l_this.Fbits);
         FHold := FHold shr longint(FOp);
         Fbits := Fbits - FOp;
         FOp := longword(l_this.FOp);
         if ((FOp and 16) > 0) then begin    //* distance base */
            dist := longword(l_this.FVal);
            FOp := FOp and 15;     //* number of FExtra Fbits */
            if (Fbits < FOp) then begin
               FHold := FHold + (longword(l_in.PUP) shl longint(Fbits));
               Fbits := Fbits + 8;
               if (Fbits < FOp) then begin
                  FHold := FHold + (longword(l_in.PUP) shl longint(Fbits));
                  Fbits := Fbits + 8;
               end;
            end;
            dist := dist + (longword(FHold) and (longword(1) shl longint(FOp) - 1));
   {$IFDEF INFLATE_STRICT)}
            if (dist > FDmax) then begin
               FStrm.ErrorMessage := 'invalid distance too far back';
               FMode := InflateMode_BAD;
               break;
            end;
   {$ENDIF}
            FHold := FHold shr longint(FOp);
            Fbits := Fbits - FOp;
            //Trace.WriteLine(String.Format('inflate:distance begin0end;', dist));
            FOp := longword(l_out.Offset - beg.Offset);     //* max distance in output */

            if (dist > FOp) then begin  //* see if copy from FWindow */
               FOp := dist - FOp;        //* distance back in FWindow */
               if (FOp > FWhave) then begin
                  FStrm.ErrorMessage := 'invalid distance too far back';
                  FMode := InflateMode_BAD;
                  break;
               end;
               from.Assign(FWindow, -1);
               if (FWrite = 0) then begin  //* very common case */
                  from.Offset := from.Offset + longint(FWsize - FOp);
                  if (FOp < len) then begin//* some from FWindow */
                      len := len - FOp;
                      repeat
                         l_out.PUP := from.PUP;
                         dec(FOp);
                      until (FOp <= 0);
                      from.Assign(l_out, longint(-dist));  //* rest from output */
                  end;
               end
               else if (FWrite < FOp) then begin      //* FWrap around FWindow */
                  from.Offset := from.Offset + longint(FWsize + FWrite - FOp);
                  FOp := FOp - FWrite;
                  if (FOp < len) then begin//* some from end of FWindow */
                      len := len - FOp;
                      repeat
                         l_out.PUP := from.PUP;
                         dec(FOp);
                      until not (FOp > 0);
                      from.Assign(FWindow, -1);
                      if (FWrite < len) then begin  //* some from start of FWindow */
                          FOp := FWrite;
                          len := len - FOp;
                          repeat
                             l_out.PUP := from.PUP;
                             dec(FOp);
                          until not (FOp > 0);
                          from.Assign(l_out, longint(-dist));      //* rest from output */
                      end;
                  end;
               end
               else begin    //* contiguous in FWindow */
                  from.Offset := from.Offset + longint(FWrite - FOp);
                  if (FOp < len) then begin//* some from FWindow */
                     len := len - FOp;
                     repeat
                        l_out.PUP := from.PUP;
                        dec(FOp);
                     until not (FOp > 0);
                     from.Assign(l_out, longint(-dist));  //* rest from output */
                  end;
               end;
               while (len > 2) do begin
                   l_out.PUP := from.PUP;
                   l_out.PUP := from.PUP;
                   l_out.PUP := from.PUP;
                   len := len - 3;
               end;
               if (len > 0) then begin
                  l_out.PUP := from.PUP;
                  if (len > 1) then l_out.PUP := from.PUP;
               end;
            end
            else begin
               from.Assign(l_out, longint(-dist));     //* copy direct from output */
               repeat     //* minimum FLength is three */
                  l_out.PUP := from.PUP;
                  l_out.PUP := from.PUP;
                  l_out.PUP := from.PUP;
                  len := len - 3;
               until not(len > 2);
               if (len > 0) then begin
                  l_out.PUP := from.PUP;
                  if (len > 1) then l_out.PUP := from.PUP;
               end;
            end;
         end
         else if ((FOp and 64) = 0) then begin //* 2nd level distance code */
            l_this := dcode.getCode(longword(l_this.FVal + (FHold and (longword(1) shl longint(FOp) - 1))));
            goto dodist;
         end
         else begin
            FStrm.ErrorMessage := 'invalid distance code';
            FMode := InflateMode_BAD;
            break;
         end;
      end
      else if ((FOp and 64) = 0) then begin     //* 2nd level FLength code */
         l_this := lcode.getCode(longword(l_this.FVal + (FHold and (longword(1) shl longint(FOp) - 1))));
         goto dolen;
      end
      else if ((FOp and 32) > 0) then begin   //* end-of-block */
         //Trace.WriteLine('inflate:end of block');
         FMode := InflateMode_TYPE;
         break;
      end
      else begin
         FStrm.ErrorMessage := 'invalid literal/length code';
         FMode := InflateMode_BAD;
         break;
      end;
   until not ((l_in.Offset < FLast.Offset) and (l_out.Offset < aend.Offset));

   //* return unused bytes (on entry, Fbits < 8, so in won't go too far back) */
   len := Fbits shr 3;
   l_in.Offset := l_in.Offset - longint(len);
   Fbits := Fbits - (len shl 3);
   FHold := FHold and (longword(1) shl longint(Fbits) - 1);

   //* update state and return */
   if l_in.Offset < FLast.Offset then begin
      FStrm.UpdateNextIn({/*FStrm.next_in*/} longword(l_in.Offset) + 1, 
                        {/*FStrm.avail_in*/}longword(5 + (FLast.Offset - l_in.Offset)))   
   end else begin
      FStrm.UpdateNextIn({/*FStrm.next_in*/} longword(l_in.Offset) + 1, 
                        {/*FStrm.avail_in*/}longword(5 - (l_in.Offset - FLast.Offset)));   
   end;

   if l_out.Offset < aend.Offset then begin
      FStrm.UpdateNextOut({/*FStrm.next_out*/} longword(l_out.Offset) + 1 , 
                         {/*FStrm.avail_out*/} longword(257 + (aend.Offset - l_out.Offset)))

   end else begin
      FStrm.UpdateNextOut({/*FStrm.next_out*/} longword(l_out.Offset) + 1 , 
                         {/*FStrm.avail_out*/} longword(257 - (l_out.Offset - aend.Offset)));
   end;

   self.FHold := FHold;
   self.Fbits := Fbits;
finally
   from.Free;
   arrbyte.Free;
   l_in.Free;
   FLast.Free;
   l_out.Free;
   beg.Free;
   aend.Free;
end;
end; 

initialization 

InitArrayWord(order, [16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15]);

end.

