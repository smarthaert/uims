unit psCodeContacts;

interface

uses Classes, SysUtils;

type

  TpsContents = (ccContact, ccCalendarEvent, ccEmailAddress, ccGeoLocation,
    ccPhoneNumber, ccSMS, ccText, ccURL, ccWifiNetwork);

  TpsContact = class(TPersistent)
  private
    FContents: TpsContents;
    FName: String;
    FEmail: String;
    FURL: String;
    FCompany: string;
    FPhoneNumber: string;
    FAddress2: string;
    FAddress: string;
    FMemo: string;
    FLatitude: string;
    FLocation: string;
    FDeclination: string;
    procedure DoChange;
    procedure SetContents(const Value: TpsContents);
    procedure SetName(const Value: String);
    procedure SetEmail(const Value: String);
    procedure SetURL(const Value: String);
    procedure SetCompany(const Value: string);
    procedure SetPhoneNumber(const Value: string);
    procedure SetAddress(const Value: string);
    procedure SetAddress2(const Value: string);
    procedure SetMemo(const Value: string);
    procedure SetDeclination(const Value: string);
    procedure SetLatitude(const Value: string);
    procedure SetLocation(const Value: string);
  public
    function MessageToEncode:String;
  published
    property Contents : TpsContents read FContents write SetContents;
    property Name : String read FName write SetName;
    property Company:string read FCompany write SetCompany;
    property PhoneNumber:string read FPhoneNumber write SetPhoneNumber;
    property Address:string read FAddress write SetAddress;
    property Address2:string read FAddress2 write SetAddress2;
    property Email: String read FEmail write SetEmail;
    property URL:String read FURL write SetURL;
    property Memo:string read FMemo write SetMemo;
    property Latitude:string read FLatitude write SetLatitude;
    property Declination:string read FDeclination write SetDeclination;
    property Location:string read FLocation write SetLocation;
  end;


implementation

{ TpsContact }

procedure TpsContact.DoChange;
begin
  {};
end;

function TpsContact.MessageToEncode: String;
begin
  Result := '';
  case FContents of
    ccContact         : ;
    ccCalendarEvent   : ;
    ccEmailAddress    : Result := Format('mailto:%s',[FEmail]);
    ccGeoLocation     : Result:=Format('geo:%s,%s?q=$s', [Latitude, Declination, Location]);
    ccPhoneNumber     : Result := Format('tel:%s',[FPhoneNumber]);
    ccSMS             : Result := Format('smsto:%s:%s',[FPhoneNumber, FMemo]);
    ccText            : ;
    ccURL             : ;
    ccWifiNetwork     : ;
  end;
end;

procedure TpsContact.SetAddress(const Value: string);
begin
  FAddress := Value;
  DoChange;
end;

procedure TpsContact.SetAddress2(const Value: string);
begin
  FAddress2 := Value;
  DoChange;
end;

procedure TpsContact.SetCompany(const Value: string);
begin
  FCompany := Value;
  DoChange;
end;

procedure TpsContact.SetContents(const Value: TpsContents);
begin
  FContents := Value;
  DoChange;
end;

procedure TpsContact.SetDeclination(const Value: string);
begin
  FDeclination := Value;
  DoChange;
end;

procedure TpsContact.SetEmail(const Value: String);
begin
  FEmail := Value;
  DoChange;
end;

procedure TpsContact.SetLatitude(const Value: string);
begin
  FLatitude := Value;
  DoChange;
end;

procedure TpsContact.SetLocation(const Value: string);
begin
  FLocation := Value;
  DoChange;
end;

procedure TpsContact.SetMemo(const Value: string);
begin
  FMemo := Value;
  DoChange;
end;

procedure TpsContact.SetName(const Value: String);
begin
  FName := Value;
  DoChange;
end;

procedure TpsContact.SetPhoneNumber(const Value: string);
begin
  FPhoneNumber := Value;
  DoChange;
end;

procedure TpsContact.SetURL(const Value: String);
begin
  FURL := Value;
  DoChange;
end;

end.
