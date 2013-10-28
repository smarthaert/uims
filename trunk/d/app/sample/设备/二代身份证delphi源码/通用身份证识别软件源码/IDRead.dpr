program IDRead;

uses
  Forms,
  Main_U in 'Main_U.pas' {IDCardRead_F},
  IDCardClass_U in 'IDCardClass_U.pas',
  IDCardDll_U in 'IDCardDll_U.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TIDCardRead_F, IDCardRead_F);
  Application.Run;
end.
