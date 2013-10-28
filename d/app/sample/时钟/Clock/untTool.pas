{******************************************************************************
*   Unit untTool
*   Module is support some tools function to the main module
*   CopyRight (C) Nanjing Fujitsu Nanda SoftWare Tech. Co., LTD.
*   CopyRight (C) By GanHuaXin 2001
*   Date :
*     New Develop   : 2001-1-8
*     Modify        : 2001-1-9 
******************************************************************************}
unit untTool;

interface
uses
  Sysutils,
  Windows,
  ShellAPI,
  Messages,
  untConst;

//function InitWindow(hWnd:HWND):BOOL;
function SetTransparent(hWnd:HWND; bAlpha:byte):BOOL;
function SetWindowAllOnTop(hWnd:HWND;bOnTop:Boolean):BOOL;
function SetWindowTransparent(hWnd:HWND;bTrans:Boolean):BOOL;
function SetWindowInCenter(hWnd:HWND):BOOL;
function SetAppAtStart(bSet:Boolean):BOOL;
function GetAppAtStart:BOOL;

function TrayIconAdd(hWnd:HWND; uID:integer; hIcon:HICON; hint:String):BOOL;
function TrayIconEdit(hWnd:HWNd; uID:integer; hIcon:HICON; hint:String):BOOL;
function TrayIconDel(hWnd:HWND; uID:integer):BOOL;
function ShowOnTray(hWnd:HWND):BOOL;
function DelOnTray(hWnd:HWND):Bool;

function SetRegData(Name:string; Buffer:Pointer; BufSize:Integer):BOOL;
function GetRegData(Name:string; Buffer:Pointer; BufSize:Integer):BOOL;

function SetRegWindowPosOpt(option:integer):BOOL;
function SetRegWindowPos(hWnd : HWND):BOOL;
function SetRegAllOnTop(option : boolean):BOOL;
function SetRegTransparent(option : boolean):BOOL;
function SetRegShowTray(option : boolean):BOOL;
function SetRegClockStyle(option : integer):BOOL;
function SetRegShowOnTaskBar(option : boolean):BOOL;

function GetRegWindowPosOpt(var Option : integer):BOOL;
function GetRegWindowPos(var Value:TMyWindowPos):BOOL;
function GetRegAllOnTop(var bOnTop:Boolean):BOOL;
function GetRegTransparent(var bTrans:Boolean):BOOL;
function GetRegShowTray(var bOnTray:Boolean):BOOL;
function GetRegClockStyle(var option:integer):BOOL;
function GetRegShowOnTaskBar(var bShown : boolean):BOOL;

function RegErrorHandle(error : integer):String;

function GetPlacePos(var Pos:TMyWindowPos):BOOL;

function GetCheckBitmaps(fuCheck:UINT; menuID:integer):HBITMAP;
function SetMenuOwnerDraw(menu : HMENU; cmdID : integer):BOOL;
function DrawBmpMenu(itemMenu : DRAWITEMSTRUCT):BOOL;

function CreateRgnFromBmp(bmp : HBITMAP):HRGN;
function CreateAlfaRgn(x,y,r,Alfa,halfWidth,ArrowLen:integer):HRGN;
function CreateHourRgn(hour,minute:integer):HRGN;
function CreateMinuteRgn(minute:integer):HRGN;
function CreateSecondRgn(second:integer):HRGN;


(*
function RegisterServiceProcess(dwProcessID, dwType: Integer): Integer;
    stdcall; external 'KERNEL32.DLL';
*)
implementation


{******************************************************************************
*   Function SetLayeredWindowAttributes(hWnd,crKey,bAlpha,dwFlags)
*   Description :    This Function is a new function import from win2000
*       It can not work on win9x
******************************************************************************}
{
function SetLayeredWindowAttributes(
              hwnd    :HWND;        //handle aoubt the window
              crKey   :Longint;     //
              bAlpha  :byte;        //
              dwFlags :longint      //
          ):BOOL; stdcall; external user32;
}
type
  TSetLayeredWindowAttributes =
    function(hWnd:HWND;crKey:Longint;bAlphs:byte;dwFlags:LongInt):BOOL;stdcall;
{******************************************************************************
*   Function SetTransparent(hWnd,bAlpha)
*   Purpose:
*       To set the window transparent as degree by bAlpha
*   Arguments:
*       hWnd        :   Handl of the window
*       bAlpha      :   The transparent degree , range from 0 to 255
*   Return Value    :   Bool of function SetlayeredWindowAttributes
******************************************************************************}
function SetTransparent(hWnd:HWND; bAlpha:byte):BOOL;
var
  dwStyle : LongInt;
  pSetLayeredWindowAttributes:TSetLayeredWindowAttributes;
  hModule:THandle;
begin
  result := false;
  if hWnd = 0 then exit;
  dwStyle := GetWindowLong(hWnd,GWL_EXSTYLE);
  dwStyle := dwStyle or WS_EX_LAYERED;
  if SetWindowLong(hwnd,GWL_EXSTYLE,dwStyle)=0 then
    exit;
  {
  result :=
    SetLayeredWindowAttributes(hWnd,0, bAlpha, LWA_ALPHA);
  }

  hModule := LoadLibrary(user32);
  if (hModule<>0) then begin
    @pSetLayeredWindowAttributes :=
      GetProcAddress(hModule,'SetLayeredWindowAttributes');
    if (@pSetLayeredWindowAttributes <> nil) then
      result := pSetLayeredWindowAttributes(hWnd,0,bAlpha,LWA_ALPHA);
    FreeLibrary(hModule);
    pSetLayeredWindowAttributes := nil;
  end;
  if not result then
    MessageBox(GetFocus(),'Error to set tranparent!','Error!',MB_OK);
