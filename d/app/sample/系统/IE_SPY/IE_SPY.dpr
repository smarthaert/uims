program IE_SPY;

uses
  Forms,
 UnitHookConst in 'UnitHookConst.pas',
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
