//------------------------------------------------------------------------------
// File Name        : cfgmgr32.pas
// Class Name       :
// SuperClass Name  :
// Author           : T.K
// E-Mail           :
// Homepage         :
// Copyright (c) 2003 by
//------------------------------------------------------------------------------
// Development environment
//   OS   : WindowsXP
//   Lang : Delphi6.0
//   DDK  : WindowsXP DDK Version 2600.1106
//   Original File : cfgmgr32.h
//
// Abstract
//   cfgmgr32.hをDelphi用のインターフェイスユニットに書き換えたものです。
//   注意：自分の必要な部分だけしかコンバートしていません。
//   　　　（USBストレージの取り外しに使ったものだけかな）
//   あとは、おいおいというか、だれかやってくれないかな～。
//
// Supplement
//   Windwos2000,WindowsXPからはSetupapi.dllに含まれているのでこのネーミングは
//   少し悩みますが、やっぱりこっちの方がしっくりくるのでこっちにしておきます。
//   まぁcfgmgr32.hって名前だし。
//   このファイルの書き方はProject JEDI(http://delphi-jedi.org)のsetupapi.pasの
//   作りを真似て書いてみました。
//   _PNP_VETO_TYPE構造体の宣言方法などはネットをいろいろ見ていたときのものを
//   そのまま使わせてもらいました。
//   この書き方だと＠99見たいな記述がいらないのでいいですね。
//   注意、setupapi.pasと一緒についていたModuleLoader.pasをこのファイルから
//   使っています。
//
// おきまり
//   自己責任で使用してください。
//------------------------------------------------------------------------------
// Revision History
// 2003.11.11 :
//------------------------------------------------------------------------------
unit CfgMgr32;

interface
{$WEAKPACKAGEUNIT ON}

{$DEFINE CFGMGR32_LINKONREQUEST}

uses
  Windows, Commctrl, Cfg, SysUtils;

type
  DEVINST     = DWORD;
  TDevInst    = DEVINST;

  RETURN_TYPE = DWORD;
  CONFIGRET   = RETURN_TYPE;
  TConfigRet  = CONFIGRET;

type
  THMACHINE  = THANDLE;
  PTHMACHINE = ^THMACHINE;

const

