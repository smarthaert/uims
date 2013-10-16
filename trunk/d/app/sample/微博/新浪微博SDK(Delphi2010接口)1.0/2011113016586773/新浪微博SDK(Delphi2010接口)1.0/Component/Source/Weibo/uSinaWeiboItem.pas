unit uSinaWeiboItem;

interface

uses
  Windows,
  SysUtils,
  Classes,
  uLKJson,
  Variants;

type
  TSinaWeiboItemUserInfo=class
  private
    FLocation: String;
    FName: String;
    FProfile_Image_URL: String;
    FDomain: string;
    FVerified: Boolean;
    FFollowing: Boolean;
    FCreated_At: String;
    FProvince: Integer;
    FScreen_Name: String;
    FFavourites_Count: Integer;
    FGender: String;
    FID: String;
    FDescription: String;
    FGeo_Enabled: Boolean;
    FFollowers_Count: Integer;
    FStatuses_Count: Integer;
    FFriends_Count: Integer;
    FCity: Integer;
    FURL: String;
    FAllow_All_Act_Msg: Boolean;
  protected
  public
    constructor Create;
    destructor Destroy;override;
    procedure LoadFormJson(UserInfoJson:TlkJSONobject);
  public
    //字段说明 - user
    //id: 用户UID
    //screen_name: 微博昵称
    //name: 友好显示名称，同微博昵称
    //province: 省份编码（参考省份编码表）
    //city: 城市编码（参考城市编码表）
    //location：地址
    //description: 个人描述
    //url: 用户博客地址
    //profile_image_url: 自定义图像
    //domain: 用户个性化URL
    //gender: 性别,m--男，f--女,n--未知
    //followers_count: 粉丝数
    //friends_count: 关注数
    //statuses_count: 微博数
    //favourites_count: 收藏数
    //created_at: 创建时间
    //following: 是否已关注(此特性暂不支持)
    //verified: 加V标示，是否微博认证用户
    //Jason的属性
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
    //allow_all_act_msg
    property Allow_All_Act_Msg:Boolean read FAllow_All_Act_Msg write FAllow_All_Act_Msg;
  end;

  TSinaWeiboItem=class
  private
    FIn_Reply_To_Screen_Name: String;
    FFavorited: Boolean;
    FSource: String;
    FIn_Reply_To_Status_Id: String;
    FIn_Reply_To_Rser_Id: String;
    FId: String;
    FRetweeted_Status: TSinaWeiboItem;
    FAnnotations: String;
    FText: String;
    FUser: TSinaWeiboItemUserInfo;
    FGeo: String;
    FTruncated: Boolean;
    FCreated_At: String;
    FMId: String;
    FBMiddle_Pic: String;
    FOriginal_Pic: String;
    FThumbnail_Pic: String;
  protected
  public
    constructor Create;
    destructor Destroy;override;
    procedure LoadFromJson(WeiboItemJson:TlkJSONobject);
  public
    //字段说明 - status
    //created_at: 创建时间
    //id: 微博ID
    //text: 微博信息内容
    //source: 微博来源
    //favorited: 是否已收藏
    //truncated: 是否被截断
    //in_reply_to_status_id: 回复ID
    //in_reply_to_user_id: 回复人UID
    //in_reply_to_screen_name: 回复人昵称
    //thumbnail_pic: 缩略图
    //bmiddle_pic: 中型图片
    //original_pic：原始图片
    //user: 作者信息
    //retweeted_status: 转发的博文，内容为status，如果不是转发，则没有此字段
    //created_at
    property Created_At:String read FCreated_At write FCreated_At;
    //text
    property Text:String read FText write FText;
    //truncated
    property Truncated:Boolean read FTruncated write FTruncated;
    //retweeted_status  转载或是回复的微博信息
    property Retweeted_Status:TSinaWeiboItem read FRetweeted_Status write FRetweeted_Status;
    //in_reply_to_status_id
    property In_Reply_To_Status_Id:String read FIn_Reply_To_Status_Id write FIn_Reply_To_Status_Id;
    //annotations
    property Annotations:String read FAnnotations write FAnnotations;
    //in_reply_to_screen_name
    property In_Reply_To_Screen_Name:String read FIn_Reply_To_Screen_Name write FIn_Reply_To_Screen_Name;
    //geo
    property Geo:String read FGeo write FGeo;
    //user 发布的作者信息
    property User:TSinaWeiboItemUserInfo read FUser;
    //favorited
    property Favorited:Boolean read FFavorited write FFavorited;
    //in_reply_to_user_id
    property In_Reply_To_Rser_Id:String read FIn_Reply_To_Rser_Id write FIn_Reply_To_Rser_Id;
    //id
    property Id:String read FId write FId;
    //mid
    property MId:String read FMId write FMId;
    //source
    property Source:String read FSource write FSource;
    //thumbnail_pic: 缩略图
    property Thumbnail_Pic:String read FThumbnail_Pic write FThumbnail_Pic;
    //bmiddle_pic: 中型图片
    property BMiddle_Pic:String read FBMiddle_Pic write FBMiddle_Pic;
    //original_pic：原始图片
    property Original_Pic:String read FOriginal_Pic write FOriginal_Pic;
  end;

  TSinaWeiboList=class
  private
    FList:TList;
    function GetItem(Index: Integer): TSinaWeiboItem;
    procedure SetItem(Index: Integer; const Value: TSinaWeiboItem);
  protected
  public
    function Count:Integer;
    function Add:TSinaWeiboItem;
    procedure Clear;
    Constructor Create;
    destructor Destroy;override;
  public
    property Items[Index:Integer]:TSinaWeiboItem read GetItem write SetItem;default;
  end;

