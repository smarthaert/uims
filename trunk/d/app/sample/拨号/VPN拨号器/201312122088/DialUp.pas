(****************************************** |******************************************
 *  DIALUP, telefonicke pripojeni site    * |*  DIALUP, dial-up networking component  *
 *     komponenta pro Delphi 3,4   (32b)  * |*               for Delphi 3,4   (32b)   *
 *              (c) 1998,99 BEALsoft      * |*              (c) 1998,99 BEALsoft      *
 *                       v1.31            * |*                       v1.31            *
 *________________________________________* |*________________________________________*
 *    !! TATO KOMPONENTA JE ZDARMA !!     * |*     !! THIS COMPONENT IS FREE !!       *
 ****************************************** |******************************************)
// Kontakt na autora // Contact to author :
// aberka@usa.net, ICQ UIN 2365308, http://bealsoft.cjb.net/ or http://come.to/aberka
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// See README.TXT for details, description of properties and methods
// Prectete si CTIMNE.TXT, kde jsou popsany vsechny dulezite funkce a vlastnosti

// Thanx to Davide Moretti for his RAS API header (Some code in this component
//  was written by him). You can reach him via e-mail: dmoretti@iper.net
// Also thanx to Magenta Systems ltd. for perfstats methods!

// News in v1.1
//   fixed bug - SetEntryUserName and SetEntryPassword
//   new - dynamic loading of dll, only when needed => you can add this component to
//         delphi on computer w/out RAS DLLs.
//
// News in v1.2
//   new - GetIP(<HANDLE_TO_CONNECTION>) sets properties ServerIP,ClientIP
//
// News in v1.3
//   new - In Win98, Win95 (with MSDUN 1.2 [MSDUN12.exe] installed) and in WinNT you can get
//           transfer statistics. Except NT you can also get connection speed.
//           InitializePerfStats(BOOL,BOOL) - 1st BOOL - Get values immediately
//                                            2nd BOOL - Don't use DUNA_KEY property,
//                                                       use 1st value found in registry {RECOMMENDED}
//                                                        // Available keys are in DUNA after calling SearchDUNA
//           GetPerfStats - write actual values into properties:
//                        - BytesXmit,BytesRecv,ConnectionSpeed
// News in v1.31
//   new - PORTUGUESE translation ;-)
//
// Future plans: connection speed on NT4>

unit DialUp;

interface

uses
  SysUtils, Windows, Dialogs, Classes, ExtCtrls, Forms, Messages;

