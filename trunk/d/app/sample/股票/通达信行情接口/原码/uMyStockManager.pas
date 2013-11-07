unit uMyStockManager;

interface
uses SysUtils, Classes, Windows, Graphics, Controls, ExtCtrls, TDXGrobal,
     TDXEDCode, uStockManager, uSockTDXManager, DB, ADODB, Variants,
     StdCtrls, MATH, Messages, GDIPAPI, GDIPOBJ, GDIPUTIL, Forms, uDrawKLine;

type
   TKLineSearchRCD = record
      BoOpen  :Boolean;
      sg0, sg1  :single;
   end;

   PTKLineSearchInfoRCD =^ TKLIneSearchInfoRCD;
   TKLineSearchInfoRCD = record
      KHigh, KLow, KBody  :TKLineSearchRCD;  //上影线 下影线
      Change, CHangeRange, Price  :TKLineSearchRCD;
      BoOpenCloseMode :Boolean;
      CloseMode :Integer;
      DAY  :Integer;
   end;
   TKLineSearchInfo = class (TList)
      private
         FListBox :TListBox;
         procedure SetListBox (Value: TListBox);
      public

         procedure AddRCD (sinfo: TKLineSearchInfoRCD);
         procedure Clear; override;
         function  GetRCD (index: integer): pTKLineSearchInfoRCD;
         procedure _Delete (DAY: integer);
      published
         property  ListBox  :TListBox read FListBox write SetListBox;
   end;

   TStockSortMode = (STOCK_SORT_CODE,
       STOCK_SORT_NAME,
       STOCK_SORT_PERCENTCHANGE,
       STOCK_SORT_PRICE,
       STOCK_SORT_PRICECHANGE,
       STOCK_SORT_VOLUME,
       STOCK_SORT_AMOUNT,
       STOCK_SORT_CHANGE,//振荡幅度
       STOCK_SORT_YCLOSE,
       STOCK_SORT_DAYS   //周期涨幅
       );
   TMyStockDrawInfo = record
      rc  :TRect;
      stkinfo :TCallBackStockInfo;
      //D :TTDX_PKBASE;
   end;

   TMyStocksManager = class(TStockDrawBaseObject)

   private
      FMyStocks :TStringList;  //stkcode+stkname stockobject
      FItemIndex  :Integer;

      FBoAutoDown :boolean;
      FSelectIndex  :integer;// 鼠标选中的行
      FBoTransparent  :Boolean;//透明

      FDrawPKCount  :longword;


      FTSize, FISize  :integer;//文本和数字的尺寸
      FTHeight, FIHeigh :integer;
      FSpaceLeft  :integer;
      FFontName :string;
      FWidthTable :array [0..16] of integer;

      FLastCodeNames  :string;    //最后一次发出获取行情的代码

      FSortMode :TStockSortMode;
      FBoSortDESC :Boolean;

      //FQry        :TADOQuery;

      FOldWinProc  :TWndMethod;
      FStock: TStockObject;

      procedure  SetAutoDown (value: Boolean);
      procedure  SetItemIndex (value: integer);
      procedure  SetSortMode (value: TStockSortMode);

      procedure  Save; virtual;
      procedure   SetStock (Value: TStockObject);

   protected
      procedure   DoKeyDown (var Message: TWMKeyDown);override;
      procedure   DoLButtonDblClk (var Message: TWMLButtonDblClk);override;
      procedure   DoLButtonDown (var Message: TWMLButtonDown);override;
      procedure   DoMouseWheel(Sender: TObject; Shift: TShiftState;
    WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);override;
   public
      RunTick  :longword;

      TitleRects :array [0..16] of TRect;
      FNameTable :array [0..16] of string;
      StockDraws   :array of TMyStockDrawInfo;

      //IGDIMatrix, IGDIColorMatrix: TGPColorMatrix;

      Constructor Create (AOwner: TComponent); override;
      Destructor  Destroy; override;

      procedure  Run;override;
      procedure  DrawBmp (Rect: TRect);override;
      procedure  Load; virtual;
      function   GetDrawingStock (Index: integer): TStockObject;
      function   GetSelectStock : TStockObject;
      function   GetNextStock(Stock: TStockObject): TStockObject;
      function   GetPriorStock(Stock: TStockObject): TStockObject;
      function   SearchStocks (Key: string; Stocks: TStrings): integer; virtual;//根据关键字查找股票
      procedure  Delete (StkCode, StkName: string); virtual;
      procedure  GetAllPK; virtual;
      procedure  GetDrawingPK; virtual;
      procedure  ProcessMessage (var Message: TMessage; var Result: integer); override;
      procedure   AfterReadData(lastMsg: TTDX_MSG);override;
      function   GetSortModeByString (Const sortkey: string): TStockSortMode;
      procedure  Sort (sortmodevalue :TStockSortMode; boDESC :Boolean = False);
   published
      property    Handle;
      property    Colors;
      property    StockManager;
      property    Stock: TStockObject read FStock write SetStock;
      //property   PaintBox: TPaintBox read FPaintBox write SetPaintBox;
//      property   Control :TControl read FControl write SetControl;
      property   MyStocks :TStringList read FMyStocks;
      property   BoAutoDown :Boolean read FBoAutoDown write SetAutoDown;
      property   SelectIndex  :Integer read FSelectIndex write FSelectIndex;
//      property   Qry    :TADOQuery read FQry write FQry;
      property   ItemIndex  :Integer read FItemIndex write SetItemIndex;
      property   SortMode :TStockSortMode read FSortMode write SetSortMode;
      property   BoSortDESC :Boolean read FBoSortDesc write FBoSortDESC;


      property   BoTransparent  :Boolean read FBoTransparent write FBoTransparent;

   end;


   TMySelectStocksManager = class (TMyStocksManager)
   public
      Destructor Destroy; override;
      procedure  Load; override;
      procedure  Save; override;
      function   Add (StkCode, StkName: string): boolean; virtual;
      procedure  Delete (StkCode, StkName: string); override;
      procedure  DeleteSelected; virtual;
   end;

   TAllStocksManager = class (TMyStocksManager)
   public
      procedure Load; override;
   end;

   TSHStocksManager = class (TMyStocksManager)
   public
      procedure Load; override;
   end;

   TSZStocksManager = class (TMyStocksManager)
   public
      procedure Load; override;
   end;

   TFilterStocksManager = class (TMyStocksManager)
   public
      //指定交易日为光头光脚阳线  K_Index = 0 表示今天
      function CheckDAY (D1, D2: TTDX_DAYInfo; Y1, Y2: single; DBL: double): boolean;
      function Search_0 (stockman: TMyStocksManager; S: TKLineSearchInfo): integer;
      function Search_1 (stockman: TMyStocksManager; startindex, endindex: integer; range1, range2: double): integer;
      function Search_2 (stockman: TMyStocksManager; SDAYS :array of TTDX_DAYInfo; percent: integer{相似度-百分之}): integer;
   end;

procedure Register;
implementation
procedure Register;
begin
  RegisterComponents('TDX', [TMySelectStocksManager, TAllStocksManager]);
end;

{ TMyStocksManager }

constructor TMyStocksManager.Create(AOwner: TComponent);
begin
  inherited  Create (AOwner);
  //FControl := nil;

  FMyStocks := TStringList.Create;
  FBoAutoDown := True;
  FSelectIndex  := -1;
  FItemIndex  := 0;
  FTSize    := 14;
  FISize    := 12;
  FFontName := 'System';
  FSpaceLeft  := 20;


  FWidthTable[0]  := 20;
  FWidthTable[1]  := 50;
  FWIdthTable[2]  := 60;
  FWidthTable[3]  := 50;
  FWidthTable[4]  := 50;
  FWidthTable[5]  := 50;
  FWidthTable[6]  := 50;
  FWidthTable[7]  := 50;
  FWidthTable[8]  := 50;
  FWidthTable[9]  := 50;
  FWidthTable[10]  := 50;
  FWidthTable[11]  := 50;
  FWidthTable[12]  := 50;
  FWidthTable[13]  := 50;
  FWidthTable[14]  := 50;
  FWidthTable[15]  := 50;
  FWidthTable[16]   := 50;

  FNameTable[0]   := '';
  FNameTable[1]   := '代码';
  FNameTable[2]   := '名称';
  FNameTable[3]   := '涨幅%';
  FNameTable[4]   := '现价';
  FNameTable[5]   := '日涨跌';
  FNameTable[6]   := '买入价';
  FNameTable[7]   := '卖出价';
  FNameTable[8]   := '总量';
  FNameTable[9]   := '现量';
  FNameTable[10]   := '今开';
  FNameTable[11]   := '昨收';
  FNameTable[12]   := '最高';
  FNameTable[13]   := '最低';
  FNameTable[14]   := '成交金额';
  FNameTable[15]   := '振幅';
  FNameTable[16]  := '累计涨幅';

  SetLength (StockDraws, 0);

  GDIMatrix := ColorMatrix;
   GDIColorMatrix  := ColorMatrix;
   FBoTransparent := False;