Implementation

{ TSinaWeiboItem }

constructor TSinaWeiboItem.Create;
begin
  FUser:=TSinaWeiboItemUserInfo.Create;
end;

destructor TSinaWeiboItem.Destroy;
begin
  FUser.Free;
  FreeAndNil(FRetweeted_Status);
  inherited;
end;

procedure TSinaWeiboItem.LoadFromJson(WeiboItemJson: TlkJSONobject);
var
  userInfoJson:TlkJSONobject;
  retweeted_statusJson:TlkJSONobject;
begin
  //创建时间
  if WeiboItemJson.Field['created_at']<>nil then
    Self.Created_At:=WeiboItemJson.Field['created_at'].Value;
  //id
  if WeiboItemJson.Field['id']<>nil then
    Self.Id:=WeiboItemJson.Field['id'].Value;
  //文本
  if WeiboItemJson.Field['text']<>nil then
    Self.Text:=WeiboItemJson.Field['text'].Value;
  //source
  if WeiboItemJson.Field['source']<>nil then
    Self.Source:=WeiboItemJson.Field['source'].Value;
  //favorited
  if WeiboItemJson.Field['favorited']<>nil then
    Self.Favorited:=WeiboItemJson.Field['favorited'].Value;

  //是否截断
  if WeiboItemJson.Field['truncated']<>nil then
    Self.Truncated:=WeiboItemJson.Field['truncated'].Value;
  //
  if WeiboItemJson.Field['in_reply_to_status_id']<>nil then
    Self.In_Reply_To_Status_Id:=WeiboItemJson.Field['in_reply_to_status_id'].Value;
  //in_reply_to_user_id
  if WeiboItemJson.Field['in_reply_to_user_id']<>nil then
    Self.In_Reply_To_Rser_Id:=WeiboItemJson.Field['in_reply_to_user_id'].Value;
  //
  //annotations
  //
  if WeiboItemJson.Field['in_reply_to_screen_name']<>nil then
    Self.In_Reply_To_Screen_Name:=WeiboItemJson.Field['in_reply_to_screen_name'].Value;
  //geo
  Self.Geo:='';
  if WeiboItemJson.Field['geo']<>nil then
  begin
    if Not VarIsNull(WeiboItemJson.Field['geo'].Value) then
      Self.Geo:=WeiboItemJson.Field['geo'].Value;
  end;
  //mid
  if WeiboItemJson.Field['mid']<>nil then
    Self.MId:=WeiboItemJson.Field['mid'].Value;
  //user
  UserInfoJson:=WeiboItemJson.Field['user'] as TlkJSONobject;
  if UserInfoJson<>nil then
  begin
    Self.FUser.LoadFormJson(UserInfoJson);
  end;

  //回复或是转载的微博信
  retweeted_statusJson:=WeiboItemJson.Field['retweeted_status'] as TlkJSONobject;
  if retweeted_statusJson<>nil then
  begin
    Self.Retweeted_Status:=TSinaWeiboItem.Create;
    Self.Retweeted_Status.LoadFromJson(retweeted_statusJson);
  end;
