// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://ly/ws/userws.exe/wsdl/IUserService
// Encoding : utf-8
// Version  : 1.0
// (03-5-17 18:00:30 - 1.33.2.5)
// ************************************************************************ //
//Download by http://www.codefans.net
unit uIUserService;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"
  // !:TStringDynArray - "http://www.borland.com/namespaces/Types"
  // !:int             - "http://www.w3.org/2001/XMLSchema"


  // ************************************************************************ //
  // Namespace : urn:UserServiceIntf-IUserService
  // soapAction: urn:UserServiceIntf-IUserService#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : IUserServicebinding
  // service   : IUserServiceservice
  // port      : IUserServicePort
  // URL       : http://ly/ws/userws.exe/soap/IUserService
  // ************************************************************************ //
  IUserService = interface(IInvokable)
  ['{949C2188-EA15-7F7F-ECC1-C47B2AA2DA3C}']
    function  GetDepList(out iCount: Integer): TStringDynArray; stdcall;
    function  GetUserList(const strName: WideString): WideString; stdcall;
    function  UpdateUserData(const UserData: WideString): Integer; stdcall;
  end;

function GetIUserService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IUserService;


implementation

function GetIUserService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IUserService;
const
  defWSDL = 'http://ly/ws/userws.exe/wsdl/IUserService';
  defURL  = 'http://ly/ws/userws.exe/soap/IUserService';
  defSvc  = 'IUserServiceservice';
  defPrt  = 'IUserServicePort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as IUserService);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  InvRegistry.RegisterInterface(TypeInfo(IUserService), 'urn:UserServiceIntf-IUserService', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IUserService), 'urn:UserServiceIntf-IUserService#%operationName%');

end.