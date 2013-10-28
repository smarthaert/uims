program QuickReportDemo;

uses
  Forms,
  Unit2 in 'Unit2.pas' {Form2},
  Rpt1U in 'Rpt1U.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  // Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