end;

procedure TMyStocksManager.Delete(StkCode, StkName: string);
begin
end;

destructor TMyStocksManager.Destroy;
begin
   SetLength (StockDraws, 0);
   FMyStocks.Free;
   
  inherited;
end;

procedure TMyStocksManager.GetAllPK;
var i, n: integer;
    str :string;
    stkobj: TStockObject;
begin
   str  := '';
   n  := 0;
   for i  := 0 to FMyStocks.Count - 1 do begin
      stkobj  := TStockObject ( FMyStocks.Objects[i] );
      if stkobj = nil then continue;
      inc (n);
      if str <> '' then str := str + ',';
      str := str + stkobj.StkCode + FMarketCodes[stkobj.market];
      if n = 50 then begin
         FStockManager.CurTDXManager.Get_PK(str);
         str  := '';
      end;
   end;

   if str <> '' then
      FStockManager.CurTDXManager.Get_PK(str);
end;

procedure TMyStocksManager.GetDrawingPK;
var i, n: integer;
    str :string;
    stkobj: TStockObject;
begin
   //每隔3秒自动获取盘口
   if GetTickCount < FDrawPKCount + 1346 then exit;
   FDrawPKCount  := GetTickCount;

   str  := '';
   n  := 0;
   for i  := low (StockDraws) to High(StockDraws) do begin

      stkobj  := FStockManager.FindStock(StockDraws[i].stkinfo.Code, StockDraws[i].stkinfo.Name);
      if stkobj = nil then continue;
      inc (n);
      if str <> '' then str := str + ',';
      str := str + stkobj.StkCode + FMarketCodes[stkobj.market];
      if n = 50 then begin
         FStockManager.CurTDXManager.Get_PK(str);
         str  := '';
      end;
   end;

   if str <> '' then
      FStockManager.CurTDXManager.Get_PK(str);
   FLastCodeNames := str;

end;

function TMyStocksManager.GetSelectStock: TStockObject;
begin
   result := GetDrawingStock (FItemIndex);
end;

function TMyStocksManager.GetSortModeByString(
  const sortkey: string): TStockSortMode;
begin   //TStockSortMode = (STOCK_SORT_CODE, STOCK_SORT_NAME, STOCK_SORT_PERCENTCHANGE, STOCK_SORT_PRICECHANGE, STOCK_SORT_PRICE);
   result := STOCK_SORT_CODE;
   if Pos ( '代码', sortkey ) = 1 then result := STOCK_SORT_CODE
   else if Pos ('名称', sortkey ) = 1 then result  := STOCK_SORT_NAME
   else if Pos ('涨幅', sortkey ) = 1 then result  := STOCK_SORT_PERCENTCHANGE
   else if Pos ('日涨跌', sortkey ) = 1 then result  := STOCK_SORT_PRICECHANGE
   else if Pos ('现价', sortkey ) = 1 then result  := STOCK_SORT_PRICE
   else if Pos ('总量', sortkey ) = 1 then result  := STOCK_SORT_VOLUME
   else if Pos ('昨收', sortkey ) = 1 then result  := STOCK_SORT_YCLOSE
   else if Pos ('成交金额', sortkey ) = 1 then result  := STOCK_SORT_AMOUNT
   else if Pos ('振幅', sortkey ) = 1 then result  := STOCK_SORT_CHANGE
   else if Pos ('累计涨幅', sortkey ) = 1 then result := STOCK_SORT_DAYS;
end;

function TMyStocksManager.GetDrawingStock(Index: integer): TStockObject;
begin
   result := nil;
   if Length (StockDraws) < 1 then exit;
   if (Index >= Low (StockDraws)) and (Index <= High(StockDraws)) then begin
      result  := FStockManager.FindStock ( StockDraws[index].stkinfo.Code, StockDraws[Index].stkinfo.Name );
   end;
end;

procedure TMyStocksManager.Load;
begin

end;


procedure TMyStocksManager.Run;
var str, stkcode, stkname, codenames: string;
    i, market :integer;
    stkobj: TStockObject;
    errno :integer;
begin
 try
   errno  := 0;
   if  GetTickCount - RunTick > 1346 then begin
      RunTick := GetTickCount;
      if FBoAutoDown then begin
         codenames  := '';
         errno  := 1;
         for i  := Low (StockDraws) to High (StockDraws) do begin
            stkcode := StockDraws[i].stkinfo.Code;
            stkname  := StockDraws[i].stkinfo.Name;
            market  := StockDraws[i].stkinfo.Market;
            if market = 255 then continue;
            if codenames <> '' then codenames := codenames + ',';
            codenames := codenames + stkcode;
            case market of
               0: codenames := codenames + 'SZ';
               1: codenames := codenames + 'SH';
            end;
         end;
         errno  := 2;
         if codenames <> '' then
            FStockManager.CurTDXManager.Get_PK(codenames);
         FLastCodeNames := CodeNames;
      end;
   end;
 except on E:Exception do MessageBox (0, PChar(IntToStr (Errno) + ' ->' + E.Message), 'TMyStocksManager.Run', 0) end;
end;

procedure TMyStocksManager.Save;
begin

end;

procedure TMyStocksManager.SetAutoDown(value: Boolean);
begin
   if value <> FBoAutoDown then begin
      FBoAutoDown := value;
      RunTick := 0;
   end;
end;

procedure TMyStocksManager.SetItemIndex(value: integer);
var n: integer;
    Rect: TRect;
begin
   if value <> FItemIndex then begin
      if (value >= FMyStocks.Count) then
         value  := 0;
      if value < 0 then begin
         n  := Length (StockDraws);
         value := MAX (0, FMyStocks.Count - n);
      end;
      FItemIndex  := value;
      if FHandle <> 0 then begin
         GetClientRect (FHandle, Rect);
         InvalidateRect (FHandle, @Rect, FERASEBKGND);
      end;
   end;
end;


procedure TMyStocksManager.SetSortMode(value: TStockSortMode);
begin
   if value <> FSortMode then begin
      FSortMode := value;
      //Sort (FSortMode, FBoSortDESC);
      //FItemIndex  := 0;
      //FPaintBox.Repaint;
   end;
end;

function sort_STOCK_SORT_CODE(List: TStringList; Index1, Index2: Integer): Integer;
var code1, code2: string;
begin
   code1  := Copy (List.Strings[Index1], 1, 6)+Copy (List.Strings[Index1], 7, 8);
   code2  := Copy (List.Strings[Index2], 1, 6)+Copy (List.Strings[Index2], 7, 8);
   result := CompareStr(code1, code2);
end;

function sort_STOCK_SORT_CODE_DESC(List: TStringList; Index1, Index2: Integer): Integer;
var code1, code2: string;
begin
   code1  := Copy (List.Strings[Index1], 1, 6)+Copy (List.Strings[Index1], 7, 8);
   code2  := Copy (List.Strings[Index2], 1, 6)+Copy (List.Strings[Index2], 7, 8);
   result := CompareStr(code2, code1);
end;

function sort_STOCK_SORT_NAME(List: TStringList; Index1, Index2: Integer): Integer;
var name1, name2: string;
begin
   name1  := Copy (List.Strings[Index1], 7, 8)+Copy (List.Strings[Index1], 1, 6);
   name2  := Copy (List.Strings[Index2], 7, 8)+Copy (List.Strings[Index2], 1, 6);
   result := CompareStr(name1, name2);
