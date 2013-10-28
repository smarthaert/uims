//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         zlib_mapped_arr
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

unit zlib_mapped_arr;
{$Q-}
{$R-}


interface

uses zlib_deftype;

type
   TMapped_arr = class
   private
      FArray:TArrByte;
      FOffset:longint; // = 0

      function  getOffset:longint;
      procedure setOffset(value:longint);
      function  getCurValue:byte;
      procedure setCurValue(value:byte);
      function  getBuffer:TArrByte;
      function  getArr(index:longint):byte;
      procedure setArr(index:longint; value:byte);
      function  getPUP:byte;
      procedure setPUP(value:byte);

   public
      constructor Create(Aarr:TArrByte; Aoffset:longint);overload;
      constructor Create(marr:TMapped_arr; Aoffset:longint);overload;
      destructor Destroy;override;

      procedure Assign(Aarr:TArrByte; Aoffset:longint);overload;
      procedure Assign(marr:TMapped_arr; Aoffset:longint);overload;
      function  POP:byte;
      procedure PUSH(value:byte);
      
      property Offset:longint read getOffset write setOffset;
      property CurValue:byte read getCurValue write setCurValue;
      property ArrByte:TArrByte read getBuffer;
      property Arr[index:longint]:byte read getArr write setArr; default;
      property PUP:byte read getPUP write setPUP;
   end;

implementation


constructor TMapped_arr.Create(Aarr:TArrByte; Aoffset:longint);
begin
   Assign(Aarr, Aoffset); 
end;

constructor TMapped_arr.Create(marr:TMapped_arr; Aoffset:longint);
begin
   Assign(marr, Aoffset); 
end;

destructor TMapped_arr.Destroy;
begin
   inherited Destroy;
end;


procedure TMapped_arr.Assign(Aarr:TArrByte; Aoffset:longint);
begin
   self.FArray := Aarr; 
   self.FOffset := Aoffset;   
end;

procedure TMapped_arr.Assign(marr:TMapped_arr; Aoffset:longint);
begin
   self.FArray := marr.FArray; 
   self.FOffset := marr.FOffset + Aoffset;   
end;


function TMapped_arr.getOffset:longint;
begin
   result := FOffset;
end;

procedure TMapped_arr.setOffset(value:longint);
begin
  FOffset := value;
end;


function TMapped_arr.getCurValue:byte;
begin
   result := FArray[FOffset];
end;

procedure TMapped_arr.setCurValue(value:byte);
begin
   FArray[FOffset] := value;  
end;


function TMapped_arr.getBuffer:TArrByte;
begin
   result := FArray;
end;


function TMapped_arr.getArr(Index:longint):byte;
begin
   result := FArray[FOffset + index];
end;

procedure TMapped_arr.setArr(Index:longint; value:byte);
begin
   FArray[FOffset + index] := value;  
end;


function TMapped_arr.getPUP:byte;
begin
   FOffset := FOffset + 1;
   result := FArray[FOffset]; 
end;

procedure TMapped_arr.setPUP(value:byte);
begin                        
   FOffset := FOffset + 1;
   FArray[FOffset] := value;
end;

function TMapped_arr.POP:byte;
begin
   result := FArray[FOffset]; 
   FOffset := FOffset + 1;
end;

procedure TMapped_arr.PUSH(value:byte);
begin                        
   FArray[FOffset] := value;
   FOffset := FOffset + 1;
end;

end.
