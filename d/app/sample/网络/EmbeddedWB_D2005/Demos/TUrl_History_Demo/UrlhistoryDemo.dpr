program UrlhistoryDemo;

uses
  Forms,
  UrlhistoryDemo_U in 'UrlhistoryDemo_U.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