end;

function sort_STOCK_SORT_NAME_DESC(List: TStringList; Index1, Index2: Integer): Integer;
var name1, name2: string;
begin
   name1  := Copy (List.Strings[Index1], 7, 8)+Copy (List.Strings[Index1], 1, 6);
   name2  := Copy (List.Strings[Index2], 7, 8)+Copy (List.Strings[Index2], 1, 6);
   result := CompareStr(name2, name1);
end;



function sort_STOCK_SORT_PERCENTCHANGE (List: TStringList; Index1, Index2: Integer): Integer;
var dbl1, dbl2  :Double;
    stkobj1, stkobj2  :TStockObject;
begin
   dbl1 := 0;
   dbl2 := 0;
   stkobj1 := TStockObject (List.Objects[Index1]);
   stkobj2 := TStockObject (List.Objects[Index2]);
   if (stkobj1 <> nil) and (stkobj1.PK.Close <> 0) and (stkobj1.PK.YClose <> 0) then begin
      dbl1  := (stkobj1.PK.Close - stkobj1.PK.YClose) / stkobj1.PK.YClose;
   end;
   if (stkobj2 <> nil) and (stkobj2.PK.Close <> 0) and (stkobj2.PK.YClose <> 0) then begin
      dbl2  := (stkobj2.PK.Close - stkobj2.PK.YClose) / stkobj2.PK.YClose;
   end;
   if dbl1 > dbl2 then
      result  := 1
   else if dbl1 < dbl2 then
      result  := -1
   else
      result  := sort_STOCK_SORT_NAME (List, Index1, Index2);
end;

function sort_STOCK_SORT_PERCENTCHANGE_DESC (List: TStringList; Index1, Index2: Integer): Integer;
begin
   result  := - sort_STOCK_SORT_PERCENTCHANGE (List, Index1, Index2);
end;

function sort_STOCK_SORT_CHANGE (List: TStringList; Index1, Index2: Integer): Integer;
var dbl1, dbl2  :Double;
    stkobj1, stkobj2  :TStockObject;
begin
   dbl1 := 0;
   dbl2 := 0;
   stkobj1 := TStockObject (List.Objects[Index1]);
   stkobj2 := TStockObject (List.Objects[Index2]);
   if (stkobj1 <> nil) and (stkobj1.PK.High <> 0) and (stkobj1.PK.YClose <> 0) then begin
      dbl1  := (stkobj1.PK.High - stkobj1.PK.Low) / stkobj1.PK.YClose;
   end;
   if (stkobj2 <> nil) and (stkobj2.PK.High <> 0) and (stkobj2.PK.YClose <> 0) then begin
      dbl2  := (stkobj2.PK.High - stkobj2.PK.Low) / stkobj2.PK.YClose;
   end;
   if dbl1 > dbl2 then
      result  := 1
   else if dbl1 < dbl2 then
      result  := -1
   else
      result  := sort_STOCK_SORT_NAME (List, Index1, Index2);
end;

function sort_STOCK_SORT_CHANGE_DESC (List: TStringList; Index1, Index2: Integer): Integer;
begin
   result  := - sort_STOCK_SORT_CHANGE (List, Index1, Index2);
end;

function sort_STOCK_SORT_PRICECHANGE (List: TStringList; Index1, Index2: Integer): Integer;
var dbl1, dbl2  :Double;
    stkobj1, stkobj2  :TStockObject;
begin
   dbl1 := 0;
   dbl2 := 0;
   stkobj1 := TStockObject (List.Objects[Index1]);
   stkobj2 := TStockObject (List.Objects[Index2]);
   if (stkobj1 <> nil) and (stkobj1.PK.Close <> 0) and (stkobj1.PK.YClose <> 0) then begin
      dbl1  := (stkobj1.PK.Close - stkobj1.PK.YClose) ;
   end;
   if (stkobj2 <> nil) and (stkobj2.PK.Close <> 0) and (stkobj2.PK.YClose <> 0) then begin
      dbl2  := (stkobj2.PK.Close - stkobj2.PK.YClose) ;
   end;
   if dbl1 > dbl2 then
      result  := 1
   else if dbl1 < dbl2 then
      result  := -1
   else
      result  := sort_STOCK_SORT_NAME (List, Index1, Index2);
end;

function sort_STOCK_SORT_PRICECHANGE_DESC (List: TStringList; Index1, Index2: Integer): Integer;
begin
   result  := - sort_STOCK_SORT_PRICECHANGE (List, Index1, Index2);
end;

function sort_STOCK_SORT_PRICE (List: TStringList; Index1, Index2: Integer): Integer;
var dbl1, dbl2  :Double;
    stkobj1, stkobj2  :TStockObject;
begin
   dbl1 := 0;
   dbl2 := 0;
   stkobj1 := TStockObject (List.Objects[Index1]);
   stkobj2 := TStockObject (List.Objects[Index2]);
   if (stkobj1 <> nil) then begin
      dbl1  := stkobj1.PK.Close;
   end;
   if (stkobj2 <> nil) then begin
      dbl2  := stkobj2.PK.Close;
   end;
   if dbl1 > dbl2 then
      result  := 1
   else if dbl1 < dbl2 then
      result  := -1
   else
      result  := sort_STOCK_SORT_NAME (List, Index1, Index2);
end;

function sort_STOCK_SORT_PRICE_DESC (List: TStringList; Index1, Index2: Integer): Integer;
begin
   result  := - sort_STOCK_SORT_PRICE (List, Index1, Index2);
end;

function sort_STOCK_SORT_VOLUME (List: TStringList; Index1, Index2: Integer): Integer;
var dbl1, dbl2  :longword;
    stkobj1, stkobj2  :TStockObject;
begin
   dbl1 := 0;
   dbl2 := 0;
   stkobj1 := TStockObject (List.Objects[Index1]);
   stkobj2 := TStockObject (List.Objects[Index2]);
   if (stkobj1 <> nil) then begin
      dbl1  := stkobj1.PK.Volume;
   end;
   if (stkobj2 <> nil) then begin
      dbl2  := stkobj2.PK.Volume;
   end;
   if dbl1 > dbl2 then
      result  := 1
   else if dbl1 < dbl2 then
      result  := -1
   else
      result  := sort_STOCK_SORT_NAME (List, Index1, Index2);
end;

function sort_STOCK_SORT_VOLUME_DESC (List: TStringList; Index1, Index2: Integer): Integer;
begin
   result  := - sort_STOCK_SORT_VOLUME (List, Index1, Index2);
end;

function sort_STOCK_SORT_YCLOSE (List: TStringList; Index1, Index2: Integer): Integer;
var dbl1, dbl2  :Double;
    stkobj1, stkobj2  :TStockObject;
begin
   dbl1 := 0;
   dbl2 := 0;
   stkobj1 := TStockObject (List.Objects[Index1]);
   stkobj2 := TStockObject (List.Objects[Index2]);
   if (stkobj1 <> nil) then begin
      dbl1  := stkobj1.PK.YClose;
   end;
   if (stkobj2 <> nil) then begin
      dbl2  := stkobj2.PK.YClose;
   end;
   if dbl1 > dbl2 then
      result  := 1
   else if dbl1 < dbl2 then
      result  := -1
   else
      result  := sort_STOCK_SORT_NAME (List, Index1, Index2);
end;

function sort_STOCK_SORT_YCLOSE_DESC (List: TStringList; Index1, Index2: Integer): Integer;
begin
   result  := - sort_STOCK_SORT_YCLOSE (List, Index1, Index2);
end;

function sort_STOCK_SORT_AMOUNT (List: TStringList; Index1, Index2: Integer): Integer;
var dbl1, dbl2  :Double;
    stkobj1, stkobj2  :TStockObject;
