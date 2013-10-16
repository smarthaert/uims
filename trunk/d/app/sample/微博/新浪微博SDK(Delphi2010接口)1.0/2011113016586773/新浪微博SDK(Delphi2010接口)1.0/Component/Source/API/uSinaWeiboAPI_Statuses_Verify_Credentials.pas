unit uSinaWeiboAPI_Statuses_Verify_Credentials;

interface

uses
  Windows,SysUtils,uLkJSON,
  Variants,
  Forms,
  uSinaWeiboAPI,
  uSinaWeiboAPIConst;

type
  //新浪微博用户信息
  TSinaWeiboAPI_Statuses_Verify_Credentials=class(TSinaWeiboAPIItem)
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
  protected
    //从服务器返回的Jason信息解析出用户信息
    function ParseFromJson(Response:String):Boolean;override;
  public
    constructor Create;
    Destructor Destroy;override;
  public
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
  end;

var
  GlobalSinaWeiboAPI_Statuses_Verify_Credentials:TSinaWeiboAPI_Statuses_Verify_Credentials;

implementation

{ TSinaWeiboAPI_Statuses_Verify_Credentials }

constructor TSinaWeiboAPI_Statuses_Verify_Credentials.Create;
begin
  Inherited Create(
                          CONST_API_Statuses_Verify_Credentials_ID,
                          CONST_API_Statuses_Verify_Credentials_NAME,
                          CONST_API_Statuses_Verify_Credentials_URL,
                          CONST_API_Statuses_Verify_Credentials_NEEDLOGIN,
                          CONST_API_Statuses_Verify_Credentials_REQLIMIT,
                          CONST_API_Statuses_Verify_Credential_DESCRIP,
                          CONST_API_Statuses_Verify_Credentials_STYLES,
                          CONST_API_Statuses_Verify_Credentials_REQMETHOD
                  );
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

destructor TSinaWeiboAPI_Statuses_Verify_Credentials.Destroy;
begin

  inherited;
end;

Function TSinaWeiboAPI_Statuses_Verify_Credentials.ParseFromJson(Response:String):Boolean;
var
  Json: TlkJSONobject;
  StatusJson:TlkJSONobject;
begin
  Result:=False;

  Json := TlkJson.ParseText(Response) as TlkJSONobject;
  if Json <> nil then
  begin

    if Json.Field['id']<>nil then
      FID:=Json.Field['id'].Value;
    if Json.Field['location']<>nil then
      FLocation:=Json.Field['location'].Value;
    if Json.Field['name']<>nil then
      FName:=Json.Field['name'].Value;
    if Json.Field['profile_image_url']<>nil then
      FProfile_Image_URL:=Json.Field['profile_image_url'].Value;
    if Json.Field['domain']<>nil then
      FDomain:=Json.Field['domain'].Value;
    if Json.Field['description']<>nil then
      FDescription:=Json.Field['description'].Value;
    if Json.Field['verified']<>nil then
      FVerified:=Json.Field['verified'].Value;
    if Json.Field['following']<>nil then
      FFollowing:=Json.Field['following'].Value;
    if Json.Field['created_at']<>nil then
      FCreated_At:=Json.Field['created_at'].Value;
    if Json.Field['province']<>nil then
      FProvince:=Json.Field['province'].Value;
    if Json.Field['screen_name']<>nil then
      FScreen_Name:=Json.Field['screen_name'].Value;
    if Json.Field['favourites_count']<>nil then
      FFavourites_Count:=Json.Field['favourites_count'].Value;
    if Json.Field['gender']<>nil then
      FGender:=Json.Field['gender'].Value;
    if Json.Field['geo_enabled']<>nil then
      FGeo_Enabled:=Json.Field['geo_enabled'].Value;
    if Json.Field['followers_count']<>nil then
      FFollowers_Count:=Json.Field['followers_count'].Value;
    if Json.Field['friends_count']<>nil then
      FFriends_Count:=Json.Field['friends_count'].Value;
    if Json.Field['city']<>nil then
      FCity:=Json.Field['city'].Value;
    if Json.Field['url']<>nil then
      FURL:=Json.Field['url'].Value;
    if Json.Field['statuses_count']<>nil then
      FStatuses_Count:=Json.Field['statuses_count'].Value;

    StatusJson:=Json.Field['status'] as TlkJSONobject;
    if StatusJson<>nil then
    begin
      if StatusJson.Field['id']<>nil then
        FStatus_ID:=StatusJson.Field['id'].Value;
      if StatusJson.Field['mid']<>nil then
        FStatus_Mid:=StatusJson.Field['mid'].Value;
      if StatusJson.Field['in_reply_to_user_id']<>nil then
        FStatus_In_Reply_To_User_Id:=StatusJson.Field['in_reply_to_user_id'].Value;

      //注释
      FStatus_Annotations:='';
      if StatusJson.Field['annotations']<>nil then
      begin
        if Not VarIsNull(StatusJson.Field['annotations'].Value) then
          FStatus_Annotations:=StatusJson.Field['annotations'].Value;
      end;
      FStatus_Text:=StatusJson.Field['text'].Value;
      FStatus_Geo:='';
      if StatusJson.Field['geo']<>nil then
      begin
        if Not VarIsNull(StatusJson.Field['geo'].Value) then
          FStatus_Geo:=StatusJson.Field['geo'].Value;
      end;
      if StatusJson.Field['truncated']<>nil then
        FStatus_Truncated:=StatusJson.Field['truncated'].Value;
      if StatusJson.Field['created_at']<>nil then
        FStatus_Created_At:=StatusJson.Field['created_at'].Value;
      if StatusJson.Field['in_reply_to_status_id']<>nil then
        FStatus_In_Reply_To_Status_Id:=StatusJson.Field['in_reply_to_status_id'].Value;
      if StatusJson.Field['source']<>nil then
        FStatus_Source:=StatusJson.Field['source'].Value;
      if StatusJson.Field['favorited']<>nil then
        FStatus_Favorited:=StatusJson.Field['favorited'].Value;
      if StatusJson.Field['in_reply_to_screen_name']<>nil then
        FStatus_In_Reply_To_Screen_Name:=StatusJson.Field['in_reply_to_screen_name'].Value;
    end;
    Result:=True;
    Json.Free;
  end;
