program cachedemo;

uses
  Forms,
  cachedemo_u in 'cachedemo_u.pas' {Form1};


{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