end;

function SetWindowAllOnTop(hWnd:HWND;bOnTop:Boolean):BOOL;
begin
  if bOnTop then
    SetWindowPos(hWnd,HWND_TOPMOST,0,0,0,0,SWP_NOMOVE or SWP_NOSIZE)
  else
    SetWindowPos(hWnd,HWND_NOTOPMOST,0,0,0,0,SWP_NOMOVE or SWP_NOSIZE);
  result := true;
end;

function SetWindowTransparent(hWnd:HWND;bTrans:Boolean):BOOL;
begin
  if bTrans then
    SetTransparent(hWnd,160)
  else
    SetTransparent(hWnd,255);
  result := true;
end;

function SetWindowInCenter(hWnd:HWND):BOOL;
var
  ScrH,ScrW : integer;
  rect      : TRect;
  NewLeft,NewTop : integer;
begin
  ScrH := GetSystemMetrics(SM_CYFULLSCREEN);
  ScrW := GetSystemMetrics(SM_CXFULLSCREEN);
  GetWindowRect(hWnd,rect);
  NewLeft := (ScrW - (rect.Right - rect.Left)) div 2;
  NewTop := (ScrH - (rect.Bottom - rect.Top)) div 2;
  SetWindowPos(hWnd,0,NewLeft,NewTop,0,0,SWP_NOSIZE or SWP_NOZORDER);
end;

function GetAppAtStart:BOOL;
var
  key : HKEY;
  ret : integer;
  chg : DWORD;
  Buffer : string[255];
  len : DWORD;
begin
  result := false;
  key := 0;
  ret := RegCreateKeyEx(
      HKEY_LOCAL_MACHINE,
      APP_KEY_START,
      0,Nil,REG_OPTION_NON_VOLATILE,
      KEY_ALL_ACCESS,
      Nil,key,@chg);
  if (ret<>ERROR_SUCCESS) or (key=0) then exit;
  len := 255;
  try
    if RegQueryValueEx(key,M_SUBNAME,nil,nil,PByte(@Buffer),@len)
      = ERROR_SUCCESS then result := true;
  finally
    RegCloseKey(key);
  end;
end;

function SetAppAtStart(bSet:Boolean):BOOL;
var
  key : HKEY;
  ret : integer;
  chg : DWORD;
  AppStr : String;
begin
  result := false;
  key := 0;
  ret := RegCreateKeyEx(
      HKEY_LOCAL_MACHINE,
      APP_KEY_START,
      0,Nil,REG_OPTION_NON_VOLATILE,
      KEY_ALL_ACCESS,
      Nil,key,@chg);
  if (ret<>ERROR_SUCCESS) or (key=0) then exit;
  try
    if not bSet then begin
      RegDeleteValue(key,M_SUBNAME);
    end
    else begin
      AppStr := ParamStr(0);
      RegSetValueEx(key,M_SUBNAME,0,REG_SZ,PChar(AppStr),Length(AppStr));
    end;
    result := true;
  finally
    RegCloseKey(key);
  end;
end;
{******************************************************************************
*   Function TrayIconAdd(hWnd,uID,hIcon,hint);
*   Purpose:
*       To Add a Icon on System TrayIcon Area
*   Arguments:
*       hWnd    : The revieved notify message's window's handle
*       uID     : The Identify of the Icon
*       hIcon   : The Handle of the ICON shows
*       hint    : The hint information when the mouse cursor on Tray Icon
*   Return Value:
*       See Shell_NotifyIcon
*   Date        : 2001-1-9
******************************************************************************}
function TrayIconAdd(hWnd:HWND; uID:integer; hIcon:HICON; hint:String):BOOL;
var
  IconData : NOTIFYICONDATA;
begin
  if (hWnd = 0) or (hIcon = 0) then begin
    result := false;
    exit;
  end;
  with IconData do begin
    cbSize            := SizeOf(IconData);
    uCallBackMessage  := WM_TRAYICONNOTIFY;
    uFlags            := NIF_MESSAGE or NIF_ICON or NIF_TIP;
    Wnd               := hWnd;
    StrCopy(szTip, PChar(hint));
  end;
  IconData.hIcon := hIcon;
  IconData.uID := uID;
  result :=
    Shell_NotifyIcon(NIM_ADD,@IconData);
end;

{******************************************************************************
*   Function TrayIconEdit(hWnd,uID,hIcon,hint)
*   Purpose:
*       To Modify the exist Tray Icon 's styles such as Icon or Hint string
*   Date    :
*       New Development   :   2001-1-9
*       Modified          :
******************************************************************************}
function TrayIconEdit(hWnd:HWNd; uID:integer; hIcon:HICON; hint:string):BOOL;
var
  IconData : NOTIFYICONDATA;
