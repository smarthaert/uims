program proBBS;

uses
  Forms,
  untBBS in 'untBBS.pas' {frmBBS},
  untMod in 'untMod.pas',
  untBBSThread in 'untBBSThread.pas';

{$R *.res}
begin
  Application.Initialize;
  Application.Title := '麻山论刀灌水机';
  Application.CreateForm(TfrmBBS, frmBBS);
  Application.Run;
end.
