unit s_lib_pas_unit;

interface
uses Windows;

const
  m_error_log = 0;
  m_info_log = 1;


  m_dead_lock_exit = 118;
  m_exit_be_killed = 119;
  m_error_exit = 117;
  m_exit = 0;
  FFdll = 'flyingfish.dll';
  FF_NTSRTS_DLL = 'ff_ntsrts.dll';

var
  m_module_name: array[0..255] of Char;



function W_Log(
  pc_module: PChar;
  i_lineno: Integer;
  int: Integer;
  pc_log: PChar
  ): Integer; cdecl;
external 'flyingfish.dll' name 'W_Log';


function GetKeyValue(
  inifilename: PChar;
  section: PChar;
  key: PChar;
  datatype: PChar;
  {
         /* c for null end char */
         /* s for short */
         /* i for int */
         /* l for long */
         /* f for float */
         /* d for double */
   }
  value: PChar
  ): Integer; cdecl;
external 'flyingfish.dll' name 'GetKeyValue';

function WriteIni(
  c_filename: PChar;
  c_section: PChar;
  c_key: PChar;
  c_value: PChar
  ): Integer; cdecl;
external 'flyingfish.dll' name 'WriteIni';


procedure s_sleep_us(l_us: Integer); cdecl;
external 'flyingfish.dll' name 's_sleep_us';

function FF_exit(i_exit: Integer): Integer; cdecl;
external 'flyingfish.dll' name 'FF_exit';

function FF_RtsMain(
  p_cert_passwd: PChar
  ): Integer; cdecl;
external FF_NTSRTS_DLL name 'FF_RtsMain';

function FF_NtsMain(
  p_cert_passwd: PChar
  ): Integer; cdecl;
external FF_NTSRTS_DLL name 'FF_NtsMain';

function FF_webMain(
  p_cert_passwd: PChar
  ): Integer; cdecl;
external FF_NTSRTS_DLL name 'FF_webMain';

function FF_CAMain(
  p_cert_passwd: PChar
  ): Integer; cdecl;
external FF_NTSRTS_DLL name 'FF_CAMain';

function FF_init(
  p_cert_passwd: PChar
  ): Integer; cdecl;
external 'flyingfish.dll' name 'FF_init';


function FF_get_thdinfo1(
  p_v: Pointer
  ): Integer; cdecl;
external 'flyingfish.dll' name 'FF_get_thdinfo';

function FF_get_thdinfo(
  p_v: Pointer; pv_size: Integer
  ): Integer; cdecl;
external 'flyingfish.dll' name 'FF_get_thdinfo1';

function CurDate(
  buf: PChar
  ): PChar; cdecl;
external 'flyingfish.dll' name 'CurDate';
function CurTime(
  buf: PChar
  ): PChar; cdecl;
external 'flyingfish.dll' name 'CurTime';

function FF_W_Info1(
  pc_file_name: PChar;
  pc_info: PChar; i_flag: Integer
): PChar; cdecl;
external 'flyingfish.dll' name 'FF_W_Info1';

//int FF_cert_key_passwd(char *p_keyfile,char *p_oldpass,char *p_newpass)
function FF_cert_key_passwd(
  p_key_file: PChar;
  p_oldpass: PChar;
  p_newpass: PChar
  ): Integer; cdecl;
external 'flyingfish.dll' name 'FF_cert_key_passwd';
//char *FF_ffconf(char *c_filename,char *c_section,char *c_name)
function FF_ffconf(
  c_filename: PChar;
  c_section: PChar;
  c_name: PChar
  ): PChar; cdecl;
external 'flyingfish.dll' name 'FF_ffconf';

function FF_load_allconf(): PChar; cdecl;
external 'flyingfish.dll' name 'FF_load_allconf';


//int FF_key_passwd_check(char *p_keyfile,char *p_passwd)
function FF_key_passwd_check(
  p_keyfile: PChar;
  p_passwd: PChar
  ): Integer; cdecl;
external FFdll name 'FF_key_passwd_check';



implementation

end.
