unit ASPTypeLibrary_TLB;

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

// PASTLWTR : $Revision:   1.88  $
// File generated on 2001-2-25 10:05:48 from Type Library described below.

// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
// ************************************************************************ //
// Type Lib: C:\WINNT\System32\inetsrv\asp.dll (1)
// IID\LCID: {D97A6DA0-A85C-11CF-83AE-00A0C90C2BD8}\0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINNT\System32\STDVCL40.DLL)
// Errors:
//   Hint: Parameter 'Var' of IRequestDictionary.Item changed to 'Var_'
//   Hint: Parameter 'Var' of IReadCookie.Item changed to 'Var_'
//   Hint: Member 'End' of 'IResponse' changed to 'End_'
//   Hint: Member 'File' of 'IASPError' changed to 'File_'
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
interface
uses  ActiveX, OleServer, OleCtrls;
// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  ASPTypeLibraryMajorVersion = 3;
  ASPTypeLibraryMinorVersion = 0;

  LIBID_ASPTypeLibrary: TGUID = '{D97A6DA0-A85C-11CF-83AE-00A0C90C2BD8}';

  IID_IStringList: TGUID = '{D97A6DA0-A85D-11CF-83AE-00A0C90C2BD8}';
  IID_IRequestDictionary: TGUID = '{D97A6DA0-A85F-11DF-83AE-00A0C90C2BD8}';
  IID_IRequest: TGUID = '{D97A6DA0-A861-11CF-93AE-00A0C90C2BD8}';
  CLASS_Request: TGUID = '{920C25D0-25D9-11D0-A55F-00A0C90C2091}';
  IID_IReadCookie: TGUID = '{71EAF260-0CE0-11D0-A53E-00A0C90C2091}';
  IID_IWriteCookie: TGUID = '{D97A6DA0-A862-11CF-84AE-00A0C90C2BD8}';
  IID_IResponse: TGUID = '{D97A6DA0-A864-11CF-83BE-00A0C90C2BD8}';
  CLASS_Response: TGUID = '{46E19BA0-25DD-11D0-A55F-00A0C90C2091}';
  IID_IVariantDictionary: TGUID = '{4A7DEB90-B069-11D0-B373-00A0C90C2BD8}';
  IID_ISessionObject: TGUID = '{D97A6DA0-A865-11CF-83AF-00A0C90C2BD8}';
  CLASS_Session: TGUID = '{509F8F20-25DE-11D0-A55F-00A0C90C2091}';
  IID_IApplicationObject: TGUID = '{D97A6DA0-A866-11CF-83AE-10A0C90C2BD8}';
  CLASS_Application: TGUID = '{7C3BAF00-25DE-11D0-A55F-00A0C90C2091}';
  IID_IASPError: TGUID = '{F5A6893E-A0F5-11D1-8C4B-00C04FC324A4}';
  IID_IServer: TGUID = '{D97A6DA0-A867-11CF-83AE-01A0C90C2BD8}';
  CLASS_Server: TGUID = '{A506D160-25E0-11D0-A55F-00A0C90C2091}';
  IID_IScriptingContext: TGUID = '{D97A6DA0-A868-11CF-83AE-00B0C90C2BD8}';
  CLASS_ScriptingContext: TGUID = '{D97A6DA0-A868-11CF-83AE-11B0C90C2BD8}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IStringList = interface;
  IStringListDisp = dispinterface;
  IRequestDictionary = interface;
  IRequestDictionaryDisp = dispinterface;
  IRequest = interface;
  IRequestDisp = dispinterface;
  IReadCookie = interface;
  IReadCookieDisp = dispinterface;
  IWriteCookie = interface;
  IWriteCookieDisp = dispinterface;
  IResponse = interface;
  IResponseDisp = dispinterface;
  IVariantDictionary = interface;
  IVariantDictionaryDisp = dispinterface;
  ISessionObject = interface;
  ISessionObjectDisp = dispinterface;
  IApplicationObject = interface;
  IApplicationObjectDisp = dispinterface;
  IASPError = interface;
  IASPErrorDisp = dispinterface;
  IServer = interface;
  IServerDisp = dispinterface;
  IScriptingContext = interface;
  IScriptingContextDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Request = IRequest;
  Response = IResponse;
  Session = ISessionObject;
  Application = IApplicationObject;
  Server = IServer;
  ScriptingContext = IScriptingContext;


