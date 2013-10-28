unit ServerController;
{PUBDIST}

interface

uses
  SysUtils, Classes, IWServerControllerBase,
  // For OnNewSession Event
  DBClient,Contnrs,
  IWApplication, IWAppForm;

type
  TIWServerController = class(TIWServerControllerBase)
    procedure IWServerControllerBaseNewSession(ASession: TIWApplication;
      var VMainForm: TIWAppForm);
  private
  public
  end;

  // This is a class which you can add variables to that are specific to the user. Add variables
  // to this class instead of creating global variables. This object can references by using:
  //   UserSession
  // So if a variable named UserName of type string is added, it can be referenced by using:
  //   UserSession.UserName
  // Such variables are similar to globals in a normal application, however these variables are
  // specific to each user.
  //
  // See the IntraWeb Manual for more details.
  TProfile = class(TObject)
  public
    Name : String;
    Dep : String;
    Password :String;
    Job : String;
  end;

  TUserSession = class(TComponent)
  public
    ProfileList: TObjectList;
    ClientDataSet1:TClientDataSet;
    FMan:TProfile;
    constructor Create(AOwner: TComponent); override;
  end;

// Procs
  function UserSession: TUserSession;

implementation
{$R *.dfm}

uses
  IWInit;

{ TUserSession }

constructor TUserSession.Create(AOwner: TComponent);
var
 i:integer;
 AMan:TProfile;
begin
  inherited;
  ProfileList:=TObjectList.Create(True);
  ClientDataSet1:=TClientDataSet.create(nil);
  FMan:=TProfile.Create;
  try
    ClientDataSet1.LoadFromFile('login.dat');
    ClientDataSet1.Active:=True;
    for i:=1 to ClientDataSet1.RecordCount  do
    begin
      AMan:=TProfile.Create;
      AMan.Name:=ClientDataSet1.FieldByName('Name').AsString;
      AMan.Job:=ClientDataSet1.FieldByName('Job').AsString;
      AMan.Dep:=ClientDataSet1.FieldByName('Dep').AsString;
      AMan.Password :=ClientDataSet1.FieldByName('Password').AsString;
      ProfileList.Add(AMan);
      ClientDataSet1.Next;
    end;
  finally
    ClientDataSet1.free;
  end;
end;

function UserSession: TUserSession;
begin
  Result := TUserSession(RWebApplication.Data);
end;

procedure TIWServerController.IWServerControllerBaseNewSession(
  ASession: TIWApplication; var VMainForm: TIWAppForm);
begin
  ASession.Data := TUserSession.Create(ASession);
end;

end.
 