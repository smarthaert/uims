unit Cmpp20;

interface


const
  CMPP_VERSION = $20;
  CMPP_CONNECT = $00000001; //  CP 或SMGW 登录请求
  CMPP_CONNECT_RESP = $80000001;
  CMPP_TERMINATE = $00000002;
  CMPP_TERMINATE_RESP = $80000002;
  CMPP_SUBMIT = $00000004;
  CMPP_SUBMIT_RESP = $80000004;
  CMPP_DELIVER = $00000005;
  CMPP_DELIVER_RESP = $80000005;
  CMPP_QUERY = $00000006;
  CMPP_QUERY_RESP = $80000006;
  CMPP_CANCEL = $00000007;
  CMPP_CANCEL_RESP = $80000007;
  CMPP_ACTIVE_TEST = $00000008;
  CMPP_ACTIVE_TEST_RESP = $80000008;
  CMPP_FWD = $00000009;
  CMPP_FWD_RESP = $80000009;
  CMPP_MT_ROUTE = $00000010;
  CMPP_MT_ROUTE_RESP = $80000010;
  CMPP_MO_ROUTE = $00000011;
  CMPP_MO_ROUTE_RESP = $80000011;
  CMPP_GET_ROUTE = $00000012;
  CMPP_GET_ROUTE_RESP = $80000012;
  CMPP_MT_ROUTE_UPDATE = $00000013;
  CMPP_MT_ROUTE_UPDATE_RESP = $80000013;
  CMPP_MO_ROUTE_UPDATE = $00000014;
  CMPP_MO_ROUTE_UPDATE_RESP = $80000014;
  CMPP_PUSH_MT_ROUTE_UPDATE = $00000015;
  CMPP_PUSH_MT_ROUTE_UPDATE_RESP = $80000015;
  CMPP_PUSH_MO_ROUTE_UPDATE = $00000016;
  CMPP_PUSH_MO_ROUTE_UPDATE_RESP = $80000016;

  CMPP_REPORT: LongWord = $00000050; //CMPP协议中没有此信息，为了区分CMPP_DELIVER包

  MSG_LENGTH = 140; //短信内容长度
  //Queue_Max_Length = 1000; //队列的最大长度

  //Connect 返回值
  ERR_CONNECT_SUCCESS = $00; //连接正确
  ERR_CONNECT_BODY = $01; //结构体错误
  ERR_CONNECT_INVALID_SP_ID = $02; //非法SP ID
  ERR_CONNECT_SP_AUTHENTICATION = $03; //SP认证错
  ERR_CONNECT_VERSION = $04; //版本太高

  //Submit 返回值
  ERR_SUBMIT_SUCCESS = $00; //成功
  ERR_SUBMIT_BODY = $01; //结构体错
  ERR_SUBMIT_COMMAND = $02; //命令错
  ERR_SUBMIT_MSG_ID = $03; //流水号重复
  ERR_SUBMIT_MSG_LENGTH = $04; //消息长度错
  ERR_SUBMIT_FEE_CODE = $05; //资费代码错
  ERR_SUBMIT_TO_LONG = $06; //信息太长
  ERR_SUBMIT_SERVICE_ID = $07; //业务代码错
  ERR_SUBMIT_FLOW_CONTROL = $08; //流量控制错

  //Deliver 返回值
  ERR_DELIVER_SUCCESS = $00; //成功
  ERR_DELIVER_BODY = $01; //结构体错
  ERR_DELIVER_COMMAND = $02; //命令错
  ERR_DELIVER_MSG_ID = $03; //流水号重复
  ERR_DELIVER_MSG_LENGTH = $04; //消息长度错
  ERR_DELIVER_FEE_CODE = $05; //资费代码错
  ERR_DELIVER_TO_LONG = $06; //信息太长
  ERR_DELIVER_SERVICE_ID = $07; //业务代码错
  ERR_DELIVER_FLOW_CONTROL = $08; //流量控制错

  //Cancel 返回值
  ERR_CANCEL_SUCCESS = $00; //成功
  ERR_CANCEL_FAULT = $01; //失败

  //Active 返回值
  ERR_ACTIVE_SUCCESS = $00; //成功