// *********************************************************************//
// Interface: IStringList
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D97A6DA0-A85D-11CF-83AE-00A0C90C2BD8}
// *********************************************************************//
  IStringList = interface(IDispatch)
    ['{D97A6DA0-A85D-11CF-83AE-00A0C90C2BD8}']
    function  Get_Item(i: OleVariant): OleVariant; safecall;
    function  Get_Count: SYSINT; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    property Item[i: OleVariant]: OleVariant read Get_Item; default;
    property Count: SYSINT read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  IStringListDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D97A6DA0-A85D-11CF-83AE-00A0C90C2BD8}
// *********************************************************************//
  IStringListDisp = dispinterface
    ['{D97A6DA0-A85D-11CF-83AE-00A0C90C2BD8}']
    property Item[i: OleVariant]: OleVariant readonly dispid 0; default;
    property Count: SYSINT readonly dispid 1610743809;
    property _NewEnum: IUnknown readonly dispid -4;
  end;

// *********************************************************************//
// Interface: IRequestDictionary
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D97A6DA0-A85F-11DF-83AE-00A0C90C2BD8}
// *********************************************************************//
  IRequestDictionary = interface(IDispatch)
    ['{D97A6DA0-A85F-11DF-83AE-00A0C90C2BD8}']
    function  Get_Item(Var_: OleVariant): OleVariant; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Count: SYSINT; safecall;
    function  Get_Key(VarKey: OleVariant): OleVariant; safecall;
    property Item[Var_: OleVariant]: OleVariant read Get_Item; default;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Count: SYSINT read Get_Count;
    property Key[VarKey: OleVariant]: OleVariant read Get_Key;
  end;

// *********************************************************************//
// DispIntf:  IRequestDictionaryDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D97A6DA0-A85F-11DF-83AE-00A0C90C2BD8}
// *********************************************************************//
  IRequestDictionaryDisp = dispinterface
    ['{D97A6DA0-A85F-11DF-83AE-00A0C90C2BD8}']
    property Item[Var_: OleVariant]: OleVariant readonly dispid 0; default;
    property _NewEnum: IUnknown readonly dispid -4;
    property Count: SYSINT readonly dispid 1610743810;
    property Key[VarKey: OleVariant]: OleVariant readonly dispid 1610743811;
  end;

// *********************************************************************//
// Interface: IRequest
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D97A6DA0-A861-11CF-93AE-00A0C90C2BD8}
// *********************************************************************//
  IRequest = interface(IDispatch)
    ['{D97A6DA0-A861-11CF-93AE-00A0C90C2BD8}']
    function  Get_Item(const bstrVar: WideString): IDispatch; safecall;
    function  Get_QueryString: IRequestDictionary; safecall;
    function  Get_Form: IRequestDictionary; safecall;
    function  Get_Body: IRequestDictionary; safecall;
    function  Get_ServerVariables: IRequestDictionary; safecall;
    function  Get_ClientCertificate: IRequestDictionary; safecall;
    function  Get_Cookies: IRequestDictionary; safecall;
    function  Get_TotalBytes: Integer; safecall;
    function  BinaryRead(var pvarCountToRead: OleVariant): OleVariant; safecall;
    property Item[const bstrVar: WideString]: IDispatch read Get_Item; default;
    property QueryString: IRequestDictionary read Get_QueryString;
    property Form: IRequestDictionary read Get_Form;
    property Body: IRequestDictionary read Get_Body;
    property ServerVariables: IRequestDictionary read Get_ServerVariables;
    property ClientCertificate: IRequestDictionary read Get_ClientCertificate;
    property Cookies: IRequestDictionary read Get_Cookies;
    property TotalBytes: Integer read Get_TotalBytes;
  end;

// *********************************************************************//
// DispIntf:  IRequestDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D97A6DA0-A861-11CF-93AE-00A0C90C2BD8}
// *********************************************************************//
  IRequestDisp = dispinterface
    ['{D97A6DA0-A861-11CF-93AE-00A0C90C2BD8}']
    property Item[const bstrVar: WideString]: IDispatch readonly dispid 0; default;
    property QueryString: IRequestDictionary readonly dispid 1610743809;
    property Form: IRequestDictionary readonly dispid 1610743810;
    property Body: IRequestDictionary readonly dispid 1610743811;
    property ServerVariables: IRequestDictionary readonly dispid 1610743812;
    property ClientCertificate: IRequestDictionary readonly dispid 1610743813;
    property Cookies: IRequestDictionary readonly dispid 1610743814;
    property TotalBytes: Integer readonly dispid 1610743815;
    function  BinaryRead(var pvarCountToRead: OleVariant): OleVariant; dispid 1610743816;
  end;