begin
  if (hWnd = 0) or (hIcon = 0) then begin
    result := false;
    exit;
  end;
  with IconData do begin
    cbSize            := SizeOf(IconData);
    uCallBackMessage  := WM_TRAYICONNOTIFY;
    uFlags            := NIF_MESSAGE or NIF_ICON or NIF_TIP;
    Wnd               := hWnd;
    StrCopy(szTip, PChar(hint));
  end;
  IconData.hIcon := hIcon;
  IconData.uID := uID;
  result :=
    Shell_NotifyIcon(NIM_MODIFY,@IconData);

end;

{******************************************************************************
*   Function TrayIconDel(hWnd,uID);
*   Purpose:
*       To Delete the Identify Icon on system Tray Icon Area
*   Arguments:
*       hWnd        : The Recevied Message Window's handle
*       uID         : The Identify of Icon
*   Return Value    : See Shell_NotifyIcon
*   Date            : 2001-1-9
******************************************************************************}
function TrayIconDel(hWnd:HWND; uID:integer):BOOL;
var
  IconData : NOTIFYICONDATA;
begin
  if (hWnd = 0) then begin
    result :=false;
    exit;
  end;
  with IconData do begin
    cbSize  := SizeOf(IconData);
    Wnd     := hWnd;
  end;
  IconData.uID := uID;
  result := Shell_NotifyIcon(NIM_DELETE, @IconData);
end;

{******************************************************************************
*   Function ShouldFlash:Bool;
*   Purpose:
*       To Determing whether it's time to flash the Tray Icon ?
*       and it is only used in procedure TimerProcMain
*   Date    :   2001-1-9
******************************************************************************}
function ShouldFlash:BOOL;
begin
  result := false;
end;

{******************************************************************************
*   Procedure DoFun;
*   Purpose:
*       To Show Some Fun things on the Screen
*   Date:
*       New Develop   :   2001-01-09
*       Modified      :   2001-01-10
******************************************************************************}
procedure DoFun;
var
  dc : HDC;
  //p   : TPoint;
  //pStru:PAINTSTRUCT;
begin
  dc := GetDC(0);
  TextOut(DC,400,400,'中华人民共和国',14);
  ReleaseDC(0,dc);
end;

procedure TimerProcFlash(
                  hwnd    : HWND;         // handle to window
                  Msg     : LongWord;     // WM_TIMER message
                  idEvent : integer;      // timer identifier
                  dwTime  : integer       // current system time
                  );stdcall;forward;
{******************************************************************************
*   Function TimerProcMain(hWnd,Msg,idEvent,dwTime
*   Purpose:
*       To control whether Flash the Tray ICON
*   Date    :   @001-1-9
******************************************************************************}
procedure TimerProcMain(
                  hWnd    : HWND;
                  Msg     : LongWord;
                  idEvent : integer;
                  dwTime  : integer
                  );stdcall;
begin
  if ShouldFlash then begin  // if the tray icon should Flash
    SetTimer(hWnd,2,400,@TimerProcFlash);  // Active timer 2
    DoFun;
    KillTimer(hWnd,1);                    // And kill self
  end else
    SendMessage(0,WM_PAINT,0,0);
end;

{******************************************************************************
*   Function TimerProcFlash(hWnd,Msg,idEvent,dwTime);
*   Purpose:
*       To Flash the TrayIcon
*   Date    :   2001-1-9
*
******************************************************************************
*   Some Global Variables:
*       IconS         :   Store the Icon Resources' Name as PChar
*       IconIndex     :   To Identify the Current Shown Icon No.
*       FlashCycle    :   The Flash Cycle times
*       MaxFlashCycle :   the Max Flash Cycle times
*
******************************************************************************}
var
  IconS : Array[1..4] of PChar =
          ('ICON_TRAY1','ICON_TRAY2',
           'ICON_TRAY3','ICON_TRAY4' );
  IconIndex : integer = 1;            // Current Icon Index
  FlashCyle : integer = 1;            // the Flash Icon Cycle times
  MaxFlashCycle : integer = 4;        // max Flash Cycle times

procedure TimerProcFlash(
                  hwnd    : HWND;         // handle to window
                  Msg     : LongWord;     // WM_TIMER message
                  idEvent : integer;      // timer identifier
                  dwTime  : integer       // current system time
                  );stdcall;
var
  hIcon : THandle;
begin
  Inc(IconIndex);
  if IconIndex = 5 then begin
    IconIndex := 1;
    Inc(FlashCyle);
    if FlashCyle > MaxFlashCycle then begin
      FlashCyle := 1;
      SetTimer(hWnd,1,2000,@TimerProcMain);// Active timer 2
      KillTimer(hWnd,2);                    // Kill Self
      // And then reback the Tray Icon!
      hIcon := LoadIcon(hInstance,IconS[1]);
      TrayIconEdit(hWnd,ID_TRAYICON,hIcon,'Hello, World!');

      //SendMessage(0,WM_PAINT,0,0);
      UpdateWindow(0);

      exit;
    end;
  end;
  hIcon := LoadIcon(hInstance,IconS[IconIndex]);
  TrayIconEdit(hWnd,ID_TRAYICON,hIcon,'你有事情要做！:-)');
end;

{******************************************************************************
*   Function ShowOnTray(hWnd);
*   Purpose:
*       To Set The Icon on Tray and set the Timer
*   Arguments:
*       hWnd    :   The Handle that received messages
*   Date    :
*       New Development :   2001-01-09
*       Modified        :   2001-01-10
******************************************************************************}
function ShowOnTray(hWnd:HWND):BOOL;
var
  hIcon : THandle;
begin
  hIcon := LoadIcon(hInstance, 'ICON_TRAY1');
  Result := TrayIconAdd(hWnd,ID_TRAYICON,hIcon,'hello,world!');
  DeleteObject(hIcon);
  SetTimer(hWnd,1,2000,@TimerProcMain);
end;

{******************************************************************************
*   Function DelOnTray(hWnd)
*   Purpose:
*       To Delete the Icon on Tray Area and kill all Timers
*   Date:
*       New Development :   2001-01-09
*       Modified        :
******************************************************************************}
function DelOnTray(hWnd:HWND):Bool;
begin
  Result := TrayIconDel(hWnd,ID_TRAYICON);
  KillTimer(hWnd,1);
  KillTimer(hWnd,2);
end;

function RegErrorHandle(error : integer):String;
var
  h : PChar;
begin
  h:=StrAlloc(400);
  FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM or FORMAT_MESSAGE_FROM_HMODULE,
    nil,GetLastError,5,h,400,nil);
  result := StrPas(h);
  StrDispose(h);

