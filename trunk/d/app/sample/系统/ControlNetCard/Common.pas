unit Common;
//download by http://www.codefans.net
interface

uses
  Windows;

type
  HDEVINFO    = Pointer;
  ULONG_PTR   = DWORD;
  DEVINST     = DWORD;
  DI_FUNCTION = UINT;

  _SP_DEVINFO_DATA = packed record
    cbSize: DWORD;
    ClassGuid: TGUID;
    DevInst: DWORD;
    Reserved: ULONG_PTR;
  end;

  SP_DEVINFO_DATA = _SP_DEVINFO_DATA;
  PSP_DEVINFO_DATA = ^_SP_DEVINFO_DATA;

  _SP_CLASSINSTALL_HEADER = packed record
    cbSize: DWORD;
    InstallFunction: DI_FUNCTION;
  end;
  SP_CLASSINSTALL_HEADER = _SP_CLASSINSTALL_HEADER;
  PSP_CLASSINSTALL_HEADER = ^_SP_CLASSINSTALL_HEADER;

  _SP_PROPCHANGE_PARAMS = packed record
    ClassInstallHeader: SP_CLASSINSTALL_HEADER;
    StateChange: DWORD;
    Scope: DWORD;
    HwProfile: DWORD;
  end;
  SP_PROPCHANGE_PARAMS  = _SP_PROPCHANGE_PARAMS;
  PSP_PROPCHANGE_PARAMS = ^SP_PROPCHANGE_PARAMS;


//
// Flags controlling what is included in the device information set built
// by SetupDiGetClassDevs
//
const
  DIGCF_DEFAULT         = $00000001; // only valid with DIGCF_DEVICEINTERFACE
  {$EXTERNALSYM DIGCF_DEFAULT}
  DIGCF_PRESENT         = $00000002;
  {$EXTERNALSYM DIGCF_PRESENT}
  DIGCF_ALLCLASSES      = $00000004;
  {$EXTERNALSYM DIGCF_ALLCLASSES}
  DIGCF_PROFILE         = $00000008;
  {$EXTERNALSYM DIGCF_PROFILE}
  DIGCF_DEVICEINTERFACE = $00000010;
  {$EXTERNALSYM DIGCF_DEVICEINTERFACE}

  function SetupDiGetClassDevs(const ClassGuid: PGUID; Enumerator: PAnsiChar;
      hwndParent: THandle; Flags: DWORD): HDEVINFO;
      stdcall external 'setupapi.dll' name 'SetupDiGetClassDevsA';

  function SetupDiDestroyDeviceInfoList(DeviceInfoSet: HDEVINFO): BOOL;
      stdcall external 'setupapi.dll' name 'SetupDiDestroyDeviceInfoList';

  function SetupDiEnumDeviceInfo(DeviceInfoSet: HDEVINFO; MemberIndex: DWORD;
      DeviceInfoData: PSP_DEVINFO_DATA): BOOL;
      stdcall external 'setupapi.dll' name 'SetupDiEnumDeviceInfo';

  function SetupDiOpenClassRegKey(const ClassGuid: PGUID;
      samDesired: REGSAM): HKEY;
      stdcall external 'setupapi.dll' name 'SetupDiOpenClassRegKey';

