//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         Ole
//
//
//      Description:  OLE Storage 
//
//////////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2004-2011 NikaSoft. All rights reserved.
//     Author: A.V.Nikulitsa
//
//       site: http://www.nika-soft.com/ 
//     e-mail: support@nika-soft.com
//
//////////////////////////////////////////////////////////////////////////////

unit ole;
{$Q-}
{$R-}

interface
uses Windows;
Const

  ole32    = 'ole32.dll';

  {$EXTERNALSYM STGC_DEFAULT}
  STGC_DEFAULT                            = 0;


  {$EXTERNALSYM STGM_CREATE}
  STGM_CREATE           = $00001000;
  {$EXTERNALSYM STGM_READ}
  STGM_READ             = $00000000;
  {$EXTERNALSYM STGM_WRITE}
  STGM_WRITE            = $00000001;

  {$EXTERNALSYM STGM_DIRECT}
  STGM_DIRECT           = $00000000;
  {$EXTERNALSYM STGM_TRANSACTED}
  STGM_TRANSACTED       = $00010000;
  {$EXTERNALSYM STGM_SIMPLE}
  STGM_SIMPLE           = $08000000;

  {$EXTERNALSYM STGM_SHARE_DENY_READ}
  STGM_SHARE_DENY_READ  = $00000030;
  {$EXTERNALSYM STGM_SHARE_DENY_WRITE}
  STGM_SHARE_DENY_WRITE = $00000020;
  {$EXTERNALSYM STGM_SHARE_DENY_NONE}
  STGM_SHARE_DENY_NONE  = $00000040;
  {$EXTERNALSYM STGM_SHARE_EXCLUSIVE}
  STGM_SHARE_EXCLUSIVE  = $00000010;
  {$EXTERNALSYM STGM_READWRITE}
  STGM_READWRITE        = $00000002;

Type

  POleStr = PWideChar;
{ 64-bit large integer }
  Largeint = Comp;
  TCLSID = TGUID;
  TIID = TGUID;
  PIID = PGUID;
  TVarType = Word;

{ Forward declarations }

{ IUnknown interface }

  {$EXTERNALSYM IUnknown }
  IUnknown = class
  public
    function QueryInterface(const iid: TIID; var obj): HResult; virtual; stdcall; abstract;
    function AddRef: Longint; virtual; stdcall; abstract;
    function Release: Longint; virtual; stdcall; abstract;
  end;

  { IStream interface }

  PStatStg = ^TStatStg;
  {$EXTERNALSYM tagSTATSTG}
  tagSTATSTG = record
    pwcsName: POleStr;
    dwType: Longint;
    cbSize: Largeint;
    mtime: TFileTime;
    ctime: TFileTime;
    atime: TFileTime;
    grfMode: Longint;
    grfLocksSupported: Longint;
    clsid: TCLSID;
    grfStateBits: Longint;
    reserved: Longint;
  end;
  TStatStg = tagSTATSTG;
  {$EXTERNALSYM STATSTG}
  STATSTG = tagSTATSTG;


  {$EXTERNALSYM ILockBytes}
  ILockBytes = class(IUnknown)
  public
    function ReadAt(ulOffset: Largeint; pv: Pointer; cb: Longint;
      pcbRead: PLongint): HResult; virtual; stdcall; abstract;
    function WriteAt(ulOffset: Largeint; pv: Pointer; cb: Longint;
      pcbWritten: PLongint): HResult; virtual; stdcall; abstract;
    function Flush: HResult; virtual; stdcall; abstract;
    function SetSize(cb: Largeint): HResult; virtual; stdcall; abstract;
    function LockRegion(libOffset: Largeint; cb: Largeint;
      dwLockType: Longint): HResult; virtual; stdcall; abstract;
    function UnlockRegion(libOffset: Largeint; cb: Largeint;
      dwLockType: Longint): HResult; virtual; stdcall; abstract;
    function Stat(var statstg: TStatStg; grfStatFlag: Longint): HResult;
      virtual; stdcall; abstract;
  end;


  {$EXTERNALSYM IStream}
  IStream = class(IUnknown)
  public
    function Read(pv: Pointer; cb: Longint; pcbRead: PLongint): HResult;
      virtual; stdcall; abstract;
    function Write(pv: Pointer; cb: Longint; pcbWritten: PLongint): HResult;
      virtual; stdcall; abstract;
    function Seek(dlibMove: Largeint; dwOrigin: Longint;
      var libNewPosition: Largeint): HResult; virtual; stdcall; abstract;
    function SetSize(libNewSize: Largeint): HResult; virtual; stdcall; abstract;
    function CopyTo(stm: IStream; cb: Largeint; var cbRead: Largeint;
      var cbWritten: Largeint): HResult; virtual; stdcall; abstract;
    function Commit(grfCommitFlags: Longint): HResult; virtual; stdcall; abstract;
    function Revert: HResult; virtual; stdcall; abstract;
    function LockRegion(libOffset: Largeint; cb: Largeint;
      dwLockType: Longint): HResult; virtual; stdcall; abstract;
    function UnlockRegion(libOffset: Largeint; cb: Largeint;
      dwLockType: Longint): HResult; virtual; stdcall; abstract;
    function Stat(var statstg: TStatStg; grfStatFlag: Longint): HResult;
      virtual; stdcall; abstract;
    function Clone(var stm: IStream): HResult; virtual; stdcall; abstract;
  end;

  { IEnumStatStg interface }

  {$EXTERNALSYM IEnumStatStg }
  IEnumStatStg = class(IUnknown)
  public
    function Next(celt: Longint; var elt;
      pceltFetched: PLongint): HResult; virtual; stdcall; abstract;
    function Skip(celt: Longint): HResult; virtual; stdcall; abstract;
    function Reset: HResult; virtual; stdcall; abstract;
    function Clone(var enm: IEnumStatStg): HResult; virtual; stdcall; abstract;
  end;

  { IStorage interface }

  TSNB = ^POleStr;

  {$EXTERNALSYM IStorage}
  IStorage = class(IUnknown)
  public
    function CreateStream(pwcsName: POleStr; grfMode: Longint; reserved1: Longint;
      reserved2: Longint; var stm: IStream): HResult; virtual; stdcall; abstract;
    function OpenStream(pwcsName: POleStr; reserved1: Pointer; grfMode: Longint;
      reserved2: Longint; var stm: IStream): HResult; virtual; stdcall; abstract;
    function CreateStorage(pwcsName: POleStr; grfMode: Longint;
      dwStgFmt: Longint; reserved2: Longint; var stg: IStorage): HResult;
      virtual; stdcall; abstract;
    function OpenStorage(pwcsName: POleStr; stgPriority: IStorage;
      grfMode: Longint; snbExclude: TSNB; reserved: Longint;
      var stg: IStorage): HResult; virtual; stdcall; abstract;
    function CopyTo(ciidExclude: Longint; rgiidExclude: PIID;
      snbExclude: TSNB; stgDest: IStorage): HResult; virtual; stdcall; abstract;
    function MoveElementTo(pwcsName: POleStr; stgDest: IStorage;
      pwcsNewName: POleStr; grfFlags: Longint): HResult; virtual; stdcall; abstract;
    function Commit(grfCommitFlags: Longint): HResult; virtual; stdcall; abstract;
    function Revert: HResult; virtual; stdcall; abstract;
    function EnumElements(reserved1: Longint; reserved2: Pointer; reserved3: Longint;
      var enm: IEnumStatStg): HResult; virtual; stdcall; abstract;
    function DestroyElement(pwcsName: POleStr): HResult; virtual; stdcall; abstract;
    function RenameElement(pwcsOldName: POleStr;
      pwcsNewName: POleStr): HResult; virtual; stdcall; abstract;
    function SetElementTimes(pwcsName: POleStr; const ctime: TFileTime;
      const atime: TFileTime; const mtime: TFileTime): HResult;
      virtual; stdcall; abstract;
    function SetClass(const clsid: TCLSID): HResult; virtual; stdcall; abstract;
    function SetStateBits(grfStateBits: Longint; grfMask: Longint): HResult;
      virtual; stdcall; abstract;
    function Stat(var statstg: TStatStg; grfStatFlag: Longint): HResult;
      virtual; stdcall; abstract;
  end;

