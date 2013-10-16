{－－－－－－－－－－－－－－－－－－－－－－－－}
{                  发送包定义                    }
{                        LUOXX                   }
{                             2004/3/11          }
{－－－－－－－－－－－－－－－－－－－－－－－－}

unit U_MsgInfo;

interface
uses Smgp13_XML, sysutils;

const
  MAX_DATA_LEN = 1024 * 3; //XML最大长度
  MAx_UserNumber = 100;//下行最大电话号码数

type
  TSMGPHead = packed record
    PacketLength: Longword; //包长度 ＝ 包头＋包体
    RequestID: Longword; //命令字
    SequenceID: Longword; //消息序号
  end;

  TSMGPLogin = packed record
    clientID: array[0..7] of char; //用户名
    AuthenticatorClient: array[0..15] of char; //认证
    LoginMode: byte; //登陆模式
    TimeStamp: Longword; //时间
    Version: byte; //系统版本号
  end;
  TLogin = packed record
    Head: TSMGPHead;
    body: TSMGPLogin;
  end;
  {上行包}
  PDeliver = ^TCTDeliver;
  TCTDeliver = packed record
    MsgID: array[0..9] of char; //网关产生的短消息流水号
    IsReport: byte; //是否状态报告（0＝不是，1＝是）
    MsgFormat: byte; //短消息格式
    RecvTime: array[0..13] of char; //短消息接收时间
    SrcTermID: array[0..20] of char; //短消息发送号码
    DestTermID: array[0..20] of char; //短消息接收号码
    MsgLength: byte; //短消息长度
    MsgContent: array[0..251] of char; //短信息内容
    Reserve: array[0..7] of char; //保留
  end;

  TSMGPLogin_resp = packed record
    Status: Longword;
    AuthenticatorServer: array[0..15] of char;
    Version: byte;
  end;

  TLogin_resp = packed record
    Head: TSMGPHead;
    body: TSMGPLogin_resp;
  end;
  {下行包1.3协议} //Endo Cancel
  {pSMGPSubmit = ^TSMGPSubmit;
  TSMGPSubmit = packed record
    MsgType: byte;
    NeedReport: byte;
    Priority: byte;
    ServiceID: array[0..9] of char;
    FeeType: array[0..1] of char;
    FeeCode: array[0..5] of char;
    FixedFee: array[0..5] of char;
    MsgFormat: byte;
    ValidTime: array[0..16] of char;
    AtTime: array[0..16] of char; //
    SrcTermID: array[0..20] of char;
    ChargeTermID: array[0..20] of char;
    DestTermIDCount: byte;
    DestTermID: array[0..21 * MAx_UserNumber - 1] of char;
    MsgLength: byte;
    MsgContent: array[0..251] of char; //string;
    Reserve: array[0..7] of char;
  end;}
  {-------------------------------------------------------------------------}

  
  {-------------------------------------------------------------------------}
  //按2.0协议修改下行包体结构
  TSMGPSubmit201 = packed record //包体1
    MsgType: byte;
    NeedReport: byte;
    Priority: byte;
    ServiceID: array[0..9] of char;
    FeeType: array[0..1] of char;
    FeeCode: array[0..5] of char;  //
    FixedFee: array[0..5] of char; //2.0 与1.3协议区别在  FixedFee 字段与  FeeCode对换
    MsgFormat: byte;
    ValidTime: array[0..16] of char; //2.0协议不同于1.3协议就在于这2个字段值 非空是占17位
    AtTime: array[0..16] of char; //
  end;

  TSMGPSubmit2011 = packed record //包头＋包体1
    Head: TSMGPHead;
    body: TSMGPSubmit201;
  end;
  //------------------------------------------------------------------  

  {TSMGPSubmit2021 = packed record //包体2
    ValidTime: array[0..16] of char; //2.0协议不同于1.3协议就在于这2个字段值 非空是占17位
    AtTime: array[0..16] of char; //
  end; }

 // TSMGPSubmit2022 = packed record //包体2
 //   ValidTime: char; //2.0协议不同于1.3协议就在于这2个字段值 为空是占1位
 //   AtTime: char; //
 // end;
  //------------------------------------------------------------------
  TSMGPSubmit203 = packed record //包体3
    SrcTermID: array[0..20] of char;
    ChargeTermID: array[0..20] of char;
    DestTermIDCount: byte;
    DestTermID: array[0..21 * MAX_UserNumber - 1] of char;
    MsgLength: byte;
    MsgContent: array[0..251] of char; //string;
    Reserve: array[0..7] of char;
  end;
  {-------------------------------------------------------------------------}
  {-------------------------------------------------------------------------}

  {TSubmit = packed record  //Endo Cancel
    Head: TSMGPHead;
    body: TSMGPSubmit;
  end;}
  //内部包结构定义
  PxSubmit = ^xSubmit; {//}
  xSubmit = packed record
    Resend: byte; //下发次数
    SequenceID: Longword; //包头序列号
    Then_DateTime: TDateTime;
    sSubmit: TTCSubmit;
  end;

  TDeliver = packed record
    Head: TSMGPHead;
    body: TTCDeliver;
  end;

  TSMGPDeliver_Resp = packed record {与回馈包体结构相同Submit_resp }
    MsgID: array[0..9] of char;
    Status: Longword;
  end;
  TSMGPSubmit_Resp = packed record {与回馈包体结构相同Submit_resp }
    MsgID: array[0..19] of char; //BCD10位解成20位
    Status: Longword;
  end;
  TDeliver_Resp = packed record
    Head: TSMGPHead;
    body: TSMGPDeliver_Resp;
  end;

  TSubmit_resp = packed record
    Head: TSMGPHead;
    body: TSMGPDeliver_Resp;
  end;

  pSubmitMid = ^TSubmitMid;
  TSubmitMid = packed record
    Mid: string;
    sequence: Longword;
  end;

  {下行回馈到中间服务器}
  PResponse = ^TSPResponse;
  TSPResponse = packed record
    Mid: string;
    Submit_resp: TSMGPSubmit_Resp;
  end;

  {拆机/停机}
  pCT_Free_Stop = ^TCT_Free_Stop;
  TCT_Free_Stop = packed record
    MsgID: string;
    SrcTermID: string;
    DestTermID: string;
    Free_Stop_time: string;
    Status: char;
  end;

  {内部协议}

  CTSMSHeader = packed record
    Total_Length: Longword;
    Command_ID: Word;
    Status_ID: Word;
    Sequence_ID: Word;
    Version: Word;
  end;

  TSPPack = packed record
    Header: CTSMSHeader;
    body: array[0..MAX_DATA_LEN - 1] of char;
  end;



  {function}
function writeXmlResponse(xSPResponse: TSPResponse): string;
function writeXmluserFeeSop(xCT_Free_Stop: TCT_Free_Stop): string;
implementation

function writeXmlResponse(xSPResponse: TSPResponse): string;
begin
  Result := '';
  Result := '<?xml version="1.0" encoding="UTF-8"?>';
  Result := Result + '<SubmitResp>';
  Result := Result + '<Mid>' + xSPResponse.Mid + '</Mid>';
  Result := Result + '<MsgID>' + xSPResponse.Submit_resp.MsgID + '</MsgID>';
  Result := Result + '<Status>' + inttostr(xSPResponse.Submit_resp.Status) + '</Status>';
  Result := Result + '</SubmitResp>';
end;
function writeXmluserFeeSop(xCT_Free_Stop: TCT_Free_Stop): string;
begin
  Result := '';
  Result := '<?xml version="1.0" encoding="UTF-8"?>';
  Result := Result + '<UserFreeStop>';
  Result := Result + '<MsgID>' + xCT_Free_Stop.MsgID + '</MsgID>';
  Result := Result + '<SrcTermID>' + xCT_Free_Stop.SrcTermID + '</SrcTermID>';
  Result := Result + '<DestTermID>' + xCT_Free_Stop.DestTermID + '</DestTermID>';
  Result := Result + '<Free_Stop_time>' + xCT_Free_Stop.Free_Stop_time + '</Free_Stop_time>';
  Result := Result + '<Status>' + xCT_Free_Stop.Status + '</Status>';
  Result := Result + '</UserFreeStop>';
end;

end.

