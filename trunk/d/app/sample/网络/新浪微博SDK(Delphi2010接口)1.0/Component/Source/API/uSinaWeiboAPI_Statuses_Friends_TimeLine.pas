unit uSinaWeiboAPI_Statuses_Friends_TimeLine;

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


type
  TSinaWeiboAPI_Statuses_Friends_TimeLine=class(TSinaWeiboAPIItem)
  private
    FWeiboList:TSinaWeiboList;
    FParam_Feature: TQueryParameter;
    FParam_Max_Id: TQueryParameter;
    FParam_Base_App: TQueryParameter;
    FParam_Source: TQueryParameter;
    FParam_Count: TQueryParameter;
    FParam_Since_Id: TQueryParameter;
    FParam_Page: TQueryParameter;
  protected
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
  public
    //获取到的微博列表
    property WeiboList:TSinaWeiboList read FWeiboList;
  end;


var
  GlobalSinaWeiboAPI_Statuses_Friends_TimeLine:TSinaWeiboAPI_Statuses_Friends_TimeLine;

implementation

{ TSinaWeiboAPI_Statuses_Friends_TimeLine }

constructor TSinaWeiboAPI_Statuses_Friends_TimeLine.Create;
begin
  Inherited Create(
                          CONST_API_Statuses_Friends_TimeLine_ID,
                          CONST_API_Statuses_Friends_TimeLine_NAME,
                          CONST_API_Statuses_Friends_TimeLine_URL,
                          CONST_API_Statuses_Friends_TimeLine_NEEDLOGIN,
                          CONST_API_Statuses_Friends_TimeLine_REQLIMIT,
                          CONST_API_Statuses_Friends_TimeLine_DESCRIP,
                          CONST_API_Statuses_Friends_TimeLine_STYLES,
                          CONST_API_Statuses_Friends_TimeLine_REQMETHOD
                  );

  FWeiboList:=TSinaWeiboList.create;

  FParam_Feature:=TQueryParameter.Create('feature','');
  FParam_Max_Id:=TQueryParameter.Create('max_id','');
  FParam_Base_App:=TQueryParameter.Create('base_app','');
  FParam_Source:=TQueryParameter.Create('source','');
  FParam_Count:=TQueryParameter.Create('count','');
  FParam_Since_Id:=TQueryParameter.Create('since_id','');
  FParam_Page:=TQueryParameter.Create('page','');

  Params.Add(FParam_Feature);
  Params.Add(FParam_Max_Id);
  Params.Add(FParam_Base_App);
  Params.Add(FParam_Source);
  Params.Add(FParam_Count);
  Params.Add(FParam_Since_Id);
  Params.Add(FParam_Page);

end;

destructor TSinaWeiboAPI_Statuses_Friends_TimeLine.Destroy;
begin
  FWeiboList.Free;
  inherited;
end;

