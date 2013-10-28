program DownloadMgrDemo;

uses
  Forms,
  DownloadMgrDemo_U in 'DownloadMgrDemo_U.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
