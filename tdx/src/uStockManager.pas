unit uStockManager;

interface
//{$DEFINE _IS_NOT_DELPHI_}     //发布对象不是Delphi的组件

uses SysUtils, Classes, Windows,
     ExtCtrls, MATH, TDXGrobal, TDXEDCode, usockTDXManager, uFunctions, Messages, SyncObjs;
Const
   DEFAULT_KLINES = 130; //默认日K线显示天数
   DEFAULT_KDAYS  = 280; //默认日K线下载基准天数
   REAL_DEAL_MAX  = 20;  //实时分笔成交最大显示数
   LARGE_DEAL     = 500;  //大单定义
   MAX_TDXMANAGER = 5;

//   WM_TDX_SM_AFTERREADDATA  = WM_USER + $120;
   


type
   TStockObject  = class;  //股票

   TOnInitStocks = procedure (Sender: Tobject; Stock: TStockObject; MaxCount, Progress: integer) of object;
   TInitStocksEvent = procedure (Sender: TObject; Market: byte) of object;

   TOnReadData   = procedure (Sender: TObject; bufCount: integer) of object;

   TOnTDXManagerConnect = procedure (Sender: TObject; TDXManager: TTDXManager; WorkIndex: integer) of object;


   TStockDayInfo = record
      Data  :TTDX_DAYInfo;   //接收到的数据
      _Data :TTDX_DAYInfo;   //除权后的数据
   end;

   TF10RcdEx = record
      RCD :TF10Rcd;
      Memory  :PChar;
      Size  :Integer;
   end;
   PTF10RcdEx = ^TF10RcdEx;

   TLastMsgs = record
      MSG_KLINE :TTDX_MSG;
   end;

   TStockManager = class;
   TStockObject  = class
   StkCode, StkName :string;
   StkPY  :string;//拼音
   Market   :byte;      //0=sz 1=sh
   initindex  :integer; //在系统初始化表中的位置
   initdata  :TTDX_STOCKINFO;
   FormatStr  :string;
   RunTick  :longword;
   PK       :TTDX_PKBASE;     //最后一次获得的盘口数据
   PKBack   :TTDX_PKBASE;     //上一次的
   MINS     :array of TTDX_MIN;
   DAYS     :array of TStockDayInfo;//TTDX_DAYInfo;   //0=今天的
   RealDealsStart :integer;
   RealDeals  :array of TTDX_DEALInfo;

   LastMsgs :TLastMsgs; //最后一次获得数据的消息


   KLineCount :integer; //显示的日K天数

   FKLineStart :integer;   //画K线开始的地方 0=今天的

   LastPKTick, LastDAYSTick, LastMinsTick,
   LastRealPKTick, LastDealTick :longword;

   Data :Pointer; //附加标志
   F10List  :TList;

   private
      FStockMan :TStockManager;
      FKLineMode  :TKLineDateMode;   //2011.09.18 获取K线的模式
      procedure  run;
      procedure  SetKLineStart (value: integer);
      procedure  ResetDaysInfo; //复权
      procedure  SetKLineMode (Value: TKLineDateMode);

   protected
      procedure  ClearF10List;
   public
      Constructor Create; overload;
      Destructor  Destroy; override;

      function  GetSingleStr (sg: single): string;
      function  GetSingleShortStr (sg: single): string;
      function  GetIntShortStr (value: longword): string;
      function  GetPriceChange: single;
      function  GetPriceChangeStr: string;
      function  GetPercentAge: single;
      function  GetTotalAge  :single;
      function  GetPercentAgeStr  :string;
      function  GetVolumeShortStr :string;
      function  GetAmountShortStr: string;

      function  GetF10Ex (Index: integer): PTF10RcdEx;
      property  F10Exs[Index: integer]  :PTF10RcdEx read GetF10Ex;
   published
      property  StockMan  :TStockManager read FStockMan write FStockMan;
      property  PriceChange :single read GetPriceChange;         //日涨跌
      property  PriceChangeStr  :string read GetPriceChangeStr;
      property  PercentChange  :single read GetPercentAge;       //涨幅
      property  TotalAge  :single read GetTotalAge;  //累计涨幅
      property  PercentChangeStr :string read GetPercentAgeStr;
      property  VolumeStr :string read GetVolumeShortStr;          //成交量字符串
      property  AmountStr :string read GetAmountShortStr;          //成交金额字符串
      property  KLineStart  :Integer read FKLineStart write SetKLineStart;
      property  KLineMode :TKLineDateMode read FKLineMode write SetKLineMode;

   end;


   {

   }
   TStockManager = class (TComponent)

   private
      //FDM :TDM1;

      FTimer  :TTimer;
      FRegKeyString :string;

      FBoAutoInitStocks :Boolean;   //是否在下载完毕初始化的市场数据后自动初始化到股票列表
      FBoMarketInited, FBoStocksInited  :array[0..MARKETS_COUNT-1] of boolean;

      FCurStock :TStockObject;//当前正在查看主界面的股票
      FStock999999, FStock399001, FStock399300  :TStockObject; //大盘
      FStocks :TStringList; //所有股票列表    Strings[n]=StkCode+StkName Objects[n]=TStockObject
      FMyStocks :TStringList; //自选股
      FMyStocksTick :longword;
      FBoMyStocksRun  :Boolean;
      FTdxManagerIndex  :Integer;
      FTdxManagerMaxCount :integer;

      FDefaultKDay, FDefaultKCount  :Integer;//默认开始的日K位置、结束位置

      FOnDecodePacket_F10 :TOnDecodepacket_F10;
      FOnDecodePacket_F10TXT  :TOnDecodePacket_F10TXT;
      FOnDecodePacket_DAYS :TOnDecodePacket_DAYS;
      FOnDecodePacket_PKDAT :TOnDecodePacket_PKDAT;
      FOnDecodePacket_REALPK  :TOnDecodePacket_REALPK;
      FOnDecodePacket_DEALS :TOnDecodePacket_DEALS;
      FOnDecodePacket_MINS  :TOnDecodePacket_MINS;
      FOnDecodePacket_INITMARKET  :TOnDecodePacket_INITMARKET;
      FOnConnect  :TNotifyEvent;
      FOnDisConnect :TNotifyEvent;
      FOnCurStockChange :TNotifyEvent;
      FOnInitStocks :TOnInitStocks;
      FBeforeInitStocks, FAfterInitStocks  :TInitStocksEvent;
      FOnReadData :TOnReadData;
      FOnAfterReadData  :TOnAfterReadDataEvent;

      {$IFDEF _IS_NOT_DELPHI_}
      procedure OnDePacket_DAYS (Msg: TTDX_MSG; data: array of TTDX_DAYInfo; start, daysCount: integer); stdcall;
      procedure OnDePacket_PKDAT (Msg: TTDX_MSG; data: array of TTDX_PKDAT; StockCount: integer); stdcall;
      procedure OnDePacket_REALPK (data: TTDX_REALPKDAT); stdcall;
      procedure OnDePacket_DEALS (Msg: TTDX_MSG; data: array of TTDX_DEALInfo; start, Count: integer); stdcall;
      procedure OnDePacket_MINS (Msg: TTDX_MSG; data: array of TTDX_MIN; start, Count: integer); stdcall;
      procedure OnDePacket_INITMARKET (data: array of TTDX_STOCKINFO; Market: byte; Count: integer); stdcall;
      procedure OnConnected (Sender: TObject); stdcall;
      procedure OnDisConnected (Sender: TObject); stdcall;
      procedure OnReadTDXStockData(Const pData: pTTdxData); stdcall;
      procedure OnAfterReadTDXData (Msg: TTDX_MSG); stdcall;

      {$ELSE}
      procedure OnDePacket_F10 (Msg: TTDX_MSG; data: array of TF10Rcd; count: integer);
      procedure OnDePacket_F10TXT (Msg: TTDX_MSG; memory: TMemoryStream);
      procedure OnDePacket_DAYS (Msg: TTDX_MSG; data: array of TTDX_DAYInfo; start, daysCount: integer);
      procedure OnDePacket_PKDAT (Msg: TTDX_MSG; data: array of TTDX_PKDAT; StockCount: integer);
      procedure OnDePacket_REALPK (data: TTDX_REALPKDAT);
      procedure OnDePacket_DEALS (Msg: TTDX_MSG; data: array of TTDX_DEALInfo; start, Count: integer);
      procedure OnDePacket_MINS (Msg: TTDX_MSG; data: array of TTDX_MIN; start, Count: integer);
      procedure OnDePacket_INITMARKET (data: array of TTDX_STOCKINFO; Market: byte; Count: integer);
      procedure OnConnected (Sender: TObject) ;
      procedure OnDisConnected (Sender: TObject); 
      procedure OnReadTDXStockData(Const pData: pTTdxData);
      procedure OnAfterReadTDXData (Msg: TTDX_MSG);
      {$ENDIF}
      procedure SetCurStock (NewStock: TStockObject);
      function  GetCurTDXManager: TTDXManager;
      procedure TimerTImer (Sender: TObject);
      procedure SetRegKeyString (value: string);
      procedure SetTdxManagerMaxCount (value: integer);

      function  AddStock (StockObj: TStockObject): integer; overload;

   protected

   public
      TDXSockMans : array[0..MAX_TDXMANAGER-1] of TTDXManager;

      procedure Run;
      procedure InitData;
      function  InitStocks (market: integer): boolean;
      //function MakeNewStockObject (Const StkCode, StkName: string): TStockObject;
      //function AddStock (Const StkCode, StkName: string): TStockObject;overload;

      function  FindStock (Const StkCode, StkName: string): TStockObject; overload;
      function  FindStock (Const StkCode  :string; Market: integer): TStockObject; overload;
      function  FindStock (Const StkCode  :string): TStockObject; overload;
      function  FindStock (Const StkCodeOrStkName  :PChar): TStockObject; overload;
      procedure ClearStocks;
      function  SearchStocks (Key: string; Stocks: TStrings): integer; virtual;//根据关键字查找股票

      function  Connect: integer; overload;
      function  Connect (Const Host: string; Const Port: integer = 7709): integer; overload;
      procedure DisConnect;
      procedure GetSpecialPK;
      procedure GetMyStocksPK;
      procedure GetALLStocksPK;

      procedure Get_PK (Const codenames: string);    //获取股票盘口
      procedure Get_TestRealPK (Const code: string; market, Time: integer);overload;
      procedure Get_K_Days (Const code: string; market:integer;  startcount: integer = 0; count: integer = DEFAULT_KDAYS);overload; //获得日K线
      procedure Get_Deals (Const code: string; market:integer; startcount:integer = 0; count: integer = 1000);overload; //分笔成交
      procedure Get_Mins  (Const code: string; market:integer; start: integer);overload; //分时图

      procedure Get_TestRealPK (Const code: string; Time: integer);overload;
      procedure Get_K_Days (Const code: string; startcount: integer = 0; count: integer = DEFAULT_KDAYS);overload;
      procedure Get_Deals (Const code: string; startcount: integer = 0; count: integer = 1000);overload;
      procedure Get_Mins  (Const code: string; start: integer);overload;

      property  CurTDXManager :TTDXManager read GetCurTDXManager;
      property  CurStock      :TStockObject read FCurStock write SetCurStock;
      property  Stocks        :TStringList read  FStocks;
      property  MyStocks      :TStringList read  FMyStocks;
      property  Stock999999   :TStockObject read FStock999999 write FStock999999;
      property  Stock399001   :TStockObject read FStock399001 write FStock399001;
      property  Stock399300   :TStockObject read FStock399300 write FStock399300;

      Constructor Create (AOwner: TComponent); override;
      Destructor  Destroy ; override;
   published
      property  RegKeyString  :string read FRegKeyString write SetRegKeyString;

      property  OnDecodePacket_F10  :TOnDecodepacket_F10 read FOnDecodePacket_F10 write FOnDecodePacket_F10;
      property  OnDecodePacket_F10TXT :TOnDecodePacket_F10TXT read FOnDecodePacket_F10TXT write FOnDecodePacket_F10TXT;
      property  OnDecodePacket_DAYS :TOnDecodePacket_DAYS read FOnDecodePacket_DAYS write FOnDecodePacket_DAYS;
      property  OnDecodePacket_PKDAT :TOnDecodePacket_PKDAT read FOnDecodePacket_PKDAT write FOnDecodePacket_PKDAT;
      property  OnDecodePacket_REALPK :TOnDecodePacket_REALPK read FOnDecodePacket_REALPK write FOnDecodePacket_REALPK;
      property  OnDecodePacket_DEALS :TOnDecodePacket_DEALS read FOnDecodePacket_DEALS write FOnDecodePacket_DEALS;
      property  OnDecodePacket_MINS :TOnDecodePacket_MINS read FOnDecodePacket_MINS write FOnDecodePacket_MINS;
      property  OnDecodePacket_INITMARKET :TOnDecodePacket_INITMARKET read FOnDecodePacket_INITMARKET write FOnDecodePacket_INITMARKET;
      property  OnConnect :TNotifyEvent read FOnConnect write FOnConnect;
      property  OnDisConnect  :TNotifyEvent read FOnDisConnect write FOnDisConnect;
      property  OnInitStocks  :TOnInitStocks read FOnInitStocks write FOnInitStocks;
      property  BeforeInitStocks  :TInitStocksEvent read FBeforeInitStocks write FBeforeInitStocks;
      property  AfterInitStocks   :TInitStocksEvent read FAfterInitStocks write FAfterInitStocks;
      property  OnReadData  :TOnReadData read FOnReadData write FOnReadData;
      property  OnAfterReadData :TOnAfterReadDataEvent read FOnAfterReadData write FOnAfterReadData;
