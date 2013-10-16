unit SPPO10;

interface
const
  SPPO_VERSION = $40;

  //包命令字定义
  SPPO_LOGIN = $00000001;
  SPPO_LOGIN_RESP = $80000001;
  SPPO_MO = $00000002;
  SPPO_MO_RESP = $80000002;
  SPPO_MT = $00000003;
  SPPO_MT_RESP = $80000003;
  SPPO_ACTIVETEST = $00000004;
  SPPO_ACTIVETEST_RESP = $80000004;
  SPPO_REPORT = $00000005;
  SPPO_REPORT_RESP = $80000005;

  //消息类别定义
  SPPO_MSGTYPE_UNMO = 1; //非MO引起的MT
  SPPO_MSGTYPE_MOFIRST = 2; //MO引起的第一条MT
  SPPO_MSGTYPE_MOUNFIRST = 3; //MO引起的非第一条MT
  SPPO_MSGTYPE_REQUESTORDER = 4; //定制确认
  SPPO_MSGTYPE_CANCELORDER = 5; //取消定制
  SPPO_MSGTYPE_BAOYUEFEE = 6; //包月计费包
  SPPO_MSGTYPE_QXBAOYUEFEE = 7; //取消包月计费包
  SPPO_MSGTYPE_QF = 9; //群发

type
  TPHONENUM = array[0..31] of char; //电话号码
  TINMSGID = array[0..9] of char; //内部消息流水号

  //协议包头
  TSPPO_HEAD = packed record
    length: Cardinal; //包长
    CmdId: Cardinal; //包命令字
    Seqid: Cardinal; //包序号
  end;

  //网关登录
  TSPPO_LOGIN = packed record
    GateId: Cardinal; //网关号
    PassWord: array[0..9] of char; //密码
    GateDesc: array[0..31] of char; //网关说明
  end;

  //网关登录应答
  TSPPO_LOGIN_RESP = packed record
    result: byte; //登录结果0成功
  end;

  //上行消息
  TSPPO_MO = packed record
    MoOutMsgId: array[0..11] of char;
    MoInMsgId: TINMSGID;
    MoLinkId: array[0..19] of char;
    MoSpAddr: TPHONENUM;
    MoUserAddr: TPHONENUM;
    MoServiceId: array[0..9] of char;
    MoTpPid: byte;
    MoTpUdhi: byte;
    MoMsgFmt: byte;
    MoMsgLenth: Cardinal;
    MoMsgContent: array[0..511] of char;
    MoReserve: array[0..7] of char;
  end;

  //上行消息应答
  TSPPO_MO_RESP = packed record
    result: byte;
  end;

  //下行消息
  TSPPO_MT = packed record //消息类别
    MtLogicId: Cardinal; //业务标识
    MtMsgType: byte; //消息类型
    MoOutMsgId: array[0..11] of char; //Mo的外部消息流水号
    MoInMsgId: TINMSGID; //Mo的内部消息流水号
    MtInMsgId: TINMSGID; //mt的内部消息流水号
    MoLinkId: array[0..19] of char; //
    OutServiceID: array[0..9] of char; //smgp20计费代码
    OutFeeType: array[0..1] of char; //smgp20费用类别
    OutFixedFee: array[0..5] of char; //smgp20固定费用
    OutFeeCode: array[0..5] of char; //smgp20费用
    Msg_src: array[0..5] of char; //信息内容来源(SP_Id)
    MtSpAddr: TPHONENUM; //sp 1200 2333
    MtUserAddr: TPHONENUM; //目标用户手机号
    MtFeeAddr: TPHONENUM; //计费用户号码(手机号)
    MtServiceId: array[0..9] of char; //业务代码
    MtTpPid: byte;
    MtTpUdhi: byte;
    MtMsgFmt: byte; //信息类型
    MtValidTime: array[0..16] of char;
    MtAtTime: array[0..16] of char;
    MtMsgLenth: Cardinal; //信息长度
    MtMsgContent: array[0..511] of char; //信息
    MtReserve: array[0..7] of char; //保留位置
  end;

  //下行消息应答
  TSPPO_MT_RESP = packed record
    result: byte;
  end;

  //状态报告包
  TSPPO_REPORT = packed record
    MtLogicId: Cardinal;
    MtInMsgId: TINMSGID;
    MtSpAddr: TPHONENUM;
    MtUserAddr: TPHONENUM;
    stat: array[0..6] of char;
    Err: array[0..2] of char;
  end;

  TSPPO_REPORT_RESP = packed record
    result: byte;
  end;

  //活动测试包，无包体
  //活动测试应答包，无包体

  TSPPO_BODY = packed record
    case integer of
      1: (LOGIN: TSPPO_LOGIN);
      2: (LOGIN_RESP: TSPPO_LOGIN_RESP);
      3: (mo: TSPPO_MO);
      4: (Mo_Resp: TSPPO_MO_RESP);
      5: (Mt: TSPPO_MT);
      6: (Mt_Resp: TSPPO_MT_RESP);
      7: (Report: TSPPO_REPORT);
      8: (Report_Resp: TSPPO_REPORT_RESP);
  end;

  TSPPO_PACKET = packed record
    Head: TSPPO_HEAD;
    Body: TSPPO_BODY;
  end;

const
  SPPO_HEADLEN = sizeof(TSPPO_HEAD);
  SPPO_LOGINLEN = SPPO_HEADLEN + sizeof(TSPPO_LOGIN);
  SPPO_LOGINRESPLEN = SPPO_HEADLEN + sizeof(TSPPO_LOGIN_RESP);
  SPPO_MORESPLEN = SPPO_HEADLEN + sizeof(TSPPO_MO_RESP);
  SPPO_MTRESPLEN = SPPO_HEADLEN + sizeof(TSPPO_MT_RESP);
  SPPO_ACTIVELEN = SPPO_HEADLEN;
  SPPO_ACTIVERESPLEN = SPPO_HEADLEN;

implementation

end.

