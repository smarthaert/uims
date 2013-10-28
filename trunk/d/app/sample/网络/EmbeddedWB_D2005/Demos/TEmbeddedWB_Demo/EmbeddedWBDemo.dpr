program EmbeddedWBDemo;

uses
  Forms,
  Demo in 'Demo.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
