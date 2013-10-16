{************************************
ModuleName: 	SGIP12 DEFINE
FileName:     SGIP12.PAS
DESCRIPTION:   RENWY SGIP 1.2 Protocol Message Definition
History:
Date       	Version			Modifier			 	Activies
2004/12/17	1.0				  CNRENWY			Create
************************************}
unit SGIP12;

interface
const
  SGIP12_VERSION = $12;

  SGIP12_BIND = $1; //对客户端验证
  SGIP12_BIND_RESP = $80000001; //服务端返回验证请求
  SGIP12_UNBIND = $2; //断开连接
  SGIP12_UNBIND_RESP = $80000002; //返回断开连接状态
  SGIP12_SUBMIT = $3; //向SMG提交MT短消息
  SGIP12_SUBMIT_RESP = $80000003; //返回SP提交MT短消息状态
  SGIP12_DELIVER = $4; //SMG向SP发送一条MO短消息
  SGIP12_DELIVER_RESP = $80000004; //返回SMG状态
  SGIP12_REPORT = $5; //向SP发送一条先前的submit命令的当前状态
  SGIP12_REPORT_RESP = $80000005; //响应SMG状态
  SGIP12_ADDSP = $6; //
  SGIP12_ADDSP_RESP = $80000006; //
  SGIP12_MODIFYSP = $7; //
  SGIP12_MODIFYSP_RESP = $80000007; //
  SGIP12_DELETESP = $8; //
  SGIP12_DELETESP_RESP = $80000008; //
  SGIP12_QUERYROUTE = $9; //
  SGIP12_QUERYROUTE_RESP = $80000009; //
  SGIP12_ADDTELESEG = $A; //
  SGIP12_ADDTELESEG_RESP = $8000000A; //
  SGIP12_MODIFYTELESEG = $B; //
  SGIP12_MODIFYTELESEG_RESP = $8000000B; //
  SGIP12_DELETETELESEG = $C; //
  SGIP12_DELETETELESEG_RESP = $8000000C; //
  SGIP12_ADDSMG = $D; //
  SGIP12_ADDSMG_RESP = $8000000D; //
  SGIP12_MODIFYSMG = $E; //
  SGIP12_MODIFYSMG_RESP = $0000000E; //
  SGIP12_DELETESMG = $F; //
  SGIP12_DELETESMG_RESP = $8000000F; //
  SGIP12_CHECKUSER = $10; //
  SGIP12_CHECKUSER_RESP = $80000010; //
  SGIP12_USERRPT = $11; //
  SGIP12_USERRPT_RESP = $80000011; //
  SGIP12_TRACE = $1000; //
  SGIP12_TRACE_RESP = $80001000; //
  MSG_LENGTH = 140; //短信内容长度
  DestUsr_tl = 1; //接收信息的用户数量(小于100个用户)。