type
  ////////////////////////////////////////////////////////////////////////////
  TCMPPPhoneNum = array[0..20] of char;
  TEmpty = record //空纪录
  end;

  //数据包包头定义
  //消息头
  TCMPP_HEAD = packed record
    Total_Length: LongWord; //消息总长度(含消息头及消息体)
    Command_ID: LongWord; //命令或响应类型
    Sequence_ID: LongWord; //消息流水号,顺序累加,步长为1,循环使用（一对请求和应答消息的流水号必须相同）
  end;

  //登录包包体定义
  // SP 请求连接到 ISMG
  TCMPP_CONNECT = packed record
    Source_Addr: array[0..5] of char; //源地址，此处为SP_Id，即SP的企业代码。
    AuthenticatorSource: array[0..15] of char; //用于鉴别源地址。其值通过单向MD5 hash计算得出，表示如下：AuthenticatorSource =MD5（Source_Addr+9 字节的0 +shared secret+timestamp）Shared secret 由中国移动与源地址实体事先商定，timestamp格式为：MMDDHHMMSS，即月日时分秒，10位。
    Version: byte; //双方协商的版本号(高位4bit表示主版本号,低位4bit表示次版本号)
    TimeStamp: LongWord; //时间戳的明文,由客户端产生,格式为MMDDHHMMSS，即月日时分秒，10位数字的整型，右对齐 。
    //Timestamp:  Cardinal; //时间戳的明文,由客户端产生,格式为MMDDHHMMSS，即月日时分秒，10位数字的整型，右对齐 。
  end;

  //登录应答包包体定义
  TCMPP_CONNECT_RESP = packed record
    Status: byte; //状态0：正确1：消息结构错 2：非法源地址 3：认证错 4：版本太高  5~ ：其他错误
    AuthenticatorISMG: array[0..15] of char; //ISMG认证码，用于鉴别ISMG。其值通过单向MD5 hash计算得出，表示如下：AuthenticatorISMG =MD5（Status+AuthenticatorSource+shared secret），Shared secret 由中国移动与源地址实体事先商定，AuthenticatorSource为源地址实体发送给ISMG的对应消息CMPP_Connect中的值。 认证出错时，此项为空
    Version: byte; //服务器支持的最高版本号
  end;

  // SP 或 ISMG 请求拆除连接
  TCMPP_TERMINATE_tag = TEmpty;

  TCMPP_TERMINATE_RESP_tag = TEmpty;

  //下行消息包包体定义
  // SP 向 ISMG 提交短信
  TCMPP_SUBMIT = packed record
    Msg_Id: Int64; //信息标识，由SP侧短信网关本身产生，本处填空。
    Pk_total: byte; //相同Msg_Id的信息总条数，从1开始
    Pk_number: byte; //相同Msg_Id的信息序号，从1开始
    Registered_Delivery: byte; //是否要求返回状态确认报告：0：不需要1：需要2：产生SMC话单 （该类型短信仅供网关计费使用，不发送给目的终端)
    Msg_level: byte; //信息级别
    service_id: array[0..9] of char; //业务类型，是数字、字母和符号的组合。
    Fee_UserType: byte; //计费用户类型字段0：对目的终端MSISDN计费；1：对源终端MSISDN计费；2：对SP计费;3：表示本字段无效，对谁计费参见Fee_terminal_Id字段。
    //Fee_terminal_Id: array[0..20] of Char; //被计费用户的号码（如本字节填空，则表示本字段无效，对谁计费参见Fee_Userstruct字段，本字段与Fee_Userstruct字段互斥）
    Fee_terminal_Id: TCMPPPhoneNum;
    TP_pId: byte; //GSM协议类型。详细是解释请参考GSM03.40中的9.2.3.9
    TP_udhi: byte; //GSM协议类型。详细是解释请参考GSM03.40中的9.2.3.23,仅使用1位，右对齐
    Msg_Fmt: byte; //信息格式  0：ASCII串  3：短信写卡操作  4：二进制信息  8：UCS2编码15：含GB汉字
    msg_src: array[0..5] of char; //信息内容来源(SP_Id)
    FeeType: array[0..1] of char; //资费类别01：对"计费用户号码"免费
    FeeCode: array[0..5] of char; //资费代码（以分为单位）
    Valid_Time: array[0..16] of char; //存活有效期，格式遵循SMPP3.3协议
    At_Time: array[0..16] of char; //定时发送时间，格式遵循SMPP3.3协议
    //Src_Id: array[0..20] of Char; //源号码SP的服务代码或前缀为服务代码的长号码, 网关将该号码完整的填到SMPP协议Submit_SM消息相应的source_addr字段，该号码最终在用户手机上显示为短消息的主叫号码
    Src_ID: TCMPPPhoneNum; //源号码SP的服务代码或前缀为服务代码的长号码, 网关将该号码完整的填到SMPP协议Submit_SM消息相应的source_addr字段，该号码最终在用户手机上显示为短消息的主叫号码
    DestUsr_tl: byte; //接收信息的用户数量(小于100个用户)
    //Dest_terminal_Id: array[0..20] of Char; //接收短信的MSISDN号码
    dest_terminal_id: TCMPPPhoneNum; //接收短信的MSISDN号码
    MSG_LENGTH: byte; //信息长度(Msg_Fmt值为0时：<160个字节；其它<=140个字节)
    Msg_Content: array[0..MSG_LENGTH - 1] of char; //信息内容
    Reserve: array[0..7] of char; //保留
  end;

  //下行消包应答包包体定义
  TCMPP_SUBMIT_RESP = packed record
    Msg_Id: Int64; //信息标识
    result: byte; //结果
  end;

  //上行包包体定义
  // ISMG 向 SP 送交短信
  // 由于在CMPP中，DELIVER和REPORT同一个命令号，所以读包体中也分两步,即先读前
  // 部份，再从Msg_Length和Registered_Delivery中判断剩余长度和内容
  TCMPP_DELIVER_HEAD = packed record
    Msg_Id: Int64; //信息标识
    Dest_Id: array[0..20] of char; //目的号码
    service_id: array[0..9] of char; //业务类型，是数字、字母和符号的组合。
    TP_pId: byte; //GSM协议类型。详细解释请参考GSM03.40中的9.2.3.9
    TP_udhi: byte; //GSM协议类型。详细解释请参考GSM03.40中的9.2.3.23，仅使用1位，右对齐
    Msg_Fmt: byte; //信息格式
    Src_terminal_Id: array[0..20] of char; //源终端MSISDN号码
    Registered_Delivery: byte; //是否为状态报告0：非状态报告1：状态报告
    MSG_LENGTH: byte; //消息长度
  end;
  // Deliver后半部分
  //PCMPP_DELIVER_tag = ^TCMPP_DELIVER_tag;
  TCMPP_DELIVER = packed record
    Msg_Id: Int64; //信息标识
    Dest_Id: array[0..20] of char; //目的号码
    service_id: array[0..9] of char; //业务类型，是数字、字母和符号的组合。
    TP_pId: byte; //GSM协议类型。详细解释请参考GSM03.40中的9.2.3.9
    TP_udhi: byte; //GSM协议类型。详细解释请参考GSM03.40中的9.2.3.23，仅使用1位，右对齐
    Msg_Fmt: byte; //信息格式
    Src_terminal_Id: array[0..20] of char; //源终端MSISDN号码
    Registered_Delivery: byte; //是否为状态报告0：非状态报告1：状态报告
    MSG_LENGTH: byte; //消息长度
    Msg_Content: array[0..MSG_LENGTH - 1] of char; //消息内容
    Reserved: array[0..7] of char; //保留项
  end;
  // ISMG 向 SP 送交状态报告
  PCMPP_Report_tag = ^TCMPP_Report_tag;
  TCMPP_Report_tag = packed record
    //  ISMG 向 SP 送交状态报告时，信息内容字段(Msg_Content)格式定义
    Msg_Id: Int64; //信息标识
    stat: array[0..6] of char; //短信应答结果，详见CMPP
    Submit_time: array[0..9] of char; //提交时间
    Done_time: array[0..9] of char; //完成时间
    dest_terminal_id: array[0..20] of char; //目的终端号码
    SMSC_sequence: LongWord;
    //////////////////////////////
    Reserved: array[0..7] of char; //保留项
  end;

  //上行包应答包包体定义
  //PCMPP_DELIVER_RESP_tag = ^TCMPP_DELIVER_RESP_tag;
  TCMPP_DELIVER_RESP = packed record
    Msg_Id: Int64; //信息标识
    result: byte; //结果
  end;


  //短信群发 注：在群发中，由于 手机号是可变长的，所以在程序中定义，长度为21*手机个数
  PCMPP_SUBMIT_QF_tag1 = ^TCMPP_SUBMIT_QF_tag1;
  TCMPP_SUBMIT_QF_tag1 = packed record
    Msg_Id: Int64; //信息标识，由SP侧短信网关本身产生，本处填空。
    Pk_total: byte; //相同Msg_Id的信息总条数，从1开始
    Pk_number: byte; //相同Msg_Id的信息序号，从1开始
    Registered_Delivery: byte; //是否要求返回状态确认报告：0：不需要1：需要2：产生SMC话单 （该类型短信仅供网关计费使用，不发送给目的终端)
    Msg_level: byte; //信息级别
    service_id: array[0..9] of char; //业务类型，是数字、字母和符号的组合。
    Fee_UserType: byte; //计费用户类型字段0：对目的终端MSISDN计费；1：对源终端MSISDN计费；2：对SP计费;3：表示本字段无效，对谁计费参见Fee_terminal_Id字段。
    Fee_terminal_Id: array[0..20] of char; //被计费用户的号码（如本字节填空，则表示本字段无效，对谁计费参见Fee_Userstruct字段，本字段与Fee_Userstruct字段互斥）
    TP_pId: byte; //GSM协议类型。详细是解释请参考GSM03.40中的9.2.3.9
    TP_udhi: byte; //GSM协议类型。详细是解释请参考GSM03.40中的9.2.3.23,仅使用1位，右对齐
    Msg_Fmt: byte; //信息格式  0：ASCII串  3：短信写卡操作  4：二进制信息  8：UCS2编码15：含GB汉字
    msg_src: array[0..5] of char; //信息内容来源(SP_Id)
    FeeType: array[0..1] of char; //资费类别01：对"计费用户号码"免费
    FeeCode: array[0..5] of char; //资费代码（以分为单位）
    Valid_Time: array[0..16] of char; //存活有效期，格式遵循SMPP3.3协议
    At_Time: array[0..16] of char; //定时发送时间，格式遵循SMPP3.3协议
    Src_ID: array[0..20] of char; //源号码SP的服务代码或前缀为服务代码的长号码, 网关将该号码完整的填到SMPP协议Submit_SM消息相应的source_addr字段，该号码最终在用户手机上显示为短消息的主叫号码
    DestUsr_tl: byte; //接收信息的用户数量(小于100个用户)
  end;

  PCMPP_SUBMIT_QF_tag2 = ^TCMPP_SUBMIT_QF_tag2;
  TCMPP_SUBMIT_QF_tag2 = packed record
    MSG_LENGTH: byte; //信息长度(Msg_Fmt值为0时：<160个字节；其它<=140个字节)
    Msg_Content: array[0..MSG_LENGTH - 1] of char; //信息内容
    Reserve: array[0..7] of char; //保留
  end;

  // SP 向 ISMG 查询发送短信状态
  PCMPP_QUERY_tag = ^TCMPP_QUERY_tag;
  TCMPP_QUERY_tag = packed record
    Time: array[0..7] of char; //时间YYYYMMDD(精确至日)
    Query_Type: byte; //查询类别0：总数查询1：按业务类型查询
    Query_Code: array[0..9] of char; //查询码当Query_struct为0时，此项无效；当Query_struct为1时，此项填写业务类型Service_Id.
    Reserve: array[0..7] of char; //保留
  end;

  PCMPP_QUERY_RESP_tag = ^TCMPP_QUERY_RESP_tag;
  TCMPP_QUERY_RESP_tag = packed record
    Time: array[0..7] of char; //时间(精确至日)
    Query_Type: byte; //查询类别0：总数查询1：按业务类型查询
    Query_Code: array[0..9] of char; //查询码
    MT_TLMsg: LongWord; //从SP接收信息总数
    MT_Tlusr: LongWord; //从SP接收用户总数
    MT_Scs: LongWord; //成功转发数量
    MT_WT: LongWord; //待转发数量
    MT_FL: LongWord; //转发失败数量
    MO_Scs: LongWord; //向SP成功送达数量
    MO_WT: LongWord; //向SP待送达数量
    MO_FL: LongWord; //向SP送达失败数量
  end;
  ////////////////////////////////////////////////////////////////////////////
  // SP 向 ISMG 发起删除短信操作
  PCMPP_CANCEL_tag = ^TCMPP_CANCEL_tag;
  TCMPP_CANCEL_tag = packed record
    Msg_Id: Int64; //信息标识
  end;
  PCMPP_CANCEL_RESP_tag = ^TCMPP_CANCEL_RESP_tag;
  TCMPP_CANCEL_RESP_tag = packed record
    Success_Id: byte; //结果
  end;

  ////////////////////////////////////////////////////////////////////////////
  //链路检测操作
  TCMPP_ACTIVE_TEST = TEmpty;

  TCMPP_ACTIVE_TEST_RESP = packed record
    Success_Id: byte; //结果
  end;

  //包体
  TCMPP20_BODY = packed record
    case integer of
      1: (CMPP_CONNECT: TCMPP_CONNECT);
      2: (CMPP_CONNECT_RESP: TCMPP_CONNECT_RESP);
      3: (CMPP_SUBMIT: TCMPP_SUBMIT);
      4: (CMPP_SUBMIT_RESP: TCMPP_SUBMIT_RESP);
      5: (CMPP_DELIVER: TCMPP_DELIVER);
      6: (CMPP_DELIVER_RESP: TCMPP_DELIVER_RESP);
      7: (CMPP_ACTIVE_TEST: TCMPP_ACTIVE_TEST);
      8: (CMPP_ACTIVE_TEST_RESP: TCMPP_ACTIVE_TEST_RESP);
  end;

  //包
  TCMPP20_PACKET = packed record
    MsgHead: TCMPP_HEAD;
    MsgBody: TCMPP20_BODY;
  end;
  ////////////////////////////////////////////////////////////////////////////
  // 发送短信队列
  tSendQueue = TCMPP_SUBMIT;
  // 接收短信队列
  tDeliverQueue = packed record
    Head: TCMPP_DELIVER_HEAD;
    Body: TCMPP_DELIVER
  end;
  // 接收状态回报队列
  tReportQueue = packed record
    Head: TCMPP_DELIVER_HEAD;
    Body: TCMPP_Report_tag;
  end;

  {**************************************************************************}
  {由于发送时包头和包体需要一块发送，下列为组合成一体的协议结构}
  ////////////////////////////////////////////////////////////////////////////
  // CMPP_CONNECT 组合包 SP to ISMG
  tCmpp_Connect_StoI = packed record
    Head: TCMPP_HEAD;
    Body: TCMPP_CONNECT;
  end;
  // CMPP_SUBMIT 组合包 SP to ISMG
  tCmpp_Submit_StoI = packed record
    Head: TCMPP_HEAD;
    Body: TCMPP_SUBMIT;
  end;
  // CMPP_ACTIVE_TEST 组合包 SP to ISMG
  tCmpp_ActiveTest_StoI = packed record
    Head: TCMPP_HEAD;
    Body: TCMPP_ACTIVE_TEST;
  end;

  // CMPP_DELIVER_RESP 组合包 ISMG to SP
  tCmpp_Deliver_Resp_ItoS = packed record
    Head: TCMPP_HEAD;
    Body: TCMPP_DELIVER_RESP;
  end;
  // CMPP_ACTIVE_TEST_RESP 组合包 ISMG to SP
  tCmpp_ActiveTest_Resp_ItoS = packed record
    Head: TCMPP_HEAD;
    Body: TCMPP_ACTIVE_TEST_RESP;
  end;
  // CMPP_CONNECT_RESP 组合包 ISMG to SP
  tCmpp_Connect_Resp_ItoS = packed record
    Head: TCMPP_HEAD;
    Body: TCMPP_CONNECT_RESP;
  end;
