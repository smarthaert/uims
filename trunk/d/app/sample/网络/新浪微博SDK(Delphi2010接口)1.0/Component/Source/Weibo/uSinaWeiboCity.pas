unit uSinaWeiboCity;

interface

uses
  Windows,SysUtils,Classes,Forms,StrUtils;

type
  TCityItem=class
  private
    FCityCode: Integer;
    FCityName: String;
  public
    constructor Create(ACityCode:Integer;ACityName:string);
    Property CityCode:Integer read FCityCode write FCityCode;
    property CityName:String read FCityName write FCityName;
  end;

  TCitys=class
  private
    FList:TList;
    function GetItem(Index: integer): TCityItem;
    procedure SetItem(Index: integer; const Value: TCityItem);
  public
    function Count:integer;
    procedure Clear;
    constructor Create;
    destructor Destroy;override;
    property Items[Index:integer]:TCityItem read GetItem write SetItem;default;
    function Add(ACityCode:Integer;ACityName:String):TCityItem;
    function GetCity(ACityCode:Integer):TCityItem;
  end;

  TProvinceItem=class
  private
    FProvinceName: String;
    FProvinceCode: Integer;
    FCitys: TCitys;
  public
    property Citys:TCitys read FCitys;
    constructor Create(AProvinceCode:Integer;AProvinceName:String);
    destructor Destroy;override;
    property ProvinceCode:Integer read FProvinceCode write FProvinceCode;
    property ProvinceName:String read FProvinceName write FProvinceName;
  end;

  TProvinces=class
  private
    FList:TList;
    function GetItem(Index: integer): TProvinceItem;
    procedure SetItem(Index: integer; const Value: TProvinceItem);
  public
    function Count:Integer;
    procedure Clear;
    constructor Create;
    destructor Destroy;override;
    property Items[Index:integer]:TProvinceItem read GetItem write SetItem;default;
    function Add(AProvinceCode:Integer;AProvinceName:String):TProvinceItem;
    function GetProvince(AProvinceCode:Integer):TProvinceItem;
  end;

  TSinaWeiboCity=class
  private
    FProvinces:TProvinces;
    Procedure InitializeData;
  public
    constructor Create;
    destructor Destroy;override;
    property Provinces:TProvinces read FProvinces;
    function GetProvinceName(AProvinceCode:Integer):String;
    function GetCityName(AProvinceCode:Integer;ACityCode:Integer):String;
    procedure SaveToXML(AFileName:String);
    procedure LoadFromXML(AFileName:String);
  end;

var
  GlobalSinaWeiboCity:TSinaWeiboCity;

implementation


{ TCityItem }

constructor TCityItem.Create(ACityCode: Integer; ACityName: string);
begin
  Self.FCityCode:=ACityCode;
  Self.FCityName:=ACityName;
end;

{ TCitys }

function TCitys.Add(ACityCode: Integer; ACityName: String): TCityItem;
begin
  Result:=TCityItem.Create(ACityCode,ACityName);
  FList.Add(Result);
end;

procedure TCitys.Clear;
begin
  while FList.Count>0 do
  begin
    TObject(FList.Items[0]).Free;
    FList.Delete(0);
  end;
end;

function TCitys.Count: integer;
begin
  Result:=Self.FList.Count;
end;

constructor TCitys.Create;
begin
  FList:=TList.Create;
end;

destructor TCitys.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

function TCitys.GetCity(ACityCode: Integer): TCityItem;
var
  I: Integer;
begin
  Result:=nil;
  for I := 0 to FList.Count - 1 do
  begin
    if TCityItem(FList.Items[I]).CityCode=ACityCode then
    begin
      Result:=TCityItem(FList.Items[I]);
      Break;
    end;
  end;
end;

function TCitys.GetItem(Index: integer): TCityItem;
begin
  Result:=TCityItem(Self.FList.Items[Index]);
end;

procedure TCitys.SetItem(Index: integer; const Value: TCityItem);
begin
  Self.FList.Items[Index]:=Value;
end;

{ TProvinceItem }

constructor TProvinceItem.Create(AProvinceCode: Integer; AProvinceName: String);
begin
  FCitys:=TCitys.Create;
  Self.FProvinceName:=AProvinceName;
  Self.FProvinceCode:=AProvinceCode;
end;

destructor TProvinceItem.Destroy;
begin
  FCitys.Free;
  inherited;
end;

{ TProvinces }


function TProvinces.Add(AProvinceCode: Integer; AProvinceName: String): TProvinceItem;
begin
  Result:= TProvinceItem.Create(AProvinceCode,AProvinceName);
  FList.Add( Result);
end;

procedure TProvinces.Clear;
begin
  while FList.Count>0 do
  begin
    TObject(FList.Items[0]).Free;
    FList.Delete(0);
  end;
end;

function TProvinces.Count: integer;
begin
  Result:=Self.FList.Count;
end;

constructor TProvinces.Create;
begin
  FList:=TList.Create;
end;

destructor TProvinces.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

function TProvinces.GetProvince(AProvinceCode: Integer): TProvinceItem;
var
  I: Integer;
