program DownloadDemo;

uses
  Forms,
  Downloaddemo_U in 'Downloaddemo_U.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