//
// Device registry property codes
// (Codes marked as read-only (R) may only be used for
// SetupDiGetDeviceRegistryProperty)
//
// These values should cover the same set of registry properties
// as defined by the CM_DRP codes in cfgmgr32.h.
//
const
  SPDRP_DEVICEDESC                  = $00000000; // DeviceDesc (R/W)
  {$EXTERNALSYM SPDRP_DEVICEDESC}
  SPDRP_HARDWAREID                  = $00000001; // HardwareID (R/W)
  {$EXTERNALSYM SPDRP_HARDWAREID}
  SPDRP_COMPATIBLEIDS               = $00000002; // CompatibleIDs (R/W)
  {$EXTERNALSYM SPDRP_COMPATIBLEIDS}
  SPDRP_UNUSED0                     = $00000003; // unused
  {$EXTERNALSYM SPDRP_UNUSED0}
  SPDRP_SERVICE                     = $00000004; // Service (R/W)
  {$EXTERNALSYM SPDRP_SERVICE}
  SPDRP_UNUSED1                     = $00000005; // unused
  {$EXTERNALSYM SPDRP_UNUSED1}
  SPDRP_UNUSED2                     = $00000006; // unused
  {$EXTERNALSYM SPDRP_UNUSED2}
  SPDRP_CLASS                       = $00000007; // Class (R--tied to ClassGUID)
  {$EXTERNALSYM SPDRP_CLASS}
  SPDRP_CLASSGUID                   = $00000008; // ClassGUID (R/W)
  {$EXTERNALSYM SPDRP_CLASSGUID}
  SPDRP_DRIVER                      = $00000009; // Driver (R/W)
  {$EXTERNALSYM SPDRP_DRIVER}
  SPDRP_CONFIGFLAGS                 = $0000000A; // ConfigFlags (R/W)
  {$EXTERNALSYM SPDRP_CONFIGFLAGS}
  SPDRP_MFG                         = $0000000B; // Mfg (R/W)
  {$EXTERNALSYM SPDRP_MFG}
  SPDRP_FRIENDLYNAME                = $0000000C; // FriendlyName (R/W)
  {$EXTERNALSYM SPDRP_FRIENDLYNAME}
  SPDRP_LOCATION_INFORMATION        = $0000000D; // LocationInformation (R/W)
  {$EXTERNALSYM SPDRP_LOCATION_INFORMATION}
  SPDRP_PHYSICAL_DEVICE_OBJECT_NAME = $0000000E; // PhysicalDeviceObjectName (R)
  {$EXTERNALSYM SPDRP_PHYSICAL_DEVICE_OBJECT_NAME}
  SPDRP_CAPABILITIES                = $0000000F; // Capabilities (R)
  {$EXTERNALSYM SPDRP_CAPABILITIES}
  SPDRP_UI_NUMBER                   = $00000010; // UiNumber (R)
  {$EXTERNALSYM SPDRP_UI_NUMBER}
  SPDRP_UPPERFILTERS                = $00000011; // UpperFilters (R/W)
  {$EXTERNALSYM SPDRP_UPPERFILTERS}
  SPDRP_LOWERFILTERS                = $00000012; // LowerFilters (R/W)
  {$EXTERNALSYM SPDRP_LOWERFILTERS}
  SPDRP_BUSTYPEGUID                 = $00000013; // BusTypeGUID (R)
  {$EXTERNALSYM SPDRP_BUSTYPEGUID}
  SPDRP_LEGACYBUSTYPE               = $00000014; // LegacyBusType (R)
  {$EXTERNALSYM SPDRP_LEGACYBUSTYPE}
  SPDRP_BUSNUMBER                   = $00000015; // BusNumber (R)
  {$EXTERNALSYM SPDRP_BUSNUMBER}
  SPDRP_ENUMERATOR_NAME             = $00000016; // Enumerator Name (R)
  {$EXTERNALSYM SPDRP_ENUMERATOR_NAME}
  SPDRP_SECURITY                    = $00000017; // Security (R/W, binary form)
  {$EXTERNALSYM SPDRP_SECURITY}
  SPDRP_SECURITY_SDS                = $00000018; // Security (W, SDS form)
  {$EXTERNALSYM SPDRP_SECURITY_SDS}
  SPDRP_DEVTYPE                     = $00000019; // Device Type (R/W)
  {$EXTERNALSYM SPDRP_DEVTYPE}
  SPDRP_EXCLUSIVE                   = $0000001A; // Device is exclusive-access (R/W)
  {$EXTERNALSYM SPDRP_EXCLUSIVE}
  SPDRP_CHARACTERISTICS             = $0000001B; // Device Characteristics (R/W)
  {$EXTERNALSYM SPDRP_CHARACTERISTICS}
  SPDRP_ADDRESS                     = $0000001C; // Device Address (R)
  {$EXTERNALSYM SPDRP_ADDRESS}
  SPDRP_UI_NUMBER_DESC_FORMAT       = $0000001E; // UiNumberDescFormat (R/W)
  {$EXTERNALSYM SPDRP_UI_NUMBER_DESC_FORMAT}
  SPDRP_MAXIMUM_PROPERTY            = $0000001F; // Upper bound on ordinals
  {$EXTERNALSYM SPDRP_MAXIMUM_PROPERTY}

  function SetupDiGetDeviceRegistryProperty(DeviceInfoSet: HDEVINFO;
      DeviceInfoData: PSP_DEVINFO_DATA; AProperty: DWORD;
      PropertyRegDataType: PDWORD; PropertyBuffer: PAnsiChar;
      PropertyBufferSize: DWORD; RequiredSize: PDWORD): BOOL;
      stdcall external 'setupapi.dll' name 'SetupDiGetDeviceRegistryPropertyA';