//      property  MaxKLineCount :Integer read FMaxKLineCount write SetMaxKLineCount;

      property  BoMyStocksRun :Boolean read FBoMyStocksRun write FBoMyStocksRun;
      property  OnCurStockChange :TNotifyEvent read FOnCurStockChange write FOnCurStockChange;
      property  DefaultKDay  :Integer read FDefaultKDay write FDefaultKDay DEFAULT DEFAULT_KDAYS;
      property  DefaultKCount  :Integer read FDefaultKCount write FDefaultKCount Default DEFAULT_KLINES;
      property  BoAutoInitStocks  :Boolean read FBoAutoInitStocks write FBoAutoInitStocks DEFAULT True;
      property  MaxWorkCount  :Integer read FTdxManagerMaxCount write SetTdxManagerMaxCount DEFAULT MAX_TDXMANAGER;

   end;
var CS  :TCriticalSection;
    StockDraws: TList;
procedure Register;
implementation
uses uDrawKline;


procedure Register;
begin
  RegisterComponents('TDX', [TStockManager]);
end;



{ TStockManager }

function TStockManager.AddStock(StockObj: TStockObject): integer;
begin
   if FStocks.IndexOf(StockObj.StkCode+StockObj.StkName) = -1 then
      FStocks.AddObject(stockobj.StkCode+stockobj.StkName, stockobj);
   result := FStocks.Count;
