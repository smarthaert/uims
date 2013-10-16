program GetTime;

uses
  Forms,
  timeform in 'timeform.pas' {FormTime};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'GetTime';
  Application.CreateForm(TFormTime, FormTime);
  Application.Run;
end.