type
  TSGIP12honeNum = array[0..20] of char;
  TEmpty = record //空纪录
  end;
  //数据包包头定义

  TSGIP12_HEAD = packed record
   { MessageLength: LongWord; //消息的总长度(字节)
    CommandId: LongWord; //命令ID
    //SNumber1, SNumber2, SNumber3: LongWord; //序列号
    SequenceNumber: LongWord; //序列号   }
    Message_Length: LongWord; //消息总长度(含消息头及消息体)
    Command_ID: LongWord; //命令或响应类型
    SNumber1, SNumber2, SNumber3: longword; //序列号,消息流水号,顺序累加,步长为1,循环使用（一对请求和应答消息的流水号必须相同）
  end;

  //登录包包体定义
  TSGIP12_Bind = packed record
    LonginType: byte;
    LonginPass: array[0..15] of char;
    LonginName: array[0..15] of char;
    Reserve: array[0..7] of char;
  end;

  //登录应答包包体定义
  TSGIP12_Bind_Resp = packed record
    result: byte;
    Reserve: array[0..7] of char;
  end;

  Unbind = TEmpty;
  Unbind_Resp = TEmpty;

  //下行消息包包体定义
  TSGIP12_SUBMIT = packed record
    {SPNumber: array[0..20] of char;
    ChargeNumber: array[0..20] of char;
    UserCount: byte; //1-100
    UserNumber: array[0..20] of char; //TelCount;  file://长度为UserCount
    CorpID: array[0..4] of char;
    ServiceType: array[0..9] of char;
    FeeType: byte;
    FeeValue: array[0..5] of char;
    GivenValue: array[0..5] of char;
    AgentFlag: byte;
    MOrelatetoMTFlag: byte;
    Priority: byte;
    ExpireTime: array[0..15] of char;
    ScheduleTime: array[0..15] of char;
    ReportFlag: byte;
    TP_pId: byte;
    TP_udhi: byte;
    MessageCoding: byte;
    MessageType: byte;
    MessageLength: LongWord;
    MessageContent: array[0..160] of char; //长度为  MessageLength;
    Reserve: array[0..7] of char;
     }
    SPNumber: array[0..20] of Char; //SP的接入号码
    ChargeNumber: array[0..20] of Char; //付费号码，手机号码前加"86"国别标志；当且仅当群发且对用户收费时为空；如果为空，则该条短消息产生的费用由UserNumber代表的用户支付；如果为全零字符串"000000000000000000000"，表示该条短消息产生的费用由SP支付。
    UserCount: Byte; //接收短消息的手机数量，取值范围1至100
    UserNumber: array[0..20] of Char; //接收该短消息的手机号，该字段重复UserCount指定的次数，手机号码前加"86"国别标志
    CorpId: array[0..4] of Char; //企业代码，取值范围0-99999
    ServiceType: array[0..9] of Char; //业务代码，由SP定义
    FeeType: Byte; //计费类型
    FeeValue: array[0..5] of Char; //取值范围0-99999，该条短消息的收费值，单位为分，由SP定义对于包月制收费的用户，该值为月租费的值
    GivenValue: array[0..5] of Char; //取值范围0-99999，赠送用户的话费，单位为分，由SP定义，特指由SP向用户发送广告时的赠送话费
    AgentFlag: Byte; //代收费标志，0：应收；1：实收
    MorelatetoMTFlag: Byte; //引起MT消息的原因 0-MO点播引起的第一条MT消息；1-MO点播引起的非第一条MT消息；2-非MO点播引起的MT消息；3-系统反馈引起的MT消息。
    Priority: Byte; //优先级0-9从低到高，默认为0
    ExpireTime: array[0..16] of Char; //短消息寿命的终止时间，如果为空，表示使用短消息中心的缺省值。时间内容为16个字符，格式为"yymmddhhmmsstnnp" ，其中"tnnp"取固定值"032+"，即默认系统为北京时间
    ScheduleTime: array[0..16] of Char; //短消息定时发送的时间，如果为空，表示立刻发送该短消息。时间内容为16个字符，格式为"yymmddhhmmsstnnp" ，其中"tnnp"取固定值"032+"，即默认系统为北京时间
    ReportFlag: Byte; //状态报告标记 0-该条消息只有最后出错时要返回状态报告 1-该条消息无论最后是否成功都要返回状态报告 2-该条消息不需要返回状态报告 3-该条消息仅携带包月计费信息，不下发给用户，要返回状态报告 其它-保留 缺省设置为0
    TP_pid: Byte; //GSM协议类型。详细解释请参考GSM03.40中的9.2.3.9
    TP_udhi: Byte; //GSM协议类型。详细解释请参考GSM03.40中的9.2.3.23,仅使用1位，右对齐
    MessageCoding: Byte; //短消息的编码格式。0：纯ASCII字符串 3：写卡操作 4：二进制编码 8：UCS2编码 15: GBK编码 其它参见GSM3.38第4节：SMS Data Coding Scheme
    MessageType: Byte; //信息类型：0-短消息信息 其它：待定
    MessageLength: Byte; //短消息的长度
    MessageContent: array[0..MSG_LENGTH - 1] of Char; //短消息的内容
    Reserve: array[0..7] of Char; //保留，扩展用
  end;

  //下行消息应答包包体定义
  TSGIP12_SUBMIT_RESP = packed record
    result: byte;
    Reserve: array[0..7] of char;
  end;

  //上行消息包包体定义
  TSGIP12_DELIVER = packed record
    {UserNumber: array[0..20] of char;
    SPNumber: array[0..27] of char;
    TP_pId: byte;
    TP_udhi: byte;
    MessageCoding: byte;
    MessageLength: LongWord;
    MessageContent: array[0..254] of char; //长度为  MessageLength;
    Reserver: array[0..7] of char; }
    UserNumber: array[0..20] of Char; //发送短消息的用户手机号，手机号码前加"86"国别标志
    SPNumber: array[0..20] of Char; //SP的接入号码
    TP_pid: Byte; //GSM协议类型。详细解释请参考GSM03.40中的9.2.3.9
    TP_udhi: Byte; //GSM协议类型。详细解释请参考GSM03.40中的9.2.3.23，仅使用1位，右对齐
    MessageCoding: Byte; //短消息的编码格式。0：纯ASCII字符串3：写卡操作4：二进制编码8：UCS2编码15: GBK编码其它参见GSM3.38第4节：SMS Data Coding Scheme
    MessageLength: Byte; //短消息的长度
    MessageContent: array[0..MSG_LENGTH - 1] of Char; //短消息的内容
    Reserve: array[0..7] of Char; //保留，扩展用
  end;

  //上行消包应答包包体定义
  TSGIP12_DELIVER_RESP = packed record
    result: byte;
    Reserve: array[0..7] of char;
  end;

  //包体
  TSGIP12_BODY = packed record
    case integer of
      1: (LOGIN: TSGIP12_Bind);
      2: (LOGIN_RESP: TSGIP12_Bind_Resp);
      3: (SUBMIT: TSGIP12_SUBMIT);
      4: (SUBMIT_RESP: TSGIP12_SUBMIT_RESP);
      5: (DELIVER: TSGIP12_DELIVER);
      6: (DELIVER_RESP: TSGIP12_DELIVER_RESP);
  end;

  //包
  TSGIP12_PACKET = packed record
    MsgHead: TSGIP12_HEAD;
    MsgBody: TSGIP12_BODY;
  end;

  //状态报告
  TSGIP12RPT = packed record
    SubSequNumber1, SubSequNumber2, SubSequNumber3: LongWord;
    ReportType: byte;
    UserNumber: array[0..20] of char;
    State: byte;
    ErrorCode: byte;
    Reserve: array[0..7] of char;
  end;

  TSGIP12RPT_Resp = packed record
    result: byte;
    Reserve: array[0..7] of char;
  end;

function SGIP12_StatusToDesc(Status: Cardinal): string;
function SGIP12_StatusToStr(Status: Cardinal): string;

implementation

uses
  SysUtils;

function SGIP12_StatusToStr(Status: Cardinal): string;
begin
  result := inttostr(Status);
  if length(result) = 1 then result := '00' + result;
  if length(result) = 2 then result := '0' + result;
end;

function SGIP12_StatusToDesc(Status: Cardinal): string;
begin
  case Status of
    0: result := '成功';
    1: result := '系统忙';
    2: result := '超过最大连接数';
    3..9: result := '保留';
    10: result := '消息结构错';
    11: result := '命令字错';
    12: result := '序列号重复';
    13..19: result := '保留';
    20: result := 'IP 地址错';
    21: result := '认证错';
    22: result := '版本太高';
    23..29: result := '保留';
    30: result := '非法消息类型（SMType）';
    31: result := '非法优先级（Priority）';
    32: result := '非法资费类型（FeeType）';
    33: result := '非法资费代码（FeeCode）';
    34: result := '非法短消息格式（MsgFormat）';
    35: result := '非法时间格式';
    36: result := '非法短消息长度（MsgLength）';
    37: result := '有效期已过';
    38: result := '非法查询类别（QueryType）';
    39: result := '路由错误';
    40: result := '非法包月/封顶费(FIXEDFEE)';
    41: result := '非法更新类型（UPDATETYPE）';
    42: result := '非法路由编号（ROUTERID）';
    43: result := '非法服务代码（SERVICEID）';
    44: result := '非法有效期（VALIDTIME）';
    45: result := '非法定时发送时间（ATTIME）';
    46: result := '非法发送用户号码（SRCTERMID）';
    47: result := '非法接收用户号码（DESTTERMID）';
    48: result := '非法计费用户号码（CHARGETERMID）';
    49: result := '非法SP代码';
    50..127: result := '保留';
    128..255: result := '厂家自定义';
  end;
end;

end.

