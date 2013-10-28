program UnicodeDemo;

uses
  Forms,
  UnicodeFmt in 'UnicodeFmt.pas' {Form2},
  psCodeProf in '..\..\Source\psCodeProf.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
