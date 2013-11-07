program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {RSRStockDemo};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TRSRStockDemo, RSRStockDemo);
  Application.Run;
end.
