program InfoinINI;

uses
  Forms,
  frm_IniOp in 'frm_IniOp.pas' {FrmInfo};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmInfo, FrmInfo);
  Application.Run;
end.
