program Update;

uses
  Forms,
  SysUtils,
  windows,
  UnitMain in 'UnitMain.pas' {FormMain};

{$R *.res}

begin
try
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
except end;
end.
