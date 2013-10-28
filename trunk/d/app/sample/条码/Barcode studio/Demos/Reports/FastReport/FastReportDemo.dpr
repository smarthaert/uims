program FastReportDemo;

uses
  Forms,
  MainFmt in 'MainFmt.pas' {Form1},
  psReportFast in '..\..\..\Source\psReportFast.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Barcode library - Fast report - demo';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
