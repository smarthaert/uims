{/**********************************************************************
* 源程序名称: futu_data_types.h
* 软件著作权: 恒生电子股份有限公司
* 系统名称  : 06版本期货系统
* 模块名称  : 恒生期货周边接口
* 功能说明  : 周边接口常用数据类型定义
* 作    者  : xdx
* 开发日期  : 20110315
* 备    注  : 数据类型定义
* 修改人员  ：
* 修改日期  ：
* 修改说明  ：20110315 创建
20110701 luyj 修改单号20110603001 版本增加到V1.0.0.1
20110802 luyj 修改单号20110802006 版本增加到V1.0.0.2
20110809 luyj 修改单号20110808022 版本增加到V1.0.0.3
20110824 luyj 修改单号20110819035 版本增加到V1.0.0.4
20110913 luyj 修改单号20110913002 版本增加到V1.0.0.5
20111026 luyj 修改单号20111026001 版本增加到V1.0.0.6
20111027 luyj 修改单号20111103023 版本增加到V1.0.0.7
20111027 luyj 修改单号20111124003 版本增加到V1.0.0.8
20120207 luyj 修改单号20120207003 版本增加到V1.0.0.9
20120216 tangui 修改单号20120214036 版本增加到V1.0.0.10
20120216 tangui 修改单号20120214036 版本增加到V1.0.0.11
20120504 tangui 修改单号20120412046 版本增加到V1.0.0.12
20120512 tangui 修改单号20120509021 版本增加到V1.0.0.13
20120720 tanghui  修改单号20120515030 版本增加到V1.0.0.14
**********************************************************************/}
unit uFutuDataTypes;

interface

const
  //定义版本信息
  HSFUSDK_VERSION = $10000014;
  HSFUSDK_VERSTRING = 'V1.0.0.14';

  //定义连接服务类型
  SERVICE_TYPE_TRADE = 1; //交易服务
  SERVICE_TYPE_QUOTE = 2; //行情回报服务

  //定义消息类型
  MSG_TYPE_UNKNOWN = -1; //未知消息类型

  MSG_TYPE_USER_LOGIN = 100; //用户登录
  MSG_TYPE_USER_LOGOUT = 101; //UFT客户注销
  MSG_TYPE_CONFIRM_BILL = 102; //客户确认账单
  MSG_TYPE_CHECK_CONTRACT_CODE = 103; //检查合约代码(单腿)
  MSG_TYPE_CHECK_ENTRUST_PRICE = 104; //检查委托价格
  MSG_TYPE_NEW_SINGLE_ORDER = 105; //委托下单
  MSG_TYPE_CANCEL_ORDER = 106; //委托撤单
  MSG_TYPE_BANK_TRANSFER = 107; //银期转账
  MSG_TYPE_MODIFY_PASSWORD = 108; //客户修改密码

  //20110822 luyj 增加组合委托 修改单号:20110819035
  MSG_TYPE_CHECK_COMBIN_CODE = 109; //检查组合合约代码
  MSG_TYPE_NEW_COMBIN_ORDER = 110; //组合委托确认
  //20110822 end

  MSG_TYPE_GET_TRADING_CODE = 200; //交易编码查询
  MSG_TYPE_GET_PROFIT = 201; //期货客户资金权益查询
  MSG_TYPE_GET_HOLDSINFO = 202; //持仓查询
  MSG_TYPE_GET_ENTRUST_ORDERS = 203; //委托查询
  MSG_TYPE_GET_TRANS_DETAIL = 204; //成交明细查询
  MSG_TYPE_GET_FUNDJOUR = 205; //历史资金流水查询
  MSG_TYPE_GET_FUND_HISTRANSJOUR = 206; //查历史转账流水
  MSG_TYPE_GET_BANK_ACCOUNT = 207; //银行账号查询
  MSG_TYPE_GET_BANK_TRANSJOUR = 208; //银期转账流水查询
  MSG_TYPE_GET_BANKBALA = 209; //银行账户余额查询
  MSG_TYPE_GET_MARKET_DATA = 210; //期货行情查询
  MSG_TYPE_GET_MARGIN = 211; //合约保证金查询
  MSG_TYPE_GET_FUTU_BANKINFO = 212; //期货登记银行信息查询
  MSG_TYPE_GET_EXCH_TIME = 213; //交易所时间差查询
  MSG_TYPE_GET_FMMC_PWD = 214; //监控中心结算单系统密码查询
  MSG_TYPE_GET_BILL = 215; //结算单查询
  MSG_TYPE_GET_HIS_ENTRUST = 216; //历史委托查询
  MSG_TYPE_GET_HIS_BUSINESS = 217; //历史成交查询
  MSG_TYPE_GET_HIS_FUND = 218; //历史资金查询
  MSG_TYPE_UFT_ORDERHSACK = 219; //委托反馈
  MSG_TYPE_UFT_ORDEREXACK = 220; //成交反馈

  //20110822 luyj 增加组合委托相关查询(06) 修改单号:20110819035
  MSG_TYPE_GET_COMBIN_CODE = 221; //查询组合代码
  MSG_TYPE_GET_COMBIN_QUOTE = 222; //查询组合行情
  MSG_TYPE_CHECK_PWD = 223; //校验密码
  //20110822 end

  //20120426 tanghui 增加单客户查费用属性和保证金属性 修改单:20120412046
  MSG_TYPE_GET_FEE_PROPERTY = 224; //UFT客户查询费用属性
  MSG_TYPE_GET_MARGIN_PROPERTY = 225; //UFT客户查询保证金属性

