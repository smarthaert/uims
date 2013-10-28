program ExportSample2_p;

uses
  Forms,
  ExportSample2 in 'ExportSample2.pas' {FormCondFormatting};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormCondFormatting, FormCondFormatting);
  Application.Run;
end.
