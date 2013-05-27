unit TDXGrobal;

interface
uses SysUtils, Classes, Windows, Messages;

{
通达信实时行情接收控件
    renshouren
WEB     :http://renshou.net
E-MAIL  :lxy@renshou.net
QQ      :114032666
TEL     :13118369704

2010.02.28

---------------------------------------- 更新日志
提示：
   DLL 版本请使用 LoadLibrary 函数动态读入
   
2010.10.27
   增加对股指期货数据的支持
   Get_Futures_KDays() 获取股指期货日K线图
   Get_Furures_Deals() 获取股指期货分笔交易
   Get_Futures_Mins()  实时成交
   Get_TestRealFutures() 实时盘口，发送命令后，服务器将在10秒内主动返回实时盘口变化
   DLL 版本增加回调函数调用方式，各函数的 Delphi 版本声明请参考 uFunctions.pas


}

//{$DEFINE _IS_NOT_DELPHI_}     //For DLL 版本，若为 DELPHI 组件版本则注释掉本行

Const
   MARKET_SZ        = 0;       //深圳市场编号
   MARKET_SH        = 1;       //上海市场编号

   MARKETS_COUNT    = 2;

   FMarketNames    :array[0..MARKETS_COUNT-1] of string = ('深圳', '上海');
   FMarketCodes    :array[0..MARKETS_COUNT-1] of string = ('SZ', 'SH');




{
=====================================================
dll 工作模式 时，向调用窗口返回的消息
======================================================
}
   //接收到解码数据   ==>>必须响应[SendMessage]  wParam = 数据类型 lParam = 具体数据内容 （TTdxDllShareData)
   WM_TDX_DEPACKDATA = WM_USER + $111;


   //接收到事件通知   ==>>可以不响应[PostMessage] wParam = 事件代码 lParam = 工作线程(TDXManager)
   WM_TDX_NOTIFYEVENT = WM_USER +$110;


   {-------------------------
   WM_TDX_DEPACKDATA 消息的 wParam 参数，根据此参数的不同, lParam 表示的 PTTdxDllShareData.buf 分别对应不同的数据结构
   ----------------------------
   }
   TDX_MSG_TESTREALPK     = $526;       //实时更新盘口,查询是否有最新变化
   TDX_MSG_GETPK          = $53E;       // 盘口
   TDX_MSG_GET_K_DAY      = $529;       //获得日K线   $52C
   TDX_MSG_GET_MINS       = $51D;       //分时图
   TDX_MSG_GET_DEALS      = $FC5;       //分笔数据
   TDX_MSG_INITDATA       = $450;       //获得市场初始化数据
   TDX_MSG_GET_BASEINFO   = $1E;
   TDX_MSG_GET_BASEINFO_  = $0D;
   TDX_MSG_GET_F10        = $2CF;       //获得F10项目列表
   TDX_MSG_GET_F10TXT     = $2D0;       //获得单个项目内容

   //股指期货
   TDX_MSG_GET_FUTURES_INITMARKETS  = $23F4; //获得期货市场初始化数据
   TDX_MSG_GET_FUTURES    = $23FB;      //期货盘口         Size=$12C
   TDX_MSG_GET_FUTURES_DEALS  =$23FC;   //分笔
   TDX_MSG_GET_FUTURES_MINS  = $23FD;    //分时图
   TDX_MSG_GET_FUTURES_KDAY = $23FF;    //日K
   TDX_MSG_GET_FUTURES_PK = $2400;      //获得盘口数据     Size=$12C


   {--------------------
   WM_TDX_NOTIFYEVENT 消息 的 wParam 参数
   ----------------------
   }
   TNE_CONNECTED           = 1;                        //某工作线程已连接到服务器
   TNE_ERROR               = -1;
   TNE_BEFOREDEPACKDATA    = 2;                        //在接收到任何数据，并且在未开始进行解码操作时
   TNE_AFTERDEPACKDATA     = 3;                        //在接收到任何数据，并且在解码操作完成后
   TNE_DISCONNECTED        = 4;                        //某工作线程已从服务器断开连接

type

   //2011.09.18 K线类型
   TKLineDateMode   = (
      KD_MIN,  KD_MIN5, KD_MIN10,  KD_MIN15, KD_MIN30, KD_MIN60,
      KD_DAY,  KD_WEEK, KD_MONTH,  KD_DAY45, KD_DAY120,
      KD_YEAR);
Const
   KLineDateModeStr : array[KD_MIN..KD_YEAR] of string =
    (
    '1分钟',
    '5分钟',
    '10分钟',
    '15分钟',
    '30分钟',
    '60分钟',
    '日线',
    '周线',
    '月线',
    '45日线',
    '季线',
    '年线');
