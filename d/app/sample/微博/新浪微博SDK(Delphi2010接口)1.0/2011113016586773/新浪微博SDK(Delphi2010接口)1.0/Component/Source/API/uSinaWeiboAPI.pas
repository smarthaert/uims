unit uSinaWeiboAPI;

interface

uses
  Windows,SysUtils,Classes,Dialogs,StrUtils,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdMultipartFormData,
  IdHTTP,
  uSinaWeiboAPIConst,
  uMyOAuth,
  uSinaWeiboParam;

type
  TSinaWeiboAPIErrorItem=class
  private
    FErrorHint: String;
    FErrorCode: Integer;
  public
    constructor Create(AErrorCode:Integer;AErrorHint:String);
    property ErrorCode:Integer read FErrorCode write FErrorCode;
    property ErrorHint:String read FErrorHint write FErrorHint;
  end;

  TSinaWeiboAPIErrors=class
  private
    FList:TList;
    function GetItem(Index: Integer): TSinaWeiboAPIErrorItem;
    procedure SetItem(Index: Integer; const Value: TSinaWeiboAPIErrorItem);
  public
    procedure Clear;
    function Count:Integer;
    constructor Create;
    destructor Destroy;override;
    function Add(AErrorCode:Integer;AErrorHint:String):TSinaWeiboAPIErrorItem;
    property Items[Index:Integer]:TSinaWeiboAPIErrorItem read GetItem write SetItem;default;
  end;

  TSinaWeiboAPIItem=class
  private
    FID:Integer;
    FURL: String;
    FIsNeedLogin: Boolean;
    FRequestNumLimit: Boolean;
    FDescription: String;
    FSurrpotFormats: TCallAPIStyleSet;
    FAPIErrors: TSinaWeiboAPIErrors;
    FHTTPRequestMethod: TCallAPIHTTPRequestMethod;
    FParams:TQueryParameters;
    FName: String;
  protected
    Function CallAPIURL:String;virtual;
    Function ParseFromJson(Response:String):Boolean;overload;virtual;
    procedure CallAPIHTTPPostSetting(AHTTP:TIdHttp;var HTTPPostStream:TMemoryStream);virtual;
    procedure CallAPIHTTPGetSetting(AHTTP:TIdHttp);virtual;
  public
    constructor Create(
                      AID:Integer;
                      AName:String;
                      AURL: String;
                      AIsNeedLogin: Boolean;
                      ARequestNumLimit: Boolean;
                      ADescription: String;
                      ASurrpotFormats: TCallAPIStyleSet;
                      AHTTPRequestMethod: TCallAPIHTTPRequestMethod
                      );virtual;
    destructor Destroy;override;
  public
    //API的ID
    property ID:Integer read FID write FID;
    property Name:String read FName write FName;
    //URL
    property URL:String read FURL write FURL;
    //参数列表
    property Params:TQueryParameters read FParams;
    //API出错代码
    property APIErrors:TSinaWeiboAPIErrors read FAPIErrors;
    //是否需要登陆
    property IsNeedLogin:Boolean read FIsNeedLogin write FIsNeedLogin;
    //介绍
    property Description:String read FDescription write FDescription;
    //请求数限制
    property RequestNumLimit:Boolean read FRequestNumLimit write FRequestNumLimit;
    //支持的调用格式
    property SurrpotFormats:TCallAPIStyleSet read FSurrpotFormats write FSurrpotFormats;
    //请求方式
    property HTTPRequestMethod:TCallAPIHTTPRequestMethod read FHTTPRequestMethod write FHTTPRequestMethod;
  end;

  TSinaWeiboAPIs=class
  private
    FList:TList;
    function GetItem(Index: Integer): TSinaWeiboAPIItem;
    procedure SetItem(Index: Integer; const Value: TSinaWeiboAPIItem);
  public
    procedure Clear;
    function Count:Integer;
    constructor Create;
    destructor Destroy;override;
    function FindItemByID(ID:Integer):TSinaWeiboAPIItem;
    procedure Add(AItem:TSinaWeiboAPIItem);overload;
    procedure Delele(AItem:TSinaWeiboAPIItem);
    Function Add( AID:Integer;
                  AName:String;
                  AURL: String;
                  AIsNeedLogin: Boolean;
                  ARequestNumLimit: Boolean;
                  ADescription: String;
                  ASurrpotFormats: TCallAPIStyleSet;
                  AHTTPRequestMethod: TCallAPIHTTPRequestMethod
                  ):TSinaWeiboAPIItem;overload;
    property Items[Index:Integer]:TSinaWeiboAPIItem read GetItem write SetItem;default;
  end;



  TCustomSinaWeiboAPI=class
  private
    FHttp: TIdHttp;
    FStyle: TCallAPIStyle;
    FAPIs: TSinaWeiboAPIs;
    FOAuth:TMyOAuth;
  public
    constructor Create(AOAuth:TMyOAuth);
    Destructor Destroy;override;
    //调用API,然后解析
    function CallAPI(API_ID:Integer):Boolean;overload;
    //获取API
    function GetAPI(API_ID:Integer):TSinaWeiboAPIItem;
  public
    //验证
    property OAuth:TMyOAuth read FOAuth write FOAuth;
    //用于向服务器调用接口
    property Http:TIdHttp read FHttp;
    //API的调用方式，使用Json还是Xml文档
    property Style:TCallAPIStyle read FStyle write FStyle;
    //支持的接口
    property APIs:TSinaWeiboAPIs read FAPIs;
  end;

  TSinaWeiboAPI=class(TCustomSinaWeiboAPI)
  end;

