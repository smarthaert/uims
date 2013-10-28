program test;

uses
  Forms,
  DateWin in 'DateWin.pas' {FRM_Date},
  DateCn in 'DateCn.pas';
{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFRM_Date, FRM_Date);
  Application.Run;
end.