begin
   dbl1 := 0;
   dbl2 := 0;
   stkobj1 := TStockObject (List.Objects[Index1]);
   stkobj2 := TStockObject (List.Objects[Index2]);
   if (stkobj1 <> nil) then begin
      dbl1  := stkobj1.PK.Amount;
   end;
   if (stkobj2 <> nil) then begin
      dbl2  := stkobj2.PK.Amount;
   end;
   if dbl1 > dbl2 then
      result  := 1
   else if dbl1 < dbl2 then
      result  := -1
   else
      result  := sort_STOCK_SORT_NAME (List, Index1, Index2);
end;

function sort_STOCK_SORT_AMOUNT_DESC (List: TStringList; Index1, Index2: Integer): Integer;
begin
   result  := - sort_STOCK_SORT_AMOUNT (List, Index1, Index2);
end;

function sort_STOCK_SORT_DAYS (List: TStringList; Index1, Index2: Integer): Integer;
var dbl1, dbl2  :Double;
    stkobj1, stkobj2  :TStockObject;
    n, start, nend :Integer;
begin
   dbl1 := 0;
   dbl2 := 0;
   stkobj1 := TStockObject (List.Objects[Index1]);
   stkobj2 := TStockObject (List.Objects[Index2]);
   if (stkobj1 <> nil) then begin
         dbl1  := stkobj1.TotalAge;
   end;
   if (stkobj2 <> nil) then begin
         dbl2  := stkobj2.TotalAge;
   end;
   if dbl1 > dbl2 then
      result  := 1
   else if dbl1 < dbl2 then
      result  := -1
   else
      result  := sort_STOCK_SORT_NAME (List, Index1, Index2);
end;

function sort_STOCK_SORT_DAYS_DESC (List: TStringList; Index1, Index2: Integer): Integer;
begin
   result  := - sort_STOCK_SORT_DAYS (List, Index1, Index2);
end;



procedure TMyStocksManager.Sort(sortmodevalue: TStockSortMode; boDESC  :Boolean);
var oldMode: TStockSortMode;
    oldDESC: boolean;
    Rect  :TRect;
begin
   oldMode  := FSortMode;
   oldDESC  := FBoSortDESC;
   FSortMode  := sortmodevalue;
   FBoSortDESC  := boDESC;
   Case sortmodevalue of
         STOCK_SORT_CODE:
            if boDESC then
               FMyStocks.CustomSort(sort_STOCK_SORT_CODE_DESC)
            else
               FMyStocks.CustomSort(sort_STOCK_SORT_CODE);

         STOCK_SORT_NAME:
            if boDESC then
               FMyStocks.CustomSort(sort_STOCK_SORT_NAME_DESC)
            else
               FMyStocks.CustomSort(sort_STOCK_SORT_NAME);

         STOCK_SORT_PERCENTCHANGE:
            if boDESC then
               FMyStocks.CustomSort(sort_STOCK_SORT_PERCENTCHANGE_DESC)
            else
               FMyStocks.CustomSort(sort_STOCK_SORT_PERCENTCHANGE);

         STOCK_SORT_PRICECHANGE:
            if boDESC then
               FMyStocks.CustomSort(sort_STOCK_SORT_PRICECHANGE_DESC)
            else
               FMyStocks.CustomSort(sort_STOCK_SORT_PRICECHANGE);

         STOCK_SORT_PRICE:
            if boDESC then
               FMyStocks.CustomSort(sort_STOCK_SORT_PRICE_DESC)
            else
               FMyStocks.CustomSort(sort_STOCK_SORT_PRICE);

         STOCK_SORT_VOLUME:
            if boDESC then
               FMyStocks.CustomSort(sort_STOCK_SORT_VOLUME_DESC)
            else
               FMyStocks.CustomSort(sort_STOCK_SORT_VOLUME);

         STOCK_SORT_AMOUNT:
            if boDESC then
               FMyStocks.CustomSort(sort_STOCK_SORT_AMOUNT_DESC)
            else
               FMyStocks.CustomSort(sort_STOCK_SORT_AMOUNT);

         STOCK_SORT_YCLOSE:
            if boDESC then
               FMyStocks.CustomSort(sort_STOCK_SORT_YCLOSE_DESC)
            else
               FMyStocks.CustomSort(sort_STOCK_SORT_YCLOSE);

         STOCK_SORT_CHANGE:
            if boDESC then
               FMyStocks.CustomSort(sort_STOCK_SORT_CHANGE_DESC)
            else
               FMyStocks.CustomSort(sort_STOCK_SORT_CHANGE);

         STOCK_SORT_DAYS:
            if boDESC then
               FMyStocks.CustomSort(sort_STOCK_SORT_DAYS_DESC)
            else
               FMyStocks.CustomSort(sort_STOCK_SORT_DAYS);
   end;

   if (FSortMode <> sortmodevalue) or (FBoSortDESC <> BoDESC) then
      FItemIndex  := 0;

   if FHandle <> 0 then begin
      GetClientRect (FHandle, Rect);
      InvalidateRect (FHandle, @Rect, FERASEBKGND);
   end;

end;



function TMyStocksManager.GetNextStock(Stock: TStockObject): TStockObject;
var Index: integer;
begin
   result := Stock;
   if FMyStocks.Count < 2 then exit;
   Index  := FMyStocks.IndexOf(Stock.StkCode+Stock.StkName);
   if Index = FMyStocks.Count - 1 then
      Index := 0
   else
      Inc (Index);
   result := TStockObject (FMyStocks.Objects[Index]);
end;

function TMyStocksManager.GetPriorStock(Stock: TStockObject): TStockObject;
var Index: integer;
begin
   result := Stock;
   if FMyStocks.Count < 2 then exit;
   Index  := FMyStocks.IndexOf(Stock.StkCode+Stock.StkName);
   if Index = 0 then
      Index := FMyStocks.Count - 1
   else
      Dec (Index);
   result := TStockObject (FMyStocks.Objects[Index]);
end;

