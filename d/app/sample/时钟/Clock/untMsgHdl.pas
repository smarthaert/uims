{******************************************************************************
*   Uint untMsgHdl
*   This module is to define the Messages on Clock Application should
*   Deal with
*   CopyRight (C) Nanjing Fujitsu Nanda SoftWare Tech. Co., Ltd.
*   CopyRight (C) By GanHuaXin 2001
*   All Right Reserved
*   Email : huiyuMag@263.net
*   Date:
*       New Develop : 2001-1-9
*       Modify      : 2001-1-9
******************************************************************************}
unit untMsgHdl;

interface

uses
  Windows,
  Messages,
  untConst,
  untTool,
  untHint,
  Sysutils,
  ShellAPI;


function ParentMainProc(
    hWnd:LongWord;
    Message:LongWord;
    wParam:WPARAM;
    lParam:LPARAM
    ):BOOL;stdcall;
function MainProc(hWnd:LongWord;
                  Message : LongWord;
                  wParam  : WPARAM;
                  lParam  : LPARAM):BOOL;stdcall;

implementation

//
// some function forward announce
//
function DlgAboutProc(hDlg: THandle;
                  Msg     : LongWord;
                  wParam  : WPARAM;
                  lParam  : LPARAM):BOOL;stdcall;forward;
function DlgOptionProc(hDlg : THandle;
                  Msg       : LongWord;
                  wParam    : WPARAM;
                  lParam    : LPARAM):BOOL;stdcall;forward;
function DlgClockSetProc(hDlg : THandle;
                  Msg       : LongWord;
                  wParam    : WPARAM;
                  lParam    : LPARAM):BOOL;stdcall;forward;

function WMParentGetMinMaxInfo(
                hWnd    : THandle;
                Msg     : LongWord;
                wParam  : WPARAM;
                lParam  : LPARAM):BOOL;stdcall;
var
  info : ^MINMAXINFO;
begin
  result := BOOL(0);
  info := Pointer(lParam);
  info^.ptMaxSize.x := GetSystemMetrics(SM_CXFULLSCREEN);
  info^.ptMaxSize.y := GetSystemMetrics(SM_CYFULLSCREEN);
  info^.ptMinTrackSize.x := 0;
  info^.ptMinTrackSize.y := 0;
  info^.ptMaxTrackSize.x := GetSystemMetrics(SM_CXFULLSCREEN);
  info^.ptMaxTrackSize.y := GetSystemMetrics(SM_CYFULLSCREEN);
end;


function ParentMainProc(
    hWnd:LongWord;
    Message:LongWord;
    wParam:WPARAM;
    lParam:LPARAM
    ):BOOL;stdcall;
begin
  case Message of
    WM_CLOSE :
      begin
        PostQuitMessage(0);
        result := BOOL(0);
      end;
    WM_GETMINMAXINFO:
      result := WMParentGetMinMaxInfo(hWnd,Message,wParam,lParam);
    WM_SYSCOMMAND:
      begin
        case wParam of
          SC_CLOSE:
            begin
              if (MessageBox(hWnd,'Would you like to quit?','Hello :-)',
                MB_YESNO or MB_ICONWARNING) = IDYES) then
                  begin
                     SendMessage(ClockWnd,WM_CLOSE,0,0);
                  end;
            end;
          else
            SendMessage(ClockWnd,WM_COMMAND,wParam,0);
        end;
      end;
    else
      result := BOOL(DefWindowProc(hWnd,Message,wParam,lParam));
  end;
end;

//
//***  The following functions worked for the Main Window of Application  ***
//

{******************************************************************************
*   Function RButtonUpProc(hWnd,Msg,wParam,lParam);
*   Purpose:
*       To Deal with message when user right click mouse on window
*   Date      :  2001-1-9
******************************************************************************}
function WMRButtonUpProc(
    hWnd    :LongWord;
    Msg     :LongWord;
    wParam  :WPARAM;
    lParam  :LPARAM
    ):BOOL;stdcall;
const
  CHECK_BOOL : Array[false..true] of UINT =
    (MF_UNCHECKED, MF_CHECKED);
var
  pMenu:HMENU;
  subMenu:HMENU;
  MousePos:TPoint;
  bTrans,bOnTop:Boolean;
  iClkStyle:integer;
  clksetBmp : HBITMAP;
