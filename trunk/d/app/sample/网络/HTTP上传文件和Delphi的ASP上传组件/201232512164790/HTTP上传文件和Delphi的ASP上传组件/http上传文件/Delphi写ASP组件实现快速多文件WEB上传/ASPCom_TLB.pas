unit ASPCom_TLB;

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

// PASTLWTR : $Revision:   1.88.1.0.1.0  $
// File generated on 2001-6-18 17:10:04 from Type Library described below.

// ************************************************************************ //
// Type Lib: D:\david\FileUpload\Project2.tlb (1)
// IID\LCID: {3EAEEDCA-E767-4137-9A45-B19073A8D7A7}\0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINNT\System32\STDVCL40.DLL)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, OleCtrls, StdVCL;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  ASPComMajorVersion = 1;
  ASPComMinorVersion = 0;

  LIBID_ASPCom: TGUID = '{3EAEEDCA-E767-4137-9A45-B19073A8D7A7}';

  IID_FileUpload: TGUID = '{FCDF6B52-CA65-4918-BAB9-6CD168B25E87}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  FileUpload = interface;
  FileUploadDisp = dispinterface;

// *********************************************************************//
// Interface: FileUpload
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FCDF6B52-CA65-4918-BAB9-6CD168B25E87}
// *********************************************************************//
  FileUpload = interface(IDispatch)
    ['{FCDF6B52-CA65-4918-BAB9-6CD168B25E87}']
  end;

// *********************************************************************//
// DispIntf:  FileUploadDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FCDF6B52-CA65-4918-BAB9-6CD168B25E87}
// *********************************************************************//
  FileUploadDisp = dispinterface
    ['{FCDF6B52-CA65-4918-BAB9-6CD168B25E87}']
  end;

implementation

uses ComObj;

end.
