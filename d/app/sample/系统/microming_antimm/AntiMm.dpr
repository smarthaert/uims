program AntiMm;

uses
  Forms,
  Unit1 in 'Unit1.pas' {MForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ÍøÒ³Ä¾ÂíÃâÒß';
  Application.CreateForm(TMForm, MForm);
  Application.Run;
end.
