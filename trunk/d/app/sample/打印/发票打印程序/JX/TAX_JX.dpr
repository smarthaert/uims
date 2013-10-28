program TAX_JX;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  Query in 'Query.pas' {FrmQuery},
  ClassJX in 'ClassJX.pas',
  Environment in 'Environment.pas' {FrmEnvironment},
  GlbVar in 'GlbVar.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'TAXÏµÁÐÈí¼þ¡£';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.

