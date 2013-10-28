unit MailIEBand_TLB;
{*******************************************************}
{                                                       }
{       IEBar 图文快存                                  }
{                                                       }
{       版权所有 (C) 2005　毕耜祯           　　　　　　}
{            转载请保留此信息 　　　　　　　　　　　　  }
{       网址：batconv.512j.com                          }
{       batconv@163.com                                 }
{*******************************************************}

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //
// Download by http://www.codefans.net
// PASTLWTR : $Revision:   1.130  $
// File generated on 2000-1-1 1:38:21 from Type Library described below.

// ************************************************************************  //
// Type Lib: E:\Delphi软件\IE\QCIEBand.tlb (1)
// LIBID: {6BE04603-18EA-4DDB-A59C-637E692E762F}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\System32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINDOWS\System32\stdvcl40.dll)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}

interface

uses ActiveX, Classes, Graphics, StdVCL, Variants, Windows;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  MailIEBandMajorVersion = 1;
  MailIEBandMinorVersion = 0;

  LIBID_MailIEBand: TGUID = '{6BE04603-18EA-4DDB-A59C-637E692E762F}';

  IID_IBandUnit: TGUID = '{5A0D613C-24A7-4ECA-A4DF-27D10207342E}';
  CLASS_BandUnit: TGUID = '{CC22CB2C-6E2E-48D6-9E1B-DF2025F72922}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IBandUnit = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  BandUnit = IBandUnit;


// *********************************************************************//
// Interface: IBandUnit
// Flags:     (256) OleAutomation
// GUID:      {5A0D613C-24A7-4ECA-A4DF-27D10207342E}
// *********************************************************************//
  IBandUnit = interface(IUnknown)
    ['{5A0D613C-24A7-4ECA-A4DF-27D10207342E}']
  end;

// *********************************************************************//
// The Class CoBandUnit provides a Create and CreateRemote method to          
// create instances of the default interface IBandUnit exposed by              
// the CoClass BandUnit. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoBandUnit = class
    class function Create: IBandUnit;
    class function CreateRemote(const MachineName: string): IBandUnit;
  end;

implementation

uses ComObj;

class function CoBandUnit.Create: IBandUnit;
begin
  Result := CreateComObject(CLASS_BandUnit) as IBandUnit;
end;

class function CoBandUnit.CreateRemote(const MachineName: string): IBandUnit;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_BandUnit) as IBandUnit;
end;

end.