end;
//
//************  The Follow is some operator to Registry  **********************
//

{******************************************************************************
*   Function OpenRegData()
*   Purpose:
*       To Open the special KEY of Clock Hint Application
*   Date   :
*       New Develop : 2001-1-9
*       Modified    :
******************************************************************************}
function OpenRegData(var APP_KEY : HKEY):BOOL;
var
  chg   : DWORD;
  keyCrt: integer;
begin
  result := TRUE;
  keyCrt:= RegCreateKeyEx(
      HKEY_CURRENT_USER,
      //HKEY_LOCAL_MACHINE,
      APP_KEY_STR,
      0,Nil,REG_OPTION_NON_VOLATILE,
      KEY_ALL_ACCESS,
      Nil,APP_KEY,@chg);
  if (KeyCrt<> ERROR_SUCCESS) or (APP_KEY=0) then
    result := false;
end;

{*****************************************************************************
*   Function SetRegData
*   Purpose:
*       To set special data to my application registry data
*   Date:
*       New Develop   :   2001-1-11
*       Modified      :   2001-1-11
*   Retrun Value  :
*       True or False , identify whether the operation is Success
*****************************************************************************}
function SetRegData(Name:string; Buffer:Pointer; BufSize:Integer):BOOL;
var
  ret : integer;
  APP_KEY : HKEY;
begin
  result := false;
  if not OpenRegData(APP_KEY) then exit;
  ret := RegSetValueEx(APP_KEY, PChar(Name), 0,
            REG_BINARY, Buffer, BufSize);
  if ret = ERROR_SUCCESS then
    result := true;
  RegFlushKey(APP_KEY);
  RegCloseKey(APP_KEY);
  APP_KEY := 0;
end;

{*****************************************************************************
*   Function GetRegData
*   Purpose:
*       To get special data from my application registry data
*   Date:
*       New Develop   :   2001-1-11
*       Modified      :   2001-1-11
*   Retrun Value  :
*       True or False , identify whether the operation is Success
*****************************************************************************}
function GetRegData(Name: string;Buffer: Pointer; BufSize: Integer):BOOL;
var
  ret : integer;
  APP_KEY : HKEY;
begin
  result := false;
  if not OpenRegData(APP_KEY) then exit;
  ret := RegQueryValueEx(APP_KEY,PChar(Name),nil,nil,
            PByte(Buffer),@BufSize);
  if ret = ERROR_SUCCESS then result:=true;
  RegCloseKey(APP_KEY);
  APP_KEY := 0;
end;

{******************************************************************************
*   Function SetRegWindowPosOpt(option)
*   Purpose:
*       To save the option of window postion to registry
*   Arguments :
*       Option   : the Window Postion Option should save
*   Date      :
*       New Develop   :   2001-1-10
*       Modified      :
******************************************************************************}
function SetRegWindowPosOpt(option:integer):BOOL;
begin
  result :=
    SetRegData(APP_KEY_SUBPOSOPT,@option,SizeOf(option));
end;

function SetRegAllOnTop(option : boolean):BOOL;
begin
  result :=
    SetRegData(APP_KEY_SUBALLONTOP,@option,SizeOf(option));
end;

function SetRegTransparent(option : boolean):BOOL;
begin
  result :=
    SetRegData(APP_KEY_SUBTRANSPARENT,@option,SizeOf(option));
end;


{******************************************************************************
*   Function SetRegWindowPos(hWnd);
*   Purpose:
*       To save the special window's postion to Registry
*   Arguments:
*       hWnd    :   The Special Window's handle
*   Date    :
*       New Develop : 2001-1-9
*       Modified    :
******************************************************************************}
function SetRegWindowPos(hWnd : HWND):BOOL;
var
  Value : TMyWindowPos;
  rect  : TRect;
