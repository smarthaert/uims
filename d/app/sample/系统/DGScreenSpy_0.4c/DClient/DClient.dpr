program DClient;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  Host in 'Host.pas' {frmHost},
  ZLibEx in '..\ZLibEx\ZLibEx.pas';

begin
  Application.Initialize;
  Application.Title := 'DGScreenSpy - Client';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
