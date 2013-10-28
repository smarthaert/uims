//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         zlib_z_stream
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


unit zlib_z_stream;
{$Q-}
{$R-}


interface

{$I xlsdef.inc}
//{$DEFINE GZIP}
uses zlib_deftype, zlib_const, zlib_mapped_arr, 
     zlib_inflateregister, zlib_adler32, sysutils;

type
   TZ_Stream = class
   private
      FBuff_in:TArrByte;    //* input buffer*/ 
      FNext_in:longword;    //* FNext input byte */
      FAvail_in:longword;   //* number of bytes available at FNext_in */
      FTotal_in:longword;   //ulong //* total nb of input bytes read so far */

      FNext_out:longword;   //* FNext output byte should be FPut there */
      FAvail_out:longword;  //* remaining free space at FNext_out */
      FTotal_out:longword;  //ulong //* total nb of bytes output so far */

      FError_msg:widestring; ///* last error message, NULL if no error */
//         private internal _state state; //* not visible by applications */

//         alloc_func zalloc;  //* used to allocate the function TZ_Stream. state */
//         free_func  zfree;   //* used to free the function TZ_Stream. state */
//         voidpf     opaque;  //* private data object passed to zalloc and zfree */

      FData_type:DataType;  //* best guess about the data type: binary or text */
//         private ulong   reserved;   //* reserved for future use */

      FInflater:TObject; //TInflater
      FDeflater:TObject; //TDeflater
      
      function  getAvailableIn:longword;
      function  getAvailableOut:longword;
      function  getTotalIn:longword;
      procedure setTotalIn(value:longword);
      function  getTotalOut:longword;
      procedure setTotalOut(value:longword);
      function  getNextOut:longword;
      procedure setNextOut(value:longword);
      function  getData_Type:DataType;
      procedure setData_Type(value:DataType);
      function  getErrorMessage:widestring;
      procedure setErrorMessage(value:widestring);
   
   public
      FAdler:longword;      ///* adler32 value of the uncompressed data */
      FBuff_out:TArrByte;   //* output buffer*/

      constructor Create;
      destructor Destroy;override;

      procedure CopyToOutBuf(buff:TArrByte; offset, len:longword);  
      procedure PrepareInBuffer(abuff:TArrByte; offset, length:longint); 
      procedure PrepareOutBuffer(abuff:TArrByte; offset, length:longint);
      procedure InflateInit();overload;
      procedure InflateInit(windowBits:longint);overload;
      procedure DeflateInit(level:longint);overload;
      procedure DeflateInit(level, windowBits:longint);overload;
      function  Deflate(flush:FlushMode):CompressionReturnCode;

      property AvailableIn:longword read getAvailableIn;
      property AvailableOut:longword read getAvailableOut;
      property TotalIn:longword read getTotalIn write setTotalIn;
      property TotalOut:longword read getTotalOut write setTotalOut;
      property NextOut:longword read getNextOut write setNextOut;
      property Data_Type:DataType read getData_Type write setData_Type;
      property ErrorMessage:widestring read getErrorMessage write setErrorMessage;

      function inflateEnd():CompressionReturnCode;
      function GetHashCode():longint; {$ifdef D2009}override;{$endif}
      function ToString():string; {$ifdef D2009}override;{$endif}
      function Inflate(flush:FlushMode):CompressionReturnCode;
      function read_buf(buf:TArrByte; offset, size:longword; wrap:longint):longint;
      function CheckBuffer():boolean;
      procedure Reset();
      
      procedure LoadToInflateRegister(reg:TInflateRegister);
      procedure RestoreFromInflateRegister(reg:TInflateRegister);
      procedure Copy(reg:TInflateRegister; count:longword);
      function NEEDBITS(n:longint; reg:TInflateRegister): boolean;
      function PULLBYTE(reg:TInflateRegister): boolean;
      procedure read_from_out_buf(src_offset:longword; dst_buf:TArrByte; dst_offset, size:longword);
      function  GetInMappedArray(offset:longint):Tmapped_arr;
      function  GetOutMappedArray(offset:longint):Tmapped_arr;
      procedure UpdateNextIn(anext_in, aavail_in:longword);overload;
      procedure UpdateNextIn(offset:longint);overload;
      procedure UpdateNextOut(offset:longint);overload;
      procedure UpdateNextOut(anext_out, aavail_out:longword);overload;
      function  get_next_in(offset:longint):byte;
      procedure CopyInToOut(n:longint);

   end;

implementation

uses zlib_deflater, zlib_inflater;

constructor TZ_Stream.Create; 
begin
   inherited Create;
end;

destructor TZ_Stream.Destroy;
begin
   FInflater.Free;
   FDeflater.Free;

   inherited Destroy;
end;



function TZ_Stream.Deflate(flush:FlushMode):CompressionReturnCode; 
begin
   if not Assigned(FDeflater) then
      result := CompressionReturnCode_Z_STREAM_ERROR
   else begin
      result := TDeflater(FDeflater).Deflate(flush);
   end;
end;


procedure TZ_Stream.InflateInit(); 
begin
   InflateInit(ZLibConst_DEF_WBITS); 
