unit uFunctions;
{
通达信实时行情接收控件 DLL 版内部函数 Delphi 实现及函数声明
    renshouren
WEB     :http://renshou.net
E-MAIL  :lxy@renshou.net
QQ      :114032666
TEL     :13118369704
}
interface
uses SysUtils, Classes, Windows, TDXEDCode, uSockTDXManager, TDXGrobal;

{---------------注意-----------------
   回调函数的 Delphi 版声明及相关数据结构请参见 TDXGrobal.pas
   本 DLL 必须使用 LoadLibrary 方式显式被主程序调用
}

//2010.08.07
{
创建数据接收组件(使用独立的数据工作线程)
参数
Handle  = 调用者窗口 Handle ，数据组件在获得数据后将向这个窗口发送消息，如果想使用回调函数方式工作，则将该参数设置为0
RegKey  = 注册字符串，试用时直接使用空值。 未注册时，本控件在一定数量的数据工作后，将随机出现乱解码
返回值
创建的数据接收组件的句柄，需要将该句柄进行保存，以便进行其他数据操作
}
function  R_Open (Handle: THandle; RegKey: PChar): longword; stdcall;
{
释放数据接收组件
参数
TDXManager = 需要释放的组件的句柄
}
procedure R_Close (TDXManager: longword); stdcall;



{连接到行情服务器
参数
TDXManager = 使用 R_Open 创建的数据接收组件返回的句柄
ServerAddr = 行情服务器地址，可以是IP或域名
Port       = 服务器端口 普通股票行情=7709  股指期货=7721
返回值
True   成功连接
False  失败
}
function  R_Connect (TDXManager: longword; ServerAddr: PChar; port:integer=7709):LongBool; stdcall;

{
断开与服务器的连接
参数
TDXManager = 使用 R_Open 创建的数据接收组件返回的句柄
}
procedure R_DisConnect (TDXManager: longword);stdcall;


{
初始化市场数据  获得最新的证券代码与证券名称等数据的表
参数
TDXManager = 使用 R_Open 创建的数据接收组件返回的句柄
Market 0=深圳 1=上海
}
procedure R_InitMarketData (TDXManager: longword; Market: integer); stdcall;//初始化市场数据


procedure S_InitMarketData (TDXManager: longword; CallBack  :TOnDecodePacket_INITMARKET); stdcall;


{
发送请求盘口要求
若提供两个参数，则能准确发送
若仅提供证券名称，也一般能准确发送
若仅提供证券代码
因为上海和深圳存在同名的代码，如000001在上海代表大盘指数，在深圳代表深发展，所以有可能发送的是不符合您预期的数据，
这时候你可以在证券代码后面加市场指定字符，如：000001SH 就代表上海的000001 000001SZ代表深圳的000001
参数
TDXManager = 使用 R_Open 创建的数据接收组件返回的句柄
StkCode = 证券代码
StkName = 证券名称
}
procedure R_GetPK (TDXManager: longword; StkCode  :PChar; StkName :PChar); stdcall;

{
设置当接收到股票盘口时的回调函数
参数
TDXManager = 使用 R_Open 创建的数据接收组件返回的句柄
CallBack  = 回调函数
}
procedure S_GetPK (TDXManager: longword; CallBack :TOnDecodePacket_PKDAT); stdcall;


{
发送请求盘口要求[支持同时多只股票]
参数
TDXManager = 使用 R_Open 创建的数据接收组件返回的句柄
StockCodeNames  = 证券列表，格式为 股票代码+市场代码，中间以","分隔，例如： 600158SH,000002SZ 表示请求获得 中体产业 和 万科A的盘口
}
procedure R_GetPKS (TDXManager: longword; StockCodeNames :PChar); stdcall;


{
发送是否有实时数据变化请求
可以用比较频繁的向服务器发送本请求，测试是否有新的交易数据或盘口变化，如果有，则返回数据，没有，则不返回数据
参数
TDXManager = 使用 R_Open 创建的数据接收组件返回的句柄
StkCode = 证券代码
Market  = 市场编号
Time    = 最后一次接收到的盘口数据结构 TTDX_PKBASE.LastDealTime 的值，若=0，则一定会返回当前最新盘口数据

}
procedure R_GetTestRealPK (TDXManager: longword; StkCode: PChar; market, Time: integer);  stdcall;


{
设置当接收到实时盘口时的回调函数
}
procedure S_GetTestRealPK (TDXManager: longword; CallBack :TOnDecodePacket_REALPK); stdcall;