{******************************************************}
{******************************************************}
{******************************************************}
// RAS API header by Davide Moretti
{******************************************************}
{******************************************************}
{******************************************************}
(*RASAPI*){* Copyright (c) 1992-1995, Microsoft Corporation, all rights reserved
(*RASAPI*)**
(*RASAPI*)** ras.h
(*RASAPI*)** Remote Access external API
(*RASAPI*)** Public header for external API clients
(*RASAPI*)*}
(*RASAPI*)
(*RASAPI*){ Delphi conversion by Davide Moretti <dmoretti@iper.net> }
(*RASAPI*){ Note: All functions and structures defaults to Ansi. If you want to use
(*RASAPI*)  Unicode structs and funcs, use the names ending with 'W' }
(*RASAPI*)
(*RASAPI*)const
(*RASAPI*){ These are from lmcons.h }
(*RASAPI*)  DNLEN            = 15;  // Maximum domain name length
(*RASAPI*)  UNLEN            = 256; // Maximum user name length
(*RASAPI*)  PWLEN            = 256; // Maximum password length
(*RASAPI*)  NETBIOS_NAME_LEN = 16;  // NetBIOS net name (bytes)
(*RASAPI*)
(*RASAPI*)  RAS_MaxDeviceType     = 16;
(*RASAPI*)  RAS_MaxPhoneNumber    = 128;
(*RASAPI*)  RAS_MaxIpAddress      = 15;
(*RASAPI*)  RAS_MaxIpxAddress     = 21;
(*RASAPI*)  RAS_MaxEntryName      = 256;
(*RASAPI*)  RAS_MaxDeviceName     = 128;
(*RASAPI*)  RAS_MaxCallbackNumber = RAS_MaxPhoneNumber;
(*RASAPI*)
(*RASAPI*)type
(*RASAPI*)  LPHRasConn = ^THRasConn;
(*RASAPI*)  THRasConn  = Longint;
(*RASAPI*)
(*RASAPI*){* Identifies an active RAS connection.  (See RasEnumConnections) *}
(*RASAPI*)  LPRasConnW = ^TRasConnW;
(*RASAPI*)  TRasConnW  = record
(*RASAPI*)    dwSize       : Longint;
(*RASAPI*)    hrasconn     : THRasConn;
(*RASAPI*)    szEntryName  : Array[0..RAS_MaxEntryName] of WideChar;
(*RASAPI*)    szDeviceType : Array[0..RAS_MaxDeviceType] of WideChar;
(*RASAPI*)    szDeviceName : Array[0..RAS_MaxDeviceName] of WideChar;
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)  LPRasConnA = ^TRasConnA;
(*RASAPI*)  TRasConnA  = record
(*RASAPI*)    dwSize       : Longint;
(*RASAPI*)    hrasconn     : THRasConn;
(*RASAPI*)    szEntryName  : Array[0..RAS_MaxEntryName] of AnsiChar;
(*RASAPI*)    szDeviceType : Array[0..RAS_MaxDeviceType] of AnsiChar;
(*RASAPI*)    szDeviceName : Array[0..RAS_MaxDeviceName] of AnsiChar;
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)  LPRasConn = ^TRasConn;
(*RASAPI*)  TRasConn  = TRasConnA;
(*RASAPI*)
(*RASAPI*)const
(*RASAPI*){* Enumerates intermediate states to a connection.  (See RasDial) *}
(*RASAPI*)  RASCS_PAUSED = $1000;
(*RASAPI*)  RASCS_DONE   = $2000;
(*RASAPI*)
(*RASAPI*)type
(*RASAPI*)  LPRasConnState = ^TRasConnState;
(*RASAPI*)  TRasConnState  = Integer;
(*RASAPI*)
(*RASAPI*)const
(*RASAPI*)  RASCS_OpenPort                  = 0;
(*RASAPI*)  RASCS_PortOpened                = 1;
(*RASAPI*)  RASCS_ConnectDevice             = 2;
(*RASAPI*)  RASCS_DeviceConnected           = 3;
(*RASAPI*)  RASCS_AllDevicesConnected       = 4;
(*RASAPI*)  RASCS_Authenticate              = 5;
(*RASAPI*)  RASCS_AuthNotify                = 6;
(*RASAPI*)  RASCS_AuthRetry                 = 7;
(*RASAPI*)  RASCS_AuthCallback              = 8;
(*RASAPI*)  RASCS_AuthChangePassword        = 9;
(*RASAPI*)  RASCS_AuthProject               = 10;
(*RASAPI*)  RASCS_AuthLinkSpeed             = 11;
(*RASAPI*)  RASCS_AuthAck                   = 12;
(*RASAPI*)  RASCS_ReAuthenticate            = 13;
(*RASAPI*)  RASCS_Authenticated             = 14;
(*RASAPI*)  RASCS_PrepareForCallback        = 15;
(*RASAPI*)  RASCS_WaitForModemReset         = 16;
(*RASAPI*)  RASCS_WaitForCallback           = 17;
(*RASAPI*)  RASCS_Projected                 = 18;
(*RASAPI*)  RASCS_StartAuthentication       = 19;
(*RASAPI*)  RASCS_CallbackComplete          = 20;
(*RASAPI*)  RASCS_LogonNetwork              = 21;
(*RASAPI*)
(*RASAPI*)  RASCS_Interactive               = RASCS_PAUSED;
(*RASAPI*)  RASCS_RetryAuthentication       = RASCS_PAUSED + 1;
(*RASAPI*)  RASCS_CallbackSetByCaller       = RASCS_PAUSED + 2;
(*RASAPI*)  RASCS_PasswordExpired           = RASCS_PAUSED + 3;
(*RASAPI*)
(*RASAPI*)  RASCS_Connected                 = RASCS_DONE;
(*RASAPI*)  RASCS_Disconnected              = RASCS_DONE + 1;
(*RASAPI*)
(*RASAPI*)type
(*RASAPI*){* Describes the status of a RAS connection.  (See RasConnectionStatus)*}
(*RASAPI*)  LPRasConnStatusW = ^TRasConnStatusW;
(*RASAPI*)  TRasConnStatusW  = record
(*RASAPI*)    dwSize         : Longint;
(*RASAPI*)    rasconnstate   : TRasConnState;
(*RASAPI*)    dwError        : LongInt;
(*RASAPI*)    szDeviceType   : Array[0..RAS_MaxDeviceType] of WideChar;
(*RASAPI*)    szDeviceName   : Array[0..RAS_MaxDeviceName] of WideChar;
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)  LPRasConnStatusA = ^TRasConnStatusA;
(*RASAPI*)  TRasConnStatusA  = record
(*RASAPI*)    dwSize         : Longint;
(*RASAPI*)    rasconnstate   : TRasConnState;
(*RASAPI*)    dwError        : LongInt;
(*RASAPI*)    szDeviceType   : Array[0..RAS_MaxDeviceType] of AnsiChar;
(*RASAPI*)    szDeviceName   : Array[0..RAS_MaxDeviceName] of AnsiChar;
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)  LPRasConnStatus = ^TRasConnStatus;
(*RASAPI*)  TRasConnStatus  = TRasConnStatusA;
(*RASAPI*)
(*RASAPI*){* Describes connection establishment parameters.  (See RasDial)*}
(*RASAPI*)  LPRasDialParamsW = ^TRasDialParamsW;
(*RASAPI*)  TRasDialParamsW  = record
(*RASAPI*)    dwSize           : LongInt;
(*RASAPI*)    szEntryName      : Array[0..RAS_MaxEntryName] of WideChar;
(*RASAPI*)    szPhoneNumber    : Array[0..RAS_MaxPhoneNumber] of WideChar;
(*RASAPI*)    szCallbackNumber : Array[0..RAS_MaxCallbackNumber] of WideChar;
(*RASAPI*)    szUserName       : Array[0..UNLEN] of WideChar;
(*RASAPI*)    szPassword       : Array[0..PWLEN] of WideChar;
(*RASAPI*)    szDomain         : Array[0..DNLEN] of WideChar;
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)  LPRasDialParamsA = ^TRasDialParamsA;
(*RASAPI*)  TRasDialParamsA  = record
(*RASAPI*)    dwSize           : LongInt;
(*RASAPI*)    szEntryName      : Array[0..RAS_MaxEntryName] of AnsiChar;
(*RASAPI*)    szPhoneNumber    : Array[0..RAS_MaxPhoneNumber] of AnsiChar;
(*RASAPI*)    szCallbackNumber : Array[0..RAS_MaxCallbackNumber] of AnsiChar;
(*RASAPI*)    szUserName       : Array[0..UNLEN] of AnsiChar;
(*RASAPI*)    szPassword       : Array[0..PWLEN] of AnsiChar;
(*RASAPI*)    szDomain         : Array[0..DNLEN] of AnsiChar;
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)  LPRasDialParams = ^TRasDialParams;
(*RASAPI*)  TRasDialParams  = TRasDialParamsA;
(*RASAPI*)
(*RASAPI*){* Describes extended connection establishment options.  (See RasDial)*}
(*RASAPI*)  LPRasDialExtensions = ^TRasDialExtensions;
(*RASAPI*)  TRasDialExtensions  = record
(*RASAPI*)    dwSize            : LongInt;
(*RASAPI*)    dwfOptions        : LongInt;
(*RASAPI*)    hwndParent        : HWND;
(*RASAPI*)    reserved          : LongInt;
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)const
(*RASAPI*){* 'dwfOptions' bit flags.*}
(*RASAPI*)  RDEOPT_UsePrefixSuffix           = $00000001;
(*RASAPI*)  RDEOPT_PausedStates              = $00000002;
(*RASAPI*)  RDEOPT_IgnoreModemSpeaker        = $00000004;
(*RASAPI*)  RDEOPT_SetModemSpeaker           = $00000008;
(*RASAPI*)  RDEOPT_IgnoreSoftwareCompression = $00000010;
(*RASAPI*)  RDEOPT_SetSoftwareCompression    = $00000020;
(*RASAPI*)
(*RASAPI*)
(*RASAPI*)type
(*RASAPI*)
(*RASAPI*){* Describes an enumerated RAS phone book entry name.  (See RasEntryEnum)*}
(*RASAPI*)  LPRasEntryNameW = ^TRasEntryNameW;
(*RASAPI*)  TRasEntryNameW  = record
(*RASAPI*)    dwSize        : Longint;
(*RASAPI*)    szEntryName   : Array[0..RAS_MaxEntryName] of WideChar;
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)  LPRasEntryNameA = ^TRasEntryNameA;
(*RASAPI*)  TRasEntryNameA  = record
(*RASAPI*)    dwSize        : Longint;
(*RASAPI*)    szEntryName   : Array[0..RAS_MaxEntryName] of AnsiChar;
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)  LPRasEntryName = ^TRasEntryName;
(*RASAPI*)  TRasEntryName  = TRasEntryNameA;
(*RASAPI*)
(*RASAPI*){* Protocol code to projection data structure mapping.*}
(*RASAPI*)  LPRasProjection = ^TRasProjection;
(*RASAPI*)  TRasProjection  = Integer;
(*RASAPI*)
(*RASAPI*)const
(*RASAPI*)  RASP_Amb        = $10000;
(*RASAPI*)  RASP_PppNbf     = $803F;
(*RASAPI*)  RASP_PppIpx     = $802B;
(*RASAPI*)  RASP_PppIp      = $8021;
(*RASAPI*)
(*RASAPI*)
(*RASAPI*)type
(*RASAPI*){* Describes the result of a RAS AMB (Authentication Message Block)
(*RASAPI*)** projection.  This protocol is used with NT 3.1 and OS/2 1.3 downlevel
(*RASAPI*)** RAS servers.*}
(*RASAPI*)  LPRasAmbW = ^TRasAmbW;
(*RASAPI*)  TRasAmbW  = record
(*RASAPI*)    dwSize         : Longint;
(*RASAPI*)    dwError        : Longint;
(*RASAPI*)    szNetBiosError : Array[0..NETBIOS_NAME_LEN] of WideChar;
(*RASAPI*)    bLana          : Byte;
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)  LPRasAmbA = ^TRasAmbA;
(*RASAPI*)  TRasAmbA  = record
(*RASAPI*)    dwSize         : Longint;
(*RASAPI*)    dwError        : Longint;
(*RASAPI*)    szNetBiosError : Array[0..NETBIOS_NAME_LEN] of AnsiChar;
(*RASAPI*)    bLana          : Byte;
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)  LPRasAmb = ^TRasAmb;
(*RASAPI*)  TRasAmb  = TRasAmbA;
(*RASAPI*)
(*RASAPI*){* Describes the result of a PPP NBF (NetBEUI) projection.*}
(*RASAPI*)  LPRasPppNbfW = ^TRasPppNbfW;
(*RASAPI*)  TRasPppNbfW  = record
(*RASAPI*)    dwSize             : Longint;
(*RASAPI*)    dwError            : Longint;
(*RASAPI*)    dwNetBiosError     : Longint;
(*RASAPI*)    szNetBiosError     : Array[0..NETBIOS_NAME_LEN] of WideChar;
(*RASAPI*)    szWorkstationName  : Array[0..NETBIOS_NAME_LEN] of WideChar;
(*RASAPI*)    bLana              : Byte;
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)  LPRasPppNbfA = ^TRasPppNbfA;
(*RASAPI*)  TRasPppNbfA  = record
(*RASAPI*)    dwSize             : Longint;
(*RASAPI*)    dwError            : Longint;
(*RASAPI*)    dwNetBiosError     : Longint;
(*RASAPI*)    szNetBiosError     : Array[0..NETBIOS_NAME_LEN] of AnsiChar;
(*RASAPI*)    szWorkstationName  : Array[0..NETBIOS_NAME_LEN] of AnsiChar;
(*RASAPI*)    bLana              : Byte;
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)  LpRaspppNbf = ^TRasPppNbf;
(*RASAPI*)  TRasPppNbf  = TRasPppNbfA;
(*RASAPI*)
(*RASAPI*){* Describes the results of a PPP IPX (Internetwork Packet Exchange)
(*RASAPI*)** projection.*}
(*RASAPI*)  LPRasPppIpxW = ^TRasPppIpxW;
(*RASAPI*)  TRasPppIpxW  = record
(*RASAPI*)    dwSize       : Longint;
(*RASAPI*)    dwError      : Longint;
(*RASAPI*)    szIpxAddress : Array[0..RAS_MaxIpxAddress] of WideChar;
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)  LPRasPppIpxA = ^TRasPppIpxA;
(*RASAPI*)  TRasPppIpxA  = record
(*RASAPI*)    dwSize       : Longint;
(*RASAPI*)    dwError      : Longint;
(*RASAPI*)    szIpxAddress : Array[0..RAS_MaxIpxAddress] of AnsiChar;
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)  LPRasPppIpx = ^TRasPppIpx;
(*RASAPI*)  TRasPppIpx  = TRasPppIpxA;
(*RASAPI*)
(*RASAPI*){* Describes the results of a PPP IP (Internet) projection.*}
(*RASAPI*)  LPRasPppIpW = ^TRasPppIpW;
(*RASAPI*)  TRasPppIpW  = record
(*RASAPI*)    dwSize      : Longint;
(*RASAPI*)    dwError     : Longint;
(*RASAPI*)    szIpAddress : Array[0..RAS_MaxIpAddress] of WideChar;
(*RASAPI*)
(*RASAPI*){$IFNDEF WINNT35COMPATIBLE}
(*RASAPI*)    {* This field was added between Windows NT 3.51 beta and Windows NT 3.51
(*RASAPI*)    ** final, and between Windows 95 M8 beta and Windows 95 final.  If you do
(*RASAPI*)    ** not require the server address and wish to retrieve PPP IP information
(*RASAPI*)    ** from Windows NT 3.5 or early Windows NT 3.51 betas, or on early Windows
(*RASAPI*)    ** 95 betas, define WINNT35COMPATIBLE.
(*RASAPI*)    **
(*RASAPI*)    ** The server IP address is not provided by all PPP implementations,
(*RASAPI*)    ** though Windows NT server's do provide it.    *}
(*RASAPI*)    szServerIpAddress: Array[0..RAS_MaxIpAddress] of WideChar;
(*RASAPI*){$ENDIF}
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)  LPRasPppIpA = ^TRasPppIpA;
(*RASAPI*)  TRasPppIpA  = record
(*RASAPI*)    dwSize      : Longint;
(*RASAPI*)    dwError     : Longint;
(*RASAPI*)    szIpAddress : Array[0..RAS_MaxIpAddress] of AnsiChar;
(*RASAPI*)
(*RASAPI*){$IFNDEF WINNT35COMPATIBLE} {* See RASPPPIPW comment. *}
(*RASAPI*)    szServerIpAddress: Array[0..RAS_MaxIpAddress] of AnsiChar;
(*RASAPI*){$ENDIF}
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)  LPRasPppIp = ^TRasPppIp;
(*RASAPI*)  TRasPppIp  = TRasPppIpA;
(*RASAPI*)
(*RASAPI*)
(*RASAPI*)const
(*RASAPI*){* If using RasDial message notifications, get the notification message code
(*RASAPI*)** by passing this string to the RegisterWindowMessageA() API.
(*RASAPI*)** WM_RASDIALEVENT is used only if a unique message cannot be registered.*}
(*RASAPI*)  RASDIALEVENT    = 'RasDialEvent';
(*RASAPI*)  WM_RASDIALEVENT = $CCCD;
(*RASAPI*)
(*RASAPI*)
(*RASAPI*){* Prototypes for caller's RasDial callback handler.  Arguments are the
(*RASAPI*)** message ID (currently always WM_RASDIALEVENT), the current RASCONNSTATE and
(*RASAPI*)** the error that has occurred (or 0 if none).  Extended arguments are the
(*RASAPI*)** handle of the RAS connection and an extended error code.
(*RASAPI*)*}
(*RASAPI*){
(*RASAPI*)typedef VOID (WINAPI *RASDIALFUNC)( UINT, RASCONNSTATE, DWORD );
(*RASAPI*)typedef VOID (WINAPI *RASDIALFUNC1)( HRASCONN, UINT, RASCONNSTATE, DWORD, DWORD );
(*RASAPI*)
(*RASAPI*)For Delphi: Just define the callback as
(*RASAPI*)procedure RASCallback(msg: Integer; state: TRasConnState;
(*RASAPI*)    dwError: Longint); stdcall;
(*RASAPI*) or
(*RASAPI*)procedure RASCallback1(hConn: THRasConn; msg: Integer;
(*RASAPI*)    state: TRasConnState; dwError: Longint; dwEexterror: Longint); stdcall;
(*RASAPI*)}
(*RASAPI*)
(*RASAPI*){* External RAS API function prototypes.
(*RASAPI*)*}
(*RASAPI*){Note: for Delphi the function without 'A' or 'W' is the Ansi one
(*RASAPI*)  as on the other Delphi headers}
(*RASAPI*)
(*RASAPI*)function RasDialA(lpRasDialExt: LPRasDialExtensions; lpszPhoneBook: PAnsiChar;
(*RASAPI*)                  var params: TRasDialParamsA; dwNotifierType: Longint;
(*RASAPI*)                  lpNotifier: Pointer; var rasconn: THRasConn): Longint; stdcall;
(*RASAPI*)function RasDialW(lpRasDialExt: LPRasDialExtensions; lpszPhoneBook: PWideChar;
(*RASAPI*)                  var params: TRasDialParamsW; dwNotifierType: Longint;
(*RASAPI*)                  lpNotifier: Pointer; var rasconn: THRasConn): Longint; stdcall;
(*RASAPI*)function RasDial(lpRasDialExt: LPRasDialExtensions; lpszPhoneBook: PAnsiChar;
(*RASAPI*)                 var params: TRasDialParams; dwNotifierType: Longint;
(*RASAPI*)                 lpNotifier: Pointer; var rasconn: THRasConn): Longint; stdcall;
(*RASAPI*)
(*RASAPI*)function RasEnumConnectionsA(RasConnArray: LPRasConnA; var lpcb: Longint;
(*RASAPI*)                             var lpcConnections: Longint): Longint; stdcall;
(*RASAPI*)function RasEnumConnectionsW(RasConnArray: LPRasConnW; var lpcb: Longint;
(*RASAPI*)                             var lpcConnections: Longint): Longint; stdcall;
(*RASAPI*)function RasEnumConnections(RasConnArray: LPRasConn; var lpcb: Longint;
(*RASAPI*)                             var lpcConnections: Longint): Longint; stdcall;
(*RASAPI*)
(*RASAPI*)function RasEnumEntriesA(Reserved: PAnsiChar; lpszPhoneBook: PAnsiChar;
(*RASAPI*)                         entrynamesArray: LPRasEntryNameA; var lpcb: Longint;
(*RASAPI*)                         var lpcEntries: Longint): Longint; stdcall;
(*RASAPI*)function RasEnumEntriesW(reserved: PWideChar; lpszPhoneBook: PWideChar;
(*RASAPI*)                         entrynamesArray: LPRasEntryNameW; var lpcb: Longint;
(*RASAPI*)                         var lpcEntries: Longint): Longint; stdcall;
(*RASAPI*)function RasEnumEntries(reserved: PAnsiChar; lpszPhoneBook: PAnsiChar;
(*RASAPI*)                        entrynamesArray: LPRasEntryName; var lpcb: Longint;
(*RASAPI*)                        var lpcEntries: Longint): Longint; stdcall;
(*RASAPI*)
(*RASAPI*)function RasGetConnectStatusA(hConn: THRasConn; var lpStatus: TRasConnStatusA): Longint; stdcall;
(*RASAPI*)function RasGetConnectStatusW(hConn: THRasConn;var lpStatus: TRasConnStatusW): Longint; stdcall;
(*RASAPI*)function RasGetConnectStatus(hConn: THRasConn;var lpStatus: TRasConnStatus): Longint; stdcall;
(*RASAPI*)
(*RASAPI*)function RasGetErrorStringA(errorValue: Integer;erroString: PAnsiChar;cBufSize: Longint): Longint; stdcall;
(*RASAPI*)function RasGetErrorStringW(errorValue: Integer;erroString: PWideChar;cBufSize: Longint): Longint; stdcall;
(*RASAPI*)function RasGetErrorString(errorValue: Integer;erroString: PAnsiChar;cBufSize: Longint): Longint; stdcall;
(*RASAPI*)
(*RASAPI*)function RasHangUpA(hConn: THRasConn): Longint; stdcall;
(*RASAPI*)function RasHangUpW(hConn: THRasConn): Longint; stdcall;
(*RASAPI*)function RasHangUp(hConn: THRasConn): Longint; stdcall;
(*RASAPI*)
(*RASAPI*)function RasGetProjectionInfoA(hConn: THRasConn; rasproj: TRasProjection;
(*RASAPI*)                               lpProjection: Pointer; var lpcb: Longint): Longint; stdcall;
(*RASAPI*)function RasGetProjectionInfoW(hConn: THRasConn; rasproj: TRasProjection;
(*RASAPI*)                               lpProjection: Pointer; var lpcb: Longint): Longint; stdcall;
(*RASAPI*)function RasGetProjectionInfo(hConn: THRasConn; rasproj: TRasProjection;
(*RASAPI*)                              lpProjection: Pointer; var lpcb: Longint): Longint; stdcall;
(*RASAPI*)
(*RASAPI*)function RasCreatePhonebookEntryA(hwndParentWindow: HWND;lpszPhoneBook: PAnsiChar): Longint; stdcall;
(*RASAPI*)function RasCreatePhonebookEntryW(hwndParentWindow: HWND;lpszPhoneBook: PWideChar): Longint; stdcall;
(*RASAPI*)function RasCreatePhonebookEntry(hwndParentWindow: HWND;lpszPhoneBook: PAnsiChar): Longint; stdcall;
(*RASAPI*)
(*RASAPI*)function RasEditPhonebookEntryA(hwndParentWindow: HWND; lpszPhoneBook: PAnsiChar;
(*RASAPI*)                                lpszEntryName: PAnsiChar): Longint; stdcall;
(*RASAPI*)function RasEditPhonebookEntryW(hwndParentWindow: HWND; lpszPhoneBook: PWideChar;
(*RASAPI*)                                lpszEntryName: PWideChar): Longint; stdcall;
(*RASAPI*)function RasEditPhonebookEntry(hwndParentWindow: HWND; lpszPhoneBook: PAnsiChar;
(*RASAPI*)                               lpszEntryName: PAnsiChar): Longint; stdcall;
(*RASAPI*)
(*RASAPI*)function RasSetEntryDialParamsA(lpszPhoneBook: PAnsiChar; var lpDialParams: TRasDialParamsA;
(*RASAPI*)                                fRemovePassword: LongBool): Longint; stdcall;
(*RASAPI*)function RasSetEntryDialParamsW(lpszPhoneBook: PWideChar; var lpDialParams: TRasDialParamsW;
(*RASAPI*)                                fRemovePassword: LongBool): Longint; stdcall;
(*RASAPI*)function RasSetEntryDialParams(lpszPhoneBook: PAnsiChar; var lpDialParams: TRasDialParams;
(*RASAPI*)                               fRemovePassword: LongBool): Longint; stdcall;
(*RASAPI*)
(*RASAPI*)function RasGetEntryDialParamsA(lpszPhoneBook: PAnsiChar; var lpDialParams: TRasDialParamsA;
(*RASAPI*)                                var lpfPassword: LongBool): Longint; stdcall;
(*RASAPI*)function RasGetEntryDialParamsW(lpszPhoneBook: PWideChar; var lpDialParams: TRasDialParamsW;
(*RASAPI*)                                var lpfPassword: LongBool): Longint; stdcall;
(*RASAPI*)function RasGetEntryDialParams(lpszPhoneBook: PAnsiChar; var lpDialParams: TRasDialParams;
(*RASAPI*)                               var lpfPassword: LongBool): Longint; stdcall;
(*RASAPI*)
(*RASAPI*){**
(*RASAPI*)** raserror.h
(*RASAPI*)** Remote Access external API
(*RASAPI*)** RAS specific error codes *}
(*RASAPI*)
(*RASAPI*)const
(*RASAPI*)  RASBASE = 600;
(*RASAPI*)  SUCCESS = 0;
(*RASAPI*)
(*RASAPI*)  PENDING                              = (RASBASE+0);
(*RASAPI*)  ERROR_INVALID_PORT_HANDLE            = (RASBASE+1);
(*RASAPI*)  ERROR_PORT_ALREADY_OPEN              = (RASBASE+2);
(*RASAPI*)  ERROR_BUFFER_TOO_SMALL               = (RASBASE+3);
(*RASAPI*)  ERROR_WRONG_INFO_SPECIFIED           = (RASBASE+4);
(*RASAPI*)  ERROR_CANNOT_SET_PORT_INFO           = (RASBASE+5);
(*RASAPI*)  ERROR_PORT_NOT_CONNECTED             = (RASBASE+6);
(*RASAPI*)  ERROR_EVENT_INVALID                  = (RASBASE+7);
(*RASAPI*)  ERROR_DEVICE_DOES_NOT_EXIST          = (RASBASE+8);
(*RASAPI*)  ERROR_DEVICETYPE_DOES_NOT_EXIST      = (RASBASE+9);
(*RASAPI*)  ERROR_BUFFER_INVALID                 = (RASBASE+10);
(*RASAPI*)  ERROR_ROUTE_NOT_AVAILABLE            = (RASBASE+11);
(*RASAPI*)  ERROR_ROUTE_NOT_ALLOCATED            = (RASBASE+12);
(*RASAPI*)  ERROR_INVALID_COMPRESSION_SPECIFIED  = (RASBASE+13);
(*RASAPI*)  ERROR_OUT_OF_BUFFERS                 = (RASBASE+14);
(*RASAPI*)  ERROR_PORT_NOT_FOUND                 = (RASBASE+15);
(*RASAPI*)  ERROR_ASYNC_REQUEST_PENDING          = (RASBASE+16);
(*RASAPI*)  ERROR_ALREADY_DISCONNECTING          = (RASBASE+17);
(*RASAPI*)  ERROR_PORT_NOT_OPEN                  = (RASBASE+18);
(*RASAPI*)  ERROR_PORT_DISCONNECTED              = (RASBASE+19);
(*RASAPI*)  ERROR_NO_ENDPOINTS                   = (RASBASE+20);
(*RASAPI*)  ERROR_CANNOT_OPEN_PHONEBOOK          = (RASBASE+21);
(*RASAPI*)  ERROR_CANNOT_LOAD_PHONEBOOK          = (RASBASE+22);
(*RASAPI*)  ERROR_CANNOT_FIND_PHONEBOOK_ENTRY    = (RASBASE+23);
(*RASAPI*)  ERROR_CANNOT_WRITE_PHONEBOOK         = (RASBASE+24);
(*RASAPI*)  ERROR_CORRUPT_PHONEBOOK              = (RASBASE+25);
(*RASAPI*)  ERROR_CANNOT_LOAD_STRING             = (RASBASE+26);
(*RASAPI*)  ERROR_KEY_NOT_FOUND                  = (RASBASE+27);
(*RASAPI*)  ERROR_DISCONNECTION                  = (RASBASE+28);
(*RASAPI*)  ERROR_REMOTE_DISCONNECTION           = (RASBASE+29);
(*RASAPI*)  ERROR_HARDWARE_FAILURE               = (RASBASE+30);
(*RASAPI*)  ERROR_USER_DISCONNECTION             = (RASBASE+31);
(*RASAPI*)  ERROR_INVALID_SIZE                   = (RASBASE+32);
(*RASAPI*)  ERROR_PORT_NOT_AVAILABLE             = (RASBASE+33);
(*RASAPI*)  ERROR_CANNOT_PROJECT_CLIENT          = (RASBASE+34);
(*RASAPI*)  ERROR_UNKNOWN                        = (RASBASE+35);
(*RASAPI*)  ERROR_WRONG_DEVICE_ATTACHED          = (RASBASE+36);
(*RASAPI*)  ERROR_BAD_STRING                     = (RASBASE+37);
(*RASAPI*)  ERROR_REQUEST_TIMEOUT                = (RASBASE+38);
(*RASAPI*)  ERROR_CANNOT_GET_LANA                = (RASBASE+39);
(*RASAPI*)  ERROR_NETBIOS_ERROR                  = (RASBASE+40);
(*RASAPI*)  ERROR_SERVER_OUT_OF_RESOURCES        = (RASBASE+41);
(*RASAPI*)  ERROR_NAME_EXISTS_ON_NET             = (RASBASE+42);
(*RASAPI*)  ERROR_SERVER_GENERAL_NET_FAILURE     = (RASBASE+43);
(*RASAPI*)  WARNING_MSG_ALIAS_NOT_ADDED          = (RASBASE+44);
(*RASAPI*)  ERROR_AUTH_INTERNAL                  = (RASBASE+45);
(*RASAPI*)  ERROR_RESTRICTED_LOGON_HOURS         = (RASBASE+46);
(*RASAPI*)  ERROR_ACCT_DISABLED                  = (RASBASE+47);
(*RASAPI*)  ERROR_PASSWD_EXPIRED                 = (RASBASE+48);
(*RASAPI*)  ERROR_NO_DIALIN_PERMISSION           = (RASBASE+49);
(*RASAPI*)  ERROR_SERVER_NOT_RESPONDING          = (RASBASE+50);
(*RASAPI*)  ERROR_FROM_DEVICE                    = (RASBASE+51);
(*RASAPI*)  ERROR_UNRECOGNIZED_RESPONSE          = (RASBASE+52);
(*RASAPI*)  ERROR_MACRO_NOT_FOUND                = (RASBASE+53);
(*RASAPI*)  ERROR_MACRO_NOT_DEFINED              = (RASBASE+54);
(*RASAPI*)  ERROR_MESSAGE_MACRO_NOT_FOUND        = (RASBASE+55);
(*RASAPI*)  ERROR_DEFAULTOFF_MACRO_NOT_FOUND     = (RASBASE+56);
(*RASAPI*)  ERROR_FILE_COULD_NOT_BE_OPENED       = (RASBASE+57);
(*RASAPI*)  ERROR_DEVICENAME_TOO_LONG            = (RASBASE+58);
(*RASAPI*)  ERROR_DEVICENAME_NOT_FOUND           = (RASBASE+59);
(*RASAPI*)  ERROR_NO_RESPONSES                   = (RASBASE+60);
(*RASAPI*)  ERROR_NO_COMMAND_FOUND               = (RASBASE+61);
(*RASAPI*)  ERROR_WRONG_KEY_SPECIFIED            = (RASBASE+62);
(*RASAPI*)  ERROR_UNKNOWN_DEVICE_TYPE            = (RASBASE+63);
(*RASAPI*)  ERROR_ALLOCATING_MEMORY              = (RASBASE+64);
(*RASAPI*)  ERROR_PORT_NOT_CONFIGURED            = (RASBASE+65);
(*RASAPI*)  ERROR_DEVICE_NOT_READY               = (RASBASE+66);
(*RASAPI*)  ERROR_READING_INI_FILE               = (RASBASE+67);
(*RASAPI*)  ERROR_NO_CONNECTION                  = (RASBASE+68);
(*RASAPI*)  ERROR_BAD_USAGE_IN_INI_FILE          = (RASBASE+69);
(*RASAPI*)  ERROR_READING_SECTIONNAME            = (RASBASE+70);
(*RASAPI*)  ERROR_READING_DEVICETYPE             = (RASBASE+71);
(*RASAPI*)  ERROR_READING_DEVICENAME             = (RASBASE+72);
(*RASAPI*)  ERROR_READING_USAGE                  = (RASBASE+73);
(*RASAPI*)  ERROR_READING_MAXCONNECTBPS          = (RASBASE+74);
(*RASAPI*)  ERROR_READING_MAXCARRIERBPS          = (RASBASE+75);
(*RASAPI*)  ERROR_LINE_BUSY                      = (RASBASE+76);
(*RASAPI*)  ERROR_VOICE_ANSWER                   = (RASBASE+77);
(*RASAPI*)  ERROR_NO_ANSWER                      = (RASBASE+78);
(*RASAPI*)  ERROR_NO_CARRIER                     = (RASBASE+79);
(*RASAPI*)  ERROR_NO_DIALTONE                    = (RASBASE+80);
(*RASAPI*)  ERROR_IN_COMMAND                     = (RASBASE+81);
(*RASAPI*)  ERROR_WRITING_SECTIONNAME            = (RASBASE+82);
(*RASAPI*)  ERROR_WRITING_DEVICETYPE             = (RASBASE+83);
(*RASAPI*)  ERROR_WRITING_DEVICENAME             = (RASBASE+84);
(*RASAPI*)  ERROR_WRITING_MAXCONNECTBPS          = (RASBASE+85);
(*RASAPI*)  ERROR_WRITING_MAXCARRIERBPS          = (RASBASE+86);
(*RASAPI*)  ERROR_WRITING_USAGE                  = (RASBASE+87);
(*RASAPI*)  ERROR_WRITING_DEFAULTOFF             = (RASBASE+88);
(*RASAPI*)  ERROR_READING_DEFAULTOFF             = (RASBASE+89);
(*RASAPI*)  ERROR_EMPTY_INI_FILE                 = (RASBASE+90);
(*RASAPI*)  ERROR_AUTHENTICATION_FAILURE         = (RASBASE+91);
(*RASAPI*)  ERROR_PORT_OR_DEVICE                 = (RASBASE+92);
(*RASAPI*)  ERROR_NOT_BINARY_MACRO               = (RASBASE+93);
(*RASAPI*)  ERROR_DCB_NOT_FOUND                  = (RASBASE+94);
(*RASAPI*)  ERROR_STATE_MACHINES_NOT_STARTED     = (RASBASE+95);
(*RASAPI*)  ERROR_STATE_MACHINES_ALREADY_STARTED = (RASBASE+96);
(*RASAPI*)  ERROR_PARTIAL_RESPONSE_LOOPING       = (RASBASE+97);
(*RASAPI*)  ERROR_UNKNOWN_RESPONSE_KEY           = (RASBASE+98);
(*RASAPI*)  ERROR_RECV_BUF_FULL                  = (RASBASE+99);
(*RASAPI*)  ERROR_CMD_TOO_LONG                   = (RASBASE+100);
(*RASAPI*)  ERROR_UNSUPPORTED_BPS                = (RASBASE+101);
(*RASAPI*)  ERROR_UNEXPECTED_RESPONSE            = (RASBASE+102);
(*RASAPI*)  ERROR_INTERACTIVE_MODE               = (RASBASE+103);
(*RASAPI*)  ERROR_BAD_CALLBACK_NUMBER            = (RASBASE+104);
(*RASAPI*)  ERROR_INVALID_AUTH_STATE             = (RASBASE+105);
(*RASAPI*)  ERROR_WRITING_INITBPS                = (RASBASE+106);
(*RASAPI*)  ERROR_X25_DIAGNOSTIC                 = (RASBASE+107);
(*RASAPI*)  ERROR_ACCT_EXPIRED                   = (RASBASE+108);
(*RASAPI*)  ERROR_CHANGING_PASSWORD              = (RASBASE+109);
(*RASAPI*)  ERROR_OVERRUN                        = (RASBASE+110);
(*RASAPI*)  ERROR_RASMAN_CANNOT_INITIALIZE       = (RASBASE+111);
(*RASAPI*)  ERROR_BIPLEX_PORT_NOT_AVAILABLE      = (RASBASE+112);
(*RASAPI*)  ERROR_NO_ACTIVE_ISDN_LINES           = (RASBASE+113);
(*RASAPI*)  ERROR_NO_ISDN_CHANNELS_AVAILABLE     = (RASBASE+114);
(*RASAPI*)  ERROR_TOO_MANY_LINE_ERRORS           = (RASBASE+115);
(*RASAPI*)  ERROR_IP_CONFIGURATION               = (RASBASE+116);
(*RASAPI*)  ERROR_NO_IP_ADDRESSES                = (RASBASE+117);
(*RASAPI*)  ERROR_PPP_TIMEOUT                    = (RASBASE+118);
(*RASAPI*)  ERROR_PPP_REMOTE_TERMINATED          = (RASBASE+119);
(*RASAPI*)  ERROR_PPP_NO_PROTOCOLS_CONFIGURED    = (RASBASE+120);
(*RASAPI*)  ERROR_PPP_NO_RESPONSE                = (RASBASE+121);
(*RASAPI*)  ERROR_PPP_INVALID_PACKET             = (RASBASE+122);
(*RASAPI*)  ERROR_PHONE_NUMBER_TOO_LONG          = (RASBASE+123);
(*RASAPI*)  ERROR_IPXCP_NO_DIALOUT_CONFIGURED    = (RASBASE+124);
(*RASAPI*)  ERROR_IPXCP_NO_DIALIN_CONFIGURED     = (RASBASE+125);
(*RASAPI*)  ERROR_IPXCP_DIALOUT_ALREADY_ACTIVE   = (RASBASE+126);
(*RASAPI*)  ERROR_ACCESSING_TCPCFGDLL            = (RASBASE+127);
(*RASAPI*)  ERROR_NO_IP_RAS_ADAPTER              = (RASBASE+128);
(*RASAPI*)  ERROR_SLIP_REQUIRES_IP               = (RASBASE+129);
(*RASAPI*)  ERROR_PROJECTION_NOT_COMPLETE        = (RASBASE+130);
(*RASAPI*)  ERROR_PROTOCOL_NOT_CONFIGURED        = (RASBASE+131);
(*RASAPI*)  ERROR_PPP_NOT_CONVERGING             = (RASBASE+132);
(*RASAPI*)  ERROR_PPP_CP_REJECTED                = (RASBASE+133);
(*RASAPI*)  ERROR_PPP_LCP_TERMINATED             = (RASBASE+134);
(*RASAPI*)  ERROR_PPP_REQUIRED_ADDRESS_REJECTED  = (RASBASE+135);
(*RASAPI*)  ERROR_PPP_NCP_TERMINATED             = (RASBASE+136);
(*RASAPI*)  ERROR_PPP_LOOPBACK_DETECTED          = (RASBASE+137);
(*RASAPI*)  ERROR_PPP_NO_ADDRESS_ASSIGNED        = (RASBASE+138);
(*RASAPI*)  ERROR_CANNOT_USE_LOGON_CREDENTIALS   = (RASBASE+139);
(*RASAPI*)  ERROR_TAPI_CONFIGURATION             = (RASBASE+140);
(*RASAPI*)  ERROR_NO_LOCAL_ENCRYPTION            = (RASBASE+141);
(*RASAPI*)  ERROR_NO_REMOTE_ENCRYPTION           = (RASBASE+142);
(*RASAPI*)  ERROR_REMOTE_REQUIRES_ENCRYPTION     = (RASBASE+143);
(*RASAPI*)  ERROR_IPXCP_NET_NUMBER_CONFLICT      = (RASBASE+144);
(*RASAPI*)  ERROR_INVALID_SMM                    = (RASBASE+145);
(*RASAPI*)  ERROR_SMM_UNINITIALIZED              = (RASBASE+146);
(*RASAPI*)  ERROR_NO_MAC_FOR_PORT                = (RASBASE+147);
(*RASAPI*)  ERROR_SMM_TIMEOUT                    = (RASBASE+148);
(*RASAPI*)  ERROR_BAD_PHONE_NUMBER               = (RASBASE+149);
(*RASAPI*)  ERROR_WRONG_MODULE                   = (RASBASE+150);
(*RASAPI*)
(*RASAPI*)  RASBASEEND                           = (RASBASE+150);
(*RASAPI*)
(*RASAPI*){* Copyright (c) 1995, Microsoft Corporation, all rights reserved
(*RASAPI*)**
(*RASAPI*)** rnaph.h  (to be merged with ras.h)
(*RASAPI*)**
(*RASAPI*)** Remote Access external API
(*RASAPI*)** Public header for external API clients
(*RASAPI*)**}
(*RASAPI*)
(*RASAPI*){*
(*RASAPI*)   Original conversion by Gideon le Grange <legrang@adept.co.za>
(*RASAPI*)   Merged with ras.pas by Davide Moretti <dmoretti@iper.net>
(*RASAPI*)*}
(*RASAPI*)
(*RASAPI*)const
(*RASAPI*)  RAS_MaxAreaCode   =  10;
(*RASAPI*)  RAS_MaxPadType    =  32;
(*RASAPI*)  RAS_MaxX25Address = 200;
(*RASAPI*)  RAS_MaxFacilities = 200;
(*RASAPI*)  RAS_MaxUserData   = 200;
(*RASAPI*)
(*RASAPI*)
(*RASAPI*)type
(*RASAPI*)(* Describes a RAS IP Address *)
(*RASAPI*)  LPRasIPAddr = ^TRasIPAddr;
(*RASAPI*)  TRasIPAddr = record
(*RASAPI*)    A, B, C, D: Byte;
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)(* Describes a RAS phonebook entry *)
(*RASAPI*)  LPRasEntryA = ^TRasEntryA;
(*RASAPI*)  TRasEntryA  = record
(*RASAPI*)    dwSize,
(*RASAPI*)    dwfOptions,
(*RASAPI*)    dwCountryID,
(*RASAPI*)    dwCountryCode          : Longint;
(*RASAPI*)    szAreaCode             : array[0.. RAS_MaxAreaCode] of AnsiChar;
(*RASAPI*)    szLocalPhoneNumber     : array[0..RAS_MaxPhoneNumber] of AnsiChar;
(*RASAPI*)    dwAlternatesOffset     : Longint;
(*RASAPI*)    ipaddr,
(*RASAPI*)    ipaddrDns,
(*RASAPI*)    ipaddrDnsAlt,
(*RASAPI*)    ipaddrWins,
(*RASAPI*)    ipaddrWinsAlt          : TRasIPAddr;
(*RASAPI*)    dwFrameSize,
(*RASAPI*)    dwfNetProtocols,
(*RASAPI*)    dwFramingProtocol      : Longint;
(*RASAPI*)    szScript               : Array[0..MAX_PATH - 1] of AnsiChar;
(*RASAPI*)    szAutodialDll          : Array [0..MAX_PATH - 1] of AnsiChar;
(*RASAPI*)    szAutodialFunc         : Array [0..MAX_PATH - 1] of AnsiChar;
(*RASAPI*)    szDeviceType           : Array [0..RAS_MaxDeviceType] of AnsiChar;
(*RASAPI*)    szDeviceName           : Array [0..RAS_MaxDeviceName] of AnsiChar;
(*RASAPI*)    szX25PadType           : Array [0..RAS_MaxPadType] of AnsiChar;
(*RASAPI*)    szX25Address           : Array [0..RAS_MaxX25Address] of AnsiChar;
(*RASAPI*)    szX25Facilities        : Array [0..RAS_MaxFacilities] of AnsiChar;
(*RASAPI*)    szX25UserData          : Array [0..RAS_MaxUserData] of AnsiChar;
(*RASAPI*)    dwChannels,
(*RASAPI*)    dwReserved1,
(*RASAPI*)    dwReserved2            : Longint;
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)  LPRasEntryW = ^TRasEntryW;
(*RASAPI*)  TRasEntryW  = record
(*RASAPI*)    dwSize,
(*RASAPI*)    dwfOptions,
(*RASAPI*)    dwCountryID,
(*RASAPI*)    dwCountryCode          : Longint;
(*RASAPI*)    szAreaCode             : array[0.. RAS_MaxAreaCode] of WideChar;
(*RASAPI*)    szLocalPhoneNumber     : array[0..RAS_MaxPhoneNumber] of WideChar;
(*RASAPI*)    dwAlternatesOffset     : Longint;
(*RASAPI*)    ipaddr,
(*RASAPI*)    ipaddrDns,
(*RASAPI*)    ipaddrDnsAlt,
(*RASAPI*)    ipaddrWins,
(*RASAPI*)    ipaddrWinsAlt          : TRasIPAddr;
(*RASAPI*)    dwFrameSize,
(*RASAPI*)    dwfNetProtocols,
(*RASAPI*)    dwFramingProtocol      : Longint;
(*RASAPI*)    szScript               : Array[0..MAX_PATH - 1] of WideChar;
(*RASAPI*)    szAutodialDll          : Array [0..MAX_PATH - 1] of WideChar;
(*RASAPI*)    szAutodialFunc         : Array [0..MAX_PATH - 1] of WideChar;
(*RASAPI*)    szDeviceType           : Array [0..RAS_MaxDeviceType] of WideChar;
(*RASAPI*)    szDeviceName           : Array [0..RAS_MaxDeviceName] of WideChar;
(*RASAPI*)    szX25PadType           : Array [0..RAS_MaxPadType] of WideChar;
(*RASAPI*)    szX25Address           : Array [0..RAS_MaxX25Address] of WideChar;
(*RASAPI*)    szX25Facilities        : Array [0..RAS_MaxFacilities] of WideChar;
(*RASAPI*)    szX25UserData          : Array [0..RAS_MaxUserData] of WideChar;
(*RASAPI*)    dwChannels,
(*RASAPI*)    dwReserved1,
(*RASAPI*)    dwReserved2            : Longint;
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)  LPRasEntry = ^TRasEntry;
(*RASAPI*)  TRasEntry  = TRasEntryA;
(*RASAPI*)
(*RASAPI*)(* Describes Country Information *)
(*RASAPI*)  LPRasCtryInfo = ^TRasCtryInfo;
(*RASAPI*)  TRasCtryInfo  = record
(*RASAPI*)    dwSize,
(*RASAPI*)    dwCountryID,
(*RASAPI*)    dwNextCountryID,
(*RASAPI*)    dwCountryCode,
(*RASAPI*)    dwCountryNameOffset : Longint;
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)(* Describes RAS Device Information *)
(*RASAPI*)  LPRasDevInfoA = ^TRasDevInfoA;
(*RASAPI*)  TRasDevInfoA  = record
(*RASAPI*)    dwSize       : Longint;
(*RASAPI*)    szDeviceType : Array[0..RAS_MaxDeviceType] of AnsiChar;
(*RASAPI*)    szDeviceName : Array[0..RAS_MaxDeviceName] of AnsiChar;
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)  LPRasDevInfoW = ^TRasDevInfoW;
(*RASAPI*)  TRasDevInfoW  = record
(*RASAPI*)    dwSize       : Longint;
(*RASAPI*)    szDeviceType : Array[0..RAS_MaxDeviceType] of WideChar;
(*RASAPI*)    szDeviceName : Array[0..RAS_MaxDeviceName] of WideChar;
(*RASAPI*)  end;
(*RASAPI*)
(*RASAPI*)  LPRasDevInfo = ^TRasDevInfo;
(*RASAPI*)  TRasDevInfo  = TRasDevInfoA;
(*RASAPI*)
(*RASAPI*)const
(*RASAPI*)(* TRasEntry 'dwfOptions' bit flags. *)
(*RASAPI*)  RASEO_UseCountryAndAreaCodes = $00000001;
(*RASAPI*)  RASEO_SpecificIpAddr         = $00000002;
(*RASAPI*)  RASEO_SpecificNameServers    = $00000004;
(*RASAPI*)  RASEO_IpHeaderCompression    = $00000008;
(*RASAPI*)  RASEO_RemoteDefaultGateway   = $00000010;
(*RASAPI*)  RASEO_DisableLcpExtensions   = $00000020;
(*RASAPI*)  RASEO_TerminalBeforeDial     = $00000040;
(*RASAPI*)  RASEO_TerminalAfterDial      = $00000080;
(*RASAPI*)  RASEO_ModemLights            = $00000100;
(*RASAPI*)  RASEO_SwCompression          = $00000200;
(*RASAPI*)  RASEO_RequireEncryptedPw     = $00000400;
(*RASAPI*)  RASEO_RequireMsEncryptedPw   = $00000800;
(*RASAPI*)  RASEO_RequireDataEncryption  = $00001000;
(*RASAPI*)  RASEO_NetworkLogon           = $00002000;
(*RASAPI*)  RASEO_UseLogonCredentials    = $00004000;
(*RASAPI*)  RASEO_PromoteAlternates      = $00008000;
(*RASAPI*)
(*RASAPI*)(* TRasEntry 'dwfNetProtocols' bit flags. (session negotiated protocols) *)
(*RASAPI*)  RASNP_Netbeui = $00000001;  // Negotiate NetBEUI
(*RASAPI*)  RASNP_Ipx     = $00000002;  // Negotiate IPX
(*RASAPI*)  RASNP_Ip      = $00000004;  // Negotiate TCP/IP
(*RASAPI*)
(*RASAPI*)(* TRasEntry 'dwFramingProtocols' (framing protocols used by the server) *)
(*RASAPI*)  RASFP_Ppp  = $00000001;  // Point-to-Point Protocol (PPP)
(*RASAPI*)  RASFP_Slip = $00000002;  // Serial Line Internet Protocol (SLIP)
(*RASAPI*)  RASFP_Ras  = $00000004;  // Microsoft proprietary protocol
(*RASAPI*)
(*RASAPI*)(* TRasEntry 'szDeviceType' strings *)
(*RASAPI*)  RASDT_Modem = 'modem';     // Modem
(*RASAPI*)  RASDT_Isdn  = 'isdn';      // ISDN
(*RASAPI*)  RASDT_X25   = 'x25';      // X.25
(*RASAPI*)
(*RASAPI*)(* RAS functions found in RNAPH.DLL *)
(*RASAPI*)function RasValidateEntryNameA(lpszPhonebook,szEntry: PAnsiChar): Longint; stdcall;
(*RASAPI*)function RasValidateEntryNameW(lpszPhonebook,szEntry: PWideChar): Longint; stdcall;
(*RASAPI*)function RasValidateEntryName(lpszPhonebook,szEntry: PAnsiChar): Longint; stdcall;
(*RASAPI*)
(*RASAPI*)function RasRenameEntryA(lpszPhonebook,szEntryOld,szEntryNew: PAnsiChar): Longint; stdcall;
(*RASAPI*)function RasRenameEntryW(lpszPhonebook,szEntryOld,szEntryNew: PWideChar): Longint; stdcall;
(*RASAPI*)function RasRenameEntry(lpszPhonebook,szEntryOld,szEntryNew: PAnsiChar): Longint; stdcall;
(*RASAPI*)
(*RASAPI*)function RasDeleteEntryA(lpszPhonebook,szEntry: PAnsiChar): Longint; stdcall;
(*RASAPI*)function RasDeleteEntryW(lpszPhonebook,szEntry: PWideChar): Longint; stdcall;
(*RASAPI*)function RasDeleteEntry(lpszPhonebook,szEntry: PAnsiChar): Longint; stdcall;
(*RASAPI*)
(*RASAPI*)function RasGetEntryPropertiesA(lpszPhonebook, szEntry: PAnsiChar; lpbEntry: Pointer;
(*RASAPI*)                                var lpdwEntrySize: Longint; lpbDeviceInfo: Pointer;
(*RASAPI*)                                var lpdwDeviceInfoSize: Longint): Longint; stdcall;
(*RASAPI*)function RasGetEntryPropertiesW(lpszPhonebook, szEntry: PWideChar; lpbEntry: Pointer;
(*RASAPI*)                                var lpdwEntrySize: Longint; lpbDeviceInfo: Pointer;
(*RASAPI*)                                var lpdwDeviceInfoSize: Longint): Longint; stdcall;
(*RASAPI*)function RasGetEntryProperties(lpszPhonebook, szEntry: PAnsiChar; lpbEntry: Pointer;
(*RASAPI*)                                var lpdwEntrySize: Longint; lpbDeviceInfo: Pointer;
(*RASAPI*)                                var lpdwDeviceInfoSize: Longint): Longint; stdcall;
(*RASAPI*)
(*RASAPI*)function RasSetEntryPropertiesA(lpszPhonebook, szEntry: PAnsiChar; lpbEntry: Pointer;
(*RASAPI*)                                dwEntrySize: Longint; lpbDeviceInfo: Pointer;
(*RASAPI*)                                dwDeviceInfoSize: Longint): Longint; stdcall;
(*RASAPI*)function RasSetEntryPropertiesW(lpszPhonebook, szEntry: PWideChar; lpbEntry: Pointer;
(*RASAPI*)                                dwEntrySize: Longint; lpbDeviceInfo: Pointer;
(*RASAPI*)                                dwDeviceInfoSize: Longint): Longint; stdcall;
(*RASAPI*)function RasSetEntryProperties(lpszPhonebook, szEntry: PAnsiChar; lpbEntry: Pointer;
(*RASAPI*)                               dwEntrySize: Longint; lpbDeviceInfo: Pointer;
(*RASAPI*)                               dwDeviceInfoSize: Longint): Longint; stdcall;
(*RASAPI*)
(*RASAPI*)function RasGetCountryInfoA(var lpCtryInfo: TRasCtryInfo;var lpdwSize: Longint): Longint; stdcall;
(*RASAPI*)function RasGetCountryInfoW(var lpCtryInfo: TRasCtryInfo;var lpdwSize: Longint): Longint; stdcall;
(*RASAPI*)function RasGetCountryInfo(var lpCtryInfo: TRasCtryInfo;var lpdwSize: Longint): Longint; stdcall;
(*RASAPI*)
(*RASAPI*)function RasEnumDevicesA(lpBuff: LpRasDevInfoA; var lpcbSize: Longint;
(*RASAPI*)                         var lpcDevices: Longint): Longint; stdcall;
(*RASAPI*)function RasEnumDevicesW(lpBuff: LpRasDevInfoW; var lpcbSize: Longint;
(*RASAPI*)                         var lpcDevices: Longint): Longint; stdcall;
(*RASAPI*)function RasEnumDevices(lpBuff: LpRasDevInfo; var lpcbSize: Longint;
(*RASAPI*)                         var lpcDevices: Longint): Longint; stdcall;
(*RASAPI*)
{******************************************************}
{******************************************************}
{******************************************************}
{******************************************************}
{******************************************************}
{******************************************************}
{this type definition part is (c) Mircrosoft:}
type
  PPERF_DATA_BLOCK = ^PERF_DATA_BLOCK ;
  PERF_DATA_BLOCK = RECORD  // pdb
                      Signature:  Array[0..3] Of WideChar; // Signature: Unicode "PERF"
                      LittleEndian: DWORD;                // 0 = Big Endian, 1 = Little Endian
                      Version: DWORD;                     // Version of these data structures
                                                          // starting at 1
                      Revision: DWORD;                    // Revision of these data structures
                                                          // starting at 0 for each Version
                      TotalByteLength: DWORD;             // Total length of data block
                      HeaderLength: DWORD;                // Length of this structure
                      NumObjectTypes: DWORD;              // Number of types of objects
                                                          // being reported
                      DefaultObject: integer;             // Object Title Index of default
                                                          // object to display when data from
                                                          // this system is retrieved (-1 =
                                                          // none, but this is not expected to
                                                          // be used)
                      SystemTime: TSystemTime ;           // Time at the system under
                                                          // measurement
                      PerfTime: TLargeInteger ;           // Performance counter value
                                                          // at the system under measurement
                      PerfFreq: TLargeInteger;            // Performance counter frequency
                                                          // at the system under measurement
                      PerfTime100nSec: TLargeInteger;     // Performance counter time in 100 nsec
                                                          // units at the system under measurement
                      SystemNameLength: DWORD;            // Length of the system name
                      SystemNameOffset: DWORD;            // Offset, from beginning of this
                                                          // structure, to name of system
                                                          // being measured
                    end ;
  PPERF_OBJECT_TYPE =^PERF_OBJECT_TYPE ;
  PERF_OBJECT_TYPE = RECORD    // pot
                       TotalByteLength: DWORD;             // Length of this object definition
                                                           // including this structure, the
                                                           // counter definitions, and the
                                                           // instance definitions and the
                                                           // counter blocks for each instance:
                                                           // This is the offset from this
                                                           // structure to the next object, if
                                                           // any
                       DefinitionLength: DWORD;            // Length of object definition,
                                                           // which includes this structure
                                                           // and the counter definition
                                                           // structures for this object: this
                                                           // is the offset of the first
                                                           // instance or of the counters
                                                           // for this object if there is
                                                           // no instance
                       HeaderLength: DWORD;                // Length of this structure: this
                                                           // is the offset to the first
                                                           // counter definition for this
                                                           // object
                       ObjectNameTitleIndex: DWORD;        // Index to name in Title Database
                       ObjectNameTitle: DWORD;             // Initially NULL, for use by
                                                           // analysis program to point to
                                                           // retrieved title string
                       ObjectHelpTitleIndex: DWORD;        // Index to Help in Title Database
                       ObjectHelpTitle: DWORD;             // Initially NULL, for use by
                                                           // analysis program to point to
                                                           // retrieved title string
                       DetailLevel: DWORD;                 // Object level of detail (for
                                                           // controlling display complexity);
                                                           // will be min of detail levels
                                                           // for all this object's counters
                       NumCounters: DWORD;                 // Number of counters in each
                                                           // counter block (one counter
                                                           // block per instance)
                       DefaultCounter: integer;            // Default counter to display when
                                                           // this object is selected, index
                                                           // starting at 0 (-1 = none, but
                                                           // this is not expected to be used)
                       NumInstances: integer;              // Number of object instances
                                                           // for which counters are being
                                                           // returned from the system under
                                                           // measurement. If the object defined
                                                           // will never have any instance data
                                                           // structures (PERF_INSTANCE_DEFINITION)
                                                           // then this value should be -1, if the
                                                           // object can have 0 or more instances,
                                                           // but has none present, then this
                                                           // should be 0, otherwise this field
                                                           // contains the number of instances of
                                                           // this counter.
                       CodePage: DWORD;                    // 0 if instance strings are in
                                                           // UNICODE, else the Code Page of
                                                           // the instance names
                       PerfTime: TLargeInteger;            // Sample Time in "Object" units
                       PerfFreq: TLargeInteger;            // Frequency of "Object" units in
                                                           // counts per second.
                   end ;
  PPERF_COUNTER_DEFINITION = ^PERF_COUNTER_DEFINITION ;
  PERF_COUNTER_DEFINITION = RECORD  // pcd
                              ByteLength: DWORD;                  // Length in bytes of this structure
                              CounterNameTitleIndex: DWORD;       // Index of Counter name into
                                                                  // Title Database
                              CounterNameTitle: DWORD;            // Initially NULL, for use by
                                                                  // analysis program to point to
                                                                  // retrieved title string
                              CounterHelpTitleIndex: DWORD;       // Index of Counter Help into
                                                                  // Title Database
                              CounterHelpTitle: DWORD;            // Initially NULL, for use by
                                                                  // analysis program to point to
                                                                  // retrieved title string
                              DefaultScale: integer;              // Power of 10 by which to scale
                                                                  // chart line if vertical axis is 100
                                                                  // 0 ==> 1, 1 ==> 10, -1 ==>1/10, etc.
                              DetailLevel: DWORD;                 // Counter level of detail (for
                                                                  // controlling display complexity)
                              CounterType: DWORD;                 // Type of counter
                              CounterSize: DWORD;                 // Size of counter in bytes
                              CounterOffset: DWORD;               // PERF_COUNTER_BLOCK to the first
                                                                  // byte of this counter
                            end ;
  PPERF_INSTANCE_DEFINITION = ^PERF_INSTANCE_DEFINITION ;
  PERF_INSTANCE_DEFINITION = RECORD // pid
                               ByteLength: DWORD;                  // Length in bytes of this structure,
                                                                   // including the subsequent name
                               ParentObjectTitleIndex: DWORD;      // Title Index to name of "parent"
                                                                   // object (e.g., if thread, then
                                                                   // process is parent object type);
                                                                   // if logical drive, the physical
                                                                   // drive is parent object type
                               ParentObjectInstance: DWORD;        // Index to instance of parent object
                                                                   // type which is the parent of this
                                                                   // instance.
                               UniqueID: integer;                  // A unique ID used instead of
                                                                   // matching the name to identify
                                                                   // this instance, -1 = none
                               NameOffset: DWORD;                  // Offset from beginning of
                                                                   // this struct to the Unicode name
                                                                   // of this instance
                               NameLength: DWORD;                  // Length in bytes of name; 0 = none
                                                                   // this length includes the characters
                                                                   // in the string plus the size of the
                                                                   // terminating NULL char. It does not
                                                                   // include any additional pad bytes to
                                                                   // correct structure alignment
                             end;
  PPERF_COUNTER_BLOCK= ^PERF_COUNTER_BLOCK ;
  PERF_COUNTER_BLOCK = record  // pcb
                         ByteLength: DWORD;                   // Length in bytes of this structure,
                                                              // including the following counters
                       end ;


