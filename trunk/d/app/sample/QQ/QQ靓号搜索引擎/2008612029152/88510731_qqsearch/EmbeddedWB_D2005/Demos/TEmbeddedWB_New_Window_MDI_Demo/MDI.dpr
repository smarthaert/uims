{ MDI Embedded Web Browser Demo by bsalsa
 updates: http://www.bsalsa.com/ }

program MDI;

uses
  Forms,
  frmMain in 'frmMain.pas' {MainFrm},
  Child in 'Child.pas' {ChildFrm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainFrm, MainFrm);
  Application.Run;
end.
