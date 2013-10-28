unit CdgLed;

{     Component: TCdgLed
        Version: 1.00
         Author: Deng-Guey Chen < dgchen@ms2.hinet.net >
  First version: 1996.12.24
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TDirection=(drNone,drLeft,drRight,drDown,drUp);
  TCdgLed = class(TLabel)
  private
    { Private declarations }
    iWidth, iHeight: integer;
    FTimer: TTimer;
    FPlay: Boolean;
    FInterval: integer;
    FDistance: integer;
    FDirection: TDirection;
    procedure LedOnTimer(Sender: TObject);
    procedure SetInterval(Value: integer);
  protected
    { Protected declarations }
  public
    { Public declarations }
    Constructor Create(Aowner: TComponent); override;
    Destructor Destroy; override;
  published
    { Published declarations }
    property Direction: TDirection read FDirection write FDirection;
    property Distance: integer read FDistance write FDistance default 2;
    property Interval: integer read FInterval write SetInterval default 1000;
    property Play: Boolean read FPlay write FPlay default False;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('CdgLed', [TCdgLed]);
end;

Constructor TCdgLed.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FInterval:= 1000;
  FDistance:= 2;
  FDirection:= drLeft;
  FPlay:= False;
  FTimer:= TTimer.Create(self);
  FTimer.OnTimer:= LedOnTimer;
  FTimer.Interval:= 1000;
  iWidth:=TForm(AOwner).ClientWidth;
  iHeight:=TForm(AOwner).ClientHeight;
end;

Destructor TCdgLed.Destroy;
begin
  FTimer.Free;
  inherited Destroy;
end;

procedure TCdgLed.LedOnTimer(Sender: TObject);
begin
  if Fplay then
  begin
  case FDirection of
  drNone:;
  drLeft:
    begin
      Left:= Left - FDistance;
      if Left+Width < 0 then
        Left:=iWidth;
    end;
  drRight:
    begin
      Left:= Left + FDistance;
      if Left > iWidth then
        Left:=0;
    end;
  drDown:
    begin
      Top:= Top + FDistance;
      if Top > iHeight then
        Top:=0;
    end;
  drUp:
    begin
      Top:= Top - FDistance;
      if Top+Height < 0 then
        Top:=iHeight;
    end;
  end;
  end;
end;

procedure TCdgLed.SetInterval(Value: Integer);
begin
  if FInterval<>Value then
  begin
    FInterval:= Value;
    FTimer.Interval:= Value;
  end;
end;

end.
