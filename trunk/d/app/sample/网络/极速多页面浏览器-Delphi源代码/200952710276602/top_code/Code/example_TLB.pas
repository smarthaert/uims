unit example_TLB;

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

// PASTLWTR : 1.2
// File generated on 2007-9-5 23:15:54 from Type Library described below.

// ************************************************************************  //
// Type Lib: E:\Delphi\Delphi\test\example.tlb (1)
// LIBID: {2CE64F20-D4B0-11D3-9CA6-444553540000}
// LCID: 0
// Helpfile: 
// HelpString: example Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\STDOLE2.TLB)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  exampleMajorVersion = 1;
  exampleMinorVersion = 0;

  LIBID_example: TGUID = '{2CE64F20-D4B0-11D3-9CA6-444553540000}';

  IID_ITBrowserToDelphi: TGUID = '{2CE64F21-D4B0-11D3-9CA6-444553540000}';
  CLASS_TBrowserToDelphi: TGUID = '{2CE64F23-D4B0-11D3-9CA6-444553540000}';
  DIID_DispInterface1: TGUID = '{ECD7C67C-BC6E-4A2A-9530-45547BE7B3F9}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ITBrowserToDelphi = interface;
  ITBrowserToDelphiDisp = dispinterface;
  DispInterface1 = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  TBrowserToDelphi = ITBrowserToDelphi;


// *********************************************************************//
// Interface: ITBrowserToDelphi
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2CE64F21-D4B0-11D3-9CA6-444553540000}
// *********************************************************************//
  ITBrowserToDelphi = interface(IDispatch)
    ['{2CE64F21-D4B0-11D3-9CA6-444553540000}']
    function Get_GetSection: OleVariant; safecall;
    function Get_GetClose: OleVariant; safecall;
    function Get_GetClose2: OleVariant; safecall;
    property GetSection: OleVariant read Get_GetSection;
    property GetClose: OleVariant read Get_GetClose;
    property GetClose2: OleVariant read Get_GetClose2;
  end;

// *********************************************************************//
// DispIntf:  ITBrowserToDelphiDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2CE64F21-D4B0-11D3-9CA6-444553540000}
// *********************************************************************//
  ITBrowserToDelphiDisp = dispinterface
    ['{2CE64F21-D4B0-11D3-9CA6-444553540000}']
    property GetSection: OleVariant readonly dispid 202;
    property GetClose: OleVariant readonly dispid 203;
    property GetClose2: OleVariant readonly dispid 201;
  end;

// *********************************************************************//
// DispIntf:  DispInterface1
// Flags:     (4096) Dispatchable
// GUID:      {ECD7C67C-BC6E-4A2A-9530-45547BE7B3F9}
// *********************************************************************//
  DispInterface1 = dispinterface
    ['{ECD7C67C-BC6E-4A2A-9530-45547BE7B3F9}']
  end;

// *********************************************************************//
// The Class CoTBrowserToDelphi provides a Create and CreateRemote method to          
// create instances of the default interface ITBrowserToDelphi exposed by              
// the CoClass TBrowserToDelphi. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTBrowserToDelphi = class
    class function Create: ITBrowserToDelphi;
    class function CreateRemote(const MachineName: string): ITBrowserToDelphi;
  end;

implementation

uses ComObj;

class function CoTBrowserToDelphi.Create: ITBrowserToDelphi;
begin
  Result := CreateComObject(CLASS_TBrowserToDelphi) as ITBrowserToDelphi;
end;

class function CoTBrowserToDelphi.CreateRemote(const MachineName: string): ITBrowserToDelphi;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TBrowserToDelphi) as ITBrowserToDelphi;
end;

end.
