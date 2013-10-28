program GreenFetion;

uses
  Forms,
  UnitMain in 'UnitMain.pas' {FormMain},
  UnitSHA1 in 'UnitSHA1.pas',
  UnitSHATools in 'UnitSHATools.pas',
  UnitLogin in 'UnitLogin.pas' {FormLogin},
  IEHTTP3 in 'IEHttp\IEHTTP3.pas',
  iehttp4_thread in 'IEHttp\iehttp4_thread.pas',
  iiehttp3_funcs in 'IEHttp\iiehttp3_funcs.pas',
  tntlite in 'IEHttp\tntlite.pas',
  WinInet_Ex in 'IEHttp\WinInet_Ex.pas',
  About in 'About.pas' {FormAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.Run;
end.
