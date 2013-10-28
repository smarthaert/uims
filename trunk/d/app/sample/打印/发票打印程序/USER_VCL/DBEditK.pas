unit DBEditK;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls;
const VK_NULL = 0;

type
  TFunctionKeys = (kNONE, kF1, kF2, kF3, kF4, kF5, kF6, kF7, kF8,
                  kF9, kF10, kF11, kF12, kUP, kDOWN, kPGUP, kPGDOWN);

  TEditK = class(TEdit)
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure KeyDown(var Key: Word; Shift: TShiftState);override;
    procedure KeyPress(var Key: Char);override;
  public
    { Public declarations }
  published
    { Published declarations }
end;

procedure Register;

implementation

procedure TEditK.KeyDown;
begin
  if (Key = VK_RETURN) then begin
    PostMessage(Handle, WM_KEYDOWN, VK_TAB, 0);
  end;
  inherited;
end;

procedure TEditK.KeyPress;
begin
  if (ord(Key) = VK_RETURN) then begin
    Key := chr(0);
  end
  else inherited;
end;

procedure Register;
begin
  RegisterComponents('EditKey', [TEditK]);
end;

end.


