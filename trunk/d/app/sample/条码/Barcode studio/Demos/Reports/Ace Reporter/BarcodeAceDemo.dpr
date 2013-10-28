program BarcodeAceDemo;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  AceRptU in 'AceRptU.pas' {Rpt1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TRpt1, Rpt1);
  Application.Run;
end.