{
发送请求获得日K线数据
参数
TDXManager = 使用 R_Open 创建的数据接收组件返回的句柄
StkCode = 证券代码
Market  = 市场编号
startcount  = 开始交易日天数，从当前最新交易日往后推的数字，若=0则从最新交易日开始
count   = 获取的日K线天数
}
procedure R_GetKDays (TDXManager: longword; StkCode: PChar; market, startcount, count: integer); stdcall;//获得日K线


{
设置当接收到日K线数据时的回调函数
}
procedure S_GetKDays (TDXManager: longword; CallBack  :TOnDecodePacket_DAYS); stdcall;


{
发送请求获得分笔成交数据
参数
startcount  = 从最新一笔交易往后推的开始笔数
count       = 需要获取的笔数
}
procedure R_GetDeals (TDXManager: longword; StkCode: PChar; market, startcount, count: integer); stdcall; //分笔成交

{
设置当获得分笔成交时的回调函数
}
procedure S_GetDeals (TDXManager: longword; CallBack  :TOnDecodePacket_DEALS); stdcall;


{
发送请求获得分时成交数据
参数
start   = 开始分钟数，一般取0，返回当前所有分时数据
}
procedure R_GetMins  (TDXManager: longword; StkCode: PChar; market, start: integer); stdcall;//分时图


{
设置当获得分时图时的回调函数
}
procedure S_GetMins  (TDXManager: longword; CallBack  :TOnDecodePacket_MINS); stdcall;



//====================期货
{
发送请求获得股指期货日K线数据
参数
TDXManager = 使用 R_Open 创建的数据接收组件返回的句柄
StkCode = 证券代码
startcount  = 开始交易日天数，从当前最新交易日往后推的数字，若=0则从最新交易日开始
count   = 获取的日K线天数
}
procedure R_Get_QH_KDays (TDXManager: longword; StkCode :PChar; startcount, count: integer); stdcall;

{
设置当接收到期货日K线时的回调函数
}
procedure S_Get_QH_KDays (TDXManager: longword; CallBack  :TOnDecodePacket_FUTURES_DAYS); stdcall;

{
发送获得实时数据变化请求，发送本请求后，股指期货服务器将在10秒内主动将该段时间内所有盘口变化情况分次返回
参数
TDXManager = 使用 R_Open 创建的数据接收组件返回的句柄
StkCode = 证券代码
}
procedure R_Get_QH_TestRealPK (TDXManager: longword; StkCode  :PChar); stdcall;

{
设置当接收到股指期货服务器返回盘口数据时的回调函数
}
procedure S_Get_QH_TestRealPK (TDXManager: longword; CallBack :TOnDecodePacket_FUTURES_PKDAT); stdcall;

{
发送请求期货分时图请求
}
procedure R_Get_QH_Mins (TDXManager: longword; StkCode  :PChar); stdcall;

{
设置当获得期货分时图时的回调数据
}
procedure S_Get_QH_Mins (TDXManager: longword; CallBack :TOnDecodePacket_FUTURES_MINS); stdcall;

{
发送请求期货分笔成交数据请求
}
procedure R_Get_QH_Deals (TDXManager: longword; StkCode :PChar; startcount, count: integer); stdcall;

{
设置当获得期货分笔成交数据时的回调函数
}
procedure S_Get_QH_Deals (TDXManager: longword; CallBack  :TOnDecodePacket_FUTURES_DEALS); stdcall;

{
获得市场类型，必须在调用 R_InitMarketData 函数获得初始化市场数据后
当两个参数都正确输入时，可以准确返回市场类别，若只有StkCode参数，因此参数两市可能存在同名，因此返回其中一个市场的类型
若只有StkName参数，一般情况下都可以准确返回
参数
StkCode = 证券代码
StkName = 证券名称
返回值
0=深圳
1=上海
255=未找到
}
function  R_GetMarket (StkCode  :PChar; StkName :PChar): integer; stdcall;
function  R_GetMarketByStockCode (StkCode  :PChar): integer; stdcall;
function  R_GetMarketByStockName (StkName  :PChar): integer; stdcall;
function  R_GetStockName (StkCode :PChar; Market: integer): PChar; stdcall;
function  R_GetStockCode (StkName :PChar): PChar; stdcall;


//注册当 TDXManager 连接上服务器时的回调函数
procedure S_Connected (TDXManager: longword; CallBack :TRNotifyEvent); stdcall;
//注册当 TDXManager 与服务器连接断开时的回调函数
procedure S_DisConnected (TDXManager: longword; CallBack  :TRNotifyEvent); stdcall;