//--------------------------------------------------------------
// Configuration Manager return status codes
//--------------------------------------------------------------
  CR_SUCCESS                           = $00000000;
  {EXTERNALSYM CR_SUCCESS}
  CR_DEFAULT                           = $00000001;
  {EXTERNALSYM CR_DEFAULT}
  CR_OUT_OF_MEMORY                     = $00000002;
  {EXTERNALSYM CR_OUT_OF_MEMORY}
  CR_INVALID_POINTER                   = $00000003;
  {EXTERNALSYM CR_INVALID_POINTER}
  CR_INVALID_FLAG                      = $00000004;
  {EXTERNALSYM CR_INVALID_FLAG}
  CR_INVALID_DEVNODE                   = $00000005;
  {EXTERNALSYM CR_INVALID_DEVNODE}
  CR_INVALID_DEVINST                   = CR_INVALID_DEVNODE;
  {EXTERNALSYM CR_INVALID_DEVINST}
  CR_INVALID_RES_DES                   = $00000006;
  {EXTERNALSYM CR_INVALID_RES_DES}
  CR_INVALID_LOG_CONF                  = $00000007;
  {EXTERNALSYM CR_INVALID_LOG_CONF}
  CR_INVALID_ARBITRATOR                = $00000008;
  {EXTERNALSYM CR_INVALID_ARBITRATOR}
  CR_INVALID_NODELIST                  = $00000009;
  {EXTERNALSYM CR_INVALID_NODELIST}
  CR_DEVNODE_HAS_REQS                  = $0000000A;
  {EXTERNALSYM CR_DEVNODE_HAS_REQS}
  CR_DEVINST_HAS_REQS                  = CR_DEVNODE_HAS_REQS;
  {EXTERNALSYM CR_DEVINST_HAS_REQS}
  CR_INVALID_RESOURCEID                = $0000000B;
  {EXTERNALSYM CR_INVALID_RESOURCEID}
  CR_DLVXD_NOT_FOUND                   = $0000000C;   // WIN 95 ONLY
  {EXTERNALSYM CR_DLVXD_NOT_FOUND}
  CR_NO_SUCH_DEVNODE                   = $0000000D;
  {EXTERNALSYM CR_NO_SUCH_DEVNODE}
  CR_NO_SUCH_DEVINST                   = CR_NO_SUCH_DEVNODE;
  {EXTERNALSYM CR_NO_SUCH_DEVINST}
  CR_NO_MORE_LOG_CONF                  = $0000000E;
  {EXTERNALSYM CR_NO_MORE_LOG_CONF}
  CR_NO_MORE_RES_DES                   = $0000000F;
  {EXTERNALSYM CR_NO_MORE_RES_DES}
  CR_ALREADY_SUCH_DEVNODE              = $00000010;
  {EXTERNALSYM CR_ALREADY_SUCH_DEVNODE}
  CR_ALREADY_SUCH_DEVINST              = CR_ALREADY_SUCH_DEVNODE;
  {EXTERNALSYM CR_ALREADY_SUCH_DEVINST}
  CR_INVALID_RANGE_LIST                = $00000011;
  {EXTERNALSYM CR_INVALID_RANGE_LIST}
  CR_INVALID_RANGE                     = $00000012;
  {EXTERNALSYM CR_INVALID_RANGE}
  CR_FAILURE                           = $00000013;
  {EXTERNALSYM CR_FAILURE}
  CR_NO_SUCH_LOGICAL_DEV               = $00000014;
  {EXTERNALSYM CR_NO_SUCH_LOGICAL_DEV}
  CR_CREATE_BLOCKED                    = $00000015;
  {EXTERNALSYM CR_CREATE_BLOCKED}
  CR_NOT_SYSTEM_VM                     = $00000016;   // WIN 95 ONLY
  {EXTERNALSYM CR_NOT_SYSTEM_VM}
  CR_REMOVE_VETOED                     = $00000017;
  {EXTERNALSYM CR_REMOVE_VETOED}
  CR_APM_VETOED                        = $00000018;
  {EXTERNALSYM CR_APM_VETOED}
  CR_INVALID_LOAD_TYPE                 = $00000019;
  {EXTERNALSYM CR_INVALID_LOAD_TYPE}
  CR_BUFFER_SMALL                      = $0000001A;
  {EXTERNALSYM CR_BUFFER_SMALL}
  CR_NO_ARBITRATOR                     = $0000001B;
  {EXTERNALSYM CR_NO_ARBITRATOR}
  CR_NO_REGISTRY_HANDLE                = $0000001C;
  {EXTERNALSYM CR_NO_REGISTRY_HANDLE}
  CR_REGISTRY_ERROR                    = $0000001D;
  {EXTERNALSYM CR_REGISTRY_ERROR}
  CR_INVALID_DEVICE_ID                 = $0000001E;
  {EXTERNALSYM CR_INVALID_DEVICE_ID}
  CR_INVALID_DATA                      = $0000001F;
  {EXTERNALSYM CR_INVALID_DATA}
  CR_INVALID_API                       = $00000020;
  {EXTERNALSYM CR_INVALID_API}
  CR_DEVLOADER_NOT_READY               = $00000021;
  {EXTERNALSYM CR_DEVLOADER_NOT_READY}
  CR_NEED_RESTART                      = $00000022;
  {EXTERNALSYM CR_NEED_RESTART}
  CR_NO_MORE_HW_PROFILES               = $00000023;
  {EXTERNALSYM CR_NO_MORE_HW_PROFILES}
  CR_DEVICE_NOT_THERE                  = $00000024;
  {EXTERNALSYM CR_DEVICE_NOT_THERE}
  CR_NO_SUCH_VALUE                     = $00000025;
  {EXTERNALSYM CR_NO_SUCH_VALUE}
  CR_WRONG_TYPE                        = $00000026;
  {EXTERNALSYM CR_WRONG_TYPE}
  CR_INVALID_PRIORITY                  = $00000027;
  {EXTERNALSYM CR_INVALID_PRIORITY}
  CR_NOT_DISABLEABLE                   = $00000028;
  {EXTERNALSYM CR_NOT_DISABLEABLE}
  CR_FREE_RESOURCES                    = $00000029;
  {EXTERNALSYM CR_FREE_RESOURCES}
  CR_QUERY_VETOED                      = $0000002A;
  {EXTERNALSYM CR_QUERY_VETOED}
  CR_CANT_SHARE_IRQ                    = $0000002B;
  {EXTERNALSYM CR_CANT_SHARE_IRQ}
  CR_NO_DEPENDENT                      = $0000002C;
  {EXTERNALSYM CR_NO_DEPENDENT}
  CR_SAME_RESOURCES                    = $0000002D;
  {EXTERNALSYM CR_SAME_RESOURCES}
  CR_NO_SUCH_REGISTRY_KEY              = $0000002E;
  {EXTERNALSYM CR_NO_SUCH_REGISTRY_KEY}
  CR_INVALID_MACHINENAME               = $0000002F;   // NT ONLY
  {EXTERNALSYM CR_INVALID_MACHINENAME}
  CR_REMOTE_COMM_FAILURE               = $00000030;   // NT ONLY
  {EXTERNALSYM CR_REMOTE_COMM_FAILURE}
  CR_MACHINE_UNAVAILABLE               = $00000031;   // NT ONLY
  {EXTERNALSYM CR_MACHINE_UNAVAILABLE}
  CR_NO_CM_SERVICES                    = $00000032;   // NT ONLY
  {EXTERNALSYM CR_NO_CM_SERVICES}
  CR_ACCESS_DENIED                     = $00000033;   // NT ONLY
  {EXTERNALSYM CR_ACCESS_DENIED}
  CR_CALL_NOT_IMPLEMENTED              = $00000034;
  {EXTERNALSYM CR_CALL_NOT_IMPLEMENTED}
  CR_INVALID_PROPERTY                  = $00000035;
  {EXTERNALSYM CR_INVALID_PROPERTY}
  CR_DEVICE_INTERFACE_ACTIVE           = $00000036;
  {EXTERNALSYM CR_DEVICE_INTERFACE_ACTIVE}
  CR_NO_SUCH_DEVICE_INTERFACE          = $00000037;
  {EXTERNALSYM CR_NO_SUCH_DEVICE_INTERFACE}
  CR_INVALID_REFERENCE_STRING          = $00000038;
  {EXTERNALSYM CR_INVALID_REFERENCE_STRING}
  CR_INVALID_CONFLICT_LIST             = $00000039;
  {EXTERNALSYM CR_INVALID_CONFLICT_LIST}
  CR_INVALID_INDEX                     = $0000003A;
  {EXTERNALSYM CR_INVALID_INDEX}
  CR_INVALID_STRUCTURE_SIZE            = $0000003B;
  {EXTERNALSYM CR_INVALID_STRUCTURE_SIZE}
  NUM_CR_RESULTS                       = $0000003C;
  {EXTERNALSYM NUM_CR_RESULTS}

