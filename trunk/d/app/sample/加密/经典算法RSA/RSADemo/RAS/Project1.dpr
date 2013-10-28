program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  ranlib in 'RANLIB.PAS',
  FGInt in 'FGInt.pas',
  FGIntPrimeGeneration in 'FGIntPrimeGeneration.PAS',
  FGIntRSA in 'FGIntRSA.PAS';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