type

  TTDX_MSG = record
      MsgID :integer;
      Code  :array[0..1023] of char;                   //获取盘口数据时，有可能是多个股票的代码字符串
      Name  :array[0..1023] of char;
      Market:integer;
      Date  :TDateTime;
      P1, P2, P3  :integer;
   end;
   pTTDX_MSG  =^TTDX_MSG;
   
  //PTTDX_STOCKINFO = ^TTDX_STOCKINFO;
  TTDX_STOCKINFO = packed record    //初始化数据 29字节
     code :array[0..5] of char;
     rate :word;                    //实时盘口中的成交量除去的除数？1手=n股？
     Name :array[0..7] of char;     //4个汉字
     W1, W2 :Word;
     PriceMag :byte;                //价格转换模式 10的n次方
     YClose  :single;
     W3, W4  :Word;
  end;
  PTTDX_STOCKINFO = ^TTDX_STOCKINFO;


  TF10Data = record                 //F10数据
      Title :array [0..31] of char;
      tmp1 :array [ 0..31] of byte;
      FilePath  :array [0..9] of char;  //$40
      tmp2  :array [0..5] of byte;
      tmp3  :array [0..$3F] of byte;
      Offset  :integer;                 //$90
      length  :integer;                 //$94
   end;

   TF10Rcd  = record
      Data  :TF10Data;
      index: integer;
   end;
   PTF10Rcd = ^TF10Rcd;



  TTDX_PK_ADD = packed record
      tmp9E   :byte;
      tmp9F   :single;
      tmpA3, tmpA7, tmpAB :single;
      tmpAF   :word;
  end;
  //盘口数据
  //pTTDX_PKDAT = ^TTDX_PKDAT;     //size=
  TTDX_PKBASE = packed record
      MarketMode  :byte;   //市场
      code  :array[0..5] of char;
      tmp7  :byte;
      DealCount  :word;   //成交笔数
      tmpA  :word;
      YClose  :Single;   //昨收盘价
      Open    :Single;   //开盘价
      High    :single;
      Low     :Single;
      Close   :Single;   //现价
      LastDealTime  :longword;
      tmp24  :Single;
      Volume  :longword;  //成交量
      LastVolume  :longword; //最后一笔单子成交量
      Amount  :Single;     //金额
      Inside, OutSide  :longword;
      tmp3C   : single;
      tmp40   : single;//市赢率？
      Buyp    : array[1..5] of Single;	 //五个叫买价    $3C+8
      Buyv    : array[1..5] of LongWord;	   //对应五个叫买价的五个买盘   $50+8
      Sellp   : array[1..5] of Single;	 //五个叫卖价
      Sellv   : array[1..5] of LongWord;	   //对应五个叫卖价的五个卖盘
      tmp94   :word;
      tmp96   :Longword;
      tmp9A   :LongWord;
      //DatEx   :TTDX_PK_ADD;
  end;
  PTTDX_PKBASE =^TTDX_PKBASE;

  TTDX_PKDAT = packed record
     D: TTDX_PKBASE;
     DEx  :TTDX_PK_ADD;
  end;
  PTTDX_PKDAT =^TTDX_PKDAT;


  TTDX_REALPK_ADD = packed record
     tmp9E    :array[1..5] of longword;
     tmpB2    :array[1..5] of longword;
     tmpC6    :array[1..5] of Single;
     tmpDA    :array[1..5] of longword;
  end;

  //实时盘口数据
  TTDX_REALPKDAT = packed record
     PK :TTDX_PKBASE;
     DatEx  :TTDX_REALPK_ADD;
     tmpEE, tmpF2  :Single;
     tmpF6, tmpFA  :longword;
  end;

  //期货
  TTDX_FUTURES_PK  = packed record   //Size=$12C
     Code :array[0..7] of char;      //代码
     tmp8 :word;
     tmpA :longword;
     YClose,                     //昨收盘价
     Open,                       //开盘价
     High,                       //最高价
     Low,                        //最低价
     Close :single;              //当前价
     InSide  :longword;          //开仓
     OutSide  :longword;
     Volume  :longword;          //总量 $2A
     tmp2E  :longword;           //=1
     Amount  :single;             //金额
     tmp36  :longword;
     tmp3A  :longword;
     tmp3E  :longword;            //=0
     ChiCang  :longword;          //持仓
     Buyp    : array[1..5] of Single;	 //五个叫买价
     Buyv    : array[1..5] of LongWord;	   //对应五个叫买价的五个买盘
     Sellp   : array[1..5] of Single;	 //五个叫卖价
     Sellv   : array[1..5] of LongWord;	   //对应五个叫卖价的五个卖盘
     
     {tmp96, tmp9A, tmp9E, tmpA2,
     tmpA6, tmpAA, tmpAE, tmpB2 :longword;
      tmpB6, tmpBA, tmpBE, tmpC2,
     tmpC6, tmpCA, tmpCE, tmpD2, tmpD6, tmpDA, tmpDE, tmpE2,
     tmpE6, tmpEA, tmpEE, tmpF2, tmpF6, tmpFA, tmpFE, tmp102,
     tmp106, tmp10A, tmp10E, tmp112, tmp116, tmp11A, tmp11E, tmp122,
     tmp126 :longword;
     tmp12A :word; }
     tmp96  :array[0..$12C-$96-1] of byte;

  end;
  PTTDX_FUTURES_PK =^TTDX_FUTURES_PK;

  TTDX_Futures_DAYInfo  = packed record   //size=$20
     DAY  :longword;//  20100920格式
     Open, High, Low, Close :Single;     //开盘 最高 最低 收盘
     ChiCang  :longword; //持仓
     Volume :longword;  //成交
     settlement :single; //结算
  end;
  PTTDX_Futures_DAYInfo =^TTDX_Futures_DAYInfo;

  //日K线数据
  TTDX_DAYInfo = packed record
      DAY   :longword;    //在代码中为tmp1C
      Open  :Single;      //开盘
      High  :Single;      //最高
      Low   :Single;      //最低
      Close :Single;      //收
      Amount:Single;     //金额
      Volume  :longword;//成交量
      UpCount :word;
      DownCount :word;
  end;
  PTTDX_DAYInfo =^ TTDX_DAYInfo;
  

  //分笔历史成交数据
  TTDX_DEALInfo = packed record
      Min   :word;   //h *60 + Min
      value  :longword;   //价格*1000
      Volume  :longword;  //成交量
      DealCount  :Integer;  //成交笔数
      SellOrBuy  :word; //Sell=1 buy=0
  end;
  PTTDX_DEALInfo =^TTDX_DEALInfo;

  TTDX_Futures_DEALInfo = packed record
      Min   :word;   //h *60 + Min
      value  :longword;   //价格*1000
      Volume  :longword;  //现量
      DealCount  :Integer;  //增仓
      DealType  :word; //
  end;
  PTTDX_Futures_DEALInfo =^TTDX_Futures_DEALInfo;

  TTDX_MIN = packed record  //size=$1A 分时图
      Min  :word;
      Close  :single;
      Arg   :single;     //均价
      Volume  :integer;  //成交量
      tmpE  :longword;
      tmp12 :longword;
      tmp16 :single;
  end;
  PTTDX_MIN = ^TTDX_MIN;

  TTDX_FUTURES_MIN  = packed record  //Size=$1A
      Min  :word;
      Close  :single;
      Arg   :single;     //均价
      Volume  :integer;  //成交量
      tmpE  :longword;
      tmp12 :longword;
      ChiCang :longword;
  end;
  PTTDX_FUTURES_MIN =^TTDX_FUTURES_MIN;

  
  TCallBackStockInfo = packed record   //回调数据触发函数时提供信息
      Code  :array[0..5] of char;
      Name  :array[0..7] of char;
      Market  :Word;
   end;


   //========================== Dll 模式使用
   TTdxDllShareData = packed record
      stockinfo :TCallBackStockInfo;
      start :integer;
      count :integer;
      buf :array[0..256*256-1] of char;
   end;
   PTTdxDllShareData = ^TTdxDllShareData;

   TWM_TDX_DEPACKDATA = record
      Msg: Cardinal;
      TDX_MSG :longint;
      Data  :PTTdxDllShareData;
      Result  :longint;
   end;

   TWM_TDX_NOTIFYEVENT  = record
      Msg: Cardinal;
      EventCode :longint;
      TDXManager  :longint;
      Result  :longint;
   end;




