unit SMGP13;

interface
const
  SMGP13_VERSION = $13;
  SMGP13_LOGIN = $00000001; //  CP 或SMGW 登录请求
  SMGP13_LOGIN_RESP = $80000001; //  CP 或SMGW 登录回应
  SMGP13_SUBMIT = $00000002; //  CP 发送短消息请求
  SMGP13_SUBMIT_RESP = $80000002; //  CP 发送短消息回应
  SMGP13_DELIVER = $00000003; //  SMGW 向CP 发送短消息请求
  SMGP13_DELIVER_RESP = $80000003; //  SMGW 向CP 发送短消息回应
  SMGP13_ACTIVE_TEST = $00000004; //  测试通信链路是否正常请求（由客户端发起，CP 和SMGW可以通过定时发送此请求来维持连接）
  SMGP13_ACTIVE_TEST_RESP = $80000004; //  测试通信链路是否正常回应

type
  TSMGP13PhoneNum = array[0..20] of char;

  //数据包包头定义
  TSMGP13_HEAD = packed record
    PacketLength: Cardinal;
    RequestID: Cardinal;
    SequenceID: Cardinal;
  end;

  //登录包包体定义
  TSMGP13_LOGIN = packed record
    ClientID: array[0..7] of char;
    AuthenticatorClient: array[0..15] of char;
    LoginMode: byte;
    TimeStamp: Cardinal;
    Version: byte;
  end;

  //登录应答包包体定义
  TSMGP13_LOGIN_RESP = packed record
    Status: Cardinal;
    AuthenticatorServer: array[0..15] of char;
    Version: byte;
  end;

  //下行消息包包体定义
  TSMGP13_SUBMIT = packed record
    MsgType: byte;
    NeedReport: byte;
    Priority: byte;
    ServiceID: array[0..9] of char;
    FeeType: array[0..1] of char;
    FeeCode: array[0..5] of char;
    FixedFee: array[0..5] of char;
    MsgFormat: byte;
    ValidTime: array[0..16] of char;
    AtTime: array[0..16] of char;
    SrcTermID: TSMGP13PhoneNum;
    ChargeTermID: TSMGP13PhoneNum;
    DestTermIDCount: byte;
    DestTermID: TSMGP13PhoneNum;
    MsgLength: byte;
    MsgContent: array[0..252] of char;
    Reserve: array[0..7] of char;
  end;

  //下行消息应答包包体定义
  TSMGP13_SUBMIT_RESP = packed record
    MsgID: array[0..9] of char;
    Status: Cardinal;
  end;

  //上行消息包包体定义
  TSMGP13_DELIVER = packed record
    MsgID: array[0..9] of char;
    IsReport: byte;
    MsgFormat: byte;
    RecvTime: array[0..13] of char;
    SrcTermID: TSMGP13PhoneNum;
    DestTermID: TSMGP13PhoneNum;
    MsgLength: byte;
    MsgContent: array[0..251] of char;
    Reserve: array[0..7] of char;
  end;

  //上行消包应答包包体定义
  TSMGP13_DELIVER_RESP = packed record
    MsgID: array[0..9] of char;
    Status: Cardinal;
  end;

  //包体
  TSMGP13_BODY = packed record
    case integer of
      1: (LOGIN: TSMGP13_LOGIN);
      2: (LOGIN_RESP: TSMGP13_LOGIN_RESP);
      3: (SUBMIT: TSMGP13_SUBMIT);
      4: (SUBMIT_RESP: TSMGP13_SUBMIT_RESP);
      5: (DELIVER: TSMGP13_DELIVER);
      6: (DELIVER_RESP: TSMGP13_DELIVER_RESP);
  end;

  //包
  TSMGP13_PACKET = packed record
    MsgHead: TSMGP13_HEAD;
    MsgBody: TSMGP13_BODY;
  end;

  //状态报告
  TSMGP13RPT = packed record
    TID: array[0..2] of char; //字符'id:' 3字节
    ID: array[0..9] of char; //消息id 10字节
    SP1: char; //空格 1字节
    TSUB: array[0..3] of char; //sub: 4字节
    SUB: array[0..2] of char; //001 3字节
    SP2: char; //空格 1字字
    TDLVRD: array[0..5] of char; //dlvrd: 6字节
    DLVRD: array[0..2] of char; //001 3字节
    SP3: char; //空格 1字节
    TSUBMITDATE: array[0..11] of char; //submit date: 12字节
    SUBMITDATE: array[0..9] of char; //YYMMDDHHMI   10字节
    SP4: char; //空格 1
    TDONEDATE: array[0..9] of char; //TODO date: 10
    DONEDATE: array[0..9] of char; //10
    sp5: char; //空格 1字节
    tSTAT: array[0..4] of char; //5
    stat: array[0..6] of char; //7
    sp6: char; //
    tERR: array[0..3] of char; //
    Err: array[0..2] of char; //
    sp7: char; //
    tTXT: array[0..3] of char; //
    sp8: char;
    txt: array[0..2] of char; //
    msgcon: array[0..16] of char; //
    sp9: char; //  #0
  end;

function SMGP13_StatusToDesc(Status: Cardinal): string;
function SMGP13_StatusToStr(Status: Cardinal): string;

implementation

uses
  SysUtils;

function SMGP13_StatusToStr(Status: Cardinal): string;
begin
  result := inttostr(Status);
  if length(result) = 1 then result := '00' + result;
  if length(result) = 2 then result := '0' + result;
end;

function SMGP13_StatusToDesc(Status: Cardinal): string;
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

