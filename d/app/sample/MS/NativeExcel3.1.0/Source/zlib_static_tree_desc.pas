//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         zlib_static_tree_desc
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

unit zlib_static_tree_desc;
{$Q-}
{$R-}

interface
{$I xlsdef.inc}

uses zlib_deftype, zlib_const;

type
  TStatic_tree_desc = class

  public
     FStatic_tree:TArrSmallint;  //* static tree or NULL */
     FExtra_bits:TArrLongint;   //* extra bits for each code or NULL */
     FExtra_base:longint;   //* base index for FExtra_bits */
     FElems:longint;        //* max number of elements in the tree */
     FMax_length:longint;   //* max bit length for the codes */

     constructor Create(static_tree:TArrSmallint; 
                        extra_bits:TArrLongint;
                        extra_base,
                        elems,
                        max_length:longint);

     function GetHashCode():longint; {$ifdef D2009}override;{$endif}
  end;




implementation

constructor TStatic_tree_desc.Create(static_tree:TArrSmallint; 
                        extra_bits:TArrLongint;
                        extra_base,
                        elems,
                        max_length:longint);
begin
   self.FStatic_tree := static_tree;
   self.FExtra_bits  := extra_bits;
   self.FExtra_base  := extra_base;
   self.FElems       := elems;
   self.FMax_length  := max_length;
end;


function TStatic_tree_desc.GetHashCode():longint;
Var HashCode:longword;
begin
   HashCode := 1;   

   HashCode := 33 * HashCode + ZLibConst_GetHashCodeForVal(FStatic_tree); //*short[]*/
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + ZLibConst_GetHashCodeForVal(FExtra_bits); //*int[]*/
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FExtra_base); 
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FElems); 
   HashCode := HashCode + HashCode shr 5;

   HashCode := 33 * HashCode + longword(FMax_length); 
   HashCode := HashCode + HashCode shr 5;


   result := longint(HashCode);
end;

end.
