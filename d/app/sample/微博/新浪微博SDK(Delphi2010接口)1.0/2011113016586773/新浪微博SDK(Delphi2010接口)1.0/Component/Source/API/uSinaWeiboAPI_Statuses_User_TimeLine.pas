unit uSinaWeiboAPI_Statuses_User_TimeLine;

interface

uses
  Windows,SysUtils,Classes,
  uSinaWeiboItem,
  uSinaWeiboAPI,
  uSinaWeiboAPIConst,
  uSinaWeiboParam,
  uLkJson,
  Variants,
  Dialogs;

//注意事项
// :id为REST风格的参数，使用该参数的URL为：
//http://api.t.sina.com.cn/statuses/user_timeline/:id.format
//使用示例如下：
//http://api.t.sina.com.cn/statuses/user_timeline/11051.xml?source=appkey
//http://api.t.sina.com.cn/statuses/user_timeline/timyang.json?source=appkey
//默认返回最近15天以内的微博信息
//由于分页限制，暂时最多只能返回用户最新的200条微博信息
//用户最多只能请求到最近200条记录

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

type
  TSinaWeiboAPI_Statuses_User_TimeLine=class(TSinaWeiboAPIItem)
  private
    FWeiboList:TSinaWeiboList;
    FParam_Feature: TQueryParameter;
    FParam_Max_Id: TQueryParameter;
    FParam_Base_App: TQueryParameter;
    FParam_Source: TQueryParameter;
    FParam_Count: TQueryParameter;
    FParam_Since_Id: TQueryParameter;
    FParam_Page: TQueryParameter;
    FParam_Screen_Name: TQueryParameter;
    FParam_Id: TQueryParameter;
    FParam_User_Id: TQueryParameter;
  protected
    Function CallAPIURL:String;override;
    //从服务器返回的Jason信息解析出用户信息
    function ParseFromJson(Response:String):Boolean;override;
  public
    constructor Create;
    destructor Destroy;override;
  public
    //请求参数 	必选	类型及范围	说明
    //source	true	string	申请应用时分配的AppKey，
    //调用接口时候代表应用的唯一身份。（采用OAuth授权方式不需要此参数）
    property Param_Source:TQueryParameter read FParam_Source;
    //since_id	false	int64	若指定此参数，则只返回ID比since_id大的微博消息
    //（即比since_id发表时间晚的微博消息）。
    property Param_Since_Id:TQueryParameter read FParam_Since_Id;
    //max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博消息
    property Param_Max_Id:TQueryParameter read FParam_Max_Id;
    //count	false	int，默认值20，最大值200。	指定要返回的记录条数。
    property Param_Count:TQueryParameter read FParam_Count;
    //page	false	int，默认值1。	指定返回结果的页码。
    //根据当前登录用户所关注的用户数及这些被关注用户发表的微博数，
    //翻页功能最多能查看的总记录数会有所不同，通常最多能查看1000条左右。
    property Param_Page:TQueryParameter read FParam_Page;
    //base_app	false	int	是否基于当前应用来获取数据。1为限制本应用微博，0为不做限制。
    property Param_Base_App:TQueryParameter read FParam_Base_App;
    //feature	false	int	微博类型，0全部，1原创，2图片，3视频，4音乐.
    //返回指定类型的微博信息内容。
    property Param_Feature:TQueryParameter read FParam_Feature;
    //如果:id、user_id、screen_name三个参数均未指定，则返回当前登录用户最近发表的微博消息列表。
    //:id	false	int64/string	根据用户ID(int64)或者微博昵称(string)返回指定用户的最新微博消息列表。该参数为REST风格参数，参见注意事项
    Property Param_Id:TQueryParameter read FParam_Id;
    //user_id	false	int64	用户ID，主要是用来区分用户ID跟微博昵称。当微博昵称为数字导致和用户ID产生歧义，特别是当微博昵称和用户ID一样的时候，建议使用该参数
    Property Param_User_Id:TQueryParameter read FParam_User_Id;
    //screen_name	false	string	微博昵称，主要是用来区分用户UID跟微博昵称，当二者一样而产生歧义的时候，建议使用该参数
    Property Param_Screen_Name:TQueryParameter read FParam_Screen_Name;
  public
    //获取到的微博列表
    property WeiboList:TSinaWeiboList read FWeiboList;
  end;