const MaxEntries = 100; //It's enough

type

  TOnEntryGet   = procedure (Sender : TObject; EntryName : Array of {Ansi}Char) of Object;
  TStandartEv   = procedure (Sender : TObject) of object;
  TOnNotConn    = procedure (Sender : TObject; ErrorCode : Integer; ErrorMessage : String) of object;
  TOnAsyncEvent = procedure (Sender : TObject; State : TRasConnState; Error : Integer;
                             MessageText : String) of object;
  TOnError      = procedure (Sender : TObject; ErrorCode : Integer; ErrorMessage : String) of Object;
  TOnActiveConn = procedure (Sender : TObject; Handle : THRasConn; Status : TRasConnStatus;
                             StatusString : String;
                             EntryName, DeviceType, DeviceName : Array of Char) of object;

  TDialMode = (dmAsync,dmSync); //dmAsync - Function will exit BEFORE finishing dialing
                                //          Events : onDialing,onError,onAsyncEvent
                                //dmSync  - Function will exit AFTER finishing dialing
                                //          Events : onDialing,onConnect,onNotConnected

  TLanguage = (English,Czech,Portuguese);

  TDialUp = class(TComponent)
  private
    FEntries    : TStringList;
    FDialMode   : TDialMode;
    FEntry2Dial : String;
    FLanguage   : TLanguage;
    FSIP,FCIP   : String;
    FDUNA       : TStringList;
    FDUNAKey    : String;
    FTimer      : TTimer;
    FStatsXmit,FStatsRecv,FStatsConnSpeed : DWord;
    FStatsXmitTot,FStatsRecvTot : DWord;
    FStatsXmitCon,FStatsRecvCon : DWord;

    FOnEntryGet              : TOnEntryGet;
    FOnDialing, FOnConnected : TStandartEv;
    FOnNotConnected          : TOnNotConn;
    FOnAsyncEvent            : TOnAsyncEvent;
    FOnError                 : TOnError;
    FOnActiveConn            : TOnActiveConn;

    procedure ResetPerfStats ;

  protected
    procedure Timer(Sender: TObject); virtual;

  public
    hRAS : ThRASConn; {Handle to RAS connection dialed with by this component when connected}
    AsyncStatus : Boolean;
    AMsg,AError : Integer;
    AState      : TRasConnState;

    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    function Dial : Integer;
    function GetEntries : Integer;
    function GetConnections : Integer;
    function HangUp : Integer;
    function HangUpConn(Handle : THRasConn) : Integer;
    function CreateEntry : Integer;
    function EditEntry : Integer;
    function DeleteEntry : Integer;
    function RenameEntryTo(S : String) : Integer;
    function SetEntryUserName(Value : String) : Integer;
    function SetEntryPassword(Value : String) : Integer;
    function RemovePassword : Integer;
    function GetEntryUserName(var Value : String) : Integer;
    function GetEntryPassword(var Value : String) : Integer;
    function StatusString(State: TRasConnState; Error: Integer): String;
    function StatusStringCZ(State: TRasConnState; Error: Integer): String;
    function StatusStringPO(State: TRasConnState; Error: Integer): String;
    function GetIP(HRC : THRasConn) : Integer;
    function InitializePerfStats (start, search: boolean): boolean ;
    function SearchDUNA: Boolean;
    function GetPerfStats: Boolean;

  published
    property Name;
    property Tag;
    property DialMode : TDialMode
      read FDialMode write FDialMode;
    property Entries : TStringList
      read FEntries;
    property Entry : String
      read FEntry2Dial write FEntry2Dial;
    property Language : TLanguage
      read FLanguage write FLanguage;
    property ServerIP : String
      read FSIP;
    property ClientIP : String
      read FCIP;
    property DUNA : TStringList
      read FDUNA;
    property DUNA_Key : String
      read FDUNAKey write FDUNAKey;
    property BytesXmit : DWord
      read FStatsXmit;
    property BytesRecv : DWord
      read FStatsRecv;
    property ConnectionSpeed : DWord
      read FStatsConnSpeed;

    property OnEntryGet : TOnEntryGet
      read FOnEntryGet write FOnEntryGet;
    property OnDialing : TStandartEv
      read FOnDialing write FOnDialing;
    property OnConnect : TStandartEv
      read FOnConnected write FOnConnected;
    property OnNotConnected : TOnNotConn
      read FOnNotConnected write FOnNotConnected;
    property OnAsyncEvent : TOnAsyncEvent
      read FOnAsyncEvent write FOnAsyncEvent;
    property OnError : TOnError
      read FOnError write FOnError;
    property OnActiveConnection : TOnActiveConn
      read FOnActiveConn write FOnActiveConn;

