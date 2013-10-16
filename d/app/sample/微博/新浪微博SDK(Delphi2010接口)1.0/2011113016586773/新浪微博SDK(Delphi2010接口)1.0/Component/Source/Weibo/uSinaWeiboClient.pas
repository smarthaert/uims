unit uSinaWeiboClient;

interface

uses
  Windows,SysUtils,Classes,Controls,Dialogs,
  uSinaWeiboAPI,
  uSinaWeiboUser,
  uMyOAuth,
  uSinaWeiboParam,
  uSinaWeiboAPIConst,
  uSinaWeiboItem;


type
  TSinaWeiboClient=class
  private
    FAPI:TSinaWeiboAPI;
    FUser:TSinaWeiboUser;
    FOAuth:TMyOAuth;
  protected
    //获取最新的微博列表
    function GetStatuses_Friends_TimeLine_WeiboList: TSinaWeiboList;
    //获取指定用户最近发表的微博列表
    function GetStatuses_User_TimeLine_WeiboList: TSinaWeiboList;
    //刚发的微博
    function GetStatuses_Update_WeiboItem: TSinaWeiboItem;
  public
    constructor Create;
    destructor Destroy;override;
    //更新用户信息
    function SyncUserInfo:Boolean;
    //发一条文本微博
    function SendTextWeibo(Source:String;WeiboText:String):Boolean;
    //发一图片微博
    function SendPicWeibo(Source:String;WeiboText:String;PicFileName:String):Boolean;
    //获取最新的微博列表
    function GetHomePageWeiboList(Source:String;Since_Id:String;Max_Id:String;Count:String;
                           Page:String;Base_App:String;Feature:String):Boolean;
    //获取指定某用户最近发表的微博列表
    function GetUserRecentWeiboList(Source:String;Since_Id:String;Max_Id:String;Count:String;
                           Page:String;Base_App:String;Feature:String;
                           Id:String;User_Id:String;Screen_Name:String):Boolean;
    //当前用户Web主站未读消息数
    function GetHomePageUnReadMsgNum(Source:String;Since_Id:String;with_new_status:String):Boolean;
  public
    //调用API
    property API:TSinaWeiboAPI read FAPI;
    //用户类
    property User:TSinaWeiboUser read FUser;
    //验证类
    property OAuth:TMyOAuth read FOAuth;
  public
    //指定用户最新发表的微博列表
    property Statuses_User_TimeLine_WeiboList:TSinaWeiboList read GetStatuses_User_TimeLine_WeiboList;
    //主页最新的微博列表
    property Statuses_Friends_TimeLine_WeiboList:TSinaWeiboList read GetStatuses_Friends_TimeLine_WeiboList;
    //刚发的微博
    property Statuses_Update_WeiboItem:TSinaWeiboItem read GetStatuses_Update_WeiboItem;
  end;

var
  Client:TSinaWeiboClient;

implementation

uses
  uSinaWeiboAPI_Statuses_Friends_TimeLine,
  uSinaWeiboAPI_Statuses_Update,
  uSinaWeiboAPI_Statuses_Unread,
  uSinaWeiboAPI_Statuses_Upload,
  uSinaWeiboAPI_Statuses_User_TimeLine;


{ TSinaWeiboClient }

constructor TSinaWeiboClient.Create;
begin
  inherited Create;
  FOAuth:=TMyOAuth.Create('','');
  FAPI:=TSinaWeiboAPI.Create(FOAuth);
  FUser:=TSinaWeiboUser.Create;
end;

destructor TSinaWeiboClient.Destroy;
begin
  FAPI.Free;
  FUser.Free;
  FOAuth.Free;
  inherited;
end;