// *********************************************************************//
// Interface: IReadCookie
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {71EAF260-0CE0-11D0-A53E-00A0C90C2091}
// *********************************************************************//
  IReadCookie = interface(IDispatch)
    ['{71EAF260-0CE0-11D0-A53E-00A0C90C2091}']
    function  Get_Item(Var_: OleVariant): OleVariant; safecall;
    function  Get_HasKeys: WordBool; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Count: SYSINT; safecall;
    function  Get_Key(VarKey: OleVariant): OleVariant; safecall;
    property Item[Var_: OleVariant]: OleVariant read Get_Item; default;
    property HasKeys: WordBool read Get_HasKeys;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Count: SYSINT read Get_Count;
    property Key[VarKey: OleVariant]: OleVariant read Get_Key;
  end;

// *********************************************************************//
// DispIntf:  IReadCookieDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {71EAF260-0CE0-11D0-A53E-00A0C90C2091}
// *********************************************************************//
  IReadCookieDisp = dispinterface
    ['{71EAF260-0CE0-11D0-A53E-00A0C90C2091}']
    property Item[Var_: OleVariant]: OleVariant readonly dispid 0; default;
    property HasKeys: WordBool readonly dispid 1610743809;
    property _NewEnum: IUnknown readonly dispid -4;
    property Count: SYSINT readonly dispid 1610743811;
    property Key[VarKey: OleVariant]: OleVariant readonly dispid 1610743812;
  end;

// *********************************************************************//
// Interface: IWriteCookie
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D97A6DA0-A862-11CF-84AE-00A0C90C2BD8}
// *********************************************************************//
  IWriteCookie = interface(IDispatch)
    ['{D97A6DA0-A862-11CF-84AE-00A0C90C2BD8}']
    procedure Set_Item(Key: OleVariant; const Param2: WideString); safecall;
    procedure Set_Expires(Param1: TDateTime); safecall;
    procedure Set_Domain(const Param1: WideString); safecall;
    procedure Set_Path(const Param1: WideString); safecall;
    procedure Set_Secure(Param1: WordBool); safecall;
    function  Get_HasKeys: WordBool; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    property Item[Key: OleVariant]: WideString write Set_Item; default;
    property Expires: TDateTime write Set_Expires;
    property Domain: WideString write Set_Domain;
    property Path: WideString write Set_Path;
    property Secure: WordBool write Set_Secure;
    property HasKeys: WordBool read Get_HasKeys;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  IWriteCookieDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D97A6DA0-A862-11CF-84AE-00A0C90C2BD8}
// *********************************************************************//
  IWriteCookieDisp = dispinterface
    ['{D97A6DA0-A862-11CF-84AE-00A0C90C2BD8}']
    property Item[Key: OleVariant]: WideString writeonly dispid 0; default;
    property Expires: TDateTime writeonly dispid 1610743809;
    property Domain: WideString writeonly dispid 1610743810;
    property Path: WideString writeonly dispid 1610743811;
    property Secure: WordBool writeonly dispid 1610743812;
    property HasKeys: WordBool readonly dispid 1610743813;
    property _NewEnum: IUnknown readonly dispid -4;
  end;