end;

procedure Register;

implementation

var
  datasize: integer = 0 ;   // performance data buffer size

const

  TOTALBYTES =  8192 ;    // initial buffer size for NT performance data
  BYTEINCREMENT = 1024 ;  // make it bigger

// NT performance counter identifiers, assume they are fixed data
  Pdata_RAS_Total   = '906' ;
  Pdata_Bytes_Xmit  = 872 ;
  Pdata_Bytes_Recv  = 874 ;
  // connect speed is not available on NT

// keys and names for Win95 performance statistics under HKEY_DYN_DATA
  Reg_PerfStatStart 	= 'PerfStats\StartStat';
  Reg_PerfStatData 		= 'PerfStats\StatData';
  Reg_PerfStatStop 		= 'PerfStats\StopStat';
  Reg_PerfAdap 			= 'Dial-Up Adapter' ;
  Reg_PerfXmit 			= 'TotalBytesXmit' ;
  Reg_PerfRecv 			= 'TotalBytesRecvd' ;
  Reg_PerfConn 			= 'ConnectSpeed' ;

  Reg_PerfStatEmum   = 'System\CurrentControlSet\Control\PerfStats\Enum' ;

{ other keys... Win9x only
Dial-Up Adapter #2\
"Dial-Up Adapter\Buffer"
"Dial-Up Adapter\Framing"
"Dial-Up Adapter\Overrun "
"Dial-Up Adapter\Alignment"
"Dial-Up Adapter\Timeout"
"Dial-Up Adapter\CRC"
"Dial-Up Adapter\Runts"
"Dial-Up Adapter\FramesXmit"
"Dial-Up Adapter\FramesRecvd"
"Dial-Up Adapter\BytesXmit"	these are the same as Total
"Dial-Up Adapter\BytesRecvd"	}