begin
  pMenu := LoadMenu(hInstance,'MENU_POP');
  if (pMenu<>0) then begin
    subMenu := GetSubMenu(pMenu,0);
    if (subMenu<>0) then begin

      //
      // to set the customer drawn of menu bar
      //
      {
      CheckMenuItem(subMenu,IDM_CLOCKSET, MF_BYCOMMAND or MF_CHECKED);
      clkSetBmp := GetCheckBitmaps(MF_CHECKED,0);
      SetMenuItemBitmaps(subMenu,IDM_CLOCKSET, MF_BYCOMMAND,clkSetBmp,clkSetBmp);
      }
      //SetMenuOwnerDraw(subMenu,IDM_HINTSET);
      SetMenuOwnerDraw(subMenu,IDM_CLOCKSET);
      // set check and radio
      GetRegAllOnTop(bOnTop);
      GetRegTransparent(bTrans);
      CheckMenuItem(subMenu,IDM_ALLONTOP,CHECK_BOOL[bOnTop]);
      CheckMenuItem(subMenu,IDM_TRANSPARENT,CHECK_BOOL[bTrans]);
      CheckMenuItem(subMenu,IDM_STARTWITHWIN,CHECK_BOOL[GetAppAtStart]);
      GetRegClockStyle(iClkStyle);
      CheckMenuRadioItem(GetSubMenu(subMenu,8),IDM_CIRCLK,IDM_DIGCLK,
            iClkStyle,MF_BYCOMMAND);
      GetCursorPos(MousePos);

      TrackPopupMenu(subMenu,
                    TPM_RIGHTALIGN,
                    MousePos.x,
                    MousePos.y,
                    0,hWnd,nil);
      //DeleteObject(hintsetBmp);
      //DeleteObject(clksetBmp);
    end;
    DestroyMenu(pMenu);
  end;
  result := BOOL(true);
end;

function WMMeasureItemProc(hWnd : THandle;
                  Msg       :LongWord;
                  wParam    :WPARAM;
                  lParam    :LPARAM):BOOL;stdcall;
var
  item : ^MEASUREITEMSTRUCT;
begin
  result := TRUE;
  item := Pointer(lParam);
  case item^.CtlType of
    ODT_MENU  :
      begin
        //item^.itemHeight := 46;
        item^.itemHeight := GetSystemMetrics(SM_CYMENU);
        //item^.itemWidth := 200;
      end;
  end;
end;

function WMDrawItemProc(hWnd : THandle;
            Msg     :LongWord;
            wParam  :WPARAM;
            lParam  :LPARAM):BOOL;stdcall;
var
  item : ^DRAWITEMSTRUCT;
begin
  result := TRUE;
  item := Pointer(lParam);
  case item^.CtlType of
    ODT_MENU :
      begin
        DrawBmpMenu(item^);
      end;
  end;
end;
{******************************************************************************
*   Function TrayIconNotifyProc(hWnd,Msg,wParam,lParam);
*   Purpose:
*       To dealwith the message when user do something about TrayIcon
*   Date      : 2001-1-9
******************************************************************************}
function TrayIconNotifyProc(hWnd  :THandle;
                  Msg       :LongWord;
                  wParam    :WPARAM;
                  lParam    :LPARAM):BOOL;stdcall;
var
  mousePos      : TPoint;
begin
  result := BOOL(false);
  case wParam of
    ID_TRAYICON:
      case lParam of
        WM_LBUTTONUP:
          begin
            MessageBox(hWnd,'Mouse Left Button Up','GanClock',MB_OK);
            result := BOOL(true);
          end;
          //ShowWindow(hWnd,Sw_SHOW);
        WM_RBUTTONUP:
          result := WMRButtonUpProc(hWnd,Msg,wParam,lParam);
      end;
  end;
end;

{******************************************************************************
*   Function CommandProc(hWnd,Msg,wParam,lParam);
*   Purpose:
*       To Deal with the COMMAND of Application Such as button,menu,Accelerator
*   Date  : 2001-1-9
******************************************************************************}
function WMCommandProc(hWnd : THandle;
                  Msg     : LongWord;
                  wParam  : WPARAM;
                  lParam  : LPARAM):BOOL;stdcall;
var
  bMenu : boolean;
  iClkStyle : integer;
begin
  if (lParam = 0) then begin  // not from a control
    if (HI(wParam)=0) then begin  // form menu
      case LO(wParam) of
        IDM_QUIT :
          SendMessage(hWnd,WM_SYSCOMMAND,SC_CLOSE,0);
        IDM_ABOUT:
          begin
            //MessageBox(GetFocus(),'Click About Menu','Hello :-)',MB_OK);
            DialogBox(hInstance,'DIALOG_ABOUT',hWnd,@DlgAboutProc);
          end;
        IDM_OPTION:
          //MessageBox(GetFocus(),'Click Option Menu','Hello :-)',MB_OK);
          begin
            DialogBox(hInstance,'DIALOG_OPTION',hWnd,@DlgOptionProc);
          end;
        IDM_ALLONTOP:
          begin
            GetRegAllOnTop(bMenu);
            bMenu := not bMenu;
            SetWindowAllOnTop(hWnd,bMenu);
            SetRegAllOnTop(bMenu);
          end;
        IDM_TRANSPARENT:
          begin
            GetRegTransparent(bMenu);
            bMenu := not bMenu;
            SetWindowTransparent(hWnd,bMenu);
            SetRegTransparent(bMenu);
          end;
        IDM_STARTWITHWIN:
          begin
            SetAppAtStart(not GetAppAtStart());
          end;
        IDM_CIRCLK,
        IDM_DIGCLK:
          begin
            SetRegClockStyle(LO(wParam));
          end;
        IDM_CLOCKSET:
          begin
            GetRegClockStyle(iClkStyle);
            if iClkStyle = IDM_CIRCLK then
              DialogBox(hInstance,'DIALOG_CLOCKCIRSET',hWnd,@DlgClockSetProc)
            else
              DialogBox(hInstance,'DIALOG_CLOCKDIGSET',hWnd,@DlgClockSetProc);
          end;
        IDM_HINTSET:
          begin
          end;
      end;
    end
    else begin                    // form accelerator
    end;
  end;
  result := BOOL(true);
