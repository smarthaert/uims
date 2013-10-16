program ProcessResource;

uses
  Forms,
  main in 'main.pas' {Form1},
  HyperLinksDecorator in 'HyperLinksDecorator.pas',
  RegExpr in 'RegExpr.pas',
  HtmlCloner in 'HtmlCloner.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
