// for internal use only - if you are not Peter from psoft.sk, please set off
{.$define PSOFT_DEBUG}

// enable export to jpg/jpeg file format ... use unt JPeg ...
{$define PSOFT_JPEG}

// enable export to gif file format ... use unt GifImg (Delphi 2009) ...
{$define PSOFT_GIF}

// if PSOFT_BARCODE_DB is active data aware barcode is enabled, this means
// BDE and another data engines are used ...
{$define PSOFT_BARCODE_DB}

{$define PSOFT_EDITORS}

// PSOFT_PROF enabled PDF417, IntelligentMail, AustraliaPost and another
// symbologies ...
{$define PSOFT_PROF}

// PSOFT_STUDIO enable 2D symbologies DataMatrix, QRCode, Aztec ...
{$define PSOFT_STUDIO}

// if set, editors, DB support, GIF, PNG, JPEG are disabled
{.$define PSOFT_LITE}

{$ifdef PSOFT_LITE}
   {$undef PSOFT_DB}
   {$undef PSOFT_EDITORS}
   {$undef PSOFT_GIF}
   {$undef PSOFT_PNG}
   {$undef PSOFT_JPEG}
{$endif}

// ---------------------------------------------------------------
// select your preferred report tool here
// ---------------------------------------------------------------

{.$define PSOFT_PRAGNAAN}
{.$define PSOFT_QUICKREPORT}
{.$define PSOFT_QREPORT4}
{.$define PSOFT_RAVE}
{.$define PSOFT_ACE}
{.$define PSOFT_RB}
{.$define PSOFT_FASTREPORT}


// *********************************************************************
// ***************  PLEASE, DON'T MODIFY LINES BELOW   *****************
// *********************************************************************

{$ifdef PSOFT_STUDIO}
  {$define PSOFT_PROF}
{$endif}

{$ifdef PSOFT_PROF}
  {$define PSOFT_PDF417}
{$endif}



{$IFDEF VER100} {Borland Delphi 3.0 }
	  {$DEFINE PSOFT_D3}
{$ENDIF}

{$IFDEF VER110} { Borland C++Builder 3.0 }
	  {$DEFINE PSOFT_CBUILDER3}
{$ENDIF}

{$IFDEF VER120} {Borland Delphi 4.0 }
	  {$DEFINE PSOFT_D3}
	  {$DEFINE PSOFT_D4}
{$ENDIF}

{$IFDEF VER125} {Borland C++ Builder 4.0 }
	  {$DEFINE PSOFT_CBUILDER4}
{$ENDIF}

{$IFDEF VER130} {Borland Delphi 5.0 }
    {$ifdef BCB}
        	{$DEFINE PSOFT_BCB5}
	        {$ObjExportAll On}
    {$else}
	        {$DEFINE PSOFT_D5}
    {$endif}
{$ENDIF}

{$IFDEF VER140} {Borland Delphi 6.0 }
	  {$DEFINE PSOFT_D5}
	  {$define PSOFT_D6}
          {$ifdef BCB}
                {$define PSOFT_BCB6}
          {$endif}
{$endif}

{$IFDEF VER150} {Borland Delphi 7.0 }
	  {$DEFINE PSOFT_D5}
	  {$define PSOFT_D6}
	  {$define PSOFT_D7}
{$endif}

{$IFDEF VER160} {Borland Delphi 8.0 }
	  {$DEFINE PSOFT_D5}
	  {$define PSOFT_D6}
	  {$define PSOFT_D7}
	  {$define PSOFT_D8}
{$endif}

{$IFDEF VER170} {Borland Delphi 2005 }
	  {$DEFINE PSOFT_D5}
	  {$define PSOFT_D6}
	  {$define PSOFT_D7}
	  {$define PSOFT_D8}
	  {$define PSOFT_D2005}
{$endif}

{$IFDEF VER180} {Borland Delphi 2006 }
	  {$DEFINE PSOFT_D5}
	  {$define PSOFT_D6}
	  {$define PSOFT_D7}
	  {$define PSOFT_D8}
	  {$define PSOFT_D2005}
	  {$define PSOFT_D2006}
{$endif}

// Delphi 2007
// Note: D2007/win32 defines VER180 and VER185. D2007/.NET defines VER190

{$IFDEF VER185}
	  {$DEFINE PSOFT_D5}
	  {$define PSOFT_D6}
	  {$define PSOFT_D7}
	  {$define PSOFT_D8}
	  {$define PSOFT_D2005}
	  {$define PSOFT_D2006}
    {$DEFINE PSOFT_D2007win}
{$ENDIF}

{$IFDEF VER190}
	  {$DEFINE PSOFT_D5}
	  {$define PSOFT_D6}
	  {$define PSOFT_D7}
	  {$define PSOFT_D8}
	  {$define PSOFT_D2005}
	  {$define PSOFT_D2006}
    {$DEFINE PSOFT_D2007net}
{$ENDIF}

// Delphi 2009
{$IFDEF VER200}
	  {$DEFINE PSOFT_D5}
	  {$define PSOFT_D6}
	  {$define PSOFT_D7}
	  {$define PSOFT_D8}
	  {$define PSOFT_D2005}
	  {$define PSOFT_D2006}
    {$DEFINE PSOFT_D2007net}
	  {$define PSOFT_D2009}
{$ENDIF}

// Delphi 2010
{$IFDEF VER210}
	  {$DEFINE PSOFT_D5}
	  {$define PSOFT_D6}
	  {$define PSOFT_D7}
	  {$define PSOFT_D8}
	  {$define PSOFT_D2005}
	  {$define PSOFT_D2006}
    {$DEFINE PSOFT_D2007net}
//	  {$define PSOFT_D2008}
	  {$define PSOFT_D2009}
	  {$define PSOFT_D2010}
{$ENDIF}

// Delphi 2011 (Delphi XE)
{$IFDEF VER220}
	  {$DEFINE PSOFT_D5}
	  {$define PSOFT_D6}
	  {$define PSOFT_D7}
	  {$define PSOFT_D8}
	  {$define PSOFT_D2005}
	  {$define PSOFT_D2006}
    {$DEFINE PSOFT_D2007net}
//	  {$define PSOFT_D2008}
	  {$define PSOFT_D2009}
	  {$define PSOFT_D2010}
	  {$define PSOFT_D2011}
{$ENDIF}


{$ifndef PSOFT_D2009}
    {$undef PSOFT_GIF}
{$endif}

