program xici;

uses
  Forms,
  MainFrame in 'src\UNIT\MainFrame.pas' {Form1},
  RegExpr in 'src\UNIT\RegExpr.pas',
  HtmlHelper in 'src\UNIT\HtmlHelper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