end;

procedure TStockManager.ClearStocks;
var i: integer;
    stkobj: TStockObject;
begin
   FCurStock  := nil;
   FStock999999 := nil;
   FStock399001 := nil;
   FStock399300 := nil;
   FMyStocks.Clear;
   for i  := FStocks.Count - 1 downto 0 do begin
      stkobj  := TStockObject (FStocks.Objects[i]);
      if Assigned (stkobj) then
         stkobj.Free;
   end;
   FStocks.Clear;
end;

constructor TStockManager.Create(AOwner: TComponent);
var i: integer;
begin
  inherited Create(AOwner);
  FStocks := TStringList.Create;
  FMyStocks := TStringList.Create;

  FBoMyStocksRun  := True;

  for i := low (TDXSockMans) to High (TDXSockMans) do begin
  TDXSockMans[i]  := TTDXManager.Create(self);
  //TDXSockMans[i].RegKeyString := FRegKeyString;
  TDXSockMans[i].OnConnected  := OnConnected;
  TDXSockMans[i].OnDisConnected := OnDisConnected;
  TDXSockMans[i].OnDecodePacket_DAYS  := OnDePacket_DAYS;
  TDXSockMans[i].OnDecodePacket_PKDAT := OnDePacket_PKDAT;
  TDXSockMans[i].OnDecodePacket_REALPK  := OnDePacket_REALPK;
  TDXSockMans[i].OnDecodePacket_DEALS := OnDePacket_DEALS;
  TDXSockMans[i].Ondecodepacket_MINS  := OnDePacket_Mins;
  TDXSockMans[i].OnDecodePacket_INITMARKET  := OnDePacket_INITMARKET;
  TDXSockMans[i].OnReadData := OnReadTDXStockData;
  TDXSockMans[i].OnAfterReadData  := OnAfterReadTDXData;
  TDXSockMans[i].OnDecodePacket_F10 := OnDePacket_F10;
  TDXSockMans[i].OnDecodePacket_F10TXT  := OnDePacket_F10TXT;
  end;

  FTimer  := TTimer.Create(self);
  //FTimer.Enabled  := False;
  FTimer.Interval  := 200;
  FTimer.OnTimer  := TimerTimer;

  //FDM := TDM1.Create(self);

  FTdxManagerIndex  := Low (TDXSockMans);

  FDefaultKDay  := 0;
  FDefaultKCount  := DEFAULT_KLINES;
  FBoAutoInitStocks := True;
  FTdxManagerMaxCount := MAX_TDXMANAGER;
end;

Destructor TStockManager.Destroy;
var i: integer;
begin
   ClearStocks;

   FMyStocks.Free;
   FStocks.Free;
   for i := low (TDXSockMans) to High (TDXSockMans) do begin
      if Assigned (TDXSockMans[i]) then
         TDXSockMans[i].Free;
   end;
  inherited;

end;

function TStockManager.FindStock(const StkCode, StkName: string): TStockObject;
var n: integer;
begin
   result := nil;
   n  := FStocks.IndexOf(StkCode + StkName);
   if n <> -1 then begin
      result  := TStockObject (FStocks.Objects[n]);
   end;
end;

procedure TStockManager.GetMyStocksPK;
var i: integer; stkobj: TStockObject;
    str: string;
begin
   str  := '';
   for i  := FMyStocks.Count - 1 downto 0 do begin
      stkobj  := TStockObject (FMyStocks.Objects[i]);
      if stkobj = nil then continue;
      try
         if str <> '' then str  := str + ',';
         str  := str + stkobj.StkCode;
         Case stkobj.Market of
            0: str  := str + 'SZ';
            1: str  := str + 'SH';
         end;
      except
         FMyStocks.Delete(i);
      end;
   end;

   if str <> '' then
      CurTDXManager.Get_PK(str);
end;

procedure TStockManager.GetSpecialPK;
begin
   //获取大盘指数
   CurTDXManager.Get_PK('999999SH,399001SZ,399300SZ');
end;

function TStockManager.InitStocks (market: integer): boolean;
var stream: TMemoryStream;
    i: integer;
    saveDate  :TDateTime;
    n :integer;
    D :TTDX_STOCKINFO;
    stkobj: TStockObject;
    HZPY, flname, stkname, stkcode  :string;
    //qry :TADOQuery;
