program ExportSample_p;

uses
  Forms,
  ExportSample in 'ExportSample.pas' {Ds2ExcelSample};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TDs2ExcelSample, Ds2ExcelSample);
  Application.Run;
end.