begin
  GetWindowRect(hWnd,rect);
  Value.Top := rect.Top;
  Value.Left := rect.Left;
  Value.Width := rect.Right - rect.Left;
  result := SetRegData(APP_KEY_SUBPOS,@Value,SizeOf(Value));
end;

function SetRegShowTray(option : boolean):BOOL;
begin
  result := SetRegData(APP_KEY_SUBSHOWTRAY,@option,SizeOf(option));
end;

function SetRegClockStyle(option : integer):BOOL;
begin
  result := SetRegData(APP_KEY_SUBCLOCKSTYLE,@option,SizeOf(option));
end;

function SetRegShowOnTaskBar(option : boolean):BOOL;
begin
  result := SetRegData(APP_KEY_SUBSHOWONTASKBAR,@option,SizeOf(option));
end;
{******************************************************************************
*   Function GetRegWindowPosOpt(var Option)
*   Purpose:
*       To get the window's postion option from registry
*   Arguments:
*       Var option  :  the return postion
*   Date    :
*       New development   : 2001-1-10
*       Modified          : 2001-1-11
******************************************************************************}
function GetRegWindowPosOpt(var Option : integer):BOOL;
begin
  result := true;
  if not GetRegData(APP_KEY_SUBPOSOPT,@Option,SizeOf(Option)) then
  begin
    Option := ID_OPTION_MIDDLECENTER;
    SetRegWindowPosOpt(Option);
  end;
end;

{******************************************************************************
*   Function GetRegWindowPos(var Valu);
*   Purpose:
*       To Get The Appliation's Window's Postion from Registry
*   Arguments:
*       the return Windows postion if it is success, or if false, the default
*       Value will be return in Value
*   Date    :
*       New Develop   :   2001-1-9
*       Modified      :   2001-1-11
******************************************************************************}
function GetRegWindowPos(var Value:TMyWindowPos):BOOL;
{var
  bmp:HBITMAP;
  bmpSize : BITMAP;}
begin
  result := true;
  if not GetRegData(APP_KEY_SUBPOS,@Value,SizeOf(Value)) then
    Value := DEFAULTPOS;
  {
  bmp := LoadBitmap(hInstance,'BITMAP_CLOCK');
  GetObject(bmp,sizeof(bmpSize),@bmpSize);
  DeleteObject(bmp);
  Value.Width := bmpSize.bmWidth;
  }
  WIN_HALF_WIDTH := Value.Width div 2;
end;

{******************************************************************************
*   Function GetPlacePos(var Pos)
*   Purpose:
*       To Adjust the window's Postoin by Pos and Postion Option
*   Arguments:
*       Var Pos: The return postion of window
*   Date    :
*       New Development :   2001-1-10
*       Modified        :   2001-1-11
******************************************************************************}
function GetPlacePos(var Pos:TMyWindowPos):BOOL;
var
  opt ,
  ScrW,
  ScrH: integer;

    function GetScreenWH(var Width,Height:integer):BOOL;
    begin
      result := true;
      Width := GetSystemMetrics(SM_CXFULLSCREEN);
      Height := GetSystemMetrics(SM_CYFULLSCREEN);
    end;

begin
  result := true;
  GetRegWindowPos(Pos);
  GetRegWindowPosOpt(opt);
  GetScreenWH(ScrW,ScrH);
  Case Opt of
    ID_OPTION_TOPLEFT:
      begin
        Pos.Top   := 0;
        Pos.Left  := 0;
      end;
    ID_OPTION_TOPCENTER:
      begin
        Pos.Top   := 0;
        Pos.Left  := (ScrW - Pos.Width) div 2;
      end;
    ID_OPTION_TOPRIGHT:
      begin
        Pos.Top   := 0;
        Pos.Left  := ScrW - Pos.Width;
      end;
    ID_OPTION_MIDDLELEFT:
      begin
        Pos.Top   := (ScrH - Pos.Width) div 2;
        Pos.Left  := 0;
      end;
    ID_OPTION_MIDDLECENTER:
      begin
        Pos.Top   := (ScrH - Pos.Width) div 2;
        Pos.Left  := (ScrW - Pos.Width) div 2;
      end;
    ID_OPTION_MIDDLERIGHT:
      begin
        Pos.Top   := (ScrH - Pos.Width) div 2;
        Pos.Left  := ScrW - Pos.Width;
      end;
    ID_OPTION_BOTTOMLEFT:
      begin
        Pos.Top   := ScrH - Pos.Width;
        Pos.Left  := 0;
      end;
    ID_OPTION_BOTTOMCENTER:
      begin
        Pos.Top   := ScrH - Pos.Width;
        Pos.Left  := (ScrW - Pos.Width) div 2;
      end;
    ID_OPTION_BOTTOMRIGHT:
      begin
        Pos.Top   := ScrH - Pos.Width;
        Pos.Left  := ScrW - Pos.Width;
      end;
    ID_OPTION_USERPLACE:
      begin
        // Autojust the position
        if Pos.Top < 0 then Pos.Top := 0;
        if Pos.Left <0 then Pos.Left := 0;
        if Pos.Top > (ScrH - Pos.Width) then
          Pos.Top := ScrH - Pos.Width;
        if Pos.Left > (ScrW - Pos.Width) then
          Pos.Left := ScrW - Pos.Width;
      end;
  end;
end;