{$IFNDEF CFGMGR32_LINKONREQUEST}
//------------------------------------------------------------------------------
// CM_Get_DevNode_Status
//
function CM_Get_DevNode_Status(
    pulStatus        : PULONG;
    pulProblemNumber : PULONG;
    dnDevInst: TDevInst;
    ulFlags: ULONG): TConfigRet; stdcall;
{$EXTERNALSYM CM_Get_DevNode_Status}


//------------------------------------------------------------------------------
// CM_Request_Device_Eject
//
function CM_Request_Device_EjectA(
  dnDevInst: TDevInst;
  out pVetoType: TPnpVetoType;
  pszVetoName: PAnsiChar;
  ulNameLength: ULONG;
  ulFlags: ULONG): TConfigRet; stdcall;
{$EXTERNALSYM CM_Request_Device_EjectA}

function CM_Request_Device_EjectW(
  dnDevInst: TDevInst;
  out pVetoType: TPnpVetoType;
  pszVetoName: PWideChar;
  ulNameLength: ULONG;
  ulFlags: ULONG): TConfigRet; stdcall;
{$EXTERNALSYM CM_Request_Device_EjectW}

function CM_Request_Device_Eject(
  dnDevInst: TDevInst;
  out pVetoType: TPnpVetoType;
  pszVetoName: PChar;
  ulNameLength: ULONG;
  ulFlags: ULONG): TConfigRet; stdcall;
{$EXTERNALSYM CM_Request_Device_Eject}


