unit UnitMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Tlhelp32, ComCtrls, OleCtrls, SHDocVw,
  ExtCtrls, Clipbrd;

type
  TMainForm = class(TForm)
    mmoOld: TMemo;
    wb1: TWebBrowser;
    btn3: TButton;
    mmoNew: TMemo;
    tmr1: TTimer;
    mmoText: TMemo;
    lbl2: TLabel;
    edtBegin: TEdit;
    edtEnd: TEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    mmoHistory: TMemo;
    lbl5: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn3Click(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  isGetOld, Doing: Boolean;
  QQOrder: Integer;

implementation

{$R *.dfm}

function GetText(Wnd: HWND): string;
var
  textlength: integer;
  text: PChar;
begin
  textlength := SendMessage(Wnd, WM_GETTEXTLENGTH, 0, 0);
  if textlength = 0 then Result := ''
  else
  begin
    getmem(text, textlength + 1);
    SendMessage(Wnd, WM_GETTEXT, textlength + 1, Integer(text));
    Result := text;
    freemem(text);
  end;
end;

function EnumWindowsProc(Wnd: HWND; LParam: LPARAM): BOOL; stdcall;
begin
  Result := True;
  if (IsWindowVisible(Wnd)) and
    ((GetWindowLong(Wnd, GWL_HWNDPARENT) = 0) or (GetWindowLong(Wnd, GWL_HWNDPARENT) = GetDesktopWindow)) and
    (GetWindowLong(Wnd, GWL_EXSTYLE) and WS_EX_TOOLWINDOW = 0) then
  begin
    if isGetOld then
      MainForm.mmoOld.Lines.Add(GetText(Wnd))
    else
      MainForm.mmoNew.Lines.Add(GetText(Wnd))
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
end;

procedure TMainForm.btn3Click(Sender: TObject);
var
  Flags: OLEVariant;
  defaultWeb: WideString;
  QQBegin, QQEnd, theQQ: Integer;
begin
  QQBegin := StrToInt(edtBegin.Text);
  QQEnd := StrToInt(edtEnd.Text);
  //弹出QQ对话窗口
  Flags := 0;
  theQQ := QQBegin;
  while theQQ < QQEnd do
  begin
    if not Doing then
    begin
      wb1.Stop;
      defaultWeb := 'http://wpa.qq.com/msgrd?V=1&Uin=' + IntToStr(theQQ) + '&Menu=yes';
      wb1.Navigate(WideString(defaultWeb), Flags, Flags, Flags, Flags);
      mmoHistory.Lines.Add(IntToStr(theQQ));
      Sleep(4000);
      Doing := True;
      theQQ := theQQ + 1;
    end;
    Application.ProcessMessages;
  end;
end;

procedure TMainForm.tmr1Timer(Sender: TObject);
var
  Param: Longint;
  i, j: Integer;
  isBreak: Boolean;
  NewWndCaption: string;
  npad: HWND;
  Inputs: array[0..3] of TInput;
begin
  isGetOld := False;
  NewWndCaption := '';
  mmoNew.Clear;
  EnumWindows(@EnumWindowsProc, Param);
  //对比旧List,得出新窗口标题
  for i := 0 to mmoNew.Lines.Count do
  begin
    isBreak := False;
    for j := 0 to mmoOld.Lines.Count do
    begin
      if mmoNew.Lines[i] = mmoOld.Lines[j] then
      begin
        isBreak := True;
        Break;
      end;
    end;
    if isBreak = False then
    begin
      NewWndCaption := mmoNew.Lines[i];
    end;
  end;
  //取出HWND
  if NewWndCaption = '' then
  begin
    Doing := False;
    Exit;
  end;
  Npad := FindWindow(nil, PChar(NewWndCaption));
  if npad = 0 then Exit;
  //拷贝文本框的文字
  ClipBoard.Clear;
  Clipboard.AsText := mmoText.Text;
  //使其成为focus之window
  BringWindowToTop(Npad);
  //输入内容
  //模拟Ctrl+V 　粘贴内容
  keybd_event(VK_CONTROL, 0, 0, 0); //按下ctrl
  keybd_event(86, 0, 0, 0); //按下V
  keybd_event(86, 0, 2, 0); //释放V
  keybd_event(VK_CONTROL, 0, 2, 0); //释放ctrl
  //模拟Alt+S  　发送消息
  keybd_event(VK_MENU, 0, 0, 0); //按下alt
  keybd_event(83, 0, 0, 0); //按下s
  keybd_event(83, 0, 2, 0); //释放s
  keybd_event(VK_MENU, 0, 2, 0); //释放alt
  Sleep(1000);
  //模拟Alt+F4　　关闭窗口
  keybd_event(VK_MENU, 0, 0, 0); //按下alt
  keybd_event(VK_F4, 0, 0, 0); //按下s
  keybd_event(VK_F4, 0, 2, 0); //释放s
  keybd_event(VK_MENU, 0, 2, 0); //释放alt
  //全局标志
  Doing := False;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  Param: Longint;
begin
  isGetOld := True;
  mmoOld.Clear;
  EnumWindows(@EnumWindowsProc, Param);
  mmoOld.Lines.Add(Application.Title);
  //全局标志
  Doing := False;
end;

end.
// //模拟Alt+S
//   Inputs[0].Itype := INPUT_KEYBOARD;
//  with Inputs[0].ki do
//  begin
//    wVk := VK_MENU;
//    wScan := 0;
//    dwFlags := 0;
//    time := GetTickCount;
//    dwExtraInfo := GetMessageExtraInfo;
//  end;
//  Inputs[1].Itype := INPUT_KEYBOARD;
//  with Inputs[1].ki do
//  begin
//    wVk := Ord('S');
//    wScan := 0;
//    dwFlags := 0;
//    time := GetTickCount;
//    dwExtraInfo := GetMessageExtraInfo;
//  end;
//  Inputs[2].Itype := INPUT_KEYBOARD;
//  with Inputs[2].ki do
//  begin
//    wVk := VK_MENU;
//    wScan := 0;
//    dwFlags := KEYEVENTF_KEYUP;
//    time := GetTickCount;
//    dwExtraInfo := GetMessageExtraInfo;
//  end;
//  Inputs[3].Itype := INPUT_KEYBOARD;
//  with Inputs[3].ki do
//  begin
//    wVk := Ord('S');
//    wScan := 0;
//    dwFlags := KEYEVENTF_KEYUP;
//    time := GetTickCount;
//    dwExtraInfo := GetMessageExtraInfo;
//  end;
//  SendInput(4, Inputs[0], SizeOf(TInput));