//
// Class installer function codes
//
const
  DIF_SELECTDEVICE                  = $00000001;
  {$EXTERNALSYM DIF_SELECTDEVICE}
  DIF_INSTALLDEVICE                 = $00000002;
  {$EXTERNALSYM DIF_INSTALLDEVICE}
  DIF_ASSIGNRESOURCES               = $00000003;
  {$EXTERNALSYM DIF_ASSIGNRESOURCES}
  DIF_PROPERTIES                    = $00000004;
  {$EXTERNALSYM DIF_PROPERTIES}
  DIF_REMOVE                        = $00000005;
  {$EXTERNALSYM DIF_REMOVE}
  DIF_FIRSTTIMESETUP                = $00000006;
  {$EXTERNALSYM DIF_FIRSTTIMESETUP}
  DIF_FOUNDDEVICE                   = $00000007;
  {$EXTERNALSYM DIF_FOUNDDEVICE}
  DIF_SELECTCLASSDRIVERS            = $00000008;
  {$EXTERNALSYM DIF_SELECTCLASSDRIVERS}
  DIF_VALIDATECLASSDRIVERS          = $00000009;
  {$EXTERNALSYM DIF_VALIDATECLASSDRIVERS}
  DIF_INSTALLCLASSDRIVERS           = $0000000A;
  {$EXTERNALSYM DIF_INSTALLCLASSDRIVERS}
  DIF_CALCDISKSPACE                 = $0000000B;
  {$EXTERNALSYM DIF_CALCDISKSPACE}
  DIF_DESTROYPRIVATEDATA            = $0000000C;
  {$EXTERNALSYM DIF_DESTROYPRIVATEDATA}
  DIF_VALIDATEDRIVER                = $0000000D;
  {$EXTERNALSYM DIF_VALIDATEDRIVER}
  DIF_MOVEDEVICE                    = $0000000E;
  {$EXTERNALSYM DIF_MOVEDEVICE}
  DIF_DETECT                        = $0000000F;
  {$EXTERNALSYM DIF_DETECT}
  DIF_INSTALLWIZARD                 = $00000010;
  {$EXTERNALSYM DIF_INSTALLWIZARD}
  DIF_DESTROYWIZARDDATA             = $00000011;
  {$EXTERNALSYM DIF_DESTROYWIZARDDATA}
  DIF_PROPERTYCHANGE                = $00000012;
  {$EXTERNALSYM DIF_PROPERTYCHANGE}
  DIF_ENABLECLASS                   = $00000013;
  {$EXTERNALSYM DIF_ENABLECLASS}
  DIF_DETECTVERIFY                  = $00000014;
  {$EXTERNALSYM DIF_DETECTVERIFY}
  DIF_INSTALLDEVICEFILES            = $00000015;
  {$EXTERNALSYM DIF_INSTALLDEVICEFILES}
  DIF_UNREMOVE                      = $00000016;
  {$EXTERNALSYM DIF_UNREMOVE}
  DIF_SELECTBESTCOMPATDRV           = $00000017;
  {$EXTERNALSYM DIF_SELECTBESTCOMPATDRV}
  DIF_ALLOW_INSTALL                 = $00000018;
  {$EXTERNALSYM DIF_ALLOW_INSTALL}
  DIF_REGISTERDEVICE                = $00000019;
  {$EXTERNALSYM DIF_REGISTERDEVICE}
  DIF_NEWDEVICEWIZARD_PRESELECT     = $0000001A;
  {$EXTERNALSYM DIF_NEWDEVICEWIZARD_PRESELECT}
  DIF_NEWDEVICEWIZARD_SELECT        = $0000001B;
  {$EXTERNALSYM DIF_NEWDEVICEWIZARD_SELECT}
  DIF_NEWDEVICEWIZARD_PREANALYZE    = $0000001C;
  {$EXTERNALSYM DIF_NEWDEVICEWIZARD_PREANALYZE}
  DIF_NEWDEVICEWIZARD_POSTANALYZE   = $0000001D;
  {$EXTERNALSYM DIF_NEWDEVICEWIZARD_POSTANALYZE}
  DIF_NEWDEVICEWIZARD_FINISHINSTALL = $0000001E;
  {$EXTERNALSYM DIF_NEWDEVICEWIZARD_FINISHINSTALL}
  DIF_UNUSED1                       = $0000001F;
  {$EXTERNALSYM DIF_UNUSED1}
  DIF_INSTALLINTERFACES             = $00000020;
  {$EXTERNALSYM DIF_INSTALLINTERFACES}
  DIF_DETECTCANCEL                  = $00000021;
  {$EXTERNALSYM DIF_DETECTCANCEL}
  DIF_REGISTER_COINSTALLERS         = $00000022;
  {$EXTERNALSYM DIF_REGISTER_COINSTALLERS}
  DIF_ADDPROPERTYPAGE_ADVANCED      = $00000023;
  {$EXTERNALSYM DIF_ADDPROPERTYPAGE_ADVANCED}
  DIF_ADDPROPERTYPAGE_BASIC         = $00000024;
  {$EXTERNALSYM DIF_ADDPROPERTYPAGE_BASIC}
  DIF_RESERVED1                     = $00000025;
  {$EXTERNALSYM DIF_RESERVED1}
  DIF_TROUBLESHOOTER                = $00000026;
  {$EXTERNALSYM DIF_TROUBLESHOOTER}
  DIF_POWERMESSAGEWAKE              = $00000027;
  {$EXTERNALSYM DIF_POWERMESSAGEWAKE}