function TMyStocksManager.SearchStocks(Key: string;
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

procedure TMyStocksManager.DrawBmp(Rect: TRect);
var RC: TRect;
    i, ii, k, n, m: integer;
    L, T  :integer;
    rCount  :integer;
    str{, stkcode, stkname} :string;
    stkobj  :TStockObject;
    Rects  :array of TRect;
    sg  :Single;
    Canvas: TCanvas;
begin
   Inherited DrawBmp (Rect);
   if FHandle = 0 then exit;
 try


   RC.Top := 0;
   RC.Left  := 0;
   RC.Right := Rect.Right - Rect.Left;
   RC.Bottom  := Rect.Bottom - Rect.Top;

   FBmp.Width := RC.Right - RC.Left;
   FBmp.Height  := RC.Bottom - RC.Top;
   With FBMP.Canvas do begin

      L := RC.Left; T := RC.Top;

      rCount  := 17;
      SetLength (Rects, rCount);

      Inc (L, FSpaceLeft); Inc (T, 3);
      Rects[0].Left := L;
      Font.Name := FFontName;
      Font.Size := FISize;
      Font.Style  := FOnt.Style + [fsBold];
      str := '99';
      Inc (L, TextWidth (str));
      Rects[0].Right  := L;

      Inc (L, FSpaceLeft);
      Rects[1].Left := L;
      Font.Size := FTSize;
      Font.Style  := FOnt.Style - [fsBold];
      Font.Color  := FColors.Silver;
      str := '代码';
      Inc (L, TextWidth (str+'啊'));
      TextOut (L - TextWidth (str), T, str);
      Rects[1].Right  := L;

      Inc (L, FSpaceLeft);
      Rects[2].Left := L;
      str := '名称';
      Inc (L, TextWidth (str+'啊啊'));
      TextOut (L - TextWidth (str), T, str);
      Rects[2].Right  := L;

      Inc (L, FSpaceLeft);
      Rects[3].Left := L;
      str := '涨幅%';
      Inc (L, TextWidth (str+'%'));
      Rects[3].Right  := L;
      TextOut (L - TextWidth (str), T, str);

      Inc (L, FSpaceLeft);
      Rects[4].Left := L;
      str := '现价';
      Inc (L, TextWidth (str+'啊啊'));
      Rects[4].Right  := L;
      TextOut (L - TextWidth (str), T, str);

      Inc (L, FSpaceLeft);
      Rects[5].Left := L;
      str := '日涨跌';
      Inc (L, TextWidth (str));
      Rects[5].Right  := L;
      TextOut (L - TextWidth (str), T, str);

      Inc (L, FSpaceLeft);
      Rects[6].Left := L;
      str := '买入价';
      Inc (L, TextWidth (str));
      Rects[6].Right  := L;
      TextOut (L - TextWidth (str), T, str);

      Inc (L, FSpaceLeft);
      Rects[7].Left := L;
      str := '卖出价';
      Inc (L, TextWidth (str));
      Rects[7].Right  := L;
      TextOut (L - TextWidth (str), T, str);

      Inc (L, FSpaceLeft);
      Rects[8].Left := L;
      str := '总量';
      Inc (L, TextWidth (str+str));
      Rects[8].Right  := L;
      TextOut (L - TextWidth (str), T, str);

      Inc (L, FSpaceLeft);
      Rects[9].Left := L;
      str := '现量';
      Inc (L, TextWidth (str+str));
      Rects[9].Right  := L;
      TextOut (L - TextWidth (str), T, str);

      Inc (L, FSpaceLeft);
      Rects[10].Left := L;
      str := '今开';
      Inc (L, TextWidth (str+'00'));
      Rects[10].Right := L;
      TextOut (L - TextWidth (str), T, str);

      Inc (L, FSpaceLeft);
      Rects[11].Left := L;
      str := '昨收';
      Inc (L, TextWidth (str+'00'));
      Rects[11].Right := L;
      TextOut (L - TextWidth (str), T, str);

      Inc (L, FSpaceLeft);
      Rects[12].Left := L;
      str := '最高';
      Inc (L, TextWidth (str+'00'));
      Rects[12].Right := L;
      TextOut (L - TextWidth (str), T, str);

      Inc (L, FSpaceLeft);
      Rects[13].Left := L;
      str := '最低';
      Inc (L, TextWidth (str+'00'));
      Rects[13].Right := L;
      TextOut (L - TextWidth (str), T, str);

      Inc (L, FSpaceLeft);
      Rects[14].Left := L;
      str := '成交金额';
      Inc (L, TextWidth (str));
      Rects[14].Right := L;
      TextOut (L - TextWidth (str), T, str);

      Inc (L, FSpaceLeft);
      Rects[15].Left := L;
      str := '振幅';
      Inc (L, TextWidth (str));
      Rects[15].Right := L;
      TextOut (L - TextWidth (str), T, str);

      Inc (L, FSpaceLeft);
      Rects[16].Left := L;
      str := '累计涨幅';
      Inc (L, TextWidth (str));
      Rects[16].Right := L;
      TextOut (L - TextWidth (str), T, str);

      if TitleRects[0].Right = 0 then begin
          for i := low (TitleRects) to High (TitleRects) do begin
             TitleRects[i].Left  := Rects[i].Left;
             TitleRects[i].Right := Rects[i].Right;
             TitleRects[i].Top   := T;
             TitleRects[i].Bottom  := T + TextHeight (str);
          end;
      end;

      Font.Color  := FColors.Red;
      case FSortMode of
         STOCK_SORT_CODE:
            if FBoSortDESC then
               TextOut (TitleRects[1].Right, TitleRects[1].Top, '↓')
            else
               TextOut (TitleRects[1].Right, TitleRects[1].Top, '↑');
         STOCK_SORT_NAME:
            if FBoSortDESC then
               TextOut (TitleRects[2].Right, TitleRects[2].Top, '↓')
            else
               TextOut (TitleRects[2].Right, TitleRects[2].Top, '↑');
         STOCK_SORT_PERCENTCHANGE:
            if FBoSortDESC then
               TextOut (TitleRects[3].Right, TitleRects[3].Top, '↓')
            else
               TextOut (TitleRects[3].Right, TitleRects[3].Top, '↑');
         STOCK_SORT_PRICE:
            if FBoSortDESC then
               TextOut (TitleRects[4].Right, TitleRects[4].Top, '↓')
            else
               TextOut (TitleRects[4].Right, TitleRects[4].Top, '↑');
         STOCK_SORT_PRICECHANGE:
            if FBoSortDESC then
               TextOut (TitleRects[5].Right, TitleRects[5].Top, '↓')
            else
               TextOut (TitleRects[5].Right, TitleRects[5].Top, '↑');
         STOCK_SORT_VOLUME:
            if FBoSortDESC then
               TextOut (TitleRects[8].Right, TitleRects[8].Top, '↓')
            else
               TextOut (TitleRects[8].Right, TitleRects[8].Top, '↑');
         STOCK_SORT_YCLOSE:
            if FBoSortDESC then
               TextOut (TitleRects[11].Right, TitleRects[11].Top, '↓')
            else
               TextOut (TitleRects[11].Right, TitleRects[11].Top, '↑');
         STOCK_SORT_AMOUNT:
            if FBoSortDESC then
               TextOut (TitleRects[14].Right, TitleRects[14].Top, '↓')
            else
               TextOut (TitleRects[14].Right, TitleRects[14].Top, '↑');
         STOCK_SORT_CHANGE:
            if FBoSortDESC then
               TextOut (TitleRects[15].Right, TitleRects[15].Top, '↓')
            else
               TextOut (TitleRects[15].Right, TitleRects[15].Top, '↑');
         STOCK_SORT_DAYS:
            if FBoSortDESC then
               TextOut (TitleRects[16].Right, TitleRects[16].Top, '↓')
            else
               TextOut (TitleRects[16].Right, TitleRects[16].Top, '↑');
      end;

      Inc (T, TextHeight (str));

      //if Length (StockDraws) <> FMyStocks.Count then
      //   SetLength (StockDraws, FMyStocks.Count);
      SetLength (StockDraws, 0);
//======================
      for m := FItemIndex to FMyStocks.Count - 1 do begin
         stkobj := TStockObject (FMyStocks.Objects[m]);
         if stkobj = nil then continue;

         i  := length ( StockDraws );
         SetLength (StockDraws, i + 1);

         Move (PChar (stkobj.stkcode)^, StockDraws[i].stkinfo.code, SizeOf (StockDraws[i].stkinfo.code));
         Move (PChar (stkobj.stkname)^, StockDraws[i].stkinfo.name, SizeOf (StockDraws[i].stkinfo.Name));
         StockDraws[i].stkinfo.Market   := stkobj.Market;

         Inc (T, 7);
         StockDraws[i].rc.Top  := T;

         Font.Color := FColors.Silver;
         Font.Name  := FFontName;
         Font.Size  := FISize;
         str    := IntToStr ( m + 1);
         TextOut ( Rects[0].Right - TextWidth (str), T, str);

         Font.Color := FColors.Yellow;
         TextOut ( Rects[1].Left, T, stkobj.stkcode );

         Font.Size  := FTSize;
         TextOut ( Rects[2].Left, T, stkobj.stkname );

         if FStockManager = nil then begin
            Inc (T, TextHeight ('0'));
            Continue;
         end;

         if ((stkobj.PK.Volume > 0) or (stkobj.PK.Close > 0)) and (stkobj.PK.YClose > 0) then begin
            sg  := stkobj.PriceChange;
            if sg > 0 then
               Font.Color := FColors.Up
            else if sg < 0 then
               Font.Color := FColors.Down
            else
               Font.Color := FColors.White;
            //涨幅
            str := stkobj.PercentChangeStr;
            TextOut ( Rects[3].Right - TextWidth (str), T, str );

            //现价
            str := Format (stkobj.FormatStr, [stkobj.PK.Close]);
            TextOut ( Rects[4].Right - TextWidth (str), T, str );

            //日涨跌
            str := Format (stkobj.FormatStr, [sg]);
            TextOut ( Rects[5].Right - TextWidth (str), T, str );

            //买入价
            if stkobj.initdata.W1 <> 0 then begin  //指数没有买进和卖出价
            for ii  := High (stkobj.PK.Buyv) downto low (stkobj.PK.Buyv) do begin
               if stkobj.PK.Buyv[ii] <> 0 then begin
                  sg  := stkobj.PK.Buyp[ii];
                  if sg > stkobj.PK.YClose then
                     Font.Color := FColors.Up
                  else if sg < stkobj.PK.YClose then
                     Font.Color := FColors.Down
                  else
                     Font.Color := FColors.White;
                  str := Format (stkobj.FormatStr, [sg]);
                  TextOut ( Rects[6].Right - TextWidth (str), T, str );
               end;
            end;
            end;

            //卖出价
            if stkobj.initdata.W1 <> 0 then begin
            for ii  := High (stkobj.PK.Sellv) downto low (stkobj.PK.Sellv) do begin
               if stkobj.PK.Sellv[ii] <> 0 then begin
                  sg  := stkobj.PK.Sellp[ii];
                  if sg > stkobj.PK.YClose then
                     Font.Color := FColors.Up
                  else if sg < stkobj.PK.YClose then
                     Font.Color := FColors.down
                  else
                     Font.Color := FColors.White;
                  str := Format (stkobj.FormatStr, [sg]);
                  TextOut ( Rects[7].Right - TextWidth (str), T, str );
               end;
            end;
            end;

            //总量
            Font.Color  := FColors.Yellow;
            str := stkobj.VolumeStr;
            TextOut ( Rects[8].Right - TextWidth (str), T, str );

            //现量
            Font.Color  := FColors.Yellow;
            str := stkobj.GetIntShortStr(stkobj.PK.LastVolume);
            TextOut ( Rects[9].Right - TextWidth (str), T, str );

            //今开
            sg  := stkobj.PK.Open - stkobj.PK.YClose;
            if sg > 0 then
               Font.Color := FColors.Up
            else if sg < 0 then
               Font.Color := FColors.Down
            else
               Font.Color := FColors.White;
            str := Format (stkobj.FormatStr, [stkobj.PK.Open]);
            TextOut ( Rects[10].Right - TextWidth (str), T, str );

            //昨收
            sg  := stkobj.PK.YClose;
            Font.Color  := FColors.White;
            str := Format (stkobj.FormatStr, [sg]);
            TextOut ( Rects[11].Right - TextWidth (str), T, str );

            //最高
            sg  := stkobj.PK.High - stkobj.PK.YClose;;
            if sg > 0 then
               Font.Color := FColors.Up
            else if sg < 0 then
               Font.Color := FColors.Down
            else
               Font.Color := FColors.White;
            str := Format (stkobj.FormatStr, [stkobj.PK.High]);
            TextOut ( Rects[12].Right - TextWidth (str), T, str );

            //最低
            sg  := stkobj.PK.Low - stkobj.PK.YClose;;
            if sg > 0 then
               Font.Color := FColors.Up
            else if sg < 0 then
               Font.Color := FColors.Down
            else
               Font.Color := FColors.White;
            str := Format (stkobj.FormatStr, [stkobj.PK.Low]);
            TextOut ( Rects[13].Right - TextWidth (str), T, str );

            Font.Color  := FColors.SkyBlue;
            str := stkobj.AmountStr;
            TextOut ( Rects[14].Right - TextWidth (str), T, str );

            Font.Color  := FColors.Silver;
            sg  := stkobj.PK.High - stkobj.PK.Low;
            str := Format ('%.02f%%', [sg/stkobj.PK.YClose*100]);
            TextOut ( Rects[15].Right - TextWidth (str), T, str );


            Font.Color  := FColors.Silver;
            sg  := stkobj.TotalAge;
            str := Format ('%.02f%%', [sg*100]);
            TextOut ( Rects[16].Right - TextWidth (str), T, str );


         end else begin
            if stkobj.PK.YClose <> 0 then begin
            Font.Color  := FColors.White;
               for ii  := 3 to High (Rects) do begin
               if ii <> 11 then begin
                  Pen.Color := FColors.White;
                  MoveTo ( (Rects[ii].Right + Rects[ii].Left) div 2 - 5, T + TextHeight('0') div 2);
                  LineTo ( (Rects[ii].Right + Rects[ii].Left) div 2 + 5, T + TextHeight('0') div 2 );
                  TextOut ( (Rects[ii].Right + Rects[ii].Left) div 2, T, '-' );
               end else begin

                  str := stkobj.GetSingleStr(stkobj.PK.YClose);
                  TextOut ( Rects[11].Right - TextWidth (str), T, str );
                  end;
               end;
            end;
         end;

         Inc (T, TextHeight ('0'));
         StockDraws[i].rc.Bottom := T;

         //画选中的红线
         if FSelectIndex = i then begin
            Pen.Color := FColors.White;
            MoveTo (RC.Left, T + 3);
            LineTo (RC.Right, T + 3);
         end;

         if T + 7  + TextHeight ('0') > RC.Bottom then break;
      end;

   end;

 except on E:Exception do MessageBox (0, PChar (E.Message), 'TMyStocksManager.Draw', 0) end;
end;

procedure TMyStocksManager.SetStock(Value: TStockObject);
begin
   if Value <> FStock then begin
      FStock  := Value;
   end;
end;

procedure TMyStocksManager.ProcessMessage(var Message: TMessage; var Result: integer);
begin
   Inherited ProcessMessage (Message, Result);

end;

procedure TMyStocksManager.AfterReadData(lastMsg: TTDX_MSG);
var Rect: TRect;
begin
  inherited  AfterReadData (lastMsg);
   if (lastMsg.MsgID = TDX_MSG_GETPK)
   and SameText (FLastCodeNames, lastmsg.Code) then begin
      GetClientRect (FHandle, Rect);
      Sort ( FSortMode, FBoSortDESC );
      //InvalidateRect (FHandle, @Rect, FERASEBKGND);
   end;
end;

procedure TMyStocksManager.DoKeyDown(var Message: TWMKeyDown);
begin
  inherited;
  Case Message.CharCode of
      VK_DOWN:ItemIndex := FItemIndex + 1;
      VK_UP :ItemIndex  := FItemIndex - 1;
      VK_PRIOR  :ItemIndex  := FItemIndex - Length (StockDraws);
      VK_NEXT :ItemIndex  := FItemIndex + Length (StockDraws);
   end;
end;

procedure TMyStocksManager.DoLButtonDblClk(var Message: TWMLButtonDblClk);
begin
   Inherited;
   if (FSelectIndex >= LOW (StockDraws)) and (FSelectIndex <= HIGH (StockDraws)) then begin

      FStockManager.CurStock := FStockManager.FindStock(
          StockDraws[FSelectIndex].stkinfo.Code,
          StockDraws[FSelectIndex].stkinfo.Market);
   end;
end;

procedure TMyStocksManager.DoLButtonDown(var Message: TWMLButtonDown);
var i, X, Y: integer;
    str: string;
    newsortmode :TStockSortMode;
      flag  :Boolean;
    ClientRect  :TRect;
begin
   Inherited;
   SelectIndex := -1;
   X  := Message.XPos;
   Y  := Message.YPos;
   for i  := low ( StockDraws ) to high (StockDraws ) do begin
      if (Y >= StockDraws[i].rc.Top) and (Y <= StockDraws[i].rc.Bottom) then begin
         SelectIndex := i;

         break;
      end;
   end;

   if ( TitleRects[0].Bottom >= Y ) and (TitleRects[0].Top <= Y) then begin
      for i := low ( TitleRects) to High ( TitleRects) do begin
         //if X < man.TitleRects[i].Right then break;
         if (X>= TitleRects[i].Left) and (X <= TitleRects[i].Right) then begin
            str := FNameTable[i];

            newsortmode := GetSortModeByString ( str );
            if newsortmode = SortMode then
               Sort(newsortmode,not BoSortDESC)
            else
               Sort(newsortmode,BoSortDESC);

            exit;
            //break;
         end;
      end;
   end;

   GetClientRect (FHandle, ClientRect);
   InvalidateRect (FHandle, @ClientRect, FERASEBKGND);
//   FControl.Repaint;
end;

procedure TMyStocksManager.DoMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
  inherited;
    if WheelDelta > 0 then
       self.ItemIndex := FItemIndex - 1
    else
       self.ItemIndex := FItemIndex + 1;
end;

{ TMySelectStocksManager }

function TMySelectStocksManager.Add (StkCode, StkName: string): boolean;
var stock: TStockObject;
begin
   result := False;
   stock  := FStockManager.FindStock(StkCode, StkName) ;
   if stock = nil then exit;
   if FMyStocks.IndexOf(StkCode+StkName) < 0 then begin
      FMyStocks.AddObject(StkCode+StkName, stock);
      //FStockMan.MyStocks.Assign(FMyStocks);
      result  := True;
   end;

end;

procedure TMySelectStocksManager.Delete(StkCode, StkName: string);
var index: integer;
    Rect  :TRect;
begin
   index  := FMyStocks.IndexOf(StkCode+StkName);
   if index >= 0 then begin
      FMyStocks.Delete(Index);
      //FStockMan.MyStocks.Assign(FMyStocks);
      if FHandle <> 0 then begin
         GetClientRect (FHandle, Rect);
         InvalidateRect (FHandle, @Rect, FERASEBKGND);
      end;
   end;
end;

procedure TMySelectStocksManager.DeleteSelected;
var stkcode, stkname, str: string;
    index :integer;
    Rect  :TRect;
begin
   if (FSelectIndex >= Low (StockDraws)) and (FSelectIndex <= High (StockDraws)) then begin
      stkcode := StockDraws[FSelectIndex].stkinfo.Code;
      stkname := StockDraws[FSelectIndex].stkinfo.Name;
      
      index := FMyStocks.IndexOf(stkcode + stkname);
      if index <> -1 then begin
         FMyStocks.Delete(index);
         //FStockMan.MyStocks.Assign(FMyStocks);
         if FHandle <> 0 then begin
            GetClientRect (FHandle, Rect);
            InvalidateRect (FHandle, @Rect, FERASEBKGND);
         end;
      end;
   end;

end;

destructor TMySelectStocksManager.Destroy;
begin
   Save;
  inherited;
end;

procedure TMySelectStocksManager.Load;
var i, n: integer;
    stkcode, stkname: string;
    stkobj  :TStockObject;
    slist: TStringList;
begin

   FMyStocks.Clear;
   slist  := TStringList.Create; try
   if fileExists (ExtractFileDir (Application.ExeName) + '\自选股.txt') then
      slist.LoadFromFile(ExtractFileDir (Application.ExeName) + '\自选股.txt');
   for i  := 0 to slist.Count - 1 do begin
      StkCode := Copy (slist[i], 1, 6);
      StkName := Copy (slist[i], 7, 8);
      stkobj  := FStockManager.FindStock(StkCode, StkName);
      if (stkobj <> nil ) and (FMyStocks.IndexOf(StkCode+StkName) < 0) then
         FMyStocks.AddObject(stkcode+stkName, stkobj);
   end;

   finally slist.Free end;

   //FStockMan.MyStocks.Assign(FMyStocks);
end;

procedure TMySelectStocksManager.Save;
begin
   FMyStocks.SaveToFile(ExtractFileDir (Application.ExeName) + '\自选股.txt');

end;

{ TAllStocksManager }

procedure TAllStocksManager.Load;
var i: integer;
    stkobj: TStockObject;
begin
   FMyStocks.clear;
   for i  := 0 to FStockManager.Stocks.Count - 1 do begin
      stkobj  := TStockObject(FStockManager.Stocks.Objects[i]);
      if (stkobj = nil) or (stkobj.StkCode = '') then continue;

      if (stkobj.StkCode = '999999')
      or (stkobj.StkCode = '399001')
      or
         ((stkobj.initdata.W1 > 0) and (stkobj.initdata.W1 < 10000)
         and (stkobj.StkCode[1] in ['0', '3', '6']))
      then begin
         if FMyStocks.IndexOf(stkobj.StkCode+stkobj.StkName) < 0 then
            FMyStocks.AddObject(stkobj.StkCode + stkobj.StkName, stkobj);
      end;
   end;
end;

{ TSZStocksManager }

procedure TSZStocksManager.Load;
var i: integer;
    stkobj: TStockObject;
begin
   FMyStocks.clear;
   for i  := 0 to FStockManager.Stocks.Count - 1 do begin
      stkobj  := TStockObject(FStockManager.Stocks.Objects[i]);
      if (stkobj = nil) or (stkobj.StkCode = '') then continue;
      if (stkobj.Market = 0) and (stkobj.initdata.W1 <> 0) and (stkobj.StkCode[1] in ['0', '3', '6']) then begin
         FMyStocks.AddObject(stkobj.StkCode + stkobj.StkName, stkobj);
      end;
   end;
end;

{ TSHStocksManager }

procedure TSHStocksManager.Load;
var i: integer;
    stkobj: TStockObject;
begin
   FMyStocks.clear;
   for i  := 0 to FStockManager.Stocks.Count - 1 do begin
      stkobj  := TStockObject(FStockManager.Stocks.Objects[i]);
      if (stkobj = nil) or (stkobj.StkCode = '') then continue;
      if (stkobj.Market = 1) and (stkobj.initdata.W1 <> 0) and (stkobj.StkCode[1] in ['3', '6']) then begin
         FMyStocks.AddObject(stkobj.StkCode + stkobj.StkName, stkobj);
      end;
   end;
end;

{ TFilterStocksManager }

function TFilterStocksManager.CheckDAY(D1, D2: TTDX_DAYInfo; Y1, Y2: single;
  DBL: double): boolean;
  var _dbl, _dbl2: double;
begin
   result := False;
   if (Y1 = 0) or (Y2 = 0) then exit;
   if (D1.Open = 0) or (D2.Open = 0) 
   or (D2.High = 0) or (D2.Low = 0)
   or (D1.Close = 0) or (D2.Close = 0)
   then
      exit;

   _dbl := Y1 / Y2;
   _dbl2  := D1.Open / D2.Open;
   if ABS (_dbl - _dbl2) > DBL then exit;

   _dbl2  := D1.Close / D2.Close;
   if ABS (_dbl - _dbl2) > DBL then exit;

   _dbl2  := D1.High / D2.High;
   if ABS (_dbl - _dbl2) > DBL then exit;

   _dbl2  := D1.Low / D2.Low;
   if ABS (_dbl - _dbl2) > DBL then exit;
   //if (_dbl2 > _dbl * (1 + DBL)) or (_dbl2 < _dbl * (1 - DBL)) then exit;
   result := True;
end;

function TFilterStocksManager.Search_0(stockman: TMyStocksManager;
  S: TKLineSearchInfo): integer;
  var i, ii, iii: integer;
      stkobj: TStockObject;
      str :string;
      sg, sg0, _sg, yclose  :single;
      pk  :TTDX_DAYInfo;
      searchinfo :pTKLineSearchInfoRCD;
      flag, find  :Boolean;
      slist :TStringList;
      Label _Next;

begin
   slist  := TStringList.Create; try
       slist.AddStrings(stockman.FMyStocks);
       result := 0;
       FMyStocks.Clear;
       for i  := 0 to slist.Count - 1 do begin
          stkobj  := TStockObject (slist.Objects[i]);
          if stkobj = nil then continue;

          for ii  := 0 to S.Count - 1 do begin
              searchinfo := S.GetRCD(ii);
              if searchinfo = nil then continue;
              //if length (stkobj.DAYS) <= SearchInfo.KIndex  then goto _Next;
              //if (stkobj.PK.Volume = 0) or (stkobj.PK.YClose = 0) then continue;
              Find  := False;
              for iii := Low (stkobj.DAYS) to High (stkobj.DAYS) do begin
                 if (stkobj.DAYS[iii].DATA.DAY = searchinfo.DAY)
                 or ((searchinfo.DAY=0) and (iii = 0)) then begin
                    pk  := stkobj.DAYS[iii].Data;
                    Find  := True;
                    break;
                 end;
              end;
              if not Find then
                 goto _Next;

              //总振动范围
              sg0 := PK.High - PK.Low;
              if (not SearchInfo.BoOpenCloseMode) or (SearchInfo.CloseMode <> 1) then begin
                  //上影线
                  if SearchInfo.KHigh.BoOpen then begin
                     if sg0 = 0 then goto _Next;
                     sg := PK.High - MAX (PK.Open, PK.Close);
                     _sg  := sg / sg0;
                     if (_sg < SearchInfo.KHigh.sg0) or (_sg > SearchInfo.KHigh.sg1) then goto _Next;
                  end;
                  //下影线
                  if SearchInfo.KLow.BoOpen then begin
                     if sg0 = 0 then goto _Next;
                     sg := MIN (PK.Open, PK.Close) - PK.Low;
                     _sg  := sg / sg0;
                     if (_sg < SearchInfo.KLow.sg0) or (_sg > SearchInfo.KLow.sg1) then goto _Next;
                  end;

                  if SearchInfo.KBody.BoOpen then begin
                     if sg0 = 0 then goto _Next;
                     sg := ABS (PK.Open - PK.Close);
                     _sg  := sg / sg0;
                     if (_sg < SearchInfo.KBody.sg0) or (_sg > SearchInfo.KBody.sg1) then goto _Next;
                  end;

              end;
              //涨幅
              if SearchInfo.Change.BoOpen then begin
                 if III = 0 then
                    YClose  := stkobj.PK.YClose
                 else if length (stkobj.DAYS) <= III + 1 then
                    goto _Next
                 else
                    YClose  := stkobj.DAYS[III+1].DATA.Close;
                 if YClose = 0 then goto _Next;
                 sg := PK.Close - YClose;
                 _sg  := sg / YClose;
                 if (_sg < SearchInfo.Change.sg0) or (_sg > SearchInfo.Change.sg1) then goto _Next;
              end;

              if SearchInfo.CHangeRange.BoOpen then begin
                 if III = 0 then
                    YClose  := stkobj.PK.YClose
                 else if length (stkobj.DAYS) <= III + 1 then
                    goto _Next
                 else
                    YClose  := stkobj.DAYS[III+1].DATA.Close;
                 if YClose = 0 then goto _Next;
                 _sg  := sg0 / YClose;
                 if (_sg < SearchInfo.ChangeRange.sg0) or (_sg > SearchInfo.ChangeRange.sg1) then goto _Next;
              end;

              if SearchInfo.Price.BoOpen then begin
                 _sg  := PK.Close;
                 if (_sg < SearchInfo.Price.sg0) or (_sg > SearchInfo.Price.sg1) then goto _Next;
              end;

              if SearchInfo.BoOpenCloseMode then begin
                 Case SearchInfo.CloseMode of
                    0: if PK.Close <= PK.Open then goto _Next;
                    1: if PK.Close <> PK.Open then goto _Next;
                    2: if PK.Close >= PK.Open then goto _Next;
                 end;
              end;

          end;

          FMyStocks.AddObject(stkobj.StkCode + stkobj.StkName, stkobj);
          _Next:
       end;
       result := FMyStocks.Count;
   finally slist.Free end;
end;

function TFilterStocksManager.Search_1(stockman: TMyStocksManager;
  startindex, endindex: integer; range1, range2: double): integer;
  var i, ii, k, nstart, nend: integer;
      stkobj: TStockObject;
      sgH, sgL, sgStart, sgEnd: single;
      dbl, dblMax, dblMin: double;
      slist :TStringList;
begin
   slist  := TStringList.Create; try
       slist.AddStrings(stockman.FMyStocks);
       nstart := MIN (startindex, endindex);
       nend   := MAX (startindex, endindex);
       result := 0;
       FMyStocks.Clear;
       for i  := 0 to slist.Count - 1 do begin
          stkobj  := TStockObject (slist.Objects[i]);
          if stkobj = nil then continue;
          //if Length (stkobj.DAYS) <= nEnd - nstart then continue;
          sgH := 0;
          sgL := 0;
          sgStart :=0;
          sgEnd := 0;
          for k := low (stkobj.DAYS) to high (stkobj.DAYS) do begin
             if stkobj.DAYS[k].DATA.DAY = nStart then begin
                sgStart := stkobj.DAYS[k].DATA.Close;
             end;

             if stkobj.DAYS[k].DATA.DAY = nEnd then begin
                sgEnd := stkobj.DAYS[k].Data.Close;
             end;
          end;

          if sgStart = 0 then continue;
          if sgEnd   = 0 then continue;
          dbl := (sgEnd - sgStart) / sgStart;

          dblMax  := MAX (range1, range2);
          dblMin  := MIN (range1, range2);
          if  (dbl > dblMax) then continue;
          if  (dbl < dblMin) then continue;
          FMyStocks.AddObject(stkobj.StkCode + stkobj.StkName, stkobj);
       end;
       result := FMyStocks.Count;
   finally slist.Free end;
end;

function TFilterStocksManager.Search_2(stockman: TMyStocksManager;
  SDAYS: array of TTDX_DAYInfo; percent: integer): integer;
  var i, ii, iii: integer;
      stkobj: TStockObject;
      str :string;
      sg, sg0, _sg, yclose  :single;
      pk  :TTDX_DAYInfo;
      flag, find  :Boolean;
      slist :TStringList;
      Y1, Y2: single;

      Label loc1;
begin
   slist  := TStringList.Create; try
       slist.AddStrings(stockman.FMyStocks);
       result := 0;
       FMyStocks.Clear;
       for i  := 0 to slist.Count - 1 do begin
          stkobj  := TStockObject (slist.Objects[i]);
          if stkobj = nil then continue;
          if length (stkobj.DAYS) < length (SDAYS) then continue;
          flag  := False;
          for ii  := low (stkobj.DAYS) to (high (stkobj.DAYS) - length (SDAYS)) do begin
             if CheckDAY (stkobj.DAYS[ii].Data, SDAYS[low (SDAYS)], stkobj.DAYS[ii].Data.Close, SDAYS[low (SDAYS)].Close, percent/1000) then begin
                for iii  := low (SDAYS) + 1 to High(SDAYS) do begin
                   if not CheckDAY (stkobj.DAYS[ii+iii].Data, SDAYS[iii], stkobj.DAYS[ii+iii-1].Data.Close, SDAYS[iii-1].Close, percent/1000) then begin
                      goto loc1;
                   end;
                end;
                stkobj.KLineCount  := 60;
                stkobj.KLineStart := ii + 60 ;
                flag  := True;
                break;
                loc1:
                Continue;
             end;
          end;
          if flag then
             FMyStocks.AddObject(stkobj.StkCode + stkobj.StkName, stkobj);
       end;
       result := FMyStocks.Count;
   finally slist.Free end;
end;

{ TKLineSearchInfo }

procedure TKLineSearchInfo.AddRCD(sinfo: TKLineSearchInfoRCD);
var rcd: pTKLineSearchInfoRCD;
begin
   new (rcd);
   rcd^ := sinfo;
   Add (  rcd );
   if Assigned (FListBox) then
      FListBox.Items.AddObject(IntToStr (rcd.DAY), TObject (rcd));
end;

procedure TKLineSearchInfo.Clear;
var i: integer;
    rcd: pTKLineSearchInfoRCD;
begin
   for i  := Count - 1 downto 0 do begin
      rcd := pTKLineSearchInfoRCD (Items[i]);
      if rcd <> nil then
         Dispose (rcd);
   end;
   if Assigned (FListBox) then
      FListBox.Clear;
  inherited;

end;

procedure TKLineSearchInfo._Delete(DAY: integer);
var i: integer;
    rcd: pTKLineSearchInfoRCD;
begin
   for i  := Count - 1 downto 0 do begin
      rcd:= pTKLineSearchInfoRCD (Items[i]);
      if rcd.DAY = DAY then begin
         Dispose (rcd);
         Delete (i);
         if Assigned (FListBox) then
            FListBox.Items.Delete(i);
         break;
      end;
   end;
end;

function TKLineSearchInfo.GetRCD(index: integer): pTKLineSearchInfoRCD;
var rcd: pTKLineSearchInfoRCD;
begin
   result := nil;
   if Index < Count then
      result := pTKLineSearchInfoRCD (Items[Index]);
end;


procedure TKLineSearchInfo.SetListBox(Value: TListBox);
begin
   if Value <> FListBox then begin
      FListBox  := value;
      //if FListBox <> nil then
      //   FListBox.FreeNotification(self);
   end;
end;

end.
