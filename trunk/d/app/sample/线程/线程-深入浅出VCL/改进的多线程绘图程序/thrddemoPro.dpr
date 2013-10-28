program thrddemoPro;

uses
  Forms,
  frmThds in 'frmThds.pas' {Form1},
  Thds in 'Thds.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