end;



function WMEraseBkgndProc(hWnd : THandle;
                  Msg     : LongWord;
                  wParam  : WPARAM;
                  lParam  : LPARAM):BOOL;stdcall;
var
  dc , tmpDC: HDC;
  p   : TPoint;
  pStru:PAINTSTRUCT;
  pen,oldPen : HPEN;
  bmp , oldBmp: HBITMAP;
  bmpSize : BITMAP;
  brStruct : LOGBRUSH;
  brRgn : HBRUSH;
begin
  dc := GetDC(hWnd);
  // draw the clock frame
  tmpDc := CreateCompatibleDC(DC);
  bmp := LoadBitmap(hInstance,'BITMAP_CLOCK');
  Oldbmp := SelectObject(tmpDC,bmp);
  BitBlt(DC,0,0,2*WIN_HALF_WIDTH,2*WIN_HALF_WIDTH,tmpDC,0,0,SRCCOPY);
  SelectObject(tmpDC,oldbmp);
  DeleteDC(tmpDC);
  DeleteObject(bmp);

  // draw center BMP
  tmpDc := CreateCompatibleDC(DC);
  bmp := LoadBitmap(hInstance,'BITMAP_CLOCKCENTER');
  Oldbmp := SelectObject(tmpDC,bmp);
  GetObject(bmp,SizeOf(bmpSize),@bmpSize);
  BitBlt(DC,WIN_HALF_WIDTH - bmpSize.bmWidth div 2,
    WIN_HALF_WIDTH - bmpSize.bmHeight div 2,
    bmpSize.bmWidth,
    bmpSize.bmHeight,tmpDC,0,0,SRCCOPY);
  SelectObject(tmpDC,oldbmp);
  DeleteDC(tmpDC);
  DeleteObject(bmp);


  // draw hour hand
  brStruct.lbStyle := BS_SOLID;
  brStruct.lbColor := RGB(0,0,255);
  brStruct.lbHatch := 0;
  brRgn := CreateBrushIndirect(brStruct);
  FillRgn(dc,RgnHour,brRgn);
  DeleteObject(brRgn);
  // draw minute hand
  brStruct.lbColor := RGB(0,255,124);
  brRgn := CreateBrushIndirect(brStruct);
  FillRgn(dc,RgnMinute,brRgn);
  DeleteObject(brRgn);
  // draw second hand
  brStruct.lbColor := RGB(255,0,0);
  brRgn := CreateBrushIndirect(brStruct);
  FillRgn(dc,RgnSecond,brRgn);
  DeleteObject(brRgn);

  {
  Pen := CreatePen(PS_SOLID,2,RGB(0,0,255));
  if BOOL(Pen) then
  begin
    oldPen := SelectObject(dc,pen);
  end;
  // draw a circle
  Arc(dc,1,1,2*WIN_HALF_WIDTH-2,2*WIN_HALF_WIDTH-2,
          1,1,1,1);
  // to create a new pen
  DeleteObject(Pen);
  Pen := CreatePen(PS_SOLID,2,RGB(0,255,0));
  SelectObject(dc,Pen);
  // draw two lines
  MoveToEx(dc,0,0,@p);
  LineTo(dc,2*WIN_HALF_WIDTH,2*WIN_HALF_WIDTH);
  MoveToEx(dc,0,2*WIN_HALF_WIDTH,@p);
  LineTo(dc,2*WIN_HALF_WIDTH,0);

  // reback some variable
  SelectObject(dc,oldPen);
  DeleteObject(pen);
  }
  ReleaseDC(hWnd,dc);
  result := BOOL(1);
end;

{******************************************************************************
*   Function WMPaintProc(hWnd,Msg,wParam,lParam);
*   Purpose:
*       To Deal with the WM_PAINT Message
*   Date    :   2001-1-9
******************************************************************************}
function WMPaintProc(hWnd : THandle;
                  Msg     : LongWord;
                  wParam  : WPARAM;
                  lParam  : LPARAM):BOOL;stdcall;
var
  dc , tmpDC: HDC;
  p   : TPoint;
  pStru:PAINTSTRUCT;
  pen,oldPen : HPEN;
  bmp , oldBmp: HBITMAP;