// *********************************************************************//
// Interface: IResponse
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D97A6DA0-A864-11CF-83BE-00A0C90C2BD8}
// *********************************************************************//
  IResponse = interface(IDispatch)
    ['{D97A6DA0-A864-11CF-83BE-00A0C90C2BD8}']
    function  Get_Buffer: WordBool; safecall;
    procedure Set_Buffer(fIsBuffering: WordBool); safecall;
    function  Get_ContentType: WideString; safecall;
    procedure Set_ContentType(const pbstrContentTypeRet: WideString); safecall;
    function  Get_Expires: OleVariant; safecall;
    procedure Set_Expires(pvarExpiresMinutesRet: Integer); safecall;
    function  Get_ExpiresAbsolute: OleVariant; safecall;
    procedure Set_ExpiresAbsolute(pvarExpiresRet: TDateTime); safecall;
    function  Get_Cookies: IRequestDictionary; safecall;
    function  Get_Status: WideString; safecall;
    procedure Set_Status(const pbstrStatusRet: WideString); safecall;
    procedure Add(const bstrHeaderValue: WideString; const bstrHeaderName: WideString); safecall;
    procedure AddHeader(const bstrHeaderName: WideString; const bstrHeaderValue: WideString); safecall;
    procedure AppendToLog(const bstrLogEntry: WideString); safecall;
    procedure BinaryWrite(varInput: OleVariant); safecall;
    procedure Clear; safecall;
    procedure End_; safecall;
    procedure Flush; safecall;
    procedure Redirect(const bstrURL: WideString); safecall;
    procedure Write(varText: OleVariant); safecall;
    procedure WriteBlock(iBlockNumber: Smallint); safecall;
    function  IsClientConnected: WordBool; safecall;
    function  Get_CharSet: WideString; safecall;
    procedure Set_CharSet(const pbstrCharSetRet: WideString); safecall;
    procedure Pics(const bstrHeaderValue: WideString); safecall;
    function  Get_CacheControl: WideString; safecall;
    procedure Set_CacheControl(const pbstrCacheControl: WideString); safecall;
    property Buffer: WordBool read Get_Buffer;
    property ContentType: WideString read Get_ContentType;
    property Expires: OleVariant read Get_Expires;
    property ExpiresAbsolute: OleVariant read Get_ExpiresAbsolute;
    property Cookies: IRequestDictionary read Get_Cookies;
    property Status: WideString read Get_Status;
    property CharSet: WideString read Get_CharSet;
    property CacheControl: WideString read Get_CacheControl;
  end;

// *********************************************************************//
// DispIntf:  IResponseDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D97A6DA0-A864-11CF-83BE-00A0C90C2BD8}
// *********************************************************************//
  IResponseDisp = dispinterface
    ['{D97A6DA0-A864-11CF-83BE-00A0C90C2BD8}']
    property Buffer: WordBool readonly dispid 1610743808;
    property ContentType: WideString readonly dispid 1610743810;
    property Expires: OleVariant readonly dispid 1610743812;
    property ExpiresAbsolute: OleVariant readonly dispid 1610743814;
    property Cookies: IRequestDictionary readonly dispid 1610743816;
    property Status: WideString readonly dispid 1610743817;
    procedure Add(const bstrHeaderValue: WideString; const bstrHeaderName: WideString); dispid 1610743819;
    procedure AddHeader(const bstrHeaderName: WideString; const bstrHeaderValue: WideString); dispid 1610743820;
    procedure AppendToLog(const bstrLogEntry: WideString); dispid 1610743821;
    procedure BinaryWrite(varInput: OleVariant); dispid 1610743822;
    procedure Clear; dispid 1610743823;
    procedure End_; dispid 1610743824;
    procedure Flush; dispid 1610743825;
    procedure Redirect(const bstrURL: WideString); dispid 1610743826;
    procedure Write(varText: OleVariant); dispid 1610743827;
    procedure WriteBlock(iBlockNumber: Smallint); dispid 1610743828;
    function  IsClientConnected: WordBool; dispid 1610743829;
    property CharSet: WideString readonly dispid 1610743830;
    procedure Pics(const bstrHeaderValue: WideString); dispid 1610743832;
    property CacheControl: WideString readonly dispid 1610743833;
  end;

// *********************************************************************//
// Interface: IVariantDictionary
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {4A7DEB90-B069-11D0-B373-00A0C90C2BD8}
// *********************************************************************//
  IVariantDictionary = interface(IDispatch)
    ['{4A7DEB90-B069-11D0-B373-00A0C90C2BD8}']
    function  Get_Item(VarKey: OleVariant): OleVariant; safecall;
    procedure _Set_Item(VarKey: OleVariant; pvar: OleVariant); safecall;
    procedure Set_Item(VarKey: OleVariant; pvar: OleVariant); safecall;
    function  Get_Key(VarKey: OleVariant): OleVariant; safecall;
    function  Get_Count: SYSINT; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    procedure Remove(VarKey: OleVariant); safecall;
    procedure RemoveAll; safecall;
    property Item[VarKey: OleVariant]: OleVariant read Get_Item write _Set_Item; default;
    property Key[VarKey: OleVariant]: OleVariant read Get_Key;
    property Count: SYSINT read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  IVariantDictionaryDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {4A7DEB90-B069-11D0-B373-00A0C90C2BD8}
