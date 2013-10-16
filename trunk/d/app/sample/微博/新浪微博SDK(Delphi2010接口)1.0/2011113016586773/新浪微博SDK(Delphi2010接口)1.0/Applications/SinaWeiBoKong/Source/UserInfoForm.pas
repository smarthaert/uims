unit UserInfoForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,uSinaWeiboCity, StdCtrls, ExtCtrls,uSinaWeiboClient;

type
  TfrmUserInfo = class(TForm)
    cmbProvince: TComboBox;
    cmbCity: TComboBox;
    lblCity: TLabel;
    lblProvince: TLabel;
    lblNickName: TLabel;
    edtNickName: TEdit;
    lblAddress: TLabel;
    edtAddress: TEdit;
    memDescription: TMemo;
    lblDescription: TLabel;
    lblUID: TLabel;
    edtUID: TEdit;
    lblDomain: TLabel;
    edtDomain: TEdit;
    Image1: TImage;
    lblGender: TLabel;
    edtFollowersCount: TEdit;
    lblFollowersCount: TLabel;
    lblFriendsCount: TLabel;
    edtFriendsCount: TEdit;
    lblStatusesCount: TLabel;
    edtStatusesCount: TEdit;
    edtFavouritesCount: TEdit;
    lblFavouritesCount: TLabel;
    chkVerified: TCheckBox;
    cmbGender: TComboBox;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure cmbProvinceChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FClient:TSinaWeiboClient;
    { Private declarations }
  public
    procedure SetUserInfo(AClient:TSinaWeiboClient);
    { Public declarations }
  end;

procedure ShowUserInfo(AClient:TSinaWeiboClient);

implementation

var
  frmUserInfo: TfrmUserInfo;

procedure ShowUserInfo(AClient:TSinaWeiboClient);
begin
  if frmUserInfo=nil then
    frmUserInfo:=TfrmUserInfo.Create(Application);
  frmUserInfo.SetUserInfo(AClient);
  frmUserInfo.Show;
end;


{$R *.dfm}

procedure TfrmUserInfo.Button1Click(Sender: TObject);
begin
  //
  Self.FClient.User.DownloadProfileImage;
end;

procedure TfrmUserInfo.cmbProvinceChange(Sender: TObject);
var
  I: Integer;
begin
  Self.cmbCity.Clear;
  for I := 0 to GlobalSinaWeiboCity.Provinces[Self.cmbProvince.ItemIndex].Citys.Count- 1 do
  begin
    Self.cmbCity.AddItem(GlobalSinaWeiboCity.Provinces[Self.cmbProvince.ItemIndex].Citys[I].CityName,
                      GlobalSinaWeiboCity.Provinces[Self.cmbProvince.ItemIndex].Citys[I] );
  end;
  Self.cmbCity.ItemIndex:=0;
end;

procedure TfrmUserInfo.FormCreate(Sender: TObject);
var
  I: Integer;
begin

  Self.cmbProvince.Clear;
  for I := 0 to GlobalSinaWeiboCity.Provinces.Count- 1 do
  begin
    Self.cmbProvince.AddItem(GlobalSinaWeiboCity.Provinces[I].ProvinceName,GlobalSinaWeiboCity.Provinces[I] );
  end;
  Self.cmbProvince.ItemIndex:=0;

  Self.cmbCity.Clear;
  for I := 0 to GlobalSinaWeiboCity.Provinces[Self.cmbProvince.ItemIndex].Citys.Count- 1 do
  begin
    Self.cmbCity.AddItem(GlobalSinaWeiboCity.Provinces[Self.cmbProvince.ItemIndex].Citys[I].CityName,
                      GlobalSinaWeiboCity.Provinces[Self.cmbProvince.ItemIndex].Citys[I] );
  end;
  Self.cmbCity.ItemIndex:=0;

end;

procedure TfrmUserInfo.SetUserInfo(AClient: TSinaWeiboClient);
begin

    FClient:=AClient;

    Self.edtNickName.Text:=FClient.User.Screen_Name;
    Self.edtUID.Text:=FClient.User.ID;
    Self.chkVerified.Checked:=FClient.User.Verified;
    if FClient.User.Gender='m' then
    begin
      Self.cmbGender.ItemIndex:=0;
    end else if FClient.User.Gender='f' then
    begin
      Self.cmbGender.ItemIndex:=1;
    end
    else
    begin
      Self.cmbGender.ItemIndex:=2;
    end;


    Self.edtFollowersCount.Text:=IntToStr(FClient.User.Followers_Count);
    Self.edtFriendsCount.Text:=IntToStr(FClient.User.Friends_Count);
    Self.edtStatusesCount.Text:=IntToStr(FClient.User.Statuses_Count);
    Self.edtFavouritesCount.Text:=IntToStr(FClient.User.Favourites_Count);

    Self.edtDomain.Text:=FClient.User.Domain;


    Self.cmbProvince.ItemIndex:=Self.cmbProvince.Items.IndexOf(
          GlobalSinaWeiboCity.GetProvinceName(FClient.User.Province) );
    Self.cmbCity.ItemIndex:=Self.cmbCity.Items.IndexOf(
          GlobalSinaWeiboCity.GetCityName(FClient.User.Province,FClient.User.City) );

    Self.edtAddress.Text:=FClient.User.Location;

    Self.memDescription.Text:=FClient.User.Description;

    if FileExists(FClient.User.HeadImageFile) then
    begin
      Self.Image1.Picture.LoadFromFile(FClient.User.HeadImageFile );
    end
    else
    begin
      FClient.User.DownloadProfileImage;
    end;

end;

end.
