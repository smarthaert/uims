unit fDef;

interface

uses Classes, Dialogs, DateUtils, StrUtils;

type

{ TArrayOfSingle }

  TArrayOfSingle = array of Single;
  TArrayOfInteger = array of Integer;

{ TStkDataRec }//0000,13100,13100X(nonEtron),13171X(nonBank),17100  数据文件的格式
  PStkDataRec = ^TStkDataRec;
  TStkDataRec = packed record
    Date: TDateTime; //日期
    OP, HP, LP, CP, VOL: Single; //收盘,开盘,最高,最低,涨跌,成交量
  end;

{ IBaseDataFile }
  IBaseDataFile = interface(IUnknown)
    function getCount: Integer;
    function getFileName: string;
    function getHeader: Pointer;
    function getHeaderSize: Integer;
    function getRec(Index: Integer): Pointer;
    function getRecSize: Integer;
    procedure loadFromFile(const FileName: string);
    procedure saveAs(FileName: string);
    function seek(Index: Integer): Pointer;
  end;

{ TBaseDataFile }
  TBaseDataFile = class(TInterfacedObject, IBaseDataFile)
  protected
    M: TMemoryStream;
  protected
    function getCount: Integer; virtual;
    procedure Reload; virtual;
    function getHeader: Pointer; virtual;
    function getRec(Index: Integer): Pointer; virtual;
    function seek(Index: Integer): Pointer; virtual;
    procedure loadFromFile(const FileName: string); virtual;
    procedure loadFromTxtFile(const FileName: string); virtual;
    procedure saveAs(FileName: string); virtual;
  protected
    function getFileName: string; virtual; abstract;
    function getFilePath: string; virtual; abstract;
    function getHeaderSize: Integer; virtual;
    function getRecSize: Integer; virtual; abstract;
  public
    constructor Create; virtual;
    destructor Destroy; override;
  end;

{ IDataFile }
 //function getData(Date: WORD): Pointer;->Date<MAX_DATADAY means Index from tail toward header, or Search data by Date
  IDataFile = interface(IBaseDataFile)
    function getData(Date: Integer): Pointer;
    function getStockName: string;
    function indexOf(Date: TDateTime): Integer; overload; //Search by Date, Index from header to tail
    function indexOf(Date: TDateTime; L, H: Integer): Integer; overload; //Search by Date, Index from header to tail
    function getCP: TArrayOfSingle;
    function getUD: TArrayOfSingle;
    function getVOL: TArrayOfSingle;
    procedure save;
  end;

{ TDataFile }
  TDataFile = class(TBaseDataFile, IDataFile)
  protected
    FStockName: string;
    FStockPath: string;
    function FindData(Date: WORD; L, H: Integer): Pointer; virtual;
    function RecStart: Integer; virtual;
  protected //implementation of interface function//
    function getFileName: string; override;
    function getFilePath: string; override;
    function getRecSize: Integer; override;
    function getData(Date: Integer): Pointer; virtual;
    function getStockName: string; virtual;
    function indexOf(Date: TDateTime): Integer; overload; //Search by Date, Index from header to tail
    function indexOf(Date: TDateTime; L, H: Integer): Integer; overload; //Search by Date, Index from header to tail
    procedure save; virtual;
    function seek(Index: Integer): Pointer; override;
    function getCP: TArrayOfSingle;
    function getUD: TArrayOfSingle;
    function getVOL: TArrayOfSingle;
  public
    constructor Create(const StockPath: string); reintroduce;
    procedure Reload(const StockName: string);
  end;

implementation

uses fUtils, SysUtils;

{ TBaseDataFile }

constructor TBaseDataFile.Create;
var
  ext: string;
begin
  inherited;
  ext := ExtractFileExt(getFilePath);
  if ext <> '.DAT' then loadFromTxtFile(getFilePath) else loadFromFile(getFilePath);
  //loadFromFile(StockPath);
end;

destructor TBaseDataFile.Destroy;
begin
  _free_(M);
  inherited;
end;

procedure TBaseDataFile.Reload;
begin
  inherited;
  loadFromFile(getFilePath);
end;

function TBaseDataFile.getCount: Integer;
begin
  if M = nil then Result := 0 else Result := (M.Size - getHeaderSize) div getRecSize;
end;

function TBaseDataFile.getHeader: Pointer;
begin
  if M <> nil then Result := M.Memory else Result := nil;
end;

function TBaseDataFile.getHeaderSize: Integer; //没有文件头信息
begin
  Result := 0;