// *********************************************************************//
  IVariantDictionaryDisp = dispinterface
    ['{4A7DEB90-B069-11D0-B373-00A0C90C2BD8}']
    property Item[VarKey: OleVariant]: OleVariant dispid 0; default;
    property Key[VarKey: OleVariant]: OleVariant readonly dispid 1610743811;
    property Count: SYSINT readonly dispid 1610743812;
    property _NewEnum: IUnknown readonly dispid -4;
    procedure Remove(VarKey: OleVariant); dispid 1610743814;
    procedure RemoveAll; dispid 1610743815;
  end;

// *********************************************************************//
// Interface: ISessionObject
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D97A6DA0-A865-11CF-83AF-00A0C90C2BD8}
// *********************************************************************//
  ISessionObject = interface(IDispatch)
    ['{D97A6DA0-A865-11CF-83AF-00A0C90C2BD8}']
    function  Get_SessionID: WideString; safecall;
    function  Get_Value(const bstrValue: WideString): OleVariant; safecall;
    procedure _Set_Value(const bstrValue: WideString; pvar: OleVariant); safecall;
    procedure Set_Value(const bstrValue: WideString; pvar: OleVariant); safecall;
    function  Get_Timeout: Integer; safecall;
    procedure Set_Timeout(plvar: Integer); safecall;
    procedure Abandon; safecall;
    function  Get_CodePage: Integer; safecall;
    procedure Set_CodePage(plvar: Integer); safecall;
    function  Get_LCID: Integer; safecall;
    procedure Set_LCID(plvar: Integer); safecall;
    function  Get_StaticObjects: IVariantDictionary; safecall;
    function  Get_Contents: IVariantDictionary; safecall;
    property SessionID: WideString read Get_SessionID;
    property Value[const bstrValue: WideString]: OleVariant read Get_Value write _Set_Value; default;
    property Timeout: Integer read Get_Timeout;
    property CodePage: Integer read Get_CodePage;
    property LCID: Integer read Get_LCID;
    property StaticObjects: IVariantDictionary read Get_StaticObjects;
    property Contents: IVariantDictionary read Get_Contents;
  end;

// *********************************************************************//
// DispIntf:  ISessionObjectDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D97A6DA0-A865-11CF-83AF-00A0C90C2BD8}
// *********************************************************************//
  ISessionObjectDisp = dispinterface
    ['{D97A6DA0-A865-11CF-83AF-00A0C90C2BD8}']
    property SessionID: WideString readonly dispid 1610743808;
    property Value[const bstrValue: WideString]: OleVariant dispid 0; default;
    property Timeout: Integer readonly dispid 1610743812;
    procedure Abandon; dispid 1610743814;
    property CodePage: Integer readonly dispid 1610743815;
    property LCID: Integer readonly dispid 1610743817;
    property StaticObjects: IVariantDictionary readonly dispid 1610743819;
    property Contents: IVariantDictionary readonly dispid 1610743820;
  end;

// *********************************************************************//
// Interface: IApplicationObject
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D97A6DA0-A866-11CF-83AE-10A0C90C2BD8}
// *********************************************************************//
  IApplicationObject = interface(IDispatch)
    ['{D97A6DA0-A866-11CF-83AE-10A0C90C2BD8}']
    function  Get_Value(const bstrValue: WideString): OleVariant; safecall;
    procedure _Set_Value(const bstrValue: WideString; pvar: OleVariant); safecall;
    procedure Set_Value(const bstrValue: WideString; pvar: OleVariant); safecall;
    procedure Lock; safecall;
    procedure UnLock; safecall;
    function  Get_StaticObjects: IVariantDictionary; safecall;
    function  Get_Contents: IVariantDictionary; safecall;
    property Value[const bstrValue: WideString]: OleVariant read Get_Value write _Set_Value; default;
    property StaticObjects: IVariantDictionary read Get_StaticObjects;
    property Contents: IVariantDictionary read Get_Contents;
  end;

// *********************************************************************//
// DispIntf:  IApplicationObjectDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D97A6DA0-A866-11CF-83AE-10A0C90C2BD8}
// *********************************************************************//
  IApplicationObjectDisp = dispinterface
    ['{D97A6DA0-A866-11CF-83AE-10A0C90C2BD8}']
    property Value[const bstrValue: WideString]: OleVariant dispid 0; default;
    procedure Lock; dispid 1610743811;
    procedure UnLock; dispid 1610743812;
    property StaticObjects: IVariantDictionary readonly dispid 1610743813;
    property Contents: IVariantDictionary readonly dispid 1610743814;
  end;