begin
  // initial about the Device

  BeginPaint(hWnd,pStru);
  WMEraseBkgndProc(hWnd,Msg,wParam,lParam);
  (*
  dc := GetDC(hWnd);
  tmpDc := CreateCompatibleDC(DC);
  bmp := LoadBitmap(hInstance,'BITMAP_CLOCK');
  Oldbmp := SelectObject(tmpDC,bmp);
  BitBlt(DC,0,0,2*WIN_HALF_WIDTH,2*WIN_HALF_WIDTH,tmpDC,0,0,SRCCOPY);
  SelectObject(tmpDC,oldbmp);
  DeleteDC(tmpDC);
  DeleteObject(bmp);
  *)
  {
  Pen := CreatePen(PS_SOLID,2,RGB(0,0,255));
  if BOOL(Pen) then
  begin
    oldPen := SelectObject(dc,pen);
  end;
  // draw a circle
  Arc(dc,1,1,2*WIN_HALF_WIDTH-2,2*WIN_HALF_WIDTH-2,
          1,1,1,1);
  // to create a new pen
  DeleteObject(Pen);
  Pen := CreatePen(PS_SOLID,2,RGB(0,255,0));
  SelectObject(dc,Pen);
  // draw two lines
  MoveToEx(dc,0,0,@p);
  LineTo(dc,2*WIN_HALF_WIDTH,2*WIN_HALF_WIDTH);
  MoveToEx(dc,0,2*WIN_HALF_WIDTH,@p);
  LineTo(dc,2*WIN_HALF_WIDTH,0);

  // reback some variable
  SelectObject(dc,oldPen);
  DeleteObject(pen);
  }
  (*
  ReleaseDC(hWnd,dc);
  *)
  result := true;
  EndPaint(hWnd,pStru);

  //result := BOOL(DefWindowProc(hWnd,Msg,wParam,lParam));
end;

{******************************************************************************
*   Function WMSysCommandProc(hWnd,Msg,wParam,lParam);
*   Purpose:
*       To shield the WM_SYSCOMMAND of SC_MINIMIZE and SC_MAXIMIZE
*   Date  :   2001-1-9
******************************************************************************}
function WMSysCommandProc(hWnd:THandle;
                  Msg     : LongWord;
                  wParam  : WPARAM;
                  lParam  : LPARAM):BOOL;stdcall;
begin
  //result := false;
  case wParam of
    SC_MINIMIZE,
    SC_MAXIMIZE:
      begin
        MessageBox(GetFocus,'heel','hel',MB_OK);
        result := true;
      end;
    SC_CLOSE:
      begin
        if (MessageBox(GetFocus(),
            'Would you like to quit?',
            'Hello :-)',
            MB_YESNO or MB_ICONWARNING) = IDYES) then
        begin
          SendMessage(hWnd,WM_CLOSE,0,0);
        end;
      end;
    else
      result := BOOL(DefWindowProc(hWnd,Msg,wParam,lParam));
  end;
end;


function WMMyPosChange(
                  hWnd    : THandle;
                  Msg     : LongWord;
                  wParam  : WPARAM;
                  lParam  : LPARAM):BOOL;stdcall;
var
  Pos : TMyWindowPos;
  dwStyle : Integer;
begin
  GetPlacePos(Pos);
  dwStyle := GetWindowLong(hWnd,GWL_STYLE);
  MoveWindow(hWnd,Pos.Left,Pos.Top,Pos.Width,Pos.Width,True);
  SetWindowLong(hWnd,GWL_STYLE,dwStyle);
  //InitWindow(hWnd);
  result := true;

end;

function WMCloseProc(
                  hWnd    : THandle;
                  Msg     : LongWord;
                  wParam  : WPARAM;
                  lParam  : LPARAM):BOOL;stdcall;
var
  bOpt : boolean;
begin
  SetRegWindowPos(hWnd);
  CloseClockWalk(hWnd);
  //GetRegShowTray(bOpt);
  //if bOpt then
  DelOnTray(hWnd);
  if BOOL(RgnFrame) then DeleteObject(RgnFrame);
  if BOOL(RgnCenter) then DeleteObject(RgnCenter);
  if BOOL(RgnHour) then DeleteObject(RgnHour);
  if BOOL(RgnMinute) then DeleteObject(RgnMinute);
  if BOOL(RgnSecond) then DeleteObject(RgnSecond);
  PostQuitMessage(0);
  result := BOOL(0);
end;

function WMGetMinMaxInfo(
                hWnd    : THandle;
                Msg     : LongWord;
                wParam  : WPARAM;
                lParam  : LPARAM):BOOL;stdcall;
var
  info : ^MINMAXINFO;
begin
  result := BOOL(0);
  info := Pointer(lParam);
  info^.ptMaxSize.x := GetSystemMetrics(SM_CXFULLSCREEN);
  info^.ptMaxSize.y := GetSystemMetrics(SM_CYFULLSCREEN);
  info^.ptMinTrackSize.x := 6;
  info^.ptMinTrackSize.y := 6;
  info^.ptMaxTrackSize.x := GetSystemMetrics(SM_CXFULLSCREEN);
  info^.ptMaxTrackSize.y := GetSystemMetrics(SM_CYFULLSCREEN);
