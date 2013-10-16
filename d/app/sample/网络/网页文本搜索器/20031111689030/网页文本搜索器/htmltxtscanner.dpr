program htmltxtscanner;

uses
  AntiIDEOnly, Forms,
  main in 'main.pas' {frm_main};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_main, frm_main);
  Application.Run;
end.
