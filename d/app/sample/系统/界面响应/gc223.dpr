program gc223;

uses
  Forms,
  dy223 in 'dy223.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
