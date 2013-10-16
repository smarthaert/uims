unit uSinaWeiboAPI_Statuses_Update;

interface

uses
  Windows,SysUtils,Classes,
  uSinaWeiboItem,
  uSinaWeiboAPI,
  uSinaWeiboAPIConst,
  uSinaWeiboParam,
  uLkJson,
  Variants,
  Dialogs,
  IdHttp;


type
  TSinaWeiboAPI_Statuses_Update=class(TSinaWeiboAPIItem)
  private
    FWeiboItem:TSinaWeiboItem;
    FParam_In_Reply_To_Id: TQueryParameter;
    FParam_Source: TQueryParameter;
    FParam_Lat: TQueryParameter;
    FParam_Status: TQueryParameter;
    FParam_Long: TQueryParameter;
    FParam_Annotations: TQueryParameter;
  protected
    //从服务器返回的Jason信息解析出用户信息
    function ParseFromJson(Response:String):Boolean;override;
    //procedure CallAPIHTTPPostSetting(AHTTP:TIdHttp;var HTTPPostStream:TMemoryStream);override;

  public
    constructor Create;
    destructor Destroy;override;
  public
    ////////////////////////////参数/////////////////////////////////
    //status	true	string	要发布的微博消息文本内容
    property Param_Status:TQueryParameter read FParam_Status;
    //请求参数 	必选	类型及范围	说明
    //source	true	string	申请应用时分配的AppKey，
    //调用接口时候代表应用的唯一身份。（采用OAuth授权方式不需要此参数）
    property Param_Source:TQueryParameter read FParam_Source;
    //in_reply_to_status_id	false	int64	要转发的微博消息ID。
    property Param_In_Reply_To_Id:TQueryParameter read FParam_In_Reply_To_Id;
    //注意：lat和long参数需配合使用，用于标记发表微博消息时所在的地理位置，只有用户设置中geo_enabled=true时候地理位置信息才有效。
    //lat	false	float	纬度。有效范围：-90.0到+90.0，+表示北纬。
    Property Param_Lat:TQueryParameter read FParam_Lat;
    //long	false	float	经度。有效范围：-180.0到+180.0，+表示东经。
    Property Param_Long:TQueryParameter read FParam_Long;
    //annotations	false	string	元数据，主要是为了方便第三方应用记录一些适合于自己使用的信息。
    //每条微博可以包含一个或者多个元数据。请以json字串的形式提交，字串长度不超过512个字符，具体内容可以自定。
    property Param_Annotations:TQueryParameter read FParam_Annotations;
  public
    //刚发的微博
    property WeiboItem:TSinaWeiboItem read FWeiboItem;
  end;


var
  GlobalSinaWeiboAPI_Statuses_Update:TSinaWeiboAPI_Statuses_Update;

implementation

{ TSinaWeiboAPI_Statuses_Update }

//procedure TSinaWeiboAPI_Statuses_Update.CallAPIHTTPPostSetting(AHTTP: TIdHttp;var HTTPPostStream:TMemoryStream);
//begin
//  inherited;
//  //AHTTP.Request.ContentType:='application/x-www-form-urlencoded';
//  //AHTTP.Request.RawHeaders.AddValue('API-RemoteIP','127.0.0.1');
//end;

constructor TSinaWeiboAPI_Statuses_Update.Create;
begin
  Inherited Create(
                          CONST_API_Statuses_Update_ID,
                          CONST_API_Statuses_Update_NAME,
                          CONST_API_Statuses_Update_URL,
                          CONST_API_Statuses_Update_NEEDLOGIN,
                          CONST_API_Statuses_Update_REQLIMIT,
                          CONST_API_Statuses_Update_DESCRIP,
                          CONST_API_Statuses_Update_STYLES,
                          CONST_API_Statuses_Update_REQMETHOD
                  );

  FParam_In_Reply_To_Id:=TQueryParameter.Create('in_reply_to_id','');
  FParam_Source:=TQueryParameter.Create('source','');
  FParam_Lat:=TQueryParameter.Create('lat','');
  FParam_Status:=TQueryParameter.Create('status','');
  FParam_Long:=TQueryParameter.Create('long','');
  FParam_Annotations:=TQueryParameter.Create('annotations','');

  Params.Add(FParam_In_Reply_To_Id);
  Params.Add(FParam_Source);
  Params.Add(FParam_Lat);
  Params.Add(FParam_Status);
  Params.Add(FParam_Long);
  Params.Add(FParam_Annotations);


  FWeiboItem:=TSinaWeiboItem.Create;
