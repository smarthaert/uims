program RSRStockDemo;

uses
  Forms,
  frmMain in 'frmMain.pas' {Form1},
  TDXGrobal in 'TDXGrobal.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
