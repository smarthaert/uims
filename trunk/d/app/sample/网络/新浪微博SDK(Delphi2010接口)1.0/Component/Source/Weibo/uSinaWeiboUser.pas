unit uSinaWeiboUser;

interface

uses
  Windows,SysUtils,uLkJSON,Variants,Forms,
  DownloadFileTask,
  uSinaWeiboAPI_Statuses_Verify_Credentials,
  uSinaWeiboAPI;


const
  Const_UsersPathName='Users';
  Const_UserPersonalInfoPathName='PersonalInfo';
  Const_UserWeiboItemImagesPathName='WeiboItemImages';
  Const_UserWeiboHeadImagesPathName='WeiboHeadImages';
  Const_UserSettingPathName='Setting';
  Const_UserHeadImageFileName='Head.jpg';

type
  //新浪微博用户信息
  TSinaWeiboUser=class
  private
    FLocation: String;
    FName: String;
    FProfile_Image_URL: String;
    FStatus_Geo: String;
    FStatus_Truncated: Boolean;
    FDomain: string;
    FStatus_In_Reply_To_Screen_Name: string;
    FDescription: String;
    FVerified: Boolean;
    FFollowing: Boolean;
    FCreated_At: String;
    FProvince: Integer;
    FStatus_Favorited: Boolean;
    FScreen_Name: String;
    FFavourites_Count: Integer;
    FStatus_Source: String;
    FGender: String;
    FID: String;
    FStatus_Created_At: String;
    FStatuses_Count: Integer;
    FStatus_In_Reply_To_Status_Id: string;
    FGeo_Enabled: Boolean;
    FFollowers_Count: Integer;
    FStatus_ID: Int64;
    FFriends_Count: Integer;
    FCity: Integer;
    FURL: String;
    FStatus_Mid: String;
    FStatus_In_Reply_To_User_Id: string;
    FStatus_Annotations: string;
    FStatus_Text: string;
    FPassword: AnsiString;
    FUserName: AnsiString;
    function GetWeiboItemImagesPath: String;
    function GetSettingPath: String;
    function GetPersonalInfoPath: String;
    function GetBinPath:String;
    function GetUsersPath:String;
    function GetUserPath:String;
    procedure ForceDirectory(APath:String);
    function GetHeadImageFile:String;
    function GetWeiboHeadImagesPath: String;
  public
    constructor Create;
    Destructor Destroy;override;
    function LoadFromAPI(APIItem:TSinaWeiboAPIItem):Boolean;
    ////////////////////////////路径///////////////////////////////
    //个人资料路径
    property PersonalInfoPath:String read GetPersonalInfoPath;
    //微博临时图片存放路径
    property WeiboItemImagesPath:String read GetWeiboItemImagesPath;
    //微博头像图片存放路径
    property WeiboHeadImagesPath:String read GetWeiboHeadImagesPath;
    //设置文件存放路径
    property SettingPath:String read GetSettingPath;
    //用户的头像文件
    property HeadImageFile:String read GetHeadImageFile;
    //从服务器下载用户头像
    procedure DownloadProfileImage;
    //本地是否已经存在用户头像的图片
    function ExistsUserHeadImage(AUserID:String):Boolean;
  public
    ///////////////////////用户资源////////////////////////////////////
    //id
    property ID:String read FID write FID;
    //screen_name
    property Screen_Name:String read FScreen_Name write FScreen_Name;
    //name
    property Name:String read FName write FName;
    //province
    property Province:Integer read FProvince write FProvince;
    //city
    property City:Integer read FCity write FCity;
    //location
    property Location:String read FLocation write FLocation;
    //description
    property Description:String read FDescription write FDescription;
    //url
    Property URL:String read FURL write FURL;
    //profile_image_url
    property Profile_Image_URL:String read FProfile_Image_URL write FProfile_Image_URL;
    //domain
    property Domain:string read FDomain write FDomain;
    //gender
    property Gender:String read FGender write FGender;
    //followers_count
    property Followers_Count:Integer read FFollowers_Count write FFollowers_Count;
    //friends_count
    property Friends_Count:Integer read FFriends_Count write FFriends_Count;
    //statuses_count
    property Statuses_Count:Integer read FStatuses_Count write FStatuses_Count;
    //favourites_count
    property Favourites_Count:Integer read FFavourites_Count write FFavourites_Count;
    //createed_at
    property Created_At:String read FCreated_At write FCreated_At;
    //following
    property Following:Boolean read FFollowing write FFollowing;
    //gdo_enabled
    property Geo_Enabled:Boolean read FGeo_Enabled write FGeo_Enabled;
    //verified
    property Verified:Boolean read FVerified write FVerified;
    //以下是status
    //created_at
    property Status_Created_At:String read FStatus_Created_At write FStatus_Created_At;
    //id
    property Status_ID:Int64 read FStatus_ID write FStatus_ID;
    //text
    property Status_Text:string read FStatus_Text write FStatus_Text;
    //source
    property Status_Source:String read FStatus_Source write FStatus_Source;
    //favoorited
    property Status_Favorited:Boolean read FStatus_Favorited write FStatus_Favorited;
    //truncated
    property Status_Truncated:Boolean read FStatus_Truncated write FStatus_Truncated;
    //in_reply_to_status_id
    property Status_In_Reply_To_Status_Id:string read FStatus_In_Reply_To_Status_Id write FStatus_In_Reply_To_Status_Id;
    //in_reply_to_user_id
    property Status_In_Reply_To_User_Id:string read FStatus_In_Reply_To_User_Id write FStatus_In_Reply_To_User_Id;
    //in_reply_to_screen_name
    property Status_In_Reply_To_Screen_Name:string read FStatus_In_Reply_To_Screen_Name write FStatus_In_Reply_To_Screen_Name;
    //geo
    property Status_Geo:String read FStatus_Geo write FStatus_Geo;
    //mid
    property Status_Mid:String read FStatus_Mid write FStatus_Mid;
    //annotations
    property Status_Annotations:string read FStatus_Annotations write FStatus_Annotations;
    //用户名
    property UserName:AnsiString read FUserName write FUserName;
    //密码
    property Password:AnsiString read FPassword write FPassword;
  end;