begin
   result := False;
   stream := TMemoryStream.Create; try
   //for market := low (FStocksInitData) to High (FStocksInitData) do begin

      flname  := Format ('%d.mdat',[market]);
      if not FileExists (flname) then exit;
      stream.LoadFromFile(flname);
      stream.Read(saveDate, SizeOf (TDateTime));
      stream.Read(n, 4);

      if Assigned (FBeforeInitStocks) then
         FBeforeInitStocks (self, market);
      {qry := FDM.qry1;
      qry.SQL.Text  := Format ('delete * from %s where IDX BETWEEN %d AND %d', [ALLSTOCKS, 10000*Market, 10000 * (Market + 1)] );
      qry.ExecSQL;
      qry.SQL.Text  := 'select * from ' + ALLSTOCKS;
      qry.Open; }
      SetLength ( FStocksInitData[market], n);

      for i := 0 to n - 1 do begin

         stream.Read(D, SizeOf (TTDX_STOCKINFO));
         FStocksInitData[market][i]  := D;

         stkcode  := D.code;
         stkname  := D.Name;
         //为加快处理速度
         //stkobj := FindStock (stkcode, stkname);

         //if stkobj = nil then
            stkobj := TStockObject.Create;
         stkobj.FStockMan  := self;
         stkobj.StkCode  := D.code;
         stkobj.StkName  := D.Name;

         HZPY  :=  GetHzPy (stkobj.StkName);
         stkobj.StkPY    := HZPY;
         HZPY  := '';
         stkobj.Market   := Market;
         stkobj.initindex  := i;
         stkobj.initdata := D;
         stkobj.FormatStr := '%.0' + IntToStr (stkobj.InitData.PriceMag) + 'f';
         SetLength (stkobj.DAYS, 0);

         FStocks.AddObject(stkobj.StkCode + stkobj.StkName, stkobj);

         {qry.AppendRecord([Market* 10000 + i, stkobj.StkCode, stkobj.StkName, stkobj.StkPY,
            stkobj.initdata.PriceMag,
            Format('%%.0%df',[stkobj.initdata.PriceMag]),
            stkobj.initdata.YClose
            ]);}

         if Assigned (FOnInitStocks) then
            FOnInitStocks (self, stkobj, n, i + 1);
      end;

      FBoStocksInited[Market] := True;

      if Assigned (FAfterInitStocks) then
         FAfterInitStocks (self, market);

      result  := True;
      stream.Clear; 


   finally stream.Free end;
end;

procedure TStockManager.OnCOnnected;
begin
   if Assigned (FOnConnect) then
      FOnConnect (self);
end;

procedure TStockManager.OnDePacket_DAYS(Msg: TTDX_MSG; data: array of TTDX_DAYInfo; start, daysCount: integer);
var stkobj: TStockObject;
    i, n :integer;
    stkcode, stkname,smarket: string;
    dbl :Double;
begin
   stkcode  := Msg.Code;
   stkname  := Msg.Name;
   stkobj := FindStock(stkcode, stkname);

   if stkobj <> nil then begin
      SetLength (stkobj.DAYS, start + daysCount);
      n := 0;
      for i := daysCount - 1 downto 0 do begin
         stkobj.DAYS[start + n].Data := data[i];
         stkobj.DAYS[start + n]._Data := data[i];
         Inc (n);
      end;

      stkobj.ReSetDaysInfo;

      stkobj.LastDAYSTick := GetTickCount;
      stkobj.LastMsgs.MSG_KLINE := Msg;
   end;
   if Assigned (FOnDecodePacket_DAYS) then
      FOnDecodePacket_DAYS (Msg, data, start, daysCount);
end;

procedure TStockManager.OnDePacket_INITMARKET(
  data: array of TTDX_STOCKINFO; Market: byte; Count: integer);
  var i: integer;
      stkobj: TStockObject;
      HZPY  :string;
      stream: TMemoryStream;
      lastDate  :TDateTime;
begin

   //保存到文件
   stream := TMemoryStream.Create; try
   stream.SetSize(count * SizeOf (TTDX_STOCKINFO) + SizeOf (TDateTime) + 4);
   stream.Position  := 0;
   lastDate := NOW;
   stream.Write(lastDate, SizeOf (TDateTime)); //写入最后更新时间
   stream.Write(count, 4);
   stream.Write(data, count * SizeOf (TTDX_STOCKINFO));  //数据
   
   stream.SaveToFile(Format('%d.mdat',[Market]));
   stream.Clear;
   finally stream.Free end;

   FBoMarketInited [Market] := True;
   if FBoAutoInitStocks then
      InitStocks (Market);

   if Assigned ( FOnDecodePacket_INITMARKET ) then
      FOnDecodePacket_INITMARKET (data, market, count);
end;

procedure TStockManager.OnDePacket_PKDAT(MSG: TTDX_MSG; data: array of TTDX_PKDAT; StockCount: integer);
  var i: integer;
      stkobj: TStockObject;
      stkcode, stkname: string;
begin
   for i  := 0 to StockCount - 1 do begin
      stkcode := data[i].D.code;
      stkname := GetStockName (stkcode, data[i].D.MarketMode);

      stkobj  := FindStock (stkcode, stkname);
      {if stkobj = nil then begin
         stkobj  := TStockObject.Create;
         stkobj.
         AddStock (stkobj);
      end; }


      if (stkobj.StkCode = '999999') then
         FStock999999 := stkobj;
      if (stkobj.StkCode = '399001') then
         FStock399001 := stkobj;
      if (stkobj.StkCode = '399300') then
         FStock399300 := stkobj;

      if stkobj <> nil then begin
         stkobj.PK  := data[i].D;
         if stkobj.PK.DealCount > 1 then begin
         if Length (stkobj.DAYS) < 1 then
            SetLength (stkobj.DAYS, 1);
         stkobj.DAYS[0].DATA.Open  := stkobj.PK.Open;
         stkobj.DAYS[0].DATA.High  := stkobj.PK.High;
         stkobj.DAYS[0].DATA.Low   := stkobj.PK.Low;
         stkobj.DAYS[0].DATA.Close := stkobj.PK.Close;
         //stkobj.DAYS[0].Volume  := stkobj.PK.Volume;
         if (stkobj = FStock999999)
         or (stkobj = FStock399001)
         or (stkobj = FStock399300)
         or (pos ('指数', stkobj.StkName) > 0)
         then begin
            stkobj.DAYS[0].DATA.Volume  := stkobj.PK.Volume;
            //涨跌家数
            stkobj.DAYS[0].Data.UpCount := stkobj.PK.Buyv[low (stkobj.PK.Buyv)];
            stkobj.DAYS[0].Data.DownCount := stkobj.PK.Sellv[low (stkobj.PK.Sellv)];
         end else
            stkobj.DAYS[0].DATA.Volume  := stkobj.PK.Volume * stkobj.initdata.rate;  //实时盘口中是手数，日K线中是股数

         stkobj.DAYS[0]._Data := stkobj.DAYS[0].Data;
         end;


         stkobj.LastPKTick  := GetTickCount;
      end;
   end;

   if Assigned (FOnDecodePacket_PKDAT ) then
      FOnDecodePacket_PKDAT (MSG, data, StockCOunt);
