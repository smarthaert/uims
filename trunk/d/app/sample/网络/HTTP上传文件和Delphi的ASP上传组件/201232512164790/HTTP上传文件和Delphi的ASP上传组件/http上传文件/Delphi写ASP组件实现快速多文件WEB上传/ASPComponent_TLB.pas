unit ASPComponent_TLB;

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
// File generated on 2004-09-23 09:28:52 from Type Library described below.

// ************************************************************************  //
// Type Lib: E:\软件集\Delphi写ASP组件实现快速多文件WEB上传\source\FileUpload.tlb (1)
// LIBID: {3EAEEDCA-E767-4137-9A45-B19073A8D7A7}
// LCID: 0
// Helpfile: 
// HelpString: David 's ASP FileUpload Component
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\system32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
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
  ASPComponentMajorVersion = 1;
  ASPComponentMinorVersion = 0;

  LIBID_ASPComponent: TGUID = '{3EAEEDCA-E767-4137-9A45-B19073A8D7A7}';

  IID_IFileUpload: TGUID = '{AED54F26-C910-4CC2-B1AC-D3B0DA161886}';
  CLASS_CoIFileUpload: TGUID = '{8E8BDAD0-41D2-4A51-9755-A21517379111}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IFileUpload = interface;
  IFileUploadDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  CoIFileUpload = IFileUpload;


// *********************************************************************//
// Interface: IFileUpload
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {AED54F26-C910-4CC2-B1AC-D3B0DA161886}
// *********************************************************************//
  IFileUpload = interface(IDispatch)
    ['{AED54F26-C910-4CC2-B1AC-D3B0DA161886}']
    function OnStartPage(const pUnk: IUnknown): Integer; safecall;
    procedure OnEndPage; safecall;
    function SaveFile(const path: WideString; overwrite: WordBool): Integer; safecall;
    function InputCount: Integer; safecall;
    function FileSize(Item: OleVariant): Integer; safecall;
    function FileType(Item: OleVariant): WideString; safecall;
    function Request(Item: OleVariant): WideString; safecall;
  end;

// *********************************************************************//
// DispIntf:  IFileUploadDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {AED54F26-C910-4CC2-B1AC-D3B0DA161886}
// *********************************************************************//
  IFileUploadDisp = dispinterface
    ['{AED54F26-C910-4CC2-B1AC-D3B0DA161886}']
    function OnStartPage(const pUnk: IUnknown): Integer; dispid 1;
    procedure OnEndPage; dispid 2;
    function SaveFile(const path: WideString; overwrite: WordBool): Integer; dispid 3;
    function InputCount: Integer; dispid 5;
    function FileSize(Item: OleVariant): Integer; dispid 7;
    function FileType(Item: OleVariant): WideString; dispid 8;
    function Request(Item: OleVariant): WideString; dispid 9;
  end;

// *********************************************************************//
// The Class CoCoIFileUpload provides a Create and CreateRemote method to          
// create instances of the default interface IFileUpload exposed by              
// the CoClass CoIFileUpload. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCoIFileUpload = class
    class function Create: IFileUpload;
    class function CreateRemote(const MachineName: string): IFileUpload;
  end;

implementation

uses ComObj;

class function CoCoIFileUpload.Create: IFileUpload;
begin
  Result := CreateComObject(CLASS_CoIFileUpload) as IFileUpload;
end;

class function CoCoIFileUpload.CreateRemote(const MachineName: string): IFileUpload;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CoIFileUpload) as IFileUpload;
end;

end.
