program Pserver;

uses
  Forms,
  Umain in 'Umain.pas' {Form2},
  Utip in 'Utip.pas' {tip};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '校时服务端';
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(Ttip, tip);
  Application.Run;
end.
