unit DatamoduleUnit;
//Download by http://www.codefans.net
interface

uses
  {$IFDEF Linux}QForms, {$ELSE}Forms, {$ENDIF}
  SysUtils, Classes;

type
  TDataModule1 = class(TDataModule)
  private
  public
  end;

// Procs
  function DataModule1: TDataModule1;

implementation
{$R *.dfm}

uses
  IWInit,
  ServerController;

// Since we are threaded we cannot use global variables to store form / datamodule references
// so we store them in WebApplication.Data and we could reference that each time, but by creating
// a function like this our other code looks "normal" almost as if its referencing a global.
// This function is not necessary but it makes the code in the main form which references this
// datamodule a lot neater.
// Without this function ever time we would reference this datamodule we would use:
//   TDataModule1(WebApplication.Data).Datamodule.<method / component>
// By creating this procedure it becomes:
//   TDataModule1.<method / component>
// Which is just like normal Delphi code.
function DataModule1: TDataModule1;
begin
  Result := TUserSession(RWebApplication.Data).Datamodule1;
end;

end.
 