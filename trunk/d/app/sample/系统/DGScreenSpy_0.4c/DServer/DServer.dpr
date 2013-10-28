program DServer;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  ScreenSpy in 'ScreenSpy.pas',
  ZLibEx in '..\ZLibEx\ZLibEx.pas';

begin
  Application.Initialize;
  Application.Title := 'DGScreenSpy - Server';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