end;


initialization
  GlobalSinaWeiboAPI_Statuses_Verify_Credentials:=TSinaWeiboAPI_Statuses_Verify_Credentials.Create;
  RegisterSinaWeiboAPI(GlobalSinaWeiboAPI_Statuses_Verify_Credentials);

finalization
  //UnRegisterSinaWeiboAPI(GlobalSinaWeiboAPI_Statuses_Verify_Credentials);
  //FreeAndNil(GlobalSinaWeiboAPI_Statuses_Verify_Credentials);


end.




//user
//用户资料信息，如查看用户资料或列表时，用户会包含最新status的子tag。
//
//字段说明
//id: 用户UID
//screen_name: 微博昵称
//name: 友好显示名称，如Bill Gates(此特性暂不支持)
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

//status
//
//微博信息内容，显示微博列表时会附带上微博的作者和转发的微博
//字段说明
//created_at: 创建时间
//id: 微博ID
//text：微博信息内容
//source: 微博来源
//favorited: 是否已收藏(正在开发中，暂不支持)
//truncated: 是否被截断
//in_reply_to_status_id: 回复ID
//in_reply_to_user_id: 回复人UID
//in_reply_to_screen_name: 回复人昵称
//thumbnail_pic: 缩略图
//bmiddle_pic: 中型图片
//original_pic：原始图片
//user: 作者信息
//retweeted_status: 转发的博文，内容为status，如果不是转发，则没有此字段


//如果返回失败
//那么Json为{"request":"/statuses/friends_timeline.json","error_code":"400","error":"40022:Error: source paramter(appkey) is missing"}

//如果返回成功，
//那么Json为
//      Response:='{"id":1651072717,"screen_name":"小悟能的爸爸",'
//                +'"name":"小悟能的爸爸","province":"31","city":"7",'
//                +'"location":"上海 普陀区","description":"","url":"",'
//                +'"profile_image_url":"http://tp2.sinaimg.cn/1651072717/50/5607820735/1",'
//                +'"domain":"orangeinmymind","gender":"m","followers_count":62,'
//                +'"friends_count":41,"statuses_count":158,"favourites_count":0,'
//                +'"created_at":"Wed Jan 12 00:00:00 +0800 2011","following":false,'
//                +'"allow_all_act_msg":false,"geo_enabled":true,"verified":false,'
//                +'"status":{"created_at":"Sun Oct 23 10:14:13 +0800 2011",'
//                +'"id":3371602135615311,"text":"有高手吗？ 我的QQ漂流瓶，晕倒，拔不出来了，怎么办",'
//                +'"source":"<a href=\"http://desktop.weibo.com\" rel=\"nofollow\">微博桌面</a>",'
//                +'"favorited":false,"truncated":false,"in_reply_to_status_id":"",'
//                +'"in_reply_to_user_id":"","in_reply_to_screen_name":"",'
//                +'"thumbnail_pic":"http://ww1.sinaimg.cn/thumbnail/62695ecdjw1dmds9mlt08j.jpg",'
//                +'"bmiddle_pic":"http://ww1.sinaimg.cn/bmiddle/62695ecdjw1dmds9mlt08j.jpg",'
//                +'"original_pic":"http://ww1.sinaimg.cn/large/62695ecdjw1dmds9mlt08j.jpg",'
//                +'"geo":null,"mid":"3371602135615311"}}';


//      Result:=True;
//      Response:='{"id":1651072717,"screen_name":"小悟能的爸爸",'
//                +'"name":"小悟能的爸爸","province":"31","city":"7",'
//                +'"location":"上海 普陀区","description":"","url":"",'
//                +'"profile_image_url":"http://tp2.sinaimg.cn/1651072717/50/5607820735/1",'
//                +'"domain":"orangeinmymind","gender":"m","followers_count":62,'
//                +'"friends_count":41,"statuses_count":158,"favourites_count":0,'
//                +'"created_at":"Wed Jan 12 00:00:00 +0800 2011","following":false,'
//                +'"allow_all_act_msg":false,"geo_enabled":true,"verified":false,'
//                +'"status":{"created_at":"Sun Oct 23 10:14:13 +0800 2011",'
//                +'"id":3371602135615311,"text":"有高手吗？ 我的QQ漂流瓶，晕倒，拔不出来了，怎么办",'
//                +'"source":"<a href=\"http://desktop.weibo.com\" rel=\"nofollow\">微博桌面</a>",'
//                +'"favorited":false,"truncated":false,"in_reply_to_status_id":"",'
//                +'"in_reply_to_user_id":"","in_reply_to_screen_name":"",'
//                +'"thumbnail_pic":"http://ww1.sinaimg.cn/thumbnail/62695ecdjw1dmds9mlt08j.jpg",'
//                +'"bmiddle_pic":"http://ww1.sinaimg.cn/bmiddle/62695ecdjw1dmds9mlt08j.jpg",'
//                +'"original_pic":"http://ww1.sinaimg.cn/large/62695ecdjw1dmds9mlt08j.jpg",'
//                +'"geo":null,"mid":"3371602135615311"}}';