//
// Values indicating a change in a device's state
//
const
  DICS_ENABLE     = $00000001;
  {$EXTERNALSYM DICS_ENABLE}
  DICS_DISABLE    = $00000002;
  {$EXTERNALSYM DICS_DISABLE}
  DICS_PROPCHANGE = $00000003;
  {$EXTERNALSYM DICS_PROPCHANGE}
  DICS_START      = $00000004;
  {$EXTERNALSYM DICS_START}
  DICS_STOP       = $00000005;
  {$EXTERNALSYM DICS_STOP}

//
// Values specifying the scope of a device property change
//
  DICS_FLAG_GLOBAL         = $00000001;  // make change in all hardware profiles
  {$EXTERNALSYM DICS_FLAG_GLOBAL}
  DICS_FLAG_CONFIGSPECIFIC = $00000002;  // make change in specified profile only
  {$EXTERNALSYM DICS_FLAG_CONFIGSPECIFIC}
  DICS_FLAG_CONFIGGENERAL  = $00000004;  // 1 or more hardware profile-specific
  {$EXTERNALSYM DICS_FLAG_CONFIGGENERAL} // changes to follow.

  function SetupDiCallClassInstaller(InstallFunction: DI_FUNCTION;
      DeviceInfoSet: HDEVINFO; DeviceInfoData: PSP_DEVINFO_DATA): BOOL;
      stdcall external 'setupapi.dll' name 'SetupDiCallClassInstaller';

  function SetupDiSetClassInstallParams(DeviceInfoSet: HDEVINFO;
      DeviceInfoData: PSP_DEVINFO_DATA; ClassInstallParams: PSP_CLASSINSTALL_HEADER;
      ClassInstallParamsSize: DWORD): BOOL;
      stdcall external 'setupapi.dll' name 'SetupDiSetClassInstallParamsA';

  function SetupDiClassNameFromGuid(const ClassGuid: PGUID; ClassName: PAnsiChar;
      ClassNameSize: DWORD; RequiredSize: PDWORD): LongBool;
      stdcall external 'setupapi.dll' name 'SetupDiClassNameFromGuidA';

