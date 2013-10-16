{-----------------------------------------------------------------------------
 Unit Name: 电信短信息网关（内部XML包解析与生成）
 Author:    luo xin xi
 Purpose:   SMS XML(Read/Write)
 History:
 Date:      2005-04-18
-----------------------------------------------------------------------------}
unit Smgp13_XML;

interface
uses Classes,
  SysUtils, Base64;

type
  //3.0协议可选参数消息包
  TSMGPTLV_tag = packed record
    Tag:Word;
    Length:Word;
    Value:byte;
  end;
  TSMGPTLVLinkID_tag = packed record
    Tag:Word;
    Length:Word;
    Value:array[0..19] of char;  
  end;

  PCTDeliver = ^TTCDeliver;
  TTCDeliver = packed record
    MsgID: string; //网关产生的短消息流水号
    IsReport: integer; //是否状态报告（0＝不是，1＝是）
    MsgFormat: integer; //短消息格式
    RecvTime: string; //短消息接收时间
    DestTermID: string; //短消息接收号码
    SrcTermID: string; //短消息发送号码
    //SrcTermType : byte;
    MsgLength: integer; //短消息长度
    //ServiceID : string;
    MsgContent: string; //短信息内容
    Reserve: string; //保留
    LinkID:string;
  end;  

  TTCSubmit = packed record
    Mid: string;
    MsgType: integer; // 短消息类型
    NeedReport: integer; // 是否要求返回状态报告
    Priority: integer; // 发送优先级
    ServiceID: string; // 业务类型
    FeeType: string; // 收费类型
    FixedFee :string;
    FeeUserType:byte;
    FeeCode: string; //  资费代码（单位为分）
    MsgFormat: integer; // 短消息格式
    ValidTime: string; // 有效时间
    AtTime: string; // 定时发送时间
    SrcTermID: string; // 短消息发送用户号码
    ChargeTermID: string; //  计费用户号码
    DestTermIDCount: integer; //  短消息接收号码总数
    DestTermID: string; //  短消息接收号码
    MsgLength: integer; // 短消息长度
    MsgContent: string; // 短消息内容
    Reserve: string; // LinkID
    LinkID:string;
    SubmitMsgType:byte;//13同步定购, 15 同步定购回复  0 点播信息 
  end;

  PReport = ^TReport;
  TReport = packed record
    id: string; //array [0..9] of char;	//状态报告对应原短消息回馈报告中的MsgID
    sub: string; //array [0..2] of char;	//取缺省值001
    dlvrd: string; //array [0..2] of char;	//取缺省值001
    Submit_date: string; //array [0..9] of char;	//短消息提交时间(格式:yymmddhhmm 例如0306112000)
    done_date: string; //array [0..9] of char;	//短消息下发时间(格式:yymmddhhmm 例如0306112000)
    Stat: string; //array [0..6] of char;	//短消息状态
    Err: string; //array [0..2] of char;	//错误代码,参看错误代码表
    Txt: string; //array [0..19] of char;	//前3个字节,表示短消息长度后17个字节表示短消息的前一段字符
  end;

function ReadDeliver(const XML: string; var rDeliver: TTCDeliver): Boolean;
function WriteDeliver(const rDeliver: TTCDeliver): string;
function ReadSubmit(const XML: string; var rSubmit: TTCSubmit): Boolean;
function WriteSubmit(const rSubmit: TTCSubmit): string;
function writeXmlReport(const xReport: TReport): string;

implementation

uses U_Main;

function GetBody(const XML, StarStr, EndStr: string): string;
var
  i, j: integer;
begin
  i := AnsiPos(AnsiUpperCase(StarStr), AnsiUpperCase(XML));
  if i = 0 then Exit;

  j := AnsiPos(AnsiUpperCase(EndStr), AnsiUpperCase(XML));
  if j = 0 then Exit;

  Inc(i, Length(StarStr));

  Result := '';
  Result := Trim(Copy(XML, i, j - i));
end;
//****根据协议修改
function ReadDeliver(const XML: string; var rDeliver: TTCDeliver): Boolean;
var
  i: integer;
  TmpStr: string;