var
  GlobalSinaWeiboAPI_Statuses_User_TimeLine:TSinaWeiboAPI_Statuses_User_TimeLine;

implementation

{ TSinaWeiboAPI_Statuses_User_TimeLine }

constructor TSinaWeiboAPI_Statuses_User_TimeLine.Create;
begin
  Inherited Create(
                          CONST_API_Statuses_User_TimeLine_ID,
                          CONST_API_Statuses_User_TimeLine_NAME,
                          CONST_API_Statuses_User_TimeLine_URL,
                          CONST_API_Statuses_User_TimeLine_NEEDLOGIN,
                          CONST_API_Statuses_User_TimeLine_REQLIMIT,
                          CONST_API_Statuses_User_TimeLine_DESCRIP,
                          CONST_API_Statuses_User_TimeLine_STYLES,
                          CONST_API_Statuses_User_TimeLine_REQMETHOD
                  );

  FWeiboList:=TSinaWeiboList.create;

  FParam_Feature:=TQueryParameter.Create('feature','');
  FParam_Max_Id:=TQueryParameter.Create('max_id','');
  FParam_Base_App:=TQueryParameter.Create('base_app','');
  FParam_Source:=TQueryParameter.Create('source','');
  FParam_Count:=TQueryParameter.Create('count','');
  FParam_Since_Id:=TQueryParameter.Create('since_id','');
  FParam_Page:=TQueryParameter.Create('page','');
  FParam_Screen_Name:=TQueryParameter.Create('screen_name','');
  FParam_Id:=TQueryParameter.Create('id','',False);
  FParam_User_Id:=TQueryParameter.Create('user_id','');

  Params.Add(FParam_Feature);
  Params.Add(FParam_Max_Id);
  Params.Add(FParam_Base_App);
  Params.Add(FParam_Source);
  Params.Add(FParam_Count);
  Params.Add(FParam_Since_Id);
  Params.Add(FParam_Page);
  Params.Add(FParam_Screen_Name);
  Params.Add(FParam_Id);
  Params.Add(FParam_User_Id);

end;

function TSinaWeiboAPI_Statuses_User_TimeLine.CallAPIURL: String;
begin
  if Self.FParam_Id.Value<>'' then
  begin
    Result:=URL+'/'+Self.FParam_Id.Value;
  end
  else
  begin
    Result:=Inherited;
  end;
end;

destructor TSinaWeiboAPI_Statuses_User_TimeLine.Destroy;
begin
  FWeiboList.Free;
  inherited;
end;

function TSinaWeiboAPI_Statuses_User_TimeLine.ParseFromJson(
  Response:String): Boolean;
var
  I: Integer;
  JsonList:TlkJSONlist;
  AWeiboItem:TSinaWeiboItem;
  WeiboItemJson: TlkJSONobject;
begin
  Result:=False;
  FWeiboList.Clear;
  //获取微博列表
  JsonList := TlkJson.ParseText(Response) as TlkJSONlist;
  if JsonList<>nil then
  begin
    for I := 0 to JsonList.Count - 1 do
    begin
      WeiboItemJson:=JsonList.Child[I] as TlkJSONobject;
      if WeiboItemJson <> nil then
      begin
        AWeiboItem:=Self.FWeiboList.Add;
        AWeiboItem.LoadFromJson(WeiboItemJson);
      end;//if
    end;//for
    Result:=True;
    JsonList.Free;
  end;//if
end;


initialization
  GlobalSinaWeiboAPI_Statuses_User_TimeLine:=TSinaWeiboAPI_Statuses_User_TimeLine.Create;
  RegisterSinaWeiboAPI(GlobalSinaWeiboAPI_Statuses_User_TimeLine);


finalization
  //UnRegisterSinaWeiboAPI(GlobalSinaWeiboAPI_Statuses_User_TimeLine);
  //GlobalSinaWeiboAPI_Statuses_User_TimeLine.Free;


end.