var
  GlobalSinaWeiboAPIs:TSinaWeiboAPIs;

//注册新浪API
procedure RegisterSinaWeiboAPI(AItem:TSinaWeiboAPIItem);
//取消注册新浪API
//procedure UnRegisterSinaWeiboAPI(AItem:TSinaWeiboAPIItem);

implementation


procedure RegisterSinaWeiboAPI(AItem:TSinaWeiboAPIItem);
begin
  if GlobalSinaWeiboAPIs=nil then
    GlobalSinaWeiboAPIs:=TSinaWeiboAPIs.Create;
  GlobalSinaWeiboAPIs.Add(AItem);
end;

//procedure UnRegisterSinaWeiboAPI(AItem:TSinaWeiboAPIItem);
//begin
//  GlobalSinaWeiboAPIs.Delele(AItem);
//end;


{ TCustomSinaWeibo }

function TCustomSinaWeiboAPI.CallAPI(API_ID:Integer): Boolean;
var
  APIItem:TSinaWeiboAPIItem;
  procedure SaveStringToFile(const AAnsiString:AnsiString;const AFileName:String);
  var
    AFileStream:TFileStream;
  begin
    AFileStream:=TFileStream.Create(AFileName,fmCreate);
    AFileStream.Write(AAnsiString[1],Length(AAnsiString) );
    AFileStream.Free;
  end;
  function LoadStringFromFile(const AFileName:String):AnsiString;
  var
    AFileStream:TFileStream;
  begin
    AFileStream:=TFileStream.Create(AFileName,fmOpenRead);
    SetLength( Result,AFileStream.Size );
    AFileStream.Read(Result[1],AFileStream.Size );
    AFileStream.Free;
  end;
var
  Response:String;
var
  URL:String;
  Signature:String;
  API_QueryParams:String;
  HTTPRequestMethod:String;
  HTTPPostStream:TMemoryStream;