implementation



{ TSinaWeiboUser }

constructor TSinaWeiboUser.Create;
begin
  FLocation:='';
  FName:='';
  FProfile_Image_URL:='';
  FStatus_Geo:='';
  FStatus_Truncated:=False;
  FDomain:='';
  FStatus_In_Reply_To_Screen_Name:='';
  FDescription:='';
  FVerified:=False;
  FFollowing:=False;
  FCreated_At:='';
  FProvince:=0;
  FStatus_Favorited:=False;
  FScreen_Name:='';
  FFavourites_Count:=0;
  FStatus_Source:='';
  FGender:='';
  FID:='';
  FStatus_Created_At:='';
  FStatuses_Count:=0;
  FStatus_In_Reply_To_Status_Id:='';
  FGeo_Enabled:=False;
  FFollowers_Count:=0;
  FStatus_ID:=0;
  FFriends_Count:=0;
  FCity:=0;
  FURL:='';
  FStatus_Mid:='';
  FStatus_In_Reply_To_User_Id:='';
  FStatus_Annotations:='';
  FStatus_Text:='';
end;

destructor TSinaWeiboUser.Destroy;
begin

  inherited;
end;


procedure TSinaWeiboUser.DownloadProfileImage;
var
  ATask:TDownloadFileTask;
begin
  ATask:=TDownloadFileTask.Create(nil);
  ATask.DownloadURL:='';
  //路径最后一个要加反杠,否则会保存到上级目录中去的
  ATask.SaveFileDir:='';
  //添加下载
  ATask.AddDownLoad(Self.FProfile_Image_URL,Self.HeadImageFile);
  //开始下载
  ATask.BeginTask;