end;

function WMCreateProc(hWnd : THandle;
                  Msg     : LongWord;
                  wParam  : WPARAM;
                  lParam  : LPARAM):BOOL;stdcall;
var
  bmp : HBITMAP;
  bmpSize : BITMAP;
  hRgn {, RgnCenter}: THandle;
  time : SYSTEMTIME;
begin
  //
  // to initial the region if window is create from a bitmap !!
  //
  bmp := LoadBitmap(hInstance,'BITMAP_CLOCK');
  RgnFrame := CreateRgnFromBmp(bmp);
  DeleteObject(bmp);

  bmp := LoadBitmap(hInstance,'BITMAP_CLOCKCENTER');
  RgnCenter := CreateRgnFromBmp(bmp);
  GetObject(bmp,SizeOf(bmpSize),@bmpSize);
  OffsetRgn(RgnCenter,WIN_HALF_WIDTH - bmpSize.bmWidth div 2,
    WIN_HALF_WIDTH - bmpSize.bmHeight div 2);
  DeleteObject(bmp);
  // combone two regins as RgnFrame
  CombineRgn(RgnFrame,RgnFrame,RgnCenter,RGN_OR);
  //DeleteObject(RgnCenter);

  GetLocalTime(time);
  RgnHour := CreateHourRgn(time.wHour,time.wMinute);
  RgnMinute := CreateMinuteRgn(time.wMinute);
  RgnSecond := CreateSecondRgn(time.wSecond);
  LastMinute := time.wMinute;
  LastSecond := time.wSecond;

  hRgn := CreateRectRgn(0,0,0,0);
  CombineRgn(hRgn,RgnFrame,hRgn,RGN_OR);
  CombineRgn(hRgn,RgnHour,hRgn,RGN_OR);
  CombineRgn(hRgn,RgnMinute,hRgn,RGN_OR);
  CombineRgn(hRgn,RgnSecond,hRgn,RGN_OR);
  SetWindowRgn(hWnd,hRgn,TRUE);
  DeleteObject(hRgn);

  result := BOOL(0);
end;

{******************************************************************************
*   Function WMTimeChangeProc
*   Description:
*       This function will called when system time is changed
******************************************************************************}
function WMTimeChangeProc(hWnd : THandle;
                  Msg     : LongWord;
                  wParam  : WPARAM;
                  lParam  : LPARAM):BOOL;stdcall;
var
  time : SYSTEMTIME;
  hRgn  : THandle;
begin
  CloseClockWalk(hWnd);
  result := BOOL(0);
  //MessageBox(Getfocus,'System time changed','HuiyuClock',MB_OK);
  if BOOL(RgnHour) then DeleteObject(RgnHour);
  if BOOL(RgnMinute) then DeleteObject(RgnMinute);
  if BOOL(RgnSecond) then DeleteObject(RgnSecond);
  GetLocalTime(time);
  RgnHour := CreateHourRgn(time.wHour,time.wMinute);
  RgnMinute := CreateMinuteRgn(time.wMinute);
  RgnSecond := CreateSecondRgn(time.wSecond);
  LastMinute := time.wMinute;
  LastSecond := time.wSecond;
  hRgn := CreateRectRgn(0,0,0,0);
  CombineRgn(hRgn,RgnFrame,hRgn,RGN_OR);
  CombineRgn(hRgn,RgnHour,hRgn,RGN_OR);
  CombineRgn(hRgn,RgnMinute,hRgn,RGN_OR);
  CombineRgn(hRgn,RgnSecond,hRgn,RGN_OR);
  SetWindowRgn(hWnd,hRgn,TRUE);
  InvalidateRect(hWnd,nil,TRUE);
  DeleteObject(hRgn);
  SetClockWalk(hWnd);
end;

{******************************************************************************
*   Function MainProc(hWnd,Message,wParam,lParam)
*   Purpose:
*       The Applicaiton Message Deal with function
*   Parmeters:
*       hWnd        :   The recevied message window handle
*       Message     :   The Message Code
*       wParam      :   The WPARAM
*       lParam      :   The LPARAM
******************************************************************************}
function MainProc(
    hWnd:LongWord;
    Message:LongWord;
    wParam:WPARAM;
    lParam:LPARAM
    ):BOOL;stdcall;
