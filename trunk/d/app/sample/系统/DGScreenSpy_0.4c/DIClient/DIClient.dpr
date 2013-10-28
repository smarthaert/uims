program DIClient;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  View in 'View.pas' {frmView},
  Color in 'Color.pas' {frmColor},
  ZLibEx in '..\ZLibEx\ZLibEx.pas';

begin
  Application.Initialize;
  Application.Title := 'DGScreenSpy - Client';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