end;

function TSinaWeiboUser.ExistsUserHeadImage(AUserID: String): Boolean;
begin
  Result:=False;
  if FileExists( Self.WeiboHeadImagesPath+AUserID+'.jpg' ) then
  begin
    Result:=True;
  end;
end;

procedure TSinaWeiboUser.ForceDirectory(APath: String);
begin
  if Not DirectoryExists(APath) then
  begin
    SysUtils.ForceDirectories(APath);
  end;
end;

function TSinaWeiboUser.GetBinPath: String;
begin
  Result:=ExtractFilePath(Application.ExeName);
end;

function TSinaWeiboUser.GetHeadImageFile: String;
begin
  Result:=Self.GetPersonalInfoPath+Const_UserHeadImageFileName;
end;

function TSinaWeiboUser.GetWeiboHeadImagesPath: String;
begin
  Result:=GetUserPath+Const_UserWeiboHeadImagesPathName+'\';
  ForceDirectory(Result);
end;

function TSinaWeiboUser.GetWeiboItemImagesPath: String;
begin
  Result:=GetUserPath+Const_UserWeiboItemImagesPathName+'\';
  ForceDirectory(Result);
end;

function TSinaWeiboUser.GetSettingPath: String;
begin
  Result:=GetUserPath+Const_UserSettingPathName+'\';
  ForceDirectory(Result);
end;

function TSinaWeiboUser.GetPersonalInfoPath: String;
begin
  Result:=GetUserPath+Const_UserPersonalInfoPathName+'\';
  ForceDirectory(Result);
end;

function TSinaWeiboUser.GetUserPath: String;
begin
  Result:=Self.GetUsersPath+Self.FUserName+'\';
  ForceDirectory(Result);
end;

function TSinaWeiboUser.GetUsersPath: String;
begin
  Result:=Self.GetBinPath+Const_UsersPathName+'\';
  ForceDirectory(Result);
end;

function TSinaWeiboUser.LoadFromAPI(APIItem: TSinaWeiboAPIItem):Boolean;
var
  API:TSinaWeiboAPI_Statuses_Verify_Credentials;
begin
  Result:=False;
  API:=TSinaWeiboAPI_Statuses_Verify_Credentials(APIItem);

  if API=nil then Exit;

  FID:=API.ID;
  FLocation:=API.Location;
  FName:=API.Name;
  FProfile_Image_URL:=API.Profile_Image_URL;
  FDomain:=API.Domain;
  FDescription:=API.Description;
  FVerified:=API.Verified;
  FFollowing:=API.Following;
  FCreated_At:=API.Created_At;
  FProvince:=API.Province;
  FScreen_Name:=API.Screen_Name;
  FFavourites_Count:=API.Favourites_Count;
  FGender:=API.Gender;
  FGeo_Enabled:=API.Geo_Enabled;
  FFollowers_Count:=API.Followers_Count;
  FFriends_Count:=API.Friends_Count;
  FCity:=API.City;
  FURL:=API.URL;
  FStatuses_Count:=API.Statuses_Count;

  FStatus_ID:=API.Status_ID;
  FStatus_Mid:=API.Status_Mid;
  FStatus_In_Reply_To_User_Id:=API.Status_In_Reply_To_User_Id;
  //注释
  FStatus_Annotations:=API.Status_Annotations;
  FStatus_Text:=API.Status_Text;
  FStatus_Geo:=API.Status_Geo;
  FStatus_Truncated:=API.Status_Truncated;
  FStatus_Created_At:=API.Status_Created_At;
  FStatus_In_Reply_To_Status_Id:=API.Status_In_Reply_To_Status_Id;
  FStatus_Source:=API.Status_Source;
  FStatus_Favorited:=API.Status_Favorited;
  FStatus_In_Reply_To_Screen_Name:=API.Status_In_Reply_To_Screen_Name;

  Result:=True;
end;


end.
