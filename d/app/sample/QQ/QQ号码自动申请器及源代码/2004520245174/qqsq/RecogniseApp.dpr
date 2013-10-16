program RecogniseApp;

uses
  Forms,
  RecogniseUnit in 'RecogniseUnit.pas' {FormRecognise};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormRecognise, FormRecognise);
  Application.Run;
end.
