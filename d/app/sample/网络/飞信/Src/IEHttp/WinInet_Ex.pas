unit WinInet_Ex;

interface

//this unit defines and overwrites the wide version of TURLComponents
//that is currently (d2007) in wininet.pas

uses windows, wininet;

type
  PURLComponents = ^URL_COMPONENTS;
  URL_COMPONENTS = record
    dwStructSize: DWORD;        { size of this structure. Used in version check }
    lpszScheme: PWideChar;      { pointer to scheme name }
    dwSchemeLength: DWORD;      { length of scheme name }
    nScheme: TInternetScheme;   { enumerated scheme type (if known) }
    lpszHostName: PWideChar;    { pointer to host name }
    dwHostNameLength: DWORD;    { length of host name }
    nPort: INTERNET_PORT;       { converted port number }
    pad: WORD;                  { force correct allignment regardless of comp. flags}
    lpszUserName: PWideChar;    { pointer to user name }
    dwUserNameLength: DWORD;    { length of user name }
    lpszPassword: PWideChar;    { pointer to password }
    dwPasswordLength: DWORD;    { length of password }
    lpszUrlPath: PWideChar;     { pointer to URL-path }
    dwUrlPathLength: DWORD;     { length of URL-path }
    lpszExtraInfo: PWideChar;   { pointer to extra information (e.g. ?foo or #foo) }
    dwExtraInfoLength: DWORD;   { length of extra information }
  end;
  {$EXTERNALSYM URL_COMPONENTS}
  TURLComponents = URL_COMPONENTS;

function InternetCrackUrlW(lpszUrl: PWideChar; dwUrlLength, dwFlags: DWORD;
  var lpUrlComponents: TURLComponents): BOOL; stdcall; external 'wininet.dll' name 'InternetCrackUrlW';

implementation

end.
