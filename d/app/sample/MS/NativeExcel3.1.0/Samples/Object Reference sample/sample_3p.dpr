program sample_3p;

uses
  Forms,
  sample_3 in 'sample_3.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