end;

procedure TStockManager.OnDePacket_DEALS(Msg: TTDX_MSG; data: array of TTDX_DEALInfo; start, Count: integer);
var stkobj: TStockObject;
    i, n :integer;
    stkcode, stkname,smarket: string;
begin
   stkcode  := MSG.Code;
   stkname  := MSG.Name;
   stkobj := FindStock(stkcode, stkname);

   if stkobj <> nil then begin
      stkobj.LastDealTick := GetTickCount;
   end;

   if Assigned ( FOnDecodePacket_DEALS ) then
      FOnDecodePacket_DEALS ( MSG, data, start, Count);
end;

procedure TStockManager.OnDisConnected;
begin
   if Assigned (FOnDisConnect) then
      FOnDisConnect (self);
end;

procedure TStockManager.OnReadTDXStockData(const pData: pTTdxData);
begin
   if Assigned (FOnReadData) then
      FOnReadData (self, pData.Len);
end;

procedure TStockManager.Run;
var i, market: integer;
    stkobj: TStockObject;
    errno : integer;
begin
 try
   errno  := 0;
   if (FStock999999 <> nil) and (FStock399001 <> nil) and (FStock399300 <> nil) and (GetTickCount - FStock999999.RunTick >= 3230) then begin
      FStock999999.RunTick  := GetTickCount;
      GetSpecialPK;
   end;

   errno  := 1;
   for i  := 0 to FStocks.Count -1 do begin
      stkobj  := TStockObject (FStocks.Objects[i]);
      if Assigned (stkobj) then
         stkobj.run;
   end;

   errno  := 2;
   if FBoMyStocksRun and (GetTickCount - FMyStocksTick >= 1345) then begin
      FMyStocksTick  := GetTickCount;
      GetMyStocksPK;
   end;

   errno  := 3;
   for i := low (TDXSockMans) to High (TDXSockMans) do
      TDXSockMans[i].Run;
 except on E:Exception do MessageBox (0, PChar(IntToStr (Errno) + ' ->' + E.Message), 'TStockManager.Run', 0) end;
end;

procedure TStockManager.SetCurStock(NewStock: TStockObject);
var old: TStockObject;
    i, start: integer;
begin
   if FCurStock <> NewStock then begin
      old := FCurStock;
      FCurStock := NewStock;
      if FCurStock <> nil then begin
          if FDefaultKDay = 0 then begin
             if Length (FCurStock.DAYS) >= FDefaultKCount then
                FDefaultKDay  := FCurStock.DAYS[FDefaultKCount-1].Data.Day;
          end;

          FCurStock.KLineCount := FDefaultKCount;
          start := DEFAULT_KLINES - 1;
          for i := High (FCurStock.DAYS) downto Low (FCurStock.DAYS) do begin
             if FCurStock.DAYS[i].Data.DAY >= FDefaultKDay then begin
                start := i;
                break;
             end;
          end;
          FCurStock.KLineStart  :=   start;
      end;
      if Assigned (FOnCurStockChange) then
         FOnCurStockChange (old);
   end;
end;

procedure TStockManager.OnDePacket_MINS(Msg: TTDX_MSG;
  data: array of TTDX_MIN; start, Count: integer);
var stkobj: TStockObject;
    i, n :integer;
    stkcode, stkname,smarket: string;
begin
   stkcode  := MSG.Code;
   stkname  := MSG.Name;
   stkobj := FindStock(stkcode, stkname);

   if stkobj <> nil then begin
      stkobj.LastMinsTick := GetTickCount;
      if start = 0 then begin
         SetLength (stkobj.MINS, Count);
         for i  := 0 to Count - 1 do
            stkobj.MINS[i]  := data[i];
      end;

   end;
   if Assigned (FOnDecodePacket_MINS) then
      FOnDecodePacket_MINS (MSG, data, start, count);
end;

procedure TStockManager.OnAfterReadTDXData (MSG: TTDX_MSG);
var stkCode: string;
    rCode: integer;
    i :integer;
    sd  :TStockDrawBaseObject;
begin
   if Assigned (FOnAfterReadData) then
      FOnAfterReadData(MSG);
   stkcode  := msg.Code;
   CS.Enter; try
   for i:= 0 to StockDraws.Count - 1 do begin
      sd  := TStockDrawBaseObject (StockDraws.Items[i]);
      sd.AfterReadData(Msg);
   end;
   finally CS.Leave end;
end;

function TStockManager.GetCurTDXManager: TTDXManager;
var i: integer;
begin
   for i  := 2 to MAX_TDXMANAGER do begin
       result := TDXSockMans[FTDXManagerIndex];
       Inc (FTDXManagerIndex);
       if FTDXManagerIndex >= FTdxManagerMaxCount - Low (TDXSockMans) then
          FTDXManagerIndex  := low (TDXSockMans);
       if FTDXManagerIndex > High (TDXSockMans) then
          FTDXManagerIndex  := low (TDXSockMans);
       if result.IdTCPClient.Connected then
          break;
   end;
end;

function TStockManager.Connect: integer;
var i, n: integer;
begin
   result := 0;
   n  := 0;
   for i := low (TDXSockMans) to High (TDXSockMans) do begin
      Inc (n) ;
      if n > FTdxManagerMaxCount then break;
      if TDXSockMans[i].Connect then
         Inc (Result);
   end;
end;

procedure TStockManager.DisConnect;
var i: integer;
begin
   for i := low (TDXSockMans) to High (TDXSockMans) do begin
      if TDXSockMans[i].IdTCPClient.Connected then
         TDXSockMans[i].DisConnect;
   end;