const
  CR_SUCCESS                  = $00000000;
  CR_DEFAULT                  = $00000001;
  CR_OUT_OF_MEMORY            = $00000002;
  CR_INVALID_POINTER          = $00000003;
  CR_INVALID_FLAG             = $00000004;
  CR_INVALID_DEVNODE          = $00000005;
  CR_INVALID_DEVINST          = CR_INVALID_DEVNODE;
  CR_INVALID_RES_DES          = $00000006;
  CR_INVALID_LOG_CONF         = $00000007;
  CR_INVALID_ARBITRATOR       = $00000008;
  CR_INVALID_NODELIST         = $00000009;
  CR_DEVNODE_HAS_REQS         = $0000000A;
  CR_DEVINST_HAS_REQS         = CR_DEVNODE_HAS_REQS;
  CR_INVALID_RESOURCEID       = $0000000B;
  CR_DLVXD_NOT_FOUND          = $0000000C;   // WIN 95 ONLY
  CR_NO_SUCH_DEVNODE          = $0000000D;
  CR_NO_SUCH_DEVINST          = CR_NO_SUCH_DEVNODE;
  CR_NO_MORE_LOG_CONF         = $0000000E;
  CR_NO_MORE_RES_DES          = $0000000F;
  CR_ALREADY_SUCH_DEVNODE     = $00000010;
  CR_ALREADY_SUCH_DEVINST     = CR_ALREADY_SUCH_DEVNODE;
  CR_INVALID_RANGE_LIST       = $00000011;
  CR_INVALID_RANGE            = $00000012;
  CR_FAILURE                  = $00000013;
  CR_NO_SUCH_LOGICAL_DEV      = $00000014;
  CR_CREATE_BLOCKED           = $00000015;
  CR_NOT_SYSTEM_VM            = $00000016;   // WIN 95 ONLY
  CR_REMOVE_VETOED            = $00000017;
  CR_APM_VETOED               = $00000018;
  CR_INVALID_LOAD_TYPE        = $00000019;
  CR_BUFFER_SMALL             = $0000001A;
  CR_NO_ARBITRATOR            = $0000001B;
  CR_NO_REGISTRY_HANDLE       = $0000001C;
  CR_REGISTRY_ERROR           = $0000001D;
  CR_INVALID_DEVICE_ID        = $0000001E;
  CR_INVALID_DATA             = $0000001F;
  CR_INVALID_API              = $00000020;
  CR_DEVLOADER_NOT_READY      = $00000021;
  CR_NEED_RESTART             = $00000022;
  CR_NO_MORE_HW_PROFILES      = $00000023;
  CR_DEVICE_NOT_THERE         = $00000024;
  CR_NO_SUCH_VALUE            = $00000025;
  CR_WRONG_TYPE               = $00000026;
  CR_INVALID_PRIORITY         = $00000027;
  CR_NOT_DISABLEABLE          = $00000028;
  CR_FREE_RESOURCES           = $00000029;
  CR_QUERY_VETOED             = $0000002A;
  CR_CANT_SHARE_IRQ           = $0000002B;
  CR_NO_DEPENDENT             = $0000002C;
  CR_SAME_RESOURCES           = $0000002D;
  CR_NO_SUCH_REGISTRY_KEY     = $0000002E;
  CR_INVALID_MACHINENAME      = $0000002F;   // NT ONLY
  CR_REMOTE_COMM_FAILURE      = $00000030;   // NT ONLY
  CR_MACHINE_UNAVAILABLE      = $00000031;   // NT ONLY
  CR_NO_CM_SERVICES           = $00000032;   // NT ONLY
  CR_ACCESS_DENIED            = $00000033;   // NT ONLY
  CR_CALL_NOT_IMPLEMENTED     = $00000034;
  CR_INVALID_PROPERTY         = $00000035;
  CR_DEVICE_INTERFACE_ACTIVE  = $00000036;
  CR_NO_SUCH_DEVICE_INTERFACE = $00000037;
  CR_INVALID_REFERENCE_STRING = $00000038;
  CR_INVALID_CONFLICT_LIST    = $00000039;
  CR_INVALID_INDEX            = $0000003A;
  CR_INVALID_STRUCTURE_SIZE   = $0000003B;
  NUM_CR_RESULTS              = $0000003C;

  CM_PROB_NOT_CONFIGURED        = $00000001; // no config for device
  CM_PROB_DEVLOADER_FAILED      = $00000002; // service load failed
  CM_PROB_OUT_OF_MEMORY         = $00000003; // out of memory
  CM_PROB_ENTRY_IS_WRONG_TYPE   = $00000004; //
  CM_PROB_LACKED_ARBITRATOR     = $00000005; //
  CM_PROB_BOOT_CONFIG_CONFLICT  = $00000006; // boot config conflict
  CM_PROB_FAILED_FILTER         = $00000007; //
  CM_PROB_DEVLOADER_NOT_FOUND   = $00000008; // Devloader not found
  CM_PROB_INVALID_DATA          = $00000009; //
  CM_PROB_FAILED_START          = $0000000A; //
  CM_PROB_LIAR                  = $0000000B; //
  CM_PROB_NORMAL_CONFLICT       = $0000000C; // config conflict
  CM_PROB_NOT_VERIFIED          = $0000000D; //
  CM_PROB_NEED_RESTART          = $0000000E; // requires restart
  CM_PROB_REENUMERATION         = $0000000F; //
  CM_PROB_PARTIAL_LOG_CONF      = $00000010; //
  CM_PROB_UNKNOWN_RESOURCE      = $00000011; // unknown res type
  CM_PROB_REINSTALL             = $00000012; //
  CM_PROB_REGISTRY              = $00000013; //
  CM_PROB_VXDLDR                = $00000014; // WINDOWS 95 ONLY
  CM_PROB_WILL_BE_REMOVED       = $00000015; // devinst will remove
  CM_PROB_DISABLED              = $00000016; // devinst is disabled
  CM_PROB_DEVLOADER_NOT_READY   = $00000017; // Devloader not ready
  CM_PROB_DEVICE_NOT_THERE      = $00000018; // device doesn't exist
  CM_PROB_MOVED                 = $00000019; //
  CM_PROB_TOO_EARLY             = $0000001A; //
  CM_PROB_NO_VALID_LOG_CONF     = $0000001B; // no valid log config
  CM_PROB_FAILED_INSTALL        = $0000001C; // install failed
  CM_PROB_HARDWARE_DISABLED     = $0000001D; // device disabled
  CM_PROB_CANT_SHARE_IRQ        = $0000001E; // can't share IRQ
  CM_PROB_FAILED_ADD            = $0000001F; // driver failed add
  CM_PROB_DISABLED_SERVICE      = $00000020; // service's Start = 4
  CM_PROB_TRANSLATION_FAILED    = $00000021; // resource translation failed
  CM_PROB_NO_SOFTCONFIG         = $00000022; // no soft config
  CM_PROB_BIOS_TABLE            = $00000023; // device missing in BIOS table
  CM_PROB_IRQ_TRANSLATION_FAILED= $00000024; // IRQ translator failed
  NUM_CM_PROB                   = $00000025;

  DN_ROOT_ENUMERATED = $00000001; // Was enumerated by ROOT
  DN_DRIVER_LOADED   = $00000002; // Has Register_Device_Driver
  DN_ENUM_LOADED     = $00000004; // Has Register_Enumerator
  DN_STARTED         = $00000008; // Is currently configured
  DN_MANUAL          = $00000010; // Manually installed
  DN_NEED_TO_ENUM    = $00000020; // May need reenumeration
  DN_NOT_FIRST_TIME  = $00000040; // Has received a config
  DN_HARDWARE_ENUM   = $00000080; // Enum generates hardware ID
  DN_LIAR            = $00000100; // Lied about can reconfig once
  DN_HAS_MARK        = $00000200; // Not CM_Create_DevInst lately
  DN_HAS_PROBLEM     = $00000400; // Need device installer
  DN_FILTERED        = $00000800; // Is filtered
  DN_MOVED           = $00001000; // Has been moved
  DN_DISABLEABLE     = $00002000; // Can be rebalanced
  DN_REMOVABLE       = $00004000; // Can be removed
  DN_PRIVATE_PROBLEM = $00008000; // Has a private problem
  DN_MF_PARENT       = $00010000; // Multi function parent
  DN_MF_CHILD        = $00020000; // Multi function child
  DN_WILL_BE_REMOVED = $00040000; // DevInst is being removed