begin
  Result:=nil;
  for I := 0 to FList.Count - 1 do
  begin
    if TProvinceItem(FList.Items[I]).ProvinceCode=AProvinceCode then
    begin
      Result:=TProvinceItem(FList.Items[I]);
      Break;
    end;
  end;
end;

function TProvinces.GetItem(Index: integer): TProvinceItem;
begin
  Result:=TProvinceItem(Self.FList.Items[Index]);
end;

procedure TProvinces.SetItem(Index: integer; const Value: TProvinceItem);
begin
  Self.FList.Items[Index]:=Value;
end;

{ TSinaWeiboCity }

constructor TSinaWeiboCity.Create;
begin
  FProvinces:=TProvinces.Create;
  InitializeData;
end;

destructor TSinaWeiboCity.Destroy;
begin
  FProvinces.Free;
  inherited;
end;

function TSinaWeiboCity.GetCityName(AProvinceCode, ACityCode: Integer): String;
begin
  Result:=Self.FProvinces.GetProvince(AProvinceCode).Citys.GetCity(ACityCode).CityName;
end;

function TSinaWeiboCity.GetProvinceName(AProvinceCode: Integer): String;
begin
  Result:=Self.FProvinces.GetProvince(AProvinceCode).ProvinceName;
end;

procedure TSinaWeiboCity.InitializeData;
var
  ProvinceStrList:TStringList;
  CityStrList:TStringList;
  I,J:Integer;
  Province:TProvinceItem;
  CurPos:Integer;
  SpacePos:Integer;
  CitysStr:String;
  ProvinceCodeStr:String;
  ProvinceNameStr:String;
  CityCodeStr:String;
  CityNameStr:String;
begin
  ProvinceStrList:=TStringList.Create;
  CityStrList:=TStringList.Create;
  Try
    ProvinceStrList.LoadFromFile(ExtractFilePath(Application.ExeName)+'省份城市编码.txt');
    for I := 0 to ProvinceStrList.Count - 1 do
    begin
      //46  海南  1 => "海口", 2 => "三亚", 90 => "其他"
      //获取省份编码
      //OutputDebugString(PWideChar(IntToStr(I)));
      CurPos:=1;
      SpacePos:=PosEx(' ',ProvinceStrList[I],CurPos);
      if SpacePos>0 then
      begin
        ProvinceCodeStr:=Copy(ProvinceStrList[I],CurPos,SpacePos-CurPos);
        CurPos:=SpacePos+2;
      end
      else
      begin
      //
      end;
      //获取省份名称
      SpacePos:=PosEx(' ',ProvinceStrList[I],CurPos);
      if SpacePos>0 then
      begin
        ProvinceNameStr:=Copy(ProvinceStrList[I],CurPos,SpacePos-CurPos);
        //有两个空格，跳过
        CurPos:=SpacePos+2;
      end
      else
      begin
        //
      end;
      Province:=Self.FProvinces.Add(StrToInt(ProvinceCodeStr),ProvinceNameStr);
      //城市串
      //1 => "海口", 2 => "三亚", 90 => "其他"
      //也有可能是" "
      //CityStrList.Delimiter:=',';
      //CityStrList.Commatext:=Copy(ProvinceStrList[I],CurPos,Length(ProvinceStrList[I]));
      CityStrList.Clear;
      CitysStr:=Copy(ProvinceStrList[I],CurPos,Length(ProvinceStrList[I]));
      CurPos:=1;
      repeat
        SpacePos:=PosEx(',',CitysStr,CurPos);
        if SpacePos>0 then
        begin
          CityStrList.Add( Trim(Copy(CitysStr,CurPos,SpacePos-CurPos)) );
          CurPos:=SpacePos+1;
        end
        else
        begin
          if CurPos<Length(CitysStr) then
          begin
            CityStrList.Add( Trim(Copy(CitysStr,CurPos,Length(CitysStr))) );
          end;
          
        end;


      until SpacePos=0;


      for J := 0 to CityStrList.Count - 1 do
      begin
        CurPos:=1;
        //OutputDebugString(PwideChar(CityStrList[J]));
        if Length(CityStrList[J])>3 then
        begin
          SpacePos:=PosEx(' ',CityStrList[J],CurPos);
          if SpacePos>0 then
          begin
            CityCodeStr:=Copy(CityStrList[J],CurPos,SpacePos-CurPos);
            //CurPos
          end
          else
          begin
          //
          end;
          SpacePos:=PosEx('"',CityStrList[J],CurPos);
          if SpacePos>0 then
          begin
            CurPos:=PosEx('"',CityStrList[J],SpacePos+1);
            CityNameStr:=Copy(CityStrList[J],SpacePos+1,CurPos-SpacePos-1);
          end
          else
          begin

          end;
          Province.Citys.Add( StrToInt(CityCodeStr),CityNameStr );
        end;
      end;
    end;
  Finally
    ProvinceStrList.Free;
    CityStrList.Free;
  End;

end;

procedure TSinaWeiboCity.LoadFromXML(AFileName: String);
begin
  //
end;

procedure TSinaWeiboCity.SaveToXML(AFileName: String);
begin
  //
end;

initialization
  GlobalSinaWeiboCity:=TSinaWeiboCity.Create;

finalization
  GlobalSinaWeiboCity.Free;;

end.


