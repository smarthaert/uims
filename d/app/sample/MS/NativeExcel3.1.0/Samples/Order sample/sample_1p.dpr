program sample_1p;

uses
  Forms,
  sample_1 in 'sample_1.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