//----------------------------------

   TTdxDataHeader = packed record
      CheckSum  :longword; //
      EncodeMode  :byte;
      tmp :array[0..4] of byte;
      MsgID :word;      //消息代码
      Size  :word;     //本次读取的数据包长度
      DePackSize :word;   //解压后的大小
   end;

   TTdxSendHeader = packed record
      CheckSum  :byte; //$0C
      tmp   :array[0..4] of byte;
      Size  :word;
      Size2 :word;
      //..下面2个字节就是发送的消息ID
   end;

   TTdxData = record
      Len :word;
      buf :array[0..256*256+SizeOf(TTdxDataHeader)-1] of char;
   end;
   pTTdxData  =^ TTdxData;

   TTdxDepackData = record
      Head  :TTdxDataHeader;
      buf :array[0..256*256-1] of char;
   end;



   //事件定义

   {$IFDEF _IS_NOT_DELPHI_}

   TOnReadTDXStockDataEvent = procedure(Const pData: pTTdxData)of object; stdcall;
   TRNotifyEvent = procedure (Sender: TObject) of object; stdcall;
   TOnAfterReadDataEvent        = procedure (Msg: TTDX_MSG) of object; stdcall;
   //TOnDecodePacket    = procedure (Sender: TObject; Const MSG_ID: integer; Const pData: pTTdxData; pDeBuffer: PChar)of object; stdcall;
   TOnDecodePacket_PKDAT    = procedure (Msg: TTDX_MSG; data: array of TTDX_PKDAT; StockCount: integer)of object; stdcall;
   TOnDecodePacket_FUTURES_PKDAT    = procedure (data: array of TTDX_FUTURES_PK; StockCount: integer)of object;stdcall;
   TOnDecodePacket_REALPK   = procedure (data: TTDX_REALPKDAT) of object; stdcall;
   TOnDecodePacket_DAYS    = procedure (StockInfo: TCallBackStockInfo; data: array of TTDX_DAYInfo; start, daysCount: integer)of object; stdcall;
   TOnDecodePacket_FUTURES_DAYS    = procedure (StockInfo: TCallBackStockInfo; data: array of TTDX_FUTURES_DAYInfo; start, daysCount: integer)of object; stdcall;
   TOnDecodePacket_DEALS    = procedure (StockInfo: TCallBackStockInfo; data: array of TTDX_DEALINFO; start, Count: integer)of object; stdcall;
   TOnDecodePacket_FUTURES_DEALS    = procedure (StockInfo: TCallBackStockInfo; data: array of TTDX_FUTURES_DEALINFO; start, Count: integer)of object; stdcall;
   TOnDecodePacket_MINS     = procedure (StockInfo: TCallBackStockInfo; data: array of TTDX_MIN; start, Count: integer) of object; stdcall;
   TOnDecodePacket_FUTURES_MINS     = procedure (StockInfo: TCallBackStockInfo; data: array of TTDX_FUTURES_MIN; Count: integer) of object; stdcall;
   TOnDecodePacket_INITMARKET    = procedure (data: array of TTDX_STOCKINFO; Market: byte; Count: integer)of object; stdcall;
   TErrorMessageEvent = procedure(Const ErrMsg: string; Const ErrCode: integer; var boStopUnPacket: boolean)of object; stdcall;
   {$ELSE}
   TOnReadTDXStockDataEvent = procedure(Const pData: pTTdxData)of object;
   TRNotifyEvent = procedure (Sender: TObject) of object;
   TOnAfterReadDataEvent        = procedure (Msg: TTDX_MSG) of object;
   //TOnAfterReadDataEvent        = procedure (lastMsg: TTDX_MSG) of object;
   //TOnDecodePacket    = procedure (Sender: TObject; Const MSG_ID: integer; Const pData: pTTdxData; pDeBuffer: PChar)of object; stdcall;
   TOnDecodepacket_F10      = procedure (Msg: TTDX_MSG; data: array of TF10Rcd; count: integer) of object;
   TOnDecodePacket_F10TXT   = procedure (Msg: TTDX_MSG; memory: TMemoryStream) of object;
   TOnDecodePacket_PKDAT    = procedure (Msg: TTDX_MSG; data: array of TTDX_PKDAT; StockCount: integer)of object;
   TOnDecodePacket_FUTURES_PKDAT    = procedure (data: array of TTDX_FUTURES_PK; StockCount: integer)of object;
   TOnDecodePacket_REALPK   = procedure (data: TTDX_REALPKDAT) of object;
   TOnDecodePacket_DAYS    = procedure (Msg: TTDX_MSG; data: array of TTDX_DAYInfo; start, daysCount: integer)of object;
   TOnDecodePacket_FUTURES_DAYS    = procedure (StockInfo: TCallBackStockInfo; data: array of TTDX_FUTURES_DAYInfo; start, daysCount: integer)of object;
   TOnDecodePacket_DEALS    = procedure (Msg: TTDX_MSG; data: array of TTDX_DEALINFO; start, Count: integer)of object;
   TOnDecodePacket_FUTURES_DEALS    = procedure (StockInfo: TCallBackStockInfo; data: array of TTDX_FUTURES_DEALINFO; start, Count: integer)of object;
   TOnDecodePacket_MINS     = procedure (Msg: TTDX_MSG; data: array of TTDX_MIN; start, Count: integer) of object;
   TOnDecodePacket_FUTURES_MINS     = procedure (StockInfo: TCallBackStockInfo; data: array of TTDX_FUTURES_MIN; Count: integer) of object;
   TOnDecodePacket_INITMARKET    = procedure (data: array of TTDX_STOCKINFO; Market: byte; Count: integer)of object;
   TErrorMessageEvent = procedure(Const ErrMsg: string; Const ErrCode: integer; var boStopUnPacket: boolean)of object;
   {$ENDIF}


implementation

end.