end;

procedure TStockManager.GetALLStocksPK;
var i, n: integer; str: string;
    stkobj: TStockObject;
begin
   n  := 0;
   str  := '';
   for i  := 0 to FStocks.Count - 1 do begin
      stkobj  := TStockObject (FStocks.Objects[i]);
      if stkobj = nil then continue;
      if (stkobj.initdata.W1> 0) and (stkobj.initdata.W1 < 10000) then begin
         Inc (n);
         if str <> '' then
            str := str + ',';
         str  := str + stkobj.StkCode + FMarketCodes[stkobj.Market];

         if n = 100 then begin

            CurTDXManager.Get_PK( str );
            str := '';
            n := 0;
         end;
      end;
   end;
   if str <> '' then
      CurTDXManager.Get_PK( str );
end;

procedure TStockManager.TimerTImer(Sender: TObject);
begin
   Run;
end;

function TStockManager.Connect(const Host: string;
  const Port: integer): integer;
var i, n: integer;
begin
   result := 0;
   n  := 0;
   for i := low (TDXSockMans) to High (TDXSockMans) do begin
      Inc (n);
      if n > FTdxManagerMaxCount then break;
      TDXSockMans[i].Host := Host;
      TDXSockMans[i].Port := Port;
      if TDXSockMans[i].Connect then
         Inc (Result);
   end;
end;

procedure TStockManager.SetRegKeyString(value: string);
var i: integer;
begin
   FRegKeyString  := value;
   for i := low (TDXSockMans) to High (TDXSockMans) do begin
      TDXSockMans[i].RegKeyString := FRegKeyString;

   end;
end;

procedure TStockManager.InitData;
var i: integer;
begin
   ClearStocks;
   for i  := 0 to MARKETS_COUNT - 1 do begin
      FBoMarketInited[i]  := False;
      FBoStocksInited[i]  := False;
   end;

   for i  := 0 to MARKETS_COUNT - 1 do begin
      CurTDXManager.Get_InitData(i);
   end;
end;

function TStockManager.FindStock(const StkCode: string): TStockObject;
var i: integer;
    obj :TStockObject;
begin
   result := nil;
   for i  := 0 to FStocks.Count - 1 do begin
      obj :=  TStockObject (FStocks.Objects[i]);
      if obj = nil then continue;
      if obj.StkCode = StkCode then begin
         result  := obj;
         break;
      end;
   end;
end;

function TStockManager.FindStock(const StkCode: string;
  Market: integer): TStockObject;
var i: integer;
    obj :TStockObject;
begin
   result := nil;
   for i  := 0 to FStocks.Count - 1 do begin
      obj :=  TStockObject (FStocks.Objects[i]);
      if obj = nil then continue;
      if (obj.StkCode = StkCode) and (obj.Market = Market) then begin
         result  := obj;
         break;
      end;
   end;
end;

function TStockManager.FindStock(const StkCodeOrStkName: PChar): TStockObject;
var i: integer;
    obj :TStockObject;
begin
   result := nil;
   for i  := 0 to FStocks.Count - 1 do begin
      obj :=  TStockObject (FStocks.Objects[i]);
      if obj = nil then continue;
      if (obj.StkName = StkCodeOrStkName) or (obj.StkCode = StkCodeOrStkName) then begin
         result  := obj;
         break;
      end;
   end;
end;

procedure TStockManager.Get_Deals(const code: string; market, startcount,
  count: integer);
begin
   CurTDXManager.Get_Deals(code, market, startcount, count);
end;

procedure TStockManager.Get_K_Days(const code: string; market, startcount,
  count: integer);
begin
   CurTDXManager.Get_K_Days(code, market, startcount, count);
end;

procedure TStockManager.Get_Mins(const code: string; market,
  start: integer);
begin
   CurTDXManager.Get_Mins(code, market, start);
end;

procedure TStockManager.Get_PK(const codenames: string);
begin
   CurTDXManager.Get_PK(codenames);
end;

procedure TStockManager.Get_TestRealPK(const code: string; market,
  Time: integer);
begin
   CurTDXManager.Get_TestRealPK(code, market, time);
end;

procedure TStockManager.Get_Deals(const code: string; startcount,
  count: integer);
var obj: TStockObject;
begin
   obj  := FindStock (code);
   if obj <> nil then
      Get_Deals (code, obj.Market, startcount, count);
end;

procedure TStockManager.Get_K_Days(const code: string; startcount,
  count: integer);
var obj: TStockObject;
begin
   obj  := FindStock (code);
   if obj <> nil then
      Get_K_Days (code, obj.Market, startcount, count);
end;

procedure TStockManager.Get_Mins(const code: string; start: integer);
var obj: TStockObject;
begin
   obj  := FindStock (code);
   if obj <> nil then
      Get_Mins (code, obj.Market, start);
end;

procedure TStockManager.Get_TestRealPK(const code: string; Time: integer);
var obj: TStockObject;
begin
   obj  := FindStock (code);
   if obj <> nil then
      Get_TestRealPK (code, obj.Market, Time);
end;

procedure TStockManager.SetTdxManagerMaxCount(value: integer);
begin
   if FTdxManagerMaxCount <> value then begin
      //最小也得3个线程
      FTdxManagerMaxCount := MAX (3, MIN (FTdxManagerMaxCount, MAX_TDXMANAGER));
      
   end;
end;

function TStockManager.SearchStocks(Key: string;
  Stocks: TStrings): integer;
var i: integer;
      stkobj: TStockObject;
begin
   result := 0;
   Stocks.Clear;
   if Length (Key) < 2 then exit;
   
   for i  := 0 to FMyStocks.Count -1 do begin
      stkobj  := TStockObject (FMyStocks.Objects[i]);
      if (Pos (Key, stkobj.StkCode+stkobj.StkName+stkobj.StkPY) > 0)  then begin
         Stocks.AddObject(FMyStocks[i], FMyStocks.Objects[i]);
      end;
   end;
   result := Stocks.Count;
end;

procedure TStockManager.OnDePacket_F10(Msg: TTDX_MSG; data: array of TF10Rcd;
  count: integer);
  var stkobj: TStockObject;
      rcd :PTF10RcdEx;
      i: integer;