begin
  result := false;
  case Message of
    WM_CREATE:
      result := WMCreateProc(hWnd,Message,wParam,lParam);
    WM_CLOSE :
      begin
        SendMessage(ParentWnd,WM_CLOSE,0,0);
        result := WMCloseProc(hWnd,Message,wParam,lParam);
      end;
    WM_DESTROY      :
      begin
        DestroyWindow(hWnd);
      end;
    WM_LBUTTONDOWN    :
      begin
          SendMessage(hWnd, WM_NCLBUTTONDOWN,HTCAPTION,0);
      end;
    WM_RBUTTONDOWN  : //MessageBox(GetFocus(),'Hahaha','R button down',MB_OK);
        result := WMRButtonUpProc(hWnd,Message,wParam,lParam);
        //MoveWindow(hWnd,20,20,140,140,TRUE);
    WM_TRAYICONNOTIFY:
        result := TrayIconNotifyProc(hWnd,Message,wParam,lParam);
    WM_COMMAND:
        result := WMCommandProc(hWnd,Message,wParam,lParam);
    WM_PAINT:
        result := WMPaintProc(hWnd,Message,wParam,lParam);
    WM_SYSCOMMAND:
        result := WMSysCommandProc(hWnd,Message,wParam,lParam);
    WM_MYPOSCHANGE:
        result := WMMYPOSCHANGE(hWnd,Message,wParam,lParam);
    WM_MEASUREITEM:
        result := WMMeasureItemProc(hWnd,Message,wParam,lParam);
    WM_DRAWITEM:
        result := WMDrawItemProc(hWnd,Message,wParam,lParam);
    WM_GETMINMAXINFO:
        result := WMGetMinMaxInfo(hWnd,Message,wParam,lParam);
    WM_ERASEBKGND:
        result := WMEraseBkgndProc(hWnd,Message,wParam,lParam);
    WM_TIMECHANGE:
        result := WMTimeChangeProc(hWnd,Message,wParam,lParam);
    else
      begin
        result := BOOL(DefWindowProc(hWnd,Message,wParam,lParam));
        exit;
      end;
  end;
end;

//
//***  The Following function is Worked for About Doalog box  ***
//

function DlgAboutLblEmailProc(
              hWnd    : THandle;
              Msg     : LongWord;
              wParam  : WPARAM;
              lParam  : LPARAM):BOOL;stdcall;
begin
end;

function DlgAboutWMSetCursor(
              hWnd    : THandle;
              Msg     : LongWord;
              wParam  : WPARAM;
              lParam  : LPARAM):BOOL;stdcall;
var
  CtlID : integer;
  cursor : HCURSOR;
begin
  //result := false;
  CtlID := GetWindowLong(wParam, GWL_ID);
  case CtlID of
    ID_ABOUT_LBLEMAIL:
      begin
        //MessageBox(GetFocus,'fdfd','fdf',MB_OK);
        result := true;
        cursor := LoadCursor(0,MAKEINTRESOURCE(IDC_HAND));
        SetCursor(cursor);
        //result := true;
      end;
  end;
end;

var
  hBrushStatic : HBRUSH = 0;
{******************************************************************************
*   Function DlgAbout(hDlg,Msg,wParam,lParam)
*   Purpose:
*       The Loop Message Handler of About Dialog
*   Date    :   2001-1-9
******************************************************************************}
function DlgAboutProc(hDlg: THandle;
                  Msg     : LongWord;
                  wParam  : WPARAM;
                  lParam  : LPARAM):BOOL;
var
  CtlID : integer;
begin
  result := BOOL(false);
  case Msg of
    WM_INITDIALOG :
      begin
        SetWindowInCenter(hDlg);
        (*
        SetLastError(0);
        if SetWindowLong(GetDlgItem(hDlg,ID_ABOUT_LBLEMAIL),GWL_WNDPROC,
          LongInt(@DlgAboutLblEmailProc)) = 0 then
            MessageBox(GetFocus,PChar('Error to subclass the label:'+
              IntToStr(GetLastError)),'Hi',MB_OK);
        *)
        hBrushStatic := CreateSolidBrush(GetSysColor(COLOR_MENU));

        result := BOOL(true);
      end;
    WM_COMMAND    :
      begin
        if lParam<>0 then begin // so it is a control
          case LO(wParam) of
            ID_ABOUT_OK :
              begin
                EndDialog(hDlg, integer(TRUE));
                result := BOOL(TRUE);
              end;
            ID_ABOUT_LBLEMAIL:
              begin
                ShellExecute(hDlg,'open',
                  PChar('mailto:Gan Huaxin<huiyuMag@263.net>'+
                  '?subject=About Clock'+
                  '&body=Hello,Mr. Gan Huaxin'),
                  nil,nil,SW_SHOW);
              end;
          end;
        end;
      end;
    WM_CLOSE :
      begin
        DeleteObject(hBrushStatic);
        hBrushStatic := 0;
        EndDialog(hDlg,integer(true));
        result := BOOL(true);
      end;
    WM_CTLCOLORSTATIC:
      begin
        ctlID := GetWindowLong(lParam,GWL_ID);
        case CtlID of
          ID_ABOUT_LBLEMAIL:
            begin
              SetTextColor(wParam,RGB(0,0,255));
              SetBkColor(wParam,GetSysColor(COLOR_Menu));
              result := BOOL(hBrushStatic);
            end;
        end;
      end;
    WM_SETCURSOR:
      begin
        //MessageBox(Getfocus,'SetCursor','fd',MB_OK);
        result := DlgAboutWMSetCursor(hDlg,Msg,wParam,lParam);
      end;
  end;
end;