begin
  Result := False;
  i := AnsiPos('<Deliver>', XML);
  if i = 0 then Exit;
  TmpStr := GetBody(XML, '<MsgID>', '</MsgID>');
  rDeliver.MsgID := TmpStr;
  rDeliver.SrcTermID := GetBody(XML, '<SrcTermID>', '</SrcTermID>');
  rDeliver.DestTermID := GetBody(XML, '<DestTermID>', '</DestTermID>');
  //rDeliver.SrcTermType := StrToIntdef(GetBody(XML, '<SrcTermType>', '</SrcTermType>'),0);
  //rDeliver.ServiceID := GetBody(XML, '<ServiceID>', '</ServiceID>');
  rDeliver.MsgContent := DecodeBase64( GetBody(XML, '<MsgContent>', '</MsgContent>'));
  //rDeliver.LinkID := GetBody(XML, '<LinkID>', '</LinkID>');
  Result := True;
end;
//***写是通用得xml结构
function WriteDeliver(const rDeliver: TTCDeliver): string;
begin
  Result := '';
  Result := '<?xml version="1.0" encoding="UTF-8"?>';
  Result := Result + '<Deliver>';
  Result := Result + '<GateID>' + GateID + '</GateID>';
  Result := Result + '<MsgID>' + rDeliver.MsgID + '</MsgID>';
  Result := Result + '<SrcTermID>' + rDeliver.SrcTermID + '</SrcTermID>';
  Result := Result + '<DestTermID>' + rDeliver.DestTermID + '</DestTermID>';
  Result := Result + '<DestTermType>0</DestTermType>';
  Result := Result + '<ServiceID></ServiceID>'; //对应协议没有得域填''
  Result := Result + '<MsgContent>' + EncodeBase64(rDeliver.MsgContent) + '</MsgContent>';
  Result := Result + '<LinkID>'+rDeliver.LinkID+'</LinkID>';
  Result := Result + '</Deliver>';
end;
//根据各运营商得协议从submitxml文档中读取需要得数据域
function ReadSubmit(const XML: string; var rSubmit: TTCSubmit): Boolean;
var
  i: integer;
  TmpStr: string;
begin
  Result := False;
  i := AnsiPos('<Submit>', XML);
  if i = 0 then Exit;
  
  TmpStr := GetBody(XML, '<MID>', '</MID>');
  rSubmit.Mid := TmpStr;

  TmpStr := GetBody(XML, '<MsgType>', '</MsgType>');
  rSubmit.MsgType := strtoint(TmpStr);

  TmpStr := GetBody(XML, '<NeedReport>', '</NeedReport>');
  rSubmit.NeedReport := strtoint(TmpStr);

  TmpStr := GetBody(XML, '<Priority>', '</Priority>');
  rSubmit.Priority := strtoint(TmpStr);

  TmpStr := GetBody(XML, '<ServiceID>', '</ServiceID>');
  rSubmit.ServiceID := TmpStr;

  TmpStr := GetBody(XML, '<FeeType>', '</FeeType>');
  rSubmit.FeeType := TmpStr;

  TmpStr := GetBody(XML, '<FixedFee>', '</FixedFee>');
  rSubmit.FixedFee := TmpStr;

  TmpStr := GetBody(XML, '<FeeCode>', '</FeeCode>');
  rSubmit.FeeCode := TmpStr;

  TmpStr := GetBody(XML, '<FeeUserType>', '</FeeUserType>');
  rSubmit.FeeUserType := StrToIntDef(TmpStr,0);

  TmpStr := GetBody(XML, '<MsgFormat>', '</MsgFormat>');
  rSubmit.MsgFormat := strtoint(TmpStr);

  TmpStr := GetBody(XML, '<ValidTime>', '</ValidTime>');
  rSubmit.ValidTime := TmpStr;

  TmpStr := GetBody(XML, '<AtTime>', '</AtTime>'); // 定时发送时间
  rSubmit.AtTime := TmpStr;

  TmpStr := GetBody(XML, '<SrcTermID>', '</SrcTermID>'); // 短消息发送用户号码
  rSubmit.SrcTermID := TmpStr;

  TmpStr := GetBody(XML, '<FeeTermID>', '</FeeTermID>'); //  计费用户号码
  rSubmit.ChargeTermID := TmpStr;

  TmpStr := GetBody(XML, '<DestTermIDCount>', '</DestTermIDCount>'); //  短消息接收号码总数
  rSubmit.DestTermIDCount := strtoint(TmpStr);

  TmpStr := GetBody(XML, '<DestTermID>', '</DestTermID>'); //  短消息接收号码
  rSubmit.DestTermID := TmpStr ;

  TmpStr := GetBody(XML, '<MsgContent>', '</MsgContent'); // 短消息内容
  rSubmit.MsgContent := Base64.DecodeBase64(TmpStr);
  rSubmit.MsgLength := Length(rSubmit.MsgContent); // 短消息长度 
  rSubmit.LinkID := GetBody(XML, '<LinkID>', '</LinkID');
  Result := True;