//------------------------------------------------------------------------------
// CM_Request_Device_Eject_ExA
//
function CM_Request_Device_Eject_ExA(
  dnDevInst: TDevInst;
  out pVetoType: TPnpVetoType;
  pszVetoName: PAnsiChar;
  ulNameLength: ULONG;
  ulFlags: ULONG;
  dnMachine : THMACHINE
  ): TConfigRet; stdcall;
{$EXTERNALSYM CM_Request_Device_Eject_ExA}

function CM_Request_Device_Eject_ExW(
  dnDevInst: TDevInst;
  out pVetoType: TPnpVetoType;
  pszVetoName: PWideChar;
  ulNameLength: ULONG;
  ulFlags: ULONG;
  dnMachine : THMACHINE
  ): TConfigRet; stdcall;
{$EXTERNALSYM CM_Request_Device_Eject_ExW}

function CM_Request_Device_Eject_Ex(
  dnDevInst: TDevInst;
  out pVetoType: TPnpVetoType;
  pszVetoName: PChar;
  ulNameLength: ULONG;
  ulFlags: ULONG;
  dnMachine : THMACHINE
  ): TConfigRet; stdcall;
{$EXTERNALSYM CM_Request_Device_Eject}

{$ELSE}

type
  TCM_Get_DevNode_Status = function(
    pulStatus        : PULONG;
    pulProblemNumber : PULONG;
    dnDevInst: TDevInst;
    ulFlags: ULONG): TConfigRet; stdcall;

  TCM_Request_Device_EjectA = function(
    dnDevInst: TDevInst;
    out pVetoType: TPnpVetoType;
    pszVetoName: PAnsiChar;
    ulNameLength: ULONG;
    ulFlags: ULONG): TConfigRet; stdcall;

  TCM_Request_Device_EjectW = function(
    dnDevInst: TDevInst;
    out pVetoType: TPnpVetoType;
    pszVetoName: PWideChar;
    ulNameLength: ULONG;
    ulFlags: ULONG): TConfigRet; stdcall;

  TCM_Request_Device_Eject = TCM_Request_Device_EjectA;

  TCM_Request_Device_Eject_ExA = function(
    dnDevInst: TDevInst;
    out pVetoType: TPnpVetoType;
    pszVetoName: PAnsiChar;
    ulNameLength: ULONG;
    ulFlags: ULONG;
    dnMachine : THMACHINE
    ): TConfigRet; stdcall;

  TCM_Request_Device_Eject_ExW = function(
    dnDevInst: TDevInst;
    out pVetoType: TPnpVetoType;
    pszVetoName: PWideChar;
    ulNameLength: ULONG;
    ulFlags: ULONG;
    dnMachine : THMACHINE
    ): TConfigRet; stdcall;

  TCM_Request_Device_Eject_Ex = TCM_Request_Device_Eject_ExA;

var
  CM_Get_DevNode_Status      : TCM_Get_DevNode_Status;
  CM_Request_Device_EjectA   : TCM_Request_Device_EjectA;
  CM_Request_Device_EjectW   : TCM_Request_Device_EjectW;
  CM_Request_Device_Eject    : TCM_Request_Device_Eject;
  CM_Request_Device_Eject_ExA: TCM_Request_Device_Eject_ExA;
  CM_Request_Device_Eject_ExW: TCM_Request_Device_Eject_ExW;
  CM_Request_Device_Eject_Ex : TCM_Request_Device_Eject_Ex;
  