end;

destructor TSinaWeiboAPI_Statuses_Update.Destroy;
begin
  FWeiboItem.Free;
  inherited;
end;

function TSinaWeiboAPI_Statuses_Update.ParseFromJson(
  Response:String): Boolean;
var
  WeiboItemJson: TlkJSONobject;
begin
  Result:=False;
//  Response:=
//'{'
//+'"created_at":"Sun Nov 06 17:23:40 +0800 2011",'
//+'"id":3376783640356245,'
//+'"text":"OrangerBo",'
//+'"source":"<a href=\"http://open.t.sina.com.cn\" rel=\"nofollow\">未通过审核应用</a>",'
//+'"favorited":false,"truncated":false,'
//+'"in_reply_to_status_id":"",'
//+'"in_reply_to_user_id":"",'
//+'"in_reply_to_screen_name":"",'
//+'"geo":null,'
//+'"mid":"3376783640356245",'
//+'"user":{'
//+'"id":1651072717,'
//+'"screen_name":"OrangerBo",'
//+'"name":"OrangerBo",'
//+'"province":"31",'
//+'"city":"7",'
//+'"location":"上海 普陀区",'
//+'"description":"",'
//+'"url":"http://blog.csdn.net/delphiteacher/",'
//+'"profile_image_url":"http://tp2.sinaimg.cn/1651072717/50/5607820735/1",'
//+'"domain":"orangeinmymind",'
//+'"gender":"m",'
//+'"followers_count":62,'
//+'"friends_count":41,'
//+'"statuses_count":0,'
//+'"favourites_count":0,'
//+'"created_at":"Wed Jan 12 00:00:00 +0800 2011","following":false,'
//+'"allow_all_act_msg":false,"geo_enabled":true,"verified":false}}';
//

  WeiboItemJson := TlkJson.ParseText(Response) as TlkJSONobject;
  if WeiboItemJson <> nil then
  begin
    Self.FWeiboItem.LoadFromJson(WeiboItemJson);
    Result:=True;
    WeiboItemJson.Free;
  end;

end;


initialization
  GlobalSinaWeiboAPI_Statuses_Update:=TSinaWeiboAPI_Statuses_Update.Create;
  RegisterSinaWeiboAPI(GlobalSinaWeiboAPI_Statuses_Update);


finalization
  //UnRegisterSinaWeiboAPI(GlobalSinaWeiboAPI_Statuses_Update);
  //GlobalSinaWeiboAPI_Statuses_Update.Free;


//'{
//"created_at":"Sun Nov 06 17:23:40 +0800 2011",
//"id":3376783640356245,
//"text":"OrangerBo",
//"source":"<a href=\"http://open.t.sina.com.cn\" rel=\"nofollow\">未通过审核应用</a>",
//"favorited":false,"truncated":false,
//"in_reply_to_status_id":"",
//"in_reply_to_user_id":"",
//"in_reply_to_screen_name":"",
//"geo":null,
//"mid":"3376783640356245",
//"user":{
//"id":1651072717,
//"screen_name":"OrangerBo",
//"name":"OrangerBo",
//"province":"31",
//"city":"7",
//"location":"上海 普陀区",
//"description":"",
//"url":"http://blog.csdn.net/delphiteacher/",
//"profile_image_url":"http://tp2.sinaimg.cn/1651072717/50/5607820735/1",
//"domain":"orangeinmymind",
//"gender":"m",
//"followers_count":62,
//"friends_count":41,
//"statuses_count":0,
//"favourites_count":0,
//"created_at":"Wed Jan 12 00:00:00 +0800 2011","following":false,"allow_all_act_msg":false,"geo_enabled":true,"verified":false}}'

end.


