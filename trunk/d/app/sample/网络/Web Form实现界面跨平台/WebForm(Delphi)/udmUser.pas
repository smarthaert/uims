unit udmUser;

interface

uses
  {$IFDEF Linux}QForms, {$ELSE}Forms, {$ENDIF}
  SysUtils, Classes, Provider, DB, ADODB;

type
  TUserDM = class(TDataModule)
    adcUser: TADOConnection;
    adqByName: TADOQuery;
    dspUser: TDataSetProvider;
    adqTemp: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
  public
  end;

// Procs
  function UserDM:TUserDM;
  
const
  ADO_STRING='Provider=Microsoft.Jet.OLEDB.4.0;Data Source=wz.mdb;Persist Security Info=False' ;

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

function UserDM:TUserDM;
begin
  Result := TUserSession(RWebApplication.Data).UserDM;
end;

procedure TUserDM.DataModuleCreate(Sender: TObject);
begin
  adcUser.ConnectionString:=ADO_STRING;
end;

end.
 