{$ENDIF}

function  IsCfgMgr32Loaded: Boolean;
function  LoadCfgMgr32: Boolean;
procedure UnloadCfgMgr32;

implementation

uses
  ModuleLoader;

const
  CfgMgr32ModuleName = 'setupapi.dll';
  CfgMgr32ModuleName98 = 'CfgMgr32.dll';

{$IFDEF CFGMGR32_LINKONREQUEST}
var
  CfgMgr32Lib: TModuleHandle = INVALID_MODULEHANDLE_VALUE;
{$ENDIF}

function IsCfgMgr32Loaded: Boolean;
begin
  {$IFDEF CFGMGR32_LINKONREQUEST}
  Result := CfgMgr32Lib <> INVALID_MODULEHANDLE_VALUE;
  {$ELSE}
  Result := True;
  {$ENDIF}
end;

function LoadCfgMgr32: Boolean;
begin
  {$IFDEF CFGMGR32_LINKONREQUEST}
  if Win32MajorVersion>=5
     then Result := LoadModule(CfgMgr32Lib, CfgMgr32ModuleName)
     else Result := LoadModule(CfgMgr32Lib, CfgMgr32ModuleName98);
  if Result then
  begin
    @CM_Get_DevNode_Status  := GetModuleSymbolEx(CfgMgr32Lib, 'CM_Get_DevNode_Status', Result);

    if Win32MajorVersion>=5 then
    begin
      @CM_Request_Device_EjectA := GetModuleSymbolEx(CfgMgr32Lib, 'CM_Request_Device_EjectA', Result);
      @CM_Request_Device_EjectW := GetModuleSymbolEx(CfgMgr32Lib, 'CM_Request_Device_EjectW', Result);
      @CM_Request_Device_Eject  := GetModuleSymbolEx(CfgMgr32Lib, 'CM_Request_Device_EjectA', Result);

      @CM_Request_Device_Eject_ExA := GetModuleSymbolEx(CfgMgr32Lib, 'CM_Request_Device_Eject_ExA', Result);
      @CM_Request_Device_Eject_ExW := GetModuleSymbolEx(CfgMgr32Lib, 'CM_Request_Device_Eject_ExW', Result);
      @CM_Request_Device_Eject_Ex  := GetModuleSymbolEx(CfgMgr32Lib, 'CM_Request_Device_Eject_ExA', Result);
    end;  
    if not Result then
      UnloadCfgMgr32;
  end;
  {$ELSE}
  Result := True;
  {$ENDIF}
end;

procedure UnloadCfgMgr32;
begin
  {$IFDEF CFGMGR32_LINKONREQUEST}
  UnloadModule(CfgMgr32Lib);
  CM_Get_DevNode_Status  := nil;

  CM_Request_Device_EjectA := nil;
  CM_Request_Device_EjectW := nil;
  CM_Request_Device_Eject  := nil;

  CM_Request_Device_Eject_ExA := nil;
  CM_Request_Device_Eject_ExW := nil;
  CM_Request_Device_Eject_Ex  := nil;
  {$ENDIF}
end;

{$IFNDEF CFGMGR32_LINKONREQUEST}

function CM_Get_DevNode_Status;  external CfgMgr32ModuleName name 'CM_Get_DevNode_Status';

function CM_Request_Device_EjectA; external CfgMgr32ModuleName name 'CM_Request_Device_EjectA';
function CM_Request_Device_EjectW; external CfgMgr32ModuleName name 'CM_Request_Device_EjectW';
function CM_Request_Device_Eject;  external CfgMgr32ModuleName name 'CM_Request_Device_EjectA';

function CM_Request_Device_Eject_ExA; external CfgMgr32ModuleName name 'CM_Request_Device_Eject_ExA';
function CM_Request_Device_Eject_ExW; external CfgMgr32ModuleName name 'CM_Request_Device_Eject_ExW';
function CM_Request_Device_Eject_Ex;  external CfgMgr32ModuleName name 'CM_Request_Device_Eject_ExA';

{$ENDIF}

end.