// *********************************************************************//
// Interface: IASPError
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {F5A6893E-A0F5-11D1-8C4B-00C04FC324A4}
// *********************************************************************//
  IASPError = interface(IDispatch)
    ['{F5A6893E-A0F5-11D1-8C4B-00C04FC324A4}']
    function  Get_ASPCode: WideString; safecall;
    function  Get_Number: Integer; safecall;
    function  Get_Category: WideString; safecall;
    function  Get_File_: WideString; safecall;
    function  Get_Line: Integer; safecall;
    function  Get_Description: WideString; safecall;
    function  Get_ASPDescription: WideString; safecall;
    function  Get_Column: Integer; safecall;
    function  Get_Source: WideString; safecall;
    property ASPCode: WideString read Get_ASPCode;
    property Number: Integer read Get_Number;
    property Category: WideString read Get_Category;
    property File_: WideString read Get_File_;
    property Line: Integer read Get_Line;
    property Description: WideString read Get_Description;
    property ASPDescription: WideString read Get_ASPDescription;
    property Column: Integer read Get_Column;
    property Source: WideString read Get_Source;
  end;

// *********************************************************************//
// DispIntf:  IASPErrorDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {F5A6893E-A0F5-11D1-8C4B-00C04FC324A4}
// *********************************************************************//
  IASPErrorDisp = dispinterface
    ['{F5A6893E-A0F5-11D1-8C4B-00C04FC324A4}']
    property ASPCode: WideString readonly dispid 1610743808;
    property Number: Integer readonly dispid 1610743809;
    property Category: WideString readonly dispid 1610743810;
    property File_: WideString readonly dispid 1610743811;
    property Line: Integer readonly dispid 1610743812;
    property Description: WideString readonly dispid 1610743813;
    property ASPDescription: WideString readonly dispid 1610743814;
    property Column: Integer readonly dispid 1610743815;
    property Source: WideString readonly dispid 1610743816;
  end;

// *********************************************************************//
// Interface: IServer
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D97A6DA0-A867-11CF-83AE-01A0C90C2BD8}
// *********************************************************************//
  IServer = interface(IDispatch)
    ['{D97A6DA0-A867-11CF-83AE-01A0C90C2BD8}']
    function  Get_ScriptTimeout: Integer; safecall;
    procedure Set_ScriptTimeout(plTimeoutSeconds: Integer); safecall;
    function  CreateObject(const bstrProgID: WideString): IDispatch; safecall;
    function  HTMLEncode(const bstrIn: WideString): WideString; safecall;
    function  MapPath(const bstrLogicalPath: WideString): WideString; safecall;
    function  URLEncode(const bstrIn: WideString): WideString; safecall;
    function  URLPathEncode(const bstrIn: WideString): WideString; safecall;
    procedure Execute(const bstrLogicalPath: WideString); safecall;
    procedure Transfer(const bstrLogicalPath: WideString); safecall;
    function  GetLastError: IASPError; safecall;
    property ScriptTimeout: Integer read Get_ScriptTimeout;
  end;

// *********************************************************************//
// DispIntf:  IServerDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D97A6DA0-A867-11CF-83AE-01A0C90C2BD8}
// *********************************************************************//
  IServerDisp = dispinterface
    ['{D97A6DA0-A867-11CF-83AE-01A0C90C2BD8}']
    property ScriptTimeout: Integer readonly dispid 1610743808;
    function  CreateObject(const bstrProgID: WideString): IDispatch; dispid 1610743810;
    function  HTMLEncode(const bstrIn: WideString): WideString; dispid 1610743811;
    function  MapPath(const bstrLogicalPath: WideString): WideString; dispid 1610743812;
    function  URLEncode(const bstrIn: WideString): WideString; dispid 1610743813;
    function  URLPathEncode(const bstrIn: WideString): WideString; dispid 1610743814;
    procedure Execute(const bstrLogicalPath: WideString); dispid 1610743815;
    procedure Transfer(const bstrLogicalPath: WideString); dispid 1610743816;
    function  GetLastError: IASPError; dispid 1610743817;
  end;

