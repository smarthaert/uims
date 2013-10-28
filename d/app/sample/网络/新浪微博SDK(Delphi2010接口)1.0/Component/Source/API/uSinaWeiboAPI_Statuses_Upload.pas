unit uSinaWeiboAPI_Statuses_Upload;

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
  IdHttp,
  IdMultipartFormData;


type
  TSinaWeiboAPI_Statuses_Upload=class(TSinaWeiboAPIItem)
  private
    FWeiboItem:TSinaWeiboItem;
    FParam_Pic: TQueryParameter;
    FParam_Source: TQueryParameter;
    FParam_Lat: TQueryParameter;
    FParam_Status: TQueryParameter;
    FParam_Long: TQueryParameter;
    FParam_Annotations: TQueryParameter;
  protected
    //从服务器返回的Jason信息解析出用户信息
    procedure CallAPIHTTPPostSetting(AHTTP: TIdHttp;var HTTPPostStream:TMemoryStream);override;
    function ParseFromJson(Response:String):Boolean;override;
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
    //pic	true	binary	要上传的图片数据。仅支持JPEG、GIF、PNG格式，为空返回400错误。图片大小<5M。
    property Param_Pic:TQueryParameter read FParam_Pic;
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
  GlobalSinaWeiboAPI_Statuses_Upload:TSinaWeiboAPI_Statuses_Upload;

implementation

{ TSinaWeiboAPI_Statuses_Upload }

constructor TSinaWeiboAPI_Statuses_Upload.Create;
begin
  Inherited Create(
                          CONST_API_Statuses_Upload_ID,
                          CONST_API_Statuses_Upload_NAME,
                          CONST_API_Statuses_Upload_URL,
                          CONST_API_Statuses_Upload_NEEDLOGIN,
                          CONST_API_Statuses_Upload_REQLIMIT,
                          CONST_API_Statuses_Upload_DESCRIP,
                          CONST_API_Statuses_Upload_STYLES,
                          CONST_API_Statuses_Upload_REQMETHOD
                  );

  FParam_Pic:=TQueryParameter.Create('pic','',False);
  FParam_Source:=TQueryParameter.Create('source','',False);
  FParam_Lat:=TQueryParameter.Create('lat','',False);
  FParam_Status:=TQueryParameter.Create('status','',False);
  FParam_Long:=TQueryParameter.Create('long','',False);
  FParam_Annotations:=TQueryParameter.Create('annotations','',False);

  Params.Add(FParam_Pic);
  Params.Add(FParam_Source);
  Params.Add(FParam_Lat);
  Params.Add(FParam_Status);
  Params.Add(FParam_Long);
  Params.Add(FParam_Annotations);

  FWeiboItem:=TSinaWeiboItem.Create;
end;

destructor TSinaWeiboAPI_Statuses_Upload.Destroy;
begin
  FWeiboItem.Free;
  inherited;
end;

procedure TSinaWeiboAPI_Statuses_Upload.CallAPIHTTPPostSetting(AHTTP: TIdHttp;var HTTPPostStream:TMemoryStream);
var
  IdMultiPartFormDataStream:TIdMultiPartFormDataStream;
  //FileStream:TFileStream;
  HTTPHeaderStrings:TStringList;
  HTTPFooterStrings:TStringList;
  Boundary:String;
  BoundaryHeader:String;
  BoundaryFooter:String;
begin
  Inherited;

  HTTPHeaderStrings:=TStringList.Create;
  HTTPFooterStrings:=TStringList.Create;

  IdMultiPartFormDataStream:=IdMultipartFormData.TIdMultiPartFormDataStream.Create;
  Boundary:=IdMultiPartFormDataStream.Boundary;
  BoundaryHeader:='--'+Boundary;
  BoundaryFooter:='--'+Boundary+'--';

  AHTTP.Request.ContentType:='multipart/form-data; boundary='+Boundary+'';

  //微博文本
  HTTPHeaderStrings.Add(BoundaryHeader);
  HTTPHeaderStrings.Add('Content-Disposition: form-data; name="status"');
  HTTPHeaderStrings.Add('Content-Type: text/plain; charset=US-ASCII');
  HTTPHeaderStrings.Add('Content-Transfer-Encoding: 8bit');
  HTTPHeaderStrings.Add('');
  HTTPHeaderStrings.Add(Self.FParam_Status.Value);

  //应用ID
  HTTPHeaderStrings.Add(BoundaryHeader);
  HTTPHeaderStrings.Add('Content-Disposition: form-data; name="source"');
  HTTPHeaderStrings.Add('Content-Type: text/plain; charset=US-ASCII');
  HTTPHeaderStrings.Add('Content-Transfer-Encoding: 8bit');
  HTTPHeaderStrings.Add('');
  HTTPHeaderStrings.Add(Self.FParam_Source.Value);

  //微博图片
  IdMultiPartFormDataStream.AddFile('pic',Self.FParam_Pic.Value,'application/octet-stream'   );

  //复制到HTTP流中
  HTTPHeaderStrings.SaveToStream(HTTPPostStream);
  HTTPPostStream.Position:=HTTPPostStream.Size;
  IdMultiPartFormDataStream.Position:=0;
  HTTPPostStream.CopyFrom(IdMultiPartFormDataStream,IdMultiPartFormDataStream.Size  );

  //保存成临时文件
//  FileStream:=TFileStream.Create('IdMultiPartFormDataStream.txt',fmCreate);
//  HTTPPostStream.Position:=0;
//  FileStream.CopyFrom(HTTPPostStream,HTTPPostStream.Size  );
//  FileStream.Free;

  //HTTPPostStream.LoadFromFile('IdMultiPartFormDataStream.txt');

  HTTPHeaderStrings.Free;
  HTTPFooterStrings.Free;
  IdMultiPartFormDataStream.Free;
end;

function TSinaWeiboAPI_Statuses_Upload.ParseFromJson(
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
  GlobalSinaWeiboAPI_Statuses_Upload:=TSinaWeiboAPI_Statuses_Upload.Create;
  RegisterSinaWeiboAPI(GlobalSinaWeiboAPI_Statuses_Upload);


finalization
  //UnRegisterSinaWeiboAPI(GlobalSinaWeiboAPI_Statuses_Upload);
  //GlobalSinaWeiboAPI_Statuses_Upload.Free;


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


