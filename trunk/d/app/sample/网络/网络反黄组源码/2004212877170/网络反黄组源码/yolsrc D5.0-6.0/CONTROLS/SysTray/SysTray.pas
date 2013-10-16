{**********************************************************}
{                                                          }
{  TSysTray Component Version 1.04                         }
{                                                          }
{  Function: Adds an icon to the Windows 95/98 System Tray }
{            and has events to respond to mouse clicks.    }
{                                                          }
{  This is a freeware. If you make cool changes to it,     }
{  please send them to me.                                 }
{                                                          }
{  Email: haoem@126.com                                    }
{  URL: http://haoxg.yeah.net                              }
{                                                          }
{**********************************************************}

unit SysTray;

interface

uses
  Windows, Messages, SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs,
  ShellApi, ExtCtrls, Menus, StdCtrls;

const
  WM_SYSTRAY = WM_USER + 1;
  IDI_TRAYICON = 0;

type
  TPopupMode = set of(pmLeftClick, pmRightClick, pmLeftDblClick, pmRightDblClick);
  TMouseEvent= procedure(Sender: TObject;
                         Button: TMouseButton;
                         X, Y: Integer) of object;

  TSysTray = class(TComponent)
  private
    { Private declarations }
    FIcon: TIcon;
    FIconData: TNotifyIconData;
    FParentWindow: HWnd;
    FWindowHandle: HWnd;
    FHint: string;
    FPopupMenu: TPopupMenu;
    FPopupAlign: TPopupAlignment;
    FPopupMode: TPopupMode;
    FActive: boolean;
    FShowDesigning: boolean;

    FOnIconMouseDown: TMouseEvent;
    FOnIconDoubleClick: TMouseEvent;

    function AddIcon: boolean;
    function DeleteIcon: boolean;
    function ModifyIcon: boolean;

    procedure SetIcon(Icon: TIcon);
    procedure SetHint(Hint: string);
    procedure SetActive(Value: boolean);
    procedure SetShowDesigning(Value: boolean);
    procedure FillDataStructure;

    procedure WndProc(var Msg: TMessage); message WM_SYSTRAY;

  protected
    { Protected declarations }

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    { Published declarations }
    property Active: boolean read FActive write SetActive;
    property ShowDesigning: boolean read FShowDesigning write SetShowDesigning;
    property Icon: TIcon Read FIcon write SetIcon;
    property Hint: string read FHint write SetHint;
    property PopupMenu: TPopupMenu read FPopupMenu write FPopupMenu;
    property PopupMode: TPopupMode read FPopupMode write FPopupMode;
    property PopupAlign: TPopupAlignment read FPopupAlign write FPopupAlign;

    property OnIconDoubleClick:TMouseEvent
             read FOnIconDoubleClick write FOnIconDoubleClick;
    property OnIconMouseDown:TMouseEvent
             read FOnIconMouseDown write FOnIconMouseDown ;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('DayDream', [TSysTray]);
end;

constructor TSysTray.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIcon := TIcon.Create;
  FHint := 'SysTray Component.';
  FPopupMode := [pmRightClick];
  FPopupAlign := paRight;
  FActive := false;
  FShowDesigning := false;

  if (AOwner <> nil) and (AOwner is TForm) then
    FParentWindow := TForm(AOwner).Handle
  else
    FParentWindow := 0;

  FWindowHandle := AllocateHWnd(WndProc);

  FillDataStructure;
end;

destructor TSysTray.Destroy;
begin
  try
    if (not (csDesigning in ComponentState) and FActive)
       or ((csDesigning in ComponentState) and FShowDesigning) then
          DeleteIcon;
  finally
    FIcon.Free;
    DeallocateHWnd(FWindowHandle);
  end;
  inherited Destroy;
end;

function TSysTray.AddIcon: boolean;
begin
  FillDataStructure;
  Result := Shell_NotifyIcon(NIM_ADD, @FIconData);
end;

function TSysTray.DeleteIcon: boolean;
begin
  Result := Shell_NotifyIcon(NIM_DELETE, @FIconData);
end;

function TSysTray.ModifyIcon: boolean;
begin
  FillDataStructure;
  if FActive then
    Result := Shell_NotifyIcon(NIM_MODIFY, @FIconData)
  else
    Result := true;
end;

procedure TSysTray.SetIcon(Icon: TIcon);
begin
  FIcon.Assign(Icon);
  ModifyIcon;
end;

procedure TSysTray.SetHint(Hint: string);
begin
  if Length(Hint) >= 64 then Hint := Copy(Hint, 1, 63);
  FHint := Hint;
  ModifyIcon;
end;

procedure TSysTray.SetActive(Value: boolean);
begin
  if Value <> FActive then
  begin
    FActive := Value;
    if not (csDesigning in ComponentState) then
    begin
      case Value of
        true:    AddIcon;
        false:   DeleteIcon;
      end;
    end;
  end;
end;

procedure TSysTray.SetShowDesigning(Value: boolean);
begin
  if (csDesigning in ComponentState) then
  begin
    if Value <> FShowDesigning then
    begin
      FShowDesigning := Value;
      case Value of
        true:    AddIcon;
        false:   DeleteIcon;
      end;
    end;
  end;
end;

procedure TSysTray.FillDataStructure;
begin
  With FIconData do
  begin
    uCallbackMessage:=WM_SYSTRAY;
    cbSize := SizeOf(FIconData);
    uID := IDI_TRAYICON;
    wnd := FWindowHandle;
    hIcon := FIcon.Handle;
    StrCopy(FIconData.szTip, PChar(FHint));
    uFlags := NIF_ICON + NIF_TIP + NIF_MESSAGE;
  end;
end;

procedure TSysTray.WndProc(var Msg: TMessage);
var
  P: TPoint;
begin
  if (Msg.WParam <> IDI_TRAYICON) then exit;
  if Assigned(FPopupMenu) then
    FPopupMenu.Alignment := FPopupAlign;

  GetCursorPos(p);
  case Msg.LParam of
    WM_LBUTTONDOWN:
      begin
        if (pmLeftClick in FPopupMode) and Assigned(FPopupMenu) then
        begin
          SetForegroundWindow(FParentWindow);
          FPopupMenu.Popup(p.x,p.y);
        end;
        if Assigned(FOnIconMouseDown) then
        begin
          SetForegroundWindow(FParentWindow);
          FOnIconMouseDown(Self, mbLeft, p.x, p.y);
        end;
      end;

    WM_RBUTTONDOWN:
      begin
        if (pmRightClick in FPopupMode) and Assigned(FPopupMenu) then
        begin
          SetForegroundWindow(FParentWindow);
          FPopupMenu.Popup(p.x,p.y);
        end;
        if Assigned(FOnIconMouseDown) then
        begin
          SetForegroundWindow(FParentWindow);
          FOnIconMouseDown(Self, mbRight, p.x, p.y);
        end;
      end;

    WM_LBUTTONDBLCLK:
      begin
        if (pmLeftDblClick in FPopupMode) and Assigned(FPopupMenu) then
        begin
          SetForegroundWindow(FParentWindow);
          FPopupMenu.Popup(p.x,p.y);
        end;
        if Assigned(FOnIconDoubleClick) then
        begin
          SetForegroundWindow(FParentWindow);
          FOnIconDoubleClick(Self, mbLeft, p.x, p.y);
        end;
      end;

    WM_RBUTTONDBLCLk:
      begin
        if (pmRightDblClick in FPopupMode) and Assigned(FPopupMenu) then
        begin
          SetForegroundWindow(FParentWindow);
          FPopupMenu.Popup(p.x,p.y);
        end;
        if Assigned(FOnIconDoubleClick) then
        begin
          SetForegroundWindow(FParentWindow);
          FOnIconDoubleClick(Self, mbRight, p.x, p.y);
        end;
      end;

    else
      Msg.Result := DefWindowProc(FWindowHandle, Msg.Msg, Msg.wParam, Msg.lParam);
  end;
end;

end.
