{******************************************************************************
*   Uint untConst
*   Module is to write some Constant Define , just like c head files
*   CopyRight (c) Nanjing Fujitsu Nanda SotfWare Tech. Co., Ltd.
*   CopyRight (c) By GanHuaXin 2001
*   All Right Reserved
*   Date    :
*       New Develop   : 2001-1-9
*       Modified      : 2001-1-9
******************************************************************************}

unit untConst;

interface

uses
  Windows,
  Messages;

// some Icons Macro define
const
  ICON_APP        : PChar = 'APP_ICON';

// some command macro define of Main Window
const
  IDM_ABOUT       = 101;
  IDM_QUIT        = 102;
  IDM_OPTION      = 103;
  IDM_ALLONTOP    = 104;
  IDM_TRANSPARENT = 105;
  IDM_HINTSET     = 106;
  IDM_CLOCKSET    = 107;
  IDM_CIRCLK      = 108;
  IDM_DIGCLK      = 109;
  IDM_STARTWITHWIN= 110;

// some command macro define of Dialog About
const
  ID_ABOUT_OK         = 101;
  ID_ABOUT_LBLEMAIL   = 100;

// some constant macro define of Dialog Option
const
  // push buttons
  ID_OPTION_OK        = 113;
  ID_OPTION_CANCEL    = 114;
  ID_OPTION_APPLY     = 115;

  // Postion Optint Radio Buttons
  ID_OPTION_TOPLEFT       = 108;
  ID_OPTION_TOPCENTER     = 109;
  ID_OPTION_TOPRIGHT      = 110;
  ID_OPTION_MIDDLELEFT    = 112;
  ID_OPTION_MIDDLECENTER  = 116;
  ID_OPTION_MIDDLERIGHT   = 111;
  ID_OPTION_BOTTOMLEFT    = 117;
  ID_OPTION_BOTTOMCENTER  = 118;
  ID_OPTION_BOTTOMRIGHT   = 119;
  ID_OPTION_USERPLACE     = 120;

  // Check Button
  ID_OPTION_CHKSTARTWIN   = 102;
  ID_OPTION_CHKTRANS      = 103;
  ID_OPTION_CHKALLONTOP   = 104;
  ID_OPTION_CHKSHOWTRAY   = 105;
  ID_OPTION_CHKTASKBAR    = 106;

  // Edits
  ID_OPTION_EDITTRANS     = 121;
  ID_OPTION_EDITWINWIDTH  = 122;

  // some label
  ID_OPTION_LBLDEGREE     = 123;
// some constant about Dialog Hint
const
  ID_HINT_LBLHINT         = 100;
  ID_HINT_ISEE            = 101;
// some constant about SetLayeredWindowAttributes
const
  WS_EX_LAYERED           = $80000;
  AC_SRC_OVER             = $0;
  AC_SRC_ALPHA            = $1;
  AC_SRC_NO_PREMULT_ALPHA = $1;
  AC_SRC_NO_ALPHA         = $2;
  AC_DST_NO_PREMULT_ALPHA = $10;
  AC_DST_NO_ALPHA         = $20;
  LWA_COLORKEY            = $1;
  LWA_ALPHA               = $2;
  ULW_COLORKEY            = $1;
  ULW_ALPHA               = $2;
  ULW_OPAQUE              = $4;

// some constant about the TrayIcon Define
const
  WM_TRAYICONNOTIFY       = WM_USER + 188;
  ID_TRAYICON             = $EEFF;
// Self Define WindowMessage!
const
  WM_MYPOSCHANGE          = WM_USER + 190;

// some constant about the window
var
  WIN_HALF_WIDTH  : integer= 40;

const
  APP_KEY_STR             = 'SoftWare\huiyuSoft\ClockHint\';
  APP_KEY_SUBPOS          : PChar = 'WindowPosition';
  APP_KEY_SUBPOSOPT       : PChar = 'WindowPosOpt';
  APP_KEY_SUBALLONTOP     : PChar = 'WindowAllOnTop';
  APP_KEY_SUBTRANSPARENT  : PChar = 'WindowTransparent';
  APP_KEY_SUBSHOWTRAY     : PChar = 'WindowShowTray';
  APP_KEY_SUBCLOCKSTYLE   : PChar = 'Clock Style';
  APP_KEY_SUBSHOWONTASKBAR: PChar = 'Show On TaskBar';
const
  M_SUBNAME               : PChar = 'Huiyu''''s Clock';
  APP_KEY_START           :
    PChar = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Run';

type
  TMyWindowPos = record
    Top,
    Left  : SmallInt;   // 16 bit + 16 bit;
    Width : SmallInt;   // 16 bit 
  end;
  
const
  DEFAULTPOS : TMyWindowPos =
                (Top    : 0;
                 Left   : 0;
                 Width  : 100);
var
  ParentWnd : THandle = 0;
  ClockWnd : THandle = 0;

var
  RgnFrame  : THandle = 0;
  RgnCenter : THandle = 0;
  RgnHour   : THandle = 0;
  RgnMinute : THandle = 0;
  RgnSecond : THandle = 0;
  
  LastSecond: integer = 0;
  LastMinute: integer = 0;

implementation

end.
