program gc201;

uses
  Forms,
  dy201 in 'dy201.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