var xSelf : Pointer;

procedure TDialUp.Timer(Sender: TObject);
begin
  FTimer.Enabled:=False;
  if AsyncStatus=False then Exit;
  if Language=Czech then
  begin
    if Assigned(FOnAsyncEvent) then FOnAsyncEvent(Self,AState,AError,StatusStringCZ(AState, AError));
  end else
  if Language=Portuguese then
  begin
    if Assigned(FOnAsyncEvent) then FOnAsyncEvent(Self,AState,AError,StatusStringPO(AState, AError));
  end else
  begin
    if Assigned(FOnAsyncEvent) then FOnAsyncEvent(Self,AState,AError,StatusString(AState, AError));
  end;
  AsyncStatus:=False;
end;


procedure RasCallback(msg: Integer; state: TRasConnState;
  error: Integer); stdcall;
begin
  While TDialUp(xSelf).AsyncStatus=True do ;
  TDialUp(xSelf).AsyncStatus:=True;
  TDialUp(xSelf).AMsg:=Msg;
  TDialUp(xSelf).AState:=State;
  TDialUp(xSelf).AError:=Error;
  TDialUp(xSelf).FTimer.Enabled:=True;
//  TDialUp(xSelf).FOnDialing(xSelf);
//  TDialUp(xSelf).OnAsyncEvent(xSelf,State,Error,TDialUp(xSelf).StatusString(state, error));
end;
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

//procedure RasCallback(Msg: Integer; State: TRasConnState; Error: Integer); stdcall; forward;

procedure Register;
begin
  RegisterComponents('Internet',[TDialUp]);
end;


