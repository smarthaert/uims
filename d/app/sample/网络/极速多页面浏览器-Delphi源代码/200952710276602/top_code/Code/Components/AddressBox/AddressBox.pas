unit AddressBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls, ComCtrls,
  Registry, ActiveX;   

const
  SHACF_DEFAULT = $00000000; // Currently (SHACF_FILESYSTEM | SHACF_URLALL)
  SHACF_FILESYSTEM = $00000001; // This includes the File System as well as the rest of the shell (Desktop\My Computer\Control Panel\)
  SHACF_URLHISTORY = $00000002; // URLs in the User's History
  SHACF_URLMRU = $00000004; // URLs in the User's Recently Used list.
  SHACF_URLALL = (SHACF_URLHISTORY + SHACF_URLMRU);
  SHACF_AUTOSUGGEST_FORCE_ON = $10000000; // Ignore the registry default and force the feature on.
  SHACF_AUTOSUGGEST_FORCE_OFF = $20000000; // Ignore the registry default and force the feature off.
  SHACF_AUTOAPPEND_FORCE_ON = $40000000; // Ignore the registry default and force the feature on. (Also know as AutoComplete)
  SHACF_AUTOAPPEND_FORCE_OFF = $80000000; // Ignore the registry default and force the feature off. (Also know as AutoComplete)

type
  TAddressBox = class(TCustomComboBox)
  private
    { Private declarations }
  protected
    { Protected declarations }

  public
    { Public declarations }
    //procedure GetTypedURLs;
    constructor Create(AOwner: TComponent);override;
    procedure CreateWnd; override;
  published
    { Published declarations }
    property AutoComplete default True;
    property AutoDropDown default False;
    property AutoCloseUp default False;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property Style; {Must be published before Items}
    property Anchors;
    property BiDiMode;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownCount;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    property ItemIndex default -1;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnCloseUp;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnSelect;
    property OnStartDock;
    property OnStartDrag;
    property Items; { Must be published after OnMeasureItem }

  end;

procedure Register;

implementation

function SHAutoComplete(hwndEdit: HWND; dwFlags: DWORD): HRESULT; stdcall; external 'shlwapi.dll';

procedure Register;
begin
  RegisterComponents('Samples', [TAddressBox]);
end;

constructor TAddressBox.Create(AOwner: TComponent);
begin
  inherited;
  //GetTypedURLs;
  AutoComplete := False;
end;

procedure TAddressBox.CreateWnd;
var
  options: DWORD;
begin
  inherited;
  options := 0;
  if not (csDesigning in ComponentState) then
  begin
    inc(options, SHACF_URLALL);
    inc(options, SHACF_AUTOSUGGEST_FORCE_ON);
    SHAutoComplete(EditHandle, options);
  end;
end;

{
procedure TAddressBox.GetTypedURLs;
var
  //Counter: Integer;
  S: String;
begin
try
}
  //Items.Clear;
  //Items.Add('sssssss');
  {
  Items.Clear;
  S := ExtractFilePath(ParamStr(0)) + '\Data\Url.lst';
  if FileExists(S) then
  Items.LoadFromFile(S);
  }
  {
  with TRegistry.Create do
  try
    RootKey := HKEY_CURRENT_USER;
    if OpenKey('Software\Microsoft\Internet Explorer\TypedURLs', FALSE) then begin
      for Counter := 1 to 25 do begin
        if ValueExists('Url' +  IntToStr(Counter)) then begin
          S := ReadString('Url' + IntToStr(Counter));
          if S <> '' then Items.Add(S);
        end;
      end;
    end;
  finally
    Free;
  end;
  }
//except end;
//end;


initialization
  Oleinitialize(nil);

finalization
  OleUninitialize;
  
end.