function HTMLEncode(const AStr: AnsiString): String;
const
  NoConversion = ['A'..'Z','a'..'z','*','.','_','-','0'..'9','!','''','(',')']; //不需要进行转换的字符。
var
  Rp:String;
  I: Integer;
begin
  Result:='';
  for I := 1 to Length(AStr) do
  begin
    if AStr[I] in NoConversion then
      Result :=Result+ AStr[I]
    else
    if AStr[I] = ' ' then
      Result :=Result+'+'
    else
    begin
      Result:=Result+'%'+Format('%x', [ORD( AStr[I])]);
    end;
  end;
end;

function TSinaWeiboClient.SendPicWeibo(Source:String;WeiboText, PicFileName: String): Boolean;
var
  APIItem:TSinaWeiboAPI_Statuses_Upload;
begin
  Result:=False;
  APIItem:=Self.FAPI.GetAPI(CONST_API_Statuses_Upload_ID) as TSinaWeiboAPI_Statuses_Upload;
  if APIItem<>nil then
  begin
    APIItem.Param_Status.Value:=URLEncodeUTF8(UTF8Encode(WeiboText));// 'test pic';//
    APIItem.Param_Source.Value:=Source;
    APIItem.Param_Pic.Value:=PicFileName;
    if Self.API.CallAPI(CONST_API_Statuses_Upload_ID) then
    begin
      Result:=True;
    end;
  end;
end;

function TSinaWeiboClient.SendTextWeibo(Source:String;WeiboText: String):Boolean;
var
  APIItem:TSinaWeiboAPI_Statuses_Update;
begin
  Result:=False;
  APIItem:=Self.FAPI.GetAPI(CONST_API_Statuses_Update_ID) as TSinaWeiboAPI_Statuses_Update;
  if APIItem<>nil then
  begin
    APIItem.Param_Status.Value:=URLEncodeUTF8(UTF8Encode(WeiboText));
    APIItem.Param_Source.Value:=Source;
    //APIItem.Param_In_Reply_To_Id.Value:='3377067832655670';
    if Self.API.CallAPI(CONST_API_Statuses_Update_ID) then
    begin
      Result:=True;
    end;
  end;
end;

function TSinaWeiboClient.GetStatuses_Friends_TimeLine_WeiboList: TSinaWeiboList;
var
  APIItem:TSinaWeiboAPI_Statuses_Friends_TimeLine;
begin
  Result:=nil;
  APIItem:=Self.FAPI.GetAPI(CONST_API_Statuses_Friends_TimeLine_ID) as TSinaWeiboAPI_Statuses_Friends_TimeLine;
  if APIItem<>nil then
  begin
    Result:=APIItem.WeiboList;
  end;
end;

function TSinaWeiboClient.GetStatuses_Update_WeiboItem: TSinaWeiboItem;
var
  APIItem:TSinaWeiboAPI_Statuses_Update;
begin
  Result:=nil;
  APIItem:=Self.FAPI.GetAPI(CONST_API_Statuses_Update_ID) as TSinaWeiboAPI_Statuses_Update;
  if APIItem<>nil then
  begin
    Result:=APIItem.WeiboItem;
  end;
end;

function TSinaWeiboClient.GetStatuses_User_TimeLine_WeiboList: TSinaWeiboList;
var
  APIItem:TSinaWeiboAPI_Statuses_User_TimeLine;
begin
  Result:=nil;
  APIItem:=Self.FAPI.GetAPI(CONST_API_Statuses_User_TimeLine_ID) as TSinaWeiboAPI_Statuses_User_TimeLine;
  if APIItem<>nil then
  begin
    Result:=APIItem.WeiboList;
  end;
end;

function TSinaWeiboClient.GetUserRecentWeiboList(Source, Since_Id, Max_Id,
  Count, Page, Base_App, Feature, Id, User_Id, Screen_Name: String): Boolean;
var
  APIItem:TSinaWeiboAPI_Statuses_User_TimeLine;
begin
  Result:=False;
  //设置参数
  APIItem:=Self.FAPI.GetAPI(CONST_API_Statuses_User_TimeLine_ID) as TSinaWeiboAPI_Statuses_User_TimeLine;
  APIItem.Param_Source.Value:=Source;
  APIItem.Param_Since_Id.Value:=Since_Id;
  APIItem.Param_Max_Id.Value:=Max_Id;
  APIItem.Param_Count.Value:=Count;
  APIItem.Param_Page.Value:=Page;
  APIItem.Param_Base_App.Value:=Base_App;
  APIItem.Param_Feature.Value:=Feature;
  APIItem.Param_Id.Value:=Id;
  APIItem.Param_User_Id.Value:=User_Id;
  APIItem.Param_Screen_Name.Value:=URLEncodeUTF8(UTF8Encode(Screen_Name));

  if APIItem<>nil then
  begin
    if Client.API.CallAPI(CONST_API_Statuses_User_TimeLine_ID) then
    begin
      Result:=True;
    end;
  end;
end;

function TSinaWeiboClient.SyncUserInfo:Boolean;
begin
  Result:=False;
  if Client.API.CallAPI(CONST_API_Statuses_Verify_Credentials_ID) then
  begin
    Result:=Client.User.LoadFromAPI( Client.API.GetAPI(CONST_API_Statuses_Verify_Credentials_ID) );
  end;
end;


//请求参数
// 	必选	类型及范围	说明
//source	true	string	申请应用时分配的AppKey，调用接口时候代表应用的唯一身份。（采用OAuth授权方式不需要此参数）
//with_new_status	false	int，默认为0。	1表示结果中包含new_status字段，0表示结果不包含new_status字段。new_status字段表示是否有新微博消息，1表示有，0表示没有
//since_id	false	int64	参数值为微博id。该参数需配合with_new_status参数使用，返回since_id之后，是否有新微博消息产生
function TSinaWeiboClient.GetHomePageUnReadMsgNum(Source, Since_Id,
  with_new_status: String): Boolean;
var
  APIItem:TSinaWeiboAPI_Statuses_Unread;
begin
  Result:=False;
  //设置参数
  APIItem:=Self.FAPI.GetAPI(CONST_API_Statuses_Unread_ID) as TSinaWeiboAPI_Statuses_Unread;
  APIItem.Param_Source.Value:=Source;
  APIItem.Param_Since_Id.Value:=Since_Id;
  APIItem.Param_Wit_New_Status.Value:=with_new_status;
  if APIItem<>nil then
  begin
    if Client.API.CallAPI(CONST_API_Statuses_Unread_ID) then
    begin
      Result:=True;
    end;
  end;
end;

// 	    必选	  类型及范围	说明
//source	true	string	申请应用时分配的AppKey，调用接口时候代表应用的唯一身份。（采用OAuth授权方式不需要此参数）
//since_id	false	int64	若指定此参数，则只返回ID比since_id大的微博消息（即比since_id发表时间晚的微博消息）。
//max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博消息
//count	false	int，默认值20，最大值200。	指定要返回的记录条数。
//page	false	int，默认值1。	指定返回结果的页码。根据当前登录用户所关注的用户数及这些被关注用户发表的微博数，翻页功能最多能查看的总记录数会有所不同，通常最多能查看1000条左右。
//base_app	false	int	是否基于当前应用来获取数据。1为限制本应用微博，0为不做限制。
//feature	false	int	微博类型，0全部，1原创，2图片，3视频，4音乐. 返回指定类型的微博信息内容。
function TSinaWeiboClient.GetHomePageWeiboList(Source:String;
                                        Since_Id:String;
                                        Max_Id:String;
                                        Count:String;
                                        Page:String;
                                        Base_App:String;
                                        Feature:String
                                        ):Boolean;
var
  APIItem:TSinaWeiboAPI_Statuses_Friends_TimeLine;
begin
  Result:=False;
  //设置参数
  APIItem:=Self.FAPI.GetAPI(CONST_API_Statuses_Friends_TimeLine_ID) as TSinaWeiboAPI_Statuses_Friends_TimeLine;
  APIItem.Param_Source.Value:=Source;
  APIItem.Param_Since_Id.Value:=Since_Id;
  APIItem.Param_Max_Id.Value:=Max_Id;
  APIItem.Param_Count.Value:=Count;
  APIItem.Param_Page.Value:=Page;
  APIItem.Param_Base_App.Value:=Base_App;
  APIItem.Param_Feature.Value:=Feature;
  if APIItem<>nil then
  begin
    if Client.API.CallAPI(CONST_API_Statuses_Friends_TimeLine_ID) then
    begin
      Result:=True;
    end;
  end;
end;

initialization
  Client:=TSinaWeiboClient.Create();


finalization
  FreeAndNil(Client);

end.