{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

constructor TDialUp.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  AsyncStatus:=False;
  FEntries:=TStringList.Create;
  FTimer:=TTimer.Create(Self);
  FTimer.Enabled:=False; FTimer.Interval:=1;
  FTimer.OnTimer:=Timer;
  FDUNA:=TStringList.Create;
  SearchDUNA;
end;


{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

destructor TDialUp.Destroy;
begin
  FEntries.Free;
  FTimer.Free;
  FDUNA.Free;
  inherited Destroy;
end;


{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

Function TDialUp.Dial : Integer;
var
  Fp                  : LongBool;
  R                   : Integer;
  C                   : Array[0..100] of Char;
  ErrS                : String;
  DialParams          : TRasDialParams;

begin
  HangUp;

  FillChar(DialParams, SizeOf(TRasDialParams), 0);
  with DialParams do
  begin
    dwSize:=Sizeof(TRasDialParams);
    StrPCopy(szEntryName, FEntry2Dial);
  end;

  R:=RasGetEntryDialParams(nil, DialParams, Fp);
  if R<>0 then
  begin
    Result:=R;
    if Assigned(FOnError) then FOnError(Self,R,'GetEntryDialParams failed');
    Exit;
  end;

  hRAS:=0;
  if DialMode=dmSync then // Synchronous dial
  begin
    if Assigned(FOnDialing) then FOnDialing(Self);
    R:=RasDial(nil, nil, DialParams, 0, nil, hRAS);
    if R=0 then
    begin
      if Assigned(FOnConnected) then
        FOnConnected(Self)
    end else
    begin
      if hRas<>0 then
        HangUpConn(hRas);
      RasGetErrorString(R, C, 100); ErrS:=C;
      if Assigned(FOnNotConnected) then FOnNotConnected(Self,R,ErrS);
    end;
  end else // Asynchronous dial

  begin
    // Async dial
    xSelf:=Self;
    if Assigned(FOnDialing) then FOnDialing(Self);
    R:=RasDial(nil, nil, DialParams, 0, @RasCallback, hRAS);
    if R<>0 then
    begin
      RasGetErrorString(R,C,100);
      if Assigned(FOnError) then FOnError(Self,R,C);
    end;
  end;
  Result:=R;
end;


{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

Function TDialUp.GetEntries : Integer;
var
  BuffSize          : Integer;
  Entries           : Integer;
  Entry             : Array[1..MaxEntries] of TRasEntryName;
  X,Result_         : Integer;
begin
  Result:=0;
  FEntries.Clear;
  Entry[1].dwSize:=SizeOf(TRasEntryName);
  BuffSize:=SizeOf(TRasEntryName)*MaxEntries;
  Result_:=RasEnumEntries(nil, nil, @Entry[1], BuffSize, Entries);
  if (Result_=0) and (Entries>0) then
  begin
    for X:=1 to Entries do
    begin
      FEntries.Add(Entry[x].szEntryName);
      If Assigned(FOnEntryGet) then FOnEntryGet(Self,Entry[x].szEntryName);
    end;
  end else
  Result:=Result_;
end;


{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

Function TDialUp.GetConnections : Integer;
var
    BufSize                     : Integer;
    NumEntries                  : Integer;
    X                           : Integer;
    Entries                     : Array[1..MaxEntries] of TRasConn;
    Stat                        : TRasConnStatus;
    Result_                     : Integer;
    S                           : String;
begin
  Result:=0;

  Entries[1].dwSize := SizeOf(TRasConn);
  Bufsize:=SizeOf(TRasConn)*MaxEntries;
  FillChar(Stat, Sizeof(TRasConnStatus), 0);
  Stat.dwSize:=Sizeof(TRasConnStatus);

  Result_:=RasEnumConnections(@Entries[1], BufSize, NumEntries);
  if Result_=0 then
  begin
    if NumEntries > 0 then

    for X:=1 to NumEntries do
    begin
      RasGetConnectStatus(Entries[X].HRasConn, Stat);
      if Language=Czech then S:=StatusStringCZ(Stat.RasConnState, Stat.dwError) else
      if Language=Portuguese then S:=StatusStringPO(Stat.RasConnState, Stat.dwError) else
        S:=StatusString(Stat.RasConnState, Stat.dwError);
      if Assigned(FOnActiveConn) then FOnActiveConn(Self, Entries[X].HRasConn,
                                                    Stat, S,
                                                    Entries[X].szEntryName,
                                                    Entries[X].szDeviceType,
                                                    Entries[X].szDeviceName);
    end;
  end else Result:=Result_;
end;


{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

Function TDialUp.HangUp : Integer;
begin
  Result:=HangUpConn(hRas);
end;


{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

Function TDialUp.HangUpConn(Handle : THRasConn) : Integer;
var
  Stat:TRasConnStatus;
begin
  FillChar(Stat, Sizeof(TRasConnStatus), 0);
  Stat.dwSize:=Sizeof(TRasConnStatus); // Must be zeroed and sized
  Result:=RasHangUp(Handle);
  if( result<>0 )then exit ;

  while (RasGetConnectStatus(handle,stat)<>ERROR_INVALID_HANDLE) do
  begin
    sleep(0);
    Application.ProcessMessages;
  end; // Wait actual closure, else port could remain locked
end;


{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}


Function TDialUp.CreateEntry : Integer;
begin
  if (Owner is TForm) then
    Result:=RasCreatePhonebookEntry((Owner as TForm).Handle, nil) else
    Result:=RasCreatePhonebookEntry(0, nil);
end;


{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

Function TDialUp.EditEntry : Integer;
begin
  if (Owner is TForm) then
    Result:=RasEditPhonebookEntry((Owner as TForm).Handle, nil, PChar(FEntry2Dial)) else
    Result:=RasEditPhonebookEntry(0, nil, PChar(FEntry2Dial));
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

Function TDialUp.RenameEntryTo(S : String) : Integer;
begin
  Result:=RasRenameEntry(nil, PChar(FEntry2Dial), PChar(S));
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

Function TDialUp.DeleteEntry : Integer;
begin
  Result:=RasDeleteEntry(nil, PChar(FEntry2Dial))
end;


{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

function TDialUp.SetEntryUserName(Value : String) : Integer;
var DialParams : TRasDialParams;
    Fp         : LongBool;
begin
  FillChar(DialParams, SizeOf(TRasDialParams), 0);
  with DialParams do
  begin
    dwSize:=Sizeof(TRasDialParams);
    StrPCopy(szEntryName, FEntry2Dial);
  end;

  Result:=RasGetEntryDialParams(nil, DialParams, Fp);
  if (Result<>0) then exit;

  StrPCopy(DialParams.szUserName, Value);
  Result:=RasSetEntryDialParams(nil, DialParams, False);
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

function TDialUp.SetEntryPassword(Value : String) : Integer;
var DialParams : TRasDialParams;
    Fp         : LongBool;
begin
  FillChar(DialParams, SizeOf(TRasDialParams), 0);
  with DialParams do
  begin
    dwSize:=Sizeof(TRasDialParams);
    StrPCopy(szEntryName, FEntry2Dial);
  end;
  Result:=RasGetEntryDialParams(nil, DialParams, Fp);
  if (Result<>0) then exit;

  StrPCopy(DialParams.szPassword, Value);
  Result:=RasSetEntryDialParams(nil, DialParams, False);
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

function TDialUp.RemovePassword : Integer;
var DialParams : TRasDialParams;
begin
  with DialParams do
  begin
    dwSize:=Sizeof(TRasDialParams);
    StrPCopy(szEntryName, PChar(FEntry2Dial));
  end;
  Result:=RasSetEntryDialParams(nil, DialParams, True);
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

function TDialUp.GetEntryUserName(var Value : String) : Integer;
var
  Fp         : LongBool;
  R          : Integer;
//  C          : Array[0..100] of Char;
  DialParams : TRasDialParams;
begin
  FillChar(DialParams, SizeOf(TRasDialParams), 0);
  with DialParams do
  begin
    dwSize:=Sizeof(TRasDialParams);
    StrPCopy(szEntryName, FEntry2Dial);
  end;
  R:=RasGetEntryDialParams(nil, DialParams, Fp);
  if R=0 then
  with DialParams do
  begin
    Value:=szUserName;
  end;
  Result:=R;
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

function TDialUp.GetEntryPassword(var Value : String) : Integer;
var
  Fp         : LongBool;
  R          : Integer;
//  C          : Array[0..100] of Char;
  DialParams : TRasDialParams;
begin
  FillChar(DialParams, SizeOf(TRasDialParams), 0);
  with DialParams do
  begin
    dwSize:=Sizeof(TRasDialParams);
    StrPCopy(szEntryName, FEntry2Dial);
  end;
  R:=RasGetEntryDialParams(nil, DialParams, Fp);
  if R=0 then
  with DialParams do
  begin
    if Fp then
      Value:=szPassword else Value:='';
  end;
  Result:=R;
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

function TDialUp.StatusString(State: TRasConnState; Error: Integer): String;
var
  C      : Array[0..100] of Char;
  S      : String;
begin
  if Error<>0 then
  begin
    RasGetErrorString(Error, C, 100);
    Result:=C;
  end else
  begin
    S:='';
    case State of
      RASCS_OpenPort:
        S:='Opening port';
      RASCS_PortOpened:
        S:='Port opened';
      RASCS_ConnectDevice:
        S:='Connecting device';
      RASCS_DeviceConnected:
        S:='Device connected';
      RASCS_AllDevicesConnected:
        S:='All devices connected';
      RASCS_Authenticate:
        S:='Start authenticating';
      RASCS_AuthNotify:
        S:='Authentication: notify';
      RASCS_AuthRetry:
        S:='Authentication: retry';
      RASCS_AuthCallback:
        S:='Authentication: callback';
      RASCS_AuthChangePassword:
        S:='Authentication: change password';
      RASCS_AuthProject:
        S:='Authentication: projecting';
      RASCS_AuthLinkSpeed:
        S:='Authentication: link speed';
      RASCS_AuthAck:
        S:='Authentication: acknowledge';
      RASCS_ReAuthenticate:
        S:='Authentication: reauthenticate';
      RASCS_Authenticated:
        S:='Authenticated';
      RASCS_PrepareForCallback:
        S:='Preparing for callback';
      RASCS_WaitForModemReset:
        S:='Waiting for modem reset';
      RASCS_WaitForCallback:
        S:='Waiting for callback';
      RASCS_Projected:
        S:='Projected';
      RASCS_StartAuthentication:
        S:='Start authentication';
      RASCS_CallbackComplete:
        S:='Callback complete';
      RASCS_LogonNetwork:
        S:='Logging on network';

      RASCS_Interactive:
        S:='Interactive';
      RASCS_RetryAuthentication:
        S:='Retry Authentication';
      RASCS_CallbackSetByCaller:
        S:='Callback set by caller';
      RASCS_PasswordExpired:
        S:='Password expired';

      RASCS_Connected:
        S:='Connected';
      RASCS_Disconnected:
        S:='Disconnected';
    end;
    Result:=S;
  end;
end;
function TDialUp.StatusStringCZ(State: TRasConnState; Error: Integer): String;
var
  C      : Array[0..100] of Char;
  S      : String;
begin
  if Error<>0 then
  begin
    RasGetErrorString(Error, C, 100);
    Result:=C;
  end else
  begin
    S:='';
    case State of
      RASCS_OpenPort:
        S:='OtevÌr· se port';
      RASCS_PortOpened:
        S:='Port otev¯en';
      RASCS_ConnectDevice:
        S:='ProbÌh· spojov·nÌ';
      RASCS_DeviceConnected:
        S:='Nav·z·no spojenÌ';
      RASCS_AllDevicesConnected:
        S:='Vöechna za¯ÌzenÌ spojena';
      RASCS_Authenticate:
        S:='ZaËÌnajÌ se ovÏ¯ovat uûivatelskÈ informace';
      RASCS_AuthNotify:
        S:='OvÏ¯enÌ: ozn·menÌ';
      RASCS_AuthRetry:
        S:='OvÏ¯enÌ: opakov·nÌ';
      RASCS_AuthCallback:
        S:='OvÏ¯enÌ: zpÏtnÈ vol·nÌ';
      RASCS_AuthChangePassword:
        S:='OvÏ¯enÌ: zmÏna hesla';
      RASCS_AuthProject:
        S:='OvÏ¯enÌ: n·vrh';
      RASCS_AuthLinkSpeed:
        S:='OvÏ¯enÌ: spojovacÌ rychlost';
      RASCS_AuthAck:
        S:='OvÏ¯enÌ: potvrzenÌ';
      RASCS_ReAuthenticate:
        S:='OvÏ¯enÌ: znovuovÏ¯enÌ';
      RASCS_Authenticated:
        S:='OvÏ¯eno';
      RASCS_PrepareForCallback:
        S:='P¯Ìprava na zpetnÈ vol·nÌ';
      RASCS_WaitForModemReset:
        S:='»ek· se na reset modemu';
      RASCS_WaitForCallback:
        S:='»ek· se na zpÏtnÈ vol·nÌ';
      RASCS_Projected:
        S:='Navrhnuto';
      RASCS_StartAuthentication:
        S:='OvÏ¯ov·nÌ uûivatelsk˝ch informacÌ';
      RASCS_CallbackComplete:
        S:='ZpetnÈ vol·nÌ hotovo';
      RASCS_LogonNetwork:
        S:='P¯ipojuje se na sÌù';

      RASCS_Interactive:
        S:='Interakce';
      RASCS_RetryAuthentication:
        S:='Opakov·nÌ ove¯enÌ';
      RASCS_CallbackSetByCaller:
        S:='ZpeÏtnÈ vol·nÌ zvoleno uûivatelem';
      RASCS_PasswordExpired:
        S:='Platnost hesla vypröela';

      RASCS_Connected:
        S:='Spojeno';
      RASCS_Disconnected:
        S:='Rozpojeno';
    end;
    Result:=S;
  end;
end;
function TDialUp.StatusStringPO(State: TRasConnState; Error: Integer): String;
var
  C      : Array[0..100] of Char;
  S      : String;
begin
  if Error<>0 then
  begin
    RasGetErrorString(Error, C, 100);
    Result:=C;
  end else
  begin
    S:='';
    case State of
      RASCS_OpenPort:
        S:='Abrindo a porta';
      RASCS_PortOpened:
        S:='Porta aberta';
      RASCS_ConnectDevice:
        S:='Conectando componente';
      RASCS_DeviceConnected:
        S:='Componente conenctado';
      RASCS_AllDevicesConnected:
        S:='Todos componentes conectados';
      RASCS_Authenticate:
        S:='Iniciando autenticaÁao';
      RASCS_AuthNotify:
        S:='AutenticaÁao: enviando';
      RASCS_AuthRetry:
        S:='AutenticaÁao: Reenviando';
      RASCS_AuthCallback:
        S:='AutenticaÁao: Esperando';
      RASCS_AuthChangePassword:
        S:='AutenticaÁao: Senha incorreta';
      RASCS_AuthProject:
        S:='AutenticaÁao: enviando';
      RASCS_AuthLinkSpeed:
        S:='AutenticaÁao: Velocidade da linha';
      RASCS_AuthAck:
        S:='AutenticaÁao: enviando';
      RASCS_ReAuthenticate:
        S:='AutenticaÁao: Re-Autenticando';
      RASCS_Authenticated:
        S:='Autenticado';
      RASCS_PrepareForCallback:
        S:='Preparando para callback';
      RASCS_WaitForModemReset:
        S:='Esperando Reset do modem';
      RASCS_WaitForCallback:
        S:='Esperando callback';
      RASCS_Projected:
        S:='Enviando';
      RASCS_StartAuthentication:
        S:='AutenticaÁao iniciada';
      RASCS_CallbackComplete:
        S:='Callback completo';
      RASCS_LogonNetwork:
        S:='Logando na rede';

      RASCS_Interactive:
        S:='Modo Interativo';
      RASCS_RetryAuthentication:
        S:='Re-autenticar';
      RASCS_CallbackSetByCaller:
        S:='Callback foi conf. pelo destino';
      RASCS_PasswordExpired:
        S:='Senha inv·lida';

      RASCS_Connected:
        S:='Conectado';
      RASCS_Disconnected:
        S:='Desconectado'
    end;
    Result:=S;
  end;
end;

{****************************************************************************}
{****************************************************************************}
{****************************************************************************}
{****************************************************************************}

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
{function RasCreatePhonebookEntryA; external 'rasapi32.dll' name 'RasCreatePhonebookEntryA';
function RasCreatePhonebookEntryW; external 'rasapi32.dll' name 'RasCreatePhonebookEntryW';
function RasCreatePhonebookEntry;  external 'rasapi32.dll' name 'RasCreatePhonebookEntryA';
function RasDialA;                 external 'rasapi32.dll' name 'RasDialA';
function RasDialW;                 external 'rasapi32.dll' name 'RasDialW';
function RasDial;                  external 'rasapi32.dll' name 'RasDialA';
function RasEditPhonebookEntryA;   external 'rasapi32.dll' name 'RasEditPhonebookEntryA';
function RasEditPhonebookEntryW;   external 'rasapi32.dll' name 'RasEditPhonebookEntryW';
function RasEditPhonebookEntry;    external 'rasapi32.dll' name 'RasEditPhonebookEntryA';
function RasEnumConnectionsA;      external 'rasapi32.dll' name 'RasEnumConnectionsA';
function RasEnumConnectionsW;      external 'rasapi32.dll' name 'RasEnumConnectionsW';
function RasEnumConnections;       external 'rasapi32.dll' name 'RasEnumConnectionsA';
function RasEnumEntriesA;          external 'rasapi32.dll' name 'RasEnumEntriesA';
function RasEnumEntriesW;          external 'rasapi32.dll' name 'RasEnumEntriesW';
function RasEnumEntries;           external 'rasapi32.dll' name 'RasEnumEntriesA';
function RasGetConnectStatusA;     external 'rasapi32.dll' name 'RasGetConnectStatusA';
function RasGetConnectStatusW;     external 'rasapi32.dll' name 'RasGetConnectStatusW';
function RasGetConnectStatus;      external 'rasapi32.dll' name 'RasGetConnectStatusA';
function RasGetEntryDialParamsA;   external 'rasapi32.dll' name 'RasGetEntryDialParamsA';
function RasGetEntryDialParamsW;   external 'rasapi32.dll' name 'RasGetEntryDialParamsW';
function RasGetEntryDialParams;    external 'rasapi32.dll' name 'RasGetEntryDialParamsA';
function RasGetErrorStringA;       external 'rasapi32.dll' name 'RasGetErrorStringA';
function RasGetErrorStringW;       external 'rasapi32.dll' name 'RasGetErrorStringW';
function RasGetErrorString;        external 'rasapi32.dll' name 'RasGetErrorStringA';
function RasGetProjectionInfoA;    external 'rasapi32.dll' name 'RasGetProjectionInfoA';
function RasGetProjectionInfoW;    external 'rasapi32.dll' name 'RasGetProjectionInfoW';
function RasGetProjectionInfo;     external 'rasapi32.dll' name 'RasGetProjectionInfoA';
function RasHangUpA;               external 'rasapi32.dll' name 'RasHangUpA';
function RasHangUpW;               external 'rasapi32.dll' name 'RasHangUpW';
function RasHangUp;                external 'rasapi32.dll' name 'RasHangUpA';
function RasSetEntryDialParamsA;   external 'rasapi32.dll' name 'RasSetEntryDialParamsA';
function RasSetEntryDialParamsW;   external 'rasapi32.dll' name 'RasSetEntryDialParamsW';
function RasSetEntryDialParams;    external 'rasapi32.dll' name 'RasSetEntryDialParamsA';
function RasValidateEntryNameA;  external 'rasapi32.dll' name 'RasValidateEntryNameA';
function RasValidateEntryNameW;  external 'rasapi32.dll' name 'RasValidateEntryNameW';
function RasRenameEntryA;        external 'rasapi32.dll' name 'RasRenameEntryA';
function RasRenameEntryW;        external 'rasapi32.dll' name 'RasRenameEntryW';
function RasDeleteEntryA;        external 'rasapi32.dll' name 'RasDeleteEntryA';
function RasDeleteEntryW;        external 'rasapi32.dll' name 'RasDeleteEntryW';
function RasGetEntryPropertiesA; external 'rasapi32.dll' name 'RasGetEntryPropertiesA';
function RasGetEntryPropertiesW; external 'rasapi32.dll' name 'RasGetEntryPropertiesW';
function RasSetEntryPropertiesA; external 'rasapi32.dll' name 'RasSetEntryPropertiesA';
function RasSetEntryPropertiesW; external 'rasapi32.dll' name 'RasSetEntryPropertiesW';
function RasGetCountryInfoA;     external 'rasapi32.dll' name 'RasGetCountryInfoA';
function RasGetCountryInfoW;     external 'rasapi32.dll' name 'RasGetCountryInfoW';
function RasEnumDevicesA;        external 'rasapi32.dll' name 'RasEnumDevicesA';
function RasEnumDevicesW;        external 'rasapi32.dll' name 'RasEnumDevicesW';}

var
  Rnaph_Initialized       : Boolean = False;
  Is_Rnaph                : Boolean = False;
  Lib                     : HModule;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

function Rnaph_(const func: String): Pointer;
begin
  if not Rnaph_Initialized then
  begin
    // Try first with RASAPI32.DLL
    Lib:=LoadLibrary('rasapi32.dll');
    if Lib<>0 then
    begin
      Result:=GetProcAddress(Lib, PChar(Func+'A'));
      if Result<>nil then
      begin
        Rnaph_Initialized:=True;
        Exit;
      end else
      begin
        Result:=GetProcAddress(Lib, PChar(Func));
        if Result<>nil then
        begin
          Rnaph_Initialized:=True;
          Exit;
        end;
      end;
    end else raise Exception.Create('Error opening rasapi.dll');
    // function not found - try rnaph.dll
    Lib:=LoadLibrary('rnaph.dll');
    if Lib<>0 then
    begin
      Result:=GetProcAddress(Lib, PChar(Func));
      if Result <> nil then
      begin
        Rnaph_Initialized:=True;
        Is_Rnaph:=True;
        Exit;
      end else raise Exception.Create('Function '+Func+' not found!');
    end else raise Exception.Create('Error opening rnaph.dll');
  end else
  begin
    if Is_Rnaph then Result:=GetProcAddress(Lib,PChar(Func))
    else
    begin
      Result:=GetProcAddress(lib,PChar(Func+'A'));
      if Result=nil then Result:=GetProcAddress(lib,PChar(Func));
    end;
    if Result=nil then raise Exception.Create('Function '+Func+' not found!');
  end;
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

function RasValidateEntryName(lpszPhonebook, szEntry: PAnsiChar): Longint;
var
  F      : Function(lpszPhonebook, szEntry: PAnsiChar): Longint; stdcall;
begin
  @F:=Rnaph_('RasValidateEntryName');
  Result:=F(lpszPhonebook, szEntry);
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

function RasRenameEntry(lpszPhonebook, szEntryOld, szEntryNew: PAnsiChar): Longint;
var
  F      : function(lpszPhonebook, szEntryOld, szEntryNew: PAnsiChar): Longint; stdcall;
begin
  @F:=rnaph_('RasRenameEntry');
  Result:=F(lpszPhonebook, szEntryOld, szEntryNew);
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

function RasDeleteEntry(lpszPhonebook, szEntry: PAnsiChar): Longint;
var
  F      : function(lpszPhonebook, szEntry: PAnsiChar): Longint; stdcall;
begin
  @F:=Rnaph_('RasDeleteEntry');
  Result:=F(lpszPhonebook, szEntry);
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

function RasGetEntryProperties(lpszPhonebook, szEntry: PAnsiChar; lpbEntry: Pointer;
    var lpdwEntrySize: Longint; lpbDeviceInfo: Pointer;
    var lpdwDeviceInfoSize: Longint): Longint;
var
  F                  : function(lpszPhonebook, szEntry: PAnsiChar; lpbEntry: Pointer;
                                lpdwEntrySize      : Longint;
                                lpbDeviceInfo      : Pointer;
                                lpdwDeviceInfoSize : Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasGetEntryProperties');
  Result:=F(lpszPhonebook, szEntry, lpbEntry, lpdwEntrySize, lpbDeviceInfo, lpdwDeviceInfoSize);
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

function RasSetEntryProperties(lpszPhonebook, szEntry: PAnsiChar;
	  lpbEntry: Pointer; dwEntrySize: Longint; lpbDeviceInfo: Pointer;
    dwDeviceInfoSize: Longint): Longint;
var
  F                   : function(lpszPhonebook, szEntry: PAnsiChar;
                                 lpbEntry: Pointer; dwEntrySize: Longint;
                                 lpbDeviceInfo: Pointer;
                                 dwDeviceInfoSize: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasSetEntryProperties');
  Result:=F(lpszPhonebook, szEntry, lpbEntry, dwEntrySize, lpbDeviceInfo, dwDeviceInfoSize);
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

function RasGetCountryInfo(var lpCtryInfo: TRasCtryInfo; var lpdwSize: Longint): Longint;
var
  F                   : function(var lpCtryInfo: TRasCtryInfo;
                                 var lpdwSize: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasGetCountryInfo');
  Result:=F(lpCtryInfo, lpdwSize);
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

function RasEnumDevices(lpBuff: LpRasDevInfo; var lpcbSize: Longint;
                        var lpcDevices: Longint): Longint;
var
  F                   : function(lpBuff: LpRasDevInfo; var lpcbSize: Longint;
                                 var lpcDevices: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasEnumDevices');
  Result:=F(lpBuff, lpcbSize, lpcDevices);
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

(*function RasCreatePhonebookEntryA; external 'rasapi32.dll' name 'RasCreatePhonebookEntryA';
function RasCreatePhonebookEntryW; external 'rasapi32.dll' name 'RasCreatePhonebookEntryW';
function RasCreatePhonebookEntry;  external 'rasapi32.dll' name 'RasCreatePhonebookEntryA';
{function RasDialA;                 external 'rasapi32.dll' name 'RasDialA';
function RasDialW;                 external 'rasapi32.dll' name 'RasDialW';
function RasDial;                  external 'rasapi32.dll' name 'RasDialA';}
function RasEditPhonebookEntryA;   external 'rasapi32.dll' name 'RasEditPhonebookEntryA';
function RasEditPhonebookEntryW;   external 'rasapi32.dll' name 'RasEditPhonebookEntryW';
function RasEditPhonebookEntry;    external 'rasapi32.dll' name 'RasEditPhonebookEntryA';
function RasEnumConnectionsA;      external 'rasapi32.dll' name 'RasEnumConnectionsA';
function RasEnumConnectionsW;      external 'rasapi32.dll' name 'RasEnumConnectionsW';
function RasEnumConnections;       external 'rasapi32.dll' name 'RasEnumConnectionsA';
function RasEnumEntriesA;          external 'rasapi32.dll' name 'RasEnumEntriesA';
function RasEnumEntriesW;          external 'rasapi32.dll' name 'RasEnumEntriesW';
function RasEnumEntries;           external 'rasapi32.dll' name 'RasEnumEntriesA';
function RasGetConnectStatusA;     external 'rasapi32.dll' name 'RasGetConnectStatusA';
function RasGetConnectStatusW;     external 'rasapi32.dll' name 'RasGetConnectStatusW';
function RasGetConnectStatus;      external 'rasapi32.dll' name 'RasGetConnectStatusA';
function RasGetEntryDialParamsA;   external 'rasapi32.dll' name 'RasGetEntryDialParamsA';
function RasGetEntryDialParamsW;   external 'rasapi32.dll' name 'RasGetEntryDialParamsW';
function RasGetEntryDialParams;    external 'rasapi32.dll' name 'RasGetEntryDialParamsA';
function RasGetErrorStringA;       external 'rasapi32.dll' name 'RasGetErrorStringA';
function RasGetErrorStringW;       external 'rasapi32.dll' name 'RasGetErrorStringW';
function RasGetErrorString;        external 'rasapi32.dll' name 'RasGetErrorStringA';
function RasGetProjectionInfoA;    external 'rasapi32.dll' name 'RasGetProjectionInfoA';
function RasGetProjectionInfoW;    external 'rasapi32.dll' name 'RasGetProjectionInfoW';
function RasGetProjectionInfo;     external 'rasapi32.dll' name 'RasGetProjectionInfoA';
function RasHangUpA;               external 'rasapi32.dll' name 'RasHangUpA';
function RasHangUpW;               external 'rasapi32.dll' name 'RasHangUpW';
function RasHangUp;                external 'rasapi32.dll' name 'RasHangUpA';
function RasSetEntryDialParamsA;   external 'rasapi32.dll' name 'RasSetEntryDialParamsA';
function RasSetEntryDialParamsW;   external 'rasapi32.dll' name 'RasSetEntryDialParamsW';
function RasSetEntryDialParams;    external 'rasapi32.dll' name 'RasSetEntryDialParamsA';
function RasValidateEntryNameA;  external 'rasapi32.dll' name 'RasValidateEntryNameA';
function RasValidateEntryNameW;  external 'rasapi32.dll' name 'RasValidateEntryNameW';
function RasRenameEntryA;        external 'rasapi32.dll' name 'RasRenameEntryA';
function RasRenameEntryW;        external 'rasapi32.dll' name 'RasRenameEntryW';
function RasDeleteEntryA;        external 'rasapi32.dll' name 'RasDeleteEntryA';
function RasDeleteEntryW;        external 'rasapi32.dll' name 'RasDeleteEntryW';
function RasGetEntryPropertiesA; external 'rasapi32.dll' name 'RasGetEntryPropertiesA';
function RasGetEntryPropertiesW; external 'rasapi32.dll' name 'RasGetEntryPropertiesW';
function RasSetEntryPropertiesA; external 'rasapi32.dll' name 'RasSetEntryPropertiesA';
function RasSetEntryPropertiesW; external 'rasapi32.dll' name 'RasSetEntryPropertiesW';
function RasGetCountryInfoA;     external 'rasapi32.dll' name 'RasGetCountryInfoA';
function RasGetCountryInfoW;     external 'rasapi32.dll' name 'RasGetCountryInfoW';
function RasEnumDevicesA;        external 'rasapi32.dll' name 'RasEnumDevicesA';
function RasEnumDevicesW;        external 'rasapi32.dll' name 'RasEnumDevicesW';
*)
function RasDialA(lpRasDialExt: LPRasDialExtensions; lpszPhoneBook: PAnsiChar;
                  var params: TRasDialParamsA; dwNotifierType: Longint;
                  lpNotifier: Pointer; var rasconn: THRasConn): Longint;
var F : function (lpRasDialExt: LPRasDialExtensions; lpszPhoneBook: PAnsiChar;
                  var params: TRasDialParamsA; dwNotifierType: Longint;
                  lpNotifier: Pointer; var rasconn: THRasConn): Longint; stdcall;
begin
  @F:=Rnaph_('RasDialA');
  Result:=F(lpRasDialExt, lpszPhoneBook, params, dwNotifierType, lpNotifier, rasconn);
end;
function RasDialW(lpRasDialExt: LPRasDialExtensions; lpszPhoneBook: PWideChar;
                  var params: TRasDialParamsW; dwNotifierType: Longint;
                  lpNotifier: Pointer; var rasconn: THRasConn): Longint;
var F : function (lpRasDialExt: LPRasDialExtensions; lpszPhoneBook: PWideChar;
                  var params: TRasDialParamsW; dwNotifierType: Longint;
                  lpNotifier: Pointer; var rasconn: THRasConn): Longint; stdcall;
begin
  @F:=Rnaph_('RasDialW');
  Result:=F(lpRasDialExt, lpszPhoneBook, params, dwNotifierType, lpNotifier, rasconn);
end;
function RasDial(lpRasDialExt: LPRasDialExtensions; lpszPhoneBook: PAnsiChar;
                 var params: TRasDialParams; dwNotifierType: Longint;
                 lpNotifier: Pointer; var rasconn: THRasConn): Longint;
var F : function(lpRasDialExt: LPRasDialExtensions; lpszPhoneBook: PAnsiChar;
                 var params: TRasDialParams; dwNotifierType: Longint;
                 lpNotifier: Pointer; var rasconn: THRasConn): Longint; stdcall;
begin
  @F:=Rnaph_('RasDialA');
  Result:=F(lpRasDialExt, lpszPhoneBook, params, dwNotifierType, lpNotifier, rasconn);
end;

function RasEnumConnectionsA(RasConnArray: LPRasConnA; var lpcb: Longint;
                             var lpcConnections: Longint): Longint;
var F : function(RasConnArray: LPRasConnA; var lpcb: Longint;
                             var lpcConnections: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasEnumConnectionsA');
  Result:=F(RasConnArray,lpcb,lpcConnections);
end;
function RasEnumConnectionsW(RasConnArray: LPRasConnW; var lpcb: Longint;
                             var lpcConnections: Longint): Longint;
var F : function(RasConnArray: LPRasConnW; var lpcb: Longint;
                             var lpcConnections: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasEnumConnectionsW');
  Result:=F(RasConnArray,lpcb,lpcConnections);
end;
function RasEnumConnections(RasConnArray: LPRasConn; var lpcb: Longint;
                             var lpcConnections: Longint): Longint;
var F : function (RasConnArray: LPRasConn; var lpcb: Longint;
                             var lpcConnections: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasEnumConnectionsA');
  Result:=F(RasConnArray,lpcb,lpcConnections);
end;
function RasEnumEntriesA(Reserved: PAnsiChar; lpszPhoneBook: PAnsiChar;
                         entrynamesArray: LPRasEntryNameA; var lpcb: Longint;
                         var lpcEntries: Longint): Longint;
var F : function (Reserved: PAnsiChar; lpszPhoneBook: PAnsiChar;
                         entrynamesArray: LPRasEntryNameA; var lpcb: Longint;
                         var lpcEntries: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasEnumEntriesA');
  Result:=F(Reserved,lpszPhoneBook,EntryNamesArray,lpcb,lpcEntries);
end;
function RasEnumEntriesW(reserved: PWideChar; lpszPhoneBook: PWideChar;
                         entrynamesArray: LPRasEntryNameW; var lpcb: Longint;
                         var lpcEntries: Longint): Longint;
var F : function (reserved: PWideChar; lpszPhoneBook: PWideChar;
                         entrynamesArray: LPRasEntryNameW; var lpcb: Longint;
                         var lpcEntries: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasEnumEntriesW');
  Result:=F(Reserved,lpszPhoneBook,EntryNamesArray,lpcb,lpcEntries);
end;
function RasEnumEntries(reserved: PAnsiChar; lpszPhoneBook: PAnsiChar;
                        entrynamesArray: LPRasEntryName; var lpcb: Longint;
                        var lpcEntries: Longint): Longint;
var F : function (reserved: PAnsiChar; lpszPhoneBook: PAnsiChar;
                        entrynamesArray: LPRasEntryName; var lpcb: Longint;
                        var lpcEntries: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasEnumEntriesA');
  Result:=F(Reserved,lpszPhoneBook,EntryNamesArray,lpcb,lpcEntries);
end;
function RasGetConnectStatusA(hConn: THRasConn; var lpStatus: TRasConnStatusA): Longint;
var F : function (hConn: THRasConn; var lpStatus: TRasConnStatusA): Longint; stdcall;
begin
  @F:=Rnaph_('RasGetConnectStatusA');
  Result:=F(hConn,lpStatus);
end;
function RasGetConnectStatusW(hConn: THRasConn;var lpStatus: TRasConnStatusW): Longint;
var F : function (hConn: THRasConn;var lpStatus: TRasConnStatusW): Longint; stdcall;
begin
  @F:=Rnaph_('RasGetConnectStatusW');
  Result:=F(hConn,lpStatus);
end;
function RasGetConnectStatus(hConn: THRasConn;var lpStatus: TRasConnStatus): Longint;
var F : function (hConn: THRasConn;var lpStatus: TRasConnStatus): Longint; stdcall;
begin
  @F:=Rnaph_('RasGetConnectStatusA');
  Result:=F(hConn,lpStatus);
end;
function RasGetErrorStringA(errorValue: Integer;erroString: PAnsiChar;cBufSize: Longint): Longint;
var F : function (errorValue: Integer;erroString: PAnsiChar;cBufSize: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasGetErrorStringA');
  Result:=F(errorValue,erroString,cBufSize);
end;
function RasGetErrorStringW(errorValue: Integer;erroString: PWideChar;cBufSize: Longint): Longint;
var F : function (errorValue: Integer;erroString: PWideChar;cBufSize: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasGetErrorStringW');
  Result:=F(errorValue,erroString,cBufSize);
end;
function RasGetErrorString(errorValue: Integer;erroString: PAnsiChar;cBufSize: Longint): Longint;
var F : function (errorValue: Integer;erroString: PAnsiChar;cBufSize: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasGetErrorStringA');
  Result:=F(errorValue,erroString,cBufSize);
end;
function RasHangUpA(hConn: THRasConn): Longint;
var F : function (hConn: THRasConn): Longint; stdcall;
begin
  @F:=Rnaph_('RasHangUpA');
  Result:=F(hConn);
end;
function RasHangUpW(hConn: THRasConn): Longint;
var F : function (hConn: THRasConn): Longint; stdcall;
begin
  @F:=Rnaph_('RasHangUpW');
  Result:=F(hConn);
end;
function RasHangUp(hConn: THRasConn): Longint;
var F : function (hConn: THRasConn): Longint; stdcall;
begin
  @F:=Rnaph_('RasHangUpA');
  Result:=F(hConn);
end;
function RasGetProjectionInfoA(hConn: THRasConn; rasproj: TRasProjection;
                               lpProjection: Pointer; var lpcb: Longint): Longint;
var F : function (hConn: THRasConn; rasproj: TRasProjection;
                               lpProjection: Pointer; var lpcb: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasGetProjectionInfoA');
  Result:=F(hConn,RasProj,lpProjection,lpcb);
end;
function RasGetProjectionInfoW(hConn: THRasConn; rasproj: TRasProjection;
                               lpProjection: Pointer; var lpcb: Longint): Longint;
var F : function (hConn: THRasConn; rasproj: TRasProjection;
                               lpProjection: Pointer; var lpcb: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasGetProjectionInfoW');
  Result:=F(hConn,RasProj,lpProjection,lpcb);
end;
function RasGetProjectionInfo(hConn: THRasConn; rasproj: TRasProjection;
                              lpProjection: Pointer; var lpcb: Longint): Longint;
var F : function (hConn: THRasConn; rasproj: TRasProjection;
                              lpProjection: Pointer; var lpcb: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasGetProjectionInfoA');
  Result:=F(hConn,RasProj,lpProjection,lpcb);
end;
function RasCreatePhonebookEntryA(hwndParentWindow: HWND;lpszPhoneBook: PAnsiChar): Longint;
var F : function (hwndParentWindow: HWND;lpszPhoneBook: PAnsiChar): Longint; stdcall;
begin
  @F:=Rnaph_('RasCreatePhonebookEntryA');
  Result:=F(hwndParentWindow,lpszPhoneBook);
end;
function RasCreatePhonebookEntryW(hwndParentWindow: HWND;lpszPhoneBook: PWideChar): Longint;
var F : function (hwndParentWindow: HWND;lpszPhoneBook: PWideChar): Longint; stdcall;
begin
  @F:=Rnaph_('RasCreatePhonebookEntryW');
  Result:=F(hwndParentWindow,lpszPhoneBook);
end;
function RasCreatePhonebookEntry(hwndParentWindow: HWND;lpszPhoneBook: PAnsiChar): Longint;
var F : function (hwndParentWindow: HWND;lpszPhoneBook: PAnsiChar): Longint; stdcall;
begin
  @F:=Rnaph_('RasCreatePhonebookEntryA');
  Result:=F(hwndParentWindow,lpszPhoneBook);
end;
function RasEditPhonebookEntryA(hwndParentWindow: HWND; lpszPhoneBook: PAnsiChar;
                                lpszEntryName: PAnsiChar): Longint;
var F : function (hwndParentWindow: HWND; lpszPhoneBook: PAnsiChar;
                                lpszEntryName: PAnsiChar): Longint; stdcall;
begin
  @F:=Rnaph_('RasEditPhonebookEntryA');
  Result:=F(hwndParentWindow,lpszPhoneBook,lpszEntryName);
end;
function RasEditPhonebookEntryW(hwndParentWindow: HWND; lpszPhoneBook: PWideChar;
                                lpszEntryName: PWideChar): Longint;
var F : function (hwndParentWindow: HWND; lpszPhoneBook: PWideChar;
                                lpszEntryName: PWideChar): Longint; stdcall;
begin
  @F:=Rnaph_('RasEditPhonebookEntryW');
  Result:=F(hwndParentWindow,lpszPhoneBook,lpszEntryName);
end;
function RasEditPhonebookEntry(hwndParentWindow: HWND; lpszPhoneBook: PAnsiChar;
                               lpszEntryName: PAnsiChar): Longint;
var F : function (hwndParentWindow: HWND; lpszPhoneBook: PAnsiChar;
                               lpszEntryName: PAnsiChar): Longint; stdcall;
begin
  @F:=Rnaph_('RasEditPhonebookEntryA');
  Result:=F(hwndParentWindow,lpszPhoneBook,lpszEntryName);
end;
function RasSetEntryDialParamsA(lpszPhoneBook: PAnsiChar; var lpDialParams: TRasDialParamsA;
                                fRemovePassword: LongBool): Longint;
var F : function (lpszPhoneBook: PAnsiChar; var lpDialParams: TRasDialParamsA;
                                fRemovePassword: LongBool): Longint; stdcall;
begin
  @F:=Rnaph_('RasSetEntryDialParamsA');
  Result:=F(lpszPhoneBook,lpDialParams,fRemovePassword);
end;
function RasSetEntryDialParamsW(lpszPhoneBook: PWideChar; var lpDialParams: TRasDialParamsW;
                                fRemovePassword: LongBool): Longint;
var F : function (lpszPhoneBook: PWideChar; var lpDialParams: TRasDialParamsW;
                                fRemovePassword: LongBool): Longint; stdcall;
begin
  @F:=Rnaph_('RasSetEntryDialParamsW');
  Result:=F(lpszPhoneBook,lpDialParams,fRemovePassword);
end;
function RasSetEntryDialParams(lpszPhoneBook: PAnsiChar; var lpDialParams: TRasDialParams;
                               fRemovePassword: LongBool): Longint;
var F : function (lpszPhoneBook: PAnsiChar; var lpDialParams: TRasDialParams;
                               fRemovePassword: LongBool): Longint; stdcall;
begin
  @F:=Rnaph_('RasSetEntryDialParamsA');
  Result:=F(lpszPhoneBook,lpDialParams,fRemovePassword);
end;
function RasGetEntryDialParamsA(lpszPhoneBook: PAnsiChar; var lpDialParams: TRasDialParamsA;
                                var lpfPassword: LongBool): Longint;
var F : function (lpszPhoneBook: PAnsiChar; var lpDialParams: TRasDialParamsA;
                                var lpfPassword: LongBool): Longint; stdcall;
begin
  @F:=Rnaph_('RasGetEntryDialParamsA');
  Result:=F(lpszPhoneBook,lpDialParams,lpfPassword);
end;
function RasGetEntryDialParamsW(lpszPhoneBook: PWideChar; var lpDialParams: TRasDialParamsW;
                                var lpfPassword: LongBool): Longint;
var F : function (lpszPhoneBook: PWideChar; var lpDialParams: TRasDialParamsW;
                                var lpfPassword: LongBool): Longint; stdcall;
begin
  @F:=Rnaph_('RasGetEntryDialParamsW');
  Result:=F(lpszPhoneBook,lpDialParams,lpfPassword);
end;
function RasGetEntryDialParams(lpszPhoneBook: PAnsiChar; var lpDialParams: TRasDialParams;
                               var lpfPassword: LongBool): Longint;
var F : function (lpszPhoneBook: PAnsiChar; var lpDialParams: TRasDialParams;
                               var lpfPassword: LongBool): Longint; stdcall;
begin
  @F:=Rnaph_('RasGetEntryDialParamsA');
  Result:=F(lpszPhoneBook,lpDialParams,lpfPassword);
end;

//RNAPH
function RasValidateEntryNameA(lpszPhonebook,szEntry: PAnsiChar): Longint;
var F : function (lpszPhonebook,szEntry: PAnsiChar): Longint; stdcall;
begin
  @F:=Rnaph_('RasValidateEntryNameA');
  Result:=F(lpszPhoneBook,szEntry);
end;
function RasValidateEntryNameW(lpszPhonebook,szEntry: PWideChar): Longint;
var F : function (lpszPhonebook,szEntry: PWideChar): Longint; stdcall;
begin
  @F:=Rnaph_('RasValidateEntryNameW');
  Result:=F(lpszPhoneBook,szEntry);
end;

function RasRenameEntryA(lpszPhonebook,szEntryOld,szEntryNew: PAnsiChar): Longint;
var F : function (lpszPhonebook,szEntryOld,szEntryNew: PAnsiChar): Longint; stdcall;
begin
  @F:=Rnaph_('RasRenameEntryA');
  Result:=F(lpszPhonebook,szEntryOld,szEntryNew);
end;

function RasRenameEntryW(lpszPhonebook,szEntryOld,szEntryNew: PWideChar): Longint;
var F : function (lpszPhonebook,szEntryOld,szEntryNew: PWideChar): Longint; stdcall;
begin
  @F:=Rnaph_('RasRenameEntryW');
  Result:=F(lpszPhonebook,szEntryOld,szEntryNew);
end;

{function RasRenameEntry(lpszPhonebook,szEntryOld,szEntryNew: PAnsiChar): Longint;
var F : function (lpszPhonebook,szEntryOld,szEntryNew: PAnsiChar): Longint; stdcall;
begin
end;}

function RasDeleteEntryA(lpszPhonebook,szEntry: PAnsiChar): Longint;
var F : function (lpszPhonebook,szEntry: PAnsiChar): Longint; stdcall;
begin
  @F:=Rnaph_('RasDeleteEntryA');
  Result:=F(lpszPhonebook,szEntry);
end;

function RasDeleteEntryW(lpszPhonebook,szEntry: PWideChar): Longint;
var F : function (lpszPhonebook,szEntry: PWideChar): Longint; stdcall;
begin
  @F:=Rnaph_('RasDeleteEntryW');
  Result:=F(lpszPhonebook,szEntry);
end;

{function RasDeleteEntry(lpszPhonebook,szEntry: PAnsiChar): Longint;
var F : function (lpszPhonebook,szEntry: PAnsiChar): Longint; stdcall;
begin
end;}

function RasGetEntryPropertiesA(lpszPhonebook, szEntry: PAnsiChar; lpbEntry: Pointer;
                                var lpdwEntrySize: Longint; lpbDeviceInfo: Pointer;
                                var lpdwDeviceInfoSize: Longint): Longint;
var F : function (lpszPhonebook, szEntry: PAnsiChar; lpbEntry: Pointer;
                                var lpdwEntrySize: Longint; lpbDeviceInfo: Pointer;
                                var lpdwDeviceInfoSize: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasGetEntryPropertiesA');
  Result:=F(lpszPhoneBook,szEntry,lpbEntry,lpdwEntrySize,lpbDeviceInfo,lpdwDeviceInfoSize);
end;

function RasGetEntryPropertiesW(lpszPhonebook, szEntry: PWideChar; lpbEntry: Pointer;
                                var lpdwEntrySize: Longint; lpbDeviceInfo: Pointer;
                                var lpdwDeviceInfoSize: Longint): Longint;
var F : function (lpszPhonebook, szEntry: PWideChar; lpbEntry: Pointer;
                                var lpdwEntrySize: Longint; lpbDeviceInfo: Pointer;
                                var lpdwDeviceInfoSize: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasGetEntryPropertiesW');
  Result:=F(lpszPhoneBook,szEntry,lpbEntry,lpdwEntrySize,lpbDeviceInfo,lpdwDeviceInfoSize);
end;

{function RasGetEntryProperties(lpszPhonebook, szEntry: PAnsiChar; lpbEntry: Pointer;
                                var lpdwEntrySize: Longint; lpbDeviceInfo: Pointer;
                                var lpdwDeviceInfoSize: Longint): Longint;
var F : function (lpszPhonebook, szEntry: PAnsiChar; lpbEntry: Pointer;
                                var lpdwEntrySize: Longint; lpbDeviceInfo: Pointer;
                                var lpdwDeviceInfoSize: Longint): Longint; stdcall;
begin
end;}

function RasSetEntryPropertiesA(lpszPhonebook, szEntry: PAnsiChar; lpbEntry: Pointer;
                                dwEntrySize: Longint; lpbDeviceInfo: Pointer;
                                dwDeviceInfoSize: Longint): Longint;
var F : function (lpszPhonebook, szEntry: PAnsiChar; lpbEntry: Pointer;
                                dwEntrySize: Longint; lpbDeviceInfo: Pointer;
                                dwDeviceInfoSize: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasSetEntryPropertiesA');
  Result:=F(lpszPhoneBook,szEntry,lpbEntry,dwEntrySize,lpbDeviceInfo,dwDeviceInfoSize);
end;

function RasSetEntryPropertiesW(lpszPhonebook, szEntry: PWideChar; lpbEntry: Pointer;
                                dwEntrySize: Longint; lpbDeviceInfo: Pointer;
                                dwDeviceInfoSize: Longint): Longint;
var F : function (lpszPhonebook, szEntry: PWideChar; lpbEntry: Pointer;
                                dwEntrySize: Longint; lpbDeviceInfo: Pointer;
                                dwDeviceInfoSize: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasSetEntryPropertiesW');
  Result:=F(lpszPhoneBook,szEntry,lpbEntry,dwEntrySize,lpbDeviceInfo,dwDeviceInfoSize);
end;

{function RasSetEntryProperties(lpszPhonebook, szEntry: PAnsiChar; lpbEntry: Pointer;
                               dwEntrySize: Longint; lpbDeviceInfo: Pointer;
                               dwDeviceInfoSize: Longint): Longint;
var F : function (lpszPhonebook, szEntry: PAnsiChar; lpbEntry: Pointer;
                               dwEntrySize: Longint; lpbDeviceInfo: Pointer;
                               dwDeviceInfoSize: Longint): Longint; stdcall;
begin
end;}

function RasGetCountryInfoA(var lpCtryInfo: TRasCtryInfo;var lpdwSize: Longint): Longint;
var F : function (var lpCtryInfo: TRasCtryInfo;var lpdwSize: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasGetCountryInfoA');
  Result:=F(lpCtryInfo,lpdwSize);
end;

function RasGetCountryInfoW(var lpCtryInfo: TRasCtryInfo;var lpdwSize: Longint): Longint;
var F : function (var lpCtryInfo: TRasCtryInfo;var lpdwSize: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasGetCountryInfoW');
  Result:=F(lpCtryInfo,lpdwSize);
end;

{function RasGetCountryInfo(var lpCtryInfo: TRasCtryInfo;var lpdwSize: Longint): Longint;
var F : function (var lpCtryInfo: TRasCtryInfo;var lpdwSize: Longint): Longint; stdcall;
begin
end;}

function RasEnumDevicesA(lpBuff: LpRasDevInfoA; var lpcbSize: Longint;
                         var lpcDevices: Longint): Longint;
var F : function (lpBuff: LpRasDevInfoA; var lpcbSize: Longint;
                         var lpcDevices: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasEnumDevicesA');
  Result:=F(lpBuff,lpcbSize,lpcDevices);
end;

function RasEnumDevicesW(lpBuff: LpRasDevInfoW; var lpcbSize: Longint;
                         var lpcDevices: Longint): Longint;
var F : function (lpBuff: LpRasDevInfoW; var lpcbSize: Longint;
                         var lpcDevices: Longint): Longint; stdcall;
begin
  @F:=Rnaph_('RasEnumDevicesW');
  Result:=F(lpBuff,lpcbSize,lpcDevices);
end;

{function RasEnumDevices(lpBuff: LpRasDevInfo; var lpcbSize: Longint;
                         var lpcDevices: Longint): Longint;
var F : function (lpBuff: LpRasDevInfo; var lpcbSize: Longint;
                         var lpcDevices: Longint): Longint; stdcall;
begin
end;}

function TDialUp.GetIP(HRC : THRASConn) : Integer;
var RASPppIp: TRASPppIp;
    lpcp    : Integer;
begin
  Result:=0; FCIP:=''; FSIP:='';
  if HRC=0 then Exit;
  FillChar(RASPppIp,SizeOf(TRASPppIp),#00);
  RASPppIp.dwSize:=SizeOf(TRASPppIp); lpcp:=RASPppIp.dwSize;
  Result:=RASGetProjectionInfo(HRC,RASP_PppIp,@RASPppIp,lpcp);
  if Result=0 then {OK}
  begin
    FCIP:=RASPppIp.szIpAddress;
    FSIP:=RASPppIp.szServerIpAddress;
  end;
end;

function TDialUp.SearchDUNA: Boolean;
var TempKey, Temp2Key                 : HKey;
    keyname, lockey                   : String;
//    flag                              : Boolean;
    NumSubKeys, NumValues, count      : Integer;
    dwType, dwSize, Len               : DWORD ;
begin
  Result:=False;
  if (Win32Platform<>VER_PLATFORM_WIN32_WINDOWS) then exit; {Not W9X ! Exit!}
  DUNA.Clear;
  TempKey:=0; Temp2Key:=0;
  Result:=RegOpenKeyEx(HKEY_LOCAL_MACHINE,PChar(Reg_PerfStatEmum),0,KEY_READ,TempKey)=ERROR_SUCCESS;
  if Result then
    Result:=RegOpenKeyEx(HKEY_DYN_DATA,PChar(Reg_PerfStatStart),0,KEY_READ,Temp2Key)=ERROR_SUCCESS;
  if Result then
  begin
    NumSubKeys:=0;
    NumValues:=0;
    {Count:=}RegQueryInfoKey(TempKey,nil,nil,nil,@NumSubKeys,nil,nil,@NumValues,nil,nil,nil,nil) ;
    if NumSubKeys<>0 then
    begin
      SetString(LocKey,nil,33);
      for Count:=0 to (NumSubKeys-1) do
      begin
        Len:=33;
        RegEnumKeyEx(TempKey,Count,PChar(LocKey),Len,nil,nil,nil,nil);
        KeyName:=PChar(LocKey)+'\'+Reg_PerfConn;
        if RegQueryValueEx(Temp2Key,PChar(keyname),nil,@dwType,nil,@dwSize)=ERROR_SUCCESS then
          DUNA.Add(PChar(lockey));
      end ;
    end ;
  end ;
  if TempKey<>0 then RegCloseKey(TempKey);
  if Temp2Key<>0 then RegCloseKey(Temp2Key);
  if DUNA.Count<>0 then DUNA.Sort;
end;

function TDialUp.InitializePerfStats(Start,Search: Boolean) : Boolean;
var TempKey                      : HKey;
    KeyName                      : String;
    dwType, dwSize               : DWORD;
    TempData                     : Pointer;
function InitData(ValueName: String) : Boolean;
begin
  Result:=False;
  ValueName:=FDunaKey+'\'+ValueName ;
  if RegQueryValueEx(TempKey,PChar(ValueName),nil,@dwType,nil,@dwSize)=ERROR_SUCCESS then
  begin
    try		// read data but ignore it
      GetMem(TempData,dwSize) ;
      Result:=RegQueryValueEx(TempKey,PChar(ValueName),nil,@dwType,TempData,@dwSize)=ERROR_SUCCESS;
    finally
      FreeMem (TempData);
    end;
  end;
end;

begin
  Result:=False;
  if Win32Platform=VER_PLATFORM_WIN32s then Exit; {Win32s? Quit!}
  Result:=True;
  if Win32Platform=VER_PLATFORM_WIN32_WINDOWS then {Win9X? Continue:}
  begin
    if Search then
    begin
      SearchDUNA;
      if DUNA.Count=0 then
      begin
        Result:=False;
        Exit;
      end;
      FDUNAKey:=DUNA[0]; // set first
    end;
    TempKey:=0;
    if Start then KeyName:=Reg_PerfStatStart
      else KeyName:=Reg_PerfStatStop;
    Result:=RegOpenKeyEx(HKEY_DYN_DATA,PChar(KeyName),0,KEY_ALL_ACCESS,TempKey)=ERROR_SUCCESS;
    if Result then
    begin
      Result:=InitData(Reg_PerfXmit);
      if Result then Result:=InitData(Reg_PerfRecv);
      if Result then Result:=InitData(Reg_PerfConn);
      RegCloseKey(TempKey);
    end;
  end;
  if Result then
  begin
    if Start then Result:=GetPerfStats; // get counters
    ResetPerfStats; // set current
  end;
end;

function TDialUp.GetPerfStats : Boolean;
var TempKey                          : HKey;
    dwType,dwSize,ConnSpd            : DWORD ;
    PerfData                         : PPERF_DATA_BLOCK ;
    PerfObj                          : PPERF_OBJECT_TYPE ;
    PerfCDef                         : PPERF_COUNTER_DEFINITION ;
    PerfmCDef                        : array [1..50] of PPERF_COUNTER_DEFINITION ;
    PerfInst                         : PPERF_INSTANCE_DEFINITION ;
    PerfCBlk                         : PPERF_COUNTER_BLOCK ;
    RegBuff,ObjPtr,DefPtr,CountPtr   : PChar ;
    ActualSize,DataType              : Integer;
    ObjNr,InstNr,CountNr             : Integer ;
    DatValue                         : ^Integer ;
    LoopFlag                         : Boolean ;

function GetData (ValueName: string; var Info: DWORD): boolean ;
begin
  ValueName:=FDUNAKey+'\'+ValueName ;
  dwSize:=4; // data is four bytes of binary, aka a DWORD
  Result:=RegQueryValueEx(TempKey,PChar(ValueName),nil,@dwType,@Info,@dwSize)=ERROR_SUCCESS;
end;

begin
  Result:=False;
  if Win32Platform=VER_PLATFORM_WIN32s then exit;
  if Win32Platform=VER_PLATFORM_WIN32_WINDOWS then  // Win95/98
  begin //
    TempKey:=0;
    Result:=RegOpenKeyEx(HKEY_DYN_DATA,PChar(Reg_PerfStatData),0,KEY_READ,TempKey)=ERROR_SUCCESS;
    if Result then
    begin //
      Result:=GetData(Reg_PerfXmit,fStatsXmitTot);
      if Result then Result:=GetData(Reg_PerfRecv,FStatsRecvTot);
      if Result then Result:=GetData(Reg_PerfConn,ConnSpd);
      RegCloseKey(TempKey);
      if Result then
      begin //
        if FStatsXmitTot<FStatsXmitCon then ResetPerfStats;
        if FStatsRecvTot<FStatsRecvCon then ResetPerfStats;
        FStatsConnSpeed:=ConnSpd;
        FStatsXmit:=FStatsXmitTot-FStatsXmitCon;
        FStatsRecv:=FStatsRecvTot-FStatsRecvCon;
      end;
    end;
  end else
  begin                           // Win NT
    DataType:=REG_NONE;        // Windows NT performance data
    try
      // start with small buffer, it will be increased in size if necessary the
      // first time, to that required for the returned performance data
      if DataSize=0 then DataSize:=TOTALBYTES;
      GetMem(RegBuff,DataSize);
      ActualSize:=DataSize;
      while RegQueryValueEx(HKEY_PERFORMANCE_DATA,PChar(PData_RAS_Total),nil,@DataType,PByte(RegBuff),@ActualSize)=ERROR_MORE_DATA do
      begin //
        FreeMem(RegBuff);
        Inc(DataSize,BYTEINCREMENT);  // increase buffers size by 1K
        GetMem(RegBuff,DataSize);
        ActualSize:=DataSize;
      end; //
      // get performance data block
      if ActualSize<100 then Exit;     // forget it
      Pointer(PerfData):=RegBuff;   // PERF_DATA_BLOCK
      // get performance object type blocks
      if PerfData.NumObjectTypes=0 then Exit;   // no objects to process
      ObjPtr:=RegBuff+PerfData.HeaderLength;
      for ObjNr:=1 to PerfData.NumObjectTypes do
      begin
        Application.ProcessMessages;
        Pointer(PerfObj):=ObjPtr;  // PERF_OBJECT_TYPE
        //  perfobj.ObjectNameTitleIndex   // not needed
        DefPtr:=ObjPtr+PerfObj.HeaderLength;
        // get performance counter definitions
        if PerfObj.NumCounters>0 then
        begin
          // read through definitions, really looking for length
          for Countnr:=1 to PerfObj.NumCounters do
          begin //
            Pointer(PerfmcDef[Countnr]):=DefPtr;  // keep each definitition
            Pointer(PerfcDef):=DefPtr;  // PERF_COUNTER_DEFINITION
            Inc(DefPtr, PerfcDef.ByteLength);
            if CountNr>50 then exit;
            Application.ProcessMessages;
          end;
            // now get counter data, perhaps from multiple instances
            LoopFlag:=True;
            InstNr:=1;
            while LoopFlag do
            begin
              if PerfObj.NumInstances>=1 then
              begin
                Pointer(PerfInst):=DefPtr;  // PERF_INSTANCE_DEFINITON
                // Instance Name:=WideCharToString
                //	(PWideChar(defptr+perfinst.nameoffset)));
                Inc(DefPtr,PerfInst.ByteLength);
              end;
              // get counter block, then read actual data values
              Countptr:=DefPtr;  // after reading through blocks
              Pointer(PerfCBlk):=CountPtr;  // PERF_COUNTER_BLOCK
              // get counter data, currently only doublewords
              for CountNr:=1 to PerfObj.NumCounters do
              begin
                if PerfMCDef[CountNr].CounterNameTitleIndex=Pdata_Bytes_Xmit then
                begin
                  Pointer(DatValue):=CountPtr+PerfMCDef[Countnr].CounterOffset;
                  if DatValue^>FStatsXmit then
                    FStatsXmit:=Datvalue^;
                end;
                if PerfMCDef[CountNr].CounterNameTitleIndex=Pdata_Bytes_Recv then
                begin
                  Pointer(datvalue):=CountPtr +
                  PerfMCDef[Countnr].CounterOffset;
                  if Datvalue^>FStatsRecv then
                    FStatsRecv:=Datvalue^;
                end;
              end;
              Inc(DefPtr, PerfCBlk.ByteLength);
              // check for more instances of these counters
              if PerfObj.NumInstances>=1 then
              begin
                Inc(InstNr);
                if InstNr>PerfObj.NumInstances then LoopFlag:=False;
              end else
              LoopFlag:=False;
            end;
          end;
          ObjPtr:=ObjPtr+PerfObj.TotalByteLength;
        end;
        Result:=True;
      finally
      if RegBuff<>nil then Freemem(RegBuff);
    end;
  end;
end;

procedure TDialUp.ResetPerfStats;
begin
  FStatsXmitCon:=FStatsXmitTot; // tot counters are from IPL
  FStatsRecvCon:=FStatsRecvTot;
  FStatsXmit:=0;                // current connection
  FStatsRecv:=0;
end;

initialization

finalization
  if Rnaph_initialized and Is_rnaph then FreeLibrary(lib);
end.