end;

{ TSinaWeiboItemUserInfo }

constructor TSinaWeiboItemUserInfo.Create;
begin
  //
end;

destructor TSinaWeiboItemUserInfo.Destroy;
begin

  inherited;
end;

procedure TSinaWeiboItemUserInfo.LoadFormJson(UserInfoJson: TlkJSONobject);
begin


  if UserInfoJson.Field['id']<>nil then
    Self.ID:=UserInfoJson.Field['id'].Value;
  if UserInfoJson.Field['location']<>nil then
    Self.Location:=UserInfoJson.Field['location'].Value;
  if UserInfoJson.Field['name']<>nil then
    Self.Name:=UserInfoJson.Field['name'].Value;
  if UserInfoJson.Field['profile_image_url']<>nil then
    Self.Profile_Image_URL:=UserInfoJson.Field['profile_image_url'].Value;
  if UserInfoJson.Field['domain']<>nil then
    Self.Domain:=UserInfoJson.Field['domain'].Value;
  if UserInfoJson.Field['description']<>nil then
    Self.Description:=UserInfoJson.Field['description'].Value;
  if UserInfoJson.Field['verified']<>nil then
    Self.Verified:=UserInfoJson.Field['verified'].Value;
  if UserInfoJson.Field['following']<>nil then
    Self.Following:=UserInfoJson.Field['following'].Value;
  if UserInfoJson.Field['created_at']<>nil then
    Self.Created_At:=UserInfoJson.Field['created_at'].Value;
  if UserInfoJson.Field['province']<>nil then
    Self.Province:=UserInfoJson.Field['province'].Value;
  if UserInfoJson.Field['screen_name']<>nil then
    Self.Screen_Name:=UserInfoJson.Field['screen_name'].Value;
  if UserInfoJson.Field['favourites_count']<>nil then
    Self.Favourites_Count:=UserInfoJson.Field['favourites_count'].Value;
  if UserInfoJson.Field['gender']<>nil then
    Self.Gender:=UserInfoJson.Field['gender'].Value;
  if UserInfoJson.Field['geo_enabled']<>nil then
    Self.Geo_Enabled:=UserInfoJson.Field['geo_enabled'].Value;
  if UserInfoJson.Field['followers_count']<>nil then
    Self.Followers_Count:=UserInfoJson.Field['followers_count'].Value;
  if UserInfoJson.Field['friends_count']<>nil then
    Self.Friends_Count:=UserInfoJson.Field['friends_count'].Value;
  if UserInfoJson.Field['city']<>nil then
    Self.City:=UserInfoJson.Field['city'].Value;
  if UserInfoJson.Field['url']<>nil then
    Self.URL:=UserInfoJson.Field['url'].Value;
  if UserInfoJson.Field['statuses_count']<>nil then
    Self.Statuses_Count:=UserInfoJson.Field['statuses_count'].Value;
  if UserInfoJson.Field['allow_all_act_msg']<>nil then
  begin
    Self.Allow_All_Act_Msg:=UserInfoJson.Field['allow_all_act_msg'].Value;
  end;
end;

{ TSinaWeiboList }

function TSinaWeiboList.Add: TSinaWeiboItem;
begin
  Result:=TSinaWeiboItem.Create;
  FList.Add(Result);
