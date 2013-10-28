{ SDI Embedded Web Browser Demo by bsalsa
 updates: http://www.bsalsa.com/ }

program Tabs;

uses
  Forms,
  frmMain in 'frmMain.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