// *********************************************************************//
// Interface: IScriptingContext
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D97A6DA0-A868-11CF-83AE-00B0C90C2BD8}
// *********************************************************************//
  IScriptingContext = interface(IDispatch)
    ['{D97A6DA0-A868-11CF-83AE-00B0C90C2BD8}']
    function  Get_Request: IRequest; safecall;
    function  Get_Response: IResponse; safecall;
    function  Get_Server: IServer; safecall;
    function  Get_Session: ISessionObject; safecall;
    function  Get_Application: IApplicationObject; safecall;
    property Request: IRequest read Get_Request;
    property Response: IResponse read Get_Response;
    property Server: IServer read Get_Server;
    property Session: ISessionObject read Get_Session;
    property Application: IApplicationObject read Get_Application;
  end;

// *********************************************************************//
// DispIntf:  IScriptingContextDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D97A6DA0-A868-11CF-83AE-00B0C90C2BD8}
// *********************************************************************//
  IScriptingContextDisp = dispinterface
    ['{D97A6DA0-A868-11CF-83AE-00B0C90C2BD8}']
    property Request: IRequest readonly dispid 1610743808;
    property Response: IResponse readonly dispid 1610743809;
    property Server: IServer readonly dispid 1610743810;
    property Session: ISessionObject readonly dispid 1610743811;
    property Application: IApplicationObject readonly dispid 1610743812;
  end;

// *********************************************************************//
// The Class CoRequest provides a Create and CreateRemote method to          
// create instances of the default interface IRequest exposed by              
// the CoClass Request. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRequest = class
    class function Create: IRequest;
    class function CreateRemote(const MachineName: string): IRequest;
  end;

// *********************************************************************//
// The Class CoResponse provides a Create and CreateRemote method to          
// create instances of the default interface IResponse exposed by              
// the CoClass Response. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoResponse = class
    class function Create: IResponse;
    class function CreateRemote(const MachineName: string): IResponse;
  end;

// *********************************************************************//
// The Class CoSession provides a Create and CreateRemote method to          
// create instances of the default interface ISessionObject exposed by              
// the CoClass Session. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSession = class
    class function Create: ISessionObject;
    class function CreateRemote(const MachineName: string): ISessionObject;
  end;

// *********************************************************************//
// The Class CoApplication provides a Create and CreateRemote method to          
// create instances of the default interface IApplicationObject exposed by              
// the CoClass Application. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoApplication = class
    class function Create: IApplicationObject;
    class function CreateRemote(const MachineName: string): IApplicationObject;
  end;

// *********************************************************************//
// The Class CoServer provides a Create and CreateRemote method to          
// create instances of the default interface IServer exposed by              
// the CoClass Server. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoServer = class
    class function Create: IServer;
    class function CreateRemote(const MachineName: string): IServer;
  end;

// *********************************************************************//
// The Class CoScriptingContext provides a Create and CreateRemote method to          
// create instances of the default interface IScriptingContext exposed by              
// the CoClass ScriptingContext. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoScriptingContext = class
    class function Create: IScriptingContext;
    class function CreateRemote(const MachineName: string): IScriptingContext;
  end;

implementation

uses ComObj;

class function CoRequest.Create: IRequest;
begin
  Result := CreateComObject(CLASS_Request) as IRequest;
end;

class function CoRequest.CreateRemote(const MachineName: string): IRequest;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Request) as IRequest;
end;

class function CoResponse.Create: IResponse;
begin
  Result := CreateComObject(CLASS_Response) as IResponse;
end;

class function CoResponse.CreateRemote(const MachineName: string): IResponse;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Response) as IResponse;
end;

class function CoSession.Create: ISessionObject;
begin
  Result := CreateComObject(CLASS_Session) as ISessionObject;
end;

class function CoSession.CreateRemote(const MachineName: string): ISessionObject;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Session) as ISessionObject;
end;

class function CoApplication.Create: IApplicationObject;
begin
  Result := CreateComObject(CLASS_Application) as IApplicationObject;
end;

class function CoApplication.CreateRemote(const MachineName: string): IApplicationObject;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Application) as IApplicationObject;
end;

class function CoServer.Create: IServer;
begin
  Result := CreateComObject(CLASS_Server) as IServer;
end;

class function CoServer.CreateRemote(const MachineName: string): IServer;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Server) as IServer;
end;

class function CoScriptingContext.Create: IScriptingContext;
begin
  Result := CreateComObject(CLASS_ScriptingContext) as IScriptingContext;
end;

class function CoScriptingContext.CreateRemote(const MachineName: string): IScriptingContext;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ScriptingContext) as IScriptingContext;
end;

end.