end;

function WriteSubmit(const rSubmit: TTCSubmit): string;
begin
  Result := '<?xml version="1.0" encoding="UTF-8"?>';
  Result := Result +'<Submit>';
  Result := Result + '<GateID>' + GateID + '</GateID>';
  Result := Result + '<Mid>'+ rSubmit.Mid +'</Mid>';
  Result := Result + '<MsgType>' + inttostr(rSubmit.MsgType) + '</MsgType>'; // 短消息类型
  Result := Result + '<PkTotal></PkTotal>'; //
  Result := Result + '<PkNumber></PkNumber>'; //
  Result := Result + '<NeedReport>' + inttostr(rSubmit.NeedReport) + '</NeedReport>'; // 是否要求返回状态报告
  Result := Result + '<Priority>' + inttostr(rSubmit.Priority) + '</Priority>'; // 发送优先级
  Result := Result + '<ServiceID>' + rSubmit.ServiceID + '</ServiceID>'; // 业务类型
  Result := Result + '<FeeType>' + rSubmit.FeeType + '</FeeType>'; // 收费类型
  Result := Result + '<FeeCode>' + rSubmit.FeeCode + '</FeeCode>'; //  资费代码（单位为分）
  Result := Result + '<FeeUserType>' + IntToStr(rSubmit.FeeUserType) + '</FeeUserType>';
  Result := Result + '<FeeTermID>' + rSubmit.ChargeTermID + '</FeeTermID>'; //  计费用户号码
  Result := Result + '<FeeTermType>0</FeeTermType>';
  Result := Result + '<TpPid>1</TpPid>';
	Result := Result + '<TpUdhi>1</TpUdhi>';
  Result := Result + '<MsgFormat>' + inttostr(rSubmit.MsgFormat) + '</MsgFormat>'; // 短消息格式
  Result := Result + '<SrcTermID>' + rSubmit.SrcTermID + '</SrcTermID>'; // 短消息发送用户号码
  Result := Result + '<FixedFee>0</FixedFee>';   //与联通得GivenValue共用
  Result := Result + '<MorelatetoMTFlag>0</MorelatetoMTFlag>';   //联通
  Result := Result + '<AgentFlag>1</AgentFlag>'; 
  Result := Result + '<ValidTime>' + rSubmit.ValidTime + '</ValidTime>'; // 有效时间
  Result := Result + '<AtTime>' + rSubmit.AtTime + '</AtTime>'; // 定时发送时间
  Result := Result + '<DestTermIDCount>' + IntToStr(rSubmit.DestTermIDCount) + '</DestTermIDCount>'; //  短消息接收号码总数
  Result := Result + '<DestTermID>' + rSubmit.DestTermID + '</DestTermID>'; //  短消息接收号码
  Result := Result + '<DestTermType>0</DestTermType>';
  //Result := Result + '<MsgLength>' + inttostr(rSubmit.MsgLength) + '</MsgLength>'; // 短消息长度
  Result := Result + '<MsgContent>' + EncodeBase64(rSubmit.MsgContent) + '</MsgContent>'; // 短消息内容
  Result := Result + '<LinkID></LinkID>'; // 保留
  Result := Result +'</Submit>';
end;

function writeXmlReport(const xReport: TReport): string;
begin
  Result := '';
  Result := '<?xml version="1.0" encoding="UTF-8"?>';
  Result := Result + '<Report>';
  Result := Result + '<GateID>' + GateID + '</GateID>';
  Result := Result + '<MsgID>' + xReport.id + '</MsgID>';
  Result := Result + '<Sub>' + xReport.sub + '</Sub>';
  Result := Result + '<Dlvrd>' + xReport.dlvrd + '</Dlvrd>';
  Result := Result + '<SubmitTime>' + xReport.Submit_date + '</SubmitTime>';
  Result := Result + '<DoneTime>' + xReport.done_date + '</DoneTime>';
  Result := Result + '<Stat>' + xReport.Stat + '</Stat>';
  Result := Result + '<Err>' + xReport.Err + '</Err>';
  Result := Result + '<Txt>' + EncodeBase64( xReport.Txt )+ '</Txt>';
  Result := Result + '<DestTermID></DestTermID>';
  Result := Result + '<SMSCSeq></SMSCSeq>'; 
  Result := Result + '</Report>';
end;
end.