end;


procedure TZ_Stream.InflateInit(windowBits:longint); 
begin
   FInflater := TInflater.Create(self, windowBits); 
end;

procedure TZ_Stream.DeflateInit(level:longint); 
begin
   DeflateInit(level, ZLibConst_MAX_WBITS);
end;

procedure TZ_Stream.DeflateInit(level, windowBits:longint); 
begin
   FDeflater := TDeflater.Create(self, level, windowBits); 
end;

procedure TZ_Stream.PrepareInBuffer(abuff:TArrByte; offset, length:longint); 
begin
    self.FBuff_in  := abuff;
    self.FNext_in  := longword(offset);
    self.FAvail_in := longword(length);
end;

procedure TZ_Stream.PrepareOutBuffer(abuff:TArrByte; offset, length:longint);
begin
   self.FBuff_out  := abuff;
   self.FNext_out  := longword(offset);
   self.FAvail_out := longword(length);
end;

procedure TZ_Stream.CopyToOutBuf(buff:TArrByte; offset, len:longword);  
begin
   ArrayCopy(buff, offset, FBuff_out, FNext_out, len); 
   FNext_out  := FNext_out + len;
   FTotal_out := FTotal_out + len;
   FAvail_out := FAvail_out - len;
end;


function TZ_Stream.getErrorMessage:widestring;
begin
   result := FError_msg; 
end;


procedure TZ_Stream.setErrorMessage(value:widestring);
begin
   FError_msg := value; 
end;


function TZ_Stream.inflateEnd():CompressionReturnCode;
begin
    FInflater := nil;
    result := CompressionReturnCode_Z_OK;
end;


function TZ_Stream.GetHashCode():longint;
Var HashCode:longint;
begin
   HashCode := -1;   
   if Assigned(FDeflater) then HashCode := TDeflater(FDeflater).GetHashCode();
   result := HashCode;
end;


function TZ_Stream.ToString():string;
Var ret:string;
begin
   ret := '***TZ_Stream***';  
//   ret := ret + ' FBuff_in_value:' + FBuff_in.ToString();
   ret := ret + Format(' FNext_in:%d',[FNext_in]);
   ret := ret + Format(' FAvail_in:%d',[FAvail_in]);
   ret := ret + Format(' FTotal_in:%d',[FTotal_in]);

   ret := ret + Format(' FNext_out:%d',[FNext_out]);
   ret := ret + Format(' FAvail_out:%d',[FAvail_out]);
   ret := ret + Format(' FTotal_out:%d',[FTotal_out]);
   ret := ret + '***************';  

//   if Assigned(FDeflater) then ret := TDeflater(FDeflater).ToString();
   result :=  ret;
end;


function TZ_Stream.Inflate(flush:FlushMode):CompressionReturnCode;
begin
   if not Assigned(FInflater) then
      result := CompressionReturnCode_Z_STREAM_ERROR
   else  begin
      result := TInflater(FInflater).Inflate(flush);
   end;
end;

//* =====================================================================
//* Read a new buffer from the current input stream, update the adler32
//* and total number of bytes read.  All deflate() input goes through
//* this function so some applications may wish to modify it to avoid
//* allocating a large strm->FNext_in buffer and copying from it.
//* (See also flush_pending()).
//* =====================================================================
function TZ_Stream.read_buf(buf:TArrByte; offset, size:longword; wrap:longint):longint;
Var len:longword;
begin

   len := FAvail_in;

   if (len > size) then len := size;
   if (len <> 0) then begin
      FAvail_in  := FAvail_in - len;

      if (wrap = 1) then begin
         FAdler := Adler32_adler32(FAdler, FBuff_in, FNext_in, len); 
      end;
{$IFDEF GZIP}
      if (wrap = 2) then begin
         FAdler := Adler32_crc32(FAdler, FBuff_in, FNext_in, len); 
      end;
{$ENDIF}
      ArrayCopy(FBuff_in, FNext_in, buf, offset, len);
      FNext_in  := FNext_in + len;
      FTotal_in := FTotal_in + len;

      result :=  longint(len);
   end
   else
      result := 0;
end;


function TZ_Stream.CheckBuffer():boolean;
begin
   if ((not Assigned(FBuff_out)) or
      ((not Assigned(FBuff_in)) and (FAvail_in <> 0))) then 
      result := false
   else
      result := true; 
end; 


procedure TZ_Stream.Reset();
begin
   FTotal_in := 0;
   FTotal_out := 0;
   FError_msg := ''; 
   FData_type := DataType_Z_UNKNOWN;
end;


function TZ_stream.getAvailableIn:longword;
begin
   result := FAvail_in; 
end;

function TZ_stream.getAvailableOut:longword;
begin
   result := FAvail_out; 
end;

function TZ_stream.getTotalIn:longword;
begin
   result := FTotal_in; 
end;  

procedure TZ_stream.setTotalIn(value:longword);
begin
   FTotal_in := value;
end;

function TZ_stream.getTotalOut:longword;
begin
   result := FTotal_out; 
end;  

procedure TZ_stream.setTotalOut(value:longword);
begin
   FTotal_out := value;
end;

