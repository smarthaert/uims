unit uSinaWeiboAPI_Statuses_Unread;

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
  TSinaWeiboAPI_Statuses_Unread=class(TSinaWeiboAPIItem)
  private
    FParam_Wit_New_Status: TQueryParameter;
    FParam_Source: TQueryParameter;
    FParam_Since_Id: TQueryParameter;
    FMentions: Integer;
    FFollowers: Integer;
    FDm: Integer;
    FNew_Status: Integer;
    FComments: Integer;
  protected
    //从服务器返回的Jason信息解析出用户信息
    function ParseFromJson(Response:String):Boolean;override;
  public
    constructor Create;
    destructor Destroy;override;
  public
 	  //必选	类型及范围	说明
    //调用接口时候代表应用的唯一身份。（采用OAuth授权方式不需要此参数）
    property Param_Source:TQueryParameter read FParam_Source;
    //since_id	false	int64	若指定此参数，则只返回ID比since_id大的微博消息
    //（即比since_id发表时间晚的微博消息）。
    property Param_Since_Id:TQueryParameter read FParam_Since_Id;
    //with_new_status	false	int，默认为0。	1表示结果中包含new_status字段，0表示结果不包含new_status字段。new_status字段表示是否有新微博消息，1表示有，0表示没有
    property Param_Wit_New_Status:TQueryParameter read FParam_Wit_New_Status;
  public
    //Json数据
    //    "comments" : 3,
    property Comments:Integer read FComments write FComments;
    //    "followers" : 0,
    property Followers:Integer read FFollowers write FFollowers;
    //    "new_status" : 1,
    property New_Status:Integer read FNew_Status write FNew_Status;
    //    "dm" : 1,
    property Dm:Integer read FDm write FDm;
    //    "mentions" : 1
    property Mentions:Integer read FMentions write FMentions;
  end;


var
  GlobalSinaWeiboAPI_Statuses_Unread:TSinaWeiboAPI_Statuses_Unread;

implementation

{ TSinaWeiboAPI_Statuses_Unread }

constructor TSinaWeiboAPI_Statuses_Unread.Create;
begin
  Inherited Create(
                          CONST_API_Statuses_Unread_ID,
                          CONST_API_Statuses_Unread_NAME,
                          CONST_API_Statuses_Unread_URL,
                          CONST_API_Statuses_Unread_NEEDLOGIN,
                          CONST_API_Statuses_Unread_REQLIMIT,
                          CONST_API_Statuses_Unread_DESCRIP,
                          CONST_API_Statuses_Unread_STYLES,
                          CONST_API_Statuses_Unread_REQMETHOD
                  );

  FParam_Wit_New_Status:=TQueryParameter.Create('user_id','');
  FParam_Source:=TQueryParameter.Create('user_id','');
  FParam_Since_Id:=TQueryParameter.Create('user_id','');

  FMentions:=0;
  FFollowers:=0;
  FComments:=0;
  FDm:=0;
  FNew_Status:=0;

  Params.Add(FParam_Wit_New_Status);
  Params.Add(FParam_Source);
  Params.Add(FParam_Since_Id);

end;

destructor TSinaWeiboAPI_Statuses_Unread.Destroy;
begin
  inherited;
end;

function TSinaWeiboAPI_Statuses_Unread.ParseFromJson(
  Response:String): Boolean;
var
  Json: TlkJSONobject;
begin
  Result:=False;
  FMentions:=0;
  FFollowers:=0;
  FComments:=0;
  FDm:=0;
  FNew_Status:=0;
  //获取微博列表
  Json := TlkJson.ParseText(Response) as TlkJSONobject;
  if Json<>nil then
  begin
    if Json.Field['comments']<>nil then
    begin
      FComments:=Json.Field['comments'].Value;
    end;
    if Json.Field['followers']<>nil then
    begin
      FFollowers:=Json.Field['followers'].Value;
    end;
    if Json.Field['new_status']<>nil then
    begin
      FNew_status:=Json.Field['new_status'].Value;
    end;
    if Json.Field['dm']<>nil then
    begin
      FDm:=Json.Field['dm'].Value;
    end;
    if Json.Field['mentions']<>nil then
    begin
      FMentions:=Json.Field['mentions'].Value;
    end;
    Result:=True;

    Json.Free;
  end;//if
end;


initialization
  GlobalSinaWeiboAPI_Statuses_Unread:=TSinaWeiboAPI_Statuses_Unread.Create;
  RegisterSinaWeiboAPI(GlobalSinaWeiboAPI_Statuses_Unread);


finalization
  //UnRegisterSinaWeiboAPI(GlobalSinaWeiboAPI_Statuses_Unread);
  //GlobalSinaWeiboAPI_Statuses_Unread.Free;


end.