//
//***  The Following functions is work for Dialog Option!  ***
//
var
  opt : integer;    // this global save the current select window postion
                    // option setting
                    // it Init in DlgOptionInitDlgProc
                    // and can change in DlgOptionWMCommand

{******************************************************************************
*   Function DlgOptionWMInitDlgProc(hDlg,Msg,wParam,lParam);
*   Purpose:
*       To Initial the Option Dialog
*   Date    :
*       New Development :   2001-1-10
*       Modified        :
******************************************************************************}
function DlgOptionWMInitDlgProc(
            hDlg    : THandle;
            Msg     : LongWord;
            wParam  : WPARAM;
            lParam  : LPARAM):BOOL;stdcall;
const
  CHECK_BOOL : Array[false..true] of UINT =
    (BST_UNCHECKED, BST_CHECKED);
var
  bOpt: boolean;
begin
  GetRegShowOnTaskBar(bOpt);
  CheckDlgButton(hDlg,ID_OPTION_CHKTASKBAR,CHECK_BOOL[bOpt]);
  //
  // Set the Radion Button First State
  //

  GetRegWindowPosOpt(opt);
  CheckRadioButton(hDlg,ID_OPTION_TOPLEFT,
      ID_OPTION_USERPLACE,opt);
  //
  // Set Apply Button Enabled
  //
  EnableWindow(GetDlgItem(hDlg,ID_OPTION_APPLY),false);
  //
  // initial the Check buttons Status
  //
  GetRegAllOnTop(bOpt);
  CheckDlgButton(hDlg,ID_OPTION_CHKALLONTOP,CHECK_BOOL[bOpt]);

  CheckDlgButton(hDlg,ID_OPTION_CHKSTARTWIN,
    CHECK_BOOL[GetAppAtStart]);

  GetRegTransparent(bOpt);
  CheckDlgButton(hDlg,ID_OPTION_CHKTRANS,CHECK_BOOL[bOpt]);
  //
  // Set the transparent edit enable status
  //
  EnableWindow(GetDlgItem(hDlg,ID_OPTION_EDITTRANS),bOpt);
  EnableWindow(GetDlgItem(hDlg,ID_OPTION_LBLDEGREE),bOpt);

  GetRegShowTray(bOpt);
  CheckDlgButton(hDlg,ID_OPTION_CHKSHOWTRAY,CHECK_BOOL[bOpt]);
  // place the window as center in desktop
  SetWindowInCenter(hDlg);

  result := BOOL(0);
end;

{******************************************************************************
*   Function DlgOptionWMCommandProc(hDlg,Msg,wParam,lParam);
*   Purpose:
*       To Deal with Menu, Button click events
*   Global Variable :
*       Opt   :   To Remember the Radio Button Saved
*   Date    :
*       New Development   :   2001-1-10
*       Modified          :
******************************************************************************}

function DlgOptionWMCommandProc(
            hDlg    : THandle;
            Msg     : LongWord;
            wParam  : WPARAM;
            lParam  : LPARAM):BOOL;stdcall;
var
  Pos:TMyWindowPos;
  dwStyle : integer;
