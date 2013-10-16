program Projectipmac;

uses
  Forms,
  Unitipmac in 'Unitipmac.pas' {formarp};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'ipmactool';
  Application.CreateForm(Tformarp, formarp);
  Application.Run;
end.