{ Storage API prototypes }

{$EXTERNALSYM StgCreateDocfile}
function StgCreateDocfile(pwcsName: POleStr; grfMode: Longint;
  reserved: Longint; var stgOpen: IStorage): HResult; stdcall;

{$EXTERNALSYM StgOpenStorage}
function StgOpenStorage(pwcsName: POleStr; stgPriority: IStorage;
  grfMode: Longint; snbExclude: TSNB; reserved: Longint;
  var stgOpen: IStorage): HResult; stdcall;

{$EXTERNALSYM CreateILockBytesOnHGlobal}
function CreateILockBytesOnHGlobal(hglob: HGlobal; fDeleteOnRelease: BOOL;
  var lkbyt: ILockBytes): HResult; stdcall;

{$EXTERNALSYM StgCreateDocfileOnILockBytes}
function StgCreateDocfileOnILockBytes(lkbyt: ILockBytes; grfMode: Longint;
  reserved: Longint; var stgOpen: IStorage): HResult; stdcall;

{$EXTERNALSYM GetHGlobalFromILockBytes}
function GetHGlobalFromILockBytes(lkbyt: ILockBytes; var hglob: HGlobal): HResult; stdcall;

{$EXTERNALSYM StgOpenStorageOnILockBytes}
function StgOpenStorageOnILockBytes(lkbyt: ILockBytes; stgPriority: IStorage;
  grfMode: Longint; snbExclude: TSNB; reserved: Longint;
  var stgOpen: IStorage): HResult; stdcall;


{ HResult manipulation routines }
function Succeeded(Res: HResult): Boolean;

implementation

{$EXTERNALSYM StgCreateDocfile}
function StgCreateDocfile;              external ole32 name 'StgCreateDocfile';

{$EXTERNALSYM StgOpenStorage}
function StgOpenStorage;              external ole32 name 'StgOpenStorage';

function CreateILockBytesOnHGlobal;     external ole32 name 'CreateILockBytesOnHGlobal';
function StgCreateDocfileOnILockBytes;  external ole32 name 'StgCreateDocfileOnILockBytes';
function GetHGlobalFromILockBytes;      external ole32 name 'GetHGlobalFromILockBytes';
function StgOpenStorageOnILockBytes;    external ole32 name 'StgOpenStorageOnILockBytes';


{ Helper functions }
function Succeeded(Res: HResult): Boolean;
begin
  Result := ((Res and HResult($80000000)) = $0);
end;

end.
