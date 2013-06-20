unit untHint;

interface
uses
  Windows,
  Messages,
  untTool,
  untConst,
  Sysutils;

function DlgHintProc(hDlg: THandle;
                  Msg     : LongWord;
                  wParam  : WPARAM;
                  lParam  : LPARAM):BOOL;stdcall;
function SetClockWalk(hWnd:HWND):BOOL;
procedure CloseClockWalk(hWnd:HWND);

implementation

var
  hHintBrushStatic : HBRUSH;
  hintPStr : PChar = nil;
function DlgHintProc(hDlg: THandle;
                  Msg     : LongWord;
                  wParam  : WPARAM;
                  lParam  : LPARAM):BOOL;
var
  CtlID : integer;
begin
  result := BOOL(false);
  case Msg of
    WM_CREATE:
      begin
        //hintPStr := StrAlloc(255);
        result := BOOL(DefDlgProc(hDlg,Msg,wParam,lParam));
      end;
    WM_INITDIALOG :
      begin
        SetWindowInCenter(hDlg);
        SetWindowPos(hDlg,HWND_TOPMOST,0,0,0,0,SWP_NOSIZE or SWP_NOMOVE);
        //SendMessage(GetDlgItem(GetFocus,ID_HINT_LBLHINT),WM_SETTEXT,
        //    0,Integer(hintPStr));
        SetDlgItemText(hDlg,ID_HINT_LBLHINT,hintPStr);
        StrDispose(hintPStr);
        hintPStr := nil;
        (*
        SetLastError(0);
        if SetWindowLong(GetDlgItem(hDlg,ID_ABOUT_LBLEMAIL),GWL_WNDPROC,
          LongInt(@DlgAboutLblEmailProc)) = 0 then
            MessageBox(GetFocus,PChar('Error to subclass the label:'+
              IntToStr(GetLastError)),'Hi',MB_OK);
        *)
        hHintBrushStatic := CreateSolidBrush(GetSysColor(COLOR_MENU));

        result := BOOL(true);
      end;
    WM_CLOSE :
      begin
        DeleteObject(hHintBrushStatic);
        hHintBrushStatic := 0;
        EndDialog(hDlg,integer(true));
        result := BOOL(true);
      end;
    WM_CTLCOLORSTATIC:
      begin
        ctlID := GetWindowLong(lParam,GWL_ID);
        case CtlID of
          ID_HINT_LBLHINT:
            begin
              SetTextColor(wParam,RGB(0,0,255));
              SetBkColor(wParam,GetSysColor(COLOR_Menu));
              result := BOOL(hHintBrushStatic);
            end;
        end;
      end;
    {
    WM_CTLCOLORBTN:
      begin
        CtlID := GetWindowLong(lParam,GWL_ID);
        case CtlID of
          ID_HINT_ISEE:
            begin
              SetTextColor(wParam,RGB(255,0,0));
              SetBkColor(wParam,GetSysColor(COLOR_MENU));
              result := BOOL(hHintBrushStatic);
            end;
        end;
      end;
    }
    WM_COMMAND:
      begin
        if (lParam<>0) then begin // from a control
          case LO(wParam) of
            ID_HINT_ISEE:
              begin
                SendMessage(hDlg,WM_CLOSE,0,0);
              end;
          end;
        end;
      end;
  end;
end;

//
// the following function is write for set the window bitmap rgn
//
function ShouldChangeHour(time : SYSTEMTIME):BOOL;
begin
  result := (time.wMinute mod 10) = 0;
  if result then begin
    DeleteObject(RgnHour);
    RgnHour := CreateHourRgn(time.wHour,time.wMinute);
  end;
end;

procedure DoHint(time : SYSTEMTIME);
  procedure HintStr(str:PChar);
  begin
    //MessageBox(GetFocus,str,'Huiyu Clock Hint ...',MB_OK);
    //MessageBeep(0);
    MessageBeep(0);
    hintPStr := StrAlloc(255);
    StrCopy(hintPStr,str);
    //hintPStr:= str;
    DialogBox(hInstance,'DIALOG_HINTDLG',ClockWnd,@DlgHintProc);
    //SendMessage(GetDlgItem(GetFocus,ID_HINT_LBLHINT),WM_SETTEXT,0,Integer(str));

  end;
begin
    case time.wHour of
      8:
        begin
          Case LastMinute of
            25:
              HintStr('注意你不要忘记刷卡！ 8：30 上班哪');
            30:
              HintStr('上班罗！！');
          end;
        end;
      9,10,11,14,15,16:
        begin
          if LastMinute = 0 then
            HintStr(PChar('整点报时'+#13+'现在'+IntToStr(time.wHour)+':00 点罗'));
        end;
      12:
        begin
          if LastMinute = 0 then
            HintStr('要去吃午饭罗!');
        end;
      13:
        begin
          if LastMinute = 0 then HintStr('下午上班罗!');
        end;
      17:
        begin
          if LastMinute = 30 then HintStr('哈哈，下班罗，注意不要忘记刷卡');
        end;
    end;
end;

function ShouldChangeMinute(time : SYSTEMTIME):BOOL;
begin
  result := time.wMinute <> LastMinute;
  if result then begin
    LastMinute := time.wMinute;
    DeleteObject(RgnMinute);
    RgnMinute := CreateMinuteRgn(LastMinute);
    // 这个时候检查是否要作些事情 ！ 各种事件
    // 简陋测试
    DoHint(time);
  end;
end;

function ShouldChangeSecond(time : SYSTEMTIME):BOOL;
begin
  result := time.wSecond <> LastSecond;
  if result then begin
    LastSecond := time.wSecond;
    DeleteObject(RgnSecond);
    RgnSecond := CreateSecondRgn(LastSecond);
  end;
end;

procedure TimerClockWalk(
                  hwnd    : HWND;         // handle to window
                  Msg     : LongWord;     // WM_TIMER message
                  idEvent : integer;      // timer identifier
                  dwTime  : integer       // current system time
                  );stdcall;
var
  systime : SYSTEMTIME;
  chg : boolean;
  hRgn : THandle;
begin
  chg := false;
  GetLocalTime(systime);
  chg := ShouldChangeSecond(systime) or
         ShouldChangeMinute(systime)or
         ShouldChangeHour(systime);
  if chg then begin
    hRgn := CreateRectRgn(0,0,0,0);
    CombineRgn(hRgn,RgnFrame,hRgn,RGN_OR);
    CombineRgn(hRgn,RgnHour,hRgn,RGN_OR);
    CombineRgn(hRgn,RgnMinute,hRgn,RGN_OR);
    CombineRgn(hRgn,RgnSecond,hRgn,RGN_OR);
    SetWindowRgn(hWnd,hRgn,TRUE);
    DeleteObject(hRgn);
    //UpdateWindow(hWnd);
    InvalidateRect(hWnd,nil,true);
    //

  end;
end;

function SetClockWalk(hWnd:HWND):BOOL;
begin
  SetTimer(hWnd,5, 100, @TimerClockWalk);
end;

procedure CloseClockWalk(hWnd:HWND);
begin
  KillTimer(hWnd,5);
end;

end.