begin
   stkobj := FindStock (Msg.Code, Msg.Market);
   if stkObj <> nil then begin
      stkobj.ClearF10List;
      for i := low (data) to High (data) do begin
         new (rcd);
         rcd.RCD  := data[i];
         rcd.Memory := nil;
         rcd.Size := 0;
         stkobj.F10List.Add(rcd);
      end;
   end;
   
   if Assigned (FOnDecodePacket_F10) then
      FOnDecodePacket_F10 ( Msg, data, count);


end;

procedure TStockManager.OnDePacket_F10TXT(MSG: TTDX_MSG; memory: TMemoryStream);
var stkobj: TStockObject;
      rcd :PTF10RcdEx;
      index: integer;
begin
   stkobj := FindStock (Msg.Code, Msg.Market);
   if (stkObj <> nil) then begin
      index := MSG.P1;
      if (Index >= 0) and (index < stkobj.F10List.Count) then begin
         rcd  := PTF10RcdEx(stkObj.F10List.Items[Index]);
         if rcd <> nil then begin
             //先释放以前的资料
             if (rcd.Size > 0) and (rcd.Memory <> nil) then
                FreeMem (rcd.Memory, rcd.Size);
             rcd.Size := memory.Size;
             GetMem (rcd.Memory, rcd.Size);
             memory.Position  := 0;
             memory.Read(rcd.Memory^, rcd.Size);
         end;
      end;
   end;

   if Assigned (FOnDecodePacket_F10TXT) then
      FOnDecodePacket_F10TXT (Msg, memory);
end;

{ TStockObject }

procedure TStockObject.ClearF10List;
var i: integer;
    rcd :PTF10RcdEx;
begin
   for i  := F10List.Count -1 downto 0 do begin
      rcd := PTF10RcdEx (F10List.Items[i]);
      if rcd.Size <> 0 then
         FreeMem (rcd.Memory, rcd.Size);
      Dispose (rcd);
   end;
   F10List.Clear;
end;

constructor TStockObject.Create;
begin

   SetLength ( DAYS, 0 );
   SetLength ( RealDeals, 0);
   SetLength ( MINS, 0);

   F10List  := TList.Create;

   PK.DealCount := 0;
   PK.YClose    := 0;
   PK.Open      := 0;
   PK.High      := 0;
   PK.Low       := 0;
   PK.Close     := 0;
   PK.LastDealTime  := 0;
   PK.Volume    := 0;
   PK.LastVolume:= 0;

   PKBack       := PK;

   LastPKTick :=0;
   LastDAYSTick := 0;

   KLineCount  := DEFAULT_KLINES;
   KLineStart     := DEFAULT_KLINES - 1;
   FKLineMode := KD_DAY;

   Data := nil;

end;

destructor TStockObject.Destroy;
begin
   ClearF10List;
   F10List.Free;
   SetLength (MINS, 0);
   SetLength (RealDeals, 0);
   SetLength ( DAYS, 0 );
  inherited;
end;

function TStockObject.GetAmountShortStr: string;
begin
   result := GetSingleShortStr (PK.Amount);
end;

function TStockObject.GetF10Ex(Index: integer): PTF10RcdEx;
begin
   result := nil;
   if Index < 0 then exit;
   if Index < F10List.Count then begin
      result  := PTF10RcdEx (F10List.Items[Index]);
   end;
end;

function TStockObject.GetIntShortStr(value: longword): string;
begin
   if value >= 10000*10000 then
      result  := Format ('%.01f亿', [value/(10000*10000)])
   else if value >= 10*10000 then
      result  := Format ('%.01f万', [value/10000])
   else
      result  := IntToStr (value);
end;

function TStockObject.GetPercentAge: single;
begin
   result := 0;
   if PK.YClose <> 0 then
      result := PriceChange / PK.YClose * 100;
end;

function TStockObject.GetPercentAgeStr: string;
begin
   result := Format ('%.02f%%', [PercentChange]);
end;

function TStockObject.GetPriceChange: single;
begin
   result := PK.Close - PK.YClose;
end;

function TStockObject.GetPriceChangeStr: string;
begin
   result := GetSingleStr (PriceChange);
end;

function TStockObject.GetSingleShortStr(sg: single): string;
begin
   if sg >= 10000*10000 then
      result  := Format ('%.01f亿', [sg/(10000*10000)])
   else if sg >= 10*10000 then
      result  := Format ('%.01f万', [sg/10000])
   else
      result  := Format (FormatStr, [sg]);
end;

function TStockObject.GetSingleStr(sg: single): string;
begin
   result := Format (FormatStr, [sg]);
end;

function TStockObject.GetTotalAge: single;
var i, start, nend: integer;
    dbl :double;
begin
   dbl := 0;
   start  := 0;
   for i  := High (DAYS) downto low(DAYS) do begin
      if DAYS[i]._Data.DAY >= FStockMan.FDefaultKDay then begin
         start  := i;
         break;
      end;
   end;


   if length (DAYS) > 0 then begin
       //start := MAX (0, MIN (FStockMan.FDefaultKIndex, length (DAYS)) - 1);

       nend  := MAX (0, start - FStockMan.FDefaultKCount);

       if DAYS[start]._Data.Close <> 0 then
             dbl  := (DAYS[nend]._Data.Close - DAYS[start]._Data.Close) / DAYS[start]._Data.Close;

       result := dbl;
   end;
end;

function TStockObject.GetVolumeShortStr: string;
begin
   result := GetIntShortStr (PK.Volume);
end;

procedure TStockObject.ResetDaysInfo;
var dbl: double;
begin
//复权处理
      {dbl := 1;
      for i := low (stkobj.DAYS) to High (stkobj.DAYS) do begin
         dbl  := stkobj.DAYS[i].Data.
         stkobj.DAYS[i]._Data.Open  :=
      end;  }
end;

