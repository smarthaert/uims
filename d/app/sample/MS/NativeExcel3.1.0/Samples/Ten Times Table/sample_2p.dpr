program sample_2p;

uses
  Forms,
  sample_2 in 'sample_2.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
