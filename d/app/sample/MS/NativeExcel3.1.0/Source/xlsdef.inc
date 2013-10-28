{$IFDEF VER230} 
  //Delphi2012 (Pulsar)
  {$DEFINE ZLIB}
  {$DEFINE D2012}
  {$DEFINE D2011}
  {$DEFINE D2010}
  {$DEFINE D2009}
  {$DEFINE D2006}
  {$DEFINE D452005}
  {$DEFINE D7UP}
{$ENDIF}

{$IFDEF VER220} 
  //Delphi2011
  {$DEFINE ZLIB}
  {$DEFINE D2011}
  {$DEFINE D2010}
  {$DEFINE D2009}
  {$DEFINE D2006}
  {$DEFINE D452005}
  {$DEFINE D7UP}
{$ENDIF}

{$IFDEF VER210} 
  //Delphi2010
  {$DEFINE ZLIB}
  {$DEFINE D2010}
  {$DEFINE D2009}
  {$DEFINE D2006}
  {$DEFINE D452005}
  {$DEFINE D7UP}
{$ENDIF}

{$IFDEF VER200} 
  //Delphi2009
  {$DEFINE ZLIB}
  {$DEFINE D2009}
  {$DEFINE D2006}
  {$DEFINE D452005}
  {$DEFINE D7UP}
{$ENDIF}

{$IFDEF VER190}
  //Delphi2007
  {$DEFINE ZLIB}
  {$DEFINE D2007}
  {$DEFINE D7UP}
  {$DEFINE D452005}
{$ENDIF}


{$IFDEF VER180}
  //Delphi2006
  {$DEFINE ZLIB}
  {$DEFINE D2006}
  {$DEFINE D452005}
  {$DEFINE D7UP}
{$ENDIF}

{$IFDEF VER170}
  //Delphi2005
  {$DEFINE ZLIB}
  {$DEFINE D2005} 
  {$DEFINE D452005}
  {$DEFINE D7UP}
{$ENDIF}

{$IFDEF VER150}
  //Delphi7
  {$DEFINE ZLIB}
  {$DEFINE D7}
  {$DEFINE D7UP}
{$ENDIF}

{$IFDEF VER140}
  //Delphi6
  {$DEFINE D6}
{$ENDIF}

{$IFDEF VER130}
  //Delphi5
  {$DEFINE D5}
  {$DEFINE D45}
  {$DEFINE D452005}
{$ENDIF}

{$IFDEF VER120}
  //Delphi4
  {$DEFINE D4}
  {$DEFINE D45}
  {$DEFINE D452005}
{$ENDIF}



{.$DEFINE ZLIB}

//////////////////////////////// IMPORTANT ///////////////////////////////////////
//
//   PngImage
//
//   To be able to convert and compress BMP to PNG image, WMF and EMF to PNG
//   and optimization of palette ,
//   you have to install TPNGImage from http://pngdelphi.sourceforge.net/
//   If you want to use TPNGImage, rename the "{.$DEFINE USEPNGLIB}" to  "{$DEFINE USEPNGLIB}"
///////////////////////////////////////////////////////////////////////////////////

{.$DEFINE USEPNGLIB}

{$IFDEF ZLIB}
  {$DEFINE OPEN_EMFWMF}
{$ENDIF}

