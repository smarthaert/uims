//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         zlib_static_tree
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

unit zlib_static_tree;
{$Q-}
{$R-}


interface

uses zlib_deftype,
     zlib_Const,
     zlib_static_tree_desc;

type
   TStaticTree = class
   public
      FStatic_l_desc:TStatic_tree_desc;
      FStatic_d_desc:TStatic_tree_desc;
      FStatic_bl_desc:TStatic_tree_desc;

      constructor Create;
      destructor Destroy;override;
   end; 

Var
   StaticTree:TStaticTree;

implementation

constructor TStaticTree.Create();
begin
   inherited Create;

   FStatic_l_desc := TStatic_tree_desc.Create(ZLibConst_static_ltree, 
                                             ZLibConst_extra_lbits, 
                                             ZLibConst_LITERALS + 1, 
                                             ZLibConst_L_CODES, 
                                             ZLibConst_MAX_BITS);

   FStatic_d_desc := TStatic_tree_desc.Create(ZLibConst_static_dtree, 
                                             ZLibConst_extra_dbits, 
                                             0, 
                                             ZLibConst_D_CODES, 
                                             ZLibConst_MAX_BITS);

   FStatic_bl_desc := TStatic_tree_desc.Create(nil, 
                                              ZLibConst_extra_blbits, 
                                              0, 
                                              ZLibConst_BL_CODES, 
                                              ZLibConst_MAX_BL_BITS);
end;


destructor TStaticTree.Destroy;
begin
   FStatic_l_desc.Free;
   FStatic_d_desc.Free;
   FStatic_bl_desc.Free;

   inherited Destroy;
end;


initialization

StaticTree := TStaticTree.Create();

finalization

StaticTree.free;

end.