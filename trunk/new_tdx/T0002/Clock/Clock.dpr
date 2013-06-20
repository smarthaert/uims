{******************************************************************************
*   Program Clock
*   Description:
*       To show a transparent window as a clock on desktop.
*       Support time schedule
*   CopyRight (C) Nanjing Fujitsu Nanda SoftWare Tech. Co., Ltd
*   CopyRight (C) GanHuaXin 2001-1-8
*   Code Tool   :   Delphi 5.0
*   All code is writen by SDK
*   All Rignt Reserved!
*   Date  :
*       New Develop   : 2001-1-8
*       Modify        : 2001-1-9
******************************************************************************}

program Clock;

uses
  Windows,
  Messages,
  untTool in 'untTool.pas',
  untConst in 'untConst.pas',
  untMsgHdl in 'untMsgHdl.pas',
  untHint in 'untHint.pas';

{$R Gan_SDK.RES}

{******************************************************************************
*   Function InitApplication(hInstance)
*   Purpose:
*       Initial Appliaction and Register the window class
*   Parmeters:
*       hInstance     :   Application Instance Handle
*   Return Value:
*       it return the RegisterClass()'s return's Value
******************************************************************************}
function InitApplication(hInstance : THANDLE):bool;
var
  ParentWndClass : TWndClass;
  WndClass : TWndClass;
begin
  ParentWndClass.hInstance := hInstance;
  With ParentWndClass do begin
    style := 0;
    lpfnWndProc := @ParentMainProc;
    cbClsExtra := 0;
    cbWndExtra := 0;
    hCursor := LoadCursor(0,IDC_ARROW);
    lpszMenuName := nil;
    hbrBackground := GetStockObject(BLACK_BRUSH);
    hIcon := LoadIcon(hInstance,'ICON_APP');
    lpszClassName := 'GanParentClock';
  end;

  WndClass.style := 0;
  WndClass.lpfnWndProc := @MainProc;
  WndClass.cbClsExtra := 0;
  WndClass.cbWndExtra := 0;
  WndClass.hInstance := hInstance;
  WndClass.hCursor := LoadCursor(0,IDC_HAND);
  WndClass.lpszMenuName := nil;
  WndClass.hbrBackground := GetStockObject(BLACK_BRUSH);
  WndClass.hIcon := //LoadIcon(0,IDI_APPLICATION	);
            LoadIcon(hInstance,'ICON_APP');
  WndClass.lpszClassName := 'GanClock';
  result := BOOL(RegisterClass(WndClass) and RegisterClass(ParentWndClass));
end;

{******************************************************************************
*   Function InitWindow(hWnd)
*   Purpose:
*       To initial the Window whose handle equal hWnd
*   Date  :
*       New Development   : 2001-01-08
*       Modiefied         :
******************************************************************************}
function InitWindow(hWnd:HWND):BOOL;
var
  WinRect : TRect;
  bOpt    : Boolean;
  dwStyle : integer;
begin
  //
  // to set the window Region
  //
  result := false;
  if hWnd = 0 then exit;
  if not GetWindowRect(hWnd,WinRect) then exit;
  WinRect.Right := WinRect.Right - WinRect.Left;
  WinRect.Bottom := WinRect.Bottom - WinRect.Top;
  WinRect.Top := 0;
  WinRect.Left := 0;

  //
  // Set Special Style
  //
  SetWindowLong(hWnd,GWL_STYLE,378470400 xor WS_THICKFRAME
      xor WS_MAXIMIZEBOX xor WS_BORDER xor WS_MINIMIZEBOX or WS_POPUP);
  //
  // Set whether window all with on top?
  //
  GetRegAllOnTop(bOpt);
  SetWindowAllOnTop(hWnd,bOpt);
  //
  // determine whether Set a icon on tray area
  //
  GetRegShowTray(bOpt);
  if bOpt then
    ShowOnTray(hWnd);
  GetRegShowOnTaskBar(bOpt);
  if bOpt then
    ShowWindow(ParentWnd,SW_SHOW)
  else
    ShowWindow(ParentWnd,SW_HIDE);
  //
  // Set whether transparent ?
  //
  GetRegTransparent(bOpt);
  SetWindowTransparent(hWnd,not bOpt);
  SetWindowTransparent(hWnd,bOpt);

  result := true;
end;


{******************************************************************************
*   Fuction InitInstance(hInstance:THandle,nCmdShow:INT,hWnd:THANDLE)
*   Purpose:
*       To create the registered windows and show it as nCmdShow
*   Parmeters:
*       hInstance     :   Application Instance
*       nCmdShow      :   The Window Show Method
*       hWnd          :   The created Window Handle
*   Return Value:
*       if success create the window return the window's handle
*       else return 0
******************************************************************************}
function InitInstance(
    hInstance:THANDLE;
    nCmdShow:integer;
    var hWnd:THandle):bool;
var
  RegWindowPos : TMyWindowPos;
  SysMenu : HMENU;
  //ParentWnd : THandle;
begin
  // at first , creat a UnVisible parent window
  ParentWnd := CreateWindow(
              'GanParentClock',
              'Huiyu Clock',
              WS_CLIPSIBLINGS or WS_SYSMENU,
              -20,-20,0,0,
              0,0,hInstance,nil);
  if ParentWnd = 0 then begin
    result := false;
    exit;
  end;
  // to modify the System Menu ! Cool!
  SysMenu := GetSystemMenu(ParentWnd,False);
  DeleteMenu(SysMenu,SC_MOVE,MF_BYCOMMAND);
  DeleteMenu(SysMenu,SC_MAXIMIZE,MF_BYCOMMAND);
  DeleteMenu(SysMenu,SC_MINIMIZE,MF_BYCOMMAND);
  DeleteMenu(SysMenu,SC_SIZE,MF_BYCOMMAND);
  DeleteMenu(SysMenu,SC_RESTORE,MF_BYCOMMAND);
  DeleteMenu(SysMenu,0,MF_BYPOSITION);
  InsertMenu(SysMenu,1,MF_STRING or MF_BYPOSITION,IDM_ABOUT,'About');
  InsertMenu(SysMenu,1,MF_STRING or MF_BYPOSITION,IDM_OPTION,'Option');
  InsertMenu(SysMenu,1,MF_SEPARATOR or MF_BYPOSITION,0,'');

  // then create my self clock window
  GetPlacePos(RegWindowPos);
  hWnd := CreateWindow(
              'GanClock',
              'Hello World!This is a test for sdk program!',
              WS_POPUP or WS_VISIBLE or WS_OVERLAPPED or WS_CLIPSIBLINGS,
              RegWindowPos.Left,
              RegWindowPos.Top,
              RegWindowPos.Width,
              RegWindowPos.Width,
              ParentWnd,//}0,
              0,
              hInstance,
              nil
  );
  if (hWnd<>0) then
  begin
    ClockWnd := hWnd;
    InitWindow(hWnd);
    ShowWindow(hWnd,nCmdShow);
    SetClockWalk(hWnd);
    result := BOOL(True);
  end else
    result := BOOL(false);
end;

//
// Main procedure entry point
//
var
  hWnd  : LongWord;
  Msg   : TMsg;
begin
  //hInstance is the golbal var defined in sysinit.pas
  if not InitApplication(hInstance) then halt;
  if not InitInstance(hInstance,SW_SHOW,hWnd) then halt;
  //RegisterServiceProcess(GetCurrentProcessID, 1);
  while GetMessage(Msg,0,0,0) do
  begin
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  end;
end.
