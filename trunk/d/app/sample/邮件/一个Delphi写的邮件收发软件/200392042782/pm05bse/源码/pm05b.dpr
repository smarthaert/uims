program pm05b;

uses
  Forms,
  main in 'main.pas' {fmMain},
  NewUser in 'NewUser.pas' {fmAddNewUser},
  UseSet in 'UseSet.pas' {fmUserSet},
  Send in 'Send.pas' {fmSend},
  AsNote in 'AsNote.pas' {fmAsN},
  addNewAs in 'addNewAs.pas' {fmAddNewAs},
  asSet in 'asSet.pas' {fmAsSet},
  chUser in 'chUser.pas' {fmChangeUser},
  getmail in 'getmail.pas' {fmGetMail},
  about in 'about.pas' {fmAbout};

{$R *.res}

begin
  Application.Initialize;
  fmAbout:=TfmAbout.Create(Application);
  fmAbout.Show;
  fmAbout.Update;
  Application.CreateForm(TfmMain, fmMain);
  fmAbout.Close;
  Application.Run;
end.
