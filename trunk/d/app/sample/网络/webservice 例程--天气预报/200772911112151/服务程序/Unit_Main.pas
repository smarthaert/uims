unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs;

type
  TServiceWeather = class(TService)
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  ServiceWeather: TServiceWeather;

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  ServiceWeather.Controller(CtrlCode);
end;

function TServiceWeather.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

end.
