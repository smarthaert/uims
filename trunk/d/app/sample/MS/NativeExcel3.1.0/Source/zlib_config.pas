//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         zlib_config
//
//      Description:  Values for max_lazy_match, good_match and max_chain_length (zlib)
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

unit zlib_config;
{$Q-}
{$R-}


interface
uses zlib_deftype;

type 

  TConfig = class
  public
    //* Values for max_lazy_match, good_match and max_chain_length, depending on
    //* the desired pack level (0..9). The values given below have been tuned to
    //* exclude worst case performance for pathological files. Better values may be
    //* found for specific files.

    FGood_length:word; //* reduce lazy search above this match length */
    FMax_lazy:word;    //* do not perform lazy search above this match length */
    FNice_length:word; //* quit search above this match length */
    FMax_chain:word;
    FFunc:compress_func;

    constructor Create(good_length, max_lazy, nice_length, max_chain:word; func:compress_func);

  end;

implementation

constructor TConfig.Create(good_length, max_lazy, nice_length, max_chain:word; func:compress_func);
begin
   self.FGood_length   := good_length;
   self.FMax_lazy      := max_lazy;
   self.FNice_length   := nice_length;
   self.FMax_chain     := max_chain;
   self.FFunc          := func;
end;


end.
