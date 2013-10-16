unit PaintPanel;

interface

uses
  SysUtils, Classes, Controls, Graphics, ExtCtrls, Messages;

type
  TPaintPanel = class(TPanel)
  private
    FOnPaint: TNotifyEvent;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Canvas;
  published
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
  end;

procedure Register;

implementation

constructor TPaintPanel.Create(AOwner: TComponent);
begin
try
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csSetCaption];
  FullRepaint := False;
  BevelOuter := bvNone;
except end;
end;

procedure TPaintPanel.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
try
  if not (csDesigning in ComponentState) then
  begin
    Message.Result := 1;
    Paint;
  end else inherited;
except end;
end;

procedure TPaintPanel.Paint;
begin
try
  Canvas.Font := Font;
  Canvas.Brush.Color := Color;
  if Assigned(FOnPaint) then FOnPaint(Self);
except end;
end;

procedure Register;
begin
  RegisterComponents('PaintPanel', [TPaintPanel]);
end;

end.