begin
  Result:=False;
  Response:='';
  //获取API
  APIItem:=Self.FAPIs.FindItemByID(API_ID);
  if APIItem<>nil then
  begin
    if Self.FStyle=cpsJson then
    begin
      //调用API
      API_QueryParams:=APIItem.Params.GetNotNullParamsStr;

      URL := APIItem.CallAPIURL+'.json';
      //HTTP请求方法
      case APIItem.FHTTPRequestMethod of
        rmPost:
        begin
          HTTPRequestMethod:='POST';
        end;
        rmGet:
        begin
          HTTPRequestMethod:='GET';
        end;
      end;
      //加上签名
      Signature:=FOAuth.AppendSignatureString(URL,
                      API_QueryParams,HTTPRequestMethod);
      //加上签名串
      URL:=URL+'?'+Signature;
      Try
        case APIItem.FHTTPRequestMethod of
          rmPost:
          begin
            HTTPPostStream:=TMemoryStream.Create;
            APIItem.CallAPIHTTPPostSetting(FHttp,HTTPPostStream);
            HTTPPostStream.Position:=0;
            Response := Self.FHttp.Post(URL,HTTPPostStream);
            HTTPPostStream.Free;
          end;
          rmGet:
          begin
            APIItem.CallAPIHTTPGetSetting(FHttp);
            Response := Self.FHttp.Get(URL);
          end;
        end;
        Result:=True;
      Except
        Result:=False;
      End;

      //解析返回结果
      if Result then
      begin
        //保存返回Json
        SaveStringToFile(URL+#13#10+Response,APIItem.Name+'-'+FormatDateTime('YYYY-MM-DD-HH-MM-SS',Now)+'.json');
        Result:=APIItem.ParseFromJson(Response);
      end;
    end;
  end;
end;

constructor TCustomSinaWeiboAPI.Create(AOAuth:TMyOAuth);
begin
  FAPIs:=GlobalSinaWeiboAPIs;
  FOAuth:=AOAuth;
  FHttp:=TIdHttp.Create(nil);
  FHTTP.ConnectTimeout:=20000;
end;

destructor TCustomSinaWeiboAPI.Destroy;
begin
  FHttp.Free;
  inherited;
end;

function TCustomSinaWeiboAPI.GetAPI(API_ID: Integer): TSinaWeiboAPIItem;
begin
  Result:=Self.FAPIs.FindItemByID(API_ID);
end;




{ TSinaWeiboAPIErrors }

Function TSinaWeiboAPIErrors.Add(AErrorCode:Integer;AErrorHint: String):TSinaWeiboAPIErrorItem;
begin
  Result:=TSinaWeiboAPIErrorItem.Create(AErrorCode, AErrorHint);
  FList.Add(Result  );
end;

procedure TSinaWeiboAPIErrors.Clear;
begin
  while Self.FList.Count>0 do
  begin
    TObject(Self.FList.Items[0]).Free;
    Self.FList.Delete(0);
  end;
end;

function TSinaWeiboAPIErrors.Count: Integer;
begin
  Result:=FList.Count;
end;

constructor TSinaWeiboAPIErrors.Create;
begin
  FList:=TList.Create;
end;

destructor TSinaWeiboAPIErrors.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

function TSinaWeiboAPIErrors.GetItem(Index: Integer): TSinaWeiboAPIErrorItem;
begin
  Result:=TSinaWeiboAPIErrorItem(FList.Items[Index]);
end;

procedure TSinaWeiboAPIErrors.SetItem(Index: Integer;
  const Value: TSinaWeiboAPIErrorItem);
begin
  FList.Items[Index]:=Value;
end;

{ TSinaWeiboAPIs }

Function TSinaWeiboAPIs.Add(
                        AID:Integer;
                        AName:String;
                        AURL: String;
                        AIsNeedLogin: Boolean;
                        ARequestNumLimit: Boolean;
                        ADescription: String;
                        ASurrpotFormats: TCallAPIStyleSet;
                        AHTTPRequestMethod: TCallAPIHTTPRequestMethod
                        ):TSinaWeiboAPIItem;
begin
  Result:=TSinaWeiboAPIItem.Create(
                                  AID,
                                  AName,
                                  AURL,
                                  AIsNeedLogin,
                                  ARequestNumLimit,
                                  ADescription,
                                  ASurrpotFormats,
                                  AHTTPRequestMethod
                                  );
  FList.Add( Result );
end;

procedure TSinaWeiboAPIs.Add(AItem: TSinaWeiboAPIItem);
begin
  FList.Add( AItem );
end;

procedure TSinaWeiboAPIs.Clear;
begin
  while Self.FList.Count>0 do
  begin
    TObject(Self.FList.Items[0]).Free;
    Self.FList.Delete(0);
  end;
end;

function TSinaWeiboAPIs.Count: Integer;
begin
  Result:=FList.Count;
end;

constructor TSinaWeiboAPIs.Create;
begin
  FList:=TList.Create;
end;

procedure TSinaWeiboAPIs.Delele(AItem: TSinaWeiboAPIItem);
begin
  Self.FList.Remove(AItem);
end;

destructor TSinaWeiboAPIs.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

function TSinaWeiboAPIs.FindItemByID(ID: Integer): TSinaWeiboAPIItem;
var
  I: Integer;
begin
  Result:=nil;
  for I := 0 to Self.FList.Count - 1 do
  begin
    if TSinaWeiboAPIItem(Self.FList.Items[I]).FID=ID then
    begin
      Result:=Self.FList.Items[I];
      Break;
    end;
  end;
end;

function TSinaWeiboAPIs.GetItem(Index: Integer): TSinaWeiboAPIItem;
begin
  Result:=TSinaWeiboAPIItem(FList.Items[Index]);
end;

procedure TSinaWeiboAPIs.SetItem(Index: Integer;
  const Value: TSinaWeiboAPIItem);
begin
  FList.Items[Index]:=Value;
end;


{ TSinaWeiboAPIErrorItem }

constructor TSinaWeiboAPIErrorItem.Create(AErrorCode:Integer; AErrorHint: String);
begin
  Self.FErrorHint:=AErrorHint;
  Self.FErrorCode:=AErrorCode;
end;

{ TSinaWeiboAPIItem }

procedure TSinaWeiboAPIItem.CallAPIHTTPGetSetting(AHTTP: TIdHttp);
begin
  AHTTP.Request.RawHeaders.Clear;
end;

procedure TSinaWeiboAPIItem.CallAPIHTTPPostSetting(AHTTP: TIdHttp;var HTTPPostStream:TMemoryStream);
begin
  AHTTP.Request.RawHeaders.Clear;
end;

function TSinaWeiboAPIItem.CallAPIURL: String;
begin
  Result:=Self.FURL;
end;

constructor TSinaWeiboAPIItem.Create(
                      AID:Integer;
                      AName:String;
                      AURL: String;
                      AIsNeedLogin: Boolean;
                      ARequestNumLimit: Boolean;
                      ADescription: String;
                      ASurrpotFormats: TCallAPIStyleSet;
                      AHTTPRequestMethod: TCallAPIHTTPRequestMethod
                      );
begin
  FAPIErrors:=TSinaWeiboAPIErrors.Create;
  Self.FID:=AID;
  Self.FName:=AName;
  Self.FURL:=AURL;
  Self.FIsNeedLogin:=AIsNeedLogin;
  Self.FRequestNumLimit:=ARequestNumLimit;
  Self.FDescription:=ADescription;
  Self.FSurrpotFormats:=ASurrpotFormats;
  Self.FHTTPRequestMethod:=AHTTPRequestMethod;
  Self.FParams:=TQueryParameters.Create;
end;

destructor TSinaWeiboAPIItem.Destroy;
begin
  FParams.Free;
  FAPIErrors.Free;
  inherited;
end;

function TSinaWeiboAPIItem.ParseFromJson(Response:String): Boolean;
begin
  Result:=False;
end;

Initialization
  if GlobalSinaWeiboAPIs=nil then
    GlobalSinaWeiboAPIs:=TSinaWeiboAPIs.Create;

finalization
  FreeAndNil(GlobalSinaWeiboAPIs);


end.
