unit uSinaWeiboParam;

interface

uses
  Windows,SysUtils,Classes;

type
  //请求的参数键值对
  TQueryParameter=class
  private
    FIsOAuth:Boolean;
    FName: String;
    FValue: String;
  public
    constructor Create(const AName:String;const AValue:String;AIsOAuth:Boolean=True);
    destructor Destroy;override;
  public
    property Name:String read FName write FName;
    property Value:String read FValue write FValue;
    property IsOAuth:Boolean read FIsOAuth write FIsOAuth;
  end;

  //参数列表
  TQueryParameters=class
  private
    FList:TList;
    function GetItem(Index: Integer): TQueryParameter;
    procedure SetItem(Index: Integer; const Value: TQueryParameter);
  protected
  public
    Function Count:Integer;
    procedure Clear;
    procedure ClearValues;
    constructor Create;
    destructor Destroy;override;
    //需要按照名字顺序排序，如果名字相同，那要根据值来排序，生成的签名才是有用的
    procedure Sort;
    function GetQueryParamsStr:String;
    function GetNotNullParamsStr:String;
    //添加一对键值
    procedure AddQueryParameter(const AName:String;const AValue:String);
    procedure Add(Param:TQueryParameter);
  public
    property Items[Index:Integer]:TQueryParameter read GetItem write SetItem;default;
  end;



function UrlEncode(URL: string): string;
function FucnUrlEncode(const S : String) : String;
function UrlEncodeUTF8(URL: UTF8String): string;
function FucnUrlEncodeUTF8(const S : UTF8String) : String;


implementation

function _IntToHex(Value: Integer; Digits: Integer): String;
begin
  Result := SysUtils.IntToHex(Value, Digits);
end;

function XDigit(Ch : Char) : Integer;
begin
  if (Ch >= '0') and (Ch <= '9') then
      Result := Ord(Ch) - Ord('0')
  else
      Result := (Ord(Ch) and 15) + 9;
end;


function IsXDigit(Ch : Char) : Boolean;
begin
  Result := ((Ch >= '0') and (Ch <= '9')) or
            ((Ch >= 'a') and (Ch <= 'f')) or
            ((Ch >= 'A') and (Ch <= 'F'));
end;

function htoin(Value : PChar; Len : Integer) : Integer;
var
  I : Integer;
begin
  Result := 0;
  I      := 0;
  while (I < Len) and (Value[I] = ' ') do
      I := I + 1;
  while (I < len) and (IsXDigit(Value[I])) do begin
      Result := Result * 16 + XDigit(Value[I]);
      I := I + 1;
  end;
end;

function htoi2(Value : PChar) : Integer;
begin
  Result := htoin(Value, 2);
end;

function FucnUrlEncode(const S : String) : String;
var
  I : Integer;
  Ch : Char;
begin
  Result := '';
  for I := 1 to Length(S) do begin
      Ch := S[I];
      if ((Ch >= '0') and (Ch <= '9')) or
         ((Ch >= 'a') and (Ch <= 'z')) or
         ((Ch >= 'A') and (Ch <= 'Z')) or
         (Ch = '.') or (Ch = '-') or (Ch = '_') or (Ch = '~')then
          Result := Result + Ch
      else
          Result := Result + '%' + _IntToHex(Ord(Ch), 2);
  end;
end;

function FucnUrlEncodeUTF8(const S : UTF8String) : String;
var
  I : Integer;
  Ch : AnsiChar;
begin
  Result := '';
  for I := 1 to Length(S) do begin
      Ch := S[I];
      if ((Ch >= '0') and (Ch <= '9')) or
         ((Ch >= 'a') and (Ch <= 'z')) or
         ((Ch >= 'A') and (Ch <= 'Z')) or
         (Ch = '.') or (Ch = '-') or (Ch = '_') or (Ch = '~')then
          Result := Result + Ch
      else
          Result := Result + '%' + _IntToHex(Ord(Ch), 2);
  end;
end;


function urlEncode(URL: string): string;
var
  URL1: string;
begin
  URL1 := FucnUrlEncode(URL);
  URL1 := StringReplace(URL1, '+', ' ', [rfReplaceAll, rfIgnoreCase]);
  result := URL1;
end;

function UrlEncodeUTF8(URL: UTF8String): string;
var
  URL1: string;
begin
  URL1 := FucnUrlEncodeUTF8(URL);
  URL1 := StringReplace(URL1, '+', ' ', [rfReplaceAll, rfIgnoreCase]);
  result := URL1;
end;


{ TQueryParameter }

constructor TQueryParameter.Create(const AName, AValue: String;AIsOAuth:Boolean=True);
begin
  FName:=AName;
  FValue:=AValue;
  FIsOAuth:=AIsOAuth;
end;

destructor TQueryParameter.Destroy;
begin

  inherited;
end;

{ TQueryParameters }

procedure TQueryParameters.Add(Param: TQueryParameter);
begin
  Self.FList.Add(Param);
end;

procedure TQueryParameters.AddQueryParameter(const AName, AValue: String);
begin
  Self.FList.Add(TQueryParameter.Create(AName,AValue));
end;

procedure TQueryParameters.Clear;
begin
  while Self.FList.Count>0 do
  begin
    TObject(Self.FList.Items[0]).Free;
    Self.FList.Delete(0);
  end;
end;

procedure TQueryParameters.ClearValues;
var
  I: Integer;
begin
  for I := 0 to Self.FList.Count - 1 do
  begin
    Items[I].Value:='';
  end;
end;

function TQueryParameters.Count: Integer;
begin
  Result:=Self.FList.Count;
end;

constructor TQueryParameters.Create;
begin
  FList:=TList.Create;
end;

destructor TQueryParameters.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

function TQueryParameters.GetItem(Index: Integer): TQueryParameter;
begin
  Result:=TQueryParameter(Self.FList.Items[Index]);
end;

function TQueryParameters.GetNotNullParamsStr: String;
var
  I:Integer;
begin
  Result:='';
  for I := 0 to Count-1 do
  begin
    if (Items[I].Value<>'') And Items[I].IsOAuth then
    begin
      Result:=Result+Items[I].Name+'='+Items[I].Value;
      if I<Count-1 then
      begin
        Result:=Result+'&';
      end;
    end;
  end;
end;

function TQueryParameters.GetQueryParamsStr: String;
var
  I:Integer;
begin
  Result:='';
  for I := 0 to Count-1 do
  begin
    if Items[I].IsOAuth then
    begin
      Result:=Result+Items[I].Name+'='+Items[I].Value;
      if I<Count-1 then
      begin
        Result:=Result+'&';
      end;
    end;
  end;
end;

procedure TQueryParameters.SetItem(Index: Integer;
  const Value: TQueryParameter);
begin
  Self.FList.Items[Index]:=Value;
end;

function SortByName_Compare(Item1, Item2: Pointer): Integer;
var
  Param1,Param2:TQueryParameter;
begin
  Param1:=TQueryParameter(Item1);
  Param2:=TQueryParameter(Item2);
  if Param1.FName>Param2.FName then
  begin
    Result:=1;
  end
  else if Param1.FName<Param2.FName then
  begin
    Result:=-1;
  end
  else
  begin
    if Param1.FValue>Param2.FValue then
    begin
      Result:=1;
    end
    else if Param1.FValue<Param2.FValue then
    begin
      Result:=-1;
    end
    else
    begin
      Result:=0;
    end;
  end;
end;

procedure TQueryParameters.Sort;
begin
  Self.FList.Sort(SortByName_Compare);
end;

end.
