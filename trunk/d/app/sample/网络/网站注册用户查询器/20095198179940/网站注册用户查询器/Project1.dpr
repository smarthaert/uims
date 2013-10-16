program Project1;

uses
  Forms,
  mainUnit in 'mainUnit.pas' {mainForm},
  dmUnit in 'dmUnit.pas' {dm: TDataModule},
  WZBJUnit in 'WZBJUnit.pas' {WZBJForm},
  IELLQUnit in 'IELLQUnit.pas' {IELLQForm},
  ADDRULUnit in 'ADDRULUnit.pas' {AddURLForm},
  SJKBFUnit in 'SJKBFUnit.pas' {SJKBFForm},
  DCEXCLEUnit in 'DCEXCLEUnit.pas' {DCEXCLEForm},
  DCTXTUnit in 'DCTXTUnit.pas' {DCTXTForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ÍøÕ¾×¢²áÓÃ»§²éÑ¯Æ÷';
  Application.CreateForm(TmainForm, mainForm);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TWZBJForm, WZBJForm);
  Application.CreateForm(TIELLQForm, IELLQForm);
  Application.CreateForm(TAddURLForm, AddURLForm);
  Application.CreateForm(TSJKBFForm, SJKBFForm);
  Application.CreateForm(TDCEXCLEForm, DCEXCLEForm);
  Application.CreateForm(TDCTXTForm, DCTXTForm);
  Application.Run;
end.