end;

function TBaseDataFile.getRec(Index: Integer): Pointer;
begin //查找的最大范围是getCount
  if (Index > -1) and (Index < getCount) then Result := Seek(Index) else Result := nil;
end;

procedure TBaseDataFile.loadFromFile(const FileName: string); //加载指定文件到内存
begin
  _free_(M);
  if FileExists(FileName) then
  begin
    M := TMemoryStream.Create;
    M.LoadFromFile(FileName);
    M.Position := 0;
  end;
end;

procedure TBaseDataFile.loadFromTxtFile(const FileName: string); //加载指定文件到内存
var
  i: Integer;
  lstSplit: TStringList;
  rec: TStkDataRec;
  line: string;
  rText: TextFile;
begin
  _free_(M);
  if FileExists(FileName) then
  begin
    M := TMemoryStream.Create;
   //M.LoadFromFile(FileName);
    AssignFile(rText, FileName);
    reset(rText);
    while not EOF(rText) do
    begin
    {
      readln(rText, line);

      lstSplit := TStringList.Create;
      lstSplit.Delimiter := ' ';
      lstSplit.DelimitedText := line;
      //ShowMessage(lstSplit.Strings[0]);

      if length(lstSplit.Strings[1]) = 4 then
      begin
        rec.Date := EncodeDateTime(StrToInt(LeftStr(lstSplit.Strings[0], 4)), StrToInt(MidStr(lstSplit.Strings[0], 5, 2)), StrToInt(RightStr(lstSplit.Strings[0], 2)), StrToInt(LeftStr(lstSplit.Strings[1], 2)), StrToInt(RightStr(lstSplit.Strings[1], 2)), 0, 0);
      end
      else
      begin
        rec.Date := EncodeDateTime(StrToInt(LeftStr(lstSplit.Strings[0], 4)), StrToInt(MidStr(lstSplit.Strings[0], 5, 2)), StrToInt(RightStr(lstSplit.Strings[0], 2)), StrToInt(LeftStr(lstSplit.Strings[1], 1)), StrToInt(RightStr(lstSplit.Strings[1], 2)), 0, 0);
      end;

      rec.OP := StrToFloat(lstSplit.Strings[2]);
      rec.CP := StrToFloat(lstSplit.Strings[3]);
      rec.HP := StrToFloat(lstSplit.Strings[4]);
      rec.LP := StrToFloat(lstSplit.Strings[5]);
      rec.VOL := StrToInt(lstSplit.Strings[6]);
    }
      readln(rText, line);

      lstSplit := TStringList.Create;
      lstSplit.Delimiter := ',';
      lstSplit.DelimitedText := line;
      //ShowMessage(lstSplit.Strings[0]);

      if length(lstSplit.Strings[2]) = 4 then
      begin
        rec.Date := EncodeDateTime(StrToInt(LeftStr(lstSplit.Strings[1], 4)), StrToInt(MidStr(lstSplit.Strings[1], 5, 2)), StrToInt(RightStr(lstSplit.Strings[1], 2)), StrToInt(LeftStr(lstSplit.Strings[2], 2)), StrToInt(RightStr(lstSplit.Strings[2], 2)), 0, 0);
      end
      else
      begin
        rec.Date := EncodeDateTime(StrToInt(LeftStr(lstSplit.Strings[1], 4)), StrToInt(MidStr(lstSplit.Strings[1], 5, 2)), StrToInt(RightStr(lstSplit.Strings[1], 2)), StrToInt(LeftStr(lstSplit.Strings[2], 1)), StrToInt(RightStr(lstSplit.Strings[2], 2)), 0, 0);
      end;

      //ShowMessage(FormatDateTime('yyyy-mm-dd  hh:nn', rec.Date));

      rec.OP := StrToFloat(lstSplit.Strings[3]);
      rec.CP := StrToFloat(lstSplit.Strings[4]);
      rec.HP := StrToFloat(lstSplit.Strings[5]);
      rec.LP := StrToFloat(lstSplit.Strings[6]);
      rec.VOL := StrToInt(lstSplit.Strings[10]);

      {
      rec.OP := StrToInt(lstSplit.Strings[2]) / 10000;
      rec.HP := StrToInt(lstSplit.Strings[3]) / 10000;
      rec.LP := StrToInt(lstSplit.Strings[4]) / 10000;
      rec.CP := StrToInt(lstSplit.Strings[5]) / 10000;
      }


      try
        M.Write(rec, SizeOf(rec));

      finally

      end;
    end;
    closefile(rText);

    M.Position := 0;
  end;