implementation

function ResultCommandString(var i: LongWord): string;
begin
  case i of
    $1: result := 'CMPP_CONNECT';
    $80000001: result := 'CMPP_CONNECT_RESP';
    $2: result := 'CMPP_TERMINATE';
    $80000002: result := 'CMPP_TERMINATE_RESP';
    $4: result := 'CMPP_SUBMIT';
    $80000004: result := 'CMPP_SUBMIT_RESP';
    $5: result := 'CMPP_DELIVER';
    $80000005: result := 'CMPP_DELIVER_RESP';
    $6: result := 'CMPP_QUERY';
    $80000006: result := 'CMPP_QUERY_RESP';
    $7: result := 'CMPP_CANCEL';
    $80000007: result := 'CMPP_CANCEL_RESP';
    $8: result := 'CMPP_ACTIVE_TEST';
    $80000008: result := 'CMPP_ACTIVE_TEST_RESP';
    $9: result := 'CMPP_FWD';
    $80000009: result := 'CMPP_FWD_RESP ';
    $10: result := 'CMPP_MT_ROUTE';
    $80000010: result := 'CMPP_MT_ROUTE_RESP';
    $11: result := 'CMPP_MO_ROUTE';
    $80000011: result := 'CMPP_MO_ROUTE_RESP';
    $12: result := 'CMPP_GET_ROUTE';
    $80000012: result := 'CMPP_GET_ROUTE_RESP';
    $13: result := 'CMPP_MT_ROUTE_UPDATE';
    $80000013: result := 'CMPP_MT_ROUTE_UPDATE_RESP';
    $14: result := 'CMPP_MO_ROUTE_UPDATE';
    $80000014: result := 'CMPP_MO_ROUTE_UPDATE_RESP';
    $15: result := 'CMPP_PUSH_MT_ROUTE_UPDATE';
    $80000015: result := 'CMPP_PUSH_MT_ROUTE_UPDATE_RESP';
    $16: result := 'CMPP_PUSH_MO_ROUTE_UPDATE';
    $80000016: result := 'CMPP_PUSH_MO_ROUTE_UPDATE_RESP';
  end;
end;

end.

