unit untSplash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Gauges, StdCtrls, PHPRPC, jpeg;

type
  TfrmSplash = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Gauge1: TGauge;
  private
    { Private declarations }
    procedure RepaintForm;
    function get_version:Boolean;
  public
    { Public declarations }
    procedure StartLoad;
    procedure StopLoad;
    procedure CheckVersion(const AStatusText: string; AProgress: Integer);
    procedure UpdateStatus(const AStatusText: string; AProgress: Integer);
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}
uses untConsts;

procedure TfrmSplash.RepaintForm;
begin
  Show;
  Refresh;
  Sleep(200);
end;

procedure TfrmSplash.StartLoad;
begin
  Label1.Caption := '正在装载……';
  Gauge1.Progress := 0;
  RepaintForm;
end;

procedure TfrmSplash.StopLoad;
begin
  Label1.Caption := '装载完毕';
  Gauge1.Progress := 100;
  RepaintForm;
end;

procedure TfrmSplash.CheckVersion(const AStatusText: string;
  AProgress: Integer);
begin
  Label1.Caption:=AStatusText;
  Gauge1.Progress:=AProgress;
  RepaintForm;
  if not get_version then
  begin
    MessageBox( Self.Handle, PChar( RSTR_CHECK_VERSION ),
        PChar( STR_APPTITLE ), MB_ICONEXCLAMATION );
    Application.Terminate;
  end;
end;

procedure TfrmSplash.UpdateStatus(const AStatusText: string;
  AProgress: Integer);
begin
  Label1.Caption := AStatusText;
  Gauge1.Progress := AProgress;
  RepaintForm;
end;

function TfrmSplash.get_version:Boolean;
var
  PHPRPC_Client1: TPHPRPC_Client;
  clientProxy: Variant;
  tunnelversion:string;
begin
  Result:=True;

  PHPRPC_Client1 := TPHPRPC_Client.Create;
  try
    PHPRPC_Client1.URL := PServiceURL;
    clientProxy := PHPRPC_Client1.ToVariant;
    try
      tunnelversion:= VarToStr(clientProxy.get_version());
      if StrComp(PChar(STR_TUNNELVERSION), PChar(tunnelversion))<>0 then
        Result:=False;
    except
      Result:=False;
    end;
  finally
    PHPRPC_Client1.Free;
  end;
end;

end.