end;

procedure TSinaWeiboList.Clear;
begin
  while FList.Count>0 do
  begin
    TObject(FList.Items[0]).Free;
    Flist.Delete(0);
  end;
end;

function TSinaWeiboList.Count: Integer;
begin
  Result:=Flist.Count;
end;

constructor TSinaWeiboList.Create;
begin
  FList:=TList.Create;
end;

destructor TSinaWeiboList.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

function TSinaWeiboList.GetItem(Index: Integer): TSinaWeiboItem;
begin
  Result:=TSinaWeiboItem(FList.Items[Index]);
end;

procedure TSinaWeiboList.SetItem(Index: Integer; const Value: TSinaWeiboItem);
begin
  FList.Items[Index]:=Value;
end;

end.



//    [{
//        "created_at" : "Tue Nov 30 16:21:13 +0800 2010",
//        "text" : "转发微博。",
//        "truncated" : false,
//        "retweeted_status" :
//        {
//            "created_at" : "Tue Nov 30 16:05:41 +0800 2010",
//            "text" : "对待事物的出发点、立足点，决定着事物的发展及发展后的结果。这个结果实际也是一种相对而言的成败。世俗间追求这种成败却又调整不好出发点，更是找不到立足点。所以成也好败也好，放下了最好。",
//            "truncated" : false,
//            "in_reply_to_status_id" : "",
//            "annotations" :
//            [
//
//            ],
//            "in_reply_to_screen_name" : "",
//            "geo" : null,
//            "user" :
//            {
//                "name" : "归元隆印",
//                "domain" : "",
//                "geo_enabled" : true,
//                "followers_count" : 66710,
//                "statuses_count" : 77,
//                "favourites_count" : 0,
//                "city" : "1",
//                "description" : "心存慈悲 身奉善行 出世入世 修己助人 归元禅寺官方网站：http://www.guiyuanchansi.net",
//                "verified" : true,
//                "id" : 1799833402,
//                "gender" : "m",
//                "friends_count" : 4,
//                "screen_name" : "归元隆印",
//                "allow_all_act_msg" : false,
//                "following" : false,
//                "url" : "http://1",
//                "profile_image_url" : "http://tp3.sinaimg.cn/1799833402/50/1283207796",
//                "created_at" : "Tue Aug 24 00:00:00 +0800 2010",
//                "province" : "42",
//                "location" : "湖北 武汉"
//            },
//            "favorited" : false,
//            "in_reply_to_user_id" : "",
//            "id" : 3980364843,
//            "source" : "<a href=\"http://t.sina.com.cn\" rel=\"nofollow\">新浪微博</a>"
//        },
//        "in_reply_to_status_id" : "",
//        "annotations" :
//        [
//
//        ],
//        "in_reply_to_screen_name" : "",
//        "geo" : null,
//        "user" :
//        {
//            "name" : "半拉拖鞋",
//            "domain" : "banlatuoxie",
//            "geo_enabled" : true,
//            "followers_count" : 56,
//            "statuses_count" : 333,
//            "favourites_count" : 1,
//            "city" : "5",
//            "description" : "在这里，我只管把话发出去，有没有人理就不管我的事了！",
//            "verified" : false,
//            "id" : 1799824787,
//            "gender" : "m",
//            "friends_count" : 76,
//            "screen_name" : "半拉拖鞋",
//            "allow_all_act_msg" : false,
//            "following" : false,
//            "url" : "http://blog.sina.com.cn/lingdianjingq",
//            "profile_image_url" : "http://tp4.sinaimg.cn/1799824787/50/1289443070/1",
//            "created_at" : "Sun Sep 05 00:00:00 +0800 2010",
//            "province" : "11",
//            "location" : "北京 朝阳区"
//        },
//        "favorited" : false,
//        "in_reply_to_user_id" : "",
//        "id" : 3980654229,
//        "source" : "<a href=\"http://t.sina.com.cn\" rel=\"nofollow\">新浪微博</a>"
//    }]