procedure TStockObject.run;
var str: string;
begin
   if (self = FStockMan.FStock999999) then begin
      if FStockMan.CurStock = nil then
         FStockman.CurStock := self;
      //如果是上证，则先获取280天的日K线
      if (GetTickCount - LastDAYSTick > 960) and (Length (DAYS) < 2) then begin
         LastDAYSTick := GetTickCount;
         FStockMan.CurTDXManager.Get_K_Days(stkCode, market, 0, DEFAULT_KDAYS);
      end;
   end; 
   
   if (self = FStockMan.FCurStock) then begin
      if (GetTickCount - LastRealPKTick > 800) then begin
         LastRealPKTick := GetTickCount;
         case Market of
            0: str  := stkCode + 'SZ';
            1: str  := stkCode + 'SH';
         end;
         FStockMan.CurTDXManager.Get_TestRealPK(stkCode, market, PK.LastDealTime);
      end;

      if (GetTickCount - LastDAYSTick > 960) and (Length (DAYS) < 2) then begin
         LastDAYSTick := GetTickCount;
         FStockMan.CurTDXManager.Get_K_Days(stkCode, market, 0, DEFAULT_KDAYS);
      end;

      if (GetTickCount - LastDealTick > 1050) and (Length (RealDeals) < 2) then begin
         LastDealTick := GetTickCount;
         FStockMan.CurTDXManager.Get_Deals(stkCode, market, 0, 20);
      end;

      
   end else begin
      //空闲的时候 获取实时盘口
      if  (PK.YClose = 0)
      and (initdata.W1 < 10000)   //普通股票
      and (GetTickCount - LastRealPKTick > 300 + Random (3000))
      and ( FStockMan.TDXSockMans[0].FMsgList.Count = 0 )
      and ( FStockMan.TDXSockMans[0].IdTCPClient.Connected ) then begin
         LastRealPKTick := GetTickCount;
         FStockMan.TDXSockMans[0].Get_TestRealPK(stkCode, market, PK.LastDealTime);
      end;

      //空闲的时候 获取日K线
      if ( Length (DAYS) < 2 )
      and (initdata.W1 < 10000)   //普通股票
      and (GetTickCount - LastDAYSTick > 3000 + Random (3000))
      and (MAX_TDXMANAGER >= 2)
      and ( FStockMan.TDXSockMans[1].FMsgList.Count = 0 )
      and ( FStockMan.TDXSockMans[1].IdTCPClient.Connected ) then begin
         LastDAYSTick := GetTickCount;
         FStockMan.TDXSockMans[1].Get_K_Days(stkCode, market, Length (DAYS), DEFAULT_KDAYS-Length (DAYS));
      end;
   end;
end;

procedure TStockManager.OnDePacket_REALPK(data: TTDX_REALPKDAT);
var   stkobj: TStockObject;
      stkcode, stkname: string;
      wH, wM  :word;
      n :integer;
begin
   stkcode := data.PK.code;
   stkname := GetStockName (stkcode, data.PK.MarketMode);

   stkobj  := FindStock (stkcode, stkname);
   if stkobj <> nil then begin
      if (stkobj.StkCode = '999999') then
         FStock999999 := stkobj;
      if (stkobj.StkCode = '399001') then
         FStock399001 := stkobj;
      if (stkobj.StkCode = '399300') then
         FStock399300 := stkobj;

      if stkobj <> nil then begin

         if stkobj.PK.DealCount < data.PK.DealCount then begin
            CurTDXManager.Get_Deals(stkobj.StkCode, stkobj.Market, 0, data.PK.DealCount-stkobj.PK.DealCount);

            n   := Length (stkobj.RealDeals);
            SetLength (stkobj.RealDeals, n + 1);
            if  n = 0 then
                stkobj.RealDealsStart := data.PK.DealCount;

            wH  := data.PK.LastDealTime div 10000;
            wM  := data.PK.LastDealTime mod 10000 div 100;
            stkobj.RealDeals[n].Min  := wH * 60 + wM;
            stkobj.RealDeals[n].value  := Round (data.PK.Close * 1000);
            stkobj.RealDeals[n].Volume := data.PK.LastVolume;
         end;


         stkobj.PK  := data.PK;
         if stkobj.PK.DealCount > 1 then begin
         if Length (stkobj.DAYS) < 1 then
            SetLength (stkobj.DAYS, 1);
         stkobj.DAYS[0].DATA.Open  := stkobj.PK.Open;
         stkobj.DAYS[0].DATA.High  := stkobj.PK.High;
         stkobj.DAYS[0].DATA.Low   := stkobj.PK.Low;
         stkobj.DAYS[0].DATA.Close := stkobj.PK.Close;
         if (stkobj = FStock999999)
         or (stkobj = FStock399001)
         or (stkobj = FStock399300)
         or (pos ('指数', stkobj.StkName) > 0)
         then begin
            stkobj.DAYS[0].DATA.Volume  := stkobj.PK.Volume ;
            //涨跌家数
            stkobj.DAYS[0].Data.UpCount := stkobj.PK.Buyv[low (stkobj.PK.Buyv)];
            stkobj.DAYS[0].Data.DownCount := stkobj.PK.Sellv[low (stkobj.PK.Sellv)];
         end else
            stkobj.DAYS[0].DATA.Volume  := stkobj.PK.Volume * stkobj.initdata.rate;  //实时盘口中是手数，日K线中是股数

         stkobj.DAYS[0]._Data := stkobj.DAYS[0].Data;
         end;

         wH  := data.PK.LastDealTime div 10000;
         wM  := data.PK.LastDealTime mod 10000 div 100;
         n   := (wH - 9) * 60 + (wM - 30);
         if  wH > 12 then
            Dec (n, 90); //下午
         if n > Length (stkobj.MINS) - 1 then begin
            SetLength (stkobj.MINS, n + 1);
            curTDXManager.Get_Mins(stkobj.StkCode, stkobj.Market, 0);
         end;
         stkobj.MINS[n].Close := data.PK.Close;

         //Inc (stkobj.MINS[n].Volume, data.PK.LastVolume);



         //stkobj.RealDeals[0].

         stkobj.LastPKTick  := GetTickCount;

      end;
   end;
   
   if Assigned (FOnDecodePacket_REALPK) then
      FOnDecodePacket_REALPK (data);

   if stkobj <> nil then
      stkobj.PKBack := stkobj.PK;
end;

procedure TStockObject.SetKLineMode(Value: TKLineDateMode);
begin
   if Value <> FKLineMode then begin
      FKLineMode  := Value;
      FStockMan.CurTDXManager.Get_K_Lines(self.StkCode, self.Market, 1, DEFAULT_KDAYS, FKLineMode);
   end;
end;

procedure TStockObject.SetKLineStart(value: integer);
var n: integer;
begin
   if value < 0 then exit;
   if value <> FKLineStart then begin
      FKLineStart := value;
      n := Length (DAYS) ;

      if (n > 0) and (FKlineStart >= Length (DAYS)) then begin
         FStockMan.CurTDXManager.Get_K_Days(stkCode, market, length (DAYS), DEFAULT_KDAYS);
      end;
   end;
end;

initialization
   CS := TCriticalSection.Create;
   StockDraws := TList.Create;

finalization
   StockDraws.Clear;
   StockDraws.Free;
   CS.Free;

end.
