program demoprj;

uses
  Forms,
  demo in 'demo.pas' {frmMain},
  test in 'test.pas',
  about in 'about.pas' {frmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.
