program Project1;

uses
  Forms,
  main in 'main.pas' {Form1},
  config in 'config.pas' {Form2},
  about in 'about.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ÌìÆøÔ¤±¨';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