{*****************************************************************************
*   Function GetRegAllOnTop
*   Purpose:
*       To get whether window Show All On Top is set
*   Date:
*       New Develop   :   2001-1-11
*       Modified      :   2001-1-11
*****************************************************************************}
function GetRegAllOnTop(var bOnTop:Boolean):BOOL;
begin
  result := true;
  if not GetRegData(APP_KEY_SUBALLONTOP,@bOnTop,SizeOf(bOnTop)) then
  begin
    bOnTop := True;
    SetRegAllOnTop(bOnTop);
  end;
end;

{*****************************************************************************
*   Function GetRegTransparent
*   Purpose:
*       To get whether window Show transparent is set
*   Date:
*       New Develop   :   2001-1-11
*       Modified      :   2001-1-11
*****************************************************************************}
function GetRegTransparent(var bTrans:Boolean):BOOL;
begin
  result := true;
  if not GetRegData(APP_KEY_SUBTRANSPARENT,@bTrans,SizeOf(bTrans)) then
  begin
    bTrans := true;
    SetRegTransparent(bTrans);
  end;
end;

{*****************************************************************************
*   Function GetRegShowTray
*   Purpose:
*       To get whether window Show in Tran Area is set
*   Date:
*       New Develop   :   2001-1-11
*       Modified      :   2001-1-11
*****************************************************************************}
function GetRegShowTray(var bOnTray:Boolean):BOOL;
begin
  result := true;
  if not GetRegData(APP_KEY_SUBSHOWTRAY,@bOnTray,SizeOf(bOnTray)) then
  begin
    bOnTray := true;
    SetRegShowTray(bOnTray);
  end;
end;

function GetRegClockStyle(var option:integer):BOOL;
begin
  result := true;
  if not GetRegData(APP_KEY_SUBCLOCKSTYLE,@option,SizeOf(option)) then
  begin
    option := IDM_CIRCLK;
    SetRegClockStyle(option);
  end;
end;

function GetRegShowOnTaskBar(var bShown : boolean):BOOL;
begin
  result := true;
  if not GetRegData(APP_KEY_SUBSHOWONTASKBAR,@bShown,SizeOf(bShown)) then
  begin
    bShown := false;
    SetRegShowOnTaskBar(bShown);
  end;
end;

function GetCheckBitmaps(fuCheck:UINT; menuID:integer):HBITMAP;
var
  crBackground : COLORREF;
  hbrBackground : HBRUSH;
  hbrTargetOld : HBRUSH;
  hdcSource, hdcTarget : HDC;
  bmCheckBox : BITMAP;
  hbmpCheckBoxes,
  hbmpSourceOld,
  hbmpTargetOld,
  hbmpCheck : HBITMAP;
  rc : TRECT;
  wBitmapX,wBitmapY : WORD;
begin
  // Get the Menu background color and crate a solid brush with this color
  crBackground := GetSysColor(COLOR_MENU);
  hbrBackground := CreateSolidBrush(crBackground);

  // Create memory device contexts for the source and destination bitmaps

  hdcSource := CreateCompatibleDC(0);
  hdcTarget := CreateCompatibleDC(hdcSource);

  // Get the size of the system defalt check-mark bitmap and
  // create a compatible bitmap of the same size
  wBitmapX := GetSystemMetrics(SM_CXMENUCHECK);
  wBitmapY := GetSystemMetrics(SM_CYMENUCHECK);
  hbmpCheck := CreateCompatibleBitmap(hdcSource,wBitmapX,wBitmapY);

  // select the background bursh and bitmap into the target DC
  hbrTargetOld := SelectObject(hdcTarget, hbrBackground);
  hbmpTargetOld := SelectObject(hdcTarget, hbmpCheck);

  // use the selected brush to initialize the background color
  // of the bitmap in the target device context

  PatBlt(hdcTarget, 0, 0, wBitmapX, wBitmapY, PATCOPY);

  // load the predefined check box bitmaps and select it
  // into the source DC
  hbmpCheckBoxes := //LoadImage(hInstance,'ICON_MENUCLKSET',IMAGE_ICON,0,0,
      //LR_DEFAULTSIZE);
      LoadBitmap(hInstance,'BITMAP_MENUCLKSET');
  hbmpSourceOld := SelectObject(hdcSource, hbmpCheckBoxes);

  // fill a BITMAP structrure with information about the
  // check box bitmaps and then find the upper-left corner of
  // the unchecked check box or the checked check box

  GetObject(hbmpCheckBoxes, sizeof(bmCheckBox), @bmCheckBox);
  if fuCheck = MF_CHECKED then begin
    rc.left := 0;
    rc.right := bmCheckBox.bmWidth;
  end
  else begin
    rc.Left := 0;
    rc.Right := bmCheckBox.bmWidth;
  end;
  rc.Top := 0;
  rc.Bottom := bmCheckBox.bmHeight ;

  // copy the appropriate bitmap into the target DC. if the
  // check-box bitmap is larger than the default check-mark
  // bitmap, use StrechBlt to make it fit; otherwise , just
  // Copy it

  if ( rc.Right - rc.Left > wBitmapX) or
     ( rc.Bottom - rc.Top > wBitmapY) then
  begin
    StretchBlt(hdcTarget, 0, 0, wBitmapX, wBitmapY,
        hdcSource, rc.left, rc.top, rc.right - rc.left,
        rc.bottom - rc.top, SRCCOPY);
  end
  else begin
    BitBlt(hdcTarget, 0, 0, rc.right - rc.left,
        rc.bottom - rc.top,
        hdcSource, rc.left, rc.top, SRCCOPY);
  end;

  // select the old source and destination bitmaps into the
  // source and destination DCs and then delete the DCs and
  // the background brush

  SelectObject(hdcSource, hbmpSourceOld);
  SelectObject(hdcTarget, hbrTargetOld);
  hbmpCheck := SelectObject(hdcTarget, hbmpTargetOld);

  DeleteObject(hbrBackground);
  DeleteObject(hdcSource);
  DeleteObject(hdcTarget);

  // return a handle to the new check-mark bitmap

  result := hbmpCheck;
