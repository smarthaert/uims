program Acc_Frm;

uses
  Forms,
  AccPass in 'AccPass.pas' {Acc};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TAcc, Acc);
  Application.Run;
end.
