program RegSeekWang;

uses
  Forms,
  UntRegFrm in 'UntRegFrm.pas' {Form1},
  UntReg in '..\UntReg.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