end;

function SetMenuOwnerDraw(menu : HMENU; cmdID : integer):BOOL;
var
  menuInfo : TMENUITEMINFO;
begin
  result := false;
  if menu = 0 then exit;
  //if not GetMenuItemInfo(menu, cmdID, FALSE, menuInfo) then exit;
  menuInfo.cbSize := SizeOf(menuInfo);
  menuInfo.fMask := MIIM_CHECKMARKS or MIIM_DATA or MIIM_ID or
        MIIM_STATE or MIIM_SUBMENU or MIIM_TYPE;
  menuInfo.fType := MFT_OWNERDRAW;
  menuInfo.wID := cmdID;
  menuInfo.fState := MFS_DEFAULT;
  menuInfo.hSubMenu := 0;
  menuInfo.hbmpChecked := 0;
  menuInfo.hbmpUnchecked := 0;
  menuInfo.hbmpItem := 0;
  menuInfo.dwItemData := 0;
  menuInfo.dwTypeData := 'Hello';
  SetMenuItemInfo(menu, cmdID, FALSE, menuInfo);
end;

function DrawBmpMenu(itemMenu : DRAWITEMSTRUCT):BOOL;
var
  orgrect, rG, rect: TRect;
  p : TPoint;
  DC : HDC;
  bmpDC : HDC;
  lb : LOGBRUSH;
  oldBrush,Brush : HBRUSH;
  oldbmp,bmp,bufBmp : HBITMAP;
  BKcolor,txtColor : DWORD;
  oldRight : integer;
  i : integer;
begin
  rect := itemMenu.rcItem;
  //DC := CreateCompatibleDC(itemMenu.hDC);
  DC := itemMenu.hDC;
  {
  bufBmp := CreateCompatibleBitmap(DC,
      rect.right - rect.left,rect.bottom-rect.top);
  SelectObject(DC,bufBmp);
  }
  //Brush := CreateSolidBrush(GetSysColor(COLOR_MENU));
  //SelectObject(DC,brush);
  //DeleteObject(brush);
  //DC := itemMenu.hDC;
  orgrect := rect;
  {
  rect.Bottom := rect.Bottom -rect.Top;
  rect.Right := rect.Right - rect.left;
  rect.top := 0;
  rect.left := 0;
  }
  bmpDC := CreateCompatibleDC(DC);
  if  (itemMenu.itemAction = ODA_DRAWENTIRE) then  begin
    BKcolor := GetSysColor(COLOR_MENU);
    txtColor := GetSysColor(COLOR_MENUTEXT);
  end
  else if itemMenu.itemAction = ODA_SELECT then begin
    if not BOOL(itemMenu.itemState and ODS_SELECTED) then begin
      BKcolor := GetSysColor(COLOR_MENU);
      txtColor := GetSysColor(COLOR_MENUTEXT);
    end
    else begin
      BKcolor := GetSysColor(COLOR_HIGHLIGHT);
      txtColor := GetSysColor(COLOR_HIGHLIGHTTEXT);
    end;
  end;

  {
  rG := rect;
  Inc(rG.Left, 20);
  if BKColor = GetSysColor(COLOR_HIGHLIGHT) then begin
    for i:= 1 to 120 do begin
      Brush := CreateSolidBrush(GetSysColor(COLOR_HIGHLIGHT) +
        i*(Abs(GetSysColor(COLOR_HIGHLIGHT)-GetSysColor(COLOR_MENU)) div 120));
      rG.Left := rg.Left +(rect.right-rect.left-20) div 120;
      rG.right := rG.Left + (rect.right - rect.left - 20) div 120;
      FillRect(DC,rG,Brush);
      DeleteObject(Brush);
    end;
  end else begin }
    Brush := CreateSolidBrush(DWORD(BKcolor));
    FillRect(DC,rect,Brush);
    DeleteObject(Brush);
 { end; }
  rG := rect;
  rG.Right := rect.Left +19;
  Brush := CreateSolidBrush(GetSysColor(COLOR_MENU));
  FillRect(DC,rG,Brush);
  DeleteObject(Brush);
  bmp := LoadBitmap(hInstance,'BITMAP_MENUCLKSET');
  oldbmp := SelectObject(bmpDC,bmp);
  Bitblt(DC,rect.left+3,rect.top+4,12,12,bmpDC,0,0,SRCCOPY);
  SetBkColor(DC,BKcolor);
  SetTextColor(DC,txtColor);
  TextOut(DC,rect.left + 22,rect.top+2,'Clock setting',13);
  if BKColor = GetSysColor(COLOR_HIGHLIGHT) then
  begin
    Brush := CreateSolidBrush(RGB(255,0,0));
    Inc(rect.Left,18);
    FrameRect(DC,rect,Brush);
    DeleteObject(Brush);
    Dec(rect.Left,18);
    OldRight := rect.Right;
    rect.Right := rect.Left + 17;
    DrawEdge(DC,rect,EDGE_RAISED,BF_RECT);
    rect.Right := OldRight;
  end;
  {
  BitBlt(itemMenu.hDC,orgrect.Left,orgrect.Top,
          orgrect.Right - orgrect.Left,
          orgrect.Bottom - orgrect.top,
          DC,rect.Left,rect.top,SRCCOPY);
  }
  SelectObject(bmpDC,oldbmp);
  DeleteDC(bmpDC);
  {DeleteDC(DC);}
  {DeleteObject(bufBmp);}
  DeleteObject(bmp);

