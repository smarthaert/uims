//**************************************************************
//                                                             *
//                          IntShCut                           *                                                      *
//                 For Delphi 5, 6, 7, 2005, 2006              *
//                     Freeware    unit                        *
//                            by                               *
//                     Per Linds� Larsen                       *
//                   per.lindsoe@larsen.dk                     *
//                                                             *
//  Contributions:                                             *
//  Eran Bodankin (bsalsa) bsalsa@bsalsa.no-ip.info            *
//         -  D2005 update                                     *
//                                                             *
//  Updated versions:                                          *
//               http://www.bsalsa.com                         *
//**************************************************************

{*******************************************************************************}
{LICENSE:
THIS SOFTWARE IS PROVIDED TO YOU "AS IS" WITHOUT WARRANTY OF ANY KIND,
EITHER EXPRESSED OR IMPLIED INCLUDING BUT NOT LIMITED TO THE APPLIED
WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
YOU ASSUME THE ENTIRE RISK AS TO THE ACCURACY AND THE USE OF THE SOFTWARE
AND ALL OTHER RISK ARISING OUT OF THE USE OR PERFORMANCE OF THIS SOFTWARE
AND DOCUMENTATION. [YOUR NAME] DOES NOT WARRANT THAT THE SOFTWARE IS ERROR-FREE
OR WILL OPERATE WITHOUT INTERRUPTION. THE SOFTWARE IS NOT DESIGNED, INTENDED
OR LICENSED FOR USE IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE CONTROLS,
INCLUDING WITHOUT LIMITATION, THE DESIGN, CONSTRUCTION, MAINTENANCE OR
OPERATION OF NUCLEAR FACILITIES, AIRCRAFT NAVIGATION OR COMMUNICATION SYSTEMS,
AIR TRAFFIC CONTROL, AND LIFE SUPPORT OR WEAPONS SYSTEMS. VSOFT SPECIFICALLY
DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF FITNESS FOR SUCH PURPOSE.

You may use, change or modify the component under 3 conditions:
1. In your website, add a link to "http://www.bsalsa.com"
2. In your application, add credits to "Embedded Web Browser"
3. Mail me  (bsalsa@bsalsa.com) any code change in the unit
   for the benefit of the other users.
{*******************************************************************************}


unit IntShCut;

interface

{$I EWB.inc}

uses windows;

const

 IID_IUniformResourceLocatorA: TGUID = (
    D1:$FBF23B80; D2:$E3F0; D3:$101B; D4:($84,$88,$00,$AA,$00,$3E,$56,$F8));

 IID_IUniformResourceLocatorW: TGUID = (
    D1:$CABB0DA0; D2:$DA57; D3:$11CF; D4:($99,$74,$00,$20,$AF,$D7,$97,$62));


{$IFDEF UNICODE}
 IID_IUniformResourceLocator: TGUID = (
    D1:$CABB0DA0; D2:$DA57; D3:$11CF; D4:($99,$74,$00,$20,$AF,$D7,$97,$62));
{$ELSE}
 IID_IUniformResourceLocator : TGUID = (
    D1:$FBF23B80; D2:$E3F0; D3:$101B; D4:($84,$88,$00,$AA,$00,$3E,$56,$F8));
{$ENDIF}



CLSID_InternetShortCut : TGUID = (
    d1:$FBF23B40; D2:$E3F0; D3:$101B; D4:($84,$88,$00,$AA,$00,$3E,$56,$F8));

 SID_IUniformResourceLocatorA  = '{FBF23B80-E3F0-101B-8488-00AA003E56F8}';
 SID_IUniformResourceLocatorW  = '{CABB0DA0-DA57-11CF-9974-0020AFD79762}';
{$IFDEF UNICODE}
 SID_IUniformResourceLocator  = SID_IUniformResourceLocatorW;
{$ELSE}
 SID_IUniformResourceLocator  = SID_IUniformResourceLocatorA;
{$ENDIF}



   IURL_SETURL_FL_GUESS_PROTOCOL        = $0001;     // Guess protocol if missing
   IURL_SETURL_FL_USE_DEFAULT_PROTOCOL  = $0002;     // Use default protocol if missing

   IURL_INVOKECOMMAND_FL_ALLOW_UI                  = $0001;
   IURL_INVOKECOMMAND_FL_USE_DEFAULT_VERB          = $0002;    // Ignore pcszVerb
   IURL_INVOKECOMMAND_FL_DDEWAIT                   = $0004;    // pass DDEWAIT to ShellExec

   TRANSLATEURL_FL_GUESS_PROTOCOL         = $0001;     // Guess protocol if missing
   TRANSLATEURL_FL_USE_DEFAULT_PROTOCOL   = $0002;     // Use default protocol if missing

   URLASSOCDLG_FL_USE_DEFAULT_NAME        = $0001;
   URLASSOCDLG_FL_REGISTER_ASSOC          = $0002;

   MIMEASSOCDLG_FL_REGISTER_ASSOC         = $0001;

type

PUrlInvokeCommandInfoA = ^TUrlInvokeCommandInfoA;

TUrlInvokeCommandInfoA = record
   dwcbSize : DWORD;          // Size of structure
   dwFlags : DWORD;           // Bit field of IURL_INVOKECOMMAND_FLAGS
   hwndParent : HWND;        // Parent window.  Valid only if IURL_INVOKECOMMAND_FL_ALLOW_UI is set.
   pcszVerb : LPCSTR;          // Verb to invoke.  Ignored if IURL_INVOKECOMMAND_FL_USE_DEFAULT_VERB is set.
end;



PUrlInvokeCommandInfoW = ^TUrlInvokeCommandInfoW;
TUrlInvokeCommandInfoW = record
   dwcbSize : DWORD;          // Size of structure
   dwFlags : DWORD;           // Bit field of IURL_INVOKECOMMAND_FLAGS
   hwndParent : HWND;        // Parent window.  Valid only if IURL_INVOKECOMMAND_FL_ALLOW_UI is set.
   pcszVerb : LPCWSTR;          // Verb to invoke.  Ignored if IURL_INVOKECOMMAND_FL_USE_DEFAULT_VERB is set.
end;

{$IFDEF UNICODE}
PURLInvokeCommandInfo = ^TUrlInvokeCommandInfoW;
TUrlInvokeCommandInfo = TUrlInvokeCOmmandInfoW;
{$ELSE}
PURLInvokeCommandInfo = ^TUrlInvokeCommandInfoA;
TUrlInvokeCommandInfo = TUrlInvokeCOmmandInfoA;
{$ENDIF}




  IUniformResourceLocatorA = interface(IUnknown)
    [SID_IUniformResourceLocatorA]
   function SetURL(pcszURL : LpcStr; dwInFlags: DWORD): HRESULT; stdcall;
   function GetURL(ppszURL : LpStr): HRESULT; stdcall;
   function InvokeCommand(purlici : PURLINVOKECOMMANDINFOA): HRESULT; stdcall;

  end;



  IUniformResourceLocatorW = interface(IUnknown)
     [SID_IUniformResourceLocatorW]
   function SetURL(pcszURL : LpcWStr; dwInFlags: DWORD): HRESULT; stdcall;
   function GetURL(ppszURL : LpWStr): HRESULT; stdcall;
   function InvokeCommand(purlici : PURLINVOKECOMMANDINFOW): HRESULT; stdcall;
  end;


{$IFDEF UNICODE}
  IUniformResourceLocator = IUniformResourceLocatorW;
{$ELSE}
  IUniformResourceLocator = IUniformResourceLocatorA;
{$ENDIF}

function TranslateURLA(pcszURL : LPCSTR;
              dwInFlags : DWORD;
              ppszTranslatedURL : LPSTR) : HRESULT; stdcall;


function TranslateURLW(pcszURL : LPCWSTR;
              dwInFlags : DWORD;
              ppszTranslatedURL : LPWSTR) : HRESULT; stdcall;

{$IFDEF UNICODE}
function TranslateURL(pcszURL : LPCWSTR;
              dwInFlags : DWORD;
              ppszTranslatedURL : LPWSTR) : HRESULT; stdcall;
{$ELSE}
function TranslateURL(pcszURL : LPCSTR;
              dwInFlags : DWORD;
              ppszTranslatedURL : LPSTR) : HRESULT; stdcall;
{$ENDIF}


function URLAssociationDialogA(hwndParent : HWND;
                      dwInFlags : DWORD;
                      pcszFile : LPCSTR;
                      pcszURL : LPCSTR;
                      pszAppBuf : LPSTR;
                      ucAppBufLen : UINT) : HRESULT; stdcall;

function URLAssociationDialogW(hwndParent : HWND;
                      dwInFlags : DWORD;
                      pcszFile : LPCWSTR;
                      pcszURL : LPCWSTR;
                      pszAppBuf : LPWSTR;
                      ucAppBufLen : UINT) : HRESULT;  stdcall;

{$IFDEF UNICODE}
function URLAssociationDialog(hwndParent : HWND;
                      dwInFlags : DWORD;
                      pcszFile : LPCWSTR;
                      pcszURL : LPCWSTR;
                      pszAppBuf : LPWSTR;
                      ucAppBufLen : UINT) : HRESULT;  stdcall;
{$ELSE}
function URLAssociationDialog(hwndParent : HWND;
                      dwInFlags : DWORD;
                      pcszFile : LPCSTR;
                      pcszURL : LPCSTR;
                      pszAppBuf : LPSTR;
                      ucAppBufLen : UINT) : HRESULT; stdcall;
{$ENDIF}



function MIMEAssociationDialogA(hwndParent : HWND;
                                dwInFlags : DWORD;
                                pcszFile : LPCSTR;
                                pcszMIMEContentType : LPCSTR;
                                pszAppBuf : LPSTR;
                                ucAppBufLen : UINT) : HRESULT; stdcall;


function MIMEAssociationDialogW(hwndParent : HWND;
                                dwInFlags : DWORD;
                                pcszFile : LPCWSTR;
                                pcszMIMEContentType : LPCWSTR;
                                pszAppBuf : LPWSTR;
                                ucAppBufLen : UINT) : HRESULT; stdcall;

{$IFDEF UNICODE}
function MIMEAssociationDialog(hwndParent : HWND;
                                dwInFlags : DWORD;
                                pcszFile : LPCWSTR;
                                pcszMIMEContentType : LPCWSTR;
                                pszAppBuf : LPWSTR;
                                ucAppBufLen : UINT) : HRESULT; stdcall;
{$ELSE}
function MIMEAssociationDialog(hwndParent : HWND;
                                dwInFlags : DWORD;
                                pcszFile : LPCSTR;
                                pcszMIMEContentType : LPCSTR;
                                pszAppBuf : LPSTR;
                                ucAppBufLen : UINT) : HRESULT; stdcall;
{$ENDIF}

function InetIsOffline(dwFlags: DWORD): BOOL; stdcall;


implementation

const
urldll = 'url.dll';

function InetIsOffline; external urldll name 'InetIsOffline';

function MIMEAssociationDialogW; external urldll name 'MIMEAssociationDialogW';
function MIMEAssociationDialogA; external urldll name 'MIMEAssociationDialogA';
{$IFDEF UNICODE}
function MIMEAssociationDialog; external urldll name 'MIMEAssociationDialogW';
{$ELSE}
function MIMEAssociationDialog; external urldll name 'MIMEAssociationDialogA';
{$ENDIF}

function URLAssociationDialogW; external urldll name 'URLAssociationDialogW';
function URLAssociationDialogA; external urldll name 'URLAssociationDialogA';
{$IFDEF UNICODE}
function URLAssociationDialog; external urldll name 'URLAssociationDialogW';
{$ELSE}
function URLAssociationDialog; external urldll name 'URLAssociationDialogA';
{$ENDIF}

function TranslateURLA; external urldll name 'TranslateURLA';
function TranslateURLW; external urldll name 'TranslateURLW';
{$IFDEF UNICODE}
function TranslateURL; external urldll name 'TranslateURLW';
{$ELSE}
function TranslateURL; external urldll name 'TranslateURLA';
{$ENDIF}

end.
