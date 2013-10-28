unit uUserMaint;
interface
//Download by http://www.codefans.net
uses
  Windows, Messages, SysUtils, Variants, Classes,DBClient,udmUser;

type
  TUserMaint = class (TObject)
  {private
    UserDM:TUserDM;}
  public
    function GetDepList: TStrings;
    function GetUserList(strName:String): OLEVariant;
    procedure UpdateUserData(UserData:OleVariant;Out ErrCount: Integer);
    {
    constructor create;
    destructor Destroy;override;
    }
  end;
  
implementation


{
********************************** TUserMaint **********************************
}
{
constructor TUserMaint.create;
begin
  UserDM:=TUserDM.Create(nil);
end;

destructor TUserMaint.Destroy;
begin
  freeandnil(UserDM);
  inherited;
end;
}

function TUserMaint.GetDepList: TStrings;
var
  i: Integer;
  tmpstrs: TStrings;
begin
  tmpstrs:=TStringlist.Create;
  
  with UserDM do
  try
    if not adcUser.Connected then
       adcUser.Connected:=True;
    adqTemp.sql.Clear;
    adqTemp.sql.add('select * from M_BMBM');
    adqTemp.Open;
    for i:=1 to  adqTemp.RecordCount do
    begin
      tmpstrs.Add(adqTemp.Fieldbyname('BMMC').AsString);
      adqTemp.Next;
    end;
    adqTemp.Close;
    result:=tmpstrs;
  finally
    adcUser.Connected:=False;
  end;
end;

function TUserMaint.GetUserList(strName:String): OLEVariant;
begin
  with UserDM do
  try
    if not adcUser.Connected then
       adcUser.Connected:=True;
    with  adqByName do
    begin
      close;
      Parameters.ParamByName('name').value:='%'+strName+'%';
      open;
      result:=dspUser.Data;
    end;
  finally
    adcUser.Connected:=False;
  end;
end;

procedure TUserMaint.UpdateUserData(UserData:OleVariant;Out ErrCount: Integer);
begin
  UserDM.dspUser.ApplyUpdates(UserData,0,ErrCount);
end;

end.
