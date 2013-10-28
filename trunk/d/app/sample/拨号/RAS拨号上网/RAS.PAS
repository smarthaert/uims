{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *


Unit:         Remote Access Service (RAS)
Creation:     Feb 18, 1997. Translated from MS-Visual C 4.2 header files
EMail:        francois.piette@pophost.eunet.be    francois.piette@rtfm.be
              http://www.rtfm.be/fpiette
Legal issues: Copyright (C) 1997, 1998 by Fran鏾is PIETTE
              Rue de Grady 24, 4053 Embourg, Belgium. Fax: +32-4-365.74.56
              <francois.piette@pophost.eunet.be>

              This software is provided 'as-is', without any express or
              implied warranty.  In no event will the author be held liable
              for any  damages arising from the use of this software.

              Permission is granted to anyone to use this software for any
              purpose, including commercial applications, and to alter it
              and redistribute it freely, subject to the following
              restrictions:

              1. The origin of this software must not be misrepresented,
                 you must not claim that you wrote the original software.
                 If you use this software in a product, an acknowledgment
                 in the product documentation would be appreciated but is
                 not required.

              2. Altered source versions must be plainly marked as such, and
                 must not be misrepresented as being the original software.

              3. This notice may not be removed or altered from any source
                 distribution.
Updates:
Sep 25, 1998  V1.10  Added RasGetIPAddress and RasGetProjectionInfoA. Thanks to
              Jan Tomasek <xtomasej@fel.cvut.cz> for his help.


 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
unit Ras;

interface

uses
    Windows, SysUtils;

{$DEFINE WINVER400}
const
    RasUnitVersion        = 110;
    CopyRight    : String = ' RasUnit (c) 97-98 F. Piette V1.10 ';
    rasapi32              = 'rasapi32.dll';

    UNLEN                 = 256;    // Maximum user name length
    PWLEN                 = 256;    // Maximum password length
    CNLEN                 = 15;     // Computer name length
    DNLEN                 = CNLEN;  // Maximum domain name length

    RAS_MaxDeviceType     = 16;
    RAS_MaxPhoneNumber    = 128;
    RAS_MaxIpAddress      = 15;
    RAS_MaxIpxAddress     = 21;

{$IFDEF WINVER400}
    RAS_MaxEntryName      = 256;
    RAS_MaxDeviceName     = 128;
    RAS_MaxCallbackNumber = RAS_MaxPhoneNumber;
{$ELSE}
    RAS_MaxEntryName      = 20;
    RAS_MaxDeviceName     = 32;
    RAS_MaxCallbackNumber = 48;
{$ENDIF}

    RAS_MaxAreaCode       = 10;
    RAS_MaxPadType        = 32;
    RAS_MaxX25Address     = 200;
    RAS_MaxFacilities     = 200;
    RAS_MaxUserData       = 200;

    RASCS_OpenPort            = 0;
    RASCS_PortOpened          = 1;
    RASCS_ConnectDevice       = 2;
    RASCS_DeviceConnected     = 3;
    RASCS_AllDevicesConnected = 4;
    RASCS_Authenticate        = 5;
    RASCS_AuthNotify          = 6;
    RASCS_AuthRetry           = 7;
    RASCS_AuthCallback        = 8;
    RASCS_AuthChangePassword  = 9;
    RASCS_AuthProject         = 10;
    RASCS_AuthLinkSpeed       = 11;
    RASCS_AuthAck             = 12;
    RASCS_ReAuthenticate      = 13;
    RASCS_Authenticated       = 14;
    RASCS_PrepareForCallback  = 15;
    RASCS_WaitForModemReset   = 16;
    RASCS_WaitForCallback     = 17;
    RASCS_Projected           = 18;

{$IFDEF WINVER400}
    RASCS_StartAuthentication = 19;
    RASCS_CallbackComplete    = 20;
    RASCS_LogonNetwork        = 21;
{$ENDIF}
    RASCS_SubEntryConnected   = 22;
    RASCS_SubEntryDisconnected= 23;

    RASCS_PAUSED              = $1000;
    RASCS_Interactive         = RASCS_PAUSED;
    RASCS_RetryAuthentication = (RASCS_PAUSED + 1);
    RASCS_CallbackSetByCaller = (RASCS_PAUSED + 2);
    RASCS_PasswordExpired     = (RASCS_PAUSED + 3);

    RASCS_DONE                = $2000;
    RASCS_Connected           = RASCS_DONE;
    RASCS_Disconnected        = (RASCS_DONE + 1);

    // If using RasDial message notifications, get the notification message code
    // by passing this string to the RegisterWindowMessageA() API.
    // WM_RASDIALEVENT is used only if a unique message cannot be registered.
    RASDIALEVENT    = 'RasDialEvent';
    WM_RASDIALEVENT = $CCCD;

    // TRASPROJECTION
    RASP_Amb        = $10000;
    RASP_PppNbf     = $0803F;
    RASP_PppIpx     = $0802B;
    RASP_PppIp      = $08021;
    RASP_Slip       = $20000;

type
    THRASCONN     = THandle;
    PHRASCONN     = ^THRASCONN;
    TRASCONNSTATE = DWORD;
    PDWORD        = ^DWORD;
    PBOOL         = ^BOOL;

    TRASDIALPARAMS = packed record
        dwSize           : DWORD;
        szEntryName      : array [0..RAS_MaxEntryName] of Char;
        szPhoneNumber    : array [0..RAS_MaxPhoneNumber] of Char;
        szCallbackNumber : array [0..RAS_MaxCallbackNumber] of Char;
        szUserName       : array [0..UNLEN] of Char;
        szPassword       : array [0..PWLEN] of Char;
        szDomain         : array [0..DNLEN] of Char;
{$IFDEF WINVER401}
        dwSubEntry       : DWORD;
        dwCallbackId     : DWORD;
{$ENDIF}
        szPadding        : array [0..2] of Char;
    end;
    PRASDIALPARAMS = ^TRASDIALPARAMS;

    TRASDIALEXTENSIONS = packed record
        dwSize     : DWORD;
        dwfOptions : DWORD;
        hwndParent : HWND;
        reserved   : DWORD;
    end;
    PRASDIALEXTENSIONS = ^TRASDIALEXTENSIONS;

    TRASCONNSTATUS = packed record
        dwSize       : DWORD;
        RasConnState : TRASCONNSTATE;
        dwError      : DWORD;
        szDeviceType : array [0..RAS_MaxDeviceType] of char;
        szDeviceName : array [0..RAS_MaxDeviceName] of char;
        szPadding    : array [0..1] of Char;
    end;
    PRASCONNSTATUS = ^TRASCONNSTATUS;

    TRASCONN = packed record
        dwSize       : DWORD;
        hRasConn     : THRASCONN;
        szEntryName  : array [0..RAS_MaxEntryName] of char;
{$IFDEF WINVER400}
        szDeviceType : array [0..RAS_MaxDeviceType] of char;
        szDeviceName : array [0..RAS_MaxDeviceName] of char;
{$ENDIF}
        szPadding    : array [0..0] of Char;
    end;
    PRASCONN = ^TRASCONN;

    TRASENTRYNAME = packed record
        dwSize       : DWORD;
        szEntryName  : array [0..RAS_MaxEntryName] of char;
        szPadding    : array [0..2] of Char;
    end;
    PRASENTRYNAME = ^TRASENTRYNAME;

    TRASENTRYDLG = packed record
        dwSize       : DWORD;
        hWndOwner    : HWND;
        dwFlags      : DWORD;
        xDlg         : LongInt;
        yDlg         : LongInt;
        szEntry      : array [0..RAS_MaxEntryName] of char;
        dwError      : DWORD;
        Reserved     : DWORD;
        Reserved2    : DWORD;
        szPadding    : array [0..2] of Char;
    end;
    PRASENTRYDLG = ^TRASENTRYDLG;

    TRASPROJECTION = integer;
    TRASPPPIP = record
        dwSize  : DWORD;
        dwError : DWORD;
        szIpAddress : array [0..RAS_MaxIpAddress] of char;
    end;


function RasDialA(RasDialExtensions: PRASDIALEXTENSIONS;
                  PhoneBook     : PChar;
                  RasDialParams : PRASDIALPARAMS;
                  NotifierType  : DWORD;
                  Notifier      : Pointer;
                  RasConn       : PHRASCONN
                 ): DWORD; stdcall;
function RasGetErrorStringA(
                  uErrorValue   : DWORD; // error to get string for
                  szErrorString : PChar; // buffer to hold error string
                  cBufSize      : DWORD	 // size, in characters, of buffer
                 ): DWORD; stdcall;
function RasHangupA(RasConn: THRASCONN): DWORD; stdcall;
function RasConnectionStateToString(nState : Integer) : String;
function RasGetConnectStatusA(
                  hRasConn: THRASCONN;   // handle to RAS connection of interest
                  lpRasConnStatus : PRASCONNSTATUS // buffer to receive status data
                 ): DWORD; stdcall;
function RasEnumConnectionsA(
                  pRasConn : PRASCONN;	 // buffer to receive connections data
                  pCB      : PDWORD;	 // size in bytes of buffer
                  pcConnections : PDWORD // number of connections written to buffer
                 ) : DWORD; stdcall
function RasEnumEntriesA(
                  Reserved : Pointer;	 // reserved, must be NIL
                  szPhonebook : PChar;	 // full path and filename of phonebook file
                  lpRasEntryName : PRASENTRYNAME; // buffer to receive entries
                  lpcb : PDWORD;	 // size in bytes of buffer
                  lpcEntries : PDWORD	 // number of entries written to buffer
                 ) : DWORD; stdcall;
function RasGetEntryDialParamsA(
                  lpszPhonebook : PChar; // pointer to the full path and filename of the phonebook file
                  lprasdialparams : PRASDIALPARAMS;	// pointer to a structure that receives the connection parameters
                  lpfPassword : PBOOL    // indicates whether the user's password was retrieved
                 ) : DWORD; stdcall;
function RasEditPhonebookEntryA(
                   hWndParent : HWND;     // handle to the parent window of the dialog box
                   lpszPhonebook : PChar; // pointer to the full path and filename of the phonebook file
                   lpszEntryName : PChar  // pointer to the phonebook entry name
                 ) : DWORD; stdcall;
//function RasEntryDlgA(
//                   lpszPhonebook : PChar; // pointer to the full path and filename of the phone-book file
//                   lpszEntry : PChar;     // pointer to the name of the phone-book entry to edit, copy, or create
//                   lpInfo : PRASENTRYDLG  // pointer to a structure that contains additional parameters
//                 ) : DWORD; stdcall;
function RasCreatePhonebookEntryA(
                     hWndParent : HWND;    // handle to the parent window of the dialog box
                     lpszPhonebook : PChar // pointer to the full path and filename of the phonebook file
                   ) : DWORD; stdcall;

function RasGetProjectionInfoA(
                    hRasConn      : THRASCONN;      // handle that specifies remote access connection of interest
                    RasProjection : TRASPROJECTION; // specifies type of projection information to obtain
                    lpProjection  : Pointer;        // points to buffer that receives projection information
                    lpcb          : PDWORD          // points to variable that specifies buffer size
                   ) : DWORD; stdcall;
function RasGetIPAddress:string;

implementation

//获取连接状态
function RasConnectionStateToString(nState:Integer):String;
begin
    case nState of
    RASCS_OpenPort:             Result := 'Opening Port';                 //打开端口
    RASCS_PortOpened:           Result := 'Port Opened';                  //端口已打开
    RASCS_ConnectDevice:        Result := 'Connecting Device';            //连接设备
    RASCS_DeviceConnected:      Result := 'Device Connected';             //设备已连接
    RASCS_AllDevicesConnected:  Result := 'All Devices Connected';        //连接所有设备
    RASCS_Authenticate:         Result := 'Starting Authentication';      //开始验证
    RASCS_AuthNotify:           Result := 'Authentication Notify';        //验证通知
    RASCS_AuthRetry:            Result := 'Authentication Retry';         //验证重试
    RASCS_AuthCallback:         Result := 'Callback Requested';           //请求回叫
    RASCS_AuthChangePassword:   Result := 'Change Password Requested';    //请求修改密码
    RASCS_AuthProject:          Result := 'Projection Phase Started';     //发送帧开始
    RASCS_AuthLinkSpeed:        Result := 'Link Speed Calculation';       //计算连接速度
    RASCS_AuthAck:              Result := 'Authentication Acknowledged';  //验证公匙？
    RASCS_ReAuthenticate:       Result := 'Reauthentication Started';     //开始重新验证
    RASCS_Authenticated:        Result := 'Authenticated';                //验证
    RASCS_PrepareForCallback:   Result := 'Preparation For Callback';     //准备回呼
    RASCS_WaitForModemReset:    Result := 'Waiting For Modem Reset';      //等待Medom复位
    RASCS_WaitForCallback:      Result := 'Waiting For Callback';         //等待回呼
    RASCS_Projected:            Result := 'Projected';                    //发送
{$IFDEF WINVER400}
    RASCS_StartAuthentication:  Result := 'Start Authentication';         //开始验证
    RASCS_CallbackComplete:     Result := 'Callback Complete';            //回呼完成
    RASCS_LogonNetwork:         Result := 'Logon Network';                //登录网络
{$ENDIF}
    RASCS_SubEntryConnected:    Result := '';
    RASCS_SubEntryDisconnected: Result := '';
    RASCS_Interactive:          Result := 'Interactive';                  //交互
    RASCS_RetryAuthentication:  Result := 'Retry Authentication';         //重新验证
    RASCS_CallbackSetByCaller:  Result := 'Callback Set By Caller';       //设置回呼
    RASCS_PasswordExpired:      Result := 'Password Expired';             //密码到期
    RASCS_Connected:            Result := 'Connected';                    //已连接
    RASCS_Disconnected:         Result := 'Disconnected';                 //已断开
    else
        Result := 'Connection state #' + IntToStr(nState);
    end;
end;

//获取IP
function RasGetIPAddress: string;
var
  RASConns:TRasConn;
  dwSize:DWORD;
  dwCount:DWORD;
  RASpppIP:TRASPPPIP;
begin
  Result:='';
  RASConns.dwSize:=SizeOf(TRASConn);
  RASpppIP.dwSize:=SizeOf(RASpppIP);
  dwSize:=SizeOf(RASConns);
  if RASEnumConnectionsA(@RASConns, @dwSize, @dwCount)=0 then
  begin
    if dwCount>0 then
    begin
      dwSize:=SizeOf(RASpppIP);
      RASpppIP.dwSize:=SizeOf(RASpppIP);
      if RASGetProjectionInfoA(RASConns.hRasConn,RASP_PppIp,@RasPPPIP,@dwSize)=0 then
      begin
        Result:=StrPas(RASpppIP.szIPAddress);
      end;
    end;
  end;
end;


//WIN API
function RasDialA; external rasapi32 name 'RasDialA';
function RasGetErrorStringA; external rasapi32 name 'RasGetErrorStringA';
function RasHangUpA; external rasapi32 name 'RasHangUpA';
function RasGetConnectStatusA; external rasapi32 name 'RasGetConnectStatusA';
function RasEnumConnectionsA; external rasapi32 name 'RasEnumConnectionsA';
function RasEnumEntriesA; external rasapi32 name 'RasEnumEntriesA';
function RasGetEntryDialParamsA; external rasapi32 name 'RasGetEntryDialParamsA';
function RasEditPhonebookEntryA; external rasapi32 name 'RasEditPhonebookEntryA';
//function RasEntryDlgA; external rasapi32 name 'RasEntryDlgA';
function RasCreatePhonebookEntryA; external rasapi32 name 'RasCreatePhonebookEntryA';
function RasGetProjectionInfoA; external rasapi32 name 'RasGetProjectionInfoA';

end.