end;

function CreateRgnFromBmp(bmp : HBITMAP):HRGN;
var
  bmpSize : BITMAP;
  oldbmp : HBITMAP;
  R , R1: HRGN;
  DC : HDC;
  transColor : COLORREF;
  iWidth, iHeight, oldHeight : integer;
begin
  GetObject(bmp,SizeOf(bmpSize),@bmpSize);
  R := CreateRectRgn(0,0,bmpSize.bmWidth, bmpSize.bmHeight);
  DC := CreateCompatibleDC(0);
  oldbmp := SelectObject(DC,bmp);
  transColor := GetPixel(DC,0,0);

  for iWidth:=0 to bmpSize.bmWidth -1 do
  begin
    iHeight := 0;
    while iHeight < bmpSize.bmHeight do
    //for iHeight := 0 to bmpSize.bmHeight -1 do
    begin
      if GetPixel(DC,iWidth,iHeight) = transColor then
      begin
        oldHeight := iHeight;
        while (iHeight<bmpSize.bmHeight) and
              (GetPixel(DC,iWidth,iHeight+1)=transColor) do
                  inc(iHeight);
        R1 := CreateRectRgn(iWidth,oldHeight,iWidth + 1,iHeight + 1);
        CombineRgn(R,R,R1,RGN_DIFF);
        DeleteObject(R1);
      end else ;
        inc(iHeight);
    end;
  end;
  SelectObject(DC,oldBmp);
  DeleteDC(DC);
  result := R;
end;

function CreateAlfaRgn(x,y,r,Alfa,halfWidth,ArrowLen:integer):HRGN;
var
  Ps : Array[1..5] of TPoint;
  deg : double;
begin
  deg := Alfa * (2*pi)/360;
  Ps[1].x := Trunc(x - HalfWidth * sin(deg));
  Ps[1].y := Trunc(y - HalfWidth * cos(deg));
  Ps[2].x := Trunc(x + (r - ArrowLen) * cos(deg) - HalfWidth * sin(deg));
  Ps[2].y := Trunc(y - (r - ArrowLen) * sin(deg) - HalfWidth * cos(deg));
  Ps[3].x := Trunc(x + r * cos(deg));
  Ps[3].y := Trunc(y - r * sin(deg));
  Ps[4].x := Trunc(x + (r - ArrowLen) * cos(deg) + HalfWidth * sin(deg));
  Ps[4].y := Trunc(y - (r - ArrowLen) * sin(deg) + HalfWidth * cos(deg));
  Ps[5].x := Trunc(x + HalfWidth * sin(deg));
  Ps[5].y := Trunc(y + HalfWidth * cos(deg));
  result := CreatePolygonRgn(Ps, 5, WINDING);
end;

function CreateHourRgn(hour,minute:integer):HRGN;
var
  d : double;
  Alfa : integer;
begin
  d := hour + minute / 60;
  if (d - 12) > 0.001 then d:= d -12;
  Alfa := Trunc(6 * (15 - d * 5));
  result :=
    CreateAlfaRgn(WIN_HALF_WIDTH, WIN_HALF_WIDTH, WIN_HALF_WIDTH - 17,
      Alfa, 3, 5);

  if BOOL(RgnCenter) then
    CombineRgn(Result,Result,RgnCenter,RGN_DIFF);

end;

function CreateMinuteRgn(minute:integer):HRGN;
var
  Alfa : integer;
begin
  Alfa := (15 - minute) * 6;
  result :=
    CreateAlfaRgn(WIN_HALF_WIDTH, WIN_HALF_WIDTH, WIN_HALF_WIDTH - 12,
      Alfa, 2, 4);

  if BOOL(RgnCenter) then
    CombineRgn(Result,Result,RgnCenter,RGN_DIFF);
  
end;

function CreateSecondRgn(second:integer):HRGN;
var
  Alfa : integer;
begin
  Alfa := ( 15 - second) * 6;
  result :=
    CreateAlfaRgn(WIN_HALF_WIDTH, WIN_HALF_WIDTH, WIN_HALF_WIDTH - 5,
      Alfa, 1, 0);

  if BOOL(RgnCenter) then
    CombineRgn(Result,Result,RgnCenter,RGN_DIFF);
  
end;

end.
