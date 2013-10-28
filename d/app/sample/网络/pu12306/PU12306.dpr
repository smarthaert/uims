program PU12306;

uses
  Forms,
  frmMain in 'frmMain.pas' {Form1},
  U_javascript in 'U_javascript.pas',
  U_Web in 'U_Web.pas',
  U_Info in 'U_Info.pas',
  frmContent in 'frmContent.pas' {Form2},
  Unit3 in 'Unit3.pas' {Form3},
  Unit4 in 'Unit4.pas' {Form4},
  U_base in 'U_base.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