var
   //tdx  :TTDXManager;
   TimerID  :longword;
   Managers :TList;

implementation
procedure TimerProc (a, b, c, d: longword); Stdcall;
var i: integer;
begin

   for i  := 0 to Managers.Count - 1 do  begin
      TTDXManager (Managers.Items[i]).Run;
      //MessageBox (0, 'dd', nil, 0);
   end;
end;

procedure ClearManagers;
var i: integer;
begin
   for i  := Managers.Count -1 downto 0 do begin
          TTDXManager (Managers.Items[i]).Free;
   end; 
   Managers.Clear;
end;

function  R_Open (Handle: THandle; RegKey: PChar): longword; stdcall;
var obj: TTDXManager;
begin
   obj  := TTDXManager.Create(nil);
   obj.Handle := Handle;
   obj.RegKeyString := StrPas (RegKey);
   Managers.Add(obj);
   result := longword (obj);
end;
procedure R_Close (TDXManager: longword); stdcall;
var i: integer;
begin
   for i  := Managers.Count - 1 downto 0 do begin
      if TDXManager = longword (Managers.Items[i]) then begin
         Managers.Delete(i);

         TTDXManager (TDXManager).Free;
         break;
      end;
   end;
end;

function  R_Connect (TDXManager: longword; ServerAddr: PChar; port:integer=7709):LongBool; stdcall;
begin
   if ServerAddr <> nil then
      TTDXManager (TDXManager).Host := StrPas (ServerAddr);
   TTDXManager (TDXManager).Port := port;
   result   := TTDXManager (TDXManager).Connect;
end;

procedure R_DisConnect (TDXManager: longword) ;stdcall;
begin
   if TTDXManager (TDXManager).IdTCPClient.Connected then begin
      TTDXManager (TDXManager).IdTCPClient.Disconnect;
   end;
end;

//注册当 TDXManager 连接上服务器时的回调函数
procedure S_Connected (TDXManager: longword; CallBack :TRNotifyEvent); stdcall;
begin
   TTDXManager (TDXManager).OnConnected := CallBack;
end;
//注册当 TDXManager 与服务器连接断开时的回调函数
procedure S_DisConnected (TDXManager: longword; CallBack  :TRNotifyEvent); stdcall;
begin
   TTDXManager (TDXManager).OnDisConnected  := CallBack;
end;

procedure R_InitMarketData (TDXManager: longword; Market: integer); stdcall;//初始化市场数据
begin
   TTDXManager (TDXManager).Get_InitData(market);
end;

procedure S_InitMarketData (TDXManager: longword; CallBack  :TOnDecodePacket_INITMARKET); stdcall;
begin
   TTDXManager (TDXManager).OnDecodePacket_INITMARKET := CallBack;
end;

procedure R_GetPK (TDXManager: longword; StkCode  :PChar; StkName: PChar); stdcall;
var sCode, sName, str: string;
    market: byte;
begin
   sCode  := StrPas (StkCode);
   sName  := StrPas (StkName);
   str  := '';
   if SName <> '' then begin
      str := GetStockCode (SName);
      if Str <> '' then
         sCode := str;
   end;

   if length (sCode) = 8 then begin
      str := copy (sCode, 7, 2);
      Delete (sCode, 7, 2);
      if SameText (str, 'SZ') then
         market := 0
      else if Sametext (str, 'SH') then
         market := 1
      else
         market := 255;
   end else
      market := GetMarketMode (scode, sName);

   if market = 255 then begin
      MessageBox (0, '未找到匹配的代码与名称。', '错误', 0);
      exit;
   end;


   Case market of
         0: sCode := sCode + 'SZ';
         1: sCode := sCode + 'SH';
   end;

   TTDXManager(TDXManager).Get_PK(sCode);

end;

procedure S_GetPK (TDXManager: longword; CallBack :TOnDecodePacket_PKDAT); stdcall;
begin
   TTDXManager(TDXManager).OnDecodePacket_PKDAT := CallBack;
end;

procedure  R_GetPKS (TDXManager: longword; StockCodeNames :PChar); stdcall;
begin
   TTDXManager(TDXManager).Get_PK(StrPas (StockCodeNames));
end;

procedure R_GetTestRealPK (TDXManager: longword; StkCode: PChar; market, Time: integer);  stdcall;
begin
   TTDXManager(TDXManager).Get_TestRealPK(StkCode, market, Time);
end;
procedure S_GetTestRealPK (TDXManager: longword; CallBack :TOnDecodePacket_REALPK); stdcall;
begin
   TTDXManager(TDXManager).OnDecodePacket_REALPK  := CallBack;
