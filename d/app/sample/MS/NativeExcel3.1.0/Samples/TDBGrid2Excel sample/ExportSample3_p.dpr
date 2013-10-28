program ExportSample3_p;

uses
  Forms,
  ExportSample3 in 'ExportSample3.pas' {DBGrid2ExcelSample};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TDBGrid2ExcelSample, DBGrid2ExcelSample);
  Application.Run;
end.
