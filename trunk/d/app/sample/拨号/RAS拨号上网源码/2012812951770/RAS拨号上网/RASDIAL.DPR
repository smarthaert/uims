program RasDial;


//lll;{$R 'RasIcon.res' 'RasIcon.RC'}

{$R 'RasIcon.res' 'RasIcon.RC'}

uses
  Forms,
  RasDial1 in 'RASDIAL1.PAS' {RasDialerForm},
  Ras in 'Ras.pas',
  Formpos in 'Formpos.pas',
  FormAuto in 'FORMAUTO.PAS' {AutoForm},
  RasDial2 in 'RasDial2.pas' {AboutForm},
  RasDial3 in 'RasDial3.pas' {ConfigureAutoForm},
  JpgPast in 'JpgPast.pas' {JpgPastForm};

{$R *.RES}

begin
//  Log := TLogMsg.Create('');
  Application.Initialize;
  Application.Title := '铁通陕西分公司天天上网拨号器';
  Application.CreateForm(TRasDialerForm, RasDialerForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(TConfigureAutoForm, ConfigureAutoForm);
  Application.CreateForm(TJpgPastForm, JpgPastForm);
  Application.Run;
//  Log.Destroy;
end.
