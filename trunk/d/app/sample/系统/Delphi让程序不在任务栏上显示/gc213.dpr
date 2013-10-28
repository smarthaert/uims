program gc213;

uses
  Forms,
  dy213 in 'dy213.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
