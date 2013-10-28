program example;

uses
  Forms,
  main in 'main.pas' {Form1},
  example_TLB in 'example_TLB.pas',
  idispatch_interface in 'idispatch_interface.pas' {TBrowserToDelphi: CoClass},
  Unit2 in 'Unit2.pas' {Form2};

{$R *.TLB}

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