type
  //定义Integer指针
  PInteger = ^Integer;
  //订阅类型
  REGType =
    (
    UnKnownType = -1, // 未知类型
    SingleCode = 0, // 单腿行情
    RspReport = 1, // 委托回报
    CombinCode = 2, // 组合行情
    OnlineMsg = 3 // 在线消息
    );

  //订阅动作
  REGAction =
    (
    UnKnownAction = -1, // 未知动作
    Subscription = 0, // 订阅刷新(主要指行情)或者指示不是退订
    CxlAll = 1, // 取消全部的订阅
    CxlFlag = 2, // 根据制定类型订阅
    Snapshot = 3 // 查询快照(主要指行情)
    );

  //连接的状态
  CONState =
    (
    Uninitialized = -1, // 连接未初始化
    Disconnected = $0000, // 未连接
    Connecting = $0001, // socket正在连接
    Connected = $0002, // socket已连接
    SafeConnecting = $0004, // 正在建立安全连接
    SafeConnected = $0008, // 已建立安全连接
    Registering = $0010, // 正注册
    Registered = $0020, // 已注册
    Rejected = $0040 // 被拒绝,将被关闭
    );

  //定义消息模式(FUTU_MSG_MODE定义)
  FUTU_MSG_MODE =
    (
    MSG_MODE_UNKNOWN = -1, //未知消息模式
    MSG_MODE_REQUEST = 0, //表示是请求消息
    MSG_MODE_ANSWER = 1 //表示是应答消息
    );

  //为兼容性统一以4字节对齐,否则有数据对齐的问题
{$A4}
  // 单腿行情
  LPCMarketInfo = ^CMarketInfo;
  CMarketInfo = record
    contract_code: array[0..12] of Char; //0 合约代码,
    pre_square_price: Double; //1 昨日交割结算价
    futu_open_price: Double; //2 开盘价
    futu_last_price: Double; //3 最新价格
    buy_high_price: Double; //4 最高买入价
    buy_high_amount: Integer; //5 最高买入价买量
    buy_total_amount: Integer; //6 全部买量
    sale_low_price: Double; //7 最低卖价价格
    sale_low_amount: Integer; //8 最低卖价卖量
    sale_total_amount: Integer; //9 全部卖量
    futu_high_price: Double; //10 最高价
    futu_low_price: Double; //11 最低价
    average_price: Double; //12 均价
    change_direction: Double; //13 趋势
    business_amount: Integer; //14 成交量
    bear_amount: Integer; //15 总持量
    business_balance: Double; //16 成交额
    uplimited_price: Double; //17 涨停板
    downlimited_price: Double; //18 跌停板
    futu_exch_type: array[0..2] of Char; //19 交易类别
    form_buy_price: Double; //20 组合买入价格
    form_sale_price: Double; //21 组合卖出价格
    form_buy_amount: Integer; //22 组合买入数量
    form_sale_amount: Integer; //23 组合卖出数量
    pre_close_price: Double; //24 昨日收盘价
    pre_open_interest: Double; //25 昨日空盘量
    futu_close_price: Double; //26 今日收盘价
    square_price: Double; //27 结算价
    pre_delta: Double; //28 昨日虚实度
    curr_delta: Double; //29 今日虚实度
    bid_price2: Double; //30 买二价
    bid_volume2: Integer; //31 买二量
    bid_price3: Double; //32 买三价
    bid_volume3: Integer; //33 买三量
    bid_price4: Double; //34 买四价
    bid_volume4: Integer; //35 买四量
    bid_price5: Double; //36 买五价
    bid_volume5: Integer; //37 买五量
    ask_price2: Double; //38 卖二价
    ask_volume2: Integer; //39 卖二量
    ask_price3: Double; //40 卖三价
    ask_volume3: Integer; //41 卖三量
    ask_price4: Double; //42 卖四价
    ask_volume4: Integer; //43 卖四量
    ask_price5: Double; //44 卖五价
    ask_volume5: Integer; //45 卖五量
  end;

  // 组合行情
  LPCArgMarketInfo = ^CArgMarketInfo;
  CArgMarketInfo = record
    arbicontract_id: array[0..30] of Char; //0 套利合约号
    futu_exch_type: array[0..2] of Char; //1 交易类别
    first_code: array[0..12] of Char; //2 第一腿
    second_code: array[0..12] of Char; //3 第二腿
    arbi_type: Char; //4 组合类型1-SPD, 2 -IPS
    buy_price: Double; //5 最高买入价
    buy_amount: Integer; //6 最高买入价买量
    buy_total_amount: Integer; //7 全部买量
    sale_price: Double; //8 最低卖价价格
    sale_amount: Integer; //9 最低卖价卖量
    sale_total_amount: Integer; //10 全部卖量
    futu_high_price: Double; //11 最高价
    futu_low_price: Double; //12 最低价
    uplimited_price: Double; //13 涨停板价格
    downlimited_price: Double; //14 跌停板价格
  end;

  //委托反馈信息
  LPCOrderRspInfo = ^COrderRspInfo;
  COrderRspInfo = record
    entrust_no: Integer; //0 委托号
    futures_account: array[0..20] of Char; //1 交易编码
    futu_exch_type: array[0..10] of Char; //2 交易所类别
    contract_code: array[0..12] of Char; //3 合约代码
    entrust_bs: array[0..8] of Char; //4 买卖标识
    entrust_direction: array[0..8] of Char; //6 开平标识
    hedge_type: array[0..8] of Char; //7 套保标识
    fund_account: Integer; //8 资金账户
    futu_report_no: array[0..20] of Char; //9 本地单号
    firm_no: array[0..8] of Char; //10 会员号
    operator_no: array[0..8] of Char; //11 操作员号
    client_group: Integer; //12 客户类别
    entrust_amount: Integer; //13 委托数量
    business_total_amount: Integer; //14 成交总数量
    cacel_amount: Integer; //15 撤单数量
    entrust_price: Double; //16 委托价格
    entrust_status: Char; //17 委托状态
    branch_no: Integer; //18 营业部号
    batch_no: Integer; //19 委托批号
    futu_entrust_type: Char; //20 委托类型
    amount_per_hand: Integer; //21 合约称数
    forceclose_reason: Char; //22 强平原因
    init_date: Integer; //23 交易日期
    curr_time: Integer; //24 当前时间
    confirm_no: array[0..20] of Char; //25 主场单号
    weave_type: Integer; //26 组合委托类型
    arbitrage_code: array[0..20] of Char; //27 组合委托类型
    time_condition: Integer; //28 有效期类型
    volume_condition: Integer; //29 成交量类型
    futu_entrust_prop: Integer; //30 期货委托属性
    frozen_fare: Double; //31 冻结总费用
    //20120428 tanghui 委托反馈和成交反馈增加错误信息字段 修改单:20120412049
    error_message: array[0..254] of Char; //32 错误信息
  end;

  //成交反馈信息
  LPCRealRspInfo = ^CRealRspInfo;
  CRealRspInfo = record
    entrust_no: Integer; //0 委托号
    futures_account: array[0..20] of Char; //1 交易编码
    futu_exch_type: array[0..10] of Char; //2 交易所类别
    business_no: array[0..20] of Char; //3 成交编号
    contract_code: array[0..12] of Char; //4 合约代码
    entrust_bs: array[0..8] of Char; //5 买卖标识
    entrust_direction: array[0..8] of Char; //6 开平标识
    business_price: Double; //7 成交价格
    business_amount: Double; //8 成交数量
    hedge_type: array[0..8] of Char; //9 套保标识
    fund_account: Integer; //10 资金账户
    futu_report_no: array[0..20] of Char; //11 本地单号
    firm_no: array[0..8] of Char; //12 会员号
    operator_no: array[0..8] of Char; //13 操作员号
    client_group: Integer; //14 客户类别
    entrust_amount: Integer; //15 委托数量
    business_total_amount: Integer; //16 成交总数量
    cacel_amount: Integer; //17 撤单数量
    entrust_price: Double; //18 委托价格
    entrust_status: Char; //19 委托状态
    branch_no: Integer; //20 营业部号
    batch_no: Integer; //21 委托批号
    futu_entrust_type: Char; //22 委托类型
    amount_per_hand: Integer; //23 合约称数
    forceclose_reason: Char; //24 强平原因
    init_date: Integer; //25 交易日期
    business_time: Integer; //26 成交时间
    confirm_no: array[0..20] of Char; //27 主场单号
    frozen_fare: Double; //28 冻结总费用
    //20120428 tanghui 委托反馈和成交反馈增加错误信息字段 修改单:20120412049
    error_message: array[0..254] of Char; //29 错误信息
  end;
{$A8}
implementation

end.