end;
procedure R_GetKDays (TDXManager: longword; StkCode: PChar; market, startcount, count: integer); stdcall;//获得日K线
begin
   TTDXManager(TDXManager).Get_K_Days(stkcode, market, startcount, count);
end;
procedure S_GetKDays (TDXManager: longword; CallBack  :TOnDecodePacket_DAYS); stdcall;
begin
   TTDXManager(TDXManager).OnDecodePacket_DAYS  := CallBack;
end;
procedure R_GetDeals (TDXManager: longword; StkCode: PChar; market, startcount, count: integer); stdcall; //分笔成交
begin
   TTDXManager(TDXManager).Get_Deals(stkcode, market, startcount, count);
end;
procedure S_GetDeals (TDXManager: longword; CallBack  :TOnDecodePacket_DEALS); stdcall;
begin
   TTDXManager(TDXManager).OnDecodePacket_DEALS := CallBack;
end;
procedure R_GetMins  (TDXManager: longword; StkCode: PChar; market, start: integer); stdcall; //分时图
begin
   TTDXManager(TDXManager).Get_Mins(stkcode, market, start);
end;

procedure S_GetMins  (TDXManager: longword; CallBack  :TOnDecodePacket_MINS); stdcall;
begin
   TTDXManager(TDXManager).OnDecodePacket_MINS  := CallBack;
end;

function  R_GetMarket (StkCode  :PChar; StkName :PChar): integer; stdcall;
begin
   result := GetMarketMode (StrPas (StkCode), StrPas (StkName));
end;

function  R_GetMarketByStockCode (StkCode  :PChar): integer; stdcall;
begin
   result := GetMarketModeByStockCode (StrPas (StkCode));
end;
function  R_GetMarketByStockName (StkName  :PChar): integer; stdcall;
begin
   result := GetMarketModeByStockName (StrPas (StkName) );
end;
function  R_GetStockName (StkCode :PChar; Market: integer): PChar; stdcall;
begin
   result := PChar (GetStockName ( StrPas (StkCode), Market ));
end;
function  R_GetStockCode (StkName :PChar): PChar; stdcall;
begin
   result := PChar (GetStockCode ( StrPas (StkName) ));
end;


//期货
//期货
procedure R_Get_QH_KDays (TDXManager: longword; StkCode :PChar; startcount, count: integer); stdcall;
begin
   TTDXManager(TDXManager).Get_Futures_KDays(StrPas (StkCode), startcount, count);
end;
procedure S_Get_QH_KDays (TDXManager: longword; CallBack  :TOnDecodePacket_FUTURES_DAYS); stdcall;
begin
   TTDXManager(TDXManager).OnDecodePacket_FUTURES_DAYS  := CallBack;
end;
procedure R_Get_QH_TestRealPK (TDXManager: longword; StkCode  :PChar); stdcall;
begin
   TTDXManager(TDXManager).Get_TestRealFutures(StrPas (StkCode));
end;

procedure S_Get_QH_TestRealPK (TDXManager: longword; CallBack :TOnDecodePacket_FUTURES_PKDAT); stdcall;
begin
   TTDXManager(TDXManager).OnDecodePatcket_FUTURES_PKDAT  := CallBack;
end;

procedure R_Get_QH_Mins (TDXManager: longword; StkCode  :PChar); stdcall;
begin
   TTDXManager(TDXManager).Get_Futures_Mins(StrPas (StkCode));
end;

procedure S_Get_QH_Mins (TDXManager: longword; CallBack :TOnDecodePacket_FUTURES_MINS); stdcall;
begin
   TTDXManager(TDXManager).OnDecodePacket_FUTURES_MINS  := CallBack;
end;

procedure R_Get_QH_Deals (TDXManager: longword; StkCode :PChar; startcount, count: integer); stdcall;
begin
   TTDXManager(TDXManager).Get_Furures_Deals(StrPas (StkCode), startcount, count);
end;
procedure S_Get_QH_Deals (TDXManager: longword; CallBack  :TOnDecodePacket_FUTURES_DEALS); stdcall;
begin
   TTDXManager(TDXManager).OnDecodePacket_FUTURES_DEALS := CallBack;
end;

Initialization

   Managers := TList.Create;
   TimerID  := SetTimer (0, 0, 100, @TimerProc);

finalization
   if TimerID <> 0 then
      KIllTimer (0, TimerID);
   ClearManagers;
   Managers.Free;
  

end.