begin
  if lParam<>0 then begin     // control command
      case LO(wParam) of
        //
        // push Buttons
        //
        ID_OPTION_OK:
          begin
            if IsWindowEnabled(GetDlgItem(hDlg,ID_OPTION_APPLY)) then begin
              SendDlgItemMessage(hDlg,ID_OPTION_APPLY,WM_LBUTTONDOWN,0,0);
              SendDlgItemMessage(hDlg,ID_OPTION_APPLY,WM_LBUTTONUP,0,0);
            end;
            SendMessage(hDlg,WM_CLOSE,0,0);
          end;
        ID_OPTION_CANCEL:
          Begin
            //GetRegWindowPos(TestPos);
            SendMessage(hDlg,WM_CLOSE,0,0);
          end;
        ID_OPTION_APPLY:
          begin
            SetRegTransParent(
              IsDlgButtonChecked(hDlg,ID_OPTION_CHKTRANS)= BST_CHECKED);
            SetWindowTransparent(
              GetParent(hDlg),
              IsDlgButtonChecked(hDlg,ID_OPTION_CHKTRANS)= BST_CHECKED);
            SetRegAllOnTop(
              IsDlgButtonChecked(hDlg,ID_OPTION_CHKALLONTOP) = BST_CHECKED);
            SetWindowAllOnTop(
              GetParent(hDlg),
              IsDlgButtonChecked(hDlg,ID_OPTION_CHKALLONTOP) = BST_CHECKED);
            SetRegShowTray(
              IsDlgButtonChecked(hDlg,ID_OPTION_CHKSHOWTRAY) = BST_CHECKED);
            if IsDlgButtonChecked(hDlg,ID_OPTION_CHKSHOWTRAY) = BST_CHECKED then
              ShowOnTray(GetParent(hDlg))
            else
              DelOnTray(GetParent(hDlg));

            SetRegWindowPos(GetParent(hDlg));
            SetRegWindowPosOpt(opt);
            SetAppAtStart(
              IsDlgButtonChecked(hDlg,ID_OPTION_CHKSTARTWIN) = BST_CHECKED);
            //
            // to Move the Main Window !
            //
            GetPlacePos(Pos);
            //dwStyle := GetWindowLong(GetParent(hDlg),GWL_STYLE);
            MoveWindow(GetParent(hDlg),Pos.Left,Pos.Top,
                    Pos.Width,Pos.Width,True);
            //SetWindowLong(GetParent(hDlg),GWL_STYLE,dwStyle);
            EnableWindow(GetDlgItem(hDlg,ID_OPTION_APPLY),false);
            if IsDlgButtonChecked(hDlg,ID_OPTION_CHKTASKBAR) = BST_CHECKED then
            begin
              ShowWindow(ParentWnd,SW_SHOW);
              SetRegShowOnTaskBar(true);
            end
            else begin
              ShowWindow(ParentWnd,SW_HIDE);
              SetRegShowOnTaskBar(false);
            end;

            SetFocus(hDlg);
          end;
        //
        // radion buttons
        //
        ID_OPTION_TOPLEFT,   ID_OPTION_TOPCENTER,   ID_OPTION_TOPRIGHT,
        ID_OPTION_MIDDLELEFT,ID_OPTION_MIDDLECENTER,ID_OPTION_MIDDLERIGHT,
        ID_OPTION_BOTTOMLEFT,ID_OPTION_BOTTOMCENTER,ID_OPTION_BOTTOMRIGHT,
        ID_OPTION_USERPLACE:
          // just to Remember the click Button ID
          begin
            EnableWindow(GetDlgItem(hDlg,ID_OPTION_APPLY),TRUE);
            opt := LO(wParam);
          end;
        //
        // check buttons
        //
        ID_OPTION_CHKSTARTWIN..ID_OPTION_CHKTASKBAR:
          begin
            if IsDlgButtonChecked(hDlg,LO(wParam))=BST_CHECKED then
              CheckDlgButton(hDlg,LO(wParam),BST_UNCHECKED)
            else
              CheckDlgButton(hDlg,LO(wParam),BST_CHECKED);
            EnableWindow(GetDlgItem(hDlg,ID_OPTION_APPLY),TRUE);
            if LO(wParam) = ID_OPTION_CHKTRANS then
              if IsDlgButtonChecked(hDlg,ID_OPTION_CHKTRANS)=BST_CHECKED then
              begin
                EnableWindow(GetDlgItem(hDlg,ID_OPTION_EDITTRANS),TRUE);
                EnableWindow(GetDlgItem(hDlg,ID_OPTION_LBLDEGREE),TRUE);
              end
              else begin
                EnableWindow(GetDlgItem(hDlg,ID_OPTION_EDITTRANS),FALSE);
                EnableWindow(GetDlgItem(hDlg,ID_OPTION_LBLDEGREE),FALSE);
              end;
          end;
      end;
  end
  else
  if HI(wParam)<>0 then begin // Accelerator command
  end
  else begin                  // menu command
  end;
  result := BOOL(true);
end;

{******************************************************************************
*   Function DlgOptionProc
*   Purpose:
*       The Loop Message Handler of Option Dialogs
*   Date    :   2001-1-9
******************************************************************************}
//var hBrushStatic : HBRUSH;
function DlgOptionProc(hDlg : THandle;
                  Msg       : LongWord;
                  wParam    : WPARAM;
                  lParam    : LPARAM):BOOL;
var
  ctlID : integer;
begin
  result := BOOL(false);
  case Msg of
    WM_INITDIALOG :
      result := DlgOptionWMInitDlgProc(hDlg,Msg,wParam,lParam);
    WM_CLOSE  :
      begin
        EndDialog(hDlg,integer(true));
        result := BOOL(true);
      end;
    WM_COMMAND :
      result := DlgOptionWMCommandProc(hDlg,Msg,wParam,lParam);
    WM_CTLCOLORSTATIC:
      begin
        ctlID := GetWindowLong(lParam,GWL_ID);
        if ctlID = ID_OPTION_LBLDEGREE then begin
          SetTextColor(HDC(wParam),RGB(255,0,0));
          SetBkColor(HDC(wParam),RGB(255,255,255));
          result := BOOL(0);
        end;
      end;
  end;
end;

function DlgClockSetProc(hDlg : THandle;
                  Msg       : LongWord;
                  wParam    : WPARAM;
                  lParam    : LPARAM):BOOL;
var
  ctlID : integer;
begin
  result := BOOL(false);
  case Msg of
    WM_INITDIALOG :
      SetWindowInCenter(hDlg);
    WM_CLOSE  :
      begin
        EndDialog(hDlg,integer(true));
        result := BOOL(True);
      end;
    WM_CTLCOLORSTATIC:
      begin
        ctlID := GetWindowLong(lParam,GWL_ID);
        
      end;
  end;
end;

end.