function TZ_stream.getNextOut:longword;
begin
   result :=  FNext_out; 
end;  

procedure TZ_stream.setNextOut(value:longword);
begin
   FNext_out := value;
end;


function TZ_stream.getData_Type:DataType;
begin
   result := FData_type;
end;

procedure TZ_stream.setData_Type(value:DataType);
begin
   FData_type := value;
end;

//* Load registers with state in inflate() */
procedure TZ_Stream.LoadToInflateRegister(reg:TInflateRegister);
begin
     reg.FPut.Assign(FBuff_out, longint(FNext_out));
     reg.FLeft := FAvail_out;
     reg.FNext.Assign(FBuff_in, longint(FNext_in));
     reg.FHave := FAvail_in; 
     reg.FHold := TInflater(FInflater).FHold; 
     reg.Fbits := TInflater(FInflater).FBits; 
end;

//* Restore state from registers in inflate() */
procedure TZ_Stream.RestoreFromInflateRegister(reg:TInflateRegister);
begin
     FNext_out      := longword(reg.FPut.Offset);
     FAvail_out     := reg.FLeft;
     FNext_in       := longword(reg.FNext.Offset);
     FAvail_in      := reg.FHave; 
     TInflater(FInflater).FHold := reg.FHold; 
     TInflater(FInflater).FBits := reg.Fbits; 
end;

//*Copy from FNext to out*/
procedure TZ_Stream.Copy(reg:TInflateRegister; count:longword);
begin
   reg.Copy(count);
   TInflater(FInflater).FLength := TInflater(FInflater).FLength - count;    
end;  


//* Assure that there are at least n FBits in the bit accumulator.  If there is
//*   not enough available input to do that, then result :=  from inflate(). */
function TZ_Stream.NEEDBITS(n:longint; reg:TInflateRegister): boolean;
begin
     //Console.WriteLine("need FBits begin0end; reg.FBits=begin1end; ", n, reg.FBits);
     Result := true;
     while (reg.Fbits < longword(n)) do begin
        if (reg.FHave = 0) then begin 
           Result := false;
           break;
        end;
        dec(reg.FHave);
        //Console.Write("add byte begin0end; FHold beforebegin1end; ", reg.FNext[reg.FNext.Offset], reg.FHold);
        reg.FHold := reg.FHold + (longword(reg.FNext.POP()) shl longint(reg.Fbits)); 
        //Console.WriteLine(" FHold afterbegin0end; ", reg.FHold);
        reg.Fbits := reg.Fbits + 8;
     end;
end;

//* Get a byte of input into the bit accumulator, or result :=  from inflate()
//*   if there is no input available. */
function TZ_Stream.PULLBYTE(reg:TInflateRegister): boolean;
begin
   if (reg.FHave = 0) then begin
      Result := false;
   end else begin
      dec(reg.FHave);
      reg.FHold := reg.FHold + (longword(reg.FNext.POP()) shl longint(reg.Fbits)); 
      reg.Fbits := reg.Fbits + 8;
      Result := true;
   end;
end;

//function TZ_Stream. ulong UPDATE_ADLER_BUFF_OUT(ulong check, uint offset , uint len);
//begin
//     FAdler := Adler32.adler32(check, FBuff_out, offset, len); 
//     result :=  FAdler;
//end; 

procedure TZ_Stream.read_from_out_buf(src_offset:longword; dst_buf:TArrByte; dst_offset, size:longword);
begin
    ArrayCopy(FBuff_out, src_offset, dst_buf, dst_offset, size);
end;


function TZ_Stream.GetInMappedArray(offset:longint):Tmapped_arr;
begin
   result := Tmapped_arr.Create(FBuff_in, longint(FNext_in) + offset);
end;

function TZ_Stream.GetOutMappedArray(offset:longint):Tmapped_arr;
begin
   result := Tmapped_arr.Create(FBuff_out, longint(FNext_out) + offset);
end;

procedure TZ_Stream.UpdateNextIn(anext_in, aavail_in:longword);
begin
   self.FNext_in := anext_in;
   self.FAvail_in := aavail_in;
end;

procedure TZ_Stream.UpdateNextIn(offset:longint);
begin
   self.FNext_in := longword(longint(self.FNext_in) + offset);
   self.FAvail_in := longword(longint(self.FAvail_in) - offset); 
end;

procedure TZ_Stream.UpdateNextOut(offset:longint);
begin
   self.FNext_out := longword(longint(self.FNext_out) + offset);
   self.FAvail_out := longword(longint(self.FAvail_out) - offset); 
end;

procedure TZ_Stream.UpdateNextOut(anext_out, aavail_out:longword);
begin
   self.FNext_out := anext_out;
   self.FAvail_out := aavail_out; 
end;

function TZ_Stream.get_next_in(offset:longint):byte;
begin
   result := FBuff_in[longword(longint(FNext_in) + offset)];
end;  

procedure TZ_Stream.CopyInToOut(n:longint);
begin
   ArrayCopy(FBuff_in, FNext_in, FBuff_out, FNext_out, n);
   UpdateNextOut(n);
   UpdateNextIn(n);
end; 


end.
