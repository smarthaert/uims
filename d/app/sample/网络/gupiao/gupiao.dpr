program gupiao;

uses
  Forms,
  main in 'main.pas' {mainfrm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tmainfrm, mainfrm);
  Application.Run;
end.

