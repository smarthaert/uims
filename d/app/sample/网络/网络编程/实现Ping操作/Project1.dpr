program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {TMyPing};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TTMyPing, TMyPing);
  Application.Run;
end.