end;

procedure TBaseDataFile.saveAs(FileName: string);
begin
  if M <> nil then M.SaveToFile(FileName);
end;

function TBaseDataFile.seek(Index: Integer): Pointer;
begin //查找第几条记录所在的内存开始地址
  if M = nil then Result := nil else Result := Pointer(Integer(getHeader) + getHeaderSize + Index * getRecSize);
end;

{ TDataFile }

constructor TDataFile.Create(const StockPath: string);
begin

  FStockName := Trim(ExtractFileName(StockPath));
  FStockPath := StockPath;
  inherited Create;
end;

procedure TDataFile.Reload(const StockName: string);
begin
  FStockName := Trim(StockName);
  inherited Reload;
end;

function TDataFile.getFileName: string;
begin
  //OpenDialog1.Execute;
  //Result := OpenDialog1.FileName;
  Result := '.\DATA\' + FStockName + '.DAT';
end;

function TDataFile.getFilePath: string;
begin
  //OpenDialog1.Execute;
  //Result := OpenDialog1.FileName;
  Result := FStockPath;
end;

function TDataFile.FindData(Date: WORD; L, H: Integer): Pointer;
var
  M: Integer;
  D: WORD;
begin
  Result := nil;
  if L <= H then
  begin
    M := (L + H) shr 1;
    D := PWORD(getRec(M))^;
    //ShowMessage(DateToStr(D));
    if Date = D then Result := getRec(M) //采用二分查找方法，查找指定日期的数据位置
    else if Date < D then Result := FindData(Date, L, M - 1)
    else Result := FindData(Date, M + 1, H);
  end;
end;

function TDataFile.getData(Date: Integer): Pointer;
begin
  //if Date > 20000 then
  if Date > getCount then //限制的最大的数据范围是20000，为什么呢？
    Result := FindData(Date, 0, getCount - 1) //Search by Date
  else Result := getRec(getCount - Date - 1); //Index Record from tail toward header
end;

function TDataFile.getRecSize: Integer;
begin //一条记录的大小
  Result := SizeOf(TStkDataRec);
end;

function TDataFile.RecStart: Integer;
begin
  Result := 0;
end;

function TDataFile.indexOf(Date: TDateTime): Integer; begin Result := indexOf(Date, 0, getCount - 1); end;

function TDataFile.getStockName: string; begin Result := FStockName; end;

procedure TDataFile.save; begin if M <> nil then M.SaveToFile(getFilePath); end;

function TDataFile.Seek(Index: Integer): Pointer;
begin
  if (M = nil) or (getCount = 0) then Result := nil
  else begin
    Index := (Index + RecStart) mod getCount;
    Result := Pointer(Integer(M.Memory) + getHeaderSize + Index * getRecSize);
  end;
end;

function TDataFile.indexOf(Date: TDateTime; L, H: Integer): Integer;
var
  M: Integer;
  //D: TDateTime;
  P, Q: PStkDataRec;
  t1:string;
  t2:string;
begin
  Result := -1;
  if L <= H then
  begin
    M := (L + H) shr 1;
    P := getData(M);
      t1:=FormatDateTime('yyyy-mm-dd hh:nn', Date);
      t2:=FormatDateTime('yyyy-mm-dd hh:nn', P.Date);
    if P <> nil then
    begin
      if Date = P.Date then Result := M
      else if Date > P.Date then Result := indexOf(Date, L, M - 1)
      else Result := indexOf(Date, M + 1, H);
    end;
  end;
    //D := PWORD(getRec(M))^;
    //ShowMessage(DateToStr(D));
end;

function TDataFile.getCP: TArrayOfSingle;
var
  I: Integer;
begin
  SetLength(Result, getCount);
  for I := 0 to getCount - 1 do
    Result[I] := PStkDataRec(getRec(I)).CP;
end;

function TDataFile.getVOL: TArrayOfSingle;
var
  I: Integer;
begin
  SetLength(Result, getCount);
  for I := 0 to getCount - 1 do
    Result[I] := PStkDataRec(getRec(I)).VOL;
end;

function TDataFile.getUD: TArrayOfSingle;
var
  I: Integer;
begin
  SetLength(Result, getCount);
  for I := 0 to getCount - 1 do
    if I = 0 then Result[I] := 0
    else Result[I] := PStkDataRec(getRec(I)).CP - PStkDataRec(getRec(I - 1)).CP;
end;

end.
