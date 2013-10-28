// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ZLibEx.pas' rev: 6.00

#ifndef ZLibExHPP
#define ZLibExHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Zlibex
{
//-- type declarations -------------------------------------------------------
typedef void * __fastcall (*TZAlloc)(void * opaque, int items, int size);

typedef void __fastcall (*TZFree)(void * opaque, void * block);

#pragma option push -b-
enum TZCompressionLevel { zcNone, zcFastest, zcDefault, zcMax };
#pragma option pop

#pragma pack(push, 1)
struct TZStreamRec
{
	char *next_in;
	int avail_in;
	int total_in;
	char *next_out;
	int avail_out;
	int total_out;
	char *msg;
	void *state;
	TZAlloc zalloc;
	TZFree zfree;
	void *opaque;
	int data_type;
	int adler;
	int reserved;
} ;
#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
#define ZLIB_VERSION "1.2.3"
extern PACKAGE void __fastcall MoveI32(const void *Source, void *Dest, int Count);
extern PACKAGE void __fastcall ZCompressStream(Classes::TStream* inStream, Classes::TStream* outStream, TZCompressionLevel level = (TZCompressionLevel)(0x2));
extern PACKAGE void __fastcall ZDecompressStream(Classes::TStream* inStream, Classes::TStream* outStream);
extern PACKAGE int __fastcall adler32(int adler, const char * buf, int len);
extern PACKAGE int __fastcall deflateInit_(TZStreamRec &strm, int level, char * version, int recsize);
extern PACKAGE int __fastcall DeflateInit2_(TZStreamRec &strm, int level, int method, int windowBits, int memLevel, int strategy, char * version, int recsize);
extern PACKAGE int __fastcall deflate(TZStreamRec &strm, int flush);
extern PACKAGE int __fastcall deflateEnd(TZStreamRec &strm);
extern PACKAGE int __fastcall inflateReset(TZStreamRec &strm);
extern PACKAGE int __fastcall inflateInit2_(TZStreamRec &strm, int windowBits, char * version, int recsize);
extern PACKAGE int __fastcall inflateInit_(TZStreamRec &strm, char * version, int recsize);
extern PACKAGE int __fastcall inflate(TZStreamRec &strm, int flush);
extern PACKAGE int __fastcall inflateEnd(TZStreamRec &strm);

}	/* namespace Zlibex */
using namespace Zlibex;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ZLibEx