{****************************************************************************
 *
 *				DEVNODE STATUS
 *
 ****************************************************************************
 *
 *	These are the bits in the devnode's status that someone can query
 *	with a CM_Get_DevNode_Status. The A/S column tells wheter the flag
 *	can be change asynchronously or not.
 *
 ***************************************************************************}
  // 4.0 OPK2 Flags
  DN_NOT_FIRST_TIMEE	= $00080000; // S: Has received a config enumerate
  DN_STOP_FREE_RES	  = $00100000; // S: When child is stopped, free resources
  DN_REBAL_CANDIDATE	= $00200000; // S: Don't skip during rebalance
  DN_BAD_PARTIAL		  = $00400000; // S: This devnode's log_confs do not have same resources
  DN_NT_ENUMERATOR	  = $00800000; // S: This devnode's is an NT enumerator
  DN_NT_DRIVER		    = $01000000; // S: This devnode's is an NT driver

  // 4.1 Flags
  DN_NEEDS_LOCKING   	= $02000000; // S: Devnode need lock resume processing
  DN_ARM_WAKEUP		    = $04000000; // S: Devnode can be the wakeup device
  DN_APM_ENUMERATOR	  = $08000000; // S: APM aware enumerator
  DN_APM_DRIVER		    = $10000000; // S: APM aware driver
  DN_SILENT_INSTALL	  = $20000000; // S: Silent install
  DN_NO_SHOW_IN_DM	  = $40000000; // S: No show in device manager
  DN_BOOT_LOG_PROB	  = $80000000; // S: Had a problem during preassignment of boot log conf

  DN_CHANGEABLE_FLAGS	= $79BB62E0;

  // 4.11 Flags
  DN2_EJECT_ON_REMOVE	  = $00000001; // S: to be check on CONFIG_REMOVE to see if ejection is wanted
  DN2_LOCK_CAPABLE	    = $00000002; // S: Locking capable
  DN2_EJECT_CAPABLE	    = $00000004; // S: Ejecting capable
  DN2_EJECT_LOCKED	    = $00000008; // S: Currently locked from ejecting
  DN2_EJECTED_ON_REMOVE	= $00000010; // S: to be set on CONFIG_REMOVE on successful ejection
  DN2_POWER_NOOP		    = $00000020; // S: does not care about power
  DN2_STARTING		      = $00000040; // S: devnode is currently starting
  DN2_NO_EXIT_REMOVE	  = $00000080; // S: devnode will not be remove at exit
  DN2_NO_HIBER_DISABLE  = $00000100; // S: devnode will not be disable at pageable resume

  DN2_CHANGEABLE_FLAGS	= $000001B6;

  NUM_DN_FLAG		= $00000020; // DEBUG: maximum flag (number)
  NUM_DN2_FLAG	= $00000009; // DEBUG: maximum flag (number)
  DN_FLAG_LEN		= $00000002; // DEBUG: flag length

  function CM_Get_DevNode_Status(pulStatus: PULONG; pulProblemNumber: PULONG;
      dnDevInst: DEVINST; ulFlags: ULONG): Integer;
      stdcall external 'cfgmgr32.dll' name 'CM_Get_DevNode_Status';

implementation

end.