function TSinaWeiboAPI_Statuses_Friends_TimeLine.ParseFromJson(
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
  GlobalSinaWeiboAPI_Statuses_Friends_TimeLine:=TSinaWeiboAPI_Statuses_Friends_TimeLine.Create;
  RegisterSinaWeiboAPI(GlobalSinaWeiboAPI_Statuses_Friends_TimeLine);


finalization
  //UnRegisterSinaWeiboAPI(GlobalSinaWeiboAPI_Statuses_Friends_TimeLine);
  //GlobalSinaWeiboAPI_Statuses_Friends_TimeLine.Free;


end.


//[
//    {
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
//    },
//...
//]

//
//      Result:=True;
//      Response:=''
//                +'                                                                                           '
//                +'    {                                                                                       '
//                +'        "created_at" : "Tue Nov 30 16:21:13 +0800 2010",                                    '
//                +'        "text" : "转发微博。",                                                              '
//                +'        "truncated" : false,                                                                '
//                +'        "retweeted_status" :                                                                '
//                +'        {                                                                                   '
//                +'            "created_at" : "Tue Nov 30 16:05:41 +0800 2010",                                '
//                +'            "text" : "对待事物的出发点、立足点，决定着事物的发展及发展后的结果。            '
//                +'                这个结果实际也是一种相对而言的成败。世俗间追求这种成败却又调整不好出发点，  '
//                +'                更是找不到立足点。所以成也好败也好，放下了最好。",                          '
//                +'            "truncated" : false,                                                            '
//                +'            "in_reply_to_status_id" : "",                                                   '
//                +'            "annotations" :                                                                 '
//                +'            [                                                                               '
//                +'                                                                                            '
//                +'            ],                                                                              '
//                +'            "in_reply_to_screen_name" : "",                                                 '
//                +'            "geo" : null,                                                                   '
//                +'            "user" :                                                                        '
//                +'            {                                                                               '
//                +'                "name" : "归元隆印",                                                        '
//                +'                "domain" : "",                                                              '
//                +'                "geo_enabled" : true,                                                       '
//                +'                "followers_count" : 66710,                                                  '
//                +'                "statuses_count" : 77,                                                      '
//                +'                "favourites_count" : 0,                                                     '
//                +'                "city" : "1",                                                               '
//                +'                "description" : "心存慈悲 身奉善行 出世入世 修己助人 归元禅寺官方网站：http:'
//                +'                      //www.guiyuanchansi.net",                                             '
//                +'                "verified" : true,                                                          '
//                +'                "id" : 1799833402,                                                          '
//                +'                "gender" : "m",                                                             '
//                +'                "friends_count" : 4,                                                        '
//                +'                "screen_name" : "归元隆印",                                                 '
//                +'                "allow_all_act_msg" : false,                                                '
//                +'                "following" : false,                                                        '
//                +'                "url" : "http://1",                                                         '
//                +'                "profile_image_url" : "http://tp3.sinaimg.cn/1799833402/50/1283207796",     '
//                +'                "created_at" : "Tue Aug 24 00:00:00 +0800 2010",                            '
//                +'                "province" : "42",                                                          '
//                +'                "location" : "湖北 武汉"                                                    '
//                +'            },                                                                              '
//                +'            "favorited" : false,                                                            '
//                +'            "in_reply_to_user_id" : "",                                                     '
//                +'            "id" : 3980364843,                                                              '
//                +'            "source" : "<a href=\"http://t.sina.com.cn\" rel=\"nofollow\">新浪微博</a>"     '
//                +'        },                                                                                  '
//                +'        "in_reply_to_status_id" : "",                                                       '
//                +'        "annotations" :                                                                     '
//                +'        [                                                                                   '
//                +'                                                                                            '
//                +'        ],                                                                                  '
//                +'        "in_reply_to_screen_name" : "",                                                     '
//                +'        "geo" : null,                                                                       '
//                +'        "user" :                                                                            '
//                +'        {                                                                                   '
//                +'            "name" : "半拉拖鞋",                                                            '
//                +'            "domain" : "banlatuoxie",                                                       '
//                +'            "geo_enabled" : true,                                                           '
//                +'            "followers_count" : 56,                                                         '
//                +'            "statuses_count" : 333,                                                         '
//                +'            "favourites_count" : 1,                                                         '
//                +'            "city" : "5",                                                                   '
//                +'            "description" : "在这里，我只管把话发出去，有没有人理就不管我的事了！",         '
//                +'            "verified" : false,                                                             '
//                +'            "id" : 1799824787,                                                              '
//                +'            "gender" : "m",                                                                 '
//                +'            "friends_count" : 76,                                                           '
//                +'            "screen_name" : "半拉拖鞋",                                                     '
//                +'            "allow_all_act_msg" : false,                                                    '
//                +'            "following" : false,                                                            '
//                +'            "url" : "http://blog.sina.com.cn/lingdianjingq",                                '
//                +'            "profile_image_url" : "http://tp4.sinaimg.cn/1799824787/50/1289443070/1",       '
//                +'            "created_at" : "Sun Sep 05 00:00:00 +0800 2010",                                '
//                +'            "province" : "11",                                                              '
//                +'            "location" : "北京 朝阳区"                                                      '
//                +'        },                                                                                  '
//                +'        "favorited" : false,                                                                '
//                +'        "in_reply_to_user_id" : "",                                                         '
//                +'        "id" : 3980654229,                                                                  '
//                +'        "source" : "<a href=\"http://t.sina.com.cn\" rel=\"nofollow\">新浪微博</a>"         '
//                +'    }                                                                                       '
//                +'                                                                                           ';

